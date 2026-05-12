Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE06CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgXa-000378-Dn; Tue, 12 May 2026 02:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWu-0001tG-QN
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWq-00052l-Kk
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso4386537f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567018; x=1779171818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iaQYN4CWwnEWNzbYvTCsYEF24c3R2ZFh9u0U94eq4LI=;
 b=UU0S9qAc22ztnkumi/P24for3GA2KTeqNDlhCgsTTS7mQbvcdmreKTv8/5GkdO+lQ1
 mbZ8Pk1+us74akGTBEKsunOV8kIUWNkUZkROWrBC+koQoZxk2szixsNExuYHgilsjHwd
 JchhTN3cu9/L+FXJWjH2kd9j7f1s+er4+C0cTqRy+4e9DBLZWwn2bsoKmOc6u6P2OhGi
 C5YbSlZDGo1pQr7kQWSbSXqD+2gnHr5aTAWoj0ynsRi3RVJ4WQVktUqclUOxr9J2UkII
 JBUqqeGYOsCqqXCYUDuZq+TM+8vMKlzENjNtwbj6TrW1yzOFQuCC9VeiWH+Fvh1BkLff
 B5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567018; x=1779171818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iaQYN4CWwnEWNzbYvTCsYEF24c3R2ZFh9u0U94eq4LI=;
 b=hPaDx7F5AQ/XgM5LlLF8VmL10tY7q3d8FykavsK/5KpeeB2ndfMOqDoO3KEWnDpAYQ
 K7pWyZqd0UCZW07mJ7dRRIA6rl6l5sdflcZVFjv9jplYr8vNNhc06PGDraryIYyBbOXt
 2/E/NLLiQd0X1F7NczC3pAlPU/8eETWjRTaQuDlLiA5fwrWiULquaDyrzmLS9PnZb9m1
 1Fz+twC8tJA9jUnwwWl/9jz2vx+1L5AnGs0cCiUgdnb9N3HP65hvKf/Kcj1epYSuX3TR
 NK3GUgoiiCSGwstKnouy5dygyrp73trnE70v2Q5W5flIg37ILt6kbEvS4YhiBcGZTnZX
 zodg==
X-Gm-Message-State: AOJu0Yxe+HbSEbHmMAGGBNGRBvcTePIxIDygxMa5g+D9wv0Wz8J7BOal
 Fq36IsVJaJrylASC3fVLoPMbzYD4FM8K593xOkbm15uUONFvpePehCVtOLc0D8m47haVa8WWXYZ
 oE2HuP7o=
X-Gm-Gg: Acq92OEguxkvUcG/yyoQn1XyFr5LJSCdRUKJIYdEXK+n8AOoVLTiKgXSqgQxOftBs9n
 ElD1RoTFp5SbP4njCLCGwBn2JFP+Hat0WeKxBeKKAWeKre8d/fVs0vXRA0s4bPytJt64Kndy6f7
 JEu4CMG8CO6ddMpzDaisqB4aJAhOJ3ZveehoVvsZclM1BqscZSp6igQl9H2NYsBTTMCQp07dSFg
 +4Nah+6/HkoKDhVJ6yi8fOlrYJqzuRsk+P4Gg5CSjzc52xhNitEpqq2RYvYUXXnH6sj9kWnXl4N
 bNt/Q36i5rhUZtIvUz0/MfiP0wptoUx5rX99KxvA9x0XwbmI+fYutihLLldAuO/EI5/QkvBnIyv
 nIdsNfdlEDS44F6YZNeRFXSDwDhOHuVMKYN5QYEnUyLzX9y9O0d2WqFzyP43cyQINvoHD+D8NYF
 NF+wz8JVqkS57s6Qn19o9vFtLFD/ueaPyxNJw3BSactS9zEsk6+vbApgXxnYCowHsug3sRG676
X-Received: by 2002:a05:6000:4381:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-456a47e069bmr18687280f8f.34.1778567017784; 
 Mon, 11 May 2026 23:23:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a68ebsm28718814f8f.1.2026.05.11.23.23.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] target/s390x: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:17 +0200
Message-ID: <20260512062142.67998-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

s390x already has an implementation of "give me the actual physical
address, not rounded down", in s390_get_phys_addr_debug(), so we can
use this for the SysemuCPUOps::get_phys_page_debug method, and merge
the s390_cpu_get_phys_page_debug() function into
s390_get_phys_addr_debug() which is now its only caller.

This leaves the function implementing the method with a name
that doesn't match the method name, but we will fix that shortly
by renaming the method to *_addr_* for all targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-7-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-8-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h |  1 -
 target/s390x/cpu-system.c     |  2 +-
 target/s390x/helper.c         | 20 +++++---------------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 40850bcdc45..e7e4f2b45d4 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -321,7 +321,6 @@ void do_restart_interrupt(CPUS390XState *env);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 void s390_handle_wait(S390CPU *cpu);
-hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 285f5999661..c9daa633c14 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -176,7 +176,7 @@ void s390_cpu_finalize(Object *obj)
 
 static const struct SysemuCPUOps s390_sysemu_ops = {
     .has_work = s390_cpu_has_work,
-    .get_phys_page_debug = s390_cpu_get_phys_page_debug,
+    .get_phys_page_debug = s390_cpu_get_phys_addr_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
     .legacy_vmsd = &vmstate_s390_cpu,
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 667d4a0da75..1a2658eaf93 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -39,7 +39,7 @@ void s390x_cpu_timer(void *opaque)
     cpu_inject_cpu_timer((S390CPU *) opaque);
 }
 
-hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
@@ -47,10 +47,11 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
     int prot;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t tec;
+    vaddr page = addr & TARGET_PAGE_MASK;
 
     /* 31-Bit mode */
     if (!(env->psw.mask & PSW_MASK_64)) {
-        vaddr &= 0x7fffffff;
+        page &= 0x7fffffff;
     }
 
     /* We want to read the code (e.g., see what we are single-stepping).*/
@@ -62,24 +63,13 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
      * We want to read code even if IEP is active. Use MMU_DATA_LOAD instead
      * of MMU_INST_FETCH.
      */
-    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, &tec)) {
+    if (mmu_translate(env, page, MMU_DATA_LOAD, asc, &raddr, &prot, &tec)) {
         return -1;
     }
+    raddr += (addr & ~TARGET_PAGE_MASK);
     return raddr;
 }
 
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v_addr)
-{
-    hwaddr phys_addr;
-    vaddr page;
-
-    page = v_addr & TARGET_PAGE_MASK;
-    phys_addr = cpu_get_phys_page_debug(cs, page);
-    phys_addr += (v_addr & ~TARGET_PAGE_MASK);
-
-    return phys_addr;
-}
-
 static inline bool is_special_wait_psw(uint64_t psw_addr)
 {
     /* signal quiesce */
-- 
2.53.0


