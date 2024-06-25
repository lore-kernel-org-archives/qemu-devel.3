Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6979EC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7ne-0001il-4n; Tue, 25 Jun 2024 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7na-0001fy-LW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:35 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7nY-0006XI-8w
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:09:34 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70670188420so2317696b3a.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328170; x=1719932970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRln+4308vpV60KhA9A1rXBcQH2LHd5SKFisrtf+G0s=;
 b=GvKXCBwbYwPFlvTJb+duBHznQvGAXovNsF+M+nf9vl2TO0+LIOCrBCk/2MOoBy+PoL
 nfoQm+nOqR6t2bZfh4kO3JGfbmxHKJ0zVGlNLZc2N+f3fitoeZs2dTS4SXRBeAuDs56d
 QAve6LgdfjWCKoSJnlRPjWKyuJFdgr2/8D1BQ+KstnQBOfwrkiIaHNB7SpGD/dFOLGCs
 NpLdJ8QrbJYUIJDL0+CagtYpJB5Zyq6NVZADIj2NvOD8HHVQNgoMeXn+hvzB6DuRJK11
 6J/6fHXYbElbC3I4PssslPLJpsEWP/b1DIQTLKfgU8kPrwcLCXMAPFduPScMxqCgK+Cc
 VyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328170; x=1719932970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRln+4308vpV60KhA9A1rXBcQH2LHd5SKFisrtf+G0s=;
 b=E4batczydHdTLKXfZanpn3sPp1xsPdW6O1fW9blZwYxLwCejG8BsrQEchOYPpVagLr
 2/0wealKVS/Bl28QHeIJu03v3aJXwJrwu17IzKjc/nLS/NKwYtsXyjPKa/+W+c84J9dr
 7jUzJsfa3leE4F47lf0dV9tOZ0WtBfcKBAwB3a8xq55nEeSb+t/RUQQekDVzBevI3fK1
 VWptLiRGkCbCK5ZI8uK6+rRob2iLYDMC54CJFeXn4MzPxokUQrRAYZrkTkXNhw5+3x5U
 I8420B5Kf7iW0XWwP46FewVbgLnLkSh2iGNo6hXnf0sO8CubjomIvO1WigoJ9z0vEbfC
 jl9g==
X-Gm-Message-State: AOJu0YzF6cGKpWrRLABF5ENUWq/HRAkUvIU+ypiFgI3zKO2xTGrKUM8H
 6shJSaCk11sgxWCbWxfo67JchSm1vrUQjDXQXHHB6jeOVDIXeg5lZmMFfECbJAB4fMR1bqEJCda
 F
X-Google-Smtp-Source: AGHT+IGDw85IrAc1zyJ8JC/Z0vCT+m7cPLI3pscPcxg0/pewAb7b+s77ZWt/sMy0fF1NMuzF1lXLSA==
X-Received: by 2002:a05:6a20:3c91:b0:1b4:c499:788d with SMTP id
 adf61e73a8af0-1bcee6ebcdcmr9481045637.15.1719328170158; 
 Tue, 25 Jun 2024 08:09:30 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:09:29 -0700 (PDT)
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
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 07/16] tests/qtest/bios-tables-test.c: Set "arch" for
 aarch64 tests
Date: Tue, 25 Jun 2024 20:38:30 +0530
Message-Id: <20240625150839.1358279-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

To search for expected AML files under ${arch}/${machine} path, set this
field for AARCH64 related test cases.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 29c52952f4..007c281c9a 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1591,6 +1591,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1684,6 +1685,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1706,6 +1708,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1779,6 +1782,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1935,6 +1939,7 @@ static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1954,6 +1959,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .variant = ".topology",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
@@ -2037,6 +2043,7 @@ static void test_acpi_aarch64_virt_viot(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -2213,6 +2220,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
-- 
2.40.1


