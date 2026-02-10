Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BBDEA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAB-00020I-Cn; Tue, 10 Feb 2026 08:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA4-0001x7-Tb
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA3-0006KE-EG
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so40445955e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731534; x=1771336334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gFf1z45G5YUmVjhRjNyUdMmLPtBu36lYSS9gfoGGAvU=;
 b=Sorr4/N+lBly7PyYXEXKE/TukDPdS24wK+zabvChqZdUhdWSXCY3PFQo4DEIwQvDlg
 VZ2qJKQNrI9P29NULi2/dMyb2xw3RUk4rO9klEV618HF2NQ9rCq3lnPpx3iialFbKR7o
 H9gOGqi/3mMUn1Jc59aoDVFlVfK9HaiXHA1s0Yhkrdvng39mJN6GCLeB0b3UsU2gLQLk
 TiD5VyYle+2D2uGXnoLHFDNQA2I95SKKB8hZvVfyLqrQwvt5xiSjKsZGGKL1RyseSw+N
 22z5ZQueA3Asc8ecMD417zChtaj7nC4ie+naJUAVdFeaeHGWCdYz8JVwnhSDtB5R4vo3
 L1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731534; x=1771336334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gFf1z45G5YUmVjhRjNyUdMmLPtBu36lYSS9gfoGGAvU=;
 b=eJxDgQoGfI5D5pr5mH3mT6KxmPpw4pESeTsUj465XdCRQU6FZimmW1VEqxJ9wLChoD
 ie3BF/4cL4W8lrI9JFqKUdRpPMj7sedySvtIDAHMzqQvqxwKvdVfexwHLGZkmeV3Dsnb
 lbyO4adOxZayprNv7MkfFpVbZZrcWdv4DoRuYaHR9PeVK6c0r1r50KwG00AdwYkdL4oJ
 2L/8PpeaFuSfr5FYApj8QYByve9NKm1LWgKBvHbbb0qEeFu0AfnUhuGeZBx1a9YLJcaS
 BHLQcsdArtL4Nx89348Kuz5AwbkTPMAXWT3aUP+S3QyiyMDL2L6PVF+g+OsazmKLZj/z
 4h/g==
X-Gm-Message-State: AOJu0Yw+8EGKIj3dADj13O/7RbHktX6Zdynl3n5IyqBVwo/PmQkCH4mT
 uhuh0REfudo//BvMKTmMjDOkZeQZoG9QcEO0x0ZDlypSk9ipR5EHBNrHnk+YZ2kd6cDEV5Dpjbh
 js4Rp
X-Gm-Gg: AZuq6aLXbriVDOl0B7kB/GxZuNy0IXFBJrcjWiQfTz0AsY+ACwT5z2rOnwwm8/NCBzf
 aGL1QoJUSytpZivcr7t0Ld4FB4i5dPEvXQlefgj5zCsciRdQSkOTHOHsj2JmCy3P7I0B2HTvmEI
 FpKFaA8ULFzgrkluFVdaiKcznAwLTbbxX9aimGRV4wNPxUm/Xde3j5s+qdEnTEOaHqlG5NQ9Lq9
 fAHQYIVrwWbA7F2iVpCV0UMdcuu/OSMw/jUOwiqblkVnFIShwFRJpbcxppveGQox5/w1KrQqLvc
 hk1/I+Zv4tVy0P5hPUneftHT7zRddOyzN3wMSYAyfFL5LrBfFHyhJwGszJiPK0ff1cf/I9zUybL
 hV60b++UDExatOIQwTKjyej/Iye8Ef1DDZaX8nhn4gzU0RNJzX3TiWMRMrXKOcyLjN/LbCrlQZg
 jDtDCJ8s2VQLA9ck6939+pdwFUfTbWMHoF0Y5w+IA22YmhK531HbUX7IuF04JvE1b4sQA1qNwrN
 xiMx9oUTjqh4pU0S+shLEGoD3XtnvM=
X-Received: by 2002:a05:600c:528b:b0:482:f12f:f35e with SMTP id
 5b1f17b1804b1-483201e3759mr219385725e9.12.1770731533663; 
 Tue, 10 Feb 2026 05:52:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] qtest: hw/arm: virt: add new test case for GICv3 + GICv2m
Date: Tue, 10 Feb 2026 13:51:47 +0000
Message-ID: <20260210135206.229528-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e489d94331..a5a5b8807b 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2252,6 +2252,25 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_msi_gicv2m(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .variant = ".msi_gicv2m",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  "-M gic-version=3,iommu=smmuv3,msi=gicv2m", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2834,6 +2853,8 @@ int main(int argc, char *argv[])
                            test_acpi_aarch64_virt_tcg_topology);
             qtest_add_func("acpi/virt/its_off",
                            test_acpi_aarch64_virt_tcg_its_off);
+            qtest_add_func("acpi/virt/msi_gicv2m",
+                           test_acpi_aarch64_virt_tcg_msi_gicv2m);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
-- 
2.43.0


