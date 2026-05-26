Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9282DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtLu-0007Px-9t; Tue, 26 May 2026 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRtLq-0007Oc-1n
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:05:51 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRtLn-0001px-9h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:05:49 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so9002734d50.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807943; x=1780412743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MfOLILJhLCs5uI9y6v3DME2R5kiBOtj3d4TbB1y6Bw=;
 b=SQZ2FlboTAN9YjbR+zADYs/sob+t6tltpWJAjtjWqBtlHwjwjmTr3Fxgo8nW5RxtN+
 wMaWClrxZdJCHThE5FvY7BUBn9977K1RobyGylEtOf+nA6TiCYvGGdF3lxno7bdoyjJf
 qUVZQF8mnPXd9zmU5Ss2T6ASHhJ/WMWqCi3hI6RpKqkZFmkWvzBGqZgXNaCJDogObOF7
 tvu31KQMKc2LNK1uNksFK0OgKxASA4ydBuxXScpesCN1ONeWT5C1NoJAvFfa9dPCwZQO
 48jU49OGxw3bO0JwNe8t5lk45P2nbRx03OQh/IKGKIiPYdjNv2DMhtUEP3k5xhOaomCl
 JYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807943; x=1780412743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3MfOLILJhLCs5uI9y6v3DME2R5kiBOtj3d4TbB1y6Bw=;
 b=Q0Ly3rSZLdMmEXSqcQw+yFOssyODTFOigMAE53K39aXHY7607v4xDXj9onoEwT404G
 qWUl6U1yM1PurtkqMmQbnQw3IYrK5Mcq45sGtprQvzk2CurPb0mHpA1xEh8GE/3GH04V
 DApSBYQAbw3QLCvKa569ruPdioYvDpbPVmFbleRtRSPyc1TNC5ViVBOGfcKQpnLZ6voi
 /NIfIdh1G+Irm8qI48NHMhOVCStV5pvU3jQudtnqBAtO7ozqZ78+mTRnCqCULBqAu1No
 BHdETipF9jjijFxz09n+CL88KA5FbKz80Kdzj4KUAKmCOfn/xgpaabyIWgJKiqHKrywF
 ogNA==
X-Gm-Message-State: AOJu0YzvbC8BePUBEvRBUEaTh1VLHhBmYyxSAtj3ONC16o6o7I3ngBaP
 WfIdzCUPx5cCRRnmD7tJR6fiFT4mLEHKrpv8MQCvh8xcbOKPBetw3wBXFlOLWw==
X-Gm-Gg: Acq92OH8Elq+GVTTCPhy4Iy3DL5oWhWBuSuZBb6bdmu2H2veCy27sP+UethuyloQHJt
 6tPUV9D9EpWQHNhr3IPKTMDkVRP4qSUrCshn8MtGb+I7kbQTaTbm0DzNftvosC/f0rqbZtec+aD
 e+rEplk/RyjeYI05sf/BknKPsvz9xN8j7Y+hhf08ZXaivNU+7gQ2KfqVGDdgR60qYPLTPqq82z1
 zoC4KkCCZfN92lwY+bjGMYWT6anqgMgW8Bpfp1UZ6592xBC34P0p8BJtHRRlGR8PWE9ZXRYB1O8
 LR3CpXSM3W9z8MZCI5np8zTZRcloQvQNbFgLgdV6Khb7j67+HRed5suXgEsLQoEULDo8z5UjOcK
 TNayDmFjmP1il+mp/noDNUtl9E60sjssIhazipixebFxmT+CT019QpDsvIIQpg1uYZZ+Yv72Xi1
 hCgkY8GXn+RbqGN6Gv8kSpLSyb5WD9T85kiG980GB/6XL47T4y2QjEHdPErXN2O/P62NSfOZFsq
 6k=
X-Received: by 2002:a05:690e:1283:b0:65f:f64c:c5f with SMTP id
 956f58d0204a3-65ff64c1eacmr7134120d50.29.1779807942755; 
 Tue, 26 May 2026 08:05:42 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65ecfd5c952sm6186323d50.12.2026.05.26.08.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:05:42 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] linux-user/s390x: restore fpu_status rounding mode from
 FPC on sigreturn
Date: Tue, 26 May 2026 11:05:33 -0400
Message-ID: <20260526150534.170504-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525152210.4119543-1-mattst88@gmail.com>
References: <20260525152210.4119543-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
The rounding mode bits [2:0] of FPC are reflected into the derived
env->fpu_status via set_float_rounding_mode(); every architectural
write to FPC goes through HELPER(sfpc) which keeps the two in sync.

restore_sigregs() restored FPC with a direct assignment:

    __get_user(env->fpc, &sc->fpregs.fpc);

This wrote env->fpc correctly but never updated env->fpu_status, so on
sigreturn the interrupted code resumed with whatever rounding mode the
signal handler last installed in fpu_status.

Factor the two-step "write fpc + sync fpu_status" logic out of
HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
it from restore_sigregs() in place of the direct assignment.

cpu_s390x_load_fpc() partially reuses the sanity check from
HELPER(sfpc): if the FPC value has an invalid rounding mode or reserved
bits set, it falls back to 0, matching the kernel's fpu_lfpc_safe()
behavior where a corrupt signal frame value causes a specification
exception and 0 is used instead.

HELPER(sfpc) now calls cpu_s390x_load_fpc() after its full
specification-exception check, including the FEAT_FLOATING_POINT_EXT
test that is not needed for the signal restore path.

Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a signal")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/s390x/signal.c     |  6 +++++-
 target/s390x/cpu.h            |  1 +
 target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git ./linux-user/s390x/signal.c ./linux-user/s390x/signal.c
index 96d1c8d11c..28ad80bde4 100644
--- ./linux-user/s390x/signal.c
+++ ./linux-user/s390x/signal.c
@@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, target_sigregs *sc)
     for (i = 0; i < 16; i++) {
         __get_user(env->aregs[i], &sc->regs.acrs[i]);
     }
-    __get_user(env->fpc, &sc->fpregs.fpc);
+    {
+        uint32_t fpc;
+        __get_user(fpc, &sc->fpregs.fpc);
+        cpu_s390x_load_fpc(env, fpc);
+    }
     for (i = 0; i < 16; i++) {
         __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
     }
diff --git ./target/s390x/cpu.h ./target/s390x/cpu.h
index 3acbe83f0f..f55b79ef8a 100644
--- ./target/s390x/cpu.h
+++ ./target/s390x/cpu.h
@@ -895,6 +895,7 @@ void s390_init_sigp(void);
 /* helper.c */
 void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
diff --git ./target/s390x/tcg/fpu_helper.c ./target/s390x/tcg/fpu_helper.c
index 6ca0b7162b..107025e675 100644
--- ./target/s390x/tcg/fpu_helper.c
+++ ./target/s390x/tcg/fpu_helper.c
@@ -1087,6 +1087,19 @@ static const int fpc_to_rnd[8] = {
     float_round_to_odd,
 };
 
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc)
+{
+    /*
+     * Mimic kernel fpu_lfpc_safe(): a corrupt signal frame value that would
+     * trigger a specification exception instead results in FPC being set to 0.
+     */
+    if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u) {
+        fpc = 0;
+    }
+    env->fpc = fpc;
+    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
+}
+
 /* set fpc */
 void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
@@ -1094,12 +1107,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
-
-    /* Install everything in the main FPC.  */
-    env->fpc = fpc;
-
-    /* Install the rounding mode in the shadow fpu_status.  */
-    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
+    cpu_s390x_load_fpc(env, fpc);
 }
 
 /* set fpc and signal */
-- 
2.53.0


