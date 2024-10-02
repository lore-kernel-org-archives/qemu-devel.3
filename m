Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70F0CF3197
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHF-0006K2-W1; Wed, 02 Oct 2024 01:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGw-0005d0-Au
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGt-0004qT-BT
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so17066435ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848271; x=1728453071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/vjiatJy7ZaD1f/ct8WHKBz+eMKhsGzWeJycNOK7OU=;
 b=ep1He1SVyJZSzSXe8FE5hHjXs3iH0BfOeYIXdYi6CP66OE62TxVR6bEtK4ZOYajc/6
 n08dTCsOgQVlwMsWDgvzkQK/v4qGRKxiluaO5OVakpUanpqSWg01u9YrdovBmMzxs/qf
 F6MiWYqU+4os6usfWbafhMHKDBjQ19hLj+nRHNHRxXiaAiZvIzyQbqrp2t+AVQJYDhms
 XbMQn/cWHSbtZHZObwS4t04lEKjsOfRbyIeB5wCSjDmpD7WKATNUHbWG1BtErSEwfmxY
 ZekHTmd1wSyx/LLVElJGutr/aiusmckPRUR1ZPzbWlnl+S5xswV3Pf38m8ZoOdYu37QB
 6IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848271; x=1728453071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/vjiatJy7ZaD1f/ct8WHKBz+eMKhsGzWeJycNOK7OU=;
 b=UlTjBJCPh2C7PiFADHEYukpdb/+TC1mb3yDtYC3f1yMzLuhO7XW9yxhQ7ckzEjiJ9G
 GK2mMTnZDxK4kRLmxRx8c/8Mt7RLYo6XfBKRRDxpSnNFli7hmQNJNpK14t1XGXscd0gZ
 MiSo4nIxvjxeyje5YRwn1W/4F4RlEh0Wd8xoHc0dAEd3UdC3G2ljhKtnS/wl4khYYjmO
 fN5FS/Mktw5J3+AEe+ZJ7uCopDmJNr4nNGH8fP2Y/lBC7r6X/5FRtyvb04YbTUT8Z8/W
 fPObRO7IgZrY2pa4qzcvYXTCKufdNkAKx5kwP0H/bco4aJDxFrM3Gm5JegANQ9yaGxyy
 hHjA==
X-Gm-Message-State: AOJu0YyDpq40KseWQwMT8LnnKGv7MdgiWX7B8llyewolhZu4tQ0sz6pk
 bfZOEv46Gy4/IxHj+kFFmnfKkeXmkr16MgWdZKWCMH0m5VbJAeycJQ7g21HY
X-Google-Smtp-Source: AGHT+IE7YeoWDYMsTfwoxm7H7Yw4lFdDojT0bCgSE5eRmnvGZgIHeNBNN/4p0vDVVbXBjw6RT+6q8Q==
X-Received: by 2002:a17:902:ec88:b0:20b:7633:6e5 with SMTP id
 d9443c01a7336-20bc5aa367cmr22061515ad.50.1727848271340; 
 Tue, 01 Oct 2024 22:51:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 04/35] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
Date: Wed,  2 Oct 2024 15:50:17 +1000
Message-ID: <20241002055048.556083-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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
2.46.2


