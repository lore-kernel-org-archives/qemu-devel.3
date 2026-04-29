Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC907CCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwuH-0001iE-Nv; Wed, 29 Apr 2026 00:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuF-0001Uv-0T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwuD-0001JD-8q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:52:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2aaed195901so52981455ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438331; x=1778043131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFjIveUuOnrhIzHJ+Ozf2SIcBbSrIZOaJvuBTb2IHEQ=;
 b=oitsMGP5GZF2/C6WEcpnBGGXLsmoTC3fz79eXCrj5HdnkxEseO+g+ZFqRDOkc3xrRP
 CRCSVdjTJtquESFmGiFU35clg34mB8bdc/YbitGVOPPSKWRoBTvSgqcOCPzN4IBck0px
 vLgxDGltsrVwhMXQTdexAXPuqXTll/ZWOZWYa+JI2JD69RqLmPPysaAhbSVW5+bZxDwa
 Xmyw6kukSQ3syZtdrtXUclqy0oL7/MhR/gRDb95G10zpAkzdJfMRvK5QZIbt5ei+XoXC
 coPCxvQ2AP8lN4SE63cCvdPfR14EsJvmR8JuBTZZj/eQmofmiinWDOP9Qlt4wxrnFuiD
 pzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438331; x=1778043131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CFjIveUuOnrhIzHJ+Ozf2SIcBbSrIZOaJvuBTb2IHEQ=;
 b=tJmxtwEHlLep9SNOSgYo32SIIbV27bN/dcFbKLeypkDGr29Vrx3hDZYLe2v8bAC/su
 3LRiVmU5FJXZAGFDizHcqFZ1GvmwEJV9XCoHWLXXNVauOY4PMKPAV7Xhl95yv8bseK26
 Wvl3i+bU0zo7X6y2tNM3WQNWt+22WbI6c1IrMQRam2h+KbyRjfghUKSRsgexDFbD+aj7
 ghIUF6MYUlXvSzhfuqjYXnhaSwPK6fK6lrFHFPj3JwhOgX0tp42H2REH5P1xZYAnNlz4
 We8VLyXrUF/cCiRl9Ab9z/Ueed7KNoleJ64cC3tb7UcROuVrPllsK9GKviPuwe8Z1I2g
 J7Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0Nn0eEWPTSKOnrHoOKZL566fcDKRezmIarG6JniDDVP01Y3LvSRH8GuB7LMfNWKqnfppoVT/pKWxI@nongnu.org
X-Gm-Message-State: AOJu0YxZMsTYlqfezswSj5lohYUnnEr9ZL007Cm7EGGwwFdow8R0ltZe
 6d/anRgZzeDuB00FjwlguMijRv3QN89EWKgaLk3M6RkgV3zJQc5I0QAW2pebiw==
X-Gm-Gg: AeBDievnXZw+cKv9GxaBbUI/BTSIOecOP9kerHswSxQtm0klNhL00tuq0QzTaQrazSS
 rS8fnU6dPEK4O6tPXdeJnUWifmw3AwRAs5O2p9Ixlxs55sM7aNfex5pr4uuMGD868wM/2qJC5Df
 6LM5lHIfYk4vdhsDkfpwIgrTtEMuNnHukeERrx3itR89rC1vrAYcIb/I4MM70vqSTIr2l6YO2ZE
 qgPn3XnLBcVGJ+10wM3lllN2Jmxj75tJAvGTuBntH6+GcO0xpz8EbZmEsfEfd72gfNRiHFPn6cC
 T5W7ANh26Xn1dR0/pl/7io5gEjeFw67LBQxj8hVGxifEVYzwpMoOuQYFo6xY8fu3OSzPKz2iX/H
 Z/zarSznR+PVZ/zDkPIPUHUGYQvIQXFC4RTh2Un/OwhSz3XSQXLVxaEHlEOVCt4ZPbQ4Ma7Xa81
 vyu+joBzlS8guWTmpg152gsqB6IWF7FqbHnqdv0F0nAjc1Ehi40xeg
X-Received: by 2002:a17:903:1a8d:b0:2b4:689a:e420 with SMTP id
 d9443c01a7336-2b97c3e3166mr60768775ad.8.1777438331591; 
 Tue, 28 Apr 2026 21:52:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:52:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/51] target/riscv: Fix pointer masking for virtual-machine
 load/store insns
Date: Wed, 29 Apr 2026 14:47:49 +1000
Message-ID: <20260429044752.4176397-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The effective privilege of explicit memory accesses made by
virtual-machine load/store instructions (HLV.* and HSV.*) is controlled
by hstatus.SPVP. mstatus.MPRV does not affect these virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421093715.2995067-5-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bab4153e53..2b3fea81d5 100644
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
2.53.0


