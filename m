Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EB0C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmqx-0002U8-Dp; Mon, 08 Jul 2024 07:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqw-0002Ol-Ad
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:18 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqg-000102-T8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:18 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-24c9f630e51so2430289fac.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720439280; x=1721044080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qevKJQpjtteUldtR7LJxAGzsp0+tuZOokGrtY3Qi+7o=;
 b=k/bymEKKPp0++brrkzoBYMTOos1iCw8WPrf65W9kf6/l+Oj55T50B7NE9szEmRy8Qm
 U1Qa3VyFOyY1VLrekLr/38IOYSL5H9eH9N51ZnQSyUI8JHahCj8LCoiL+grLoAmUX4oh
 jj5IzAU5QnBW59pqoY5vBqdcyexbQ01J3JHg8XwzhYM6z5FMc/lzMGpHJAJptxk/A5R+
 F1GIsC/1HAMLt1KrQ8S6mFg2T5Y9jF92mhcC/aoNHLHGItT3Rp5EBgd+zqyx8F7IzxjH
 ONb+CPE661/fkwAo+ZFirlB8PgExJqiQzO22K5yOAw9SBHpKsihczeDMQjFKkXZsKRC1
 eTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720439280; x=1721044080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qevKJQpjtteUldtR7LJxAGzsp0+tuZOokGrtY3Qi+7o=;
 b=aacI3LZ3tANwPd6mqIFXLxMq4isjtqytRp4uvEQKpCv5X/BWL7b/llra7QbkwqA+Q/
 1SZL7ebtegFxBp5ILBxcYTa1k+CCr8E+rFbi1StB//xxAiWZFHHsiUMQVsuB9jqFkY37
 zfTcFgxlB9agOoO4JYHRP2zWqykuNyX+0p1d5vUmmbTWY0NP/4CLRZA1kvqEnRNo0Yrr
 mfCQuHU/GKrI1uKfppb10NU2OfeUHux8SfSN86oUFrsNy5PKhxL9ED1ucyou6az3AC+d
 7Jm6Xp8L4+qDSMYypKsbLuttgUgukR8a2KCjAlAkrp8DwW/y/UNc6up1o2JDRg/GP1/r
 8gDQ==
X-Gm-Message-State: AOJu0YwAnzBF80bP/VyzAmOlnbgs0jTVsNGLly4O/5mhgZN1nbG/jawf
 vQyitT+ayXyVWNfJLxgITmfh4ycWyeMjyQay7cB14cL+2c9FJ2+LnL0UaYfNdjr0GNmpzFzCZci
 p
X-Google-Smtp-Source: AGHT+IFvpJn4KMcBXXykKweTrbJwHmpyOXy6l8Fu5w3dAa28Mp502SmEnqqMbLwg8u6jK6fF89txhQ==
X-Received: by 2002:a05:6871:24c2:b0:25b:3e23:e5e7 with SMTP id
 586e51a60fabf-25e2b8a7442mr9931574fac.3.1720439280253; 
 Mon, 08 Jul 2024 04:48:00 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b2a432ac6sm2769642b3a.94.2024.07.08.04.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:47:59 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 3/9] tests/acpi: Allow DSDT acpi table changes for aarch64
Date: Mon,  8 Jul 2024 17:17:35 +0530
Message-ID: <20240708114741.3499585-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

so that CI tests don't fail when those ACPI tables are updated in the
next patch. This is as per the documentation in bios-tables-tests.c.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9282ea0fb2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


