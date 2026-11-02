Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEF606A339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OK2629aW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDA-0003Dk-5V; Mon, 02 Nov 2026 08:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCr-00038v-4P
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:14 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCp-0002GX-7Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:12 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2925156f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626570; x=1794231370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QuYSi0zSMrGa43TVlEojifZzbxnd9SDw0WW04x9iRW8=;
 b=OK2629aW8iNS0To+7BDEtwho6i5PkF49bElQYKozmRZQFc9N8XgKhIYmloyzSlpgQ2
 pDkIsTFdy/X3YM3Q1r7dvCtVdzYRLzGYC7TTnENN7NllDoRhPF9ztWXUktJzbFa/tLJE
 F1RThTXmwsfiWe2C+LXHHZljcSWVAWa0q6vnYphgl6J50xtHkE6hN8hCPqaWEXSN0QUR
 yn/e89ZO4Nz+HR+cgk2O5eJHoXnfdWvo5ZDGpiXxc14R3NFo2xB/wLqdeOIJkAEjEHaH
 aqCqMTR106W1pIVn82y7oqcqTdSutfAQG64+IyU11nbu8PT/xvOn/p0jwLKScZTEkTUs
 SPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626570; x=1794231370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QuYSi0zSMrGa43TVlEojifZzbxnd9SDw0WW04x9iRW8=;
 b=d2TmP6PsDnZ5bT2r/4vFaUVko9K6hXZ6Wmn2PQDiwN7vLUjGhGWMjpwS+OOdDkjBjs
 JgeYnChKyCSV6VqidVHBROGERixoqn++rSDiXyPPKA+tILDb+sgQ7+AAYNkrN/lNY1RM
 17ykmGVgGfJhJdQxpkX8lvw8Er2svbZMYOZBN0vSknTqEvA2HTPE4O/EncmIEuw6pYeg
 C8cnNZE+OvZjEEMLFC2bROxzlS5riDSlFxuD08OFi03gb+M4/T9u73P8dbhK7dljIOOO
 +mh/I1RGp9Qil8nQlzn0eR8LUPBUvvKCeah406kvoyGYkx/HhN9pckqca8fkxrvG2zzJ
 YLdA==
X-Gm-Message-State: APuU4Z8dgOvAdviVI1PgBKPgRFuotNq7J5tKeq/1qC9dLvCtoOFcHsm1
 rM8nrf7hScOR86Ase7okyO6A77AMi/snLKZI6YoV731C+Db3GFX3KJtjBeNy77TThwjrcDEOcPM
 deqI/heY=
X-Gm-Gg: AYBFou23R+VJbBIGaF3coZ0n5zimdrpTFDMrPyzYi2RdrpbbVoh0aBjA+1nnhoTe7g+
 vQ6CaVUB4MpR0a5waMzNxDHFKavECaZSUDalBcrtK2Y6f8VAXk73ZcDBUaSByTvvCGt+EHD3mTi
 AxdQw/B5d4eJUhDdi6uaEcgUu/xeg9IZDmVufE3i/vpV3l0JkisKEbzC7S+K8hIJA/p2hqvNa5g
 M5EYdPJsJ9HCsCLor2W46OUBMLH1s7167MAg1k83AGWIefPcNbs1DYP8RS9xuXYWOrQnhUdrbCt
 t9yWyt0GB67Hgj4xnmbSqu9aSxJswvis/mXG2drSZRn/dlByqXSCNePeHKS9eOBHFBayYaxChE0
 GdCyjpsUrWI+f+X/b2bHk7AAbO770ZRc6Js1ZJYCg3lO3+ukZ3TPz7u6jhWYohZEemYvWRXBXfU
 1DrwcLwfvkoAQkoecQoOacXmSHrBc5hJv5cTvFh1rBdjRt8a1C/K1DR8DnBo1DGTAFPsmLUEfEr
 nCL3pr9KOxWGhQV3fzFxonWjxDGF7hKyzSEaTVwFCw6fPViWFodQPV8eFfNTs0v/gRTlSQDjJLS
 XbrxnwU3wSgAFTRTip32UVlPJ0mkifFN3OMN2NAsN8hI0asDMqQhwd+/FCLc0uCdYKNoT59OxFv
 6aPBgC0vTWUKTK2jyYxprPS2uldY+rkcC2Q==
X-Received: by 2002:a05:6000:29cf:b0:48e:6f76:de9c with SMTP id
 ffacd0b85a97d-48e6f76f453mr13432006f8f.28.1793626569780; 
 Mon, 02 Nov 2026 05:36:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/47] tests/functional/aarch64: add raspi4b GENET networking
 test
Date: Mon,  2 Nov 2026 13:35:17 +0000
Message-ID: <20261102133547.1375701-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-18-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_raspi4.py | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index c61014b5fa2..014be0507f9 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -116,5 +116,36 @@ def test_arm_raspi4_initrd(self):
         #self.vm.wait()
 
 
+    def test_arm_raspi4_genet(self):
+        self.require_netdev('user')
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
2.43.0


