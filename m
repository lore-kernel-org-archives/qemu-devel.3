Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE35EE83EE3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8s-0005xG-5G; Wed, 04 Feb 2026 02:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZM-0004fk-Px; Wed, 04 Feb 2026 01:40:56 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZL-0004HR-6M; Wed, 04 Feb 2026 01:40:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAkRG0zKFRgsoB9LBfhqIgf/7/Z8I4nrBaS1+cqgrBFui+T6ZIjKfUgIpFGJaqzv4Y6GZZnI0JFZnT8OjDYG6J0pxIHDoHMtnlQWnNa1/6/sKu9AzMeK8kl7/ioJpI1MVEzBDAju3V2aSBxlsSmQIWh5zcuJFz0Ld3b5TkLJqcADlg3cXqc9OGm+a++rEdRMFcumRcmmCiq590WHHwTxXHFnlFht8HDjzXnai9tcGXJ/v7MTWo6ei7XtgAjzIB7vKaeeIz/FcV0v3P2UQPYH14Yv6ELDytjvJco8OhSEQUEdqRFdaodJExBnuZmJNa4SqIJ9W5ev6AvqxGv5qHGIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt9qCMcyOdDxHGZLyohxeKuHtgqxZc3XiCnCgDaQoIM=;
 b=wQBEHiBOQCkGgNYLxagQbvfT8xe6MHcNHAxRue/FuLpicirAwgP3C+onFkIwfro3epEkeN1cfUZWIFJawb2cO9lJnkM0E3HFTr/wRSSUDPZBqBSQ6JnDVGKZvQG/ywt1oMiM3ApmaXSWii9hNq4TbkPcHqSflDglmvNFEoSZkBtrICuZKqsBW1qhzlxoRsTqRtGAhSBhFbBs4Gb4UGGSGe1PL5w4lv4MVpiyuVOVxXU/nuBd10ttOA4sP3kkfUE9iRXAf0WTzChDJc6gX0aTlZxi4fMbRhzx9w39WwJUKNy9liNuWxdT+aClP2dEKgmM2wht2s6HpMsTGCzSyrQugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt9qCMcyOdDxHGZLyohxeKuHtgqxZc3XiCnCgDaQoIM=;
 b=B6qT0nMY3IE9aUYeA257d9tArygEwE3+pFrRoh8fNKSIwIrTEM+PVsdenr1/MdgCFwCIky8OdTDrV1FqmS2FjE3Kp0a3gzGDJsKmZRBUD6yi+2sLU4vwpPjHPKH+E3Kqhplqv9CQ9ZqHNuqhpYnuqJdU8aze82ZMOdbnH9qAHBQrzr9shzeUonqE0OBUeE5wY6nq8v/dWwb6DAbQ+v3JDhK1+tNIGHrdnCLw7mobEZh6WuK+k72rqO7YJoyYD9XzxMfGuEIZqw1JkYF6JNrbc739f4W7vuhVj/G/mRZ+s1v3LJfb6vtfhiP3hHxaOVylXzi7qcbfdyNF8bQ6XGGrUw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:38 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:38 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 15/22] hw/arm/aspeed: Attach WDT device to AST1700 model
Thread-Topic: [PATCH v6 15/22] hw/arm/aspeed: Attach WDT device to AST1700
 model
Thread-Index: AQHclaEss08oGXAKJEa9dAzMRrC5zQ==
Date: Wed, 4 Feb 2026 06:40:38 +0000
Message-ID: <20260204064016.3515639-16-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 197b6b29-8308-4497-bf62-08de63b84efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MDdmL3U0ZnpCTnhBZE9IeXNWMFZmcDJhdEYvSzlUcDR4elVEYVVESXJtbXdz?=
 =?utf-8?B?WkVSTzUvV0lPREQ2SVBPcHJzYnBKbjlkTTl6Ny9QazBVbWpha0JiMFc5KzN1?=
 =?utf-8?B?R3dxTVAzM1h1T0Q3OXR3Qm4rZE1xS0FXT0Rib1luenBXK0RqT1FlUVRKQnJX?=
 =?utf-8?B?djhFNHFjRDAyVVFtKytBaWU0bzVRc0c4RU55SUdCRkE3QnJoOTZycmZoaXo2?=
 =?utf-8?B?cThSK1FETUZEMDhqc1FraGpnZUwxc1JzeFpRLzhvbFF2WEJTNzFaMm4vbURQ?=
 =?utf-8?B?R0REMlNVZG8xV2VxRzJKZk10NmRiYVVIL24zZ2Fma1lMRGR1a1FVbm1TUzJO?=
 =?utf-8?B?M0RQU2hibysrNmtHbmxnOU93c1ZsTTNuRGN4NFBiSmN1c3dXSFRoUlMxVXVU?=
 =?utf-8?B?T1JMUHRlaDhLc2Uzc3lTRW5pQ2V3bWFyOHFjelZYUUZ1NlJhUVRPV1FNaEEz?=
 =?utf-8?B?VzhHYmIzK0lTUGl1N0t2bkVWRnZlRnFXbkpqY3pZSXFwZHRqNEg0bE1mMFNn?=
 =?utf-8?B?c3MyWXhXcDFMajdYNG1ZUklZQ3N5ZkoxbVdnV0FaS3VBQTQrWk13UHluZVpm?=
 =?utf-8?B?Vy9tM3VPbFVJU2MveXd0L3lheTlDdTZpd3hWQThwa0JhaWxscjh3YmNwS1Zq?=
 =?utf-8?B?cmpQdktUUFVReld5RUhWd1dadG1KdEszRWxmaEF6U1g3R21WYm1HTDY2YWFY?=
 =?utf-8?B?bGVVTmR4cmtNVUllZ0hvalFEYmRIaXM1T2VwYnVGNGs4bkgxTEcybHRFK1hJ?=
 =?utf-8?B?UHhueDE4L3B6dUcvZlE3RStZSVBQL0swSnVDbVhWWlVuQjk3cENjYy96SE04?=
 =?utf-8?B?czBpaHVnUnVuaXVta0JWT1F5WGpuRjBXSFNORnF5L09IOGF4QzJ5QVlFbVla?=
 =?utf-8?B?VS9vQWpYZmhPV3VGRzcremh2WnFjWlJrWFpIOTBiTklxelpWUU5sdjIvQTVY?=
 =?utf-8?B?ZDNPU2U3Y0YxUm9EV20rajhvb0ZhWkJOVUdOU1RheFZuajArUmE3K3BwQm1a?=
 =?utf-8?B?SkNSNXVhbWhPeFcydituelRmM3BYcXR0MFBTUlB3MGw0Y0FIeTVMSWF0aWps?=
 =?utf-8?B?dWZWbFhrd2dTM1NRUmlod1RKaXdjZ2NxSDg2dXhuLzhHZkxMSVRraFZDRFIw?=
 =?utf-8?B?bEVxc0tMaEMxa1dXcU9URmJJUHR0a0p5ZmphZlNXbEFodnh1Tnh1am5lSjlB?=
 =?utf-8?B?NTNsdHltM0JWOCs5WlBQc1dWMUx6cis3dEtYNXEvUUxTVEdZSHFQRlBFbzNY?=
 =?utf-8?B?c1J3MzBmTU9mTXBaQXprTUsxVlNCSVZKSE01T0phQzF4b1RWNitIUWtXOVpj?=
 =?utf-8?B?QUlQYkxXb3ZaQ3I2VVBleUY3K01sWEI5NWNheUdyZjJIQkV4em40OUpzV29Y?=
 =?utf-8?B?RnpyZnVNaEpVQjlsSDBYRU1adDVtQkNuQ1Q1MW42K2pkV3JOTEpZcVdlWWNB?=
 =?utf-8?B?cFQwQ2R6ZlFzdDV2MmhyanhJeCtHZlA5anNpU3hoMDQ2SGRSaXZPaWs0YnlZ?=
 =?utf-8?B?dVZnWFg1NzJaaFEweVBUazJmTkVwcVRNb1l2QWhFUTNTOXh4NnlXeHc0aDkx?=
 =?utf-8?B?dExxZ2FzRnMyUnNaM2hFVlhSVXQyVEVTY1BNdThranBWaWNLWm8vY0prUmR5?=
 =?utf-8?B?OHVEd1ZMeDdVNzBDQjBzcW5ZbTRScVN1UVVhVkdqckwrVEtyTlJSZ0VCTHJW?=
 =?utf-8?B?QnA0ajVjMS9HWnhLbFVtWXBCMGE1eG1iYlVCU1NXK2ROejdvRUUrdjVPME5I?=
 =?utf-8?B?c0p0cnRpdnJpaVByVjJGWTNXMmdzNjROME1lT3FMRDZTVUlOdFF6Qlg5ZzJY?=
 =?utf-8?B?MEVVL1JJUXlzT2lnQkJRY05PVWE5VWF1bm9BZkZUK0FtVHRXZ2RpenVMVWtK?=
 =?utf-8?B?MnAxMlV6OGtqcGgwc3dFdFBOcm9HT3pCMUpCczk1SzNORHFFQ3E4MVQxLzM1?=
 =?utf-8?B?dHJxU0xyZlZIU3pCcmdwNDhsaXRxeEcrQUdKM1BSVWdqVk1SbE5XYVU4RXpp?=
 =?utf-8?B?bERKQ0lBcy9XeDlIVlFXTGFKOXlBdmNuUXpIYUNKT2VNR0FCRFJ2ZDR1cVAy?=
 =?utf-8?B?Z3Z4cHlBL0tIVVgvVWhzYS8xTXBzZlNWUmFuY05jdUN6Uis1dkRhbmpsSzR1?=
 =?utf-8?B?aklobWJia2s5QW9PZWwrd045UXZlYzdOekFhbUJJVjdvV2E4WGlIR1JVbjdD?=
 =?utf-8?Q?R4STlQDBoORpQ+MyB5A1Rr8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnpLY1FsMnRxL1NpMVdac3o5eGJtY1lEVGN5NWxiMGxhcnE2U2JQMGUzSFp1?=
 =?utf-8?B?WVI4S01PL3NvMk0wakN6cDRCL2c1WGtVcFAyTHhOeS9McGhGTUtiT01yRFhR?=
 =?utf-8?B?SG5uN29KK05FVDlOa0ZacU5hK0VLTXArdUJFMnQ1L0xsN2dZQTluNWgvRFht?=
 =?utf-8?B?OUxicW1vYkVyR2hUSGRuM3ZKZWtPRGxFc1JXR2YrbkFXMnBWV29NUUNacFJB?=
 =?utf-8?B?dldXaENLc0hia0FpT3o5WVZCN0l4R3pZeVJMbXE4MGlFL3lLakplZ2lPU3Mw?=
 =?utf-8?B?ZkpDNHU4d01PWFY0Tml2NWRucmdIU3lwYVl4VHVqMFZBYTR1REtjdjZzdFVw?=
 =?utf-8?B?KzNhNDdXSXNLVFBCeDJTOThpUVR2MFpOT3UybmVlWVdMWmtQNm9sM05aZEN4?=
 =?utf-8?B?TC94UkFHSGgxMEpFcmJacElKU2UwSS9EUlA2Y0lkV2l1Sk9qZ01vVWJVUFp0?=
 =?utf-8?B?V3F2YWh2UFc3ZGFJVHZ1ek83VUl6dy9aWnFsaXViYW1JZC9SbGVCNkRZdmNU?=
 =?utf-8?B?QlRkWFNDdzk2L1ArSVRNZ2dNNHVxM2VyNzVlQ1Uxcm9WdC9OclNUVU9KYVIy?=
 =?utf-8?B?a0xqQloyNk1YMC83QXRYbjlZUE4yQUNCZlpnU1psOGlTU3IzczFpRWE2OExB?=
 =?utf-8?B?WkhyVWcyb0QxWXkvZUovSzZDcXF0dFRLc1M4eGNDVFMyb3JDY2tkZU4rMnl1?=
 =?utf-8?B?RjNJK3paVlJhQktmRjJyR2x6OVVVaDg1UDRzNUh2TVhiczB2MThLVEdPUUdm?=
 =?utf-8?B?Q05hWG9SMFdVN0d4cDdWWTBnRnh3TFdzMGFNd1o5bmxLeDBzQTRCMkNJSzNi?=
 =?utf-8?B?ZEwxbFYvVnZvRi8zZWdxS3NHOXdnMXhlRzhITzJpbytOTTZsQUpZdW5Xcll1?=
 =?utf-8?B?Qk94UnF3VXo2OHMwNUdKWjVLS0xIbndZdVE1R1RmS24zcWxoTnhvSm5FcUpJ?=
 =?utf-8?B?bWYxVmJwVUlZOFk2RmlDT3BVUm5kUnU2QkdhdFRGWUxWRHNxa2x0ZTNtMUJS?=
 =?utf-8?B?U1JqVWpheXVOV1RRdXRBUGpXVTJSUGVFaXBPU2dHOTBRSUJRTm5ZaVl4U29W?=
 =?utf-8?B?Q0RQSTZxU2wvU0Q0THVSc1I4N0dYZWFyRFdJditjMFNtUVZrcm90bC9IZVk3?=
 =?utf-8?B?STJBbHByVlFsMHJpbGtVNE1pN2RyQ01iTXNTLzdDUUsvK3dneERDRGZNSXJP?=
 =?utf-8?B?aTVhZC9oclBMMERidHlVODk4MUpua204ODJqdWJYdFp5N0Q3bnl4TXErcGlw?=
 =?utf-8?B?N1pkR0x6RkJDZnZHS2NLc09UYlR1ajlvVnQrTVFNZFhtZlBDS2pBMk93eWZQ?=
 =?utf-8?B?T2J3Q3puZEZWYmp4U3RhNzE4ck9XbnlFZzIxVWJIYzhxU0tVb0hxaUY0Um1R?=
 =?utf-8?B?Q0p3dU0wZmR0SmVReUZvTG9WeVZlK1h4NGs4ZWRGWkNNaVpUdXdiS3pteG9X?=
 =?utf-8?B?a3VxNkI3dDN4aFhlYVQ3eGlLcXpCN2NQdGRCa0dYU2lJbys1Rm5mV2MreFlC?=
 =?utf-8?B?RjFySmFlaEFWdEFCYXU2TEdHbkRlRm1wVG0zRHZkRkc2L3FZdmtXekttZ2tv?=
 =?utf-8?B?Mk11MFBpV1QrYm5EeVF2TmdQSkJIejhubmFNVFpkdHVzWG9tS3JkdVRKZ0tX?=
 =?utf-8?B?WmdDcm43MXpJQ0ZnY2xCa3E2UnZmRHJtU1NoOFBSTlRTR1VaUE5IU1NkZjBY?=
 =?utf-8?B?c0Z6Zm5WTW5oTnRacEdMaGNBVmJGWmxZTU9IN2hQcDhJNU91VzlYamZveUVN?=
 =?utf-8?B?bklwS2swak03dXZQME0zNlgvYnFqU2F6Yk5aSFV6dzc0Njc3K1l1NldINkJq?=
 =?utf-8?B?SGFTeGtzcExhdExJMHRWNTNPOG5FemxhTk9HbjY3S1VTRDZ5NmpvOFRsZEVo?=
 =?utf-8?B?RVQ0N2piNktGd3RhUnNxeFRTaDNaQVQxT3JuUUxYTGNRZ1lreGdza0NvdVd5?=
 =?utf-8?B?U01zTHBlUllFeFZGU2V0NFZHSi8yR2RPdk0rTGlBWnMrOHhrVVZjaG9VbENM?=
 =?utf-8?B?K3MwWlBZZXhxTVJvcktZdlE2K3dXT2RaVFArUGprU2hwQlNqT0J0SW1WbDNK?=
 =?utf-8?B?OXNOdFZnMjdOaDc5NVVDNUlhS2RSbG16ekZnQVhWOFlaa3MyMWJmR3pheUsz?=
 =?utf-8?B?UDJ6MlF4ZUdWZGRGVFI5Q29jN29kUzBXM2ZiUXgySGh5cUxzUFhNZWEzdG1q?=
 =?utf-8?B?WkxPZGpwOWd4YVBEWkw3NUdmRVlVUmxPeE1BYzNvcHZ2K1ZiVUhJN09GZ2Ft?=
 =?utf-8?B?WDhsOEZPeU5JelBnYzVWT1B0SlBiSm44T3djeVBIRnJkQWdIQWd3YnhBeTNX?=
 =?utf-8?B?MnY5WlV3WU5CdHRFUzZaWXlZWEM1VGlFQmdCdkxsUGY3VzJwTjhwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197b6b29-8308-4497-bf62-08de63b84efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:38.2704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JlpzdB5zqPRE1Hm+/eQ1TnxnPoIrVDFaFx9Bt5+9nE2RKC52MOPF5FaKXuurqXxourcApEEaTeuPF4NG1azAWmiwtVigl8WaNrLKWZn5+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
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
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Q29ubmVjdCB0aGUgV0RUIGRldmljZSB0byBBU1QxNzAwIG1vZGVsLgoKU2lnbmVkLW9mZi1ieTog
S2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD77+9
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZh
biA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFi
aWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAu
aCB8ICA0ICsrKysKIGh3L2FybS9hc3BlZWRfYXN0MTcwMC5jICAgICAgICAgfCAyNCArKysrKysr
KysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmggYi9pbmNsdWRlL2h3L2Fy
bS9hc3BlZWRfYXN0MTcwMC5oCmluZGV4IDEwMDVjZTYzNjQuLmVlMGM0N2QxNzMgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgKKysrIGIvaW5jbHVkZS9ody9hcm0v
YXNwZWVkX2FzdDE3MDAuaApAQCAtMTUsOCArMTUsMTEgQEAKICNpbmNsdWRlICJody9pMmMvYXNw
ZWVkX2kyYy5oIgogI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2x0cGkuaCIKICNpbmNsdWRlICJo
dy9zc2kvYXNwZWVkX3NtYy5oIgorI2luY2x1ZGUgImh3L3dhdGNoZG9nL3dkdF9hc3BlZWQuaCIK
ICNpbmNsdWRlICJody9jaGFyL3NlcmlhbC1tbS5oIgogCisjZGVmaW5lIEFTVDE3MDBfV0RUX05V
TSAgICAgICAgICAgICAgOQorCiAjZGVmaW5lIFRZUEVfQVNQRUVEX0FTVDE3MDAgImFzcGVlZC5h
c3QxNzAwIgogCiBPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShBc3BlZWRBU1QxNzAwU29DU3Rh
dGUsIEFTUEVFRF9BU1QxNzAwKQpAQCAtMzcsNiArNDAsNyBAQCBzdHJ1Y3QgQXNwZWVkQVNUMTcw
MFNvQ1N0YXRlIHsKICAgICBBc3BlZWRTQ1VTdGF0ZSBzY3U7CiAgICAgQXNwZWVkR1BJT1N0YXRl
IGdwaW87CiAgICAgQXNwZWVkSTJDU3RhdGUgaTJjOworICAgIEFzcGVlZFdEVFN0YXRlIHdkdFtB
U1QxNzAwX1dEVF9OVU1dOwogfTsKIAogI2VuZGlmIC8qIEFTUEVFRF9BU1QxNzAwX0ggKi8KZGlm
ZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAw
LmMKaW5kZXggZTI2NGIyMjAwYi4uNTk5NTRlY2E5OSAxMDA2NDQKLS0tIGEvaHcvYXJtL2FzcGVl
ZF9hc3QxNzAwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKQEAgLTI1LDYgKzI1LDcg
QEAgZW51bSB7CiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0kyQywKICAgICBBU1BFRURfQVNUMTcw
MF9ERVZfVUFSVDEyLAogICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkwsCisgICAgQVNQ
RUVEX0FTVDE3MDBfREVWX1dEVCwKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU1BJMF9NRU0sCiB9
OwogCkBAIC0zNyw2ICszOCw3IEBAIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX2FzdDE3MDBf
aW9fbWVtbWFwW10gPSB7CiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9JMkNdICAgICAgID0gIDB4
MDBDMEYwMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9VQVJUMTJdICAgID0gIDB4MDBDMzNC
MDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NUUkxdID0gIDB4MDBDMzQwMDAsCisg
ICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9XRFRdICAgICAgID0gIDB4MDBDMzcwMDAsCiAgICAgW0FT
UEVFRF9BU1QxNzAwX0RFVl9TUEkwX01FTV0gID0gIDB4MDQwMDAwMDAsCiB9OwogCkBAIC0xMzUs
NiArMTM3LDIyIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX3JlYWxpemUoRGV2aWNlU3Rh
dGUgKmRldiwgRXJyb3IgKiplcnJwKQogICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbigm
cy0+aW9tZW0sCiAgICAgICAgICAgICAgICAgICAgICAgICBhc3BlZWRfYXN0MTcwMF9pb19tZW1t
YXBbQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTF0sCiAgICAgICAgICAgICAgICAgICAgICAg
ICBzeXNidXNfbW1pb19nZXRfcmVnaW9uKFNZU19CVVNfREVWSUNFKCZzLT5sdHBpKSwgMCkpOwor
ICAgIC8qIFdEVCAqLworICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQVNUMTcwMF9XRFRfTlVNOyBp
KyspIHsKKyAgICAgICAgQXNwZWVkV0RUQ2xhc3MgKmF3YyA9IEFTUEVFRF9XRFRfR0VUX0NMQVNT
KCZzLT53ZHRbaV0pOworICAgICAgICBod2FkZHIgd2R0X29mZnNldCA9IGFzcGVlZF9hc3QxNzAw
X2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9ERVZfV0RUXSArCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaSAqIGF3Yy0+aW9zaXplOworCisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
bGluayhPQkpFQ1QoJnMtPndkdFtpXSksICJzY3UiLCBPQkpFQ1QoJnMtPnNjdSksCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKTsKKyAgICAgICAgaWYgKCFzeXNidXNfcmVh
bGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+d2R0W2ldKSwgZXJycCkpIHsKKyAgICAgICAgICAgIHJl
dHVybjsKKyAgICAgICAgfQorICAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMt
PmlvbWVtLAorICAgICAgICAgICAgICAgICAgICAgICAgd2R0X29mZnNldCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0UoJnMtPndk
dFtpXSksIDApKTsKKyAgICB9CisKIH0KIAogc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfaW5z
dGFuY2VfaW5pdChPYmplY3QgKm9iaikKQEAgLTE2OSw2ICsxODcsMTIgQEAgc3RhdGljIHZvaWQg
YXNwZWVkX2FzdDE3MDBfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9iaikKICAgICBvYmplY3RfaW5p
dGlhbGl6ZV9jaGlsZChvYmosICJsdHBpLWN0cmwiLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZzLT5sdHBpLCBUWVBFX0FTUEVFRF9MVFBJKTsKIAorICAgIC8qIFdEVCAqLworICAgIGZv
ciAoaW50IGkgPSAwOyBpIDwgQVNUMTcwMF9XRFRfTlVNOyBpKyspIHsKKyAgICAgICAgb2JqZWN0
X2luaXRpYWxpemVfY2hpbGQob2JqLCAiaW9leHAtd2R0WypdIiwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJnMtPndkdFtpXSwgImFzcGVlZC53ZHQtYXN0MjcwMCIpOworICAgIH0K
KwogICAgIHJldHVybjsKIH0KIAotLSAKMi40My4wCg==

