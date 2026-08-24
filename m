Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCDC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRuc-00033s-Jd; Mon, 24 Aug 2026 06:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRua-00033B-QX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuY-0001pn-Ih
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1358317f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567290; x=1788172090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xag12ub1bcuK3t8iRdQzufeU8tr65Q5N7+Ogw4oNi1g=;
 b=LGxsqjTVvAVbfiRa92DKHQMX1MSzFU/Oij+LO1HPaj97sF0d6sM/Bgwc3/N+QJ/8Bv
 SrrODslmxehC40w4gmYy5QmwJat/YCnx9L0Y9xBtzFg0z4AeVwlwVSF08won9J/JTAnd
 JnE1+Q6YZ87RHR5ulX2/fo8HXoLW927/Wjh15/+qF+YHB5xwBooZlykEl9GpGtGNlOOg
 zzrs9WKmyfgBl3eAZ57gWcYLVOgajSzK6+26/9xZEmxko9KQrlc5FHyld5P4zFms1mhV
 K2opxAKtwm0v1lB1ReygMHdqkwh4qPZfCqZBU0rWrLDdOTTOi1BUsoC5oY6uSn5bQTfo
 JYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567290; x=1788172090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xag12ub1bcuK3t8iRdQzufeU8tr65Q5N7+Ogw4oNi1g=;
 b=ofRU+h+IuqY8t2YjPnOCYNHOZwlFZbAnOiFWcDLCgxI9imf9kHQUCIsQAMYlFP7dj1
 t3YH4Fz2udjfRI3hGph94IMGz6g+USjJTao+W6Hzh0PwvFApVn75664c1XGSC6xP92WB
 jOFshbnHa+ggcevUeZbMO+NiF5DvMNUfKjkncTmyWSODXubWJe6YfrQmxc+u6W2CYo9v
 3FkikrPgT9Gm0TrQaR69xtF+zqB9OcV3NNXbedfMuM6a7G7HcWZIriL2JmkDFa0AIQP4
 /ms2VUUbho5ZGhofcFO3TBhjayD+6lHx4MepV+Lwm0GyYf3rwkwGdZnSVz8M0NtEe/aA
 V8kQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqESdZxwOL0CXRvFVcUsDTOKCqEOnzsYAfkjc1BER6P4fH5Nqex+9rXtVZxc9RwDw9dKJv/KBfp5Z8W@nongnu.org
X-Gm-Message-State: AFuF++kJMX/kTKdP/gbekJPkkFoLN40eeLr4WywGRUnp97OeIO913tZc
 cRkj1dzZwD5t2qlaKp8pyY9ym1NlD5O8vyqaijk0QF+Hhq4F88Fyb97KXaUjTspmBITDZWeZTwu
 HzLkXA2Q=
X-Gm-Gg: AR+sD12kXtlpJziBmu9RM/M2uwUid88WGmwaOze8HCwp6KeiFnbB3xr7iXuqf72ozXg
 3Dxu+DY2qvkeR8gQU0KKk6JNo+8f/snuMobh0hTtIC/e57tkIX/yj2CEsm5+tky08WzpfVEpfvq
 X3k/Yl1rRSX/bd9cCqb1t6K3SpNItUz7YX0eAza7BrCE7G+PPqCxAVcuWJVTNAJZOr6qcqaRVJP
 Iq8VW2SUQxyT0CWSFK2FIEcdZZlFYtGAZo7STaCXEJnBI7ZewXvDXy18+mlGFSO7x8Oyk1m66p8
 cGjVs00K8TD287/3trqcobGouLbRWpmzccRFKyMlLj2yOuuy1fXtnWURBhHzT9O2ahAoVjrzxZY
 mkU3vWf2PL+l0WUsj3HKtxjTtxq1h7XDVT8Oj1ZZZWW6sEoQegbLk8N9Bo8fSDIVmVIMmyxB6BS
 DJ7xRBJJ7HLQ3jiNnAmu9dCRlMk0ExRy8SYYCgFVD7SWBSM5dMeLaqKKHPzF1Y+nhazjsfTkFO+
 HgEZaic/kHb7jUMolOJFsPKOqnzM2h6UKKupnuhNappwfWaSp+1VVamazbpYHLs/zCWt9adc+I=
X-Received: by 2002:a05:600c:4f09:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-499b8457b10mr298163075e9.10.1787567290415; 
 Mon, 24 Aug 2026 03:28:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c355e6d1sm77730095e9.6.2026.08.24.03.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:28:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
Date: Mon, 24 Aug 2026 11:28:01 +0100
Message-ID: <20260824102805.639072-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102805.639072-1-peter.maydell@linaro.org>
References: <20260824102805.639072-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The GICv5 spec defines that an L2 IST is always aligned to its size,
by stating that bits [N:0] of the address are 0 where
    N = 11 + (2 * L2SZ)

We were missing this check, and only aligning by applying
R_L1_ISTE_L2_ADDR_MASK, so we would only enforce 4K alignment even if
the L2 IST was 16K or 64K.

Add the missing masking of low bits.  We already needed to calculate
the number of bits needed to index each byte in the L2 table, so add
it to the GICv5ISTConfig to save having to re-calculate it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c         | 6 ++++++
 include/hw/intc/arm_gicv5.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index cdc6c9d3466..20680a5c225 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -595,6 +595,11 @@ static bool get_l2_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
             return false;
         }
         l2_base = l1_iste & R_L1_ISTE_L2_ADDR_MASK;
+        /*
+         * The effective base address of the L2 table is always
+         * aligned to the size of the L2 table.
+         */
+        l2_base &= MAKE_64BIT_MASK(0, cfg->l2bits);
         id = extract32(id, 0, cfg->l2_idx_bits);
     } else {
         /* 1-level table */
@@ -1358,6 +1363,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         cfg->id_bits = id_bits;
         cfg->istsz = 1 << istbits;
         cfg->l2_idx_bits = l2_idx_bits;
+        cfg->l2bits = l2bits;
         cfg->structure = FIELD_EX64(cs->irs_ist_cfgr[domain],
                                     IRS_IST_CFGR, STRUCTURE);
 
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index b8baf003ad6..d763a7939c7 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -23,6 +23,7 @@ typedef struct GICv5ISTConfig {
     uint8_t id_bits; /* number of bits in an ID for this table */
     uint8_t l2_idx_bits; /* number of ID bits that index into L2 table */
     uint8_t istsz; /* L2 ISTE size in bytes */
+    uint8_t l2bits; /* bits needed to index L2 table in bytes */
     bool structure; /* true if using 2-level table */
     bool valid; /* true if this table is valid and usable */
     /* This caches IST information about pending LPIs */
-- 
2.43.0


