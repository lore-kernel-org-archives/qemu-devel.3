Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55476C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8RS-0006XO-GZ; Fri, 25 Sep 2026 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xA8Ft-0000EL-Nu
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:54:34 -0400
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xA8Fp-00067V-2g
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:54:33 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.110.43.115])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4hrwHW3V0Fz3wwW;
 Fri, 25 Sep 2026 15:54:15 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 17:54:14 +0200
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/2] iotests: Add coverage for NBD connect thread start delay
Date: Fri, 25 Sep 2026 17:53:46 +0200
Message-ID: <20260925155346.357703-3-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 11035789415208337703
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTET5RUJGNfmJ9NTrJITjXYbdcTO3CD1/irQgvmbcVvU+j3yU3NLNdBQmSWzUyxGftnAL5Iois3+qtj5G+XGi6yJapT3529pc59sfOOCq/Kc8FQqT0XQF2xXbKMW9Wi/PJNlpjMFYJCk+XKL+8KSXvAiIysT66Iz/ljKq0uOHOb4fy1muOGETRnXuHRDQlP5guWfSG0NaIpQ2MvLi/625mPQwXHSmLKChwuCT5l8HPUupqfW4YfVcoXdGds9cFNYInZ9eTzaLkTVa9NMU6N55UkVhVs1pX/lFlbzKKFdmuYQ7LC7KFt6l3jwirOWNNA0XHCtZueAPaQvk4ugL/EC2Ybessk4iZdJyM4kj0LVGZxyt6b/vAlnclParS91v/L68acsYwQQ3Rl8NA9EskWg7wcXzNCZQgR3lQCc9U1Q5KBX10qK0wxsS4grI0+aHtp28WBiaotM2121hUueftkSkXHHGA9k7XqBeHKSWs4zKG5nYBdzTpWvKoRT04XPVjXf0TVdXLzwI+I/bUqMu/JAj1q+6wyHWq0xv1+YJqKUnAo+dxeORxN+CxpC9rDjQsAcRTKvbWrh0dB6D8K0Sl6hCwFrFd2knOKIfv1Rj45r+EWlolc5aa5qv6WIKHpjfya1yJ0PaoasSnWd6orkgjpj9bNB3kpkOWy4+s1pyG/pZ3zwOg
DKIM-Signature: a=rsa-sha256; bh=366bXCSEca/MypXuX5DsaXF8rVnjw5CHK4WfDSFcpbg=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1790351655; v=1; 
 b=MLPd4GwTafQOE3CxzyxwdIUJQ8zqNDet1CtfnsXA2PQ2yKMD2pRnxNHyr5c3y8YwrfZ1udjg
 19ZPxqzExoOT2qSJoSLuagMTUz+aaGfstUEOrHsQF7MJRRnFlh4sF9Ds62OLxujKqOlE1d72dtf
 NLiNesNPhBwihcfcKAIFqhvA=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:02 -0400
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

Test the connect thread starting condition with reconnect-delay=0 when
the server disconnects after a successful handshake but before running
operations. Prior to the change to nbd_co_establish_connection(), this
test would demonstrate two I/O errors. The tests 264 and 277 covering
reconnection do not use reconnect-delay=0 so this case is not exercised.

Add a test that provokes multiple errors in order to put an NBD client
in the above-mentioned situation and shows that the first operation
starts the connect thread and leads to successful subsequent I/O.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 tests/qemu-iotests/tests/nbd-stale-connection | 62 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 +++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

diff --git a/tests/qemu-iotests/tests/nbd-stale-connection b/tests/qemu-iotests/tests/nbd-stale-connection
new file mode 100755
index 0000000000..6f6fb6ef1b
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-stale-connection
@@ -0,0 +1,62 @@
+#!/usr/bin/env python3
+# group: quick
+#
+# Test the NBD client stale channel discard
+#
+# Copyright (C) 2026 OVHcloud
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import iotests
+from iotests import qemu_nbd_popen, qemu_img_create, file_path, log
+
+
+# estimated duration required by the connect thread to reach a running server
+MAX_NBD_HANDSHAKE_DURATION = 0.5
+# sleep duration of the connection retry in nbd client
+CONNECT_RETRY_DELAY = 1
+
+iotests.script_initialize()
+nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
+disk = file_path('disk')
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+with iotests.VM() as vm:
+
+    vm.launch()
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        vm.cmd('blockdev-add', {
+            'driver': 'nbd',
+            'node-name': 'nbd0',
+            'server': {'type': 'unix', 'path': nbd_sock},
+        })
+        iotests.log('=== NBD Device connected ===')
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+
+    iotests.log('=== NBD server down. Detect the break and start the connect '
+                'thread ===')
+    # client was in CONNECTED state a new operation updates to CONNECTING
+    log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+    # in CONNECTING, the operation starts the connect thread
+    log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        iotests.log('=== NBD server up. Wait for the connect thread to park '
+                    'the channel ===')
+        # wait for the connect thread to get a new channel and stop
+        time.sleep(CONNECT_RETRY_DELAY + MAX_NBD_HANDSHAKE_DURATION)
+
+    iotests.log('=== NBD server down. The parked channel is closed ===')
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        iotests.log('=== NBD server up. Restart the connect thread ===')
+        # operation will determine that the channel got closed and restart the
+        # connect thread
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+        # Wait for it to succeed
+        iotests.log('=== Wait for the connect thread to park the new channel. '
+                    'Subsequent operations are successful ===')
+        time.sleep(MAX_NBD_HANDSHAKE_DURATION)
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
diff --git a/tests/qemu-iotests/tests/nbd-stale-connection.out b/tests/qemu-iotests/tests/nbd-stale-connection.out
new file mode 100644
index 0000000000..50f80e2305
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-stale-connection.out
@@ -0,0 +1,17 @@
+Start NBD server
+=== NBD Device connected ===
+{"return": {}}
+Kill NBD server
+=== NBD server down. Detect the break and start the connect thread ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+Start NBD server
+=== NBD server up. Wait for the connect thread to park the channel ===
+Kill NBD server
+=== NBD server down. The parked channel is closed ===
+Start NBD server
+=== NBD server up. Restart the connect thread ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+=== Wait for the connect thread to park the new channel. Subsequent operations are successful ===
+{"return": {}}
+Kill NBD server
-- 
2.43.0


