Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E2CFD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUY-0004GF-FN; Sun, 01 Mar 2026 16:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUW-0004Fp-Hd
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:20 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUU-000469-TS
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401066; x=1773005866; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VUejWMhQkG7pH2XoHMbIv+U4AWHb+H2LmI/W2RFUmqmN1mdal7C1L6U226ZTctZg
 7YbG1mknCqPxuS196WG1hpkMhRr9Nu4M+6EV/cngUPzK9/2Wf6gfGPWlY+9v3CESK
 fnVwa9iPdKwJvAB8YdIeiG8+FPck42CMOGvItU7uGd75l9MkReEIexyCFIafGnpPy
 Rz4zg00SeDE1DbvtVayWk3GWZ0hx8RdLhPcNDg5NQlVjHlaQMeQIv7gcUnQlZSatE
 bsJaX+3vd2DHnV5YZKQPBv86YUOsg2+atrFJuIj7HAWKTEHxRlwXlShEIbCY/+hPV
 UGP7UPcSAXoE4Aq9xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vsx-1vay4W49ez-00zjRp; Sun, 01
 Mar 2026 22:37:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:35 +0100
Subject: [PATCH v11 15/21] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-15-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGiUYXcwn1jEXt8XKcolUCcBqtR5jFWmoBQV
 GnKLmZTQA6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxogAKCRA1qwsonF2y
 WMkKEACKfMsStpI3b5aMOdNHIcLDPsr7g7tH3wLKXWSh9lZgVwVrZVlEU8LKRs9NJlsOi+odqc6
 BMRSLS2c5CO1BxyQFs189ihiy+p/ajJhC1CD+bV75//YncgBmivWoty9DwQuIi3sSioSsCyyO5t
 hMOGBfTZVA8khG5p8J9Hh3C4EgdYb5+UdozgGlxbEreulpiRaNG6YYHo9L8/mASZ5903MdX5yc1
 LHbk6D3RVngoTt47lq8RJJpdzKvHpHGpm7qv7+pnJVlOjQAjHJ8R9PIxn6fHLT6sDobOaW+xR5b
 LWeZfHPUXl8FqOI66aKD/l1j/krPd9tyLQH8sbbNUegsq1XGe1Da3tLuiLlsAv4Vn3OqjBh4eIf
 cqJ6szPR5/pMTvAZbEfMyINzJOK6lShVUYyiJOo6GwfQpB00AoQa4Dd/Kz4LkyvzLmEz2Hp7V6b
 E/Mg0AAi2aH2ldJDCcJGBl6eh9izpt6klqSojzsLYmxGNTQ1YprST8xYyllCl2IOnZQIv6K7o91
 /wYBhF3JQmjIViFoTj3oEax6EFAIcyHcrLQ9gMF69XK143ne3dBkBzOEEgEZNgthWfATyuBPS9v
 Y/Ho2M1UF/yLBolY0RhVwJ04+HyjcnkNl9c8hXSn1a9l+ebLQu3vHsd0dzHTkT1+RM0G4blI96s
 H3J7fIhzX44gYXQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:RvvRdeQf76ZS6I/EYdq32eho/oNkJSTz5FA5z307s0eLjLPKRWo
 vj9fOEzj+R6CJwkOJgJ+wwblyqIBGiveygpGlM5qFdHF7EkxbcIFzwMHaUxGyku3HudHsL3
 O9oVP6nkigrS388Se+BrRINIKLqvoGF9x3+0yfLW10jYgovz5Ypzg/20JAjlYcMzHx92oOv
 t472EkmPRj/VreQaDkTYw==
UI-OutboundReport: notjunk:1;M01:P0:vDMrzrVpyQ4=;Bz7fjJy1YS97eNp5U9zhDKUpy5I
 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
 4/ZyPXgE+QPURwbkIknFOFSo8iumciM9JmKdXM
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


