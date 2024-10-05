Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1F4CF887E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fj-0002Cg-Sq; Sat, 05 Oct 2024 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6ff-0002AA-Hh
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fd-0002Qt-Jl
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b95359440so27109595ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141972; x=1728746772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qIlBHpyIHO+kiCFyGgZVBXgacr4yw5gCrMn63zUSz3U=;
 b=eDMItdVME/VsMLfCoup7x9FWV5tSbBjc2rTrL3G3ZRO7H97Uwh6WV8kZY98RIWxYVz
 0LQe7c9kLru7UOTrQFY7W70Or/R9UMzquKSYRy0WwJPdFtVTOf44zds9NmL9Q6xt05/f
 YAwFMkxdOmAiXSt/11m8K/uNVG7NTo7+HsySX2Vsc0Dlwt2UZRHDeIq3YZ9Nwreg2qT/
 G98b+nQhKzYdtYuIDD/zJdwVpIr/AMwUhOxB7neBWLkpbALAPQwDBcp8slJ2tiy7nc4J
 BijDdZZfpr5+pp7w+w5H/o3gXS0afn0LVidyoUzcMV42KvGFhuNr8XlDz0UGcx7pKK//
 y93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141972; x=1728746772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIlBHpyIHO+kiCFyGgZVBXgacr4yw5gCrMn63zUSz3U=;
 b=YDan9tVefdTHkpPZDIeXV7XSC8RtDZnpw6FNTD3sbaMUMGd+tnsmlFGBEmn8CmuqjV
 kqEJigEZQLrtzNviyNTelYUmrciprEfObQ5jhuEB7tnL87LRZGfvoRXfuHUbUazIM7t9
 d7/wRtsbiUqTLqvL7huzZ7XeEcZerKTeJyEk8/uj+DasEAQKT7EArYdaM8ewOHJkz3pS
 XP2/SvF3EbiGDNTrHt2ikDjRbQwHNUM2lW2gp6KGhrC7oNpHSlsPOxEBZDD2oMqhz9UF
 fQ1GLW0/jlACzD3yF1p09KKyrehhgOAQ9sKf8J4MIz1dvFhsv7V1tye8L/Zv0UMeipz1
 hVtw==
X-Gm-Message-State: AOJu0YyTqW26ldEfwVbeSvCik+YYB4fvVAt+pxVtNEI/CuqE1uSCbyyA
 IhGOUf0/EvINS+hkrBUoDMQJGjNxFJ5xk6icS4jwrjc5I/tKf0mO3qxR0vWcxa4R3AfeHwYEYdF
 t
X-Google-Smtp-Source: AGHT+IGWHKPtHA2twxKvGB6E/ujF3z3IoFDGiLN3geSfu/MXfka4dtEv6hp0P2DmLjyD/i9iV2pkew==
X-Received: by 2002:a17:902:d2d1:b0:20b:9547:9b2d with SMTP id
 d9443c01a7336-20bfde55510mr91868295ad.2.1728141972285; 
 Sat, 05 Oct 2024 08:26:12 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 20/20] target/arm: Fix alignment fault priority in
 get_phys_addr_lpae
Date: Sat,  5 Oct 2024 08:25:51 -0700
Message-ID: <20241005152551.307923-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Now that we have the MemOp for the access, we can order
the alignment fault caused by memory type before the
permission fault for the page.

For subsequent page hits, permission and stage 2 checks
are known to pass, and so the TLB_CHECK_ALIGNED fault
raised in generic code is not mis-ordered.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 49 +++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0a1a820362..50aa5e338c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2129,6 +2129,34 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         device = S1_attrs_are_device(result->cacheattrs.attrs);
     }
 
+    /*
+     * Enable alignment checks on Device memory.
+     *
+     * Per R_XCHFJ, the correct ordering for alignment, permission,
+     * and stage 2 faults is:
+     *    - Alignment fault caused by the memory type
+     *    - Permission fault
+     *    - A stage 2 fault on the memory access
+     * Perform the alignment check now, so that we recognize it in
+     * the correct order.  Set TLB_CHECK_ALIGNED so that any subsequent
+     * softmmu tlb hit will also check the alignment.
+     *
+     * In v7, for a CPU without the Virtualization Extensions this
+     * access is UNPREDICTABLE; we choose to make it take the alignment
+     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
+     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
+     */
+    if (device) {
+        unsigned a_bits = memop_atomicity_bits(memop);
+        if (address & ((1 << a_bits) - 1)) {
+            fi->type = ARMFault_Alignment;
+            goto do_fault;
+        }
+        result->f.tlb_fill_flags = TLB_CHECK_ALIGNED;
+    } else {
+        result->f.tlb_fill_flags = 0;
+    }
+
     if (!(result->f.prot & (1 << access_type))) {
         fi->type = ARMFault_Permission;
         goto do_fault;
@@ -2156,27 +2184,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     result->f.attrs.space = out_space;
     result->f.attrs.secure = arm_space_is_secure(out_space);
 
-    /*
-     * Enable alignment checks on Device memory.
-     *
-     * Per R_XCHFJ, this check is mis-ordered. The correct ordering
-     * for alignment, permission, and stage 2 faults should be:
-     *    - Alignment fault caused by the memory type
-     *    - Permission fault
-     *    - A stage 2 fault on the memory access
-     * but due to the way the TCG softmmu TLB operates, we will have
-     * implicitly done the permission check and the stage2 lookup in
-     * finding the TLB entry, so the alignment check cannot be done sooner.
-     *
-     * In v7, for a CPU without the Virtualization Extensions this
-     * access is UNPREDICTABLE; we choose to make it take the alignment
-     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
-     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
-     */
-    if (device) {
-        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
-    }
-
     /*
      * For FEAT_LPA2 and effective DS, the SH field in the attributes
      * was re-purposed for output address bits.  The SH attribute in
-- 
2.43.0


