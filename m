Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C441AE9381C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9s4-0001we-Vx; Mon, 13 Apr 2026 01:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9s3-0001wG-FA; Mon, 13 Apr 2026 01:30:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9s0-0006Fp-Iz; Mon, 13 Apr 2026 01:30:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYW6N5CbTTBI1UzP0p4/+hcfdJon8HdTlg4H5fBqgtfBxN8x5nv9TdOHFQCS8gcMet+Sose+/jC8wZch4M/TlaN89t2uojvLvZrf+1YVHMbNuq2YympOiXF77s++7K33ZIDsT4A33A+/1B2YbwdUNBxJrf7fn/VNVyUDZH+08g8FZORxnACfzsfE9V3rGlBeVrx9XLaAdMt0KfJXpATSKXGQLR/SiwzS4fjraiTedCUQUVuWwlOXVOHxj04Jpg2LlpG6PAf9PpegRcpgVWCaFcCWw4FWIeRa43lpaovOlsR9pB0eDipk2eKzNzdVfIgLv+fsmCtBe4IvGJp9A5+ISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d93aLF44jOruReXuntHSn7G431dZgqsqeAUR4zHklPo=;
 b=qqQYD9x0yZb7lv0dziFxkqwUSb5ofb3lpzzbGtft4gYfbiXiB0pkz/TrkV8cEM6NnmuBPWQtkAEyc/XOevb9pVeSpFpej7tiYNaJEbwhChKRdGvmJe2IOwdFA/4YtF31CEW6pdX/rH65yWvOqx9gCeMC4l7nMg5oxl5pf51YGHst8a5e9/grp5VKo85pGjYg0zb1S1X9rZ/UZrfD3GQ4xELBWuYQQGFxm8W674aSS34Wss2EdRYIorKsd0ElmzwTXZhYIheRoUTK64Gc/Ilk5Jy90gMe/XMwS/PM1kUY/ignjFlbC5nZv7DXNXACajTVcpQ+Pux4T7MuXRuxscPzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d93aLF44jOruReXuntHSn7G431dZgqsqeAUR4zHklPo=;
 b=SmtHJ754zcFT6PnXyH8tuNWKJH9tvWvqdCuVXWdzJyDTPNqiVjyNZQByhYKtDlxRQ3oxIJhYjfsRq6B8uOEPa5xZVlGnOjNqaZEx1oDiKNU8rX9dwcYYvY9aFAOEz8PwjfPPv1AEChBXzBMkTJT0HQ77RkB9Iu88QjVJl1yLETYzbyaC7JZ+0tFebSCc7kCaA17asNtvXYEZzOUGo5bUbfsZ9PVNUKEnrIuD30vkAkA2AsyO2/+zpdYN4+V2UTKjgVsjPxLay9BV3wPYAmAPerGROE7YGD6EghVvEWsdsCBHcx+HooabipEqkYAwn29iZHZXz1+gy4ovfN2Cx//E6g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by PUZPR06MB5674.apcprd06.prod.outlook.com (2603:1096:301:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:29:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:29:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 03/13] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Topic: [PATCH v1 03/13] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Index: AQHcsShaZnUucCOzr0mk+y9iYEFGBbXcFUsAgAAH4QCAAAO7gIAAiY8w
Date: Mon, 13 Apr 2026 05:29:53 +0000
Message-ID: <TYPPR06MB8206B419C7D3BA6882CECA56FC242@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-4-jamin_lin@aspeedtech.com>
 <4253d673-02a9-45cd-9781-0f03866b9703@linaro.org>
 <6ae68fe4-6b54-433e-a9df-ae703a9c5f38@kaod.org>
 <9a15c454-c904-4c16-8ba1-14352bd9b86d@linaro.org>
In-Reply-To: <9a15c454-c904-4c16-8ba1-14352bd9b86d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|PUZPR06MB5674:EE_
x-ms-office365-filtering-correlation-id: c6f60f9b-c26e-47e5-acbf-08de991db0fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3vrBLObMFJ75tlMCvKUi5Jgu1FP645wlUCId0tKRfIvU+gehP7hqTh8Z5VcFn+idXnfxuQD5oQW7OrdFAD01154tyl22IXErkVnhArQZsi8cq7PECj/EjGxaJESh2niMu8GNzXK9Si6qbJgQUuzIpDD33iZGOex9aMyBDvTyYUnK7O7eVqletld8Qyr2CUgP1KQn9QDcJQDvIn9MY8uKj8cwk39rFJunJ/FJDk9B5snkn+jWv0C+dxyyXrwung8SflUWFjqpE3RaaZjM4hCVcV1N3QQJKE71oHDkRetSgxRI6xPuG+sM3vC07J2o1Ib0IHgxfalVsPOOgFrvVUbFdMuYu+Z8UHuHA063tCOdQ/9ZmXOKBnRoXQq0yGXzehiwk3f6/aO5a5uI8Qw/AHg3H0D+qIIfz1zmOkT234RMm6g6j8CFLrxbr33fIseqm0Jk49vwMzL52+RVA+B95G2sYfV7aaTVEdcRLdTDOqccSFATREFcZHYO/gzFZF+j3q+d19bT3+IgCGvqbxugxn3PnQlqalgBnPnfrHXJFi7CJLkjXQNIOedqjRX3Mk9R1I0YU3mq+pGVT90x3YQLbyMKw+DJveFTzv04om7/rHGltstn9dl8fd70nhMRW9kJ9/qJhimx9dDu8Usv8CI2iJ2ZlpS9zqlBy4ES22aDg55I3ifaEACr14+wlSQByxYUJDDc/P35l/5NhzDJe0CYIGx6SHeerU6kmNov9MeL7y3fNEGn1bFPqTmnoZt3wLJUdMYe4yKzvBUWVukYDu/s2K/cABmtdbdGJ/6OWPgnRXRMcRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NMRjkxaFMwK0lKcjk3ZW8vcmt6UEFmMzJSNkQ2Nk5GclFwWUJ5K1ZzRHJD?=
 =?utf-8?B?aUNZZWxYZmp3aEJvK0RzdlZUTWorcU56d2J4alhKK2JOZnVGYlpqdzYxdjhI?=
 =?utf-8?B?bzFscVp0OEJqazJWeUpwNTdzN2xhQU02MWZpVTd0U0JGOXIwc0luNFgvcTZs?=
 =?utf-8?B?QkJrZ2NielZIUXFiRFliTUgra051ZHNwSXNxanlTcFd5ODREVVc2NklKMlRi?=
 =?utf-8?B?N3h1RjJmdXRacExmUmhMaXJCMW5RTXZpZHc1MXQzbEdTejRDYkliRGVHYTlV?=
 =?utf-8?B?aXByaWRnNXBNa2lOQTJrVG1vaEVFMnZEMDZBSlpoOWVGNW1NejJBSFpHU25G?=
 =?utf-8?B?OVFkVS9kRjhkMHpWM2sxTFBGU1loRW8wYkw1L0c2NVVubVBSQkZMSUU3clRB?=
 =?utf-8?B?RCtGcW5XR1BmT3o2L3FXUHliWjYwdUU3ME8vOWkvSzdMQ0lueExxeGYvcUVW?=
 =?utf-8?B?S0tTOVdXVjZ1dVVEbGN6NCtHbit1MVRHWG9ZdXYzQ0RCQzh0SzgrUzRHTTRK?=
 =?utf-8?B?WmxYU2syeWNCdGtIWkZBaDhUejdUNWVYVmR6V0QwSWdHY0t6Rlh0enc1OUlF?=
 =?utf-8?B?RUF3dkRjZGZZYnhqRDJiOVhsYXhWNWxqOURMTFcxa3VmTzl5dTdwcG5sZWYy?=
 =?utf-8?B?YWtja3ZhTHp1N3JmQzVaOXVvZzM5bVBkMHlGYkxyT1hCbFlFWmNEZ21RQ3lH?=
 =?utf-8?B?N1QvQjlUSEtmRUtZVFJINzBsWHVxZTF6a0ZPTE5OeDIzSWtxZlZrTHZrNVJw?=
 =?utf-8?B?R3lCSnIzdEl5UC9ZMyt0QVNkbTZVRDhUWWxxdWpET2NqTzRkZEdMVHg5aVh5?=
 =?utf-8?B?QjFQNUVRd1Uxa1ZTUDY3TElsdnB0STUrc1JnNGdneFphSjIrMk55ZFhKWllk?=
 =?utf-8?B?WE1vd05DQUJyVlRYTHgwT0VrV3BOOE5LVkhnNnJzbTdXSi9Iam5icnVUKzFP?=
 =?utf-8?B?S1ZJS1FoOEpRblh1VW02UjRoQkwxa3ZaS09KaVFNTTFkWUlEdk9xYWZjbkpv?=
 =?utf-8?B?Y0F4WjJkdjBRMW5vcjkxemFNdmJOejZRcEJjR0krcy9QYUY5RXdJUjBHRlEx?=
 =?utf-8?B?ZXRJUzVoZHZmS2ZqM3JPaDMzRzQ2ZndtM0x6YU4rcW51U2ZCbFAxSEFhM3Jp?=
 =?utf-8?B?MkZWaWZ0b0cvWS9aMTZVenc0Y0N0Nlh0ZFFwNVA0OFlVWjB6cGFjaStsQXpC?=
 =?utf-8?B?Zm5Vd2htRG9KckVweEpzUGx2N3RYY2ZsQnlQME1LK3lGZUFDTXFxNkg5bmNm?=
 =?utf-8?B?QXVMZEVqZEtyQ2NoU0xRTXFvc2o5S2RSR3JBVmhreEI3anpnSERFWVJrSkxW?=
 =?utf-8?B?QXR6T3FrUWpiWHQ2WktpYTh2RlJyZVdWWEJRSFBUZkJLYU1PNlVzLzBURnlO?=
 =?utf-8?B?T0FJNHp0Lzh6ZWhSaG5YRHJQeno1dmRBbmhPaUNQd0ZqRjRhK28ySk9vWVJa?=
 =?utf-8?B?eCtuZGlGWGI5bWJLbUhwalVaRjVheFlwK2hHZXhCTGVtWjIyNEhiUy9PcGho?=
 =?utf-8?B?M0JzY1dJTGJjV3RFdDdZVlM0WFVOVFNiWkVtbUdYZU4zdnJHVVYyOXB1SXk1?=
 =?utf-8?B?SGxPdml3VnA0REM5emFGU1QvQmg4TUR6Wkl4Q2c2ZnM0TFRkQWN4ZUowbWVt?=
 =?utf-8?B?NHJ6WitWYWdCVldjZHpwYlJJZlBPT2NqNmZnVjV5bzVFZXNRd1Q2anNxa3JI?=
 =?utf-8?B?UlZ0NHhPbFBZMCtUZGxUTldMVVVDT29qa2lQZVl6VGIwcGFoUVIzdXlZdTJF?=
 =?utf-8?B?ZkVWUzh5NkVVendqdFc2bFNjeUpIcU1EbWQvM3RRQ2syMXNoNjBrdjdvcDEx?=
 =?utf-8?B?VFNwRmFUdENhQWtMaFFCbmhKY3h1L0dEaEN2S21GdjMyeWZOTVFMQ0VxYUpD?=
 =?utf-8?B?cXErOE9IdmJjQi9HQWR2NnpuTHNmNm15cVRMZCt1TUJVVWxybEZweFlPVHcy?=
 =?utf-8?B?RDg2RDNNekd0UnVHcUJtTi9QWnVUSU1yNDgyTmdBdnRqRS8yTVRuTDhJaHo4?=
 =?utf-8?B?NW9oY2NOSkFRdnJNYVpCTmZkYklxSWhwMjlUUlE5eVdhTTR5WGhBb2puM2s4?=
 =?utf-8?B?dk5ObHNKM2w5dlNJd0FpYzZtZndGN3BoTkxkcmFsRFVGdXZkY2ZrZ2ZKZ1lB?=
 =?utf-8?B?SzlRNTY4Zk5ucmNJZy8xaGlzYjlLTC9neXU1dGxMQ3FmcDUvLzBzK3E3clpv?=
 =?utf-8?B?STdyM2VXRHI1NVRtaWFDdVRhaExaUTFKRDZjZDRYeWlmQXBpVXl2UG5uY0NE?=
 =?utf-8?B?VWozWWxDRHJrb3ljZVY0dWdEcGRQeXE2QnprR2NsYThrWmNBcUZ6SzM5RlBF?=
 =?utf-8?B?cHUrVi9NMk5YT1play94MkJQTGRNQW4xOUNqc3NRbWt2bjVDMTBZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qyTBTAIF0DNMEhCb5CvwIH/4iBGaNhab8BtuUFKQSdiyBmV6121QCfr6QdFzpJjmVO7T5mTPX7i4VlWsDQdRXi3IQuiTtuNxqJ19yCwij2O+B2W4C5gzXOikAPSFMDEx+SCL/0hyQb6svk4nHJ2mBal8e7mAiemWAwn3u+2beApgJt5ILyFP4a+4va25kp8lTVjbgkcl+fgwrAIqju4axXA0lLu+FB6c9gGFzRcB/BmXG5CcU5AQ0c2EATc24OYVToZVBL1VC3R/GUzfOmjbyF6DQyMfw8u2EcUD82cSuB7PnybR8PRu9IWcAMNcF/YecwObeMvkg7SnH9o4e9VSOg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f60f9b-c26e-47e5-acbf-08de991db0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:29:53.5034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Sm92oYdgzw/d8xjmGcN7r0iJu+f63ALATOjkbNp9I4iBd/GoN2eLfT1A6EhRxOwfKokGwo0x3VJMEU4YVcR2fCa6DZMwpQx/4sJiYblov0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5674
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgUGhpbGlwcGUgYW5kIEPDqWRyaWMsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMy8x
M10gaHcvdXNiL2hjZC1laGNpOiBDaGFuZ2UgZGVzY3JpcHRvciBhZGRyZXNzZXMgdG8NCj4gNjQt
Yml0DQo+IA0KPiBPbiAxMi80LzI2IDIzOjAzLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4g
PiBPbiA0LzEyLzI2IDIyOjM0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPj4g
SGkgSmFtaW4sDQo+ID4+DQo+ID4+IE9uIDExLzMvMjYgMDg6MjYsIEphbWluIExpbiB3cm90ZToN
Cj4gPj4+IENoYW5nZSBpbnRlcm5hbCBFSENJIGRlc2NyaXB0b3IgYWRkcmVzc2VzIGZyb20gdWlu
dDMyX3QgdG8gdWludDY0X3QuDQo+ID4+Pg0KPiA+Pj4gVGhlIGZvbGxvd2luZyBmaWVsZHMgYXJl
IHVwZGF0ZWQ6DQo+ID4+PiAtIEVIQ0lQYWNrZXQ6OnF0ZGFkZHINCj4gPj4+IC0gRUhDSVF1ZXVl
Ojp7cWhhZGRyLCBxdGRhZGRyfQ0KPiA+Pj4gLSBFSENJU3RhdGU6OnthX2ZldGNoX2FkZHIsIHBf
ZmV0Y2hfYWRkcn0NCj4gPj4+DQo+ID4+PiBVcGRhdGUgZ2V0X2R3b3JkcygpIGFuZCBwdXRfZHdv
cmRzKCkgdG8gdGFrZSA2NC1iaXQgYWRkcmVzc2VzIGFuZA0KPiA+Pj4gcHJvcGFnYXRlIHRoZSB0
eXBlIGNoYW5nZSB0aHJvdWdoIHRoZSBkZXNjcmlwdG9yIHRyYXZlcnNhbCBwYXRocy4NCj4gPj4+
DQo+ID4+PiBBZGp1c3QgTkxQVFJfR0VUKCkgdG8gb3BlcmF0ZSBvbiA2NC1iaXQgdmFsdWVzOg0K
PiA+Pj4NCj4gPj4+IMKgwqDCoMKgICNkZWZpbmUgTkxQVFJfR0VUKHgpICgoeCkgJiB+KHVpbnQ2
NF90KTB4MWYpDQo+ID4+Pg0KPiA+Pj4gc28gdGhhdCBsaW5rIHBvaW50ZXIgbWFza2luZyB3b3Jr
cyBjb3JyZWN0bHkgd2hlbiBkZXNjcmlwdG9yDQo+ID4+PiBhZGRyZXNzZXMgZXhjZWVkIDMyLWJp
dCBzcGFjZS4gVGhlIHByZXZpb3VzIG1hc2sgKDB4ZmZmZmZmZTApDQo+ID4+PiBpbXBsaWNpdGx5
IHRydW5jYXRlZCBhZGRyZXNzZXMgdG8gMzIgYml0cy4NCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNo
IGRvZXMgbm90IGNoYW5nZSB0aGUgb24td2lyZSBkZXNjcmlwdG9yIGxheW91dCB5ZXQuDQo+ID4+
PiBJdCBvbmx5IHJlbW92ZXMgdGhlIGludGVybmFsIDMyLWJpdCBhZGRyZXNzIGxpbWl0IGFuZCBw
cmVwYXJlcyBmb3INCj4gPj4+IGxhdGVyIHBhdGNoZXMgdGhhdCB3aWxsIGFkZCBmdWxsIDY0LWJp
dCBRSC9xVEQvaVREL3NpVEQgc3VwcG9ydC4NCj4gPj4+DQo+ID4+PiBTaW5jZSB0aGUgdHlwZSBv
ZiBmZXRjaF9hZGRyIGNoYW5nZXMgZnJvbSAzMi1iaXQgdG8gNjQtYml0LCBidW1wIHRoZQ0KPiA+
Pj4gVk1TdGF0ZSB2ZXJzaW9uLg0KPiA+Pj4NCj4gPj4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0K
PiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRl
Y2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiDCoCBody91c2IvaGNkLWVoY2kuaCB8IDEwICsrKy0t
LS0NCj4gPj4+IMKgIGh3L3VzYi9oY2QtZWhjaS5jIHwgNjcNCj4gPj4+ICsrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+PiDCoCAyIGZpbGVzIGNoYW5n
ZWQsIDQxIGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+Pg0KPiA+Pj4g
QEAgLTI0ODQsOCArMjQ4OSw4IEBAIHN0YXRpYyB2b2lkIHVzYl9laGNpX3ZtX3N0YXRlX2NoYW5n
ZSh2b2lkDQo+ID4+PiAqb3BhcXVlLCBib29sIHJ1bm5pbmcsIFJ1blN0YXRlIHN0YXRlKQ0KPiA+
Pj4gwqAgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfZWhjaSA9IHsNCj4gPj4+IMKg
wqDCoMKgwqAgLm5hbWXCoMKgwqDCoMKgwqDCoCA9ICJlaGNpLWNvcmUiLA0KPiA+Pj4gLcKgwqDC
oCAudmVyc2lvbl9pZMKgID0gMiwNCj4gPj4+IC3CoMKgwqAgLm1pbmltdW1fdmVyc2lvbl9pZMKg
ID0gMSwNCj4gPj4+ICvCoMKgwqAgLnZlcnNpb25faWTCoCA9IDMsDQo+ID4+PiArwqDCoMKgIC5t
aW5pbXVtX3ZlcnNpb25faWTCoCA9IDIsDQo+ID4+DQo+ID4+IFNpbmNlIHRoaXMgZGV2aWNlIGlz
IHVzZWQgaW4gY2xvdWQgdmlydHVhbGl6ZWQgaW5zdGFuY2VzLCB3ZSBjYW4gbm90DQo+ID4+IGln
bm9yZSBwcmV2aW91cyBtaWdyYXRpb24gc3RyZWFtcyBhbmQgcmVhbGx5IG5lZWQgdG8gaW1wbGVt
ZW50IHRoZSB2Mg0KPiA+PiB0byB2MyBob29rLg0KPiA+DQo+ID4gV2Ugd2lsbCBuZWVkIDoNCj4g
Pg0KPiA+ICvCoMKgwqAgdWludDMyX3QgYV9mZXRjaF9hZGRyX2hpOw0KPiA+ICvCoMKgwqAgdWlu
dDMyX3QgcF9mZXRjaF9hZGRyX2hpOw0KPiA+DQo+ID4gdG8gYmUgc2V0IGJ5IHByZV9zYXZlLCBh
bmQgdXNlZCBieSBwb3N0X2xvYWQgdG8gcmVjb25zdHJ1Y3QgNjQtYml0DQo+ID4gYWRkcmVzc2Vz
LiBUaGlzIGlzIGdvaW5nIHRvIGJlIHRlZGlvdXMgLi4uDQo+IA0KPiBXb3VsZCBzb21ldGhpbmcg
aW4gdGhvc2UgbGluZXMgd29yaz8NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3Vn
Z2VzdGlvbnMuDQpJIHdpbGwgdHJ5IHRoaXMgc29sdXRpb24uDQpKYW1pbg0KDQo+IC0tID44IC0t
DQo+IGRpZmYgLS1naXQgYS9ody91c2IvaGNkLWVoY2kuYyBiL2h3L3VzYi9oY2QtZWhjaS5jIGlu
ZGV4DQo+IDU3ZjkzMGIwOTk4Li5jMjI4ZDRhOGM2ZCAxMDA2NDQNCj4gLS0tIGEvaHcvdXNiL2hj
ZC1laGNpLmMNCj4gKysrIGIvaHcvdXNiL2hjZC1laGNpLmMNCj4gQEAgLTI0MzksNiArMjQzOSwx
MCBAQCBzdGF0aWMgaW50IHVzYl9laGNpX3Bvc3RfbG9hZCh2b2lkICpvcGFxdWUsIGludA0KPiB2
ZXJzaW9uX2lkKQ0KPiAgICAgICAgICAgICAgIGNvbXBhbmlvbi0+ZGV2ID0gTlVMTDsNCj4gICAg
ICAgICAgIH0NCj4gICAgICAgfQ0KPiArICAgIGlmICh2ZXJzaW9uX2lkIDwgMykgew0KPiArICAg
ICAgICBzLT5hX2ZldGNoX2FkZHIgPSBzLT5hX2ZldGNoX2FkZHJfcHJlX3YzOw0KPiArICAgICAg
ICBzLT5wX2ZldGNoX2FkZHIgPSBzLT5wX2ZldGNoX2FkZHJfcHJlX3YzOw0KPiArICAgIH0NCj4g
DQo+ICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4gQEAgLTI0NzEsNyArMjQ3NSw3IEBAIHN0YXRp
YyB2b2lkIHVzYl9laGNpX3ZtX3N0YXRlX2NoYW5nZSh2b2lkDQo+ICpvcGFxdWUsIGJvb2wgcnVu
bmluZywgUnVuU3RhdGUgc3RhdGUpDQo+IA0KPiAgIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2
bXN0YXRlX2VoY2kgPSB7DQo+ICAgICAgIC5uYW1lICAgICAgICA9ICJlaGNpLWNvcmUiLA0KPiAt
ICAgIC52ZXJzaW9uX2lkICA9IDIsDQo+ICsgICAgLnZlcnNpb25faWQgID0gMywNCj4gICAgICAg
Lm1pbmltdW1fdmVyc2lvbl9pZCAgPSAxLA0KPiAgICAgICAucHJlX3NhdmUgICAgPSB1c2JfZWhj
aV9wcmVfc2F2ZSwNCj4gICAgICAgLnBvc3RfbG9hZCAgID0gdXNiX2VoY2lfcG9zdF9sb2FkLA0K
PiBAQCAtMjUwMCw4ICsyNTA0LDEwIEBAIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRl
X2VoY2kgPSB7DQo+ICAgICAgICAgICAvKiBzY2hlZHVsZSBzdGF0ZSAqLw0KPiAgICAgICAgICAg
Vk1TVEFURV9VSU5UMzIoYXN0YXRlLCBFSENJU3RhdGUpLA0KPiAgICAgICAgICAgVk1TVEFURV9V
SU5UMzIocHN0YXRlLCBFSENJU3RhdGUpLA0KPiAtICAgICAgICBWTVNUQVRFX1VJTlQzMihhX2Zl
dGNoX2FkZHIsIEVIQ0lTdGF0ZSksDQo+IC0gICAgICAgIFZNU1RBVEVfVUlOVDMyKHBfZmV0Y2hf
YWRkciwgRUhDSVN0YXRlKSwNCj4gKyAgICAgICAgVk1TVEFURV9VSU5UMzJfVEVTVChhX2ZldGNo
X2FkZHJfcHJlX3YzLCBFSENJU3RhdGUsIDIpLA0KPiArICAgICAgICBWTVNUQVRFX1VJTlQzMl9U
RVNUKHBfZmV0Y2hfYWRkcl9wcmVfdjMsIEVIQ0lTdGF0ZSwgMiksDQo+ICsgICAgICAgIFZNU1RB
VEVfVUlOVDY0KGFfZmV0Y2hfYWRkciwgRUhDSVN0YXRlKSwNCj4gKyAgICAgICAgVk1TVEFURV9V
SU5UNjQocF9mZXRjaF9hZGRyLCBFSENJU3RhdGUpLA0KPiAgICAgICAgICAgVk1TVEFURV9FTkRf
T0ZfTElTVCgpDQo+ICAgICAgIH0NCj4gICB9Ow0KPiAtLS0NCg==

