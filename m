Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E878FEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzW-0002Xb-S0; Tue, 30 Dec 2025 16:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzC-0001jK-Jh
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:35 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzA-0002jL-RY
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso64177455e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129031; x=1767733831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4HHs8JJBlkqK5dGRyRM7AMKgYGwv/c7DPSq4oaL1jlE=;
 b=MyyZstlX71f4yi+AuIjo0OIUBbcxCQeWkavA3Mn8ljFahAqFA1FGB5IUz6Tm+NGIBU
 gnHbiRy1denzdBymMCC8uIC0WnbE2ISGdfa7ZT2e46n7qYmUSewaBLjwcVw6NKeuhmsj
 0aEDH3y1/7WzXzQBZh1jWtrnPXb12p9RRK/QJ2x8UydpKgBQQRTLI6bSnpLxzq22l3qt
 AvhVBUbW0UQUauCEZ7mP0e4lZPz/chGvHqUwLADnpZ2miF2RUf2K2Ay15GwsnMJtv7S7
 XFeMh8ZcHY5zXmVlvu9Sh77pimWRIw27va0T67Bxx68AtM4aGp1nGjW31CNaLJfebz8N
 d4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129031; x=1767733831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4HHs8JJBlkqK5dGRyRM7AMKgYGwv/c7DPSq4oaL1jlE=;
 b=P1Eqw5FhngiZ21uGwaSqexHt4Ly3+xGFF39Vr38NxjCv+66ae1f4XjpIGrY3adDP9D
 7YWZlQsORRLppE7nZ9PohSJOxKbNF3JcnCL9ktq7FhafZLt0u+sgEP1exjcTCTohC/zt
 8ZvfbF1k8eRj/j6dED3XDlIU6F7/sN/OlHQHBFIK+QiWE+wJzAeQCmoOYUBrq0zIV4tx
 qsb++kvFJ/fdAHqXKIiprMZ4b3J+ao5A6aiIVRMi76I5OgoerQ3V9R2hnKNL8EAiKvMt
 1JaF9vWW8NCkCKqTPY6R7WL07dUjcseRB3uFZTKYHwb0RCerUwv9G9VQaO8z1r7RxO05
 C8qg==
X-Gm-Message-State: AOJu0Yx1aqdv6tQuOxhO+c6NC++UrRXPn1gpLLo2RT8mG0GFV5Z3BaRI
 d1wZe0sQCIGh58gSKE6cExuL8tZ1u1W4qmLh8ivhLcawJ1kgf9rJA+c1tIG0Q2ig+9QqbnoMgWB
 2KdvFMMc=
X-Gm-Gg: AY/fxX7pxh9wLrpJaEioCN9xPnSl30koE0O8uqpLGBfAp+Pw4DfrD393xPharYWJrvn
 8uXKocMJVUv9xi/p4BulFnEeG3dDJMlL/hAPp+ofSopSbqdQe0De/HD3Hnv1hfLcmB8tL8/U4Gn
 k5EYlaTa0d39qDW1Fkad27OX7RCEnxtxKPsia35FNOHTWCKaZgolplrlY7m91RDwc7uwt+YmBdN
 w0AYQjWejVante0/PH62rd2edXclFPciMna6jneefgal67H7bpyti8kj1y6k2jzTWXyKJLsuwWK
 N8y/Mrju5fAh67Svh6yr7jcvP2mMj5woFZVEnP/Kw6Xnn2n+wzSocjcD75RErHTTno7pAl6573G
 UhQwdJC8hUa11n7dRr88j14GPt/pE/KI8E6Pk7797SBIE07y5RAZ3bjtWwwGrnVbh4gHKrFHL9s
 HCjwRqQJt5wFhOArAGB2rscvmvAqs+OA7iKk4nBdb2VivGp7NDiGuRdl4xvjo5tcdv/TVtCGM=
X-Google-Smtp-Source: AGHT+IHBIGMx4ih4HMbfdXMjwWkKOGzypUnxFyEBGW79owQgoHTdHzzzI4lA19U3aCBcgmDBUDtLqQ==
X-Received: by 2002:a05:600c:4fd3:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-47d19532e14mr349319655e9.7.1767129030718; 
 Tue, 30 Dec 2025 13:10:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b28a7sm664836485e9.12.2025.12.30.13.10.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/34] system/memory: Remove address_space_stl_notdirty and
 stl_phys_notdirty
Date: Tue, 30 Dec 2025 22:07:45 +0100
Message-ID: <20251230210757.13803-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

stl_phys_notdirty() was added in commit 8df1cd076cc ("physical memory
access functions") as a (premature?) optimisation for the CODE path.
Meanwhile 20 years passed, we might never have understood / used it
properly; the code evolved and now the recommended way to access the
CODE path is via the cpu_ld/st_mmu*() API.

Remove both address_space_stl_notdirty() and stl_phys_notdirty()
leftovers.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-5-philmd@linaro.org>
---
 include/system/memory.h          |  6 -----
 include/system/memory_ldst.h.inc |  2 --
 system/memory_ldst.c.inc         | 39 --------------------------------
 3 files changed, 47 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index b3597fb2d04..edef51a276d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2855,12 +2855,6 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "system/memory_ldst.h.inc"
 
-static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_notdirty(as, addr, val,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 7270235c600..173164fee3a 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -25,8 +25,6 @@ uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl, SUFFIX)(ARG1_DECL,
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 333da209d1a..b45bfecd137 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -261,45 +261,6 @@ uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
                                        DEVICE_BIG_ENDIAN);
 }
 
-/* warning: addr must be aligned. The ram page is not masked as dirty
-   and the code inside is not invalidated. It is useful if the dirty
-   bits are used to track modified PTEs */
-void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    uint8_t *ptr;
-    MemoryRegion *mr;
-    hwaddr l = 4;
-    hwaddr addr1;
-    MemTxResult r;
-    uint8_t dirty_log_mask;
-    bool release_lock = false;
-
-    RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
-
-        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
-    } else {
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        stl_p(ptr, val);
-
-        dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-        dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
-        physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
-                                            4, dirty_log_mask);
-        r = MEMTX_OK;
-    }
-    if (result) {
-        *result = r;
-    }
-    if (release_lock) {
-        bql_unlock();
-    }
-    RCU_READ_UNLOCK();
-}
-
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
-- 
2.52.0


