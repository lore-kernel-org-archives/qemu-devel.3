Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F37CA9ED6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mV-0001lc-Id; Mon, 12 Oct 2026 02:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mS-0001k6-2H; Mon, 12 Oct 2026 02:45:04 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mQ-0006MT-5l; Mon, 12 Oct 2026 02:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDOJhM7dnN4/1JFlbftT6nXmJ61+W1qh0U3w1R9qEkfCQwPUzUrtcb+DqUapwaNR3LbZzbAC8b5wbyX5ZvDK43MiS2pyY/uByTSkvxaa2yAeGY6G1F+2aR68jX7sNkD82rmgU9ei6KvLNjW9wB3WyJ/25P4iSQmUgWq3yvefCAp/FDO6fdHh9ioMq7FiD1kfE7Ug3TpxI1OcWbur6KcUwf0rdJKHQOUADaX53nClmjCm+sUIgBfxBxQ877DzuryjgBHfv1Y2XazALy+9DEcwLy/CKqGB60Fw6uajjy23JUvtV8uA1QFHOhyu5vbfqRNLceXTS1D4ARkdvT6JSKNPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5uC+u26CxmU9tcBwQ+VQCuJD1i5gWinZRYDog6jts4=;
 b=ARIDiP/7Y0HBrESOBgl6Lb0O0FYS2DfCKDFdUh4B/W6bSntxGABvxRWgHeoxSJ+ux12vhmVGFLJqMlw+pU99J5PAmezIN4DVpkx1Ob+wTArdCyISNTLrECCclf4dVbNzMh3afmM2qml9lJeVIChyMTlB28nuQez2m036lXuJt8RoinFDBIVM1Nj95G+xm+JjfLnbpCbzdsarM91FjWIy+Esq2cizvKpSCV2XoVwjuvdbUAWvMq1ob/9K2L+WfGSTxlJ9uw059rBuln31U6BIzMcy6+ApVCZaarCZ/QnkIIAqXtQpgc29zvWYoMIPHh5n9BvJBvDTymPiM8matKUsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5uC+u26CxmU9tcBwQ+VQCuJD1i5gWinZRYDog6jts4=;
 b=qPtp4gcyEXtGQDsqKSPHJfuHfryTn7lYsfkK21BYFFSrmeL0929ENQPmKb96z3CPr7de0xCIO4BicdlbQLl1aH+IsTdkA57OoKzT4hOSMczm79MW3Mc/FtxaBnP90qMc72bG60RgchNsBcIHOAavUM3dGRuprM1AHqGVmcydDYd2Pj4xR2ZJnEASt3UdTucdTPL++akzyO9A5h5vWCBv1Omn1Zt4UoXbuaavNsoFTo9kHTRR/U3+1j4FI6kNfRM9NWRl3Y4BXZJjSS4Id+gDVO0ua0YTM5pNol8FEMFnpJeQKunT13NX71JgToD7BZZwCXHyqJ0AAOzx96TUjxw6oA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:51 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 04/12] hw/arm/aspeed_ast27x0: Use a table for unimplemented
 devices
Thread-Topic: [PATCH v2 04/12] hw/arm/aspeed_ast27x0: Use a table for
 unimplemented devices
Thread-Index: AQHdWhUu7qIl64TSWkSMtNags/llkw==
Date: Mon, 12 Oct 2026 06:44:50 +0000
Message-ID: <20261012064445.2571633-5-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: e29bf27b-fe1b-4e8f-8ff6-08df282c508a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: uRD8/KWBZecoyqdJrgiVrI7ONFpQQyLYDNFByGVkeyMDqQXBSx+QrgtZQjWO6+z9EUDlsWphsMxAuConOWjyudELMm6FKTcd5U1Y8UY3KGizeSgowXG4Nco4DcHRFpPsvmatVhgjE7JrjkZoxFwU9+8Qg9aHYq0l34GQ/I1sT47dPYK4MWCYH1z3itdmmMZgitBOrp1dWe1ImmDrMS8KnE6ZoYSrmaFqO3o1fco3PK1sUprWChqsKIlr107lhXBo36O2QOthydU7TkQXNvExS7TjgO0/pp/Z30n8eCwRgM7vmnSbU9Wjy2K8ecBJsXtRbLI308NirnfvRCJHoDIbSLuqsJtbgP7AZ9nUEQLoRSlB8zElHKIbYNBlF2OCUKF2enJ6E8DBjIXGSvBmDKNDK5QqcRKY953sj140qVHs3A2h2opyxCQdecs4PtqTPnm/YfPbFgaXceqNlLL067Le91RPH9LO2dczshOYMWp5oYcsMRV6V5wDU0iFTYlaTKM8bOHjIByxTpiRleS12tTL6PsdosTLaYpRqC448kafnDeXYWBUT1xXa4sUnGwwFeqN902SqQ2YIzVknOiR0SDflAOkm0WbO58BRbq4dO7rEA+KCNCSGtnIVcX25ITYc5r5L3CU19L2QwZ2DQyGrBEMoxOdMOUi6QkN2ldzcyPSsGf6qMyrrpNHa3fsE+SV+0PrQi3ajDxRgiDqCIbzYoorqY39izTw0GOY+NG7vrpxtq8Dv7J5RahlggKF5KsDRbFO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V9iayTCTFi5FIV9uuD21oe2Zfz9+6VuEyot8nt4jC0SSdWkNkWVAAOC0de?=
 =?iso-8859-1?Q?sajg56qKuxWAhYpg5bxsIoKApLfbuNUQz5xuI38ktRClrCMVADQKiXIrpO?=
 =?iso-8859-1?Q?z6FpNAlSx9UAq7Tlqh9DMdrMxd+buzeuqVhG9W1RNwOHRmNnfGOWOEyOLO?=
 =?iso-8859-1?Q?POZmgtUMtvXHrARsG/BAW+SDdoKpBi0qhxhudDU5hryhcHDj7OMjKp90A4?=
 =?iso-8859-1?Q?ZoK7G0tVQVk3KrUw4i5W6Co9BcHhixEXCsw3fUev8L/EI58oVMUdIrBbRq?=
 =?iso-8859-1?Q?edy9rHhnjHiacpaUjMaYqJHe17+Ie/LJ0wrw5HCU7FXjrH7KgK0Rt4fZyP?=
 =?iso-8859-1?Q?3CqazF6ZldyvIS++7ga6kNraaz+3KyvtCLYWzkzpLmtQXiVy/GwXehxi7S?=
 =?iso-8859-1?Q?yJaFZgaTNNTQeho9/sVpzqtHYZ3HKFfGWeH7aWEffJAoG9hcOdG8MF6cST?=
 =?iso-8859-1?Q?dO4WZH2WBJhc1ixTj7pdCxo5z4YAURdN+jHmoIFEdaUOqx7Y+ZRTMZA/nA?=
 =?iso-8859-1?Q?2orEYAdja+3fYEiDkXGS0GlBcc9/ivVeN07THq4tJ9LdkCER3JyJeL36Cp?=
 =?iso-8859-1?Q?EXx2YOa5yjIPeZlPW+N5/rA2LTWOaBZMY71UuWTvX0GyyRb6XsMvkgRhSq?=
 =?iso-8859-1?Q?1zhqCadWzL0h36ACYDa+cu2AJyE4p2VKz88BNk0Nu92bJURO8okHlESsWa?=
 =?iso-8859-1?Q?w9M69suH5JoCt3D6AR4L2SuyxNIt6YisIOpEpQ4FLtmvkolVpTW6q0h4dd?=
 =?iso-8859-1?Q?bHVTJvc9B59grg4mozVlcqDpKLINtOIvUR1gSExjoIHS0wpVqEO0Nyd0LG?=
 =?iso-8859-1?Q?zg1C2rJa5+wlutsVUYzZX5JQS/2MFmYB7eqEcF6l4RURwxsbG3FykzrX8H?=
 =?iso-8859-1?Q?uClCIq9bYhMJCBzTlse/sltXGnAOvqEUa3Xa4uRvdRyVrCOsR77slhYbaO?=
 =?iso-8859-1?Q?CYgK2GOUxh593KHSr43xiNZD+BLOnLAdFB4mC70jTBRTurofHs6Ho03sWD?=
 =?iso-8859-1?Q?lSVEw1s5RrDEH6cjQ6j9rqo/g8kByoqZXJFJZ3VhR4agli3ko9hQ/BIX28?=
 =?iso-8859-1?Q?fZSlLDXWAPEtrHaiQgyNtFLJRaB+p+GBn5Bpqxapq+9GhgEPDJaiwGj8gi?=
 =?iso-8859-1?Q?GY2s85dSgy1vx9oh9WKZCuUBjWcWFyV3NDPXQUcdW51bYqAvlt+59XkwCp?=
 =?iso-8859-1?Q?bBU7W4s4b+zOHL3FD9fkTkN+i4+eMNH+YGN2hxolsjFbEAR1ijFqk61g0m?=
 =?iso-8859-1?Q?uBQiJJqAyeQ+4MwvkSprx9qNBi0ncSHRQr6W+hYEeQ004G8dfvzsekxRfF?=
 =?iso-8859-1?Q?spTVKpPyt7iRzUDnpoYjdxH7Og8nl7bfEutPektZzaddE530EsVq75BNdP?=
 =?iso-8859-1?Q?7R/7pl/2cWKPCGHw8V56QfLKXh98AdB68BiexjyIxcwyj0maYvCb112Ygt?=
 =?iso-8859-1?Q?F27qbsmYqcXMpYIwM2xG5HgbBMKBbPRNihekMK3zxUmwCsMvs98ePRm7vV?=
 =?iso-8859-1?Q?zh8UoHs4rh1toN0pKWUFhLizwqjjGxCFD16Ky1iKZ2DGMlTb7sptGPK26R?=
 =?iso-8859-1?Q?5jOACtXdmC/QniDxzpJ94ODjs3umQFa1IvbKYqGY3y4kcghYlIHgJKqy7A?=
 =?iso-8859-1?Q?y+HBIz6Iz8AqmGR25LJqudyujSSPBbBrvmJGyNHfKR3APOFmMillWxeHVk?=
 =?iso-8859-1?Q?fMVLcYeCGuncu0AVkd5HTE0a9K+2ao72K5C5Yl213darzuD8HtIj42Vu7r?=
 =?iso-8859-1?Q?qZR+KVQvIblGsZFHIHkZ1Zf0HUh/0iVjpSfsyKzTTglyBq2IeE7DnItgig?=
 =?iso-8859-1?Q?irhFDd5deQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0AZVLMWwX9itYC/Cu9ndDof4Edcubye5SpOpaHovRpXNhj1gLNSGn+TZrC0Hoca0cq2xAS0ydITT03gxOHo3N/57ucfbwZN7wIdewKWZ0oolqVNKCRKfW+Hex4poZBkpZvms7dtkbweWPHDXdvlekgt3L9qiqMUXpa/ENjktr4x1tJn94XecTvv6tgMW+1ySe1I3Ed7i9HY5whVJgcXQ+Da+LaOYdKAifNFSGmw4sYYQMBUUDgPBqtCQqd6ZxPScLm8unfjedTZD//b0O1RKPoZ9yDX2sFgTEJKPa0csZ8O4qTivGmin/+1jVeHRzcJ1Xfn6zovoImp3aZ+BFh20Wg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29bf27b-fe1b-4e8f-8ff6-08df282c508a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:50.4647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moLr3X5IQjsDnmyYvtIEwPR16Q2DPTeD2MiRNL/ZE+ui1RSVNYd1BFszvieGjjROJ70ftaSJSwFasyJXojPs8Z+rYJ2EQl/MsR3mzjItBFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedSoCState. This made the variable names confusing. For example,=0A=
AspeedSoCState has "udc" as an unimplemented device, but=0A=
Aspeed2600SoCState also has "udc" as the real UDC model.=0A=
=0A=
Use the unimp_devs table in AspeedSoCClass to describe the=0A=
unimplemented devices, and use create_unimplemented_devices() to create=0A=
and map them. This makes the code easier to maintain and read. Convert=0A=
AST2700 to use them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 41 ++++++++++++-----------------------------=0A=
 1 file changed, 12 insertions(+), 29 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 6365dbd638..2ef29e31e9 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -24,10 +24,6 @@=0A=
 #include "qobject/qlist.h"=0A=
 #include "qemu/log.h"=0A=
 =0A=
-#define AST2700_SOC_IO_SIZE          0x00FE0000=0A=
-#define AST2700_SOC_IOMEM_SIZE       0x01000000=0A=
-#define AST2700_SOC_DPMCU_SIZE       0x00040000=0A=
-=0A=
 static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,=0A=
     [ASPEED_DEV_IOMEM]     =3D  0x00020000,=0A=
@@ -263,6 +259,14 @@ static const struct gic_intc_irq_info ast2700_gic_intc=
map[] =3D {=0A=
     {201, 3, 1, ast2700_gic201_intcmap},=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_soc_ast2700_unimp_devs[] =3D=
 {=0A=
+    { "dpmcu", "aspeed.dpmcu", 0x11000000, 0x00040000, -1000 },=0A=
+    { "iomem", "aspeed.io", 0x00020000, 0x00FE0000, -1000 },=0A=
+    { "iomem0", "aspeed.iomem0", 0x12000000, 0x01000000, -1000 },=0A=
+    { "iomem1", "aspeed.iomem1", 0x14000000, 0x01000000, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)=0A=
 {=0A=
     Aspeed27x0SoCState *a =3D ASPEED27X0_SOC(s);=0A=
@@ -558,15 +562,6 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
         qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",=0A=
                              sc->silicon_rev);=0A=
     }=0A=
-=0A=
-    object_initialize_child(obj, "dpmcu", &s->dpmcu,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "iomem", &s->iomem,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "iomem0", &s->iomem0,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "iomem1", &s->iomem1,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1137,22 +1132,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
         }=0A=
     }=0A=
 =0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-                                  "aspeed.dpmcu",=0A=
-                                  sc->memmap[ASPEED_DEV_DPMCU],=0A=
-                                  AST2700_SOC_DPMCU_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
-                                  "aspeed.io",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM],=0A=
-                                  AST2700_SOC_IO_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem0),=
=0A=
-                                  "aspeed.iomem0",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM0],=0A=
-                                  AST2700_SOC_IOMEM_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem1),=
=0A=
-                                  "aspeed.iomem1",=0A=
-                                  sc->memmap[ASPEED_DEV_IOMEM1],=0A=
-                                  AST2700_SOC_IOMEM_SIZE);=0A=
+    /* Unimplemented devices */=0A=
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *d=
ata)=0A=
@@ -1183,6 +1164,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCla=
ss *oc, const void *data)=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
+    sc->unimp_devs   =3D aspeed_soc_ast2700_unimp_devs;=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *d=
ata)=0A=
@@ -1213,6 +1195,7 @@ static void aspeed_soc_ast2700a2_class_init(ObjectCla=
ss *oc, const void *data)=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
+    sc->unimp_devs   =3D aspeed_soc_ast2700_unimp_devs;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_soc_ast27x0_types[] =3D {=0A=
-- =0A=
2.53.0=0A=

