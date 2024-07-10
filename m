Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49265C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRW3F-00039c-CA; Wed, 10 Jul 2024 08:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRW3D-00036f-9H
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 08:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRW3B-0004tt-Ec
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 08:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720613034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WxVATn/7oTvdKaGQFE/QHqmVJRmPO7JHQtZyaj0EZUM=;
 b=d6C4gzLQLodZdFpO5eJPzlOraUAkpxCXtBY2Ri5B5+DsuRHBCOAXqSEi7Ss5JXTS1EDz3U
 j1mf145HPbEJcgHhhEGZsoLZqCN8TN8O1ppio227PsV0Eot7yMRrIsdeZGI3PNFvpG/2r3
 f3N3v2GTBRHUolF9yUKkJBZ3elTaCQc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-AaNB9XQVO263BqFXYEYiAg-1; Wed,
 10 Jul 2024 08:03:48 -0400
X-MC-Unique: AaNB9XQVO263BqFXYEYiAg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28DE31955BD2; Wed, 10 Jul 2024 12:03:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.89])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A58B195421C; Wed, 10 Jul 2024 12:03:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: [PATCH] tests/avocado: Remove the non-working virtio_check_params test
Date: Wed, 10 Jul 2024 14:03:30 +0200
Message-ID: <20240710120330.78581-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The test has been marked as broken more than 4 years ago, and
so far nobody ever cared to fix it. Thus let's simply remove it
now ... if somebody ever needs it again, they can restore the
file from an older version of QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.45.2


