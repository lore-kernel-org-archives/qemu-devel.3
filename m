Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1799DC98329
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh703-0007aZ-Pr; Sat, 17 Jan 2026 09:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zo-0007Vy-RS
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:47 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zm-0002aB-Hj
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658976; x=1769263776; i=lukasstraub2@web.de;
 bh=jmmCkmbM6P+Pz3osqXiFsq/n2vXEQZ2GzxUnCFZCFHg=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sbv7nMd2eyE4HHpi76Uvc+uk72owMK2zrZedBsAaesXDa7Ps2pMIL0xEtJBivfEu
 def5nVHGqHyw8CWLP37UmVAj+VN4tXL7sj2QLmwwdSfMBrRrdLcJfLAVsmmbIpONf
 Femr7FYH+0TwOxmE7F4Y9OY1w00g0UZWQeGIVZqFfYpYtN/FO8sMq9sYnB/M0Rxac
 CWOXTP6thYrirZQifgxOBkx49MSc0C2lVeniI49mlrLR8EgASIFV49rrfzA2THWwJ
 GpAXkQqfAoFt/XKtl6YSxnf39FKmrwpC+JlDg80wLemoIzpwGU5pPBI+3kQr2up6Q
 TShrGhvW5KiemBqiAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmvd-1w5Tup0nzb-00di8t; Sat, 17
 Jan 2026 15:09:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:14 +0100
Subject: [PATCH v2 7/8] qemu-colo.rst: Miscellaneous changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-7-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=jCYaZBUHDqTrqK9kYrWH9VDRWkB0ZIX+kmVIzl/UR4k=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gcrEz0TtgBauRU1l73mg/56Fr82w1jVBn9n
 0S7VtHyK7KJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYHAAKCRA1qwsonF2y
 WBYVEACCoGIN3W93uYYZdbrV2ZhkE3EDc6vDJNl2rBZHSQAEr7hh4mb9F6iz6o9ei+O8CsmP9gH
 sibN8m0myS1rMisq4uFldezTHIb937oveYH0USMVkux+ePT1Y9cBDIXCKNwMKoPPKx26ygpTHIF
 jzkHbMULhhYdE6ADRL5i5GyFrq+iIbBN/BteL9FaXOhhBzOOG9omsN6FKdDHvPv8mv5ESTyR4XX
 jpE6xc0AFp9DuFx8L1wjpT7P4AM/ffn6VFYlfKmpvxI3Z/r6zV1Dl5G7UeXLUwu4M0erD1A8c46
 6V24kkjm4CDihFJHSblqPD5moEWwUEFFeUMCpqTHzlcQMYvVC5hHXtoA0EpTgTN6tBtkBP4isEG
 khDOUX52OMFjr2ylARFY+Dd07h9YxK0A1O6Gw8qm48RrxarneAk0Glu2XCQiqaopgYgMIz24ZNV
 8mcxu7kQ2Bc2ZFa6BJDgYrPf6QUpXb6zXD24drTWOv5CFG+0PeWI+L/2Y3ThcixVg4OUoPt6UxB
 PpwMlphPtBixySIIgmQE0ddLU/Dnk9QP9aG+PkfBo0pBouBe7G9lTqpRfQtFvsO8URX6A48+ZtR
 bUuXvrrPmauyWIu7urvyfoDfv+OtK7UC7PddHl/BjILMeoJme0OGiOFVjD3X4SUkbEeLUpDbqmL
 +G3mmdQoQk8D1dw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:J+kwkHdP4KZqgPIWdQ9s2k0JATJAWadKUiFjyU/JCb6GlsNZUP7
 IQ4CchqWW6LoZ+LfwJLt2O0BIcEjZvp7AadECFKh4tU7rYpbHiS2d+QtGG3Je16Ck4i42S6
 v6wwscpyVp28KPohgvFTzQ5C2WX1323Tv5f8Z9gbRQWh3x5AJYOInk8cEnWwC5yOTVaeR1w
 k5ucH7sOv0PEUNyiUw97w==
UI-OutboundReport: notjunk:1;M01:P0:9LVts7/GUgk=;aoyeOmugaQJZL0+yLVaV+pgYTKU
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 5b00c6c4c2679153f398ed5a85a5d9cc515630e6..2052e207e57afdd3ab3ab1a447=
d55f5e2e5b5b87 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -1,14 +1,6 @@
 Qemu COLO Fault Tolerance
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
-| Copyright (c) 2016 Intel Corporation
-| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
-| Copyright (c) 2016 Fujitsu, Corp.
-| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
 This document gives an overview of COLO's design and how to use it.
=20
 Background
@@ -83,8 +75,8 @@ Overview::
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
@@ -158,14 +150,14 @@ in test procedure.
=20
 Test procedure
 --------------
-Note: Here we are running both instances on the same host for testing,
+Here we are running both instances on the same host for testing,
 change the IP Addresses if you want to run it on two hosts. Initially
 ``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Host=
.
=20
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
@@ -193,7 +185,7 @@ instance::
=20
=20
 **2. Secondary**:
-Note: Active and hidden images need to be created only once and the
+Active and hidden images need to be created only once and the
 size should be the same as ``primary.qcow2``. Again, you don't need to ch=
ange
 any IP's here, except for the ``$primary_ip`` variable::
=20
@@ -354,8 +346,10 @@ Wait until disk is synced, then::
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
+| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
\ No newline at end of file

=2D-=20
2.39.5


