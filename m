Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21A1CE7AFE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWPz-0006hp-MV; Fri, 06 Sep 2024 06:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smWPx-0006gW-Kz
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smWPs-0004UN-RO
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725619330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOB1qi72CiNVBxNfyABVl9VxIYh3E4/0bicJbDCMjnU=;
 b=NZ6uW590K8kw54Q2/tNG3OWxV9+Ze8Y+zk44MmvftasxB6Or3qt6CJPG6iytIfW9xELLXY
 TTLErHp/3pfi+O4GWdXLEk9h4EQ43kYuNEJVEzyDpdyOHMOkrCS8Hbvm2EHlxkhLDooHTg
 fhp44rXdkyyAlwtx1Bk2XJXO44nKQMk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-hJ_SddubMYejnn6FFwH5Dg-1; Fri, 06 Sep 2024 06:42:06 -0400
X-MC-Unique: hJ_SddubMYejnn6FFwH5Dg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7d2159ebf3dso2749146a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725619325; x=1726224125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOB1qi72CiNVBxNfyABVl9VxIYh3E4/0bicJbDCMjnU=;
 b=b4r0Js759qB9WMfeUXMkbl/2LxCMe6hRbBKHWxmGydmGxADCZ2cZYJWoWsl9NOV+5m
 EoMKPzzmz4cBrsJJO1Uj0Xmgviz0sPqIy+282F2+U6Zp4Yxga6CEbpGvC0jhwfqpDbhS
 uFI9mqyVYDfm5PE90CnE9OEq7Et2pSN8/+h694UqscWH7+9cFlqENu6+rEIOUfIBoZcI
 wqUXelxQV412iUkK6LRcjzQMCAqhA8zxFi/+oRAJZZ/CfGYkexOXXpLwXgIMTExs1get
 ZGSWdJ5B2AEcemoDKz3ACdBxuJi/OO10q5eL/1YHDcNZP3U79WjqlqgUi+k8zQhFU/jN
 iTrQ==
X-Gm-Message-State: AOJu0YwkiZS8+/NHbMThSdIl1NQ2Q1iqgOFXLBRRbKdZod5zp07kG0IT
 XNUkKlXhgRIj+RFWeotYYdzsNgUaCqA2Zw7XjjdoMZnRccZJ3V4g4YwF95hSuW/pX9tJObD9yaI
 FHlNlmDSCPfPhlTIljkyVstHlG0Nar0ns28FDHgDwR0bfS6HCtYCMJp4NA7nLTYqrhwBLfqhlQh
 /9XSVY1ljIi/pLbBaFRPhiH6VlzEQ=
X-Received: by 2002:a05:6a20:cd92:b0:1ce:f588:28b0 with SMTP id
 adf61e73a8af0-1cf1d165620mr2068298637.13.1725619324863; 
 Fri, 06 Sep 2024 03:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEFCEMO59zl/Tk6CuyCnKqdSDckzrqemPsWFnFoxmBqvAsbf/irQOPxghgbOb/H+Oi+8xaaH6j2QDtWdjPLi8=
X-Received: by 2002:a05:6a20:cd92:b0:1ce:f588:28b0 with SMTP id
 adf61e73a8af0-1cf1d165620mr2068246637.13.1725619323998; Fri, 06 Sep 2024
 03:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-9-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-9-35579191f17c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Sep 2024 12:41:49 +0200
Message-ID: <CABgObfaetW_G7JL0Eo-LrOEEdMhaZMtNhYGuEwtJbazcsjg96g@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 9/9] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> +impl PL011State {
> +    pub fn init(&mut self) {
> +        let dev =3D addr_of_mut!(*self).cast::<DeviceState>();

One small thing that I forgot about, is that the init function should be un=
safe.

For a short term change after this is merged, this should take not a
&mut self, but a "obj: &mut MaybeUninit<Self>".

It needs a utility macro like

fn uninit_field_mut<'a, U>(dest: *mut U) -> &'a mut MaybeUninit<U> {
    unsafe { &mut *(dest.cast()) }
}

macro_rules! uninit_field_mut {
    ($container:expr, $field:ident) =3D> {
        $crate::uninit_field_mut(unsafe {
             std::ptr::addr_of_mut!((&mut *$container.as_mut_ptr()).$field)
        })
    }
}

and initialization code like

    p_clock =3D uninit_field_mut!(self, clock);
    p_clock.write(NonNull::new(...));

and it's clearly less pretty; but it avoids comments like

    // self.clock is not initialized at this point; but since
`NonNull<_>` is Copy,
    // we can overwrite the undefined value without side effects.

and it is safer because MaybeUninit<> prevents calling other functions
of PL011State too early.

It would be nice to just add a TODO here, but it's not necessary.

Paolo

On Wed, Aug 28, 2024 at 6:12=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> This commit adds a re-implementation of hw/char/pl011.c in Rust.
>
> How to build:
>
> 1. Configure a QEMU build with:
>    --enable-system --target-list=3Daarch64-softmmu --enable-rust
> 2. Launching a VM with qemu-system-aarch64 should use the Rust version
>    of the pl011 device
>
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS                                        |   5 +
>  meson.build                                        |  24 +
>  hw/arm/Kconfig                                     |  33 +-
>  rust/Kconfig                                       |   1 +
>  rust/hw/Kconfig                                    |   2 +
>  rust/hw/char/Kconfig                               |   3 +
>  rust/hw/char/meson.build                           |   1 +
>  rust/hw/char/pl011/.gitignore                      |   2 +
>  rust/hw/char/pl011/Cargo.lock                      | 134 +++++
>  rust/hw/char/pl011/Cargo.toml                      |  26 +
>  rust/hw/char/pl011/README.md                       |  31 ++
>  rust/hw/char/pl011/meson.build                     |  26 +
>  rust/hw/char/pl011/src/definitions.rs              |  20 +
>  rust/hw/char/pl011/src/device.rs                   | 594 +++++++++++++++=
++++++
>  rust/hw/char/pl011/src/device_class.rs             |  59 ++
>  rust/hw/char/pl011/src/lib.rs                      | 585 +++++++++++++++=
+++++
>  rust/hw/char/pl011/src/memory_ops.rs               |  57 ++
>  rust/hw/meson.build                                |   1 +
>  rust/meson.build                                   |   2 +
>  scripts/archive-source.sh                          |   5 +-
>  scripts/make-release                               |   5 +-
>  scripts/rust/rust_root_crate.sh                    |  13 +
>  subprojects/.gitignore                             |  11 +
>  subprojects/arbitrary-int-1-rs.wrap                |   7 +
>  subprojects/bilge-0.2-rs.wrap                      |   7 +
>  subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
>  subprojects/either-1-rs.wrap                       |   7 +
>  subprojects/itertools-0.11-rs.wrap                 |   7 +
>  .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
>  subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
>  .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
>  subprojects/packagefiles/either-1-rs/meson.build   |  24 +
>  .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
>  .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
>  .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
>  .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
>  subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
>  subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
>  .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
>  subprojects/proc-macro-error-1-rs.wrap             |   7 +
>  subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
>  subprojects/proc-macro2-1-rs.wrap                  |   7 +
>  subprojects/quote-1-rs.wrap                        |   7 +
>  subprojects/syn-2-rs.wrap                          |   7 +
>  subprojects/unicode-ident-1-rs.wrap                |   7 +
>  45 files changed, 2043 insertions(+), 13 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 727f3a7a2cfe600ffdb861bafada7db415d020e5..cb65018b4bf3958952ecd7c8d=
703abee838cc265 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1189,6 +1189,11 @@ F: include/hw/*/microbit*.h
>  F: tests/qtest/microbit-test.c
>  F: docs/system/arm/nrf.rst
>
> +ARM PL011 Rust device
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Maintained
> +F: rust/hw/char/pl011/
> +
>  AVR Machines
>  -------------
>
> diff --git a/meson.build b/meson.build
> index 7f05466d128776ad8dbf403179734e6831b023c0..a4249fc24f77526b14a2fc570=
498d5ea34f48bbe 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3489,6 +3489,7 @@ qom_ss =3D ss.source_set()
>  system_ss =3D ss.source_set()
>  specific_fuzz_ss =3D ss.source_set()
>  specific_ss =3D ss.source_set()
> +rust_devices_ss =3D ss.source_set()
>  stub_ss =3D ss.source_set()
>  trace_ss =3D ss.source_set()
>  user_ss =3D ss.source_set()
> @@ -4002,6 +4003,29 @@ foreach target : target_dirs
>    arch_srcs +=3D target_specific.sources()
>    arch_deps +=3D target_specific.dependencies()
>
> +  if have_rust and have_system
> +    target_rust =3D rust_devices_ss.apply(config_target, strict: false)
> +    crates =3D []
> +    foreach dep : target_rust.dependencies()
> +      crates +=3D dep.get_variable('crate')
> +    endforeach
> +    if crates.length() > 0
> +      rlib_rs =3D custom_target('rust_' + target.underscorify() + '.rs',
> +                              output: 'rust_' + target.underscorify() + =
'.rs',
> +                              command: [find_program('scripts/rust/rust_=
root_crate.sh')] + crates,
> +                              capture: true,
> +                              build_by_default: true,
> +                              build_always_stale: true)
> +      rlib =3D static_library('rust_' + target.underscorify(),
> +                            rlib_rs,
> +                            dependencies: target_rust.dependencies(),
> +                            override_options: ['rust_std=3D2021', 'build=
.rust_std=3D2021'],
> +                            rust_args: rustc_config_args,
> +                            rust_abi: 'c')
> +      arch_deps +=3D declare_dependency(link_whole: [rlib])
> +    endif
> +  endif
> +
>    # allow using headers from the dependencies but do not include the sou=
rces,
>    # because this emulator only needs those in "objects".  For external
>    # dependencies, the full dependency is included below in the executabl=
e.
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1ad60da7aa2d1fcb157561461c229cb486b65e3a..45438c1bc4b842f6d28005c7e=
fa0a3ac32272d37 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -20,7 +20,8 @@ config ARM_VIRT
>      select PCI_EXPRESS
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select PFLASH_CFI01
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL031 # RTC
>      select PL061 # GPIO
>      select GPIO_PWR
> @@ -80,7 +81,8 @@ config HIGHBANK
>      select AHCI
>      select ARM_TIMER # sp804
>      select ARM_V7M
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL022 # SPI
>      select PL031 # RTC
>      select PL061 # GPIO
> @@ -93,7 +95,8 @@ config INTEGRATOR
>      depends on TCG && ARM
>      select ARM_TIMER
>      select INTEGRATOR_DEBUG
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL031 # RTC
>      select PL041 # audio
>      select PL050 # keyboard/mouse
> @@ -119,7 +122,8 @@ config MUSCA
>      default y
>      depends on TCG && ARM
>      select ARMSSE
> -    select PL011
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL031
>      select SPLIT_IRQ
>      select UNIMP
> @@ -228,7 +232,8 @@ config Z2
>      depends on TCG && ARM
>      select PFLASH_CFI01
>      select WM8750
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PXA2XX
>
>  config REALVIEW
> @@ -248,7 +253,8 @@ config REALVIEW
>      select WM8750 # audio codec
>      select LSI_SCSI_PCI
>      select PCI
> -    select PL011  # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL031  # RTC
>      select PL041  # audio codec
>      select PL050  # keyboard/mouse
> @@ -273,7 +279,8 @@ config SBSA_REF
>      select PCI_EXPRESS
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select PFLASH_CFI01
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL031 # RTC
>      select PL061 # GPIO
>      select USB_XHCI_SYSBUS
> @@ -297,7 +304,8 @@ config STELLARIS
>      select ARM_V7M
>      select CMSDK_APB_WATCHDOG
>      select I2C
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL022 # SPI
>      select PL061 # GPIO
>      select SSD0303 # OLED display
> @@ -356,7 +364,8 @@ config VEXPRESS
>      select ARM_TIMER # sp804
>      select LAN9118
>      select PFLASH_CFI01
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL041 # audio codec
>      select PL181  # display
>      select REALVIEW
> @@ -440,7 +449,8 @@ config RASPI
>      default y
>      depends on TCG && ARM
>      select FRAMEBUFFER
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select SDHCI
>      select USB_DWC2
>      select BCM2835_SPI
> @@ -515,7 +525,8 @@ config XLNX_VERSAL
>      select ARM_GIC
>      select CPU_CLUSTER
>      select DEVICE_TREE
> -    select PL011
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select CADENCE
>      select VIRTIO_MMIO
>      select UNIMP
> diff --git a/rust/Kconfig b/rust/Kconfig
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..f9f5c3909887451f71360a798=
6d79e57fdb43c91 100644
> --- a/rust/Kconfig
> +++ b/rust/Kconfig
> @@ -0,0 +1 @@
> +source hw/Kconfig
> diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..4d934f30afe13ddff418db8ec=
9e8b8eb25a9e8d0
> --- /dev/null
> +++ b/rust/hw/Kconfig
> @@ -0,0 +1,2 @@
> +# devices Kconfig
> +source char/Kconfig
> diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..a1732a9e97fe3211547e30bc9=
319382e6394ed5b
> --- /dev/null
> +++ b/rust/hw/char/Kconfig
> @@ -0,0 +1,3 @@
> +config X_PL011_RUST
> +    bool
> +    default y if HAVE_RUST
> diff --git a/rust/hw/char/meson.build b/rust/hw/char/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..5716dc43ef6facdcf1cc96310=
8347bbf4d12cf0e
> --- /dev/null
> +++ b/rust/hw/char/meson.build
> @@ -0,0 +1 @@
> +subdir('pl011')
> diff --git a/rust/hw/char/pl011/.gitignore b/rust/hw/char/pl011/.gitignor=
e
> new file mode 100644
> index 0000000000000000000000000000000000000000..71eaff2035d5a65b57ae32dfe=
ecf3d87bbc7b396
> --- /dev/null
> +++ b/rust/hw/char/pl011/.gitignore
> @@ -0,0 +1,2 @@
> +# Ignore generated bindings file overrides.
> +src/bindings.rs.inc
> diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.loc=
k
> new file mode 100644
> index 0000000000000000000000000000000000000000..b58cebb186e99efe184117bb9=
31a341543d4466b
> --- /dev/null
> +++ b/rust/hw/char/pl011/Cargo.lock
> @@ -0,0 +1,134 @@
> +# This file is automatically @generated by Cargo.
> +# It is not intended for manual editing.
> +version =3D 3
> +
> +[[package]]
> +name =3D "arbitrary-int"
> +version =3D "1.2.7"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b=
1df46d"
> +
> +[[package]]
> +name =3D "bilge"
> +version =3D "0.2.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512=
e67b57"
> +dependencies =3D [
> + "arbitrary-int",
> + "bilge-impl",
> +]
> +
> +[[package]]
> +name =3D "bilge-impl"
> +version =3D "0.2.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000=
adb2d8"
> +dependencies =3D [
> + "itertools",
> + "proc-macro-error",
> + "proc-macro2",
> + "quote",
> + "syn",
> +]
> +
> +[[package]]
> +name =3D "either"
> +version =3D "1.12.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb233=
85b58b"
> +
> +[[package]]
> +name =3D "itertools"
> +version =3D "0.11.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418=
c3fe57"
> +dependencies =3D [
> + "either",
> +]
> +
> +[[package]]
> +name =3D "pl011"
> +version =3D "0.1.0"
> +dependencies =3D [
> + "bilge",
> + "bilge-impl",
> + "qemu_api",
> + "qemu_api_macros",
> +]
> +
> +[[package]]
> +name =3D "proc-macro-error"
> +version =3D "1.0.4"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a=
5ce38c"
> +dependencies =3D [
> + "proc-macro-error-attr",
> + "proc-macro2",
> + "quote",
> + "version_check",
> +]
> +
> +[[package]]
> +name =3D "proc-macro-error-attr"
> +version =3D "1.0.4"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b=
35f869"
> +dependencies =3D [
> + "proc-macro2",
> + "quote",
> + "version_check",
> +]
> +
> +[[package]]
> +name =3D "proc-macro2"
> +version =3D "1.0.84"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc1202=
4a49d6"
> +dependencies =3D [
> + "unicode-ident",
> +]
> +
> +[[package]]
> +name =3D "qemu_api"
> +version =3D "0.1.0"
> +
> +[[package]]
> +name =3D "qemu_api_macros"
> +version =3D "0.1.0"
> +dependencies =3D [
> + "proc-macro2",
> + "quote",
> + "syn",
> +]
> +
> +[[package]]
> +name =3D "quote"
> +version =3D "1.0.36"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208=
acaca7"
> +dependencies =3D [
> + "proc-macro2",
> +]
> +
> +[[package]]
> +name =3D "syn"
> +version =3D "2.0.66"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3=
cdcff5"
> +dependencies =3D [
> + "proc-macro2",
> + "quote",
> + "unicode-ident",
> +]
> +
> +[[package]]
> +name =3D "unicode-ident"
> +version =3D "1.0.12"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec=
0fee4b"
> +
> +[[package]]
> +name =3D "version_check"
> +version =3D "0.9.4"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda78=
7e483f"
> diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.tom=
l
> new file mode 100644
> index 0000000000000000000000000000000000000000..b089e3dded623131ee13b4af8=
145b84388755df7
> --- /dev/null
> +++ b/rust/hw/char/pl011/Cargo.toml
> @@ -0,0 +1,26 @@
> +[package]
> +name =3D "pl011"
> +version =3D "0.1.0"
> +edition =3D "2021"
> +authors =3D ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
> +license =3D "GPL-2.0-or-later"
> +readme =3D "README.md"
> +homepage =3D "https://www.qemu.org"
> +description =3D "pl011 device model for QEMU"
> +repository =3D "https://gitlab.com/epilys/rust-for-qemu"
> +resolver =3D "2"
> +publish =3D false
> +keywords =3D []
> +categories =3D []
> +
> +[lib]
> +crate-type =3D ["staticlib"]
> +
> +[dependencies]
> +bilge =3D { version =3D "0.2.0" }
> +bilge-impl =3D { version =3D "0.2.0" }
> +qemu_api =3D { path =3D "../../../qemu-api" }
> +qemu_api_macros =3D { path =3D "../../../qemu-api-macros" }
> +
> +# Do not include in any global workspace
> +[workspace]
> diff --git a/rust/hw/char/pl011/README.md b/rust/hw/char/pl011/README.md
> new file mode 100644
> index 0000000000000000000000000000000000000000..cd7dea31634241cbf96b0be13=
f21d52bbd8ae750
> --- /dev/null
> +++ b/rust/hw/char/pl011/README.md
> @@ -0,0 +1,31 @@
> +# PL011 QEMU Device Model
> +
> +This library implements a device model for the PrimeCell=C2=AE UART (PL0=
11)
> +device in QEMU.
> +
> +## Build static lib
> +
> +Host build target must be explicitly specified:
> +
> +```sh
> +cargo build --target x86_64-unknown-linux-gnu
> +```
> +
> +Replace host target triplet if necessary.
> +
> +## Generate Rust documentation
> +
> +To generate docs for this crate, including private items:
> +
> +```sh
> +cargo doc --no-deps --document-private-items --target x86_64-unknown-lin=
ux-gnu
> +```
> +
> +To include direct dependencies like `bilge` (bitmaps for register types)=
:
> +
> +```sh
> +cargo tree --depth 1 -e normal --prefix none \
> + | cut -d' ' -f1 \
> + | xargs printf -- '-p %s\n' \
> + | xargs cargo doc --no-deps --document-private-items --target x86_64-un=
known-linux-gnu
> +```
> diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.bu=
ild
> new file mode 100644
> index 0000000000000000000000000000000000000000..547cca5a96f7eef284caf1949=
380b65f7d015d92
> --- /dev/null
> +++ b/rust/hw/char/pl011/meson.build
> @@ -0,0 +1,26 @@
> +subproject('bilge-0.2-rs', required: true)
> +subproject('bilge-impl-0.2-rs', required: true)
> +
> +bilge_dep =3D dependency('bilge-0.2-rs')
> +bilge_impl_dep =3D dependency('bilge-impl-0.2-rs')
> +
> +_libpl011_rs =3D static_library(
> +  'pl011',
> +  files('src/lib.rs'),
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi: 'rust',
> +  dependencies: [
> +    bilge_dep,
> +    bilge_impl_dep,
> +    qemu_api,
> +    qemu_api_macros,
> +  ],
> +)
> +
> +rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_depen=
dency(
> +  link_whole: [_libpl011_rs],
> +  # Putting proc macro crates in `dependencies` is necessary for Meson t=
o find
> +  # them when compiling the root per-target static rust lib.
> +  dependencies: [bilge_impl_dep, qemu_api_macros],
> +  variables: {'crate': 'pl011'},
> +)])
> diff --git a/rust/hw/char/pl011/src/definitions.rs b/rust/hw/char/pl011/s=
rc/definitions.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..baafe1d3908e695a895c3f8ef=
4cae3e390654f1f
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/definitions.rs
> @@ -0,0 +1,20 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Definitions required by QEMU when registering the device.
> +
> +use core::mem::MaybeUninit;
> +
> +use qemu_api::{bindings::*, definitions::ObjectImpl};
> +
> +use crate::device::PL011State;
> +
> +pub const TYPE_PL011: &std::ffi::CStr =3D c"pl011";
> +
> +#[used]
> +pub static VMSTATE_PL011: VMStateDescription =3D VMStateDescription {
> +    name: PL011State::TYPE_INFO.name,
> +    unmigratable: true,
> +    ..unsafe { MaybeUninit::<VMStateDescription>::zeroed().assume_init()=
 }
> +};
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/de=
vice.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..07cf2fa4e1f3985b24a25e7cf=
86223bf699cf022
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -0,0 +1,594 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use core::{
> +    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
> +    ptr::{addr_of, addr_of_mut, NonNull},
> +};
> +
> +use qemu_api::{
> +    bindings::{self, *},
> +    definitions::ObjectImpl,
> +};
> +
> +use crate::{
> +    memory_ops::PL011_OPS,
> +    registers::{self, Interrupt},
> +    RegisterOffset,
> +};
> +
> +static PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf=
0, 0x05, 0xb1];
> +
> +const DATA_BREAK: u32 =3D 1 << 10;
> +
> +/// QEMU sourced constant.
> +pub const PL011_FIFO_DEPTH: usize =3D 16_usize;
> +
> +#[repr(C)]
> +#[derive(Debug, qemu_api_macros::Object)]
> +/// PL011 Device Model in QEMU
> +pub struct PL011State {
> +    pub parent_obj: SysBusDevice,
> +    pub iomem: MemoryRegion,
> +    pub readbuff: u32,
> +    #[doc(alias =3D "fr")]
> +    pub flags: registers::Flags,
> +    #[doc(alias =3D "lcr")]
> +    pub line_control: registers::LineControl,
> +    #[doc(alias =3D "rsr")]
> +    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
> +    #[doc(alias =3D "cr")]
> +    pub control: registers::Control,
> +    pub dmacr: u32,
> +    pub int_enabled: u32,
> +    pub int_level: u32,
> +    pub read_fifo: [u32; PL011_FIFO_DEPTH],
> +    pub ilpr: u32,
> +    pub ibrd: u32,
> +    pub fbrd: u32,
> +    pub ifl: u32,
> +    pub read_pos: usize,
> +    pub read_count: usize,
> +    pub read_trigger: usize,
> +    #[doc(alias =3D "chr")]
> +    pub char_backend: CharBackend,
> +    /// QEMU interrupts
> +    ///
> +    /// ```text
> +    ///  * sysbus MMIO region 0: device registers
> +    ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
> +    ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
> +    ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
> +    ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
> +    ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
> +    ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
> +    /// ```
> +    #[doc(alias =3D "irq")]
> +    pub interrupts: [qemu_irq; 6usize],
> +    #[doc(alias =3D "clk")]
> +    pub clock: NonNull<Clock>,
> +    #[doc(alias =3D "migrate_clk")]
> +    pub migrate_clock: bool,
> +}
> +
> +impl ObjectImpl for PL011State {
> +    type Class =3D PL011Class;
> +    const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type_inf=
o! { Self };
> +    const TYPE_NAME: &'static CStr =3D c"pl011";
> +    const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(TYPE_SYS_BUS_=
DEVICE);
> +    const ABSTRACT: bool =3D false;
> +    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> =
=3D Some(pl011_init);
> +    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Obje=
ct)> =3D None;
> +    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Objec=
t)> =3D None;
> +}
> +
> +#[repr(C)]
> +pub struct PL011Class {
> +    _inner: [u8; 0],
> +}
> +
> +impl qemu_api::definitions::Class for PL011Class {
> +    const CLASS_INIT: Option<
> +        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::f=
fi::c_void),
> +    > =3D Some(crate::device_class::pl011_class_init);
> +    const CLASS_BASE_INIT: Option<
> +        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::f=
fi::c_void),
> +    > =3D None;
> +}
> +
> +#[used]
> +pub static CLK_NAME: &CStr =3D c"clk";
> +
> +impl PL011State {
> +    pub fn init(&mut self) {
> +        let dev =3D addr_of_mut!(*self).cast::<DeviceState>();
> +        // SAFETY:
> +        //
> +        // self and self.iomem are guaranteed to be valid at this point =
since callers
> +        // must make sure the `self` reference is valid.
> +        unsafe {
> +            memory_region_init_io(
> +                addr_of_mut!(self.iomem),
> +                addr_of_mut!(*self).cast::<Object>(),
> +                &PL011_OPS,
> +                addr_of_mut!(*self).cast::<c_void>(),
> +                Self::TYPE_INFO.name,
> +                0x1000,
> +            );
> +            let sbd =3D addr_of_mut!(*self).cast::<SysBusDevice>();
> +            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
> +            for irq in self.interrupts.iter_mut() {
> +                sysbus_init_irq(sbd, irq);
> +            }
> +        }
> +        // SAFETY:
> +        //
> +        // self.clock is not initialized at this point; but since `NonNu=
ll<_>` is Copy,
> +        // we can overwrite the undefined value without side effects. Th=
is is
> +        // safe since all PL011State instances are created by QOM code w=
hich
> +        // calls this function to initialize the fields; therefore no co=
de is
> +        // able to access an invalid self.clock value.
> +        unsafe {
> +            self.clock =3D NonNull::new(qdev_init_clock_in(
> +                dev,
> +                CLK_NAME.as_ptr(),
> +                None, /* pl011_clock_update */
> +                addr_of_mut!(*self).cast::<c_void>(),
> +                ClockEvent_ClockUpdate,
> +            ))
> +            .unwrap();
> +        }
> +    }
> +
> +    pub fn read(
> +        &mut self,
> +        offset: hwaddr,
> +        _size: core::ffi::c_uint,
> +    ) -> std::ops::ControlFlow<u64, u64> {
> +        use RegisterOffset::*;
> +
> +        std::ops::ControlFlow::Break(match RegisterOffset::try_from(offs=
et) {
> +            Err(v) if (0x3f8..0x400).contains(&v) =3D> {
> +                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize]=
)
> +            }
> +            Err(_) =3D> {
> +                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offse=
t 0x%x\n", (int)offset);
> +                0
> +            }
> +            Ok(DR) =3D> {
> +                // s->flags &=3D ~PL011_FLAG_RXFF;
> +                self.flags.set_receive_fifo_full(false);
> +                let c =3D self.read_fifo[self.read_pos];
> +                if self.read_count > 0 {
> +                    self.read_count -=3D 1;
> +                    self.read_pos =3D (self.read_pos + 1) & (self.fifo_d=
epth() - 1);
> +                }
> +                if self.read_count =3D=3D 0 {
> +                    // self.flags |=3D PL011_FLAG_RXFE;
> +                    self.flags.set_receive_fifo_empty(true);
> +                }
> +                if self.read_count + 1 =3D=3D self.read_trigger {
> +                    //self.int_level &=3D ~ INT_RX;
> +                    self.int_level &=3D !registers::INT_RX;
> +                }
> +                // Update error bits.
> +                self.receive_status_error_clear =3D c.to_be_bytes()[3].i=
nto();
> +                self.update();
> +                // Must call qemu_chr_fe_accept_input, so return Continu=
e:
> +                return std::ops::ControlFlow::Continue(c.into());
> +            }
> +            Ok(RSR) =3D> u8::from(self.receive_status_error_clear).into(=
),
> +            Ok(FR) =3D> u16::from(self.flags).into(),
> +            Ok(FBRD) =3D> self.fbrd.into(),
> +            Ok(ILPR) =3D> self.ilpr.into(),
> +            Ok(IBRD) =3D> self.ibrd.into(),
> +            Ok(LCR_H) =3D> u16::from(self.line_control).into(),
> +            Ok(CR) =3D> {
> +                // We exercise our self-control.
> +                u16::from(self.control).into()
> +            }
> +            Ok(FLS) =3D> self.ifl.into(),
> +            Ok(IMSC) =3D> self.int_enabled.into(),
> +            Ok(RIS) =3D> self.int_level.into(),
> +            Ok(MIS) =3D> u64::from(self.int_level & self.int_enabled),
> +            Ok(ICR) =3D> {
> +                // "The UARTICR Register is the interrupt clear register=
 and is write-only"
> +                // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register=
, UARTICR
> +                0
> +            }
> +            Ok(DMACR) =3D> self.dmacr.into(),
> +        })
> +    }
> +
> +    pub fn write(&mut self, offset: hwaddr, value: u64) {
> +        // eprintln!("write offset {offset} value {value}");
> +        use RegisterOffset::*;
> +        let value: u32 =3D value as u32;
> +        match RegisterOffset::try_from(offset) {
> +            Err(_bad_offset) =3D> {
> +                eprintln!("write bad offset {offset} value {value}");
> +            }
> +            Ok(DR) =3D> {
> +                // ??? Check if transmitter is enabled.
> +                let ch: u8 =3D value as u8;
> +                // XXX this blocks entire thread. Rewrite to use
> +                // qemu_chr_fe_write and background I/O callbacks
> +
> +                // SAFETY: self.char_backend is a valid CharBackend inst=
ance after it's been
> +                // initialized in realize().
> +                unsafe {
> +                    qemu_chr_fe_write_all(addr_of_mut!(self.char_backend=
), &ch, 1);
> +                }
> +                self.loopback_tx(value);
> +                self.int_level |=3D registers::INT_TX;
> +                self.update();
> +            }
> +            Ok(RSR) =3D> {
> +                self.receive_status_error_clear =3D 0.into();
> +            }
> +            Ok(FR) =3D> {
> +                // flag writes are ignored
> +            }
> +            Ok(ILPR) =3D> {
> +                self.ilpr =3D value;
> +            }
> +            Ok(IBRD) =3D> {
> +                self.ibrd =3D value;
> +            }
> +            Ok(FBRD) =3D> {
> +                self.fbrd =3D value;
> +            }
> +            Ok(LCR_H) =3D> {
> +                let value =3D value as u16;
> +                let new_val: registers::LineControl =3D value.into();
> +                // Reset the FIFO state on FIFO enable or disable
> +                if bool::from(self.line_control.fifos_enabled())
> +                    ^ bool::from(new_val.fifos_enabled())
> +                {
> +                    self.reset_fifo();
> +                }
> +                if self.line_control.send_break() ^ new_val.send_break()=
 {
> +                    let mut break_enable: c_int =3D new_val.send_break()=
.into();
> +                    // SAFETY: self.char_backend is a valid CharBackend =
instance after it's been
> +                    // initialized in realize().
> +                    unsafe {
> +                        qemu_chr_fe_ioctl(
> +                            addr_of_mut!(self.char_backend),
> +                            CHR_IOCTL_SERIAL_SET_BREAK as i32,
> +                            addr_of_mut!(break_enable).cast::<c_void>(),
> +                        );
> +                    }
> +                    self.loopback_break(break_enable > 0);
> +                }
> +                self.line_control =3D new_val;
> +                self.set_read_trigger();
> +            }
> +            Ok(CR) =3D> {
> +                // ??? Need to implement the enable bit.
> +                let value =3D value as u16;
> +                self.control =3D value.into();
> +                self.loopback_mdmctrl();
> +            }
> +            Ok(FLS) =3D> {
> +                self.ifl =3D value;
> +                self.set_read_trigger();
> +            }
> +            Ok(IMSC) =3D> {
> +                self.int_enabled =3D value;
> +                self.update();
> +            }
> +            Ok(RIS) =3D> {}
> +            Ok(MIS) =3D> {}
> +            Ok(ICR) =3D> {
> +                self.int_level &=3D !value;
> +                self.update();
> +            }
> +            Ok(DMACR) =3D> {
> +                self.dmacr =3D value;
> +                if value & 3 > 0 {
> +                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemen=
ted\n");
> +                    eprintln!("pl011: DMA not implemented");
> +                }
> +            }
> +        }
> +    }
> +
> +    #[inline]
> +    fn loopback_tx(&mut self, value: u32) {
> +        if !self.loopback_enabled() {
> +            return;
> +        }
> +
> +        // Caveat:
> +        //
> +        // In real hardware, TX loopback happens at the serial-bit level
> +        // and then reassembled by the RX logics back into bytes and pla=
ced
> +        // into the RX fifo. That is, loopback happens after TX fifo.
> +        //
> +        // Because the real hardware TX fifo is time-drained at the fram=
e
> +        // rate governed by the configured serial format, some loopback
> +        // bytes in TX fifo may still be able to get into the RX fifo
> +        // that could be full at times while being drained at software
> +        // pace.
> +        //
> +        // In such scenario, the RX draining pace is the major factor
> +        // deciding which loopback bytes get into the RX fifo, unless
> +        // hardware flow-control is enabled.
> +        //
> +        // For simplicity, the above described is not emulated.
> +        self.put_fifo(value);
> +    }
> +
> +    fn loopback_mdmctrl(&mut self) {
> +        if !self.loopback_enabled() {
> +            return;
> +        }
> +
> +        /*
> +         * Loopback software-driven modem control outputs to modem statu=
s inputs:
> +         *   FR.RI  <=3D CR.Out2
> +         *   FR.DCD <=3D CR.Out1
> +         *   FR.CTS <=3D CR.RTS
> +         *   FR.DSR <=3D CR.DTR
> +         *
> +         * The loopback happens immediately even if this call is trigger=
ed
> +         * by setting only CR.LBE.
> +         *
> +         * CTS/RTS updates due to enabled hardware flow controls are not
> +         * dealt with here.
> +         */
> +
> +        //fr =3D s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
> +        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
> +        //fr |=3D (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
> +        //fr |=3D (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
> +        //fr |=3D (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
> +        //fr |=3D (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
> +        //
> +        self.flags.set_ring_indicator(self.control.out_2());
> +        self.flags.set_data_carrier_detect(self.control.out_1());
> +        self.flags.set_clear_to_send(self.control.request_to_send());
> +        self.flags
> +            .set_data_set_ready(self.control.data_transmit_ready());
> +
> +        // Change interrupts based on updated FR
> +        let mut il =3D self.int_level;
> +
> +        il &=3D !Interrupt::MS;
> +        //il |=3D (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
> +        //il |=3D (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
> +        //il |=3D (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
> +        //il |=3D (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
> +
> +        if self.flags.data_set_ready() {
> +            il |=3D Interrupt::DSR as u32;
> +        }
> +        if self.flags.data_carrier_detect() {
> +            il |=3D Interrupt::DCD as u32;
> +        }
> +        if self.flags.clear_to_send() {
> +            il |=3D Interrupt::CTS as u32;
> +        }
> +        if self.flags.ring_indicator() {
> +            il |=3D Interrupt::RI as u32;
> +        }
> +        self.int_level =3D il;
> +        self.update();
> +    }
> +
> +    fn loopback_break(&mut self, enable: bool) {
> +        if enable {
> +            self.loopback_tx(DATA_BREAK);
> +        }
> +    }
> +
> +    fn set_read_trigger(&mut self) {
> +        //#if 0
> +        //    /* The docs say the RX interrupt is triggered when the FIF=
O exceeds
> +        //       the threshold.  However linux only reads the FIFO in re=
sponse to an
> +        //       interrupt.  Triggering the interrupt when the FIFO is n=
on-empty seems
> +        //       to make things work.  */
> +        //    if (s->lcr & LCR_FEN)
> +        //        s->read_trigger =3D (s->ifl >> 1) & 0x1c;
> +        //    else
> +        //#endif
> +        self.read_trigger =3D 1;
> +    }
> +
> +    pub fn realize(&mut self) {
> +        // SAFETY: self.char_backend has the correct size and alignment =
for a
> +        // CharBackend object, and its callbacks are of the correct type=
s.
> +        unsafe {
> +            qemu_chr_fe_set_handlers(
> +                addr_of_mut!(self.char_backend),
> +                Some(pl011_can_receive),
> +                Some(pl011_receive),
> +                Some(pl011_event),
> +                None,
> +                addr_of_mut!(*self).cast::<c_void>(),
> +                core::ptr::null_mut(),
> +                true,
> +            );
> +        }
> +    }
> +
> +    pub fn reset(&mut self) {
> +        self.line_control.reset();
> +        self.receive_status_error_clear.reset();
> +        self.dmacr =3D 0;
> +        self.int_enabled =3D 0;
> +        self.int_level =3D 0;
> +        self.ilpr =3D 0;
> +        self.ibrd =3D 0;
> +        self.fbrd =3D 0;
> +        self.read_trigger =3D 1;
> +        self.ifl =3D 0x12;
> +        self.control.reset();
> +        self.flags =3D 0.into();
> +        self.reset_fifo();
> +    }
> +
> +    pub fn reset_fifo(&mut self) {
> +        self.read_count =3D 0;
> +        self.read_pos =3D 0;
> +
> +        /* Reset FIFO flags */
> +        self.flags.reset();
> +    }
> +
> +    pub fn can_receive(&self) -> bool {
> +        // trace_pl011_can_receive(s->lcr, s->read_count, r);
> +        self.read_count < self.fifo_depth()
> +    }
> +
> +    pub fn event(&mut self, event: QEMUChrEvent) {
> +        if event =3D=3D bindings::QEMUChrEvent_CHR_EVENT_BREAK && !self.=
fifo_enabled() {
> +            self.put_fifo(DATA_BREAK);
> +            self.receive_status_error_clear.set_break_error(true);
> +        }
> +    }
> +
> +    #[inline]
> +    pub fn fifo_enabled(&self) -> bool {
> +        matches!(self.line_control.fifos_enabled(), registers::Mode::FIF=
O)
> +    }
> +
> +    #[inline]
> +    pub fn loopback_enabled(&self) -> bool {
> +        self.control.enable_loopback()
> +    }
> +
> +    #[inline]
> +    pub fn fifo_depth(&self) -> usize {
> +        // Note: FIFO depth is expected to be power-of-2
> +        if self.fifo_enabled() {
> +            return PL011_FIFO_DEPTH;
> +        }
> +        1
> +    }
> +
> +    pub fn put_fifo(&mut self, value: c_uint) {
> +        let depth =3D self.fifo_depth();
> +        assert!(depth > 0);
> +        let slot =3D (self.read_pos + self.read_count) & (depth - 1);
> +        self.read_fifo[slot] =3D value;
> +        self.read_count +=3D 1;
> +        // s->flags &=3D ~PL011_FLAG_RXFE;
> +        self.flags.set_receive_fifo_empty(false);
> +        if self.read_count =3D=3D depth {
> +            //s->flags |=3D PL011_FLAG_RXFF;
> +            self.flags.set_receive_fifo_full(true);
> +        }
> +
> +        if self.read_count =3D=3D self.read_trigger {
> +            self.int_level |=3D registers::INT_RX;
> +            self.update();
> +        }
> +    }
> +
> +    pub fn update(&mut self) {
> +        let flags =3D self.int_level & self.int_enabled;
> +        for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
> +            // SAFETY: self.interrupts have been initialized in init().
> +            unsafe { qemu_set_irq(*irq, i32::from(flags & i !=3D 0)) };
> +        }
> +    }
> +}
> +
> +/// Which bits in the interrupt status matter for each outbound IRQ line=
 ?
> +pub const IRQMASK: [u32; 6] =3D [
> +    /* combined IRQ */
> +    Interrupt::E
> +        | Interrupt::MS
> +        | Interrupt::RT as u32
> +        | Interrupt::TX as u32
> +        | Interrupt::RX as u32,
> +    Interrupt::RX as u32,
> +    Interrupt::TX as u32,
> +    Interrupt::RT as u32,
> +    Interrupt::MS,
> +    Interrupt::E,
> +];
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int=
 {
> +    assert!(!opaque.is_null());
> +    let state =3D NonNull::new_unchecked(opaque.cast::<PL011State>());
> +    state.as_ref().can_receive().into()
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +///
> +/// The buffer and size arguments must also be valid.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_receive(
> +    opaque: *mut core::ffi::c_void,
> +    buf: *const u8,
> +    size: core::ffi::c_int,
> +) {
> +    assert!(!opaque.is_null());
> +    let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>()=
);
> +    if state.as_ref().loopback_enabled() {
> +        return;
> +    }
> +    if size > 0 {
> +        assert!(!buf.is_null());
> +        state
> +            .as_mut()
> +            .put_fifo(c_uint::from(unsafe { buf.read_volatile() }))
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, eve=
nt: QEMUChrEvent) {
> +    assert!(!opaque.is_null());
> +    let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>()=
);
> +    state.as_mut().event(event)
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer for =
`chr`.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_create(
> +    addr: u64,
> +    irq: qemu_irq,
> +    chr: *mut Chardev,
> +) -> *mut DeviceState {
> +    let dev: *mut DeviceState =3D unsafe { qdev_new(PL011State::TYPE_INF=
O.name) };
> +    assert!(!dev.is_null());
> +    let sysbus: *mut SysBusDevice =3D dev as *mut SysBusDevice;
> +
> +    qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
> +    sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut =
Error);
> +    sysbus_mmio_map(sysbus, 0, addr);
> +    sysbus_connect_irq(sysbus, 0, irq);
> +    dev
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
> +    assert!(!obj.is_null());
> +    let mut state =3D NonNull::new_unchecked(obj.cast::<PL011State>());
> +    state.as_mut().init();
> +}
> diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/=
src/device_class.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..631d276e72d444011ef5ef28c=
e169815439011d6
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/device_class.rs
> @@ -0,0 +1,59 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use core::ptr::NonNull;
> +
> +use qemu_api::bindings::*;
> +
> +use crate::{definitions::VMSTATE_PL011, device::PL011State};
> +
> +qemu_api::declare_properties! {
> +    PL011_PROPERTIES,
> +    qemu_api::define_property!(
> +        c"chardev",
> +        PL011State,
> +        char_backend,
> +        unsafe { &qdev_prop_chr },
> +        CharBackend
> +    ),
> +    qemu_api::define_property!(
> +        c"migrate-clk",
> +        PL011State,
> +        migrate_clock,
> +        unsafe { &qdev_prop_bool },
> +        bool
> +    ),
> +}
> +
> +qemu_api::device_class_init! {
> +    pl011_class_init,
> +    props =3D> PL011_PROPERTIES,
> +    realize_fn =3D> Some(pl011_realize),
> +    reset_fn =3D> Some(pl011_reset),
> +    vmsd =3D> VMSTATE_PL011,
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mu=
t *mut Error) {
> +    assert!(!dev.is_null());
> +    let mut state =3D NonNull::new_unchecked(dev.cast::<PL011State>());
> +    state.as_mut().realize();
> +}
> +
> +/// # Safety
> +///
> +/// We expect the FFI user of this function to pass a valid pointer, tha=
t has
> +/// the same size as [`PL011State`]. We also expect the device is
> +/// readable/writeable from one thread at any time.
> +#[no_mangle]
> +pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
> +    assert!(!dev.is_null());
> +    let mut state =3D NonNull::new_unchecked(dev.cast::<PL011State>());
> +    state.as_mut().reset();
> +}
> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.r=
s
> new file mode 100644
> index 0000000000000000000000000000000000000000..54de89538a59c6f29a4192792=
00f75d516913bad
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -0,0 +1,585 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// PL011 QEMU Device Model
> +//
> +// This library implements a device model for the PrimeCell=C2=AE UART (=
PL011)
> +// device in QEMU.
> +//
> +#![doc =3D include_str!("../README.md")]
> +//! # Library crate
> +//!
> +//! See [`PL011State`](crate::device::PL011State) for the device model t=
ype and
> +//! the [`registers`] module for register types.
> +
> +#![deny(
> +    rustdoc::broken_intra_doc_links,
> +    rustdoc::redundant_explicit_links,
> +    clippy::correctness,
> +    clippy::suspicious,
> +    clippy::complexity,
> +    clippy::perf,
> +    clippy::cargo,
> +    clippy::nursery,
> +    clippy::style,
> +    // restriction group
> +    clippy::dbg_macro,
> +    clippy::as_underscore,
> +    clippy::assertions_on_result_states,
> +    // pedantic group
> +    clippy::doc_markdown,
> +    clippy::borrow_as_ptr,
> +    clippy::cast_lossless,
> +    clippy::option_if_let_else,
> +    clippy::missing_const_for_fn,
> +    clippy::cognitive_complexity,
> +    clippy::missing_safety_doc,
> +    )]
> +
> +extern crate bilge;
> +extern crate bilge_impl;
> +extern crate qemu_api;
> +
> +pub mod definitions;
> +pub mod device;
> +pub mod device_class;
> +pub mod memory_ops;
> +
> +/// Offset of each register from the base memory address of the device.
> +///
> +/// # Source
> +/// ARM DDI 0183G, Table 3-1 p.3-3
> +#[doc(alias =3D "offset")]
> +#[allow(non_camel_case_types)]
> +#[repr(u64)]
> +#[derive(Debug)]
> +pub enum RegisterOffset {
> +    /// Data Register
> +    ///
> +    /// A write to this register initiates the actual data transmission
> +    #[doc(alias =3D "UARTDR")]
> +    DR =3D 0x000,
> +    /// Receive Status Register or Error Clear Register
> +    #[doc(alias =3D "UARTRSR")]
> +    #[doc(alias =3D "UARTECR")]
> +    RSR =3D 0x004,
> +    /// Flag Register
> +    ///
> +    /// A read of this register shows if transmission is complete
> +    #[doc(alias =3D "UARTFR")]
> +    FR =3D 0x018,
> +    /// Fractional Baud Rate Register
> +    ///
> +    /// responsible for baud rate speed
> +    #[doc(alias =3D "UARTFBRD")]
> +    FBRD =3D 0x028,
> +    /// `IrDA` Low-Power Counter Register
> +    #[doc(alias =3D "UARTILPR")]
> +    ILPR =3D 0x020,
> +    /// Integer Baud Rate Register
> +    ///
> +    /// Responsible for baud rate speed
> +    #[doc(alias =3D "UARTIBRD")]
> +    IBRD =3D 0x024,
> +    /// line control register (data frame format)
> +    #[doc(alias =3D "UARTLCR_H")]
> +    LCR_H =3D 0x02C,
> +    /// Toggle UART, transmission or reception
> +    #[doc(alias =3D "UARTCR")]
> +    CR =3D 0x030,
> +    /// Interrupt FIFO Level Select Register
> +    #[doc(alias =3D "UARTIFLS")]
> +    FLS =3D 0x034,
> +    /// Interrupt Mask Set/Clear Register
> +    #[doc(alias =3D "UARTIMSC")]
> +    IMSC =3D 0x038,
> +    /// Raw Interrupt Status Register
> +    #[doc(alias =3D "UARTRIS")]
> +    RIS =3D 0x03C,
> +    /// Masked Interrupt Status Register
> +    #[doc(alias =3D "UARTMIS")]
> +    MIS =3D 0x040,
> +    /// Interrupt Clear Register
> +    #[doc(alias =3D "UARTICR")]
> +    ICR =3D 0x044,
> +    /// DMA control Register
> +    #[doc(alias =3D "UARTDMACR")]
> +    DMACR =3D 0x048,
> +    ///// Reserved, offsets `0x04C` to `0x07C`.
> +    //Reserved =3D 0x04C,
> +}
> +
> +impl core::convert::TryFrom<u64> for RegisterOffset {
> +    type Error =3D u64;
> +
> +    fn try_from(value: u64) -> Result<Self, Self::Error> {
> +        macro_rules! case {
> +            ($($discriminant:ident),*$(,)*) =3D> {
> +                /* check that matching on all macro arguments compiles, =
which means we are not
> +                 * missing any enum value; if the type definition ever c=
hanges this will stop
> +                 * compiling.
> +                 */
> +                const fn _assert_exhaustive(val: RegisterOffset) {
> +                    match val {
> +                        $(RegisterOffset::$discriminant =3D> (),)*
> +                    }
> +                }
> +
> +                match value {
> +                    $(x if x =3D=3D Self::$discriminant as u64 =3D> Ok(S=
elf::$discriminant),)*
> +                     _ =3D> Err(value),
> +                }
> +            }
> +        }
> +        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS=
, MIS, ICR, DMACR }
> +    }
> +}
> +
> +pub mod registers {
> +    //! Device registers exposed as typed structs which are backed by ar=
bitrary
> +    //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
> +    //!
> +    //! All PL011 registers are essentially 32-bit wide, but are typed h=
ere as
> +    //! bitmaps with only the necessary width. That is, if a struct bitm=
ap
> +    //! in this module is for example 16 bits long, it should be conceiv=
ed
> +    //! as a 32-bit register where the unmentioned higher bits are alway=
s
> +    //! unused thus treated as zero when read or written.
> +    use bilge::prelude::*;
> +
> +    // TODO: FIFO Mode has different semantics
> +    /// Data Register, `UARTDR`
> +    ///
> +    /// The `UARTDR` register is the data register.
> +    ///
> +    /// For words to be transmitted:
> +    ///
> +    /// - if the FIFOs are enabled, data written to this location is pus=
hed onto
> +    ///   the transmit
> +    /// FIFO
> +    /// - if the FIFOs are not enabled, data is stored in the transmitte=
r
> +    ///   holding register (the
> +    /// bottom word of the transmit FIFO).
> +    ///
> +    /// The write operation initiates transmission from the UART. The da=
ta is
> +    /// prefixed with a start bit, appended with the appropriate parity =
bit
> +    /// (if parity is enabled), and a stop bit. The resultant word is th=
en
> +    /// transmitted.
> +    ///
> +    /// For received words:
> +    ///
> +    /// - if the FIFOs are enabled, the data byte and the 4-bit status (=
break,
> +    ///   frame, parity,
> +    /// and overrun) is pushed onto the 12-bit wide receive FIFO
> +    /// - if the FIFOs are not enabled, the data byte and status are sto=
red in
> +    ///   the receiving
> +    /// holding register (the bottom word of the receive FIFO).
> +    ///
> +    /// The received data byte is read by performing reads from the `UAR=
TDR`
> +    /// register along with the corresponding status information. The st=
atus
> +    /// information can also be read by a read of the `UARTRSR/UARTECR`
> +    /// register.
> +    ///
> +    /// # Note
> +    ///
> +    /// You must disable the UART before any of the control registers ar=
e
> +    /// reprogrammed. When the UART is disabled in the middle of
> +    /// transmission or reception, it completes the current character be=
fore
> +    /// stopping.
> +    ///
> +    /// # Source
> +    /// ARM DDI 0183G 3.3.1 Data Register, UARTDR
> +    #[bitsize(16)]
> +    #[derive(Clone, Copy, DebugBits, FromBits)]
> +    #[doc(alias =3D "UARTDR")]
> +    pub struct Data {
> +        _reserved: u4,
> +        pub data: u8,
> +        pub framing_error: bool,
> +        pub parity_error: bool,
> +        pub break_error: bool,
> +        pub overrun_error: bool,
> +    }
> +
> +    // TODO: FIFO Mode has different semantics
> +    /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR=
`
> +    ///
> +    /// The UARTRSR/UARTECR register is the receive status register/erro=
r clear
> +    /// register. Receive status can also be read from the `UARTRSR`
> +    /// register. If the status is read from this register, then the sta=
tus
> +    /// information for break, framing and parity corresponds to the
> +    /// data character read from the [Data register](Data), `UARTDR` pri=
or to
> +    /// reading the UARTRSR register. The status information for overrun=
 is
> +    /// set immediately when an overrun condition occurs.
> +    ///
> +    ///
> +    /// # Note
> +    /// The received data character must be read first from the [Data
> +    /// Register](Data), `UARTDR` before reading the error status associ=
ated
> +    /// with that data character from the `UARTRSR` register. This read
> +    /// sequence cannot be reversed, because the `UARTRSR` register is
> +    /// updated only when a read occurs from the `UARTDR` register. Howe=
ver,
> +    /// the status information can also be obtained by reading the `UART=
DR`
> +    /// register
> +    ///
> +    /// # Source
> +    /// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register=
,
> +    /// UARTRSR/UARTECR
> +    #[bitsize(8)]
> +    #[derive(Clone, Copy, DebugBits, FromBits)]
> +    pub struct ReceiveStatusErrorClear {
> +        pub framing_error: bool,
> +        pub parity_error: bool,
> +        pub break_error: bool,
> +        pub overrun_error: bool,
> +        _reserved_unpredictable: u4,
> +    }
> +
> +    impl ReceiveStatusErrorClear {
> +        pub fn reset(&mut self) {
> +            // All the bits are cleared to 0 on reset.
> +            *self =3D 0.into();
> +        }
> +    }
> +
> +    impl Default for ReceiveStatusErrorClear {
> +        fn default() -> Self {
> +            0.into()
> +        }
> +    }
> +
> +    #[bitsize(16)]
> +    #[derive(Clone, Copy, DebugBits, FromBits)]
> +    /// Flag Register, `UARTFR`
> +    #[doc(alias =3D "UARTFR")]
> +    pub struct Flags {
> +        /// CTS Clear to send. This bit is the complement of the UART cl=
ear to
> +        /// send, `nUARTCTS`, modem status input. That is, the bit is 1
> +        /// when `nUARTCTS` is LOW.
> +        pub clear_to_send: bool,
> +        /// DSR Data set ready. This bit is the complement of the UART d=
ata set
> +        /// ready, `nUARTDSR`, modem status input. That is, the bit is 1=
 when
> +        /// `nUARTDSR` is LOW.
> +        pub data_set_ready: bool,
> +        /// DCD Data carrier detect. This bit is the complement of the U=
ART data
> +        /// carrier detect, `nUARTDCD`, modem status input. That is, the=
 bit is
> +        /// 1 when `nUARTDCD` is LOW.
> +        pub data_carrier_detect: bool,
> +        /// BUSY UART busy. If this bit is set to 1, the UART is busy
> +        /// transmitting data. This bit remains set until the complete
> +        /// byte, including all the stop bits, has been sent from the
> +        /// shift register. This bit is set as soon as the transmit FIFO
> +        /// becomes non-empty, regardless of whether the UART is enabled
> +        /// or not.
> +        pub busy: bool,
> +        /// RXFE Receive FIFO empty. The meaning of this bit depends on =
the
> +        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
> +        /// is disabled, this bit is set when the receive holding
> +        /// register is empty. If the FIFO is enabled, the RXFE bit is
> +        /// set when the receive FIFO is empty.
> +        pub receive_fifo_empty: bool,
> +        /// TXFF Transmit FIFO full. The meaning of this bit depends on =
the
> +        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
> +        /// is disabled, this bit is set when the transmit holding
> +        /// register is full. If the FIFO is enabled, the TXFF bit is
> +        /// set when the transmit FIFO is full.
> +        pub transmit_fifo_full: bool,
> +        /// RXFF Receive FIFO full. The meaning of this bit depends on t=
he state
> +        /// of the FEN bit in the UARTLCR_H register. If the FIFO is
> +        /// disabled, this bit is set when the receive holding register
> +        /// is full. If the FIFO is enabled, the RXFF bit is set when
> +        /// the receive FIFO is full.
> +        pub receive_fifo_full: bool,
> +        /// Transmit FIFO empty. The meaning of this bit depends on the =
state of
> +        /// the FEN bit in the [Line Control register](LineControl),
> +        /// `UARTLCR_H`. If the FIFO is disabled, this bit is set when t=
he
> +        /// transmit holding register is empty. If the FIFO is enabled,
> +        /// the TXFE bit is set when the transmit FIFO is empty. This
> +        /// bit does not indicate if there is data in the transmit shift
> +        /// register.
> +        pub transmit_fifo_empty: bool,
> +        /// `RI`, is `true` when `nUARTRI` is `LOW`.
> +        pub ring_indicator: bool,
> +        _reserved_zero_no_modify: u7,
> +    }
> +
> +    impl Flags {
> +        pub fn reset(&mut self) {
> +            // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE=
 are 1
> +            self.set_receive_fifo_full(false);
> +            self.set_transmit_fifo_full(false);
> +            self.set_busy(false);
> +            self.set_receive_fifo_empty(true);
> +            self.set_transmit_fifo_empty(true);
> +        }
> +    }
> +
> +    impl Default for Flags {
> +        fn default() -> Self {
> +            let mut ret: Self =3D 0.into();
> +            ret.reset();
> +            ret
> +        }
> +    }
> +
> +    #[bitsize(16)]
> +    #[derive(Clone, Copy, DebugBits, FromBits)]
> +    /// Line Control Register, `UARTLCR_H`
> +    #[doc(alias =3D "UARTLCR_H")]
> +    pub struct LineControl {
> +        /// 15:8 - Reserved, do not modify, read as zero.
> +        _reserved_zero_no_modify: u8,
> +        /// 7 SPS Stick parity select.
> +        /// 0 =3D stick parity is disabled
> +        /// 1 =3D either:
> +        /// =E2=80=A2 if the EPS bit is 0 then the parity bit is transmi=
tted and checked
> +        /// as a 1 =E2=80=A2 if the EPS bit is 1 then the parity bit is
> +        /// transmitted and checked as a 0. This bit has no effect when
> +        /// the PEN bit disables parity checking and generation. See Tab=
le 3-11
> +        /// on page 3-14 for the parity truth table.
> +        pub sticky_parity: bool,
> +        /// WLEN Word length. These bits indicate the number of data bit=
s
> +        /// transmitted or received in a frame as follows: b11 =3D 8 bit=
s
> +        /// b10 =3D 7 bits
> +        /// b01 =3D 6 bits
> +        /// b00 =3D 5 bits.
> +        pub word_length: WordLength,
> +        /// FEN Enable FIFOs:
> +        /// 0 =3D FIFOs are disabled (character mode) that is, the FIFOs=
 become
> +        /// 1-byte-deep holding registers 1 =3D transmit and receive FIF=
O
> +        /// buffers are enabled (FIFO mode).
> +        pub fifos_enabled: Mode,
> +        /// 3 STP2 Two stop bits select. If this bit is set to 1, two st=
op bits
> +        /// are transmitted at the end of the frame. The receive
> +        /// logic does not check for two stop bits being received.
> +        pub two_stops_bits: bool,
> +        /// EPS Even parity select. Controls the type of parity the UART=
 uses
> +        /// during transmission and reception:
> +        /// - 0 =3D odd parity. The UART generates or checks for an odd =
number of
> +        ///   1s in the data and parity bits.
> +        /// - 1 =3D even parity. The UART generates or checks for an eve=
n number
> +        ///   of 1s in the data and parity bits.
> +        /// This bit has no effect when the `PEN` bit disables parity ch=
ecking
> +        /// and generation. See Table 3-11 on page 3-14 for the parity
> +        /// truth table.
> +        pub parity: Parity,
> +        /// 1 PEN Parity enable:
> +        ///
> +        /// - 0 =3D parity is disabled and no parity bit added to the da=
ta frame
> +        /// - 1 =3D parity checking and generation is enabled.
> +        ///
> +        /// See Table 3-11 on page 3-14 for the parity truth table.
> +        pub parity_enabled: bool,
> +        /// BRK Send break.
> +        ///
> +        /// If this bit is set to `1`, a low-level is continually output=
 on the
> +        /// `UARTTXD` output, after completing transmission of the
> +        /// current character. For the proper execution of the break com=
mand,
> +        /// the software must set this bit for at least two complete
> +        /// frames. For normal use, this bit must be cleared to `0`.
> +        pub send_break: bool,
> +    }
> +
> +    impl LineControl {
> +        pub fn reset(&mut self) {
> +            // All the bits are cleared to 0 when reset.
> +            *self =3D 0.into();
> +        }
> +    }
> +
> +    impl Default for LineControl {
> +        fn default() -> Self {
> +            0.into()
> +        }
> +    }
> +
> +    #[bitsize(1)]
> +    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> +    /// `EPS` "Even parity select", field of [Line Control
> +    /// register](LineControl).
> +    pub enum Parity {
> +        /// - 0 =3D odd parity. The UART generates or checks for an odd =
number of
> +        ///   1s in the data and parity bits.
> +        Odd =3D 0,
> +        /// - 1 =3D even parity. The UART generates or checks for an eve=
n number
> +        ///   of 1s in the data and parity bits.
> +        Even =3D 1,
> +    }
> +
> +    #[bitsize(1)]
> +    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> +    /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
> +    /// register](LineControl).
> +    pub enum Mode {
> +        /// 0 =3D FIFOs are disabled (character mode) that is, the FIFOs=
 become
> +        /// 1-byte-deep holding registers
> +        Character =3D 0,
> +        /// 1 =3D transmit and receive FIFO buffers are enabled (FIFO mo=
de).
> +        FIFO =3D 1,
> +    }
> +
> +    impl From<Mode> for bool {
> +        fn from(val: Mode) -> Self {
> +            matches!(val, Mode::FIFO)
> +        }
> +    }
> +
> +    #[bitsize(2)]
> +    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> +    /// `WLEN` Word length, field of [Line Control register](LineControl=
).
> +    ///
> +    /// These bits indicate the number of data bits transmitted or recei=
ved in a
> +    /// frame as follows:
> +    pub enum WordLength {
> +        /// b11 =3D 8 bits
> +        _8Bits =3D 0b11,
> +        /// b10 =3D 7 bits
> +        _7Bits =3D 0b10,
> +        /// b01 =3D 6 bits
> +        _6Bits =3D 0b01,
> +        /// b00 =3D 5 bits.
> +        _5Bits =3D 0b00,
> +    }
> +
> +    /// Control Register, `UARTCR`
> +    ///
> +    /// The `UARTCR` register is the control register. All the bits are =
cleared
> +    /// to `0` on reset except for bits `9` and `8` that are set to `1`.
> +    ///
> +    /// # Source
> +    /// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
> +    #[bitsize(16)]
> +    #[doc(alias =3D "UARTCR")]
> +    #[derive(Clone, Copy, DebugBits, FromBits)]
> +    pub struct Control {
> +        /// `UARTEN` UART enable: 0 =3D UART is disabled. If the UART is=
 disabled
> +        /// in the middle of transmission or reception, it completes the=
 current
> +        /// character before stopping. 1 =3D the UART is enabled. Data
> +        /// transmission and reception occurs for either UART signals or=
 SIR
> +        /// signals depending on the setting of the SIREN bit.
> +        pub enable_uart: bool,
> +        /// `SIREN` `SIR` enable: 0 =3D IrDA SIR ENDEC is disabled. `nSI=
ROUT`
> +        /// remains LOW (no light pulse generated), and signal transitio=
ns on
> +        /// SIRIN have no effect. 1 =3D IrDA SIR ENDEC is enabled. Data =
is
> +        /// transmitted and received on nSIROUT and SIRIN. UARTTXD remai=
ns HIGH,
> +        /// in the marking state. Signal transitions on UARTRXD or modem=
 status
> +        /// inputs have no effect. This bit has no effect if the UARTEN =
bit
> +        /// disables the UART.
> +        pub enable_sir: bool,
> +        /// `SIRLP` SIR low-power IrDA mode. This bit selects the IrDA e=
ncoding
> +        /// mode. If this bit is cleared to 0, low-level bits are transm=
itted as
> +        /// an active high pulse with a width of 3/ 16th of the bit peri=
od. If
> +        /// this bit is set to 1, low-level bits are transmitted with a =
pulse
> +        /// width that is 3 times the period of the IrLPBaud16 input sig=
nal,
> +        /// regardless of the selected bit rate. Setting this bit uses l=
ess
> +        /// power, but might reduce transmission distances.
> +        pub sir_lowpower_irda_mode: u1,
> +        /// Reserved, do not modify, read as zero.
> +        _reserved_zero_no_modify: u4,
> +        /// `LBE` Loopback enable. If this bit is set to 1 and the SIREN=
 bit is
> +        /// set to 1 and the SIRTEST bit in the Test Control register, U=
ARTTCR
> +        /// on page 4-5 is set to 1, then the nSIROUT path is inverted, =
and fed
> +        /// through to the SIRIN path. The SIRTEST bit in the test regis=
ter must
> +        /// be set to 1 to override the normal half-duplex SIR operation=
. This
> +        /// must be the requirement for accessing the test registers dur=
ing
> +        /// normal operation, and SIRTEST must be cleared to 0 when loop=
back
> +        /// testing is finished. This feature reduces the amount of exte=
rnal
> +        /// coupling required during system test. If this bit is set to =
1, and
> +        /// the SIRTEST bit is set to 0, the UARTTXD path is fed through=
 to the
> +        /// UARTRXD path. In either SIR mode or UART mode, when this bit=
 is set,
> +        /// the modem outputs are also fed through to the modem inputs. =
This bit
> +        /// is cleared to 0 on reset, to disable loopback.
> +        pub enable_loopback: bool,
> +        /// `TXE` Transmit enable. If this bit is set to 1, the transmit=
 section
> +        /// of the UART is enabled. Data transmission occurs for either =
UART
> +        /// signals, or SIR signals depending on the setting of the SIRE=
N bit.
> +        /// When the UART is disabled in the middle of transmission, it
> +        /// completes the current character before stopping.
> +        pub enable_transmit: bool,
> +        /// `RXE` Receive enable. If this bit is set to 1, the receive s=
ection
> +        /// of the UART is enabled. Data reception occurs for either UAR=
T
> +        /// signals or SIR signals depending on the setting of the SIREN=
 bit.
> +        /// When the UART is disabled in the middle of reception, it com=
pletes
> +        /// the current character before stopping.
> +        pub enable_receive: bool,
> +        /// `DTR` Data transmit ready. This bit is the complement of the=
 UART
> +        /// data transmit ready, `nUARTDTR`, modem status output. That i=
s, when
> +        /// the bit is programmed to a 1 then `nUARTDTR` is LOW.
> +        pub data_transmit_ready: bool,
> +        /// `RTS` Request to send. This bit is the complement of the UAR=
T
> +        /// request to send, `nUARTRTS`, modem status output. That is, w=
hen the
> +        /// bit is programmed to a 1 then `nUARTRTS` is LOW.
> +        pub request_to_send: bool,
> +        /// `Out1` This bit is the complement of the UART Out1 (`nUARTOu=
t1`)
> +        /// modem status output. That is, when the bit is programmed to =
a 1 the
> +        /// output is 0. For DTE this can be used as Data Carrier Detect=
 (DCD).
> +        pub out_1: bool,
> +        /// `Out2` This bit is the complement of the UART Out2 (`nUARTOu=
t2`)
> +        /// modem status output. That is, when the bit is programmed to =
a 1, the
> +        /// output is 0. For DTE this can be used as Ring Indicator (RI)=
.
> +        pub out_2: bool,
> +        /// `RTSEn` RTS hardware flow control enable. If this bit is set=
 to 1,
> +        /// RTS hardware flow control is enabled. Data is only requested=
 when
> +        /// there is space in the receive FIFO for it to be received.
> +        pub rts_hardware_flow_control_enable: bool,
> +        /// `CTSEn` CTS hardware flow control enable. If this bit is set=
 to 1,
> +        /// CTS hardware flow control is enabled. Data is only transmitt=
ed when
> +        /// the `nUARTCTS` signal is asserted.
> +        pub cts_hardware_flow_control_enable: bool,
> +    }
> +
> +    impl Control {
> +        pub fn reset(&mut self) {
> +            *self =3D 0.into();
> +            self.set_enable_receive(true);
> +            self.set_enable_transmit(true);
> +        }
> +    }
> +
> +    impl Default for Control {
> +        fn default() -> Self {
> +            let mut ret: Self =3D 0.into();
> +            ret.reset();
> +            ret
> +        }
> +    }
> +
> +    /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
> +    pub const INT_OE: u32 =3D 1 << 10;
> +    pub const INT_BE: u32 =3D 1 << 9;
> +    pub const INT_PE: u32 =3D 1 << 8;
> +    pub const INT_FE: u32 =3D 1 << 7;
> +    pub const INT_RT: u32 =3D 1 << 6;
> +    pub const INT_TX: u32 =3D 1 << 5;
> +    pub const INT_RX: u32 =3D 1 << 4;
> +    pub const INT_DSR: u32 =3D 1 << 3;
> +    pub const INT_DCD: u32 =3D 1 << 2;
> +    pub const INT_CTS: u32 =3D 1 << 1;
> +    pub const INT_RI: u32 =3D 1 << 0;
> +    pub const INT_E: u32 =3D INT_OE | INT_BE | INT_PE | INT_FE;
> +    pub const INT_MS: u32 =3D INT_RI | INT_DSR | INT_DCD | INT_CTS;
> +
> +    #[repr(u32)]
> +    pub enum Interrupt {
> +        OE =3D 1 << 10,
> +        BE =3D 1 << 9,
> +        PE =3D 1 << 8,
> +        FE =3D 1 << 7,
> +        RT =3D 1 << 6,
> +        TX =3D 1 << 5,
> +        RX =3D 1 << 4,
> +        DSR =3D 1 << 3,
> +        DCD =3D 1 << 2,
> +        CTS =3D 1 << 1,
> +        RI =3D 1 << 0,
> +    }
> +
> +    impl Interrupt {
> +        pub const E: u32 =3D INT_OE | INT_BE | INT_PE | INT_FE;
> +        pub const MS: u32 =3D INT_RI | INT_DSR | INT_DCD | INT_CTS;
> +    }
> +}
> +
> +// TODO: You must disable the UART before any of the control registers a=
re
> +// reprogrammed. When the UART is disabled in the middle of transmission=
 or
> +// reception, it completes the current character before stopping
> diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/sr=
c/memory_ops.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..a2552ba58ecf2b33a07f4cced=
5e7c5e3c3cdfcff
> --- /dev/null
> +++ b/rust/hw/char/pl011/src/memory_ops.rs
> @@ -0,0 +1,57 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use core::{mem::MaybeUninit, ptr::NonNull};
> +
> +use qemu_api::bindings::*;
> +
> +use crate::device::PL011State;
> +
> +pub static PL011_OPS: MemoryRegionOps =3D MemoryRegionOps {
> +    read: Some(pl011_read),
> +    write: Some(pl011_write),
> +    read_with_attrs: None,
> +    write_with_attrs: None,
> +    endianness: device_endian_DEVICE_NATIVE_ENDIAN,
> +    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed=
().assume_init() },
> +    impl_: MemoryRegionOps__bindgen_ty_2 {
> +        min_access_size: 4,
> +        max_access_size: 4,
> +        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed(=
).assume_init() }
> +    },
> +};
> +
> +#[no_mangle]
> +unsafe extern "C" fn pl011_read(
> +    opaque: *mut core::ffi::c_void,
> +    addr: hwaddr,
> +    size: core::ffi::c_uint,
> +) -> u64 {
> +    assert!(!opaque.is_null());
> +    let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>()=
);
> +    let val =3D state.as_mut().read(addr, size);
> +    match val {
> +        std::ops::ControlFlow::Break(val) =3D> val,
> +        std::ops::ControlFlow::Continue(val) =3D> {
> +            // SAFETY: self.char_backend is a valid CharBackend instance=
 after it's been
> +            // initialized in realize().
> +            let cb_ptr =3D core::ptr::addr_of_mut!(state.as_mut().char_b=
ackend);
> +            unsafe { qemu_chr_fe_accept_input(cb_ptr) };
> +
> +            val
> +        }
> +    }
> +}
> +
> +#[no_mangle]
> +unsafe extern "C" fn pl011_write(
> +    opaque: *mut core::ffi::c_void,
> +    addr: hwaddr,
> +    data: u64,
> +    _size: core::ffi::c_uint,
> +) {
> +    assert!(!opaque.is_null());
> +    let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>()=
);
> +    state.as_mut().write(addr, data)
> +}
> diff --git a/rust/hw/meson.build b/rust/hw/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..860196645e719624d2e2e6bc3=
01b62b81ab2e19b
> --- /dev/null
> +++ b/rust/hw/meson.build
> @@ -0,0 +1 @@
> +subdir('char')
> diff --git a/rust/meson.build b/rust/meson.build
> index 7a32b1b195083571931ad589965c10ddaf6383b1..def77389cddc52f5d4503840e=
9bdfb1207586fa2 100644
> --- a/rust/meson.build
> +++ b/rust/meson.build
> @@ -1,2 +1,4 @@
>  subdir('qemu-api-macros')
>  subdir('qemu-api')
> +
> +subdir('hw')
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 65af8063e4bddc89ea4bdf05716ebc9ed108e7fb..8b06c162307ec89739775cf6b=
8c15f9734367dd3 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -26,7 +26,10 @@ sub_file=3D"${sub_tdir}/submodule.tar"
>  # independent of what the developer currently has initialized
>  # in their checkout, because the build environment is completely
>  # different to the host OS.
> -subprojects=3D"keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-t=
estfloat-3"
> +subprojects=3D"keycodemapdb libvfio-user berkeley-softfloat-3
> +  berkeley-testfloat-3 arbitrary-int-1.2.7 bilge-0.2.0 bilge-impl-0.2.0
> +  either-1.12.0 itertools-0.11.0 proc-macro2-1.0.84 proc-macro-error-1.0=
.4
> +  proc-macro-error-attr-1.0.4 quote-1.0.36 syn-2.0.66 unicode-ident-1.0.=
12"
>  sub_deinit=3D""
>
>  function cleanup() {
> diff --git a/scripts/make-release b/scripts/make-release
> index 6e0433de24dc8a37cefae6d828a2958309bbf1c1..841404274b066cc26c9065615=
0ab01fa46cbd219 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -17,7 +17,10 @@ if [ $# -ne 2 ]; then
>  fi
>
>  # Only include wraps that are invoked with subproject()
> -SUBPROJECTS=3D"libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-t=
estfloat-3"
> +SUBPROJECTS=3D"libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-t=
estfloat-3
> +  arbitrary-int-1.2.7 bilge-0.2.0 bilge-impl-0.2.0 either-1.12.0 itertoo=
ls-0.11.0
> +  proc-macro2-1.0.84 proc-macro-error-1.0.4 proc-macro-error-attr-1.0.4
> +  quote-1.0.36 syn-2.0.66 unicode-ident-1.0.12"
>
>  src=3D"$1"
>  version=3D"$2"
> diff --git a/scripts/rust/rust_root_crate.sh b/scripts/rust/rust_root_cra=
te.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..975bddf7f1a4c6ca7770f800b=
dc894cdff1f3ab1
> --- /dev/null
> +++ b/scripts/rust/rust_root_crate.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +set -eu
> +
> +cat <<EOF
> +// @generated
> +// This file is autogenerated by scripts/rust_root_crate.sh
> +
> +EOF
> +
> +for crate in $*; do
> +    echo "extern crate $crate;"
> +done
> diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> index adca0266be69181151e77639096380b3aba4abcf..50f173f90dbe5dde1162cfe96=
636f63637574c74 100644
> --- a/subprojects/.gitignore
> +++ b/subprojects/.gitignore
> @@ -6,3 +6,14 @@
>  /keycodemapdb
>  /libvfio-user
>  /slirp
> +/arbitrary-int-1.2.7
> +/bilge-0.2.0
> +/bilge-impl-0.2.0
> +/either-1.12.0
> +/itertools-0.11.0
> +/proc-macro-error-1.0.4
> +/proc-macro-error-attr-1.0.4
> +/proc-macro2-1.0.84
> +/quote-1.0.36
> +/syn-2.0.66
> +/unicode-ident-1.0.12
> diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-=
int-1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..e580538a8776001147bfc5c5c=
73df2bfccac6347
> --- /dev/null
> +++ b/subprojects/arbitrary-int-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D arbitrary-int-1.2.7
> +source_url =3D https://crates.io/api/v1/crates/arbitrary-int/1.2.7/downl=
oad
> +source_filename =3D arbitrary-int-1.2.7.tar.gz
> +source_hash =3D c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff=
8b1df46d
> +#method =3D cargo
> +patch_directory =3D arbitrary-int-1-rs
> diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wra=
p
> new file mode 100644
> index 0000000000000000000000000000000000000000..7a4339d29896922c392e2e195=
2e02a1ee82b1874
> --- /dev/null
> +++ b/subprojects/bilge-0.2-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D bilge-0.2.0
> +source_url =3D https://crates.io/api/v1/crates/bilge/0.2.0/download
> +source_filename =3D bilge-0.2.0.tar.gz
> +source_hash =3D dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c5=
12e67b57
> +#method =3D cargo
> +patch_directory =3D bilge-0.2-rs
> diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-=
0.2-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..eefb10c36c24007d48833748c=
f200d67b6ff7ee7
> --- /dev/null
> +++ b/subprojects/bilge-impl-0.2-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D bilge-impl-0.2.0
> +source_url =3D https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
> +source_filename =3D bilge-impl-0.2.0.tar.gz
> +source_hash =3D feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc0=
00adb2d8
> +#method =3D cargo
> +patch_directory =3D bilge-impl-0.2-rs
> diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..6046712036c8db1b142d083ae=
6f8a2d58d6203ab
> --- /dev/null
> +++ b/subprojects/either-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D either-1.12.0
> +source_url =3D https://crates.io/api/v1/crates/either/1.12.0/download
> +source_filename =3D either-1.12.0.tar.gz
> +source_hash =3D 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb2=
3385b58b
> +#method =3D cargo
> +patch_directory =3D either-1-rs
> diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0=
.11-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..66b05252cd55ed3149b79b992=
a6d224e9789ba97
> --- /dev/null
> +++ b/subprojects/itertools-0.11-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D itertools-0.11.0
> +source_url =3D https://crates.io/api/v1/crates/itertools/0.11.0/download
> +source_filename =3D itertools-0.11.0.tar.gz
> +source_hash =3D b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab54=
18c3fe57
> +#method =3D cargo
> +patch_directory =3D itertools-0.11-rs
> diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/su=
bprojects/packagefiles/arbitrary-int-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..34a189cbaec77ba6631c6a8cb=
40d7eb3f32099ee
> --- /dev/null
> +++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> @@ -0,0 +1,19 @@
> +project('arbitrary-int-1-rs', 'rust',
> +  version: '1.2.7',
> +  license: 'MIT',
> +  default_options: [])
> +
> +_arbitrary_int_rs =3D static_library(
> +  'arbitrary_int',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi: 'rust',
> +  dependencies: [],
> +)
> +
> +arbitrary_int_dep =3D declare_dependency(
> +  link_with: _arbitrary_int_rs,
> +)
> +
> +meson.override_dependency('arbitrary-int-1-rs', arbitrary_int_dep)
> diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subproje=
cts/packagefiles/bilge-0.2-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..a6ed4a8f0cde70be0bf75cd1a=
d40bc64e3a11a3a
> --- /dev/null
> +++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
> @@ -0,0 +1,29 @@
> +project(
> +  'bilge-0.2-rs',
> +  'rust',
> +  version : '0.2.0',
> +  license : 'MIT or Apache-2.0',
> +)
> +
> +subproject('arbitrary-int-1-rs', required: true)
> +subproject('bilge-impl-0.2-rs', required: true)
> +
> +arbitrary_int_dep =3D dependency('arbitrary-int-1-rs')
> +bilge_impl_dep =3D dependency('bilge-impl-0.2-rs')
> +
> +lib =3D static_library(
> +  'bilge',
> +  'src/lib.rs',
> +  override_options : ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi : 'rust',
> +  dependencies: [
> +    arbitrary_int_dep,
> +    bilge_impl_dep,
> +  ],
> +)
> +
> +bilge_dep =3D declare_dependency(
> +  link_with : [lib],
> +)
> +
> +meson.override_dependency('bilge-0.2-rs', bilge_dep)
> diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/sub=
projects/packagefiles/bilge-impl-0.2-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..80243c7024d898826cc3c98ba=
5b78ef286b79ce9
> --- /dev/null
> +++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> @@ -0,0 +1,45 @@
> +project('bilge-impl-0.2-rs', 'rust',
> +  version: '0.2.0',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('itertools-0.11-rs', required: true)
> +subproject('proc-macro-error-attr-1-rs', required: true)
> +subproject('proc-macro-error-1-rs', required: true)
> +subproject('quote-1-rs', required: true)
> +subproject('syn-2-rs', required: true)
> +subproject('proc-macro2-1-rs', required: true)
> +
> +itertools_dep =3D dependency('itertools-0.11-rs', native: true)
> +proc_macro_error_attr_dep =3D dependency('proc-macro-error-attr-1-rs', n=
ative: true)
> +proc_macro_error_dep =3D dependency('proc-macro-error-1-rs', native: tru=
e)
> +quote_dep =3D dependency('quote-1-rs', native: true)
> +syn_dep =3D dependency('syn-2-rs', native: true)
> +proc_macro2_dep =3D dependency('proc-macro2-1-rs', native: true)
> +
> +rust =3D import('rust')
> +
> +_bilge_impl_rs =3D rust.proc_macro(
> +  'bilge_impl',
> +  files('src/lib.rs'),
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_args: [
> +    '--cfg', 'use_fallback',
> +    '--cfg', 'feature=3D"syn-error"',
> +    '--cfg', 'feature=3D"proc-macro"',
> +  ],
> +  dependencies: [
> +    itertools_dep,
> +    proc_macro_error_attr_dep,
> +    proc_macro_error_dep,
> +    quote_dep,
> +    syn_dep,
> +    proc_macro2_dep,
> +  ],
> +)
> +
> +bilge_impl_dep =3D declare_dependency(
> +  link_with: _bilge_impl_rs,
> +)
> +
> +meson.override_dependency('bilge-impl-0.2-rs', bilge_impl_dep)
> diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojec=
ts/packagefiles/either-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..a5842eb3a6a63cf9488366375=
8ca5eb11225ad58
> --- /dev/null
> +++ b/subprojects/packagefiles/either-1-rs/meson.build
> @@ -0,0 +1,24 @@
> +project('either-1-rs', 'rust',
> +  version: '1.12.0',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +_either_rs =3D static_library(
> +  'either',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2018', 'build.rust_std=3D2018'],
> +  rust_abi: 'rust',
> +  rust_args: [
> +    '--cfg', 'feature=3D"use_std"',
> +    '--cfg', 'feature=3D"use_alloc"',
> +  ],
> +  dependencies: [],
> +  native: true,
> +)
> +
> +either_dep =3D declare_dependency(
> +  link_with: _either_rs,
> +)
> +
> +meson.override_dependency('either-1-rs', either_dep, native: true)
> diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/sub=
projects/packagefiles/itertools-0.11-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..13d2d27019d215fb793c457e4=
94be7387a7ef455
> --- /dev/null
> +++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
> @@ -0,0 +1,30 @@
> +project('itertools-0.11-rs', 'rust',
> +  version: '0.11.0',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('either-1-rs', required: true)
> +
> +either_dep =3D dependency('either-1-rs', native: true)
> +
> +_itertools_rs =3D static_library(
> +  'itertools',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2018', 'build.rust_std=3D2018'],
> +  rust_abi: 'rust',
> +  rust_args: [
> +    '--cfg', 'feature=3D"use_std"',
> +    '--cfg', 'feature=3D"use_alloc"',
> +  ],
> +  dependencies: [
> +    either_dep,
> +  ],
> +  native: true,
> +)
> +
> +itertools_dep =3D declare_dependency(
> +  link_with: _itertools_rs,
> +)
> +
> +meson.override_dependency('itertools-0.11-rs', itertools_dep, native: tr=
ue)
> diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b=
/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..38ea7b89d39d3f131959f0066=
5b51a49d5bc95e5
> --- /dev/null
> +++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> @@ -0,0 +1,40 @@
> +project('proc-macro-error-1-rs', 'rust',
> +  version: '1.0.4',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('proc-macro-error-attr-1-rs', required: true)
> +subproject('quote-1-rs', required: true)
> +subproject('syn-2-rs', required: true)
> +subproject('proc-macro2-1-rs', required: true)
> +
> +proc_macro_error_attr_dep =3D dependency('proc-macro-error-attr-1-rs', n=
ative: true)
> +proc_macro2_dep =3D dependency('proc-macro2-1-rs', native: true)
> +quote_dep =3D dependency('quote-1-rs', native: true)
> +syn_dep =3D dependency('syn-2-rs', native: true)
> +
> +_proc_macro_error_rs =3D static_library(
> +  'proc_macro_error',
> +  files('src/lib.rs'),
> +  override_options: ['rust_std=3D2018', 'build.rust_std=3D2018'],
> +  rust_abi: 'rust',
> +  rust_args: [
> +    '--cfg', 'use_fallback',
> +    '--cfg', 'feature=3D"syn-error"',
> +    '--cfg', 'feature=3D"proc-macro"',
> +    '-A', 'non_fmt_panics'
> +  ],
> +  dependencies: [
> +    proc_macro_error_attr_dep,
> +    proc_macro2_dep,
> +    quote_dep,
> +    syn_dep,
> +  ],
> +  native: true,
> +)
> +
> +proc_macro_error_dep =3D declare_dependency(
> +  link_with: _proc_macro_error_rs,
> +)
> +
> +meson.override_dependency('proc-macro-error-1-rs', proc_macro_error_dep,=
 native: true)
> diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.bu=
ild b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..d900c54cfd1ad6c8c415438c2=
e9dd51695c82150
> --- /dev/null
> +++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> @@ -0,0 +1,32 @@
> +project('proc-macro-error-attr-1-rs', 'rust',
> +  version: '1.12.0',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('proc-macro2-1-rs', required: true)
> +subproject('quote-1-rs', required: true)
> +
> +proc_macro2_dep =3D dependency('proc-macro2-1-rs', native: true)
> +quote_dep =3D dependency('quote-1-rs', native: true)
> +
> +rust =3D import('rust')
> +_proc_macro_error_attr_rs =3D rust.proc_macro(
> +  'proc_macro_error_attr',
> +  files('src/lib.rs'),
> +  override_options: ['rust_std=3D2018', 'build.rust_std=3D2018'],
> +  rust_args: [
> +    '--cfg', 'use_fallback',
> +    '--cfg', 'feature=3D"syn-error"',
> +    '--cfg', 'feature=3D"proc-macro"'
> +  ],
> +  dependencies: [
> +    proc_macro2_dep,
> +    quote_dep,
> +  ],
> +)
> +
> +proc_macro_error_attr_dep =3D declare_dependency(
> +  link_with: _proc_macro_error_attr_rs,
> +)
> +
> +meson.override_dependency('proc-macro-error-attr-1-rs', proc_macro_error=
_attr_dep, native: true)
> diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subp=
rojects/packagefiles/proc-macro2-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..818ec59336b81ac7dd76a2317=
357c7b276cf490b
> --- /dev/null
> +++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> @@ -0,0 +1,31 @@
> +project('proc-macro2-1-rs', 'rust',
> +  version: '1.0.84',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('unicode-ident-1-rs', required: true)
> +
> +unicode_ident_dep =3D dependency('unicode-ident-1-rs', native: true)
> +
> +_proc_macro2_rs =3D static_library(
> +  'proc_macro2',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi: 'rust',
> +  rust_args: [
> +    '--cfg', 'feature=3D"proc-macro"',
> +    '--cfg', 'span_locations',
> +    '--cfg', 'wrap_proc_macro',
> +  ],
> +  dependencies: [
> +    unicode_ident_dep,
> +  ],
> +  native: true,
> +)
> +
> +proc_macro2_dep =3D declare_dependency(
> +  link_with: _proc_macro2_rs,
> +)
> +
> +meson.override_dependency('proc-macro2-1-rs', proc_macro2_dep, native: t=
rue)
> diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subproject=
s/packagefiles/quote-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..d36609bd3c8aa7df95eb29266=
1dd293fbe7320b0
> --- /dev/null
> +++ b/subprojects/packagefiles/quote-1-rs/meson.build
> @@ -0,0 +1,29 @@
> +project('quote-1-rs', 'rust',
> +  version: '1.12.0',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('proc-macro2-1-rs', required: true)
> +
> +proc_macro2_dep =3D dependency('proc-macro2-1-rs', native: true)
> +
> +_quote_rs =3D static_library(
> +  'quote',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi: 'rust',
> +  rust_args: [
> +    '--cfg', 'feature=3D"proc-macro"',
> +  ],
> +  dependencies: [
> +    proc_macro2_dep,
> +  ],
> +  native: true,
> +)
> +
> +quote_dep =3D declare_dependency(
> +  link_with: _quote_rs,
> +)
> +
> +meson.override_dependency('quote-1-rs', quote_dep, native: true)
> diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/=
packagefiles/syn-2-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..a53335f3092e06723039513a1=
bf5a0d35b4afcd7
> --- /dev/null
> +++ b/subprojects/packagefiles/syn-2-rs/meson.build
> @@ -0,0 +1,40 @@
> +project('syn-2-rs', 'rust',
> +  version: '2.0.66',
> +  license: 'MIT OR Apache-2.0',
> +  default_options: [])
> +
> +subproject('proc-macro2-1-rs', required: true)
> +subproject('quote-1-rs', required: true)
> +subproject('unicode-ident-1-rs', required: true)
> +
> +proc_macro2_dep =3D dependency('proc-macro2-1-rs', native: true)
> +quote_dep =3D dependency('quote-1-rs', native: true)
> +unicode_ident_dep =3D dependency('unicode-ident-1-rs', native: true)
> +
> +_syn_rs =3D static_library(
> +  'syn',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi: 'rust',
> +  rust_args: [
> +    '--cfg', 'feature=3D"full"',
> +    '--cfg', 'feature=3D"derive"',
> +    '--cfg', 'feature=3D"parsing"',
> +    '--cfg', 'feature=3D"printing"',
> +    '--cfg', 'feature=3D"clone-impls"',
> +    '--cfg', 'feature=3D"proc-macro"',
> +  ],
> +  dependencies: [
> +    quote_dep,
> +    proc_macro2_dep,
> +    unicode_ident_dep,
> +  ],
> +  native: true,
> +)
> +
> +syn_dep =3D declare_dependency(
> +  link_with: _syn_rs,
> +)
> +
> +meson.override_dependency('syn-2-rs', syn_dep, native: true)
> diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/su=
bprojects/packagefiles/unicode-ident-1-rs/meson.build
> new file mode 100644
> index 0000000000000000000000000000000000000000..54f2376854504236689604f8a=
b08d351e4cceae9
> --- /dev/null
> +++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
> @@ -0,0 +1,20 @@
> +project('unicode-ident-1-rs', 'rust',
> +  version: '1.0.12',
> +  license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
> +  default_options: [])
> +
> +_unicode_ident_rs =3D static_library(
> +  'unicode_ident',
> +  files('src/lib.rs'),
> +  gnu_symbol_visibility: 'hidden',
> +  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
> +  rust_abi: 'rust',
> +  dependencies: [],
> +  native: true,
> +)
> +
> +unicode_ident_dep =3D declare_dependency(
> +  link_with: _unicode_ident_rs,
> +)
> +
> +meson.override_dependency('unicode-ident-1-rs', unicode_ident_dep, nativ=
e: true)
> diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-ma=
cro-error-1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..b7db03b06a019562b2ad77bb2=
52d50b7e83c0b33
> --- /dev/null
> +++ b/subprojects/proc-macro-error-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D proc-macro-error-1.0.4
> +source_url =3D https://crates.io/api/v1/crates/proc-macro-error/1.0.4/do=
wnload
> +source_filename =3D proc-macro-error-1.0.4.tar.gz
> +source_hash =3D da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a7=
3a5ce38c
> +#method =3D cargo
> +patch_directory =3D proc-macro-error-1-rs
> diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/pr=
oc-macro-error-attr-1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..d13d8a239ac259132cd905bc5=
12e9024b2f30fb8
> --- /dev/null
> +++ b/subprojects/proc-macro-error-attr-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D proc-macro-error-attr-1.0.4
> +source_url =3D https://crates.io/api/v1/crates/proc-macro-error-attr/1.0=
.4/download
> +source_filename =3D proc-macro-error-attr-1.0.4.tar.gz
> +source_hash =3D a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a5527=
4b35f869
> +#method =3D cargo
> +patch_directory =3D proc-macro-error-attr-1-rs
> diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-=
1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..7053e2c013c6d6be9efa5dd99=
cb43b5906a772d3
> --- /dev/null
> +++ b/subprojects/proc-macro2-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D proc-macro2-1.0.84
> +source_url =3D https://crates.io/api/v1/crates/proc-macro2/1.0.84/downlo=
ad
> +source_filename =3D proc-macro2-1.0.84.0.tar.gz
> +source_hash =3D ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12=
024a49d6
> +#method =3D cargo
> +patch_directory =3D proc-macro2-1-rs
> diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e7ea69049f83d51190cef867=
cec1adc202f77db
> --- /dev/null
> +++ b/subprojects/quote-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D quote-1.0.36
> +source_url =3D https://crates.io/api/v1/crates/quote/1.0.36/download
> +source_filename =3D quote-1.0.36.0.tar.gz
> +source_hash =3D 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad42=
08acaca7
> +#method =3D cargo
> +patch_directory =3D quote-1-rs
> diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..13ffdac3c3b1bbed2f568a263=
8c3dfe20dbc0748
> --- /dev/null
> +++ b/subprojects/syn-2-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D syn-2.0.66
> +source_url =3D https://crates.io/api/v1/crates/syn/2.0.66/download
> +source_filename =3D syn-2.0.66.0.tar.gz
> +source_hash =3D c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5=
f3cdcff5
> +#method =3D cargo
> +patch_directory =3D syn-2-rs
> diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-id=
ent-1-rs.wrap
> new file mode 100644
> index 0000000000000000000000000000000000000000..4609f96ed970a64bf0f9d06b2=
9bcc9985a907c3d
> --- /dev/null
> +++ b/subprojects/unicode-ident-1-rs.wrap
> @@ -0,0 +1,7 @@
> +[wrap-file]
> +directory =3D unicode-ident-1.0.12
> +source_url =3D https://crates.io/api/v1/crates/unicode-ident/1.0.12/down=
load
> +source_filename =3D unicode-ident-1.0.12.tar.gz
> +source_hash =3D 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4faceb=
ec0fee4b
> +#method =3D cargo
> +patch_directory =3D unicode-ident-1-rs
>
> --
> 2.45.2
>


