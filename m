Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9474FCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utMiT-0007MY-LC; Tue, 02 Sep 2025 04:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utMiQ-0007Jq-ED; Tue, 02 Sep 2025 04:50:10 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utMiN-0002HA-Ob; Tue, 02 Sep 2025 04:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sesqGPY1/uk4XOPRhOIKlBcEYFccW8g7jFY8cE+LhaskaomAV55LBqVj5rSleDhoMfZyVOKFOo6b3JnPs1TAIUBDeoIHOpbITquHxqAnyR9i2Iu+H0jfVUXeTJWxmZfm40+u0cVozATP0xp5JL/S5T2gbWR2o8FlndRzL3qs2z9cbzlLSB+mdCMYG7t5C8/jz+71RHWaRFrwhIuH3s9luTQ1h8I2OKCH8oDgtMrhTcuzaKIJXu2RxXaV5/RlUc2b3RaldnCSIf/9+2CYgnCKS8yj4zouRDgY5qw/dbBBxhSx8Xg67OPVNMz7D9mDyrsiXaC3QALbN23VxQFbjHhfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC9k0ny/d1DVCjVtbZpMPKECbuj4vmwBXg9okHXJeSc=;
 b=YGMEqn7NOgNmD9vX0MFbHG1fUA3JX/8BE9CMuMKOxjxN2CQFDr4retgLhm1sbwjZ0/3j9pggt2Z4xIky3QCtRcy3W6k1Iu8FYO6deDAaFuQRVt9gOFv5zOolkdYjXPV+6UOLcB2boS0zNmMIIlytn1UBrbadT2KNEB9qFmC+qI5D1uqFSzmCmk3cixn5NbenClCz2iCc0sxp0zdh9UkI5sHEyItjq1iaZGyYB4MsH50qM5Ibx65FqGhvuHLuOiQRa3Sp/RyNcvXh1Q9U2FQJDTNMnM7vstyMOSckI2GC1B080W6RL8nlmsG6Jvq3NUzq6v418YBwkUh+SosHJvl/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC9k0ny/d1DVCjVtbZpMPKECbuj4vmwBXg9okHXJeSc=;
 b=lTsUTwsZIkzihYPr0wVUFzXuYdN2QwuOyaoD0flsi6U37r0Z94UvyvBcG8LmfLkDmcsf/g9Q5Pb/mDf1M8kziLnRajibtueLEecDvbIBA5qK2Wh4id84ZinFAat2EEap59ejEFXgAd1EDloI2W7Brn7hoQIL89QZ38aJqDHaBk9YweWTVSDsTDetBxToteU6tNg7Am+5GhoOnhKwjzNGdhuhE15iqXn3+dL1SMIsJTbkl3BvCDWV8Z/koS1YGIa/8L9JHrJlql6sjkBYRYsN8pk3GvKn/533bw1dERqVyGyEITJOBTOSKq8Ynkq03VsJe4RtVsfGJnpL8Am7pN/9MQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB7259.apcprd06.prod.outlook.com (2603:1096:405:86::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 08:49:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:49:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor
 initialization from machine to SoC leve
Thread-Topic: [SPAM] [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor
 initialization from machine to SoC leve
Thread-Index: AQHb9syfxnDc/cgy1Uu07Vhs7LToKrR/tc8AgAASzDeAABY1sA==
Date: Tue, 2 Sep 2025 08:49:58 +0000
Message-ID: <SI2PR06MB5041B96A9D9B2DBA14DA07D1FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-3-jamin_lin@aspeedtech.com>
 <555f7a62-7332-41a2-a316-e0888fbc819d@kaod.org> <87ms7dpb4l.fsf@pond.sub.org>
In-Reply-To: <87ms7dpb4l.fsf@pond.sub.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB7259:EE_
x-ms-office365-filtering-correlation-id: 7c2f3f08-1d1a-4400-74de-08dde9fdb266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?ZzB1dkgrcWgwbktzeFYwZ1Q2aFB3SUYzejRKbnBKN1ZDQURjYTR1eTZObU43?=
 =?utf-8?B?eDFMMWpwRFN6K1crZkROUGhMQS9RSG5GTWp4eGRTeHpmck83a0xwcmpTM1Fn?=
 =?utf-8?B?OW1jMzJiS3JiZVQrK096QXlkOTFTMzFXbnZFYnQxaDF1a2QxaE1Nb01EWGZp?=
 =?utf-8?B?MFdkWGFxbFBES1VRU0tvZ1piZjlnWi9MNUUwdmQvSkRhVHNSVnJ5dTN6dmFs?=
 =?utf-8?B?UTRXUVZodDFHTTUyMXJ4MG4zQ0JCeGh5ZGtudElscGJHQUM5YXU0Nmo1VU1J?=
 =?utf-8?B?MHlrZTJKdEU1YnlyT1ZEU0pTRVcyc3hKZjRrV1FxQm5VSWlvQlgrNVNpVHJa?=
 =?utf-8?B?R3VzRnoyNkh1T2l0TW5CTnUwZEc5WGpUQ3g4aE1hVDRib2J3cVlDRXk2ekVY?=
 =?utf-8?B?ZzRhL3pSaCtCSmptWWlFVkdacUlmTURyN2pzbllrVHJodVMrSlN1bytCT29D?=
 =?utf-8?B?VUp6Z1d3V2pqb2YyamFOR2ZhNUdzNmcwWG9idWVhd01sZDd2T3B2NWtTbTh3?=
 =?utf-8?B?Z05FS0JWWUg3ZGRlNHhzMkFUWDZOS2V2NkRlbzNERzFZdTFCYXoybGwzS04v?=
 =?utf-8?B?Um90QkNiY05mV2ptTDB5WTZZa29EaHJKVVR2anNMZmVkWDZwM2c0VWhRdm9v?=
 =?utf-8?B?eVlkS3J1cXJHQTRyeDdzd29jZFRjOTNxaGV2QTZzYlFNT21VS2JBWno4YlFj?=
 =?utf-8?B?anJrTzN6eUtyK1RoWG03L295eFg2TnRyemo2WHJEVmU1Tzd4TkQ0cmVhRkdu?=
 =?utf-8?B?NngxUGNSMmNESTZhOTgzUUc3emdPVGgrSGtOeTlLSXF3RjlCUzcrZ1M3a29y?=
 =?utf-8?B?KzNnSzZ4SlNwRkhrQmtDZ0ZDTExrUlozTUhDNkg2YmpOeFR2cGV2Nm04SjZN?=
 =?utf-8?B?M2lhdTZSSXBxcEVNK1pkVlBqODk1TW80emo4OXdhS2ordmJHZVB1ZTM0UGlJ?=
 =?utf-8?B?RzJId1JZV2srZEZKaGUxdlkyemc0SDUwdVJiOEtmUkxTUUlGMHlwUkJ5OGdr?=
 =?utf-8?B?UENUMzAyckRWRFM5Y3l1eG0vUFpOUzJ6UzkyMHVyVk9nN0cwakR4Mlk0aWpQ?=
 =?utf-8?B?TmJtZkhMVUREMWQ2WEtKV0FVTFhkWnB5OVlpUWRPSUtDd0JXbkhTZzNROWJQ?=
 =?utf-8?B?T2x0MENXakRLUW9NNEhLOCtMOTFYaXpYRnBlMGs1eUtiRDF2UUU0QjZ2emlx?=
 =?utf-8?B?VXhzR1VFMWlBRWdkMlZ5SWRlN1VwS3pCZUV0ZCtjSDVBV0x4ckthUUpYbGda?=
 =?utf-8?B?WWFtR3hCbTNwSXBMZHYyb0tnM2FYdndQMlhnWWh3b21QS0RlWjZaK3dFajlD?=
 =?utf-8?B?Z2VMcVlGMUc4Qm1CVGVINERzQkRuYWszWWlmR0x4YXpyWTJVTG1IdU9XRjZR?=
 =?utf-8?B?RGo3QWF3T1lKajRtZndPUG5OaHNPa3RRR3hlMXZ2MW4zeHJyTVh5elRDRGgv?=
 =?utf-8?B?b293bXJNaEgxaDhBaS9XdXg3SGFoamhCTzFMVjFmRjZYaGZ6RExPNEc5Tjd1?=
 =?utf-8?B?cmRoUEk3TlYrQXkrMDdrYWFpdE9PakcwRExCd3ZWWU1OUXJrQWh3WTZKQ21o?=
 =?utf-8?B?UzhBaElEb1JheGVUYThLY21TMC9wZEpuUjJpTmdyYXAzOG1lRjhyeTdlRk4y?=
 =?utf-8?B?TGZZN3FnN1RkaDRMWHdTMGpCdmV2RzFidXBOYnJRUFZrVkxWTUtQbm1Eb1VQ?=
 =?utf-8?B?YWZBamxrblBBN3RvaHhRWkpYdEtBanlsRXIvdjFHdXo3cHJ2T28xM3lIdVZq?=
 =?utf-8?B?ZGxVa1VmVWd0d0lkYUpoOER1R2xZaW0wNEI4bDZRMnJ2TE9aa1pwSXZXUlo3?=
 =?utf-8?B?YTBKSXdSQ1NKTGY4WEhWbm1ROHdER0Ztblk4TlM1M2RFL25kOWsvSVBPNGUr?=
 =?utf-8?B?dEhnalpCVVRyOHp2NmVPYTN0MWFvRWNQVTNVZ1hSVG03WU15WWVWdUI2WEda?=
 =?utf-8?B?MFVRSDVZVmtNSG5Bc1NBQWdTNFJKamsxZ2tjRnRzWDZmZlV0RzFZYnh4aUVr?=
 =?utf-8?B?UEFNZ0xvc3V6ejlocndTWFdQbWhhTHR3MnIya05tc092V0IwQkxLaktPQkoy?=
 =?utf-8?Q?9WlQCf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnpTS2hrQlNvb1Fzb0JaRVJ6TjFoSS9MaFc5cU9HcEhwVDVGaU5RcUR1OEpH?=
 =?utf-8?B?Y3hFZDB2MlllczMxQU9TL0VvLzRwMncyZm1raWxPZFh2UlpXNDltR0hJS3N0?=
 =?utf-8?B?VTV0QnNETmFwVnEraFlVbGp0ZWJYUG9IZDVvZlJtYzJ5bHFOYmMxcFJlU2l4?=
 =?utf-8?B?bDk5R01NbG9HdmhEZmtJU2hab2tXeUl3bmlHNHVHc3pFQ2FaV1BmMmhFZm4w?=
 =?utf-8?B?aE0wZEtwOHZMdTNJQ0UyazViNUVWVjdLaEVHckxWUnowVXZvRnJVZUdad2Rk?=
 =?utf-8?B?NFN0VFpIMVVJZVhBMFU5OUlaMGVsSlM2RUZ1MVVpWkNqSThWbGNFTzRmQ1Uy?=
 =?utf-8?B?bittMERnQXNpK0s5UXpOMlVRRk9sbk00Y3lkaXNFUTZNb0lFeVo0dUJkSEV3?=
 =?utf-8?B?bEROTU9hT0J4ZjUwUTNrYUF3dzlZM3FONkY2M28zdmRYRXI4eENESUpzdHpx?=
 =?utf-8?B?eFhIbVU0K3c5T0xpK2VUT2xLYlZhd2ZuWTZlV0NLSUFZOFhJRWwvSk1sVkVH?=
 =?utf-8?B?WUMwODE3enhtNUU4a2ExVllJRUE5clpyczB4T3h4QkFSS25oUVRCNmxSbjN2?=
 =?utf-8?B?Y1VXY1lvSDBJYjJaaVpZbDdCMER4QnM0S3NKcTl6bVYrNm50ZmFUR1J6QlZn?=
 =?utf-8?B?ZHk4d1Ixb2tmNUxKaHE1QldKRDBvUEVaRzNrRE9LNERvcEpwQWZJaW1qZE1C?=
 =?utf-8?B?M0kvVVBHRnNpdkVpQVl4K2xKR2l0SWd6SUl4N0tJUkM1TmRmbjBjTkJMclM1?=
 =?utf-8?B?VytLK3JzRDdVS2NwQVRFR1ZOa1Y1VFVLNkdFQUlza0JhODcrWmxYdXNTL1By?=
 =?utf-8?B?c2JRN0t5NDVRdEtWVllJR2VlT3NXTTI4UURBeDRzWGFLMU1abnJuR3N1eXRa?=
 =?utf-8?B?TmhxTDdNeWxMbUF6Um82Qjg0a0ZMc1FDeElZbU9TcllEbU5PSlNrdnhSaWha?=
 =?utf-8?B?eUlYZUg5WUlKUzZ5TG1BTVRXaEErUjBzMVA3S1p1SXlPcUoxVE1JaHJqK01J?=
 =?utf-8?B?Um1IRFhORVhoOHo5S29ISS9KYlVOZ1Q4d1p1dmwvemVvRjlIblljUDFIcElN?=
 =?utf-8?B?TjJyaE9BekFrZkRQMHQxZFZwUHhFaGFYWUw2bklUTjZDc3dyUXNza1ZzUXB4?=
 =?utf-8?B?U1ViUUdpOWUwQzBmMXFVeHVUSi9nZnlXTUd6T09yT3BYdlZCOHd4RWhEbTVV?=
 =?utf-8?B?L09VdVBRUGlDVXU4elRDSkt6Z001Z0FXQU9LZmxyMFJEVEdnUVpnUGVFS0tj?=
 =?utf-8?B?TEpjcTZSSG5xaGhkMFJUcWlscWZXcWxZam9ienpOVlJyVDhWYVpxcEVTcUVx?=
 =?utf-8?B?c1o4WnV3bklMRnVJenowZTErbk85TFg5aDRJY0JGeWRkRUtnYmpZOEluMm55?=
 =?utf-8?B?bFA4NEJuRXllQ01mVHRSUzlpTkU3ZkdvSGQ5WWRTVlFVSDhrQ1RDV0QvVFcr?=
 =?utf-8?B?Mk5aOTh1akNLRzMxaCt2aGNHSzRiSlh4T0RTd2JEWmQ2N1pZS2JLK0FMZ0Q2?=
 =?utf-8?B?ek1GMTYxeUVaT283N09iTnRMMFBDWENwMmVrdXIxTStNR3FYNk1jVGFpNlYx?=
 =?utf-8?B?WnBwRTcwV0NVK3NzbEVGaVlpcHVhc0htT0N0TExiMFhZRFVVZEEyYk1jVzRz?=
 =?utf-8?B?djAyOXhhaTJwM0RqZDZCWkZDbHVyU1pEbi8yRC8yb09VeWtGYkV1c25tbCtH?=
 =?utf-8?B?cm9sSnlvVHc1bkpFa0xLQmNBeXFSN05Cc1Q2MWdhSUJyT0k1ZkJzTUdXc1FD?=
 =?utf-8?B?VmNJUGJNMVRvbDU5Qk1oVmE0M1FoUWZZOG1yQkNQZVViMFVYRll0RTl3WFd1?=
 =?utf-8?B?VWl4WWRrV3JhVEwxVGdVdTdSLzl4ZGg0MW5FdE4zRmpYV0tCYncvcy9EQjg4?=
 =?utf-8?B?Y3Q4K0lZWGNZaWpoUEJGZmN1eU82SGNBWE4ya2J4R1FzVVRkUElDd1hyZFBC?=
 =?utf-8?B?RDFoZHRJTGROQ2ZOalVmSnJ3MVRVY3VuN2V3YkpPOXJJQjQwYWsxbFpoN2o2?=
 =?utf-8?B?OTYxUlo0SityYTJyaS9YcUkwUHFnODNnd0NHNi94Y1lvWlN3QVJLQk5PRU9w?=
 =?utf-8?B?QTdyRmlmNW55OVNZUG9STytJOE1FODdMbk9hKzBucG1iQWZ1cXRRK2FRM0xr?=
 =?utf-8?Q?XaoGdCH69DyJVA857Zjyyg7Y8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2f3f08-1d1a-4400-74de-08dde9fdb266
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 08:49:58.5213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CADxBXmDMq4FCeR2AQH71p0ioSzPf7CFul922YlftDiuAx1L8EPWGIkSh5NMoGWCfdcKMtVXAe1aPQatuGq7Uk5N0HkGlt9ODq6gY0M0G70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7259
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgTWFya3VzLA0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAyLzIxXSBody9h
cm0vYXN0Mjd4MDogTW92ZSBTU1AgY29wcm9jZXNzb3INCj4gaW5pdGlhbGl6YXRpb24gZnJvbSBt
YWNoaW5lIHRvIFNvQyBsZXZlDQo+IA0KPiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3Jn
PiB3cml0ZXM6DQo+IA0KPiA+IE9uIDcvMTcvMjUgMDU6NDAsIEphbWluIExpbiB3cm90ZToNCj4g
Pj4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiwgdGhlIFNTUCBjb3Byb2Nlc3NvciAoYXNwZWVkMjd4
MHNzcC1zb2MpIHdhcw0KPiA+PiBpbml0aWFsaXplZCBhbmQgcmVhbGl6ZWQgYXQgdGhlIG1hY2hp
bmUgbGV2ZWwgKGUuZy4sIEFTVDI3MDBGQykuDQo+ID4+IEhvd2V2ZXIsIHRvIG1ha2Ugc3VyZSB0
aGUgY29wcm9jZXNzb3JzIGNhbiB3b3JrIHRvZ2V0aGVyDQo+ID4+IHByb3Blcmx54oCUc3VjaCBh
cyB1c2luZyB0aGUgc2FtZSBTUkFNLCBzaGFyaW5nIHRoZSBTQ1UsIGFuZCBoYXZpbmcNCj4gPj4g
Y29uc2lzdGVudCBtZW1vcnkgcmVtYXBwaW5n4oCUd2UgbmVlZCB0byBjaGFuZ2UgaG93IHRoZXNl
IGRldmljZXMgYXJlDQo+IHNldCB1cC4NCj4gPj4NCj4gPj4gVGhpcyBjb21taXQgbW92ZXMgdGhl
IFNTUCBjb3Byb2Nlc3NvciBpbml0aWFsaXphdGlvbiBhbmQgcmVhbGl6YXRpb24NCj4gPj4gaW50
byB0aGUNCj4gPj4gQVNUMjcwMCBTb0MgKGFzcGVlZF9zb2NfYXN0MjcwMF9pbml0KCkgYW5kDQo+
IGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFsaXplKCkpLg0KPiA+PiBCeSBkb2luZyBzbywgdGhlIFNT
UCBiZWNvbWVzIGEgcHJvcGVyIGNoaWxkIG9mIHRoZSBTb0MgZGV2aWNlLCByYXRoZXINCj4gPj4g
dGhhbiB0aGUgbWFjaGluZS4NCj4gPj4NCj4gPj4gVGhpcyBpcyBhIHByZXBhcmF0aW9uIHN0ZXAg
Zm9yIGZ1dHVyZSBjb21taXRzIHRoYXQgd2lsbCBzdXBwb3J0DQo+ID4+IHNoYXJlZCBTQ1UsIFNS
QU0sIGFuZCBtZW1vcnkgcmVtYXAgbG9naWPigJRzcGVjaWZpY2FsbHkgZW5hYmxpbmcgUFNQDQo+
ID4+IERSQU0gcmVtYXAgZm9yIFNTUCBTRFJBTSBhY2Nlc3MuDQo+ID4+DQo+ID4+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiANCj4gWy4uLl0N
Cj4gDQo+ID4+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9h
c3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+ID4+IDZhYTM4NDFiNjkuLmZmYmMzMmZlZjIgMTAwNjQ0
DQo+ID4+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4+ICsrKyBiL2h3L2FybS9h
c3BlZWRfYXN0Mjd4MC5jDQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4gQEAgLTYxMCw5ICs2MTksMzUg
QEAgc3RhdGljIGJvb2wNCj4gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19yZWFsaXplKERldmljZVN0
YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPj4gICAgICAgcmV0dXJuIHRydWU7DQo+ID4+ICAg
fQ0KPiA+PiAgICtzdGF0aWMgYm9vbCBhc3BlZWRfc29jX2FzdDI3MDBfc3NwX3JlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3INCj4gPj4gKiplcnJwKQ0KPiA+DQo+ID4gSSB3b3VsZCBwYXNz
ICdBc3BlZWQyN3gwU29DU3RhdGUgKicgaW5zdGVhZC4NCj4gPg0KPiA+PiArew0KPiA+PiArICAg
IEFzcGVlZDI3eDBTb0NTdGF0ZSAqYSA9IEFTUEVFRDI3WDBfU09DKGRldik7DQo+ID4+ICsgICAg
QXNwZWVkU29DU3RhdGUgKnMgPSBBU1BFRURfU09DKGRldik7DQo+ID4+ICsgICAgQ2xvY2sgKnN5
c2NsazsNCj4gPj4gKw0KPiA+PiArICAgIHN5c2NsayA9IGNsb2NrX25ldyhPQkpFQ1QocyksICJT
U1BfU1lTQ0xLIik7DQo+ID4+ICsgICAgY2xvY2tfc2V0X2h6KHN5c2NsaywgMjAwMDAwMDAwVUxM
KTsNCj4gPj4gKyAgICBxZGV2X2Nvbm5lY3RfY2xvY2tfaW4oREVWSUNFKCZhLT5zc3ApLCAic3lz
Y2xrIiwgc3lzY2xrKTsNCj4gPj4gKw0KPiA+PiArICAgIG1lbW9yeV9yZWdpb25faW5pdCgmYS0+
c3NwLm1lbW9yeSwgT0JKRUNUKCZhLT5zc3ApLA0KPiAic3NwLW1lbW9yeSIsDQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIFVJTlQ2NF9NQVgpOw0KPiA+PiArICAgIGlmICghb2JqZWN0X3By
b3BlcnR5X3NldF9saW5rKE9CSkVDVCgmYS0+c3NwKSwgIm1lbW9yeSIsDQo+ID4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKCZhLT5zc3AubWVtb3J5KSwNCj4gPj4g
KyAmZXJyb3JfYWJvcnQpKSB7DQo+ID4NCj4gPiBwbGVhc2UgdXNlIGVycnAgaW5zdGVhZC4NCj4g
Pg0KPiA+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4+ICsgICAgfQ0KPiANCj4gb2JqZWN0
X3Byb3BlcnR5X3NldF9saW5rKCkgY2FuIHJldHVybiBmYWxzZSBvbmx5IHdoZW4gaXQgZmFpbHMs
IGFuZCBpdCBzZXRzIGFuDQo+IGVycm9yIHdoZW4gaXQgZmFpbHMuICBTaW5jZSB5b3UgcGFzcyAm
ZXJyb3JfYWJvcnQsIGl0IGNhbm5vdCBmYWlsIChpdCBhYm9ydHMNCj4gaW5zdGVhZCkuICBUaGVy
ZWZvcmUgdGhlIHJldHVybiB2YWx1ZSBpcyBhbHdheXMgdHJ1ZSwgYW5kIHRoZSByZXR1cm4gc3Rh
dGVtZW50DQo+IGlzIGRlYWQgY29kZS4NCj4gDQo+IElmIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGlu
aygpIGlzIG5vdCBleHBlY3RlZCB0byBmYWlsLCBpLmUuIGZhaWx1cmUgd291bGQgYmUgYQ0KPiBw
cm9ncmFtbWluZyBlcnJvciwgdXNlDQo+IA0KPiAgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
bGluayguLi4sICZlcnJvcl9hYm9ydCk7DQo+IA0KPiBJZiBmYWlsdXJlIGlzIG5vdCBhIHByb2dy
YW1taW5nIGVycm9yLCBwYXNzaW5nICZlcnJvcl9hYm9ydCBpcyB3cm9uZywgYW5kIHlvdQ0KPiBu
ZWVkIHRvIHBhc3MgZXJycCBpbnN0ZWFkLg0KPiANCj4gPj4gKw0KPiA+PiArICAgIGlmICghcWRl
dl9yZWFsaXplKERFVklDRSgmYS0+c3NwKSwgTlVMTCwgJmVycm9yX2Fib3J0KSkgew0KPiA+DQo+
ID4gc2FtZSBoZXJlLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24g
LSB0aGF0IGNsYXJpZmllcyB0aGUgaW50ZW50IGFuZCB0aGUNCmRpZmZlcmVuY2UgYmV0d2VlbiB1
c2luZyAiZXJyb3JfYWJvcnQiIGFuZCAiZXJycCIuDQpBcHByZWNpYXRlIHlvdXIgaGVscC4NClRo
YW5rcyBhZ2FpbiBKYW1pbg0KDQo+IFNhbWUgYXJndW1lbnQuDQo+IA0KPiBbLi4uXQ0KDQo=

