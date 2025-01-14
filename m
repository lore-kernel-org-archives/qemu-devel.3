Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD83C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgqP-0008Lr-Ab; Tue, 14 Jan 2025 08:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqI-0008K1-En
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:26 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqG-0003qt-Nw
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:26 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb9bbcc936so3144616b6e.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736860820; x=1737465620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoU6QnxQq9cq31fuw1ONPxwM9qu/LCG5eKvjACufAPA=;
 b=YI7xA9MnEkfiBjRxdViLBJJPYBO2Xnvk0beaFvkLPCrS96vW9GlIeYUZA4SCbWH3eo
 nOC6cn5SKYdEnzWTGJQB6reNH8Q1ZJStvVZVLHRoLtDoWOhPn277KfET44Uq4uyQJW/q
 AHahbghM7TG8P0+LdFfvn6MHDI7StMW0lkTz+fPlv9orM80R5tNS/V8XhlNUhUQUnD1o
 WA5smBuUYS5mqzU+8O0eU8urXzh2/kmABsel+AQg7WFsWW1/Btq0F/cdsba2fafwQj6Q
 nY1V+EoEHiU2Mnl8nJd+JcdHgQnBvYEIu8SnacQl3t/8myhYuLc4KzejC3mVrm6W//5p
 x4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860820; x=1737465620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZoU6QnxQq9cq31fuw1ONPxwM9qu/LCG5eKvjACufAPA=;
 b=OjjNlR3MdAW2yFugm2CoB1RQTuszeC9r+86n9rfjEFgjANeSMsz2RVd6tahOiWgQ0b
 OJ04qNmL2qDiBJNM6kq35D/NUV81QTKJQcgus33Eaj3sOq9FQ1I28oZGS8KNGOVGtAnr
 pGZeq70jFwPppEYlG+3XiBKQLq0rcr3tkn8xmU1y4NKbtSRkK21wGYbXBfXxK53C4v2F
 7D+iWWXz/LMlnzeenRaBdQTK0j8k+HKiYhKjMD4Kgcgh1D5nglEAMUQrUZN9ltT2olIn
 6WlPjJzA+zxFJUKkp8mLTVMdtpxLOjhI0s6vUemwSoe4V8QGvu+uiEXKO6MCD3TQe22L
 sbMQ==
X-Gm-Message-State: AOJu0YxD5bZpwPaqDqO5Xe3ymDLaMD0FK7FBcnK+s5CPd1xqmqaPaJcQ
 JZKUg4wIA31TIM/u7tDDzZ3rEiirE1OqFbSEpcnDNY9r4kYLEWDoHLPAfmkWQpm6so+3ej7q+6G
 vLyg=
X-Gm-Gg: ASbGnctgLsKHGDIrRqN6yrJIiaXBK9zSzqFLqmKsk/y61zwbkyZfvCNi8cVdVPfrUB7
 zlFQ2zR6/NziOnO97y05a/t7B8U5QoF0YfChzuh07setV5UOfegvEr8N5MGvnTQqlP2W9M3hokL
 XAQXXrpPbETECZug0ggSKqCEUqIULASs1EYQgN1wvTRw/T7nvSWTZGj3MZEJ1VTn+rSvq6P57tn
 frdv17cu7ZPe7YdXCLaK4lVb/ctrR0g+/xeouTDSsZgHejmsVaqhpjvjUT700Uts92brDZuujW+
 ztC079/ZFw==
X-Google-Smtp-Source: AGHT+IFbAKrBGIDt6kdiohPP8q/s/CIXA0y61VYwJTmXgTpo2SS3/AK9T0hJWGzqWP1gMlta08px4Q==
X-Received: by 2002:a05:6870:ff08:b0:29e:5ac8:2c09 with SMTP id
 586e51a60fabf-2aa066ed9d7mr12594599fac.13.1736860819967; 
 Tue, 14 Jan 2025 05:20:19 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809b10e4sm5052411fac.35.2025.01.14.05.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 05:20:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/4] target/riscv: RVA23 profile support
Date: Tue, 14 Jan 2025 10:20:08 -0300
Message-ID: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

After adding 'supm' and 'sspm' we're finally ready to add official RVA23
support after adding a couple of trivial pieces:

- add ssu64xl, another 'named feature' for something that we already
  implement in TCG;
- declare RVB in RVA22U64. This is more a cosmetic change to make it
  straightforward to implement RVA23U64 as a child of RVA22.

Adding RVA23U and RVA23S is done in the same model as we did with RVA22
profiles, including a CPU for each of them for easier consumption.

Patches based on alistair/riscv-to-apply.next.

Daniel Henrique Barboza (4):
  target/riscv: add ssu64xl
  target/riscv: use RVB in RVA22U64
  target/riscv: add RVA23U64 profile
  target/riscv: add RVA23S64 profile

 target/riscv/cpu-qom.h            |   2 +
 target/riscv/cpu.c                |  83 ++++++++++++++++++++++++++++--
 tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 400 bytes
 3 files changed, 82 insertions(+), 3 deletions(-)

-- 
2.47.1


