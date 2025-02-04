Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA9AC02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 03:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf9Wn-0002kU-GR; Mon, 03 Feb 2025 22:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tf9Wj-0002jk-0A; Mon, 03 Feb 2025 22:23:05 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tf9Wg-0007KG-7x; Mon, 03 Feb 2025 22:23:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Emz0tJXYkz14sTPKDaSffpPfCs92+B3WXgGCyhFFQ2BqTKKCevnc4UWHlEFs5mwQlUvXCmykaPZSp7/1Je+geJEcG1musXUo2XId+9eo6BzCQFxAsYgmeVCaARlr7l2nTmX+3zSQCFkX1SFfZL+SfXOqqWBGVJQD5wcyeiE5aNlYphZwkRHuoWmTu7JdS/PsM8ZxQWd+bSMRpDmZDteyo/Ge0Qp/K5XzIBTonE/TJyD8BqTVlxl0tT53CxCsiPAZi2F31nwQPzWCYvHdtqGx2p0lP2c2AvLG7a2iCTTNFWjGxyMxl0Mxii2ABBbnqeEKxY0vy8SA2ODGjAOc/O6fWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP+R202+Xf8EDEMat+i8zFMqMs0BoDg0+T18HJ9wsTo=;
 b=fuTYG80U/zny1bI2oMjXFPvqC8IGDt9LM6BG5byb74AYXkbNJQyPkc2LIZyHVqU/6htXaluEtGEeCEmalGPbUCK28gJajVfDypEXc//ZVKqa5ViI6TTfGaIG7fEh8rjOiHYuPoHn02vDkJLxzMJfTKu7F5yCt+OilYoihoVjiIjyUNKbs3bEVjfla+couEhMCU36a7sPNY2EpTu1P/MXjZa7zR5hs4aKuHX66/sA9rqgIM4UBELd/I4f4HcoGMXkSSHNVtJ3FpAqFUrKrqTOhbM7H7/sE/Qzqm1XJJLzrY/VtL9XYwd9WI9K+gBudOfw7jX9gqNJ6HqK6OAgeU9luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP+R202+Xf8EDEMat+i8zFMqMs0BoDg0+T18HJ9wsTo=;
 b=A5cRlqq43xySoeeJ5fNeYCifR4q3I+gJMECH7fKsJF1/r2zq1g8ko89/2WSR9U49UO146UY5AGZ4moKl3IBMNqE03xqQ/OGvY3aLd2Q6xrquzs1Np4UG7YwxAlgR39t5pKESJDKPmcc01Vh+pa2u/lsqwcXlbqff+3f+xEFCZVAGnuIZjp+F9eWxycTH7j6mgHDXZ7mfR9c6KHpdy3FSCBJM1lVPiIMkWQ9gOUe6iLY94iVYyB+rdcUcNIzdWpGLJRtAftgniMLVp6pWnzxw3ZbVPtQmouzZQYo8p5utWzYxW+9eD1YAaygyQY2AK3SntEZAqt9pFs7h5pmmcBwL7Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5609.apcprd06.prod.outlook.com (2603:1096:400:31e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.8; Tue, 4 Feb 2025 03:22:47 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Tue, 4 Feb 2025
 03:22:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Jinjie Ruan <ruanjinjie@huawei.com>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
Thread-Topic: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
Thread-Index: AQHatkJWGs9xLfQ5AU+zfhhp5GQ22rMw5oUAgAXDrjCAAAX7UIAAmBuAgACy9wA=
Date: Tue, 4 Feb 2025 03:22:47 +0000
Message-ID: <SI2PR06MB5041FEE03F41C70EECA37654FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <20240604054438.3424349-14-jamin_lin@aspeedtech.com>
 <ffafbec0-db25-478b-8eba-39162f9bce0d@linaro.org>
 <SI2PR06MB5041F84077718CE5A58B8F54FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB50417A6E45521504224146A9FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <1e8f3190-cf23-4eeb-a5fd-189f61a834b6@linaro.org>
In-Reply-To: <1e8f3190-cf23-4eeb-a5fd-189f61a834b6@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5609:EE_
x-ms-office365-filtering-correlation-id: f4bcc036-2b6e-4b3d-ff6c-08dd44cb3270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YUJUVmpFTC9ZWGdFcngvTUNBMWcwQWVQZjhHVlF0Yi9MNEFIQ1JzK1dvVkdv?=
 =?utf-8?B?dDVidUtPaGVzUzhtV1U5TkNqSFlVTDhxamhyTHc3WUJqYzZKbHA1Z0FIN1NH?=
 =?utf-8?B?ZEd6bHc1WHowS3VVWUpYVG5ic0xvVWp3SWZaSjh3TjBoTlEzUW1DZFdyNGFK?=
 =?utf-8?B?Zis5dStkYno1R0F3N09iUlgxdmdHMVJ2RFRqTmJRRU92aUx2a0svb2lSNm41?=
 =?utf-8?B?VWlYNG8vSyswL2JyQXJxMWlMY241R05VTnBNeVhnVnlpcEJUN1BwS2dTazVj?=
 =?utf-8?B?b09uS2p0dVBYZllRdmkxR2JaQnZQSjFrRks1bi80VEdUY2lMMG9jODNNRjhT?=
 =?utf-8?B?YnBWSGhXaUg0RG9BNlczaitZckh5VSt3WGFHcDRGUnFGSkNheGJEL3p5Rm9G?=
 =?utf-8?B?b0kwR0plaVlidDZrMzZXU2FxWjg0R05UdUJ6L0s5MDQySmlFWEVOZWxjNEhN?=
 =?utf-8?B?Y0g5eVBmaUNaZEh5VUNzdzJqQjc0NGl2SkxkbUo5dkJoUXRGZCs0eUEwRWRN?=
 =?utf-8?B?eVB1SWkwYWtobFJKa2x1bXBUYU1pNTErV3I0UHdqd3NSb3Rwd2tqNWs3cHZ2?=
 =?utf-8?B?WlBycmhwb1NTQk9wQk1iY3BVQnRFL0NhTWVrWEN6N2Fwdk4xOVBydWMyOFQv?=
 =?utf-8?B?aEdROG9OZ3E4MElVSHdyYWV0ZSsrbUs4QVJ4SmptbjZMUVJBR2xVZGkyN3Fu?=
 =?utf-8?B?VXA2cmNKZUdHMDliNnR3Vng3NE9CallQQ1VxaHpNRGRrb3ZncVMrQmhpWitm?=
 =?utf-8?B?NmM5M1d5aU01K0o4cWpRV0t5R0Y1RUMraFNXTktwbjJmcCtEaTlkaTlGMzBH?=
 =?utf-8?B?SjhwdkhBamRsc2ZqQk1IM2Y1SFJBS3B5V1JTb3JoQjBrQ2hITVdHMytlWjF2?=
 =?utf-8?B?NW9vOVZtRkJkSlBCZ0dwaG9xcGtLQnk4aW1NRVdVRk40aFV1cE5SYTJ0cnJN?=
 =?utf-8?B?S2hVM0FtU3l6M1RBQUxzWWhaRE00K3dwL05jeGZ6Z096S2xsUU0vV0dIOVQ5?=
 =?utf-8?B?N3BCSENVNVAzRWxLaUpheFBSUDYrbkU2V2dMVm5uSFFsNzluRlJUaExYVXJI?=
 =?utf-8?B?dFVHSnd1cEdlVDNoRDBsQ04zMEJVYmtFT3FuMW9tQnhrWFkycXlEcTI1NkJm?=
 =?utf-8?B?YVZTV25RQURTbUNZQTNGOEtVemY0OVkvVHl4bFVQRW92ZTlwRnlaUUd6YzRy?=
 =?utf-8?B?ZXdGdkRiemtKem5aaHJwN0hwZ1U2bkF0MnZCb0ZKc1JBMG1zaTJmU2JFYjhW?=
 =?utf-8?B?bXZtVGxJc1ZBdmpTTXNXQW1lRnlQbGF0c1FVWEFDQWFJOHpJZXVjZGdqWjQv?=
 =?utf-8?B?NHVMMFpIYTBEb0lyVG9ONmhPVGZGVEFvUGl3c1p1WHhMRnVYc3lxeEZScWk2?=
 =?utf-8?B?S05jMG45NjZzUUlxZ1d2Q0srSjFLSlVyNXRFUEh6b3QyWWJTWWIrbkgzZGJm?=
 =?utf-8?B?TWsreWZ0NDZVWTZGRWV1aTdQMjVoeFpVY08zbXhoM2h0NmV1WWlYUTY0NGNY?=
 =?utf-8?B?M0k5dkdwdVN5Tms3Q2FoK0pLMWZXcnljQk02QVU0TU1qN0grZnFlaGsxR3ZB?=
 =?utf-8?B?YzNwdEpxeU1ldE9TYUNHZVlJTzZlR1MxcG9nZFhEbTJiNVcxTHB0aVArcXcz?=
 =?utf-8?B?UnpWbEtYNFpWZ2NLVFdJQTFXOWNZWm5NQlF2b0FnVU5hYUVRRjl2N2x2YTBH?=
 =?utf-8?B?RkFrallwZmpzTytlbDlZTHowamxwWThBdG1xL0RCNndOMC91N2JxcDRibVJm?=
 =?utf-8?B?TnI5UTdvS2MvUWFCeUNrN0J3akVnMDRyVmRlczRGT0loNjkyOFF3c3gvMnAy?=
 =?utf-8?B?WDllSmdkYmRXY2tJd1RnS0lPY3IzRE9KWDJpT0N1cFhWSFJJekRwU2gvYXRH?=
 =?utf-8?B?Z2c0Wldlcmg2dkROQnRsdEttanpRbWducTZTYXk0OG45dEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtVNG5Xay9QT00vS0dRcFA0NFFkODZkVDhUbm5hOEJqUU00YVJYSmRWNmdD?=
 =?utf-8?B?NFgyZTFxU0FVb0JlSjNFZXBWZ002Y2cvOGtMcnJLZXRvaFdielNQemp3WEY4?=
 =?utf-8?B?R1oyNXBIMDJJNG1uUXZIQjAyaEUwMmdZT0RaWjJPd1d3c0h4OXVBRVBQTGNp?=
 =?utf-8?B?TG9pRytkNkNjdnFxdUxYUHhxVG53YWJaM0FuZXRXL2p3UnNaM3g1d2ZPK3E3?=
 =?utf-8?B?aGdMWmQ5MDNKZDdMQnBmamNvVGhXZnhlbklsTGFVMkxSUzlzZktkT1FNM204?=
 =?utf-8?B?aGxHSnMxZW1BMC9ZYnpTT29zL1NHZFZhY2pmcHFBQjRlUVB4MUxDVDVxZjE3?=
 =?utf-8?B?VTQ4U216Y2RwOHloaVYrOEVhM29tek9hQ3pIRlFTNGlpUVVHR0ZnaTJramhm?=
 =?utf-8?B?TUlpSDdzUlVLUVdYajJNc2o0bnd2dU9IbzBWWVRreW9yYVF0RjUwdE5DaHV5?=
 =?utf-8?B?V0tpbnFjMUJzM2Y1eHBQUkV3UWlPTnRNNVJUQk9pdWxLeFFFcmlLVW1tVzYw?=
 =?utf-8?B?NjQyVUFmUEdoYjdieGo5cEpZVXhzSEFTeW41SDRPSkYxR21WZEtkYWMyRE0w?=
 =?utf-8?B?UVQzRXlSUW4wMmttOFJpTkIybERUTy9XRzEwRDlpS2F2WXVXTUhEREhXNnYy?=
 =?utf-8?B?MUE3aUJwSWtodUNRbmh1ak9DaFZWMGxmTnIwTHI2OEEvZVRVcm02SzdlUnV5?=
 =?utf-8?B?ZXZzbHdHaHJDM0ZzNGNLaFNIbm1STDQrUTFONzFqOXAxMUh0SHJWdHFLSGRu?=
 =?utf-8?B?SjBkT2NDd3ArUmxEekpJc2VKN2IrbzhJbGNscE1xV2hRK05JeW5oaERoYTZJ?=
 =?utf-8?B?NTVoZUpIa2U0cHZwSG1mZmhzUHJtNWliNWIrdmo0bmhtUTMwWjBGMEtnTGJq?=
 =?utf-8?B?SFNPMW9MUTlhZ093aXc0WmI3dFdlcmx3WnQ3a2NVWXJoZFc5NCtmdWk4cldT?=
 =?utf-8?B?ZythcEo3anl2enBSNHZOcDQxUEUrb3p3cWxVbWF4aDVyZ1BJVDU1bkU2NU1U?=
 =?utf-8?B?NU5CenpIUnU0eUxBRjU0YnNLRG1kWFQrQWhLNW0zMjBIWlFIMGZjNVZRN3U1?=
 =?utf-8?B?Z29rK0VTRUFwVFNDQU1STTlIWHdpL0hHRG9jM1ZldVRtT2RocWZaY0t3ZXFP?=
 =?utf-8?B?bjNmanJaWmZqYVJUaDdGaTBLaDlnMmUwcWNDNUJQanVBNjdad3pOV25XN0dV?=
 =?utf-8?B?OEpsUW82ZTUrNVA2RHlCdy9TWWphR2h6K20zditmR3dpZkdXMERrT3RhdTFk?=
 =?utf-8?B?OXVzZlJkMTlBcEU2eGFKdXZhbmFTay8zQSs3OFhBVFErcEhqV2JLNjRXbzJZ?=
 =?utf-8?B?RFk0UW1RUlJUL1kzWFA5YWI1RURnWGxqNjhEeUlTRDBkSzBra1hTdUt6dksr?=
 =?utf-8?B?YWFLR2xvQkF0VXI1a3h1M1p6VDhVZ1BzZFhsOGNzQm12NFZCa3h3allJVnIy?=
 =?utf-8?B?S3ZNWDdLNGZia0dFMGt4RG5uNlVQL2x6Tkp2REJQOXJPQ2pBVDdsTmFuVmJN?=
 =?utf-8?B?N0p1TDFxVDZpcjNacU5VMmt3Si8vTm04ak1kclRWTnJqQU95RGdHV2d2SUtB?=
 =?utf-8?B?N1JUTkxiNlpxTEgrekNRb3R0TFViOGVNNkNlTi9yYk56RFRrU0I0OWgvMzRh?=
 =?utf-8?B?dHVJVEdMY1VVV285NlhueUZicmdOaXlUT1ZLSjE1eHFEemV4dnFIS3ZhaGk4?=
 =?utf-8?B?Q3hpT0o0MnFQeENZanVTNW92a3lEQ2Npam5lOG15VW04eFJMMkNaNHd2OE5y?=
 =?utf-8?B?TExGbzdTMVh0aHRxcG9veHN0VnYzSEd5ZXRJczFsRzFKMXhPdjVmcGxFSDZX?=
 =?utf-8?B?Y1hTRjdBSWQxRGxoSWV2dnJJOWhyN2xJTXNsNzJwa3NvYkd2SEd2WlpRNHJK?=
 =?utf-8?B?RU05anFoMnFJbEt3b09uTGwrOW1WYWNMek5lR1d2Vi9qRVpqRmJ4Tzdha1hx?=
 =?utf-8?B?WmVlWnpSc0lBZTlaVjNvRlBzWURQL1k5dXhWbGlkeEZDb2gxZEZ2VnFDalBJ?=
 =?utf-8?B?MkhFRFA2S0Rrc3lVU0NUTmxzK0VJY2NZWTJmeEI5VGRuOEE4b2oySGUvTVRN?=
 =?utf-8?B?UHRGdG5GQytYb2w0N0JxVGpSOHhINUlkYTViNXVtd2hIZUt0eVVLTnBNRTB3?=
 =?utf-8?Q?n5tveyizgBp1d/YJI8jGxxhoA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bcc036-2b6e-4b3d-ff6c-08dd44cb3270
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 03:22:47.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99kA8hU5XhVSZZDillnXjPdBCH4bRq3Dt0tTk1yx96XX9BLn5Mmmx7392f7UI7AFgZRHLrSo/SYtQHU22wT8NEd9ZEHSChnzRwebc4KrqbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5609
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCj4gRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA0LCAyMDI1IDEyOjQxIEFNDQo+
IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAa2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pjsg
Sm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFsaXN0YWlyDQo+IEZyYW5jaXMgPGFsaXN0
YWlyQGFsaXN0YWlyMjMubWU+OyBDbGViZXIgUm9zYSA8Y3Jvc2FAcmVkaGF0LmNvbT47IFdhaW5l
cg0KPiBkb3MgU2FudG9zIE1vc2NoZXR0YSA8d2FpbmVyc21AcmVkaGF0LmNvbT47IEJlcmFsZG8g
TGVhbA0KPiA8YmxlYWxAcmVkaGF0LmNvbT47IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1h
cm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+OyBKaW5qaWUgUnVhbg0KPiA8cnVhbmppbmppZUBodWF3ZWkuY29tPg0K
PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4g
PHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEz
LzE3XSBhc3BlZWQvc29jOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+IA0KPiBPbiAzLzIvMjUgMDg6
NDMsIEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBQaGlsaXBwZSwNCj4gPg0KPiA+PiBGcm9tOiBK
YW1pbiBMaW4NCj4gPj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAzLCAyMDI1IDM6MjkgUE0NCj4g
Pj4gVG86IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz47IEPDqWRy
aWMgTGUgR29hdGVyDQo+ID4+IDxjbGdAa2FvZC5vcmc+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcNCj4gPj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25z
dHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+ID4+IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBDbGViZXIgUm9zYQ0KPiA+PiA8
Y3Jvc2FAcmVkaGF0LmNvbT47IFdhaW5lciBkb3MgU2FudG9zIE1vc2NoZXR0YQ0KPiA+PiA8d2Fp
bmVyc21AcmVkaGF0LmNvbT47IEJlcmFsZG8gTGVhbCA8YmxlYWxAcmVkaGF0LmNvbT47IG9wZW4N
Cj4gPj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpB
bGwgcGF0Y2hlcyBDQyBoZXJlDQo+ID4+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBKaW5qaWUg
UnVhbiA8cnVhbmppbmppZUBodWF3ZWkuY29tPg0KPiA+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVl
QGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPj4gPHl1bmxpbi50YW5nQGFzcGVlZHRl
Y2guY29tPg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIIHY1IDEzLzE3XSBhc3BlZWQvc29jOiBB
ZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4+DQo+ID4+IEhpIFBoaWxpcHBlLA0KPiA+Pg0KPiA+Pj4g
RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiA+Pj4g
U2VudDogVGh1cnNkYXksIEphbnVhcnkgMzAsIDIwMjUgMTE6MTQgUE0NCj4gPj4+IFRvOiBKYW1p
biBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEPDqWRyaWMgTGUgR29hdGVyDQo+ID4+
PiA8Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PjsgQW5kcmV3DQo+ID4+PiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkNCj4gPj4+IDxqb2VsQGptcy5pZC5hdT47IEFsaXN0YWlyIEZyYW5jaXMgPGFs
aXN0YWlyQGFsaXN0YWlyMjMubWU+OyBDbGViZXINCj4gPj4+IFJvc2EgPGNyb3NhQHJlZGhhdC5j
b20+OyBXYWluZXIgZG9zIFNhbnRvcyBNb3NjaGV0dGENCj4gPj4gPHdhaW5lcnNtQHJlZGhhdC5j
b20+Ow0KPiA+Pj4gQmVyYWxkbyBMZWFsIDxibGVhbEByZWRoYXQuY29tPjsgb3BlbiBsaXN0OkFT
UEVFRCBCTUNzDQo+ID4+PiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0
Y2hlcyBDQyBoZXJlDQo+ID4+PiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgSmluamllIFJ1YW4g
PHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT4NCj4gPj4+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNw
ZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA+Pj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2gu
Y29tPg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxMy8xN10gYXNwZWVkL3NvYzogQWRk
IEFTVDI3MDAgc3VwcG9ydA0KPiA+Pj4NCj4gPj4+IEhpIEphbWluLA0KPiA+Pj4NCj4gPj4+IE9u
IDQvNi8yNCAwNzo0NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IEluaXRpYWwgZGVmaW5pdGlv
bnMgZm9yIGEgc2ltcGxlIG1hY2hpbmUgdXNpbmcgYW4gQVNUMjcwMCBTT0MNCj4gPj4+PiAoQ29y
dGV4LWEzNQ0KPiA+Pj4gQ1BVKS4NCj4gPj4+Pg0KPiA+Pj4+IEFTVDI3MDAgU09DIGFuZCBpdHMg
aW50ZXJydXB0IGNvbnRyb2xsZXIgYXJlIHRvbyBjb21wbGV4IHRvIGhhbmRsZQ0KPiA+Pj4+IGlu
IHRoZSBjb21tb24gQXNwZWVkIFNvQyBmcmFtZXdvcmsuIFdlIGludHJvZHVjZSBhIG5ldyBhc3Qy
NzAwDQo+ID4+Pj4gY2xhc3Mgd2l0aCBpbnN0YW5jZV9pbml0IGFuZCByZWFsaXplIGhhbmRsZXJz
Lg0KPiA+Pj4+DQo+ID4+Pj4gQVNUMjcwMCBpcyBhIDY0IGJpdHMgcXVhZCBjb3JlIGNwdXMgYW5k
IHN1cHBvcnQgOCB3YXRjaGRvZy4NCj4gPj4+PiBVcGRhdGUgbWF4aW11bSBBU1BFRURfQ1BVU19O
VU0gdG8gNCBhbmQgQVNQRUVEX1dEVFNfTlVNIHRvDQo+IDguDQo+ID4+Pj4gSW4gYWRkaXRpb24s
IHVwZGF0ZSBBc3BlZWRTb2NTdGF0ZSB0byBzdXBwb3J0IHNjdWlvLCBzbGksIHNsaWlvIGFuZCBp
bnRjLg0KPiA+Pj4+DQo+ID4+Pj4gQWRkIFRZUEVfQVNQRUVEMjdYMF9TT0MgbWFjaGluZSB0eXBl
Lg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIFNETUMgY29udHJvbGxlciBpcyB1bmxvY2tlZCBhdCBTUEwg
c3RhZ2UuDQo+ID4+Pj4gQXQgcHJlc2VudCwgb25seSBzdXBwb3J0cyB0byBlbXVsYXRlIGJvb3Rp
bmcgc3RhcnQgZnJvbSB1LWJvb3Qgc3RhZ2UuDQo+ID4+Pj4gU2V0IFNETUMgY29udHJvbGxlciB1
bmxvY2tlZCBieSBkZWZhdWx0Lg0KPiA+Pj4+DQo+ID4+Pj4gSW4gSU5UQywgZWFjaCBpbnRlcnJ1
cHQgb2YgSU5UIDEyOCB0byBJTlQgMTM2IGNvbWJpbmVzIDMyIGludGVycnVwdHMuDQo+ID4+Pj4g
SXQgY29ubmVjdCBHSUNJTlQgSVJRIEdQSU8tT1VUUFVUIHBpbnMgdG8gR0lDIGRldmljZSB3aXRo
IGlycSAxMjggdG8NCj4gMTM2Lg0KPiA+Pj4+IEFuZCwgaWYgYSBkZXZpY2UgaXJxIGlzIDEyOCB0
byAxMzYsIGl0cyBpcnEgR1BJTy1PVVRQVVQgcGluIGlzDQo+ID4+Pj4gY29ubmVjdGVkIHRvIEdJ
Q0lOVCBvci1nYXRlcyBpbnN0ZWFkIG9mIEdJQyBkZXZpY2UuDQo+ID4+Pj4NCj4gPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+Pj4g
LS0tDQo+ID4+Pj4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgIHwgNTYzDQo+ID4+PiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4+PiAgICBody9hcm0vbWVz
b24uYnVpbGQgICAgICAgICAgfCAgIDEgKw0KPiA+Pj4+ICAgIGluY2x1ZGUvaHcvYXJtL2FzcGVl
ZF9zb2MuaCB8ICAyOCArLQ0KPiA+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgNTkwIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2Fy
bS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiArc3RhdGljIGJvb2wgYXNw
ZWVkX3NvY19hc3QyNzAwX2dpY19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yDQo+ID4+
Pj4gKyoqZXJycCkgew0KPiA+Pj4+ICsgICAgQXNwZWVkMjd4MFNvQ1N0YXRlICphID0gQVNQRUVE
MjdYMF9TT0MoZGV2KTsNCj4gPj4+PiArICAgIEFzcGVlZFNvQ1N0YXRlICpzID0gQVNQRUVEX1NP
QyhkZXYpOw0KPiA+Pj4+ICsgICAgQXNwZWVkU29DQ2xhc3MgKnNjID0gQVNQRUVEX1NPQ19HRVRf
Q0xBU1Mocyk7DQo+ID4+Pj4gKyAgICBTeXNCdXNEZXZpY2UgKmdpY2J1c2RldjsNCj4gPj4+PiAr
ICAgIERldmljZVN0YXRlICpnaWNkZXY7DQo+ID4+Pj4gKyAgICBRTGlzdCAqcmVkaXN0X3JlZ2lv
bl9jb3VudDsNCj4gPj4+PiArICAgIGludCBpOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgIGdpY2J1
c2RldiA9IFNZU19CVVNfREVWSUNFKCZhLT5naWMpOw0KPiA+Pj4+ICsgICAgZ2ljZGV2ID0gREVW
SUNFKCZhLT5naWMpOw0KPiA+Pj4+ICsgICAgcWRldl9wcm9wX3NldF91aW50MzIoZ2ljZGV2LCAi
cmV2aXNpb24iLCAzKTsNCj4gPj4+PiArICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKGdpY2Rldiwg
Im51bS1jcHUiLCBzYy0+bnVtX2NwdXMpOw0KPiA+Pj4+ICsgICAgcWRldl9wcm9wX3NldF91aW50
MzIoZ2ljZGV2LCAibnVtLWlycSIsIEFTVDI3MDBfTUFYX0lSUSk7DQo+ID4+Pj4gKw0KPiA+Pj4+
ICsgICAgcmVkaXN0X3JlZ2lvbl9jb3VudCA9IHFsaXN0X25ldygpOw0KPiA+Pj4+ICsgICAgcWxp
c3RfYXBwZW5kX2ludChyZWRpc3RfcmVnaW9uX2NvdW50LCBzYy0+bnVtX2NwdXMpOw0KPiA+Pj4+
ICsgICAgcWRldl9wcm9wX3NldF9hcnJheShnaWNkZXYsICJyZWRpc3QtcmVnaW9uLWNvdW50IiwN
Cj4gPj4+PiArIHJlZGlzdF9yZWdpb25fY291bnQpOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgIGlm
ICghc3lzYnVzX3JlYWxpemUoZ2ljYnVzZGV2LCBlcnJwKSkgew0KPiA+Pj4+ICsgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gPj4+PiArICAgIH0NCj4gPj4+PiArICAgIHN5c2J1c19tbWlvX21hcChn
aWNidXNkZXYsIDAsDQo+IHNjLT5tZW1tYXBbQVNQRUVEX0dJQ19ESVNUXSk7DQo+ID4+Pj4gKyAg
ICBzeXNidXNfbW1pb19tYXAoZ2ljYnVzZGV2LCAxLA0KPiA+PiBzYy0+bWVtbWFwW0FTUEVFRF9H
SUNfUkVESVNUXSk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgZm9yIChpID0gMDsgaSA8IHNjLT5u
dW1fY3B1czsgaSsrKSB7DQo+ID4+Pj4gKyAgICAgICAgRGV2aWNlU3RhdGUgKmNwdWRldiA9IERF
VklDRSgmYS0+Y3B1W2ldKTsNCj4gPj4+PiArICAgICAgICBpbnQgTlVNX0lSUVMgPSAyNTYsIEFS
Q0hfR0lDX01BSU5UX0lSUSA9IDksDQo+ID4+PiBWSVJUVUFMX1BNVV9JUlEgPSA3Ow0KPiA+Pj4+
ICsgICAgICAgIGludCBwcGliYXNlID0gTlVNX0lSUVMgKyBpICogR0lDX0lOVEVSTkFMICsgR0lD
X05SX1NHSVM7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgICAgIGNvbnN0IGludCB0aW1lcl9pcnFb
XSA9IHsNCj4gPj4+PiArICAgICAgICAgICAgW0dUSU1FUl9QSFlTXSA9IDE0LA0KPiA+Pj4+ICsg
ICAgICAgICAgICBbR1RJTUVSX1ZJUlRdID0gMTEsDQo+ID4+Pj4gKyAgICAgICAgICAgIFtHVElN
RVJfSFlQXSAgPSAxMCwNCj4gPj4+PiArICAgICAgICAgICAgW0dUSU1FUl9TRUNdICA9IDEzLA0K
PiA+Pj4+ICsgICAgICAgIH07DQo+ID4+Pj4gKyAgICAgICAgaW50IGo7DQo+ID4+Pj4gKw0KPiA+
Pj4+ICsgICAgICAgIGZvciAoaiA9IDA7IGogPCBBUlJBWV9TSVpFKHRpbWVyX2lycSk7IGorKykg
ew0KPiA+Pj4+ICsgICAgICAgICAgICBxZGV2X2Nvbm5lY3RfZ3Bpb19vdXQoY3B1ZGV2LCBqLA0K
PiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oZ2ljZGV2LCBwcGli
YXNlICsNCj4gPj4gdGltZXJfaXJxW2pdKSk7DQo+ID4+Pj4gKyAgICAgICAgfQ0KPiA+Pj4+ICsN
Cj4gPj4+PiArICAgICAgICBxZW11X2lycSBpcnEgPSBxZGV2X2dldF9ncGlvX2luKGdpY2RldiwN
Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBwaWJhc2Ug
Kw0KPiA+Pj4gQVJDSF9HSUNfTUFJTlRfSVJRKTsNCj4gPj4+PiArICAgICAgICBxZGV2X2Nvbm5l
Y3RfZ3Bpb19vdXRfbmFtZWQoY3B1ZGV2LA0KPiA+Pj4gImdpY3YzLW1haW50ZW5hbmNlLWludGVy
cnVwdCIsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIGly
cSk7DQo+ID4+Pj4gKyAgICAgICAgcWRldl9jb25uZWN0X2dwaW9fb3V0X25hbWVkKGNwdWRldiwg
InBtdS1pbnRlcnJ1cHQiLCAwLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bp
b19pbihnaWNkZXYsIHBwaWJhc2UgKw0KPiA+Pj4gVklSVFVBTF9QTVVfSVJRKSk7DQo+ID4+Pj4g
Kw0KPiA+Pj4+ICsgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGksIHFkZXZf
Z2V0X2dwaW9faW4oY3B1ZGV2LA0KPiA+Pj4gQVJNX0NQVV9JUlEpKTsNCj4gPj4+PiArICAgICAg
ICBzeXNidXNfY29ubmVjdF9pcnEoZ2ljYnVzZGV2LCBpICsgc2MtPm51bV9jcHVzLA0KPiA+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2luKGNwdWRldiwNCj4g
Pj4+IEFSTV9DUFVfRklRKSk7DQo+ID4+Pj4gKyAgICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKGdp
Y2J1c2RldiwgaSArIDIgKiBzYy0+bnVtX2NwdXMsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2LA0KPiA+Pj4gQVJNX0NQVV9WSVJRKSk7
DQo+ID4+Pj4gKyAgICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKGdpY2J1c2RldiwgaSArIDMgKiBz
Yy0+bnVtX2NwdXMsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0
X2dwaW9faW4oY3B1ZGV2LA0KPiA+Pj4gQVJNX0NQVV9WRklRKSk7DQo+ID4+Pg0KPiA+Pj4gWW91
ciBwYXRjaCB3YXMgbWVyZ2VkIGFyb3VuZCB0aGUgc2FtZSB0aW1lIEppbmppZSBhZGRlZCBOTUkg
c3VwcG9ydA0KPiA+Pj4gKHNlZSBjb21taXQgYjM2YTMyZWFkMSAidGFyZ2V0L2FybTogQWRkIHN1
cHBvcnQgZm9yIE5vbi1tYXNrYWJsZQ0KPiA+PiBJbnRlcnJ1cHQiKS4NCj4gPj4+DQo+ID4+PiBT
aG91bGQgd2UgYWRkIHRoZW0gbm93Pw0KPiANCj4gPiBJIHJlZmVycmVkIHRvIHRoaXMgbGluZSwN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9ibG9iL21hc3Rlci9ody9hcm0vdmlydC5j
I0w5MDcsIGluIFFFTVUncw0KPiB2aXJ0LmMgdG8gYWRkIE5NSSBzdXBwb3J0Lg0KPiA+DQo+ID4g
QXJlIHlvdSBzdWdnZXN0aW5nIGFkZGluZyB0aGUgZm9sbG93aW5nIGxpbmVzIHRvIGVuYWJsZSBO
TUkgc3VwcG9ydD8NCj4gPiBJdCB3b3JrZWQgYXMgd2VsbC4NCj4gPg0KPiA+IGBgYA0KPiA+IHN5
c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGkgKyA0ICogc2MtPm51bV9jcHVzLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihjcHVkZXYsIEFSTV9DUFVfTk1JKSk7
DQo+ID4gc3lzYnVzX2Nvbm5lY3RfaXJxKGdpY2J1c2RldiwgaSArIDUgKiBzYy0+bnVtX2NwdXMs
DQo+ID4gICAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2luKGNwdWRldiwgQVJNX0NQ
VV9WSU5NSSkpOyBgYGANCj4gDQo+IFllcywgY29ycmVjdCENCj4gDQoNClRoYW5rcyBmb3Igc3Vn
Z2VzdGlvbi4NCldpbGwgc2VuZCBwYXRjaCB0byBzdXBwb3J0IE5NSSBmb3IgQVNUMjcwMA0KDQpK
YW1pbg0KPiBUaGFua3MuDQoNCg==

