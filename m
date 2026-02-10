Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D80EA3F2E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjm2-00024e-MB; Tue, 10 Feb 2026 04:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjm0-0001ti-Eh; Tue, 10 Feb 2026 04:11:08 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjly-0004mZ-Tt; Tue, 10 Feb 2026 04:11:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWFfrKX/bRrjV+cDZoDtronhPQQF5+kxif5dpT9z96/PIY++blCRIwgjT4A2LQQWn2ZvyOpY386bAc4hjI2u7FxxH0JyKfgFdAAtb08W5goobGueOkBh8wU/jQTO6OBTP/+52oaxO4s9SDPfVsP/32WMNMLZkCZHLF+1X5CJ5LkYU3xyJZnRH3KAXbxn2jpxfmFhArd9v0Rcwo71dA6CTDk4+gU44R/odT5KmpYmyWiM2tgOwWUBJ/tiWYxGdVfTcsZxLxcYlbzji7L9EH0n0DI4S3PNjKXvdzxvr62aLI0+yKHjxl2zaXsQ15DE2RKAfGxtrB+5UwYP1+IXdhX8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/POID4vn3hJIrgGxh2Q0TxFbvEOWqfR6BvcMHnLlHNY=;
 b=erK0lNQjNMD1/CXNmf9ryjai2n8b576BxPNJubiEPmz7CNc3MDL0xjFOK3S1TcREwKTM9EG/3qaPDFv3iZaBwpjKYMqKstxDI0ZM9v02krGpN7OpL8Ult958mp6VIh1+bpnuRY0t3WXBNiOUYLXWUbNPz6l8GFPQbTMDA6IAgt+M5/TYlvX3rSFzTU6z3z92CtcA8udWZhi47bKp5jqR1465d6lO5uV3zVNjMwTBbbdM6CqYaeeLsPptGl911dqbWI8ZkR33Tp+1AQLSlO+26iJL2cDgIwSp5K5vCXr1XGi7T31ZtX+1abKHEGwcWvmwEmX2sDwHwHo3uOwHd9iDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/POID4vn3hJIrgGxh2Q0TxFbvEOWqfR6BvcMHnLlHNY=;
 b=Ps51KwiV+a4mDmZGIlTM6k7a4rxXR3KjwRBMgUO31yCV72kUEyuZLY6vhJcWxYEAgvbKxFvfvv1vaOWpzQEECXwNG7IJf/EkphCD0TiBaMYr3WarfQkJPi0QHXX15GznR3uz3tt8gD5J6aG+0ZTZE8tjxMjFykWXu1FbKjPb2S4uVE5oxY0JlWCVdP+/OO2/znZlbahtLroyJA6h/o0AlU1p6DIp/CxsC1Ald0nLiac7WHWCHVsGIzmK2BWZeb3zv4EHK4OSJo0yAmQFDfMHNB3cY/fMyuHd3aT8t3bbEaSnOXPzEcguX7qzcQ+tFT6G0ZiaumOT0ahWx3UwEyrWEg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:50 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:50 +0000
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
 <nabihestefan@google.com>
Subject: [PATCH v5 21/21] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 i3c functional test
Thread-Topic: [PATCH v5 21/21] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Index: AQHcmm0mCt+TkxdwhUqGE8n0PP8BFw==
Date: Tue, 10 Feb 2026 09:10:50 +0000
Message-ID: <20260210091018.1553489-22-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ad504e9e-232a-42fa-4c8d-08de688448ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vzHxioJ21D4EwnO1DQAbEKe5XBghXmMxAZMw8D+tvydOqlGjORleVlHp+u?=
 =?iso-8859-1?Q?DCigsh387vVrh/iJ4j6dbCmb4kZ/92JJgtf8MUTNveRot3/C4ejebcNxsz?=
 =?iso-8859-1?Q?TvXkYUAySUzzgTMwE29bnYF1gfo0IgK4ULYSQ0Q3nYKpv8Xk7xlC7XEhFm?=
 =?iso-8859-1?Q?kfREzQ/SLD4FiqXX7IF6ouTaeYY4UW5jRA5p7DSoqNwGWMVhOUR1GTaL01?=
 =?iso-8859-1?Q?FgL4SHvYZ4La2W+6mfRCyVuqw06SU39vAthEIVen+Ip1eeg+fhwc5P67wY?=
 =?iso-8859-1?Q?b/kdk65JXYDPY6qLBiDFWZDN5r6b45d7vexC5HNfRdZo9EFAcy+3lxAiUK?=
 =?iso-8859-1?Q?WwCNkTA+vhPmn40GcEbO7UMkNIVTcSzIuZZcp8buyv33JpKuynjRBGz23o?=
 =?iso-8859-1?Q?Pa6dG+PbLzanJ3RQPy6ctxD8+H3oK6z14CdFgGxCPVJt8d42mCCfchUCsW?=
 =?iso-8859-1?Q?xgzHyqPx3axLV/GBgpWtuZjHzSOcAG7KPwUAQvffmHCY7xLjfT2/YgkqYe?=
 =?iso-8859-1?Q?j3SxfqD5qqoEALuJhHLboM+44SOGILTkP+YQ0HR7UpXufxPW3q6IC9h1QK?=
 =?iso-8859-1?Q?k5U+snFh5P0/ytrIqTPe+qMUuHj6xZtk926dnDykTFTABGCLact2B0hPHZ?=
 =?iso-8859-1?Q?QsgssBjP/1i7lwV2OASV2Mv8tpnsZFCLFV0iRRYRICCDRK08U3Z9JUBSml?=
 =?iso-8859-1?Q?y3sBoo8OiodFy9rtO0P9PkHkZbNQFHSiyl0DgL6HO3b6SB0Glq+6BmOn+c?=
 =?iso-8859-1?Q?pUFe4kAD+1fNqzhJoHr844HeLc4Ag7yxRepxZuNUccOKJVevyb3udqlXGM?=
 =?iso-8859-1?Q?9apacQfWzLrGSWsjpyCcHCzQLNpeiB97MG/Q3XhAm/uD1R6P4NKgwP0fSK?=
 =?iso-8859-1?Q?9FzjRAhhJSssb/vQvLxD9ieZMGiuh7aiG9pY79HY9RslGu0CgTMY4FfdNL?=
 =?iso-8859-1?Q?4mhHtWFn7u9nGLE8CCUseoxtmKLJaIkh0/CV+JtDs+dm3sor5PTNtTwLKB?=
 =?iso-8859-1?Q?se5MsmzRQGIw9C8YDfNtYG8HxlIC0NAu5drQwLBw74u/Z1LfowsV1ao3aC?=
 =?iso-8859-1?Q?9c1HtfExBjawTth0fbtfvoOlXovmYIjwwCseiwsu92IcqXxaq7zlP080+1?=
 =?iso-8859-1?Q?UT2x7GBVMtQ4LaKjNIyAHrAjhOzetaTvLGjNiEo6/iYMz064nmBaSQ7EWT?=
 =?iso-8859-1?Q?RQjhPELkaG6+M1g9hOn0BED6u8S/ItzI3y3cbpvhNBy1+ZsNXGUc5De29q?=
 =?iso-8859-1?Q?cOLLP89kLCcarNfrX7HK1lp75/EheulhcDFNPnG6O70aWIt8s5xH2cn+fP?=
 =?iso-8859-1?Q?CBZjaJHaBwD9KmyddVEggmUSta9Nm92hHDjUgdzc2GOHHrKdDb8bI7Dego?=
 =?iso-8859-1?Q?qVTlw2YLoDezfhfvNCswrriRa/QY9tYsWNqogVt6puvTHeXLEWOIJKhFmB?=
 =?iso-8859-1?Q?w3mZi+kR7cY0SXnwHhM4d9pVrUkXeKloVWvfzORZoihhCoY98vY4PAh5VC?=
 =?iso-8859-1?Q?d1Yuf5XiCzfBA2orlXPD+BmiS7N1deOxfTaeoGWnuQ3JHhJpyx1QlEjQ9h?=
 =?iso-8859-1?Q?X1P1eZRSgw20yVhWAkftOB1h/CkHIPx1BWbzi5EIg/cs19bLwghlpIOEou?=
 =?iso-8859-1?Q?WtBvqvk4PeQQiflHd09HK6w1uhrMJICvLBNE79/KVdg+qGR6jv08FDxZut?=
 =?iso-8859-1?Q?d3fRcwSu0pMO9DuyJPV0b5WG53Poh9ds4ih6lZJ5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HrTnvFi8gsEtzUNdmTgR9tubM628tZO9XWrrQf6O2ermx+JRZum9rSB4ZP?=
 =?iso-8859-1?Q?Rian9bDsR8dLrY8xumz0rnLAhcv91LaCWfIhrNuWAXzw1J2Ro1Q/jj1vQp?=
 =?iso-8859-1?Q?WxNDl2h0rKuiiXH9D0XuQfcWrDhP513+l87EiGEmJUTqpIQPEg07fOARkQ?=
 =?iso-8859-1?Q?vAW5whno0T1hVbQy/QaS3zQn72lQc+dzaCeJW2oXcc+122J/kvQjipOKjl?=
 =?iso-8859-1?Q?6Aje7i5tUlWVJJ83RPdNZy4fL0h8MnhP03snafTl1HH2ObdHf+Wf2N8/2+?=
 =?iso-8859-1?Q?z2qn/jg1Pm6tPjSk+xuNMyNuqy+GlnoKc+3WITA4QhMgY302BCdCAGEOSe?=
 =?iso-8859-1?Q?dqxET3uAWtE58sQA3zm9Ia2OorZkvIetyIobrFMvb0L1kzf/L1tx66TNNG?=
 =?iso-8859-1?Q?kPCONn5XshDgcQhASVLU95w+ICeB+q3ppG+03xLZeoRDtorla0Hx3Xc2sP?=
 =?iso-8859-1?Q?262KsMqLxSyzLct6EcrszDspBFP6SFVHL/LCKyvbEK0Cpolu2g4cmmV+GL?=
 =?iso-8859-1?Q?h9pBwH6PZ9cl/1qZYsZwDHdxYOB5n8W8OsJpqGZQrLQoF6Dz8b4/QqQ1bJ?=
 =?iso-8859-1?Q?Ope5T7KvBEmojHvY2l6x9c0sGEGolPS2TopzFfTPPRk2a61Z0NyhYYl9Qx?=
 =?iso-8859-1?Q?jcQA2hUr8EwZxet7OGRvP6tEkdiMkcfvpXi2B+1dZ813WLEisUqrf2ao4c?=
 =?iso-8859-1?Q?/r2qvAq1lCqjq/ucRTBdjJHdj41IzG/I7OY4DGcZmz2dMARIGs+s3z8JdU?=
 =?iso-8859-1?Q?IJ0WFBlRnGMm1cLfxya3Idj+AIlkm91VTSDWroRWjJuWNkIKS6iAEIspn6?=
 =?iso-8859-1?Q?oJf/YqXEOdvAZoc4b4eRKMldgTKZBSSG/QNlRXJUu2bi3aVd4vqrtdxRYE?=
 =?iso-8859-1?Q?rhMrIEYWIaZLGmibWgHGtkQfy9nNqXLi+6LW9BsSp3exXJK7TNyrOod3ZY?=
 =?iso-8859-1?Q?Jny16bhbNgYNwBr10RuMPisaqDHzOZZLgQMgaXq1QCk55k+7+Bswxl2Kw5?=
 =?iso-8859-1?Q?06QAKIlcVxY6OxZF+9bhvIlg+P3OvMf/6Z28OK+P3/oVgnr2DUEI3/Wgra?=
 =?iso-8859-1?Q?tCgGhlO5tHCzW0I805mwZHMLqyiB7RyqWIq3/p7UHHVdbL9eqYWeV0gO+Z?=
 =?iso-8859-1?Q?nqXxzB0sZP91TRRTIMIV5FsucpYt4QXXpAKP3Kxb6x0c7eWbdmeY463a5e?=
 =?iso-8859-1?Q?oRNtrCcSjAwBx3XjSMILI/lg4oGbcuuxLonqFjw21wRONapVUYazq9aG+M?=
 =?iso-8859-1?Q?phxMCeLJlG5I3CJSCY6FiMy5c0T6BPh2Bn5/f+Ogh0MHgAFzv+IOMpxzCt?=
 =?iso-8859-1?Q?TqrC1Z6optgT0NI11c7v284BM6NGH4+SmbIO0+RJLnHSht5gKKgVkn0MLf?=
 =?iso-8859-1?Q?nd2xK+ilxOSNHOiepWmrr9DYBNiDa/2hwxW1B3mjU1kBzaS56TtLi33Ung?=
 =?iso-8859-1?Q?+bNKL0O9nwND5J8FhJmtsOtPhIt7yNS8CEi8zoxWcuglJSvP24kAjV2Mu9?=
 =?iso-8859-1?Q?KtlxkEBtS5VMD0Aw8sGq+gdOwirK6+3psfqLeRj8V5/GAZJGja9NFH02+A?=
 =?iso-8859-1?Q?Rx6/fwpuBl5WnIXP2GTW053HN1cDXLZH39u2cw0bNoZW4/LfZ9mlnNyfgj?=
 =?iso-8859-1?Q?LsmoCJqlqjQZGAqVcr5MUjMnBbuRprNuRgC1U9tC2RNNYnk9UABJ1n0aON?=
 =?iso-8859-1?Q?yPaI/V17w5J4uPN9bdUaHE+5fltfEKSWKXutawjyuRNAOGCsjoV3zdFm9I?=
 =?iso-8859-1?Q?kwbuBHy89vRS5WFRsXVH8ZZzASdqO4lGN72P4FzbIoexDq7CYphSztigWr?=
 =?iso-8859-1?Q?m1M0XfF03g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad504e9e-232a-42fa-4c8d-08de688448ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:50.1388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVdMtq1+f5xTxg7TwNtCudbtURrlHGHTJ/Vhv6PBtJQcyEqp32H75VsvyasT1+TTfl2rFPFh7OL8UQM4FU23/Kd/UysKX9ZWO7SZPkbFIto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 6236aeb11c..3485feaf2c 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):=0A=
             'ip addr show dev eth4',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2600_i3c_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'=0A=
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',=0A=
+            'Success on message 0')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):=0A=
             'ds1338,bus=3Daspeed.i2c.bus.5,address=3D0x32')=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.0')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device',=0A=
+            'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default", "image-bmc"))=0A=
 =0A=
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
+        self.do_ast2600_i3c_test()=0A=
 =0A=
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
-- =0A=
2.43.0=0A=

