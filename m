Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF5AC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLrU-0003nS-Ja; Sat, 02 Aug 2025 19:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnS-0004fd-2N
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:52 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnO-00061J-Du
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:49 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61998205433so136756eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177865; x=1754782665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GheDyyaEk32LhV4XyorEEP22MgDBMiF8XtCyvBQ0qqg=;
 b=mPc1mzuUU9+LWB1FGOb8vsIjYPYzusCzYtX/aOiN2rta06AsxdPm4ULiFpwj0qQYge
 Sx/I7AATSi2KcIr1DsydmXfzzHYVjG8mu5BY2UkKO48xPgTGhlX/6S2gxKgXMcwQuK0r
 grpzAGlgfLmoruW24gCAUiKmqE9shPi9yVts25oSyLA++8HzjPQcOw1IxhQqWsHy9bXu
 RvM5BfjkMMkOVAmjd0nAoabG3Kd+ywjMglEKnEJ54fPKxj0mWEhHZqxBQ6KDHpkwv5Xa
 yknGnvjt/RuAH+6mowhgbItYo59qu6QjBMklxjoP2FGB1m6QQhspxw6HOqGuDSzNs8tc
 kISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177865; x=1754782665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GheDyyaEk32LhV4XyorEEP22MgDBMiF8XtCyvBQ0qqg=;
 b=jIp4iKBzwGOPCbp2uzwXsk7eewyQYH8SSOLiruhiOzqdCdw73dqcYqKk60nxxVJf5i
 liLtP2Mf8R+A0w4XBK/1pGDMs9p4MvQImzDoBRPG8qkSXEI1jkCMeH4Ow1f93EyMktdn
 aIGjQJtF0lsECiTHMtpC5xxEl7hExL9jbuC/P7dLIzVnvUG6ke+tZMrFSMqlNdI7dKxe
 P9jrVKdhBxxI8v8vvtADZPCl9QV2KhKDqBLNa8VGurlsOjhbP9z4eVnesSEJkyXHS0j9
 YYl0YJSPUe0pSEcB8e+Qe+NfQENuhp8yRjUXuB1gd79FnPwH82W48xY7drM72mG4RqNS
 nUTA==
X-Gm-Message-State: AOJu0YxZRfp09XM2i0kSwI2vWclLXGRf6sqiimvK94eTvIGx9hRsFHqP
 tH5nj1Ca/VhCvjbXNs3v4frnlu0L/PR1RHq8ZKJEiiTRbN3s7Te+epQo4cYX1GEMdo0/3wIGBwc
 FNNvmpjU=
X-Gm-Gg: ASbGncvKpb6C8a7aLOKdyvsxdVgrjQxt0sUXFRKHQq4jNwTuj8OjC26qzZoCCWALDlB
 vls1ZrJqBapNPU+cgofXOpjZtzzTmil92c3GjkrLlcOboXcDkXd/RuDyIN01tAM1BD/ut+giY8m
 7LJU+ln8nxNHbXpIE60MJFXwYZe0bR2+mQuv46bUmjE0S3l54Y8A9w6d3SreSV+3nzX34jVWZAZ
 B1pwmL54T0QTvObXP9Fk+4mlHEv4dFq2GIQ+ofVJ49aIaxeubGxuXASNCmPZkJMTEo9eNpJ420p
 hihdV4ZL+nnyyv4cl7vjronDMoIqbYK/aP+/KeDIu1bZ5+5axULG4X2W0H6V2kJX1o3qFS9DJRv
 MQXi5+cfdfvST7NqFzO4aXGAIlMso3q72biTWhxglLA5lgA6xCYr+BizPj6RQeDg=
X-Google-Smtp-Source: AGHT+IFewqVC4SNhO6rrtWPibAa56fYiOEsq/jSUOXgufIElODhPoHbawwFjA+CSROR4yt4d5lYN5w==
X-Received: by 2002:a05:6870:6196:b0:2e8:f5d4:6077 with SMTP id
 586e51a60fabf-30b679b7e9emr2447620fac.38.1754177865220; 
 Sat, 02 Aug 2025 16:37:45 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 59/85] target/arm: Implement GCSPUSHM
Date: Sun,  3 Aug 2025 09:29:27 +1000
Message-ID: <20250802232953.413294-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  3 +++
 target/arm/cpregs-gcs.c        | 16 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 15894332b2..93358e6123 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -46,6 +46,8 @@ enum {
     ARM_CP_DC_ZVA                = 0x0005,
     ARM_CP_DC_GVA                = 0x0006,
     ARM_CP_DC_GZVA               = 0x0007,
+    /* Special: gcs instructions */
+    ARM_CP_GCSPUSHM              = 0x0008,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
@@ -861,6 +863,7 @@ typedef enum FGTBit {
     DO_BIT(HFGITR, DVPRCTX),
     DO_BIT(HFGITR, CPPRCTX),
     DO_BIT(HFGITR, DCCVAC),
+    DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_BIT(HFGITR, ATS1E1A),
 } FGTBit;
 
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index 9c06100d2b..38987372c9 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -33,6 +33,17 @@ static CPAccessResult access_gcs_el0(CPUARMState *env, const ARMCPRegInfo *ri,
     return access_gcs(env, ri, isread);
 }
 
+static CPAccessResult access_gcspushm(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (!(env->cp15.gcscr_el[el] & GCSCR_PUSHMEN)) {
+        return CP_ACCESS_TRAP_BIT | (el ? el : 1);
+    }
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSCRE0_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 5, .opc2 = 2,
@@ -69,6 +80,11 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 5, .opc2 = 1,
       .access = PL3_RW,
       .fieldoffset = offsetof(CPUARMState, cp15.gcspr_el[2]) },
+
+    { .name = "GCSPUSHM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
+      .access = PL0_W, .accessfn = access_gcspushm,
+      .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 45ff7bb0b2..a5810be2f7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -420,6 +420,19 @@ static MemOp check_ordered_align(DisasContext *s, int rn, int imm,
     return finalize_memop(s, mop);
 }
 
+static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+
+    tcg_gen_ld_i64(addr, tcg_env, sp_off);
+    tcg_gen_addi_i64(addr, addr, -8);
+    tcg_gen_qemu_st_i64(value, clean_data_tbi(s, addr), mmuidx, mop);
+    tcg_gen_st_i64(addr, tcg_env, sp_off);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2765,6 +2778,11 @@ static void handle_sys(DisasContext *s, bool isread,
             }
         }
         return;
+    case ARM_CP_GCSPUSHM:
+        if (s->gcs_en) {
+            gen_add_gcs_record(s, cpu_reg(s, rt));
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


