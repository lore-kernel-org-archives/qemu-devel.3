Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E9606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cL2JnN6I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSkv-0005i0-3X; Thu, 29 Oct 2026 12:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSko-0005e6-S0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkk-0000YA-2o
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1923893f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290397; x=1793895197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yNUYKhaF5H3g5eksgQQV46oOh6IBPKeBXaamkf/sgO8=;
 b=cL2JnN6INGgFZnPT9wguGQAz6Udm799y/14NioX05P7QdtpxjEHezhPASTrk15viFh
 qs2tTONGWf2H26Y+HKZRtZ0bAezc97IKM8yMGqKbW2oHh8A5UJA6qxGv2TqYpoOJlukp
 QkdFyESyvlzdjZrqXjoMqV5gLLIK2CjS1eFqKyNEAcDfWvlSeWhEdz2qHbvgQMj/Cn0Q
 YEkhORTdOOfnfQCcRgeeLQwQRg80guNhYkL0lkYAnhjumTXDFGdoOxUUj0QjVPd73gby
 lS248evpa8pqIJ8Dyxi1BXlEiWpo4kafTqOnKLhPAUsgQC++H7ehmGCG2QVQbe9sczAv
 wNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290397; x=1793895197;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yNUYKhaF5H3g5eksgQQV46oOh6IBPKeBXaamkf/sgO8=;
 b=iRLa7ULiu8oczd/SA/xHBOWltgtjc2CdjeT4BQkaBFJ/FapUPQlgQPEkL5qFBiixlT
 pBmj7OUAlcp86jd48TUoWg4TfEZO0Z6y9aJNDXd1HsQWASjeLKavBII5vnecnM861e2g
 HWK3m/yZD/8jSiI6OMHo3DKqyxGrX69OqBLTY2uSMVgbSE5/PUAHfq9YoaLLA39r9g1j
 JU0NXRUz7VQ2qt2RnkRKlWEci2ruu301GRNopkYjjC1tki4P3eEUFoDDRDxAaBYCzeQ1
 BwfHI6+f8SwJJbFLWWvEuiJ/umoeXXwpBfom0O4PU7LrNDdsy631bMJdeQrHMB9f6lnF
 kfqA==
X-Gm-Message-State: AFq9FYJZ8xq41WdGA1NVju2XtGWTWL/K4GGItOq2nSBGOKc4gtoOQn9s
 scsWktDIHJsZ+vVs0LxlxGdL34Mb4BvURqJ5ylGhgSPpHaFhtzrbsbzt8Us8HLvLN2M=
X-Gm-Gg: AYBFou3m3lXXLkr7sAph93V+QNitFYtz7poSQE14hp2nvrrrS4P0eOJsr/uAro+EWIn
 nBx09Zn8ezCGqKQH8C3r3g6bhixDO1Mfcw90TYLvnhZkmkehZG/kxAbCdQ0nIyP1WQ7Ked3e7BM
 bVFLXo0CsM+RbTLz2jX/fH4GPKoRET+10znxvPFSVnhFP0QCwOsg0FaSGiAvxnppusTrZwLbJdj
 WcsRNAODyUm2m4HwHxL0GX7WKrLmUk5UZVitVGcCGuCYEax9PZxQXx3sYdzr8UjaPQN03oKS3XW
 7Z9WthHCuubmelEu02vD9Ico3X5qgb0G29hFJmMZGjMWXBmEOCb65uPYNKsd0dWxkeIE2FKrk3v
 lm89ZY/alVmlbaqCzUqiozT/PDWwPH9WOzD7tOqnlP4FYKQix8VAgrGZlJ3j3kET2RHIhDJ6434
 ACZAKcw9ELvAab1CVOGwkiT2P+KiPwjfGhPzxEkaIC7j936xaunzSPktbLnQwMcDM/eKqr+UX+5
 XTdhMDLiML/DXoUkr6KJg8E4ITpthzRAJKH7d8bLnxsw/jmy9Ca7T2ST784jQ+nsshDaipwDqOX
 upc/JfLXQ0uAvXAGh8Ordac4vhx7QHwuYLmzhu7bu2IGM4aJ5g==
X-Received: by 2002:a05:6000:4919:b0:48d:ff71:dd97 with SMTP id
 ffacd0b85a97d-48e5d319cc9mr13311602f8f.7.1793290397181; 
 Thu, 29 Oct 2026 09:13:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfad2f7sm70600f8f.43.2026.10.29.09.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:13:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A438A5FA91;
 Thu, 29 Oct 2026 16:13:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/8] target/arm: simplify wfxt_timer_cb to only trigger
 cpu_interrupt
Date: Thu, 29 Oct 2026 16:13:07 +0000
Message-ID: <20261029161310.2065290-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029161310.2065290-1-alex.bennee@linaro.org>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HALT_WFE will always be cleared when leaving halt via
arm_cpu_leaving_halt so we don't need to worry about atomic games in
the asynchronous timer callback. Furthermore, a WFET timeout or
event-stream expiration is not an event that sets the event register;
doing so causes a subsequent WFE to wake up immediately.

As we only need CPUState to call cpu_interrupt we can also simplify
the user data and avoid needless casting to get to it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 01b223f895a7 ("target/arm: enable WFE sleeping for A-profile")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 510fc9eeb3b..c690e2c8937 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -885,26 +885,12 @@ static void arm_cpu_leaving_halt(CPUState *cs)
 }
 #endif
 
-/*
- * Unlike almost everything else that messes with the halt_reason and
- * event_register details the timer callbacks are not in the vCPU
- * context.
- *
- * To prevent races we atomically consume a HALT_WFE and set the event
- * register. Either way we trigger the an exit event.
- */
 static void arm_wfxt_timer_cb(void *opaque)
 {
-    ARMCPU *cpu = opaque;
-    CPUState *cs = CPU(cpu);
-    CPUARMState *env = &cpu->env;
-
-    if (qatomic_cmpxchg(&env->halt_reason, HALT_WFE, NOT_HALTED)) {
-        qatomic_set(&env->event_register, true);
-    }
+    CPUState *cs = opaque;
 
     /*
-     * We expect the CPU to be halted; this will cause arm_cpu_is_work()
+     * We expect the CPU to be halted; this will cause arm_cpu_has_work()
      * to return true (so we will come out of halt even with no other
      * pending interrupt), and the TCG accelerator's cpu_exec_interrupt()
      * function auto-clears the CPU_INTERRUPT_EXITTB flag for us.
@@ -2302,7 +2288,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      */
     if (tcg_enabled() && arm_feature(env, ARM_FEATURE_V6K)) {
         cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                       arm_wfxt_timer_cb, cpu);
+                                       arm_wfxt_timer_cb, cs);
     }
 #endif
 
-- 
2.47.3


