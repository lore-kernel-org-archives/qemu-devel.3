Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947BD10F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqNy-00010m-1b; Sun, 17 Nov 2024 20:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNu-00010R-9c
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:16:58 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNr-0006Ow-2Y
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:16:57 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so897482b3a.0
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892613; x=1732497413;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uVDgod62yjGMU8t9Rg8DGqOcOdlPeLLYYxxoHJ6HLro=;
 b=b+zwGVDLVkiX8BWbM+md5c5f39KMWzkJ/QONVDddM2LCBkrGNro8x11rT5+rHaPFww
 fQma5yXi+n8PXCW0r1zPHuwNPXSf8yyjWuaF7wZ6hwvfknOo7Bh+NLnjNbBWpeigzX9e
 RE+hqEcGsCEsR5YiglLcqNqInTuUZ7c1Va5SueVO43ojSRSMDncPfutOdtb/coGw/gxj
 1cqBgVLwwz//wknwFyVowVJCfHBU1Gam+0Es+znXM++RdvvMz10dyi+ckTYL1VekevP6
 pg+W77LIlTYWBaHx3Fp16tOliUPFIJQQ7b/gHSGNM6XzIWX8q6XWoMQ5iwTl3zKow2xg
 /6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892613; x=1732497413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVDgod62yjGMU8t9Rg8DGqOcOdlPeLLYYxxoHJ6HLro=;
 b=fzEXAeAauC/a/Nh52EJLgitnAHEi7xC6955z630CTiImvrhwS8eqO1Us2InAtLjZ46
 jkzrN+TkpuJVs3520nXKMDh0Wk/mOUORZAvmlfYMECcYNp9ZEIuH5QE+XyarbRncFQYR
 QNCcxr2a0vccfTzj5wKMJyi7DLcZiD3b9KJYDJJ+UbIQuusb0LsQUe50Hk6JXSlAj8Y5
 Ekogh/uOQ9jjsu6kymFXbig11yGGBCKVq1jRSTxO46zwVAnVWBPC3tIyxlagnYnY5aKp
 czr/okTawOYf3ptsGB2Ot/405C132en8NVMRBBRHBqtXrCFD6kMMZgEuOpLTDC1zl0Xz
 EMLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXQoB9OzAI1oK3pG0uBtZAudz7IMED1mCtjDGFuV8HxJYQYZUtbvtev7wUGjHacxmpzDsIJ0yRjBvK@nongnu.org
X-Gm-Message-State: AOJu0YxMGR+rmtUGQJwLFIkW8QFlYk7VR9zuJOja1Z0xbOrDaJr2gY7Z
 4GmASRIQE2fjXjV8TZbIbP3nqog4JP6n7FfNSMm2BeaYHKjyxnZGx4/eZLEL9+eMqNtJGVoNp0/
 7
X-Google-Smtp-Source: AGHT+IFnA6537lG99llz1ypDd70EUkTVq/708cu/67YCRwl0ssK1DFd4mrijpHvGUa0uj9i/L6PNpA==
X-Received: by 2002:a05:6a00:3a28:b0:724:5aac:1687 with SMTP id
 d2e1a72fcca58-72476d43285mr13727724b3a.20.1731892613282; 
 Sun, 17 Nov 2024 17:16:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:16:53 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:49 -0800
Subject: [PATCH v3 01/11] target/riscv: Add properties for Indirect CSR
 Access extension
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-1-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b527..963f1f3af9ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,12 +185,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d18..8b974255f6fb 100644
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

-- 
2.34.1


