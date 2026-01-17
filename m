Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B99C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh70R-0007il-MY; Sat, 17 Jan 2026 09:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zn-0007Vt-F4
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zl-0002YD-8o
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658976; x=1769263776; i=lukasstraub2@web.de;
 bh=L+V4Gt5CUA9qShPGb1rbeQo/4nry+EVAZ8+KEKy/8m8=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VrYzS9rZEfONyFcq4EUfwlSvhlSCPSFrJz+1UnRI741x0svJfMXHP4F8I2iEOlqj
 fK5vumjgO0/a+EUymcHW1AQAuXLNnpj6QS1L4VYf0Yx5LET72xiGtniL+dEouAR9y
 sJjSSLhxXILBvawXFEDWSGct4iz6yUF6K68YLKZZ8ADhA/8jlm9eDaG0ObEnW2VJ6
 euv1TALiS7Hk6s1geo7GZCPUMui8qHlfJSbl8/R964eudqqifumRD6nQT+FTz+qDM
 YrpvVX48ALQ3Ogt7AQzecLnhWSFswiZqC7jB8nhhkIPwjGCqNJY2TyfB1PwZEa6G3
 HSn6Psets/AgczFQmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1vcjGy1v5U-004O36; Sat, 17
 Jan 2026 15:09:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:15 +0100
Subject: [PATCH v2 8/8] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-8-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4390; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Wy3VAnO0m0QZdX/VzG9DsOeurIr2LUv0/r/nVf1KFJA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gcXxtGDunTet0q2hWSXJ8MVACWa/Vlrn15F
 4uJW9Xn8SKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYHAAKCRA1qwsonF2y
 WEWID/9+dnUOkM7VIj5qMP/f3Lzh7wPWJsj/3+NvQUVjeyL2N3kECsXf5p13qYauxDd91Fxnbrh
 XCw8Ftz6GbIwThJcvpJqCHqfxDLIJlC2rJHHm5EwLaFDV5Fk3UbOSdfgjZz8/tczqD02Tl05yHW
 CySmY8Yfjws56EgucL/JAOPadVLZd+PgHHJj6Ua9RFwo9ru3kjKwKSjaNuc0exgX3BZrg+AZyGS
 8xK0csOysJx3KpGSVbxY4oW/sij+jOJv3BaBrTQcLzgnmAfhu2JjV0W89H4rKarxFkdH09zzG+2
 1RIkUFWHUYMIlJIE1YIiDyr+AaBA9//zRZ7e0ftWSQnsTj/lKGRdll31MfDU3X9nHDg9jCEUEOA
 wZigKys4hQRvfUNiTAQR5XlEs7weZxc4HPFp+9Hi4HYhMlCDnDcHSvaVVzy6GH7vijW+D1ZJT8P
 rru2g8ZFy5aL4XHmRkX0nENasE1/feZ4XAhqfYoZRyAC16u6uvf7Cr45OqI9rWyvZHxn4BtyMfr
 n1dV4jZYOy3XB32O+XJvHKVLtiyFRXb8EU3dpK1g1p+O1ARhrfLsUlBj6BWjKne8LFkQfSPeZYC
 nbjToK2KlCTX8DcYco5NkzES++VaGotRQqZaznj9mLyJIHC/87f8M9NR3HC32noyA0Bg9hhfG21
 cfqujE8m1qbHWHA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:sbqTXSiBn5cJl5m1SGU6Sxm5esa0mR4rY5WY1VCh8H2KvWzdR0b
 CQkdYEXPHTUMe+ye3TeuA0EbacWfO4YtcVS05Ze6dxUkUyZSgFps4UHMVuhhmogeRmjgRaX
 yPrsSycXpjw955ryS/R14avP4vuyGn8TJtB3bYkM/g2oJYwLwOeqL1jxDaUS62p0coeO4Sh
 vSKnlgCSLcOEyF1Bm6mVQ==
UI-OutboundReport: notjunk:1;M01:P0:N1WPQfWgbCM=;yYfb/Kx3uVA0nUKYYZI2Tqu+gt1
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 2052e207e57afdd3ab3ab1a447d55f5e2e5b5b87..7e361998d871b2c9a0e8065a15=
c004a9d841958b 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -233,8 +233,8 @@ Note:
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
@@ -262,7 +262,7 @@ Primary Failover
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
@@ -302,8 +302,8 @@ Wait until disk is synced, then::
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
@@ -334,8 +334,8 @@ Wait until disk is synced, then::
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


