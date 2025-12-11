Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F82D3E78A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 02:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTWr8-0000iF-9L; Wed, 10 Dec 2025 21:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vTWr6-0000ha-Ot
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:56:36 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vTWr5-0005KB-6j
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:56:36 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34381ec9197so410758a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 18:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765421794; x=1766026594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFPa43ZKBK0jE8M4900tFDQHM1I1hGL7lW+BtayTHNM=;
 b=UA8bqKZreG7DLqkxHKxBsbZX5CUupIlI0Po5Su944CZkvJWmHDL/tlS8oGnT2PFdto
 0zS55mHGSFazgJKJ2QnA9s912bjp6uO4D5FCqCQS//99smNIiZXEAGR0NSSYM/XOY039
 SiQEMFi15S+oRrRTWJb3Zq66Ng7FZNEnd5qtBtJvj3qZrONObIxaJSnIAhdO1rUe4t1P
 KDoAIxSpC4yysXjaL40xJvV/bUxJWtHJBIfN8Ws++0JyKOblCoxnztHndPdJ47t117nN
 q4m9QhPNPBe5Vq0IZE1mqC5V7lddvx4VnuxCovv20ap0O8Tr2+pEPxugCEE6QnelAuH0
 w4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765421794; x=1766026594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFPa43ZKBK0jE8M4900tFDQHM1I1hGL7lW+BtayTHNM=;
 b=CThv6DD1SQ0FRC2REOyEYN5BkMSQeRnuIMm9mPCmjxDjME6MlXiSmI4jZ4gIGXMMM7
 dU31uIriPOE26EWKX/AZV8xEddMLN2znMBST9Kbg3K7cM1tqDP2lA2/NoinR+jSMmzrt
 yG4CnBMFZ5atM1hOPCWsusa8+pbjSchTKq/vAJzlqNDMsGGvhH7VKTIawZgYDgamFy4r
 1paZkt8T8a2Hn6KHdR8Cg0LyqDl5ttALEERwh06vwXQWmKLvV4d9OG7PhJkw+oEbF36m
 BnXPQea7qQdDzY34/2DLVLepyoHuK4GUD91HoOmjM1OKt9yH3tRKUhT2Fc7rnw8R+/DE
 pG5w==
X-Gm-Message-State: AOJu0Yxt+jT7QTqdeotxAB3Ej/ycUxH9XDBumIpkO9GPuu9TXvC4PyQv
 vsD3ftogvoKWt4r/M3b/twJcV3NSNemT6UwCxCHRftMHlFvEKlRFJqK/5aquqrljeCtCVRqtAMJ
 VRZ/luKqCkkKoPJgJiK9lYPUslQPsAS0e/peXSTKlf7whUQqgqB4PmGTuOzes9r3cfVKQW9tgEw
 1hbBB4BHnA1eMKjL0Pv//2ptrQm0WU5tBlK+HeMGJv
X-Gm-Gg: AY/fxX5nQVuvLYYym5J4FQhIOB3Tr6LGCH/2u912HuchncF0s1Th104EQH01SB6SSMt
 H74XeJrEweRKx40H6/1MkkaH1p57uwo+lsLbIV14NCFQ9hYmO62L3ZhC7NGMOtM9QtuUd64Zx+A
 QFK0kjmEuF5Ky08clhOSsLnOH0SS0WIri4sdCHVhp3t6UX7xIqpUDV9B+XEQLUHu+g/fn3+/78G
 ZcbMuSqLFFqoCL/Ya4+bSGhFGmgt14ocky+H98QltLFA/N50Si4F7r8HLT9R4k/4NYPHUmfKd0u
 x9UyMdBv2NlBfA1u5i3u2NQHF8uN6uvTeiu173HEVjHiYzlu4zJZocdpq0eIRuvyCblNIGGfvoj
 waAhnlC+wOTkOsMKjwXNrg6lDV7MnaeaOqfe1iJDuJE+oypWXRjH8EODTeu5PA5Dv1XB/zyZZyX
 WGCnJAbNwej+K/J0mQfrfx9XshZjFG4LZvE2Oo7eTp+UxSZXM9BA==
X-Google-Smtp-Source: AGHT+IE29SNJ8mua6A019W4ewlKiI0GCnbrkI/x4Ttye7vvNHtSaNgNFdNwo/7G+LEJLk/Nit6bvvg==
X-Received: by 2002:a17:90b:4b85:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-34a7284d089mr4709841a91.12.1765421793461; 
 Wed, 10 Dec 2025 18:56:33 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34a926de17dsm70870a91.6.2025.12.10.18.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Dec 2025 18:56:33 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 2/2] hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode
 handling
Date: Thu, 11 Dec 2025 10:56:11 +0800
Message-ID: <20251211025611.99038-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251211025611.99038-1-jay.chang@sifive.com>
References: <20251211025611.99038-1-jay.chang@sifive.com>
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

Align SPEC: Bare mode contexts are not cached, so they require
direct memory deallocation via g_free instead of hash table cleanup.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 79eee2e85e..fca5763858 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1344,7 +1344,16 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
 
 static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
 {
-    if (ref) {
+    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+
+    if (!ref) {
+        return;
+    }
+
+    /* ref is pointing to ctx in Bare mode. Bare mode ctx is not cached */
+    if (mode == RISCV_IOMMU_DDTP_MODE_BARE) {
+        g_free(ref);
+    } else {
         g_hash_table_unref((GHashTable *)ref);
     }
 }
-- 
2.48.1


