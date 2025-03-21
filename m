Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79289C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhE9-0001FO-IV; Fri, 21 Mar 2025 14:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhE5-00014x-U9
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhE4-00070X-5X
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hM94b7RjZwD5r8G5ixj1lC759u1MwLyQq0Zg/KCwTz0=;
 b=R7WokSoJFIug2d95ofE+KkPZja6umwlJ/F7LbPOPCEJLZ+ynC1gGRO0RbiKRFfTPeFQhwb
 5pIvT1OJH/7uxjCf/ArW/sEQ7pBf2q7lACwkJXTbJSX/lOEyWep3GOJdqgf8tjAy2DMmyh
 Qw/IroJYRfTxaeSMsbxV4flytCCFJqA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-lrLPxnuIMnujFumsoRIo1Q-1; Fri, 21 Mar 2025 14:36:10 -0400
X-MC-Unique: lrLPxnuIMnujFumsoRIo1Q-1
X-Mimecast-MFC-AGG-ID: lrLPxnuIMnujFumsoRIo1Q_1742582169
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d025a52c2so16562385e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582168; x=1743186968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hM94b7RjZwD5r8G5ixj1lC759u1MwLyQq0Zg/KCwTz0=;
 b=gSdpQP2oZz7H+esM4Y5+NVVBY0VtzB/jqhPj7qOoAKHecWBd6DgIBTxJ+5eN/scJuf
 JnepCSHwrH6mDwHTBW1+Gkv6BnXMKN4TIjuhyIeddLrl/U14K59VV13GydZ+PQOP2zX+
 m6U+f1I7xualBTzy7e+2ZqXCzesoS8KtHH9GN2KduTVhrpkW3hbyNnwEWLHPF9Y2ZWWI
 /OAsGtRizoU4CdxZOYrzIFSo0X+iDRebk1xp/Dps2lXkmABfwBWQdMkySXnD7zOrVqD2
 1CJMT7ePtxvVO60W8gw3lS+GAyz+VugpB+es8TRy2PX8ZS38Q9cLZM+ZFgovbwNPsl4v
 WVug==
X-Gm-Message-State: AOJu0YwiiV+2IS/4bPgl9WkA8ewjLFc3uInl1ciRQClzbtYLzo4UipRE
 +iMFz0mR8lZPEdtShRRMptcoJeed1C5ECC2QdfUeNmQNGDJ0TTZDsa80IgBz4QlzzqycggKCFIq
 m5EleqgcB0bjJt19rmSUsO6KaeE/RszOaYjpDOSK4TVIkA74DQL0BUG9aLwYzkemkQwKIH49qic
 jcS/W0DH/s/yLbAdvxj2FqJMv069b1xlq5+umh
X-Gm-Gg: ASbGncvQwsxiPyVs3lim+JAntayTiaDzt14W9XKfqrboMqN7cQX7SBKTydXNk4sm4Jy
 fPYaPxRghviUXhlWhSegFc1jj1UxAwWL+YzEnqO++N3n9lhDadi8WmHejiZAMmsZvbCcb8iaF9r
 Co4aq+ywh9UDPvXmrsDhEQxYcyCgyFItbIQoNpS268dwzq75SozeTjPekUFsaDuFEhwiMSlfYIX
 70fxxGaPC9o9I5DwRhPSo4XQrxh4/VlW5JEY7kdsgEfA9IBOhL6B7LJigApRdWfRvjRASPJHzjd
 SJZGI0eXfbnIBAEJUO4G
X-Received: by 2002:a05:600c:4ed3:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-43d509f8503mr48205675e9.17.1742582167648; 
 Fri, 21 Mar 2025 11:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERIdFFX2mSX424IJFKa6B987z61o6QPkdM24gRxnXfq56SCLHs/Jn34Hw4rHtd6jMRlzjLjQ==
X-Received: by 2002:a05:600c:4ed3:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-43d509f8503mr48205545e9.17.1742582167097; 
 Fri, 21 Mar 2025 11:36:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4174f8d3sm55870665e9.0.2025.03.21.11.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Tanish Desai <tanishdesai37@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/24] rust: Kconfig: Factor out whether PL011 is Rust or C
Date: Fri, 21 Mar 2025 19:35:33 +0100
Message-ID: <20250321183556.155097-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently every board that uses the PL011 duplicates the logic that
selects the Rust implementation if Rust was enabled and the C
implementation if it does not.  Factor this out into a separate
Kconfig stanza, so that boards can go back to simply doing "select
PL011" and get whichever implementation is correct for the build.

This fixes a compilation failure if CONFIG_VMAPPLE is enabled
in a Rust build, because hw/vmapple/Kconfig didn't have the
"pick the Rust PL011 if Rust is enabled" logic in it.

Fixes: 59f4d65584bd33 ("hw/vmapple/vmapple: Add vmapple machine type")
Reported-by: Tanish Desai <tanishdesai37@gmail.com>
Analyzed-by: Tanish Desai <tanishdesai37@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250319193110.1565578-2-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/Kconfig      | 30 ++++++++++--------------------
 hw/char/Kconfig     |  6 ++++++
 hw/char/meson.build |  2 +-
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 15200a2d7e7..a55b44d7bde 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -21,8 +21,7 @@ config ARM_VIRT
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
     select GPIO_PWR
@@ -75,8 +74,7 @@ config HIGHBANK
     select AHCI_SYSBUS
     select ARM_TIMER # sp804
     select ARM_V7M
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL022 # SPI
     select PL031 # RTC
     select PL061 # GPIO
@@ -89,8 +87,7 @@ config INTEGRATOR
     depends on TCG && ARM
     select ARM_TIMER
     select INTEGRATOR_DEBUG
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031 # RTC
     select PL041 # audio
     select PL050 # keyboard/mouse
@@ -108,8 +105,7 @@ config MUSCA
     default y
     depends on TCG && ARM
     select ARMSSE
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031
     select SPLIT_IRQ
     select UNIMP
@@ -173,8 +169,7 @@ config REALVIEW
     select WM8750 # audio codec
     select LSI_SCSI_PCI
     select PCI
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031  # RTC
     select PL041  # audio codec
     select PL050  # keyboard/mouse
@@ -199,8 +194,7 @@ config SBSA_REF
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
     select USB_XHCI_SYSBUS
@@ -224,8 +218,7 @@ config STELLARIS
     select ARM_V7M
     select CMSDK_APB_WATCHDOG
     select I2C
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL022 # SPI
     select PL061 # GPIO
     select SSD0303 # OLED display
@@ -285,8 +278,7 @@ config VEXPRESS
     select ARM_TIMER # sp804
     select LAN9118
     select PFLASH_CFI01
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select PL041 # audio codec
     select PL181  # display
     select REALVIEW
@@ -371,8 +363,7 @@ config RASPI
     default y
     depends on TCG && ARM
     select FRAMEBUFFER
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select SDHCI
     select USB_DWC2
     select BCM2835_SPI
@@ -448,8 +439,7 @@ config XLNX_VERSAL
     select ARM_GIC
     select CPU_CLUSTER
     select DEVICE_TREE
-    select PL011 if !HAVE_RUST # UART
-    select X_PL011_RUST if HAVE_RUST # UART
+    select PL011 # UART
     select CADENCE
     select VIRTIO_MMIO
     select UNIMP
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 3f702565e67..9d517f3e287 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -11,6 +11,12 @@ config PARALLEL
 
 config PL011
     bool
+    # The PL011 has both a Rust and a C implementation
+    select PL011_C if !HAVE_RUST
+    select X_PL011_RUST if HAVE_RUST
+
+config PL011_C
+    bool
 
 config SERIAL
     bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 86ee808cae7..4e439da8b9e 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_uart.c'))
 system_ss.add(when: 'CONFIG_PARALLEL', if_true: files('parallel.c'))
-system_ss.add(when: 'CONFIG_PL011', if_true: files('pl011.c'))
+system_ss.add(when: 'CONFIG_PL011_C', if_true: files('pl011.c'))
 system_ss.add(when: 'CONFIG_SCLPCONSOLE', if_true: files('sclpconsole.c', 'sclpconsole-lm.c'))
 system_ss.add(when: 'CONFIG_SERIAL', if_true: files('serial.c'))
 system_ss.add(when: 'CONFIG_SERIAL_ISA', if_true: files('serial-isa.c'))
-- 
2.49.0


