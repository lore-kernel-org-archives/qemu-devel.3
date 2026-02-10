Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ECBEA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlz-0001q2-Hj; Tue, 10 Feb 2026 04:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlx-0001l1-Te; Tue, 10 Feb 2026 04:11:05 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlw-0004mZ-CJ; Tue, 10 Feb 2026 04:11:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxKL6fGI6l7pb14Hqv5/fjt16cBcWA5o3jGywzOni5ZP83cqm9F2opNH217idKIrj7d1G3ppsZ111tsWIav0sjwbO/kLHdeuJNydYBz1M45mv5dG/EgQuuf3KH0al8w8RQ4MWLQF0SdhIkA3TvxWUshlrVepvKGbY3y2mQcU8/SBQrN4/2QDgGWj7RP0KcUaoSYoX9CdSOmJfWNaYztSNCARA2g4dTqhh51iHLUZ6EP6JxFUPXqHbKnDyAWu0IZOEEJAf72PEX/wRmxH8N7xtRg2l2awYzwBKEW7YikT7+J7MNpSwiSR3GZ/agjKwY7FxkMZhKi8iqlUjfMXaso1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=t8K60srXi5yEdqVX/r7QebJNq8SqcxDnShjHJeZBMa2RYBwrWraruDfBYL4Z7boB24EKIxhhLj0Bw10UshVuHUL/Ole5xKSFJAIphmeIXbAorfADBzWQLyOYpww2ySTDmPay11XeQYH3s/4FJnGkiYQEld+J+fBmeGbVvNI39jEQRhmucCNW15SwjoRmNvxJmYLdKBdFSh1yAE7Ls/J30cV5jz3TAR14jCKyq7WUMkxofEoeQcwdXeIipBxOTh4Ll8LhVSaEuKHomTvtKOU/dGG94QYx/TSlxvzBQugXS1zMVhMexeBOvLlaaqdFMT8GP35Xx3tRUJVzsgXJwCljJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=DHTfws0TUcdoaBT4x9EIz8gSes5gKenLiOUeHTdDAE66tdSf5DrAPneU3nJiRH0TqbZQpZPAMDrXznGoSwgfXgQUytJJ9SGJMsgiSL82drmeDDksRJOtSkyMvgPF906DJi8CLBSvHK+anusnPA/WCljYOJ84QVF59OV5nebSSuB20ucZQPfpVvZf6RhIEF1wD145hoIXsa5f5RpRNxj6mBSqZXnZETBpIHKYk4md08CIC15h3dxMRa6Xh1h4g0v/m+290kMeKASRNPXxJz3kXNM8LzmJ3uLkYwJTVULhDc90NoWh03ootpHSYglV2QR3AAH4SLhheduKRw+ysY5UvA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v5 19/21] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Topic: [PATCH v5 19/21] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Index: AQHcmm0knUwqKT0NqEio25hgALdvLg==
Date: Tue, 10 Feb 2026 09:10:47 +0000
Message-ID: <20260210091018.1553489-20-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 036f88c4-6da6-4127-d50a-08de68844762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?L0bio8350cfnUAiFGtwF+92wmVnSJxI2w9e7AcD+Ppi+nzRSv9ipdZ0lv7?=
 =?iso-8859-1?Q?o33u3Z9j1Tey4p00lyiScMKHnJlPpWuexd/JuRbkBdsQRlspFZPIagfc6Y?=
 =?iso-8859-1?Q?FkrpW++YG9P+gQGwK5qKuKDN+hIKsf9WYyY7sjSspftMEX0t/Ny7o2XdHg?=
 =?iso-8859-1?Q?dEKBGxP26qpZiaOM80QDpdntkAl4QpeuiJU+2xZzCmqZmthdRf7oZHTyjM?=
 =?iso-8859-1?Q?DpUYYe86hyecJ68QtcVsvRUpTJZYPFP/JyAUH4CAe/ZnMDCTAO72TcdJvb?=
 =?iso-8859-1?Q?gMyDMrQnL8s7cAeYa/TOI9LOr2O3U4sUR4Dpp/j4sJXvpCwE1E9GmKoBnb?=
 =?iso-8859-1?Q?9T4mt5AC4oYiWW0/X8b8s3yVtSrfMM1QM9TG+cJupXU7kNNzXqVbwGhgwT?=
 =?iso-8859-1?Q?7TrGWfacJMl5QXfc/525neJvPe3GoYzKdJAZkR8R+Wy4VcW3EAsaK3EF8z?=
 =?iso-8859-1?Q?tsq8hHq7OXteg6jAVSr2ZYmxiC+o71Byl0xiuq232kYqUPKavdquY69S3D?=
 =?iso-8859-1?Q?l/rEvS+Ohtfmi8T9dK1pRU0a2/BY9ODVKCrH8GiGmr5L5LeouNGsDzmeII?=
 =?iso-8859-1?Q?mh92hcLIICjBWgGIL6OWR7fVDrtcCcL1JXwLQrRM+0+2YWn1vFqN1Sgm2C?=
 =?iso-8859-1?Q?zNmGXGQr/PdqmQ60tN2lK11/pjZEwwuZ+e9tnBYI2nsORRsDjbCMVIqMEt?=
 =?iso-8859-1?Q?5on2VCemm/9YJ9MrskanQHL+SQa6AX5pT60Nk93joroeIkojvamQ1SH48S?=
 =?iso-8859-1?Q?iDQiEImQiogNRtw+/mnjd7FfcyzVOHDPyWj0ckPaG+3jl7VxSHQUuzDUQv?=
 =?iso-8859-1?Q?WErVBsCFowVtOCi0L4HQx9jkAuylL0KkWX5JT05cnpfIAdfy74iWujsKjY?=
 =?iso-8859-1?Q?DEP43qZ+flJjJIguTJAyAQ5O03Kmbc5ZRWcgPrDsH3oSNBWH5nCqmgMQyc?=
 =?iso-8859-1?Q?hFDDJct/UtyAtsdrUPp4BfuceiVZnPsbwgWFzPN2cQ06Fb12mg79+U2ttK?=
 =?iso-8859-1?Q?faEmHvjwcAkB6AM8YGWOuRulmJ3Li97CVYGFamORzTFcs9G4pkUgOUa2T8?=
 =?iso-8859-1?Q?jz8Y1ffdTNe9yQaPsO/w5hcrFMXAKOo81V3Hz/kwJc6pPzDSerD9KW6RYC?=
 =?iso-8859-1?Q?odOKYJO9VTyAixEuIk/2LXx12EnMtXc72tppGqMFjf6H8GNTjwJW5fFk2X?=
 =?iso-8859-1?Q?ZxMmr+hkaujH04qI+eZJhGx7KQj+jyjYCTEELwaMRsMjBeun0NWVi/WMnb?=
 =?iso-8859-1?Q?0uVMPXGbQPpq6C0J0NgrzTrov9WknOWwZ+NiWsO5y2sjgEnzkoMq8ubvze?=
 =?iso-8859-1?Q?y9jd7/Rg+ZPf1T+2TjlEkCm7Wyvet192zNtF+uG+IcUlLS7kZslH/4OsGI?=
 =?iso-8859-1?Q?GU9We9eLcuGzWSnoziXwsidBtUBtO271mTeMWhtLj4Hwc4pGo3obEnIWrH?=
 =?iso-8859-1?Q?Rp9hBrdABZ+do5dYQKiLg+Kyc6L0Ld/idgREo/qxTbOUotRN7EPDd5j6h0?=
 =?iso-8859-1?Q?/Zb8iF4xuG7YnIOTVTGi8W9k9urxVRdL4mDk0mlyCu6kfQZpTVPT2Uzz9V?=
 =?iso-8859-1?Q?qtwGHSGVmchxOGTE9uZpOjQ+waIPmaRH3KrbNGF6uIQmc+0xngsMh37K1Q?=
 =?iso-8859-1?Q?P1O2ymsKmIrZmPf1k2DFjOMca2v5j+rd+uimozs2E2oVDeQoj4uJwC3QLf?=
 =?iso-8859-1?Q?BGvgB1Y/dg55LGnJVHfCe9gM2Fq75YKkXP4suog4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?apJnzUPTwZ0bJxMcAasjgu/07QpuhGy1lwQRAkRCvk9xIFNDH5rq5dvzjg?=
 =?iso-8859-1?Q?FPG+WCvTWWuWrGg+E9QrV6OFssK+u8ZtZkfiMMp2rkt6TBgUiAOL9VaRyO?=
 =?iso-8859-1?Q?OK7NYuc8RSSU45JxyBnbd0kG82w+nPaQ8UVAbKvDSwsOAeZA9HyeErlBPD?=
 =?iso-8859-1?Q?BwXtMCuWmoE0cCMy0RZuTwUpUIhK1gckMgP9Dvg5athYQv9q601UZJq2Kf?=
 =?iso-8859-1?Q?orE7rTkyGPXbN/fWiwjFzrw3xaxK1wlEYntKEMRPKCp5zAN+xEzeDpS3NH?=
 =?iso-8859-1?Q?NJKjp0XECMQURhf4CHKwSZBMNeeRI68D4dTOkZMlF55MOefjojgoH97EPu?=
 =?iso-8859-1?Q?VVDA0CIKv/mDDTRNfggqblA9ndiKS6Kl5L606QQr8Fey4UIOgnksXNr/pm?=
 =?iso-8859-1?Q?U+jg2V6FYiOVls2wnt/qmJf7GD6NVGmFec2EDD7WxBfTXD33JRKmcuMrOr?=
 =?iso-8859-1?Q?t+PpWAJAGRz1OHIn3gKtsAlmncrCDLCfgjDXZGlRz2chCeaRy+o8byNw2K?=
 =?iso-8859-1?Q?PJgI5Cks+vozIDjvX99DbU86shWMyqTi66QpNMDVVIE/i+aUSgDuTT5QB6?=
 =?iso-8859-1?Q?imKAg1prJriKAqhr+9utSRkE5oSClmdZEk6vdQh8fBipqgz+W9RloWe3h6?=
 =?iso-8859-1?Q?OWhrp5zGlSs/QJS8aSND/UbfyO8rmf8cCiTqjTnFCgz9aIuLQpkPlRj3sx?=
 =?iso-8859-1?Q?vulOPLWtBECwfTauyDCDL8XXoR6ktv1SgRoeFEntDsO3BgHv3xtKcyzj7J?=
 =?iso-8859-1?Q?eQkLm3U5nV9RbEL4TEKK9UnPB3nP4dgp+3Qh8tJg7FhCN2gwp9NuHzlJPk?=
 =?iso-8859-1?Q?BqHidJUjLKi7ea11+Adi1FzLz8fQfn7rJgwT8pnzooaBCnk7NEL7bbUCXr?=
 =?iso-8859-1?Q?fBHA8HtvgjTiGIpGK6Qu2RPPIQJNF+zF3xxOONpip9F1UZG2BUWyMkpMUN?=
 =?iso-8859-1?Q?v11FfNZbBjJveRbx0AcrEs/jR5WpLEI+hu7hoq6ixvvyszcn+AaKg8WSXZ?=
 =?iso-8859-1?Q?5AIIFhyGYWxZM37BLj8CRe/zCHBltntXOgnLvqqcSe5xCw2h52UlH/3ooZ?=
 =?iso-8859-1?Q?MutYKMnpw2R3uZPFX2Ho3sS+YPjSr1oNVshPhnkam2KtgXNsUC5iBeGmfM?=
 =?iso-8859-1?Q?5zeDaVyaEVj6ievVEtAqQ9fiXgNZ/b/Gv16/kKIpvXbNvnbjoZgjbAid4b?=
 =?iso-8859-1?Q?BTRIFNib4ksZMCJ8Egcuq9TFLuGe0Aryav6MQ0oXaDxK/GgsIqdNmEB1lO?=
 =?iso-8859-1?Q?/J9Uly3HEVkkt6rrKHuuhZh0XVsYXezEZ0b6T3rfiC+l1w39zHwpro+3B/?=
 =?iso-8859-1?Q?H+7jvXCmxLChieWa3OkCylBMCJAqUrDdm1GUsgTXr0wf9JUtAfQmGAgu1C?=
 =?iso-8859-1?Q?eGE9WeSCOrDaJC4LZHnPsRSP3Nfx4Z2WwCX5X50oOEDyRDs9a0FsZeQk96?=
 =?iso-8859-1?Q?ussv8RTfMHoXXBOHdiZmUyg9gMTtoxH5GHIc+hVuxUttH5hxFzcXnguXZU?=
 =?iso-8859-1?Q?+4RI+QN6d0aZVeNF2nLxOAShccm86B9aXKBRtgU8rTuivDR8j6MetvcTxX?=
 =?iso-8859-1?Q?gAeZJM0lMSpQIMkfCHBYQKLFioU9V9FFd5SAYR/yRrl573gIs5kEvOUfwd?=
 =?iso-8859-1?Q?LhoMj+8gmhhnz7YSVdsLJAAXWe87ZhuERZuehIdBEBKyyt38M2sXPee6T5?=
 =?iso-8859-1?Q?DEzZ3TytGBsSCa95YG7TsZyq2t7hVG0IU3qdoT1Lx70yKMEclkAcRKDkU+?=
 =?iso-8859-1?Q?cC1k8dvSSRIdmpKLepBzt1EzNdkg8t0TAb1i88rfrur/7atABUcIvvPmuf?=
 =?iso-8859-1?Q?WvtTFjQjng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036f88c4-6da6-4127-d50a-08de68844762
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:47.5666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzLladJF9M6wazvjhkTYqG0AFg71deMh67d/Au/FtCP9quvabDZW+dDcpv9tE6ehpqZjgr3BQqAPodYeQefp+ciK7ZLxgnL/axDxKX8Ndzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Allows us to attach the mock I3C target=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/Kconfig | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index d545ecd712..3396a32fd7 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -547,6 +547,7 @@ config ASPEED_SOC=0A=
     select I2C=0A=
     select I3C=0A=
     select DW_I3C=0A=
+    select I3C_DEVICES=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
-- =0A=
2.43.0=0A=

