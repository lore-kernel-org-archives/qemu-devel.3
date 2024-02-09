Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5017AC48BC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOfk-0000PG-LR; Fri, 09 Feb 2024 06:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcj-00069X-Tz
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:53 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOci-0000om-AF
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:49 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e09a817e41so17634b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476446; x=1708081246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mS7zGioHh3twFkHbHpX/UA+G7tLxKn7JwfRtRQ4guMU=;
 b=OO1s8aXuteDu7wlctDlmEWFGn6jPmRkyO1nRwVPwCMlglp/33VmlU9FvfJgpRr6lX8
 yFip64v7XnXKBY+6WqTlprre9g1zv11JelJXwFsVkoLyEAj5a3UzQSVqoZPR4BJkOpbb
 Dyia1gsRSfTSijhIxCwspQZheZj8FXG/RXOvZbU/R110DinZdvhWUN1jT6mWeEzv8+AQ
 cZiu4YgKQsAYMOXe/d6bs0+J1GQEYsWbRMh5mgj91xjbRnJPVwG/J6ekl97gJP+VT08X
 rUKW3v9cEDH8r5Bwp6U8oZKSQiEZBO8lqnMgsFetx6R9tRd3BfD9AetOTaO72DjdmdDg
 chlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476446; x=1708081246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mS7zGioHh3twFkHbHpX/UA+G7tLxKn7JwfRtRQ4guMU=;
 b=UeZ7AfXPWa1Ylpg4dlF6yVKMIEtwIDfYjKUhXSv5x/Cg0KmZpVsvKSLjq6aQ/HEzyq
 Uho0Hi8xhjeOOuAJjZG4KLnyLLrRMNBrO7hCX6ySWPBk2oOnTDHok1WsHaImuYsjeIZ9
 TGY9cf/eaClxhC6O1ws0Vnd3h9Lvpa98vQGqw75cdVZ3ftf3r/8g+dozxVcui3jX0eT4
 Fum9nopWC0iQAnUTjXos4rY/+IdxEcQ/stidNqGwLvdJA9/AZ+jv+nUajcEoktrA9HTG
 inkefFTCcbhGOxZv90J6EtCzdyKwQ+XzZwHoZ4fd2VJcvDD0zNTm45qbq6Bh/eZf/H31
 9Q1w==
X-Gm-Message-State: AOJu0Yzn1rMMlVUTCh8gspCxamAL7es/41MGLS6fN7IDo4SIjEheJh8Y
 wehHGSWkwapgZUn/YY+Go/Sf7XuB+7KV5foYDGAUFVU8U7f8RZWpNfTsnOK4b2XajQ==
X-Google-Smtp-Source: AGHT+IHcwEoul1b+a+sqr0IKmO8gZet8wnihFWg2mL3pbzsKNpKfovyRplrcLTGiTlGBN3jvsQw5xg==
X-Received: by 2002:a05:6a20:d397:b0:19e:a85d:166 with SMTP id
 iq23-20020a056a20d39700b0019ea85d0166mr1830669pzb.9.1707476446217; 
 Fri, 09 Feb 2024 03:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWbNPFgDd01IAUbXRLR3uwURvoJ01P9OelU6U62t30rC32deLVkFG3aZN5Dd0Gn3e2DKikYv/v9IaLrgFb7cEsDNodxx04T2wjcf3NXSomJNIkxtNIPaRWPWj4ZUinKOFKgeoo=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/61] hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
Date: Fri,  9 Feb 2024 20:57:55 +1000
Message-ID: <20240209105813.3590056-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The 'isa' char pointer isn't being freed after use.

Issue detected by Valgrind:

==38752== 128 bytes in 1 blocks are definitely lost in loss record 3,190 of 3,884
==38752==    at 0x484280F: malloc (vg_replace_malloc.c:442)
==38752==    by 0x5189619: g_malloc (gmem.c:130)
==38752==    by 0x51A5BF2: g_strconcat (gstrfuncs.c:628)
==38752==    by 0x6C1E3E: riscv_isa_string_ext (cpu.c:2321)
==38752==    by 0x6C1E3E: riscv_isa_string (cpu.c:2343)
==38752==    by 0x6BD2EA: build_rhct (virt-acpi-build.c:232)
==38752==    by 0x6BD2EA: virt_acpi_build (virt-acpi-build.c:556)
==38752==    by 0x6BDC86: virt_acpi_setup (virt-acpi-build.c:662)
==38752==    by 0x9C8DC6: notifier_list_notify (notify.c:39)
==38752==    by 0x4A595A: qdev_machine_creation_done (machine.c:1589)
==38752==    by 0x61E052: qemu_machine_creation_done (vl.c:2680)
==38752==    by 0x61E052: qmp_x_exit_preconfig.part.0 (vl.c:2709)
==38752==    by 0x6220C6: qmp_x_exit_preconfig (vl.c:2702)
==38752==    by 0x6220C6: qemu_init (vl.c:3758)
==38752==    by 0x425858: main (main.c:47)

Fixes: ebfd392893 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122221529.86562-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 26c7e4482d..fb8baf64f6 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -196,7 +196,7 @@ static void build_rhct(GArray *table_data,
     RISCVCPU *cpu = &s->soc[0].harts[0];
     uint32_t mmu_offset = 0;
     uint8_t satp_mode_max;
-    char *isa;
+    g_autofree char *isa = NULL;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
                         .oem_table_id = s->oem_table_id };
-- 
2.43.0


