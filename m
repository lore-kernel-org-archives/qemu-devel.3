Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB29C79FA1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jC-0002Y5-Tt; Tue, 08 Sep 2026 23:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ds6gagoKCvElmTgeXrcanZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--stanleyjhu.bounces.google.com>)
 id 1x48j5-0002Wh-5Z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:11:56 -0400
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ds6gagoKCvElmTgeXrcanZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--stanleyjhu.bounces.google.com>)
 id 1x48j3-0004zI-3F
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:11:54 -0400
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so6526756a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923511; x=1789528311; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o1abFe5QNIdjftxiivQ5ppUFUH7EKLKLKn1t+ajtyG4=;
 b=gfjTAWiS4wcNrQhvHdLIbbf7s8j/N3y4VdbFaalZNVAbGYQLoG0iIkIDYDQ3So8QX3
 wZvEKoUYr5O/gVU5n84HLmubG6A8yOGXUPm8W0jIa4RqlbE1KhVKJAGavJtSL9d91Kct
 N6iScK4hCK6uBeyf4plTTArzBm7TXa6lqrDQjo/GVuZf2E5vL8TverE6W7LMYYBYhmIS
 BoJQPhzmsQYNuolb1QHJZgFtuwRFvDU0o3G8oOOBfi2LsW86Pez4Znaib1inUM9Sit/J
 sNtcU4GCtanRKav7pTrq2pEqB8xPLr9ZVZvp0VfrvUuFGHWuDVnXmLrw/B11/lWi98rf
 1w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923511; x=1789528311;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o1abFe5QNIdjftxiivQ5ppUFUH7EKLKLKn1t+ajtyG4=;
 b=X96vXu4uzV68Nd4hHoNBWRTIJrax83l7gAup9W7uLAnKgTnCQqY9KU3GI1WiV3HgTd
 SYvSmvBNM9v8pbYMhG4T1VYAFokFLZzO8H6OOQtRtC6iE+E58MDTQAn+L/px6P5+iXsH
 Lc/NWN7TovRh79Fa864n0D9mrXWOMmoLEfL5ru6ve/Gg/cYpuWmmxpGdSzDb++KyAk9D
 Vwj3aqcs2uQu9hyYJZp5/6XnyyFaKgfNHk8iIbTPkoF2sFKSsYo0Di4EhNxG8PA05pG+
 ac/aR7cv2Yy2WmZpwHiSPw4s1cyD8mTkBoJ4CFZrG7kNXeIvMN2za4zctc2AqA5O6Jz5
 W2gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzT2esRH8btZryKMwcxH6Pz26wcF+XrjNwRr0ru0li2I2ECBdywpTtxnbCx8799oSYy/k/RsCEHfm4S@nongnu.org
X-Gm-Message-State: AFuF++m04/34chBU3/IXhlh65yEsWVySy5QswEYOQH+SPlrmfamooxOO
 HalDYShjuLmhWOgXoEfP0ZP8rIYq95GbKn3lu6aiPaPo9iqoXszJRjLJbXi4iSc64VOvS8xzC8T
 onpkt1E2x2312LmAeGAvcSg==
X-Received: from pjni21.prod.google.com ([2002:a17:90a:8395:b0:39b:9879:9a])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-39b261ba63bmr49416131a91.11.1788923510934; 
 Tue, 08 Sep 2026 20:11:50 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:11:44 +0800
In-Reply-To: <20260909031146.1646684-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260909031146.1646684-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031146.1646684-2-stanleyjhu@google.com>
Subject: [PATCH v2 1/3] hw/ufs: Track SCSIRequest and cancel pending requests
 in ufs_clear_req
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1046;
 envelope-from=3ds6gagoKCvElmTgeXrcanZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1046.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In the UFS emulator, outstanding SCSI requests are dispatched asynchronously
to the block layer via scsi_req_enqueue(). When requests are cleared or
aborted (e.g. during HCE reset or TMR aborts), ufs_clear_req() releases the
scatter-gather list without cancelling the pending SCSIRequest. If an
asynchronous AIO callback completes afterwards, ufs_scsi_command_complete()
dereferences stale or freed request state, resulting in use-after-free
hazards.

Track the active SCSIRequest in UfsRequest and explicitly cancel any in-flight
requests in ufs_clear_req() before freeing request resources. To prevent
dangling references during cancellation cascades, decouple and clear req->sreq
in completion and cancellation handlers.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/lu.c  | 12 ++++++++++++
 hw/ufs/ufs.c |  6 ++++++
 hw/ufs/ufs.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bdb1650851..a62ebb51fd 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -173,6 +173,12 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
     int16_t status = scsi_req->status;
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
+    if (!req) {
+        return;
+    }
+
+    req->sreq = NULL;
+
     /* WB / HID accounting should only happen for successful commands */
     if (status == GOOD) {
         ufs_wb_process_write_req(req, transfered_len);
@@ -190,6 +196,11 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 
 static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
 {
+    UfsRequest *req = scsi_req->hba_private;
+
+    if (req) {
+        req->sreq = NULL;
+    }
     scsi_req->hba_private = NULL;
     scsi_req_unref(scsi_req);
 }
@@ -389,6 +400,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     SCSIRequest *scsi_req =
         scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
                      UFS_CDB_SIZE, req);
+    req->sreq = scsi_req;
 
     uint32_t len = scsi_req_enqueue(scsi_req);
     if (len) {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 3c4d7424da..adae6639e1 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2221,6 +2221,12 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 
 static void ufs_clear_req(UfsRequest *req)
 {
+    if (req->sreq != NULL) {
+        SCSIRequest *sreq = req->sreq;
+        req->sreq = NULL;
+        scsi_req_cancel(sreq);
+    }
+
     if (req->sg != NULL) {
         qemu_sglist_destroy(req->sg);
         g_free(req->sg);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6f2693b7ca..265a43faaa 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -60,6 +60,7 @@ typedef struct UfsRequest {
     UtpUpiuRsp rsp_upiu;
 
     /* for scsi command */
+    SCSIRequest *sreq;
     QEMUSGList *sg;
     uint32_t data_len;
 
-- 
2.55.0.1007.g17ff1f9808-goog


