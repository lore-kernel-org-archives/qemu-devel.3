Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05050C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t97-0005uK-53; Mon, 06 May 2024 03:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8n-0005o4-Vr
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8m-0001dV-If
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tpj0GLKdyQenhxApFtKcWrPJj8IHK+zOooWEIXzunbA=;
 b=Z4OJxBz1zDzbQEtph0v6gR6+orTCHZIYs3q5/Rb8ZPBWc/ENZk/LBPvy76QwY5fAzvDT1R
 XCFUul6U1lJOZ1K+AZRkTU8e0od+6/GvM+Z7qk94N9XucNiedw/G44juh29XlaqIi8JAYI
 KPKGBSM+6CkQ+le0wndfxq6yLqIe2I8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-HpUuD6daOaSMRGMGtyowxQ-1; Mon, 06 May 2024 03:52:02 -0400
X-MC-Unique: HpUuD6daOaSMRGMGtyowxQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59cbb6f266so53706266b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981920; x=1715586720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tpj0GLKdyQenhxApFtKcWrPJj8IHK+zOooWEIXzunbA=;
 b=j0fFHCkMXpKK3Gvsf4xLaGS5k560BiaDGvlOedGGMIga9sfopSwB7Mv8KC3wpn2Sju
 DxcrHEanjKBSSb/koDAi9CQaKo/7b2oLQCj4fzYvyTMfoMebsH7tMETpqXzEqkn5S8ey
 gsqwlwRZtaanoskJCNYNHj/1GRSLn4uOPowiVU00U/Na+Cx3Wfgl8h6NUVnvQjgODRFH
 FnlsN1/0fCvfFtmvJr+ZGdGlpyHTVKLDvrmRghs+7G6dcpxKU+MpSRywwbhzEAMuRlZ9
 4N6RxUzjoOqJkr/RTOc1WfBttaBY1yXaL3WbLY12pjlYWE9pLcfWmI9bq0nVwSewHScO
 JUJA==
X-Gm-Message-State: AOJu0YzFjHCieei++Y42EhKytJ2dOpjuiXzsLWh+RWEWkmbVh+OLKqq1
 X1nRufQxmvG9utqhseX3LfPMlNMmU5jcokKaogwl5L1hiFcwn3DrosfoV3eU/V5e44LSV32QUBT
 WWObAib4bNq8BOkJ3tPJxsr+Ikdf604gZUvMpe8COIFQdj9VxMwhT0q7LW/21LS9trTe2Rws0ih
 lai2mpqYXndx9Xkq6QCBNR/LE7nMlbAtiypuDb
X-Received: by 2002:a17:906:ddb:b0:a59:bfd6:bf2c with SMTP id
 p27-20020a1709060ddb00b00a59bfd6bf2cmr3833946eji.7.1714981920571; 
 Mon, 06 May 2024 00:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJxDIuqJSJw5yF5zNogglTpt690fUknOLHcXwCcv6f48mWw6z+EOdKZVnWAr3Vyha4KVVaHQ==
X-Received: by 2002:a17:906:ddb:b0:a59:bfd6:bf2c with SMTP id
 p27-20020a1709060ddb00b00a59bfd6bf2cmr3833926eji.7.1714981920211; 
 Mon, 06 May 2024 00:52:00 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fy20-20020a170906b7d400b00a59ac65a13csm2546977ejb.179.2024.05.06.00.51.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/46] loongarch: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:52 +0200
Message-ID: <20240506075125.8238-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Continue with Loongarch.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/loongarch64-softmmu/default.mak | 3 ++-
 .gitlab-ci.d/buildtest.yml                      | 4 ++--
 hw/loongarch/Kconfig                            | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/configs/devices/loongarch64-softmmu/default.mak b/configs/devices/loongarch64-softmmu/default.mak
index 0893112b81d..ffe705836fd 100644
--- a/configs/devices/loongarch64-softmmu/default.mak
+++ b/configs/devices/loongarch64-softmmu/default.mak
@@ -3,4 +3,5 @@
 # Uncomment the following lines to disable these optional devices:
 # CONFIG_PCI_DEVICES=n
 
-CONFIG_LOONGARCH_VIRT=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_LOONGARCH_VIRT=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 75222c4450b..a82848ba55b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -648,8 +648,8 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm, i386, x86_64
-# does not build without boards: i386, x86_64
+# requires libfdt: aarch64, arm, i386, loongarch64, x86_64
+# does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 5727efed6d8..78640505630 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -1,5 +1,7 @@
 config LOONGARCH_VIRT
     bool
+    default y
+    depends on LOONGARCH64
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
     imply VIRTIO_VGA
-- 
2.44.0


