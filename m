Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB4FFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLVx-00033l-PI; Mon, 27 Apr 2026 08:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO7-0008D7-PF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0005lR-RN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d75312379so7328435f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294110; x=1777898910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cYSIl2V+H9S0t8iglEzTUuxj5zc2Wid6B1AfAuxMEuE=;
 b=B5hpmisNxSdEiJCKDoCPcCxD0MIRVZLcGLERk6DZpiC9ydE/XceE04ZrUAI0bUV/kz
 8u+at+BjhveoYVgAV2ippfPbuqqO/9AlZWglRd7jI15OtuHTCr0HWmAhFGZ3FOXq6aoO
 DmDg0fc2XvhZz0qoh/5pMTuXLRRBYd6i84ISYp0XsffBF7W9Fx0XqW/4AeYY6xCWOwfb
 MkBbz2eplbyHHustImTaHQ2b28x73Xnma0SRZoVsx3nZO1xA6Xk06IP1NfRSMahP+a3p
 ygWQbcGkFSrq1+6o3fVRlGj6uyGIKAipJfWpdHIsPoseM39zriWJ7yn06jA34BcgMow6
 c9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294110; x=1777898910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cYSIl2V+H9S0t8iglEzTUuxj5zc2Wid6B1AfAuxMEuE=;
 b=q4sXIQ87oiYlP/K+ZGK28Iy+qFQKFkpIYixM6LA0n2rrLhyRpsIe91+3aC0FKZG32g
 KFXsRGNW9+hUjS2EKEjKsmMdtCpfn/u0lYDLT11+5Mo0jyvtmFpDk+MrMEdd5w4raag1
 dEn7T6sWlkagu2oTrLu3X3WgCvmdTEi4kVWslau27jaHs8GkDrx2E0ZnwWlOxTNxeRxt
 M+hLZ1MDwx1PZ4lia7K3i8b7zbVnA2zabv9IxFXipH4TKcthMg8JhH3vhjvXJmXhBNzT
 GrXp/zFKnXAk5QBnnt/OiHVFTXcXM9n0qPOCqChbVHJzgiaKBfxvyJ1/EQKs+wfRk0RJ
 0aAg==
X-Gm-Message-State: AOJu0YzS9yYX7r+VTGCQ7J8V632qiS6r32X9onpsGPrA0jLNANz5zvva
 1wm7YE/vRcOytA7D7SKPvMZDMW/K425FY9jUnSvad5E4weMcozBWwL9jhMbgVueGpb9fRify6+B
 50XvV
X-Gm-Gg: AeBDievSybw2t/g0x6w44/zjLEAxX7rQSrBDg7XSlcsAdXl8VhlIskZJUohPLRGYgYy
 sfluGyZQPFtJldl+H4LFUYD+SqRXSRpRP4racXqxuBjDDnDARH51ZWLoOi44fPxdbMRSxLs6kbp
 wOnifK5n+9X4FuDzdSeKhI3e5ouhyB+sLKdguqeA8nvSfXA1RW/qnQ7adKTc4kdhGwbWz7Cv3hK
 ovKuQNiEarda3gfpIr4MtHN3Qq4SCdv24OaeZ9TcCQZFsgva9IFoua7JndGpXp5aitqdkrGUamH
 prBxaLz1M5VoldphpoYsLAKGinLd0H4ZoplbOMP5t1OcSJkRBP2dVd0/vtbrBh6dpb42K0YjzpM
 dfVhAMP57C/wS8rSlKABqOZA6CdFSPfP8TWjWn9I5LVfw8XCnMGpQx1ffM9yHPvKwubEn+x81tf
 zrQ1C3/PxcZTHPdID+UEf1ozdgWZl1AYAHqiE8YF6wr5AC8z18yIX0mSdmgtsYeQp8fKtg/Ramp
 Li4tJjsL4fepM9K6FggxdC4O/hm9u9RCmNqbuN/ALLwx6s59xI/
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-488fb896910mr494899525e9.7.1777294109579; 
 Mon, 27 Apr 2026 05:48:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/63] target/arm: migrate check_hcr_el2_trap to use syndrome
 helper
Date: Mon, 27 Apr 2026 13:47:29 +0100
Message-ID: <20260427124738.966578-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

It shares the same COPROC_ISS encoding as the other CP traps although
not all the fields are used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-16-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h       | 16 ++++++++++++++++
 target/arm/tcg/vfp_helper.c |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 841fd3292b..53137394e2 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -251,6 +251,22 @@ FIELD(COPROC_ISS, OP2, 17, 3)
 FIELD(COPROC_ISS, COND, 20, 4)
 FIELD(COPROC_ISS, CV, 24, 1)
 
+static inline uint32_t syn_cp10_rt_trap(int cv, int cond, int opc1,
+                                        int crn, int rt, int isread)
+{
+    uint32_t res = syn_set_ec(0, EC_FPIDTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
+}
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 45f2eb0930..e692bc568b 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -1359,10 +1359,7 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
         g_assert_not_reached();
     }
 
-    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
-                | ARM_EL_IL
-                | (1 << 24) | (0xe << 20) | (7 << 14)
-                | (reg << 10) | (rt << 5) | 1);
+    syndrome = syn_cp10_rt_trap(1, 0xe, 7, reg, rt, 1);
 
     raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
 }
-- 
2.43.0


