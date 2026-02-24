Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E3BEFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLU-0002JR-1f; Tue, 24 Feb 2026 01:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLK-0002Gq-8U; Tue, 24 Feb 2026 01:56:28 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLE-0005M8-LJ; Tue, 24 Feb 2026 01:56:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv+92eAn9v4YrLFIMkDDRO7NdZz6ANSnx+wzCUStJToPZkWJPCe1rWRt8YjtCUkKTZievBf4cSDfmYN9z94oC+Rei9Z/RG19O2M2zs1fYJSyxIGCEJqlE8k/Nhi9cjZXexf4O4wApC5hP7AGWaSQElc7gkxwEuKAvM2RB8D2Peuw1FgQ08pXF94g+bIy9qAJN33M2V1HodDL7Fb5LJrHEvdpSRfV6daidj/AaByk43xjb2TnBM+czs5sBMNsRRvMeExYz4QkDU3lvwHmz+4spih1pRnvLg+Nf+1e81lGLPg+cpXyZM7PS1eMRqwORlmaQhoZRuoUo1IUdgy99njeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wdn49wxih/GxlQRPCZsSv0ZU4aHVolZYhvwrQewYITs=;
 b=Q0C/J6Yx/jXK0bsPlvrEd2jCTOMDDJa1rhH1FH34j1fHl6oTdqXxyg1z1Ce50scLDlh8ueDFSy0Ni7Ji3NmpNMKFkklZLbKVYk4qx5UNvaZPtvnyLb7vSJmOH5xb1BuDldHGlor699Do6WrgYiQGS3/N8W46k3g1aU2cVwW2NP8ytoODev5BJkBgm14tGP0gTuiSsMDYAgDmZ+rdJT1S17ZQUrlxqLgy5eYmGecuaQhX37csNw6E42xbbXdkK5oJxQpjcDO4BQyHMdfabcN6/nwQSUWb8PNN1KDBFzks/PBfyig+UDB/No2koXDDMs1JYl5oSOutt3qmImS8lplQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdn49wxih/GxlQRPCZsSv0ZU4aHVolZYhvwrQewYITs=;
 b=KxUGITbGdo6maPuOx+KiR9rsIaIi0ArMzFSrUXRdVFbmRBUqJU6g04nuKKfG9/p0uGvu8P66oEwwJ9ANEGgvLWXAdlIattkk4EkqzDqx1fsvQc9oQYlweZNiaiIkTU4ASvBBwbLOfRbsuuNViVEcRdzJPl4yErMW3Fnj1Pmfx/79eUaZ888LPIJFHstcPWyq5KW/p3Rl77pUxED3fY7OMXc02Xaoi1TVf/dO4ZfJGSWzTrIrn4DPDvPnng8IrbRHfUcJP4OMlopZ2AdHZp80rjbC8+RM2yXphTEBw5OjH9pCtGd7SoME/A4L/+QbfJa1k69xhCUHBPWkTaMRe7CcwQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by PUZPR06MB6171.apcprd06.prod.outlook.com (2603:1096:301:11e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 06:56:14 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:14 +0000
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
Subject: [PATCH v3 12/15] hw/block/m25p80: Implement volatile status register
 write enable for Winbond
Thread-Topic: [PATCH v3 12/15] hw/block/m25p80: Implement volatile status
 register write enable for Winbond
Thread-Index: AQHcpVqq9gqwbhjXi0iW1h/cuw62MA==
Date: Tue, 24 Feb 2026 06:56:14 +0000
Message-ID: <20260224065556.3847942-13-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|PUZPR06MB6171:EE_
x-ms-office365-filtering-correlation-id: 6a8a1ae9-8380-4717-13d0-08de7371cd09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1jnJuSTBjTBvmwTuAokMIaBv3fmxlaikteyCyZJku192vy6KB4aycP41wr?=
 =?iso-8859-1?Q?U6N1z0LZXoUX4XmT+8Q3yCsuKKupav0vyKjqJOgidYwOGcb52L/YyND8lW?=
 =?iso-8859-1?Q?FFAsXFa+DdIX0Yj/mUBsfgfc9EW70R5szjJlqwNnLuX//+MXBSY0HaYI2B?=
 =?iso-8859-1?Q?JkJXWw40eRG6CNouilx5yB7tXlRs9JLmFfx9pHSAnAMll9E49w/IcqmPRo?=
 =?iso-8859-1?Q?N6eqN3zVUEaMz6U6x2V+ZYemK4pBA/Pd7y/YcdoRcxvb7MqYS+COIvUlAn?=
 =?iso-8859-1?Q?1AqFZjYONiuuTeuo/R1wsWwU5Shns0sv7s3fBWvwFyC7efBBZI1Qjrfrrg?=
 =?iso-8859-1?Q?CIVeJtuWIWXB1T+nNjH4eRReNViAPXsboZSwDA1l3kMV29BJBV+AmNGhnu?=
 =?iso-8859-1?Q?m92yFZ5/Yd65LiAqpDW2KLmKMytaVdz87c4oH3VhGQBXlCMa5XleYFbNMk?=
 =?iso-8859-1?Q?pjn9rvQXYbPyV210R+sioIVAcBXycVAsHCXbuUSZ5VbBf6f30p8MP7vvl3?=
 =?iso-8859-1?Q?1StI/OP+Vc/Pcg5HGj7ejgH0TbmC3Tcjp/aUq8pg4pndOoSJVjzDtkyHAP?=
 =?iso-8859-1?Q?reXLtZ/Itn+dl8h7QCEeoPhELSD84mSZC2oZXLt5qnoqXtTAnNGI7cmrjn?=
 =?iso-8859-1?Q?Pbs1McdjzNOwOmCNstrPPoXRYUL6cmsOzZHZSg5jN6ol1XjGiYRN3/qDEU?=
 =?iso-8859-1?Q?b75dPlILnVOvDy07H3yCHkvICSyO4mhf7vWYKIZJchfRMbTLBhaxFQmO/x?=
 =?iso-8859-1?Q?tU1EfU3AMefAOSxXWoGt4zXSaqpcOA/YHPtWOsAY1dUjeptcsyWumhmJV1?=
 =?iso-8859-1?Q?eBxwykIfA8s20FCmS5wLotdyW0QwF/l9yvA2k8opuVJzrUDo0nP4ZsoQFb?=
 =?iso-8859-1?Q?kltkfk+WBDNLR56FX6kBW/mvhsPaTRo9vZUTcYEK1ZEBw+A+0qYBminDI8?=
 =?iso-8859-1?Q?pbry7KiyweLlkpNA1rtNxJuMJInYHwMNfLpdDkesq8PTK2aT/mDZqxk3Lr?=
 =?iso-8859-1?Q?rtzwPBcW7TbhZMCxmicDJK4Pf01R8aDY+WwixzZtIBB28mISliSdlrKWV9?=
 =?iso-8859-1?Q?RoNbPgx22ZQQQGqt8BvbM3O33S1Y3vMIjQbjmK94cbx7g6lDafx336XK/J?=
 =?iso-8859-1?Q?Tcz9jrHZqTyVwiCv8bTajsprpD2RAJWYO9EAKiTElqwPgqCFaPaej+ExC1?=
 =?iso-8859-1?Q?xM2QtXaSvhIKFGpbFFezTH+YXOkb9NkP91lCM+PZlbX5yTWPrzdprvRBJV?=
 =?iso-8859-1?Q?/K1ixDnpZcNzDC55JnR4wmjhiuluJ8J7JomIkRE60yuVGhsWwZftUJKJ18?=
 =?iso-8859-1?Q?jBQe6J169AIzLCNHGAggGY3Ngl/gNj6cqK9Ro1YPcrwNCIKgnsqS+fHVgG?=
 =?iso-8859-1?Q?C37aX11PH0IUs9A0vZ+vQ8gwL2c0iSwFsijCkmHNqWBN9vW1rg+NgsL0Jt?=
 =?iso-8859-1?Q?3MBzv0BMh4ipUDZVAllObZXHAmMW+okIPs+d3A0p7HpqTyk9RHk0mCLSsx?=
 =?iso-8859-1?Q?rYSNimq98XXnXXZ4iT7UpOd8I6pt7y262/Of/aNRdN+otdJ7Ys+KucTPsD?=
 =?iso-8859-1?Q?u4oCUP/44R4vBJDokDYAwRhhMndSXF+er6x8RBfNIc9kCk+EhRoOWKXH1v?=
 =?iso-8859-1?Q?IzpRHsOPh+MeQI07Fn7g0EegLf6AMyjGy6Z9Qnt8nERCris7JIc4zT99zi?=
 =?iso-8859-1?Q?QJKp/yRq18UNoZEisEPR13e7ZWbY8aiHh2YrPEr5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nRZruRR1hrWJIkiySsdUHIkfnkgKrULQ77iaQvYXR+d18tbU+fVchQ3o1v?=
 =?iso-8859-1?Q?DNQEYfE+9U7uY8rox+ViV8PPB8qcOmSI++z1oH9i75EvDwQ969jf5zISDL?=
 =?iso-8859-1?Q?vc2176f8MRgWKgAqDnSys/xKYIsa75VWrxtYOxLbHzerGDaLLeUcyLbR0l?=
 =?iso-8859-1?Q?X4NFVK/ye6rEx1YA+bdDurovQp9E/4iVfrBFCT9MH8DUdvAe6se4DnXEvH?=
 =?iso-8859-1?Q?klNtANfIwuNXnrzDcEN5LoCX0RbOe2R6k5gIFZYOFgqMZ7BadTtSohs8WM?=
 =?iso-8859-1?Q?vL+wa4ZfVSPEBKmzTfso+71hI4m2TYIurJ8euPbE4SHqkG9BHDDNbf//ZN?=
 =?iso-8859-1?Q?9o+YTcuCTwn35puz0kWP+QnA9CumVxNnfGx2xtPnd3S/AOzcyhi7Q5BHqq?=
 =?iso-8859-1?Q?HOj+OxML/VzqFedRDFQfUV5l8DnEaPDJKm2VhXC9pH3LfbEXkr9HuE5Yuo?=
 =?iso-8859-1?Q?JhADcXqSHa0tpfLbzfd5DosJhmgoTFB7VoR7f8uedQHWsSim0Qvr/0QR0C?=
 =?iso-8859-1?Q?mBlz3f2gf1wew1+BxGpFB/6dIfvmpmArWhVoj7nxPFg6t/CzcRKrDQBtzo?=
 =?iso-8859-1?Q?2Xjp4+kQFovCimxHNcraIVBlgAgoU0Py/a1JXpgC9PdDE0//pNQ86etGm1?=
 =?iso-8859-1?Q?fkVwbbCfDE8hIkN7kfdu6Frzr/zPHK9wzVn3rB2/Cs2scM62KXOBSghAvq?=
 =?iso-8859-1?Q?63HzV6IQ+4CxgdGQ1HgmN72FY99v9FF71zQSekzeuRyVhLUcpGxmYYLh+7?=
 =?iso-8859-1?Q?7R/m/WmQuYPhcdsWJz1QE/paA51CWWzk6z+Av+JWSxXZbEF48h8z0sFDGc?=
 =?iso-8859-1?Q?tusC58qh5SRLY3tXI6yOrr8kEGP/rw79qY6/0ZffakwupYvSbDryzeB9zX?=
 =?iso-8859-1?Q?Vpy+0YLRa9rnvc36MmTazVC+aVbNXIts9L4bB+ynM9MbcrQea5q2pK8LJ7?=
 =?iso-8859-1?Q?bfxAsUBThNODau9JIqf5BPtbGxOTePR/gg97NCNmbv5Iy1782ZKEXy7Sld?=
 =?iso-8859-1?Q?E+kL/RGuSVyvQBxfz0Ty/QSZ4g3q5F4VSDMCdITJVzdNO6eUpCWEO/zXro?=
 =?iso-8859-1?Q?ovEjzRpDBID/TTQHSC50lz1ONu2wdpFNpD8KiPpB/4FRE2+c9k/NCC4jJD?=
 =?iso-8859-1?Q?3E765jf4m4JB5CxQs2t9YisVSinPAVmrtLOUKMMgN9vIGy08gTUMzoYdFE?=
 =?iso-8859-1?Q?gSxvKonj4MZEHBUywDCLmqN9D9cXPk0OPR94fU6bFgrDW8/uZdr/vgfcPu?=
 =?iso-8859-1?Q?r1/wgzo6ZGL+DYLNmhcs9ayIHivhHHfGmQLlcwFseJWGg75nZ1rwyanibY?=
 =?iso-8859-1?Q?G/ulGXu7u/txBcxPbGHUwVFePm0VTPnshGPi410NO8MdSVFGjooZx7LLUQ?=
 =?iso-8859-1?Q?Q0viPngJOrh+vn86NiX/NqZesc8YuaM8UyQXr5uo+Jn2v4xEaIpN0KqxyJ?=
 =?iso-8859-1?Q?PyRC508oK+h9r3a3MhI/2pClU9FQCJERWKAQy1FGMk0BuYh9dj87pDcteN?=
 =?iso-8859-1?Q?50LNzMjEpPDWDfMJFaZ6bJ2N/YbEHRI3ELrAKMB6twQCBxe5afYIFsZzRo?=
 =?iso-8859-1?Q?7XP8RuxB7O0Atp2h+oNvbwz4YU5e6jeeIEdSmmZLHfOBr4dEcA2GhDVGJE?=
 =?iso-8859-1?Q?9+RrZ7P9FDFSg+FpJbs3MLup3Adk1ux0vyTD0m6rt8xj7IL2vp8Z6XISEV?=
 =?iso-8859-1?Q?AFB3CZtqtKVAUTPZl3QRyMozt0AwsmmCouA7ABVCZE8x6x2+DYC0/3p/XH?=
 =?iso-8859-1?Q?JiYE8azHmpxXnJ9k4M61gFRkJWFGWbuBlZaP2vihsYr2kJmVzK0Z8WJ1lI?=
 =?iso-8859-1?Q?oM5gKYmaeg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a1ae9-8380-4717-13d0-08de7371cd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:14.1330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdwoQwRYtckOKpDABHi9C2wzjT5uHs/vO2YQ5l/vINaIEhRNjudrD/rpNNez2Msp+z62z8T+wADKUkoGN8RCXNkg1a7vnSYQOSP5jUGW4MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6171
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

Winbond SPI NOR flashes require the Volatile Status Register Write Enable=
=0A=
(VSR WREN, opcode 0x50) command to be issued before updating volatile=0A=
status register bits, such as those accessed via the WRSR2 command.=0A=
=0A=
Currently, WRSR2 handling only checks the standard write enable latch,=0A=
which does not fully model Winbond hardware behavior.=0A=
=0A=
Add support for the volatile write enable mechanism by introducing a=0A=
separate volatile_write_enable flag. For Winbond devices, WRSR2 writes=0A=
that update volatile status register bits are gated by the VSR WREN=0A=
command. If the volatile write enable latch is not set, such writes are=0A=
rejected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/block/m25p80.c | 36 ++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 32 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c=0A=
index b8a2543c0b..5bb8b8efa9 100644=0A=
--- a/hw/block/m25p80.c=0A=
+++ b/hw/block/m25p80.c=0A=
@@ -438,6 +438,11 @@ typedef enum {=0A=
      */=0A=
     WRSR2 =3D 0x31,=0A=
 =0A=
+    /*=0A=
+     * Winbond: 0x50 - Write Enable for Volatile Status Register=0A=
+     */=0A=
+    VSR_WREN =3D 0x50,=0A=
+=0A=
     RNVCR =3D 0xB5,=0A=
     WNVCR =3D 0xB1,=0A=
 =0A=
@@ -510,6 +515,7 @@ struct Flash {=0A=
     uint8_t spansion_cr4v;=0A=
     bool wp_level;=0A=
     bool write_enable;=0A=
+    bool volatile_write_enable;=0A=
     bool four_bytes_address_mode;=0A=
     bool reset_enable;=0A=
     bool quad_enable;=0A=
@@ -897,6 +903,7 @@ static void reset_memory(Flash *s)=0A=
     s->pos =3D 0;=0A=
     s->state =3D STATE_IDLE;=0A=
     s->write_enable =3D false;=0A=
+    s->volatile_write_enable =3D false;=0A=
     s->reset_enable =3D false;=0A=
     s->quad_enable =3D false;=0A=
     s->aai_enable =3D false;=0A=
@@ -1305,8 +1312,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
          * combinations of the two states are called "software protected m=
ode"=0A=
          * (SPM), and status register writes are permitted.=0A=
          */=0A=
-        if ((s->wp_level =3D=3D 0 && s->status_register_write_disabled)=0A=
-            || !s->write_enable) {=0A=
+        if (s->wp_level =3D=3D 0 && s->status_register_write_disabled) {=
=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
                           "M25P80: Status register 2 write is disabled!\n"=
);=0A=
             break;=0A=
@@ -1314,6 +1320,17 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
 =0A=
         switch (get_man(s)) {=0A=
         case MAN_WINBOND:=0A=
+            /*=0A=
+             * Winbond requires VSR WREN (0x50) prior to updating volatile=
=0A=
+             * status register bits. VSR WREN does not set WEL.=0A=
+             *=0A=
+             * Accept either standard WEL (0x06) or VSR WREN (0x50).=0A=
+             */=0A=
+            if (!s->write_enable && !s->volatile_write_enable) {=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "M25P80: Status register 2 write is disabled=
!\n");=0A=
+                break;=0A=
+            }=0A=
             s->needed_bytes =3D 1;=0A=
             s->state =3D STATE_COLLECTING_DATA;=0A=
             s->pos =3D 0;=0A=
@@ -1332,6 +1349,16 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
         s->write_enable =3D true;=0A=
         break;=0A=
 =0A=
+    case VSR_WREN:=0A=
+        switch (get_man(s)) {=0A=
+        case MAN_WINBOND:=0A=
+            s->volatile_write_enable =3D true;=0A=
+            break;=0A=
+        default:=0A=
+            break;=0A=
+        }=0A=
+        break;=0A=
+=0A=
     case RDSR:=0A=
         s->data[0] =3D (!!s->write_enable) << 1;=0A=
         s->data[0] |=3D (!!s->status_register_write_disabled) << 7;=0A=
@@ -1824,8 +1851,8 @@ static const VMStateDescription vmstate_m25p80_block_=
protect =3D {=0A=
 =0A=
 static const VMStateDescription vmstate_m25p80 =3D {=0A=
     .name =3D "m25p80",=0A=
-    .version_id =3D 0,=0A=
-    .minimum_version_id =3D 0,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
     .pre_save =3D m25p80_pre_save,=0A=
     .pre_load =3D m25p80_pre_load,=0A=
     .fields =3D (const VMStateField[]) {=0A=
@@ -1837,6 +1864,7 @@ static const VMStateDescription vmstate_m25p80 =3D {=
=0A=
         VMSTATE_UINT8(cmd_in_progress, Flash),=0A=
         VMSTATE_UINT32(cur_addr, Flash),=0A=
         VMSTATE_BOOL(write_enable, Flash),=0A=
+        VMSTATE_BOOL(volatile_write_enable, Flash),=0A=
         VMSTATE_BOOL(reset_enable, Flash),=0A=
         VMSTATE_UINT8(ear, Flash),=0A=
         VMSTATE_BOOL(four_bytes_address_mode, Flash),=0A=
-- =0A=
2.43.0=0A=

