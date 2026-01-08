Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDA1CF6A86
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdllh-0005SM-Iy; Thu, 08 Jan 2026 03:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vdllf-0005RN-Dp; Thu, 08 Jan 2026 03:53:19 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vdllc-0007Y0-DH; Thu, 08 Jan 2026 03:53:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWIo53xrpnSf9cIAEwUjL2Q77ujdhnQEIEJ5qhXEVnvmRue/mOG84MOw7QygvsXYDnB3GgaqtFN7jZ5dzqnKNC4Q+EDVJdyqBYvOlKSUVhKBguWzutcZ7zSJZLJXmHysRI8ZZ6t9UV8ZT3tIbXUYsrqIXkeA+iUiQ4rPh4DGstlNXAATarPwcFLwVE4wDnhNgrpLw21sjMK7Fz9LZn/Pm2WJc0XEsECqV96YDjiCmaBOl9cbC5I8EgpqJaJFWsnGZWxLRmOApTCfha0i6wWs1FTkm2GWuLUsoyDMvJPy+szzbLp1x8j/VQm9pOetQPqUUnP0SBejJJLTaJJO3lOZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wudiMW/uf3Np1M3ElqgqzBNL4/+pRBq2QSO/hGozTKI=;
 b=azY7pu6rpynfVbw0Mou2R12bz96xhWVPKEypTsyrpAKmsKCAts+C1ZRkAW0dMw6qn8u90toLpzNS4CrcRZ+hmW6O9okW4s+veqZIwgCyHo7HLeoRDOiP01+2o7pYPWkKdE/HSLPG8/bxQ+KygB5v8u65NqkYLXQvk1X3i028PrY5/CVPuLq+QQIKTEZTf8VkOu1tcoKzwkttdh+dWGM77UtMpcRF0hgvjAs9MP2JTsIWv0fKRmmy6rOBvfohyJwqsfsCi1rm5otfS9v4bHbtdawWVQToN98a9dvJRI44LzoDNOEoNXlyfC6jLslDLFpgxePX/ZsSCxTpmLwFaXpd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wudiMW/uf3Np1M3ElqgqzBNL4/+pRBq2QSO/hGozTKI=;
 b=mB6iGUa/JXFWYmzb1IiKYusFngD80dhjaoiXPfoyTo4GG9rKBoGtSSdWmieYU2sN6BU3J6UGAFXJPemU8W4cl72eBV8tme9giAjU3Qkwl+eR102jlLd+Pbq81RiHNwijnO70wqIZEpkwhtKBxfkBaXgRxL3VhsmdFGs9tyDUnjwn7o0svqg4Uoer6kadnDA1mby32SpKGZTbPak9DSPJi0JWI7JxlWn4mCKA/vd8kyRmrwoDtQ3VXoEdAak7R3BO1punUO5XnSzJq0O4wAOmO99WKE4TsT+xgh4Ph3HEy/Kp4xpXtDwR5EpptzlUBKnV3hOGrkUpBh4pFljO9B6i7g==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SE2PPF6240AD2A0.apcprd06.prod.outlook.com (2603:1096:108:1::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 08:53:07 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 08:53:06 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
Thread-Topic: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700
 model
Thread-Index: AQHcdHaM7LqK+1z4NUeh6mGjSHFVqbVG4dYAgAALpoCAAM4SsA==
Date: Thu, 8 Jan 2026 08:53:06 +0000
Message-ID: <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
 <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
In-Reply-To: <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SE2PPF6240AD2A0:EE_
x-ms-office365-filtering-correlation-id: cab10210-5b48-49b9-628f-08de4e935746
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NUhsay9HNFQ0NVZLSE9zdk02b0xncE0wN1VmWlpUZWliUm1RenB4aWxUSjBr?=
 =?utf-8?B?cUYySktSd3I3RCtMekI2QlJBQ01GVWhTc251QTNsOTloRTVyNnhUcVpCTVdD?=
 =?utf-8?B?RzYzLzJaRjBXSU1SY3E4bUJVRUlYZGs5alZzSUcrcG84N0g1SWlQRitFUDY4?=
 =?utf-8?B?aHBlTFE0cGhRKy9vdkdzaXV4aElLcmxPeWN0YmJoaXYyUVRacFdUTldCaytW?=
 =?utf-8?B?dUEzeVUveWNyM0xBbk9uamxZNHlBUW1FNnM1Q1BVQ1pjRGFnR2N6SkZFbG9h?=
 =?utf-8?B?Y0FoMTJpeEV3OENDemU5NnNTY2JBa2UrR05sZzNicThtcml5TklmSUx5MjI4?=
 =?utf-8?B?VDRnK1BYM1ZHTTc5NTF6ZkFnZU1GUHJaYU10eklnaVRHWjVGaDRhb05hdmFi?=
 =?utf-8?B?UnhtMWNCQXVmOUg2Sk9KWkF2amVnMDFBTEhUMGdJeFhtelgwYlZUTFZKaEJV?=
 =?utf-8?B?ZE94N1lDVVpHQkVkNG5talhiNVRwalRhbi9tWThVSElERzVObk9EaTZ4NGVE?=
 =?utf-8?B?QnJPUmVGc0tkVmlZSllqWm1mSjYrYm1HTXpMREs1OHlJMVRKNzlZSFpvTTlZ?=
 =?utf-8?B?N2s1QzhpSCtaQVQ4UVRHRU5PYVc3K3JmRWpiVis1MW1nZ0dCaEdKeE5zQXh2?=
 =?utf-8?B?c2ZjRXo0YjFNanlqdGFGWG1Qbm9RcUtnSWVEM09wYi9VVUFRUUdtc1FGZ1pX?=
 =?utf-8?B?UzB6OEFnUFBTVEdjM0N0dkVMMjYyTzNELzNjSlNubEs4ZXF1QXVITXd4enJD?=
 =?utf-8?B?c0drYWJVUFU3VklTUzVwK1Z2R3BuQ2ttOHVjTDhjTjk1YVFGZDBmd1dFREh6?=
 =?utf-8?B?cFQ5Z0htSFVOUTVuTzdBb1FES3VvYlJ3U054aXc1VDJ0N05jbnBaWE0veERs?=
 =?utf-8?B?REYrUHlweG9YVkNTOVVSYWpucFJyRHpmU21PWjdvbEo3UGxkN3p3bFFKWHFm?=
 =?utf-8?B?SHBmWkl1a1RVUWtMelIyTVBVL2d0V1pSOC9YNlJwS053QStmVVFxKzRSN2Fr?=
 =?utf-8?B?QjltMFo3SmxRWUZvTVhoQ3RTRmduM05rYWJtdC9yeHl1U1pKeVpiamFDRGx1?=
 =?utf-8?B?WUJwcWlyMTM5Z1J2bUV0YyszaFNxc01LemZuM0Y2UjhqRTBycHMxR1JESmNJ?=
 =?utf-8?B?VHdFLzZUWUNUaEhCR1ZnM3UxVWxYd0dZRmY3WXMxUzJERmJFMlFsSzRZUks1?=
 =?utf-8?B?Um0vKzkzeTJqUFUyTGxYcDlhV0FKMHl5S2FJNU1EMkZSc1pCTEMxR3RvYmxV?=
 =?utf-8?B?ZXZNaTFvZVIxYWpvNk84SHQrQVZBekJQMWc4bkc1WTFuUTRXMW9uQjBWL2F6?=
 =?utf-8?B?dUhpcDhuVEhITERYdTc1dE13N25qZDc5d0dtQzJ4anBVVzlGdlR4aUxjMHhT?=
 =?utf-8?B?dEwrVTRDZTVvOG84RHFBejEvU3JUUmZ1Wk8rRFBGS1d4UGpUUnRLT3BLMnN1?=
 =?utf-8?B?Y3d0aE52ajBOSzhWREprVWoxZXdubXI1VTVoK2dBSUtlNTVXbG03cGpaT2ha?=
 =?utf-8?B?TjBBNStOOUdLNm01TXA1SHBuTkVid0xsS0YrUkNOQlZ1Z3RtcEorN1pscjBS?=
 =?utf-8?B?TjgwZm1lVVZCVGZRcVZURFRTdDhwdDl4d3hSNjdLZ0QzN0RDcTQ1d3JBWEIr?=
 =?utf-8?B?SVZ0TmNiQVplV0ZMN0tqTWN6SDRBcTRmcEVYTlFzYWozZDhhenRCbFhmTXF5?=
 =?utf-8?B?Y0ZoWTQ2bGp2V2d0QXBmYkJralU1aUhEK3RnOW1xVm5CK3hwVkxucFJDVHdU?=
 =?utf-8?B?akVHVEQ4YVg2UmtIKzI2dlpVSFpHeWZmVlMwRFNoM2JTakdMbVhPNXJ6VC8x?=
 =?utf-8?B?djhrK3I0STVxWlRPRVIyZUNvMlVIcHh1YWxPQTBXdWlZaFljNDVVR2hPT3Vv?=
 =?utf-8?B?OGhJMG5UWHpKN1B1RXBkWGVYbkZwMkh4MnNIRXE4YU4zbnBsckJQTGVRd05r?=
 =?utf-8?B?S0oranBuQzYrb0pYUnlaWktQaThiQjJCUnpheWgva3BxVlNBaXJwaEJFM2Fo?=
 =?utf-8?B?Y2lOcDFoNjNsQWxVK1hzdkhXK1ZaODRNZ2Fic2d3dlIyU0IzZDJja1JkQ1dL?=
 =?utf-8?Q?t0PzSq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZtNi9ReGF5Ylk5b1lyQkJLYkZyWDZsMVlCa1RZUVVkdDBMcnpTRzUyVVBU?=
 =?utf-8?B?Yy9wZHN2ZmptTmdnUlJYOXlRTmVpZWZvL2lybTFLMHZBUDEvcjFoMkYvL0h4?=
 =?utf-8?B?WE42YWM4eGtwUGdNUmtDb2Nmdjg4M3RBZVVHVDZmMk9mWlpRTFR4YmJiYU52?=
 =?utf-8?B?V2JJT0VIbXdRMmo1a0poRHNTcGozQUNWRnhQNnJuRjFpb0dkZmQyYityVjgy?=
 =?utf-8?B?a2tESGJ0VzN6cmJkRWZ0WERXWUdsZEdMK2Ewc0tNdktMOTRUdEprNmtaazcz?=
 =?utf-8?B?UG43V0swVXJBZ1FOd29KTEV6T1RmR1I1WlhSQjRZUTQ4M0lHTHRudTVLQWFH?=
 =?utf-8?B?aVI2R0NsckluZjhxZjY2eDVJNkpwdE9oZ0l4Q1lmclRzQVBLOVh5RHo1Ym9i?=
 =?utf-8?B?K0kwUnN5d1E4VUxsWFN0OWxmTE5GeFZKMTFoMXNSMWdLNTB2S3daVnYrREZa?=
 =?utf-8?B?dGFaUytjbXlndWY1N1AwU0tpUjBIenNhSzdFTDJjUUp2aUJLYktsSkNZaHRX?=
 =?utf-8?B?TmFuWnBCL1JJSGFYMGpBWnJCKzRPb1NRUzYyY3U2ZEhudUkzbTZSVnV4Umlm?=
 =?utf-8?B?RUhJQmRqVmdrUmNRR28xazRrY2Ixd1Z2cVRrREtHRG1EMFhkczFLUFpiOUkv?=
 =?utf-8?B?cEpmME41NTNIUjBwSHlMb3dpRTFHZmV6Q1lRZldNdmRqNDFINVBVN0RraSth?=
 =?utf-8?B?WjNUQUthVTZDRDRrT2dOb0VnMWhJZ21NNFZ2UGR6ZTMwVEkwa1ZwMmZhWUow?=
 =?utf-8?B?N1FlQkpFSkR1TFBpSmNMSzVxZ0g2TW9wdUdUYzVjS283K1ZvNkUzS1lEaHlJ?=
 =?utf-8?B?SjVHTVYyVk40MWl0b0RHWVIxS2swMm15R0huOUFia1h1QVU1MlQxN0o3ZVhr?=
 =?utf-8?B?U2NuV0Mvb0NTbWovSkVEalZ4Ti9ISXc2Qy9RWHcxamVaMlVVVmVPWmVmQ3Ry?=
 =?utf-8?B?QURhNzlYdVBzREdRWTFvREpIVUhIazNudytlcnBhZ3FHb0hLU21hLzViTHkr?=
 =?utf-8?B?YXVjbms1b1U3UlVJYXUvZkEzWHBUR2dLRFA0RllJdWRvajl1RXF1TjJtcTdW?=
 =?utf-8?B?cVJsYnh5ODIvbFcvbVFWajEzVC9MaTRjZ2dDeHJhTnhuYnB5TUtHb0x3cnNm?=
 =?utf-8?B?bFEwRzltZy8zVDBsUzhlZU50YzJ4N2lUNk00eHZ3VFQzY1JqOUJ3QloyRjU0?=
 =?utf-8?B?T2tDWjVaejNQNEVaMUQyQ00rdDh5WGdTVXQ1ZWlSVUt3dUxvVGNzdDBPSG8w?=
 =?utf-8?B?WmVOTUhtVGt0dWZsWUFidmpkZVhvdHloT3NvNHJmQm8zOW9TQkg5a1d3QXlF?=
 =?utf-8?B?dndKZkRGeElHYVZuT1QvcGovTmIrc1g3T0VIckU0aDdFU3ljYld0MXJDUmpC?=
 =?utf-8?B?bnh1VVZNdkdCNnljdXZZcTZGY1REK2doT3ZnckM4ZnE5dFN6bWd6ZlRFK0po?=
 =?utf-8?B?ZEw4OWROTTlhdmdnVWdWcm1aTmF1RWZPUUw4TWtDdDc0WjUzZjdhcm5SRDlQ?=
 =?utf-8?B?bnU5ZU51enV0a3J4Q2lsVWJGVzZWQWtmNDM4Uk0wWnluc1hsYml2R3c5MnV1?=
 =?utf-8?B?THgvb2ZxMmJ0Q1JkbERESlNjakxvSnAxeXkvQ2pQMExqL3F0MDJxWDZVcDJX?=
 =?utf-8?B?MWFrVktjWjZXWVlFdnlHbmUvc1gwY2x4N3Y1dEtXS21PTGF2eXYreE1NK2RT?=
 =?utf-8?B?WUNRWDBWdG1PYXB1aFladkdWelBiTFNVaHRUbzRpd3FTOHZ3TzNseTVPV3NE?=
 =?utf-8?B?VDZiSFpXZmg4eTlGTlh3K3VFVDZSU1Jsc2c0ek85c1Urb0NCZ0dXSm0yMVVt?=
 =?utf-8?B?NGRXRTE3VHFneE9XYUU4V1E1NUFocUhCd3J2RHRtdWtTMDRzYlNGUEppcWZT?=
 =?utf-8?B?QjhvU3hmZGQ2TVZqL0o1QzdMTTZBUUoydjVSb0p3c1o0YXpDa1duZjZqTTBN?=
 =?utf-8?B?Rnh6c1U4N0FjeWduOFcxbWpTcWVvQ3pqaTZ6OEx1YkhxRVVqV2tic1NwTW9R?=
 =?utf-8?B?ZFRSWk01Q0ticEJISTRIWXBpL1VwNktDUk5ERmQ4Z09pM29nTnh1U2JLbUxh?=
 =?utf-8?B?YUhkZ00wSGNITGNrWFdUYm5acGUwNjJ6cWVRa2RPV0JVUVhicndhci9nR2Zi?=
 =?utf-8?B?U1lRdWNzYXBnaG1HN1VFSW0zV0pEaldURTA5UlpjWjNuSEY3MlNnYzZVYzJI?=
 =?utf-8?B?emhlVUVuYjlSNFRxVlp1RHNSSXI1VWc5UG02Z0dlRlZTMzhqaEMva25XNEFC?=
 =?utf-8?B?K2FzYTQwUnBsS2FBaXhHaUF4N2Vtb0VqOFBSTFNZTnRuTzU4UzNGRjF0cWZP?=
 =?utf-8?B?d0xUc0FIeEcwcFNFY3ZMVnZYc21PQ2VYbFpqOGtJSVpzRFZQVW5XUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab10210-5b48-49b9-628f-08de4e935746
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 08:53:06.4071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTQxRYfiHoBiKX8wa2xWCj5ebZh1Sj6XE/6gFev36/tl7HQ1wQeL7MYrtFD0DME6yJXG66jnswoRdXgRLdmjUHGKlAl+IYQlq2x4wkovSpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF6240AD2A0
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgNywgMjAyNiAxMTozNSBQ
TQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlk
ZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVl
QGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3
QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+
IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpB
bGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDE0LzE5XSBody9hcm0vYXNwZWVkOiBhdHRhY2ggSTJD
IGRldmljZSB0byBBU1QxNzAwDQo+IG1vZGVsDQo+IA0KPiBPbiAxLzcvMjYgMTU6NTMsIEPDqWRy
aWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+IEhlbGxvIEthbmUsDQo+ID4NCj4gPiBJIGFncmVlIHdl
IG5lZWQgYSB3YXkgdG8gZGlzdGluZ3Vpc2ggdGhlIEkyQyBidXNlcyBiZWxvbmdpbmcgdG8gdGhl
DQo+ID4gQXNwZWVkIFNvYyBmcm9tIHRob3NlIG9mIHRoZSBBc3BlZWQgSU8gRXhwYW5kZXIsIHNv
IGRldmljZXMgY2FuIGJlDQo+ID4gYXR0YWNoZWQgb24gdGhlIGNvcnJlY3QgYnVzLg0KPiA+DQo+
ID4gTGV0J3MgcHJvY2VlZCB3aXRoIHlvdXIgcHJvcG9zYWwuIEJlbG93IGFyZSBzb21lIHJlZmlu
ZW1lbnRzLg0KPiA+DQo+ID4gWyAuLi4gXQ0KPiA+DQo+ID4+IC0tLSBhL2h3L2kyYy9hc3BlZWRf
aTJjLmMNCj4gPj4gKysrIGIvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+PiBAQCAtMTI2MSw2ICsx
MjYxLDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19yZWFsaXplKERldmljZVN0YXRlDQo+ID4+
ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPj4gwqAgc3RhdGljIGNvbnN0IFByb3BlcnR5IGFzcGVl
ZF9pMmNfcHJvcGVydGllc1tdID0gew0KPiA+PiDCoMKgwqDCoMKgIERFRklORV9QUk9QX0xJTkso
ImRyYW0iLCBBc3BlZWRJMkNTdGF0ZSwgZHJhbV9tciwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9NRU1PUllfUkVHSU9OLA0KPiBNZW1vcnlS
ZWdpb24gKiksDQo+ID4+ICvCoMKgwqAgREVGSU5FX1BST1BfU1RSSU5HKCJidXMtbGFiZWwiLCBB
c3BlZWRJMkNTdGF0ZSwgYnVzX2xhYmVsKSwNCj4gPj4gwqAgfTsNCj4gPj4gwqAgc3RhdGljIHZv
aWQgYXNwZWVkX2kyY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZA0K
PiA+PiAqZGF0YSkgQEAgLTE0MjEsMTQgKzE0MjIsMjggQEAgc3RhdGljIHZvaWQNCj4gPj4gYXNw
ZWVkX2kyY19idXNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4+
IMKgIHsNCj4gPj4gwqDCoMKgwqDCoCBBc3BlZWRJMkNCdXMgKnMgPSBBU1BFRURfSTJDX0JVUyhk
ZXYpOw0KPiA+PiDCoMKgwqDCoMKgIEFzcGVlZEkyQ0NsYXNzICphaWM7DQo+ID4+IC3CoMKgwqAg
Z19hdXRvZnJlZSBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKFRZUEVfQVNQRUVEX0kyQ19C
VVMNCj4gPj4gIi4lZCIsIHMtPmlkKTsNCj4gPg0KPiA+DQo+ID4gSSB3b3VsZCBwcmVmZXIgaWYg
eW91IGFkZGVkIGEgbmV3IHByb3BlcnR5IHRvIEFzcGVlZEkyQ0J1cyA6DQo+ID4NCj4gPiAgwqDC
oMKgIERFRklORV9QUk9QX1NUUklORygibmFtZSIsIEFzcGVlZEkyQ0J1cywgbmFtZSksDQo+ID4N
Cj4gPiB3aGljaCB3b3VsZCBiZSBzZXQgaW4gYXNwZWVkX2kyY19yZWFsaXplKCkgOg0KPiA+DQo+
ID4gIMKgwqDCoMKgLyogZGVmYXVsdCB2YWx1ZSAqLw0KPiA+ICDCoMKgwqDCoGlmICghcy0+YnVz
X2xhYmVsKSB7DQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+YnVzX2xhYmVsID0gZ19z
dHJkdXAoVFlQRV9BU1BFRURfSTJDX0JVUyk7DQo+ID4gIMKgwqDCoMKgfQ0KPiA+DQo+ID4gIMKg
wqDCoMKgZ19hdXRvZnJlZSBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy4lZCIsIHMt
PmJ1c19sYWJlbCwNCj4gPiBpKTsNCj4gPg0KPiA+ICDCoMKgwqDCoMKgwqDCoCBpZiAoIW9iamVj
dF9wcm9wZXJ0eV9zZXRfc3RyKGJ1cywgImJ1cy1uYW1lIiwgbmFtZSwgZXJycCkpIHsNCj4gPiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gIMKgwqDCoMKgwqDCoMKgIH0NCj4g
DQo+IFRoZSBhYm92ZSBjaGFuZ2VzIG1heSBiZSBpbmNsdWRlZCBpbiBhIHNlcGFyYXRlIHByZXJl
cXVpc2l0ZSBwYXRjaC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiBUaGUg
bmFtaW5nIHNob3VsZCBiZSBhIGhpZ2hlciBsZXZlbCBkZWNpc2lvbiwgbWFkZSBhdCB0aGUgU29D
IGxldmVsLg0KPiA+IFNvLCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKCkgc2hvdWxkIGJlIGFkanVz
dGVkIHdoZW4gdGhlICJidXMtbGFiZWwiDQo+ID4gcHJvcGVydHkgaXMgc2V0Lg0KPiA+DQo+ID4g
SSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGtlZXAgdGhlICJhc3BlZWQuJXMuaTJjLmJ1cyIgcHJl
Zml4LiBIb3cNCj4gPiBhYm91dCByZW1vdmluZyAiYXNwZWVkIiAod2hpY2ggaXMgcmVkdWRhbnQg
YW55aG93IG9uIGFuIEFzcGVlZA0KPiBtYWNoaW5lKSA/DQo+ID4NCj4gPiAgwqAgImlvZXhwJWQu
aTJjLmJ1cyINCj4gPg0KPiA+IEFsc28sIGluIGFzcGVlZF9pMmNfYnVzX3JlYWxpemUoKSwgcGxl
YXNlIG1ha2Ugc3VyZSBBc3BlZWRJMkNCdXM6Om5hbWUNCj4gPiBpcyBzZXQsIGxpa2Ugcy0+Y29u
dHJvbGxlci4gVGhpcyBjb3VsZCBiZSBhbiBhc3NlcnQgdG9vLg0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+DQo+ID4gQy4NCj4gPg0KPiA+DQo+ID4+IC3CoMKgwqAgZ19hdXRvZnJlZSBjaGFyICpwb29s
X25hbWUgPSBnX3N0cmR1cF9wcmludGYoIiVzLnBvb2wiLCBuYW1lKTsNCj4gPj4gK8KgwqDCoCBn
X2F1dG9mcmVlIGNoYXIgKm5hbWUgPSBOVUxMOw0KPiA+PiArwqDCoMKgIGdfYXV0b2ZyZWUgY2hh
ciAqcG9vbF9uYW1lID0gTlVMTDsNCj4gPj4gwqDCoMKgwqDCoCBpZiAoIXMtPmNvbnRyb2xsZXIp
IHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJycCwgVFlQRV9BU1BFRURf
STJDX0JVUyAiOiAnY29udHJvbGxlcicgbGluaw0KPiA+PiBub3Qgc2V0Iik7DQo+ID4+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4+IMKgwqDCoMKgwqAgfQ0KPiA+PiArwqDCoMKgIC8q
DQo+ID4+ICvCoMKgwqDCoCAqIEkyQyBidXMgbmFtaW5nOg0KPiA+PiArwqDCoMKgwqAgKsKgwqAg
LSBFbXB0eSBidXNfbGFiZWwgLT4gQk1DIGludGVybmFsIGNvbnRyb2xsZXIsIHVzZSBkZWZhdWx0
DQo+IG5hbWUuDQo+ID4+ICvCoMKgwqDCoCAqwqDCoCAtIE5vbi1lbXB0eSBidXNfbGFiZWwgLT4g
ZXh0ZXJuYWwvYWRkb24gY29udHJvbGxlciwgcHJlZml4DQo+ID4+ICt3aXRoIGxhYmVsDQo+ID4+
ICvCoMKgwqDCoCAqwqDCoMKgwqAgdG8gYXZvaWQgY29uZmxpY3RzIGFuZCBzaG93IGJ1cyBvcmln
aW4uDQo+ID4+ICvCoMKgwqDCoCAqLw0KPiA+PiArwqDCoMKgIGlmICghcy0+Y29udHJvbGxlci0+
YnVzX2xhYmVsIHx8DQo+ID4+ICsoc3RybGVuKHMtPmNvbnRyb2xsZXItPmJ1c19sYWJlbCkgPT0g
MCkpIHsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIG5hbWUgPSBnX3N0cmR1cF9wcmludGYoVFlQRV9B
U1BFRURfSTJDX0JVUyAiLiVkIiwgcy0+aWQpOw0KPiA+PiArwqDCoMKgIH0gZWxzZSB7DQo+ID4+
ICvCoMKgwqDCoMKgwqDCoCBuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCJhc3BlZWQuJXMuaTJjLmJ1
cy4lZCIsDQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcy0+Y29udHJvbGxlci0+YnVzX2xhYmVsLA0KPiBzLT5pZCk7DQo+
ID4+ICvCoMKgwqAgfQ0KPiA+PiArwqDCoMKgIHBvb2xfbmFtZSA9IGdfc3RyZHVwX3ByaW50Zigi
JXMucG9vbCIsIG5hbWUpOw0KPiA+PiArDQo+ID4+IMKgwqDCoMKgwqAgYWljID0gQVNQRUVEX0ky
Q19HRVRfQ0xBU1Mocy0+Y29udHJvbGxlcik7DQo+ID4+IMKgwqDCoMKgwqAgc3lzYnVzX2luaXRf
aXJxKFNZU19CVVNfREVWSUNFKGRldiksICZzLT5pcnEpOw0KPiA+DQoNCkhpIEPDqWRyaWMsDQoN
ClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9ucy4gSSBoYXZlIHJlZmFjdG9yZWQgdGhlIGJ1cyBu
YW1pbmcgbG9naWMgdG8gYWxpZ24gd2l0aA0KeW91ciBjb21tZW50cy4gVGhlIGRlY2lzaW9uIG1h
a2luZyBmb3IgdGhlIGJ1cyBuYW1lIGhhcyBiZWVuIG1vdmVkIHVwIHRvIHRoZQ0KU29DIGxldmVs
LCBhbmQgdGhlIHJlZHVuZGFudCAiYXNwZWVkIiBwcmVmaXggaGFzIGJlZW4gcmVtb3ZlZC4NCg0K
SGVyZSBpcyBhIHN1bW1hcnkgb2YgdGhlIGNoYW5nZXM6DQoxLiBBZGRlZCBhIGJ1cy1sYWJlbCBw
cm9wZXJ0eSB0byBBc3BlZWRBU1QxNzAwU29DU3RhdGUuIFRoaXMgYWxsb3dzIHRoZSB0b3AtbGV2
ZWwNCiAgU29DIChlLmcuLCBBU1QyNzAwKSB0byBkZWZpbmUgdGhlIGxhYmVsIGR1cmluZyBpdHMg
aW5pdGlhbGl6YXRpb24gb3IgcmVhbGl6ZSBwaGFzZS4NCjIuIFRoZSBidXMtbGFiZWwgaXMgcGFz
c2VkIGZyb20gYXNwZWVkX2FzdDE3MDBfcmVhbGl6ZSB0byB0aGUgSTJDIGNvbnRyb2xsZXINCiAg
KEFzcGVlZEkyQ1N0YXRlKS4NCjMuIEluIGFzcGVlZF9pMmNfcmVhbGl6ZSwgdGhlIGNvbnRyb2xs
ZXIgZ2VuZXJhdGVzIHVuaXF1ZSBuYW1lcyB1c2luZyB0aGUgYnVzLWxhYmVsLg0KICBUaGVzZSBu
YW1lcyBhcmUgcGFzc2VkIHRvIHRoZSBBc3BlZWRJMkNCdXMgdGhyb3VnaCBhIG5ldyBidXMtbmFt
ZSBwcm9wZXJ0eQ0KICBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBidXNlcy4NCg0K
V2l0aCB0aGVzZSBjaGFuZ2VzLCB0aGUgbmV3IG9iamVjdCBoaWVyYXJjaGllcyBhbmQgYnVzIG5h
bWVzIGFyZSBhcyBmb2xsb3dzOg0KQk1DOiAvaTJjL2J1c1swXS9hc3BlZWQuaTJjLmJ1cy4wDQpJ
T0VYUDAgKExUUEkwKTogL2lvZXhwWzBdL2lvZXhwLWkyY1swXS9idXNbMF0vaW9leHAwLjANCklP
RVhQMSAoTFRQSTEpOiAvaW9leHBbMV0vaW9leHAtaTJjWzBdL2J1c1swXS9pb2V4cDEuMA0KDQpJ
IGhhdmUgYWxzbyB2ZXJpZmllZCB0aGF0IHRoaXMgbmFtaW5nIGNvbnZlbnRpb24gZG9lcyBub3Qg
cmVxdWlyZSBjaGFuZ2VzIHRvIGV4aXN0aW5nDQp0ZXN0IHNjcmlwdHMsIGFuZCBhbGwgZnVuY3Rp
b25hbCB0ZXN0cyBwYXNzZWQgc3VjY2Vzc2Z1bGx5Lg0KDQpJZiB5b3UgaGF2ZSBubyBmdXJ0aGVy
IGNvbmNlcm5zIHJlZ2FyZGluZyB0aGlzIGFwcHJvYWNoLCBJIHdpbGwgc3VibWl0IHRoZSB1cGRh
dGVkIHBhdGNoDQpzZXJpZXMuDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

