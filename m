Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087E2E7317E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5dp-0003MB-U5; Mon, 02 Feb 2026 20:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dj-0003L7-Kb; Mon, 02 Feb 2026 20:55:39 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dh-0007rl-7z; Mon, 02 Feb 2026 20:55:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnJW6ia37d6sHIzJM0JnvsqXEqdVo9GZQvb4e2d9cvOVLDH9SnDRPQI74XT53YGAdFRHdMvNBt+0yJlnCuZtosF7K9l9AOD9EIL0WWpVfLq6l3X1su9DiQsFkZSibR2iBp4cv/STcfNbXkGMTYk8kJNrfmnKarZzCaXvqE9CqX9FTIoVMYrjFbl6QsvqtBXJpcH3b2enY1898tznMSSI9ppSLjTh/5BL2sAW27bmED3qrA2fKGv4zC8DRGIGxA3qm+1U532Gzk1NUGojO4iOgo75Jzxu53qvqrmFFDHGlye/0bV+p5Hd6W/UIjxzlguPlWrsUcuY5/I6Z7OOWVdKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AERDW71m0v22kM49/Vs8GIt6sPKvLfEB/MP5qqtsVGA=;
 b=icmuzRUCA+bXCDcR12XLghw+j3F2k+ZXLAm0nXPqovVp6RAhgVF+Vuxu+zSdsnHLX28aFEOAvqKcSKmbGE1yDdlO2R8c7f3MuqlhcUoWgeMirXkMx5Ar1MingDYazsbtQGvaZgh4Wotemg+Q9RfDbo24HFf+ESvCgvTiBiE9MAG+rPW7L+XycfQz5HtvDYhiNCZFCqFVfDpuVnJt0px3rSPB9ZgnGYbTPAvatI2tvqxaffPY76CmTc1rhcFAFj3WbJ0p4vwrBjFnfmoAnC9DoFGgRuvlQozS6HD9B3sWXE8ckIH55JrN4dG0TKyccphrLlymNmk7XzS+4nfBPNhz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AERDW71m0v22kM49/Vs8GIt6sPKvLfEB/MP5qqtsVGA=;
 b=iXOwzGM9NrGQSUKO+nDVTEgc6ae9btAumtJLZ0qz3mTbEVHJ4PfnOWIvPf1vNkBRXaZ0aYklHzXQKwa3I97byFLp+4wYQOBpHBCMYp7OVQGeAOfY35EwK89eFpBmDA8CSqioqcXatFR76eDVfw/ddphyYIE6fjrw59+jstR8fOu+oOHWpDrC2Cg/MCqc4ql5/q73OWz6KGLKC1shYYZ4BhwVrENikdEHKX4ZF1kYzfGwbXelhNZW6pD0Vi1TLnoj/xqSWdwzP+wYKXxOsqopDehxjdp0NJ5GqAL4+p8viYFe8DvpNl6MThjmjgel3uIIycFOVewckEqFoAKyGknF8g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
Thread-Topic: [PATCH v2 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
Thread-Index: AQHclLAs64G/W7ikD0OPHiXwvHdKsA==
Date: Tue, 3 Feb 2026 01:55:29 +0000
Message-ID: <TYPPR06MB820655E28A3A9BC11193688FFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: 6eb464b1-42fb-4d3a-ec86-08de62c74f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LtFk/G9T9EWGcFy51tm9oj9CFBU+U1Yu+FU+Awe3BDkqb1kl1SprlT5h1tyv?=
 =?us-ascii?Q?kwJNum4V0t7x1CcvKp3WLDsyTCEPe3wMWc/50P6ACk0NVR3JV1d+96Nz8vkq?=
 =?us-ascii?Q?L2b0oHIwJrKaVqYargjuA+ueZTyXdw8/0dk0KUkXlpSwl4pLvF54rKdCS+dD?=
 =?us-ascii?Q?2+qGoaRmDyFrVAkiR8W6NqQLgfPTvZig8a15c0eU8vv5GS50K3XVtan3gz8Z?=
 =?us-ascii?Q?UNu6xkSXmqLFvLkjtdA3xhrmkKxmvuw2hm44hoh+TyxZIH1OBZmoiq0NO/Al?=
 =?us-ascii?Q?lKu6EUzzxx2zojDRiUvXb2+GhsbvilfPMAYWeLbPt/ENQIglV2rUEbhl3zi2?=
 =?us-ascii?Q?lgexvR5nlYHpDIUMdejWSXK6/1AQDeCBYExa88dxVHyasO6trkapiwrD/OmY?=
 =?us-ascii?Q?wjPhr2fFicm69VROc6y+oyYKGsVPwR+Y+qeUY2TPk5zUQO9iM81nMUOAquMs?=
 =?us-ascii?Q?wsmD6UV/NAIFWF0SRmV62BeUXLb4tedOB+mcFpi9cOwJh6wW31HGq2bXsQgA?=
 =?us-ascii?Q?bScjdL0w1Ic365YqcqqK1Zw/EI4KoByPsvYBhy7Hm7X4HWzaAvMaBkt/p7/8?=
 =?us-ascii?Q?dv8ajgFeu12EJELSMke2lJ/rPV/obmyx+JQ3+rV++GPczffq//4W/IHHEoLm?=
 =?us-ascii?Q?R5glmVSsDYjdyl8wXxcX7/WP4HK/giBssdSuEB3/nK5w4ULzDTKbENk7iqg0?=
 =?us-ascii?Q?dx4SqUNtu0hwxwliRjNzhnwwObOJURd2PXACTv32n/SgZz9ZG9QicDXelPrF?=
 =?us-ascii?Q?Hlf6xDwXeVhKsLlXpEpDsfGybJ8M3271VRCJ3YPp28AS320KV9h+qBI32Zh1?=
 =?us-ascii?Q?QZJApozXULbH+t9HIqQfwMaGz1mY+CUgyAP5W3GpL8HRIuWNXreBdS5NxsTv?=
 =?us-ascii?Q?lNWZVXsvWOAC8mdjviwSH/lt7+THh+i96ifP5ytbh0ZGHifaO8YJjwk8kkMX?=
 =?us-ascii?Q?6iAj7fw3YTtPVU657hEprZmf50MyVyW1cBEq5DIxIGoOV6TP8GHQc1VcKp9V?=
 =?us-ascii?Q?i0OCkHIkN6r+Ay+dwoK1j9jejkwhDWVezcIa7fkdyLyVrIFWW5sMD63/l6iG?=
 =?us-ascii?Q?n2ic+7uj5OdBiKUrKUSgMmojn1AL9Lu0boZq2dXKDJYumb3erzI4wcyvIx/x?=
 =?us-ascii?Q?4W2+6nnQheu3kNW43pcTo2k53qX65BVLE1mtwKR83/Zp3OxmPBwMrFFlzIeR?=
 =?us-ascii?Q?NNKlyJ/Y8roGAjqmu2a92RqpHY9zBjJ1nVhRSxqw+Fljw6UyqQkki/tAYTJI?=
 =?us-ascii?Q?X56phXV5jQRwAMOrITPkAqv4Vw0xULX+uygznsFGMhU9yXb2RUjA61FM3iBl?=
 =?us-ascii?Q?zU7oW+RqmAsDk2WvqplN+Zv6a89h9e55PCEXIec1mPCxPHKcUoSYE/8F+p7O?=
 =?us-ascii?Q?oG5TVnYcDzctb4g/MzCmTALJmKbd4J4joM8MYQMZHDwHn1kVi6Q9piFz5bk5?=
 =?us-ascii?Q?OUm7eIbQlbMPljLaC9O5+pDaT4Egqh3O5MTdjwj2Bb6Fkko7ceX9DpJPzvD+?=
 =?us-ascii?Q?nXiF1lA0RRVc2hX/m8n4ryLI/yP+s6V3Yoj9MT1SIRlBYxCrDr6vV8O1MPoq?=
 =?us-ascii?Q?UU6YVyrakp50SCSU78qTAtKms9ugiSNBtMqe2mKPqF9UiaLau4VFh/zLS1MY?=
 =?us-ascii?Q?BjfU4SJNwt1BbU7JPliLoFI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xjl3vBVtXfDdKMCk48efnjxkhBbJujRxgvI4Qt+IdSv5CYcVMKizcWG2UEbx?=
 =?us-ascii?Q?MHXGMO9RY5U9qNuN45H2T7RLHzQAalCFoFpso575thwN0JgilK7lSA/XSnDU?=
 =?us-ascii?Q?0JWKqHi22bWHN+M6Pm+/AoZvITeaZYUUcuNHpQ/exAn1q2XBSmNOAS7aLshg?=
 =?us-ascii?Q?A3t2qt9CgYz1V/ObVwQxhIJp4vxsdlS+O7BT/w+PvQF/oP/wNzS21oyciTIT?=
 =?us-ascii?Q?ChKNJZLR6DQmjSEQ9YTIyV1DGEpj7nGiCWjpCJvC4vQpq9JvUPu0K91Kcoc2?=
 =?us-ascii?Q?2tqxhTvCqoxkzpfij7Gg0t0+Gz8pSTszyuDgRCVK7cWafgttFvnlAjelsQWj?=
 =?us-ascii?Q?jOS/TR8bqRHzViWw+3qWIIXzFOzDPjz72T7c81LgTv0p6zfPRa/JkiR94ufh?=
 =?us-ascii?Q?ENpkOjtb4+NaA7QwEc1FBFIMjvCmU64yz8gGXh0U1hFHwg4sEnLti9XPYZJP?=
 =?us-ascii?Q?WXu6xAtnvaaE3C2fafq+o1yUNA0FjZHxRuQIucYIuA04brEydBDUDToPRxm+?=
 =?us-ascii?Q?qtb3S9oQ5n9+pjxdwCEUZOOstv/RpfBI/CwkSUURD/3IgU38BLWlW3MPhdaJ?=
 =?us-ascii?Q?3AegUJpK7g5b6w8wSiQaGKC+vktxBt4KL2dhhkA3kyFMGxRArA7BN61DToC9?=
 =?us-ascii?Q?ommO572K9n1O7KBIPvAhIgb9jPXXE8GREdZvCaqjQVjBx3EtCnZRT7c7rKYc?=
 =?us-ascii?Q?EsweB9wxO5jgMnYO5wNbfDGeOC2Mw8FtqzuckYlSawSBcA58omfTMzy5cdHh?=
 =?us-ascii?Q?BJgA5e4lcQzBqxajjh9zLsCd2FLhOOxG+a1XaAHMG/NloxzUcEW6neiRH9iR?=
 =?us-ascii?Q?5u6FYcRdczB1IKnNICryk3qo75PerpjrrcyTn2siJVvMZCcP0HqOB8Z222BF?=
 =?us-ascii?Q?K6H7bNs8avXpUEOg3owWQRx1IjV3vGvJholyeaL3bHIvgH0Q5oUCg4iiK3SC?=
 =?us-ascii?Q?NoetVLwcrZO34jAuTL/ZX508K1dZ5IwlIvG9InAg3fox+8QGh2hRzvnRIS2F?=
 =?us-ascii?Q?PLICsGNamQY16nXNHDSrSUMSqWc4oUfx48T+OPMLXjGwUgK04+9U3Sqm0HG8?=
 =?us-ascii?Q?DCEkvjKMw5f6wmkNfxf+o7e63bTfibDsHTlg7GUAa9wqUB8qvKfeF9bMPS/d?=
 =?us-ascii?Q?9MiOPVVn8iWB+YAvwfgTe/LBAXCFutGThlOZuHO1YOw3WI9RkB/mwATtTNrA?=
 =?us-ascii?Q?2w44DFzQPhM6bEsl0eP7ZiBcijrpZTkW7ZQkxC0zh86K5LkBSKxxn/HOud4j?=
 =?us-ascii?Q?73RndTlaZANyXWbr8h+flPDIK4R7hozrwKmW3+dQx/2AtorVrWtWlgSsapGg?=
 =?us-ascii?Q?jZHwZKaOzFhMqXBC0UFCFlz+coQKsIuHKitBc7eA/Jm90wmDSeWC0Cw2v9Me?=
 =?us-ascii?Q?W5Blda4hyG6Ede9xfniNr9zhX3aOA5wDaZZ1ITMEvN05w9aN/XH5I8S0Wy+g?=
 =?us-ascii?Q?TiQ8PRZtifcjdY7HUTbbRrHH+sRFKTOJFbawb46SK9TTTyy/mUuLzAx+TBYm?=
 =?us-ascii?Q?lu+GWpAUcF9A4LscdIyU4oT1dvtovXWuRtFtbzegHDzaIscRu10p8WlU38F2?=
 =?us-ascii?Q?20Twug7wihNTaR2j9EddyW3lpaDysv5+TNyVy4qggNUBaTvgPUREXcrzJcCG?=
 =?us-ascii?Q?BKdDbqFgjS02iuyxWDS/kydvS5IIsRr8WKFVQpVJqBMhjf9nvXwLC+SBGMth?=
 =?us-ascii?Q?S1kP9nJD0lHlL75vV0U36iE+ImdDAOUb6xw0a+GtzRHrsgGgWLTmi51zhoaT?=
 =?us-ascii?Q?lnBqb6Qyzw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb464b1-42fb-4d3a-ec86-08de62c74f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:29.6736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQjKvOxotPQu48sluqegmzRgOM7naTve8YP95vMEYWGlBeZodcbqxoheB+fPpLFZDL2rtsQLgzjBbK/QHStVS6pUesbWzYq/T117YaeISEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
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

v1=0A=
 1. Update test ASPEED SDK v11.00 for AST2700 A1=0A=
 2. Fix DMA moving data into incorrect address for I2C=0A=
 3. Fix EHCI3/4 IRQ routing to GIC=0A=
=0A=
v2=0A=
 1. Fix some extra 'From' info in the mail body=0A=
=0A=
Jamin Lin (8):=0A=
  hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC=0A=
  hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables by address=0A=
  hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps=0A=
  hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Enable PCIe2 DTS status=0A=
    for AST2700 tests=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Update test ASPEED SDK=0A=
    v11.00 for A1=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED SDK=0A=
    v11.00 for A1=0A=
  docs/system/arm/aspeed: Load raw U-Boot image in AST2700 boot example=0A=
=0A=
 docs/system/arm/aspeed.rst                    |  8 +-=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   | 14 +--=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   | 14 +--=0A=
 hw/arm/aspeed_ast27x0.c                       |  2 +=0A=
 hw/i2c/aspeed_i2c.c                           | 87 +++++++++++++------=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 78 ++++++++++-------=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 54 ++++++------=0A=
 7 files changed, 153 insertions(+), 104 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

