Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8831C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUiLG-00037T-4d; Thu, 26 Jun 2025 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUiLD-000364-SM; Thu, 26 Jun 2025 04:52:19 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUiL9-0006lC-Vl; Thu, 26 Jun 2025 04:52:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egkcNIXv28WRjVPDGrUWg9osw7YQ+GP99CKDC+9Ir3HREjg97GBUNwO71khP1K+W7Bt5YmPnuRC2qI1bL0IqOtiHf/wkEbJCoTJmYTgw/C3ZOyRqbrAh6SKZ13tIQH6HNMXV3//0r4iFk1zJUv1THmP4spIr93VdutzX0WXDNYDfFlIf3qp0/OPqV/KS15uz+eGAox8vVUH/08lFDxaIALa2qmpkhbQFzvTakKuffTSjaVAP7yFH9vJNBsNOLwozEm0izOoI6LGp/zwLNDLZOhPY6nm0VUHrJEqGrW8OQ3rXVemSzxzPIF1PD4W17ca5npDtoAFvUD77whCMvb7m+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdIkFrLDMpVPeMEA4E/ZJA/gsBT0xnhWr6bh46lMPcU=;
 b=CBC84Nc94lqcWzRbf1JCzLMu752gmfNDs5Zzc5kQgjrtNy5qF8C7/8yOlhk4QQo/ZODiwXEQbNUyceRYubrwrXutyhNLrybOqLsymUKjiA/zOfmjm1sMuD16+AU9tS08RJ3FDV+ls8HA78I4oqpC00huey3RpNylwNp7U33k3ERK/Z86vap/6QGHezzyg0LPJx0/lxGLiZYgSb3cPeGYGPyVsQ85hyzPWA9/Yn3SJxYVgoca4bM6CKIAzT4YrRoJeaMBq5p48WThyroSk0ekQH7SYbIeefdB3VqEErKr1dsu0PtDi6HU439yZb90lX3iMeIJYaG9R5R5QEeGpzykWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdIkFrLDMpVPeMEA4E/ZJA/gsBT0xnhWr6bh46lMPcU=;
 b=fWt4Dra2dccTYfJc2ggWnjPh86Rb6lAFfuXWZfSNU/ffTeFW8QsxYOTvZqFFwzDdTz3W/rgli12fKjdXeyhePpsgEYb8mkzbNItrB6xyQv5l47G0PG5RvyBovOmzgS5a/NTsZ4h3e3VIjDVKcNz4Yp7Obo1psQ59qOlLldlHzC5MXupSTQ+2g9UqZv4xKeF2mlXXiwg5HXo2pwLfICx4QRwjMY052Tud6olZehEkcsv7+IXOT+WcOrXc2EEZpzDfGIugQ6zUiwf+p7EnWCGy75oLiZptdsK/jkJxA+S9T/bdS7TGPsXizUxcbwp3FYFsUBJ0skk5g8gyNL3TMWY1+Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6207.apcprd06.prod.outlook.com (2603:1096:101:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 08:52:04 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:52:02 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Topic: [PATCH v1 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Index: AQHb5m/x74XtCm4mqEq0uljiECt7krQVGhqAgAAATOA=
Date: Thu, 26 Jun 2025 08:52:02 +0000
Message-ID: <SI6PR06MB76312E4EB6754F236A74432EF77AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250626075711.1589039-1-kane_chen@aspeedtech.com>
 <20250626075711.1589039-2-kane_chen@aspeedtech.com>
 <37b1845f-85f6-4c5a-aba1-45433844ad7f@kaod.org>
In-Reply-To: <37b1845f-85f6-4c5a-aba1-45433844ad7f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6207:EE_
x-ms-office365-filtering-correlation-id: d54112c5-73d8-4286-e682-08ddb48eb803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WkFtazJoazNQcGR5dTdPTzc1bnhKTlZxVTdDY3R0NWtwaElYOU9SNStPUits?=
 =?utf-8?B?RkVtRW1keTNQQ1NoQWwrYkY5SWo5eS90TVJqUXpvbW5Vb2UzdEhHRitsa0xN?=
 =?utf-8?B?MnBOVENaRXJHc2Q1emQ3YUJYRXNSL2U3VTZEWkVFcHAveGhpUDR3Rk5TWDlo?=
 =?utf-8?B?aDk3QVNQMjhmcUJOZmhlQXlRRUw5Y2Nzc2J6TVIxcktTaFJsK2xyMEc4Vit2?=
 =?utf-8?B?V0lQeVo3dGxqa3pzTWcybW1TS015N1hKcHpIdXpkbmFKOXJIMmFlN0RoY1Zt?=
 =?utf-8?B?eGNKcUZZdTVrc2paZllQcGlhUWMvbXdZTWlUWkFTNFNkQnlWeWJrK2xzRmQ4?=
 =?utf-8?B?bmh3N05pU053WUU1QlZQTkdMN2lSVGFHaStJL2tuK2RWWXpYcnY1Z3VBWTBZ?=
 =?utf-8?B?aldNUUx3MWhhbjdsZms1MTJNMTFEYTFlZThqcEVMbjRlR0xUdEp5Tzhlblht?=
 =?utf-8?B?ZmpyOVRsNHhZMXgrYllmVWRTc1g2WFg2bTAyVkVOUS9XTXp1SGg0aldPOURI?=
 =?utf-8?B?aThCSFNhVWE0ZFNvOWxBN0V6VzdaOWt0LzlUUC9DK1pqTjFwbzlMUCtZbEgr?=
 =?utf-8?B?NGFZZ2FvcDAyMFRQZHhGdWx0ZnBBTkVOTFRoaEJxaGpwOEhYTVNUWFc0MVR3?=
 =?utf-8?B?Q1Y2bkZFYUIyejZXQi9SdURMN3Y4Z1hYNVhKNnlKaG5VNGtHUDRSakdLbVNz?=
 =?utf-8?B?bEFmREwzWk1rdklzeno2YUplMHJYMit6YXBYMUFvUVo2NTduSm9JSm9Ub1k3?=
 =?utf-8?B?Um9hTTYxODFoYzZYeTZMZDdrUVBwWUF4QmJwY3FZTVFHMWVxUVY2UjdTQVY1?=
 =?utf-8?B?MzRoYi8wdDBjTldSSWtFcGZYdDJMb3Rpc3g2VkRQT05jdVRsZklOOEE1eG1O?=
 =?utf-8?B?OG8va0tyVVE4YnYrV2hrSkRGWGNhWEZ0Y3lVbDlyYitkYU1oa3RtdU1nMGpU?=
 =?utf-8?B?d2VSYzRhMzhmNVVKaUErS0ZQYzZBK1pDUExSL0FEVzRxbUNlQklvUjNmalJK?=
 =?utf-8?B?UGIrb3RvTDBHQVB2RWYvVXlxK3BKMmRlQTJpb1NHcGNTeXVEekRHSkdQWTR5?=
 =?utf-8?B?eWN1QWFuNEtFalMxMzJycW1yRlZXTDl2U1F4R0dRUjNjNjVycmEyVk1TWVpE?=
 =?utf-8?B?K1V4MUpsYktQSE1IQ2tPQnltR2FJQmRvRzZTR1pkN1RLUXZ3TUxETGFkU3cy?=
 =?utf-8?B?UnJEd29ETmhDNy9VMzJnSFJjdCtYTG1KYnlUN1pTNHdRQWxid2VwdzMyM3Bs?=
 =?utf-8?B?eUk4NGtJWjl0OW8vOFN3N2pxa0kvWGJPNVJVQW8yUS9NU01OYklETlhqYXVW?=
 =?utf-8?B?UHhmbVk5a08yTWZLc00rMWREcVNjNEZYRkxVWUpDL3lJL0FqeUZxL0xJSXlq?=
 =?utf-8?B?Uk54YkJ4YVB5Mi9xZzVjdGNtaWZiTGFVV1VLejl2dmt2enNuUGRHa1JoSXY4?=
 =?utf-8?B?R0RTYTNPYkIrSXc5MWdlSncyN1ZqWkNpdzF2TzZQZ3pvbDFQYld3VTl4eWlX?=
 =?utf-8?B?OTR5ZG9tcjBoUHVYVnpOenl3TWdXVFVRQ3ExcnlZM2p2VVgrWDRqYW9TdWEv?=
 =?utf-8?B?Q0Q4a0ZEREhpWitpU0Y0ZkFVS2hkTEptdlpsd2tzcWxvRnk5NU9Sb2M4TC9j?=
 =?utf-8?B?NFdrVE43LzYvMVV4RWpBanFvaTNBY0orY2R0MHFaVThhOFEvc0tCV0dvOWZ2?=
 =?utf-8?B?TGFEdHgxVlFRdDJEcTVkTE1DaEFoUWtyNmZnbTRWMHpScVkvSkloaUxUNHNO?=
 =?utf-8?B?SkExWS81ZTd2RUlqLytEVkhhd1JqWmJXYmhUekJPVGRmK3U4NEZpQjIzUTJV?=
 =?utf-8?B?N25ObE91dUNvdndmR1hMUlZOR040Q2c4eFExZVF3bEd0cDF1QlkzVkR6c212?=
 =?utf-8?B?VFBOMTBneVFEcHdydjRMZmcvdk0wMGxsM1lncjYxVXpPQnhwRzZtWDdteExB?=
 =?utf-8?B?K2g4Y3ZFZ0c5dWFsOGFnQk94ckEvUWk2U3AvYUkyaVl1MjdQMWRIdnU1VlNI?=
 =?utf-8?B?azdiUnBqbzNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXd3NTQ2ekhlNDZPNHQ4Y05ZTkwvb2RGSHVnYVpSU1BtRStDS2V6YlBNekVE?=
 =?utf-8?B?ZkQzNG02VTVHcG5mUlZQZllZUUVmK3BybS9kMEFUY3h5U3V0OUVodk1FSSs0?=
 =?utf-8?B?VkY3K285eXJCb3g2YkpRbEdGVnRzcGlMZGpCQ2djQ0hlRm55dVdueTA1MnVn?=
 =?utf-8?B?R2FZRWoyamtFVW9VbzJVQk40NWRvUFV6VDFpUVdmWG8wWWdxZTJjNmNwRlNh?=
 =?utf-8?B?RUFHZENwK1JiS1VnMGJkaWsrYU55Vys4aGtrZmZkRDNTTUFJZW5YR2hBQnU5?=
 =?utf-8?B?SzdCcjhLRGNyNEpkdTV4SHl6M0E0WmZONG5Oc0ZUUDJ3V2hrTTlPeTR1S0NT?=
 =?utf-8?B?aTlUNEVoZURoRHJrZVlFWkZ0QnRkOHlyYkNoa3cxUytiUVFmbzVMc0xqTXJj?=
 =?utf-8?B?eU9ob0hSODdjRjF6dFRMRk0xbXpvem9sMW1tVEs1WFBVYWloalBBNC9CS1h1?=
 =?utf-8?B?UXMyZmVZWVQzT2J5TDVzOW5weEcwZFJ6QkcrYkowTTBnb1A4NGcwNHdUUjFP?=
 =?utf-8?B?ZGZkVXZFdVhVRjZrbU1wemlYMmhQWFZIMlVITXNPNjZKbmN1SUhrY1RLbEtX?=
 =?utf-8?B?R0x0R3Uxc1JrUXFBZ1d4SFN5d1Q1aWYwOEhHOXc5eXRpK2RvVWZ4eGladSts?=
 =?utf-8?B?KzdpL3M4UjlHUnVTcG1Ud3ZoZXluK2xMM3grUEZFKzlHOSsycHRCdkdITkd1?=
 =?utf-8?B?ckVFeE1hQUZqV0U0T0FQajJ5RmFKRkN1RWNYUmtXb1dKbGR6UFlib1lmWXRq?=
 =?utf-8?B?K3AzMXV5ZUd2TGxwMmZyUFEzSW90Zy9jam9mY3JMbGc2UW9tNlQ5YXhUUzNE?=
 =?utf-8?B?LzVjRGVaTThXaW4xNGNLN0tsbzZKUEMyWGJ4WEZwdStpL1dzS29lbEMwVzhG?=
 =?utf-8?B?VXZ4WHJVcHZhOEFNREFMOU9vK0srbGRhN0l6RDV6cWVSWHM2aDBaRDBLQUVp?=
 =?utf-8?B?T012azNTUG40R2NlclRaSjBzdDkyNXhUeGlFOUVsTlZLakpqRFlWM2d3aFJW?=
 =?utf-8?B?SWdsNXhLYU94UUthZnNsWm9WR3h6RFhhVktUZE0rRWtMdXpHajFIbVFzaUlt?=
 =?utf-8?B?UWZTOHpZWXcvL1V0QkhoT29iMTM0NVQzS1drNWZjVkY0RUVvQ0lMUldUelRY?=
 =?utf-8?B?VHA5WUZtb0tFcHdDbmNnVjdhZCt0SFY5Mm9jVEtlZTljQjVlVVUyQXU0cWFI?=
 =?utf-8?B?NTNoWTRpL1AxTXhDaUR5cFVDc2lmOEVYUkZpa1p0T3BBc1FCeStPTlBqM3ox?=
 =?utf-8?B?UmV1UzJVNVJEaUJleWVyZWNDWGNNUTVFaDFJYS9NQm1uY3ZkeXRCUnp1U2xK?=
 =?utf-8?B?dnc5Y05RTUNNQ1VaSmF0UFVFbnloWXhVa0cwMSthVmY3TlBGRG5OejhEUEVS?=
 =?utf-8?B?VzlMYnZQWkRwRWtzT21qaGdmakludSs3RVdvODNZbHZ3K1NNTllrZXJkUHNG?=
 =?utf-8?B?cHBYSkxIUkZHekpwSk5PQ3BhSEVhNVhwSzIyRVltZ1pKM1VrVVRTMVJ6dEZ2?=
 =?utf-8?B?WXhkaU02cjd1b1JQd2Eva0xJV2NtR0xLdnVtaWtrekU0K2owdjErZWtlYkVa?=
 =?utf-8?B?NjR2RWZEK2FJblhuSWQreTlMd0dZSkpZYTVmaDhwRjhta0NvTWgrTzdUMnFt?=
 =?utf-8?B?bGlseHYwWFV1VitsOEZvc2hkMWZUdStuMDVWY1l4V25ZK214ODY2VHZmWUVT?=
 =?utf-8?B?aVhtU2F2M1JQTHNjclBXREpJTjM1OUVYWm1yV1B3VGFZakxrMVUvb2Z2cTU3?=
 =?utf-8?B?dGtUaWllRnliV0hLWlFwdEs0S1JLMUpVQ3pObWpuaDVDVjZZaHNQTGV2Tml6?=
 =?utf-8?B?aldlVDRUckdVRFdXbmZERnA1S0wxQ0xVcUIxNGhxYjJZNlRyK3NqblhROFZO?=
 =?utf-8?B?UFB2WXFqU3ppZ25tY3lOeDd3dGRuVy9NeHVrYWhzeC9rM2EzK3l4cVErbi9J?=
 =?utf-8?B?YVZKMHpveHVrSk9IUmxjWVc0SDBJOGJYcDVrdEswQkdHbTlQSk5VWkw3cHhx?=
 =?utf-8?B?dDNlTVBVRDJhYTAzRy9jKzVhQ1RsV2xyeHNWZzc0ZkVxQkYwekZEc0lPRUQr?=
 =?utf-8?B?bE1UZW0vZ3N5VjExR21UOEp0U2JoSXdhY2RWWkNCKzd4dkh2NkRKREZyVkVC?=
 =?utf-8?Q?823vUfFSfUPDCS+lGNlv0GikE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54112c5-73d8-4286-e682-08ddb48eb803
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:52:02.1999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHsR3CLvwd3QRTYaJP2rLyA9fPe1H5sHoIHYVLAlajEyXwqGbEvoVWnIDh5vN0ks+sknpmNkjgp8Y5h+rX2jt+Y1Atmwz6Rc63noKxfj83A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6207
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLiBJIHdpbGwgbW92ZSB0aGUg
T1RQIGltcGxlbWVudGF0aW9uIHRvIGBody9udnJhbS9gIGFzIHN1Z2dlc3RlZCwgYW5kIGFkanVz
dCB0aGUgcmVsYXRlZCBjb2RlIGFjY29yZGluZ2x5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjYsIDIwMjUgNDoyMyBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFz
cGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9w
ZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwg
cGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8z
XSBody9taXNjL2FzcGVlZF9vdHA6IEFkZCBBU1BFRUQgT1RQIG1lbW9yeQ0KPiBkZXZpY2UgbW9k
ZWwNCj4gDQo+IE9uIDYvMjYvMjUgMDk6NTcsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBL
YW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEludHJvZHVj
ZSBhIFFFTVUgZGV2aWNlIG1vZGVsIGZvciBBU1BFRUQncyBPbmUtVGltZSBQcm9ncmFtbWFibGUN
Cj4gKE9UUCkNCj4gPiBtZW1vcnkuDQo+ID4NCj4gPiBUaGlzIG1vZGVsIHNpbXVsYXRlcyBhIHdv
cmQtYWRkcmVzc2FibGUgT1RQIHJlZ2lvbiB1c2VkIGZvciBzZWN1cmUNCj4gPiBmdXNlIHN0b3Jh
Z2UuIFRoZSBPVFAgbWVtb3J5IGNhbiBvcGVyYXRlIHdpdGggYW4gaW50ZXJuYWwgbWVtb3J5DQo+
ID4gYnVmZmVyLg0KPiA+DQo+ID4gVGhlIE9UUCBtb2RlbCBwcm92aWRlcyBhIG1lbW9yeS1saWtl
IGludGVyZmFjZSB0aHJvdWdoIGEgZGVkaWNhdGVkDQo+ID4gQWRkcmVzc1NwYWNlLCBhbGxvd2lu
ZyBvdGhlciBkZXZpY2UgbW9kZWxzIChlLmcuLCBTQkMpIHRvIGlzc3VlDQo+ID4gdHJhbnNhY3Rp
b25zIGFzIGlmIGFjY2Vzc2luZyBhIG1lbW9yeS1tYXBwZWQgcmVnaW9uLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4g
LS0tDQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX290cG1lbS5oIHwgMzMgKysrKysrKysr
KysrDQo+ID4gICBody9taXNjL2FzcGVlZF9vdHBtZW0uYyAgICAgICAgIHwgOTENCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IA0KPiBQZXRlciBzdWdnZXN0ZWQgdG8gbW92
ZSB0aGVzZSBmaWxlcyB1bmRlciBody9udnJhbS8gd2l0aCB0aGUgb3RoZXIgT1RQDQo+IG1vZGVs
cy4NCj4gDQo+IFBsZWFzZSBjb25zaWRlciByZW5hbWluZyB0byA6DQo+IA0KPiAgICAgaW5jbHVk
ZS9ody9udnJhbS9hc3BlZWRfb3RwLmgNCj4gICAgIGh3L252cmFtL2FzcGVlZF9vdHAuYw0KPiAN
Cj4gDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBtZW0uaA0KPiA+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNwZWVkX290cG1lbS5jDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBtZW0uaA0KPiA+IGIvaW5jbHVkZS9ody9t
aXNjL2FzcGVlZF9vdHBtZW0uaCBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+IDAwMDAw
MDAwMDAuLjY0Y2Q0ZDFhN2MNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9vdHBtZW0uaA0KPiA+IEBAIC0wLDAgKzEsMzMgQEANCj4gPiArLyoNCj4g
PiArICogIEFTUEVFRCBPVFAgKE9uZS1UaW1lIFByb2dyYW1tYWJsZSkgbWVtb3J5DQo+ID4gKyAq
DQo+ID4gKyAqICBDb3B5cmlnaHQgKEMpIDIwMjUgQXNwZWVkDQo+ID4gKyAqDQo+ID4gKyAqICBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAgKi8NCj4gPiArDQo+ID4g
KyNpZm5kZWYgQVNQRUVEX09UUE1FTV9IDQo+ID4gKyNkZWZpbmUgQVNQRUVEX09UUE1FTV9IDQo+
ID4gKw0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL21lbW9yeS5oIg0KPiA+ICsjaW5jbHVkZSAiaHcv
YmxvY2svYmxvY2suaCINCj4gPiArI2luY2x1ZGUgInN5c3RlbS9tZW1vcnkuaCINCj4gPiArI2lu
Y2x1ZGUgInN5c3RlbS9hZGRyZXNzLXNwYWNlcy5oIg0KPiA+ICsNCj4gPiArI2RlZmluZSBPVFBN
RU1fU0laRSAweDQwMDANCj4gDQo+IFRoaXMgZGVmaW5lIGRvZXNuJ3Qgc2VlbSB1c2VmdWwuIE1h
eSBiZSBpbnN0ZWFkLCBzZXQgdGhlIE9UUCBvYmplY3QgInNpemUiDQo+IGZyb20gdGhlIHBhcmVu
dCBtb2RlbCBhdCByZWFsaXplIHRpbWUuDQo+IA0KPiA+ICsjZGVmaW5lIFRZUEVfQVNQRUVEX09U
UE1FTSAiYXNwZWVkLm90cG1lbSINCj4gPiArT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQXNw
ZWVkT1RQTWVtU3RhdGUsDQo+IEFTUEVFRF9PVFBNRU0pDQo+ID4gKw0KPiA+ICt0eXBlZGVmIHN0
cnVjdCBBc3BlZWRPVFBNZW1TdGF0ZSB7DQo+ID4gKyAgICBEZXZpY2VTdGF0ZSBwYXJlbnRfb2Jq
Ow0KPiA+ICsNCj4gPiArICAgIHVpbnQ2NF90IHNpemU7DQo+ID4gKw0KPiA+ICsgICAgQWRkcmVz
c1NwYWNlIGFzOw0KPiA+ICsNCj4gPiArICAgIE1lbW9yeVJlZ2lvbiBtbWlvOw0KPiA+ICsNCj4g
PiArICAgIHVpbnQ4X3QgKnN0b3JhZ2U7DQo+ID4gK30gQXNwZWVkT1RQTWVtU3RhdGU7DQo+ID4g
Kw0KPiA+ICsjZW5kaWYgLyogQVNQRUVEX09UUE1FTV9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2h3
L21pc2MvYXNwZWVkX290cG1lbS5jIGIvaHcvbWlzYy9hc3BlZWRfb3RwbWVtLmMgbmV3DQo+ID4g
ZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwLi5hNzdkNDE4NmY4DQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX290cG1lbS5jDQo+ID4gQEAgLTAsMCAr
MSw5MSBAQA0KPiA+ICsvKg0KPiA+ICsgKiAgQVNQRUVEIE9UUCAoT25lLVRpbWUgUHJvZ3JhbW1h
YmxlKSBtZW1vcnkNCj4gPiArICoNCj4gPiArICogIENvcHlyaWdodCAoQykgMjAyNSBBc3BlZWQN
Cj4gPiArICoNCj4gPiArICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyICAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gPiArI2luY2x1
ZGUgInFlbXUvbG9nLmgiDQo+ID4gKyNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4gKyNpbmNs
dWRlICJ0cmFjZS5oIg0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL2Jsb2NrLWJhY2tlbmQtZ2xvYmFs
LXN0YXRlLmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vYmxvY2stYmFja2VuZC1pby5oIg0KPiA+
ICsjaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRfb3RwbWVtLmgiDQo+ID4gKw0KPiA+ICtzdGF0aWMg
dWludDY0X3QgYXNwZWVkX290cG1lbV9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwN
Cj4gPiArdW5zaWduZWQgc2l6ZSkgew0KPiA+ICsgICAgQXNwZWVkT1RQTWVtU3RhdGUgKnMgPSBv
cGFxdWU7DQo+ID4gKyAgICB1aW50NjRfdCB2YWwgPSAwOw0KPiA+ICsNCj4gPiArICAgIG1lbWNw
eSgmdmFsLCBzLT5zdG9yYWdlICsgb2Zmc2V0LCBzaXplKTsNCj4gPiArDQo+ID4gKyAgICByZXR1
cm4gdmFsOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfb3RwbWVtX3dy
aXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50NjRfdCB2YWwsIHVuc2lnbmVkIHNpemUpIHsNCj4gPiArICAgIEFz
cGVlZE9UUE1lbVN0YXRlICpzID0gb3BhcXVlOw0KPiA+ICsNCj4gPiArICAgIG1lbWNweShzLT5z
dG9yYWdlICsgb2Zmc2V0LCAmdmFsLCBzaXplKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQg
YXNwZWVkX290cG1lbV9pbml0X3N0b3JhZ2UodWludDhfdCAqc3RvcmFnZSwgdWludDY0X3QNCj4g
PiArc2l6ZSkgew0KPiA+ICsgICAgdWludDMyX3QgKnA7DQo+ID4gKyAgICBpbnQgaSwgbnVtOw0K
PiA+ICsNCj4gPiArICAgIG51bSA9IHNpemUgLyBzaXplb2YodWludDMyX3QpOw0KPiA+ICsgICAg
cCA9ICh1aW50MzJfdCAqKXN0b3JhZ2U7DQo+ID4gKyAgICBmb3IgKGkgPSAwOyBpIDwgbnVtOyBp
KyspIHsNCj4gPiArICAgICAgICBwW2ldID0gKGkgJSAyID09IDApID8gMHgwMDAwMDAwMCA6IDB4
RkZGRkZGRkY7DQo+ID4gKyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBN
ZW1vcnlSZWdpb25PcHMgYXNwZWVkX290cG1lbV9vcHMgPSB7DQo+ID4gKyAgICAucmVhZCA9IGFz
cGVlZF9vdHBtZW1fcmVhZCwNCj4gPiArICAgIC53cml0ZSA9IGFzcGVlZF9vdHBtZW1fd3JpdGUs
DQo+ID4gKyAgICAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0KPiA+ICsgICAg
LnZhbGlkLm1pbl9hY2Nlc3Nfc2l6ZSA9IDEsDQo+ID4gKyAgICAudmFsaWQubWF4X2FjY2Vzc19z
aXplID0gNCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9vdHBtZW1f
cmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIHsNCj4gPiArICAgIEFzcGVl
ZE9UUE1lbVN0YXRlICpzID0gQVNQRUVEX09UUE1FTShkZXYpOw0KPiA+ICsNCj4gPiArICAgIHMt
PnN0b3JhZ2UgPSBnX21hbGxvYyhzLT5zaXplKTsNCj4gPiArDQo+ID4gKyAgICBhc3BlZWRfb3Rw
bWVtX2luaXRfc3RvcmFnZShzLT5zdG9yYWdlLCBzLT5zaXplKTsNCj4gPiArDQo+ID4gKyAgICBt
ZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPm1taW8sIE9CSkVDVChkZXYpLA0KPiAmYXNwZWVkX290
cG1lbV9vcHMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgcywgImFzcGVlZC5vdHBt
ZW0iLCBzLT5zaXplKTsNCj4gPiArICAgIGFkZHJlc3Nfc3BhY2VfaW5pdCgmcy0+YXMsICZzLT5t
bWlvLCBOVUxMKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IFByb3BlcnR5IGFzcGVlZF9v
dHBtZW1fcHJvcGVydGllc1tdID0gew0KPiA+ICsgICAgREVGSU5FX1BST1BfVUlOVDY0KCJzaXpl
IiwgQXNwZWVkT1RQTWVtU3RhdGUsIHNpemUsDQo+IE9UUE1FTV9TSVpFKSwNCj4gPiArfTsNCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9vdHBtZW1fY2xhc3NfaW5pdChPYmplY3RDbGFz
cyAqa2xhc3MsIGNvbnN0IHZvaWQNCj4gPiArKmRhdGEpIHsNCj4gPiArICAgIERldmljZUNsYXNz
ICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4gKyAgICBkYy0+cmVhbGl6ZSA9IGFzcGVl
ZF9vdHBtZW1fcmVhbGl6ZTsNCj4gPiArICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsIGFz
cGVlZF9vdHBtZW1fcHJvcGVydGllcyk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBUeXBl
SW5mbyBhc3BlZWRfb3RwbWVtX2luZm8gPSB7DQo+ID4gKyAgICAubmFtZSAgICAgICAgICA9IFRZ
UEVfQVNQRUVEX09UUE1FTSwNCj4gPiArICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9ERVZJQ0Us
DQo+ID4gKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihBc3BlZWRPVFBNZW1TdGF0ZSksDQo+
ID4gKyAgICAuY2xhc3NfaW5pdCAgICA9IGFzcGVlZF9vdHBtZW1fY2xhc3NfaW5pdCwNCj4gPiAr
fTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9vdHBtZW1fcmVnaXN0ZXJfdHlwZXMo
dm9pZCkNCj4gPiArew0KPiA+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFzcGVlZF9vdHBt
ZW1faW5mbyk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3R5cGVfaW5pdChhc3BlZWRfb3RwbWVtX3Jl
Z2lzdGVyX3R5cGVzKQ0KPiA+IGRpZmYgLS1naXQgYS9ody9taXNjL21lc29uLmJ1aWxkIGIvaHcv
bWlzYy9tZXNvbi5idWlsZCBpbmRleA0KPiA+IDZkNDdkZTQ4MmMuLmVkMWVhYWEyYWQgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvbWlzYy9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL2h3L21pc2MvbWVzb24u
YnVpbGQNCj4gPiBAQCAtMTM2LDYgKzEzNiw3IEBAIHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJ
R19BU1BFRURfU09DJywNCj4gaWZfdHJ1ZTogZmlsZXMoDQo+ID4gICAgICdhc3BlZWRfc2JjLmMn
LA0KPiA+ICAgICAnYXNwZWVkX3NkbWMuYycsDQo+ID4gICAgICdhc3BlZWRfeGRtYS5jJywNCj4g
PiArICAnYXNwZWVkX290cG1lbS5jJywNCj4gPiAgICAgJ2FzcGVlZF9wZWNpLmMnLA0KPiA+ICAg
ICAnYXNwZWVkX3NsaS5jJykpDQo+ID4NCg0K

