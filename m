Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5B6CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 06:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB63m-00043l-C2; Tue, 21 Oct 2025 02:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vB63i-00043B-CY; Tue, 21 Oct 2025 02:41:26 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vB63e-0001Lo-47; Tue, 21 Oct 2025 02:41:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT3h21ZbtaC0u0mLfHW3EO6CwW8DLXd/bCcWITd8C146RlaE5pfRwhQMQZ195RtDIeU40xzP8hhqeZv307wodBFsrK9ZbzXvSYu7gfg9KJbD/qoRM+yuBWC+nflo345DMdzs2ne1CGRscA4lsg4Eow7WkOAEq6mPz8ck1cMkFBLlUs+XIeNdWwU23Ye2K9WdVWSV3vAsd4lOa2QPrC5tA16U0qOaSefha1sSzknAlzt7Pmi7wNFn2SzWDj6Eg45r8MWfvxuIpGvFMpNEZCuJeLLx5I2kEy/Xmc+ekiW60JRdXujYPQ4i1CVKufMMgPirJB7fAmG3nq7fSnyljSZ3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9mOgvioXzKsYB99mUOtrpaSwaBkZhQzCssqRT00m28=;
 b=Gov0NFH03lEOLYBjJXHsgLlT9RDsvkfqMJF70Mpo/SkBit0o3+Iihgkx1MR1WbccmWV7f8RbevNDMub/uLdyPNvp+39EJNFFKKlrBOH8FfAcCrDMnny9TWWlrN/Ur8j3udoHsTfPvDiJAgVe4oFxsr/L114g5SxW3m7+vo2jTWG2AWq+m38kFY7vH9voAlWXEiveIIh3MRVNsj5QD/uTIJ9sJbNxwv6EvTGavIyXths3CmwGfk/BrRX96+YUCouSrB53QAHiQfkML74wtkH2I/q5rzX5GWa4eVatNhvfrHrzppSbzaSmOLdbGBJ822+CegU7G0ClXbwVRqfsfruQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9mOgvioXzKsYB99mUOtrpaSwaBkZhQzCssqRT00m28=;
 b=Vu4O0CbApIIRvo4j8KP6R6HN8MaCJkerW8V6gCcmkry3h62+NJdqcwm2D4nF95SMdx6lA5Xvfe1TWeoz7i2IaocXdnYtsSUw6+AVP+ETvnSk/YIzC+GFR4ZWKnEN9V5wJaugy3GbPg6ChYWF8PiJZ+VnYAmf6MzfR/NVT48aemy+1TtNEK+CeLf759AVdu07hLazRPtHNSVgSJXF1lexs5nm9LnSlqFSsg5yRcEzizqqTtyHEpbfSMxZfbLvl8lXGendJ0AecjxPau0ciG0Gu53HjSFGkcBYOAdGTOasSMUY3afQRtD/RimP2kRFa75Cf7haIk+Ftaiizd/NZx4DxA==
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com (2603:1096:820:30::6)
 by TYZPR06MB5026.apcprd06.prod.outlook.com (2603:1096:400:1ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 06:41:13 +0000
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156]) by KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 06:41:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: 'Andrew Jeffery' <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Patrick
 Williams <patrick@stwcx.xyz>
Subject: RE: aspeed: Split the machine definition into individual source files
Thread-Topic: aspeed: Split the machine definition into individual source files
Thread-Index: AQHb4PvonkQ5WUYo0k+UuuoQJWjdG7TEwxGggACgzwCABzH94IAAUq2AgAAAUoA=
Date: Tue, 21 Oct 2025 06:41:12 +0000
Message-ID: <KL1PR0601MB4196F40949678039B771F610FCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
 <KL1PR0601MB41966988C6264D25E6782045FCE9A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <965c2eb3-639e-4792-bd8d-f47682099601@kaod.org>
 <KL1PR0601MB419628CE287BDF2715845C4BFCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <d51ad87c-8076-4f86-b9ed-388313ae9e2d@kaod.org>
In-Reply-To: <d51ad87c-8076-4f86-b9ed-388313ae9e2d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4196:EE_|TYZPR06MB5026:EE_
x-ms-office365-filtering-correlation-id: 2a0eb08d-dca7-4b98-102f-08de106cd41b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q1hCYU1nLzhzb3ZVcTFIS0w1UEZKU0M2c1YrRmVPRjdBUUtJSGhPRzN5MzFV?=
 =?utf-8?B?bHlFZmFLQ3drWEUrYXVmQ0hwTEozTFVMQ09FRTMxVDFXYnZLUHlSTkNmQjVT?=
 =?utf-8?B?UDlvaTJmZ3BQbUlQVTNsbXcrYWhMbmNCL0dyZi9FaTgwalR1Z0dkQXFXV2pZ?=
 =?utf-8?B?U2Z6cHYyQjRxMXdWUEZXMlJieE9TbmV2QlhTTkVIb245ZGFBUnFma0p1R3RB?=
 =?utf-8?B?TStjR0FhOXpOOHBXVCtWWWVIeHJmWVJTUFFtQ2d1SWpKWkdGQVBlU2dLeWYw?=
 =?utf-8?B?RVJ0VkpnYjVORXpMbFdaRDRhaWdWN0xackl5OUxwQlRvcjBvdHpicTh1ZURI?=
 =?utf-8?B?Q1ltaDVsMVRlRFRPV1pKc3Z1STdsSU80bjMxdHZQTUpZZVJWdnV3MHB2ZHM4?=
 =?utf-8?B?VzNyMklDclp1YVF5ck1zMFRET0VNbWJqN3Q1SnU2TFFYbFg5VldmZHVLTTBt?=
 =?utf-8?B?WlI2ejgzOTJDU0lua1ZWalY5aVB5WjhpL0x0YVN2SUFOWWlaVVF3aTRrSVFj?=
 =?utf-8?B?cnI0SFNjSTRoU3I3SGp6SkpOVEV1QmJ3TEhzTElPTkV1dUZVdG9SU25wNEly?=
 =?utf-8?B?WG9RWHU5Q1RGZVJ0Y3hScEZxNGJBMllkaTFzQktjektsRUw0OWQ0QnZ4blh5?=
 =?utf-8?B?Um1ZS0F3bnBQUURNUmJIY3F3eWo3aUY5SklXZkphbjY0MVFCODEyTzVSWVJ0?=
 =?utf-8?B?Sy9kV2s4TE5xNFkvTWJWNjZHUjJSMHprSG1zOU8wcFBPL3BmOU9GSFNQZWF4?=
 =?utf-8?B?R3hFWnZBeUtaRzJHY2ZBNDZmWnFRTlFsdmUyZGdvMDFPQWxLTlFrUERJYlVN?=
 =?utf-8?B?OXlzTzRQWmVHYjFUTmUyRzJ4UnNMd0JuMUpBSlpQU1laSGsxUEpRSGg3eFJz?=
 =?utf-8?B?bGtLVlJTV1ZXOUkzdHpHSG9hNyt1YWt6VTBWZmZOTTRwbGNQUlI1QWU1S3B1?=
 =?utf-8?B?Q0VMa0pSVEJVT1M0NjBNanhjTlU0eVRNSDRUcy9YT0VXK1d5SzBhYlBPZ254?=
 =?utf-8?B?bU1WdVZYaFB3OXp1Z0J5aHFodjl6Rlo2VnpEVTBudHJFR0NMT0kzcjBpRWhj?=
 =?utf-8?B?T0ZuY2prclVxSGwzSGxzSjhRcXFXNjB6V01HTjhJcDhPdlVzbkM5RDEvMVFM?=
 =?utf-8?B?WVpuRDRLcnlycWdmNjE5VHQ2VkFnR1dxZEFhMzJ1UXBjR0dXaHo2YjZ0aHg0?=
 =?utf-8?B?bm5VbTNHbHczYnFVMlNRYWJlcWwvR243QnRjM2UxVFlsMjFzcTR4SU9oUS9D?=
 =?utf-8?B?b09LRDh1N2hhejNpNEc4UGRXLzcrZ1RpL3g3WXgyMVlCdUtvU3ZsUVQxSENS?=
 =?utf-8?B?Zll0OVNqMDN6djRJTDR6NFJTU3VrRVRKZjhCUFVRWTRZVFRxOGlZMEo4cCtF?=
 =?utf-8?B?ZjR2UUplemFabXQzWXE3YXc4QllOeFNlR2NhMGVCeEtUaExOZ1lhK0FJczBJ?=
 =?utf-8?B?aXpKOFdUOGVrM2lMUmhzTU1xZHRkRC9aYm9oQmFHenZFdUFTdktVM1pIS1lR?=
 =?utf-8?B?cU5BbUVqTGxBVVFOMkVxdjB4N09aQUs4SFlwNHFSUG9rOTdDZlNhTjlpZnRa?=
 =?utf-8?B?TUFQN2NUbmJPTHhLbW5weC8yT3hDcTBMRWN5UFZFbnVGTmp0QWs0dFFla3BK?=
 =?utf-8?B?RkpseldKUCtNSnFSOWxWNi9WSU01WkN6WnRrM1FOcXRmT1RneE5PMk5LaGs4?=
 =?utf-8?B?S2dtNlhRRGNKZG1uejNCdnNzTzh1a2ROYS9hM2NPQ01iK25jR2FrckVyT0lt?=
 =?utf-8?B?aHVGSjk0aUI5ejh5NkkzeTFPM3VnWXRMQXgxaUtRMWJOditYQ2pxRm9FZXd3?=
 =?utf-8?B?bUd6ODF4aXExSFJZZ1p3UDdGRlRjR084R1RMQkR5NHBkcFlwQ1llK2QwaC9n?=
 =?utf-8?B?Zm9wR2swZEJzYlBmTEx3VTdwbWMzblBBbVFqMW03RTZXMXBvdU5CT3Ewc2lJ?=
 =?utf-8?B?Z1NWVDQ1cnlraDU5cUhYOFMrcXQ1QzRseDVRekFCaExxTkx2QldVb3owQTVu?=
 =?utf-8?B?MkdTOXdFTWFMZkdUQkl3RXZHdkY0MTNHZmpUSVNYaWsxdnpUY2lDRDllcTFW?=
 =?utf-8?Q?k/8pFy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4196.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmI1V0FKanZkb2pPWWxndHZCU3UzWUt6K1U2M0RvbVdoSlI2b2ZGZzFGdFJH?=
 =?utf-8?B?SHRKQmdORVJZNnFFUk80blk2QmZvUmR0L2VpdDJnamFOWW45U0xqZndHa0o5?=
 =?utf-8?B?WDNsK3poZWsxVnF2cE1kbzErRnlxRDRQQ0FDNEVVcnh5citXU0Fha3FiSVdT?=
 =?utf-8?B?NDB3ZlY0d1NXN21wcjdVQXlvT2VRYUhZODZMbGdwLzVPZ1BZRGlQYUVmUC9J?=
 =?utf-8?B?Ym1udDF3V1AzVkFtMW4wdk5mRFV0VmVGZUp2MjhncWl6RFYvOHpBWXkwVFFU?=
 =?utf-8?B?MlYzckhjMVEyWVhTL0VycFlOZytPUWFWaWszTmJOd0tGaWVFRkp2VXFYa09t?=
 =?utf-8?B?a3dmeEcyOVdLcllINGpyWWZneVRMNlFtNWFlZk5HeEtmKzh5aW9RZUZtZVp4?=
 =?utf-8?B?ZTZTVDNFQjhicnFUbnlHN1ppOGt5Y0Vib2xtRHdGbno0SkFOSHFPQTlscE5h?=
 =?utf-8?B?N25ocHhkam4ySVJJdHFPWmhEa1UwRkUzOFVsWS9vd1RrcmJkZGFsZ2pNMTZr?=
 =?utf-8?B?WDRKYUN4QzRVQlNGcjdxREw1WVIrUVBvVzQ0UFZzVGYxM3ZWNWYyeG42YWxs?=
 =?utf-8?B?QjVlc3BOZUVBYXVHTnJZZW5xdkNZMmpiTHhibnEwemNqU0huVUNLREVTSzhh?=
 =?utf-8?B?dGJ1UDYwNFlscFYwa0oyYXVFeVIvRjIvcjNRUzhBalhldnB2blNveENTRUNk?=
 =?utf-8?B?VnQvVlIrdWVIZWo1WDQvc3Z3dHMvbkcvdjBVOXAybGFraExCY2l4aDZ6Ym84?=
 =?utf-8?B?MHphTWZxWGVvSXpYRE1kcVlESGlONzZwNWxDUkx1TkJ5M2NheVY0TzlRZWR0?=
 =?utf-8?B?VFhOOEYwZ2VrSlNTa3M2OUx6VmdUSHhNWlpyMVI5WGU2aUdtMmRRTWEwa1M0?=
 =?utf-8?B?SzBURTljbnl1WWpidjZvc0g0MlMxTUZLKzJXc28rV1pBSUJjSmlkQmRwaTZB?=
 =?utf-8?B?allHamd2RVNsaWZTSW1HWkVqZjMrOEpyWlM3emZlVWNsczlDWFBTTTBhQUNO?=
 =?utf-8?B?ZjZvSjdtcDA4ekFONEF3dlRxdkxZWVgwb2pORUJIQUp0dWZTQ0g0NHBidVBJ?=
 =?utf-8?B?ZXMvVzZRYkZVTTJZR1U5VUYzVktSVW10M0hFYy9QZ29ZWnhEcGtBMVd1TzFC?=
 =?utf-8?B?MFd4UUxLMG90WHlkVFhRd09kalhKQWhOQXhzazRxMlIxVWdySFl2MlozSVhQ?=
 =?utf-8?B?S2lzcEhjVWJYa21OOVJPek5SU0o1UDAraWRlOG16aVZmeXVFZy9VWGQwSmJp?=
 =?utf-8?B?bXdDOWhmeXBZVjlVVG5ZQm1tb0xiNmhTNUxFakNxVzh4YW13bldiM1JxNWtZ?=
 =?utf-8?B?NlFEbFpUWUhQT05XVEExbHZjRnRBOG9pV3JiR096VVF6K2hNNXVSdzMrdHRC?=
 =?utf-8?B?NnlMZTk0QTBlU0owamxwVlRpL3Fia0FNWS9zZGg5OTVjQkllUW1vbURMYm52?=
 =?utf-8?B?VXp0dDArSk9sc0kyVmRJUXVvVVlEblJqSm1yeTdBT1hTREVpV0hhQTkrL3lX?=
 =?utf-8?B?MHloSVRucTdDQlpVa1ROcWVHNEM0aEZiZ09MTWVwbi9TclJuZFlCYTk2cE9B?=
 =?utf-8?B?c2F0aVhLWVc0cG1WTEhwUEhSOHpWVGxqc2pkVkl6QnhzWVhtMGxhRVRSbmhX?=
 =?utf-8?B?M2JYMFhIZk11UHdsNVdiSGc4dkxpS3lOOUVIcW9ZMm9PbHhXTndEWUJTejNI?=
 =?utf-8?B?eUZmSFU2Ri9VNFk4TGtnWjVSaVNMWWFYOUhGejN3SmZqVTIxWGFFL1ZlV3dt?=
 =?utf-8?B?NFJPckpNL0lIV21WMUNKcHNsM29nUlM5YlVuaU15YzlHMk9JMzViZmRReG1m?=
 =?utf-8?B?eVd1ZjZxajhxSldscG04cFA1OGU1SEw4aE1ieGdUZ2FpYW5nY1dwMkR0cHIz?=
 =?utf-8?B?dFJ1RUpXcUdSaVdhNW1qelVTZzdicFl6OTBCRFlHT09aY3RDQnV2WFF1OC9W?=
 =?utf-8?B?dVFKL2pUNXROakRNNUVHcHczQ3p3WTBmaTRlZFh0dmhMOTh5WnRVK2lWUHdL?=
 =?utf-8?B?MWpVbi9EZTJNUGdnSnQybE5YNkxTdlphdEhLNmYxcXptd0JaYVp3OVZ4K2tt?=
 =?utf-8?B?QlJyd2hBUTJUNnRQeURGeEs4M3A2RWpkUFFuSjNpZkFWbG9BTnNxNXV2L0dH?=
 =?utf-8?Q?hoJ0QFmGjteQW3NqmvqIHqQuU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4196.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0eb08d-dca7-4b98-102f-08de106cd41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 06:41:13.3669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTh/6RATD4NceDNWGUCQPXPwM4CZWfnf82kA/XGIpXriXlTHMO9dX9qzVhy7LBaU6RZjwC+kjB5x+Y3bpVRHhoow4KVFO7WJwE5p48963LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5026
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

SGkgQ8OpZHJpYywgDQoNCj4gU3ViamVjdDogUmU6IGFzcGVlZDogU3BsaXQgdGhlIG1hY2hpbmUg
ZGVmaW5pdGlvbiBpbnRvIGluZGl2aWR1YWwgc291cmNlIGZpbGVzDQo+IA0KPiBIaSwNCj4gDQo+
IA0KPiA+IFBhdGNoIHNlcmllcyAxDQo+ID4gaHcvYXJtL2FzcGVlZF9hc3QxMDMwX2V2Yi5jIChh
c3QxMDMwLWV2YikgLS0tPiBvcg0KPiA+IGh3L2FybS9hc3BlZWRfYXN0MTB4MF9ldmIuYywgdGhl
biB3ZSBjYW4gcGxhY2UgKGFzdDEwMzAtZXZiIGFuZA0KPiA+IGFzdDEwNjAtZXZiKSBody9hcm0v
YXNwZWVkX2FzdDI3eDBfZXZiLmMgKGFzdDI3MDBhMC1ldmIsDQo+ID4gYXN0MjcwMGExLWV2YikN
Cj4gPg0KPiA+IFBhdGNoIHNlcmllcyAyDQo+ID4gaHcvYXJtL2FzcGVlZF9hc3QyNDAwX3BhbG1l
dHRvLmMgKHBhbG1ldHRvLWJtYykNCj4gPiBody9hcm0vYXNwZWVkX2FzdDI0MDBfcXVhbnRhLXE3
MWwuYyAocXVhbnRhLXE3MWwtYm1jKQ0KPiA+IGh3L2FybS9hc3BlZWRfYXN0MjQwMF9zdXBlcm1p
Y3JveDExLmMgKHN1cGVybWljcm94MTEtYm1jKQ0KPiA+DQo+ID4gUGF0Y2ggc2VyaWVzIDMNCj4g
PiBody9hcm0vYXNwZWVkX2FzdDI1MDBfZXZiLmMgKGFzdDI1MDAtZXZiKQ0KPiA+IGh3L2FybS9h
c3BlZWRfYXN0MjUwMF9yb211bHVzLmMgKHJvbXVsdXMtYm1jKQ0KPiA+IGh3L2FybS9hc3BlZWRf
YXN0MjUwMF9zb25vcmFwYXNzLmMgKHNvbm9yYXBhc3MtYm1jKQ0KPiA+IGh3L2FybS9hc3BlZWRf
YXN0MjUwMF93aXRoZXJzcG9vbi5jICh3aXRoZXJzcG9vbi1ibWMpDQo+ID4gaHcvYXJtL2FzcGVl
ZF9hc3QyNTAwX3lvc2VtaXRldjIuYyAoeW9zZW1pdGV2Mi1ibWMpDQo+ID4gaHcvYXJtL2FzcGVl
ZF9hc3QyNTAwX3N1cGVybWljcm8teDExc3BpLmMgKHN1cGVybWljcm8teDExc3BpLWJtYykNCj4g
PiBody9hcm0vYXNwZWVkX2FzdDI1MDBfZnA1MjgwZzIuYyAoZnA1MjgwZzItYm1jKQ0KPiA+IGh3
L2FybS9hc3BlZWRfYXN0MjUwMF9nMjIwYS5jIChnMjIwYS1ibWMpDQo+ID4gaHcvYXJtL2FzcGVl
ZF9hc3QyNTAwX3Rpb2dhcGFzcy5jICh0aW9nYXBhc3MtYm1jKQ0KPiA+DQo+ID4gUGF0Y2ggc2Vy
aWVzIDQNCj4gPiBody9hcm0vYXNwZWVkX2FzdDI2MDBfZXZiLmMgKGFzdDI2MDAtZXZiKQ0KPiA+
IGh3L2FybS9hc3BlZWRfYXN0MjYwMF9xY29tLWRjLXNjbS12MS5jIChxY29tLWRjLXNjbS12MS1i
IG1jKQ0KPiA+IGh3L2FybS9hc3BlZWRfYXN0MjYwMF9xY29tLWZpcmV3b3JrLWJtYy5jIChxY29t
LWZpcmV3b3JrLWJtYykNCj4gPiBody9hcm0vYXNwZWVkX2FzdDI2MDBfcmFpbmllci5jIChyYWlu
aWVyLWJtYykNCj4gPiBody9hcm0vYXNwZWVkX2FzdDI2MDBfZnVqaS5jIChmdWppLWJtYykNCj4g
PiBody9hcm0vYXNwZWVkX2FzdDI2MDBfYmxldGNobGV5LmMgKGJsZXRjaGxleS1ibWMpDQo+ID4g
aHcvYXJtL2FzcGVlZF9hc3QyNjAwXyBmYnkzNS5jIChmYnkzNS1ibWMpDQo+ID4NCj4gPiBGb3Ig
dGhlIEZCWTM1IHBsYXRmb3JtLCBzaW5jZSBpdCBpbmNsdWRlcyBib3RoIEFTVDEwMzAgYW5kIEFT
VDI2MDAsIHdlIG1heQ0KPiBjb25zaWRlciByZW5hbWluZyB0aGUgZmlsZSB0bzoNCj4gPiBody9h
cm0vYXNwZWVkX2FzdDEwMzBfYXN0MjYwMF9mYnkzNS5jICAoaHcvYXJtL2ZieTM1LmMpDQo+IA0K
PiBTaW5jZSBhc3QyNjAwIGlzIHRoZSBtYWluIFNvQyBvZiB0aGUgZmJ5MzUsICJody9hcm0vYXNw
ZWVkX2FzdDI2MDBfZmJ5MzUuYyINCj4gc2hvdWxkIGJlIGEgbW9yZSByZWxldmFudCBuYW1lLg0K
PiANCg0KaHcvYXJtL2FzcGVlZF9hc3QyNjAwXyBmYnkzNS5jIChmYnkzNS1ibWMgZnJvbSBhc3Bl
ZWQuYykNCmh3L2FybS9hc3BlZWRfYXN0MjYwMF9mYnkzNS5jICAoaHcvYXJtL2ZieTM1LmMpDQoN
CkJvdGggdGhlbSB1c2UgdGhlIHNhbWUgbmFtZS4gRG8geW91IG1lYW4gdG8gbW92ZSB0aGVtIGlu
IG9uZSBmaWxlPw0KDQpUaGFua3MsDQpKYW1pbg0KDQoNCj4gVGhlIHJlc3QgbG9va3MgZ29vZCB0
byBtZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

