Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C292C83F0D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDt-00088d-Er; Fri, 04 Jul 2025 12:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDr-00086w-SS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDp-0005yH-Rc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso11807095e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646308; x=1752251108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d/LfvC3NRJWTIueu6Kv0svLLOIPKIUa3RlTtXD3PzRg=;
 b=u5ZVDZln6xgbwH8knvLNpQ8f5v8HPxw1WO1SujB4fjplKSZ9MEck5xSoJZbREvLziD
 gwqS9MRrI98/ZmSBopxxwKf/ATspQNRm6+uHwPdQuIcdIr7/fGKawsIBoFzTTreXA1Jg
 EQduhjWWpNUKNzN6igFR9PvXNRkHsWl3WG4/ewUY70aR0NwhO5fQN7P/CXkXeV1OxP24
 gI5WLvavN6Q6qpCghNcoowcFPwI+LmgXY+DBfI26CC8cVjl5MFguysWWS997KfPyTzv8
 Urpzz4mrjp0sMRXXBrAUcYiS1jTQmesB+2h8sMFYYveHR4ea3LQxLbQ4Gv1zq2qY7Spy
 OwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646308; x=1752251108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/LfvC3NRJWTIueu6Kv0svLLOIPKIUa3RlTtXD3PzRg=;
 b=Xr/JuQTj2RwOtOR8v+wlusNxf43mtwHnKEzcwnWxrUA8iJULW6WQak1miJa1TXqX1V
 O+174Fm6R4G83yavPBTRXJCuE/rXwLB+Y6rKtx1lUPs6UwTQ+4NgFnB1KmqikElOA7Kk
 x4wzlnWE4Ee4boKRdLe9H10g0WTZEt1U1OvPPE92g4BDLloIiZONffMxS62/NiFP0yNk
 fFSFbDpQKDL9ZgQ8HKSpEQnxthQnGq6InH2ruspMYMZMxQHAgxxon/vXiaC24JO1r0yT
 RyV6+R0plObAvnAcsD84e6gbWKQ3qQoWsNUzSxi2Dq3Ez2uFYWK2942/MG208Dqtj+89
 R3/g==
X-Gm-Message-State: AOJu0Ywx/CNT+VlFG+8XndMPWj3WOZ/NWDsk71hTPLK2D/uYfnhlUNLi
 apr+r6kaHdFgTWVaNF7aonH0qIdVUEFQ7ruqDFwNAX7nfIGJ9cq2befRsxzN4ADNUVWdkF63TAX
 mUnoV
X-Gm-Gg: ASbGnctTByiY14Ydx1LP4b2XlJ8/g1t0nt3lVjiWNTfuKJH6Qbdfb/85FAR1UZj8gxw
 /F1dULGcxv89pKvyKmcxdOVQCwrqxSxi44X5ixmwKO9Gsvb6wW2WYxSqOYWfoMohGDSNowarx2d
 z/bTIKjDPDWHu520shZuUiNF//MSzDtUcbGILdeVVnV+jgbGORUudelvCHkckivEJ1lNlrtW+Gr
 xpVMClszY7DpnQfSrm9QYkQ8mz+dakqzvA/29fTfyy/yBoTHhcBFESjEOWay0wJWcmyg2kKb1LG
 CrFGO6BcDPNXNZy2TEKIK1MLhlZVp+43EFlotUDBpC/+4iUt0UjQAlFZ787kCFupfsUr
X-Google-Smtp-Source: AGHT+IHOjKAvkLt/51nVnbJGX61nFsWcEcXrag0hCWPzrdYmw9+SKiH9Kich9iGJajSw8nFpy4+sBg==
X-Received: by 2002:a05:600c:8b52:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-454b30df071mr30296615e9.21.1751646308227; 
 Fri, 04 Jul 2025 09:25:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 005/119] target/arm: Fix VLDR helper load alignment checks
Date: Fri,  4 Jul 2025 17:23:05 +0100
Message-ID: <20250704162501.249138-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the load operations in the VLDR
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-5-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 506d1c34757..8834523c23f 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -148,13 +148,15 @@ static void mve_advance_vpt(CPUARMState *env)
 }
 
 /* For loads, predicated lanes are zeroed instead of keeping their old values */
-#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
+#define DO_VLDR(OP, MFLAG, MSIZE, MTYPE, LDTYPE, ESIZE, TYPE)           \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
     {                                                                   \
         TYPE *d = vd;                                                   \
         uint16_t mask = mve_element_mask(env);                          \
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned b, e;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         /*                                                              \
          * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
          * beats so we don't care if we update part of the dest and     \
@@ -163,7 +165,7 @@ static void mve_advance_vpt(CPUARMState *env)
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (eci_mask & (1 << b)) {                                  \
                 d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
-                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;     \
+                    (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;\
             }                                                           \
             addr += MSIZE;                                              \
         }                                                               \
@@ -185,20 +187,20 @@ static void mve_advance_vpt(CPUARMState *env)
         mve_advance_vpt(env);                                           \
     }
 
-DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
-DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
-DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
+DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
+DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
+DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
 
 DO_VSTR(vstrb, 1, stb, 1, uint8_t)
 DO_VSTR(vstrh, 2, stw, 2, uint16_t)
 DO_VSTR(vstrw, 4, stl, 4, uint32_t)
 
-DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
-DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
-DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
-DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
-DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
-DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
+DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
+DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
+DO_VLDR(vldrb_uh, MO_UB, 1, uint8_t, ldb, 2, uint16_t)
+DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
+DO_VLDR(vldrh_sw, MO_TESW, 2, int16_t, ldw, 4, int32_t)
+DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
 
 DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
 DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-- 
2.43.0


