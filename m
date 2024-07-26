Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A8CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXEYs-00048x-Ir; Fri, 26 Jul 2024 02:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sXEYm-00047o-Pb; Fri, 26 Jul 2024 02:36:12 -0400
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sXEYi-0008F3-2N; Fri, 26 Jul 2024 02:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpLo/9WxIZjRE3V147cSsi0B1Szx29Pf7AT10lth/aweARl7+DhTBchlminBA9QI+66K4/b+eHIgQfCGJrmIPTeWNDm0ie1jysrlq/xlrtzAPv7L5+nL2xd81mF20l+GQMcf62nHbIgviMD4TeEM6v2Y+edLLbInGaGBFnL+jeAXw3tfJjWOalqEJRlJ3GVjbhyDSwHlnkYICmoyF3+D/Xc7fQJ45/ZqlcUueqA/lCUohQ7CHgQ3+8uURTfMq5uWIu3xnmeKAW8+e+cVXxOCcEc2P8lOfl3d1IF7eVHFBjGmxdUxvRG6TLlBRX3+KMfuS4YQ/HL55lGeT3NC1GrDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUTc4calbgP6giFPatKQ57UTOaAm7h9Diomq2ea6+xg=;
 b=IQtPqTDI4JEhj/VaPATmlelac2f5r2QMPcafo8XTkE/eTOUufYvY3xPSLQnWMtJVlfNjcsJ+qSJ8A2h0V8xzKYu8eHfU5xb+Acm9tI9oVb5t9pAHpeIyL6vB+lHt4fkwYvCHVY9gks7YQLabZCdcOwmLFXjeqqGEXk9Hk0XXKrz2ObT3nePTW9nGd/jTR84uA+f96WUrhH26UrmIPcU972CUGSnatf9iYjCLzemnY27WY74fy5OHYmX6W4mEGqXtYrvqQOjwTfT5yaOFa1vfCy75MtOlG40CwmRUdzHip3yAXUO5889nSsFO7VeOv3FfQ4kMPoRE3oIjgY4lHYNjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUTc4calbgP6giFPatKQ57UTOaAm7h9Diomq2ea6+xg=;
 b=qA76GqNlRfUuCF7tah+dMlPH61H75dxuc8JhC0A/d6kkEE1YYsIRFTPMfIb7eFIFS36mevaX+JhFPQ2yEA+R+fyoKZSkwR5cHUlmxRowMCIhSRZBFk3tnoJYeeXsDMhJ6/06JcmV25mCvJSrIa5/Hs3Ag1ERU5hzUpakd6UrgiFejKFPhHWXX6NxVjYMGHcSwExUi17w2WmHo0Z+Al/p/f/5PjyuACv3ds61UxkCIEUkhgaqh+0eMzS5Q+DfKQLqoPiA+xsA4X26myPbuGmVUPJVVMX1AiTERMZLhU+VNLPjo5AswLWBywYjC7Aj1t3gjYmaLbymhQRTo1bgITsFgw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB6542.apcprd06.prod.outlook.com (2603:1096:400:481::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 06:36:00 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 06:35:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 12/15] aspeed/soc: introduce a new API to get the INTC
 orgate information
Thread-Topic: [PATCH v1 12/15] aspeed/soc: introduce a new API to get the INTC
 orgate information
Thread-Index: AQHa2N7IMMxGyeAgEkOSM1OBYYC1wLH9x6mAgArPX4A=
Date: Fri, 26 Jul 2024 06:35:59 +0000
Message-ID: <SI2PR06MB5041C0F1C8FFF216B7B7FC89FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-13-jamin_lin@aspeedtech.com>
 <f70ae091-151b-476c-a8ef-312952163fac@kaod.org>
In-Reply-To: <f70ae091-151b-476c-a8ef-312952163fac@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB6542:EE_
x-ms-office365-filtering-correlation-id: d02b16b8-82e3-4d75-6bda-08dcad3d367a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZDF3Mk4rTXkwVWU3VldZN2RZWFBRblZ6V0FScGNPVGFoVStiQjFHdURsZTBO?=
 =?utf-8?B?Q2pHNUxjdWpXZHZSYzF5ZnEza1ArK3BYdFJjNFdmdHlHM1VsbTBnSWYvbFZG?=
 =?utf-8?B?Vm4zRnNrWXkxNlV6WlRGR3ZwZlpobnFrRTlJdWpuNGJPa2lyWjB5Yktzb2s5?=
 =?utf-8?B?MzFWY0ZvbnB2M0QwODl6cHJ2eFRJU2NXSW9iSWRiQzNPQm5ETzFGWGNRdWNo?=
 =?utf-8?B?VUwyQnBaYzcvZjcyRlU4eitwMzgyZmRjbTRtcisvQTR3OU02bUg3NFVBZ3hI?=
 =?utf-8?B?ZnpBQkdBZEs1Zy94UFVMRDNDaThsQzBXYkRpTGQySENlZVhQSTZQaE9jL0dp?=
 =?utf-8?B?WlZ4UWNWNHM2OHcvOTRpWUJ3UUwyVWJoSG1GZmx1WG5lTUxmb1B6SWJHM2FS?=
 =?utf-8?B?aEdXWFhlVDJLd1ByK1R2SUVENFlBRm04WURMZkhTVFl5QmNBckErNS9UenAy?=
 =?utf-8?B?clBUYituQmo4MnB2N3BDSlBuaUVYdktZTS9LZmJGblBvY0hRUlpMdjZtbGxN?=
 =?utf-8?B?c2U0cE1adEwzTVRpb3NHOWtmeGJ4VWZiRThkUGo0Rm5RR1N3VFA1TFZpQVJk?=
 =?utf-8?B?SU5QN2dFTWdBNnhhd0pCU25YdHRHbUxEZ2o4aDNNTWR3S3UrMGNIaDNZejkr?=
 =?utf-8?B?OVljNVUxd1BJUVd2b1pJa3NnNkJveml1amZZUDNyM1J3dTNTK0JtWUpxTzB0?=
 =?utf-8?B?OEpwK2I2OTVMRElVREpBSXdZNlJwV3hTRjFlMDFFNDFkN0VUbm9hKzEwb09K?=
 =?utf-8?B?cjNLQk1Ya2FUaVBORWkyRFBDL2NIM1ZiM2NRNS9LQmNLR25aWCtkOFV3d3Bi?=
 =?utf-8?B?cTQ3QTVLaXpvaERDSzRoSGZzNEFGSjdJM1prbzFEYXBMK3lkdllzZ1pFc1Fr?=
 =?utf-8?B?Y1VGYU94NEFOZGZXdGhWNjVlc3pnakVJa0lvT3IxY2hhNFRPL2pIYUxLWFY4?=
 =?utf-8?B?cDVSZnNYL041a2hncGp4SlN3Qk5jUzJaelQxVElCdjZTelJHTkh4YW14RkdF?=
 =?utf-8?B?MTZNcy84UnJKaE5JdG1TUnZoYlNScVRkc0lXU1h3UTgxV1NOS1RtOHF5d09t?=
 =?utf-8?B?TmF4aXd3Wkt0aUV1Y0IrdEEram5nc0NDVTU3Sm8rSXZHa2lrbUxSTFVPZDM2?=
 =?utf-8?B?YnNaKzZLT0tVc1liUGxjRFhpWUgyRThtekdBNHZwSnNvclpGb0xPR0VPSWd0?=
 =?utf-8?B?VDZXQTk3TUlFV2JUc3JUSSt4Y1V3aEQ4Z2xTbit1bDdtcFFmUmJlem45bWFy?=
 =?utf-8?B?NUwvcWN2MzQ5TzBJREd1Z2FXOVorNFdLZGpQbHF4YlJ1MERUYm1PR3c4Mk9S?=
 =?utf-8?B?VHZqUTE1VjJFSEpjZmQ3VlNPclBHeXBaYkVaTGpReDNMREMwYUZqR0kvbnpw?=
 =?utf-8?B?MlNPWU9XTUp5cnp4Mml6YWIwMEY3NEdISHZuZThwSXgzUWlXQ2o2Ung2WGl5?=
 =?utf-8?B?QUJCOE1mQU9qNWZxNHZQcTg5NDcyOExicjR3RkI2Y3pkVXpwaXB1K1hYN1Yv?=
 =?utf-8?B?aitRa0h2TzdzR2gxNzFYSEdhUGYxZjEyejZ0SzVCWGVXc1E4QjN1T1lPWmFI?=
 =?utf-8?B?NGlzdnZldG9IRmdJWGtDU2ZTV3lYM0s3RFFiT1hTOGdGNCs0LzMvdU1meTYv?=
 =?utf-8?B?dkJXcTduMFQ3K21Nc2xTS3dlODdNaWlsVEZ1ejdFeEdpYUhpSVB5R2toK2xz?=
 =?utf-8?B?MWwzajlkdVpJSlRXRUZYN3BwRWdQM0s3VDhLU21sTUFsWGVoZFRCbGJvbmZR?=
 =?utf-8?B?ZW5CU1RHczJMc2hmWnZQM3ArQm1qejltMlFuLy9QVUxkRGdGNXcxeWN6MzU1?=
 =?utf-8?B?WWxmQ2YxelhyYlQwK0owUy9uWUk5YU5zM1pvcjFveFZTTWdLRlJ0c08wSWpj?=
 =?utf-8?B?VDNPdXZYTXZFMVZRNFczR3JablltY3JlaWRESEZnMGhQZFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1dIZ3hsdW9FQVlCSEhwaHFweHp1SU51WS9tY2cxL0ltUFhVUlhHUkNIcmJO?=
 =?utf-8?B?dWVPZnIraUZCcHA3a2ZhWUQ2Y0dRYy8xc3pZQ2Z5cHRCTW5pSGl0aXhkeWZw?=
 =?utf-8?B?R0xkc0JYbk41UE9DL1pwcVc1Y3kwUlZQZDkrZzNHR1RyWVZYL3JlMjJWNkRR?=
 =?utf-8?B?UDJseUwwRFkwYjVPWlZxL3BuRVh6eW9ZT0FhdEhuOU92RXZyNW9qZ3Izd2lR?=
 =?utf-8?B?bHpveXVJOUo0cVBLU3EzWmRoYjRBRDNGS0gzR1lRZ0YyMzU5WVlSME8wTnlB?=
 =?utf-8?B?VUFmZ0xoUVBnWFRRNEd4OFFidHpZVm5HY3F4VTg0NTArU0dyTVBUeXViSFYw?=
 =?utf-8?B?a1FXN0t4SDZDUnNqU1FQTGJjZnhhdDlSWWV1VEJCYVpUMnRTNTdqT3BSY3dG?=
 =?utf-8?B?aTZuRDBReXY0VnFBOHBJMTFVSk1JRnBVSGZjUjN5UFZZdlZFN3E5MFo3djdN?=
 =?utf-8?B?Z2lOLzZpQjIrSW53VE1WZEgxQTZrWEtUcUp5NGgwRFNIeTZRL3FBQjFobk1k?=
 =?utf-8?B?a05laDFQaWZxN1NJUmg2SGc3MHd4d0NGQVl2R0M2aWxZeGtidjUxQy9SVGx1?=
 =?utf-8?B?Z3BCK090K1loSldLMC9NRmZVb1JZMm9IK241bFFsaXJndlYzRHhEL2oxcldh?=
 =?utf-8?B?WEdMZGpKanpOOHI2Vk5OVHREcDFXbnNkSWhSdWY1bGxFam92YXkycVptUWNG?=
 =?utf-8?B?NjE3M3VlSGIyaXFTa1ZQdVV0L0tVcW4vcGkyaDNRclBMK09zME1yL0hmZTFu?=
 =?utf-8?B?THdHb1F6WEVnY2hYazJpbzJ6YVJuaGVMalEydk1oM3ZjdTkyMjc4WkhiUjRW?=
 =?utf-8?B?dWt6dkxGRTZFSkJZcmc0MVNiaGtaQjZGM2t6NjU4RUhkMGhNc2ZmS1hFVkZr?=
 =?utf-8?B?cFV1bFJ2NXN0cjgzSHpzUEhGeEhKRlZPUWpzOXA3ZGgzcDV0aHdBaTUyN0JS?=
 =?utf-8?B?dEhrL2NrZ2FTZTVmZmxTR3lDSWx2WWFSWm9mUFNEcmFjZlliTjdWekFzTCtD?=
 =?utf-8?B?Y3V1TTVLdlU1VExQRjhndjk2a2VMcEZHN1BISDE3Q2k4N2NtNXZYNGJvN0xs?=
 =?utf-8?B?dkxkaXI1ZSt0d2NHc2FzVTlBQXRKQ3RZWmp1NlZHbGNadEZiN1F5TkI5djRY?=
 =?utf-8?B?UUVESGkxLzBvQm4vUzExY3BVcmVaMXNwTlZMbmZxZEdJZFpMTVJUNWxRa0pJ?=
 =?utf-8?B?ZWZHOUdVaVNwbDhoMDRLUFIvWTF6NVBZZE5jUHZUcXEzMHBtTHhITWRvR1pL?=
 =?utf-8?B?RXplMzUxUTdvejNsY2cwcCs1Y2NaQkxRcmJaY1A1aFFXWERIdmswNUlpcVBx?=
 =?utf-8?B?OXhKajRDZjF4NC81dndldmsyczhhdDM1dzRKSlNqSDdRK0JzNlEzVFJQdVpm?=
 =?utf-8?B?cjB1c0hRMnBady9sOGczMWxmMTYrL25iS1lRL3hXNml3NDRsUUZnU21NMElo?=
 =?utf-8?B?eCtFR2tvbWNYbTFhZUczeXlXNnVGK01rS3MvWitscnhVM1Y1My9IZTlJRTRK?=
 =?utf-8?B?bFduVjB3TGlLemQ0WkZaeW5XREN3bDZ4cmJoM1V5MG5VVVVIaVlwTmtLNHJE?=
 =?utf-8?B?VzJYK0V0Y0ZKZXp1Qk1xdkExeDZkZlEyWnNTaldzaFB0ci9wdDFtaUpTRHFK?=
 =?utf-8?B?djZjQTJyUUZQSUtrdFEzcWY5TGNJK2hMS1VzZm9lMXRmWnU3R2NzQVcvVGM5?=
 =?utf-8?B?QWZ1QWZlYkt2V1lsbFZlRThlNHpJdXljbWJvRzV2QWhoVFlidjQxWXFvOHhI?=
 =?utf-8?B?UmduSzk3R3VOR3FMellmMjA4dlFPazI5eTZBY2lQZ2ZudzRSZlpXdjFTOHhR?=
 =?utf-8?B?UHl1WVY0czhPWnpJZ2VZZXhGMElaT0JzSFlRQTE5Y2owK3ROY2ZrT0Vsd0ZE?=
 =?utf-8?B?ZCsyVDFWZ1AzZUFibk5rZGlQa3NyVmNQSDAyZjIrOGxLUTZhdkRxa05VeEJj?=
 =?utf-8?B?NXhhakd2cE41VEZrQ01OUEZ5UjRlTzJuU2JZZE9yckdUVjZJQ2NlT1VZWFV0?=
 =?utf-8?B?VzhZQStCTHRjaUxnWHphVzRCWXBFWitrZFpmVG9IdE1hU25OMThFK3I4MDRK?=
 =?utf-8?B?SWJjd3dGV01HdjFBZGY5SGt4eVBLV1NER1NUcUkzeENGMTZyYzJNQ01KMXE3?=
 =?utf-8?Q?giOUrOTFyF2XZAcrhhHw9kP19?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02b16b8-82e3-4d75-6bda-08dcad3d367a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 06:35:59.8300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThkRYzBAtDP6yK4i2tKgiPWujMv6yaInudz8b48FlBqIsCb9vgGeR279f4pa7AzGtD1A8/43tVq7Dlg8uWOfzMevb7XpXm2JhnJ3mio4f00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6542
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTIvMTVdIGFzcGVlZC9zb2M6
IGludHJvZHVjZSBhIG5ldyBBUEkgdG8gZ2V0IHRoZSBJTlRDDQo+IG9yZ2F0ZSBpbmZvcm1hdGlv
bg0KPg0KPiBPbiA3LzE4LzI0IDA4OjQ5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQ3VycmVudGx5
LCB1c2VycyBjYW4gc2V0IHRoZSBpbnRjIG1hcHBpbmcgdGFibGUgd2l0aCBlbnVtZXJhdGVkIGRl
dmljZQ0KPiA+IGlkIGFuZCBkZXZpY2UgaXJxIHRvIGdldCB0aGUgSU5UQyBvcmdhdGUgaW5wdXQg
cGlucy4gSG93ZXZlciwgc29tZQ0KPiA+IGRldmljZXMgdXNlIHRoZSBjb250aW51b3VzIGJpdHMg
bnVtYmVyIGluIHRoZSBzYW1lIG9yZ2F0ZS4gVG8gcmVkdWNlDQo+ID4gdGhlIGVudW1lcmF0ZWQg
ZGV2aWNlIGlkIGRlZmluaXRpb24sIGNyZWF0ZSBhIG5ldyBBUEkgdG8gZ2V0IHRoZSBJTlRDDQo+
ID4gb3JnYXRlIGluZGV4IGFuZCBzb3VyY2UgYml0IG51bWJlciBpZiB1c2VycyBvbmx5IHByb3Zp
ZGUgdGhlIHN0YXJ0IGJ1cw0KPiA+IG51bWJlciBvZiBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAu
YyBpbmRleA0KPiA+IDQyNTdiNWU4YWYuLjBiYmQ2NjExMGIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0K
PiA+IEBAIC0xNjQsNiArMTY0LDExIEBAIHN0cnVjdCBnaWNfaW50Y19pcnFfaW5mbyB7DQo+ID4g
ICAgICAgY29uc3QgaW50ICpwdHI7DQo+ID4gICB9Ow0KPiA+DQo+ID4gK3N0cnVjdCBnaWNfaW50
Y19vcmdhdGVfaW5mbyB7DQo+ID4gKyAgICBpbnQgaW5kZXg7DQo+ID4gKyAgICBpbnQgaW50X251
bTsNCj4gPiArfTsNCj4gPiArDQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGdpY19pbnRjX2ly
cV9pbmZvIGFzcGVlZF9zb2NfYXN0MjcwMF9naWNfaW50Y21hcFtdID0NCj4gew0KPiA+ICAgICAg
IHsxMjgsICBhc3BlZWRfc29jX2FzdDI3MDBfZ2ljMTI4X2ludGNtYXB9LA0KPiA+ICAgICAgIHsx
MjksICBOVUxMfSwNCj4gPiBAQCAtMTkzLDYgKzE5OCwyNyBAQCBzdGF0aWMgcWVtdV9pcnENCj4g
YXNwZWVkX3NvY19hc3QyNzAwX2dldF9pcnEoQXNwZWVkU29DU3RhdGUgKnMsIGludCBkZXYpDQo+
ID4gICAgICAgcmV0dXJuIHFkZXZfZ2V0X2dwaW9faW4oREVWSUNFKCZhLT5naWMpLCBzYy0+aXJx
bWFwW2Rldl0pOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0
MjcwMF9nZXRfaW50Y19vcmdhdGUoQXNwZWVkU29DU3RhdGUgKnMsIGludA0KPiBkZXYsDQo+ID4g
KyAgICBzdHJ1Y3QgZ2ljX2ludGNfb3JnYXRlX2luZm8gKm9yZ2F0ZV9pbmZvKSB7DQo+ID4gKyAg
ICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0dFVF9DTEFTUyhzKTsNCj4gPiArICAg
IGludCBpOw0KPiA+ICsNCj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGFzcGVl
ZF9zb2NfYXN0MjcwMF9naWNfaW50Y21hcCk7IGkrKykgew0KPiA+ICsgICAgICAgIGlmIChzYy0+
aXJxbWFwW2Rldl0gPT0gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW2ldLmlycSkgew0K
PiA+ICsgICAgICAgICAgICBhc3NlcnQoYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW2ld
LnB0cik7DQo+ID4gKyAgICAgICAgICAgIG9yZ2F0ZV9pbmZvLT5pbmRleCA9IGk7DQo+ID4gKyAg
ICAgICAgICAgIG9yZ2F0ZV9pbmZvLT5pbnRfbnVtID0NCj4gYXNwZWVkX3NvY19hc3QyNzAwX2dp
Y19pbnRjbWFwW2ldLnB0cltkZXZdOw0KPiA+ICsgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBJbnZh
bGlkIG9yZ2F0ZSBpbmRleCwgZGV2aWNlIGlycSBzaG91bGQgYmUgMTI4IHRvIDEzNi4NCj4gPiAr
ICAgICAqLw0KPiA+ICsgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gPiArfQ0KPg0KPg0K
PiBUaGlzIGxvb2tzIHJlZHVuZGFudC4gQ291bGRuJ3Qgd2UgZXh0ZW5kIGFzcGVlZF9zb2NfYXN0
MjcwMF9nZXRfaXJxKCkgd2l0aA0KPiBhbiBpbmRleCBwYXJhbWV0ZXIgaW5zdGVhZCA/DQo+DQoN
ClRoYW5rcyBmb3IgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KDQpBY2NvcmRpbmcgdG8gdGhlIGN1
cnJlbnQgZGVzaWduIG9mIGFzcGVlZF9zb2NfZ2V0X2lycSwNCnRoZSBmdW5jdGlvbiB0eXBlIG9m
IGdldF9pcnEgY2FsbGJhY2sgZnVuY3Rpb24gc2hvdWxkIGJlIFhYWChBc3BlZWRTb0NTdGF0ZSAq
cywgaW50IGRldikNCg0KcWVtdV9pcnEgYXNwZWVkX3NvY19nZXRfaXJxKEFzcGVlZFNvQ1N0YXRl
ICpzLCBpbnQgZGV2KQ0Kew0KICAgIHJldHVybiBBU1BFRURfU09DX0dFVF9DTEFTUyhzKS0+Z2V0
X2lycShzLCBkZXYpOw0KfQ0KDQpzdHJ1Y3QgQXNwZWVkU29DQ2xhc3Mgew0KICAgIHFlbXVfaXJx
ICgqZ2V0X2lycSkoQXNwZWVkU29DU3RhdGUgKnMsIGludCBkZXYpOw0KfQ0KDQpJZiB3ZSB3YW50
IHRvIGFkZCBhIG5ldyBpbmRleCBwYXJhbWV0ZXIgaW4gYXNwZWVkX3NvY19hc3QyNzAwX2dldF9p
cnEsIEkgd2lsbCBjaGFuZ2UgYXMgZm9sbG93aW5nLg0KMS4NCnN0YXRpYyBxZW11X2lycSBhc3Bl
ZWRfc29jX2FzdDI3MDBfZ2V0X2lycShBc3BlZWRTb0NTdGF0ZSAqcywgaW50IGRldiwgaW50IGlu
ZGV4KQ0Kew0KICAgIEFzcGVlZDI3eDBTb0NTdGF0ZSAqYSA9IEFTUEVFRDI3WDBfU09DKHMpOw0K
ICAgIEFzcGVlZFNvQ0NsYXNzICpzYyA9IEFTUEVFRF9TT0NfR0VUX0NMQVNTKHMpOw0KICAgIGlu
dCBpOw0KDQogICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoYXNwZWVkX3NvY19hc3QyNzAw
X2dpY19pbnRjbWFwKTsgaSsrKSB7DQogICAgICAgIGlmIChzYy0+aXJxbWFwW2Rldl0gPT0gYXNw
ZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW2ldLmlycSkgew0KICAgICAgICAgICAgYXNzZXJ0
KGFzcGVlZF9zb2NfYXN0MjcwMF9naWNfaW50Y21hcFtpXS5wdHIpOw0KICAgICAgICAgICAgcmV0
dXJuIHFkZXZfZ2V0X2dwaW9faW4oREVWSUNFKCZhLT5pbnRjLm9yZ2F0ZXNbaV0pLA0KICAgICAg
ICAgICAgICAgIGFzcGVlZF9zb2NfYXN0MjcwMF9naWNfaW50Y21hcFtpXS5wdHJbZGV2XSArIGlu
ZGV4KTsNCiAgICAgICAgfQ0KICAgIH0NCg0KICAgIHJldHVybiBxZGV2X2dldF9ncGlvX2luKERF
VklDRSgmYS0+Z2ljKSwgc2MtPmlycW1hcFtkZXZdKTsNCn0NCg0KMi4gaW50cm9kdWNlIGEgbmV3
IGdldF9pcnFfaW5kZXggZnVuY3Rpb24gcG9pbnRlciBhbmQgdGhlIGZ1bmN0aW9uIHR5cGUgb2Yg
dGhpcyBjYWxsYmFjayBmdW5jdGlvbiBhcyBmb2xsb3dpbmcuDQpzdHJ1Y3QgQXNwZWVkU29DQ2xh
c3Mgew0KICAgcWVtdV9pcnFfaW5kZXggKCpnZXRfaXJxKShBc3BlZWRTb0NTdGF0ZSAqcywgaW50
IGRldiwgaW50IGluZGV4KTsNCn0NCg0KRG8geW91IGhhdmUgYW55IGNvbmNlcm4gb3IgY291bGQg
eW91IHBsZWFzZSBnaXZlIG1lIGFueSBzdWdnZXN0aW9uPw0KVGhhbmtzLUphbWluDQoNCg0KPiBU
aGFua3MsDQo+DQo+IEMuDQo+DQo+DQo+DQo+DQo+ID4gICBzdGF0aWMgdWludDY0X3QgYXNwZWVk
X3JhbV9jYXBhY2l0eV9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQN
Cj4gaW50IHNpemUpDQo+ID4gICB7DQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFs
aXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2
KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53o
rbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu2
6YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzp
m7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4DmiYDmnInopIfljbDku7bjgILorJ3orJ3m
gqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNo
bWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlk
ZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVs
ZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlz
Y2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4NCg==

