Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1667DCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTe-0002Zs-1a; Mon, 05 Oct 2026 07:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <394PDagoKCmoabIVTMgRPcOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTb-0002YK-DO
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:23 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <394PDagoKCmoabIVTMgRPcOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTZ-0005QF-G7
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:22 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-86fa6b15ed3so1956372b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198199; x=1791802999; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M5v8qUl4HO0U7DRUSDf/YGwEmMmliYBjW9aq2FXssZY=;
 b=mla61yVEQSehEE0+4uEY9rm1rMy+DN6bYlii1+0QqfoLzlmUP7bDLMKPA/3z/+rmTR
 aYZP9hAJ2wnFUGPHWkmqDevpI4dgpStSFAxVa5gSJfwDtGNczF8WrRKjGtcFGjZm4ekl
 WiO7aIAz3spB4jbKQc97IPwebfmzZoTESTIncS8wyeVpY2Z/hyhN8LzRCxkQWGjiVWhn
 QX9xXYor2UVYN5SteXDN5k5BqxdyHbOlcyCsv2TT0YHcqx0Dh51pO3iBN4jwFxi3oTVN
 gXkjitnNW9lm6qVCL+8loiQi5h/zg8n2Le/70T+FyHyAd+bVtPo2DL3/cpHIGuOYHE7L
 Lb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198199; x=1791802999;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M5v8qUl4HO0U7DRUSDf/YGwEmMmliYBjW9aq2FXssZY=;
 b=saHuzGoVbtyjAZPgRwM/Q+SPw8p+TzexqAs+MtMPUv9L+w433sg/mZbZrU+YstpglR
 dGHbGxBAFP6rVO3Q+QUxmFF0nyXriRKOvBdq3ZGQSfzgUFxXlevPUHhksI6zkqKPPRIm
 HrOj7AX2wfx9HPXSF7u8U6GWeMO7fKS89L0kSYPLY9DH+exSiSmb0wfJ6jEoPd6N3PJ1
 h1+uYpJMkmp8/mC5hfZhu1ZEU1qLXtVOJh2P2htcNNUINEHa/HA9+DTnu5cRr8kl1hVY
 iPxZuhZEO60UX631cl7V49fJCeySC13li1Kz8pN/zeHcQL8EUPAC/6Lx5D/d/43wHrnW
 8caA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdo0F/jSVJFwowXUPK86s+glrzmlEBNi9tgSh9LplHk10XBUE9ioEcQpOlNk1CquGJ1mlIQL5Jlt0I@nongnu.org
X-Gm-Message-State: AFq9FYLAmjhDpj8od2t/GkaAkg4RckLvlQYWidnv/P5rA2h5b3bjYQLY
 Y2nGBVXn9YoHUenLPPzmH89sDUpCnbPh15NUC2cZxoSdLNdN34UH8PLlTi5QjwJeZ3Xrc3ZZEeS
 l9bYSMn6RUkqcF/B6ErXJPw==
X-Received: from pfbmt10.prod.google.com
 ([2002:a05:6a00:6e6a:b0:88f:a93e:7dfa])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1bc7:b0:880:ee58:2768 with SMTP id
 d2e1a72fcca58-88af8b3f3c3mr8408909b3a.56.1791198199093; 
 Mon, 05 Oct 2026 04:03:19 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:12 +0800
In-Reply-To: <20261005110315.3327418-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261005110315.3327418-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110315.3327418-2-stanleyjhu@google.com>
Subject: [PATCH v4 1/4] hw/ufs: Track SCSIRequest and cancel pending requests
 in ufs_clear_req
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=394PDagoKCmoabIVTMgRPcOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
index bdb165085..5905c49fa 100644
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
index 3c4d7424d..adae6639e 100644
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
index 6f2693b7c..265a43faa 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -60,6 +60,7 @@ typedef struct UfsRequest {
     UtpUpiuRsp rsp_upiu;
 
     /* for scsi command */
+    SCSIRequest *sreq;
     QEMUSGList *sg;
     uint32_t data_len;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


