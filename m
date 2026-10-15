Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221EBCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlk-0005Z8-2F; Thu, 15 Oct 2026 06:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIih-0000JK-H9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:30:03 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIid-0004e2-DN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:29:54 -0400
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so16849385e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060190; x=1792664990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yjBmG+zuYRbjC22UGQURaHMUPP1uzHBYq+b+aCfLeJc=;
 b=p4Dk3dtvFprpOGgZEBX9wMzappobbnlxH+bqmF/4BrdIgGkwXZUXdHM8S79D7bmLSY
 rfAk47ipsDtPokgUuw8OgQbl08A11EkmnDshdPZk2qXfkrbtA3yWk05zVZ/sn8hwQJUH
 hzV807e680FCIb15t38fBp0G9qUrXM5fd0T18vj8kk1kc0gMttR6WWZVYtU90zTIpMvX
 5Bq/LPL7/sJhH/xBKfJtspTJaYt+X0EwiVViPXFAA5sPXkKcZ58PpPT8YB2LPwFAquCT
 83UonhD1WQ22jlfXh+wp6zQkyF+GGwMPGZmLPAWWH+TVFrv7UQIMr796r4coStAlNYZz
 l3CA==
X-Gm-Message-State: AFq9FYLoaC/MmyscLebS00mivjb0gSjqlMssQc3USo+GekVewhM6jk+u
 CnpJ6tGhHcctIqlKpbFg2iY6xN1UQHvF93wjfh04znLfKllrZvxLlehDBmrkQw==
X-Gm-Gg: AYBFou0d7BAXD/4Qv5lIj3ysi/a5Ry64xHxltaD6KILyehoHbVUezNOYBhpsrdyCM9a
 8DOimRJgqq8RieDePrDkga5+2ZG/BpUZeXqkea8u2C/sNOD8bIs73csVixEHJHo2D0/9e7FP9nW
 6Vp8WG8tLajMueeM68vXKzsSvktWc4fKMzHvA+ZZ9oh4FZ51yCqWp0BM+uAA81FWc0J9VYsjwPc
 Eqg9Rq5PQxQMatgxW9L7/Vob76F4tdZxMzSSIa6cP4aMF3p9f98hZRLqmfuCrSCfNB0SFkPwMFi
 m3GfpMwDU3IlQJtTzK+uaDEbWHY9UBA1d0McwV6uJ906ZTQlyi0dEYHNREsgMYJivKkoEnK+0+Q
 rSem6yX/IQdbHyvxKjAat9GwIJDbyBcBGYAHYohtVj9zmQJnhLknNM3uMYyi5sCE8BzNLBaAtlz
 la+HYxAswnQmGzAdNlx3VOF1vGsKFcBP/GyctCG+lengQDNqKcoX7DWB0j26wb9hTeIQpEWOjPn
 47aOB8XPZUDUU3ATA96F8edy4l7+ldvLOK4MnHI397HuA==
X-Received: by 2002:a05:600c:4e43:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a18e4b67e1mr365550045e9.22.1792060189894; 
 Thu, 15 Oct 2026 03:29:49 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd5f4319sm27199325e9.0.2026.10.15.03.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:29:48 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:28:37 +0200
Subject: [PATCH v3 50/50] tests/functional/arm: minerva: add BMC boot test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bmc-minerva-v3-50-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056477; l=2487;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=utRMkw0VXmaCFdITu3Kg7E0hjjFW9yC9c7a309pEC8o=;
 b=SABl57njXkNYtVhmFAMHi+9+Vh94V3yFVOyiJ6i4w7g/HzNMH4rEXJxxNzKHKDhDsKospncCz
 2RDPbzyCefZBmJQPxlpxQ6MtV28h4038LwoDLqgRGUTdZMXmVJn+Fja
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.44; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f44.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a functional test booting the Facebook Minerva BMC machine.

Note: The boot image currently lives on a personal fork; a TODO in the
test notes it should be relocated under legoater/qemu-aspeed-boot before
upstreaming.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/meson.build            |  2 ++
 tests/functional/arm/test_aspeed_minerva.py | 30 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..dd1ddf7f6f 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -16,6 +16,7 @@ test_arm_timeouts = {
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
   'aspeed_gb200nvl_bmc' : 480,
+  'aspeed_minerva' : 480,
   'aspeed_rainier' : 480,
   'bpim2u' : 500,
   'collie' : 180,
@@ -51,6 +52,7 @@ tests_arm_system_thorough = [
   'aspeed_bletchley',
   'aspeed_catalina',
   'aspeed_gb200nvl_bmc',
+  'aspeed_minerva',
   'aspeed_rainier',
   'bpim2u',
   'canona1100',
diff --git a/tests/functional/arm/test_aspeed_minerva.py b/tests/functional/arm/test_aspeed_minerva.py
new file mode 100644
index 0000000000..925a82b139
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_minerva.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class MinervaMachine(AspeedTest):
+
+    # TODO: the boot image currently lives on a personal fork; move it under
+    # legoater/qemu-aspeed-boot before upstreaming.
+    ASSET_MINERVA_FLASH = Asset(
+        'https://github.com/eblot/qemu-aspeed-boot/raw/refs/heads/minerva-bmc/images/minerva-bmc/openbmc-20260720025047/'
+            'obmc-phosphor-image-minerva-20260720025047.static.mtd.xz',
+        'bd713df39d3c09846299a2377315465187a4dcd33c29d3b3d683ef13b59f36bb')
+
+    def test_arm_ast2600_minerva_openbmc(self):
+        image_path = self.uncompress(self.ASSET_MINERVA_FLASH)
+
+        self.do_test_arm_aspeed_openbmc('minerva-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3')
+
+if __name__ == '__main__':
+    AspeedTest.main()

-- 
2.53.0-Meta


