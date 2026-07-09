Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B0CC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlPM-0001Nu-TE; Thu, 09 Jul 2026 05:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whlPK-0001Ne-Eb
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:51:02 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whlPI-0000Yn-Nr
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:51:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so9641315e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783590658; x=1784195458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fftu9YTeWRktJwqkL+gul7AqzfbpXEjTPuVqzY9QqbE=;
 b=wKG4doJHTMLQ1rjF+GmIee3dLnMW58A/aLKv3E9CfludHuvJo03SNR+vINkJfImMuy
 EH0YjEe/DuvpFjvasr2Gvs7vUnyFV3cLwzuifPu7isi9iLnzq1spUVZJwNU6da5hZxe9
 4Vc3F1YbTz+wHzeWfXgrEtaDAIuCfnkxVucSn/yFwkTWACTXxCnDHNA0L8TouZjDhq0n
 Z6lgNs81+wh+C25GCfiVz4h6ejk2OEmkq7wLpKTv0pM+Juh8wXVntBA3Dwv5n7J0wGuV
 RqFZV1McMiyQnvxurmeB4uL/YySD1b1OERkzD/TTan2u0Iast/u9/6mSTNDYn+fbXwik
 6lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783590658; x=1784195458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fftu9YTeWRktJwqkL+gul7AqzfbpXEjTPuVqzY9QqbE=;
 b=kiBpz+paEM37UDx9xWp2lA1Iggk0t0PdPLFGGihmlcVq/RhkSgDiYJrTkIl2Oso81r
 nPAst4a7jCFvG6MWyJiwUm9AVTDgSASUq2Ss2f8Zi6gkNPpNplnc8Q0HQYGQzv1oYlZV
 w3cUx75A/itHW5wOLuzyqzgjbjC/hLnRODukT1O50EdU3i5qSHx8j3FmCQFxUfJ/rwX5
 JYGw8iW2+rPgAhCOMdwjkKEGNnStdokfwEalP5bNYJPStUC/1eQqXKJnZMYGg66vHHQX
 UgqIfMnb0cOiHgJ7eMdyFR7w9EXpN9x0xLy/bFYdz9djpgmXkX3DuFPkgsq8gvDcmu46
 vG5g==
X-Gm-Message-State: AOJu0YzoU9b+siVdZFWHwH2l/numttCtbNbCGk3ym5c/gAUKtBY9cISx
 8wmrF/3lYbjN3BBCMUO7NZeV3dr/RWOVaO94QmSWEDH3rYagOp/3ncUktQPdlWQgyYZdqJ9omoG
 RPvHba6nI0g==
X-Gm-Gg: AfdE7clcAPCG5WGtHUWI/Zc4vUUaPj/QHLPSBqw8373aaq+nb5KB46iPqWW4dALB162
 GIqFslroxNgryHRsr71yXBorMQaVtLVaPYqWC9KQLcUh+bOk+H5NeBo8lxTVJteL9WupYXqKR0L
 /CMw2VvcLcIqEWB/otN/ey7H5Tqk1nGdauoCyWzj0XCN6P3L6jYrcWNJ978viFMe3mIj1kXcMNK
 7Mc7U6PGUQERIgQnMLOz/3/r8zQveVszHNxawrqAonv2j9e/Z4ilswtm/wqtSFA67TirqjyH5us
 u3/rj7SfZqolxFFS7gvoqn1QnjIrwMtpM1y3ubVJU+I6n8ChIRvvERwYRVhAAaZoBbPONyFkZ26
 wjiphHEkNuRXWMnjtcQSQzkBzw7KykFDwgKvlvR3rfGFI6mXs7GN0ArwKZDS39yfPEees+x74Dk
 5KHOaWy3KOG1h6J7WWUOLRwqpGxKaju4sC81MT1EzoRs1xAgYzkU4ExQoqzsTB0V4AGCjVXdQ5q
 tElAiqZSE3zKAvOjitoXw==
X-Received: by 2002:a05:600c:1554:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-493e6859938mr63798165e9.4.1783590657863; 
 Thu, 09 Jul 2026 02:50:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm54491245e9.14.2026.07.09.02.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 02:50:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH] target/ppc: Remove unused helper_lscbx()
Date: Thu,  9 Jul 2026 10:50:56 +0100
Message-ID: <20260709095056.1803725-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The helper_lscbx() function isn't called anywhere.  It used to be
used by the PPC 601 CPU support; we removed that in commit 005b69fdcc
in 2022 but missed this helper function.

Fixes: 005b69fdcc ("target/ppc: Remove PowerPC 601 CPUs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This came to my attention because Coverity reported a
"shifts into sign bit" issue in the function: CID 1663681
---
 target/ppc/helper.h     |  1 -
 target/ppc/mem_helper.c | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e99c8c824b..6b2d19a3ad 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
 #endif
 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
 
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 119dc1df23..787ba2cdec 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -367,34 +367,6 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
 #endif
 }
 
-/* XXX: to be tested */
-target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
-                          uint32_t ra, uint32_t rb)
-{
-    int i, c, d;
-
-    d = 24;
-    for (i = 0; i < xer_bc; i++) {
-        c = cpu_ldub_data_ra(env, addr, GETPC());
-        addr = addr_add(env, addr, 1);
-        /* ra (if not 0) and rb are never modified */
-        if (likely(reg != rb && (ra == 0 || reg != ra))) {
-            env->gpr[reg] = (env->gpr[reg] & ~(0xFF << d)) | (c << d);
-        }
-        if (unlikely(c == xer_cmp)) {
-            break;
-        }
-        if (likely(d != 0)) {
-            d -= 8;
-        } else {
-            d = 24;
-            reg++;
-            reg = reg & 0x1F;
-        }
-    }
-    return i;
-}
-
 /*****************************************************************************/
 /* Altivec extension helpers */
 #if HOST_BIG_ENDIAN
-- 
2.43.0


