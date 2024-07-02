Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A9BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEC-0005op-Ms; Tue, 02 Jul 2024 10:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDP-00053W-Sc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDN-0000Ni-Hr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxS1+bCJZBeQoTfbYKSlDoSTgSREcQFLu7+nTuWUmeY=;
 b=ExsYWtsaat39d5Gjp87iOAkEMkNtJEmvNzAy43PI/TsnWErRUO9Uyhoh8Ps+TWwya4beqP
 CW8l7yk/wI2GCLlYwdtY//BxmdQ0vyDrIxVXTDtbeZpZ4e3HA/vKWN+swHaj0x/lACGjWA
 ocjcQ5Yg6sniOgJi1YrtQUI2rj9dL8s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-NFh03_mYO1qGqDsp_Welvw-1; Tue, 02 Jul 2024 10:10:35 -0400
X-MC-Unique: NFh03_mYO1qGqDsp_Welvw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-58c4f94b57cso80454a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929434; x=1720534234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxS1+bCJZBeQoTfbYKSlDoSTgSREcQFLu7+nTuWUmeY=;
 b=q7+TUmOAec0clXV25bgfcLF6A/yndTBU/0BONstQ4UcNYbQER2kKf00QDrCun/Uv8M
 SmJPTaOJa7G+pOmJcI0ZHdxeJtvC8Fj0GoY8+tn3Mr5wx5448+5pfCYuhC4wRJap1Uda
 F4oNt5bemZ7a4+KEzOExkAhFfhhRIzgJoNkOEqbvhawzxHQhy6WbmljBcsNZr5wZDCo5
 6Aobm38TjaHbuqoRq5aKv3uns/A+mdWo8rbLsNq32ZdJVwG6AdXdu3EUKewb9sRqbm2/
 7UL9uU2jqSJMj6HI5P0Rq3jbeGqmCDS6QFZac5sTvKLWi3KbDciQC/Oa+NfL/BLxSdNk
 bWoA==
X-Gm-Message-State: AOJu0YwIl2pNkUwZS2HImnM5eSEAL2zRm536WeFK/TsfkFZWmqeCHm7i
 bQ3SfU+7P5qL6eeLCFj0uKxPNcL9cm/+DcNCgAYW9Vo9o8rZpASc5Psk4wwDmbhrm/96t0fW4nd
 1ESiOF4dr775/pBYGOqLdkfrmQjSS/BseyDlinvZBWznzQhlA8XKIFVBt7B9VHfrPkGsxNQ6/Q9
 FQawyEc2sPeytQUiKRZRPKfk33VSh6gw==
X-Received: by 2002:a05:6402:254a:b0:578:649e:e63e with SMTP id
 4fb4d7f45d1cf-5879f1c2563mr5887463a12.16.1719929433760; 
 Tue, 02 Jul 2024 07:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPBmche2iGcvwCD62/r7nPmS1fB9gFmI3Nm1efVk1vq5I6kd4FLokj1zkFBoOkLzQupRodqw==
X-Received: by 2002:a05:6402:254a:b0:578:649e:e63e with SMTP id
 4fb4d7f45d1cf-5879f1c2563mr5887433a12.16.1719929433282; 
 Tue, 02 Jul 2024 07:10:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324feb7sm5779580a12.37.2024.07.02.07.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:32 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 68/91] tests/qtest/bios-tables-test.c: Set "arch" for aarch64
 tests
Message-ID: <c04869bc34e75c867c78b6ca24e40f0859d1ad32.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


