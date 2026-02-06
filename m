Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4FCEE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQRN-0007TL-15; Fri, 06 Feb 2026 13:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRM-0007Sm-2g
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRK-0004vP-KE
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48069a48629so22177345e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402020; x=1771006820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrcCkInJZLGHoUCMjS3h9A+VC+3ccU1K0/TSYxS+ucA=;
 b=x30mEBdOBMqbmkrHP35i63U1hd8ckNXO1UdrWRSx1Abp82BfotajZHmQfcPaHWuGJ+
 zv24IVxZuKfM3InlZkQTWls+PsDSAzjC1NI2vVV4tQiKcOmUs2ZebA/UbdvlbXa0jysB
 XbDEgrgT97sq1Ldw2toPdAihy7SRf8jRpMs0t6QsPYbhHBpTyfAROwXqp6X0TneI9L1G
 yK7bzlxHKYCrQPzcXPkRhC+7/f+xkNRbIpqvob2gNk9JeLKsu8tgSqXReS3rEMtuv/LC
 wAq3dCz01mTxlTkMVXslzPKhz4IAKTuWJnSrxcw6w2LiQtm/PFanKvWOi5EA2njZqjYz
 4R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402020; x=1771006820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrcCkInJZLGHoUCMjS3h9A+VC+3ccU1K0/TSYxS+ucA=;
 b=tqDPQL+TGvPZJyh8hzyAOU7Xsd79msqVisFs8A7IDLztMQznwc6bUpC5XD9muawJ9e
 5kMV9eXiE0HwOGSSALeOyrLsv6Hf3CA2PMavRWqji/Ch64EqivdcEmjPphD+hhJ9lxeh
 +6q0Nx4v5SgzpphngZlEu6ojn0Tfbf2pjha1xIF0cy34RsAZhkdK2naSBdwSD+4hGa5A
 mTYnKgvCAy6Bv+TorpyghrIUJ4wlxK93y2wVZUgkoF32AEUIcubIUFZzqm8KDwT6Cpd9
 I/gLJHFPxdCzdjhIqzhnZYMZBkZ3eW9Og+zQVww700kKEdrg7cdsgkCti3esXCb+wocQ
 TjrA==
X-Gm-Message-State: AOJu0YwejHnyOZ5fzzAw69J7f41Lp5MqsMSZQVcrKqR7pyC0fSjvfUu9
 PqeNeUjnga+Um0tklQ5krvfWH1vGzVsqHlXckNb1CNj+BP7KAuCzD+iC2999yqbfTl43xIvYv5P
 TxqtBdTg=
X-Gm-Gg: AZuq6aKFmVbxQTiwG2TxMssJJibXAySHHi8HEfQXegEx4D1NdlTE0MM1IC/nxHdTQRr
 GAz+gSuSmKLYHLWfjIhhEmt8fQsdxB08I/4KUKrUlUab1SIVpNrv5J1/y5AXV/lW5A1xzWx5l/Y
 mHjAwVqSREgtIzMFMYtNUfLbyhSoq2rWXZza4AA1Af5h40VnNVsuzoQm0gsXxkFNz0mKiDxMoux
 m+nd0OqsqBC37SY/pghbKzEQyLxlIBNYd4LOC9HFr65K02F1gG0HCWmviboQRiFyYCGEYxvUEv9
 3JUt2cAkR990pDXqTycHUuNmvwY+SEM7Kh5/wapAxUXrgX3LaurRbv1bmJRqJsYE6pnnpQIXn7t
 AVFxF6Jqav89XqejeFOUM9EFz+zWmlfg+UFmqXIvacTHYxiLHk8UvY+Py33rq4D7TTI+k2CTFqq
 qS/oXOT1NvMB3x9KzWBh3ay6MkfbDal7ZrnF3vXa1BfzWk92tovLvZvftPJJ02
X-Received: by 2002:a05:600c:3d96:b0:47e:e20e:bbbe with SMTP id
 5b1f17b1804b1-4832021eaa9mr56311165e9.25.1770402019725; 
 Fri, 06 Feb 2026 10:20:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209c1a64sm23611385e9.12.2026.02.06.10.20.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/10] target/s390x: Replace %target_ulong -> %vaddr where
 appropriate
Date: Fri,  6 Feb 2026 19:19:46 +0100
Message-ID: <20260206181953.18683-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Use the %vaddr type for virtual addresses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/s390x-internal.h  | 3 ++-
 target/s390x/helper.c          | 2 +-
 target/s390x/mmu_helper.c      | 4 ++--
 target/s390x/tcg/excp_helper.c | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a4b54dc441c..31e164c9b5a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -10,6 +10,7 @@
 #ifndef S390X_INTERNAL_H
 #define S390X_INTERNAL_H
 
+#include "exec/vaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
 
@@ -376,7 +377,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
 /* Special access mode only valid for mmu_translate() */
 #define MMU_S390_LRA        -1
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
+int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, uint64_t *tec);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags, uint64_t *tec);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index d0c36d4a537..5002eebd4c8 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -71,7 +71,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v_addr)
 {
     hwaddr phys_addr;
-    target_ulong page;
+    vaddr page;
 
     page = v_addr & TARGET_PAGE_MASK;
     phys_addr = cpu_get_phys_page_debug(cs, page);
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 30f09ec3de4..39ff42da3a3 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -122,7 +122,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
     return ret == MEMTX_OK;
 }
 
-static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
+static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
                               uint64_t asc, uint64_t asce, target_ulong *raddr,
                               int *flags)
 {
@@ -381,7 +381,7 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
  *               there is an exception to raise
  * @return       0 = success, != 0, the exception to raise
  */
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
+int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, uint64_t *tec)
 {
     uint64_t asce;
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 019eb4fba1f..292d130d03e 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -147,7 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        bool probe, uintptr_t retaddr)
 {
     CPUS390XState *env = cpu_env(cs);
-    target_ulong vaddr, raddr;
+    vaddr vaddr;
+    target_ulong raddr;
     uint64_t asc, tec;
     int prot, excp;
 
-- 
2.52.0


