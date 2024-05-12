Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA479C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nC-0003f4-BG; Sun, 12 May 2024 06:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mz-0003VE-JN
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mv-00068i-Ne
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KX/WzO9SEbEapAHb5uV1NTmuenXlvGjuYVaH5T5vvic=;
 b=RfU6h4OfpvlOWbTMtXyriqn9sqcuk9q2TlYIDuBAsBPY74f1knbANotiqz3nPsjrJZ0HKi
 c8c6pQrhxahT2lUMbtCDIQp1UkLwOHCCCyosD4xJQOrCbSblQw8E0R6CIcHKMh8BqgpD+E
 p3HEI1kkx6dcOd0hViQmYP4zNLyK26w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-PLCEdn1xN7uOJNaf7v2BRg-1; Sun, 12 May 2024 06:50:39 -0400
X-MC-Unique: PLCEdn1xN7uOJNaf7v2BRg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a0014904so190531666b.2
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511037; x=1716115837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KX/WzO9SEbEapAHb5uV1NTmuenXlvGjuYVaH5T5vvic=;
 b=k1pakW2Gkp/IYuItoMzQW34gSVHUDD85KcsGVxyFQ0Tn4x25g7lHjuw1XdqG0jJaNG
 iqMpIMkGF05H3QVkUJLqQ089/t28bHfhF5eadfAp3dY+LEF5UfdO+Ox4KrSVtr1WbY5s
 GxgrJRIdyPd6FkazjqvKNc0J5pcDLgoRLqXQ7eaNErMex71qOiK3G4PfBSg/ZMxVSfBb
 PAsvNJL+O5KcRW0ZCISsHX3LgzbxDkzokwyvIIUwP5sK71osBp56zSbWw+9fTNO17BN2
 4guTSiUwOGrQ+gMYWMtbz3rn2zvCr39iYyz5NpvbIh4J4puHl+u+5pJh7o2G4G7zCYYW
 772g==
X-Gm-Message-State: AOJu0YwTBvDBrLXV3k3eARrNOMMeSxS8WAM4Kab8w1iFZ14ZURiJ+53s
 yRzVszHuHBMvDNBrekUQtj9VuAi9FzXycnbd/VOJcT3AQ0ldrh3fgvB/XiUos2KqA3/rBEYhwXM
 5qYowMgkaQ/AXX9jL9ZatmBi4lGxRyTNQCXNNQJDjgbMwO7poQq4OmCDK3Fj/8zRE0XhnryelSI
 gRw5BHqqSC7Orp4xOYdkg7+tO9wPHpu6xwnuoH
X-Received: by 2002:a17:906:1701:b0:a59:a857:85d9 with SMTP id
 a640c23a62f3a-a5a2d67879emr490545566b.69.1715511037461; 
 Sun, 12 May 2024 03:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAMQoJFiNV1OFUsJN62OUeWHrQkLpx2Bsxk8PeHuYtv/59lhGqKX+/ais5exnKX0UIRM1T4Q==
X-Received: by 2002:a17:906:1701:b0:a59:a857:85d9 with SMTP id
 a640c23a62f3a-a5a2d67879emr490544566b.69.1715511037089; 
 Sun, 12 May 2024 03:50:37 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b019edsm451328866b.174.2024.05.12.03.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/27] i386: select correct components for no-board build
Date: Sun, 12 May 2024 12:49:38 +0200
Message-ID: <20240512104945.130198-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The local APIC is a part of the CPU and has callbacks that are invoked
from multiple accelerators.

The IOAPIC on the other hand is optional, but ioapic_eoi_broadcast is
used by common x86 code to implement the IOAPIC's implicit EOI mode.
Add a stub in case the IOAPIC device is not included but the APIC is.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240509170044.190795-13-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic-stub.c      | 29 +++++++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml |  2 +-
 hw/intc/meson.build        |  2 +-
 target/i386/Kconfig        |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 hw/intc/ioapic-stub.c

diff --git a/hw/intc/ioapic-stub.c b/hw/intc/ioapic-stub.c
new file mode 100644
index 00000000000..4dcd86248da
--- /dev/null
+++ b/hw/intc/ioapic-stub.c
@@ -0,0 +1,29 @@
+/*
+ *  ioapic.c IOAPIC emulation logic
+ *
+ *  Copyright (c) 2004-2005 Fabrice Bellard
+ *
+ *  Split the ioapic logic from apic.c
+ *  Xiantao Zhang <xiantao.zhang@intel.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/intc/ioapic.h"
+
+void ioapic_eoi_broadcast(int vector)
+{
+}
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 8ca3e0586c7..7af5c1ce8ad 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -650,7 +650,7 @@ build-tci:
 # Check our reduced build configurations
 # requires libfdt: aarch64, arm, i386, loongarch64, microblaze, microblazeel,
 #   mips64el, or1k, ppc, ppc64, riscv32, riscv64, rx, x86_64
-# does not build without boards: i386, x86_64
+# fails qtest without boards: i386, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index f4b540e6a8b..0d1b7d0a432 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -20,7 +20,7 @@ system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_avic.c', 'imx_gpcv2.c'))
-system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'))
+system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
 system_ss.add(when: 'CONFIG_PL190', if_true: files('pl190.c'))
diff --git a/target/i386/Kconfig b/target/i386/Kconfig
index ad9291d3b8f..6b0feef0299 100644
--- a/target/i386/Kconfig
+++ b/target/i386/Kconfig
@@ -1,5 +1,6 @@
 config I386
     bool
+    select APIC
     # kvm_arch_fixup_msi_route() needs to access PCIDevice
     select PCI if KVM
 
-- 
2.45.0


