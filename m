Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52A2C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtM-0005io-73; Sat, 18 Jan 2025 20:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtK-0005e1-Lg
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:18 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtJ-0003Ks-00
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:18 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so4702222a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249255; x=1737854055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LHXMBF6i1q7RRjNkT6ZcWgA0CuRJJd6cB+bhUvNlRg=;
 b=eZJXade34d3vyLrJrLYM/XHMt7J4za1yjs2jKFqqL7JaeUzUrSKKujY6xbwDTMPRSD
 BPyq/XBGhKTDKHssIdWJT4ofr/oXmRC1BIdSt1n/fl/s2ggB6QLs/eW9D+o4iz8p27gQ
 7KhWC0HNao5c42+XPhyfGkIh/rN2K7wfONP5DaHGu94kxezuM5iyantOftOIx8nJHri1
 hhUS7la3M4+SsGImj43cLQNrEEU83e2SKMNP7hQmhbFbdH0TWBI2aY10WHE68hrwkVLc
 dvA9gj/oOssUybJ+rQ33jY/UWuW+gtyJmPoaCvgGgy7YDcSU2fdXMSDDPXfmtfkU+do7
 O6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249255; x=1737854055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LHXMBF6i1q7RRjNkT6ZcWgA0CuRJJd6cB+bhUvNlRg=;
 b=Ip0wUjaqgDbi2okaZUNXE3iEc7Zc7n0aKc5NVM8Avw7c5sIXPG0DJTk1p3i1GsuP/J
 ogoLzV4OCNe7YEtUi0OGlFCds1g1iVus4Q1d5+q1Peorn2DE0lQ70jgFiqtcLI1vxtnU
 ck303mFPcraFSkC2JOSAUBCj2mLmGC94bdGNqlLYbM9s9/So9XuJrLWGrl790cskHMbY
 xyL9XUtA/1b5HdWFFZ548vGH5dZEwBJUOgpR3w22XmtGjrWGwIcdshcxX541v5OI2qpM
 8F1NPiQUuFlYUNwcLjYHZbLcv6mKtLQyp4WI/q2SNJ0O/MxfL/hH+hfMI+0iu7X2kUx/
 PItw==
X-Gm-Message-State: AOJu0YzqwXjJfpJB3hud8pCj8ymccJpGdjkZaBZ63wrQKCOyehc0bD8n
 H4uiojQYSk/LLFEbb0tGrCpY2xvWI6VmLh4cUZQFtYvqQKEuEUvCj+T0x4Hp
X-Gm-Gg: ASbGncvDtov4EHDUeAXoVr+lV9RvbHSztXMXOqWOVBnSSsUcqP9IrLsOlelPHPiyBWF
 4NlggLn/AVHZW4l9R/KDQWdi7LYW579RUNaJH4v5GYLTyUBKst9DatGKLPwOk5O2c9GkE22hJsA
 5V+G2AbyWS2aVcHEuL7TydzNcFrU/Hwyd2LTmNBHN0wdZvjWTghWXgOvsiUpRh+en98+6B4n9/3
 +g4Dr1hl9Znb9J2/7C55Bj+B/QM9x/NNmgkuvaKf7V2sUXjdH86d9XuHbpAGEtN3/eoRtAEvCrl
 XAElrl23DZsTnPYUqUyoEwW9ufbvStGK4zRFUxyvpsubl//0ge7bvhwvJIFzytVz9QhWYl6org=
 =
X-Google-Smtp-Source: AGHT+IEssHuh6zF3OwrMK4BngBUfA8Pi6Ix9k8LcgORQLRcvNZPV0DrEY3B1j2PKzF0lQ02BgukG1w==
X-Received: by 2002:a17:90b:2dc9:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2f782d306f5mr11166568a91.25.1737249255538; 
 Sat, 18 Jan 2025 17:14:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL v2 28/50] target/riscv: Add properties for Indirect CSR Access
 extension
Date: Sun, 19 Jan 2025 11:12:03 +1000
Message-ID: <20250119011225.11452-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the properties for sxcsrind. Definitions of new registers and
implementations will come with future patches.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-1-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 2 ++
 target/riscv/cpu.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ee7c908710..4fe2144ec7 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -79,6 +79,8 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_smcsrind;
+    bool ext_sscsrind;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dace670e5e..4f5772ae5b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -192,6 +192,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -201,6 +202,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
-- 
2.48.1


