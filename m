Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB15EC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1I32-0008Ae-3u; Tue, 01 Sep 2026 02:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x1I2z-0008AG-Tf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:32:41 -0400
Received: from mail-francesouthazon11011043.outbound.protection.outlook.com
 ([40.107.130.43] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x1I2x-0007MQ-TK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQDf/rHB5vyAXWJtr8sdjYgixHHdyAdJrsftTdMlFy6viemCiFq3oxgshJMEXRPtS4Uq71J9nt8YLuPibEDQXZHstnOjqHBpUl/8L3GmyZK4eRCk+8/+yj7EQywna0YFm15El/LQwRngdZdYNL7MU4ewg5IweksFJOHbSR0LDBIivX0OyPct0dEm1L3NmiTvw4dzMIvMwTpyRjT2i9GVwroopG0aoXtGYOd0KDYx21Rztrj4BfvIcOFfJ38t7Fxj4Yd0VkcXpE7TiJQRvowrbYGSeiRBFYgFa9LtI9Kyqh1plsFBxGYVCXATbe6ff8VkhiKI+b2urTYhJqYQe/ns6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb+SkbCwf9f7gOJfd5pCUCKOjV1HrIXVWhMnf4KW5v4=;
 b=Zo49gSNqkn12UQKuALdRjHGKo8kZfIGOP5P5PPUQvOSBwie9N099AQ840fHyl1cdGfC0VU2NCTdSoIQk/P8NJsYW33slpWaXbDfpHrCTH/lZnAdMs9/UJkCvqZFq1ItZm15CRILdt8fEbRs0OLuOtmcu2P0rB9zea3bsG7GJr7beakmVttg26BT4u0lOBnqrlQ09tsDrpu3pYRXib+Y9aaiVkhDt6vwnuR74pnepfSqr8XJU+sjqtA0VYRAg2kbg8MJkzEPSXRxI8vvB7rg5f5qaIa1QsRvvBPGt0t06Xr/+0fzBbZuDSyPLgYzUzg82ZBsvatrAhrVh3u16VhFi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb+SkbCwf9f7gOJfd5pCUCKOjV1HrIXVWhMnf4KW5v4=;
 b=LFuuPHfnH34uXpSIMcFjNEmXd8UaJfjbFjVetoQnTAfDXJ2ZOeLtk4DKfMfJTqvt6PUIphpqyCKh6m7IhbTr4+BgiAS5Ex5Z7TmHpD5Mn8UP/InbcoZ8VbVrACmTJovtjDzPI0wpDQwZoeizNYU8Ywr5MzDScWIavvDY+KKbI1BOzF0zEyti+x0+BagebSP9ndCw9AgjpZNl7M5lrY01XfJmbmWLqhbmtGvV+h0M3d2rFj+gGxIsW7olGanUTHw++xcwV2Tg4Dv+ueFmXcDMPgkjvX+B0iATVfR/i3yaNbYVMUj3IVBzp6tMmm/R17BxZl8qYv2fw6cAKBBWHbqWyg==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 1 Sep
 2026 06:27:33 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:27:32 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv2 7/7] tests/functional: Enable Cortex-M7 boot
 in i.MX8MP EVK functional test
Thread-Topic: [EXT] Re: [PATCHv2 7/7] tests/functional: Enable Cortex-M7 boot
 in i.MX8MP EVK functional test
Thread-Index: AQHdDWSRGYDu73v5CEWfK7lCFdn7dra4yOuAgADRwBA=
Date: Tue, 1 Sep 2026 06:27:32 +0000
Message-ID: <DB8PR04MB717719BFA03B4ED19860E76387A82@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <20260706162859.3361063-8-gaurav.sharma_7@nxp.com>
 <5F842A4E-B642-41BB-BC19-8685F281D5F9@gmail.com>
In-Reply-To: <5F842A4E-B642-41BB-BC19-8685F281D5F9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-09-01T06:27:14.0000000Z;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public; MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|VI1PR04MB9929:EE_
x-ms-office365-filtering-correlation-id: db19c90e-652b-4f06-1ea3-08df07f21b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|38070700021|56012099006|4143699003|6133799003|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: A5Q2Pl4ZRBB2uNh+MEXezK/z0EZQdoSI8kFBfRXe/X8GZyMyFzkI8P2RniJq/2UemTBObtIhQyAmtX1QK0hhAYw0oYan2SDdyeYjV6JO3pBgAxqS+MbLKxuv4qQAGahNlVVweFzcHGU+QZmSm1sFaZj9nLGyh9A/lM/H2pxtNMJ0/vkNYIg43jX41kWPbgXNaLyWuwV/mOAG6CsTlEFUzOrM6kPc/tILCcdbaD6IJ0NXhpSNWdg4Y/FOyTJsQYQEHQtlWcKrQGHmbdPGBHmICjHEQS12LQlQW18SHEcHHCkHxBGgnyR6OFzD2jqlC9GPppugBe1XLO1bV+LWpVaLo56ckjd+5Hg1XOcoD6H6OwKr9+b0EKTxY2VPFy3qDf26xDC/VXE0jZBMQhor4NfBmUSfZfuFRDngRqELYo4IJKuePiEr6N2aHZEZuK18GLu7moN1fvd9KjrxrlmWl8nuwJGKj+M5l2EknKkdVDU75pwNAwUm7nxRaabp6ESKgqNdxyzBVkHRMBBoxpR1puQpaxZIbiLiWxnXSI66FfJ/2sN4xSchjzNF0yIrCyO/QN5aM5nlPzr5EmT7y0+9OM34sxQqRoPDas+UOOXesykz3Fyt1NQ7XihYCfqSlhFvudxKIBHWuFG5EBvCRhf+ux2Zosb5OlFQv+s2mq4yr2Oy+QNU8uD52TzPZ6iC8W9Ik/H9GI2eCAsm2nlhD5wVed/pqcV3FGSXurhzedjq7H4EpiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(38070700021)(56012099006)(4143699003)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekRIQ0NVdXhUK2wxUDZuYmlzRFJSTGZaT1VBSSt3ZENPTUtuYnJXSDhPOTlY?=
 =?utf-8?B?OHJnejlSQ1V2MVRJWC9DUUJQRFVkb2JpZU5aelBVN0VyRSs3SStNMnZHcmox?=
 =?utf-8?B?M3hIdTJUV0piczNUbFo3QmJWNUdoRUFLWHk5NlV1Z2R4V2lvZlUxTy9POGV6?=
 =?utf-8?B?cGoxUkFSYjNQZzRxN29HRENZcU1aU2ZUQkh0QnpkRXFvUUYvZ3pKc2xLelcx?=
 =?utf-8?B?UnAvTE03aTFMQ3lOS0tTa01pSmRSS0hyUDBKVGszZ3EycVJlVzEvaEtuR1J2?=
 =?utf-8?B?WTcrU1B5dzdqbWlTNEY1R1FTSGxOSVNUV0pLZWsvcDdEZXhMSEM3MkxNODRL?=
 =?utf-8?B?RjJ0TDNzYmJoS2ZJclh4S2d5RGFLTU9Da3hQV0hYdWlmaUIya0hCYTVZZW1G?=
 =?utf-8?B?RGpWMHV0dHdjQUdBNlBlME9zTjdYN3NURmluejlzZGs5d2ZQeWNLOGNDWVQ2?=
 =?utf-8?B?MVQraURUWG9zZ202WHBHT0h5QU9DMGthZTM2QU1iM2F0MTI4a0QweURCTnBs?=
 =?utf-8?B?Z0tmY1ZKQVhUdzdacW4zSU1QY25XTkd2d1RUZENRdThoenhkTUU0QkJMSkM3?=
 =?utf-8?B?aXNNZjZ0c1VwNkQ1ZW5tM1NYd3g5NXVXQkRHbFJGUGZLK3VwbTJraHpIQ3Rl?=
 =?utf-8?B?QTNqaTJGYVV0WXJteTZSZEsyVUpzK0pHWDJnTVJoQWZ4WERWTXJEOEIyUzF2?=
 =?utf-8?B?NzFySUh1VFdFN1NjVWllamJkSEN6VDl3OEtLMG9LdkcrSTNrZXgxZFRlL3Yz?=
 =?utf-8?B?TGNHZzJBWS9Ic0VyUFhCMitaYWVsRm1oNlJSbU5Oa0FBcmVFRUNVZ1lpWnFo?=
 =?utf-8?B?NktvSE80YVZCenAwQ1ZsOW95OFhpWW1DM1ZNSTZEUENVSzZ0cEhMSGxZdHps?=
 =?utf-8?B?ZEFkOU9vTENFMXRIZWdyOHlHQVM5dE44NmZpY2I2UEtxcjlYOGMrV1doajFU?=
 =?utf-8?B?MFE3Zy8zZ0tnUlprU2l6eU80UHlzNVRJTkwyaE12M04vYUFRNlVMZUppTjRn?=
 =?utf-8?B?OW1NcThrUVlsZmIrdTR0YkZGUGxHY3BEWmlPSTZ0ZnEyNUUxMHRweEU1Z1Uy?=
 =?utf-8?B?bUk4cGFQa2VQeUhoUlpRaWUvUUNiaERUbU1TRXpqU0dBS0VTWkRaa3kvS0JE?=
 =?utf-8?B?RU9QRE5JYnlHaldYdWNTa3BxSVQ1eGh3dnlUSXgyTzFZQ0QwQ0pIV04rV2xZ?=
 =?utf-8?B?cGZRVE1ncG5TdEFTYmlnNVc1eXRTZGYyV05ia0J6Ym5hSC9PaUJ3YlRqLy90?=
 =?utf-8?B?NHJpZVhWVWxpdGJQdEdXSTRacXh2cEhPZEMrVVVUaDZLbk1xd0RiYmFkSGVv?=
 =?utf-8?B?YU9NWXVjWTVPWVNPRjVBazNpb3EzRU0rMHFtUjdOeGpuRmE4YWd4WEJWMEdZ?=
 =?utf-8?B?K21KQU1ybjVJSlZZUG9pcUlSV3BvNW5QRVdVQUgwUzU1N0dyeGZ2M2dBajh6?=
 =?utf-8?B?RDd1OEQyWXA1YTNhVS9Wb1hiMjI2aVZCbWUvTERMTXBWenR3b04vWEZtWHVr?=
 =?utf-8?B?S3NrRFRRR3JVVHNkU0E4aTZmWTBLU0kvaDZlRUladmEyZ0lGRTljNU8vUTRr?=
 =?utf-8?B?TjZhWnVrcU5ZSDN2Tlc4anVwWldiUlNtNmo1eEVUNklrdnJQTjRxWjczQWpY?=
 =?utf-8?B?YWppekZPZ09ONjVRUGZNNXNwd1FjQnM0SnY2UG5EekZoUFhDWFdsR3RUck1O?=
 =?utf-8?B?RmFQdHBuVXdMVTdDQXltL2c5VDBadGJzM2tvMkg4dEdYQ3hTb1IvSFpqZ1Bt?=
 =?utf-8?B?ZGJPcDNLdVVWWGFlRXRYVjdoUG9yQW1hOTJSU0VnUTRGQlBhalRUcVZ1RzZQ?=
 =?utf-8?B?em9BdGlYb1ZyYzZVZXc4VnA2SElGZ283ekpPWjR5dk4vQUZzakhCRmI2SHVp?=
 =?utf-8?B?NXdVc2U1TXdSd0NNc0cxT1Y3WTRXVmZjRDFSMnRQbk4zZE4zVGtaZElnc1RV?=
 =?utf-8?B?QVlnZFNyY290a3FaNUNiYW9scFlYZ1JvYk9hS3VOV3BmbXVUK1JodnVxRHYz?=
 =?utf-8?B?RUFWTWs3TVZnc3lJRFJiRmQ3VExYcFJHSGFZTTAxLzBiUmxwZFFPU3oxeXhz?=
 =?utf-8?B?K1pIb0NmL29vUXAxN3U0cnhJZlh6Mkkrb0lsYys1N3QxVE1HejRhTTlnK01w?=
 =?utf-8?B?aGJOZ3k5emtQNFViNzhQME84TEdDRlhtQzcvaUJEVmFDRHIrNXBqNzkyU2pC?=
 =?utf-8?B?V1NiYjNqK0U1U2hIRWF6eGQ2NWVFL2plRFV6bElPVURnYUpBNWpDTXA0Mk95?=
 =?utf-8?B?Njh2WjlkbVpwNHVKK0ZZNi9lMjhobko1a2Facm9tVVVWa05BbFlabkpCblE2?=
 =?utf-8?B?MDdiZXozUHJZT3VIb0szRlBVUktTUXBML3JGVFBxMkNRQUhLT1l0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db19c90e-652b-4f06-1ea3-08df07f21b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 06:27:32.9350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pS/giaXC1av/0DvDGrvxBz/uZhuSGQifGN4Vy8C5XFlwfk2AcyuuNyrRuQtj0KI836e9TtaWPyMUaUfH2/pwOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929
Received-SPF: pass client-ip=40.107.130.43;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

DQoNCg0KTlhQIFB1YmxpYw0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBC
ZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdtYWlsLmNvbT4NCj4gU2VudDogMzEgQXVndXN0IDIw
MjYgMjM6MjUNCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgR2F1cmF2IFNoYXJtYSA8Z2F1
cmF2LnNoYXJtYV83QG54cC5jb20+DQo+IENjOiBwYm9uemluaUByZWRoYXQuY29tOyBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSHYyIDcvN10gdGVz
dHMvZnVuY3Rpb25hbDogRW5hYmxlIENvcnRleC1NNyBib290IGluDQo+IGkuTVg4TVAgRVZLIGZ1
bmN0aW9uYWwgdGVzdA0KPg0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQ
bGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2ht
ZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0
DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBBbSA2LiBKdWxpIDIwMjYgMTY6Mjg6NTkg
VVRDIHNjaHJpZWIgR2F1cmF2IFNoYXJtYQ0KPiA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+Og0K
PiA+VXBkYXRlIHRoZSBpLk1YOE1QIEVWSyBmdW5jdGlvbmFsIHRlc3QgdG8gZW5hYmxlIHRoZSBD
b3J0ZXgtTTcgY29yZSBieQ0KPiA+c2V0dGluZyBtYXhjcHVzPTUgYW5kIGVuYWJsaW5nIHRoZSBm
c2wtaW14OG1wLmVuYWJsZS1jbTcgcHJvcGVydHkgVGhlDQo+ID5pLk1YOE1QIFNvQyBtb2RlbCBt
YWtlcyB0aGUgQ29ydGV4LU03IG9wdGlvbmFsIGFuZCBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiA+
DQo+ID5TaWduZWQtb2ZmLWJ5OiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNv
bT4NCj4gPi0tLQ0KPiA+IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAxMyArKysrLS0tLS0tLS0tDQo+ID4gdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3Rf
aW14OG1wX2V2ay5weSB8ICAxIC0NCj4gPiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTDQo+ID5pbmRleCA5N2RjYzc4ZGVkLi5mZTkyMWEyOGRlIDEwMDY0NA0KPiA+LS0t
IGEvTUFJTlRBSU5FUlMNCj4gPisrKyBiL01BSU5UQUlORVJTDQo+ID5AQCAtOTIxLDI5ICs5MjEs
MjQgQEAgRjogaHcvcGNpLWhvc3QvZGVzaWdud2FyZS5jDQo+ID4gRjogaW5jbHVkZS9ody9wY2kt
aG9zdC9kZXNpZ253YXJlLmgNCj4gPiBGOiBkb2NzL3N5c3RlbS9hcm0vbWNpbXg3ZC1zYWJyZS5y
c3QNCj4gPg0KPiA+LU1DSU1YOE1NLUVWSyAvIGlNWDhNTQ0KPiA+K01DSU1YOE1QLUVWSyAvIE1D
SU1YOE1NLUVWSw0KPiA+K006IEJlcm5oYXJkIEJlc2Nob3cgPHNoZW50ZXlAZ21haWwuY29tPg0K
PiA+IE06IEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPg0KPiA+IEw6IHFl
bXUtYXJtQG5vbmdudS5vcmcNCj4gPiBTOiBNYWludGFpbmVkDQo+ID4gRjogaHcvYXJtL2ZzbC1p
bXg4bW0uYw0KPiA+IEY6IGh3L2FybS9pbXg4bW0tZXZrLmMNCj4gPi1GOiBpbmNsdWRlL2h3L2Fy
bS9mc2wtaW14OG1tLmgNCj4gPi1GOiBkb2NzL3N5c3RlbS9hcm0vaW14OG0ucnN0DQo+ID4tRjog
dGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfaW14OG1tX2V2ay5weQ0KPiA+LQ0KPiA+LU1D
SU1YOE1QLUVWSyAvIGkuTVg4TVANCj4gPi1NOiBCZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdt
YWlsLmNvbT4NCj4gPi1MOiBxZW11LWFybUBub25nbnUub3JnDQo+ID4tUzogTWFpbnRhaW5lZA0K
PiA+IEY6IGh3L2FybS9pbXg4bXAtZXZrLmMNCj4gPiBGOiBody9hcm0vZnNsLWlteDhtcC5jDQo+
ID4gRjogaHcvbWlzYy9pbXg4bXBfKi5jDQo+ID4gRjogaHcvcGNpLWhvc3QvZnNsX2lteDhtX3Bo
eS5jDQo+ID4gRjogaHcvcnRjL3JzNWMzNzIuYw0KPiA+K0Y6IGluY2x1ZGUvaHcvYXJtL2ZzbC1p
bXg4bW0uaA0KPiA+IEY6IGluY2x1ZGUvaHcvYXJtL2ZzbC1pbXg4bXAuaA0KPiA+IEY6IGluY2x1
ZGUvaHcvbWlzYy9pbXg4bXBfKi5oDQo+ID4gRjogaW5jbHVkZS9ody9wY2ktaG9zdC9mc2xfaW14
OG1fcGh5LmgNCj4gPiBGOiBkb2NzL3N5c3RlbS9hcm0vaW14OG0ucnN0DQo+ID4rRjogdGVzdHMv
ZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfaW14OG1tX2V2ay5weQ0KPiA+IEY6IHRlc3RzL2Z1bmN0
aW9uYWwvYWFyY2g2NC90ZXN0X2lteDhtcF9ldmsucHkNCj4gPiBGOiB0ZXN0cy9xdGVzdC9yczVj
MzcyLXRlc3QuYw0KPiA+DQo+DQo+IFRoaXMgcGFydCBMR1RNLCB0aG91Z2ggdGhlIGNvbW1pdCBt
ZXNzYWdlIHNob3VsZCBtYXRjaC4NCj4NCj4gPmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L2FhcmNoNjQvdGVzdF9pbXg4bXBfZXZrLnB5DQo+ID5iL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2
NC90ZXN0X2lteDhtcF9ldmsucHkNCj4gPmluZGV4IDk5ZGRjZGVmODMuLjYwNDZjNTczZDUgMTAw
NzU1DQo+ID4tLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9pbXg4bXBfZXZrLnB5
DQo+ID4rKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9pbXg4bXBfZXZrLnB5DQo+
ID5AQCAtNTMsNyArNTMsNiBAQCBkZWYgdGVzdF9hYXJjaDY0X2lteDhtcF9ldmtfdXNkaGMoc2Vs
Zik6DQo+ID4gICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdpbXg4bXAtZXZrJykNCj4gPiAgICAg
ICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoY29uc29sZV9pbmRleD0xKQ0KPiA+ICAgICAgICAgc2Vs
Zi52bS5hZGRfYXJncygnLW0nLCAnMkcnLA0KPiA+LSAgICAgICAgICAgICAgICAgICAgICAgICAn
LXNtcCcsICc0JywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgJy1rZXJuZWwnLCBzZWxm
Lmtlcm5lbF9wYXRoLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAnLWluaXRyZCcsIHNl
bGYuaW5pdHJkX3BhdGgsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICctZHRiJywgc2Vs
Zi5kdGJfcGF0aCwNCj4NCj4gVGhpcyBodW5rIHNob3VsZCBnbyBpbnRvIHRoZSBuZXcgcGF0Y2gg
d2hpY2ggZml4ZXMgdGhlIFNNUCBjb25maWd1cmF0aW9uLg0KPg0KDQpPa2F5LCBJIHdpbGwgYWRk
IGEgbmV3IHBhdGNoIGFzIHBhcnQgb2YgdGhlIG5leHQgcGF0Y2ggc2VyaWVzIGZvciB0aGlzLg0K
DQo+IEJlc3QgcmVnYXJkcywNCj4gQmVybmhhcmQNCg==

