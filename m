Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1120E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cg-0005ic-0e; Thu, 19 Feb 2026 14:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bg-0003BF-O3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:38 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bY-0008D4-Jt
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48371119eacso12118755e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528941; x=1772133741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTB2dnUfw5P9soFqJNWQnp91K2KotzZiKYi6xg12/H0=;
 b=GqIoTdrKaUK5bdCr9BZvhL2SI/jLdW65FT6XbYLi33aEIDZ9bszkDwi3XDsNqCRmKt
 5VrCkznHrDjYSDvlrqkdat3Gwt2rhacNSIwdf0CJQrATPJVhGC66CWr5MgtUP7PImN+d
 eaG5WUQZT1KXYFk0RW8/raxbR+xiKd/5dselbQVhRy+8HrvlR8tLg34xbx0zQIy6Mlvs
 O1RWRGmFmXtBAPBn9vtEwx/MmIsvYmhzXcjs2pVR+uIR7Djl1IQgSTabdtn6XdftfCWZ
 8KUX+n4j4h9o2gZwlNW/92ijjCDwMxcQ2DJwpKaLzKwbZuEWXKeWmSdM7vWjulO4c7A8
 g0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528941; x=1772133741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTB2dnUfw5P9soFqJNWQnp91K2KotzZiKYi6xg12/H0=;
 b=XM3rtmV2ZHTfXnA4dtID5dtlofqC4I+XzTzhuDR+I6P3EBO/aBl7vfqNzhQMivsnFi
 2BSJqIpoo0EM5Oa6SqTxPbxJHsYE5Gpj+k6xLHFj3R5FhKzOf+taVFsnMuGKCY8yb+yg
 0oWCd/24X+AJ6maphqqZ77LVco4bZFLR1fz26UTIyT01IoRhRefW0hmuB+T+J92JEZbU
 ZWEBLEs4Xnhj2o4HSfWL4+qT+0kFkOynms9ihtFCuX0mvaZwMezimpyTz2+8+K5WfWnO
 IasQQSTlyQhNEomxxEm/Bqo6XuGHH53z3P1fR10PC8GM4ATkavT1umdXaNaTzAWL5ZGz
 VFQQ==
X-Gm-Message-State: AOJu0YyYrrnlCcpBJshr4b26rU3V2tARnrRMg+ZFFDBEoXd1TW4LpZ69
 yCeZ4oAwnySHXyh726rg93DtnvGYIh4cWxN56E7a4lnXRfcx+rmR6T8GzGFZNxermfEURUt8Lfh
 UvVDkoBCj3g==
X-Gm-Gg: AZuq6aIbYqsPRVVSn2BAsdTwpMvDhnUSpkMyvAhYRLh7x+6Pf6oJ0L7udTvFSMqdz3a
 I+oL8VN9qnJ9N8FNjRkTq22PhCQf6iIr83+P5Jva9sZ0OQaqO7C9yEoz4c/EGjQQvBkVP+zLGNw
 Y/FUarg2faWlqz3D6qgXN69aRYIp80awkCbN+VkoVfCGm6KK/l3Ehbn/8Bpku/mL62D7a85ichQ
 yJzh6prUbmZosFJkR5T7sB2wB6xIa56Ah1IoAezSeqGwta9zlREDRGAVCv46JVmvNWwtk0c6nIs
 7eIilO2J5uG7Um30n++/HTamszgxFGrJLcnL5bQIhN01A3zNx1EdVK3Fy8U1PZVbsTp8zZCPFL7
 xPjSIp7UWWcFVGg+zWJX5bqYF6ZrPaSyqqPnzdl+5o1coYcp53zUHB7KBchpx7feZloTKsYFOd+
 Qf2lJWV09hippnvTIFTBi3S1SacLxTfledVgLyNHd8EU9A4x9dU0Fl15k59loKgZW36+QZ3yW6
X-Received: by 2002:a05:600c:820b:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-48398b5d7cdmr105005215e9.20.1771528941272; 
 Thu, 19 Feb 2026 11:22:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1bfsm51498541f8f.13.2026.02.19.11.22.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 20/50] target/ppc: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 19 Feb 2026 20:19:22 +0100
Message-ID: <20260219191955.83815-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/ppc-qmp-cmds.c | 132 --------------------------------------
 1 file changed, 132 deletions(-)

diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 7022564604f..66c3bcb2c38 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -33,54 +33,6 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    unsigned int u;
-
-    u = ppc_get_cr(env);
-
-    return u;
-}
-
-static target_long monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    return cpu_read_xer(env);
-}
-
-static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
-                                    int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    if (!env->tb_env) {
-        return 0;
-    }
-    return cpu_ppc_load_decr(env);
-}
-
-static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    if (!env->tb_env) {
-        return 0;
-    }
-    return cpu_ppc_load_tbu(env);
-}
-
-static target_long monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    if (!env->tb_env) {
-        return 0;
-    }
-    return cpu_ppc_load_tbl(env);
-}
-
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
@@ -92,90 +44,6 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
-const MonitorDef monitor_defs[] = {
-    { "fpscr", offsetof(CPUPPCState, fpscr) },
-    /* Next instruction pointer */
-    { "nip|pc", offsetof(CPUPPCState, nip) },
-    { "lr", offsetof(CPUPPCState, lr) },
-    { "ctr", offsetof(CPUPPCState, ctr) },
-    { "decr", 0, &monitor_get_decr, },
-    { "ccr|cr", 0, &monitor_get_ccr, },
-    /* Machine state register */
-    { "xer", 0, &monitor_get_xer },
-    { "msr", offsetof(CPUPPCState, msr) },
-    { "tbu", 0, &monitor_get_tbu, },
-#if defined(TARGET_PPC64)
-    { "tb", 0, &monitor_get_tbl, },
-#else
-    { "tbl", 0, &monitor_get_tbl, },
-#endif
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-
-static int ppc_cpu_get_reg_num(const char *numstr, int maxnum, int *pregnum)
-{
-    int regnum;
-    char *endptr = NULL;
-
-    if (!*numstr) {
-        return false;
-    }
-
-    regnum = strtoul(numstr, &endptr, 10);
-    if (*endptr || (regnum >= maxnum)) {
-        return false;
-    }
-    *pregnum = regnum;
-
-    return true;
-}
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
-{
-    int i, regnum;
-    CPUPPCState *env = cpu_env(cs);
-
-    /* General purpose registers */
-    if ((qemu_tolower(name[0]) == 'r') &&
-        ppc_cpu_get_reg_num(name + 1, ARRAY_SIZE(env->gpr), &regnum)) {
-        *pval = env->gpr[regnum];
-        return 0;
-    }
-
-    /* Floating point registers */
-    if ((qemu_tolower(name[0]) == 'f') &&
-        ppc_cpu_get_reg_num(name + 1, 32, &regnum)) {
-        *pval = *cpu_fpr_ptr(env, regnum);
-        return 0;
-    }
-
-    /* Special purpose registers */
-    for (i = 0; i < ARRAY_SIZE(env->spr_cb); ++i) {
-        ppc_spr_t *spr = &env->spr_cb[i];
-
-        if (spr->name && (strcasecmp(name, spr->name) == 0)) {
-            *pval = env->spr[i];
-            return 0;
-        }
-    }
-
-    /* Segment registers */
-#if !defined(CONFIG_USER_ONLY)
-    if ((strncasecmp(name, "sr", 2) == 0) &&
-        ppc_cpu_get_reg_num(name + 2, ARRAY_SIZE(env->sr), &regnum)) {
-        *pval = env->sr[regnum];
-        return 0;
-    }
-#endif
-
-    return -EINVAL;
-}
-
 CpuModelExpansionInfo *
 qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                               CpuModelInfo *model,
-- 
2.52.0


