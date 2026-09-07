Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2B5C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ca5-0005SA-Kb; Mon, 07 Sep 2026 12:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cZq-00054J-IB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:52:17 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cZn-0004zs-P9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:52:14 -0400
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so44880585e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799930; x=1789404730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvxLkYLFxBz+kmta5sRtklppBkoMZNtdkurTxLQZymc=;
 b=Cl2YPOdrlNQR+3oVGuWV5kXV70D9W+27V/ve7vm7hSrk8XDIgW7Qt8lGJp9GRddWyX
 hL4p900k5UmEn3wpWk3UX487glKbITRJbm5wslVQT5bZ7IR8Ym0NUeqFibSuEpYUH+It
 3Qlm6gS/n8QWgbUhhjRPiZCQB0FxwupwxVyOanv3wrf1yxrtvNfcnYuwjcfj0DS8rggB
 ggR/6oHHkD3dQNmZxVGXw7fD4gaDtp8f4wqYi7YjkxvgRsykTu2v423GhMdTz5Phl5m2
 9KQnmeKhP+pE5dXDdyqwlmwSlJQIGceHkwrRJO28y2IuWXppuyeAW1VENYbUBG4i6C2U
 eNJg==
X-Gm-Message-State: AFuF++mu5m7FSWJn6JSFVPCH/oKINrrmTLXSenVXnKYyIA51Y/weDgbT
 fQO++SX0de4AoSceY+jSdpgGUwC+qSbij4vhgif5tqDfDkRloQsUq7aZ6Sf+f/0+
X-Gm-Gg: AYBFou2TTfMUps4P+4mhtvYhrjyOS6ka5fIfWnEhbYaywpZFNc2TpKNWGbxQKHSUtll
 g845H3Go+gvEzfnipa00E9CxpFngj2LLxI0Nb+KkMuhJr0Y5IejTcdzubX3x45ke7dYFC3VwBVt
 eJUvJa4S+7FEMdXkz/iOjn/oyq2hxX1rb+LJrsypt2ZGJdfgRHlZTGCwdruKhzFqVXOzs9SAZUF
 ogJApn2Av63AU8shQES/8R53mf/YqoaNsEsMa7E9AwLB1I/ptE2zC/qaqlt4eHTaD9pL/wbJtL8
 A6r/KX9+6ox92Sx4Y8cB63pQgPGC+/sn9zPhX8b5dP7IjN9VninwoyCvxcHohkNXXoi+VTLUe30
 IbsRqrJsy5t6HwSMQevRZALrqmkU+BN6zCBk9MbDNnO/ttNVVyxhbaxAJ5fdDkiyvHHp9hRB62I
 Geq5arxyADw8yXdDgBOUWxYejBjG/aJfvYQqdEn9tJPZI4tXjNEzq6pqrE+1f0tjG8o93j8fLJH
 XrrN3OJI7769mSMNdKeuSgU04NwphktlZY=
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49cf82a514cmr244391835e9.16.1788799930026; 
 Mon, 07 Sep 2026 09:52:10 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm383936695e9.10.2026.09.07.09.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:52:09 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:42:40 +0200
Subject: [PATCH 50/50] tests/functional/arm: minerva: add BMC boot test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-50-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799323; l=2482;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=zMnHp1SdNieEAjweeitFky57rPPnAgy18OpmLaUpJ1g=;
 b=V1QzQMxFouIxH4+6g0pVsz7I5wTEN7pR2ggQuv3Iq8sMs0tlCTfPc+Z4JyM62A5ZZPXCfz4/Y
 BQs9aZ1zMwsC5KjI+t1YSLVMlBc+KUKDXGAHdGYkT58OSPpETyxitFy
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f51.google.com
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


