Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB98E63CBE
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6ug-0006zf-7Y; Sun, 25 Jan 2026 15:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ue-0006yW-Oy
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:48 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uc-0006Cy-Af
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373645; x=1769978445; i=lukasstraub2@web.de;
 bh=V2wl7+xKW2VUs5IlZ39gvgGSN6Swz3GT8YAOMgvY2Y0=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mMlEMBuWRgpLc1jJXUVyaRZ+pTE+TW1HGdiztYZ8jh55GNdaD+1D51GK6ubHTsdC
 82B4Rw3PdVSVHtxFbdy3GyjkAp0Iqaak/u/aBMltrpJSjgkst/gRlaaYkoLZzUrAG
 F+CP+iRzJejajLSubNWaujOBMFZJz8p1DdLmPF+/CLW7RgZtY9bUNfSM+dxsGV1Qj
 bSCKj/XaWC45pVqgi2XJI+swtsMGMxUUrr6+Tp3Cj2Ccvs98CmFmd2H2gK8zEhYS0
 1gr68Clfp1HL7w3YWHoyh/MVGj5wQcqP95hCNdBj2jZZ6rDHc0p+h/d6WLFY1R/aV
 SzrBLKwrLZBMhjOgag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1vX8MX3w9p-004Sll; Sun, 25
 Jan 2026 21:40:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:15 +0100
Subject: [PATCH v3 10/10] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-10-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Vq0uip/eSPkRlYDXg+iQ5EdKb/P2Q7zchodJcpyMdqs=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/Grx+ZbqNGH100D4woVAlYxTtwnH6K5bypk
 +8f55hNPDSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xgAKCRA1qwsonF2y
 WEY+D/0SDOGyX+ugjqU+Usw69SBWzTz3XdgmKtSEXsn6P3nVQiyZPQDXWi1UOINLO1qAeYmUrYo
 2QWMVJ9r7NrZB0OvjFYh05QDg5JOSf5GmIdNqQZzpO+zBImzZg54MwonWTajhq8hKMlkSiRHkED
 AcIL6XFHetVSonNvCVUMvZaNU2t3c/c0iTffxKbEkZiNOYmNMNqu3t9N2Tm8RWp4FI+MrcRzWZx
 1haF2l0QHpPWGSGqC7bANd//acJSAostArSHdwrgsgQyHMGjaxUXF+vpAzUnciAYp7EY3S+SDy6
 +bZNC6upDGAfDl/nNUJwe04PbL3vuXrDsQ2fuy1PrcL36gjPPEaUsc1iQftffxXb6OnxVydd73k
 Iedz/jc9M8Ac64gKOK5eQwOIvJy8ParEx4elEzrwhuHlTMVdoAgYwhq9Obskuev08daAYEDQgLq
 aDSJbWPEIiMxemcao3K1c9SfM2VLcA11n9ANY3ROcc+LSt6FJPQksejOhuJTUaA5orrfVLLiDR0
 GBNqqaWuxZJKgxOnNx/oiD7yrXhsjqpucDeRAGuuwb1natbKEIAygVFvCBI3scKLHsu/vpGkwvN
 U0lF5ZSniFKRSlIdkh2C4FGjJUb4yo0qdFdBsUsE1pkFkMMOgST4kFqQPSx7lUFw0xIbuCeH76E
 AnCTD9rJLqnnroQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:+Otzk+ddWmecq07m4P/YnuJCryHvhxSyKStnhuNz2DoK4n5IY5u
 zZAGwR/BP4dmp1sBibazRga3C0uoC8R6/fWjcqQXVDst2+75uBbrHg5iV+MFDZwLi6WXDtO
 j0VFZy1IVngK7FQ8K1J9g7qj7PWsfYYzUsvYT1J+f8SbG2FJ3Yeo7xjNMkikrmKqL3qAJwV
 wSzKtfMC1tFKuqsiK5/3g==
UI-OutboundReport: notjunk:1;M01:P0:WaqLuQ9VoOU=;jtVijc6FU2N6ap0wUoSA6Y6oe9s
 +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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


