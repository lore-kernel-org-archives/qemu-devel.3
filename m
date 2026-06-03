Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A8CD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfF0-00006a-B5; Wed, 03 Jun 2026 02:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEy-00005t-Q1; Wed, 03 Jun 2026 02:38:12 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEw-0008Ja-Df; Wed, 03 Jun 2026 02:38:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGL5fxz6PtjzZercPI07o+rdpD4JMKhuOBpjc9ukbeBkuV4f65kz45UXin9ComVbxN8XaEXnr8KDZ7NNtNQZW/XljeSnCLILKG8y0q36/5lQHUO1cX4MYSPaQVA0qnG5wY6F29CYGjZnu33D5ZxQADgMKMQKHauLlPbwr7j1CjARO5U5uj1BWkyPdOJwZCEUCh/coHkZiquLVPz95RI/vi/XMhROJONdgZgP7MJq7832IFCZfvqyy3IOgzkIKjo7hmK75NoxWkzpztyI4BsBBt4nK9i71CamPA/bNSGBOXJ1/YMw8CMI9sAEkCCyKxArlpTiq3iePYKxoQkPa9FlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf7S7F8aRxSN2RBA0im64tndZUAiNIOEfUKvqRgggX0=;
 b=wraSestNkNH5xVWD2JoWfzuLrXbsmJKr5UF1Y847HXv8xZnnX+Pwzom0zGgz6ryERORRidSQzj3gPAFekZdsH7P/QuE8zji7ZKUU4qtEnlo4aMPeqSfTL0jG1/Yor0Xn437Qt8qNNVepBCMNKZUhQTuzPFOGZkPADZsSiEJUvIqVv5v/cAv5QZXfioNnIFbdwC1Q7XEM25GxsAQqOHgdPDpk4wdwUBTiJdvPqmXBYQO2GOgZkKsbLATr5+0gCbWn8RXT9Frsd06XCmXbPmjEcXwqD7mar1u3wl09W3WDpryWBpYVxw8xHpAclpVkZaCoyeifXV5u7AhVcDFGn/9F0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf7S7F8aRxSN2RBA0im64tndZUAiNIOEfUKvqRgggX0=;
 b=YeEDIylk9KgkYAt8hXm2Dwd+yNCANzAwaA+qk/Y+LBYp53ebsA5m1uZvuL6xWxznQ/9UgDj3DS80jd0mhgzXy7pFPtxsG7RLKtUSGISGdeLweEWdR24HzyUaVs79/UyABbNJJ4U6w9a1BWBQPTNXioLKk6qvQIAqcfpCO6kfSgsbyX3Xow1RD7zLt7FMEI+v0N9beK/7W4T82r8ECZ69UpfVn1ObNgaqJzzxIcw31M05G+e7etI0wjFEmEqw0DzKQKlE/uYfPFNlKhHesfL+yJ+m/v18pkwPISMxta044QmfifnCeI8BC+M2+nD48VOo1BE2dh6U6W8AvBFfgPDW3A==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by TYNPR06MB8525.apcprd06.prod.outlook.com (2603:1096:405:3d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:38:02 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:38:02 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 3/6] hw/misc: Add external Caliptra mailbox peer
Thread-Topic: [RESEND PATCH 3/6] hw/misc: Add external Caliptra mailbox peer
Thread-Index: AQHc8yOGVsgLN5+rAkWBO7I3alIf7A==
Date: Wed, 3 Jun 2026 06:38:02 +0000
Message-ID: <20260603063756.1481524-4-steven_lee@aspeedtech.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|TYNPR06MB8525:EE_
x-ms-office365-filtering-correlation-id: 38e74462-bc70-4b1a-021e-08dec13aa94e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|6133799003|3023799007|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: UpDeKngaEaxUsg9Nv+WQ/Dy2TdLO48kOiVHmA//KvHdZXYHDGpdckJwJBXbVFgvFl9mfBPTR6DBm3srIgKcMb5Ks0KuI9bKotaYSN5oQT+fUBIKaLZmANMMklwNW2TF9endH/V8lMaruNEnk4qPk21DLWklfktLRdGtOWKt/J437qxzlvirZJbcJwHRbVgkz8JjNXP7OCxZLxGGfOYbLQB1AUK0J9BcWyu7/mLEdtXn7BJckVJJWlNxRApB2jXhuOkZy5g8sTXtRSjtMJwAyM2xgyahb+Y99cvAn0MZPFMsxRq24w7UsGs57tS37mj09DcIILsecCND9PmW7KEcZgpEdfOFGNZk/zFSFVLvjINqlI/umRKp0wwkQFHjrtVRoQxSSkaQGApVCPQveakKy6AxXNkr9CqLQAOAMCW+23mpq4bNlD8WRLEKxfTpysJ4oL+4WbCYwK+Ry4ZPkI0+KZ8fPKXfC02wI6KpCEqv2JgOa+frKcVRTvqoxy4PWtx1BEA2mqmoQ8KUlNqD6cjhFiaCcKiSi/sa9CmDCmJosy2in1fgATZN0Wc2Ik7WpDE1fxJy332SnvSWshhEycKymJFs8luAme+CS9iw6mHcP+XGL1c0MgPfv3ucfiMsRFphel/riNQ5ufqpZ1xqZzgQUyTEXDVGD6DusaDCxW/S8KYzCdhiCxPS/bTXDNUWdN0zIGPJQdELoXMk0txBVE670baoQDMR+NqZJMHc2JkI2Z4Xo1t4e0u7FFL0b4o1+LLwEvjEEU2mcmhKumaFBRacVrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cygRZ+5s3HjjHdr24MII0NOjADOIzWaLT8NFdCx4uUtJPg+UCWkS0UHjPh?=
 =?iso-8859-1?Q?YGZB+D7yLSOKKySnz00nbwghIf/DVY98u2ftyGlVYGzwQX+Q32qjKVVvdD?=
 =?iso-8859-1?Q?7MZv9y9ZAd6OAID3im3EKJZ5OxqFTrBxxH26DauNm53cyJUzebYcCwOzcT?=
 =?iso-8859-1?Q?YybPi7JgYd7XrAjlciYqFwGOkP3kd5/yvM0NMKQ7ar3ygync/qGTUN/gKd?=
 =?iso-8859-1?Q?saPJFSiP11JeJBOLC4XbLXdEM0Hmkly8EFobunjL3pXocmWZvEkB+NjRHt?=
 =?iso-8859-1?Q?gbF4yKdIsBWAAPsFKF7yKLIlJNwjQu+YLVVAmTNpilW7vtIEcLQzdQCt9h?=
 =?iso-8859-1?Q?bT8V3u4+T8gcfDmhFlLSdoujsbDb3TNZWP6Z2EAF0i9DENppPpW6/iWTWa?=
 =?iso-8859-1?Q?R7I8tiaRawMxBEGESFhU+q5UA6UoDonLc+SpAiGZJCGed3rNgZGvbWX84I?=
 =?iso-8859-1?Q?vj3CpSazcksYzn8Jq84M/bRC+XTiLQCmxyJa5l3GzHsj0jlxyfwqWcBVg+?=
 =?iso-8859-1?Q?B3LzrxJO2FspF6a63MI3e5+25jSkQUyoDn4KiqPDZZYVQ3K4akuH0GED12?=
 =?iso-8859-1?Q?7FIJTxy4zeJFPnsdidA7WAD+dCmX3hoTQ/KNwIhHaDqip23Jn+Aq75QF6F?=
 =?iso-8859-1?Q?RD31Uz0tD8uRGjKe+hqu3zEFKP/0vlKyu6HAJ4LzvSlBhflgHrNuudIxe5?=
 =?iso-8859-1?Q?xX/JqP6MBmK6PlQQM6NSAdvCeJtTDjR65ctNq1d4J/SqmLXlyLqifraB5y?=
 =?iso-8859-1?Q?zHv1d4sH7U902t9BQil+cnNXlnpzWiNXEAZOm6bfSbggtETjEyPrFn9wN6?=
 =?iso-8859-1?Q?uSxwPkSVUYOuoWa166USVWmWzasIWWuaJRlPI3ca13+yu3e9ZXiABze9sv?=
 =?iso-8859-1?Q?mnBQrHMfNPRs6rkpDJh7ieeyPH0LK7Qfsn7lk23w+LlJwLfQsSx5eDPb81?=
 =?iso-8859-1?Q?X8Zt7DKhhI7MkTzKvkhapayCGhL+Y7rRElp5tPYEwgS1c/s/LNHdGo8X77?=
 =?iso-8859-1?Q?A721w+0XPm6rDBnswYjncqaAzDG28gQupTBmAzcs13NhhPIz9cnrP4DMDr?=
 =?iso-8859-1?Q?wmiFVEqWqvilWjvPOrDj+wkSj4lspv6WdgXIfiMyemHtjKfozASb/91u0V?=
 =?iso-8859-1?Q?QaATMkxemYrCVy6jIKjxaW9UIo9R1nRRG0FgrFmwnx0NzrUsr0P2Na7hNX?=
 =?iso-8859-1?Q?Uhx92kbKizqBAHfBeiJCnSK+VkDZ7mLyFIV5fzU5oKtN7DDWlWHCDJ5tOr?=
 =?iso-8859-1?Q?ayb/6ZRKReF2qCCYBsBjlxuYRs7XoMLozqlWyTGiRShRY5NCH5jA8S0uAa?=
 =?iso-8859-1?Q?wqxNgxH8O5TR1MJ1GvR04WEuYOCfFsn/ehK3tCPixc4Srlme+JnsUER4tS?=
 =?iso-8859-1?Q?WSdjogEmnJRT6VDj+eeJ4ggW+w+ukp5ytfEQC1gt8U6iOYDlqvmzVFLdI+?=
 =?iso-8859-1?Q?/ZpE6o/z0PqqzXXKgB+BTd3KGfXtjBTT/vV0lCtIjSCf3CjBmFg4AI6wdY?=
 =?iso-8859-1?Q?BO9Cf9zfSK1N/ujch/oM/YJ8VMHomPfVPAfXjZMr6oYtEPFJswGk7gb99n?=
 =?iso-8859-1?Q?BROxIHYrkyb73JWO7Xqvjgq0p5qkUIuqJIqxKGl6M/+X1D6Y2PZ9Y8qU3G?=
 =?iso-8859-1?Q?WdbhQ7tlgTOK3Qwo1/fLid14Pf9hX645APx4HN3m+SkyBWt3or4r+ml4og?=
 =?iso-8859-1?Q?gkTyWgOYhpMaxozYXiUInW9q9LdD0B549c754/xIgMdYhqTAwTvxlkY5jn?=
 =?iso-8859-1?Q?u3t9WOGqba1ERkG/W9yRyP+plOF6X3nrZGtbhLmWy+E2ws2xdcCH8t8jVE?=
 =?iso-8859-1?Q?wFXCX3xFig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LqkZUT9wOuMavjs7IJ/KM+s85f6VyEqPlYpVVwHUk/0p+CYLKwsg9AqPhiJUCPBmljRQoYKrq3qXMkh+NmTuNh1oUakFdelYbctVQw3cvpA052F08IZLi6eEZsEkeKBDPsMnjY2VQd9Cb/mamoHaVnffWDqamK8F1UxotYIRCsharbkC8/FdtZnYZhnTBAjfPh+8ROvEDzblmY69lLAHnuDdzc3RLWr4jd/9NfNf2gBmYa0gGnbuhcR6jaz5ItOWES1RrOuTA4NAyajOjlr7Hbu6KNsnZMuadnGCaLycyIqbqpJ+H65EOhqME3Js8BnmUKmJ37svpX5CLbPWf4W4bg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e74462-bc70-4b1a-021e-08dec13aa94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:38:02.5285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FABXDVwidusN06KQ8j9y7P5lq4XEaVYKPQrUfMLnObmQTRUseV/Cknn2DU7fG51wa+OZkr8vrCKrvs8elwUpgUooYSPBaudliDHNJmPYNGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8525
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=steven_lee@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a cptra-mbox-peer-extern backend that forwards mailbox execute requests=
 to a chardev peer using a small framed protocol.=0A=
=0A=
Run the blocking chardev transaction from the thread pool and report comple=
tion back through the mailbox peer interface. Block migration while this ex=
ternal backend is realized because the peer state lives outside QEMU.=0A=
=0A=
Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>=0A=
---=0A=
 MAINTAINERS                      |   1 +=0A=
 hw/misc/cptra_mbox_peer_extern.c | 318 +++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build              |   1 +=0A=
 3 files changed, 320 insertions(+)=0A=
 create mode 100644 hw/misc/cptra_mbox_peer_extern.c=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index cd5c4831e2..a0e11d4a0e 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -1270,6 +1270,7 @@ L: qemu-arm@nongnu.org=0A=
 S: Maintained=0A=
 F: hw/*/*aspeed*=0A=
 F: include/hw/*/*aspeed*=0A=
+F: hw/misc/cptra_mbox_peer_extern.c=0A=
 F: hw/net/ftgmac100.c=0A=
 F: include/hw/net/ftgmac100.h=0A=
 F: docs/system/arm/aspeed.rst=0A=
diff --git a/hw/misc/cptra_mbox_peer_extern.c b/hw/misc/cptra_mbox_peer_ext=
ern.c=0A=
new file mode 100644=0A=
index 0000000000..f8d5886880=0A=
--- /dev/null=0A=
+++ b/hw/misc/cptra_mbox_peer_extern.c=0A=
@@ -0,0 +1,318 @@=0A=
+/*=0A=
+ * Caliptra mailbox external peer (backend).=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "block/thread-pool.h"=0A=
+#include "chardev/char-fe.h"=0A=
+#include "hw/misc/aspeed_cptra_mbox.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "migration/blocker.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/bswap.h"=0A=
+#include "qemu/error-report.h"=0A=
+=0A=
+#define CPTRA_MBOX_PROTO_MAGIC      0x4D424F58u   /* "MBOX" */=0A=
+#define CPTRA_MBOX_PROTO_VERSION    1u=0A=
+#define CPTRA_MBOX_CMD_EXECUTE      1u=0A=
+#define CPTRA_MBOX_CMD_RESPONSE     2u=0A=
+#define CPTRA_MBOX_PROTO_MAX_PAYLOAD (8 + CPTRA_MBOX0_SRAM_SIZE)=0A=
+=0A=
+typedef struct QEMU_PACKED CptraMboxProtoHdr {=0A=
+    uint32_t magic;=0A=
+    uint16_t version;=0A=
+    uint16_t command;=0A=
+    uint32_t payload_len;=0A=
+} CptraMboxProtoHdr;=0A=
+=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(CptraMboxPeerExtern, CPTRA_MBOX_PEER_EXTERN)=0A=
+=0A=
+struct CptraMboxPeerExtern {=0A=
+    CptraMboxPeer parent;=0A=
+=0A=
+    CharFrontend chr;=0A=
+    Error *migration_blocker;=0A=
+};=0A=
+=0A=
+typedef struct CptraMboxExternReq {=0A=
+    CptraMboxPeerExtern *p;=0A=
+=0A=
+    uint32_t cmd;=0A=
+    uint32_t dlen;=0A=
+    uint8_t *req_data;=0A=
+    size_t req_len;=0A=
+=0A=
+    uint32_t rsp_status;=0A=
+    uint32_t rsp_dlen;=0A=
+    uint8_t *rsp_data;=0A=
+    size_t rsp_len;=0A=
+=0A=
+    char *error;=0A=
+} CptraMboxExternReq;=0A=
+=0A=
+static size_t cptra_padded_len(uint32_t dlen)=0A=
+{=0A=
+    return (size_t)((dlen + 3) / 4) * 4;=0A=
+}=0A=
+=0A=
+static int G_GNUC_PRINTF(2, 3)=0A=
+cptra_req_fail(CptraMboxExternReq *req, const char *fmt, ...)=0A=
+{=0A=
+    va_list ap;=0A=
+=0A=
+    va_start(ap, fmt);=0A=
+    g_free(req->error);=0A=
+    req->error =3D g_strdup_vprintf(fmt, ap);=0A=
+    va_end(ap);=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int cptra_write_all(CptraMboxExternReq *req, const void *buf, size_=
t len)=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    if (len > INT_MAX) {=0A=
+        return cptra_req_fail(req, "write too large: %zu", len);=0A=
+    }=0A=
+    ret =3D qemu_chr_fe_write_all(&req->p->chr, buf, len);=0A=
+    if (ret < 0 || (size_t)ret !=3D len) {=0A=
+        return cptra_req_fail(req, "backend write failed");=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int cptra_read_all(CptraMboxExternReq *req, void *buf, size_t len)=
=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    if (len > INT_MAX) {=0A=
+        return cptra_req_fail(req, "read too large: %zu", len);=0A=
+    }=0A=
+    ret =3D qemu_chr_fe_read_all(&req->p->chr, buf, len);=0A=
+    if (ret < 0 || (size_t)ret !=3D len) {=0A=
+        return cptra_req_fail(req, "backend read failed");=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Wire protocol (magic 0x4D424F58 "MBOX"):=0A=
+ *=0A=
+ *   Header (12 bytes, little-endian):=0A=
+ *     u32 magic       =3D 0x4D424F58=0A=
+ *     u16 version     =3D 1=0A=
+ *     u16 command=0A=
+ *     u32 payload_len=0A=
+ *=0A=
+ *   MBOX_EXECUTE (1)  QEMU -> backend=0A=
+ *     payload: u32 cmd, u32 dlen, u8 sram[ROUND_UP(dlen, 4)]=0A=
+ *=0A=
+ *   MBOX_RESPONSE (2) backend -> QEMU=0A=
+ *     payload: u32 status, u32 dlen, u8 sram[ROUND_UP(dlen, 4)]=0A=
+ */=0A=
+static int cptra_extern_worker(gpointer data)=0A=
+{=0A=
+    CptraMboxExternReq *req =3D data;=0A=
+    CptraMboxProtoHdr hdr;=0A=
+    size_t tx_payload_len =3D 8 + req->req_len;=0A=
+    g_autofree uint8_t *payload =3D NULL;=0A=
+    size_t rsp_data_len;=0A=
+=0A=
+    if (!qemu_chr_fe_backend_open(&req->p->chr)) {=0A=
+        return cptra_req_fail(req, "backend is not connected");=0A=
+    }=0A=
+=0A=
+    payload =3D g_malloc0(tx_payload_len);=0A=
+    stl_le_p(payload, req->cmd);=0A=
+    stl_le_p(payload + 4, req->dlen);=0A=
+    if (req->req_len) {=0A=
+        memcpy(payload + 8, req->req_data, req->req_len);=0A=
+    }=0A=
+=0A=
+    hdr.magic =3D cpu_to_le32(CPTRA_MBOX_PROTO_MAGIC);=0A=
+    hdr.version =3D cpu_to_le16(CPTRA_MBOX_PROTO_VERSION);=0A=
+    hdr.command =3D cpu_to_le16(CPTRA_MBOX_CMD_EXECUTE);=0A=
+    hdr.payload_len =3D cpu_to_le32(tx_payload_len);=0A=
+=0A=
+    if (cptra_write_all(req, &hdr, sizeof(hdr)) < 0 ||=0A=
+        cptra_write_all(req, payload, tx_payload_len) < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    if (cptra_read_all(req, &hdr, sizeof(hdr)) < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    hdr.magic =3D le32_to_cpu(hdr.magic);=0A=
+    hdr.version =3D le16_to_cpu(hdr.version);=0A=
+    hdr.command =3D le16_to_cpu(hdr.command);=0A=
+    hdr.payload_len =3D le32_to_cpu(hdr.payload_len);=0A=
+=0A=
+    if (hdr.magic !=3D CPTRA_MBOX_PROTO_MAGIC) {=0A=
+        return cptra_req_fail(req, "bad response magic 0x%08x", hdr.magic)=
;=0A=
+    }=0A=
+    if (hdr.version !=3D CPTRA_MBOX_PROTO_VERSION) {=0A=
+        return cptra_req_fail(req, "bad response version %u", hdr.version)=
;=0A=
+    }=0A=
+    if (hdr.command !=3D CPTRA_MBOX_CMD_RESPONSE) {=0A=
+        return cptra_req_fail(req, "unexpected response command %u",=0A=
+                              hdr.command);=0A=
+    }=0A=
+    if (hdr.payload_len < 8 || hdr.payload_len > CPTRA_MBOX_PROTO_MAX_PAYL=
OAD) {=0A=
+        return cptra_req_fail(req, "invalid response payload length %u",=
=0A=
+                              hdr.payload_len);=0A=
+    }=0A=
+=0A=
+    g_free(payload);=0A=
+    payload =3D g_malloc(hdr.payload_len);=0A=
+    if (cptra_read_all(req, payload, hdr.payload_len) < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    req->rsp_status =3D ldl_le_p(payload);=0A=
+    req->rsp_dlen =3D ldl_le_p(payload + 4);=0A=
+    if (req->rsp_dlen > CPTRA_MBOX0_SRAM_SIZE) {=0A=
+        return cptra_req_fail(req, "response DLEN 0x%x exceeds SRAM",=0A=
+                              req->rsp_dlen);=0A=
+    }=0A=
+=0A=
+    rsp_data_len =3D cptra_padded_len(req->rsp_dlen);=0A=
+    if (8 + rsp_data_len > hdr.payload_len) {=0A=
+        return cptra_req_fail(req, "short response payload for DLEN 0x%x",=
=0A=
+                              req->rsp_dlen);=0A=
+    }=0A=
+=0A=
+    if (rsp_data_len) {=0A=
+        req->rsp_data =3D g_malloc0(rsp_data_len);=0A=
+        memcpy(req->rsp_data, payload + 8, rsp_data_len);=0A=
+        req->rsp_len =3D rsp_data_len;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void cptra_extern_req_free(CptraMboxExternReq *req)=0A=
+{=0A=
+    g_free(req->req_data);=0A=
+    g_free(req->rsp_data);=0A=
+    g_free(req->error);=0A=
+    g_free(req);=0A=
+}=0A=
+=0A=
+static void cptra_extern_complete(void *opaque, int ret)=0A=
+{=0A=
+    CptraMboxExternReq *req =3D opaque;=0A=
+    CptraMboxPeerExtern *p =3D req->p;=0A=
+    CptraMboxIf *intf =3D p->parent.intf;=0A=
+    CptraMboxIfClass *ic =3D intf ? CPTRA_MBOX_IF_GET_CLASS(intf) : NULL;=
=0A=
+=0A=
+    if (req->error) {=0A=
+        error_report("cptra-mbox-peer-extern: %s", req->error);=0A=
+    }=0A=
+=0A=
+    if (ic) {=0A=
+        if (ret =3D=3D 0) {=0A=
+            ic->complete(intf, req->rsp_status, req->rsp_dlen,=0A=
+                         req->rsp_data, req->rsp_len);=0A=
+        } else {=0A=
+            ic->complete(intf, CPTRA_MBOX0_STATUS_CMD_FAILURE, 0, NULL, 0)=
;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    cptra_extern_req_free(req);=0A=
+    object_unref(OBJECT(p));=0A=
+}=0A=
+=0A=
+static void cptra_extern_handle_execute(CptraMboxPeer *peer, uint32_t cmd,=
=0A=
+                                        uint32_t dlen, const uint8_t *data=
,=0A=
+                                        uint32_t len)=0A=
+{=0A=
+    CptraMboxPeerExtern *p =3D CPTRA_MBOX_PEER_EXTERN(peer);=0A=
+    CptraMboxIf *intf =3D peer->intf;=0A=
+    CptraMboxExternReq *req;=0A=
+=0A=
+    if (!qemu_chr_fe_backend_connected(&p->chr) ||=0A=
+        !qemu_chr_fe_backend_open(&p->chr)) {=0A=
+        if (intf) {=0A=
+            CPTRA_MBOX_IF_GET_CLASS(intf)->complete(=0A=
+                intf, CPTRA_MBOX0_STATUS_CMD_FAILURE, 0, NULL, 0);=0A=
+        }=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    req =3D g_new0(CptraMboxExternReq, 1);=0A=
+    req->p =3D p;=0A=
+    req->cmd =3D cmd;=0A=
+    req->dlen =3D dlen;=0A=
+    if (len) {=0A=
+        req->req_data =3D g_memdup2(data, len);=0A=
+        req->req_len =3D len;=0A=
+    }=0A=
+=0A=
+    object_ref(OBJECT(p));=0A=
+    thread_pool_submit_aio(cptra_extern_worker, req,=0A=
+                           cptra_extern_complete, req);=0A=
+}=0A=
+=0A=
+static void cptra_extern_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    CptraMboxPeerExtern *p =3D CPTRA_MBOX_PEER_EXTERN(dev);=0A=
+=0A=
+    if (!qemu_chr_fe_backend_connected(&p->chr)) {=0A=
+        error_setg(errp, "cptra-mbox-peer-extern requires a chardev attrib=
ute");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    qemu_chr_fe_set_open(&p->chr, true);=0A=
+    error_setg(&p->migration_blocker,=0A=
+               "Migration disabled: cptra-mbox-peer-extern chardev backend=
 "=0A=
+               "state is external");=0A=
+    if (migrate_add_blocker(&p->migration_blocker, errp) < 0) {=0A=
+        return;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void cptra_extern_finalize(Object *obj)=0A=
+{=0A=
+    CptraMboxPeerExtern *p =3D CPTRA_MBOX_PEER_EXTERN(obj);=0A=
+=0A=
+    migrate_del_blocker(&p->migration_blocker);=0A=
+    qemu_chr_fe_deinit(&p->chr, false);=0A=
+}=0A=
+=0A=
+static const Property cptra_extern_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", CptraMboxPeerExtern, chr),=0A=
+};=0A=
+=0A=
+static void cptra_extern_class_init(ObjectClass *oc, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(oc);=0A=
+    CptraMboxPeerClass *pc =3D CPTRA_MBOX_PEER_CLASS(oc);=0A=
+=0A=
+    dc->desc =3D "Caliptra mailbox external (chardev) peer";=0A=
+    dc->realize =3D cptra_extern_realize;=0A=
+    dc->hotpluggable =3D false;=0A=
+    device_class_set_props(dc, cptra_extern_props);=0A=
+    pc->handle_execute =3D cptra_extern_handle_execute;=0A=
+}=0A=
+=0A=
+static const TypeInfo cptra_extern_type =3D {=0A=
+    .name              =3D TYPE_CPTRA_MBOX_PEER_EXTERN,=0A=
+    .parent            =3D TYPE_CPTRA_MBOX_PEER,=0A=
+    .instance_size     =3D sizeof(CptraMboxPeerExtern),=0A=
+    .instance_finalize =3D cptra_extern_finalize,=0A=
+    .class_init        =3D cptra_extern_class_init,=0A=
+};=0A=
+=0A=
+static void cptra_extern_register_types(void)=0A=
+{=0A=
+    type_register_static(&cptra_extern_type);=0A=
+}=0A=
+=0A=
+type_init(cptra_extern_register_types)=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index d23045c4b5..9d545e8fb7 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: fil=
es('pvpanic-mmio.c'))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_cptra_mbox.c',=0A=
+  'cptra_mbox_peer_extern.c',=0A=
   'aspeed_hace.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
-- =0A=
2.43.0=

