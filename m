Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3F2C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyV-0001gr-2q; Wed, 28 Feb 2024 03:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyT-0001gY-OU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyN-0000YY-Ts
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImnxzicTPLHKm7joJu7uVvlR2wnz8WjZKAHxyJJxnEY=;
 b=ZCAvpc9Xcnl8S+meQYcnuTXmlrOJAxFFx+idXhC+dVzooiDj4aKnTdTXIROBZxdF0x1ppI
 7fyIoEGsQDYZLoE7UfbBP2zCM4ShD2GqBJfHlHKvMEEhQJ4TCJ6AF0xgkMgt/b5CYpePnU
 GoyIwMgGovq1PkxvDaKun2n7Mp9D1gI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-HoBdJAVNPAiglH0hAy1IIQ-1; Wed, 28 Feb 2024 03:07:26 -0500
X-MC-Unique: HoBdJAVNPAiglH0hAy1IIQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3e68c15996so240051766b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107644; x=1709712444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImnxzicTPLHKm7joJu7uVvlR2wnz8WjZKAHxyJJxnEY=;
 b=dwDyena9H57a0kAM8RJGCAmyAG7dqFu/UDGymyOMdXbABfIQ5gc8esGXaNRRBQxZJ9
 rWnaB7qzP8cUrbXyXAdlLu8VSb3c9I60rL0SQ8g19NGYhxTWwYv6kasEnL6bif6tvWw5
 8As/caLm8U6+wZxyv4XtxSNhtQ738No7uLOELbsmCFG2yJ35ODjitXoXIr287NUtw4/V
 tt3ibiXHHddH6YPddGkjs215antr2U7+w3AHjb+cNahRpljSrMIS8zKSufAGBqVeCKA1
 mWzPrWB74Ranj/AYkTgebMCsuDwZXokou0GJYloFTUN7otMhLDyf5Gxa9aQEUYpXT8pl
 +S8w==
X-Gm-Message-State: AOJu0Yx4RaNDsda7boCLgqrK4S9pFDKO7ACP1LWkzxOvBiMDutvm+Pzs
 glizTz7iwc0dKoTPIT4NBzX1pdwjhoaDiAMt+eE+LQubmuWecCoYggjyCbAZqmvY8S0NjAlZebl
 P839IddG0Ng478YusQKUHvlDtM9G8/oQHWYDbutt6dc7VMtUrN4X/3v+1hcW5gsOn6S3qHuyp6L
 vm2q6iVY6vPtW+UrfvmCpaUSECHcHYOqn/LTGR
X-Received: by 2002:a17:906:3b03:b0:a3e:422d:a27d with SMTP id
 g3-20020a1709063b0300b00a3e422da27dmr8919121ejf.47.1709107643902; 
 Wed, 28 Feb 2024 00:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/Xd2yGXGFJ8KZmxm2bK7ZTYZoQXMHabhvajGjEwW89nZ8y32K1HA2EVZtiKMwMPM1jToRBQ==
X-Received: by 2002:a17:906:3b03:b0:a3e:422d:a27d with SMTP id
 g3-20020a1709063b0300b00a3e422da27dmr8919108ejf.47.1709107643530; 
 Wed, 28 Feb 2024 00:07:23 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 lr17-20020a170906fb9100b00a440d567be7sm155221ejb.190.2024.02.28.00.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] ide: collapse parameters to ide_init_drive
Date: Wed, 28 Feb 2024 09:06:45 +0100
Message-ID: <20240228080646.261365-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All calls to ide_init_drive comes from ide_dev_initfn.  Just pass down the
IDEDevice (IDEState is kinda obsolete and should be merged into IDEDevice).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/ide/internal.h |  6 +-----
 hw/ide/core.c             | 40 ++++++++++++++++++---------------------
 hw/ide/ide-dev.c          |  5 +----
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 20dde37f458..0d64805da20 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -416,11 +416,7 @@ uint32_t ide_data_readw(void *opaque, uint32_t addr);
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_data_readl(void *opaque, uint32_t addr);
 
-int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
-                   const char *version, const char *serial, const char *model,
-                   uint64_t wwn,
-                   uint32_t cylinders, uint32_t heads, uint32_t secs,
-                   int chs_trans, Error **errp);
+int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp);
 void ide_exit(IDEState *s);
 void ide_bus_init_output_irq(IDEBus *bus, qemu_irq irq_out);
 int ide_init_ioport(IDEBus *bus, ISADevice *isa, int iobase, int iobase2);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 9c4a8129028..3c42d72ac25 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2589,24 +2589,20 @@ static const BlockDevOps ide_hd_block_ops = {
     .resize_cb = ide_resize_cb,
 };
 
-int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
-                   const char *version, const char *serial, const char *model,
-                   uint64_t wwn,
-                   uint32_t cylinders, uint32_t heads, uint32_t secs,
-                   int chs_trans, Error **errp)
+int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     uint64_t nb_sectors;
 
-    s->blk = blk;
+    s->blk = dev->conf.blk;
     s->drive_kind = kind;
 
-    blk_get_geometry(blk, &nb_sectors);
-    s->cylinders = cylinders;
-    s->heads = s->drive_heads = heads;
-    s->sectors = s->drive_sectors = secs;
-    s->chs_trans = chs_trans;
+    blk_get_geometry(s->blk, &nb_sectors);
+    s->cylinders = dev->conf.cyls;
+    s->heads = s->drive_heads = dev->conf.heads;
+    s->sectors = s->drive_sectors = dev->conf.secs;
+    s->chs_trans = dev->chs_trans;
     s->nb_sectors = nb_sectors;
-    s->wwn = wwn;
+    s->wwn = dev->wwn;
     /* The SMART values should be preserved across power cycles
        but they aren't.  */
     s->smart_enabled = 1;
@@ -2614,26 +2610,26 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
     s->smart_errors = 0;
     s->smart_selftest_count = 0;
     if (kind == IDE_CD) {
-        blk_set_dev_ops(blk, &ide_cd_block_ops, s);
+        blk_set_dev_ops(s->blk, &ide_cd_block_ops, s);
     } else {
         if (!blk_is_inserted(s->blk)) {
             error_setg(errp, "Device needs media, but drive is empty");
             return -1;
         }
-        if (!blk_is_writable(blk)) {
+        if (!blk_is_writable(s->blk)) {
             error_setg(errp, "Can't use a read-only drive");
             return -1;
         }
-        blk_set_dev_ops(blk, &ide_hd_block_ops, s);
+        blk_set_dev_ops(s->blk, &ide_hd_block_ops, s);
     }
-    if (serial) {
-        pstrcpy(s->drive_serial_str, sizeof(s->drive_serial_str), serial);
+    if (dev->serial) {
+        pstrcpy(s->drive_serial_str, sizeof(s->drive_serial_str), dev->serial);
     } else {
         snprintf(s->drive_serial_str, sizeof(s->drive_serial_str),
                  "QM%05d", s->drive_serial);
     }
-    if (model) {
-        pstrcpy(s->drive_model_str, sizeof(s->drive_model_str), model);
+    if (dev->model) {
+        pstrcpy(s->drive_model_str, sizeof(s->drive_model_str), dev->model);
     } else {
         switch (kind) {
         case IDE_CD:
@@ -2648,14 +2644,14 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
         }
     }
 
-    if (version) {
-        pstrcpy(s->version, sizeof(s->version), version);
+    if (dev->version) {
+        pstrcpy(s->version, sizeof(s->version), dev->version);
     } else {
         pstrcpy(s->version, sizeof(s->version), qemu_hw_version());
     }
 
     ide_reset(s);
-    blk_iostatus_enable(blk);
+    blk_iostatus_enable(s->blk);
     return 0;
 }
 
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index c8e2033469c..900f80faf19 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -118,10 +118,7 @@ void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         return;
     }
 
-    if (ide_init_drive(s, dev->conf.blk, kind,
-                       dev->version, dev->serial, dev->model, dev->wwn,
-                       dev->conf.cyls, dev->conf.heads, dev->conf.secs,
-                       dev->chs_trans, errp) < 0) {
+    if (ide_init_drive(s, dev, kind, errp) < 0) {
         return;
     }
 
-- 
2.43.2


