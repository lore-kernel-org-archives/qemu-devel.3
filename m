Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A5FD6C28B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTjK-0002oB-BA; Tue, 19 Nov 2024 14:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTjH-0002nT-6q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:39 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTjC-0007gz-A7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:38 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-72487ebd2f5so2857756b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043852; x=1732648652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtwIk6HkYOGhU19AjHqQe2GTivk7yu3nAfc701TP3rY=;
 b=SFhUoCFtiyJkooZ1abyOYMckkBAhSb2QVkIs5A8oxNlcz+Vkrk3YciRqC2Ajpa9g53
 zxWlWxeADQkn7H3RHHeYgXavc91+A0Su69VxhFDfffuefBgxPKk8pNeHIyyDKbAjcyeC
 +xwykqy87c9NTnfXW9bfvbR2JPd3+8do1Vn2LXlpOWvMRsZmP4ePOtqMHl8KwRJHcQFc
 wRj7y2fo1xHWXlQs5x7FMpy+leSsxFgUr6d1fWlzDmBCW47njotYA+aEAuCcjWYly1TA
 P5fvzVanrpu100JeMePP42UreHQq+vQIAED7Md7STfUPBvD4P2gQ5HpkvS4Daguv2amp
 tzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043852; x=1732648652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtwIk6HkYOGhU19AjHqQe2GTivk7yu3nAfc701TP3rY=;
 b=fQxiGemkkRRzO+DNBh/a+UxyOpw1Ucqtmwj8fYLComMkkZZBieOTxCrwFtpM6WdHaA
 /eJRHDNOCrL6ZR6LyzYsm+9r344bEExOv7Zxyay3bG2QLLBBbJc+efmv9LP+aN5Ty+ON
 vkD25Z5MWAkVX9TJmzP+2NMb/Mt/qt4IkpQZUhLPAKeMJ/yvcuvJo9J2m9hBd9x9GLi6
 e7LotMaOrBLR6/g/M7j0ZESB444p+ZoP+8HOeSqXwNRoG8zwpDeW1lb0/oE/UqDEsgV3
 hx6MwWkJgSH+sY/1x4obReMZTu01IDK1MH0QTaVKswYAmf/GZoScYPGvIxBe/cb8kkwm
 WH7Q==
X-Gm-Message-State: AOJu0YxV2xTBQifbM5zGyLn5NYzrg5qDC22ZRHEDYrG1KybC7tQyYv/0
 WYhNXSD9IvedsJqk3hqAg/hU+vpO3vwOhefQY8YYUzGHst6wCAJiGaG3jorRjRjTz1dD61PO8NU
 3
X-Google-Smtp-Source: AGHT+IFJ7QTNystlVZ/PA1M42dL8S4Kpg058GD/3NGQH57Q90TlCuRQ2Edmv3MwHWx3o0Zuo7P5fOA==
X-Received: by 2002:a05:6a00:1311:b0:724:5aac:1687 with SMTP id
 d2e1a72fcca58-724bed54e77mr175242b3a.20.1732043852617; 
 Tue, 19 Nov 2024 11:17:32 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:32 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 7/8] target/riscv/kvm: remove irqchip_split()
 restriction
Date: Tue, 19 Nov 2024 16:17:05 -0300
Message-ID: <20241119191706.718860-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a9680f2447..aaff4a0f42 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1408,11 +1408,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
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
2.47.0


