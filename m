Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4530CC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4df-00083E-L8; Tue, 25 Jun 2024 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4db-00081l-Qn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:47:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dZ-0000cv-9g
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:47:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f480624d10so44549435ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719316019; x=1719920819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lbsxmg90aTd6nFIb0DqMgD+2BW+Kj7xCn7qm3Ilobms=;
 b=Nt7WTw4nRfLOc/H/CnRHJjwkVpuNziMkPEtLQtMmng30GqKWhjlf6eEyWCfYOE/3kh
 CHmh90WaxAj4giZ/5zgU+ajvvkKfxJ6TK/v2e2xOuw74CysW+X+8Y5JafINgM3sBgP9F
 gF5QqJhYE99hVboysj1gJ4nWipknIajZTBPIGgv++q5G9o7c7VLIR1RjJE5ZdXlQfVuh
 2hzFlweYsQTARsCo8H3tEPjx/Za09LCjMNILh5m5SHvoe0fAmL+lIX2ym2NwM/G7s1Ko
 KCovC20F7UsYuJ17p8e1jRNX0gA9hy72KlOwN5eKY5mzw7/GjoEzQEHLcsujQkm8rsc/
 6jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316019; x=1719920819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lbsxmg90aTd6nFIb0DqMgD+2BW+Kj7xCn7qm3Ilobms=;
 b=ElaY7f44yIJJ+3HkTMLTxZO6U1+5dM1HK1L1xjJcdbE4nxsGUVMl06futnb8jXJSgZ
 GW0K/teLHBsxdUE6Mg9KDPethCqQJcoWMwbv1rotuW5f5DeknPkvyHvzH/VccyEk35Ms
 5cAMj7IiWZomCuwMtSR0oWYSh3FaoTh/hY2HPrn07t8h9Sk2rR7x7IS2t5eWld8qcdT6
 mle4iURvGNvkrHDUFMQnKeJc4iC9RK+W2Fv02mks2TsRV1oEYB7Vol68w845ZOFdLZPz
 s3RSlRYHA+mxDWEXVdn/A2U8qgeduATHHuCfkpgK7YBo4vJ6GtMJfJH/gbPHF2HJ7dsW
 G8Aw==
X-Gm-Message-State: AOJu0YwIOPs4L1//XZ9oQIny5wJ/UgSQ7z9pPTYUES4MZAXKiR5xRNsY
 wCjSkZw/03K4ZkhPsW3M3ntRzxWuWwemzbmEa/aXgaEKCpWUEdC1Nf8g0l2z+vU7HOUrL0P1PDB
 WAr+u5wBG1R3NLUuI2QM2DvSDosq6ikLOYPhkenuLPugO94XdR0CCQLxF2KxjgmqVT0G5O8bO+n
 XiNVWDZQoTSQzVUsH3VCiZn/Qn3XV/N84kBOlQ8RAY9E1I
X-Google-Smtp-Source: AGHT+IHWTYhFMMaeZ1FXCxTWHZyKoUmxN4wbVk6PvfZkbHis/sAFikNiJUBbSGavUu8/Uf2LXTQCHg==
X-Received: by 2002:a17:902:ec84:b0:1f9:a4bf:de10 with SMTP id
 d9443c01a7336-1fa1d3e0120mr115375845ad.2.1719316019100; 
 Tue, 25 Jun 2024 04:46:59 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321d4esm79472325ad.67.2024.06.25.04.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:46:58 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 4/6] target/riscv: Add multi extension implied rules
Date: Tue, 25 Jun 2024 19:46:27 +0800
Message-ID: <20240625114629.27793-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240625114629.27793-1-frank.chang@sifive.com>
References: <20240625114629.27793-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Add multi extension implied rules to enable the implied extensions of
the multi extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 340 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b463bd8370..a2640cf259 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2297,12 +2297,352 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcb),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcd),
+    .implied_misa_exts = RVD,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCE_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zce),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zcb), CPU_CFG_OFFSET(ext_zcmp),
+        CPU_CFG_OFFSET(ext_zcmt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCF_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcf),
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCMP_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcmp),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCMT_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcmt),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zca), CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZDINX_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zdinx),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zfinx),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfa),
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule ZFBFMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfbfmin),
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule ZFH_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfh),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zfhmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZFHMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfhmin),
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule ZFINX_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfinx),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZHINX_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zhinx),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zhinxmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZHINXMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zhinxmin),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zfinx),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZICNTR_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zicntr),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZIHPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zihpm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZK_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zk),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zkn), CPU_CFG_OFFSET(ext_zkr),
+        CPU_CFG_OFFSET(ext_zkt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZKN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zkn),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zbkb), CPU_CFG_OFFSET(ext_zbkc),
+        CPU_CFG_OFFSET(ext_zbkx), CPU_CFG_OFFSET(ext_zkne),
+        CPU_CFG_OFFSET(ext_zknd), CPU_CFG_OFFSET(ext_zknh),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZKS_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zks),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zbkb), CPU_CFG_OFFSET(ext_zbkc),
+        CPU_CFG_OFFSET(ext_zbkx), CPU_CFG_OFFSET(ext_zksed),
+        CPU_CFG_OFFSET(ext_zksh),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVBB_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvbb),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvkb),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE32F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve32f),
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE32X_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve32x),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE64D_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve64d),
+    .implied_misa_exts = RVD,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve64f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE64F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve64f),
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zve64x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE64X_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve64x),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFBFMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfmin),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFBFWMA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfwma),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvfbfmin), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFH_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfh),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zfhmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfhmin),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvkn),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvkned), CPU_CFG_OFFSET(ext_zvknhb),
+        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKNC_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvknc),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvbc),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvkng),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvkg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvknhb),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve64x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKS_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvks),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvksed), CPU_CFG_OFFSET(ext_zvksh),
+        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKSC_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvksc),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvbc),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvksg),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvkg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
+    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
+    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
+    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
+    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
+    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
+    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
+    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
+    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
+    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
     NULL
 };
 
-- 
2.43.2


