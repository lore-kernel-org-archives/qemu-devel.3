Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33C3CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 02:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQFEF-0008SB-KT; Thu, 21 May 2026 22:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wQFE9-0008R7-JX; Thu, 21 May 2026 22:03:05 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wQFE6-0006S9-IW; Thu, 21 May 2026 22:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icp4STVAb4zCdBq4GOFBoUg6ZPxefswiVLcz+Hno12XKdi0UNIlaAvW9BocN4ZEXGBMJ9lc2r/Dom9i22Hn738g6GX735ekuE/d1CfHRPSVQjf3THVNV5xpyHzhbqIFpbRbzjvza0kRV7QkrC8Konm1WqH9l7mOF7MkA4jvbjKaJkhBtRT7el1WltjUlrTs+1x5KiTDqvstIqHcrIPMWoEykEZSp/gocUH6Td2dtkDN411nos8Od4G59h9ImjM2YMAWgWcPBLcC8qpe7srE9TtNPwE8n3NHn6ItqXJxxWgXwGgtWxttJxxZQ6qWu94cpND706HQ42LOqTNBK8vwocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rzXMVa3AhliELcpV9EMP06hiFpMHA/7zkE+XtUnvsI=;
 b=ekkIlATjozZSqEUqh8bk8FyXuAmD7qJVXglGUZj3q6fTr9L/aHR/yXdn6WQCKB5g8FZXoCCA7sLqeb2frRovqY4mCFH6z+kDEGQxrzRsnPVpFRYiayP7mYNyFdVeHuOph74ApLpNnJGEzIgRHazJsjwqgNcOw6/pzP6KhzwRQVvdNzufx3qbwrhRwmF3jh4RVoVbnTyjhwyrV70fS5wZ2YMoqwzRPdHrSMaVF0VSCfK96cEVUFxnv1CVma6k3o47/wnyfssVDz6iPosN+cHgxDztXPFK0FndCQgo678lxjoOU2F+e6zRBA6v5HmjwWOY0fB7mo/ynfTWd4upGBCDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rzXMVa3AhliELcpV9EMP06hiFpMHA/7zkE+XtUnvsI=;
 b=JiZ/47hFPbDh77JOr+cnP+oVmaWycvaSi5USFlXRSnF2zqHFlm5mZTXxfADNMIoNYzu5smvJ9FgOMQBzvBTkKP431LgEfw4fZ/cg4Uc3NcoubEIKhKxj7Oa88rNsPoOymMnVr6Nd12Y/WtOt8tWLh7SG72DRjOHfjb7E5D/oOGJl7WdS+O+V+Ww3Av7DK7eJ0WW07esloffme/H3GnD5wJUqS3d4OEWn7ryDk9Y5rMOOkyJXemuofAqOxYIY0s6P7enpniqb/daKSY/hxdP+5Ei57jqzmkfo2e4ZF20cRenVX8VltgXgSfD5hqsamOcJpcs1srBwHWGwefxu2lai5w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5381.apcprd06.prod.outlook.com (2603:1096:4:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 02:02:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 02:02:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 4/4] hw/arm/aspeed: Add AST1040 EVB machine model
Thread-Topic: [PATCH v1 4/4] hw/arm/aspeed: Add AST1040 EVB machine model
Thread-Index: AQHc6O5Y6WhPqNo/U0yF7Y1TsizpuLYYLbSAgAEeZ7A=
Date: Fri, 22 May 2026 02:02:52 +0000
Message-ID: <TYPPR06MB8206CDAB1888CD8B0910001FFC0F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260521065203.3713466-1-jamin_lin@aspeedtech.com>
 <20260521065203.3713466-5-jamin_lin@aspeedtech.com>
 <14262972-3693-4fdb-81cf-695f230d184c@kaod.org>
In-Reply-To: <14262972-3693-4fdb-81cf-695f230d184c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5381:EE_
x-ms-office365-filtering-correlation-id: 0038b989-9c92-4a4b-3e49-08deb7a63bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|4143699003|6133799003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 6OyBHpEkiKoGnYNbJdbH9c5wRashgMqnZj5pd6pkCth6NtJTaf8hJCzV3etyFsho1vfqyRD45vQ2+HgW9KpujIY8kVe2mKE7gwQMmZaLr22J3/eC7fRosIO5a+AV8Y5xW7PmsDA6H2d3pOJELRwy4tG+rnuq6vS3QdZ4eO7sqfVPrZ3NtCzmhGjRS5QHBv/S5mNjENYXrrMqrxc30hefXisJpd1Ua0EAQXD0/dT8ags6UZPSKs17/2ZYUPqxWgTB/pyyULy+7akb6ib8+XutIg1YWjOyZvhf2LE0HO4nP93I+93Hm1q/uANfTVF+Eg2aFUqtEC6P0JOHivx6uZm9jSC6z0YrbR/k6ELLI4lrqNMGGP5VOOMi/VKnskR6/iPQtz1tUS02YzaimcF07FwyU3C/6hbHgUrp56zwrdHSPYu2a4RZAMYvjZiPZV7kF0vsuJPFI1QMlVUvqvgDLkcGYq51/gZJpJttYvl2x8OWRXxAwOymvfpcKZv/VSPeIplvdRGA7kh6UaGvygDNwsGhIjeYiFZzwa2qKZmzz8xn0RpZbbGJVeemS4o1oagp46u23KbeT9rO2ZhK8i4vsF1L1LNvjwurUkbyhwzSecPbh6BXqOJmRK1qChSL6GOLGgToOG2qfqzbgXlOrMwdP9eSRmgwOHLdiu1GJPAGdDGKvnvDdPctyP8SUKPaDH/r9OjiMz4Vbgb6mUw77VoX3qEBhA5qwNcTB53ELVswNGf7cgAEJVu805gxS+nj/jkNHmDK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4143699003)(6133799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHBoSzNvSVRIcDR2c3dYY0czRmFGeEErb0F0K0tZTE5OZFlESlVUUmNUckxG?=
 =?utf-8?B?eS92RTF5RlVkQm44ZjBFTW1lNUE3VmpUU2lqTUwwb2VxSThjN2dHMHc1NGhJ?=
 =?utf-8?B?Vlp0WHBLckNYZU84UnBNVi9BUzc3TFkxa3NHY295YlJDNjlFbnJKdmJLdktX?=
 =?utf-8?B?dFFzOHQrSS9JZkd3UFExeDlZQ1hFWkUwM1pNU29EdHhhQTRtZ05BeHFiTEVv?=
 =?utf-8?B?eFJuZS9yZUU1ekJHeDZJejc2MmQ3VVNiME4xOWl3TU9MSmRBRHYwczlUWXVh?=
 =?utf-8?B?ZWlmMmEzTGRTa2l0THV1bTB6bnhiU2d6dmZpU0svNVVRLzF6bDFSZVdvbEE3?=
 =?utf-8?B?Z2dQWXNzY3FaK0t1aU5RaFlDdDhhOXYwR2NLUGs1TW5lTlFTRFVFK1pnY1Fo?=
 =?utf-8?B?NTdkWFN3eGRINzZyd3lYWmIwdzR2SW9aVnFTRmlUMWVPekU1bFlVczJTWURO?=
 =?utf-8?B?cnhSVmhGZFNYQVZUd1FROWhtYmJjZ09RSjlaREo3bGNXZXdIRTBkWGhSTnlz?=
 =?utf-8?B?U1pzNUNwdWMvNC9UWFFVUWdPM1I3Nm9yS1o1NXVHdWxreVJoOVFaUWZIZmhz?=
 =?utf-8?B?NWN2YkEvL3RjYmYrdGZTTUxXbFF0aGRPVWxsbmZaeHZCalBCR2Ntc3YvRkNr?=
 =?utf-8?B?QTBSQzVEMk5leXhSNGJQZFYvOEJXYytVY2sweVFtVlZSSVRZWDZxNmRCYzBy?=
 =?utf-8?B?eFRXNEYzTjd4SnczcmFEVTM0MTEwUENQZFFmTWQrQm9uTlNjUnUrVmpFbU5W?=
 =?utf-8?B?ZmIrWjBWOHlIV3hNdVdRTlpTaEdtY3ZqNFJBdmlwa2NDRkdsdEZIZGRIcW5Z?=
 =?utf-8?B?OXBNajNiVUtsU29nMFNMdVNZYVE5WExmWS9FN1FaNzFhNGtWeGROdUF3dWdD?=
 =?utf-8?B?Sm5WN3dSWERsL1lJUmtmYTVDTWJVeHNRMU5pelpWNEFBZkNTTVFtN1Y0QmZS?=
 =?utf-8?B?clNlNm9oSkE0N2pZdGFaNThkOUc4anRHM1Jnc2VmcytrVVVpTEZ4bjFHUmF6?=
 =?utf-8?B?dHlrblVSL1JWVGp0K21IYm53TWNCY2ZnVURGWnZ4VWtxaWYwSGp5SE1hc3ZR?=
 =?utf-8?B?WjBuam5NZEpmYkllZU51dTZxUVFkeWdVc00zSE44a0daM1BzaTN1ZkFvVkRK?=
 =?utf-8?B?VHJsNE1USCt1RmZFZUdyems3MWVWWGVtcUZmMUZxUTJScXBBckp4UjI1VmZS?=
 =?utf-8?B?THdiNCs5ZzVEZ21zbC80MVJiYWpmekRWRWlGOXk1azZSdWJ4emJXM0swSGNk?=
 =?utf-8?B?d0ltNk9LLzVxeFYzSHJFUnYvcUxjeVJPUmkwZE1HNGdqcFVZb0NMVHBqWlJk?=
 =?utf-8?B?NVFhMkdsNlAzVmNnUmc5NnUvYlFiaWlIWUQ4MUVSNHNGOHhNaGQ5Q25wVkR1?=
 =?utf-8?B?dUpkbDNZNGVvRmlxZytRKy91YmwwcXFRcm81S25OaDdRb2dBMTdSUXBpNlZy?=
 =?utf-8?B?c1JkVTVMVjRyS0FSNElYL0d6UHJQZ2dYZlc3RjZCWlU4YVFqbnBiK3Vsa04z?=
 =?utf-8?B?V2k1dklobGYrQnJvQ083R2w3dmZObjdrdzVDUmtMRDdXNHVKY1I4a0JkcUsy?=
 =?utf-8?B?d05jZGIyTHBtdngxZjZqTEh5VkhndzhYelhGbkhTNThPa0lLaVk4bzA0WXJW?=
 =?utf-8?B?QkI2VUJZQkpQZ2cxdnVDblAxOVBpTG9KSzZLWmtGUnM2SjN3eFZSMG9lbFJi?=
 =?utf-8?B?a0dFZXFVbng1azA5dXl2Y3RkdG5KdkdmTCt4Y2dIQ0dTRm5JeUdCdUVoUWI0?=
 =?utf-8?B?UVMzRW9Ga21nZTdCQVVyV2NDcjBrd051bHlkK05RZWFnVFNhVEhSb1MrVkow?=
 =?utf-8?B?U3lpNmRaQWxOSWFKNkh2ZmtnMUVVMHpiSlhMUUx3ZnB6TlFINmdQa3ZoQ0xh?=
 =?utf-8?B?clFIV3FFUVBzRmJnSEJWbzlwR3RQNVBvUFRuYm9LTllua25YNEFtc1lRVFlj?=
 =?utf-8?B?QlE3eGtGOElzSHFVN1k0UDJVVXZlZzg5YWZER1VhODcrUUJnQVpuZW1mVGZJ?=
 =?utf-8?B?RmpvcGVsYkRtY2x5bHdpaXRHbzJhMDE3OVAwS2ZMS2tSZGV2alZxYjlsem80?=
 =?utf-8?B?SGgzV095SlM3STJVeWhjL1M3V3JmV2ZNRGRCZU8xSS9DYzdkMDFyaHFmOVNI?=
 =?utf-8?B?QTJpVWVjT3hnWXpkSkVnUFpvN2lOOUxCY3NORE14Z0txc0F4S3VHTWJxb25E?=
 =?utf-8?B?Qzc4dllvazhkazg3ZVZuUG1vdkFIcyt6aFNUSzh0WW84VXB5ZUtlREV1bklS?=
 =?utf-8?B?WXcrdjJCUC90VDhrQnlCNTZqdWF0WHUyZ1dzdzJZMEdveEdZa2Z2ZWRjS3VK?=
 =?utf-8?B?d3NRT1NHWXgwR2EyYWFGY1AvWC9XWkxzSDUycXBBRDc2YVNRUlFSdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hmF5WEL2W2HzQqMy96MqHrKt4jLUw2LIyA4OUx4H8BFUCZee9/DjMxTwVUWggOrfGfqBrBBTQ1ZU85XGUgr5B6tQsjta7d/e+ID0OsG/QwSD8lbuQ7dJnMP4hCKhDZ/JHMETuTLhY8RuLxNts2GCQnIFMFNAPBEiD/vOwX7zB2GyD6v64GZO6sxpVM3sGRrIvgZsHUFjdX/ymNOR/j3X8CV/g6TrjZgpili7V6Su0Dn+C0mVNfN0mZhLXvI8xw5CvM0iV84h8m+0LDS9/1PZpBdDK/BRQx/FJRQEG/eEYcvTeyf7zDhooSOhXyzLtoaPQF5rQZf2zp9Qx2q7vDgW6Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0038b989-9c92-4a4b-3e49-08deb7a63bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 02:02:52.9438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4umeKPxgCiSfaN7qrecmwubOti/x2ptn6wxbXlMfjiHwjATMdRBwR+nepXPKBzurS+bAdJewjufEh+bUfMkQPDXG7TKrl6Fxiul9msdc/Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5381
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgNC80XSBody9hcm0vYXNwZWVk
OiBBZGQgQVNUMTA0MCBFVkIgbWFjaGluZSBtb2RlbA0KPiANCj4gT24gNS8yMS8yNiAwODo1Miwg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IEFTVDEwNDAgaXMgdGhlIG5leHQtZ2VuZXJhdGlvbiBkZXZp
Y2UgZm9sbG93aW5nIEFTVDEwMzAgYW5kIGlzDQo+ID4gcHJpbWFyaWx5IGRlc2lnbmVkIGFzIGEg
YnJpZGdlL0JJQyBjb250cm9sbGVyIHBsYXRmb3JtLiBJbnRyb2R1Y2UgYQ0KPiA+IGRlZGljYXRl
ZCBBU1QxMDQwIEVWQiBtYWNoaW5lIGltcGxlbWVudGF0aW9uIGZvciBmaXJtd2FyZSBkZXZlbG9w
bWVudA0KPiA+IGFuZCB2YWxpZGF0aW9uLg0KPiA+DQo+ID4gQWx0aG91Z2ggdGhlIGV4aXN0aW5n
IGFzdDEweDAgRVZCIG1hY2hpbmUgY29kZSBhbHJlYWR5IHByb3ZpZGVzIGENCj4gPiByZXVzYWJs
ZSBtaW5pYm1jIGluaXRpYWxpemF0aW9uIGZsb3csIEFTVDEwNDAgcmVxdWlyZXMgZGlmZmVyZW50
DQo+ID4gcGxhdGZvcm0gc2V0dGluZ3MsIGluY2x1ZGluZzoNCj4gPg0KPiA+ICAgIC0gRGlmZmVy
ZW50IFNZU0NMSyBmcmVxdWVuY3kNCj4gPiAgICAtIERpZmZlcmVudCBpbnRlcm5hbCBmbGFzaCBz
aXplDQo+ID4NCj4gPiBUbyBhdm9pZCBvdmVybG9hZGluZyB0aGUgZXhpc3RpbmcgQVNUMTAzMC1z
cGVjaWZpYyBoZWxwZXIsIGludHJvZHVjZSBhDQo+ID4gc2VwYXJhdGUgYXNwZWVkX2JpY19tYWNo
aW5lX2luaXQoKSBpbXBsZW1lbnRhdGlvbiBpbiBhIGRlZGljYXRlZA0KPiA+IHNvdXJjZSBmaWxl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDEwNDBfZXZiLmMgfCA3Mg0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBody9hcm0vbWVz
b24uYnVpbGQgICAgICAgICAgfCAgMyArLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvYXJt
L2FzcGVlZF9hc3QxMDQwX2V2Yi5jDQo+IA0KPiANCj4gTm8gZnVuY3Rpb25hbCB0ZXN0ID8NCg0K
V2lsbCBhZGQuDQoNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTA0MF9l
dmIuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTA0MF9ldmIuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0IGluZGV4IDAwMDAwMDAwMDAuLjU4NTFjZjY5NjcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxMDQwX2V2Yi5jDQo+ID4gQEAgLTAsMCArMSw3MiBAQA0K
PiA+ICsvKg0KPiA+ICsgKiBBU1BFRUQgQVNUMTA0MCBFVkINCj4gPiArICoNCj4gPiArICogQ29w
eXJpZ2h0IChDKSAyMDI2IEFTUEVFRCBUZWNobm9sb2d5IEluYy4NCj4gPiArICoNCj4gPiArICog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgICovDQo+ID4gKw0KPiA+
ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0K
PiA+ICsjaW5jbHVkZSAiaHcvYXJtL2Jvb3QuaCINCj4gPiArI2luY2x1ZGUgImh3L2FybS9tYWNo
aW5lcy1xb20uaCINCj4gPiArI2luY2x1ZGUgImh3L2FybS9hc3BlZWQuaCINCj4gPiArI2luY2x1
ZGUgImh3L2FybS9hc3BlZWRfc29jLmgiDQo+ID4gKyNpbmNsdWRlICJody9jb3JlL3FkZXYtY2xv
Y2suaCINCj4gPiArI2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCINCj4gPiArDQo+ID4gKyNkZWZp
bmUgQVNUMTA0MF9JTlRFUk5BTF9GTEFTSF9TSVpFICg0ICogTWlCKQ0KPiA+ICsvKiBNYWluIFNZ
U0NMSyBmcmVxdWVuY3kgaW4gSHogKDQwME1IeikgKi8gI2RlZmluZSBTWVNDTEtfRlJRDQo+ID4g
KzQwMDAwMDAwMFVMTA0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2JpY19tYWNoaW5l
X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKSB7DQo+ID4gKyAgICBBc3BlZWRNYWNoaW5lU3Rh
dGUgKmJtYyA9IEFTUEVFRF9NQUNISU5FKG1hY2hpbmUpOw0KPiA+ICsgICAgQXNwZWVkTWFjaGlu
ZUNsYXNzICphbWMgPQ0KPiBBU1BFRURfTUFDSElORV9HRVRfQ0xBU1MobWFjaGluZSk7DQo+ID4g
KyAgICBDbG9jayAqc3lzY2xrOw0KPiA+ICsNCj4gPiArICAgIHN5c2NsayA9IGNsb2NrX25ldyhP
QkpFQ1QobWFjaGluZSksICJTWVNDTEsiKTsNCj4gPiArICAgIGNsb2NrX3NldF9oeihzeXNjbGss
IFNZU0NMS19GUlEpOw0KPiA+ICsNCj4gPiArICAgIGJtYy0+c29jID0gQVNQRUVEX1NPQyhvYmpl
Y3RfbmV3KGFtYy0+c29jX25hbWUpKTsNCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hp
bGQoT0JKRUNUKG1hY2hpbmUpLCAic29jIiwNCj4gT0JKRUNUKGJtYy0+c29jKSk7DQo+ID4gKyAg
ICBvYmplY3RfdW5yZWYoT0JKRUNUKGJtYy0+c29jKSk7DQo+ID4gKyAgICBxZGV2X2Nvbm5lY3Rf
Y2xvY2tfaW4oREVWSUNFKGJtYy0+c29jKSwgInN5c2NsayIsIHN5c2Nsayk7DQo+ID4gKw0KPiA+
ICsgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChibWMtPnNvYyksICJtZW1vcnki
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChnZXRfc3lzdGVtX21l
bW9yeSgpKSwNCj4gJmVycm9yX2Fib3J0KTsNCj4gPiArICAgIGFzcGVlZF9jb25uZWN0X3Nlcmlh
bF9oZHNfdG9fdWFydHMoYm1jKTsNCj4gPiArICAgIHFkZXZfcmVhbGl6ZShERVZJQ0UoYm1jLT5z
b2MpLCBOVUxMLCAmZXJyb3JfYWJvcnQpOw0KPiA+ICsNCj4gPiArICAgIGFybXY3bV9sb2FkX2tl
cm5lbChBUk1fQ1BVKGZpcnN0X2NwdSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbWFj
aGluZS0+a2VybmVsX2ZpbGVuYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDAsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgQVNUMTA0MF9JTlRFUk5BTF9GTEFTSF9TSVpFKTsg
fQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX21hY2hpbmVfYXN0MTA0MF9ldmJfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqb2MsDQo+ID4gKw0KPiBjb25zdCB2b2lkDQo+ID4gKypkYXRh
KSB7DQo+ID4gKyAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7DQo+ID4g
KyAgICBBc3BlZWRNYWNoaW5lQ2xhc3MgKmFtYyA9IEFTUEVFRF9NQUNISU5FX0NMQVNTKG9jKTsN
Cj4gPiArDQo+ID4gKyAgICBtYy0+ZGVzYyA9ICJBc3BlZWQgQVNUMTA0MCBCSUMgRVZCIChDb3J0
ZXgtTTRGKSI7DQo+ID4gKyAgICBhbWMtPnNvY19uYW1lICA9ICJhc3QxMDQwLWEwIjsNCj4gPiAr
ICAgIGFtYy0+aHdfc3RyYXAxID0gMDsNCj4gPiArICAgIGFtYy0+aHdfc3RyYXAyID0gMDsNCj4g
PiArICAgIG1jLT5pbml0ICAgICAgID0gYXNwZWVkX2JpY19tYWNoaW5lX2luaXQ7DQo+IA0KPiAg
ICBtYy0+ZGVmYXVsdF9yYW1fc2l6ZSA9IDA7ID8NCj4gDQpXaWxsIGFkZC4NCg0KVGhhbmtzIGZv
ciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KSmFtaW4NCj4gPiArICAgIGFtYy0+bWFjc19t
YXNrID0gMDsNCj4gPiArICAgIGFtYy0+dWFydF9kZWZhdWx0ID0gQVNQRUVEX0RFVl9VQVJUMTI7
DQo+ID4gKyAgICBhc3BlZWRfbWFjaGluZV9jbGFzc19pbml0X2NwdXNfZGVmYXVsdHMobWMpOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX2FzdDEwNDBf
ZXZiX3R5cGVzW10gPSB7DQo+ID4gKyAgICB7DQo+ID4gKyAgICAgICAgLm5hbWUgICAgICAgICAg
ID0gTUFDSElORV9UWVBFX05BTUUoImFzdDEwNDAtZXZiIiksDQo+ID4gKyAgICAgICAgLnBhcmVu
dCAgICAgICAgID0gVFlQRV9BU1BFRURfTUFDSElORSwNCj4gPiArICAgICAgICAuY2xhc3NfaW5p
dCAgICAgPSBhc3BlZWRfbWFjaGluZV9hc3QxMDQwX2V2Yl9jbGFzc19pbml0LA0KPiA+ICsgICAg
ICAgIC5pbnRlcmZhY2VzICAgICA9IGFybV9tYWNoaW5lX2ludGVyZmFjZXMsDQo+ID4gKyAgICB9
DQo+ID4gK307DQo+ID4gKw0KPiA+ICtERUZJTkVfVFlQRVMoYXNwZWVkX2FzdDEwNDBfZXZiX3R5
cGVzKQ0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vbWVzb24uYnVpbGQgYi9ody9hcm0vbWVzb24u
YnVpbGQgaW5kZXgNCj4gPiBmYTNhODQ4NDkyLi45Yjc1Y2M3ZmIxIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2FybS9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL2h3L2FybS9tZXNvbi5idWlsZA0KPiA+IEBA
IC02Myw3ICs2Myw4IEBAIGFybV9zcy5hZGQod2hlbjogJ0NPTkZJR19BU1BFRURfU09DJywgaWZf
dHJ1ZToNCj4gZmlsZXMoDQo+ID4gICAgICdhc3BlZWRfYXN0MjYwMF9yYWluaWVyLmMnLA0KPiA+
ICAgICAnYXNwZWVkX2FzdDEweDAuYycsDQo+ID4gICAgICdhc3BlZWRfYXN0MTB4MF9ldmIuYycs
DQo+ID4gLSAgJ2FzcGVlZF9hc3QxMDQwLmMnKSkNCj4gPiArICAnYXNwZWVkX2FzdDEwNDAuYycs
DQo+ID4gKyAgJ2FzcGVlZF9hc3QxMDQwX2V2Yi5jJykpDQo+ID4gICBhcm1fY29tbW9uX3NzLmFk
ZCh3aGVuOiBbJ0NPTkZJR19BU1BFRURfU09DJywNCj4gJ1RBUkdFVF9BQVJDSDY0J10sIGlmX3Ry
dWU6IGZpbGVzKA0KPiA+ICAgICAnYXNwZWVkX2FzdDE3MDAuYycsDQo+ID4gICAgICdhc3BlZWRf
YXN0Mjd4MC5jJywNCg0K

