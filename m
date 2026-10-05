Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975BCA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRG-0006aO-Ax; Mon, 05 Oct 2026 02:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR6-0006Vs-Qv; Mon, 05 Oct 2026 02:44:32 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR3-0008WN-Lj; Mon, 05 Oct 2026 02:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trPs2gx7l07wa7PPQr5Z/F4K6cgXLZcsHg3+4jAVsGrHrs4NdvYx+FlGgMK61yiabQhJcprEadD3Sx3Os0Ep99S0YPx7MA4NIa8giRVs9dmdclTGUOWTPZiql0ZLhedg2x0fpaRVq/S2LpaP1dHmG2jOL2IyeM9YOgSttuITYWL19br8xdZpe5UdovNvYi4nyrcWoq6uBSroTItYoS+IMIIpzW6PcgDbUuvdwU0kFKVfCrB8ckVicErDI/xCIbXxoXoYXe8RRJlyqEHMB5HHVaqSHPQIe/KfipB7238CaFwXRd+bpd5r/V907l50RpvXHBOgsSW9flixPvhOO5yzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GmVw3BnZ/g+FOkCVN7mqTgGIG90bGFir7b6//jRxwM=;
 b=vT0IKOdFOIg4HTt48ky/peKPDc09PduRcwKZKGk4iVibxYuaRTfSsxXGUllK0H4HMydPdfhHyRDsbV37rndJa9rS6MLZzpmQyGv4vs1Zh30yIQ7uwiIxQh4lvq88ZPf9hZS93Gorx4LQBCLQurxLbmd3nWYjMJ+iLKuT/3Y4mDrn9mTqn6p025UkrPcnEKkUR1SBi9Bp+k4LL1c5Ls7DyAcq1M26yEm6AUrQ3DI4OZz8/INtIBmSCWo1Gt8R0BgIlNTpVOlEXN8N1FD9a6w9gpOJ7y2nEXNjNkszK+N68GHAfsbY18L+JDNxQQHHSsnxS/4NtkCD5ptxqbw2BTPUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GmVw3BnZ/g+FOkCVN7mqTgGIG90bGFir7b6//jRxwM=;
 b=aXF0yz+EbMqx2nhT+o4QyG/lztAOGGtN55iwsCzEIpPA7nlFbs0/7yTBsuyfH2nNdrnPp+F1NU61948STaIzP4DjYECXt34nTAqY582B0EPm6g9iNGR88RS0xF+qQjuleA9+SE6mIae7Y2fd943Vc7mYYU4bicJPfjnDIrQ4Ls/NVnuzKPCsFi+jcR0lUVj4Kjiwl+FOYT1TIafC8WmNkjgpvvEZUhwaQ9uvEfUjLa9Rf9lsSu2lDhrBOJuQlsxtE5m2RP7jbgakfWIPVRs2J/ype1d/vlD3V4Z/7wUZ31lIenLgsmZiuO5yGI3tli7gqj3Uj9k7Fmu6BFaIy2bgYQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8774.apcprd06.prod.outlook.com (2603:1096:d10:8a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:19 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 00/11] hw/usb/aspeed-udc: Add AST1030 UDC support
Thread-Topic: [PATCH v2 00/11] hw/usb/aspeed-udc: Add AST1030 UDC support
Thread-Index: AQHdVJTyBF2n6dH/HkWnZKwdCqaQnQ==
Date: Mon, 5 Oct 2026 06:44:19 +0000
Message-ID: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8774:EE_
x-ms-office365-filtering-correlation-id: b58125a7-b9d1-4399-38d5-08df22ac1526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|3023799007|56012099006|260925022911599003|260925021911599003|260925021311599003|18002099003|38070700021;
x-microsoft-antispam-message-info: 21AjZ+JZgMJP43qmDnumyaiybHJgMTU/lp7I3y9zvf5N30+r/vLM6LB9aVNYUQQ5z30Bd+ChKkMQn1aH01olSXiS2jI70uGxeXQS8fKc+7QzJf8KCnVqT8ceeOvhmVtou48+SGU00IQpeg3wtYOuxBQRID774HZBz9jSk0NYBIOi4EwvOUAvJ6cTKZ5bAXtrv7gxULnCCBGcaxEFZg0EC6QJx/CVw1A58YY/FQS3olMmNldmV5lPaWeD6RwJPt0mMjgCA80t0bEhn/sKY1iGUHayO1seCeZEvr1ji9ZthcR1GlaNXkA+mXz2ZW4KIaCGkNYY6gtoxQf3TgBRAAPhADcQC0OM5mSjF6z/KlyBg11O6nr0JzbPwUwqJyd9X7wAwsFvM2z7lg2TRxieKbKGPSouMQF75TN1Wwz/ujSu5GrXnSSMRe46NJXeqiOq9ItOrYFVrjp7+zBEqwF9gbc3wPT6qa4vqX3EbjDFDPKBU/kb/IdOIviuzvziPqnQyfOhbpDTk7BTXPpOq1byvrlRitSvxnicXZXx/YH+yAPiLRCr/1j1ezzG8gRObHOA/Gk0WWxiNPcHNLd4BBFIGu3+4QvUmSmiCAykfyNrC5JVHFYTiNBz9FGsd/U1xZo2yUjUavcm6j6kij/R2EXEY+YX2Q9PdZKNVFYnw8ENt0R8sa0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(3023799007)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dCZbodAlIdWd04DpP/lObQG9hGmlN3yGRceUN5YX3VL/hxSkPcdmELi6+S?=
 =?iso-8859-1?Q?lCO7CNjv0djESvt8BYkRhcBTKQg0bMhJ6ptirvaDmT86M7sYPuHn66ZmNv?=
 =?iso-8859-1?Q?YH/LIRacZfU99M27GCt0G1JTS1tHxkJEbo2Nx0OQQ6hgnYKUwd+mjozY5m?=
 =?iso-8859-1?Q?I6/qIsYJOVirWIlHoDG9XO4Pmx+5L29y54raDqhX8KJ+NwJIwV+Jj/7OGA?=
 =?iso-8859-1?Q?2vTHr0T20yxeLdRuVcbziCBJ/ksv8FsFgnUBoN6kiEgGHcwsqp9+2KbBlp?=
 =?iso-8859-1?Q?Wg9aQKuxQ3bQDmAYO61bTJOzEVbidUlww/cO8pMRZJE+vYu5d6sP/X8NmZ?=
 =?iso-8859-1?Q?A2pUcNMFDLVTjiZNPe+gKe10O5gk+HcySLar9/0wdnuyTTsXqhZBopEJ6d?=
 =?iso-8859-1?Q?+8We5CfmMvsb234y7xtu6X+8sxfWrqITYDH7NF9Wz6cD0J0+0x9cVQXjZn?=
 =?iso-8859-1?Q?zO9zsvLDdxnhkDx/xGHhw0dAwFq9cEZy6mlA3ZlYx4v1/bzbtJ4HkiVFOf?=
 =?iso-8859-1?Q?NDRvSxMtLwIgH7vdad5Y92LtuMfQsN2bou6aZSszzl1wV2oq/nzMsvE7yj?=
 =?iso-8859-1?Q?ygoSJqNs7arY4MfJYM/ftpPVkHAS+fORlxvCpQ5XAxD4SGEKaEv618Cz2H?=
 =?iso-8859-1?Q?UMPEzSrpr8rD95XKBimlSM0UVsz8mNqaEMbNQ6eNGhC4t6kVGuf+0ZkBWA?=
 =?iso-8859-1?Q?eusC5xAOBVwofK0eff8m5seAuHgmVIF6U+12sd2Cj8rW8QzyA0GvE+Lkia?=
 =?iso-8859-1?Q?ZSolILumylKfsYUbkeAyx0A7FIKn9xsFaCe8agVUzk+S65uLlif3SdKwXD?=
 =?iso-8859-1?Q?o1bIxecT8RAwF+YFGzUW93ObIvyrkCHTpK6zz6W7W9n11hyIst87AfMoPM?=
 =?iso-8859-1?Q?Gn4VT3ZvLeZOBeLFDtTEjE2D1nEqxOTwkx7lS1l6JDE2ysDNN5mLdYLXP4?=
 =?iso-8859-1?Q?SsMgV2Ig23mLXcH7Z2OdOzDq1lCVksvGtMQ61JbJmdMJngDdxbQvhIv3JX?=
 =?iso-8859-1?Q?2vt+Y9YOI4//I4dvTjQ70dFUe69kvq0JZ6Gg+I6dOiXTCyJlJ80AWd7bQX?=
 =?iso-8859-1?Q?DseFgKGJrV/ouqzRknnn3CENJxJZvQppjMJzkOM43172zR1eJtKIZaKSy0?=
 =?iso-8859-1?Q?wlaenvTOnHaXBfCce8b+M2NWpV0vsLl3eKcdvkmK01a/ku/zRlSXmo6h9c?=
 =?iso-8859-1?Q?bUtV77uzZH1xEmeWOfPtwXpcSlezMOpUw4GxOg+IoFyN1+aeuQ57rRt9M2?=
 =?iso-8859-1?Q?k/Ns8TEaO5Ilzg+bJzPzdIKqVN26IF30aixb+OuXDsIwIMGCtPE9BWeJb5?=
 =?iso-8859-1?Q?gj/r+NcLanMbIjlApnTbcsFJWnCXsK39jI1qPPVWs0zoqn/erd4lera24L?=
 =?iso-8859-1?Q?ZIoQxpW1lUeUKMxgUHr/IZxmFBaNKc0IwK7wqwl9Lo1/FRqDK+Pt/Gi2Nl?=
 =?iso-8859-1?Q?iZ1mBKrM4vx4AVz55h1c8rAvYcpabq2uA3K5GJmfeKh9LOc8YD8hcGF/Jv?=
 =?iso-8859-1?Q?QVCarkQDVdip6LDavtdfINE+e4FkhtDTeBaJ9Y64JB1RJCmQmClLhNxNJ1?=
 =?iso-8859-1?Q?eiRvejmLd+wpJsJt8s+Inw7M3t6Dsq5XWwkMNDjFmHkahUFtRoQ9KPf/bL?=
 =?iso-8859-1?Q?GMAnkDR5cqc7UgDVfCbHGeGW8LiN38uA3xC7ht5zKimLbR33RemfmxPeKk?=
 =?iso-8859-1?Q?KFREds5zQitVH9WVKox+tPWEF3w8i6TqnYJTqY7HmAeYsUjeiKbmOytbEU?=
 =?iso-8859-1?Q?KIajW8Dp1fJMr4unYzDXDmOi0O2C4rVrMmWtQDf7p9qvwZQyVfBBrvCBAk?=
 =?iso-8859-1?Q?RY7L0w06yw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s3z1rtkPdlPl88gLLKIxhhkyxSJ5AJAq74gZASBKiRFQh6MHz8zm1Ij7nmpYuyRPe1nLeYToasQo7MCrGDXISuTQ0zH1ymbhFRVFlIBqhdEnwcjV8kWEgF925K+a5rqaX3AYEz0sXPGxy1tWWauTUBcMM9BvEoBrz0ZKGHZlW+kWU8WlxPC/ADoQdVb2q0jIha1N47vs675JbsCPcx27FZ379I2x5YxFg45H51N8feCZ8H2N4awyo1mZmvkDzWHuw1HExfBYLSEtiDB6+YkKobT756gioFfbLTMgEo5iIOxk7f7cqy+hetTwJJC47duYIQvzA/lL2a0Dfj64FGTpBQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58125a7-b9d1-4399-38d5-08df22ac1526
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:19.4399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wozuxbn0OYxOEBkrAVVl05UKYWfoG+QnKZVLkhm5IngUPAhfrvaDwBKj17xMgFj7HBrVrD1a1L6B/nAWJjdubj6vPjABP8UiXcoKuKvo8XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8774
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series adds USB Device Controller (UDC) support for the ASPEED=0A=
AST1030 and extends the existing ASPEED UDC model with the transfer=0A=
handling required by the AST1030.=0A=
=0A=
The v1 series included both the usbredir server transport and the ASPEED=0A=
AST1030 UDC support. Following review feedback, the two parts have been=0A=
split into separate series. The usbredir server transport is now sent=0A=
separately, while this series contains the ASPEED AST1030 UDC changes.=0A=
=0A=
Dependency=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The AST1030 UDC implementation itself does not depend on the usbredir=0A=
server transport series. However, the functional test in this series=0A=
does depend on it, because the AST1030 has no USB host controller and=0A=
requires usb-redir-server to export the emulated USB gadget to a USB=0A=
host controller in another QEMU instance.=0A=
=0A=
The functional test therefore depends on:=0A=
=0A=
[PATCH v2 0/8] hw/usb: Add a usbredir server transport=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20261005032022.398090=
3-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Background=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
This work is part of a larger plan to model USB device-side support on=0A=
ASPEED BMC/BIC SoCs, which has three goals:=0A=
=0A=
1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host=
=0A=
   (EHCI) controllers, so that work targets the AST2600 UDC: its gadget can=
=0A=
   be attached to the SoC's own EHCI bus, letting the guest enumerate its=
=0A=
   own gadget and exercise the UDC end-to-end.  [Done]=0A=
   https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@as=
peedtech.com/=0A=
=0A=
2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC=
=0A=
   needs a second QEMU instance. The UDC gadget is redirected out of the=0A=
   guest with libusbredir and attached to another QEMU that runs a USB host=
=0A=
   (a VMM, or an AST2600 / AST2700 guest).  [this series]=0A=
=0A=
3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media=0A=
   support in QEMU.  [future]=0A=
=0A=
This series implements goal 2.=0A=
=0A=
AST1030 gadget to an AST2700 host=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
        QEMU #1  -M ast1030-evb              QEMU #2  -M ast2700a2-evb=0A=
  +-----------------------------+      +-----------------------------+=0A=
  | Zephyr   usb_dc_aspeed      |      | Linux    ehci-platform      |=0A=
  +--------------+--------------+      +--------------+--------------+=0A=
                 | MMIO                               | MMIO=0A=
  +--------------v--------------+      +--------------v--------------+=0A=
  | aspeed.udc                  |      | EHCI3        (usb-bus.3)    |=0A=
  +--------------+--------------+      +--------------+--------------+=0A=
                 | USBPacket                          | USBPacket=0A=
  +--------------v--------------+      +--------------v--------------+=0A=
  | aspeed.udc-gadget           |      | usb-redir                   |=0A=
  +--------------+--------------+      +--------------+--------------+=0A=
                 | USBPacket                          |=0A=
  +--------------v--------------+                     |=0A=
  | usb-redir-server            |                     |=0A=
  +--------------+--------------+                     |=0A=
                 |                                    |=0A=
                 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D unix socket =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=0A=
                           usbredir protocol=0A=
=0A=
Testing=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The AST1030 UDC was tested with a Zephyr CDC-ACM gadget. The AST1030=0A=
side exports the gadget through usb-redir-server:=0A=
=0A=
$ qemu-system-arm -M ast1030-evb -nographic=0A=
-kernel zephyr.bin=0A=
-chardev socket,id=3Du,path=3D/tmp/usbredir.sock,server=3Don,wait=3Doff=0A=
-device usb-redir-server,id=3Dudcredir,chardev=3Du=0A=
-device aspeed.udc-gadget,bus=3Dudcredir.0,udc=3D/machine/soc/udc=0A=
=0A=
uart:~$ usb enable=0A=
uart:~$ usb print 1=0A=
=0A=
The gadget is attached to EHCI3 of an AST2700 guest through the=0A=
usb-redir client:=0A=
=0A=
$ qemu-system-aarch64 -M ast2700a2-evb -nographic=0A=
-drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -snapshot=0A=
-net nic -net user=0A=
-chardev socket,id=3Dr,path=3D/tmp/usbredir.sock=0A=
-device usb-redir,chardev=3Dr,bus=3Dusb-bus.3=0A=
=0A=
The AST2700 guest enumerates the AST1030 gadget:=0A=
=0A=
root@ast2700-default:~# lsusb=0A=
Bus 001 Device 001: ID 1d6b:0002 Linux 6.18.36 ehci_hcd EHCI Host Controlle=
r=0A=
Bus 001 Device 002: ID 2245:1030 ZEPHYR Zephyr DFU sample=0A=
=0A=
Data transfer was also checked:=0A=
=0A=
2700 -> 1030 =0A=
echo '1234567890' > /dev/ttyACM0=0A=
1030 console: Print Data: 0x31 0x32 ... 0x30=0A=
=0A=
A functional test is added to exercise the AST1030 UDC through this=0A=
usbredir setup.=0A=
=0A=
v1:=0A=
  1. Make the SETUP buffer byte addressable=0A=
  2. Support single-stage IN transfers=0A=
  3. Clear EP_POOL_ACK when no endpoint ack is left=0A=
  4. Mask the reserved bits on register writes=0A=
  5. Use the endpoint max packet size for OUT transfers=0A=
  6. Test the usbredir server transport=0A=
  7. Add the USB device controller for AST1030=0A=
  =0A=
v2:=0A=
  1. Split the usbredir server transport into a separate series as=0A=
     suggested during review.=0A=
  2. Keep this series focused on the ASPEED UDC changes and AST1030=0A=
     UDC support.=0A=
  3. Add the AST1030 functional test using the usbredir server transport.=
=0A=
=0A=
Jamin Lin (11):=0A=
  hw/usb/aspeed-udc: Make the SETUP buffer byte addressable=0A=
  hw/usb/aspeed-udc: Mask the reserved bits on register writes=0A=
  hw/usb/aspeed-udc: Clear EP_POOL_ACK when no endpoint ack is left=0A=
  hw/usb/aspeed-udc: Rename the transfer helpers after their DMA mode=0A=
  hw/usb/aspeed-udc: Store the EP_DMA_STS write first=0A=
  hw/usb/aspeed-udc: Pick the EP_DMA_STS path by direction=0A=
  hw/usb/aspeed-udc: Support single-stage IN transfers=0A=
  hw/usb/aspeed-udc: Use the endpoint max packet size for OUT transfers=0A=
  hw/usb/aspeed-udc: Add trace events for the transfer paths=0A=
  hw/arm/aspeed_ast10x0: Add the USB device controller=0A=
  tests/functional/arm/test_aspeed_ast1030: Test the usbredir server=0A=
    transport=0A=
=0A=
 include/hw/arm/aspeed_soc.h                 |   1 +=0A=
 include/hw/usb/aspeed-udc.h                 |  13 +-=0A=
 hw/arm/aspeed_ast10x0.c                     |  17 +-=0A=
 hw/usb/aspeed-udc.c                         | 290 ++++++++++++++++----=0A=
 hw/usb/trace-events                         |   9 +=0A=
 tests/functional/arm/meson.build            |   1 +=0A=
 tests/functional/arm/test_aspeed_ast1030.py |  52 ++++=0A=
 7 files changed, 330 insertions(+), 53 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

