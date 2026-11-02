Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAF606A32F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AC/Cypl+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsE5-0005Ed-EJ; Mon, 02 Nov 2026 08:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDE-0003QG-RB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDC-0002Kf-ND
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so25286825e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626593; x=1794231393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iBiMuIp9n8up73RHu4vxqBSnWbGZ6MRGnHsIe4y3uJI=;
 b=AC/Cypl+I4xgbwPT43xCaDjEWPygn5aM4/C2NStHNhxrpSt6DWsOOI1/Fd/Qf6yuXU
 lMafP9OmjdF4B66QK8DW6Ise09oBxHoJTp/qcnbR4OX/CRxPHwDUtLxPnremVW1Qr3jC
 V3GMyckWi+nE70JubE5odMLw41nkaebOuuYx6cHF0BXkXrU0QiLVfEKGrWyLrM3pNAhD
 4aqaWmZz65efvbvHPuADEI+de9Pq0BEsvrvr916yQHpCh/xc6IjBioersvrOLrH1dHko
 goGaRwVxACjW7XeFWCXsKYuSMc4qCAvd/inLPT2gOQMf4s1n4esCUPJWisuRy8w5UipO
 gMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626593; x=1794231393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iBiMuIp9n8up73RHu4vxqBSnWbGZ6MRGnHsIe4y3uJI=;
 b=2AB0acpUYf+mQc/nuna8gyMGHtr52bzoy+Peh7Kr+OJEScLqSE12xHxvcOZDnWTIuO
 fIUdvt/7Guku40AfakDMyUy1XeIdac1GbWA+XJuOfOM0aXZK5PQPg2hUQ4xwKuerm+ED
 3As/Q0DA/fGxmUS/8GVCqXo9EAfTUhh0tKoaWc6mEMRsfPQj6DcUE2/a6ibBp/ziApij
 NRkQaD6LN6n7f9PcqWTHNf1lvdq/A3ZoYc55rzhOq77jzvEkeJ2eGiWN/UisVveKzCkp
 qkb/OQSCkWbJBOywmBLN85bffimo8djqdcnDLyF5i7fdzYtXMd10wZE+QpTfLZ2Sgx7e
 IZ1Q==
X-Gm-Message-State: AFq9FYL+X0+yTZ9dts7ymSPUGfP6dLfBtYydRpg9QRl0jaSA06BjHW7b
 PSBvyxOc4jZjl0Gajv8YrBkekGVYMZjW/eYDIU5k8BQA9zrzEeW5U98VcqEau0ajwbEILOk9wBm
 bNvImazM=
X-Gm-Gg: AYBFou0peyBEMy2Q3GVitTj24mKiUmtKyHcFQB416i8KUv88nSrwtJn5SAEnBJn0eMn
 AUCCX5p8FchpwWnvrQRW62rPFhMInHRbRS/EYk5Wmsm1rofCyHExB8QRsbIqDLmUHJLg73Nejyi
 yzMvnP+Yd6j/sOiHFzetQ9j9ET2cOC1xt57APzmTVg0JmSz8mTk6xc5ETGAkncsQlida9Jtak5S
 +4wXnrYVCcxx2mHN6ztHcrWsHe4S6/jm+vKDxcKo7p0h+RuK/ZQFUYf1sDJD+8jNxhMfCB40lR+
 P6I0fHP1X3spe8Xjk3Q9UFKlUuV18laPzkvE0RQ7tymqiqRDXzDchUp9mgXfVu/dO4S2AL2uomB
 cKCKLfJWjT6FAqOGQdHBytNmA/yf2oim4A7JJf3mY5AnTgewj6Jo1DwAGfkDpxkcxUQWPLsG6ei
 gpGz9T7+KhJwyQVWaneDnSrGVYFDiP0ML80M7tu/USHradNYIFdYebV353Qg61jTRiqbr391407
 nbBzTcfVvyrSyLEQNqzd12N2aHU0OL4n/yK78fy1f2znG1t6KP1/JGM+IXljXcH8X3DOlDVjZO0
 S3fDIg5C7YMb0PXhhRCzYSGD1v65JyCW4uCRqq143nVmxD/prarhfBilBttU7pdk8HprdmaPJFN
 s5guN6fx9UJmDbMwxA45A6ek+YK6sJXjLew==
X-Received: by 2002:a05:600c:8b55:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4ac17b2b023mr247058325e9.19.1793626593220; 
 Mon, 02 Nov 2026 05:36:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/47] hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
Date: Mon,  2 Nov 2026 13:35:39 +0000
Message-ID: <20261102133547.1375701-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/arm_gicv5.h | 1 +
 hw/intc/arm_gicv5.c         | 6 ++++++
 2 files changed, 7 insertions(+)

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
diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3c50238634e..2b08f8feec2 100644
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
+        l2_base &= ~MAKE_64BIT_MASK(0, cfg->l2bits);
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
 
-- 
2.43.0


