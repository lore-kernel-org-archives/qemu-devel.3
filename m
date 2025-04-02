Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED254C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Gq-0005ss-A5; Wed, 02 Apr 2025 17:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gc-0005Jy-J7
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Ga-0006FU-Vn
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso1294995e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627895; x=1744232695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nb+c/Z4w3wqEwv6YT3XISFL6Vm6o+2eT8WWgkU5k0OE=;
 b=vgJlgC7y5UIVyv/v3B8K0nyOeczFssdSDnrmzZopavcbtKEUr9g81uq2K+qcHs9Cro
 iNQvD5Xc64g9YJt3tPU7JfO+Pl0iCxvfXz5RBR/wnkjtowMtQxs/74kTEL1WUVhImo2+
 FiY/zxeGX8+zoMOgd+QQMGn0FJzebaRgRB6T7HjMWvg7Y8B/9uq+phkSPzCgo/xRZw1A
 POxMwmsuYfZfEuZRPf8n3GUiLRdTpZcuW1SJnz/hg2hEPqJAtyhIU90ZfU0q7rGeocBu
 F1mE2bxQ5uHTNSGrcGqhLzLoJOni/SNR99HIQnvxTVG+xnelTYIOlWQ8SnXhtgxWWqa2
 UYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627895; x=1744232695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nb+c/Z4w3wqEwv6YT3XISFL6Vm6o+2eT8WWgkU5k0OE=;
 b=sMjndvfcB+5Ifb1F3xJO2jbrpl7fcM2IYirYe/Ir7bZ9ZSxRK8sL74eSVDSf/pIzbT
 EihQUhEbQr0LCNv0e5CUYRdZwmqn3YXIOstAFC5glgX0AbIpfvdoBffTFuBntetzvWzQ
 tsCsC5His0LLw9RJIZZ6fzAs868LMeIrcJWNRYEUIOlYSZao6QOGdPf+WR7XVJmRAQsu
 nJBcFcOC6rF6LhxWFzK3Hhx9DTq6VljmhSP7MoMzyx8BDpmVVGvTeGRteYs5L3+ylCgo
 tT2JN2YozqvIa6KhNk2aIxvc1dT/Z/OmWdJ5Kjl5Zp5OrjqGxKScGFWWX3y/UjIzdZwn
 N5vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMVXcD0VKPn2kVqcAeu8USR9ps0G7xyphJREUp+XkuFbFg3ZqlkvRLc300CO+esYkiD1fUIBqIfhuf@nongnu.org
X-Gm-Message-State: AOJu0Yx+XLS0F70v2z2rf4WbZdEsELnAnrZrMwqKUzET8fq25yFp/CZ8
 BuVotDRgEc7ymjmZFE3LtG9k4iezOgPaO0UAzf37UdYeDFsYH5xA595gKoUfOSJXEkiHQmP4MKt
 q
X-Gm-Gg: ASbGnct0wVB116AcTA4gJyf5ILm8H77MRGrQJy4cpud1cxH1J5AWVZCZvav0BRzkTyE
 K64WFzbFmkc/rIJGBrbZTl23YCgyuMmKaE1WOWro1EfbDzoZTxr4BAYmhdc7UPBMALG/PC4XX7o
 +edx8QI4xPRts2eG4Ks0vSDwk1BtfIincfQv/q4H9b3bv9p/z+tc6UdGDY1bT/QWqa5Nc1+btLt
 RJWhenWEBXhqLO7KF28Xp2Yg4W6sNl2KxoOpqvxdU79+64d6XRtjmwwG4eUOo3MdLs2xLWHM7Sh
 bSv8L1xcDZYtQ6kZ1KlhS7875jpWUDIXbYJ/7W+aXdMR9vTiI+m+4Isy2B8ywyifjGHga2MSX92
 8veaWH/hEjzMDvmKpaDE=
X-Google-Smtp-Source: AGHT+IFTBucdF9FOJ2+WL466IfvlNe84U8kh/Pd7fMpb7I8ZuoBxZpQXdNfLoApqzcC8jX2HTttmDg==
X-Received: by 2002:a05:600c:3d0a:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-43ec1532085mr2191695e9.29.1743627895461; 
 Wed, 02 Apr 2025 14:04:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm2099945e9.1.2025.04.02.14.04.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 18/43] target/riscv: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:03:03 +0200
Message-ID: <20250402210328.52897-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Move riscv_cpu_mmu_index() to the TCG-specific file,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c         | 6 ------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c7c5d082ffa..ad534cee51f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1019,11 +1019,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return riscv_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
 #ifndef CONFIG_USER_ONLY
@@ -3047,7 +3042,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 778c4dcd703..5d0429b4d00 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -92,6 +92,11 @@ static const char *cpu_priv_ver_to_str(int priv_ver)
     return priv_spec_str;
 }
 
+static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return riscv_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -139,6 +144,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .translate_code = riscv_translate_code,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
+    .mmu_index = riscv_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
-- 
2.47.1


