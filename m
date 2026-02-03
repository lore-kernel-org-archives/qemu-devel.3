Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70148E8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSB-0007PH-0U; Tue, 03 Feb 2026 05:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS1-0007Cl-Dm
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRw-00028E-Vf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113751; x=1770718551; i=lukasstraub2@web.de;
 bh=vPdA5YHqp48z3cME0KludllELa88DoVjFkKeaLE2BzM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AulfmudjjfVuTmqBRLrEXya0kCrvpOw+go+sPzH5LJS0ohq770pkoQIeVbnrSm2P
 UzJ9hZ9nqpnrio0kx0lBDfwZvQhtVkzWH3VrggbUaERRuGpmv2z/6pcoz7pjEG1TD
 akolf6n24owdWz5bXkuC/QQvMo9gOsGhYhl8druqPZtNmrx4MNdm6up4ZF/56qMUl
 anY6uxy8G/XmzZMDN3HrepzVV6GRESLG45HCQtjJcMwURW4kQx9xQxjen7b7LSH3A
 yOOwHkf12b+ax5x0xEAedw1sdNbw1lJXLvuOf4zOivATRFVzdtVtLo+l3ySQHBgBA
 xGdRgnqX27NdpGarUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1vHiun32di-00mGSO; Tue, 03
 Feb 2026 11:15:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:20 +0100
Subject: [PATCH v5 14/16] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-14-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3193; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=kNrl7OSQUzh9feTkXpfcqS5ojF5ddlhd3s3KlJtm79Q=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQXxbcSgwaE/Vkkg0urCvLQPYI0AO6kxMlr
 08q6XwGogOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WJduD/9Teisyj28H9C+nhYUuQtOG+VO0reT2msHrMlDANmdPu9FidMS7KLHdPKsrqLG9a/R8Smy
 0u6KfZd4aDOrEHPvDZBZEAvBNhQbQFzg7FVxpm4QQnVU9MilHf2RMNtqZnAUxr9Xr4Abf6WKw4w
 105gQjzBSoEmKQhU8+jkIqROwF8A6poXOGHXK8va6U70N7fH398EIN7SWKjfznuGKvlF3kbtCPT
 PLfMiD3EUP+Nt2RpfVlzMmzemR9byHYYhHO0UcByrmj5S5HH2c1iynbaqASWASWvth5ttkkcW+N
 dLmOgxKjZ1/tKYiI6xtEMdWKX+9ecwTYbT8kFUFaMFctVPb90mZFg+jQ4uc9cWCIB704cgZPVfu
 9bMP66JRNyabDdAjzocXzdiq8+QF7GiSAPykChs7zcMsOmUv+vsZeI8Apvw/CM7H/+pKtKgRC1I
 adO3lyhi4BMOm9RRawfNINd+XhOUhP9CtaKMIyAExbhlvXGIUajjtE2U1eRX+rm0D0owTieqJUh
 aIeDIlgpJHZsfHRblGp4ggVuuBO/ZE1Bu7OMPjZsdJeManfBJaKeRCx1c5xr4TBetjziyMa/6dP
 /hLXoo81SjJZp4H4+dB0RPB1YPxyed/aRk3kEQSVtsr68SH/rZpRu7Le6P0bmcf2daX0FVc/sOm
 4c7tfiZ5M60AgyA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:coREtnMd2tdlbmRF/JLNolt9er/Akbsl2mayRrouV8JIgGB2cwO
 6dU8I8Z96Q8f3k0Q9P8af2lBF+URW++dMOrbccwZ2OjcKdYB9XIZfLUJlxG/4q+MxviJXja
 pz64xVeNcOTfpqFNzZpsRuEq8Qx0m4XhYOdUL2ZbSYiLvtoWYXGra+P1U9o7YN6ygcV5Jhs
 3tgoIXzZildxDYoJ7sRxg==
UI-OutboundReport: notjunk:1;M01:P0:laOcnJrOpQw=;tg/DjvUnt14xuyidLCJuXglQM6R
 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
 oMIGaToYLAsQGmPWOxvNnJtGDwOOR
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


