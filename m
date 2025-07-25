Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27797C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLdh-0001CG-0d; Fri, 25 Jul 2025 12:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLdc-000160-70
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:51:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLda-0000Jx-D2
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:51:15 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b321bd36a41so2135735a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753462273; x=1754067073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2Vhm9qelu6Wjy2FEjpmUyJOP4jkPq9U+ELgdGhyD4Q=;
 b=v095r1ntHlwtLaLY2E6tCHG3idWUD2/0i4tC/mMHZ9AJwkKowYWt/qJFwU9m/VAB/B
 55S3/raY5J/2Z6Cl/vbSSJj+xZiLwk0P4RLrtFDmW8XuLvouud8MDpM5/KS0xH2jdx2j
 jY/Kgdg7DWV1diUm6ZrJQiaHsvQAflhVtEHZMrRv+bQdH9NEq06+WWyKzWz7C+tO5PCV
 0VU45ZM25+qr7NKnmZiq8bfgGn8yMFC0OZvm4PUxSW2QlyAxBs2tw9OsmWMaunq14Asw
 l/7EpQZ7RYwFw3J9TQFmlRuQF2dVsvgSqU9g6AQhC6v4C5jZmRikHRwhIzC+AXxThMVm
 Yzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462273; x=1754067073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2Vhm9qelu6Wjy2FEjpmUyJOP4jkPq9U+ELgdGhyD4Q=;
 b=rRwpuvIhCwL8cflwzUo7VTm/NN3zFGayFmTdJQMAeY2PbtAw7BT7KNxm5cDhcTgqRg
 mhzhpKVIjBjXdW+3VICdh97qhrJPAQZ0rXx6yXXYjErAmwAP46WrfEGK6kdEztBqiHeP
 eut0Z0bZQ8/IV2OmL7RYVJZkWWS+wX6jPMLdsl4/BgwRe0d6hwhJ/GckA3uKGJf9muVg
 v7IvJ+BuXky7t1g/f95SYHS9rqbHjo1Y/+yj3oL05TkgkCT/nAAvrUri4mYWOvwz86f0
 r9SSBo0a5USt2cSVwlREMF4EwdP2qPjWfs8uJHqMrHPSXj1P1IyhnIWvC5LWatWlhWzr
 prIQ==
X-Gm-Message-State: AOJu0YzReG+8aZh+Oi/i2IioYs+5gG8XSIIZtiaGurBPqQkTZOXNmOAf
 lJAGmX6lXVrwJk01DdVxxHJ8lOjT5bQF2eSZRmnrjz1SfbZKw2RV2NokrLyvJUNQS9eyPgw+uze
 hVeOL
X-Gm-Gg: ASbGncuRLbIiZXkISNkLbDCX3V24z7kgwxWq20cv9esF7PAHQ8Aaj0g/Ww7L60p4RqQ
 SLM4gFXYhR3j4wPYRpB8eQ/WPwQowNG6sBm5+9SckEcGb3t6D6VpkBch7GCnDU0dhHhWm96Wi2F
 jHUE8r/5Zbqs/NlSXbqWwzEQ+cEfe/c2s4cLW7XlM9kTqaNnotImPawDlGlLvikOSBjEl3Fl41R
 AxAQBGW4mmlsgZdEOrDdZ02h1LXwGqYriJNhuuJtWj00WEERu4ISzQFZRQs7rRlcyqOkbzfl/+3
 EKAEpsrrJ3bVq76Y0H72gvh42UI4ynJd+UWaBFPmEdVNK3ZheI/p5jEBhIXbkcF5tDBCjvJxikv
 jCSoqTtt4A/dVNdB4KyYUHTixzTSxVsvIFA/d6NAhl8NSr+lSoogbd2wTKj6rbKZlLHzN/H8EW+
 l4xRgwIcH1PQ==
X-Google-Smtp-Source: AGHT+IEbWBzcGIqgXj1xX9G61Qw3JNHoEzH05eRHZrAEJaxikBTs1CUIzBAfwS195WsKyzC5sbghSA==
X-Received: by 2002:a17:90b:17ca:b0:31e:4112:4031 with SMTP id
 98e67ed59e1d1-31e77a4a2a3mr3746177a91.30.1753462272695; 
 Fri, 25 Jul 2025 09:51:12 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635efc3sm3864080a91.22.2025.07.25.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 09:51:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-10.2? 2/2] linux-user/aarch64: Generate ESR signal records
Date: Fri, 25 Jul 2025 06:51:05 -1000
Message-ID: <20250725165106.37105-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725165106.37105-1-richard.henderson@linaro.org>
References: <20250725165106.37105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c |  2 ++
 linux-user/aarch64/signal.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 43a471b535..a290dda30c 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -70,6 +70,8 @@ void cpu_loop(CPUARMState *env)
         case EXCP_DATA_ABORT:
             addr = env->exception.vaddress;
         do_syndrome:
+            /* Let signal delivery see that ESR is live. */
+            env->cp15.esr_el[1] = env->exception.syndrome;
             ec = syn_get_ec(env->exception.syndrome);
             switch (ec) {
             case EC_DATAABORT:
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50cab78d8..ca46734e2d 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -65,6 +65,13 @@ struct target_fpsimd_context {
     uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
 };
 
+#define TARGET_ESR_MAGIC    0x45535201
+
+struct target_esr_context {
+    struct target_aarch64_ctx head;
+    uint64_t esr;
+};
+
 #define TARGET_EXTRA_MAGIC  0x45585401
 
 struct target_extra_context {
@@ -177,6 +184,14 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
     }
 }
 
+static void target_setup_esr_record(struct target_esr_context *ctx,
+                                    CPUARMState *env)
+{
+    __put_user(TARGET_ESR_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(env->cp15.esr_el[1], &ctx->esr);
+}
+
 static void target_setup_extra_record(struct target_extra_context *extra,
                                       uint64_t datap, uint32_t extra_size)
 {
@@ -444,6 +459,9 @@ static int target_restore_sigframe(CPUARMState *env,
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_ESR_MAGIC:
+            break; /* ignore */
+
         case TARGET_SVE_MAGIC:
             if (sve || size < sizeof(struct target_sve_context)) {
                 goto err;
@@ -568,7 +586,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         .total_size = offsetof(struct target_rt_sigframe,
                                uc.tuc_mcontext.__reserved),
     };
-    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0;
+    int fpsimd_ofs, fr_ofs, esr_ofs = 0, sve_ofs = 0, za_ofs = 0;
     int sve_size = 0, za_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -578,6 +596,15 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     fpsimd_ofs = alloc_sigframe_space(sizeof(struct target_fpsimd_context),
                                       &layout);
 
+    /*
+     * In user mode, ESR_EL1 is only set by cpu_loop while queueing the
+     * signal, and it's only valid for the one sync insn.
+     */
+    if (env->cp15.esr_el[1]) {
+        esr_ofs = alloc_sigframe_space(sizeof(struct target_esr_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -631,6 +658,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
+    if (esr_ofs) {
+        target_setup_esr_record((void *)frame + esr_ofs, env);
+        /* Leave ESR_EL1 clear while it's not relevant. */
+        env->cp15.esr_el[1] = 0;
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
-- 
2.43.0


