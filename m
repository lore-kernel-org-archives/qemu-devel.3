Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D651BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t98-0005vU-4p; Mon, 06 May 2024 03:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t90-0005rZ-7Z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8y-0001fJ-QA
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lqW75R0kfx7mTOUqcSRaHg3gZohk47UGz1fTQcjeIM=;
 b=TIq7txPVaiOab6BQqhtyeBDTEnMKEz+aCy1wgF+QFNoscmqYABRdn1XobC+a//U30mOLtN
 JUOUpZ12/DKp/XH5r+Niz4bNYZZz6IcoFgrTdLPEcjqKlVlncDmGjBkCZHbN7+PthUEQny
 5qcci2ZjmIib9UG2/rBOsxFJ5ZiVhq4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-1bxTInLcPbOekdHWk8VG7w-1; Mon, 06 May 2024 03:52:14 -0400
X-MC-Unique: 1bxTInLcPbOekdHWk8VG7w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5729ec37366so846500a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981932; x=1715586732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lqW75R0kfx7mTOUqcSRaHg3gZohk47UGz1fTQcjeIM=;
 b=EM0rDf8uX8CLZL4gYUr4tgbyEqU0j5i8Xg1Mk8AL+pqw/+ZPVFv/WGK/FGk3fiTdvu
 W8XflfcqHPwxQs03y2A0eVn0I9Q2J/QfrLffzFeVilwwsw1/6Bv7WQg7Hw8jka57f/2j
 U+leMhccW2LPGvmOtJtxECbo64f/nlYpXrljsHyjsMRUwFPik3NQz1rZzPaAnybb/Usw
 zN21tfBGUq+ZJrdqE2dFQlJHuhPIQrxrMtnZLCC71fSw3/cVcBnCUGHjERilrMWRWi5E
 baWA0gIuEEYydxFE2cZRf+48daaXzO+xKz1j3gqLWeIG/z52Mi3CcFoRtYETimAizEWe
 FkRQ==
X-Gm-Message-State: AOJu0Yzs5BNjbMdzE01VyZaPQXk1cr5LjXRNCR81PtbVqu+VMw5rvfcc
 i0jPz2QUr1Z+5yqslQNXbs5W8kF0JFEVnfDapp9OC3R5anEeK1P8i4QwIFJsrZZQ/tRa2pvfITy
 sIWT8962JnIvCZpF3oDHbopGdxyUyICJphU/or30XUmutXOugTHRCDTxpWRxVVKzUA396KtPVGp
 sDQbWK0jLOgEAy9k2S01EcF8G+XWynxgFI/eRy
X-Received: by 2002:a50:d69a:0:b0:56e:5735:db2b with SMTP id
 r26-20020a50d69a000000b0056e5735db2bmr6619427edi.29.1714981932567; 
 Mon, 06 May 2024 00:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdZGwzDz0rMx1uOrDSEGgnwPZ7uVHbH46UET/dGuuoEL4DXdyTPbzk23sappGmawUR7QlPYQ==
X-Received: by 2002:a50:d69a:0:b0:56e:5735:db2b with SMTP id
 r26-20020a50d69a000000b0056e5735db2bmr6619419edi.29.1714981932202; 
 Mon, 06 May 2024 00:52:12 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a50c34c000000b00572459a4ffesm5074877edb.56.2024.05.06.00.52.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/46] openrisc: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:57 +0200
Message-ID: <20240506075125.8238-19-pbonzini@redhat.com>
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
Continue with OpenRISC.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/or1k-softmmu/default.mak | 5 ++---
 .gitlab-ci.d/buildtest.yml               | 2 +-
 hw/openrisc/Kconfig                      | 4 ++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/configs/devices/or1k-softmmu/default.mak b/configs/devices/or1k-softmmu/default.mak
index 3aecdf9d738..efe3bc278bc 100644
--- a/configs/devices/or1k-softmmu/default.mak
+++ b/configs/devices/or1k-softmmu/default.mak
@@ -5,6 +5,5 @@
 # CONFIG_TEST_DEVICES=n
 
 # Boards:
-#
-CONFIG_OR1K_SIM=y
-CONFIG_OR1K_VIRT=y
+# CONFIG_OR1K_SIM=n
+# CONFIG_OR1K_VIRT=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 811132443a7..49cd50c354d 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -649,7 +649,7 @@ build-tci:
 
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
-#   mips64el, x86_64
+#   mips64el, or1k, x86_64
 # does not build without boards: i386, loongarch64, x86_64
 build-without-defaults:
   extends: .native_build_job_template
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 97af258b556..9c9015e0a5d 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -1,5 +1,7 @@
 config OR1K_SIM
     bool
+    default y
+    depends on OPENRISC
     select SERIAL
     select OPENCORES_ETH
     select OMPIC
@@ -7,6 +9,8 @@ config OR1K_SIM
 
 config OR1K_VIRT
     bool
+    default y
+    depends on OPENRISC
     imply PCI_DEVICES
     imply VIRTIO_VGA
     imply TEST_DEVICES
-- 
2.44.0


