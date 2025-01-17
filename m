Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A2AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNc-0001HR-2K; Fri, 17 Jan 2025 00:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNM-0008T9-Pc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:40 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNL-0006BV-Bw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:36 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216281bc30fso39731645ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093514; x=1737698314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VRfwf/f3l/VIzxVXHJMTOKa6E5uf06+ovvADrZ9bgY=;
 b=l7GVlE2bgye+CenfWQBeG3qNYnrzlWekvkidJ1Qq8qBl1VTEwwW33fJegkGgnU7HMs
 RRnqiOWBxJ2+dRcA39lzh7VUngAOV9bZl+zaSt2RcCLvZhSkfgPkxFrjzB4/7tPqQQTK
 XOasmMQXdpZWrvt9zTdUJVzXMGQ1jm6J5n+un7ToOPZ5EVwbMA7E0HRKlisHEuOySCFU
 RvwVvox5l0ucMzpMlk6ua7ryuUBYD+9L8zGhaIOCqz5CgIMwHGt4raU/M0FJbg6CfsIC
 y+YoHWqkgodw39s8isij+DMcRI57x/pHGkJplZlXrgUgu42B9kkdMP2GOXTEAFIwJ9We
 jw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093514; x=1737698314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VRfwf/f3l/VIzxVXHJMTOKa6E5uf06+ovvADrZ9bgY=;
 b=WGIbCoRM2hygYmUr7Yx7tguWufjnZbsOXZ2VgMd9NaV9lbMSEP/apQyFD3wyWxNu5g
 aW/Nl8+OqKk//XOWBoYoweEJ0E3kFLYBTBrlX459sKlKuru4ECBQ98rw9NG9gGWpj7Md
 u1MbIf9JVV8/CIPXztJbwCPynqKp12pNU56XCsxhiCpQox9P9FQCLntFRXn/Yrn/dVuI
 OD0iO5BJxYaa9b1bh27VvFQ8Mrcp/wrogWeb6opiVQyunAl76/FYxeryiQunfOzTjvkm
 bGXm6pmSTHJcC37IaLo/zuMvmDPNPbivtrHSq1YC7ioKcTnRgMp4MtREb0iVRtaNbMAB
 EwSw==
X-Gm-Message-State: AOJu0Yyy+fbUw/U+iASIoVkFcGIHcXAr4hMsfK8i5uqrJOCFt3T3zYzU
 zzPJHMUwEiiUBF4mJRu/Xsaenfbfl5i1DCjxMByOmGW6FlosCNvE7aUX+g==
X-Gm-Gg: ASbGncuk5qLW+ojd82KyMuqhhgAjsMQdwlyrfU5pt3PAOIuxaLGhFJvVDefVDae+DcF
 IRl2B4c8bj8eeo6oZstrEJanfh8S40UCJQvATaVhoEl/BDK7pFY/AzOAmUvAitCK2vXSWLA6Yzn
 CodGIBepFn492EVmrzno0B8QuVyq5BD7Na4SqkTHU/FFejJrh6nbA21jvypj961haTW7lFyd0Yt
 9vuyYvLLhRkmdHJyWFzwQhVxm3u/MSFSW9xTJfCHEVanJcCurhrB7zOEo9el3IhJADITXfWRKtE
 ljJxGc3/adBTdhjPz4FjjkcECrVcKxg4GkSTZI+6jzJ6xogHgZoXISKGm/e0
X-Google-Smtp-Source: AGHT+IEQdcY3da+1AKD5yF88FEAzPyvEnzsNypMeW843i5w1AULabrExmpamurP9bEizeLd7zmijfg==
X-Received: by 2002:a17:903:32cf:b0:216:5af7:5a8e with SMTP id
 d9443c01a7336-21c355ec9c0mr22160045ad.26.1737093513863; 
 Thu, 16 Jan 2025 21:58:33 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/50] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Fri, 17 Jan 2025 15:55:47 +1000
Message-ID: <20250117055552.108376-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Clément Léger <cleger@rivosinc.com>

When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
when executing sret if executed in M-mode. When executing mret/mnret,
SSTATUS.MDT is cleared.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-8-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 59c4bf28ed..ce1256f439 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -306,6 +306,9 @@ target_ulong helper_sret(CPURISCVState *env)
         }
         mstatus = set_field(mstatus, MSTATUS_SDT, 0);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >= PRV_M) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -391,6 +394,9 @@ target_ulong helper_mret(CPURISCVState *env)
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -436,6 +442,12 @@ target_ulong helper_mnret(CPURISCVState *env)
         env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        if (prev_priv < PRV_M) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+        }
+    }
+
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
     }
-- 
2.47.1


