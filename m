Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E2EC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfL-000169-Bv; Thu, 13 Feb 2025 11:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfH-000149-3B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfF-0005eF-8H
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gp7LPZ4z/UwRnFvmVqp2Msund5xUSnBQY80C+x5wKs=;
 b=gJqYcFx1nHrMkr/BzYwQ7caC2MyaASu8JTyg501Y6SefDpbHCV/T0fkV37Z4fSNsrQfLkV
 d8MgHTTEUxA7J4j0aB/cA8lz5Bndg/2v2dsvYoE/XvBMhjrN3Mx3C/JIDhlTeictQmlv0e
 rknbOiOCXu4ppFBL//xr6XF0sIUYs4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-yHDJQ3Y0OY6giGBMUUtQ8A-1; Thu, 13 Feb 2025 11:02:05 -0500
X-MC-Unique: yHDJQ3Y0OY6giGBMUUtQ8A-1
X-Mimecast-MFC-AGG-ID: yHDJQ3Y0OY6giGBMUUtQ8A
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso7823435e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462523; x=1740067323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gp7LPZ4z/UwRnFvmVqp2Msund5xUSnBQY80C+x5wKs=;
 b=mvEPBs4rcS5wlYbGgv4u8jTj98Sx3XTQz6lfu2sxs1Cnt0fJe8tmwU7nHV6IBEGrGP
 c7T7eo35mzBzFoFoEOTl0ppPAL0jBcVdk9bxlTBsErkDBkFFR9e9p9WztdxScZ3l50CQ
 Tj0arJe8z8wk2X8QB6BSd+VJg+tmAQXiOQkB7DWs8LH5th2jiNo9KTvmfeoOpoESDURK
 W5AdYS8IRJizUxBMES6ZCNiGD9GRPVFr9ienJ/Qf7f5nPRejO2KoCrq1zyY5avewGKS0
 lXxRmIZgRDG9/sh1l2J2sy/jxpWuKotL3ziTWlEFRZeSwmIPjk2KdJDodxwr8XeYVpxL
 +dEg==
X-Gm-Message-State: AOJu0YzYk8cA6S+n7Ww3EC9JN0QHzFBdIc86j3w6u+tUFznpqi4NIKVF
 MKXdsukC1iuTnbycGq3XzE+g1vWCXMPU5y73X9ChZbn4fsb5ZPDZMzevGivjqbEHpfer5x8qPOf
 NSu5QmmOxQ6mZ+L5eDQMN4WP/d9gg5M4AzMyWe/spEN/Xc4Nvntzve0xbuXDoxACQK6YFna73lv
 GrTyDdhG8U5gV2VSQRPH74AvjeqY5HEPl3d3iePmg=
X-Gm-Gg: ASbGncvmexV+FR+/gw8je3TumT/PSCo7hcnO9pG/2GcEPy+RTZ69+Q/Xzddq/ImJbgB
 GwHngGEK5OGyBaqRaX+eea8j+cA43Ow79GvyUwIOk0Yexoh5b8+2H2i1ab7qZ8T7QLrtB26gSgx
 2JXpQwuBfiwYN4pAc5Rk4Qd9H8TdujXqwgm/0+jO+cTqxuzs6f5jnzE/yldqU6LN20sEi6Lk8vh
 ktERWOp4qM8dif4rBRHq3aErXWwekBPEThNqA3WlFE1is9vaZ0V/wdNAkwt30Qky+96s+XGEgf/
 Me0pSaWYZz53troekQLUBBHyn+967cDdrGm3DkWEkGyd/w==
X-Received: by 2002:a05:600c:46c7:b0:439:35bb:a5eb with SMTP id
 5b1f17b1804b1-439581604d6mr85279095e9.4.1739462522528; 
 Thu, 13 Feb 2025 08:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFN2PdtHTwx8hF3F1lRnh6YMMkBV6sqm75V68yv3DjBOdEin5ZbzIpx7wuWzkR5mDbSxuoVw==
X-Received: by 2002:a05:600c:46c7:b0:439:35bb:a5eb with SMTP id
 5b1f17b1804b1-439581604d6mr85278345e9.4.1739462521908; 
 Thu, 13 Feb 2025 08:02:01 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5fb6sm2209597f8f.44.2025.02.13.08.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:02:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/27] i386: enable rust hpet for pc when rust is enabled
Date: Thu, 13 Feb 2025 17:00:50 +0100
Message-ID: <20250213160054.3937012-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Add HPET configuration in PC's Kconfig options, and select HPET device
(Rust version) if Rust is supported.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/i386-softmmu/default.mak | 1 +
 hw/i386/pc.c                             | 2 +-
 hw/timer/Kconfig                         | 2 +-
 rust/hw/Kconfig                          | 1 +
 rust/hw/timer/Kconfig                    | 2 ++
 tests/qtest/meson.build                  | 3 ++-
 6 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 rust/hw/timer/Kconfig

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 4faf2f0315e..9ef343cace0 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -6,6 +6,7 @@
 #CONFIG_APPLESMC=n
 #CONFIG_FDC=n
 #CONFIG_HPET=n
+#CONFIG_X_HPET_RUST=n
 #CONFIG_HYPERV=n
 #CONFIG_ISA_DEBUG=n
 #CONFIG_ISA_IPMI_BT=n
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0eb52d315bb..22641e6ddca 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1701,7 +1701,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
     pcms->max_fw_size = 8 * MiB;
-#ifdef CONFIG_HPET
+#if defined(CONFIG_HPET) || defined(CONFIG_X_HPET_RUST)
     pcms->hpet_enabled = true;
 #endif
     pcms->fd_bootchk = true;
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index c96fd5d97ae..9ac00845340 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -11,7 +11,7 @@ config A9_GTIMER
 
 config HPET
     bool
-    default y if PC
+    default y if PC && !HAVE_RUST
 
 config I8254
     bool
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
index 4d934f30afe..36f92ec0287 100644
--- a/rust/hw/Kconfig
+++ b/rust/hw/Kconfig
@@ -1,2 +1,3 @@
 # devices Kconfig
 source char/Kconfig
+source timer/Kconfig
diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
new file mode 100644
index 00000000000..afd98033503
--- /dev/null
+++ b/rust/hw/timer/Kconfig
@@ -0,0 +1,2 @@
+config X_HPET_RUST
+    bool
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 68316dbdc1a..8a6243382a1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -103,7 +103,8 @@ qtests_i386 = \
    config_all_devices.has_key('CONFIG_VIRTIO_PCI') and                                      \
    slirp.found() ? ['virtio-net-failover'] : []) +                                          \
   (unpack_edk2_blobs and                                                                    \
-   config_all_devices.has_key('CONFIG_HPET') and                                            \
+   (config_all_devices.has_key('CONFIG_HPET') or                                            \
+    config_all_devices.has_key('CONFIG_X_HPET_RUST')) and                                   \
    config_all_devices.has_key('CONFIG_PARALLEL') ? ['bios-tables-test'] : []) +             \
   qtests_pci +                                                                              \
   qtests_cxl +                                                                              \
-- 
2.48.1


