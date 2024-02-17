Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF6C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89j-0003RM-0b; Fri, 16 Feb 2024 19:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89f-0003PV-S2
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:08 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89R-0007wS-R3
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:07 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so2380045b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128111; x=1708732911;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6zQL2CTLDv8SMjYyqrJ65mcDbZjwYbAqZ3AZWMYm0I=;
 b=iMVSkC4Z+Y86c5LO3L7DmJ9+wcvLVillD/22X9vi/x/9b5etEa9yays+UMrbUQqvIN
 +OkjyNpU8ZKgHSN5O4DZ8UFFjWL5ASSBTASXVGivw58GA8wbcAcAn1PNrDfGGQ05aCkY
 gOVKAcTKdRNfy0XLYBft21FBH919PV1dHoUJnUULt2hkObpnJLGR2J8hjJ0VvhrV3Y0a
 TM7hAHsTnNCzkwnSaV2D/QuXO/Ihv+yozGrEBc2mWfmvcec1NYa+6Br8LaZR5ZIsYjbO
 ABGoCZT8cylDq8/WFRPR3KwzJ8zs5p4hPWRuFEe1nj4P7kYMmt1khAsXFdQgVUyVSex+
 pHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128111; x=1708732911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6zQL2CTLDv8SMjYyqrJ65mcDbZjwYbAqZ3AZWMYm0I=;
 b=ED85vli3rXbXvdLNR/z0rAA1+epTbb9KU0ft0Cu0RpoZcbNgSnZJ9IZFVdhe7vLQpG
 7WOUdgpOzP3wjGhwxMnBbtSKUgm5cBihBriqspxzTF6xxpO2Le0BMMVKCCDmVRW7AvOw
 PbTIM5PmPnl1SguTzWYnIUfmne8KV6lSQtSpdE9Rodk4lp5NvTqcGXwrnuJ6QQhUacMu
 ACTuZBorjcn6nWSLhizu7bvlXt3O9Nxf6NETgVB5F8WjXbcuOsbMUqxq5G9VwP1Z/l7T
 Ub/Wp9OToqXqmDA691esWRsbrFojslkdienmWPDfZLZa2abQP8yL7omLEbYkCazDcOrF
 yXwg==
X-Gm-Message-State: AOJu0Yza9B+MYQe2vRR75RKcEzZo2JeSsDuiTnv+q13oZJow/ZuX3i+E
 vWkxc8SbprW3XB+1SBKzMK1esiSW4lKH4xX2BcE0wy4T1IUa6e3NwU9SJnKDNyI1Qu1tbUMrhgM
 c
X-Google-Smtp-Source: AGHT+IFAdH143+J+/qP1H9D5UdgM1UyRrOXMNcjxe/AllWBLHaXFalFchRrbPEwA3PXtIsBUMovneg==
X-Received: by 2002:a05:6a00:2e24:b0:6e1:4836:629c with SMTP id
 fc36-20020a056a002e2400b006e14836629cmr2333672pfb.11.1708128111556; 
 Fri, 16 Feb 2024 16:01:51 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:50 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 5/8] target/riscv: Add smcdeleg/ssccfg properties
Date: Fri, 16 Feb 2024 16:01:31 -0800
Message-Id: <20240217000134.3634191-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42c.google.com
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

This adds the properties of smcdeleg/ssccfg. Implementation will be in
future patches.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/cpu.c     | 4 ++++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ff7c6c7c380e..c5ec203fb8fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -151,11 +151,13 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_12_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_12_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
@@ -1352,6 +1354,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
+    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
+    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index b9086464752e..a3be34c88ef0 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -76,6 +76,8 @@ struct RISCVCPUConfig {
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
-- 
2.34.1


