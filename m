Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D551AC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmS3-00019i-4P; Fri, 02 Feb 2024 00:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS1-00019N-Rr
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:57 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS0-0001e5-Dd
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:57 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1404574a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853055; x=1707457855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw2P2PO5VlSnBjLMn3wVhUzylUVudEj93tNb1F3kdv4=;
 b=pX4WnSb6Uv0oECWgI4HaxBazN6LiMv9a1dufowbwDmp2NJJwhraUeBooeWpmVb+kAy
 p0Cq5WBoNQCKhSEHehxDgEmubMBbxLZq4l/U+po3W4+KNvg70YFIDxdd5yjcJciN+KP8
 1c5KcBqi5ttie4rF57K+8c+c1MjcLlH2XZFUza/YSI7N//G9xh3+0GUsRGONjRHdzY6I
 GUTqQovrzAMFCfvfyFhrgBvW3v00XvYZkJOCL5sW9RYpPMlOqfm8O9ZjmYYuq6ASCYw1
 D89Nuo+NJNTcl7ruoH6q1p0rn4e6qYLQnUnz8sAyqv7pfXHQPOQaDD+p3zADxNXAIXKz
 6dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853055; x=1707457855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yw2P2PO5VlSnBjLMn3wVhUzylUVudEj93tNb1F3kdv4=;
 b=c03chpBQT+5wZeC99p+vs82o5pqcXxAznPuNuDG83XQF1FYQnzvfp5fCZWXUWiSG3y
 D0r0+mImxhuRNfoe/he4u8kdglNZnkuhQIz3ODiDD03wkv4dukWOIszcmjzGwykpxoyI
 FxYE3JG2bysxBaQyusMul/7cC+uESBYYtqTmc4H5DUqB2+C1ph1JLJOrEhD2XWbq7Cxe
 m+7zFtxrMWgByi6zxTTYPc1KBpzYp/zEsqhfFZePWxXoxcgKlpfFpzk9BsDIyvjdDiX4
 kdFuDkTn4gZ2vDcwMB8ojzdwdFgbpSdegOYFOAew0q/+6yltPLhHzH3VFgMuCIcurox6
 PbLw==
X-Gm-Message-State: AOJu0YzIRIgs6V7f37ZBGDBReosNGxcSNjI1I8K9lkmCPPE5OxLGfBVE
 9OoR0rzaJ4d98R9/2y6ShRUbiL4IH7PYrU6o0aojJNC+iXgucQ/R/Gi4LCaS3I15bbX40c8Bb8h
 WdB0=
X-Google-Smtp-Source: AGHT+IEmi7bqO5BtyUgH0b09kOqLL5QNdC3uwyMB8SjraD1jYMWz/A7KqVPZ5qWyTSJsbZImYC3SJQ==
X-Received: by 2002:a05:6a20:dda2:b0:19c:9af5:a472 with SMTP id
 kw34-20020a056a20dda200b0019c9af5a472mr4862414pzb.62.1706853055179; 
 Thu, 01 Feb 2024 21:50:55 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/57] target/avr: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:45 +1000
Message-Id: <20240202055036.684176-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h | 4 +---
 target/avr/cpu.c | 6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7d5dd42575..4595c6bb18 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -184,9 +184,7 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
     env->features |= (1U << feature);
 }
 
-#define cpu_mmu_index avr_cpu_mmu_index
-
-static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUAVRState *env, bool ifetch)
 {
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 1c68748b24..a40f445af2 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -50,6 +50,11 @@ static bool avr_cpu_has_work(CPUState *cs)
             && cpu_interrupts_enabled(env);
 }
 
+static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
 static void avr_cpu_synchronize_from_tb(CPUState *cs,
                                         const TranslationBlock *tb)
 {
@@ -236,6 +241,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = avr_cpu_class_by_name;
 
     cc->has_work = avr_cpu_has_work;
+    cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->get_pc = avr_cpu_get_pc;
-- 
2.34.1


