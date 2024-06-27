Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A29BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxk-0007P1-IZ; Thu, 27 Jun 2024 06:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxg-00078J-T9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:42 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxb-0002LB-LK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:40 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7f38f5584ebso294339039f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482553; x=1720087353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3b4i1MebHelO8I9kGEWGTWysdpA0laU5VjzsEYbS4w=;
 b=jikOLZxx11Q3QYE6zxTh/d2Cfb5nSpxUIjMHfuPQr1u1w5AZnIIj4qPiQ8503db6Td
 Sx+t1sbVz3OBzvJm9fyBLJ5MQ7RNfySyyapa+DJRnikECsgCN3TaApRGNN1jXBEerUK1
 2izAEPWkJ/f2gNffXwmVdrAEUGHaUQmAP+Qf898pYPf3NwSD7wE2EjB8c7l91n+/Ub4u
 scfxPH+X+dgQBAkde+pZOzoDwNQUQntwGfFybQlPFFSsh1wJLObFViga1qNhwKwjplCr
 s1twZW9qrfRPObcKDcxroOX6RgBso+GbJ4mrcn95cOpOIlfBuGyNpNwzagrCxx1KlVyO
 3Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482553; x=1720087353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3b4i1MebHelO8I9kGEWGTWysdpA0laU5VjzsEYbS4w=;
 b=FWgP4xOwVmuTpQmrrtZHvw68kxkQe7R1Hk7pTAw9S7t6Efg14e5OMe//38IdvOVekW
 46Zwi3zYFkjHhbE+56i/5kyX2pzLyEBt0rEYBhLY6gPCluutQG84rCgOIDiK9uyufM0Y
 VBTu9gCGYIMGodzAEYGrpieWUEZ7cCNgP24Sp29z/WWFPuUp4p+EOv+rW/F/Qhi7CKLd
 CTx91vKomsUn2i0VoQ6uWvgcK3oBfPgokTfbaMn+14PuMXmDWUqZml8J9IuGmW5a1l4u
 FD9dy0LzBpuIv+Ce2ZZ1KzHjhUMgrwsD4zTVTwDDjk1xrxX41Lx3k2ofYmmzoOSXBgOT
 svpA==
X-Gm-Message-State: AOJu0YyQP8ZNIgu34zFvBcQ8Ru+Jqib7RxAhLA9BIFffBJbCQCxCTo/B
 8Ey70mXYnVwg61ckB4GeL0tZZBc5z3pjjOdoOxBmi7uYV9Hetv72LVGx7ZSh
X-Google-Smtp-Source: AGHT+IHVhTDcL4fZw0QdopDpSTnzN6sCGIUt84GQR18fIeKROJAC4knWU00AewUDkSIni8CttZijCg==
X-Received: by 2002:a05:6602:2d82:b0:7eb:8a6e:11e1 with SMTP id
 ca18e2360f4ac-7f3a4dc2c31mr1765560839f.5.1719482552823; 
 Thu, 27 Jun 2024 03:02:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 27/32] target/riscv: Add multi extension implied rules
Date: Thu, 27 Jun 2024 20:00:48 +1000
Message-ID: <20240627100053.150937-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Message-ID: <20240625114629.27793-5-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.45.2


