Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A8FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO8H-0002oM-8B; Wed, 25 Feb 2026 18:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8D-0002FP-Qc
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8B-0002wt-Vr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso2372155e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061442; x=1772666242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nV/6P4k/wYGcsUX8qZDzsKQHMcwpvKFH9KhkcfgGdBU=;
 b=MSxc6BOUxPLKpXGdiFqF1/mc9OVeqjvtrMDrVDje2UyJe3UhaSD0BBjbrbs0dmbYV1
 5toRcOJgJN71rx0sb9RkgD32sb8MyVoNq5mphkZ4+3A+S/0eszVt5ICpqb/lXuIK4Rsz
 wZp0NFExn2BMaP/Py8jL81lJqUp9fJdpDD3Np/U1qtUicuVkzTrCHC/2yehVVkBXDI9L
 dqvCh894WjBNZ9wj+9frHXTx8Uj1hNG+pzf2fg1QpwTGu121DEFcJMGR0Bgt1s/YErt4
 3HxhYXS+7WmmLKmzJhuRqoWuez2aXng6i/npj6cbrvCSIQt1CdOemMGpsHOG07ivEBsJ
 G+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061442; x=1772666242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nV/6P4k/wYGcsUX8qZDzsKQHMcwpvKFH9KhkcfgGdBU=;
 b=BM5riWSltuk1SPxhiPUWP8UXmATacZUCjrAuipsIj/gks1kITSnTvHjKqO+u+R9q7Y
 lRs+MrygnzQX7cfLxX0RnT8m0OWNECXBt/jYbqXMsCQHAnMakp6gP6JvAuLVPkp8hpKq
 2lyS19sDWoJuoezIKBHl/2UNQA8m/oYcGF4RfBRtMpA2dioTmjkc7CW7bHFaB1bvDear
 IWqMu6yHlk5uzAc9A/9Wz88qILIH2IscU7FAwM46LdXpLZHA4DZNKv3LzSX2+jvwkr4k
 l/nJSGnWaZx3KJdNNl1Bdf+8pnvGeHReWuWSmph7C21G/hPKPEgqosYsgN5o2VmxUcYM
 TYsQ==
X-Gm-Message-State: AOJu0YxsvJBDThv2agNIlGOVlIjvVMqLo2+Fi4LLTcvFQN9JcfcKYdSw
 lHV9Fzn7RZzJZJT3xkGG37wstXThBgPgPFMoZP6gOJvryREw1rPmGVCGyi/xtNT+V0YQKP99aF9
 XHRy0SK8=
X-Gm-Gg: ATEYQzxVyGLjo+j3L1QNGgBp+MgdBImPUdzrv/QxwB2hlpsX1mjdP5NqcJ3/1OxdoUT
 gDy5XnD3Wyv9/NO4kMpxV1kvcVUJRtGuib8B4hjGNp6pzSnKjxAsnPU6f8mjgSM0JadoItmTzqw
 ZgHp6MkxW+JpsIr3h6WHU18zwwT+OAxdIHFQKQQ9kbSJ1pasdvh8MEXXDbLdDxrpGZjjRjobs91
 EbPwy2xkWnVszqcmg27aPg97hkM2yy81cv6xYFRrIsb4xcMhuZqx4znINTXGxQTr2F3Eg3U2RqZ
 BXo3vRbSsKKpZ2t8LyJFefl7JWpQOTZrZAcYuxj6YkR8A3QV+IBzfjoYwTYvtmlk5hol6smbvTI
 PxwCxf82bTcVoVmAS16jrElVzChSTxA3uvCQFgzfviV8qv/MBltHCH0oiG/SInvYf2RvBu4IIMn
 m3xfWL3ou684taK5Cdg40K4zSMtfeAwH/FxIgficlr8R+Ac1yneVQlv8MdrR2T82CX3H6z5FPe
X-Received: by 2002:a05:600c:1913:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-483c3de9bdemr1170575e9.21.1772061441970; 
 Wed, 25 Feb 2026 15:17:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb87030sm21685805e9.10.2026.02.25.15.17.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/70] target/ppc: Remove MonitorDef register entries available
 via gdbstub
Date: Thu, 26 Feb 2026 00:13:28 +0100
Message-ID: <20260225231411.96482-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-21-philmd@linaro.org>
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


