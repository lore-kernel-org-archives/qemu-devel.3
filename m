Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBBA606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JzUT9sgn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0F-0007DY-W0; Mon, 09 Nov 2026 09:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ01-00078u-Fx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:31 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQPzz-00088e-Pv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so8574295e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233126; x=1794837926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7yNu8ef/LhlDmPJ3xfJh3ZEtZik4Tro2+mKWpoGfMeU=;
 b=JzUT9sgnSEEBPPIWEolTCRLmEBf3cv0kxomk7H5MMrbgOIPyuwHX9YBYrCU1rBUYKA
 CcZFQT6My/LmBCKGR+OS2Ap7FdQDHPEkcx9p6ha0F94/re0u1uGhsZU/e5zEg3VUOTz3
 Mlue5VFNrYoK31JDciOKVSXXFvNzzsIkb/jX4vpwJKbfXIPyR5vXnh67tWuyz7Mu36ZS
 XKYTIKEW1u1aTooP7eniRlAXFsRzhxMHfQj1/dHy/JaME/fVlkAbwFOWihuiEoVBXE0V
 srhT2f6qMfehhg0//l7oXahtK6DUxmKIosO7QcmCvj/DEgVljcC98j1n+8qE0GSyxJ0L
 fuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233126; x=1794837926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7yNu8ef/LhlDmPJ3xfJh3ZEtZik4Tro2+mKWpoGfMeU=;
 b=sA9A89d74j8LncDC6vFAE+hWxIAXpEwEM6JVvpDmZ3VObY0e/i/4hPp4VA/tH/4P/A
 KVYK/qi3iKQoySfjFIuet8cA2WmLU/YpddjN/aVuPKwC6R7quNZXtaV5+2fp3EqHcVYG
 qOGODKVEc8NwRaqpzmJm0KvZ9OGvrygU0gsVkcH3/DP+EVapluiWOptROpG6ntK9EaLC
 g7AoCr1Lbd7SYFG62tokaqpMxyJJbCWVmrzHiNZ161yk0kcGVDxxWX9oCokBFzXtRFzI
 /T1/c8s9NLjPutLNqRlpP2ZwSZZYwgEK5r5eTRlNUNjpfor1uPx2Af8hxi7+pHCnr4vj
 5t0A==
X-Gm-Message-State: APuU4Z+hyb83FUvh4r3yHcgkuR/2nuZiskqMDo2GtGrIx4ypHrV9Y/mZ
 AptsRJH2awW3n5HZo7L7mPzH01os3/YslcfjP3+94YXDwSGpfkN6Auqs6V8x/IxgpkzvzKgTpPm
 WS0S+WmI=
X-Gm-Gg: AYBFou3H8HT2E0wcDdhPrVb1B2SnZJfpI9F67vxrVLgm0q7q037LYTm1gfTKm8A/BIL
 8xpAn5Zrp2RoV919AjYdGthr9NWM2N5EwFjUiWeKmiJdp29O+nDeJmH5Lg3VPddfMrS7A6Ne87+
 zBK+YLiupFs7HTrHcXDP532LfgD8JqP4LuV9f+jSjtMOWl84qM7DALfxSqOEGFC66CvezZRo4lF
 lXryYKCyiK5cEjFmzdy2e64XSkozEerA0D8xAyxWBUIzUpyX43vzEdqyAYReKsu6romNN1/AIhb
 VlvGO1K2cQZsZwdrYfh1GPJonQVFHR3c23W4yAX5d2DFByYjyLxsNI6NJ7lIvRrAO3bowO+XKLi
 QMNpB4d9Thaw1yH9jBlg09HiRJa0JtP5pigpqtMYbDdRwYl2YSoSISnkKufq3t3WT9urgStWY+1
 Q5D1uCrjDNJw6wlpgfsqHIizL2iAWt8l/paS7bfnmrekE4H9iHjOiia67R4GalKLKJRWSHW5FAi
 tlZRRjI+ksRCVwdA031hV9qh0uV5J/6AVej539+U3LJWElp3JmsR2S1PrvoSIhkZJDh5wxUpG3I
 AkPQxcd7GuW+3SjUySUO7sQ786SNtqrFDHiLn5DS7m3anMm4n59jbgfSk4RTw4Csa0fjJi5OFxD
 C3GO8QpEhzZMmKWsiWOuTcUjXPcmxQTFbh69CheEQeyKmFHqLlAUgle4=
X-Received: by 2002:a05:600c:3494:b0:4b2:3c81:d1 with SMTP id
 5b1f17b1804b1-4b960d9bbc6mr81259745e9.5.1794233126303; 
 Mon, 09 Nov 2026 06:05:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] target/arm/ptw: check XN for ARMv6 in get_S1prot()
Date: Mon,  9 Nov 2026 14:05:15 +0000
Message-ID: <20261109140523.240161-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The XN bits are supported in all ARMv6 and onward VMSA translation
tables, but we were ignoring them unless the CPU was at least v7.

For the ARM_FEATURE_V6 case, we retrieve the AP and XN bits in
get_phys_addr_v6() but we don't check the XN bit in get_S1prot().
Since you can't validly get to get_S1prot() except via
get_phys_addr_v6() or get_phys_addr_lpae(), we can remove the version
check entirely and need not explicitly check for "v6 or better"..

Change the `else if (arm_feature(env, ARM_FEATURE_V7))` check in
get_S1prot() to plain `else`.

Cc: qemu-stable@nongnu.org
Fixes: d8e052b3876356 ("target-arm: get_phys_addr_lpae: more xn control")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4367
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20261106-armv6-xn-check-v2-1-1291bb77a6c2@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e67d02493b..e36d2ff9383 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1595,7 +1595,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         if (regime_has_2_ranges(mmu_idx) && !is_user) {
             xn = pxn || (user_rw & PAGE_WRITE);
         }
-    } else if (arm_feature(env, ARM_FEATURE_V7)) {
+    } else {
         switch (regime_el(mmu_idx)) {
         case 1:
         case 3:
@@ -1613,8 +1613,6 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         case 2:
             break;
         }
-    } else {
-        xn = wxn = 0;
     }
 
     if (xn || (wxn && (prot_rw & PAGE_WRITE))) {
-- 
2.43.0


