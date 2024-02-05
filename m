Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC454C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvRq-00021a-6V; Mon, 05 Feb 2024 04:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rWvRo-00021H-2y; Mon, 05 Feb 2024 04:39:28 -0500
Received: from mail-southeastasiaazon11020002.outbound.protection.outlook.com
 ([52.101.133.2] helo=SG2PR03CU006.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rWvRe-0004De-FW; Mon, 05 Feb 2024 04:39:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdwNckVN7Qo9Sss2IOa6DG9qq98C/aVh0UCd47G3CNIxzc7WdseENaa822aKU+wyJsTTgk4h1ItX8v3eMR1CpRoht6bzza/jBJf5sGbyMhAuvtk8Dqb0UC1NS4Qg7he9VNtL4X9b4VDnWbdXOD5YPymg8/5j3YXSd9OwcJId6GoW2uL5+zCzEppY/AKPoo765j8k36H8PUbiucAB7ZYJ74iFT7nG7grnatu1fnisvi3qH6x0SpWU2DU3drZGO82jT8LtM0Et6vnYlwWYXPqsquwVSLHY0gnGEXIaP9ZfZbwrIzgsxI5jkm0lUgrQMnYJEyPHqcPLqrK7ZDOocUhMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G0573CRaxDF5PzwAeLQOyFRyp6Z0Jdi5UhIemW9qvk=;
 b=IVjjl+bEtV9lXk/3ZA3USoIzYQ+HMXFbdu3Y585he0wI1UuhtVOKNecfEPDrTD+oAo9hh6FTIjrpITZ6rWmWnLgABwYCHS/47UYpD3jN8c03T0SfuLdqkXoPCmNu0DKlIaUb+Os9cgUmyjgVnl4xZI6HBVdhUWJ+RzPfOCh3XCggBXF1z1SaQJ1AqifI5XZZjgh9zULdx7d9f2O/AFgqyxZJXrv0cxI1xWMipMOJZfWSRow7L/9ABADq/Us6iZWqh5LgtOaPgArsIKnhlIAQmJh4mhiEFcpdoytdrbta09iUoxoEB2WANrl8jIusxW2DvSPt1LxzCei+nFaTrqq0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G0573CRaxDF5PzwAeLQOyFRyp6Z0Jdi5UhIemW9qvk=;
 b=VSBgshAVEzKRC6OAeMGGhmxhdPO2TV1RwGPdwDFId6Ctad/FHm1Cuf1xEtfHBDxRwMEV+S195wPGmiCo67rWmoKkd3jX6KsCOA41U+7bhza+tM8D6ZmcuVGQ4uW1wOTAQOhlTWvQd3E75KQ8ThbG0G515ZmC8ZpIDyA6q+qfxVF3vTKUWAp/CwHN6NgZLIP+4/5D62dBE9y3Cp2jdHp69BblSV5V+kIkL24VDLhd6Xj4v+dEgO6UKZ+XqxWDZRsiIZt9aDTUxMk8T5YooPvK/Q2Vnkv1Fot20Rmdl5phTUhf3I9efaPh4Pp5z0IwnnJ+Ls/bQRHzzkng15gZVnXAMQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB4127.apcprd06.prod.outlook.com (2603:1096:400:6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.34; Mon, 5 Feb 2024 09:38:06 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 09:38:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v0] aspeed: support uart controller both 0 and 1 base
Thread-Topic: [PATCH v0] aspeed: support uart controller both 0 and 1 base
Thread-Index: AQHaWAvXQO1274e1K0yFSK+fur9+t7D7fbSg
Date: Mon, 5 Feb 2024 09:38:06 +0000
Message-ID: <SI2PR06MB50413C107EBCB5E9F257C8BDFC472@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205081757.304433-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20240205081757.304433-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB4127:EE_
x-ms-office365-filtering-correlation-id: 91566207-85e5-4e5c-6bbc-08dc262e2828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ClawxROUxKo7/Z+PLAMbEj4fYZiu3QrMQ1wWUFFameCwGJRkjuuHyGt4ybPqBYiF3xwWfneJy1022f+wtEgNGhAe19omACSAt5sDtYM2ELlob7wBRzQtI+PHmZ4mImUmoPkgCbRvXqM7YNotLEyoLuludMczpBxzQ9l6wy3TW5drqBO3aD+sG9Pn7iUbPbnEbGI4JRGDB2E1ZieY5FAbzyZAEyanolTeCkiofv7hp2zcqVph5x8mhGiMxmIRb9ZPfx/LUUdohqai9IY5WCrWSXC7CZIY/hstNwDKvNpEJgKye8MUl2I1eaJDSA9LNu1WBJ5peFe5Qd5TIzoHpAqkql0iUuEnkUkutqSab7+D/nlXZeoUxfCS8eljD6GvtwFcThZZ2zRdktoaJg+Xj2nJ7IK7iE+rmEkmWrlN51jLoikb75J9X0MSLmiaB6AHB/cGrQykkNz+SeaBcVX8apUXmTHiZd7Ve3yqTOXIh+gpw9va2WEEeJfdT8OgmL2z+W9bNCgQchKf7tUTMr/S5U+uLcD169S6Dlm0Z+0/N/WbEd55mVJdJywEa+Jkwv/cg8O8/d4JCxoyO8FoIZxSIgMvig/ZAZ4YQprMlQgxw8pXlFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(76116006)(38070700009)(2906002)(110136005)(107886003)(66556008)(71200400001)(66946007)(9686003)(7696005)(6506007)(478600001)(966005)(53546011)(66476007)(64756008)(66446008)(86362001)(52536014)(5660300002)(83380400001)(316002)(8676002)(4326008)(26005)(33656002)(8936002)(38100700002)(122000001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3ALIk42skx44Bq8GnNlYoh/R2Z/ujG4fRe4mVrq+ov40WyzEBcGTl6Gb+Y?=
 =?iso-8859-1?Q?hwkpXDKcHoJfxm8rnOdAWMVu0YHgPhYRVSDIypaG8U/mn0VY2ofbp3Wt0I?=
 =?iso-8859-1?Q?6WdVAWAULHUahRzs8gFsS1+jz8YKO+lMq9flsi2CLgYO5pgKUbDsjVw5g8?=
 =?iso-8859-1?Q?OX1ojzHY6F9i3VFct9UebRB3rsfmlChYvK6eNZa0Bw/GHUSqU27+ZJ4iVK?=
 =?iso-8859-1?Q?K4yq8eiE4Z2ybDy+w+ELUMah8voJdpZBSYfVum+XHJu9SoX0dj90AjWjBV?=
 =?iso-8859-1?Q?86nlySdwszeaIAkFvklD16m7pHJTReHArvmeXcYom+VwEWd5uSDArYOpih?=
 =?iso-8859-1?Q?D9rH1chOuIDbBihxYV11zJ79o9SrTGxU0dYisKtiokx7RvY3FQl+amNdmn?=
 =?iso-8859-1?Q?2JzRm+s2TUU9sCSooOnvhnczhf7gcAnpqyeGLX5NkXJpB3Hq8gAkAg0ucJ?=
 =?iso-8859-1?Q?FoUruqapZkjvfWHGYVq52E/w5bUZ13sgqHIzYks8pidODxK3cV/HJyO7oN?=
 =?iso-8859-1?Q?YadNRsUPE+Hd+rDjyyIsz+ygIv0588QtXn1jle0IQv9w/GufmN/HlF3PNc?=
 =?iso-8859-1?Q?QhMcFAVm4TZXvIbA7fWGm4HiIooSuPNd4w18vCiGr/wBoGz/8FUaYOYDNQ?=
 =?iso-8859-1?Q?SKFPKCG9e9aCYupFdMNZfmeL6SPbMfYan0IJq0aNT1d9qpwC1u47sWoRZP?=
 =?iso-8859-1?Q?o+dUGJASQvf08zAmiBoAOSbpFBWnYNWyhXygrtam9TRMzyO8iM3iXVOXNF?=
 =?iso-8859-1?Q?Ly9CKDtIABq+wlRx1U+x0HKByYRl0CM0pdkcPxOBAR27EO+FBU9DHCOMjs?=
 =?iso-8859-1?Q?+byrlgB5l69HMGqhFMvNRAcngbNbMcobUhQkjpEaHXpVQjIFD4WH64nmM8?=
 =?iso-8859-1?Q?3nHc0NfyDMIY54DR7xhkH8Aycvxk2YVOkbdmRe00AODpXXAMRt/EWLlSuy?=
 =?iso-8859-1?Q?Y97Nu0G9WrUpRtWuX5Y72ZcMK4Sr9di73SuOopqiMTlHxsxOk8pGGpLbv4?=
 =?iso-8859-1?Q?7bCQBtYWS4PlXGtcAJG7NRAicmkW1Svb9XLUpCd35u+UW8TgvFQ8VN7JKx?=
 =?iso-8859-1?Q?3mzXO3w4wFsLaR7rv/x4XE3AkLB9TkR5C9XT2vUqk6idMm+Vn8ZQAL3GCl?=
 =?iso-8859-1?Q?HMPqKiX6G5qaWe4VK5M4fbeAHMRnXNKxctzLd2ve6ev4maCj01wPywNrHp?=
 =?iso-8859-1?Q?Q5hjWV+ACJiU7MFJwGNzWOSqjUUzl/HeGw/p2YWPZWBla/IFCkEQImEp36?=
 =?iso-8859-1?Q?2VQLuYKwWacL71fU4DiLC2Nl/3oh9VGb0tFCxwernRqlPmiEaJNnVErmNE?=
 =?iso-8859-1?Q?1EljEgTgEu/SymBjuAGE1ZLA+8+AS9NbLMb0uumrLok5hui1u36w+XnZ/r?=
 =?iso-8859-1?Q?/aFWa0dn3IzHl6OOy5zF7F1wXcrtdLrWJVZVW6pX8XCje8d9TOGGs+Pdnh?=
 =?iso-8859-1?Q?q3A3fhiVnLnaYjDO6YIGTkx7tY9CSKneSpemtlrwQSObi8IcvVcysmHo9k?=
 =?iso-8859-1?Q?2zhy3S2gM/2euNGoWdjO6TTO7eeCGu72R4ZyNcNouE6P3v662jLK+Os5Fq?=
 =?iso-8859-1?Q?6+wvZH1rAYfbO1lzrrEkqcm/SHqAV+DikwZoB8/zJSd8zxsm4ex+z5j/P7?=
 =?iso-8859-1?Q?q9A1JAiJ+diETzzUSl1Zj9V0R6JKZKeTeV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91566207-85e5-4e5c-6bbc-08dc262e2828
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 09:38:06.3767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcjT6Vh4UWV73SUr8mlzd5clK670fzCiXniY0YyrCzE8VpQWQrMkcRlLKr+BMKa20ZNdhYRTUTgmrpGOZHzoKLzmh+oRMQ9A1MOFiTaoK2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4127
Received-SPF: pass client-ip=52.101.133.2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SG2PR03CU006.outbound.protection.outlook.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=2.881,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Monday, February 5, 2024 4:18 PM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Andrew Jeffery <andrew@codeconstruct.com.au>;
> Joel Stanley <joel@jms.id.au>; open list:ASPEED BMCs
> <qemu-arm@nongnu.org>; open list:All patches CC here
> <qemu-devel@nongnu.org>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Jamin Lin
> <jamin_lin@aspeedtech.com>
> Subject: [PATCH v0] aspeed: support uart controller both 0 and 1 base
>=20
> According to the design of ASPEED SOCS, the uart controller is 1 base for
> ast10x0, ast2600, ast2500 and ast2400.
>=20
> However, the uart controller is 0 base for ast2700.
> To support uart controller both 0 and 1 base, adds uasrt_bases parameter =
in
> AspeedSoCClass and set the default uart controller 1 base for ast10x0,
> astt2600, ast2500 and ast2400.
>=20
> From datasheet description
> ast2700:
> Base Address of UART0 =3D 0x14c33000
> ast1030:
> Base Address of UART1 =3D 0x7e783000
> ast2600:
> Base Address of UART1 =3D 0x1E78 3000
> ast2500:
> Base Address of UART1 =3D 0x1E78 3000
>=20
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/arm/aspeed.c             | 8 +++++---
>  hw/arm/aspeed_ast10x0.c     | 1 +
>  hw/arm/aspeed_ast2400.c     | 2 ++
>  hw/arm/aspeed_ast2600.c     | 1 +
>  hw/arm/aspeed_soc_common.c  | 4 ++--
>  include/hw/arm/aspeed_soc.h | 1 +
>  6 files changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
> 09b1e823ba..218b81298e 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -342,7 +342,7 @@ static void
> connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>      int uart_chosen =3D bmc->uart_chosen ? bmc->uart_chosen :
> amc->uart_default;
>=20
>      aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
> -    for (int i =3D 1, uart =3D ASPEED_DEV_UART1; i < sc->uarts_num; i++,=
 uart++)
> {
> +    for (int i =3D 1, uart =3D sc->uarts_base; i < sc->uarts_num; i++,
> + uart++) {
>          if (uart =3D=3D uart_chosen) {
>              continue;
>          }
> @@ -1092,9 +1092,11 @@ static char *aspeed_get_bmc_console(Object *obj,
> Error **errp)  {
>      AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
>      AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(bmc);
> +    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(obj);
> +
>      int uart_chosen =3D bmc->uart_chosen ? bmc->uart_chosen :
> amc->uart_default;
>=20
> -    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 +
> 1);
> +    return g_strdup_printf("uart%d", uart_chosen - sc->uarts_base + 1);
>  }
>=20
>  static void aspeed_set_bmc_console(Object *obj, const char *value, Error
> **errp) @@ -1114,7 +1116,7 @@ static void aspeed_set_bmc_console(Object
> *obj, const char *value, Error **errp)
>          error_setg(errp, "\"uart\" should be in range [1 - %d]",
> sc->uarts_num);
>          return;
>      }
> -    bmc->uart_chosen =3D ASPEED_DEV_UART1 + val - 1;
> +    bmc->uart_chosen =3D sc->uarts_base + val - 1;
>  }
>=20
>  static void aspeed_machine_class_props_init(ObjectClass *oc) diff --git
> a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c index
> c3b5116a6a..2634e0f654 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -436,6 +436,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass
> *klass, void *data)
>      sc->wdts_num =3D 4;
>      sc->macs_num =3D 1;
>      sc->uarts_num =3D 13;
> +    sc->uarts_base =3D ASPEED_DEV_UART1;
>      sc->irqmap =3D aspeed_soc_ast1030_irqmap;
>      sc->memmap =3D aspeed_soc_ast1030_memmap;
>      sc->num_cpus =3D 1;
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c index
> 8829561bb6..95da85fee0 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -523,6 +523,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass
> *oc, void *data)
>      sc->wdts_num     =3D 2;
>      sc->macs_num     =3D 2;
>      sc->uarts_num    =3D 5;
> +    sc->uarts_base   =3D ASPEED_DEV_UART1;
>      sc->irqmap       =3D aspeed_soc_ast2400_irqmap;
>      sc->memmap       =3D aspeed_soc_ast2400_memmap;
>      sc->num_cpus     =3D 1;
> @@ -551,6 +552,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass
> *oc, void *data)
>      sc->wdts_num     =3D 3;
>      sc->macs_num     =3D 2;
>      sc->uarts_num    =3D 5;
> +    sc->uarts_base   =3D ASPEED_DEV_UART1;
>      sc->irqmap       =3D aspeed_soc_ast2500_irqmap;
>      sc->memmap       =3D aspeed_soc_ast2500_memmap;
>      sc->num_cpus     =3D 1;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c index
> 4ee32ea99d..f74561ecdc 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -666,6 +666,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass
> *oc, void *data)
>      sc->wdts_num     =3D 4;
>      sc->macs_num     =3D 4;
>      sc->uarts_num    =3D 13;
> +    sc->uarts_base   =3D ASPEED_DEV_UART1;
>      sc->irqmap       =3D aspeed_soc_ast2600_irqmap;
>      sc->memmap       =3D aspeed_soc_ast2600_memmap;
>      sc->num_cpus     =3D 2;
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 123a0c432c..3963436c3a 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -36,7 +36,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error
> **errp)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      SerialMM *smm;
>=20
> -    for (int i =3D 0, uart =3D ASPEED_DEV_UART1; i < sc->uarts_num; i++,=
 uart++)
> {
> +    for (int i =3D 0, uart =3D sc->uarts_base; i < sc->uarts_num; i++,
> + uart++) {
>          smm =3D &s->uart[i];
>=20
>          /* Chardev property is set by the machine. */ @@ -58,7 +58,7 @@
> bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)  void
> aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)  {
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
> -    int i =3D dev - ASPEED_DEV_UART1;
> +    int i =3D dev - sc->uarts_base;
>=20
>      g_assert(0 <=3D i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
>      qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr); diff --git
> a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h index
> 9d0af84a8c..ce2bb51682 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -140,6 +140,7 @@ struct AspeedSoCClass {
>      int wdts_num;
>      int macs_num;
>      int uarts_num;
> +    int uarts_base;
>      const int *irqmap;
>      const hwaddr *memmap;
>      uint32_t num_cpus;
> --
> 2.34.1

Please drop this patch, I created a new patch series here, https://patchwor=
k.kernel.org/project/qemu-devel/list/?series=3D823082=20
Thanks-Jamin


