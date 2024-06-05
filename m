Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkCE-0000sx-T3; Wed, 05 Jun 2024 02:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC6-0000qT-60
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkC3-0007De-Lr
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f692d6e990so18023225ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569137; x=1718173937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMInlFL188ZWR1mMyu2viiuWqvKsDnAijhCCsb0k4W8=;
 b=kJ4e4Zhr7cKUHg3TCZz26Fs15OlgU4hRtBsc4th24uuqAEAs4BIn0iMQucfuwCSDJk
 ZpJdlAd4A2SJolXgmYhWOzkMSx8rV9zl6CkIPfKphvVAv2aDwvIbO8d2uaXSLmHQxD4w
 7uDV77BprYCNHg7EN283DrkSBuGk1USvXM5K3yXzvm13e1AECa8DryKsSx3aNDL2qL+6
 6pG9aP3h5QQVJgQUm3AeZw1r8hHCXprez9UU5G3AaYv/DolqguDyVHh9gxO3i+nFJcgW
 87TqbifgXObHYAnYle2B38zdXEjUmBPMTRvvqqRFE6hqgq7MuOBW2Y3kA+qxY19EK+IA
 fSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569137; x=1718173937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMInlFL188ZWR1mMyu2viiuWqvKsDnAijhCCsb0k4W8=;
 b=ZoIL+1D2eR9b9iiO1G40OQVBylZa8jHXAynLVQ171uhvCm8S04vq0pP3hy52T8Lk1L
 05HMBS02G3n8xHuQy8FgM7syyMnZNJD9HQPxeqU8mOM+e+hdTxB5tAZK7P0ZJOtl38hs
 EYmfIjrM+Oiuf6LHKxxDRHSR+ZavSq/Irz2vwIseqYup2YCijdsCLBrxhoSuYlwd89EJ
 2Zi1WpsrouwMg3aIXKeO6gbZToRoo4Ru8Y6gTypf9B7ABCEBVunNh2oIqG/88qApZZKK
 BGy7zNdpaUgfO2hXwy5DEu42vIzzic7SZpEYdCX1R908Pa9jxGU1PM9PmTvU2KVEyW9B
 6/Lw==
X-Gm-Message-State: AOJu0YyNcL7aeJzaZePSu7wA0XCkiZVED+BS/AW6ClRTQW1jhRLiE2P7
 KZ+m3Z3Dcw4toEzPZhbEx6dLS2y71belY3P09Ph8UT2D3nkVbQ0R4YssvyZ8euE0hEiDENnXhK/
 vRTv5x6iiFglHBWtFW0fR0VHmPlOHlnne8d5SNEMrV6PY5pJKFX9J8bUmZ2eLNr0Mjff6P0cB2z
 OccaEF/+9krtefYKevuTia2u4h+xeNMWr6U+Hq69eNdw==
X-Google-Smtp-Source: AGHT+IETueM9ksvD6vVqcJB3LQOyBzxGxemLZ1c1L+mmE2eDxivg/MvSHHzqPj9smz/ieh9VY7IiWw==
X-Received: by 2002:a17:902:dac1:b0:1f6:6a85:7ab3 with SMTP id
 d9443c01a7336-1f6a5a874acmr20349375ad.66.1717569137122; 
 Tue, 04 Jun 2024 23:32:17 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356c84sm94819725ad.76.2024.06.04.23.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 23:32:16 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH RESEND 4/6] target/riscv: Add standard extension implied rules
Date: Wed,  5 Jun 2024 14:31:52 +0800
Message-ID: <20240605063154.31298-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240605063154.31298-1-frank.chang@sifive.com>
References: <20240605063154.31298-1-frank.chang@sifive.com>
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
---
 target/riscv/cpu.c | 340 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a6e9055c5f..80b238060a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2289,12 +2289,352 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
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


