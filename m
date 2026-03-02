Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439B3E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1il-00008m-81; Mon, 02 Mar 2026 06:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ia-0008MG-76
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:44 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1iY-0006Bi-CS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451941; x=1773056741; i=lukasstraub2@web.de;
 bh=7na/cU/5mF9ehdTeY4EL5tJl/nkO7neQy2zDMuNSRZI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=deyGyv4ncziBytd+ZPGh+twcXTgq9mqj30PHMNgL0tqDUMV7TDPRXyn/kzcdtwZ7
 OYZuBd8ARI0MfYrs6AI/90iZfvTfP5ZdXDpSvak3WkVS7bafyZV9dl5dcMab4knSE
 oepAloTJhqTxROet8QDjSpwh1mhz/y5tIWBvllMGaj/ae+Ciq72vYLcC5cmk4puI/
 imXpT8jQAK07ByRf6VlnW6mAA9RW1olZqpUhpHBjmLG30W2BSTt4cXCymBbvO7k+O
 Pw39sRfAAeBR4yCKzdmhc70AGxgeYI8l7DBQx233s0i4iMKLiFQ3C05rsAyAb4WD6
 0XM4elXEUjfZyMGonQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1w2EO140HV-003SId; Mon, 02
 Mar 2026 12:45:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 15/21] qemu-colo.rst: Miscellaneous changes
Date: Mon,  2 Mar 2026 12:45:30 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-15-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=xf4Mr+LNhtrRhluncnlq21hBJuEc0CRkqsQ5PC6uWik=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6UJE/5SgkuLLmtGEOEpo8ZXNiIm8TNXbNRL
 WXCUBvTjf2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WKQLD/9afZL2+/FncrBiCrud8iDiH4lKqj4f1P2oinsX9NgdIki9M8DPr6VzJ7q/7DBPwcOduJ6
 D8/KsxeERgPvcZ+/Xgp4kfnL2cU7iyLjSTG6wMrDtjpHxBg55xCaUvZK+hhSA4bd4ySwjystRdH
 Q/y2shprXtUd591fduUI62MmkIajBAUhvSyOr79ZFkLpAnaSv9yoPbhhv7MqV5PQy3XDKAIznL3
 L0ZRkgtXU0Ug8qg27AlT8F0gqxuFd4B2y9IRSlT/JW6N0N1ky1lI5aJfb01gxnrvVxf91VA/HxS
 84sMwyHOlj94w3fD0lbTF6JtplBUwIAUOXGFSi6DMkDXDxCq5nEue/2AFIeeF6/GrnwZDJQrZ4N
 VkrnTjwlX+ZNGuA3YC7v4qBcppIErs8ogHWmYFp8Tllh3DLRkUoEu7uHBLddwvH2w5VlBgD1kHh
 sya4QTSl/fyIa7BGrwbIB2DwLZQ7HMWgMoi2yfE5bpDfraqHW6wUWzmVK2lArY0i3OjCN1qYWZA
 JUSDkJLoCK5CcYLLuVJIO2fwrhjY/uLy+XpuoSzqAbk+8UTBmXhr9Cg/Czm24oqHOywrtW2YhLO
 H9+KiZpSbUVBr6+k0eOBp9+J203i5EVLwWuLwoKB7R/ZHSwT92c7e88x6/CGkpyJpCKjSgbr8+X
 uEH0KFvARCAhedw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:voU0pbWXeUBpKgcjeDndTjbjxGEmw+cZfSxvMCZr+OL+N8y9lfO
 7xHfLuGQpDLe/hsrMvGQMTDQoSPnbqb5UYJ+RLCuTQeU2vTRFXZahtX8beLzD+o3NrYtE8w
 pNmqPe2M6PJwTArlJE5k2+lEZ2PFBrn8hU3GJuyLc7CIx7O+VhrlZyfwBiCXB8ir8uz0xkA
 lQ18PtEpLUPHJ295cRnmA==
UI-OutboundReport: notjunk:1;M01:P0:0VbGo9TOl4w=;W/IBQKHgYI9KDvb9k+WZtOVSKw3
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


