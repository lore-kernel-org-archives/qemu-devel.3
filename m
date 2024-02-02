Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619C1C48292
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSA-0001C9-OT; Fri, 02 Feb 2024 00:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS8-0001Bs-QM
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:04 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmS7-0001gP-2j
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:04 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ddcfda697cso1373119b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853062; x=1707457862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nvj1miDV4d0e4aC2ZaNqUMG+jiO2D2TtjbXo5NKm+xI=;
 b=udJ5MTjalup/znrV01+HT2HHuBlifRHAAwQcOvkdb9QPs3pX/W5v/zVmQfae1J18Uc
 hGUTDcanSfHFsEgXv/XwB52NAMNqHa1qIo58bn0sRx07W4G6wC3UYrfYCPQJDlahQCxE
 XNLdJ0dIn9rt+4Lx77AfVylGqbDfFsI3tjN/riXEvZOr6VdrrRl62JvD1uXtY/xZj0cM
 iKARpTvgm8r0gghHnaXWJhB9oeeh5VIl4NUQLGkFEtPBwJ9V4sKkJeEHpUJPlDaDlhVF
 msolhVhh7GWRfNzXrXmEJstq3UOZvj/VvVNtysRnaXoIuY0las7Pa+d056qfFAx90D+h
 TVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853062; x=1707457862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nvj1miDV4d0e4aC2ZaNqUMG+jiO2D2TtjbXo5NKm+xI=;
 b=afzdqYFJzZ2XnC5yjQC8CD/FNQsXFtQWP7yPR5M2JU23kv9lm03bVds2Qc37PsKDZO
 M/GsQFK1im5MmGVYtfAqlJHJQawdoujPO2pJTZYMj6kjsSEt0pqR51xNvzNJjibGh27Y
 6NV7oEGL5DRWMCetDnPLbaNqGekFE6m7Z54N3LUZkJ2jEVwrpqx4ke4+MyMji1nsYiUM
 sPerdS6w3FB94ByIhvxt4d7cWpvltRR/z1pClBwymgJWYcRWKD7sqYWIHT02JsXYTw+f
 Uqp54Mp8jTueE9EZ5Sj3aWDOoAB004mMhZabOp6IuF6jUFj/lIBr1dyH0mMAUxbe4F/s
 F4Gw==
X-Gm-Message-State: AOJu0Yy1AfLBeTAlbuRO+suxhyjWwn0w3jB0Vux3ImrP2G3QZW7nJErK
 a4FqJycm7eZiaMyd/ajPzPr2cTUcubWb/q6K0GnD5VBWO2nXs8JvlxKdQuXTzf+wrcc2dMMKvMJ
 kWuY=
X-Google-Smtp-Source: AGHT+IFtNLv1eOyVKzCDtTR7jPFM4IA9yXy+AwbWb3RSb89DKVcD3BgQK036qdgX/cKwxAb/NaTTMQ==
X-Received: by 2002:a62:cdca:0:b0:6dd:c61e:2026 with SMTP id
 o193-20020a62cdca000000b006ddc61e2026mr7402503pfg.9.1706853061701; 
 Thu, 01 Feb 2024 21:51:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXRsuNE6gMFdIYwCiZ8pkv8TEZiTHBhzVURFjm7PQHRdv883hJ8FKIjnwq97yrUp2Dvgf7jlPeHnGPq5bfkGSeTEg==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/57] target/hppa: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:48 +1000
Message-Id: <20240202055036.684176-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h |  7 ++-----
 target/hppa/cpu.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6a153405d2..04439f247d 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,16 +281,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
     return hppa_is_pa20(env) ? 0 : PA10_BTLB_FIXED + PA10_BTLB_VARIABLE;
 }
 
+int hppa_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
 #else
-    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
-        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
-    }
-    /* mmu disabled */
-    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
+    return hppa_cpu_mmu_index(env_cpu(env), ifetch);
 #endif
 }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 3c019855b4..fbb37e541e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -94,6 +94,17 @@ static bool hppa_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
+int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUHPPAState *env = cpu_env(cs);
+
+    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
+        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
+    }
+    /* mmu disabled */
+    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
+}
+
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     info->mach = bfd_mach_hppa20;
@@ -194,6 +205,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
+    cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
-- 
2.34.1


