Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC9CF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDt3-0003uA-Cz; Tue, 24 Sep 2024 18:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsq-00038D-TU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsp-0001kK-1K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7191fb54147so4430958b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216385; x=1727821185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGgFxZGfm9ekyoaWZ4grTX9986f5O+aJN6pNlI6SJRk=;
 b=WHLANgu2N3DFuusl+XL4uhtdmiBC6uYh26P7X1SW3d+ZdWhFJzyBRHUKLfc/YjZMGD
 NQUS9tb4jLBvjBlhdRufq4tuPLqkKlfrhHpaaiFz9MUtEpZJBRL7IQ7NcvAcosyEUX6E
 vlMj2AvzgRUa31TjXl9jrLmu2SABpHAdx3oxahbPYsOS0Ro6K0rskQj9Ooz2cwI9kfvR
 Dc8GClR2ruNRzcdlQtKh8y2EV0ASkq4SmPiD6d7lLnoUwzyh/OHgjsEfNbrS/qeEtz+e
 N01wpWxy4vv/MC4FMCryv0zg2VGRKJKcQbn9RLX6CgrXEFk5Cmlohegjx5dkq/c2a2Ps
 NNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216385; x=1727821185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGgFxZGfm9ekyoaWZ4grTX9986f5O+aJN6pNlI6SJRk=;
 b=EWHK0kgv6T3C6qRO5iZTfsXkxnkno3Ri35WASLZEow8J5pUAhTGqlwHuMxdg4vu4Ym
 1h4P6XM1W7aUwibQS4XtyvZkB+nMbgLsfn+ZUhLBLLmA4dSmdF3KKc4/ZYuAAcWxPODN
 Z721Xtfa3VBEGbfjGiOPseZkgDGGH056P6tpM91ebRO3K/W9BfRnwi/v5Tpvz9CEZVwi
 Bf5vexWqHxT+fJJtzto3C6RFJ8MqTDGahoDuSFKdpmeyIaGMMeLS2QvPVKhtLQPSDTJO
 Qb8PE1sz7+OTglTnkFCjcEiELF1yxrvZEukHl3vVNJisY+joES/svJbxYxJEhZUJ3esZ
 hN2w==
X-Gm-Message-State: AOJu0Yye+J4xqUonwmGOeJ6xZ7eIVLBYwRy4Cl87gXL/3bnkP4bCSYAt
 t7CtEL2RAFF05ol8wPcWcdwM08PMycTh5szyfgzcKionV3zJF/HQ0IrRbw==
X-Google-Smtp-Source: AGHT+IEqGKN38J8hmv3R8xg5w5CpvuiY8JclIG36w2O0DKtUMn+GOCpDyQJb9G53u9MZsiWuOk/8LQ==
X-Received: by 2002:a05:6a00:1acf:b0:714:2198:26bd with SMTP id
 d2e1a72fcca58-71b0aab426dmr1186515b3a.11.1727216385389; 
 Tue, 24 Sep 2024 15:19:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 33/47] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Wed, 25 Sep 2024 08:17:34 +1000
Message-ID: <20240924221751.2688389-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added functions for cloning CPU registers and resetting the CPU state
for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-4-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index 9c31d9dc4c..a93ea3915a 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -131,4 +131,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
     }
 }
 
+static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gpr[xSP] = newsp;
+    }
+
+    env->gpr[xA0] = 0;
+    env->gpr[xT0] = 0;
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.46.1


