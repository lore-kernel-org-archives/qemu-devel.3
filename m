Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB6EEDF021
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 02:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqMs5-0000GS-N2; Wed, 11 Feb 2026 21:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vqMs4-0000GG-7P; Wed, 11 Feb 2026 21:56:00 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vqMs1-000833-4g; Wed, 11 Feb 2026 21:55:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4jgiRqhUmWTfdJe03LVUEZPApHlw34Sh7tBFtT5Zh9rh8J6OxGoWuJTxW4aAC4cVvk3/friLjinZy+gglJgd7iCMlkT+dm09J/5FSvc05QgOcB+rnSh4NlmSvAGxpS7NcDdCX29P2oDYuQwzDdLSXuwAt+O1GreSKnIqXcS7XzFeqvO6dIOIrTzn30R5pIVSDo5LawCHsP1F83rhIKBjSeQjluYBDKkUiyf4QdGjxps44oITPBE1MBAdZ2uiaw95ksJtu2gWcifedY3NKld1ZHMYwAUmKjC1OoJZAL7iLwixB7qeeS+8/lp/3OlWVUV43S8QrLlwA5H4PF+0p6t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV7JfeQKABRq53sUAwLM0DWP2Qo9fNBWJbXrtdoNeLA=;
 b=zGsH4OUFVOnoqDQcfoJbC51t8ZzJ8QhXz/kjshGLhldOcB8K+Cf2iRbHKz+h9yr4j607W8e4FUsu4rVKFo0LTkZed7ikU8Ia/7sJigQZAkK4rgJ3kwpM+AsRIQvM2ZireEUYVvjPrMCHchD2BDG2MeR4dR9AP6YZa9IX/G/+n3+W1n+Nw76R5RHzQ4ZRsX3jg4x5/jHnnV5QqITVCxaCvYWKt8DaeXc4x+FwoUKkS2WKAVyDMEICsLJGbChKe5otKiISIEnRafdHNxG0sYklYdSOxM2tzw+wXRVNoBxeXx3ThzZ3BGOuejqHtLV2xUW5mE3jdbN5zQ8AXKDWjp6uCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV7JfeQKABRq53sUAwLM0DWP2Qo9fNBWJbXrtdoNeLA=;
 b=C+CTC0DgyQgYj31mERigkJyhvK9vj4/wYAs4BPHPeMTQElVuyPU+HStdQrxK2aUThPCtD2PzgWGg28qpwfdot1Hxft4hlyjw3RN0u/xo52FjVlzjAKzgefWlIAm3jVJjvhThJ2u6soWzo5x1V1075A9UazX5t8sUX4e+oWnDEFur5EJJJJibEd46mrNIKz6vJ+tsKybETOw+PPWEby5jTMoDekjxKcsUuOFKgnshMySTzf2qJMeS2QamfqftP+hIUsDZcGfGbyakfcailbqKrR08/ASohZR94ZVGyXLoHXFTvY9VRQeIBbFMbELMbDK33xN9yZDO28U/j5LU/aeLig==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6545.apcprd06.prod.outlook.com (2603:1096:400:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 02:55:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 02:55:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v5 21/21] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Topic: [PATCH v5 21/21] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Index: AQHcmm0mCt+TkxdwhUqGE8n0PP8BF7V9gwaAgADZGBA=
Date: Thu, 12 Feb 2026 02:55:46 +0000
Message-ID: <TYPPR06MB82066FF60DB23E0D983221C8FC60A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <20260210091018.1553489-22-jamin_lin@aspeedtech.com>
 <93629d7d-8e27-4121-a9ba-cc6361020830@kaod.org>
In-Reply-To: <93629d7d-8e27-4121-a9ba-cc6361020830@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6545:EE_
x-ms-office365-filtering-correlation-id: 63586dc6-911a-47aa-b395-08de69e238a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?WEZ3Y2U1UmJLSUNYU3lyQWE1Z00wR21CWFF1d3ptQUVleUlBNVgvV3pMUU1p?=
 =?utf-8?B?WU52UWxmMUdxMXJpbmFCVFVJYkV5LzRCdmgzSDRkS0Z1a3FNQ25KNDhFRUV5?=
 =?utf-8?B?RTllSmxXSWI0SEsrSkY5Sy9SbXZNZDJ1cDBSQUxFVGNNd0RONGVzSG9PUm5F?=
 =?utf-8?B?Y3hvOHZ5QjRWTkgzYk5LY2Q3KzV2OWs2cURMbDcrYzFxSlZIamRjYUNTOVp6?=
 =?utf-8?B?MU5RdmJOeFFsdjJzRWRlZktnd3hOK3pPRGhQN3A2akNjOXo3Q01xSXgwendp?=
 =?utf-8?B?enBHaWx2TWIrY2lGOVZlMjV2K09lWHRoelBPU1IrSjM3WnoxNXdVOXM1TUR4?=
 =?utf-8?B?NEdhQkx1KzBLaXljTUh6c0RMTTJjSkNNMG9ZY2dTVlV4MVJibXc4UXBHMVZZ?=
 =?utf-8?B?Y0NJZEdIRFF4SkhvSzZIV2VqVzdGc1UxWHVnZ2sydXQ0M09lU3F5SnpEalhv?=
 =?utf-8?B?UWhvb1NSdzZrMHVhUE0rd1ZPdXlBWXBoYUlTWnRrdmc2UHdydWFaVkF0eWp5?=
 =?utf-8?B?Zjh2RC9pOFFHbGlBMUkxdjg0aCtvU2IvYWFkbXdsdTdFVjNBblZmVWMwTHVL?=
 =?utf-8?B?VHl1MStNQ2tOeUNqYlIvdUp4RllrVUNGTXAxNjJ4aWN0M21WMENSTktSaDlM?=
 =?utf-8?B?enZRbUYvNlBnRG9pRjU1YUlvdExMeVN3RUozZ0R1WEtxMXJnNW1wTjh1ZXBF?=
 =?utf-8?B?YWRjeFBBUUYvSUpyZE50TVpjTWFQbU9mcnVSRHFzUFpxSnNYMW1MemVrcDNT?=
 =?utf-8?B?NnUvUjlmdVdVVWM4MVhaeVZlMWN5Y1ltaGd3ZERDZTNNTGUzU0VwZ1U0Q1c2?=
 =?utf-8?B?eUY5RFdxRFdFZ3BqRVA0c3d4M3NQUjNnNkpMOWVtMGJOOGd6OS9Jb1Z6bTE4?=
 =?utf-8?B?MjJJMkloSHdjWWNLYkZjRm45UzZaS0QzQk5DQVJSWExMdlJ0ZUFtVGp0dTh5?=
 =?utf-8?B?TkQrSWpLV3RCR2pOdnJBL3ZyNEZ1bEJubDhrN1RUU0dXdEMxZ2VMaStCWVVy?=
 =?utf-8?B?RUFObEVVNjBzTXlIUWdScWdXNTF3QTF0ME9zTVZySUQrc2VNbTA4VlFxdi8x?=
 =?utf-8?B?Vks0dUVkRzhHWkdOR0dtUnM0VnA0eW8vNG9DRHRwZ1lZeUZEYjBhYXg3ZGR6?=
 =?utf-8?B?Y2ZJUHVzV0g3Tkd3NzBFUkxBVmdLU2N6SkxHaHV5YXlweFZVRGhMUm1zS1ZT?=
 =?utf-8?B?aXUyejdSZkRFMWYvUjkzNG1JWFVBdnJTdStoSVBqWm1UdGhaMVlHUWJnZ2d2?=
 =?utf-8?B?VGw0M2dGQVRCTGVxYUw4RUtZQUMycUE2SVoxeC9PVm8zQTV2WUp2eE9Sdm1p?=
 =?utf-8?B?aHgrTk5zMXA1SVdRRk9uSE5CMHpaVFdsRCs1bS9hL1FGUVdoQTNrb0c1SU10?=
 =?utf-8?B?cjlTeGpwbDRabCtiK1BuNFhCaUplQVFRY0NRampEWWovTm9rMDZnNVhSL0Ri?=
 =?utf-8?B?dlFLeDlnUHhEeCt6anhER0JKcXVjVk9sK2xHSVNQRG1JZXI2TXkvVk9udnJ2?=
 =?utf-8?B?cDlZVDVMSG9BWnBPV1E4aWVMaEl6SXBnbjVJZHBSREo1ams2NHp3YmFqaXcr?=
 =?utf-8?B?dEl4N3N6Z3hkRXJ5ZXlJVVIyR1d2YVlOV0k1Y1EwTk16TmkrZTcrVnVXUDQx?=
 =?utf-8?B?MEpGV0pRVWM3Mnk2V0FYV1R5YVQzdXlKTHZoQWp3WEVVS1VtNlcwOVQyQWpj?=
 =?utf-8?B?dFpUUGd2c2dWWUNqQWtEMGo4SlEwOFlxUDNRb0s2U0pXSFRYbk5qbEVNcjVE?=
 =?utf-8?B?Z1FtL0xMRkVPdElEUExmN2pXZEFZNDBEb2Zma2RLaW5NZldSNUViL2RrSFgy?=
 =?utf-8?B?NWVUUnAvei9HK28wY3ZkWlFKbHR0TmxhNXFwNXBPQ2x6V0VZL2FRUk1aTHJh?=
 =?utf-8?B?QVZyQnFjWU1NTXBiQWZmK1JEV25GMkh5ejBqdVhvWm1TSmthZ1JibHlCLzZZ?=
 =?utf-8?B?MzFORmJDOGk1K21GMXhMS2M4dnN2alBHRHh4V3ZBdzFhSzgyNEJhd2dJMUJs?=
 =?utf-8?B?REliMmp2eDJkNE1wdkZhV053QmloYmp6bmdEMjJBRGVPbVFiS2grVXA3Q2NL?=
 =?utf-8?B?ZlZCbUxVOTYwSE9TeFJvb0pnNkpYTmZCL0EyVm9TeDZmdkR6clZUL254MDlM?=
 =?utf-8?Q?IShVo76eo4cxJ1WMSYCFm65qt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2pzK2ZuUitjUG9pcmU2ZHVmOWpHUG9rQUZFMUlLT1BQS0NTUFArd2pSL0d4?=
 =?utf-8?B?KzhTNCtxWE1YVGFKUVpicExlTVJsZHoyY0ltZmJSOTNJZWVaMlZwSEpRb0F5?=
 =?utf-8?B?Rm5nNWg2VEl3Q1g3aElGZkEycXQ5QzRUVEFZVGNaWVVlWWxvdURHQ2ErTzBE?=
 =?utf-8?B?b2owKzhJREYrZEZxeGFqOEh2VUxLZ3R1Vmt0a3ZaTHJ2dWpTOWUyMHRjVWZl?=
 =?utf-8?B?dHlENGdONFBNbkRvT0hQeVJKVCtzRDJVSWhlWDdMSktqbFZ2LzlwOWR2N0Vp?=
 =?utf-8?B?L1VhZGI5b3c2Sjh6aFhtdlFqTU9rUThVdEVRdjJCaWpUTkNrTVc0cElXSVlC?=
 =?utf-8?B?RUlXSCtoYnRndVZQR0RYVFhhUDFSWVhuWGkvdlNXWDFEY1RaTzVlMENRYW8v?=
 =?utf-8?B?SzlOb2tzL0hjWFBnUTBpWXkwWlZ4ZlNmelNQanhqenRXcnYyNVZJVGptSXhi?=
 =?utf-8?B?RVVSQWJIc0R6Ujdrb09adDlNaGluWUJHeHU5blFPSGhibUtDNkxpdWFuYkZH?=
 =?utf-8?B?cHZ4amNZM0toZzJVSWNNdmR3UXRPNFBKRlZva1h5Q3lnZ1d1amMrcDJvV3pu?=
 =?utf-8?B?RWdST2VQbCtvNklzVGdZQ3QyS0tDK0NOTDFxUDZ3b0pLRG5Jbm90dGpib2c0?=
 =?utf-8?B?ZllNQllsSmw3emhQLzM3azU1UnFMQlNOUzhRYnZWUWtCUDJrNEMrVXh1SW9G?=
 =?utf-8?B?VENiMVF0dlE2OGt6QWZqZTlWcWVGVU51dHNIZW03WG1LWUpvYjVBVzdLcnYw?=
 =?utf-8?B?dCtxQzhDVjVJQkZueTJhamhzTnI2R1BBRXJ6NE9mN2xoK0UrM05UVk55ZTFv?=
 =?utf-8?B?YlRtVDhNR3NMMnBHeThZT2k4R3AwQlFrNDQ0cjZhVVFyNTRMS2lQbFNTZVM2?=
 =?utf-8?B?QXdnNFR6ZnRNMVhTemhZSUsvNGJVR1ZlV3lNZGJVWTFjMzRTNnk3SDRoUHoy?=
 =?utf-8?B?SGprVkJZLzlFOFdiYVo0aGF1ZzhPcnhZaldFbjV6b1NEWFhFM1IxcTdHSldp?=
 =?utf-8?B?STRGdVdZSHp0cmY2SjJTYjJXWXhMMWF3eUc3VmxLdTh0eWUwUlZmUWZtcnpN?=
 =?utf-8?B?RHAreDM4a2I1cWJYN2p3TCtkY0I3Qk9tWm5WTWk1dmQxVXl5UytPN0ZGaEgr?=
 =?utf-8?B?Z05rM0xnR2xkRCtSbzFMcS9qRUFLbG90U2wwVE1jNkoxWmI4aTNQVkZ4Qzk0?=
 =?utf-8?B?cFZnSFN0Y0c1c2VzM1Q0RzVHNTJSd0Z2UGEyUnNQVzU0a2RJUXRieUlKcGpM?=
 =?utf-8?B?blRUdGdGVm5BQTVQcmFGSHROUXNOdW1KZEptV3FJak1LN0xGbHc2aHBOWkxW?=
 =?utf-8?B?aU10U1JkNnBiUnNMZ09BdDVFQnJpM3Nkc2oxR01GSTE4V25hb3BjSlN0UUZo?=
 =?utf-8?B?N1ZsNWhMbG1BZEQyMHg1U1RqRUppZmVlK0RSNHVqeGhvejZxb1NlY04xM0xT?=
 =?utf-8?B?bXloRVZsTmxFY0pMWm4vKzd2Tnc1bzRpaWhhSmtDbVVRQ3VnZ2JVVXdaOHN1?=
 =?utf-8?B?UytjMmdqZEt6dDNZWnhuSzNWbHB3eDlHQVlmRVZ6aHIxenFtVmxkc1VEYzhQ?=
 =?utf-8?B?WWZMTGRGUjZvRnM0WU5SSzVBRkNWVWpBUmpMczZLM0l5RUdVNytndUZkYWlo?=
 =?utf-8?B?L3BvMGI3MXFNWnNwUVVBTHNZa2xibnFJczVJa2Urd3U5cWRRVE5ydWl2WHVh?=
 =?utf-8?B?cnBEallDd3pMV2tCbG9qQzB6WW5YZmRtZkVGV0J1NVROOEMxRzhxUVVuVGhr?=
 =?utf-8?B?YVZaSG5TQk5TNUlEbzhwTzZjWGRjam91dkMrNDk4TmNYUWdXTHFpcDRFRVBn?=
 =?utf-8?B?L3R0clFJU3NWeVZVdmdMRGhhNWdMVUttYVA4OWNRQ0lHeVVIeVNuT3JmWHJL?=
 =?utf-8?B?UkNyN2FSZFgwUlhPNGEvVXZiWEU4RmthTm1ScytTTUFUQVROdGR1OEd0ZjRy?=
 =?utf-8?B?ZDRhTHpGWGZNYjI5dGY4WUYzVlVaTlBpTlBPaUZDS0w2VzlaSHJzbklDNzA3?=
 =?utf-8?B?d1RRNVd4RGtUMzNiS3U4NkNRRmdTcHdFRUJZQ1RtUHI4WGVWT2dOZkYrVVZH?=
 =?utf-8?B?VEhITkptNTF3ZHl1WmVJWnY5R1RJaGdGYU9xekVZRnpRbnVMd2VmQkw4YmZ2?=
 =?utf-8?B?djBRZUk1WCtDSCt6TUVEZEdaVlREZVptejhNczliMS84Rm95ejJHMy9LWnhD?=
 =?utf-8?B?d3phYWJkZER1TElUT1VOOVUyQ3FDa1llNWhoWlY4NXFVNDBXVGQzUytoU2t6?=
 =?utf-8?B?MlFPUkJyaTczRXlkRXE0aWtiZ2t3TnFFc0hZR1k4SWE0clI5K1BwK3AyWFFh?=
 =?utf-8?B?eW1aQ3FEb0FHclhOMnY5Z1BjMXB5WnBibTcvMzlxcERsTzA2UTFvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63586dc6-911a-47aa-b395-08de69e238a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 02:55:46.6008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6XHlqe60mOY9oJpZ72PeecVttaTmKHGpLwpqYvT3+BZaQxVu1XuCUnduncc3Nz8E18qTzctkQAG9+7sDxx2LFeAxQ7fI/w+W1rmuyuzO2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6545
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIxLzIxXSB0ZXN0cy9mdW5j
dGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3NkazoNCj4gQWRkIGkzYyBmdW5jdGlvbmFs
IHRlc3QNCj4gDQo+IE9uIDIvMTAvMjYgMTA6MTAsIEphbWluIExpbiB3cm90ZToNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrLnB5IHwg
MTIgKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2Fz
dDI2MDBfc2RrLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYw
MF9zZGsucHkNCj4gPiBpbmRleCA2MjM2YWViMTFjLi4zNDg1ZmVhZjJjIDEwMDc1NQ0KPiA+IC0t
LSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrLnB5DQo+ID4g
KysrIGIvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGsucHkNCj4g
PiBAQCAtMzEsNiArMzEsMTUgQEAgZGVmIGRvX2FzdDI2MDBfcGNpZV90ZXN0KHNlbGYpOg0KPiA+
ICAgICAgICAgICAgICAgJ2lwIGFkZHIgc2hvdyBkZXYgZXRoNCcsDQo+ID4gICAgICAgICAgICAg
ICAnaW5ldCAxMC4wLjIuMTUvMjQnKQ0KPiA+DQo+ID4gKyAgICBkZWYgZG9fYXN0MjYwMF9pM2Nf
dGVzdChzZWxmKToNCj4gPiArICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRfZm9yX3BhdHRl
cm4oc2VsZiwNCj4gPiArICAgICAgICAgICAgJ2kzY3RyYW5zZmVyIC1kIC9kZXYvYnVzL2kzYy81
LTEyMzQ1Njc4OTBhYicNCj4gPiArICAgICAgICAgICAgJyAtdyAweDEyLDB4MzQsMHg1NiwweDc4
LDB4OTAsMHhhYiwweGNkLDB4ZWYnLA0KPiA+ICsgICAgICAgICAgICAnU3VjY2VzcyBvbiBtZXNz
YWdlIDAnKQ0KPiA+ICsgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihz
ZWxmLA0KPiA+ICsgICAgICAgICAgICAnaTNjdHJhbnNmZXIgLWQgL2Rldi9idXMvaTNjLzUtMTIz
NDU2Nzg5MGFiIC1yIDggfCBncmVwIDB4IHwNCj4geGFyZ3MnLA0KPiA+ICsgICAgICAgICAgICAn
MHgxMiAweDM0IDB4NTYgMHg3OCAweDkwIDB4YWIgMHhjZCAweGVmJykNCj4gPiArDQo+ID4gICAg
ICAgZGVmIHRlc3RfYXJtX2FzdDI2MDBfZXZiX3NkayhzZWxmKToNCj4gPiAgICAgICAgICAgc2Vs
Zi5zZXRfbWFjaGluZSgnYXN0MjYwMC1ldmInKQ0KPiA+ICAgICAgICAgICBzZWxmLnJlcXVpcmVf
bmV0ZGV2KCd1c2VyJykNCj4gPiBAQCAtNDMsNiArNTIsOCBAQCBkZWYgdGVzdF9hcm1fYXN0MjYw
MF9ldmJfc2RrKHNlbGYpOg0KPiA+ICAgICAgICAgICAgICAgJ2RzMTMzOCxidXM9YXNwZWVkLmky
Yy5idXMuNSxhZGRyZXNzPTB4MzInKQ0KPiA+ICAgICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCct
ZGV2aWNlJywgJ2UxMDAwZSxuZXRkZXY9bmV0MSxidXM9cGNpZS4wJykNCj4gPiAgICAgICAgICAg
c2VsZi52bS5hZGRfYXJncygnLW5ldGRldicsICd1c2VyLGlkPW5ldDEnKQ0KPiA+ICsgICAgICAg
IHNlbGYudm0uYWRkX2FyZ3MoJy1kZXZpY2UnLA0KPiA+ICsgICAgICAgICAgICAnbW9jay1pM2Mt
dGFyZ2V0LGJ1cz1kdy5pM2MuNSxwaWQ9MHhhYjkwNzg1NjM0MTInKQ0KPiA+ICAgICAgICAgICBz
ZWxmLmRvX3Rlc3RfYXJtX2FzcGVlZF9zZGtfc3RhcnQoDQo+ID4gICAgICAgICAgICAgICBzZWxm
LnNjcmF0Y2hfZmlsZSgiYXN0MjYwMC1kZWZhdWx0IiwgImltYWdlLWJtYyIpKQ0KPiA+DQo+ID4g
QEAgLTY5LDYgKzgwLDcgQEAgZGVmIHRlc3RfYXJtX2FzdDI2MDBfZXZiX3NkayhzZWxmKToNCj4g
PiAgICAgICAgICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsDQo+ID4g
ICAgICAgICAgICAgICAgJy9zYmluL2h3Y2xvY2sgLWYgL2Rldi9ydGMxJywgeWVhcikNCj4gPiAg
ICAgICAgICAgc2VsZi5kb19hc3QyNjAwX3BjaWVfdGVzdCgpDQo+ID4gKyAgICAgICAgc2VsZi5k
b19hc3QyNjAwX2kzY190ZXN0KCkNCj4gPg0KPiA+ICAgICAgIGRlZiB0ZXN0X2FybV9hc3QyNjAw
X290cF9ibG9ja2Rldl9kZXZpY2Uoc2VsZik6DQo+ID4gICAgICAgICAgIHNlbGYudm0uc2V0X21h
Y2hpbmUoImFzdDI2MDAtZXZiIikNCj4gDQo+IEkgYW0gc2VlaW5nIHRoZXNlIGVycm9ycyBmcm9t
IExpbnV4IDoNCj4gDQo+IDIwMjYtMDItMTAgMTY6NTA6MjAsODEyOiBbICAgIDUuMDgwMTY4XSBp
M2MgaTNjLTA6IHhmZXIgZXJyb3I6IDQNCj4gMjAyNi0wMi0xMCAxNjo1MDoyMCw4MTg6IFsgICAg
NS4wODM2NDhdIGkzYyBpM2MtMDogeGZlciBlcnJvcjogNA0KPiAyMDI2LTAyLTEwIDE2OjUwOjIw
LDgxODogWyAgICA1LjA4NTgxN10gaTNjIGkzYy0wOiB4ZmVyIGVycm9yOiA0DQo+IDIwMjYtMDIt
MTAgMTY6NTA6MjAsODE4OiBbICAgIDUuMDg2MzY5XSBpM2MgaTNjLTA6IHhmZXIgZXJyb3I6IDQN
Cj4gMjAyNi0wMi0xMCAxNjo1MDoyMCw4NzA6IFsgICAgNS4xMjcyNTddIGkzYyBpM2MtMTogeGZl
ciBlcnJvcjogNA0KPiAyMDI2LTAyLTEwIDE2OjUwOjIwLDg3MzogWyAgICA1LjEzMDg3OV0gaTNj
IGkzYy0xOiB4ZmVyIGVycm9yOiA0DQo+IDIwMjYtMDItMTAgMTY6NTA6MjAsODc0OiBbICAgIDUu
MTMxMjUzXSBpM2MgaTNjLTE6IHhmZXIgZXJyb3I6IDQNCj4gMjAyNi0wMi0xMCAxNjo1MDoyMCw4
NzQ6IFsgICAgNS4xMzE1MjddIGkzYyBpM2MtMTogeGZlciBlcnJvcjogNA0KPiAyMDI2LTAyLTEw
IDE2OjUwOjIwLDkwOTogWyAgICA1LjE2Mjc5MF0gaTNjIGkzYy0yOiB4ZmVyIGVycm9yOiA0DQo+
IDIwMjYtMDItMTAgMTY6NTA6MjAsOTEzOiBbICAgIDUuMTYzNDg4XSBpM2MgaTNjLTI6IHhmZXIg
ZXJyb3I6IDQNCj4gMjAyNi0wMi0xMCAxNjo1MDoyMCw5NDk6IFsgICAgNS4xOTUzOTZdIGkzYyBp
M2MtMzogeGZlciBlcnJvcjogNA0KPiAyMDI2LTAyLTEwIDE2OjUwOjIwLDk1MjogWyAgICA1LjE5
NjEwMV0gaTNjIGkzYy0zOiB4ZmVyIGVycm9yOiA0DQo+IDIwMjYtMDItMTAgMTY6NTA6MjEsMDE4
OiBbICAgIDUuMjUzMzk4XSBpM2MgaTNjLTU6IHhmZXIgZXJyb3I6IDQNCj4gMjAyNi0wMi0xMCAx
Njo1MDoyMSwwNDI6IFsgICAgNS4yNjk1NjVdIGkzYyBpM2MtMDogeGZlciBlcnJvcjogOQ0KPiAy
MDI2LTAyLTEwIDE2OjUwOjIxLDA0MzogWyAgICA1LjI3Mzg0NV0gaTNjLW11eC1pbXgzMTAyIDAt
NGNjMzEwMjAwMDA6DQo+IE5vIG93bmVyc2hpcA0KPiAyMDI2LTAyLTEwIDE2OjUwOjIxLDA0OTog
WyAgICA1LjI3NjAxN10gaTNjIGkzYy0xOiB4ZmVyIGVycm9yOiA5DQo+IDIwMjYtMDItMTAgMTY6
NTA6MjEsMDQ5OiBbICAgIDUuMjc4NzU3XSBpM2MtbXV4LWlteDMxMDIgMS00Y2MzMTAyMDAwMDoN
Cj4gTm8gb3duZXJzaGlwDQo+IA0KPiBJcyB0aGF0IGV4cGVjdGVkID8NCj4gDQoNClllcywgdGhp
cyBiZWhhdmlvciBpcyBleHBlY3RlZC4NCkkgdmVyaWZpZWQgdGhlIHNhbWUgcmVzdWx0IG9uIHRo
ZSBBU1QyNjAwIEVWQiBhbmQgb2JzZXJ2ZWQgaWRlbnRpY2FsIGVycm9yIG1lc3NhZ2VzLg0KDQpJ
M0MgYnVzIDAsIDEsIDIsIDM6DQpUaGVzZSBidXNlcyBhcmUgY29uZmlndXJlZCB0byB1c2UgdGhl
IGkzYy1tdXggKGlteDMxMDIpIGluIHRoZSBkZXZpY2UgdHJlZS4NCkhvd2V2ZXIsIHNpbmNlIHRo
ZSBpM2MgbXV4IG1vZGVsIGlzIG5vdCBwcmVzZW50IGluIHRoZSBjdXJyZW50IGVudmlyb25tZW50
LCB0aGUgZHJpdmVyIHJlcG9ydHM6DQp4ZmVyIGVycm9yOiA0DQpObyBvd25lcnNoaXANClRoZXNl
IG1lc3NhZ2VzIGluZGljYXRlIHRoYXQgdGhlIG11eCBkZXZpY2UgaXMgZXhwZWN0ZWQgYnV0IG5v
dCBhdmFpbGFibGUuDQoNCkkzQyBidXMgNQ0KRm9yIHRoaXMgYnVzLCB0aGUgZmlybXdhcmUgZG9l
cyBub3QgaGF2ZSB0aGlzIGkzYy1tb2NrLXRhcmdldCBtb2RlbCBkcml2ZXIsIHdoaWNoIHJlc3Vs
dHMgaW46DQp4ZmVyIGVycm9yOiA0DQpUaGlzIGlzIGFsc28gZXhwZWN0ZWQgdW5kZXIgdGhlIGN1
cnJlbnQgY29uZmlndXJhdGlvbi4NCg0KRGVzcGl0ZSB0aGVzZSBlcnJvciBtZXNzYWdlcywgdGhl
IEkzQyBkZXZpY2Ugbm9kZXMgYXJlIHN0aWxsIGNyZWF0ZWQgY29ycmVjdGx5Og0KL2Rldi9idXMv
aTNjLw0KICAwLTRjYzUxMTgwMDAwDQogIDAtNGNjNTExODEwMDANCiAgMS00Y2M1MTE4MDAwMA0K
ICAxLTRjYzUxMTgxMDAwDQogIDUtMTIzNDU2Nzg5MGFiDQogIGkzYy00DQpUaGlzIG1lYW5zIHRo
ZSBjb250cm9sbGVyIGl0c2VsZiBpcyBmdW5jdGlvbmluZy4NCldlIGNhbiB1c2UgdGhlIGkzYy10
cmFuc2ZlciB0b29sIHRvIGFjY2VzcyB0aGUgZGV2aWNlIG5vZGUgYW5kIHRlc3QgdGhlIGkzYy1t
b2NrLXRhcmdldCBtb2RlbC4NClRoZSByZXN1bHRzIG1hdGNoIGV4cGVjdGF0aW9ucy4NCg0KRm9y
IHJlZmVyZW5jZSwgdGhlIHJlbGV2YW50IERUUyBjb25maWd1cmF0aW9uIGNhbiBiZSBmb3VuZCBo
ZXJlOg0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVk
LW1hc3Rlci12Ni4xOC9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWFzdDI2MDAtZXZi
LmR0cyNMOTUwDQoNClRoYW5rcywNCkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoN
Cg==

