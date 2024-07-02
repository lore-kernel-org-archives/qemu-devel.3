Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0790C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyn-0001vg-Tp; Tue, 02 Jul 2024 16:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyl-0001lk-NI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyj-0001IN-1v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxS1+bCJZBeQoTfbYKSlDoSTgSREcQFLu7+nTuWUmeY=;
 b=d6E720waoBjGLlbSvUoxkz2GsBFy2cbAirOu39CaVFiG0JrcFa+N3PcX8DSp9FAXsZvJ7M
 PPjNVM1veq+lfBv2ikIldoOFO3TxHsWl/Lqk5LuJmED8wv30p8/cKiJ92ZUaoB3jLFZrme
 ZUVnaPb41SDnbC0xN8xC7sYOKhYKvpc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-d7cpGZdENbGvMM-Fr0JMmA-1; Tue, 02 Jul 2024 16:19:49 -0400
X-MC-Unique: d7cpGZdENbGvMM-Fr0JMmA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4258675a531so14529365e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951587; x=1720556387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxS1+bCJZBeQoTfbYKSlDoSTgSREcQFLu7+nTuWUmeY=;
 b=Osp7Q1aUStqldgYgI1ZQsnZiuopSV49Otuj8A8Hkza3caJsIt6OJc24HhDlCeFhWEl
 otkfcAxe1CKBU2Vx417kI9BrxEjwdTgEKmj+xxgvrqEj2HZ/x1O/eo7ZBd/XmkY5G7BM
 K7NYK90Hij61shA3kbeqbpo+2sQoawolYgZyUc6dObZMpNr9EBER6HEevC3umX/Bs4I/
 Vxlp1diKOLuAHbcz6zaanFRmjJ2mrvIRo599VvW5ATb4Qhe2/zezpAdC9SOgJU1gPW4T
 Tl0xMwd3pAvj78MYPfv5DXlFGLo8GKg5f+f9H1APnGUNeaXBT2fXwSLH9U85oBMok8L8
 wPvw==
X-Gm-Message-State: AOJu0Yw8RDrBLy4PNxRtveYUMV7Rfzb3RYdlU+H+Q6NqW8vEkdYoV8I+
 Xzcw9ijx9ilb1a1bDK/o89+UqG8IzXzMVN/8RQJh/0MkyHWs+GxBbfSNTlpH4GHLn2ogvtNazEf
 Jo5AmFpJktDc2ZK4bHdQ+V5BAe4znq6gzsxJ2iLM99ONnx2iAODupeTQnlP3I9GdxuCAaLL6q9/
 in8izmvO7fJTxAnFUitevM05hCNASPMA==
X-Received: by 2002:adf:f30b:0:b0:362:b906:99c4 with SMTP id
 ffacd0b85a97d-3677572829amr5635396f8f.58.1719951587409; 
 Tue, 02 Jul 2024 13:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzEgq1Ja7oVtQLIn6FTz3aI1hqp2bY7hIqRfrM4WNvJEdTHMe7OOpJi9TZDnH/nz3WcYF7Ug==
X-Received: by 2002:adf:f30b:0:b0:362:b906:99c4 with SMTP id
 ffacd0b85a97d-3677572829amr5635369f8f.58.1719951586672; 
 Tue, 02 Jul 2024 13:19:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e0661sm13961980f8f.47.2024.07.02.13.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:46 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 68/88] tests/qtest/bios-tables-test.c: Set "arch" for
 aarch64 tests
Message-ID: <54f055a3e0b40814248e49c08296a56b4ab0a27e.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To search for expected AML files under ${arch}/${machine} path, set this
field for AARCH64 related test cases.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-8-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


