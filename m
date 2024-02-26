Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E987C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWNA-00020T-6p; Mon, 26 Feb 2024 03:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reWN2-0001zE-0x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reWN0-0005Pm-4t
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708936193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1eDmbIANOn5GUFnwUNctW2wFwCkHAYHYCToWMrxESA=;
 b=CDvxwg7uiVtqq9Cw6yAFwnLBJfp0INFrYpO9dwl1Nz+LpD4mmjJHxH7HFcBuG4hCEoqQeT
 AGMElfQvGasS1zn6NkwCkpVw5MCIkm1bzNogEZuZ8Mtc4pQ+ee3PEkEfejHD6z6V4VuuCR
 am/srYuMxRl+gL50U/mTQNWOdoazkJQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-LV2HJsL6PyKYlaCdauIpUA-1; Mon, 26 Feb 2024 03:29:48 -0500
X-MC-Unique: LV2HJsL6PyKYlaCdauIpUA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a431a294ebeso32232466b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936187; x=1709540987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1eDmbIANOn5GUFnwUNctW2wFwCkHAYHYCToWMrxESA=;
 b=e+dPiZt2U1WvXr7KMp0SFhKX/k+z/0X46sICDDS3PPoIVSdEqI8HEAhL0aLZjBWdVz
 eSc5R7L/GQLlstlZeOoAPKBMMCsjgAwtLQA4vDj6L+U84V7Ib1GG/wMMktRWnIuyLsvx
 cyqsJs7PudZFkx/wHt82MYKnTalFPOdNnlTxuXzKo2KihOlMq46duwuR+H74NiZTX/p1
 Pkf7wqet1UHW/XfbY9bPE29xFxBP2nFI3PC8PBU/7APKwJDNuyEdoStUW+Ivp3jtCQ6+
 Y09eN3eSHz0+9isqoS8ax5jWh/vIA8+s9dBCnOmNeOB6Mhl3GQQx+CQu574HrGSagYi+
 ggGg==
X-Gm-Message-State: AOJu0YzcGkKv5yKHVe/l389c8fIxfde4RwQ9Vq69qXKEhdd62KVJuJqX
 sWiBqr4dujDJrN3GN7HJ8cOP9ezMW1mXyFIW4rnyNz6leBEQs1yFkUTgaPwND5WxjJ5iSeSgZiE
 w9WWoiXerNOGWiPoH6lj2N2Ja7HpgzbkuyvKyrwoMricCvhFH5fH1+eCFy9v1MQ3w2mXIYjuunr
 rJRBD/rqA5cwKoAY85Ca/qJd678gX4bdis/WhG
X-Received: by 2002:a17:906:aed5:b0:a3f:ee60:4e15 with SMTP id
 me21-20020a170906aed500b00a3fee604e15mr4144270ejb.55.1708936187054; 
 Mon, 26 Feb 2024 00:29:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdFpKpC7Ruhw9H/LpSIe8mncILi6Ijo6d8qGOe++uiDEGkhYUABuXwcZGXjGmbYEw3V7sl7A==
X-Received: by 2002:a17:906:aed5:b0:a3f:ee60:4e15 with SMTP id
 me21-20020a170906aed500b00a3fee604e15mr4144254ejb.55.1708936186482; 
 Mon, 26 Feb 2024 00:29:46 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 kx5-20020a170907774500b00a3d81b90ffcsm2162974ejc.218.2024.02.26.00.29.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:29:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] ide: collapse parameters to ide_init_drive
Date: Mon, 26 Feb 2024 09:29:40 +0100
Message-ID: <20240226082941.90364-2-pbonzini@redhat.com>
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

All calls to ide_init_drive comes from ide_dev_initfn.  Just pass down the
IDEDevice (IDEState is kinda obsolete and should be merged into IDEDevice).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/ide/internal.h |  6 +-----
 hw/ide/core.c             | 40 ++++++++++++++++++---------------------
 hw/ide/qdev.c             |  5 +----
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 3bdcc75597d..0ad0d59d578 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -614,11 +614,7 @@ uint32_t ide_data_readw(void *opaque, uint32_t addr);
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
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 1b3b4da01df..9244c5a0fdb 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -208,10 +208,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
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


