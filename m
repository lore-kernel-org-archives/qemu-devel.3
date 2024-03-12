Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA460C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WH-00007D-K4; Tue, 12 Mar 2024 13:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UA-0005Yr-14; Tue, 12 Mar 2024 13:00:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5U6-0008GH-C6; Tue, 12 Mar 2024 13:00:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso4198354b3a.1; 
 Tue, 12 Mar 2024 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262807; x=1710867607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVf/h4PI+3Z76hKAbw499YFjHfc8Pmr7sIWjABUIFRU=;
 b=j6ivl4oREg+0hFBLs2TkCwe5Z3BHqPpGxXG4azhtxuAQDUDzhCrv6dv8mvIrbIvXxR
 YUPreFpeEROekVIIsEmGxNTvATfqnuZWAMnptdK0iP+nNfNHDdFmudhxLzVFoZ85YIrs
 Sz3XtqfS+j2skOaUwuaFt9ixnREE9DroRDup4LhCN+zFdcIskeePe07NEBVJ46jq20oX
 v7rNkUzw2FRL64hFyGRiyIka+ZCDBl0FOQbFwICrG43JU7KhqqI+UCP0jJIgQEFiSJEV
 8mTgkdOeyIsdHNnOSsY/Ek4/5Tc1uaQfVSq6OfBO1KYuEppLMvvhoRGOWyBFfL434yD9
 OV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262807; x=1710867607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVf/h4PI+3Z76hKAbw499YFjHfc8Pmr7sIWjABUIFRU=;
 b=YBd4rW1HBfDfZd+Jjv79gxAlPSeS7HziTApC/h0EcvZWbkY3xUqfqF84r79Qmnpfgi
 oQnCmVq1IsksnVXjUz3ulP90tAsC1eygfQBCRH6McmLgtOxyAqU0udGmMjjBOqhUXlR7
 EsfwFV/5sXWjep8mBIuBRTjqE6afiwUrcN0Lz6ZgaQS5N2BFlc10LKbjOHnU9WSWYpgg
 SrUI3O6p6BzVw3VKoEopllKsuVUFa39tVUawaK5jvTJl+Zsoxp0qvZZrgG7YQQ7N2e9z
 hJjELANUItA41ZO6z6SASTSJLxnyUzae/tHPWoBoqiNjSFLlkw85bl4mvcmHh1EsF6h5
 98EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMHEYqyIEu8xNzjtJuOB1yR8GE2rUFnG8R+VPNPE71jxp2a02Efxs1NcJowV8PFWJ0uPystprOBsdCBMcxwxmAJt+
X-Gm-Message-State: AOJu0Yx9Lu+CVlSwZu0DmOdsnbHBQZjE9y4JEYGGlRIURWTfcZDEAv9x
 Uu3xWvh/3LnCJnj9I7sj/sMHCjfjIbVWXf4HwlzvC76BJDWylCFt+/v83weutbs=
X-Google-Smtp-Source: AGHT+IE2BWYpxkin3d2quXeWGkHTSNyrpq3ejZ4Khbf1skactvbitmdRvtpAS22JzEH5Fh2a0bV29Q==
X-Received: by 2002:a05:6a20:72a0:b0:1a3:1553:b425 with SMTP id
 o32-20020a056a2072a000b001a31553b425mr7674251pzk.15.1710262807455; 
 Tue, 12 Mar 2024 10:00:07 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/38] target/ppc: Use env_cpu for cpu_abort in excp_helper
Date: Wed, 13 Mar 2024 02:58:29 +1000
Message-ID: <20240312165851.2240242-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Use the env_cpu function to get the CPUState for cpu_abort. These are
only needed in case of fatal errors so this allows to avoid casting
and storing CPUState in a local variable wnen not needed.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 98952de267..56a5fe7f3b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -445,7 +445,6 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -473,8 +472,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -523,7 +522,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             env->spr[SPR_40x_ESR] = ESR_PTR;
             break;
         default:
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -550,11 +549,12 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         trace_ppc_excp_print("PIT");
         break;
     case POWERPC_EXCP_DEBUG:     /* Debug interrupt                          */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -569,7 +569,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -592,8 +591,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -653,7 +652,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -675,8 +674,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
-                      "exception %d with no HV support\n", excp);
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset exception "
+                      "%d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
@@ -703,11 +703,12 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
     case POWERPC_EXCP_MEXTBR:    /* Maskable external breakpoint             */
     case POWERPC_EXCP_NMEXTBR:   /* Non maskable external breakpoint         */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -730,7 +731,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -753,8 +753,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -812,7 +812,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -854,8 +854,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
-                      "exception %d with no HV support\n", excp);
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset exception "
+                      "%d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
@@ -875,11 +876,12 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -902,7 +904,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -925,8 +926,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -984,7 +985,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1026,7 +1027,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
@@ -1039,11 +1041,12 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1066,7 +1069,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -1103,8 +1105,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1135,6 +1137,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
         if (env->mpic_proxy) {
+            CPUState *cs = env_cpu(env);
             /* IACK the IRQ on delivery */
             env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
         }
@@ -1173,7 +1176,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1214,7 +1217,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
             /* DBSR already modified by caller */
         } else {
-            cpu_abort(cs, "Debug exception triggered on unsupported model\n");
+            cpu_abort(env_cpu(env),
+                      "Debug exception triggered on unsupported model\n");
         }
         break;
     case POWERPC_EXCP_SPEU:   /* SPE/embedded floating-point unavailable/VPU  */
@@ -1228,17 +1232,19 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_EFPDI:     /* Embedded floating-point data interrupt   */
     case POWERPC_EXCP_EFPRI:     /* Embedded floating-point round interrupt  */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1376,7 +1382,6 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1, lev = -1;
@@ -1415,8 +1420,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1512,7 +1517,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1578,7 +1583,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             new_msr |= (target_ulong)MSR_HVB;
         } else {
             if (FIELD_EX64(env->msr, MSR, POW)) {
-                cpu_abort(cs, "Trying to deliver power-saving system reset "
+                cpu_abort(env_cpu(env),
+                          "Trying to deliver power-saving system reset "
                           "exception %d with no HV support\n", excp);
             }
         }
@@ -1650,11 +1656,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1687,8 +1694,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
-            cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with "
-                      "no HV support\n", excp);
+            cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
+                      "with no HV support\n", excp);
         }
 
         /* This can update new_msr and vector if AIL applies */
@@ -1706,11 +1713,11 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
     if (excp <= POWERPC_EXCP_NONE || excp >= POWERPC_EXCP_NB) {
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
     }
 
     qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
@@ -2244,7 +2251,6 @@ void ppc_maybe_interrupt(CPUPPCState *env)
 static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2288,14 +2294,14 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
 static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2359,7 +2365,8 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
@@ -2438,7 +2445,8 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 #endif
@@ -2446,7 +2454,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_RESET: /* External reset */
@@ -2543,7 +2550,8 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
-- 
2.42.0


