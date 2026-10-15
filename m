Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D954CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvi-0001fD-Rt; Thu, 15 Oct 2026 14:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvg-0001ck-FD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:48 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvd-0001XM-VQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:47 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-53397325663so16455091cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087905; x=1792692705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=enGY8Mg8CmhgNg4I2/M1BECJVg3BBS7XEPbL+hW9bwo=;
 b=NoNn1XbIvwhgzUHdaLp9OgHKUx/y5pZar8gbQZp36FUfOK+xdej19qWei4I7xCjYEi
 tKx29rxBPHnfK640Tv/YCAlnkI++TUtjWNH5FqEPCl2dSiCXxkBFqSqqiKZsFDs6Krzn
 2VnOmQrkz1QggodnrQPKi5y6FM5Q25kpMz8utrSja82tOeG93/fcwQd8/bBlvDiN3tms
 zZaUeSilmaHJ9uNbSogl3GOs53b7HHIVLgGwOYd8cCPT2JcTf86cOkSYlyYX+o2K4D2y
 S4mMYl+JTjhNWYd5u5hvCp43ntVWceVIHsSbOCjt/Vv9bs/uqYTQja+WjYZxKyFIyZD1
 RnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087905; x=1792692705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=enGY8Mg8CmhgNg4I2/M1BECJVg3BBS7XEPbL+hW9bwo=;
 b=ugNwDIx4Z7AlVSFbaz3zl7Rzu/HAO+k3/4rB5CyRSpPbMstFrcZ/oe918qW2hLy83T
 3dQ86mBwiEb3IDE6fth2nJ2MU77FI+oJDnMeCZCRljJHb3O3OBdZR8D6oZMiHW5U8a7R
 eAZZcew2Z8Won++6MMcB8zjh9+ODuiqrLX8yan4GGnoTHzLk9WO0gfyz4DIzA2vBEKyS
 gffHjWHMSd9/mYeZUAD3EUbyutOs4obWgGKajDI7FWPgSs+C/3sRRsc9C+zEm6qPbB0E
 hqucWET/aD8fQMMYUP9bRlGnYyjKZx95kEhb9QiuZMhqvsJWC+lN7GLro/PSU/CdX9rZ
 L9jQ==
X-Gm-Message-State: AFq9FYInXstZIpbn5qg8+bYvHwOpUXllplfipM9j2MkVZusSfNeGylbe
 4au4oPu42i+icx1o9GMmldpM1gbHdIznjqySNMzEaWETIwk05xxmUB2c3SlmyX38
X-Gm-Gg: AYBFou33qD7uOSGwQIFmh1jxyI12om37ygMdkqSy7ua6qSqhaqu3MQH9InpOEHK+FkO
 zNBlkuWKmOXd+fzpP8serH2b6NQu5wNblB3AmEPbpQXmAf96KBFGPp6Oa+/zXAW2OWigMsBJrp8
 65AlaIPITmBUeV8K0r2rgY9v44TI1WdefN7gKm6UAESAF0fouVTiedG89lDgQcd53deFzG/FV3M
 XjltB5gewYHO883Gvl1kcJEFbqmg3y28hmoorXziwiJkA04TVidbI4k4yvwnEKU+QdNM/ayIPhr
 CZT+FmDUTF9g1as4UZL8wipceIjgh7HYIRIoI+Yfo0GMb7QolGTuCHZDJXqFJ5tqL+/dR2i+f1U
 6dmj+R6KyR/9ByQoEgGfJHNxTvdjBAMuzXd5MOyQWDQ5pZKXzTrHAdEEzmIgw2DIe+WYYCEUnB/
 xwqfyMKmMyMnEfhxND0LHqEVNX58A+A0htoMDM9ojoSW7/WTqoeMLZfYmrmeGfsMr4rSvoaoyJK
 /2ee3UcwpTVGRVxKL8DMesdSC00YRBSasvKpS79MxlX5ibJnguApRhlSoKsSDZwrtWowA==
X-Received: by 2002:a05:622a:98e:b0:530:ea8c:1b6b with SMTP id
 d75a77b69052e-5359f498093mr317451441cf.3.1792087904887; 
 Thu, 15 Oct 2026 11:11:44 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:44 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v3 16/16] tests/functional/aarch64: add raspi4b GENET
 networking test
Date: Thu, 15 Oct 2026 14:11:21 -0400
Message-ID: <20261015181122.60608-17-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add test_arm_raspi4_genet, exercising the raspi4b GENET controller
end to end: boot with a -nic bcm2838-genet device attached, confirm
the guest driver probes it ("GENET 5.0 EPHY" in the kernel log),
reach a shell, and confirm the link actually comes up
("ip link show eth0" reports LOWER_UP) rather than just that the
device exists.

Verified locally against this series with the exact kernel/initrd
assets this file already pins (raspberrypi-kernel_1.20230106-1 /
groeck linux-build-test rootfs). The link only comes up because the
MDIO patch handles the PHY autonegotiation-restart request (BMCR
ANRESTART) correctly; without that the link never comes up and this
test would hang at the "ip link show eth0" step, so it also serves
as a regression test for it.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index bacecbbe9c..f703fc69ae 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -109,5 +109,35 @@ def test_arm_raspi4_initrd(self):
         #self.vm.wait()
 
 
+    def test_arm_raspi4_genet(self):
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2711-rpi-4-b.dtb')
+        initrd_path = self.uncompress(self.ASSET_INITRD)
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot',
+                         '-nic', 'user,model=bcm2838-genet')
+        self.vm.launch()
+        self.wait_for_console_pattern(
+            'bcmgenet fd580000.ethernet: GENET 5.0 EPHY')
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'ip link show eth0',
+                                                'LOWER_UP')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.55.0


