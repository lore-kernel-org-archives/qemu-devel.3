Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3C9CA101E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMoE-00055E-S0; Tue, 03 Sep 2024 02:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoD-00050i-L7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:33 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoB-0002FC-Ub
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-205722ba00cso11754975ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725344070; x=1725948870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGrHAUtc6Oe0+s4X91g1WKyiAEgqhFplpZjvQxzqUvM=;
 b=AwPPysbhvdeuwWA6xfuWeygjVTApWuQcQLHG9rW6lBPwbvRdD7qoQnYz3/cU+9fAp+
 XVF7oMLmBzPGkgQMLblzagGFCo/yPO6zs4+2/PJqrEZ7VsC7yhY+5Pfogv8UYXr/Nn9X
 dG22/86SBN+EQAk0hypKSv1U0Auop7rrLrmFTnR0cdOI+gvD/GvTz4Z5XmKgutopWfyi
 YBREda8KSCvbM1Ma9EKbvz1qmkFWXqSePXaVTU+EW1xP8bN9b+znXnMfWfVRVeBLI/cj
 ph7o/xaadQYfhPbBs6qplYF2MEW2eGoMM065rlYOGCQV9D4oDusTd43+/LlglbfyHeWK
 SPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725344070; x=1725948870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGrHAUtc6Oe0+s4X91g1WKyiAEgqhFplpZjvQxzqUvM=;
 b=CSZbYsiQF/3LSY+l6UkdGlhjBCddEqEZwr7WZwMS+rY8wmH3yEP4Pa973h2KukV9xD
 l/COyZk6IExByx5vScsd5b3EgIAtEViMkS/gjN7Iud2rrHGPwXlKkop4iDELmZdyHXnO
 5zMzsDVneweK6p0Ze0z4ThD5/RKAGoGO17Rjet1LsMvfQ4f2ZfvgPLqhcL8739nzTiTS
 IT6sicT184MI2Q7W0LFT6bLMuAY7ynuY80srquQq18dROSVS2YBldbq+Pxk8sdu1Cg26
 yfwtLvyWjAT1gOJgyHAyVeF42iZRlrxhZEUS/tPIfBR05hmkVv13jEDatAaqcEfkqZ3v
 wcZQ==
X-Gm-Message-State: AOJu0YwattjWMYUGcnN66dhIA4pVy0u8W6CQyRSvTAj3IYT85rIXXPZh
 KqElfEPbIDd7WG3+v1HWZ4C8lZB7XCW96v4MfPCAKY/j6WGDTCRp9oxGtEqRFnJUnznyYTgaFMI
 9OzXWZZ/mG1XSfvl8paGZz7XL1w+rOra3JAFeQwx5j0QFNAjzOJlNp/qQMG7Ftqq4pn01kI8Fnh
 y0jBMfg0X6Cy9L9Pe/KetxD86JMNkR5x2p5UQ=
X-Google-Smtp-Source: AGHT+IGgDblYLu4YoqREVmIigSlZWUIjjn25hLwT5Wc+rpeN3wTIzOPNa5Sk8ZXp00UM0tgK9T10Yw==
X-Received: by 2002:a17:902:d2c2:b0:202:38d8:16c with SMTP id
 d9443c01a7336-2054733519dmr75286795ad.37.1725344069759; 
 Mon, 02 Sep 2024 23:14:29 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20524c16145sm60467145ad.98.2024.09.02.23.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:14:29 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 3/5] target/riscv: Support hstatus[HUKTE] bit when svukte
 extension is enabled
Date: Tue,  3 Sep 2024 14:17:55 +0800
Message-Id: <20240903061757.1114957-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903061757.1114957-1-fea.wang@sifive.com>
References: <20240903061757.1114957-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Svukte extension add HUKTE bit, bit[24] in hstatus CSR. The written
value will be masked when the svukte extension is not enabled.

When hstatus[HUKTE] bit is set, HLV/HLVX/HSV work in the U-mode should
do svukte check.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 54c3ae0a4e..8cfc24428e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -598,6 +598,7 @@ typedef enum {
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTW          0x00200000
 #define HSTATUS_VTSR         0x00400000
+#define HSTATUS_HUKTE        0x01000000
 #define HSTATUS_VSXL         0x300000000
 
 #define HSTATUS32_WPRI       0xFF8FF87E
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6ee6d1a9cd..2b28057e57 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3459,6 +3459,9 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    if (!env_archcpu(env)->cfg.ext_svukte) {
+        val = val & (~HSTATUS_HUKTE);
+    }
     env->hstatus = val;
     if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
-- 
2.34.1


