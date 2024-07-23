Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE92EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGR-0000f0-OV; Tue, 23 Jul 2024 07:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGP-0000SP-5t
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGN-00032q-Dd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzt8G/PRNnMChFMEQ4aarEs6+i24lgZhcl5D6q7vGuM=;
 b=frzaX/9P2g2JHb0y+rcKJ68OZ7FiVshaqXNIBgucR7J6P5eW2OwMuSADiFhxTvznJs8Gzb
 w0Re+H0wgeHSUkVfyzRagG6WyWfTj9UGy+Bsc34YHLLr1LnnSPRpDbKbEZ6nJfJsJ5bw4a
 qNJAzK9sgjMUH53qalw5O+Fa6Me9W1g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-X8rJZoFJMCqcojAAMlIepg-1; Tue, 23 Jul 2024 07:00:57 -0400
X-MC-Unique: X8rJZoFJMCqcojAAMlIepg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77c9c6bdadso49569166b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732455; x=1722337255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzt8G/PRNnMChFMEQ4aarEs6+i24lgZhcl5D6q7vGuM=;
 b=AGcqCTRJhKCGFli8QIZdqDyTqHwQqQA4vDN5LUJGF6gCfyfWxyxEB2zz+lUoNwyc3O
 on335BmuJ8m0qalf+B9vChkAK90lZT157pQvtxtq5ZJMqLnaRuNRF5LNtHu7rSUpiX9Y
 lrC9ij12dP7TtrG0RILfYx30smR6rtZS+R6kEk/r8SoLC7oeImsjs+RBLSYbMwybYwjl
 skveiWJvTPZSpXTtD6OqyEOKNZwySm8eFQPZlAiEk3BvI/rK8YfwhvGyA4hPWJFanY2o
 saAlF5fCBb8s/WfLZUek9S+lskAkBxmUFZv0xy5zc9iVMBY1ukvx/0WTnC52nLnIf3S/
 DEGw==
X-Gm-Message-State: AOJu0Ywv+1V5GhDf2PW0tyPssXxp+oiWPoFVdfK6UJUIm/s69rtx/Eyb
 c5Frhh17IepQ+3c+vhpMGkJkX0pJJr2LX4F96ufwgJTWITN0KJTmEERl2xFqzweMlM2L+v0LeiL
 ckUKQcoWOJbhJtB9oYcKP8NuuHJujWY+0AcwBPFLI2ze0NRa4bR5lqwoXjPOw0UD5rZ49Jm5lEg
 LtdeRQuCOQO9Qv3+W+NRxi/LHmuq+KKA==
X-Received: by 2002:a17:906:7315:b0:a77:cd51:3b32 with SMTP id
 a640c23a62f3a-a7a4c45555amr703390766b.62.1721732455593; 
 Tue, 23 Jul 2024 04:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlIEs/VclIdqLZ0sRivY+ZDHiB3WnRjOkoZq5ol3WksP4uaEgNGUJNR6RmnnsuqhfEn1MQw==
X-Received: by 2002:a17:906:7315:b0:a77:cd51:3b32 with SMTP id
 a640c23a62f3a-a7a4c45555amr703386866b.62.1721732454838; 
 Tue, 23 Jul 2024 04:00:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c922b49sm523517266b.181.2024.07.23.04.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:54 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 56/61] tests/acpi: Add empty ACPI data files for RISC-V
Message-ID: <cc3ba2422554b63f30b697eb67143b5d48c5b7a3.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As per process documented (steps 1-3) in bios-tables-test.c, add empty
AML data files for RISC-V ACPI tables and add the entries in
bios-tables-test-allowed-diff.h.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-8-sunilvl@ventanamicro.com>
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


