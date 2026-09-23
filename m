Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDC2C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OHn-0006Mr-3V; Wed, 23 Sep 2026 10:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36uazagoKCuMXYFSQJdOMZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHh-0006Kc-E7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:21 -0400
Received: from mail-pf1-x445.google.com ([2607:f8b0:4864:20::445])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36uazagoKCuMXYFSQJdOMZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHf-00014p-8W
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:21 -0400
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-86917d18880so837418b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174955; x=1790779755; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VXrVapuWvSJm7rcWHE7Jo96roAfMJ04rFyL6n3yRULQ=;
 b=IzmGx3D5YYitVJCOybBuRzvcU3tyU+/1e7jcE78S5S2aNUlavh4rjEl1236kYim2gb
 nup7IT9uCe94tOf8wI1nihOBfAKT5ImOGk+GfGiKjlG7FDnBZiUxfK0+FWdzie5FR/Al
 P2cEt+VSSPi71Mj5ZDoBcd0h3/Oj6EEnP7B13XXpDneT6cUcTz0CKiMuucA+w8tvUyf9
 IE/VHGjePvKjQ0sOjmMcHpRM6dHUCHSQE5V7pOJSLu53AXOWXBUCD3SbF9+dPZYobUBD
 l03LeRlX5uhcpgodC5U7KyTURd6Z9gQDrvuRoa1fmSRqIOkyI0cZaUrRIr0Lh/6JoRW0
 zPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174955; x=1790779755;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VXrVapuWvSJm7rcWHE7Jo96roAfMJ04rFyL6n3yRULQ=;
 b=QbmeDMB3pLYnaoIio97F7qnF5lxaietvTITL4lav3Mm7+bQwc8i04hdV+7p6ZaQvhw
 Elp3GBaarUzcoU7N1LLba/Ye0Ie3R7JOJIQOUWFRfewLKOYC0ixQO+CtVCFymd7wGVd9
 Kuh11we1pwb1BsxWPadMZG8pIN5A6j6AQ6nzmGfBKUuVzvad/OkJqRLidtwTnOsuifI3
 0D95eQTtJX8EnbtHLBYQ2bKkSN4Cy0K9PtrI99jmeG1bagID0hfx1SIeT3e6vJCqk6E/
 EoAflfLyZK45F9uQnjUe1iQJXZauYa4ajdx8+eG8Aev3LexrMYN4IYD59BG/UqBic0fA
 hZYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5bndN331ezMS1xLoVj4nvuaFO1oWQUf3rWOQxCAdqa6z57dVHDIt0FQ+wq8NKTkzDmT3VRQZFA07h@nongnu.org
X-Gm-Message-State: AFuF++n13vuvf+YWObapImTcaoJ7bMklnpppeObJjiOywaYXG9H8WpIF
 COyC1RT2nQVGwDVwCgglK1VRHdLdz4A5WSB8Xq4Z+RqzuQIKp8U6Uu9MSk8SvxK/VsJjuDzgxQ3
 bIOxfbV1WQ/DNN5TXwZvJWg==
X-Received: from pfl5.prod.google.com ([2002:a05:6a00:705:b0:877:3011:1894])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4406:b0:878:3538:8f7f with SMTP id
 d2e1a72fcca58-87d1bca920dmr2418856b3a.45.1790174954887; 
 Wed, 23 Sep 2026 07:49:14 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:48:09 +0800
In-Reply-To: <20260923144911.2877141-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260923144911.2877141-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923144911.2877141-2-stanleyjhu@google.com>
Subject: [PATCH v3 1/3] hw/ufs: Track SCSIRequest and cancel pending requests
 in ufs_clear_req
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: Stanley Jhu <stanleyjhu@google.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::445;
 envelope-from=36uazagoKCuMXYFSQJdOMZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x445.google.com
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

Existing callers of ufs_clear_req() only invoke it after requests are no
longer in flight. In preparation for Task Management Request (TMR) task
abort and MCQ queue cleanup support, where individual in-flight requests
are aborted without purging the entire SCSI device, track the active
SCSIRequest in UfsRequest and cancel any pending request via
scsi_req_cancel() in ufs_clear_req().

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/lu.c  | 8 ++++++++
 hw/ufs/ufs.c | 6 ++++++
 hw/ufs/ufs.h | 1 +
 3 files changed, 15 insertions(+)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bdb1650..5905c49 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -173,6 +173,9 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
     int16_t status = scsi_req->status;
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
+    assert(req != NULL);
+    req->sreq = NULL;
+
     /* WB / HID accounting should only happen for successful commands */
     if (status == GOOD) {
         ufs_wb_process_write_req(req, transfered_len);
@@ -190,6 +193,10 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 
 static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
 {
+    UfsRequest *req = scsi_req->hba_private;
+
+    assert(req != NULL);
+    req->sreq = NULL;
     scsi_req->hba_private = NULL;
     scsi_req_unref(scsi_req);
 }
@@ -389,6 +396,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     SCSIRequest *scsi_req =
         scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
                      UFS_CDB_SIZE, req);
+    req->sreq = scsi_req;
 
     uint32_t len = scsi_req_enqueue(scsi_req);
     if (len) {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 3c4d742..adae663 100644
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
index 6f2693b..265a43f 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -60,6 +60,7 @@ typedef struct UfsRequest {
     UtpUpiuRsp rsp_upiu;
 
     /* for scsi command */
+    SCSIRequest *sreq;
     QEMUSGList *sg;
     uint32_t data_len;
 
-- 
2.56.0.rc1.310.g51773c2048-goog


