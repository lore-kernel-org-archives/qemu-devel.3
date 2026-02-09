Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E2BEF06FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGpS-0002SY-Hm; Sun, 08 Feb 2026 21:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGpQ-0002SD-It; Sun, 08 Feb 2026 21:16:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGpO-00067D-Sv; Sun, 08 Feb 2026 21:16:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWnZLR3Nz2ABgYKXGrzdM+j17FwKS2+tqqWFyLCKiQZfnD2BUizm9FsurtN+9kTjoHVFZq8JtVt72VWsnk3PRAf4aowH1vFRtJl5F4OG0eEQeADc6AyHhJE7WWuK8/PsOXpqjVX6pndDX8QzG0Z1DEEWcksGXDvvEmJhlPC04+xqqQwOmJMlO7MxeUcex0a+8UWyBwlM5vABkm3fFmZmPHwLx9bMse3WWFLjCKxu1bW8uGcK8HumCqfNFauaQJ60AZh2BYlPzSDltcEx8GeEXkasjp86hPKGZ2hLMHhBpbh1bdFw/99qLD7AstdInM7UmF/xl6kBY5nlWbwQ/FB4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LqABw3PUey0xKRSaQZT3ESssfnAQ2x8Aqs3dRkOosE=;
 b=gTxRSPdYCf1StaL0BCRYP5ggYOTdNt7bWwBFK1/03rUcnOIkrP9zDdZ6SFALObQLhdKzR/WnYinL9cSHIVJc5WEitPoklPp6xQQNRdPUzGe9rr4RH7nK/tknD+0LuUVrMfXzND/wiQ0YwAMHjc1Dp7zcq2+7t+XZlxWkqckKQd5yNpsdWriVEWqpznmtsmEAgEsW3CPB7T8eb584X3QlejS+VamVYyG7bQPHzayo+1PQm0k9gHRGMgd7BAgveIL/M0N7hvLoSvk+yrSOQ7JgmmWSA4EGOXdS8+BpI594tfvZn3KvGgNbTRQSuOfSDmsBgoOc2Bf6zJoZeAl8NFTJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LqABw3PUey0xKRSaQZT3ESssfnAQ2x8Aqs3dRkOosE=;
 b=ND4D8HKMs7A7cHQgww5RTjip98Qb4sXjB1MBX7aY/EJLF4X2YdjMexVvJM/S8FRT4Ko1Mu87zcowfrIOkPIu/FFVlebYOhgpQ6BIkdd8dxPk+emEadFb0iV2Xy70dws1nkfUGe3nxtoTs8/mbLn8v6iP2cx0nxM2vGTLCTpxcgcdXkW977uROaHelQCD5yEIFUnkFt2Y5WlUaVRKeo/qPJ3edPLR2szqbGeJK3mVvRDr229fDU1qwVRep0ryqze+vzF+cKK137oHqDU6aNIH0fiN6LkHHGuNxBsstEio13tdyLZF77n5SzGKmt1ljSKFsmaIYhUKdXoulaX6jQOhUw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6284.apcprd06.prod.outlook.com (2603:1096:400:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:16:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:16:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 06/10] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
Thread-Topic: [PATCH v1 06/10] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
Thread-Index: AQHclyosSbMP25tLj0S0hntsBZSHhrV1alyAgAQ7XKA=
Date: Mon, 9 Feb 2026 02:16:37 +0000
Message-ID: <TYPPR06MB8206DF9473864275B477F362FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-8-jamin_lin@aspeedtech.com>
 <53c7f3d1-a4f5-4c0e-a850-b3caa42126f6@kaod.org>
In-Reply-To: <53c7f3d1-a4f5-4c0e-a850-b3caa42126f6@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6284:EE_
x-ms-office365-filtering-correlation-id: bc0307af-4a4d-4086-af9d-08de678140e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?TzJIbHNvRTkwYWR0M3NIZ2piZjZxOG5IL20zWWlsNWpjdWo4K0drVlhGTmFZ?=
 =?utf-8?B?b1JrV09vS2Vranp1ai9TS1p0Z0NtazVMRG9zajViWmFHTkFlelJDK05QdnNP?=
 =?utf-8?B?T1Y1Z3I4YlBEUTlabXNRM3pNMlpGOUlkYXlmKzlvQ0YzNGplTzhReHUzT0N1?=
 =?utf-8?B?bnZMM0M5R2Rqa0xwbGpMME9ZajFnc1p2SVlPWGRXSDdDd0pRVEFOWG5VS3B4?=
 =?utf-8?B?QjV3aDFjV2NSWnVTaGpEa3RPVXRvVE55NmplYmR2QktUODBjWjBBY25jOHNl?=
 =?utf-8?B?b3kzbTBoRU4vQTFRNUViTW1BN0JYRExIaFZoTnZWYmh0MnVSVnNZT01remVy?=
 =?utf-8?B?SlhIaHRYbVgvR2Mwbzk5NTJINTc0TFNBek1ROXJGTUV1WVBYWmFhYUd6c05r?=
 =?utf-8?B?TkEzSmtRNmxUczBIWHMzMldpL3VJd3BUYjRGaUNkUXRWejZRdFAybnBpMXl2?=
 =?utf-8?B?WldlMU5Wd1Zvam95MXgreWFzWWlhR0REMWZRVi9FbGE2YXRBK09PcHliZEJl?=
 =?utf-8?B?NVNDUHhSSUQ4SkFRSlI2TTlubTFzOHVxMThEaVpPcUVrWUhLZnVhUmR2VW81?=
 =?utf-8?B?RmluZVpqTU0wUmUvUVl3SXdkaWZjRlZ0OGx4R1ZpMWpBRlE4OU5IcktTZkpS?=
 =?utf-8?B?R0k1Q05ZcEZoNUhib2ltYkpXRGlVR3pLMDRpQmRpaVNzZlZFMmlrNENjV24r?=
 =?utf-8?B?RzVteUt6b3dtdnFNenN6K0orWFgxbUYyTHZGbDl3VitRcDVod0RLRFh6QWZV?=
 =?utf-8?B?K0hBa1cvb2s0dVdqcGZrZWZnZzQ1eUNlcVVUa0d4TWxsbXJPc3RlSzNRRFo3?=
 =?utf-8?B?ekJCY3RrWUJtNTQ0SXZUbEl4bG1CNElJdWczaG42YkdpVWFzOVhENzYxTFZz?=
 =?utf-8?B?OXJVelE1Kzd0QnppQ3VPbk1KOVVaK0ZlQnl6bk1YbXFLOWZmV0RyS3AzbXF5?=
 =?utf-8?B?Zjg0Tmh2UWcwNllKd3pHelZjT2s0WXhXR1Y4WkpiRUpXRjM1MzB6Q3I0UUhV?=
 =?utf-8?B?bVgrQ2NGSkV4cmZTaFlHZ2wyaUc3OTVOYVdPdEtaOG4zWVNGeHppdXRFbDAw?=
 =?utf-8?B?R0xQRWQxcXFGWTB1RUk4ZFAvcWQ0Tk9NVjkzWGZXUW54dHh3WmFRNnp4QVpZ?=
 =?utf-8?B?QTBzbnJEWUhNcS9GT0FOSXpnUEJYditnVjA0NXZHc25YdXZiakJBOUVhTERn?=
 =?utf-8?B?TFBVNDI5NWttQkdJd0ZEQlJQNS9oQ1g0L2tVREhYS2JrYnFtV1R3NzhHYmEz?=
 =?utf-8?B?RWtGbmlkQWVwZEx1UEtGREZVcjhBdWFDSEhaai91b25JRTMweUF6OUIvZnFE?=
 =?utf-8?B?RzdqSGZoUEJsOURjNkRIWitTU2ZPUVRXeWRNRlJXTkJuZHlHTUsxaWlLQmVH?=
 =?utf-8?B?UHBQWVphNTN2L2pSdHdkUDFzMnl1MVZlWWhndG9UN1ljcHFhNHowK0U5dWxP?=
 =?utf-8?B?RForNmw4NEN6djUzendDNUV6anBxbDlmVlo5L3doT1lrQTJPYkE5U1lrMzlJ?=
 =?utf-8?B?RDU1V1B2QytJaG1zN0poU0FzNzhDbGJncm5ZVHBZREs1UEhkTFFSU0dlcG1v?=
 =?utf-8?B?YXRRWENSRnVjd09idzVNc2VLVHpTbGEvZ0U2ZEE5SkNleFlVZCtqUWdMa0lG?=
 =?utf-8?B?aE1nY3hZaVdZdFp1WmxQYjlPUElXLzJJODJZdlRMMVd1QzBpNHE0N01mQ3d2?=
 =?utf-8?B?MVRlSllrVDczVXg0ZDhEcUkwemd6SEpXeURJOUs3U1kwMEYrOWZJa3JyRkl0?=
 =?utf-8?B?UVN3aUlJUTFLbDhMVTJXd0VJdFpjT1VTd3F4WWtPanJ5RkVuM0RSTm50UHNB?=
 =?utf-8?B?ZHdkY0dBNzdTVjVGWFNNcC9PMzVadGdaYndITzRpV3NDdVozZWt3UlgyTlRq?=
 =?utf-8?B?RmtDRmMwV1lRa2xtREUydnJMZm1sOW1ubVpRNnJ5bFp4bVFhR1kxVVBrUm0w?=
 =?utf-8?B?VmRNL3FwanUrWWt0QTIyMWt5Tzl5RzlibzJzQzY5M2FmMCtKS2M4cml2NVhQ?=
 =?utf-8?B?a1R0TFVWemVMUU12Wkd6eTM1bjJZWmFBSXBNSVN1SU5lZlkxL3VpWmR0TERi?=
 =?utf-8?B?b0llejY5TVlsYmlRNnpjcnJ5RXl6aWlpYnZzbmFtMS9idzlHRTYwY1ZCYm5O?=
 =?utf-8?B?U2lvemVuT3BkQkhuWnl5bU9QNnRaVVJKaXl3RlpqbXp3aWZSOExSYlBMQnRW?=
 =?utf-8?Q?XclzpLHMz/WfghJ1YIvqbS4tzLKwHEzrafFNd63PrIlt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MndpOUYrZHFKaW0xZ2FvaC9JZWtDSlBRZkJFYU5LWm9COENHdUtUNGJLbkx3?=
 =?utf-8?B?REFpRmUrK1ZJWHpDMkh4aWFMZjJKVEdDUXNldUNjSkxLTFFmWWVZU082bFZE?=
 =?utf-8?B?UVJuL011Q3lCT2UwanJzQTM0M1hWRWlGR2JJMDh2NlRWQVVJbDdyM2pIZTRY?=
 =?utf-8?B?MXZMaGZ6Tm94QmtGZUp4eC9MUTZjZTMzM2swckhhbHpjVVQvcUpQb0QyN2tI?=
 =?utf-8?B?VWY0Q3g5WTZ0VkZqWWFjYTdFM3NCNkxNbFUram96ZFc2WFAyRTYrMWFMY1lm?=
 =?utf-8?B?aTNyWEdaV2JTY0w0TGp4WitWYllzQ3lyK3VOQ1NzWkIwWXIrT3NqOGI1aFpj?=
 =?utf-8?B?MG1HMmFwNFpJVTlYRjR3cmJzejArRzByTmd3OEdWb3JXNDFTek9BQXNQamRY?=
 =?utf-8?B?Wjl5YVVxVjFDWHhxQjhUTWkreHhUWTNUSGVDSVVSbVVBTmg2VENhaUFtYkFt?=
 =?utf-8?B?STdxd1lBb2JPR1VWZ25mek5TVnA2SFNpQ2E3TWNSc3Q1M0J2aFBueC95OFkx?=
 =?utf-8?B?ZkE2RTVFMWFSYzRhNSt2R2pxVG5pZGo3OUhZQU5JZ09TcTRkVUlidGRyWU9V?=
 =?utf-8?B?NzlYZEd5UHYzNUNUeGVCRTVEYzRMU2Y1VW5ST0NEUkMvaEhoQlRkRU5NOVN4?=
 =?utf-8?B?cVZDMzU4Q3pqTXVLd2dmc0tTczBXeFZEcnVHWE1yZ2xKRTNxR2lVTGhUM0gr?=
 =?utf-8?B?QzU5OU9mdzZxVlNoVnBFa0loNmRZcUxMWG5UU1E4ZjdSeWJuTnk3MzNVVHRq?=
 =?utf-8?B?RmZsQ1hkY3Z4YWZoTjFaQ2gxZFRHa0JPcG1KTzZ2L2lMZm5WRTFoc1JNSEc1?=
 =?utf-8?B?bHUvNTlBald4MVdKV1drVzArZlNmcXlwUkhEWW1hVjZodGVmWUhFT2wxMEl5?=
 =?utf-8?B?a21sMGU1OGw4ZFdJbGtHOXJDZC9aSVBRVGQ5M3FXVnNvU2hkNVhuR29uU0o2?=
 =?utf-8?B?S3lqSkV4b0tXb0UyVHlvZDNlUDlNSCtFZUxkTDRQaEFjNlYvak44bDR5VUV2?=
 =?utf-8?B?SnpHeitzdmZ2UmlhM01iWlpXQjRtWWw3ZXhNSEVKUGFMcTdvdGRsWGMvUDh4?=
 =?utf-8?B?Tjd0RVljOTlWU0xwcHIzRjhtdUkrSEJwbDliSkFhNXZBVUg2ZkIyQWo0NDhP?=
 =?utf-8?B?MzJVQk1ZQmpZOFFUekJuY1c4b1lmdUxQZEJUR2pSS09DNkcwT0pKRjA1R1A3?=
 =?utf-8?B?OEJKTTF2cGVwUVJ1VkNFSllzcTk2MUpkWEwwQThKQktPMUoxTkdaWWMyR1Rw?=
 =?utf-8?B?eWxwSGtFZUNJRWxuL1JrK3ErUmh6a2Z1aFhSeWUveVhXMFFPL0ljU0dYaEw3?=
 =?utf-8?B?ZCt4RXdpTmtIcGRnVnlUaWdOUzlZYnJkRy9iUjZpd1J3bVgydVAwZnlNWG54?=
 =?utf-8?B?U1luMDJiVXpnQTZFUDBQN3lBQ1JoaEZGbVowTkI5WmJRUGJqdUxEL0tKQ0NJ?=
 =?utf-8?B?MVFGenRYcTByeEVKZSszZVJSaExzU0pRVzRIS2pXVzRPdHViL0RKWkdHekhq?=
 =?utf-8?B?SU8zNWZndVlVTGwrMExWUElIUlZwT2doZFQ2cW11c0thaUN5ZmdQUHVPWE9R?=
 =?utf-8?B?TGllU0ZNQmhyQkRNM2dZb3JaQ24yTGQrdk5tMzR0ZEc2dlRRTy85aDUvTS8z?=
 =?utf-8?B?aE90UkIrNkN2dGhqTnFvRWNxNForZ1Vna05mNWdhMHdxRjdTUWYxTGo2RXdk?=
 =?utf-8?B?UDg4bEdoZ3R6R3owZjhiZXoyWUErUzRWNnk3K0RBNVQ5ZklueHRYTytxWWpu?=
 =?utf-8?B?ZUJoUkl4N1ZDVFFDVEFmVjNCRUtHbHBqOUNkZnZ4UkxlSVZJV01oRGxkbWVU?=
 =?utf-8?B?a1I1RW9VQjY2dUxocDlzZGhLS2JCZFNyRjlLMDZ3N1Y2NnVPNWh3RWMrc1FB?=
 =?utf-8?B?aHNwRS93a28vcjlKQ3VXWmZPR2NEUWhJUk5KODlKa29USWhKdGE4eG11RjFW?=
 =?utf-8?B?MXp6UCsyamQvMUwwdG5kNW1vMnBhbTZQTlo4b09zWUUvUzVoSkl3aUkxVjZt?=
 =?utf-8?B?czZXemNYKzMwVGhNdXJLcWRJVzNVcS9pMitFZi9Lb251djhLY3dHRk1wSk90?=
 =?utf-8?B?bnpSM0dMekxqbkppTUVQVFFNOHBTSE5nOU5TVERVUTNKWHh1MDVncm5HUEE2?=
 =?utf-8?B?djFrMkl1cTZ0RUJMVDVUdkxZajA3VDlCaXFhQjlaWU1ncGRsMU9NTTJGSkhJ?=
 =?utf-8?B?QUNBMzJRQXo5YnVHT29zODMzZTVMRFFiV2Z2T1ZVRldFOU5mOXZMQm1zaDF0?=
 =?utf-8?B?RVJWNFA2N0NuTSszUEZSQmF1K1BpS29aWkwwK2Y3S1FUdTJkQVFxY2hna1Ro?=
 =?utf-8?B?ZytlbGgycVN6TUJMa0dlNWM5bjNGRUVlaDJEZGJpN0FKWUE0aHhyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0307af-4a4d-4086-af9d-08de678140e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 02:16:37.0344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ND1YcJyEaJupoQIg01Jz00cHBnJbW2DRoP0yxjXllDazsIqw8unySwLZfILdVAGRfgzctgizwE67lixrkOAuve7H7XOew8lVuToAZPWeqtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6284
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDYvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MF9ldmI6IEFkZCBBU1QyNzAwIEEyDQo+IEVWQiBtYWNoaW5lDQo+IA0KPiBPbiAy
LzYvMjYgMDY6MzMsIEphbWluIExpbiB3cm90ZToNCj4gPiBBZGQgYSBuZXcgQVNUMjcwMCBBMiBF
VkIgbWFjaGluZSB0byBtb2RlbCB0aGUgbmV3ZXIgQTIgc2lsaWNvbi4NCj4gPg0KPiA+IFRoZSAi
YXN0MjcwMC1ldmIiIG1hY2hpbmUgYWxpYXMgaXMgbW92ZWQgdG8gdGhlIEFTVDI3MDAgQTIgRVZC
LCBtYWtpbmcNCj4gPiBpdCB0aGUgZGVmYXVsdCBBU1QyNzAwIGV2YWx1YXRpb24gYm9hcmQuIFRo
ZSBleGlzdGluZyBBU1QyNzAwIEExIEVWQg0KPiA+IG1hY2hpbmUgcmVtYWlucyBhdmFpbGFibGUg
YXMgImFzdDI3MDBhMS1ldmIiLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2Fz
dDI3eDBfZXZiLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDBfZXZiLmMgYi9ody9hcm0vYXNwZWVkX2Fz
dDI3eDBfZXZiLmMNCj4gPiBpbmRleCAzMWY3ZDYxMTE3Li4wZmYxYmViZWIwIDEwMDY0NA0KPiA+
IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MF9ldmIuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3Bl
ZWRfYXN0Mjd4MF9ldmIuYw0KPiA+IEBAIC0zNCw3ICszNCw2IEBAIHN0YXRpYyB2b2lkDQo+IGFz
cGVlZF9tYWNoaW5lX2FzdDI3MDBhMV9ldmJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsDQo+
ID4gICAgICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOw0KPiA+ICAgICAg
IEFzcGVlZE1hY2hpbmVDbGFzcyAqYW1jID0gQVNQRUVEX01BQ0hJTkVfQ0xBU1Mob2MpOw0KPiA+
DQo+ID4gLSAgICBtYy0+YWxpYXMgPSAiYXN0MjcwMC1ldmIiOw0KPiANCj4gUGxlYXNlIGNoYW5n
ZSB0aGUgbWFjaGluZSBhbGlhcyBpbiBhIHNlcGFyYXRlIHBhdGNoLg0KVGhhbmtzIGZvciB0aGUg
cmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCBkby4NCg0KVGhhbmtzLA0KSmFtaW4NCj4gDQo+
IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiAgICAgICBtYy0+ZGVzYyA9ICJBc3BlZWQg
QVNUMjcwMCBBMSBFVkIgKENvcnRleC1BMzUpIjsNCj4gPiAgICAgICBhbWMtPnNvY19uYW1lICA9
ICJhc3QyNzAwLWExIjsNCj4gPiAgICAgICBhbWMtPmh3X3N0cmFwMSA9IEFTVDI3MDBfRVZCX0hX
X1NUUkFQMTsgQEAgLTUwLDEyICs0OSw0MA0KPiBAQA0KPiA+IHN0YXRpYyB2b2lkIGFzcGVlZF9t
YWNoaW5lX2FzdDI3MDBhMV9ldmJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsDQo+ID4gICAg
ICAgYXNwZWVkX21hY2hpbmVfY2xhc3NfaW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCj4gPiAgIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9hc3QyNzAwYTJfZXZiX2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZA0KPiAqZGF0YSkNCj4gPiArew0KPiA+
ICsgICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOw0KPiA+ICsgICAgQXNw
ZWVkTWFjaGluZUNsYXNzICphbWMgPSBBU1BFRURfTUFDSElORV9DTEFTUyhvYyk7DQo+ID4gKw0K
PiA+ICsgICAgbWMtPmFsaWFzID0gImFzdDI3MDAtZXZiIjsNCj4gPiArICAgIG1jLT5kZXNjID0g
IkFzcGVlZCBBU1QyNzAwIEEyIEVWQiAoQ29ydGV4LUEzNSkiOw0KPiA+ICsgICAgYW1jLT5zb2Nf
bmFtZSAgPSAiYXN0MjcwMC1hMiI7DQo+ID4gKyAgICBhbWMtPmh3X3N0cmFwMSA9IEFTVDI3MDBf
RVZCX0hXX1NUUkFQMTsNCj4gPiArICAgIGFtYy0+aHdfc3RyYXAyID0gQVNUMjcwMF9FVkJfSFdf
U1RSQVAyOw0KPiA+ICsgICAgYW1jLT5mbWNfbW9kZWwgPSAidzI1cTAxanZxIjsNCj4gPiArICAg
IGFtYy0+c3BpX21vZGVsID0gIncyNXE1MTJqdiI7DQo+ID4gKyAgICBhbWMtPm51bV9jcyAgICA9
IDI7DQo+ID4gKyAgICBhbWMtPm1hY3NfbWFzayA9IEFTUEVFRF9NQUMwX09OIHwgQVNQRUVEX01B
QzFfT04gfA0KPiBBU1BFRURfTUFDMl9PTjsNCj4gPiArICAgIGFtYy0+dWFydF9kZWZhdWx0ID0g
QVNQRUVEX0RFVl9VQVJUMTI7DQo+ID4gKyAgICBhbWMtPmkyY19pbml0ICA9IGFzdDI3MDBfZXZi
X2kyY19pbml0Ow0KPiA+ICsgICAgYW1jLT52Ym9vdHJvbSA9IHRydWU7DQo+ID4gKyAgICBtYy0+
ZGVmYXVsdF9yYW1fc2l6ZSA9IDIgKiBHaUI7DQo+ID4gKyAgICBhc3BlZWRfbWFjaGluZV9jbGFz
c19pbml0X2NwdXNfZGVmYXVsdHMobWMpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGNv
bnN0IFR5cGVJbmZvIGFzcGVlZF9hc3QyN3gwX2V2Yl90eXBlc1tdID0gew0KPiA+ICAgICAgIHsN
Cj4gPiAgICAgICAgICAgLm5hbWUgICAgICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgiYXN0Mjcw
MGExLWV2YiIpLA0KPiA+ICAgICAgICAgICAucGFyZW50ICAgICAgICA9IFRZUEVfQVNQRUVEX01B
Q0hJTkUsDQo+ID4gICAgICAgICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX21hY2hpbmVfYXN0
MjcwMGExX2V2Yl9jbGFzc19pbml0LA0KPiA+ICAgICAgICAgICAuaW50ZXJmYWNlcyAgICA9IGFh
cmNoNjRfbWFjaGluZV9pbnRlcmZhY2VzLA0KPiA+ICsgICAgfSwNCj4gPiArICAgIHsNCj4gPiAr
ICAgICAgICAubmFtZSAgICAgICAgICA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJhc3QyNzAwYTItZXZi
IiksDQo+ID4gKyAgICAgICAgLnBhcmVudCAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0K
PiA+ICsgICAgICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX21hY2hpbmVfYXN0MjcwMGEyX2V2
Yl9jbGFzc19pbml0LA0KPiA+ICsgICAgICAgIC5pbnRlcmZhY2VzICAgID0gYWFyY2g2NF9tYWNo
aW5lX2ludGVyZmFjZXMsDQo+ID4gICAgICAgfQ0KPiA+ICAgfTsNCj4gPg0KDQo=

