Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E1D3E798
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaOH-0000Rj-Ol; Thu, 11 Dec 2025 01:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vTaOC-0000Qd-4s; Thu, 11 Dec 2025 01:43:02 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vTaO7-0005O3-Gq; Thu, 11 Dec 2025 01:42:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEx3yMPCPInNJGq+zB4Wwca6HB1esE1TebvQmXX27jjtIQqE5ZM2ePk+s393XPZCFaoZCKUB3TtBgngMr6BxqvluwDJbqZrUspfHJwtVFSmHuSLFWzXCsWdG8zisODSneyqDkp7dkFifnti4zdxiJRJtSQpj3nG1lYAmbrfhd26BLljyP4JU5NGvahlpI5uh/09YP3Z8kcd+Pwiyv75GfrzXQL/o1kNUKi7v5mrThZaVntZ61HqGY2INPrvcenYsAW4RyTtDoCeBUlOpx6MkmZpBPdJH9GxZzU6RCSODu3DLWHOXQA1BWfGNvlVktsPRAfMmWUhPa4t2L5Kgo8Jw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYebL0w5VFwubfkbY5IJFNWGgULlK4irNttYo/LQ1U0=;
 b=iY6uB+DItvxhuFpraibn2dN+yI9IOpm+B86vmfoid91yEpkywvTTvvrn8Bpm0HXQZVyNju/NLlXAJjo0UFep2l1yzXcjn5mM0dh3N1iBU8hkGVDBC2o0AI1NPn7l44t/BUTnCqcrERzywSgxgc9BlWuCi09zWYxZPoaeRDJAVOvip3/06hF3ugtpbj3ZoON24n4Vv1dvxlYxNVEwbrsRWCXVCbEbzGMl8NkaUKw5h9AHrvD0RichzlZCpY5MBMAlxjtuqV6LZyCyhxv83r4JJlJnp9Hinq7JTTG381oBevAJVUmrDve17HNwgLgAvjreH/n+/sNZlfTNEjr5/mjt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYebL0w5VFwubfkbY5IJFNWGgULlK4irNttYo/LQ1U0=;
 b=iPMMgZ/ErBgfCteojRwMw4pvvhS357LiWddT2+yNatgRI8RdduG2eN/FMTMtPY/zc9F2x+hQ81aLC9BcFoU55KQufUwzaPNar44URmn9lp9NHFOIK6QOoatSjd+HmtapvVihBwWNaN0RIcxxBzYB193b9ge4AU/YJIqWZWKUcwj+sPEYso8lJW4gMeOYarS9gqhasfes96XslBYzZYq30IIRShqK3XIiNlKgjlecI5w5Kc6Bgv8Qd/lpD3iyVNpeTgFjR98PwTDer5tFKvyTHgCc15rL3b3ANx1vBbO6sOyRnlm5gLTRfRFgGVGqlAf/95naIRko78BaToC1sg+1hA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB6335.apcprd06.prod.outlook.com (2603:1096:101:13c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 06:42:47 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:42:47 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 00/18] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v3 00/18] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcaBaCQIdJYTUOKk+0YD9pSIaY37UbgckAgAB/h8A=
Date: Thu, 11 Dec 2025 06:42:47 +0000
Message-ID: <SI6PR06MB76310C943D65CE7456178A50F7A1A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <CA+QoejW4vx7U-QYBK6GY10NpwXyQFe92j9M=OeURWz_D5vBbUw@mail.gmail.com>
In-Reply-To: <CA+QoejW4vx7U-QYBK6GY10NpwXyQFe92j9M=OeURWz_D5vBbUw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB6335:EE_
x-ms-office365-filtering-correlation-id: b26f6ade-1214-471f-e42f-08de38807f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?OG5tZmRLc0pjTmlYQlBKVXgzdkdNS1NPaDlFMndhVDJ6YjBNdTh2MEJyTEN0?=
 =?utf-8?B?cWU5dFFNdjNvQXdPRmRmVWYyeEoweUhKMmFKQnh6MG1hMnFtS2NVWFJwNS9Z?=
 =?utf-8?B?c3JMWFVsMGFITm5pTkdWWTROWm90N3dzekVPV2ZHNGhtK3VIc1BQMVJYRWNF?=
 =?utf-8?B?S2JzdlFGbnI5aTNMVC9TNmZGNVM4THpPWWtYVXpHZGl4dnpLTExRV0orS2FL?=
 =?utf-8?B?cVRTZTNSSTlFM1pUMkNqaUJnRXZMTVoyTXA0Q0pMTjhReWUwRDhoTkNzM1VK?=
 =?utf-8?B?T0lHSi9iTlFWekY1VGlYY1YxOGpuQ296a1RRLzBEL2lTakhwMHdZUnVFM1Qr?=
 =?utf-8?B?aGJoR3FBY1kwcFRhQldYU01LQjIvaUxsTlIvOW54WldoMzgvMlNMK3lBbzAy?=
 =?utf-8?B?eFZVcWVWN3h3eXNKb1VUUkJ1WHUzck9qZHlvd1I1bkVyTVJ4d2x3QUZjVDJH?=
 =?utf-8?B?Q3ZYelExd1R2eFEvNjR6U1JaWE5Ob25hRG9rYkZkajdSblNVZnhCaGpUOEto?=
 =?utf-8?B?YzY0eUpsbmhPL01ZYjEyVHcvUWJKR1liS3NicEpodjh2SURQaDQyMkJiNWYw?=
 =?utf-8?B?clgxeEdJYmEvOTNYWXpYc0d0VzkrSUVFZmVYUldDZ0tFVytKWmh0Rml5V3do?=
 =?utf-8?B?M3VHNUVsWk9vd0ZCeVlzNWh1Vno4ZXVPT3hZSnhDU2pKdm9nMzNzb1pjZTFF?=
 =?utf-8?B?YmE4OG5iOTg4VE95VTRlOVZUb1ZkZXcxMHJPbnNoa1ZqRlR6c1NZZWg5Ynk1?=
 =?utf-8?B?YjFtV2l2MEpCdmowdDJFRCtuaWFvTzgzZ0xoeFNlT2xUZU95c2lWdTd6YWE5?=
 =?utf-8?B?eEF0eEdIL1pXSUFTVnRCdFFDYmR1WjBVS3FwY3VBZ0syWWRmY1FCNVRmcDFZ?=
 =?utf-8?B?T3ZpUENWZXFQYnNMQWdTWE0zdjFpOVo4MDFMWE4yTnRHd1U1c2Yxck1IV1dr?=
 =?utf-8?B?Q2FadjRYbSs5bU54RWFQcE1jVXNLZUpvT0g5L2V3bEpReWlIMnV3ZlZXTnJI?=
 =?utf-8?B?eGtscHdWZ1lCWWM4WHI4UnZMQmZZMlJ6bUh5ZEhoS1ZMNzBMd1F1aXFlRDJI?=
 =?utf-8?B?d3hxYkF2Smsyc0g3WFBMeldiUTJwRjN4dlJNdllhVTdsdWZoQnRWcy9QVDNm?=
 =?utf-8?B?Skx2N2F5V0JBL3VYOENCL0lSdkxmZEZLa3pJcEFVeW5DekRDcWV5dEhCZk1a?=
 =?utf-8?B?YW5oYjR0MFVrTFNJbUhxbEIxTFBPMlNLeFpWQ2hlVzludTJ0eUcxcGowaTlU?=
 =?utf-8?B?UGhjSnpVWWQ1WXBjSW9mL0pHZ0VqL2gvL2tEMHZiZ2VnMm9iODN2VkRWNWph?=
 =?utf-8?B?VkZhLzJOb2MxT1ZQOXZtTVZUTUJxdU5NQnNJY1dpejFaWVAza3Z5d0lmdnk4?=
 =?utf-8?B?RENWOFk3U2pqeFMvTE9uRm42UURJOUltbTJOc1ZzWCs2aHRsSHlJaTBod3Jq?=
 =?utf-8?B?UmZhQVhSWDgyem9yNGFwczRZekY0aFhZZlFPZjJ5K2VpYmlNcElBY0pLTTIx?=
 =?utf-8?B?R1g4Sjc4dmd4MUw1ZTFyYjVFZTRjeDViOWt3Q1VXdEsrVE44bE11S1JmRG02?=
 =?utf-8?B?N0hQT2MyTmVsRkhNdVNQTEhtM1FEQmhCZ1hKKzRNMG80dzdMVzA5THR6Q3dT?=
 =?utf-8?B?NGlkM09Cc3luS3d5QWo0ZFdDK1Z0dE9XMUxOTE1XNm5qNE9ra2RLNXVNdFR0?=
 =?utf-8?B?NE9zZ09Cd2duS21oOExDb2RPKzQ3NjhacHo5U2xHMlpaM0JYNHVCOXNrT2tI?=
 =?utf-8?B?a3REMGtnNEFSbjkyMDVoeld5WE1Zdk1wYUF2QUExU21pUzIrekZENndqN0VE?=
 =?utf-8?B?MVV2d0RRUlZYY1RUYU5BMGNzSG9wOCtjYlAzRElKdTdrNVliV0xFUERIdG16?=
 =?utf-8?B?SSs4eDhZYlgrVnlpb1R2MDdJMkY0anRxZXladHMxSXYwWXlrZDYxUElZNlhW?=
 =?utf-8?B?WFBQVkJacGZELzlJN1ppS05QNWsySzdMRUc2dm5hZTNlTEh3c2RzVC9BWHhE?=
 =?utf-8?B?TysvSytlK2xMNFMxUVJ1VmJ6aDVodkNJVWpjZlNBQ0laeDdDSk1uK1pMQ3c1?=
 =?utf-8?B?eEtnOWhyQXRyVmRVWmUrbUhic1lSOUVYalpaUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVFZG1JTkRQZFBsVG43Z0lLSklKUnAvNDhQUWhqZEVNdXN0a2pYRW5mSVlP?=
 =?utf-8?B?QWxsMW9BTUZmOEFDUXJDcW55MytVWDdpT3dBc2VTNm5lTjFHMk95R3BadkxR?=
 =?utf-8?B?R05Nb2w1TENPckhpckIvM1BDWGJDOUxHdE9OcVhtbWo2L0NXQloybWppclgx?=
 =?utf-8?B?L1RPRWNWUVRrbmRLWVl0SWdzNUtvbHpKKytsM2NtWDUzUU45bitlYjgrM1VC?=
 =?utf-8?B?VVorTFRGeFBYRzhNRkhjQ3FzYVNuZlNPSEpDTVV0S3kyM3MyZldLN2JEUm1l?=
 =?utf-8?B?VWlSSy9NeUhmVW4yeE9kOUJtMFh5MW9WMVVLVWZOdFJ4UUpXQWpzdmhOWUJn?=
 =?utf-8?B?QVc5SHl5UmlabkFWQ1BkUkw3VnNNN2JRTGhKeFQ0R2RacXpGYTAwNEZ0VDlP?=
 =?utf-8?B?TTVEUDhhRmRMcVloYkFyY05NTlRNU3NOYzgwQjMxMmkyak5JNEhKZUJNd2Z0?=
 =?utf-8?B?SHp3YzllQmJRM0dDZ2todE1YUU00bUhEUzNuWkI1MXI5TDVNNnBmYjU1QVhC?=
 =?utf-8?B?Y2xSNUFjck1hOWZ0akFpbW1SQ3FQZ0ppZW9UTk9nSlFZM2ZON1RtWmtnbTJ4?=
 =?utf-8?B?aTU4Y1RwczFHYlhWd2RPdE1NU2Z3cWVqUGhmbThMY0laOGtmOGR5bkpHUlJN?=
 =?utf-8?B?OUFjLzNsM25kV2JCdDlhcURBS2pLem9RdC9FSWU3bDN5bnhUWk4zUWtKZHYy?=
 =?utf-8?B?ZGx2UkczUkJIcGhiRnc0SXg3RWt6UFk0R2xiRVdLYXV3M0hVd2laVGpLK2ZT?=
 =?utf-8?B?U1V4VDVldlcvSzNtSzdlb1hVUWFLWU5TSGtWb2o3KzRHQ0xqdE9jWSs5NU55?=
 =?utf-8?B?d1lyaUFXaGtFMk4ybE1ycVJCaGpTUUpQSnFmU1FzdFNLSmJBTlcxR3JCQ2ZS?=
 =?utf-8?B?UlNpbXo1MmtqUy9pSEpnYUQyL3FrUnZXSWNTN3g2WlV2UjlwQ0sxMDV2Ukwr?=
 =?utf-8?B?OHgzY3RveGNhT2JCMzRtcXhIYUJyZDljSUFNWVVsc1RXNWhZcS8zWU1wOFNG?=
 =?utf-8?B?WUpFNDA1ZXBmM2p2cFZiZ2Y5bUJBblN3dktTYTNlYXRhUFFpS3lpZVFXYW5p?=
 =?utf-8?B?bjYvd1JyVjBPL3ZUaXlMUGVPbkM5SWc4aDhOUkNib1QwSmVzNUZsTlFOUisw?=
 =?utf-8?B?dGxJZytHTnkyb1lwNmpEcmtEZHNpSExWVmsvNjcrdTZZb1kxM2FWTHozNTBR?=
 =?utf-8?B?eW1ER1A3N1lnM3lmVnlzbk8zaXZkemF2OVNGSjlmSGlvWHRrcGg2WVhCNktZ?=
 =?utf-8?B?dTBVTllFK3NzODRpMjIyRUliWE5XU2ZKbWtINzlsamh4VFB6MkdyYSs3TFJw?=
 =?utf-8?B?cFU0NTZDQ095Rnl5SVFNdG9rdHFOQ0xQZUkwdDJNSlAxRys4NmdIeG1EUlFq?=
 =?utf-8?B?RjFRcU5RR2lHY2JXSWYxNFA3TGp3TmlXUEozNUg5SmpPWHU1ZGVXeXo0OHgr?=
 =?utf-8?B?U2VvRS9aS0l6NURhNlBHVWtBZm5BOGJjRlQvU080VUFpeHR1ZE9VYXltdHJo?=
 =?utf-8?B?WXhKVzJXbW4yS3NPRjg5TUVGVy8rWWlaY0JJNEJPekRwaUpuMjZpQWRpWHZr?=
 =?utf-8?B?L0FjVFFLa3hjNVl2ZGNuRHBZdzM1Y1IrVXlGNGVNQXVxRm5JaUFjUjdTcHVz?=
 =?utf-8?B?emhqb3gxSFE5UTNxU2U0RnBKQXhOZlptTUt0VmErNGF5d3dNVDNUTEZhYjJJ?=
 =?utf-8?B?dG91bHYrN2lCa05OSU8vMDJQZ0F1c2VGamxXS1FkSzBkMmpQanJBcDB1UXJn?=
 =?utf-8?B?MGR2ZWhlamRyRTd5Z0hkQThQSE92WkhQMFR4OXBYMm0rdks3NGNWSTBsMU9B?=
 =?utf-8?B?a1o0Q0dUTDAwaXoyR2orb3NsUlV0TmVKbVM5YW9wTHJSd29rZEI2ei9Tb1dW?=
 =?utf-8?B?aTZDRTYwaVBlcjVha29BS1V0UUdLRHY4UURpWW9FZGN5d2xZUVRFNGQ3V1Vw?=
 =?utf-8?B?VmpIL1pPWlo1MnJ5YU1WOFdYVVptSzM1cDdHQ0F2UVdzVWJ3Y1JHR1ZKZk9k?=
 =?utf-8?B?UnV1OUVXNVRTUTdtcXVzSkJJQXlwWWdOQys4SDNiNnZLeVppYUNvSm1KSGxx?=
 =?utf-8?B?NmZIUmpqQm14WkZLZnhJTTYvS3JRS2Nqai9VUUJ0UnFEK29QbHVvTUpvS2lQ?=
 =?utf-8?Q?UIV66FMZaTTN0WmsEkhslZr9Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26f6ade-1214-471f-e42f-08de38807f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 06:42:47.4757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAhiJEDCv1kJglH19ges6q17g2swLdCXvasNhpwLMx02JQ46VXlYxj48nWPemgEFwDNnBXl7fCbvYqdIKGPziePj4pb0cn2nQyT4Jfrb2+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6335
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

SGkgTmFiaWgsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcgYW5kIGNvbW1lbnRzLiBJIHdp
bGwgd2FpdCBhIGZldyBtb3JlIGRheXMNCnRvIHNlZSBpZiB0aGVyZSBpcyBhZGRpdGlvbmFsIGZl
ZWRiYWNrIGZyb20gb3RoZXJzLiBJZiB5b3UgZW5jb3VudGVyDQphbnl0aGluZyB1bmV4cGVjdGVk
IGluIHlvdXIgbG9jYWwgZW52aXJvbm1lbnQsIHBsZWFzZSBsZXQgbWUga25vdy4gSQ0Kd2lsbCB0
cnkgdG8gYWRkcmVzcyBpdCBpbiB0aGUgdjQgcGF0Y2ggaWYgcG9zc2libGUuDQoNCkJlc3QgcmVn
YXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFiaWgg
RXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNl
bWJlciAxMSwgMjAyNSA3OjAyIEFNDQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gQ2M6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBQZXRlciBN
YXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5f
bGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5k
cmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47
DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBUcm95IExl
ZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDAv
MThdIGh3L2FybS9hc3BlZWQ6IEFTVDE3MDAgTFRQSSBzdXBwb3J0IGFuZA0KPiBkZXZpY2UgaG9v
a3Vwcw0KPiANCj4gT24gU3VuLCBEZWMgNywgMjAyNSBhdCAxMTo0NeKAr1BNIEthbmUgQ2hlbiB2
aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBLYW5l
LUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEhpIGFsbCwNCj4g
Pg0KPiA+IExUUEkgKExWRFMgVHVubmVsaW5nIFByb3RvY29sICYgSW50ZXJmYWNlKSBpcyBkZWZp
bmVkIGluIHRoZSBPQ1ANCj4gPiBEQy1TQ00NCj4gPiAyLjAgc3BlY2lmaWNhdGlvbiAoc2VlIEZp
Z3VyZSAyKToNCj4gPiBodHRwczovL3d3dy5vcGVuY29tcHV0ZS5vcmcvZG9jdW1lbnRzL29jcC1k
Yy1zY20tMi0wLWx0cGktdmVyLTEtMC1wZGYNCj4gPg0KPiA+IExUUEkgcHJvdmlkZXMgYSBwcm90
b2NvbCBhbmQgcGh5c2ljYWwgaW50ZXJmYWNlIGZvciB0dW5uZWxpbmcgdmFyaW91cw0KPiA+IGxv
dy1zcGVlZCBzaWduYWxzIGJldHdlZW4gdGhlIEhvc3QgUHJvY2Vzc29yIE1vZHVsZSAoSFBNKSBh
bmQgdGhlDQo+ID4gU2F0ZWxsaXRlIENvbnRyb2xsZXIgTW9kdWxlIChTQ00pLiBJbiBGaWd1cmUg
MiBvZiB0aGUgc3BlY2lmaWNhdGlvbiwNCj4gPiB0aGUgQVNUMjd4MCBTb0MgKGxlZnQpIGludGVn
cmF0ZXMgdHdvIExUUEkgY29udHJvbGxlcnMsIGFsbG93aW5nIGl0IHRvDQo+ID4gY29ubmVjdCB0
byB1cCB0byB0d28gQVNUMTcwMCBib2FyZHMuIE9uIHRoZSBvdGhlciBzaWRlLCB0aGUgQVNUMTcw
MA0KPiA+IGNvbnNvbGlkYXRlcyBIUE0gRlBHQSBmdW5jdGlvbnMgYW5kIG11bHRpcGxlIHBlcmlw
aGVyYWwgaW50ZXJmYWNlcw0KPiA+IChHUElPLCBVQVJULCBJMkMsIEkzQywgZXRjLikgb250byBh
IHNpbmdsZSBib2FyZC4NCj4gPg0KPiA+IEJlY2F1c2UgdGhlIEFTVDE3MDAgZXhwb3NlcyBhZGRp
dGlvbmFsIEkvTyBpbnRlcmZhY2VzIChHUElPLCBJMkMsIEkzQywNCj4gPiBhbmQgb3RoZXJzKSwg
aXQgYWN0cyBhcyBhbiBJL08gZXhwYW5kZXIuIE9uY2UgY29ubmVjdGVkIG92ZXIgTFRQSSwgdGhl
DQo+ID4gQVNUMjd4MCBjYW4gY29udHJvbCBhZGRpdGlvbmFsIGRvd25zdHJlYW0gZGV2aWNlcyB0
aHJvdWdoIHRoaXMgbGluay4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9u
IHRoZSBTR1BJTyBjaGFuZ2VzOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNTExMDYtYXNwZWVkLXNncGlvLXYxLTAtYjAyNjA5MzcNCj4gPiAxNmZhQGdvb2dsZS5j
b20vDQo+ID4NCj4gPiBJdCBpbnRyb2R1Y2VzIGEgYmFzaWMgTFRQSSBjb250cm9sbGVyIG1vZGVs
IGFuZCB3aXJlcyBpdCBpbnRvIHRoZQ0KPiA+IEFTVDI3eDAgU29DLiBUaGUgc2VyaWVzIGFsc28g
YWRkcyB0aGUgQVNUMTcwMC1zcGVjaWZpYyBMVFBJIGV4cGFuZGVyDQo+ID4gZGV2aWNlIGFuZCBp
bmNyZW1lbnRhbGx5IGNvbm5lY3RzIGNvbW1vbiBwZXJpcGhlcmFscyBvbiB0aGUgQVNUMTcwMA0K
PiA+IG1vZGVsLiBGb3IgdGhlIEkzQyBibG9jaywgd2hpY2ggbWF5IGNhdXNlIGtlcm5lbCBjcmFz
aGVzLCBpdHMgTU1JTw0KPiA+IHJlZ2lvbiBpcyBtb2RlbGVkIGFzIGFuIHVuaW1wbGVtZW50ZWQg
ZGV2aWNlIHRvIHJlc2VydmUgYWRkcmVzcyBzcGFjZQ0KPiA+IGFuZCBtYWtlIHRoZSBtaXNzaW5n
IGZ1bmN0aW9uYWxpdHkgZXhwbGljaXQsIGVuc3VyaW5nIHN0YWJsZSBndWVzdA0KPiA+IHByb2Jp
bmcuDQo+ID4NCj4gPiBJbiB0aGUgb2ZmaWNpYWwgcmVsZWFzZSBpbWFnZXMsIHRoZSBBU1QxNzAw
IGZ1bmN0aW9ucyBhcmUgbm90IGluY2x1ZGVkDQo+ID4gYnkgZGVmYXVsdC4gVG8gdGVzdCB0aGUg
QVNUMTcwMC1yZWxhdGVkIGZ1bmN0aW9uYWxpdHksIHBsZWFzZSBpbmNsdWRlDQo+ID4gdGhlIGZv
bGxvd2luZyBEVFMgZmlsZXMgZm9yIHByb2Jpbmc6DQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29t
L0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12Ni42L2FyY2gvYQ0KPiA+
IHJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1sdHBpMC5kdHNpDQo+ID4NCj4gaHR0cHM6Ly9n
aXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12Ni42L2Fy
Y2gvYQ0KPiA+IHJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1sdHBpMS5kdHNpDQo+ID4NCj4g
PiBBZnRlciBpbmNsdWRpbmcgdGhlc2UgRFRTIGZpbGVzIGluIHRoZSBCTUMgaW1hZ2UsIHlvdSBj
YW4gdmVyaWZ5IExUUEkNCj4gPiBmdW5jdGlvbmFsaXR5IHVzaW5nIHRoZSBmb2xsb3dpbmcgc2Nl
bmFyaW9zOg0KPiA+DQo+ID4gMS4gSW4gVS1Cb290Og0KPiA+ICAgIFJ1biB0aGUgbHRwaSBjb21t
YW5kIHRvIHRyaWdnZXIgdGhlIExUUEkgY29ubmVjdGlvbiBhbmQgZGlzcGxheSB0aGUNCj4gPiAg
ICBjdXJyZW50IGNvbm5lY3Rpb24gc3RhdHVzLg0KPiA+IDIuIEluIEJNQyBMaW51eDoNCj4gPiAg
ICBSdW4gaTJjZGV0ZWN0IC15IDwxNi0zOD4gdG8gc2NhbiBhbmQgdGVzdCB0aGUgSTJDIGJ1c2Vz
IGV4cG9zZWQgYnkNCj4gPiAgICB0aGUgQVNUMTcwMC4NCj4gPg0KPiA+IEFueSBmZWVkYmFjayBv
ciBzdWdnZXN0aW9ucyBhcmUgYXBwcmVjaWF0ZWQhDQo+ID4NCj4gPiBLYW5lDQo+ID4NCj4gDQo+
IEkgbGVmdCBzb21lIG5pdC1waWNreSBub3RlcyBvbiBzb21lIG9mIHRoZSBwYXRjaGVzLCBidXQg
YWZ0ZXIgZml4aW5nIHBhdGNoIDAzDQo+IGV2ZXJ5dGhpbmcgZWxzZSBzZWVtcyBnb29kLiBGV0lX
IEkgYnJvdWdodCB0aGUgd2hvbGUgcGF0Y2hzZXQgaW50byBvdXINCj4gYnJhbmNoIGFuZCBub3Qg
b25seSBkb2VzIGV2ZXJ5dGhpbmcgY29tcGlsZSBwcm9wZXJseSwgYnV0IEkgY2FuIGFsc28gc2Vl
IGFuZA0KPiBpbnRlcmFjdCB3aXRoIHRoZSBpMmMgYnVzZXMgZnJvbSB0aGUgQVNUMTcwMCBpbiBv
dXIgaW50ZXJuYWwgcGxhdGZvcm1zLiBXaWxsDQo+IHdhaXQgZm9yIHY0IHRvIGFkZCB0aGUgcmV2
aWV3ZWQgYW5kIHRlc3RlZCB0YWdzLCBidXQgTEdUTSENCj4gDQo+ID4gLS0tDQo+ID4NCj4gPiBD
aGFuZ2VMb2cNCj4gPiAtLS0tLS0tLS0NCj4gPiB2MzoNCj4gPiAtIEFkZCBQV00gbW9kZWwNCj4g
PiAtIEludGVncmF0ZSB0aGUgU0dQSU8gbW9kZWwNCj4gPiAtIEZpeCBJMkMgdGVzdCBjYXNlIGZh
aWx1cmUNCj4gPiAtIFJlZmluZSBjb2RlIHN0cnVjdHVyZQ0KPiA+DQo+ID4gdjI6DQo+ID4gLSBT
ZXBhcmF0ZSB0aGUgQVNUMTcwMCBtb2RlbCBpbnRvIGEgc3RhbmRhbG9uZSBpbXBsZW1lbnRhdGlv
bg0KPiA+IC0gUmVmaW5lIHRoZSBtZWNoYW5pc20gZm9yIGFzc2lnbmluZyB0aGUgQVNUMTcwMCBi
b2FyZCBudW1iZXINCj4gPg0KPiA+IHYxOg0KPiA+IC0gSW5pdGlhbCB2ZXJzaW9uDQo+ID4gLS0t
DQo+ID4NCj4gPiBLYW5lLUNoZW4tQVMgKDE4KToNCj4gPiAgIGh3L21pc2M6IEFkZCBMVFBJIGNv
bnRyb2xsZXINCj4gPiAgIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBMVFBJIGNvbnRyb2xsZXIgdG8g
QVNUMjdYMCBwbGF0Zm9ybQ0KPiA+ICAgaHcvbWlzYzogQWRkIGJhc2ljIEFzcGVlZCBQV00gbW9k
ZWwNCj4gPiAgIGh3L2FybS9hc3BlZWQ6IEFkZCBBU1QxNzAwIExUUEkgZXhwYW5kZXIgZGV2aWNl
IG1vZGVsDQo+ID4gICBody9hcm0vYXNwZWVkOiBJbnRlZ3JhdGUgQVNUMTcwMCBkZXZpY2UgaW50
byBBU1QyN1gwDQo+ID4gICBody9hcm0vYXNwZWVkOiBJbnRlZ3JhdGUgaW50ZXJydXB0IGNvbnRy
b2xsZXIgZm9yIEFTVDE3MDANCj4gPiAgIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBMVFBJIGNvbnRy
b2xsZXIgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogQXR0YWNoIFVBUlQg
ZGV2aWNlIHRvIEFTVDE3MDAgbW9kZWwNCj4gPiAgIGh3L2FybS9hc3BlZWQ6IEF0dGFjaCBTUkFN
IGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICBody9hcm0vYXNwZWVkOiBBdHRhY2ggU1BJ
IGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICBody9hcm0vYXNwZWVkOiBBdHRhY2ggQURD
IGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICBody9hcm0vYXNwZWVkOiBBdHRhY2ggU0NV
IGRldmljZSB0byBBU1QxNzAwIG1vZGVsDQo+ID4gICBody9hcm0vYXNwZWVkOiBBdHRhY2ggR1BJ
TyBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogYXR0YWNoIEky
QyBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogQXR0YWNoIFdE
VCBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogQXR0YWNoIFBX
TSBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogQXR0YWNoIFNH
UElPTSBkZXZpY2UgdG8gQVNUMTcwMCBtb2RlbA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogTW9kZWwg
QVNUMTcwMCBJM0MgYmxvY2sgYXMgdW5pbXBsZW1lbnRlZCBkZXZpY2UNCj4gPg0KPiA+ICBpbmNs
dWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oIHwgIDUzICsrKysrKysNCj4gPiAgaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX3NvYy5oICAgICB8ICAyNSArKy0NCj4gPiAgaW5jbHVkZS9ody9pMmMvYXNw
ZWVkX2kyYy5oICAgICB8ICAgMSArDQo+ID4gIGluY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5o
ICAgfCAgIDIgKw0KPiA+ICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX2x0cGkuaCAgIHwgIDMyICsr
KysNCj4gPiAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9wd20uaCAgICB8ICAzMSArKysrDQo+ID4g
IGh3L2FybS9hc3BlZWRfYXN0MTcwMC5jICAgICAgICAgfCAyNjkNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICB8
IDE2MyArKysrKysrKysrKysrKysrKy0tDQo+ID4gIGh3L2kyYy9hc3BlZWRfaTJjLmMgICAgICAg
ICAgICAgfCAgMTkgKystDQo+ID4gIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgICAgfCAg
NjAgKysrKysrKw0KPiA+ICBody9taXNjL2FzcGVlZF9sdHBpLmMgICAgICAgICAgIHwgMTk0ICsr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGh3L21pc2MvYXNwZWVkX3B3bS5jICAgICAgICAg
ICAgfCAxMjEgKysrKysrKysrKysrKysNCj4gPiAgaHcvYXJtL21lc29uLmJ1aWxkICAgICAgICAg
ICAgICB8ICAgMSArDQo+ID4gIGh3L21pc2MvbWVzb24uYnVpbGQgICAgICAgICAgICAgfCAgIDIg
Kw0KPiA+ICBody9taXNjL3RyYWNlLWV2ZW50cyAgICAgICAgICAgIHwgICA0ICsNCj4gPiAgMTUg
ZmlsZXMgY2hhbmdlZCwgOTU3IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKSAgY3JlYXRl
IG1vZGUNCj4gPiAxMDA2NDQgaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5jbHVkZS9ody9taXNjL2FzcGVlZF9sdHBpLmggIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiA+IGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfcHdtLmggIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+IGh3L2FybS9hc3BlZWRfYXN0MTcwMC5jICBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvbWlzYy9hc3BlZWRfbHRwaS5jDQo+ID4gY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNw
ZWVkX3B3bS5jDQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo+ID4NCg==

