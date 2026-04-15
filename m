Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F01F433CC
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8Dk-0002V4-Mj; Wed, 15 Apr 2026 17:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8Dj-0002TR-CF
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8Dh-0002oM-IP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0046078so71182165e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290182; x=1776894982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChYobPnwj4tKATx8rDrb5+LPUUeRhqbHM1XXErD9y5Q=;
 b=PjHFefcNU0A5xS8WW5DSM5gMSt0Al2KEbo3fch2PhCodCk3H+LJgGPChpLedIMuRSh
 AdhTVENaEPI1pqqi9GvVHromZu0KMiR4wwvQO6ZUeUxgLrHOFGvAaUNVtyG8FjfZHUw5
 CXiVCJ/871g1eHozro8N4vJ0a2cKCWWJ9Y83wprVZ2zYd/Xv376h0/LOFDEoi3tETEsZ
 rToMkC27NchS7tS3psvArg1E69v6P6Npj+XkCwu4abz3u88tOogUzKCLKOz+0EqC4AAV
 7fGRSzJC+U11DhCCCyTtiMiVZ9asiDNi+GSxCTk+hZ6jfcSv/Q8USgiqgrfsLz2Uba28
 W1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290182; x=1776894982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ChYobPnwj4tKATx8rDrb5+LPUUeRhqbHM1XXErD9y5Q=;
 b=SS9KovbxT8yUITGFGfYhazmjBgOoeDEMny+FjOO4abNTsf5oe9urm/MFXn0g9auXhL
 TCKO5XjMuMnTq+lPxW4m649NWpx+FN+wVPHmuC1ciBKzetVgcd/CjIcLjtYtGleZDZ/s
 oTOJyu/yT1v47jCShvxoeWoK/n5OugLPWCMBq3cePf24Ue8xXfdYMBK2U8HDsy01DO65
 /OmWvJSl1aQhHONYodncAsf/PSeicE2xAefgEf24R5J4hU4IiLUjXvnr1b73sQ1pf0Si
 Lto42XkQ5lswekLpLEKAdIp6fcupyKsiAi/OjWGBFMif4N7T8RMWsw5S5AdqV4ZRXriz
 f3vA==
X-Gm-Message-State: AOJu0YxokvJm58EOk2BjPTnD6RwKCwS7kFMJrl4R/oqDLoFVKo7YthV0
 Xt7gFkDwc/8G7YSXPNGwI2WAhYhaGQvEvuD2m76J1LSGgPme6vYYblGC6ikjYd7oNtsJcyq5iMF
 2dVL0jrI=
X-Gm-Gg: AeBDieub7x5PdAjSGsoKDoH+yPt6e1HBKk5mNgCkC0Vk1MhVL8vmaVXSKmcCCEanW9x
 gDYTs0pLEiV2wPGqs8HNeT4VUewjuE/PE4++1JPB5fjZ1wMzJmal5ycb3qU67eJ3YZCkbe2hy+t
 qIYm1trrlsS9hq3lo2eE6JH6Ky7OVjeCuZ812tYVxU6OHPz0O5y9RXt/uRoe/oTJp+TYw7D0p3f
 lir9Ozuq219Mjtehb8oNnBxe/7GnsFWybTRI8f2EYaoZLJ3HSqTohltKMeyPud/d5gq4NJJkbtm
 osqmvM/Ts3pLmyaMPWOvQh0TEUvyXUnEEs1PwgaUopn29n57FAWlTmiGBVELT/irNfoOAQ/ogjm
 GmhbeNUwNTykt4gOnIJn6MApoYp5Gr6+lU4bCjtZDE7/SrNIyI5vRpDbRJByfAUlVavTp8oDx4G
 ChtLddG0yFjsJYoEIX5urJdhttLlsOkSvIkmsaGvzoOClP9iuO1kOWBaOmMKL1qZZ4RBT2udoF
X-Received: by 2002:a05:600c:a415:b0:485:419c:4eba with SMTP id
 5b1f17b1804b1-488d67bf7abmr258106465e9.1.1776290182579; 
 Wed, 15 Apr 2026 14:56:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm8921436f8f.18.2026.04.15.14.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 14:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 6/8] cocci: Do not initialize variable used by CPU_FOREACH
 macro
Date: Wed, 15 Apr 2026 23:55:37 +0200
Message-ID: <20260415215539.92629-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
References: <20260415215539.92629-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

The CPU_FOREACH() macro, defined in "hw/core/cpu.h",
ends up calling QTAILQ_FOREACH_RCU() which always
assigns its iterator variable when entering the loop.
Remove the pointless and possibly misleading assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/internal.h              | 2 +-
 hw/misc/mips_cpc.c                  | 4 ++--
 target/mips/tcg/system/cp0_helper.c | 8 ++++----
 target/mips/tcg/system/tlb_helper.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 28eb28936ba..c6cf69dfb6a 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -279,7 +279,7 @@ static inline int mips_vpe_active(CPUMIPSState *env)
 
 static inline int mips_vp_active(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
+    CPUState *other_cs;
 
     /* Check if the VP disabled other VPs (which means the VP is enabled) */
     if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 924de855ee2..240ccf4d312 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -44,7 +44,7 @@ static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
 
 static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
 {
-    CPUState *cs = first_cpu;
+    CPUState *cs;
 
     CPU_FOREACH(cs) {
         uint64_t i = 1ULL << cs->cpu_index;
@@ -62,7 +62,7 @@ static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
 
 static void cpc_stop_vp(MIPSCPCState *cpc, uint64_t vp_stop)
 {
-    CPUState *cs = first_cpu;
+    CPUState *cs;
 
     CPU_FOREACH(cs) {
         uint64_t i = 1ULL << cs->cpu_index;
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index b69e70d7fcf..99f43ad9e11 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -1559,7 +1559,7 @@ target_ulong helper_emt(void)
 
 target_ulong helper_dvpe(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
+    CPUState *other_cs;
     target_ulong prev = env->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
@@ -1577,7 +1577,7 @@ target_ulong helper_dvpe(CPUMIPSState *env)
 
 target_ulong helper_evpe(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
+    CPUState *other_cs;
     target_ulong prev = env->mvp->CP0_MVPControl;
 
     if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
@@ -1599,7 +1599,7 @@ target_ulong helper_evpe(CPUMIPSState *env)
 /* R6 Multi-threading */
 target_ulong helper_dvp(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
+    CPUState *other_cs;
     target_ulong prev = env->CP0_VPControl;
 
     if (!((env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
@@ -1617,7 +1617,7 @@ target_ulong helper_dvp(CPUMIPSState *env)
 
 target_ulong helper_evp(CPUMIPSState *env)
 {
-    CPUState *other_cs = first_cpu;
+    CPUState *other_cs;
     target_ulong prev = env->CP0_VPControl;
 
     if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 566924b079e..680b4da29fa 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -346,7 +346,7 @@ void helper_ginvt(CPUMIPSState *env, target_ulong arg, uint32_t type)
     uint32_t invMsgVPN2 = arg & (TARGET_PAGE_MASK << 1);
     uint8_t invMsgR = 0;
     uint32_t invMsgMMid = env->CP0_MemoryMapID;
-    CPUState *other_cs = first_cpu;
+    CPUState *other_cs;
 
 #ifdef TARGET_MIPS64
     invMsgR = extract64(arg, 62, 2);
-- 
2.53.0


