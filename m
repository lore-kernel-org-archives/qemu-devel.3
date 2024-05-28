Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC8BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtRD-0005j0-2G; Tue, 28 May 2024 05:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBtR3-0005fT-O5; Tue, 28 May 2024 05:48:01 -0400
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBtQz-0008G2-3f; Tue, 28 May 2024 05:48:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6T9iwccUlSSTKIPg6EtEHLAYj8lhOpHolmh+gdyTI4dseXifjJduDgUStFqCAou2ubBbikmkK60c9nAkmE72NLY2trWysDF22NHM6L4w6zAWWlDdO4g5skvFpj7ZiaY2sdgHSdnkzziA+2UHSO86bPetgxb9e1PAGIjFF7TTecYur0mhG/17t+ezRLCdyCIaV3N8fIC4IINGRjZQe+zjefLS1oIt2HBM98B15vewdjcTbUJFwK6J4hI2Ni8OGI7UILtVthi6S1QWDDt0nh88UDR4PWHjzE0SrOD4XLsz8BxaFI9nGlExaL5f6tbBcG5eqfSxm3UEwHEf6R2g8o9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VidALTpgqv/RxLlvnz2AvXIeW+xuTjxoiHgZqVTe+oM=;
 b=oaBFkpj+Ln7AnP0+M3+WpD0d847cYxoSBV7FcUF3dNHo+B+obMNLADilP+vJARIlr80sk9l+vZrbscDXCUcMXwuROt+GuKc4jWks4/musFMOvxjRGU4H8qR3sg/0Sr+XxRt0yD/uBTx6Kt3gfBvac70C/Skz7ACgosQw0iNXA29HIdijwuhJnmo04h47gH4OiCZ7atnlsuw77nYCIWTA8YSfy9IAn95hC/GK44d+vSvP/MLcKRemVpqiuHvYg36v/kp7M8MRiLfgmVOhvoGLcbMLp1yrQnMG0ex99eZ7VIdQRBEz4ndrsfZaeDfAxGv+M7Sg9Gd+K8IP6rgeW2VLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VidALTpgqv/RxLlvnz2AvXIeW+xuTjxoiHgZqVTe+oM=;
 b=Aerj0PWx8rcxAEeij5tfTo0WNyOic7+BSgMdaGBckth2jrWDRj2WLC7LqpwxFgon0HqxZ02I4TtvRfBCZ7cwIY3iRhoA1DKUZwk/zwZL1Pa7GdtncqkyoxSZHoThWY/uW3FprOQbnKzVclKy9Wt96huEUq0uXPB6u6subx8JL16UDGXgbl5jbnqHopGMdCDRI9SLe3d1HBBi9/N5UxLfa3dauilRCtUdTQEwtffPCn7TVbDQWh0nDhCF3Yhp37NC1Ru1dvNLv8A6741Pd0FB6GHXqLbCecx+qfHo8CTXTqef7A7vWqxXgMjyMOTG/GcIRciYQjc8NbaxDlQ2DmD3Bw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6753.apcprd06.prod.outlook.com (2603:1096:101:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:47:38 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:47:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
Thread-Topic: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
Thread-Index: AQHasAxBoT342ZIDJkuMa+uwhNwqLrGq4AwAgAAPGoCAABcLgIAA1T4AgABWlQCAADQcoA==
Date: Tue, 28 May 2024 09:47:38 +0000
Message-ID: <SI2PR06MB5041A8BD40F5BEC60A4A3A76FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-6-jamin_lin@aspeedtech.com>
 <9476cfcc-5a7c-4b76-a684-1361463bd161@linaro.org>
 <b01604af-5fa7-469f-98e9-c23b3a668a2e@kaod.org>
 <933822dc-de0e-4180-90f9-d951aed30aec@linaro.org>
 <SI2PR06MB5041CD54D31762371A757C48FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <9dfa5ca2-56a9-49c4-a651-044dc952f67b@kaod.org>
In-Reply-To: <9dfa5ca2-56a9-49c4-a651-044dc952f67b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6753:EE_
x-ms-office365-filtering-correlation-id: a389f402-7cde-429e-466e-08dc7efb35f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009|921011; 
x-microsoft-antispam-message-info: =?utf-8?B?Unl2dnF4NUx6b2dYQVlsaXFGaHZkeDRlWitRNjdOV1FMd2NvNmdsWmJwVllj?=
 =?utf-8?B?emg2YmtUOG80T1lPZnRxNk9XTTdWc2ZnQTRzd24zODIycGdwNWlxMkRleFI3?=
 =?utf-8?B?dDNKcFRWaFhrT1B5S0pxRSthVitBQWNPd2xmcXpLbTZOazhzS0NEQjdlQjk1?=
 =?utf-8?B?SjRTc3ExMHh3dzRQTmJhUTlDODY1WWZnWEc1U21Yc0hCcnpZbkpmY1Vnalht?=
 =?utf-8?B?a2NtMXJvWExRRzU4dXpJWmdTRXJQRUtpS0d6OFhiMTVNV0x2M2xZb2F2THdC?=
 =?utf-8?B?YjB5SEVhbTMrUEE0V0Nnei9oOEZJMnYwQ2VuRmo0MFVqNEM0RzJiOXdaalY1?=
 =?utf-8?B?NGtGN2pyOGRLNjIvcDd6SGRNK01zazNOKzNLcXJmSjAvYUpGY2JWQ2w2bmxR?=
 =?utf-8?B?eG11eFhNbGtJV1FRbUY2Y0MzZXFEMEpxZkV3cXhiK1NkSWxXdlI3VzBRT1p5?=
 =?utf-8?B?MnZOS0w3UkhCVkdiYWFZbVlxRUo3dzRYY1plOHVhVit3TXFiRFdYZ2lYd2FE?=
 =?utf-8?B?cEQvU3UycG1qY2VudDJtbUdTWUsremJ6Q3FNTDJmZDZRdHpUakNqREZoZTFs?=
 =?utf-8?B?NFEyMThQeDJWWTZUT1dsazVOUU1yTnZ2SXNWdU5HYjQ5Yzc0bm5BQlBJOXR6?=
 =?utf-8?B?d21iMnFsVWhXZjE4VkZPbGdsS0dhTkgweVQrMFZxTUhIcndMMy9MZzNqNk9l?=
 =?utf-8?B?OU5MWFRiSkNVR2JLU0VrK0ljakp1TTI2WFJaS3YwN2J6aEh4VHNDVWFFK1Rr?=
 =?utf-8?B?SWVPY1N0M0pHVDhwYnJaN0N1V1lmUDNiakVBQjIvbEN1Z09RRmhlZUM2MXdC?=
 =?utf-8?B?OTBJUjltRDBZTVdESHYrV3FJZmcxMzdJdHExdTJGdUFBeUNHZ1dRVTE4cEFl?=
 =?utf-8?B?TnZ2RmNndVRDNzJOSm1lS01MbWs2RmdZY2k2UDFtWHdqUUgyaVhrVEx0Q05Y?=
 =?utf-8?B?VUI4VFZVYTh4eDg3SDhqUjkvMTcrc1hCZ0pmVGYrWlNSTnEzZVhLTVlMZXZi?=
 =?utf-8?B?ODAxKzZ4SEYvTGx5MGN2cXdhY3hSQ2dhbGNqcnN6RFRZQS9UV0FHRkdjZWNK?=
 =?utf-8?B?NjdSUU9ZaHg3Ym5aOHVCMjF3aXVRM2grTWNBeTZUcHRRc0d3Y2ExRXRGWGo0?=
 =?utf-8?B?K1hUbHlJaDNQU3JGYm5hQkdDVE1yUlJBaXZENmNTMGxTSXdjTUZFa1VUSmJ4?=
 =?utf-8?B?UkkvMnNKUGtweE91MWlQdFJmR0NEVkNrQjloZHBPS3pmTlNBMkRUejlDTmtn?=
 =?utf-8?B?STNJZ0o3TWNCZEVubm9wV3dIRWJ4Y25RSzNTaGgrbCtnMXh5UFJEdDg3NjZB?=
 =?utf-8?B?b3ZKSVJIL2p2MUtXQUVvU3dESVFJdGZhYnA3Q0JWYTYvdks4TjhaNGtPbG5i?=
 =?utf-8?B?L24wdTg2MzlsZ2kyZGFTT2IzWDBzeWNGYTVOQmNqMVk3NGY0N3JFZ240Witi?=
 =?utf-8?B?QmdJQTM2MDN4cWFxSmRkVmxyRW9KY01TZThjcm41YkNNQ0NBK2JtTG9EZnF6?=
 =?utf-8?B?ek9TenU3akpaQjhmUDBTSUpIYmdlS1hDUU9za2JlcldER0IzV0xMY0QvV1h0?=
 =?utf-8?B?UGkxTlQ4azJXcnMvV2hoZlRGakljOTJPUmMxMys3LzFEdTJmSW0zTEpxVzEw?=
 =?utf-8?B?eEhYZm5kaFVUQkhtdEk0amhtZVJMNVVTaE4vQlZTYVpCelhKY0hscXFzOXV3?=
 =?utf-8?B?dkl1QTBKdm5uaVB1N1J5MWpmbERXZkJIbVZ1UHBjSFFGUzJIeVZCTTBiSmFG?=
 =?utf-8?B?d3ZXb1B6ZW1NbU05TSsvdTN1MURKYUVWMzRuUG9JT0lFcVl1ZktnZUFRTVVo?=
 =?utf-8?Q?RByP1+5iNNWVQpXPTAgQsVgdUBsrMMg2kg5VQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009)(921011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTM4WlgzMkRQUnFFZytBMzRpQncxd1ExZ0hGYVM5Q1kyUnV2bnphbFdlTkJB?=
 =?utf-8?B?dVBkWXozL2Z2R0JuczB5eWM0ZU95ei9XdjE2dTkwQzF5YkVuM0xJMWI5Yzd5?=
 =?utf-8?B?UDEwSzNWSzV4UzBqQTFiWVZBTmhXSUhWWjk3QVZjR3NHZXk0MmswcTdmWnhI?=
 =?utf-8?B?Y0w4TDNDZDBkbWRIM1QrMnE1WG5yRjhmcGRpQTUvM1ZIWUltemozTUp0eUFt?=
 =?utf-8?B?R01yU0JKMEljVmkybkpUQXBaRFZTWU1UWUdBbVdCSG9JNk5ZMFFZNWp1UWdo?=
 =?utf-8?B?UG90dG52MUs4b0JtUjZ5TE02WloyM1BENzh2Sit2WXJIVVdRdEZJY1hGbGFz?=
 =?utf-8?B?RHhRV3JOY3lPUFl6dm92SFNudUY1N2o4M0VSN3hCTytkTi94Zk1JSnIra2lH?=
 =?utf-8?B?aVQ4bHVTTmhoK0pSOXNZTk9xRWxUYitrQ08zZlpmZ0tYYzl1TytFRCtDVGU5?=
 =?utf-8?B?QVZRaWU5aTJ2RVFYTXdqRllZdlJuUFFhdGtKYXFCeDkzLzVxRzFTS3E1TnNG?=
 =?utf-8?B?WFZPZ1A4bXdGTU92N0RFUHhWVmgrT1dKRjVDNlVVaEhqOUp1MnZmdWlhbVNL?=
 =?utf-8?B?czN6aEJrVmhXVUFyeDBpQWJPa2s4MmZSdkY3eWdTdHkrQ2VlQ3JtZlphTzFq?=
 =?utf-8?B?cmc4UWdtaG9Yd2Q4OVhEb0ZmWHVuQmxFV1cra0tGVlZPck4weDVkNW9LRCtj?=
 =?utf-8?B?dEgyUVJwOHBldUZkWnFzUDFvL1BOUXU1OEpVVjRmNWVUQlg3TWw5WDJXYnpB?=
 =?utf-8?B?MzBvVjc3Z25zTHVMZmp3UEtVMEFoTHZ1d2Y3cjREeE41eDJveC9zVlpxVXJD?=
 =?utf-8?B?djJsclF0U2FyYXlaKzQ4MEFGdUVPOGhCV25GZFg5bUo4MnJPdzhEYmgvWHVK?=
 =?utf-8?B?NTBGS3cvaDIxZ1poVFUvclFJM0NyWGRIZjJwK283RmE2TVhXSXA1c09yUjBX?=
 =?utf-8?B?QVc1blRBSzQ2UHJrZHArSDNVSDhSb0hNNlBJOFE2UXZ1TFduS0lOdGVHckg3?=
 =?utf-8?B?Z1hubWFWUU1aM3dOWEdTanNGNFlTVitCL0NsWFBqOTFpZUhpYUc4K1dWQzJX?=
 =?utf-8?B?aFIrMk5XczFVTkJEYmNxUk9pOU9rbzNyWnYxQmZnUUt4bXlJK3ZHSTFneEc5?=
 =?utf-8?B?YWI1YkRiWWZsdms5MGFvMUVoUEpLTnI3OG5XSzQ5d08wLzY5dkt5dVcvbHMv?=
 =?utf-8?B?S1VTL3AydXR0MC9rbzh2VEdLSDU1Ty81c1gzNVQxa1hJbU1NWmp2VFB1RTRy?=
 =?utf-8?B?N2lKbDFCTm5wcjM2MVNtbjBpM0JsWjUwSmZrUXpQRUhXeGZyMnIwRGxTQWJ1?=
 =?utf-8?B?TkloMzNYcUFUYnUvSGEySEpTQlVHWFlQQlV6QnE2MGFHcTM2M2RMdUZBemlo?=
 =?utf-8?B?N0RmbG5HZEIrSmRSOXFvUGlKT0Nqdmttaml5Tm12eXpiZTJQVitDRTN0ZGdS?=
 =?utf-8?B?cE4ySjNCS2l2elYrRUIyVlljSmgvbTZ3MjExOTlOS3Rkd0F6QnVPVHkrQ3Mr?=
 =?utf-8?B?N25LSWMxMWlvdllHdUZ1MlhkckVLMHJkOGJPeXRwZ1FYaHc3YStYbGZ4S09T?=
 =?utf-8?B?TmoySXV5ckhMaUxHdFFEYU8vS01tUW1wR1FMMEFSUFdCZXg5VE10aTBjYW1E?=
 =?utf-8?B?L0V3ZjdTSlh2cDdYTVpVNVorVUZJbUJrYVN2ejk1MWtDUlY5SHNlWVg0RExn?=
 =?utf-8?B?aUhLbGtYWU0xQW5ZemxxRzFMTHliMjRKUG0wRU44aGZSWTM5OUpFMVM1VzNv?=
 =?utf-8?B?WWRMUnJuRGtTWi9HWmVCNXFGUEZoWTQ3eGZkMlpZZ05mcEV3RGtwaWtrQmZw?=
 =?utf-8?B?UFBCbWZCZmN1NDhQZjYyYTU4eDRDOWVIa3ZUWmV3VG96Z21mdTgrdERHQ0NK?=
 =?utf-8?B?cmtWUE9BcEZQRVBVa1piTTJEb2dydVZKdTZ6RUhhcTUwT3lBTXRSWngxV2dr?=
 =?utf-8?B?bll6TkczVkxNR1BiaVJFZHZVcUV6V1VTbFRQUDVoN3R0b2JQM213NUduMDdV?=
 =?utf-8?B?a1R2ajFtWElrSjc5ZHlSQU94UDNHem52TmdWNEhxajFHM09YT1I3aVpaWHBE?=
 =?utf-8?B?WFRhMk1Oelprc01LT3R1SnNVeEpUaVhMd05XdFQybnVuUTg2UU81aHFYMnJ0?=
 =?utf-8?Q?ZcsZSrexydvqMqNLB3TIrIFtA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a389f402-7cde-429e-466e-08dc7efb35f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 09:47:38.6110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6o4TjK+1bFdULbNAOxR4yw3byi3nQsSv6b/IJik6WdiEP9ILsupPShlqAdemFAmx/TpO7j7gmGcLXsQ0Bf+GN+aUlGXg35Yp6GpIjlwLrmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6753
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMjQg
MjozNCBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqQ0KPiA8cGhpbG1kQGxpbmFyby5vcmc+OyBQZXRlciBNYXlkZWxs
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBDbGViZXIgUm9zYSA8Y3Jv
c2FAcmVkaGF0LmNvbT47DQo+IFdhaW5lciBkb3MgU2FudG9zIE1vc2NoZXR0YSA8d2FpbmVyc21A
cmVkaGF0LmNvbT47IEJlcmFsZG8gTGVhbA0KPiA8YmxlYWxAcmVkaGF0LmNvbT47IG9wZW4gbGlz
dDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gbGlzdDpBbGwgcGF0
Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJv
eV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGluLnRhbmdAYXNwZWVk
dGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDUvMTZdIGFzcGVlZC9zZG1jOiBB
ZGQgQVNUMjcwMCBzdXBwb3J0DQo+IA0KPiBPbiA1LzI4LzI0IDAzOjI2LCBKYW1pbiBMaW4gd3Jv
dGU6DQo+ID4gSGkgUGhpbGlwcGUsIENlZHJpYw0KPiA+DQo+ID4+IE9uIDI3LzUvMjQgMTM6MTgs
IEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+Pj4gT24gNS8yNy8yNCAxMjoyNCwgUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+ID4+Pj4gSGkgSmFtaW4sDQo+ID4+Pj4NCj4gPj4+
PiBPbiAyNy81LzI0IDEwOjAyLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+Pj4+IFRoZSBTRFJBTSBt
ZW1vcnkgY29udHJvbGxlcihEUkFNQykgY29udHJvbHMgdGhlIGFjY2VzcyB0byBleHRlcm5hbA0K
PiA+Pj4+PiBERFI0IGFuZCBERFI1IFNEUkFNIGFuZCBwb3dlciB1cCB0byBERFI0IGFuZCBERFI1
IFBIWS4NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlIERSQU0gbWVtb3J5IGNvbnRyb2xsZXIgb2YgQVNU
MjcwMCBpcyBub3QgYmFja3dhcmQgY29tcGF0aWJsZQ0KPiA+Pj4+PiB0byBwcmV2aW91cyBjaGlw
cyBzdWNoIEFTVDI2MDAsIEFTVDI1MDAgYW5kIEFTVDI0MDAuDQo+ID4+Pj4+DQo+ID4+Pj4+IE1h
eCBtZW1vcnkgaXMgbm93IDhHaUIgb24gdGhlIEFTVDI3MDAuIEludHJvZHVjZSBuZXcNCj4gPj4+
Pj4gYXNwZWVkXzI3MDBfc2RtYyBhbmQgY2xhc3Mgd2l0aCByZWFkL3dyaXRlIG9wZXJhdGlvbiBh
bmQgcmVzZXQNCj4gPj4+Pj4gaGFuZGxlcnMuDQo+ID4+Pj4+DQo+ID4+Pj4+IERlZmluZSBEUkFN
QyBuZWNlc3NhcnkgcHJvdGVjdGVkIHJlZ2lzdGVycyBhbmQgdW5wcm90ZWN0ZWQNCj4gPj4+Pj4g
cmVnaXN0ZXJzIGZvciBBU1QyNzAwIGFuZCBpbmNyZWFzZSB0aGUgcmVnaXN0ZXIgc2V0IHRvIDB4
MTAwMC4NCj4gPj4+Pj4NCj4gPj4+Pj4gQWRkIHVubG9ja2VkIHByb3BlcnR5IHRvIGNoYW5nZSBj
b250cm9sbGVyIHByb3RlY3RlZCBzdGF0dXMuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+Pj4gU2lnbmVkLW9m
Zi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+Pj4+IFJldmll
d2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+Pj4+PiAtLS0NCj4g
Pj4+Pj4gIMKgIGh3L21pc2MvYXNwZWVkX3NkbWMuY8KgwqDCoMKgwqDCoMKgwqAgfCAxOTANCj4g
Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+Pj4+PiAgwqAgaW5j
bHVkZS9ody9taXNjL2FzcGVlZF9zZG1jLmggfMKgwqAgNSArLQ0KPiA+Pj4+PiAgwqAgMiBmaWxl
cyBjaGFuZ2VkLCAxOTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+Pg0KPiA+
Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NkbWMuaA0K
PiA+Pj4+PiBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2RtYy5oIGluZGV4IGVjMmQ1OWExNGYu
LjYxYzk3OTU4M2ENCj4gPj4+Pj4gMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvbWlz
Yy9hc3BlZWRfc2RtYy5oDQo+ID4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2Rt
Yy5oDQo+ID4+Pj4+IEBAIC0xNyw2ICsxNyw3IEBAIE9CSkVDVF9ERUNMQVJFX1RZUEUoQXNwZWVk
U0RNQ1N0YXRlLA0KPiA+Pj4+PiBBc3BlZWRTRE1DQ2xhc3MsIEFTUEVFRF9TRE1DKQ0KPiA+Pj4+
PiAgwqAgI2RlZmluZSBUWVBFX0FTUEVFRF8yNDAwX1NETUMgVFlQRV9BU1BFRURfU0RNQw0KPiAi
LWFzdDI0MDAiDQo+ID4+Pj4+ICDCoCAjZGVmaW5lIFRZUEVfQVNQRUVEXzI1MDBfU0RNQyBUWVBF
X0FTUEVFRF9TRE1DDQo+ICItYXN0MjUwMCINCj4gPj4+Pj4gIMKgICNkZWZpbmUgVFlQRV9BU1BF
RURfMjYwMF9TRE1DIFRZUEVfQVNQRUVEX1NETUMNCj4gIi1hc3QyNjAwIg0KPiA+Pj4+PiArI2Rl
ZmluZSBUWVBFX0FTUEVFRF8yNzAwX1NETUMgVFlQRV9BU1BFRURfU0RNQyAiLWFzdDI3MDAiDQo+
ID4+Pj4+ICDCoCAvKg0KPiA+Pj4+PiAgwqDCoCAqIFNETUMgaGFzIDE3NCBkb2N1bWVudGVkIHJl
Z2lzdGVycy4gSW4gYWRkaXRpb24gdGhlIHUtYm9vdA0KPiA+Pj4+PiBkZXZpY2UgdHJlZSBAQCAt
MjksNyArMzAsNyBAQA0KPiA+PiBPQkpFQ1RfREVDTEFSRV9UWVBFKEFzcGVlZFNETUNTdGF0ZSwN
Cj4gPj4+Pj4gQXNwZWVkU0RNQ0NsYXNzLCBBU1BFRURfU0RNQykNCj4gPj4+Pj4gIMKgwqAgKiB0
aW1lLCBhbmQgdGhlIG90aGVyIGlzIGluIHRoZSBERFItUEhZIElQIHdoaWNoIGlzIHVzZWQNCj4g
Pj4+Pj4gZHVyaW5nIEREUi1QSFkNCj4gPj4+Pj4gIMKgwqAgKiB0cmFpbmluZy4NCj4gPj4+Pj4g
IMKgwqAgKi8NCj4gPj4+Pj4gLSNkZWZpbmUgQVNQRUVEX1NETUNfTlJfUkVHUyAoMHg1MDAgPj4g
MikNCj4gPj4+Pj4gKyNkZWZpbmUgQVNQRUVEX1NETUNfTlJfUkVHUyAoMHgxMDAwID4+IDIpDQo+
ID4+Pj4NCj4gPj4+PiBUaGlzIGNoYW5nZSBicmVha3MgdGhlIG1pZ3JhdGlvbiBzdHJlYW0uDQo+
ID4+Pg0KPiA+Pj4gRG8geW91IG1lYW4gbWlncmF0aW9uIGNvbXBhdCA/IFdlIG5ldmVyIGNhcmVk
IG11Y2ggYWJvdXQgdGhhdCBmb3INCj4gPj4+IHRoZSBBc3BlZWQgbWFjaGluZXMuDQo+ID4+DQo+
ID4+IFNvIGxldCdzIGp1c3QgcmVtb3ZlIHRoZSBWTVNUQVRFIHRvIHJlZHVjZSBjb2RlIGJ1cmRl
bj8NCj4gPj4NCj4gPj4gT3RoZXJ3aXNlIGluY3JlbWVudGluZyB0aGUgdm1zdGF0ZS52ZXJzaW9u
IGlzIGVub3VnaC4NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4NCj4gPj4gUGhpbC4NCj4gPiBJ
ZiB5b3UgYm90aCBva2F5LCBJIHdpbGwgcmVtb3ZlIGl0Lg0KPiA+IERvIEkgbmVlZCB0byBjcmVh
dGUgYSBuZXcgcGF0Y2ggb3IganVzdCB1cGRhdGUgaW4gdGhpcyBwYXRjaD8NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgdGhpcyBpcyBuZWNlc3NhcnkgdG8gZG8gc28gbm93LiBQb3NzaWJseSwgaW5jcmVh
c2UgdGhlIHZlcnNpb24NCj4gbnVtYmVyIGluIHRoZSB2bXN0YXRlIHdoZW4gcmVzZW5kaW5nIGEg
djUuDQo+IA0KSWYgSSB1bmRlcnN0YW5kIHlvdXIgcmVxdWVzdCwgZG8geW91IG1lYW4gdG8gY2hh
bmdlIGFzIGZvbGxvd2luZyBpbiB0aGlzIHBhdGNoPw0KDQpzdGF0aWMgY29uc3QgVk1TdGF0ZURl
c2NyaXB0aW9uIHZtc3RhdGVfYXNwZWVkX3NkbWMgPSB7DQogICAgLm5hbWUgPSAiYXNwZWVkLnNk
bWMiLA0KICAgIC52ZXJzaW9uX2lkID0gMSwgIC0tLT4gQ2hhbmdlIDINCiAgICAubWluaW11bV92
ZXJzaW9uX2lkID0gMSwgLS0tPiBDaGFuZ2UgMg0KfTsNCj4gQWxzbywgYWxsIEFzcGVlZCBtb2Rl
bHMgc2hvdWxkIGJlIGFkZHJlc3NlZCBhbmQgdGhhdCdzIGJleW9uZCB0aGUgc2NvcGUgb2YNCj4g
dGhpcyBzZXJpZXMuDQo+DQoNCkFuZCBjcmVhdGUgYSBuZXcgcGF0Y2ggc2VyaWVzIHRvIHVwZGF0
ZSBhbGwgdm1zdGF0ZSB2ZXJzaW9uIGZvciBhbGwgQVNQRUVEIG1vZGVscz8NClRha2UgYXNvZWVk
X2dwaW8uYyBmb3IgZXhhbXBsZToNCnN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1z
dGF0ZV9ncGlvX3JlZ3MgPSB7DQogICAgLm5hbWUgPSBUWVBFX0FTUEVFRF9HUElPIi9yZWdzIiwN
CiAgICAudmVyc2lvbl9pZCA9IDEsIC0tLT4gQ2hhbmdlIDINCiAgICAubWluaW11bV92ZXJzaW9u
X2lkID0gMSwgLS0tPiBDaGFuZ2UgLS0+IDINCn0NCg0KVGhhbmtzLUphbWluDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBDLg0KPiANCg0K

