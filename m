Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40081075269
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DMp-0006qY-Rh; Tue, 24 Mar 2026 21:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5DMn-0006q5-Ps
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:49:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5DMl-0002F7-VS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:49:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c742bc88d87so2105958a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774403342; x=1775008142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdL+h6yBgXbZ7bBX74DhN7YW8IAwuTGpZ2NmoWW2Uz8=;
 b=NUeX29a4dGn8J7DrK5E9+Qf7+Sit6NGqAO4ezeM67VBMY+wdcE1GnwjKX7l4bOauFL
 Ev4aPcMK7ap9NYiiI6Va2JbU9waBDu2ok1dpNQm6XqEljsW6pB1cxOcChEP+FgWrnNEa
 IkK0Z01mZAdcv/WlbK1HbckaIi/3WQVrAGdCkufVS+tc2AnI8OjzZD5FXnUAIrVHsuHO
 D0UynK8S53RmcUGtdbkz7uhPnLEXtwF3M3KrsFmRRGOiSFgfGQLFK/HbaG9l+9QGPDOG
 5MFDBTIET6a/2YzRGB2mqdcFymYwZv5Xu13WPwmL2UGFhrsh0wJvoIzIyeR6xPsLKxnJ
 YJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774403342; x=1775008142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdL+h6yBgXbZ7bBX74DhN7YW8IAwuTGpZ2NmoWW2Uz8=;
 b=V2G+VlgscBfkZajp2tm1H1x6R9ZsMpTmRJ4nhiWIxK85P9FHtypAwP/58ZMLG/NQ3v
 +uEVROZcCOv1VMlwj/mCtzwhV3ImMU9WY0ArdUJMKHZEbv6B+wY5aeNg/j26oYFeuVOR
 d7GHVHiJqIJViukUrC9R/yBdqpfYsLfayuuVUzjQPKNVccbBKH7xhvbOY+hSI13TJO0k
 OS4eU3XhdMmRLgx94eggcmBamnhNzOMfD7JOxQ2IyhnQTiZU3ckKuJqSjq8mXTXuXJrf
 LuBM5Lai4X3nuxC1vDN1URcviIXPrOXsXCVyylBpHKQ2G6sMCXoDPfAmMtxM9INDzJ3B
 /+SQ==
X-Gm-Message-State: AOJu0YwbPEBRjhlXb0sLJbao31Py0oiXnY3QUXdPyYe/z0Apt0QZI0wY
 rhHcut2AA64bj9HbVRC/bWAw4663hdJfAcjPpQd8E59XpqJ3s4r9mwAsyDPcoPJVDk23WmKbro1
 +rB6fx/93N7xLZqjkycb1+gYCOu0EOOl1CR6gNpdPhoDvL8cIXodoe9n/tm3MXkleTMbjIM+yUE
 5U1Jf+qpeoZKzVYjbIFBTSmAQJiXCG+Dd6vA8BBcdLkeA=
X-Gm-Gg: ATEYQzzrUFwLC/YhzuYGpGgxXDKyMHHaf9tXGIQmk7AN+nssJUNZ4eXSqEt0Q5yn29j
 6QiNMSmAqun5kMSt6fg0hbBhD2GjSbTuCaLMuYFS3TNilMNK2VhdE+reLKDXhdg7sxj2AiAYOal
 vUZ5rgNR72/ffBQUDr1e9EWlttIDgXMdUuab9Hg9WnV4T7bmo7MmEDLmIyGmG2Gp9ykPq10e6/i
 9X37QCMkBKGWoa0yU/u67WpPXDOydaKPB8vD4fUbNrcTWcMkNzfJ8/fdP4AyEPh83b62skfUVof
 LBjUvx+Sa7rJKiAC0kGTAgduFfFaN9gqPaXf1a+PEvt84tDKP9T/8xzXcmInANljswAvfzkSfz2
 WaPSIAKqOpUrfI9uXCySEuFL4Mz7PZpfjTpRLIbt+JRIGE4LgDnwYhyVq6APMDDqhZ0Y4XyQRSf
 FEnebkeMuGt2+fl6NN91fBHXWNGhQQY56Mb3kwrAN/wFE1RuXSfugKifwdoJiqGg==
X-Received: by 2002:a17:903:38c5:b0:2b0:b075:f2fb with SMTP id
 d9443c01a7336-2b0b0b175b9mr17981845ad.35.1774403341611; 
 Tue, 24 Mar 2026 18:49:01 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0aefd07c2sm17937615ad.31.2026.03.24.18.48.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Mar 2026 18:49:01 -0700 (PDT)
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
Subject: [PATCH v2] hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
Date: Wed, 25 Mar 2026 09:48:56 +0800
Message-ID: <20260325014856.58948-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x52b.google.com
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

Replace the temporary custom extension bit (TC[32]) with the
standard EN_PRI bit defined in RISC-V IOMMU specification.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Change in V2:
  Align code

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 hw/riscv/riscv-iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 225394ea83..30343e98d0 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1572,11 +1572,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
     iot_cache = g_hash_table_ref(s->iot_cache);
-    /*
-     * TC[32] is reserved for custom extensions, used here to temporarily
-     * enable automatic page-request generation for ATS queries.
-     */
-    enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
+    enable_pri = (iotlb->perm == IOMMU_NONE) &&
+                 (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
     /* Check for ATS request. */
-- 
2.48.1


