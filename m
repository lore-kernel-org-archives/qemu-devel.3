Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA83E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7b-0007GC-Ua; Wed, 18 Feb 2026 16:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7D-00076p-Hb
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:48 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7A-0007Fj-Nu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450182; x=1772054982; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Dt0vV1jcXxcB8oWkpqEmkJgTkx3XpGXbqYXGr8l8R3OpVdxqkftE+F+yvlnh4sWl
 fZ8n59GgJ8FzfOqTSyBaRgeb3G1FgfsY9MwzgjkPbsyP1/4Di+G73PR5zkHR889nN
 2/B5Kwel+vNai+/P1UtMubQB7MCeqdu4I98efSCoa7TJ4wzOk6weLNuE+S6Z6McLO
 okGxK/dq6XhQtGCp2fqAbQfJOX1XDAGPYkAMdn4JJVsCeMDuVcRqysJctd4EAwnxW
 +4hI46PRHqmNC7SnZBkHQj/E5rvRomeXjAvX2cWQGubt/hD90tnpUPnpH4/u2jIu7
 8rh8OXCIR+aAv6OlKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2gkl-1vtdGM41Xj-000GU0; Wed, 18
 Feb 2026 22:29:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:35 +0100
Subject: [PATCH v9 15/19] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-15-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89yNUFxnW+hOn/1oA1JstAiPWDeJby+kMUP
 hmz1UjmiDKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WJwaD/4h95wEC+PbY6bfZtbpM5CGwYp6L51R3Dwey1cvy3YsB0EtPEGu+NyDrcaHgEUnz69fMEe
 JyCHGd/jdV+6BsyXrEHtP3WoD3OwRPLBfuMGhZvAxszSy51IPWzBxJwfVV/p2ZTFMegSocryQC4
 9nURkQv6Gzds759uM923AQIG2Zgu8j1Qdy/p+n27A5nRp9coYvVi80SVJNLnkZHHmqIGWVy0caK
 fbnnwq6oukD/H3QcNwcespCeoABala9zsoc53QC29PvaJJBajTzfcqWSSuFbgl0qJLWLJNmPOtp
 XSJQvtIIOdFP3ornjkRo7kMBWr9T+VHro//w5AUkUBmNjXTc+ZdzQ1oxtRZcAIBfZVpYpKEsROF
 tRInz7yi2+Vs4QBJIEeYiQnwhLPC8nwKtzYuA6zdG+xVaXBAQ0DoI/EyPuDMHft6R6hUpgEuZKu
 b6uf9F8pU9kEmJTzCsI+tseuQAoA/oIzyyjCTlxlV0mJdeOxh+jQE2BKXA7sh90dxUXhPDSeY5a
 sAG0EVERBKG4KNnYgq6LeiaW5hpM2gnmuDjYAfu80IvESMISA2nUSckihVyQON/7JxXsMtV3axi
 JH76lGVotJoeXDcbHKRY6ubeQTntHl6bVdAySItTUWLfnEPaETzohxv/ltfvui+sSfrWi45a7Du
 oR2/CG3uvAtm52A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:4IcSdf7akiaY5qm99ouoS5JTH5fNGOOxIa6qcGmi4XpVkp+UBhA
 3yyKVe3sWvBHIrJIV2fcYQo10pqwOmEhLzZqt+18tOX7ieP+fm+VhFmgbC7kB+Gr1dSnlG3
 8cDHgOsPcpWryEhUEK2v69TxorfJrKmLJPyfsx8C8KYOG+dEUIykZmnQ4H52yImsdhHBKVS
 nOVCSHDKcFm/GhHMXVLBA==
UI-OutboundReport: notjunk:1;M01:P0:sf9zR16kmAM=;NLmFkwQ0o7bmoWHczd16PDNTNir
 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
 wXNV0U/+frels0k28P/GDsBcdyqla
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


