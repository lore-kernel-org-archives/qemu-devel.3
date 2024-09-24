Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EC2CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrU-0003nS-UY; Tue, 24 Sep 2024 18:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrT-0003ms-RE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:23 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrR-0001cZ-5b
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:23 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso4898846a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216299; x=1727821099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PukEHZTP1cHGH2nRPTAG73nQxz7hdOrzOlU4AwU4HbA=;
 b=EmXSFQCsRzxX4UqgK9rZk0R4xVLHXM0XL7jgdh5ls6gQ2WXha5YW6c94vESJSFznb7
 vlfdlgOAkdIePSWhSzNC4LLEvrsJu71hl34+Qmo189wbw24YW77HNPAgRBP4cpd9xkXH
 smjL91B325xh92Rt9LiP9Lhor8AdJlVjHHht37PP2a8BeQiui61UW2YTFcElQjG8ulc1
 02OjJk7DFliPjkA+w8AjN6eLLZqQB1vc15UYbTAhsJC1ASlwJpYFF8Q9JIxQ01CYJCMe
 Pg6UrkmqWzX0c90vqH1qHsmg9gc5/2LRQ3UMkqejp5GK6RZxoIdcTmw5chUmsYtGqpyM
 yFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216299; x=1727821099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PukEHZTP1cHGH2nRPTAG73nQxz7hdOrzOlU4AwU4HbA=;
 b=OllRT/znu8T7wfyy8z6o/9XoH+oZw0X5JSOCx4+NITZ8u6ww6shDVBUDcfMHYR9qtO
 64/2miPFDFUU+mEGQZ0veaBGUl+33pZgnb7DxTIswKMbVmjc9cc5ufZJZouPKEsQfi3N
 DFv90HKQ59y1R2/BVgyXauMHDBvnY/V4aWhtKTDLMSwI0kzfUclgHARU+1CVV2AtSGrz
 SbCFAoyBo7MTmrStdbKJ3/Qty+0F90SCuLA8WsIGvrHLdT5rv4JpJ7m5+PO7YazbDJfs
 WgtQsw6l7Yb2+/7TVfNS3wyvfbTSVtQSuEM62Yw/G7jNdCagQeM3KR+vj0QXMZhTlJse
 0NFg==
X-Gm-Message-State: AOJu0YzhuENrsy929h30bnsvdTVmmTYIfCKtFdLUlTAZcfM/tKohx9TT
 NvTKQKhwmFGu2O75r4O/CdJJI8sMbXoIpQMIFnzmLR8thHmbpWO88isomQ==
X-Google-Smtp-Source: AGHT+IFZrCRFRIjAAMYH2fBZJWVnuskk0Bv4DbOsLwcBYYT1tHbjvoL97u9BzsXe1wUGPQkyE6tswQ==
X-Received: by 2002:a05:6300:668a:b0:1cf:3d14:6921 with SMTP id
 adf61e73a8af0-1d4d4b9b563mr1179023637.35.1727216299503; 
 Tue, 24 Sep 2024 15:18:19 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vladimir Isaev <vladimir.isaev@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 06/47] target/riscv: fix za64rs enabling
Date: Wed, 25 Sep 2024 08:17:07 +1000
Message-ID: <20240924221751.2688389-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Vladimir Isaev <vladimir.isaev@syntacore.com>

za64rs requires priv 1.12 when enabled by priv 1.11.

This fixes annoying warning:
warning: disabling za64rs extension for hart 0x00000000 because privilege spec version does not match

on priv 1.11 CPUs.

Fixes: 68c9e54beae8 ("target/riscv: do not enable all named features by default")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cc5552500a..0f8189bcf0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -115,7 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
-- 
2.46.1


