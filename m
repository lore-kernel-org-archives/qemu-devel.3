Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6724606A324
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IktFnan9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt2E-0001fN-VF; Mon, 19 Oct 2026 15:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt1G-0000cq-4S
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt1E-0003Ci-BO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so18818895e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438055; x=1793042855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OyGDZraoX18hxB+U7qbf5uZlUEfq2P9vYKMBAe8kBEw=;
 b=IktFnan9g52+VfLvT/aVAOgJIW1qTB/KI9ib8WIxfi5xFfKUtU4FezIdignybdTSv4
 G+1xp3sO2ae4jRoGTS8roJS5TA/KvDMijn6gfzOSztqcqPB8qXdpn/f78tdkj8WLabBu
 30aZwimm85UQduI7uaObxmFTrdyCl0wN4JVDn+AoLEcnkjvXuWRRnoXh0eUWsoTtm4oC
 F8zIEwkbC9F1ScgbNMwiA4oeyGWwSZWsikem+CJXn5Y2f32YrKcANR/plOril+BdG4x5
 mzNFeYBcthWFd+1bAr+POzLXMAu7N/CHEqTraUzVWxu1f6LEh24E1IeJD4LEkHCJ1pnv
 zRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438055; x=1793042855;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OyGDZraoX18hxB+U7qbf5uZlUEfq2P9vYKMBAe8kBEw=;
 b=1DaBN31Gg1B2XgyBbprCdml7fPzdXZG0FjKQWzfaVI1Jrqt9qUY6yEcZS+iKcUQX6I
 9LF+AgpzmeilwM/j3FXNXwpiyYWm3xOXAdvEov3LbDlIOMh4YOMiuXA/965IYDnOHstf
 DsBywQN+2n7jiJu7JjFAQQt+Cgcaa7K4lHBvRzcKtAI3HNk+wOWWbju66bFlMA7IQ51V
 GIATJH6iK+dts4Gw6aPvS6wKRzqKAD0OoiPhA8M9l61yhLUiYs4XpeR1mYgruSgI+sJR
 xwVrY5OBEanuPQg+WU0z7vInKDPYUIt/RoMQ3N6z3uUfTWbmTJy27C0Mjk/IgF1zYp/F
 E61A==
X-Gm-Message-State: AFq9FYKGxhdBLN8KoxuHepagSQWvlKIL4BtNlqAarLVAsylKsLq83clk
 iXxPuTt981ogQ1BhO/gQ99sUXi1Z79w4lXRYe0p0e6whpPBV1Ld0fctfoCwe+YYNPgk=
X-Gm-Gg: AYBFou0WFd8HzjFSjHSH9IvjZfT0rEo84jMNBuFbkf7RpQclcr49xegwFlA7xtjPlmx
 oUU9QDT3293Pk5ImGpg62FAE+AUZwjOZZTV6zfVh0m6ONlKXkwnPE78DTZXChnHpRGGHgJXa/rp
 zMKzNv/4+4OyrXTAdhoS06vKgjfnYynBz3shEa8H3zdBscRLq5FXR9CgiqIuydXX6gDghfXZPn2
 wYYP6JCfVe0SkTi9VWFzGGWH+DspiTIhg2F7XOCBP58eyGejxWyDMQWbDNVckLfurnE7DWhoh5y
 qwpvJBIryIf8T3lvBAM3c4jHIr0ObN0xp1PMAMk0kYtcaWW/aICL1ihANcZYnJcqYw0pRu+jUYW
 Nu+RXOP43aJZ6/h6ILwXCGU7tKyxIEPAIgUmA/o+H7lbSh9to7F9AKgVuTNj5QsbVXPc2ZNhHjF
 kcZrarWu/7seFqWss653gTbKzr1rhINEkF6EKdsnKy2SbZODgGw6v08XnOG9mJHvuyDnPaSzM51
 QglMGK4
X-Received: by 2002:a05:600c:6815:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a1d762367fmr188306815e9.34.1792438054739; 
 Mon, 19 Oct 2026 12:27:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d699dasm13426065e9.12.2026.10.19.12.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A77E25FED7;
 Mon, 19 Oct 2026 20:27:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 16/19] tests/functional: add tuxrun kvm gdb test for arm64
Date: Mon, 19 Oct 2026 20:27:01 +0100
Message-ID: <20261019192704.3220373-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As with x86_64 we now have the bits to add a KVM gdb test

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_tuxrun.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

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


