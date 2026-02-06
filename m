Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1603EEE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3X-0004Jz-18; Fri, 06 Feb 2026 15:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3M-0004Fz-Am
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:47 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008Oa-LT
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408208; x=1771013008; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AlErLvQtl4AhlbuXckVOp841Bsy8rMLEJpZ1jt6+eUILw0hRb4hgeLYPbarDgIsd
 FbWevnggei1rBPt9ie3wE7DbUTn60PFuRZAaknzyIJ7jk4+1A0Iva3L6yhfHR3uxC
 md8VypwLLkrW+ceE+HoXjZDiedXQK33WOhPo8J3XeMLjSAfu3IL4LhbQSlYtTXz/w
 f3FJI3487mNQxIy250WEQwSVIzyR7KTVEyPt/qTg9lFD+Ds0n3wa3V3xpPzHWTXHH
 2fwFMOHudmUcym+trNq5C1fK85ZI7DukeZ2Oehl/vPaTNYfSqqeJB5xL989EF4ZOU
 Q0VFhZKIElhpG0UTIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1vzkb30S77-00ABlz; Fri, 06
 Feb 2026 21:03:28 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:14 +0100
Subject: [PATCH v6 16/18] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-16-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGrXbbuwImUIEpmlxDQ2+xEMA/5Zf5eZ1Kk
 GiNkZ3ydXGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WGgKEAC5M8/1oKEBFrZLHnIF0gUTX8q4HJvFDSy5GyL0jiDGEAhYiWSxvsC+NkinQJzUChRXtMZ
 3eWyIwk6DIV5SAMoeQg2zoMceCmydhA5+cGwTGEfhEMZsLVnUqVkCiQdJOtb+E89iMNeaz7BAQR
 d0mKkGWqYLHLCcV9kszlzPwLn98/7VgeVka67+hdwePbtwZDThlu3oEhocFcqlhTSLU/a9jdRWw
 5dS+6hkYYwODV8EV8Qm8AUIkHdz1jGA90f4hdGIiT/YqKDKKKrBN9M8gK62m4Q0uD2QGhECa1oB
 HX9ZoK/8a8y5Ag7USFDFfCeNfMNmbXK10yJBFsdXh5zKtNn/0KhJ2HCEW0nZsOcIQUO4GluwkFr
 s+9fKLWrYUBmqkA04V76i6zi8KTLwfgf3YYo0BRCAtmwwBh+kytj45XKidD/nz/Mv0Y5/mytrh7
 fwBxAMP+j3AG8By6m/ZECcF5ef7TTgEnvcP5WvM+G1I19MwaIbxj4NKljKZw3q0iqSlyoOagIXw
 MbrmoWI3nKktfcxUFIfqNuQIB6D6zbqg7nfIHv2Bx9uD27pKnZMi/HHI6VTEmYkwlsOTPpnXjUO
 NQ/zuHgviqbzYqg5G0G5EhVHhO805UyOWL6cNKQNkEksyyBJqmkBU9UZ0KdPWPHlzaxZr/3/pCA
 xqQvDtEVyEyc3yg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:DIfL4tHEiTTZOHd68u2G/Ujk0d2K2HAa3JpOA6P96PcGHYO5Bze
 iU9Mpmx8obSt4P2AsqTauxhB0KKhQhvm9hsxddpbVcO6zfFICzB37fpUWeKvoVD/qv+sIZa
 wYpA/1NhYQeuNlQDNrcs1lNxMdEd+oP0GOOV1o1AlGtInaNnboqEDBqIb8mcFSLuopmn5Ps
 Qlo2RwoQjxp3afikxqLTA==
UI-OutboundReport: notjunk:1;M01:P0:gtTi/Rw/K2o=;I2dnj+JS82bjBbPr+W2KJcrfr5x
 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
 NWJGCABs=
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


