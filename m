Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F4FC3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmW-0000fW-Sy; Sun, 21 Jul 2024 20:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglc-0003Pj-MG
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglW-0005yS-3M
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzt8G/PRNnMChFMEQ4aarEs6+i24lgZhcl5D6q7vGuM=;
 b=B//3CDP8iUE9kLts7+p5UfQghhNDJuqXAZeNMs5TO5f+67C5VX6ylsgSwH9Q7ahW+X+kD6
 HmBaGXUb0ZaL6uBQOBTWhbM4YGa4PhJ9nyTX09vXuuTlgrWCYQ1rIsT9YJm4dDexPX/EQ3
 gh8uLmXfxCd3GNJdmLBvHhNpiDg0OyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-sGhs1ftxM9yN6lJMEDkz8Q-1; Sun, 21 Jul 2024 20:18:55 -0400
X-MC-Unique: sGhs1ftxM9yN6lJMEDkz8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso37783415e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607534; x=1722212334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzt8G/PRNnMChFMEQ4aarEs6+i24lgZhcl5D6q7vGuM=;
 b=mGC1qpTK/SQHSwoVRrBNO6VyXiVGhpMdfRCQ5IzPV3PBuQRRgoOZiRIMAptW7JZ0TU
 8Q7kuS7ymDtCvzhbJZOKW3WFegc7K6WR9I5eO0lGXFEawLCY55wFJ7BUwKCJHnoXIHTD
 +BpS43vgp4Pg82kNG8MDqJsOEaEZSJKFWppgS4KOLw0kG6qEHyRZ5+OWDUCU0yPOX81M
 648or4HukpkPJx5P15msdaxO47Hz1A2PYq0jnqradx/QkNvhn+qQNMhJMegekP8LrXwd
 htj0qZ+4qr0klq1mYMVu+zCgoe+6P9ZuS160xbOnU1R3AiO+4zuIfgkWO72P48gFQn9e
 M72Q==
X-Gm-Message-State: AOJu0YzdXNV3iZ8raqgA+OCq9uBHrYuvBo9ACjnp8ccBSJ7zxkhlYGmE
 8Q+dg6W6NC2nxesUZm3vHyFfYobdZo7ax3YoAfovx9VoIFer4levHlrGiQTl8BRcf7CmITStfzs
 pDWTwqoLOzmABJmnx/K2K5IzpF6DmI4aQZwYn5jashv9nqdp7sJd0FY/nSifJ937t+lpL0c3sm+
 OSl0Kwbd4xA+fwADrTW7W0pWPhAMD1Jg==
X-Received: by 2002:a05:600c:4f47:b0:426:61fc:fc1a with SMTP id
 5b1f17b1804b1-427dc515d17mr39079015e9.3.1721607534331; 
 Sun, 21 Jul 2024 17:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8YZfFWpbcRoIDZgme7S2NZqWIXHvsojUm7n30zBxqgzXwin+UhnslKPiLHokD4BBbvolMag==
X-Received: by 2002:a05:600c:4f47:b0:426:61fc:fc1a with SMTP id
 5b1f17b1804b1-427dc515d17mr39078835e9.3.1721607533662; 
 Sun, 21 Jul 2024 17:18:53 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2927e21sm83115235e9.0.2024.07.21.17.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:53 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 57/63] tests/acpi: Add empty ACPI data files for RISC-V
Message-ID: <ffef157913bb7d456d89f48396fcfc7157efecc6.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


