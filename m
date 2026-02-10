Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ED0EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohl-0005EH-BU; Tue, 10 Feb 2026 09:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohZ-00057r-NG
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:53 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohX-0005lT-HM
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733603; x=1771338403; i=lukasstraub2@web.de;
 bh=5DRNtylFaST6/JPH9QU2U4TO4NvWnISJBshbkAaedFI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XAz2aUsn2K2c0NTSiV+nTskYNABqa4ajTGgDPJplLuQSVEPSTlte/oC0zEKhFjGF
 t3m56biyFKtWgE2AALYwsxRve7q6YAT89qDoj1Eg0hUEFVTWFNZolkxotU+y5T15y
 qIKCPp8Y78AiiSCh6/wRvV8n+cDhlEM3Ob9R1c1rr/j9iVG5HMltQyDzNno+yiCH9
 ajJUpQ0LBzLhZBUz7o/2cccuWl/6EdKwY77tgnlnqlQgWpuxEWwgazOGwxM+hYOhf
 jp4+EHGEgCxEKVPEECDZ0uOk9fhTjZUDMgPL5Ea7LRbLrivmp7HT9h7BafcJ6EVTp
 nsiApKrkX7GQwHQFyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCqh-1vS6CD48Vz-00eV9N; Tue, 10
 Feb 2026 15:26:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:30 +0100
Subject: [PATCH v7 18/18] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-18-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Ad1R+f1Vk3I4YITt3rkJaiH1YHxPyeiDl6K
 fChv3Iz/P+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHQAKCRA1qwsonF2y
 WPdlEACnNMkELWOKoGz1xLv8O4YZP91hA7JxvzKblTZ7SKoTbgNi8zjNTS0mHiKG4AaL7MdIEj7
 NO2ZCWyX+Gu5gr52CSN10UANibhGJYet4c3DvAeX3Y/fD0uXH+CR15zrQo+W6vcwdWAOMZeyJcK
 FlLFdVrO1sC0hyl6r+l23F48hZ+xVTjO1t0jobCbRI6uE73lrPFdgVeWO5WeLW4jk8R6Ll/ElAI
 0aMBeJN48swJekIc03CR5Cm71RyuNYHjp51puy/iMcXzkV6DfeKgUpreZry2M27Faj6/cpUrhlD
 igbHVJGvvlg5rF2eVCjR2OATcKNSg7bj+fbxnD3rmKXQeiS+CvCjSHh86jBjjYwu8PKUW0TjsL4
 7+eWZSMvofB4JjQw9yPIcYavZM6Spfcl0Xj7k9UorBVLLbdxF2tWaY+BfF/noDyR51GDac4DcoZ
 JTr63wTBAbxF8XyRBbrca41B4DVaJ8y4kMf2gCIR2k32+hlWyLBuO/bNZThUAFpVchVHqnRyGif
 ogY7xmbzXKw59pmheoD5JUCugtvF84ctAHZfL45ZqzwMMcvEQzJxAQSEcoUE8vkVFUSY5s5AQ6M
 RjKP6a4KXXh2vT+FbgbKVgTfTP1DEjyKGBZV2659eXxnPOH0UUWJEmDrqFqa/n8MrPZBld0GSWm
 1pJ3mP3afBoJ/SQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:NMnynwR9zabIpF7VRP5WnaubOd7ERxLuRdtV5oUiVUmXPwi3knW
 GFqesdQR1PMrAZwSc6pZwU6tUkkWP9jKRst7/v9VEHtZisrV92URax7PzXzCpy6vGLxBxyk
 GhOaWRwOlHufEGHYCDUwa3xlUtVcgz48R5vqXeY8Ukyy42h8taIaEjs+3nr72/vRKPoa1p5
 zR0oaeucV7kAmFWNSTf4g==
UI-OutboundReport: notjunk:1;M01:P0:L/tEENQbTBs=;WkCRMKXJY8PiFo7wnkwazAbhHFo
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


