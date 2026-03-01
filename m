Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB7FFD0062
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHu-0001BO-6E; Sun, 01 Mar 2026 14:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHm-00015s-98
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:02 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHj-0003WD-Eu
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392614; x=1772997414; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ds+ffnrh2lMOXp8Dv1wFKoniGA1hk9uQs1NtYWi5G3WULMzrgW2MJW0vMuCgo9S6
 AaLxCYlNKBok4b/qDZS1fUl9GGZOE9vdEerK9lzAhvF1WQg4YSoP48KosEli4Ldba
 jfZWrbFVoqEZF/9P+U18TwBHZRmmnlcvVLZvoPsnEioN3bG1V7B8psKPvSlkNgOMZ
 iLsYqYLSztFrmWkre0aGu9VglkjjCjIHMle4rsco6hBbQeIifogJKpwVkzzKxLR1s
 +IixrpLtu+oY59S4UwrOZzytQWAW6a6togKNlTlABIeYZvxEAQWIanSmUZ3wvY3bT
 FGfMYbxdP6oMjnkRbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1w9F9k3Z01-00Rlpf; Sun, 01
 Mar 2026 20:16:53 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:40 +0100
Subject: [PATCH v11 15/21] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-15-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdNZBkyd++ZdmIPQ+IGnjTAK8xsxbyPksvh
 qodTjTlklWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WPhEEACIkYnaayq+Ung7lRhDqB/5/oTqXa0hdeclgEUe/jXfn62nU4tnG54+S3s9Z4YjwZdIsOy
 Kc+EXEH1uR6md4lbKnzqdyZl/jApLwztU3p88d+oSEWYtt1JCpWQ0E7XP/f/0vMhQoKlR6HRk1K
 KHYsIGIkxSJo3okMjN1ONP8PQHsEy4WIqf4ophjrvm9rBJXHkYczonmKeuue+XJKvT9cjomnDkX
 DzvKLaS0Scz4S2Qf3rGSCZRFRCXoUPvZ29vwea+IEkJNmqkh3waCHYxzd/+IFEX3jhPEzomAlz+
 pZnE8sHSkg4QFJHbMGRUuVJD9L1aUBS25mOxzl3zYsK5xzmuIlRhNDnbOi2AF2Yd9fWVk+ClbqU
 GbV8CxuTzxM1FqlcXeuboVPzpCXuxDpfNPLELfpqGBowDe8xLD/whz/TWRsN1VapWxy4E01lNcG
 FOPfeDqPqF3sPQ/Irl8eBZqm1jf674MPgOgyI8pMspF0fJYSuzuPhxdTAZ8CEJ7Xbe885ExMhJY
 DlGjf3dun7aAAbhkGQM4EY+RSrO00D6d5VGR4KTKfjnC3brB2pUsrf6/38NraIfALFeewo6dLkU
 q7Peuuekel+Hirkr40LBmQa7A7hKlWbLps42bo95NLAauvp5aSLGwZdkih3thvGE5oFXv9AWcOY
 QXov3qUNHfTMziA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Idajwd3E8QQDTCgmuVK2ifaj32na4/YAgWwOhOGbqIbULKmuckZ
 XL9KBvs3wFldOuFO8FXOsiytJIoKWy1vYYVBqZzgyjLU2YR1Xr9t5qg1ig0Kz3tOYVBDr4/
 vanXar4dLQZOOuFpGmYjiaAik1ey9pHxg1y9p2W5tTOLPHeqdAqBao+JXuZH/abPOT7f5uu
 8o4tI8pOKiLE+pD3ctMOA==
UI-OutboundReport: notjunk:1;M01:P0:KX3dDYoz05E=;Upf8vEANWJnarMIaKLraMHlXabp
 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
 MVorAu7wgL7YNPY0otp9xC7cCfAWpxNsnxZRxD
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


