Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6531EC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKj-0002Kn-H8; Mon, 19 Aug 2024 20:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKd-0001sj-AY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKT-0001DR-Dy
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-201d5af11a4so45587315ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112106; x=1724716906;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4mAJdMCJKnSHTZBg24BmY/PI6LJMup/le/nWxFZ0Nw=;
 b=REQLDDgZvdHfM8e5ebZZOjdMd6NU3wgg+odc8jG0plPSKzgUoyZxFGswT7onZ0InBv
 vzRGWlTK7flMgkRBV4bJynUZ1Kp/2/lfIXLVdomU6TEtcjTSk9lHKBVAUGUk6kq0Jsgf
 +Rl0Dhzms0kA2lpLL3qSV1jwKwj1e9cHOTppCj0t+tE0ppXFaNtcI4sweuzD/2TXTpiq
 7fmzJVwISK/bIJGOyo+JgCCBWOdAqOhU373ic2RfRlMpBMtBa0TD8YxcviLEYWHE2Hi3
 h8HS6wRWU3EElo7N1MDuw5JWq5JDWuDabX9HaG/5+ibpPvYPqG2yBFITkYboPwHLkwKC
 A7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112106; x=1724716906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4mAJdMCJKnSHTZBg24BmY/PI6LJMup/le/nWxFZ0Nw=;
 b=edEPMNBR3hSs3riKdpM2YtypT4FNBLJc7IccAGs1IfmYgD21820nH7HEw+Ohremzre
 dlZSPhCdyxx8GlljiMtSj3m0lZB1ljKzlJLPec3kQCjlcbMKkerZanFPnBi7D71JCPKE
 prdynSRbdHXvmqm8FKH9nx4H4MJaLoDPGkWZcN1TMBUOIIZSDqXwsVBrK85PtB9NnFLN
 qlCChzmsqe0P1S3E8vxt7RJIHqMjgH8AvSKi3IxmZ1O6qAoS67mWZ809VH5F+ikf1PLL
 Zs0IYKY8cLIzTP2zv0TuKfDjxdrlOyQdPW8fk6yOmZKwh1mBd3Gk8sAr8Fo1REFhjnbv
 OYOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+BHVfGgrkELEh591oVFrlW/3RhlxzTUICFPt7APXIShz1wUynWifXzoH3ttsA/ohX8vYcEAqtZBuw@nongnu.org
X-Gm-Message-State: AOJu0Yy4Yen0ungWZ3FfQX1Ai1hyQg8i1ZhmBXOkkMtkUTJe5X9f5Pnz
 38PnzAqHmycc0oaMCMzha1kiOLbYENHjawraJj0hBHDEPagKv+R4ZAZqWe3TGoI=
X-Google-Smtp-Source: AGHT+IHzYAUSm0lFJxlWh3ACWB1vOR06Fo/a3HW5ULY+H6V21yjNCQQMrcKd42LNy17vfQzr83Kb/w==
X-Received: by 2002:a17:902:e751:b0:202:2fc8:da35 with SMTP id
 d9443c01a7336-2022fc8dc69mr103360855ad.55.1724112105415; 
 Mon, 19 Aug 2024 17:01:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v5 08/15] target/riscv: Add zicfiss extension
Date: Mon, 19 Aug 2024 17:01:22 -0700
Message-ID: <20240820000129.3522346-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x634.google.com
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

zicfiss [1] riscv cpu extension enables backward control flow integrity.

This patch sets up space for zicfiss extension in cpuconfig. And imple-
ments dependency on A, zicsr, zimop and zcmop extensions.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 083d405516..10a2a32345 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -107,6 +107,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
+    ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
@@ -1482,6 +1483,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
+    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 88d5defbb5..2499f38407 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -68,6 +68,7 @@ struct RISCVCPUConfig {
     bool ext_zicbop;
     bool ext_zicboz;
     bool ext_zicfilp;
+    bool ext_zicfiss;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ed19586c9d..4da26cb926 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,6 +618,25 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zihpm = false;
     }
 
+    if (cpu->cfg.ext_zicfiss) {
+        if (!cpu->cfg.ext_zicsr) {
+            error_setg(errp, "zicfiss extension requires zicsr extension");
+            return;
+        }
+        if (!riscv_has_ext(env, RVA)) {
+            error_setg(errp, "zicfiss extension requires A extension");
+            return;
+        }
+        if (!cpu->cfg.ext_zimop) {
+            error_setg(errp, "zicfiss extension requires zimop extension");
+            return;
+        }
+        if (cpu->cfg.ext_zca && !cpu->cfg.ext_zcmop) {
+            error_setg(errp, "zicfiss with zca requires zcmop extension");
+            return;
+        }
+    }
+
     if (!cpu->cfg.ext_zihpm) {
         cpu->cfg.pmu_mask = 0;
         cpu->pmu_avail_ctrs = 0;
-- 
2.44.0


