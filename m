Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378E5F51415
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLE-00038h-UO; Fri, 06 Mar 2026 02:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLD-00037U-Np
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:19 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLA-0007gg-N6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:19 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82989744ee0so1424028b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781073; x=1773385873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAJGv84Ss1wrOGywljZlC4+g4uy/tSqZFBXfSaBqFpE=;
 b=jc/IIg2aVUcdnPdbnkHLd33S2cHybUKKDcms3mh9GTBoo/w2TeY1sH6SpD8vpNS4HZ
 NSBPBIEbXnHoPF4i8DgBObq6+s5VmZ/4SVhsNPXFH4AWrrEqVFHBV7sT2QEwUmU3eRmM
 +w6w7ws+mp0AG+dXU8LQv9IrB0rGUYAo7bgkAznZ4YUAfCCePz3kOBj/TR8ybKuK7wCQ
 cqc+krkyqKlIl4+kKvCdW66jTndTdQ1OHg8xNtu8DSKRCR8Fm/SxUea9EoWRjPph2tGq
 kRabrhINW1YcbhaSig23J5zqMkHXnHleCnSZzPCovm687qpvJK2SuoaiV500s58OIc1r
 uXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781073; x=1773385873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAJGv84Ss1wrOGywljZlC4+g4uy/tSqZFBXfSaBqFpE=;
 b=Bx/mHajjCFAaq1hC9E9+wYImthLJHsJ/f3yYlH8TKOhzw8vznGaUm9ro/6dbdC8QHk
 O5yC15w85JRTWJBM/arD4P+JqPcmoRf+J3M+tEgpoh1RBOLy7qGEgYzFAQosTjqMB9tn
 ziL+4LD0CzfEnByA7bpVBzXmfreC0jVnHfRqrfpLcBWiCy/hdamCuUFro10vxqjfJSm0
 l8d2wOUoVRb1P5g5pMZ8+/XseXcBK4hnijaRwd8KghGbNcXMdeTT4PqEiGjZTHcRM4aJ
 QnuuKMWwq5ZT2El7Ag2LJiDO3DcTIsl5pBQhyRRZ8k68SzBueA8g/SPQkUBVQbpzJk9e
 fTuQ==
X-Gm-Message-State: AOJu0YwlWvVDBdrDYXHgNH48a5mTkbUpmNVkYvxsBxoA4kRDUlOgVWUO
 OjQjMZXUwBP6CGiFL/UKfUvkT+TGYbxt5vOHUZCCds7RdZloGt4A/XA8ykVK9u3nfv6n7tFZsVF
 KiEcDqdVk1+Iq3u4spe/6PuceCBPQ+wy8yRWMigP0ohan3GjAsAzrvrzUDO340M9cCnKfmU4gEA
 uA9XA6zG07QXOYen/I0wS1Z5tGSDclzTrZFGu4wU9P5/7n
X-Gm-Gg: ATEYQzxhQaP3yerTW9cDNRN58bijTAc5qQ0gYppzG4XCAi1jr1g8TQK3ID/bnFL7FnO
 51eTrbwOh2iYaAo7co4wUv9Y9m5lQW4H6lJDEyWYJ/2sRKoni5bcBjxPm69OttiEO30Qm+63Jaf
 ExhGS6cbSGmY+I1GvFY634VfekuNwhnT9O67Y8ReN1pjBlOLTWnBMtge2CN9fcZnvNLpEfCnNGO
 MI1fqkmfEJsPBo6+SiL9LBZNbZ3/c5ag2x7fWSZ4twjOj8oRvUAm0SbPuQC6y2G2b6tf1z0F9iU
 /Rb/on1ChKopx+ACx3eDD2zsE64c6ojq+pFHQ22QI80rYusddBxfYhPWrHSUUwx/VN5wWx1Dzg3
 iRR2Iw6Grp/uIBsuaP+xUHu8NZFpoAwak1TXHb18BGwVCGCQPvpkZgDblvWoMDKe+pyoC3JYfTI
 qJCt1JnMmJmcfXqa72edphDq9hLSGs4A2AQZ0a6cpCIU8t90O8yEEGEQwsSxeg7JeUl69GXq9A4
 e1FgzTizPyJLufYcAnjZVx70Z4=
X-Received: by 2002:a05:6a00:7487:b0:829:82f1:8bf7 with SMTP id
 d2e1a72fcca58-829a2d6e341mr861412b3a.11.1772781072930; 
 Thu, 05 Mar 2026 23:11:12 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:12 -0800 (PST)
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
Subject: [PATCH v5 1/9] target/riscv: Add cfg properties for Zvfbfa extensions
Date: Fri,  6 Mar 2026 15:10:56 +0800
Message-ID: <20260306071105.3328365-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42d.google.com
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
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9be79622f4..2ddc26c837 100644
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
index 70ec650abf..3696f02ee0 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
 BOOL_FIELD(ext_zvksc)
 BOOL_FIELD(ext_zvksg)
 BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfa)
 BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..720ff0c2a3 100644
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


