Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255A2C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAODb-0003Eh-I8; Fri, 24 May 2024 02:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAODT-0002yM-31
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAODI-0001TP-0z
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:46 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f8f30712d3so255691b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716531332; x=1717136132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsa6//hDacH3c+JfwYsMFNnpZVOmhl0+Dj2RJG6LSfI=;
 b=RNS20LcRvskTYBdSoRSLhmMr+Sq+pgTODiHUByq/03kp7Svi/7sIPjQbaiT60gVn8o
 VkNpsyNPYePEHbfluD1w5tY1+yPqhZ8F/FDpBMsfz0lzXnzxHhx4vOBPfWTL/SmSXaph
 Ry2lw8oJ+Vpmyux+Yv28K2iR3+dturZ+IbIjU4/rk9s7KW2B3TxPyAupoOBe9xWaEgFt
 X33q09GCk+zZl2MUkxRDhvJ0fB/uKiStkmIy0SwGVihf51P50PrRefdBfHyAhHyrTTDj
 WXvbdPsAuQbrxUeNR5+lTT7/SdKDIPiJrr/YtBk/m15b5QwaUmEyJjOcSBfO9Ou7rhRI
 BiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531332; x=1717136132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsa6//hDacH3c+JfwYsMFNnpZVOmhl0+Dj2RJG6LSfI=;
 b=Jes3wpM9H+VaUiHHv7qclxAmNMfgL5C1MSMD8KCROO2T+lT85ET6Vc2Ic47u2bQKMr
 Dx/9gQ+QRWLMi34iHQoFCQ9fndKODcHLXMtsC9xVHh6ihzvCa7Vxo5e9RGHcal0pz9Yc
 qfpazNVtcxpxBsOjMQqc9CGDFubPlK86Iml5GMmFyRG73gWbX1WjCu4DAo3jOiqGB/1H
 j9r7vH5NJDFOB3NUOv1ZDxLmL0xbq2Jkc4oT+LvqUcni4MyyhUC3LIA4l/jxTjvN5XlW
 ckBXTfy/Mw93rxyO0Upk2fcKssOofiqo9PKI7ZhVFJorq6HG4NzstfRQ4Lii2WdcU2S1
 AzQw==
X-Gm-Message-State: AOJu0YwSgYfArDyaT74qHCvxgGt759eN3AfpJaf2cNJ55yUAjnMlQvPj
 D8ArKGF086wbQSGGjzghm3iHRumgxdsM8TVXlsYaoFv3AXFqMFK2RRcqhymob6qLzwp+6lo63Nh
 NdHo=
X-Google-Smtp-Source: AGHT+IH74dYvoTMOGbqizAQe1rmy4wEZ8M1YnUPdrJK22dhg68JjlZoqo2bAdifufOKn2raWjK1jOA==
X-Received: by 2002:a05:6a20:5646:b0:1b1:d74d:87b0 with SMTP id
 adf61e73a8af0-1b205ce9273mr5104824637.22.1716531331796; 
 Thu, 23 May 2024 23:15:31 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea487sm516106b3a.107.2024.05.23.23.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:15:31 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 10/12] tests/qtest/bios-tables-test: Add empty ACPI data
 files for RISC-V
Date: Fri, 24 May 2024 11:44:09 +0530
Message-Id: <20240524061411.341599-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524061411.341599-1-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x435.google.com
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

As per process documented (steps 1-3) in bios-tables-test.c, add empty
AML data files for RISC-V ACPI tables and add the entries in
bios-tables-test-allowed-diff.h.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/data/acpi/virt/riscv64/APIC           | 0
 tests/data/acpi/virt/riscv64/DSDT           | 0
 tests/data/acpi/virt/riscv64/FACP           | 0
 tests/data/acpi/virt/riscv64/MCFG           | 0
 tests/data/acpi/virt/riscv64/RHCT           | 0
 tests/data/acpi/virt/riscv64/SPCR           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 7 files changed, 6 insertions(+)
 create mode 100644 tests/data/acpi/virt/riscv64/APIC
 create mode 100644 tests/data/acpi/virt/riscv64/DSDT
 create mode 100644 tests/data/acpi/virt/riscv64/FACP
 create mode 100644 tests/data/acpi/virt/riscv64/MCFG
 create mode 100644 tests/data/acpi/virt/riscv64/RHCT
 create mode 100644 tests/data/acpi/virt/riscv64/SPCR

diff --git a/tests/data/acpi/virt/riscv64/APIC b/tests/data/acpi/virt/riscv64/APIC
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/riscv64/DSDT b/tests/data/acpi/virt/riscv64/DSDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/riscv64/FACP b/tests/data/acpi/virt/riscv64/FACP
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/riscv64/MCFG b/tests/data/acpi/virt/riscv64/MCFG
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/riscv64/RHCT b/tests/data/acpi/virt/riscv64/RHCT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/virt/riscv64/SPCR b/tests/data/acpi/virt/riscv64/SPCR
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..d8610c8d72 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/riscv64/APIC",
+"tests/data/acpi/virt/riscv64/DSDT",
+"tests/data/acpi/virt/riscv64/FACP",
+"tests/data/acpi/virt/riscv64/MCFG",
+"tests/data/acpi/virt/riscv64/RHCT",
+"tests/data/acpi/virt/riscv64/SPCR",
-- 
2.40.1


