Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40313CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHD-0006DK-Ld; Wed, 02 Oct 2024 01:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGu-0005bF-3B
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:39 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGk-0004qi-Eh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so69138765ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848280; x=1728453080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EI0kHcPUo6x2eDcs+2KIC40XgBNh/atV1LPebowvuc=;
 b=IKmB27JSDaqpGHNMkV4VF71HMt//IxEKMKbkqb74cTKPqvN+WNJ1cIl5kLW2htkcUM
 UMh7VksYr3P8s+BL7e9GQMcU4A5ysE5hQEYau53KrCaR5rjyIx9Xtxbnr21yntGLNqZp
 obWFfKZQkEzoN9t5qS3kezHkLaRQPEQFLxxtaijcDm3s14tSUqI4n7TiBP4yOvSnsY8t
 nzlNEa6xMjIXGNKGw1Hq/WjuwC0kwN/LLuPmtjgnLwgKNUTY1wp8A1Dg4tgGWGJVsmfd
 yOTREC7IIwB9EiJRfLhRa0/Cf8eAnIOsUM/Jbo//sn4pWqpW1tgDGc08las8MBvNuyyK
 pnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848280; x=1728453080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EI0kHcPUo6x2eDcs+2KIC40XgBNh/atV1LPebowvuc=;
 b=MZZiK31NFGaVc+/4wPWrcyQsZGxwL2D68oy7bqEAgWT9WQxTHCyWa8yMjG6KK+18Nz
 n3bC6Y7jZnXBR0NMDlgexb+5tvRXno/wROVQpBCsCLDlXtpN+qu8WQcIjMb8dW0tBlDs
 KEgX5A6QMiPUyaY777AEPzyFuTVXLamb+mkEx42LrPv+6KO7pqYDJ31odRf0jubLZDaR
 nQ55b2mUBTLPn1d1vUgNth9DyqLa7QvvAUBFEwbFZ3IoJe4LI7nsxPjPShn/BWxLyiIG
 Eb111JqSHy/BVZwhQoK92c2t1bW2EiAx/1+M2OsB2rzL23i4ne8ZlmWbPxbg5yWSoqJV
 X/Bw==
X-Gm-Message-State: AOJu0Ywbj59iWdrM/C8U9g3vZP6XaXFK+Jz/OZEfRxY4Catg00MIc8RW
 pYPpZWrrEeJJPvWzVdNE6oXvtqGTt9MQD63Ms5etf1x5sOjiIS0AkuOLA4L9
X-Google-Smtp-Source: AGHT+IGE0j1kMdboAeZwtGhDlYUMfgr+B4vNiOFZCauuscRDmdIeYKkvGqNjcsgE9liJIWFAWitTdg==
X-Received: by 2002:a17:902:da8e:b0:20b:9062:7b08 with SMTP id
 d9443c01a7336-20bc5a94f9dmr31384235ad.45.1727848280068; 
 Tue, 01 Oct 2024 22:51:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v3 07/35] target: riscv: Enable Bit Manip for OpenTitan Ibex CPU
Date: Wed,  2 Oct 2024 15:50:20 +1000
Message-ID: <20241002055048.556083-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Alistair Francis <alistair23@gmail.com>

The OpenTitan Ibex CPU now supports the the Zba, Zbb, Zbc
and Zbs bit-manipulation sub-extensions ratified in
v.1.0.0 of the RISC-V Bit- Manipulation ISA Extension, so let's enable
them in QEMU as well.

1: https://github.com/lowRISC/opentitan/pull/9748

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240823003231.3522113-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0f8189bcf0..a1ca12077f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -680,6 +680,11 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
     cpu->cfg.ext_smepmp = true;
+
+    cpu->cfg.ext_zba = true;
+    cpu->cfg.ext_zbb = true;
+    cpu->cfg.ext_zbc = true;
+    cpu->cfg.ext_zbs = true;
 }
 
 static void rv32_imafcu_nommu_cpu_init(Object *obj)
-- 
2.46.2


