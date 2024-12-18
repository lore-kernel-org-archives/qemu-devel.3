Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB6FE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQd-0007gg-6b; Wed, 18 Dec 2024 06:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQV-0007ce-1s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:18 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQR-0007xx-TK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:41:13 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166651f752so66857245ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522068; x=1735126868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQDYd8goWFdiiQvBBrxBKIN+0R/MG7OS8oAWf14cKlo=;
 b=eNgTxk8Tk1rQ+yXxzcUQhtl+CCtpalQMKYx4TvMdyHH4p2CVP5332Ihp28XpUDc74M
 PvbJaSjVBuXVuGkZhTEfwBtEoNJiH3ECv2M0bIwfZZfMdL9bR33JUx0ZLHDnpnVNr0qU
 YsOWcxGVtn6wHR/3MXSV4iHaAaF8RFhb5sOa4ilEiDh9jmP9A9CwRrYyu1fhD23LSwod
 +dsCMNYn4zbmZjuNJ1XqnPbyQDqf31Urim1f416TKzVQa6e/s3uLhIQWtGiouvJ8aY82
 zxRdWOhhigPNXkIkksF60GGYxMVSivBniQKCruIN/m4rXRzhxJz1S5wgl4fqJGmanS3M
 zWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522068; x=1735126868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQDYd8goWFdiiQvBBrxBKIN+0R/MG7OS8oAWf14cKlo=;
 b=K4iaA6VXaevOzqgHT2MQT6B3rOGikMgF5zvcli/uhdUBpXu7FQDAp1xmQj192yTY10
 Eq8T8zebS6acs+e+FglpQE5XQRsomanpBb4vp1JSbRFfhVONU9RxhU7UyP9u8NuGQnKD
 hoTkUzP8VOwoFw4b6+AFa2ZTSvPqvb7adJKwRnMH4oPZ0vIWYVOOLjJncYSK3543jDSd
 w/jCd7pdjo0sRdRzL8QTtw/jphZoIQOPoPBKSTORISBsx1BU8hVgKEcxEfu9hrydIKVl
 sjX5Z8gvcMLtT+4OxCY7AxqxWBlOaoNkESVD5i2T4Z9U2oWkTiTQG0+31A7cV3u7iQKy
 CzlA==
X-Gm-Message-State: AOJu0YyvH84gGJvhc213uf0biy0U4vpQi8km6cLAXkCtPS+wNuyKXUWQ
 IbmIElIb88XUtEsD+RLZuaiXMIQbYc4b3kbSYLVSMjfttN7OE89oH2VsCYR2qyZn1BnstJLOSBO
 rWDM=
X-Gm-Gg: ASbGncvALS9ZtAXJpYfEOttPfiF2nfDNGX7XnMzuGxMIPwZ/w2zOFFCZh7rgzfFNLs6
 2Vxt3SNAHLjusbe2MkUkK9srePqJXvjQ3RHU0AaLyy7qcbmp5vxgY4sFcEJVs4t5EWSkB97gtpS
 LB6YYTtfsw+0HaRcwIU4BtYy4siRDPNtHBVoMWzVTl7k3RkqVUZoGk8uHRVJ0J2LMW7Ya3yCzEp
 C4bJs1OaiSZZawOTWMWKL1B2PDvFyzHY+5gtNFOxrtJXV6/oOa37xXqouquutJ1Uj43BKxY78UC
 Uw==
X-Google-Smtp-Source: AGHT+IGlbMKzSjQAr7+Exa84raNs/YbPOp6zO5xXJkkL81Qk7Rib8vvf8G97aZgunyVRf322FWA6hQ==
X-Received: by 2002:a17:902:d481:b0:215:385e:921c with SMTP id
 d9443c01a7336-218d726cbf6mr29639195ad.51.1734522068679; 
 Wed, 18 Dec 2024 03:41:08 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:41:08 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 9/9] target/riscv/tcg: add sha
Date: Wed, 18 Dec 2024 08:40:26 -0300
Message-ID: <20241218114026.1652352-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

'sha' is the augmented hypervisor extension, defined in RVA22 as a set of
the following extensions:

- RVH
- Ssstateen
- Shcounterenw (always present)
- Shvstvala (always present)
- Shtvala (always present)
- Shvstvecd (always present)
- Shvsatpa (always present)
- Shgatpa (always present)

We can claim support for 'sha' by checking if we have RVH and ssstateen.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 41629019e2..9b55198a46 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1713,6 +1714,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
+    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a1457ab4f4..fe0c4173d2 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -141,6 +141,7 @@ struct RISCVCPUConfig {
     bool ext_svade;
     bool ext_zic64b;
     bool ext_ssstateen;
+    bool ext_sha;
 
     /*
      * Always 'true' booleans for named features
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cbf2cf1963..3480767b35 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -210,6 +210,11 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
         break;
+    case CPU_CFG_OFFSET(ext_sha):
+        if (!cpu_misa_ext_is_user_set(RVH)) {
+            riscv_cpu_write_misa_bit(cpu, RVH, true);
+        }
+        /* fallthrough */
     case CPU_CFG_OFFSET(ext_ssstateen):
         cpu->cfg.ext_smstateen = true;
         break;
@@ -350,6 +355,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
                           cpu->cfg.cboz_blocksize == 64;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
+
+    cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
+                       cpu->cfg.ext_ssstateen;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.1


