Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECFAC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DLi-0004DS-CG; Tue, 22 Apr 2025 09:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7COt-0000EC-Mk; Tue, 22 Apr 2025 08:06:57 -0400
Received: from sender3-op-o12.zoho.com ([136.143.184.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7COp-0002mZ-Ib; Tue, 22 Apr 2025 08:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745323582; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CqgUqqTIGnpDkOAixwAJdrt0dBVbevIOgoiT6TzUD4F1yLfI146Nph+Xz5HB+0jF7OXbUtTd/b2yt+Lnj4Z2qILfy348DAmuiaC/CEhmYs6vp66rub8LCHPX/lnDqWl5B8llV8M3U1xYo3w1P9qTkv8e+UGFpBh+/kr7DTTkYjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745323582;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=2c0O9T1s6X8/ZTemOXWayC8UqGgBEItGWgmlUlE7g6Y=; 
 b=nT+jbnnl1DiH8C3uLG4+ImfdhHyc6bp8pbO7Vy/UM1bcVs8qnJyXiAAu1FqFGHrtYPyjgitILYJSWIbc2EIu8DnvhG5bDGFfDgd/SqwIzvJeFfM+lnOi54HtveaSXXQVBJy19kaP5PCgCN89ZzMPPOH8EUeZnTuSxO78HzSZ2IM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745323582; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=2c0O9T1s6X8/ZTemOXWayC8UqGgBEItGWgmlUlE7g6Y=;
 b=ctqEAoQ8LMpLvHzgPZsQERzz9n8WacvHTYHnEAj+iuf9cx6wAm4v5gK9YxLpRMA8
 VCoxfs9oJ8RJoQ8PNbfHSg7oLRKUxFDp53+itQEqEv5peFlXidxFLoKk7vgvpu3eHV0
 Llo/QIENnordzV0mQOL6ZU+C4yrbmVDRiA48xRbk=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745323581073534.0804907669417;
 Tue, 22 Apr 2025 05:06:21 -0700 (PDT)
Date: Tue, 22 Apr 2025 20:06:21 +0800
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <1965d645e78.faddb8f4912124.7439555839695048949@linux.beauty>
In-Reply-To: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
Subject: [PATCH V2 2/3] tests/qtest/bios-tables-test: Add test for disabling
 SPCR on AArch64
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.184.12; envelope-from=me@linux.beauty;
 helo=sender3-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Apr 2025 09:07:38 -0400
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

From: Li Chen <chenl311@chinatelecom.cn>

Add ACPI SPCR table test case for ARM when SPCR was off.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec435..d2a1aa7fb3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1789,6 +1789,24 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_acpi_spcr(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+        .variant = ".acpispcr",
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  " -machine spcr=off", &data);
+    free_test_data(&data);
+}
 static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
 {
     test_data data = {};
@@ -2583,6 +2601,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
             qtest_add_func("acpi/virt/oem-fields",
                            test_acpi_aarch64_virt_oem_fields);
+            qtest_add_func("acpi/virt/acpispcr",
+                           test_acpi_aarch64_virt_tcg_acpi_spcr);
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
-- 
2.49.0



