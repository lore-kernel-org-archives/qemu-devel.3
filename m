Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLT-0004k1-Qk; Fri, 17 Jan 2025 00:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLS-0004jY-17
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:38 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLQ-0005xD-H5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:37 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166022c5caso28742315ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093395; x=1737698195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ns2SZo6J1ZJQLcHXaGJS2LfH5vBStHvDZXJNG1Vraik=;
 b=laJuZkhMeHUaon54sCdb2u7KwPdVDRmoe8naArE8ENFaHDzVqWR4Lp+LDeQYQB2T1B
 PTYiPXmqgbDpnlWwHmcS7mg+N6iKv8fuzoMC6GJp0C1T6T6t1faGA3Iwf+1o33jaMXFn
 dVv47KZBDusv11eCb1yOxVCfmMxZosvtniGHGFO5OC2jDgGFdUIwcfhFaS2SOXN6oARo
 Ld6YSD6c567yzHcB9hAUQlP93l4QtV0n5nj2mkuJ0KDU4jFuzVsrlx4N2NuNczHYCh3j
 f4cqC2Q7VC4PXHUl+LROoIa04PPxJd3qnBRkuqcWYRwD7H01Wh0Zz0IfR4iMK/mPq091
 Gh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093395; x=1737698195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ns2SZo6J1ZJQLcHXaGJS2LfH5vBStHvDZXJNG1Vraik=;
 b=c/ZRoG1cDDesZ8tFDpppRthQrwyCr4I2v8Y5NL4kH6fTqL319yC4Cy1NZX4qB0MygP
 IATP2EFwEPkquYoqN5kzr8dmrAHujS1DMjuEfhFtGyLRzzirQtR9/292kwWdLi4o7jTi
 lHIL/xs/Jxmid8fQmv/Hwsj2UIyDuXvsCPE6ewwkzayHeSIZEjYdNXjou7juw61QRKti
 GZyjTKoA1/mIVLVaDui+3f/SD9cq2n22jE/4XTP/fIjwAjMZMDnYtwk1z7mx0kjbDLkd
 IZGvz2faR1RyoNffx6j9foyuh9v915E0DMToMc4lS3dBW2zq/J80nXRk+F1kEVF1AEOy
 Kh9A==
X-Gm-Message-State: AOJu0Yzj/Fr+oiALKVLgav3+aHhXCr//Rt7TcjUxPPemVGCd0kn/J6+0
 l5mqefT/71hA/6Sgm0N2ToMRXK9z2bawkoFoxKTsj17S8wK6QNbU/uYLug==
X-Gm-Gg: ASbGncu3tVyYqUTPSGfUD8kodcOEKMrTT3zqvdXyK0AhBLWbgjxvmWzG6Sr3WL2NExr
 ++BBOSZnIod0cah6OmHSczRiUBxh9LXM2oGUREWQg9B8DNd5xAO8iXuHQTw8LT7iEl6iILWvmEX
 06axtE0zZaiaKXIvR9Mk9oOyLPO/08CBjepWopL1UOoIsrbZVA/5Na7Dl1eIu8Cw2qV9rKzuRbt
 fjt1NOOK87HxdwO5l8evDKjht0nFbH9dJcIdGK/8zlJ0zM5l3c/ooM9cl4ov2uqlNq0nuafbhse
 xn6wguHIgEu4d4Yx+GOnC0pxCJ/oajNCYKR9Be1NHl2wcgqXtJdOYlA6b9im
X-Google-Smtp-Source: AGHT+IFBYyDC1EVKoaSvq8f4DKO0f5Ls7YJrUOaUk1oyjZpEA8nZBgjsU0iH62ueKrL02tjks7/2HQ==
X-Received: by 2002:a17:902:cec6:b0:216:5568:38c9 with SMTP id
 d9443c01a7336-21c35574ee8mr20143045ad.31.1737093394942; 
 Thu, 16 Jan 2025 21:56:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/50] target/riscv/tcg: add sha
Date: Fri, 17 Jan 2025 15:55:12 +1000
Message-ID: <20250117055552.108376-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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
Message-ID: <20241218114026.1652352-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 8 ++++++++
 3 files changed, 11 insertions(+)

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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3e138572d4..954425081d 100644
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
@@ -1714,6 +1715,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
+    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
 
     { },
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8b89c99c0f..e03b409248 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -212,6 +212,11 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
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
@@ -352,6 +357,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
                           cpu->cfg.cboz_blocksize == 64;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
+
+    cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
+                       cpu->cfg.ext_ssstateen;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.1


