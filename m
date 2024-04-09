Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A88CD1299
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGR-0000YK-Ey; Tue, 09 Apr 2024 15:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGQ-0000Xr-LE
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:14 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGO-0004dI-Uv
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ed054f282aso3541071b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691371; x=1713296171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6xA9uOxQL6GHFyuuAVL91EMcYGjdhkuoxzjyRnEesc=;
 b=zzednVjRbN/2iPwxXCBlLXvi3F8W8UpCZ+BKARDqHNddJie0VaEB3ya2fruYfezvSs
 dgp89U5/nikhR7tNzktwpn5YdcwyQKzVTCgxbgVYFcgpquJ/9klSNdgUJIDC8GBj/UFH
 nSmpO09kRyNZ5rmoTg0Ox+gSiD4DOwb2rKNle0ZkxN4JFWPZB4xIQ+epuAgRDHA7EoI9
 Lk4961TIENhFFbdqDX0WQ39KRMfYstFX959zoNAdk4CSQp6mQtmwWdo29lN9+CjHkWs2
 XE7qiuyruzDBBQpzICbF1VRA4lK/qeSr1cEeiri6CGrF8vSgKIBX6Zux7uSHBc7sMkuS
 ChaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691371; x=1713296171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6xA9uOxQL6GHFyuuAVL91EMcYGjdhkuoxzjyRnEesc=;
 b=fNFq8tnzYD2l6q89vzJVtlZIxw12wjN/J9cug1NSGifAf8HITH69sGh56hCBKJQ3AZ
 x39yFADYbNh7Ou/NjG4vMeyohn1aHDKTCkwzicA3Yy6LH8LyE3jemcIRjVWqPxU2LPEl
 ZHZ18gncp6/uFMDgj+wGdbEqVRYlVAfQgB5KhzI9LYmf+Uwn5kpJUtICvHOtWjokoaBo
 eCKaQKJTzmBzQL1Y4S9efVKjMcLZFwMoQCi/z2wBpfojRLBEZrVII4MBIDlH99rWj9bb
 j4+b3M/9nNKIKdEhjok2BYo5ujKQWitfhwLMclbzJycxKym89LxBtQfIj/LqwPZ8TtPG
 QOyg==
X-Gm-Message-State: AOJu0YzKjTNFudc0kVSZP3i58SaLcOlzFAeZQHjl1plaQCoRNuD6+Eab
 YU/MaQHSpHzaAbXak29aZjikPb+9xIHNTO4e09mUDUddS/UKKL6Ql7s9Yau59m369HlKxOjfxt9
 E
X-Google-Smtp-Source: AGHT+IGOgAZuJwu3FTkXLdD1y+C8iqb+AxJFN52OkAGuSptSQNbeCfLsSMh6w3Ya0ISyeev/631Q5w==
X-Received: by 2002:a05:6a20:5618:b0:1a7:5614:a8a0 with SMTP id
 ir24-20020a056a20561800b001a75614a8a0mr714514pzc.44.1712691371343; 
 Tue, 09 Apr 2024 12:36:11 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL v2 04/20] target/hppa: Fix IIAOQ, IIASQ for pa2.0
Date: Tue,  9 Apr 2024 09:35:47 -1000
Message-Id: <20240409193603.1703216-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The contents of IIAOQ depend on PSW_W.
Follow the text in "Interruption Instruction Address Queues",
pages 2-13 through 2-15.

Tested-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
Reported-by: Sven Schnelle <svens@stackframe.org>
Fixes: b10700d826c ("target/hppa: Update IIAOQ, IIASQ for pa2.0")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 20 +++++++++++---------
 target/hppa/sys_helper.c | 18 +++++++++---------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 90437a92cd..a667ee380d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -107,14 +107,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
     /* step 3 */
     /*
-     * For pa1.x, IIASQ is simply a copy of IASQ.
-     * For pa2.0, IIASQ is the top bits of the virtual address,
-     *            or zero if translation is disabled.
+     * IIASQ is the top bits of the virtual address, or zero if translation
+     * is disabled -- with PSW_W == 0, this will reduce to the space.
      */
-    if (!hppa_is_pa20(env)) {
-        env->cr[CR_IIASQ] = env->iasq_f >> 32;
-        env->cr_back[0] = env->iasq_b >> 32;
-    } else if (old_psw & PSW_C) {
+    if (old_psw & PSW_C) {
         env->cr[CR_IIASQ] =
             hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
         env->cr_back[0] =
@@ -123,8 +119,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
     }
-    env->cr[CR_IIAOQ] = env->iaoq_f;
-    env->cr_back[1] = env->iaoq_b;
+    /* IIAOQ is the full offset for wide mode, or 32 bits for narrow mode. */
+    if (old_psw & PSW_W) {
+        env->cr[CR_IIAOQ] = env->iaoq_f;
+        env->cr_back[1] = env->iaoq_b;
+    } else {
+        env->cr[CR_IIAOQ] = (uint32_t)env->iaoq_f;
+        env->cr_back[1] = (uint32_t)env->iaoq_b;
+    }
 
     if (old_psw & PSW_Q) {
         /* step 5 */
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 208e51c086..22d6c89964 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -78,21 +78,21 @@ target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
 
 void HELPER(rfi)(CPUHPPAState *env)
 {
-    env->iasq_f = (uint64_t)env->cr[CR_IIASQ] << 32;
-    env->iasq_b = (uint64_t)env->cr_back[0] << 32;
-    env->iaoq_f = env->cr[CR_IIAOQ];
-    env->iaoq_b = env->cr_back[1];
+    uint64_t mask;
+
+    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
 
     /*
      * For pa2.0, IIASQ is the top bits of the virtual address.
      * To recreate the space identifier, remove the offset bits.
+     * For pa1.x, the mask reduces to no change to space.
      */
-    if (hppa_is_pa20(env)) {
-        env->iasq_f &= ~env->iaoq_f;
-        env->iasq_b &= ~env->iaoq_b;
-    }
+    mask = gva_offset_mask(env->psw);
 
-    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
+    env->iaoq_f = env->cr[CR_IIAOQ];
+    env->iaoq_b = env->cr_back[1];
+    env->iasq_f = (env->cr[CR_IIASQ] << 32) & ~(env->iaoq_f & mask);
+    env->iasq_b = (env->cr_back[0] << 32) & ~(env->iaoq_b & mask);
 }
 
 static void getshadowregs(CPUHPPAState *env)
-- 
2.34.1


