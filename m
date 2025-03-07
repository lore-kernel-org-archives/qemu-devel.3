Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15D5C282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNgP-0000oV-Aq; Thu, 06 Mar 2025 21:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqNgK-0000o4-C4; Thu, 06 Mar 2025 21:43:24 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqNgH-0000cn-SM; Thu, 06 Mar 2025 21:43:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwajzG83myJNW2ykvPDeW0O0z4Q120Uwu8GqmP2sP+L1VpwoojIPwHU7I9s0709LGHhwbsN8B3vINVbkKleVGGmPdaMDSsu6FgAKywjsLQY5Wf7NdxWTWayjIF84FckWg1Xat5pBCQrOpbCcH/+z/cstRQ4fcDF25f0m2HoDrDgwR7VQhTlPKy8OA6ce4kHKVR81D5Ofw01S+i/2i3HbwyiUOYUneT5DCu9Nb+bVnoqvOOWbXaTku6iZ41VFYrtZuiymqpD0LPntShbAS222cBT5XNNdbRKeeGBP6UweA6a5IlGe4M3uEzgohd+6QwhsZW9SeXAC4KjwWBDm5bHUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK0nGdjbwQ6ijDgD1y3DJjc3XcqBYoKwDDRWeHtiwGA=;
 b=PAdXUOdUIMK6wRBuutX2nGvvzYXYXXqJuTfFqFSxxynJD7f7RV/VTDX2eAB4Wvk0DWa6IWkdDrF6QCWxTwlaIFijXCsVhnqVfyYbgSbGgr4fP6j2re+kiwmoL6R+Zcfr474ORXDoZ2im/1x2vaBxsoMysjdpAOokAA42XeAL8dZu8UyswDnwgWtGpPWAA8cDTwlE1wAm+yjzLdxyl1urFyrl3mCOWFU5Wb73PvAnXxa3QG6rgOZRnTWif0ItuTMNovd7ZekPNnLOVprxyhTd9q9havd4PyecA0D4b3JToth2tpsQiHH1CMA5aHLqgXkeFdVzGk+6jx4zBHEDLClfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK0nGdjbwQ6ijDgD1y3DJjc3XcqBYoKwDDRWeHtiwGA=;
 b=gTpf1cnlousCry2hPo+Hem8BHaG0XL7wPO+RmHfMYQkRZSfbOE2I3CPDZO2o/hwhpNUHNYuJrXIxxEaPCZj2guOjpvAYWKvY+mopPix8YjCp7IZ7+cQAZdgPN7NasrlpFO+8IfozMMUA0klfm41KN2n2a62KKBlGHgumoLJZicsVwBXbu4jmcKlYHM8MWb7kJjtR3lk7hDry1Q2fOe6W/aRi7QndWqfvbwk9jNZPN2uIV6c5eyJdocgtcasNH4wzHH8EB4+AXhdUkgmMfeaqiAn6QP8OoOQnwZeT5q9HESjlimNr1I+eC3MVrA+XAy26uQeOh3AfP3B1BUShOojT2Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6220.apcprd06.prod.outlook.com (2603:1096:400:35c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 02:43:04 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:43:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 04/29] hw/intc/aspeed: Support setting different
 register size
Thread-Topic: [PATCH v5 04/29] hw/intc/aspeed: Support setting different
 register size
Thread-Index: AQHbjoP2b5RQYvTZh0KpAPMbReyV7bNmOrcAgAC9ZwA=
Date: Fri, 7 Mar 2025 02:43:03 +0000
Message-ID: <SI2PR06MB504163437DA8DE0AC5F22F60FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
 <20250306103846.429221-5-jamin_lin@aspeedtech.com>
 <351689e6-7267-4641-8096-20a34889aa67@kaod.org>
In-Reply-To: <351689e6-7267-4641-8096-20a34889aa67@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6220:EE_
x-ms-office365-filtering-correlation-id: bbc523d2-aea5-4c59-e50d-08dd5d21c85f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VnY3TTNlTUMvTVdjV2phOTlNR1hsWjhmdW9kZXdvNXc0L2lEZXdOUXZ0ZTdH?=
 =?utf-8?B?cU0rTXZIci9qb0xoNHQ5MHZhQTdvMkdpQTM1MnhOS0x0UTkvazdzd0RjeWZ5?=
 =?utf-8?B?YU9zaFpOaEhNTFJZcEROR2RhckJNaWJFQ1pJcmJxNXJya0VRRHExbW8reVdM?=
 =?utf-8?B?THgxejJLbk81ejlJM3FYdmE3dHd4TkwrWVFpaFYwTGpSOFVFWWFLWW9wMG1V?=
 =?utf-8?B?dmNiMjU1dDlBVnV5NDNNek4vUWhIZXk3V0lncy9SeElWRnZFN3UwdEpyRUhR?=
 =?utf-8?B?Y1NPakQwMVk3TkJhQWZtSmxvZWR2QUVyYWZHczNSMHhoR1p3WkU4WU5zdkto?=
 =?utf-8?B?eXFINEFIWEpvTFAwTGpNMzdkTnpqc3UrYjhoT2hnWGZRVWlqMjc5VVlLS0lE?=
 =?utf-8?B?bCs4WUJxdDd3MUI2VmZqZmRLT0xLbkJxTWkzOWdtV3hGNWZUdVZKZXk1dDla?=
 =?utf-8?B?TXFDOU5jRjNJdzU2ME8vYnB3OWFEdUx4M3RtYUpPd2FwSGtZZEJpcGtGRDJt?=
 =?utf-8?B?dnJJYjFqeWxqU2JKUVcwUmFwRFF3Mmxxa2tjNzY3Vi9WTzk1UFpST0xqRXRQ?=
 =?utf-8?B?d2h6dmxJcXBIZ3lIT3FkWUsrcWhodGt1bENUSDBpTWNZei9Hdktod3kzRzdo?=
 =?utf-8?B?d0hqM2VHazZwS1RWWXRzU1FpNzRBMUtzV2xYZmF2WW1SOFVSQzczNzdWaXNi?=
 =?utf-8?B?dFZCSFVEcnJqV1gvTmxhUXJqM2M5N0hzL0R4VkVuVFFac1RQdW1EL3VyTEla?=
 =?utf-8?B?YW5SRTBLaU13MXhudXJ0T2ZYUmZuV3FxYzE2cmgzWS9SRGlQUUVRaXBSM3I4?=
 =?utf-8?B?QWRJVFZibkh4YXhpM2ZuRkExdUJIUU42Z3V6VjBLYU9sTlV3RVV3Vnhva3dU?=
 =?utf-8?B?WVBWMkNEMUhTZmxnSFo5VUh4QUtNaUhDLzVISW9jWmdaTmdkYS9nYU5BeHJX?=
 =?utf-8?B?WndOcVl3a0hMOEJqV1llVFlZWCtZY1lYcXpSNFFXVi9Wak13N0dEZlRtMkR3?=
 =?utf-8?B?cGltY0M5QlZ4U1NtTmtmSkYyK1AyOHJZUi9oMzhJbzhWYVRuYjlmKzhqbW1S?=
 =?utf-8?B?cUFOTUt3WkJZdjRYMnFFWWR0bDhnNlU5Skhab1JYREhTWWd1OWlkZ0FveUFW?=
 =?utf-8?B?UmVhYW8vdWs1SjdrbVdDUEVMSmZ0eWlTamNVbTIzcXM2cHpubHJBQUVUL1BQ?=
 =?utf-8?B?TlB2NjFxN3cvc2RiU05idWhMYUh2bkcvV011VDBBVlE3Rnh4VEliTER1bVEy?=
 =?utf-8?B?V1RaZlMvNEU4cmYzWmV3WlZYRUhEUGtvajNPajNqcGJTbnVMRjJNN2dXVURj?=
 =?utf-8?B?Qm50d3BCVWdXRFdLRWVUdWdEOTdTZTF0SGxIMzZrckVjeUZ6YUgvL3dqK2Jv?=
 =?utf-8?B?NWhNZmlsUW11Y3lPOXJSV2hKL3QrWis1anNPbkdPMXFhejBEbkFhUWxaNlBB?=
 =?utf-8?B?VzhyeEJydWp3WEV6SGFqZVlnUzBpeHhJNTZwWnd1ODhHdVloUmxyTmxEMlhl?=
 =?utf-8?B?QU1ZVzNjOUYrdUtVaUIxeEVGOVhmV3V1d3dVTWlCZFJScVl2a04yQ2ZNQXdK?=
 =?utf-8?B?eHp0b21JTXkzeWpNbDQweXM3MjhBbzdDNGlLTmhURzBzZEMrM0x6T1Z6dHA2?=
 =?utf-8?B?d2dnRC81Um8xN2ZXc1NBWVpnYXpqcWZxaGZUR2VvU3NsdVdMZktCcE16Z3NI?=
 =?utf-8?B?NnYzbUVwQXZjaUh3VXVsVnViK3FFWm5Jalh5a0dRRnRJYWZ6MTZnSVRXdHpo?=
 =?utf-8?B?MnJQUDlZajVNSU5vM3gxZzZDYXNGeGxXcXJlWTNFU3JUeVd5aUJsaVZhWFJU?=
 =?utf-8?B?cEl2a1VQZVQvd3NDcFJRZTBXc3UvSTl1VnpjQTlONEI2aDB0UEVhRzhkYzZ1?=
 =?utf-8?B?TlhBc0xBS3k1bURLTGhNdmV0b21zc1BEYVBld3dWUU0zUkFjOFpwWktTclRP?=
 =?utf-8?Q?VqiwLHX33FFSBhsAPOD6yw9DDCg4a8Qu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1JhYWNjTkRjMnNBOWhIaWp0cExOWWpnYkZScXBXdmNQdFA0MWJVQ1R1U0tJ?=
 =?utf-8?B?N1l2RE5iUnFXeURSQmpQQzdHYXJsK2V2WS9uU2lMWUZwR1ltRkRIS2FmMEtw?=
 =?utf-8?B?MGdXSzM2SnQxZXBjdEQyTlc5M0hyd1pQMXRmdnEvZWNyTTN2S2prY0VWZENB?=
 =?utf-8?B?bkhIblBKNGtPanFCOVU5Z1c4Y0JFck9aUDlKQkNaQmU4Qjh6dFB6d2pmbzJv?=
 =?utf-8?B?VER2RUdOL0Z4cWhqMkZtRDNVNTV3NWFPc0ZrQitYZWI0czZoNGkxZGIyeWZa?=
 =?utf-8?B?KzFsbWVHNHVmeFk0bTErbklDbDIyVm54TkF3MGNnc2Mrd3VaR3lmbTJ1ejNU?=
 =?utf-8?B?dVlLamhSa0V3cEJYNE5KNWZzNENFWXFQS1orNjVuVlZHUU9IYjZVek1zMVhn?=
 =?utf-8?B?S0ZzbmR4ZEJmczN4V1BVVmlNZ1dpR1UzanNKZyt0Q2NIU2FmR0NzVk5JbGxs?=
 =?utf-8?B?ZDB1YTZDY2EybEdJZXA1WkFZa0Vuc2ZGVW5oeHpvd0U4WHNlb0xhOFlaa1VM?=
 =?utf-8?B?KzFOZFdqcDNNOXEyNCtjS1ZseUEyeWtrV2M4eVV6MEZXMzNpUjRtT0Q2TlVC?=
 =?utf-8?B?cSt4ZGdHVjdIN0c2ZzQvNFRsRVpjaHJlWmZWN3BCMTVOZ3hpNFJVZGxlYnI1?=
 =?utf-8?B?cmJSaSsvbnB0bCtlakZSSGxobFBMSlVnNXR3ZytYSm1xdXhaS2k5aHFrT01L?=
 =?utf-8?B?RjRtaDhJODZDWXBMOEVjV2VWaVY4WDhTMmJiS2VsN2VtQittaGhNeHRpcWdT?=
 =?utf-8?B?Smt2YkRJSHFyNmFSUUphQ0ExRDdNalB1QXl5d0cyck90NzJnRlhOTkplblNH?=
 =?utf-8?B?WTJSTjJyT1FzQWVjc0Q1eHZITFdGc0pWdFNrNlNBM1JKL3hnN1ZzSHkybUZq?=
 =?utf-8?B?amdTSTBVTXRpWVpEck5tK1NPMlI3NmhyVksvNjExN0FmeTRGRkRZcHk2bGFG?=
 =?utf-8?B?M1VLYXRQTWM4ZGJjWU1tS3NtNFhUVkU5MFEwYXRHQlltcXhQZlZkNVlIK3dq?=
 =?utf-8?B?MkVmelR6NUpWTS9xaTVVSG9Ib0FtOHhkTWIzQU1pSmhTVkNGWnpJOEk3SzRP?=
 =?utf-8?B?emZJY2J3R21BRHRrSnFyaXc4TlAvUmZRNDVPWUR1ekh3dGtzcHFGNitXMFJR?=
 =?utf-8?B?OXJKR1p0RDZXbC9RcDduR2d3TllZN3VqL1RGdHB0WmNUQlQ5aFA0SWZCbDU1?=
 =?utf-8?B?VlFNYlBtRlcrR0ZLcVJnbjBKUjBDcDNmcGN0VGFiQXpGbnNTUUt4MnZURDlr?=
 =?utf-8?B?WTdiK0VGZWlrSkhmRnhLeEowSDJKTUJDZ1YxcUNOZ3NjWURUbXRQblNaWlZP?=
 =?utf-8?B?dmFQTVBselM0amJWZ2VWNnNoalA3OTRLc1Ryb1dVcnoyM0FoZ3ZvemVBL3pt?=
 =?utf-8?B?dnVYZ3dLSGN4MlRkblRYcUx1TlBoQUxJOUVLMkhmeC9MV012ek1Sd1JZeEs0?=
 =?utf-8?B?VFZ1RllHN2ZlMXpjZUNFbGxEUFdKWUJ6d202clJKdi9RelFydnVsdVdqdFRZ?=
 =?utf-8?B?K2RROC9YU1hIdVVOMkI2cDVYNVFjZTlzTHMvUGhmNkRYTWtUeG9LcUNNb1Bs?=
 =?utf-8?B?QS9QMnFrWnA2ZUMzMTFXTUlwckpWeTdURzRpMVkzcUZNMmcxL0tWaUhZZXZ0?=
 =?utf-8?B?UGd3b2R6emdrK2RqL09mNDI2YzU1QWtJM2VPVk9UeWZBeXhJM0d2ci9uc05Q?=
 =?utf-8?B?RzlRM1NreGpZaE11U0xKS0xURUNGREV2S1JuUnpjNXRleUM2V044K2t2empV?=
 =?utf-8?B?d3IzS0p0V0RpRUNmYjZ2S0tjeU1xVGg4NEhzTnYwajZuOFNhVTA1a0U1TDBj?=
 =?utf-8?B?RnZVMFVyZTZSNDc0YmRTVndwTEREbXpCOUtCOEJoS2U3alNscjRVcXNtYnZh?=
 =?utf-8?B?ZXhudjlGVGlaSW0wVis0bUlyYVpoYVRaVzJXZWFhMTk5TldOR0lqSnlPVDRM?=
 =?utf-8?B?RDBsUkRIRHl2cCs2Zlg5V0lrMWJhZjY1Q0RLOUxaeVE5MUxJRmpMSXZocVY3?=
 =?utf-8?B?YWwraENkOUZpOVNFdkFCcUh6aDI0WFZrZmVsKzgvRFJSRTBtZHAvQWdhUWRT?=
 =?utf-8?B?TmRlRDNMdnNkY2I4MFlGWGhxTnQwWml1VW02Tm9uRUJJM3g1eVc5cVdySWk3?=
 =?utf-8?Q?vcBS8M2m+vg4lIPZNZCkiYJNF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc523d2-aea5-4c59-e50d-08dd5d21c85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 02:43:03.3278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKx8vRFSMwuw6V/evZB3Pu46dntzvHf7aZ2LZDuX/WtxVyAtha8slHdMdwCyVhp4YKnz5IxIfwkFhPhdgkct6dZxU1Q0vnvkffdYfB5iftM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6220
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDQvMjldIGh3L2ludGMvYXNw
ZWVkOiBTdXBwb3J0IHNldHRpbmcgZGlmZmVyZW50DQo+IHJlZ2lzdGVyIHNpemUNCj4gDQo+IE9u
IDMvNi8yNSAxMTozOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgdGhlIHNpemUg
b2YgdGhlIHJlZ3MgYXJyYXkgaXMgMHgyMDAwLCB3aGljaCBpcyB0b28gbGFyZ2UuDQo+ID4gU28g
ZmFyLCBpdCBvbmx5IHVzZSBHSUNJTlQxMjggLSBHSUNJTlQxMzQsIGFuZCB0aGUgb2Zmc2V0cyBm
cm9tIDAgdG8gMHgxMDAwDQo+IGFyZSB1bnVzZWQuDQo+ID4gVG8gc2F2ZSBjb2RlIHNpemUsIGlu
dHJvZHVjZSBhIG5ldyBjbGFzcyBhdHRyaWJ1dGUgInJlZ19zaXplIiB0byBzZXQNCj4gPiB0aGUg
ZGlmZmVyZW50IHJlZ2lzdGVyIHNpemVzIGZvciB0aGUgSU5UQyBtb2RlbHMgaW4gQVNUMjcwMCBh
bmQgYWRkIGENCj4gPiByZWdzIHN1Yi1yZWdpb24gaW4gdGhlIG1lbW9yeSBjb250YWluZXIuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oIHwgIDIgKy0N
Cj4gPiAgIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAgICAgIHwgMjIgKysrKystLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDE4IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50
Yy5oDQo+ID4gYi9pbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaCBpbmRleCA0N2VhMDUyMGI1
Li4xN2NkODg5ZTBkIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50
Yy5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmgNCj4gPiBAQCAtMTYs
NyArMTYsNiBAQA0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF8yNzAwX0lOVEMgVFlQRV9BU1BF
RURfSU5UQyAiLWFzdDI3MDAiDQo+ID4gICBPQkpFQ1RfREVDTEFSRV9UWVBFKEFzcGVlZElOVENT
dGF0ZSwgQXNwZWVkSU5UQ0NsYXNzLA0KPiBBU1BFRURfSU5UQykNCj4gPg0KPiA+IC0jZGVmaW5l
IEFTUEVFRF9JTlRDX05SX1JFR1MgKDB4MjAwMCA+PiAyKQ0KPiA+ICAgI2RlZmluZSBBU1BFRURf
SU5UQ19OUl9JTlRTIDkNCj4gPg0KPiA+ICAgc3RydWN0IEFzcGVlZElOVENTdGF0ZSB7DQo+ID4g
QEAgLTQyLDYgKzQxLDcgQEAgc3RydWN0IEFzcGVlZElOVENDbGFzcyB7DQo+ID4gICAgICAgdWlu
dDMyX3QgbnVtX2xpbmVzOw0KPiA+ICAgICAgIHVpbnQzMl90IG51bV9pbnRzOw0KPiA+ICAgICAg
IHVpbnQ2NF90IG1lbV9zaXplOw0KPiA+ICsgICAgdWludDY0X3QgcmVnX3NpemU7DQo+IA0KPiBU
aGUgJ19zaXplJyBwcmVmaXggZGVzY3JpYmluZyBhIG51bWJlciBvZiByZWdpc3RlcnMgaXMgY29u
ZnVzaW5nLg0KPiAnbnJfcmVncycgd291bGQgYmUgYmV0dGVyLg0KPiANCldpbGwgZG8NCg0KVGhh
bmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24gYW5kIHJldmlldy4NCkphbWluDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgI2VuZGlmIC8qIEFT
UEVFRF9JTlRDX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9hc3BlZWRfaW50Yy5jIGIv
aHcvaW50Yy9hc3BlZWRfaW50Yy5jIGluZGV4DQo+ID4gZmViMmM1MjQ0MS4uMWMzZGMzZmNlMCAx
MDA2NDQNCj4gPiAtLS0gYS9ody9pbnRjL2FzcGVlZF9pbnRjLmMNCj4gPiArKysgYi9ody9pbnRj
L2FzcGVlZF9pbnRjLmMNCj4gPiBAQCAtMTIwLDEzICsxMjAsNiBAQCBzdGF0aWMgdWludDY0X3Qg
YXNwZWVkX2ludGNfcmVhZCh2b2lkICpvcGFxdWUsDQo+IGh3YWRkciBvZmZzZXQsIHVuc2lnbmVk
IGludCBzaXplKQ0KPiA+ICAgICAgIHVpbnQzMl90IHJlZyA9IG9mZnNldCA+PiAyOw0KPiA+ICAg
ICAgIHVpbnQzMl90IHZhbHVlID0gMDsNCj4gPg0KPiA+IC0gICAgaWYgKHJlZyA+PSBBU1BFRURf
SU5UQ19OUl9SRUdTKSB7DQo+ID4gLSAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJS
T1IsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAiJXM6IE91dC1vZi1ib3VuZHMgcmVhZCBh
dCBvZmZzZXQgMHglIg0KPiBIV0FERFJfUFJJeCAiXG4iLA0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgX19mdW5jX18sIG9mZnNldCk7DQo+ID4gLSAgICAgICAgcmV0dXJuIDA7DQo+ID4gLSAg
ICB9DQo+ID4gLQ0KPiA+ICAgICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOw0KPiA+ICAgICAgIHRy
YWNlX2FzcGVlZF9pbnRjX3JlYWQob2Zmc2V0LCBzaXplLCB2YWx1ZSk7DQo+ID4NCj4gPiBAQCAt
MTQzLDEzICsxMzYsNiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y193cml0ZSh2b2lkICpvcGFx
dWUsDQo+IGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IGRhdGEsDQo+ID4gICAgICAgdWludDMyX3Qg
Y2hhbmdlOw0KPiA+ICAgICAgIHVpbnQzMl90IGlycTsNCj4gPg0KPiA+IC0gICAgaWYgKHJlZyA+
PSBBU1BFRURfSU5UQ19OUl9SRUdTKSB7DQo+ID4gLSAgICAgICAgcWVtdV9sb2dfbWFzayhMT0df
R1VFU1RfRVJST1IsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAiJXM6IE91dC1vZi1ib3Vu
ZHMgd3JpdGUgYXQgb2Zmc2V0IDB4JSINCj4gSFdBRERSX1BSSXggIlxuIiwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgIF9fZnVuY19fLCBvZmZzZXQpOw0KPiA+IC0gICAgICAgIHJldHVybjsN
Cj4gPiAtICAgIH0NCj4gPiAtDQo+ID4gICAgICAgdHJhY2VfYXNwZWVkX2ludGNfd3JpdGUob2Zm
c2V0LCBzaXplLCBkYXRhKTsNCj4gPg0KPiA+ICAgICAgIHN3aXRjaCAocmVnKSB7DQo+ID4gQEAg
LTI4OCw4ICsyNzQsOSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y19pbnN0YW5jZV9pbml0KE9i
amVjdCAqb2JqKQ0KPiA+ICAgc3RhdGljIHZvaWQgYXNwZWVkX2ludGNfcmVzZXQoRGV2aWNlU3Rh
dGUgKmRldikNCj4gPiAgIHsNCj4gPiAgICAgICBBc3BlZWRJTlRDU3RhdGUgKnMgPSBBU1BFRURf
SU5UQyhkZXYpOw0KPiA+ICsgICAgQXNwZWVkSU5UQ0NsYXNzICphaWMgPSBBU1BFRURfSU5UQ19H
RVRfQ0xBU1Mocyk7DQo+ID4NCj4gPiAtICAgIG1lbXNldChzLT5yZWdzLCAwLCBBU1BFRURfSU5U
Q19OUl9SRUdTKTsNCj4gPiArICAgIG1lbXNldChzLT5yZWdzLCAwLCBhaWMtPnJlZ19zaXplKTsN
Cj4gPiAgICAgICBtZW1zZXQocy0+ZW5hYmxlLCAwLCBzaXplb2Yocy0+ZW5hYmxlKSk7DQo+ID4g
ICAgICAgbWVtc2V0KHMtPm1hc2ssIDAsIHNpemVvZihzLT5tYXNrKSk7DQo+ID4gICAgICAgbWVt
c2V0KHMtPnBlbmRpbmcsIDAsIHNpemVvZihzLT5wZW5kaW5nKSk7IEBAIC0zMDcsOSArMjk0LDkg
QEANCj4gPiBzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y19yZWFsaXplKERldmljZVN0YXRlICpkZXYs
IEVycm9yICoqZXJycCkNCj4gPg0KPiA+ICAgICAgIHN5c2J1c19pbml0X21taW8oc2JkLCAmcy0+
aW9tZW1fY29udGFpbmVyKTsNCj4gPg0KPiA+IC0gICAgcy0+cmVncyA9IGdfbWFsbG9jMChBU1BF
RURfSU5UQ19OUl9SRUdTKTsNCj4gPiArICAgIHMtPnJlZ3MgPSBnX21hbGxvYzAoYWljLT5yZWdf
c2l6ZSk7DQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5pb21lbSwgT0JKRUNU
KHMpLCAmYXNwZWVkX2ludGNfb3BzLA0KPiBzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgIFRZUEVfQVNQRUVEX0lOVEMgIi5yZWdzIiwNCj4gQVNQRUVEX0lOVENfTlJfUkVHUyA8PCAy
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX0FTUEVFRF9JTlRDICIucmVn
cyIsIGFpYy0+cmVnX3NpemUNCj4gPDwNCj4gPiArIDIpOw0KPiA+DQo+ID4gICAgICAgbWVtb3J5
X3JlZ2lvbl9hZGRfc3VicmVnaW9uKCZzLT5pb21lbV9jb250YWluZXIsIDB4MCwNCj4gPiAmcy0+
aW9tZW0pOw0KPiA+DQo+ID4gQEAgLTM2MSw2ICszNDgsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRf
MjcwMF9pbnRjX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4gKmtsYXNzLCB2b2lkICpkYXRhKQ0K
PiA+ICAgICAgIGFpYy0+bnVtX2xpbmVzID0gMzI7DQo+ID4gICAgICAgYWljLT5udW1faW50cyA9
IDk7DQo+ID4gICAgICAgYWljLT5tZW1fc2l6ZSA9IDB4NDAwMDsNCj4gPiArICAgIGFpYy0+cmVn
X3NpemUgPSAweDIwMDAgPj4gMjsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5
cGVJbmZvIGFzcGVlZF8yNzAwX2ludGNfaW5mbyA9IHsNCg0K

