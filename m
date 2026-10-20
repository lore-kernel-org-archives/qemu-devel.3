Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GvkvLZkS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8wo-0008T7-FH; Tue, 20 Oct 2026 08:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wm-0008SS-6r
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wk-0004My-LG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so26621255e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792499281; x=1793104081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dT6MVmsVPa33xYsB4R9hl3VCTg+ecJ2i/jON0dmG+pI=;
 b=GvkvLZkSpnwsDL6EVoKyewZDL3XisupkUN4oqAYMRay4MwDtb62ZEm40qkV0y3Hdgc
 CnTgRadScHUGibqztSvTS/LKwWc6QvztudAHed5EMbU4oC7v+VIj5Sp0kqbjcE/5Li21
 p1QClyx1u1A8TCm0ov1DzTD7LD3WUVxwSfB2SCcyhAr0Dq6okapBdO/1XEEgrZov/L8O
 V7SxJu1IxDiLmmgIZ7WA0o5OWWYfmY7OKP8uayI6NmxgfdgI/bi5A0Hb3D0Wz3CcM3jD
 usRElekI4dpLxWmiQoy2JEvBB0SHl/sHhAccqiRpdzW8lre41g10Z6keZr+oVmgo6X5s
 l/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499281; x=1793104081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dT6MVmsVPa33xYsB4R9hl3VCTg+ecJ2i/jON0dmG+pI=;
 b=OxQF0iQGR6Mr7v7uyjSY/mnJe3Q8fUxZounT3zJYf5+meu50+pQZn0FK1GdCYRtX9V
 BBlq4j5hX5ov6xp273SWH53FqHsUhIrZzT7AG4FyUOfZmfOPCMkshsv6HZKmrddMb1NI
 iV0vHP7sLnBIiJbzHcgLixVJW51K8jAtGhp4lI2BMOZ/0DqNpOg3eIpxGwUrIlZpSIV3
 WDAmotcmJjezvYxD/LIQ+WeeZkj4nnifKovo9v+Ne6EpEW+8rmcVznyy/q/UgWBG3fqD
 40OPS00E83qW5TRi0mP/+p77NtDxCpIM1oQGJcxb/2TsQeWsYSh/luDpAIlJq4EU933N
 TbKQ==
X-Gm-Message-State: AFq9FYKAy6r2L7WWW5l6MqCw/vYQXdiK3SQ9I/uIJVzoshyw+9pQCchE
 S2ZP1Zlp/u3eQKnu2c3+4gygqYJAXXlzfmJMPtjZGbhPndMOtZwnrQXHZrki8OHu+n+ffjZXsxk
 0xbp3eRw=
X-Gm-Gg: AYBFou0XqacgRWZRyfuhmLpzzEKlWwspPHKOpMAk8DW1dAxcnCxWICoPwzr/6u1wUje
 3bHSO/E9EbnLfuEOrbCNE0s389IxtNRelBLbHjMZHqJyij13rk69wIduT/uvS9tJXR0kIkakCvf
 lwac7a9+CstAHdg/gi6ue+5jOvlY6GOWQckoqej63fd+hgFwbddnexNJYCK5oH66retLNr42CUI
 XuxRDrp0dM+hT3cidCGFwPsV4pJfsb0OD8B7dDvmap79cZYC3Op8iLR1fF8BvsOU0KIw/U0QKJJ
 F4aovLrYj07B6wwz20nbmvHCzLNTJD1afElON0uQKFgtUcwusGlk6KO18DFKnrjkKJCPH56a7BF
 EOZroDeCQeOn4kcpBzzuNFM/rNgvMfX60iSxRy2buuHTxMTJE9SdLX8ay9uO8rZS6NAEJJNlBKe
 rJ6OmxNwX9CjLhDr9uulI/hZzB/BuuSiWQmhi8QQUbFUG/tiCSKtUW0tl61B9WzIQeyIg9/hC6m
 39cbhfjcsnstdAEzkWuqD0Zq3Mf8cjWZkEKg21dKU4QBiRxJH3MT8lughzVigmOD3c1LbmKKUI3
 NYdOqvVP3C1Z3w==
X-Received: by 2002:a05:600c:4e0d:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4a1e7ce1570mr122591455e9.2.1792499281003; 
 Tue, 20 Oct 2026 05:28:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd482bsm68899315e9.12.2026.10.20.05.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:28:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 3/5] target/or1k: Convert to translate_for_debug
Date: Tue, 20 Oct 2026 13:27:50 +0100
Message-ID: <20261020122752.3651914-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020122752.3651914-1-peter.maydell@linaro.org>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert or1k to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/or1k/cpu.h |  3 ++-
 target/or1k/cpu.c |  2 +-
 target/or1k/mmu.c | 21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index fc4387ce7ae..99b65ae4b97 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -296,7 +296,8 @@ void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #ifndef CONFIG_USER_ONLY
-hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool openrisc_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                      TranslateForDebugResult *result);
 
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                            MMUAccessType access_type, int mmu_idx,
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 66c00c0930c..d5415f0e567 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -247,7 +247,7 @@ static void openrisc_any_initfn(Object *obj)
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
     .has_work = openrisc_cpu_has_work,
-    .get_phys_addr_debug = openrisc_cpu_get_phys_addr_debug,
+    .translate_for_debug = openrisc_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 3fc56e1b771..a78e8c8ca2e 100644
--- a/target/or1k/mmu.c
+++ b/target/or1k/mmu.c
@@ -139,7 +139,8 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool openrisc_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                      TranslateForDebugResult *result)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     int prot, excp, sr = cpu->env.sr;
@@ -152,12 +153,15 @@ hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
                             PAGE_READ,
                             (sr & SR_SM) != 0);
         if (!excp) {
-            return phys_addr;
+            break;
         }
         excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
                             PAGE_EXEC,
                             (sr & SR_SM) != 0);
-        return excp ? -1 : phys_addr;
+        if (excp) {
+            return false;
+        }
+        break;
 
     default:
         /* The mmu is partially enabled, and we don't really have
@@ -167,13 +171,20 @@ hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
                             PAGE_EXEC | PAGE_READ | PAGE_WRITE,
                             (sr & SR_SM) != 0);
         if (!excp) {
-            return phys_addr;
+            break;
         }
         /* fallthru */
 
     case 0:
         /* The mmu is definitely disabled; lookups never fail.  */
         get_phys_nommu(&phys_addr, &prot, addr);
-        return phys_addr;
+        break;
     }
+
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
-- 
2.43.0


