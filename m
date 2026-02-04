Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B613E83EF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8n-0002OZ-HI; Wed, 04 Feb 2026 03:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8l-0002O4-CN; Wed, 04 Feb 2026 03:21:35 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8j-0003UH-Jw; Wed, 04 Feb 2026 03:21:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiUG0b8sVT3fwP6VlA0RkmEtwEk4yHKyRNg+/ZTvH2vpOIEOLRlxbOAvn10+4F3qx0spYBwftf+TbV+eBeNuDLJ1v5qEyggtwISBfQjB82gNwaVLj+zjjlJPcch300h6DAnTwQafOPCzR1e0wBqBt5rNqmFKydgipeGk7n7Ckcn1jLsdaZQhWZHbRg69qpQ6jQfYBI9DW4CTM91zME5VmYE2UAZckDFzsd7BZMlr1q4OACO9lneEwj6c0m5kVfFwyyvAjP6waR0gDd0OREfDsHynZR5XNEsDl9Kn3BWi53iFvxa6hmmKjQhtVJVR6f1IvhtiAGwu7+oKHT581RgQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xanY8lWWj1o9pHV4DaF+bwhx77T/jfPF1cnYyg/dbTU=;
 b=U2fNuGQXYVcmUpY2vTYhOkLqjqsmLDAW4QmaVIGyD5FTUq8G0BjWJ7N5s6JIMGYC+4FzsmPtllV/L2ssdQ1bvAuURTlWT8+i3moU6JD0V0CrVAPhFCvLOuO+aKYxmSsHK8g1CTVWL7E6l/QVwo/5gl3UDd2yypzvM1ioKBueb9lJWyqynWV0envDMUNg8pkGqVt1wBS0AurXfokZZ0+3ER6z3bFLCFkJYORuX6pJX4lvuaJqb46I5ppfbPqipBWbOL2GmHjOuyXzE/bQrtNWUwMPGyb09uuhQK4Vz7FgcrWbyKnnI65waXbXgUaXuHY0xeOZKwDLTrDwUw05p0hTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xanY8lWWj1o9pHV4DaF+bwhx77T/jfPF1cnYyg/dbTU=;
 b=aTmgkVx2bK2DMnzeOzuPyJClUnFnipbsnTTZ06LeS4L2sGou3UGCM8Mu86GluOnPNqBpyt8RDh56Hvpx/JnCOyQwmy9yP8/kwvfs1dSjdMBtAprgK1KSGVnmNmrwfNai/8Wzaks8EmKpg/O1Z64vk0Aa6j5TkMHmqEsba9JY1YTZVqlxUkoNLapzNy6P7tIWhcNlhl7dHs0IkyyH19VRNsv4B5+yC/tbceGWvZJ676LoQkm5GD5/RjRYThtFOMBFdaElk6k8ho8AHTWmSV+dEmLZudC0NzEpCvaRPjrANKZ6lx3EYT0w0UtCjrFhpNy7WQYAVfyKlivV2vaMXVFhkQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:22 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:22 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 06/22] hw/arm/aspeed: Integrate interrupt controller for
 AST1700
Thread-Topic: [PATCH v7 06/22] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
Thread-Index: AQHcla8/itGmu5FPUUeTNpv6WhfoGg==
Date: Wed, 4 Feb 2026 08:21:22 +0000
Message-ID: <20260204082113.3955407-7-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: fa7478cd-fa22-4c4c-0f19-08de63c661ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OT7Op5Wx7MODfuUyP6WAU54P4LqdNWIRH+gPLxa61qgqEoStfKkhkWeKzf?=
 =?iso-8859-1?Q?zCR545sPchmKHDdqCFbM+VFKrq7BFJNw4SBkbwWqyn8js8jrJTXhYqeJZz?=
 =?iso-8859-1?Q?iArHOaF3+DjNMCLyf42ULXz4cgOXQJPBY+h9UVQ/hVjA67YCE4oNb2fBKV?=
 =?iso-8859-1?Q?zxHEvFRPnpYgT7hxAWWDRLUGT5TW2VKlESNBax3n+eE2XQyLk2xplAkwKl?=
 =?iso-8859-1?Q?O7ld2iwutCqOqW3ywozHNMibbIDBH1bdb4Ne4xiOG25LJY9TWzwZ1JQAd/?=
 =?iso-8859-1?Q?pFcDTipcx8MLhxAMXXj+3p24cmbKTdiWxK9uj33x97hSBJt4zs/3x/wpQ0?=
 =?iso-8859-1?Q?H1SP+CImHpZye9/LQFcGCf0wrAgb/9WwzIF3C+3H4O8cD3oRQf3AxTXQU7?=
 =?iso-8859-1?Q?GMrCbzXypuDBIi5PpMyNbfKQ3JWI9WR+mugi4l2folpKlinb6zARhYf/Eo?=
 =?iso-8859-1?Q?o/US8GC6/BOI4JoTHKHhQ1sIGOgicbb2KpH3joMJK2smv4M/Mj16YJY5F2?=
 =?iso-8859-1?Q?vf1KCozW/eqaSHewbR4NhK1dgIgJP2Eof5Yv8rKQkTYD1IBI2/TpOkOFBN?=
 =?iso-8859-1?Q?n5ZzO6hMHyE+q/RUN3N1ar4TeFgN/oorIdz4N9WZPgvlotL0yc9eRZer5n?=
 =?iso-8859-1?Q?8fGAQhW6gRDAs2Fma3p6j7E/Db9nqyW37OE0oDWOfhx1IOSTD8iPJOzwcQ?=
 =?iso-8859-1?Q?ZIBtnrieTHJvuG3/aOxLljQA4skSRNe+k+3oEE4TRZLLYKr49JkEBILDNm?=
 =?iso-8859-1?Q?WOxeR0302cK+qJx1jPwHSnQvx5TOxVzpHpy9gZuFqzI2Ivw9IImG2QIdGF?=
 =?iso-8859-1?Q?VwroG6w+FsFpsH/w+ZGwETe9GofID+wNPpZowxkuqZHwT/fWkGVv8TLPil?=
 =?iso-8859-1?Q?CoB1qWTYA8VKNtKnzVXBXmNB86txCXwLgOCndPiBASaiuHO4E29EEPvNfm?=
 =?iso-8859-1?Q?vtbzlTi/D+4qF4yW8cnyW/0nmZMgemHVCGB5oL1cZfjyfpK/cySwj/1iWa?=
 =?iso-8859-1?Q?RviCuvxfCvcP1kecbDPUX93xqv8ZC4ss07wfSIPXnZCgEBAF2rX0dNBIdc?=
 =?iso-8859-1?Q?Ge51oN+7jVLdXjGdfGZsos3YNp4jDGOF98ZuV3b/2WTOakT3IuCn/dO8Yg?=
 =?iso-8859-1?Q?KIlFw0dGZva2o472i0l0/m67+KWhkgvrmoBdehiSwXT5k89ZyYCjv7o726?=
 =?iso-8859-1?Q?J1KOkKBRkDDzlYR1ktjp8FQihS1Ers9razddnG/ONRAcofPrk44THvjUt7?=
 =?iso-8859-1?Q?2J6TcwLtr3G1IaQN+gnIToVrBp5KbtGYyYiMWEtzxiHM5K0XXuhq2OPbol?=
 =?iso-8859-1?Q?8y20PFL2HTciuG8hy+syeiA3ebrCgPcC/QYBRKJi9sjgp0uFAV4H7hOxvz?=
 =?iso-8859-1?Q?WlCGGBwp6tIm2IoZOAIYXZDvx4Tq/3Y4F5CyKjEaH4XOWp5mBPrEgUHPqm?=
 =?iso-8859-1?Q?O5aNjiVPLsohKtBwdr2b1dG+r6rh9M4iQTbV4ZehHblVJtJUiJvB2AwiVy?=
 =?iso-8859-1?Q?DbB83tXA9hfkNbUkSZDTyv2XUXjqiSDJ6821wVlWtSjOBwV9cNeIoaZgAP?=
 =?iso-8859-1?Q?Jd/imnt2o75SwI/XpTf6OiGca3pEwJs39whl0Gx+7gqHmAZ6ThLuE69G0D?=
 =?iso-8859-1?Q?NTwjEQS6SPodjEXxT//gIYfQic7F/kigiNOdExuh7q368BtSu5F0gsTXj4?=
 =?iso-8859-1?Q?gidDguWBv9lnCl0rD2k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sIo+T6m1qO7P6PhkEQmAc4FKVJC50oetoZdddriGW0s5NtU5WGA0Z2Dza4?=
 =?iso-8859-1?Q?WUG4nUDAOmA5Aq72KuKNEZkKpvQ1yFeOcMdG/B8DohpkMZaQkabZgA9D8T?=
 =?iso-8859-1?Q?8d49+Rufl2MkW2/v3JySl6+CPTRXRiDSBwsGOJdHoNYou6e5K4hHXNcWaW?=
 =?iso-8859-1?Q?aiWp8bTDWBxc9w1sQIIVyzdMZ1uaUY4OTqbk2K27F4NLYTH738d/6jUkm3?=
 =?iso-8859-1?Q?4hfVXmEOmGC/uY6uexGPabWYCjY0/jMJKu43drhVdKCT2ZNx9v3pc5+jtb?=
 =?iso-8859-1?Q?weeX1ByqqMn8DnIaxNiXMuji0qYG8ZDH0G6S95/jeaOj2y+iGfIoRGsDBX?=
 =?iso-8859-1?Q?x1kZ4LVBYrRmckch2AK3bjC8giq/58Y5xWctnR5tIXsk3Bzz9u1Ew6VFB7?=
 =?iso-8859-1?Q?2/7fofsOh8WhveLkynqDrYzfEu4MopIbA18pEqAYKKil0b0VIyN/xfuXLp?=
 =?iso-8859-1?Q?AOVL6e6XtJ2ltT1/H+5xVAZQ53JI5mH4CE0nvuBqHhuSsMtuCt8+bzKtpe?=
 =?iso-8859-1?Q?HmUrTeJeU3SSWH1Bt+jsIaE8nlTd1vwqqsa8GatSsyO6fmdpiOyF1yLL2u?=
 =?iso-8859-1?Q?dpAikh+fz/X4je1zCnKs/6GIYVnn1hDo2YhGDBo2fbMwuSfmh/czbmxkkV?=
 =?iso-8859-1?Q?Wl/L7y+k/V1QwwGlaT1P47xgLby/cYjJtODvreIcxbFGVFOllhLGjCgFtO?=
 =?iso-8859-1?Q?NHf9pOZu91h3IEdZvObrlf+mZ9zUEHDgdyXxv0/JTsrzoEYbGncoqxkiL9?=
 =?iso-8859-1?Q?QwZxCROjJ/W3WM4+KcBCOYgWpOfD1+UlFTESur+8RvK0FPE+f2jxXXRjld?=
 =?iso-8859-1?Q?1rsKcLyMSezu3NWOqK0KW3CmWLvb0e3mvDFMDyaut14OI9mx8M87tXQscM?=
 =?iso-8859-1?Q?KsCpxwOoKxPdH6N6mg8X/lmjR9eVw9aOWCox3GDE6vYSFnlgaOazVrZMpY?=
 =?iso-8859-1?Q?wrLU/OVuTLzCyxoHFmN9xRUwP4SxGUtbgW0uDoZjsE4z8vhcc04tlSmXGQ?=
 =?iso-8859-1?Q?LY88sCVsZ9xEBXLO7ylIme/KM+WAA6NYzJAXrBXMbKsJlC2kFzYjJBunvu?=
 =?iso-8859-1?Q?6TACrBPd2i88q3c7yF3Tu5sgkv5kEHjTUNBGMZnTRD9WnhD9fSepUUOYoF?=
 =?iso-8859-1?Q?ltFnU/Tsl9x8QsX1SNNYuspCNIKxocN6gzQ5eTvTTfi3fH7hq47G2QGaLv?=
 =?iso-8859-1?Q?oQRXtu+tKgFhVzp4DAJvvcHmOspYXBBhTiQxeHylucK74Tlc2l5BaquAEQ?=
 =?iso-8859-1?Q?dCenGjW/UViJVnXReM9VF6Mmm3s04UpElAEE4nTTAbw8OICR6XmkjqJlzk?=
 =?iso-8859-1?Q?XCM4vuZoxdLee05Od9zZe+osKDjfniKbwvXiB8Txqzt5G5up4Yeq3kb/LD?=
 =?iso-8859-1?Q?HNMvgg12tm1OIt2mD5v82hiaRDNPXM0YPpJzgLIiZdcJsDw9vdTDA6ypIe?=
 =?iso-8859-1?Q?PupR8XNXEnk2e5QSw6ovMNz7c33FvrMnA7sjLuWg9YkyxnIL19xaGDMAUv?=
 =?iso-8859-1?Q?V2tdmN96WTHdk4jt+sTOJVkZioZOrt0QnkHoKdsEHGm1kg6H+vlxtnmzvg?=
 =?iso-8859-1?Q?s70FmP/zAocDJeNZmuvGek4wYECDMCQMsf5dx42KY2vhLjAnyuIn1NiSSL?=
 =?iso-8859-1?Q?yu8afbwJF5gPJv5be+Rk+WqQVs/YI5wlxKboM9kuN6ZNGaBxcCykmt0NvF?=
 =?iso-8859-1?Q?50hJj+WxS3G9v6EeE9gqrmYer72g9vlTrjbifYuXrOsguq4UDqAdRJB6nb?=
 =?iso-8859-1?Q?s5yzkRkjcHjvR0tRXEP13874aNMciAxrhrFLyHzDqj+QC2Cpkjdegx04N8?=
 =?iso-8859-1?Q?1fc86+95Xw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7478cd-fa22-4c4c-0f19-08de63c661ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:22.5969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2c4MinHUymTmftUIX2l0pae4cID9VdQGjCJ39IgtL8LpYuWc2KzkrFIwZ7xV8hLfDaQDNDFj7upRB6vX7aT+jrgyeOgzG2X8mCTeOP3GA90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling=0A=
the propagation of AST1700-originated interrupts to the host SoC.=0A=
=0A=
This patch does not implement interrupt sources in AST1700 itself,=0A=
only the wiring into AST27X0.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h   |  6 +++-=0A=
 include/hw/intc/aspeed_intc.h |  2 ++=0A=
 hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++=0A=
 hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++=0A=
 4 files changed, 104 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index f19bab3457..b051d0eb3a 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -58,6 +58,7 @@=0A=
 #define ASPEED_UARTS_NUM 13=0A=
 #define ASPEED_JTAG_NUM  2=0A=
 #define ASPEED_PCIE_NUM  3=0A=
+#define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
 =0A=
 struct AspeedSoCState {=0A=
@@ -146,7 +147,8 @@ struct Aspeed27x0SoCState {=0A=
     AspeedSoCState parent;=0A=
 =0A=
     ARMCPU cpu[ASPEED_CPUS_NUM];=0A=
-    AspeedINTCState intc[2];=0A=
+    AspeedINTCState intc[ASPEED_INTC_NUM];=0A=
+    AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];=0A=
     GICv3State gic;=0A=
     MemoryRegion dram_empty;=0A=
 };=0A=
@@ -288,6 +290,8 @@ enum {=0A=
     ASPEED_DEV_LTPI_CTRL2,=0A=
     ASPEED_DEV_LTPI_IO0,=0A=
     ASPEED_DEV_LTPI_IO1,=0A=
+    ASPEED_DEV_IOEXP0_INTCIO,=0A=
+    ASPEED_DEV_IOEXP1_INTCIO,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h=
=0A=
index 5d10268fff..b25ef4a464 100644=0A=
--- a/include/hw/intc/aspeed_intc.h=0A=
+++ b/include/hw/intc/aspeed_intc.h=0A=
@@ -15,6 +15,8 @@=0A=
 #define TYPE_ASPEED_INTC "aspeed.intc"=0A=
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"=0A=
 #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"=0A=
+#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "-ast2700-ioexp1"=0A=
+#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "-ast2700-ioexp2"=0A=
 #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"=0A=
 #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"=0A=
 #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index a05112e2b0..d9866c2c3b 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -91,7 +91,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,=0A=
     [ASPEED_DEV_WDT]       =3D  0x14C37000,=0A=
     [ASPEED_DEV_LTPI_IO0]  =3D  0x30000000,=0A=
+    [ASPEED_DEV_IOEXP0_INTCIO] =3D 0x30C18000,=0A=
     [ASPEED_DEV_LTPI_IO1]  =3D  0x50000000,=0A=
+    [ASPEED_DEV_IOEXP1_INTCIO] =3D 0x50C18000,=0A=
     [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,=0A=
     [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,=0A=
     [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,=0A=
@@ -446,6 +448,10 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
     object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INT=
C);=0A=
     object_initialize_child(obj, "intcio", &a->intc[1],=0A=
                             TYPE_ASPEED_2700_INTCIO);=0A=
+    object_initialize_child(obj, "intc-ioexp0", &a->intcioexp[0],=0A=
+                            TYPE_ASPEED_2700_INTCIOEXP1);=0A=
+    object_initialize_child(obj, "intc-ioexp1", &a->intcioexp[1],=0A=
+                            TYPE_ASPEED_2700_INTCIOEXP2);=0A=
 =0A=
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);=0A=
     object_initialize_child(obj, "adc", &s->adc, typename);=0A=
@@ -690,6 +696,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *de=
v, Error **errp)=0A=
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,=0A=
                     sc->memmap[ASPEED_DEV_INTCIO]);=0A=
 =0A=
+    /* INTCIOEXP0 */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[0]), errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[0]), 0,=0A=
+                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);=0A=
+=0A=
+    /* INTCIOEXP1 */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[1]), errp)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[1]), 0,=0A=
+                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);=0A=
+=0A=
     /* irq sources -> orgates -> INTC */=0A=
     for (i =3D 0; i < ic->num_inpins; i++) {=0A=
         qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,=0A=
@@ -1006,6 +1028,21 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
         }=0A=
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);=0A=
+=0A=
+        icio =3D ASPEED_INTC_GET_CLASS(&a->intcioexp[i]);=0A=
+        /* INTC_IOEXP internal: orgate[i] -> input[i] */=0A=
+        for (int j =3D 0; j < icio->num_inpins; j++) {=0A=
+            irq =3D qdev_get_gpio_in(DEVICE(&a->intcioexp[i]), j);=0A=
+            qdev_connect_gpio_out(DEVICE(&a->intcioexp[i].orgates[j]), 0,=
=0A=
+                                  irq);=0A=
+        }=0A=
+=0A=
+        /* INTC_IOEXP output[i] -> INTC0.orgate[0].input[i] */=0A=
+        for (int j =3D 0; j < icio->num_outpins; j++) {=0A=
+            irq =3D qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j);=
=0A=
+            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,=0A=
+                               irq);=0A=
+        }=0A=
     }=0A=
 =0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c=0A=
index 77fae39205..52f2f946d5 100644=0A=
--- a/hw/intc/aspeed_intc.c=0A=
+++ b/hw/intc/aspeed_intc.c=0A=
@@ -793,6 +793,64 @@ static const TypeInfo aspeed_2700_intc_info =3D {=0A=
     .class_init =3D aspeed_2700_intc_class_init,=0A=
 };=0A=
 =0A=
+static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
+    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
+    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
+};=0A=
+=0A=
+static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,=0A=
+                                              const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 2700 IOEXP2 INTC Controller";=0A=
+    aic->num_lines =3D 32;=0A=
+    aic->num_inpins =3D 2;=0A=
+    aic->num_outpins =3D 10;=0A=
+    aic->mem_size =3D 0x400;=0A=
+    aic->nr_regs =3D 0x58 >> 2;=0A=
+    aic->reg_offset =3D 0x100;=0A=
+    aic->reg_ops =3D &aspeed_intcio_ops;=0A=
+    aic->irq_table =3D aspeed_2700_intcioexp2_irqs;=0A=
+    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_2700_intcioexp2_info =3D {=0A=
+    .name =3D TYPE_ASPEED_2700_INTCIOEXP2,=0A=
+    .parent =3D TYPE_ASPEED_INTC,=0A=
+    .class_init =3D aspeed_2700_intcioexp2_class_init,=0A=
+};=0A=
+=0A=
+static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {=0A=
+    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
+    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
+};=0A=
+=0A=
+static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,=0A=
+                                              const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 2700 IOEXP1 INTC Controller";=0A=
+    aic->num_lines =3D 32;=0A=
+    aic->num_inpins =3D 2;=0A=
+    aic->num_outpins =3D 10;=0A=
+    aic->mem_size =3D 0x400;=0A=
+    aic->nr_regs =3D 0x58 >> 2;=0A=
+    aic->reg_offset =3D 0x100;=0A=
+    aic->reg_ops =3D &aspeed_intcio_ops;=0A=
+    aic->irq_table =3D aspeed_2700_intcioexp1_irqs;=0A=
+    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_2700_intcioexp1_info =3D {=0A=
+    .name =3D TYPE_ASPEED_2700_INTCIOEXP1,=0A=
+    .parent =3D TYPE_ASPEED_INTC,=0A=
+    .class_init =3D aspeed_2700_intcioexp1_class_init,=0A=
+};=0A=
+=0A=
 static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] =3D {=
=0A=
     {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},=0A=
     {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},=0A=
@@ -950,6 +1008,8 @@ static void aspeed_intc_register_types(void)=0A=
     type_register_static(&aspeed_intc_info);=0A=
     type_register_static(&aspeed_2700_intc_info);=0A=
     type_register_static(&aspeed_2700_intcio_info);=0A=
+    type_register_static(&aspeed_2700_intcioexp1_info);=0A=
+    type_register_static(&aspeed_2700_intcioexp2_info);=0A=
     type_register_static(&aspeed_2700ssp_intc_info);=0A=
     type_register_static(&aspeed_2700ssp_intcio_info);=0A=
     type_register_static(&aspeed_2700tsp_intc_info);=0A=
-- =0A=
2.43.0=0A=

