Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF43C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyZ-0001lI-QP; Wed, 28 Feb 2024 03:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyY-0001jr-83
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyT-0000af-PV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiQu0qcepvLNgNVO8+FT105hczx+1saht4JobhIZWJ8=;
 b=fpHLjKFQTNZgnZxdx2rBsldC476qzHWysu+MAl1DJpLaBVpO3GjYc0Nmy16VJ45a8tGYGN
 Y3EJHV8D2CPATGuT6iCQbt+h01HKp31pNROjIMAIPbxkCbKrfQ6vHMBEewLoeye+V14SHV
 bcmCknxb7vfWdgdP+WMlsfveNAasTbI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-IHiRcwyLO6uLrqyLtbNwAQ-1; Wed, 28 Feb 2024 03:07:29 -0500
X-MC-Unique: IHiRcwyLO6uLrqyLtbNwAQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3e68c15996so240054866b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107647; x=1709712447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiQu0qcepvLNgNVO8+FT105hczx+1saht4JobhIZWJ8=;
 b=DpJfe1nELfl4fHshmDVb2hza6ONc3yXrleMOfEXr+2iin2v8GhBzDi6+ODto88TWdE
 Zx9O6rbVoCZdzNITlv0ZkRXjf3MeXParmUcfhG6pEf3uXdUGhm2xl5ocOR5J7GqrY8DV
 U0kVO2BDC6qgmiskcNBUYKTejXCXLIye+nxXYxb2yEngXG8Jv2ji3WiuO72sCmM3bbuI
 IQum0KO/Viilg6kApXB89o4R4YSZlpP6mWj2XhTHFu7GNVezTuqphqHG0ykageYv8GHF
 JxUXysmoZENHkxP5KdVpEAuJYdSFBtU6qg8XbxgnKu5kN0Sxqf5hXgE51zK+r5v3tbFO
 ofJw==
X-Gm-Message-State: AOJu0YzFS3dQ+shLLtg3bbAHdzZt3Sq54IKLARrHmePjO32UbkjBpeoh
 /Rf0YraJ9huhBMZGN/Z9wCYXc4+h4INSJCpBibZ9REqr5/VpAM0beunKm2YHNEv52r84dwXeGti
 CEN2s6YWpG5zl3qI3WAdIOiDBfOo+54H2eV57AVyIPf/DvKMwkyMrO8Ix18a6uFfL87ircoNyLL
 KaNPCcjrCRZNsb8ue/20tqc9/jB9aEwwyYOUPa
X-Received: by 2002:a17:906:f882:b0:a43:d063:91cd with SMTP id
 lg2-20020a170906f88200b00a43d06391cdmr1550683ejb.13.1709107646838; 
 Wed, 28 Feb 2024 00:07:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3qxGJfHwmTkrlF8u8fFbwLd3qvHSn2U9eNt4Tw8vnohb8xpbW/HKm6Jx40hhWqCzvNntGWA==
X-Received: by 2002:a17:906:f882:b0:a43:d063:91cd with SMTP id
 lg2-20020a170906f88200b00a43d06391cdmr1550674ejb.13.1709107646570; 
 Wed, 28 Feb 2024 00:07:26 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a170906c28800b00a3d2d81daafsm1587934ejz.172.2024.02.28.00.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] ide, vl: turn -win2k-hack into a property on IDE devices
Date: Wed, 28 Feb 2024 09:06:46 +0100
Message-ID: <20240228080646.261365-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/ide/ide-dev.h | 2 ++
 include/sysemu/sysemu.h  | 1 -
 hw/ide/core.c            | 3 ++-
 hw/ide/ide-dev.c         | 1 +
 system/globals.c         | 1 -
 system/vl.c              | 2 +-
 qemu-options.hx          | 3 ++-
 7 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 708cc0fda34..9a0d71db4e1 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -65,6 +65,7 @@ struct IDEState {
     int drive_serial;
     char drive_serial_str[21];
     char drive_model_str[41];
+    bool win2k_install_hack;
     uint64_t wwn;
     /* ide regs */
     uint8_t feature;
@@ -163,6 +164,7 @@ struct IDEDevice {
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
+    bool win2k_install_hack;
 };
 
 typedef struct IDEDrive {
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
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 900f80faf19..99f2f1226cf 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -31,6 +31,7 @@
 
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


