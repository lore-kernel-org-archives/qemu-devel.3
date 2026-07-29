Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9BBC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1cz-0001au-AE; Wed, 29 Jul 2026 06:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wp1cy-0001aV-5X
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:35:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wp1cw-0000av-Io
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:35:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso1270475ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785321305; x=1785926105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NmEDzN5Cp4O/3ZwmDGm7v2KbQxIwUxQ/XdoFt6nz26I=;
 b=g64IKkBDVYVgC2RHrdMD/wqvlUQJ9HHw3/+6usZuudPoOEJv3rRDKswhbE7Y/5+930
 YKaOd84b8P78dxB3nLDch96tcRD5Oc30oAfb3R5+vZ5pd2KoBlg07qim4c108QvBHwTu
 eda6PW7UDIVg6EO01UHk2OWH+51qJvFWVGSCLkoIT1BNDHw99yunSgkRVEaj2T9jqObF
 uq9Hf6/Lbu6pUM8izgP2oX3S3twy5VWepifh8OmPpucVtKtS4OsQJVBcXNHIUA1IDkYk
 qeVGrs0DHmY6XZyo/1vt501l/yl5aVgnYbbEpxIzHJuoNkMuGP67mzUBW2HaAkftMj/y
 uS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785321305; x=1785926105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NmEDzN5Cp4O/3ZwmDGm7v2KbQxIwUxQ/XdoFt6nz26I=;
 b=LGzDVVwJoMSVyw78SoSYF6G/0U4WkYhYggbNxiuONvTEerGLZnSvSDkS3RHoQ/LBrI
 u+iSrVUuBwIIWl3aqLrkIgkatySQOZBRU4tGLUQxh1KwHkQfG8PyJBfU6tfxI5ED9IKZ
 Jeqw25ue+Pl7cQQQKcCBnB3htgxpz8eN4Jlr7MIqN8LsnGYQ0nNuYQ0o+hmrvW+Cijwb
 pBSUToaZZ8ZpavBUisAdtvUVe3yzm0BfvvedI4jJS1FbnV91QjSDySZSA8AthkmiBh1E
 gBABJDZWua/RCDG0Nxwn0+6uvPW2j8XJ/GsEtk3ELbuhamCwpO2KMNeUHrA+OlBk6Xco
 GBwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrk7Fuh6I0fWnbl3DUaUJ96sciZgvSBl9M0cckds2i+GvuNL/ifb5Hww5lV7EHqdJiPySbHocCgfL7R@nongnu.org
X-Gm-Message-State: AOJu0YyAUmvZMbqVySO61SCzieY8qVZWvCkfG013/S7OHJLC8/r/DBig
 0BlMIQqpg/QZCJ1nTKruxDZdBta9uPlibavi8+7XHYvALYO8DA9WFa9S
X-Gm-Gg: AR+sD11L+xyYCS3Weh4QBVihtrvrWXbItW9UKnzQNvQhPZUmSXMx6vf3hVmbCzhmklX
 9gQs20MNX9Jen5avfi/HYgybnxALl+i15wghHKciOG3fi3SIG08nU3+7+950XyhEjJNsKmOQKlr
 pmz6OeefwLQpSGgQASa2aT1/Qo7zzagrqq1r8DHVD/MR0Aj7ddMZ8ORh/2Ha795MOGsDL44egWp
 QaRWyDgMXs324QUtrn04zI+VTrfCQ9ZUiTO2QxoTVgX1gMKdyvLEZhb5tGaUIvgoJwmRm06GImf
 A7JeRpNGJOKE+6zLywDM7eHjAuyCb3p+LwqfDchaX0cTjTskWFGd4YQj0Q+oWkmDaLDlqbbSG4Y
 s4o1QHkzo70NMrOwzla1WlY1SrvAY7m7/6hIIOSyLrWW+HAJ7/XGOO3h+zrHVEXEJOM/6vvnVbL
 TYkYnfFNk74GXYkG3uxRUAP6YsVegK45dJst6wLQJgusxTyn6PLAHtLYoWwJw4Nbx/Z1rzPl3Nx
 bgyq1Sp
X-Received: by 2002:a17:902:ebc3:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d015c55771mr64029855ad.3.1785321304750; 
 Wed, 29 Jul 2026 03:35:04 -0700 (PDT)
Received: from localhost ([61.98.20.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf99edsm9212665ad.67.2026.07.29.03.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:35:04 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
X-Google-Original-From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 2/3] hw/nvme: factor out nvme_sq_cancel_inflight()
Date: Wed, 29 Jul 2026 19:34:53 +0900
Message-Id: <20260729103454.26947-2-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729103454.26947-1-minwoo.im@samsung.com>
References: <20260729103454.26947-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Factor the cancel-and-wait loop used by nvme_del_sq() into
nvme_sq_cancel_inflight(), so it can be reused to drain queues on
controller reset.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e715de8247d1..86b86b2a0fbb 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4822,6 +4822,26 @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
     return 0;
 }
 
+/*
+ * A pending Async Event Request has no aiocb (nvme_aer() parks it without
+ * issuing any block I/O), so there is nothing to cancel; just drop it.
+ */
+static void nvme_sq_cancel_inflight(NvmeSQueue *sq, uint16_t status)
+{
+    NvmeRequest *r;
+
+    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
+        r = QTAILQ_FIRST(&sq->out_req_list);
+        r->status = status;
+
+        if (r->aiocb) {
+            blk_aio_cancel(r->aiocb);
+        } else {
+            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
+        }
+    }
+}
+
 static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
 {
     uint16_t offset = sq->sqid << 3;
@@ -4856,16 +4876,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_del_sq(qid);
 
     sq = n->sq[qid];
-    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        r = QTAILQ_FIRST(&sq->out_req_list);
-        r->status = NVME_CMD_ABORT_SQ_DEL;
-
-        if (r->aiocb) {
-            blk_aio_cancel(r->aiocb);
-        } else {
-            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
-        }
-    }
+    nvme_sq_cancel_inflight(sq, NVME_CMD_ABORT_SQ_DEL);
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
-- 
2.34.1


