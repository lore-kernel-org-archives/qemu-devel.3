Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B3AC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUib2-0001cg-V5; Tue, 30 Jan 2024 02:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUib0-0001cN-EO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:31:50 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUiat-0001eQ-Ee
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:31:49 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5101cd91017so3929687e87.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706599899; x=1707204699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuV7zyjYwtPUjtBjnNdL9VYj7gFFuA+/Qvw13n53RtQ=;
 b=h3JN7bp8wHzuajnvxGhlUYBj8Rflot8Yn621GZTvjKh7t/6p0gaS86EEQrqUsr3IiP
 IMox7jgmc/w4clc6cYVrBGKiwT7J13zdAqkzyW9b3fMuy5F47x8OaxUFd2HH8NzRzW61
 RTE0D6CjLdUVqRP3JMbbrVHAFdY/hEO/jdnPcoNWDkUO9lO6MwY/CXqi9OGrEk3HrPYx
 MgqBtzBWLEwMSioTgKnFiFm+hhYhZvLOrWFiIbF/ezOKMjxlzubz//r6km/sOxwmRiyj
 K3b3zZ308/Q/p/XIpoaEwSh7K1v3M/fbvrZzFAxE+N5OguxL2AaJGCHrR4vyiaJrnoil
 bjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706599899; x=1707204699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OuV7zyjYwtPUjtBjnNdL9VYj7gFFuA+/Qvw13n53RtQ=;
 b=OSGhkannxKLyxr38BuELWwZgkeknMEAU7/+2ojTf2DmSMWs2B9yeTkPonXfe0CIRSj
 ntWlN/ma2d1yUXO1JHoipmzZcGQbi2n8WJ8phCnldH8tbGX+2HFLGhyt78If/asxyXMX
 uAnV95+amHyJCeXYhjjcpseh5HI4EJAUrHfkerQsnC9VzyRA/zML04XHoSBnaIr+JnGs
 K3nt2tuY3r9Zl/3QDYPcB5uRQl8aA9LsjgBDtqlLCkXDJ3kOS7RQw5ogO24eR+M4tWPF
 wHKZP6IoMxHQ8ViZz0GKZvHDoqdCJEuy4WjW+JTiJShn2Y6+kmLU3BztWghI/JTXvZa/
 c8IQ==
X-Gm-Message-State: AOJu0Yw21Mon4PLPYtg5Wm4hsAzbDGJln3X6IAensVVSr3eS3Lpto9t8
 SGu3axDXZyupw+wFsLYd1ZdQgjnIQa5rEwmQgC83g5F8Dv9jzcUagbhJG6Wb860R/7+MxvXMmhE
 oZ4s=
X-Google-Smtp-Source: AGHT+IGL0ZBFQANNugWD26srVi66BCFP3teEdE5dpcVJQob+pNyt48U2N7mVH21iAgO+A3kfF89Gvg==
X-Received: by 2002:a05:6512:3b21:b0:510:544:78f with SMTP id
 f33-20020a0565123b2100b005100544078fmr5554230lfv.14.1706599899499; 
 Mon, 29 Jan 2024 23:31:39 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 bj26-20020a0560001e1a00b0033ae6530969sm7174070wrb.85.2024.01.29.23.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 23:31:39 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 2/2] hw/block/block.c: improve confusing
 blk_check_size_and_read_all() error
Date: Tue, 30 Jan 2024 09:30:32 +0200
Message-Id: <7260eadff22c08457740117c1bb7bd2b4353acb9.1706598705.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
References: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In cases where a device tries to read more bytes than the block device
contains, the error is vague: "device requires X bytes, block backend
provides Y bytes".

This patch changes the errors of this function to include the block
backend name, the device id and device type name where appropriate.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/block/block.h |  4 ++--
 hw/block/block.c         | 25 +++++++++++++++----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 15fff66435..de3946a5f1 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -88,8 +88,8 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 
 /* Backend access helpers */
 
-bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
-                                 Error **errp);
+bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
+                                 void *buf, hwaddr size, Error **errp);
 
 /* Configuration helpers */
 
diff --git a/hw/block/block.c b/hw/block/block.c
index 9f52ee6e72..ec4a675490 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -54,29 +54,30 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
  * BDRV_REQUEST_MAX_BYTES.
  * On success, return true.
  * On failure, store an error through @errp and return false.
- * Note that the error messages do not identify the block backend.
- * TODO Since callers don't either, this can result in confusing
- * errors.
+ *
  * This function not intended for actual block devices, which read on
  * demand.  It's for things like memory devices that (ab)use a block
  * backend to provide persistence.
  */
-bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
-                                 Error **errp)
+bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
+                                 void *buf, hwaddr size, Error **errp)
 {
     int64_t blk_len;
     int ret;
+    g_autofree char *dev_id = NULL;
 
     blk_len = blk_getlength(blk);
     if (blk_len < 0) {
         error_setg_errno(errp, -blk_len,
-                         "can't get size of block backend");
+                         "can't get size of %s block backend", blk_name(blk));
         return false;
     }
     if (blk_len != size) {
-        error_setg(errp, "device requires %" HWADDR_PRIu " bytes, "
-                   "block backend provides %" PRIu64 " bytes",
-                   size, blk_len);
+        dev_id = qdev_get_human_name(dev);
+        error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
+                   " bytes, %s block backend provides %" PRIu64 " bytes",
+                   object_get_typename(OBJECT(dev)), dev_id, size,
+                   blk_name(blk), blk_len);
         return false;
     }
 
@@ -89,7 +90,11 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
     assert(size <= BDRV_REQUEST_MAX_BYTES);
     ret = blk_pread_nonzeroes(blk, size, buf);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "can't read block backend");
+        dev_id = qdev_get_human_name(dev);
+        error_setg_errno(errp, -ret, "can't read %s block backend"
+                         " for %s device '%s'",
+                         blk_name(blk), object_get_typename(OBJECT(dev)),
+                         dev_id);
         return false;
     }
     return true;
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 26ce895628..0a12030a3a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1617,7 +1617,8 @@ static void m25p80_realize(SSIPeripheral *ss, Error **errp)
         trace_m25p80_binding(s);
         s->storage = blk_blockalign(s->blk, s->size);
 
-        if (!blk_check_size_and_read_all(s->blk, s->storage, s->size, errp)) {
+        if (!blk_check_size_and_read_all(s->blk, DEVICE(s),
+                                         s->storage, s->size, errp)) {
             return;
         }
     } else {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f956f8bcf7..1bda8424b9 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -848,8 +848,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage, total_len,
-                                         errp)) {
+        if (!blk_check_size_and_read_all(pfl->blk, dev, pfl->storage,
+                                         total_len, errp)) {
             vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
             return;
         }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6fa56f14c0..2314142373 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -902,7 +902,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage,
+        if (!blk_check_size_and_read_all(pfl->blk, dev, pfl->storage,
                                          pfl->chip_len, errp)) {
             vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
             return;
-- 
γαῖα πυρί μιχθήτω


