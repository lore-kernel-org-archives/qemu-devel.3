Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806C9CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgB-0003v3-11; Tue, 02 Jun 2026 01:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHg8-0003uZ-PZ; Tue, 02 Jun 2026 01:28:40 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHg5-0002fW-As; Tue, 02 Jun 2026 01:28:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pekMe7A2XSW0JpCW4qiokxDNN5rj9Sk+FiWyWEWEJtnGojm1N5F5zqpkzRl3UwWc2BsAT+UX9D35YXTC1LnXJ/iPHOjuy/s6Z6frsBRcHQDYW2fYBbbdJSSeOCPb6OFY6ey1bLYu6oH8WEK0QZ6YEwTvOQaDYkF2o2tlS+G61Wau3caggqxBZgh1ygw/XaFxB9KmfgBWkF3GsEGAHlCLoE7nTowiGFJpPuIbRmwnU3FTntik+CoeunIHjz2PbxvuB+Z4MLpyCEE+l2TG0+6FA51lJ98pmZQ7kYTVLpphuQ46VH1iSuVMkGjfxddo/3qnnS9dCZhQIoHqDklmTpfcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsfvImj+MNsz2WVz7mUlbVPXHwk26x/Zh8GzYMIdgnE=;
 b=Z22COp2kJrNZTgrkoGjL+C76E/ytiJBcKo6Z9dzbKMx1SA/1JPYmxtOhbNNGoaVh2RxH2q9EvmYmw3tqcNjav9vDdoR6sxN1pIpxh/dQQXa7JFr/dTOsPqkGf1s+zMaHNlRocudvj7NN0yo0HVWpoOMBQ/qklXtNmbFSCxerR2fvtB97z+ITc2PhAb/fcuz5Y2wgpUp8XT0iV5WiHsWkw8DSD/UQzOQn/dkW9arwl53lIlUHldMhrZMPstN/P7UFpghG4C0hMc2mcfx4i4+exX4Vr6MaDAZdzUf7FCVx9YYdXU4ZNTijjs+L+dsTTT1WJ2HAqgoSbvOwH6UPr0jmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsfvImj+MNsz2WVz7mUlbVPXHwk26x/Zh8GzYMIdgnE=;
 b=jwcnXsyKJOxdQvFMDVWE2STJ1IkEMcwc3K50TVyKEJdW9LKoHU37Ii9KboThk32sKFaRFQ7zV56Dhcf19CXBtVgFIc9f/Cm/iIa+Oe1YMsJOtfCevPN4SYMxZQxVlkpod5rDc76Cs8GZxrSbirB3x8vM1g1yN+GfbTiYXRJmam4LMNKIIcfIS7QaEtek62q8Sxq94XylRroPM+9qBve164NrbaCoKCu62SbXMIcIpc3XrM13isoy7XYXNGuYKgrjpt7XP7abA0TnjeCU50RsobY2yh4U5t7qkosFKhLGRdFL17AfnBWYyTvC6DuJbnLnWTm8CyVaRwlGfJL5nkEcBg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:28 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 00/10] hw/arm/aspeed: Add AST1040 peripheral support
Thread-Topic: [PATCH v2 00/10] hw/arm/aspeed: Add AST1040 peripheral support
Thread-Index: AQHc8lCkOYpc7ii9O0il6RL28yg86w==
Date: Tue, 2 Jun 2026 05:28:28 +0000
Message-ID: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: 98e89ec7-9a44-44fa-52df-08dec067c705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|38070700021; 
x-microsoft-antispam-message-info: D8z9I2MaJBjrYHTPBaLwkEmBazMZnLV0LsENYwsPJltGjBAGNTAeZkN54CkD5RO5RUrK/C5LqhGFXsH/8kA125PY/hw7EIiEPEQGP+GJjJzTjfSYPWJ/556inS7IgKX9dp3ZmUKUumY4UD0TuTcsdk4KAVtwzMCunFoUitjyQ82bNk9KQpYr67XgjL3z2OJYGeb3TKGRxvjtTfwBC3Nz5LZaHlPgoVlBxYSwE2ZpK4jMeoFyogUuxeZFECHPORsG1QbP2yGF96tsqJ8hvam1PfXxbcwpOmNu8f2aUxtwWpwQyNfSHqr4GSFgB9cnaxHC56VsAVJXeiRN2w57zZ+FDPpaqHMTh66g2yom496u59JSLxAd0OY0dXCoZ0nld7JSx2ZZ36oE0hApk/2THAzi8gVa90UfanCoQCJ9QOx+yr1LCDCMry3bOBir5uptt7Iwv3GhWwW5qq7aRmvldadeH8asn1IKT/duA8F0lZBMyonyoCE/DFBy3qaYuhEvP8CYGSIsT783Xg4HNe/HAfhzW4GRru0RhsmgjXnj+EmkvMhQF89KdVwtL6qkcQWp1wG9jdz/hBX/QI4IDFDEs/P+KN1TGShfcHo9duvPhtiwypRDACsflLg6rYXDaGaDQo64N3JFPCSajARReuKBAFf5P+lPRTWpUJSsLfLqMMU9Mi0bS5O0NNER9Iac1kbl4ZWgs8gZBHJOHAUuLMeLNw5t7UL1PvopnSHzZJMprQtC6WAuP91RrzOkc9P91giErfxd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gCpQspxdwMMwVYtQojrRpKGomjRIiGtANA8B8GFecNLzJaWaqEepx5cAu5?=
 =?iso-8859-1?Q?oE1syVFiLWlECZL9EwvvEVJ5NzlnWUeRZPaD5bkEJlvPR4O7pkekx1hZcd?=
 =?iso-8859-1?Q?WhYejciRyqkpXAYHPy1NkmkFlqplLROXtple3Fosy9KtArv4mZs0CyHECI?=
 =?iso-8859-1?Q?2HeBtOTvcTgIdiQFELrczjWtVGZfmbxPaDrez1zq3uCTYVqyhle4vWlqbT?=
 =?iso-8859-1?Q?IonkzLHfc0EEVIgup1pNXDhTUmvbzitGaMEthmG2k2WHFcpY3nKmaLW/X4?=
 =?iso-8859-1?Q?s3U3tNE6MKt1yAwwmpOiFdXwSvYcB+DgRE0R981kB8rmwWO7U0oUCqY91g?=
 =?iso-8859-1?Q?YxsN3U6BzIcm2eJXTElmWn0zGhTrQT/tPKU/16ic5NzwyRMBpTI68dDH6L?=
 =?iso-8859-1?Q?GBsIL4AHSaS8A/55do+/nGGA2GpzEh7J9WHvvJ+rVw3GcOR5LWf+4k2CmZ?=
 =?iso-8859-1?Q?Pnsf8EbF72hWk8NPSUt/u1bbGHLSbmtXsEOE1X6iN3Ko5S/MF8yZTXtw/A?=
 =?iso-8859-1?Q?ke+XcyWPjiZhrpREXBlhzOy/qcirWC9WQbA2vbARRhbjuwR68c+bJjtSB6?=
 =?iso-8859-1?Q?04okd/D/rWae+uzJ4cpqwaHRB/Q0lSZ3oAeic61l9ToKx0EngcaAncq/OT?=
 =?iso-8859-1?Q?Licvuk92HI3hchjWWoy5EZXzT3X2YY84iskepYj7q4HEzGolI6di9lcxbo?=
 =?iso-8859-1?Q?WYIz3l/oWFE+6SUHeb9/adbCC3vHcAzXDotaYyI3xf5u+VXUx1SsfMZuAF?=
 =?iso-8859-1?Q?k3ShJuRaXvk1E9YkR7BpBtfyuxnTcCStfb3ngCyiegz4r6VVEleQIWDzT8?=
 =?iso-8859-1?Q?uZvb8QdbcFPb+mpDuQIdEGk6KYELbPFkYLgbhHWk6ee/Duew91+allKmZ/?=
 =?iso-8859-1?Q?DLdAKH4okqZLpCLeTOwFnDvEPgeps86McTGirXHAE7vL1L8GohmkLPzx6x?=
 =?iso-8859-1?Q?iCX1bIKo0/YHk97toQjrKFDKGcQu062QnEme3udKMdwPo6UIWxY9Vbj4+T?=
 =?iso-8859-1?Q?Cjk8bPFMpxQI1gDg5HpC91Gkb47mBR9INyW79xTOZc71u1xxFkT2M14X6Y?=
 =?iso-8859-1?Q?RKtHskOW/gW1dWPKZ/P61J4rqiiRjU5jXMtj9EeUWI83bOXjtw8PjTwlcV?=
 =?iso-8859-1?Q?MdyxgrN3mnMh1fKL5iFtnZDN87v8ogMCPNwbDas1sSt6JSqJJYz0betHkH?=
 =?iso-8859-1?Q?KeCMriwfZs4G5he6wKPG+kvanlVcloBLbyuvvFJ0fi2jVQ3czVQht1+Kfd?=
 =?iso-8859-1?Q?qkN/p5jQrerNwE3PS6FZAgfJj0FXrHOLL/ivcy5nKaRqGLI9jdMmVjP91z?=
 =?iso-8859-1?Q?OBfy6ASji/KtL+1qkWpjzL79Bdg7o4tTS2royB1qy/nSStRYdH/0P2jtW+?=
 =?iso-8859-1?Q?/Aq6MNAeCZ5ANNcEno1fKjntl7cQBREc8n0zjLQfiUrY425EYFNPPY4Oux?=
 =?iso-8859-1?Q?UX+pan8rDt4YVh54yRbEKV1KpvP2pIwzQVRukOodJw/Rilz8awHdWbtAUt?=
 =?iso-8859-1?Q?kuUtlOX/KLFvhbqW3yiuWBM1dYzumbN5jBjHNxCccV+Jjs+NGrreL0Bo9e?=
 =?iso-8859-1?Q?u5p6o5YzuQsPeM1p83VZg49KWDWBAJXCPVeVSzFYoQvwaA2JEoISnLjKYM?=
 =?iso-8859-1?Q?rVp1rXkRy2iYFHfqos8zHJUJWzy/fsXqfuRC3pK/G35fqQHBs8lTi5xybl?=
 =?iso-8859-1?Q?JEy+xmSKeGt6QjAC9BjhTAwbVjxyZPAdc4mvzoE8CiKMxtvOppDwhAfrsw?=
 =?iso-8859-1?Q?tbNDl3yFRxJvUdSefGQ/liA3J2i1E+EviMOOci35rPWhUWdmcUwFOFwtwZ?=
 =?iso-8859-1?Q?Ip8CaiZGaA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nCc5vN/MtgWaeYTw6MAx6dRiB0D1NzUHcE5XLj9CI+J2uK+hvSG/6UKiyeAmgHhJx0U9nAC0/5UvUoOViRbDI2TjpNckl7cnwkbMS4JCdkHhP4aTdJ2zU/tql408epgcFWtvtoKttK6w4OwiUl7kxIJ1cEm1V4VMDYv/m75FKnrPrFN6B3WTrXeUkzHUG1DdVKls8yFHaciPvv5okG6ddEfs88izp3GdG1sqkUlrHmwg5a7BRbxZCY2NydFt/ltf7bOVMfHC0P3h2fk3WOn2WElo3St6olv6efIbNlYmGqUyIXIFbg9ckoUlpkqzgoSYLVyjMgoIP8zBzK0v401bJQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e89ec7-9a44-44fa-52df-08dec067c705
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:28.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBTvXlMviwDC25zqrsm0qxOWuNTWovDfvhW9B/HqfvcCMzHlMTHLnEBdGIxvzLoymw2dLCOPuuqqrhumPSldXl3Q45/Kf8GKwlljRb5o3JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This series extends the AST1040 SoC model by adding support for several=0A=
peripherals that are compatible with existing AST2700 controller models.=0A=
=0A=
The AST1040 shares a number of peripheral IP blocks with the AST2700,=0A=
allowing the existing QEMU models to be reused with minimal changes.=0A=
This series adds support for ADC, PECI, GPIO, SGPIO, I2C, and watchdog=0A=
controllers, and updates the AST1040 EVB machine to instantiate onboard=0A=
I2C devices for validation.=0A=
=0A=
For I2C support, a new AST1040 I2C type is introduced. The model=0A=
inherits the AST2700 I2C architecture, including DMA support and=0A=
64-bit DMA address registers, while constraining DMA accesses to the=0A=
16 MiB HyperRAM address space available on AST1040.=0A=
=0A=
Depends on:=0A=
  https://github.com/legoater/qemu.git (branch: aspeed-next)=0A=
=0A=
v1:=0A=
  1. Support ADC, GPIO, SGPIO, I2C and PECI=0A=
=0A=
v2:=0A=
  1. Address review feedback.=0A=
  2. Fix issues reported during review.=0A=
=0A=
Jamin Lin (10):=0A=
  hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to unify DMA address=0A=
    handling=0A=
  hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size and adjust offset=0A=
  hw/arm/aspeed_ast1040: Reuse AST2700 ADC model=0A=
  hw/arm/aspeed_ast1040: Introduce PECI support=0A=
  hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller model=0A=
  hw/arm/aspeed_ast1040: Add SGPIO controller support=0A=
  hw/i2c/aspeed_i2c: Introduce AST1040 I2C model=0A=
  hw/arm/aspeed_ast1040: Introduce I2C support=0A=
  hw/arm/aspeed_ast1040_evb: Introduce onboard I2C device=0A=
  hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models=0A=
=0A=
 include/hw/i2c/aspeed_i2c.h |   8 ++-=0A=
 hw/arm/aspeed_ast1040.c     |  97 +++++++++++++++++++++++++++++-----=0A=
 hw/arm/aspeed_ast1040_evb.c |  18 +++++++=0A=
 hw/i2c/aspeed_i2c.c         | 101 ++++++++++++++++++++++++------------=0A=
 4 files changed, 175 insertions(+), 49 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

