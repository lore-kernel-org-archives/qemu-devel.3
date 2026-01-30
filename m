Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1326DE6BF05
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOj-0003gs-AG; Fri, 30 Jan 2026 07:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOh-0003R3-Lb
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:47 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOf-0001uN-So
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775278; x=1770380078; i=lukasstraub2@web.de;
 bh=G158C2Fa8nrbB9ID8An2zgaBGN+nt7yzulw+cALwfxo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wbeau2TBCanEnrcpZNw/F3/Cqx11P1nLxAsMDhn7wqbnj9xnhbpNqHd0jSmdvHaS
 AHbTq/eK5Nssln54m1dcj1mCqexJTGWR3nrVAH4+UJ8oS59vjHP1ghslZaa3LwuXJ
 nK+bFf9CERxY8kp/qGD2+TpP6MCq2dIg+0oxQZOFzcDXeRVCMC9H4yL1IqS0osVZd
 MCjlnc5fO7Dag9c9HCbLPTwn7WCk1y64o4eWDcu8YrRj2ruEqHvrRKWWhd2uAhIFx
 jDE7RHXLcrf4C15G2M6lqeZ8u16eWxzHi8yHeQtruFiTYKdw19KFmMeXO3NOuMem0
 LfCd5/HoCv5hHzZQEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5bT-1vE2S30KLN-00PQ2v; Fri, 30
 Jan 2026 13:14:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:22 +0100
Subject: [PATCH v4 14/16] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-14-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3147; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=HjRkk3PLsLjQtpMcn7YOFBq4HgSWnQadmFyAlnP7/W8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCmr2LVtHy783HsODxBTIr+ZHY27Bf4KLUof
 80YzM/Dp9SJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpgAKCRA1qwsonF2y
 WJNbEACoPatXJrnbzdHm1hPWWNokfvQFIEgfw+Co6B2uRZFGIauMH8DquaDOoE0OpLKziv0Ggh7
 ss226rpCy3WnX3OyrWUedDM4ocoWWrtuCtcWc0Q0K2b9nlaRV9JJ1Wm/sb46Ca17EE9stwyS2Sf
 goTY9JAk51N9TJxKVfHG1tO6FUMElm8nI72qNPYq1dnmB1SDknmSqLJJrEdBYJI1UIK9BbDmLPs
 eBiOM90W70+3fwnnOGyGgNMRdv2fQ88ILDe19PGk1P+TIaBGf5Ahbd6wDRekQOUL5Wad23uoUk2
 cyt6M9c4wI7u6ePXFmOeutBjzfp8//8Xh5JOi6t+M0sMKYxphvivH2yO5Qq+Y42TST1LScmEE4r
 NktuQp7Zwwb0jqZS9Z8Ap4+bIvJpaWHVHps6ZlKXuuXh+kc3J/LU6PM/UBdbVYf6t+D8WfU9xjC
 SX2aidKpCPQ6kAcotDobKmK9R8bapFtwzpaS0OCwdShCN2jt0n00P4lKHB7iF4EOfdIMouHvW8u
 0G0QBCWDpAsKxv8hB3H1PEDo6e9P8xOI/ldCAPiL+Xmoi74JUA7kUnmgkB9nbfOxOX83bPNPwxV
 +pb3N3yffLU6GHEdfSqU0sGLRdHg4Dhtc5nvWglxxVljXCGhzsKiBd0uaspWYctbAu+xdm/+v2m
 zLnaOgBlMeSkjyQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:nqmBOFtKVY51fy4QD0eUUK8mUB6A05sJb/WnIygp/qrIYuoKFuh
 cSrmtBn2DQkgopBiHJWWM0XdAk9ja5865L/Ab7HDP8fayrSnHEdY0BaeErM8+DfDvvPpkJ3
 Ln78U7hYeuYmDxuTGtho6mlsPlZhP8VGGTsJDxzf0pqUdIOPIN+gAE8IpHRt6rpIqFqCuru
 2b9xCFayHkWmpYYKUK7AQ==
UI-OutboundReport: notjunk:1;M01:P0:XAMrx2zN5t4=;PvJu5Cql2xrQAizef/SAD/jWgAJ
 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
 iTIZszdnP82bfIrAdRjvCOq7+CDoi
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 4b5fbbf398f8a5c4ea6baad615bde94b2b4678d2..a70e61aa09391cda933031535f=
a982d27cf6654b 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -1,13 +1,6 @@
 Qemu COLO Fault Tolerance
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
-| Copyright (c) 2016 Intel Corporation
-| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
-| Copyright (c) 2016 Fujitsu, Corp.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
 This document gives an overview of COLO's design and how to use it.
=20
 Background
@@ -82,8 +75,8 @@ Overview::
         |   Storage     |  |External Network|       | External Network | =
|   Storage    |
         +---------------+  +----------------+       +------------------+ =
+--------------+
=20
-Components introduction
-^^^^^^^^^^^^^^^^^^^^^^^
+Components
+^^^^^^^^^^
 You can see there are several components in COLO's diagram of architectur=
e.
 Their functions are described below.
=20
@@ -157,14 +150,21 @@ in test procedure.
=20
 Test procedure
 --------------
-Note: Here we are running both instances on the same host for testing,
+
+Setup
+^^^^^
+
+Here we are running both instances on the same host for testing,
 change the IP Addresses if you want to run it on two hosts. Initially
 ``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Host=
.
=20
+COLO uses double the guest ram size on the secondary side. The Qemu versi=
on
+should be the same on both hosts.
+
 Startup qemu
 ^^^^^^^^^^^^
 **1. Primary**:
-Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all=
 hosts.
+Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all hosts=
.
 You don't need to change any IP's here, because ``0.0.0.0`` listens on an=
y
 interface. The chardev's with ``127.0.0.1`` IP's loopback to the local qe=
mu
 instance::
@@ -192,7 +192,7 @@ instance::
=20
=20
 **2. Secondary**:
-Note: Active and hidden images need to be created only once and the
+Active and hidden images need to be created only once and the
 size should be the same as ``primary.qcow2``. Again, you don't need to ch=
ange
 any IP's here, except for the ``$primary_ip`` variable::
=20
@@ -353,8 +353,9 @@ Wait until disk is synced, then::
     {"execute": "migrate-set-capabilities", "arguments":{ "capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
=20
-TODO
=2D----
-1. Support shared storage.
-2. Develop the heartbeat part.
-3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
+| Copyright (c) 2016 Intel Corporation
+| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+| Copyright (c) 2016 Fujitsu, Corp.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.

=2D-=20
2.39.5


