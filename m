Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F4606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=Uz5H6aba
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRry6-0006vJ-FO; Fri, 13 Nov 2026 09:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRrxy-0006bG-Lz; Fri, 13 Nov 2026 09:09:23 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRrxv-0004RJ-Fm; Fri, 13 Nov 2026 09:09:22 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.58.50])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jQzdm6566z3y2B;
 Fri, 13 Nov 2026 14:09:16 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 13 Nov
 2026 15:09:15 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <armbru@redhat.com>, Guillaume
 Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v2 2/2] iotests: Make nbd-stale-connection test deterministic
Date: Fri, 13 Nov 2026 15:08:52 +0100
Message-ID: <20261113140852.702959-3-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
References: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 1877156620531286456
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTF1JsA+MLnxH9Dj7qhLTm25Nm4o53p3GaQgNqMUIRY23It9nRwWJ9TgYOVB8Hove0W8gUUYVM3qiECAG5tUCZgiYtDjSwOV5ct8RAVrxl12KPLsN34lx3Yi+0ikiVgxI9y1JuJwchjQvRnxU5zRTRs3oi9bS/ehGeqRMzD1AhfXVXUlob7QTkX/0JG6Xsgz6XwSk09UyiZwfFaJqmuqGs+tJfECPN3Wb1eYJtSTxugOEHlMRzd8AK3F2t/CmXEiQ4jJYHdblAu2p0S4EVflb//4HzFow7sSmoQelFuiDkAq2u62YiT6Zvup5k4dqV5yXSMQizkFGYEelA76SUJIH+DlLFbTJKSWqek28iUmH1GpkjACcx3lL8QPr3ZFl4gl7thbEXTGYxb+tgmzoy+8dejCvGBjEV/bDsSVHHt3C8IYd9VPYp/Dp5u4mmgn9t396+XSJ5JifPohgsG3LpEbpG9Vmu10hkn2FYUtPd5uaiBS6a/AiCA/EkvY4iqZx+smq0xg0fSbFqRgOBLiLyHxqcJpGul4r4g5byyVecRHRUaHlVhUsZxAysP8ZEwiwwXXmFNCX5583MHtu43B9O16xr5QmF4+kwF77pvDRWWyITGqMkgC+mLgQ1nzNRnlIjjuRPG8RZWg0qivftMTbBbGSdCgugVyyp5IDos74NcabO7KUg
DKIM-Signature: a=rsa-sha256; bh=KGcJOWN86dl8LqKRubF5zmk6oX/hhCsOYijf/YEW57E=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794578957; v=1; 
 b=Uz5H6abaflSFxANrc5uxGjsREQnCWy/dTUZ1GGS7b3H4Ntgjiw3pXFIQItjKQQOWFPLD5g1J
 z4dUCOf3uNuPUJnBqM08tkvxGlModMQ6zKMGIKyTCNSqFm8fNgUisQJC0/KJj0qr1UF4lS0E4R0
 VDrQq6/LiFbfxxjNDUh7Jn3M=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
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
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At the moment, the test sleeps to wait for the connector to park a new
channel, which can fail on slow or loaded hosts.

Poll the x-debug-query-nbd-client command to verify the current state
instead of relying on timing.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 tests/qemu-iotests/tests/nbd-stale-connection | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-stale-connection b/tests/qemu-iotests/tests/nbd-stale-connection
index e361bccfa9..3f7f68e979 100755
--- a/tests/qemu-iotests/tests/nbd-stale-connection
+++ b/tests/qemu-iotests/tests/nbd-stale-connection
@@ -12,14 +12,21 @@ import iotests
 from iotests import qemu_nbd_popen, qemu_img_create, file_path, log
 
 
-# estimated duration required by the connect thread to reach a running server
-MAX_NBD_CONNECT_DURATION = 1
-
 iotests.script_initialize(supported_fmts=['qcow2'])
 nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
 disk = file_path('disk')
 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
 
+
+def wait_for_parked_connection(virtm, node_name):
+    with iotests.Timeout(30, "connect-thread did not reach 'parked' state"):
+        while True:
+            client = virtm.qmp('x-debug-query-nbd-client', node_name=node_name)
+            if client['return']['connector']['state'] == 'parked':
+                return
+            time.sleep(0.1)
+
+
 with iotests.VM() as vm:
 
     vm.launch()
@@ -44,7 +51,7 @@ with iotests.VM() as vm:
         # in CONNECTING, the operation starts the connect thread
         log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
         # wait for the connect thread to get a new channel and stop
-        time.sleep(MAX_NBD_CONNECT_DURATION)
+        wait_for_parked_connection(vm, 'nbd0')
 
     iotests.log('=== NBD server down. The parked channel is closed ===')
 
@@ -56,5 +63,5 @@ with iotests.VM() as vm:
         # Wait for it to succeed
         iotests.log('=== Wait for the connect thread to park the new channel. '
                     'Subsequent operations are successful ===')
-        time.sleep(MAX_NBD_CONNECT_DURATION)
+        wait_for_parked_connection(vm, 'nbd0')
         log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
-- 
2.43.0


