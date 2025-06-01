Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E78C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZ6-0002Ff-8N; Sun, 01 Jun 2025 11:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ4-0002E8-Kk
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZ2-0004e1-VQ
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGe6QEKbqDO2iJtSQF2boocqAH94qpLOcY8tzlF//aY=;
 b=EFlNeGQjn32hGKmQdZkCXNYeQXEgum+IbZy2RHVou3z+6cOfTfhrvthPqrvr6tCR5U6SJf
 EGT5YFzmTwgOLezM1B5cTQfdliga/+dOxqHGvwWdXI3i3TVwXU4vN/u/7Dhmaduiu7kCiX
 ZkWAhOBrKrwjN02JDGLdjSe30cSer8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-fUI3D8OOPuC4w92wrnIkMQ-1; Sun, 01 Jun 2025 11:25:31 -0400
X-MC-Unique: fUI3D8OOPuC4w92wrnIkMQ-1
X-Mimecast-MFC-AGG-ID: fUI3D8OOPuC4w92wrnIkMQ_1748791530
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso321495f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791529; x=1749396329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGe6QEKbqDO2iJtSQF2boocqAH94qpLOcY8tzlF//aY=;
 b=QNhfUfXp3Wfx3wMfykK8Sqcwn4uW0zRdxvHhgRmgUPkcP2ufTQxiE+Jnsgn7FfIgKY
 2WEDIJra5tpnSU+7k50myp8GIfjj7t1OtsHVr/Kmsw3paea+qh3x8ID/Lu8kYiHCBejm
 PrBoxZ0cg3zt7axQSyxSiJBh1wf0jK/DYW/hMQ1eoZswd7qz7cKvnfoVW4CAlXr0fMW6
 YAE4rFIOclhEWYnrrgpe2GDctXZX0tyK+Q9kEWixOjtjG6aAJ1yJmoMOG035ut2zhzZI
 0YwBUMuMxWG2k8AnP0UedWcnLjUbCaLHHyVFuUHULUz7cUJXxhz6hba+y2j2a+INMH7J
 4byQ==
X-Gm-Message-State: AOJu0YwBE5VcSNG26lN53Jf7SGQcPwMuLE+3uL8p87uWo1bhGxzZaoc5
 ud4qcw4qansIlGaMS6uJTvJ3qgowX+ji7aXhtNnynv44FDDOIXjww/7zq4M4aYMzQQ6gI8nYjz1
 ZNEcoGXFcQ3J9bSeEOg2/E3b5XbO6zyq1YfO950FGLtpeK789MzKzg0Dx/by4jImWceZ1UBSYTB
 yWYE/EroNYY7+OP1oRYtk6SN0n5EbaO+M9jA==
X-Gm-Gg: ASbGncsorOG1JHsyc9y/etGy6hMusE3aV6QvOabBRqgDVwWNwzcvfrIwK8e+a2CiJPK
 oZxxtkxFXoopv70RgSmyJ/u0kJFyWtnIMFANI1Yl6zWJTA1lXBiwHl8ENgoSmFcPHseIx7+n/kO
 0srAYrWCddwDLuZLP4ldPX58WtAfsOV5y+6RoStkeSECFm1S9/wa42x0SkZ1OFoFdy23Z40Bcd9
 GnDoHOFrY9o9uMILVs9EDbEK6D90sbZQobCc0J54svKo/ZbR+DqcCtg7fUtOhQkLauRBGbgS34K
 OfbAU/MaOmLFFSG7
X-Received: by 2002:a05:6000:2507:b0:3a4:dbdf:7147 with SMTP id
 ffacd0b85a97d-3a4f89e8c67mr7235622f8f.54.1748791529535; 
 Sun, 01 Jun 2025 08:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHELRmD7pW2SQCqIwkNVv6whO4B7jLZm4NU5mjpjD+MfuyDgTNGGB5Sk3/QBB/A6cNT4ggjGA==
X-Received: by 2002:a05:6000:2507:b0:3a4:dbdf:7147 with SMTP id
 ffacd0b85a97d-3a4f89e8c67mr7235602f8f.54.1748791529109; 
 Sun, 01 Jun 2025 08:25:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b8f0sm11574063f8f.6.2025.06.01.08.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:28 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 17/31] tests/qtest/bios-tables-test: Use MiB macro rather
 hardcode value
Message-ID: <82acc8c83f93814bb01669412a0a226c39fa8d77.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Replace 1024 * 1024 with MiB macro.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250520130158.767083-4-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec435..0b2bdf9d0d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1622,7 +1622,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 256ULL * 1024 * 1024,
+        .scan_len = 256ULL * MiB,
     };
 
     data.variant = ".memhp";
@@ -1717,7 +1717,7 @@ static void test_acpi_riscv64_virt_tcg_numamem(void)
         .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.variant = ".numamem";
@@ -1743,7 +1743,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.variant = ".numamem";
@@ -1765,7 +1765,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
     /*
      * While using -cdrom, the cdrom would auto plugged into pxb-pcie,
@@ -1841,7 +1841,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.variant = ".acpihmatvirt";
@@ -2095,7 +2095,7 @@ static void test_acpi_riscv64_virt_tcg(void)
         .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
         .ram_start = 0x80000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     /*
@@ -2117,7 +2117,7 @@ static void test_acpi_aarch64_virt_tcg(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     data.smbios_cpu_max_speed = 2900;
@@ -2138,7 +2138,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     test_acpi_one("-cpu cortex-a57 "
@@ -2223,7 +2223,7 @@ static void test_acpi_aarch64_virt_viot(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
 
     test_acpi_one("-cpu cortex-a57 "
@@ -2407,7 +2407,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
-        .scan_len = 128ULL * 1024 * 1024,
+        .scan_len = 128ULL * MiB,
     };
     char *args;
 
-- 
MST


