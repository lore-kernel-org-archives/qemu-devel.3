Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F4CC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbK-0001jE-Ua; Thu, 23 May 2024 19:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaf-00076L-FT; Thu, 23 May 2024 19:11:17 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaX-0006I9-7o; Thu, 23 May 2024 19:11:17 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b52b0d0dfeso2833547eaf.0; 
 Thu, 23 May 2024 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505867; x=1717110667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGRV+A0Z6ioG6ImZPkbnbweK1JbvKAB9m8KPvmYU42o=;
 b=VvRf+89QcDoay9w78YZdqp8ahMVdFCIhCWmQFbXJxZ3sKghYRypDtJj9EocPM9Y2nq
 3opQrOlfvVHDArHzFHdKlIE5vT75hDFry2ZgWzAJUWobXQbLyIg3m4EmPcjEME4QH6dg
 +KWr/BRczGIoFxojCCCyxwUdFL+ViaaQWFMDfwOPTZNR8hZbX4Gs3u57xAnPY6i2Snpq
 IEw4AWG6TVV22nfeqhf5M7PybNy+3a06HPCRIOawbZ0FrTk1CbnaJc4tppxZKJ+teqcg
 7z/NYZxurxn/nzmqHwfuszJxyJq9GE2dL09hjSaXaCVx+ehybfdJRCmnRqvcqrcoeB8+
 00jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505867; x=1717110667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGRV+A0Z6ioG6ImZPkbnbweK1JbvKAB9m8KPvmYU42o=;
 b=QCInahF1nFu6d59REKiP82HEHXJV/4Il3goD3YG3NOLCL4m0x5k06pxs1Id2zUpXI/
 lLPHqSoSmRTkkaULFPwnNPhgFkdbxMHJdfd7lp3hsKuDwO7boHee8aygJWYUv7eUVjrj
 us1nzc/7foxzrQF2jZiaHVJJ0RUBDkIqskf4xBvXVm3ecFBIj30/ruDIByjFSiiYl9yM
 cYl65Z+dz3zhYvjHxjc3k14Cup96LuDWYk6nPxeItsW6UXEo4wFBZKiWjyObC8dFtVDp
 3lL5vJsh/lKZZb9QhqEQpBx2Ba3kPYsFjykd7tV+TfVwdpbczK9BLs91kHttR7wmOii6
 BDHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaUEX9ICNjaM34luo+eWDJYyUXt4SUg7tRckQypQZyF5wHB/c5dbenlZkOjY35RqimV4S2Az16YyL6y0x4F3D2fJMD
X-Gm-Message-State: AOJu0Yz5a5hhOow50pGKHpbIBREostQOzPmz3uldDAQ71zA7eiZislX1
 a/CZRow8hHuKU3O2kR3YWh+o5YqF0W2xg+A2HkX9vk3HkWTzUiBhP3hnVA==
X-Google-Smtp-Source: AGHT+IEx+MxZR4aVoGUlEUdyEBX83EMRNj1V/FJgcPKmSKWYPhXAfrip0eGpM/8F8STEzJJF0Gm8vw==
X-Received: by 2002:a05:6358:8094:b0:183:e918:3a42 with SMTP id
 e5c5f4694b2df-197e50f4d86mr106713655d.9.1716505866888; 
 Thu, 23 May 2024 16:11:06 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 62/72] target/ppc/mmu_common.c: Split off real mode handling
 from get_physical_address_wtlb()
Date: Fri, 24 May 2024 09:07:35 +1000
Message-ID: <20240523230747.45703-63-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add ppc_real_mode_xlate() to handle real mode translation and allow
removing this case from ppc_jumbo_xlate().

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 46 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 8599106f75..ab912da821 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1117,23 +1117,12 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
 {
-    bool real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-                                           : !FIELD_EX64(env->msr, MSR, DR);
-    if (real_mode) {
-        ctx->raddr = eaddr;
-        ctx->prot = PAGE_RWX;
-        return 0;
-    }
-
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
         return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
         return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
                                            access_type);
-    case POWERPC_MMU_REAL:
-        cpu_abort(env_cpu(env),
-                  "PowerPC in real mode do not do any translation\n");
     default:
         cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
     }
@@ -1251,6 +1240,24 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
+static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                                MMUAccessType access_type,
+                                hwaddr *raddrp, int *psizep, int *protp)
+{
+    CPUPPCState *env = &cpu->env;
+
+    if (access_type == MMU_INST_FETCH ? !FIELD_EX64(env->msr, MSR, IR)
+                                      : !FIELD_EX64(env->msr, MSR, DR)) {
+        *raddrp = eaddr;
+        *protp = PAGE_RWX;
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (env->mmu_model == POWERPC_MMU_REAL) {
+        cpu_abort(CPU(cpu), "PowerPC in real mode shold not do translation\n");
+    }
+    return false;
+}
+
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
@@ -1264,6 +1271,10 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
     int type;
     int ret;
 
+    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+        return true;
+    }
+
     if (access_type == MMU_INST_FETCH) {
         /* code access */
         type = ACCESS_CODE;
@@ -1303,11 +1314,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->spr[SPR_40x_DEAR] = eaddr;
                 env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
-            case POWERPC_MMU_REAL:
-                cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
             default:
-                cpu_abort(cs, "Unknown or invalid MMU model\n");
+                g_assert_not_reached();
             }
             break;
         case -2:
@@ -1359,11 +1367,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     env->spr[SPR_40x_ESR] = 0x00000000;
                 }
                 break;
-            case POWERPC_MMU_REAL:
-                cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
             default:
-                cpu_abort(cs, "Unknown or invalid MMU model\n");
+                g_assert_not_reached();
             }
             break;
         case -2:
@@ -1457,6 +1462,9 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_BOOKE206:
         return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_REAL:
+        return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
+                                   protp);
     case POWERPC_MMU_MPC8xx:
         cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
-- 
2.43.0


