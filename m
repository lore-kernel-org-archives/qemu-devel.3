Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278A3C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 06:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUJBG-0007Vt-Nr; Wed, 25 Jun 2025 02:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUJBA-0007PH-KU; Wed, 25 Jun 2025 02:00:18 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUJB6-0001t6-7V; Wed, 25 Jun 2025 02:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBEYTrRgVKPMV4shOoNhgGL5qJF5faZEkfJ1CUTgjYS83R9wdzeCPH7EKuuoPjYMYHuNX6NTIz4eVjVMl18PZgJp6yza4aaR9eIIE+sq9p0pBT8JAqBzTL/80r8cDQH5U6LSJZFvnjYGqTPky/6ATiJKTlszQbmBoNLFf5th9pIIo1JBNM4iKxu06qf3UzRFUjAfcKT6S+ozzMUCuQOgmWvxlTcL77ObtgmPGIggpx4gPVhBBvtSmMMM/UsCQgRb+mrkhy54Dp+lLJ/Ckvylie6Ly4OA22kkaLhLeKd5gFoxEJDFwyObU+lUubtXneBV5LZ7j6cK2OuCJDue9qNbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cHbD8aRQygyChaGWPEWkJPp7kR/fU628dDH+dcUwMg=;
 b=R8YDzkoGk+vW/EkBBD3r7C0tYNm+NwH70wLuKiba+xGuft1ZS3GOT1RTdGvHs2fv9mY44QO9cpn0CkSzxKjnal20aahW+GFWOmrOhUiTmkXjihAgRnGkdHzHZkvW6WoaD55uNdTv9ZOpNy/XXp8sqPTXpAAst8RvW+Ch7ip6Rdu980SKJprEik7clq9R/2DM1E3AihHWlpjQAl116cQL7AVqhvUB/3O7e1bp6f7bynfg94XZAe66izqXG0wdSuTzyMbotCuWZYKecfi57Nj+UY1d4AirLTq2uf0Uz6PPzORK35o3fEhOCAGh/ezrNG20O14Vix96Me+xXcV6VlgXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cHbD8aRQygyChaGWPEWkJPp7kR/fU628dDH+dcUwMg=;
 b=amtCP0zTaG721fgKlJpDFAbcfejjkaUzBxmkEN5qRh1hmMso+SwyygNMrVtuTVA2R7N9K5UgbFpK2Z7zIpkMk75X0PAWa7WiYeglbfN83DJqCJ2rzLQ7RSul61K5oJoo3L52X6Gf7Rezzq5Cr/mbLQXI2r6WI1+06JEftmVfY0aCR2RC6Ks19usVSWoCzdUQydGZitPJ+WvTHmiRMuFlsWBSABBekEQIkMvhuLwDhTblQLQKq+WHQiIJ6ROJFPlh/ome9hworSniXUbTC1X8Ze23CYRqFaOVaGBPqIJ1STeCZ6JeHuPPS2v5Qi4j+/44QD+RpnDujRuIpER9dIp5BA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6669.apcprd06.prod.outlook.com (2603:1096:820:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 06:00:00 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 05:59:59 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Topic: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Index: AQHb5K7TOApg+TuBvUGRhcDupkjJHLQR2OUAgAFm9eA=
Date: Wed, 25 Jun 2025 05:59:59 +0000
Message-ID: <SI6PR06MB76316F7B660439BFEB5698FDF77BA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250624022219.3704712-1-kane_chen@aspeedtech.com>
 <20250624022219.3704712-2-kane_chen@aspeedtech.com>
 <601cae7f-8203-4068-a7ec-7cd3e11519d8@kaod.org>
In-Reply-To: <601cae7f-8203-4068-a7ec-7cd3e11519d8@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6669:EE_
x-ms-office365-filtering-correlation-id: 05537eed-6bae-47ba-432e-08ddb3ad84ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEo0aGNlaXFCeUxjaVJmbjFaaTNIR0hScE1VZVlSUnBnalAwSW0wMnE3QjhN?=
 =?utf-8?B?ZGZRTXl6cHNybjE1US8wWWJrRDRsK3JnMXdrSGw4ZjNkWjhOVHVZT2JoYnoy?=
 =?utf-8?B?L1lWbGlxN1l4WjlOREF2NGJFL1VsMnpFUUdNSnByaHB5N1FlcUFDODMxK0VY?=
 =?utf-8?B?eG0yOWkyeS9Vb2dUd1JKL3BaaVArOXZDTlRlRzlxVllhYjF1MU9PZVZMblo3?=
 =?utf-8?B?aGRwR0djbnI1UEhBRndROEcyU3Z1Q1VRcXNIYlNmVDJwNy9RRmkvR2tUVVE0?=
 =?utf-8?B?K250NVllelZkcG9xeHpjRVZVZytwSWVQQTB1NzlNbDJsclg4cDZCTUdkTzlC?=
 =?utf-8?B?aGQ3NkM3Z3BGc0lNTVBVRkkzTGpSUWtEWnFaZk9pSGRhbzZPbUJxamtGT3cx?=
 =?utf-8?B?OW1uTmNDQ2hqZTBLdzhwWG11Unk2Y1lFNzZGNWwwVVRWLzZPQUZKVzdFdStN?=
 =?utf-8?B?bWx5ZitYMFh4R0Z4YmVxb1FvWW9sL0FnRFZtWWdxa1VCTEh1cmxxTTRyd2Fa?=
 =?utf-8?B?K3VYcDQ4eUxtUEpldSs1YThpOFdhUnRJdVJiR1VzWHhPUDh6elBMZmRJOVNR?=
 =?utf-8?B?blRXS3hhenN2ZjNucVgxaGZxdEo5Tm83c0FFanJubkNxNGNjVldCWUtyL1Jy?=
 =?utf-8?B?cUk5RXlMV2hWODZ2N0NUSGkraEYxT1BGTnRhUzZ0VzZSRVVWL2FWbC9TenMv?=
 =?utf-8?B?WGtxNUZ4TDhCUzVxbXhVTTc0RmVpMnFHVjZNMUNLOHdsZDJNMnRMYkVIQkhL?=
 =?utf-8?B?ekVZSDdmeURkbzZLVVBSdDZ1OFpSYU0rdVc1d2JwQnhKWXFMcXFEbldZWUpQ?=
 =?utf-8?B?MGdpY3JjK0E4TExkQ1pYbXFoNjZjZjdZWi81RjRhbWRtVE9OckdIeDljckRn?=
 =?utf-8?B?V0gzUnVndGJpOG1aMnFxUGRVK3czTUpFTE1tVjh1N014WHpLU0ZFSUgwNCth?=
 =?utf-8?B?WHRtNDc1UFlqQzA5Tm9WK2V6Zm9GMlB0eXlKZkZCbisxRU1pWUhYZWc2RnF0?=
 =?utf-8?B?ODJ4MEt1N1ZjS09GNlpDdlBsa2RndFM3TytzSFFESmVXTGgwREpqc3M5VXVJ?=
 =?utf-8?B?TkV6Ynh4cUw2YWpIMmhGL2JOOWE2akdPZFpkSFVZVTBKY1VheS9TQlpUUG1u?=
 =?utf-8?B?L1JnbkVNbnorMEhDb0dranhQSUlEa2xmcUJpWkxTSnZidWJwVjd2bUlGSThP?=
 =?utf-8?B?NVhQRUUzTlB1YkVpVGxwb0x5a2tsb3IzQWxDNzJXNmdaQnJ5ci9YTDJCVEVC?=
 =?utf-8?B?d1AwVnlybFM4U2dxaVZqelhuNTIwKzh5RVlyQmc0ZXdpc0tITG9uSUlDd0dw?=
 =?utf-8?B?RTk0bTRuLzZ5bG13dXg0dW1tZ1RhQkR1bWdrMWxxWHYveTVlc3VseE9xN3VL?=
 =?utf-8?B?ZGY4SkdST0ZpWnFJWk9HSnNKQzMrb2pWdGh2WER4MHJYcnZLeVA1bjMyeXQ5?=
 =?utf-8?B?QzQ4UXFOUTYyNFZxeTVlbVU5VElLK0JlM1FIM2wzZTVKWVlEaGxNWS8rMFZ2?=
 =?utf-8?B?NUx3U01hZWhTcFFBZzVOc3o5QUdtOWM0eGdocE9hUFV0RktQUzNPTW9kMXAx?=
 =?utf-8?B?QlNycmxzZWlHb3FscHVRVlV6R3hvYnMvZkszQVh3TzAyZDJWN0V6ZDFob2RU?=
 =?utf-8?B?OVIzZVVQYjhzWGR1OVJ1R2I1ZzBtVmN1SGFhTHM2MUw3cWNlRkpVb0hWSUdX?=
 =?utf-8?B?cFhOSjUzM2ZTOUh1TDNRTXdDbjlna1d5d2Rrck4yNnlhY05nUC9nMCtMNlRG?=
 =?utf-8?B?MGZLbnpydytyQ0k0SEZuelViQm56RGI4K0xCVVJ1YVJ0S084RDZ0Wkl5L0xZ?=
 =?utf-8?B?UGNpQVl0WVQ3d0h0Rms0ZGVING5QaitOa0k0UmJOV1hOQUFqVys0aHpmN2FO?=
 =?utf-8?B?c0pGUGxhS0p5Qy9xcGpEMXpkOUx0YnNPdTFkdWRLd2hxdkxoU3RkQ2NIUGJB?=
 =?utf-8?B?czNXYmJEYTdCcmhpNHlRaldzS2RoSVp2cGFtVWMwMTFVOHEybUZEMERPaVll?=
 =?utf-8?Q?RotG/X+olwLtv+xdXESu0SyLh7B31E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjEwU1pwclAyQXhoYlNZdzhEbUVtcE9aaUZadE84Mi92L0UxNXVNdm1OUUlp?=
 =?utf-8?B?VU82QXFmWUdsN2dqOW1GRTJEUGJIZ1VxdldNMmtpY3NGVTZyYUpodE9iSTE1?=
 =?utf-8?B?dmpTNjRONzA5K2RwR053TG91cWo2MHlsc09mUDZnd2xyRHh5M0I3eWxZL0sr?=
 =?utf-8?B?aTZOK2ViYnJvMUg2YW1UZ3FaeURKOWJMbkxYSGJYYzlOU1lpRmY1bi81WGU4?=
 =?utf-8?B?MkxiUnR4YkJBYkFhYm1HZ3dJQmtsbFduWDl6ZmdVNlNTa2ptYThLTERieDdY?=
 =?utf-8?B?VlRtWkFpY3NjTVVsak5HYWhGWkc5dlI2TDZLN0VLV1ltL1ZtdVl6aWhnMFJt?=
 =?utf-8?B?VXF6Zyt3MjFZdHVBdkFxUStTNUZsSU82V2lNMUczRXpaTDczUmdZVmF0cUx3?=
 =?utf-8?B?RUdyVC94eDRHSFdXTURCSUNyRno3T21IUVdHUGgxMUEybk9xNmxhNDlLbE9m?=
 =?utf-8?B?ZmxVUXAxaWhWdjM5Y3BmaXVyVXg4WGN3aUtsdThrR1ZVaGZXOXpneHdNMUtq?=
 =?utf-8?B?S3RWUElLc0Y1TXRWN3B2cCtSajBleDY0d2ZoRGFsVFRRdHhRa0w3MFMxSHcw?=
 =?utf-8?B?d2VmNkxrc29hSWVVR2dpMjZOdHBaMHRYSUcrcEkrK0ZLa3g1QnFjaU40c0lM?=
 =?utf-8?B?YitWYWpRRkJwYnlUOVZDU1YyaFYwWTI0Q3UyN1EzRHF1NnpTZG15Ri9VMWwr?=
 =?utf-8?B?SGtqUjZYLzE4OUwxODIvWUNtUDNpdkFFK3Rpb2Y2czlYWjQvV3BxMVF2d2Vm?=
 =?utf-8?B?RmE3SSt1TWg5bmdRSmdVWVNzeURMcDN6QzlDbEJvTGNxd0s4UStPdklDUkpt?=
 =?utf-8?B?dHN1VkhKakFBQ0FNZFFYaXptcTdnSXNTVUZML2MrOEJsalZIWm55eHQvb1gx?=
 =?utf-8?B?ckJ1V0haWXo3T0FqL0s1Yit2YmlmenFYKzZFMVdxVDcvV1NxR2R6T0xwekI3?=
 =?utf-8?B?Y3d6YVpvSDlMWUdBdXVUYkRRVGk1NmdjZDBTSVIvQ1M2UmF5S2cyMjRpZjE2?=
 =?utf-8?B?RENPRUpRRjV1V2Z1MnRvRUx2ZzltWEluQU8zbWx2U3FKTzYyeDhkSy9FcGdX?=
 =?utf-8?B?RGhzY2NoZnNhQ001aWUxOE94RFd0cjc4VTFERWNIN2c0OVNyZVZuZ2drd2Ft?=
 =?utf-8?B?blZRQUdwNFBkMVV3WVdvNWE3L05FTmF0bVZSZ2RpQ2FtcEsrRDZTUkFHZHF1?=
 =?utf-8?B?YzduMmQwTmFURHVQcU5NOTg0S0FZZ1p5SVMrbzgvODJiM1VXMjBTUCttNzFH?=
 =?utf-8?B?OVBBaGh3YmRIQ243M1RTNm5VRlJFVXIxMExmOTlvY0syVHJrY2NhVnBHNkhW?=
 =?utf-8?B?MmJpVXNWazBwbHN2amxXOEM0RUhVQjlEQzVSclcrdkZPamE4OXgxTFcwZkZM?=
 =?utf-8?B?WFhnUTUzZWFQekpzb2I4ZUJ5RlE0OHpaWFRYYUNnREtsb3BDa0Y0b3FYaXlB?=
 =?utf-8?B?L2RTQzdjSEZhN2pubmN0dWd6T1FWb01IdCtCZFBKM0lqVnAyd3VpZlZpRHdB?=
 =?utf-8?B?RGdHdWFmbTd6ZUV0Y2dwM0VnM25iSG1GYXRnWHBxSDdpQkdRQU04SkVicS96?=
 =?utf-8?B?TlRDRVZoVlNFbmFtenhmOExCOUpSWGE2QkFBM2s3Z2JaSk5wWVhBaGFRa2RM?=
 =?utf-8?B?NlhucVFKUUp1UXZQTXJZazd5UkJiVzRMWWpsaEVMMHBaMVI3d2RmU3ZPeklp?=
 =?utf-8?B?NHZFbmtIZTJ2UVlIYkZyYkVPeHFpaXd1cjcrUjZXdmVKNitBcFZYVGNzNTlo?=
 =?utf-8?B?MGFPRFhzYkNUcnJkNGZhTVNINWxKc0FpZDNjYWkvQTBqMGsvRUJmaW53NjlU?=
 =?utf-8?B?NW8xNlp1Vy9QQytoQWpkQytZWTU0OVp6L2NINDE0dzhDdkF4MUxBQ0lvTEV6?=
 =?utf-8?B?eTNqakFERjZNaDhTZFM0QjkvNWRya2hpS2F4b2VYVU9waWhOVW5RaXB4ekhw?=
 =?utf-8?B?UCtIMUtxVEYvbENJVHFlWGpTazUxQWpzRS9mNi9kYVp3VjdwY0MxUUV6SE84?=
 =?utf-8?B?SnlZeHNBbnIzTnp1bmt5ZUVGaGN6MW9PMHRITEdsQm00amdhem1paVNGNmxH?=
 =?utf-8?B?UFlsaGhTaFRmM0JmZFNLeUdwVkNyM3NtbE1ETU5oOVhjM043QjdlS3ZuaE05?=
 =?utf-8?Q?/x7hZkdkgkNyzarzjnh0Q0j8C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05537eed-6bae-47ba-432e-08ddb3ad84ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 05:59:59.7388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43BmFqgnd8jkKdAtUwxPzg7BRqz0/oSm9Qw/yfaJ3O5YxgQO5djVHw98Ow1qirsJ574ILIQ26DEOWkS/AbjU0L2wkYlv1iDgQdii8sB1ZpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6669
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgaGVscGZ1bCBjb21tZW50
cy4gSSB3aWxsIHVwZGF0ZSB0aGUgY29kZSBhY2NvcmRpbmdseS4NCg0KSSBhbHNvIGhhdmUgYSBx
dWVzdGlvbiByZWdhcmRpbmcgdGhlIE9UUCBtZW1vcnkgY29udGVudCBpbml0aWFsaXphdGlvbi4g
U2luY2UgdGhlIE9UUCBtZW1vcnkgb25seSBuZWVkcyB0byBiZSBpbml0aWFsaXplZCBvbmNlLCBJ
IHBsYW4gdG8gbW92ZSB0aGUgaW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIHRoZSByZXNldCBmdW5j
dGlvbiBhbmQgdXNlIGEgZmxhZyB0byBlbnN1cmUgaXQgcnVucyBvbmx5IG9uY2UuIFRoaXMgd2F5
LCB0aGUgbWVtb3J5IGNvbnRlbnRzIHdpbGwgYmUgcmV0YWluZWQgYWNyb3NzIGRldmljZSBvciBt
YWNoaW5lIHJlc2V0cy4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSBjb25j
ZXJucyBvciBzdWdnZXN0aW9ucyBhYm91dCB0aGlzIGFwcHJvYWNoLg0KDQpCZXN0IFJlZ2FyZHMs
DQpLYW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUg
R29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjQsIDIwMjUgMjoy
OCBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBN
YXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5f
bGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5k
cmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47
DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHY2
IDEvM10gaHcvbWlzYy9hc3BlZWRfb3RwOiBBZGQgQVNQRUVEIE9UUCBtZW1vcnkNCj4gZGV2aWNl
IG1vZGVsDQo+IA0KPiBPbiA2LzI0LzI1IDA0OjIyLCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gRnJv
bTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4gPiBJbnRy
b2R1Y2UgYSBRRU1VIGRldmljZSBtb2RlbCBmb3IgQVNQRUVEJ3MgT25lLVRpbWUgUHJvZ3JhbW1h
YmxlDQo+IChPVFApDQo+ID4gbWVtb3J5Lg0KPiA+DQo+ID4gVGhpcyBtb2RlbCBzaW11bGF0ZXMg
YSB3b3JkLWFkZHJlc3NhYmxlIE9UUCByZWdpb24gdXNlZCBmb3Igc2VjdXJlDQo+ID4gZnVzZSBz
dG9yYWdlLiBUaGUgT1RQIG1lbW9yeSBjYW4gb3BlcmF0ZSB3aXRoIGFuIGludGVybmFsIG1lbW9y
eQ0KPiA+IGJ1ZmZlci4NCj4gPg0KPiA+IFRoZSBPVFAgbW9kZWwgcHJvdmlkZXMgYSBtZW1vcnkt
bGlrZSBpbnRlcmZhY2UgdGhyb3VnaCBhIGRlZGljYXRlZA0KPiA+IEFkZHJlc3NTcGFjZSwgYWxs
b3dpbmcgb3RoZXIgZGV2aWNlIG1vZGVscyAoZS5nLiwgU0JDKSB0byBpc3N1ZQ0KPiA+IHRyYW5z
YWN0aW9ucyBhcyBpZiBhY2Nlc3NpbmcgYSBtZW1vcnktbWFwcGVkIHJlZ2lvbi4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfb3RwbWVtLmMgICAgICAgICB8IDg1DQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvbWlzYy9tZXNvbi5idWls
ZCAgICAgICAgICAgICB8ICAxICsNCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfb3RwbWVt
LmggfCAzMyArKysrKysrKysrKysrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRp
b25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9hc3BlZWRfb3RwbWVtLmMN
Cj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX290cG1lbS5o
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9hc3BlZWRfb3RwbWVtLmMgYi9ody9taXNj
L2FzcGVlZF9vdHBtZW0uYyBuZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAw
MDAuLmIxM2I4N2ZhZTgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaHcvbWlzYy9hc3Bl
ZWRfb3RwbWVtLmMNCj4gPiBAQCAtMCwwICsxLDg1IEBADQo+ID4gKy8qDQo+ID4gKyAqICBBU1BF
RUQgT1RQIChPbmUtVGltZSBQcm9ncmFtbWFibGUpIG1lbW9yeQ0KPiA+ICsgKg0KPiA+ICsgKiAg
Q29weXJpZ2h0IChDKSAyMDI1IEFzcGVlZA0KPiA+ICsgKg0KPiA+ICsgKiAgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAi
cWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9sb2cuaCINCj4gPiArI2luY2x1ZGUg
InFhcGkvZXJyb3IuaCINCj4gPiArI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4gKyNpbmNsdWRlICJz
eXN0ZW0vYmxvY2stYmFja2VuZC1nbG9iYWwtc3RhdGUuaCINCj4gPiArI2luY2x1ZGUgInN5c3Rl
bS9ibG9jay1iYWNrZW5kLWlvLmgiDQo+ID4gKyNpbmNsdWRlICJody9taXNjL2FzcGVlZF9vdHBt
ZW0uaCINCj4gPiArDQo+ID4gK3N0YXRpYyB1aW50NjRfdCBhc3BlZWRfb3RwbWVtX3JlYWQodm9p
ZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICt1bnNpZ25lZCBzaXplKSB7DQo+ID4gKyAg
ICBBc3BlZWRPVFBNZW1TdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiArICAgIHVpbnQ2NF90IHZhbCA9
IDA7DQo+ID4gKw0KPiA+ICsgICAgbWVtY3B5KCZ2YWwsIHMtPnN0b3JhZ2UgKyBvZmZzZXQsIHNp
emUpOw0KPiA+ICsNCj4gPiArICAgIHJldHVybiB2YWw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyB2b2lkIGFzcGVlZF9vdHBtZW1fd3JpdGUodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHZhbCwgdW5z
aWduZWQgc2l6ZSkgew0KPiA+ICsgICAgQXNwZWVkT1RQTWVtU3RhdGUgKnMgPSBvcGFxdWU7DQo+
ID4gKw0KPiA+ICsgICAgbWVtY3B5KHMtPnN0b3JhZ2UgKyBvZmZzZXQsICZ2YWwsIHNpemUpOyB9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIGFzcGVlZF9vdHBtZW1f
b3BzID0gew0KPiA+ICsgICAgLnJlYWQgPSBhc3BlZWRfb3RwbWVtX3JlYWQsDQo+ID4gKyAgICAu
d3JpdGUgPSBhc3BlZWRfb3RwbWVtX3dyaXRlLA0KPiA+ICsgICAgLmVuZGlhbm5lc3MgPSBERVZJ
Q0VfTElUVExFX0VORElBTiwNCj4gPiArICAgIC52YWxpZC5taW5fYWNjZXNzX3NpemUgPSAxLA0K
PiA+ICsgICAgLnZhbGlkLm1heF9hY2Nlc3Nfc2l6ZSA9IDQsDQo+ID4gK307DQo+ID4gKw0KPiA+
ICtzdGF0aWMgdm9pZCBhc3BlZWRfb3RwbWVtX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3IgKiplcnJwKSB7DQo+ID4gKyAgICBBc3BlZWRPVFBNZW1TdGF0ZSAqcyA9IEFTUEVFRF9PVFBN
RU0oZGV2KTsNCj4gPiArICAgIGNvbnN0IHNpemVfdCBzaXplID0gT1RQTUVNX1NJWkU7DQo+IA0K
PiBXaHkgbm90IHVzZSBzLT5zaXplIGluc3RlYWQgPyBhbmQgYSBkZXZpY2UgcHJvcGVydHkgPw0K
PiANCj4gPiArICAgIGludCBpLCBudW07DQo+ID4gKyAgICB1aW50MzJfdCAqcDsNCj4gPiArDQo+
ID4gKyAgICBzLT5zdG9yYWdlID0gZ19tYWxsb2Moc2l6ZSk7DQo+ID4gKyAgICBpZiAoIXMtPnN0
b3JhZ2UpIHsNCj4gDQo+IGlmIGdfbWFsbG9jKCkgZmFpbHMsIHRoZSBhcHBsaWNhdGlvbiB3aWxs
IHRlcm1pbmF0ZS4gVGhlcmUgaXMgbm8gbmVlZCB0byB0ZXN0IHRoZQ0KPiByZXR1cm5lZCBwb2lu
dGVyLg0KPiANCj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJGYWlsZWQgdG8gYWxsb2Nh
dGUgT1RQIG1lbW9yeSBzdG9yYWdlIGJ1ZmZlciIpOw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4g
PiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBudW0gPSBzaXplIC8gc2l6ZW9mKHVpbnQzMl90KTsN
Cj4gPiArICAgIHAgPSAodWludDMyX3QgKilzLT5zdG9yYWdlOw0KPiA+ICsgICAgZm9yIChpID0g
MDsgaSA8IG51bTsgaSsrKSB7DQo+ID4gKyAgICAgICAgcFtpXSA9IChpICUgMiA9PSAwKSA/IDB4
MDAwMDAwMDAgOiAweEZGRkZGRkZGOw0KPiA+ICsgICAgfQ0KPiANCj4gVGhlIGFib3ZlIGluaXRp
YWxpemF0aW9uIGNvdWxkIGJlIGRvbmUgaW4gYQ0KPiBhc3BlZWRfb3RwbWVtX2luaXRfc3RvcmFn
ZSgpcm91dGluZS4NCj4gDQo+IEkgdW5kZXJzdGFuZCB0aGF0IHlvdSB3YW50IHRoZSB2YWx1ZXMg
c2V0IGF0IHJ1bnRpbWUgdG8gYmUga2VwdCBhZnRlciBhDQo+IG1hY2hpbmUvZGV2aWNlIHJlc2V0
Lg0KPiANCj4gPiArICAgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcy0+bW1pbywgT0JKRUNUKGRl
diksDQo+ICZhc3BlZWRfb3RwbWVtX29wcywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICBzLCAiYXNwZWVkLm90cG1lbSIsIHNpemUpOw0KPiA+ICsgICAgYWRkcmVzc19zcGFjZV9pbml0
KCZzLT5hcywgJnMtPm1taW8sIE5VTEwpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhc3Bl
ZWRfb3RwbWVtX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCBjb25zdCB2b2lkDQo+ID4g
KypkYXRhKSB7DQo+ID4gKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3Mp
Ow0KPiA+ICsgICAgZGMtPnJlYWxpemUgPSBhc3BlZWRfb3RwbWVtX3JlYWxpemU7IH0NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfb3RwbWVtX2luZm8gPSB7DQo+ID4g
KyAgICAubmFtZSAgICAgICAgICA9IFRZUEVfQVNQRUVEX09UUE1FTSwNCj4gPiArICAgIC5wYXJl
bnQgICAgICAgID0gVFlQRV9ERVZJQ0UsDQo+ID4gKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVv
ZihBc3BlZWRPVFBNZW1TdGF0ZSksDQo+ID4gKyAgICAuY2xhc3NfaW5pdCAgICA9IGFzcGVlZF9v
dHBtZW1fY2xhc3NfaW5pdCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVl
ZF9vdHBtZW1fcmVnaXN0ZXJfdHlwZXModm9pZCkNCj4gPiArew0KPiA+ICsgICAgdHlwZV9yZWdp
c3Rlcl9zdGF0aWMoJmFzcGVlZF9vdHBtZW1faW5mbyk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3R5
cGVfaW5pdChhc3BlZWRfb3RwbWVtX3JlZ2lzdGVyX3R5cGVzKQ0KPiA+IGRpZmYgLS1naXQgYS9o
dy9taXNjL21lc29uLmJ1aWxkIGIvaHcvbWlzYy9tZXNvbi5idWlsZCBpbmRleA0KPiA+IDZkNDdk
ZTQ4MmMuLmVkMWVhYWEyYWQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9tZXNvbi5idWlsZA0K
PiA+ICsrKyBiL2h3L21pc2MvbWVzb24uYnVpbGQNCj4gPiBAQCAtMTM2LDYgKzEzNiw3IEBAIHN5
c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19BU1BFRURfU09DJywNCj4gaWZfdHJ1ZTogZmlsZXMo
DQo+ID4gICAgICdhc3BlZWRfc2JjLmMnLA0KPiA+ICAgICAnYXNwZWVkX3NkbWMuYycsDQo+ID4g
ICAgICdhc3BlZWRfeGRtYS5jJywNCj4gPiArICAnYXNwZWVkX290cG1lbS5jJywNCj4gPiAgICAg
J2FzcGVlZF9wZWNpLmMnLA0KPiA+ICAgICAnYXNwZWVkX3NsaS5jJykpDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBtZW0uaA0KPiA+IGIvaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9vdHBtZW0uaCBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+IDAw
MDAwMDAwMDAuLmE1OThlNzA3YTkNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaW5jbHVk
ZS9ody9taXNjL2FzcGVlZF9vdHBtZW0uaA0KPiANCj4gUGxlYXNlIGFkZCB0byB5b3VyIC5naXQv
Y29uZmlnIGZpbGUgOg0KPiANCj4gW2RpZmZdDQo+IAlvcmRlckZpbGUgPSAvcGF0aC90by9xZW11
L3NjcmlwdHMvZ2l0Lm9yZGVyZmlsZQ0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0K
PiANCj4gDQo+ID4gQEAgLTAsMCArMSwzMyBAQA0KPiA+ICsvKg0KPiA+ICsgKiAgQVNQRUVEIE9U
UCAoT25lLVRpbWUgUHJvZ3JhbW1hYmxlKSBtZW1vcnkNCj4gPiArICoNCj4gPiArICogIENvcHly
aWdodCAoQykgMjAyNSBBc3BlZWQNCj4gPiArICoNCj4gPiArICogIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBBU1BFRURf
T1RQTU1FTV9IDQo+ID4gKyNkZWZpbmUgQVNQRUVEX09UUE1NRU1fSA0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgInN5c3RlbS9tZW1vcnkuaCINCj4gPiArI2luY2x1ZGUgImh3L2Jsb2NrL2Jsb2NrLmgi
DQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vbWVtb3J5LmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0v
YWRkcmVzcy1zcGFjZXMuaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgT1RQTUVNX1NJWkUgMHg0MDAw
DQo+ID4gKyNkZWZpbmUgVFlQRV9BU1BFRURfT1RQTUVNICJhc3BlZWQub3RwbWVtIg0KPiA+ICtP
QkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShBc3BlZWRPVFBNZW1TdGF0ZSwNCj4gQVNQRUVEX09U
UE1FTSkNCj4gPiArDQo+ID4gK3R5cGVkZWYgc3RydWN0IEFzcGVlZE9UUE1lbVN0YXRlIHsNCj4g
PiArICAgIERldmljZVN0YXRlIHBhcmVudF9vYmo7DQo+ID4gKw0KPiA+ICsgICAgdWludDY0X3Qg
c2l6ZTsNCj4gPiArDQo+ID4gKyAgICBBZGRyZXNzU3BhY2UgYXM7DQo+ID4gKw0KPiA+ICsgICAg
TWVtb3J5UmVnaW9uIG1taW87DQo+ID4gKw0KPiA+ICsgICAgdWludDhfdCAqc3RvcmFnZTsNCj4g
PiArfSBBc3BlZWRPVFBNZW1TdGF0ZTsNCj4gPiArDQo+ID4gKyNlbmRpZiAvKiBBU1BFRURfT1RQ
TU1FTV9IICovDQoNCg==

