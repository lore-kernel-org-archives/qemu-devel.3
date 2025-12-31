Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74B2EE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqip-0007Vs-LH; Wed, 31 Dec 2025 02:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqio-0007Uw-AC
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:18 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqim-0001Ao-4X
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:18 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so11086883b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166455; x=1767771255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61Ox3g57Sf+viLXH39+CDULuy7QZTHnRiB/sotzZN9M=;
 b=awg2tp2wSaA1m8FOrZ/kd108h9cTAkvlwyeVYGjnc7tz6IC0rvQoMo5IeOz/JC4ZN6
 3xSLu4XoedHrTC6ozVHCexGTYveY18ue4lwsuEMJXJguS+2S+CFPgL1bUvbIjO8oBcN+
 39sFGGQbJfZL/THfU9nCulvuQnKPAekMX6NgQi56nUguvByprsva5sRKV5H7NO82FZdj
 GAJBcGxfxHYOtuhOPDTnhXIJjTx4LRmZIScdTj+chmSGA9WlaEAfk575zG0T+aPmKg6l
 5NumKuofZ6Pdw7YYnyZOCuulJ4TaIxwnXwtX/TGnH1Suivzf+tAslwvCss9hjJ0EGfoB
 VaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166455; x=1767771255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=61Ox3g57Sf+viLXH39+CDULuy7QZTHnRiB/sotzZN9M=;
 b=FctzGDnbZWNVOWoaae458HK7obRM2QxpbNMPCnvqjtODbrCpCsvLPsGXtDYIJ4YZXK
 qnTWgp7FZYRbVijitI+q7Imd0F5CDJNfd2Q0qTkv27b6uO7ODvArj+kVTrNkoMrkB7zO
 4cRSM1vZ650KuTo+MvTvaK9Z7Nh8MTN+qcdBRPbFmeHuLU9UDM1la19MaJ2nJTug1JOu
 nbubLnZhiCrURXUWe4zjepzTJCGYcQZVVP/nCaLkPVAoCf7+8JsQpI2FpP9vlLenfoFf
 OPXyAKR0SJ/pKKrTkcDvIrJMuBw/HltBoA0pxcr22gDiBjBx32iQWhCg2m/Gj8DOLcmb
 eUWw==
X-Gm-Message-State: AOJu0YxXAg7DaHgK9HnOXpRUeGdD3zn4OyExyRtcAUY5o1Q0qoCklZpq
 cDc6+aENN6BXhRu3sN3y8NdJVTVmLFAi1k+EIP0QMmZ+FykP/vJzBpd+8sDD2Ud2AvuaoG26maJ
 bWf7c
X-Gm-Gg: AY/fxX5fUT1XLtgjoc42Avq3hRVXcganYgCT3U3viLiBuJ6j4cr+bdVFowAtCBb/O+j
 c430QoY2EfEvw+kypbR9Uy1br4adEaUNI/TNT5fOUv+dPKL499KRiAcEtVOFlYdrgQQJfveW8Kv
 t4aIE1x/LpQ1zdAzGWZ+PBnadBPZXp/7RQdUU33KKG5syx/1LkaxO/GqvncR309H/QAz6cbNE27
 teObZ27iqJsC1L7rEIuh6XXXYWgLDm31qkWr1zsKGbelSnKnalgGarKo8C3aiVyP1JTYb7LSlg8
 U6W5FRGxVTR7FDL5cs5fOhAkT2BvUR9SvTwcBSuFPQCehhxEHSbts995ceyvP7nV/PENbETXoDh
 83dsITiyn8NlqwbXG5i8XGbDMUoK4CGSPDn9Cvqzv7JnpjJvNC+hMG2vutrayqrYZjXKxlX+sis
 5WOtiQQPu9XMzrPIfC988fkRILZ4dCOGgKXqVd6BZkC4SaGVD2WSS8egf2yiid5KyK
X-Google-Smtp-Source: AGHT+IFr2BQfgqdsoAz6ZSs2bynSwblget3vPPS78gMEJCrPXxkfH3oy5/3E4GkGFXFyzBULpoiVbg==
X-Received: by 2002:a05:6a00:44c6:b0:7e8:4398:b369 with SMTP id
 d2e1a72fcca58-7ff66c637damr28990442b3a.60.1767166454672; 
 Tue, 30 Dec 2025 23:34:14 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/11] include: qemu/ctype.h -> qemu/qemu-ctype.h
Date: Tue, 30 Dec 2025 23:33:55 -0800
Message-ID: <20251231073401.2097765-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This headers conflicts with C++ ctype header, included from iostream.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/{ctype.h => qemu-ctype.h} | 0
 block/ssh.c                            | 2 +-
 block/vvfat.c                          | 2 +-
 gdbstub/gdbstub.c                      | 2 +-
 hw/core/bus.c                          | 2 +-
 hw/core/qdev-properties-system.c       | 2 +-
 hw/core/qdev-properties.c              | 2 +-
 hw/hyperv/syndbg.c                     | 2 +-
 hw/nvme/nguid.c                        | 2 +-
 hw/s390x/ccw-device.c                  | 2 +-
 hw/s390x/ipl.c                         | 2 +-
 hw/s390x/s390-virtio-ccw.c             | 2 +-
 hw/scsi/scsi-generic.c                 | 2 +-
 migration/migration.c                  | 2 +-
 monitor/fds.c                          | 2 +-
 monitor/hmp.c                          | 2 +-
 net/net.c                              | 2 +-
 net/tap-solaris.c                      | 2 +-
 qapi/qapi-util.c                       | 2 +-
 qobject/json-parser.c                  | 2 +-
 target/ppc/ppc-qmp-cmds.c              | 2 +-
 target/riscv/cpu.c                     | 2 +-
 target/riscv/riscv-qmp-cmds.c          | 2 +-
 tests/qtest/libqtest.c                 | 2 +-
 tests/qtest/migration/migration-util.c | 2 +-
 tests/vhost-user-bridge.c              | 2 +-
 ui/keymaps.c                           | 2 +-
 util/cutils.c                          | 2 +-
 util/id.c                              | 2 +-
 util/readline.c                        | 2 +-
 30 files changed, 29 insertions(+), 29 deletions(-)
 rename include/qemu/{ctype.h => qemu-ctype.h} (100%)

diff --git a/include/qemu/ctype.h b/include/qemu/qemu-ctype.h
similarity index 100%
rename from include/qemu/ctype.h
rename to include/qemu/qemu-ctype.h
diff --git a/block/ssh.c b/block/ssh.c
index bdec94e9e92..8ae7be4b423 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -34,7 +34,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qapi/qapi-visit-sockets.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index e334b9febb1..d495d07e5b0 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -36,7 +36,7 @@
 #include "migration/blocker.h"
 #include "qobject/qdict.h"
 #include "qobject/qstring.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1f8cd118924..47d4f63d4e4 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 53f392fdda8..202c42b405d 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index fe5464c7da1..420b60e9ba1 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -20,7 +20,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-visit-virtio.h"
 #include "qapi/qmp/qerror.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 #include "qemu/uuid.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 05489c8fbbf..3e762d83194 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -4,7 +4,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-visit-common.h"
 #include "qobject/qlist.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "qemu/units.h"
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 1e177f9dd82..7219ed0f219 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
index 4cd6fad6ac9..acd73ac695b 100644
--- a/hw/nvme/nguid.c
+++ b/hw/nvme/nguid.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/visitor.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "nvme.h"
 
 #define NGUID_SEPARATOR '-'
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 25c42732795..6520fee7970 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "ipl.h"
 #include "qapi/visitor.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qapi/error.h"
 
 static void ccw_device_refill_ids(CcwDevice *dev)
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d34adb55220..21adb5955b3 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -34,7 +34,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
 
 #define KERN_IMAGE_START                0x010000UL
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8314655ec2c..217244643b6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -19,7 +19,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "virtio-ccw.h"
 #include "qemu/config-file.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 0a676a16fa4..c2563ccbdf6 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
diff --git a/migration/migration.c b/migration/migration.c
index 9d1bf5d276d..5b21eb07d5e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/monitor/fds.c b/monitor/fds.c
index cc35d2ec334..d98c117a9b2 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "system/runstate.h"
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 4caafbc7146..023c4e77a84 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -30,7 +30,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/config-file.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
diff --git a/net/net.c b/net/net.c
index a176936f9bc..ca2f49119d5 100644
--- a/net/net.c
+++ b/net/net.c
@@ -43,7 +43,7 @@
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/id.h"
 #include "qemu/iov.h"
 #include "qemu/qemu-print.h"
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 75397e6c544..6e1da970d98 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "tap_int.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "net/net.h"
 
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 3d849fe0347..b372c74dd04 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qapi/qmp/qerror.h"
 
 CompatPolicy compat_policy;
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7483e582fea..7c5618ba3f3 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/unicode.h"
 #include "qapi/error.h"
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 7022564604f..ae9711a21e3 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/error.h"
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f26d8b8b07..17df96913ce 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/qemu-print.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d5e9bec0f86..618007fc0f9 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -31,7 +31,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/qemu-print.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 622464e3656..10a01ba76fa 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -31,7 +31,7 @@
 #include "libqtest.h"
 #include "libqmp.h"
 #include "qemu/accel.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/exit-with-parent.h"
 #include "qemu/sockets.h"
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index c2462306a15..1c6dbb6c19b 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index ce4c3426d39..cb852194dd0 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -31,7 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/atomic.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/iov.h"
 #include "standard-headers/linux/virtio_net.h"
 #include "libvhost-user.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 2359dbfe7e6..6dfd5a45ee3 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -26,7 +26,7 @@
 #include "qemu/datadir.h"
 #include "keymaps.h"
 #include "trace.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "ui/input.h"
diff --git a/util/cutils.c b/util/cutils.c
index 9803f11a596..2c0a9926893 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -48,7 +48,7 @@
 #include <wchar.h>
 #endif
 
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 
diff --git a/util/id.c b/util/id.c
index ded41c5025e..0ba538dce81 100644
--- a/util/id.c
+++ b/util/id.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/id.h"
 
 bool id_wellformed(const char *id)
diff --git a/util/readline.c b/util/readline.c
index 0f19674f526..f756d384625 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/readline.h"
-#include "qemu/ctype.h"
+#include "qemu/qemu-ctype.h"
 #include "qemu/cutils.h"
 
 #define IS_NORM 0
-- 
2.47.3


