Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA3606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rky07HCQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeX-0006n9-Tw; Fri, 23 Oct 2026 14:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeO-0006hX-G3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeM-0004ZK-8V
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so992138f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778753; x=1793383553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HeMMGwvyGA3wE9mbaQIS+jfi743WAKKkzz+mk0ix3s=;
 b=rky07HCQh5Yi45vireDgZjAW9LIUOHhkv8fgHQO0p90jjY+vXbhYOBOpiwhFZqsvaH
 zvzLjyLyekPx56gj1s2L1vULsaIo/mLbgc880WZYIUp9iK8h3T3A/L1d539wmRcvZm9a
 kJTexcdsMXbpkdmWnQ7v1VAlz+A13wM3GwncyiQjbg6+n6Joo/oox8zD+cvAGxFhSezP
 yzo2tFjHqgZbWcpBceAE7vel0+iqBLKAPOZ/cn9PaJKoqFMQ9KyASq09A9VNnES7/eTE
 NVB08+2loks03Tu2IfpNHV3fzLg2KcRTweeL4p1owWz/ueeKPtEpmp9FtA/+umE7iP+V
 nM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778753; x=1793383553;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HeMMGwvyGA3wE9mbaQIS+jfi743WAKKkzz+mk0ix3s=;
 b=VJEHADVzh2vFTI8qVyMDJBIHmVW46Fp7jr5vE+ZiyN9U+TjS48CKacO6Q2TB1czFiA
 pw44ImKEFyiNsANnWWkvImrVWvtR/tCm9UxmuBa7XYxBfazRlMvYXkXn1DdGSBUwaFHT
 nrC+m0DfiEXaLLpETXbScVt48louMPRsahOb/gMIBekxZk55va6XbIeNLo+GUTVu3qmT
 B/0WUOu9jKsWdtgF52eBbJadd8GgYubiY7SZ4AHXOr1Tu2HMntSNwlGU5rHS34u/BAF1
 CWrEVmW91evfBvqXaj5tAPCOxaAj1caoCilIC7t7x85QAIdhA1LEP32fvEFdLs5ahF1o
 KlUw==
X-Gm-Message-State: AFq9FYJZ0Ctvxi4YmQN0jfoZsFhYgK6hXSGOcHfz1zK+qFHqZ2CvBUKf
 CGMvQwXbUxzqKNnSyvO7CjyrgdfAkUdxxD185dUrl2j746tq/Ht235ymutAlEOTj+W4=
X-Gm-Gg: AYBFou11DBhf7+FJm0lUrBFPQFAfxdoOb8n3r+4jjaax9CKJO/C+QG/EXVK2Ir3gFud
 q3eFw1qOW45TPf1MOZamuQdTap+0pSHmVQVnGbJ3v89D43xGXT8I3JmvLKHOfnYZgMSIZmr/WkY
 jC8t0gF2xQMYkXZzkzzScTzPFYMiJN/fpmZSxCZ+3pOs4kqMztSRufOSU4vypBFpjjSgvw78oSN
 W4AkArGemT1Z3k+56qQu3bUhgzjpr64O5VenGoeSIzwktS1VMPbGfjNkK4jCqXTyFPk7g29tQPM
 qbzhIr0crPQ4+L1mpc/MGc015kKGeqghaZFQU/kZJLxryT1M+p6fouFCzjmV/pybrdJ+9gJGTOG
 zYC+P53HVaHqE2DfZyU7BjkXgRvsdY1EMCwvvNWUWjO8gGqkt3icKY+WKHOeplWKyNLE9o/I7ng
 dOHtR8wp3bOs5RYYI5iG4EYT4+ExrV+3cAMVxsjQSn28h7JU7UHG/lZTNcnlgWoJ2eaxvV8iqGg
 4hg+sTcjWkY1Dgucenxb87vTHiPr9RJgLU8ptdmQicM2GlEBUht3Yk=
X-Received: by 2002:a05:6000:1606:b0:48e:f10:ceb8 with SMTP id
 ffacd0b85a97d-48e38589445mr3786483f8f.11.1792778752739; 
 Fri, 23 Oct 2026 11:05:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4104b5sm1228580f8f.36.2026.10.23.11.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 826186136A;
 Fri, 23 Oct 2026 19:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 Virtio-ccw)
Subject: [PULL 19/19] tests/functional: add tuxrun kvm gdb test for s390x
Date: Fri, 23 Oct 2026 19:05:37 +0100
Message-ID: <20261023180539.1574134-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

As with x86_64 we now have the bits to add a KVM gdb test. A couple of
minor wrinkles need to be handled.

The first is applying an offset when loading the symbols to take into
account the relocation that happens.

The other minor wrinkle is the s390x only supports WP_WRITE watch
points so we skip the other watch point tests lest we get confusing
messages about failing to insert HW breakpoints.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20261019192704.3220373-20-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
index 44b14ab6d48..40b0907ff3e 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -160,6 +160,7 @@ def common_tuxrun_gdb(self,
                           rootfs_asset,
                           accel=None,
                           dtb_asset=None,
+                          symbol_off = None,
                           drive="virtio-blk-device",
                           console_index=0):
         """
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
index 6f858f2d0b7..9fdf05b55d3 100755
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
-- 
2.47.3


