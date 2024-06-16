Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C000C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvM-0007Re-Ug; Sat, 15 Jun 2024 22:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvL-0007Pm-B5
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvJ-0001iG-BP
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so29456895ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506035; x=1719110835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Zx8it72Zy7Z5HxasQNNaxMP/T5FQJ8nmED3Hly6Uyg=;
 b=XYZSSuMOL6sATp2WoZJXkFMxMGBtdAC22y202yJ89KJn9z8UQjmY8G5DogEecK+tc4
 ktfXB3l5uvFM+gicql6fqHrFtazYXBpPfZXkKg6oS/OHIfqypgvo70hd3WYRv8TtCP8Y
 0nHkWKv0SVJuwuXcDk5DaAtBBDO4KWpdxPCdHZpDN/bLoN0gFZ7YE8m2Def+Uf+swIB/
 in7WPCdh2uTfuhlZ01TYh/ZQxpk5UvTdfdgb4Tj8l5EKhaDIHZRDSGMCzckJ77Gs0ePd
 KOUl5GKcDCLwR/+FeBZEyfBsxP99B5POsC2qqbmNx4pWvfSE2rlyY03Pz+GnCQYlzGrC
 GxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506035; x=1719110835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Zx8it72Zy7Z5HxasQNNaxMP/T5FQJ8nmED3Hly6Uyg=;
 b=IEBxXDB665SDlWuKZIKDZkLITCLf7WTt1wda2RSfWkDwZXbjYJ7Qbo0M8wEoYqU9a2
 3j6W4okoRvhbRed7/Grnta+Mqmr30AV5B4KrtiGT4ccIiBzC0oURUPzRK/ygPegWswdf
 YJ6e2ORdMq6fKgOnZWKDRMf8YiqeYPuiFD8+v4zuQcz8X8nzoIrcyneDtQO0h3FTqgg9
 Y5s0VMzKkWqTWwxVGoLr7r0mUsLheM9KNf7FTGw4tDnr9pSYuviR8EYVV6y8Pbw90NEy
 1Wk/LP8828Suks2MF2/s9ltBn/i5nEcf97DUzgkXLvHSwQaknGgIwkpx4wFo5Rwsc8Ul
 a/fA==
X-Gm-Message-State: AOJu0Yy/5qEbUj95/UZfUoPgHNuQBfOi/tNDATRPdY7unuGSSPP1kTKK
 ENVXh+SxW+0B9dQJXKgya6NKSohEG3xIDV+/pW/NQ5Td1/T7kdS410i9jtp5lD/Tnv/lsSqQl0o
 mWVGw8fj85mhGQIVi3136Zaf66UzA6Wu1fl5gxk3djVvcID4hos8tQBLTPKxMiwxUuRV4MIVJIt
 Sd9dXT+jOGt7FV/Jv8h8QROq1QYWHk3X+Dd9IM4ms=
X-Google-Smtp-Source: AGHT+IGSv3zdtIKPscfm5xzHKxjYzELkUR0jj257FJoS+Z0FeFZOz7XLxnwYBdZv9j0OUtk8okqiSg==
X-Received: by 2002:a17:902:7883:b0:1f6:1780:f7b1 with SMTP id
 d9443c01a7336-1f8625d3880mr55457285ad.17.1718506034491; 
 Sat, 15 Jun 2024 19:47:14 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:14 -0700 (PDT)
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
Subject: [PATCH v2 4/6] target/riscv: Add standard extension implied rules
Date: Sun, 16 Jun 2024 10:46:55 +0800
Message-ID: <20240616024657.17948-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616024657.17948-1-frank.chang@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frank Chang <frank.chang@sifive.com>

Add standard extension implied rules to enable the implied extensions of
the standard extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 340 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d09b5e9e62..1a3b1387e1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2297,12 +2297,352 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcb),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcd),
+    .implied_misas = RVD,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCE_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zce),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zcb), CPU_CFG_OFFSET(ext_zcmp),
+        CPU_CFG_OFFSET(ext_zcmt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCF_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcf),
+    .implied_misas = RVF,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCMP_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcmp),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zca),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZCMT_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zcmt),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zca), CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZDINX_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zdinx),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zfinx),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfa),
+    .implied_misas = RVF,
+    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule ZFBFMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfbfmin),
+    .implied_misas = RVF,
+    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule ZFH_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfh),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zfhmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZFHMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfhmin),
+    .implied_misas = RVF,
+    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule ZFINX_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zfinx),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZHINX_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zhinx),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zhinxmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZHINXMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zhinxmin),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zfinx),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZICNTR_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zicntr),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZIHPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zihpm),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZK_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zk),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zkn), CPU_CFG_OFFSET(ext_zkr),
+        CPU_CFG_OFFSET(ext_zkt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZKN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zkn),
+    .implied_exts = {
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
+    .implied_exts = {
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
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvkb),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE32F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve32f),
+    .implied_misas = RVF,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE32X_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve32x),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE64D_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve64d),
+    .implied_misas = RVD,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve64f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE64F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve64f),
+    .implied_misas = RVF,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zve64x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVE64X_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zve64x),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFBFMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfmin),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFBFWMA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfwma),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvfbfmin), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFH_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfh),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zfhmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfhmin),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvkn),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvkned), CPU_CFG_OFFSET(ext_zvknhb),
+        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKNC_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvknc),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvbc),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvkng),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvkg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvknhb),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve64x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKS_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvks),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvksed), CPU_CFG_OFFSET(ext_zvksh),
+        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKSC_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvksc),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvbc),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvksg),
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvkg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {
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


