Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF024CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx3-0004uM-2I; Fri, 31 Oct 2025 14:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwz-0004so-9m
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwT-0006FG-2L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-429c2f6a580so698966f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935617; x=1762540417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ANpFGbNGmlcXCWtT3fqz3aKKSVJvWIseEjhgN0BfcDQ=;
 b=hB8kTHkrBPs9Zkfzx2PBAZewLhPYkIX2EYWJo78IiVA1W1xR3DAfFyfYixB5Dautps
 4laVXZttLXKlJmOLagZqQUxPTbJohozt9amIu8v7Z+yxysCnPZQ+521M9PnYdcQ53LIq
 xSss8PyIVDM9l+kyWVs9L9EwisIN9foM+X2VzkkUqoYYmYTCFTIHreQSMIzzepBI7ukU
 wf6b/3US94RG3TYz/A2gwadIwn6YsZpLvoU/a3g5lpT/apkh/8REC5phWLdXOtObotqt
 zf2E+YhLjcYGPRb08AHyUu9J0Td375fa02/7/yncJfggkN/dTG5L6Qlxcx/qHJDn07U5
 YVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935617; x=1762540417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANpFGbNGmlcXCWtT3fqz3aKKSVJvWIseEjhgN0BfcDQ=;
 b=c1wYigZsvxK/nJo8LZSJya5gevhn94Bqi5AmBDN+wGD2+jJKmrmIta2IabMOStfx4C
 qsQIx4w5xJl8XwPbmrtx7TolFpX6CwV1jM4Ho/PL5xiQu4YqxE0QqXnIZlKbcZyOKJZP
 OUAJXCYZsVUu0CDRF+dSDl4H15Zly1IU5vHRakHWInFIJLmyIdB4ZrM+vhAe1Kbe5PoC
 KoGvlbkYvceUZoCZLpSIsxj1NB0xQwL5iemPViVUmcBE0P9TFqhRYaMPwCAXQBDRzdEz
 yZ2kyoKRC1IUPKBSal6IMiY4IfZBTi5eTo6AIsv7u2hudFXuzHuJX+vg4qvtyFZEFRwH
 pkzQ==
X-Gm-Message-State: AOJu0YwVPmgoBY6KmRtTsNxvqadMRnrr24F/CnFS5Rh/zgbfjgghfSEW
 D7B7NvWqHWjK02YbuWK+GdfTZdqoRpdWhadW8bFic/ZjkqUIAdqnY80KsLN6tPCvdir/Y2kG2o6
 BhlFi
X-Gm-Gg: ASbGncsM1cAajXM+Rmgen/7NQJ2IU2iqYd4C1iras071mALN+HGReoDvUzGK6+UzzTk
 fshurIlv/SwMGrOBt7UHRMgQhByy+pLbhMO6KYdPlOrzyQDIwze9wyED1ZWZy+rdXP6/KuBGUOK
 AeWzbpoUHYq3cMYgMxUXUxzqBIQrRG8DHWOK47j39a8HGvBfJrw+W4MH2i3UwpHWLOjXRQy0MlH
 iscZHxyvFTERKN1WMDK9d9MKeqS2MtFQRdUBiU4wTXcKrq9KA1YchhcGg5ASGjtq2xeVD56dvta
 6Griooyl7cFx1gxYNaSoAhGaSX12r/LeAe9fLNpWhU3BbmQWfiKTTQwZf4ixCNNSeHd48k71BSV
 tHVXDaLGrysG9kJPCfLoM/vU7Qg/EfdYM4OptP/kRaBp2fkiqH/Kb3b6SnrtmLWr/Jc4dxvWAT8
 FVsUcJwA==
X-Google-Smtp-Source: AGHT+IEiCvEhmnEUluYvrneZOJPgbWKLeHS75hCXLn5Wr+TMAysJLk5+fgmoLyvBw0sK/8JWw1GJ6A==
X-Received: by 2002:a05:6000:2507:b0:3e7:46bf:f89d with SMTP id
 ffacd0b85a97d-429bd6ac0bemr4318491f8f.44.1761935616738; 
 Fri, 31 Oct 2025 11:33:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/38] target/arm/hvf: Factor hvf_handle_exception() out
Date: Fri, 31 Oct 2025 18:32:57 +0000
Message-ID: <20251031183310.3778349-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Factor hvf_handle_exception() out of hvf_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 123 +++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fcb6950692b..8553ce6adc2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1802,61 +1802,15 @@ static void hvf_sync_vtimer(CPUState *cpu)
     }
 }
 
-int hvf_arch_vcpu_exec(CPUState *cpu)
+static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
-    int ret;
-    hv_vcpu_exit_t *hvf_exit = cpu->accel->exit;
-    hv_return_t r;
-    bool advance_pc = false;
-
-    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
-        hvf_inject_interrupts(cpu)) {
-        return EXCP_INTERRUPT;
-    }
-
-    if (cpu->halted) {
-        return EXCP_HLT;
-    }
-
-    flush_cpu_state(cpu);
-
-    bql_unlock();
-    r = hv_vcpu_run(cpu->accel->fd);
-    bql_lock();
-    switch (r) {
-    case HV_SUCCESS:
-        break;
-    case HV_ILLEGAL_GUEST_STATE:
-        trace_hvf_illegal_guest_state();
-        /* fall through */
-    default:
-        g_assert_not_reached();
-    }
-
-    /* handle VMEXIT */
-    uint64_t exit_reason = hvf_exit->reason;
-    uint64_t syndrome = hvf_exit->exception.syndrome;
+    CPUARMState *env = cpu_env(cpu);
+    ARMCPU *arm_cpu = env_archcpu(env);
+    uint64_t syndrome = excp->syndrome;
     uint32_t ec = syn_get_ec(syndrome);
-
-    ret = 0;
-    switch (exit_reason) {
-    case HV_EXIT_REASON_EXCEPTION:
-        /* This is the main one, handle below. */
-        break;
-    case HV_EXIT_REASON_VTIMER_ACTIVATED:
-        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
-        cpu->accel->vtimer_masked = true;
-        return 0;
-    case HV_EXIT_REASON_CANCELED:
-        /* we got kicked, no exit to process */
-        return 0;
-    default:
-        g_assert_not_reached();
-    }
-
-    hvf_sync_vtimer(cpu);
+    bool advance_pc = false;
+    hv_return_t r;
+    int ret = 0;
 
     switch (ec) {
     case EC_SOFTWARESTEP: {
@@ -1895,7 +1849,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         cpu_synchronize_state(cpu);
 
         CPUWatchpoint *wp =
-            find_hw_watchpoint(cpu, hvf_exit->exception.virtual_address);
+            find_hw_watchpoint(cpu, excp->virtual_address);
         if (!wp) {
             error_report("EXCP_DEBUG but unknown hw watchpoint");
         }
@@ -1913,8 +1867,8 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
 
-        trace_hvf_data_abort(hvf_exit->exception.virtual_address,
-                             hvf_exit->exception.physical_address, isv,
+        trace_hvf_data_abort(excp->virtual_address,
+                             excp->physical_address, isv,
                              iswrite, s1ptw, len, srt);
 
         if (cm) {
@@ -1928,11 +1882,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
             address_space_write(&address_space_memory,
-                                hvf_exit->exception.physical_address,
+                                excp->physical_address,
                                 MEMTXATTRS_UNSPECIFIED, &val, len);
         } else {
             address_space_read(&address_space_memory,
-                               hvf_exit->exception.physical_address,
+                               excp->physical_address,
                                MEMTXATTRS_UNSPECIFIED, &val, len);
             if (sse) {
                 val = sextract64(val, 0, len * 8);
@@ -2030,6 +1984,59 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     return ret;
 }
 
+int hvf_arch_vcpu_exec(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    hv_vcpu_exit_t *hvf_exit = cpu->accel->exit;
+    hv_return_t r;
+
+    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+        hvf_inject_interrupts(cpu)) {
+        return EXCP_INTERRUPT;
+    }
+
+    if (cpu->halted) {
+        return EXCP_HLT;
+    }
+
+    flush_cpu_state(cpu);
+
+    bql_unlock();
+    r = hv_vcpu_run(cpu->accel->fd);
+    bql_lock();
+    switch (r) {
+    case HV_SUCCESS:
+        break;
+    case HV_ILLEGAL_GUEST_STATE:
+        trace_hvf_illegal_guest_state();
+        /* fall through */
+    default:
+        g_assert_not_reached();
+    }
+
+    /* handle VMEXIT */
+    uint64_t exit_reason = hvf_exit->reason;
+
+    switch (exit_reason) {
+    case HV_EXIT_REASON_EXCEPTION:
+        /* This is the main one, handle below. */
+        break;
+    case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
+        cpu->accel->vtimer_masked = true;
+        return 0;
+    case HV_EXIT_REASON_CANCELED:
+        /* we got kicked, no exit to process */
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+
+    hvf_sync_vtimer(cpu);
+
+    return hvf_handle_exception(cpu, &hvf_exit->exception);
+}
+
 static const VMStateDescription vmstate_hvf_vtimer = {
     .name = "hvf-vtimer",
     .version_id = 1,
-- 
2.43.0


