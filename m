Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAA5E9B357
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Q2-0000W4-51; Mon, 02 Mar 2026 05:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O0-0006aX-Bw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nw-0007J9-CF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446816; x=1773051616; i=lukasstraub2@web.de;
 bh=E8fQx4IKgnAm6YubDXuh85OWLGDWOvvXmk2YMWUkr38=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=W1RBxYagvcwMaoYU4N7tJj3tHi9GPfJ0jmb5NyMTAbygyCBlpsTPfZa0NvsX18mF
 oRUcF9yUFYonVinHwUBVzxoj1J0kqVsM95oAJHziK+SVbSWGcuD4EEb96RBkHIBzv
 /4YH/MtEHy7sQlu4gDPn9AYjZsXq1AvFne1N+V2X1hlX1iBcxAtL4CIVF2BlRo+QE
 XJuEhJtyqteXN8hehcY/DunO184qIskWZ5cRWfhSSOtUno6+zqUq5o18Ex2iN6y+e
 oyrmMq+KkM6DXTKO+0ec23wmwnkb7IaMccsI3E1rPA5ZqyNss4tVa+f/Xbne7GeLf
 AqcwUqkLdXzOenNIWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1vU1EM2gT0-00lrWj; Mon, 02
 Mar 2026 11:20:16 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 17/21] qemu-colo.rst: Simplify the block replication setup
Date: Mon,  2 Mar 2026 11:19:59 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-17-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=pUq20iNV0WnXQSUmrEA2fewmY1+dKjnmaS5gYKFAorU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpS5x5ctoONdhVNNqjmRN7UfndwnZB2fnHm
 aqlPdrvimSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WEGeEACfS32NcG1BJEMBiprmW1Qe7VYmhwC0qiBxcHSrlDIC8s43iNbaKrdE3VNGTLCAHC1hCqu
 LUypp31SacydLHONObGMlYS94zer/Zgp7EvSFF5xeH7/zizsDMM3BiyR1omQqj/FMvZiikejc/l
 ofOJ6clJWfMmWUe/c557wA/op4clkC4dIwIU81ZhiGYC6myYSG2BIwGc0zzie1U/wdp5VL9SKJw
 FI9ZiQGtWz+Zzaovqujy0pB9MysfodfvW830IQDhgqkyTZN4zYI7SXt7DirrrhzBwRLBeebZI4l
 +pyrfXESzn28WE77jMLWRrZ0pP/D667HkPRF5WoRX+DM7bLe5UwOd8qh6mlbDy5wPl9Preiy7BI
 MJ0pZl2B5UWn+UXkrBwiLV9JQHd/TuP2HQDo6yrOK1C6RNXHrLI4Aln+ArLjwzGdt5+r0gBVG1F
 UJEwufZ8PAKmLvRpXGQADcgCdx5/D01aojtmtXjC3RSdEC1Y9qwSZQ0jvto0issz+3MNCLgT+aK
 AAC6eSaQ9ZldDWiWZIJJaSGWzQSZ2T5Vl54DpoP3m4m3o0xIKO2M+UnkC27ZwngOYxj5+QHthHI
 9Q9UYxiar12eOCAYZIOPe18WLEkOjWhnZtYVd72FyGRShSVgjbBMrr1T+grA7xwxpAOlLIaWQNV
 DsdU1tuIN6XnLPg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ajazl1Si6ZJMNw6qMGqU690xWGzmidRf5Zsebax7QrIEGvYntx1
 5SsazIzatdFSRtjgraXlhLFro9ZEV+ZY+bpd6m6LetPxrWxk0ijsf+ThnCu6jGwhK8yXUrS
 s1QQnt7qS/Z4A/SWU9+QQDAj4plQSBYR4HWBz0o2gjSjqJ0EUHRdHKXWojMSA5sFyf85l68
 3VJxf95V6xJDuyYnOD0nw==
UI-OutboundReport: notjunk:1;M01:P0:TyvfrqdyTq4=;3JUQ+bl62M11HOlZ5yKr5iukhrJ
 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
 83spOH7QPjYKY8mdUkTAH6QIGmQKQ
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


