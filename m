Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6BDC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c5M-0006tA-Na; Wed, 08 May 2024 03:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c55-0006nW-5E
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4c53-0003cu-DM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abjyl/HEi16Q8U+vYHLBpHeQKrEN0ASuTTcw3BTIrws=;
 b=dxig78WiDNUiFMZgFmTp2TbPg3yjZgYzyD9Goh3SxJZNJP3QrVkSOBqt6jYX+1AkPzIa9R
 RUXTQC0hWYBV9GNC1lPmSZT5i/1M/xG+b2X4xfyUAmpPK35g9WjoRsyhMZayjdcqaXFXLc
 jt9rpQlL9uaaCAfPzUT8ALcW5RNmgK0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-gQSdojxwMRCMpZHnNJ48bQ-1; Wed, 08 May 2024 03:51:11 -0400
X-MC-Unique: gQSdojxwMRCMpZHnNJ48bQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59eea00cafso103465966b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154668; x=1715759468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abjyl/HEi16Q8U+vYHLBpHeQKrEN0ASuTTcw3BTIrws=;
 b=i4LHHrOXFD4hxLgCFoWuf4gi4nJ7+Xy/ZEZ7mkaZJfwn2xeRzsHRQiSxDTFOMwkE0k
 1K2X/zxGXYvCfBANbY7qHjuH3pAneN0/YjMXSJyzeCYoAwyJzVi2dtCaXenNlsa7pS6C
 BlWjMrpVl2bxEOh+a8JeD/5p8WSNne71adPOxWiN5ttxMyDv8sWV/dgWvPwZmUMiiVCJ
 lmKVhhNoftmRznXARRbwMDBAR4BVjD7CQoulUlTmG2RkA4N6VoHdK1eygCMGQhaJI7Jr
 z5kjQm6wyNDiUlvot12oS3abt5aAW/ht78617ERi9P4RhJv9z0U8YRt1T58zcxGg+EgP
 wZzQ==
X-Gm-Message-State: AOJu0Yw5NOacxjVocnjQalh9eZSZtTaT/TcWDE0yWVSo26H2bZem/YKq
 eZhdKw9jldQW9g1Nh99hxaKcJ4WRGOhgphS9ZcF31q+SreCJpPwtkaBvtuFRMK3N207IfSgauBG
 loCGNsPxaKUIbEKys4wFEapfST733+nPXJR5mg3FdPpLv5KCWP+pbpCAwBxa76u3AXd5feBIES9
 1iKHfxtZe9ZqMH4tMHWKPDjjl4EYd+wkzof6KV
X-Received: by 2002:a17:906:2451:b0:a59:ba2b:5915 with SMTP id
 a640c23a62f3a-a59fb9c6954mr148715266b.50.1715154667949; 
 Wed, 08 May 2024 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLXo3NdlxOiqqt2SvyAj045QXX5nq3uWC8Dr2WBtOnX8nBS8WQINZ/tdf8BfhwjzZYPq/EUQ==
X-Received: by 2002:a17:906:2451:b0:a59:ba2b:5915 with SMTP id
 a640c23a62f3a-a59fb9c6954mr148713666b.50.1715154667465; 
 Wed, 08 May 2024 00:51:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 cx10-20020a170906c80a00b00a59fac165dfsm888483ejb.204.2024.05.08.00.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:51:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 1/6] meson: pick libfdt from common_ss when building
 target-specific files
Date: Wed,  8 May 2024 09:51:00 +0200
Message-ID: <20240508075105.15510-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508075105.15510-1-pbonzini@redhat.com>
References: <20240508075105.15510-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Avoid having to list dependencies such as libfdt twice, both on common_ss
and specific_ss.  Instead, just take all the dependencies in common_ss
and allow the target-specific libqemu-*.fa library to use them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              | 14 +++++++++++---
 hw/arm/meson.build       |  2 +-
 hw/loongarch/meson.build |  2 +-
 hw/mips/meson.build      |  2 +-
 hw/openrisc/meson.build  |  4 ++--
 hw/ppc/meson.build       |  4 +---
 hw/riscv/meson.build     |  2 +-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 43da4923721..7ca0ba4987f 100644
--- a/meson.build
+++ b/meson.build
@@ -3868,15 +3868,23 @@ foreach target : target_dirs
 
   target_common = common_ss.apply(config_target, strict: false)
   objects = common_all.extract_objects(target_common.sources())
-  deps = target_common.dependencies()
+  arch_deps += target_common.dependencies()
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
+  # allow using headers from the dependencies but do not include the sources,
+  # because this emulator only needs those in "objects".  For external
+  # dependencies, the full dependency is included below in the executable.
+  lib_deps = []
+  foreach dep : arch_deps
+    lib_deps += dep.partial_dependency(compile_args: true, includes: true)
+  endforeach
+
   lib = static_library('qemu-' + target,
                  sources: arch_srcs + genh,
-                 dependencies: arch_deps,
+                 dependencies: lib_deps,
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
@@ -3924,7 +3932,7 @@ foreach target : target_dirs
     emulator = executable(exe_name, exe['sources'],
                install: true,
                c_args: c_args,
-               dependencies: arch_deps + deps + exe['dependencies'],
+               dependencies: arch_deps + exe['dependencies'],
                objects: lib.extract_all_objects(recursive: true),
                link_depends: [block_syms, qemu_syms],
                link_args: link_args,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 6808135c1f7..aefde0c69a3 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'), fdt)
+arm_ss.add(files('boot.c'))
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index d306d82c2ee..bce7ebac97e 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -3,7 +3,7 @@ loongarch_ss.add(files(
     'fw_cfg.c',
     'boot.c',
 ))
-loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'), fdt])
+loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('virt.c'))
 loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
 
 hw_arch += {'loongarch': loongarch_ss}
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index f06d88f3430..ca37c42d900 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -9,7 +9,7 @@ if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
-mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: [files('boston.c'), fdt])
+mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
 endif
 
 hw_arch += {'mips': mips_ss}
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
index 2dbc6365bb7..82f1f0ef1cc 100644
--- a/hw/openrisc/meson.build
+++ b/hw/openrisc/meson.build
@@ -1,7 +1,7 @@
 openrisc_ss = ss.source_set()
 openrisc_ss.add(files('cputimer.c'))
 openrisc_ss.add(files('boot.c'))
-openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: [files('openrisc_sim.c'), fdt])
-openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: [files('virt.c'), fdt])
+openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
+openrisc_ss.add(when: 'CONFIG_OR1K_VIRT', if_true: files('virt.c'))
 
 hw_arch += {'openrisc': openrisc_ss}
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index d096636ee7f..3ebbf329bcc 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -3,9 +3,7 @@ ppc_ss.add(files(
   'ppc.c',
   'ppc_booke.c',
 ))
-ppc_ss.add(when: 'CONFIG_FDT_PPC', if_true: [files(
-  'fdt.c',
-), fdt])
+ppc_ss.add(when: 'CONFIG_FDT_PPC', if_true: files('fdt.c'))
 ppc_ss.add(when: 'CONFIG_FW_CFG_PPC', if_true: files('fw_cfg.c'))
 
 # IBM pSeries (sPAPR)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2f7ee81be3c..f872674093a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,5 @@
 riscv_ss = ss.source_set()
-riscv_ss.add(files('boot.c'), fdt)
+riscv_ss.add(files('boot.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
-- 
2.45.0


