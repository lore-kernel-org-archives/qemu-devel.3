Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7F1C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvDz-0005OR-AY; Tue, 29 Jul 2025 21:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCV-0003AO-Vz
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCT-0004is-VR
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso4359933b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837304; x=1754442104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifEoAXRng5a+xRiHUCEEy4t4IHwKmHWTZK+mMwPSJPw=;
 b=YfGPu5OAh8edeohXSCV2jIBNuIoYg6ztP6E/7GLPqmPpNeZgePaMUBhPzzNoMHRut8
 OtbrLA7v5lljTByelYU/mn4LcNp1dfrdZeZueb7lc4CuLEgbFa7CYLi7FwQ/JGTKY0Q8
 piGZwFR6JkVqDqwUNeGoKGqEe4AY0R/1+MGnj/26OoPgeF8Jm+JePffhL9WR9+PZNt2p
 rn0Wq9Pc8S3JtKEAfFN4Nr/QBWFYtPPr0eWx7O5PyoJfE55EOgMWqrUyL6cZW/jyjSYE
 45T3x1sOr+PG8AYirUAd5k9RlTtI4V/EqaZnNvI6uFqZeeB+g152v4b6wZY4DWYeYxgf
 nVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837304; x=1754442104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifEoAXRng5a+xRiHUCEEy4t4IHwKmHWTZK+mMwPSJPw=;
 b=BpqkgrGEKxJxcz5rvuuIpt2bOH8K9Sggs3ck1O6cStzYKruur6KCPmXwrsIkxiKpRp
 iIegXUEXZ1sb/GL644ID9nSm4DZMjhLzA4l3oM1jQKS9YYP/tKoW5P7bS6YnqtRVAfU3
 f3L9mWrqMTZmx6gD6IlRyKNhUdawZfQK2GxnD6Qta5bFoqoVCcO3tFpdXLIG6ThYVfTA
 aMCQZXQJ0ynhsYY+bQ8bQHlcVBJvXdIl0X/Hn5aPLzO4jzbdRdnFKIUxveMzI7DLTZa4
 XyKd7WXb9aOEtJly+tdU7jVAZa3hg+qtytVFyNYjqJ8NkjeigDpI3/oqutC1nzv4rHrA
 ZdZw==
X-Gm-Message-State: AOJu0YyKz1QKq0ZSUQUUWs/6pqOYiRg4KfmuXpovfSYi9sNRX6UiLqi4
 OnKvTJCTz6ievK+SvOAR9lGnMUe+ynO2zPPv2AVCjEqbzF8wTuXhCntd5Xzq3A==
X-Gm-Gg: ASbGncujJwTLMsC+MqxJKldhzuovUidQ8bIbtmDHShatzSapF9f7tnCp1ms1bDkTaAY
 YRnIQ70yggBYngq5EIHXbQAMEFX6qoupjWJIYQbQXEnmgw42SVteHUxrCy9TOa6D2ehy8+vN1OR
 dCaYFS2nxSokyVLEzDkrrXWv9YFwACvHegy/YgF1QEaZIE0LeW9B1AyBlo/hbL9wB0P35beD0E6
 PypdOXkDTWA/W2/VioQnGx0Mqh4GUW7aSxMLzGEkjB7r1h6mhQHBkyeIXH43vq/8ktKQMADhC40
 xzVuMpjth9+NVKxiq0YUcyXCOfuZYm11mF139juOfQlNRkKmlvGg0E+X7P4XMjdJt62McIExza/
 iE3y+Oy1ihgGC5rn6OR70/pYnpeLAaTWSA7FftCquLiU8wfIOa+vxBZIAalNfbcSCzXTV97nj8y
 U66Ves+TC7TMvnSg/DkmhFcRhcD34=
X-Google-Smtp-Source: AGHT+IFqpEwXvArcCmWQqfDv3uLCvp39+9Zo1F+yEWcjKR8TAMVeXRXjSOEYA2qU6kF8IGiZHmLw6Q==
X-Received: by 2002:a05:6a21:339d:b0:218:96ad:720d with SMTP id
 adf61e73a8af0-23dc0cf784dmr1748861637.1.1753837303601; 
 Tue, 29 Jul 2025 18:01:43 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/11] tests/data/acpi/riscv64: Update expected FADT and MADT
Date: Wed, 30 Jul 2025 11:01:15 +1000
Message-ID: <20250730010122.4193496-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
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

From: Sunil V L <sunilvl@ventanamicro.com>

Update the expected tables for the version change.
 /*
  *
  * ACPI Data Table [FACP]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
 [004h 0004 004h]                Table Length : 00000114
 [008h 0008 001h]                    Revision : 06
-[009h 0009 001h]                    Checksum : 13
+[009h 0009 001h]                    Checksum : 12
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 004h]                FACS Address : 00000000
 [028h 0040 004h]                DSDT Address : 00000000
 [02Ch 0044 001h]                       Model : 00
 [02Dh 0045 001h]                  PM Profile : 00 [Unspecified]
 [02Eh 0046 002h]               SCI Interrupt : 0000
 [030h 0048 004h]            SMI Command Port : 00000000
 [034h 0052 001h]           ACPI Enable Value : 00
 [035h 0053 001h]          ACPI Disable Value : 00
 [036h 0054 001h]              S4BIOS Command : 00
 [037h 0055 001h]             P-State Control : 00
@@ -86,33 +86,33 @@
      Use APIC Physical Destination Mode (V4) : 0
                        Hardware Reduced (V5) : 1
                       Low Power S0 Idle (V5) : 0

 [074h 0116 00Ch]              Reset Register : [Generic Address Structure]
 [074h 0116 001h]                    Space ID : 00 [SystemMemory]
 [075h 0117 001h]                   Bit Width : 00
 [076h 0118 001h]                  Bit Offset : 00
 [077h 0119 001h]        Encoded Access Width : 00 [Undefined/Legacy]
 [078h 0120 008h]                     Address : 0000000000000000

 [080h 0128 001h]        Value to cause reset : 00
 [081h 0129 002h]   ARM Flags (decoded below) : 0000
                               PSCI Compliant : 0
                        Must use HVC for PSCI : 0

-[083h 0131 001h]         FADT Minor Revision : 05
+[083h 0131 001h]         FADT Minor Revision : 06
 [084h 0132 008h]                FACS Address : 0000000000000000
[...]

 /*
  *
  * ACPI Data Table [APIC]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
 [004h 0004 004h]                Table Length : 00000074
-[008h 0008 001h]                    Revision : 06
-[009h 0009 001h]                    Checksum : B4
+[008h 0008 001h]                    Revision : 07
+[009h 0009 001h]                    Checksum : B3
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
[...]

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Message-ID: <20250724110350.452828-4-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/riscv64/virt/APIC           | Bin 116 -> 116 bytes
 tests/data/acpi/riscv64/virt/FACP           | Bin 276 -> 276 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 0c3f7a6cac..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/APIC",
-"tests/data/acpi/riscv64/virt/FACP",
diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
index 66a25dfd2d..3fb5b75359 100644
Binary files a/tests/data/acpi/riscv64/virt/APIC and b/tests/data/acpi/riscv64/virt/APIC differ
diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
index a5276b65ea..78e1b14b1d 100644
Binary files a/tests/data/acpi/riscv64/virt/FACP and b/tests/data/acpi/riscv64/virt/FACP differ
-- 
2.50.0


