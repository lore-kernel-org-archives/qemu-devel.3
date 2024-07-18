Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2848FC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbu-0006Uj-3Y; Wed, 17 Jul 2024 22:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbs-0006NI-7f
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbq-0003TP-MR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fa9ecfb321so2835215ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268665; x=1721873465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBhEbZgxKwN8imJwjPHV7O09WyPrbNNlfJ4u8IYDLqE=;
 b=Z5tlFzUmOaVqk9JeL8/Mn/aNShAAit2TsOlHKf1g8rNrFNmsvSs0fEEt+j1ZJlwCxZ
 Q9Gt7KlyFqJyp8f+xQfKBxVKHPOYBApOI4tP7cw39QaZcgg9bEgfttSyRX6jlV9X1gjW
 LRABBqiC4atbQ+1k+rZMsaZJq+itvCj7IFxedSper3YiGjkaVqoK5X9Dr81cD9uW4Dtm
 JTUmx+H2rMRs8Q5pLo/KKgabitrsZGEfLtvyH1njMnZy18aBM2fHbjzTOE32uVm9jdFw
 2rLHZSCyOhBL4YhuMaJxXE1fx/iDCI8dU0rJ8yhtig9LprNarCBesFI7Qv4YeHjDUliW
 8vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268665; x=1721873465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBhEbZgxKwN8imJwjPHV7O09WyPrbNNlfJ4u8IYDLqE=;
 b=Rnc6O6M22Cr1RyJi6Vtl5SSN1WNy7NcnrNiDl6ihkRZf+rHB94z0WG8xlAXXO4DJGk
 nKwp02UGe0hoWm2ToYbxgNl3w783a5claVsnQo2VTBMZDSlTRiQWoEyhITV4Ib/Pf7Pd
 m9cm8WS09dyVGVi8w4ALqv9dtiljAEs7ds/nxv3tfP5jKQWMENbovxyEvbB28q3UIp3g
 ftbu/2+2iZaAtXp4qZ0a6vyNht7m4kcdtIAaIl74biBdXFz+Tm00E3NA7BK03Ki2c2Sv
 64HTTdudAnQpdkbowFedNJjXHHVsX3WXPibkjsP7uFZALRuTki0WO59Ki7ID2OjErKz5
 /pEA==
X-Gm-Message-State: AOJu0Yw+yRZ5PhozSmIAIkyFDASiquQmBR7I/Bx5SoZ+oSiW/4PGeIHI
 fJeLfbw338bJCJTdY2hULCdzHCRettyBaP9NQKpg8KA11NuzudrSV28gtub7
X-Google-Smtp-Source: AGHT+IHRBLjNjqOQaML08vVWXOu9h5Q/Vs2KXksyZrHplOcwGQq2vnIGduP6oPxTsWRWQj6i2OR86g==
X-Received: by 2002:a17:902:c406:b0:1f7:3d0d:4cd with SMTP id
 d9443c01a7336-1fc4e17bf10mr30771115ad.24.1721268665142; 
 Wed, 17 Jul 2024 19:11:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/30] target/riscv/kvm: update KVM regs to Linux 6.10-rc5
Date: Thu, 18 Jul 2024 12:09:56 +1000
Message-ID: <20240718021012.2057986-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Two new regs added: ztso and zacas.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240709085431.455541-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1047961fed..f6e3156b8d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -281,6 +281,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
     KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
     KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
@@ -298,6 +299,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zksed", ext_zksed, KVM_RISCV_ISA_EXT_ZKSED),
     KVM_EXT_CFG("zksh", ext_zksh, KVM_RISCV_ISA_EXT_ZKSH),
     KVM_EXT_CFG("zkt", ext_zkt, KVM_RISCV_ISA_EXT_ZKT),
+    KVM_EXT_CFG("ztso", ext_ztso, KVM_RISCV_ISA_EXT_ZTSO),
     KVM_EXT_CFG("zvbb", ext_zvbb, KVM_RISCV_ISA_EXT_ZVBB),
     KVM_EXT_CFG("zvbc", ext_zvbc, KVM_RISCV_ISA_EXT_ZVBC),
     KVM_EXT_CFG("zvfh", ext_zvfh, KVM_RISCV_ISA_EXT_ZVFH),
-- 
2.45.2


