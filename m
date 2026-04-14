Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BFCF34C7E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 05:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCW9G-0000YZ-Qt; Tue, 14 Apr 2026 01:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCW9A-0000Xl-MF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 01:17:12 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCW98-0007jW-B8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 01:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG8SbgB2QrIY/5Sa2jCPdrDHXuVM4Kfu+zkPvcSq+zGq/nWMJHPaiy0VpEr8LZuIQzeKVGjQ7T5CxxY9zvEeA07S/5shbE7z7wrZlSX/minzV2r7+jBfeHpFSmEgZIL3rHRqf29EdtXbrKsilpjMd1uMQ0KJYnjPcKyxhWHIQGL9vKbab9p5ZsiCdXhMSR8HTesvH9exYC4y0qIx1qxKgbTl/xUNmJdtrSE/mLG3b57mQp+q0APCyWbYCTGiY8gIu1JbZYdP+dnA+ZKuEjYziWNbjZcZOvMiNrRyAeWuAz3TKbx5STtXxb8VVgZFWsFgsipgImzIyqRVTaCsfeFHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7P5TQEgeip1+ucB7FeQss1bkO9awhkl13a+eU09ru4=;
 b=n6k1OMRzte7/l8LCq9E3592nzE7xaybmRo8f3uKLDJoTac9oK8Qx5UU8YQhiagNpJzs3oICJIm5o/Xk49Jd5+P2Qkt+5YKdXptise27KGzR8uj2M6rKUy0SRiX4sv7WY+IFCIOa5PrsHnDm8AwzSa97p0osZmBAQThp3v62XCfDgqDe0gj9A/YXLIDwReRY16iZ7BquTeporuXaa1UI3Vv81WVDvd1h18qxBRw2JwI7hSWwktcfO2Ru+oH3iVWiGKwVQM6bHAE6cKLTXZ+7VWuOriTV90d99Ipu0Bsf0qzNXzV0PJ14GzaMSQ3CUjnUUVmlr+e+AfCvy80RJ/pxYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7P5TQEgeip1+ucB7FeQss1bkO9awhkl13a+eU09ru4=;
 b=GYYCN/fLJdOE7kLU/e6mfm94Sb3pfH5BqUsEZlPSRoTAhxVrioNGokudw6h2LJhNeTferv7yTiUtxaUYlBazXYnJrTjRzbXn0DqIaXIG0uZg9oeYSf1EYOee7nibBKoLafMXNfo/xJbFB5LqzQM5HqWUsGHSVvVOloynqOgaec2Et7dQGyDxPnuYswJxHmpU7UkWF49ZvnzuDhzMcH9ruJ9G+K7QQ1wKdCWOkujgoUfWxoP0k8eqLI7MkRtXBQD9ovjMq3BgsNzt2UFWjnTR5snRsBjWR09g63MbPcfCqVDuHi0MDRPnE/3tPZo9ycOGAfKkxRIcFptvf91w5XIwLA==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by GV2PR04MB11921.eurprd04.prod.outlook.com (2603:10a6:150:2f9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 05:17:06 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Tue, 14 Apr 2026
 05:17:06 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcyxhq2POQGlihkUmOWoImS6Nbv7Xc/V4AgABboCCAAAaFAIAAGGWAgACNCZA=
Date: Tue, 14 Apr 2026 05:17:05 +0000
Message-ID: <AM0PR04MB437078A384825E22C9B6B28287252@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
 <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
 <AM0PR04MB43700A10A6F9E20DE479701887242@AM0PR04MB4370.eurprd04.prod.outlook.com>
 <AM0PR04MB4370028D6C330307CADBF81D87242@AM0PR04MB4370.eurprd04.prod.outlook.com>
 <AE626996-1262-42ED-8400-9684DA86F871@gmail.com>
In-Reply-To: <AE626996-1262-42ED-8400-9684DA86F871@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|GV2PR04MB11921:EE_
x-ms-office365-filtering-correlation-id: fdc2d7f4-d26a-4ab7-01a5-08de99e511eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: YJBZLCYugCZOroj05CJ8G7HyAzZvMnekIIw4VlZpU/3+N0ZlxSV6te4s97qfBRWYGAmfaD6QwW6r/iWzffbrggaKVcCuf8upJwlqtaelwPdV4av6m1ngVOOKUwYszgz/s/SE3+AuzFmmFktd5UnDkeFordPPPNDyyOJeuogJ8GE1KI7cOLVthIoBm4ZqkpS11HqanbsaRZWAc67EsDap7OAnqB42lGmxRxYvIEKIigRugeNY4JqRDPdiEUw8BpXXgWTfZzSnRs5x4idW7xwDbr1YWq2es5Cj1XToAgLezgwIUu/w7YZuSOuJ3ECC5tDqj9mV4kQqrbW05iuSYMOSvIq274x5Qww1TJrF3A4oc50z9Td4biUFI0X1DdVKVNlJ/vIpFibc1PYQgxl9P+IyPl9egvpSym1Y5TIl3JyFwDCh8g8J5AlwYovk8vtErFkQsVmlpvT3keDqTi1IIHesU64YVAgwehy2EzG32iu+3Gf3zq5kGhqGXUtML/ESWwIT2xBRmFKeIugPER9ilteQVUHsxVuswfiLcQG9N+yNE1qVcCF9zuc/o0+DBhfgfLvurL9yfD2co/zOlg2r+Uxqh2JXh6cVwniw0tE1bWQ37Upp7W3q8DO4YKvorjqyq9NXKwI7eGiaVKp6vhg57gI+PyL9lzq/+JZpPYnU18/NHPNBLbWdojmL/R3RmVLYHOIVEcibkX8OPD4lv3Rve58dCMQYNZED5Wq6ZR6qppEV6Qzp5S+E7+3lobH4QDohCByW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OIfdG3ldaQDy3HeVD8RsjtevmmSTRNAEt55yvTbp7A0WRN/FJfNYmJswMLkd?=
 =?us-ascii?Q?oHgFclmYywXwv+qGGou5T9zXlkiIyh0RK9ud0nnD5jUQB3YKveUxplV4iKpV?=
 =?us-ascii?Q?S585ETTtuvVElQquydDWeqScrFYU6KkjZZASzeley+ot6Ce1cToLporl2ERH?=
 =?us-ascii?Q?ZX9U2VkuHrIuL9gxNwcgDDvBtFtv06PJv5kfeR3LCBLkF+7INzAIl+V2s2nV?=
 =?us-ascii?Q?0WHybECtY5QrwHLvGfMCDeRB7CFe23wvvkDzo8uTPFeEzJIACg7gPZ3DYX1z?=
 =?us-ascii?Q?1jumG7gr+69F0sjcPmxp3Yd6ORfHRodO7L7WKGBHLoQnH2Q+DJdtJfQQ/7id?=
 =?us-ascii?Q?1qDYN9IewL8GknbNzfz+w8mJ//biFb7qroqCNzMkpHRs9o3HSR7FcnKyP6V3?=
 =?us-ascii?Q?gLZJyrR7uAGTpIb06vSzvKRT2r/F6SFvh9kXL4NMGiYs/x7cqZMT1s0jIfKe?=
 =?us-ascii?Q?KG4Fmn3wR239SGdWkP4lM5ok05neAXuh6BKuA/Xe7GSHJeycBhVmBdwMPP3/?=
 =?us-ascii?Q?HUwTZtmZYTwfUKOtFxRn60FNF8saSNU6pTJ/Z1our5szGcA032PyIHvYoKeR?=
 =?us-ascii?Q?7aWaTj0bpxAxHnLqc7HWh37s6J4qiEcBFiCTKt+EM25I/2RrzdDHbcyQIbqc?=
 =?us-ascii?Q?8FWrK9vl4aQoohH7hhXKE8BMokBi3XAahbIWhNq+ODsZ3LKf6JtzSxhN2YYw?=
 =?us-ascii?Q?LdZAhF1/Eklrz4Wd4b3Q5PRGdYYQjWdMh3uGoWulteIx5XhbqwN+6WN2TDol?=
 =?us-ascii?Q?SeGxMGKdQp7vUGKZuqZ4nuBrMbbuTQyHupXxHK0+2A9wmoZeMRLWWWwb4nUE?=
 =?us-ascii?Q?mN72Jl28kKfsbRyKwjJmX+RB/PKf9m0yqhh3iMkNXSWGcuTpGRAVzGm/3JbT?=
 =?us-ascii?Q?v8HPP456haJd2rbzavo2NfASBHPpU39RGj++/nsp3Xs9B+yJM8u6v0ohU51n?=
 =?us-ascii?Q?aAtxyAFcJ4IVLQEJVauj3VtkvtkCCTsOPNAy5oNZeAxJrY5l/MR6RpMcYcEr?=
 =?us-ascii?Q?pZI1bOrPlP09Raj9YQlBKN8C/3AQbmg83tfGT4Q7WWIFevHeiSRewdXWLxJD?=
 =?us-ascii?Q?pqo2513yswHIgcc3T+pKic4aIouoDgpDLDsLnrwNiBo70GLGk/65KZYTE1j4?=
 =?us-ascii?Q?VlMdz0wSTrvqcfdDzHS4xD1+muaHsnKAYYzB8V7iMmPpOciUn71CkptFzRz+?=
 =?us-ascii?Q?N5193Vc9Z7PgP6Eb7lLSHjq4wX3eCZZKVgPWdY0z4ui4a3maJKj5N+41tc9W?=
 =?us-ascii?Q?Kf6CcKr40ZQ9l0EfK8oSjilwQmosyxi6AC4junvX06I5UFoahKr4oDfKgx6m?=
 =?us-ascii?Q?Po8hUQ3ergcygYyBcgKZ2/b/UmREbNPdq6+JqGaKFTMfngp7iigqWNbLhlm2?=
 =?us-ascii?Q?UlzzMIHp/rlE6pOqy3qULk4ymAF0YBQAENLeSLs44Dg5Suuyed3bD2p7urjv?=
 =?us-ascii?Q?Ry0mWIdYMBSwXjQbXDwpUt9BNT6Q+zHxnbCsLUDl3uK+uX5MFnglTHKMhLCX?=
 =?us-ascii?Q?Dy5zi4h2rFrjqZAbZ5U6eONlFQNQWsM2R7mTx51vawab9V7JAvugr4mstcj/?=
 =?us-ascii?Q?CznXZcWDCttN8638BKf0zDh55vg9bvZejjCW8ORW4Ysm0XdmBmsvKMpwr/L0?=
 =?us-ascii?Q?jO/OfMB0xgu+m62gbZ/1xJKOYh89yGX8XRTHGHWgxL5EPVDUtZs1j0l5Z7Zy?=
 =?us-ascii?Q?30TwXmQ79UPKEa5Ynt6JJKeUn14PDZCMTFzfPkBN4BAS//zOiHwGH2K4Jh48?=
 =?us-ascii?Q?gX51YXm48A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc2d7f4-d26a-4ab7-01a5-08de99e511eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 05:17:06.0059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3gAnb9dci5xuQCwU11nL/XsxMTlhd0c1pVccr3PMzYLZvKQPyNd695vzhCGM4MQtFVWJsQp33qLMXFPjnEtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11921
Received-SPF: permerror client-ip=2a01:111:f403:c201::6;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


> -----Original Message-----
> From: Bernhard Beschow <shentey@gmail.com>
> Sent: 14 April 2026 02:20
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
> i.MX8MM EVK board
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 13. April 2026 19:54:29 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> >@'Bernhard Beschow', after I rebased to master and build the changes,
> >so far I have observed build errors like:-
> >
> >1. 2 of those attributed to qdev-properties.h header file moved from
> >hw/ to hw/core/ 2. 2 errors attributed to boards.h header file moved
> >from hw/ to hw/core/ 3. One attributed to smmu :-
> >
> >In file included from ../hw/arm/smmuv3.c:37:
> >../hw/arm/smmuv3-accel.h:17:10: error: #include expects "FILENAME" or
> <FILENAME>
> >   17 | #include CONFIG_DEVICES
> >      |          ^~~~~~~~~~~~~~
> >../hw/arm/smmuv3-accel.h:44:8: error: attempt to use poisoned
> "CONFIG_ARM_SMMUV3_ACCEL"
> >   44 | #ifdef CONFIG_ARM_SMMUV3_ACCEL
> >      |        ^
> >../hw/arm/smmuv3.c: In function 'smmu_validate_property':
> >../hw/arm/smmuv3.c:1968:9: error: attempt to use poisoned
> "CONFIG_ARM_SMMUV3_ACCEL"
> > 1968 | #ifndef CONFIG_ARM_SMMUV3_ACCEL
> >      |         ^
> >
> >Build command used:-
> >
> >../configure --target-list=3Daarch64-softmmu make -j$(nproc)
> >
> >are these expected ?
>=20
> Certainly not, since we're close to a release. The only advice I can give=
 for
> now is to double check against imx8mp...
>=20

Got it. Build is fine with the changes now. Sending in the v6 shortly.

> >
> >
> >
> >> -----Original Message-----
> >> From: Gaurav Sharma
> >> Sent: 14 April 2026 00:30
> >> To: 'Bernhard Beschow' <shentey@gmail.com>; qemu-devel@nongnu.org
> >> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> >> Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support
> >> for i.MX8MM EVK board
> >>
> >>
> >>
> >> > -----Original Message-----
> >> > From: Bernhard Beschow <shentey@gmail.com>
> >> > Sent: 13 April 2026 19:01
> >> > To: qemu-devel@nongnu.org; Gaurav Sharma
> >> <gaurav.sharma_7@nxp.com>
> >> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> >> > Subject: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
> >> > i.MX8MM EVK board
> >> >
> >> > Caution: This is an external email. Please take care when clicking
> >> > links or opening attachments. When in doubt, report the message
> >> > using the 'Report this email' button
> >> >
> >> >
> >> > Am 13. April 2026 07:37:22 UTC schrieb Gaurav Sharma
> >> > <gaurav.sharma_7@nxp.com>:
> >> >
> >> > Hi Gurav,
> >> >
> >> > >Changes in v5:
> >> > >- Fixed SoC object reference counting by using
> >> > >object_new_with_props()
> >> > >  instead of object_new() + object_property_add_child()
> >> > >- Merged imx8mm-evk.rst documentation into imx8mp-evk.rst to avoid
> >> > >  duplication and updated the title accordingly
> >> > >- Added on-chip RAM (OCRAM) support to match iMX8MP dev
> >> >
> >> > I tried to apply v5 but I'm hitting the same issues as Patchew:
> >> > <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> >> >
> pat%2F&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7Caa935d96ff2e4
> 05ac
> >> >
> 8cd08de999e31c1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 9117
> >> >
> 101899885925%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW
> UsIlYiOi
> >> >
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> 0%
> >> >
> 7C%7C%7C&sdata=3DJAaw56sBFbwFFHt4bHO1Zt51fDkADIqVN7kPV9Tkt%2BI%3
> D&res
> >> > erved=3D0
> >> > ch
> >> > ew.org%2FQEMU%2F20260413073737.986219-1-
> >> >
> >>
> gaurav.sharma._5F7%40nxp.com%2F&data=3D05%7C02%7Cgaurav.sharma_7%4
> >> >
> >>
> 0nxp.com%7Cfbdcd381f0014ebd086a08de9960ed16%7C686ea1d3bc2b4c6fa
> >> >
> >>
> 92cd99c5c301635%7C0%7C0%7C639116838724991885%7CUnknown%7CTWF
> >> >
> >>
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> >> >
> >>
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DnyynvYO
> >> > v87nTkxEFkU8k3eSt4r%2Fa17rQkr9STABgaaA%3D&reserved=3D0> Mind
> >> resending a
> >> > version rebased onto master?
> >> >
> >> > Moreover, you may keep my R-b tags which I've given during v4.
> >> >
> >> > Best regards,
> >> > Bernhard
> >> >
> >>
> >> Hey Bernhard,
> >> yes, looks like I need to rebase and create patches again. Lemme do
> >> that and send over as v6.
> >>
> >> > >
> >> > >Changes in v4:
> >> > >- Update Maintainers file
> >> > >- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a
> >> > >variant
> >> > >  specific property
> >> > >- Split up the patch that enabled CCM and Analog in the previous
> >> > >  revision. Now we have 3 patches to enable CCM and Analog in
> >> > >iMX8MM
> >> > >- Updated copyrights
> >> > >- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check'
> >> > >failures
> >> > >
> >> > >Changes in v3:
> >> > >- Minor documentation change - Added KVM Acceleration section in
> >> > >docs/system/arm/imx8mm-evk.rst
> >> > >
> >> > >Changes in v2:
> >> > >- Fixed the DTB offset in functional testing script
> >> > >test_imx8mm_evk.py
> >> > >  and preserved alphabetical order of machine names in
> >> > >tests/functional/aarch64/meson.build
> >> > >- Fixed a typo and updated the documentation
> >> > >- Modified structures type to static const in fsl-imx8mm.c
> >> > >wherever
> >> > >  applicable.
> >> > >- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-
> evk.c.
> >> > >This
> >> > >  is needed because the default DTB in the iMX LF BSP images have
> >> > >CSI
> >> > >  and DSI enabled. Developers/Hobbyists using these BSP images
> >> > >will
> >> > >  observe CSI and DSI crash logs on the console since these are
> >> > unimplemented.
> >> > >  With this change, both debian and iMX LF images will boot up
> >> > > without any
> >> > issues.
> >> > >
> >> > >Changes in v1:
> >> > >
> >> > >This patch series adds support for the NXP i.MX8MM EVK (Evaluation
> >> > >Kit) board to QEMU, enabling emulation of this ARM Cortex-A53
> >> > >based development platform.
> >> > >
> >> > >The series includes:
> >> > >
> >> > >1. Core peripheral support (CCM clock controller, Analog module) 2.
> >> > >GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation
> >> support
> >> > 3.
> >> > >GPIO,I2C,SPI,USDHC and USB Emulation support 4. PCIe and ENET
> >> > >Controller Emulation support 5. Documentation and functional test
> >> > >included
> >> > >
> >> > >Key features ported:
> >> > >- Basic boot support with Linux
> >> > >- UART console for serial communication
> >> > >- Interrupt handling
> >> > >- Clock and power management infrastructure
> >> > >
> >> > >Testing:
> >> > >- Linux kernel boots to console
> >> > >
> >> > >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> > >
> >> > >Gaurav Sharma (15):
> >> > >  hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
> >> > >  hw/misc/imx8mp_analog: Add property to analog device
> >> > >  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
> >> > >  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
> >> > >  hw/arm/fsl-imx8mm: Implemented support for SNVS
> >> > >  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
> >> > >  hw/arm/fsl-imx8mm: Add PCIe support
> >> > >  hw/arm/fsl-imx8mm: Add GPIO controllers
> >> > >  hw/arm/fsl-imx8mm: Adding support for I2C emulation
> >> > >  hw/arm/fsl-imx8mm: Adding support for SPI controller
> >> > >  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
> >> > >  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
> >> > >  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
> >> > >  hw/arm/fsl-imx8mm: Adding support for USB controller
> >> > >  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
> >> > >
> >> > > MAINTAINERS                                 |  10 +
> >> > > docs/system/arm/imx8mp-evk.rst              |  33 +-
> >> > > docs/system/target-arm.rst                  |   1 +
> >> > > hw/arm/Kconfig                              |  24 +
> >> > > hw/arm/fsl-imx8mm.c                         | 704 ++++++++++++++++=
++++
> >> > > hw/arm/imx8mm-evk.c                         | 130 ++++
> >> > > hw/arm/meson.build                          |   2 +
> >> > > hw/misc/imx8mp_analog.c                     |  12 +-
> >> > > hw/timer/imx_gpt.c                          |  26 +
> >> > > include/hw/arm/fsl-imx8mm.h                 | 242 +++++++
> >> > > include/hw/misc/imx8mp_analog.h             |   3 +
> >> > > include/hw/timer/imx_gpt.h                  |   2 +
> >> > > tests/functional/aarch64/meson.build        |   2 +
> >> > > tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
> >> > > 14 files changed, 1251 insertions(+), 7 deletions(-) create mode
> >> > > 100644 hw/arm/fsl-imx8mm.c create mode 100644 hw/arm/imx8mm-
> >> evk.c
> >> > > create mode 100644 include/hw/arm/fsl-imx8mm.h create mode
> 100755
> >> > > tests/functional/aarch64/test_imx8mm_evk.py
> >> > >

