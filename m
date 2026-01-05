Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB302C2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 06:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vceQ4-0000V1-T1; Mon, 05 Jan 2026 01:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcePu-0000Sk-8o; Mon, 05 Jan 2026 01:50:14 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcePq-0001BP-6j; Mon, 05 Jan 2026 01:50:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a32weVyG9jlYeYH1mjLRg2WpS6dHtSegG+iRKEyKh2CsNBuzftjeKNSM8aKDhrVJUELgIgvtNRHwh9FLoz5dMDbdB5jYxMJfRr5Undr84CT0ETIQFjHLDvZxd9lp3q0Ii9rO1lb0ELgNkHG/a9y5lYJMAPZ3K+X2vJ2m8qpmbQyYRj+Uv5AhVjiEbR0bcw4iQ3olZHYZMDimp2kGHETDY/P+9lZxa8NIlSS7uxnkLmYEv6w6NWQd3cUNxwYciXAhTYk/Jkqd6EtgMloPNzIxvE9LrvMxImKvkEuiyGIh1Z1lhgMsgm+TMS3y5Mhgm9pD+ZnUHa2K9PuDIb/WBQtqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDuu3IwRNbSZqWxklWw3jwJaE+p/yMlqW7V80ClbDAE=;
 b=VpW3SprWlUjFQ1dJearc66/9cbiErjrfM/X9F9tHoAJj7NaA4brX+MR4teS88ZGGq5tuQO57Fc7Ckd14kS5RFPu8FbbGD0lwIz/RbSeFFiCi8oMdcZYUqS4LeLC7MgiCS8TDGYc0DFUkKEyLEAJzr2dPb5WKW65dIoUH33hrB0SGPq0k/nTl5ApI8LQRQh4IM8H4kcRSWtRsCF+DYV9xTGEleD87sW76vJ7uaU5FWRZBOl+MG2pR9H3TgbThCWvM53sni4gNdVbMe8DSX8zmUhCh5RGlZ7JBE0YvAdGR2v3r4p7cTUbg+75likO2aWANdl+Ydu5Uco9/xKukPFVPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDuu3IwRNbSZqWxklWw3jwJaE+p/yMlqW7V80ClbDAE=;
 b=G6z8EcsbhGp2dXDP8HChFt8k2ISAtxKTZPi7HYFdqHhE3V6qUJfdXKUR1eDVGqrMSawhqsFLrNDTll8pnSFfeh8A6bMpZx/uIzC8JDUndA8BWGwkq1NuMqjtBK/Y7iliSoY8Lx1BcMLLl6s7vBX6tnQR7kyqRMD7UubzG0MoenH7fBvyAjpyx7wqezFO3dy90LlPbLsJathXE61y48XO0VBe2hX8VoO6QI5wqli4HvPTIGhjFV87kU+zup8MBjYjLphYAh5cPhjC8jdv6RDnMjKVWfkdcTE9Ig68bZ42/YyJVtnbtI3SQFWxL+ZgKQhIbuTleflyMVrkJ/MfGiud3w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYPPR06MB8052.apcprd06.prod.outlook.com (2603:1096:405:31a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 06:50:03 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 06:50:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 06/19] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH 06/19] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHb2/a6ZdC6p30rN0y/oNhjEpOzC7VEZv/g
Date: Mon, 5 Jan 2026 06:50:03 +0000
Message-ID: <TYPPR06MB820699FDFDAC4F1C1D290F64FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-7-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-7-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYPPR06MB8052:EE_
x-ms-office365-filtering-correlation-id: 3757f31d-49dd-4ccc-dbee-08de4c26a784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Wm9INHZWQ3lQVUVaendISlZKNGZsWTNuTUVGL1ZFbVZ0bExONG9rYWpEVWpV?=
 =?utf-8?B?cFBIbnZWbm43Y1NzQjB5V0FYL3VFYjVqd1I0MzFpbmNVU0t6RTc0VDZMcjN0?=
 =?utf-8?B?cVRxdVljdmJOc2hNd1dJWUpsbWcxUld3V2RFcU1uYllqU1F3RGY4VnNMRU9S?=
 =?utf-8?B?SDVtUVNmRkd5ZTVnMEZGRFBLd1NBVGdtczgrQThwcGM0NXhyNFJuNGtyN3pl?=
 =?utf-8?B?YWkyS1YxS0N3ei9YdXNrbTNTWVU4eHhGMUR6c3ZhY0U0QXNxZGgyc0NGaUxw?=
 =?utf-8?B?ci8zYzJVKzBpY0JpamRDV0JVRjNBY01scFNrM1dkYXZPaCs4RlZhN2lmYjZR?=
 =?utf-8?B?Tm1TbW91M003QTU1RjFIRzI3OEFtRlRvb1RMVDgzT0pOKy9rTHJLQXo5TmRU?=
 =?utf-8?B?emlZZkNraDdtWGxqR29lRzg4UXIzc2xkVk5kM2QxekE2S1c5Nnoyd2JKR01y?=
 =?utf-8?B?SnJlTUtMZXFBWmhFTmM4ZnpWRlNEMGxnTHMrWWYyYml4dXRzNzJ5NUljYzFW?=
 =?utf-8?B?anVHVWlhTnZQMFlUaWl3ZG56US9aS3pXUmR2NFNjUmo5NWFmcnZXUHpJdjZI?=
 =?utf-8?B?UVJ1V2ZWekY3TGhQcXhoL0R2aUtydnk2elF4YTBiaFpORHdDL25KeGFzNm1o?=
 =?utf-8?B?d256V3FKWXpHRnZ5a0RvS1UzTGpXUnJYaVZUMmxqaE1QaE9FT2E5em85RjZO?=
 =?utf-8?B?NDZUS3FDK2Z4M2tKazIzT0JKNENMZjc1Mzd3Uk1RT29HMWdMTy9Pa2FhUjFP?=
 =?utf-8?B?Q0JEL3pERXZyOHdpQ2o4RWpjM2xHcEVzVXRkMEpmQitYajhuY0YyT2tjUWJ5?=
 =?utf-8?B?VEtzMHZsZVJFN0pONXNMY2J0RE1QY3NoRWtmQnpsKys3dnpnaENwWjgyRzEz?=
 =?utf-8?B?VU1hYmtRWVI1TzlSWmgxS1B2VnlRYmZGM3Q5RjhWTDZxUFZBQkVCYUFKWEZZ?=
 =?utf-8?B?ZngyS3F0QXFoMjBiemRZbkNHZ2gwOURtRDY5czlabVN3YU5YYUVhblNnWUNM?=
 =?utf-8?B?K29OaUkycUJjaUVkY1NydVZGTGdxK0VqckFwSC9xaVpZaW1PU3hhYkhtR0hC?=
 =?utf-8?B?U1ZVUDdZN2UwMjJzVnBMazdDeUFWRGRSMS9kZm9yTHBPc0NRZENBQTE1ZlRq?=
 =?utf-8?B?Wll4Z1pUalNBaVVGUGw1c09SRU9hcGV2UTE5OU9NTGRYVTJweHVTMVhBSG80?=
 =?utf-8?B?b2ppWUlwdEZWaUdTVGJGTlBiZVFIOTdVVzN2azZMSysvVE1WRnVvbnZZQnpm?=
 =?utf-8?B?TVJ2d1hpMWlscU5zakdPTTlNSVBWZW1aekY1ZG4yZjU2WEdCdjYyZTZBMlNq?=
 =?utf-8?B?UUs2RUFYSmFmakVYSWxDNjlMVXhjNmJCekRuY1llWWpCbEk0TVJVOERGQVlF?=
 =?utf-8?B?dkxGOTdrSk42K2RqS0hJcE96cDU5bFptNjFPMlp0TWxEaWZsVmxVcnYxMm80?=
 =?utf-8?B?UXRrYndmLzJaelB3Z2loN3p2SUtwVmwzeDBOZ3FPdE1DNGtBZmtEbkhRaU5X?=
 =?utf-8?B?T2kvcEtsN1hGVU5JL3pWdVM4UnRwMDIyWU1EeUZxU21MMTcxOEdJWUdxU0lO?=
 =?utf-8?B?V2pJTFJnOTU0clZiMXpBMjQ1d2hzVlRtYzZrQ29sTXhHNGRtaU5acWtpKzk3?=
 =?utf-8?B?ZUs4QVZWSFg2bHJ3TVB3SDhhRnQ5dFRDMHVjQnJGNlVCYnZnNzg4NjZueVFD?=
 =?utf-8?B?bSt4RHJZa1N3WGt1SDJVbFZTRVZqVHNIa1dRTkJzaVEyc2ltTXNFQW9QemZO?=
 =?utf-8?B?WDBndkw0dzZ4ZE00QVFuaTZUOFRuRUJZeGV1NlRxTWpmNlpCYktjb2JicXNZ?=
 =?utf-8?B?NTRaM1FVZm9vT0RtSGp0YWlmNjBxZmpHdXFPVTduc0RlUVdIK0owUVAxVEJQ?=
 =?utf-8?B?N1BlYm1Gc3dGSUxQcG9LNUQ5NTROQ3pQaStFVjBERHBVRlRlbWF6QmVQc0tS?=
 =?utf-8?B?MkFlbjhwTHhsdy93bXF3QnloeG1sa2Y0MFJPZWFrbnYxNUFwR0pRaHFqZ3Q3?=
 =?utf-8?B?TG8rOUZGK2FrMUx3MnRmSThwbm1ZWXBpZEJOVzI4REhXQmZOai8zTWpVcDNI?=
 =?utf-8?Q?C1SKO3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUdyaHpmSnRFbEJYdTNzWEhNMGYyYTNCV3dUVW56akNoeTNHN2NSTng5N3FS?=
 =?utf-8?B?eE83UGk0WWlrYnN6ejlucS9RTFA4eXREaHBCSFoybHkzREIxWXVGdGZtUjMv?=
 =?utf-8?B?RXM3dmZzTmd1T3FvNzVuVFRDL3QwOTltMXZ0VjJmRUE5VUEvdjNuMkdleE15?=
 =?utf-8?B?UndMYmsvNGwwQ1R3VnluYU9ZRU9LczUvRTB6UWVHbDVPUkVTMWMvbHFHQlF1?=
 =?utf-8?B?a3g1eWh2YWtEY2JSYUdZbXpHVkNiNTR2eG5MbFQwNDZRZnpRVHkvMDVWRG5v?=
 =?utf-8?B?NGd3dEgwTEo5Q0syN2Y1RDlhS0pRK2ZZaUhPQS9wblpzSDU0cDF0VGQyRkd0?=
 =?utf-8?B?VDQzRDh3d0hmSUZtS1I4U0h4Q3VFbHMrNGNROUZjSXNNRFhaRjBBOFZNTWh2?=
 =?utf-8?B?UzZjck5GM21TYmRleE1DR1lFTW1ZK3lyaUJoNVA3dFlIaHhGdGo4SjFwVHpz?=
 =?utf-8?B?VG1QbTdOdThTdW9rQk5Qa05RT1dqaElmODY3dG0vUERyN0xmVUtwMEEwMGc0?=
 =?utf-8?B?aHBhWmdiVkM0TXFXSTNMVGFVbHdERHRWeUZocnlXVmRyQytGbkJrZFB4S1A3?=
 =?utf-8?B?MmZ5T1JqeDJobVBqbGhKazRxQzlSeEhISmRsWTJ6bEhNSlFkUm81UFFkbTdU?=
 =?utf-8?B?WFNJQ0Z4Z1ZmTG9iaktQdG5lMGRqeUdrRlFBN0ViekpsSkhkU0U1VERmckxi?=
 =?utf-8?B?bWZYL2VnZjNQTkQ2QVN0eVJRalFpMUpoL0dCRFNOdnNUSCtsQ3Jvb3puQWNL?=
 =?utf-8?B?VzFXV1VVTS9UeDFmSjdJWWlBeWV0WEEyTWJUTVNaVDNFT29FOHJLNEROZWh2?=
 =?utf-8?B?cnVqa3MzUmdMWFErSDF0a3RtdFE2R0tybXdUYjRDSW50UXZuaUhVMnova0xJ?=
 =?utf-8?B?NVkvMDVWTHVMcFAzamxuNEwzaU9sNWhCVVdYaVlCbHFORHFrZTN6aWV0czNO?=
 =?utf-8?B?bUM4RzlmSnVSMWlrS1hjSjhJOU94bnZhNXNkTkExdjBOOHJYS3I5N2QyY245?=
 =?utf-8?B?MEQ4czNHR1crYW5UUDdJVWtjSlk3MlFyRUlBOGt2WkhlQXIzK3dBQ1l6TG5D?=
 =?utf-8?B?Uy8vUHZEKzFHbnZNU0laWTFaQ2hMRWl2Q1B4endEMjY3S1N6ZE0wc2s4blpI?=
 =?utf-8?B?Q1dxRm1LV0hxczBmRWU1alZyTWlFV2dYQ3BXOVZ4NEhmcHBkdmZOYUhsVUdk?=
 =?utf-8?B?ZmMwOHhIN1VoQ3F1V25zT0Jyb3BKZHkyUDFkd0RRK0JWMmFTLzAydEdJYkRv?=
 =?utf-8?B?NUhxYTdzRmtrcHVmTlErczhKNVRjOGxDNXM1ODFRU1FBSXk3NkoyL2FDNzVO?=
 =?utf-8?B?YzdKRlcwanI4YjFkakpmOFJ4WDZTd2JBenVyVWticm1CcDdQVURJSWt4SFdx?=
 =?utf-8?B?WVpNMUZPZ0l2U1N6bkxNc0FpSVpBb1R5UUx0c1daNEEyMWtLNDVSQXBvUlFO?=
 =?utf-8?B?SG93WWY0cWZlOVFzb0ZNWkErcE5DRjg4MVdqRHMwazJiNTdVcVF1VkNRVm9I?=
 =?utf-8?B?N1dpeUQ5K0dHQnhFa3JnODdNelh1dTFPaGp5RUxtS1ZDUUhpVlFPdG0wa2tJ?=
 =?utf-8?B?dlJ5TDFnMUJTbGVpWFVxM1Q3KzZCNkRzMjlHV2JHMXd1OXUyWjBZNVNCbGFE?=
 =?utf-8?B?aDBPSHMreU81V3BqbHo4cUtIc0JMSk5VeVRKS25nbTFVRU51MVBKcmFsZFZS?=
 =?utf-8?B?cVY3WUhRVDZ4RkRQWUZCYTNRMVVYU1ZyNnhxbi8zTmd1eWJ2SUNOS010WG5I?=
 =?utf-8?B?VXZIT3lucHpkdmZWOENDY1o0a3IxaFhxOWJ4MUlyU0JUNGFyQy8zcGR2aWlV?=
 =?utf-8?B?RWx1QmVlR25Hd3JnalBVTy9mdjZQNmlOYnpzc2M3cEdrTnczNm5Vd2xiVzZL?=
 =?utf-8?B?K2FiNTh4ZUpEMW0xTWNRcWw2ZmJWUFZvUElhdURjSGFwZFN2UEZCZEppVE9s?=
 =?utf-8?B?QzVGeHVrZEhTOVRlK2RhUmtXRG5ReWVGNEVVdFJWbTNhM25kdFh0S01jRkdT?=
 =?utf-8?B?eENsL3VvNXJ5aDRtYXFkU3IyQlJNSzZZSkVsM0djT3QvSFdVL2kzNGJGZlRo?=
 =?utf-8?B?eVZ6ZU5NdDVrS3ZFd2xUUFhsR05Cd0xLL1g5QWtXQzNJSVgzejdPMUxaeTFh?=
 =?utf-8?B?RndQbFpPRStnNEVhclBTOUwya3ZrSGo5VnlEdGlWemM1MmdMNDVwUS9nNzFQ?=
 =?utf-8?B?UXlEeUlVNFIwSjduV3pQZFZoMjBZa1RRV1RhQk5FbEdxQVoySXpFVXdlNHJB?=
 =?utf-8?B?RnRZV1pzSTBlaXlRY3MwSzhjOEJvaUFlbXM2akFGQVdCQzN1MGV6aXZyeTRB?=
 =?utf-8?B?OUFnMEZsMlYrQjJFMUwvU1NhYUJ3eDhzV202QUM4Rk9OUzdkTzNXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3757f31d-49dd-4ccc-dbee-08de4c26a784
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 06:50:03.5924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pR3hCQ8zzhGoOit7mi2hMRl/agsWIYudGtApGcLQ44Xit7QRAB4hQ5FI2xszJLajKZRnGQXPZOaCb3RE+w7P4Y6R7qPPYksRXqJZfdTr+Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8052
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDYvMTldIGh3L2kzYy9kdy1pM2M6IEFkZCBtb3JlIHJlc2V0IHZh
bHVlcw0KPiANCj4gQWRkcyByZXNldCB2YWx1ZXMgZm9yIHRoZSBuZXcgcmVnaXN0ZXJzIGFkZGVk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBQYXRyaWNrIFZlbnR1cmUgPHZlbnR1cmVAZ29vZ2xlLmNvbT4N
Cj4gLS0tDQo+ICBody9pM2MvZHctaTNjLmMgfCAyMCArKysrKysrKysrKysrKysrKysrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ody9pM2MvZHctaTNjLmMgYi9ody9pM2MvZHctaTNjLmMgaW5kZXggYjI1Mjkw
M2VhNC4uODQ1ZmJkNWVmZA0KPiAxMDA2NDQNCj4gLS0tIGEvaHcvaTNjL2R3LWkzYy5jDQo+ICsr
KyBiL2h3L2kzYy9kdy1pM2MuYw0KPiBAQCAtMjg1LDE0ICsyODUsMzIgQEAgUkVHMzIoREVWSUNF
X0FERFJfVEFCTEVfTE9DMSwgMHgyODApDQo+ICAgICAgRklFTEQoREVWSUNFX0FERFJfVEFCTEVf
TE9DMSwgTEVHQUNZX0kyQ19ERVZJQ0UsIDMxLCAxKQ0KPiANCj4gIHN0YXRpYyBjb25zdCB1aW50
MzJfdCBkd19pM2NfcmVzZXRzW0RXX0kzQ19OUl9SRUdTXSA9IHsNCj4gLSAgICBbUl9IV19DQVBB
QklMSVRZXSAgICAgICAgICAgICAgID0gMHgwMDBlMDBiZiwNCj4gKyAgICAvKiBUYXJnZXQgbW9k
ZSBpcyBub3Qgc3VwcG9ydGVkLCBkb24ndCBhZHZlcnRpc2UgaXQgZm9yIG5vdy4gKi8NCj4gKyAg
ICBbUl9IV19DQVBBQklMSVRZXSAgICAgICAgICAgICAgID0gMHgwMDBlMDBiOSwNCj4gICAgICBb
Ul9RVUVVRV9USExEX0NUUkxdICAgICAgICAgICAgID0gMHgwMTAwMDEwMSwNCj4gKyAgICBbUl9E
QVRBX0JVRkZFUl9USExEX0NUUkxdICAgICAgID0gMHgwMTAxMDEwMCwNCj4gKyAgICBbUl9TTFZf
RVZFTlRfQ1RSTF0gICAgICAgICAgICAgID0gMHgwMDAwMDAwYiwNCj4gKyAgICBbUl9RVUVVRV9T
VEFUVVNfTEVWRUxdICAgICAgICAgID0gMHgwMDAwMDAwMiwNCj4gKyAgICBbUl9EQVRBX0JVRkZF
Ul9TVEFUVVNfTEVWRUxdICAgID0gMHgwMDAwMDAxMCwNCj4gKyAgICBbUl9QUkVTRU5UX1NUQVRF
XSAgICAgICAgICAgICAgID0gMHgwMDAwMDAwMywNCj4gICAgICBbUl9JM0NfVkVSX0lEXSAgICAg
ICAgICAgICAgICAgID0gMHgzMTMwMzAyYSwNCj4gICAgICBbUl9JM0NfVkVSX1RZUEVdICAgICAg
ICAgICAgICAgID0gMHg2YzYzMzAzMywNCj4gICAgICBbUl9ERVZJQ0VfQUREUl9UQUJMRV9QT0lO
VEVSXSAgID0gMHgwMDA4MDI4MCwNCj4gICAgICBbUl9ERVZfQ0hBUl9UQUJMRV9QT0lOVEVSXSAg
ICAgID0gMHgwMDAyMDIwMCwNCj4gKyAgICBbUl9TTFZfQ0hBUl9DVFJMXSAgICAgICAgICAgICAg
ID0gMHgwMDAxMDAwMCwNCj4gICAgICBbQV9WRU5ET1JfU1BFQ0lGSUNfUkVHX1BPSU5URVJdID0g
MHgwMDAwMDBiMCwNCj4gICAgICBbUl9TTFZfTUFYX0xFTl0gICAgICAgICAgICAgICAgID0gMHgw
MGZmMDBmZiwNCj4gKyAgICBbUl9TTFZfVFNYX1NZTUJMX1RJTUlOR10gICAgICAgID0gMHgwMDAw
MDAzZiwNCj4gKyAgICBbUl9TQ0xfSTNDX09EX1RJTUlOR10gICAgICAgICAgID0gMHgwMDBhMDAx
MCwNCj4gKyAgICBbUl9TQ0xfSTNDX1BQX1RJTUlOR10gICAgICAgICAgID0gMHgwMDBhMDAwYSwN
Cj4gKyAgICBbUl9TQ0xfSTJDX0ZNX1RJTUlOR10gICAgICAgICAgID0gMHgwMDEwMDAxMCwNCj4g
KyAgICBbUl9TQ0xfSTJDX0ZNUF9USU1JTkddICAgICAgICAgID0gMHgwMDEwMDAxMCwNCj4gKyAg
ICBbUl9TQ0xfRVhUX0xDTlRfVElNSU5HXSAgICAgICAgID0gMHgyMDIwMjAyMCwNCj4gKyAgICBb
Ul9TQ0xfRVhUX1RFUk1OX0xDTlRfVElNSU5HXSAgID0gMHgwMDMwMDAwMCwNCj4gKyAgICBbUl9C
VVNfRlJFRV9USU1JTkddICAgICAgICAgICAgID0gMHgwMDIwMDAyMCwNCj4gKyAgICBbUl9CVVNf
SURMRV9USU1JTkddICAgICAgICAgICAgID0gMHgwMDAwMDAyMCwNCj4gKyAgICBbUl9FWFRFTkRF
RF9DQVBBQklMSVRZXSAgICAgICAgID0gMHgwMDAwMDIzOSwNCj4gKyAgICBbUl9TTEFWRV9DT05G
SUddICAgICAgICAgICAgICAgID0gMHgwMDAwMDAyMywNCj4gIH07DQo+IA0KPiAgc3RhdGljIHVp
bnQ2NF90IGR3X2kzY19yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwgdW5zaWduZWQg
c2l6ZSkNCj4gLS0NCj4gMi41MC4wLnJjMS41OTEuZzljOTVmMTdmNjQtZ29vZw0KDQpSZXZpZXdl
ZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkph
bWluDQoNCg==

