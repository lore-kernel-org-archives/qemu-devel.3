Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF8606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xj4h1Qsp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8wp-0008Te-T8; Tue, 20 Oct 2026 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wo-0008TD-Ju
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ8wm-0004NH-Vl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:28:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so32415425e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792499283; x=1793104083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vIJbdNAXRzY/n52qxKNec3ew+2nR5MYFb3y4fJM4Cfs=;
 b=Xj4h1Qspg4FZXe4qkcJ+zDbGC2AIzynpB8iuR45KjBtz3xSdaFDp1PQh3Q8qP2Z2xw
 epW8xtG9Ydzur4rKMsRRcfHdtmL2GSNHeFCcfK5Ctta+9pSL1E13H7xdo3UV+Fzci4qg
 oWJDyjteTrzDI9Wp5TK+4EYGhSRn/qxrW0k3hmdvjliL2m+QdNNCrk6kYMeOqHaHJXH5
 XUmEpu5BDe+ODBbXZBVyZmgNT9Ul+iE/BZiQBPg0A5hqJhLSE/vsrGOZNyHSpLmOYCjB
 aaP/Ky2PdEycx/WVQcwr+dkFv1jxr+6BAeQ8nZKM4na1SSN88M+376k7/HeEDAMiVQ1K
 7C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499283; x=1793104083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vIJbdNAXRzY/n52qxKNec3ew+2nR5MYFb3y4fJM4Cfs=;
 b=kEq32bCmKyoqdU/V+Hm5P0ktmlvpSZpEjK/cjsbBkKYgfhO1Pm+LGtJ15LIi3cCcZk
 m0kkcOFej5QP/9pbaXqPUh9EhnggBZERYeL0HT9g69tUvZ0wyu4OPPfAGH5W1l4SWfX1
 xyfc1KiT8o3r3XQaUXKILWLkMJc/wkAXFVF0erv5K/A1Msrriln78ic7sXUwg0ClKDtH
 zjUn37TlPuBl7OPw4UdOBQsyho8tTXs7Pjl/irySLxoP05+tZ4IfHQenASeT7h4Oio34
 AQQou1kBKWrO3ZXSg8aTBiDxBamcvuoEiHDuPBGal+MxvYX5YPon6P8KgdJnPpH4ZP0z
 W1KA==
X-Gm-Message-State: AFq9FYI2K21mLJDOw4+Wft8DxnEVHWHhjwgYngkTpm9zPvhQgJbMXskf
 rklQsAabIMCNUzQrLbxHxFYbzxN11WpUaQFQp4XA1GrD2WBc2re3+G98gAPVvh7JdVIGVu4Lx0e
 8disKZiI=
X-Gm-Gg: AYBFou0ZllyOBvwg4gjQzZKBDMhdhhIbhNgWL3DtiKesvcscATju4raBicO5gAXw0N5
 aexRd3rQ7OesZfXD3UmVDxWMwmgIZFtmwnLKDOU7kAfaJ4jzRrQWN0HhHhdJYZ5BJIGvBBa7HOu
 Q2Ljqc4lnhHMiiHCuAXHkgj/rnsErShLmzC38IvGY8gMV9b7Cp+2tOPvxFPLDTKk3A8YFCO+TtY
 DyiLZA+xaUYz9WuFvCiz//+xeEZO8bUaBL8ZyOhCcnuBYQAA2iJtZm1r3us+IDk1HFzKUD0DmRP
 j990n2G8Mrp5WsC7PLMc4wp6Yw4mrPTWNX2axsgY3Qmiv/8g5hI6/8QPuQjRcx60gxc6mxDmhzO
 e1/dUftjMm13NRWu9jQURhilwYdWTYak5g6xO/2VsDYaW7sVXh/6+YINrdOSNTfHf6vYQ2XbROX
 X0+2/GNMVhTPVjgz9iLoNEGa2FoyIGXYrdoZHvL0BFhwTGsamQjA5DCbO0o/5tejNEl7Hu7KxEk
 5CAiErSXrGhKRvK+A8RUedYXzixfIaU/MD6DhDQ013RIQGFCmKh4fOTXWJ72KLaSRc7vYXrYZuQ
 mXY=
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a1d7615cb9mr230307795e9.17.1792499283517; 
 Tue, 20 Oct 2026 05:28:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd482bsm68899315e9.12.2026.10.20.05.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 05:28:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 5/5] target/tricore: Convert to translate_for_debug
Date: Tue, 20 Oct 2026 13:27:52 +0100
Message-ID: <20261020122752.3651914-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020122752.3651914-1-peter.maydell@linaro.org>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Convert tricore to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/tricore/cpu.h    |  3 ++-
 target/tricore/cpu.c    |  2 +-
 target/tricore/helper.c | 13 ++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 12e497d2a7a..17e3d1fe804 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -79,7 +79,8 @@ struct TriCoreCPUClass {
     ResettablePhases parent_phases;
 };
 
-hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool tricore_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                     TranslateForDebugResult *result);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 FIELD(PCXI, PCPN_13, 24, 8)
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 84a05e3d363..deca702cc6d 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -207,7 +207,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
     .has_work = tricore_cpu_has_work,
-    .get_phys_addr_debug = tricore_cpu_get_phys_addr_debug,
+    .translate_for_debug = tricore_cpu_translate_for_debug,
 };
 
 static const TCGCPUOps tricore_tcg_ops = {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 273713a1473..9cc80b14c8c 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -47,7 +47,8 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
     return ret;
 }
 
-hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool tricore_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                     TranslateForDebugResult *result)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     hwaddr phys_addr;
@@ -56,9 +57,15 @@ hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(&cpu->env, &phys_addr, &prot, addr,
                              MMU_DATA_LOAD, mmu_idx)) {
-        return -1;
+        return false;
     }
-    return phys_addr;
+
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 /* TODO: Add exception support */
-- 
2.43.0


