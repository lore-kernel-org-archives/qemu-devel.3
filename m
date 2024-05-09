Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52347C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5797-0002Qa-7n; Thu, 09 May 2024 13:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5794-0002PH-5x
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5791-0003b5-PZ
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwuKd3xDQi5jqV7bVmAt6zG3iu3oNv9dZi8phhwclTk=;
 b=MYjfxszpUl9XXK0mukPWVayDE/AFn/U4dvwd6/ASuHNsjYOlEpHf9UC+6whoe68it0xJnq
 Lc0XzQNOoHgTDZLWXd7404GCvQUcAPiMnbl9BMChjT/YVY5kLS53FQ8tjI9+YS0+vuIiPq
 1F3n+TSPXhvJbJPD8/JWckdkNJIjIDs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-ltratU-dMjSEbkIlui_Qng-1; Thu, 09 May 2024 13:01:16 -0400
X-MC-Unique: ltratU-dMjSEbkIlui_Qng-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51fa40244f6so1025572e87.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274073; x=1715878873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwuKd3xDQi5jqV7bVmAt6zG3iu3oNv9dZi8phhwclTk=;
 b=FmjHOTymRd3NYwcrQvGIliEfPMhf8qHY8QOhA8MLAUPpfVVkhTSmGbg4wc4Ig/MWp0
 /MWMXvjqhm+CouNV69m9V27YMORwsIxTOu1if1b1ntlOc4lJkYAypYoIspDO+YkoS9Ne
 vSXcLsrR0s0RboCUElvfjgcsuC9bLGNZgjb9oo+JIGmIthnfqlSn5po+noc643WjYs86
 VT5AmJpfTzDKdQA+1rL7ccNgz4CV1heeLS2wH4+KVTu4AVCgDzBnzCTf5nqQYgdo3lNf
 2a7j/j1jQIw6Q23aAdvsGZBCHk+8D3wdYfCiWUMRbijMg3HvQ9QNE/58/yG9Sbzk2Tq4
 hZlQ==
X-Gm-Message-State: AOJu0YwhNl4mqSHAnH9TwUsSSokH65l0URKT25lT0bhtqO7YIZSV0tOc
 0OJVbnClQePhM1H5YU35obBY5Hjw6iZABv2MlrqRyq3vA/GpEkmxFz9xyPoQrofVcH98C50++r5
 uwhRTxpA5YwpakM69aGfKWOWQAklJkxOSrtglWqBaTGAbPKHPPDykzQ+rq7UaJ0boRPFNi4Dq9b
 iLJqyhOz7Op7PC6+R7ltC3ogeP1UwkDicn/NXd
X-Received: by 2002:a05:6512:10c9:b0:51e:ef7f:4e89 with SMTP id
 2adb3069b0e04-5220fb76884mr102864e87.6.1715274073420; 
 Thu, 09 May 2024 10:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+FRMeRZq1nvhsAjfLlfh8C25qyukNK0bbj5du0KKSnjG3G7MPmDDt9iw3+QmGWhALp4bOog==
X-Received: by 2002:a05:6512:10c9:b0:51e:ef7f:4e89 with SMTP id
 2adb3069b0e04-5220fb76884mr102842e87.6.1715274073045; 
 Thu, 09 May 2024 10:01:13 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17922159sm93336666b.97.2024.05.09.10.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:01:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 12/13] i386: select correct components for no-board build
Date: Thu,  9 May 2024 19:00:43 +0200
Message-ID: <20240509170044.190795-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
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

The local APIC is a part of the CPU and has callbacks that are invoked
from multiple accelerators.

The IOAPIC on the other hand is optional, but ioapic_eoi_broadcast is
used by common x86 code to implement the IOAPIC's implicit EOI mode.
Add a stub in case the IOAPIC device is not included but the APIC is.

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
index f8502905203..62616157206 100644
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


