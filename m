Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B6E9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hx-0005AN-DF; Mon, 02 Mar 2026 05:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HY-0004tr-9D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-00062f-Gq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=T8H38GvibVHDMvX8tmDGec2/he4Ng8uVfJQQk+F20GMDqvpsrgtfRRE8NuRR747T
 l28zcP2IrdxpNAEWJwhuma1uVuQfOJalhTbdeulr0a9cmA2hjYIAXoIZQFo88D0p0
 J77+ufIN3ko+rgbeyks92u34vZppHlxGKSvfnTNUjE8Oi7aclnDH9ZSeduDpJxx/p
 2xa3FqRdiSmKDfd9tM2f03cAULyOERfY/ScvpZjV2DKyRR3QNVjCRnpU5Ds85x+s9
 arn5nlxhNsr8ucvaqJnBv9GmLcfHocPOWv1M7/3deUF1gr2L6Jb6aX4eTgkyvCVuc
 8mXGsi4UGXK1Fhvw3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXVZ-1voRZc35Xf-00DvrZ for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 15/21] qemu-colo.rst: Miscellaneous changes
Date: Mon,  2 Mar 2026 11:13:26 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-15-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xf4Mr+LNhtrRhluncnlq21hBJuEc0CRkqsQ5PC6uWik=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAGnQrFjunfOAd3sncp3zqkwqLLDOi4IqdX+
 WDFnPygBWKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WHMbD/9UdfWfkf/VDa6V/rnKTbxKvTmVuy2NRDG1kH7yIXcnL3rd8cFR5q6+oWiisjk5XmuvamZ
 hMaoUQTsGJF2W2mafJ4alk+jERdtruf6NLpz5RWmW5KbTQThV4iciE2RwCxYtwwCvfEArJuTxHm
 qBWQ+ZoRPoM/i0c5GuTgN2L8L1SMuKAp5c9E4fSmWgBjnZLKAsk7ScPHYy2ZWZaW/TKMc1FLydv
 LGx8E9RMOT+TYjel2SUUv4rHzRPWKmJ1HZ4MD2R+HmNUumptV8Ef4VQ+XorUPY5j7EWKeUuDLCD
 6jBupD0R4C+EYbJVBozWUNg9nqmB/qi4FpC5K95sWDwfywKBOOwj4xjAvI6wEjbiMh/C+rsFsx9
 VypXG+O1LY+SmjZo3bEJ3OiQSAE+mrFlELxZPEe3q8549bEBkjmGWyzmhXQXf8dKIBrP4ekXRtq
 ngtL0mfC/N16/Pus9aIXLOrRmQHQ/zse7qHrQyjQng3UvtDu0tcBf3NntsypTNCnAmgCr67b0ot
 /yZx2l7YYtylUjJHSrRDUR55rg0a4Mr6eLOTNyfIVxfsGWx9bBztbDGC6HzprANKUJWpQavkup5
 4qGnf3NmA1u2FX3HmZ2UUNUcForLYw/qA2uMqQ+76/D2G/5M4Kkzo0IuLUXo50qViDW4mcCdzzm
 9p2M/orx4ttRyuw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JR4GNZZsq8g4GuBS/Axe3H615FRU8lkIsrcuo+k53NT+I8Y84e7
 N5qWajCWqN992/UHpwNUhUzjd9w5A05eB/RBcMTBq4So87nZgbHD3VOi1hLkIvXdZikcE+p
 Bxrqpn5Hrpep3cCYWWtOtpjR1Mtp+l8ZsMYvlr9PGvtlFKNXtZyCsZJYKlNW3DZlB6O3RDn
 xf+PpZ3JMtjgIoEhIlMKA==
UI-OutboundReport: notjunk:1;M01:P0:OtXG/Ps8g+0=;ILI+TDGcT77fbAP6CZx5ePOGket
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


