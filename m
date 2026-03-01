Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87DAFD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmI2-0001HE-UX; Sun, 01 Mar 2026 14:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHu-0001CK-9B
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:10 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHs-0003YB-31
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392614; x=1772997414; i=lukasstraub2@web.de;
 bh=E8fQx4IKgnAm6YubDXuh85OWLGDWOvvXmk2YMWUkr38=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GMpKgyq9tponCVVYnB7W47D1pEBRklnsOv4cgCklT7+KFDXCzBkakNgDEd4uGwli
 tmq5iU9GjuICNUA19wzMKrchX1FC2cOg+kGKSLmIkwQtZrM8f3VZd4kqDUbmi6Pav
 QsDyOfxMUeXPxFl4HRZ8v6fhg6hnOj94xy4BqMnYP43k0e3h7m+QdBL5u2dHuB//+
 wJ4VKX1/5fUKfTh+piE5ByZZcYisezTs/ta75X28Hu8OF8xCyGyGkBV8Jn8TcW1gs
 aIBX6bNzQkjX0UvJMbefqt2mGWiqtdQZY5RlADmAY0aprowXMLm50kj1lsREu+lsW
 ZYRwxRDhKlNNiLxP/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxeE-1vGsww27dg-00ouQU; Sun, 01
 Mar 2026 20:16:54 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:42 +0100
Subject: [PATCH v11 17/21] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-17-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=pUq20iNV0WnXQSUmrEA2fewmY1+dKjnmaS5gYKFAorU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCd5JOCAcBzNLp5xR5LDJtDrGqTb9EL8K9of
 wnw9K7uxciJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WAc2D/9w9nC/cG/f3VIdFdHRv8KLftqI7nINUkr+n/tXUW5z/g+UaplwKqsDa4nnBPHpUZsESX5
 qDKzo2ojnMVb+jzj36PAcH8WjZKjoajen1lnEeA3XV4dcSzg+dRXhrwKHTkZgD+PL4Mr5IMg9wY
 vhw0Id5aAjz3RRkBw/0meZNLhVfuhuYXZSI1NU2xC8gpf30t64YpWtt7SteqkHE+eAXVQKUFG8t
 gvRJO1etc0sHbgozgeA/QItnMCc/TaJcPL2kNw3+eDj9pdTvshjhOVQasbj3B8mDpqVnnvVzPOM
 WCGYlD2BWVMo0CZgYNIwSsIdRGETxOMvPWz+2kj9COMLsCHjKirnNRxMgVqM8wvEjbOnBPeNcxg
 /5uk+PxZ955+Xl1CaokXZXwkaYE54bAdV8kosLbFK36DGlWJW04ftevYoekXEVpXt3xN6neYVSs
 b7JPzsmljt38nNjT8Dzb7HyABZuae6Xy/9dWQn0jdUlZGOdPLHsOLKVamkRowJJ2WJiFxagO2D0
 7nMf/mr59J9jeJD8nOLhMGWu4FbISbb5csg0OeItIpyhQbMC08SKv1zfjsNR927Yqa1+t/Z5AyO
 1atP8k84w8+SKLXksrTs90lVxV+VpEvD9Ez70nqZ+uENztNmJ6J22ewcMTzDNIo0y1PFc+KiboG
 0sLshUZ1NNALgPA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:4Hj+cRKitab/AYZvnNbn8Qr5Lt862hMIXlFoJ9flFCfYdPb5eOJ
 870d2e/5NDdiCz1hlPNjFr90dxoL6DVAqmBkVUGAhb1iRBbuPDasEeZ5MmQXkDE6KFxZ9yV
 O8A/BEiLvD/Lf5mHTQSCxTDHSX2ss68AF3SW5PX7fXCCkENQX0Bq4MGUE4PmRRV9bXpcQRF
 YB+bgXOHEZHKR81sYp7uw==
UI-OutboundReport: notjunk:1;M01:P0:WY8KUtlrQb4=;YWjcESCt4kFFwUPoDQngbI3DjZa
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On the primary side we don't actually need the replication
block driver, since it only passes trough all IO.
So simplify the setup and also use 'blockdev-add' instead of
'human-monitor-command'.

This is how my clients use colo in production.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 75abbd80298df79223cb8e70064a5dc83d70f4eb..f7d3b6439cf3401a58c4126342=
39d1a43999a10e 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -240,8 +240,8 @@ Note:
 **4.** On Primary VM's QEMU monitor, issue command::
=20
     {"execute":"qmp_capabilities"}
-    {"execute": "human-monitor-command", "arguments": {"command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "nbd0" } }
     {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
=20
@@ -269,7 +269,7 @@ Primary Failover
 The Secondary died, resume on the Primary::
=20
     {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "child": "children.1"} }
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_del replication0" } }
+    {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"} }
     {"execute": "object-del", "arguments":{ "id": "comp0" } }
     {"execute": "object-del", "arguments":{ "id": "iothread1" } }
     {"execute": "object-del", "arguments":{ "id": "m0" } }
@@ -309,8 +309,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out=
" } }
@@ -341,8 +341,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.1", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", =
"queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "indev": "compare_out" } }

=2D-=20
2.39.5


