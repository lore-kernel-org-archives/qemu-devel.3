Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C700DC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nB-0003eQ-AH; Sun, 12 May 2024 06:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mz-0003VB-ET
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mw-00068r-4v
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KAgxrPk7qgofAnBxYawC+GAMA6BaH6EyGuv3lOcUvQ=;
 b=Mthmq27WE8joTBrrDLtKVCJcyTN6jMScUowHzboF9XfxQBLPaZl435xbWup4By3lMeO0wa
 ZJEM3W9uuXryx3GFl6no3mymMUfw2+5QMZfq3Y/+1BHv23O6iOARh20NlBrd08Z/Mq1Wi4
 NDx9XwY1t6wC9LgoV6hgmVZjRJb8g68=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-scLgQEXBOIieo8xs01p6ug-1; Sun, 12 May 2024 06:50:29 -0400
X-MC-Unique: scLgQEXBOIieo8xs01p6ug-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51fa2c23f62so3185099e87.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511027; x=1716115827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KAgxrPk7qgofAnBxYawC+GAMA6BaH6EyGuv3lOcUvQ=;
 b=GdYh+w1HtTL9REt100LJHopUi6oAkzdPL93Rlwq+1fVlqvCpZhiQZ2crhjDTnp0vb2
 6dZvVqKJH2csMFyt/EKNdcAhUZ1vwPcdfAnlxSmlEncCs32Ej7o/owLwbjPngwuadLMV
 ajJXKjp1tovzMJOb/syYfm03D0gBsYPHuh7Es7H84wg4NFD+KRCnZpWCoKH48nxqtenJ
 8H3L5tt7E4R2cFN645oZntexXXDTUgsTJmKvvZC6bunQTu7uSbZ/3d3gkGlK84Z3cgt3
 22vDJzM30U39Y+QcUx3TcXtkJWslucI01yV1P8uTFmvfXgzD5sTdemz+ujRvedPIyuBq
 dCMw==
X-Gm-Message-State: AOJu0YyzVvijCb0AtwK3azELLSV6yxUT5sg/sLezaACsJWQVjfcAOX0S
 Ch47rOc58P7DpfsclMbfn0WueDE6NxjAdhHy+ZVQX1qSIX21t+SM5yWjd3IANTQBDQmIaB0qtM0
 hbgUjRwWWFiJmlQ+Gyuc+5KLMGYnAZs9+ey51TRvYZjjZG2kMv1tk9AG+dIkQaCz87jlu4hk0Pc
 QGXyIEYBXJWbT31fySGoF5w+QYiSrJpQ6BtLoG
X-Received: by 2002:ac2:4ace:0:b0:521:92f6:3089 with SMTP id
 2adb3069b0e04-5220ff73877mr4175459e87.60.1715511027402; 
 Sun, 12 May 2024 03:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCcKYCBodKFNLRRDdSsXODcrEBG4Jpgra6HT3oEoroWWd4T04tYgssZTbDJJmKUa1c6aNvlQ==
X-Received: by 2002:ac2:4ace:0:b0:521:92f6:3089 with SMTP id
 2adb3069b0e04-5220ff73877mr4175452e87.60.1715511027026; 
 Sun, 12 May 2024 03:50:27 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bea653bsm4654570a12.1.2024.05.12.03.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/27] i386: correctly select code in hw/i386 that depends on
 other components
Date: Sun, 12 May 2024 12:49:34 +0200
Message-ID: <20240512104945.130198-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

fw_cfg.c and vapic.c are currently included unconditionally but
depend on other components.  vapic.c depends on the local APIC,
while fw_cfg.c includes a piece of AML builder code that depends
on CONFIG_ACPI.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240509170044.190795-9-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c    | 2 ++
 hw/i386/meson.build | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d802d2787f0..6e0d9945d07 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -203,6 +203,7 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
     fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
 }
 
+#ifdef CONFIG_ACPI
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
 {
     /*
@@ -229,3 +230,4 @@ void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
     aml_append(dev, aml_name_decl("_CRS", crs));
     aml_append(scope, dev);
 }
+#endif
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index d8b70ef3e9c..d9da676038c 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -1,12 +1,12 @@
 i386_ss = ss.source_set()
 i386_ss.add(files(
   'fw_cfg.c',
-  'vapic.c',
   'e820_memory_layout.c',
   'multiboot.c',
   'x86.c',
 ))
 
+i386_ss.add(when: 'CONFIG_APIC', if_true: files('vapic.c'))
 i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                       if_false: files('x86-iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
-- 
2.45.0


