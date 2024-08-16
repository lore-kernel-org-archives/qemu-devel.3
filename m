Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6FAC531DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serJ6-0007JC-JW; Fri, 16 Aug 2024 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ4-0007As-DE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ2-00041w-MK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-201ee6b084bso14391565ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723793007; x=1724397807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5QfoW0VwajlTQd3ELmUEuobbsHpYmua9JmMsJd9x1U=;
 b=Z/C/VAkUf2viV0Qm/2cl9oG1IIAvZ+SzDH8h30gzrtbAxKfouDHjg5D0P5JxQiLdmT
 qmCOm8+kGKH1tNCceFPu4IqfA42rg//RISQbcrH+KWiNqqlItnhSifOvv1dNCDAY61/Q
 pT5VsXk+NONFuOH069uYYi8NHn4Y/ChHdA2sgoP6pbiDLrZACKDeDNYTd/mDPTCkqU47
 IpiVJRZenxqQIgA6xPmbLh3i75Tn91heT8ghpFCKaiOvHpHr9E0wy0NYiBJfEjwxBUeH
 luTuHkpXkCPPYs2EAdUt7urgAbZMbCrBF0LKDzBvTijeBrFV1a5ddG4YAPvtZcLJvWeW
 72Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793007; x=1724397807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5QfoW0VwajlTQd3ELmUEuobbsHpYmua9JmMsJd9x1U=;
 b=lTDXEfPw3aI/gDFPZicdeoFCKppyFPowa7nIh9QWn323q/80WtPtAAt3UAkdqpkRMo
 PwXn04djV2ZiEGnq2OsY5/Y1+y3bcRAOZluLmh2pD8e8TDCkcI2HqvVstol7QwSZCML6
 PhvCUKr5a7zHan6vx35a6GzjTFXLSytf08qJ3NSe5JtLZxFdSkfrSKUvTlk0fZjObLAv
 kcrk2mt9wqTgcW+rGcTqYAHwmv5RpHbeHtUUiU6kZEb75Opd1wd2Uxkf644T7eBijUdn
 n4+JOks4Rfax2vj3UpefukWJDhTJa1y/Czb2rE2ohJRaCzRmUKp2QOUbEZErotqC5is4
 Zzsg==
X-Gm-Message-State: AOJu0Yz3i0K7r2QTRDP8uXdnI+CKrpM6a/bpB7CcyBeklDQkEYUmR6Q4
 ZoBGADO2p7MOC2vi9Yr5pH+aitApdxJOHLbiKqEdSRS6Hd9HrTiXVf25GUr0bhuu9njmA6HZYXb
 g6SE=
X-Google-Smtp-Source: AGHT+IEgZPh5rDde9XyAFxUbQHSM8JWx02PqbUfs58RohWXSE/JsTLTkDxJB1OVAmiJpq/UliOw8EA==
X-Received: by 2002:a17:903:32c8:b0:1fb:9627:b348 with SMTP id
 d9443c01a7336-20203f53eb2mr25162275ad.58.1723793007072; 
 Fri, 16 Aug 2024 00:23:27 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com
Subject: [PATCH v3 4/6] target/sparc: Add FSR_QNE to tb_flags
Date: Fri, 16 Aug 2024 17:23:09 +1000
Message-ID: <20240816072311.353234-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816072311.353234-1-richard.henderson@linaro.org>
References: <20240816072311.353234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/sparc/cpu.h       |  8 +++++++-
 target/sparc/translate.c | 10 +++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9f2bc44722..f517e5a383 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -744,6 +744,7 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_AM_ENABLED   (1 << 5)
 #define TB_FLAG_SUPER        (1 << 6)
 #define TB_FLAG_HYPER        (1 << 7)
+#define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
@@ -775,7 +776,12 @@ static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
     if (env->psref) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
-#endif
+#ifndef CONFIG_USER_ONLY
+    if (env->fsr_qne) {
+        flags |= TB_FLAG_FSR_QNE;
+    }
+#endif /* !CONFIG_USER_ONLY */
+#endif /* TARGET_SPARC64 */
     *pflags = flags;
 }
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c803e8d1ba..eb0158a11d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -185,6 +185,8 @@ typedef struct DisasContext {
     bool supervisor;
 #ifdef TARGET_SPARC64
     bool hypervisor;
+#else
+    bool fsr_qne;
 #endif
 #endif
 
@@ -5596,13 +5598,15 @@ static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
 #ifndef CONFIG_USER_ONLY
     dc->supervisor = (dc->base.tb->flags & TB_FLAG_SUPER) != 0;
+# ifdef TARGET_SPARC64
+    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
+# else
+    dc->fsr_qne = (dc->base.tb->flags & TB_FLAG_FSR_QNE) != 0;
+# endif
 #endif
 #ifdef TARGET_SPARC64
     dc->fprs_dirty = 0;
     dc->asi = (dc->base.tb->flags >> TB_FLAG_ASI_SHIFT) & 0xff;
-#ifndef CONFIG_USER_ONLY
-    dc->hypervisor = (dc->base.tb->flags & TB_FLAG_HYPER) != 0;
-#endif
 #endif
     /*
      * if we reach a page boundary, we stop generation so that the
-- 
2.43.0


