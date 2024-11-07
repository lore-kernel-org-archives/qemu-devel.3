Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F1ED5AE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8trN-0006Lu-42; Wed, 06 Nov 2024 23:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trL-0006HR-64
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:11:03 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8trJ-00051D-Np
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:11:02 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20e6981ca77so6403855ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952660; x=1731557460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIhg5dboa4x/xyN0s29uEbsoGSKibvfs1Cx1DxBIl+s=;
 b=JRYk+doEjgho0Sr0DjrU434/uclv3TzwoAOE2FG9D7bXOLY4BBqEcmNxhioKRx3T1B
 tOi4rcU5BFflZZKxdlTXxN7RHhiYG6qxWZpEVEiH7BoGE0PQr1EsCbgKLwR5ZxrQPYMH
 hvAzkk0JkvMpcKHZpo2QwU/P5jPWhz0xBjyDtxJmG+cPePcC0HL8jgmkC8VPqfA3bTci
 m5w6ojzFcSXNx4Ihap1P8+Aryu5JE0Dsterfpgn6tNA5zMLnPPKP1bh3/OaMMaeeGWAe
 FsaD3tcFlq0Km4SxvYekjSfC020DPZtM/w6I7c8V4ueW+Hf2ZZFOOU3KT61pnIjLoNjY
 YyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952660; x=1731557460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIhg5dboa4x/xyN0s29uEbsoGSKibvfs1Cx1DxBIl+s=;
 b=DZZPOk61ModsPWfcfBbscAjiScZw5l+CBIqllUBR+kqbz8CK3eFeuTocOqAc8CD+Yn
 Kn6X9nYTdyUgVQO/kjxRYaUsNCMe+/VxFffMdzzAQaYWtxZUEZb/k9WzRdA0USgKnZsU
 x7GNkxEXU8wbP122B9l69bZb5OA+6g88Mq27eBQ1/WBXoZcmCyJyIgK1ASj3C9fyAtue
 qxkMDv8WziZRkEVw69ToYaIHfzeR5d/ExNgF0LjH+vIeUFsDc4kQGP5Gt0wA6k1i4CnE
 zBZ9MPdswOeeSmBhWzS94W2FTExWuleFVOLgBUfzFibiarJNCsaVl29cj2EuhCtTwNfB
 jnKA==
X-Gm-Message-State: AOJu0Ywkxh4f9tnks8mEUcIH5Pq9+6F7k89QqQASUTbJelhmmoGEYqra
 YIZSMXObk4AqQnmla3jK8vTqj/wGIseTEPib8zbviUHhgV+RsSneUsAbOA==
X-Google-Smtp-Source: AGHT+IEq54ZxHSFX5UqXrP8NxUvl+5zcP8RxqBHvdwIBsvDPWIenHv9GeJkYDCWGkA7epcSN2TmDVQ==
X-Received: by 2002:a17:902:f541:b0:20c:ee48:94f3 with SMTP id
 d9443c01a7336-211785e38b8mr6694515ad.14.1730952659908; 
 Wed, 06 Nov 2024 20:10:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:59 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Quan Zhou <zhouquan@iscas.ac.cn>,
 Andrew Jones <ajones@ventanamicro.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/12] target/riscv/kvm: Update kvm exts to Linux v6.11
Date: Thu,  7 Nov 2024 14:10:15 +1000
Message-ID: <20241107041016.40800-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Quan Zhou <zhouquan@iscas.ac.cn>

Add support for a few Zc* extensions, Zimop, Zcmop and Zawrs.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Message-ID: <ada40759a79c0728652ace59579aa843cb7bf53f.1727164986.git.zhouquan@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cbda4596da..c53ca1f76b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -281,7 +281,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
+    KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
+    KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
     KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
     KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
@@ -292,6 +295,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
     KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
     KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
+    KVM_EXT_CFG("zca", ext_zca, KVM_RISCV_ISA_EXT_ZCA),
+    KVM_EXT_CFG("zcb", ext_zcb, KVM_RISCV_ISA_EXT_ZCB),
+    KVM_EXT_CFG("zcd", ext_zcd, KVM_RISCV_ISA_EXT_ZCD),
+    KVM_EXT_CFG("zcf", ext_zcf, KVM_RISCV_ISA_EXT_ZCF),
     KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
     KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
     KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
-- 
2.47.0


