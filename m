Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FDCD39420
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILc-00006p-1R; Thu, 02 Apr 2026 09:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8ILG-0006PC-AT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXW-0008N7-3e
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:52:52 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso768127a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134364; x=1775739164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYCYevpMfrK+zxSCLo4tPrMiTzPqUIxo8+gm2PMHzc8=;
 b=UO4NXoOmP8cIijlpWZXqJj3zCCSuFfJEy0YqEmd6dSObCiPeFxDjUqD10EweRYEdVY
 pHrCOKlsWQUVFlsGWlVW0GP7K1XrQGHzI5wRnQLsFduOOzmTBm7odvZ36PFZqNie+hev
 N9uP8Dh3da8MYKXFptINnVuCNCHLnNakrkP/VEpq6xLq7/9dLvHMkrfjUNs91We7wOyi
 WjsVqrrayaofuqa9/CmQBbYrid27Or9vH5XPbtFWVtHZTEx5fAWFslMul2B9KNxOduX4
 IvPsSSLN8RlpeFNIB1kp7rBnY6audoWANpXsQ+AvafUuMrn9Yr7AnQ3csoJE218Ti7qH
 7GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134364; x=1775739164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qYCYevpMfrK+zxSCLo4tPrMiTzPqUIxo8+gm2PMHzc8=;
 b=FFfdhBZrbkisOdL1Ctkq+ri1Fk05u/yTIDJnSHp6Uvj6K2WlZc8UiBLfSOXVWRxp7z
 X25M8Z6RdEtvTEh2nxon+ABrEqxqnzTJLji9jXQE/ZvR6hQDPiwCnSErOjrH7OWxrhiE
 d2z4PXwcgrr212qhEukCs2NKTIo2B5gbRrIZZpaUzCqrbUtCrDL61bqJedBD5wXulE2X
 aTRqeYVUF98T22GF/NxiQ816iXUz08GwrUFMrCInroxNbYDy3JYFEH59Tj30L5BTWqrZ
 gLzbYk8A+7rpdcLqIk1zpeQGmo6ZkOrrfQkBKiQaWL3lhVX6m+dxbs8pER6nmUB6uzuu
 KROQ==
X-Gm-Message-State: AOJu0YyiVi8MNKD7FfFdzMrrUU2GnXwk8EQaUnyYT19oZ6MUQ1lCbm6K
 hbY/X0vfIjvAG+GY372xJCg+bloI654DO7gMB4YO5Py71RDVVd4NgSTH+2K+Mi8mEtSX6sxURxb
 OGdkd/HuedQXVSA7qsNyq+uVSlhPmUkC93L6sIK/fZpHq5cDtd+UnL6M5AFfJ+4Rir/tZKOUiGy
 CHLPD29SZsLzjBLSmOvO7bb6SabM2YkhVEhuJ4nco=
X-Gm-Gg: AeBDieuyQWYWr/uDv5A6ASD3+/KDjO4rwnnPh5JFLEBM9JS3Moibf7sCXnkZTTukQUs
 F5mQrbmlvqZth3rs3VNTbM91FC3PGmBJSBHLmu53bWKtkVSH6fZY8ENahfoBAWBWAeQpljVQqQL
 5iESpyvTfsdcPspJeNKVOLuFFBmzSwALK+PqpnEbwoUjCuJ/LX2Q4Ri6o0MqxbMfzNrrX6mjsBS
 Oqex7zMenlwImZ+gDxL65hu7hUMjZrmDGRKLq+tCszQynm7UC64rXJ2cIlK7dVp+FctYs2fROqs
 o80OnWWNYad9LQvm2REJ05B8SzVPWqF7DaniKCzuBPUooevaZZcsPVCPV0Ye5ebLdud3QNcikdc
 m8F3xzbvx5HSSJXleMhnZGerp4odAB2637KhoMbjolU8vBlkEjf2jKQlaBOmTNgjZZ6Se6RAzLY
 1lINAjfrSGq2VkIfleJ/yZ0akJkCKhymP35+LQzX/pSPbV8AbNuvVqzX7zkNXyDa02SmeVqz7+f
 weRw/5bGJw2ge2tSFMW/Kfq/xY=
X-Received: by 2002:a17:90a:da8b:b0:35b:929f:7e92 with SMTP id
 98e67ed59e1d1-35dd40dc877mr3329170a91.18.1775134363739; 
 Thu, 02 Apr 2026 05:52:43 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:43 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 1/9] target/riscv: Add cfg properties for Zvfbfa extensions
Date: Thu,  2 Apr 2026 20:52:26 +0800
Message-ID: <20260402125234.1371897-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Zvfbfa extension adds more complete BF16 vector compute support
and requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 03a1bb075a..7c652dea78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
+    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index d4b7c880d4..734fa079f2 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -100,6 +100,7 @@ BOOL_FIELD(ext_zvks)
 BOOL_FIELD(ext_zvksc)
 BOOL_FIELD(ext_zvksg)
 BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfa)
 BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3407191c22..c4f7da7193 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfbfa) {
+        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
+            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
+                             "and Zfbfmin extension");
+            return;
+        }
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
-- 
2.52.0


