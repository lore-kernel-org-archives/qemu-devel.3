Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1704ACA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSg-0001Q6-Eq; Wed, 30 Sep 2026 12:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSd-0001IC-0I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:15 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSa-00036F-Ku
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:14 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so24616185e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786831; x=1791391631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hN4OV+wI9wzixf1RMjrnP9cuocGcMS1AGAK/zi0H+YE=;
 b=vSsg+DOYhW8IHES6t50WKyUxWK9+migX6842M3pwiE+L3TP1BIvuENfZAXHTpIUQxg
 PsQ17glzNELaKNeao0Fbtf5FDky9BV6hWt6rZW+H0EJNd3ua6/ypZD7zlCmHRgvjJ5R2
 W8z8ntMOLfh7aoL/q+mDcCZGltpqzDL9eiXqJNzE6h9JEnQYVBRU7R0z/zZCV9CU/8un
 TtQdWsxroGq7WmXy3mkAtmqIAtAHcGx72ldurMIIleAVFt5+JCN8BGZp8zMsdTG7fIub
 O6unX2fvr5ZzY8e2esiXhFMBkZrDGkr2PHQABVKsyOqHUKMHqhfP8zX4VBCRWUNu/4s5
 32AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786831; x=1791391631;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hN4OV+wI9wzixf1RMjrnP9cuocGcMS1AGAK/zi0H+YE=;
 b=GHsjrVvg8VfLb4pEZYYmBQHxTxTph9/e+nlzhvqObz5c6Fdqu8m9vkbp/RUIjYQ8GZ
 gYPxPk88SXTPDU5KVwHTmVtUsCM/frQEviHMWIKqFc+QY8X10loSvsi6Q4jQVGt4CPrn
 ivuB0OKMHONTxBK9hrryzcxgxOOhJ3eFbOUO8zy1p1JH9W81e9JzOhNt4DovEaKtPgUR
 Cb8NCnUxUNXMxaEN6cWYT28G2h/7a8gFtaLSGHI27n49PdiObVM7yPs8kAqiFNT5pw4H
 BfULxYo1o81yOfKrEah/1XMgmS2Sbr14rofJRuW0Kp9+F32qvfXUMNBtQj/AwnbLscDZ
 Quag==
X-Gm-Message-State: AFuF++lDRJWTSxwV2awQUTXyRE01Q+IRx2dBl8gUKe/jwO7x+tkoJgiP
 TfIPm1zF1dPlsh6GbpPHqQEtuXlK0l192i6tiTfaB5upqBRm55CiJbYaVKQKIRporhI=
X-Gm-Gg: AYBFou3WDxo4F2y+yQp1/W7txtW5C8b2TQ/NkR88+9r16OR6zr+VpGSPLH9qIL5ZY+U
 rvXqB8eUzvc51Ta1itaNms4qvTqMBG6eeKzpxX+Vg74/Rvvu715+4Z2IGn6t9z4cxaCyW/G6haZ
 Qst5+5fbSd+DCR6l3jdkJ9rnqbjv6FKVbOsapCfnp8I/M4swbD99ZRdhnNdJ5nv7FxNC7zl7Q+B
 nLXvPFwWo7HXegZCvn3sev61kLFOSNEEbxdadA7P62cuMiw43EAawkQy4HZ8qXAWNvY16WO10bz
 40GvWZhVyv0KFYOXOn8Y8rCKot56Bo3n9aHsRAMEhbdbUFbRmVIpLFVHSNdckOA8ku9HHcZf3j0
 0A+/pJMxB6TV4FV97KxxVmhIjy9t4mD3sDyfVWlz06ms1wXlfAw3PlVEvE4KqxESydyyr/WLpUz
 /mZAaqEQakiPQqh4/T7wsiydnBqRM+4qQXzr8NVLuoEsiyIr3EC1qHO1Fg3Slfd4biTJs5KQ==
X-Received: by 2002:a05:600c:4e41:b0:49e:73e7:888c with SMTP id
 5b1f17b1804b1-4a01ad8da72mr35397365e9.4.1790786831026; 
 Wed, 30 Sep 2026 09:47:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb7b095sm4779325e9.12.2026.09.30.09.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:47:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09ABA61A5B;
 Wed, 30 Sep 2026 17:46:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 13/13] tests/functional: add tuxrun kvm gdb test for x86_64
Date: Wed, 30 Sep 2026 17:46:49 +0100
Message-ID: <20260930164649.433573-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

With all the bits in place we can now exercise the KVM gdb interfaces.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 026b373accb..1a1138d16ae 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -11,7 +11,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingEnv
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunX86Test(TuxRunBaselineTest):
@@ -19,6 +19,9 @@ class TuxRunX86Test(TuxRunBaselineTest):
     ASSET_X86_64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
         '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
+    ASSET_X86_64_VMLINUX = Asset(
+        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
+        '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
     ASSET_X86_64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
         '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
@@ -47,5 +50,20 @@ def test_x86_64_kvm(self):
                            drive="driver=ide-hd,bus=ide.0,unit=0",
                            accel="kvm")
 
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_x86_64_kvm_gdb(self):
+        self.require_accelerator("kvm")
+
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun_gdb(kernel_asset=self.ASSET_X86_64_KERNEL,
+                               vmlinux_asset=self.ASSET_X86_64_VMLINUX,
+                               rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                               drive="driver=ide-hd,bus=ide.0,unit=0",
+                               accel="kvm")
+
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3


