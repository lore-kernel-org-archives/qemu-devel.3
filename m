Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE842C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqed-00018I-98; Fri, 19 Apr 2024 12:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeZ-00014y-Dq
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeT-00015a-Q8
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-346406a5fb9so1730783f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542388; x=1714147188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHJ237dkf2kJpaGwj/VrUeZKq0pv4D2ZIu3Md4Bu1Kw=;
 b=MxE4VhEThWb3ZWgTmPeJevq8kyAv0WcF9at0EwO4pUT0Ma39oVXnnhmVczs63+0F0d
 D3mnkScXR5k1vou/EtboZtWw0eusXjRib2Pcy4or7WLPI+CEgms+3+7h/rVUuXkKAJPS
 /wc0FiCMXPZJRwfBh6A+EADjmp2qzdGH5qBrJmMhIOQl1OqEVZ8E7v2uAz/zjUWtcl9J
 sPv4l2C9WY5JFCPrXjNsQNk+kzCBWI6I19aqB3G9rL/Imr1XDtNt1vCn+dJSYDPupA+B
 IfbgApOuy7jF3TEnKGL0gaH72lMR2WIFrsS8C58uAN9eWib0J8JOGaRcwHTRWN7Wr0uu
 nc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542388; x=1714147188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHJ237dkf2kJpaGwj/VrUeZKq0pv4D2ZIu3Md4Bu1Kw=;
 b=jmt5oE3YKCBRjixITM+2vJjW1NzLVsr1N8rQFNX9zLDanZ9GZdWxiuMsgJTbM3RvCr
 nUMoKpgV1uSMy8cxG/f0s9hQgC3EsoQrRkMXJy3DM4Alm/ydoB2fGkdO9ocytJ5pJ39I
 yBB3irvpTVW515sorXa9dllZ8a1NtpE0eUQ6v5RGpw1RgOFdyRXa84ZSlkrbe4Tb0w6N
 KErvBhJEMDu+OUDaAUVaCoRp63SDAy38cHcQ473d5Tlod1wuV+o+fy3bDT7FNjN8w4Sq
 L3tCZNVW4isMtxHtegaaIqGsTANRygb4vGir7fdRCsGslAZk0zgiTaBvnqzc52KSJMzv
 n51Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWToN3S6DVKhm8MCUIz1MmCIAinjStEKwcbbDsPj3Wvo67swuSnwu+R8iqsIwJ77js+l33xKGu8lTLSZIE1+i2Gtgm9uxU=
X-Gm-Message-State: AOJu0YwlLtKWBdasjnI+hRpIuG6KgSplB8Q3m6dwhTVyDuRNGN9leflP
 jU7YcS4RV/uJhCzzgvDpYrulOCTeDBJ9j1Foy2pXYvMIcCRWQ7Mjl6THlSDJGNM=
X-Google-Smtp-Source: AGHT+IGlBA950nDjW7CG1uLSn0MBVse+OwbjPv7C46uF3Gal/NNnyKNA4TJwKZ9Al41bcIAubUbBHA==
X-Received: by 2002:a05:6000:114f:b0:34a:19d0:d907 with SMTP id
 d15-20020a056000114f00b0034a19d0d907mr1645758wrx.37.1713542388388; 
 Fri, 19 Apr 2024 08:59:48 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 02/22] target/arm: Add confidential guest support
Date: Fri, 19 Apr 2024 16:56:50 +0100
Message-ID: <20240419155709.318866-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
support the Arm Realm Management Extension (RME). It is instantiated by
passing on the command-line:

  -M virt,confidential-guest-support=<id>
  -object guest-rme,id=<id>[,options...]

This is only the skeleton. Support will be added in following patches.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 docs/system/confidential-guest-support.rst |  1 +
 qapi/qom.json                              |  3 +-
 target/arm/kvm-rme.c                       | 46 ++++++++++++++++++++++
 target/arm/meson.build                     |  7 +++-
 4 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 0c490dbda2..acf46d8856 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -40,5 +40,6 @@ Currently supported confidential guest mechanisms are:
 * AMD Secure Encrypted Virtualization (SEV) (see :doc:`i386/amd-memory-encryption`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
+* Arm Realm Management Extension (RME)
 
 Other mechanisms may be supported in future.
diff --git a/qapi/qom.json b/qapi/qom.json
index 85e6b4f84a..623ec8071f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -996,7 +996,8 @@
     'tls-creds-x509',
     'tls-cipher-suites',
     { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
-    { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
+    { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] },
+    'rme-guest'
   ] }
 
 ##
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
new file mode 100644
index 0000000000..960dd75608
--- /dev/null
+++ b/target/arm/kvm-rme.c
@@ -0,0 +1,46 @@
+/*
+ * QEMU Arm RME support
+ *
+ * Copyright Linaro 2024
+ */
+
+#include "qemu/osdep.h"
+
+#include "exec/confidential-guest-support.h"
+#include "hw/boards.h"
+#include "hw/core/cpu.h"
+#include "kvm_arm.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
+
+#define TYPE_RME_GUEST "rme-guest"
+OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
+
+struct RmeGuest {
+    ConfidentialGuestSupport parent_obj;
+};
+
+static void rme_guest_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static const TypeInfo rme_guest_info = {
+    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
+    .name = TYPE_RME_GUEST,
+    .instance_size = sizeof(struct RmeGuest),
+    .class_init = rme_guest_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void rme_register_types(void)
+{
+    type_register_static(&rme_guest_info);
+}
+
+type_init(rme_register_types);
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb..c610c078f7 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -8,7 +8,12 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_ss.add(when: 'CONFIG_KVM',
+  if_true: files(
+    'hyp_gdbstub.c',
+    'kvm.c',
+    'kvm-rme.c'),
+  if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-- 
2.44.0


