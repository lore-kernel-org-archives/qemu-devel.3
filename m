Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F8CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dS8-0007gc-BS; Fri, 17 Oct 2025 01:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v9dRv-0007V4-37; Fri, 17 Oct 2025 01:56:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v9dRo-0005XO-4G; Fri, 17 Oct 2025 01:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OK2bSqVL0bWSTB9kaCwXuys9ZYrBBD/Ll9aSCaH9fPmQOeIrTjM9y/6f4ZDeHe2NUNXvRgeEuKwQJar8otq/RYAlOIF2LvDX52ABMHr/kwkhocBDPKC2e2bZaOkFuV/f1kBJWFiIpg9HSCKQ0lUhL7z+rHPzlojTdbtXo9a2mybGEhZyWAGf5kysEy/Rv6SS91c4gYiIc1BZiOrZy75BUodAbjYOwabFuLi597Esw/byzoqeEOL1TpSsSsirn9hl/2lR0BCER58dxYjfVKEosZz8DDd4egIgcDb4xqaK4xS1fWwMooeJigm2P9NL+SlN/YDPKp5wDMuyphy9F6Xgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8NDftBi5fh0c52RuMcKZ4eg6mDVQLSXwiKAiEnK5ME=;
 b=VVN+KnFCBBlnepJZwzg9FvSf6k9PwI3mZvn47bUU4RLO51amqmc/WnmlIoANz2C41KYPDplD/uDQ85MmdSv2BzyuxEHuQeflyf+WqeRUoyX/uupytzTIyGZivPqhnaRoP+cb3Fd6erLYeTH2D4MzUOeTubJ2ZhlLRvuo4hdYllDYC+W7VXT3m4gNlBeE0zPFjd4wLNt0hHr9L+EFAr8GeWlpHYjRiL1mO7kPoX44+EItcN17iwd1XIp00Wq1gR1icm2w5E831YjyhfibESLgVb3ky7K5PBp5ZKoEkpwOvsMbq/CBjek2Fz6C5QfYheorfdU1nxAZmXAKbSDa7WtF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8NDftBi5fh0c52RuMcKZ4eg6mDVQLSXwiKAiEnK5ME=;
 b=S+Ne4LkRnPz4kAB7146KcjL8OoH3iXHS+B+7g4IeTRgZM2s3Kc8Popca5sWrHzWXL/xQFiuywtviFF8l9tAYpGkbQYUuKw3za+iH+3p08n3p9DrN211YEEq7FhrGkbH/IEtfqmfZhA7QNjlP2tNm3V8+TuaLs8vB3yBE1/WTmXlBiW4xbfVpFCf7gCcJNMg0I60Q4UrvzIgYQUt5rKFt1zhbU2fxrjC7cgTwbPmrGKT/pVx42COOsns6ravldb67XZ4wkpARTscyQU9zBsDzEqyZFRiuifoyvqrGzCXkXOGB/ysuIyyNXcOmoMa7D76L+YBF510enHM5QjF+uy0dYA==
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com (2603:1096:820:30::6)
 by SEYPR06MB5719.apcprd06.prod.outlook.com (2603:1096:101:b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 05:55:38 +0000
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156]) by KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 05:55:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 0/1] Move AST1030 machine to a separate file
Thread-Topic: [SPAM] [PATCH v1 0/1] Move AST1030 machine to a separate file
Thread-Index: AQHcPatwpmDY2vjGRU6GDhsp/jm8h7TF2LUAgAAAKRA=
Date: Fri, 17 Oct 2025 05:55:38 +0000
Message-ID: <KL1PR0601MB4196F8C8C4DABAB537CFBC0FFCF6A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
References: <20251015081219.2766143-1-jamin_lin@aspeedtech.com>
 <9405e583-3d71-4d49-8860-39c23b359fd7@kaod.org>
In-Reply-To: <9405e583-3d71-4d49-8860-39c23b359fd7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4196:EE_|SEYPR06MB5719:EE_
x-ms-office365-filtering-correlation-id: c151c08e-b301-4de7-f3f3-08de0d41cc52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?Tk52RFRRbzFweEVzVC9Nd0dMMUtiQk5DMjFEVld6dXFsN3lPdVVKalVJNGRV?=
 =?utf-8?B?aFRZTHVjQVpOMDZtLzYvRUE5SDFEODVpZnV6UzBPS1N5UkZYMExEbHdiTlRn?=
 =?utf-8?B?ckYwYzYvVU5xYTNIV2F6NWVnemZhOFAxeGtUNzRPRW9Rc0VUNWFqek1iNHBn?=
 =?utf-8?B?blA5Q0FISk9mL3BxWlMwYStGK3BqQ2tzTXdqeXBya0M1RFVha1oxUXJLM1lq?=
 =?utf-8?B?a0xUTHFVMXdPZWpHMzhsZyt5eTh0MncvVjRjM2pVTEp4dUtvcXpCOFZIZXl3?=
 =?utf-8?B?VTg3VUdLLzN0cndKTm1SUW9UVFhMdHRtc00rQjYvK21Hbkp2M1NwMGpkemt0?=
 =?utf-8?B?ODgxTVJSQ216ZzZaWDRiU1FqL1JKVUN2QlRObnV0V3U3VGVScmUrZDhseGpm?=
 =?utf-8?B?NTg3Ti93RlZjUWJ5Q1hMRGh3c3A5THVUNGZNaGd1TUxIUnZpSDQ5Ry9Dak5G?=
 =?utf-8?B?REEvcHNhV3duVFJ5K2QvMmF4NlNUenRtOGduZVdvQ3dZOWdGSzJTejEvVDJY?=
 =?utf-8?B?VlorUU04YnVsdTA4enNyL2dQR05yaU1jakdLa0JRN29UaXE5M29uK1FqQ2Vr?=
 =?utf-8?B?MU4wZS9SSDdiaUpDRGpQc3JlZStIVE5CRS9RQ05WeXEzTVZ1dm9aM0U4TGtW?=
 =?utf-8?B?bTdiTjB5ZDRqZEZFUWJWMTJrK1hmOFBRQmpHSmtmcThUMGV6eDJjdzg1alVQ?=
 =?utf-8?B?OXg5ZmczMFJ4ZXBhZkpZTXRZZEI4ZmUrcHM4Nmhvd2FxRVUya2FHeHVIcjJC?=
 =?utf-8?B?NXcwZ0VZR0FBVE5pdzczazNMa0tNK0RMSFI1OVlDcyt5THdSd1pyUWVVWk1H?=
 =?utf-8?B?K1ZoTFpKdmwvSVM3ZkNkWE1BbTZQOFU5cmM5Qm8xbmFHRUxnN2ZwRDRQZUNW?=
 =?utf-8?B?aU8rZzF2NVBZa2RLTVYyWjJBRktsaXlyWHhRUW51dU53TlF4MXdJN3ZFQ0gr?=
 =?utf-8?B?cjZ2dTRFdHNMOVFUNWtwY3pVcnV0TWZsZU9wRytMa0tJWjZBZUdlRlc1RTVS?=
 =?utf-8?B?Z2RNdzNrN2YzZVpSdkNPZ05ZbEhQTjNOZldDelhXUTFDZ3lTcHZlejgzaW9R?=
 =?utf-8?B?NXd0aG4yRm1oTi83dEIxTG9kL2d3L0phQlNuZFFObkRmWmNqSTlPTXRqK3F5?=
 =?utf-8?B?cENydXozMzVxVjZ0SG4wRHVhZktHZ1U0OHRLWHc4ajBTYm54dEorSngwaHgw?=
 =?utf-8?B?RTRZb0FTWjUzK3BLWUcva09RcEdUV1RJL1hoSkF6dmw4TjM3eVd6aUtDdzhy?=
 =?utf-8?B?THFzd3N6K3Ezd0lBMmxWTGNray9HenkxMmVkeCtrelFMVC9ITkErT2oxSFlv?=
 =?utf-8?B?bHN5U0NVdk5CMzZNU2FPcWlPclhReXFKNU15SFc0ak84YkdFeGhGbXZON0hv?=
 =?utf-8?B?dktPN0JVV2RFcGVsNUFoaWdrdWdxN2RtdEtvL1luL05ZOVRKRjJwRzNiQWY4?=
 =?utf-8?B?Z0FMM0VzME5rY3FSL3ROdDhTdmgzaXVVY2dPSkxDQXVxVnA5TGM1QnVQSytG?=
 =?utf-8?B?V0tXZk9ET2E1UkMwL2FnL2NEb0M3b1phTk5UZDBteUNYMWZqWG85dXhGd09V?=
 =?utf-8?B?UmpxOTd4d005RDFuZ1lROVhINWpPL1JuRXhENTQ4c3YvY0pKc3hVbG5FN291?=
 =?utf-8?B?RlpKMW9vU3RnUkNhRDRuY3IrcGV2V1c3YUwxZWRmNjU0ZHRvdEpRRXkvUEZm?=
 =?utf-8?B?RlR3SlVzY3FRSThDRlBQdHFvUU03Qms1aDI2aXBEWXJnWnRNa0s2R09vclhk?=
 =?utf-8?B?YTJCUWMwbHlmS3FnbHlEazV1RFlZNlllb3FBemc2b0VaVXJmblM0UWo2TVUy?=
 =?utf-8?B?QjQxRThHRWErUmREVFFrenYxUlRjWHJtaXZyaktlSDF0eStrZXRlN2FSbnpz?=
 =?utf-8?B?Z2R5RUtaZ1NyR0JWYzc0ayt6ZExNZVlSaTh5SnBneE4wNFlkNUMvU25QSHZO?=
 =?utf-8?B?SmlrNkx4WVV1OWhQbDJ1dHJ2Nmc0a3lUdjhVdXFCU1hxUSthMi9xSkxOTU5S?=
 =?utf-8?B?SjVsejhzampaU1lJNHFNa3lOMDRmUTgzV3RYZWVDeVBDendTWFprTUdmcUJq?=
 =?utf-8?B?d1duMHB3dWFRUWxwRnJVUTlJejlRcXR0VGd6UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4196.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXpJUklXOGtkQXdLQ0RmN292REYrZU5BT016dUhrOW14bDJLZCtGa1NYRzR6?=
 =?utf-8?B?SjhlcEpxTXN3dnlIcm44cVhLTjRTTnhFRHhjY2hiWHAyNFhrYkhteENPZVhG?=
 =?utf-8?B?dzJRazZyVVRCR3B2K0J0UEw1RHdObmZIQ29sRGVHcERyVnNMWE9lU0Z3VzA4?=
 =?utf-8?B?bTJ0NTN4ZVdkUDN5YzVEelZCTkFmd2QxYzBhSTNPelBlZzhVMzM1WjM1MUor?=
 =?utf-8?B?U2hXUSs2YW5iSUR5bTVLaHpKL1EvMWZBaUFmUWZzU0RxcDJQUkREU3B2cE9W?=
 =?utf-8?B?UzR3cUlheng3U0tLYWpUUGJyOU9zdTJaVHBaS1hidmcxUWkrZ2wvRjNET0pN?=
 =?utf-8?B?NmZLZjhIbmV4dnZvZEx2dXpVM21pTzlMbzdua21zcktuK1hlR3o1eTFua1U2?=
 =?utf-8?B?QWRNc1AvZ3VxZEhNTURhZEdreWVKVjRUUGhnWFFwdXY4aE5HU2VwaWpXTnNB?=
 =?utf-8?B?ZkdEb2hiV1piQkRkY0dVMjBXUjZ0M2gzemRJUFgzQS8vU09oS3VuRUtadkd2?=
 =?utf-8?B?OXRubmtDNm8yN0piaGpvUlNtTnZzc2pRcXhEYWI4WXpNeTBVZDVQWkdVUHh0?=
 =?utf-8?B?SVJxNTZ6Z3M0QTJINXRhMjJxZHVPZWJyOEpjTXJ1YkhYb0hReEIvZkdtb3Na?=
 =?utf-8?B?NWQwaUN4aXNmaXIweWxmSmtnUlJpZ2l2K09XSmJwaFRSRXQzQllma01KSkJw?=
 =?utf-8?B?bVhJYkkxZVFpTHYvTS8rZkxMZmJ2YTMzVjlVMExRYStiQmV0WlVQTFZDcWNH?=
 =?utf-8?B?eFNua21jZWhod0ErOEZCczNxNmhwcm5SRGtpQmhNaVFPKzNwdTlvdzYycWdC?=
 =?utf-8?B?V3pKeEtqeGtINSs3NWRadWhVTjhqdFFvazBRanRBbW93bE9Wa2JUN054T2g3?=
 =?utf-8?B?RUQyZk92VHZDUnppUEhJei8xOW15UjFoc1MwbjR3MVBMWnI5Zzhpd1czeThp?=
 =?utf-8?B?dDhZMWcvcURreTJ2aWk1d0ZiSWNMVmZ1dUthdmo5WkhlZEIzd1BpZkljSnZQ?=
 =?utf-8?B?RFdxd0R4SkFMWmd1RXc0RkVOeWQ2aTQrK2ZTR2tQQkdFTlNmZzhEL1cvWjlB?=
 =?utf-8?B?RTNtSnhDMklGQkhxbWtkWFl1SUhTNHdFeGFzZGo2L3dmc2tiUkk1TDQ1N282?=
 =?utf-8?B?UHJVcUlTUW1xbGRHaFhBbDN4ZHJuallyenBiekUwL2xMOXlHZTB0SkJ4WVVP?=
 =?utf-8?B?MXhhZDdlRGZ5b3RHanUxNlBENkVaa3lpVXJjQ1ludjNHeWpvVE5DRy9yNEpu?=
 =?utf-8?B?QldXZUVOUC9heGMwT1pDNHVQZUhGTEl6OTZDTlYzQ1hPTUt0azNGOG9NRW54?=
 =?utf-8?B?bjFISUVvUHhKanVVeEVkTDhGZUd5KzFDMWE2VGJLaTY3NVV1MWQvTFlhTjc5?=
 =?utf-8?B?dVBMYXAyRmhPV3U5VHB0cWR1YWhUdk9yTWNyYjh1TUdVbW85a2tOVFMrSXpQ?=
 =?utf-8?B?YzFYekM5Y1JyWUgvM283Y2NQK2k2eW5rTnprZU9qOVRTN2FiSEw5N0NyZTF4?=
 =?utf-8?B?UlNRN0dIR0Fta3krSGl5cnRSTnZDL2R3SFM3MXhZVzUwVE9SSkl6R0FDcFUw?=
 =?utf-8?B?YVVjZ05KVE84TnJvdEdhcnNiTFpaditaNUQ0MTlVVG1HN3dMZFo1K0pQRjBw?=
 =?utf-8?B?bE55SnJ4d0Yxb2xzbng0THgra0hlRFpXLzBDRW4rMmhJY3hXYjVxdmcxQjZ1?=
 =?utf-8?B?NjQ3U2E4OC9SdzZVa1I3NXpiZFI1Y21sajRrdVV0Y1FDdWNQQ3gyOHB6Lyti?=
 =?utf-8?B?QTlFbEwzenJDUDVZNFJzRU9QRWhlMENhN3ZDYm9wcE11Si9yR0ZYM0w1REJI?=
 =?utf-8?B?azVkdG12MXJDb2prQzRRdXRhM09YdXdjN1JtejJhcmZWRjBwd1VUL0VtT1ht?=
 =?utf-8?B?WHlpQ1l3MWZBZmh1cWF0RWRyUTZmNVpTelZ6dy9EMkFKZHVnZUViMDBPWGlZ?=
 =?utf-8?B?TDJUQ1pHZzkrN093M1pNcnN2WXlhUEp2NW82WGhGZEhoN2E5NlRvTG9vUVl0?=
 =?utf-8?B?ZEZRK2dwWEMra1NySGVEWDhoVGJoZnQ0UnRQbEFWeStxQTRNV1lUbVMyQWEr?=
 =?utf-8?B?WjU2aUcvakJqRFBZd3AxQ1pYSkVFYU9TTDE1NXJ3bW05b01SUlRuUnR2SG42?=
 =?utf-8?Q?0vEQp8GOXg1EfUdaBuZ6ZJnli?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4196.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c151c08e-b301-4de7-f3f3-08de0d41cc52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 05:55:38.5118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJRMOeEV0OvXB6m6n50oh2kZEFdhgZH9I2pia7BBLf1ebhnyyyr5kQbsgGl16npLalam8z7QsiF4VM9K5joFzs2NuISAdrEkPaKrBlaWEKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5719
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAvMV0gTW92ZSBB
U1QxMDMwIG1hY2hpbmUgdG8gYSBzZXBhcmF0ZSBmaWxlDQo+IA0KPiBKYW1pbiwNCj4gDQo+IE9u
IDEwLzE1LzI1IDEwOjEyLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gdjE6DQo+ID4gICAxLiBNb3Zl
IEFTVDEwMzAgbWFjaGluZSB0byBhIHNlcGFyYXRlIGZpbGUNCj4gPg0KPiA+IEphbWluIExpbiAo
MSk6DQo+ID4gICAgaHcvYXJtL2FzcGVlZDogTW92ZSBBU1QxMDMwIG1hY2hpbmUgdG8gYSBzZXBh
cmF0ZSBmaWxlDQo+ID4NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZC5oICAgICAgICB8ICAx
OCArKysrKysNCj4gPiAgIGh3L2FybS9hc3BlZWQuYyAgICAgICAgICAgICAgICB8IDEwNiArKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QxMHgw
X2JvYXJkcy5jIHwgMTA3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAgaHcvYXJtL21lc29uLmJ1aWxkICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKyksIDEwMiBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDEweDBfYm9hcmRzLmMNCj4gPg0KPiANCj4g
SSB3aWxsIHdhaXQgZm9yIHlvdXIgcHJvcG9zYWwgcmVvcmdhbml6aW5nIHRoZSBhc3BlZWQgbWFj
aGluZSBmaWxlcy4NCj4gDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4NCkkgd2lsbCBw
cm92aWRlIGFuIHVwZGF0ZSBsYXRlciBpbiBhbm90aGVyIGVtYWlsLiBJdCBhcHBlYXJzIHRoYXQg
dGhpcyBwYXRjaCBjYW4gYmUgZHJvcHBlZCwgYXMgd2UgaW50ZW5kIHRvIGhhdmUgb25lIEMgZmls
ZSBhbmQgb25lIGNvbW1pdCBwZXIgYm9hcmQvbWFjaGluZS4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K
PiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNCg==

