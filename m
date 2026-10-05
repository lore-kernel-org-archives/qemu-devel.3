Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A7ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 01:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDXra-0007wA-9d; Sun, 04 Oct 2026 21:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDXrW-0007vj-Vq
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 21:51:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDXrU-0000Oe-Jw
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 21:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOs69uIAA1psksQqYHvcPUEY32iqn4/O4B432DLpi8vMIpnXsbKJ1mTqKVMTub5MZ6ZuMVqr6vRASTyHVYM4ymCgGIThxCwMUmaYzvRslg8R76I9Gt92xytFsNRuUNjUutdMac4WVXawyQ+kz7GHS2H8zdZTcmbYNLvsVTS8a5SQVdiL/7vfnJKPLCWDpj+B3/uKUVC90W0rWQfBTtau1mTNAOSSbY+tvgDVQCMPwRnif8QKGSi4RWMS+UlYTiRUvKZ297yZKNMviCcCSDUG+0jGnRLsmeSfcWqLJw8QYI0gybzLedxqR+SraB79IoE6G9uCiY1PbVEyUPXkXwal0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIDBnqc/pgxwA0CPvy6sInKqjIh6wh9J8QXN3Zg+QdM=;
 b=apVIk10mqp8cYEGBz4/b3VP7BxDpgJz4pmIyes8rwEDxgS9mup+FLpCBdXfhauBUr0XBG7m0ItYvxdg9BABAfOt0ou/+Ei02rUgfKRsri+YhCwy1RKo1RWO0rbhRdIoWqNStkAg4uJlIR/Z13F7KPmmQOdlGSYaRxQBUEGThGIaH0QrbXsKn+bRMg7J4Mib7Fkt6CTDvmuWmo5dO15mWGMkN3E9TyU6HYEQnS92BhSxdYIaV5ILCJHz2uoiTmi0W3AwNl4jObEyiR2l4rKHzPOWH1HmaQ5gMFIswdqH8cEY1aBzNQ2hGIx9Nyy1OSc0DeZ4s9uudPVhPn3AcOHz29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIDBnqc/pgxwA0CPvy6sInKqjIh6wh9J8QXN3Zg+QdM=;
 b=oN77eEuzmmeR5uPcBgqrzXJFYav/X0jLjn1N8mYJRFlxxrIdtvkn2t4A6tQF/SNRgOhwpPpac2kdUqWPeIBBrOHBkL/M5m3fhh0IoTQzFOI+wKonwZYC+Y1fF5xN2c3Nm2SdAZojbp7/e9Lcmu3U9UPZM2Xo4c68587mBOOlhHpI+voFT43ai7FbM13BuIiSOOeBnWkK8zEUnSxJQpo19ITvrCs9+R1dvL+w0YiXnWHLthH8MA620+LYzI0yIIgMD09F2RgsBdblXhyjV3ACSO9Nm5obr8tfTqa6mRDg/kq79ZiAT/uigS+jn596zw5zqZ1uqfv1edyshTTq5hTFlw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PUZPR06MB6186.apcprd06.prod.outlook.com (2603:1096:301:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:51:22 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:51:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Peter
 Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Thomas Huth
 <th.huth@posteo.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
Thread-Topic: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
Thread-Index: AQHdVGveNcCzyGnaMEeV50pBxdgpv7buLxYQ
Date: Mon, 5 Oct 2026 01:51:22 +0000
Message-ID: <SEZPR06MB73627886C2A3216639C727D4FC962@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261005015015.3466808-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005015015.3466808-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PUZPR06MB6186:EE_
x-ms-office365-filtering-correlation-id: ab4121e9-26f4-4fec-5ab1-08df22832881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hdlOy5FnFDD/+ynFUJU4C8R2iW8+w1UFHVzbPbQ0ASulMWrEuNbMZHD7lx7kkjq3eV0SCzz4MWYEe1WkDzMb0lsOeLUtT133iKa+sRO0rK9qSDsdyTV+i5wVD8pOrSm/NiGG+Plxskze8eR3VbywMbGYvsohR9HeKukE6gpBpTyC0qNoO5R/KnKojU1XiJkbkgri9iDueSRcchNrJ4iEviv5ZDigq2dw4OhmmBrfFvCfU7UPlyk6oIQw5uSKRxCmyYl9k0evIQDZfEz1pnXH+SiKLOoxaAvoJ24DlmX5gFHybapzaYqy2MCC8DK02v3vnOkdJ83OpQvAgv5zuimx0p/SzTRdvQAwBqfAdksB+yt90uc3ec2tFnlV+GvXtG0PcCxZ92TLEm+C8r6HfjLeayL9gdvAnHJhg85ulbw3qKZZ3OsytbDCIv/jRg7LJUXxwsofnZ+RWwEGepoHgtxklQ7gkBhnR+/u+EqcF1ZlXZ086NwH9Si0VWh5tVWMzlwOuV35A6ZwZj/NJ1M8EOf642p5yLg0Mtwna6XIory3PM/rcYcbaKl6nLG6zPbP+eigGxwlWPRk3gYrBgWLD/fAF6jUxfFDJWXADjyD3aelW3ESomIxMI1MRCMEQhjP50Gv7mHRltKFw+vyeFZJud9NGhT1dm50eLHLdFX2d/ysjF8BGmdqeyQ9fBSoOF8OYpWg/hFv4fOG2SHVNJ1f7KGiBHm/fEM/yjRw4Ltek0bg0bM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a9H837/FWUxJv3gzX34jhf56AxUqZg9X7ldXANgRFA4EFmElxiuKLxy1vF?=
 =?iso-8859-1?Q?0Y4/nj1+7m23B83j1WKow8IlmlkgZGnW4V8zv22GHmhoqo5riwaSPAtn6C?=
 =?iso-8859-1?Q?q5mIGL+NEQpIZbA42G7XRnd9/p9jc/ow3iZHKNMTNfcFhV07Eu4ycZYiny?=
 =?iso-8859-1?Q?OjcWdpVdpHr63kBn9FNje7L8SmcqVlEAjGOKbvqhXURQcIRI2n/P85ZIc+?=
 =?iso-8859-1?Q?+9e9hsirLnJ6NcaY9wEJ0gmpSMzeHp4FLRxS0eBB49/PLUQ54RsYyzddim?=
 =?iso-8859-1?Q?Gt7/FrZfIADWJWGJJ7Cyf1+OI+ySZT4PXQsO+hIBeRv+dsP9uT9fvFIvv8?=
 =?iso-8859-1?Q?fPXGGRBKTZU131shICKf0jwGEguCn6OFbvaP5CMQe9PXpX9YVgKyhSWmzi?=
 =?iso-8859-1?Q?447vOW2x1tGrD7mnjp8gGIg+K4LFsc0yD1ccb/v9gJM/gpSziuYCDAzj4x?=
 =?iso-8859-1?Q?/ah5yYe4S7TlpeZYRezjTGntcyd+KxSCBmgkMJk/peAQu4NfRbuW8Aebp1?=
 =?iso-8859-1?Q?AFZsWCiprwHDh+Qe3NLUw7LyGlOGStWZwVW7FdYMDeewFEXzCyM0cZAOQi?=
 =?iso-8859-1?Q?9VyEQ048HgTrKu9lTINETEk8Z3E+rzJrmhCVhKUj/SAuNu8kS2yol57oox?=
 =?iso-8859-1?Q?6KfE2aepgqsLwPH2lw7HlU/yl5R0SJiZPMovIKirO2Oi4Sot1R/+isYv69?=
 =?iso-8859-1?Q?rETOOtvr8RdrULZWQk1+1X0Gd2RtPFmFrEA5aiok8a9Pwcfp3c8mu4vpKv?=
 =?iso-8859-1?Q?pvKKv6SbhrouBEc0/YE5iL8S7Xj15icXc3LHbdGyTAzhEj3T1ultESrWvZ?=
 =?iso-8859-1?Q?bxih6o5JcCLGgPYX886BPHm6M5uas9Sv96Fo67hDmI8Jpu2caaCkEta0tS?=
 =?iso-8859-1?Q?JplurIDNgNz+NICZpPgVPdFdIMzJHMcWeeoDW7X9iQCoN/5F4DzM+jZhBM?=
 =?iso-8859-1?Q?/cefvuou30LqtVIXBtgxGTCHQyqFjNFltjGJVQwwIulLFq+xIxD9ldvbTi?=
 =?iso-8859-1?Q?3U012qV/s2lAdKDin3sMBtSUE/F0BjmSpOOk0ZCR3jTrRvkiyEnr6q2JWI?=
 =?iso-8859-1?Q?jbyPU1ZjtmO6fLfiezfBcqSpQNfgr9Ch6QQyh1NDbk4iQJr7BV33Uufmx0?=
 =?iso-8859-1?Q?Uneq5SzHlX2ppuaPegOlEV9eYyWqfRP3cXwjrEWdWsUKc5JTO8aMIgZsmF?=
 =?iso-8859-1?Q?xJljSJb7fWAXkNLwYPJ2qr+RJQJL+1SfNWFhSQshBThbLru+lYXWkZqlFv?=
 =?iso-8859-1?Q?iwM5rhz8sY7rstenqcjeVKAFxtI6dtmNci7fk+3yzNKFD6wB0nji4dJc9W?=
 =?iso-8859-1?Q?WCKD3pT9niGpBZSp4X/jnIfyVZX5bJsGu9t5+PpdPar5QnuKVJ8V2iv2pc?=
 =?iso-8859-1?Q?dBV6Dfe0pe+UZaFGZ+oy1gt6vK/BMUbuzRl4eGFjSz1KupUvw9lGuYa6iB?=
 =?iso-8859-1?Q?dh8ptsNsyPxxrJ+w6t7s7hIqAg0v8RDmaxzhzsENKmo0FEMfHbAno4CyGz?=
 =?iso-8859-1?Q?spEdDBUth1Ks3edY6aws/VfM6RvgwE2Mk5Cja7OQW4XJHlLIMDGsfnhAzc?=
 =?iso-8859-1?Q?HDln9KQPVUgEO3UVPASHEiV5hXtM/rBN8QpHmRCQQcCoyYPFYr1hckbanr?=
 =?iso-8859-1?Q?YiIrkEmIiMqy2FL4+sXOcHzaZ8Fm4ZkIvGL8ozjnwC6wCseTNGGItqFc42?=
 =?iso-8859-1?Q?DKbzaPOxtAlZeSvHn7MBYNqMN9NyqFBPJRT1sp0yx4T0uOw0P8jou7XAbY?=
 =?iso-8859-1?Q?ixTVyp05tCiRI4m48WdiqrSWMmiwChWb/2iubPa7LkMSIWgdYz75nUhgF+?=
 =?iso-8859-1?Q?gO3KHA98hg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4121e9-26f4-4fec-5ab1-08df22832881
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 01:51:22.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzBFl8mV14gGUiQUFBh779kHDAPR6+ANdltfus6F+Q9ef04AEP333cCv+Dt2N/rm9u+1A3hM9ne6fRF5+V8Ln/H/c4sgdh0hiHJeJmbTCrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6186
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

+ C=E9dric Le Goater <clg@kaod.org>

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Monday, October 5, 2026 9:50 AM
> To: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>; Peter Maydell
> <peter.maydell@linaro.org>; Markus Armbruster <armbru@redhat.com>;
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>; Thomas Huth
> <th.huth@posteo.eu>; open list:All patches CC here
> <qemu-devel@nongnu.org>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> <troy_lee@aspeedtech.com>
> Subject: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
>=20
> Update the ASPEED BMCs reviewer list to reflect the current active review=
ers.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  MAINTAINERS | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1312bbd1bd..93a23526d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1265,12 +1265,8 @@ F: tests/functional/arm/test_emcraft_sf2.py
>  ASPEED BMCs
>  M: C=E9dric Le Goater <clg@kaod.org>
>  M: Peter Maydell <peter.maydell@linaro.org>
> -R: Steven Lee <steven_lee@aspeedtech.com>
> -R: Troy Lee <leetroy@gmail.com>
>  R: Jamin Lin <jamin_lin@aspeedtech.com>
>  R: Kane Chen <kane_chen@aspeedtech.com>
> -R: Andrew Jeffery <andrew@codeconstruct.com.au>
> -R: Joel Stanley <joel@jms.id.au>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/*aspeed*
> --
> 2.43.0

