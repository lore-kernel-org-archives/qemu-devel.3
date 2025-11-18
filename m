Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E946CED603
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJRA-0005E9-Vr; Tue, 18 Nov 2025 05:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJR9-0005Bw-9Q
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:51 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJR7-0000Aj-Lh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:50 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7bb3092e4d7so3875552b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763463588; x=1764068388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BeAfhzzwLoezXUW4QEKWPyiXQiwrmDlOOpUfme2j/5E=;
 b=hkDzl0KkPTBCA9niuMj60/rQJeTFJt2weYmIeYVS21IitekMwW4aJ+20l2eHEerQXG
 ltGAvj0hZDj+ZN8dgC52smvdWoW9rmYi2OU7HyzcE/vcC8delO9Tj3vfzU2tJdlVSCbq
 lszNyZR99yqBbbmLE7AuI2K5H8k4A5fuF6MWEgPxi/LE9Oert+NFLxco7i1iiakq5VJU
 Dea8cLT6xS7qayeYNiFYetTpLSkH94IQtLFtT/UpWw9N+gMKShOIu+SesxCokW3/lQdm
 DyJtEgoOqVNBRPJLDshXKk561KH+swAHoUUkq/No9cv/VF3hHhs0KuSOdN/Ok5tmtjft
 1+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763463588; x=1764068388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BeAfhzzwLoezXUW4QEKWPyiXQiwrmDlOOpUfme2j/5E=;
 b=G0xSl1ewncW2EFy+TjPdN5kptDbA8N4fjqRCYkzuwkkztiuaNkwN6tza7pFFPcK5z7
 JYF/Rzj/58HqCfH80oxzDhDt64WzdKLjCg2s6taTJniHEGnWMqSExIM3RG5SzOjboFbf
 k7t/NcQz9Fsp0xnuWB4VkgeUm+6ec+imybye605JGAdTlfw/S+u1ugWahrVGXiP5dhLt
 Te1Fai7h5leABL15ruGfrpYaDnnGsYGITLjOmmJ4litI5mT7S7JISwz66cCUUfBZun0Y
 oq1VXZNKCnFIJ7+XVtOpBK5qpOkm0JUQD6VMebOGEjxsaBmIBxu2Ex5Z2zVbDlpk3FeA
 rNZg==
X-Gm-Message-State: AOJu0YxO8WyqEgLUZ+koRva3R4qIQcnxg8Eo3UV2vsk2MzWXLjM2Zzz+
 gE/p5xza5bwxBkV68Cawonb87uhq+kJFNZ3oXReKy8pZrdFnWIEZeqBMfxBVfK3TGTUQpVbFPAA
 R4AAm71d8/DRD51TkvCq3j4n44s+PtNKAqyzHD10JseOMz0ha5qDjNYxoS3NfPdjkzrhmm/E/43
 md+T+wmML9O97kYmP2nISlDGqmBbVVbXdcWkNWHXHaB7A=
X-Gm-Gg: ASbGncvouzdh956Y8/CCjNOe8wEkYy+yP8zoZwM7czn1k9dp/j6fousZX9o/JaUzP2s
 rvWwnqqHXnk3SI39o6mAXEdw49m8osTeQhn9kJp/VLbQW8hfohjO2hA3EPZcXCDVtYzAD0EDR3b
 HlnAGxkjflgTcnxAMjhIbWJcfv3+tXbugeYjk24pPfPBvW17aufCiXW3w8+97fQhXzBrjTnUpzD
 YFnUCOc0rhBPNwsGnLWtLCZ3jsKbq98McjCuy3OgYNejrqlTyRwtakfx0I/naS+IBXysWBXLMVb
 ILm75p2WkyPvgIKzJnE7cQ4gG9dskIylYnJAM+s8N7TNndVPlxdX4BTwsm0kUgFmoff104TOEZB
 KszqL3uxmT7pVEEV4Cby0InG7dK+RitT1qBUAs++juTKlnlrcgz/jx5vqqSMncclloOdYVC3RIH
 KvgbLloMS9F4PnEUIDFLYUAIwQd4z3qyHSUNY2jD/2BfF0RlN+
X-Google-Smtp-Source: AGHT+IEc2MitcQABfhGMFRlWqEWvpt1XO2zEb5HfUNZCS7ZD4azMbbNnUkXzpcZLGtupsytJpEP9SA==
X-Received: by 2002:a05:7022:1e05:b0:11b:c2ea:daed with SMTP id
 a92af1059eb24-11bc2eadc31mr6464311c88.32.1763463587625; 
 Tue, 18 Nov 2025 02:59:47 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db4a36asm43989903eec.5.2025.11.18.02.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:59:47 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 2/3] target/riscv: Fix pointer masking PMM field selection
 logic
Date: Tue, 18 Nov 2025 18:59:35 +0800
Message-ID: <20251118105936.2839054-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118105936.2839054-1-frank.chang@sifive.com>
References: <20251118105936.2839054-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
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

mstatus.MPV only records the previous virtualization state, and does not
affect pointer masking according to the Zjpm specification.

This patch rewrites riscv_pm_get_pmm() to follow the architectural
definition of Smmpm, Smnpm, and Ssnpm.

The resulting PMM source for each mode is summarized below:

  * Smmpm + Smnpm + Ssnpm:
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U-mode:  senvcfg.PMM
      VS-mode: henvcfg.PMM
      VU-mode: senvcfg.PMM

  * Smmpm + Smnpm (RVS implemented):
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U/VS/VU: disabled (Ssnpm not present)

  * Smmpm + Smnpm (RVS not implemented):
      M-mode:  mseccfg.PMM
      U-mode:  menvcfg.PMM
      S/VS/VU: disabled (no S-mode)

  * Smmpm only:
      M-mode:  mseccfg.PMM
      Other existing modes: pointer masking disabled

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90e..112093012b0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -154,22 +154,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
         }
         break;
     case PRV_S:
-        if (riscv_cpu_cfg(env)->ext_smnpm) {
-            if (get_field(env->mstatus, MSTATUS_MPV)) {
-                return get_field(env->henvcfg, HENVCFG_PMM);
-            } else {
+        if (!env->virt_enabled) {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
                 return get_field(env->menvcfg, MENVCFG_PMM);
             }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->henvcfg, HENVCFG_PMM);
+            }
         }
         break;
     case PRV_U:
-        if (riscv_has_ext(env, RVS)) {
+        if (!env->virt_enabled) {
             if (riscv_cpu_cfg(env)->ext_ssnpm) {
                 return get_field(env->senvcfg, SENVCFG_PMM);
             }
-        } else {
+
             if (riscv_cpu_cfg(env)->ext_smnpm) {
-                return get_field(env->menvcfg, MENVCFG_PMM);
+                if (!riscv_has_ext(env, RVS)) {
+                    return get_field(env->menvcfg, MENVCFG_PMM);
+                }
+            }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->senvcfg, SENVCFG_PMM);
             }
         }
         break;
-- 
2.43.0


