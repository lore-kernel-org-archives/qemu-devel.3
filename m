Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE4606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ibCWiYoP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJn96-0001Kp-Ds; Thu, 22 Oct 2026 03:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn94-0001KZ-PX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn93-0008Np-54
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8a064fac8cbso1014415b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792653804; x=1793258604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+6yBcr8TNRTYM7tzElNbeweGtXzdHQVdEk4IlWyoBOY=;
 b=ibCWiYoPmJmh1bESqUiO1NOxvbllXjymMFpwihyvczOh68Zg1G1yg1wlxnGrBvdRMZ
 mtgjZfinAs0m8+Oh39+x/tRpQvCAAsGd6sI32ax848JiF5BLjCSl46q2F/+dzFObz0H2
 8fI+GRIk1/WQDsC98uzyaG4nIaIeRgPU6cAaCe65P4PnjupFCIspndQBPyJRPhUKcD6P
 /c4I/mKUWLZsXaNQww01aHIOc/9VOjOUraHaCslYKpmSHewCO8/VM4lU02fG7/GhD4P+
 8TWH/4XSJIpV9mtDnbdIDYzt1XO5EhntT6p0HFyTQ5fe91QlY4RdXVBNIE12NqLbdZDn
 rrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653804; x=1793258604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+6yBcr8TNRTYM7tzElNbeweGtXzdHQVdEk4IlWyoBOY=;
 b=x9LfQBuag01vab81Ezg2jrsR4dmPGj9iru5ZdTg5Ivi0hR2V8s/fdourXCDz0Abe1q
 PgdOOJkHStQ6RsL+qhMuFuQ+NyWE3m86VPk72AIxsLZK4JhFiGkUbd0bJiaAfA/IAWn9
 txIUP0fBZ+HIT3XBTtgbua088sLVli7JruyYamqJZlM35kE1hnK9VkqLMv4ixoC6JnW5
 YRe0OVD2NrFAtTtp+TC7Zskt8J7d2GwRaagwgA0v8BNmsCUYtVATEZVyWIICclJOT5/t
 FGmWnsbOrWINw8+m0rqlyicKTMBTIm0DFsHFmFBofeStuNfcGeJE1noIL+7clg+EKI6K
 AdeA==
X-Gm-Message-State: AFq9FYKz7ZMpWncfiyDFbMLswH/bp+TVzNw9AXRWnVQw4Gf9Sbk3n2UV
 GdPqoZ42B3bLKQ1UAsuEMXr2nZNQVN/Gy79kn/GUUYrENMPCB/b66ef/dSLWS8e4ytg=
X-Gm-Gg: AYBFou0zQ5GE4WI1MHo+GGJRcF0JDtCq+v9zWtpvOfSTYHMF3Sekc9lw54QHc3STdTW
 GnKnxsHVfQXMT6taUtP1JoZ+ykdd4KLbvLQMyXdt5G8Ej/Ui4JSd+P3fpX6N8MM8apbIoxIJauB
 Ql75RAHyuDnFkUEgOwI6N1jWTJODiNkSQgPSU3HW89oDgkP+Ei8P3fwyN3Y0waBrm69t6HCwBYr
 lUHKZbLtTMw3SVkfdTYcbDR+ssTI5w3OEzpvO1xbAVUvs8fr6VbZD7a9wDq8xxjs2YoUm4pF3oQ
 PSFI9b8UZAHyqq0fgo/yLYeU/hTcF+y23jEwWFSMdBWVO5AYvDK1d03BYzYcb+gVjFmisT0XuS1
 sIJNXG5Q1qu5Q9PT2Dpht1+RQ0WfyWbuhseDK5QN9+zXn73PrKn6FjF230S3f/rQZkY32yQKDbr
 ufyoHfel4LJDlyECTdjyBnPp+nDCJixFrfI3dsoubZwOakYuBk2mi3ZCIVxijVjXNqFn3QoefXQ
 Xg/BEg8EfwK1uV/UzEau3Fv4ii8TQTHj1YiV1YL8UQfW7I48WHyj4DUU90W
X-Received: by 2002:a05:6a20:6a1a:b0:3e2:490d:5111 with SMTP id
 adf61e73a8af0-3e287bba32amr3761424637.8.1792653803611; 
 Thu, 22 Oct 2026 00:23:23 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0894b49dcsm1699776b3a.16.2026.10.22.00.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:23:21 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v4 2/4] hw/loongarch/virt-acpi-build: Drop UART _DSD clock and
 add _STA
Date: Thu, 22 Oct 2026 15:22:36 +0800
Message-ID: <20261022072238.319308-3-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022072238.319308-1-waysorrypub@gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=waysorrypub@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The UART _DSD clock property contains a typo ("clock-frenquency")
and has its key/value order reversed. It also specifies a 100 MHz
clock, which does not match the emulated UART.

QEMU's UART model uses baudbase = 115200, corresponding to a clock
frequency of 1,843,200 Hz. The Linux 8250 PnP driver uses the same
frequency by default when no clock is specified.

Since the default already matches the UART model, there is no need
to provide an explicit clock property. Drop it from _DSD, consistent
with the existing x86 ISA serial ACPI implementation.

Also remove _CCA because the emulated UART does not support DMA,
and add _STA = 0x0f to indicate that the device is present,
enabled, visible, and functioning.

Signed-off-by: pillow <waysorrypub@gmail.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 54965f0..55c7641 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int index)
 {
     Aml *dev;
     Aml *crs;
-    Aml *pkg0, *pkg1, *pkg2;
     Aml *scope;
     uint32_t uart_irq;
     uint64_t base;
@@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int index)
     dev = aml_device("COM%d", index);
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
     crs = aml_resource_template();
     aml_append(crs,
         aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
@@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int index)
     aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
                                   AML_SHARED, &uart_irq, 1));
     aml_append(dev, aml_name_decl("_CRS", crs));
-    pkg0 = aml_package(0x2);
-    aml_append(pkg0, aml_int(0x05F5E100));
-    aml_append(pkg0, aml_string("clock-frenquency"));
-    pkg1 = aml_package(0x1);
-    aml_append(pkg1, pkg0);
-    pkg2 = aml_package(0x2);
-    aml_append(pkg2, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
-    aml_append(pkg2, pkg1);
-    aml_append(dev, aml_name_decl("_DSD", pkg2));
     aml_append(scope, dev);
     aml_append(table, scope);
 }
-- 
2.56.0


