Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB8F4BB71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux21-0002tT-VX; Tue, 24 Feb 2026 13:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1x-0002eF-Am
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1r-0004FM-7b
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:05 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so5147792f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957260; x=1772562060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkNy59D0Uu4igVYE18UvDQMuUJbqf46KWffVZeykai8=;
 b=K6ob9EA4I+SHxC4y5VDU06zyqBaiISM9uNAEMBYtHO9L1U0AgF9vKtyomeFZVumRAn
 WLRstTwxkNKgkJGWEEoZm0PpeHeB0WtXKIWcDZujzBXf1DcK9YQEbIIKXeGhINjCwxmK
 OdcF2kZkEEyNl6D64cer5oP03tDCGWkOh89/yiDM1EwCfqUuB4TLtNeqwKUBTQ66MliM
 zyM+LCr/8nCTtUwT0hcXkEKZNU1XU6/pf/456qRgOps9/jVgpAb+XunrRYgJ9ACHNhlz
 KO7rcP+vGXIgP50owW4kQeacJjr77ImoEQ7dggwrEOl36ihRlAJrtryWyHuE8nVflT52
 Vftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957260; x=1772562060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jkNy59D0Uu4igVYE18UvDQMuUJbqf46KWffVZeykai8=;
 b=K60CCfHd5fbYjSJP/N9X22VoyixrHDHi4KcQsLrYA0KjDmNLPQdbWUQ0+kGY6edv6/
 DEinGVOcLRjH8YBQ0z3R3XvMOBAUhQCoEPXm3FwxEbI6kClPxHDqW329uoNWCccMJ9HS
 5YwdpeiNOeXZWlIMMAXUyOORe6qUKOrGYUfqcJ8rbCzJja6QhU39GiypdlTSPRoRbCVE
 B+A7FDrqAE6WssdRrD+IUnY9CxAcSvFbvRhB6O8SApFORfBgy8FWLK0o5Cqa8YzZ7utJ
 MIxxzon2XqRKp7z8QeqPaZIf2/phLIceBDje87Bo3Ht97qJ1FTlKsFZQE4C2xZS9X8mc
 CYnA==
X-Gm-Message-State: AOJu0YxDulu9AsQAuHbAu8r8qRIMLZBah+uQlYH9aUEQS0kkwaW7OZSB
 DrnEOlDhcOqN9jfwS6rLqEaB2njAH57HxYZlwnSCumMrtjYID358de36LCvM1bWIyqXneafR6Mq
 KkF1jKeQ=
X-Gm-Gg: ATEYQzx+QkgdTusAJpSBXU34Q2CmuDVS/XVFBif60bZdKo9rIbGJSrBfnWsQHW9RhKG
 3ZfArHcfinSWQzhfYogGC48TQg7weTSapzf4UFlSVXzz4NqcdGTsBuB3pkGlHnF/u/ag90zdjZb
 Fmr8ui9FuFZ6k7fGVJSttMDb3o4ayfnc07M6S//4GklcCK5YNehaoAPXNJROkuYhLd+f5Zd702A
 f80VVFJGTLYzNNkuZ//5XrfwTQug+2AVxECEO8nBXOxdOFXzo3d/KK/KwHJDJvg0H14D9hGgfnK
 PBhW1ZkOf5U6SxkasCht1ZNP2R1vNkethUqC0GxcfHpmD+kFT8uKs2i39HEBgc5HouXgN6hC+Ea
 quN1cyy884o8yKV7B/jIPAc4FYOb1n82Uo7xASIk5LRHulrMrCvl0BbbtxQuA0WlVHjGm0zZISr
 mqEnfiwb1pGZjoPrSkMhhK/9FFQrxk8C5Mod+QcmIBSpwLqSeyXNVO0lyVM4c11qJubWIZOGtW
X-Received: by 2002:a05:6000:2c0e:b0:436:da9:4371 with SMTP id
 ffacd0b85a97d-4396f154441mr24301035f8f.5.1771957259837; 
 Tue, 24 Feb 2026 10:20:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9f77sm29287550f8f.5.2026.02.24.10.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/10] hw/display: Build stubs once
Date: Tue, 24 Feb 2026 19:20:12 +0100
Message-ID: <20260224182017.99865-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/acpi-vga-stub.c |  1 +
 hw/display/meson.build     | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

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
2.52.0


