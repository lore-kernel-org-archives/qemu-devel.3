Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F1C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDe2-00036g-K9; Tue, 06 Aug 2024 02:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDe1-000325-CS
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDdz-0003wo-Ox
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so1999905ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722925562; x=1723530362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUA5stD664rN/7Zk/IxG6em8g6FU8KrpOoscG0RunZg=;
 b=f5yf83KSP5OP411ic2cZi4Ae9D+U8B3Tr2ennccu3npzlGlCYR7Ob9QmkmyvraiL8Z
 CNdi9xjcsezPSIKHsQXPuy/MwMPtnk0k3v6Ns0GFU+n9H1iOMFl1n+ijhjWB5t6gSQY6
 s4wZW9iY/R2Uuykv4PtFopzI5fU1I6OWJrrZn+RjewEkpR8x8ttqD9sjENFTOsOWMGCE
 QqycXjrrxPOlKc0cj32p9E9DR+VT5T0asCf33ANyxr99m7KUeqgcayRbhyljnlVa8fpZ
 zq+2SXKhIKpZ+VJTtYl8hBmA3OxhG8ZKOJ9wXOLgrqc1Zg0mZlEWa7BPIU1yDYagCeKp
 URng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722925562; x=1723530362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUA5stD664rN/7Zk/IxG6em8g6FU8KrpOoscG0RunZg=;
 b=c0SxQxNzM2n3DR92ITW7MorCcWrvnl7sHtPr1QiTNzHCIiGqX9brMm4bkZ+WUGh7vV
 M8SXfEYbhHgtVTumV0O+pmRgByH2C8P0DlfbR0+kB6zEnxTmKmyooI272AglzD/SGjkM
 kD54whEJkZMTbVjH0La70aOe9wmcGDM0czAEhJm5C5HqQ90E7B0vBCsBjGE3Bq6uM1hv
 7KFlHuEJTERR6pb3TDBmtTDVsaNrNnciSMiSef3+TKNGmwI8Wu/wdITI2ihaGlZeTRov
 VLBRco3IZYplsxbbzyNJLI7FoKBxewSVX3UIdN2y7IS3FqYKossoic3H8OiUv9arikm6
 a7pQ==
X-Gm-Message-State: AOJu0YycyRaI2HRcUU1/yLog4dNsobWKAXd8B8aLoHVNnLfS8PyE+ucy
 lwn9j9YR7oTZIF8j2Buo6mky3LX0xfM1azxp2io0ht+P8DDCXtjsOk7cxeQr
X-Google-Smtp-Source: AGHT+IHy9tL4GmTAckhYQFoklVJycu1UlYdZIS0ZHsnJc8vPTPc+FeO55DIE76FRkMsDjKrY8eN9dw==
X-Received: by 2002:a17:902:e808:b0:1fc:4f9b:6055 with SMTP id
 d9443c01a7336-1ff5725863emr137507355ad.1.1722925561909; 
 Mon, 05 Aug 2024 23:26:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f161sm79464975ad.232.2024.08.05.23.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 23:26:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/5] target/riscv: Add MXLEN check for F/D/Q applies to zama16b
Date: Tue,  6 Aug 2024 16:25:42 +1000
Message-ID: <20240806062545.1250910-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806062545.1250910-1-alistair.francis@wdc.com>
References: <20240806062545.1250910-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zama16b loads and stores of no more than MXLEN bits defined in the F, D, and Q
extensions.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802072417.659-3-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 0ac42c3223..49682292b8 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -47,7 +47,11 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if (ctx->cfg_ptr->ext_zama16b) {
+    /*
+     * Zama16b applies to loads and stores of no more than MXLEN bits defined
+     * in the F, D, and Q extensions.
+     */
+    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
@@ -67,7 +71,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if (ctx->cfg_ptr->ext_zama16b) {
+    if ((get_xl_max(ctx) >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
-- 
2.45.2


