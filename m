Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E40C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8HH-0002DX-CK; Thu, 22 Aug 2024 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh8HF-00025S-I5
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:55:01 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh8H8-0002ap-OI
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:55:01 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 22 Aug 2024 13:54:52 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724334892; bh=ObKhh5ctOrQTCNzAWvBPR008LcANC1kNYVDOEchZxFY=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 J6kz2J7HZkLZofhLCF6cc1w95UwHRpSFjk7zXSdXOftTJROUdQC+/gg4wTCeEaG9BErXLKQ++tVROI6oXb8ICg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724334892; bh=ObKhh5ctOrQTCNzAWvBPR008LcANC1kNYVDOEchZxFY=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 OaABsvv+duGFbQyGkISYsSIDiYrX54nIt9nC5NridEctBeoHVBLVRgiLHkvShwhAUOGHmyb2KUn8x6la4/jtPlvyQZ76rRiIDGq5Zeyl9HVj0gkt27Z7O6t+RgtQQhZ/xQYFLvU+jE/kbE2hZ6RwYMInLAY1s3cK6HX0VwtnW7/ZNWaJjac6h/mjQLTDw7Z/M8UpBdmo2QVEPeOZxGXjfow4CSfB7RuJhDqR8P87/Es6r2h+uSTrl86AadTJd8EEq0RcwqS2Op5f8ixB6J707GqMJsHBjlzedj1kDgZmTHus0Wy7Su5serQdZDeS8nLqrVVeI9b19vBXnJtcYL+hBA==
Received: from corvink-nb.c.koehne.headscale.beckhoff.dev (172.17.61.20) by
 ex04.beckhoff.com (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 15:54:50 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/7] vfio/igd: add ID's for ElkhartLake and TigerLake
Date: Thu, 22 Aug 2024 15:54:14 +0200
Message-ID: <20240822135420.58849-5-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822111819.34306-1-c.koehne@beckhoff.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.61.20]
X-ClientProxiedBy: ex04.beckhoff.com (172.17.5.170) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

=EF=BB=BFElkhartLake and TigerLake devices were tested in legacy mode with =
Linux
and Windows VMs. Both are working properly. It's likely that other Intel
GPUs of gen 11 and 12 like IceLake device are working too. However,
we're only adding known good devices for now.

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 863b58565e..84b0ec3139 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -88,6 +88,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x2200:
     case 0x5900:
         return 8;
+    /* ElkhartLake */
+    case 0x4500:
+        return 11;
+    /* TigerLake */
+    case 0x9A00:
+        return 12;
     }
=20
     /*
--=20
2.46.0

This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments=
. If you have received the e-mail in error, please inform me immediately by=
 reply e-mail and then delete this e-mail from your system. Thank you
=20
Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben. Sollten Sie die M=
ail versehentlich erhalten haben, teilen Sie mir dies bitte umgehend per An=
twort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann aus Ihrem System. V=
ielen Dank

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Bec=
khoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075




