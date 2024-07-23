Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003AC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGa-00012r-8J; Tue, 23 Jul 2024 07:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGU-0000sY-9l
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGR-00033U-R0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfiaAZu1KXFxLDbrHFmgg4NXXcuygsvbvDqpALcUfu8=;
 b=SVFVkkp9UNBGqDiUJZxAdtrSW6PP/z43UCWx+g8TDR4/6OB4LcoJIPsmyzUtsxYenCRuwP
 kOHcG+ELBJ5w1P1+AkXSltFChyWZkvrkJQb1YFKpMKJSX1tR4e3GnP1sUSFH/geivAIqmn
 Xbz4oZvhh617Nzf7xtxJ9lpn9Zu4GcU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-odEllz1VNPaf61ykFfxviQ-1; Tue, 23 Jul 2024 07:01:02 -0400
X-MC-Unique: odEllz1VNPaf61ykFfxviQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a766a51b0dso1454857a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732460; x=1722337260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfiaAZu1KXFxLDbrHFmgg4NXXcuygsvbvDqpALcUfu8=;
 b=ammD+2SST0dlOrv4QcytykTGR/rxSXOg6A4ngxBdVR1UZ/8exNDnRSqU0ctSDzWVn7
 IU4Y6ynOKAIbCoYCauziEJsCNVjrPcK+LpqNaCkKlOngIjBocaygjw7CmdS8b9jIXrk6
 OspbYkjq8PSiO8o/Ocu7n7lw88TIYH1fuDPIiGDCoGTL6BpbHtm7wzC1hprDCsl2ZiZW
 d+m9F/dth+ck+4DaXOG2mCmOKJQUaM0TbkHtAwqbertqFggTV2n/glK7Dvpf9BdZgYfC
 nvjJwKwB5J9IuUXQTRheLefSpt6eAMuswSJhpj4oiWBJP0IqSqIUlMVh2gmI1P8S3Sby
 0Wmw==
X-Gm-Message-State: AOJu0YwRBDyO5i68BzyevFZe3RdwoxXP0Oy8+HVrAVj3TG7yFKni7sKd
 BzX8eEED2ZKNmE4Zx33kIlfXusTkEHpLMtrQTBKHTw9lKQD1wHTyQmVTkHR0ZQp3JQZsaVrjcU/
 Ltt5KvB5p7dE/HdefhVdd52nSTu0usFz8uJLZmb8ts84Fp5T2IM2CluTFiOVJlQm7fWekct67tG
 /IMVxv2gFjID2DZtV4G+xdXdCccZ3PyA==
X-Received: by 2002:a50:c316:0:b0:5a2:2654:7fd1 with SMTP id
 4fb4d7f45d1cf-5a479c68cc3mr5390683a12.36.1721732460402; 
 Tue, 23 Jul 2024 04:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBYVThZX7ANk5IUMxdIRk0Vu14SbL3gPO8WF7QGVZAyZ8iPgX4EIBb+/Fbxohn7nCi3rQ2Gg==
X-Received: by 2002:a50:c316:0:b0:5a2:2654:7fd1 with SMTP id
 4fb4d7f45d1cf-5a479c68cc3mr5390651a12.36.1721732459775; 
 Tue, 23 Jul 2024 04:00:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30aaa2c72sm7306317a12.33.2024.07.23.04.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:59 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 57/61] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Message-ID: <5b966e548fb7a530431379bab053eb1d6fb25867.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add basic ACPI table test case for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-9-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 498e0e35d9..36e5c0adde 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1963,6 +1963,28 @@ static void test_acpi_microvm_acpi_erst(void)
 }
 #endif /* CONFIG_POSIX */
 
+static void test_acpi_riscv64_virt_tcg(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64.
+     */
+    test_acpi_one("-cpu rva22s64 ", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
@@ -2441,6 +2463,10 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
         }
+    } else if (strcmp(arch, "riscv64") == 0) {
+        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
+            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
MST


