Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011E4CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNBJ-0006fy-FL; Mon, 25 May 2026 00:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNBI-0006fV-3z; Mon, 25 May 2026 00:44:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNBG-0001o0-9N; Mon, 25 May 2026 00:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEjnz2AufEC3ya5mXsDAkTqYzOa07neJWQzXuaXHrboPHr91we116M8DV+tgD6BggM6ohURELc20vBotLzy7qG3G8YRByzRTUNeXn4snYrWOmAej4yVD3zdnXkpkh+X07OT8ViHzGvRmFZOlesVdOkwachDv5y8Q88fZ1u3uQBzWfKmJmVA1ic0XtZ8XnCQfIuXytfPTmw0JvqGNGJ5Uxg0Bv9iIodGf331Mg3622RM9nYFMcbGQdPvS4vxz1xjIaUBvoPo/L7AFMnw+iFtNImj/gQ4190gjtkwphKn8Xxf6I4hI6ogvcy1e+EgQXTwblkBFz1uAD1JVOPHWOXSnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyaGXj/b7Cvupf9SkcIirB2gaB3dYX3Zsqx38OXutvo=;
 b=DnmVWaDB9SxY9BxcAXZ2XOmTKj5PIg3ZObthk+ZxEatEJMrnWjGXlzG/US1j+rL0PGcydf19678OBsbvJ4wpXz0oDbF6y0ll+9jAzWEwOA93wiKBwqPQ+EMVQ1QvctFUzm25HpIt2HKBsSdoA9GfLHQDSIwEGR9kZyYKRfR2FgPk00vQV1QgGL1kexZjfUCClq3cGCqS36TqBUXzTlBFz0TU0w3+ur2564X8p7WvpoY/72eDTUS7UV7xvE4rRRXtzEvR86GkcOGT2Wn0FYUd9f6c50SILmzPXu/MYsX9OkdD7bkbnjOp5Z/pcZ0U3Nusoe/ohaCAyahpYzYyoyMNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyaGXj/b7Cvupf9SkcIirB2gaB3dYX3Zsqx38OXutvo=;
 b=GMagfEurlbZ5T1H2k2xWaxkT4I242m+qgg0g59fCG8KITrUhqxU99BtuxfZCUpXd3qLpvWf1jGsjCOx038Ilg2I7Ihei7ykEVa2/nPkP0Ga7puAJ8Fl5luq1Z0CluJ2Hn+ntFcm4by3URlPdDUAcl/wSItXoCf/DLibe8S7PqW9QVdCl8tdPlEpHWCEhhfwI9JEKCLpqC9wn7hUZuyST1ZJMs4L8iFpHDNP60LKClkzdw1b5s7St8kfVvL6EblRhl2cZo79sxcrOs93WKc5gjJ/7sMi+lHMG/WtrTXI3iNRl1FtDCPuU7SHTG9bmEEr1DUESPhda+ymTEvxuve5jAw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB6543.apcprd06.prod.outlook.com (2603:1096:400:474::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:44:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:44:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Kane Chen <kane_chen@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Topic: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Index: AQHc7ADBTVFYQA+5Q0qXUei6Cq1nDbYeKeNA
Date: Mon, 25 May 2026 04:44:38 +0000
Message-ID: <TYPPR06MB8206D1D6B283918E5FDC9172FC0A2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB6543:EE_
x-ms-office365-filtering-correlation-id: f53d243f-86c8-46cf-525e-08deba1853c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ONGIW+/OgzXq+P49JLOoIwoIZy5yiL4kuPABnL/2FC7W8+C5snfsWpcNec/qxLij1b9ZEHZHsEYywRNQU2kBVeq/ALePzLFWzLkEfegGW9IZ4NrlrNcdRF5MvlZgRNUIO5zHvdu2z/TFQoWdRlxGUnvvYqEIE/deN7WLodiuXm78cuRfNwJfD/G+DeXB0lf3bd/zWv7N4gKUDzH7M8ptCvZpAW+FBR0Qp0cqyV2Lwpm2Pk/fJIK+2aQOJoPHQteCUvQrZNB7QDqlQtDPUiZufnL/QD8HZiaH7TT0lZkewkmMKkR8EcooBTs+s+XYp/ki/aRHFlTm1mZ+4/WwQ7qBJ4kXexozcUOOZ/g0+dAsarRTZor1Zm+Rs6Eq05mijLc1Vp/4TZSnHQltOxp6BP1+QGPUJMt6w1iQfPZG8ZjdI5GAQca8G9HP6h/3N8nhzheKYgsk3e1c2nRZOvCnucT9zRp+WfO97qseYC9rGneJyAb+i5MjSYoPCl5Ts0g+VOTPl0r5mqg1mbegR0LLEvoobrw5elt0dIu7NoTha+0HfnJ6N7NifzT8pFymEnlwtsZTX6O/xejlZJlW3PZt3l29KwoaMOz4WUyvF17utG4rHTprzr+MrRsSMknA2iOnGdSdnIc7vXC2tu/NaWgMC589wf0EtAi2NZUz1FrkJSjLkRP1YEhLO6DdlpxtrVP9rIm6R9QqS24m22wmctBTOCrT9DjEKoxsc7v4ytzBkQaTljFU+YzfE1cBLqvkmlBkYVk1qk2dDe0ELtEy5gOxC4xb7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R/vWn+dMu2M7+iCjs3rCbbiucG5sBYYmVMAuaZturknEbNTsktTsyy3GMy?=
 =?iso-8859-1?Q?1QaIl4M2I8hixtzu1NzDQR7bcxeMScTNidxuhTpgByFFlC7gu+6d+KbUOg?=
 =?iso-8859-1?Q?92v91ZswUh3peW+iDDFr3U7UjgvXLT5gvfjczY00N4B0Ks40d8EbTaI31o?=
 =?iso-8859-1?Q?xXWnZj9MQ9p/uZx5oBgu7sIhAYewOg8RBJpwJh7CNdaCWR8CfRKB1arYa6?=
 =?iso-8859-1?Q?4/zY9IiZIAN7nNS23pCQw/3mS4rFdRI/VUWqIofTaIvG94gy8tgJCn55rH?=
 =?iso-8859-1?Q?q9I12n53YdprxzBEbrushK7o3JOcd3m7404KE3ai7K6p/9ueUF9Mu3rlaY?=
 =?iso-8859-1?Q?Eo7glHLlKQYRA5HvUAU3Pw89uaLN8nXeM+QfyePI3bmAK77zQ906zcJau5?=
 =?iso-8859-1?Q?pje/V75eyTRFO0Eb7TkZNOtwjm9TjSIeN34rj2Q3zDOe8xWG1/OkipeD2D?=
 =?iso-8859-1?Q?GGoK15MzwyZILxEXmFVocdFGts15vZERkgBbKe+xcyAkmc6O5sX2/1mvWW?=
 =?iso-8859-1?Q?uCVbYYiNEwZlGgGx6d8vn8LBPQiMkOHISFH+0+/r0ccFjml5fYmPCbS6eR?=
 =?iso-8859-1?Q?KCAR9YyQEPXvWFZXVKSFI/JzDQhfyI0xXceKMp4CC1U3g9ZnNgMWq0vgC6?=
 =?iso-8859-1?Q?iNAILXEChvNbBZUfZmdZvsqPU26hGDM9xdqJZdjOYDYlxA69UzfYA6vqIM?=
 =?iso-8859-1?Q?CxSBqGq89iKV449Er6m+P3EdNRlsx35VNE57RFKjkICP5b8F5ATJLGyQ+4?=
 =?iso-8859-1?Q?X9QDEB/364CKg3+ypVxoy4h/sGFhrDdjAvj6vREVsUwpyPYxHiOTqF4UxT?=
 =?iso-8859-1?Q?tpKKV8TJVZ9hu6Z5MVm4n2HtVXoMGz1sk2uW/l9x4bEUSO4vibqkW8oPh0?=
 =?iso-8859-1?Q?3irF+y3BcXVNlzbSlBcM/KjLToCjqwF2hYzF8DKtRqgZKrD2i+Ao84z2Xj?=
 =?iso-8859-1?Q?JHHKt6E0bAi+IZyoPIzOzeDwjp6b4WTg8FiaGu/oKJI8+FhoVs6ScvVAgy?=
 =?iso-8859-1?Q?T8FjRUSiEADITRS1I/sEGGA3TUs1QMqtRkvw1N8ZnZGZIvT6OsA+oc1r/d?=
 =?iso-8859-1?Q?3T5pzjfysSpVWn3nAo0938J7D9Hy+I3uzvjKTVWCP8BO2wvDogIk2SoKaj?=
 =?iso-8859-1?Q?c6oJcjvU8MIzvUOpxpye+/vNZcQM69WVbdy+1f9cndbOo2wvSK0PNyFSLp?=
 =?iso-8859-1?Q?s+b6jCtksmgg0aMc0uca8smc0/kvsTDJVqzhoOcKH33ERrDGcOAlXY5C5x?=
 =?iso-8859-1?Q?M/mHovY02HM1e/ZCxkoDmO3QWQfLiV9aaHb4fpKWXGWHQbA1G3SRDq7XzH?=
 =?iso-8859-1?Q?jqyJaYc8KQPxF6znv8CjeTZ/4ve/jQTJHcw1m97/DUP9OmIEtjheoQlbGw?=
 =?iso-8859-1?Q?J3Q/N+SQKN4Tbw1p9Ug4axslAPDwUWPZyHEDE368Sw1KwcF6BrMnaCRNAA?=
 =?iso-8859-1?Q?Kmtgn4gAQJRuGLont+AwTLrVEDskA5rk5o18YY7lOvl8fu7dZMa9CacqVA?=
 =?iso-8859-1?Q?1p+0dCKpDaZUs9uHBYhu8fbqzOwodEoixfOpveaezY+dzttE60fQHqAvqI?=
 =?iso-8859-1?Q?pAzfPAQvK7JO6xaDSmMFNeKnUKMCDDF6jG07+nvuKQZNAh5gKY9IDy9Fej?=
 =?iso-8859-1?Q?GsbNK1+Io58PvqIy/oR3E6aQvHWxAVxStrw7oXxq0r1nvIKNlebqI1FPW4?=
 =?iso-8859-1?Q?M6nfL9WeD+U5c1Aq1gwm61hAgSxDtILDrJ3EyOfUUr+W9d//GQxoY57vht?=
 =?iso-8859-1?Q?IGLbLj/xKdaiPI7U4mDitZ9zIJ4RnT5BDVTH2u8yPku9J1GhSsydTXUj3c?=
 =?iso-8859-1?Q?pKFCF2zdtw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X8qWpkdxDc1q5YWMMin7llAiKfj0wKwIXnloHvqEvnmrOKIdWbQBzJNpmAempjmu6P/Kd1B5Dm49s7dDfCAyy150yO0sQ92MsF1aPiFZnRXJT2ZgutMXkpF0PXFpOvY/mHBeNazTKWXHC+4mDL/MQURfKjh8FNPy6fi+caNmpWzGygH8Hjjp2U7lvJcoQVQTp5dt9VZQeJ9Ci2nYuTRJvHlLl4lHrT6IIUtU5faIEcLdGfUJ6R+Sk7kq6M884yPHM2iTmxqjuArkecVi9y8I+Px98DTGq9agSrUc55ipVGGLCpNIqMYX8RzOUOMwqGaSTCHUSVEBePlvLxZr6jPc3g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53d243f-86c8-46cf-525e-08deba1853c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:44:38.0821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQC8CpnXOUhK915e60EmPuXU14y+/qqZgPEDr/nYs+bSDr0cDdz2Qcz1zexMQ8q6/QvTD0Bfoul0YRS7V1izwedz52ao/fWPRKA98roVHsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6543
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

> Subject: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
> Resettable interface
>=20
> Hi,
>=20
> This series converts Aspeed device drivers from the legacy reset callback
> registered via device_class_set_legacy_reset() to the Resettable interfac=
e by
> setting rc->phases.hold directly.
>=20
> Best Regards,
> Kane
> ---
>=20
> Kane-Chen-AS (23):
>   hw/misc/aspeed_pwm: convert to use Resettable interface
>   hw/misc/aspeed_peci: convert to use Resettable interface
>   hw/misc/aspeed_hace: convert to use Resettable interface
>   hw/misc/aspeed_sbc: convert to use Resettable interface
>   hw/misc/aspeed_xdma: convert to use Resettable interface
>   hw/misc/aspeed_lpc: convert to use Resettable interface
>   hw/misc/aspeed_sdmc: convert to use Resettable interface
>   hw/misc/aspeed_scu: convert to use Resettable interface
>   hw/misc/aspeed_ltpi: convert to use Resettable interface
>   hw/pci-host/aspeed_pcie: convert to use Resettable interface
>   hw/timer/aspeed_timer: convert to use Resettable interface
>   hw/gpio/aspeed_gpio: convert to use Resettable interface
>   hw/sd/aspeed_sdhci: convert to use Resettable interface
>   hw/ssi/aspeed_smc: convert to use Resettable interface
>   hw/intc/aspeed_vic: convert to use Resettable interface
>   hw/intc/aspeed_intc: convert to use Resettable interface
>   hw/i3c/aspeed_i3c: convert to use Resettable interface
>   hw/watchdog/wdt_aspeed: convert to use Resettable interface
>   hw/net/ftgmac100: convert to use Resettable interface
>   hw/fsi/aspeed_apb2opb: convert to use Resettable interface
>   hw/rtc/aspeed_rtc: convert to use Resettable interface
>   hw/adc/aspeed_adc: convert to use Resettable interface
>   hw/i2c/aspeed_i2c: convert to use Resettable interface
>=20
>  hw/adc/aspeed_adc.c       |  7 ++++---
>  hw/fsi/aspeed_apb2opb.c   |  7 ++++---
>  hw/gpio/aspeed_gpio.c     |  7 ++++---
>  hw/i2c/aspeed_i2c.c       | 14 ++++++++------
>  hw/i3c/aspeed_i3c.c       |  7 ++++---
>  hw/intc/aspeed_intc.c     |  7 ++++---
>  hw/intc/aspeed_vic.c      |  7 ++++---
>  hw/misc/aspeed_hace.c     |  7 ++++---
>  hw/misc/aspeed_lpc.c      |  7 ++++---
>  hw/misc/aspeed_ltpi.c     |  7 ++++---
>  hw/misc/aspeed_peci.c     |  7 ++++---
>  hw/misc/aspeed_pwm.c      |  7 ++++---
>  hw/misc/aspeed_sbc.c      |  7 ++++---
>  hw/misc/aspeed_scu.c      | 39 ++++++++++++++++++++++-----------------
>  hw/misc/aspeed_sdmc.c     | 14 ++++++++------
>  hw/misc/aspeed_xdma.c     |  7 ++++---
>  hw/net/ftgmac100.c        | 14 ++++++++------
>  hw/pci-host/aspeed_pcie.c | 21 ++++++++++++---------
>  hw/rtc/aspeed_rtc.c       |  7 ++++---
>  hw/sd/aspeed_sdhci.c      |  7 ++++---
>  hw/ssi/aspeed_smc.c       |  7 ++++---
>  hw/timer/aspeed_timer.c   |  7 ++++---
>  hw/watchdog/wdt_aspeed.c  |  7 ++++---
>  23 files changed, 130 insertions(+), 98 deletions(-)
>=20
> --
> 2.43.0

This patch series

Reviewed-by Jamin Lin <jamin_lin@aspeedtech.com>

Thanks,
Jamin

