Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F58606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gQgs8zpK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHFP-00078L-MV; Fri, 23 Oct 2026 11:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKHFM-00073A-4o
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:31:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKHFK-0005om-1x
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:31:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so4422935e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792769512; x=1793374312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nq6mGa1U1Jb7hN/w0fwb8Ul5pywvrDXTmWYtbo9ODRY=;
 b=gQgs8zpKFxcAVG9U+HG4XBJF67Yj+ojV+f90IRjJ1Ru/oiJh68Sz4Xk8+Vg2ise6yI
 3sPU9A278fNwkWKMApf2+aFLTxQS6NSD6etwtUIUW7eh0Vhcppn+zfMVgS3VdjnFdhWU
 5cbBrCLaxD4gRDgpLbmgrUUJC+Cbe5rzxeEUyzYR8psU7jC4cM5EX2gUC6hypMa8+1bQ
 FSwMeNuPTizzHGapeMr7G8JHKYPJ+RxYPUyUT7NLHzj9e+f7+0l8WAek2JJIrJNVifKD
 dxABMyysVKd/JBPWAp4O6rbYedHuge6z9IWzabMmo2eFRkjzGgftMiJSXUBMd4yTj7iE
 KkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769512; x=1793374312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nq6mGa1U1Jb7hN/w0fwb8Ul5pywvrDXTmWYtbo9ODRY=;
 b=p4aT5Jb1Cg+UAQ+CoJBMHplMCTYMHh1mM2GiPMTsoWpiS0d8oYDW/s843D1tuF+tf3
 vswLlmz7aCYLm6CeEUkq2OqxU+JGXvos/Ddmw0eoAUqN2MwESJ8gqngqKEwNd8CkVBS/
 TLoXzN/z7tRpnGIDPloCRCX6ntataosbNWv2AsYJmcG3aD+d2sICHgbM8VnfiCvrlElU
 oD+nZbzfLn+ZDQatzXy54YMW0UO1OnMT0/T6eKGfeOyyY0ZqrwjdxYpbVbcZcuODRVti
 XWh7udB6xhzNQH/ZaYRm6AJ982MCk648DXzWtnHbuK1ntC6BmyrUCcJvbNlaPIYFN5GX
 /UEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBycDkDTmVbPivpLoFibEmml36hs9BYSuoRdUrrmqZBdqpEmzNLghG3zYmuL9+89zOwKLWr7Xe8JMjkX@nongnu.org
X-Gm-Message-State: AFq9FYKauauFXuAyBRsGsRCCBTgLV6/FoZFPvdNh10l6uXiE8xpaAQ6v
 nFPgC+Kbs0VCyhMZlCJfXq/oVUorEj84oZdJYby5DTjeSmRLX36e9Aa7sKl5QhGxxyY=
X-Gm-Gg: AYBFou0WhvbFh9Z+CKucKmHMNqKkYnVX7VyxXHyqMBDu4Yy3lpmhn/7ziqO0s2Sqavx
 Oszeq69D67RFy20xeUK8G2u+xujXQrsHvFCI6qiOuym1Ava1jvBOOR4Gg+UvuDOYrJ6RXMmW5E5
 zMW9RkViAbVM/13RFiUpypXRfyZrZHLwKDq4H7l1gM+RgMkn+OX9zQPWujoB42z/Q3V4//yRvhm
 cqQizqrML8NBMNTfM573WTuMRfXeGoBQ4JFHxNZGTErbLbwjTmM0AUVLmLCKMzd82ADDCMOGdxC
 2UTl0RBG3pfqxCkoNMYPgmSn3RgH32Vmx1DKDaK0neKjNGn/ouVd5CrFsCGfdZmkBTY8fW6uRUS
 eRPVznHOEuJfvoL3csSXauxzC1T4krYiCktoPMVUwG8K0z0JgAqFkXEZmQhyfhd9iQ20LT4fpLO
 jiRzaYlMRp3exIpBBV+CE6mK1bZmL8H/oZDrhqkFehkpnGguKbtk3kjWDJnUyafWSHEO5tskHRF
 Lp7FqVzpow5qria0J3FgoX0wD6sfjRPNKOz1E7jjfk0B7+bxtnA1mg34Joltc1WPSgiM3P+Fmrm
 5/YvkRcD2+QEzgCEBMT6+JUx/t8fZEtlWWTJOm8QXcoqZDoykR2CqYrnmTrr
X-Received: by 2002:a05:600c:3b18:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4a211f2bf92mr41367035e9.31.1792769512294; 
 Fri, 23 Oct 2026 08:31:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b062a277sm12920335e9.7.2026.10.23.08.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH] hw/misc/allwinner-h3-dramc: Avoid shift by negative amount
Date: Fri, 23 Oct 2026 16:31:50 +0100
Message-ID: <20261023153150.1710372-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In allwinner_h3_dramc_map_rows(), we take a row_bits count from a
register, and calculate (1 << (row_bits - 3)).  If the guest programs
row_bits to less than 3 then this is undefined behaviour.

Treat overly small row_bits values as "doesn't match actual RAM
size".

Fixes: b71d0385e97e ("hw/arm/allwinner-h3: add SDRAM controller device")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4210
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/allwinner-h3-dramc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 10d929a3039..2a4b33aa182 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -78,7 +78,7 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
         }
     }
 
-    if (s->ram_size == (1 << (row_bits - 3))) {
+    if (row_bits >= 3 && s->ram_size == (1 << (row_bits - 3))) {
         /* When row bits is the expected value, remove the mirror */
         memory_region_set_enabled(&s->row_mirror_alias, false);
         trace_allwinner_h3_dramc_rowmirror_disable();
-- 
2.43.0


