Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70208D715FD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6uf-0006zZ-PI; Sun, 25 Jan 2026 15:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ue-0006yH-Gs
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:48 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uc-0006Cw-A8
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373644; x=1769978444; i=lukasstraub2@web.de;
 bh=G158C2Fa8nrbB9ID8An2zgaBGN+nt7yzulw+cALwfxo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WeTJEP6hOIBnUlUQYaMT4yiHMJLdtcGH5RQiaC5wp5kdQbsJZwGEiiwUlJVnrZQT
 P/UvJpRv7IrTxB8VF4v1i858t73ajSAsbq7mTV+ifUZFpfP2lJviHIRc8Ua6mqakz
 TG9QJ+TmoppRXXeVoY7HQ22Ap82SG+2Of46BpWfN3NRman5GGxmxgAkf8Hp1vkS5v
 ABFllYnDOhYoJqSHYsAE/+hegSMnCb9wAGpoIyPgGzCc3hIfiReROW74H/vWvtkMC
 BGK5gAUBwr+AmIf9JJBVKEkvtghzIbV8MkFtQmXMpZX8NnSmJBnvqTJB48iUPZMkX
 ElE48qcqKdLm/+KI1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mt8gF-1w4F5p1Edd-0120L3; Sun, 25
 Jan 2026 21:40:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:13 +0100
Subject: [PATCH v3 08/10] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-8-ae926ccd8eae@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3147; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=HjRkk3PLsLjQtpMcn7YOFBq4HgSWnQadmFyAlnP7/W8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/F2KWxRicPyn1OZ/ayiDNSfFEud0IDnFCFV
 RZ92izIieiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WIJ9EACLFcsWMglrab18HGHWaWvpPYQZ7lD8A7OJht1A8YO8cF6coydHEHuy258+RkYlRRfjVL2
 oXUYkoDrEMj/BCmd+OprogrceYkH/dSu+KNYpiw0KbUndGP9nbdOrOrSmQeRiNlHlYAfIITzfKw
 Qs4NA6l9XiRKv+W6O8g4Isjhdjt0KXTHy9GCwk8DrbmKK4wOzz92GZwn733NERQ/9CVq6kYJ5vB
 uLZJVtEEtI5sqaoKtt2kTvNk01+VoT0jfVc34m1nhT72g91qbeLzB3JTyBVNSVFdKP4cpGkdeWh
 jzEd5RkR6uYdHGu3i0qgFguDiaWwOC/BQrxnHypFA23R+NU0zHiX8kcAKpGz2MZze32yA8Apr2B
 t2I9oRDlxcZNrhf9N/6MFRWvj6yGf5OGwM8nctlyJVLzfHYBqx+/JOfkPk+4ZZAIQzCxJgY5mmb
 daT4027cXS8izcsLjHW7M2TQh+BK57XtmoPje1ynoE293JHBDy2Ntf4B4o67y68cz9EQj0VT6nr
 m8nqvpJzFAaACpsdi4/ZX4cTbE6kezyCZ5DLZUCpJd+E+3uDr1L3SwrUwXONg7decN5xh4bZHsL
 8HNIRSq0AIOli6J4WsWl6kEwZjM7I7RhWHg4GSWQMUGkMAjhCbrF6pmpk7L6HnBsSQ1Ve43kLwo
 mltz7g8u0YdvzhA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:wTpczBnRaWeXWYEuibW4jNYqZJk1/HOc5J5S7l45RV6PlSldSwx
 0hgn78IaawDvan7y0F2Zl78sBeSqhLFo03GDBBEehw4pKsvOysav7wc2c4ZyOP5D/sfZh7p
 zKZUsbiynd97YSh6fAa9t5fzf+t484Rc4DfjB6o6Dr7InNwlbMpmzVdtbOZzqfnbsLY11fw
 giJGNIcPjeWmO7bXZaFtw==
UI-OutboundReport: notjunk:1;M01:P0:BAh4oNcfV1k=;+9UTV5J0dBqa+4ee4dIcykDRGqB
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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


