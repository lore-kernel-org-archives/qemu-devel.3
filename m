Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AFACFC5F7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syySl-0006Hf-Bl; Thu, 10 Oct 2024 15:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syySH-00068z-1g
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:04:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syySF-0004kP-NJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:04:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df2b0a2f7so1179773b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587045; x=1729191845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMbhqBUI4BThm42iYqRzGr0189fZkGi1HZ2Ne6+spLA=;
 b=YGFzpzhRim7P++/zlLCQmD59WTgJ3l47IWUVGMpjNC7u81egx4vgqimV7i4uu9o8Ej
 N/zU0yeFNPgTF4aVQv/coxhx/8fVjIdamqfwK7owex2uj7FJ8mL/GvBRdqwl8Rgef2hk
 wCx1E0A3YxCnbmYyB8EvxegmfqjCULGENtNntezg7vdsrlOCUGmm+X3yfoVL97zOZu7z
 6q1+LZbDyfdjKg+N72FtlIfowSPptUiZXrUWd1E3dNO/XqDgu4WpYc0YSsYM0iy0lDBo
 AtiljjW7I4y4rpH0hEwg5IA/szcFAicsnFqXdMHkqcLDkuDNAMA+3a/RAVhvIw8292sJ
 f2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587045; x=1729191845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMbhqBUI4BThm42iYqRzGr0189fZkGi1HZ2Ne6+spLA=;
 b=HjsR8+vfBY6dE1bjdCZoPGsqL2KmHzoaMS/Bbn6sorp48aF/IQNXRrAXTaYtmCdIOb
 w9YPP9FM3M5sM9S6J01GZtz8sXCx4EtnaThX+NGOHE5pRQwRORL1up2b3Y6WcBWLD8Gh
 4FqgreIjRqIbq8G3Z74Vig2cCjPMaQmN4Bc5wsqcjBAMLMg3FT5HXSY+8Rci77szZc33
 MLVdUsop6884RAQPJ6Y58wTFAAL0RTDJ0mc7O4GDYzT2i0c9KfoQcpJkQfBLtSm8UuLq
 od3THXQJkz/J1EpohNc1Hxw5oIsmX8veOTg7bj5ZzvymHyd932PCNBvjmraPv7d5qqoC
 zRWA==
X-Gm-Message-State: AOJu0Yw7zmUL0KGw30ScwCvnOBx1kxE7diZyLdoN3C6Lr1GPbLlUnnl9
 Yrbu9ODGSaKAx6T6zQueHyKfFJ4lzR8ZWdVluUMNxf+ja+A/MU0i66vNCRKPfgP7PYE34tW1hkW
 R
X-Google-Smtp-Source: AGHT+IHbp1uGkw0ilcVCTKLbhAM/6+cZ3JOvqmiQKpmc1GXspro/ZT0rUyFxTKe/EdmOHWIleXur5A==
X-Received: by 2002:a05:6a00:2349:b0:714:3a4b:f78f with SMTP id
 d2e1a72fcca58-71e37f577aemr87636b3a.20.1728587045587; 
 Thu, 10 Oct 2024 12:04:05 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:04:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 7/8] target/riscv/kvm: remove irqchip_split() restriction
Date: Thu, 10 Oct 2024 16:03:36 -0300
Message-ID: <20241010190337.376987-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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

Remove the 'irqchip_split()' restriction in kvm_arch_init() now that
we have support for "-accel kvm,kernel-irqchip=split".

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a92a46694a..3d0584277c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1401,11 +1401,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    if (kvm_kernel_irqchip_split()) {
-        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
-        exit(1);
-    }
-
     /*
      * We can create the VAIA using the newer device control API.
      */
-- 
2.45.2


