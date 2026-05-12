Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80975CD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 01:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMc5N-0006C6-Pr; Mon, 11 May 2026 21:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMc5E-0006Bc-W3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 21:38:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMc5C-0003qg-BK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 21:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARZT+bpSGEmvWFiJ9JCeC0bXEUWXIVO/VIXyBRoWxqr8QsOkZ4fjYqOWoXzXKG7pIue5N0e+eCXVm+zC9IV8dN4U3mThbeELQEhu94nY9yRw8k/7Cn4mq57rtS/onnZc75+YbCKjTRHEU/s0pSn57yXoMMJaemu/VLP9zXZdR1jz/jsJ1aab9j6jOCUQD5WIsQ/MdHRCowwwv4W1f3uathNoOkjnRwSlMmzltTD5gO4ZpnhTTli1I8aZ1HITLxL+irPjGrwCLzcn1wH9QgtsgKDPnj4Ii+qX8TtVVp7sdpA6o0dU7cs+WhbDWPSlVoI3mChC7cgIdsTPlG0ODkSmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq7FxqECWpZSMoUBjKtw5WqE6fxsDx/BrFHyhmXE5Kw=;
 b=npygEM1U7txT+A9hI/6YmD18lvikfHgNGjos9dkfHhuYDCl67hHTm4yDTX+P52N41qV3KjyR6/xYS/aiE7knUcYhg833ovG77yz/eZH4/cSB4v8KMsB6lq4qa0oMgYvTbbx69749qwi3eHGoT+5OIzqYGg7bOB0d/3i4tUkwW3kio1slUlow0mQ84StKZ9MiebRwKLE//1RxxY1fvsM3mq6e82NpQ7aPRHnzaV6jSg9CH6u6m8Bx6V/lZ6drvkupwxvrCCEOl+TrBUKQIVwxj+2vG7GIeJQR+QYkva93nALzn4BEXz9hmFNDwm8X32ETjwBjUqoXvmt8Wutfh3bhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq7FxqECWpZSMoUBjKtw5WqE6fxsDx/BrFHyhmXE5Kw=;
 b=L+SDK+zu6xRRRkWNfssmzLvZaa6qFLaryidlqaS9EdcxBXRkehrv5VCj7rBwNWmvOd6R0wrl0lCMHwD/jHiheWPd+S4ACHyr9SX2MWGfbEzJYnDHdsTF/iG94ZIPqO98mfP9/DJ8m8eW8BsUaL3shy9zH2WyjgXSrW1rG0FJB0mi0MC5JHwbmVxXucwnWJbKmiNeSV3G7Q2g1iXKioJJ8H3nSSDUkWcIjzJYzNU3ZrKs+Y4Lcj6sL7CJuOo1aGT/CmejSGWTF8vj4LlgSI9Id45JALYG0+rAHA48bjTWjWUDSd7+nqOuVUaGDl/OBE+l2EAzgu7hknVSm/6ixwO5pQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5605.apcprd06.prod.outlook.com (2603:1096:101:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 01:38:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 01:38:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Ashish Anand <ashish.a6@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "komlodi@google.com" <komlodi@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "saurabh@samsung.com"
 <saurabh@samsung.com>, "vishwa.mg@samsung.com" <vishwa.mg@samsung.com>,
 "y.kaushal@samsung.com" <y.kaushal@samsung.com>, "ashish.anand202@gmail.com"
 <ashish.anand202@gmail.com>
Subject: RE: [PATCH v2] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly
 during ENTDAA
Thread-Topic: [PATCH v2] hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID
 assembly during ENTDAA
Thread-Index: AQHc3JVFhNL1P1VkBEqJ+e+Qz/zKbrYJpnAg
Date: Tue, 12 May 2026 01:38:43 +0000
Message-ID: <TYPPR06MB8206534A09BB46564DDAA012FC392@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <CGME20260505134412epcas5p1ccd2bd43c50ec651636847fa8c516072@epcas5p1.samsung.com>
 <20260505134002.509037-1-ashish.a6@samsung.com>
In-Reply-To: <20260505134002.509037-1-ashish.a6@samsung.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5605:EE_
x-ms-office365-filtering-correlation-id: da944233-d841-477b-5c45-08deafc733b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: fy+8NlqCIJ6r+dOvvsx7bApOrbWM2T5b0j3jkTorkrh3flD84GOP7qrqRIPAbFJddkRE5HOVT2UbL0KolmQ+wH+ucUg29b6zDfzHeMYYGb6pnQ54XKG6fIyUhRrrWpyvLxk89z/Zj8JTcJaigYAbr1V0Hm2xnB8NHemuKXIUpwu16GsuWgGSDSCnD9Ee5lSosDW74wzwz/6iQ1rVGEC82oQZIrQGqK4gUYc1IXMInFiX74xumXQpWCT7ENmvFqRDJBA3a5eRRWSBPrx3WZqNwFV3dn1xAOAL7sPnYRfXn6Byievskp/1a5nzPU7omyb7euO/7BpQdgiRl7O8InxFcOz10DZhoO1Z/cCeGKXpd9e/MARYyFQY/bza1nQjfXN9YySjC/jVVXw3pefYcSDc0iLMXFEqgHBa1DCVGOBlvvfdQ0ZbiI/iP47+P9WVeItBld5k00Sx3FdX7CSL6AYCvarv0qzIom3869ufjFBEXwR7r9l0pwiIOA2WLTw2jgnawFxpMo3WhfYbdKPf1GLIXEsb3xOK4YTiI3TOQJGnR0vIakvgGEL+rrTXNZGnpqOsay8BbjqEt6GlSrAOVnrza3xqumLWH4GvxkMygxybp/vSis7MB2DNGXuMTIQp2BH6u+gfr+ojSmOMYVJ4QCvej8rqnfEpvkmQl3DGgnCPKLR6LmlvsSNIH3Ik4PsZSB7exD/htftKl/IuPtpeXp7fSrWbs036lspDtEaPEozBq0ecm2rbfIkEoh+zKaATwMsu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9Wd2lvZDEwekhvbXl0V0ZBTDFUWnlhcTZZTDU0UVR1R2tmOUJFU0txalBa?=
 =?utf-8?B?TnBUM3ozTVV5MVM3QmhSQVhFNHBja1kxV1ZLNHRhK21mL1QrbWpxMzdpTGFT?=
 =?utf-8?B?YW9qWlhMaEdVZFFGZTgzdlRoZzUrVG1ETkZMcHdlZVpjc1hjTUNlVFJBdm1r?=
 =?utf-8?B?cjlSNDdyZEFFQTVUWmhaQ3Z2M05ibWpnUEtsdVA0djZJRG5UYXYxcXZ2Mlli?=
 =?utf-8?B?NkhLaDhOMVJIRDlFQnNEaUx6aDZLbzJwZ3JaTGMrYkF2TUJOUnRIQzFyL2U5?=
 =?utf-8?B?SHJReGpyYXRZTHIzTTNpRE5qbTBCQ0l6b1YxQlk3ZTQrWU1QYnhxRGdHZ3ox?=
 =?utf-8?B?L2xqT2JSVmVyTE9VbVJ5eEFoZndQNDVodXJib3g2TGZ1QzBwWU5UZ3NpUUFr?=
 =?utf-8?B?cmNHNUp5U1ZwZWJKMHZYZmh1ZVdzK203dUFMV3dRRHc5UEFlcnNkaWFzMERC?=
 =?utf-8?B?bjBoV3BGOHk0Yk4vdFJGblM3S3pFVjlnQU5yWUhBM013bmxBZ3lHQUpEWHRu?=
 =?utf-8?B?dVRIYnM1bWV6SEdSc0p2NnQxNjNWTmZ2emZWR1ZhaHVkVWRpNi90eldJVFBB?=
 =?utf-8?B?bHllZVhKTW9vUFo2dEdidEVqTm40c2wwSnkwSTFYeTdDZStUMGFCeVgxRmNV?=
 =?utf-8?B?K2FnNk9NNXI3QVBSc3lyYjdYWmFnYWc3V1dqYTJQVXAzWjkyaUx2WXpickNa?=
 =?utf-8?B?OE9wUXNXd2NJT3U2Tk52UTQ4ajBZdDlEY29zZVB5Smt6bkVjQ1BEVHNlUGE1?=
 =?utf-8?B?UFRZWjNFQUFTMEMrOWVrNWVwc3lCVGV1c09GNk5vNW5zcmlNQW5wUkpDeEZK?=
 =?utf-8?B?c0RpT216UmhzNVhLVzlnejBVdkdqcGNRQlRqVlA4TWpVZ3g4U1hLcnhqeERD?=
 =?utf-8?B?Vnd6S1IxdHpUZzhKd0dDQ0c0ZHMwK1pwaFJ6NHVyOGxRaERFYTN2MEZDbFh2?=
 =?utf-8?B?NXBpMTc3SnNEOWZmM24vMDFaMEJLem8yd3loZnJpdVdMbzFYdTJkdGxtZGdL?=
 =?utf-8?B?TXl5eDhMZkNEWlovcVZvbHdYdmFYTE5ORURCVjV1SHZhVkVWQjVtTXpZaXkv?=
 =?utf-8?B?RzNva3ROd2M2OC9TcVRHalpwcmMyWjVVQktZZmVZWmhVS0dleVQrRm44K2po?=
 =?utf-8?B?Zk1iMXlhclpjbHhjOEVCWksyL1dMUFRYemEwcHNheGRDRXRORlVnRSswN2h2?=
 =?utf-8?B?bWF3emNoMS9KZTB5K0JUOVJIUWlaZTM4cTdTZTVObVBqQ3ltamcwZzNjYjkw?=
 =?utf-8?B?am1DUkNHaUlyWEZ2VFFCbGl3VlUyZlV3TGI1cHpDeTNFVmVYUnNCbmZzbm5j?=
 =?utf-8?B?dG9qaFF0QmlOOGpwUnpPNW9jVFV0ZVNqNnBldG92a1hTcWdtTFFyTnNPWGhV?=
 =?utf-8?B?Z0ovanpvbDArT20zekRONUZKOXhpeGwrNCs3SHY0U09ZWEVWekgzRGQwdU9K?=
 =?utf-8?B?Wmw3NzgxUXFWOW9xMmE1aXVTNTBSY0FKVXdNK2o2SkYyM29uREF2WmNxZEZm?=
 =?utf-8?B?UlprZjlvcUhYZDdXVHh5R3RsdkFhVU41d3IybUdRYU5PT3doQ09PWWRybHFT?=
 =?utf-8?B?WTh0Qk8xaktwK09tTUp4RS9mZGpHZFN1MEJ2dE9mVytWbGVjSUZUNUJHVmJZ?=
 =?utf-8?B?NXAzWGFyTmdBNU85MzlsYjRiTC9jL3pLYmZBa2Y3R3E2MlNrTi9wNDJOUEww?=
 =?utf-8?B?akpZcURHT2RNNnZLMWxEQXFseExpb3U1MDJEUWY3RkhHNmd5Y2pVSTFlakRt?=
 =?utf-8?B?c2lFSmc4OUc3UVhwcDAzVEJXTVpzQVZJYVZITEd1NXpqVDJqRXFKaUUyaXdj?=
 =?utf-8?B?em1kYUQ4Y2dpeGRyVDV1aVUyY2JYSk5OZXNJbWZoU0J3dmNOaCszTEp3ckJr?=
 =?utf-8?B?Q09ITXY1V2FJemdLUHdmQ1RDbUhIcjI0MXVvaEF6N21DVmF1Rmc3emJtWWYr?=
 =?utf-8?B?WXVXTFAzdC9vSDRIU2dFTzJSaFdmWFhFQjkzdzZiajJHNzJJOUhPVzdld3pl?=
 =?utf-8?B?UjRYZGtuS2dvZ3kzV2Q5Z3dCV0w1K1pUL3A4MVlQeGtKVm9mUW02SU1WdG5C?=
 =?utf-8?B?a0hNUlF3S3ZWcTBvSVhmS2w2bWJhNzlzQXZqUWdYeHhDaTFPclFydWdOKzFU?=
 =?utf-8?B?SklpQUxHSWorM2RyZGU4TGhqZnBLVlpSNDBGQnhJdWk3Nmo1Q1FJdURnYXJp?=
 =?utf-8?B?aDZTbHp5bk5Bdk4yWk8xL2hKNU5JOENrc0F2aGE1TnJsVmdoOW03c1MxSEI1?=
 =?utf-8?B?T2JKY0pGVTV1RHhEUTRDYXVnR1FVZ2tnUCt4Tk5rSms3T2ZuMGsxZkw4UlVR?=
 =?utf-8?B?ZENybElmZHVqaFg1NExPTzEzd0RmUUVFandTcWxxL1AwazdwcllWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qhLKddHWD/eeSD1NomeOm91m1LxckfoNxdwv9icxA3aOCf87tMQ5Ela+Cvdzi3kfaguJy/b4/coYjpxOnEpVe6eIEHneVvq5Rd0KxOScc/dcOIQaYecTo95r93mJ7RnYKAf3RI6FOZhjAdTjuDRyYDF9N0MN8NljFAl6/P321QPj8CVctd/+Qm8VvYuHcIbb7ISqXGRVtba1cS/qSxBmc4elV50SpU4PbtMlxWBmgV0VQlqvldlJZ3FpayjpA4m7elz1LSBRikvi/FrIlhy7u9ig2Sjj9EA0Vc/9hRM5XhPTR74dW5rWAHuLXeBtFBNFyU3fpXmvQ7tPqFIHms0p3A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da944233-d841-477b-5c45-08deafc733b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:38:43.4050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mafERkp8S6kTdoPFcoKw/xfpD/x37H/8rzEBqX1aV+rq/uBnVotTP9yBNT8SwApzSH8gMRJVvQq12uC63f42rtCJXgeYhnkKi8UEoldbrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5605
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQXNoaXNoDQoNCj4gU3ViamVjdDogW1BBVENIIHYyXSBody9pM2MvZHctaTNjOiBGaXggQkNS
L0RDUiBleHRyYWN0aW9uIGFuZCBQSUQgYXNzZW1ibHkNCj4gZHVyaW5nIEVOVERBQQ0KPiANCj4g
VGhlIHRhcmdldF9pbmZvIHVuaW9uIGluIGR3X2kzY19hZGRyX2Fzc2lnbl9jbWQoKSBkZWNsYXJl
cyBwaWQsIGJjciwgYW5kIGRjcg0KPiBhcyBzZXBhcmF0ZSB1bmlvbiBtZW1iZXJzLCBjYXVzaW5n
IHRoZW0gdG8gYWxsIGFsaWFzIGJbMF0gcmF0aGVyIHRoYW4gdGhlaXINCj4gY29ycmVjdCBwb3Np
dGlvbnMgaW4gdGhlIEVOVERBQSByZXNwb25zZSBidWZmZXIuDQo+IFRoaXMgcmVzdWx0cyBpbiBk
d19pM2NfdXBkYXRlX2NoYXJfdGFibGUoKSBiZWluZyBjYWxsZWQgd2l0aCBCQ1IgYW5kIERDUg0K
PiBib3RoIHJlYWQgZnJvbSBiWzBdIGluc3RlYWQgb2YgYls2XSBhbmQgYls3XSByZXNwZWN0aXZl
bHksIGNvcnJ1cHRpbmcgdGhlIGRldmljZQ0KPiBjaGFyYWN0ZXJpc3RpY3MgdGFibGUgb24gZXZl
cnkgRU5UREFBIG9wZXJhdGlvbi4NCj4gRml4IGJ5IHJlcGxhY2luZyB0aGUgYnJva2VuIG1lbWJl
cnMgd2l0aCB1aW50NjRfdCBkIGFuZCBleHRyYWN0aW5nIGZpZWxkcyBwZXINCj4gdGhlIEkzQyBz
cGVjIEVOVERBQSB3aXJlIGZvcm1hdC4NCj4gDQo+IEFkZGl0aW9uYWxseSwgZHdfaTNjX3VwZGF0
ZV9jaGFyX3RhYmxlKCkgaW5jb3JyZWN0bHkgc3BsaXRzIFBJRCBhY3Jvc3MNCj4gTE9DMSBhbmQg
TE9DMiBhdCBiaXQgMzIuIFBlciB0aGUgTGludXgga2VybmVsIEhDSSBkcml2ZXINCj4gKGRyaXZl
cnMvaTNjL21hc3Rlci9taXBpLWkzYy1oY2kvZGN0X3YxLmMpLCB0aGUgRENUIGxheW91dCByZXF1
aXJlcw0KPiBMT0MxIHRvIGhvbGQgcGlkWzQ3OjE2XSBhbmQgTE9DMiB0byBob2xkIHBpZFsxNTow
XS4gRml4IHRoZSBzcGxpdCBhY2NvcmRpbmdseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFzaGlz
aCBBbmFuZCA8YXNoaXNoLmE2QHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgZnJv
bSB2MSA6DQo+IDEuIFJlcGxhY2VkIGJyb2tlbiB1bmlvbiBtZW1iZXJzIHdpdGggdWludDY0X3Qg
ZCwgYWRkZWQgd2lyZSBmb3JtYXQNCj4gY29tbWVudC4NCj4gMi4gUmVwbGFjZWQgbG9vcCB3aXRo
IGJlNjRfdG9fY3B1KHRhcmdldF9pbmZvLmQpID4+IDE2Lg0KPiAzLiBGaXhlZCBMT0MxL0xPQzIg
c3BsaXQgYXQgYml0IDE2IGluIGR3X2kzY191cGRhdGVfY2hhcl90YWJsZS4NCj4gNC4gQWRkZWQg
Y29tbWVudCB0byBpM2MuaCBjbGFyaWZ5aW5nIGhvdyBjb3JlLmMgdHJhbnNtaXRzIHQtPnBpZCBk
dXJpbmcNCj4gRU5UREFBLg0KPiANCj4gTGluayB0byB2MSAtDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3FlbXUtZGV2ZWwvZXhkdTUybXVnNmZoM2J3ajdvZm8zamxsdHl1d2pmbmRkeG9iaW8N
Cj4gNHczamhhcTZ1djdrQGJveG8zajVvY2VmMi9ULyN0DQo+IA0KPiBUaGlzIGJ1ZyB3YXMgZGlz
Y292ZXJlZCBkdXJpbmcgZW5kLXRvLWVuZCBFTlREQUEgdGVzdGluZyB3aGVyZSBCQ1IgYW5kDQo+
IERDUiB2YWx1ZXMgb2JzZXJ2ZWQgaW4gdGhlIGNoYXIgdGFibGUgcmVnaXN0ZXIgZGlkIG5vdCBt
YXRjaCB0aGUgdGFyZ2V0J3MNCj4gYWN0dWFsIEJDUiBhbmQgRENSIHZhbHVlcy4NCj4gDQo+ICBo
dy9pM2MvZHctaTNjLmMgICAgICB8IDE2ICsrKysrKystLS0tLS0tLS0NCj4gIGluY2x1ZGUvaHcv
aTNjL2kzYy5oIHwgIDcgKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kzYy9kdy1pM2MuYyBi
L2h3L2kzYy9kdy1pM2MuYyBpbmRleCBkODdkNDJiZTg5Li4xN2ZmNDg0YzVkDQo+IDEwMDY0NA0K
PiAtLS0gYS9ody9pM2MvZHctaTNjLmMNCj4gKysrIGIvaHcvaTNjL2R3LWkzYy5jDQo+IEBAIC0x
NDU5LDExICsxNDU5LDEwIEBAIHN0YXRpYyB2b2lkIGR3X2kzY191cGRhdGVfY2hhcl90YWJsZShE
V0kzQyAqcywNCj4gdWludDhfdCBvZmZzZXQsIHVpbnQ2NF90IHBpZCwNCj4gDQo+IFBfREVWX0NI
QVJfVEFCTEVfU1RBUlRfQUREUikgLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2l6ZW9mKHVpbnQzMl90KSkgKw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKG9mZnNldCAqIHNpemVvZih1aW50MzJfdCkpOw0KPiAtICAg
IHMtPnJlZ3NbZGV2X2luZGV4XSA9IHBpZCAmIDB4ZmZmZmZmZmY7DQo+IC0gICAgcGlkID4+PSAz
MjsNCj4gKyAgICBzLT5yZWdzW2Rldl9pbmRleF0gPSAocGlkID4+IDE2KSAmIDB4ZmZmZmZmZmY7
DQo+ICAgICAgcy0+cmVnc1tkZXZfaW5kZXggKyAxXSA9IEZJRUxEX0RQMzIocy0+cmVnc1tkZXZf
aW5kZXggKyAxXSwNCj4gDQo+IERFVklDRV9DSEFSQUNURVJJU1RJQ19UQUJMRV9MT0MyLA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1TQl9QSUQsIHBpZCk7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVNCX1BJRCwgcGlkICYg
MHhmZmZmKTsNCj4gICAgICBzLT5yZWdzW2Rldl9pbmRleCArIDJdID0gRklFTERfRFAzMihzLT5y
ZWdzW2Rldl9pbmRleCArIDJdLA0KPiANCj4gREVWSUNFX0NIQVJBQ1RFUklTVElDX1RBQkxFX0xP
QzMsIERDUiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkY3Ip
OyBAQCAtMTUwNywxMCArMTUwNiw5DQo+IEBAIHN0YXRpYyB2b2lkIGR3X2kzY19hZGRyX2Fzc2ln
bl9jbWQoRFdJM0MgKnMsIERXSTNDQWRkckFzc2lnbkNtZA0KPiBjbWQpDQo+ICAgICAgZm9yIChp
ID0gMDsgaSA8IGNtZC5kZXZfY291bnQ7IGkrKykgew0KPiAgICAgICAgICB1aW50OF90IGFkZHIg
PSBkd19pM2NfdGFyZ2V0X2FkZHIocywgY21kLmRldl9pbmRleCArIGkpOw0KPiAgICAgICAgICB1
bmlvbiB7DQo+IC0gICAgICAgICAgICB1aW50NjRfdCBwaWQ6NDg7DQo+IC0gICAgICAgICAgICB1
aW50OF90IGJjcjsNCj4gLSAgICAgICAgICAgIHVpbnQ4X3QgZGNyOw0KPiArICAgICAgICAgICAg
dWludDY0X3QgZDsNCj4gICAgICAgICAgICAgIHVpbnQzMl90IHdbMl07DQo+ICsgICAgICAgICAg
ICAvKiBQZXIgSTNDIHNwZWM6IGJbMF09UElEIE1TQiwgYls1XT1QSUQgTFNCLCBiWzZdPUJDUiwN
Cj4gKyBiWzddPURDUiAqLw0KPiAgICAgICAgICAgICAgdWludDhfdCBiWzhdOw0KPiAgICAgICAg
ICB9IHRhcmdldF9pbmZvOw0KPiANCj4gQEAgLTE1NDQsOSArMTU0Miw5IEBAIHN0YXRpYyB2b2lk
IGR3X2kzY19hZGRyX2Fzc2lnbl9jbWQoRFdJM0MgKnMsDQo+IERXSTNDQWRkckFzc2lnbkNtZCBj
bWQpDQo+ICAgICAgICAgICAgICBlcnIgPSBEV19JM0NfUkVTUF9RVUVVRV9FUlJfREFBX05BQ0s7
DQo+ICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAgfQ0KPiAtICAgICAgICBkd19pM2Nf
dXBkYXRlX2NoYXJfdGFibGUocywgY21kLmRldl9pbmRleCArIGksDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhcmdldF9pbmZvLnBpZCwNCj4gdGFyZ2V0
X2luZm8uYmNyLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB0YXJnZXRfaW5mby5kY3IsIGFkZHIpOw0KPiArICAgICAgICB1aW50NjRfdCBwaWQgPSBiZTY0
X3RvX2NwdSh0YXJnZXRfaW5mby5kKSA+PiAxNjsNCj4gKyAgICAgICAgZHdfaTNjX3VwZGF0ZV9j
aGFyX3RhYmxlKHMsIGNtZC5kZXZfaW5kZXggKyBpLCBwaWQsDQo+IHRhcmdldF9pbmZvLmJbNl0s
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YXJnZXRfaW5mby5iWzddLCBh
ZGRyKTsNCj4gDQo+ICAgICAgICAgIC8qIFB1c2ggdGhlIFBJRCwgQkNSLCBhbmQgRENSIHRvIHRo
ZSBSWCBxdWV1ZS4gKi8NCj4gICAgICAgICAgZHdfaTNjX3B1c2hfcngocywgdGFyZ2V0X2luZm8u
d1swXSk7IGRpZmYgLS1naXQNCj4gYS9pbmNsdWRlL2h3L2kzYy9pM2MuaCBiL2luY2x1ZGUvaHcv
aTNjL2kzYy5oIGluZGV4IDZiYTkwNzkzYWQuLmRjZjhkOWIxNDMNCj4gMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvaHcvaTNjL2kzYy5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvaTNjL2kzYy5oDQo+IEBA
IC0xMzgsNiArMTM4LDEzIEBAIHN0cnVjdCBJM0NUYXJnZXQgew0KPiAgICAgIHVpbnQ4X3Qgc3Rh
dGljX2FkZHJlc3M7DQo+ICAgICAgdWludDhfdCBkY3I7DQo+ICAgICAgdWludDhfdCBiY3I7DQo+
ICsgICAgLyoNCj4gKyAgICAgKiBQcm92aXNpb25lZCBJRC4gU2luY2UgY29yZS5jIHNlbmRzIHRo
aXMgTFNCLWZpcnN0IGR1cmluZyBFTlREQUENCj4gKyAgICAgKiB2aWEgKHBpZCA+PiAob2Zmc2V0
ICogOCkpICYgMHhmZiwgdGFyZ2V0cyBtdXN0IHN0b3JlIGl0DQo+ICsgICAgICogcHJlLXJldmVy
c2VkIHNvIHRoYXQgcGlkWzQ3OjQwXSBnb2VzIG9uIHRoZSB3aXJlIGZpcnN0LCBhcw0KPiArICAg
ICAqIHJlcXVpcmVkIGJ5IHRoZSBJM0Mgc3BlYy4NCj4gKyAgICAgKiAgZS5nLiBmb3IgYSBkZXZp
Y2Ugd2l0aCBwaWQgMHhBQUJCQ0NEREVFRkYsIHN0b3JlDQo+IDB4RkZFRUREQ0NCQkFBLg0KPiAr
ICAgICAqLw0KPiAgICAgIHVpbnQ2NF90IHBpZDsNCj4gDQo+ICAgICAgLyogQ0NDIFN0YXRlIHRy
YWNraW5nLiAqLw0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFt
aW5fbGluQGFzcGVlZHRlY2guY29tPg0K

