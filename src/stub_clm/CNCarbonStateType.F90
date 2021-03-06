module CNCarbonStateType
  use clm_varcon     , only : spval, ispval, c14ratio
  use shr_kind_mod       , only : r8 => shr_kind_r8
  use decompMod      , only : bounds_type
  use clm_varpar             , only : nlevdecomp_full, ndecomp_pools
implicit none

  type, public :: carbonstate_type
    real(r8), pointer :: decomp_cpools_vr_col    (:,:,:) => null() ! col (gC/m3) vertically-resolved decomposing (litter, cwd, soil) c pools
    real(r8), pointer :: frootc_patch             (:)    => null() ! (gC/m2) fine root C
    real(r8), pointer :: totlitc_1m_col          (:) => null()
    real(r8), pointer :: totlitc_col             (:) => null()
    real(r8), pointer :: totsomc_col             (:) => null()
    real(r8), pointer :: cwdc_col                (:) => null()
    real(r8), pointer :: totsomc_1m_col          (:) => null()
    real(r8), pointer :: decomp_som2c_vr_col     (:,:)=> null()
    real(r8), pointer :: som1c_col               (:) => null()
    real(r8), pointer :: som2c_col               (:) => null()
    real(r8), pointer :: som3c_col               (:) => null()
    real(r8), pointer :: domc_col               (:) => null()
  contains

    procedure, public  :: Init
    procedure, private :: InitCold
    procedure, private :: InitAllocate
  end type carbonstate_type

contains

  !------------------------------------------------------------------------
  subroutine Init(this, bounds)

    class(carbonstate_type) :: this
    type(bounds_type), intent(in) :: bounds

    call this%InitAllocate ( bounds )

    call this%InitCold ( bounds )

  end subroutine Init
  !------------------------------------------------------------------------
  subroutine InitAllocate(this, bounds)
    !
    ! !DESCRIPTION:
    ! Initialize module data structure
    !
    ! !USES:
    use shr_infnan_mod , only : nan => shr_infnan_nan, assignment(=)
    !
    ! !ARGUMENTS:
    class(carbonstate_type) :: this
    type(bounds_type), intent(in) :: bounds
    !
    ! !LOCAL VARIABLES:
    integer :: begp, endp
    integer :: begc, endc
    !------------------------------------------------------------------------

    begp = bounds%begp; endp= bounds%endp
    begc = bounds%begc; endc= bounds%endc
    allocate(this%decomp_cpools_vr_col(begc:endc,1:nlevdecomp_full,1:ndecomp_pools)); this%decomp_cpools_vr_col(:,:,:)= spval
    allocate(this%frootc_patch             (begp :endp))                   ;     this%frootc_patch             (:)   = spval
    allocate(this%cwdc_col(begc:endc)); this%cwdc_col(:) = spval
    allocate(this%totlitc_col(begc:endc)); this%totlitc_col(:) = spval
    allocate(this%totsomc_col(begc:endc)); this%totsomc_col(:) = spval
    allocate(this%totlitc_1m_col(begc:endc)); this%totlitc_1m_col(:) = spval
    allocate(this%totsomc_1m_col(begc:endc)); this%totsomc_1m_col(:) = spval
    allocate(this%som1c_col(begc:endc)); this%som1c_col(:) = spval
    allocate(this%som2c_col(begc:endc)); this%som2c_col(:) = spval
    allocate(this%som3c_col(begc:endc)); this%som3c_col(:) = spval
    allocate(this%domc_col(begc:endc)); this%domc_col(:) = spval
  end subroutine InitAllocate

  !-----------------------------------------------------------------------
  subroutine initCold(this, bounds)
    !
    ! !USES:
    use spmdMod    , only : masterproc
    use fileutils  , only : getfil
    use clm_varctl , only : nsrest, nsrStartup
    use ncdio_pio
    !
    ! !ARGUMENTS:
    class(carbonstate_type) :: this
    type(bounds_type), intent(in) :: bounds
    !
    ! !LOCAL VARIABLES:
    integer               :: g,l,c,p,n,j,m            ! indices
    real(r8) ,pointer     :: gdp (:)                  ! global gdp data (needs to be a pointer for use in ncdio)
    real(r8) ,pointer     :: peatf (:)                ! global peatf data (needs to be a pointer for use in ncdio)
    integer  ,pointer     :: soilorder_rdin (:)       ! global soil order data (needs to be a pointer for use in ncdio)
    integer  ,pointer     :: abm (:)                  ! global abm data (needs to be a pointer for use in ncdio)
    real(r8) ,pointer     :: gti (:)                  ! read in - fmax (needs to be a pointer for use in ncdio)
    integer               :: dimid                    ! dimension id
    integer               :: ier                      ! error status
    type(file_desc_t)     :: ncid                     ! netcdf id
    logical               :: readvar
    character(len=256)    :: locfn                    ! local filename
    integer               :: begc, endc
    integer               :: begg, endg




  end subroutine initCold

end module CNCarbonStateType
