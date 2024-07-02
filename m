Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AF2C3271F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyR-0001Bo-OJ; Tue, 02 Jul 2024 16:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyP-00014m-FJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyN-0001GG-Ny
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qq6X3kMK8U5RTSY4JoCXP6cD3LHFaX4iQOeFqnwxYP8=;
 b=Y0cQ2Q0gHjrblaPJM2gA+lMTLoW7oCVFtBt38/R4B49pw1X96aLdcytc06nr4ERKw5k8C0
 hKeCZXYSSAqqHWtHVSIGQkbiJi4NFRvTuCc0A3l6PG2KD7/PVIQSgJ1nKdRidPb+eeTyFG
 3MCBIsNylMdtypG+jojuI6yJb2SdgyU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-4M4iWmEiPauShBcCxZNI0g-1; Tue, 02 Jul 2024 16:19:30 -0400
X-MC-Unique: 4M4iWmEiPauShBcCxZNI0g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36789dfcc8bso468728f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951568; x=1720556368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq6X3kMK8U5RTSY4JoCXP6cD3LHFaX4iQOeFqnwxYP8=;
 b=Mz4AeP17fF+n4s4HJ3igQfHC5R9iNwwmnUFtqTfbSbSCldx5duLubXWUj/rwckCrQI
 FHBT29F+nxwA/G15CasYOEqv1QGH7e2VjACSnR7kWxTrENHa6IUNOgi/diQsgZ/SXDVo
 rscxRI8RtKQl6EVEizvG8BonyddqqrNItzcFWvb1Xx9bzIdsR52gitF+FFiRbb1NpGzr
 Dpzu1N/DxJmNrOE9N4UTE6vUu2QM/zIUzA5dLsLoMnTdzJb0RPw8LzuRYDUM5MHNuf+C
 7Z+6ihSFfXui/SnMc27RFph+oHSh5Ns76PAucu2OCm7LRxtLGSJR5/NvW/p655CEOn3H
 pLqg==
X-Gm-Message-State: AOJu0YyAb505oQSIUmbGkbUZ+54H6r1e9SuV5N92fzFPTZL/Kk6qRQcx
 C15JMmX3VDvvwK7ZQnGk0bNaScdNFaVYQJNiqIfbfz+Es3+qos1tkBKkB+uPTjzReuVYM8Z7EPR
 A+NIGVD1zArYuGZJqX2F03z5Bgdvd01j1xAmFEaZTmqNzSm4qEXX3lbfe747M6u0fXqwVVDXdCK
 DtBwrIHW5jtlTBpKYMC2j/B9ELZv3QzQ==
X-Received: by 2002:a5d:630f:0:b0:362:41a4:974d with SMTP id
 ffacd0b85a97d-3677571b76bmr8009513f8f.46.1719951568165; 
 Tue, 02 Jul 2024 13:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB42dNu53o5DjJc92/1GCxsGCuDGgRA/SYa/1ezxStI7rHPI61/G2dSAkjuCM1KJG0cEcleg==
X-Received: by 2002:a5d:630f:0:b0:362:41a4:974d with SMTP id
 ffacd0b85a97d-3677571b76bmr8009498f8f.46.1719951567582; 
 Tue, 02 Jul 2024 13:19:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103366sm14034500f8f.102.2024.07.02.13.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:27 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 63/88] uefi-test-tools/UefiTestToolsPkg: Add RISC-V support
Message-ID: <e50a460b64a8d311676b46b71f6891d55036cf94.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


