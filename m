Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1351EC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8my-0005Lg-3H; Wed, 03 Jul 2024 18:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ms-0004ou-9g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mh-0005jI-BW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qq6X3kMK8U5RTSY4JoCXP6cD3LHFaX4iQOeFqnwxYP8=;
 b=dfBQV6p845Sxk+L00Ag7hBM4ygLxVzyK9VJR6oe96Jpy6DjMn65wMEo8jZJH+S8sb2kNHz
 2Jho2K8AJanxilDPvtqhluuTlpwJIiZ8cOQ/BPYpXxjwZu8XBlc5yPJpStCcDyys8O5gJd
 ma02KLOkCO9wzvIHygzm3YN3G4d1vv0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-eDJGmhNYNCGuaVCEWCgtwg-1; Wed, 03 Jul 2024 18:49:04 -0400
X-MC-Unique: eDJGmhNYNCGuaVCEWCgtwg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36794ef4815so33833f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046942; x=1720651742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq6X3kMK8U5RTSY4JoCXP6cD3LHFaX4iQOeFqnwxYP8=;
 b=kXszI61jxEiF/eE6n7kkhDZtbyeD/lGFw1c9xtvHBS3tGUyf0qgd8fgx5Gs5GdJf0E
 FWHN4AAOIhOMVnvCiMomPAOUDyB5c4sGKi9bWT6AxKquby7CWmjv1BjQHGkG2rYbyO7W
 EoLZgrLxzKqrVeIfiv2XY2QtnCnPsy/GiSw4vsV5/K5O0THYbkRv47pAPxD0LTbc8D92
 LftY0Y2NjlTzoF48Od2gIEN4rGWEh1PY5FQjRmlZf0GXnzkKvI556UHoS8Xv6GXtQMB8
 ieYwPbx/zgVvKS8wA+Zedrn/dzS2dkvvAWbGArMqjAKOtAf/3xyrQg35sBTLCN1QxIJ+
 U31A==
X-Gm-Message-State: AOJu0Yy6IzQ7Ms+04dSpif0dVUkEMLKK01cjBuG7mf8kF3/xk2Tkycx0
 MJy74XylFKipw8YsNcFfYQrkJP7iOH/y6gJJ1AR+xnt4ztNzfBqEzdel3jNioPlLn6QmF9R/KsH
 gOG10toUqYG22iBA4Kt8r8V1Vcg+hQayP2xBSNdhk17cKyb1AdZe+ugTPwe4XV6acK3cSiP49Cp
 ls4zHSCdrxw2KAkki0APE7FzhVi/07xA==
X-Received: by 2002:a5d:634b:0:b0:367:40e6:46bd with SMTP id
 ffacd0b85a97d-3679dd73dd5mr3268f8f.61.1720046942680; 
 Wed, 03 Jul 2024 15:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwNgm45H9+37MtlccIZDiJAMzaIGI9WslSjpYndIx3Pphid0K6fLJy+PomiNZpDtDL2fpBEA==
X-Received: by 2002:a5d:634b:0:b0:367:40e6:46bd with SMTP id
 ffacd0b85a97d-3679dd73dd5mr3258f8f.61.1720046942114; 
 Wed, 03 Jul 2024 15:49:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10337csm16824378f8f.97.2024.07.03.15.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:01 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 60/85] uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
Message-ID: <b05ff4086f79cdc59c4adcfd278259792a8bb714.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


