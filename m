Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975CCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBEH-0007Bm-P1; Thu, 18 Sep 2025 05:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uzBEE-0007BG-28; Thu, 18 Sep 2025 05:47:03 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uzBE5-00044O-7W; Thu, 18 Sep 2025 05:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx4beZMqUJPVRghulfDQJNv+0z9L8t8qcaGzNU8DgTQiJXZ3zX0DLvHlM6iyjDee+QuHLpCOUJ7G7T3VMf9uVOnkUiY4n4J26yZ5mWy2Urtts/YK1VSvTGfz87lRj2eS0+3325gH61MWloMXzKvxbfKN7tqzYCQ2nlXp/7MQ75otxLI2Y973wL4Zsi1ueW3OeiGx8d3g8465A6gqHCrMW5cy83lE3PmE6d57h0QoOAaIUDbMjfodGwOGYKEE4jrf7oQqlYG0K0kDVa3QXcSBkuhDz/HTau9P4oRV3VpOH5F8jjl4au39A9bQfVp35gwnYIZrJZAtCzDJ5Q63JS4qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHD06pab1VCLhjv5OQche+kvOyBP7obQ5oblllkV2vw=;
 b=JJI7n5G6XqXPenrO2v2UZwk0uTrPBRllx7nX4Dkpo2GyjRAt2copeUuehcWHdu3IPULLimnHLNVddFPk9birKAPI5RW9EKAPILFMiPs9LEtNRkr7N1F51eW9Cfd/lL8Wh7K7VisATvvph3z92ikBQmuuw36+UzUk3hWWrxgQpGSbyDZgJicUYCMG0KGqc56vnuYa2oMaprLu4DuBd/xMWdUzd93VSHo6tKFezVaKP03kjWaLtEtDFAi4OOU61obQegbMkcsKtaveSw7lWAyliCf+kqgHHf1VXZGpX/3G0to7+xojibvvxbrIl/bhiHybckm99P/lwSH8T3b7B3+lTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHD06pab1VCLhjv5OQche+kvOyBP7obQ5oblllkV2vw=;
 b=k8Cl/vDqfvx/2dnGd5o0hW3C66J2Cv4j8E06sWR4fvXMKviKOK+nnL+4blQAWtTdrMK2VKtXLgiEuYEEXEp7g/wDK6y4AwBB/U/IG1PbrJ0KXkijL9du3KAqUYHHLL9OFW5XhGsNbBQKwrLvQlcNdvsWUP4AT+IVMLsgfOUiG0J6m9A/OuHKUrMpP0TChQH5l9SS0o7rxEkQt0oLGCGVmGHy5eSgqOh1HRPqDXjejMjk/qR0VX0OkdOkDEWHwE6AMnBV0530H6vsRhtxym/G/8HVGwt1dsUft9p6KcHfMAvidC40lKyPk47owfRoilmM5hvgeBbFTSO896uEeEBtRw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SE3PR06MB8016.apcprd06.prod.outlook.com (2603:1096:101:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:46:40 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 09:46:40 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 1/6] hw/arm/aspeed: Add 'ioexps-num' property
 for AST27x0
Thread-Topic: [SPAM] [PATCH v1 1/6] hw/arm/aspeed: Add 'ioexps-num' property
 for AST27x0
Thread-Index: AQHcJ3LWmiRf9SZ83kCAPhu4eMMirrSXCUkAgAAEqbA=
Date: Thu, 18 Sep 2025 09:46:40 +0000
Message-ID: <SI6PR06MB7631260957F33C379575C6F0F716A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
 <20250917013143.1600377-2-kane_chen@aspeedtech.com>
 <454d8e49-ce7d-4e6e-9115-8b2db2f645c5@kaod.org>
In-Reply-To: <454d8e49-ce7d-4e6e-9115-8b2db2f645c5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SE3PR06MB8016:EE_
x-ms-office365-filtering-correlation-id: 394b63ba-cc07-4c85-4298-08ddf69844ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?bEVsd0IzSkVMN1NCYmQrc3JMUE12ZzZrbmJYSDI5YUNrMWt4WGVlWUUzcjlw?=
 =?utf-8?B?S1NVOG52SWNKTVFCK2QyT2NBM2hrRUc0WGoxRkZDZ1ljUi9mL2hFaDY2TkVz?=
 =?utf-8?B?NzJIeUdkVXN4eEtVQ2NSNUlEdVRlNUxFcEdzV0J4SEU5VXpRcFZzNmw2a3Q2?=
 =?utf-8?B?dU1BVHoxeElldWNOTmVTU0dPWXZvK28vN0hlQytBbHQrTmtkdndOVVQrRFRO?=
 =?utf-8?B?RzgwNTBZbjdvY0F1cmNqZ09tbzlSc2dyRTBmNUQvMlZSclRjWnFBQm9IcjFi?=
 =?utf-8?B?YWNPWnhGL3FXdERiYU14eUkwT1VmZ2JnUHhoRHNSaHhxYUtIRldhM0VRbW9X?=
 =?utf-8?B?cTNMYkxOVzdVUktwd1NyeThCMCtpWFlrQzlxT05ROXV1RnU2NHFzbll0bExj?=
 =?utf-8?B?ZnlYaXBEOWJZeUxSSUF4MEtRb3hqNGR6VmlqMjJic0tWcmd2VkNZWkJTelR4?=
 =?utf-8?B?WWtZVk1pZllHenkrT1hxNmc0elJWSlJROGlrc0VwK2VML2xSMkV2L29YaDlP?=
 =?utf-8?B?VFp5aHZZYmgvSGsyL1Z1Y1FSb2RodWVnR3hXMWJiV0FwdUVURlRWME9BVERw?=
 =?utf-8?B?Q2ZQVTAzaVJXdjBwSXNCT3dzTU9LbDBSUUlOZU9JSGRzZzJnNU01MkFRRmZm?=
 =?utf-8?B?SHVGYjhtRmpZaTVpTzRmUmtPQUpmY1RCU3BveXdCNDlNYUJwOHNucGorUWo5?=
 =?utf-8?B?VEVHaUpDU0xHMnhZWlB0NkN1YUtGb1JPdmRETWJxM2JjdUJyOEhyTXRiOTlR?=
 =?utf-8?B?Uk9FSmpNaEtRU29wMlBRdkZDS1hDY0dXdjdENnFhNURMT2hEY1hVcE55UlJO?=
 =?utf-8?B?eksxeUtEWUlRMndQd3FzY05QTnE3MkVvbFRrcXI0bGQ3bEQ4NU9YUnVCTEpH?=
 =?utf-8?B?dzNZM2ZFVVZpdkFOV0FjZEE1TUExS0Y1VW1EWnhTbHVITXlzOXUySU5zbVJx?=
 =?utf-8?B?bURyYncwK3poeUJNUWFqRk9JcHBITmpMcDZuYmRtcWtlcTFtZHNuL2dHbFpM?=
 =?utf-8?B?Rlp3eHh5VFRCSHdrbXQrSXhxNkd2SGpONWY3OFczNXZCbGp2NnU1dWc2bStB?=
 =?utf-8?B?T3VtUk14UEF6MVZ0TW9VZlBmdk8wcFZGZ1N4NnRiZnpjYUJ3a1RRbVJmMFls?=
 =?utf-8?B?Smdhd1BhWlFrN0JQb0JCZThRbFFqY0lDT1FIcGlrMU5TSUlCalZGWW5OK0FR?=
 =?utf-8?B?VHdvOXlodks3UzZnd0dvNm1NZlFyMkI2VDZpcVJ6dHhobmxXdTIyRk5VVU1B?=
 =?utf-8?B?RFVQdEVjWS9tTlBQY2RvTVJFRXhqQmdZWjk2dUVWczl4clgwb3pIZjUzRDFQ?=
 =?utf-8?B?QXV4U0RLNVR5YkFCQk1jOE8wRENRZ0ZWTlEzVkJ4eTJrcU1IdUVQZ0RWUW9T?=
 =?utf-8?B?dk5iR0ZzTE5UVzlFaXMvcEt1VmRxN1hOa2MxYkNudk1CTGE0WUVpSkhBMmdV?=
 =?utf-8?B?dzA3WVVkdGNXTFY3V3NtK3RwWWVHRXBQTUZ6cXNyR1FuZmtuY0JRZUhZb3Nq?=
 =?utf-8?B?WU9lUG9zd0J1dEVpTWNIL0psZjk1UTNlRXF1VG1MN3VMSjk3NFptZjFFYVQ0?=
 =?utf-8?B?aVQ5bFVVdnIyRDhVazFLcHl2UXVhSklmSTNvT1lPeFpxY25WMkRBbnZLeTJR?=
 =?utf-8?B?K1k5MnQ3MDg0QW83R1NKQ2J4YkY2NkwwQ1pvL2tpUUNyRUtJNmFhcjBTalk3?=
 =?utf-8?B?bHo4VXdEa0VqVjJ3ZEszblBhcWF2WG9hZG9kRlNaY1VJQ0haNE9hMUVaVUpk?=
 =?utf-8?B?blduYzJ4OGRKVHFxRnZ4bllUdTBraSsyMXBEa3phYVpDcmlGWlBRVW1aM2FF?=
 =?utf-8?B?WEdoVWFIbE45c0tRNW14ZTAvd1RmU3FlWUhOR2ZlTkZrY0ZsOFNieE1xN1lq?=
 =?utf-8?B?eUc3eTh0dmpDU2tkVnZhaTdWVGVIcDE0SmpEcFFCZml6blkxTHZCMWFlTjZO?=
 =?utf-8?B?bEtIQnBLOUQrY1k5WUZRZnpPMllSMFhJYzBkeno2QTlGUnNiSTRpK1B2dStJ?=
 =?utf-8?B?bnF5NW5RbFhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZuYzhkelF6VWJWd0dZUFJCc1pEa0dSWERSTHpBTnpLK2gwaURBNjZSLzZq?=
 =?utf-8?B?dHNUQU5rTm8ybFVpdFVDSmlnM1g2SU9FMDZsNE1ZU3h5R09JaHJvTVZFd2hM?=
 =?utf-8?B?dWZGVHBpVlkzd3I4aW9iN0grVFMwRStURW1mYUNkMENsVHhYeUZQRTVKUXRl?=
 =?utf-8?B?WkcyTEZIOEhSY01UWjFFK2ZjbUZ0MmE4bG5xTjRMclBidnpLd1Zib3d1c0tw?=
 =?utf-8?B?djcxV0VXQ2NTUmdwN3R1alMzbkduN1QvdnBmSWRSamJMUzcxNXhPcGZOTTFR?=
 =?utf-8?B?RFU2QVBWZmxSTkJYK1U2UUhOOU5VejJBWkF1MGc2VEkzQXZvY2hELzFkS2Ew?=
 =?utf-8?B?VW0rNWN1Rm9HY0p3ZHpjL0wrY09FMU8ybHZSVGM4NEM5TVVXK3Z5WUhnK1JR?=
 =?utf-8?B?Z2I2dys1MVdGS3haQ3NUWnU0UklXNDlJZjFnaHFmTHZPU0dQOWZUblFiODla?=
 =?utf-8?B?YzdKOVd6aWh1UjhrRzhHM21QQ0JtTTNUNExPaC9LajhhNDVOMjNNT3dvMnNK?=
 =?utf-8?B?Rjl6UUZTeFQyVVNCcEloZk01VHJjZm9ORU13aldJU3RxMldhVTVyT2RNa2Vo?=
 =?utf-8?B?L3l6cGhwcDZXaFgrNzdOWDFNU1Jkckp0NkRteWt2Vks5eEQ2R2x3WEVKVGgv?=
 =?utf-8?B?eHV1S05pM0Y2Y2l0UlJRUnlpcVlVTUhlajhOZ2RKNjJHaEdxbDR5SlIwaFVQ?=
 =?utf-8?B?d3hBQmR1Mk94cnB5RjM2TVo2bncxZUpkdlN2TWRZUFpvSjFUWnBGbGswOEEr?=
 =?utf-8?B?YTNrS3E4b3JRSVFONXE2WU5wUWdHcnp3RWM2Wmt0d3hTa3J2Y09EZHVvWHMx?=
 =?utf-8?B?aFdpeE5LL3hXWTNaSklnOStIYmVtRVFXNyszK3lHMy9KSVJCRUxCai9UUzRU?=
 =?utf-8?B?aXFaU0R6L056MnJUMFNGMDB6NXdXTzJ0Q2x2UUVZZnlVMzFuLzNkMW1aRXB2?=
 =?utf-8?B?V3lXR3ZmTzVvWWFkNlhGUzdUMjRNSlA4bWhaTnN5Q0hKSkMwRFRkVnUwVC9z?=
 =?utf-8?B?c2FwSlYzaDNBSGd3cXBEaW5RRlJvRTFDNjIyZU5jMTgzQk9WdFlYOVplYTB2?=
 =?utf-8?B?T1lhdmJiY3V1U1Ivb3VQNjJaWVJxWlQ2MEJyTlRRbU0rRGhaWHE0alF4RVlj?=
 =?utf-8?B?WXlUS3ZBZE5YZ01xL09OSWpQMis0eE5yVnNRZllNMHdHTGQ3dkpNdjhNVmQ3?=
 =?utf-8?B?M1Y1QWZJdkplcW00a1BRdE55SHpBL1duUUQvb2laNW56OWJFbm1KZVUvUEFS?=
 =?utf-8?B?enlsQU94RWwwZ0lGTmN3cmhML3Uwa1p5YTlxUG1hSjFIZ3JkMG1kSVcrZVRT?=
 =?utf-8?B?OXY1M2hkcjFmNzdOekRZeHltU1Q3ZmszNmdTcEJTamUzeEd2YzM4dGFSMGx0?=
 =?utf-8?B?Nk9aZmx2RWNYQWR6VG5DK3lqdWRPWU5DbHZmVFZzWWRMMndibXJCNnhLYmoy?=
 =?utf-8?B?akxpbnFCUFI2UFRlUXFwYjY1NkswcUk5Q094Z211R3pVRmoxSUF3RlUyOWxU?=
 =?utf-8?B?Ym96T2hXNGtOZytENjZxWkxjQTgrbmxCTTFHRFZ3NUZIV0tYaUZLM1V5OGpo?=
 =?utf-8?B?eHY3VEtIL0VVTG1ySXFYNTNyd0Y5ZHZSSmNsUTA3RU5jTjdhMWQ5NGNsVmhw?=
 =?utf-8?B?cDNZTUZHamlUM0lncnBjWU1JY3NLcDlWbnJSVFlQWlE0V1BQUFREd3owdWJi?=
 =?utf-8?B?KzJOLzZYc2JpempZcnFPa0VoZFI1TmRLa29WVXIzMzZxMUYxWUkzQXp5RWhL?=
 =?utf-8?B?Ty9zZ1hOZi9JR1kzUlJaV0JjNEE3YkZuNGJUSGlaSEhkREZNeHRqc09OMWMx?=
 =?utf-8?B?eGprdXNRSkozRUpGWTlXMUpSUVRuSlF1SXhaNmkxV0tMWmMwUVVNTmxKVEVa?=
 =?utf-8?B?TEJLckR1eUZVQnhCYmY4MSs4VDRzZmpHVDkzd05rekVFczBVUDFlV0owNndu?=
 =?utf-8?B?MDB4Q2MyYjFGVWlyYVMwMEFGSitTRmFrZUQxdCsvK3NsdnJ5ZW1OUURPdnNX?=
 =?utf-8?B?SjBsNUM5SU9OMnVtNWI2d3hkVmMrNUlnUmtndnYxY0NLRk5ZUksyaEdlT0xC?=
 =?utf-8?B?ejNWRjRzYXNlblZrVTJpL0YxM1J2K2plcHR5eWZPb1FJMWVId3RrVFNPSExi?=
 =?utf-8?Q?QXdWO8tKgNn0zNoqliBvDBp5z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394b63ba-cc07-4c85-4298-08ddf69844ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 09:46:40.7846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9tdQn9XFXSWRQa73oCeJ+mtIr1bMOrw7xgmxAQoEhLAR0dxATGfySoGDYUkb+L0eVMVRUi4uzXGgAn+gqGqNPATZkXHDjCY+2cq5SJZN/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8016
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYywNCg0KQWRkaW5nIGEgYml0IG1vcmUgY29udGV4dCBoZXJlOiBJJ2xsIGZvbGQg
dGhlc2UgZGV0YWlscyBpbnRvIHRoZSBjb21taXQgbG9nIGluIHRoZSBuZXh0IHJldmlzaW9uLg0K
DQpMVFBJIChMVkRTIFR1bm5lbGluZyBQcm90b2NvbCAmIEludGVyZmFjZSkgaXMgZGVmaW5lZCBp
biB0aGUgT0NQIERDLVNDTSAyLjAgc3BlY2lmaWNhdGlvbiAoc2VlIEZpZ3VyZSAyKToNCmh0dHBz
Oi8vd3d3Lm9wZW5jb21wdXRlLm9yZy9kb2N1bWVudHMvb2NwLWRjLXNjbS0yLTAtbHRwaS12ZXIt
MS0wLXBkZg0KDQpMVFBJIGlzIGEgcHJvdG9jb2wgYW5kIHBoeXNpY2FsIGludGVyZmFjZSBmb3Ig
dHVubmVsaW5nIHZhcmlvdXMgbG93LXNwZWVkIHNpZ25hbHMgYmV0d2VlbiB0aGUgSFBNIGFuZCBT
Q00uIEluIEZpZ3VyZSAyLCB0aGUgQVNUMjd4MCAobGVmdCkgaW50ZWdyYXRlcyB0d28gTFRQSSBj
b250cm9sbGVycywgYWxsb3dpbmcgaXQgdG8gY29ubmVjdCB0byB1cCB0byB0d28gQVNUMTcwMCBi
b2FyZHMuIE9uIHRoZSByaWdodCwgdGhlIEFTVDE3MDAgc2lkZSBjb25zb2xpZGF0ZXMgdGhlIEhQ
TSBGUEdBIGFuZCBvdGhlciBpbnRlcmZhY2VzIChHUElPL1VBUlQvSTJDL0kzQywgZXRjLikgb250
byBhIHNpbmdsZSBib2FyZC4NCg0KQmVjYXVzZSB0aGUgQVNUMTcwMCBleHBvc2VzIGFkZGl0aW9u
YWwgSS9PIGludGVyZmFjZXMgKEdQSU8vSTJDL0kzQywgZXRjLiksIHdlIHJlZmVyIHRvIGl0IGFz
IGFuICJJL08gZXhwYW5kZXIiLiBPbmNlIGNvbm5lY3RlZCBvdmVyIExUUEksIHRoZSBBU1QyN3gw
IGNhbiBjb250cm9sIG1vcmUgZG93bnN0cmVhbSBkZXZpY2VzLiBOb3RlIHRoYXQgdGhlIEFTVDE3
MDAgY29udGFpbnMgUk9NIGNvZGUgb25seSBhbmQgZG9lcyBub3Qgc3VwcG9ydCBmaXJtd2FyZSB1
cGRhdGVzLCBzbyBpdHMgYmVoYXZpb3IgaXMgZml4ZWQuDQoNCldoZW4gdXNpbmcgdGhlIEFTVDE3
MDAsIGluY2x1ZGUgdGhlIGZvbGxvd2luZyBEVFMgc25pcHBldHMgdG8gZW5hYmxlIHRoZSBhZGRp
dGlvbmFsIGludGVyZmFjZXM6DQpodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvbGlu
dXgvYmxvYi9hc3BlZWQtbWFzdGVyLXY2LjYvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXNw
ZWVkLWx0cGkwLmR0c2kNCmh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9i
bG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQt
bHRwaTEuZHRzaQ0KDQpJZiBhbnkgaW5mb3JtYXRpb24gaXMgbWlzc2luZywgcGxlYXNlIGxldCBt
ZSBrbm93IGFuZCBJIHdpbGwgZG8gbXkgYmVzdCB0byBwcm92aWRlIGZ1cnRoZXIgZGV0YWlscy4N
Cg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IFNlcHRlbWJlciAxNywgMjAyNSA0OjIyIFBNDQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBh
c3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8
bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47
IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFy
bUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDDQo+IGhlcmUgPHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtTUEFNXSBbUEFUQ0ggdjEgMS82XSBody9hcm0vYXNwZWVkOiBBZGQg
J2lvZXhwcy1udW0nDQo+IHByb3BlcnR5IGZvciBBU1QyN3gwDQo+IA0KPiBIZWxsbyBLYW5lLA0K
PiANCj4gT24gOS8xNy8yNSAwMzozMSwgS2FuZSBDaGVuIHdyb3RlOg0KPiA+IEZyb206IEthbmUt
Q2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gQVNUMjd4MCBwbGF0
Zm9ybXMgY2FuIGF0dGFjaCB1cCB0byB0d28gQVNUMTcwMCBJTyBleHBhbmRlciBib2FyZHMuDQo+
IA0KPiB3aGF0IGFyZSBBU1QxNzAwIElPIGV4cGFuZGVycyA/IEhvdyBhcmUgdGhleSBhdHRhY2hl
ZCB0byB0aGUgbWFpbiBib2FyZCA/DQo+IG9uIHdoaWNoIGJ1cyA/DQo+IA0KPiA+IEludHJvZHVj
ZSB0aGUgJ2lvZXhwcy1udW0nIHByb3BlcnR5IHRvIGxldCB1c2VycyBzcGVjaWZ5IGhvdyBtYW55
IElPDQo+ID4gZXhwYW5kZXJzIHRvIGluc3RhbnRpYXRlIGZvciBhIGdpdmVuIG1hY2hpbmUuDQo+
ID4gPiBUaGlzIGVuYWJsZXMgbW9kZWxpbmcgYm9hcmQgdmFyaWFudHMgdGhhdCBzaGlwIHdpdGgg
MC0yIGV4cGFuZGVycy4NCj4gPg0KPiA+IE5vdGU6IEFTVDI1MDAgYW5kIEFTVDI2MDAgZG8gbm90
IHN1cHBvcnQgSU8gZXhwYW5kZXJzOyB0aGlzIHByb3BlcnR5DQo+ID4gaXMgb25seSBhdmFpbGFi
bGUgb24gQVNUMjd4MCBtYWNoaW5lcy4NCj4gPg0KPiA+IENvbW1hbmQgdXNhZ2U6DQo+ID4gYGBg
DQo+ID4gLi9xZW11LXN5c3RlbS1hYXJjaDY0IC1NIGFzdDI3MDBhMS1ldmIsaW9leHBzLW51bT0y
IFwNCj4gPiAgICAtZHJpdmUgaW1hZ2UtYm1jLGZvcm1hdD1yYXcsaWY9bXRkIFwNCj4gPiAgICAu
Li4NCj4gPiBgYGANCj4gDQo+IEkgd291bGQgcHJlZmVyIHRoZXNlIGNoYW5nZXMgbW9kaWZ5aW5n
IHRoZSB1YXBpIHRvIGNvbWUgYXQgdGhlIGVuZCB3aGVuIHRoZQ0KPiBtb2RlbGluZyBpcyBkb25l
Lg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IC0t
LQ0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oIHwgIDIgKysNCj4gPiAgIGh3L2Fy
bS9hc3BlZWQuYyAgICAgICAgICAgICB8IDQ5DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBiL2luY2x1ZGUv
aHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGluZGV4IDIxN2VmMGVhZmQuLjc3MjYzY2M2ZWMgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gKysrIGIvaW5j
bHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gQEAgLTQ5LDYgKzQ5LDcgQEANCj4gPiAgICNk
ZWZpbmUgQVNQRUVEX01BQ1NfTlVNICA0DQo+ID4gICAjZGVmaW5lIEFTUEVFRF9VQVJUU19OVU0g
MTMNCj4gPiAgICNkZWZpbmUgQVNQRUVEX0pUQUdfTlVNICAyDQo+ID4gKyNkZWZpbmUgQVNQRUVE
X0lPRVhQX05VTSAyDQo+ID4NCj4gPiAgIHN0cnVjdCBBc3BlZWRTb0NTdGF0ZSB7DQo+ID4gICAg
ICAgRGV2aWNlU3RhdGUgcGFyZW50Ow0KPiA+IEBAIC0xMDMsNiArMTA0LDcgQEAgc3RydWN0IEFz
cGVlZFNvQ1N0YXRlIHsNCj4gPiAgICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgbHRwaTsN
Cj4gPiAgICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUganRhZ1tBU1BFRURfSlRBR19OVU1d
Ow0KPiA+ICAgICAgIEFzcGVlZEFQQjJPUEJTdGF0ZSBmc2lbMl07DQo+ID4gKyAgICB1aW50OF90
IGlvZXhwX251bTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgICNkZWZpbmUgVFlQRV9BU1BFRURfU09D
ICJhc3BlZWQtc29jIg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0v
YXNwZWVkLmMgaW5kZXgNCj4gPiBjMzFiYmU3NzAxLi41OTNjYjg3YmZlIDEwMDY0NA0KPiA+IC0t
LSBhL2h3L2FybS9hc3BlZWQuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0z
Miw2ICszMiw3IEBADQo+ID4gICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPiA+ICAgI2luY2x1
ZGUgImh3L3FkZXYtY2xvY2suaCINCj4gPiAgICNpbmNsdWRlICJzeXN0ZW0vc3lzdGVtLmgiDQo+
ID4gKyNpbmNsdWRlICJxYXBpL3Zpc2l0b3IuaCINCj4gPg0KPiA+ICAgc3RhdGljIHN0cnVjdCBh
cm1fYm9vdF9pbmZvIGFzcGVlZF9ib2FyZF9iaW5mbyA9IHsNCj4gPiAgICAgICAuYm9hcmRfaWQg
PSAtMSwgLyogZGV2aWNlLXRyZWUtb25seSBib2FyZCAqLyBAQCAtNDksNiArNTAsNyBAQA0KPiA+
IHN0cnVjdCBBc3BlZWRNYWNoaW5lU3RhdGUgew0KPiA+ICAgICAgIGNoYXIgKmZtY19tb2RlbDsN
Cj4gPiAgICAgICBjaGFyICpzcGlfbW9kZWw7DQo+ID4gICAgICAgdWludDMyX3QgaHdfc3RyYXAx
Ow0KPiA+ICsgICAgdWludDMyX3QgaW9leHBfbnVtOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgLyog
T24gMzItYml0IGhvc3RzLCBsb3dlciBSQU0gdG8gMUcgYmVjYXVzZSBvZiB0aGUgMjA0NyBNQiBs
aW1pdCAqLw0KPiA+IEBAIC00NDQsNiArNDQ2LDkgQEAgc3RhdGljIHZvaWQgYXNwZWVkX21hY2hp
bmVfaW5pdChNYWNoaW5lU3RhdGUNCj4gKm1hY2hpbmUpDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE9CSkVDVChnZXRfc3lzdGVtX21lbW9yeSgpKSwNCj4gJmVycm9yX2Fib3J0
KTsNCj4gPiAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGJtYy0+c29jKSwg
ImRyYW0iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QobWFjaGlu
ZS0+cmFtKSwNCj4gJmVycm9yX2Fib3J0KTsNCj4gPiArDQo+ID4gKyAgICBibWMtPnNvYy0+aW9l
eHBfbnVtID0gYm1jLT5pb2V4cF9udW07DQo+ID4gKw0KPiA+ICAgICAgIGlmIChhbWMtPnNkaGNp
X3dwX2ludmVydGVkKSB7DQo+ID4gICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBibWMtPnNvYy0+
c2RoY2kubnVtX3Nsb3RzOyBpKyspIHsNCj4gPg0KPiA+IG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9v
bChPQkpFQ1QoJmJtYy0+c29jLT5zZGhjaS5zbG90c1tpXSksDQo+ID4gQEAgLTE0ODYsNiArMTQ5
MSw0OSBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfbWFjaGluZV9hc3QyNjAwX2NsYXNzX2VtbWNf
aW5pdChPYmplY3RDbGFzcyAqb2MpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiU2V0IG9yIHVuc2V0IGJvb3QNCj4gZnJvbSBFTU1DIik7DQo+ID4gICB9
DQo+ID4NCj4gPiArI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVl
ZF9nZXRfaW9leHBzX251bShPYmplY3QgKm9iaiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFZpc2l0b3IgKnYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdm9pZCAqb3BhcXVlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKSB7DQo+ID4gKyAgICBBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYyA9
IEFTUEVFRF9NQUNISU5FKG9iaik7DQo+ID4gKw0KPiA+ICsgICAgdmlzaXRfdHlwZV91aW50MzIo
diwgbmFtZSwgJmJtYy0+aW9leHBfbnVtLCBlcnJwKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQgYXNwZWVkX3NldF9pb2V4cHNfbnVtKE9iamVjdCAqb2JqLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVmlzaXRvciAqdiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFcnJvciAqKmVycnApIHsNCj4gPiArICAgIHVpbnQzMl90IHZhbDsNCj4g
PiArICAgIEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jID0gQVNQRUVEX01BQ0hJTkUob2JqKTsNCj4g
PiArDQo+ID4gKyAgICBpZiAoIXZpc2l0X3R5cGVfdWludDMyKHYsIG5hbWUsICZ2YWwsIGVycnAp
KSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlm
ICh2YWwgPiBBU1BFRURfSU9FWFBfTlVNKSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiSU9FWFAgbnVtYmVyIGlzIGV4Y2VlZGVkOiAlZCIsIHZhbCk7DQo+ID4gKyAgICAgICAgcmV0
dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGJtYy0+aW9leHBfbnVtID0gdmFsOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX21hY2hpbmVfYXN0
MTcwMF9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYykgew0KPiA+ICsgICAgb2JqZWN0X2NsYXNz
X3Byb3BlcnR5X2FkZChvYywgImlvZXhwcy1udW0iLCAidWludDMyIiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYXNwZWVkX2dldF9pb2V4cHNfbnVtLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhc3BlZWRfc2V0X2lvZXhwc19udW0sDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpOyB9ICNlbmRpZg0KPiA+ICsNCj4g
PiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9j
LCBjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMg
PSBNQUNISU5FX0NMQVNTKG9jKTsgQEAgLTIwMzIsNiArMjA4MCw3DQo+IEBADQo+ID4gc3RhdGlj
IHZvaWQgYXNwZWVkX21hY2hpbmVfYXN0MjcwMGExX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNz
ICpvYywNCj4gPiAgICAgICBtYy0+YXV0b19jcmVhdGVfc2RjYXJkID0gdHJ1ZTsNCj4gPiAgICAg
ICBtYy0+ZGVmYXVsdF9yYW1fc2l6ZSA9IDEgKiBHaUI7DQo+ID4gICAgICAgYXNwZWVkX21hY2hp
bmVfY2xhc3NfaW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCj4gPiArICAgIGFzcGVlZF9tYWNoaW5l
X2FzdDE3MDBfY2xhc3NfaW5pdChvYyk7DQo+ID4gICB9DQo+ID4gICAjZW5kaWYNCj4gPg0KDQo=

