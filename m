Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E529F9B5F1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTbi-00008N-KW; Wed, 22 Apr 2026 05:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFTbc-00007q-FE; Wed, 22 Apr 2026 05:10:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFTbZ-0002oZ-MU; Wed, 22 Apr 2026 05:10:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiIs/nxyov0Lp18K3PyJg9To9elT6ziSWi3A7w338grBAjMJp9hwbaixaEx4svhHq05OabvsfnNZqsAvWcb+hoNkkefMYEr6FTbqgpMaSo7WQ9y3SNXZ1X5MRfJPPBkx1Ri8UuGm3olgYYNtE3LcJTH9bzMe1sYM17mvaPEaWhnnQzjkiCCEJvFT/bNlk9fGw43BxW+fiDgz9w2EkYXajzYMUeNkZFGansawY2uFYMmhL2xuFP3kIaNR2WKkEPsq5NEbuHqUPSqHJuTDsARBE3rfmhCix7iK4T6HSXV8j5SLTNi27lPUH5uphGox9yqYV2vnUUlVUL5g+JfdZDYWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg2H459451L7X+M+37D1XpjastGvVlXhft6ZAa6DlVQ=;
 b=FsH7vnZycLL6nK+MCuUKP21KV5fAm/NJTQmeUd3EMfdebxfpVesM6C/k5ozZVH0qNtnlj6JCbkDZ4qCTc7wDqGI1ZGY51V/RWY+oxrZeWq0ZVwcxC6tdYblCUSwlJS3ZnQQF9Kg1MCUTzH5+A5BSLoV4I1xU4MXO7QFPzzfE0R3zcn58/+hOY2jdrrxX9A+Rv8UUsMh+TPF7B5+yCvRl+8Z09SXuENz/aRHd06a2+VN0CjQ/g22YrUSBUgP1Q8NVZSxo3CPFFAv9VBjI1UfSCnwuXHu5ORin+CQGae33k2i65J3Rsi0oMRz+IvTiritY4PFwbme72E3P75WHDc9UTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg2H459451L7X+M+37D1XpjastGvVlXhft6ZAa6DlVQ=;
 b=Cfz/SvUssIB8jvFScyiYXYDZcmUXhZ23VVp6eZ0WuRr/zOM+ElZdFfk8g4dyWsJrnjrec5Rcfi5ml1E3LGrXLI3t1DGLApT5XANv6OQkXthheV+BD8ql4Vn7fZzEA7xkBAPRRX7U2bf47JyL50MsJDjt0Oxhrg60sWm/RFcDclDq/HNl1BWzD91maf8AYDeeb6kbXIGUm6lZiCVkoQS3AR9jOA2/g4aHVAGm2mV+D1XGIsvdGXr6/btee++1px20/t+g/ytm2nD3WCt+vzcWQCjVdYZQEOC4B3IzAX8PZSmx9SFrUSvHW1YktccprYyRyMXw4nKTOUXWUtg993CrFw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6212.apcprd06.prod.outlook.com (2603:1096:820:d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 09:10:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 09:10:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Xu
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: RE: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Topic: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Index: AQHczUNKKWmZ+R83iUmW5is8kUw4XrXi1YYAgACIrACABBnIQIAArEqAgAKwMhA=
Date: Wed, 22 Apr 2026 09:10:35 +0000
Message-ID: <TYPPR06MB82064F4FC063BAF8EF29C3FFFC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-7-jamin_lin@aspeedtech.com>
 <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org> <aeJNdLTRSZQiEiP_@x1.local>
 <TYPPR06MB8206C244CD249505E6B543F8FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <0c533df3-b06c-4fc6-a4b9-6e17206525a3@kaod.org>
In-Reply-To: <0c533df3-b06c-4fc6-a4b9-6e17206525a3@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6212:EE_
x-ms-office365-filtering-correlation-id: 4bfeb039-3956-4a00-71fd-08dea04f03c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 0+0bLkpExImpBtg5MmHN3ZDOQ+XB4eRifhbIdqUpJ5+yri7vC0JmbVVUse6Ir6hrsWhvxKCD3alcb9gtlYnDvPNntiw3J6JOFG9BmDGcyIL7mJi/72axE5VZ1lsNL+tV9kv1nOQLSTL+S/7Zilheac4RO6FQ9TtKNgQWhZSDwtm02qNyzKsr+uwn9gBxI8GbPIgDfQNsOF41ViUnhfq2g0g48/kLJ4q/BPeR0jP0IQ7HecK8+1V6AT9MzboGh7qTF6bJrVKYpYxqYjl9yqYIuFNI3RVDpo5QQb9IEvaD/hoc9oLfaUPFRGfmTcSEtU41sjhEfl2X5woEl4VPbwjllzEyKnbdOdvhadun8RsEX7eWS9+MZIzNwvdZ7iidA24J5sbaDPTPRIIp3lRi0XitAgXsPiBWwHWLZXr1ffPpYRPlgrg4A3xcYDUqx9DRTWKj0Mk/2OW8JWjYFU9lmVpk/6cuIyOBVZJ1G5Qt4X/DalsY/DYw+2t1h3spBYZbCidTp5VsjnxcJv9O/SDOSSOMUYHXXbBAJKBjXGhPVJ6cAoSsXqDXvqIb7q1twwui+A16pWbO/kFfQUrymhk58vx8VS4amfusmVoztv12mXrXANH9nrCIfgbXhEG85NGC9qAVziSdVDYeLqUkog0QEwMxYP1VMs/3svbcAnV7oXWeBrP0/FcbMgoooF9oRW0rvnld6Ah0xmANzYcTba0CZu6y0yNJLl4QfY4dGv7ru/Ll+a0X57bnVBVjrQIGlXQ2rZLIADT7cXGwk/OZfGGdt2JKaQDwrfvwauK2jWzdxalAQY0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmdkdXZIREhIQko1WHgybXRZdXN6Rm5yK2RWMVViQTR6YnNJSVRmVTRLVXFY?=
 =?utf-8?B?c2MvaVR1b0psT054MGs4RDBZL2tIYk51UFMvL0hkTSt2N2tOdjRIdWR2cGlJ?=
 =?utf-8?B?am9lYng1TXBjSnB2akN5QkZwcjJySHZKS3U0WGs3R3RWd0I5ZmZ0QTY1TjNZ?=
 =?utf-8?B?ZVpQNDliT0NTYlVkVjFzWnl4TXRuUGRuZEhLUGEwc0lkazFGYVIzVzg0UTZh?=
 =?utf-8?B?WUNydFNsS294ckR1c0xiNXpHWDVaOTBTRUxRaENjY2Q1MnNHN3hHbWFKNjNQ?=
 =?utf-8?B?YUZLUDJpNDBJRGJ0ZFFsQlZQQURZcDdjcUhURkNabTBOQkZQYnlYV0JSWEt4?=
 =?utf-8?B?UW5FU0I2V1JSNkRuelBhVjQyU3R0RGNMNXFhb3M3SVJ4aHdJaDJmTzBzUHF6?=
 =?utf-8?B?azBLK0pxN0E1aW5NRTJUQ2ZDUnlJZlhFQ3lXcnRDQXV4d3VId3lMdFRGQURY?=
 =?utf-8?B?akE3WDIrcERJZkFPcU05RjVFMU9TcEV1OEZ1SXV0alAyZ1Nhb1o3cnVDZWZD?=
 =?utf-8?B?L1VIcFhQeXBHVS9lN1QxUGlLUS91SEw2NXMyWnU1QXlHZUtYdVlxMUswbndk?=
 =?utf-8?B?bEZJcUpBZFdheWhhL1Z4Zlo0RVBDZTRZRDl3cTVXQmQvSHJSQnluOEtGemxa?=
 =?utf-8?B?dTJTL1Q0by8yN3ovdS9EZ0lmaXJYVFJaNlpLN0lEWDU3VVVza3BCenFsTlc3?=
 =?utf-8?B?YVBxWnRyNmpkNXJhVmE5MFhxcHB0endmcVZzNXVmT2hzQ1UrKy9iWGdwNkZI?=
 =?utf-8?B?TWgyTERycmk5REpqMGkyMzFLUkE5OW1OR2tTT1U3b0xzZW94THFBOW5JeHRU?=
 =?utf-8?B?SXJlU3BDcllrd2lTR0VOTHZneTJER21IeTNDV1EyQ1JYL1dLTXdNeHBMK2RI?=
 =?utf-8?B?aVBaZXBZM0p3bFFkaWp6NjFlZC9kVlphYnA5ZS9JWlRQSlAyNGxWVlBPVHlw?=
 =?utf-8?B?Q3M1OWM4ZllnUVRBaTNxTjFTREVPVzd2cEVIRDZTdnNyN20wTzNFYVY4QXhm?=
 =?utf-8?B?WVlyQ2l1dzkrSUZBY1loTENMTTJoUnppTWZwbGN2UFZValh3QkFZYy82SS80?=
 =?utf-8?B?Q1lkMnZXcWs4SXVMQ1RRSERvWTlvb0JtQkd1ZlZjajdzWmNpNFF1OGlqVHpX?=
 =?utf-8?B?dXJURzVMRU9UOHVmREdVY2g1QVlDY0RFbnJBclhaWkFrR0JyamkyOXFlT2o5?=
 =?utf-8?B?cXhxdGVHcFk3K1UrT0owclRTS250c1BiK1Y0ckVKT3VHMWZCZkZtTTI2cGZP?=
 =?utf-8?B?a09vd0lQemxRdm04TForNVJoeDBMVzlNU0kyWnBmSjVvcG9zUFM1Tm1aUGlw?=
 =?utf-8?B?RUtaeCtZcVdoOEpnQnU0dGtLdFpvNUJwelF5Wm4zT3VjM1pVeXF4WUZqS1FU?=
 =?utf-8?B?QWJYUmdmbXkvb3RnNmdlbVVDVkNTcDRiVURJUlRIam1vdWN2MHdnSGhTUnFW?=
 =?utf-8?B?VTdjQkt1WjNERXpzRXY1blhlWW1YSkVWa2dLWW9ndXg4V2NxRnlIMXc5QXJx?=
 =?utf-8?B?VllpMjZRKy9GOUs4bjVob3VGRVY5VTdZNmtYR0p2VFEzMnJpejk2V0RQckZh?=
 =?utf-8?B?MzYzY3VrcTYwd3Vma2dxNHRxbndPMkE2Zm5QdWpIcVBGQm0rT2ZLK0Vaalpp?=
 =?utf-8?B?dkJLc004bE04RXBaYTdVV1V2cnJTNExmZnh6eURhS2NhQjNrOFdQVEkxbzgv?=
 =?utf-8?B?ZitPZFFNMm5VSEV5L29GcGg0bEcxUFB5a01ZY2drNGxMQ000Ry9LS2J4VUt1?=
 =?utf-8?B?UW1KdXhpY1JSQjgzakJsakw0SHUvNzZZYTlIRXA4M21nRGs5R29IeWxxUWlN?=
 =?utf-8?B?cjZmWHk2Qzhob3h3UCtSbkhvcEZNMnBMOHZyR1ZEVkZJYTJIVE5DNTBxUjNn?=
 =?utf-8?B?L2FUaTUrbTRXbCs3MjU5RkZZQ2VVWFQ0WUU3TGl3UnJCY0p4dzNaYllYYVJk?=
 =?utf-8?B?ZVlldk5zRDRvTEFhci90TGx2emM3WUJmeFhJaEJDZEt4MFJrVUFGQlpVc2xD?=
 =?utf-8?B?WS9tN0RoaVZTVkErZXpjd2VDaFZWZ0JCU3BFTlNOQjl4QmgwY3BXWDVEZ0dl?=
 =?utf-8?B?cTF4WWxRYkgrNFVXeDZYSDVQQklVWUVqemdRSXpKZWFxNXRZQUdKTnZHS2Rp?=
 =?utf-8?B?L3NYTTFKREU1Y0h0OTNjM1A1VU94TzJMTEpVTUhXaTV2MVZTSjlDaWN5aWRv?=
 =?utf-8?B?TThIbWdzRnFDK0RYeEZmajRrOE5XODBIM2wrOG1raVliMkZlVDZIMnVVbU9R?=
 =?utf-8?B?bGFLM1F4amNFeFMrVnczWVZnUGxLekY0bWMzVDkzd3NXc3g2Z2V1aXBqQllk?=
 =?utf-8?B?MmRoV3VKM01jSkVZeDM1THgwQVI0WUtJY1loSURNNS96T0JFMVh2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EdkeNH3yRYPjIQzU3bMmO46pL4BfS+Q5KKRFzVJYXcTYZKynBzbd5Lu+59ng3TNQron3tI9tmURx5/S5TyxjBdN6RP8/Pz7JBkxc8PH1nHbU8tD0wldESfPWMFZ+6aFrU09Mlm+ODbn6YqN6d3kDTk2pkIRZUbTt2NMgyfHnL5EAB4rZ7+qNJ8ceWGcDHnAwercoecxOj5Khdy8+mG+07qQIzd5hcQdIZLhv/vcxzqIFndJInm47BfcPlow1AdwhZDIiXctV4oTnT8ASodH7jI4sd8fezQGikl7TMGdz8Z8izvbf0PAHq8h72xrsO9ytdEfRyIBdSFOAkbuU0L34wQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfeb039-3956-4a00-71fd-08dea04f03c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 09:10:35.9272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3hNqs3Hv0fCnuqmfsOPt2YiLHU42L1/y+YQSI1dHBpQcDtP30zenk0mqM1QDvCy28wT6IT8Z14YQUaoKxvgazZgGxZJnj3ZbdwY7N3rvtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6212
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDYvMTddIGh3L3VzYi9oY2Qt
ZWhjaTogQ2hhbmdlIGRlc2NyaXB0b3IgYWRkcmVzc2VzIHRvDQo+IDY0LWJpdA0KPiANCj4gT24g
NC8yMC8yNiAwNzo1NiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIFBldGVyLCBQaGlsaXBwZSwg
Q8OpZHJpYw0KPiA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDYvMTddIGh3L3VzYi9o
Y2QtZWhjaTogQ2hhbmdlIGRlc2NyaXB0b3INCj4gPj4gYWRkcmVzc2VzIHRvIDY0LWJpdA0KPiA+
Pg0KPiA+PiBPbiBGcmksIEFwciAxNywgMjAyNiBhdCAwOTowMTozNEFNICswMjAwLCBDw6lkcmlj
IExlIEdvYXRlciB3cm90ZToNCj4gPj4+ICsgUGV0ZXIsIEZhYmlhbm8sDQo+ID4+Pg0KPiA+Pj4g
T24gNC8xNi8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IENoYW5nZSBpbnRlcm5h
bCBFSENJIGRlc2NyaXB0b3IgYWRkcmVzc2VzIGZyb20gdWludDMyX3QgdG8gdWludDY0X3QuDQo+
ID4+Pj4NCj4gPj4+PiBUaGUgZm9sbG93aW5nIGZpZWxkcyBhcmUgdXBkYXRlZDoNCj4gPj4+PiAt
IEVIQ0lQYWNrZXQ6OnF0ZGFkZHINCj4gPj4+PiAtIEVIQ0lRdWV1ZTo6e3FoYWRkciwgcXRkYWRk
cn0NCj4gPj4+PiAtIEVIQ0lTdGF0ZTo6e2FfZmV0Y2hfYWRkciwgcF9mZXRjaF9hZGRyfQ0KPiA+
Pj4+DQo+ID4+Pj4gVXBkYXRlIGdldF9kd29yZHMoKSBhbmQgcHV0X2R3b3JkcygpIHRvIHRha2Ug
NjQtYml0IGFkZHJlc3NlcyBhbmQNCj4gPj4+PiBwcm9wYWdhdGUgdGhlIHR5cGUgY2hhbmdlIHRo
cm91Z2ggdGhlIGRlc2NyaXB0b3IgdHJhdmVyc2FsIHBhdGhzLg0KPiA+Pj4+DQo+ID4+Pj4gQWRq
dXN0IE5MUFRSX0dFVCgpIHRvIG9wZXJhdGUgb24gNjQtYml0IHZhbHVlczoNCj4gPj4+Pg0KPiA+
Pj4+ICAgICAgICNkZWZpbmUgTkxQVFJfR0VUKHgpICgoeCkgJiB+MHgxZlVMTCkNCj4gPj4+Pg0K
PiA+Pj4+IHNvIHRoYXQgbGluayBwb2ludGVyIG1hc2tpbmcgd29ya3MgY29ycmVjdGx5IHdoZW4g
ZGVzY3JpcHRvcg0KPiA+Pj4+IGFkZHJlc3NlcyBleGNlZWQgMzItYml0IHNwYWNlLiBUaGUgcHJl
dmlvdXMgbWFzayAoMHhmZmZmZmZlMCkNCj4gPj4+PiBpbXBsaWNpdGx5IHRydW5jYXRlZCBhZGRy
ZXNzZXMgdG8gMzIgYml0cy4NCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgcGF0Y2ggZG9lcyBub3QgY2hh
bmdlIHRoZSBvbi13aXJlIGRlc2NyaXB0b3IgbGF5b3V0IHlldC4NCj4gPj4+PiBJdCBvbmx5IHJl
bW92ZXMgdGhlIGludGVybmFsIDMyLWJpdCBhZGRyZXNzIGxpbWl0IGFuZCBwcmVwYXJlcyBmb3IN
Cj4gPj4+PiBsYXRlciBwYXRjaGVzIHRoYXQgd2lsbCBhZGQgZnVsbCA2NC1iaXQgUUgvcVREL2lU
RC9zaVREIHN1cHBvcnQuDQo+ID4+Pj4NCj4gPj4+PiBVcGRhdGUgdGhlIEVIQ0kgdHJhY2UtZXZl
bnRzIHByb3RvdHlwZXMgZm9yIFFILCBxVEQsIGlURCwgYW5kIHNpVEQNCj4gPj4+PiB0byB1c2Ug
dWludDY0X3QgZm9yIHRoZSBhZGRyZXNzIGFyZ3VtZW50IGFuZCBwcmludCBpdCB3aXRoIFBSSXg2
NC4NCj4gPj4+PiBUaGlzIGVuc3VyZXMgZnVsbCA2NC1iaXQgYWRkcmVzc2VzIGFyZSBzaG93biBp
biB0cmFjZSBvdXRwdXQgYW5kDQo+ID4+Pj4gaW1wcm92ZXMgZGVidWdnaW5nIG9mIHF1ZXVlIGhl
YWRzIGFuZCB0cmFuc2ZlciBkZXNjcmlwdG9ycy4NCj4gPj4+Pg0KPiA+Pj4+IE1pZ3JhdGlvbiBj
b21wYXRpYmlsaXR5Og0KPiA+Pj4+DQo+ID4+Pj4gVGhlIGZldGNoIGFkZHJlc3MgZmllbGRzIGlu
IEVIQ0lTdGF0ZSBhcmUgZXh0ZW5kZWQgZnJvbSAzMi1iaXQgdG8NCj4gPj4+PiA2NC1iaXQsIHJl
cXVpcmluZyBhIFZNU3RhdGUgdmVyc2lvbiBidW1wICh2MiAtPiB2MykuDQo+ID4+Pj4NCj4gPj4+
PiBCYWNrd2FyZCBjb21wYXRpYmlsaXR5IGlzIHByZXNlcnZlZCBieSBrZWVwaW5nIHRoZSBsZWdh
Y3kgMzItYml0DQo+ID4+Pj4gZmllbGRzIChhX2ZldGNoX2FkZHJfcHJlX3YzLCBwX2ZldGNoX2Fk
ZHJfcHJlX3YzKSBmb3IgcHJlLXYzDQo+ID4+Pj4gbWlncmF0aW9uIHN0cmVhbXMgdmlhIFZNU1RB
VEVfVUlOVDMyX1RFU1QoKSwgYW5kIGludHJvZHVjaW5nIG5ldw0KPiA+Pj4+IDY0LWJpdCBmaWVs
ZHMgZm9yIHYzKy4NCj4gPj4+Pg0KPiA+Pj4+IEluIHBvc3RfbG9hZCwgcHJlLXYzIHN0YXRlIGlz
IHByb21vdGVkIHRvIHRoZSA2NC1iaXQgZmllbGRzLg0KPiA+Pj4NCj4gPj4+IFNpbmNlIGVoY2kg
aXMgc3VwcG9ydGVkIGJ5IGRvd25zdHJlYW0sIEknZCBwcmVmZXIgdGhhdCB0aGUgbWlncmF0aW9u
DQo+ID4+PiBtYWludGFpbmVycyBhbHNvIHZlcmlmeSB0aGUgaW1wbGVtZW50YXRpb24uDQo+ID4+
DQo+ID4+IFRoYW5rcywgSSdsbCBvbmx5IGxvb2sgYXQgdGhlIG1pZ3JhdGlvbiBiaXRzLg0KPiA+
Pg0KPiA+PiBbLi4uXQ0KPiA+Pg0KPiA+Pj4+IEBAIC0yNDQxLDYgKzI0NDUsMTEgQEAgc3RhdGlj
IGludCB1c2JfZWhjaV9wb3N0X2xvYWQodm9pZCAqb3BhcXVlLA0KPiA+Pj4+IGludA0KPiA+PiB2
ZXJzaW9uX2lkKQ0KPiA+Pj4+ICAgICAgICAgICAgfQ0KPiA+Pj4+ICAgICAgICB9DQo+ID4+Pj4g
KyAgICBpZiAodmVyc2lvbl9pZCA8IDMpIHsNCj4gPj4+PiArICAgICAgICBzLT5hX2ZldGNoX2Fk
ZHIgPSBzLT5hX2ZldGNoX2FkZHJfcHJlX3YzOw0KPiA+Pj4+ICsgICAgICAgIHMtPnBfZmV0Y2hf
YWRkciA9IHMtPnBfZmV0Y2hfYWRkcl9wcmVfdjM7DQo+ID4+Pj4gKyAgICB9DQo+ID4+Pj4gKw0K
PiA+Pj4+ICAgICAgICByZXR1cm4gMDsNCj4gPj4+PiAgICB9DQo+ID4+Pj4gQEAgLTI0NzAsOSAr
MjQ3OSwxNCBAQCBzdGF0aWMgdm9pZCB1c2JfZWhjaV92bV9zdGF0ZV9jaGFuZ2Uodm9pZA0KPiA+
PiAqb3BhcXVlLCBib29sIHJ1bm5pbmcsIFJ1blN0YXRlIHN0YXRlKQ0KPiA+Pj4+ICAgICAgICB9
DQo+ID4+Pj4gICAgfQ0KPiA+Pj4+ICtzdGF0aWMgYm9vbCBlaGNpX2NvcmVfaXNfYmVmb3JlX3Zl
cnNpb25fMyh2b2lkICpvcGFxdWUsIGludA0KPiA+Pj4+ICt2ZXJzaW9uX2lkKSB7DQo+ID4+Pj4g
KyAgICByZXR1cm4gdmVyc2lvbl9pZCA8IDM7DQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4g
ICAgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfZWhjaSA9IHsNCj4gPj4+PiAgICAg
ICAgLm5hbWUgICAgICAgID0gImVoY2ktY29yZSIsDQo+ID4+Pj4gLSAgICAudmVyc2lvbl9pZCAg
PSAyLA0KPiA+Pj4+ICsgICAgLnZlcnNpb25faWQgID0gMywNCj4gPj4+PiAgICAgICAgLm1pbmlt
dW1fdmVyc2lvbl9pZCAgPSAxLA0KPiA+Pj4+ICAgICAgICAucHJlX3NhdmUgICAgPSB1c2JfZWhj
aV9wcmVfc2F2ZSwNCj4gPj4+PiAgICAgICAgLnBvc3RfbG9hZCAgID0gdXNiX2VoY2lfcG9zdF9s
b2FkLA0KPiA+Pj4+IEBAIC0yNTAxLDggKzI1MTUsMTIgQEAgY29uc3QgVk1TdGF0ZURlc2NyaXB0
aW9uIHZtc3RhdGVfZWhjaSA9IHsNCj4gPj4+PiAgICAgICAgICAgIC8qIHNjaGVkdWxlIHN0YXRl
ICovDQo+ID4+Pj4gICAgICAgICAgICBWTVNUQVRFX1VJTlQzMihhc3RhdGUsIEVIQ0lTdGF0ZSks
DQo+ID4+Pj4gICAgICAgICAgICBWTVNUQVRFX1VJTlQzMihwc3RhdGUsIEVIQ0lTdGF0ZSksDQo+
ID4+Pj4gLSAgICAgICAgVk1TVEFURV9VSU5UMzIoYV9mZXRjaF9hZGRyLCBFSENJU3RhdGUpLA0K
PiA+Pj4+IC0gICAgICAgIFZNU1RBVEVfVUlOVDMyKHBfZmV0Y2hfYWRkciwgRUhDSVN0YXRlKSwN
Cj4gPj4+PiArICAgICAgICBWTVNUQVRFX1VJTlQzMl9URVNUKGFfZmV0Y2hfYWRkcl9wcmVfdjMs
IEVIQ0lTdGF0ZSwNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVoY2lfY29y
ZV9pc19iZWZvcmVfdmVyc2lvbl8zKSwNCj4gPj4+PiArICAgICAgICBWTVNUQVRFX1VJTlQzMl9U
RVNUKHBfZmV0Y2hfYWRkcl9wcmVfdjMsIEVIQ0lTdGF0ZSwNCj4gPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVoY2lfY29yZV9pc19iZWZvcmVfdmVyc2lvbl8zKSwNCj4gPj4+PiAr
ICAgICAgICBWTVNUQVRFX1VJTlQ2NF9WKGFfZmV0Y2hfYWRkciwgRUhDSVN0YXRlLCAzKSwNCj4g
Pj4+PiArICAgICAgICBWTVNUQVRFX1VJTlQ2NF9WKHBfZmV0Y2hfYWRkciwgRUhDSVN0YXRlLCAz
KSwNCj4gPj4NCj4gPj4gVEw7RFI6IEkgZmVlbCBsaWtlIHdlIHN0aWxsIG5lZWQgbWFjaGluZSB0
eXBlIGNvbXBhdCBwcm9wZXJ0aWVzLg0KPiA+Pg0KPiA+DQo+ID4gSSBkb24ndCB1bmRlcnN0YW5k
IHRoaXM6IENvdWxkIHlvdSBwbGVhc2UgZGVzY3JpYmUgaXQgaW4gbW9yZSBkZXRhaWw/DQo+ID4N
Cj4gPj4gRGV0YWlsczoNCj4gPj4NCj4gPj4gV2hlbiBhIHYyIHN0cmVhbSBhcnJpdmVzLCB0d28g
X1RFU1QoKXMgd2lsbCBkbyB0aGUgbG9hZGluZywgdGhlbg0KPiA+PiBwb3N0X2xvYWQoKSBleHRl
bmQgaXQgdG8gNjRiaXRzLCBsb29rcyBmaW5lLg0KPiA+Pg0KPiA+PiBXaGVuIGEgdjMgc3RyZWFt
IGFycml2ZXMsIHR3byBfVEVTVCgpcyBnb3Qgc2tpcHBlZCB0aGVuIGxhdHRlciB0d28gdGFrZQ0K
PiBlZmZlY3QuDQo+ID4+IHBvc3RfbG9hZCgpIHNraXBzLiAgTG9va3MgZmluZS4NCj4gPj4NCj4g
Pj4gV2hlbiBtaWdyYXRpbmcgdG8gYW5vdGhlciBRRU1VLCBkdWUgdG8gdGhlIGZhY3Qgc2F2aW5n
IHZtc3RhdGVzDQo+ID4+IGFsd2F5cyB0YWtlIHZtc2QncyB2ZXJzaW9uIGRlY2xhcmVkICgzKSwg
SSBkb24ndCBzZWUgaG93IGl0IGNhbg0KPiA+PiBtaWdyYXRlIGJhY2sgdG8gYSB2MiBzdHJlYW07
IGl0IGRpZG4ndCBrbm93IGFib3V0IHYzLg0KPiA+Pg0KPiA+PiBKaWFtaW4sIGhhdmUgeW91IHRl
c3RlZCBtaWdyYXRpbmcgZnJvbSBhIG5ldyBRRU1VIGJpbmFyeSBiYWNrIHRvDQo+ID4+IGFub3Ro
ZXIgb2xkIG9uZT8gIEZvciB1cHN0cmVhbSBhbmQgc2VyaW91cyBkZXZpY2VzLCB3ZSBuZWVkIHRv
DQo+ID4+IGd1YXJhbnRlZSBiaS1kaXJlY3Rpb25hbCBtaWdyYXRpb25zLCBiYWNrIGFuZCBmb3J0
aC4NCj4gPj4NCj4gPg0KPiA+IFNvcnJ5LCBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBkZXNp
Z24gb2YgUUVNVSBtaWdyYXRpb24sIGFuZCBJIGRvbid0IGtub3cNCj4gaG93IHRvIHRlc3QgaXQu
DQo+ID4gSSBhZGRlZCB0aGVzZSBob29rIGZ1bmN0aW9ucyBiYXNlZCBvbiBQaGlsaXBwZSdzIHN1
Z2dlc3Rpb24gYW5kIHJldmlldy4NCj4gPiBDb3VsZCB5b3UgdGVsbCBtZSBob3cgdG8gdGVzdCBt
aWdyYXRpb24gdG8gZW5zdXJlIGJvdGggdmVyc2lvbiAzIGFuZCB2ZXJzaW9uDQo+IDIgYXJlIHdv
cmthYmxlPw0KPiANCj4gDQo+IE1pZ3JhdGluZyBhIHJ1bm5pbmcgZ3Vlc3QgYmFjayBhbmQgZm9y
dGggYmV0d2VlbiBRRU1VIFsxXSBhbmQgWzJdIHNob3VsZCBiZQ0KPiBwb3NzaWJsZSA6DQo+IA0K
PiBbMV0gcGF0aC90by9xZW11LTEwLjIvaW5zdGFsbC9iaW4vcWVtdS1zeXN0ZW0teDg2XzY0IC1N
IHBjLXEzNS0xMC4yIFwNCj4gICAgICAuLi4gXA0KPiAgICAgIC1kZXZpY2UgdXNiLWVoY2kgXA0K
PiAgICAgIC1kZXZpY2UgdXNiLWtiZA0KPiANCj4gWzJdIHBhdGgvdG8vbXlxZW11LXdpdGgtcGF0
Y2hlcy9pbnN0YWxsL2Jpbi9xZW11LXN5c3RlbS14ODZfNjQgLU0NCj4gcGMtcTM1LTEwLjIgXA0K
PiAgICAgIC4uLiBcDQo+ICAgICAgLWRldmljZSB1c2ItZWhjaSBcDQo+ICAgICAgLWRldmljZSB1
c2Ita2JkDQo+IA0KPiBUaGlzIGlzIHJlcXVpcmVkIHRvIGd1YXJhbnRlZSBmb3J3YXJkIGFuZCBi
YWNrd2FyZCBjb21wYXRpYmlsaXR5IG9mIFFFTVUNCj4gcGMtcTM1LTEwLjIgbWFjaGluZSBpbnN0
YW5jZXMuDQo+IA0KPiANCg0KVGhhbmtzIGZvciB0aGUgbWlncmF0aW9uIHRlc3Qgc3RlcHMuDQpJ
IGhhdmUgdGVzdGVkIGJvdGggZm9yd2FyZCBhbmQgYmFja3dhcmQgbWlncmF0aW9uIGZvciBFSENJ
IGFuZCBvYnNlcnZlZCBmYWlsdXJlcyBpbiBib3RoIGRpcmVjdGlvbnMuIA0KSSB3aWxsIHJldmlz
ZSBteSBjaGFuZ2VzIGluIGEgZm9sbG93LXVwIHBhdGNoIHRvIGFkZHJlc3MgdGhlc2UgaXNzdWVz
IGFuZCBlbnN1cmUgdGhhdCB0aGUgbWlncmF0aW9uIHRlc3RzIHBhc3MuDQoNClRoYW5rcywNCkph
bWluDQogDQo+IEMuDQo=

