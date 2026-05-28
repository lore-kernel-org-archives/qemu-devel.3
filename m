Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B444BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdNq-00075n-G0; Thu, 28 May 2026 12:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNp-00075Q-3z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNn-0000nG-Jf
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so135769825e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779984894; x=1780589694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xergeKXYKTtIyx8bmrRfFwsNBYI+z6i13P5AaQZQ58M=;
 b=Ev0vlXgKpB+7wBqZe43p5JkiR7NVfNOTSnTYQRUrjkGxo+6wey9kkU67Yy7JR0toyD
 2D8fw1SS4/QCtrrstXV7ElTyqcOUa6/nb3LvZwOGK1OcLLTDN5zI7hNhl8S+Jt1AR3ID
 8uj8asgUtXSHEq26F2ZbiO6D0Dcjx35/fteEoSqX3pJTV5fref6/8kpnO0c2HMVR0MMZ
 ARUKYXgOegy2/t0ZB5Tg++my4Xp+ViA8XzgvWVgEiqBrNbMDTKooUxKxOeKyZCPIcS21
 9dzDHuK1CFmUGGYoJLGw+UBz83EobIVTnqUGpYeNg0GVrHvLMjCoU4+uHFl2TL4cHB+7
 nISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984894; x=1780589694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xergeKXYKTtIyx8bmrRfFwsNBYI+z6i13P5AaQZQ58M=;
 b=UUJUL02I2bxWwZGhtMi/Dkpo0Hf4kT9jU033n6IN7/H5oKKfqVrod7eCvte8T2OBhS
 O2Kkqd5Mev8l40YSGbAe1vm7rVsno2nvUelI8daZmsQzNMkiPElR3lMwHrE+S+Yt84O6
 wQTWSQ9j2rqFzAZAemyOUl885/BBj5dCW0JcJqw9xY7XDdT5kg8468zVJq595PPnyE5a
 uZBZnRZa2wZu48/3XyraOXaNquVZNrAT163O8wKk2R4dwFDEBXAQkc5icgbbPV7hOYnz
 lneTOCFU6MQF+pMeCJx2R5/OywC7GPvHJnid/OdJhC2Yqq+Dp663T8++Il+EeUbJm13i
 EorA==
X-Gm-Message-State: AOJu0YzIQYMhZ630BJjcLTpq8WURX6XhDt6h561PPM/VsW3W9AdDboBR
 iotLaLGvhTFWLH/fAF5xYUH7yOkHlm9qpQfxhmbXE5k+vnc3uiRGOXdOPaifqzgkVJdO0n5ytpu
 V9FEk
X-Gm-Gg: Acq92OEzT7cYZ+Z1PRWqbxesF82GccymP9z1GfWyBZmY+C3tgyMae32iWpUUepfUYoT
 hqlt6X4KKjkCYO2cD6/5ehDfdwOqmjHk/1Sh14j2Tl+9XOlGill4SSI1Qyn5uYpE31UA3key3en
 CKBXj0Mwu0V8XaLdzL8liftWBnQvxJlN8sWwCJenk+B05Gr2lHN33PRFS9l0f0c/1D+eAyKOYnJ
 tpWAvNYE5zXkVOdnJKVaQMHHaQShO8w5Ct4xPsy4KpwHOXGhfLkt5KmDlvhUNcuo3qiC2EmNebP
 /x+OYvJhHcT0oWc0RxEei7kGf25ifM6DR97SSA6CmN0gH6OsY0rsEMiGn/khzzB88tMBZn55cij
 l5gyzto2euar5wMRAeMwHMw7Lijntz8pgErzIt6UGMLgnvnUVvReB92f28gxoUUS6/H2ckhu8HV
 LdJ16ri88rtxK0zAY9zBNdO5zDcAbgv3ddHkpiM+bPzGEr0FnJzECE9MV+pUDU/pIFVJB3osB20
 EE4ZQBhF1kzrs2+z6KK05DoWbllurxEhm9u6aT5og==
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-49050580a91mr404846245e9.11.1779984893973; 
 Thu, 28 May 2026 09:14:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b5a618dsm19378805e9.8.2026.05.28.09.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:14:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 1/3] target/microblaze: Convert to translate_for_debug
Date: Thu, 28 May 2026 17:14:48 +0100
Message-ID: <20260528161450.3564396-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528161450.3564396-1-peter.maydell@linaro.org>
References: <20260528161450.3564396-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
x86 and microblaze.  Convert microblaze to the newer
translate_for_debug method, as a step towards being able to remove
get_phys_addr_attrs_debug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c    |  2 +-
 target/microblaze/cpu.h    |  4 ++--
 target/microblaze/helper.c | 16 +++++++++-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index c6a456dd5e..a97c92a7b6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -428,7 +428,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
     .has_work = mb_cpu_has_work,
-    .get_phys_addr_attrs_debug = mb_cpu_get_phys_addr_attrs_debug,
+    .translate_for_debug = mb_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 068da60529..b9602f72b9 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -369,8 +369,8 @@ struct MicroBlazeCPUClass {
 #ifndef CONFIG_USER_ONLY
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
-hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
+bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                            MMUAccessType access_type,
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f81c4f625b..676f9de8f6 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -280,8 +280,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
-                                        MemTxAttrs *attrs)
+bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     hwaddr paddr = 0;
@@ -289,10 +289,6 @@ hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
 
-    /* Caller doesn't initialize */
-    *attrs = (MemTxAttrs) {};
-    attrs->secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
-
     if (mmu_idx != MMU_NOMMU_IDX) {
         hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
@@ -303,7 +299,13 @@ hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
         paddr = addr;
     }
 
-    return paddr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = paddr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.43.0


