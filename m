Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93968D65553
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 05:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGXDU-0003ut-0c; Thu, 28 Nov 2024 00:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tGXDR-0003uK-8G; Thu, 28 Nov 2024 00:37:25 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tGXDO-0005sM-PN; Thu, 28 Nov 2024 00:37:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZ0GT7rNxlkhCaK8zdY4YVgqB8QMWin7Jbe4/KuBJ8RhiMl2UKoRfYkzj55GqMjmrXyOsF5dDIxfJ9Wm91UaW2aF+g7fYOLeBpXGrVBqEEuibSEHYWEtL04eoPcJUVAIpYY/HGtTJIJeIND7od80XZTPnMQHgZmD7vrcTsd2rbLp1YVSJSKhYU5nUoUareKHf9tdGsTz1R63Ga1+AGIDbW8YHWIDb1MZLQjSD2hN7i1lw/MTIpFig3bYWRu4YfK++MlKfRFZL0xMEqNm+c23c0j+jmjpcvUqQo5WKAAQH4mMhjk3wuSqGxIzLssCTlh38s9HqaI30/fUgFf40zy5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO1WsNztkBR+vOToixGLH4gIcsJJiggI4pi6FRThcVI=;
 b=OBX36GRaxMgi72RgINiIngysTbH9nHFtPwHAqHgbC45TQCSdhkvZRVQ8VFxMKQAOSJKko22zH14jh4zGXck/msEwz0AExmkPfp3mC4aKVPizV3bH96aZga46zSm6FJulM7hGxldYQS/xLeaWdq0KD79l28wy78jay6ljiF02ZlyTFseTjpkggmcsX/q5R3gd5nKZLcvYe/pGBAxP8+FK3myyNWWgN9cZWXHCmDSX8gXS4nNwRsYBgP7fAkpwhBETeOAbNX4K5FItI7T3p7Gcr65+ERc0XRfMBjES72mNccJfEQ0Plo+wbM+uwNUauehahqWkCIfD128eSZsCj2b3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO1WsNztkBR+vOToixGLH4gIcsJJiggI4pi6FRThcVI=;
 b=VleA/zLgvo22Rp20Y+2gFIMKOp1ZtRO8lrwoy1RxrOhh6OYQLxkJlt5p1n5UEeZOtE6cKIugjnL3D5N0TnXm1uIzJL/DxPqxwVza9yREGaoe8tn8qRHjGdtEFv4SQR65vtgZNprVvdcLNOfFCthzHn0rvs9jqHs+J1VpDTyBfhuoVC3vB/mSkTGLzqTcgFEYU/CcGUsu7X1zYp9lR0KShVEiyn+MmsMGEvCCcwzLWhcmXhMxSXiRxQol8GF2btn4LjRiJ1YnNEK7CzuyscG3hgszrLlpVPukzeHvvZEJmf6WdIH0g7ZS8df8ivbfaQtajLMRcIlQYjYKRs1txMSXKw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6175.apcprd06.prod.outlook.com (2603:1096:400:35f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Thu, 28 Nov
 2024 05:37:08 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 05:37:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 0/3] Introduce a new Write Protected pin inverted
 property
Thread-Topic: [PATCH v3 0/3] Introduce a new Write Protected pin inverted
 property
Thread-Index: AQHbNnpmL6iUs5arJ0GWD6agaBg3qLLK9QAAgAAbo4CAATDKIA==
Date: Thu, 28 Nov 2024 05:37:08 +0000
Message-ID: <SI2PR06MB50412ED181B416D22DB210FDFC292@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <2e956389-289a-4806-8985-ab846d808736@kaod.org>
 <b520adf4-12f1-4261-a48f-bb74589bb31d@linaro.org>
In-Reply-To: <b520adf4-12f1-4261-a48f-bb74589bb31d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6175:EE_
x-ms-office365-filtering-correlation-id: 299e4e5e-508d-43c3-d6bf-08dd0f6eb302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dFVNS0JwYjVCbm1XRTdFVkdTOVlwOXJLL1JOOFRhNklVQlNuT0tJaDRjRUtF?=
 =?utf-8?B?MGQvUTFxUU4yMzkrUVV3NEVtRXoweFZHSGVTQlloSy9mWjVHRkpSeVp4cnkv?=
 =?utf-8?B?a2FwV1FsNmY3ZFpuWi8wZnFaT2VrbDJoT3lEeVhtcFdpTUV5b1dWbXdoOS9M?=
 =?utf-8?B?TmFicWZZdklnSUYwVVB1QmhKWGdiYzNwSnQyWjNiLytqamRkNHQ3Nm5HaXF5?=
 =?utf-8?B?aDVseHNtYTh1ZXcydGJoa0FCWVprc0NHRklyWjRTRWRFcW9kS09lUXNBZmJn?=
 =?utf-8?B?clYreGlaOHROeGxDdENJcVlWNlVpOGNPSm1YejJHVEQwZUdaRTh6S2ZCUHJC?=
 =?utf-8?B?aUd5OG9uQ2VXK0UzdUYzd3p5Z1lZK2VWMnpXWVFScU9ObGdJSEk2Q01BOTFt?=
 =?utf-8?B?M1ExZmt3dDZFYzZEOHVaQ0ZtcmZQYnNDdkVzNHVuK3dmQWptMWtKb1ZDL3ZK?=
 =?utf-8?B?S092NlYrb0Q1ME9iNWxGNTNMb2tua215VHhWSnIzdldFY0ZTTXBDOEtndWVO?=
 =?utf-8?B?UTJGTlYwcVJuczBxQWtDYmhLd3RVTGZYVkxXbExQZUNHL0RMdWxQdDR0Njg5?=
 =?utf-8?B?Y0dqOHZFRUR0S3VoMzNRcyt1TGJKYXozUkxMcHNna3YwNVBuaWtSSE5VVzgv?=
 =?utf-8?B?TWhOT1VPajJnYngyRjBsZzY3TTdDRWVmVi85R0JoZEpiRUorbC9Uc2NDOU92?=
 =?utf-8?B?TTNGNjV4RkRSYmtYYzVrakw2TUd0Sk5QTHdxSEVmeHFySDJKZ0plRFRsNmgy?=
 =?utf-8?B?SU1rRWZWaWE5NDhDbWN1Wk9kRE9QVWdnOFF6Qjh5TVpuVW5WZ2tUZUxVUDB6?=
 =?utf-8?B?ZjhyRlhyODhvLzBWb09BSC8yYzAwZ0ZlSWlBWnZ4SThRUE5zcEU4RjZzSkRt?=
 =?utf-8?B?Q2F2bTlyWHZvcjlWcy9mNUlGNlA3MUsxZlJIMnFLOVdCZFBXTHU4Ui9pODk1?=
 =?utf-8?B?NGxWUVRqYTE5ZnBKWnhOaC9XeENtRzl4b1UzQ091cHRDZHVabnlWZzhSTzNt?=
 =?utf-8?B?aXdZNU90Ykh3RVdhL041Rm4wSUpsUUxXUnlIRkg2T3pCL1JPV1VsZWVNRnpZ?=
 =?utf-8?B?OFhadldWT3VKNFIxbnlJVGRvWUx0NzMxTG9icW04VUNKSERrRFEyL1NZanJj?=
 =?utf-8?B?a2c2WlRhUUVFMThVNk02cEp0M3N4d0hiRkxqRm1LTSt3V2RoRnVRK3JLQ0d3?=
 =?utf-8?B?Vm1jSHJwN1B3YzBHT203KzUzY3ZlK1BRRHJrTDhRa1Z4N1BuVDl4eGFreGRO?=
 =?utf-8?B?aUR2SUxjejFvMkxWbk85eEVubCtKZ2ZiaHMrN05NMFNQV284am1nV08rZ2FP?=
 =?utf-8?B?OUZnZnhZM1pUdW56M3luZE9pUlZIc1RXcXo1RWpYRTZCTW9WRXpZdHdQb0Zu?=
 =?utf-8?B?TkVQRUo1b3VkTDhJekp5RldUUjR6clF1RjBra2ZGSGsybjdzT0oyR3piMlBF?=
 =?utf-8?B?RllBVVlXYkRGaGI2Ulp3bGoxV1hsODlWTnAvTkxKK0MzRlZQZWZhcnEyQmVR?=
 =?utf-8?B?UFhnUFpVanN4My9PNWNWNUdmSnJzN09PaUNucXY4SmluNVJOSGRZbGdFcTJB?=
 =?utf-8?B?SWMwY2w4VXZObmErTzRiT1FSRzVnNE9naFVmVkFEMzU5TElraEYydFpCSmhv?=
 =?utf-8?B?UDF6ekJ5Snlib05RZEUzcnlXWjl5YUpueGlkU2lNSzZ6SWxBK0l0ZWNlSU9Z?=
 =?utf-8?B?MWo3dmlrVG4raGJzOTYxdzNLMStWVW5uMEFrVmFSUCtrTEtqU0dqN2txbCt5?=
 =?utf-8?B?U3g3aTlIWld2L2x0VkFxenVOVE8wYlhiOWc3RHh6c1NKME9UeXl1bEhPSXdT?=
 =?utf-8?B?YWh5RzVjSGduVjRUeDRmc3g3T29uTWh5cE55b2JqempSc0NXNzhoTndSMmdv?=
 =?utf-8?B?akpDaURoRDJ1RG1URDQyQ1o4RXV4dDFUTnFJdkRobG1uWFVZeUJydmhoSCsv?=
 =?utf-8?Q?H4ljxjzTxZf3M72zInSv9LhkeOOFmZFl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1JOZXdyWGg2cDZRQm51TWIxWmJpOTBpVTJ1MHVnWVlQa1pHWkhJbnhPMW1q?=
 =?utf-8?B?ZW5FbURpeENEQVdFaDI1UEUwdy83WitxcUllMGtoUnJkOW9UaWNrKzgrb3Ft?=
 =?utf-8?B?N0dXZjA4MklJYnY1MFcvS1M5aFQxQWlBck9tL2NweGJodkl3anhUa1VKRmt4?=
 =?utf-8?B?QVFiQmdTQnRuYy9sV0dDWmN5Vjk0ZHc2MU5hT1BjTmFLdk5rNEFkd0ZDWUtk?=
 =?utf-8?B?N0RBdDR0SThpbjFBZWI1c3dVdDhYaHRDekpSVlNxZmJMYlBLUCtuZ05IYmp3?=
 =?utf-8?B?cStRZVZTQWl2NkpRNGQ3cENVRVpONEhPRW5aeDlYUzFKUlhIOGZwZG15eHlR?=
 =?utf-8?B?eFg3aWRYNDFKS0QxOVpzZHhyMmExYzE5dTU1R0RDdkZtTXpDWWRuTEo0Mi9J?=
 =?utf-8?B?UWhWOWY4dXVGK3lFZmM3WW5vWXBzY2JaMDBkYzhFRVF5V09yaXFTTWRGbnBN?=
 =?utf-8?B?MzFRMmd6S1JkNStMWnlVczltMENyZEpIOE42U0VMK01WYUx0eTFjZWlUUmNv?=
 =?utf-8?B?aTMyYU1yTmFpS3VRUVBqbFkwTDN0c09DRCsxWTV1WDF0SFZ6RzN1NktvYkN0?=
 =?utf-8?B?SnczcnZjbWVsWlU4bVQ0WE9YMHlJem9YN1hVakdGakhKTFhIKzc0Y2pXbS9K?=
 =?utf-8?B?OVQwTUZzYmhobmpCODlyZlhHS2JzTDhYSlExcmtaV1poQjJ0T3J4d3Y4d2di?=
 =?utf-8?B?RE5JL1B4WmpidVJRRE1jdHNTa3pFUWJSbngrUnQ5MVNvT2dIZ2hoL1oveW1h?=
 =?utf-8?B?SVFINDdqOWNqWnE4Y3hQeGRxTkFnU3FlbDBXSUVQamJYR1dhQy9TbWtTRDJU?=
 =?utf-8?B?SGt4a2I0UEZiSDVTL1hESVg2QmdOOSt4VVkxcUZKMTBrZHRVSXVwWkZvMC9k?=
 =?utf-8?B?TWUwRzY3TDg1blVTd3diQVoza3JFYm4xWWVoaWlWTHhlbld4TFZmdHM5ZE4w?=
 =?utf-8?B?Z3FCYUFjTk1MeEh6azE4VWN6eGhYdDBNVStGR1BnRXEzUXczbFpPeE1xNWtL?=
 =?utf-8?B?Z3FYOEZIRWJuK2RjcUU3c3hsRWcrUlVqS09mcDc0N2J4VENaZXFtcmlNUmZz?=
 =?utf-8?B?ZGI1RnFKS1R5NDZzQzdQSWN6TVNOWWc4S2FmRnhtYnJYQ0xlMnJ6NUMzM3ZR?=
 =?utf-8?B?WGFIeFRBRDl2QjRlUDF5UWdwbncvdkxlelJaZnBsMXZVNWZTTVoyYVVTYnN4?=
 =?utf-8?B?a1FrUll0Q0V0ZmVINVUvbUxSWm9wdG41RzE0RXNwaGcrSGFBYUdHc3M3NXFW?=
 =?utf-8?B?ZlZQdlpENWVnTW1VZFdhb09JbG1yb0JYVTZBbTljQ0laTDdKOGlhOEs2NEZ4?=
 =?utf-8?B?VWtPY25oajVqcVFxNkE3VTE4OTRGS2NTU2lscXBVNjIyV1U5SzhXbmpiakVB?=
 =?utf-8?B?TUc2VERWMFRGWkc0aVJSS3JFZFp1bEd6czUvN0NyY0xXdURmcEp4ejF6MUVZ?=
 =?utf-8?B?WUFTYWNnQmEyWkdFQ1RRb3BtWkRHZjZmb1htRkJsaHBLTUY1RjhIZHE3cHlS?=
 =?utf-8?B?RUYwcVNMdFhRSmtTMDdvR3RHOC9vNDh1aEdOcnlwbVNzZHJLT29oTTg3UkdO?=
 =?utf-8?B?U05id2tuQWVSM00xdWpEdllqc2t4WTRQZ1ZvMWlSSW00NnRhYjF3aVpkdWlC?=
 =?utf-8?B?c2xpenJrOFdtV3hpUm5QS0VMYVRQTXJqZGZSQWx1S1M5TlpUL2FicHdOOVE4?=
 =?utf-8?B?M28xdWhBeStjbVFPZEw4OGovQ2JHUnhITWh6QjJ1aTM3dnUvdFhmbERJM3di?=
 =?utf-8?B?aE9EQXU1RlJudWVWZzhTeTZiNEpzNnJWWVVNN3RPbGUxVVdqcEIvb0lkbklM?=
 =?utf-8?B?SFUwcDc2VFFWcHJNRUxOZTF2ejJtakZ5ZXZ6bUIxd2syOGtNN2RrNTBsekxM?=
 =?utf-8?B?ODJZcUx5bi9tTUJVV05UdEF0UWExSENDczNaV3gvcnI0b3ppVzFsQzhuQjNC?=
 =?utf-8?B?VGRYQis2NFQvQ1d0THA3SVVSSThPODl0TWpqVkRJV1dlZXBQME9NWCtLZ0hn?=
 =?utf-8?B?WmQ4bXRHVWg4NzRFRFhmMTZESTg0eXRVajZvSmtld2ljTE8xVS9zR0I5TGRV?=
 =?utf-8?B?L0V3OXB3U3dheHB6L1J5UTQreFVRWnE0ckJFamJLM0Fad09kbWJQNUZsd2dz?=
 =?utf-8?Q?smHzeu6fP7fQ9TzG8uV/rAyCa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299e4e5e-508d-43c3-d6bf-08dd0f6eb302
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 05:37:08.0477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgP7vyO3fMTS/fr8qyfiFOSFYPp71IQwjbrX0AwslgM6uc3hf/rWG/DL98Ppytm0KXK9ewjX0Jjr8OKjvse9/CF95nbD4XlYuOAoxcLUw/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6175
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzNdIEludHJvZHVjZSBh
IG5ldyBXcml0ZSBQcm90ZWN0ZWQgcGluIGludmVydGVkDQo+IHByb3BlcnR5DQo+IA0KPiBPbiAy
Ny8xMS8yNCAxMDo0NCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4gT24gMTEvMTQvMjQg
MTA6NDgsIEphbWluIExpbiB3cm90ZToNCj4gPj4gY2hhbmdlIGZyb20gdjE6DQo+ID4+IDEuIFN1
cHBvcnQgUlRDIGZvciBBU1QyNzAwLg0KPiA+PiAyLiBTdXBwb3J0IFNESENJIHdyaXRlIHByb3Rl
Y3RlZCBwaW4gaW52ZXJ0ZWQgZm9yIEFTVDI1MDAgYW5kIEFTVDI2MDAuDQo+ID4+IDMuIEludHJv
ZHVjZSBDYXBhYmlsaXRpZXMgUmVnaXN0ZXIgMiBmb3IgU0Qgc2xvdCAwIGFuZCAxLg0KPiA+PiA0
LiBTdXBwb3J0IGNyZWF0ZSBmbGFzaCBkZXZpY2VzIHZpYSBjb21tYW5kIGxpbmUgZm9yIEFTVDEw
MzAuDQo+ID4+DQo+ID4+IGNoYW5nZSBmcm9tIHYyOg0KPiA+PiByZXBsYWNlIHdwLWludmVydCB3
aXRoIHdwLWludmVydGVkIGFuZCBmaXggcmV2aWV3IGlzc3Vlcy4NCj4gPj4NCj4gPj4gY2hhbmdl
IGZyb20gdjM6DQo+ID4+IDEuIGFkZCByZXZpZXdlciBzdWdnZXN0aW9uIGFib3V0IHdwX2ludmVy
dGVkIGNvbW1lbnQgMi4gQVNUMjUwMCBFVkINCj4gPj4gZG9lcyBub3QgbmVlZCB0byBzZXQgd3At
aW52ZXJ0ZWQgcHJvcGVydHkgb2Ygc2RoY2kgbW9kZWwNCj4gPj4NCj4gPj4gaHR0cHM6Ly9naXRo
dWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12Ni42L2FyY2gv
DQo+ID4+IGFybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWFzdDI1MDAtZXZiLmR0cyNMMTEwDQo+
ID4+DQo+ID4+IEphbWluIExpbiAoMyk6DQo+ID4+IMKgwqAgaHcvc2Qvc2RoY2k6IEZpeCBjb2Rp
bmcgc3R5bGUNCj4gPj4gwqDCoCBody9zZC9zZGhjaTogSW50cm9kdWNlIGEgbmV3IFdyaXRlIFBy
b3RlY3RlZCBwaW4gaW52ZXJ0ZWQgcHJvcGVydHkNCj4gPj4gwqDCoCBody9hcm0vYXNwZWVkOiBJ
bnZlcnQgc2RoY2kgd3JpdGUgcHJvdGVjdGVkIHBpbiBmb3IgQVNUMjYwMCBFVkINCj4gPj4NCj4g
Pj4gwqAgaHcvYXJtL2FzcGVlZC5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrKw0KPiA+PiDC
oCBody9zZC9zZGhjaS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA3MA0KPiA+PiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+PiDCoCBpbmNsdWRlL2h3L2FybS9h
c3BlZWQuaCB8wqAgMSArDQo+ID4+IMKgIGluY2x1ZGUvaHcvc2Qvc2RoY2kuaMKgwqAgfMKgIDUg
KysrDQo+ID4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRp
b25zKC0pDQo+ID4+DQo+ID4NCj4gPiBQaGlsaXBwZSwNCj4gPg0KPiA+IEkgcGxhbiB0byBxdWV1
ZSBwYXRjaCAyLTMgZm9yIFFFTVUgMTAuMC4gSXMgdGhhdCBvayBmb3IgeW91ID8NCj4gDQo+IEhh
dmluZyB0byBtb2RpZnkgc2RoY2kuYyBpbnRlcm5hbHMgaXMgZHViaW91cywgc2luY2UgaW52ZXJz
aW9uIG9jY3VycyBvdXQgb2YgdGhpcw0KPiBibG9jay4gSWYgdGhpcyBpcyB0aGUgc29jL2JvYXJk
IGxheWVyLCBpc24ndCBiZXR0ZXIgdG8gbW9kZWwgYXQgdGhpcyBsZXZlbD8gU210aA0KPiBsaWtl
Og0KPiANCj4gLS0gPjggLS0NCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MjYwMC5j
IGIvaHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMgaW5kZXgNCj4gYmUzZWI3MGNkZDcuLmFhZDliZTY2
Yjc1IDEwMDY0NA0KPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI2MDAuYw0KPiArKysgYi9ody9h
cm0vYXNwZWVkX2FzdDI2MDAuYw0KPiBAQCAtNTU5LDggKzU1OSw5IEBAIHN0YXRpYyB2b2lkIGFz
cGVlZF9zb2NfYXN0MjYwMF9yZWFsaXplKERldmljZVN0YXRlDQo+ICpkZXYsIEVycm9yICoqZXJy
cCkNCj4gICAgICAgfQ0KPiAgICAgICBhc3BlZWRfbW1pb19tYXAocywgU1lTX0JVU19ERVZJQ0Uo
JnMtPnNkaGNpKSwgMCwNCj4gICAgICAgICAgICAgICAgICAgICAgIHNjLT5tZW1tYXBbQVNQRUVE
X0RFVl9TREhDSV0pOw0KPiArICAgIGlycSA9IGFzcGVlZF9zb2NfZ2V0X2lycShzLCBBU1BFRURf
REVWX1NESENJKTsNCj4gICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVWSUNFKCZz
LT5zZGhjaSksIDAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGFzcGVlZF9zb2NfZ2V0X2ly
cShzLCBBU1BFRURfREVWX1NESENJKSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNjLT5z
ZGhjaV93cF9pbnZlcnRlZCA/IHFlbXVfaXJxX2ludmVydChpcnEpIDoNCj4gKyBpcnEpOw0KPiAN
Cg0KVGhhbmtzIGZvciBzdWdnZXN0aW9uLg0KDQpVbmZvcnR1bmF0ZWx5LCBJIHN0aWxsIGdvdCB0
aGUgIldyaXRlLVByb3RlY3RlZCIgc3RhdHVzIGFmdGVyIEkgdXNlZCAicWVtdV9pcnFfaW52ZXJ0
KGlycSkiLg0KDQpyb290QGFzdDI2MDAtZGVmYXVsdCMgZG1lc2cgfCBncmVwICJtbWMiDQpbICAg
MTMuODg5NzY0XSBtbWMyOiBTREhDSSBjb250cm9sbGVyIG9uIDFlNzQwMjAwLnNkaGNpIFsxZTc0
MDIwMC5zZGhjaV0gdXNpbmcgQURNQQ0KWyAgIDEzLjg4OTg0OF0gbW1jMTogU0RIQ0kgY29udHJv
bGxlciBvbiAxZTc0MDEwMC5zZGhjaSBbMWU3NDAxMDAuc2RoY2ldIHVzaW5nIEFETUENClsgICAx
Ni43Mzk5MDFdIG1tYzE6IG5ldyBoaWdoIHNwZWVkIFNEIGNhcmQgYXQgYWRkcmVzcyA0ZGQ3DQpb
ICAgMTYuNzQwMzMwXSBtbWMyOiBuZXcgaGlnaCBzcGVlZCBTRCBjYXJkIGF0IGFkZHJlc3MgZTUw
Mg0KWyAgIDE2Ljc0NTIzMl0gbW1jYmxrMjogbW1jMjplNTAyIFFFTVUhIDEyOCBNaUIgKHJvKQ0K
WyAgIDE2Ljc0ODc2NV0gbW1jYmxrMTogbW1jMTo0ZGQ3IFFFTVUhIDEyOCBNaUIgKHJvKQ0KDQpJ
IGR1bXAgUk8gc3RhdHVzIG9mIFNESENJIGRyaXZlciBhbmQgSSBzdGlsbCBnb3QgdGhlIFJFQURP
TkxZIHN0YXR1cy4NCnJvb3RAYXN0MjYwMC1kZWZhdWx0Oi8jIGNhdCAvc3lzL2J1cy9tbWMvZGV2
aWNlcy9tbWMxXDo0ZGQ3L2Jsb2NrL21tY2JsazEvcm8NCjENCg0KT3VyIEZXIGFkZGVkIOKAnHNk
aGNpLHdwLWludmVydGVk4oCdIGluIFNESENJIGJ1cyBkcml2ZXIuDQpodHRwczovL2dpdGh1Yi5j
b20vQXNwZWVkVGVjaC1CTUMvbGludXgvYmxvYi9hc3BlZWQtbWFzdGVyLXY2LjYvYXJjaC9hcm0v
Ym9vdC9kdHMvYXNwZWVkL2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMjTDc1Nw0KVGhpcyBwcm9wZXJ0
eSB3YXMgZGVmaW5lZCBoZXJlLCBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxv
Yi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMtY29udHJv
bGxlci55YW1sI0w3MQ0KDQpBY2NvcmRpbmcgdG8gdGhlIGRlc2lnbiBvZiBTREhDSSBkcml2ZXJz
LCBpdCByZWFkIHRoZSBQUkVTRU5UIFNUQVRFIFJFR0lTVEVSIGF0IFNESENJX1dSSVRFX1BST1RF
Q1QgYml0Lg0KSWYgdGhlIHZhbHVlIG9mIHRoaXMgYml0IGlzIDAsIHRoZSBzdGF0dXMgaXMgcmVh
ZG9ubHkuDQpIb3dldmVyLCBvdXIgRlcgYWRkZWQg4oCcd3AtaW52ZXJ0ZWTigJ0gcHJvcGVydHks
IHNvIGl0IGludmVydGVkIHRoZSByZWFkb25seSBzdGF0dXMgaW4gbGluZSAyNTgyLg0KVXNpbmcg
cWVtdV9pcnFfaW52ZXJ0KGlycSkgZGlkIG5vdCBjaGFuZ2UgdGhlIFBSRVNFTlQgU1RBVEUgUkVH
SVNURVIgdmFsdWUgYW5kIA0KdGhhdCB3YXMgd2h5IEkgYWRkZWQgYSBuZXcgcHJvcGVydHkgaW4g
U0QgY29tbW9uIG1vZGVsKHNkaGNpLmMpIHRvIG1ha2UgdXNlcnMgdG8gY2hhbmdlIHRoaXMgYml0
IHZhbHVlLg0KDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wbHRmbS5jI0w0Mg0KaHR0cHM6Ly9naXRodWIuY29tL3Rv
cnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGx0Zm0uYyNM
ODcNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLmMjTDI1NzQNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51
eC9ibG9iL21hc3Rlci9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMjTDI1ODENCg0KVGhhbmtzLUph
bWluDQoNCj4gICAgICAgLyogZU1NQyAqLw0KPiAgICAgICBpZiAoIXN5c2J1c19yZWFsaXplKFNZ
U19CVVNfREVWSUNFKCZzLT5lbW1jKSwgZXJycCkpIHsNCj4gLS0tDQo=

