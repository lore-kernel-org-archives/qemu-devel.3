Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9220CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaXv-0007nC-4v; Wed, 20 May 2026 02:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wPaXu-0007lK-0d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:36:46 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wPaXs-0006Zj-FG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:36:45 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36643b96b99so4157767a91.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779259003; x=1779863803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93MiGTcduLfIDsBpe5BIrK9Tw93sePZbkjobcOPHdhM=;
 b=PYp8TSSm1KVtZFNYlzBPAJRqIBla9A2Kipqr3gUmu3jpnu/Zx2ei3PjgQnvusQ044J
 b2nJ68oe9ygA5Ico+XR0Ioq4ha2qxicOO7rnuHpC2w5vXEVW8PPAKq+LgwAYTBZYIonP
 TA0rjElBG/K5Tq86WUurJfPs1VKfgV70kF+A3t/PxAnpQW/kAj7Ch72AnFKb5vSAtqyH
 uJbmy/6jlnqIKpTl7FXrxIsfAynp7C2yBjVlCyIFP1hw3y3kWHHfvFfMzuZRzC5hkM9f
 1FIFY5VkyACZb0bPKbs2gCUs7l7iAOaJBfvIqjs9MIemMAy1sknAeDynHKZUEyZkgh+g
 FkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259003; x=1779863803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93MiGTcduLfIDsBpe5BIrK9Tw93sePZbkjobcOPHdhM=;
 b=P5pYzxgAQxA9LvJcSAj6s0StsYBV97D7Nq79XEYq3ohsF3WZdpRSzvYy2mNQZi/Kwq
 T+1asPPeGGaFc7sQ2/pZE43/yMzvzRe/ZvMjVB/TRqt21WJBJ3/SpRGsHOHjr7i+gkbJ
 aemU4M4rkRKuxlSc0GJv5+uZ4rYqWBwW2eOiEKI3qvHmm6PrgrhGrjkc9O6Q2un2ZWj7
 HNeuVFEzR84w/f+MbWs/tTWbFHZTxNUKsTT3VGSakHqnl9TGAigIgnmba3l4KJnDgowi
 jIYgitiF51pVbiHcDdOy830OYNY7eDWouzOpqLnKF/1Dlphq5Hyg1eVKnPMNbWsoH+VU
 YW9Q==
X-Gm-Message-State: AOJu0YzlaPbJviPwq6jeKnyy5zPR9gWghQA/d/viaWf51lHp41cAuUVt
 iY2fSfrbeUxllnqSnpDnlbfc9bfTYJOVtwzEz3WWYME7R6lHyiG0zZ04cjYdGRGk/rHSVgYvkPn
 75w9i17mba5F64ljl8Bkd2qayNhNOs19ffGyS7qZQhtYn2CrMMDArKgnM83AS0RGapotix+JtzE
 D0lGbZLbEtjx+dr447dYvUtMxCfzbOD3TNxJsiVxq5xi8hYw==
X-Gm-Gg: Acq92OGgJAO0Q3to5VgNjivsrKJuFjsHIlWDt7XK2CyUj5zJEHq+NQXOzwhXiueel9A
 fm8wFDkjIibRH7rItj0b6n0qeTiX44f7SFB0tXmBQnOXLjSEu6qMpO2nZRD0TYfLu3iHA5u2QTZ
 x0PU1b66veZp8q7yoCy+HAo+amvC6KQy59auoZ4o2zxRH2fXWE8CuSjvjaCvSjekJFUqNLMvmpZ
 D740xWQHzeth1CYyGbmfE/PbysgsByRUgABOgoBjdIoVRriCIdiPJ98IwJGql36jgWnO5WozdrH
 jxHnTs082r+7pvT9WCRgN/c8jmprPg+NCMbyYn1wB7BBPj9VUEjs51z0YewXz6ec7u19t/7u4ty
 HbeB54PuY6pIYRA2Y5BrmZ/FBABBzCyq/UgsTQt6E1KO6sg45dl1VQ4vFENRkgUja7/BDvyk3UE
 DM1VkW5Jvg9RN2dXHjQ4jbTYbw+4lZonStdce7P8jfVEtlsIrQdV3xzqBAYu+Rbg==
X-Received: by 2002:a17:90b:5290:b0:368:f0d0:1ce8 with SMTP id
 98e67ed59e1d1-36951a11701mr22183100a91.9.1779259002767; 
 Tue, 19 May 2026 23:36:42 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36959ca0fa5sm8364342a91.3.2026.05.19.23.36.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 23:36:42 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v5 2/2] target/riscv: Improve PMP address alignment readability
Date: Wed, 20 May 2026 14:36:06 +0800
Message-ID: <20260520063606.36600-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260520063606.36600-1-jay.chang@sifive.com>
References: <20260520063606.36600-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Replace manual bit manipulation for better readability:

- TOR: Use ROUND_DOWN() to clear lower bits
- NAPOT: Use deposit64() to set lower bits

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/pmp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 8adf7c9719..58a8923d0d 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_TOR:
         /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
         if (g >= 1) {
-            prev_addr &= ~((1ULL << g) - 1ULL);
-            this_addr &= ~((1ULL << g) - 1ULL);
+            uint64_t granule = 1ULL << g;
+            prev_addr = ROUND_DOWN(prev_addr, granule);
+            this_addr = ROUND_DOWN(this_addr, granule);
         }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
@@ -641,13 +642,14 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
             if (g >= 1 && g < TARGET_LONG_BITS) {
-                val &= ~((1ULL << g) - 1ULL);
+                uint64_t granule = 1ULL << g;
+                val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
             /* Bit [g-2:0] read all one */
             if (g >= 2 && g < TARGET_LONG_BITS) {
-                val |= ((1ULL << (g - 1)) - 1ULL);
+                val = deposit64(val, 0, g - 1, -1ULL);
             }
             break;
         default:
-- 
2.48.1


