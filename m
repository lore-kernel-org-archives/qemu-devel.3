Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70469C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAx-0002X8-Jo; Fri, 08 Mar 2024 06:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAn-00024K-0J
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:57 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAl-0001oK-HR
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so15467065ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896434; x=1710501234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUfHetbQTbtHMLLjzmHwMZ6ZjeZkaLJCNXyb36srtfk=;
 b=EKhbPO4sWP/LNatDD7iYlxj3Ujk67XhwLAPsW673Qr926PuTh7XfoBeTqCYuLM7Itm
 BYBmt1SPCbwu4GQ6ARS/VkOatOsCtniuBHUmmJUQuN2i9WyqDH0aEevHigT87gaA/wJJ
 T+u30y5YQIHndXd4BQ1ItNGcaXDp7KfP9fterzgtwf5vuT2rEtJvX/3e0dEuPmTthgKi
 5AwjWY2yw3Xx11OCKD13B/Bm22dazZaX+Uj0DL7OR9MdcEHGJoL/DV/g8vciGBbWDDOF
 1ZPKP/rF1b8Dw/aYfsStrldACLmSh/8cr+MD6cwJ2ej/k01JS4HU5hzpPNJVUe5UlWH1
 +2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896434; x=1710501234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUfHetbQTbtHMLLjzmHwMZ6ZjeZkaLJCNXyb36srtfk=;
 b=HdhJv1SESJiZVSExACBVY2wsn+pY5CSeKhIIp3Ds4JD/J638LvRFEMXh8sFDXetZYs
 8kdtq7afP8ERDhaB47/HgkWe+0MsxELzZQFM5wPdtLodQ5Con8YWh58Ojq4RIg99HZ1z
 QgcUCp7lVMEYp3KxtIO7gowkLxylVIMGE0Dz160RjQvVd/CgTocappP0UouypEZ7D6Xn
 arGBflqDw7FjdcHPTjmxlwQYMUIwojyoV+/2rMTtPCbU8dBKDHBDz1RxwY32wFQp6JwE
 r6dpBH/BeZQsypbEsjlm07hAy4izwKkRXDmD9dBEHFCgSjuxF/Ziv38TdtjArds9duJr
 J1EA==
X-Gm-Message-State: AOJu0YxpwMokmp5z2j5ZA8Zbb426fqagDYN3ES7YzNtIU9r11HDo80NC
 xAHLXBSsFEsknp7sX2bfRoppZ+FEj57z5T30pFbyGCxreckV6I8YBsKBcERw5I2mrw==
X-Google-Smtp-Source: AGHT+IGN/bycU2fMZHrmdfXOngBxT5q4J+/ZhHJfzjHp0B8dRswRFN6JYHMKGwyWx0dIJI96T0gCSA==
X-Received: by 2002:a17:902:cec8:b0:1dc:588b:99c8 with SMTP id
 d8-20020a170902cec800b001dc588b99c8mr13238461plg.36.1709896433996; 
 Fri, 08 Mar 2024 03:13:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:53 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ilya Chugin <danger_mail@list.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/34] target/riscv: fix ACPI MCFG table
Date: Fri,  8 Mar 2024 21:11:52 +1000
Message-ID: <20240308111152.2856137-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Ilya Chugin <danger_mail@list.ru>

MCFG segments should point to PCI configuration range, not BAR MMIO.

Signed-off-by: Ilya Chugin <danger_mail@list.ru>
Fixes: 55ecd83b36 ("hw/riscv/virt-acpi-build.c: Add IO controllers and devices")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index ef72db018e..0925528160 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -647,8 +647,8 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-           .base = s->memmap[VIRT_PCIE_MMIO].base,
-           .size = s->memmap[VIRT_PCIE_MMIO].size,
+           .base = s->memmap[VIRT_PCIE_ECAM].base,
+           .size = s->memmap[VIRT_PCIE_ECAM].size,
         };
         build_mcfg(tables_blob, tables->linker, &mcfg, s->oem_id,
                    s->oem_table_id);
-- 
2.44.0


