Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D075606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gb29s83S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeP-0006ip-NR; Fri, 23 Oct 2026 14:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeM-0006fs-Oy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeK-0004YZ-Jt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so677643f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778751; x=1793383551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tIt1MoBw6d47x/eSKHc3IPqV22aXtKNe7+mP07eYspE=;
 b=Gb29s83S9EQEwAWzmi+jYekUN/sJ9BRTKyGXNk0Fo/csx5ZV2kQtJXYdy3vVzG+cOs
 tXOYA0jRUF1biJ4BfBe07M4049kQfyw723pw11eQqIpKa+DAzmSC8xucd0EOMnUSF+hU
 4IK54RVaKcbqMSNOXRCg16hXcXeQurf9H9gzMYpCk4DKAepjiC/64R7FyRAnFjag6CNU
 PZdCz96l0nLhziZurxnuXFghr3pIgErEZpvMUl5V5g/lT7BTh+J6bhlqj7Rco7LwmTGU
 GSXVl4FZpiFyhtaUp9MDULS27SI4hJEeZj8wJhViSDcm49GWi8sh/DOh59Sk72LjdkGZ
 HFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778751; x=1793383551;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tIt1MoBw6d47x/eSKHc3IPqV22aXtKNe7+mP07eYspE=;
 b=rbhRFo1yhIpBuInDgjmjgwr3FIinqqUTMAs1FYah4i3rTB/TJxeIKyi2jnLYDoUiPa
 NYDTMZwye1L7xQ+iZ/DXFshksYAU+GFdq3JzZtkIomnbyoG6XNsxxJ99cDQx3bVZFbQr
 2zX9YPypoIisTfFnboIoiX0prPJoW1QuxAFo59c6wIqNQZsszSYEzAvMpnh0t9AdZ9kq
 WblmWoCD2dxFd/xC77H0QKPaoRDcFo8zB/HMn7Oe0TTUwt1QFf2wyqxTLl3wG9VTSIXf
 TtDBXNshKoT/pldAYeglaG33DsUiG8s2SrninSvOwlrbdCfbACNMxz61Z0l73XFQ+Ezv
 XXgw==
X-Gm-Message-State: AFq9FYLqUeJJ1TvJV6s+E8QdGBCEtQStQ+4zoItc3DNYcpxQpu8Ppoiq
 cjm1ZjovNnxu+Fti0c2kfTdATwOSG7EzGdt5X0lGZx0p4BwrmrfmhYEmAGzJtE6RNEs=
X-Gm-Gg: AYBFou29JWMP5C0s10Fhg4ITp7sCib0/PGSLzNbFuSh6qY+iui05J9DGBxKVAtsxmqD
 uYHgB0/G4hfL6u2pISXpjpn98c3iQ5Nf6KTMJvkhVy2MsA+m+YMo08XiCEkOzZvOjDTG+q4vLv2
 DHTSBI7haVI2UzYaGRomfoy4iVgnOrz85V7eEMvjigK65mUReqIs4hOOJnQb2CvpTFBOlLlwQTE
 09zkqAx5cYbfoW9m7s8YRq6dS51WTZXHleTF6hTtUeD3kIyEWq5WFloM+tMq9gOQf8VImDwcEeD
 8S4cdQbISXlY+dj3i9/KPUuoDjSDfo9dawMJL5QIgaL0fY9UaqA4QceB3mnkmy3AgkUq6L3Ltlp
 aLjDLD428NaydcIzAkkI4ggmEQSKFhJ6yRzhuLtWMSYNjD2q0fqtYaVJzNh/jzlYs2HFadccAtu
 vaL5+hI/YR6KdRj019T/KI3eflJdmLIIVmfRzK1GW0NJGLj85ZqKfRPG6iyB/4Vj2kYJUbAaIVZ
 AxNkfeSmNIj2tUS+mk/m3J55XOPypyTP98gqPXJ881kkm6hNXWfeOo=
X-Received: by 2002:adf:fe8c:0:b0:48e:3085:7cf0 with SMTP id
 ffacd0b85a97d-48e385a7627mr3657444f8f.51.1792778751031; 
 Fri, 23 Oct 2026 11:05:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37ca2asm1374011f8f.8.2026.10.23.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B1D5611FC;
 Fri, 23 Oct 2026 19:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 16/19] tests/functional: add tuxrun kvm gdb test for arm64
Date: Fri, 23 Oct 2026 19:05:34 +0100
Message-ID: <20261023180539.1574134-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As with x86_64 we now have the bits to add a KVM gdb test

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-17-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 6de02e1d8b2..2ff321582d3 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -11,7 +11,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingEnv
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunAarch64Test(TuxRunBaselineTest):
@@ -19,6 +19,9 @@ class TuxRunAarch64Test(TuxRunBaselineTest):
     ASSET_ARM64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
         '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4e')
+    ASSET_ARM64_VMLINUX = Asset(
+        'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
+        '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b85')
     ASSET_ARM64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext4.zst',
         '4ab8cec9d1e17dbb1abdf2ae1939ad4f9d0dc2466230f6a119a7c1845cdef0b1')
@@ -42,6 +45,18 @@ def test_arm64_kvm(self):
                            rootfs_asset=self.ASSET_ARM64_ROOTFS,
                            accel="kvm")
 
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_arm64_kvm_gdb(self):
+        self.set_machine('virt')
+        self.require_accelerator('kvm')
+        self.cpu='host'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun_gdb(kernel_asset=self.ASSET_ARM64_KERNEL,
+                               vmlinux_asset=self.ASSET_ARM64_VMLINUX,
+                               rootfs_asset=self.ASSET_ARM64_ROOTFS,
+                               accel="kvm")
+
     ASSET_ARM64BE_KERNEL = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/arm64be/Image',
         'fd6af4f16689d17a2c24fe0053cc212edcdf77abdcaf301800b8d38fa9f6e109')
-- 
2.47.3


