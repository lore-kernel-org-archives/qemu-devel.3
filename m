Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE09C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOaa-0008Gf-FX; Fri, 09 Feb 2024 05:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaZ-0008GW-L3
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:35 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaY-0000Ay-4Q
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:35 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-219108b8e9cso430873fac.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476312; x=1708081112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQCs+odaNl3yO/t48S28H1Q/4KUtJWYHdC+h6upI0Ds=;
 b=Kady0kDpu26FqofSSb9vWfgaSPgIEO99ItEKHEGFYVNcba/rawddTh4SXNlRRo8TJ7
 GV4xMhX/CEmI9OhGyIsYOoH2pxFru/AKGI7u7ujjB/SXbF88215DEZbDWyfVYWCEO+KD
 dI/xYlX3p//V9t9AgJY0RjN6Z+eJghr+CvseuYNIK2ZHZQ+EpRRaUw+RxUYs3f35sg3X
 robStMHg7tXd6Wr5Rp2HVs/ageYJVgQHQzodX4XqFNGyTGsSq2pE+wULqb2wwzBhQZ4T
 HPKIxwYjfRcCVrAhZUBGJvHe+uv873P20hnK41X26qK/4xl4/NtL8yPfRighVtkTd2B1
 44OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476312; x=1708081112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQCs+odaNl3yO/t48S28H1Q/4KUtJWYHdC+h6upI0Ds=;
 b=BLDZQZu5893tn7F3uJcZWKygb8tq+vqwjFSRAz258S70gSjut7K/Qod8pQCHVckDlR
 dfwoQS0t34dE539m3kkdCXSwMXMHkesuHkJ5kPIP1QUT4mGktgXFyJeDoSV3+ZuaBSKE
 /EBI4tLgV17XWNpBxJO0+z+u6nbTFghs49WX6Y2q9BtQXJqpwLZnyKi34yhnTlxLWUsF
 ggNbn0ZPQ/ACZNjtiIe/FFH8FyBmt0kCsol/6O/rQKdnXfYqGnqvIUwtye870kd8Bu5g
 MDdo+BLuAZ+sIHgNsFmESyLp8EFczZfP/dtj4HdPjrrwUrABcSXngoUTmi8pUR+OgNXx
 UJdg==
X-Gm-Message-State: AOJu0Yy4qrhwUSMKTegZyHkCD6fCVYltX/ru6folky3Fmcht783pwBZE
 9BW6DrWVRQ65dbQP/7dkofe+gLH7/ljJn95W9CCcCtBKG681VZWJSxe8SCl93SZQ0A==
X-Google-Smtp-Source: AGHT+IEobRDnRCDy8JhU2rBFiAnD3roYAZyXHh17os9/b0ULULGuWC6HNCEWrkUoTzRljUhVCtYKSw==
X-Received: by 2002:a05:6870:7008:b0:219:3db3:243 with SMTP id
 u8-20020a056870700800b002193db30243mr1309968oae.11.1707476312484; 
 Fri, 09 Feb 2024 02:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCkMG4ytStqgWwLWfhgo4AmwqzA6/vrI2d+pPv8KpY70mbYvtgcI8ZFD4L5MRDBC92L8/iS/bUO8gcu3huRl6vViUUKoGDJ1R+hya5cROt8fdLTzhe9GE6ntcPG02Rri9K/opWMop1VBPrxvYf2YtyYWh5TvmbVrnnAn8xjmYqXUzQQU68lGIcX3+f8Vubr3EelYS8
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/61] target/riscv: Add infrastructure for 'B' MISA extension
Date: Fri,  9 Feb 2024 20:57:14 +1000
Message-ID: <20240209105813.3590056-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Rob Bradford <rbradford@rivosinc.com>

Add the infrastructure for the 'B' extension which is the union of the
Zba, Zbb and Zbs instructions.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240111161644.33630-2-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         | 1 +
 target/riscv/cpu.c         | 5 +++--
 target/riscv/tcg/tcg-cpu.c | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f63ee9cc58..136fc1de73 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVH RV('H')
 #define RVJ RV('J')
 #define RVG RV('G')
+#define RVB RV('B')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index be21fa09c6..8a2fd7d031 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,9 +38,9 @@
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
-static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
+static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
-                              RVC, RVS, RVU, RVH, RVJ, RVG, 0};
+                              RVC, RVS, RVU, RVH, RVJ, RVG, RVB, 0};
 
 /*
  * From vector_helper.c
@@ -1304,6 +1304,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
+    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
 static int riscv_validate_misa_info_idx(uint32_t bit)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b7da92783b..baecfa7672 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1056,6 +1056,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVJ, false),
     MISA_CFG(RVV, false),
     MISA_CFG(RVG, false),
+    MISA_CFG(RVB, false),
 };
 
 /*
-- 
2.43.0


