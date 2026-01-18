Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35735C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYYX-00054s-HH; Sun, 18 Jan 2026 14:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYV-00050i-Dd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYT-0006df-7Y
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso24417165e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764919; x=1769369719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TMJh25P01fbyCqTCyF8lbOVh7yUzhOqUbvGeEO3WWI=;
 b=fy6G6HLPvJCps6JxPXNyJ00PvPOpBMlRKR7KV/t0yENGnpkXC2IFOrL+DvhfGyuxzf
 K95KzuNGDRveCyyKPHAg5n0zEcjtW6yUMqiH8oPiIuJrRbieF0jY35+hcidwcMs8osaj
 fzzXYAseIQaPePeqvyN6osL745b5BImrRf9Mwy0vYoIPF588bXguWCawiza5camTlTQ9
 7pWd94Od7bK5Me0edFsbBpVSyF73DcRACManf72vAHoJ/t+4GO5lvYynHIPw8W1h0pFo
 DXK+uBLVQGcYnFDb/QWFpzMXK/IAyPeATBkemfNG55l7YPvGgiV8Sj92v9dz/wyEO64l
 aSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764919; x=1769369719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6TMJh25P01fbyCqTCyF8lbOVh7yUzhOqUbvGeEO3WWI=;
 b=Ru6dUc9foGiBA8/h9aOXbxx3pELtIoROdyyd8KiEft9B5JGvbB2zJq+wc0zx5IbfnH
 e5g/eirNIi1yZj67xiFCQPMFXALrOya9PlR8A5RH3jnUeH8r91VQR5L12RzAJVG6uyYq
 VIAAQcOYV1K2WgFF6m0gpYeNoAfCKbD+BaPoJK1T2DAQrLEksGZOzZ2OKvktrbFf/ai1
 YIBh2F/UwjnxW8kLYekkFaUBw+eYv/R91N7OuL21rRskUJORsPwHUxpyQkPsRYOObPwe
 at2GrItqB3j6NHiD4ue6c++diiHHeaRclClU5dbYOPxfroG0WcAQVctVf2mtB1WNH0T3
 Qq4w==
X-Gm-Message-State: AOJu0Yy1+iqePAnE/o4Ch3pkQecEuYWGrJozUXNolfNtU/Dtyy3Xbv3s
 HtcB+BVT7QAF9pMKGylJwlJfipdZbve15cF/J7yU6vDP5+/cJX9dpVQ3ALsGUHhiN/u2rG8JLv1
 xsL6UYCw=
X-Gm-Gg: AY/fxX72N8H5K4ya9BgBpoHUnGP2alzGqAMGE7/q54SKvhsqy+aeyupsdg1druOIzys
 Npt8TRZlEWIXk93jRAjGD0NxuGrJjO3NtmgXMoiaAubb1OosB3Tkj49haFofLu0+cDnN9PwKQNU
 0K/r/yfuQImAl4IO5cLfNqk8RTM5RhHn+dfSfpjs8xF4B1PJuPBk9Cll6k/6UAqIpLDhR3ppWlf
 +yBSfnEEHX56OZ/T6BYCSEWQ6Vdrf/ANkMZ5K2jRD616pQPVBCNlxTkWaCMbYJ5wIYWApn0Cx0c
 cWQRBO5cxL9vJgc2eGKWpYuxKlSxnG418Glw8/BFKF5ln0x8XIHFiJ9rgpUzD1SpyBZvm858LYa
 ZZMycQpDepS8jlhpJzcncCpQtz+3K+Vzo4I4ffVnYECDsmstpow4lC40LyEaWICus9Rkk/CzB1K
 w6jkg10YExLOlrh8JOkMPh/slBUvdR72J73JiMawldkAXZOOKOqLCrB2dZqpfv
X-Received: by 2002:a05:600c:a399:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-4801e345c96mr90254755e9.27.1768764918293; 
 Sun, 18 Jan 2026 11:35:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4802dc90068sm76413205e9.7.2026.01.18.11.35.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 01/18] bswap: Include missing 'qemu/bswap.h' header
Date: Sun, 18 Jan 2026 20:34:51 +0100
Message-ID: <20260118193509.42923-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All these files indirectly include the "qemu/bswap.h" header.
Make this inclusion explicit to avoid build errors when
refactoring unrelated headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/qcow2.h                         | 1 +
 audio/audio.c                         | 1 +
 block/blklogwrites.c                  | 1 +
 block/export/vduse-blk.c              | 1 +
 block/export/vhost-user-blk-server.c  | 1 +
 block/export/virtio-blk-handler.c     | 1 +
 block/parallels-ext.c                 | 1 +
 hw/9pfs/9p-local.c                    | 1 +
 hw/block/cdrom.c                      | 1 +
 hw/block/hd-geometry.c                | 1 +
 hw/net/can/ctucan_core.c              | 1 +
 hw/nvram/xlnx-efuse.c                 | 1 +
 hw/scsi/scsi-generic.c                | 1 +
 hw/sd/sd.c                            | 1 +
 hw/sd/ssi-sd.c                        | 1 +
 net/l2tpv3.c                          | 1 +
 qga/commands-linux.c                  | 1 +
 scsi/pr-manager-helper.c              | 1 +
 target/arm/tcg/arith_helper.c         | 1 +
 tests/qtest/acpi-utils.c              | 1 +
 tests/qtest/aspeed-hace-utils.c       | 1 +
 tests/qtest/bios-tables-test.c        | 1 +
 tests/qtest/libqos/igb.c              | 1 +
 tests/qtest/libqos/virtio-9p-client.c | 1 +
 tests/qtest/migration/framework.c     | 1 +
 tests/qtest/npcm7xx_emc-test.c        | 1 +
 tests/qtest/tpm-emu.c                 | 1 +
 tests/qtest/ufs-test.c                | 1 +
 tests/qtest/vmgenid-test.c            | 1 +
 tests/unit/test-hbitmap.c             | 1 +
 util/bitmap.c                         | 1 +
 31 files changed, 31 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 96db7c51ec2..192a45d596b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -26,6 +26,7 @@
 #define BLOCK_QCOW2_H
 
 #include "crypto/block.h"
+#include "qemu/bswap.h"
 #include "qemu/coroutine.h"
 #include "qemu/units.h"
 #include "block/block_int.h"
diff --git a/audio/audio.c b/audio/audio.c
index 86e674410ab..b7a28f79d4f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -32,6 +32,7 @@
 #include "qapi/qapi-visit-audio.h"
 #include "qapi/qapi-commands-audio.h"
 #include "qobject/qdict.h"
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index aa1f8888690..2490e91802c 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -16,6 +16,7 @@
 #include "block/block_int.h"
 #include "qobject/qdict.h"
 #include "qobject/qstring.h"
+#include "qemu/bswap.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index bd852e538dc..8af13b7f0bf 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include <sys/eventfd.h>
 
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "block/export.h"
 #include "qemu/error-report.h"
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index d9d2014d9b7..a4d54e824f2 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -10,6 +10,7 @@
  * later.  See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "block/block.h"
 #include "subprojects/libvhost-user/libvhost-user.h" /* only for the type definitions */
diff --git a/block/export/virtio-blk-handler.c b/block/export/virtio-blk-handler.c
index bc1cec67570..3dd6c43af1a 100644
--- a/block/export/virtio-blk-handler.c
+++ b/block/export/virtio-blk-handler.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "virtio-blk-handler.h"
 
diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 778b8f684ef..3410daa6206 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -30,6 +30,7 @@
 #include "block/dirty-bitmap.h"
 #include "parallels.h"
 #include "crypto/hash.h"
+#include "qemu/bswap.h"
 #include "qemu/uuid.h"
 #include "qemu/memalign.h"
 
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 376b377698c..c3745f2839f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -28,6 +28,7 @@
 #include <sys/un.h>
 #include "qemu/xattr.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/block/cdrom.c b/hw/block/cdrom.c
index c6bfa50ad0c..70399a54601 100644
--- a/hw/block/cdrom.c
+++ b/hw/block/cdrom.c
@@ -26,6 +26,7 @@
    here.  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "hw/scsi/scsi.h"
 
 static void lba_to_msf(uint8_t *buf, int lba)
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index db221901cf4..a86f2b406b6 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -31,6 +31,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "system/block-backend.h"
 #include "qapi/qapi-types-block.h"
 #include "hw/block/block.h"
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index b6ad7cdb400..f6ff4ad2003 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
+#include "qemu/bswap.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index facbef3fc4c..34436705dde 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/nvram/xlnx-efuse.h"
 
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 0a676a16fa4..6acaf8831a3 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5a1fda38a7b..37f6e0702b0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -35,6 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qemu/bswap.h"
 #include "hw/core/irq.h"
 #include "hw/core/registerfields.h"
 #include "system/block-backend.h"
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 1782fb74316..a3a9f0c7efd 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -19,6 +19,7 @@
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "hw/sd/sd.h"
+#include "qemu/bswap.h"
 #include "qemu/crc-ccitt.h"
 #include "qom/object.h"
 
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 3044fa46081..68c95552687 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -29,6 +29,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index ae2c4d442a3..378f4d080c1 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index aea751fb047..f6454cd80de 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -19,6 +19,7 @@
 #include "pr-helper.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/module.h"
+#include "qemu/bswap.h"
 
 #include <scsi/sg.h>
 #include "qom/object.h"
diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 670139819df..97c6362992c 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -6,6 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
index 9dc24fbe5a0..28cca00b960 100644
--- a/tests/qtest/acpi-utils.c
+++ b/tests/qtest/acpi-utils.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "qemu/bitmap.h"
+#include "qemu/bswap.h"
 #include "acpi-utils.h"
 #include "boot-sector.h"
 
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 0f7f911e5eb..25450a296bf 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bitops.h"
+#include "qemu/bswap.h"
 #include "aspeed-hace-utils.h"
 
 /*
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 6b892ef23e1..e489d943312 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -59,6 +59,7 @@
 #include <glib/gstdio.h>
 #include "hw/firmware/smbios.h"
 #include "qemu/bitmap.h"
+#include "qemu/bswap.h"
 #include "acpi-utils.h"
 #include "boot-sector.h"
 #include "tpm-emu.h"
diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index ab3ef6f0c3b..64fdadac90a 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -27,6 +27,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
+#include "qemu/bswap.h"
 #include "libqos-malloc.h"
 #include "qgraph.h"
 #include "e1000e.h"
diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 6ab4501c6e1..af01d4c3458 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "virtio-9p-client.h"
 
 #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 57d3b9b7c5a..6a0063c322d 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
+#include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
index eeedb27ee68..71505356b04 100644
--- a/tests/qtest/npcm7xx_emc-test.c
+++ b/tests/qtest/npcm7xx_emc-test.c
@@ -19,6 +19,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/bitops.h"
+#include "qemu/bswap.h"
 #include "qemu/iov.h"
 
 /* Name of the emc device. */
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index 9e4c2005d0e..189374a9cec 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -16,6 +16,7 @@
 #include "backends/tpm/tpm_ioctl.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qobject/qlist.h"
 #include "qobject/qstring.h"
 #include "tpm-emu.h"
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 4867ccf08a1..8cfdc41d3ce 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -14,6 +14,7 @@
 #include "scsi/constants.h"
 #include "block/ufs.h"
 #include "qemu/bitmap.h"
+#include "qemu/bswap.h"
 
 #define DWORD_BYTE 4
 /* Test images sizes in Bytes */
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index 33e96b7c559..2a159e24dd4 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitmap.h"
+#include "qemu/bswap.h"
 #include "qemu/uuid.h"
 #include "hw/acpi/acpi-defs.h"
 #include "boot-sector.h"
diff --git a/tests/unit/test-hbitmap.c b/tests/unit/test-hbitmap.c
index a4fe0679178..d6e710b9cf6 100644
--- a/tests/unit/test-hbitmap.c
+++ b/tests/unit/test-hbitmap.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/hbitmap.h"
 #include "qemu/bitmap.h"
+#include "qemu/bswap.h"
 #include "block/block.h"
 
 #define LOG_BITS_PER_LONG          (BITS_PER_LONG == 32 ? 5 : 6)
diff --git a/util/bitmap.c b/util/bitmap.c
index 8d12e90a5a4..7095a0c398c 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
+#include "qemu/bswap.h"
 #include "qemu/atomic.h"
 
 /*
-- 
2.52.0


