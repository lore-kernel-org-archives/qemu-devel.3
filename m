Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD838C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjye-0001Y2-VP; Tue, 02 Jul 2024 16:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyc-0001Va-RF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyZ-0001HW-WC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZlKbjCfDnCk5ojJHJFE0MXkNQoHYTrUaZpWkcL5Y50=;
 b=AFRFKC/ArTrGpswTMHc9YdFEF1PAoNl8a2j23rM0hU404O7fRatnyWiuy/7A97IFd1TPGQ
 ifEG8ELb/JBxMm6qcyFBIub+1VWJkCy7DiMxCbBA4iGqTbnjxrWFoJcG9VeIQp97xiC7nv
 BDvKjLKBIu3WfgvDP989w83Q5/IWrWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-CIn8BuSPPYqYWcMTzV1YPw-1; Tue, 02 Jul 2024 16:19:37 -0400
X-MC-Unique: CIn8BuSPPYqYWcMTzV1YPw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257dd7d594so17727005e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951576; x=1720556376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZlKbjCfDnCk5ojJHJFE0MXkNQoHYTrUaZpWkcL5Y50=;
 b=rs3XHKgAisOj9zOoBVuMtJrPXtQYA8K8ZF4SEivu1W73tvlUTNY5/dq6Ys/U6imzqJ
 TxuJHJu63C4b4kZRionB4nzL64gCSfqUbDx8NjAPmouRZ76S51l8BHyQqaasFALjoiGN
 qUMa7hfoTuVqjhyyla4Y7cyCfELnaGeXJFslBmDzr7OXg4461Q03GbXHYyvvGbRDXolP
 a2cTS/PInASXt+Uz1eyGwV1Q2+UCJdBy2grgjaRSLHm4CinEynnspWpCwQKT/MR70I/N
 hU01SQ7QWJEbe9pd5oAPuf1OLX1sP206qav1y8jLQkh4CZmxyiVqqfSyj6pFn4SvbIC3
 7Y0A==
X-Gm-Message-State: AOJu0YwbWQt1Un8omBKwtIXMxBjHZu/13WuEWMXh8RQMeGkM1Mf0X+4Q
 n96/XjJBwfzSdCQ8whfHut/8NF4OWnDO+Q+hu+wi8Attg7rte07UvaxAWZgoZQVy1DOgCGY9noJ
 mchbYXjgFHc5vmMUuK99txBAcaK8rbVqEYFSD0dV9UVgyaWgMl1yY+UFTajo25wKxHOCgltN/z1
 IKxPES9N/eT5JCwWkAF6V6A76hucGNVQ==
X-Received: by 2002:a05:600c:4da1:b0:424:a516:13f8 with SMTP id
 5b1f17b1804b1-4257a06d4efmr62282405e9.35.1719951575939; 
 Tue, 02 Jul 2024 13:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6IoL6deH5h8/m6I8EUjnOBtaL+jji9FxD/KUH5gsl/MmTN0UBp9qDIqLuJph+5eQYtF3AmQ==
X-Received: by 2002:a05:600c:4da1:b0:424:a516:13f8 with SMTP id
 5b1f17b1804b1-4257a06d4efmr62282135e9.35.1719951575064; 
 Tue, 02 Jul 2024 13:19:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f1bsm207481805e9.44.2024.07.02.13.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:34 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 65/88] tests/data/uefi-boot-images: Add RISC-V ISO image
Message-ID: <526845b8593181c4a56f3baeaabc5bc3f742e569.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=2.5, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

To test ACPI tables, edk2 needs to be booted with a disk image having
EFI partition. This image is created using UefiTestToolsPkg.

The image is generated using tests/uefi-test-tools source.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Message-Id: <20240625150839.1358279-5-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 .../bios-tables-test.riscv64.iso.qcow2          | Bin 0 -> 16896 bytes
 tests/uefi-test-tools/uefi-test-build.config    |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2

diff --git a/tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2 b/tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..c720bf99a45fab6d1e21963cca563ee0ea059b82
GIT binary patch
literal 16896
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

literal 0
HcmV?d00001

diff --git a/tests/uefi-test-tools/uefi-test-build.config b/tests/uefi-test-tools/uefi-test-build.config
index 1f389ae541..a4c61fc97a 100644
--- a/tests/uefi-test-tools/uefi-test-build.config
+++ b/tests/uefi-test-tools/uefi-test-build.config
@@ -24,7 +24,7 @@ cpy1 = AARCH64/BiosTablesTest.efi  bios-tables-test.aarch64.efi
 ####################################################################################
 # riscv64
 
-[build.riscv]
+[build.riscv64]
 conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
 plat = UefiTestTools
 dest = ./Build
-- 
MST


