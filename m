Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2DEC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 09:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxps-0007sd-KY; Thu, 08 May 2025 05:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uCxpk-0007rt-1d; Thu, 08 May 2025 05:46:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uCxph-0000Rx-Vl; Thu, 08 May 2025 05:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0y2zahHMjfMXsXbA1RFywB+z474QhK0k1IcsPiTtjIk2puLL+dTzD8jjkbzuxIy7h4sIn87+s8NAn3nmrHfMziAv+xCPI5p176fKq1B9cBTLXorK5lDOMEc9x8LlygK23ZzKmpGnJoPpT8tURHHmjMZRYE3+uQ0s7NbPxWVOD6CFmo1mh4nMArphkOICFJLFYe8TYYOKtRlW5VscKEbbMY4fd8A2dMqrMJJsJcOjoseWibc6C7dpgu+MqONsiAxe8vYSkPvka0mQWo8AxnHCvnfU3EPmvgqZs+4y/fsKz9tvejSFZPit6WC6gCR/7HIes9XS77n6SvZIzg+jsitvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z7s5+UPvsf97CQLUwNQ3kMD8+S91kd2dmRx5g/g5DI=;
 b=OoRJs0efbopxSjeHuIaMJeNNYvG9xUoXofiH2gTWlQK5juGNwK5Ium928Qu2L97CjzkrpUu0cw3n3ck0cdGK1yixB28jVJ7pdvfh2VQVTLtI6IWgbGIKFRRw6U61JPnpOrb1pHRiP7xk+iag1iIrJW11IIZJ84bVYUmMXPQvslJNLPnQ7tRyWrI+yujDayfNPtmchwSy9TtKUhKO+bb0mBWsbenaBWtFvJh+nSvAN2eeebq/WsomrVd81jVMHNDLCqVSzcUB4/tRP6bKUJqZzc4wmZ1eNzpxZZsAEJZ0sYH7HQmDQlOjCZRfhe9Jeae0h+HQRo86DXKW5daNVPye5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z7s5+UPvsf97CQLUwNQ3kMD8+S91kd2dmRx5g/g5DI=;
 b=FjMfTAKsDSKJ6sZyvrJQDGHhhZBQU+nxgJLXn49WgQH1wPvEj221JxD/vb4xJ5s2qHnA8CclPtW3IuMtkhzbhwmDAwEcu9XpYWfPXMI5qK5Hn00aRm3I6oXUIl1yJ8C1z+ai+7B+lyihPOIBHZSPOOJDbzEmXQeE3vRbqFWtcrm0O3JkSy2WHY7ZsErFXrQKe0AzEcEPfDpBZkfbTFVPF+hOH+cp4ayDZKPmr0g0DfHuGkFOvIWWnhxGLtt1QglH2JbG8lMJ0HRuFGqXl/tUqoZXyugdNwXgl0TXDdHPzhkXjCaAjvqBK3s8iNuju0unUsUxR0FuaAMpbcstF9fyfw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYSPR06MB6541.apcprd06.prod.outlook.com (2603:1096:400:47d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 09:46:15 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 09:46:15 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Kane Chen <kane_chen@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 2/3] hw/misc/aspeed_sbc: Connect Aspeed OTP memory
 device to SBC controller
Thread-Topic: [PATCH v3 2/3] hw/misc/aspeed_sbc: Connect Aspeed OTP memory
 device to SBC controller
Thread-Index: AQHbs/tcIb3sikwTC0+/rq5RAwfDZrO4tC+AgAAOfDCAD8nXMA==
Date: Thu, 8 May 2025 09:46:15 +0000
Message-ID: <SI6PR06MB76317580431C72FC3F1FE3EDF78BA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250423025651.189702-1-kane_chen@aspeedtech.com>
 <20250423025651.189702-3-kane_chen@aspeedtech.com>
 <3c8ff4de-e17f-46c5-ae43-e7ecfa071414@kaod.org>
 <SI6PR06MB76318756D4D9D2C6E35BE20EF7812@SI6PR06MB7631.apcprd06.prod.outlook.com>
In-Reply-To: <SI6PR06MB76318756D4D9D2C6E35BE20EF7812@SI6PR06MB7631.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYSPR06MB6541:EE_
x-ms-office365-filtering-correlation-id: 43628e79-55b9-43dc-e8bf-08dd8e152cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?RExFbGJBRjNHcmc2d3pRZUNXekE1aElBZCszcFRLSm9SajdYQndPcGtKS1RG?=
 =?utf-8?B?Q21IU1FiRHh5SHg3bnR3Tko5b09QZXJKQzhiR1Nualg5dDd0cnRaR2JlN3BJ?=
 =?utf-8?B?MmUvSitrdnp6c250dU5Ra0lVREVLanZwaVVnREN0dW4rL2E2VXhTZ1RnSWZX?=
 =?utf-8?B?NlVRZHhlSFpHTVlRbFNROFF0bVhTallISEozc0daYjVEMHF4VWJPR1hMcFI4?=
 =?utf-8?B?YTN1K1VwYVpCeHFuNEhhbXBQUTBSMm5ZTE1tdVV4eWRxaWhaaEw5ajZpdkdJ?=
 =?utf-8?B?dDA3eEFrM2hxQm9NcVkyeVlvMS9sRTNiR1RsQ2hYWTZmamJtVGhRWDJhbGZ6?=
 =?utf-8?B?NjhFQVdyVFBPM290YVJrd3RUNG5oZ0FOWEhYazNTSnBtSHBqbWcrU2Y5TXpW?=
 =?utf-8?B?c3FFYmFVN25HdHF3dkN4ZndsZU81dWE1TlVOTCswODZvalZsT2pZbDFIZXhQ?=
 =?utf-8?B?NXBMQ2w0dEZGT3lMN0szU3NGS2dtTElqU25pZ3BTYTNwNEtrNFFaekNRMmZ1?=
 =?utf-8?B?Q0hJY1hlNWIxQzBQakFNT0lLcDl1dDduYS9TcHk3dnRjQ3VOSHpCdWhIZkNi?=
 =?utf-8?B?dlhnQUZHV3R1ZTcwSWFJYllwVE1OUTA3dWZzSzI4QWlpVEU3NnY2YzJQVzRH?=
 =?utf-8?B?QklsdW5JYzJ0djBuQ2huUGRHd2YzRFRUSEJiZEN6NG82SEVLc2ppbnNpK3k2?=
 =?utf-8?B?YWhtbkkwZk5paE9tQzI0SGRZa1p1RzFZNWlKbTRPS1Z2MzczTFpERjIzdGxk?=
 =?utf-8?B?eHFkUWFINVN3ajlHWDgvV041ZlllQmpGMVJtR1RsTDBVL0dFUGk4Qlc2QnRQ?=
 =?utf-8?B?am9RVzNQVFZNMmx1elBBczg5S00wcktPbzhtK0NHcFBNcFlGa1U4a0k2MHhn?=
 =?utf-8?B?ZE1GYnlmZUZBTWxQK3REQXdWeWxMWmVDWDg4R3NIQnlGRFVWRkZrNU1wRVZ5?=
 =?utf-8?B?TDNmS2RHSVYxOCtyVzVEUS9iYkdZZUIvK3VKVk1qN3FHVUdUZ3ltUnRzVWIr?=
 =?utf-8?B?RTVzSXBlTVpRWG1FN2xYWWNNOFNaaTVkeXRzUzR2M1YyOWx1YU82WlQxN2hU?=
 =?utf-8?B?OElPakN6SHZwNFV5Ly9mYVl0TUxyTmpvTWVsc1JaU09wd0hDaW15V0NINHdw?=
 =?utf-8?B?TlQrUWZja0NMLzdySkk4MXlCWm16elhlTm4wYzZhRzJhVytSVWFSYlpGMkRL?=
 =?utf-8?B?dks1czh3M2NEWnFLZEZaTmt5NU95R2xTZ0gzUnpEcVBlTlFGR2h6cHltYkdF?=
 =?utf-8?B?SEgwTThYcllOZ0VjbGJ4T0xjcHE5di9JQ056ajduZVhaTkw4SzM4WUxHNEI3?=
 =?utf-8?B?MVJkTnlhTG80Q2dxU0pnRExLWXRHcmJNdzUveUxZdURWdHV2TGZ0VWlneGYw?=
 =?utf-8?B?dE1NT3RjM2ZlNmo2akN3YmlkblVSdVVpeGo2eVE1Y0lrOS9neUVpMTVXMUZt?=
 =?utf-8?B?d2ZQQ2U3KzlFajRNL3JqOFBIa2QrWnU0alJXdWpHc084ZjAzTmt1OEM0dHZV?=
 =?utf-8?B?UWxvelJpZWIydXgyeCtxYWQ1TmRrditUWWsyNkp2OEROaDVlaG5qNnJHQW1t?=
 =?utf-8?B?RFhmRmZhaDgvN0JWTSttUXdhNlk3Wk1FakVCZnBkbnd0S3hWL3RMS0hkQzVs?=
 =?utf-8?B?dThEWEpqYTJUU0hTNVZ4aEYyZGtLcGZhdXExRDkxWTBqZ0VyUDU3SW1Xc2lW?=
 =?utf-8?B?Mi9EdExvV2VKelJqUFRYdWFwZFVqczNLcVdvUmk4dUxWK1ZqL2tVQnJiQ1li?=
 =?utf-8?B?M0dyTEFJVndrQ2xrMXJjSkdMUFc0bnVUQ25xZE90OWp6cFU0aXpIQ3ZsajJw?=
 =?utf-8?B?TUE4QW5XQjB0OEZlYmlrNGhISW50dmk2UFYzcjdobFB5aXR3RGJjQklIYW83?=
 =?utf-8?B?cHFGWCtySWpUQ0FiOEJhQnFUdW81c2k4cDZGL1dscmhrNmlIMEpxRUVpUzdF?=
 =?utf-8?B?dWNnU05oYS9tbk1udlNpUHhPK214dUwxL0tmMjd3c0IwVTkxYTdKMkhYOEVz?=
 =?utf-8?Q?Xq23X17ugyawApiOZCfhl5wWd84R40=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXJiTkg4NnlDZE9XeDBOK0FVVDZoMS9GOFVObHNERllOSS9SeE1aQklDcjV4?=
 =?utf-8?B?N3Q2ek85WUNuWEFOSW1Rd3RFMnk5TlpVR2hnWnFBLy83czQrRURLT1k2ZlVM?=
 =?utf-8?B?SEJVTnFXYjcwRkNDcmxZVFoyaUpKZk1vZ0MvRTVPSDVkRnpaaFhURndlTHFn?=
 =?utf-8?B?YzNmc2ZsVXhiU00rNURZbVF5YUdEeUl5Qll4bmx0d3QwZ09Ld05HNkJmcjVu?=
 =?utf-8?B?UTFoMVR2UzJLRXEyR3B3N3FPNGxINzhsYWJFV09ES0RaNkNPQ25SMjNrWXVn?=
 =?utf-8?B?UFpLanhiNTdXYXN6VUdPTFN3UzlYRDZ2QmVDSjZvUkdDNXpzcnhadm9xOXJD?=
 =?utf-8?B?dXZJbjJ5S3VwMWh5S05MRHg5bFEvdHk3SENuaGxHMVNndGc0VTd3Qk10LzQv?=
 =?utf-8?B?U0F5Y2tMRHNDSUNYSUdyc1pDVVpxRlJJbmExK3lqRW1wb1FGa011eDIrVFhX?=
 =?utf-8?B?TUprZEUyQTQ0QTVyOEVLbUZjMkxjSUp5NHlMMHBjRzE4SnE2bzE4S1IzUmFX?=
 =?utf-8?B?eDdMVm85U0NXNnRGZGFhb1hWU3lBblFRa2l2VEl1UEozYjJiZFd2Smc5dTBa?=
 =?utf-8?B?UW1qWEsyczJlcEhzYVZNRk5KUTlhVHVNRGtuU0tFZVRTVzU1b0NpVVFvN0dq?=
 =?utf-8?B?a3VEQk93Y0M2YXZSb2pGbFJMeHFMYmpCbUwxa2JuYjN2UWR6NXU4SzhTRUVW?=
 =?utf-8?B?ckZuMzhENkYrTWpaZ0loRW1LenJLS2FQRXR4K0FiUjBibUxaVXFiVCtWRFJY?=
 =?utf-8?B?Y2tZMnVaNi9DNHV3TWUyWmtOTm9GcGplRHMwT2dnOGh2R2ptVkZwaVRGTHha?=
 =?utf-8?B?aHZtZURBNUdqN3ZKUTB1c2hnb3RFOXUxUTAxbzg2eTR1YXB4UHBrRkdYbnEr?=
 =?utf-8?B?RVYxdExTRS8rSENtQ2lOV0ZRT2dqYStoeVJUMGlBNEU0ZmgxNkxCd2RvZnFt?=
 =?utf-8?B?RStRaDE0WkVXUjVWNTA4cTlJWnZFdnB2VzE0bDY4YVowVzEwVXFYL21lQkUz?=
 =?utf-8?B?eW85OGRqeENpZ3lvL1N1QUQ4NHJDWStWV00wdVR1MldoeVcyTXRBbS9DVGFy?=
 =?utf-8?B?QWQvV3dkUzRNbzRPelBYL3VBTFpnMVZXb1R6L1k5RXdxWWlRMTY2YzVGZm5W?=
 =?utf-8?B?RmpTaE1TM2pNTmNSY2xzbWNHUWYvRTFreXhpWDhGTk9FTm9Nc2lCMHRvR0RS?=
 =?utf-8?B?aXV4MGdWYzBJK3EzRkVncytiY1RjM080MU1BamVXek9tZmlyUzUyYUtIbjl0?=
 =?utf-8?B?OExDd0FBMHh4Wnh6cXE1enBIUS9LZlkwNlZJeEg5R1BEdEFMVmZhajZ1d0ZU?=
 =?utf-8?B?MzllUzgrSXYrOFBnOGM2U0hrWUg5RTg2SjNmMmE1ZFpCc3JIamlQTzlmWFJn?=
 =?utf-8?B?blFvUG5CYTMwc3B1bGdVcDQxTXNtK1owNkkvWFF6Ulp4RzkrTTZyVmFPd2Ju?=
 =?utf-8?B?R0ozZFUyQzFEUSsrVVJYbThUM0NtZDdlaE9WdjVLdUJMZSttN1VaOEpXOXNT?=
 =?utf-8?B?RjhsZzhJMFJiUnJoaXVsNDRSRHVqT3JvRGRUSUZiT1ZuVFNrZDVoa21keitp?=
 =?utf-8?B?aW1hdzIydU9FWlJOWGJSdUZ4cmk0a0tZZGxaOE5LNkFBaUFqZnl2azVFSnNp?=
 =?utf-8?B?bFFiMXRJL3BZcmlUdGdqRk1ZQ21nY1hLTE5yTTh6MDRKY0kvT1R4c0xyak5l?=
 =?utf-8?B?Y2NOOEJkbHlvaVhLSUN5STlvVXRseDhTWDVXSHVKQTdiWlBqZUVXUTVxeHZT?=
 =?utf-8?B?SmU2bWRzdTFkQ3d5OVhXZ3l3RGk1REtPNEwwS0xDbS9kc3RINFdKOGVNaUJG?=
 =?utf-8?B?V2pOTWU3clgzdmd4ekZlbGlLNDhCUlZQQmRjRmlRazBuL0lUbUhkYUZjcUlv?=
 =?utf-8?B?ditRUE4zUEk1bWdqYXJwcjBzWHpNNk8vMFZEWjRYdkNYSVRQQ3I4UWhybTNw?=
 =?utf-8?B?K29pUTU1S2FGUWNISEh2STBQNjJyOVNwOUdkcGk4SXAzT1lFOTdBajAxOU0z?=
 =?utf-8?B?T0NVMThvSGVZYVNiSThQL2tmeTV2L3VWZ2psLzg5ektMTGU4ak9mSDZPVm9N?=
 =?utf-8?B?eFBKVEU2Y2YyRlZjU3A4YWJSS1VqcGE0Qi8wNCtzaXlhMlRQc29GNDFvOENF?=
 =?utf-8?Q?xTpg5ly3EJXlxqO6+wekSf9BY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43628e79-55b9-43dc-e8bf-08dd8e152cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 09:46:15.1466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ob/ityQqqLsFPeu+d/9bEPD7WvCrw0oiXke4UKuKoT/A0sIzaO1nyAYbNEab4cZzcMbVZmIwiaXYyt6xtFs8RsfhyrWf9PscJ60Rqa9zE60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6541
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiA+ID4gK3sNCj4gPiA+ICsgICAgQXNwZWVkU0JDU3RhdGUgKnMgPSBB
U1BFRURfU0JDKG9wYXF1ZSk7DQo+ID4gPiArICAgIHVpbnQzMl90IG90cF9hZGRyLCBkYXRhLCBv
dHBfb2Zmc2V0Ow0KPiA+ID4gKyAgICBib29sIGlzX2RhdGEgPSBmYWxzZTsNCj4gPiA+ICsgICAg
RXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ID4gPiArDQo+ID4gPiArICAgIGFzc2VydChzLT5v
dHBtZW0pOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBvdHBfYWRkciA9IHMtPnJlZ3NbUl9BRERSXTsN
Cj4gPiA+ICsgICAgaWYgKG90cF9hZGRyIDwgT1RQX0RBVEFfRFdPUkRfQ09VTlQpIHsNCj4gPiA+
ICsgICAgICAgIGlzX2RhdGEgPSB0cnVlOw0KPiA+ID4gKyAgICB9IGVsc2UgaWYgKG90cF9hZGRy
ID49IE9UUF9UT1RBTF9EV09SRF9DT1VOVCkgew0KPiA+ID4gKyAgICAgICAgcWVtdV9sb2dfbWFz
ayhMT0dfR1VFU1RfRVJST1IsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICIlczogSW52
YWxpZCBPVFAgYWRkciAweCV4XG4iLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICBfX2Z1
bmNfXywgb3RwX2FkZHIpOw0KPiA+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ID4gKyAgICB9DQo+
ID4gPiArICAgIG90cF9vZmZzZXQgPSBvdHBfYWRkciA8PCAyOw0KPiA+ID4gKw0KPiA+ID4gKyAg
ICBzLT5vdHBtZW0tPm9wcy0+cmVhZChzLT5vdHBtZW0sIG90cF9vZmZzZXQsICZkYXRhLCAmbG9j
YWxfZXJyKTsNCj4gPiA+ICsgICAgaWYgKGxvY2FsX2Vycikgew0KPiA+ID4gKyAgICAgICAgcWVt
dV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICIlczogRmFpbGVkIHRvIHJlYWQgZGF0YSAweCV4LCAlc1xuIiwNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgX19mdW5jX18sIG90cF9vZmZzZXQsDQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgIGVycm9yX2dldF9wcmV0dHkobG9jYWxfZXJyKSk7DQo+ID4gPiArICAgICAgICBlcnJv
cl9mcmVlKGxvY2FsX2Vycik7DQo+ID4gPiArICAgICAgICByZXR1cm47PiArICAgIH0NCj4gPg0K
PiA+IFBsZWFzZSB1c2UgYW4gQWRkcmVzc1NwYWNlLiBTZWUgYXNwZWVkX3NtYyBmb3IgYW4gZXhh
bXBsZS4NCj4gPg0KPiBJIHdpbGwgcmV3b3JrIHRoZSBjb2RlIHRvIHVzZSBhbiBBZGRyZXNzU3Bh
Y2UgZm9yIE9UUCBtZW1vcnkgYWNjZXNzLg0KPiBUaGFua3MgZm9yIHBvaW50aW5nIG1lIHRvIHRo
ZSBhc3BlZWRfc21jIGV4YW1wbGUg4oCUIGl04oCZcyB2ZXJ5IGhlbHBmdWwuDQoNClNvcnJ5IGZv
ciBicmluZ2luZyB1cCB0aGlzIHRvcGljIGFnYWluLiBXaGlsZSB3b3JraW5nIHdpdGggQWRkcmVz
c1NwYWNlLA0KSSBmb3VuZCB0aGF0IEkgY291bGRuJ3QgZGlyZWN0bHkgdXNlIGFkZHJlc3Nfc3Bh
Y2VfcmVhZCgpIG9yDQphZGRyZXNzX3NwYWNlX3dyaXRlKCkgaW4gdGhlIFNCQyBjb2RlLCBiZWNh
dXNlIHRoZSBPVFAgbWVtb3J5IGVuZm9yY2VzDQptb3JlIHNwZWNpZmljIGFjY2VzcyBydWxlcy4N
Cg0KRm9yIGV4YW1wbGUsIHNvbWUgcmVnaW9ucyBvZiB0aGUgT1RQIG1lbW9yeSBtYXkgYmUgY29u
ZmlndXJlZCBhcw0Kd3JpdGUtb25seSwgbWVhbmluZyB0aGUgZ3Vlc3QgaXMgbm90IGFsbG93ZWQg
dG8gcmVhZCBmcm9tIHRoZW0uIFRvDQpzdXBwb3J0IHRoaXMgYmVoYXZpb3IsIEkgcGxhbiB0byBp
bXBsZW1lbnQgY3VzdG9tIHJlYWQvd3JpdGUgZnVuY3Rpb25zDQppbiB0aGUgT1RQIG1lbW9yeSBk
ZXZpY2UuIFRoZXNlIGZ1bmN0aW9ucyB3aWxsIGFjdCBhcyB3cmFwcGVycyBhcm91bmQNCnRoZSBB
ZGRyZXNzU3BhY2UgQVBJcyBhbmQgZW5mb3JjZSBhZGRpdGlvbmFsIGNoZWNrcyBiZWZvcmUgYWxs
b3dpbmcNCm1lbW9yeSBhY2Nlc3NlcyBmcm9tIHRoZSBTQkMuDQoNClRoZXNlIGFkZGl0aW9uYWwg
Y2hlY2tzIHdpbGwgYmUgaW50cm9kdWNlZCBpbiBhIHNlcGFyYXRlIHBhdGNoIHRvIGtlZXANCnRo
ZSBjaGFuZ2VzIG9yZ2FuaXplZCBhbmQgZWFzaWVyIHRvIHJldmlldy4NCg0KRG8geW91IGhhdmUg
YW55IGNvbmNlcm5zIGFib3V0IHRoaXMgYXBwcm9hY2g/DQoNCkJlc3QgUmVnYXJkcywNCkthbmUN
Cg==

