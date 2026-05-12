Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E0FCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZc-0000Jc-R5; Tue, 12 May 2026 02:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZ1-0007bI-JO
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYx-0007MN-7I
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so54044595e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567148; x=1779171948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C+xxVR8pXwXMffQeINHKMkFw5XP/nHWRIy9zl0uo9xU=;
 b=slVHwqsWUmj9THh/l39HZgO1WEjmOooggFSpFjGpJzrIE0GwTFP1OuKpmq2B3eGB5k
 rAkEw9329esXPxAbau/6DztjC7GygBZZndnZ3rbJ+JwBESqjglOgZCyYTvMcR1tATQpL
 lnMR9vx2GRHy1465KCj1Ht0VRj5+P4lfaR50Kf9MIpvZZZ2OGa3QM+ILWq1VlbNdTFcU
 Xj7PBcKkhXxJakTKDrfcWcjRJ6+e2DrtKdbjCijImJ9MAgomADb9VBhf/MsJrDX5xDSH
 4OTLRpwbQBnWbu8CRLSDCtEzS9tAV889zv3+O03i8obMpWgAz7LAfBqhU7GJtP9qhnDJ
 IFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567148; x=1779171948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C+xxVR8pXwXMffQeINHKMkFw5XP/nHWRIy9zl0uo9xU=;
 b=kzlsAdHiwlkPx1swlHsuuWElC2zqf/HwKSpjxY2G742gWO1hMvUzvrJB1tPzwXprXi
 nn1ULy6Oc/Zl5ObBZDztKHHRjlpNu9xT6Vem+6ISkwTOZwEIs8c0qNwjHSbIhw9apz8x
 crbX5RbiI3r2RhTW0kwwyDGE3nhrdn+4l8EIE9iR7UMN/pQ7/POVdrr09szL3bpfKpBP
 9Vc1g+QHeebVbjJMyrGa/181+/speHphhd1iq8tsJO82P6yBAO7aQM9R1RYIV4Qsvo+y
 6EvUcFXMApD90BjtgYH20qPon+ChZ6m5b4Gifh2gKOptOK5QM2WK/yVQJKyPWyz0gn+i
 roYg==
X-Gm-Message-State: AOJu0YwHPmNO3kgwiBYWgllQTva3xSk7/Q6Le5Sdo4UAeo22pOGjvEts
 I5uKskOMRjHBZw9xt5m0hH31Z1+cGUrLWu1u2ay2BCPfgagHJ+JcovvKMtNXxYdhyxdTaXdrqvh
 k13a4hF4=
X-Gm-Gg: Acq92OG4oD0K8v7agubZ9ijnyEdMQx+MRte2f+4ksqbSOnB10EmO/N148INt6lBmTFQ
 X2DCE1RbaLBSU+c8wRU9NGLRS9MJD3LCbv3yjWAWGAcofL/o5ClpIDP39M+KdVlbPh1MishctX9
 D5AE8I/AfxyGygH+MSPY8hVcCNNqUyDS82JYRHLmXVE53M1gqce8m7mFAa0Q2sQkLbX1q7efmdb
 pgNxBWpo0mgkt9/A4iKdyL8xkZtu4Z6d3z/huS8s69rDBBVh5DOnCYN7IZHEWvG0y/61B6korS/
 qGGpLbFmK6QDdhOga3opPKkk2FOqWsk+g7hRFgn7MJZpm+EULOusU5jEGZ3Tk3Q5wF+p8xfqGKF
 yaSS3c9hBXXOCZtj6uZD61PxWWPPmb3vWEeqVaVqW5nPiBzvsn16aaS+dKMiCFd+bgObtbM6q/9
 umcHUpw0SOP1YX8200N8I0d/p/B9EKJs87e2aAi30nxuPTefeNp8+e1erF2dUk+40Dt44l8lqU
X-Received: by 2002:a05:600c:b99:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48e8fe4b10amr19557615e9.6.1778567148262; 
 Mon, 11 May 2026 23:25:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e908d2c0esm21086865e9.13.2026.05.11.23.25.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] Remove cpu_get_phys_addr_debug() and
 cpu_get_phys_addr_attrs_debug()
Date: Tue, 12 May 2026 08:21:35 +0200
Message-ID: <20260512062142.67998-35-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All the callers of cpu_get_phys_addr_debug() and
cpu_get_phys_addr_attrs_debug() have now been updated to use
cpu_translate_for_debug(), so we can remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-26-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 34 ----------------------------------
 hw/core/cpu-system.c  | 20 --------------------
 2 files changed, 54 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a7256aeb9dc..59d601465b4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -738,40 +738,6 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-/**
- * cpu_get_phys_addr_attrs_debug:
- * @cpu: The CPU to use for the virtual-to-physical translation
- * @addr: The virtual address.
- * @attrs: Updated on return with the memory transaction attributes to use
- *         for this access.
- *
- * Obtains the physical address corresponding to a virtual one, together
- * with the corresponding memory transaction attributes to use for the access.
- * Use it only for debugging because no protection checks are done.
- *
- * The address need not be page-aligned; the returned address will
- * be the physical address corresponding to that virtual address.
- *
- * Returns: Corresponding physical page address or -1 if no page found.
- */
-hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                     MemTxAttrs *attrs);
-
-/**
- * cpu_get_phys_addr_debug:
- * @cpu: The CPU to use for the virtual-to-physical translation
- * @addr: The virtual address.
- *
- * Obtains the physical address corresponding to a virtual one.
- * Use it only for debugging because no protection checks are done.
- *
- * The address need not be page-aligned; the returned address will
- * be the physical address corresponding to that virtual address.
- *
- * Returns: Corresponding physical address, or -1 if no page found.
- */
-hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-
 /**
  * TranslateForDebugResult: gives result of cpu_translate_for_debug()
  *
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 954b81931d8..16f048c9565 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -87,26 +87,6 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
     }
 }
 
-hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                     MemTxAttrs *attrs)
-{
-    TranslateForDebugResult result;
-
-    if (!cpu_translate_for_debug(cpu, addr, &result)) {
-        return -1;
-    }
-
-    *attrs = result.attrs;
-    return result.physaddr;
-}
-
-hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
-{
-    MemTxAttrs attrs = {};
-
-    return cpu_get_phys_addr_attrs_debug(cpu, addr, &attrs);
-}
-
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 {
     int ret = 0;
-- 
2.53.0


