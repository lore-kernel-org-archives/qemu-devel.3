Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580E5C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 01:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thIt6-0001Vg-D1; Sun, 09 Feb 2025 20:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1thIt2-0001VN-H0; Sun, 09 Feb 2025 20:47:00 -0500
Received: from mail-psaapc01on20720.outbound.protection.outlook.com
 ([2a01:111:f403:200e::720]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1thIt0-00008A-CP; Sun, 09 Feb 2025 20:47:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ6D9mM/KBDzMt17gn5Yhf8otYQVsAXuCX22Mwv/b0nNizIU751hXjfGDT5GYU/9ZhgUBY/HedFYvLgDfJotqIPHDO0DvXNZ+S6jqgmVxnn+o5qnecHF0VoKOV1RqzemYj8bUW1WKxjTCyJqdzy2EsQbAzorlhZYPdq5xpcGrx/zFTye1MVdCzmbtinGICPq6LflFGVng8Pn+W+7oHDEDbpE18b5k5A1ihWqLyzZR0uwrYubsw9kPAsxyylRXCGMsViFQrvAggsTwnJigmel8oCDtQaHtPfVwoQB9/6n74ISIAPR9XxKKUtMB0NQeQMm3CX873g+0hwSkUGdBbKEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KDmGjnY5tDUyuTpkREjJ91nqB2HdhyUMgQMccO95tM=;
 b=LY39N2WdWuy8ClieyL0PoMTJ03UhbxwESid5fnZ6MtAMezk9aIufFS/8Dj4kwRkXCw1TAFQeO/cxVc8YnlLWVQAX3dz9y+/kfCMcgaM7zNBhZGBkyJZhod84sOmz0XlYe4/DyEYQCZtfViKk7B0+Z97abkEJ/HMzys0UJFAjDV40NeT8QXEgwYP1finL5X+46W6HlcLem3iLG7gicd3cvZ2VZlL7IWMWZLVIwcJMxtUvwQeWTfPSWBEOM0vsGlOgTw5X2Tfiff8M/Ynb0hJegUJSTUv4hVVBiDfp7dAmnLYZ6oNbETMQlUIqr7CpcnB4igtdej3YB66AaXKbtwHTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KDmGjnY5tDUyuTpkREjJ91nqB2HdhyUMgQMccO95tM=;
 b=XwPwpb0DzlLW4//Owqjn7F/bVlv3CsaoxLO+64gAs6q7ueS7e22NRiZQxtd8a1Nmgr3RPSdqVg694cKzZVEcR5uDM57Bo76Eo6ElFZmJdrmvKlplb4f3QWIketF7oYK2pvMoeK7iGQC7LrGtJwkF2YDCfFN8Snci1lzuBMMRGCjLdDgM6r/UhbbBD6/aLEMBY1Ab5Xx0M2a42jqLoQxwuSrG0/Sge3D3RzwkFVpDfYAkaMKGZp2ktqlfq6pkKaOf1p+0+4228PAplKHu3vXTb9Nu+EXVrnPon4G/avVQLHZJflwNuLpLD7j/jQ9sn275FYTL3KekgJGOKtX64zrpww==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6033.apcprd06.prod.outlook.com (2603:1096:101:d7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.7; Mon, 10 Feb 2025 01:46:42 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8445.007; Mon, 10 Feb 2025
 01:46:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 0/6] INTC model cleanup
Thread-Topic: [PATCH v2 0/6] INTC model cleanup
Thread-Index: AQHbeHzmbyJCliZYDUml1UTgRgEefbM/yNKw
Date: Mon, 10 Feb 2025 01:46:41 +0000
Message-ID: <SI2PR06MB504118C85E9C5FFEADB3274FFCF22@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250206095253.928308-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20250206095253.928308-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6033:EE_
x-ms-office365-filtering-correlation-id: af9bc201-d5fe-4bdf-1ed5-08dd4974c477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?j4StuIUoqD2MiyVS6oxlsYabYULEMJYXoAclz3io5KSPzwwvAI8RawKBm4?=
 =?iso-8859-1?Q?ryBa+aWb7zjT9C8NnR4HfLpvzYaRG6DuJGNSzwWjRqAwHmMpoudxsNLBW/?=
 =?iso-8859-1?Q?wB5xjfHlrY1gFA/NdayUTB8X1lAXFFfwWfZYTOUIKSN7MUOA/sEH+EZ6cB?=
 =?iso-8859-1?Q?LKYWVnhy2BhRc6ZkM/csOk4fGYjHeAUKGh7N2qlXZko4bW8tURUpImmaVB?=
 =?iso-8859-1?Q?5f/BUc2Ksiy8Um8zZLte9/Pv9IR7FZmKxT247RL86ahad5D119M/MKLdSv?=
 =?iso-8859-1?Q?TMz/lX4iOKRJNz8cBQ0ifGMesUaADkDTWtX9lEurpY32PTY6WKxujxm35L?=
 =?iso-8859-1?Q?YIxUTtaMHJ7gO5hiIEx7NA+W9+vrj7cps1iBzW1oavyQOS0b9z+xmo4qWg?=
 =?iso-8859-1?Q?ZtPQNAi3iMo5kUskR3K9Cu/zdcSGSe+BTMtu+qztXkBczt7mdWePKK53Me?=
 =?iso-8859-1?Q?zt43bVkNr7ssn6rBSyi7qH0TZkxFPY1t2s5qJhRh7n0s6KBm+s9kXUpVmE?=
 =?iso-8859-1?Q?vhyojdjRnkFCqJo6Ga6fsRq2NZahIMiPVoKhwNlnMYID6lzGMp+b1fwXDS?=
 =?iso-8859-1?Q?mUTwTc3WFC9A0TbPeVb6496vf+NO8ubEx4tt/AwYU0qCjAdW59l5TW+N7A?=
 =?iso-8859-1?Q?w4dLKwT0R+mz8PWFu3pp9NSx7yVeP43UgidviDQJ3k+Jt4H8ZadQUJwxhI?=
 =?iso-8859-1?Q?riAp0Up9iaQ2HLDHVJhX8cpLZh3Po9nuL/f6KIeJOoSdO/HaC4Jp5hdxfj?=
 =?iso-8859-1?Q?Jb6xp1yNu8uFuEuR1djij4d5khsYow3psDIw8vkYuwvwaNWGQpJCnOnWtY?=
 =?iso-8859-1?Q?0AgC8/ak6lnbhammHg1FHdNhyM3cLFerd0W/iVuC6NcSlOA9dbXMiHp6y1?=
 =?iso-8859-1?Q?NBliVOQFGpSj7LkymUOhb+VhaNS+XDZmtDEdOjEPQzbwfrouQdMxUIE3Ob?=
 =?iso-8859-1?Q?eNBypPU70rnoSI5TXpv8NKDTMKOYJ5MNSHzZbiPg1VI69DGFLvUox60J3K?=
 =?iso-8859-1?Q?x2ih3909Rdr6SEzezSgOBZo2EAFn34qzS1je/TBRtg9B/fj6/335JTAcTn?=
 =?iso-8859-1?Q?Ik3bQEwADLnwDxXI7//LaVcs0nLlbae5TErQ+pxx6fb1JnnCIIbusQnCds?=
 =?iso-8859-1?Q?1GDLmQNH3ScBYwUaMGgMCPTs7peuYpB3IvmZkzO9V0xbATkLv7r7evN8DG?=
 =?iso-8859-1?Q?9iYnsjMd4wN1x8f8WEVVn4zi4O3tpd7g4TTpRy+H+XKamAqcqt1XUnVnLm?=
 =?iso-8859-1?Q?aevpDoCL/y7Kon7w5LAel7nT9HJlPn2hthWy6zeVGJX6861995t0Ilbbsm?=
 =?iso-8859-1?Q?jl/dLwvGRXfxbndxxLzwrRfmFTaCvgDegBtd8YCG07x0fE0usJQyl5Vzr4?=
 =?iso-8859-1?Q?OXf6ciRHqab3MGAesqoQTe3ZSDaAO/7c6GQQa6/bOhsP8AVLvyLvT2NKkE?=
 =?iso-8859-1?Q?ptUhH1eELMIC2wTz3YrI9G7RGbJxZ0AMxbxb/Mex8NpLGBMXl+spr/cNNO?=
 =?iso-8859-1?Q?Ho7n6Bm1SxMgrUoJw+EcsF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F1OCiz3Yt+i7m0kHG3YDWs2qe864aduGRhbmDAwu9NGU1yqn9YzlzxbDXw?=
 =?iso-8859-1?Q?eXRHFtk2DZj/lyqgAXcDcTo8f3Kri2rNkf4HHrEhLGrtdXRtPBrFRq0/B5?=
 =?iso-8859-1?Q?4o2X3W8P+vgbRSBOQbbLJVKc3MkX1bnspOZU5Y71aFDHq0ts5NJ5T8fjmj?=
 =?iso-8859-1?Q?Cy3xcDNvohz6NskK5LO76jS38lv3XfUctRMJbwBEBnAxOkXINgfoIxU86n?=
 =?iso-8859-1?Q?pKmt1RhyR/69wRrL0jz6W0eGGaCbJVBKE9itWXTpTmpIB96scgb2ZNRO/u?=
 =?iso-8859-1?Q?F91hfzBIhfs69vNYG+v/gio6zBC6RpZM5jXNemev0w15BGLnURBYeu+vwK?=
 =?iso-8859-1?Q?tj/T3w7TsoTdEhc+v11aqM6Vse60RmrEGd+3IgvPK7swXfJRgzy4PGEanA?=
 =?iso-8859-1?Q?riw5jhFexTPPejYhciZb4walwi4zlyYW0tfXltBE849Wpi7O6AIiY3Y0AJ?=
 =?iso-8859-1?Q?ggdYtoRp3mfPxYKyLncww7bc2qtzV4Ua+cQtB2jAIIPyoANkRayOjczNVq?=
 =?iso-8859-1?Q?i1BBZg2LwZfW5hQgEsyV+OtcGf2d1TdPJiRhZTbprV0C+KLbDQ6c6gtatv?=
 =?iso-8859-1?Q?5dmflLMtKBuEs7FjYEj8K14KtO9h4DRCOfYWsQ2u4MbZ5IBAZVsSEdd7/n?=
 =?iso-8859-1?Q?C9PNqorY0G9/+9XyG9GgWNIjAsyxlaWI60y8j2HTInGQ79YIN7Vm9WxU3e?=
 =?iso-8859-1?Q?p5HKYJJYnSazF3JS88b7BnlGo3KBZlpbMHVKFJdbbZTkXAOzfgRsLcFYNC?=
 =?iso-8859-1?Q?EXGU/ep9emse9UDvbrhiwwL2Tik6GxQpnZnVWm5MB0nqFYqRxGJrzjD+Pk?=
 =?iso-8859-1?Q?/nKmyL6rKOakyoIIdOfFUUrXjKg6UPBVzLGEyyQhKTSN4mCxsRjG3bnZhb?=
 =?iso-8859-1?Q?Rk6uU7PPQ89vXRC1WOvZWu8ioo8VLtfcBGuyVUoH/tJjsmWED28mDqtm9w?=
 =?iso-8859-1?Q?VCAmBmWOLE6gOl0tl+T8f0SGaJFJtVmQFyqUI7h26tjbua11CmZile9xOa?=
 =?iso-8859-1?Q?ELQKkNikAZKJCEWrxgb29y3qP5lE33+vHb9epypp4nDDSeSl2iRoLeeISu?=
 =?iso-8859-1?Q?ToRuR0+O7ADvYY1MD06xDWF+3uCigpqU0C9uCfp8ZeOL/R/vsm/bJPfs7D?=
 =?iso-8859-1?Q?jN40goG0y/1ICLlRDbwc1efavPogVraC4bXUf1zmctP3yQvCc6KyY/9RwW?=
 =?iso-8859-1?Q?0pNomU/sfPgNCIC2h3BsOCrLdm4rZQiY4kIt2OxwEz6I+eyavBThdlHxNT?=
 =?iso-8859-1?Q?7I4srtdx/mDHZZY8Ut49gu7jsnvobTzYM7uoLbB9M/5otPT9xbdoBj6e1V?=
 =?iso-8859-1?Q?9qQrg4Hjm3mRLCNa1vWrvIs8HwBOLf+Y+9kUjFc65s/3LlDWN12po3z0Uh?=
 =?iso-8859-1?Q?sOzA5ATkqhQ109Y9e22xwBqz2b3SvZe7ScD+s083LBcg2tBnSgb/gpH5hc?=
 =?iso-8859-1?Q?gZ9Lk+hXQz4YDdnxgnzD4IWo6h+wXoxvxP8kvsTtF842mexRRZBqf45AVp?=
 =?iso-8859-1?Q?E7tsSFCf47FX1TvHsW/QgNY9uEP1dwMcon+GGcMG1xoKajaJf6UffAbpH1?=
 =?iso-8859-1?Q?rwlz1lI7oTJn+YaLjPVruakFVRX5fACoKV2LkxZq1bhgc+3idAJIbioekL?=
 =?iso-8859-1?Q?RmP2BwIQ9wZVYtP9O26S9XZfh5iUi1hFTY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9bc201-d5fe-4bdf-1ed5-08dd4974c477
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 01:46:41.7444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVQMaVq8bbEh3fVBYgfqbQr8RWStOwtOEy3VaBufdDVMqpIeofDCzc7uTG54HcQR4z0icibIV41VQqGZ8dcL3h/AChI4OiuBo2liSnDVlRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6033
Received-SPF: pass client-ip=2a01:111:f403:200e::720;
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

Hi Cedric, Andrew

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, February 6, 2025 5:53 PM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
> Lee <leetroy@gmail.com>; Andrew Jeffery <andrew@codeconstruct.com.au>;
> Joel Stanley <joel@jms.id.au>; open list:ASPEED BMCs
> <qemu-arm@nongnu.org>; open list:All patches CC here
> <qemu-devel@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>; Yunlin Tang <yunlin.tang@aspeedtech.com>
> Subject: [PATCH v2 0/6] INTC model cleanup
>=20
> v2:
>   To streamline the review process, split the following patch series into
>   three parts.
>=20
> https://patchwork.kernel.org/project/qemu-devel/cover/20250121070424.246
> 5942-1-jamin_lin@aspeedtech.com/
>   This patch series focuses on cleaning up the INTC model to
>   facilitate future support for the INTC_IO model.
>=20
> Jamin Lin (6):
>   hw/intc/aspeed: Support setting different memory and register size
>   hw/intc/aspeed: Introduce helper functions for enable and status
>     registers
>   hw/intc/aspeed: Add object type name to trace events for better
>     debugging
>   hw/arm/aspeed: Rename IRQ table and machine name for AST2700 A0
>   hw/arm/aspeed_ast27x0: Sort the IRQ table by IRQ number
>   hw/intc/aspeed: Support different memory region ops
>=20
>  hw/arm/aspeed.c               |   8 +-
>  hw/arm/aspeed_ast27x0.c       |  58 ++++-----
>  hw/intc/aspeed_intc.c         | 227 ++++++++++++++++++++--------------
>  hw/intc/trace-events          |  24 ++--
>  include/hw/intc/aspeed_intc.h |   5 +
>  5 files changed, 183 insertions(+), 139 deletions(-)
>

Please ignore the v2 patch.
I will resend the v3 patch, as I am retaining the INTC naming and introduci=
ng a new INTC_IO model to support the AST2700 A1.
So, I think I don't need to split 3 part patches to support AST2700 A1.
Sorry for your inconvenience.
Do you have any suggestion or concern?

Jamin

> --
> 2.34.1


