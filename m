Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FFCC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVR-0004Aj-2a; Fri, 19 Jul 2024 13:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cJSaZggKCj8xifoesjlhpphmf.dpnrfnv-efwfmopohov.psh@flex--whendrik.bounces.google.com>)
 id 1sUqUH-0002LG-VA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:41 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cJSaZggKCj8xifoesjlhpphmf.dpnrfnv-efwfmopohov.psh@flex--whendrik.bounces.google.com>)
 id 1sUqUF-0004CP-0M
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:41 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso7655685e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406577; x=1722011377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=EuegESfmjtOPOYVDWqUdcW99Kxin32wkde1axwvFNOQ=;
 b=0ltkSNuraYIwg7A0L4pjawWGo/7/5zZaMCRNk456a1vjufscT/YsPOw+0zG6OPGLNM
 cyuKZaBj09PB7LsaBXS+cImRnxkqmTwjvQurByYboycCuswKnxkL4qCjyKet6dZ+6dz/
 /qk3sGKXC+Wh8CCd1qcMp6SoALxsXZtVxVsM7B7FjR60/R3W6LEIkwZCX0eUFC9xrem0
 3RJxi9OOoh7/jdBVV7Fa44kLh75igd+xyXz1ZkOUdeUUnNfo9Lb7BvPRLDAOfBLXJ+7L
 usLT0pehaFBsWEKGMjrXgRqbzAMmjtyWUMSXD9M/b17zI4SrjJK4fV83AyJXvdKBrwYZ
 Bubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406577; x=1722011377;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EuegESfmjtOPOYVDWqUdcW99Kxin32wkde1axwvFNOQ=;
 b=AqhGlN/KfC04y94vaG76HuXZXIk1xJ60/N4eivbr3Nz6gAgIEonwsKOOyXuCh0MnHh
 78FPUZ2CRHWmq+zwnuJUP2hg1Z3Wr1P+8gcGGD0ITqMN8IWx8o7rKyqKf6AU85XmZ1wT
 2pRa+dK+8a5s3erjPC+UJifRqeKT1AYSEGxuXwapl6f0fCwH2FjAmlQD2+ifw+MxLWV2
 13o/hclXMIEizX6lSMJPm03b2IYzmjz64d2lOVrACtJmCrlXlDjDsxm1TEAwRyEQiXZ7
 U4rUUDbRTPY7+pAuP3qvXxcivXEy+1ZeK6uBNxm5kv8fQ0Cu1W3Kr0XUNULuQ8vViZBV
 0cww==
X-Gm-Message-State: AOJu0YzcLinjCdzNFV/4MmLdha/xDzKF8hLxg/HMxbvHLb2qAS79XlEq
 yj3MrnQDzftP5VBXmn0VCy2qZLkJqrpF+zdpCNkh1qQhZmcnaCwyzVRIaR/IGIkblZCgWkl7U6Z
 zjfOOw8SPigMkKB+D+Q0Cos79tbN9cj8Ygqrg15TlpQz9jM2nBhZ6K0e5E9EN50R3vEm3OK+ZQS
 5XTPIijit/Jza4iXsopxJCQqOaLilhkVNn+JSQUM0Cvw==
X-Google-Smtp-Source: AGHT+IFv0AX1gUZXag6niCN+z/eeMcO9hLQ0PBPZwp13D1t/x/HZxPTHu7Fi/4o0Et9+KaOV4SYRmubJNz4xFw==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:600c:1c1d:b0:426:6761:2fea with SMTP id
 5b1f17b1804b1-427d2ac80c1mr636785e9.3.1721406576860; 
 Fri, 19 Jul 2024 09:29:36 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:21 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-2-whendrik@google.com>
Subject: [PATCH v1 1/9] Add Intel RDT device to config.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3cJSaZggKCj8xifoesjlhpphmf.dpnrfnv-efwfmopohov.psh@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:48 -0400
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Change config to show RDT, add minimal code to the rdt.c module to make
sure things still compile.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/Kconfig       |  4 ++++
 hw/i386/meson.build   |  1 +
 hw/i386/rdt.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h | 12 +++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c08..4dd05ed6f2 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -10,6 +10,9 @@ config SGX
     bool
     depends on KVM
=20
+config RDT
+    bool
+
 config PC
     bool
     imply APPLESMC
@@ -26,6 +29,7 @@ config PC
     imply QXL
     imply SEV
     imply SGX
+    imply RDT
     imply TEST_DEVICES
     imply TPM_CRB
     imply TPM_TIS_ISA
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 03aad10df7..fdbf5962b5 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport=
.c'))
 i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+i386_ss.add(when: 'CONFIG_RDT', if_true: files('rdt.c'))
=20
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
new file mode 100644
index 0000000000..0a5e95606b
--- /dev/null
+++ b/hw/i386/rdt.c
@@ -0,0 +1,49 @@
+#include "qemu/osdep.h"
+#include "hw/i386/rdt.h"
+#include <stdint.h>
+#include "hw/qdev-properties.h"
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+#include "target/i386/cpu.h"
+#include "hw/isa/isa.h"
+
+#define TYPE_RDT "rdt"
+
+OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
+
+struct RDTState {
+    ISADevice parent;
+};
+
+struct RDTStateClass { };
+
+OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
+
+static Property rdt_properties[] =3D {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rdt_init(Object *obj)
+{
+}
+
+static void rdt_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void rdt_finalize(Object *obj)
+{
+}
+
+static void rdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->hotpluggable =3D false;
+    dc->desc =3D "RDT";
+    dc->user_creatable =3D true;
+    dc->realize =3D rdt_realize;
+
+    device_class_set_props(dc, rdt_properties);
+}
+
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
new file mode 100644
index 0000000000..45e34d3103
--- /dev/null
+++ b/include/hw/i386/rdt.h
@@ -0,0 +1,12 @@
+#ifndef HW_RDT_H
+#define HW_RDT_H
+
+#include <stdbool.h>
+#include <stdint.h>
+
+typedef struct RDTState RDTState;
+typedef struct RDTStateInstance RDTStateInstance;
+typedef struct RDTMonitor RDTMonitor;
+typedef struct RDTAllocation RDTAllocation;
+
+#endif
--=20
2.45.2.1089.g2a221341d9-goog


