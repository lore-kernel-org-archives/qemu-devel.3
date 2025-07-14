Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A1DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGv-0005Gw-QE; Mon, 14 Jul 2025 19:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGe-0003rj-6D
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGc-0005WX-Lb
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJv/YmIjonHQlMT0SQkrle2ZJPKdQ/3itH7NXNzClac=;
 b=JbQ+OFXrcePBTJAWUbofyoPPq7rfuJCxtwLEoNargBjnfXyoGWUazq267GKWGCWy7PIxhN
 rOYLsqBHao76y5KZDcQYXjOhIAs1teROxOPwk1561Iu+RqfFBcyD7teZwwmLpRng+PJeJj
 rJd5Yp94yFuaHAVAUvV8XyHsTwqJ5AU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-2yLOjqqGNXmcWIpdLyNn5A-1; Mon, 14 Jul 2025 19:07:24 -0400
X-MC-Unique: 2yLOjqqGNXmcWIpdLyNn5A-1
X-Mimecast-MFC-AGG-ID: 2yLOjqqGNXmcWIpdLyNn5A_1752534443
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561dbbcc7eso4644795e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534442; x=1753139242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJv/YmIjonHQlMT0SQkrle2ZJPKdQ/3itH7NXNzClac=;
 b=ThXw3XsZhFfeA/1/5srtcLX3O0/C31fmUVzj1YLuxd8ScrTGTHlpMCxCrzvhCp9lFP
 alabTpMyIFDijUqH+GZWg79sapf8E7kw6yBbO+Dna0k5MmcVBnveVbGWNfVXIE7JfnOH
 5zP+1KZCjnLVixkS987zdYBsl5rgTgv8J3QHzUibyPK0nDJs1vKpFkW109g8TunE6kDd
 LrJS/SFF3mYFh6Srr8mTIrsOMxdyS4fg5ogq6A3d6zZ9CkpoTxhyvBbG+8F0fADB7IBz
 YhZskETWliAXyDL0TPL4/x6y3T2QB8X1jfnieS1KiAvKst7+kv/UE/DvFhqGUKfQpoh+
 nxOQ==
X-Gm-Message-State: AOJu0Yy+0GeTxnCrL8vBYr28Yl0BTwEJPPPCo9ebh4Y1YOmdWUkDd20v
 GuIydwWiYbvgjoZgK2cmpaPwIQS4UMuwLXo1I0TFw0cb8gX30ZjExZ/IincRismrZyheQIRSMv5
 9Egu7PjgLJRwdGydkxuU8obZbOPhLIJjhGAULpKY9xJMze002N6olnENQ9Gtxqoh6i0Kdm23fT3
 UVu8GvHpj/cR+PJP0SAxo5eCVXAZKkWc8B6A==
X-Gm-Gg: ASbGncsIb+npcPYiYEf7Po2S98TNSybg90NKm24MM6T8RIa1441/FhvoEXUAaRf9T6J
 yqgHCpNPEtk1/ko1Gll8VZQvdfHqmQSg4X6Zg196F+NflC6U4eoJsWB4pXp/WHk1rleYFI2hfLX
 XJSUjg2qHRzHYUjCuOmm5YTbCcaktrWMQEsLRIQTvBzZp9N0Cwp0/K9Oq3PEprQ6UHLC4UzLRIX
 nQIXyGcK72VbU2jfe2uR2kiI+L+xQ16KtvG7gG7YJLDmZgWnU0QPCppbSmD8BFZmjN6z1Oaqtci
 w4XzhB6AQryPF7QV3X/CjejAI0hKUb+B
X-Received: by 2002:a05:600c:3595:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-454ec15e5c5mr131981795e9.11.1752534442271; 
 Mon, 14 Jul 2025 16:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdTOtbZq8Kx063i3ZxrpbYGmrMGCPGdabNJ/KZtaCZbC5wZWtRq4ZwiSKHHRZjmaXGYnyaEw==
X-Received: by 2002:a05:600c:3595:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-454ec15e5c5mr131981625e9.11.1752534441827; 
 Mon, 14 Jul 2025 16:07:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561a052729sm48139675e9.33.2025.07.14.16.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Chen <chenl311@chinatelecom.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 26/97] tests/qtest/bios-tables-test: Add test for disabling
 SPCR on AArch64
Message-ID: <9ce87106c7bcb1c2ada17e578db87f13ac29ae92.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Li Chen <chenl311@chinatelecom.cn>

Add ACPI SPCR table test case for ARM when SPCR was off.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Message-Id: <20250528105404.457729-3-me@linux.beauty>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f41e638014..c84cf1070d 100644
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
@@ -2672,6 +2690,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
             qtest_add_func("acpi/virt/oem-fields",
                            test_acpi_aarch64_virt_oem_fields);
+            qtest_add_func("acpi/virt/acpispcr",
+                           test_acpi_aarch64_virt_tcg_acpi_spcr);
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
-- 
MST


