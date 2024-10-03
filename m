Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC7CF855A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 07:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swFv1-0008FG-I3; Thu, 03 Oct 2024 03:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1swFux-0008Ex-Jg; Thu, 03 Oct 2024 03:06:31 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1swFuu-0004ZL-TH; Thu, 03 Oct 2024 03:06:30 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MkHEH-1sCW1c46qP-00al1P; Thu, 03
 Oct 2024 09:06:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] MAINTAINERS: remove gensyscalls.sh from the linux-user section
Date: Thu,  3 Oct 2024 09:06:20 +0200
Message-ID: <20241003070620.1080820-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ci2EeCpFxBub0NDLDFaq0HfxWNv80HZflO+U6VSK+J1BU/TfueM
 b+NzzWK80lR8zt1e60lbQGfofyYd20O7G10UDyN6rCQGEXN6IYI4gb3ddN91fDhItIpMFbV
 fY3vOEDdEDT/ZKzDCqvrjeaLAixHZs46V3BLNpkhsjiElndfp/CJDeO/fj6iaGiPjG5+KkI
 syMjI6+0VldvuzRlc6JRg==
UI-OutboundReport: notjunk:1;M01:P0:mrfK0UKEB9M=;3g9wl4VdsIzJxHhBXZ+bMDSQisY
 4KZoZZfJndmenWjxMICrlVcwppB1jyAwEf25s6dW22gvqfczdHFYFcj2kWqGeSOxJTjbogzL2
 rCPnYpqmTYWq5Iy7gWeK/zcQMPqcdKPnR+1UHOU8oSpP3WpC5heWjphfUpGKmT9lR8ligub+F
 Kne2C77ivY+6x/vZ96X26cQxwZJHEoJWkvcsrkVEV9c6S50KPC9b5mFu4NIIGWrNFLpoMv+W2
 gIgEoSpWJopkjEAcHc3MSnsxzf/xbzx3Npnl77ykp5unfLuUk+TY5RH0OPJTuBo6GErX8KYmu
 QpChtD6jbGHnbkh7BhOO7qeHHK7CQjS+uD6e2JSsSYteBvJDY/N8R8f6t9z5ALdhEKF4/QjhS
 eP8snTG9TV3K0Xw1zzdB2b2veEI6qJ0nf9F4i3jQB9dxEW3wVswMoDu3vop1pSK5TmsqKFHTp
 Fa/YEUZT0q3vsweUBEKPHh3VEpM9h1QPuf3pALylI8aOK5Dtuzz29FEzSJ/YilW2lhZFZjp8Q
 3NVjCRTzgjcEPPhMpqQRiz9h5GMU+JMUfv8VlzCiW9KPLjXal4zg+Isdh0sqIWG0RgQEc+n3Q
 erKIuG+oXDQzcOyx2MIE32pB3zhD88M6/gtefLIoG90cc87L/sF6j0s+TLY9uWvBBo73Q9VpM
 AJrE0DCYMponl8q3pqSGb1mF/9CiJEabB5elWsI0NheGSQfp3PeS4PZ3QgZPtQWafCVDoAAxv
 kL6KpHX1o9I210LbcAq3u4iO2tIbNigDQ==
Received-SPF: pass client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The file has been removed by c52e40596834
("linux-user,loongarch: move to syscalltbl file").

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f4075..4a6b6ce6006f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3731,7 +3731,6 @@ F: configs/targets/*linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
 F: scripts/update-syscalltbl.sh
 F: scripts/update-mips-syscall-args.sh
-F: scripts/gensyscalls.sh
 
 Tiny Code Generator (TCG)
 -------------------------
-- 
2.46.2


