Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DB2CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrQ-0003dr-KB; Tue, 24 Sep 2024 18:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrO-0003XA-8w
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrM-0001cE-GI
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so4471382b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216293; x=1727821093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RttL6BgoQ/DY/0vFFqR0rzq7wrxcaMq9VvLjsngh4qg=;
 b=Ce1RfL46+/re3bP878EJCBoOsiDRRhFZxrx9ibloedxTcu0UM9eLcQAV/vMZrS3NOj
 I75M4WOrwR7sRgtfnoKMBiR11hL79TAYpikITTnzIP4O/cu6l+xHtDV3Mnp2etJR4T9j
 U9UEPl7j7F+UdwH31pN5jqYM0iOoMjhMIjDugaTHuFLoSR7Cc5PrkGx+08tATGqxcRiM
 Fw/c/jRJEq4BdXbw1jGvofRzAbNRN7O9Wa4OmUJ1CJKOFyGqAkP8/GzGVlEI1c99ZB9L
 0UL2j2muyWepWfpOOmrb95X7klii+Oa0qOqOIqfJcAdsINxVajeSWCt/OCV8QiQxi0Ut
 QmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216293; x=1727821093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RttL6BgoQ/DY/0vFFqR0rzq7wrxcaMq9VvLjsngh4qg=;
 b=lTpbb+1EfIilzBtAz4B9M+N+5BXq1kA7KEw8QC9PU9w4rQ5wrS4nqtqa9HtrYQE+xO
 /AUKx2A7nobnBw26ojsJdTSkpLrHQzABOpialCEge5rCEaFsGMteuik6bt5YQMdsqrot
 MhErqFroCOo3/zo221uK3kecAM3sHlbJTVcKgu0qYpY44jHMis8JTzX70EKak4qX4NIc
 7FEkxDToJmtmafQxm9Am+YKbNgSKFhT9ZYoaCgytI2Qv7XV5B73unN75PGyzwrJCYvdi
 S3uJPO71+zL5H3Lwnp4kfmgYoYer7dxYXnIbWFdWkPTQmzDTRAnHydUwQ4SCOUsw4N6I
 lRaQ==
X-Gm-Message-State: AOJu0Yw63yXyQI7GgglXjLza36Bnr+K0w6JbPfXXKrcdtwHkJ8rM6JYX
 LGSBZ/ShCNLpzWPJUWjN2gytEIS0AjaVtV0utCqpG8449bAthPORi4vkfg==
X-Google-Smtp-Source: AGHT+IF1Zq9cwOZrXDsqrtsJen7sUzOz8GyWZ74M4UnnDS2MnY2Ml/9P8T1EAamH0Cfy6/VrXQBqMg==
X-Received: by 2002:a05:6a00:2345:b0:714:1a74:9953 with SMTP id
 d2e1a72fcca58-71b0aaec1f4mr920497b3a.16.1727216293478; 
 Tue, 24 Sep 2024 15:18:13 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 04/47] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
Date: Wed, 25 Sep 2024 08:17:05 +1000
Message-ID: <20240924221751.2688389-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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
2.46.1


