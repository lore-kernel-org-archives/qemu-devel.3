Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D75CFB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 05:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8jF-0003wO-Cx; Fri, 24 Apr 2026 01:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8jD-0003vb-V5
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:05:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8jC-0005q7-9x
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:05:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so3155462b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 22:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777007120; x=1777611920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmZ0nGBImY+awhw0ANHTquhG/heSaRQBT3E52jWGxAE=;
 b=BWXO6yz9+OvMMuc+2BjIrSnPzTzN+cV+PRWbko7QT5oWU+vEsLXXDgMnzEMiy5J/dA
 Jv1IOWtBDor8JvOeQQGjOdyREEiKwZ+GYoSIGv9nFSdenIK710/f6cPEqos8cQrUr2hd
 kr24Kf9LM13W5xmIbshxV8dvreR4KHUx+5sSXVWZNzUqAMF75CCM3p0D7OKJzvlMoRkh
 QR9DmjJgoG5vw/IgKpkwtn2Yssp7HLN0ALVDcGkmZI7vBNmgf4NH+1tlQKLDSgz/7rfm
 e8q2tERlY/fuYc5Zwz+ywUn5nhwCwgk9M1CDIZdBc4GtbY67qmyxRZ2jY2GQkXXp85NY
 f6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777007120; x=1777611920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vmZ0nGBImY+awhw0ANHTquhG/heSaRQBT3E52jWGxAE=;
 b=cRJuUPCOrfQj16/EAIcRJn1xQVXcXywme8itktS2VXBTxmP8mjOrX2SUfNMxz+wBaO
 Es/lytm49JHglPewtVeNJk27FipPulisIznaAoCA9/8QaTzPLAyHzD4wEuV+ugce/Pvq
 4JYdPPuO4c7+nkizHZ4BWR1/dxl8d6HPfAVSg+vUqaBvTbyGDwWf+Uw+qYN6K3OrIoFK
 aRH+S6o+Sc2rAyZZwyWYP56MxzkEPvTGRWMXHluEa8o/+jFIqnwEG8HwmDs/RxZJ/zUF
 +Xq9Hh66BYnHIudeeIqxk1Wlzg1LJvTOcjpHgnnnSQAk4nFGboYoYdGZi54oucbR4t/4
 q/5w==
X-Gm-Message-State: AOJu0YyoUF8e08+1Gi3xzMzI1F/taETIkTnn6SaibkUAgiJ+lv8I3PnE
 RrLiH7qthGADj3MOzqbLOELldM6YZGW7D6CN8h8/mDfEP2IvmKJt146cWYHyUnrf45D14SFUl0T
 1J7YP3HZEF38ldI2PqsMBCCjlvoPIBIh7iy1KroORiG3qrCE+tWJxctf9m4MDE+5NR8/YhhXRu2
 srutxdeehFNDkQomQ1thxso2rbO8rzXrWxJsUrrK9e0ZoJaPNg
X-Gm-Gg: AeBDieuE9/5+Q/pCPyEzjZW6ZPEDwYHSNqzfFYkoOYMPwlb3+ok58K39Xh/LTVHJFVo
 Ys5YwhZYRgvrRgv+tpucjN8lDCl6yOC4C1bRIEqBxdIK8vIVGHAhYIPE3f6FgpTSrqbcWI2SSLY
 +x/KggKtntRoqASO+kvkALU5pV38+dgUixAPjQ/fF4VpVGbsvau04XQImywTX5Qv001I1TPnOcJ
 S4/FA8vRaOMrMrmWPK2EwBvvbDtONRfGnIrzhB+TNoxvoVkwTe48URagrcTclQ2nY1C+5LPF3MW
 jABPoKRLu7L2wkx7TgNuezkIFna1bZ1yytDKGfNjENUsi9VWM+WgF1+O1RzCmqjTHMHhkXSSdHo
 TSzw8NgcAnUjEL0oY7kDgffKYfFYkWuhq29yPsAvS1NaiBcfMjAE9XbouHKQBY/w15oBa6lHc9m
 +nN6GkjO1inl2H5BFKfK977i4rBYaDbsQRc9XsDvXMc8Tzu0LshtbZpbrKON1V
X-Received: by 2002:a05:6a00:c8f:b0:82c:26a4:df02 with SMTP id
 d2e1a72fcca58-82f8c9bad60mr32888759b3a.42.1777007120169; 
 Thu, 23 Apr 2026 22:05:20 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981992sm26698554b3a.7.2026.04.23.22.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:05:19 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 2/2] target/riscv: Update MISA.X for non-standard extensions
Date: Fri, 24 Apr 2026 13:05:09 +0800
Message-ID: <20260424050509.3935180-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424050509.3935180-1-frank.chang@sifive.com>
References: <20260424050509.3935180-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.X is set if there are any non-standard extensions.
We should set MISA.X when any of the vendor extensions is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53b..175e877f90a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVH RV('H')
 #define RVG RV('G')
 #define RVB RV('B')
+#define RVX RV('X')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5db166c01e9..42b40104806 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1201,6 +1201,20 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
     }
 }
 
+/* MISA.X is set when any of the non-standard extensions is enabled. */
+static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
+
+    for (int i = 0; arr[i].name != NULL; i++) {
+        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
+            riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
+            break;
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1209,6 +1223,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
     riscv_cpu_update_misa_c(cpu);
+    riscv_cpu_update_misa_x(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0


