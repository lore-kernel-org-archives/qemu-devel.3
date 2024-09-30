Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3906ACF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCR5-0007SQ-Nv; Mon, 30 Sep 2024 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCR2-0007IF-MJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCR0-0004U3-WA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so39516685e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687472; x=1728292272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFaQW0OfcXDNSv5OAJ0dPlLZ03IofsgYwsxu/4pf3Z8=;
 b=lToO5Kfym4rT5yZaBIJvwvtGs8bv0dTLG8Cf3euYrN/JUrjyp1C9xUUs9JpkiK1xUx
 UjCd1iSEW042XY8yJAf7q2jz0iwRjXtOpQSnfd3dEAgOJ8jYbBSqTtZST0woAit80jw2
 7q0dY03kGZ1xoxPuS40CYwyN6RYwDG/ayzQWcpmwV4V67CtVCKH2BxXXf+N4wZfEsdMJ
 3WyiojyZwD2QvZryES1/sClYFlsGrMQZn2bCRJojf+dvWdWsfLK6qr2K5FlSDx4GOFGb
 9AZT8mCxgL9LQCon3v7AsixnEu7qAJA1Aql/sY2ytnhk/pb6fGHfs7/TtCosZlmDMEPR
 lL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687472; x=1728292272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFaQW0OfcXDNSv5OAJ0dPlLZ03IofsgYwsxu/4pf3Z8=;
 b=BxzceaqoAIWTJO4XnDj6Whc95Jlrn8jYacBcUL5SiQj30MwsNNEMe09JnW08wTZ693
 zDCgbXqmKwY8XecQ8iXw6G7BCha9FL0+rFaFTJAn2HE9vYeQPeabeMtt8XuSi9ZXYrwJ
 Z2Q4ehAToUGI7wW/jRXEIpYoRUEiU/8lWEB70u9vhPepm+hwOxVHn5lSuunoPyWVc1Nz
 LZIqY8GL2O/x1uYYerjjpG/zBVvG5nnuQFjN+hKDXeEP2yB5Ww38pGNFsYP6bS7ZyHVu
 kruwhLUD8Aj3gOrV1o15YXmiPC0Lu/F2oIJzusvoz1JwbVOeMcT0gzWukYpebyiBSe+x
 S6Cw==
X-Gm-Message-State: AOJu0YzGI0fVOaWwRp9WHouCYiy2gaaarFOEor+FV/9QkSlUZWg1Oyk/
 8QDAWtAXbRBQOLfLYvMsUzjBea3RE+w318DZ5BAwpRKmFUDMHSk5BpC8r/f9NJc42WiThLamuCA
 Z
X-Google-Smtp-Source: AGHT+IEpq7EAXrM9chFNANAbCwVEd8GTqU43vv2HIljxflw96YCXEYGlw4eQsQGH/gSo3eUCxRcEOg==
X-Received: by 2002:a05:600c:511a:b0:42c:b97a:5f7d with SMTP id
 5b1f17b1804b1-42f5840cfd3mr92606615e9.7.1727687472033; 
 Mon, 30 Sep 2024 02:11:12 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddb85sm144106025e9.2.2024.09.30.02.11.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 01/12] target/mips: Declare cpu_is_bigendian_env() in
 'internal.h'
Date: Mon, 30 Sep 2024 11:10:50 +0200
Message-ID: <20240930091101.40591-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In order to re-use cpu_is_bigendian(), declare it on "internal.h"
after renaming it as cpu_is_bigendian_env().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/internal.h        |  6 ++++++
 target/mips/tcg/ldst_helper.c | 15 +++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index a9a22ea00e..1ce2bbf62d 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -9,6 +9,7 @@
 #define MIPS_INTERNAL_H
 
 #include "exec/memattrs.h"
+#include "exec/memop.h"
 #ifdef CONFIG_TCG
 #include "tcg/tcg-internal.h"
 #endif
@@ -287,6 +288,11 @@ static inline int mips_vp_active(CPUMIPSState *env)
     return 1;
 }
 
+static inline bool cpu_is_bigendian_env(CPUMIPSState *env)
+{
+    return extract32(env->CP0_Config0, CP0C0_BE, 1);
+}
+
 static inline void compute_hflags(CPUMIPSState *env)
 {
     env->hflags &= ~(MIPS_HFLAG_COP1X | MIPS_HFLAG_64 | MIPS_HFLAG_CP0 |
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 97056d00a2..3d5cd2fdfa 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -53,11 +53,6 @@ HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
 
 #endif /* !CONFIG_USER_ONLY */
 
-static inline bool cpu_is_bigendian(CPUMIPSState *env)
-{
-    return extract32(env->CP0_Config0, CP0C0_BE, 1);
-}
-
 static inline target_ulong get_lmask(CPUMIPSState *env,
                                      target_ulong value, unsigned bits)
 {
@@ -65,7 +60,7 @@ static inline target_ulong get_lmask(CPUMIPSState *env,
 
     value &= mask;
 
-    if (!cpu_is_bigendian(env)) {
+    if (!cpu_is_bigendian_env(env)) {
         value ^= mask;
     }
 
@@ -76,7 +71,7 @@ void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = cpu_is_bigendian_env(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
 
@@ -100,7 +95,7 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = cpu_is_bigendian_env(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
@@ -130,7 +125,7 @@ void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = cpu_is_bigendian_env(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
 
@@ -174,7 +169,7 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = cpu_is_bigendian_env(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
-- 
2.45.2


