Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAF606B2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=g6ZUfV/K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgt1-0002dJ-9G; Wed, 04 Nov 2026 14:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsf-0002Ib-E3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:51 -0500
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsd-0002Lq-Bv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:44 -0500
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so1923240c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821361; x=1794426161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vwhROYoIVDL7uqD7PhyM1wXYwIRPQhsV7AJeWRT7iDY=;
 b=g6ZUfV/K21aeDTEZ47H71RFeOy+JnOw5LPBOzdMzbx2us7pSIApIcKwUCLXsib4AL9
 TvVGOvR4KfDTDvbv2AOpldD0E6DaPhtlT12CxAPdR0Ie5vL/CDjrNNjvnMAMNazdmll1
 ldoyH34goHcWCCHRTn1XRLP2toqBvrjVWCD6l42viXGE/gLjy7DpgMf6YRmGSGVlRLnL
 cIix2jhpsJNFAa8OHYVE/i27FDL3MlOcUkhLAmbyRr7y/v/c/Ps9H8iAOVThUDCzUGD/
 O5lLtyaASFtC5zX6MuMBBGDOAval0E3608TcNqhpOHNkqq+UgDdQFOmaCCDg9vSDC1vo
 Ofgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821361; x=1794426161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vwhROYoIVDL7uqD7PhyM1wXYwIRPQhsV7AJeWRT7iDY=;
 b=mwWtNhYqJN489u9K4v/Z3Fqb9BQ3PY8IT9y1IxXcWH+9Azdwn8iqeFp4e1DanFu2vv
 aAUjRhZNT93m6BT6XMCyTWMKQ3E2wmfxEuaj7MRgGNw2zTTLH3UXPIOK7UEzRQetVV4E
 QL2Uwty2pJFSSaVyfN68LFMTmcwH8fgwszZg5Obw9p1jLp01MYpFY3SgMA1om2VE/LL9
 go8Y3wT2uMqxOLKLzBSQJ3Jvg4ncGO64cCRhtDzLFE8EsTxH0ZpJViUjsHTYMSax0Di6
 qlj9jD/Ec1nKb7jdop4FugNeR1SJsiOO8/Xd4YH+P9ge5KZ09q8gxuRfs8xHJqJqDFnT
 oHiA==
X-Gm-Message-State: APuU4Z+dQd1yrbTGziD5EQyyHnEKXA7pIVcvlEEBW6nIjIum2LFPv61V
 GwH5tIM7DBZoDyPj/onaMMfLQ19xJDoVrTc8nt9H5MlKtQkbKMiLsJXyCKUMwEKEQ3QV9RrHDqy
 JQ3B7sr0XfP+HloSTiVPJMhO/cj7B7bnlatuZsMK3DOLYkYWm8wJjaCEmSVXbJOcNVAvdJWG9xq
 FZLh51bQhsRs9LWrIC8n2L/epcYK19PMdH0qTk1JuvPQ==
X-Gm-Gg: AYBFou2TAZfpn8DosvxUq3acD+5iYUrOWECag977Shuef8JIO/g6qfCX238+TdTcZkb
 v82wRgSZP0ybtai9JjzlhE6YCfDUmSIGzz/4DlmX16mBXUhCzJUcuBSgNZspbL6A7lFwq5X5l92
 tTNHt716RTIdAVzvcTx26POauBeP3pnKb71k9B3opqDqdPSrj4mF2WxtMitB9Eurkne7qw9GGBd
 5SXvNUbz+sXMD/DAC4Ry1JPaFLB99vyoUMsIl/Ku/KRpoxhv2Tr/nzC9uS2dl6zG1ote2+Us8Qf
 0SeJUf3sc12hphNJPcAcqlzbM8lpTAG525Z2rSD4B1Tku/UZnLiXgc55uHW1ZtukCMl81q2oslX
 HbY6m5Rm/v70kD4PvfSQNKNxKhgaEIkwwSG4hW3ad0v/4wdJmMUNprqqQs6U3gd4QJjYUnJ0tJ6
 ixTi3ASx75q9GJMOPK8pPN27MEMkYGQan0VyJYupLScWIhIUIsEVy9chUuzaHP2hHeG+Mv8o1zS
 RNxEQOp2vPJVHvajg6s893Z4DOuegy5MriM9Su9UOk/pp4nIhethZ/PS35nDheVUcdnf38++k+6
 gJesw23FDw02XGFyDQixmWJsYFfrV/sYMDwuEbnG4ePjvUnq4Map7/89/pQgiwTwiUaxrML8SSI
 ZZM7Erfu22+0Uv+SQ1vmDRnJDc3K1
X-Received: by 2002:a05:693c:42d3:b0:36a:1452:8dad with SMTP id
 5a478bee46e88-36a4244dbfcmr24530484eec.20.1793821360900; 
 Wed, 04 Nov 2026 11:42:40 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:40 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 08/38] target/riscv: Add Zvqwdota16i cpu property
Date: Thu,  5 Nov 2026 03:41:23 +0800
Message-ID: <20261104194155.679241-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=max.chou@sifive.com; helo=mail-dl1-x1234.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CPU configuration property of Zvqwdota16i extension which depends on
the Zve64x extension per the specification.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/tcg/vector_helper.c  | 4 +++-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08b14782451..7873e67c053 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -250,6 +250,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
+                                    ext_zvqwdota16i),
     ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
                                     ext_zvqwdota8i),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 0c08d688ac1..8bac69a17f7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvqwdota16i)
 BOOL_FIELD(ext_zvqwdota8i)
 BOOL_FIELD(ext_sdext)
 BOOL_FIELD(ext_sdtrig)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1c51ea94489..54749125acf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -696,6 +696,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvqwdota16i && !cpu->cfg.ext_zve64x) {
+        error_setg(errp, "Zvqwdota16i extension depends on Zve64x extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 6abcf522648..6d79fb5d299 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     target_ulong reserved = 0;
 
     if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvqwdota16i ||
         riscv_cpu_cfg(env)->ext_zvqwdota8i) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
@@ -93,7 +94,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                         cpu->cfg.ext_zvqwdota8i);
         break;
     case MO_16:
-        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
+                        cpu->cfg.ext_zvqwdota16i);
         break;
     default:
         break;
-- 
2.56.0


