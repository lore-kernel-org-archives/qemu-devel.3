Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F920E83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbc-0002sR-IG; Wed, 04 Feb 2026 13:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhba-0002nS-Ig
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbX-00015p-M1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:58 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so144662f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229674; x=1770834474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvYDn7wiE6YYknVXCDrq+1QLwmQ6PA+WeFUDdqmLXUU=;
 b=kQYSRqm9PTuXJqZCoVFilcCel2N4qJ6v9XUbLavSCsCGlr5bxvjd0DxufKqNcvza2H
 G2RAYAgDS4Hjx+ZuVezlN/gSW/biOn0OK8ODVRi9cgQjyEZyYUVsVSeSL9lBgzCKlA7Y
 swTEePDcomYre2q0GNqL0Z725iV12zLRehAHweI0fLjnM9DZ6iu2XmmgnHudwckLyFa3
 67qGOPsqAszAs2jb9KRIv2T8HyTua8Z2LLiIap0XVHBfT3covczzi92wmDUhmQb83V2B
 av/HdWwULfDy3QzJ9wdl6h4qQG3NrpSMFEctggXBxjBbOPJOJwAaA0WKJpSUutZoHWwF
 lATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229674; x=1770834474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvYDn7wiE6YYknVXCDrq+1QLwmQ6PA+WeFUDdqmLXUU=;
 b=NUDzn/5bsb+84Fm2OrvQCJ0TMwa8akgh5dJobMVjaFTkIrfgGAngbyRViPl3ghRbSW
 FCH1HcKPi4ENywaWqnaj/rUVfpxpsioft7L1OWaPxZGQJ6Ffijiz9DB6ig+nJhaogUWj
 K2RO7wx2MxUYuXVZuUVgSL+Z8eUcdzJtbQT51LvV/BUy0o+WB3NK2dAcOvUXBDmIiXjU
 9pTsyuG8nKrg8qsg7UttM6EHn2MJSQ5YxewWlBCZbK+z+efX0VsgM94O1VR8tppDf7YL
 xI8rkuB1GWlKjy81/3WhnqwBjPaw86dqMIudyMILv+Tr092lthhUuBvrm/Vi0XsiDKET
 zoZQ==
X-Gm-Message-State: AOJu0YzW+13q3eBbd2JV4VNcSoTPD/3vPR+CVuNIo/nx/AOsKUOcNocN
 Dyz8WKaMKc+fcpAYqDz2vlGcWqv6PFsf7QfEzD6+JoPkbER1klJIuvdy+FMI9+ahY7oLxfi/5nM
 oP1gt4Es=
X-Gm-Gg: AZuq6aLVVedq1CFyKT4H8E128Qsi3JQr7+SMRU7GKMk9H6qp5TJF7CnvXqXQzcLCs5D
 ODGkiC0/Xmj+FKcvpkQM0Ax3V3+f8Ls94KjhRR/BBnQsUfVwGffRpa29f7sNPIfwYxPP8R9kzPI
 /m6VaX5ezPZRrn28T2Crl6KUMQ350tPndVJ/+HgA1BOK0qwejCyBk01RhY+c0UMlsnfs7Jt9ENA
 N4/5mwTqzFHQBndbLz1K5MJ7WNmL4+XPbQEZWcTXotuNfe04q0IZB5KNzzYpOUKhUNuuTGNZfR9
 3sd9BJwkmGSbJzXH22VtzCksm/y6QDqFeeqifi46a4TCxcNLMYKb2DxJvEYeQL8ys8nNkntP06t
 KzIxatxOD/1l5qW2EWTi3ypRFT0LL2T1/qU9cLGFmV6kybjVplq3tebL0vbVO2nkIzkyMUjQMBf
 NRBPJadgbwHsnI8FEOsQgivU1JYUwZZwkdG2hqELqR5vLVQrVS3mdf723GKgGUZH4aOSHhC94=
X-Received: by 2002:a05:6000:2011:b0:435:9950:ee1 with SMTP id
 ffacd0b85a97d-43617e37d52mr5840899f8f.3.1770229673688; 
 Wed, 04 Feb 2026 10:27:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38fbbsm8665770f8f.13.2026.02.04.10.27.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:27:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] target/s390x: Replace %target_ulong -> %hwaddr where
 appropriate
Date: Wed,  4 Feb 2026 19:27:17 +0100
Message-ID: <20260204182722.44062-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the %hwaddr type for physical addresses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h  |  9 +++++----
 target/s390x/helper.c          |  2 +-
 target/s390x/mmu_helper.c      | 16 ++++++++--------
 target/s390x/tcg/excp_helper.c |  2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index f0f7bb5cb11..790cd688762 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -10,6 +10,7 @@
 #ifndef S390X_INTERNAL_H
 #define S390X_INTERNAL_H
 
+#include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
@@ -368,19 +369,19 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 
 
 /* mem_helper.c */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra);
 
 
 /* mmu_helper.c */
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
+hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr);
+bool mmu_absolute_addr_valid(hwaddr addr, bool is_write);
 /* Special access mode only valid for mmu_translate() */
 #define MMU_S390_LRA        -1
 int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec);
+                  hwaddr *raddr, int *flags, uint64_t *tec);
 int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec);
+                       hwaddr *addr, int *flags, uint64_t *tec);
 
 
 /* misc_helper.c */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 5002eebd4c8..667d4a0da75 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -43,7 +43,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    target_ulong raddr;
+    hwaddr raddr;
     int prot;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t tec;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 3313487b41d..a3cbfab79b6 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -86,7 +86,7 @@ static bool lowprot_enabled(const CPUS390XState *env, uint64_t asc)
  * Translate real address to absolute (= physical)
  * address by taking care of the prefix mapping.
  */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
+hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr)
 {
     if (raddr < 0x2000) {
         return raddr + env->psa;    /* Map the lowcore. */
@@ -96,7 +96,7 @@ target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
     return raddr;
 }
 
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write)
+bool mmu_absolute_addr_valid(hwaddr addr, bool is_write)
 {
     return address_space_access_valid(&address_space_memory,
                                       addr & TARGET_PAGE_MASK,
@@ -123,7 +123,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
 }
 
 static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
-                              uint64_t asc, uint64_t asce, target_ulong *raddr,
+                              uint64_t asc, uint64_t asce, hwaddr *raddr,
                               int *flags)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
@@ -296,7 +296,7 @@ static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
     return 0;
 }
 
-static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
+static void mmu_handle_skey(hwaddr addr, int rw, int *flags)
 {
     static S390SKeysClass *skeyclass;
     static S390SKeysState *ss;
@@ -382,7 +382,7 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
  * @return       0 = success, != 0, the exception to raise
  */
 int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec)
+                  hwaddr *raddr, int *flags, uint64_t *tec)
 {
     uint64_t asce;
     int r;
@@ -472,7 +472,7 @@ nodat:
  * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
-                           target_ulong *pages, bool is_write, uint64_t *tec)
+                           hwaddr *pages, bool is_write, uint64_t *tec)
 {
     uint64_t asc = cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env = &cpu->env;
@@ -523,7 +523,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int currlen, nr_pages, i;
-    target_ulong *pages;
+    hwaddr *pages;
     uint64_t tec;
     int ret;
 
@@ -585,7 +585,7 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
  * @return       0 = success, != 0, the exception to raise
  */
 int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec)
+                       hwaddr *addr, int *flags, uint64_t *tec)
 {
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 292d130d03e..41b0017d767 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -148,7 +148,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     CPUS390XState *env = cpu_env(cs);
     vaddr vaddr;
-    target_ulong raddr;
+    hwaddr raddr;
     uint64_t asc, tec;
     int prot, excp;
 
-- 
2.52.0


