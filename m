Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE4606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KImn+U0Q;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H0n+HUjl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIrz1-0006Xd-0n; Mon, 19 Oct 2026 14:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryc-0006OZ-Ig
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIrya-0005oi-Jg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJf5WoW+KCYT2WZIsVh8AsXHBLLVzMmsYUbsdGFsmtM=;
 b=KImn+U0QQy/YhMBSGtGBq+sbI2IC3NJz4+Oq0dJJfNOdKc89b1LQUdm++6EI+7CgiFfdjZ
 86776ADMC3dQRwEdzyY8XrsvlSFEWLMBTmIzdW+shU2Ebr44O/CNfs2aUbWDNHl1wrdZFV
 SKjFzlV7xCXxkoH8IOIQEcahbLzikE4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-lX7hR5uiMLOlatHKp_TAvg-1; Mon, 19 Oct 2026 18:20:46 +0000
X-MC-Unique: lX7hR5uiMLOlatHKp_TAvg-1
X-Mimecast-MFC-AGG-ID: lX7hR5uiMLOlatHKp_TAvg_1792434045
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso14101595e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434045; x=1793038845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eJf5WoW+KCYT2WZIsVh8AsXHBLLVzMmsYUbsdGFsmtM=;
 b=H0n+HUjlnMOC/zBfYe9Xl4K6JTWvRCNIpKQXsDbUr2WYKMNsnPApcJyeH5NFXbeLa4
 OxITojUDM5mxBD8hCo73qVYt/X3+FPKZ2H217hoXVVcTv9mSdNPxt8gRH8nGTsxe77c6
 In4PHQqBM0BPHOA5bMnfpzme5jGkPghGjX1aCpDnIp7wTKwDS0HGAfP6O0cMzgzWHnaM
 iOeYRX8NkHZm4/9OpbpmCk+XQkPuaojR49SAS4imcuo6NLUNM7qRqQO3UNmrQ07m6Vff
 /RBHvbHAe1D03x+x/xaf1+PMuacyECnoCU1BfrG9PZJQtaLSUn79PzU5hl0ezdkACIK+
 vDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434045; x=1793038845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eJf5WoW+KCYT2WZIsVh8AsXHBLLVzMmsYUbsdGFsmtM=;
 b=MBhr5BrSclyVxf23vACVPTUuU7ssDiULFK+s8p3IDyBQPnc22u975kAIannuI6JJVT
 PXMlk4mafYjUVIl99fEbdQOm0rzhWK/j/BpCxkiNCDq9d3cSKuGQDu+UvUcMLkaE7PNX
 AuGHODFlyceFqQzIvClqA2SB3OA71Z36mQg7lznGf3iEs1a4gD0AbxUgood2MavjnWMI
 WQ1+oCy3G92Fcn+4V52WR4QBtyzIkeegvsiBeRLT1tahN2HKsvqivxlX8ujneisJOY4l
 CNWtjADDbhK0nNhAhK6zBdU/Khj7jOs2bBVLVyJuEqYHMhvEo2Hl749sTJpJk3I9VXVS
 rnmA==
X-Gm-Message-State: AFq9FYJ4WFe8Dp5AxgeWU96uSuvXruW0AtEGa/BbFLFbE7jzFUw84Xg/
 uhcThqwzqcrzGrWMTI8DxkMAbhMxoptvTO2Hnr+ysYHKPVoaufsqd8PxJaI0VzxyzE7nxM/96iK
 3uXzC6imKUUoFKnUCTK+cQlI7n5Pag3miCahZjPKEgxFLJX7P3VYucGTu
X-Gm-Gg: AYBFou3QA95pPTx6V1cRe2/7n0LLrmKOK/B5aOfysNlLXG8bOXsJ3rYB4qlFcZFXnqF
 Oy17CneL0ipq9UdigJ7ruHeQ8a+GHh7+el1rtrUpoTQRmT53uikTzUV0hCKDhHqG3vh3LyhVpdL
 REPNzYXhuQ1TYaZCYeKhSVPir9LX05P7fmExo9jhCkAmPVasNKvhoh3ZHggxD7kQSECaQk6za1x
 qI78WsQgcKHn85jFA85WrI4fTVIX9mdCi9GMicQV5Qv/8rryGe905apzlwNEU0Pluka41xOZ/IZ
 n3hsG8loX1bBTsmxwu0E4JV+zAzga5T9ps5N731D2Py5UiD1FI/rRxGmdJ0d4fPYmot/FDGTziN
 36SqhIBG1yu552IVYHTupeGhVYzBtKLOIVboM2BwdErka3oE46fJPIsZc
X-Received: by 2002:a05:600c:3d8f:b0:4a1:e31f:e86b with SMTP id
 5b1f17b1804b1-4a1e31ff798mr114111855e9.28.1792434045303; 
 Mon, 19 Oct 2026 11:20:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8f:b0:4a1:e31f:e86b with SMTP id
 5b1f17b1804b1-4a1e31ff798mr114111435e9.28.1792434044910; 
 Mon, 19 Oct 2026 11:20:44 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cb6d82sm9577475e9.5.2026.10.19.11.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:44 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 04/12] iotests: PC-only test for I/O errors during suspend
Date: Mon, 19 Oct 2026 20:20:20 +0200
Message-ID: <20261019182028.45305-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Using IDE (PIO) and writing directly to the PIIX4 PM device, we can test
what happens when an I/O error occurs while the VM is suspended.

The moment we resume the request while the VM is suspended is the moment
of the SUSPENDED -> IO_ERROR transition, and the moment we issue `cont`
is the reverse IO_ERROR -> SUSPENDED transition.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 .../tests/io-error-during-suspend             | 155 ++++++++++++++++++
 .../tests/io-error-during-suspend.out         |  22 +++
 2 files changed, 177 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/io-error-during-suspend
 create mode 100644 tests/qemu-iotests/tests/io-error-during-suspend.out

diff --git a/tests/qemu-iotests/tests/io-error-during-suspend b/tests/qemu-iotests/tests/io-error-during-suspend
new file mode 100755
index 00000000000..5ef741d96b4
--- /dev/null
+++ b/tests/qemu-iotests/tests/io-error-during-suspend
@@ -0,0 +1,155 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Reproduce an I/O error while the guest is entering suspend
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Creator/Owner: Hanna Czenczek <hreitz@redhat.com>
+
+import iotests
+from iotests import filter_qmp_event, log
+
+iotests.script_initialize()
+
+# PC machine type required for PIIX4 and IDE
+if iotests.qemu_default_machine != 'pc':
+    iotests.notrun('Requires a PC machine')
+
+def vm_qemu_io(qvm, dev_id, cmd):
+    log(f'[HMP] qemu-io to {dev_id}: {cmd}')
+    command_line=f'qemu-io -d {dev_id} "{cmd}"'
+    log(qvm.qmp('human-monitor-command', command_line=command_line))
+
+def await_event(qvm, match):
+    evt = qvm.event_wait(match, timeout=30.0)
+    assert evt is not None
+    return evt
+
+def find_pci(qvm, vendor, device):
+    """
+    Return bus, slot, function of the device matching vendor and device ID.
+    """
+
+    for bus in qvm.qmp('query-pci')['return']:
+        for dev in bus['devices']:
+            if dev['id']['vendor'] == vendor and dev['id']['device'] == device:
+                return dev['bus'], dev['slot'], dev['function']
+
+    raise RuntimeError(f'PCI device {vendor:04x}:{device:04x} not found')
+
+def enter_s3(qvm):
+    """
+    Enter suspend via the PIIX4 PM device
+    """
+
+    bus, slot, function = find_pci(qvm, 0x8086, 0x7113)
+    pci_pm_addr = 0x80000000 | (bus << 16) | (slot << 11) | (function << 8)
+
+    # Config registers:
+    # - 0x40: Set the power management I/O range base
+    # - 0x80: Bit 0 enables that range
+    # I/O range:
+    # - +4: PM1a_CNT
+    #   - Bits 10..=12: SLEEP_TYPE (1 for suspend, see `acpi_pm_cnt_write()`)
+    #   - Bit 13: SLEEP_ENABLE
+
+    arbitrary_pm_io_base = 0xb000
+    log('Setting up PIIX4 PM I/O range')
+    # Setting the base address
+    qvm.qtest(f'outl 0xcf8 {pci_pm_addr + 0x40:#x}')
+    qvm.qtest(f'outl 0xcfc {arbitrary_pm_io_base:#x}')
+    # Enabling the range
+    qvm.qtest(f'outl 0xcf8 {pci_pm_addr + 0x80:#x}')
+    qvm.qtest('outb 0xcfc 0x1')
+
+    log('Going to sleep')
+    pm1a_cnt = arbitrary_pm_io_base + 4
+    pm1a_value = (1 << 10) | (1 << 13)
+    qvm.qtest(f'outw {pm1a_cnt:#x} {pm1a_value:#x}')
+
+def ide_issue_pio_read(qvm, lba, sectors):
+    """
+    Issue a read request from the master device.
+    Does not read the data through PIO, though.
+    """
+
+    for port, val in (
+            (0x1f6, 0xe0 | ((lba >> 24) & 0xf)), # 0x40 selects LBA
+            (0x1f2, sectors),
+            (0x1f3, lba & 0xff),
+            (0x1f4, (lba >> 8) & 0xff),
+            (0x1f5, (lba >> 16) & 0xff),
+            (0x1f7, 0x20), # WIN_READ
+        ):
+        qvm.qtest(f'outb {port:#x} {val:#x}')
+
+with iotests.VM() as vm:
+    # So we have PIIX4
+    vm.add_args('-machine', 'pc')
+
+    failing_sector = 42
+    vm.add_blockdev(vm.qmp_to_opts({
+        'driver': 'raw',
+        'node-name': 'test',
+        'file': {
+            'driver': 'blkdebug',
+            'inject-error': [{'event': 'read_aio', 'iotype': 'read',
+                              'sector': str(failing_sector), 'once': 'on'}],
+            'image': {
+                'driver': 'null-co',
+            },
+        },
+    }))
+
+    disk = 'ide-disk'
+    vm.add_device(f'ide-hd,id={disk},drive=test,bus=ide.0,unit=0,'
+                   'rerror=stop,werror=stop')
+
+    vm.launch()
+
+    try:
+        # Issue a read request from a guest device (to the failing sector), and
+        # have it pause before it returns
+        vm_qemu_io(vm, disk, 'break read_aio r0')
+        log('Issuing read')
+        ide_issue_pio_read(vm, failing_sector, 1)
+        vm_qemu_io(vm, disk, 'wait_break r0')
+
+        # Read request is paused now, let's suspend the VM
+        log('Entering suspend')
+        enter_s3(vm)
+        log(await_event(vm, 'SUSPEND'), filters=[filter_qmp_event])
+
+        # Should be suspended now
+        log('[QMP] query-status')
+        log(vm.qmp('query-status'))
+    except Exception:
+        # The VM will not be able to quit without this request finished, which
+        # (without this block) would make the test hang instead of exit if
+        # something unexpected goes wrong
+        vm_qemu_io(vm, disk, 'resume r0')
+        raise
+
+    # Resume the request, which should run into an error thanks to our blkdebug
+    # configuration
+    vm_qemu_io(vm, disk, 'resume r0')
+    log(await_event(vm, 'BLOCK_IO_ERROR'), filters=[filter_qmp_event])
+    log(await_event(vm, 'STOP'), filters=[filter_qmp_event])
+
+    # Should be stopped now (not just suspended)
+    log('[QMP] query-status')
+    log(vm.qmp('query-status'))
+
+    log('[QMP] cont')
+    log(vm.qmp('cont'))
+
+    log(await_event(vm, 'RESUME'), filters=[filter_qmp_event])
+
+    # Should be suspended again (error was injected 'once', so should be gone)
+    log('[QMP] query-status')
+    log(vm.qmp('query-status'))
+
+    vm.shutdown()
diff --git a/tests/qemu-iotests/tests/io-error-during-suspend.out b/tests/qemu-iotests/tests/io-error-during-suspend.out
new file mode 100644
index 00000000000..353f18250ad
--- /dev/null
+++ b/tests/qemu-iotests/tests/io-error-during-suspend.out
@@ -0,0 +1,22 @@
+[HMP] qemu-io to ide-disk: break read_aio r0
+{"return": ""}
+Issuing read
+[HMP] qemu-io to ide-disk: wait_break r0
+{"return": ""}
+Entering suspend
+Setting up PIIX4 PM I/O range
+Going to sleep
+{"event": "SUSPEND", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": false, "status": "suspended"}}
+[HMP] qemu-io to ide-disk: resume r0
+{"return": ""}
+{"data": {"action": "stop", "device": "", "node-name": "test", "nospace": false, "operation": "read", "qom-path": "/machine/peripheral/ide-disk", "reason": "Input/output error"}, "event": "BLOCK_IO_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"event": "STOP", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": false, "status": "io-error"}}
+[QMP] cont
+{"return": {}}
+{"event": "RESUME", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+[QMP] query-status
+{"return": {"running": false, "status": "suspended"}}
-- 
2.55.0


