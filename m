Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8792DCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtN-0003pw-6i; Thu, 15 Oct 2026 14:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtI-0003nh-Qi
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtH-00011y-Bh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so702928f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087758; x=1792692558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GXaCAVRhQ6qa4TyuoFmK6dUSEzqGZ541EgzP7ERSCYk=;
 b=DSNMdh7ySDC2Sy6jQnnYRnqwiabHcJ9Z0vpapwtRM4wImY2u+QYk/3wg9zjlCCZf5b
 YEKSM1KSoRA9LkyW3WS8Qs+JRODsp/rzDutjN659gL6HBjTWjklb6mxtzdt9mFY7DkQs
 +15HwktD6Akwx7yaNR4qltewumPHaMjgYcC/CsNZpfpS9ERISLC0ruj6JavxjclGbMo6
 l6NKc8l3GJxI1HuYDTEcIc0pTQwjjkEDVQBRb98LO/MvtHQlDD5asTWwtPYGiIAos3Gm
 B/sABMo31ZofdNM0tKR2f92rQOEwiodvu+SENz6JGdhTBEn7TH9GhTdbmrbyCMsYytaH
 zPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087758; x=1792692558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GXaCAVRhQ6qa4TyuoFmK6dUSEzqGZ541EgzP7ERSCYk=;
 b=zoKwh0bWa5aOSQXqMve+q38T0qtMaRUJvLyPxdxp9FdTcArFYwmaK8adrp36B+wRlS
 RKx7E4WC3wOcw6/UJT7qCb2CYIfC9qIeEoRajng4TMSk0wZw8yN1hupw0NWlCApHpt/k
 596i64qQC/W852HhV2zuppBiIJ5SEEukjMwRALU/z29eerFFgBLHSvcF5MPjAwlYzTwz
 Xx1u1bcnMY36e3uy9yxfM4UCk2UenpsewgfsjboAOo25c5bTbXPacu+bfBqPCVkjg51y
 a+5D4Nx1AQLgqi/E+EEttS49lAT0ejOdpHjjeL0Xo4ZD3Y72U/1M5H0rUIKhiOEm7r+K
 A0Cw==
X-Gm-Message-State: AFq9FYLGgjZkEVzELaYldRVB8a6Psv2x+s8CqP18FuWjUuXuxFIl9ssS
 Ukx4nsrUh7YLpA6sb1uD7T7rvNaWzlpPdPfsQZzWdtI69uwgSGmP30Wq86YxPu/nezUtzye/zi8
 KTsFFVkc=
X-Gm-Gg: AYBFou10gnD/lsLWcIeWSTjgCh6xs/cTQzt7qDin6HnbE570pCBZkGUcClFXMbCqrcH
 SwSngMFk5cOZQRbLFbiRVUxOZPDxtmgQ/m0nBmqJ6sgOmbRVm7vRua/3iMnqmdCJwKEo2zwxrBP
 KDXf2AH4Dc9f1vSsopz8bXByIv0pgzbV7oyjOZkX4XN7ZkM+14Utu0Tofbm2mSJK3C3HMH6f+Ti
 e2PEnWSE+BpdYWwWbeDNPesAEgqJNLEs5oJo60ZNqGoZ+M75f6tt+hlUexAhDnUe6IAy4vpe4nn
 Llztrnvd9DNl/7mw39P/9ut9mkkCq4AaKLTGWZLAZTcEh6wX3nnf1TG/A1kYwwiK++LCnfvZ1yB
 qF2Z2QTVH4wA0U3H9FFx51HFcD3DQLcvqwn0ei9+0iJN3U7mjPieohAwV1wtSVCH4juVNo9jq+J
 450Krj7q86VcODvjhIm1HuyWNV0PMG9frR/ZTiTSMgdnmKRsmpLuF6exwH7StrDQuwUXNQ5HZXc
 hZSKeyTcX8isAaQMh0GjrSoFR1k3Bo7F5I+Z2WYWH4GL6TYBeNSMzlSu7RtMl3tqtctCPJnSIQs
 In0=
X-Received: by 2002:a5d:5d8a:0:b0:48d:ee3e:24a9 with SMTP id
 ffacd0b85a97d-48dee3e2508mr12115132f8f.19.1792087757741; 
 Thu, 15 Oct 2026 11:09:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] target/arm: Implement SCR_EL3.TID5
Date: Thu, 15 Oct 2026 19:08:55 +0100
Message-ID: <20261015180858.1863407-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261010070952.323466-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 78da51996e8..7ac21108d1c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5669,8 +5669,21 @@ static const ARMCPRegInfo dcpodp_reg[] = {
 static CPAccessResult access_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID5) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID5) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
-- 
2.43.0


