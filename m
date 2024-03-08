Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C02C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAQ-0008Al-Lp; Fri, 08 Mar 2024 06:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAL-0007mC-Em
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:29 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAI-0001iQ-RE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:29 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso5051465ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896405; x=1710501205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ie72vi7RW6BNE9TlURYsjSELR5HeYR9KkTQLpis4Is=;
 b=AoGy3PGnIEuFkJwOuTu4MVeKELTqa97mCLG8d325Y1I27Abz6l7CRA1vN+6qzt76iy
 tpc8XDhbA8MHQ+g78SDZpt+oFv+BVZJY0bbTGHAaUYwiFF+vUBkGZYH6O5i1QkYlLdFo
 IElrSNaF+9Q2PZcvuYyvLFqATbSP5IJa+c4bRa3JvxzQf1K7vEsQ/Wob16xGQTPQ+3wV
 +kpostSK1VeA/FcrSpHDtHZOxhwOV02oStc/WcmFYFIiN1H2fQy2btPvf3SrPfbwdEoU
 +7RZ/Zwo/ZKnmx/Oh8xG6ysLGJDdRSz/oIJusaawIwQwU2iydfatadbH2aYA0J3UOCAy
 b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896405; x=1710501205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ie72vi7RW6BNE9TlURYsjSELR5HeYR9KkTQLpis4Is=;
 b=qDZaE8STO4V5YRH+xnLMNpt/xtJzY3Ip38hClTa2yrElmO5NorUo2E3YW2gaaGNxZ4
 C6m0ti4Qne4/3QAHanvHv1esxvEV+n56IsPoioH3mPCeBNE+zoDjBk0PbBmXOl7Y1RIT
 NEyjLIPhb2Z7jcR52NOw14fNsYlJ+wtQYUATnwzwFbBG3yRXVRfGz+N/UESeFqrhAJhm
 TSqMQFDDMo7fISv++qmsmni0EeS6wmKeSMNHO6RPvj8eR3Ey9kvi7So1CXWnjHC1kbxz
 uwXrcnMXO89H1cqs+xEVd62g3Cjm1qDu3PwOuTxKsSXVlnJp2DrJHZzGtAIDmbyOrlf2
 5VdA==
X-Gm-Message-State: AOJu0Yy0GmKitkBYNwR7M7odHd+HeHKKPEI4zut5VbYGmFW37b7wX7KN
 qK8KfynN+XFITSGi0TI3UvBE4DxEjY+2Kd3HN1yAmoZOFDKo2dy2Z/9sV96EiCG9hA==
X-Google-Smtp-Source: AGHT+IG8IgJxC/MUAmiWIt59L/AZVS7IWCCtbn4WxCKr3IxgzP5H2JeQRlxaz2kvyeOF/rXcVHCY+w==
X-Received: by 2002:a17:903:1104:b0:1dc:a40c:31c6 with SMTP id
 n4-20020a170903110400b001dca40c31c6mr12266359plh.25.1709896404901; 
 Fri, 08 Mar 2024 03:13:24 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/34] target/riscv/kvm: update KVM exts to Linux 6.8
Date: Fri,  8 Mar 2024 21:11:43 +1000
Message-ID: <20240308111152.2856137-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

The last KVM extensions added were back in 6.6. Sync them to Linux 6.8.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240304134732.386590-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 422e4f121c..c7afdb1e81 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -275,13 +275,42 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
+    KVM_EXT_CFG("zicond", ext_zicond, KVM_RISCV_ISA_EXT_ZICOND),
     KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
     KVM_EXT_CFG("zifencei", ext_zifencei, KVM_RISCV_ISA_EXT_ZIFENCEI),
+    KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
+    KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
+    KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
     KVM_EXT_CFG("zba", ext_zba, KVM_RISCV_ISA_EXT_ZBA),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
+    KVM_EXT_CFG("zbc", ext_zbc, KVM_RISCV_ISA_EXT_ZBC),
+    KVM_EXT_CFG("zbkb", ext_zbkb, KVM_RISCV_ISA_EXT_ZBKB),
+    KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
+    KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
     KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
+    KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
+    KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
+    KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
+    KVM_EXT_CFG("zkr", ext_zkr, KVM_RISCV_ISA_EXT_ZKR),
+    KVM_EXT_CFG("zksed", ext_zksed, KVM_RISCV_ISA_EXT_ZKSED),
+    KVM_EXT_CFG("zksh", ext_zksh, KVM_RISCV_ISA_EXT_ZKSH),
+    KVM_EXT_CFG("zkt", ext_zkt, KVM_RISCV_ISA_EXT_ZKT),
+    KVM_EXT_CFG("zvbb", ext_zvbb, KVM_RISCV_ISA_EXT_ZVBB),
+    KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
+    KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
+    KVM_EXT_CFG("zvfhmin", ext_zvfhmin, KVM_RISCV_ISA_EXT_ZVFHMIN),
+    KVM_EXT_CFG("zvkb", ext_zvkb, KVM_RISCV_ISA_EXT_ZVKB),
+    KVM_EXT_CFG("zvkg", ext_zvkg, KVM_RISCV_ISA_EXT_ZVKG),
+    KVM_EXT_CFG("zvkned", ext_zvkned, KVM_RISCV_ISA_EXT_ZVKNED),
+    KVM_EXT_CFG("zvknha", ext_zvknha, KVM_RISCV_ISA_EXT_ZVKNHA),
+    KVM_EXT_CFG("zvknhb", ext_zvknhb, KVM_RISCV_ISA_EXT_ZVKNHB),
+    KVM_EXT_CFG("zvksed", ext_zvksed, KVM_RISCV_ISA_EXT_ZVKSED),
+    KVM_EXT_CFG("zvksh", ext_zvksh, KVM_RISCV_ISA_EXT_ZVKSH),
+    KVM_EXT_CFG("zvkt", ext_zvkt, KVM_RISCV_ISA_EXT_ZVKT),
+    KVM_EXT_CFG("smstateen", ext_smstateen, KVM_RISCV_ISA_EXT_SMSTATEEN),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
-- 
2.44.0


