Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CFCEFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLC-0002FJ-Gn; Tue, 24 Feb 2026 01:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumL9-0002Ey-Ks; Tue, 24 Feb 2026 01:56:16 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumL6-0005Lc-R7; Tue, 24 Feb 2026 01:56:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS4JfRad4TW4zVQ0aFDyK7ZE+GgXOHUhKB5fz3vcuTtNJZQbOosQPwwLfJQ6AiGjWTMv9nGMNWAj+CH+641VlxNRcTRfiBsf3mB6hJazjVHBYndODY6Up2ydmrj+lYyG58KwypSssPHs32Xr3cG+zdOBoqgB8o9K1FlxMhRD7qCdlMS6qb2aynJA+q+jjMJrAADTGINBsoZt3vDerQ5vN4YCp9sRuortTPqKavXI9Hr+2yzEUdoBmaVJVcubKred28L13n5oC4XoFeUkfPsCBJRRV1tB8rxwaWn/7Wua80aUBie+sNRySXvrjFJQKqiy+D5F80Ixv6/I2QDon73Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPI7bzBGbNgohErSZqjaK7yAhTrVvtOSxP5b5nRxZ0Q=;
 b=juymTyWvn4TSWhDEE8Eqi2vZ9Ol+/7tbkZAYhud/uWkaE7bJbyZvcmSxoSuA6NSo+bG+JIxeBynnEAAmPPDNvO0mnC3QyqWKikSDBAI/U0ZoSCt8gjalauMTYe8UhY10wqR/TSK2iBdv3dQ6MyS3ajb9zEQdvyEVbZ72NxA0OLz7jye9lYG453dmdAp5Yy6lAW0WuSKMICyiinhNnsT9Nk5JsSIbvOO3BjS9d3aTR+Jbd/MVdHmMT+41YmtQ9d/sEx4F3/LlcEScMzUA0TmS+phNcklaq6J1/yn1iDA8Z2GdqXOiSQdCUmLsDGtxpvk9bI3N7zzWLaXJUa7VYuD1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPI7bzBGbNgohErSZqjaK7yAhTrVvtOSxP5b5nRxZ0Q=;
 b=eLykbyuA/fStPy4XFxetkmy8RQVWavy7MDVLXyPug/1e7KuT5gXxbuR4OKzQtOdbP9H4IZ/F+aApkFVn8j2a1VSn2bJ7ssPIgVyhlHurT6hNrm1rNaln/8v24U75vtVytLHn0eFi+8em+ZpY7tuiZc9nSmIZ17NMMLXmXbvnH8EU5AlRpvAIMx3oDEyQGgnf9DXS/kkdvpde6g4AZ0/23UNzrjcLrFN932qw9YIw4EF7Wj/tUJZdVGKSpeCjU2PHLbRmsZfAQWn9GOv5rzHgB+EzLL2WFwvnRURF2M5pG1+mvC0OJQhT8rg8plsGfQ5UsnMemAHdhNtpEYzPglTODw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:55:58 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:55:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 00/15] Add SSP/TSP power control and DRAM remap support for
 AST2700
Thread-Topic: [PATCH v3 00/15] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHcpVqgClr8ZujQ6U6HeTjc97VUsw==
Date: Tue, 24 Feb 2026 06:55:57 +0000
Message-ID: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 158b85fd-a128-420e-0f9b-08de7371c33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zwOLjbo6zcYRbY+GCmbUn7pFHqYLYGHVJ0z953ThYAaODisw7PqdBuMkVN?=
 =?iso-8859-1?Q?5ZN6Cn9x5nNiUjM1sSiWjR+/TdfqycmZx+CV36EUIZ75Lyaso9PuIHYJSw?=
 =?iso-8859-1?Q?KMZgE8WirZIyOz6WVmgFJU5ClFievM7yV60ZLVybYhmU/ghbwM6go95PU9?=
 =?iso-8859-1?Q?IDwr2fIJRuQ2c+FkNgAaOpvq60rpbOEUDAlChzFGBgvjZ5JFhkKI+kew5c?=
 =?iso-8859-1?Q?Ab6hceOsxbc3Pl5gFqqA7qFaV5MshLLDeoQW7+OqUy/DwdRl2RYOjwo2C8?=
 =?iso-8859-1?Q?rpXTngHoP1KJifItPzQvSTBXccRvuQxHD97bkjI60ofQDKAPhPRHuPWsHm?=
 =?iso-8859-1?Q?vv4QLF2+0emc1tfmKE23bwm7jvWDGrDrAbr1yOlK5kRJP19GDK7QMHOOTh?=
 =?iso-8859-1?Q?Rm4qohApuFbPuisbumDdhqU4OkGclNKMd5bn7fySdJXh142OyasaFrS5ea?=
 =?iso-8859-1?Q?CqplZxnt13EF1Ut2gnrG0se6avgh0ZqG0lDRqsc5ysxRb9K4nXV+0FhB//?=
 =?iso-8859-1?Q?G8S1dhBdoA7ZkpRLNvluOWgRnNU2WZQDAuY4i5QbmuWlUErUOidduWSXTX?=
 =?iso-8859-1?Q?6CW4TzDzDqVA8nXMpVcqMA19+/HC7fiAjZo44oO3jQ7hsRjYssU8aeZxhE?=
 =?iso-8859-1?Q?B+a+G5I+Edn6QX6je4pIvUogI2iFJhDG3+v/slJJV4eXA/HPnGB59VjMnX?=
 =?iso-8859-1?Q?e3KIPkD6ZtCPyoGvg3aO9HJb+kO775hN/Xxl4KOa9dhd7MXHzPGfjUUi+L?=
 =?iso-8859-1?Q?sQizZPdLcU0FAaBUcUBAkP9JSyMy1pkGLZPGvamlQvWpdKi3LB1SopLN/i?=
 =?iso-8859-1?Q?GXu1wjKepIVaQF+Uxbufc4crDv4RM4TJSy2VsWWfnHxL46k9TFV6Bdn5Nr?=
 =?iso-8859-1?Q?Lw5e5B5T0k89TQoBJCcHDWQofN62OLSEoXWpu8vDhbiTCvMi/CgDbqEpuq?=
 =?iso-8859-1?Q?OIyH6lKwpL5ho+02Z+D6xyLrCGyh1uwLpYa/GVwRg3gsmyXlUNVxDw6Qfw?=
 =?iso-8859-1?Q?K+8r0/8SilnC8qN1sua89+X1s8FTh+Ua9t1o4N7RU4LFINYvijs/vHWBB4?=
 =?iso-8859-1?Q?Z4uCrSKYkGBpNfxGPwcSo8cQHVqKzlas4cO6MJ9kUFvNSdpECjvWjrqJ4/?=
 =?iso-8859-1?Q?Y9LQslrTjAAnGwc19X+8RuZxYqZXixcdUOrlr+awJP7iTxY1L++XETGbpR?=
 =?iso-8859-1?Q?arGMjCnPn2Jdj4OTzbsZwojAOvi4Gytu251Xnv/fRiz1Eh4Em8Sv2aPdSD?=
 =?iso-8859-1?Q?nPRx0nbnlc7L0pV/bgV8d/HeLQB8hMQJZtX6yfw4wuw31jqMBy5S9vXwwA?=
 =?iso-8859-1?Q?26Z7gqchjh27NABw9PkVp9oxe1cCgNmsWu9OqXA9sYOdxeZ5aczpZ1Y6ZY?=
 =?iso-8859-1?Q?NxzJL/In08wUSYqU4wlQTXZ81MdDiSmgmk5uGHXijhXGgToR+rrIQ2BLEE?=
 =?iso-8859-1?Q?4ikK58gtzqwIEx3eoZPAsUR5f0PQgrTGSnd/wRzW0tMt+MX3vZ6EqhsY3s?=
 =?iso-8859-1?Q?SXUKPjESBUU+KOwEvJtCddQed7//U2kYPnFpUapGAS2Ox3cJFaICVlR3Li?=
 =?iso-8859-1?Q?v945y+poSXSqPiQlBkcuTnQcxRB3STKR0SG4wFcCYeuHpLAhkZaAm//ZNS?=
 =?iso-8859-1?Q?PW+s7bC4oeLfhE0T1V/re0nxSkDq5DZovRiti0lk/ZE1ZfVZGTUXa8/GJN?=
 =?iso-8859-1?Q?Uge2+vsD02EWbxdglcM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6558CndoTu1/WxYo+5PgHOKaAUsq0U8Qi47OITerdwapvPIfvat2DEGdEY?=
 =?iso-8859-1?Q?pTV7BZZNyUgxqE108C4Uj2xO5Laq7b8bQsddLV9gBJtQtOeV8YMg+Ij0Zb?=
 =?iso-8859-1?Q?Xwk3byF0KuVlTi63dE/haxlsFz149zic/yvNMIiJdAHVa2xbzDiVd5Q0XL?=
 =?iso-8859-1?Q?i8bzkC8LzRamU28RndrZp5ivjOJvoUi9FsMsbz+oy6PoUDpsq4im/tA5j2?=
 =?iso-8859-1?Q?FCfD3zpsnZlWaUqwqt87qA2X+SHdyyVoVItg9xnervibWt8WbTDgAVgTIL?=
 =?iso-8859-1?Q?MPPnmRET29hsFdBl/l42XhN49yiNY4FbiDE0tNwotxRIyS2MpZ8+xT43jq?=
 =?iso-8859-1?Q?IRa5tpYef49wWzzXQ7FGrvo3hanbEHGeMn6pBC6yei4w6ecZq4zT9EP6P3?=
 =?iso-8859-1?Q?a3+43qKHqWA5o+BH867FjkbL5Bg2A9VbTDmeZ0TUgntoEKWCk8WDCOBRyv?=
 =?iso-8859-1?Q?pVPTkUy4YTuuMKLd9gPtlHGGbMPmQfhYwWXxmf+UpHDTIrClYTLeivOS/s?=
 =?iso-8859-1?Q?cnfks/qCdEmX/7pz1ti8rH8OGoQE3X67nEjrKw6zqM7as8gBZ5h1UVWMCy?=
 =?iso-8859-1?Q?8UAVhJ4Adi9YtVdlug2h2aEOVkY/+h+6Sb3dazQ83jrSf1OhVPVcxOQ4JR?=
 =?iso-8859-1?Q?XgelCh686HgWjzHIGlwr/NElokz9/jJZPQLeWeROiLUBRMfnLoIfku3gEl?=
 =?iso-8859-1?Q?Q+vBVRea7cBpyxZFC8wKuR/Z+dXAmz2gr2N+HGkQBFpiZ8HjcRgFbKOmXf?=
 =?iso-8859-1?Q?BskjHIEOy0NHwYy1XQRb+4KhYa4+VOc4xmdeh3MVPa1lb7dDCeGxurd0pP?=
 =?iso-8859-1?Q?Ac8UJ1cwR921Ygoca68gHjIj43VBL307ciiSgcmVGMzY26Nf6lFBu8yYJ5?=
 =?iso-8859-1?Q?M0+qDKVK49tGkiUy9Vs1eqGaS0wDLwk3USDGa2qDy5RcBBlywTjEEil0MM?=
 =?iso-8859-1?Q?X0l/boVoV5nQfxSrhJnQDTuYxUgBe6d0AYs5Mf4hdxbh0ru5BumfSgXdS6?=
 =?iso-8859-1?Q?3nLHQoZMHCxVZK6m1KHJ0bGybgbxtOOKM91TrEp9/LkEZ30RHQfVwWQW1M?=
 =?iso-8859-1?Q?HIuBRfzVGFpHIsCWVFenYNTOxjxifJMUZEpXOFYmZv4NnN/UPns+kNVGAO?=
 =?iso-8859-1?Q?0Tr3zHdXOSWq2VTxYJ3/FSMaSiuKCq7lNUapz5etsSKLDHYCfsoadAW7fW?=
 =?iso-8859-1?Q?yjZ3ltkptLgqNSZOjqVc4B/RU50tzCR6u9jpmFyJM3NgxzlBArmz96j1Dt?=
 =?iso-8859-1?Q?5j+5xwWjA76WJjy4Cq4iSjOLb54mkg0CImQr6okV8HzI0AjZzFba1gx/e6?=
 =?iso-8859-1?Q?qHZ63sAue5Hi6w8NuMtZYoV8fXizgsO/Th/PC4OM2h2iTKjPyZbZGrqpJv?=
 =?iso-8859-1?Q?G+2AXuOgoir84wrIo0e7BfLrjtmBIqhKtY76xGJvXWD/Snpn/qVCq2mgdO?=
 =?iso-8859-1?Q?oekskNwG1T0BEgaHwXrS9jjeHdFk5kYzOnepDYZESif2GMsnkprnvvc5hf?=
 =?iso-8859-1?Q?2capIC/3uFrNtsvkZW0eDZwziziJqrhf5O4OuOS3QVxB6wxMkLWbBaFKTu?=
 =?iso-8859-1?Q?szgJhIWvO1G//yrlqzKdcWpSB2gmZPPrsH/pV/1ONzrC6BRPxwfuf3kgCj?=
 =?iso-8859-1?Q?8eAgNBFbnA5dG8750WFSYkA0sverowpMm/zsHDxsnaLBVgiePXZdcrKQhD?=
 =?iso-8859-1?Q?/Z5CyZUXDV7TNDCT4hirUROy1pAe+1stvd9ff2q9by6ZCADcUGFD74Ykb1?=
 =?iso-8859-1?Q?mPcZCo11CrJq99LQUmTwFt4LynI3VeDfd8Vgbu/EH3pizIBcQdmVywk8ms?=
 =?iso-8859-1?Q?oJnxrj2NNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158b85fd-a128-420e-0f9b-08de7371c33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:55:57.7296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWl1q19KOfHFq+bqY1Ll40fNOlKo/QOx6+VeUz50ZkA/5Eq6etLbw2pkptVEVcysOFHpjKbf7QBF3miEwZamYA16AJT9P0Fbo7PtDuJj1uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
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

This series improves AST2700 platform support by aligning SSP/TSP=0A=
power and reset behavior with hardware, and enabling DRAM remapping=0A=
required for proper firmware boot flow.=0A=
=0A=
v1:=0A=
  1. The changes move DRAM/SDMC initialization earlier to support memory=0A=
aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement=0A=
SSP/TSP reset, power-on, and remap controls via SCU registers.=0A=
  2. With these updates, SSP and TSP can be booted via PSP and load their=
=0A=
binaries from DRAM. Functional tests and documentation are updated=0A=
accordingly.=0A=
=0A=
v2:=0A=
  Fix "make check" failure caused by both AST2700 and AST1700 realizing the=
 same=0A=
  TYPE_AST2700_SCU model.=0A=
  =0A=
v3:=0A=
 1. Drop "Move DRAM and SDMC initialization earlier to support memory alias=
ing"=0A=
 2. Support SPI/FMC FIFO Mode=0A=
 3. Add unimplemented devices=0A=
=0A=
Jamin Lin (15):=0A=
  hw/arm/ast27x0: Start SSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Start TSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap=0A=
  hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap=0A=
  hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO=0A=
    regions for SSP/TSP=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions=0A=
    for SSP/TSP=0A=
  hw/block/m25p80: Implement volatile status register write enable for=0A=
    Winbond=0A=
  hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for=0A=
    AST2700=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP=0A=
    and load binaries from DRAM=0A=
  docs: Add support vbootrom and update Manual boot for ast2700fc=0A=
=0A=
 docs/system/arm/aspeed.rst                    |  37 ++-=0A=
 include/hw/arm/aspeed_coprocessor.h           |   5 +-=0A=
 include/hw/arm/aspeed_soc.h                   |   3 +=0A=
 include/hw/misc/aspeed_scu.h                  |   6 +=0A=
 include/hw/ssi/aspeed_smc.h                   |   3 +-=0A=
 hw/arm/aspeed_ast27x0-fc.c                    |   8 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   |  39 +++=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   |  36 +++=0A=
 hw/arm/aspeed_ast27x0.c                       |   6 +=0A=
 hw/arm/aspeed_coprocessor_common.c            |   2 +=0A=
 hw/block/m25p80.c                             |  36 ++-=0A=
 hw/misc/aspeed_scu.c                          | 272 +++++++++++++++++-=0A=
 hw/ssi/aspeed_smc.c                           | 111 ++++++-=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  34 +--=0A=
 14 files changed, 563 insertions(+), 35 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

