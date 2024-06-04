Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C92C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZW3-0005la-5L; Tue, 04 Jun 2024 15:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZW0-0005PR-5Y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVy-0000zP-41
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=381VnGSReclgz5bDfsJYpCqnbDXNXRPUyOf3bkjFhOs=;
 b=L54ahSSOR1n8YGwvGy0l1eUEfI5vqCEZpetrg0ezIEfwfZWaj13xUc6t2shzWQO6x35HgY
 e+WVgRF1/CSUbUNVsYpsBBFzotvSHQQBiaVCUmwOeioHu/tY4km8ogh9bFC3VSzRXFg42l
 NPwMRxsZs/ZW754rxlI7v9Puc24BGZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-6OhfSn7SOoSAGcYG-quBMw-1; Tue, 04 Jun 2024 15:08:06 -0400
X-MC-Unique: 6OhfSn7SOoSAGcYG-quBMw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212adbe3b6so35388455e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528085; x=1718132885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=381VnGSReclgz5bDfsJYpCqnbDXNXRPUyOf3bkjFhOs=;
 b=kvEl5AlenFaUHytHGPFa2n35ovy0W7Aig0l8+4fhUpwwDJP0/OpwdBeqpMoKofgspQ
 1aEsRLUgyaCylwxS5ISB2399wCUCpz7mcrVoVeNJlvvCspmivaugoDMsM2ppRP3MmjoA
 JYSaS4ggwiyeHzdp+nFgURf9gyjBzkldiQilD/V6UL+OXGh+wKBPbREbEwTz0WnkbB4c
 QHQlRfnZsCBqaNNSuY8RQayCdUVvJLGWwqKuYAgjjw4OhUjwt+aqPeWRpZiR+rvUQX6h
 iZEnxtALXVmTQFWGondaLMN7vF5EPDf7i8LsXkRk9EOu/gkJdTL/ol895N9f0qgRxcAU
 gJzg==
X-Gm-Message-State: AOJu0YzOJmgj+BFJ8dnyECGSsA5UOK7GvuGgr+L29xUiwycs7WMGdg3p
 90I/A8fesiI9ey+tYXuJnflUtIdz3299/zl3OH1Dl667PIo17Cv8/mFT7/o59uemXlaxDOQW+Wt
 CWV2M3XA1rAU3GzTbGGTnekLOWk7rcxwuqRnL+oM1p0g7qEdOzw/377PRozPoJ6zjuboNrPtIb+
 HCf+nSNuU+4bc0BtIDC91KishD+iNsLw==
X-Received: by 2002:a05:600c:524d:b0:421:20aa:6045 with SMTP id
 5b1f17b1804b1-421562f21f3mr4042085e9.24.1717528085130; 
 Tue, 04 Jun 2024 12:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzV7pUpU6/XIevsL2Do1McPWw8dJNepxEqsayE4n7jiFfSkJ3RtWWQs8e2PVjBYnmRaUE5sA==
X-Received: by 2002:a05:600c:524d:b0:421:20aa:6045 with SMTP id
 5b1f17b1804b1-421562f21f3mr4041855e9.24.1717528084606; 
 Tue, 04 Jun 2024 12:08:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214beb5c9asm32041825e9.7.2024.06.04.12.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:04 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 34/46] bios-tables-test: Allow for new acpihmat-generic-x test
 data.
Message-ID: <4680fb4a69d137870c421a4da697f4b39b002dc9.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The test to be added exercises many corners of the SRAT and HMAT
table generation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240524100507.32106-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
 tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
 tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
 tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
 tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
 6 files changed, 5 insertions(+)
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat-generic-x

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a5aa801c99 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.acpihmat-generic-x",
+"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
+"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
+"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


