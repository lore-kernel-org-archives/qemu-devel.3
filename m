Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BE4F8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbwF-0002cN-P8; Fri, 17 Apr 2026 01:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDbwD-0002br-OM; Fri, 17 Apr 2026 01:40:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDbwA-0004QZ-P5; Fri, 17 Apr 2026 01:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3oH5g9U1M11P3rC9wvBmesdzhxOmvWR83XJjiIZKkDD13n+ELJC8ytrJiU4u7UW2etE7P2ipebb405JBWUMIdzzMD8GVYuo/ndRcMB47FYHsiDm+S9TQKpKqaz6kJsXBMzlfJMX4aFBREgJORUR0fo4nzv13uV/hK69hO9INKr0VwKsvnftoymf8TCBJbsXMsxZxRokbVFM0j0/rGzbAY/KJ7nYTxlwc4TKb9PxbYj8+I5+MXGz5Y6u9b7UhuvpBs288Mo/WalSshFJR8QvVeAR1JfKBYP+bfWm7gwqQ/LS1cume4DwTuGPO9Npa/HWMe7RDRoSzmg0HwGa6UQlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xanHB1VmvJApEWfqeAqiQ6TTTSUZwIm4NwqzMoraNG0=;
 b=K7vgz2+Z49qou43THf17ZFMPzNro5uTx6eVtKMhgobgFsjGAIh/AzVcN7M0cWE+bE3rzQU5qsWe4Kg+cEBOXJUqrfPuQ5CjfR7i4/CGgtfNPpVN4Q6fC81BfrqKrOheCY9Dtylj/yW+OVZl/HLnftRhHTYKm0yA2FfjEGyn3/NhWOPW8UgIZW/edJ4V4JBsVuVt4U2flfdB/oMj/FYvdXFbpSeusMXXnlOplhls5RMWqf2N0w4l1vZZLCD3KAUHzF0GExvKwYmwRb7XKCkLLU/rU5EVIdV3n9QsXo3QNeac2tTr4DsmvASkNbUrdSt7j8exQGTU7UZIiA0wA52EJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xanHB1VmvJApEWfqeAqiQ6TTTSUZwIm4NwqzMoraNG0=;
 b=msPZBvQElukmjF2ziucZv1/22DxJaExMtJe7l0xtIIjfNyGeSbdQhpxuXS/TkR4zhWzL3xbMvoNUrg2ceD3E8TQzN9UsSzC66XHfpI8DrM9hf0rjzokEY2X1g/Rq5B58vml7ZQkP/YqrtFq7mleiJ/Lzkmf9QJxa5Nby9lRep2Eh2plApWjHW8rN5RnhnUWQ6VC3RWaw18c0dgTRlibPz1rUIZBDMiLCj3uaUmFmmxlWg/xJ1LYgaZKvny9/5p8W2AfXzK/tyRS5xxmh5jm3EUXRt/c3RIzX4NwutHRJkT8V6totjdH+uVMLrCg80Npd5C3q8gJqGwFt3I0uExNa4g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6033.apcprd06.prod.outlook.com (2603:1096:101:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 05:40:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 05:40:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHczUNObou9Fmh1/EmYf55F3wvnKbXitHqAgAAHusA=
Date: Fri, 17 Apr 2026 05:40:10 +0000
Message-ID: <TYPPR06MB82062B89BEDF49BA637CDC02FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-10-jamin_lin@aspeedtech.com>
 <c03af2eb-c7e9-4954-9a53-b1575c7073f6@linaro.org>
In-Reply-To: <c03af2eb-c7e9-4954-9a53-b1575c7073f6@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6033:EE_
x-ms-office365-filtering-correlation-id: 3a0c8893-37bb-4d16-6bfb-08de9c43ca51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: h9kIqIcIu0juZiXBlgQapJ3bKDJ5Cwdc+7bLirNOVvyzjSbBrNVTxUsKw6BbUCCS0BdOvHkuz1XOtkltSB1OryEWcBWqcbKFZ8y7VlpFnhFvsUGNiNPg/enIcxDrk1lB4ZWkmSFVYTdfgVx5WB9ji1WRzY2RxSMUBAb8kcbGgiJRRNDYeFRN9z9h9Z0NJhaSa7cMX5sI5hkkb/cgP7lOhbdzbmZq1KrmWtUmtdGEezCWAIPrNb31ROGmujRQervim3Hy7dHcYQ/FmRHl+f3lo2+iB5dGZVEUhrhDEa5Syer21AckMjwtlTATsgzpU7ez8qQSqT/eop+hM+yJNqYBEPllqJQi3fTuCZUJvDiDpmiUWwVDlCWbqPXHAemQ3YBkpy3oYeDoLAGolwRm/FFJoY6hcfJ6LZuMDXvPMDi6gQavg9gGV2vBwJBnzCHGJ/9dMSu4+k7yddseSRdlH9a71/d/UoFA9NwBA2tcqjhZMdn4vdSqr1g1SEH2U/J6JdknwmkVlMVhuYA4zrf3adR8762gPvcLPipaITJxJlBShkPfwNEXt4WdMpyuqVtUmzYcV15IDCDhOOquHmdPWlwqtAh1KF3MkldNPwS5oMY8jS8MVkNSojc6u8FUb+6LvKyrpiMPO+cgLLlMf8tQthw5hI2N52sfEZXqmLu+tDO9trZ2grZffuShEoDqg7nkD4DeCUVzxhic4qyMaq8qzPfdUao0U7cjbNnsSW0s4lrsQ/wfo5pCFj8IMTaMbwIVj8fvNaDErx7smJVoEy1LzL9/lIVxDNLyJ5wt3VYyHTdD6x/aQ9HinNC+/J6ogi+guYik
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFpXSDk3NnRoRmllVGFsbURoT1NlRldQcVJJdzRrcmJ6R2RzUklMTGFkRmVT?=
 =?utf-8?B?dFlmaEJjME0yYXJDL2diblVpaVZOVk9sQ3JqZXMxb0hHVHp3R2ZBeTN6OXJu?=
 =?utf-8?B?eC9SUzd5OExmRVZ3aU1ua1pDaVZZYUpBZmQzS3dXcWN2S2dmTlNsT0kxMmpF?=
 =?utf-8?B?TmM1dElZaVlpZlRhQnpwS2x5d0hLbmw4VXMyL1pRbEp1SWtsWnRTb2dncG1h?=
 =?utf-8?B?eXVPSkd2YXFXWmtJSkc1SXVDYU80MEM0eWxpNVRtcmlFUnFybS9ES2NnMGNK?=
 =?utf-8?B?NTh5OHI3cjhsc3BKQ05RUWFHdVM1djRCSGo1SEtnWFpQTVVJWUp2ZnBqKzhz?=
 =?utf-8?B?d1gvdS9mY2U3NU8wWVE3SGlFSTU4VmFCK3FoQkVRL2gxa2VTdFFkN1RGdk5P?=
 =?utf-8?B?TWs1Y1BJaDNFVmZLczROcW5jZVJlR3ZwNERBZGVGR2VpUGlQRWxqSUliOXF1?=
 =?utf-8?B?NHdCZk8ybkozV2JDbWJMQ1YyOXNQRHl3QmNXNmx4aWxWNU1TNCsyak95UGZ1?=
 =?utf-8?B?TmU5Y3VXbmFGU2F1Z2xZWE1PeDBKMkFPcXZ4Uzc0KzdGQk5ZY0NScjNEbWN2?=
 =?utf-8?B?b2ljcDRGaEt6NldiNEFoNVFpSkt3aVh2MGxjZjA0RFI0czYzRlNacXdSNWVR?=
 =?utf-8?B?cHIwR2dkd3RNQU05dXp0QlRGbkNyOFQ4YzRSV2l4UTdmZkpENlF4cVBod0VO?=
 =?utf-8?B?RE83RGhnT2p1SGR1R1hrV3NxbFVBN2xZQzFOUEFWbkx4VEI5RnFhTEpDUHdL?=
 =?utf-8?B?eHQrbEh6ZmdOTjNRcEhZSDZRMnZCUUZXU2tIeExhQUVwV3l6S0ljdCtzMzRR?=
 =?utf-8?B?bDhUT1BMR2h4U1hLVkhNcEhEeU9aK2h0V1llenBpVjhtSWM1bGhPU1h4aWo2?=
 =?utf-8?B?N2RjY01jVUdvV2dtay9IcCt0Q2g5amVGdi9EYWl4ZktJYjB5Z2xwbG1SMzlL?=
 =?utf-8?B?ZXMzb3FBeTE2TWpIamxLOFR0K0ZUOTVpb21RL2RTOEdkTUJvSW0xejhJazN5?=
 =?utf-8?B?aE1yME1VVlBCSEVwVVhUMHVKYkxNWE0vZkhPV1VoWEduVkd1WWhHdWJjclFY?=
 =?utf-8?B?emZBZHBUcWlmOWYrUHRtRURrYUxBVHZqK3lzTmNIeWZkMTVYcGRxVFlVK1Nk?=
 =?utf-8?B?MTlkY3hGUUxTaWZnZHNLamNDN2VaaU1NUUJKdFVMc2hSa2R6d3NnSHd0b1Bo?=
 =?utf-8?B?MGFpNGlnSk56U3MvYWNHaVFBaUhhY0FLR2N2OFFEa295WTg0THVKMG8rblkx?=
 =?utf-8?B?N2RhQmRoYXM5MHhnVU9vekpkbW5WSFFJcSttQWxKNVcrRDU1MndqMXFQc2NJ?=
 =?utf-8?B?Y2xxMG5yME9rVmFQRE1iVXdzRmVvS3JwK0NYcmFlMHRNbEVEMThycHIwcW9X?=
 =?utf-8?B?STJTMzU0cmVwSzIvaTBsNUlobFFPQkZwV1grSG9ObGdZbElEbkxOMjN5bXdW?=
 =?utf-8?B?MHVSRnhnT0lnc3ZkNnFPaksybGtHTzRxS3c0VC9OSERXKzg5VDlZTFp4WjVG?=
 =?utf-8?B?dFdhOW5aU252STRadkpiN2J3RzRYZUdXaHYvY0daekl1a2x3UmsvWmd2VWZJ?=
 =?utf-8?B?VGdoZDRndFFONE1kYi91bEVQYm9aQ2xDN3ZYb1BRM0JRZWRLMFdxZkRpZ040?=
 =?utf-8?B?RVVCMnA2MXhkalQxUnpVOFM0UVFBZmhRcElQTDJkWWhOZnh6YmR1ZXNtYlFC?=
 =?utf-8?B?L211aFNQYjVXMm5uZUszWDhXWlB4dXBzNUxSdjVSR25VTG5XbkJyOHdTMDZy?=
 =?utf-8?B?ZGQ4aFVvdy9pM0hqRU5QQ09hUkFwU05lUy9CRnA4N0ZjbVRiZEkwSHRreHRz?=
 =?utf-8?B?M2xkRE1DQWxSb0l5NHhINFFpckJLWGNNZHp0UlRGY1pJazhMczVhbzhBOTZ3?=
 =?utf-8?B?eENvR25HcldYbjFKaHdveHR0TjU4b3ZMSzlHcEhjYW5MZVpLZlg1MzBWZFgr?=
 =?utf-8?B?WjU4SmdyVldVS29TOGZQdm1iVGVYU2prdjZ0REYycWVuVTVUaU5GSnlVSVdF?=
 =?utf-8?B?eEtCcTRVWk1DSjl1WWNLUnlYc2h4OUVlcUJ3eExwaHpxcTNaZUIrK2ZzTGZG?=
 =?utf-8?B?Qng1WFVXNGtZdHd1WmN3NGxDQzV1VVBBL2FzMGpKZ2VXUnM5NDIxMU9nZDE0?=
 =?utf-8?B?Sm1WNE13U3pjUmJTTTJldU5PR01ONVBkcjdSaDNvVVNrcnNtbWZKNCszMEYr?=
 =?utf-8?B?eDhkcTZmS0ZpSHg3dk9UcGptSk56L05yaHlTUjU1aGN6eVJTOFV6cEVPQ1Fm?=
 =?utf-8?B?TUp4SExzUEE2djk4SllwMytBem53Rm5haHFwSlRFQUNudlc1aHFkY1U3VHJr?=
 =?utf-8?B?eGkrZ0ROZDFYaUo3NFpVKy9aanVMcHdpeDg4WkNiZjFoOWpZVCtGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ILeSWV1UeKEp0RiVJMmekQtZrNVxoP4Or4Qv+WRVBXcEJmPeeaRXVXr/40wivzMHEtQpXAb+w1rP7DLj7wJFQZZK4eBZ7D/FGAfnF97mNPX1C/59VmzqdHfVna7wGl+i+GfBudZhlwDRN0iHa0JMncuP8SdMA8aWqxz/5cv2NFDmhsIfNMeLnnS4Whu0WeotYP6t8cfaiyHMgxQZ7wTf6OLu8VyQ3itaQ4vmypNZv0R2txT2WX3W4Jwy/MnOhFZ1wKmHnbK3iFiOr5o5VNOn5ng1Btof9MlIndj6PeJwBW8K3UvezZl2xJ67NOG9Mxzp9e24yLvBWJv1DAS4i0YbVg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0c8893-37bb-4d16-6bfb-08de9c43ca51
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 05:40:10.3987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etarCiYBInuWcgvk8wLDNfMzmmyl1hPjV4SYzlc78sYDhBBA+8sJhfrdybOyG95I1IjKHWYpsYDu/7H+OQcjxLHC2nJ3tS5r2LImwB4zGe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6033
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwOS8xN10gaHcvdXNiL2hj
ZC1laGNpOiBJbXBsZW1lbnQgNjQtYml0IFFIDQo+IGRlc2NyaXB0b3IgYWRkcmVzc2luZw0KPiAN
Cj4gT24gMTYvNC8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEVIQ0kgc3VwcG9ydHMg
NjQtYml0IGNvbnRyb2wgZGF0YSBzdHJ1Y3R1cmUgYWRkcmVzc2luZyB3aGVuIHRoZSA2NC1iaXQN
Cj4gPiBBZGRyZXNzaW5nIENhcGFiaWxpdHkgYml0IGluIEhDQ1BBUkFNUyBpcyBzZXQuIEluIHRo
YXQgbW9kZSwgdGhlDQo+ID4gQ1RSTERTU0VHTUVOVCByZWdpc3RlciBzdXBwbGllcyB0aGUgdXBw
ZXIgMzIgYml0cyB3aGljaCBhcmUNCj4gPiBjb25jYXRlbmF0ZWQgd2l0aCAzMi1iaXQgbGluayBw
b2ludGVyIGZpZWxkcyB0byBmb3JtIGZ1bGwgNjQtYml0DQo+ID4gZGVzY3JpcHRvciBhZGRyZXNz
ZXMgKEVIQ0kgMS4wLCBzZWN0aW9uIDIuMy41IGFuZCBBcHBlbmRpeCBCKS4NCj4gPg0KPiA+IFRo
ZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGFzc3VtZXMgMzItYml0IFFIIGRlc2NyaXB0b3IgYWRk
cmVzc2VzIGFuZA0KPiA+IGRpcmVjdGx5IHVzZXMgbGluayBwb2ludGVyIHZhbHVlcyB3aXRob3V0
IGFwcGx5aW5nIHRoZSBDVFJMRFNTRUdNRU5UDQo+ID4gdXBwZXIgZHdvcmQuDQo+ID4NCj4gPiBJ
bnRyb2R1Y2UgYSBoZWxwZXIsIGVoY2lfZ2V0X2Rlc2NfYWRkcigpLCB0byBjb25zdHJ1Y3QgZnVs
bCA2NC1iaXQNCj4gPiBkZXNjcmlwdG9yIGFkZHJlc3NlcyB3aGVuIDY0LWJpdCBjYXBhYmlsaXR5
IGlzIGVuYWJsZWQuIFVwZGF0ZSBRSA0KPiA+IHRyYXZlcnNhbCBwYXRocyAoYXN5bmMgbGlzdCB3
YWxrLCBob3Jpem9udGFsIFFIIGxpbmssIGFuZCBwZXJpb2RpYw0KPiA+IHNjaGVkdWxlIGVudHJ5
IGhhbmRsaW5nKSB0byB1c2UgdGhlIHRyYW5zbGF0ZWQgNjQtYml0IGFkZHJlc3Nlcy4NCj4gPg0K
PiA+IEVIQ0kgNjQtYml0IGJ1ZmZlciBwb2ludGVyIGZpZWxkcyBhcmUgZGVmaW5lZCBpbiBBcHBl
bmRpeCBCIGFzIHNwbGl0DQo+ID4gMzItYml0IGxvdy9oaWdoIHBhcnRzIGxvY2F0ZWQgYXQgc2Vw
YXJhdGUgb2Zmc2V0cywgcmF0aGVyIHRoYW4gYQ0KPiA+IHNpbmdsZSBjb250aWd1b3VzIDY0LWJp
dCBmaWVsZC4gVGhlcmVmb3JlLCB0aGUgYnVmZmVyIHBvaW50ZXJzIGNhbm5vdA0KPiA+IGJlIHJl
cHJlc2VudGVkIGFzIHVpbnQ2NF90IGJ1ZnB0cls1XSB3aXRob3V0IHZpb2xhdGluZyB0aGUgZGVz
Y3JpcHRvcg0KPiA+IGxheW91dCBkZWZpbmVkIGJ5IHRoZSBzcGVjaWZpY2F0aW9uLg0KPiA+DQo+
ID4gSW50cm9kdWNlIGVoY2lfZ2V0X2J1Zl9hZGRyKCkgdG8gY29uc3RydWN0IGZ1bGwgNjQtYml0
IGJ1ZmZlcg0KPiA+IGFkZHJlc3NlcyBmcm9tIGJ1ZnB0cltdIGFuZCBidWZwdHJfaGlbXSBmaWVs
ZHMuIFVzZSB0aGlzIGhlbHBlciB3aGVuDQo+ID4gY2FsY3VsYXRpbmcgdHJhbnNmZXIgYnVmZmVy
IGFkZHJlc3NlcyBzbyB0aGF0IGRhdGEgYnVmZmVycyBhYm92ZSA0R0INCj4gPiBhcmUgY29ycmVj
dGx5IGhhbmRsZWQuDQo+ID4NCj4gPiBBbHNvIGFkZCBidWZwdHJfaGlbNV0gdG8gRUhDSXFoIHRv
IHN1cHBvcnQgNjQtYml0IGJ1ZmZlciBwb2ludGVyDQo+ID4gZmllbGRzIGFzIGRlZmluZWQgaW4g
QXBwZW5kaXggQi4NCj4gPg0KPiA+IFdoZW4gNjQtYml0IGNhcGFiaWxpdHkgaXMgZGlzYWJsZWQs
IGRlc2NyaXB0b3IgYWRkcmVzc2VzIHJlbWFpbiAzMi1iaXQNCj4gPiBhbmQgZXhpc3RpbmcgYmVo
YXZpb3VyIGlzIHVuY2hhbmdlZC4NCj4gPg0KPiA+IE5vdGU6IFNpbWlsYXIgc3BsaXQgNjQtYml0
IGJ1ZmZlciBwb2ludGVyIGhhbmRsaW5nIGlzIHJlcXVpcmVkIGZvcg0KPiA+IHFURCwgaVREIGFu
ZCBzaVREIGRlc2NyaXB0b3JzLCB3aGljaCB3aWxsIGJlIGFkZHJlc3NlZCBpbiBmb2xsb3ctdXAN
Cj4gPiBjaGFuZ2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody91c2IvaGNkLWVoY2kuaCAgIHwg
IDQgKysrKw0KPiA+ICAgaHcvdXNiL2hjZC1laGNpLmMgICB8IDQ4DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+ICAgaHcvdXNiL3RyYWNlLWV2ZW50
cyB8ICAyICstDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QtZWhjaS5oIGIvaHcv
dXNiL2hjZC1laGNpLmggaW5kZXgNCj4gPiBmZTRjNTA4YzMyLi43NzNmMzc2ODM0IDEwMDY0NA0K
PiA+IC0tLSBhL2h3L3VzYi9oY2QtZWhjaS5oDQo+ID4gKysrIGIvaHcvdXNiL2hjZC1laGNpLmgN
Cj4gPiBAQCAtMTQxLDYgKzE0MSw5IEBAIHR5cGVkZWYgc3RydWN0IEVIQ0lxdGQgew0KPiA+ICAg
I2RlZmluZSBRVERfQlVGUFRSX1NIICAgICAgICAgICAgICAgICAxMg0KPiA+ICAgfSBFSENJcXRk
Ow0KPiA+DQo+ID4gKy8qIFFIIG92ZXJsYXk6IGFsdG5leHRfcXRkLCB0b2tlbiwgYnVmcHRyWzVd
LCBidWZwdHJfaGlbNV0gKi8gI2RlZmluZQ0KPiA+ICtFSENJX1FIX09WRVJMQVlfQ09VTlQgMTIN
Cj4gPiArDQo+ID4gICAvKg0KPiA+ICAgICogRUhDSSBzcGVjIHZlcnNpb24gMS4wIFNlY3Rpb24g
My42DQo+ID4gICAgKi8NCj4gPiBAQCAtMTk0LDYgKzE5Nyw3IEBAIHR5cGVkZWYgc3RydWN0IEVI
Q0lxaCB7DQo+ID4gICAjZGVmaW5lIEJVRlBUUl9GUkFNRVRBR19NQVNLICAgICAgICAgIDB4MDAw
MDAwMWYNCj4gPiAgICNkZWZpbmUgQlVGUFRSX1NCWVRFU19NQVNLICAgICAgICAgICAgMHgwMDAw
MGZlMA0KPiA+ICAgI2RlZmluZSBCVUZQVFJfU0JZVEVTX1NIICAgICAgICAgICAgICA1DQo+ID4g
KyAgICB1aW50MzJfdCBidWZwdHJfaGlbNV07DQo+ID4gICB9IEVIQ0lxaDsNCj4gPg0KPiA+ICAg
ZW51bSBhc3luY19zdGF0ZSB7DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QtZWhjaS5jIGIv
aHcvdXNiL2hjZC1laGNpLmMgaW5kZXgNCj4gPiBiOWU0MjUxZDYyLi4zN2FlNjM3ZTA4IDEwMDY0
NA0KPiA+IC0tLSBhL2h3L3VzYi9oY2QtZWhjaS5jDQo+ID4gKysrIGIvaHcvdXNiL2hjZC1laGNp
LmMNCj4gPiBAQCAtMTQ3LDYgKzE0NywyNCBAQCBzdGF0aWMgY29uc3QgY2hhciAqYWRkcjJzdHIo
aHdhZGRyIGFkZHIpDQo+ID4gICAgICAgcmV0dXJuIG5yMnN0cihlaGNpX21taW9fbmFtZXMsIEFS
UkFZX1NJWkUoZWhjaV9tbWlvX25hbWVzKSwNCj4gYWRkcik7DQo+ID4gICB9DQo+ID4NCj4gPiAr
c3RhdGljIHVpbnQ2NF90IGVoY2lfZ2V0X2J1Zl9hZGRyKEVIQ0lTdGF0ZSAqcywgdWludDMyX3Qg
aGksIHVpbnQzMl90IGxvdywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IG1hc2spDQo+IA0KPiBSZW5hbWUgQG1hc2sgYXMgQGxvd19tYXNrPyBPciBkaXJl
Y3RseSB1c2UgNjQtYml0Pw0KPiANCj4gc3RhdGljIHVpbnQ2NF90IGVoY2lfZ2V0X2J1Zl9hZGRy
KGNvbnN0IEVIQ0lTdGF0ZSAqcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50MzJfdCBoaSwgdWludDMyX3QgbG8sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QgbWFzaykgew0KPiAgICAgIHVpbnQ2NF90IGFkZHIgPSBzLT5jYXBz
XzY0Yml0X2FkZHIgPyBkZXBvc2l0NjQobG8sIDAsIDMyLCBoaSk6IGxvOw0KPiANCj4gICAgICBy
ZXR1cm4gYWRkciAmIG1hc2s7DQo+IH0NCj4gDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1
Z2dlc3Rpb24uDQoNCkluIHRoZSBjdXJyZW50IGNvZGUsIHRoZSBtYXNrIChlLmcuIFFURF9CVUZQ
VFJfTUFTSykgaXMgZGVmaW5lZCBhcyBhIDMyLWJpdCB2YWx1ZSBhbmQgaXMgaW50ZW5kZWQgdG8g
YXBwbHkgb25seSB0byB0aGUgbG93IDMyIGJpdHMgb2YgdGhlIGJ1ZmZlciBwb2ludGVyLg0KSWYg
d2UgY2hhbmdlIHRoZSBmdW5jdGlvbiB0byB0YWtlIGEgNjQtYml0IG1hc2sgYW5kIGFwcGx5IGl0
IHRvIHRoZSBmdWxsIDY0LWJpdCBhZGRyZXNzIChhcyBpbiB0aGUgcHJvcG9zZWQgdmVyc2lvbiks
IA0KdGhlIHVwcGVyIDMyIGJpdHMgKGJpdHMgNjPigJMzMikgbWF5IGJlIHVuaW50ZW50aW9uYWxs
eSBjbGVhcmVkIHdoZW4gdGhlIG1hc2sgaXMgb25seSAzMi1iaXQgd2lkZS4NCg0KRm9yIGV4YW1w
bGU6DQoNCiNkZWZpbmUgUVREX0JVRlBUUl9NQVNLIDB4ZmZmZmYwMDANCg0KSW4gdGhpcyBjYXNl
LCBhcHBseWluZyAiYWRkciAmIG1hc2siIGFmdGVyIGNvbWJpbmluZyBoaS9sbyB3b3VsZCB6ZXJv
IG91dCB0aGUgaGlnaCAzMiBiaXRzLCB3aGljaCBicmVha3MgNjQtYml0IGFkZHJlc3NpbmcuDQpU
byBwcmVzZXJ2ZSB0aGUgb3JpZ2luYWwgc2VtYW50aWNzLCB0aGUgbWFzayBzaG91bGQgb25seSBi
ZSBhcHBsaWVkIHRvIHRoZSBsb3cgcGFydCBiZWZvcmUgY29tYmluaW5nIHdpdGggdGhlIGhpZ2gg
MzIgYml0cy4NClNvIEkgc3VnZ2VzdCByZW5hbWluZyB0aGUgcGFyYW1ldGVyIHRvIG1ha2UgdGhp
cyBleHBsaWNpdC4gSSB3aWxsIGNoYW5nZSB0aGlzIGZ1bmN0aW9uIGFzIGJlbG93LiBXaGF0IGRv
IHlvdSB0aGluaz8NCg0Kc3RhdGljIHVpbnQ2NF90IGVoY2lfZ2V0X2J1Zl9hZGRyKEVIQ0lTdGF0
ZSAqcywgdWludDMyX3QgaGksIHVpbnQzMl90IGxvLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90IGxvX21hc2spDQp7DQogICAgdWludDY0X3QgYWRkciA9IGxvICYg
bG9fbWFzazsNCg0KICAgIGlmIChzLT5jYXBzXzY0Yml0X2FkZHIpIHsNCiAgICAgICAgYWRkciA9
IGRlcG9zaXQ2NChhZGRyLCAzMiwgMzIsIGhpKTsNCiAgICB9DQoNCiAgICByZXR1cm4gYWRkcjsN
Cn0NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiA+ICt7DQo+ID4gKyAgICB1aW50NjRfdCBhZGRyOw0K
PiA+ICsNCj4gPiArICAgIGFkZHIgPSAodWludDY0X3QpKGxvdyAmIG1hc2spOw0KPiA+ICsgICAg
aWYgKHMtPmNhcHNfNjRiaXRfYWRkcikgew0KPiA+ICsgICAgICAgIGFkZHIgfD0gKHVpbnQ2NF90
KWhpIDw8IDMyOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldHVybiBhZGRyOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdWludDY0X3QgZWhjaV9nZXRfZGVzY19hZGRyKEVIQ0lT
dGF0ZSAqcywgdWludDMyX3QgbG93KSB7DQo+ID4gKyAgICByZXR1cm4gZWhjaV9nZXRfYnVmX2Fk
ZHIocywgcy0+Y3RybGRzc2VnbWVudCwgbG93LCBVSU5UMzJfTUFYKTsgfQ0K

