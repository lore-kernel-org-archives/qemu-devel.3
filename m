Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B96EC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9f-0007Rg-5T; Mon, 06 May 2024 03:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9C-0005yN-6o
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t97-0001hP-2f
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1J72qMEdQMNMOsNvSGFzl7NaeouKzIePtfnpA/e1t8=;
 b=HOD1G6CwkNpHRW8zIaD/5eCTKcPUvtVDgKVFNBvwsYNpst2vJ45VSVfkdFFKDIUMYxwNnP
 IAg6dbrIDgVApNH4EbJW9svAIEfqVWuP64mNH3TWluqzHyi6G/qzRcjMxOndpCIIbqSMrm
 ICbH281Wfz1txQzL3UBSVRrO6dFVCqM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-aIU9EAT8MLm-0i-r2qSsoA-1; Mon, 06 May 2024 03:52:21 -0400
X-MC-Unique: aIU9EAT8MLm-0i-r2qSsoA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c02f798bso98270566b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981940; x=1715586740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1J72qMEdQMNMOsNvSGFzl7NaeouKzIePtfnpA/e1t8=;
 b=RK/aAzx6J6B36N++wbB1595GEWQei+yftIsFutUvcxj5Mx0EaTPmaJ5WnMIqAwKFpF
 Zc1Sg0W8ve25Gf1wx9YsexYNUKvBwTWCqa05u5Zqplykc6U3562ajpFg5jZS2kbEhhlW
 uQzZW3xkxz/JRnOq4ok3MHF+pMHWzvE6RzLRm5FYCo3MyMvwLtP1tmSDdEFMFbIBoqAy
 fYFM05FrAsxlB4f86v+NDLaAeQfBpC//zCs+1HOWndC3zmKVJb3NzF220K2w6YBnm72J
 IFeBI0nYayqAdl0XJDoH8iGDqkNJtsQx+jhTrr8qytD8HNsRmuSWJ7Ad9gGMIwX2JhCV
 6/7w==
X-Gm-Message-State: AOJu0Yz1wLMnj6zHOhcWqc6vpcd/KFsrmBLKFQGpHJGNFZTZV/EbDurh
 ozl98qh52pv+RHHMusEP4iXktWfLtGbzXne3K1zs8/SdXpIiAttFSeGhgU+cbz21qfvod5Y18I6
 RfHkrpaK8PG6mOR0W2sY9J0n6H90+iDIZ+R9CEdTaQNXoaH4HrEsWW1UJod/E9Neyt7FwdS878a
 VGRL0BChiiAoxjEym+udzPF7HuuwbCsEQCFAfV
X-Received: by 2002:a50:99d2:0:b0:572:7d5b:9923 with SMTP id
 n18-20020a5099d2000000b005727d5b9923mr9403287edb.22.1714981939847; 
 Mon, 06 May 2024 00:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElELRl0i2e1EKL9cWolbHJ180GBGraOlT1Y1DMnSzXMzyoVUewmcC+h2oSAEuN4vaK7eE0lQ==
X-Received: by 2002:a50:99d2:0:b0:572:7d5b:9923 with SMTP id
 n18-20020a5099d2000000b005727d5b9923mr9403268edb.22.1714981939421; 
 Mon, 06 May 2024 00:52:19 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 u9-20020aa7d989000000b0057030326144sm4884702eds.47.2024.05.06.00.52.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/46] rx: switch boards to "default y"
Date: Mon,  6 May 2024 09:51:00 +0200
Message-ID: <20240506075125.8238-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with RX.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/rx-softmmu/default.mak | 3 ++-
 .gitlab-ci.d/buildtest.yml             | 2 +-
 hw/rx/Kconfig                          | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configs/devices/rx-softmmu/default.mak b/configs/devices/rx-softmmu/default.mak
index df2b4e4f426..e7caebe1974 100644
--- a/configs/devices/rx-softmmu/default.mak
+++ b/configs/devices/rx-softmmu/default.mak
@@ -1,3 +1,4 @@
 # Default configuration for rx-softmmu
 
-CONFIG_RX_GDBSIM=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_RX_GDBSIM=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a65b5fc9560..13f505f20d7 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -649,7 +649,7 @@ build-tci:
 
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   mips64el, or1k, ppc, ppc64, riscv32, riscv64, x86_64
+#   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
 # does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index 2b297c5a6a6..b2fa2b7eec3 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -7,4 +7,6 @@ config RX62N_MCU
 
 config RX_GDBSIM
     bool
+    default y
+    depends on RX
     select RX62N_MCU
-- 
2.44.0


