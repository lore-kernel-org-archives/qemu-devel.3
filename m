Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E3FC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgqR-0008Ms-Vh; Tue, 14 Jan 2025 08:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqJ-0008Kx-Q3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:31 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqI-0003rZ-6S
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:27 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2a9ef75a20dso2686958fac.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736860824; x=1737465624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZO0MHW2C4CbxTJs7lkrSc3hq/cnXciHDtgsOH5i4QM=;
 b=X0bcaQa8cqYIQ7D2W4FsyhneUk2UGFCzw1HZjl5g17gE0sRsiYmYglV2X79Doi777T
 tZ3GkLeeijUZsCU5hBjLfu54l4u7mSmmmMmyIbl2dTWQXUXc40fTQB1ZLbjDFGsxFMHL
 VsVhMu4yemdXF7N17OAvnwOmM5cqhs1gbvnjrKH2Tgu4kIIcSPd4DVCgpinWlVHa7/NP
 rVSrmHzYDiiVdKwN17xM8M3ADyb4MDlY9NP4E/jruwQBe0IXa9VPvG9GPqfMBl1lTh5F
 9C9veu4vkUP0EyPrdZqTRtpPzD0pH92ew4qyNzwyEEn7Ag1wIhz9/LDjUhWaIXYiDtTU
 qTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860824; x=1737465624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZO0MHW2C4CbxTJs7lkrSc3hq/cnXciHDtgsOH5i4QM=;
 b=bYXAH6xqOPAr55IDgdrKJkmVqqljvbrm8hjt/cerWifnSYsl1yrdl+1loxA8mV2Iie
 qz4qzcsBr/G3lcJnS2Ewbb+AzduqpN0HK0i2+QPdiJ6MJdJB5yz1x30kJvkHipkUuKGT
 8nkB4wzmSvvb1lCLQ3+grXBfZFfYM17vPqVj3baIrdoIPZI7q2NBiZONb7wP6OAujQ/M
 gUWrE2du89gu9yQ1SvAccvOK0JeN4NMGpfh6lzFvWdJV2U3QBAjNmS7vHmmI/+D+pdu/
 LNbTpADVwoMa1IxbpgZZrnk7PWnbMNm9z/rbIIO1D8wNrYdI63STXkDlLZk7EYGVuYkG
 fy4A==
X-Gm-Message-State: AOJu0Yw6rcaj0kW4H0K+lUqEecq3/JQ6z6VTrz6sqqQtFdLB8+aTrBAH
 uZQ8GDxPdsovr6MmRZg9So0kbuFMLEpJDBoZBqwREm9jaBFf4hTDFD5vgMAOJRCPn0GsXrIrva5
 5P8c=
X-Gm-Gg: ASbGncvUCM/5AW4iVso6EJ8I2djOx9Nm80zRf0RLu7Y+rr39Z8Et7qGgFGU7iymosM7
 AZP3bqv7wcmGe68VQmi5WgtAXfCs34imcLC1os0C4P/Y7m8zJVzu7+9bRED/8zQaC8ZyssnY7OD
 4eRAQ/dbViDOnZWd4eIpxDIcroCPnCsFP2PE+zyYK1m9Hr5y6u29jQQBZiD4vlE9NV6dhLGLP0b
 lvxR3673jAzVTaAtH++/Zjr42/EdTBH+pGH53SS7HIPwzgSO7kFIdCegGDDVNtXOzj/OJE6k62D
 wMF2YmGIIA==
X-Google-Smtp-Source: AGHT+IED0BDUA1OTbVWTRlcscr5NVh0ehFhUWzXKwNxsm0ViE5yWeuNKTRYy/okFSRfEhn0UpFZqSw==
X-Received: by 2002:a05:6870:ce91:b0:29e:19ee:4832 with SMTP id
 586e51a60fabf-2aa066fbbeamr12964334fac.18.1736860823916; 
 Tue, 14 Jan 2025 05:20:23 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809b10e4sm5052411fac.35.2025.01.14.05.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 05:20:22 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/4] target/riscv: add ssu64xl
Date: Tue, 14 Jan 2025 10:20:09 -0300
Message-ID: <20250114132012.1224941-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

ssu64xl is defined in RVA22 as:

"sstatus.UXL must be capable of holding the value 2 (i.e., UXLEN=64 must
be supported)."

This is always true in TCG and it's mandatory for RVA23, so claim
support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 398 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2..b187ef2e4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -213,6 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 695022d56c4ac16607d4c622955ad339fbbfe997..b14ec15e553200760a63aad65586913d31ea2edc 100644
GIT binary patch
delta 48
zcmZo;?qlW(@^B96V`N}pOqj@Jz^cQ@$e^;(o|BQSxYW#~B4@H2qXkC_BLhPoBLf2f
D`wIz-

delta 41
wcmeBUZe!*O@^B7mV`N}poG_8gfK`Q&kwIpoJtyPj07f&87)Az$G)4vn0JA^`U;qFB

-- 
2.47.1


