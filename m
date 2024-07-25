Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845BEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ls-0008BJ-6y; Thu, 25 Jul 2024 19:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lq-00083Y-Kq; Thu, 25 Jul 2024 19:58:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lo-0001Zi-8I; Thu, 25 Jul 2024 19:58:26 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2caff99b1c9so284443a91.3; 
 Thu, 25 Jul 2024 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951902; x=1722556702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSwJBZCisw9vXJ6eD8OFwE3uL+nOYcoBzazfj23ZCHM=;
 b=R6IytXae8r1EL/nAI721FlplcUA+umHS5hy0t9nKrsT2uU5L+92IFjNEqO7N4kKIhU
 2J5NrNiF+tC7TQ62rAycSSk8dnbDFV6n1O81x/O5F6j5lh6pIye+xXNr2od7Pn+C72mO
 2IoOE9wrhP3+LOr0hefGc8kKaEwvsoyu8mGc4S6SlFiQsGyW4aHxUq2aYvwtz77/1kvq
 vop5Ym11t6DIi0bCJejCr+ffYqxcLg43b2auzU1pY5mftVBm7qAoyJZgnpOzQWie5csF
 7VBTy5GrQnGAsVIwmamOpvyCfyvvd0ROwmIWXqQIK/GA4FakMebyF/isa9OXlNx8TuOg
 wdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951902; x=1722556702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSwJBZCisw9vXJ6eD8OFwE3uL+nOYcoBzazfj23ZCHM=;
 b=OCQc8Ai57y3Bua3fh0AucNkuejFos3Uj7KjvoQUj0Gy2bKYdrD8Z95bLxYTFeCOG3u
 KzwwUYmqzEwIpj6WIJC6dkJ10vQ4SQC4zePiPhtnxL+wfe1RptAA7X+9dmN9ZaB7GYiE
 YNUVi/kSpQ8Qh4tI2mIFB3j6/8cXki3FvcPQ1wmrFKN+yPCA/xsiwdgJRTafkZjkhkg6
 DE7J4+KQCsfWlFI5EEDAv2wN2/NqTOfxB/bSJ80fWD1xEXPwCxpMPHtEqRWDWWxVyTdN
 cw+NjxXnLTQih6rTsdCt1rM9HAsM6SV24eGfGfPGNjITG9pRViDm1+Nq/af5pZdYlff3
 KiZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqsV3cH1iMgVl8hOwuoBq8B/xo1lyu9UcYZD7fr0xAYRl0KAnnq6Se+0YahccsSieviXaxTfkNcc0Za4y2HJvTtQlD
X-Gm-Message-State: AOJu0Yy0u6ITKdkVssdlKnjayo0zMeNWOVJnvFDqUrH8Mp+CUrH02Cjq
 5JsGy08Jam7gcYwbPYuo1dW7uh1ZiniqMSgNDe1abxf6wqu5m7el65yM+Q==
X-Google-Smtp-Source: AGHT+IEJbJS63pi8J7nV2hMVCZxnIJKFaxrsnOk1xjVdBFK5gB0/Pk6Kp0dm2zt/SUlTIuuj5Qep+A==
X-Received: by 2002:a17:90a:ba89:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2cf2e9ab041mr3917670a91.5.1721951902143; 
 Thu, 25 Jul 2024 16:58:22 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 66/96] target/ppc/mmu_common.c: Remove local name for a constant
Date: Fri, 26 Jul 2024 09:53:39 +1000
Message-ID: <20240725235410.451624-67-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

The mmask local variable is a less descriptive local name for a
constant. Drop it and use the constant directly in the two places it
is needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 08c5b61f76..2618cdec6a 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,7 +98,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int h,
                                 MMUAccessType access_type)
 {
-    target_ulong ptem, mmask;
+    target_ulong ptem;
     int ret, pteh, ptev, pp;
 
     ret = -1;
@@ -108,12 +108,11 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
     if (ptev && h == pteh) {
         /* Check vsid & api */
         ptem = pte0 & PTE_PTEM_MASK;
-        mmask = PTE_CHECK_MASK;
         pp = pte1 & 0x00000003;
         if (ptem == ctx->ptem) {
             if (ctx->raddr != (hwaddr)-1ULL) {
                 /* all matches should have equal RPN, WIMG & PP */
-                if ((ctx->raddr & mmask) != (pte1 & mmask)) {
+                if ((ctx->raddr & PTE_CHECK_MASK) != (pte1 & PTE_CHECK_MASK)) {
                     qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
                     return -3;
                 }
-- 
2.45.2


