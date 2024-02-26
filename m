Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A08C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWOS-0003Nb-LQ; Mon, 26 Feb 2024 03:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reWNi-0002fV-Cs
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reWNg-0005lt-0E
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708936234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QB2QhgmyFYhyT6UFhg2UYF31nerIusNfV8qHdXYeS/o=;
 b=EroKxZycxW6KpY+53VxrrsWjRAs2/gccRSYqPkHHAuF9bhu0+Dceg0oMbpGORdmiW1kgLU
 z1XppQsV95zCBBAt9dZO61xLYeSJCy5J6/knQEt+6CMfSSG/v6AOjaeMFzGqUoDbl46N8w
 EjTXXsXnRnjI8j7sRjhT7d14qirghMY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-M5qzw9T6O9Cipe8CEc8Q-A-1; Mon, 26 Feb 2024 03:29:52 -0500
X-MC-Unique: M5qzw9T6O9Cipe8CEc8Q-A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5646f7fd7a9so1353633a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936190; x=1709540990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QB2QhgmyFYhyT6UFhg2UYF31nerIusNfV8qHdXYeS/o=;
 b=LCK0YqspZ1+IDgI5pNC1PrurBPQLWvmQ3qqFHhAD9gZzdIlKcCuWadw+pfH/V9XrGE
 41bd2v/BGSIMN3R5djS+IhR37Lxu7zKTWJkxFTCsNi/faJVQkrRvLLb+pG6mBv7X4D6h
 1M+WTKbCbbDRkNu8yqPT+uyW4vZTRMFG4FWQaZLMkKmwwwK3GzJw5ioQBTo5npDPMXE0
 LwMCvg88fPavjMZgxn+bQBNcuwxML2I7GoUeTyptnhMyP42JC1RO4QEV7NYHW5xymSHf
 ordnRtkdtYuoXZbOxEFkd8iRu94F/nkHH2j6AEskEhZ7MbPyztlQh+ZZYDvq03jf8h3a
 M37Q==
X-Gm-Message-State: AOJu0Yy5buifzjXHQ6rgugypNg3gIV2MtE/RXO8p6/rnYxTVEsSPfEvk
 JYyWEGB8SQv1PItrCzBibcqa/5L+bngGtu+Or4YuJRpjsArd2OhEZiVXc+n89ZTO+0jQ73gR5+2
 U+yGyjv9BdaTBtZ8SFWxox97mIBi3hheS29fjTilAm1w+UoGsahooa3fT48/0t2qI5P+v58eTs9
 Pld1FKpBatIr17jMR738+f2DsMLtW0+kFCZjVE
X-Received: by 2002:a05:6402:3447:b0:565:8e3a:5ad8 with SMTP id
 l7-20020a056402344700b005658e3a5ad8mr4116301edc.11.1708936190451; 
 Mon, 26 Feb 2024 00:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuRfltgvyZQX5PHRGWYOTN4/xuRJJBOK+4rPI7NK6zBphAY62TZsOEZxBRKPT8qijnnysASQ==
X-Received: by 2002:a05:6402:3447:b0:565:8e3a:5ad8 with SMTP id
 l7-20020a056402344700b005658e3a5ad8mr4116290edc.11.1708936190133; 
 Mon, 26 Feb 2024 00:29:50 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r7-20020aa7c147000000b00564d7d23919sm2066104edp.67.2024.02.26.00.29.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:29:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] ide, vl: turn -win2k-hack into a property on IDE devices
Date: Mon, 26 Feb 2024 09:29:41 +0100
Message-ID: <20240226082941.90364-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226082941.90364-1-pbonzini@redhat.com>
References: <20240226082941.90364-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/ide/internal.h | 2 ++
 include/sysemu/sysemu.h   | 1 -
 hw/ide/core.c             | 3 ++-
 hw/ide/qdev.c             | 1 +
 system/globals.c          | 1 -
 system/vl.c               | 2 +-
 qemu-options.hx           | 3 ++-
 7 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 0ad0d59d578..b743170d097 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -384,6 +384,7 @@ struct IDEState {
     int drive_serial;
     char drive_serial_str[21];
     char drive_model_str[41];
+    bool win2k_install_hack;
     uint64_t wwn;
     /* ide regs */
     uint8_t feature;
@@ -527,6 +528,7 @@ struct IDEDevice {
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
+    bool win2k_install_hack;
 };
 
 /* These are used for the error_status field of IDEBus */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 73a37949c24..eb1dc1e4eda 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -41,7 +41,6 @@ extern int graphic_height;
 extern int graphic_depth;
 extern int display_opengl;
 extern const char *keyboard_layout;
-extern int win2k_install_hack;
 extern int graphic_rotate;
 extern int old_param;
 extern uint8_t *boot_splash_filedata;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 3c42d72ac25..3f8c0ede2a1 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1059,7 +1059,7 @@ static void ide_sector_write_cb(void *opaque, int ret)
                            ide_sector_write);
     }
 
-    if (win2k_install_hack && ((++s->irq_count % 16) == 0)) {
+    if (s->win2k_install_hack && ((++s->irq_count % 16) == 0)) {
         /* It seems there is a bug in the Windows 2000 installer HDD
            IDE driver which fills the disk with empty logs when the
            IDE write IRQ comes too early. This hack tries to correct
@@ -2597,6 +2597,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
     s->drive_kind = kind;
 
     blk_get_geometry(s->blk, &nb_sectors);
+    s->win2k_install_hack = dev->win2k_install_hack;
     s->cylinders = dev->conf.cyls;
     s->heads = s->drive_heads = dev->conf.heads;
     s->sectors = s->drive_sectors = dev->conf.secs;
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 9244c5a0fdb..61dba354302 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -41,6 +41,7 @@ static void idebus_unrealize(BusState *qdev);
 
 static Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
+    DEFINE_PROP_BOOL("win2k-install-hack", IDEDevice, win2k_install_hack, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/system/globals.c b/system/globals.c
index 5d0046ba105..e3535842010 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -40,7 +40,6 @@ int autostart = 1;
 int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
-int win2k_install_hack;
 int graphic_rotate;
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
diff --git a/system/vl.c b/system/vl.c
index 98bf0c386b4..e480afd7a00 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3265,7 +3265,7 @@ void qemu_init(int argc, char **argv)
                 pid_file = optarg;
                 break;
             case QEMU_OPTION_win2k_hack:
-                win2k_install_hack = 1;
+                object_register_sugar_prop("ide-device", "win2k-install-hack", "true", true);
                 break;
             case QEMU_OPTION_acpitable:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("acpi"),
diff --git a/qemu-options.hx b/qemu-options.hx
index 1136642c21d..9a47385c157 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2641,7 +2641,8 @@ SRST
 ``-win2k-hack``
     Use it when installing Windows 2000 to avoid a disk full bug. After
     Windows 2000 is installed, you no longer need this option (this
-    option slows down the IDE transfers).
+    option slows down the IDE transfers).  Synonym of ``-global
+    ide-device.win2k-install-hack=on``.
 ERST
 
 DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
-- 
2.43.2


