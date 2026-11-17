Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF05606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m4Juy8Ie
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI5-0002JH-T2; Tue, 17 Nov 2026 08:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI2-0002HJ-WB
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:03 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI0-0000sG-8u
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:02 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so2675439f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922318; x=1795527118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2qB+TruDA6V/Hg/qEMwbvI5mG5608AYXXpYycfVwoYU=;
 b=m4Juy8Ieyc4P3Rwbi7uS6qbx3z23oC8zDkLa5JbxVB/qlkqxj0YNKXIte+iwrqhNYr
 WdLEIRlUR52TPvsOCCoEdQqlnZ7oehh4+AyOfiN7fPfBKhu1v279HespHPAUWwsgZKP3
 jvx/+qfmYOr0PufDClV6b2O1zETAAmvpP4Q6DXLRvkfCGvTYN935A/AfLmYAkHCnmxXt
 8PH+cNnCaPu7MgNTugG1Ak/UJ/XoIuthX7/ukE+KYh/WbVh1qqBy34Gw2s9BSfnM4B8h
 3qmaYwE1qG8DBxtseexv2g1LWM7e6+Jc/SjVf5ih6eRBxMy1V1e70Sw4lwj39OrI96jN
 eS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922318; x=1795527118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2qB+TruDA6V/Hg/qEMwbvI5mG5608AYXXpYycfVwoYU=;
 b=jYKRg8IPHdqkwC0lrvS2MhSXCt+Xc5fdMZ17wtfL+uisVmKSrPCfYffwUXjMosnirj
 SyR5sjhZjBeZxlSwMnoLjvMmewvHFCAtTs6pxPFN+RYBihHzSedSThdUxzIw4dI84AL/
 UHAA/G23Z47k27yoih+LLn/5YgHXYyZtpYsR2EBKOLI9215DXAy0qrtUN2KQJDYr0eWF
 spR+mFQj3ieb5U6x0MFfPOua1r5+2Idhtx9qOBMLUUIpSG6nod9CqFeQ/CbhKzwmSwao
 S7T5Klh+LY3Bgu0aFiR7dVNFNycG0lmJeDWs1gFCdPD7gyNcwQTzEAXmo/IM6X1LZZP9
 c/2Q==
X-Gm-Message-State: APuU4Z/bB7gNvPjPvvuJQkp0rXLzO7e4MkAISHXXPOKFa4De6gb72JMD
 L5uscy8iVO4Nl02GxHi/E60S4VDgukfPquN4SykAm5jk82nV4YazQZ/fiyfiOhxGa6oaFncufGL
 xSI7Yumw=
X-Gm-Gg: AZFdTZdqVvurIejNPJXhH9eNxCJJZxcAMSTkH68+zNmG/4mp0kTcB+VUn+2JvVrejfe
 gUuympngJ09GKGKkp+Wn9NmnDUqWCExxizVOhJS06dklmBBRrVhiOKPfOZGV40hiGlJmZS2dxJB
 HaACJsFc5NHYr7J3VRKAslaWFzGUznscxF00gOIeJbtzTgl6eQsQDBGV5gc0+KrF7kbfRxN/LIi
 s2parPF1CnsvxFCfylCO0eJ9PFSkVTqGqHQqgKd/81Hui5KlPVxZ8tvEVX5LfG8kU3+U+nWq7rf
 vdOSeihrUn4IQg3oyX6av8RcbOj+OmD7A5fp2WrdtqoGPemR38UDWwe8mOa/kU3VFEshatqEWJZ
 Mtr1Jjo/csDKYk74WJe2zW84TRWnLj9AsdzEMB1KmFm9SBkTO9I4yryFDmU7R6XBUw7KOkehjYY
 jrJnWHAY8H5P1OBW2hOMJy+AG8ZnfvQDzv+aV/tgj/H2F6Ck2de+xd4md5bQ4MoUpfFGEdd2z1q
 TCEoN7b8kd0lkT/Dh9C1L0Dz9+AvD3LOCoZecapuP6GhVD5uNPti0CtpAS65FEQDBRYwoYur0gI
 Dwt7UE7XNj8m9ws/kCRmL2hj7ahmHucsv+geV6wB/E8S/2RyLiAa99EnEIzyPiReoKH0R5F3ucS
 D9WqQeNMhCi1ubGjR1n4pGAEKqgSfrXiUbawUH2w/I80AEqDH/IL9f1s=
X-Received: by 2002:a5d:584b:0:b0:490:71a7:6f51 with SMTP id
 ffacd0b85a97d-49c72ba6509mr28875120f8f.45.1794922317904; 
 Tue, 17 Nov 2026 05:31:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] hw/i386/amd_iommu: Mask address when calculating large PTE
 page size
Date: Tue, 17 Nov 2026 13:31:48 +0000
Message-ID: <20261117133149.2108068-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The amd_iommu handling of the "large PTE page size" (where Next Level
bits are 0b111) case is not correct.  We calculate the page size
using the address in the descriptor (as per table 14 of the spec),
but we don't explicitly pick out the Page Address field, instead
passing the whole PTE word to cto64().  This means that a PTE which
incorrectly sets all the reserved high bits can cause cto64() to
return 63 or 64, and we will try to shift by an out of range amount,
which is undefined behaviour.

Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
(matching how we do it to get the address for the next page table
level in NEXT_PTE_ADDR).

Cc: qemu-stable@nongnu.org
Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Sairaj kodilkar <sarunkod@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20261105105816.3012283-1-peter.maydell@linaro.org
---
 hw/i386/amd_iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 948d8611b15..008e882724c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -216,7 +216,8 @@
 /*
  * Take a PTE value with mode=0x07 and return the page size it encodes.
  */
-#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
+#define PTE_LARGE_PAGE_SIZE(pte) \
+    (1ULL << (1 + cto64((((pte) & AMDVI_DEV_PT_ROOT_MASK) | 0xfffULL))))
 
 /* Return number of PTEs to use for a given page size (expected power of 2) */
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
-- 
2.43.0


