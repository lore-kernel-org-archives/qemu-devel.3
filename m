Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABA4E8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSG-0007Yv-MP; Tue, 03 Feb 2026 05:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS4-0007Gc-SY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:10 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS3-0002E4-2G
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113752; x=1770718552; i=lukasstraub2@web.de;
 bh=5DRNtylFaST6/JPH9QU2U4TO4NvWnISJBshbkAaedFI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kGNbRyqc498zliYwrHKxCgh4srV+bZpnkBxpWGddY9JEDVc5srwin1NPDD+4MRIu
 nIgiNCN/8Ec5ddMeubDaCjWy7+Wkw31mRjWR6FHGZyTclB6/aWpmpalL3fZgvaaRC
 0rwnjvWCaTFGuDg4By3tv4F6O8h+Bx46ICfTdCPFNV4kiz1sbnk+BlMGlPSVvrTbR
 El8+HZWPLy1SlTuRB28vZJ+flHis0RdRxh198y/VCDlCKArmE5B2BOYFkpZ5iwMvK
 g1uLG7g/vpwwm1de+Dt3N7xnorTNmnOrxL0v2A/QvFyqkcCOKdItSFduWZ+or5SZl
 TDbGAOsO4uijMg25mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFdB-1w7D8d1dZz-00TDTJ; Tue, 03
 Feb 2026 11:15:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:22 +0100
Subject: [PATCH v5 16/16] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-16-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=TYU6TTLFHjrH9WpcMw6oVhFbPAVy0WPrt4oU9i8UKQI=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQt8I5ZhVJgrBoLPYUubUzmavuyZB6FimEt
 S6GxaCIhamJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WEIsD/9unCoK8XI1sXohqjrLcu9aYcEqUNryKtIn7bKj7H2ZPPUO9vZS6FWVe3AGHLuaDRTOFu3
 gvInO/fCTRsSAmRsjHCj7Amrc0pZA/+o8kbFtIjC2cfujM2wIlzSmCqNIRyvfZ6NMZZZLlsQAjh
 ocyuY40elgQdIRXEtDGjONQzZAvF2Qp1BG/1tEDrJ+HLG95Sr99ZgVMMI/iaTXB2HL4WwC35s+/
 lpGfpLnVKhfmqvsPYsxBEURHpzcB15VNFZswfr8sY9iz1Q8/kevggS4tD0RUeUpEI7MN7fXSPHW
 P0FbAtfAyE2H49Zfm9HcbYr3iptjKKjAc0cmVEF6gkkMdXkTcRgnmb7bcPhX7/b4bHCQ5NOiFep
 Gor7UI4j4LmKBDbQz1M0b6kci9tIjjdrMwjc4MNDXhhK7/2andpokRwPd/K+2ZYXT9mlhj23Oti
 1X5jojOp4mM7gIGLRZI/BJeCIhI+ZzGIn4IEjgAhJ2GJcv/rAToolJwgtGG4PueyjaRO9wPXAmv
 SSg2Lo8r6QeJM6QQ80Pwx17Qg23KV/N4yHsXNTVuFtPcJqaHejsBJ1MF4zjkFsKeZRPLy2NVKLk
 Pdo1HbeFWW1ERScPFmtYCSi8Y4/VWxdEmaRk/uewpBX3p0JG4RrKGxPJlThtktr3F4OG6Ma833K
 Nb1G8OVWvMpVVWw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:MYLtUNlMGO0xEyXCjRw65xH33DaoECDc9EmUHo6DlWIUVksaPb7
 9rvxasGY+F9tbb1pmKO3e7+v+KEv8FoJ7BaHoNugH3Ej/hidghh3Fd5vA2cNyWJXRyH3pWo
 MUFNa1UST8ojqw6vF7NuNNLHtyUBtrGDfLZEAJm2Ny4z+TBrw+c+S/gFmEWIExqMr8f9kHb
 gqDfeAGHQ8dSUXPahVnzQ==
UI-OutboundReport: notjunk:1;M01:P0:4G6+xxSiHNw=;z+WCo6GAoCrHfBnUyhPLxNtjf6b
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


