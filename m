Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD536CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZG6-0003mE-UG; Sun, 04 Oct 2026 23:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZG3-0003lH-Sr; Sun, 04 Oct 2026 23:20:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZG2-0000RH-Ha; Sun, 04 Oct 2026 23:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBYeOBeTnwN3i+9132o029hjSi4alhRgn2ZTfKyZbEqWxqocN+3XOc8kv9eRbpCXjyAINjBahvi2XRoqxLmdEgvQFFRNMk0qXl/FELwrV03LezFqBMaDWO/3zD0OGVilU2KchLJCRPq7/d5QmwUqHWuxaS5B+hyE/5jIoCadfzZkeo5paVi38d4fjuxNU3NIwH9Rsv1lnhEFKwM15a6PoIESXFXqZVP+pFzGOMXL10Y7P+qsfrf2kD1x6AEa8y4T/bxSGty04KHYdhmUQiZIvJL+64wN1mECNoWLa63rWS4LpXuy+RfcgBS4eAuuwTtzGeVVlK7qJKg5cACZBDaWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVoHOQyJEdYjfE3io8kly3UMWDN4ev2GhkJmFp3L56o=;
 b=XkKeNwohZPwqmBJerXScr3jtCrq0d/mVECFVPFcBZUhHwGDbvDiXFNgt1R+vGvurNUoyxHHIdxSVQOKhJlllyYyroVHWGcsGbkEXJfZC7p47SL7xwm2tNhI8wx3DFjbq4O9RU0sw9auIBsVm0UYwr237gfNhH+mVg+WUK5FNoMq9UHHdABo3aXvmBvnPumDZR5821cmFOOqIY/kUOJbEDjXItprMVTxnSiHGJh02K3FZQs3fj+orLtKqmCAxfilHRRXG0/QUlYHDQghOqzw2SNcEu86Ht3+1Lfgv1t+r4dDF+yvzDd9Cr4lMhbkrqFdN37BlZiawI98T45TzJIl9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVoHOQyJEdYjfE3io8kly3UMWDN4ev2GhkJmFp3L56o=;
 b=gkbTp4Q32BrqheeCYdUS3UqWCAkWk0/AL+aPSjaH9cXoKkZVGD3u9nxdGbAwLDN3ZcQlAHLpBeZYiUsjOKHEqZF0o8fYrSlejZadecJmZQIybxjYz9HctPHxE9aXvDqQ/004R6ApttexVx/kZ3u/iX/cMxLDQKebVa3SpkABaKLbzDnZTCpwmB2iYuMBd3M9zEuhdxFMKS4CT6EQqvLt/AGgPszVd2BGaqvAIlhwx5+sHzys3pJSI+pvrLdn+DOQr/txUBEXKimv28JHC75658lHNDeT2tPLfCBwaZwcANPzj872jY90KutgpeZ/uUa+n4ls3HJbf8HIMadNDTnBKQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:35 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 8/8] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v2 8/8] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdVHh8WLcGhRrOsku6+NgME83aVQ==
Date: Mon, 5 Oct 2026 03:20:34 +0000
Message-ID: <20261005032022.3980903-9-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYUPR06MB5945:EE_
x-ms-office365-filtering-correlation-id: 3432e1ea-6c43-4a98-cc52-08df228f9e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: fPkh3QQRQVwPBxAJvpz8zVZP1TNjhrg9IsrFk05smIdM41aYNMxWT0XSCtScdIW2CthMLfs+Rp4DiEf6c0o4ZQG4j/wid0LZULiIbMLyDcNiDEjzGViEM68OM9AvVQ0YCfCnFjdy5GbClMt1UVkujn9rJn4kUTdPNtIxiRIvU6ds28XOwul7d4ijlkKLe64fdONAIinukuAztCTRBFToni+0lP2spoHYiiqyu3umBIJB38+YEOw1sh+e2r3jXBSmwTZWOTKWofoA/G/nbhSEBra3W1XYLHJCfeQRtOmEbhDTbgkAnwlF1hUb9RcMKk8NxPOXDSPeiIZGpr+rCIVqHpVXMHmdsbK+jSKtAn5S5sqaLSxWF9u67EKbVaZx2DCfWH8heJP9aja9mKm+GE/SxE34MV0SusbTHVCv6VAr35ilMnM18i33CmfnBBDrjIxqkYUqxwy/Pxu96ABoojHWOXVGI6Ai+e4G7J7U7PTpRmxidHgr7/cTjZVtEZbMqg3n1gZrmkeGS95uxHVUyABnUpUOIURQdX8+vLH19reJrX51V2Mxn3HyfIdRmH1th3EBFam/ChkkCxDUGzwO1fXDM2elcgJ+5a9M1zWTbLG1IKglk1hpc5Ol4dYU69VTlCCui+bGxsX5ImmZMex7wiIL+LzTiTO0TNMZzaEnpLV7yifo6kqDMW4S39uGErNC2yP0kzA5KAWUSUk0wWelPPTcvo0LSzaVjZWnaDvYycLhLko=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EasNYZHKJW7e7GSb4uuRxJykyhtmZPdZtN8ViZd6Y+p8WStwbakIJ+4GLytO?=
 =?us-ascii?Q?FWls4hBvEUKJYN3Er7nO6N7Lad+4OmbNcUbxrpJ0aKUtXxxw1uASSZc6bLPj?=
 =?us-ascii?Q?d2G/yDWbhe07zCJb3FeMah2GLfLyIN18d4MedLqeop2OoPsoiJ3cZPMSWqsw?=
 =?us-ascii?Q?0ae/8BnGKy+rTIUbviv/B0YCNRAhcT492x2UlyZ90nwyKqiJ25g8NJCX2J5j?=
 =?us-ascii?Q?ul4GY5kWTpBTgQAv/3L1T5ydkv8hNf24yBgmFNM2WgD+82nIkRBdFg5FTEMR?=
 =?us-ascii?Q?bf0QD9KJmwJad+TaUmr6jA9DhnrSvLYL9l0A5+dH5PAqx0YU0mL+hSf3Low3?=
 =?us-ascii?Q?+8KKGmTvuAcpjaC5jQO3umiZ/QIk3kMTDu0gWcB5NJII/NMUnyY1A5c/JbdX?=
 =?us-ascii?Q?qC5F1aiBpkkNIKMh1UJdxn7yT1SimydgIm40v7vEmjT97U4FAxN39CaJ7UWz?=
 =?us-ascii?Q?2/lBREtDpRqLjWbAgH6y+0V0gf4E5ZQ3x6Sb6tJhzuQcsqDjDLD6bj2jVFBd?=
 =?us-ascii?Q?23E/8EqG1hzFrxtPoYjah+k9AD3WCZrmNTo2NI6lCt1p3q2Ed5JWUtb40IDP?=
 =?us-ascii?Q?5/7Zp6xo9abH52Mnwj0isYtnJ/eqqn6WWcvFXbKjkQ7QgCJI88l1AU6Vwi8d?=
 =?us-ascii?Q?QexDMqWCwRHQEuTdHqRI6kJVeEXKhkXOgGObMGIGg8YbyDEz67tJWDPh31fP?=
 =?us-ascii?Q?ig7dHj82pHsIqN3N+II0H9o1kUlduM7eWi693hybmeAFp6wh8PESMPEifTBu?=
 =?us-ascii?Q?S2gZvtX2m0tlpHiI4y0CYGAfytAXcIoMhYg9/GuHULN6bFsl75Y/RheLd/kN?=
 =?us-ascii?Q?rn1MnqAZ07v1ynyGoa7QTxkj7kwkQQvMpvpiTi+Peh/g3OUsBF6A8XfkZMHo?=
 =?us-ascii?Q?+WK0wsdDCB5ro114g2SmYVwDyVDHBSopNPgbSR7dzl2z+WKRlRPlENT14pqd?=
 =?us-ascii?Q?zQVyTP0UWUFWCa0EL3qzDroRfZIuxfIi8oZBNL4lPlfQ+AdrCK9vhrzicyP9?=
 =?us-ascii?Q?PoDz9bQ7K7zkO34+dsOnx3oZfuz4JiFafCFRnHJ1PwzQLNlk5o0yBqpfqDF1?=
 =?us-ascii?Q?XPYiB5iTsFPt9OUVW36Q7SUZxRA7Le2gp0wFAZssJbJvQmkxz4f1Rxd1SGYj?=
 =?us-ascii?Q?arnm84MVAnRajmpXGYhUIkU47HI4FX33+LLVqBfE4vYjNWtXdLWoL3ZhtEVE?=
 =?us-ascii?Q?+ja13qmwudyaT1ZLVp7HLCtnEMF4u7IaGHFRytYtnT29eDVpSheTf71KpSbI?=
 =?us-ascii?Q?LKHCDFu0qHOnLt+DEMmNODcO1aRqPtuJv8Om0rTyM0jMmt6yQiiDSXAmuxv/?=
 =?us-ascii?Q?34K8YQlQBHkkmLnUMLDlO1YAlv8RszbuZkC6pRwej1yykIL8/Jdmqnwz+d5N?=
 =?us-ascii?Q?jBBHJKUKcUmOgf8fR1HZSg9KIaOWl3/v7LfoLdrQnh7O1TZSLGlzJ43ahMKm?=
 =?us-ascii?Q?Q0rl/hi4fBzbHa/V4ZJLcH0BJG4Y19MFnBdUqh6WObU6KjyAi8seJ7RNjdEY?=
 =?us-ascii?Q?9q2SScSXXiJMHyqGIYSA5IxRjA1vhNsk1HmUpysbxH4R4T5sroguWPTTG8MU?=
 =?us-ascii?Q?XfdMvDRsnzssuRDYeWmdjfWJSm9naYKPh/5dEZC1Kc3+0WwQEE4hxw7KucVd?=
 =?us-ascii?Q?aqHpad5l+66OroymU3O+k7tQUZnXcZvU5srJll/WTomqzyy69qjQp+7cNNsb?=
 =?us-ascii?Q?s0SHaJXhr2cbmXSN6la93R7QCsrh3yUqDa+mwPRlzhw+MjGIE9yRRuIYE23f?=
 =?us-ascii?Q?OmezDrLgLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1s8kEj+SvkzA/IEX749U1kkP93vPNjmxaleQtYc3KwQNbMXoepFBrvw6neYpXBjl+EcRYnmTlyZGdiylOYv3TRf2CCurwGuGEvYtalGpCDXSVb5hbICu6zemwtcmB07DG/hEL57S4s6A+Tk0IyBL8HGtc1VYCTMDRXYxrRJ9irGKDyRrZ2TeTTDXaM68jIsRAjNJZERl6NmJ0B/7osrhThpr9Uc6NxdBwBJwNNEp5SmRoHzK+jwhU0EBl/jb4oaxnvWZpzrIcPS95GeyE+CzaYFaPrjLATh6utPjlUfPTX1ighg7ZaqUOj/r8iKsNVrTPMt/iLkNioOYuF7eywxKVw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3432e1ea-6c43-4a98-cc52-08df228f9e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:34.4979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZWFbgxAz5a7EXPr8fc0m8LNBFbfXK9BD2fvi//2IycyaMHZBkmmE2lVu+Cvpu+K3Z6jgGmwLkRWjk69rup6RYXcBCncl2GPjDs35ThqHqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5945
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

Let the ASPEED machines accept "usb-redir-server" with -device, so a UDC=0A=
gadget can be exported to a USB host running in another QEMU:=0A=
=0A=
  -device usb-redir-server,id=3Dredirsrv,chardev=3D<chr>=0A=
  -device aspeed.udc-gadget,bus=3Dredirsrv.0,udc=3D/machine/soc/udc=0A=
=0A=
usb-redir-server sits on the main system bus so that the USB bus it=0A=
provides can be found by "bus=3D<id>.0". That makes it a sysbus device, and=
=0A=
a sysbus device can only be created with -device if the machine lists it.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c=0A=
index a7cfbd6c5e..4e1ecbabe7 100644=0A=
--- a/hw/arm/aspeed.c=0A=
+++ b/hw/arm/aspeed.c=0A=
@@ -409,6 +409,12 @@ static void aspeed_machine_class_init(ObjectClass *oc,=
 const void *data)=0A=
     mc->no_cdrom =3D 1;=0A=
     mc->no_parallel =3D 1;=0A=
     mc->default_ram_id =3D "ram";=0A=
+    /*=0A=
+     * Lets a UDC gadget be exported to another QEMU instance over usbredi=
r.=0A=
+     * The type name is spelled out rather than used through its macro so=
=0A=
+     * that this still builds when the usbredir library is absent.=0A=
+     */=0A=
+    machine_class_allow_dynamic_sysbus_dev(mc, "usb-redir-server");=0A=
     amc->macs_mask =3D ASPEED_MAC0_ON;=0A=
     amc->uart_default =3D ASPEED_DEV_UART5;=0A=
 =0A=
-- =0A=
2.43.0=0A=

