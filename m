Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C177EEE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3X-0004KZ-Jy; Fri, 06 Feb 2026 15:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3K-0004FW-EL
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:46 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008O5-Py
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408208; x=1771013008; i=lukasstraub2@web.de;
 bh=5DRNtylFaST6/JPH9QU2U4TO4NvWnISJBshbkAaedFI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Kt1hymP0rdnp9K3KshAMuMSlX7fRWfIidexAzAThf5nRWqXhpYG57o1lwsr7oqNF
 BVEvobGD5z3nc8iwOC5gTNgRWBFt0Q0hl7bqSPA8D2RRMzfjyHvKX/sCgiUd5Vua4
 /kEQDCuDvUHtUX3OZ4ckiebDj9SULf05dj0umuBFt/nnnFO7RV9KrXYRfQ3cfQyCk
 mmwTotKKmvkVeMJem6s/mQO8VdATBPdYUZpvm6ohlxcx/VwWXBqYpbJhQBgL0ow9M
 B+7XkmijXTOem2rvYn+qDdiNKb0DCVzCkbTwmkKBWVCTIDpIbud1bUxgasdPbnp9F
 hGPsA3vlvCs65NwEXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myv70-1van6w31j0-00zJCq; Fri, 06
 Feb 2026 21:03:28 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:16 +0100
Subject: [PATCH v6 18/18] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-18-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGe3cIAmSSruvsKePa/q/yb6R3d18u0LSu3
 nS8OXASj/iJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WARhEACqnSOSV/Rk2zotN32GhnRMpmRohdbmiBR20zeg4Id2+8a3ai0LnBx987QaD4ziAcB0c1N
 lBjhlu1iGeU77Pc9BqLGAt51ujev6PbXH47iZAtOY+E1xfLQu3PJ5eHYjMsv0vJk78X6bRfL0fB
 s/QbROWhSVCQgNonDqzpf6+ycKuSLm/mCLp0K8vZcTWvRPYxlVAGoOdpTRnNrk755FWTofQbVp/
 01aGs7U2h4iMOCyXZFVccRfZkLlKlO2HOoIu48UI22tFxdy0L2CT7YJfdANWgWyceQQCoaA7GK9
 ETGw06hjjR8yyOn8S/Ulmtdz7dYRO4blloNgN2IWX8yxfLMYQuhWqQ0m4SqE7vXNusD78Dz+QVz
 OhPx2C+Od8m3ICQjVByUtMoCmeh0GON8Yijpc0Mq7LoLM4JFRTAhgVkt6SQ9ysWIDLRb1TUTMot
 zg0IGTbn7BFvUplE6wOYOLobi1O/JqOe/DCP6BOPsLphhVhacXCwzKt1dK7kiyqfXDh9TDENd5a
 HPdaYWgeRl4v656ZU+oEJDIu5NNUwHalj7To9+qCm11rmyvwUNmz5Ijo4z9Y1cgMgLeZz6th70n
 PBtCcrAbgcHO054L8D62f9KNs5snKP9aE+o8cERy+e8Jb8Zr+X1SCVjmMG6DUpowjG9mr40hota
 Lt8PCVx4Yl8B59Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Lw+aJQ/vz4IeyCp5ldJt0/YmZ84A4ASz613FKLm8Ygeu5YUwNtu
 q8kQ94qgAMstnBvdFdZcFmAcDWJhsxEYp9Kvn+qyu4OxnSvTZC/YTfzttcRHtHjIYMFNfTb
 VCZpvji4OsBMe9zc9i1QBDxsQEzYjSAMbPUUSPhCfmp75wdA7qqRvUbpRiDCdFBCl1C+3xS
 BOwhZsap8e17Wkn5v3ICw==
UI-OutboundReport: notjunk:1;M01:P0:Cj3NvltwMtg=;3dwLqbuR4cSDDPUun25X/KVlHzO
 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
 86qKQXXNKjyC7RJhYeFemdO3FxkeK
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


