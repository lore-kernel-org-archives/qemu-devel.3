Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916F7CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHA-00061u-Po; Wed, 02 Oct 2024 01:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGu-0005bG-3O
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGk-0004qr-Eo
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b6458ee37so45284745ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848277; x=1728453077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdeIyhNaaghAtMGSeOorbIjQzK0FlGezNaWISsAp6yg=;
 b=SNXtEM76E/KFF7mPRnCkm3Vnii4AFq1Zd7Gv32N1NpyXgqONaRqxyEIaC0F8M8w4eQ
 Mi3PdZ7OiEt1MMB+UXpaQgnyf5Xog01kkFsok9qPX6C8TtYNDA1pT7jiKZANzT42ghye
 /mb9zUupFDJsCZXLCdmElOQXuusGRfTkaaZlHuXTWSJzWpzYUpoM3dZTQ3JXrxv7CzOf
 +Gdn/0t4FUzTHKC7KQwK49XlmADSuQ/G8fGTDjS7yTmD/Dk9ABW2xB1ubtFg2ZzfdI/x
 tQYi8p4+/UUnSz1cSqt/RDUtQ7xXagh8+UduoIp0FMwMI7dqXu/F/WseYxAH6K/vW1LO
 pbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848277; x=1728453077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdeIyhNaaghAtMGSeOorbIjQzK0FlGezNaWISsAp6yg=;
 b=HJgmII2bSsd8HtE8jIoxbP9Q/CiGeD331FG5FhfPYWqmK1NTJ5/Fh/8muWVEDHLgBf
 IjmNxSLqeUAUfWwbMnQJUXYhvnfMLBVlCnf1pDBzE1T7JbVn3/UQDmdu+vtuaY1T+6tn
 zta8gt6IZUUljNxZlOqg4exEWkAEojDZD+sGQGbel4dT1/hWg4Cthm6DSHtjlznuIx/C
 f5iQykjVfJ4aChB3cwx8COTQNh5j6anuepagE2MAyMj6F7LaX2TBTKIkXCUsJrP1Xh77
 H+dwawsqfzoSKC5kTMCaH5S3OQRxT/84gB6Aw/ZYSZ+IbkQfJMVLqcSGO72ffN2iW1MH
 O+UQ==
X-Gm-Message-State: AOJu0YykwUwMcrK3oV4vzZqAiFsOaLuchmHGo0J0tKC210gbix7QKJl+
 emaHfpJfV8lMwlZ25YKknDVK42NXf34laMjUwz4MrFcnR6a3xUwLKj4ZuIMh
X-Google-Smtp-Source: AGHT+IH4WkCaYkDsMsgCI4CausnuYQzZnA7agH+Bo1zxwOL8Qn8x0Ym5/rZBEusY3Yj+HJhO5DYZEA==
X-Received: by 2002:a17:902:e805:b0:20b:6d71:4140 with SMTP id
 d9443c01a7336-20bc5a5cd20mr26185695ad.44.1727848277345; 
 Tue, 01 Oct 2024 22:51:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vladimir Isaev <vladimir.isaev@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v3 06/35] target/riscv: fix za64rs enabling
Date: Wed,  2 Oct 2024 15:50:19 +1000
Message-ID: <20241002055048.556083-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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
2.46.2


