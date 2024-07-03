Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwAe-0006z4-0O; Wed, 03 Jul 2024 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sOwAP-0006qD-Ot; Wed, 03 Jul 2024 05:20:46 -0400
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sOwAJ-0000dM-0K; Wed, 03 Jul 2024 05:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4jutL94JLKghhdXDcQna5/CHmjDc4GVeF6ntEqnEwFffVY0sN2il9udW0HE7QIGLPeBCbgaWhBJrS7ngtAg19UJDziDO8Qpbwb3j0M+8RHOX/MPdJx+wNwMd6gb5wXkPaL0uvxXV2B7NIOCwt+ZxyK0HHndffs2IIZwbJ3RTp1jacNZDPOIl2uCNySTy9TzvwWA/m2Aw3H0ThTCvVNfmPYe8/2G2H4jCkGiPqisVI5TLsd8upOJPevGMsiRvfNpFuP70HJc8F+cPJGDqkhmpLRXX3SsqHJnETSW0/c6tXxbs2Fk0C9akdYEJUYbTnbRkoB4RW1YdkhABrYtgsXGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMcQGw38P7kEEOLhhfBUjrT4AzeSd0P5AhsCJBgUrtg=;
 b=lrieojeBnph5cqVG0U+klvucAHNZWyr4SA6s/gkkvI5AA2TcJlBxiUy+Y5Tg1f1+41Sx+3wOu/oE5Ws9IY3K/tUesv/tN5RlYWGmE3HXhpXA5056nzgKcPZo/1lNGjF4gv4A7phlFE+FlIN8p0iz5PtsWhauEKYZIVo6ZdfDsxC+3BIXNxgIGxPrx4rlYppZwg8wYMARphLTG/aG2Nu+IuIhB11CGnKQEuq9ScONuM47YYKz7+MaxqdlgWH9kLgD0vmF5Dji+MPy+CtfJqI4IerIwyP1aImL5ibIshbdem5HBfk8vB/jW34bNTKEWrcTzMHXh6yg0B+mimy5jWKnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMcQGw38P7kEEOLhhfBUjrT4AzeSd0P5AhsCJBgUrtg=;
 b=fHgxIiuLMLmF7Gt7vgjLAR02VHD6BgXEIXVgRkxPQSgcAYwAX2xTZXf8cRQ1R2tvbAEZ5cb2FGRffaGUJMjz9jqO7mFnSJ9GLMhE/ZX4SyEDMTquOVWQvMUL4KYSus9j9CLAI98fWxTiy5xqTttgQpYbRwc4bCxUvlhJ+Ws52FL8o6GgJdzEwkebQuS7I/YgNktagEu5vr+6mh7zvuI5mc1DtEypt5kmpolMnKLFKkK98NdFSJyWNlLwe/hlKZu1LVEOUksd6EGYnNx/7Rpobh1rFLZy2etlyk26/9IjQqyCah2V3g+K4PVWjqmn/8rxvLeNU0gP6M5uVOagwHFGRA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6565.apcprd06.prod.outlook.com (2603:1096:400:452::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.25; Wed, 3 Jul 2024 09:20:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:20:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 5/5] test/avocado/machine_aspeed.py: update to test
 network for AST2700
Thread-Topic: [PATCH v2 5/5] test/avocado/machine_aspeed.py: update to test
 network for AST2700
Thread-Index: AQHazSFTHWzHDxhfEE6hBVlVuFfCWbHkuZwAgAAAY5A=
Date: Wed, 3 Jul 2024 09:20:31 +0000
Message-ID: <SI2PR06MB5041F72B4AC7059D9C9785CCFCDD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
 <20240703081623.2740862-6-jamin_lin@aspeedtech.com>
 <153d7e87-28d6-403c-9d84-786c52cd6acb@kaod.org>
In-Reply-To: <153d7e87-28d6-403c-9d84-786c52cd6acb@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6565:EE_
x-ms-office365-filtering-correlation-id: fafd9e12-df1e-43b2-240a-08dc9b41632d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bklUU2tkVHY3NTJWa0dObVk2cmxLNUluUWdaWVRkVityWTVnQkdpSUJPRFFH?=
 =?utf-8?B?V0hWeDlPWW9LeC90QVRlQ2s1eS9jTW9keHYvT25NbFZmb29QYmNubDRQWjdq?=
 =?utf-8?B?azVxOFQrcnlEakloVnErQWtSOXBzbVJBNU53SVZBU2lPcC9qNlhIS1JtOU42?=
 =?utf-8?B?MUpsdnAwcUFsQU1TZ3M1alE2Z2FCWFphbzBydm5TYnZjSXh4ZzlGaWRtYUhO?=
 =?utf-8?B?MzR3aG5yMzlMTGQ0RGFYY1hTaFFZYWk0aHQvU3pIQmtrdENZaXpWSmp2a2g2?=
 =?utf-8?B?Zkd6azZiMDV6dlBrM05FSEtFVEhpT25JaFlnajVNZ0hBSUd1dXZxZWNFT1FQ?=
 =?utf-8?B?UFkzejJ5NXd3UTBBRHQ5eXgvRG1DU1BaamFlTmtOS2oyOGprQWQ0ajNVT3hw?=
 =?utf-8?B?S1FIMjFEZ0YrNm1aQldlVk1rdTl2azZMSFdCbWp5UHRxSklhd2FmOTVZMVBF?=
 =?utf-8?B?eUM4R3JhOWFsdDdCOW1OcUxJRG5NSkNWeWhXRXhadHAzSGNvTENrMExzU21B?=
 =?utf-8?B?bXpWZTFCWERSdmZvbW9VdjFpNUlTd2tVcHRhck93R2RsTHUyVjVRVHM4dGt2?=
 =?utf-8?B?WWxWMGY0aStCaUNLa2FTTi96TDJTNnhrSzNvWHE0WGZSS0RSMnpwWGNic0p5?=
 =?utf-8?B?VXJhbmVxR1BYQzNPcUZrNGVWcVFzd1dMU2dzRVRHT1hvQmorazNRSkYvT2E0?=
 =?utf-8?B?WGQxajhnNkJ1Z1BiTE5GV3BmenZQRlh1OXJWaWg4WHJpL01KM08ybXBHZDNZ?=
 =?utf-8?B?cWNSa0hyWS9vYytKUkpBUlZaeGNxejN3VG9TK0ZKRmtTVTVjd2hycThmWXB6?=
 =?utf-8?B?Vk93dU93LzBZaEFWTzlTaFZhcnhQUTB5a3NaV2Y3RncwNWZ1cEpiTmJEaXJU?=
 =?utf-8?B?TndkNW40Q20xVWp2eldIZWN1Yyt4MjhCSEtRNmVWdkQ2K1JaaGVKSXVkcm0x?=
 =?utf-8?B?czZLV3pqWGNVcmxWVWJGRVduSXZhWVJoanFtOGJQYk5RT3BhNU1HcnpoaUNH?=
 =?utf-8?B?akJ2MmVwL0hvMXBvME13L2hNamN2VkFJTGNic3ZZWnk4elZ5OFF5WS9Jc2dV?=
 =?utf-8?B?aDFSMVpEbzc2azBWTHZTcGp1RFl5ei9zQXNhTjRyT2hZMDZsSmVxNTMzSVNS?=
 =?utf-8?B?bThjR0c1VGpOTlVmZktXL29YS2ZRdERuT1h2MmpySTNpcXdwUGlHK2dVcFN6?=
 =?utf-8?B?WVpNQmJqc3d1ZGY4WHZ3aHh1VkdhR0JOYkdBSWV0UzhHdGx1cTQvZHFBeUNY?=
 =?utf-8?B?Q1htd1hqT0RSeDQvY3M4OFBrMVl4UkxtS000NThicUthWXdlS2l0WDAyQzhv?=
 =?utf-8?B?a0MrQmpQamVSSy9rMzJ0ZGRuSFpNY2pVRDFBWDFPbVhpVWF5ZkE3eTh4YlpC?=
 =?utf-8?B?ZzFwd1JNUjNXdjVIOSs5bG9NQ0xtK3JVeGNJQU1tckxlaEUvQXhpQ0FEVmpy?=
 =?utf-8?B?SUtoSjc3VGRQVS8wQVZ1aUU4RzFHSUJIMFdTSVZLTUNXZCtKNEE3SVN2USta?=
 =?utf-8?B?SWVOdzhjSFgvRm5WbldEcUNucnRKMlFZOWdodmcyQm9Gd0tYUnFHT1BIOGRG?=
 =?utf-8?B?dVFWWS9qZFNkbXBFVElrcElWNTlpWUJ4Zm5qSml4VkczSlRDUzVFNkNCNDhZ?=
 =?utf-8?B?TXVXVURkNEhRRVkvVXl2ZUg1MG9PTFA0MXE2dVV3a1ZxeTMydHIraTRlN1JU?=
 =?utf-8?B?YlhIQTdVLzRDY3QwZHZzdFZ0cWR2ODVmVGlLMi90Mmp6TStkNDJ4Zk5VVEtW?=
 =?utf-8?B?SGN2Q2dzMmVnQkFOakd5Zy9YTWV1M1hxdU9PZXYyY1pUN2cxby9STXJneDl5?=
 =?utf-8?B?YzdCYTRoZExYZERnSnp0R1lqNExGZWc2K0hXbnVWVFhNNHFDQW5xQ2c5c3Qx?=
 =?utf-8?Q?SR4p3iIkxpAxZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MERVdGJNNFA5MExpbzRUWjZhLzFzb25vYzhCR2JMUUFiRllHaUg0Nkp4eHRW?=
 =?utf-8?B?alMzWVorbGRIWCtnbWdDMGY0SUVRdEpmN3hGeTk2QUdrekVtazk3b0Rrb05h?=
 =?utf-8?B?U1poMWNRSGx5MFcwL1NNdmhkMGQ5S3Q1d1Jkbk4wZkhaeUV3cjU1S2NGa083?=
 =?utf-8?B?K29DUmV0ZHVVZUo3ODFSQkJhaHlmMDhhZzJqTVdBUUNpT2tKaXJ6dmVOakhy?=
 =?utf-8?B?bjc2K09VL1Q1YkorZnN0UjI1K3M5eFRuOWYrUmMvblFOaGplTXY4T3pEVDhh?=
 =?utf-8?B?QmhsbWxIZno3Y2Z2UVdsZWpLN1Bjdk5ub0ovQ2hxcUFRaExIWU5nYzFVQUV4?=
 =?utf-8?B?aDNvT2hVRElFc2dUWHlJSDVLT1hTZE50OFhYWjkyMmd1Q1pERThjelpmSng2?=
 =?utf-8?B?ZklUMk5TR0U4TklEUmxYem1vcmdKeHN2b1VxT2NBY01YeW9VUXpXWStxUXFZ?=
 =?utf-8?B?eG55V1UzbXpncFljdWlwSTJsUlVJUTZ0T2VZWmZRZ3BEZldZS1ErRWxkWHpv?=
 =?utf-8?B?YkZtbFFJRFBBZU42QTd1alVWY09RVURYVVV5aDh5c3hWTWVyd2E2bStyYjV2?=
 =?utf-8?B?RDRneG9kcHlmTDRsQTVTNEZUQXpiRU9GY3czM1prMzFCZDdaSlFNTExJL3VY?=
 =?utf-8?B?Z1VsdXdGYlZtUGRDazJiOHdLQlhkeldJK3duclNON1F4b3BtMldYZU92aCtS?=
 =?utf-8?B?Rnpkcy9kY0hwV3ZJM3VOaGJhU3JYbFBTTHBUSUxrUnlKMGdPUnc2RWdOK1RT?=
 =?utf-8?B?bmN1UDdxQ1BUWGhxTHh2QVVxS0ZEMWgyRld1Y1M5Z3ozRzBUUW1NYzJ0UU5J?=
 =?utf-8?B?anJ4dVliQ0xXV2FQd2xUM2ZKZjRVNVdSVEJkM1IxaXZEZmNTUmkzSDFmVkZO?=
 =?utf-8?B?TU12TFNuREY4VnhoM3hERk9XYWJlTlp6TE9jaVU3SzJ3K1pCU05ZcHVGMlpW?=
 =?utf-8?B?a3NtcXhXcDRmMGZqa2Y3clJQUWMvSXFPb1JWNm8zTldITURidXJycWdpSVY4?=
 =?utf-8?B?aDlvQ3BZN1NIOFA5ZlVYbHlVNURpc1pXNWZDRzdMWmY5MTBXOEd5UFk2UHBh?=
 =?utf-8?B?NUhWOUd3QkhXQ2Rka1NoQXRmVG1uNVRvc3hGRFZYT3hvai9GQVJ3VkZZOWNa?=
 =?utf-8?B?ZHdHMURiNXRCbnpXVjVxVjZtTWdVN09UTDVOcDRBdU5GYzZVbm5FMHUwenVP?=
 =?utf-8?B?a1IycmwrUGV1cnVIdXJ6dDNHaVEwWDVYc1BjL2wzcTl3ZmY1N2Vlb0d4SjJz?=
 =?utf-8?B?MjVmblE5MWZhbUpacE9Da2U4ZEdhc0lUUzEwVmt4YjFYOVYwMzh4dDlhbEZN?=
 =?utf-8?B?OUFuaGdOWXlNQ2gxdk5yMnhBZm4xSnZ5RXcvd01JQVB2U0huRk4vYkVTWWZa?=
 =?utf-8?B?a2dDZ0NtMTlzLzhBTnZ4K3Bua3hNR2tleGhISWEwVVNlMTJyRzYrWXgxdDBj?=
 =?utf-8?B?dTZpa1lxc1dOWHlXdzBJakYrUUVtYU5NOHFMbmh2N2VuVG9JeVc5NklVUGxw?=
 =?utf-8?B?MXhXY1d4RGtxdzNCeTVNQ1k1LzBGUGV3Q2hMS24zemJPbDNKWDl1M3VTU2FD?=
 =?utf-8?B?K3YwTnAxeW9uWlp2MEZUOEpnOXc2YURaNVZIMytEcTN0Q3g3cFZDRjZZSWxi?=
 =?utf-8?B?aWJOWkFPTFA0N0tieFR3akwrenNqZFdYbzFWdjZQWkdCZm5GdVdRZkI0NEhr?=
 =?utf-8?B?a3hNMERSbE9oa0RBaWdnVHN3QW5TQTNEODE1eVR3QnB2dSt3YXdCY0ZOR3Vt?=
 =?utf-8?B?Z3AwYko5N29tNWNzdU9BbC9pK2xNODhBWGVFVG9MWCt2VTBPZmU0VGk1dDRN?=
 =?utf-8?B?RklWTys2d0hFeGRIanNCa045Q3BxbmpHWDg2U29hK0xaVUIyNkVDa3VsVFdw?=
 =?utf-8?B?YTBVeGNVczJYZkY0QTRJM3lHVVNOYit0ZkhnY0dsZS9TQUJsUVR5bTViRWhq?=
 =?utf-8?B?elI2U3RLaHd6UXF3Qk1DdWZNeURmdGNvalE4QnlKT0FmSkFKMHEyRlloT0k4?=
 =?utf-8?B?T2Y2SWFMQXFWdFNFbGZXWHM4MzVkK3hSV1grTks2TkttdVRDVVdCc3hhY1BO?=
 =?utf-8?B?dmV0cVhGKytkVTQ3enNnUFJ1cEZZK2wzMVNTek1Ud05BN0RlWFJWWGIrWDg4?=
 =?utf-8?Q?6Qw6JXM+GvqgkWN2XiKKGIac9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafd9e12-df1e-43b2-240a-08dc9b41632d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:20:31.8300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5Vx2fxORF7W44gQrAyhQZwynMnGOqWXUsdMRfjrxMtI71m4Drg8a/q37QWw0C0rpQxJxxMtO5h92RjfSCrOOcp+I8q4cZ0XotEc8c8+BKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6565
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMywgMjAyNCA1OjE4IFBNDQo+
IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwN
Cj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNw
ZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBBbmRyZXcgSmVm
ZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsNCj4gSm9lbCBTdGFubGV5IDxqb2Vs
QGptcy5pZC5hdT47IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBL
ZXZpbg0KPiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgSGFubmEgUmVpdHogPGhyZWl0ekByZWRo
YXQuY29tPjsgSmFzb24gV2FuZw0KPiA8amFzb3dhbmdAcmVkaGF0LmNvbT47IENsZWJlciBSb3Nh
IDxjcm9zYUByZWRoYXQuY29tPjsgUGhpbGlwcGUNCj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPjsgV2FpbmVyIGRvcyBTYW50b3MgTW9zY2hldHRhDQo+IDx3YWluZXJzbUByZWRo
YXQuY29tPjsgQmVyYWxkbyBMZWFsIDxibGVhbEByZWRoYXQuY29tPjsgb3BlbiBsaXN0OkFTUEVF
RA0KPiBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIEND
IGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IG9wZW4gbGlzdDpCbG9jayBsYXllciBj
b3JlDQo+IDxxZW11LWJsb2NrQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS81XSB0ZXN0L2F2b2NhZG8vbWFjaGluZV9h
c3BlZWQucHk6IHVwZGF0ZSB0byB0ZXN0DQo+IG5ldHdvcmsgZm9yIEFTVDI3MDANCj4gDQo+IE9u
IDcvMy8yNCAxMDoxNiBBTSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFVwZGF0ZSBhIHRlc3QgY2Fz
ZSB0byB0ZXN0IG5ldHdvcmsgY29ubmVjdGlvbiB2aWEgc3NoIGFuZCBjaGFuZ2VzIHRvDQo+ID4g
dGVzdCBBc3BlZWQgT3BlbkJNQyBTREsgdjA5LjAyIGZvciBBU1QyNzAwLg0KPiA+DQo+ID4gQVNQ
RUVEIGZpeGVkIFRYIG1hc2sgaXNzdWUgZnJvbSBsaW51eC9kcml2ZXJzL2Z0Z21hYzEwMC5jLg0K
PiA+IEl0IGlzIHJlcXVpcmVkIHRvIHVzZSBBU1BFRUQgU0RLIGltYWdlIHNpbmNlIHYwOS4wMiBm
b3IgQVNUMjcwMCBRRU1VDQo+ID4gbmV0d29yayB0ZXN0aW5nLg0KPiA+DQo+ID4gQSB0ZXN0IGlt
YWdlIGlzIGRvd25sb2FkZWQgZnJvbSB0aGUgQVNQRUVEIEZvcmtlZCBPcGVuQk1DIEdpdEh1Yg0K
PiA+IHJlbGVhc2UgcmVwb3NpdG9yeSA6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRl
Y2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvDQo+ID4NCj4gPiBUZXN0IGNvbW1hbmQ6DQo+ID4gYGBg
DQo+ID4gY2QgYnVpbGQNCj4gPiBweXZlbnYvYmluL2F2b2NhZG8gcnVuDQo+ID4gLi4vcWVtdS90
ZXN0cy9hdm9jYWRvL21hY2hpbmVfYXNwZWVkLnB5OkFTVDJ4MDBNYWNoaW5lU0RLLnRlc3RfYWFy
Y2gNCj4gNjQNCj4gPiBfYXN0MjcwMF9ldmJfc2RrX3YwOV8wMg0KPiA+IGBgYA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IA0K
PiBDb3VsZCB5b3UgcGxlYXNlIHNwbGl0IHRoZSBwYXRjaCA/IFRoZSBjaGFuZ2Ugb2YgU0RLIHNo
b3VsZCBiZSBhIHN0YW5kYWxvbmUNCj4gcGF0Y2guDQo+IA0KV2lsbCBmaXgNClRoYW5rcy1KYW1p
bg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICAgdGVzdHMv
YXZvY2Fkby9tYWNoaW5lX2FzcGVlZC5weSB8IDEzICsrKysrKystLS0tLS0NCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvYXZvY2Fkby9tYWNoaW5lX2FzcGVlZC5weQ0KPiA+IGIvdGVzdHMvYXZv
Y2Fkby9tYWNoaW5lX2FzcGVlZC5weSBpbmRleCAzYTIwNjQ0ZmIyLi44NTVkYTgwNWFlIDEwMDY0
NA0KPiA+IC0tLSBhL3Rlc3RzL2F2b2NhZG8vbWFjaGluZV9hc3BlZWQucHkNCj4gPiArKysgYi90
ZXN0cy9hdm9jYWRvL21hY2hpbmVfYXNwZWVkLnB5DQo+ID4gQEAgLTMxMywxNCArMzEzLDE0IEBA
IGRlZiBkb190ZXN0X2FybV9hc3BlZWRfc2RrX3N0YXJ0KHNlbGYsIGltYWdlKToNCj4gPg0KPiA+
ICAgICAgIGRlZiBkb190ZXN0X2FhcmNoNjRfYXNwZWVkX3Nka19zdGFydChzZWxmLCBpbWFnZSk6
DQo+ID4gICAgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoKQ0KPiA+IC0gICAgICAgIHNlbGYu
dm0uYWRkX2FyZ3MoJy1kcml2ZScsICdmaWxlPScgKyBpbWFnZSArICcsaWY9bXRkLGZvcm1hdD1y
YXcnKQ0KPiA+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1kcml2ZScsICdmaWxlPScgKyBp
bWFnZSArICcsaWY9bXRkLGZvcm1hdD1yYXcnLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgJy1uZXQnLCAnbmljJywgJy1uZXQnLA0KPiA+ICsgJ3VzZXIsaG9zdGZ3ZD06MTI3LjAuMC4x
OjAtOjIyJykNCj4gPg0KPiA+ICAgICAgICAgICBzZWxmLnZtLmxhdW5jaCgpDQo+ID4NCj4gPiAg
ICAgICAgICAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oJ1UtQm9vdCAyMDIzLjEwJykN
Cj4gPiAgICAgICAgICAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oJyMjIExvYWRpbmcg
a2VybmVsIGZyb20gRklUDQo+IEltYWdlJykNCj4gPiAgICAgICAgICAgc2VsZi53YWl0X2Zvcl9j
b25zb2xlX3BhdHRlcm4oJ1N0YXJ0aW5nIGtlcm5lbCAuLi4nKQ0KPiA+IC0gICAgICAgIHNlbGYu
d2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKCJzeXN0ZW1kWzFdOiBIb3N0bmFtZSBzZXQgdG8iKQ0K
PiA+DQo+ID4gICAgICAgQHNraXBVbmxlc3Mob3MuZ2V0ZW52KCdRRU1VX1RFU1RfRkxBS1lfVEVT
VFMnKSwgJ1Rlc3QgaXMNCj4gPiB1bnN0YWJsZSBvbiBHaXRMYWInKQ0KPiA+DQo+ID4gQEAgLTM4
NywxNSArMzg3LDE1IEBAIGRlZiB0ZXN0X2FybV9hc3QyNjAwX2V2Yl9zZGsoc2VsZik6DQo+ID4g
ICAgICAgICAgIHllYXIgPSB0aW1lLnN0cmZ0aW1lKCIlWSIpDQo+ID4gICAgICAgICAgIHNlbGYu
c3NoX2NvbW1hbmRfb3V0cHV0X2NvbnRhaW5zKCcvc2Jpbi9od2Nsb2NrIC1mDQo+ID4gL2Rldi9y
dGMxJywgeWVhcik7DQo+ID4NCj4gPiAtICAgIGRlZiB0ZXN0X2FhcmNoNjRfYXN0MjcwMF9ldmJf
c2RrX3YwOV8wMShzZWxmKToNCj4gPiArICAgIGRlZiB0ZXN0X2FhcmNoNjRfYXN0MjcwMF9ldmJf
c2RrX3YwOV8wMihzZWxmKToNCj4gPiAgICAgICAgICAgIiIiDQo+ID4gICAgICAgICAgIDphdm9j
YWRvOiB0YWdzPWFyY2g6YWFyY2g2NA0KPiA+ICAgICAgICAgICA6YXZvY2FkbzogdGFncz1tYWNo
aW5lOmFzdDI3MDAtZXZiDQo+ID4gICAgICAgICAgICIiIg0KPiA+DQo+ID4gICAgICAgICAgIGlt
YWdlX3VybCA9DQo+ICgnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMv
cmVsZWFzZXMvJw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAnZG93bmxvYWQvdjA5LjAxL2Fz
dDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neicpDQo+ID4gLSAgICAgICAgaW1hZ2VfaGFzaCA9DQo+
ICdiMWNjMGZkNzNjNzY1MGQzNGM5Yzg0NTlhMjQzZjUyYTkxZTllMjcxNDRiODYwOGIyNjQ1YWIx
OTQ2MWQxZTA3Jw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAnZG93bmxvYWQvdjA5LjAyL2Fz
dDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neicpDQo+ID4gKyAgICAgICAgaW1hZ2VfaGFzaCA9DQo+
ICdhYzk2OWMyNjAyZjRlNmJkYjY5NTYyZmY0NjZiODlhZTNmZTFkODZlMWY2Nzk3YmI3OTY5ZDc4
N2Y4MjExNmE3Jw0KPiA+ICAgICAgICAgICBpbWFnZV9wYXRoID0gc2VsZi5mZXRjaF9hc3NldChp
bWFnZV91cmwsDQo+IGFzc2V0X2hhc2g9aW1hZ2VfaGFzaCwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYWxnb3JpdGhtPSdzaGEyNTYnKQ0KPiA+ICAgICAgICAg
ICBhcmNoaXZlLmV4dHJhY3QoaW1hZ2VfcGF0aCwgc2VsZi53b3JrZGlyKSBAQCAtNDM2LDQgKzQz
Niw1DQo+ID4gQEAgZGVmIHRlc3RfYWFyY2g2NF9hc3QyNzAwX2V2Yl9zZGtfdjA5XzAxKHNlbGYp
Og0KPiA+DQo+ID4gICAgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1zbXAnLCBzdHIobnVtX2Nw
dSkpDQo+ID4gICAgICAgICAgIHNlbGYuZG9fdGVzdF9hYXJjaDY0X2FzcGVlZF9zZGtfc3RhcnQo
aW1hZ2VfZGlyICsNCj4gPiAnaW1hZ2UtYm1jJykNCj4gPiAtDQo+ID4gKyAgICAgICAgc2VsZi53
YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oJ25vZGlzdHJvLjAgYXN0MjcwMC1kZWZhdWx0IHR0eVMx
MicpDQo+ID4gKyAgICAgICAgc2VsZi5zc2hfY29ubmVjdCgncm9vdCcsICcwcGVuQm1jJywgRmFs
c2UpDQoNCg==

