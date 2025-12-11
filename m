Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC44D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjgi-000373-Mi; Thu, 11 Dec 2025 11:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgh-00036T-5q
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:43 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgf-0003vb-Pt
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-29845b06dd2so3362335ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471120; x=1766075920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wUNshzy7TiVfB+mByD3i/H6Ikd2eT08vib1DJFSU7w=;
 b=AVPC3EoM5Guw6zvFZaYVJKpqh70qyvHyuEVlJnIkHmdeADOeREeZkVSi89HuVurTNc
 j6yXJcSmp+NmjwnN0CGsfGyANDTnLhIBFP4fCCqhFQyZ4GlIQ16Vns1zPrp8R//76s8g
 Bwh2FwxRhvD2b2kukpvg616F8GaZH5TItzYU2DEqza5JO6urqwvzxHcFciP/SaajHF4C
 MKmYBLEgoAuLFnWSm/a3x/CV2tmrcZBtHZ6aTJVoC85xXQgSU9ZtRdE5y3dN4Il4NIAD
 PRj7YWn9alA9xj6P965kzEVX+Osq3yYr6sLvbJy7F1m6z+Ep85pghXFJLj7hfZx3jsWP
 HvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471120; x=1766075920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8wUNshzy7TiVfB+mByD3i/H6Ikd2eT08vib1DJFSU7w=;
 b=C+w+tN5rFpA07gh20HuC94k6HlWg6J4GmUMz/up4j7nwOxXSLNlvI5b/y/VaTC4r3D
 j2yAzyVREFqQRekdHfaR10FR8YjK737NmhXlpRFhy35ydbWgaxfDhQdPL9Ri/oqxI2e0
 sIw/sCGgf+QM6Plz1p5F8GGElJbpI0ogxyBu7MgE9fZVDL+HpduoL0mYP1bpdikniPTJ
 7lV6HphpBptj8Hg44UBG8/fVQoJ5HDEaJbKge3KK5glZ15WtOmf/YYXE/Duz0e+qBW/c
 LEQeguhsxPf7W995xkom7/t0zIpvBR/WnbSE/sOobT2J9UwlpfQq/He64eJFUf4mdfds
 Bq6g==
X-Gm-Message-State: AOJu0YyMRg5lFxIZCaD8xqFA/syFdtDkXPtHGblHFuqDdaydv4rz7QmA
 1PJPJl3jGUfDp4H2FUb/Q4u8WPWZH1P1HbDdFekD3zk7i+phe8fMFOSaGmCjzop/o3oJsU1YVs9
 JQsnA8fBZXT8HTfr+87LR715KpAeZXxoxa182zdGDlQ4ckNuxEDgUA5985wmmQbi3FUTAoTmr0y
 ErlNrQsm6SDQoSQ4bGhZEJMWfPsTf3qbFD3xcvJ7VEmjI=
X-Gm-Gg: AY/fxX7qTIwIl9ru2yTaCCEhj99PGorqkUCuFLCcQ0D1QPz2Wl5W6gDQV5m1IEsMUiq
 Ovbp8bSCbJk2ACtvutIMH2bwcQ7C4zki203n8ZeZHBI9y2iupXyq5+H4F1fbnpw92mmGwHmg2e3
 mMQxoOV4SxKWZxeQGyJLmZYbL9J+FGVMQ7/TFuf5UMFZfZiJxN3AiwTsgGAwYXaTg16+cM9C8ZH
 yQrrWVMKin2GL959KFvSTgs7FfhX0EOqhYBud40GSG0rDiVlqEAWNCOgL1J5dV9Wf4470CZopKy
 clw9Ux0vLvOrU6ENqyGy4ywIMYHLMygp52Mxmn7FEbkYsCv33/k6agcWiXBGwih3eEK2hRaydf9
 JFWX9hpxkDgnTPz0+AqSJw/5Mep/RwxyHhN593aczpDQeFKQY93macpFkKrYFdXngXJTwxfV8nG
 N3BHnHmo5KU7wBHsKtyNjkiv1rDOSEFDsWOjm82Ob3o50RXOqq
X-Google-Smtp-Source: AGHT+IGSsHxPXGNLabwg+xZjalN6xJlpeGIGpuODBIb9IMh3sO0GuZUgbmNjjCYzZ+7kdpuJGRuk2A==
X-Received: by 2002:a17:903:1987:b0:295:6d30:e268 with SMTP id
 d9443c01a7336-29ec27f12f2mr73100675ad.59.1765471119940; 
 Thu, 11 Dec 2025 08:38:39 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:39 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 4/6] target/riscv: Fix pointer masking for virtual-machine
 load/store insns
Date: Fri, 12 Dec 2025 00:38:23 +0800
Message-ID: <20251211163826.3998266-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
References: <20251211163826.3998266-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

The effective privilege of explicit memory accesses made by
virtual-machine load/store instructions (HLV.* and HSV.*) is controlled
by hstatus.SPVP. mstatus.MPRV does not affect these virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_helper.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4347153d794..8f2a7234184 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -217,16 +217,23 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode = cpu_address_mode(env);
+    int priv_mode;
+
+    if (!riscv_cpu_cfg(env)->ext_ssnpm ||
+        get_field(env->mstatus, MSTATUS_MXR) ||
+        get_field(env->vsstatus, MSTATUS_MXR)) {
+        return PMM_FIELD_DISABLED;
+    }
+
+    priv_mode = get_field(env->hstatus, HSTATUS_SPVP);
 
-    if (priv_mode == PRV_U) {
-        return get_field(env->hstatus, HSTATUS_HUPMM);
+    if (priv_mode == PRV_S) {
+        /* Effective privilege mode: VS */
+        return get_field(env->henvcfg, HENVCFG_PMM);
     } else {
-        if (get_field(env->hstatus, HSTATUS_SPVP)) {
-            return get_field(env->henvcfg, HENVCFG_PMM);
-        } else {
-            return get_field(env->senvcfg, SENVCFG_PMM);
-        }
+        /* Effective privilege mode: VU */
+        return (env->priv == PRV_U) ? get_field(env->hstatus, HSTATUS_HUPMM) :
+                                      get_field(env->senvcfg, SENVCFG_PMM);
     }
 #else
     return PMM_FIELD_DISABLED;
-- 
2.43.0


