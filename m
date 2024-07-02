Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4D0C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeDI-0004bd-2u; Tue, 02 Jul 2024 10:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDD-0004A7-IW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeD8-0000J0-36
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qq6X3kMK8U5RTSY4JoCXP6cD3LHFaX4iQOeFqnwxYP8=;
 b=AD+Jn+39gteK/SPWlHoM8YBFCH3XwpGf1BMTYSsq4Y2w/ek5GSmtiqWPZGOoJnWF/X/pEz
 XK506Dr6qbhUs1CnOj8RwsQnnT+DJ5ABASTIogbb+X9NKVHNMroKpsq6hHvl1GbBQLL7ma
 SfG+QYKlQdnBYUykT5DACW0dfC8/NKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-ywZo8X4QMFSRI91soVd6MA-1; Tue, 02 Jul 2024 10:10:18 -0400
X-MC-Unique: ywZo8X4QMFSRI91soVd6MA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256667ebf9so29787045e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929417; x=1720534217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq6X3kMK8U5RTSY4JoCXP6cD3LHFaX4iQOeFqnwxYP8=;
 b=H/ICMbOavj+fgFnpSFL1uMOA/d8PfiUtDSaZUd3+JN7V1ZA+X9KtcAHxceIBkRPJp2
 pVIQlOmjT3zZXu6RxME1CdUfEnszQOemAnhPm7r9azPSL0m1b84neHeAUL9zD6eabgwk
 q+Bev1lAW52BimyRr3cJyXKYrttkXmBzS2/KOvcn2cJPULLhfWYfi5azwB6GSwY2RJUV
 yXoIXT+xiL9PKfPlnmcofPOasTMhAQyW8Xe/9vOGYfHFbBaJ9Gz0nZFtuCKzPmwlIqYR
 34qQRUgqLiqAnU65Ndg6Lxs1Yk/eJDGRBzskafLNZsYtZ487+9TgMje4ot7gEMzdjVD9
 XVmQ==
X-Gm-Message-State: AOJu0Yyqs9/qDQQtmlQMNvQiprTZAbX92MEZgrvIhR+lEGH2Ehcl6Dri
 B5Mzn0ZtWJ5eK0hY5ittdHS2HHEE/5h2gwzcH2EPXyxdeMtfGRp7fMHyjNb/Zd87tSN2m0GckqA
 3w1RX5J5aW7w4pX6o6N9e5WQb9R8KC3fiZWRKTkg4vkZ2oq45hwxJuhXaK64NLukC7fmNNoqik8
 56ow9/ufEg0n64L17MvjPTabADEvkJ7A==
X-Received: by 2002:a05:600c:4f94:b0:425:7c46:d336 with SMTP id
 5b1f17b1804b1-4257c46d499mr54231075e9.17.1719929417089; 
 Tue, 02 Jul 2024 07:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFySsgJqXcJ79POgmKrIbdLl8PEOmX4fONoo6vKU///699K/Pk4odKCdhbUbT93ZVyLZ+bPAg==
X-Received: by 2002:a05:600c:4f94:b0:425:7c46:d336 with SMTP id
 5b1f17b1804b1-4257c46d499mr54230735e9.17.1719929416515; 
 Tue, 02 Jul 2024 07:10:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba0bsm13305727f8f.69.2024.07.02.07.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:16 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 63/91] uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
Message-ID: <492ce19c7be7fd2a36550420a27d646ed6af74e2.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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

Enable building the test application for RISC-V with appropriate
dependencies updated.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-3-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
index c8511cd732..0902fd3c73 100644
--- a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
@@ -19,7 +19,7 @@
   PLATFORM_VERSION        = 0.1
   PLATFORM_NAME           = UefiTestTools
   SKUID_IDENTIFIER        = DEFAULT
-  SUPPORTED_ARCHITECTURES = ARM|AARCH64|IA32|X64
+  SUPPORTED_ARCHITECTURES = ARM|AARCH64|IA32|X64|RISCV64
   BUILD_TARGETS           = DEBUG
 
 [BuildOptions.IA32]
@@ -60,6 +60,10 @@
 
 [LibraryClasses.IA32, LibraryClasses.X64]
   BaseMemoryLib|MdePkg/Library/BaseMemoryLibRepStr/BaseMemoryLibRepStr.inf
+  RegisterFilterLib|MdePkg/Library/RegisterFilterLibNull/RegisterFilterLibNull.inf
+
+[LibraryClasses.RISCV64]
+  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
 
 [PcdsFixedAtBuild]
   gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x8040004F
-- 
MST


