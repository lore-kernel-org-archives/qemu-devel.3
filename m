Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCBBFCB611
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWf7-0004Y5-0a; Fri, 06 Mar 2026 10:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf2-0004T5-6X
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf0-0002jc-AW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-480706554beso101650885e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809213; x=1773414013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=neIVOnBr0Aa66xW+JsZOMzMUdIBz29j3DIzODXV+V+8=;
 b=CTAXksa+wJ4fSup/y2X0P2g+bk+bNSVmhgruSSOnP6w7yquILTZx8dvKRg89//smcJ
 AKuZroUj79t8opPAtNCeuPafBpprm8GJSTDsRcPH8YOL+TkafcsRFjyXZbcdNRusuNCC
 x1wZgslcfbvL2/5zjQA8LmDvWl+ue1gHARRNeg8/54eXMdth2npzX1GXvZKz774i02dS
 1Q7Of4ZGG22c30SdiLrKxT5OxZZn7R/YouWWFJyFjSY+Gr2rR2g8+efaYlhsaQgF7MKU
 1zsyfnIz8IdZsFQswPJEdyauNcqW34a0gQPEzzSdN58eBXZAcrrCfQw4fYZ3Zy8GMSIs
 CtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809213; x=1773414013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=neIVOnBr0Aa66xW+JsZOMzMUdIBz29j3DIzODXV+V+8=;
 b=LMNLwlC3YEYtVbiKcEeILYfnBLfVFo1Admw2lgHoaec105ioMiVZfMovwxPodoBFLV
 gbkqKjZaglNdbP5/nz/EO3a0fqRtAyUypHjYWadoxknc82O4HcaeORoEpw9ZbMgSm0Zx
 5vzNWNnE406bIBhpOq/IgX9ByIu7hkCvMiHpJ0saCmmgLFBTF4YdBN5DnxUCtN2BB7gJ
 g6gEBalbKTrOAjY+kkWXKEKmY3vUg6KdkO6I3KMCzrPw13g1EkV68N5w4QMcSMgMAyNs
 kHnbBu1LyD4HdbqofnmcwD2vcPMWRBcIY/i01F3TiNJ3ncxbIOFjtxx3/r1K/s6O53Lm
 lS9Q==
X-Gm-Message-State: AOJu0YwYjPqiAar2Qw751K47dwf+42JulGnLXrWLY1Uk4g9zIa8Q2BoL
 TKx6y/cwQ/R91Jn3b2scjpFSHmvMDm0LEE61BCMP3Q3cffmdcHIk+uKj3VB2AOAJ7rAXDK0vbvq
 5fu2b
X-Gm-Gg: ATEYQzxUhe52nIwwdx5Oegd3yhI0FR5DIaVjfqLZbiWaDgJNDDIUlrN2/vC2VWgH7o0
 XssspvOFyaYVgmTl+uTsAHxLDHaP8uXQFEDeLG2qQrst1jcagUkpAY3NF/4kPJ4a8pp9MwNyk+u
 gfLgVxt9SQJsugwnIcoDDRfygW/jru5LopboEQL4eZ90PrUw7MyIcVo18YzjxJJTn/cp2jMA2uA
 pyp/E6bgy5OnvUaY2nsWqlEo1/R8pweuy8Cw9U6LlfzMcelUuTlgUo/Hl50e+kbGSZRjAjElva+
 fehDjAx6vKN7rVGnIfLwCGLBzA/kEknJ9Irw10IsR+hSERWYZTU1MF6EivY9EUaU94dTayW8HpI
 j4MwbyfWnrpTM6jiJTD+ukcyoQYAYC3JVp98D4T5po1Jr9EUCdQYAsgrYEFosJCW85lXPY4fhn3
 Cj+nVzfGOHfaaXw5/jDyCf5mLM8PoWLc9wuRhQPwiVhFIhIgyOuJqboc89fY/7Inhpw48nDNGpJ
 JgVloZYQQzO0Wvi9UdgBzP47q8Li38=
X-Received: by 2002:a05:600c:a12:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-48526967fd5mr37674005e9.23.1772809211134; 
 Fri, 06 Mar 2026 07:00:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/49] hw/arm/smmuv3-common: Fix incorrect reserved mask for
 SMMU CR0 register
Date: Fri,  6 Mar 2026 14:59:20 +0000
Message-ID: <20260306145939.2162189-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tao Tang <tangtao1634@phytium.com.cn>

The current definition of the SMMU_CR0_RESERVED mask is incorrect.
It mistakenly treats bit 10 (DPT_WALK_EN) as a reserved bit while
treating bit 9 (RES0) as an implemented bit.

According to the SMMU architecture specification, the layout for CR0 is:
| 31:11| RES0           |
| 10   | DPT_WALK_EN    |
| 9    | RES0           |
| 8:6  | VMW            |
| 5    | RES0           |
| 4    | ATSCHK         |
| 3    | CMDQEN         |
| 2    | EVENTQEN       |
| 1    | PRIQEN         |
| 0    | SMMUEN         |

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Message-id: 20260304142344.3341444-2-tangtao1634@phytium.com.cn
Fixes: fae4be38b35 ("hw/arm/smmuv3: Implement MMIO write operations")
Link: https://lists.gnu.org/archive/html/qemu-arm/2025-06/msg00088.html
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmuv3-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 67a23fbeaa..2df54ba60f 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -355,7 +355,7 @@ REG32(CR0,                 0x20)
     FIELD(CR0, EVENTQEN,      2, 1)
     FIELD(CR0, CMDQEN,        3, 1)
 
-#define SMMU_CR0_RESERVED 0xFFFFFC20
+#define SMMU_CR0_RESERVED 0xFFFFFA20
 
 REG32(CR0ACK,              0x24)
 REG32(CR1,                 0x28)
-- 
2.43.0


