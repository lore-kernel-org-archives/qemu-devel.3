Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020C0C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEG-00069N-9M; Tue, 02 Jul 2024 10:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDy-0005LZ-0H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDl-0000Ra-BQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5HbSZj+J5fFVUz4QWaOQfMriUE05NQ5H5UstCGrrUE=;
 b=bw2CB6E/Yp5A9NTwKjc3EPgqvtEpU/zDkOxBAO2hICSdPhGZ86AdnGIeiM3ZMHavrltaC0
 bRpSSsw3R/phgnlc3cYbYdb+VUxnLGeT3VAqT+VkEy7b0g75JwEH+8S/C1A98aGgKnhOf0
 LpWVIMrBgPRDi1l//9JRno2jDJCEJIs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-pdZJDBJUMqCNhVbtcz1NAw-1; Tue, 02 Jul 2024 10:10:58 -0400
X-MC-Unique: pdZJDBJUMqCNhVbtcz1NAw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso2403472f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929454; x=1720534254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5HbSZj+J5fFVUz4QWaOQfMriUE05NQ5H5UstCGrrUE=;
 b=Yb7i72almIseAc138AN5cQxvKvb/I5pwFwPXzOVUMK27SN7UMxZv/m/babbKiJyhMt
 CS0fM0f1rvbt3SYt5SU1BOuBIuifflxt3C1NaZ5ljEoTuQKIqjO/f1tsZ6RL2BMOEaij
 JI0UjVP3Hssl73cxQVoZ+UPMZ7cVoU4i4+OmN8uhYO8Y5eetd8DP0nJGZ2UZuRcN/GUT
 pYRK72bXui/GUwRMD+OzFwAoIxBpVzMHr615NNYumO/M3Ly6xPkNXz/hCrPVN0VMxqqN
 WqoxPVK/O+5ktoAoIaGcTs1+DWq7O1OqrDTI+QjIkSCkc8JnAKYkGoKUvzAall3MKNor
 lE/g==
X-Gm-Message-State: AOJu0YxPe4MG+/d3j32ZJMygkczAA//JtIBBJvFdzHNtbId+vJDBesdj
 VXoanLZGFaSBqH+7Vq8QOrSNcPClNzX6qKu+ZxdX/eZREZN7C6UTu7RRz0+QrBhJBfxw9D3vQXP
 Gsrh96HH+YdY0CUhiaevQVcAZG8n5clyfVXbZJg4Pmk+Hal1VivqpzfPCdQkixOpBBZZmq/wqED
 LQkXVEz//NKxSm9gZvpzV5qMtMym7Pkg==
X-Received: by 2002:a5d:4fd1:0:b0:367:4354:52c4 with SMTP id
 ffacd0b85a97d-367756ae62emr5451634f8f.24.1719929454486; 
 Tue, 02 Jul 2024 07:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz8DhNyvdv6aBbt3QB8jItMlDHzyhEzu91IR/kZdL9LE/Iw/oHNnq08VseejoNe/DOSJpHkA==
X-Received: by 2002:a5d:4fd1:0:b0:367:4354:52c4 with SMTP id
 ffacd0b85a97d-367756ae62emr5451616f8f.24.1719929453961; 
 Tue, 02 Jul 2024 07:10:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd5f1sm13440198f8f.6.2024.07.02.07.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:53 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 75/91] tests/qtest/bios-tables-test: Add empty ACPI data files
 for RISC-V
Message-ID: <208760683664dd2a81f8c120e607a2fb5dba3d10.1719929191.git.mst@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As per process documented (steps 1-3) in bios-tables-test.c, add empty
AML data files for RISC-V ACPI tables and add the entries in
bios-tables-test-allowed-diff.h.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-15-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 tests/data/acpi/riscv64/virt/APIC           | 0
 tests/data/acpi/riscv64/virt/DSDT           | 0
 tests/data/acpi/riscv64/virt/FACP           | 0
 tests/data/acpi/riscv64/virt/MCFG           | 0
 tests/data/acpi/riscv64/virt/RHCT           | 0
 tests/data/acpi/riscv64/virt/SPCR           | 0
 7 files changed, 6 insertions(+)
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..70474a097f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/APIC",
+"tests/data/acpi/riscv64/virt/DSDT",
+"tests/data/acpi/riscv64/virt/FACP",
+"tests/data/acpi/riscv64/virt/MCFG",
+"tests/data/acpi/riscv64/virt/RHCT",
+"tests/data/acpi/riscv64/virt/SPCR",
diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/MCFG b/tests/data/acpi/riscv64/virt/MCFG
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


