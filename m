Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E57EC48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89S-0003LO-Nz; Fri, 16 Feb 2024 19:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89Q-0003Kz-A1
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:01:52 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89L-0007uz-RP
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:01:49 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e0f5934813so2090114b3a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128106; x=1708732906;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0Fg3oLZqQjSAYBkitbDfSo4mh2A3osvSIf7Yp2p+8E=;
 b=zTpMKDqAA1Vx+VuphOoxZfI4mRSQTpJGvdy96VsE5yT+iSK8i77AQiUXG0MeoJV8PT
 hxZdN9rAhb/HIc0YeE0BHFf8n9chrFf/XYDl7dVyQkLixn9+Pkj5CZPTKaMG2bV2XZLr
 sPKCtousO3tC2Az0Fovqwfn8tVexYD1d7GA6so47vRtzaZ4RPe1pYZBUNrYxV4KSGcN0
 9Ew9SEszOacePRvJY/3CYZP8v6u/hiCQiIqct/n6AW9RqA0FuqtGEcj/pnlg4mYXakCX
 XvB1A5JkwVroKIjLqSBHjYdANUMKtyi7kJr5mWau44v5oBsPogUFB6rhokHWlL0zlRv4
 s13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128106; x=1708732906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0Fg3oLZqQjSAYBkitbDfSo4mh2A3osvSIf7Yp2p+8E=;
 b=jURUbSdwaHVa647wUo+g4zIC6miHgUN3ZYE00wbFP3/x4vdasaHm8yrGYleVuS0sHa
 CvS2iK8vZEdMUbX4p6mV4KrUTXD+xqgaaaVywfkPz5O5iNbzy6r1NyKix6KOPK3eEqGY
 hU3EvyOcqLTlhYiMQQTbAwnZjPRZBRyD7Oo7KocmlrgBWTe/gcufSfhNEtTBMXuVE388
 NPjCa/9sAD4zNPM7Dr5op6ilTwGXqW6RfhXnpQBlHxrgjgQwqYvi+TOkidsrWDskUnQa
 WmktqVizwyGSmz4enPX1drOXychRnlycTPCn8sTqjjgI52QhVTjxFHsCUA21O6tH1o+R
 Hk/g==
X-Gm-Message-State: AOJu0Yw39bHuCZqYgyAvCHSi2aOqHgZpuarI4bEBRxe31P1zGZcTyKHd
 Dy71z7KaNQDpeAozK+N7KES1lztB/KUSqOcpv9cYZ8i42GSV7a/MYEhwnHMzEFuBuC+F5G+9GlQ
 s
X-Google-Smtp-Source: AGHT+IGzADrYzPcNY3RqO3T1kyg8JFD4ffQbnJcozK4J7bG3yILjNQEKPD03Q9l72mQkHWAJLjCfPg==
X-Received: by 2002:aa7:860c:0:b0:6e1:1c:1125 with SMTP id
 p12-20020aa7860c000000b006e1001c1125mr6005694pfn.14.1708128105678; 
 Fri, 16 Feb 2024 16:01:45 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:45 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 1/8] target/riscv: Add properties for Indirect CSR Access
 extension
Date: Fri, 16 Feb 2024 16:01:27 -0800
Message-Id: <20240217000134.3634191-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c     | 4 ++++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8af99ed2f6de..ff7c6c7c380e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -152,10 +152,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
+    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1348,6 +1350,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
+    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
+    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index eabbecb8f962..b9086464752e 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -74,6 +74,8 @@ struct RISCVCPUConfig {
     bool ext_smstateen;
     bool ext_sstc;
     bool ext_smcntrpmf;
+    bool ext_smcsrind;
+    bool ext_sscsrind;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
-- 
2.34.1


