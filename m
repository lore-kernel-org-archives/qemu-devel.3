Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F0E109190B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ITl-0003Kb-I0; Thu, 19 Mar 2026 14:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITj-0003Jj-6Y
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITg-0000zU-Vc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483487335c2so9769215e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773946334; x=1774551134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99Agaah8svWMvp88jjgollb/i/IbGwJRUZgPwXncGK8=;
 b=XAOLDHQwoThKWVTUvvVXwrPn6RxvuTAHKqn638ge+pYQXfkAb86u31LiVcrx4xWd1Y
 I8BeSwp8B0lQB0VFtFR/9l4MEmyiMHNDZvO0aZwPFgo8OKxyHxprOUkjEvwfAN+VLMNP
 bwgNZ+j7iB8kcU89Ts+yiXgbuH7mc4X4h9pDLFNAhIzMSXv8Cc1Kv32gqOyqTxHvPEJl
 rdtrWE/S0RapyCGeAcrgJjMOpgo/rHSsKozYDcHDtgDd9HQi4p/6T2z/e/YNBaxVWAcS
 IGSojXffp0SWq8z/LfsIUasMXqkF3849/N4LA2D5T7jAPH14cDBlDz0TzGA1/zUXKZ9C
 sjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946334; x=1774551134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=99Agaah8svWMvp88jjgollb/i/IbGwJRUZgPwXncGK8=;
 b=I16nT0UE6osTaL0MwuygKsFx8k67pzvLokgiPDbg6x7Ha+NjBsDDsG1TN6VG1u3p9L
 dAUs1o06DTzvokhAb0/zMIoelCtmSrOQcEXU8s/5UaUyy04ck1KgtrF8ZF71is9MhpQF
 EdSI7MeyrWtq0wn0RYDpET2UkwaRHibJfC571ftnrV8ydNvoH6Gh8CEo5zfy1bKAv75S
 VHyLQINgmNRz41/WUjia6Mq8wDcqQ64ZA/fGX/Kyjx+1v4H0dNX+XY1W4KAnd3MY3DqC
 RwxvXCfKteEyEJnMRVKgIDHbmZYrJLmxTYctSpODcM3SKdtZrhipmd6bxtHVM3mQS5hc
 TK1Q==
X-Gm-Message-State: AOJu0YzUQbIWWKfxTjDyRmcvTYtYew8BYkMBzFqIknMY5IfYFEI+Dhi4
 yZLMj4coRibB7Q2l+o/jgDDk3enyvjBYgTgFx5EY6rhjGBVTMHzFPHxR7CKUWNYYgfMlDSxHnLw
 bxb1vZNo=
X-Gm-Gg: ATEYQzy4B0kAZCkqcNHfOUoI5rT3L33iSymhzMj0iDJrsnPJm+2RcP4kx4Qx6eYIxN0
 ozWMAvzcTRmZYbhg1pynNm4sxUNrj9l6+fgAXJXT1WYhJznpcN0aJPODiaec9ZbCqL5GUjOKzCq
 S8C/5cxnnsP2hw48UNMuYu5ONGQ6j21YpynMsiNGgwRWb+bhq5OeInV9VpD7QgpxDMnZUALJ78T
 DwO+wbEklD5Tr3uBgFJdgYrBRWZ7GC6kshWhoHc/94fIwQkDcOHFgqZJCMmesgR7Y5ANJXx/ODV
 ADsdHg0SijiIpmtuMCFy5spZsx+nhNee9e3oIuGX+wPrIUN9ogPnCUCeZH0rHQDJLIG/p+uo+nA
 Zxg/8L5u7Oz5uHCXV3MyWe/ReQ/IS9E5oBNna7jmgr9ASb8vb75yekxNgO1aHE2hVEe/DDtGfyB
 9+h6vVwe635UnxjqYqXPa12SKZVQtvOV5CeH3jT8Vw2tIDZuuXJ8L+jh4pZJysz2fj4m1xoN4R
X-Received: by 2002:a05:600c:3d90:b0:485:3c8f:e4d9 with SMTP id
 5b1f17b1804b1-486fee1d9e6mr2730975e9.26.1773946334418; 
 Thu, 19 Mar 2026 11:52:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d9896sm8408145e9.2.2026.03.19.11.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 11:52:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (cpu)
Date: Thu, 19 Mar 2026 19:51:59 +0100
Message-ID: <20260319185203.11799-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
References: <20260319185203.11799-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/excp_helper.c | 21 +++++++++++++--------
 target/s390x/tcg/mem_helper.c  | 12 +++++++-----
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 41b0017d767..05e448d3f20 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -54,8 +54,9 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     g_assert(dxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Store the DXC into the lowcore */
-    stl_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, data_exc_code), dxc);
+    address_space_stl_be(env_cpu(env)->as,
+                         env->psa + offsetof(LowCore, data_exc_code), dxc,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 #endif
 
     /* Store the DXC into the FPC if AFP is enabled */
@@ -71,8 +72,9 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
     g_assert(vxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
-    stl_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, data_exc_code), vxc);
+    address_space_stl_be(env_cpu(env)->as,
+                         env->psa + offsetof(LowCore, data_exc_code), vxc,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 #endif
 
     /* Always store the VXC into the FPC, without AFP it is undefined */
@@ -619,11 +621,14 @@ void monitor_event(CPUS390XState *env,
                    uint64_t monitor_code,
                    uint8_t monitor_class, uintptr_t ra)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    AddressSpace *as = env_cpu(env)->as;
+
     /* Store the Monitor Code and the Monitor Class Number into the lowcore */
-    stq_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, monitor_code), monitor_code);
-    stw_be_phys(env_cpu(env)->as,
-                env->psa + offsetof(LowCore, mon_class_num), monitor_class);
+    address_space_stq_be(as, env->psa + offsetof(LowCore, monitor_code),
+                         monitor_code, attrs, NULL);
+    address_space_stw_be(as, env->psa + offsetof(LowCore, mon_class_num),
+                         monitor_class, attrs, NULL);
 
     tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
 }
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 2a79a789f63..8474a694110 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -41,6 +41,7 @@
 #else
 #include "hw/s390x/storage-keys.h"
 #include "hw/core/boards.h"
+#include "system/memory.h"
 #endif
 
 #ifdef CONFIG_USER_ONLY
@@ -958,13 +959,14 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
 inject_exc:
 #if !defined(CONFIG_USER_ONLY)
     if (exc != PGM_ADDRESSING) {
-        stq_be_phys(env_cpu(env)->as,
-                    env->psa + offsetof(LowCore, trans_exc_code),
-                    env->tlb_fill_tec);
+        address_space_stq_be(env_cpu(env)->as,
+                             env->psa + offsetof(LowCore, trans_exc_code),
+                             env->tlb_fill_tec, MEMTXATTRS_UNSPECIFIED, NULL);
     }
     if (exc == PGM_PAGE_TRANS) {
-        stb_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, op_access_id),
-                 r1 << 4 | r2);
+        address_space_stb(env_cpu(env)->as,
+                          env->psa + offsetof(LowCore, op_access_id),
+                          r1 << 4 | r2, MEMTXATTRS_UNSPECIFIED, NULL);
     }
 #endif
     tcg_s390_program_interrupt(env, exc, ra);
-- 
2.53.0


