Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C76tfsJL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJr-0006DU-Kz; Fri, 30 Oct 2026 10:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJk-0005vB-Nj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJi-0002CT-DR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so10447865e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793369449; x=1793974249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I5lNQGbQgbiv/UuO9nJqyeQpH+FV5vQi2V0LEmImOoU=;
 b=C76tfsJLNb0pVeCzUrRk5kRWn2s2wyncn6VSzC5v1hExDt2FRYIbY+aPuV3gHThh+1
 tRaQWRheQk4NaGILH7jjC3L1z6MQJr/HjMy0vrye2kl3jhJeypQGBk0ss0FusT8KmhoG
 S2PRj4MCwWcf1ky1y1AFAxVCjL9FZxtxCGKMiK/OqsBeGxqKTCW300XbHP41rFsAKY42
 uZ0f1lX55W0KMrwsrRkTWHbBcqev5LxZoMRBjkY2RQ2o37BOlH/iFPVP7l+5lrTG69em
 fCP1YbsveKCTiFzNDXQsa0mhdWbfs2VsJjuRuhVdvKOVezFAyBTxYI4j2dLnJlR9IfjL
 qv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369449; x=1793974249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I5lNQGbQgbiv/UuO9nJqyeQpH+FV5vQi2V0LEmImOoU=;
 b=ckSfkqrGFz2reh0R/etRC0NDa8oUIwPj5kpNwlpzV12qbHZCrA/xpjQGlTdPvzRIQY
 sCpz0oQ3NtuyF6170eExxewcqGr+cL+SmbdHWCD8Z5U4TBT84bPTAknjJfdJzqGU3F1C
 IXdOP0JDdoVuWW2SHbbqAvSmW7dIz9NurKS1Bp3//nTId/0fL/D6xbkFAHqrzL+mZfB9
 Ha9iN1SfCV9kAMTdqOEG+hrPqtOfuE6RNeDUer9caAzg+lVSdlByNy1mnOPz0b6/Sdsa
 /O9Hn2W+SCjJjS19QfdrHBbxtmARncvxA+9eagTEx+w5i+RIBt/MEKMe/XxOVSFcFRAA
 RUzQ==
X-Gm-Message-State: AFq9FYLFK2JNmD0BJWGWqusc7BhtigIP6h+7AghAucTYUM0pTY+EA1Gw
 ShzbXIPSsHb/Z8eX1XyXS+hzylQQKL9lDdvGSjImTutZLdhAzM4hteNkZ2jDqckEfl8=
X-Gm-Gg: AYBFou0RofY5RTKrYe7vGUuxDtSKUytUX71g6yjGDoPkaUPeNhgJp7lfLUceKxk0QE6
 aojwzva+7YtcKzweFMEjFsg1SIAZ3J5MiB1sXb0bIfKIhZVXorIdMdCFGVVXZzveZhi03q71EB9
 jp98xpyWFrnffyZOGote0DaNSH/FYkjsLAEuS/YGiL5wPlE3+zO38eTr5bKNAXQua+/tnsKNLSw
 lxMHfhbV1BubtbrAQyRQf+wDVWLKxg66ebxI4bPC540lJXWOuoAPIv/ug4++PyOYZE21Gnkdm6n
 v99LDeKZIPZ6x3xOm1qFfWl37dzae2DpcB7U9UV+Hs2/f5MzXrP+8N72AsA5Qvd/l0fkc972tbf
 mN8VzMJ/39ijBlPTqKCV6TWpFuYcqNVEAvvLcjfAp8bZtb0JSicC5gIAKbJ5W+hTVfa15hD+AAp
 Jc+0bRmw5lOk642GRX6FITpqFA9d756T7DkC1YEZAGjOd5mAZ8FX2IvmW1Pk77QzPcoMl4jXMp7
 JFuR4EMfsTE5m8w9s9jLwE0osCrHVPht+SXbGl31dYJRsVEu6G+BjpwXBr1Ssa7QczFK3hTID3K
 erlCx3BJvkLdhk3Meu0fQSnhg7PZHOd4d0t01cWVfBIOswtJFQ==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4ac17a3628emr53720765e9.14.1793369448517; 
 Fri, 30 Oct 2026 07:10:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf0b36853sm57948315e9.0.2026.10.30.07.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:10:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36C1C5F81E;
 Fri, 30 Oct 2026 14:10:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/4] target/arm: hold bql when SEV sets the event_register
Date: Fri, 30 Oct 2026 14:10:43 +0000
Message-ID: <20261030141046.2710206-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030141046.2710206-1-alex.bennee@linaro.org>
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Message-ID: <20261029161310.2065290-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


