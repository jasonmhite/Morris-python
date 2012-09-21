!The original statement of the Morris problem makes it kind of tedious to
!implement nicely with NumPy, so this Fortran module is meant to be called.
!
!Compile with F2py
! Build signature specification:
!    f2py -m morris_test -h morris.pyf morris.f95 --overwrite-signature
! Compile:
!    f2py -c morris.pyf morris.f95
!
!Note that morris.py provides some bookkeeping code to make this easier to 
!call, use the morris() function in that instead of this directly.
!If you call this directly, you have to initialize the coefficient arrays.

function morris(x, b0, b1, b2, b3, b4)
    implicit none
    real(8), intent(in) :: b0
    real(8), dimension(20), intent(in) :: x, b1
    real(8), dimension(20) :: w
    real(8), dimension(20, 20), intent(in) :: b2
    real(8), dimension(20, 20, 20), intent(in) :: b3
    real(8), dimension(20, 20, 20, 20), intent(in) :: b4
    real(8) :: morris
    real(8) :: y1, y2, y3, y4
    integer :: i, j, k, l

    do i = 1, 20
        if (i==3 .OR. i==5 .OR. i==7) then
            w(i) = ((2.2 * x(i)) / (x(i) + .1)) - 1.
        else
            w(i) = 2. * x(i) - 1.
        end if
    end do

    y1 = 0.
    y2 = 0.
    y3 = 0.
    y4 = 0.
    
    do i = 1, 20
        y1 = y1 + b1(i) * w(i)
    end do

    do i = 1, 20
        do j = 1, 20
            if (i < j) then
                y2 = y2 + b2(i, j) * w(i) * w(j)
            end if
        end do
    end do

    do i = 1, 20
        do j = 1, 20
            do k = 1, 20
                if (i < j .AND. j < k) then
                    y3 = y3 + b3(i, j, k) * w(i) * w(j) * w(k)
                end if
            end do
        end do
    end do

    do i = 1, 20
        do j = 1, 20
            do k = 1, 20
                do l = 1, 20
                    if (i < j .AND. j < k .AND. k < l) then
                        y4 = y4 + b4(i, j, k, l) * w(i) * w(j) * w(k) * w(l)
                    end if
                end do
            end do
        end do
    end do


    morris = b0 + y1 + y2 + y3 + y4
end function morris

