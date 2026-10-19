Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4B606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eCSFg3ZR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dnzIyHH0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIrz7-0006co-GD; Mon, 19 Oct 2026 14:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryv-0006WD-0e
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIrys-0005ry-PL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA1kYpviYukq6qxxQH3ZLixjfNRZabHCuj4f2iyyXYk=;
 b=eCSFg3ZRykJVqG2uALn02xQtbxI1fMEgQJ/uyk2GwAPFjOx5hbU5RQSG2zwbHBA3zzPY6B
 UC16MTu5ipd/IskZFSOHbRi0ZRGzJ03wy41ac4Cxr9p5Lp7flEEfH2QjMr7N/sO2gEw2km
 iYYJ4UWcCJwiVj5kEwFu6EnUtiF90kw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-VfbE-8dBPsOGZVNZP3LVmw-1; Mon, 19 Oct 2026 18:21:04 +0000
X-MC-Unique: VfbE-8dBPsOGZVNZP3LVmw-1
X-Mimecast-MFC-AGG-ID: VfbE-8dBPsOGZVNZP3LVmw_1792434063
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1721559b4so25104275e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434063; x=1793038863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cA1kYpviYukq6qxxQH3ZLixjfNRZabHCuj4f2iyyXYk=;
 b=dnzIyHH0oTXHf8Qsxogg10h4naavdRts8to6IRtBALZpNef2f1IEea9E8bfgJ6Igji
 M7xacXKWGEVLTMpMO/xbVMeYoZwYUlsxPKwipdGoWOQeyvr/bbn6pKXg2Ko88YBwpTOj
 LTu7+PAYr1NGsngvR3sV23God8stnFoX5Kdd76ui9L7Sl7Q0dpm0WRRZhikFXu/+cP/Z
 WOnFoAQL2wPZt/Fh3SekVpl9eXXkzy71gnSqGb/C3t3PbaPnsiJCveNMaComz4RUsFjY
 aKmRwQ94DoZG4kCOxfFLeX8Amt97kg/Uza6mMY9xH0pJ3HihraInXq6BkXBQypKm1ltQ
 tVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434063; x=1793038863;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cA1kYpviYukq6qxxQH3ZLixjfNRZabHCuj4f2iyyXYk=;
 b=x8JYhUzskQzJEL2D1p0+MuC6CfJZ+CUoE2zmAJsLZ+MeHUamZoPshEcn+OIgc/IL9r
 vlIdwt88rp4CNn48zSoeK+648IG+1+SBr6+8m0nJBzbgJRqxImSvxIIwVzZGZ6RTwdqJ
 pth2ObnL116k/lXAHvRDLN8+xLYbPff3mpC/ftpgAvgJERLg+GYd5l6JIsP8nuKR83sV
 KnCdfgA5Rf3OHVzAZHwPrd9AgF2SKsiw4SX5v6LgSBMTBJTVDJjsFu1/h2F+wNkIehMN
 KyUm+gRUxaI0D6DxgFIh0X5WetxLMuQ/a8xB9IpWFmjOic3IlbUIQCyxnGwcSCndKaxW
 cTzQ==
X-Gm-Message-State: AFq9FYJUx+vT0Sqs9MiUmgprBRo8MW0DUFON3BOA48VVVpdL7epTtNI3
 cG0BP5QUmJXTxJGFZy0+6Eb0zRV3VcncNOaAghlYhrSIQBObw3eWx1+Tt15txXEaIma3/V4Z+di
 icNn3okrphaxtuoIENwJXtZ6B+835YVxM2OpWqPx5URdjdnFFi9jXo8Yl
X-Gm-Gg: AYBFou2KMsweW2/vL/RSjtfinMfNnHpMJfVK/iHi6NGaT+Ud/HjnAvmOIvyoVSp0Taw
 aWlc/YZ5x3Kw855qcFqbRn0hKt7gKYY16XIJVFFwURqrkoUSGYulI68rP8RGXm8TCtumAUe0gC3
 FYzlfbQasTxI0Vu/cW4E6xILYsoixpDklkdOWcfZRDZ5Kz7YKGVhY9/CKW6fnPk7lpeAtWAjxVQ
 2Vc2akO7QBZG5g/b2fUuCOP+1YdxFMP4n62c3U2Dv/Be7rIvKXwMScO7Lcy41LRfg2iU3KXTFZf
 lvdX4kyobPpX/F2Q9LdC3BkWYrKh+PTkpA455HGg3NfVNcXzVtQA05XCnP8rteaRGo3F8uor3lq
 ykeZRsjSB3WvxuYnIWSDWGQyK1muznhLw3jszfuH5pmWTMQsRMUQpMUwd
X-Received: by 2002:a05:600c:4e8a:b0:49f:ffd0:4039 with SMTP id
 5b1f17b1804b1-4a1d763ca4amr170445945e9.32.1792434063121; 
 Mon, 19 Oct 2026 11:21:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8a:b0:49f:ffd0:4039 with SMTP id
 5b1f17b1804b1-4a1d763ca4amr170445455e9.32.1792434062535; 
 Mon, 19 Oct 2026 11:21:02 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cdf2f0d1sm173497545e9.2.2026.10.19.11.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:21:01 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/12] iotests: Add io-delay-reporting test
Date: Mon, 19 Oct 2026 20:20:28 +0200
Message-ID: <20261019182028.45305-13-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test delay-report-ns and delay-stop-ns via HMP qemu-io (break, aio_read,
resume) on a null node (with blkdebug).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/io-delay-reporting   | 187 ++++++++++++++++++
 .../qemu-iotests/tests/io-delay-reporting.out |  90 +++++++++
 2 files changed, 277 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/io-delay-reporting
 create mode 100644 tests/qemu-iotests/tests/io-delay-reporting.out

diff --git a/tests/qemu-iotests/tests/io-delay-reporting b/tests/qemu-iotests/tests/io-delay-reporting
new file mode 100755
index 00000000000..7a51d2c4063
--- /dev/null
+++ b/tests/qemu-iotests/tests/io-delay-reporting
@@ -0,0 +1,187 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test the I/O delay QMP event.
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Creator/Owner: Hanna Czenczek <hreitz@redhat.com>
+
+import asyncio
+import iotests
+from iotests import filter_qmp_event, log
+
+DELAY_REPORT_MS = 5000 # ms
+DELAY_STOP_MS = 10000 # ms
+EPSILON_MS = 50 # ms -- small delta that can safely be added/subtracted
+NS_PER_MS = 1000 * 1000
+DELAY_REPORT_NS = DELAY_REPORT_MS * NS_PER_MS
+DELAY_STOP_NS = DELAY_STOP_MS * NS_PER_MS
+
+qtest_clock = 0 # ms
+
+iotests.script_initialize()
+
+def vm_qemu_io(qvm, virtio_blk_id, cmd):
+    log(f'[HMP] qemu-io to {virtio_blk_id}: {cmd}')
+    command_line=f'qemu-io -d {virtio_blk_id}/virtio-backend "{cmd}"'
+    log(qvm.qmp('human-monitor-command', command_line=command_line))
+
+def advance_clock_to(qvm, clock_ms):
+    """
+    Retain the current absolute clock time so we can step *to* a specific time
+    via `clock_step`.
+    """
+
+    # pylint does not like global much, but this is a test script, and not
+    # using global would just make this more complicated.
+    global qtest_clock # pylint: disable=global-statement
+    msecs = clock_ms - qtest_clock
+    log(f'[qtest] clock_step {msecs}ms to {clock_ms}ms')
+    qvm.qtest(f'clock_step {msecs * NS_PER_MS}')
+    qtest_clock += msecs
+
+def reset_clock():
+    """
+    Reset the internal qtest clock to 0; use before launching a new VM.
+    """
+
+    global qtest_clock # pylint: disable=global-statement
+    qtest_clock = 0
+
+def await_event(qvm, match):
+    evt = qvm.event_wait(match, timeout=30.0)
+    assert evt is not None
+    return evt
+
+def assert_no_event(qvm, event_name):
+    try:
+        evt = qvm.event_wait(event_name, timeout=0.1)
+        assert evt is None, f'Unexpected {event_name} event: {evt}'
+    except asyncio.TimeoutError:
+        pass
+    log(f'(No {event_name} event)')
+
+def run(error):
+    """
+    If @error is False, run both requests normally.
+    If it is True, inject an error into the second one.
+    """
+
+    log('')
+    log(f'=== Running tests with error={error} ===')
+    log('')
+
+    reset_clock()
+    with iotests.VM() as vm:
+        # Cannot use null-co.latency-ns, as that uses realtime (not qtest time)
+        # Need to use raw to get the read_aio event working
+        opts = {
+            'driver': 'raw',
+            'node-name': 'test-node',
+            'file': {
+                'driver': 'blkdebug',
+                'image': {
+                    'driver': 'null-co',
+                },
+            },
+        }
+        if error:
+            opts['file']['inject-error'] = [{
+                'event': 'read_aio',
+                'iotype': 'read',
+                'sector': str(4096 // 512),
+                'once': 'on',
+            }]
+        vm.add_blockdev(vm.qmp_to_opts(opts))
+
+        vm.launch()
+
+        log(f'[QMP] device_add id=vblk delay-report-ns={DELAY_REPORT_NS} '
+            f'delay-stop-ns={DELAY_STOP_NS}')
+        log(vm.qmp('device_add', {
+            'driver': 'virtio-blk',
+            'id': 'vblk',
+            'drive': 'test-node',
+            'delay-report-ns': DELAY_REPORT_NS,
+            'delay-stop-ns': DELAY_STOP_NS,
+        }))
+
+        try:
+            vm_qemu_io(vm, 'vblk', 'break read_aio read_0')
+            vm_qemu_io(vm, 'vblk', 'aio_read 0k 4k')
+            vm_qemu_io(vm, 'vblk', 'wait_break read_0')
+
+            vm_qemu_io(vm, 'vblk', 'break read_aio read_1')
+            vm_qemu_io(vm, 'vblk', 'aio_read 4k 4k')
+            vm_qemu_io(vm, 'vblk', 'wait_break read_1')
+
+            advance_clock_to(vm, DELAY_REPORT_MS - EPSILON_MS)
+
+            # Assert there is no event before the step
+            assert_no_event(vm, 'BLOCK_IO_DELAY')
+
+            advance_clock_to(vm, DELAY_REPORT_MS)
+
+            # But now there should be, right on time
+            events = [await_event(vm, 'BLOCK_IO_DELAY'),
+                      await_event(vm, 'BLOCK_IO_DELAY')]
+            events.sort(key=lambda event: event['data']['offset'])
+            for event in events:
+                log(event, filters=[filter_qmp_event])
+
+            # Have the read_0 request finish -- advance clock to test the
+            # correct duration
+            advance_clock_to(vm, DELAY_REPORT_MS + EPSILON_MS)
+            vm_qemu_io(vm, 'vblk', 'resume read_0')
+            log(await_event(vm, 'BLOCK_IO_DONE'), filters=[filter_qmp_event])
+
+            # Let read_1 hang for longer to trigger a STOP
+            advance_clock_to(vm, DELAY_STOP_MS)
+
+            # Read the pre-STOP notification
+            log(await_event(vm, 'BLOCK_IO_DELAY'), filters=[filter_qmp_event])
+
+            # Then the actual STOP
+            log(await_event(vm, 'STOP'), filters=[filter_qmp_event])
+            log('[QMP] query-status')
+            log(vm.qmp('query-status'))
+
+            # Have the read_1 request finish
+            advance_clock_to(vm, DELAY_STOP_MS + EPSILON_MS)
+            vm_qemu_io(vm, 'vblk', 'resume read_1')
+            log(await_event(vm, 'BLOCK_IO_DONE'), filters=[filter_qmp_event])
+
+            log('[QMP] cont')
+            log(vm.qmp('cont'))
+            log(await_event(vm, 'RESUME'), filters=[filter_qmp_event])
+            log('[QMP] query-status')
+            log(vm.qmp('query-status'))
+        except Exception:
+            # The VM will not be able to quit without these requests finished,
+            # which (without this block) would make the test hang instead of
+            # exit if something unexpected goes wrong
+            vm_qemu_io(vm, 'vblk', 'resume read_0')
+            vm_qemu_io(vm, 'vblk', 'resume read_1')
+            raise
+
+        # Test device unplug to verify that stopping the delay tracking timer
+        # works
+        log('[QMP] device_del id=vblk')
+        log(vm.qmp('device_del', id='vblk'))
+
+        # system_reset forces the device unplug to happen
+        log('[QMP] system_reset')
+        log(vm.qmp('system_reset'))
+
+        event = vm.event_wait('DEVICE_DELETED', 20.0,
+                              {'data': {'device': 'vblk'}})
+        assert event is not None
+        log(event, filters=[filter_qmp_event])
+
+        vm.shutdown()
+
+run(False)
+run(True)
diff --git a/tests/qemu-iotests/tests/io-delay-reporting.out b/tests/qemu-iotests/tests/io-delay-reporting.out
new file mode 100644
index 00000000000..99349d2b124
--- /dev/null
+++ b/tests/qemu-iotests/tests/io-delay-reporting.out
@@ -0,0 +1,90 @@
+
+=== Running tests with error=False ===
+
+[QMP] device_add id=vblk delay-report-ns=5000000000 delay-stop-ns=10000000000
+{"return": {}}
+[HMP] qemu-io to vblk: break read_aio read_0
+{"return": ""}
+[HMP] qemu-io to vblk: aio_read 0k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break read_0
+{"return": ""}
+[HMP] qemu-io to vblk: break read_aio read_1
+{"return": ""}
+[HMP] qemu-io to vblk: aio_read 4k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break read_1
+{"return": ""}
+[qtest] clock_step 4950ms to 4950ms
+(No BLOCK_IO_DELAY event)
+[qtest] clock_step 50ms to 5000ms
+{"data": {"action": "report", "bytes": 4096, "latency-ns": 5000000000, "offset": 0, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"action": "report", "bytes": 4096, "latency-ns": 5000000000, "offset": 4096, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[qtest] clock_step 50ms to 5050ms
+[HMP] qemu-io to vblk: resume read_0
+{"return": ""}
+{"data": {"bytes": 4096, "failed": false, "latency-ns": 5050000000, "offset": 0, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DONE", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[qtest] clock_step 4950ms to 10000ms
+{"data": {"action": "stop", "bytes": 4096, "latency-ns": 10000000000, "offset": 4096, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"event": "STOP", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": false, "status": "io-hang"}}
+[qtest] clock_step 50ms to 10050ms
+[HMP] qemu-io to vblk: resume read_1
+{"return": ""}
+{"data": {"bytes": 4096, "failed": false, "latency-ns": 10050000000, "offset": 4096, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DONE", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] cont
+{"return": {}}
+{"event": "RESUME", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": true, "status": "running"}}
+[QMP] device_del id=vblk
+{"return": {}}
+[QMP] system_reset
+{"return": {}}
+{"data": {"device": "vblk", "path": "/machine/peripheral/vblk"}, "event": "DEVICE_DELETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+=== Running tests with error=True ===
+
+[QMP] device_add id=vblk delay-report-ns=5000000000 delay-stop-ns=10000000000
+{"return": {}}
+[HMP] qemu-io to vblk: break read_aio read_0
+{"return": ""}
+[HMP] qemu-io to vblk: aio_read 0k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break read_0
+{"return": ""}
+[HMP] qemu-io to vblk: break read_aio read_1
+{"return": ""}
+[HMP] qemu-io to vblk: aio_read 4k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break read_1
+{"return": ""}
+[qtest] clock_step 4950ms to 4950ms
+(No BLOCK_IO_DELAY event)
+[qtest] clock_step 50ms to 5000ms
+{"data": {"action": "report", "bytes": 4096, "latency-ns": 5000000000, "offset": 0, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"action": "report", "bytes": 4096, "latency-ns": 5000000000, "offset": 4096, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[qtest] clock_step 50ms to 5050ms
+[HMP] qemu-io to vblk: resume read_0
+{"return": ""}
+{"data": {"bytes": 4096, "failed": false, "latency-ns": 5050000000, "offset": 0, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DONE", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[qtest] clock_step 4950ms to 10000ms
+{"data": {"action": "stop", "bytes": 4096, "latency-ns": 10000000000, "offset": 4096, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"event": "STOP", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": false, "status": "io-hang"}}
+[qtest] clock_step 50ms to 10050ms
+[HMP] qemu-io to vblk: resume read_1
+{"return": ""}
+{"data": {"bytes": 4096, "failed": true, "latency-ns": 10050000000, "offset": 4096, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DONE", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] cont
+{"return": {}}
+{"event": "RESUME", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": true, "status": "running"}}
+[QMP] device_del id=vblk
+{"return": {}}
+[QMP] system_reset
+{"return": {}}
+{"data": {"device": "vblk", "path": "/machine/peripheral/vblk"}, "event": "DEVICE_DELETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-- 
2.55.0


