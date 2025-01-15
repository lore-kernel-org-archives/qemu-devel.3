Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1281CC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7s7-000632-DB; Wed, 15 Jan 2025 13:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pq-0006zg-8y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pn-0006fz-H7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ag3nS8CSRSWzObDvb75VNRNg7yyr8lxnvn6CfDV/TZ4=;
 b=MgIyACh72iJo7lxm96PPggAFctgXZbqIjJ+420AJ3NuRw40bv5t174nuaJMYEDVRLCmUgG
 jxKMHcfL22y5GL+P/BYjspLbpVyNelmJsREZvl8JZmls2y9YlsGnW8t9PnC84yStq5qE90
 8WiFhRhwqtOpFqbsmqWH98dmqM34c5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-XtLt5IrVNz-KDr0HD35U7w-1; Wed, 15 Jan 2025 13:09:41 -0500
X-MC-Unique: XtLt5IrVNz-KDr0HD35U7w-1
X-Mimecast-MFC-AGG-ID: XtLt5IrVNz-KDr0HD35U7w
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43646b453bcso36825145e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964580; x=1737569380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ag3nS8CSRSWzObDvb75VNRNg7yyr8lxnvn6CfDV/TZ4=;
 b=VT9nOoOeFDdnX3YmdHbyqJKZfBsNfQTcO+tzG9pVfJyHI3oAYaK6ySVkg3w7cp2tBQ
 ynUASsCZ56DV9kPiW49164I1oA1W36M0WJ3igPOHdPMsiCObGiKkC0Dizb3jW77Vxxlv
 wZqer2JhQBnG2rIZlEbHI6+yS+1hslZF3n4wgaay4dQ86JU/wrmLK9T/zXJQsHG0eZ1P
 SIzv/qfP0HtG2HwtIg3YIvCzzdeQQtwk2+mjwgY/26tmBqnSDXDKSMGhiqxawy8PEImV
 CUcmC9q/DfJ83A6mab9Q43haZiiqaKIURpgETN98JFeoJ9O2jcx/Gj8D0EHCNErXq7Dz
 /0jA==
X-Gm-Message-State: AOJu0YyoCtrXw7HDcq/7NQB58GSi/A+Of1VtbkiEMtWR6WCvX320DX+C
 J78dydefP6RATn5f2C6EcrIimAVzvX2KQi/TbJ8xlIO2Hh75HYCEEwAgRv5fucAVhgIXFtzB7YC
 v4p4NMIeJGYQI4TvlNr5hAPb5hhIF9jxJM07t60uUR71+9x5emIrbjKZfeQIQpGlq6LTcxFXhKr
 t6P3rL4g+tQvTw0Xff/21Is7wagCBjwQ==
X-Gm-Gg: ASbGnctGhtQG4coLvsTlP+ncz0QLpK2+RcTJP7UKF2V7Eoyz44Qw8YXABQ6y9mb5Sub
 Y96jBHXO5r1qXVuOSBExLCwN7Hlj+hifmt5HA0zs34rtJO5eoUraLNMyxrbjQHEgCJCd1RyNU6e
 qFrEjAneWBCZ4TOb8doxb2BB8CPfuSJsbkC3SOVlKgOSKCjlL3oOo0Myq1bTXWRyVMC+UwHD83y
 j21YhF4reSisIIefAok9cmEANrTW/RdfJH/CLWL3Yfw+3uMKlep
X-Received: by 2002:a05:600c:468a:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-436e26a78a5mr234939245e9.9.1736964579900; 
 Wed, 15 Jan 2025 10:09:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1aZa0Ck+WEMB49/GhnZBuRGAB7VVFOIbhKJYK3EAUM5ujYSmPju3bAXwtFhZGKBqH4W08/A==
X-Received: by 2002:a05:600c:468a:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-436e26a78a5mr234938975e9.9.1736964579486; 
 Wed, 15 Jan 2025 10:09:39 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c617sm31454915e9.37.2025.01.15.10.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:38 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/48] tests/acpi: q35: Update host address width in DMAR
Message-ID: <81ab964f21620db32558277f220eb0d803c14109.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Differences:

@@ -1,39 +1,39 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/x86/q35/DMAR.dmar, Mon Nov 11 15:31:18 2024
+ * Disassembly of /tmp/aml-SPJ4W2, Mon Nov 11 15:31:18 2024
  *
  * ACPI Data Table [DMAR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "DMAR"    [DMA Remapping table]
 [004h 0004   4]                 Table Length : 00000078
 [008h 0008   1]                     Revision : 01
-[009h 0009   1]                     Checksum : 15
+[009h 0009   1]                     Checksum : 0C
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   1]           Host Address Width : 26
+[024h 0036   1]           Host Address Width : 2F
 [025h 0037   1]                        Flags : 01
 [026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 00 00

 [030h 0048   2]                Subtable Type : 0000 [Hardware Unit Definition]
 [032h 0050   2]                       Length : 0040

 [034h 0052   1]                        Flags : 00
 [035h 0053   1]                     Reserved : 00
 [036h 0054   2]           PCI Segment Number : 0000
 [038h 0056   8]        Register Base Address : 00000000FED90000

 [040h 0064   1]            Device Scope Type : 03 [IOAPIC Device]
 [041h 0065   1]                 Entry Length : 08
 [042h 0066   2]                     Reserved : 0000
 [044h 0068   1]               Enumeration ID : 00
 [045h 0069   1]               PCI Bus Number : FF

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Message-Id: <20241212083757.605022-18-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/x86/q35/DMAR.dmar           | Bin 120 -> 120 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 46f80be9ca..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/DMAR.dmar",
diff --git a/tests/data/acpi/x86/q35/DMAR.dmar b/tests/data/acpi/x86/q35/DMAR.dmar
index 0dca6e68ad8a8ca5b981bcfbc745385a63e9f216..0c05976715c6f2f6ec46ef6d37790f86a392b5ea 100644
GIT binary patch
delta 21
ccmb=Z;BxVG460yYU|{5#$R)+7KT$Op05(qqk^lez

delta 21
ccmb=Z;BxVG460yYU|<xT$R)+7Hc>Sg05*ICk^lez

-- 
MST


