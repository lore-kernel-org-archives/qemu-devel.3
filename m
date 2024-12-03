Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA825E77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6b-0001Jo-QR; Tue, 03 Dec 2024 18:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6Y-0001I4-F1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:54 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6W-0001JG-Eu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:54 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so4283395a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267691; x=1733872491;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FyiLgrScJsMZeBZ1bSE7OPq3hdaSp5RGPvZtqSAwd9A=;
 b=TJFXyVpAwEA+AURxZsP+8/xl+l541T+2tvSxpzBFBn90WCPOUcPeg5XS58e7h+16XC
 K03kPQmWuV2G5hVUUI4YFGvq6LYtx2Pzecf8s1ZP7EzYYFDSN0WHl7NNy3X1vtkqGn6t
 +xFPu3Qe5IFxVj+I6+Ko4iRu2RE8NmtYCz8DSkxSp196mfxsXWjhMJ+PUauw7iLZAIYN
 ZXj/8JCftE0MrgrdCvnmYz81AY1EYt2OB6UtgShxosfKWyy3GTkL3tw47z6omP/qNaT2
 KZ+vT+u11Bi/mYTGR/PTaqMKrdA6teucvO4yEaHJPta5U6viZrS0w6L1EIY4y3LHVAer
 NTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267691; x=1733872491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyiLgrScJsMZeBZ1bSE7OPq3hdaSp5RGPvZtqSAwd9A=;
 b=gvV+RYDQuiupBvA517w6YBvi5AkxyAaP7OBNEH9mRk+U+yQV/CzrbzFdpvV4DT5NOY
 kVd12eWKeWxrmGROmkrHHKLrcG1LgmwGM+qSjO/ZL2MdIVEH6JvwwZjUNTyExB3h0UbZ
 OmbJk2THo9ITG+LliUvxSjFppziK1TyKKkJRB6BzWWyYbVyrUTiXhIAWZxEmbALofUCc
 o9nJVuJO5v7IJbvahKnygzfIIPpUfk/1MNDp/yM/nYdOjBlEeGW9br1l1U34kIiSbMwI
 +BYlhqH/tNM6uEoOQZuH3C3qlgY8NN8U0/lDwNZ96rzsndveIX11RzTYmWfm2YrYHbYd
 b+Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO0MnzU2RpKww9iEuAFOeHITeQIAKDooAGdkYWiRCE8ow0iMzUleC7xMBcHHo9vpwLZA2QjU1Td93k@nongnu.org
X-Gm-Message-State: AOJu0Yxw7BanH5T+F2GmVfpp8NIZwkaKL/6snkGe0jmbehtYQUM8W2be
 YXkz/3ftAjycEnqhijJS8xMdLyqY5yFNzBLiQ/w08VGNBXLo+eIZ941YXdizot8=
X-Gm-Gg: ASbGncs6sLeycZC1Lu+mQE50krytYWFUyHN48Wei30qSU0AC4OUlStinDbBopHjFDEx
 5+nidxyXsBfNm5hTmR5OYdYzyxLLjRhsHDAtrGm6zN+1nIu98ThSIaQ62OyOp8BISGmVZxlxC8m
 mbhLMQwOKsx3mzQetv54ERZpKjBFzeYWNPwifcs+6J5ZQ6RBBZCFcc1wR3xqE+AJWDDn0kM85Ef
 pskuHTNUzJTCc3/2/plXmDyZw8Xa5LUe6CwzjXA2knJ63HdZP3eImtW5ONC14c=
X-Google-Smtp-Source: AGHT+IEfbIvb8FoeZ5Y1G7BRUQ1hMVBquV2hB0NHd2V183vF8K7nU3w+h4tC7Zmj43pxEPqnrokZ8g==
X-Received: by 2002:a05:6a20:748f:b0:1db:d932:ddcc with SMTP id
 adf61e73a8af0-1e1653c4a75mr6491682637.19.1733267691121; 
 Tue, 03 Dec 2024 15:14:51 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:50 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:43 -0800
Subject: [PATCH v4 05/11] target/riscv: Add properties for counter
 delegation ISA extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-5-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This adds the properties for counter delegation ISA extensions
(Smcdeleg/Ssccfg). Definitions of new registers and and implementation
will come in the next set of patches.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 963f1f3af9ae..82edd28e2e1d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,11 +184,13 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b974255f6fb..ae2b019703fe 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,8 @@ struct RISCVCPUConfig {
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;

-- 
2.34.1


