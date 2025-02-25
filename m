Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E8FC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL2-0002IV-An; Tue, 25 Feb 2025 13:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ0-0008B5-1U
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzIy-0002Bi-BG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so57827005e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506714; x=1741111514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yxn9ofMo25WYq7dF2Vjj2JTu1cwoC9F4JXJ3NPkXp1k=;
 b=bl34Zr+WjOITsj9Ca+wSlFU8AsFhIGifwwphTbSVFmtqfrN146/mKY4HUVVG6H1VHm
 bqIm0pIuPYKdDc5iOx469sx63/hr+0I6NFi9vhZOVRVwTqkwXIqWSbeX4VKBOjoJunmn
 UhucwzwaSBDwUfPiS39Se9P+nja4v8MjbHejDnBiJmF/OtDnGLuDZ2d2bVJeKJmkn19+
 R1v9ATdzqJtyN9f3MGpRzQzNVq68ZrZJLNbH95Omo0nYvXCX720FhS0rT6xYVUNZ+w5R
 UV056NaKuT86gnxm0KIz5WaUN4eQbOBxWVuTFHRsJDMNFj16cqhvcFzyuKHlLUda0G6p
 YYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506714; x=1741111514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yxn9ofMo25WYq7dF2Vjj2JTu1cwoC9F4JXJ3NPkXp1k=;
 b=xB1UzObgwPsnfOZPJByJuMLMHpByGdH6jv+zVKYy4/oTjHUMoBesgu6VCiIl8VIqXy
 N3SZh1x3a/ZAyUHztQmFhHq4t8VPJY54y6D8jNu1623wJdoYjX6kx3t+i5FoNIbhopQf
 bqD0pIIkE5jXzZAYXzImg6AxEXg4o3iDZIFmAAVYuSJRbijtagBP0K+sRIPYaMjALJge
 0jJBUkjHUnjVt9i0H/ZVaI8XtkAPpOh7BqXlkr17QFNynNCCnzihNu0a93HKk+HUvQcK
 5C8fiN/sYfHEXhjC67kEKNU7DofZ3V2dPVowDNcBd3zre87xOlA0tN0z/E+gWiQa7DVH
 YNUw==
X-Gm-Message-State: AOJu0Ywx7wMPA45uDBV1qjuTVDBTPb6lDCQrcMagYTAUaQsnl5g5tMbB
 xo5cIPSfxSMyAg54tDCmCQs+S5dO858Ing0GhE5X4S8sRyA1ybOzFMDmYGKogvmKVxofgQnS7Pl
 O
X-Gm-Gg: ASbGncvl2LOI7i17U6L/Ec2YzFLw+aEeODpPFaTqrpYHISRd45ALGiArctXN0o8Dnve
 pOTm42DpxNxeQirf8Z1R/InmOk/yP8u9lRF6MDUksHIyLDqO5fXjgkjEd3G2aPV+SK64oZYq+Xq
 xMce0UJ4RZyrbHrjAB/WC1LdjfHUOx/X/CjzRDRHC/QJEV9HLRW7IEJSd6xQ0cQNQZggA2YP4EB
 4epDZhMl+Ya11fgs2dv67a0cROGJcvataOuL5+7pD4LIK1dAnLClYFR7DQ8Ewco6ICGZKKg1e6u
 6SU8W4JSoNbIZf0SAPu0qtBnjqdxC4GA
X-Google-Smtp-Source: AGHT+IHkzLD5ajZr0wOXczBWkQNn2+Dy9nkfKfXw/R5ZYRpQijzOSTToQt8uVaFr4lg+ydKYcRki4w==
X-Received: by 2002:a05:600c:3114:b0:439:9b80:ca6f with SMTP id
 5b1f17b1804b1-43ab0f255a3mr49938835e9.5.1740506714354; 
 Tue, 25 Feb 2025 10:05:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/43] hw/arm/smmuv3: Fill u.f_cd_fetch.addr for
 SMMU_EVT_F_CD_FETCH
Date: Tue, 25 Feb 2025 18:04:27 +0000
Message-ID: <20250225180510.1318207-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
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

From: Nicolin Chen <nicolinc@nvidia.com>

When we fill in the SMMUEventInfo for SMMU_EVT_F_CD_FETCH we write
the address into the f_ste_fetch member of the union, but then when
we come to read it back in smmuv3_record_event() we will (correctly)
be using the f_cd_fetch member.

This is more like a cosmetics fix since the f_cd_fetch and f_ste_fetch are
basically the same field since they are in the exact same union with exact
same type, but it's conceptually wrong. Use the correct union member.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250220213832.80289-1-nicolinc@nvidia.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b49a59b64c2..b40acbe0245 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -377,7 +377,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
         event->type = SMMU_EVT_F_CD_FETCH;
-        event->u.f_ste_fetch.addr = addr;
+        event->u.f_cd_fetch.addr = addr;
         return -EINVAL;
     }
     for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
-- 
2.43.0


