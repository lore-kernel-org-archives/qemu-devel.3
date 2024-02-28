Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA2AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfP23-0000m6-B6; Wed, 28 Feb 2024 13:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP21-0000lG-Uz
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:54 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP1z-0006u7-Ng
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:53 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7c7c984699fso22739f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709146310; x=1709751110;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=905pMmDAunh5nIsFS3DLPx4ZT1e5JqkKJba1GCgIYNc=;
 b=xO/0NnmQncXCIxU5RdHBj2QTTdWIqkekNexT/7ScDnRWsQZ5kavIQmxr+bVxaWuXj9
 wFMe0XGHnnVB7BRnLNUAqkaTME/sXsI+iBVTbSOL4Jqdx4bPXooHT2L6L7pWHnXz8iV2
 xYIBuxyncv6KzBHmSkq9Zs8hs4dpKymbXd1+q1CauerUY+cJLwBwVFUSuaw/ZP8SDdnO
 rgD6r70tjIHVSMLqUzzYwmbaxd9UF2aY2LU57iC9EsooLUINxhj+5yEdEk2oaxOf07oW
 jH9oftbKc1XfNe2szexfRn1YD763QdhpOR9ksj4CNeViSUVftxGKVAyPwP6vFYT5vZEl
 3b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709146310; x=1709751110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=905pMmDAunh5nIsFS3DLPx4ZT1e5JqkKJba1GCgIYNc=;
 b=lAbsxHnxUS6Y/B4affuHLVtXb7AR/qNDFnBg8hbH/nYeI+jUfU5+hb34xvRsHbwOV4
 Uj+gjfgDfx8hEr+jS1sILpcEA2isjhzP8IXLC+zJ4Tlw6IwJemWDedOrWOBD1DOaHwk0
 UGzPwLvARD+d8AOBxWT3kv+yrmQmhkVdi1vtM+mDk1zqgG0b5IglgNjtB/zeC6IxsKeW
 Bn5/cQYLerNPAG+HHn+GsX0Ajxl8r9v7CMNfx/8lxAvq4KMAXkuXUXje4KRn85JQNqX+
 IvA5O1C0cnstRu5q95rWhsy5hGtWTq/fls/ulyh7/FS6dQmvHjHeHYQzjFHBpkQkNQqt
 RSZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLdIDkhKD0ZKUXo82n4jH9b2VJ8wKyglBzppSXKyfnZ7tlj1j56z7iQwO0Vga67on5TWCsAYsCSUW+PfYNFZHxXbhMjP8=
X-Gm-Message-State: AOJu0YwmmwwLNfuf2nM2LnXL9IPUJ+sQb+wB8bEd5nllvOjwz1jkh/jV
 QrWHy0CrOxS38H19M1zEygyCEHbYlWVSvRv9NH5IpXcdakY9fjSNJlE7yqKEByE=
X-Google-Smtp-Source: AGHT+IGOZPVwhrgVdVZalS9avQitXnwjafgOydkdsKjokZodMvmu4yNfuyyxZgRkXL4J93BFjOgfuw==
X-Received: by 2002:a92:dccd:0:b0:364:1b46:607d with SMTP id
 b13-20020a92dccd000000b003641b46607dmr149147ilr.5.1709146310506; 
 Wed, 28 Feb 2024 10:51:50 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a635d54000000b005dbed0ffb10sm49562pgm.83.2024.02.28.10.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 10:51:50 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v5 2/5] target/riscv: Add cycle & instret privilege mode
 filtering properties
Date: Wed, 28 Feb 2024 10:51:13 -0800
Message-Id: <20240228185116.1321730-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228185116.1321730-1-atishp@rivosinc.com>
References: <20240228185116.1321730-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=atishp@rivosinc.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This adds the properties for ISA extension smcntrpmf. Patches
implementing it will follow.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b8d001d237f..f9d3c80597fc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -169,6 +169,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
@@ -1447,6 +1448,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
+    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 833bf5821708..0828841445c5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -73,6 +73,7 @@ struct RISCVCPUConfig {
     bool ext_zihpm;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcntrpmf;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
-- 
2.34.1


