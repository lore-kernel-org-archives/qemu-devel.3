Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F6FF60F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VJY-0004fh-BB; Tue, 31 Mar 2026 05:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7VJW-0004er-Hc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:23:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7VJV-0003vO-2Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:23:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so252734f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774948986; x=1775553786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wP+GI1GA2esVBEcdv2LEdQJ+EKOQrpQMHXtB4e3u7TU=;
 b=uuF5tiyJtl6NyKA3FiAhGWMXajshZ9x7EGb1BlnYVoG9/8cJFemM6HC/xdSi7JFmPV
 PAECsZ8rndEoIjT7El1mVj2+Qwy5p7Nmvq+/O9e0wkH0zCDePxzukmY2fJwEs0prTJ+K
 GfHy8sGHw8UOLQhpu0CpsXSC1BWbG0HretAQqxjVdgyuEjmths/sogPTwTFxb1io2cC7
 ThfTgoV/PHT4FWlgd8oXJlsyopOARyJt65orkwKFNCAzeXpuAll3sZVJcK7caeIqEMaV
 hNwbAQGIEfjiaybWRpEO16vujjzZrVVIHbXU5wSSW0ElQBBqncY1hp8aZjNRPslg+qt4
 Rosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774948986; x=1775553786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wP+GI1GA2esVBEcdv2LEdQJ+EKOQrpQMHXtB4e3u7TU=;
 b=Tgaa/uQ4twKeX0k5eLKsqwnPm7DNvrUPOXq/P2KIgH+MG/rtv9KjfsY/pO68bjC8gD
 BnUPN4daY5z+CCzegChjN1Uk40mOLJJudT6TYnejuVCNNDR0A+Glsc4HSfifICDC45Mb
 LpBOg58fvF88cJWPOMMKPqjrkwAVCQvgcIHptkRkSgHATTxftfJT/N/MoXKSC3ztVRIf
 ZSqt6HwND7nF4pSHo/pWtH6wivsW9juBy72GrzK5+4GzUYoXhksj0hkIu8BMf0iNXbA+
 QJkVJpKotz1bYxfGvm+7j4RHlmebb7XSiHrYdHu6VIdlYAHZIvghUHGz69BzGxaPO1oq
 vmuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW985D4iCfVThOxDCGypjZhi8EAq4WICLseov3eO+OmJUIB33Zdhq4OiUKhAMUkwLfU2OxkseoRCSxy@nongnu.org
X-Gm-Message-State: AOJu0YwHPCF4oVLJJb4rMhcuYS/JxYTYeJIwL8Wip9gnfLPt4p788EbY
 Q8e6UL4jThgfyfTqxVFSmhQwdUFgWoTObjf0xzXFdxlhbJERbAJQf5YwB2qxhOhTVW0=
X-Gm-Gg: ATEYQzxR/g6wh58SOuTxbUnwdORRzeIYuWiR+bnaCnczAvntRN4eiO6hobpGgQZrVrL
 H9DsK2CvSVvQPoEjpIXc8peJiWI81t2eUYczYBT6t/MC27lWtViLcwdIY+V8AwV202EnjVjJyWE
 VugMo/wz8CYURZbqIETKooUiXOwvD0sGreaVTeiXi4C6vK2n0zVhbcBOWNenIuiK99sV9oe8fMa
 fb3t7JbnSI5pIoAz+KgXfcLKfYOdx9Eog6zeg+es3ybD3sJtcjnq1ZocFEWLoKQ4xuRKV7GpduW
 nNTRGoOx9MogcVISlz3OAR+m4JIirZdoBeYU6MG3lCdwApWPgpYNY1OWxOWR/WNcPH34zX89bCa
 t3fprAJiBFliCIDSGRYVC2fvLlcHIxCt3ww5EBYuvIq1Qk7qweEj/IW3ubPb7PdPDcOIKtEhj3p
 PtXAaTb7blNqyO5VKjbQAWyq6bMuHGcy80eHdzjvtxLb6yozzbu6vbWUG7dhcJVzIQDTyI9fIwu
 aioqOe12WjUrhV4DWBaEQvdsoT6xOA=
X-Received: by 2002:a5d:64e6:0:b0:439:b858:1d28 with SMTP id
 ffacd0b85a97d-43b9ea9aef9mr25655034f8f.26.1774948986461; 
 Tue, 31 Mar 2026 02:23:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf257b72dsm25928298f8f.34.2026.03.31.02.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 02:23:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: do_ats_write(): avoid assertion when ptw failed
Date: Tue, 31 Mar 2026 10:23:05 +0100
Message-ID: <20260331092305.2062580-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In do_ats_write() we try to assert that the cacheattrs from
get_phys_addr_for_at() are in the form we expect:

    /*
     * ATS operations only do S1 or S1+S2 translations, so we never
     * have to deal with the ARMCacheAttrs format for S2 only.
     */
    assert(!res.cacheattrs.is_s2_format);

However, the GetPhysAddrResult struct documents that its fields are
only valid when the page table walk succeeded.  For a two stage page
table walk which fails during stage two, we will return early from
get_phys_addr_twostage() and depending on the fault type the
res.cacheattrs may have been initialized with the stage 2 cache attr
information in stage 2 format.  In this case we will incorrectly
assert here.

Fix the assertion to not look at the res fields if the lookup failed.

Note for stable backports: the do_ats_write() function is in
target/arm/helper.c in older QEMU versions, but the change to the
assert line is the same.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3328
Fixes: 9f225e607f21 ("target/arm: Postpone interpretation of stage 2 descriptor attribute bits")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not a regression, but it's a very safe fix, so this will probably
get into 11.0.

 target/arm/tcg/cpregs-at.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 0e8f229aa7..53dd67375d 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -37,8 +37,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
      * have to deal with the ARMCacheAttrs format for S2 only.
+     * (Note that res fields are only valid on ptw success.)
      */
-    assert(!res.cacheattrs.is_s2_format);
+    assert(ret || !res.cacheattrs.is_s2_format);
 
     if (ret) {
         /*
-- 
2.43.0


