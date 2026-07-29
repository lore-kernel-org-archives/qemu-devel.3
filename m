Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980EEC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1d1-0001cE-Q6; Wed, 29 Jul 2026 06:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wp1cz-0001bC-TI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:35:09 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wp1cy-0000bf-Ek
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:35:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca53979f8e8so73216a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785321307; x=1785926107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3bCHXaJOK/Wa0/ozG1gEj9l3yJc5tvwwY3AgneX0KEw=;
 b=Ip9nyDWQrjsUZ8y7RLIMpX21xvlNRfhe5eKqZEhRaXF0nonHanNYrvgvlDempU7stp
 ciFmoarSNjn/wdG6WlMZuLrSY6mL1+wLgp1LtNvh0ag6VcvXNpcIVYSXpAd+Bvhkbxos
 3gRz1OXtL0lrV2BYsGX0PkQ7K5PU0Y/jIVQlDvZC+nvlBfoM0jIxluKEmzhbj+H1EuHH
 MkHoiNguVtztbg2Vsoj8lA86SCVzMtXDD5PXTiY67TY8Mnb47Ju6pmlY6YGcYGB2+lmW
 Z6dvNH3f/CpHxSFnPgbFPeR0ik2GkYvIVL2qS/eO7fBI9RUTXoSz9/peqhNpdJRbjGb0
 O7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785321307; x=1785926107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3bCHXaJOK/Wa0/ozG1gEj9l3yJc5tvwwY3AgneX0KEw=;
 b=TU6G7czHzhX2HeCpCHvToRsIPOWCfBZOH434yj/ryFKcF84UibWroycICy8s4YJ/kh
 GNxXDQ1Hmt53Y6NQ5cYOXv14LIvsyE0vsak98RLG1158fXRYMD9knlb9b8JF5bes7fKG
 0GjxJEO7dDVLrFgpiGFhlpX7rZVQ7yZCCsw+2t5Av4ok8UDP5ik4Uw9s1hXH73WAPNbJ
 c7yRMC1VYFP8DJkcbs5zuy+/ZKCiFTD/td+KY6G5gSpmxGWs+4QYDbHvA1ok1cCZofLZ
 i8T6gu6GxhKzwjeAX/preBqjTJGvcBikyO29MMnMtrnC9aAu2ce5tJ66Rvu1LKEbyAKY
 7FXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFxudrPW6QoNJSvcur6or9Qs3cUNvx3xpLLz2IEpBn+iEzKXFhjREsTi9JG0F8zsrUw4Es53V2tNji@nongnu.org
X-Gm-Message-State: AOJu0Yx4gXX7i+TDPQ6N2Qlu+6xnOpXH4uvjubH/G31YytqI0au2tOxE
 RLzQRczAgjbJWm/Y8tHMORllXHxYxoaQld/4GUqnP05Rq61hOt3F5p6g
X-Gm-Gg: AR+sD11OuzvNIpKIoxqNaBpWmkroxap3D/qwZFtJILNWWilDqATktSnz2zkYpc1C7ui
 smBToymYmidPK27PGazUxY1b3OLd4sTXoPUGe6/LQrwkeekPEj0FLE2Pe2uBqLR3EUYtq2uRWk9
 foi/JjzqcobcYgE0QEzL3IWZFFyYf8RQnlyGkOjA93YZkA8+y6Od9g9qchpmA1xgaOHjaxMBrZn
 4/F+pP8OVUJfic+lyi++fwV7k8QF9/AFOkernTQ5nYy/SIuliIK3bRlw8iDIQUxm2PrCRsPrfQG
 lpvCekMZfrQAtXHDtSodmbcqvb1fAt9jZScO360aQQEF1bsiNqTdc0ybWkoU8artYaC2W6Y+02z
 e5LvivXjZxs1HMUMZgZQWbhqZALQFJ8P237r35/qqzVymiE3AwN6PA1OwtxfwuGqM4MHyOEAfkw
 PBrNCmVMmVR/J0N6JcQcdRGdZlKEkioIUbGZcAPjI44nChS/RuAyWd1AGyBw==
X-Received: by 2002:a17:902:e88c:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d0157877cfmr61122235ad.0.1785321306839; 
 Wed, 29 Jul 2026 03:35:06 -0700 (PDT)
Received: from localhost ([61.98.20.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022c3b58dsm9148005ad.79.2026.07.29.03.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:35:06 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
X-Google-Original-From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 3/3] hw/nvme: cancel inflight requests on controller reset
Date: Wed, 29 Jul 2026 19:34:54 +0900
Message-Id: <20260729103454.26947-3-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729103454.26947-1-minwoo.im@samsung.com>
References: <20260729103454.26947-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

nvme_ctrl_reset() freed every SQ/CQ right after nvme_ns_drain(), which
only waits out requests on a per-namespace BlockBackend. That is safe
as long as the guest first tore down I/O queues gracefully (Delete
I/O SQ/CQ), since nvme_del_sq() already cancels and waits for
anything left on a queue before freeing it.

A reset that happens without that graceful sequence first (e.g. an
abrupt/asynchronous controller reset) can still have commands
inflight on blk_aio_*. Freeing sq/cq before those complete leaves
their completion callbacks (nvme_rw_cb() and friends) to run against
already-freed NvmeRequest/NvmeSQueue/NvmeCQueue memory via
nvme_enqueue_req_completion(), causing a use-after-free/segfault.

Run nvme_sq_cancel_inflight() over every queue in nvme_ctrl_reset()
before the free loops, so no in-flight blk_aio_* callback can fire
after sq/cq memory is freed.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 86b86b2a0fbb..22b1b9636878 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8035,6 +8035,18 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
         nvme_ns_drain(ns);
     }
 
+    /*
+     * Cancel and wait out every inflight command on every queue first. A
+     * reset is not required to be preceded by the guest's graceful
+     * Delete I/O SQ/CQ sequence, so sq/cq must not be freed below while a
+     * blk_aio_* completion for them could still be in flight.
+     */
+    for (i = 0; i < n->num_queues; i++) {
+        if (n->sq[i] != NULL) {
+            nvme_sq_cancel_inflight(n->sq[i], NVME_CMD_ABORT_SQ_DEL);
+        }
+    }
+
     for (i = 0; i < n->num_queues; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
-- 
2.34.1


