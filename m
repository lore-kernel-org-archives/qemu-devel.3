Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C397C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtG-0005Jp-Dj; Sat, 18 Jan 2025 20:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtE-0005Am-4A
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:12 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtC-0003Jo-FL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:11 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso4714302a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249249; x=1737854049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIx7yMpbHg8i0EoIEIkPLKxcpay9Dhimmk1POO5dii4=;
 b=PIWAAn/s9XH+TlQv35nKCn5qEnvu0s/V231VAZHrHekboaWGjaKMW1VtoN7Q6RDRVM
 pzNT8tsgf87dJx+yQpMbUNfr9IaF7M8e+i6vuUpZ0HX40Z7mWg8Am0GXIY54o7/lXcrO
 KgnJJnmHhj3BULElmA0YhXcjjQNVjfqQ0M8+B6GS/x48ba/6EAMTC/0YoByfPdaXN3HU
 65QeUbHflLH+YvpLlAxKuZ7cVJ4DHNNooIeMJv3nE5W0YaIgRQ3SF79Vtrg82mxnA/oH
 E1tKttM7l9L8Lu0CB7HWW/ETXYk5iLHCsjhmUcliEofby0I9AHc6IktVfxQiu756xlvc
 7vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249249; x=1737854049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIx7yMpbHg8i0EoIEIkPLKxcpay9Dhimmk1POO5dii4=;
 b=uF9NRvEIIcDo64UzV/YkWAV1tCVlk77/9fgFLsfCXyaR0keoL7zEL7SA6SKaYUuuSt
 7dUkkMleqBljX+ItW1hps/3xcNgYJodqfM6eX2o5pGcvkdeP4onsfedt5KePJGTFnkHW
 95FeZpGRYwuSIIpPk4J/otdobH1qfC2wLWtQXry/zjAvvnvtp31UbG6r9BQRe/LvFdjU
 zYHIGdVcQfSeLjJ76S6MBBhGAEx1wpTS/D2zoMc43UCaqDdPFgkblNLMqo3GJpUr5wNX
 9HVpC98vTjdTxYaDVUu3f9KN0rHsk6HYzJ2RYESMCag2SJvYYmPrOgRAnrL+whXAS9gk
 gw/g==
X-Gm-Message-State: AOJu0YxuDsbC20mHe8a0C4lByE4JRAQq3d4SyBGk3qCkX745oSPGkm/j
 NwS0JPE4/SVY5Edn4BfD5NlRg4aHG9IE2miLL45bNZMJCgHl+U1OsnLjXaE2
X-Gm-Gg: ASbGncuH9p5H7cEG+sAk5rGc4qNLkk/S5BkphdBU4Yt8GWMp6U7vmIVMH+l6dSDuukC
 1KL1vqlfAtDZtEedwpDh86UVIQt5Q6tFAXX7tyZr7yPcGpx4OeoD3KeXoKD+cYUA6N5p6GMKP0U
 wPwmlUtdal6jmU/qXqqhLG1/mYZodlPS3GqVolANSZqlKrw5W3AZoSH8HFPJTl9E87Yyjk+V7c2
 8YQPP6LQkDSAe3Vergq/oaVolBsIdJyMKgLFFU//RKNh3mbYdK5amQRgdM2mxqL/tRHbjia6+qd
 +kDO61KpfjgHBxup5hUFQSN4umcAdtTE1cWcR4dOx5swmy5ygz1VoCyNxtCrKonG2sAaRdTzng=
 =
X-Google-Smtp-Source: AGHT+IHuMFT3NGneS8g/DauNXd9xDzMyBgmrkqK2o2q8wd4oU2bTR9LkyXzaX86d020TWizofC26Og==
X-Received: by 2002:a17:90b:4c43:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f782d65adbmr11178532a91.29.1737249248734; 
 Sat, 18 Jan 2025 17:14:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:08 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 26/50] target/riscv: Have kvm_riscv_get_timebase_frequency()
 take RISCVCPU cpu
Date: Sun, 19 Jan 2025 11:12:01 +1000
Message-ID: <20250119011225.11452-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep kvm_riscv_get_timebase_frequency() prototype aligned with
the other ones declared in "kvm_riscv.h", have it take a RISCVCPU
cpu as argument. Include "target/riscv/cpu-qom.h" which declares
the RISCVCPU typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250112231344.34632-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm_riscv.h | 4 +++-
 hw/riscv/virt.c              | 2 +-
 target/riscv/kvm/kvm-cpu.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 5851898868..b2bcd1041f 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -19,6 +19,8 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
+#include "target/riscv/cpu-qom.h"
+
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
@@ -28,6 +30,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
-uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
 #endif
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2bc5a9dd98..9e8876be29 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
                           kvm_enabled() ?
-                          kvm_riscv_get_timebase_frequency(first_cpu) :
+                          kvm_riscv_get_timebase_frequency(RISCV_CPU(first_cpu)) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 11278ea778..23ce779359 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -758,11 +758,11 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = false;
 }
 
-uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
 {
     uint64_t reg;
 
-    KVM_RISCV_GET_TIMER(cs, frequency, reg);
+    KVM_RISCV_GET_TIMER(CPU(cpu), frequency, reg);
 
     return reg;
 }
-- 
2.48.1


