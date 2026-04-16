Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4C9F433D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsM-0008I5-VK; Wed, 15 Apr 2026 21:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBri-0007rc-Ct; Wed, 15 Apr 2026 21:50:03 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrf-0007PV-Sf; Wed, 15 Apr 2026 21:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbHxWUkSuwTHrhvAtfH81nBmWjXDWA/1pN2sjY/OVEoJLw9DCHotbuGDelHUA/Ots26WTNgxCAY9StxbmG/TjMjH3X7bqNMeBm0gQuhjrrlqBUe6ocix8ZfTPjGib5t9aiqtHy6AejwFqs1JlcPdDU4l/mWubysfImED8josdCZc+qZNUDpRjJaWpWvJFRbRN1VCV9sW9B5PTHRLgFp42QAfQCw4PmSgQOeYe3mewQvA2z1wq27NyySWMA1wuc0CVV6yMNdpWyu9jse1rMCDb7TMu+n9sLuNPTYOCz+r+9enkdV3O4aZmrYf3d365mf76i6LcTyelMy3151SCFSKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6usZ5mXShBCQUWpF5kXm4oFlG2iJBMpiedjEUoqbNs=;
 b=QbFNZXwLDKw6qWw6i3A7d8xAHrvZLnTrb4UB//Ez5Cqnh/bkygDrVMpn0BzX3sF/tfRmtHzRbAJw3hmw4+JW+MekBfMBmAtmO1W/pNcEb7kiSzvrZq1JQwO0W1gpm9caTScAtWArZgtnf5MhMRrisMNIMzEg4miWomEyjFY0PJpcchj9v9ec82Au5OawHBTdU6ecjB2CP3eaxnJs0zQ83zupSNwF6aFJ7wBlElwuHgGqHw+FdrVVwdf/I1Y19kDwgR+jc3tkaeEm6yKj2PIIcc9Uo3JltnuzP88NJ/Fpi4O3gnyMEZuoq9ejP12W3KDUcbQq+eZXsSr51Potv2gf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6usZ5mXShBCQUWpF5kXm4oFlG2iJBMpiedjEUoqbNs=;
 b=ervodXUbBeuYKLlen/c8b8D9o/azBmuYA+UEDcuHH/C+4gbRD2zGTkbvXBs0ZF1DTY9cEVxln/XArPD6EpuGGuOTKslpc6Hk0WUM7LeRUioJMNzTstxT5tsWd/XqNLJcyp4OcsJtoP23O5Jsm3K+Aiw+9HDW7bezqOFQ7vpS38wRVIqQBurij5s3C1ujDjq8Hu+8uwATVoWK3MQwrXOPvukBgeKtGINo2SAOoLQisWuwLPPjA/GxxI1PwK8JkAa7QD5FIhXN1T0PfTR2Q3SpH+c2/2Pm6Am8p8BbMyItUk+yKLW8g4wcD2KCpZHzHKfZS+7wjGgPjRtErTwS1TVGAA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 05/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs with
 trace events
Thread-Topic: [PATCH v3 05/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs
 with trace events
Thread-Index: AQHczUNJbYaidtPzU0Ws/JExGfVqVQ==
Date: Thu, 16 Apr 2026 01:49:40 +0000
Message-ID: <20260416014928.1279360-6-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: c787422c-d8f6-42b1-e3f9-08de9b5a6c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: prom7BlHFqaAtwo1pQeajI/ZNjwWUsgOthBJ2Lx6bjViHBeHBce7S8tdtAj58KqX0R9Xkw/SsY6B1f3N7AazX0R1PNo0wkWS+TCZIWb5EhYbXJ70LMk/I9+cf21geabINU+fi50DRS8ANslX8tPTea+xIMc4U9sOq5DGFCobBNrM+wpAb6XsvHd3BqvtYhLv7t5wMJYOiA3YV59zcvGF6QZHkFcFBzmmKdcbmKqvzrbq/G+xxcmfOw/vC3gRPlzjjA+zuVdi7WVKphuFFaZild6a3oTDmx5m8ZTLSUs+Q+DmLHXozCsNjGIzVz+diNoWm/kYIGS3RQqOx3SK+s3dXf/RCzCTNo2Wo/VisiyI7V7O9RZ1ULdDJs1NKqa0ig0VmyAC/ZDgsgo0CrMfUAGZprkJC/eAqQ5gRaeQ6Qf1ftJ+hQ7DHMzATZDTNhGyfoK92fbj2x3Nxx3bfOZjdGjGFUCt3zID+zGQziwe0sLYQ2zHaIf9n1zFibMNcRvTmnjhUMGOQ8dmbP/mIc47WaodhnsTikPkJ1Kfr3rhpN0stv2hGe8DMPTKKx+iPZUKTPsCV+2rQSSfYp0XF+UbD2cG5RBczzGYkhm2Weg35kTBXzttnkeV5aDhqThi5vcOphdzrAQeqHX0OiN0QPd4TqNhqYbqLi2/aSPbJUSfL9MJJ0dgFVtjmSs89LhWlIeyRZkZG9U8ufBnjOJwkVdfr34rMK+UXpj1Du1qkpI5RtsRpKic3ubsXPieS6nKpStfTXEaPSuFjtLBFM3NvGCBHiSnJqEvSes/jH1+nnrIyIRHHGSeytpz7Cf1l7uq8vlPO+tm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oMpOg9eOrUnN1/W0g10WvWcT3IA8Lz1/WqQHLQhF5iKLXGHKOkntnhWItd?=
 =?iso-8859-1?Q?rp/1hb2tBJ2k09mvfITszvNkQ0F1t/tB4IE4v5gmhD33pKTM9I6aXJ5YAc?=
 =?iso-8859-1?Q?Xo7ImhPeTCG+AQ8L6y3j7y454sHcSeaT05NMwbvtqsPDpdVAKO6xinfVwl?=
 =?iso-8859-1?Q?EKiGWb39lLvdKxhXe6xmxoMaSQLxVYjrNGnKyZn0h4MUkTCpaq6iyMdlCd?=
 =?iso-8859-1?Q?fZafuvDNx7jzIAo6G93sD+8uep2MAuMt/SGLqdmKvaUFoG1MjtGz9Yke88?=
 =?iso-8859-1?Q?+OSs0IvBsxHWSjrnUyzLk3KqXlPLolnFQzksiAXRtmYMBzYtBItVvE8pSk?=
 =?iso-8859-1?Q?Mamx+YM/nLh1a3UWfy8ny37jaLerJWsJjWQquuWJwbI5YugMOyDo8PpcXg?=
 =?iso-8859-1?Q?DB2m0Lh2jtHXoRDCXw9Xu5IxlDPZcs8AsElXIUeZe0Iv/GdossIs606I8w?=
 =?iso-8859-1?Q?Ow6uo+jZNcygZij94R1yEe/HrytGFXZJJkqAzx9vqyUOEPcEtGU1SzXHH+?=
 =?iso-8859-1?Q?itK3CsqmxopudyJG8N08eCrCJZG5EVA8qUZij4YO6UVN0diihE6LO6V0Xf?=
 =?iso-8859-1?Q?wMEyWEshk935iJ2V8FH1l9INnQKXrpbUR1AkE8awI3Nw3qbDoBTgumGedv?=
 =?iso-8859-1?Q?CJzuzFJF4dfljvtHiVdDRjQPYZm+wkXZ0F8y7VQx4LqKudGewy6bhf1YnK?=
 =?iso-8859-1?Q?GP1rVx/T8u9dFvbdvPoNlP2+yGpmAxm9X5JPY9XqQjwdjIti+6C5vhvTB0?=
 =?iso-8859-1?Q?zKxwKeOJ7SpFtqQK78mLYMlAhnLO8zzu33zzbfDG1Nd7zbi3unY6hhIU1Y?=
 =?iso-8859-1?Q?MbIKzDz7wGnKX3uEl5vMWE59GXU0p6U5yfEYkNwUmuIF/QlWczL1093KFU?=
 =?iso-8859-1?Q?oCJEhw3wUEER/cYYezcSg+yNb72kTJlUw8Topj803i66u0A2iXz8YJarCy?=
 =?iso-8859-1?Q?vBh2wPsIG4FsFqIXE+n3UUyCZ58STBCSYgzeDVBHwb8k0taJgKbLUwug4y?=
 =?iso-8859-1?Q?ZxYfIbSrtr85rCyr78V9EPhZ40FdRt0zCb/otvUujAMmDza4seaZUrpxzL?=
 =?iso-8859-1?Q?rLN0ltGB8NuUzKP0nKQ6p16YohrqknWs7meMJotUhUc8yLVni3WOL9Pr9w?=
 =?iso-8859-1?Q?PLVmtSGlxkhKFlpM+ETGErZn7J3JFNiAVWivlLTQJZOXf+0esqpaJGqANt?=
 =?iso-8859-1?Q?gprhvFaJ9gOEQjjPS57LfVsKAAZ5woeCTxhbJ58GG1xWdHoV/8VLZxf6oo?=
 =?iso-8859-1?Q?oTLULSMh5DsE4rNegZgRuq6Yk2Kk7F7/aQGn4MFNZL+Bvd98big9sz5Odd?=
 =?iso-8859-1?Q?tdJ+wJ26R0wjnVDJRv1n3tQzyLwaeCm7iq9SrFiqlYp4aBHIVDCVlGNxMv?=
 =?iso-8859-1?Q?CDkgD0aKu3p158ayfmJ17ZCfQLJJcAdji5p8Y46hwdkXu3h3eC/qA+qMac?=
 =?iso-8859-1?Q?ZtT0cY8lwi4eU9TNW3wfej7OIvpokltyJQngXvkTzdxFwSJbcI11+ibtzn?=
 =?iso-8859-1?Q?V5gKSad+MXol89aNqqWqz5W4cvEWgmVNCtngPN/H1eQhwYlZoeBiMT7t2O?=
 =?iso-8859-1?Q?3LzXD7xKx2ENl7Wv/14BOXo9UXzwZ7woWhUevwGYm6eNicEuZThk/w2LCp?=
 =?iso-8859-1?Q?tP9Fpi47VPTtlnte3FKAibsi0OkyplugmGV0lRVDtcX4Z9qvzSboRjh7E/?=
 =?iso-8859-1?Q?pQOLOl+3LfTDX7puDJ42JFpQ7eJ2wsAEpBkutjmp4w4OVkiBj1lfi0qpxS?=
 =?iso-8859-1?Q?RDHTDQ+q7n6Etg4IRmT6lZw/o3NRB0C/udA3/3BiVorJX99ErNE4GCKf4e?=
 =?iso-8859-1?Q?++3uiivWoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WmXLzu/AKjGEAnXo03LigglsocyC3tNa/Sz4KW/1C8dqIh4fA6RZpguO6vqQHqGu1bnOtlpZ39DVIFI2MUbRx+SRKKndVGiN1vPZk17+cEHgK+t8q6NcUP+n4b9G30S8U52awM8GlsaFijaNaqhObqczqYqDISH1M3rDVa83RecNyI+EOCRqb0FGwA+YkFc2cErBkrKlCR/4Z0dyYbh6YNrlQ081kAcWplcDmsX+7eq3lNiPMD77pjVRNqXd7z5FkIyb3r+MIpaIYqd2e1lM7Jy+5ZBulFMnExaKLoPKYCQyJJAp/xgSiua0ZsfmitOjZYNtZ3N1R/BgscKkxJN4ag==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c787422c-d8f6-42b1-e3f9-08de9b5a6c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:40.0490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nm23u4DDjozNLHmNCfLfPpnw0SRnCbfvzX/KtavHKM/gWIJGpqlZ41ZpH29CZQ5SmW1dsrDn9P0FgoeoK7QwUeOJd5Y8R621K3y8vdslD6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Replace legacy DPRINTF() debug logging in the EHCI host controller=0A=
implementation with QEMU trace events.=0A=
=0A=
The EHCI_DEBUG macro and associated DPRINTF() definitions are=0A=
removed as they are no longer needed.=0A=
=0A=
Trace events are added for:=0A=
- packet submission and completion=0A=
- queue head execution state=0A=
- periodic schedule advancement=0A=
- ITD error conditions=0A=
- port state handling=0A=
- skipped microframes=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   | 10 ---------=0A=
 hw/usb/hcd-ehci.c   | 49 +++++++++++++++++++--------------------------=0A=
 hw/usb/trace-events |  9 +++++++++=0A=
 3 files changed, 30 insertions(+), 38 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 736407fd52..4234591cb4 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -24,16 +24,6 @@=0A=
 #include "hw/pci/pci_device.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
-#ifndef EHCI_DEBUG=0A=
-#define EHCI_DEBUG   0=0A=
-#endif=0A=
-=0A=
-#if EHCI_DEBUG=0A=
-#define DPRINTF printf=0A=
-#else=0A=
-#define DPRINTF(...)=0A=
-#endif=0A=
-=0A=
 #define MMIO_SIZE        0x1000=0A=
 #define CAPA_SIZE        0x10=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index bebd137f94..d0ea4949f9 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -839,7 +839,7 @@ static USBDevice *ehci_find_device(EHCIState *ehci, uin=
t8_t addr)=0A=
     for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         port =3D &ehci->ports[i];=0A=
         if (!(ehci->portsc[i] & PORTSC_PED)) {=0A=
-            DPRINTF("Port %d not enabled\n", i);=0A=
+            trace_usb_ehci_port_disable(i);=0A=
             continue;=0A=
         }=0A=
         dev =3D usb_find_device(port, addr);=0A=
@@ -1281,10 +1281,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     assert(p->async =3D=3D EHCI_ASYNC_INITIALIZED ||=0A=
            p->async =3D=3D EHCI_ASYNC_FINISHED);=0A=
 =0A=
-    DPRINTF("execute_complete: qhaddr 0x%x, next 0x%x, qtdaddr 0x%x, "=0A=
-            "status %d, actual_length %d\n",=0A=
-            q->qhaddr, q->qh.next, q->qtdaddr,=0A=
-            p->packet.status, p->packet.actual_length);=0A=
+    trace_usb_ehci_execute_complete(q->qhaddr, q->qh.next, q->qtdaddr,=0A=
+                                    p->packet.status, p->packet.actual_len=
gth);=0A=
 =0A=
     switch (p->packet.status) {=0A=
     case USB_RET_SUCCESS:=0A=
@@ -1327,7 +1325,7 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     } else {=0A=
         tbytes =3D 0;=0A=
     }=0A=
-    DPRINTF("updating tbytes to %d\n", tbytes);=0A=
+    trace_usb_ehci_qh_tbytes(tbytes);=0A=
     set_field(&q->qh.token, tbytes, QTD_TOKEN_TBYTES);=0A=
 =0A=
     ehci_finish_transfer(q, p->packet.actual_length);=0A=
@@ -1392,10 +1390,9 @@ static int ehci_execute(EHCIPacket *p, const char *a=
ction)=0A=
 =0A=
     trace_usb_ehci_packet_action(p->queue, p, action);=0A=
     usb_handle_packet(p->queue->dev, &p->packet);=0A=
-    DPRINTF("submit: qh 0x%x next 0x%x qtd 0x%x pid 0x%x len %zd endp 0x%x=
 "=0A=
-            "status %d actual_length %d\n", p->queue->qhaddr, p->qtd.next,=
=0A=
-            p->qtdaddr, p->pid, p->packet.iov.size, endp, p->packet.status=
,=0A=
-            p->packet.actual_length);=0A=
+    trace_usb_ehci_packet_submit(p->queue->qhaddr, p->qtd.next, p->qtdaddr=
,=0A=
+                                 p->pid, p->packet.iov.size, endp,=0A=
+                                 p->packet.status, p->packet.actual_length=
);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -1472,7 +1469,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     usb_handle_packet(dev, &ehci->ipacket);=0A=
                     usb_packet_unmap(&ehci->ipacket, &ehci->isgl);=0A=
                 } else {=0A=
-                    DPRINTF("ISOCH: attempt to address non-iso endpoint\n"=
);=0A=
+                    trace_usb_ehci_log("ISOCH: "=0A=
+                                       "attempt to address non-iso endpoin=
t");=0A=
                     ehci->ipacket.status =3D USB_RET_NAK;=0A=
                     ehci->ipacket.actual_length =3D 0;=0A=
                 }=0A=
@@ -1675,24 +1673,22 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehc=
i, int async)=0A=
         if (ehci->usbsts & USBSTS_REC) {=0A=
             ehci_clear_usbsts(ehci, USBSTS_REC);=0A=
         } else {=0A=
-            DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status re=
set"=0A=
-                       " - done processing\n", q->qhaddr);=0A=
+            trace_usb_ehci_fetchqh_reclaim_done(q->qhaddr);=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
             q =3D NULL;=0A=
             goto out;=0A=
         }=0A=
     }=0A=
 =0A=
-#if EHCI_DEBUG=0A=
-    if (q->qhaddr !=3D q->qh.next) {=0A=
-        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
-               q->qhaddr,=0A=
-               q->qh.epchar & QH_EPCHAR_H,=0A=
-               q->qh.token & QTD_TOKEN_HALT,=0A=
-               q->qh.token & QTD_TOKEN_ACTIVE,=0A=
-               q->qh.next);=0A=
+    if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
+        if (q->qhaddr !=3D q->qh.next) {=0A=
+            trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
+                                       q->qh.epchar & QH_EPCHAR_H,=0A=
+                                       q->qh.token & QTD_TOKEN_HALT,=0A=
+                                       q->qh.token & QTD_TOKEN_ACTIVE,=0A=
+                                       q->qh.next);=0A=
+        }=0A=
     }=0A=
-#endif=0A=
 =0A=
     if (q->qh.token & QTD_TOKEN_HALT) {=0A=
         ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
@@ -2154,7 +2150,7 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         /* make sure guest has acknowledged the doorbell interrupt */=0A=
         /* TO-DO: is this really needed? */=0A=
         if (ehci->usbsts & USBSTS_IAA) {=0A=
-            DPRINTF("IAA status bit still set.\n");=0A=
+            trace_usb_ehci_log("IAA status bit still set.");=0A=
             break;=0A=
         }=0A=
 =0A=
@@ -2221,9 +2217,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
         if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-=0A=
-        DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
-                ehci->frindex / 8, list, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
         ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
@@ -2291,8 +2285,7 @@ static void ehci_work_bh(void *opaque)=0A=
             ehci_update_frindex(ehci, skipped_uframes);=0A=
             ehci->last_run_ns +=3D UFRAME_TIMER_NS * skipped_uframes;=0A=
             uframes -=3D skipped_uframes;=0A=
-            DPRINTF("WARNING - EHCI skipped %"PRIu64" uframes\n",=0A=
-                    skipped_uframes);=0A=
+            trace_usb_ehci_skipped_uframes(skipped_uframes);=0A=
         }=0A=
 =0A=
         for (i =3D 0; i < uframes; i++) {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index dd04f14add..0d4318dcf1 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -89,6 +89,7 @@ usb_ehci_state(const char *schedule, const char *state) "=
%s schedule %s"=0A=
 usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
 usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
 usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"=0A=
 usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
 usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
 usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
@@ -100,13 +101,21 @@ usb_ehci_port_reset(uint32_t port, int enable) "reset=
 port #%d - %d"=0A=
 usb_ehci_port_suspend(uint32_t port) "port #%d"=0A=
 usb_ehci_port_wakeup(uint32_t port) "port #%d"=0A=
 usb_ehci_port_resume(uint32_t port) "port #%d"=0A=
+usb_ehci_port_disable(uint32_t port) "port #%d"=0A=
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"=0A=
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %=
s"=0A=
+usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%x, ne=
xt=3D0x%x, qtd=3D0x%x, pid=3D0x%x, len=3D%zd, endp=3D0x%x, status=3D%d, act=
ual_length=3D%d"=0A=
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask=
) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"=0A=
 usb_ehci_guest_bug(const char *reason) "%s"=0A=
 usb_ehci_doorbell_ring(void) ""=0A=
 usb_ehci_doorbell_ack(void) ""=0A=
 usb_ehci_dma_error(void) ""=0A=
+usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%x, next=3D0x%x, qtdaddr=3D0x%=
x, status=3D%d, actual_length=3D%d"=0A=
+usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, recla=
mation status reset - done processing"=0A=
+usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08=
x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
+usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
 # hcd-uhci.c=0A=
 usb_uhci_reset(void) "=3D=3D=3D RESET =3D=3D=3D"=0A=
-- =0A=
2.43.0=0A=

