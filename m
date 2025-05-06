Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33A9C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWq-0008Oe-Nc; Tue, 06 May 2025 10:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV6-0001TO-PW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV3-00026D-Nu
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so37387805e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542544; x=1747147344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jAC8SyoVpYgwD+G/npRRAIEZQ/u3a4tNRq3WItpxT5Q=;
 b=zaycUpFysukv4ZlV95HFtBWwzecy/JCeLPgwZZ9hqeUjeGhvO2/w0KhGAfcWfUD72z
 4iK9wx8QfDp1vbr7LPMKp4CGECm0R5twWYkoc6f5aZ3DR9qnqMtqdusIRvoeAt0QTDxZ
 QO5aav9qYNoyhyD2ZIjD0Hdd/G1W4ps3MNiHuDcNG8d21RCn4+pE50YPSfEnH3dNw58f
 965XC/HMceGbB2GCJC47xAp7VZRJ4p9cvuCbFlcviasPt0WU3wuHdmMfrrqzDp5VuCHc
 j94dZkDFAnhVLEHv7I9eNA6uskiIef83vuUk862+ZXi+rGcalb/tpHkAI37OVSp6kE/c
 PupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542544; x=1747147344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAC8SyoVpYgwD+G/npRRAIEZQ/u3a4tNRq3WItpxT5Q=;
 b=JSRP6qwBryS67kDBHyGM/dXwmuLrgb+RyPzZUFhl5p9Eyz2UyoT31NdcaY+W/AYtSI
 QUAUcgkEMIz4Hm4zxYZZXLrVmwfYcXHw2Ca/E5xsGudNE75n2biYb8y1UDdO91PA8JlC
 JydFcpS+6fSMc65aArWyk4clqw1XSIDlL7cNY5W+jRaxa/DIpbuO3Yh6BGWX/PB4c8LQ
 /kkPkyIPNC8IHQR5l+ejWw1E61Yodm+VM7mvgrHiCx1G8tr3IYc6DB895pw4AmpQfDaR
 Hu55Nf18NcvLk3hf0Pfl3EXS3Ac5XIQ33AM9iWmI0lub3cbigGCDiyY6I7wM0cbtWl/1
 gsPw==
X-Gm-Message-State: AOJu0YzisZZpoTP31OOZPa0DAeWVEnvprAowId3TVXd+B1pdpbE3om67
 pvelDn4aURd8RmIwFkKCNgrwHAQBlyVYrihioZxBbmp0ITdtHuUwX/2QzhrI6wYG1qypG8ZlHub
 U
X-Gm-Gg: ASbGncuHx/SJAs/JgAvwku/gjOAZjLi8CKDJvviVUBrY8Wbkyq53Iop7PEnIfVTrkgc
 Io5Mw2nzfRmTnVqwN+K1UPhWbyLREE9QL7gABtNbhNMJeqwqNBV0RxypAo3cYWcPgBSaLX53HUj
 pwoQEdi3zygu6pavWdJaj2YNOH9llT4UVhwI58zgwiby/GHeaHOPoiU9zxsxGrtKWvRsscAr6KT
 XaDsFbMWi1lpRhSK2zQ3XfkP346lwXPYOteR3X0bPz/QsuUN6jym2NTnd/6Mfhr67tD6I5pcD56
 IEprU3qL8IND2XZkG8FNC9YqavFyeaybr7toczkeZF/IqDc=
X-Google-Smtp-Source: AGHT+IFgbx18FjmrywAIAuk0sIxiJKBC6aQdbpHS7futK1xVhkrKFL4FS4c0NeW2LNydHf6j7Il8PA==
X-Received: by 2002:a05:600d:1c:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-441c4933d05mr107313235e9.31.1746542544138; 
 Tue, 06 May 2025 07:42:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] target/arm/ptw: extract arm_cpu_get_phys_page
Date: Tue,  6 May 2025 15:41:48 +0100
Message-ID: <20250506144214.1221450-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allow to call that function easily several times in next commit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250414153027.1486719-4-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0ae9c5a3f49..3e00e4a8bb4 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3630,23 +3630,17 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
                              memop, result, fi);
 }
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
-                                         MemTxAttrs *attrs)
+static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
+                                    MemTxAttrs *attrs, ARMMMUIdx mmu_idx)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    ARMSecuritySpace ss = arm_mmu_idx_to_security_space(env, mmu_idx);
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
-        .in_space = ss,
+        .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool ret;
-
-    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
+    bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
@@ -3654,3 +3648,13 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     }
     return res.f.phys_addr;
 }
+
+hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+                                         MemTxAttrs *attrs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+
+    return arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+}
-- 
2.43.0


