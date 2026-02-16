Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8180AE63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXc-0002Yb-Pi; Sun, 15 Feb 2026 22:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXb-0002Xz-DY
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:55 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXa-0002Qx-2Q
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:55 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ab232cc803so12309515ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213493; x=1771818293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P+JiQhGFIecDO5oCQASMdaCHlvyW+snKBIRmy6tjygk=;
 b=Z8T1cD1hwF/iSdt0aCWiTc3PJf2XdQ7JZ2IhtfMRy3Op7w+YSrsEQpPMAoMrFgIu47
 2LZbofDUAtHWfhRCWGaHWrxVUy/JNvGipckEeyOw8hhyu+Y6B551oVMHh2+PJru/m9Nm
 OSd7OG0u4OIBQR7QC0DrqG3ccHeIW66ed8gR85PKWMJYEAGNg2QiZisL1GQjg0BIc4H7
 PoG/2xk8WXCHgHRMtVyVjcDrJh33j+6Ue+IrmI8+BaAntOhzsrqnHDLfs9D87U5C7iTL
 /BsPffkGCdDpqQvSlSfg4/hEyabDHAm8JHd9JCk2vLlVhF37OHwRNrOz2HkSgJBvsKrf
 /2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213493; x=1771818293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P+JiQhGFIecDO5oCQASMdaCHlvyW+snKBIRmy6tjygk=;
 b=g/XEdma+Pu9OfIqCtaBdSlQc3dHyNGIVKJrgmJTwHOgZpS+hJdWc3Af5yEHB4UQcjS
 ISvcskvSGhmNcpDopHnlOqkfz+my8fR1WMv36Az9AX2T113j9vSOW/FkiEzkMUbiS+r4
 WqyEoLLc235Sxpnr9QGfoyRxjyqdgqJRV3/zoz+ZO+fXUJTiJKPIpXWKRl+/gTEt3QnT
 VuqwmTq+pPP18lF+L+BXTvlowZWKHfpOCRQUfBk0tKJ1+Rdya38klNr7EGRcOnQFoYMz
 AKRBgCcYlIYV6oObEvZZ/IwBrV5UouFOwOPo2cOJDKHo1YrRcu6teD+f1KaTM8aTJTbx
 lVXw==
X-Gm-Message-State: AOJu0YyO81P3XwujxfueYzQRbCAVbcYOXB3IynXDHhAmNF1CVRf70QbQ
 THG5r29uCvMT+Plqhl5QY69h7uZRVsRxgiTrZkzRFeyjlAgOhTjzob0crGX78f8Fgw+wIiSslYO
 RbunZfsk=
X-Gm-Gg: AZuq6aJZFubisdLuhV26A6NQWYXEJnocO6qW+bjvFl5W3rCs5IK1n48Qvk2UpwmE+Ub
 RwRp1gdcOskfwsg+DinhwX1Hp1M6Wlj4AOERzv8k6yXt1DuaIGx/Q094ydD4z31h0KliTtILavz
 XKaxmOJs8tLcDQDeBC7vIqK937FM6UbJiCNayqCiK/snoypkhKinT541ZbvMRh97Hp5rdsdtkwE
 y4bpS4/zAt46FMk4CB7XKKNGpvm/HvPVqvSyE1xiaaqIPFtVbXEmiab2QZv7kSLGTgbqdukCe4d
 efCvCyjiawcAmwgH/OEh3No3LvM1vgMr10CJShbtQT8JpEuR6UTmRK5pAU3nKI7EfhjhMyOT5M3
 RVQl6jnHFdn1y8ZJUC9HEzSTHbgSKLCaz4X4QFsr4wMdmeDq67enudOSBvL5GVZ/6wgoBxwqzO2
 KDvZhhbETtwa3vRLfmZIPg/HL8DD3Lt+uN
X-Received: by 2002:a17:903:38cd:b0:2a0:c1e4:e25 with SMTP id
 d9443c01a7336-2ad1759ac22mr84887255ad.54.1771213492650; 
 Sun, 15 Feb 2026 19:44:52 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/13] target/arm: Remove kvm test in arm_set_pmu
Date: Mon, 16 Feb 2026 13:44:26 +1000
Message-ID: <20260216034432.23912-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

In kvm_arm_get_host_cpu_features, we only set ARM_FEATURE_PMU if
kvm_arm_pmu_supported.  In arm_cpu_post_init we only register the
"pmu" property if ARM_FEATURE_PMU.  Therefore, if kvm is enabled,
we can only arrive in arm_set_pmu if kvm_arm_pmu_supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7542444b18..16ce5f300d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1218,10 +1218,6 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     ARMCPU *cpu = ARM_CPU(obj);
 
     if (value) {
-        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
-            error_setg(errp, "'pmu' feature not supported by KVM on this host");
-            return;
-        }
         set_feature(&cpu->env, ARM_FEATURE_PMU);
     } else {
         unset_feature(&cpu->env, ARM_FEATURE_PMU);
-- 
2.43.0


