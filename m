Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07270C369A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 02:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2hiV-0000O7-VV; Wed, 09 Apr 2025 22:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u2hiT-0000Nq-8U; Wed, 09 Apr 2025 22:32:33 -0400
Received: from mail-psaapc01on2072c.outbound.protection.outlook.com
 ([2a01:111:f403:200e::72c]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u2hiP-0002O7-Jx; Wed, 09 Apr 2025 22:32:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvPHhh4WhXBQTmXCsWOFUBAF0aTw5R41UIOQZyj7amCjd/oRsJDNol+8eQnMsW02y/RtfcfCr1WtxZ4xxgPwpmaAVPyoW56Wi2HFQyZxKz9NdctMIfdMxGlou0wraxNIYRiSIVfyl3+Z/te/D3c9rV0HcCbK7cjSVdStLRCIQxuq9DOg0t2B05cpJlrqjbOgsdQfOJ/UYKTWoLvLk8llXpM9UcKgWkgem3wGg++TaifQtNZLhtyaB2CERPJQwWx5w+Rrl/4Fk6aI9c5YB5S4eTYDxllMRrqWgYZW7tYBdXUwi8dG/obVK6gw5+J8LgdZoULXhr3u0MjTG8rRpQSxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4hwuxSTgGxuFLH4y304fnmomGBgs/Va1mIpvjzRYyU=;
 b=GjmTWOnLHJQPGXwCmW2qWnFTfA5h2aGBlSEzZmrxaGLAfTNzTz3VO0MH8iUS/iQwcax6aq/tix6yxUTKqs8uQfe45JAvv2TO1T0v57L3f6bxaKumetyOKQap6Xmgozs41hn9fGWu94Rg/46JjeaFW9nxYrC3r5MWjhEQIqLnQOfjc/iNSYn78EjjD0cMu3eX1XKTJU6iABXtLtdBJ4W1tQevcQbGayatJ6SeBYr5TnthX+jq3RBa4z3J9pE1FICYpMdxdlW7Ge2sKIEE7Viyko+zzPwNwMnw/KYGlKpNPv5+n6JKbRatbiqgacSX2QElvaOyVC1mEz+G5d6jkGqlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4hwuxSTgGxuFLH4y304fnmomGBgs/Va1mIpvjzRYyU=;
 b=Wa/NOS98sTDE/g0vMmN37waOfWRY9kf5HbTFACjWyaOL+KpCPCcwUeBgdynI+tr8trq17wiYkFzMHb2w8BgU7+36uoFKnxOeoKjhhItGa0N9J4FAfoOBu6P7ugwFwCTv1+8ZYYMUrjXm4RqdMShVdXgO/6tlpZyLwGelk8ifkBoAkpqgajJi2Q1kJKc3PeOnX2lUlli6JpJtcwj/ozaXgTlA/ijiyKMMYy6eV916SLwusTMS57Ul19S19vNgp7tCc0y254y9zUTDFKznRtkYso8udVCSiy2R0QqYtgjECqHA4joqECBcNC/QDem60kBEnmpISmK7ty1vGtfDJKgevg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB7030.apcprd06.prod.outlook.com (2603:1096:990:6d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.31; Thu, 10 Apr 2025 02:32:20 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 02:32:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 0/9] Support vbootrom for AST2700
Thread-Topic: [PATCH v1 0/9] Support vbootrom for AST2700
Thread-Index: AQHbqTaymNAGMPVtbUWMF2kInkR/tLOcLo3g
Date: Thu, 10 Apr 2025 02:32:20 +0000
Message-ID: <SI2PR06MB50410ED73D611FD1A669713BFCB72@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250409100039.2391847-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20250409100039.2391847-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB7030:EE_
x-ms-office365-filtering-correlation-id: 10f88f31-3c51-4815-6d1c-08dd77d7eb07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cGb31Yc23d3CSoen9H9GlqXzPaMtINJnK0ajFvrScZYwDHOgFwxP0DF8gG?=
 =?iso-8859-1?Q?fuXgNrADhhgxz2vqoIdjt+x7Aj+BREbjyCJZiHkasfyjX7aSNgBFoa2oko?=
 =?iso-8859-1?Q?oz7EJhw5XJ7/QBuRIoeZXWDiDOTH3QarCqWjcLOjPdCxFIegtOanRF/0QX?=
 =?iso-8859-1?Q?1mrrn7j61jyG5ziWuZF1ZHK+ntZy8UWtLmizdfzcfSITnEywu97Nk2mawU?=
 =?iso-8859-1?Q?vPl1Wbo1JMilGD7Ygu7kp/PordQyGAaC8i1UBm99aKn0KyOaQ2D50BIPM2?=
 =?iso-8859-1?Q?IaHylWnJrx6M2TISxeZ5hx70c1VJDT+Tgp0jAGIyuwaa0ILCNzv9KOEUyN?=
 =?iso-8859-1?Q?hSEKD8vV7oMrlewcXdi/4TIvoduB5QSaUsRBVfw6kyTROYgr0KCHgirNDJ?=
 =?iso-8859-1?Q?WGT0NhvzM2LQ2tbnc0yHoYs8M8vx6G5rlrsUSGDhu5YPtowkXmbTvtWtyU?=
 =?iso-8859-1?Q?x6o8qfzwnROuAdlFoF5Ong0OS+t2/qd88N/NrvF7wgrBY3vGdwEXa4La0U?=
 =?iso-8859-1?Q?I6ZYX0mD6TyaZBg4JTQ05KZGrfHzxBc3taIIWD5Q1yakdXguSPH9TVzHbQ?=
 =?iso-8859-1?Q?+uXtgyh6y2ZQS+nhSxyD+RvG08hIKygQtC1YRjDJ+Y7d2B3zKfccbzA5lZ?=
 =?iso-8859-1?Q?2RoT//W/DBYb8+NNEMkRZcWPEnDr1dS7V+ylnNJadTSGPMTmHFzW+dvEZ8?=
 =?iso-8859-1?Q?TjAh8WfAWQ/HGpN8AXvNax71QNrNe456ppyR7XXWrpOWnIBtLuAslkTonS?=
 =?iso-8859-1?Q?gdOJDBKjAoB9Rn0pzIdXFRxjsiprpqb0NG3t082SyEKDwXgROMHqo9thYk?=
 =?iso-8859-1?Q?0JiOfURbPawVLP1RfuB9QXp3k8nTT8AJ6pq3dyMcpckDIj/48rehZBJJgr?=
 =?iso-8859-1?Q?5/yNReKQZU4+USiE/0+iWYyfRrmAsBc0hndPUvXxPkKt9jCEe6FhLI1yi7?=
 =?iso-8859-1?Q?66YWTRueb29052Oudtrba9BwNxAfKD85EmbrqyC9WggS7VnH/ymoGZbvSx?=
 =?iso-8859-1?Q?r5zXd+zFjIaS6Jq9b7ylAntpl6WVIOtyEyMi9NApC15QfVPCn64XVASeJO?=
 =?iso-8859-1?Q?p6OAjaMiccQaWUgEI6/lZ53Ti9Vadkol9xUO2bphgGHpKvYhQQIWRpqGwr?=
 =?iso-8859-1?Q?QuQd/H0kuO6epwkpFKp4nZJ/6E0MWQZYqCJ1VEtwTB7E7gZ+F2yLCS7c5l?=
 =?iso-8859-1?Q?pB9IOgC15hW2jvuN2808rYvCxgloCaO6tBq/2wGEno8FtyeR28fCd6RcRK?=
 =?iso-8859-1?Q?Wb/zpnZcknK9427TJ4wcjcEKTUVemAbcI/u3yUhOu6p1Ms/2e2ep/Q68y8?=
 =?iso-8859-1?Q?yorbKfNHoMELvUDE0U5etVbiUgmr9nhG4q8MDuy2Av7PpZjz4+VCvAQMkQ?=
 =?iso-8859-1?Q?T9GEBy+cHxDIshIKPYivgkr+8yrOcQZ1zYFWQ4SIKuPFR869I0GpbnvEqf?=
 =?iso-8859-1?Q?PvYJBNLpWtMYqXHQ+PLEl4vh48lbGcLlMUoqWbLusX12KL+1Gv/l8EYxeY?=
 =?iso-8859-1?Q?04r2jE/U92XXuXrwU4cs93VSgBZmZZsXM/N1e7HdMLsaLM6TP5cDjwIP82?=
 =?iso-8859-1?Q?hd+bnHw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UXq7XZkri5vPDdR0jxgn3xIi+XyMXHBrqG6dsgB92zZ/jySdg4EsajBrOY?=
 =?iso-8859-1?Q?NF7yVuTezS5Vnhv986WtatJDkji+SWoImlAiVKkPtqNiPcZRHm6n6pIj4B?=
 =?iso-8859-1?Q?Rk9xjNLRjDdi5zqLNlhj1JoaJYiiH4OcyxsOYzwWNaCnAZ/A/APp9y7Wza?=
 =?iso-8859-1?Q?5B6yFHjnaSzgOP5996Clb0nHoFrLYSJGgfvcqAJGJlDtjP5H3oVxID5sQh?=
 =?iso-8859-1?Q?WE+HRnDQtVeuVe77pUlivsYfuycuhevMZRB3cGONH0RT4KZJ33zKFJhPzR?=
 =?iso-8859-1?Q?zYDRUYM3og5cIUmzpjpwAZ/awJ9dDrghcKVoWBg/7HvSeShMIi9zhmyLBt?=
 =?iso-8859-1?Q?ApdqzaHvqbHuTn3w3LyXYHo5zpPVBXFfYpBzEpFbi3jvoaqvtfUBOqElVu?=
 =?iso-8859-1?Q?5QHwC2MWoriDGnBOmFwcNP2B8ZSPCOF9ezeetZ8KSyBuvxhSgTddIgxjs2?=
 =?iso-8859-1?Q?2rg7UL+9kHKqoJZofBIQ0VazfrLGRwYNcVAcekfhSGlTdNjZWIpquVgvaM?=
 =?iso-8859-1?Q?68BbPNwX7/pD16gv7zCA+p7XNcYtmJjZZXsq+4kCzKLKu78ApWTJpNRXnk?=
 =?iso-8859-1?Q?QpuNXNbRqL1SbQ5r+tky8A+67JlG9y8x5XOpsfAOHYBxOvrW0xjxwDdNdQ?=
 =?iso-8859-1?Q?6UBmDiwpDbfj4JdAH4n7hM+Cm/oBWdTUPBvBWL1/M3imp9f0N8GX3pJb4f?=
 =?iso-8859-1?Q?jhUDGED705FwYf0LyoL+pUpPoFt6HpF2GL3vuSrS58eEcQ952aO57i0bOK?=
 =?iso-8859-1?Q?LRdabRADQEO+0XvOriZoJfGLFkFZ9oh6CR9XIyo3YPR5dqKqJjmwq8nEC8?=
 =?iso-8859-1?Q?Bw6iF7JcDg6EfJf+iqWj952gjopPyXMdRgkqT5Iez2kSE3wCzjJcOYOchb?=
 =?iso-8859-1?Q?phT5ubwMfjgYMyiwf+cQbAsvT/hZqKsAIMfS9iPecn62ldrA7OPxNtstfj?=
 =?iso-8859-1?Q?8yOifHtCL2DEuuHLylT74L+wM7JxCj5ZaZRAEeuXll+rQ0DWa/BjKVe360?=
 =?iso-8859-1?Q?MkV5JEybsWdlVqz0omduM1IUYTnAgcm/mV0kMi/h0JXEzyFY0HMhElxeN7?=
 =?iso-8859-1?Q?NTQpkkxXhlF/Fphl8ybMEAyAEPXmtV2OB+Tv9F4dF0MYJXUHzgPLIxbQ4i?=
 =?iso-8859-1?Q?AUKPPXLsbXdhAnkWssX5oj/JJrzdXWFkwRvUzNQOA0w3xfrni8xlLosl1F?=
 =?iso-8859-1?Q?UgUSfff3bGwlubyUP80hmSAAIAzDDtOoBuJJLABNkK7/QArCrm7gOwDw6Q?=
 =?iso-8859-1?Q?E0jPbT1vVAOXk9CtLm8SBgF51HL3LyN0CoX3x19dbcapGYEr5BWJns2XXm?=
 =?iso-8859-1?Q?9uX9XcMoZgujPjLzVlJWzZrjpOKKdsx8m8xppySiepGU7QhsMc/m99FYFu?=
 =?iso-8859-1?Q?WblbcgD5PNiWSoNOO2LEcWzNmHEECbuJwreCcy9nmyqVi5wSGpRuliW087?=
 =?iso-8859-1?Q?GmJ/jOPi/mQhei/lqHlqZyffXW5quVqU6O85YLVkzeZPIpFlSFpwQUypRj?=
 =?iso-8859-1?Q?0UMDHmsC/NOiLTZYN+W0v2kvKAgyUKIevpaEDeRoJQyNk1065nma6cQnpc?=
 =?iso-8859-1?Q?fRV2GwcZILQNeHMjtFFvNif5QTRpR61nv9WyATOkmru0sqen/JKmgdniEt?=
 =?iso-8859-1?Q?5dvo7CEGP435XT0sEAeV2SBBJxxPZnBDy7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f88f31-3c51-4815-6d1c-08dd77d7eb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 02:32:20.1210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/ANmKP6vQo7tBWx3OQJ2pJar69wW6UnnCYKixPDJNhWg+A2zzX0u7diEb0k75EL38DwS2NIBg4XitVoQiqjjuLq1YuHtlaD3FsKqFdj+w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7030
Received-SPF: pass client-ip=2a01:111:f403:200e::72c;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

Hi all,=20

> Subject: [PATCH v1 0/9] Support vbootrom for AST2700
>=20
> v1:
>   Add initial support for AST27x0
>   The purpose of vbootrom here is to simulate the work of BootMCU SPL
> (riscv)
>   in AST2700, because QEMU doesn't support heterogenous architecture yet.
>=20
>   ast27x0_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
>   ASPEED AST27x0 BMC SOC. It currently implements the bare minimum to
>   load, parse, initialize and run boot images stored in SPI flash, but ma=
y grow
>   more features over time as needed. The source code is available at:
>   https://github.com/google/vbootrom
>=20

This patch series failed to build because I missed including one patch.
I will resend the series as v2.
Sorry for the inconvenience.

Jamin

> Jamin Lin (9):
>   hw/arm/aspeed_ast27x0: Add "vbootrom_size" field to AspeedSoCClass
>   hw/arm/aspeed_ast27x0: Rename variable sram_name to name in ast2700
>     realize
>   hw/arm/aspeed_ast27x0 Introduce vbootrom memory region
>   hw/arm/aspeed: Enable vbootrom support by default on AST2700 EVB
>     machines
>   hw/arm/aspeed: Reuse rom_size variable for vbootrom setup
>   hw/arm/aspeed: Add support for loading vbootrom image via "-bios"
>   pc-bios: Add AST27x0 vBootrom
>   tests/functional/aspeed: Update AST2700 functional test to use
>     vbootrom
>   docs/system/arm/aspeed: Support vbootrom for AST2700
>=20
>  MAINTAINERS                             |   1 +
>  docs/system/arm/aspeed.rst              |  18 +++--------
>  include/hw/arm/aspeed.h                 |   1 +
>  include/hw/arm/aspeed_soc.h             |   2 ++
>  hw/arm/aspeed.c                         |  37
> ++++++++++++++++++++++-
>  hw/arm/aspeed_ast27x0.c                 |  20 ++++++++++---
>  pc-bios/README                          |   6 ++++
>  pc-bios/ast27x0_bootrom.bin             | Bin 0 -> 15464 bytes
>  pc-bios/meson.build                     |   1 +
>  tests/functional/test_aarch64_aspeed.py |  38 +-----------------------
>  10 files changed, 68 insertions(+), 56 deletions(-)  create mode 100644
> pc-bios/ast27x0_bootrom.bin
>=20
> --
> 2.43.0
>=20


