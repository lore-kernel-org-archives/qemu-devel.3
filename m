Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE63CCA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGIBn-0006QX-EX; Mon, 12 Oct 2026 11:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGIBg-0006Pm-Fn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:43:40 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGIBd-0004TM-HQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:43:40 -0400
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so12730265e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791819816; x=1792424616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvxLkYLFxBz+kmta5sRtklppBkoMZNtdkurTxLQZymc=;
 b=vTCfDjkwH259KLDZejl8AZDWih6Jv7+OJ85N8NonG2mv7tWbH4rut+qUP78D5vjWtb
 PVQIsTqOtx+parXBA91m6OMhvTijrFYoqnBmW4yvjGPuCu4OR2LlMgY5U64tAf2P7qMe
 tPNjRe5UGclQsYth5PqNJMI5DRDWRTKNK5uo1eXm+nUd+6lMsKbW5k3zgF4LLpn2UUPR
 Ffhtd6a+NYwRrCwYNsxTlaLctwJzitR5Pn7SOCspeJlHknv6CUlBoZdms/6Du2lziz2F
 GT74jdhUYYBcC6EIhijjIgToxpyZCs2VBFw5nlqkdZFiW4g50a1dG3XjZwq8/zDx20p5
 MoXg==
X-Gm-Message-State: AFq9FYKVmP3PO9wFja9to68xRNqQtyBfZ3renpHs/vGCxDbAKTEnGzYJ
 F2YXopPGEkgYN3XU9lR4rzK7RTuqZ9oBtNddlmrXjZGSzWMtuDuEGmnIxzOoJA==
X-Gm-Gg: AYBFou3RLwNhREKuCYfQQf01xdpUHJu1DbQWT1BMForIA48aqv0OUui1p94kSwEnN0s
 Ms4gWxNG2ouKWdrP0blLfHGB/8RT8dykM9R8L85ZIMQxtufZl2ueaGjdIxhcWvPimG8n9UCpg5W
 OZ564uxWQFZhsW7JRP9DEnE7gRJA3dvHtIP0t18if4MMS0AnDdnb0pygbY2D3gCzsBRBhmGDNeA
 yWprx0mM9XZANRPko8HtsFDs2x86n5VJDy15HazT0ejgIK5XssNzdkP+X+DMX5NmkFpWZamKvB6
 kOOcxwL2a7p6t8aYqSzSKVJreOMzoIUy8XfOaWw9KeTh2G4st5m0p16n/MLBKyf58IDFrIVbr38
 G7vEDAAtq4WxxGhTp9qTVlX7zg+iZZdFwdrispxHMkAvC8FXMxdKFhiHlUJw5d7XRXCRS969sik
 N2TG2gQU3p+hh+h6SHNDYWMXcXR0rP2XqXa0hES5YS4panbDXJJjRvq1fFHeFNqjQ3vNTOoyaC2
 vk7cMgfvnN4uA/37tfQ806LowB8Dtfnka5w8j52UI94ZA==
X-Received: by 2002:a05:600c:46cf:b0:49e:8191:e5cb with SMTP id
 5b1f17b1804b1-4a18e4a3ac7mr203566265e9.5.1791819815754; 
 Mon, 12 Oct 2026 08:43:35 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm549923185e9.9.2026.10.12.08.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:43:35 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:43 +0200
Subject: [PATCH v2 50/50] tests/functional/arm: minerva: add BMC boot test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-50-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815522; l=2482;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=zMnHp1SdNieEAjweeitFky57rPPnAgy18OpmLaUpJ1g=;
 b=nyi8/XBH9UGmX2jVpKGkPotKXBP+6qgCH8/kFF3zlDpCxKWzlCrCE5166Mwx1mGaS3fPQdgBt
 lC3vUfcIfIODPHsZmTDAwhyk09JVuJuoJKLKsYYO+a267DsTK/gtylH
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.42; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f42.google.com
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
2.50.1


