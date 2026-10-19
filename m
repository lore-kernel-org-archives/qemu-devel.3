Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BC606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B9BP7uy6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xItAb-0000wR-0S; Mon, 19 Oct 2026 15:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xItAG-0000qK-GQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:36:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xItAC-0004kl-DQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:36:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2055939f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438610; x=1793043410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dpO5hniEQRNAl5erttXnmgUUc1WsysxeDKtd+oAaW6o=;
 b=B9BP7uy6x04Mp3/XYIGAK/RACrLr0QWwKNm3BqvzhZ65hfkWpiORV70NvSQ5IZk7ot
 b0Pzru2O93lH5KL4aUiy+9mdf6bKcG1D7QJbZPi+ZdTjIiP9IfxT7jWXlQbXYeIaP1CO
 JwV6nOCIwiqQoUMQiWeHgODevI/fEHG67ZHbBMXLzDVPmaRLNPCqh8J2tl5pXemog0uk
 UpPd1CIPaBRoHQOXTM07z/sHUrSSBeRQMP+OQ14eN4arUv0mrUYBuy6M13udJtlLMuqZ
 Z6+0lcolo5t91QbNmo89LrUzpZfKwPI9kYDdSixDdC7DmVaWrQnE1J34KhkqRk/nXsFw
 4s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438610; x=1793043410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dpO5hniEQRNAl5erttXnmgUUc1WsysxeDKtd+oAaW6o=;
 b=wRb9zvaGXUTTBSDkbLQhJgkmroInTpoNboOg1KwsLz/RrWl402IFUn8SyU51k6LW2V
 G3Yeq3VEw4Ehq/BlgNR0Ktx87gHwZyqcEDETREk4OX70muzWsryL4ZRKUOedGLh/h5dh
 9a4SU/RAoObgApzXCELbZY38QupKGJkMHZsv182weHyQ8P6P/C28KJi2EgM0BrXWZqGD
 Vro0gER//N5B8Qo0nPy2yL7DwFe9jNqgoWX65dwXuVry9xgCdTZIt43E3pioR8w7L5wp
 n4zheTUQz2KqF+t8MJ+5jvYIh+ATnRGlvrsLp2bJFmURGGEs/Lrc5r1Tu0RRWlFbX2RU
 TWBA==
X-Gm-Message-State: AFq9FYJVYLYUKdPFrak5rX/Slg6OLLjFZ6d7j8VWPQrJKjrXo+I+XMOn
 Z9P3jnQxYK6CCl5rQmZrX6P8yE9iDRBNbdnbkOdRB1I6zzsLib9cXhE1x6Vu3Xg3tMo=
X-Gm-Gg: AYBFou2lC6ZkV5Vt9SF5g69NNlq0xhOs1sQUdQj8RmCVHJx9E0OaZdHcVeKT+o1cFL7
 pzQchUzK36a7Y7PjPMG05+h2GpEzcERpYILkQrmkKy3K6P1kffZ+E8oYdtgs/NXrJaz+GFzKlrg
 rB8vFMrO+mq319AnJo8lj/FYl4u4oJ5recfeqehfq5WQIvBKJp/FAjcet9Q6SLOy5obI6R4OITC
 y6SVSX+i8wXqmQqjY4UJuxozPnMJfn0OAt1GH6uUq3EsR+/9/K5hYn9etg/tCg74ZA5YCfcJOI4
 GIrRuf6WILMjEkQ6Mjb6mfe9AXXzHehYq2g7s7Ae50PyCfCtkRSYkJwMV8tzJYS94HGY/TQIcfh
 abi+S+jYAP7Jlx3L72N/6p52/A2UAynazhROkcQBho5/Kzaazt3OUsESpO8NYtINmzIGWkZKXU+
 O/jezc9Nlh72XLF2Ntma1a2ciCn8YXXKoDf8wRlLHMabA2bTOnZ86CacRKByh68IMN1sVayw==
X-Received: by 2002:a05:6000:3c9:b0:48e:932:af0b with SMTP id
 ffacd0b85a97d-48e0932b03emr14543280f8f.32.1792438609776; 
 Mon, 19 Oct 2026 12:36:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d82fe82sm803608f8f.51.2026.10.19.12.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:36:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F209B5F8DC;
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
Subject: [PATCH v3 19/19] tests/functional: add tuxrun kvm gdb test for s390x
Date: Mon, 19 Oct 2026 20:27:04 +0100
Message-ID: <20261019192704.3220373-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

As with x86_64 we now have the bits to add a KVM gdb test. A couple of
minor wrinkles need to be handled.

The first is applying an offset when loading the symbols to take into
account the relocation that happens.

The other minor wrinkle is the s390x only supports WP_WRITE watch
points so we skip the other watch point tests lest we get confusing
messages about failing to insert HW breakpoints.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

---
v3
  - add symbol-offset handling
  - limit the watchpoint tests
  - add skipIfMissingEnv("QEMU_TEST_GDB") decorator
---
 .../functional/gdb-scripts/kernel_gdb_test.py  | 10 ++++++----
 tests/functional/qemu_test/tuxruntest.py       |  4 ++++
 tests/functional/s390x/test_tuxrun.py          | 18 +++++++++++++++++-
 tests/guest-debug/run-test.py                  |  7 ++++++-
 tests/lcitool/libvirt-ci                       |  2 +-
 5 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
index f457ccdcbf4..975faf3d284 100644
--- a/tests/functional/gdb-scripts/kernel_gdb_test.py
+++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
@@ -95,11 +95,13 @@ def do_one_watch(sym, wtype, text):
 def check_watches(sym_name):
     "Watch a symbol for any access."
 
-    # Should hit for any read
-    do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
+    # s390 only supports write watchpoints
+    if "s390" not in gdb.selected_frame().architecture().name():
+        # Should hit for any read
+        do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
 
-    # Again should hit for reads
-    do_one_watch(sym_name, gdb.WP_READ, "rwatch")
+        # Again should hit for reads
+        do_one_watch(sym_name, gdb.WP_READ, "rwatch")
 
     # Finally when it is written
     do_one_watch(sym_name, gdb.WP_WRITE, "watch")
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 6ad421e897d..c43a0b0e499 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -159,6 +159,7 @@ def common_tuxrun_gdb(self,
                           rootfs_asset,
                           accel=None,
                           dtb_asset=None,
+                          symbol_off = None,
                           drive="virtio-blk-device",
                           haltmsg="reboot: System halted",
                           console_index=0):
@@ -205,6 +206,9 @@ def common_tuxrun_gdb(self,
             "--gdb", gdb_path,
         ]
 
+        if symbol_off is not None:
+            cmd.extend(["--symbol-offset", f"{symbol_off}"])
+
         log_cmd = " ".join(f'"{arg}"' if ' ' in arg else arg for arg in cmd)
         self.log.info(f"run-test: {log_cmd}")
 
diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
index 8e0261e2b7f..3821f985196 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -11,7 +11,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingEnv
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunS390xTest(TuxRunBaselineTest):
@@ -19,6 +19,9 @@ class TuxRunS390xTest(TuxRunBaselineTest):
     ASSET_S390X_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
         '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
+    ASSET_S390X_VMLINUX = Asset(
+        'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
+        '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
     ASSET_S390X_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
         '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f5')
@@ -42,5 +45,18 @@ def test_s390_kvm(self):
                            haltmsg="Requesting system halt",
                            accel="kvm")
 
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_s390_kvm_gdb(self):
+        self.set_machine('s390-ccw-virtio')
+        self.require_accelerator('kvm')
+        self.wait_for_shutdown=False
+        self.common_tuxrun_gdb(kernel_asset=self.ASSET_S390X_KERNEL,
+                               vmlinux_asset=self.ASSET_S390X_VMLINUX,
+                               rootfs_asset=self.ASSET_S390X_ROOTFS,
+                               symbol_off="0x3ffe0000000",
+                               drive="virtio-blk-ccw",
+                               haltmsg="Requesting system halt",
+                               accel="kvm")
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 48a5261618d..0b93aae62c6 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -28,6 +28,7 @@ def get_args():
     parser.add_argument("--kargs", help="Kernel args to --append")
     parser.add_argument("--binary", help="Binary to debug")
     parser.add_argument("--symbols", help="Symbol file for binary to debug")
+    parser.add_argument("--symbol-offset", help="offset to apply to symbols")
     parser.add_argument("--test", help="GDB test script")
     parser.add_argument('test_args', nargs='*',
                         help="Additional args for GDB test script. "
@@ -134,7 +135,11 @@ def format_cmd(cmd):
     gdb_cmd.extend(["-ex", f"target remote {socket_name}"])
 
     if args.symbols:
-        gdb_cmd.extend(["-ex", f"symbol-file {args.symbols}"])
+        sym_arg = f"symbol-file {args.symbols}"
+        if args.symbol_offset:
+            sym_arg += f" -o {args.symbol_offset}"
+
+        gdb_cmd.extend(["-ex", sym_arg])
 
     # finally the test script itself
     if args.test:
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index f34cd57eb89..5176e136ab1 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit f34cd57eb892259c26600187bc35cc4152f932cf
+Subproject commit 5176e136ab11e275eb9f57c3d5c80e77af6507cb
-- 
2.47.3


