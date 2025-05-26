Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3B9C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQRo-0003cW-Rr; Mon, 26 May 2025 01:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRc-0002tO-By
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:16 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRR-0002Jk-Ur
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:08 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4e290e420eeso542643137.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748237523; x=1748842323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BICU4b7QLdbhUSoTdVeRR8JtDxyaYap4Oi2QriTbDw=;
 b=sdcu9ZO4hek9hPb0l8FpjnRFCO0ZS5UQJqTn8Hpt6KnPRcghZReE1ufFoCx7Q5jii5
 HHlazw5nkLzdq9bSPIotIfQ4lrMAUa3PBPIDRROW2Lz9zf+1WGE0dUVdzKOTZcjkIP/f
 781BlokpLytAQlewVgrkfVIuW21+u0WhX0WL95UhWLZoNRDeI1p7KU3q771oQoBD/YMX
 iORoJFhh21zYpLSYxo8E3Xh+BIOpQKl3NIGEHnTsqv6xrvGmTojUq8vDAP3E1Bqbnhvn
 aR5UXNVOagOPEzJbsp+0njV/GYqKZ6/+ZT8njVK5dL0154qy0WFQCiQgmrN29RBvlLJW
 8n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237523; x=1748842323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BICU4b7QLdbhUSoTdVeRR8JtDxyaYap4Oi2QriTbDw=;
 b=Ald98YAFfPtD4hm7vUbeDSCFgI1ogUkArXzsCyZtHr4ysk3NrTqTjshZpRpOrdeV1O
 63ydQHBlBFgPcrbsPBCB7qoIo6fhOYPAV6/t+z2XYJ6vqBea7fJya8H03WM9Hcc2VOmY
 n+bkaCnSaKACJtTZ7TDPlC907GGZpKQttPW49U7snq1kxxc02IbtTsaj0sB04eURbVMr
 DwohWU9WbFoHW5qqWfVJdhEXDZV0ppGr490KVTYgCKFFHq2ix9cofRSyK3j6vVrwBJEY
 8jCkdmgvuutvZHFmxTRbVA7MO5Q4iO7TJ9JwuWWOyT9tFP0R3yxa4ewNYGNGQg1Nf+vO
 atWQ==
X-Gm-Message-State: AOJu0Yw2lMVgiEl4K/FM2h4ZMPbic64PeD2so1lSS+f3Vd55xKQ5T4TR
 TStFp8QXdLSqSjQ/v3z6jcVG9fNMQW/Pn4N/cCEKydlaEDOxDVg15DgduVKrk+8SagIkTgmkpek
 cBxs6gv8=
X-Gm-Gg: ASbGncs1uMMF65KnI21duWpZuUAWGQi23qKHbQ5brBHIX6DoSK2knSVSmcGFpOartHD
 zSPXTF6FJAKTW0xqyGpCrDSkO3O3f2zNjI8Q1PFyyrxbGxU4xMDO56aipbBGfsayTvUdTu1A86b
 CcWRjIryO9IdKPtTLG1jUxv3uhr9q8Wbq8x7Pxt+j7zHpGdXW58tk3InMrreVhaIGER3nTEnGR3
 2PbCNJnvrk66o+5yFoTXdnl56N+Xh1/fUOnWOJpPlqWU+RK+UDBp3h2V+O18Ycsz8GBGqYp8hbx
 3YbMFml5j3B9YJ/LQya37xCLloA4yMMtllPZUBJdLBgWjnO57gduf1rPjKbJXaPuktBeN6geT3E
 cDkmdfk9rnZsvlGpSVZeejpEG7kgzj+Fw
X-Google-Smtp-Source: AGHT+IFLT89ZZ/LgA2ugxIyY2m5X3Ne9b8navUdNxLGD0pktr2W0XQyI8xR/4omQb//PVn07GRQrfw==
X-Received: by 2002:a05:6102:6c4:b0:4bb:d45c:7f4b with SMTP id
 ada2fe7eead31-4e4240f9b9amr5989646137.11.1748237523455; 
 Sun, 25 May 2025 22:32:03 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e454da4378sm784310137.17.2025.05.25.22.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 22:32:02 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, mst@redhat.com, imammedo@redhat.com
Subject: [PATCH 2/5] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug off
Date: Mon, 26 May 2025 05:31:20 +0000
Message-Id: <20250526053123.1434204-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526053123.1434204-1-gustavo.romero@linaro.org>
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe29.google.com
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

ACPI PCI hotplug is now turned on by default so we need to change the
existing tests to keep it off. However, even setting the ACPI PCI
hotplug off in the existing tests, there will be changes in the ACPI
tables because the _OSC method was modified, hence in the next patch of
this series the blobs are updated accordingly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/bios-tables-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec435..216941dbb5 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
     };
 
     data.variant = ".memhp";
-    test_acpi_one(" -machine nvdimm=on"
+    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
                   " -cpu cortex-a57"
                   " -m 256M,slots=3,maxmem=1G"
                   " -object memory-backend-ram,id=ram0,size=128M"
@@ -1775,7 +1775,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
      * to solve the conflicts.
      */
     data.variant = ".pxb";
-    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+    test_acpi_one(" -machine acpi-pcihp=off"
+                  " -device pcie-root-port,chassis=1,id=pci.1"
                   " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
                   " -drive file="
                   "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
@@ -1846,7 +1847,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 
     data.variant = ".acpihmatvirt";
 
-    test_acpi_one(" -machine hmat=on"
+    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
                   " -cpu cortex-a57"
                   " -smp 4,sockets=2"
                   " -m 384M"
@@ -2123,6 +2124,7 @@ static void test_acpi_aarch64_virt_tcg(void)
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
     test_acpi_one("-cpu cortex-a57 "
+                  "-machine acpi-pcihp=off "
                   "-smbios type=4,max-speed=2900,current-speed=2700", &data);
     free_test_data(&data);
 }
@@ -2142,6 +2144,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-machine acpi-pcihp=off "
                   "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
     free_test_data(&data);
 }
@@ -2227,6 +2230,7 @@ static void test_acpi_aarch64_virt_viot(void)
     };
 
     test_acpi_one("-cpu cortex-a57 "
+                  "-machine acpi-pcihp=off "
                   "-device virtio-iommu-pci", &data);
     free_test_data(&data);
 }
-- 
2.34.1


