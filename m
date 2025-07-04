Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E2EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMQ-0002qV-4M; Fri, 04 Jul 2025 07:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLs-00023l-0P
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLp-00035E-UI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23508d30142so11797135ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627584; x=1752232384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wukv0DOSwKF1QSCxncv8qsgC08USos6JXcq8SCd4uBQ=;
 b=Sx0NKX4LmaiuyizSkLew4tRPP4ZSyhyjSIZJ4+NJ/PGdKbeJHDmZQ1fT7+K/ivs7Gw
 QEGNnnv+WkaloT75bAjPFM2wHYhU9RzebLOUOfdvr9F5ZMY2hbH0/oGUv/nsGXUn768p
 JhEqU50PMGR4Yab5LeNHmeSDtnaRCPNASAJA3FV2+rWj1ysTrr9uIKggB4P2ej53giG0
 KzAniDRBZXfPUc5fNnGXvCt0QJwiDYuiOdmhIs/yrfvXEfK3Cp97QqfxMv4eSViVHyV2
 s2e7GpeS6shIWN2gsP0eFAsNf1VIUuHEBwuSs69OYt2CRQWKiVbqj4/WaXWMGAe8dEkC
 ZECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627584; x=1752232384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wukv0DOSwKF1QSCxncv8qsgC08USos6JXcq8SCd4uBQ=;
 b=kyweF8u/m+s0H45+8NN/A7M/otHqemiKlIZm6EsCxg93CFIbQYSErRsaq7nPrSS/vE
 v+7DwVNGFkmCcJfMlwwZUaSM72fpkJlvcrLJyGGaEiK+C05VIJ4XH73mRqcxjyRmD7H5
 b23+qQZ0Bg4tLdpUbf9UxpLPavOSAQKj+SxTSyCYJHnb6Mfj/CTT/uhZF0RBXfaiSJFG
 biLNXBl0SOODRA/8BLP0wUOzvmqTHLdFVwFqF1lYWnQuBVW7e202ym8r465i3YvOHgVZ
 KqIGitKK5vNMWZq2b0Cy5K6U7bStdie8qzREzpW9zwf+/CNJTD9SHzoIuC8gfKSmvtWd
 SInQ==
X-Gm-Message-State: AOJu0Yyc/D5yvQo8P7gtlS0N1mbYepnVKwLttetODAMvHnkSNv/liizV
 0no0KKuJfZk3phqhUawMOmZ/qpVQQ4TEXGdnBrpvIAeNSgvYYFjDMfXUYOZCAA==
X-Gm-Gg: ASbGncv+cxmGYUFXcm6tQjPH945PkO0B2H24tDv+NYK7yUALmhr8HE6A1oszyP5V+4+
 /kZ2pOYzZj60k0Vq14fQuW6CKVt/dfCTPX8qdCRJppjB2+7PPty4owpI8kaVVi6DCjHhPZpNJPe
 DvLCQqRf7YRY0t6Zsa5G5B+afIih1rr9rljQXFryTxRwELfpGudnHkhkn1Xm1ELBHGlrbdqn8HT
 42QT9l3PClMXVAVdwifza04LE3dW/Ye44AI7ghd9X7w0EJ4kVUsZHsaAlgLS2a1GksmkQHV31lN
 O7WGhysFtS0WI0N4eFr3jeYA4ButLdqJY3YSrWs0oWGtAb34m4q7mMWv4EvAyUJYvsAP1ppDnWD
 iDc7RCKD8DK+PM4+YR42aCvvKLGN9D0Kkfgu1XkCciw1MkQyocoA6AZfXzKyEWKjEtbE=
X-Google-Smtp-Source: AGHT+IH+AWo/IcZ4BEX1UjGbQUrAWmsL8Ey8njCOSZURfp9354abzclw0s9pa5wNZkZctopv9QcrHw==
X-Received: by 2002:a17:902:e5c1:b0:235:ecf2:393 with SMTP id
 d9443c01a7336-23c85ecb801mr41712735ad.53.1751627584010; 
 Fri, 04 Jul 2025 04:13:04 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/40] target/riscv/cpu.c: add 'sdtrig' in riscv,isa
Date: Fri,  4 Jul 2025 21:11:38 +1000
Message-ID: <20250704111207.591994-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

We have support for sdtrig for awhile but we are not advertising it. It
is enabled by default via the 'debug' flag. Use the same flag to also
advertise sdtrig.

Add an exception in disable_priv_spec_isa_exts() to avoid spamming
warnings for 'sdtrig' for vendor CPUs like sifive_u.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250604174329.1147549-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 target/riscv/tcg/tcg-cpu.c        |   9 +++++++++
 tests/data/acpi/riscv64/virt/RHCT | Bin 400 -> 406 bytes
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7c6e0844d0..b4e7eff331 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 81174de409..163e7ce364 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -451,6 +451,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
                 continue;
             }
 
+            /*
+             * cpu.debug = true is marked as 'sdtrig', priv spec 1.12.
+             * Skip this warning since existing CPUs with older priv
+             * spec and debug = true will be impacted.
+             */
+            if (!strcmp(edata->name, "sdtrig")) {
+                continue;
+            }
+
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
 
             /*
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 13c8025b86..156607dec4 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.50.0


