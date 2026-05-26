Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9FCCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmw-0001W8-MW; Tue, 26 May 2026 10:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmr-0001IL-46
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmp-0001UI-83
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so4722277f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805778; x=1780410578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4pfkmfO6w1kOno/o5NKaV1qIY+DkeTQ+Jd3ugyh66bk=;
 b=FJDKcPn18DOZEEWqSztAAw/UxwfN+jwnFD2ZqISenldK3uCBPOGs4BXlLxXLzSYZuF
 Qo15WIF57WHEzadAhY+t+Epsnvqvg01SZ5EFgm4QHhVlfYFdBeVBz4Kgeuk08xV5Xh78
 1ZXQ3rkrQ4xr1vsm6XaELwUKZ0KLqAsu7/fxGAk6JYy42jyFcDgQohv/grIg6SNbAoTN
 WXUAm0Z6fyvgSa7BrLFGjkXnHC6S0Fi2UBzLzXaFirbGMAhgR5/aPCCb4Qmy4ExPbQlr
 52NBSrqR30OAq9Euwruv+lnaQhoCF7TliOiLe9N66pxf2GVlV1oNkMQnRPoDRckBdZqO
 f9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805778; x=1780410578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4pfkmfO6w1kOno/o5NKaV1qIY+DkeTQ+Jd3ugyh66bk=;
 b=U4ZqZVSdYfGzL6X6XU2DUlrNYm+bP1kDEOAx8cF3paj1s79GRbpaJ/uwx0Nrl7jFTG
 xrVmIVYJQtn3s5hufJYTfyhcTVshCnVVUaiDXLEBEbIueugdwZKYXwTcsBkz507WAB/M
 y0IEAjuQb62VEf+Ry5mj0IB/wkbDJqAkwXeo70hFvxaPeJwVzTujX621T1iN4p6u60kT
 FV9me1E6HYdLoihKLIe4TIOR234IT3iRsusS+2KNzTzF+wsYj8AWS4DR1zH2EaETZvD9
 vNKdJZdINt8HfG0JjrGZxt5rM2HAdV7oqWUNp9u63AwqC3H0mUTDZo2IKLMxlH1QK0GQ
 4U3g==
X-Gm-Message-State: AOJu0Yy87j35p37fOPfIU43mp0GvCrhdGbY72NeLuWeFmn6jpkdGhEbS
 pMVpclM60qUPJ4srAohK7bZzC4QVDPN2rl3+31yg8pnAJ8Z/l4sSKyOu8IRISF+rbPtKo/3FvJU
 IRbTv
X-Gm-Gg: Acq92OFOaHWEni4LjnmqNvd81q9IQ76Q05v2tzzUHnGwAZXmtE96gbORDbcuCcogGw+
 fMNHLvaR71qhAIsBoto9j8sv0oPXayASKsBgoBJtvhxDnRqearCjBdFXe6IJH82SRJup3wRTAZ9
 7UCay/a+c7NwvITMilntmxN7BlLyIGsdBTMBBUUGvBvttEdFoPTYZqm9I7Dkv+rGXaLvEJ2VLWW
 mFfvy8IRYxxQRfhv603k513Vsbb8y1d+Zptuho8pu3EiW5tRmOiAX7LJJ4SN2/yAlx3bpig4jUY
 7yA8rTgE3gtD9fEgxapnPFmbHhVfSxZhbrocUesqmu6bvEQPE/QlOMG/0RK58A6x42OkFQ7G2zp
 EF1arz1JRYaBYhZiFVzRELEEQRr3/Ppb+xs5q9qIEFlTQj3hXitEfQcAre1+3u46sVKgArc8zMY
 xLnZPUB/okNJ7SWvPq/QwjlB5mazxizOGKSmb1wXWKA0Pr8jZ80jwvjg9y4CkFEvva5WgaMzRA+
 8LQhZui8CcqLwEVudpKP4bEcrEi1GY=
X-Received: by 2002:a05:6000:4704:b0:43d:300b:2285 with SMTP id
 ffacd0b85a97d-45eb3690494mr32812115f8f.11.1779805777811; 
 Tue, 26 May 2026 07:29:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/54] linux-user/aarch64: Implement FPMR signal frames
Date: Tue, 26 May 2026 15:28:43 +0100
Message-ID: <20260526142850.2326589-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-17-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f7edfa249e..899fce7643 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -73,6 +73,13 @@ struct target_esr_context {
     uint64_t esr;
 };
 
+#define TARGET_FPMR_MAGIC   0x46504d52
+
+struct target_fpmr_context {
+    struct target_aarch64_ctx head;
+    uint64_t fpmr;
+};
+
 #define TARGET_EXTRA_MAGIC  0x45585401
 
 struct target_extra_context {
@@ -362,6 +369,14 @@ static bool target_setup_gcs_record(struct target_gcs_context *ctx,
     return true;
 }
 
+static void target_setup_fpmr_record(struct target_fpmr_context *ctx,
+                                     CPUARMState *env)
+{
+    __put_user(TARGET_FPMR_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(env->vfp.fpmr, &ctx->fpmr);
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -518,6 +533,12 @@ static void target_restore_tpidr2_record(CPUARMState *env,
     __get_user(env->cp15.tpidr2_el0, &tpidr2->tpidr2);
 }
 
+static void target_restore_fpmr_record(CPUARMState *env,
+                                       struct target_fpmr_context *fpmr)
+{
+    __get_user(env->vfp.fpmr, &fpmr->fpmr);
+}
+
 static bool target_restore_zt_record(CPUARMState *env,
                                      struct target_zt_context *zt, int size,
                                      int svcr)
@@ -610,6 +631,7 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_tpidr2_context *tpidr2 = NULL;
     struct target_zt_context *zt = NULL;
     struct target_gcs_context *gcs = NULL;
+    struct target_fpmr_context *fpmr = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     bool rebuild_hflags = false;
@@ -691,6 +713,15 @@ static int target_restore_sigframe(CPUARMState *env,
             gcs = (struct target_gcs_context *)ctx;
             break;
 
+        case TARGET_FPMR_MAGIC:
+            if (fpmr
+                || size != sizeof(struct target_fpmr_context)
+                || !cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+                goto err;
+            }
+            fpmr = (struct target_fpmr_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -735,6 +766,9 @@ static int target_restore_sigframe(CPUARMState *env,
     if (tpidr2) {
         target_restore_tpidr2_record(env, tpidr2);
     }
+    if (fpmr) {
+        target_restore_fpmr_record(env, fpmr);
+    }
     /*
      * NB that we must restore ZT after ZA so the check that there's
      * no ZT record if SVCR.ZA is 0 gets the right value of SVCR.
@@ -817,7 +851,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0, fpmr_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -841,6 +875,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                        &layout);
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        fpmr_ofs = alloc_sigframe_space(sizeof(struct target_fpmr_context),
+                                        &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -917,6 +956,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         !target_setup_gcs_record((void *)frame + gcs_ofs, env, return_addr)) {
         goto give_sigsegv;
     }
+    if (fpmr_ofs) {
+        target_setup_fpmr_record((void *)frame + fpmr_ofs, env);
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
-- 
2.43.0


