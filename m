Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391CBD18138
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Pg4-0002Zr-4x; Mon, 14 Oct 2024 14:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfz-0002WM-MR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0Pfy-0005SI-1w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:20:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so10256395ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728930013; x=1729534813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDLYPeyJ2SpGytc6m82Xk9kQFJ8k5cOwhRWJOvX6Zsg=;
 b=f+M03EOBUQwo/xmiYicZeeBrZBAa1CYOc46GD0MJnNQOz92WE20iu9GcBQQNKe60K0
 GixcabDgeEneIV8ZqqWTB3tCN/qOQuG9naKSUm5lJ8aVxL0aJp+JEl+TVJYLwH/nI+KP
 EqAQ7w2KLf1vy6Z/NPyWz8Ad+puA4H9ljFQcw0252Ob9ja4hP/g5vjNblUpS8g/709Kd
 odosSUTEhBL7CCC+DfxXM+Xk50mtwa1gt09z8r/mNGJH8zr3hh0pIjL5QZF4/GHabccR
 EfyD/jiS9nFtAPzVZ4YHYvumoRNl223WsnqVEByF81r8TP+1iVy5UH8FVhAaFUrYPydz
 mtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930013; x=1729534813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDLYPeyJ2SpGytc6m82Xk9kQFJ8k5cOwhRWJOvX6Zsg=;
 b=QCeMmaTsx2ApOjv9KcT1NuwuG0znTXafC8kZZJOh5xgD4hd4VJCJia4DuwuzkpiRo+
 NNaSErvf13dV8gI+2gnGyhlP0cJWI3FbIZ+nO2iPXHJHi3g0d9I//sawvBMLu+ZkzQT+
 NZTnMZfjjVP/iiTYmFOxJry8LM40j96TPc8CTxe6O675/RD1GGRYg3Dn8WVGnsaffecb
 GDKuNcrMIiL6bU94zR+sEGSnERzyaPr4zFdsmJs73QEU8Z4a7/1zOL1iRqvsX6mZHnAU
 zBYjXies0+smLJtkrEPSq1v0u1lIOTQeHrKxLOxhPN0oA2mtFFhPJXu0wh5P8khtFTLD
 vKFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJnEiC6MSnOQxsLUOiTcvxhKs2pTWRxZ4OdY6k1xvpf0kv+3Vh6I6WXQUURtmUsXZuOOozH6EuFq+J@nongnu.org
X-Gm-Message-State: AOJu0Yw8veRdgFXJzkyRn3zniV7O+IcAYBWiAXw9qqa3e0bPnqEYRe8M
 Dehq2abo9u5xlmjDhUg1R0DUGb4WFl1eQ0+Y+W4HjgnxaCzgGUKeK11tmM70CgA=
X-Google-Smtp-Source: AGHT+IFI8Zdki0yxQLzFQrSdayla/1ZgC22fWP9QcCjdTjc930fHMhuxUgPYQuYE/axYIqcrOTlmTg==
X-Received: by 2002:a17:903:40ce:b0:20c:70ab:b9c3 with SMTP id
 d9443c01a7336-20ca147b50dmr125642005ad.34.1728930012753; 
 Mon, 14 Oct 2024 11:20:12 -0700 (PDT)
Received: from fchang-1826.. (1-169-245-242.dynamic-ip.hinet.net.
 [1.169.245.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c375d0csm68964525ad.304.2024.10.14.11.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:20:12 -0700 (PDT)
From: frank.chang@sifive.com
To: 
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-devel@nongnu.org (open list:All patches CC here),
 Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v7 5/5] target/riscv: Add Smrnmi cpu extension
Date: Tue, 15 Oct 2024 02:19:48 +0800
Message-Id: <20241014181948.1974405-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014181948.1974405-1-frank.chang@sifive.com>
References: <20241014181948.1974405-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

This adds the properties for ISA extension Smrnmi.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b3195da512..fed64741d1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
@@ -1502,6 +1503,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.34.1


