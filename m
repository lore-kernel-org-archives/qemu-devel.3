Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C0C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2XE-0003Bp-73; Wed, 17 Jul 2024 07:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2VB-0001oS-U1; Wed, 17 Jul 2024 07:07:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Uv-0007TN-G6; Wed, 17 Jul 2024 07:07:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 529C47B37A;
 Wed, 17 Jul 2024 14:06:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B9F3C10B28F;
 Wed, 17 Jul 2024 14:06:40 +0300 (MSK)
Received: (nullmailer pid 844406 invoked by uid 1000);
 Wed, 17 Jul 2024 11:06:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 08/16] tests/avocado: Remove the non-working
 virtio_check_params test
Date: Wed, 17 Jul 2024 14:06:32 +0300
Message-Id: <20240717110640.844335-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717110640.844335-1-mjt@tls.msk.ru>
References: <20240717110640.844335-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The test has been marked as broken more than 4 years ago [*],
and so far nobody ever cared to fix it. Thus let's simply remove
it now ... if somebody ever needs it again, they can restore the
file from an older version of QEMU.

[*] https://lore.kernel.org/qemu-devel/4bbe9ff8-e1a8-917d-5a57-ce5185da19fa@redhat.com/

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
(mjt: add reference as suggested by philm)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/avocado/virtio_check_params.py | 143 ---------------------------
 1 file changed, 143 deletions(-)
 delete mode 100644 tests/avocado/virtio_check_params.py

diff --git a/tests/avocado/virtio_check_params.py b/tests/avocado/virtio_check_params.py
deleted file mode 100644
index 5fe370a179..0000000000
--- a/tests/avocado/virtio_check_params.py
+++ /dev/null
@@ -1,143 +0,0 @@
-#
-# Test virtio-scsi and virtio-blk queue settings for all machine types
-#
-# Copyright (c) 2019 Virtuozzo International GmbH
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-
-import sys
-import os
-import re
-import logging
-
-from qemu.machine import QEMUMachine
-from avocado_qemu import QemuSystemTest
-from avocado import skip
-
-#list of machine types and virtqueue properties to test
-VIRTIO_SCSI_PROPS = {'seg_max_adjust': 'seg_max_adjust'}
-VIRTIO_BLK_PROPS = {'seg_max_adjust': 'seg-max-adjust'}
-
-DEV_TYPES = {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
-             'virtio-blk-pci': VIRTIO_BLK_PROPS}
-
-VM_DEV_PARAMS = {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=scsi0'],
-                 'virtio-blk-pci': ['-device',
-                                    'virtio-blk-pci,id=scsi0,drive=drive0',
-                                    '-drive',
-                                    'driver=null-co,id=drive0,if=none']}
-
-
-class VirtioMaxSegSettingsCheck(QemuSystemTest):
-    @staticmethod
-    def make_pattern(props):
-        pattern_items = [r'{0} = \w+'.format(prop) for prop in props]
-        return '|'.join(pattern_items)
-
-    def query_virtqueue(self, vm, dev_type_name):
-        query_ok = False
-        error = None
-        props = None
-
-        output = vm.cmd('human-monitor-command',
-                        command_line = 'info qtree')
-        props_list = DEV_TYPES[dev_type_name].values();
-        pattern = self.make_pattern(props_list)
-        res = re.findall(pattern, output)
-
-        if len(res) != len(props_list):
-            props_list = set(props_list)
-            res = set(res)
-            not_found = props_list.difference(res)
-            not_found = ', '.join(not_found)
-            error = '({0}): The following properties not found: {1}'\
-                     .format(dev_type_name, not_found)
-        else:
-            query_ok = True
-            props = dict()
-            for prop in res:
-                p = prop.split(' = ')
-                props[p[0]] = p[1]
-        return query_ok, props, error
-
-    def check_mt(self, mt, dev_type_name):
-        mt['device'] = dev_type_name # Only for the debug() call.
-        logger = logging.getLogger('machine')
-        logger.debug(mt)
-        with QEMUMachine(self.qemu_bin) as vm:
-            vm.set_machine(mt["name"])
-            vm.add_args('-nodefaults')
-            for s in VM_DEV_PARAMS[dev_type_name]:
-                vm.add_args(s)
-            try:
-                vm.launch()
-                query_ok, props, error = self.query_virtqueue(vm, dev_type_name)
-            except:
-                query_ok = False
-                error = sys.exc_info()[0]
-
-        if not query_ok:
-            self.fail('machine type {0}: {1}'.format(mt['name'], error))
-
-        for prop_name, prop_val in props.items():
-            expected_val = mt[prop_name]
-            self.assertEqual(expected_val, prop_val)
-
-    @staticmethod
-    def seg_max_adjust_enabled(mt):
-        # machine types >= 5.0 should have seg_max_adjust = true
-        # others seg_max_adjust = false
-        mt = mt.split("-")
-
-        # machine types with one line name and name like pc-x.x
-        if len(mt) <= 2:
-            return False
-
-        # machine types like pc-<chip_name>-x.x[.x]
-        ver = mt[2]
-        ver = ver.split(".");
-
-        # versions >= 5.0 goes with seg_max_adjust enabled
-        major = int(ver[0])
-
-        if major >= 5:
-            return True
-        return False
-
-    @skip("break multi-arch CI")
-    def test_machine_types(self):
-        # collect all machine types except 'none', 'isapc', 'microvm'
-        with QEMUMachine(self.qemu_bin) as vm:
-            vm.launch()
-            machines = [m['name'] for m in vm.cmd('query-machines')]
-            vm.shutdown()
-        machines.remove('none')
-        machines.remove('isapc')
-        machines.remove('microvm')
-
-        for dev_type in DEV_TYPES:
-            # create the list of machine types and their parameters.
-            mtypes = list()
-            for m in machines:
-                if self.seg_max_adjust_enabled(m):
-                    enabled = 'true'
-                else:
-                    enabled = 'false'
-                mtypes.append({'name': m,
-                               DEV_TYPES[dev_type]['seg_max_adjust']: enabled})
-
-            # test each machine type for a device type
-            for mt in mtypes:
-                self.check_mt(mt, dev_type)
-- 
2.39.2


