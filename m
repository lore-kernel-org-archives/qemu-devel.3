Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF23EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6A-0001cH-Bq; Tue, 24 Feb 2026 00:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul5y-0001ac-Eo; Tue, 24 Feb 2026 00:36:31 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul5w-0001H5-2E; Tue, 24 Feb 2026 00:36:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuUviRjhA9xbshc2vg4QlWTsS396RpGDwG6zI03LS/Jn1S5QDk8DHfi+PWVmzoo+mNLXKwe1c6BBHQeGxgc2vVLXIk+fkKlApTwitz74zZbqwOjWJFX4ooHsMS0A/nmFig+pJKtS2mm9TaSxlakY/REcIVfgacvbuF6B0un7oWkgFfaZEB6NFcQ6gnBuJOmF4KY95YR+60mLM+qLHm+7w+qRwJ/iwnJiqormDLEdr2BxCPYRRq59/nl3VNK1CIyHdUh71NLnxkbmALnkuTwzWZTmH5ZZXzNaPgeV0h6aUBZjxhKPfpu2pMeGW/wPWMBr9/N4jHGjCLg6lHYtIpGjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gYQnBAq34sWYxliQDOyox+onivinbcmbdCmRpnGio=;
 b=s+jvTEIs+Bsc199OSxyDf332ZYf+I7jTAyXsp/GodJr0tpZtp4s+OWmqd/e1f2f2J+eOhxMTk3SP1rBHcmWXLw/x8wyf2HcfsAJ/4of2t5IVbe6hWSzyp3yNXoSFqcBPcMuHVjKK7/7cBfkxtASubPgjOMH6mAfwLPjnaw8dr0ke0pZwKWSk8BZ25HShMYWm6rYKG1Bjp90JNa34Uc18f9ltzXtrEB9Em82dvI9jbVTXCZzbarwBophQEPl6ZtAcVY+h2rg4F1ASpdqApMfmkjrgvz5cexM6yjKopgpwb1itGC04TMtRF/DkkkO/khkSMAD5kk6bQToo5RZtIfyJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gYQnBAq34sWYxliQDOyox+onivinbcmbdCmRpnGio=;
 b=GWMGgwj8/UPMBW9VhkI5tOSkZ+QV+RqyBHDzsBmJcC6si7vybCNQi8nP2YTRvYsFnsM2rVCayb4T8pkTAzMVp9B7U+GIPgDPF+nTw436Ea7R1oP0DCOIclVpVf3ZTV0/Bt7ly1tctdrO9Yc2lFhaW0bBeCFT4hUcN0y0ama0Bmn/HkwXVM61EB9grlF2AZktUdJ2Eeo45t0UOSIBA7gD9guZOk2uw+nuY+E9fPGpiW1Pt1U+k0pQuYRiIMWYXsJ+RDOi3OEPV9HaO6CJpOz/iCRY930eJSSqnSnP7/SirhHs6o47HuhjEW4LUvR6t0RgipLJ4ZrigZ7do3oUjxLc+Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:18 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 02/22] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
Thread-Topic: [PATCH v6 02/22] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
Thread-Index: AQHcpU9/1nq27PKgGE67zFclJndpEQ==
Date: Tue, 24 Feb 2026 05:36:18 +0000
Message-ID: <20260224053613.589102-3-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: 53d43325-805f-422d-41ce-08de7366a268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zGzQD+HXj8yvoxbBVNiPwBJHEfcqc97as71xC8dbKxJpTOHRrk/xsl59VH?=
 =?iso-8859-1?Q?fac8CUBI+tKenTXCmvssv40Czbh54ScrLp8SkDw95dwxMDh0XCeCsO3rsR?=
 =?iso-8859-1?Q?7F02nmOF75H6DEmydmw606Y63jE70tVVOBsX7oVqfaLbrb05p6yPqXu69G?=
 =?iso-8859-1?Q?TVZzH7xz6LmWpGlWjR7uVGB3gYmR+L0j/IOOA2G/1ULkZBB3Xwgj1tKNkg?=
 =?iso-8859-1?Q?2cdfn24kzaOentMZhRkfKJq1dD6ktLMaraeSOIoxO6X7OqehwE7aVYqWA6?=
 =?iso-8859-1?Q?LSxNDId2RPXlCet0mENratKyPhxGpzEEEL0Jh4+KpG8Nkqb4UEASQ1HqgV?=
 =?iso-8859-1?Q?BOTrcMJfuOqvnVPEOmKjyELdxacRtF9EMtRnvuG99GA6koCnTDqixHzcJP?=
 =?iso-8859-1?Q?TXz5Y7Mtl/QIGtGuiUCEl/ALMoqL4yWxc8tz/72nWiJ1u28L/cZGFO5yfI?=
 =?iso-8859-1?Q?GkXQyvjIMmR9A+45RJUexiu6hDhPracZKVsaBG0hCSFFxBJTUBTbaH45ut?=
 =?iso-8859-1?Q?NXm11xQsgVYoijkzlFBGYSH6DLn6TMPwR+AVo4rh2O9mbsRDj/hhiC2zTt?=
 =?iso-8859-1?Q?PmL7GIzRPlRLuT3Daa3AB03qzq9+VPxrVvvMI5O4u969lvvEquP3oR5Bql?=
 =?iso-8859-1?Q?ky81lPkSGNQyl5N8eYkK1dr6Df7RLbz+s9r10aqY7Bm4z27hr4ZamjHTXi?=
 =?iso-8859-1?Q?y9Vut8e+M4YLx/TeFVNR6iCFMNInVy2eNjuFSBONl7iIXZT8KskCn/1fVP?=
 =?iso-8859-1?Q?x7kkZdQP5q+PiSzQ4izSfWbxhIEkclpvxE7ucH4XUomj8TKqSC35y9v51Q?=
 =?iso-8859-1?Q?ELtLgXO7P/lFapWvnnIL9aq1/WmqFg3Jf7+2c7vrA1aq11cqYW2seGtfwM?=
 =?iso-8859-1?Q?Gwck0TWvXd0ryCL9YtMjRz4V2UkzIePHf4i1yd8hVNvFuNB2spIVBMbenk?=
 =?iso-8859-1?Q?+C7bUMkFztydyezFefhZ2dE9p/uTZYn85qDnYzD2lwCs+kDJw0I5Ps3y7E?=
 =?iso-8859-1?Q?xoFYTcsjvOfjU+yGBZyn6QXDs1LUugd1nfiBHgalOw4uXY6CWyBvCZseX7?=
 =?iso-8859-1?Q?2xep+ZkMMzwvIE6dNFqi1CPxczmyqtEAroBJYApqFc0JIRxCKONIzeTwoX?=
 =?iso-8859-1?Q?yeffIXI0pNDf9M3S4nMg8VPIU7zAnZauo732kbLsPT0x52pAukPqaSpY3f?=
 =?iso-8859-1?Q?q0smHdc+QP0mH7np4Gqu0sETjTib5yrXClAgdNfcsOIBnfYA232K775lr0?=
 =?iso-8859-1?Q?1FGDjpSaJMD0pQ6h/pKtEiKPV6DkvzBfIuHor/zqfV4OXeouD9r102lPac?=
 =?iso-8859-1?Q?FHz3/i1a1vvv0K6TwTfl562lWA48f55tvrKKc5c3jNXhz7AbKfWpo9QWuS?=
 =?iso-8859-1?Q?pVQGvw5Q81Kez8n21OegCl3keuG7el9ZE7v/dVGANW/vhK7uEMSr9lDJCw?=
 =?iso-8859-1?Q?A6L3z8qBsEvN5esg2TT5nNIJx9+JMvcY6xBWktkFEURfoAEuxttT5C9PIO?=
 =?iso-8859-1?Q?y24En2T2wPe7IX1b2n4RrICL0AhdT98klhDkFE2jVuMniyJ9auXylkfRdo?=
 =?iso-8859-1?Q?vWbFFBhUHXIi+AOfeNNoL044tmiDDvKjyt+4ZUmNPteIFmZ8dcsZZakZkb?=
 =?iso-8859-1?Q?LrKd6C5xF9e3jeALpM0ZGpiOkMgg/soPuy92lBOSN/Ge8GqIoeDCaMbBFL?=
 =?iso-8859-1?Q?KqCxELU9abw7NbE0eTqDw9SjoWhfAkL62BAY/u8H?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dK4ftrQteBpOT1vDl/k/j+VDBC1w8Zcu/gPBy4zwOpBaS/S93A0eiKGud4?=
 =?iso-8859-1?Q?wdLCgwm4Iy2kehWjMwd1wIZj+5CT+MMw+ITUVh7+Ye+FBgRb8QsLGDlL76?=
 =?iso-8859-1?Q?1S/Byi1Yk8MfIEyIZhxhvrbspK0E0PxspOFfO3IgVWD7lDaioEAwchcRNj?=
 =?iso-8859-1?Q?b2QSn+MM8z+jDlFegBUy0QtezBB4p2apjUZ4hOTadfLGPu7NdfK8E0beBq?=
 =?iso-8859-1?Q?irlDQOlix/l44ChYu1bhRfh2Tn7dQg5WRPAk3wFqAJlSS7ZKGRnpgqzTxp?=
 =?iso-8859-1?Q?rLouUA95RINSZJU5m3mIJVgdO9uUk1Qm3xKvUTnvIEn9cfMwc+Pd1upm2Z?=
 =?iso-8859-1?Q?Uomz1uUSPOddVk37X4Bg9B6/lGFFST3lg7tVS9NxGpK2UNrRzSZGxYapz6?=
 =?iso-8859-1?Q?AotMX3ZF7RZwUXsobKI8ZxrLbEjp4BVfXYsn7axi79B7TW7EoRZd1LnuD+?=
 =?iso-8859-1?Q?KogQamLNYVd9vJ01T47/QJbHbP5uG5mZ84EDYo2P3hYpGHojSfcChEeFyc?=
 =?iso-8859-1?Q?VlRwQJTquKXaGYpQL64H1dIsAPG0mCtJbKOdWkksgDrePyBAhcjtH7NxIh?=
 =?iso-8859-1?Q?OH34bpkdwt1zLo2905VgvX45h/JVSzkc6YNeYURjNbYwgkOpWN08rcQziQ?=
 =?iso-8859-1?Q?clOVHkK8JPZfo5naKrbgZk41GznjHab3Um1zdCAVWbWQQw98ycUep1hi/T?=
 =?iso-8859-1?Q?aGEOTZdlg6UHWa0UfmAjGJOT4STOY6C9SM1Vyoc++QLNqUXPP6EovxInuA?=
 =?iso-8859-1?Q?JOI4+qGu3Lj44Qxsj3AKRSNRCQesrez9lJ336IfsfZjuSkxKs57d46Myw/?=
 =?iso-8859-1?Q?azCW8Tq4y37J5f61O80v1/ss88y2Sk0QRklEaC20EMuprBx5sT9W5FtzBA?=
 =?iso-8859-1?Q?PgrgPGuibdNIx6HE6VH/r0xE/7raCLhJO56HVIbggy2SQvfIu3VvGu8NSr?=
 =?iso-8859-1?Q?Y2Hab9FCjQ4++tAkVVYNeZ3nrFqUhE3gtxyGqgaVtV9+sAPQNk4zfsj9uz?=
 =?iso-8859-1?Q?k7j0CDxUV3AKvk9eUknL5vjN2EbmIP6naybe+QHgEedFrGZ+xaG9f3EaJf?=
 =?iso-8859-1?Q?cmuzXUIcY7FiPr+vOeAYNK3o9STuwHQaMnjwVcAP00p5TPS68JUw91tmyr?=
 =?iso-8859-1?Q?7DBi/8UEnd3rzWwRh4k68Y+h/LPeeGTYFBzJZvlTAMZOEWqlRrrxydLgd7?=
 =?iso-8859-1?Q?59dxaYkN+8YK/o8uN3s8iAiTjsUyPfQMHjQq/couq+lan2nInckSmZxMCk?=
 =?iso-8859-1?Q?28CczLi/0lARh9Udj37hrA9VWW1xWeLkzyvaIv3a/n+R9TMBATMgUTRoWE?=
 =?iso-8859-1?Q?c3XgtxLehCkQKx8lxBszie2ECXglS4Fp4mk/0L5pN3uHoy1rR5+U4tHRbp?=
 =?iso-8859-1?Q?0smv/6JmnwHW3MrOIYQX/GpTuFq0oaNkUeh+SBdt13L5p6dc4OzEWtJQ7Y?=
 =?iso-8859-1?Q?Fo0YET0AA9Cs6B8RpXfI4ZIeIYcctALiUQ8s3Pab0GShv+M4PvyOZlES76?=
 =?iso-8859-1?Q?guO45QqPRaj2mrlShuT4ZEmCCllUQK6tyrhI760E/sPMrulr4r/LKXYHAy?=
 =?iso-8859-1?Q?UDu4IWD4AChYk3aUXY/KlPkc/Z0Rx4/b48ISi9xlfklwMM6HEouN50QdzS?=
 =?iso-8859-1?Q?A5tQ1B7qHfBZSUwOcFn9qkKVs7jw/1m9uOy+JSnukJvWTJ+uJNwSddowCN?=
 =?iso-8859-1?Q?n+DD+aY3BbFxCapDZluQ60rH9TLmRiOyFYYhhVXuc8qVo1BR5b5an653oa?=
 =?iso-8859-1?Q?r7YcSuJn8K36Ik1+Lv4Dn1d/AgU1t9Vg7eYLstpLEN+OCTrkb8rks66hKP?=
 =?iso-8859-1?Q?B33Gbm4aRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d43325-805f-422d-41ce-08de7366a268
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:18.1051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tsEnAd32U4/5l0ewksDhQ9aZ4ItnRJIf9vbTla/i5tGoAOt6d3GzuXeGhCtDjLBLWpqLlTqLUtjmrxlUk8zIXYDWyvPbfxV0lwVmnBgjWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
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

Following review feedback, update the Aspeed I3C device to use the=0A=
DEFINE_TYPES() macro instead of an explicit type registration function.=0A=
=0A=
DEFINE_TYPES() is the currently recommended approach in QEMU for=0A=
registering multiple TypeInfo entries and avoids boilerplate=0A=
type_init() code.=0A=
=0A=
Additionally, rename embedded SysBusDevice fields from "parent" to=0A=
"parent_obj" to comply with the QEMU coding style guidelines for QOM=0A=
objects.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 16 ++++++----------=0A=
 hw/i3c/aspeed_i3c.c         | 35 +++++++++++++++--------------------=0A=
 2 files changed, 21 insertions(+), 30 deletions(-)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 7a984e1f01..bd0ffc84ea 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -21,28 +21,24 @@ OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASP=
EED_I3C)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-typedef struct AspeedI3CDevice {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
+struct AspeedI3CDevice {=0A=
+    SysBusDevice parent_obj;=0A=
 =0A=
-    /* <public> */=0A=
     MemoryRegion mr;=0A=
     qemu_irq irq;=0A=
 =0A=
     uint8_t id;=0A=
     uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-} AspeedI3CDevice;=0A=
+};=0A=
 =0A=
-typedef struct AspeedI3CState {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
+struct AspeedI3CState {=0A=
+    SysBusDevice parent_obj;=0A=
 =0A=
-    /* <public> */=0A=
     MemoryRegion iomem;=0A=
     MemoryRegion iomem_container;=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
     AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
-} AspeedI3CState;=0A=
+};=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index fff259ff66..e7cdfbfdbd 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -337,13 +337,6 @@ static void aspeed_i3c_device_class_init(ObjectClass *=
klass, const void *data)=0A=
     device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i3c_device_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-    .class_init =3D aspeed_i3c_device_class_init,=0A=
-};=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -366,18 +359,20 @@ static void aspeed_i3c_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_i3c;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i3c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_i3c_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedI3CState),=0A=
-    .class_init =3D aspeed_i3c_class_init,=0A=
+static const TypeInfo aspeed_i3c_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_I3C,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_i3c_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedI3CState),=0A=
+        .class_init =3D aspeed_i3c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedI3CDevice),=0A=
+        .class_init =3D aspeed_i3c_device_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
-static void aspeed_i3c_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_i3c_device_info);=0A=
-    type_register_static(&aspeed_i3c_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_i3c_register_types);=0A=
+DEFINE_TYPES(aspeed_i3c_types)=0A=
-- =0A=
2.43.0=0A=

