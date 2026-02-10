Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9C2EF0704
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWY-0000pr-Ei; Tue, 10 Feb 2026 11:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWU-0000ix-5n
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:34 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWS-0006yQ-4L
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740605; x=1771345405; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kOg+qLNqs2w1p+/SBNsvvcRw78hoxojIxHMDeDgZNuZVuEZADvhuuxLVjZ179XFV
 DsCN5Qp/Q9EzuERtY+CZ63yfSGJ5ZKCSHCB7r40UeMinBYagf47an4GfnzFntiNsl
 KoPRVh080RVdpGrMxAXwBH+ejM+6RysPYxdYTRmbdHzFcB6Zj/Wmc5XgSxLiuqP8i
 fvo+3SZ336+zRLihdWuXQkWITP4OBD/3liG/lUWHtlQn+4zNT3KSwU+yJiecX4Gu1
 NEwlN14+avFmbUPPQKlQQhUr1K0O7303lYscma7In7Sig6ahAUSuyU/He0Xgh6k5Q
 37lRrwrXZ/gqM8zmYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1vxqrW1LBj-009et2; Tue, 10
 Feb 2026 17:23:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:13 +0100
Subject: [PATCH v8 15/17] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-15-7f9e5f7d082b@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xf4Mr+LNhtrRhluncnlq21hBJuEc0CRkqsQ5PC6uWik=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t4mEmdVBGQvbIXfdi/5Vsrow+oNIkYlRHnT
 00HorXqhXCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbeAAKCRA1qwsonF2y
 WBN1D/9w3/enyvrGZ1mGmafFgvLu9BXIjMWnjsxMGEaZQ9FBoyvlFYRBgy6LQY+nJ5O72/hNpQf
 CXLwxkMPk0JnPTrREEpjd43aTzRUxbqPFIsgZ0SOa8yxKQ5GyxYGlxkkRp0Rl2t6QwZoWeK7jq5
 hw4z2DhNeieSzPmafj4g1c9kTIezpgwl1nxInk/KA/KWMlohrpmSUQH92Q4S6JoV5TGCgiTFhkb
 IR9ryowhX4LSbjv1Uo2vdlBoU5Xkk6TykqxUMQwqJiWhOQyv7VPLIpU+tVn+kf/6HFiWR34TVPd
 ilHYcjMLVaHlh6IeMG5vQRaqtl+PeQK9na6pD32I/4BCKZesaEdoMUURCa/czVAZZqpexev9cyB
 6I/Ed/DtWIh/7NZYUKpacqpOOaMDPP8yPyZ1lgmB/fqQCtg+N2/EyRGEl0cwdfM+WEkTippEF3e
 FfREIFyzXXn4AfjfTSD5nLsuLVhgv23X4OR9vRKdgsvJ3WvFSY2u61x2BcFp9p5mlh2VjFnJh/D
 AwEaYntC6MNp8W+nUmrS4q/rh2KCfAN8hAo9TIyKTeWePTDzA4USHnPGhcku21kspHQtX8n/T+i
 FOBECqQCbfRXu57xN7IyTnntRjx93SQQauXi8WsB5qZQ71QnqaQ7BOaaN+ssLm3REa9KMd4OBVR
 0gyxISpZrY5c1RQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:HbTs1yz6jwIEAopZNIbz1nQryUV3Q3AXlfzRfAsHRoNJFrFKHnh
 oWMf0XzcxU5z4sQ54sC1eeNGkV4mXD4bmOCMNgsrsuU5e+gP8D3859kaXpv4abDDdsnQqyg
 ywWange626l2J1MWE5AYKbS+Cee1X9JFIJ4OOUdb18e31Yo8Cq3tRaW2F9o3suyawnuFQbL
 HMVMUq3hXXuejRQ81/ebA==
UI-OutboundReport: notjunk:1;M01:P0:gsd5TxUxFSk=;kw0lqWdtu1pa/PSd1w0EQAp7kiP
 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
 AtOUoxTLwinWbYtBvU7PgZF0Y3MTF
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


