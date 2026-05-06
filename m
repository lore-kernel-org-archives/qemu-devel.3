Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E4BCD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX6O-0002hp-B4; Wed, 06 May 2026 03:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX69-0002eQ-Lz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:16 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX66-000829-Sv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:13 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3658c87160eso800092a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778054109; x=1778658909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orupH/ZosDBgw2QZSHIIN9b4U6Oo6D+nsWsNqobO55I=;
 b=IQ5PKjNX5oLZKZlIabZ6eZzWZIrklGaPDgm/jQ0LJTFgJXXwHYAq0VL0ZI8T6X611H
 VxmzEd6aqbUmMohidLARzYrcXU7GFL/q1I4Sb6FjWtdO9FDaM8fvdqGy9yAd32sndNHP
 K0T4lZDAvCirocsAK193AFVzuKII1AJPE5W7cuVyUP6miIpexokFgauqpQY1zaOsMq9x
 CGAkNN/Moi2/5x5r9ibcEys3uJppDSi1ZwjeVSZfWxA224Iszqqya0eAo+oMMmSf31QZ
 Jmz9DAzrsgCblUH2cbOWZmSSDeKWdPF+9msC+YXPs8viv6tHLY/BsSYlWq9hBc+cRZDw
 JKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054109; x=1778658909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=orupH/ZosDBgw2QZSHIIN9b4U6Oo6D+nsWsNqobO55I=;
 b=tJkA4xLtanim5tl1mJNiAeuGrlkelLsu56HzpgWrwvj1H6Mek8fZejLkHDRz29Bso9
 gWzePtYNVxRtnUkbfcZJJJRQmau/PnR+ErXmyDd36r3d/nLaDJT3iG/rfB6+VJriuKV9
 l55L6UN/Vwyaow/4KmqpW9njYAtk/hddYSLkrU5FOzzuD2bg0g01rMcr2LvnfnVFozkv
 YRT6W9vnjifQ9zBOyhBHAEtvEjX3NN7Led91et1Rp7UsqIo81ZEsVH5jQVqe30pJPKs1
 HQUoseTlGq15nrH7aSmcJZg2bCRfwPksF5HBnLI2LNXJbl1WyX5cZOkucAbrZ8GTTD65
 aIMQ==
X-Gm-Message-State: AOJu0YxK7zY6zJ0Vxdxz3Os8TF58zSvhDiWpr8Ng1dkTixkdG5BcePF3
 GUaPrO3h13nYT/GTL0jtEdkUurFgUlfvcXPSNQyTDz+EUCcm64cxfP1OZ+DeVA==
X-Gm-Gg: AeBDiet7IA2z49pD9ucTUQTlm5bQkIiQhUM72Cjb2Kfb0Rmc5jaqopvOMXQdEtxHYvT
 p/Q17ryiPn7RbZeGHOVoiu/C2AfLLxl1qwWD/3eVUrYZ9YnFk5uLhd6ETXixK98Bb6c2dUZWpy+
 orgEFi/a5HoF2NQ14D3Xhj1XN1ftqEN3B9Z/YM2hKCwbUYY7aYpEsfGOGpjs/HJf33sqa1j1p5d
 ZvmAOAACNZI3hDtfayg4E9r2Jtdyy3fVkPZMCnUodOo7+HBX1a6jC+TtJiibEUVmc/kucbAKXp0
 STo0oXklStEd/oz9nKvTgsPCv3twxz2MJzSVRiBSZG3auLaGXoDdxl6IEZEnQeHbxZqOpigQD58
 TGcGO33WmwvbJ5YKAo+kGk9BmDahWYohnmEOUNg48H7MAL5SntLhEtkHtXMhe82o84U4xq+fk0m
 iFaIHPchpOrICSx+KbXta5N+6Rhqz/1UEHCOzCzT++jA==
X-Received: by 2002:a17:90b:6d0:b0:365:3154:7b1 with SMTP id
 98e67ed59e1d1-365ac78f19amr2173356a91.26.1778054108983; 
 Wed, 06 May 2026 00:55:08 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4bcaa49sm1380997a91.1.2026.05.06.00.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:55:08 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 j-young.choi@samsung.com,
 Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Subject: [PATCH 2/4] hw/ufs: Guard MCQ CQ accesses against missing queues
Date: Wed,  6 May 2026 16:54:29 +0900
Message-ID: <2b4e9005cb7452c21937c99f570d774563b67b46.1778053560.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778053560.git.jeuk20.kim@samsung.com>
References: <cover.1778053560.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1034.google.com
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

A guest can ring an MCQ CQ doorbell before the completion queue exists.
The CQ head write path then dereferences a NULL CQ through
ufs_mcq_cq_full().

Ignore CQ head updates for missing CQs, and make ufs_mcq_cq_full()
handle a missing CQ defensively.

Fixes: f78762a3cc8 ("hw/ufs: Fix mcq completion queue wraparound")
Reported-by: Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 4 ++++
 hw/ufs/ufs.h | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index d5fba15e2a..1819ba2e8a 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -817,6 +817,10 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
     case offsetof(UfsMcqOpReg, cq.hp): {
         UfsCq *cq = u->cq[qid];
 
+        if (!cq) {
+            break;
+        }
+
         if (ufs_mcq_cq_full(u, qid) && !QTAILQ_EMPTY(&cq->req_list)) {
             /* Enqueueing to CQ was blocked because it was full */
             qemu_bh_schedule(cq->bh);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 13d964c5ae..9e800cafac 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -203,7 +203,14 @@ static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
 static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
 {
     uint32_t tail = ufs_mcq_cq_tail(u, qid);
-    uint16_t cq_size = u->cq[qid]->size;
+    UfsCq *cq = u->cq[qid];
+    uint16_t cq_size;
+
+    if (!cq) {
+        return false;
+    }
+
+    cq_size = cq->size;
 
     tail = (tail + sizeof(UfsCqEntry)) % (sizeof(UfsCqEntry) * cq_size);
     return tail == ufs_mcq_cq_head(u, qid);
-- 
2.43.0


