Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A9FCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 02:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIHIF-0007Tu-LJ; Sun, 09 Nov 2025 21:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIHI7-0007PH-VC; Sun, 09 Nov 2025 21:06:00 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vIHI5-00089w-65; Sun, 09 Nov 2025 21:05:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDnuU/f44wy5aKuWvfqDmxM/MrgnahIF8U5N9IzTABec14au0fuwWAZUKj/XEpOQLu6+B80O8MGjy240PxFvlmVGDju7Opep8SJ7cf3syjd2YusJ5CBKoYihPbUyGByDICii9v858lU6etRTTMkBRh4u5ur5Q7/KN95z40wCtLDWOPysiNaCcUucLeyhIDFHL/7EA3jRisJ43OJs3jg9Y7dSibxHZnwJF2XmsLOPnHyj7LgVyLCvNZwwWasRlCuJ9IKxyXO31U6MDocpC8yQlWolbVux7ZnhY4K7WnxuwhkWZCn0qg9OtP/A6KDshTp053f+YAfOHrcQB6cKluwbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmeLAoVm97FJLzFZ4sa/FTvFN9fhP6s3fJhvwt3Ik4E=;
 b=mD8/XMOyqUX/fOFGDcrs23GJVjITDr48jIc8PyymnkbKnBSIldoNVd8VC6KzgGVQ8Wfu+3et3e53OqNZYUMa1OASEeqJJTirfro/so8RsqQT+9Cf934x5WhDHuyJIs13MY0cOXgLhWBNNT2hW+PD63U5qjTpdcMKmqwTGCbkbQSoQGR+fjls6KQzsnfh3wvdkHmRwPHsakTfhrRthC7COF3zmOUBktIJJDB/To6PBOHm5clif1kCBKbG8ZmvG+KG5p9hd4bUkJ2ce+Lf90m59kg5DPcr9+qtx0HBREYdDQ8MojXB9MGPgv6n6/DTHyjrEe/9w0dwO5KV+sFtHKbBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmeLAoVm97FJLzFZ4sa/FTvFN9fhP6s3fJhvwt3Ik4E=;
 b=j4sv322GtV7TZpDyfjNJl2RrLEMDo6xIaszHiIrL/1M56xr+FQ5e1zjNK1k7RZjAdtJQgtWpYZhYOU5s+ikXN1nvyg+Eo1eBG/BFlKm9jpUMFywMVsAJY5dJ3ELesiYRDRO1Nf1cV8qfd3oY5ZrlWJR+UINV11fboNpov60b3lEmqR7Otclo4U388zY5+PfPlYMOqAtvT3ic2j+ev3vd9ankFKCzbAQWl8jsoyZwLsC8HPV0MKFBfkFw6QkJxFppoM2WsZ462A5B8oY+2DKP+kjiQ53svZVIaHKTJN5lQRnLARRmnsWfe5//P4/GYZ/frCSDpT6sKqw3S819dXquJg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 02:05:49 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 02:05:49 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 06/17] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
Thread-Topic: [PATCH v2 06/17] hw/arm/aspeed: Attach LTPI controller to
 AST1700 model
Thread-Index: AQHcTgiLytFKeAJ0oEGM+WjY64pEhbTnOwWAgAP018A=
Date: Mon, 10 Nov 2025 02:05:49 +0000
Message-ID: <SI6PR06MB7631F126495552EC49248043F7CEA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-7-kane_chen@aspeedtech.com>
 <fa0cf341-f336-48cd-b5d6-458710d187e9@kaod.org>
In-Reply-To: <fa0cf341-f336-48cd-b5d6-458710d187e9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6395:EE_
x-ms-office365-filtering-correlation-id: e06cea1e-2d92-4ddf-fd29-08de1ffdab3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Tjd6T3djWnJ3WGJxeG0rbjZYRmh0Q3NVMlp1ZG1WUHFKRjR3eTdwL09uT0cz?=
 =?utf-8?B?UmoyOXhCZXljeHltMnh2SHUrcjFtZmc4TlFmdFpmMURxMVRsbUc1K2Z3bUJU?=
 =?utf-8?B?Sk5zV1Fya3RBbWpiZUFFZng1cVpwRGNUY2FmQTcwaWV3ank3ODBxdi9TSURw?=
 =?utf-8?B?VjF1SUNnMXlCWGNFU2k2cnA0dERnYmVWY0hVOVRNeEMrSWNhOERqaWx0ZGpB?=
 =?utf-8?B?SjRBekNUTk9SZVRvcjRscjZHb21ESHVOaU1kTVo3eU1zMGZMR3JwN1V5dVhl?=
 =?utf-8?B?bnJWQjcrQVVMb2lGaml2L2RzRzZmcGpHU0JlOVdsNHF1QzFxQWZLWEFwSHVv?=
 =?utf-8?B?Qzg4RUhMR2VkT09Na082YnJFWFc2TEpyOXVuSDdHdjJlMWZRNVVUYkl2NC95?=
 =?utf-8?B?ejNnSXlxN3FjWFptVm9NUUYrVHpUUGtZUGJkQXpvM0FZOW92Unc2L1VyMVgw?=
 =?utf-8?B?cmhZWUpUaDN3dVlodXlYckRiYkhpUi8xUDFyaHptTFgyRThPaWh4dDhrNEtT?=
 =?utf-8?B?UDJCWTNoMnpKK2tMdVNDeTBJK3dGUjk2Qlg2UmQ3M0ljajlXUjRQbVM4OUxH?=
 =?utf-8?B?ZHJIaTN1b2t3bHBzQ2ovSmtlQTk5RTNBQzkxWStKT2pYY0s5bVdDMDJxMmQv?=
 =?utf-8?B?YzRqZVNBbGlkUGo2Q3UxY01QM1hqSEx6b0VZeG1zN2FuektSclJ4bTR3RVZv?=
 =?utf-8?B?TWExNElLd093cVRPNlVOTDJYMldjWWk5RHNHZ1pHVTlMTjd1NzM3MktHb3R6?=
 =?utf-8?B?TW9ZN0hVanFGWXUweVl3Y3hweWs3akszZGdLSzQ4UE1pbGtyNlI5am52R1M0?=
 =?utf-8?B?NnljblNScVl0cS9OYW9QL3JvdXJ0dThiWGZoKyt0OUNDc3VmcUwxcWc4UkRH?=
 =?utf-8?B?TWdBZXhwWTcvODdNdmszczRBbHZpQytvVE0rVkF0UUhDRUwreXhndlFvQnBy?=
 =?utf-8?B?NTRyOE1FTHFVOTMvL2l1VG5HZWNQN2dsdTlwYlhwSWwyMDJPWFkrSGQ3cjk4?=
 =?utf-8?B?cTAvb2dsY3dKb0VER0g5bE5kMDZ0K2JNRUFlZXZwWk9nbFdoVXJ6dzZEUmVz?=
 =?utf-8?B?SFhDdWNTeTBFMCtuSVRpb0VEbEJGUjlrbHorTkR3R1ZxeWpTbW9PWUJmeXNy?=
 =?utf-8?B?cm5USnJIdVhGRXQwdU9UUjVYNTZNbHBaWkxKRktOdXZlWGZnekdJR09iNVRn?=
 =?utf-8?B?VHpiNkN6YVIrQSs4T21VS1V3M2NPc3d6Q0ZjMzNZV3NWZmdhUDJ0UXgySTBE?=
 =?utf-8?B?VzIvZXV4ekEzMDNvMllCeThBWFcxc1BCOVI1bkVxVG1hY3p5R0NiWXRpV3dw?=
 =?utf-8?B?NzZTNG1GU0ZUeGhMK3ZCQ3lYVm16cWd6ekc2R255ejNYSW1yUGhnbjMvVUtH?=
 =?utf-8?B?R3RhR092aDZtS2l4ZmZkN1pIWkRUUUlTbkx0RVJQZjk0TlgzMWFoUmU5WmMx?=
 =?utf-8?B?ZmRiRlMyLzM3Y1BMVlFMbk5hNkJVdHF0Y3h1TWUzdlU1RVJqdXNpTUNDRGtw?=
 =?utf-8?B?NVU3YkJHU3QvMm5hM0FLc0FLbHZnY2dvQ3FFTHNKNU5vNVRaSGNiL0xwbE9o?=
 =?utf-8?B?NnFXRVNEcWtzenJudk9oUmZWZDVxMGRqTmhtcXNSeWFDck5zeHUzQld5RUE5?=
 =?utf-8?B?YWFYTnhqYnNzenB2UlhHT2dISFRQUC9xRWFLelo3NGcxKzhNanhRYWkzUkFR?=
 =?utf-8?B?ZlpnT1VJRjk5d3QrNjdlUnVKbzhsMXRZWElibysrWGNScjNCMUdnVC9zNWxO?=
 =?utf-8?B?eVVueXh2b29qdGlBMWZrU1dvcDFxRDdaVU8xVzdscFRKVjZDWFRpRG1iTlpo?=
 =?utf-8?B?UlZYQUlKMnRuOTJmS25BZU8vUDFBWC9CbWp5Y2NabThEUnJNVVBBaktSR3R4?=
 =?utf-8?B?blVQRnFLYTNoMTlGanlzTm1tVGxhNkd4R0U5Z0Q4TU5GZ2FMQ3hUNDc1aXNS?=
 =?utf-8?B?V3VSOG1tWVJKVW9ubkVzb0lMb2FrbXRhRFU3SXcyaHl5enV3UDMxUFo2WGoz?=
 =?utf-8?B?VmpvMmRBL0VKRHBCNWdUZFE4TXBZeGhOZFA1Q3E4NHRxS3VOMCtGVUpmNUli?=
 =?utf-8?Q?uccW5+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjhxWEpJYUpyY2FZUGRENCtqS3BrWllxSUtKVXk4cFlZOEQ1UHlIUVY0aUxY?=
 =?utf-8?B?dTM3dVFSSXhhRlYvSmh3MEhFL2NDK3ZYM2pRWDQzSDZIYzR6K0Z4K0ptWDh1?=
 =?utf-8?B?ZnVhQ2VXV3hGeEIyTlZmb3VDSW82RFhPQkQ1UU9PTHV2ZTQ5SjlXSmNQY1kv?=
 =?utf-8?B?OVptZ2VXYldpck01QXl5eFVyeHh4YWJhQXJqWFZjVWV0RGVkVzkwNzBvd3Rs?=
 =?utf-8?B?dStRV3RqUWpUQmhteUVpUmNhc2N2bDV1dWRsMWRMc1VYQXk2MjBDd2p5MGQz?=
 =?utf-8?B?MVNQODF4QkQrYTF4QWsvVDNPWUxja3hRMHRzQ2tMbVBvOW9wdEorb0l4UTBE?=
 =?utf-8?B?Zm1uMUdYY09SV0JVL001ZGIrOVd2MDVNMkNkb2VVMjFOSzVHaVkxYnd5M2Np?=
 =?utf-8?B?azhYeC9oT2s0azR2SzNndjVyYkN6c2FkcHBZUzVGd3FOR2pUSFRSZGRFUGxq?=
 =?utf-8?B?M0dPd2drSTcxVnkxL0diRHVjdHBmZElZcFc3clNvR0dMYWNpREJBMmNmaXoz?=
 =?utf-8?B?cXpkcEIwR0M0a3VRZkE1eGVRT1BWaWRwc2dTbUloY241SE1TUHM2aXFRSnNa?=
 =?utf-8?B?WnkwSTNZWENNZmcyamsyQWoveDZUM3UvdDlXUS91MytzTXNFSUpwWk5DUzVw?=
 =?utf-8?B?N1BubDZEdzEwTVJ6eXo0czZldlZZK3BMM1R6citlVmtpcFR1UDBQdnloRlFt?=
 =?utf-8?B?cVR1WTNabE4rUXQ4ZDA4NFhmR3R4RkhKbnoxZnR4VXlyd2RsREc3WFF3eVUy?=
 =?utf-8?B?YTZwOEx0ZTBWYyt3dHRwZlRyY3RGMHFMWG9VUmFpTEZIRTd2d2xkbk9DbDcr?=
 =?utf-8?B?TTQ2bk1iank5NnVZdUQ5ZC90V1ZyOTdxcUhtUmZpYXFNY2RzTTEvU3BSTkU4?=
 =?utf-8?B?U2tuUmgwb2Ryall6N1lTTUx5Unh1K2VYWWEzbm4wRW9PaEVmaXorOVloYktH?=
 =?utf-8?B?RUNZODFydTB0RGlKTjNpZmh6dlJUcWRkL2pqVDR3QW0vU1k5UGtGZVdQSzl4?=
 =?utf-8?B?U3NwbGowcmwzRVRiZHFQZC9FOW9iM0pDd1JrNmpGajlDZk13UUhQSzl0MEpa?=
 =?utf-8?B?L0J5OXh4enp5eVFMcGZQZGtFMm5xWHp5Q0xCcnJTSU0zdmxjVUxkRVVkaENK?=
 =?utf-8?B?anBpVmNwd3orbmRVUW5md3lIVVBiYTdmSWFuS3J0NUdwVVB3UFFOaVErT3ZI?=
 =?utf-8?B?NkRWb1R2SkptcGlqbUNTS0VVaGpIWlJRQUY2dmxjbUlOaC82TC81SnMySU13?=
 =?utf-8?B?Tno0RFVBQ1dCSFI2dUttV3h1R2xXV0hMQ0QyWGtkRkwvcy9RNkhVZmtVSTVD?=
 =?utf-8?B?K0Z1T1h3UW9qczZqK1JJV2hwdVgrR1lGZWg4QmpMOGkxUzBzY3RnL2d4RXV0?=
 =?utf-8?B?VzJTeU1jeFRvcGpwekgrbjFCYXdmNFl1YVBpVGtueDN0ZnQ1YnM1bkZHdVVT?=
 =?utf-8?B?aEU2Y1NxdEJDVU5YM3RhMlY5ZmFmbiswSitmeTQ1SVllcjQ4TmNiQWRXcG1i?=
 =?utf-8?B?ZzF5QllZWmticXRCeWRWeHFTTDVxc0ZTWjdMVUJmdEVEdGdKVUdrSGtCUjNz?=
 =?utf-8?B?RnAxT2tDeVJ5Uk9EeU9wbGNlY0k4V0xWTUpWeElQbkYzQ2hxRFJvejNERzJj?=
 =?utf-8?B?ZGhIbDQvTzRCYzQrNjMvTXN4R21pVHRtRkhBazQyTENRR1RoSUhkTXk3ZUFT?=
 =?utf-8?B?RUR0UUFNeUJya2ZFbXI5bEFubldqd1FIbUdDUGR2VHFxWVh1L2VWWDZEQzNV?=
 =?utf-8?B?Y0U5dkZNcENVUWFHZE82NVRtYWQ0VDhIVStrSVJBVUQ2bXZod1hETTBDZXhw?=
 =?utf-8?B?aS9YNDNNUlpEeDZ5dW91aUN5bEUwenh6STdRa0s3UWpNSTQ3S2NuRzBvV2NW?=
 =?utf-8?B?RXRZbHlBUGc4UTZ0N2lzMmZoVW9WSG1qdFBBTFl0RzVmZlRwUHdoaHU3WWZQ?=
 =?utf-8?B?Yis3QXUwYThOb0ZpSkcwcmZYVFI4OUEvYTlMZnVSUEtaQXQ1RDY1QUpkWlV5?=
 =?utf-8?B?Uld4cHAybFlVYW1zQmEyVzRSN2xZOE9KRUdkYlBQMWtpc1A3Y2YrQUtTVUFl?=
 =?utf-8?B?dWI4ZVdBaW9QQ2tLUFVNWkNOMCtMTU1qdXBlZytHeERUK2thYU5qUTM0bUJx?=
 =?utf-8?Q?D2nYEf11U3lP0WX1nSyuGwV/Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06cea1e-2d92-4ddf-fd29-08de1ffdab3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 02:05:49.3306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bwFU44woZ6lY4i5xrzjxl4pXGK5Ita6H13aIIDv7n3iLXVk+f1tyTvYPDh49Z0DBxrPmYDTZ7fx2ifoXY6As2AsZy265IXGqb742yWCmYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6395
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcuDQoNCkJlc3QgUmVnYXJkcywNCkth
bmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA3LCAyMDI1IDk6Mzcg
UE0NCj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5
ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xl
ZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJl
d0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0K
PiBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6
QWxsIHBhdGNoZXMgQ0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDA2LzE3XSBody9hcm0vYXNwZWVkOiBBdHRhY2ggTFRQSSBjb250cm9sbGVyIHRvDQo+IEFTVDE3
MDAgbW9kZWwNCj4gDQo+IE9uIDExLzUvMjUgMDQ6NTgsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBG
cm9tOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IENv
bm5lY3QgdGhlIExUUEkgY29udHJvbGxlciB0byB0aGUgQVNUMTcwMCBtb2RlbCBieSBtYXBwaW5n
IGl0cyBNTUlPDQo+ID4gcmVnaW9uIGFuZCB3aXJpbmcgaXRzIGludGVycnVwdCBsaW5lLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuaCB8ICAy
ICsrDQo+ID4gICBody9taXNjL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDIxICsrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmgNCj4g
PiBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5oDQo+ID4gaW5kZXggNjI0ZWY2MWVk
YS4uYzJiZWExMTM0NiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2Fz
dDE3MDAuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5oDQo+ID4g
QEAgLTI4LDYgKzI4LDggQEAgc3RydWN0IEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSB7DQo+ID4gICAg
ICAgU3lzQnVzRGV2aWNlIHBhcmVudF9vYmo7DQo+ID4NCj4gPiAgICAgICBNZW1vcnlSZWdpb24g
aW9tZW07DQo+ID4gKw0KPiA+ICsgICAgQXNwZWVkTFRQSVN0YXRlIGx0cGk7DQo+ID4gICB9Ow0K
PiA+DQo+ID4gICAjZW5kaWYgLyogQVNQRUVEX0FTVDE3MDBfSCAqLw0KPiA+IGRpZmYgLS1naXQg
YS9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmMgYi9ody9taXNjL2FzcGVlZF9hc3QxNzAwLmMgaW5k
ZXgNCj4gPiAzMTI1YmVjNzk1Li4wY2EyYjkwZmYwIDEwMDY0NA0KPiA+IC0tLSBhL2h3L21pc2Mv
YXNwZWVkX2FzdDE3MDAuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuYw0KPiA+
IEBAIC0xNiw2ICsxNiwxNCBAQA0KPiA+ICAgI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2FzdDE3
MDAuaCINCj4gPg0KPiA+ICAgI2RlZmluZSBBU1QyNzAwX1NPQ19MVFBJX1NJWkUgICAgICAgIDB4
MDEwMDAwMDANCj4gPiArDQo+ID4gK2VudW0gew0KPiA+ICsgICAgQVNQRUVEX0FTVDE3MDBfREVW
X0xUUElfQ1RSTCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBod2FkZHIgYXNw
ZWVkX2FzdDE3MDBfaW9fbWVtbWFwW10gPSB7DQo+ID4gKyAgICBbQVNQRUVEX0FTVDE3MDBfREVW
X0xUUElfQ1RSTF0gPSAgMHgwMEMzNDAwMCwgfTsNCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9h
c3QxNzAwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgew0K
PiA+ICAgICAgIEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSAqcyA9IEFTUEVFRF9BU1QxNzAwKGRldik7
IEBAIC0yNiwxMA0KPiArMzQsMjMNCj4gPiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfYXN0MTcwMF9y
ZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgQVNUMjcwMF9TT0NfTFRQSV9TSVpFKTsNCj4gPiAgICAgICBzeXNidXNfaW5p
dF9tbWlvKHNiZCwgJnMtPmlvbWVtKTsNCj4gPg0KPiA+ICsgICAgLyogTFRQSSBjb250cm9sbGVy
ICovDQo+ID4gKyAgICBpZiAoIXN5c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5sdHBp
KSwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKyAgICBt
ZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPmlvbWVtLA0KPiA+ICsNCj4gYXNwZWVkX2Fz
dDE3MDBfaW9fbWVtbWFwW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkxdLA0KPiA+ICsNCj4g
PiArIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0UoJnMtPmx0cGkpLCAwKSk7
DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX2luc3RhbmNl
X2luaXQoT2JqZWN0ICpvYmopDQo+ID4gICB7DQo+ID4gKyAgICBBc3BlZWRBU1QxNzAwU29DU3Rh
dGUgKnMgPSBBU1BFRURfQVNUMTcwMChvYmopOw0KPiA+ICsNCj4gPiArICAgIC8qIExUUEkgY29u
dHJvbGxlciAqLw0KPiA+ICsgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaS1j
dHJsIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5sdHBpLCBUWVBFX0FT
UEVFRF9MVFBJKTsNCj4gPiArDQo+ID4gICAgICAgcmV0dXJuOw0KPiA+ICAgfQ0KPiA+DQo+IA0K
PiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

