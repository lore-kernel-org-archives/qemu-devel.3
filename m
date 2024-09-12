Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A11EE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPO-0000OM-L7; Thu, 12 Sep 2024 01:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPI-00006f-VP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPG-0002yu-MA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7179069d029so371580b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119012; x=1726723812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4PEFDsxpFWW8kLI+VribdFRqFddzL93mbYGJkbVr8k=;
 b=JQRbgHwLmR0fDpJaBcdOMNmcVRlkyfyz4gVRqJ7+3B2ipVQRHrl2Z3HyEkAUrJhC/z
 q3DiV00DeEDpz/dVe3ElKcv4Y1fTsfqyj+UsSiMXFmw08jJaDd9Nk8ti4Cyoj9FrkY/2
 1E74xVTtQRD91wzs62Z4RtYwZn2Yirju6pqhhaiKjXGgjTdUARORLrD9uSXES2S9GwY2
 1JljZbrZMbr09lJu4ypRKSXSsko0/XctkIGu1dnk2ttMMQEFAW6Y0RkbeH3cjgptaae9
 t+EhWC9RE1eRJytpq67yvSpt7WHqJKh1F3sqB63zQfZStxjnMQvNYk/g9g8gHg98yVqB
 YJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119012; x=1726723812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4PEFDsxpFWW8kLI+VribdFRqFddzL93mbYGJkbVr8k=;
 b=TL7YsRJdMkMG3IPaRkBiVin1B0BA9OU+wA9XrIupcIZzWLzcBRdhiqR1AgKMeZGX0W
 xoSsH1TMaN7ncseAR52mDK3l1r3DHt+H8mla5wJTdePJkOCT1PrOlIcGjdsh+mW1/YlP
 fmzbG9MGV0mIiaODeFoPd3S+RiNVBuVJ1kSCPYoG9eacnWLZkh+0lg+lJe1gWAYRre2N
 LMGpSPAz/1GYtuVB0kLg5kxK4IfFcbu1rbJdb2yHkTzLDhhxsslz2Iq30CfWLvsCHV2g
 asdrNgzVPZIfeBSpsN7o4RxXH1MSz1WHu6Thx4LMPNc5gM4FZe5jJ4WB2vJAzyv0GXBs
 1Jyw==
X-Gm-Message-State: AOJu0YxdiRGuqEfs1FPn+C/SL4VWxrZRP8+o0ZaZ6ZUV4QJgRzH6+1Bl
 JU49zyhum+SaF4RWQtI8FdfU3gVQjrYGos7GWtstopEabd8tvnLH/SRKpA==
X-Google-Smtp-Source: AGHT+IHKmeMejQanCM8WgDJNCvfYuc55K30yq64yaCKbXtrxVCOjfWNYr3790hkO1lWo7stY1b6FNg==
X-Received: by 2002:a05:6a00:198d:b0:70d:2583:7227 with SMTP id
 d2e1a72fcca58-7192605871fmr2939725b3a.6.1726119012475; 
 Wed, 11 Sep 2024 22:30:12 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:12 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/47] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
Date: Thu, 12 Sep 2024 15:29:09 +1000
Message-ID: <20240912052953.2552501-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Haibo Xu <haibo1.xu@intel.com>

As per the step 5 in the process documented in bios-tables-test.c,
generate the expected ACPI SRAT AML data file for RISC-V using the
rebuild-expected-aml.sh script and update the
bios-tables-test-allowed-diff.h.

This is a new file being added for the first time. Hence, iASL diff
output is not added.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/riscv64/virt/SRAT.numamem   | Bin 0 -> 108 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a3e01d2eb7..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SRAT.numamem",
diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/riscv64/virt/SRAT.numamem
index e69de29bb2..2b6467364b 100644
Binary files a/tests/data/acpi/riscv64/virt/SRAT.numamem and b/tests/data/acpi/riscv64/virt/SRAT.numamem differ
-- 
2.46.0


