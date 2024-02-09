Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F74C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOd1-0006ZW-Cp; Fri, 09 Feb 2024 06:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcT-0005yX-KB
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:34 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcR-0000ku-Vy
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:33 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6daf694b439so672468b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476430; x=1708081230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvQUwsICpZcQeI5Pjh1leKe5Q1wcm33hOnjqIx059ZI=;
 b=aoueqetaqbr/1uoF0zNRrwwangvKHP3IhsXwcIIyVXBn7oH4SLzPUrgtkeVy7ti2Cv
 P4p5oEYZNBugl5+goWVfkhyhSE8pP2LBa7lc0QuvdOmd3Qmh0CV+FfZFKgPSqKJBEiVo
 jLp0DDWd8CwMbma19lInYpD2fuAiKgMiJ1gVBOUaTLguFpdCF3EaafcoX2prd1Nx5nwx
 NLRk4gIrHa/QJNTyUBPb7ovrAEWgAorE0KuGeyrJ0iYqXW6bWYeJukLGOjcqghCMCe2s
 nhfI0RCO5AUcC3bh+zWJkZvl01UKWGb+Kl81yxGEFBRVVS0jhI9gdsh93QBauqUFTrdj
 UiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476430; x=1708081230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvQUwsICpZcQeI5Pjh1leKe5Q1wcm33hOnjqIx059ZI=;
 b=m/wFz1qltLc4HWu4PSmkh1ipxlpV1ZFnM/HDfvWVbgZWvADWb57masxZrDfsKDieZm
 5Nz42svM0442p7gTUycbMoOhhWN6oYo7deOSi/S7bMXXKm9ZRmCRs7SnEG3KNUvCdgD+
 gOs+fTGfEJTFElT9T47+yajXZ9qY+brpQNFbKHcqX0jgoYoJLvGzZ8WX7tY6QM23cf5P
 m42r9Ihjk5CdURA3xzwwhO9qSFhKDrw4d0p3V+BLd4x8Qp/Ad1rFAq+iMyTIfoCe5DkA
 bmX15IcW87m6fiZBhQvN9GFu2dOtyvrHBztk3eOHeJppRFnrYmPzix6YbOqv2XfmMCPq
 v3uw==
X-Gm-Message-State: AOJu0YzXYFpkunMz7Py/DbEJe+SN2V4IcF1enrTU3i9D7dOfW5dfvhv7
 Jumoatc9Yd9HkHL4saBHEw4+FVO5HlS7LnIHvoTOa+4f9GjRSxdM2xwyI7UfR8iKzQ==
X-Google-Smtp-Source: AGHT+IFGJ9hi8QC8nI6UEMsH9fPCxHS6Sc8oQl/O04/haj/l8CjFx/7AdK8MMCCanvb4qtakB6ijTg==
X-Received: by 2002:a05:6a20:d389:b0:19e:9da6:c73b with SMTP id
 iq9-20020a056a20d38900b0019e9da6c73bmr1642074pzb.8.1707476429746; 
 Fri, 09 Feb 2024 03:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWudzVqydjoODRkYKeNPJl9Bq4LF1XeP6gUT1LH5xUU5IOYgwlJSMY9y6iaS4caOfnDNFMZCk3Tvn/bOhhJi/WZde+CIMDZNb3ef6aITINlD1l663bXAKxt+0E5ScJGLGIraeZDfHPqssvd75l8RtP9rNxsYBkkboRWSzorbWsym0eR9CzDr+ZHrYCXZUe9OeVmt/yADpqarBaocA==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/61] target/riscv: Remove misa_mxl validation
Date: Fri,  9 Feb 2024 20:57:50 +1000
Message-ID: <20240209105813.3590056-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It is initialized with a simple assignment and there is little room for
error. In fact, the validation is even more complex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240203-riscv-v11-1-a23f4848a628@daynix.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5618769a00..6574028414 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -268,7 +268,7 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
@@ -288,11 +288,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     default:
         g_assert_not_reached();
     }
-
-    if (env->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
 }
 
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
@@ -908,7 +903,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    Error *local_err = NULL;
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -917,14 +911,11 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
 
     CPU(cs)->tcg_cflags |= CF_PCREL;
 
-- 
2.43.0


