Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1026DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTd-0002Ic-Uf; Fri, 04 Jul 2025 06:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTb-000250-6t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:17:03 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTZ-00074Y-4s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:17:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so663756f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624219; x=1752229019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aW8jT2Wve8m9HiyaZWg6TzaiyGwHlA9RHVgvMmEmKaQ=;
 b=YRLJIf7N2kXU5OvLDFhRDTQAD/QKMO+yDbkaCJLMBym0Z4lqISw3lgUZ2JDzQzL/3E
 jTFJJtfw9aoMlMow/A6n7zYufpM7LscdngrST3GG92NzCcjRRuoDILH7y81/u8Rtaeug
 V+bS0BUKMuWCRplbn8FlZiAgOdUc32C43q9aH49R3bVvA+w0ZJI2WoBTXXNVt3wT6XDp
 u1+cXXMPMEuJACTZUwdlwSv6hJgTvQsh6WzUCTmtMC91nahuVhKTD1FZpCfAaFnO/Q/E
 PHNlTt4NqdmXaKQL0Hs+nlLdVhcXuubiJFwTOU5xhulE38kD+xuyRKrDvWryqLUff728
 qyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624219; x=1752229019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aW8jT2Wve8m9HiyaZWg6TzaiyGwHlA9RHVgvMmEmKaQ=;
 b=C6Ds7p+n1zrF4s64S3iHk3+mxaH1K68y2Rj5MEovfu9W1YJR5kR+WCVHtB3V4yRFdj
 mL9hYVtgPthzGeHXYuJdKJ7gy1+gPcyvzYg9WO493YkEQJeTUri1otWK8kCg4BCiHsvo
 HIFTZ2fP8MpFxmlY11+DTR32amU4xbmfFI/5f876BS8sJaA/32TZsizEvSNTVGx48cyY
 iyAmYyNMSIPiIXo0Esm/eI0JyKsoO5xIdYNnoK9RyDbM2xn+XB3kWz/dkcGkfv/w5Bu+
 MGX5sUEPRL7tqxdj+8Mv7JVxln4RwPzIuHDX7+Pp3DSqTOS1JK2lTvwm1JK9X9R44Fgk
 KV+A==
X-Gm-Message-State: AOJu0Ywu8TIlmHUOqQQE1P+NXOA9ZghBtEtkv48zx57/M0WP0TC7tbZ6
 63xXG07UUAWkGHN5hYg8sX5Qsf3AoIWLdkoGZ/qLCxVc6wTdPShYSE3+uKuSFD+q7o5SWetqNvW
 vaUjG29U=
X-Gm-Gg: ASbGncu9NqxKIDuLhqScwVDN8brrZtEtqaePG6RItFpwwXByl0tP5CbUf03bcUFoUFZ
 STrdGG0PQI4kdj7gKdGBxUm6pctJih/pM5Jxy8uFHBqCIbmTlIsyJt2cHJMARLOa+dLpKtpJygs
 OKSfbcZEd5Dq9OQt14ju8ZZ8rIrdiNS+HtJnTlq9/B/qGtQv/KieiyDPyZ/1WhhqyhDGpO21Auf
 rnsHge93+H7iN6gImK5UjVgSTOEZ8LucvCVn4lA0kbI/xyj1lcaCmeXj9ZHHUw2iOh2SOsjOzo+
 hx6cxu3aBSHyQmlBb0x3CPcUdyFPd6DzlKmGkgTprP0nvm7YYWd69x68idN3DDSXM1pW7tTgLzD
 NiqEG5h+NdsziK3DlQEixreXSxPmU9uP9KbFK
X-Google-Smtp-Source: AGHT+IF3wWl/dXPWddWZhkJIPm+jB9bAgRPyGBzoOVuDFY+YwD8VcH4+2FgwzuJgcwhUzFlEm1B8sQ==
X-Received: by 2002:a5d:64e4:0:b0:3b1:8db7:d1fc with SMTP id
 ffacd0b85a97d-3b4964f92b7mr1619616f8f.21.1751624218666; 
 Fri, 04 Jul 2025 03:16:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0a5csm2083276f8f.29.2025.07.04.03.16.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/31] hmp-cmds-target.c: add CPU_DUMP_VPU in
 hmp_info_registers()
Date: Fri,  4 Jul 2025 12:14:32 +0200
Message-ID: <20250704101433.8813-32-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit b84694defb added the CPU_DUMP_VPU to allow vector registers to be
logged by log_cpu_exec() in TCG. This flag was then used in commit
b227f6a8a7 to print RISC-V vector registers using this flag. Note that
this change was done in riscv_cpu_dump_state(), the cpu_dump_state()
callback for RISC-V, the same callback used in hmp_info_registers().

Back then we forgot to change hmp_info_registers(), and 'info registers'
isn't showing RISC-V vector registers as a result. No other target is
impacted since only RISC-V is using CPU_DUMP_VPU.

There's no reason to not show VPU regs in info_registers(), so add
CPU_DUMP_VPU to hmp_info_registers(). This will print vector registers
for all RISC-V machines and, as said above, has no impact in other
archs.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250623145306.991562-1-dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 8eaf70d9c9a..e9820611466 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -102,7 +102,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
     if (all_cpus) {
         CPU_FOREACH(cs) {
             monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-            cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
         }
     } else {
         cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
@@ -117,7 +117,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
         }
 
         monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-        cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
     }
 }
 
-- 
2.49.0


