Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02537CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX6R-0002ih-Bh; Wed, 06 May 2026 03:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX6E-0002el-0v
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:20 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX6B-00085p-6e
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3658c87160eso800131a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778054113; x=1778658913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IdASMODNaa9Qa5EkhRzMRiJsje/vGTTLmetdjczDI4=;
 b=OEjv26tdWnScgYlYdNVtoFyH6Jt2lZsGbH2KI3yS1yxdcAeZWxSGyQsDLTzlb0nIeE
 WBzLreYc8VXw6I+yXYr8O/Ed72Yf8aYx0p7qtDKUS6p4u1JwfEdmaCjFhLX5odcjif09
 lMROU5CMmTxcKauC63suH1pU2wQHy9PvnRXNhuO+HFLANu+BY4MQXIWQkvbNZntcVoHd
 lY+eAN9Kye2OIWzhgNNqeMLQwu64Gu1zC04Q5QuU4I8aaeSfLOC/drOOkQK5IegVNGQN
 i5F+MitPxoB2lpi5k12qdk2IlKqkaGZZxVeY9KDb1RjGJu4PZ8n3zDqe5oJv34M+QWqi
 7JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054113; x=1778658913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0IdASMODNaa9Qa5EkhRzMRiJsje/vGTTLmetdjczDI4=;
 b=M0dvKL48DeQu5FhfSFKF831P3TZD0mRCuLEbqUEQBoFiwTxXCyq1VAmOTWIOAxOeMM
 gem+vZl8A13Frp7ule1wC9l4AekNZybittbFSS5JpA7itFrXLDmmxmuF7j35NEifmM2B
 Qsnp9WJBzvo+Upjp6dMCQUDfgQcX86raZQoJHdFERD4oEvlG+z3l49KCj+iz+uef02gW
 hrbRKamz1BwrhV9IA6nZuWxizv3ZCgd4DkYgOhueMJ7zinAZjaFTF7Lx2elxPVF8LHz+
 lcG8YyiPMJMq1AhR9qqTQCPyO1wzQ7DSuuUjj25JxbG6msD+eRjkuqLEpTvYk5wI602x
 FyXA==
X-Gm-Message-State: AOJu0Yxuz8hsYw66RIlqtgr7cSiFiWwgBSPXhaGd7pE4iPivxXxBk7JP
 1P2S3lVJZZr56+7ulVE34zupBGFWUWo/8u0pn3g4J+pM9pkb83B5hWeS22XGyQ==
X-Gm-Gg: AeBDietJK0WMQffuBfV8DAdk2tZwgns/E+cAUfVPuRXiSz+0Yzpi1teQAhaJdWhehki
 S9L6Uxhc56HOvfK0dK83OA2x8QAMB5kFr3XuyI3Qc67bYygMqvuCA7MTDswjIRXr90wiX72n94C
 8YKpegcGXrV3b1t0BuC1lgj7/w2MqlEBa2rJOWNExNQySP+GC7squYsRIxN3+8ADN69FnPV3lgn
 14Pl2HUaA0aYuxWnxeLclEpWqb+rCOmnZq8NBk7aa+q+JVAcB9McXynHY8WVif688xVG5+lf7v+
 +y5DxGd+TAvJwRuWkRy97KiYF+ndaISJArNiuIePYYJj8iRndHPc2lG/LxjxTj7wlMlR0el2ebS
 OCOsYQu0wdwroD61Qlru2AO/tBE2O7chHt7r55tJhV9Fjromm3T5kLi78X+59hTr9+5ue0DI7GL
 Owm+r1UrERTFdLt8wuNagjjsnBeFIwksf1DSefNec3QQ==
X-Received: by 2002:a17:90b:1c8b:b0:364:534b:a898 with SMTP id
 98e67ed59e1d1-365abad59c2mr2116123a91.8.1778054112510; 
 Wed, 06 May 2026 00:55:12 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4bcaa49sm1380997a91.1.2026.05.06.00.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:55:12 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 j-young.choi@samsung.com
Subject: [PATCH 4/4] hw/ufs: Keep MCQ SQs alive while requests are outstanding
Date: Wed,  6 May 2026 16:54:31 +0900
Message-ID: <3472fb763391a8efa096adc5d169c55e327112df.1778053560.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778053560.git.jeuk20.kim@samsung.com>
References: <cover.1778053560.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1036.google.com
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

MCQ requests are allocated with their SQ, but can remain in flight on the
CQ list or in the SCSI layer after leaving the SQ free list.

Reject runtime SQ deletion while any request is still outstanding, and
use separate teardown helpers so device exit can still release MCQ
queues after child devices have been unrealized.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 49 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 7734b35f08..6f7ea9c95f 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -44,6 +44,7 @@ ufs_err_mcq_create_sq_invalid_size(uint8_t qid) "invalid mcq sq size for sqid %"
 ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
+ufs_err_mcq_delete_sq_busy(uint8_t qid) "mcq sqid %"PRIu8" has outstanding requests"
 ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_create_cq_invalid_size(uint8_t qid) "invalid mcq cq size for cqid %"PRIu8""
 ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 4ccd7aa64d..6548f0f637 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -556,6 +556,31 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     return true;
 }
 
+static bool ufs_mcq_sq_has_outstanding_req(UfsSq *sq)
+{
+    UfsRequest *req;
+    uint16_t free_reqs = 0;
+
+    QTAILQ_FOREACH(req, &sq->req_list, entry)
+    {
+        free_reqs++;
+    }
+
+    return free_reqs != sq->size;
+}
+
+static void ufs_mcq_free_sq(UfsSq *sq)
+{
+    qemu_bh_delete(sq->bh);
+
+    for (int i = 0; i < sq->size; i++) {
+        ufs_clear_req(&sq->req[i]);
+    }
+
+    g_free(sq->req);
+    g_free(sq);
+}
+
 static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
 {
     UfsSq *sq;
@@ -572,9 +597,12 @@ static bool ufs_mcq_delete_sq(UfsHc *u, uint8_t qid)
 
     sq = u->sq[qid];
 
-    qemu_bh_delete(sq->bh);
-    g_free(sq->req);
-    g_free(sq);
+    if (ufs_mcq_sq_has_outstanding_req(sq)) {
+        trace_ufs_err_mcq_delete_sq_busy(qid);
+        return false;
+    }
+
+    ufs_mcq_free_sq(sq);
     u->sq[qid] = NULL;
     return true;
 }
@@ -617,6 +645,12 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
     return true;
 }
 
+static void ufs_mcq_free_cq(UfsCq *cq)
+{
+    qemu_bh_delete(cq->bh);
+    g_free(cq);
+}
+
 static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
 {
     UfsCq *cq;
@@ -640,8 +674,7 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
 
     cq = u->cq[qid];
 
-    qemu_bh_delete(cq->bh);
-    g_free(cq);
+    ufs_mcq_free_cq(cq);
     u->cq[qid] = NULL;
     return true;
 }
@@ -1884,12 +1917,14 @@ static void ufs_exit(PCIDevice *pci_dev)
 
     for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
         if (u->sq[i]) {
-            ufs_mcq_delete_sq(u, i);
+            ufs_mcq_free_sq(u->sq[i]);
+            u->sq[i] = NULL;
         }
     }
     for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
         if (u->cq[i]) {
-            ufs_mcq_delete_cq(u, i);
+            ufs_mcq_free_cq(u->cq[i]);
+            u->cq[i] = NULL;
         }
     }
 }
-- 
2.43.0


