Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E937C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9d-0007J2-9r; Mon, 06 May 2024 03:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t99-0005wH-3d
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t97-0001hb-K0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66X98Fkv+2DNq3mOuHqUSiSO+Feayago3MqQ7S1J/PY=;
 b=WmTlu49LBAPHvnbtJdWs3Rfv5XdRwMEilVQpTa/VP30D3HhIr1fNRt5Bk3kyyyur0MDLVw
 GWO7oj5Ck5BYRYkqJCLQDY/ZhirL/hGTGHtHeNv65QuAiX6Abq6FAESFVwstnsaKLFc1JX
 VLnUWEQINdAbMWjYL6CBPN2c+QblzlY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-V6CvMinlOs2ZxTL4wjFE_A-1; Mon, 06 May 2024 03:52:23 -0400
X-MC-Unique: V6CvMinlOs2ZxTL4wjFE_A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572eea3758dso935880a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981942; x=1715586742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66X98Fkv+2DNq3mOuHqUSiSO+Feayago3MqQ7S1J/PY=;
 b=d88EwfzMkdkHd84WUxS0z4AHOcnkn2AMTzQ0N+1Y0ZhddILseQwTtEbGqvcCGTEJgW
 kIioqpKLr1uwpGiWjKT4UVnQVRYaTIEG/0CqjxXUnGUSnxQmCjCW1qHtJq8PLWmOU1RC
 I7zShgWNp7/1L2+uRlU+7KAZhQnHSoF8RyduOKAyAsnM580IrhwSXQL7d/srk54OOtGt
 uRqYqMA/cO/OKTu6P2+d9htc3cKWDYTf6pj/NnDDPS3z69Jmkdm2Qyjw/3rMkbc3W7cq
 pbp/agPL97ypSfMcPHKtArfmjQrePcwFpcTQHMoh24RP4/wZurwhnX5wgjfwYHsyDPRC
 67nA==
X-Gm-Message-State: AOJu0YwvIDFKdiGyJKFBeo8foEiNjk8dnkk+Mx09tqQCEgVQd8+UxY07
 fSTNR0EAN8/1wE4POgoFPNs5xfaLxWAA+yzicN5QlvNmJYBgBclO7FVwf06DLiv8+tziLGaV0y6
 GCddrycTWhQxdxQxwn7BFdeHg5Oy+R2cLn4dIxdJrazetu5v5t/k32Z4maA7X2ZGQsCYPLcgaaL
 rG2Zi8r/tQJGPMrSkSgSlD3L6c81qlRyUkZ/sl
X-Received: by 2002:a50:9fc8:0:b0:572:99fa:1095 with SMTP id
 c66-20020a509fc8000000b0057299fa1095mr10999403edf.18.1714981942091; 
 Mon, 06 May 2024 00:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOFGA3FNCajSih961nc6YZepATIQrc5dWE0+w+MZYGZkDCxulIl5yHMgttl7zU+E2OElihig==
X-Received: by 2002:a50:9fc8:0:b0:572:99fa:1095 with SMTP id
 c66-20020a509fc8000000b0057299fa1095mr10999386edf.18.1714981941663; 
 Mon, 06 May 2024 00:52:21 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa7d541000000b00572eebbfc61sm1926215edr.35.2024.05.06.00.52.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/46] s390x: switch boards to "default y"
Date: Mon,  6 May 2024 09:51:01 +0200
Message-ID: <20240506075125.8238-23-pbonzini@redhat.com>
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
Continue with s390.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/s390x-softmmu/default.mak | 5 ++---
 .gitlab-ci.d/buildtest.yml                | 4 ++--
 hw/s390x/Kconfig                          | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
index 6d87bc8b4b0..340c1092922 100644
--- a/configs/devices/s390x-softmmu/default.mak
+++ b/configs/devices/s390x-softmmu/default.mak
@@ -9,6 +9,5 @@
 #CONFIG_WDT_DIAG288=n
 #CONFIG_PCIE_DEVICES=n
 
-# Boards:
-#
-CONFIG_S390_CCW_VIRTIO=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_S390_CCW_VIRTIO=n
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 13f505f20d7..2475262c5c8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, loongarch64, x86_64
+# does not build without boards: i386, loongarch64, s390x, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -666,7 +666,7 @@ build-without-defaults:
       --disable-strip
     TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
       mips-softmmu mips64-softmmu mipsel-softmmu
-      s390x-softmmu sh4-softmmu
+      sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 26ad1044858..3bbf4ae56e4 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -1,5 +1,7 @@
 config S390_CCW_VIRTIO
     bool
+    default y
+    depends on S390X
     imply VIRTIO_PCI
     imply TERMINAL3270
     imply VFIO_AP
-- 
2.44.0


