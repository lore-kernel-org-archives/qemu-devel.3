Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112C4CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMeyG-0006Mx-1e; Tue, 12 May 2026 00:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexp-0006He-Jr
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexm-00076K-Az
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba4a1a0325so35875125ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778561000; x=1779165800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=konCHW8lvM+pkBpHalqNVGWKkcAXDmRlJyrbHkVFMjo=;
 b=R9k1vz1MDICwPrIl8YkqxvSu0r8aLe7HyoTbxfdYf3L2ann05kxY8GteUs96/8XWhk
 glSQhC4SKxnMrJF4a8iEsKkP3Wx57b/qeGmFAkQjf8ydCBLlZn+D0+e8Ht4HVYgnuiAp
 MYQqhYO1YHIDQWMJ6JiSxNpYTyGa5V5hODbCcZN0NEAA2UIDUsEAAiG6chY7RHXrFyso
 vW/rPK2esemA/+qcvaHb5BkOI94kLRmA+psMnupl+6c+sqbqga6XypRw0SGsfWTCFMRR
 QUnOtyY4SGamWe+l+yxAstwpGP5QEnDH+X+sQ0xBuFlu8o5x7RDLTlNvukTvSxJIuF8T
 oFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778561000; x=1779165800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=konCHW8lvM+pkBpHalqNVGWKkcAXDmRlJyrbHkVFMjo=;
 b=QlW8n4m8MixRJ6kqD0rWQLj4pkYX7Pdshy21DJqkXms8IoXh2WB2WnOanPYKn/hB9v
 Y/oTd10+EIcHvy8AQs83oKJ64qkwxHIaWkr+Z6nfCwriGmKrY4shj2ZsoE3NAwO1H7Hv
 bpCit8jHa30z2FGBHE6USJwQJNqZzZrHr3aSr1wJfq3e4lRWyEgVmwUCfpYKs1InsrGE
 g3Qo+dEvgggxLCnHj2ZAg/OdWh0Bh/bLNyWyJFuBr/jBUwd4SHtj6YtNZ8FjeiqE2HDe
 +/Z+LoKQPtkWZnMhBFvm05XOuseWTtDJQwU4J27/8D2Jwf0vBQRIac2gGV4ytfH2I/ks
 jgyA==
X-Gm-Message-State: AOJu0Yxs3XH1vMX1WEkgd0l1MyjUG6j8lmZuoGAHE+4lgD1/yTlFnMye
 pef8C25Nho+q+gwSfgeJF9hjxnr6sctRj/0VMJENMy8bg7ydDhBHoX2fSK3bRA==
X-Gm-Gg: Acq92OEU2jrjP99G5bjEZl+GU4cEpFtHqb4/Gu2ywYZsbF6taAabRo2+Bp2J8l37nGd
 4lrwvE9gioHxGp9GhE3Xp3A941NcWHCXYGXim7VQ4xB+CYs2H+NVtKZslt7wtpV+d3tSb/TUhrg
 raSOvqw+oJvghKSiedVoB0Hnu48kOBtohRSL+kGlX5WWVvGyqcm/KwM8ovNzWGJJJWMn1uN/57k
 s3nmtbwOa/UDY7tRdB1LVPqLBXMd9uCB6AchzsuRy6twf12wLhthD4ws3MCU6hoDjGetci6vsk6
 4eNlLLduUXAA0GNNNkyPvRrL3JKOQDhO2etnUzeuHQaUE/TLoABR3QDyHtpI8yrBqVjahe+2z1Z
 Djpl5jasC56arcZqhPu9iO4JXjm+yv+6O23kN20OW6/6N7Sbih2a6aXRiWJegdzOrPzE1CGIJXN
 iUMYxyUThh0MNNNJHa4C4lGrRYiu7p
X-Received: by 2002:a17:902:b187:b0:2bc:cf07:9244 with SMTP id
 d9443c01a7336-2bccf079339mr50852375ad.2.1778560999730; 
 Mon, 11 May 2026 21:43:19 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebe7f1sm108938215ad.78.2026.05.11.21.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:43:19 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 3/5] hw/ufs: Reject zero-depth MCQ queues
Date: Tue, 12 May 2026 13:42:53 +0900
Message-ID: <4a909c00b9e18478e67a792c7f7cfae62cb6c865.1778560533.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778560533.git.jeuk20.kim@samsung.com>
References: <cover.1778560533.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x631.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

Reject SQATTR.SIZE and CQATTR.SIZE values that produce zero-entry MCQ
queues. Such queues can later trigger a divide-by-zero while advancing
queue pointers.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |  2 ++
 hw/ufs/ufs.c        | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 531dcfc686..7734b35f08 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -40,10 +40,12 @@ ufs_err_mcq_db_wr_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_db_wr_invalid_db(uint8_t qid, uint32_t db) "invalid mcq doorbell sqid %"PRIu8", db %"PRIu32""
 ufs_err_mcq_create_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_create_sq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_sq_invalid_size(uint8_t qid) "invalid mcq sq size for sqid %"PRIu8""
 ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
 ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_cq_invalid_size(uint8_t qid) "invalid mcq cq size for cqid %"PRIu8""
 ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_delete_cq_not_exists(uint8_t qid) "mcq cqid %"PRIu8 "not exists"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1819ba2e8a..4ccd7aa64d 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -506,6 +506,8 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     UfsMcqReg *reg = &u->mcq_reg[qid];
     UfsSq *sq;
     uint8_t cqid = FIELD_EX32(attr, SQATTR, CQID);
+    uint16_t qsize =
+        ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
 
     if (qid >= u->params.mcq_maxq) {
         trace_ufs_err_mcq_create_sq_invalid_sqid(qid);
@@ -527,12 +529,17 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (!qsize) {
+        trace_ufs_err_mcq_create_sq_invalid_size(qid);
+        return false;
+    }
+
     sq = g_malloc0(sizeof(*sq));
     sq->u = u;
     sq->sqid = qid;
     sq->cq = u->cq[cqid];
     sq->addr = ((uint64_t)reg->squba << 32) | reg->sqlba;
-    sq->size = ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
+    sq->size = qsize;
 
     sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
                                  &DEVICE(u)->mem_reentrancy_guard);
@@ -576,6 +583,8 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
 {
     UfsMcqReg *reg = &u->mcq_reg[qid];
     UfsCq *cq;
+    uint16_t qsize =
+        ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
 
     if (qid >= u->params.mcq_maxq) {
         trace_ufs_err_mcq_create_cq_invalid_cqid(qid);
@@ -587,11 +596,16 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (!qsize) {
+        trace_ufs_err_mcq_create_cq_invalid_size(qid);
+        return false;
+    }
+
     cq = g_malloc0(sizeof(*cq));
     cq->u = u;
     cq->cqid = qid;
     cq->addr = ((uint64_t)reg->cquba << 32) | reg->cqlba;
-    cq->size = ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
+    cq->size = qsize;
 
     cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
                                  &DEVICE(u)->mem_reentrancy_guard);
-- 
2.43.0


