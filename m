Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4A3C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnDU-0002Bw-ST; Tue, 02 Jul 2024 19:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDN-00024W-1D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDG-0007VI-Vs
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fafc9e07f8so8496015ad.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719964022; x=1720568822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbZQwN4l72NfnRdu4dMv7G4q55sco83AM+p/oHKAQe8=;
 b=r/2WAJJXXosDDjwGFSBIYC00w0Wg2XUsZf01jE8XeS2aHGW7nyCT/3/COwOT7ATcTF
 uYrCMwPo5pWg9Ja5uVkvPjlcHmboBjoTzR8xHDD2+G26xXbVaVRaKQNLasyu8OBtcyvn
 YI1ZW/FeC2QywOuhkkaDrYvL4jmquJMu7iIYqPgptkE4AMPrDX5ctOHhzKbodsYTPsmQ
 PiM6rAr11Qdben/MpbiUv5x5Cys9goBmuYoISJRovsHcrK/ZHhJFj00Ud4gHIpJ55R7l
 qu61GLaAwc+yqV8Ij4BQIZKewBcoNBlT/HAMn8K+J1kF47UCCIOrSjRn2c+oimQMGi8/
 DTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964022; x=1720568822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbZQwN4l72NfnRdu4dMv7G4q55sco83AM+p/oHKAQe8=;
 b=f3zzVh9N8kYYwKWBIJRlq+a6WyMi6Ydn0Lc7eONsj36Eqyv/9YgGAwdZwMIj7DiXbQ
 bUyBzABG3ZIA8m0UULhvjYB7K9cQS5YJqBjqMmR8PwMLQI7UIpOdTnzEfOXdiIPEzJj9
 uDHcXc9bJwPEFIfqyaAVFt4vbTEYakFQJO9BiLhe2QZYsd0FB8YlQ+ErqNkt4+kyJVQ2
 NoajhnP33Z3qo2WvcZMaIXMfaCTRkpgHSqyIOL+YTkIJLYpSr4Hc/8RQjyalE3k0eIG0
 SjPep4FfKqK+arEhu5etk/CIzvWm0ieL0ymGmVvZQAbXqLQ3Z/GPxS32Ik7S5ULTHKMP
 hCdg==
X-Gm-Message-State: AOJu0Yy6Gu4D+1+tKTAwYwSLGFq0NF/IHxR22u5dXvEXFI7Olx8Leult
 h3Scxgt4ZOdm5IkJZU03m3HjSd9Xw8Ne+rMCJr7KECwFDgCFefM/mGLuuJcyZ+hFO45G3Eq8+to
 q
X-Google-Smtp-Source: AGHT+IH7iDiyfS9f9tzqutiYSEBRLOay76fwZVTJjQUJgeuurkHJ13WUvvTI0ZN7W++kzJmVZUSrXA==
X-Received: by 2002:a17:902:f611:b0:1f7:1a31:fae8 with SMTP id
 d9443c01a7336-1fadbc85fc7mr117478325ad.26.1719964022021; 
 Tue, 02 Jul 2024 16:47:02 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535e62sm90147045ad.154.2024.07.02.16.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:47:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	balaton@eik.bme.hu
Subject: [PATCH 1/4] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
Date: Tue,  2 Jul 2024 16:46:56 -0700
Message-Id: <20240702234659.2106870-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702234659.2106870-1-richard.henderson@linaro.org>
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.34.1


