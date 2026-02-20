Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E2C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXs-0000Yf-VJ; Fri, 20 Feb 2026 14:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXh-0000Uf-UB
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:03 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXf-0001SU-59
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617111; x=1772221911; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EaDKSK+CK0+etOQWh88jRvM9v+iraJHn8QJivwqX9lH+zrEJ8gKz4YSpm5SZSbK5
 d+kIxCjnoqJv7uDU+mvLZjdBFq1huD9Ou56KACApfrLNXwjZsUZLWRSxvyYDSxcJO
 YbLF4z5N/qJVBWKvjoP4gE8Zy2Tm+zhPrqFpNi/WdicJSAAz9fL862DLTeFasGk+3
 umdVYZrKNNlDJBHQkLWlpR/OJDG0BU5gr83iWMF8MP50f2yJ5jrXSrODt+2++c2Lk
 MLu8e8Bla+dluAgqYVII/JhANYvyusGAtZnc22uxI9tOJrfLVRs6FpaZxIBa3e66S
 6mTycckzHrIkIWttww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jWK-1vjW9521CG-010Rb2; Fri, 20
 Feb 2026 20:51:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:37 +0100
Subject: [PATCH v10 15/19] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-15-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xf4Mr+LNhtrRhluncnlq21hBJuEc0CRkqsQ5PC6uWik=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtO1AjRXm/stKe4cXABxoTciUG/wdJg3BV09
 meUUlA5LF2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WHJ8EACm5S6gHM+AsWkpFWiCmTNFqeVkhe/y0FKylVKp+Yrw/ug2cUnbCLtDNsjxvVlvP4vY5kw
 1fQ8mwi9XeJmSEL29EobZVnPOWd1+4OHPHEZOXhsCeFTUFgaiXwmBJ4Ua3Al3tjSu6Dho77Ku8c
 w/Ovg2N0Gdw2TqUXdJp76iVBTPQc9TGd43r/bxlemkbWd/szwLGK9udu84wWUsc2MrocOP/23b3
 WXzvnpZgDmCBQGTv8R6SZWmCsofphwyibNiDFKOoBdYlO0SOrP6JdobPrzxTpP+xizUKHyqfglX
 pKzeA4liB2QNJxTdyOy3MS2MxYCZpsHhxsAfPbSWOK5gRL0jYz5hw3UtDCtIV/v9uJ7YQN/5ARS
 VEX7hqu43lNLQ11sSuyEKnw6stj0iJMLr54GIyfiZoODfy+u3z9V6QGgYWT+iELJPfsY7ssGhL3
 fDibXl5T4WYyQJ7KDTeAT0wz3dloIALQC5EFTuJh+/Lk1l+CFHsNlQ30XOCj7kdEQACl9FmlXQ+
 55DXI37xx2udBFRIljZjeDgXJ+mEGfoL+1xazLjyeo5bB/+VtUBdVuC/HFxu8r9jOnHZb0mKCz6
 VGSItWP4f7f1ZrVj8jgTMus2kEAd5TZ6MYBjiwDb8RdkzWAGVLfvsjWO5dPKpESgP1j+9VwF6R2
 oU/iPNMYtvZWJPg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:hnHbmstdL7oe3sNugFAGwNZov9cu98BsaOMaDAfUnPv5ohZY/LZ
 MMNqPFi0wpo2IbR0BhmXZQWNripXGU7H38Gd9anr7+JyZd2LY4/+MIA5hZq712w5SwAfTbL
 /3xppTl2spthqt6ctanpKetYHaucIBt69H53Pt3LKJdTpQBFxZomaGDsygs3CfhseZ+hxar
 inqc/by6tdkzJ7HzRSLeg==
UI-OutboundReport: notjunk:1;M01:P0:CxubRbxVOl8=;ioz4Oxj6wsvHJ6WcrS49vpaiv1P
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


