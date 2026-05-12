Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7111ECD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMeyQ-0006Rh-Rs; Tue, 12 May 2026 00:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexp-0006HY-Bu
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexm-000760-AQ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:24 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bcd730e090so11318885ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778560998; x=1779165798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eDB1l1/PVI48NXBHGAF6ykZYQWCGY5zXP5eqTSYuaI=;
 b=ZPesKLr/dd5tq2MtOJxrrqaJ87pmNOt1NC5aDdy2wFRLGEc5NOHg61jqVdQzpaQbXd
 8EZ3arGzRURCmYOgRVde9bfX9+iaq4CziYgzBQ9t2fTJltt3//Cu8we99dhc7GFrJQzI
 yQ9FB4GXsLag7nJCMalDj3ColkSH35wUQL4oM76AKIjDxodW7fGMVHYDwN51+5g8a2aV
 /M6aykBOVPFBm00P/ChUuUNq3Km/RNVSqqoHwEzhIE6p24MCmLAPqBGZz4LiLrvUsdsf
 RRvou12vITyQ48d3Fy7rCqYsarAVoity6lYtAikDJ3Qmq+bSGzWctetAdOrls8h9nLOS
 NIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778560998; x=1779165798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+eDB1l1/PVI48NXBHGAF6ykZYQWCGY5zXP5eqTSYuaI=;
 b=iIFl0+FquLmMTdgK46osB/auFJLFTzg9PThtTPsQe2VboewOVe/skHK+koUXq8DUvB
 Q2D7BQLmS3fDy5lfjcl7EcqQl/6zIEBlpw7HGt4ARFptP3vCBFulWD5GTMckr2aDMD92
 o3Q9fv676KLFtCPsbgPuOuXyb/AuEPKkgKFS6f/+vgTiIZmSMWcv3U7M3KRtpSisjDrK
 qtnw3H8yW7yrP0cY+wfXuQbDqd+8mUvCPp2qWCynF/jpPEQ0AZfOOiQWQC+2GtCll/yg
 0x8ugSdWfDE/S4xkoEWK/2Pr4A0Jrh/CfQcO/pCcWW/c1ND/WoeW5mbmmd6oPmfNFfvF
 poUQ==
X-Gm-Message-State: AOJu0Yw8YbfLv0pCMQslGXJcQfChKR/xlBod8p5uZv9Rv+U2TvCY1pxz
 a6CCStOA2FGZg9uFyi1IcqlZJNLpslTYdxNk/yrwUnlu62FuEJjeeS2f7Xuzrw==
X-Gm-Gg: Acq92OHQ7xe1HI0cw2SPM/ZKpm7tmiH3CFG7O85DQrzzzvn733uvdi1w4s8i8Gnoi0H
 ehnL+Gz6EckdCJhIjkYFV0DjCIuMt3AJSRO1wVgWDp/RP5lZplWydfjJViRrWMz5vEPGAlTtJTH
 LVsZZtIhH6usOOs2E3SFbwUEYAyASPNrOw19vA2QL64mcBWWMusJo751PPqNduSnMDb+Jef8LVg
 1wXh/Bhqo+Pz9kY5+gVDocVqCr7pPmeVSybz2O65IntGDSgI6WFKeetvkKlRmEPw3nWC5Ump366
 lQvc6MLKtQRZCL2aF6UIpZS634iAMzhpu3RgZUrYZ1zO66FpiWlruAeSN81QovAel2vtCorLqq+
 AjkLDXsPr1oSldl+LndjvYE/p1xOeAsrPn9ewU34ByTZ74s6AQMKekFZ2RzOqFE5UAFdrm57F5Y
 7+b4GzF6dHZjsKNcDB9B0Q5jIo82UL
X-Received: by 2002:a17:903:1b10:b0:2b0:bebb:1081 with SMTP id
 d9443c01a7336-2ba7a20ce22mr278454615ad.28.1778560997718; 
 Mon, 11 May 2026 21:43:17 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebe7f1sm108938215ad.78.2026.05.11.21.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:43:17 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Subject: [PULL 2/5] hw/ufs: Guard MCQ CQ accesses against missing queues
Date: Tue, 12 May 2026 13:42:52 +0900
Message-ID: <283d921e771e8a98a5c3d1eed1ed791b89ba47a8.1778560533.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778560533.git.jeuk20.kim@samsung.com>
References: <cover.1778560533.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62c.google.com
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


