Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77563CE8E7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yR3-00077h-DC; Thu, 24 Oct 2024 10:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yR1-00077S-IK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:31 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yQw-0003ta-Oi
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so138846866b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778604; x=1730383404; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HPZlkGUuKhNgrlgtDwPVRTmR3FzHv6w6ni5BQKVW4Eo=;
 b=ggc4LzILeaevjDszboJ6LXuAtIkPdKnn9HAshFxf+usFg88nRF/oIFgEul1uYAXGWs
 AX+qgDGIzGM48TMB13YM6WDmkW86d5CDlSG04IkSRpURJNjJp5B88k3V/V7pV0EkG3t2
 oVFAHqE/5OhvbnTLyAKUwwooK//wQmCQeGHx/dUaSYnuCNtMLnwftT76xABZ6IEcPG2B
 wIqrNDl/QVBzsqRIzjeXLeIykKkP+H3o0imNiXMVdSqCig+3SB4TydicnHb3/x+zpyoA
 Dvpa+CuzIpQk6fllQAh/akAIezsCOWNfC1brhtdoE5YkkVnHUB0rYKfGYbdoX+WhKI81
 976w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778604; x=1730383404;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPZlkGUuKhNgrlgtDwPVRTmR3FzHv6w6ni5BQKVW4Eo=;
 b=AuW9X4duEQmNGA6/n/Lob8ywR7Df9us6mzwkplYJX2nrgV6764BTZ+Od1wR2idT5A6
 c0lbgDM8Hhao6XcjV8l3/z8V5/Sso2KZ2Y13evp+Z7Fo4QdyLzRFyMKWZ7K13SO83Fyk
 k+RfV4TdmXb1JWi3Auo5I4izULKppF9fbimgdq/YdAYL2q22xBhASbXlfTk8aIhMELG2
 VKr8eJLhDQa6CgmfpcMSgxSJZa/4T6VLLPBdaDAy5llqsujaVQvRdo+25bXGP1J505B9
 Asmw/1H7OmBSg/WzfM+yYKdUjpwXi8sV7wzvDRKkaTAPDzESw+lM6yTm68KuFinnizT+
 qHXw==
X-Gm-Message-State: AOJu0YzR/5V/rqR5R7+fSsb84cmuAyQRda2AtPR13ntBV03kKEhUu7xE
 v8ALCnTepWorfFFRLPDepZyoD1WmLx7owCP+bVFGFvkwtFiyhLWuddokVd1YBOg=
X-Google-Smtp-Source: AGHT+IEyn0iRCkHaoWwSuxxZOwlzKawvb2U9lzYfag7HyT43DvUtPZxckVo9n9eh6337RRiCWbNv1w==
X-Received: by 2002:a17:907:6d29:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a9ad2711791mr174482866b.11.1729778602864; 
 Thu, 24 Oct 2024 07:03:22 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:22 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:02:59 +0300
Subject: [PATCH 01/11] Revert "rust: add PL011 device model"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241024-rust-round-2-v1-1-051e7a25b978@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=84372;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=FGMhTFmzdJgWKFqcTqIrpxOXCBEYBfopxSuG8TgVq8I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9paFF2R2prcDhWZTlRMzVBMVJkVUJYTWEyCmZRVFF0d3lOaFZpajQ4R1RB
 Tk9KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG9nQUt
 DUkIzS2Nkd2YzNEowTEdHRC85SUludzhraXlsbUhYZ3p3MGc3YVJyU3gxWjVkV2V1am1HVVVEVw
 o4Mk5NOUxoVk43MzhVVmRWRHdGbTdzSkhHM3JyQjIrL3NnL1VwQXhoeTFCd00yRGRqbFdCV3B3T
 kxTa0ZTaityCng1LzlLZGxhd3FoeE9TVG5LRlZsQ0dxVnEwREdaejJhOXBjTjlDeDdvUXhrcmxH
 aTRyT0ZRcWFpalptNC84a1kKWG5lMDdGTmxBZkhvUHpUckcwcVNsalFjU3drZ0FnaG9yRkxRYmt
 xQm9iYmd3MW1peFBMTExlT3E5Uzk2Q3lDNwpPTno0QzdraXFIbnJCYlErQzhXNTU5Rm9DSVMvdU
 lpeWtMbkh4T0o3MTFNV1ZIQ3kyMVBoQmlNZXErWHV6Ny9JCmlyd29lRnZWMjdNeTlqSmxDNnN6L
 01ETU1RVjdySmp2VzFzalBPSFRKcVFIRTVZZ29nQ1VtTS9TYnc4WkNLZ3MKbHZlZmEzSlhCY0tF
 TGc3OWZDNGNNNkxBM0kxcmR2YWVZMjBnWU4wdFZvSzhqOG5SVTkzeERKSVJSRFRESWM1RQpyL1l
 jM0VTeUdUcGYyZVEyRncvazd0RW5NYzAyMExWK0t4MlloQWN3ZjgwUWdldmVoMXJpRDBOTFRQRm
 ErZVQ1Cjkza1hpTHA1MGY0YmJXKy9zcmlkdlN1dkVXM1VCTFhBa3gveU9PSGNFeTNFUUEzRVlDN
 kkrUVFRYm1qZjhLYWIKZXk4Qys3Rk9heHhPbXRPSGRzb1pWWnRNaUFqUXIzVFBYeFhzTXRwMzBo
 VVMxTlp0YU9pT3QrSWxRY0wrOGRwRwo5SGRRSkk3Sk1aQVFBVkY5NWtvWXF6czdrd1hCaVNtZUU
 za3d0bFhudVVNeTZRQkVkcXZJYysvTmNzOVg0N1ZLCnNIR1RFdz09Cj1pTXF0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Patch was applied with invalid authorship by accident, which confuses
git tooling that look at git blame for contributors etc.

Patch will be re-applied with correct authorship right after this
commit.

This reverts commit d0f0cd5b1f7e9780753344548e17ad4df9fcf5d8.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                                        |   5 -
 meson.build                                        |  24 -
 hw/arm/Kconfig                                     |  30 +-
 rust/Kconfig                                       |   1 -
 rust/hw/Kconfig                                    |   2 -
 rust/hw/char/Kconfig                               |   3 -
 rust/hw/char/meson.build                           |   1 -
 rust/hw/char/pl011/.gitignore                      |   2 -
 rust/hw/char/pl011/Cargo.lock                      | 134 -----
 rust/hw/char/pl011/Cargo.toml                      |  26 -
 rust/hw/char/pl011/README.md                       |  31 --
 rust/hw/char/pl011/meson.build                     |  26 -
 rust/hw/char/pl011/src/device.rs                   | 599 ---------------------
 rust/hw/char/pl011/src/device_class.rs             |  70 ---
 rust/hw/char/pl011/src/lib.rs                      | 586 --------------------
 rust/hw/char/pl011/src/memory_ops.rs               |  59 --
 rust/hw/meson.build                                |   1 -
 rust/meson.build                                   |   2 -
 scripts/archive-source.sh                          |   4 +-
 scripts/make-release                               |   4 +-
 scripts/rust/rust_root_crate.sh                    |  13 -
 subprojects/.gitignore                             |   7 -
 subprojects/arbitrary-int-1-rs.wrap                |   7 -
 subprojects/bilge-0.2-rs.wrap                      |   7 -
 subprojects/bilge-impl-0.2-rs.wrap                 |   7 -
 subprojects/either-1-rs.wrap                       |   7 -
 subprojects/itertools-0.11-rs.wrap                 |   7 -
 .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 -
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 -
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 --
 subprojects/packagefiles/either-1-rs/meson.build   |  24 -
 .../packagefiles/itertools-0.11-rs/meson.build     |  30 --
 .../packagefiles/proc-macro-error-1-rs/meson.build |  40 --
 .../proc-macro-error-attr-1-rs/meson.build         |  32 --
 .../packagefiles/unicode-ident-1-rs/meson.build    |  20 -
 subprojects/proc-macro-error-1-rs.wrap             |   7 -
 subprojects/proc-macro-error-attr-1-rs.wrap        |   7 -
 37 files changed, 12 insertions(+), 1906 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3bfa132fd6ecd61dd733b760a5e1ccd39613455..793c683aa6cccafca9c98b74b9a20d84211f041b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1137,11 +1137,6 @@ F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
 F: docs/system/arm/nrf.rst
 
-ARM PL011 Rust device
-M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-S: Maintained
-F: rust/hw/char/pl011/
-
 AVR Machines
 -------------
 
diff --git a/meson.build b/meson.build
index c26c417de16ad9256a019a90fd89ea990bb3f948..0d617c551e61c90c7c357c62ff5da34437723947 100644
--- a/meson.build
+++ b/meson.build
@@ -3520,7 +3520,6 @@ qom_ss = ss.source_set()
 system_ss = ss.source_set()
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
-rust_devices_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -4068,29 +4067,6 @@ foreach target : target_dirs
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
-  if have_rust and have_system
-    target_rust = rust_devices_ss.apply(config_target, strict: false)
-    crates = []
-    foreach dep : target_rust.dependencies()
-      crates += dep.get_variable('crate')
-    endforeach
-    if crates.length() > 0
-      rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
-                              output: 'rust_' + target.underscorify() + '.rs',
-                              command: [find_program('scripts/rust/rust_root_crate.sh')] + crates,
-                              capture: true,
-                              build_by_default: true,
-                              build_always_stale: true)
-      rlib = static_library('rust_' + target.underscorify(),
-                            rlib_rs,
-                            dependencies: target_rust.dependencies(),
-                            override_options: ['rust_std=2021', 'build.rust_std=2021'],
-                            rust_args: rustc_args,
-                            rust_abi: 'c')
-      arch_deps += declare_dependency(link_whole: [rlib])
-    endif
-  endif
-
   # allow using headers from the dependencies but do not include the sources,
   # because this emulator only needs those in "objects".  For external
   # dependencies, the full dependency is included below in the executable.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e7fd9338d11dadb7a18032c674927db3d9887bdd..53eb7bb3d0157bb6e8e078fe73ec66015ae0fe13 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -20,8 +20,7 @@ config ARM_VIRT
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
     select GPIO_PWR
@@ -74,8 +73,7 @@ config HIGHBANK
     select AHCI
     select ARM_TIMER # sp804
     select ARM_V7M
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL022 # SPI
     select PL031 # RTC
     select PL061 # GPIO
@@ -88,8 +86,7 @@ config INTEGRATOR
     depends on TCG && ARM
     select ARM_TIMER
     select INTEGRATOR_DEBUG
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031 # RTC
     select PL041 # audio
     select PL050 # keyboard/mouse
@@ -107,8 +104,7 @@ config MUSCA
     default y
     depends on TCG && ARM
     select ARMSSE
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011
     select PL031
     select SPLIT_IRQ
     select UNIMP
@@ -172,8 +168,7 @@ config REALVIEW
     select WM8750 # audio codec
     select LSI_SCSI_PCI
     select PCI
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011  # UART
     select PL031  # RTC
     select PL041  # audio codec
     select PL050  # keyboard/mouse
@@ -198,8 +193,7 @@ config SBSA_REF
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
     select USB_XHCI_SYSBUS
@@ -223,8 +217,7 @@ config STELLARIS
     select ARM_V7M
     select CMSDK_APB_WATCHDOG
     select I2C
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL022 # SPI
     select PL061 # GPIO
     select SSD0303 # OLED display
@@ -284,8 +277,7 @@ config VEXPRESS
     select ARM_TIMER # sp804
     select LAN9118
     select PFLASH_CFI01
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL041 # audio codec
     select PL181  # display
     select REALVIEW
@@ -370,8 +362,7 @@ config RASPI
     default y
     depends on TCG && ARM
     select FRAMEBUFFER
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select SDHCI
     select USB_DWC2
     select BCM2835_SPI
@@ -447,8 +438,7 @@ config XLNX_VERSAL
     select ARM_GIC
     select CPU_CLUSTER
     select DEVICE_TREE
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011
     select CADENCE
     select VIRTIO_MMIO
     select UNIMP
diff --git a/rust/Kconfig b/rust/Kconfig
index f9f5c3909887451f71360a7986d79e57fdb43c91..e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 100644
--- a/rust/Kconfig
+++ b/rust/Kconfig
@@ -1 +0,0 @@
-source hw/Kconfig
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
deleted file mode 100644
index 4d934f30afe13ddff418db8ec9e8b8eb25a9e8d0..0000000000000000000000000000000000000000
--- a/rust/hw/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-# devices Kconfig
-source char/Kconfig
diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
deleted file mode 100644
index a1732a9e97fe3211547e30bc9319382e6394ed5b..0000000000000000000000000000000000000000
--- a/rust/hw/char/Kconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-config X_PL011_RUST
-    bool
-    default y if HAVE_RUST
diff --git a/rust/hw/char/meson.build b/rust/hw/char/meson.build
deleted file mode 100644
index 5716dc43ef6facdcf1cc963108347bbf4d12cf0e..0000000000000000000000000000000000000000
--- a/rust/hw/char/meson.build
+++ /dev/null
@@ -1 +0,0 @@
-subdir('pl011')
diff --git a/rust/hw/char/pl011/.gitignore b/rust/hw/char/pl011/.gitignore
deleted file mode 100644
index 71eaff2035d5a65b57ae32dfeecf3d87bbc7b396..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# Ignore generated bindings file overrides.
-src/bindings.rs.inc
diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
deleted file mode 100644
index b58cebb186e99efe184117bb931a341543d4466b..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/Cargo.lock
+++ /dev/null
@@ -1,134 +0,0 @@
-# This file is automatically @generated by Cargo.
-# It is not intended for manual editing.
-version = 3
-
-[[package]]
-name = "arbitrary-int"
-version = "1.2.7"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
-
-[[package]]
-name = "bilge"
-version = "0.2.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57"
-dependencies = [
- "arbitrary-int",
- "bilge-impl",
-]
-
-[[package]]
-name = "bilge-impl"
-version = "0.2.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8"
-dependencies = [
- "itertools",
- "proc-macro-error",
- "proc-macro2",
- "quote",
- "syn",
-]
-
-[[package]]
-name = "either"
-version = "1.12.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
-
-[[package]]
-name = "itertools"
-version = "0.11.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
-dependencies = [
- "either",
-]
-
-[[package]]
-name = "pl011"
-version = "0.1.0"
-dependencies = [
- "bilge",
- "bilge-impl",
- "qemu_api",
- "qemu_api_macros",
-]
-
-[[package]]
-name = "proc-macro-error"
-version = "1.0.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
-dependencies = [
- "proc-macro-error-attr",
- "proc-macro2",
- "quote",
- "version_check",
-]
-
-[[package]]
-name = "proc-macro-error-attr"
-version = "1.0.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
-dependencies = [
- "proc-macro2",
- "quote",
- "version_check",
-]
-
-[[package]]
-name = "proc-macro2"
-version = "1.0.84"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
-dependencies = [
- "unicode-ident",
-]
-
-[[package]]
-name = "qemu_api"
-version = "0.1.0"
-
-[[package]]
-name = "qemu_api_macros"
-version = "0.1.0"
-dependencies = [
- "proc-macro2",
- "quote",
- "syn",
-]
-
-[[package]]
-name = "quote"
-version = "1.0.36"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-dependencies = [
- "proc-macro2",
-]
-
-[[package]]
-name = "syn"
-version = "2.0.66"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
-dependencies = [
- "proc-macro2",
- "quote",
- "unicode-ident",
-]
-
-[[package]]
-name = "unicode-ident"
-version = "1.0.12"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-
-[[package]]
-name = "version_check"
-version = "0.9.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
deleted file mode 100644
index b089e3dded623131ee13b4af8145b84388755df7..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/Cargo.toml
+++ /dev/null
@@ -1,26 +0,0 @@
-[package]
-name = "pl011"
-version = "0.1.0"
-edition = "2021"
-authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
-readme = "README.md"
-homepage = "https://www.qemu.org"
-description = "pl011 device model for QEMU"
-repository = "https://gitlab.com/epilys/rust-for-qemu"
-resolver = "2"
-publish = false
-keywords = []
-categories = []
-
-[lib]
-crate-type = ["staticlib"]
-
-[dependencies]
-bilge = { version = "0.2.0" }
-bilge-impl = { version = "0.2.0" }
-qemu_api = { path = "../../../qemu-api" }
-qemu_api_macros = { path = "../../../qemu-api-macros" }
-
-# Do not include in any global workspace
-[workspace]
diff --git a/rust/hw/char/pl011/README.md b/rust/hw/char/pl011/README.md
deleted file mode 100644
index cd7dea31634241cbf96b0be13f21d52bbd8ae750..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/README.md
+++ /dev/null
@@ -1,31 +0,0 @@
-# PL011 QEMU Device Model
-
-This library implements a device model for the PrimeCell® UART (PL011)
-device in QEMU.
-
-## Build static lib
-
-Host build target must be explicitly specified:
-
-```sh
-cargo build --target x86_64-unknown-linux-gnu
-```
-
-Replace host target triplet if necessary.
-
-## Generate Rust documentation
-
-To generate docs for this crate, including private items:
-
-```sh
-cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
-```
-
-To include direct dependencies like `bilge` (bitmaps for register types):
-
-```sh
-cargo tree --depth 1 -e normal --prefix none \
- | cut -d' ' -f1 \
- | xargs printf -- '-p %s\n' \
- | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
-```
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
deleted file mode 100644
index 547cca5a96f7eef284caf1949380b65f7d015d92..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/meson.build
+++ /dev/null
@@ -1,26 +0,0 @@
-subproject('bilge-0.2-rs', required: true)
-subproject('bilge-impl-0.2-rs', required: true)
-
-bilge_dep = dependency('bilge-0.2-rs')
-bilge_impl_dep = dependency('bilge-impl-0.2-rs')
-
-_libpl011_rs = static_library(
-  'pl011',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [
-    bilge_dep,
-    bilge_impl_dep,
-    qemu_api,
-    qemu_api_macros,
-  ],
-)
-
-rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
-  link_whole: [_libpl011_rs],
-  # Putting proc macro crates in `dependencies` is necessary for Meson to find
-  # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_dep, qemu_api_macros],
-  variables: {'crate': 'pl011'},
-)])
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
deleted file mode 100644
index c7193b41beec0b177dbc75ac0e43fcfea4c82bfb..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/src/device.rs
+++ /dev/null
@@ -1,599 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use core::{
-    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
-    ptr::{addr_of, addr_of_mut, NonNull},
-};
-
-use qemu_api::{
-    bindings::{self, *},
-    definitions::ObjectImpl,
-};
-
-use crate::{
-    memory_ops::PL011_OPS,
-    registers::{self, Interrupt},
-    RegisterOffset,
-};
-
-static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
-
-const DATA_BREAK: u32 = 1 << 10;
-
-/// QEMU sourced constant.
-pub const PL011_FIFO_DEPTH: usize = 16_usize;
-
-#[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
-/// PL011 Device Model in QEMU
-pub struct PL011State {
-    pub parent_obj: SysBusDevice,
-    pub iomem: MemoryRegion,
-    #[doc(alias = "fr")]
-    pub flags: registers::Flags,
-    #[doc(alias = "lcr")]
-    pub line_control: registers::LineControl,
-    #[doc(alias = "rsr")]
-    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
-    #[doc(alias = "cr")]
-    pub control: registers::Control,
-    pub dmacr: u32,
-    pub int_enabled: u32,
-    pub int_level: u32,
-    pub read_fifo: [u32; PL011_FIFO_DEPTH],
-    pub ilpr: u32,
-    pub ibrd: u32,
-    pub fbrd: u32,
-    pub ifl: u32,
-    pub read_pos: usize,
-    pub read_count: usize,
-    pub read_trigger: usize,
-    #[doc(alias = "chr")]
-    pub char_backend: CharBackend,
-    /// QEMU interrupts
-    ///
-    /// ```text
-    ///  * sysbus MMIO region 0: device registers
-    ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
-    ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
-    ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
-    ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
-    ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
-    ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
-    /// ```
-    #[doc(alias = "irq")]
-    pub interrupts: [qemu_irq; 6usize],
-    #[doc(alias = "clk")]
-    pub clock: NonNull<Clock>,
-    #[doc(alias = "migrate_clk")]
-    pub migrate_clock: bool,
-}
-
-impl ObjectImpl for PL011State {
-    type Class = PL011Class;
-    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
-    const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
-    const ABSTRACT: bool = false;
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-}
-
-#[repr(C)]
-pub struct PL011Class {
-    _inner: [u8; 0],
-}
-
-impl qemu_api::definitions::Class for PL011Class {
-    const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-    > = Some(crate::device_class::pl011_class_init);
-    const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-    > = None;
-}
-
-#[used]
-pub static CLK_NAME: &CStr = c"clk";
-
-impl PL011State {
-    /// Initializes a pre-allocated, unitialized instance of `PL011State`.
-    ///
-    /// # Safety
-    ///
-    /// `self` must point to a correctly sized and aligned location for the
-    /// `PL011State` type. It must not be called more than once on the same
-    /// location/instance. All its fields are expected to hold unitialized
-    /// values with the sole exception of `parent_obj`.
-    pub unsafe fn init(&mut self) {
-        let dev = addr_of_mut!(*self).cast::<DeviceState>();
-        // SAFETY:
-        //
-        // self and self.iomem are guaranteed to be valid at this point since callers
-        // must make sure the `self` reference is valid.
-        unsafe {
-            memory_region_init_io(
-                addr_of_mut!(self.iomem),
-                addr_of_mut!(*self).cast::<Object>(),
-                &PL011_OPS,
-                addr_of_mut!(*self).cast::<c_void>(),
-                Self::TYPE_INFO.name,
-                0x1000,
-            );
-            let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
-            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
-            for irq in self.interrupts.iter_mut() {
-                sysbus_init_irq(sbd, irq);
-            }
-        }
-        // SAFETY:
-        //
-        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
-        // we can overwrite the undefined value without side effects. This is
-        // safe since all PL011State instances are created by QOM code which
-        // calls this function to initialize the fields; therefore no code is
-        // able to access an invalid self.clock value.
-        unsafe {
-            self.clock = NonNull::new(qdev_init_clock_in(
-                dev,
-                CLK_NAME.as_ptr(),
-                None, /* pl011_clock_update */
-                addr_of_mut!(*self).cast::<c_void>(),
-                ClockEvent::ClockUpdate.0,
-            ))
-            .unwrap();
-        }
-    }
-
-    pub fn read(
-        &mut self,
-        offset: hwaddr,
-        _size: core::ffi::c_uint,
-    ) -> std::ops::ControlFlow<u64, u64> {
-        use RegisterOffset::*;
-
-        std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
-            Err(v) if (0x3f8..0x400).contains(&v) => {
-                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
-            }
-            Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
-                0
-            }
-            Ok(DR) => {
-                // s->flags &= ~PL011_FLAG_RXFF;
-                self.flags.set_receive_fifo_full(false);
-                let c = self.read_fifo[self.read_pos];
-                if self.read_count > 0 {
-                    self.read_count -= 1;
-                    self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
-                }
-                if self.read_count == 0 {
-                    // self.flags |= PL011_FLAG_RXFE;
-                    self.flags.set_receive_fifo_empty(true);
-                }
-                if self.read_count + 1 == self.read_trigger {
-                    //self.int_level &= ~ INT_RX;
-                    self.int_level &= !registers::INT_RX;
-                }
-                // Update error bits.
-                self.receive_status_error_clear = c.to_be_bytes()[3].into();
-                self.update();
-                // Must call qemu_chr_fe_accept_input, so return Continue:
-                return std::ops::ControlFlow::Continue(c.into());
-            }
-            Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
-            Ok(FR) => u16::from(self.flags).into(),
-            Ok(FBRD) => self.fbrd.into(),
-            Ok(ILPR) => self.ilpr.into(),
-            Ok(IBRD) => self.ibrd.into(),
-            Ok(LCR_H) => u16::from(self.line_control).into(),
-            Ok(CR) => {
-                // We exercise our self-control.
-                u16::from(self.control).into()
-            }
-            Ok(FLS) => self.ifl.into(),
-            Ok(IMSC) => self.int_enabled.into(),
-            Ok(RIS) => self.int_level.into(),
-            Ok(MIS) => u64::from(self.int_level & self.int_enabled),
-            Ok(ICR) => {
-                // "The UARTICR Register is the interrupt clear register and is write-only"
-                // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
-                0
-            }
-            Ok(DMACR) => self.dmacr.into(),
-        })
-    }
-
-    pub fn write(&mut self, offset: hwaddr, value: u64) {
-        // eprintln!("write offset {offset} value {value}");
-        use RegisterOffset::*;
-        let value: u32 = value as u32;
-        match RegisterOffset::try_from(offset) {
-            Err(_bad_offset) => {
-                eprintln!("write bad offset {offset} value {value}");
-            }
-            Ok(DR) => {
-                // ??? Check if transmitter is enabled.
-                let ch: u8 = value as u8;
-                // XXX this blocks entire thread. Rewrite to use
-                // qemu_chr_fe_write and background I/O callbacks
-
-                // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-                // initialized in realize().
-                unsafe {
-                    qemu_chr_fe_write_all(addr_of_mut!(self.char_backend), &ch, 1);
-                }
-                self.loopback_tx(value);
-                self.int_level |= registers::INT_TX;
-                self.update();
-            }
-            Ok(RSR) => {
-                self.receive_status_error_clear = 0.into();
-            }
-            Ok(FR) => {
-                // flag writes are ignored
-            }
-            Ok(ILPR) => {
-                self.ilpr = value;
-            }
-            Ok(IBRD) => {
-                self.ibrd = value;
-            }
-            Ok(FBRD) => {
-                self.fbrd = value;
-            }
-            Ok(LCR_H) => {
-                let value = value as u16;
-                let new_val: registers::LineControl = value.into();
-                // Reset the FIFO state on FIFO enable or disable
-                if bool::from(self.line_control.fifos_enabled())
-                    ^ bool::from(new_val.fifos_enabled())
-                {
-                    self.reset_fifo();
-                }
-                if self.line_control.send_break() ^ new_val.send_break() {
-                    let mut break_enable: c_int = new_val.send_break().into();
-                    // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-                    // initialized in realize().
-                    unsafe {
-                        qemu_chr_fe_ioctl(
-                            addr_of_mut!(self.char_backend),
-                            CHR_IOCTL_SERIAL_SET_BREAK as i32,
-                            addr_of_mut!(break_enable).cast::<c_void>(),
-                        );
-                    }
-                    self.loopback_break(break_enable > 0);
-                }
-                self.line_control = new_val;
-                self.set_read_trigger();
-            }
-            Ok(CR) => {
-                // ??? Need to implement the enable bit.
-                let value = value as u16;
-                self.control = value.into();
-                self.loopback_mdmctrl();
-            }
-            Ok(FLS) => {
-                self.ifl = value;
-                self.set_read_trigger();
-            }
-            Ok(IMSC) => {
-                self.int_enabled = value;
-                self.update();
-            }
-            Ok(RIS) => {}
-            Ok(MIS) => {}
-            Ok(ICR) => {
-                self.int_level &= !value;
-                self.update();
-            }
-            Ok(DMACR) => {
-                self.dmacr = value;
-                if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-                    eprintln!("pl011: DMA not implemented");
-                }
-            }
-        }
-    }
-
-    #[inline]
-    fn loopback_tx(&mut self, value: u32) {
-        if !self.loopback_enabled() {
-            return;
-        }
-
-        // Caveat:
-        //
-        // In real hardware, TX loopback happens at the serial-bit level
-        // and then reassembled by the RX logics back into bytes and placed
-        // into the RX fifo. That is, loopback happens after TX fifo.
-        //
-        // Because the real hardware TX fifo is time-drained at the frame
-        // rate governed by the configured serial format, some loopback
-        // bytes in TX fifo may still be able to get into the RX fifo
-        // that could be full at times while being drained at software
-        // pace.
-        //
-        // In such scenario, the RX draining pace is the major factor
-        // deciding which loopback bytes get into the RX fifo, unless
-        // hardware flow-control is enabled.
-        //
-        // For simplicity, the above described is not emulated.
-        self.put_fifo(value);
-    }
-
-    fn loopback_mdmctrl(&mut self) {
-        if !self.loopback_enabled() {
-            return;
-        }
-
-        /*
-         * Loopback software-driven modem control outputs to modem status inputs:
-         *   FR.RI  <= CR.Out2
-         *   FR.DCD <= CR.Out1
-         *   FR.CTS <= CR.RTS
-         *   FR.DSR <= CR.DTR
-         *
-         * The loopback happens immediately even if this call is triggered
-         * by setting only CR.LBE.
-         *
-         * CTS/RTS updates due to enabled hardware flow controls are not
-         * dealt with here.
-         */
-
-        //fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
-        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
-        //fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
-        //fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
-        //fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
-        //fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
-        //
-        self.flags.set_ring_indicator(self.control.out_2());
-        self.flags.set_data_carrier_detect(self.control.out_1());
-        self.flags.set_clear_to_send(self.control.request_to_send());
-        self.flags
-            .set_data_set_ready(self.control.data_transmit_ready());
-
-        // Change interrupts based on updated FR
-        let mut il = self.int_level;
-
-        il &= !Interrupt::MS;
-        //il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
-        //il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
-        //il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
-        //il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
-
-        if self.flags.data_set_ready() {
-            il |= Interrupt::DSR as u32;
-        }
-        if self.flags.data_carrier_detect() {
-            il |= Interrupt::DCD as u32;
-        }
-        if self.flags.clear_to_send() {
-            il |= Interrupt::CTS as u32;
-        }
-        if self.flags.ring_indicator() {
-            il |= Interrupt::RI as u32;
-        }
-        self.int_level = il;
-        self.update();
-    }
-
-    fn loopback_break(&mut self, enable: bool) {
-        if enable {
-            self.loopback_tx(DATA_BREAK);
-        }
-    }
-
-    fn set_read_trigger(&mut self) {
-        self.read_trigger = 1;
-    }
-
-    pub fn realize(&mut self) {
-        // SAFETY: self.char_backend has the correct size and alignment for a
-        // CharBackend object, and its callbacks are of the correct types.
-        unsafe {
-            qemu_chr_fe_set_handlers(
-                addr_of_mut!(self.char_backend),
-                Some(pl011_can_receive),
-                Some(pl011_receive),
-                Some(pl011_event),
-                None,
-                addr_of_mut!(*self).cast::<c_void>(),
-                core::ptr::null_mut(),
-                true,
-            );
-        }
-    }
-
-    pub fn reset(&mut self) {
-        self.line_control.reset();
-        self.receive_status_error_clear.reset();
-        self.dmacr = 0;
-        self.int_enabled = 0;
-        self.int_level = 0;
-        self.ilpr = 0;
-        self.ibrd = 0;
-        self.fbrd = 0;
-        self.read_trigger = 1;
-        self.ifl = 0x12;
-        self.control.reset();
-        self.flags = 0.into();
-        self.reset_fifo();
-    }
-
-    pub fn reset_fifo(&mut self) {
-        self.read_count = 0;
-        self.read_pos = 0;
-
-        /* Reset FIFO flags */
-        self.flags.reset();
-    }
-
-    pub fn can_receive(&self) -> bool {
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        self.read_count < self.fifo_depth()
-    }
-
-    pub fn event(&mut self, event: QEMUChrEvent) {
-        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.fifo_enabled() {
-            self.put_fifo(DATA_BREAK);
-            self.receive_status_error_clear.set_break_error(true);
-        }
-    }
-
-    #[inline]
-    pub fn fifo_enabled(&self) -> bool {
-        matches!(self.line_control.fifos_enabled(), registers::Mode::FIFO)
-    }
-
-    #[inline]
-    pub fn loopback_enabled(&self) -> bool {
-        self.control.enable_loopback()
-    }
-
-    #[inline]
-    pub fn fifo_depth(&self) -> usize {
-        // Note: FIFO depth is expected to be power-of-2
-        if self.fifo_enabled() {
-            return PL011_FIFO_DEPTH;
-        }
-        1
-    }
-
-    pub fn put_fifo(&mut self, value: c_uint) {
-        let depth = self.fifo_depth();
-        assert!(depth > 0);
-        let slot = (self.read_pos + self.read_count) & (depth - 1);
-        self.read_fifo[slot] = value;
-        self.read_count += 1;
-        // s->flags &= ~PL011_FLAG_RXFE;
-        self.flags.set_receive_fifo_empty(false);
-        if self.read_count == depth {
-            //s->flags |= PL011_FLAG_RXFF;
-            self.flags.set_receive_fifo_full(true);
-        }
-
-        if self.read_count == self.read_trigger {
-            self.int_level |= registers::INT_RX;
-            self.update();
-        }
-    }
-
-    pub fn update(&self) {
-        let flags = self.int_level & self.int_enabled;
-        for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
-            // SAFETY: self.interrupts have been initialized in init().
-            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
-        }
-    }
-}
-
-/// Which bits in the interrupt status matter for each outbound IRQ line ?
-pub const IRQMASK: [u32; 6] = [
-    /* combined IRQ */
-    Interrupt::E
-        | Interrupt::MS
-        | Interrupt::RT as u32
-        | Interrupt::TX as u32
-        | Interrupt::RX as u32,
-    Interrupt::RX as u32,
-    Interrupt::TX as u32,
-    Interrupt::RT as u32,
-    Interrupt::MS,
-    Interrupt::E,
-];
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_ref().can_receive().into()
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-///
-/// The buffer and size arguments must also be valid.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_receive(
-    opaque: *mut core::ffi::c_void,
-    buf: *const u8,
-    size: core::ffi::c_int,
-) {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        if state.as_ref().loopback_enabled() {
-            return;
-        }
-        if size > 0 {
-            debug_assert!(!buf.is_null());
-            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
-        }
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_mut().event(event)
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer for `chr`.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_create(
-    addr: u64,
-    irq: qemu_irq,
-    chr: *mut Chardev,
-) -> *mut DeviceState {
-    unsafe {
-        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
-        let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
-
-        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
-        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
-        sysbus_mmio_map(sysbus, 0, addr);
-        sysbus_connect_irq(sysbus, 0, irq);
-        dev
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
-    unsafe {
-        debug_assert!(!obj.is_null());
-        let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
-        state.as_mut().init();
-    }
-}
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
deleted file mode 100644
index b7ab31af02d7bb50ae94be0b153baafc7ccfa375..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/src/device_class.rs
+++ /dev/null
@@ -1,70 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use core::ptr::NonNull;
-
-use qemu_api::{bindings::*, definitions::ObjectImpl};
-
-use crate::device::PL011State;
-
-#[used]
-pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: PL011State::TYPE_INFO.name,
-    unmigratable: true,
-    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
-};
-
-qemu_api::declare_properties! {
-    PL011_PROPERTIES,
-    qemu_api::define_property!(
-        c"chardev",
-        PL011State,
-        char_backend,
-        unsafe { &qdev_prop_chr },
-        CharBackend
-    ),
-    qemu_api::define_property!(
-        c"migrate-clk",
-        PL011State,
-        migrate_clock,
-        unsafe { &qdev_prop_bool },
-        bool
-    ),
-}
-
-qemu_api::device_class_init! {
-    pl011_class_init,
-    props => PL011_PROPERTIES,
-    realize_fn => Some(pl011_realize),
-    legacy_reset_fn => Some(pl011_reset),
-    vmsd => VMSTATE_PL011,
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mut *mut Error) {
-    unsafe {
-        assert!(!dev.is_null());
-        let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
-        state.as_mut().realize();
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
-    unsafe {
-        assert!(!dev.is_null());
-        let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
-        state.as_mut().reset();
-    }
-}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
deleted file mode 100644
index 2939ee50c99ceaacf6ec68127272d58814e33679..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/src/lib.rs
+++ /dev/null
@@ -1,586 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-//
-// PL011 QEMU Device Model
-//
-// This library implements a device model for the PrimeCell® UART (PL011)
-// device in QEMU.
-//
-#![doc = include_str!("../README.md")]
-//! # Library crate
-//!
-//! See [`PL011State`](crate::device::PL011State) for the device model type and
-//! the [`registers`] module for register types.
-
-#![deny(
-    rustdoc::broken_intra_doc_links,
-    rustdoc::redundant_explicit_links,
-    clippy::correctness,
-    clippy::suspicious,
-    clippy::complexity,
-    clippy::perf,
-    clippy::cargo,
-    clippy::nursery,
-    clippy::style,
-    // restriction group
-    clippy::dbg_macro,
-    clippy::as_underscore,
-    clippy::assertions_on_result_states,
-    // pedantic group
-    clippy::doc_markdown,
-    clippy::borrow_as_ptr,
-    clippy::cast_lossless,
-    clippy::option_if_let_else,
-    clippy::missing_const_for_fn,
-    clippy::cognitive_complexity,
-    clippy::missing_safety_doc,
-    )]
-
-extern crate bilge;
-extern crate bilge_impl;
-extern crate qemu_api;
-
-pub mod device;
-pub mod device_class;
-pub mod memory_ops;
-
-pub const TYPE_PL011: &::core::ffi::CStr = c"pl011";
-
-/// Offset of each register from the base memory address of the device.
-///
-/// # Source
-/// ARM DDI 0183G, Table 3-1 p.3-3
-#[doc(alias = "offset")]
-#[allow(non_camel_case_types)]
-#[repr(u64)]
-#[derive(Debug)]
-pub enum RegisterOffset {
-    /// Data Register
-    ///
-    /// A write to this register initiates the actual data transmission
-    #[doc(alias = "UARTDR")]
-    DR = 0x000,
-    /// Receive Status Register or Error Clear Register
-    #[doc(alias = "UARTRSR")]
-    #[doc(alias = "UARTECR")]
-    RSR = 0x004,
-    /// Flag Register
-    ///
-    /// A read of this register shows if transmission is complete
-    #[doc(alias = "UARTFR")]
-    FR = 0x018,
-    /// Fractional Baud Rate Register
-    ///
-    /// responsible for baud rate speed
-    #[doc(alias = "UARTFBRD")]
-    FBRD = 0x028,
-    /// `IrDA` Low-Power Counter Register
-    #[doc(alias = "UARTILPR")]
-    ILPR = 0x020,
-    /// Integer Baud Rate Register
-    ///
-    /// Responsible for baud rate speed
-    #[doc(alias = "UARTIBRD")]
-    IBRD = 0x024,
-    /// line control register (data frame format)
-    #[doc(alias = "UARTLCR_H")]
-    LCR_H = 0x02C,
-    /// Toggle UART, transmission or reception
-    #[doc(alias = "UARTCR")]
-    CR = 0x030,
-    /// Interrupt FIFO Level Select Register
-    #[doc(alias = "UARTIFLS")]
-    FLS = 0x034,
-    /// Interrupt Mask Set/Clear Register
-    #[doc(alias = "UARTIMSC")]
-    IMSC = 0x038,
-    /// Raw Interrupt Status Register
-    #[doc(alias = "UARTRIS")]
-    RIS = 0x03C,
-    /// Masked Interrupt Status Register
-    #[doc(alias = "UARTMIS")]
-    MIS = 0x040,
-    /// Interrupt Clear Register
-    #[doc(alias = "UARTICR")]
-    ICR = 0x044,
-    /// DMA control Register
-    #[doc(alias = "UARTDMACR")]
-    DMACR = 0x048,
-    ///// Reserved, offsets `0x04C` to `0x07C`.
-    //Reserved = 0x04C,
-}
-
-impl core::convert::TryFrom<u64> for RegisterOffset {
-    type Error = u64;
-
-    fn try_from(value: u64) -> Result<Self, Self::Error> {
-        macro_rules! case {
-            ($($discriminant:ident),*$(,)*) => {
-                /* check that matching on all macro arguments compiles, which means we are not
-                 * missing any enum value; if the type definition ever changes this will stop
-                 * compiling.
-                 */
-                const fn _assert_exhaustive(val: RegisterOffset) {
-                    match val {
-                        $(RegisterOffset::$discriminant => (),)*
-                    }
-                }
-
-                match value {
-                    $(x if x == Self::$discriminant as u64 => Ok(Self::$discriminant),)*
-                     _ => Err(value),
-                }
-            }
-        }
-        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR }
-    }
-}
-
-pub mod registers {
-    //! Device registers exposed as typed structs which are backed by arbitrary
-    //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
-    //!
-    //! All PL011 registers are essentially 32-bit wide, but are typed here as
-    //! bitmaps with only the necessary width. That is, if a struct bitmap
-    //! in this module is for example 16 bits long, it should be conceived
-    //! as a 32-bit register where the unmentioned higher bits are always
-    //! unused thus treated as zero when read or written.
-    use bilge::prelude::*;
-
-    // TODO: FIFO Mode has different semantics
-    /// Data Register, `UARTDR`
-    ///
-    /// The `UARTDR` register is the data register.
-    ///
-    /// For words to be transmitted:
-    ///
-    /// - if the FIFOs are enabled, data written to this location is pushed onto
-    ///   the transmit
-    /// FIFO
-    /// - if the FIFOs are not enabled, data is stored in the transmitter
-    ///   holding register (the
-    /// bottom word of the transmit FIFO).
-    ///
-    /// The write operation initiates transmission from the UART. The data is
-    /// prefixed with a start bit, appended with the appropriate parity bit
-    /// (if parity is enabled), and a stop bit. The resultant word is then
-    /// transmitted.
-    ///
-    /// For received words:
-    ///
-    /// - if the FIFOs are enabled, the data byte and the 4-bit status (break,
-    ///   frame, parity,
-    /// and overrun) is pushed onto the 12-bit wide receive FIFO
-    /// - if the FIFOs are not enabled, the data byte and status are stored in
-    ///   the receiving
-    /// holding register (the bottom word of the receive FIFO).
-    ///
-    /// The received data byte is read by performing reads from the `UARTDR`
-    /// register along with the corresponding status information. The status
-    /// information can also be read by a read of the `UARTRSR/UARTECR`
-    /// register.
-    ///
-    /// # Note
-    ///
-    /// You must disable the UART before any of the control registers are
-    /// reprogrammed. When the UART is disabled in the middle of
-    /// transmission or reception, it completes the current character before
-    /// stopping.
-    ///
-    /// # Source
-    /// ARM DDI 0183G 3.3.1 Data Register, UARTDR
-    #[bitsize(16)]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
-    #[doc(alias = "UARTDR")]
-    pub struct Data {
-        _reserved: u4,
-        pub data: u8,
-        pub framing_error: bool,
-        pub parity_error: bool,
-        pub break_error: bool,
-        pub overrun_error: bool,
-    }
-
-    // TODO: FIFO Mode has different semantics
-    /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
-    ///
-    /// The UARTRSR/UARTECR register is the receive status register/error clear
-    /// register. Receive status can also be read from the `UARTRSR`
-    /// register. If the status is read from this register, then the status
-    /// information for break, framing and parity corresponds to the
-    /// data character read from the [Data register](Data), `UARTDR` prior to
-    /// reading the UARTRSR register. The status information for overrun is
-    /// set immediately when an overrun condition occurs.
-    ///
-    ///
-    /// # Note
-    /// The received data character must be read first from the [Data
-    /// Register](Data), `UARTDR` before reading the error status associated
-    /// with that data character from the `UARTRSR` register. This read
-    /// sequence cannot be reversed, because the `UARTRSR` register is
-    /// updated only when a read occurs from the `UARTDR` register. However,
-    /// the status information can also be obtained by reading the `UARTDR`
-    /// register
-    ///
-    /// # Source
-    /// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register,
-    /// UARTRSR/UARTECR
-    #[bitsize(8)]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
-    pub struct ReceiveStatusErrorClear {
-        pub framing_error: bool,
-        pub parity_error: bool,
-        pub break_error: bool,
-        pub overrun_error: bool,
-        _reserved_unpredictable: u4,
-    }
-
-    impl ReceiveStatusErrorClear {
-        pub fn reset(&mut self) {
-            // All the bits are cleared to 0 on reset.
-            *self = 0.into();
-        }
-    }
-
-    impl Default for ReceiveStatusErrorClear {
-        fn default() -> Self {
-            0.into()
-        }
-    }
-
-    #[bitsize(16)]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
-    /// Flag Register, `UARTFR`
-    #[doc(alias = "UARTFR")]
-    pub struct Flags {
-        /// CTS Clear to send. This bit is the complement of the UART clear to
-        /// send, `nUARTCTS`, modem status input. That is, the bit is 1
-        /// when `nUARTCTS` is LOW.
-        pub clear_to_send: bool,
-        /// DSR Data set ready. This bit is the complement of the UART data set
-        /// ready, `nUARTDSR`, modem status input. That is, the bit is 1 when
-        /// `nUARTDSR` is LOW.
-        pub data_set_ready: bool,
-        /// DCD Data carrier detect. This bit is the complement of the UART data
-        /// carrier detect, `nUARTDCD`, modem status input. That is, the bit is
-        /// 1 when `nUARTDCD` is LOW.
-        pub data_carrier_detect: bool,
-        /// BUSY UART busy. If this bit is set to 1, the UART is busy
-        /// transmitting data. This bit remains set until the complete
-        /// byte, including all the stop bits, has been sent from the
-        /// shift register. This bit is set as soon as the transmit FIFO
-        /// becomes non-empty, regardless of whether the UART is enabled
-        /// or not.
-        pub busy: bool,
-        /// RXFE Receive FIFO empty. The meaning of this bit depends on the
-        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
-        /// is disabled, this bit is set when the receive holding
-        /// register is empty. If the FIFO is enabled, the RXFE bit is
-        /// set when the receive FIFO is empty.
-        pub receive_fifo_empty: bool,
-        /// TXFF Transmit FIFO full. The meaning of this bit depends on the
-        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
-        /// is disabled, this bit is set when the transmit holding
-        /// register is full. If the FIFO is enabled, the TXFF bit is
-        /// set when the transmit FIFO is full.
-        pub transmit_fifo_full: bool,
-        /// RXFF Receive FIFO full. The meaning of this bit depends on the state
-        /// of the FEN bit in the UARTLCR_H register. If the FIFO is
-        /// disabled, this bit is set when the receive holding register
-        /// is full. If the FIFO is enabled, the RXFF bit is set when
-        /// the receive FIFO is full.
-        pub receive_fifo_full: bool,
-        /// Transmit FIFO empty. The meaning of this bit depends on the state of
-        /// the FEN bit in the [Line Control register](LineControl),
-        /// `UARTLCR_H`. If the FIFO is disabled, this bit is set when the
-        /// transmit holding register is empty. If the FIFO is enabled,
-        /// the TXFE bit is set when the transmit FIFO is empty. This
-        /// bit does not indicate if there is data in the transmit shift
-        /// register.
-        pub transmit_fifo_empty: bool,
-        /// `RI`, is `true` when `nUARTRI` is `LOW`.
-        pub ring_indicator: bool,
-        _reserved_zero_no_modify: u7,
-    }
-
-    impl Flags {
-        pub fn reset(&mut self) {
-            // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are 1
-            self.set_receive_fifo_full(false);
-            self.set_transmit_fifo_full(false);
-            self.set_busy(false);
-            self.set_receive_fifo_empty(true);
-            self.set_transmit_fifo_empty(true);
-        }
-    }
-
-    impl Default for Flags {
-        fn default() -> Self {
-            let mut ret: Self = 0.into();
-            ret.reset();
-            ret
-        }
-    }
-
-    #[bitsize(16)]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
-    /// Line Control Register, `UARTLCR_H`
-    #[doc(alias = "UARTLCR_H")]
-    pub struct LineControl {
-        /// 15:8 - Reserved, do not modify, read as zero.
-        _reserved_zero_no_modify: u8,
-        /// 7 SPS Stick parity select.
-        /// 0 = stick parity is disabled
-        /// 1 = either:
-        /// • if the EPS bit is 0 then the parity bit is transmitted and checked
-        /// as a 1 • if the EPS bit is 1 then the parity bit is
-        /// transmitted and checked as a 0. This bit has no effect when
-        /// the PEN bit disables parity checking and generation. See Table 3-11
-        /// on page 3-14 for the parity truth table.
-        pub sticky_parity: bool,
-        /// WLEN Word length. These bits indicate the number of data bits
-        /// transmitted or received in a frame as follows: b11 = 8 bits
-        /// b10 = 7 bits
-        /// b01 = 6 bits
-        /// b00 = 5 bits.
-        pub word_length: WordLength,
-        /// FEN Enable FIFOs:
-        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
-        /// 1-byte-deep holding registers 1 = transmit and receive FIFO
-        /// buffers are enabled (FIFO mode).
-        pub fifos_enabled: Mode,
-        /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
-        /// are transmitted at the end of the frame. The receive
-        /// logic does not check for two stop bits being received.
-        pub two_stops_bits: bool,
-        /// EPS Even parity select. Controls the type of parity the UART uses
-        /// during transmission and reception:
-        /// - 0 = odd parity. The UART generates or checks for an odd number of
-        ///   1s in the data and parity bits.
-        /// - 1 = even parity. The UART generates or checks for an even number
-        ///   of 1s in the data and parity bits.
-        /// This bit has no effect when the `PEN` bit disables parity checking
-        /// and generation. See Table 3-11 on page 3-14 for the parity
-        /// truth table.
-        pub parity: Parity,
-        /// 1 PEN Parity enable:
-        ///
-        /// - 0 = parity is disabled and no parity bit added to the data frame
-        /// - 1 = parity checking and generation is enabled.
-        ///
-        /// See Table 3-11 on page 3-14 for the parity truth table.
-        pub parity_enabled: bool,
-        /// BRK Send break.
-        ///
-        /// If this bit is set to `1`, a low-level is continually output on the
-        /// `UARTTXD` output, after completing transmission of the
-        /// current character. For the proper execution of the break command,
-        /// the software must set this bit for at least two complete
-        /// frames. For normal use, this bit must be cleared to `0`.
-        pub send_break: bool,
-    }
-
-    impl LineControl {
-        pub fn reset(&mut self) {
-            // All the bits are cleared to 0 when reset.
-            *self = 0.into();
-        }
-    }
-
-    impl Default for LineControl {
-        fn default() -> Self {
-            0.into()
-        }
-    }
-
-    #[bitsize(1)]
-    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
-    /// `EPS` "Even parity select", field of [Line Control
-    /// register](LineControl).
-    pub enum Parity {
-        /// - 0 = odd parity. The UART generates or checks for an odd number of
-        ///   1s in the data and parity bits.
-        Odd = 0,
-        /// - 1 = even parity. The UART generates or checks for an even number
-        ///   of 1s in the data and parity bits.
-        Even = 1,
-    }
-
-    #[bitsize(1)]
-    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
-    /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
-    /// register](LineControl).
-    pub enum Mode {
-        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
-        /// 1-byte-deep holding registers
-        Character = 0,
-        /// 1 = transmit and receive FIFO buffers are enabled (FIFO mode).
-        FIFO = 1,
-    }
-
-    impl From<Mode> for bool {
-        fn from(val: Mode) -> Self {
-            matches!(val, Mode::FIFO)
-        }
-    }
-
-    #[bitsize(2)]
-    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
-    /// `WLEN` Word length, field of [Line Control register](LineControl).
-    ///
-    /// These bits indicate the number of data bits transmitted or received in a
-    /// frame as follows:
-    pub enum WordLength {
-        /// b11 = 8 bits
-        _8Bits = 0b11,
-        /// b10 = 7 bits
-        _7Bits = 0b10,
-        /// b01 = 6 bits
-        _6Bits = 0b01,
-        /// b00 = 5 bits.
-        _5Bits = 0b00,
-    }
-
-    /// Control Register, `UARTCR`
-    ///
-    /// The `UARTCR` register is the control register. All the bits are cleared
-    /// to `0` on reset except for bits `9` and `8` that are set to `1`.
-    ///
-    /// # Source
-    /// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
-    #[bitsize(16)]
-    #[doc(alias = "UARTCR")]
-    #[derive(Clone, Copy, DebugBits, FromBits)]
-    pub struct Control {
-        /// `UARTEN` UART enable: 0 = UART is disabled. If the UART is disabled
-        /// in the middle of transmission or reception, it completes the current
-        /// character before stopping. 1 = the UART is enabled. Data
-        /// transmission and reception occurs for either UART signals or SIR
-        /// signals depending on the setting of the SIREN bit.
-        pub enable_uart: bool,
-        /// `SIREN` `SIR` enable: 0 = IrDA SIR ENDEC is disabled. `nSIROUT`
-        /// remains LOW (no light pulse generated), and signal transitions on
-        /// SIRIN have no effect. 1 = IrDA SIR ENDEC is enabled. Data is
-        /// transmitted and received on nSIROUT and SIRIN. UARTTXD remains HIGH,
-        /// in the marking state. Signal transitions on UARTRXD or modem status
-        /// inputs have no effect. This bit has no effect if the UARTEN bit
-        /// disables the UART.
-        pub enable_sir: bool,
-        /// `SIRLP` SIR low-power IrDA mode. This bit selects the IrDA encoding
-        /// mode. If this bit is cleared to 0, low-level bits are transmitted as
-        /// an active high pulse with a width of 3/ 16th of the bit period. If
-        /// this bit is set to 1, low-level bits are transmitted with a pulse
-        /// width that is 3 times the period of the IrLPBaud16 input signal,
-        /// regardless of the selected bit rate. Setting this bit uses less
-        /// power, but might reduce transmission distances.
-        pub sir_lowpower_irda_mode: u1,
-        /// Reserved, do not modify, read as zero.
-        _reserved_zero_no_modify: u4,
-        /// `LBE` Loopback enable. If this bit is set to 1 and the SIREN bit is
-        /// set to 1 and the SIRTEST bit in the Test Control register, UARTTCR
-        /// on page 4-5 is set to 1, then the nSIROUT path is inverted, and fed
-        /// through to the SIRIN path. The SIRTEST bit in the test register must
-        /// be set to 1 to override the normal half-duplex SIR operation. This
-        /// must be the requirement for accessing the test registers during
-        /// normal operation, and SIRTEST must be cleared to 0 when loopback
-        /// testing is finished. This feature reduces the amount of external
-        /// coupling required during system test. If this bit is set to 1, and
-        /// the SIRTEST bit is set to 0, the UARTTXD path is fed through to the
-        /// UARTRXD path. In either SIR mode or UART mode, when this bit is set,
-        /// the modem outputs are also fed through to the modem inputs. This bit
-        /// is cleared to 0 on reset, to disable loopback.
-        pub enable_loopback: bool,
-        /// `TXE` Transmit enable. If this bit is set to 1, the transmit section
-        /// of the UART is enabled. Data transmission occurs for either UART
-        /// signals, or SIR signals depending on the setting of the SIREN bit.
-        /// When the UART is disabled in the middle of transmission, it
-        /// completes the current character before stopping.
-        pub enable_transmit: bool,
-        /// `RXE` Receive enable. If this bit is set to 1, the receive section
-        /// of the UART is enabled. Data reception occurs for either UART
-        /// signals or SIR signals depending on the setting of the SIREN bit.
-        /// When the UART is disabled in the middle of reception, it completes
-        /// the current character before stopping.
-        pub enable_receive: bool,
-        /// `DTR` Data transmit ready. This bit is the complement of the UART
-        /// data transmit ready, `nUARTDTR`, modem status output. That is, when
-        /// the bit is programmed to a 1 then `nUARTDTR` is LOW.
-        pub data_transmit_ready: bool,
-        /// `RTS` Request to send. This bit is the complement of the UART
-        /// request to send, `nUARTRTS`, modem status output. That is, when the
-        /// bit is programmed to a 1 then `nUARTRTS` is LOW.
-        pub request_to_send: bool,
-        /// `Out1` This bit is the complement of the UART Out1 (`nUARTOut1`)
-        /// modem status output. That is, when the bit is programmed to a 1 the
-        /// output is 0. For DTE this can be used as Data Carrier Detect (DCD).
-        pub out_1: bool,
-        /// `Out2` This bit is the complement of the UART Out2 (`nUARTOut2`)
-        /// modem status output. That is, when the bit is programmed to a 1, the
-        /// output is 0. For DTE this can be used as Ring Indicator (RI).
-        pub out_2: bool,
-        /// `RTSEn` RTS hardware flow control enable. If this bit is set to 1,
-        /// RTS hardware flow control is enabled. Data is only requested when
-        /// there is space in the receive FIFO for it to be received.
-        pub rts_hardware_flow_control_enable: bool,
-        /// `CTSEn` CTS hardware flow control enable. If this bit is set to 1,
-        /// CTS hardware flow control is enabled. Data is only transmitted when
-        /// the `nUARTCTS` signal is asserted.
-        pub cts_hardware_flow_control_enable: bool,
-    }
-
-    impl Control {
-        pub fn reset(&mut self) {
-            *self = 0.into();
-            self.set_enable_receive(true);
-            self.set_enable_transmit(true);
-        }
-    }
-
-    impl Default for Control {
-        fn default() -> Self {
-            let mut ret: Self = 0.into();
-            ret.reset();
-            ret
-        }
-    }
-
-    /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
-    pub const INT_OE: u32 = 1 << 10;
-    pub const INT_BE: u32 = 1 << 9;
-    pub const INT_PE: u32 = 1 << 8;
-    pub const INT_FE: u32 = 1 << 7;
-    pub const INT_RT: u32 = 1 << 6;
-    pub const INT_TX: u32 = 1 << 5;
-    pub const INT_RX: u32 = 1 << 4;
-    pub const INT_DSR: u32 = 1 << 3;
-    pub const INT_DCD: u32 = 1 << 2;
-    pub const INT_CTS: u32 = 1 << 1;
-    pub const INT_RI: u32 = 1 << 0;
-    pub const INT_E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
-    pub const INT_MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
-
-    #[repr(u32)]
-    pub enum Interrupt {
-        OE = 1 << 10,
-        BE = 1 << 9,
-        PE = 1 << 8,
-        FE = 1 << 7,
-        RT = 1 << 6,
-        TX = 1 << 5,
-        RX = 1 << 4,
-        DSR = 1 << 3,
-        DCD = 1 << 2,
-        CTS = 1 << 1,
-        RI = 1 << 0,
-    }
-
-    impl Interrupt {
-        pub const E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
-        pub const MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
-    }
-}
-
-// TODO: You must disable the UART before any of the control registers are
-// reprogrammed. When the UART is disabled in the middle of transmission or
-// reception, it completes the current character before stopping
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
deleted file mode 100644
index 8d066ebf6d016fa30db004933751a854d7e59117..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ /dev/null
@@ -1,59 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use core::{mem::MaybeUninit, ptr::NonNull};
-
-use qemu_api::bindings::*;
-
-use crate::device::PL011State;
-
-pub static PL011_OPS: MemoryRegionOps = MemoryRegionOps {
-    read: Some(pl011_read),
-    write: Some(pl011_write),
-    read_with_attrs: None,
-    write_with_attrs: None,
-    endianness: device_endian::DEVICE_NATIVE_ENDIAN,
-    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed().assume_init() },
-    impl_: MemoryRegionOps__bindgen_ty_2 {
-        min_access_size: 4,
-        max_access_size: 4,
-        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed().assume_init() }
-    },
-};
-
-#[no_mangle]
-unsafe extern "C" fn pl011_read(
-    opaque: *mut core::ffi::c_void,
-    addr: hwaddr,
-    size: core::ffi::c_uint,
-) -> u64 {
-    assert!(!opaque.is_null());
-    let mut state = unsafe { NonNull::new_unchecked(opaque.cast::<PL011State>()) };
-    let val = unsafe { state.as_mut().read(addr, size) };
-    match val {
-        std::ops::ControlFlow::Break(val) => val,
-        std::ops::ControlFlow::Continue(val) => {
-            // SAFETY: self.char_backend is a valid CharBackend instance after it's been
-            // initialized in realize().
-            let cb_ptr = unsafe { core::ptr::addr_of_mut!(state.as_mut().char_backend) };
-            unsafe { qemu_chr_fe_accept_input(cb_ptr) };
-
-            val
-        }
-    }
-}
-
-#[no_mangle]
-unsafe extern "C" fn pl011_write(
-    opaque: *mut core::ffi::c_void,
-    addr: hwaddr,
-    data: u64,
-    _size: core::ffi::c_uint,
-) {
-    unsafe {
-        assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_mut().write(addr, data)
-    }
-}
diff --git a/rust/hw/meson.build b/rust/hw/meson.build
deleted file mode 100644
index 860196645e719624d2e2e6bc301b62b81ab2e19b..0000000000000000000000000000000000000000
--- a/rust/hw/meson.build
+++ /dev/null
@@ -1 +0,0 @@
-subdir('char')
diff --git a/rust/meson.build b/rust/meson.build
index def77389cddc52f5d4503840e9bdfb1207586fa2..7a32b1b195083571931ad589965c10ddaf6383b1 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,4 +1,2 @@
 subdir('qemu-api-macros')
 subdir('qemu-api')
-
-subdir('hw')
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 30677c3ec9032ea01090f74602d839d1c571d012..62a2cf45d28ed5565076443b9f931a647d395542 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -27,9 +27,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # in their checkout, because the build environment is completely
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
-  berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
-  proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
+  berkeley-testfloat-3 proc-macro2-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 sub_deinit=""
 
diff --git a/scripts/make-release b/scripts/make-release
index 8dc939124c4fd4abf3509c3b64c0588bc8810962..cf7d694ef73ba1c6c5afad5d211a42f6a6fe1577 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -18,9 +18,7 @@ fi
 
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
-  berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
-  proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
+  berkeley-testfloat-3 proc-macro2-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
 src="$1"
diff --git a/scripts/rust/rust_root_crate.sh b/scripts/rust/rust_root_crate.sh
deleted file mode 100755
index 975bddf7f1a4c6ca7770f800bdc894cdff1f3ab1..0000000000000000000000000000000000000000
--- a/scripts/rust/rust_root_crate.sh
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-
-set -eu
-
-cat <<EOF
-// @generated
-// This file is autogenerated by scripts/rust_root_crate.sh
-
-EOF
-
-for crate in $*; do
-    echo "extern crate $crate;"
-done
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 50f173f90dbe5dde1162cfe96636f63637574c74..b6888182ca4e5b59b90cfde1792a5770e9a5240a 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,13 +6,6 @@
 /keycodemapdb
 /libvfio-user
 /slirp
-/arbitrary-int-1.2.7
-/bilge-0.2.0
-/bilge-impl-0.2.0
-/either-1.12.0
-/itertools-0.11.0
-/proc-macro-error-1.0.4
-/proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.84
 /quote-1.0.36
 /syn-2.0.66
diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
deleted file mode 100644
index e580538a8776001147bfc5c5c73df2bfccac6347..0000000000000000000000000000000000000000
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = arbitrary-int-1.2.7
-source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
-source_filename = arbitrary-int-1.2.7.tar.gz
-source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
-#method = cargo
-patch_directory = arbitrary-int-1-rs
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
deleted file mode 100644
index 7a4339d29896922c392e2e1952e02a1ee82b1874..0000000000000000000000000000000000000000
--- a/subprojects/bilge-0.2-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = bilge-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
-source_filename = bilge-0.2.0.tar.gz
-source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
-#method = cargo
-patch_directory = bilge-0.2-rs
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
deleted file mode 100644
index eefb10c36c24007d48833748cf200d67b6ff7ee7..0000000000000000000000000000000000000000
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = bilge-impl-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
-source_filename = bilge-impl-0.2.0.tar.gz
-source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
-#method = cargo
-patch_directory = bilge-impl-0.2-rs
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
deleted file mode 100644
index 6046712036c8db1b142d083ae6f8a2d58d6203ab..0000000000000000000000000000000000000000
--- a/subprojects/either-1-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = either-1.12.0
-source_url = https://crates.io/api/v1/crates/either/1.12.0/download
-source_filename = either-1.12.0.tar.gz
-source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
-#method = cargo
-patch_directory = either-1-rs
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
deleted file mode 100644
index 66b05252cd55ed3149b79b992a6d224e9789ba97..0000000000000000000000000000000000000000
--- a/subprojects/itertools-0.11-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = itertools-0.11.0
-source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
-source_filename = itertools-0.11.0.tar.gz
-source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
-#method = cargo
-patch_directory = itertools-0.11-rs
diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
deleted file mode 100644
index 34a189cbaec77ba6631c6a8cb40d7eb3f32099ee..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ /dev/null
@@ -1,19 +0,0 @@
-project('arbitrary-int-1-rs', 'rust',
-  version: '1.2.7',
-  license: 'MIT',
-  default_options: [])
-
-_arbitrary_int_rs = static_library(
-  'arbitrary_int',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [],
-)
-
-arbitrary_int_dep = declare_dependency(
-  link_with: _arbitrary_int_rs,
-)
-
-meson.override_dependency('arbitrary-int-1-rs', arbitrary_int_dep)
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
deleted file mode 100644
index a6ed4a8f0cde70be0bf75cd1ad40bc64e3a11a3a..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ /dev/null
@@ -1,29 +0,0 @@
-project(
-  'bilge-0.2-rs',
-  'rust',
-  version : '0.2.0',
-  license : 'MIT or Apache-2.0',
-)
-
-subproject('arbitrary-int-1-rs', required: true)
-subproject('bilge-impl-0.2-rs', required: true)
-
-arbitrary_int_dep = dependency('arbitrary-int-1-rs')
-bilge_impl_dep = dependency('bilge-impl-0.2-rs')
-
-lib = static_library(
-  'bilge',
-  'src/lib.rs',
-  override_options : ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi : 'rust',
-  dependencies: [
-    arbitrary_int_dep,
-    bilge_impl_dep,
-  ],
-)
-
-bilge_dep = declare_dependency(
-  link_with : [lib],
-)
-
-meson.override_dependency('bilge-0.2-rs', bilge_dep)
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
deleted file mode 100644
index 80243c7024d898826cc3c98ba5b78ef286b79ce9..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ /dev/null
@@ -1,45 +0,0 @@
-project('bilge-impl-0.2-rs', 'rust',
-  version: '0.2.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('itertools-0.11-rs', required: true)
-subproject('proc-macro-error-attr-1-rs', required: true)
-subproject('proc-macro-error-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-subproject('proc-macro2-1-rs', required: true)
-
-itertools_dep = dependency('itertools-0.11-rs', native: true)
-proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs', native: true)
-proc_macro_error_dep = dependency('proc-macro-error-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-
-rust = import('rust')
-
-_bilge_impl_rs = rust.proc_macro(
-  'bilge_impl',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_args: [
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
-  ],
-  dependencies: [
-    itertools_dep,
-    proc_macro_error_attr_dep,
-    proc_macro_error_dep,
-    quote_dep,
-    syn_dep,
-    proc_macro2_dep,
-  ],
-)
-
-bilge_impl_dep = declare_dependency(
-  link_with: _bilge_impl_rs,
-)
-
-meson.override_dependency('bilge-impl-0.2-rs', bilge_impl_dep)
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
deleted file mode 100644
index a5842eb3a6a63cf94883663758ca5eb11225ad58..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ /dev/null
@@ -1,24 +0,0 @@
-project('either-1-rs', 'rust',
-  version: '1.12.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-_either_rs = static_library(
-  'either',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'feature="use_std"',
-    '--cfg', 'feature="use_alloc"',
-  ],
-  dependencies: [],
-  native: true,
-)
-
-either_dep = declare_dependency(
-  link_with: _either_rs,
-)
-
-meson.override_dependency('either-1-rs', either_dep, native: true)
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
deleted file mode 100644
index 13d2d27019d215fb793c457e494be7387a7ef455..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ /dev/null
@@ -1,30 +0,0 @@
-project('itertools-0.11-rs', 'rust',
-  version: '0.11.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('either-1-rs', required: true)
-
-either_dep = dependency('either-1-rs', native: true)
-
-_itertools_rs = static_library(
-  'itertools',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'feature="use_std"',
-    '--cfg', 'feature="use_alloc"',
-  ],
-  dependencies: [
-    either_dep,
-  ],
-  native: true,
-)
-
-itertools_dep = declare_dependency(
-  link_with: _itertools_rs,
-)
-
-meson.override_dependency('itertools-0.11-rs', itertools_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
deleted file mode 100644
index 38ea7b89d39d3f131959f00665b51a49d5bc95e5..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ /dev/null
@@ -1,40 +0,0 @@
-project('proc-macro-error-1-rs', 'rust',
-  version: '1.0.4',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro-error-attr-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-subproject('proc-macro2-1-rs', required: true)
-
-proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-
-_proc_macro_error_rs = static_library(
-  'proc_macro_error',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_abi: 'rust',
-  rust_args: [
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
-    '-A', 'non_fmt_panics'
-  ],
-  dependencies: [
-    proc_macro_error_attr_dep,
-    proc_macro2_dep,
-    quote_dep,
-    syn_dep,
-  ],
-  native: true,
-)
-
-proc_macro_error_dep = declare_dependency(
-  link_with: _proc_macro_error_rs,
-)
-
-meson.override_dependency('proc-macro-error-1-rs', proc_macro_error_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
deleted file mode 100644
index d900c54cfd1ad6c8c415438c2e9dd51695c82150..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ /dev/null
@@ -1,32 +0,0 @@
-project('proc-macro-error-attr-1-rs', 'rust',
-  version: '1.12.0',
-  license: 'MIT OR Apache-2.0',
-  default_options: [])
-
-subproject('proc-macro2-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-quote_dep = dependency('quote-1-rs', native: true)
-
-rust = import('rust')
-_proc_macro_error_attr_rs = rust.proc_macro(
-  'proc_macro_error_attr',
-  files('src/lib.rs'),
-  override_options: ['rust_std=2018', 'build.rust_std=2018'],
-  rust_args: [
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"'
-  ],
-  dependencies: [
-    proc_macro2_dep,
-    quote_dep,
-  ],
-)
-
-proc_macro_error_attr_dep = declare_dependency(
-  link_with: _proc_macro_error_attr_rs,
-)
-
-meson.override_dependency('proc-macro-error-attr-1-rs', proc_macro_error_attr_dep, native: true)
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
deleted file mode 100644
index 54f2376854504236689604f8ab08d351e4cceae9..0000000000000000000000000000000000000000
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ /dev/null
@@ -1,20 +0,0 @@
-project('unicode-ident-1-rs', 'rust',
-  version: '1.0.12',
-  license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
-  default_options: [])
-
-_unicode_ident_rs = static_library(
-  'unicode_ident',
-  files('src/lib.rs'),
-  gnu_symbol_visibility: 'hidden',
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  dependencies: [],
-  native: true,
-)
-
-unicode_ident_dep = declare_dependency(
-  link_with: _unicode_ident_rs,
-)
-
-meson.override_dependency('unicode-ident-1-rs', unicode_ident_dep, native: true)
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
deleted file mode 100644
index b7db03b06a019562b2ad77bb252d50b7e83c0b33..0000000000000000000000000000000000000000
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
-source_filename = proc-macro-error-1.0.4.tar.gz
-source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
-#method = cargo
-patch_directory = proc-macro-error-1-rs
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
deleted file mode 100644
index d13d8a239ac259132cd905bc512e9024b2f30fb8..0000000000000000000000000000000000000000
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-attr-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
-source_filename = proc-macro-error-attr-1.0.4.tar.gz
-source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
-#method = cargo
-patch_directory = proc-macro-error-attr-1-rs

-- 
2.45.2


