Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4D606A33A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jD3opyXv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PxFpOalU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F3-0005p7-Kq; Wed, 28 Oct 2026 13:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EJ-0004tl-O1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EF-0003SW-UG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YAvj+CCpvxp4VUmJlVii+rObiQbYixK68MIAnNv3rxg=;
 b=jD3opyXvRcYWGRhvbufQ7jlArlObDSUQ4jojf1d/xuByzhnnIQbRPBeenDGcNgMw7SJrZd
 czxxIiWFRMGEQ1nWgox/P0TCuR3J3s7NKzvzhy5j6EgEJr29ZU4ipRNj3vQd8XbxkMIw6X
 ssvyCC1wOaUHAgOY+MtZsC7uF87QQqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-q77w1yPSMbOCUvo4A3ggJw-1; Wed, 28 Oct 2026 13:14:20 -0400
X-MC-Unique: q77w1yPSMbOCUvo4A3ggJw-1
X-Mimecast-MFC-AGG-ID: q77w1yPSMbOCUvo4A3ggJw_1793207659
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48af5a07314so811920f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207659; x=1793812459; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YAvj+CCpvxp4VUmJlVii+rObiQbYixK68MIAnNv3rxg=;
 b=PxFpOalU/E/hOpZo+SrwRN6kSWN6+gjNUrm3NXQHKs+VAGiV8fC3elrWYwZgIT8jD0
 T6MhaoEx+qt2+01QEXGdkZRrZMxdq5dd7n2J+wB+49MzF2JPXqokf42hFlM9rF8jhF4J
 QCT7/4v9cM4Q77AY3BuSyEZHem+NgCMrYB6iBKBsO8lKKgnZQKTImWCjXSSwHjp+UiHV
 deyNI3Tvv/AA/mohM0FIvktwCDZrTrP2W5vRaQRYCQ/6kKfVutQF+DtFtyoKZ6l6G+WJ
 MVYQtse3Fs/zAlmqfM3vvD86kDvAXzUMe73gsFGD1/9awZmMesAeod+UhtueWYMJLxxr
 vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207659; x=1793812459;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAvj+CCpvxp4VUmJlVii+rObiQbYixK68MIAnNv3rxg=;
 b=SC7o/p3uhlBbmYxBJHfGGeJk9GJ3ZC8SSk7JULm6Q7kOj41i+LOJuR7D6mQNrBccAx
 EaJvp8iOvEP48RC1EpdnOO68rmMuR41ItXBOSi17kH17v3zlzGBLEuJ0NGBqgXxNKpC6
 8qm/hSP2UFY4RQzXV6I2ZYg/VyCqXx1437kPu3qDWWBu6vz95AfLeQQdtOjQZ1PUGfnG
 9MY7y259u9TYX+vvC6wR+l+LfRsgYrleSP8SXsZ/Mzpqltx0Fq1+/XltBnwhRSe4B9KY
 x/ZGI7JEEVoVS+n7+7ukhdeCpedvyp7P4fDaIxUNOEWrxceZP/tRqV2J+oX6HlimBkFY
 7WMw==
X-Gm-Message-State: AFq9FYIuTSPqPY+9WKPa1GiyqPDlCUlljta3VcS+fscnpZaMCEfD2E3r
 I50rmsMBAIZnfUK0+kigu6Ye8MytJWH1JUvOvU9OOns+nN0cA2eWy4ozjl0Sub++nytp0LTPid5
 Awj9PmoOPdx8rrZXszQBDSv+Kl/nvkPmLJ8V6Fk3ppZ5xtISZ4gGUZSA2MGva462O/hbcg8NXlm
 vATewy0cGirMxBueom74XIgWEHtKGfhDY3Eg==
X-Gm-Gg: AYBFou1FVREhWTDV1+fEmxbtGslIYtkymDKJv6RO8x5170mVOGT+CbxZkyXS+lIjmjh
 ffJtG4dAolrnSQI+hZcORRIDPFf4wLHESa6fi152WS0FGzSiOO0R7gD7FhjtmQDOlNQLHpSzuto
 zFCgfU7x2A5DdFSH9+jrOIHQfnfCJwtcxS+CLLqRLk/s1rgpopo7lAZOv0F7aIe97XPa8esXjem
 V/WJFQPR1lcEj2yKycq1/ogTPEfd79FdObY8Yp34/Xd+rXrj1gA5OC75BcCJmIRHVYNl0YYf8Jk
 GFosnealVjeIZlmbttPEarkjI4JMRyKX8VzuHELYxfAaYpFX4FnDd405GWvqvXFROToJBdWxSdj
 bbiXeTHCPYpjzMWrxz03lxRaPGy8vRRXD5VSOmd1H
X-Received: by 2002:a05:6000:46da:b0:48e:64cb:1673 with SMTP id
 ffacd0b85a97d-48e64cb1727mr217724f8f.45.1793207655165; 
 Wed, 28 Oct 2026 10:14:15 -0700 (PDT)
X-Received: by 2002:a05:6000:46da:b0:48e:64cb:1673 with SMTP id
 ffacd0b85a97d-48e64cb1727mr217150f8f.45.1793207645667; 
 Wed, 28 Oct 2026 10:14:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm35244460f8f.44.2026.10.28.10.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:04 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 04/78] tests/functional: add test_tap_migration
Message-ID: <5464efb40194a7ba887363307693e203f9fd8b9d.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add test for a new local-migration migration of virtio-net/tap, with fd
passing through UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914175351.393680-2-vsementsov@yandex-team.ru>
---
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 425 ++++++++++++++++++
 2 files changed, 426 insertions(+)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e..6254149239 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -51,4 +51,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'tap_migration',
 ]
diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
new file mode 100755
index 0000000000..a34bd94fd2
--- /dev/null
+++ b/tests/functional/x86_64/test_tap_migration.py
@@ -0,0 +1,425 @@
+#!/usr/bin/env python3
+#
+# Functional test that tests TAP local migration
+# with fd passing
+#
+# Copyright (c) Yandex Technologies LLC, 2026
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import subprocess
+from subprocess import run
+import signal
+import ctypes
+import ctypes.util
+import unittest
+from contextlib import contextmanager, ExitStack
+
+from qemu_test import (
+    LinuxKernelTest,
+    Asset,
+    exec_command_and_wait_for_pattern,
+    skipIfMissingCommands,
+)
+from qemu_test.decorators import skipWithoutSudo
+
+
+GUEST_IP = "192.168.100.2"
+GUEST_IP_MASK = f"{GUEST_IP}/24"
+GUEST_MAC = "d6:0d:75:f8:0f:b7"
+HOST_IP = "192.168.100.1"
+HOST_IP_MASK = f"{HOST_IP}/24"
+TAP_ID = "tap0"
+TAP_ID2 = "tap1"
+TAP_MAC = "e6:1d:44:b5:03:5d"
+NETNS = f"qemu_test_ns_{os.getpid()}"
+
+
+def ip(args, check=True) -> None:
+    """Run ip command with sudo"""
+    run(["sudo", "ip"] + args, check=check)
+
+
+@contextmanager
+def switch_netns(netns_name):
+    libc = ctypes.CDLL(ctypes.util.find_library("c"))
+    netns_path = f"/var/run/netns/{netns_name}"
+
+    def switch_to_fd(fd, check: bool = False):
+        """Switch to netns by file descriptor"""
+        sys_setns = 308
+        clone_newnet = 0x40000000
+        ret = libc.syscall(sys_setns, fd, clone_newnet)
+        if check and ret != 0:
+            raise RuntimeError("syscall SETNS failed")
+
+    with ExitStack() as stack:
+        original_netns_fd = os.open("/proc/self/ns/net", os.O_RDONLY)
+        stack.callback(os.close, original_netns_fd)
+
+        ip(["netns", "add", netns_name])
+        stack.callback(ip, ["netns", "del", netns_name], check=False)
+
+        new_netns_fd = os.open(netns_path, os.O_RDONLY)
+        stack.callback(os.close, new_netns_fd)
+
+        switch_to_fd(new_netns_fd)
+        stack.callback(switch_to_fd, original_netns_fd, check=False)
+
+        yield
+
+
+def del_tap(tap_name: str = TAP_ID) -> None:
+    ip(["tuntap", "del", tap_name, "mode", "tap", "multi_queue"], check=False)
+
+
+def init_tap(tap_name: str = TAP_ID, with_ip: bool = True) -> None:
+    ip(["tuntap", "add", "dev", tap_name, "mode", "tap", "multi_queue"])
+    if with_ip:
+        ip(["link", "set", "dev", tap_name, "address", TAP_MAC])
+        ip(["addr", "add", HOST_IP_MASK, "dev", tap_name])
+    ip(["link", "set", tap_name, "up"])
+
+
+def switch_network_to_tap2() -> None:
+    ip(["link", "set", TAP_ID2, "down"])
+    ip(["link", "set", TAP_ID, "down"])
+    ip(["addr", "delete", HOST_IP_MASK, "dev", TAP_ID])
+    ip(["link", "set", "dev", TAP_ID2, "address", TAP_MAC])
+    ip(["addr", "add", HOST_IP_MASK, "dev", TAP_ID2])
+    ip(["link", "set", TAP_ID2, "up"])
+
+
+def parse_ping_line(line: str) -> float:
+    # suspect lines like
+    # [1748524876.590509] 64 bytes from 94.245.155.3 \
+    #      (94.245.155.3): icmp_seq=1 ttl=250 time=101 ms
+    spl = line.split()
+    return float(spl[0][1:-1])
+
+
+def parse_ping_output(out) -> float:
+    lines = [x for x in out.split("\n") if x.startswith("[")]
+
+    max_gap = 0.0
+    prev_timestamp = None
+
+    for line in lines:
+        if "no ans" not in line:
+            # This is a successful ping line
+            try:
+                timestamp = parse_ping_line(line)
+                if prev_timestamp is not None:
+                    gap = timestamp - prev_timestamp
+                    if gap > max_gap:
+                        max_gap = gap
+                prev_timestamp = timestamp
+            except (IndexError, ValueError):
+                # Skip malformed lines
+                continue
+
+    assert prev_timestamp is not None, "No successful pings found"
+    assert max_gap > 0.0, "Need at least two successful pings to calculate gap"
+
+    return max_gap
+
+
+def wait_migration_finish(source_vm, target_vm):
+    migr_events = (
+        ("MIGRATION", {"data": {"status": "completed"}}),
+        ("MIGRATION", {"data": {"status": "failed"}}),
+    )
+
+    source_e = source_vm.events_wait(migr_events)["data"]
+    target_e = target_vm.events_wait(migr_events)["data"]
+
+    source_s = source_vm.cmd("query-status")["status"]
+    target_s = target_vm.cmd("query-status")["status"]
+
+    assert (
+        source_e["status"] == "completed"
+        and target_e["status"] == "completed"
+        and source_s == "postmigrate"
+        and target_s == "paused"
+    ), f"""Migration failed:
+    SRC status: {source_s}
+    SRC event: {source_e}
+    TGT status: {target_s}
+    TGT event:{target_e}"""
+
+
+@skipIfMissingCommands("ip", "ping")
+@skipWithoutSudo()
+class TAPFdMigration(LinuxKernelTest):
+    ASSET_ALPINE_ISO = Asset(
+        (
+            "https://dl-cdn.alpinelinux.org/"
+            "alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"
+        ),
+        "96d1b44ea1b8a5a884f193526d92edb4676054e9fa903ad2f016441a0fe13089",
+    )
+
+    @classmethod
+    def setUpClass(cls):
+        super().setUpClass()
+
+        # The test namespace has no external connectivity.
+        cls.ASSET_ALPINE_ISO.fetch()
+
+        try:
+            cls.netns_context = switch_netns(NETNS)
+            cls.netns_context.__enter__()
+        except (OSError, subprocess.CalledProcessError) as e:
+            raise unittest.SkipTest(f"can't switch network namespace: {e}")
+
+    @classmethod
+    def tearDownClass(cls):
+        if hasattr(cls, "netns_context"):
+            cls.netns_context.__exit__(None, None, None)
+        super().tearDownClass()
+
+    def setUp(self):
+        super().setUp()
+
+        self.require_accelerator("kvm")
+        self.set_machine("q35")
+
+        self.setup_shared_memory()
+
+        init_tap()
+
+        self.outer_ping_proc = None
+
+    def tearDown(self):
+        with ExitStack() as stack:
+            stack.callback(super().tearDown)
+
+            if self.shm_path:
+                stack.callback(lambda p: (os.unlink(p) if os.path.exists(p)
+                                         else None),
+                               self.shm_path)
+                self.shm_path = None
+
+            stack.callback(del_tap, TAP_ID2)
+            stack.callback(del_tap, TAP_ID)
+
+            if self.outer_ping_proc:
+                self.stop_outer_ping()
+
+    def start_outer_ping(self) -> None:
+        assert self.outer_ping_proc is None
+        self.outer_ping_log = self.scratch_file("ping.log")
+        with open(self.outer_ping_log, "w", encoding="utf-8") as f:
+            self.outer_ping_proc = subprocess.Popen(
+                ["sudo", "ping", "-i", "0", "-O", "-D", GUEST_IP],
+                text=True,
+                stdout=f,
+            )
+
+    def stop_outer_ping(self) -> str:
+        assert self.outer_ping_proc
+        self.outer_ping_proc.send_signal(signal.SIGINT)
+
+        self.outer_ping_proc.communicate(timeout=5)
+        self.outer_ping_proc = None
+
+        with open(self.outer_ping_log, encoding="utf-8") as f:
+            return f.read()
+
+    def stop_ping_and_check(self):
+        ping_res = self.stop_outer_ping()
+
+        disconnect_time = parse_ping_output(ping_res)
+        if disconnect_time > 0.5:
+            self.fail(f"long disconnect time: {disconnect_time}")
+
+    def one_ping_from_guest(self, vm) -> None:
+        exec_command_and_wait_for_pattern(
+            self,
+            f"ping -c 1 -W 1 {HOST_IP}",
+            "1 packets transmitted, 1 packets received",
+            "1 packets transmitted, 0 packets received",
+            vm=vm,
+        )
+        self.wait_for_console_pattern("# ", vm=vm)
+
+    def one_ping_from_host(self) -> None:
+        run(
+            ["ping", "-c", "1", "-W", "1", GUEST_IP],
+            stdout=subprocess.DEVNULL,
+            check=True,
+        )
+
+    def setup_shared_memory(self):
+        self.shm_path = f"/dev/shm/qemu_test_{os.getpid()}"
+
+        try:
+            with open(self.shm_path, "wb") as f:
+                f.write(b"\0" * (1024 * 1024 * 1024))  # 1GB
+        except OSError as e:
+            self.fail(f"Failed to create shared memory file: {e}")
+
+    def prepare_vm(self, vm, shm_path, incoming):
+        if not vm:
+            vm = self.vm
+
+        vm.set_console()
+        vm.add_args("-accel", "kvm")
+        vm.add_args("-device", "pcie-pci-bridge,id=pci.1,bus=pcie.0")
+        vm.add_args("-m", "1G")
+        vm.add_args("-net", "none")
+
+        vm.add_args(
+            "-object",
+            f"memory-backend-file,id=ram0,size=1G,mem-path={shm_path},share=on",
+        )
+        vm.add_args("-machine", "memory-backend=ram0")
+
+        vm.add_args(
+            "-drive",
+            f"file={self.ASSET_ALPINE_ISO.fetch()},media=cdrom,format=raw",
+        )
+
+        vm.add_args("-S")
+
+        if incoming:
+            vm.add_args("-incoming", "defer")
+
+    def add_virtio_net(
+        self, vm, vhost: bool, tap_name: str, local: bool, incoming: bool
+    ):
+        netdev_params = {
+            "id": "netdev.1",
+            "vhost": vhost,
+            "type": "tap",
+            "queues": 4,
+            "script": "no",
+            "downscript": "no",
+            "x-permit-local-migration": local,
+        }
+
+        if not (local and incoming):
+            netdev_params["vnet_hdr"] = True
+            netdev_params["ifname"] = tap_name
+
+        vm.cmd("netdev_add", netdev_params)
+
+        vm.cmd(
+            "device_add",
+            driver="virtio-net-pci",
+            romfile="",
+            id="vnet.1",
+            netdev="netdev.1",
+            mq=True,
+            vectors=18,
+            bus="pci.1",
+            mac=GUEST_MAC,
+            disable_legacy="off",
+        )
+
+    def set_migration_capabilities(self, vm, local):
+        vm.cmd(
+            "migrate-set-capabilities",
+            {
+                "capabilities": [
+                    {"capability": "events", "state": True},
+                    {"capability": "x-ignore-shared", "state": True},
+                ]
+            },
+        )
+        vm.cmd("migrate-set-parameters", {"local": local})
+
+    def setup_guest_network(self) -> None:
+        exec_command_and_wait_for_pattern(self, "ip addr", "# ")
+        exec_command_and_wait_for_pattern(
+            self,
+            f"ip addr add {GUEST_IP_MASK} dev eth0 && "
+            "ip link set eth0 up && echo OK",
+            "OK",
+        )
+        self.wait_for_console_pattern("# ")
+
+    def migrate(self, vm, mig_sock):
+        vm.cmd("migrate", uri=f"unix:{mig_sock}")
+
+    def do_test_tap_fd_migration(self, vhost, local=True):
+        socket_dir = self.socket_dir()
+        mig_sock = os.path.join(socket_dir.name, "mig.sock")
+
+        # Setup second TAP if needed
+        if not local:
+            del_tap(TAP_ID2)
+            init_tap(TAP_ID2, with_ip=False)
+
+        self.prepare_vm(self.vm, self.shm_path, False)
+        self.vm.launch()
+        self.set_migration_capabilities(self.vm, local=local)
+        self.add_virtio_net(self.vm, vhost, TAP_ID, local, incoming=False)
+
+        self.vm.cmd("cont")
+        self.wait_for_console_pattern("login:")
+        exec_command_and_wait_for_pattern(self, "root", "# ")
+
+        self.setup_guest_network()
+
+        self.one_ping_from_guest(self.vm)
+        self.one_ping_from_host()
+        self.start_outer_ping()
+
+        # Get some successful pings before migration
+        time.sleep(0.5)
+
+        target_vm = self.get_vm(name="target")
+        self.prepare_vm(target_vm, self.shm_path, True)
+
+        target_vm.launch()
+        if not local:
+            tap_name = TAP_ID2
+        else:
+            tap_name = TAP_ID
+        self.set_migration_capabilities(target_vm, local=local)
+        self.add_virtio_net(target_vm, vhost, tap_name, local, incoming=True)
+
+        target_vm.cmd("migrate-incoming", {"uri": f"unix:{mig_sock}"})
+
+        self.log.info("Starting migration")
+        self.migrate(self.vm, mig_sock)
+
+        self.log.info("Waiting for migration completion")
+        wait_migration_finish(self.vm, target_vm)
+
+        # Switch network to tap1 if not using local-migration
+        if not local:
+            switch_network_to_tap2()
+
+        target_vm.cmd("cont")
+
+        self.log.info("Verifying PING on target VM after migration")
+
+        # Keep the stopped source alive while checking the target.
+        time.sleep(0.3)
+        self.stop_ping_and_check()
+
+        self.one_ping_from_guest(target_vm)
+        self.one_ping_from_host()
+
+        self.vm.shutdown()
+        target_vm.shutdown()
+
+    def test_tap_fd_migration(self):
+        self.do_test_tap_fd_migration(False)
+
+    def test_tap_fd_migration_vhost(self):
+        self.do_test_tap_fd_migration(True)
+
+    def test_tap_new_tap_migration(self):
+        self.do_test_tap_fd_migration(False, local=False)
+
+    def test_tap_new_tap_migration_vhost(self):
+        self.do_test_tap_fd_migration(True, local=False)
+
+
+if __name__ == "__main__":
+    LinuxKernelTest.main()
-- 
MST


