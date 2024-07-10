Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC03C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0Z-0000xU-UW; Tue, 09 Jul 2024 23:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0Y-0000qf-Ad
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:42 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0E-0003kn-ET
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:41 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7035d5eec5aso2388359a34.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582101; x=1721186901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUYGnB0iFJYfFcduqyWfe3U13R89iRgamOgAr45s1Xw=;
 b=M7VadgY/pD2ao240HXSVry1FsnDhLFG3ztsQYfsCxr57ztMJo0QLS1aVFSyK8/+05D
 x+aJy1tDByGwujjvnsuCejWWHtYIeu18P1LSgBbX+Wf2TkR9v1KL1/cHO3B2D2RDrruM
 LIjhgxzTW8Hd10KpcJ6qytRvW3/UXyqlqn9ZdGE+S47v1r7VVam/+1/V/5YQr7rCWsyv
 sxqkylsJYOTicPqoZGeeKfoUnZKyvG6BCLY7TKi1HGaUabMH96k1SRsWoKoVgsPA8Lfg
 6+nnzmYmnPaCTtxmTk6L0tTC/KQeaCdMmUqip5TXxEbDU9NMn/t5x4m4KYhGn+Q6pJcb
 xK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582101; x=1721186901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUYGnB0iFJYfFcduqyWfe3U13R89iRgamOgAr45s1Xw=;
 b=Ih2gLN4zPGZSJF28azzHMXJ/RSmtW5Oq+fWap1qtXxvcosInsXCJaotPTFMMJoBS39
 VVMcfjyPWWm+8XFXlmaHEQPWkspUaS6JVeJUpsK6ddDITLO+Qg06SY4DZeVcU6v3a5hQ
 j7s5N9uFqgiRFN/aWLksvTuAJCFsM+dVfTTakXK39WJmsEtvwxEKDj2Iwf3Pd0P2QKWK
 xSone9ADrfnTuAtE2Da/Ri8cJxohEm83fWcXr9Sv6wbxm4Eq/huQaxN9+FeN1TAWpMPB
 /dv8FNzoAV8v/d/C1oIKAySMG3OghQNlvTr7Jl3zMgmhSxya2+WLe9ZR0u1f8IerSWNg
 G0oQ==
X-Gm-Message-State: AOJu0YzSOHUjoNLaB4Zdc/MovMk8e1csmBaiiyyjoAJDUim93/608U2t
 qHR0apPELgEuQP8+0iy7QN0g5aCyQaGU1754BjzxZtls0QWqQjjoqPI2f4vsK2as+6rR8VEJWxr
 YdS0=
X-Google-Smtp-Source: AGHT+IEvyOKdZeqqiDs0BX5+vg15SjeR4CDQqg8OZkbSAxkYcotTSRtN91wP6pDRDElAzsSGxy9Gyg==
X-Received: by 2002:a05:6830:19d7:b0:703:65ff:5163 with SMTP id
 46e09a7af769-70375b4057cmr4621107a34.26.1720582101246; 
 Tue, 09 Jul 2024 20:28:21 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 05/13] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
Date: Tue,  9 Jul 2024 20:28:06 -0700
Message-ID: <20240710032814.104643-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Instead of passing a bool and select a value within dcbz_common() let
the callers pass in the right value to avoid this conditional
statement. On PPC dcbz is often used to zero memory and some code uses
it a lot. This change improves the run time of a test case that copies
memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index f88155ad45..361fd72226 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
 }
 
 static void dcbz_common(CPUPPCState *env, target_ulong addr,
-                        uint32_t opcode, bool epid, uintptr_t retaddr)
+                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
 {
     target_ulong mask, dcbz_size = env->dcache_line_size;
     uint32_t i;
     void *haddr;
-    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
 
 #if defined(TARGET_PPC64)
     /* Check for dcbz vs dcbzl on 970 */
@@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, false, GETPC());
+    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());
 }
 
 void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
 {
-    dcbz_common(env, addr, opcode, true, GETPC());
+    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
 }
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
-- 
2.43.0


