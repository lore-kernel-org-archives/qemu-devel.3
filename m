Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F78CEB26E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWd-00014Q-MS; Tue, 10 Feb 2026 11:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWX-0000p7-FW
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:38 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWV-0006zs-6l
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740606; x=1771345406; i=lukasstraub2@web.de;
 bh=5DRNtylFaST6/JPH9QU2U4TO4NvWnISJBshbkAaedFI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wwsS4T1yOywU173QJ0HJignKui+MYlOMOjITg1SfNlmpGsrSN0euptDGTv8XIOuz
 kLcHDoI3yC2GiYmLaZfy0U8cHMPxY5I4l8NDwGVPiywTQLvUr3QTQDLcD8SY6vJMH
 P13Z0sqKx38eYYoCUT9ztzoJ/V+96i8biVcNgrU65oSQnE15KBhr0oXHY3VINNeFB
 zLWRWjN+0Scc0DpaQvd371viy3iP//OLOYWuAFrzbh3Jd2XpjUwIndt1SJNQke32g
 rwpkukWfby0Ovtkr6LQH8JiDR6b73DGqcPGfihftKg0Ig4kp6W74pXQ0zkwGytCBQ
 ELvR4sGojSFbVZQXqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1vHL35342I-00azPd; Tue, 10
 Feb 2026 17:23:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:15 +0100
Subject: [PATCH v8 17/17] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-17-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t4Vq2gZiZhBFGjkrxHckUw+eD9okSqm1SxX
 gNL8G0W+26JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbeAAKCRA1qwsonF2y
 WO+4EACTDIPTkemUPnEjsv2m6m5MUMTTbJI4yaZAVLd4HZXTa97nCbUZFkQDse4MbIxsbdbFD0J
 c/mcz5cwCG0GGBh5gje4VlFCAXdZRXLGaPKeCsdOXyIhnBExB4I3tNYJcKCIkeGxtCqLotWvU/T
 XkHox+Wx244fA7JB8WPO4f3KwglQBHGYIRGCBfFWPPe9w3MCoQ7MmG17l0DEB3LWxOkfUzbzUDW
 fQsH34hBbgxi3s5E/m7HDp9SdEgPcs0Tv4hty/5z3hc8isFKYywfrpg+8G5bX0RcTQwn8kfRTNL
 OHMDCPFQvfnuksLID6Kv/+F1SOhgJlJ2EQiPHIWqsZgjdPolFFaX4ptVNtMUeyZ8b35k6X7aulT
 CqAALCOyRXtMO72cIqBQnXATfuxPKbCI7v9XLV+i4yZyaS6fMqVV7puOmC1L5J2tFYC+ZqnCAk2
 tISgpj1pPP+1aoG7EIlGIqL4S3D/no0kBmxfRdJbmyOTRjXTmgE43enBcpVGDIwgWA3Ar5yGwRr
 gMxSTjp8c/m+6pTrYgKwdZLkM6ZR0WOayvzThJSawQi9UqmO3jw1C2g/v0UCqgUCZ6V3mm0gyxi
 5MR+kvvTNPUqdrDKEUpyXup00yxplBBip7BOSYCFooq91A53FC0hHDUJycPyiszqya+2o6HwPOF
 9Hcc1LG6rtqcFUg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:rt+biBApfy17RNzSAq6EYYJ5yaapCJhlXy9GRcrLzIIutaLE6qc
 kBhZsqiFheyFpwsIdpw+p4Sju7Iz6+/Uu9ic8ycctZABp9HxM2KzcAZ/yqkFmJQ2ON/xcgk
 qZPAwfKqA3yukrhrbfC95cStcLLFj+Q15lZNFfurzSuPmS/tfzkr475poXhXg3PK0bXuaJl
 qgf2dwwMer7jOeM+dN81w==
UI-OutboundReport: notjunk:1;M01:P0:KYRJ8io21xM=;+2Jd5U00HxJOPE1Q6z/3akyh6r5
 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
 n2tZnW7c=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


