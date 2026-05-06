Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2323ACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX6N-0002hG-Im; Wed, 06 May 2026 03:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX66-0002ck-V8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:11 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX65-00081G-1j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so2250428a91.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778054107; x=1778658907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpz2GXMM6c2b9OSumI0x/yIWAjgMb6Nrdlpfn8YZXuI=;
 b=FbSuGjbFA0sdDBbhrrbR9flYCcYaab3Vve9TSIRAl7g6JTWSMody97Z6ToKSu9VJTY
 D7vDPEpHwJhq7QCdwMzoZ+5X/8cr7EyZIpetjHFcy300aJ9mvPx6MblE5HCHN95Cda5A
 fC1FjKkRLd29MtBK6IMnogmecPO+/nnIatGN9LVlS81X66f1k6O284Qp9CBM91Q/0uG6
 42I+u/kT5PF8UwRsJ/NvJ6iTcATcG8Nr2AifGoc2cnah5zvsSwJhP31bl/HNNyabW3yZ
 yo4RAHpic65aoH+A6k2qaxb+0FqxzlKn2KDaLbpMfn96GsFv2/gQXntbdeAjGuAci9Nr
 F6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054107; x=1778658907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vpz2GXMM6c2b9OSumI0x/yIWAjgMb6Nrdlpfn8YZXuI=;
 b=Xkt1j7hXozEnuObUxDwzdZhKK0GPZWy3SFNZPdtSxlUPQCjxF6JBTW/kd0iETMwD7J
 nNim759UbMAnvmff3rA00Tuu2qB8SWF/NiebZvGz6uEpcTokjX68246konvnQlqVc8qF
 wnOzwbu372i+aN7vlznOO+DD50zNmb4JrAFX84GvzSfRY4dYe2Wb1WKxLcak2JgRV5ks
 SqKpN6oe3pM/tc1s6dW846a+uM4uY7+Ydpzc1jgWSTcYfKYNnNjDRzjY82FxCbW5iut2
 51VQZwSoEZuruNIVOHm/JkHvM9//bg35V3+QP5TbihWukTqyIXBIVdFH36N+T5a1DUE1
 qgCw==
X-Gm-Message-State: AOJu0YwwKnwdrMOndnVIKompKMLxh6a/zp4vE7VgTyGduzp5uuhkGRIU
 gaZ8VbGxNAACJrRc18T4YsLI2tvDJaAl7aJ3FcljKwoA6OtXCzYgJYOZan+89g==
X-Gm-Gg: AeBDieuMqCbtz/bHs81J/S0cL2+16x9vQKkwIdDfINS6tulzA9Zf36k/F1q88Xb3j5A
 Vtm5IRJl/WByCSfbiWgMcyI2hxrmo2slofL6zCu0KAfOGQc2Qrcs8NgFUkZE6Aq7lIER+bX9Lz+
 DrQcZ/wdvgVpnmS/UumhUB5ef1tpOS8RwmjIvfCcMwDa9lCuVtYv61ysj9EKVXF6K0bINcd81fD
 0Y2cos2B04I5RfWK3J5KSQ6Z+afBXTijTYsz6TurZK6hDEY9W7+CCbUdQJ8sF/ckKCoAolsup6c
 LHcBthxKxpoK6ncDYv5orJ42M3WqHMSIhEHy29Qjwd7lYM9Zv60V85FgnTtWnFeQKB4rod2/qDS
 dbotQA3aEVJ/bZH5Pcv8RddNBLTtU8QYuVkxvGNsfwkjMsoPr8Rl4POuIX5xV0ns+eRzfxhr5zX
 ElwlSKYScWk49ViI8U+tTYG+qNGOjaXVvqIhkmestfdSXL2g3+gVoj
X-Received: by 2002:a17:90b:4b87:b0:361:45df:114 with SMTP id
 98e67ed59e1d1-365ac2751c7mr2067483a91.19.1778054107042; 
 Wed, 06 May 2026 00:55:07 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4bcaa49sm1380997a91.1.2026.05.06.00.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:55:06 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 j-young.choi@samsung.com,
 Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Subject: [PATCH 1/4] hw/ufs: Validate MCQ SQ references before use
Date: Wed,  6 May 2026 16:54:28 +0900
Message-ID: <23d46a0e034b9420125dfe40bffba445fc4ee19f.1778053560.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778053560.git.jeuk20.kim@samsung.com>
References: <cover.1778053560.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102c.google.com
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

A guest can program an out-of-range SQATTR.CQID value, or ring an
MCQ SQ doorbell before the submission queue exists.

Reject SQ creation when the referenced CQ is invalid, and ignore SQ
doorbells for queues that have not been created. This prevents a
guest-triggerable out-of-bounds read and NULL pointer dereference.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Reported-by: Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cb74cb56bc..d5fba15e2a 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -517,8 +517,13 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (cqid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_sq_invalid_cqid(cqid);
+        return false;
+    }
+
     if (!u->cq[cqid]) {
-        trace_ufs_err_mcq_create_sq_invalid_cqid(qid);
+        trace_ufs_err_mcq_create_sq_invalid_cqid(cqid);
         return false;
     }
 
@@ -775,6 +780,11 @@ static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
     }
 
     sq = u->sq[qid];
+    if (!sq) {
+        trace_ufs_err_mcq_db_wr_invalid_sqid(qid);
+        return;
+    }
+
     if (sq->size * sizeof(UfsSqEntry) <= db) {
         trace_ufs_err_mcq_db_wr_invalid_db(qid, db);
         return;
@@ -788,7 +798,14 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
                                  unsigned size)
 {
     int qid = offset / sizeof(UfsMcqOpReg);
-    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+    UfsMcqOpReg *opr;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_invalid_register_offset(offset);
+        return;
+    }
+
+    opr = &u->mcq_op_reg[qid];
 
     switch (offset % sizeof(UfsMcqOpReg)) {
     case offsetof(UfsMcqOpReg, sq.tp):
-- 
2.43.0


