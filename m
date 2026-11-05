Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478D606A330
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jcAY+tWS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvAo-0004Fh-Cy; Thu, 05 Nov 2026 05:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOvAj-0004EL-LE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:58:23 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOvAh-0007d7-Oc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:58:21 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1072665f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 02:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793876298; x=1794481098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t2KKIrPR1POJjOq8/zwNRKeGnt6m/qNkZvE8vxmrh6E=;
 b=jcAY+tWSeBH91tDc4tQ9RK9QcyCrJjdoX5dg1JFz7O0diuJu0XQi4r4oh4R8Zxa4+U
 tzQndJW++NuqMttJSzO/mw/uWjwVvaeYXqVsswhnsJyQ6wu13PH6Qv6xuftJqisTlwbE
 xhdpkDvQqcItXCTDhc+y/V/O4L+laa39DlnMQK3dROVtK8qJKY3aVpaduNZtd9Pl/taF
 bscCBPFacWGLZljO7PIYWlT1E0+NnIyh5/KUez/j2L7kMoh9KFrNtK0R1NkYCUUA551o
 YbQDCDUoXs5VmNMs0dMG6ejYaGERs0mPuv5IfJYnNNtMoIE348AWLaTwJyvx7b4Vm+eK
 6XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793876298; x=1794481098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t2KKIrPR1POJjOq8/zwNRKeGnt6m/qNkZvE8vxmrh6E=;
 b=gEIrG2FOawWWcSdvGGr4XoolcSUPblzmsgzDLKl5HrVREZSrqJ6jOz92i+QbD/VPTm
 tdWUdFnyg1OVUsGguxBaTlSuUV4Pu7u0P5cPxGqKWj7cVhnc+Vw1ocqMSTXx9zkrba8b
 nq/MFDhcANewgGRZkiRD7dfucPPSxIGnHhG88tbBM4+EZpP5xY/3RsCjhCLSVOVwnns6
 3tt+cNunf/IBlGJYa8oW/hNuglhIWV/upWtW6N9GCAFxyvmXru/W84XeXVOfsfkO96J1
 NFfEP1jPDzg2mc/canSPPv4bWFdqyzO6pILuwzoITuQybyo3Pg0F0rq2Ul7ZTVtcotIQ
 dssA==
X-Gm-Message-State: APuU4Z9COd11pSwyX+PNAzT2I7W3mc2L64B16BwFXdXCMZ+kj0LOnlNN
 HwE0PL7umxaiw4RDq3Px7fruH4kr/Sv0wGTi2+rewiAMHQNbY6mEqTHibe68Zl5+4b9/hgcKNwx
 MHwzVsl0=
X-Gm-Gg: AYBFou3gdRA543gmwQzb2nawCGOmVddGYuraHcZXwx054zko1HRFRPG2yjqY3nu4cG/
 NqbC0o7/xBw0aUZJGYKDW3Lri+yIpWdQx3RhyxWD6uLKdi9Ctf4X5uaUMPEuvYbDBaDg9tTGuiH
 E7Wj+uXxQVReNeO/XXNe+0TDD39b1vMdQ+DHQalCOmGIeUcdHGQ9KTf9Sd13m8rSawPkZU/JXtw
 53ehaQOgt5UcsjtaNjRAIUV/autse9DU+xzDfm8K0DHF5qvohWKR4WIgriuzqyMnP4rLVCAfDGy
 RJ8ZWucdihY5MPrKhDHinrtykZLus17JbYbyc0wpNaX6PZjTi2RaoW1QmndezNFHBqMvn34wWuG
 Gz8yPYfGhTFmbSadnb4WWJ17fZD0camHVNR+F+t+ZQBdQ6xDaRK+dvcoYFowWIBJEF+oSiO4r5j
 org39saphfnZUjbnG6dcXJnFvQrLAqwL4s8b8WM6pDC20LXhDfdpd9HY+TVAXeMtTVmXhQw5gKl
 naFxL6qmwB9WCiPuISHy/m4rNihspff9aqGSkNBD+SKC16YmDebG4qE6oV3ekYkpuI3ecIZ+zSq
 7PTlUoAaz+an2ToNFUVkb+4OtGuQLF5KOgJnB3+pj9IlPXzEfcRZLMJiv0vwDQW5xGcolSTGNZp
 l0prYV6z3bC5fhE1dkmm3rF8HXcAwnWIhPw==
X-Received: by 2002:a05:6000:990:b0:491:286f:8e62 with SMTP id
 ffacd0b85a97d-491286f9074mr3510257f8f.12.1793876297719; 
 Thu, 05 Nov 2026 02:58:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1ffdbsm9009278f8f.50.2026.11.05.02.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 02:58:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/i386/amd_iommu: Mask address when calculating large PTE
 page size
Date: Thu,  5 Nov 2026 10:58:16 +0000
Message-ID: <20261105105816.3012283-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Side note: we don't seem to enforce the spec's requirement that
the page size must be larger than the default for the level
and smaller than the default for the next level up, but that's
a different bug.
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


