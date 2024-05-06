Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C204C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9N-0006Qz-Ku; Mon, 06 May 2024 03:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8u-0005pj-37
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8r-0001e3-FX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cP3nWL94R08Eo67ZV+TaTc1CdPSmPODit+By5QzQoEE=;
 b=gUZ1DGigP0OlyS0Awr0xNNZvvrt9ZbqcEyHlTKfM5/9JiBt9r+M2Af2+s74xwq2JiE5C+Z
 fwAYuf7B5oG4yAZwR1WQkPXnGarQLbo8/NoKMaYv5EgHQgZqII1MQ8Gzo8lWVi9wiSDsX5
 Eh4p40Nz6DSLgoLVGemketaFfnVAx6k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-MMSJi--VOT-puKbRGEWYxQ-1; Mon, 06 May 2024 03:52:06 -0400
X-MC-Unique: MMSJi--VOT-puKbRGEWYxQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572ba1df326so501289a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981925; x=1715586725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cP3nWL94R08Eo67ZV+TaTc1CdPSmPODit+By5QzQoEE=;
 b=p4DoxWE2zqHK0tbXLDlR5OLWxOPqMvZYCHeguYqDnVlFEk+3KI4MRL5F/vZUNaRAUV
 KtbC4w9yssUA3eeaKJ2NQkf4dHSg0e6Glx475f3u3Exj50pXtvAyhypm3S0f28/DChSP
 3zvtURKGDjvaTS4k5vWGGCBwdtti23jWsG2h7PqKMzhJgSxEKwl0YrNmnMEDYoOvuwYO
 7eqWqI6ab7j1NQP+HUAbG49861Nu8GGW/O6ITiTsCGxjm2HqEmJOQzLTwsL/zrLYix6j
 fcV6U7UdjoOaGnZvi2DgiGNUaIKTsFcf5tPK8snXsQ+7sttMFhxiqPad6piTn7XQ6BOS
 a7/w==
X-Gm-Message-State: AOJu0YwAqkR4cfIkq6Brb+cMLKAiPlfd7Dr2kkzSXAEfNaPM8O60HZah
 i04TqIq1Fqp0z+Cdna7eVlqnrWrxjK8RwepynPlqBqKXerjMHFLwKdv9rcqJHtJIQxarAT/RoGG
 JXg4PA9nNhc6mNRDmPrWuU0DaOG7+etdGOZkOmqZdCrirTZw35h3D06DOmuCfPJH6yTShTHbJfg
 c7gc9FyaKhp20yQsWi+A6brh3XEQNA0O9zjRSm
X-Received: by 2002:a50:8a96:0:b0:572:65d3:803c with SMTP id
 j22-20020a508a96000000b0057265d3803cmr7680805edj.0.1714981925306; 
 Mon, 06 May 2024 00:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy9p1zDeCaFNCPq87ATV8ryWATOXqbWc8CoJP6jDYnU7Gokxn6w26XZyA7AtCA+hqDVtPWHg==
X-Received: by 2002:a50:8a96:0:b0:572:65d3:803c with SMTP id
 j22-20020a508a96000000b0057265d3803cmr7680790edj.0.1714981924903; 
 Mon, 06 May 2024 00:52:04 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ze15-20020a170906ef8f00b00a59ae3efb03sm2425669ejb.3.2024.05.06.00.52.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/46] microblaze: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:54 +0200
Message-ID: <20240506075125.8238-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with Microblaze.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/microblaze-softmmu/default.mak | 9 ++++-----
 .gitlab-ci.d/buildtest.yml                     | 3 ++-
 hw/microblaze/Kconfig                          | 6 ++++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/configs/devices/microblaze-softmmu/default.mak b/configs/devices/microblaze-softmmu/default.mak
index db8c6e4bba3..583e3959bb7 100644
--- a/configs/devices/microblaze-softmmu/default.mak
+++ b/configs/devices/microblaze-softmmu/default.mak
@@ -1,7 +1,6 @@
 # Default configuration for microblaze-softmmu
 
-# Boards:
-#
-CONFIG_PETALOGIX_S3ADSP1800=y
-CONFIG_PETALOGIX_ML605=y
-CONFIG_XLNX_ZYNQMP_PMU=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_PETALOGIX_S3ADSP1800=n
+# CONFIG_PETALOGIX_ML605=n
+# CONFIG_XLNX_ZYNQMP_PMU=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a91e8d359d5..e2e92f25c58 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,7 +648,8 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm, i386, loongarch64, x86_64
+# requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
+#   x86_64
 # does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index e2697ced9cc..d78ba843fac 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -1,5 +1,7 @@
 config PETALOGIX_S3ADSP1800
     bool
+    default y
+    depends on MICROBLAZE
     select PFLASH_CFI01
     select XILINX
     select XILINX_AXI
@@ -8,6 +10,8 @@ config PETALOGIX_S3ADSP1800
 
 config PETALOGIX_ML605
     bool
+    default y
+    depends on MICROBLAZE
     select PFLASH_CFI01
     select SERIAL
     select SSI_M25P80
@@ -18,4 +22,6 @@ config PETALOGIX_ML605
 
 config XLNX_ZYNQMP_PMU
     bool
+    default y
+    depends on MICROBLAZE
     select XLNX_ZYNQMP
-- 
2.44.0


