Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A45C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC7U3-0004xU-LD; Tue, 28 May 2024 20:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sC7U2-0004x3-00; Tue, 28 May 2024 20:48:02 -0400
Received: from mail-sgaapc01on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:feab::71d]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sC7Tx-0004UI-Jw; Tue, 28 May 2024 20:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQUPRSLs/v2fcvK+dGWrrgKe1IGvZWlmtm+p+n4TpqmW22UV/k7J0YTHOxb9ZTJFeb3Ms7YmcY6vZ9UqlQ+/oc0tAAem6a/btSLYVq+VL4KRjK6wogWNNbUNPtFsuXw06Yw5gAaR8qGqad1k5pLkZfdSaKQaHJhEPAXMJqpePfQZsGbT9HjVcbu9X32azuFOzx6TxREREDCrOCd4N604F8lbHYZd/haaGLJvYZ2p4ONHnB6mfjiYwnrC9wltUSd+qsPIy4XsTdAFz/FviVDfhJ1fm4c8canqVr47cYVhoso3kzKOiJEm+cbu3k7MO02Z/tINLnpBF9WT8Btz+KgqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McHeIKRy1R2fr8peG+3mXpJEiZIJbyaHPKQ4r95mack=;
 b=FLNrs2MVCWYuZ1Mre/qqx2Ygd2M7J2sFaVNcKMmyTOlDhKY9HYAO8oCTfP6GPxnQGgc61v+x90DDg3V1wFuAVrYcyokFg0V/Lxh6tKe5tIkylIvKHW5ANeXs4bHt1+ZEuzgs7kcbJNwAKvTauD3IOvUJJ/uRKWSk7+FM2XiiIWd2geNS+KBOKX+ug6zkjb2YzWwy3qaewx6GPMdGI4OHgEuXZpOcCk9Y13gh7O4C2SA3e/+yXj6G3ubr6cw86dxNuMSp/yvXa2pkCZ1veaTGU+oMODJZH7lqma6xjV64MVlsdG193vh34aF9GhEBUqoFgMbOyWaaZwws6HHbeK9b2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McHeIKRy1R2fr8peG+3mXpJEiZIJbyaHPKQ4r95mack=;
 b=K/EgfoQFPkF911ggIhVhLVcBAP8zppBUK+WSPZKh6PVGXFb5RoIbMtjCVfGedb1CfQ7aLDsg90QmuCGoZXXwbTjmUFgaSLwCsUqUE6UH+9xXkjCJGiRotD7gCwt6j1QnIDRxosfW5iLFMUwKsCsvVTvXs3Es3sbtyWKEoz99rnD9xt/YlGP30oRmV88cetouo0BlpLNtvoQlNZGZC0apb/YDM1tHCe7sJ/cxQ0iRhmqePsSbPy0XNgH8BYuP4V6REmJ/yNOuRNKii6prm+tjz9oUA9I/fHhS8+pUFvz60LasQOIM2UjZUk80SmhargGccwz52Ep52SArahVWXr/LEQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6094.apcprd06.prod.outlook.com (2603:1096:400:33c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Wed, 29 May
 2024 00:47:42 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 00:47:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>
Subject: RE: [PATCH v4 00/16] Add AST2700 support
Thread-Topic: [PATCH v4 00/16] Add AST2700 support
Thread-Index: AQHasAw9vuAr/T43PEue8t3w9svr7LGsamWAgAAAoaCAAASJAIAA85Hg
Date: Wed, 29 May 2024 00:47:42 +0000
Message-ID: <SI2PR06MB504156ACED014A5DDB091479FCF22@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <f2c66f47-af78-436b-968c-c267e84b9a18@kaod.org>
 <SI2PR06MB5041C99C448D21D6DB8D8053FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <104095bd-c492-49f2-887b-e97b4a030e5b@kaod.org>
In-Reply-To: <104095bd-c492-49f2-887b-e97b4a030e5b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6094:EE_
x-ms-office365-filtering-correlation-id: 282cae6e-f07b-4ef8-fa12-08dc7f78f296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|366007|7416005|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?VXRPSXRRQk5sbW9QczI1NW9KR2t1VGZGUWMyVkxWM0tlR3hYR0V4QUFnaS9B?=
 =?utf-8?B?VnkxaG1iWjJpdWdvcXMxVzMyQ1JCUWU2RkVneEdUaC9CSnlyWVVITXNsYmxw?=
 =?utf-8?B?ZDBzYnVSQ3pHMVZDd2ZIcUZBcGxkSHg3OS9ZeXlsZzVMWGloUlhEY3E4a2FU?=
 =?utf-8?B?SzdmTlpqNElXMGlQVGp1aHFJbHVpdlorUlZpRm83UUd1bGZEeHFNS2owNUVt?=
 =?utf-8?B?OFROSS9UL0c1R01JZ2xYcTBKemVPQ1lHQ0tOUXc4eXpmRUI3WDlEdlBPaUpR?=
 =?utf-8?B?Wm95V2YxVlNCeVA1UGxramFsamQ2cDJDTjBqdkZxVVg5VkkzVFJxdlovME1v?=
 =?utf-8?B?SmpML0tTcVFRMG9WWmFvTS9lYXNLUU9LTjQxaWtpa04xWHQ4TS9sK2EvSDAr?=
 =?utf-8?B?TGdkSjdlSHQ2UDNsZUlVZC8wc2hTWHFabXVZbm4veFRCSlJZTERHR3lhY3c1?=
 =?utf-8?B?dkdibnQ2QTVhQjRaUTdxTUpLRWdMclhLMHBBdWJ3OXN2SlJNbVNlVEVNM1g2?=
 =?utf-8?B?M0RBZWdJbURhVEZDRmtwc2dhZmxXN0xINzNTaHJIT0xVdk4vZ0UwSHBJdHFV?=
 =?utf-8?B?d1pQbWNqTmhyVUJ3RjRnMGx3a2JyYzhrOUxjRjNEbzNSNFgyOVhaMHJYRTlR?=
 =?utf-8?B?MWF0eTk1NGs3dVI0ME91Z3VUTGtPaFZGb2xqck1sUTU5TWl5OGliclZDcUt2?=
 =?utf-8?B?dUpJZmZKL1hPbnk4aElZdW5TTGhwajJPaU10SnBxODAxNzRmY3MyKzB6alI0?=
 =?utf-8?B?dCtVNXdFNWgzeVZPellBZDZFcG9jVy8ySTA4bHh0alpWSmt2a2RZa05QRWpa?=
 =?utf-8?B?VUZZVWhQNlhaOHVNTXdBem1IQzdraSs3NldqclRzWGR3YVVnTjBhb0tqNm9N?=
 =?utf-8?B?Ni93YWpMRWlSd2NhYXdnVUFDaDYxaElkbEQzaFVtdGtQc3hIdld3U2dHT3Ni?=
 =?utf-8?B?TGR3S1Z3U0pqa3lrU0VJZWZuNWdZUkpuZkQzcUpXRERBa1Bmc1YwckYzWEpC?=
 =?utf-8?B?aFcwZ3F2MXdTdWsyYlBjcDl0RG9hQkZ1bUZNK0FtUDVzbXRkYnpCa0xrSHJ2?=
 =?utf-8?B?cXBCS1NqaWxUWjJHQ1JwRjI4MWk1Z3FsNFB0VUtLZmpsMDNKcm4yYnk0bjdN?=
 =?utf-8?B?Z3dFU0Z5a0tzYkJRNStCbDdnaDZXaml1M2ZYWTZZQjRUNWZ0UnhhQ0pFVXlj?=
 =?utf-8?B?T3R4a2sxbWF2NUlIOUhNZTVnZWVOcnNadCtOWEdMdG15VVpKUnlvWnUzWHli?=
 =?utf-8?B?bDBhV0lJckxSZEYrMU1VTHNGODczOEV3WjZJMzFEQWRSWHh1MzdLOFE0OW1H?=
 =?utf-8?B?VHpTcUZuZktZNSsrWTlqVTRGMmxjUFl1ajRhdk5FU216Sy9iME5lZ1AzTjNl?=
 =?utf-8?B?M1ozbzA3ZWNSeXZUaFVYT09lYXk2VmovQUx5YjNhcWNMN2srSndNSWk3cWJj?=
 =?utf-8?B?T3pYVW9Dc3h0dDdYNUQzRmdJSGpFa1JzNDZYUGVNRzk4Y01xOCszRVU2WDRl?=
 =?utf-8?B?VFZ1TzlWbEorV0hsZ1Q3NitTSU1ybVAyc29FeXN3QWVFKytWQ0dCR1dvQmRx?=
 =?utf-8?B?QU42YmlNSjMvaVlaalg1aXZGemYyTEMzdkRQc1dGSXRwNEw1d1Zva2ZPcUlz?=
 =?utf-8?B?dDIrU3ZjcmFKOG5VbVVxQlI3ZGxXVGJsS2VMLzNuNXp5bzZuMkVUMnZybG1x?=
 =?utf-8?B?UmVDQ2RJcnZNZ3JpSG5UcE5YdGxOSXJNN1pLUldrQ05Qd1ByRENnL1dGNnkz?=
 =?utf-8?Q?a0UVBM0nZvWs5mWStc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(7416005)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OThISXVpVXd5UHovcWhVL0dlNGl1LzRzRE5DdkFzWEl5K2Zha2FCVXFFS3NL?=
 =?utf-8?B?a3RzTmJuRTFMdmhMRk1YRVZFeDMrM1VwSWpxQWpKZHBYMXQyOEZtaEpqV3Av?=
 =?utf-8?B?bjFkZk9rbm1TbFBHL3ZDMGhxbVo5aHNuSzVuRHNXdkRJOEJUaHVLRjFZSXZo?=
 =?utf-8?B?TWRJblh2Qzd2WnY2OTl1UWhXZnVsNlZOaTE4NkxvbG9KZXZ1NHl6WUVxT2k3?=
 =?utf-8?B?dHVEQWhaclFtZjJtdDlvQlZlY1VRUElxRmFqMUVPNUYrM1RGN3NIbmNsTlEx?=
 =?utf-8?B?dExqVjcray9HUXljNWRuN1VrTnJ2R1hlRTBpeHo0VFgzRG9KallxdUQ4QTlP?=
 =?utf-8?B?U05veWV1Wm9xR0NJd3gzTEJtRnF6TFlwNGJtSmZtUjJrODVkVHdBeVphT3c0?=
 =?utf-8?B?c1dVQnM2TVJjZGxjalcyU3RKY05JdXIwTlI1ditwUjFGemloam02WEVoY1dD?=
 =?utf-8?B?YUo3SlowTThOQmdZWFVvNDJSUFBxR1lRUnpHV1ZOblBZazRkcUJBUzlwNjlQ?=
 =?utf-8?B?RlNrS3pIbkI1TXdkQ1ppV3pIUXZPK2R4UGh1djcrMGxvanFTRFoyZXVzbHMw?=
 =?utf-8?B?c1NMenpyZmtXWEpPTlFOUmtnM1gzN2FpclVtMGZEZnM3RVJIMkZyWm5jTnlP?=
 =?utf-8?B?ZGtnWld2elJ6MzFCdlJhYllySE4zbmFxY1ZlSUhnOGN1cUFxM3FLUFkwUFlV?=
 =?utf-8?B?bmtKb1MxbUFaNVlIaU1YMlRMRGczaVhVZG1RWTVjWnB5Ylc0R3VGcGFpeFR2?=
 =?utf-8?B?SXU4Y3F2T0htUytJdCtMUXNPZ3RpaUc0c1djYmFnRU0wOGtSSkw1MnM3YVZO?=
 =?utf-8?B?WVlEUlhDc2RhVXlsWkRYVlhiY002bHRRT3FReG8zS1VEOUE4czJxb3JvTGZT?=
 =?utf-8?B?Sk43N3pNTEpjdFBjRXVQTmJ0eitwQ0Z6cjdJSFU3RHE5NDNIc0FRZUFKN2hL?=
 =?utf-8?B?TmxLQUdYOVM5QWpyRlBFWkRBbEJyKzdFclpJMFp6bDE0d2VtQ2ZBS2lQd0lr?=
 =?utf-8?B?M0ZsNWRRVDlUeVhIL3hkVzlaWEtnVTNIb01hS2ZUeGFvcGwvRW16bWhrRW4r?=
 =?utf-8?B?MGZvaXJsK0lTZzA1QVZHRGp2Z0R4YU9Za1RobVRnR3U0a29LQ0h0WUdJRG1V?=
 =?utf-8?B?VWt6RFpGV1dmYysrWFNzeDAyM2lWNmJwSXA2RWlXMUxEdC9oWXhnNWFhQXVs?=
 =?utf-8?B?dVkxaEdoVVloWWdnazVkNUZSdC9uOWwvYmlFWW5BY2s2YmpFam5MU3NnSE5F?=
 =?utf-8?B?YWNrNlY5R0Nmc0VkQ0lsaVdwZE1zSW85M0xLZkE0N0pXbmpVMHhUTWpPZlJH?=
 =?utf-8?B?TWgrRjh1eDEyRWtlYjJ1ZENBWHkvVm5NZWZ4bkRLWTJEQ2NuSFNDZXZPajlI?=
 =?utf-8?B?QXM5OG91Z3Fqc1NYZ05ZVllOVG5sY3NrdUYra3VxYXZ0cnFObmRINVVlUFZT?=
 =?utf-8?B?dmFCTjJDS3hVbUpxa3RzTGc5UFFDaUFCM29FVitOVE1GTkpqaEg5T1FKSHBK?=
 =?utf-8?B?SDh5Q2R5YmJIbjF0YVhhM2g3SXZDaVNVYi8vS2loeE1QQnI5OEppQlRyd2JD?=
 =?utf-8?B?UVdqWEp3U3hxaWZqZHJPQ1hBWmhxeHNhYjMwS0U1dlM4dkFMNnN5dk1FNDA5?=
 =?utf-8?B?blB4SWpHOUVlQlZZT0FKWkJQdVh1b09IYm5GYi93MytPS1UwNmlkY2xSR09s?=
 =?utf-8?B?UnUwenQ0UTVndHFNNkZ0bUJCT3BBNDBOMHdkTXc0YlpZdEYzSlpuNTh3UnVB?=
 =?utf-8?B?Mmt0Z3JvLzNpM3p3eUtXZzBGdy9IK0dvd1VBNTZjNmRjMWlEUFNlTmduUWJJ?=
 =?utf-8?B?b2hGNElMNlY3NnNoVC95T2Vaek1tUktpeEVuUnduZk8vR2k1eGZnRXgwNlNY?=
 =?utf-8?B?WDAraTE2KzFucXQ3WW1raFVFNWtFSngrOHllNVUvMG10NlYxaGFvOVM2ZEFB?=
 =?utf-8?B?OVFRT0cyajVzT2hNVXVFT0tHUDN2U0FLNmduWVMyMkg2a08yaHZHdUJTY0lV?=
 =?utf-8?B?YjlGRDcvS1drL045QThEeHhaZGFzbTFadktDRW4zTnhaNmkyUjRzZXZRSHg5?=
 =?utf-8?B?azF5Nmp0MEpYNWNZQjU5NGZJWGRkdWFqLzdYZW53RTVPUzBFRTNPc2dGZlJZ?=
 =?utf-8?Q?smQq7agRp1EiowLCG1lqyx1cT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282cae6e-f07b-4ef8-fa12-08dc7f78f296
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 00:47:42.2056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zwvbll+pnVe9HsP7mJPteBPuquD2D68Rp9gcyag2jBz58O1SX4a9M99CRXYNANgq9IH6D5EEl/DuZF+siEwILB5V/hg8YAehhFicWjxXwwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6094
Received-SPF: pass client-ip=2a01:111:f400:feab::71d;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IE9uIDUvMjgvMjQgMTI6MDIsIEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDZWRyaWMsDQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBH
b2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPj4gU2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDU6
NTYgUE0NCj4gPj4gVG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0
ZXIgTWF5ZGVsbA0KPiA+PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgQW5kcmV3IEplZmZl
cnkNCj4gPj4gPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9l
bEBqbXMuaWQuYXU+Ow0KPiA+PiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIz
Lm1lPjsgQ2xlYmVyIFJvc2ENCj4gPj4gPGNyb3NhQHJlZGhhdC5jb20+OyBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+Ow0KPiA+PiBXYWluZXIgZG9zIFNhbnRvcyBN
b3NjaGV0dGEgPHdhaW5lcnNtQHJlZGhhdC5jb20+OyBCZXJhbGRvIExlYWwNCj4gPj4gPGJsZWFs
QHJlZGhhdC5jb20+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+
Ow0KPiBvcGVuDQo+ID4+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25n
bnUub3JnPg0KPiA+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVu
bGluIFRhbmcNCj4gPj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIHY0IDAwLzE2XSBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4+DQo+ID4+IEph
bWluLA0KPiA+Pg0KPiA+PiBJIHRoaW5rIHlvdSBzaG91bGQgYWRkIHlvdXIgc2VsZiBhcyBhIFJl
dmlld2VyIHRvIHRoZSBBU1BFRUQgQk1Dcw0KPiA+PiBtYWNoaW5lIGluIHRoZSBNQUlOVEFJTkVS
UyBmaWxlcy4gV291bGQgeW91IGFncmVlID8NCj4gPj4NCj4gPiBBZ3JlZS4NCj4gPg0KPiA+IENv
dWxkIHlvdSBwbGVhc2UgYWRkIG1lLCBUcm95IGFuZCBTdGV2ZW4gaW4gdGhlIE1BSU5UQUlORVJT
IGZpbGVzPw0KPiA+IHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20NCj4gPiB0cm95X2xlZUBhc3Bl
ZWR0ZWNoLmNvbQ0KPiA+IGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbQ0KPiANCj4gWW91IHNob3Vs
ZCBzZW5kIGEgcGF0Y2ggdXBkYXRpbmcgdGhlIE1BSU5UQUlORVJTIGZpbGUgd2l0aCBuZXcgbmFt
ZXMgYW5kDQo+IHRob3NlIHByb21vdGVkIHNob3VsZCByZXBseSB0aGF0IHRoZXkgYWdyZWUsIG9y
IG5vdC4NCj4gDQo+IFNlZSBodHRwczovL3FlbXUucmVhZHRoZWRvY3MuaW8vZW4vdjkuMC4wL2Rl
dmVsL21haW50YWluZXJzLmh0bWwgZm9yIG1vcmUNCj4gaW5mbyBhbmQgdGhlIGdpdCBoaXN0b3J5
IG9mIE1BSU5UQUlORVJTIGFsc28uDQo+IA0KV2lsbCBzZW5kIGEgcGF0Y2ggdG8gdXBkYXRpbmcg
dGhlIE1BSU5UQUlORVJTIGZpbGUuDQpUaGFua3MtSmFtaW4NCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQoNCg==

