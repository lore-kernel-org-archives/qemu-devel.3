Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357F0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 01:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGS33-000499-CV; Tue, 04 Nov 2025 20:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGS30-00048W-J6; Tue, 04 Nov 2025 20:10:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGS2x-0002Qy-M5; Tue, 04 Nov 2025 20:10:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDciE2Rg18mA0PhLiy7Sx5VsYz8Jl8u1TnVNQx7s6DhyuDRinDuF4vYtCoRbMSgZHxMBHr6FZ4HcmD2juyds9FLnQAZburEB8BnNTASUf9OBHNoa6I6XrJMCGThdegtkMaa/57+ZmWevdVcAROFfnEudLWQKDqdZIjTmQCil88r+SLHVodgEo9zTjYQeLYXB0ofIgQ4bkfzZPVDKToOWYhLJ3SJjwK71EqlrAFrTum7+XElgy7oyBzOwGpQBqluIPSM1eWArQhrlpg8ArwTrXGnTAs5/3FVf7wQ1x/JNinEPsyjl1ZB/e1zSpDGs/GAkewV0zJtOoLGkPH2nSQsfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moLQJfhGgYOvGmfu0bGX5iOz6zkRrDja8IWHmzsHptI=;
 b=twTl+g+8NemJqByc5fILrOrZPNMqEcplAC2iQp1iIU/419b56BVfhiW2bybal+TSaMEnIFkCxaaC5bwM07WOiU6fqRcIc2M3489J18pMrxV+CEt+n/32z45Etc+Kl6V1mDHLhI+aRXrPaceevDe0pg30czWu/YyG0r9Pptom1S1f4a2q9S5Z6iR8m/ad+ahT6cFUYPKqMW2YpRmHZpvV7gXXv/SN8pgGZIdLhX5J03WYLRk/3N1OLrPjLeMHwUCEeIL9BAJpqjgpCi3mn/VqbKk4hrAepiktbnMr+n8V3Mo+Jt76JqIaHA7vpdDFKj0e199mPgCXkdKu8cdFZzqUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moLQJfhGgYOvGmfu0bGX5iOz6zkRrDja8IWHmzsHptI=;
 b=dHvTgtTVisNmJj1duveF34yY328YYBFgMaSX00bk5X6KDruYAGFapjkdVmChzW6XNvaPm5bWk8I1aeHtZMUXi5kOVm53pImPj4AcyVv6j67QWJxQiak84+jQbI7Sr4cZlrcLFqyZxpjN4NBEbOj3biw/RzWEjgCgJxjcTffe7n4BHohxuLeHuGcZYgBJech+xoPQ64KoWFy1acbJeHWWs+5+8iYEeDw90Jqek/y0yYyvTkq4JS9PyHjKw+9JhaWdvPE1yYLQBLoMXJg3PxxiXFEKCP5jv7hnIJyI28IBGushVd5v/jgZqxb4mpBsFDSJdBhOfKg792I07+KUi83Hsg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5878.apcprd06.prod.outlook.com (2603:1096:101:e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 01:10:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 01:10:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Kane Chen <kane_chen@aspeedtech.com>
CC: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: RE: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
Thread-Topic: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
Thread-Index: AQHcTeQI2jslWiB++EigOGYQzXj01bTjRgCg
Date: Wed, 5 Nov 2025 01:10:37 +0000
Message-ID: <TYPPR06MB820663370307D783EA2AF733FCC5A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251104233742.2147367-1-nabihestefan@google.com>
In-Reply-To: <20251104233742.2147367-1-nabihestefan@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5878:EE_
x-ms-office365-filtering-correlation-id: 07a42945-d295-4bf6-b2c5-08de1c082121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UTdqb1FaM1FUNVpzZWFtVm1mRU5iajl3eEdBT29VeGw1ZHVBT2llQlV1cU9t?=
 =?utf-8?B?Sll0QTdkOVRDajgvZTdXNStqK05kL0Vjdm1iZXRLZU1TSW1PUXh2WXBERFpL?=
 =?utf-8?B?YXFvVklqaUgwWnovNklMT1h1MTNQYVJFanBhZ21ER2N0T1gvSWlHVlJyYXdH?=
 =?utf-8?B?QW5uT0tBVU5vMFhjUWQ3OFoyQlI0T3FRQ3F6c1pPNVE5QnRWTDhlc0xncGtr?=
 =?utf-8?B?dkNFbWdQOTMrR1V1eFVreEZLWk8vd0VjZHJmNGtkbGlrNVRxT3loQTQwaUJ5?=
 =?utf-8?B?a0FTSlEzOWlRTTMvUDdqd3V3NCtSK0lhbHFKQm9Kb1JZYktRTERMNGVVc3ZS?=
 =?utf-8?B?Z2FOdEQxV0dqTVZIOStyaFZNamRPM0hlcWNFZkIxRTZ5T251MDZTeTZZVGli?=
 =?utf-8?B?VmFFdHM3LzNLWmJpS1lXOW85Z3IraDdvZllhcXFRdDA0c3U5QkNZemRmRGRs?=
 =?utf-8?B?dXU1T2QxcE1DQjlFSHZNb0hKY29iWmZzcjN2ZlZ2MDdSQ1FISXJPcVR2c3o0?=
 =?utf-8?B?UnpIWVo4Nk5jZTNDbDhrbE13QzZKbWxRWWVBUmdCajZ2L3ljTkpVS3hzVjQz?=
 =?utf-8?B?WkZBV3R5YVJ4emtobUppbHJhdldxNjZzeW5GTW9SREM5UHBpMkEzZWtkVlBS?=
 =?utf-8?B?OHlUMXMvQW9NOTBSOENpbThyN1NRQUVCRW5ndUsyazVSSm9EQ28zc0hDUnVP?=
 =?utf-8?B?cy93bWFZMHA0bFZaeUhqRUFYcnFjYkErbDVKZ1hCbHFMSEUrYm95Y0J1SHND?=
 =?utf-8?B?OXdkbzdxU2Fyc1lYUDNFYjUzY1ErVDgya0FDYUtCVFUzNGVuM2diS0tHb3pP?=
 =?utf-8?B?Mm1ZRGNFVXdZZExYQXRYeXFlcW1pNStRWjZZYWF5S0t6M3c1SnNGRnJTTUlU?=
 =?utf-8?B?R05zNGxIdWJsejVYdUFUZHV2eXlPSC84RlZ0Y0VWZEYwZU1SWC9jZUMzcmJn?=
 =?utf-8?B?K1pxclJSZEhnNXBDSTI0TmE4TGMzeWFmb2dyQnpCNllWWkFUMFJaUVlJRjB5?=
 =?utf-8?B?cWNKN0twaEdNUURjeThIU09GTFJRTXpYRGw0V2lIVkFhVVlwVkVsOEVTNDh5?=
 =?utf-8?B?ZW1jbXMxL21qeEhiMko1VEF4WVR1NUphOEhQMk01MWdLN0cyb3B2WFRQdkFZ?=
 =?utf-8?B?dnhqY3lLRHAyZGVjUXZ4OCtvUm5Fa2lFQ2Jod2RzYnNvQXZacjAvSjdscHFu?=
 =?utf-8?B?czFwNUZNcSt5bFJpbUNaUE5obCtFc3VZTG5LMEh6V2dJVzFldDdTc3RIdjRn?=
 =?utf-8?B?TmVrbjZmQUhQWkMvTkVTRnUwOGRvdjhWTXRWOWFuNUpnQm9GbThjaUlPWDhH?=
 =?utf-8?B?SVBOMkthMHJFZi96TlZqelhJT1BBTXdaS3VrRE1ISjdsM0dqa2tDQktOUkc2?=
 =?utf-8?B?Q2VheDdpc2o0YjdLNFY3MjdDaisrNjdKblhyaGZLK2dFMi9XdHVJNVJoMys5?=
 =?utf-8?B?aHlMWlZkcGtpMVR5Q1hBdnlyMHVRcXhWZ3NXblFKQ1lxNGhLMUJpOGV0dnBi?=
 =?utf-8?B?M3FFNWpIMUhpdk8wQk42NGcyaUFmZ0NiUlN4Vm51Y3JRalJ6N1VGUW5sQUhj?=
 =?utf-8?B?S1VudDBTeml4UWZ1NzZiMXo2K0YzWkJaYTdSeTNWQ08rbzJ0M29RRVVvc2Rq?=
 =?utf-8?B?M1ZrMVRqa0pYUlh0OTcxRGZKaGxSd2hDYVlEdzNqbjdvY28zQm56Q1MxQ3l2?=
 =?utf-8?B?c3hEZ1ZNNEo4Z0NmRlBMZVJZVkJXSzlwQVQ3dWY5eEV3UzArOUY5b1Q2K3hm?=
 =?utf-8?B?M09KYnBhd0piNnVYYngxWUx3amo4QWljNFYwRG5JZjNic1phRGg4ZEY0SENX?=
 =?utf-8?B?cXJsanROYjBrdm5SbXBrcVNoTytURGFxS0N3bHhRVXVncXdVa0NoZGpJdVU3?=
 =?utf-8?B?Q1htUTlYSmlqdzRyRDBWcTByaDZKMWVpRGhFVkRxUGpWRWI3Q1N0b21mZ3kr?=
 =?utf-8?B?Y01CaWo4OW1UK2FzaFUzdm93aDUzaDl3d0Jra3lROFlEb2pOdVU2Y2oxN0xD?=
 =?utf-8?B?WGJ2bWxtSGltU0dKMEduRTF3VFd2cmlONnQ1ZmplK1I1ZkVueHk1MUR1RTFQ?=
 =?utf-8?Q?4H7MAe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHVqbXpEeUVuU3ZQYlpBTCtqUTJLdDlWWVAvR1YvUWJkeDlHamJ3NmdDeE5U?=
 =?utf-8?B?Q2szK3Z5dTRzaER5NzI3VUhOSFBiR3BkdjNtZlc0QUlRUm83M3E3OC85V3dI?=
 =?utf-8?B?cXdWVEdnTFE2MmtoYWZKalczdGhnT3dKMEJNdUFLZGJPcmYzSVhYVWp0bmdY?=
 =?utf-8?B?SVhzRjBTNjR1bWs5WkhWbDBMb2luNnRYcWJPTTgzbDUxVFNldVg4a1JqWTNo?=
 =?utf-8?B?S0M4dDQvYVZyajRyVVU4ajVua2tJR20yTXhxK0FTTmNqVXoxSGQzUHh1NDhG?=
 =?utf-8?B?VG5MWmtYdzF5ZFdEKzMzcGY4SWlVTkhEbDdvZnMyNDBHMWV4SkMvNVgwM2kv?=
 =?utf-8?B?dURqemhQNmVzemlTY0d2MnYrTVNYaEVqeVIvT0I5S05OMTcxREswNVZCQnE0?=
 =?utf-8?B?a0ZMTmpMYUd4MlYrKzhRaTJhb3JuTmZibHZ3MkYxb3JUdjhkcmpqZmhKakxI?=
 =?utf-8?B?VkhoUUQ1QjNRQjNWNEhwZy9DVFFWb2VSN3JJcUhxVm53Ryt5UWY0NGxnT1Bv?=
 =?utf-8?B?SUw0U0V4eForaWUwMXd0UG5sdjZUT201TTF6cnlBT3plcWIzQU4wRVJjRDFw?=
 =?utf-8?B?RUcwN0FxZ2RVNE5ZZEkvcVlWbkY2MFJic3Y3NmdSbkExWWdRRnRIdTlOWWNL?=
 =?utf-8?B?cHMvbnd5OTk2b1c2Mmp0L3hQa1V2ZTUvbGRqQ2k0Q0Vvd1VYcWNlT0pwc2Vq?=
 =?utf-8?B?cm5GSHJxZkQ4R0t2emJ1S2dhNjFIN2Q2d0ZSSEd2YUFXeGZUdmk3SjV5V2NI?=
 =?utf-8?B?eHFhenB3ck5DRDJQekRFVit3MUk4Zi9xaWxzaXRwM1YrUTN0K0NvOXhJR2NN?=
 =?utf-8?B?T082ZSs1bjlHaDhpa2pLZkxNUW9zdnRvRDl4NFFYVDRxcTdyd21wSUtEOVlr?=
 =?utf-8?B?bGgwcmN6bWFUcTFiQjk3OEVwYkh4WExZd1ZSZ0JYSmpnRG5HeTdIeXU5V3cw?=
 =?utf-8?B?c1ExbjBueHkyMXpyOGpCdUgrTVN6RzNzLzhvSjBKNHlYT2liODVidlUyVThl?=
 =?utf-8?B?Snp6ZXJkMFhJRlV0Y0pQTFYzL2tESW9LdEJaWDkybTlKckZFWURVekw1Wi9a?=
 =?utf-8?B?VXpUMTRzYlNwbkd3MWVRcXhldVpHYm42MUEzR3hJc1pxL0daMnc4d3dCQ2pz?=
 =?utf-8?B?YzU3T293ZVVVNWo0dVFvR09QRllBaWdzdzJhVVhlb2lNNTIxSVhYUnAva3N3?=
 =?utf-8?B?dXZCc1ljbFZyc3hVdTQxelRSSGxHN1BwR2ZLcUxYbXk0U3ZqcUNCUHgyL244?=
 =?utf-8?B?cVIyWER0dWtxZ0dOYy9KNEJyWFNhZk1tbXovN0dpVEMrcVN4STFySU9pSXpB?=
 =?utf-8?B?OFJaQ0RsL2RUTk4wMmdpeGJXTTNXb0xHaElJeURVa3Nva24ybFJQdWdPR1Qx?=
 =?utf-8?B?QXFFSXVFdzBGMUZMbk9ma2lCSHJGMDkzNnY3Rzkzb29wcm9kZTNQa05CS2VQ?=
 =?utf-8?B?a0Rod0k0RWo1bnZBb1hySk1YYUdIeFlBRU1rZnBCZEdPK1NNYmZIdHNSZTdo?=
 =?utf-8?B?bGxCWFBXN3Ryc0VRM0JvWTVGYTNGSDNaY1J5U3ZsTTV5RXZLRHF3dFRpbWtC?=
 =?utf-8?B?SlFpTERyU0VaTG9tSDM4Q0hHSDdrdDVOelVuSjNLRjVMVEZ2OTVRZG8vc093?=
 =?utf-8?B?eTF6TjdEVmVyWHBRU2RIZTNJUEhCL2d3MTJyWjhIZlJpOG5SaCtCdEY1ZkJT?=
 =?utf-8?B?ZUt4WC9tc0xKVTZUWlA4YktjLzQ2OXhkS3REdVdCLzRlUHUybGdhL0dONHlY?=
 =?utf-8?B?L1pHSmtYNm5ZdjhHU0pTMFd0M2doVkExSk1Uc2lwUTE1OE5McHBXR2Noc240?=
 =?utf-8?B?dEQxUzNJQkU3SU15REN3TkRpSzJVZllVeko5elpZYTdMWk1MU25LdEdwdEVP?=
 =?utf-8?B?a2F1cVBYbjFQZjNJa1BQbEc1Ynh0Um9aRDZ6U2daODhWazlTcVZOUVRwOVBp?=
 =?utf-8?B?TjFPTk1JMGtvd0dENnpuVjIyRnBRWldyaWcySlNxL2srWnc1Ynh3a3V3WWNy?=
 =?utf-8?B?Z0F0bzlzd1Nobkl1STBYbjlydFNMcjZ6NGJ6MzM5K2VZMU1oRXBtVUt0UHly?=
 =?utf-8?B?bWg0SXhpOUhHWGtIcy9LODArUk0ySXhtSi9ERWxEbWtyVnZGRUQvMEJZMVUx?=
 =?utf-8?Q?+0SBHpUjo9uDYzCKhO0ilNWJb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a42945-d295-4bf6-b2c5-08de1c082121
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 01:10:37.3726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXjpa1x00q59rPCTIEX9e4Puf4BDhzlAiP+HOrK3F6Xw67UOFlwnIPx5Zl3cfuvPRW2fEoZXOPhhZpSwYW7Noij453s+ZCP4+KBgJOXiZfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5878
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

KyBLYW5lDQoNCkhpIEthbmUsDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgaXQ/
DQpUaGFua3MtSmFtaW4NCg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGh3L2FybS9hc3QyN3gwOiBGaXgg
dHlwbyBpbiBMVFBJIGFkZHJlc3MNCj4gDQo+IFRoZSBhZGRyZXNzIGZvciBMVFBJIGhhcyBvbmUg
bW9yZSAwIHRoYXQgaXQgc2hvdWxkLCBidWcgaW50cm9kdWNlZCBpbiBjb21taXQNCj4gOTEwNjRi
ZWE2YjJkNzQ3YTk4MWNiM2JkMjkwNGU1NmY0NDNlNmM2Ny4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGh3L2Fy
bS9hc3BlZWRfYXN0Mjd4MC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiBjNDg0YmNkNGUyLi4xZTZm
NDY5NTM4IDEwMDY0NA0KPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiArKysgYi9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiBAQCAtODcsMTEgKzg3LDExIEBAIHN0YXRpYyBjb25z
dCBod2FkZHIgYXNwZWVkX3NvY19hc3QyNzAwX21lbW1hcFtdDQo+ID0gew0KPiAgICAgIFtBU1BF
RURfREVWX1VBUlQxMV0gICAgPSAgMHgxNEMzM0EwMCwNCj4gICAgICBbQVNQRUVEX0RFVl9VQVJU
MTJdICAgID0gIDB4MTRDMzNCMDAsDQo+ICAgICAgW0FTUEVFRF9ERVZfV0RUXSAgICAgICA9ICAw
eDE0QzM3MDAwLA0KPiArICAgIFtBU1BFRURfREVWX0xUUEldICAgICAgPSAgMHgzMDAwMDAwMCwN
Cj4gICAgICBbQVNQRUVEX0RFVl9QQ0lFX01NSU8wXSA9IDB4NjAwMDAwMDAsDQo+ICAgICAgW0FT
UEVFRF9ERVZfUENJRV9NTUlPMV0gPSAweDgwMDAwMDAwLA0KPiAgICAgIFtBU1BFRURfREVWX1BD
SUVfTU1JTzJdID0gMHhBMDAwMDAwMCwNCj4gICAgICBbQVNQRUVEX0RFVl9TUElfQk9PVF0gID0g
IDB4MTAwMDAwMDAwLA0KPiAtICAgIFtBU1BFRURfREVWX0xUUEldICAgICAgPSAgMHgzMDAwMDAw
MDAsDQo+ICAgICAgW0FTUEVFRF9ERVZfU0RSQU1dICAgICA9ICAweDQwMDAwMDAwMCwNCj4gIH07
DQo+IA0KPiAtLQ0KPiAyLjUxLjIuMTAwNi5nYTUwYTQ5M2M0OS1nb29nDQoNCg==

