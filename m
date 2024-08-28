Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0ABC54FA7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHyF-0007AB-3Z; Wed, 28 Aug 2024 08:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHy9-0006rH-3E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:40:13 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHy6-0003su-4z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:40:12 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 28 Aug 2024 12:40:06 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724848806; bh=WvXA3b/pGBwMm/pSzKkwS64utPARX3Z7jOH9XCrQCdg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 DeqHtCmSciWTqgAKxI8NIOWWOKU0hFPuhhh0E57a4f91DKq59pKpL8bgjVyOinf8YtCHiyi3Pdf8W67hnKF0BQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724848806; bh=WvXA3b/pGBwMm/pSzKkwS64utPARX3Z7jOH9XCrQCdg=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 ctGApoxA4Crcgi3HSHx+pZN+r4Tn1HpGAQeccbg+8iPACQGRmVZf7lLu3Rxmlu31v5mwLtoY8lhAx2RnNAV1Qy2kVhiyh0xqBKTpgis1hg0B4YCHB2UH8YEGmRCRLKyW7KHeXdr/Jagdh4pJazln+AOMfCi2aJvL2k+37r4LezVV8JIBeWEyVxkiBOkBOcp4bgtAaSIeF2upNR9+txPJZ7Sk3ZbdaBtTrkFsCVtg8b5wGsLEdmC5xERdDba311sAI+B6jDTye6TjEBss71pnjRGqsuY+XrdOkyCYLHVlcrNnVlwhXg9G+da7LEBbih+gOT964wlCEP3YXRJ+T42QUQ==
Received: from corvink-nb.beckhoff.com (172.17.128.201) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:40:04 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>, <c.koehne@beckhoff.com>
CC: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: [PATCH v2 5/7] vfio/igd: add ID's for ElkhartLake and TigerLake
Date: Wed, 28 Aug 2024 14:39:57 +0200
Message-ID: <20240828123959.84400-1-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828123549.83293-1-c.koehne@beckhoff.com>
References: <20240828123549.83293-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.128.201]
X-ClientProxiedBy: ex07.beckhoff.com (172.17.5.172) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 0d68c6a451..8a41b16421 100644
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




