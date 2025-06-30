Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3328FC83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW83J-0006yD-8M; Mon, 30 Jun 2025 02:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW830-0006v3-7d; Mon, 30 Jun 2025 02:31:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW82w-00077I-Dt; Mon, 30 Jun 2025 02:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOcS2W8kTKzKLJViJyVyPgPetePB08ukCjkmlJ+QUTCijMB+YXRGWQjmnDLyXwWpj4hiSMAKPlxsKEPEVWfJy5CHmZGnWAgJ0XH4vly34PbQGS3vfFlnDLjCDhie7quBBzHQEv3OZWIfOzRiYGiMOUZS0QNDZo7wRB40KKaFW/GIoSsH9e2CPZ/B6wKvdOxdsbF/6vnmzxFqL5WgPZM3nWMiFu5zH1wcSbNzS1qJTsuoM8foo9JNn/JKgmz3Xxh65VnWhn/81bvEOmxnQtvjYwwhTpewci3Arq8EHKKer0da1t0U7Un5ukaOBihufl1zFE2qQDskM9mbfNg0/F3vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkdHCfsTtux1I5+oflogm9Dv6GqGoMV3E3QCF6+s1Nw=;
 b=YH55bcwynFqqMyTVPOzx9NHqWwbJ8bf/4d25yIXhFXSe3TCOVnsT6eDoKJIfh+TmkVU3iK/oBOMliORtZq6L82/ZbtyfcuB9m0onKXGneVQzFiRWyp105yTpXRtCkRDosqpqUDiP9e3wYwiC44miQ/7SHbytf2B+EuM1dyGhWC6/DfWDIGpOT0chkLadZS2nulRUo13NtMCWxqQ9cHuBgxLa8SUob3mEQR6pNpK5nau6slWJfyPsBX0QcfZUnvZpYbwi0wl4aSomXwrTIcp79UQwmR15T2g0JwC5dv3T/Y/cEFk/NroLV1o2OuqLni4H/HpqHktbeCKlbWwaJwPH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkdHCfsTtux1I5+oflogm9Dv6GqGoMV3E3QCF6+s1Nw=;
 b=mfCHzPr91eoRUiuDygqs+O6eLO7Vm5FKKibzqOvnXN3jJvKFr99QwRarALVrWiwKWpYFc5dWi7RCRqEN0vToR0MVRoVRUeWF5ImWqwFoQFc5Bt2C1W5bMMtT0t58RXz+kQFrNRRIQ8svDVAM7KI32NT6dVEW0Pvb89wHKoeT0L5h9oFWHboi0okDqHgatsXQrl814FKTPLbVpyxLZpXR24VkPPh5x6CSS9IpW3hOwCOsO8dc6OJZc6MSCFE69mQj1srp4LWAavIBx2IjsH5NRi0znHFp/G6LfhwY/11NOWU6TbVqdETkF5QPPvRTPUxdUBwzaBOvl8+4SHNVC01zFg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6460.apcprd06.prod.outlook.com (2603:1096:101:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 06:31:09 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 06:31:09 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 1/3] hw/misc/aspeed_otp: Add OTP device model with
 fallback RAM storage
Thread-Topic: [PATCH v3 1/3] hw/misc/aspeed_otp: Add OTP device model with
 fallback RAM storage
Thread-Index: AQHb6X5FnFJEyCK3h0ifr8AB7BPVWrQbPTGAgAAAuPA=
Date: Mon, 30 Jun 2025 06:31:09 +0000
Message-ID: <SI6PR06MB7631A354DB9ED870C56E92BAF746A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250630051721.254207-1-kane_chen@aspeedtech.com>
 <20250630051721.254207-2-kane_chen@aspeedtech.com>
 <29000208-b155-40a3-a3aa-3b679c7a18cf@kaod.org>
In-Reply-To: <29000208-b155-40a3-a3aa-3b679c7a18cf@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6460:EE_
x-ms-office365-filtering-correlation-id: cc1b1a2d-2114-4600-03c1-08ddb79fb373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TnY1TnVjN21pUzhFbEFHUTZ2a0VIbkFvU2NrZ1BOM1JvNnl4Z3dWR09YRlBE?=
 =?utf-8?B?MkZUQ1lZd3prYVE3S0F3bjJMMVhXdGJ2STM0aUh0cG5UcVZzbktSRFFEd1Jl?=
 =?utf-8?B?YWZkU0M1a2EyYmFEaHlCL3Q3TVU3QWFqTWZYaHc2MTVybTh3bTdIM1o5RXQw?=
 =?utf-8?B?dlVqbjZBVXBQaTlKQU50eDQzWTk3cE5BZmlKUkZQZ3lXMEJVcm5ZNnM2Zks1?=
 =?utf-8?B?MkxSam1qQ2dLNU1jMnYvL2NXb3FuWWtiYmJGb2dSS0E5MS8vOEgzYUYxbmlQ?=
 =?utf-8?B?K1QvVWp2N0ZTeTVmR25pU0dGNTNJalBkWE5YbXlpUXNEMlREbkc4TnN6N1Ar?=
 =?utf-8?B?UStSMDlzdFBtVWFyZGZZQi9CVk11Mi9MYzVPbWxocWpOaWoxdUc1aWZERGM2?=
 =?utf-8?B?MWVuRk1ZcW1VSDBySUFYQ3JTNGhjV0s5Ly9KYXNWS3diV2Y3cHJHVlo3R0hM?=
 =?utf-8?B?UDVhT0h6MHhLZ1hLTERSV3lrdlNLOUl1bWtpS2RGMjdXUktxeGFkUktyVUc3?=
 =?utf-8?B?dHpza2VaeVJlbnBPUzlsSzVXZkhlVDY3Wm1LaHVSWU4rMVA1bW4yWnZSWThq?=
 =?utf-8?B?VFp2cmtjalhENEtjWDljMmMwSUdVZThDd21NdDcrVWY3MXFoa2xnaUZrTDdP?=
 =?utf-8?B?WjdoZXE0QjlmdzV6bnlJK0NTS0hDL2tKQW1HcVRqdjhaaHRjSDBYVmhTTzFM?=
 =?utf-8?B?d3VNa2FNdWR6czkvQndUQytRLzB2WGdjanllSVc5MmZwSW5mcEE0SjZtNW1l?=
 =?utf-8?B?MzNDSVJ3dU5FcTJmQ0s4TldIa1graW9yQjBwaG0vYytTdStXdW1YU293YTl5?=
 =?utf-8?B?TVR4WEtBL01TQU5TMWc3Y2NMQ3J5THhBMHB1UEtiRUovMnkzdWc5MDRubWVp?=
 =?utf-8?B?ck00VmR6bXpqdGVvYTVjc0RTcGxYbUUvNVdDUkg3c2tBN01VRllqREc1dzBr?=
 =?utf-8?B?cHA2RzZzNGhKU0w1eUFhamdEM1E2bExBTmNtZHE0MDNZV3U4TTNHa2dmYTlZ?=
 =?utf-8?B?bERDYWlUanlPN1B4eFQ3MDBRYTlsbUZ5NTNXWXJBVk1Oall5bnM0YlkxOVh2?=
 =?utf-8?B?a1JLemtpYmJZODMwWVQ4M1laME14R28xRmVTRDRaQ1FrR1loWnBCOGhWSXl1?=
 =?utf-8?B?UklYWkY0YlhjNGl1MmtzWjFvYXZhYjZHcHpUT2xQWVZOemppVVNHRDQ5bzlH?=
 =?utf-8?B?WW1ac09YYTV3bG8yUWFnU0d5VlkwTXZGUXdSOHVHWHk4ZThweit1UjFhVjVr?=
 =?utf-8?B?Yk85V0VUaWVMMXV4Y2QvdW85QXF6b2VCNDFPNVJLTFZ0S05wUjErWTEwblRn?=
 =?utf-8?B?Q3hXekFweFZRV2xoS21pTTRUaENFVk4wRzJYSTZMRVM5OFBuVUJpOGlReVFw?=
 =?utf-8?B?RG9HaUpiZEQ0L0NLb2R4RmF6MGZFQkorS3YyLzFnVmpQZVd6UXRJUktiRVk1?=
 =?utf-8?B?OUhoTENlZDNaUWRWM0l5RkVmNlBicGJEcjZONEF1UU9RRC94R0tuSUJVMUp5?=
 =?utf-8?B?RlU3azR5S2hRM05wS0FITElqb204cUh5TDZlMXk3d1JhTy9ycXhsVGxDSU1N?=
 =?utf-8?B?SVVvUU94TlJjR0IxaDRjWWVnSFBxWDQ5RGJ5dDVNRFZ4RXdUY1p6dFN2THd3?=
 =?utf-8?B?cHZBa3pJVnA4KzdPZGxxRWErc3pNUGJnZHdjS0MrK05ZeEJvZ0svcmtlWXBi?=
 =?utf-8?B?L0huNUFDV3BBSm9ZTVEwcXVjWE1ZckdoSFVKWGh5UGxBMDFxZktXS0c0Kzdz?=
 =?utf-8?B?aUEyenkvK2F0Z3IxT3d1WlF1WTlHSVhIUGtlZGtlNjhJcExkbDZsNlNpeXRv?=
 =?utf-8?B?TmNmejI0Y0tOblVlN0Rac21VcnFKV0w1NkwybDYzVU5qRHJibS9MYS94Q2Zq?=
 =?utf-8?B?U3lUa3h4WHpLMzVFNFV0MHZEUFZQRnZFL2FyL3ZVUUVpRHBuSHB2Yzc4MXBa?=
 =?utf-8?B?bXA5a052VUpCNDVtWEVCWmc5QVFpU0ZDSUQ5WkIzMEZrby9NVkljb21lR21I?=
 =?utf-8?Q?WeTdQubhPaiXzOcGvyf4W09xRSIaYM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3FIQnR1NnVNa2pJZXREQXM3aTJSN2g0YUY3L0dDM1daK2JVaHdBNXNJRmRM?=
 =?utf-8?B?K0ZVcTYzY2ZmSmpRdkp2U21MWXJ1dUZCRTZ2WHJLaTNodEdmZXNnVVRwKzZY?=
 =?utf-8?B?aTA3Tmh1Y3FCcVRxYUpXNXVrYUpPS2tVS1NJUlFidTlieHg0aXg3SE9Yd3Jn?=
 =?utf-8?B?czhJUm80cmZTZUdRTFM3K1FydDN3MnRpQnU4dWhZZzRSWHYyVkVCdTkwOHZ4?=
 =?utf-8?B?OFVQTjIxQ3IrQXZINnExblh4dm5YUW9EZElhTEZkZGZYQVFnOHY4N3dUTUVN?=
 =?utf-8?B?Y3ppSkswQVoxUWc1S0pnWXVGWWhjb2hTMUVXemYxZUZtcEF3M0p2VDV4TEV0?=
 =?utf-8?B?WStmZStBbkZGVFc2WFFZSTlBc2h4UUp5djFMZlNDK3EyZHFKRzFXaEt3MUhL?=
 =?utf-8?B?V2pKZnRPdXRDdXp3aHZRTUJqcCt2T2ViaTA5TUVwNFZOS1I4U0cvQTF3TjY0?=
 =?utf-8?B?QmM5am5YVWplaVFJbFIyWEZvVnJTQStaanJkbTRhMFJ4dXp6dnloRGxPRjY0?=
 =?utf-8?B?dXpzT2g5aVhmbzBYdklKSldINTNFVVJma3owSnFGdExxbTNLTzlUMTNYTlRS?=
 =?utf-8?B?dWpvVDUrUHFkVTNIOU5adk1ZTFZENmFreTR6M1BQalFtaGJTZFlWR1VSNnE4?=
 =?utf-8?B?ZW9JN3BXdlh1QXhiQXZhQ3lkcTdqVnFNVVI1SkdPMTloRzhqcXJTcERBUWpo?=
 =?utf-8?B?N2xSZFdxc3VJcXQ0UXVubHNjbWE0c3lPeGJtTG9SLzJPNzV1U2hNUWQvejdP?=
 =?utf-8?B?Qm02dHJHTTJ1M3ZEWm82UXlDUzJWZGdpUUZZRmwvVGhHUHQvLzdRM2J0Qk5m?=
 =?utf-8?B?Qks2Q3ZlZXhCN3lBU0FNWGZadWd5cHRLRjdoemhaV0Nkb2cwQXllM3JCaVN1?=
 =?utf-8?B?YUxNZmhBVGVad1Q0dnJoVVZvM1k0TFFHY251QXJaRE13K3hpRXY4YXlBUUdU?=
 =?utf-8?B?Z2RlS29zRW44aFBvSGlJMjRuVSt1cGEwMjB2dTJ0dWFrcWpBTVZDWTUwVnBo?=
 =?utf-8?B?M1E3QWo1emp4Zk9jWFRidngramdoamdhS25vZEQ4bVNXODFmQ0NyNm81b0hS?=
 =?utf-8?B?NVdUNDk3bE1TTGVyRFcvclluQ2IwZXN6aFJsSlBVdkFxcUx0K25uZnVmWUFJ?=
 =?utf-8?B?cG5BMmkweU12dXZMU3BBY3pTTEszaEoxVGllMDZxSnZtcTdHcUQ3NCsvdTlJ?=
 =?utf-8?B?UDFPK21CaDNnOWYzQk9OMy9sdGg2ZEdQOGFCdHZ0Nm9EamZySE9nUk82SEVu?=
 =?utf-8?B?YWRPbGp2YmRKOGlqL2k3N0ZKZU9zSVFwaThmejdIL2tCc3NwYW9DcXB6QlNw?=
 =?utf-8?B?UWxEZ2FyZ0p0NkhKYnRkTk1DRHZjYUdHY1Ava280bk9HaStpUzBjaFZXZW03?=
 =?utf-8?B?eUtiL3Q4UVc3MkJTYUl6c3NDb1J2Q0RZVGpOSVhHRzlhR3VscExTcGFSRnYy?=
 =?utf-8?B?YzJxSnA5L0QrYXBMN05XSWsvUzEzQjgraFBxWVZFYW51SkxGa3J6YjlTZTZq?=
 =?utf-8?B?a0I3Vzh5ZnpaOWZaVFlkK0cxbjZoOXJzQWlQOWlsQXRBSzZ6eVJHKzlZNWhL?=
 =?utf-8?B?cEVpVDNmU1dMeGllSHNEVTJkMlRvMXoxaEEvVXlRaXZwNXZiR1RaYURvdWFM?=
 =?utf-8?B?SXE4cTdwd3U3Q2UrRU9QVWdYZktTR3NKQVl4OVZKUFE3ZjZ1OG8rVTBScnAv?=
 =?utf-8?B?Wm9aak5mb2ZnU0NPUDNvNlkrVFYvTzUwdzhwWnJXQ1Rua3BaL1F0TlpaWElB?=
 =?utf-8?B?NytJd3Eyb2dZYWpaSm9LeWpGYlN4OUoyY1NaVVRDdkdoTnl5SVQwL2ZGaHVX?=
 =?utf-8?B?T2hpd0d6YU5qVkxJSHBWb1hoZks1NWg1WFowZmRFTjhMWCtsbnlyMVpSeXk3?=
 =?utf-8?B?QXBlVVRZcm9sY29SMkVRWVp2U0tySU9ORmtTNzNBdldQaXZGR2x1anYxa2lw?=
 =?utf-8?B?NStKVkQ0TkwzL1dBS05vTERsdVJpdmgzcGlvQ1FRQUhEQzVJaGdpRmFQQWhP?=
 =?utf-8?B?OXhYRlEydmg4aXV3cytsenV2SFEzV2N1dlEzRUdiMUVaYVZpZ2N6Z2g4YmFJ?=
 =?utf-8?B?NDRnRC8xeVR4eDBLa0NpV0VUSCs0cy9FaUJySlZJTXQ1Q0wrUWxtYkJ1QmxE?=
 =?utf-8?Q?zDhRPZgF7c28Uq2BVv0SR7d/N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1b1a2d-2114-4600-03c1-08ddb79fb373
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 06:31:09.4795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnbytnBx0JW9vuIOJxVIhHs72aezKx8rgXzc3NrphnW/BipcJlP3NSuQyf/L3XIE048jaNUALjk6THb995wpjKQMseJMXBeIrs4z3S2TL9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6460
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KR290IGl0LCBJJ2xsIHJlbmFtZSB0aGUgdHlwZSB0byAiYXNwZWVkLW90
cCIgYXMgc3VnZ2VzdGVkIHRvIHN1cHBvcnQgdGhlIGdsb2JhbCBwcm9wZXJ0eSBzeW50YXguDQoN
ClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24hDQoNCkJlc3QgcmVnYXJkcywNCkthbmUNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMzAsIDIwMjUgMjoyOCBQTQ0KPiBU
bzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVl
ZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVj
b25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9wZW4g
bGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0
Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8
dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8zXSBo
dy9taXNjL2FzcGVlZF9vdHA6IEFkZCBPVFAgZGV2aWNlIG1vZGVsIHdpdGgNCj4gZmFsbGJhY2sg
UkFNIHN0b3JhZ2UNCj4gDQo+IE9uIDYvMzAvMjUgMDc6MTcsIEthbmUgQ2hlbiB3cm90ZToNCj4g
PiBGcm9tOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIFFFTVUgbW9kZWwgb2YgdGhlIEFTUEVFRCBPbmUtVGlt
ZQ0KPiBQcm9ncmFtbWFibGUNCj4gPiAoT1RQKSBtZW1vcnksIHVzZWQgZm9yIHNlY3VyZSBmdXNl
IHN0b3JhZ2UuIFRoZSBtb2RlbCBzaW11bGF0ZXMgYQ0KPiA+IHdvcmQtYWRkcmVzc2FibGUgT1RQ
IHJlZ2lvbiB3aXRoIGEgbWVtb3J5LWxpa2UgaW50ZXJmYWNlIHZpYSBhDQo+ID4gZGVkaWNhdGVk
IEFkZHJlc3NTcGFjZS4NCj4gPg0KPiA+IElmIG5vIGV4dGVybmFsIGJsb2NrIGJhY2tlbmQgaXMg
cHJvdmlkZWQgdmlhIHRoZSAiZHJpdmUiIHByb3BlcnR5LCB0aGUNCj4gPiBtb2RlbCBhdXRvbWF0
aWNhbGx5IGFsbG9jYXRlcyBhbiBpbnRlcm5hbCBSQU0tYmFja2VkIHN0b3JhZ2UgYnVmZmVyIHRv
DQo+ID4gaG9sZCBPVFAgZGF0YSwgZW5hYmxpbmcgc2ltcGxpZmllZCB1c2FnZSB3aXRob3V0IENM
SSBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxr
YW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L252cmFt
L2FzcGVlZF9vdHAuaCB8ICAzMyArKysrKysrKysrDQo+ID4gICBody9udnJhbS9hc3BlZWRfb3Rw
LmMgICAgICAgICB8IDExMw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gICBody9udnJhbS9tZXNvbi5idWlsZCAgICAgICAgICB8ICAgNCArKw0KPiA+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAxNTAgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvaHcvbnZyYW0vYXNwZWVkX290cC5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
bnZyYW0vYXNwZWVkX290cC5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9udnJh
bS9hc3BlZWRfb3RwLmgNCj4gPiBiL2luY2x1ZGUvaHcvbnZyYW0vYXNwZWVkX290cC5oIG5ldyBm
aWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4gMDAwMDAwMDAwMC4uMjJiMjE5NWEwMA0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2h3L252cmFtL2FzcGVlZF9vdHAuaA0KPiA+
IEBAIC0wLDAgKzEsMzMgQEANCj4gPiArLyoNCj4gPiArICogIEFTUEVFRCBPVFAgKE9uZS1UaW1l
IFByb2dyYW1tYWJsZSkgbWVtb3J5DQo+ID4gKyAqDQo+ID4gKyAqICBDb3B5cmlnaHQgKEMpIDIw
MjUgQXNwZWVkDQo+ID4gKyAqDQo+ID4gKyAqICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlciAgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgQVNQRUVEX09UUF9IDQo+ID4g
KyNkZWZpbmUgQVNQRUVEX09UUF9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL21lbW9y
eS5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvYmxvY2svYmxvY2suaCINCj4gPiArI2luY2x1ZGUgInN5
c3RlbS9hZGRyZXNzLXNwYWNlcy5oIg0KPiA+ICsNCj4gPiArI2RlZmluZSBUWVBFX0FTUEVFRF9P
VFAgImFzcGVlZC5vdHAiDQo+IA0KPiBQbGVhc2UgY2hhbmdlIHRvICJhc3BlZWQtb3RwIiBzbyB0
aGF0IHdlIGNhbiB1c2UgOg0KPiANCj4gCS1nbG9iYWwgYXNwZWVkLW90cC5kcml2ZT0iZm9vIg0K
PiANCj4gdG8gZGVmaW5lIGEgYmFja2VuZC4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
PiANCj4gDQo+IA0KPiA+ICtPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShBc3BlZWRPVFBTdGF0
ZSwgQVNQRUVEX09UUCkNCj4gPiArDQo+ID4gK3R5cGVkZWYgc3RydWN0IEFzcGVlZE9UUFN0YXRl
IHsNCj4gPiArICAgIERldmljZVN0YXRlIHBhcmVudF9vYmo7DQo+ID4gKw0KPiA+ICsgICAgQmxv
Y2tCYWNrZW5kICpibGs7DQo+ID4gKw0KPiA+ICsgICAgdWludDY0X3Qgc2l6ZTsNCj4gPiArDQo+
ID4gKyAgICBBZGRyZXNzU3BhY2UgYXM7DQo+ID4gKw0KPiA+ICsgICAgTWVtb3J5UmVnaW9uIG1t
aW87DQo+ID4gKw0KPiA+ICsgICAgdWludDhfdCAqc3RvcmFnZTsNCj4gPiArfSBBc3BlZWRPVFBT
dGF0ZTsNCj4gPiArDQo+ID4gKyNlbmRpZiAvKiBBU1BFRURfT1RQX0ggKi8NCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvbnZyYW0vYXNwZWVkX290cC5jIGIvaHcvbnZyYW0vYXNwZWVkX290cC5jIG5ldyBm
aWxlDQo+ID4gbW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMC4uZjAxOGM1ODcxMw0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9ody9udnJhbS9hc3BlZWRfb3RwLmMNCj4gPiBAQCAtMCww
ICsxLDExMyBAQA0KPiA+ICsvKg0KPiA+ICsgKiAgQVNQRUVEIE9UUCAoT25lLVRpbWUgUHJvZ3Jh
bW1hYmxlKSBtZW1vcnkNCj4gPiArICoNCj4gPiArICogIENvcHlyaWdodCAoQykgMjAyNSBBc3Bl
ZWQNCj4gPiArICoNCj4gPiArICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyICAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gPiArI2lu
Y2x1ZGUgInFlbXUvbG9nLmgiDQo+ID4gKyNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4gKyNp
bmNsdWRlICJzeXN0ZW0vYmxvY2stYmFja2VuZC1nbG9iYWwtc3RhdGUuaCINCj4gPiArI2luY2x1
ZGUgInN5c3RlbS9ibG9jay1iYWNrZW5kLWlvLmgiDQo+ID4gKyNpbmNsdWRlICJody9xZGV2LXBy
b3BlcnRpZXMuaCINCj4gPiArI2luY2x1ZGUgImh3L252cmFtL2FzcGVlZF9vdHAuaCINCj4gPiAr
DQo+ID4gK3N0YXRpYyB1aW50NjRfdCBhc3BlZWRfb3RwX3JlYWQodm9pZCAqb3BhcXVlLCBod2Fk
ZHIgb2Zmc2V0LCB1bnNpZ25lZA0KPiA+ICtzaXplKSB7DQo+ID4gKyAgICBBc3BlZWRPVFBTdGF0
ZSAqcyA9IG9wYXF1ZTsNCj4gPiArICAgIHVpbnQ2NF90IHZhbCA9IDA7DQo+ID4gKw0KPiA+ICsg
ICAgbWVtY3B5KCZ2YWwsIHMtPnN0b3JhZ2UgKyBvZmZzZXQsIHNpemUpOw0KPiA+ICsNCj4gPiAr
ICAgIHJldHVybiB2YWw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9v
dHBfd3JpdGUodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHZhbCwgdW5zaWduZWQgc2l6ZSkgew0KPiA+ICsg
ICAgQXNwZWVkT1RQU3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gKw0KPiA+ICsgICAgbWVtY3B5KHMt
PnN0b3JhZ2UgKyBvZmZzZXQsICZ2YWwsIHNpemUpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgYm9v
bCBhc3BlZWRfb3RwX2luaXRfc3RvcmFnZShBc3BlZWRPVFBTdGF0ZSAqcywgRXJyb3IgKiplcnJw
KQ0KPiA+ICt7DQo+ID4gKyAgICB1aW50MzJfdCAqcDsNCj4gPiArICAgIGludCBpLCBudW07DQo+
ID4gKyAgICB1aW50NjRfdCBwZXJtOw0KPiA+ICsNCj4gPiArICAgIGlmIChzLT5ibGspIHsNCj4g
PiArICAgICAgICBwZXJtID0gQkxLX1BFUk1fQ09OU0lTVEVOVF9SRUFEIHwNCj4gPiArICAgICAg
ICAgICAgICAgKGJsa19zdXBwb3J0c193cml0ZV9wZXJtKHMtPmJsaykgPyBCTEtfUEVSTV9XUklU
RSA6DQo+IDApOw0KPiA+ICsgICAgICAgIGlmIChibGtfc2V0X3Blcm0ocy0+YmxrLCBwZXJtLCBC
TEtfUEVSTV9BTEwsIGVycnApIDwgMCkgew0KPiA+ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGlmIChibGtfcHJlYWQocy0+YmxrLCAwLCBz
LT5zaXplLCBzLT5zdG9yYWdlLCAwKSA8IDApIHsNCj4gPiArICAgICAgICAgICAgZXJyb3Jfc2V0
ZyhlcnJwLCAiRmFpbGVkIHRvIHJlYWQgdGhlIGluaXRpYWwgZmxhc2ggY29udGVudCIpOw0KPiA+
ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfSBl
bHNlIHsNCj4gPiArICAgICAgICBudW0gPSBzLT5zaXplIC8gc2l6ZW9mKHVpbnQzMl90KTsNCj4g
PiArICAgICAgICBwID0gKHVpbnQzMl90ICopcy0+c3RvcmFnZTsNCj4gPiArICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgbnVtOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgcFtpXSA9IChpICUgMiA9
PSAwKSA/IDB4MDAwMDAwMDAgOiAweEZGRkZGRkZGOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAg
IH0NCj4gPiArICAgIHJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29u
c3QgTWVtb3J5UmVnaW9uT3BzIGFzcGVlZF9vdHBfb3BzID0gew0KPiA+ICsgICAgLnJlYWQgPSBh
c3BlZWRfb3RwX3JlYWQsDQo+ID4gKyAgICAud3JpdGUgPSBhc3BlZWRfb3RwX3dyaXRlLA0KPiA+
ICsgICAgLmVuZGlhbm5lc3MgPSBERVZJQ0VfTElUVExFX0VORElBTiwNCj4gPiArICAgIC52YWxp
ZC5taW5fYWNjZXNzX3NpemUgPSAxLA0KPiA+ICsgICAgLnZhbGlkLm1heF9hY2Nlc3Nfc2l6ZSA9
IDQsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfb3RwX3JlYWxpemUo
RGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKSB7DQo+ID4gKyAgICBBc3BlZWRPVFBTdGF0
ZSAqcyA9IEFTUEVFRF9PVFAoZGV2KTsNCj4gPiArDQo+ID4gKyAgICBpZiAocy0+c2l6ZSA9PSAw
KSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiYXNwZWVkLm90cDogJ3NpemUnIHBy
b3BlcnR5IG11c3QgYmUgc2V0Iik7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0K
PiA+ICsNCj4gPiArICAgIHMtPnN0b3JhZ2UgPSBibGtfYmxvY2thbGlnbihzLT5ibGssIHMtPnNp
emUpOw0KPiA+ICsNCj4gPiArICAgIGlmICghYXNwZWVkX290cF9pbml0X3N0b3JhZ2UocywgZXJy
cCkpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAg
bWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5tbWlvLCBPQkpFQ1QoZGV2KSwgJmFzcGVlZF9vdHBf
b3BzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHMsICJhc3BlZWQub3RwIiwgcy0+
c2l6ZSk7DQo+ID4gKyAgICBhZGRyZXNzX3NwYWNlX2luaXQoJnMtPmFzLCAmcy0+bW1pbywgTlVM
TCk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBQcm9wZXJ0eSBhc3BlZWRfb3RwX3Byb3Bl
cnRpZXNbXSA9IHsNCj4gPiArICAgIERFRklORV9QUk9QX1VJTlQ2NCgic2l6ZSIsIEFzcGVlZE9U
UFN0YXRlLCBzaXplLCAwKSwNCj4gPiArICAgIERFRklORV9QUk9QX0RSSVZFKCJkcml2ZSIsIEFz
cGVlZE9UUFN0YXRlLCBibGspLCB9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX290
cF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZA0KPiA+ICsqZGF0YSkg
ew0KPiA+ICsgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiAr
ICAgIGRjLT5yZWFsaXplID0gYXNwZWVkX290cF9yZWFsaXplOw0KPiA+ICsgICAgZGV2aWNlX2Ns
YXNzX3NldF9wcm9wcyhkYywgYXNwZWVkX290cF9wcm9wZXJ0aWVzKTsgfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9vdHBfaW5mbyA9IHsNCj4gPiArICAgIC5uYW1l
ICAgICAgICAgID0gVFlQRV9BU1BFRURfT1RQLA0KPiA+ICsgICAgLnBhcmVudCAgICAgICAgPSBU
WVBFX0RFVklDRSwNCj4gPiArICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKEFzcGVlZE9UUFN0
YXRlKSwNCj4gPiArICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX290cF9jbGFzc19pbml0LA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX290cF9yZWdpc3Rlcl90eXBl
cyh2b2lkKSB7DQo+ID4gKyAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmYXNwZWVkX290cF9pbmZv
KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdHlwZV9pbml0KGFzcGVlZF9vdHBfcmVnaXN0ZXJfdHlw
ZXMpDQo+ID4gZGlmZiAtLWdpdCBhL2h3L252cmFtL21lc29uLmJ1aWxkIGIvaHcvbnZyYW0vbWVz
b24uYnVpbGQgaW5kZXgNCj4gPiAxMGYzNjM5ZGI2Li5iNjZmMjM2MDViIDEwMDY0NA0KPiA+IC0t
LSBhL2h3L252cmFtL21lc29uLmJ1aWxkDQo+ID4gKysrIGIvaHcvbnZyYW0vbWVzb24uYnVpbGQN
Cj4gPiBAQCAtMTksMyArMTksNyBAQCBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfWExOWF9C
QlJBTScsDQo+IGlmX3RydWU6DQo+ID4gZmlsZXMoJ3hsbngtYmJyYW0uYycpKQ0KPiA+DQo+ID4g
ICBzcGVjaWZpY19zcy5hZGQod2hlbjogJ0NPTkZJR19QU0VSSUVTJywgaWZfdHJ1ZTogZmlsZXMo
J3NwYXByX252cmFtLmMnKSkNCj4gPiAgIHNwZWNpZmljX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FD
UEknLCBpZl90cnVlOg0KPiA+IGZpbGVzKCdmd19jZmctYWNwaS5jJykpDQo+ID4gKw0KPiA+ICtz
eXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVNQRUVEX1NPQycsIGlmX3RydWU6IGZpbGVzKA0K
PiA+ICsgICdhc3BlZWRfb3RwLmMnLA0KPiA+ICsgICkpDQo+ID4gXCBObyBuZXdsaW5lIGF0IGVu
ZCBvZiBmaWxlDQoNCg==

