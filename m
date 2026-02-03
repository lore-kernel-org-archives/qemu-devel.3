Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E0BE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzu-000777-CQ; Tue, 03 Feb 2026 10:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzo-00071V-N3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzl-0002Oz-JJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:15 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5968891f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131232; x=1770736032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bjhzaEBGyHaRFQtACgFvrwQWK/lqJCAf9i6R698ij38=;
 b=awJ/fX9PIPwIeDIJiKtCcayQSn2HMv66NP72PTJ9jyBQijH5mHTHN3J8ZQXjHIgGFp
 c6OUde9ZczHSQ2oJSpBWt47/aSFB7WhHkgbeIPu1DEGNo42LEbS4qFLf3m5m5xAXElnx
 EBqRUk7vlztsJOKuJP3EykF8ATc89Ds7RpeBZwPL0OkSM/06QWJoVT15SzSoEWz/jqBn
 DoTeiAjtLZgstvcxuom8HOvEpHg7Ro2j5WNdGyG1J6Qm08oKVVHK2vPMvJ1eAl04/BPU
 oX2RLffpkly5YleUx8qXyNXtcZteUrHBJuOQoN7Kl+nEX9MOMEA2kZ2oVPvNEUv9BZjp
 oqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131232; x=1770736032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bjhzaEBGyHaRFQtACgFvrwQWK/lqJCAf9i6R698ij38=;
 b=VdxjrVL0jEaXeqh8rKdkayx7iOScFf5B54zrz/z0u8/89KL/rW2pbUEvmJJByPitU9
 lIqj2Qx0XSl1GSBkH3xAxogW8M6RpavBvHBcpgQNBuq47VtwXyohhgR0mbQOig6hfLHG
 7Hrd4Y3MlaTABO6csXZ/0hQPImEdQRbbLhRTE4vVhCU56BatHg6zpZ3bWMnDnPA153Zg
 Dq2MdDOkfIx+YQ07VqBJRMzJ9SwqZREzylc/pMK2eUW1c4SVSEXLdzkORPFFOhko5LRq
 dXyEbKiS/5X2RfRSO21qZR7MhDgTqBC9MkgQc9uYJ0EuAudRhQsYhylC0agcJhJQ13Jp
 OPPg==
X-Gm-Message-State: AOJu0YyjIwG16wcX9fU3t9YP6QmkOnAPMNcGDfsEcELGjZ8Nu2sWPf2R
 GJbMYQ5d8n5ysNVzVfJGxmR5VU/APnlSrbqxIBnMNb2RmuUpvvdiEW6qwobeFMcw5PrSweE7eBD
 KBzfdX/M=
X-Gm-Gg: AZuq6aLNEdboAOr2WfsvAjZ8aUMDYuShaLZ4gVaYJQ7ki0yy3XTDUsZtiZwBjVK5QwE
 Qp9F4EXxPy3f6ynENsfbqHXj8E7CAt3dTx0DSY4MxHU966P0lAyqqltn8c0BnBVUU8kWfYigIOQ
 iF1lBhE5PMJpIZqXje/UpO7i5SrHCfvmtbAjx8L9jYZau7kBxMpkLejW2YVOBg/fkO9x2FHRHAV
 DdKm5VzGYwEV2XSqq3ZHv9AhGzicVp+LDz1nDa+IhnM7Gs3/E/d3hK/T3BYWstAO+GB708YGzZt
 92wGd26MrWqVanNacFYC+L5tmrPmcTLUJ8LYPlVjitRgUB8tAzoUvuOsCBwArxDEzkP+jL+QyAQ
 nVJm29bm8QwPaBqm+h2xfLiEfci2HNy1AAGEPoe5i9eCGQgw0HloMxluwJo9UkX0c5/h/hoWCD1
 9ZdXvW2upU+XHfRX3SnN5Dtg4EP8NFIkdTFTltScxabdOQaK7IMpqRqguvo2jO
X-Received: by 2002:a5d:584d:0:b0:435:a2f8:1533 with SMTP id
 ffacd0b85a97d-435f3abc7ccmr24715415f8f.52.1770131231598; 
 Tue, 03 Feb 2026 07:07:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf16sm52975072f8f.22.2026.02.03.07.07.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/30] target/alpha: Remove target_ulong uses in
 get_physical_address()
Date: Tue,  3 Feb 2026 16:04:27 +0100
Message-ID: <20260203150436.71907-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

%addr is a virtual address, so use the 'vaddr' type.
%pphys is a pointer to a physical address, so use the 'hwaddr' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202234550.34156-7-philmd@linaro.org>
---
 target/alpha/helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index d6200d101cc..179dc2dc7ae 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -165,14 +165,14 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
 }
 #else
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
-static int get_physical_address(CPUAlphaState *env, target_ulong addr,
+static int get_physical_address(CPUAlphaState *env, vaddr addr,
                                 int prot_need, int mmu_idx,
-                                target_ulong *pphys, int *pprot)
+                                hwaddr *pphys, int *pprot)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
     target_long saddr = addr;
-    target_ulong phys = 0;
+    hwaddr phys = 0;
     uint64_t L1pte, L2pte, L3pte;
     uint64_t pt;
     uint16_t index;
@@ -297,7 +297,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    target_ulong phys;
+    hwaddr phys;
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
@@ -309,7 +309,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                         bool probe, uintptr_t retaddr)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong phys;
+    hwaddr phys;
     int prot, fail;
 
     fail = get_physical_address(env, addr, 1 << access_type,
-- 
2.52.0


