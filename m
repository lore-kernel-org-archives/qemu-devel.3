Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE1DCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETL-0002G3-DZ; Thu, 15 Oct 2026 01:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESk-0001tY-BD; Thu, 15 Oct 2026 01:57:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESh-0003FT-Uv; Thu, 15 Oct 2026 01:57:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCJqY4DIb8zFRy/6lEsXs/z9rPGk4E3hy7/T0Fmdz/k4v8TBc2SB2JTr+rFa9u7mhOhK1+g0EqOiAn6tAP9D7rDKdaiVpUVmIWo1NCunxusWHPzGIk0B+DK5iU36LZAhFk7JEH11v2OJYue1UdgOtA5Oo3TPBakf9AbdIE+HoziiVTsC3+59zOLIAt89x+5zIp2cta+1ZmfAYaFHqJjiFLsGgHGMqElhggnCzePMEedzUDq0Ws7ARiDgOaPaUbhIjORvDndgURJzR/bUEf5jypHDSmVJkUb3u+oiq7N7VPWUjjomNeuGnW3JmVWV6NlVn50oX4+jtKjZt07NSTw0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIsWFyKkkB+zF4juebxgWX4rKJ+n95K+Vbe7ssL/Wnk=;
 b=dGx2vzNHhPgzVJUpmtbY3gEiKMzKehkQ8GJhpN2StFhyKtKOh/0LqhnfZDQawuRjuZZKJ0rLMv8A6PQbYJm1jOlRXCRv3ON54TvT7+9XwjKiNP4IF3evdIMpe2ZklzbrkxDG59QGsjnXr8BBgJC7p5gpys/btdjt0VAwkR5UoOyQfOqi65Nf1UG2OUSVDmbveUwptO56orbw+3sdxbSRzd/7odNvEneJp1j2D7Ra8a9ptuYIdYzmzgCF9BHm2QHVotod+MRn96tkRRewyfQDG0PL9l94pIVOLfd+cgU6I5afLGRBor8mFI75wWJgMulHnPJSAwOhlCdZ58RUgawr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIsWFyKkkB+zF4juebxgWX4rKJ+n95K+Vbe7ssL/Wnk=;
 b=qIT0em8nixlh8KWIEsubtJy9KIvs2nU1wJBgPgJR45cd3hewLoat1pwcFEr8QfRPLwnKaUDeUGZticXfkzBHuTi2t3ekgTcxjLfCBbE9HqK77yyItOmxiB0PyOuc4q468tzOKUZugPfWqkuyrr+ctaAE6WEpbOd3zhMjzPf6DvOdCOq+/t4uPEeoKt255N0UwVfjlTD3yw4hZ+atpJz4UUTdmedH4fw4KJfLtXGcFlPg3IzN9CsM/WSFixP5zCWF45s4rsMNu/OnfmSbvnvgW/4TZGmXjjMMpRJy1U5Hr3FTWnCx/xPFFxxBMB4K8Z4ad6vet+NC3yxRs2DiefKW3w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6954.apcprd06.prod.outlook.com (2603:1096:405:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:57:03 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:57:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 12/14] hw/arm/aspeed_ast1040: Add Caliptra as an
 unimplemented device
Thread-Topic: [PATCH v1 12/14] hw/arm/aspeed_ast1040: Add Caliptra as an
 unimplemented device
Thread-Index: AQHdXGn8Zs1xwuG6WUyY0OBbtg47Vg==
Date: Thu, 15 Oct 2026 05:56:56 +0000
Message-ID: <20261015055642.106204-13-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6954:EE_
x-ms-office365-filtering-correlation-id: 87677b1a-59a9-47e5-5475-08df2a8122cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|56012099006|261009223027099003|261009221227099003|921020|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: KLfTEHQrFGEQMGSXY1+kprqsSR0/Izh1TZ+W+SFFZFSgGq+RMJlaBw3pobMEfD/j0YA4Ku7KXaWwe7QJ7RocspMK0H4jrlW2B14SRxwjZArc9REgGaKrPkfxRhf4iQJNLNhCcEs5xjWx8s6YG5+a7retstb+gGUva2cxD4rXF6RzqKdOQftKoKQCdCR2jbEjEyMF3nFmL4iMs2/6DR1K6WV+whjL00lk/FDOjFmb8FhLiy2QvcANsFm7lIrHJnjlBUbx+PDQ/4p+84CwphUvlM9x6C+2KHDetOxtp0PE+Cg9HnmmGpChYpI8/o0+j99pXO/8VerryZgZDj44350GaD1NwxuOVtNN0olY56dCDPyr3MgQxbMi+HPPeuF7yfaoiqEyV8EuhLlEvrB3Sj/HFpcxrHUJ1jGjAW5z/5Kdvsy0pDFfqJmdMVTl6BQLn8X/MZrsktBshxv4LrP4tiKraKyremFzHOg84H/UQXXlUUsrueXFyZfHAZNY2DFLx1LYmxCrWWQ9pG8B9Lq+X2P3QXugwC1lt5ETSP2hPpfFzXFLCgiFNiaoFuawT8ccS9YzDLwFmLEdoY6zqwox4C4UXB2lVQZm28jR5ohnSUWSbX/ieLkTQF3g8ACbYvsYwhERw6t4SQCkyGSgv9YP2mK5XtXbLdvuXljcZL6+9DymYaVC6TLygDi4kWwb1RPxgFBxH3kM4unmk8/weMx5c3p92elTL7vcvEJ1U02Pl3S14lQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(261009223027099003)(261009221227099003)(921020)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TRxkHhEDjob3TRpvlFvSA/fppBW9IhWt+I0KeBeWP4/xhwsNVsL84igaja?=
 =?iso-8859-1?Q?vNR5ahQ55V+gj+tej1YuoPZd5c4XVKzq0Hv6m8iLAYCEcePMbH4Zp939ZH?=
 =?iso-8859-1?Q?5o/h74VGWMI9KaWF5GIB01TvR3s8gpe4aDQCbBTjjqR1DskS+qE8ZFxK5A?=
 =?iso-8859-1?Q?rJG1+a608/eOW3z4kmb1BnRWFjQQiu8MnI+9sQsMVdY49a/Ktj3YkObrlA?=
 =?iso-8859-1?Q?4+XwgrjllY4//a9cfjPrRMRsDoElDmEDADrMDTyU/uRA9w+BZrdED3Mxsj?=
 =?iso-8859-1?Q?bxssCKheg74iG9Jv48KOUqWxZcLQaqaP9GWEXE+lIuC9qh1KttQ7AVyUST?=
 =?iso-8859-1?Q?1qLmR192uZD9vowO5azN92pYTlEY2rBJ4bWk/FmknKgTyuK3agKCzSucQu?=
 =?iso-8859-1?Q?KNYwkvhh9CkXicKYnDJXOzANheA/iiGDfjhaSgOi3ynnq6sJJ4LX+DHBhX?=
 =?iso-8859-1?Q?Z/iiWihskRilJQAK/Kpb+4xOJgaPTHytdelbpNzELOnkbuPcOPl20w0G7X?=
 =?iso-8859-1?Q?4cip1Qj/47WyKQyhoXYMN9StvpG6vtWzLRCHZH6aWOSoV+CIJtpM2NJvZu?=
 =?iso-8859-1?Q?gaMS+sgVPXMFgLAfvaZ6E0xTF8DU/zSG5uGS7fUHJ33SwCZCDGtOzHCBje?=
 =?iso-8859-1?Q?s2KGcgKvHVnsddNN1NLjL2MagV6klnUIzQi2OMa2b18PMBCIQuM/GW/Ooj?=
 =?iso-8859-1?Q?JFo1itGq6GAOpD+CBQTOmzbyxt1RGZYP5A7ITdakux3JN76aE06yKI8I0R?=
 =?iso-8859-1?Q?g6S84m2XwX56CAbBkGb/jGdMKaCGJyPnQJknRVrR3UB5LVGFMzrfzViwI7?=
 =?iso-8859-1?Q?6wO3WOqw2LeGeJ6Qp//POpIpzTVnhNKPeyiJc7adr9qI9NrCkno9w1J6ZZ?=
 =?iso-8859-1?Q?jgK0Gr+c9f91AYeieaxG3cUJCpXHDRlZlHiaGpyszAUA4SAiVMAmPKPW1O?=
 =?iso-8859-1?Q?JKYIrsstUR7GHNjB0TTxtWlcLahacwh9YdDf1GDp06IubBz9WoTp1ClzM/?=
 =?iso-8859-1?Q?CY2zTsW8prZU+BV0cKVWl7r75lRJYBMFl9TsiUXLgHL90yXUErVJBLgW1Y?=
 =?iso-8859-1?Q?rm+fwlx/YBOdt+FIa2qL4jOT86WtxAw02ThYWC4MtS2y+v3PYL2+2SeCAE?=
 =?iso-8859-1?Q?H2pipX1ySJYwkcHvxuW3RHrFryhAIoxLsXLzCCavw41cc+Bh60z/KmlPrT?=
 =?iso-8859-1?Q?3mG7mKDIKJR5uBdXXMxQxPyCE/HK6od+DfEJU0pNB/wQeKvALv5v8aVSfB?=
 =?iso-8859-1?Q?B+xiUzbllVC2vyXPOz0vEGt8ktDk6YRPCoKpQNaPyJTq2avBHyy/RJODVP?=
 =?iso-8859-1?Q?t/K9b6zivEua+2MrvhHhIf3g6OZ0EXh6WyycZfChl+hbKwMR6zu1x7/CHr?=
 =?iso-8859-1?Q?L040L1QP50KTsN8RDQwi/rvE28j9NDWW5TOEL9FjBFV55I9p1jDfCRryFG?=
 =?iso-8859-1?Q?T0Edc9qYPy5ghRqB/FOISmNZ/c7Ufuvb9YSMbeYED50YwTRkoYuwyOe5VS?=
 =?iso-8859-1?Q?T1BHuNUdZFvH2P3Raq5CPGe3tcMOZaXN2XC5mY2vjhQGmIJUgKw39rmGqg?=
 =?iso-8859-1?Q?JpIsaHcqdtQFhb4aIzYkMoFXTpnHIXI5KBtDx9NS9Izr3R7bDJL4pdZfYf?=
 =?iso-8859-1?Q?iN2dbHRxDZjZ0sUXtqyLbPz7XDovOWJnmcBQKemRBSmkAtJBMpHsnW1x58?=
 =?iso-8859-1?Q?uRAmKhJRNPP5wzSrCi8gUhd/GdbQ/9mbBu5iyPCJ/7TuoVxBfGcDFbEzDX?=
 =?iso-8859-1?Q?uD6oMFJtsZj2Grk7lUPKEcsRo7pJCCfLy+4JserswGgzHVAC/Y8Lacx53G?=
 =?iso-8859-1?Q?0VX04P+rzw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B+VAtoSuecmVn9CYS66emanobk1h8RT0tVK4iKLNg+RCGVmMNbI78kJsS5MvQiVgmrTJJw+OVuvbzG2O8sSVtk6KPDFU06mgCOqVBGTzlQqQJKvjTl2QnoXD6NCz55dc30qsz1DAt/1VkrdIZ7VcRiUslIAV4Vy1z7uVwGPe1D79WWw7cGAXcAOdeZoPa5BsQF1p91KAkU5s4LLrgfrNF4N8sYFE9iMKc/zbXdbcARJJH1pA0BUBQtCUyrnqJWf6VoI8CZ5YTZGit8ct+gD45rlfHk1CsL9yxW/dC4/1RYLM15BqhR1l71F7QGKfQG/W6u8l68W/Nj4iKEKawzfrYw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87677b1a-59a9-47e5-5475-08df2a8122cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:56.9759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8b5sTXImpWAVYC5qxTMaPYFVptmj5Wq+qo2dMbU2JrL5/O5OpsX+2vzMwIu1lTbmT9Rg2H+SaVGA+m0kBLhNw93P8Wr1Sf8OEUwMrirxNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6954
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

The AST1040 provides a Caliptra Wrapper at 0x74200000 with=0A=
a size of 1MB, but it is not modeled yet.=0A=
=0A=
Add the Caliptra register region as an unimplemented device to reflect the=
=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 5f6aa1503a..74a1097bd7 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -93,6 +93,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
     { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
     { "i3c", "aspeed.i3c", 0x74C20000, 0x8000, -1000 },=0A=
+    { "caliptra", "aspeed.caliptra", 0x74200000, 0x100000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

