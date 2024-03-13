Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69494C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWFM-0002Q4-Mt; Wed, 13 Mar 2024 17:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFJ-0002FR-PO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFH-0007rq-TR
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso231733f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365682; x=1710970482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8X472is1XN7Nm+dILoz/idT0Hrtz/X3rNIf8XYJ+iTQ=;
 b=ftxLuPcoqiHOwjaIRz+nXm/cc7GnJ3LW5N4apU5H+5lyzFyK3BP4t1lXikkODggPzJ
 vkW5KoGIrfo1gOd/vZDiehQukxmZF0z/QfOJxQXlD6LoUnjX5IsOnmg5rFATOExSMAja
 pO9FgmdPNuS+Qyl/rabRkWgiXOlm1J2P9263Q+T2SXQxekzQ81OqBYE58UH782hWBdSF
 I3kGY/dUM0kOtIAgrGPmMWWV/vJHuBiyb4M7o01e/NWgVH7rhC72+7omatG5Z7m5rPd2
 Glx1Gj44hSaZv68pJh5YgbwHA2nHqsPbqSzwGsK+VSOl34wiSysPE5iKL6nuzGLxLnl8
 QDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365682; x=1710970482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X472is1XN7Nm+dILoz/idT0Hrtz/X3rNIf8XYJ+iTQ=;
 b=SDNMkZPGzSdvxQif9NrZbTWByfOqwYQDsWN2HsqKLdjDul0Zz078EF3umsq2obKm51
 bqzTQrSQdXbEI1ihj9LzdMCNmBvPEIJxOKpqNRxEFxhG2qcVLD1kvRNswkBmMrqXmZ4c
 kZUm769QckB4K32I5M/VYVaXI1SXL8IJO2GlfqmvoyYaFEscPgbzY0bDWY19j0YQADqb
 q+I9AMIcvCTbGy0vlmlzrPGfls7HFWSDLgXzcOGq+2s0yDTiF0uQgT7dcCHST3S+9TqG
 mE5yy87PTHLX+omH6Set/ZSeiQCz9TB6jU9nrooxzSqCZJFA9KU6R8l6+XVWJwWw4wEP
 h+Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKquW5yDCGVlKLV0eQW/VMJ2r2rUd8U/qqHBJcO/N+O0nTKuIdJs+9aRV8LOqbvLAvlPZwlQ0T60exLp2HmhNC5M6dw+Q=
X-Gm-Message-State: AOJu0YzJtyCs2QEfP6XUhyGpdL5j+fxBVmqmJxarh89nyDOu5V/5xfhq
 GlVgbtnIf8VU1RoHnwBob5lS0GThc5c0qeeKk0+QsnWhxADkBxAzwL90SAVHAUE=
X-Google-Smtp-Source: AGHT+IFQ+X44STFpsLaI99RVxnAcASp7BBxTUJTZK6/k7vY0xknW8WQ41XVXSu0eVbwc2O4gAu+F1A==
X-Received: by 2002:adf:a296:0:b0:33e:bc7f:edd7 with SMTP id
 s22-20020adfa296000000b0033ebc7fedd7mr2372862wra.7.1710365682559; 
 Wed, 13 Mar 2024 14:34:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 bk1-20020a0560001d8100b0033e95794186sm57071wrb.83.2024.03.13.14.34.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 09/12] accel/tcg/internal: Check for USER_ONLY
 definition instead of SOFTMMU
Date: Wed, 13 Mar 2024 22:33:36 +0100
Message-ID: <20240313213339.82071-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 6 +++---
 accel/tcg/tb-hash.h         | 4 ++--
 accel/tcg/tcg-all.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 4e36cf858e..b22b29c461 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -24,7 +24,7 @@
 #define assert_memory_lock()
 #endif
 
-#if defined(CONFIG_SOFTMMU) && defined(CONFIG_DEBUG_TCG)
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_DEBUG_TCG)
 void assert_no_pages_locked(void);
 #else
 static inline void assert_no_pages_locked(void) { }
@@ -62,12 +62,12 @@ void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_pages(TranslationBlock *);
 #endif
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
                                    unsigned size,
                                    uintptr_t retaddr);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
-#endif /* CONFIG_SOFTMMU */
+#endif /* !CONFIG_USER_ONLY */
 
 TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
                               uint64_t cs_base, uint32_t flags,
diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index a0c61f25cd..45a484ce82 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -25,7 +25,7 @@
 #include "qemu/xxhash.h"
 #include "tb-jmp-cache.h"
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
 
 /* Only the bottom TB_JMP_PAGE_BITS of the jump cache hash bits vary for
    addresses on the same page.  The top bits are the same.  This allows
@@ -58,7 +58,7 @@ static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
     return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
 }
 
-#endif /* CONFIG_SOFTMMU */
+#endif /* CONFIG_USER_ONLY */
 
 static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c6619f5b98..929af1f64c 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -116,7 +116,7 @@ static int tcg_init_machine(MachineState *ms)
     tb_htable_init();
     tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_cpus);
 
-#if defined(CONFIG_SOFTMMU)
+#if !defined(CONFIG_USER_ONLY)
     /*
      * There's no guest base to take into account, so go ahead and
      * initialize the prologue now.
-- 
2.41.0


