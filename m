Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25C2CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 12:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNs6k-000649-Mb; Fri, 15 May 2026 08:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6j-00063P-33
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6h-0000VU-BQ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso78869775e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778849854; x=1779454654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuPFKRaiB2fHObLjLFJOcy++OZ2S1wxCfyuKUlasefg=;
 b=mdyGYS52/J39fIaFwU/j6OKxyWVGV1J9Y10ahn/Am/ASd2QwkUJivXfrGbUth2Ef4Y
 eGb8i2NUAVvOQbm2tSZCJD1uIIpkCQptgpWlLEpqfA245wqz+Hj0e8/NI9Y7Rz28C/aG
 +qnDCl1KzVl5m6Ak4Hg3yUaQzbgJo7DOINGYlhcal8UfJdV45RrhEipYWo8+MUWyFPW1
 bNU04G68FW5FjFN7DzM5Z1mUVKOGs9bmZujhP0WGeeyEW779czpFbb1crrzJmLR2Ricl
 wYq59MmARKPK2ifJ08utYzMR8a5GUxxhRBjYY0vIFyDOrmhHvhoDdaoSopWI1HmB5Zgn
 IBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849854; x=1779454654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JuPFKRaiB2fHObLjLFJOcy++OZ2S1wxCfyuKUlasefg=;
 b=eak4az0hMVLe5HQWWz5bxrtDYYTNPqXCdlXWAg2d5B9wT5P1Mcm6aVRWvoYP3c2hTK
 dU7InU9i+57zEPNFvXcAy7cLk3zAczbmZ5b8eFzy9VAux/fT3qLoH6DHmlnWNmPtVwow
 fI5q+e0jLQ50li3HAKJOO013T14kBMIEAequ9V6utlwlO0fZ9RBbh3CU9CJOUrgxiJ5h
 GmFLknhgxVkB6Mn5e7dtFQrioQmZjk+uXAXJcQZHlOh8f/z3a+oledjA5mI6Yo2obyxv
 spMlBut3CytEHjcFTp/L3o2+q2qRmx3l7yUVlGdeIsqwiXqY26PAGYAmU+FYtvUbVlFF
 c56g==
X-Gm-Message-State: AOJu0Yx/+F/xpIivAupf5oWdRqRXIISHgT5eg3Gfo3cnFTmRYIgbuvAL
 WUMUhkLs2lVk18B7/OJtcequWo5QgPf06iSoMR3dIumAtelsFiglq+EM2x+ueX+49jsSG8WNyh1
 uDlJD
X-Gm-Gg: Acq92OHKzxCcU+DUuHCtTxAVZRr72/47UKgRcNHxwLpYRAy/MaSa3eGLYm8Fe1ogjU2
 J41c+4k6r3hugstfxPsl+8PHzLDpDe7VMrmJ8Fr1xN7Qyec+6LckWSPMBMI0szMdXuaQSGZG9fi
 hiCO58o1TmLhJn66jy5sK3uWaA0XMbuxGUiQUBlmQ38/ItbrPhi7f1elevv1EMbKJ12TVnUDOVE
 7d/jNBfyP3JCWCprjjMH5lHUH8GEMyM/gymtrPmw3Kf4KpKQhIH7Zy2AWf6Lg/THnnlXPvvEbHD
 eB9QO8NDkEYE7kzEWyyKV34IVpUkYR2yjB0/CyJ0h2gG6wyK/+u+bb35BTjdde4KWPEWagKdB4b
 yAKyWSmRCfuCpFmskkTv1KMagjLCt6Qcvwxb1YBOQXPuZn5x6XcdzeTYU8rgU+VfdwyR9lLGqxy
 PVJOyo8soOZc+fUJHvnmPBCyOdTF/Iu6to+x0xROyUu4pVfUpmNJSFszjENcdURdoU+IM8xOTdj
 IqUyg50WQj6JYOE3M8uLukDYcDsmvs=
X-Received: by 2002:a05:600c:8184:b0:48f:d1b8:9aa5 with SMTP id
 5b1f17b1804b1-48fe60ecd7dmr50984535e9.8.1778849853832; 
 Fri, 15 May 2026 05:57:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm57526515e9.2.2026.05.15.05.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:57:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 3/3] hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug
Date: Fri, 15 May 2026 13:57:27 +0100
Message-ID: <20260515125727.349675-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515125727.349675-1-peter.maydell@linaro.org>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

No targets use the SysemuCPUOps::get_phys_addr_attrs_debug method
any more, so we can remove it, together with the handling of it
in cpu_translate_for_debug().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/cpu-system.c             | 11 ++---------
 include/hw/core/sysemu-cpu-ops.h | 14 --------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 16f048c956..14eb4ed87f 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -63,15 +63,8 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
         return cpu->cc->sysemu_ops->translate_for_debug(cpu, addr, result);
     } else {
         /* Fallbacks for CPUs which don't implement translate_for_debug */
-        if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
-            result->physaddr =
-                cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
-                                                               &result->attrs);
-        } else {
-            result->physaddr
-                = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
-            result->attrs = MEMTXATTRS_UNSPECIFIED;
-        }
+        result->physaddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
+        result->attrs = MEMTXATTRS_UNSPECIFIED;
         if (result->physaddr == -1) {
             return false;
         }
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 441901fae8..8be6a84bd5 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -39,20 +39,6 @@ typedef struct SysemuCPUOps {
      * for a complete target page or they use memory attributes).
      */
     hwaddr (*get_phys_addr_debug)(CPUState *cpu, vaddr addr);
-    /**
-     * @get_phys_addr_attrs_debug: Callback for obtaining a physical address
-     *       and the associated memory transaction attributes to use for the
-     *       access.
-     *
-     * This must be able to handle a non-page-aligned address, and will
-     * return the physical address corresponding to that address.
-     *
-     * CPUs should prefer to implement translate_for_debug instead of
-     * this (and must do so if their translations are not always valid
-     * for a complete target page).
-     */
-    hwaddr (*get_phys_addr_attrs_debug)(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
     /**
      * @translate_for_debug: Callback for translating a virtual address into
      * a physical address for debug purposes.
-- 
2.43.0


