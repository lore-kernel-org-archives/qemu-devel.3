Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FD606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I0UqS7zM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEG-0005WU-Sk; Mon, 02 Nov 2026 08:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDM-0003eY-35
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:44 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDK-0002M2-6Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1548854f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626600; x=1794231400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QZM8G4ZaOXWKd8EWjwtDNazCVa/3U7u3kt9a2OWGQ4s=;
 b=I0UqS7zMFLOlsnKJISdDUL0WBnvyAqnmqjFr0X0IC0NtjFq4w+2gX/D7Gh/R3CBAJZ
 +0pG7RL6tbHpLGxRzmYiKYfYmH72F1kedZZN0+cIbH1AhM6zvNV7F/4AW/dWHNf6z4ho
 1hSzL3pKiETfLYznCxda4siYgf6Sjp5HiRO1cZuPZPGpeP7sWT01DFiBW7C8ee/sghe5
 NRaaRq2OH44yOVrj++RBcpWQG5sUML8EZgBj3/55vqtTbkSjyN2us1sadDobeTroyTJS
 aSFGFH+NsGnFXRoenmz5ABDNJTrHropga1wqIJLNrhI5ogIAk7D/5tj5v4ftbC/pugmb
 G5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626600; x=1794231400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZM8G4ZaOXWKd8EWjwtDNazCVa/3U7u3kt9a2OWGQ4s=;
 b=Plwtp8eDFlHMcoSylnqLepSxz805BOxOKpHv9zi1S2JXaH+nexh8iBFMwwgWLPIVmK
 42UctqHr8aNipE8uDfnVwC80n8ZWUpO2HQ7UIr2UCQ8OU7KGmSWtEDBMJIkHkuNSYVLQ
 QyQNMG0bbzkWcoLTnF3QhKENA61uiA7amLFBeIfp5NXqXdARyIshAg7sg6GXVsF0QZBg
 t+MnJoozmOurXpqzJid+hhCUkIeS6TCcsc2IyLFeoHNaIZoXr2W6hv1b616Ge76CIkm7
 8R1Z1KJtSuhH8tsJ7gGcH1I/1lfU7eHQhzMGmXfAmUieE8BGbRjrrYp1epJ/6QujHprR
 spwA==
X-Gm-Message-State: APuU4Z9lNm+wW7t5atm3pUfBRtSPyT6xPpUPE4Un9ESEYr1FcyZJ0jpv
 jDWq+0luL91nBDoPoULysdiSh4WFiCpSGxhHxsI+C4mOmCnLhC40yNfUTv1IJw71Qqh1u1YvjfW
 2gUxw7M0=
X-Gm-Gg: AYBFou1K1+WiNopdlLZkfMqUHEM5/lBivH+LzPuhhDtEkhtLYsYRwhMxLMVmrPK9YcT
 TwHMTtJWYjlwX9cqEdrFuEouo1u1slPhL69kWbeg2lPHYS39lCNzgQ/1dHnSPdf46ol3UjKh6pm
 oH7/kttPSKXkKb+kU5Y/hOPoEY68XKOeXx1qFM60iPGdHxnCFhGBF5+BaVJr8csFi8ufylLa6Lh
 gwyh8SPbw5F3p8Flg+Jw6qX4CYUwUiCedguvMJ0Pvr/ojJuQbRAW+PROp9ifz15mBkzLYbjXrf3
 jR9OKcxTu0IaNBmIXGqecLRRVBSs178sW2JU/WnNqn0HAq4gUtl9ZoDiZWiNLxuSa07lBdO28Qw
 YHkIcfW7VUFjrVow41ksYuJclnJPQpOuwfEKph0wdtk4fGLIH6aPkGMsb/Cfzrd68kePrvz1PXF
 Dv5jAiQAJI8pGod8hKoPyRJWkl2d71jkB6tz8FNkzkdNVcF8M3NIBOFp2WUwPLlou58pO8vcH/t
 taedLWDy1PQ8V5xWDHeAY8SrLSW+Rfa92pgaqQChjhRqX28mKZhHVVoaeKqSQniVZNt+i16bj3T
 LKO+2hKhNqaoRsb90i3y/XUvfLL30s8ALFSeKlR2unWVR775HZMVvbmIMgxPMjaryqHrwGwHn2g
 RgO4Dj5kzDztQqhqkfi3G83VRPUS1MNN5eA==
X-Received: by 2002:a5d:5d09:0:b0:48e:76ab:7900 with SMTP id
 ffacd0b85a97d-48e76ab7eefmr15316718f8f.17.1793626599642; 
 Mon, 02 Nov 2026 05:36:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/47] target/arm: hold bql when SEV sets the event_register
Date: Mon,  2 Nov 2026 13:35:45 +0000
Message-ID: <20261102133547.1375701-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Bennée <alex.bennee@linaro.org>

There is a race in qemu_process_cpu_events and sleeping on halt_cond
where we can miss the setting of the event_register which would cause
arm_cpu_has_work to report we shouldn't sleep. As by definition the
bql has to be held when we go to sleep against halt_cond guard the
kicking of the cpus by the SEV helper with the BQL to ensure things
are properly serialised.

The other places that set event_register are fine as they are either
in the same vCPU context or are already serialised by the BQL.

Also use qemu_cond_wait_bql like the other halt_cond users.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4660
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4670
Cc: qemu-stable@nongnu.org
Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Lorand Marton <lorandmarton.dev@gmail.com>
Message-id: 20261030141046.2710206-2-alex.bennee@linaro.org
Message-ID: <20261029161310.2065290-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/cpus.c              | 2 +-
 target/arm/tcg/op_helper.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index e11a5aab6a6..985732217fb 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -412,7 +412,7 @@ void qemu_process_cpu_events(CPUState *cpu)
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &bql);
+        qemu_cond_wait_bql(cpu->halt_cond);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 6a673e5ae6e..5788a094123 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -470,7 +470,10 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs = env_cpu(env);
+    CPUState *cs;
+
+    BQL_LOCK_GUARD();
+
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         target_cpu->env.event_register = true;
-- 
2.43.0


