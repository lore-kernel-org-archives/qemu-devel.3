Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF746CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsJX-0005qG-Iq; Mon, 18 May 2026 03:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOsJO-0005oo-5d
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:22:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOsJM-0004dx-Cw
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:22:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-834f1075805so1497780b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779088967; x=1779693767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0HL/wr8JMbX7mHAeT8rrFM6IXQVebR9Lmq9PhVV0xc=;
 b=G/ex6n66/x0AGMtS3/OFW+4rS8K44f+vKIHW8y64DG3qMPJXzVk7E/vbbNWdaVkC5q
 pKPeROmIUdddi5tvJoOpX6GvA1HBHHUJtwCoAeWhciqNsfUSi5cKfC/M85a2L9vEyR7z
 wol/WP6BdEcOhPUhJ1ugseqKRbW9I8JQGXKR6xgvyC+JLfDuURG9Ksu2vr+NXLsLD1bL
 PQOSBg4aNraps8eHPiOwooN3/2+ihC1S4njNRfl4tU73Atos8CBVEZ5TT6MwYdrY00hI
 mI4ohm33fHg8ymv1n+sYsEckjuMFZkzx4AMa9qQqbj/549NxY3pFV0K244AtKoyKwVCr
 mVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088967; x=1779693767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0HL/wr8JMbX7mHAeT8rrFM6IXQVebR9Lmq9PhVV0xc=;
 b=Gptw7oe+2grdJoen8LM3F9Ooy4sfXdsqMYUYxmR9pY91La6NEp64MfVPtH1uJtjMi8
 hfAoowUGoe4I5gTX3Cp9os3RJ/WIXPSKoBtQmUFoCAj/SE2y1c7feZxlTTuUaWWP+Ikf
 RNuORvxu8WDgt6HDRh65sEhfksu/LWHYZ2GGLE+P0EuvFnJ+Bi4TT/vi2TgYvdXPhO1z
 0/0tHCbX0FzLR+MUs+YuA/SorbfxI1jp5DLihc6mauLFev+WkEDBuhLTZbRyz6MgTAIn
 vQSgfC85BSUXMQfH9ivk3oV7rPojnz/fb6lfeCFHN7Bs54B6Et4b2f11pt0/wT9SVzoS
 e9QA==
X-Gm-Message-State: AOJu0YxFqvsqXThlaUjdUaMrLHOK4GIOV2Yxojvs9rsdSxlcIyKYhKFA
 ZmfufpwQJbk2WITJ1qlmunzXG1R0+i19t9a8tAK4Qd1Q6ngSydI+RfIrcQtjN6+d6+EpEpnh7ti
 V8SUZ9J3MOgaiAHFCOVY81sHZRAo40M96BYI7TrBIujac20O++CXjtBE630cF+nlSOn1ZC8Qune
 sRdcceikvV0riOEuMrufdiXtj9zIEnqw6n2PmFNzndABI=
X-Gm-Gg: Acq92OHYuEKtftpSq11eDXAccmNzGec7Miu+gwaWybQHh1mdUb+PdUluz4B0wVIrI2w
 st51z3sELpA0Y8k/1yFOGOwEbJs76VqhCvFEdqw01DCmyRugZm7Kznacou2HulPFHR0UhNu5F3C
 yMlHzowZ1c1Oxww6Ft6xsB1cxkNRhDYg+ErotT+btzMr5X7QYmE5znkNeYe5NeoVGlSsachPEFR
 wWXsFOJAOavJEQVOyBN3PakpWOOIkJtInfWlrRZbi+T5negAhNN2WVwv46Raw0S2OK7ed6Tqcls
 SRxCG0ZG0NVpdvPkM1W1I7O3sWyfJC9JmmckJ1JzofIYnNfowHYpY74CxpbBqdg22WrS6CHvhEw
 EBKhhN+jEu0mojLwQYiekxrbuEBaAE4tKITSkUpZlPeyG9bWP2kr1Bw/iudE2/sodSKOrdN5WQl
 e2Yqm9m6DTjl7JnhFHI59mdLP8iP1a9TRPvuEXtAHMWuuHDWsEOuswzIgjx4TXiw==
X-Received: by 2002:a05:6a00:194f:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-83f33cf2aefmr14524773b3a.21.1779088966914; 
 Mon, 18 May 2026 00:22:46 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5c045sm16502348b3a.37.2026.05.18.00.22.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:22:46 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v2 1/2] hw/riscv: Don't insert DDT cache in Bare mode
Date: Mon, 18 May 2026 15:22:38 +0800
Message-ID: <20260518072239.16293-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518072239.16293-1-jay.chang@sifive.com>
References: <20260518072239.16293-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x435.google.com
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

In Bare mode the IOMMU does not perform DDT look-ups, therefore
caching DDT entries is unnecessary.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 hw/riscv/riscv-iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5bc2472a83..c5c04e336e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1358,16 +1358,23 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
 
     int fault = riscv_iommu_ctx_fetch(s, ctx);
     if (!fault) {
-        if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
+        if (mode != RISCV_IOMMU_DDTP_MODE_BARE) {
+            if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
+                g_hash_table_unref(ctx_cache);
+                ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
+                                                  riscv_iommu_ctx_equal,
+                                                  g_free, NULL);
+                g_hash_table_ref(ctx_cache);
+                g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+            }
+
+            g_hash_table_add(ctx_cache, ctx);
+            *ref = ctx_cache;
+        } else {
             g_hash_table_unref(ctx_cache);
-            ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
-                                              riscv_iommu_ctx_equal,
-                                              g_free, NULL);
-            g_hash_table_ref(ctx_cache);
-            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+            /* Remember ctx so it can be freed */
+            *ref = ctx;
         }
-        g_hash_table_add(ctx_cache, ctx);
-        *ref = ctx_cache;
         return ctx;
     }
 
-- 
2.48.1


