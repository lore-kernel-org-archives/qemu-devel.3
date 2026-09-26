Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6372C9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMPt-0002H0-8X; Sat, 26 Sep 2026 03:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPq-0002Fo-6U
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:46 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPo-0000Rt-9H
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:45 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3429bca3880so925250eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406102; x=1791010902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gvdLUze2sQ9rH6tf9YWuWP18ipAcGMhXKG5e40lFeJk=;
 b=Y5z0WrAgGi6ZZmqa6aFZZyvy29g+3VHviZL1XoP/Z976UfCcD9JrlmeW7pVCQxwzgK
 J17xhQoRs0R1lT9DXTmNEp1gZlgkUuDYhIAcv8PiF/MIobBO3deD4mfwg4vB4nrVKN8O
 bSd6fgpE9ehVIevN9QYeUSEnrcZKltFIGJUH2pxjRuzz25iP2sZL3+SnoKB7QF90uGTT
 Z4ufpdbxZxrVxfWcCrt1Xt+9z9Z0+lBfkwXsLtN1XXulLXDQCYkT9XluBXUKypva0pfp
 E+VU87Z0P8vr6jpeh5rP4sLT6Ty4tFI7EG4N1DF/Q67ZvTPHdq5BcbdNfrAfcS9wpwNS
 yUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406102; x=1791010902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gvdLUze2sQ9rH6tf9YWuWP18ipAcGMhXKG5e40lFeJk=;
 b=BxwiLIAWY9tyKgaewRzrKWocV6+lrQ2+ufOOs0HJOFFykc2asPc655lp8jMikFkUir
 s6+PXDAn6BLSEm+qL3fcwGmhIjYmeAJpy9mfl1W8ApMnIkwspTNeeRDtPzRfidZOAOua
 JgT2Y5LbQL4GDM4W8B/0ws18Y1R0VdTBPwP+tqT3at4KGZBYqyczqK1qIlo3Cdtgdca7
 KyS6jBgwlKEViQyZbroP1PkipxXTrqkIhebyEK4pv8JCU7fEhmnse5CHY63I9kAIgHhB
 x9XOC0rR6AphJPHOEqlEOhvlxHIoEAYgh+ZpyshoE8h4VsTvJ91FscccxDRystdsg0VC
 mfRw==
X-Gm-Message-State: AFuF++lmy1on3ahsqjfg0soEKQLyQlupCUXLe0Pzq9ggvxQQ3j/esvGm
 FZ7XY25vOb2jjoMPMvaGCGfcVlMjpDTZERvVW6hSVXwWh+NzMo+4oBtve6rZA0Kl
X-Gm-Gg: AYBFou1LdlTlycB/Z68GcQ0MtlDpkv5cM4le5BbfnfAePI5MTXTNoppEDGNv2cm2jnj
 zZ2KTt9j937lNKZSZYrdX/ZVJLf+i8xWKFsyDfCq4/3oJMI+5s3LpVSuc5bKehFBNztVaHCOF3N
 0ebMjtgK7y2vwmrmv+D4NrRKnfkZoNaJQP2cK7ZBUpT7I1CwTGkIQ2cFYjScAN0vUrMfXV9Xtns
 mkL58uodBZ7BOvMXeeDNbBzc/wpwxjaqypwQYOfcaAlmTck9adcj9f6YxeQIsoDW9wnfYrOr127
 LbL9Kc4wGZ1toT7jmBmqN65QJphebJUcAzfz5KR94fh3H6M04Qo7vPVA1Ff+ZrHBfnIgGLuJowI
 RL7U6NUtrka60ve6c61KfnfXcO6psD+qMGipDFCi/4+EqPLZ6WTdAK15P4pGEGSnk76cwCaIzUm
 MBcemkrb0IoiU/wmyNVw8ElUiIEbYvabOEMIGdB1X8ek/c+NTRGjKMH6BgAzDLSEoA+SZZ9w1nz
 h7r8bJU+IVVFdFz4nwqK8ypSaHyErI=
X-Received: by 2002:a05:7301:1506:b0:33b:e529:4446 with SMTP id
 5a478bee46e88-3426febb75bmr2199672eec.5.1790406101084; 
 Sat, 26 Sep 2026 00:01:41 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:01:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 09/55] kconfig: rename REGISTER to HW_REGISTER
Date: Sat, 26 Sep 2026 15:00:08 +0800
Message-ID: <20260926070057.1234-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename config REGISTER to HW_REGISTER. register is a C keyword, and a
later TargetKconfig commit will use it as a struct member.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/Kconfig          | 2 +-
 hw/core/Kconfig     | 2 +-
 hw/core/meson.build | 2 +-
 hw/dma/Kconfig      | 4 ++--
 hw/i2c/Kconfig      | 2 +-
 hw/usb/Kconfig      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/Kconfig b/hw/Kconfig
index c92ca2b13a3..94f963f2944 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -85,7 +85,7 @@ config XILINX_AXI
 
 config XLNX_ZYNQMP
     bool
-    select REGISTER
+    select HW_REGISTER
     select CAN_BUS
     select PTIMER
     select XLNX_BBRAM
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index d1bdf765ee8..839e249b9d0 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -29,7 +29,7 @@ config PLATFORM_BUS
     bool
     depends on DEVICE_TREE
 
-config REGISTER
+config HW_REGISTER
     bool
 
 config SPLIT_IRQ
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 8fe776d2c86..1c645d7041d 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -21,7 +21,7 @@ system_ss.add(when: 'CONFIG_GUEST_LOADER', if_true: files('guest-loader.c'))
 system_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
 system_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
-system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
+system_ss.add(when: 'CONFIG_HW_REGISTER', if_true: files('register.c'))
 system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 0a23e7d7b87..8f221b20634 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -16,7 +16,7 @@ config I8257
 
 config ZYNQ_DEVCFG
     bool
-    select REGISTER
+    select HW_REGISTER
 
 config XLNX_ZDMA
     bool
@@ -29,7 +29,7 @@ config SIFIVE_PDMA
 
 config XLNX_CSU_DMA
     bool
-    select REGISTER
+    select HW_REGISTER
 
 config K230_GSDMA
     bool
\ No newline at end of file
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 0766130b596..3482f475cf9 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -20,7 +20,7 @@ config ARM_SBCON_I2C
 
 config DESIGNWARE_I2C
     bool
-    select REGISTER
+    select HW_REGISTER
     select I2C
 
 config ACPI_SMBUS
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index e8c00f813a6..43771291a06 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -137,7 +137,7 @@ config IMX_USBPHY
 config USB_DWC3
     bool
     select USB_XHCI_SYSBUS
-    select REGISTER
+    select HW_REGISTER
 
 config XLNX_USB_SUBSYS
     bool
-- 
2.52.0.windows.1


