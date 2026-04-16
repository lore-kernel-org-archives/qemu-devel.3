Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15754F8D77A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTuO-0003Rp-L2; Thu, 16 Apr 2026 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTu1-0003AZ-BF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:43 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTtu-0002Mx-UW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so6008002f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373524; x=1776978324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3+QzwRIxmWw9kXSisKAYHbTtDISxVU5LWF6vZ8RTyg=;
 b=K0qsYkd7G3nJCp00bl4qBjQWQt+4iPHu6uIsw1LStF0UWCi2uV5eml1sv40aIkZPNl
 P7B1eX64G+7Y6K0A6YyoPQSLv/CvbX82H+tDeYW1eEIGXPSqVTX0RHx5Sqj0snBSfjCf
 RlmGYxBbyGSiunWODUB6zhnf/8/42tGKF6s92EEfU8D7MT8K5lIDmKmaLkNN4CRPb02K
 E4/oeR7wIgji0w/gL6/HJ0fImQxt2q3OEgMyhxqSkfeIrRscw3cDvhvmBHpnDuRCSv6t
 7vsGUYr1BeOVZRgvtkIPpR9nt1g8GGQyHdjdGFUxo9pqZyW+8vhtxZVTKn/MFK5M7Vh4
 OLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373524; x=1776978324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a3+QzwRIxmWw9kXSisKAYHbTtDISxVU5LWF6vZ8RTyg=;
 b=o5k6V09u0hdPMNj0hHayy3eYjt0JpfcCEqVFzcvI2uqDmmim7VaVuwTwC0mcua1TFA
 /4ti9T39BIW/Lo3nsNldVFObmLQRyrkJg8XzJ40meWCA4Ei25L8CDDUIb4GLYnH28AVl
 JKBfLNYxdt7i6wxBgu4LSCkGBhTWkH0thE/aiOZNBSsTxIex/I0sZFZV5m0r7RFo5mVz
 FZhqDqW0zj2GAopmz/Dwv9myheDIddoxFliHgfAijNCrkyjD46FgRjEqKRKvpA1OBNhC
 GZhjgojJ+w32O+a6TGCUha9NTIYkLK30Tc8/Jbp87BvaDJ0PllWrsrQesty3Hf9jqbTx
 9htQ==
X-Gm-Message-State: AOJu0YzDoxC3fjB5CDFB+mcGc5CnoZxTE4wavSGXQMulI+/elNk++PXW
 O4I97fIU55gcooNa2E/1esYhqPMVXs2zD37w47B+Y7vhkikLXoyDKMTa+aYq/B3PJkLzv/1FGBB
 b4WKbPzE=
X-Gm-Gg: AeBDievpbNpBo0IiPE11WpYnxEZPNnZlNvMPwVbTQZOxwMTVVqY5I5YJw1ipk/ONEjj
 +g5ZHY7gk0PZWcgh9jP5K/hB3utnJioejxD6hb9aq6R079oaK9UaTDCiZvL68WN7m/NUlrTWSU0
 3Fn62LDaWVdsKKy1BYmI8uiRv8dUPsfK6kT8pBM/VId1IxoI69hSdkPKElGvWtpS4A7+AQIuOyy
 Ac6mOZboLya9g+eERwd1dDwCacv+VoX5hFnWHJq/DvU6/iCMo9/tdLHWf4ykgN4dYHZbsV4/Svv
 yL4kIP1rs5vf4scl5yTFKrmcSfJeLgyK/4BYSDwEg9mNoeHHxhY7CEdEZcTr0qXwuLQ1+RgnDK9
 d1+JlH+BfWoOcQ1gN581XTw6UeILhtya3ArBY+e721tPralE/2bPw/K2acYpUwppriLLnGxDK2Y
 /H3/f7Irk4VD8A1HL5Lvi8i5Rsz+OQQF/cORBhWl7ffJAodm80mb4OYS8sXWoYFgiT1rkhRXBUX
 CSC0cT81Hk=
X-Received: by 2002:a5d:584f:0:b0:43d:7d24:b510 with SMTP id
 ffacd0b85a97d-43fe3e0c921mr122828f8f.22.1776373524507; 
 Thu, 16 Apr 2026 14:05:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d6e9sm16755765f8f.1.2026.04.16.14.05.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 14:05:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/4] target/mips: Remove unnecessary target_ulong uses in
 LD/ST Multiple
Date: Thu, 16 Apr 2026 23:05:06 +0200
Message-ID: <20260416210508.30686-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416210508.30686-1-philmd@linaro.org>
References: <20260416210508.30686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

@do_r31 is a boolean, @base_reglist a size (size_t) and @i an
unsigned index.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 7be2cad89d6..fdc192e9c14 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -228,13 +228,11 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    size_t base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
                 (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 4;
@@ -252,13 +250,11 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    size_t base_reglist = reglist & 0xf;
+    bool do_r31 = !!(reglist & 0x10);
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
                               mem_idx, GETPC());
             addr += 4;
@@ -276,13 +272,11 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    size_t base_reglist = reglist & 0xf;
+    bool do_r31 = !!(reglist & 0x10);
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
                 cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 8;
@@ -300,13 +294,11 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    size_t base_reglist = reglist & 0xf;
+    bool do_r31 = !!(reglist & 0x10);
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
                               mem_idx, GETPC());
             addr += 8;
-- 
2.53.0


