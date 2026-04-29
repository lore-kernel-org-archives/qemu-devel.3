Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657E3FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwsa-0005uy-20; Wed, 29 Apr 2026 00:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsX-0005kM-Ki
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsV-0000Zy-IT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so58107065ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438226; x=1778043026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZGBDYnwZqSqs28QzjXN8Q4ySmk72zZ3GUDndcMdMCw=;
 b=J/RKSGC+48CrpmKdNcPc4SKRFLhj1Y29yXLaC96MYEJ8FdbbInKhIZqaPrYOVbman+
 yvcVKH3cm/3IXJWjrX5gFIZdySqtr3cdnugTCGHdq2na9qyddy7j/KMwI4jXrAnzNMN7
 dTFBOmqldqPo+7pc9PQnwp2jFiqNQcNQlYqB7sx0LrwE3tnHqoN/JtJaQl/aozXu4Mrv
 oytlb/w9+fKHDbhxdzZfMQ3x9LxzZ5vnKFylBlDGkzghWFOeIgPKxzOC6iLs1Ra+4xDB
 3HUshS8kGVbdyz6WkP9lxG/deEnYI0e0p4w6kY6Ie2u7h54CrZYwVTvqki2Wr/qy1MpL
 FCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438226; x=1778043026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cZGBDYnwZqSqs28QzjXN8Q4ySmk72zZ3GUDndcMdMCw=;
 b=NZnMGHo+iuOJo/d+4t2WDQ+YIPoh/RzqDF7Lnw/ZBmm7zZDdTvOSl2lxaPzwKpQJVu
 3bKCfv2jpU5Q0z5FxGssAfrd1g9UjX5JW1qGUSWe07BHx8XvHbf7vfe59MjhDTCZGv+z
 acnFN4N0JAsk5Y6lyB3VqFkd2W44BUUAO7zfSmgnndsHSFsDKcRz/MvaGm4m4ZIlmRSQ
 IhsNU5BB5vooY2VCYlkJRZugJ93HdC79HJ3xg9qa8oQu4Hh1lBF3urgZ4LAt9XH5BhFM
 1JbZF3QlQGf03PO/hOys7wJHDOsdBN0nIS1G3W2Ywb6UKammsb3RygyDVO7EX9aplWMZ
 zabQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aOC5wgTcBi7m5wDv4qMGnFlpidSz9Sjf2G3U7N1qDE/Cx+HyvJcdpHYhKi3j3Pn19/b6wi0l23Jhz@nongnu.org
X-Gm-Message-State: AOJu0YzF7brwpgHTj3lox4r4PL+Hg0BXyzdkKtuSEZVdm6R9IRVPnFTa
 6aDGsM6j8Pz8Rf2c8zTSgSs+S8ktV4IIbZX0IAJgMpHhCnPVIV4g/XnZ
X-Gm-Gg: AeBDiesTyGjKEzPX0Yfr+X6J/CtYs+oo/TQkLdZPBKvNznFBfky3S5guhAaopRuG8v9
 ClcQtcDkOu28u577qVn9Fc4cariXWpRdtDr2F995TFxEm/9J7P6CBWM8lZ/Yk5GI27ju3v63oHh
 d1nJD0hYDxKrasDL7QX3fxVit/oy/RiYJ41cWnnybx61TUKVktPy64aBPSqINeyYbAdBQWzTbCL
 +tHIboLZ+TmlDOdFYF6+8+S8eC9Wm4NCTtPvt4iwEsI2cmvSRp/DaYd97vea6u7NP7X53885PrF
 dw6O0nZoZ04ZWrDQ6m/jT+87rV83D6TxyNlmMhfqMm0Zd86GxbduUHmYA1V6pi5DbtmZLMkAji1
 FqY83FeGpkgLGHFYbNi39/Ug+G+WnmOROC5zKkWsX0aKCTYvu2Y6mxJogKEJHPEnf9U9T4WvMBy
 i3wsZYYYrhMJdQ+MTrw6bn8wxpXkUpJo6bNZlmB/i19AoZDQb1BiAEOTUruTrseTc=
X-Received: by 2002:a17:903:3c6b:b0:2b2:50e1:f104 with SMTP id
 d9443c01a7336-2b97c3d4e15mr62616045ad.3.1777438226290; 
 Tue, 28 Apr 2026 21:50:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/51] target/riscv: Add cfg properties for Zvfbfa extensions
Date: Wed, 29 Apr 2026 14:47:28 +1000
Message-ID: <20260429044752.4176397-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Max Chou <max.chou@sifive.com>

The Zvfbfa extension adds more complete BF16 vector compute support
and requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/cpu.c                | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

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
2.53.0


