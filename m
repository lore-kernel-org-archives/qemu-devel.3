Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265A9FEDA0E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Zh9-0005QM-A7; Tue, 17 Mar 2026 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zh7-0005Px-8S
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zh5-000600-9a
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so50531105e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774185; x=1774378985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IN3mmd8Urjjjp+liaxE/z6bIhAV5QP0h8A82qKPCmjg=;
 b=SlN0qITY4vsVX4uCoEzXiRpQCDnPi5mXxB2j163454wvq32kVxlJcV7sK2xaj9ASc6
 a6XoE1d2ck97mSuiKvXrFAWeIghJbkCEX4j9Kgj6ggg5kpvQ/q6ihIQ0b9UTm2CZqg6i
 8z4sY6ARmCaEySjIiw+ISmXU60bNz8qD5P80jYDlRb1vfvXIgf6Jxt4a5H4f++uYXlWT
 B10VpOw6RCBVmepQsGmkaDlMcWBmZ/b96sJPcC4Nhc0ZAmAct2IX8ODAWSo1IIAF97ep
 61b8J096x/u1cJ30jzI4qKi1yxr8uoipT/2cRae9OAZ/8yzeeh++M8b0xeafBICssiRo
 9ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774185; x=1774378985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IN3mmd8Urjjjp+liaxE/z6bIhAV5QP0h8A82qKPCmjg=;
 b=BxNA1cWFlXWWJv6RJzupozgkkp+Tq+HG1+zLp3QDJBWX0JLRPHz9z5Zz9vmMNBs48s
 HK2DfLsRQhBdnK4yYnu5GKpzI0ruO1dGBLSjflWRo8jD6JjXjR4i/i10C1KwOX7yfsSX
 4oJETFLtvQDw/2OqMhSPs3ygunbgZDmGOvE2lxUFjZlQa9NL7QL7lYAff8cs6qJ5aOsm
 odjQPhTm3H2n9zWHE+IMoFyb/vdVIuAaR5p6DrlmOYzYlHxUrs/6qloGYYCjxW9986gp
 CaIF7kQIJwrymxDzKqQk35YwkuxHuxAvymAvb+eom3qUOTTuT5uwkqGUt1337uq89sYZ
 NuKw==
X-Gm-Message-State: AOJu0YzAY9A+UJ+ozEXTncb2rv8lC/Pa1RY8gMtV5XAgen+KQxFWbU8w
 3tQG0QKyFSCq3aWe9ncV+i76M2tUitBL2dVX4+gwAIaj7oFETlxLpWqcTMPdPPLSo4B3Wkky6pL
 JRvd8mOs=
X-Gm-Gg: ATEYQzyLfN+MRR7nFCp5kKQqJkb3UU/Sdf6LlkypQuavzxipilzM5B24PnKmDWxu+cZ
 lZL8Uj5EMUXdiO5t1aR9dd98fCqDCm/65EhK5kCIoDhH4H7pePztr5ozcV5DclkPeRXBwEx0vED
 OP7rdzlyXxWJHiIfwJ9SYA3i9zbVn1VW6WJTFBBMeXxFyJwfGbbYsJqVO1xCUChI6JAGAVv4V9G
 lq6AyCMKLN+noNAhQJhJ4DPv6ynyx5IcXz37Kyc3dZdu7uHGjCgJwTiQYqC10WCUi4eH1VXmNSi
 S5MH6ii8NijMGs1sOBXGXat1JI32vH6cTFdQBtudlIpzJX0rZrGc99znw3XxY1f4OZWpsZ5qaWu
 cUN1TDzPmoGwz5bYxwPEbYkrY7ng0trRIrDt/aqmrS4/auNBdldXHrWztF3jFWXsHMhJL7mAUqj
 FWPRfcYsNuBHCGcGor3LoHEet8r4UvSvQrW5X3Er1xN+ikpD444TR2RsZ54Ivo4RpCy0vZd3uR
X-Received: by 2002:a05:600c:5392:b0:485:40c6:f526 with SMTP id
 5b1f17b1804b1-486f4451109mr12140925e9.26.1773774185114; 
 Tue, 17 Mar 2026 12:03:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4b9892esm348185e9.19.2026.03.17.12.03.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 12:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] hw/display: Build stubs once
Date: Tue, 17 Mar 2026 20:02:47 +0100
Message-ID: <20260317190250.70506-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317190250.70506-1-philmd@linaro.org>
References: <20260317190250.70506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Add pixman to qemuutil library dependencies since pixman is
transitively included, which is needed to be able to include
prototypes for stubs we declared:

  In file included from include/ui/console.h:4,
  include/ui/qemu-pixman.h:10:10: fatal error: pixman.h: No such file or directory
     10 | #include <pixman.h>
        |          ^~~~~~~~~~

On OpenBSD, opengl headers are not available in default
include path, and thus we need to add opengl to list of
qemuutil dependencies, otherwise we get:

  In file included from ../hw/display/acpi-vga-stub.c:4:
  In file included from ../hw/display/vga_int.h:28:
  In file included from include/ui/console.h:9:
  include/ui/surface.h:11:11: fatal error: 'epoxy/gl.h' file not found
  # include <epoxy/gl.h>
            ^~~~~~~~~~~~
  1 error generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225035739.42848-8-philmd@linaro.org>
---
 meson.build                |  2 +-
 hw/display/acpi-vga-stub.c |  1 +
 hw/display/meson.build     | 19 ++++++++-----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index b2154bb9287..ab726ea1152 100644
--- a/meson.build
+++ b/meson.build
@@ -3781,7 +3781,7 @@ util_ss = util_ss.apply({})
 libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt])
+                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt, pixman, opengl])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res,
                               dependencies: [event_loop_base])
diff --git a/hw/display/acpi-vga-stub.c b/hw/display/acpi-vga-stub.c
index a9b0ecf76d0..ee0fbf8175d 100644
--- a/hw/display/acpi-vga-stub.c
+++ b/hw/display/acpi-vga-stub.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#undef CONFIG_PIXMAN
 #include "hw/acpi/acpi_aml_interface.h"
 #include "vga_int.h"
 
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c041bdb..e730c289b15 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -3,7 +3,8 @@ hw_display_modules = {}
 system_ss.add(when: 'CONFIG_DDC', if_true: files('i2c-ddc.c'))
 system_ss.add(when: 'CONFIG_EDID', if_true: files('edid-generate.c', 'edid-region.c'))
 
-system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'), if_false: files('ramfb-stubs.c'))
+system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'))
+stub_ss.add(files('ramfb-stubs.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb-standalone.c'))
 
 system_ss.add(when: 'CONFIG_VGA_CIRRUS', if_true: files('cirrus_vga.c'))
@@ -36,21 +37,20 @@ system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
 system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
 
+stub_ss.add([files('acpi-vga-stub.c'), pixman])
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
     config_all_devices.has_key('CONFIG_VMWARE_VGA') or
     config_all_devices.has_key('CONFIG_ATI_VGA')
    )
-  system_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                      if_false: files('acpi-vga-stub.c'))
+  system_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
 endif
 
 if config_all_devices.has_key('CONFIG_QXL')
   qxl_ss = ss.source_set()
   qxl_ss.add(when: 'CONFIG_QXL', if_true: [files('qxl.c', 'qxl-logger.c', 'qxl-render.c'),
                                            pixman, spice])
-  qxl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                  if_false: files('acpi-vga-stub.c'))
+  qxl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
   hw_display_modules += {'qxl': qxl_ss}
 endif
 
@@ -119,16 +119,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
                     if_true: [files('virtio-vga.c'), pixman])
   virtio_vga_ss.add(when: 'CONFIG_VHOST_USER_VGA',
                     if_true: files('vhost-user-vga.c'))
-  virtio_vga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                         if_false: files('acpi-vga-stub.c'))
+  virtio_vga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
   hw_display_modules += {'virtio-vga': virtio_vga_ss}
 
   if virgl.found() and opengl.found()
     virtio_vga_gl_ss = ss.source_set()
     virtio_vga_gl_ss.add(when: ['CONFIG_VIRTIO_VGA', virgl, opengl],
                          if_true: [files('virtio-vga-gl.c'), pixman])
-    virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                              if_false: files('acpi-vga-stub.c'))
+    virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
     hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
   endif
 
@@ -136,8 +134,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
     virtio_vga_rutabaga_ss = ss.source_set()
     virtio_vga_rutabaga_ss.add(when: ['CONFIG_VIRTIO_VGA', rutabaga],
                                if_true: [files('virtio-vga-rutabaga.c'), pixman])
-    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
-                                                    if_false: files('acpi-vga-stub.c'))
+    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'))
     hw_display_modules += {'virtio-vga-rutabaga': virtio_vga_rutabaga_ss}
   endif
 endif
-- 
2.53.0


