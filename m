Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5D9CED247
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 22:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxwP4-0004Ut-UF; Mon, 07 Oct 2024 18:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tudor.reda@gmail.com>)
 id 1sxwCy-0003Ht-E1; Mon, 07 Oct 2024 18:28:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tudor.reda@gmail.com>)
 id 1sxwCw-0000w9-17; Mon, 07 Oct 2024 18:28:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so50922315e9.2; 
 Mon, 07 Oct 2024 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728340079; x=1728944879; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/FpSsDrrY8UDEAD5wnBVLHrAw5CrI7mLHyIeNNbQvX8=;
 b=dUnQQQ0UdYhVJ8WFJO4Rz3Ab7dD3JHHA+6/sxbRQVdQEi/xoi3Y3TEJbdy3hPs4VIo
 E+0eVM4gHQ8RXphhMHhs5770otPXVAQn1TWcl0QT8TeCbRvmNhSW7sDTkmGV0NUXSo+0
 6hreTFiJz15Xk4o8PFAvbk4YnJ0+m6gQ+OTPygAA3PgnbuE1BbkKqML1ldDm2CBYttv9
 YtUgx598HBHJiPYiZUEQi3WdI3hlsnVHKhIYiSaFZ0SdOi8kspX0T9YkkuIG8DB+qsrt
 5cQLR+9FOcqloqr9YU52SM6oTnUNpcM9eoKzhsaK2gF1EGib5xX49AOgt+AIQg4EL/Qq
 1jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728340079; x=1728944879;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/FpSsDrrY8UDEAD5wnBVLHrAw5CrI7mLHyIeNNbQvX8=;
 b=AZtX0mJhbaJKg9z0eRWsa1qaQVJBJ7oIBHzJgV/A6QT825aXOLzaaeQ8dmNZTSmocs
 txbRmBxJYjwEeyYmzSwkVpPtU0a/6yuFMQlHB00iZGZ2B5vT0U+m9SQvnTLbtRnCi5k/
 IKLs88EaFIJdCG3f3BIWZOy+SlhF0TFirMZZnuBXGbr2DKid8jR/jD19NRI/J2gI7KRe
 NUShNRVw3CEtUin9ZV0WWdMgcbZfAQYwKYFoCN9/vcyDpi8GIHuQr3ou7CvrdQx85BSM
 VOOH04i/jOGGvnK8u4nmQixIu19tLYaOd5rPdUyNXPXgwzBGYAX4CgLbKqFH+OQukFSO
 r1yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAGlxcsF5Dh/0/3ULpskJpIBMAJnwadb+I3NDeDllrBFHkU5fT2Zg1bSwENTNF37PuunuJN4j08EWHDEI=@nongnu.org
X-Gm-Message-State: AOJu0YwEgtcMrrUrfZR+V0FokONKJ9kJuj8roWjKFlRKiV7fpTfrweId
 Q3jGLxUVdjP23RFWcfx1mQ+prhzMkv+k1H6DnKymlh2FbjdyuxKQ
X-Google-Smtp-Source: AGHT+IGX9ElrXMmpXSpOMed4xtp7JiWeSgQHlf1pZ/XMumrfK8E4REuLqe+gA1woUED9wrrQv1LHJQ==
X-Received: by 2002:a05:600c:1d20:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42f85ae91dbmr93549765e9.27.1728340078922; 
 Mon, 07 Oct 2024 15:27:58 -0700 (PDT)
Received: from redaops ([146.70.124.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e8a58esm87883905e9.16.2024.10.07.15.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 15:27:58 -0700 (PDT)
Date: Tue, 8 Oct 2024 01:27:56 +0300
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: [PATCH] replace error_setg(&error_fatal, ...) with error_report()
Message-ID: <ZwRgbNs4Hz-Drt2V@redaops>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=tudor.reda@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Oct 2024 18:40:32 -0400
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

According to include/qapi/error.h:
* Please don't error_setg(&error_fatal, ...), use error_report() and
* exit(), because that's more obvious.

Patch updates all instances of error_setg(&error_fatal, ...) with
error_report(...), adds the explicit exit(1) and removes redundant
return statements.

Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2587
---
 hw/arm/allwinner-a10.c    | 5 +++--
 hw/arm/allwinner-h3.c     | 4 ++--
 hw/arm/allwinner-r40.c    | 4 ++--
 hw/arm/xlnx-versal-virt.c | 4 ++--
 hw/audio/soundhw.c        | 3 ++-
 system/vl.c               | 3 ++-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 08cdff61e4..3cc5142832 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/char/serial-mm.h"
 #include "hw/sysbus.h"
@@ -49,9 +50,9 @@ void allwinner_a10_bootrom_setup(AwA10State *s, BlockBackend *blk)
     g_autofree uint8_t *buffer = g_new0(uint8_t, rom_size);
 
     if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
-        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
+        error_report("%s: failed to read BlockBackend data",
                    __func__);
-        return;
+        exit(1);
     }
 
     rom_add_blob("allwinner-a10.bootrom", buffer, rom_size,
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 9bc57cd266..a1b4b1de1c 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -182,9 +182,9 @@ void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)
     g_autofree uint8_t *buffer = g_new0(uint8_t, rom_size);
 
     if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
-        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
+        error_report("%s: failed to read BlockBackend data",
                    __func__);
-        return;
+        exit(1);
     }
 
     rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index ced73009d6..b197530c38 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -231,9 +231,9 @@ bool allwinner_r40_bootrom_setup(AwR40State *s, BlockBackend *blk, int unit)
     struct boot_file_head *head = (struct boot_file_head *)buffer;
 
     if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
-        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
+        error_report("%s: failed to read BlockBackend data",
                    __func__);
-        return false;
+        exit(1);
     }
 
     /* we only check the magic string here. */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 962f98fee2..8b12d3e7cb 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -761,9 +761,9 @@ static void versal_virt_init(MachineState *machine)
             if (!flash_klass ||
                 object_class_is_abstract(flash_klass) ||
                 !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
-                error_setg(&error_fatal, "'%s' is either abstract or"
+                error_report("'%s' is either abstract or"
                        " not a subtype of m25p80", s->ospi_model);
-                return;
+                exit(1);
             }
         }
 
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index b387b0ef7d..d18fd9fa05 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -88,7 +88,8 @@ void select_soundhw(const char *name, const char *audiodev)
     struct soundhw *c;
 
     if (selected) {
-        error_setg(&error_fatal, "only one -soundhw option is allowed");
+        error_report("only one -soundhw option is allowed");
+        exit(1);
     }
 
     for (c = soundhw; c->name; ++c) {
diff --git a/system/vl.c b/system/vl.c
index fe547ca47c..50c138eece 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1841,7 +1841,8 @@ static void object_option_parse(const char *str)
 
         type = qemu_opt_get(opts, "qom-type");
         if (!type) {
-            error_setg(&error_fatal, QERR_MISSING_PARAMETER, "qom-type");
+            error_report(QERR_MISSING_PARAMETER, "qom-type");
+            exit(1);
         }
         if (user_creatable_print_help(type, opts)) {
             exit(0);
-- 
2.39.5 (Apple Git-154)


