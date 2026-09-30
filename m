Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B5CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogo-0001o9-Bj; Wed, 30 Sep 2026 03:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogl-0001nC-T9; Wed, 30 Sep 2026 03:25:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogj-00027I-5F; Wed, 30 Sep 2026 03:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0POs9oYNDHLH0HGLGGKg/WJyD483ctaNic+XhSAjWGFc499v+S8TbNVRzHN4ArVHrYVTL5V6FKNZ07KbfR8rhVRya+3S9OeZwBAGii24FjqQP4pGb7JelQpYtid2A+F5U99KDKAGODLl2haXtNGRWjsKWE9HO4WaL/CHtqzZImdaIrdpmv63kTCregjmucrI0lf1BeashbpcZYI2EXkMkEnMv/GXoT6OkBUGqctelZLpm+zUg5HdL5foClJ/8o/tsdl7ZT8ZHJ7u7Iv6yv6XZquYiUUmuryvs2lQOEG5TgBvVS43ZGt96VRiSupW/eroNzPABm6+P4rNGmZuRJaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kle7GjQxyV0TeODdVJZ95px4goT0GAYfwyRuFjfXbE=;
 b=M8paW7K0Q9t9qQXxOGgQKaMn0Tvnj8lKe8VSWeIHSFhSxk2pViFE2+Ksd95pfpdflxMR2tY5D7IG1+In3t5OXsncQ2Ws6vhPX4lXuxglymm9F2zzkq6Uf7sjz9nORAi6dkIRSuRTEog3gff+7fr4iQeuAIPaxlqk+uwHI+lbRdeNPgIIHEZMimRQSsChtVdN06JnVHOiveII5fu8C9XydrfNKZwlEnhT2QQR7Y/cDNruDlw/Akn8pBdQR0z4KvCGGGEmmXzI9QWHdVPjWuYah2jo1gKWrf4VWoDmraG87goX5fVZLdHPNmSUhAUm46EOWSAbjNiNQT4r2GEuAU4xBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kle7GjQxyV0TeODdVJZ95px4goT0GAYfwyRuFjfXbE=;
 b=mXEWBPsogCc82+0MoDDbNer7kwdlpONH0QwE2rEuA+QcDR0u7+QRyr9mn1VA7QfEKYqTCbZ0ut9ONb52FyumwdS0vhnPq1s5vlW2fLzPFmsJIiZFlq+psCA+sG1EsjgaZYYahmX7LmbHzcK7TYbDWAIS9ANi0OWCbiwdu4wkLHlsQqGy/sJmQTenGW4Ufr+IQuJ3Ls7DcBQfXUWsKItHtgIXFgSz2CqplcAdqY650e1ef3SdZEzrWQqH2DX01O5oOTKQ/ob4gLkKdByUKUeFIwtS36tE8TQIbZj71VzIsjf//MoBg4i2wHstaDgyo+OFwirUgVz16im/7mwOIzfCNg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6451.apcprd06.prod.outlook.com (2603:1096:990:2d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:02 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/11] hw/arm/aspeed: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 00/11] hw/arm/aspeed: Use unimp array and table for
 unimplemented devices
Thread-Index: AQHdUKzOaVSfIu2tjEqZnY4VZvR4cw==
Date: Wed, 30 Sep 2026 07:25:02 +0000
Message-ID: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6451:EE_
x-ms-office365-filtering-correlation-id: 0ee9d2fe-15bb-4443-a59e-08df1ec3f11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: nDylagObGO3rltTi0g2QVh1m65yG+6LrKnynIv45yoSRjgVYfNKVvB4OMNN5FcQkLMBG6I9arfPv1NhbptksNOGweIPCx4TIYCn+29PYAzQBQAn6cDCqbfbRz/pWRwrE06IpT7JxAR+ijAmDcslcsstF4V/sSg+9IyoMUJ89BjoI90UpLTkGkCmIqP9+4gZGI521pTRwpbbKVqL4G0YToth56yXsanZ8/SxVMCyLddlVaRODiOcnce1IEJyOUSH0V71MNK4CqxC/PQgOSkkVsvF0459h9+hKz+HGl1UgUTVbqec3K293YIOLs0OMYS6z/y0SJHRu5Rmvmty7oUw3GO+IPhmnJq7qgcmXbanJtvkU23kPUiYLRxnBObFMe8vQfv+vjOE1+jmTmhV98CoAO+PkAG6cGB8PWCqhMj8+WHgBMVo6z7TjE71WmVjA4vxssdNmsnl+VLY7UXM4Zezxng0SXNBzVJ0DPhgAIlXyEAhMG43KUttkJ7JOuha+0b+WtrUrxcqHa1QPEusgfbYCfT59zYM5NNwuXg1aWLsDl2rWfArwT6QYOFL2hRYfluDj1SdNlW8MY90pTi99uuiAIeYGeF1QXN69763Pv2oI1OBoKFWYd8piFYCPFe0fCKBQnRzumb9VWwOmw9LcFZC/T/AIMWXZPXkc35TVtIAYTPNlBLGQw8yJrTK2OkBUH+MIPeNrUV9RebLRe6VcybbPKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?62dzJT0ECe4is0+ECLrENTOsTCJgRalp5Rgz/i0GQ3F+pZFaMVzbUaoVp0?=
 =?iso-8859-1?Q?/fI08ovEjKeryCXqKoeYl2b6Ty3SMzruiZJi9/cDfG3JXyd58y+iZ0blF9?=
 =?iso-8859-1?Q?jDnkNLI6AFvaSaFWyS/5ArzZTupPspRDoBB725LjrFWxcM3USVl7aZ2Mp5?=
 =?iso-8859-1?Q?gI5jEYugHJuEIZyYXmpqPhE7BajujCWtvxKn2CA6rcpvTmIBbQ/nIJjnuz?=
 =?iso-8859-1?Q?rDXkFOeXokWkMYTVaIxhYqSP2c/kg9YAvpyHxmi+bpuzpOVbwEVLPBr5Dn?=
 =?iso-8859-1?Q?5h7gs9Rr1PeWinzFYfW1ncW+2iJCAMusPm0rs/MGV0s/Nd2KelvDwvAjtj?=
 =?iso-8859-1?Q?qFIrdJtsK5okgWOtjaICB1klG5j95jXk7ZSOYgwHSHmwbXmf5Ufgk+FWGe?=
 =?iso-8859-1?Q?MU3GrFzgGzDbIOShkV24hnkNLmCpjuj1DD1WQv2kb3S5WRCNlVzDd5KccQ?=
 =?iso-8859-1?Q?BJOMER1jc8h2DWcmwUNDWNsMbg4UHfy4MTy34hm+8YYJ/NKG+DanYx8wu3?=
 =?iso-8859-1?Q?baf2M45a4QPCrH0YZBRx+eJkgChAkBULr2v4HQUEDL5m3zrkepAZ9pE1OI?=
 =?iso-8859-1?Q?90txGAozLoTHEvtvCxlje7H6HIem7Ox0SFQnh9GTsd+RNFCFkgTLpu7Lpj?=
 =?iso-8859-1?Q?bBKgO/V9/nEUxa0L+s8SC8To7kxe0fAO86+5f20gdeUTtyVWefq5N65MAj?=
 =?iso-8859-1?Q?XoXWRt4JJUhQqzluoPbp7ZKWtbdU38HwAMF9fBNs5vz2oidcln7aSqHxfr?=
 =?iso-8859-1?Q?AZSVmySCZUK1YcDxKVxt5OmCMKlZWxQlTXOLYuNMPad+/s7/M9yzc7MrJf?=
 =?iso-8859-1?Q?RtSPXe+ZXNzvyelNLcWfIuHV51VO/snyyP+mgdsY6xy1XNmqs2odyKiuvE?=
 =?iso-8859-1?Q?pzor/r1UMsQDj4bzycfsvyV9a+xV/RhvMNWXaMlHACQxKG2RLOlEfTO4Ec?=
 =?iso-8859-1?Q?esG2zFGCQe8C/LrcA99yCoEv1D9n/0bGtJhNL5vI0vFI1pJ+7IdAIzITsq?=
 =?iso-8859-1?Q?Lf36uKtSxYmP8zTyE/plqgvDl9sTpelVdLB+Aj763HfiW7jyU8WfU6qHhy?=
 =?iso-8859-1?Q?9r14ie2f/8CRDYNERqDXCmqu2uSXGCLq0hO2Y9uYIXWSOLWkgDN3G9uxyx?=
 =?iso-8859-1?Q?MHj9JVw39E77WR7vgkqKMKFKvKt8TzSp1izVl6b0jsZFtylrPhzo23bsri?=
 =?iso-8859-1?Q?zfXMDkek0ywF6XBBLQDkCKnJzmDSIPOLB9efbLRoGGcA9wWRKt+l9fsfp/?=
 =?iso-8859-1?Q?APqPfQhpRpGQz+8Uir8fZL8va4fTQrRGp7Mq+xlnEZZG5Qwj2+qLZE4/N4?=
 =?iso-8859-1?Q?IBoC/+HBMNSHr/E7k0qEix94+OFA9AfaArngQsQJ7mgHJg9FKAHHqsF64K?=
 =?iso-8859-1?Q?cjxJoLGp3qpNBCUXKq9lOShnqunYpyyXypcnJ2UQVrxDxqMrJAuFVkBefO?=
 =?iso-8859-1?Q?eyMw2H3yPQZPS7LFYH3uVP+XCJrwAKVvxWUwxEHnEwXVOqAR6S9CoHrZZH?=
 =?iso-8859-1?Q?i0F4vkecQvEKzz4rC+03UIq3JPdNCMizxr023PTRQkNvQNho1NUlbMAV71?=
 =?iso-8859-1?Q?erPK8dfetoF7P8kDUvmulbYJVRBr9jfDxTwvhSTvoo/b03E+IyTM4Ytxar?=
 =?iso-8859-1?Q?aJq4rLw8qzg/ohAwn596KMnBJhi0u97SqsoFEAJRuTnk1wBkaMhk+bxbYE?=
 =?iso-8859-1?Q?DUDXjwu4zjJS2EZ8RqUu9aLD1HI1ut6P/Nfm5FGR6XX0EZzoGKfj7Vby45?=
 =?iso-8859-1?Q?5t156R2OyqTuC+fA7iY9qwZyhE6FJIlYLZnA+wbbYLgpyNolCiFmsqyu6U?=
 =?iso-8859-1?Q?qAfoZqayCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LKDgKckpApwOw7mUAiybGRk23cjAuZ/Ho4iw6jfDlBt08k1PiKwvnYs/LoSCT4amIkkAjCKfSjSnaqLSIxdz5+WIIxonELYCfHyDwCQE9mnM+mqjhnRsaRKTV1mERdKwIuAOTN2oXdEuzurPwpLxEMoDn8ad897lM2cHSCruVK1jUbPUPU9qBJaFlP9Q8s4eaRXGnPfy0prmPJ2fa56UWoyoK7lRdxAIEla19iKd5GdSHneo2sI/b5QFxlTlpfm4Ph9bWeeuepnkn17AysxiSJ2QkeDIVR2m1U31FgPfig4u2i2mX5Z7qPZZpwQogah6bcwWQ8e+U2XOrUFCHbLhEQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee9d2fe-15bb-4443-a59e-08df1ec3f11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:02.2181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsjfRbam2quSEgx44iA3a3BQbNHmsqO6TiTCeeQlGraivEkUYizG9NEiVWBkL/jX4eZlC/5HsEmeU2KLvZClBTSRr7wNeNCXMiQkgWBz+eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6451
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

v1:=0A=
 1. Use unimp array and table for unimplemented devices=0A=
 2. Sort device IDs alphabetically=0A=
=0A=
Jamin Lin (11):=0A=
  hw/arm/aspeed_ast2400: Use unimp array and table for unimplemented=0A=
    devices=0A=
  hw/arm/aspeed_ast2600: Use unimp array and table for unimplemented=0A=
    devices=0A=
  hw/arm/aspeed_ast27x0: Use unimp array and table for unimplemented=0A=
    devices=0A=
  hw/arm/aspeed_ast10x0: Use unimp array and table for unimplemented=0A=
    devices=0A=
  hw/arm/aspeed_ast1040: Use unimp array and table for unimplemented=0A=
    devices=0A=
  hw/arm/aspeed: Remove unused unimplemented device fields=0A=
  hw/arm/aspeed_ast27x0: Use unimp array and table for unimplemented=0A=
    devices for SSP/TSP=0A=
  hw/arm/aspeed_coprocessor: Remove unused unimplemented device fields=0A=
  hw/arm/aspeed_ast1700: Use unimp array and table for unimplemented=0A=
    devices=0A=
  hw/arm/aspeed_ast1700: Remove unused unimplemented device field=0A=
  hw/arm/aspeed: Sort device IDs alphabetically=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h     |   3 +-=0A=
 include/hw/arm/aspeed_coprocessor.h |   5 +-=0A=
 include/hw/arm/aspeed_soc.h         | 195 ++++++++++++++--------------=0A=
 hw/arm/aspeed_ast1040.c             |  49 ++++---=0A=
 hw/arm/aspeed_ast10x0.c             |  64 ++++-----=0A=
 hw/arm/aspeed_ast1700.c             |  42 +++---=0A=
 hw/arm/aspeed_ast2400.c             |  33 +++--=0A=
 hw/arm/aspeed_ast2600.c             |  53 ++++----=0A=
 hw/arm/aspeed_ast27x0-ssp.c         |  56 ++++----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         |  56 ++++----=0A=
 hw/arm/aspeed_ast27x0.c             |  49 +++----=0A=
 11 files changed, 287 insertions(+), 318 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

