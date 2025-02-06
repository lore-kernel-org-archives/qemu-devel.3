Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0249DC02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 07:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwDt-0001Th-HZ; Thu, 06 Feb 2025 02:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfwDm-0001S7-32; Thu, 06 Feb 2025 02:22:46 -0500
Received: from mail-psaapc01on2071d.outbound.protection.outlook.com
 ([2a01:111:f403:200e::71d]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfwDj-0007Xn-N4; Thu, 06 Feb 2025 02:22:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPP/clo3mHi5Y0RYZeqGRuPVDwD7xI8YrKJj8kNdTOEojFJIRqOYFCIvthSjO/60UEYCICxtevC+TcI8Dm5j7erCPKU9IlqT7ni9pEts84jcLnIm4+U//xHqhmWFeJdF4uqY/LPpYD6VPQc1erWNr8QIlqV8DWXQAJL8JsU9q73sgkishtkhn5KyEUdv3QPrraP3HXmUT0XA7sowR6IOXFkpZcgorjYwp2V41LPdYGSLKZ9aOOwkP+6njcHnNplU7CwrLK990LLLRoNEQYuEU3zKPyxl6vyZ+/dv4GrKvw52tK3PKpfJDMHFtPvfHPSBZ1215aD6fuelPGxWbzQHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbCzmf3LtaV9dmHOmnu5j8J9CvqlKgHM48G5ySCiR5c=;
 b=bYvaY6DYv37/x7QWxSPZ7nYwvpINoTLknC4p44CqJrU9BhZbCQRNNzyPSoSp2hDMqLfTGJ8ybMMO9L0zdSv1tbA4eBbDbi0leYXs+hX48+ZS1GxuNpHGRrfdhq/iJibYXw2mX1gJ/UBbX/4ZVy/uG0RKpPADFs9M8jq+XjVyEeCigYIDT+Zc+pzNr8MdGg+VZWWqbY+6OYjFeg7Oyb8obzeApbv1LlNsXDZ+qJDhC0lhn+xMGBlSTCHzQmy/Ybsz7bbTOGjD0UDaM8jxGiUrRPt2nm3q7GW+//nayQYCMWUju1sAIpMdCanlbBg2CpTRjyoAa00GsM/aW78iWEceSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbCzmf3LtaV9dmHOmnu5j8J9CvqlKgHM48G5ySCiR5c=;
 b=rIehNOmIKlu5oo0vmXqSNtXOHLZAQ1AAZnir3yis6Ow/44Mqo6PWpIIIVkeLklf1AxKQHjUuId/2/Tn6UdgvezhJvdz5eP+T39yEHlGO+evkLQ3psF2r+hvcEoAceo9OtZzaOFUPd79TwpTK1p+S7OPEOpDdNVKcyOBOBwCvdqqOanbFkTYfJg9tFf9erL3LwpaIgPogCxpZ4inL7jDdb4qyxAX4/RWSsTr+f5WNFLCZAY0I5aOKimsmCz99ROLadMi74jLAunmNiKTisG4NgMxn187uOsY9Nq6+gOlStytKAPIkU27DR9Iba8S4QH3FZKFAc6rq5sktmS74t+jnOw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5835.apcprd06.prod.outlook.com (2603:1096:400:31e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Thu, 6 Feb
 2025 07:22:28 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Thu, 6 Feb 2025
 07:22:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Joel Stanley
 <joel@jms.id.au>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of
 INTC controllers for AST2700 A1
Thread-Topic: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of
 INTC controllers for AST2700 A1
Thread-Index: AQHba9LAR+6tJtZgg0OzH5hIXoiXmbMuxMkAgAgoeYCAAT1PgIAANmFAgAEVwoCAAFhTgIAAA6PwgAAj7YCAAABsYA==
Date: Thu, 6 Feb 2025 07:22:28 +0000
Message-ID: <SI2PR06MB50410AD58647FFAA3CE822CDFCF62@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-13-jamin_lin@aspeedtech.com>
 <cb18b72dbfce3a606a4bd7ea41732d451fbea0f1.camel@codeconstruct.com.au>
 <SI2PR06MB50414F9067112317161AD907FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ad26f753de3648a2b238514ac7136847a2ae3a71.camel@codeconstruct.com.au>
 <SI2PR06MB50410511510D84B854672E8CFCF72@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <64d943d2e53c70ca55b33ec7a9b103368d72acc0.camel@codeconstruct.com.au>
 <CACPK8XfaJKPObz+FuRQhP7SSxPCV+KNaeFgT+U0id6HhYQ0Fdw@mail.gmail.com>
 <SI2PR06MB5041B6BB13FB75F73E0DA27BFCF62@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <e2a35cdf-746d-4181-b5b9-525f7886e760@kaod.org>
In-Reply-To: <e2a35cdf-746d-4181-b5b9-525f7886e760@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5835:EE_
x-ms-office365-filtering-correlation-id: 0cbe0c40-7563-4097-3a6b-08dd467f0320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejhPTC8rbE5lNW5aMTVWUlh1WUZ3ZXdSTHUvZUpFNlZzWEplZ25IcWkxdisr?=
 =?utf-8?B?VWs5ZVZzNkoxc05ZMmYzbzlWa2xVa252ZUM3d2twaDRFU0Zyb3hTSWpRZTgv?=
 =?utf-8?B?QTFhc2RqSGtqNjZKYlg2UFd3R1dzYlMrRU9XdWc3cC9LR0p0aDV4dWkrRlIr?=
 =?utf-8?B?SUsyZHdUN3cxb0ZCaGdCN2hneklpdE1BYzA3V2lHcmp2QklTZDlyWEpxdGRl?=
 =?utf-8?B?cTljdFFIWDM1VStxWlJXd21ZRzF1YlByZWpRUGgvYXVjRXhNT3hGOW1YMkVL?=
 =?utf-8?B?L2MyZmFoUU5CRnFOYTBNblpjVUp4RkFac1NIVE5vSm1ralVhODJ1Q3FpakhF?=
 =?utf-8?B?aTI5SjN3Kzl4R0JOSFYrck5JUFBXdGtUZGFWOXRBWGRWN09yN1hzU090TFdQ?=
 =?utf-8?B?NThiNGdPY1JFYXkwSGd2a2kvVWtpL2NSOGhtcjBIY051b013Y0xLT0VjejIv?=
 =?utf-8?B?Y2oybVdKNGxpcFRsNEs4UkExRkduKzFrd2RKbGpqanhrTzN5ZlRxbTcwaWRH?=
 =?utf-8?B?MjJFRCtnRFo4aGI4LzdTcnZJa1N1NXZrUXFUdWNvZ0VKUVQ2S2dOUm9STnV5?=
 =?utf-8?B?MUIzWDhUblVFRnhJL1BmQjlJYklUTG5MUUdKMERLc3I4ZVdJT0tTY3h1cGdF?=
 =?utf-8?B?OGFzS3ZuWlJlQ2xmTzZCS2kxaFczNnBBQnZiQ2k1NVFseUE3UU5BUE13dG0x?=
 =?utf-8?B?ZisyYjNJcElES0t3NjhIK0Z6TitvczBFbUJrdCtaWENTa0krcERyYmhFNTlM?=
 =?utf-8?B?WVN1TWhwZWJMKzB6WmZ2TkdMR2p6Q1dZNnl1dGE4cHN2Rk1WNXBZQXFoZkQ5?=
 =?utf-8?B?djNwdE9ZSnJDOFZ1SjluZXBHQkczcys5eDBnbVZBRGZ2VzBTMzNBUlpuUzJQ?=
 =?utf-8?B?SE40VlRDWkNvSFAxQ29CTHZIZ2tqbUt4TVc2UXo2SlhNaW0raEtpWU16aFFB?=
 =?utf-8?B?OUNoaXNIWURzWWg1aVEwTkdvaFhEcXZmTFJmak81SlpVcWtpSW9ROURFZ0xI?=
 =?utf-8?B?bUMrRUFwK0FlNDlCQU1LMjQ4STJiNVVoTElpdXNOT2JQT3FwMzJDeURBcVlk?=
 =?utf-8?B?VTBOaGpVOWVFUm5iTEU5aHBMNDNSYU40UmpoREZEcVoyTW1tNmFmVTBxazVv?=
 =?utf-8?B?YmhRbHVQZ2RrcnU1VHV4eVVJZUxMM2FOck1MdWh2VTlRNTQwNWVXbE5MYjYy?=
 =?utf-8?B?WjVzVU5qaDFvZ3BsbHh1YVdvK1lHQTlRcHQ3Z1V2TExGOE1mRmJJRGV5TVZu?=
 =?utf-8?B?NnMwNDY5THByVmtUdzBicUtDbERUTjFwVE1MN1JkU3luMXIyM3E4RFkrN3RU?=
 =?utf-8?B?TGVXMnI1VWNsRkJTdVBicUNIY0pXMzVZVE5Oczc2OEhGRWNUVUxnamU2elZW?=
 =?utf-8?B?cG9MdmFsbXNLOGl5OWwwa21Ca25velg4MGVNM2s2UTRVT3ZEMlpmWkNyNEZ5?=
 =?utf-8?B?OThXWXVuN245bm5relZhLy85Q3lkakFHUDlmc0F3clhEVE5uRldscmNzSnpP?=
 =?utf-8?B?T2xyVGY4NXN2dy8vZEdCdWkwUWdtRFkvcDR2V3ZJN2p1VmpoNXVQL1ZRTzJP?=
 =?utf-8?B?dmIwb3NveHZVTHA0QW5qV1VIRFNUR1h3SDZCNnpsWXowUDVMOUVYYU44RTNw?=
 =?utf-8?B?SjZnTW5OVG90ZXUwaytJTXl0MnVZMlNmdnVFbFZFd21Oc0J2eW9LK0dUM1Qx?=
 =?utf-8?B?dFVQd29DQ1RySUFqUk80R3I5WW4zcmlkUWFOL1JQTmgwYm8zdGRDNUdmcmVq?=
 =?utf-8?B?VnUzVDhkQTlmS3ZFcDFnMUh2V3BseW0vYUpBMGQ3LzBmTmIrY3J3b1dvSDJs?=
 =?utf-8?B?eUQ5WXVZd0djenZMRzNiaE5SMzlQMmRKSmhjaWYvcGhJYVFOUkZ5dWRNNGtC?=
 =?utf-8?B?eG1sSlVzWXpWaVpwK0VBVXVmRENNL3NKWDI2TlEzdzBJTkFsM2pVTkJEZy9a?=
 =?utf-8?Q?dCkZvSJ7UItJ2ugK0TY8xK/8CY4OBZAy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2k3ZmQrbGpwYlNrb3F4WCtWVW0wSUQ2aUJTR0NUK2V3a0Y4ZXdmU09uWVNu?=
 =?utf-8?B?TWVOU2pYeG5GQzNqc1lBYzc0blFUVTYzdERaUDRUa2sxR3MwUlZrSno5MGd2?=
 =?utf-8?B?cURHVHYrdW53VlVZZ3ptVXRNVWgvV2lwNW9tcTJWTkVlM0MwQ0swZW5sczNz?=
 =?utf-8?B?TFN5WVROZDhRaStaU2dKOHBTdDk2dXFmWTAxcVNXS0o0UzdrSzY3Z1ZZVm1V?=
 =?utf-8?B?d3V0WWpWTXc2ZGg3MXBCTWMwbG5nU002TUtnYjEyQ2VZVVN2b2c3ZnM0YWJP?=
 =?utf-8?B?NlJna2lGbGNMSjlXUUtMQlhQbGI4K0MrWVV4RkMxZFNzcTBvOG0yMGRScldD?=
 =?utf-8?B?MVBHT2EyV2p5VlM0aUYrdGhCQXRMYTZSbkhZVTJ4TjNwYjROeEt4UFA4cEF5?=
 =?utf-8?B?TW5Ga0lQMFU3QkZZUnhaYUpUOVE2WDVUUTZFVzJ1YkYybFRUa2FGOWFwa21P?=
 =?utf-8?B?MlBwOGJ2NWlUWFozQXM0djRlSk9OUGo4WHlJei9yYzJ5aG5laXVhcW85VXZR?=
 =?utf-8?B?SDdFZlU0U0pVRWpSTTJmS0N0MjdVZFc2TGNQSjVxOWNXd28rWXUxSEdpM3o4?=
 =?utf-8?B?eURybmdEK20xYy9IVnhnTUdQczlFcG0wRWdReTJ0OGxDL1NweXZzV21VdEU0?=
 =?utf-8?B?ZTMvbmxEdmx6RkNsOGNxemtPejFoUG9YVDJFNlJuSEJmWE5HUVNIS0N5RUVC?=
 =?utf-8?B?cHFMM1JzOVJsUXA0S2YyRFpmQ2ZsR3JMYjdwbXpTbUV6ZkkrWGFMdG85dVBZ?=
 =?utf-8?B?V0w1dUNXaGlVaGliUkUyYmt0RkdMMHptcmlXc2FlK2k1ZXEzMzAxSlUwaUFQ?=
 =?utf-8?B?T1lrRkFtdzN3NTlrNmNybTN5MU85bU04aTNFQXZlV0pndm96dFpXVU9obEdX?=
 =?utf-8?B?ZUtvdlVlVDdsWElTTXRnMU1FZ2x3MHltR2tFY0JEeXNTZzFqNW54bGlvajZp?=
 =?utf-8?B?b2o3c2haRllRQkZaK1RYejVZRGl2TDJ0dXozeWlybm41L3l1K1ZHUzFwV1ZY?=
 =?utf-8?B?LzA5SjJ0bDRpZFFoRnJlMGZ6NFo3czg3TE1VaDlmeFJpeU5VZDJ0ajRYbDJx?=
 =?utf-8?B?S2FoRUFOU1hzRERBTkFjeUtReVkwUkEzTFc1OGs3U1lmSi9SeDUyd3FkSWJ1?=
 =?utf-8?B?WlcwbXVYRDRvanhlWDA2dlBnamo5ZTNheEkyeHRxZ3M0VEJ4VHZlSFBHcnMx?=
 =?utf-8?B?QlR0anZSa3g2ZlJBMXNqb1NUdjNpUmZ6bFdDODBGYllYMHJnd3k3M2lMQnAx?=
 =?utf-8?B?djVwWG9SOTVienNKOVdyNUVZbXRvK1hUa014S0s0Wk5qZFJJTkVHYWdrQ2sx?=
 =?utf-8?B?R09oSUNXUkhONVlYM1BRblhiRzlXeTlVNXFVenhQNW4xMUpWTVgxN3B2SVpp?=
 =?utf-8?B?cDBvSWdOaEdGNWZHN0w4UzFRNVVaR2dJVmtyZFVuTHE5cS92SHovcjJVeGFP?=
 =?utf-8?B?bGQvLzZzNjNvNG1LR3VtelRiMzFDWEhHSytLQ0tiQzI0dGk4ZFdKclYxdnM5?=
 =?utf-8?B?MTZqUUxXR01qVTFXOHFOaUhwNHZZN2hVdG5SakpnL3N0bEw4K1ZuS2k5QTgy?=
 =?utf-8?B?T1pwWFZQTEM1L3BBZVRvU2JicTIrQ29udTQ2TzZEQ1RuclZpZTd5QjNabFNG?=
 =?utf-8?B?VGl0alBNVTFzMGNmMEhhRkREQnJmYlk3cVBRMXlmTmd6WDM2S2sxSGhJNmZJ?=
 =?utf-8?B?NHRrbTVZaVRENURUN1FaK1R5UjNPZGdzQit4RHh1S1RxdjNnRnpyMHRjM1Ez?=
 =?utf-8?B?TmQ2cDV6S2lBOENROGwvNjl3Qy9jUmdxcXlPZWtGUk5scU03NzFZS1J3a1N6?=
 =?utf-8?B?YlFCNTBnQTJKSXBsTW11d05UeTFtMnRDQVdTT3h6MjgvcVlKUEg1RnpWdkJY?=
 =?utf-8?B?endDWXZHM0I0cGhnQzBPWFN3MTdKTlB5T0VVMUlSMHhNWU1tdFpHVzF6dWlD?=
 =?utf-8?B?bElzeENOQ0J2dUI5TVpLQ2s5LzVham5XZUl6bUFVbi9KbXN2OERmam1vMzN2?=
 =?utf-8?B?U1NPQ3NJdFU1TmFlU2pwbEswcHVoK0NDSDQzTTN2OVhWL1RkTzF1dnR3Vk1C?=
 =?utf-8?B?eTNnZ28yN3FocWZFNmR4KzI0WEhZTm4yWmZHRUVmdm1VUUNXRVdaWGRYbit4?=
 =?utf-8?Q?Ea9iYvpusfSuPZX5FU2lS95f/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe0c40-7563-4097-3a6b-08dd467f0320
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 07:22:28.3673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6DufA2EgYL5u6pBhoCQJgT0HxziN2xO+YI1Z+0X87e3h7ywXNUwM3ZTtL94OCirH8/E+L0511hdz9MwmjLlyDDTkk1d+WPEuec3OMsNq8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5835
Received-SPF: pass client-ip=2a01:111:f403:200e::71d;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 THREAD_INDEX_BAD=3.197 autolearn=no autolearn_force=no
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

SGkgQ2VkcmljLCANCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNiwgMjAyNSAzOjE3IFBNDQo+IFRvOiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQu
YXU+DQo+IENjOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8
c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNv
bT47IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47DQo+IG9wZW4g
bGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBUcm95IExl
ZQ0KPiA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZyA8eXVubGluLnRhbmdA
YXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTIvMThdIGh3L2FybS9h
c3BlZWRfYXN0Mjd4MDogU3VwcG9ydCB0d28gbGV2ZWxzIG9mDQo+IElOVEMgY29udHJvbGxlcnMg
Zm9yIEFTVDI3MDAgQTENCj4gDQo+IE9uIDIvNi8yNSAwNjoxNSwgSmFtaW4gTGluIHdyb3RlOg0K
PiA+IEhpIEpvZWwsDQo+ID4NCj4gPj4gRnJvbTogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5h
dT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjUgMTI6NTUgUE0NCj4gPj4g
VG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+PiBDYzogQW5kcmV3
IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEPDqWRyaWMgTGUgR29hdGVy
DQo+ID4+IDxjbGdAa2FvZC5vcmc+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+OyBTdGV2ZW4gTGVlDQo+ID4+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJv
eSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgb3Blbg0KPiA+PiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPj4g
PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNv
bT47IFl1bmxpbg0KPiA+PiBUYW5nIDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMi8xOF0gaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBTdXBw
b3J0IHR3bw0KPiA+PiBsZXZlbHMgb2YgSU5UQyBjb250cm9sbGVycyBmb3IgQVNUMjcwMCBBMQ0K
PiA+Pg0KPiA+PiBIaSBKYW1pbiwNCj4gPj4NCj4gPj4gT24gVGh1LCA2IEZlYiAyMDI1IGF0IDEw
OjA5LCBBbmRyZXcgSmVmZmVyeQ0KPiA+PiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pg0K
PiA+PiB3cm90ZToNCj4gPj4+IFRoYW5rcywgSSdsbCBjb25zaWRlciB0aGlzIHVwZGF0ZWQgZGlh
Z3JhbSBhcyB3ZWxsIHdoaWxlIEkgcHV0IG15DQo+ID4+PiBvd24gdG9nZXRoZXIgZnJvbSB0aGUg
b3RoZXIgcGllY2VzIG9mIGluZm8geW91J3ZlIHByb3ZpZGVkLg0KPiA+Pg0KPiA+PiBXaGVuIHlv
dSBzZW5kIHRoZSBuZXh0IHZlcnNpb24sIHBsZWFzZSB0cnkgdG8gc2VwYXJhdGUgeW91ciBjb2Rl
DQo+ID4+IGNsZWFudXBzIGFuZCBtaW5vciByZW5hbWVzIGludG8gYSBkaWZmZXJlbnQgcGF0Y2gu
IEl0IG1ha2VzIGl0IGVhc2llcg0KPiA+PiB0byBzZWUgd2hhdCB5b3UncmUgYWRkaW5nLg0KPiA+
Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEpvZWwNCj4gPg0KPiA+IFRoYW5rcyBmb3Igc3Vn
Z2VzdGlvbi4gQ2VkcmljLCBhbHNvIG1hZGUgdGhlIHNhbWUgc3VnZ2VzdGlvbiBpbiBwYXRjaA0K
PiA+IDAsDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2
ZWwvY292ZXIvMjAyNTAxMjEwNzA0MjQuMg0KPiA+IDQ2NTk0Mi0xLWphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbS8NCj4gPg0KPiA+IEkgdGhpbmsgSSB3aWxsIHJlLXNlbmQgdGhpcyBmaXJzdC4NCj4g
DQo+ID4NCj4gPiAxLiBJTlRDIHJlbmFtZS9wcmVyZXFzL2NsZWFudXBzDQo+ID4gICAgIGh3L2lu
dGMvYXNwZWVkOiBSZW5hbWUgSU5UQyB0byBJTlRDMA0KPiANCj4gSSB0aG91Z2h0IHdlIHdlcmUg
a2VlcGluZyBJTlRDIGFuZCBpbnRyb2R1Y2luZyBJTlRDX0lPID8gQXMgeW91IHdpc2guDQo+IA0K
DQpZZXMsIEkgYW0gd29ya2luZyBrZWVwaW5nIElOVEMgKENQVSBEaWUpIGFuZCBpbnRyb2R1Y2lu
ZyBJTlRDX0lPKElPIERpZSkuDQpJIHVuZGVyc3RhbmQgdGhhdCBJTlRDMCBhbmQgSU5UQzEgYXJl
IHZlcnkgZGlmZmljdWx0IHRvIGludGVycHJldCBvciBkaXN0aW5ndWlzaCB0aGVpciBtZWFuaW5n
cy4NCg0KVGhhbmtzLUphbWluDQoNCj4gSWYgd2UgY2hvb3NlIHRvIHJlbmFtZSBJTlRDIHRvIElO
VEMwLCBJIHByZWZlciB0aGF0IHlvdSBzZW5kIHRoZSBzZXJpZXMgYmVsb3cNCj4gZmlyc3QuDQo+
IA0KPiANCj4gPiAgICAgaHcvaW50Yy9hc3BlZWQ6IFN1cHBvcnQgZGlmZmVyZW50IG1lbW9yeSBy
ZWdpb24gb3BzDQo+ID4gICAgIGh3L2ludGMvYXNwZWVkOiBJbnRyb2R1Y2UgYSBuZXcgYXNwZWVk
XzI3MDBfaW50YzBfb3BzIGZvciBJTlRDMA0KPiA+ICAgICBody9pbnRjL2FzcGVlZDogU3VwcG9y
dCBzZXR0aW5nIGRpZmZlcmVudCBtZW1vcnkgYW5kIHJlZ2lzdGVyIHNpemUNCj4gPiAgICAgaHcv
aW50Yy9hc3BlZWQ6IEludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb25zIGZvciBlbmFibGUgYW5kIHN0
YXR1cw0KPiByZWdpc3RlcnMNCj4gPiAgICAgaHcvaW50Yy9hc3BlZWQ6IEFkZCBJRCB0byB0cmFj
ZSBldmVudHMgZm9yIGJldHRlciBkZWJ1Z2dpbmcNCj4gPiAgICAgaHcvYXJtL2FzcGVlZDogUmVu
YW1lIElSUSB0YWJsZSBhbmQgbWFjaGluZSBuYW1lIGZvciBBU1QyNzAwIEEwDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBDLg0K

