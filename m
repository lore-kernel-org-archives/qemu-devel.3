Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59D7E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Pz-0000O7-O1; Mon, 02 Mar 2026 05:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O0-0006ad-Gq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nw-0007JA-Cb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446816; x=1773051616; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FPY4aGX5nU3qFe/3DXc10ww17EqAcxcOtjiYF4S6JBWHrqqISg6W76Yrb87elu30
 2zqc4UWZBsoLH7EhZw0qWI5zvnH1pSdAsEhAQX/V15bJ0ifgNKtlR4b0IH/pHmI7x
 WZA9IvdHOhLMCjS3jZbMQIAmoxvend39sVZtdwZJvTpa/66LzdNsyyNbKbRciQfSZ
 uQ4Z3QUiJ+H769yVSzHH4Mgs7U7XY1UdSyLCkjWzNF4yfhz+NorQISsJK50rThs+g
 Kk2P4m3hmtH1nhYxVMQ2Y9XlGXbJzj7maasUw92AYY3nsVw8u5GV67ZrkYRv1Dom7
 lMWsrh2D8T3WkmTL7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1vv4i43NOd-008LFH; Mon, 02
 Mar 2026 11:20:15 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 15/21] qemu-colo.rst: Miscellaneous changes
Date: Mon,  2 Mar 2026 11:19:57 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-15-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xf4Mr+LNhtrRhluncnlq21hBJuEc0CRkqsQ5PC6uWik=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpZmVPCLGIwSppuqmKWV3O2YdCgj+BbfKKq
 DLDnWybTuSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WMPJD/9wruwn1nuP5OJBOvBPFV28sR+g1OzDl1j4V5XCALI99BwJbvUvcGxT2Jg1grdwo3Ts4lS
 b7i9oVljZ6bh4pV4lqXM73/uzb/7Dkc109EilK39uI+D5TZn+NUOBBq9QvzuB9VVjrOYKwWinw2
 Z+l9UatBucnicFAFxOCHW+RVTljS8D0cIqjDPBl/lTdepcrIfbMQ0SPuz9iACLyxpdVlPzQx9NP
 8l7E5/kvUZR7CAoJY68vHvCY7v4FehNODC+stVDHa9/38qeO4LpRDDh40HVTYkbhORtHp+/LeK4
 tfQC/bINhHj5awcLH49CS33NllBrDP3bHenaEbaH4Mi2fiMqrH6ZryorZANOpxU0NJt25m/e0qK
 +s1TTEnIE42w79hk54mi/iUOcjPdivP1aTLdRevqfqFRiogmLZQRC8+iPKkk0XIbfqPcn6GYHnE
 9J61F+oegfG1b+4F2Ii8lU6+syb4+aWkGN38423SubUTR3j+K42ilYWj0PYhvvqSp9vAjGVUS6L
 ZnKawdFhoFzA7lJtJvkRm0fXgmoefwrt1Jp8VEr3u2vlE/leBkcnqS8J//lDlPaLOc4ByAXOklY
 jHxXIxu0xw1RxoWedd8j8i8wRvl4BP05dXHcjHeqxeI/jFyHyw7HYsFs8fTUaZTJPt+4M5OQdBt
 h6qDpJ4N9KHecnw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RmP1P8scos0eGAmp0D+trCX9x6RgUx4x3q487gjwnqWjjzgNQvB
 6u5sQkrAWil+q+w6H1hxOMxpOT83tjqYIx6qaqopc8v7sfzwoHvjiInJkjQ5GYZYNEoMVDl
 Jz8Y0fxFlsdMvKSn2RUmYg/8LnDKdmaspHsSNLbZVeJpYoFH1Yu80BsByZDteAz4j0XShBz
 b8JqXY5fsALKPk10qjHyw==
UI-OutboundReport: notjunk:1;M01:P0:sdkjkKk6F00=;fdeKFPLliuhuBwi5lEOZ/DBU270
 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
 wrB87fXECVj+SAyIBWlAPN6GHwRa/7rPCWcpna
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
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


