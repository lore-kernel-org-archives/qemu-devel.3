Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C690CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyRq-0006Dl-Me; Thu, 21 May 2026 04:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPyRo-0006BX-7w
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:08:04 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPyRm-0007rh-AB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFQRJ3kTpHif0Zq6yTvJ9IYm4ByUsB3hmHaSWqX2hrl/5EX7WJCCMp0J8E87mSxuZDNvsrIKtTpHphi6LJaG2NrDFGvqq2eVcpA4qHPQ/LXLxOz2fN2eQHAPKKjzq7uWaKVwkEBS2vwTQNMbAWVD99G3bTU4cUCkqbb5wwkuEBk6ybIwQVF5mHFXqfcJcZquKxhiY4pT18zRooLPEPORMJ3IzYyMvFGxPPBuycgvagyL3bEpbWli/7UALmE3FkDHSYGQi3FLvsH59jNgxBhpDT56WRNIdsOPGKDV5xlqCJ26NPZSasZjGmifhie6cQXafVFamdqnCly1zAg1jKkfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnaXmkwiAWVQmKtzlxx1HlB5X356esVVrF8OYebFiKw=;
 b=nEvDYW9kfx0R1soCB1udacUhqwSQmt5QEEIlDKmVdCOJ/4CtfrT1eSVt4w06kH8LuSBxXjXdNBOtykLwIZoekfbCtaY9m76szC+mMT1FIjeiUSdZ8qvBArqIUwVXOhm+z3eOBTDrOsN0J2Q2azTcQK0Ye/P4PWPEdrxvTOx19k8niZlRZPX+YmqHjbqhhckJyfSS8mNJ2KLc/nZyJr6e5k+/P1CGnMeLyO0AX3WcIhbnPWTCO60o26UeRo545bF5eHPJV/jG4RlHvY/oxBt+9aMQrKusIOfqwuFlCJspiu7f8LkpKYx6yXixccpCJiXm32PZGgF9vAQit7OsVU6GhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnaXmkwiAWVQmKtzlxx1HlB5X356esVVrF8OYebFiKw=;
 b=qgLLQMlf8UqXvi5cucEmKz+MxoZOSu1tKJM8Gal2Kun7DYuiEgRCgchGk2cr6wAGWAIpwgYSwqBbHZRMy1HmBydqP46NPwonAmi9aioiLuZQNoibK3/FVX2dH4v3lUOY4I7N6UpdQmVlE9JkNlKQzPEGOIa+49ZqZ+vBM3bFszksXdP1UMCj+YNKhhZf/rNdBxViG/2NHoXPoMtLuxrMW7pZl7GLFahyaAJfbs417qF2W+xQ3VXpQfo33WdtEsjozTLIlTgjrl8ZN5LiNtA04PVsL8rHYqgtj8V3SCIXLDGb3jcrMEyzxOsYRZLPEToey4SaKF+ZFY5P0RUAR2bDgg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8373.apcprd06.prod.outlook.com (2603:1096:4:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 08:07:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 08:07:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>, Joe
 Komlodi <komlodi@google.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Nabih Estefan <nabihestefan@google.com>
Subject: RE: [PATCH 32/39] MAINTAINERS: Fix F: typo in "I3C"
Thread-Topic: [PATCH 32/39] MAINTAINERS: Fix F: typo in "I3C"
Thread-Index: AQHc6PiZT/tJxggvAUOvBFJQqAYXp7YYH4cw
Date: Thu, 21 May 2026 08:07:55 +0000
Message-ID: <TYPPR06MB820628660CF95C40C634E8EAFC0E2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-33-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-33-armbru@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8373:EE_
x-ms-office365-filtering-correlation-id: 3f7fe084-1812-4a6c-4ea7-08deb7101042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021|4143699003;
x-microsoft-antispam-message-info: HUST48l0bvpB0VkBgvaNJKzU24TMMfG+F4PyTWO3K9dWizugpCIu3xkFFdFPfbU0Eh419sSonSRabwU7W4ksFJQjzeYtdFAiJLoCE9TjFTtQQh9HE7TVesmGO7FBjK2tEEoGU66CeShLPg9QjqZEWF2AePbVwpc7kNGp7hcT/yQV8WwhAAwCJHV2LpJUuESYaFlEvtNkcgc0G6asU4svtcHCSyau0bRhK+4ovZfL9KtGw8vBKnIkfDb9vca8kgkORTGCTRV0munQeMF+lyAWEX++wjGB2982OEbr2zMdnDIHlTTIrA4C1GRZjCnAFLV8x4ri7Ja0YIyd+PxITYbOGfsKQ6UkwSYhQdAqRL649YKlWiIcTellJSvuvMzc01ktoHMB68DLBZ0sF7/f6yLbT+vOAdYoZmnQKe5JfDy8M7TrQVc181QIRtuj5R2IPP/lzw1t7614+9RcHSLQOX8MAi3ANqJT7B8XQ1VzJM0RfHLGc0n3/CfKyjUC+GpXp7Vgh+snhZ4qGLsT3Xzal5afxCmodnRLkxj8y2/pa9jQXO3cbqpw9IMH9QemrLUglcOngqB1WQxnL7TCWaVsHh2nuXoIBWJIjQ2WRh9Sp1FoMQdV7CEvyMVdGYXkaL3h4dVK9sDfAPTvf1/hxXjYyQgpWGzZD6nlg0dKyMG91J6l1VpQZor46y13B6OqU2QEEAu8QcYAQWSjO+l4TOM0yROTrsRGe+9XozhDEy/fGZdGv3pnT0KQJxEpBkkqRn31h+i9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tmw2RlhaT1hjVW5tN2NTQlphcFFyeDErQS9GZzkrSTVrN1lRTEpWbGppSXhM?=
 =?utf-8?B?dGFrMnRBd2JTTTgvVi9ZOGp5Y1A3WlJ4aTZ4U3NLNmU5bU1XSjJRUml2Rzh6?=
 =?utf-8?B?bnh3V3pIc0hDMzN4dFdRMWxRV0VxNjFKMVBqQnRyUE95WUc2aTBXY3dtQzVJ?=
 =?utf-8?B?WXJ5WWpSNG1ZQWlNOExvbEw0dVVJMnNTYW5UazY3WUFMUGVEOVhYMFh2UlU1?=
 =?utf-8?B?ZVhabHNGMVgzOVVxVU4rck8vbktkalgzYThrOXlpZzdQeGN3QzF4TDY4UjNl?=
 =?utf-8?B?bmRQOUdsL1hsQ3F6aURja20zemJqWmNtNTBXRVRTZHV2Ymx0YlpYWDlSbGJm?=
 =?utf-8?B?MnEyc0NSNThDZDFnbTBSL0xkdUFDZjU0T0Y0Tm8wNjJ1eXF6WDZoejhUN2hm?=
 =?utf-8?B?S2l0dGo3QlFpaVZtZm9DZ3Jja1lzMGRBWkdQbUNlTWZjN3hOM2lyVm5GbkZ0?=
 =?utf-8?B?NGE2VURua2dOTS9IRHhReXZ2R0R0S0ZJUndXZk85OHlLcFFkMlhWZkZGQk9Y?=
 =?utf-8?B?N00xalVrOVExVTVyb2V5QjZseXY4eTVlclVDYlBDY01lenZ4MjZGMkExWjVE?=
 =?utf-8?B?L3BGRFFQaWlJR0RuQjNQQ05xS2NYVnE2ZzkvK0lkRHpsSjdOblZncVlMWEIr?=
 =?utf-8?B?ZjBNL1Q0ZmoyVWtFeVZDMk56RWpvVExCdE5kVVIwMzlMOU9ZZkpZb3lQK3BY?=
 =?utf-8?B?VWxoZzBYRVU1Q3ZJQytjM0JhVHV3a1lVZ1BXSGY3YXltelg2bkJDM2NYaU5r?=
 =?utf-8?B?cjVMclhKejlBTlNLQ1hIUlluZDNkU1RTc1F0MGp4eXViTzdGbHRUZmtFdFgv?=
 =?utf-8?B?YndpMVZTSmVQaTE5bEFORkRydDRlYmJ2b2xrZ0oxR2VrVmN6dk83V1p2UVlu?=
 =?utf-8?B?VVlLSUkrc3Exd245WHJ5blQwdk5VNnVHUnpuNDN2dlBPVkgwRGY4NnJORXRU?=
 =?utf-8?B?WnFOV3JxQW91RHdFMUJMa0NUWEcxTzBUcHlxU0w0RVJ3Y3pzd0RaZ1RCdkxm?=
 =?utf-8?B?cFBXQkRXUkJuakVqSHZ5Z1BBNXBSYnNhVXdVWlltRW1rQ3JSUC9LMnFWY1Bt?=
 =?utf-8?B?NE1hN0dSUXppODh5S0tSUFlIWHliTktkbFU1UW9hTzZBdnhvOC9hM1phWjNY?=
 =?utf-8?B?Rlo2SWppamYrVDBBUFZOa1RNQlpvL0VUcDU4dWQ3Z25FUHh1ZGZqUGpGMGRN?=
 =?utf-8?B?bGFUZkVGWUpWMWxMT0NQYXB0RzJCdDFJeTgwbkt0MndXSUQ5Y3ljbkhtRC9o?=
 =?utf-8?B?YkMrZnI1SlpxU2N6RTg0djJiNTd1MDMxSmgrRXZVRmxmNzFKZWs0UE9qbGVW?=
 =?utf-8?B?Mzg3WWhvd1dvbitzbFBvLzhUNUpwUXZKNWNrZXRicGRMWU01SzhrSTBtNlFy?=
 =?utf-8?B?VXdBcEtGV0NaUGhLWVB2UWVMS3hpb3Q5NE1QRDdQSDJ3R1NScXlTbFBINVEv?=
 =?utf-8?B?eGVZck9ZU0NtNlU5ZnY5T3ZZSjJWSjhzeGl1ZGRKaS9DQ2ZDeVAzYkgvQk53?=
 =?utf-8?B?NjRxSHI4RnZ4STRLMm85bTlyM3lCUlhvS2JLMGo5MkFtNE00ZFgzeTQ2cXJt?=
 =?utf-8?B?cEJ0eDYwNjE4d1R5UWVyZmRwcHB2MW5Rd3ozQnMyaXNMY2duK2V2dnIrUFZs?=
 =?utf-8?B?RmU2disxaDVGcFZDNVdqR3FiUnhQbkpIWjJRMEVJMnFJM2ZXeE1oMk1saktm?=
 =?utf-8?B?TnZ3QnZraWlqTUZhNk1rMWlzbVhVR1NMd2RkUXFyWGVmQlQ5VEttdFFtZTJj?=
 =?utf-8?B?T0ZidnBGWS9oQmZKeTFpTkxLMy9BeVJaUnBsUDZWQjl1RlVYZllQdmFyaTNU?=
 =?utf-8?B?NlM1VnNZcVp6Sm1jQklEWjE2MDlKbHdaVkJWTVdmck9BM0VBb1paL28zZHdH?=
 =?utf-8?B?dU03WWRLVS84N29nSW1ESE5rc29kUDRuRVhySXpHa2dUMVl3djFDNlRnTzFa?=
 =?utf-8?B?RFAxenh6QmIyRXVZV041ZFkraWpidVVvWm92dDhxT0NlNURpenFRWXJDaTBx?=
 =?utf-8?B?cjI0QmpSbXhlQXJhajVIQ2U4MjJyUzNJbVRINDlraWhTeGNNbkQ2L2tWS0Fp?=
 =?utf-8?B?NXFwenlQcGVIUFJteXV5WmdxeW5OdkFMRWY1dUhFbzVHYnc5TTdwTEZTOUhK?=
 =?utf-8?B?QmdJTWtEWnl6Ykc0eWV3elJNN2IwRm5TTE8xenlDOUtkbzMrZE5uVjBlRDVE?=
 =?utf-8?B?bEpUa3NWRTgzMTI4U2l0OGNmMmhBTzZSTjJBRVRzODd6YzFtaVhBaVBOVkpp?=
 =?utf-8?B?K2pBYkU2TXA0b0Z0ZExISVMvM01tWURSUkYvTUd3Qmhwc01aRTFGWUNrSExY?=
 =?utf-8?B?WVdRR3lqM2Ftb3RTbnZ0b2Y2eHJYWE5uODZjejVrUllxRW9vNExUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7fe084-1812-4a6c-4ea7-08deb7101042
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 08:07:55.3116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ginfrpizNiZBKRBiOj09PXdS3XzTtiZls4n28eaZPXrLOeJL7ronSWoJoFsd2l2X8cBNHBt3X/xsNlQ4eTYN1F5H2ezxAHTvsRILZBMOIfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8373
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

SGkgTWFya3VzLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCAzMi8zOV0gTUFJTlRBSU5FUlM6IEZpeCBG
OiB0eXBvIGluICJJM0MiDQo+IA0KPiBGaXhlczogNWY2ODJkYWE2NSAoTUFJTlRBSU5FUlM6IEFk
ZCBJM0MgbWFpbnRhaW5lcnMgYW5kIHJldmlld2VyLA0KPiAyMDI2LTAyLTI1KQ0KPiBDYzogSm9l
IEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4NCj4gQ2M6IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAa2FvZC5vcmc+DQo+IENjOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gQ2M6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAg
TUFJTlRBSU5FUlMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
DQo+IGluZGV4IGIxYjI5OGZiMGUuLjc4OTliOTE2MjAgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlO
RVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0zOTY1LDcgKzM5NjUsNyBAQCBNOiBKYW1p
biBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gIFI6IE5hYmloIEVzdGVmYW4gPG5h
YmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiAgUzogTWFpbnRhaW5lZA0KPiAgRjogaHcvaTNjLyou
Yw0KPiAtRjogaHcvaTNjLy5oDQo+ICtGOiBody9pM2MvKi5oDQo+ICBGOiBody9pM2MvS2NvbmZp
Zw0KPiAgRjogaHcvaTNjL21lc29uLmJ1aWxkDQo+ICBGOiBody9pM2MvdHJhY2UtZXZlbnRzDQo+
IC0tDQo+IDIuNTQuMA0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+DQoNClRoYW5rcywNCkphbWluDQo=

