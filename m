Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC683D58CBD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ToD-0000b0-28; Sun, 22 Mar 2026 21:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w4To5-0000aS-Bh; Sun, 22 Mar 2026 21:10:14 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w4To2-0002Pg-QQ; Sun, 22 Mar 2026 21:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDmeMzAeT7hwVTSVYyBvE+mYo228VhFNUpRd899Q3NlAWu1F2RDjsGqLxptAsbGhiZf71tMiEicfLwAZAJKT84KBjC7vDN6d1VARsVc9xi5k/EZFTA4tcvezrLavX0ooyGHF5bTxsCk+2lIQhTSk/Fk6/g5RGLiWz7iVVI+mJpBugpUa7eM/lrKeGcyipj2YB8udg6yeJndCceKpFsvN2eamnths3x7Mcc1PMB9WIFUQ+hY/XDoXcKuOA85tmSsR3INfHMs9sbUZtEz1a/C+CTjUiYby/vdm+rcxoKHH4xReKtPHXCyKArfiEGSXfBNgz8HRM+VBLdkAL908EVplBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY+QWUTXBIWC1X092XW5/wJwWymLYFZOrKmW2iNkI1U=;
 b=SQ89ZdOnb6Klw6VhOKvJfN1y6uLHOA6guxik6ecWtl8tV19N4ug161v7LXNitJYoyyM03VAioHMMz5O9A3BwUnYvkPxCB7bKiii91mwGyBb3F+Er2MvkM9U1dZ90ZLK9mTF4cpnPYt9cf0ZR8y36JC2bKSQA1026yFkMy/IJh6KK3chEk315gblM4lm9oHjJaUpcqIl0QsA/yaD8SByklpUjn7xc+jRTE954yLg+ujlO15hkEWmpqqneivimWrrw+38fTIjTQeHfs9U4P84MO0Mj1jQlezi74+tr3s4Z/GlMXMu3sQadcUDs9qpJdjvkC0teshUemdlsuxMpXgGdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY+QWUTXBIWC1X092XW5/wJwWymLYFZOrKmW2iNkI1U=;
 b=ryCBBe9vcbJMh/htMats7z0y+caz+Doz7RNLCgHCgn5gBkQinfQnVJoQbIE5nkOwC/SAejzgtj3sFFcM4QLCPSd/e9tawIl+oyg2BQF5oi1PQ22BpXf2MKOaSNaSL4gKtg2AV3zbz4aQhqLmjivmFYBw3w+DPDwpPdIaB+Z97G+LkpRXSZqWHFFoCQLwlJSRmrEIc87ukbYMpEw3PuCFU/vKpVzN4tGwwFJqOhdCWA2DwHbsT3o1IYFg+JsUFZQZJIv3gAnxUuNwYsCCObIsbykye6V6YEy06CKRCcmC1N4AYMwPa6EXdkfPsrfI6sbbdWICNwpWcvEED04SYBUC9g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5740.apcprd06.prod.outlook.com (2603:1096:101:ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 01:10:00 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:10:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH 2/3] ftgmac100: Improve DMA error handling
Thread-Topic: [PATCH 2/3] ftgmac100: Improve DMA error handling
Thread-Index: AQHcukbv7U/g/kf+zEW5wrUH3iB87rW7TliQ
Date: Mon, 23 Mar 2026 01:10:00 +0000
Message-ID: <TYPPR06MB8206A99D50332D2388AEBB9BFC4BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260322215732.387383-1-clg@redhat.com>
 <20260322215732.387383-3-clg@redhat.com>
In-Reply-To: <20260322215732.387383-3-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5740:EE_
x-ms-office365-filtering-correlation-id: db22250c-1ffe-4b46-805c-08de8878e7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|13003099007|38070700021;
x-microsoft-antispam-message-info: 1l2LEYG5gw5W6z71ez75r8zW7ieL6/RjwSjYPQxlHS6Z9E5IqrNnxBg/avX3uobxNc5JMB6anE6h7mi6C8AYJkcwH1EFsqxLGjDXprfLHcNsbkseUVee6yOjFDYUTdQKkJ8BBE2xXgP91wk/MPNm0ZW49VH+Lw4A9T3PH3mFLRsg1+SKyXSPalZLTAS27kTu/nmZqnbISH0kAlZTg8stDe+p1Gl9OnzvUTmsY73Aw0pKieJ8pn3nj+OFYd8PDrV/4L4PGqi9fomG0Cm3dLoAxgJTVOtg35Ur2Vig6dOgxhKbhsXUwN1ifu1q+iHS0NbaagiUvJgz20trAqN9jSSGervWhGRZd1fplHIi/LMWToVNDuk+nTLYaJyfdT/p4Le/k/leqdXbQWOZAmO4KMgoIHFSoBuDbocyrGw1ZQqXsYbfScrPw3xpzg1tI2ANI8+usSjutPZ+jlgaYLtWXnwVZ0uYbIe6S6uZVbTPpwl7Q9vq0CP6spl4/BAoaAG3qu1/s4N/ITyuizPrX8JC3vaMt+8rHyajafR8/VXEy2xTwWrlQzn12hKciMIkMZG+odnvEIcgIVMsVsBQ4CkG/vsugIls2IKS0nosne7jiKykEOUw3p7dCXE2PdUI0ZlsawKGyYYTr0Km4fQSmNvwgNABsoqnoQeqTG0js50cDDhg9nhoSm+hIOsNVFItofgKi7sjQgIPSbe0U6V6dtnes26bl5Cq2F+zx+3CEoH6WWbR8J+IB2jjDJcrVfup31ERXPcRncc0Ih4cnZ3m9e/g4ipezQrPaqjTSlqPVSH234+/PGk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjRlMUZ6c2QrSGdwOUJtbVVBUHM5cmxOelRjWGpYWTRHbVpsR0d6VDVQNlE1?=
 =?utf-8?B?WkZNM0JpRW82NTk0Ukt6YlQ4TmlZaHJzM2djSkNLUEtPaDJxb1pEOWN6Q2k1?=
 =?utf-8?B?d0hOYis1K1RvaDdKZWhBOWZISHFka0ZZWC9XSlVCNlB4ZlBiT1owODIwc1dk?=
 =?utf-8?B?UUxyVDgxRk5NT3NKZVRVdThtZXNxdG5VY0VlSHNHbzBzOGpzRWdidmY2Ykk4?=
 =?utf-8?B?UCs5N0NXVGFVa25xNlZ4V0hJWUJIaUxCb3RkYXFrZnBHSDhyZHh0bjJBVXMy?=
 =?utf-8?B?TjNnQVhVa1U4UjhWT0lTSE4wOUJwbnZtcEFJL2pOOW4xSEoydEhsd3YzZzhK?=
 =?utf-8?B?aGxVckVQU2swNEFVaDBiQzNlb0VnQXMzODJtenR1L1pES2M2akFFdE5XLzBw?=
 =?utf-8?B?ek9idmc4d0hianBaUWJ3NXpKV1kwMzFicFEvSUh0VmZuOHJHN0FjUE9rUDJL?=
 =?utf-8?B?VWZEZHhBazEycHNHU0xZYm1BeUp2eEtuc3BPdzZzS2V3dGhxeU1xc3NKa1pZ?=
 =?utf-8?B?aXllREU1cEQ1Y0NVdDV5UTk0QnBVWURPZDRGcENLTVhoNXFURGlsSDZqWE8w?=
 =?utf-8?B?RXJUWGFkMG9jWkFFblN6b3pxeGd3NS95UnM2R0ZoVTV2dXlKa1RHdTgwczhw?=
 =?utf-8?B?UWVLcTJNSThpN3RoUXYxeWRnM0tISW8rem1abmxyRDVMMVNmSlRZelp4OWdF?=
 =?utf-8?B?a0FzMjlmUDZwd3l6Y1FKUUUrSDZxQ0M0Umg1SjdJcGI1Q1NBM2piMEQwcVZZ?=
 =?utf-8?B?WDEyMGVRZE9ZZEU0QnFKZm8ySG5lZlFnNGFiR2x2YmQyMDJrT3lIZFhHa2VP?=
 =?utf-8?B?T29WeGpSZkxmdjNodlJobng0SnRkYXdqWE9yNmZ3QUpSalA0Rmt6Q3VoRUZF?=
 =?utf-8?B?eEJNck83TWxNNG5oa3NQVVRVbEpnRmFQU1ExeFR5RFNiOXQ1WUdqOUVmTHBV?=
 =?utf-8?B?VFlLVkUwYktWWVd6cURjNFFsZHQ2V0loRW5uQkc3R1hVMWU2d1lpRnUwQjBK?=
 =?utf-8?B?OCttZ2pRVXpvNG0rK05LK1FIK0NsdVhJN0hlNzJuK1RoSEVsaWF3ekl0ZUkw?=
 =?utf-8?B?RkNNa2xIQ1d1TWlzR2t4eGNvZkRkRy81UGloMENQeG9wc2l4OU0wVEJiTjdW?=
 =?utf-8?B?N3pFRVBIK2xmYmtISEY3eFpVNlRSMUx0T05Bb3NhaFkvZXhhWUYrZ1JlcXF1?=
 =?utf-8?B?MVdvbEpmOGNKWGRVTnJ2aFhuS3Rwam5uY2NVTEdDTXlycUpSZWVSTjZVR3Vl?=
 =?utf-8?B?TVh5OHBQWGIrbGNvWXRpVEVNdmpDT3RkbjhOeUVjT0JnYnZRcFg0ZU9lTFNP?=
 =?utf-8?B?Z0o4K1dmV1VlZjlJVnZaUXhLZkFzQTlESkczemdPQnUyUFRzVnJabzNKRStM?=
 =?utf-8?B?WTZiTUY4WS9MNXUxVnU4REZiZlhLMVpWejhiSUx6SUFXWk56d21PbWdtZVVr?=
 =?utf-8?B?Q3BtQlg2T0l0b2Y0TE1LTFFSa2V3MGplc2F6Um1uZlFQR2FnSnZwTUgwaGVx?=
 =?utf-8?B?S1FXWUNuektoVzB2WHYvckI3Z1R5NE0zRjMrQ1AwcW81L2pKeS9BOThJaGV2?=
 =?utf-8?B?dkMwOCtFSmFvY0Rkc2N1Mlh3NTZoZ0VKK2t6WnlkZ3gzUzJNdVZpM1phc0FO?=
 =?utf-8?B?UWEraTlIQTRFZFVFUHp5b3FzNWlDNERBWjNMck1PK0ZsUzM2b0NXanhtNFU5?=
 =?utf-8?B?blFpbFRrU21iZ0pxa0xTczUwWVlzZGZ0aFdQenlrV21NZ3d2RmxpaDZ0ckgx?=
 =?utf-8?B?NW9SS2IyTk5QTVYwQ2hJNU9HQmgzUDNhVDVWQ1hjWDhXSWFwaHErZytydkYz?=
 =?utf-8?B?V0J2QjlBc3djSFJ3Rk9jWXB3QzZvQjdFazhYVHpGUk1FM2RlU2EzVUZsU3J6?=
 =?utf-8?B?TzBGUU44djhTY0UwTlNrYkgwWWQ5RGEvNnp5U0hwWnNPeFJvWFV6Z0VpQURN?=
 =?utf-8?B?bmNtOE53YmdYMkc0T1dXTkV3cWNlODhrUDVUcEQwRHJNRFo0dWpsZkRWZjQ2?=
 =?utf-8?B?TjhrcFl4YmxxdVhETWZpNCtzNjhBVEJBRTBSZy9NY2t2ZDNWelBHREM4US8x?=
 =?utf-8?B?M1RUQlFFbDNLVG1SV2phYkR0d28vZUZyTFMzbUUwZTA5OEtTRFVOOUh6YUMv?=
 =?utf-8?B?VlpmTWtEOEI1aVBWdWhVM012dllVbWV2N3IvK1lWK2doc1Y5eWg0L0J1ekZK?=
 =?utf-8?B?WmlxNUxmeENTMTdlK1dzY2w4aE85TWJvVDZZbnBWUC9Uck5NWjRGYTh5Q3Uy?=
 =?utf-8?B?VVlTK2xGZSsyQWU2dlF3ZWRCellDYXVxWlRsVCtEK1ZIeG5RU1FINldqdElz?=
 =?utf-8?B?d2FlSFdDa3NQVW1QTy9DTkFvaDdPZFhwazBrWHRiVE81SGNBZURMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db22250c-1ffe-4b46-805c-08de8878e7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 01:10:00.1895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUe2rEgIcRO1t6EP1K7DK/17+0472FYVBJ/2OVwOyDNpHKODgpcZ3ZSH8m+Il9A+M/d6Go7zfCgFjabgIdirpRqIdjP5jRpArgTeojUUL4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5740
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjMsIDIwMjYgNTo1OCBBTQ0K
PiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBQ
ZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBKYW1pbg0KPiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2gu
Y29tPjsNCj4gQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMi8zXSBmdGdtYWMxMDA6IEltcHJvdmUgRE1BIGVycm9yIGhhbmRsaW5nDQo+IA0KPiBD
dXJyZW50bHksIERNQSBtZW1vcnkgb3BlcmF0aW9uIGVycm9ycyBpbiB0aGUgZnRnbWFjMTAwIG1v
ZGVsIGFyZSBub3QgYWxsDQo+IHRlc3RlZCBhbmQgdGhpcyBjYW4gbGVhZCB0byBhIGd1ZXN0LXRy
aWdnZXJhYmxlIGRlbmlhbCBvZiBzZXJ2aWNlIGFzIGRlc2NyaWJlZCBpbg0KPiBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzMzMzUuDQo+IA0KPiBUbyBm
aXggdGhpcywgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiBmdGdtYWMxMDBfd3JpdGVfYmQoKSBp
biB0aGUgVFggcGF0aCBhbmQNCj4gZXhpdCB0aGUgVFggbG9vcCBvbiBlcnJvciB0byBwcmV2ZW50
IGZ1cnRoZXIgcHJvY2Vzc2luZy4gSW4gdGhlIGV2ZW50IG9mIGEgRE1BDQo+IGVycm9yLCBhbHNv
IHNldCBGVEdNQUMxMDBfSU5UX0FIQl9FUlIgaW50ZXJydXB0IGZsYWcgYXMgYXBwcm9wcmlhdGUu
DQo+IA0KPiBUaGUgRlRHTUFDMTAwX0lOVF9BSEJfRVJSIGludGVycnVwdCBzdGF0dXMgYml0IG9u
bHkgYXBwbGllcyB0byB0aGUNCj4gQVNUMjQwMCBTb0M7IG9uIG5ld2VyIEFzcGVlZCBTb0NzLCBp
dCBpcyBhIHJlc2VydmVkIGJpdC4NCj4gTmV2ZXJ0aGVsZXNzLCBzaW5jZSBpdCBpcyBzdXBwb3J0
ZWQgYnkgdGhlIExpbnV4IGRyaXZlciBhbmQgaXQgc2hvdWxkIGJlIHNhZmUgdG8NCj4gdXNlIGlu
IHRoZSBRRU1VIGltcGxlbWVudGF0aW9uIGFjcm9zcyBhbGwgU29Dcy4NCj4gDQo+IFJlc29sdmVz
OiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzMzMzUN
Cj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiAt
LS0NCj4gIGh3L25ldC9mdGdtYWMxMDAuYyB8IDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvbmV0L2Z0Z21hYzEwMC5jIGIvaHcvbmV0L2Z0Z21hYzEwMC5jIGluZGV4DQo+IDY5YTM4YWRi
NjI3Zi4uMjVjM2VkZTcyY2JiIDEwMDY0NA0KPiAtLS0gYS9ody9uZXQvZnRnbWFjMTAwLmMNCj4g
KysrIGIvaHcvbmV0L2Z0Z21hYzEwMC5jDQo+IEBAIC02MjQsNyArNjI0LDEwIEBAIHN0YXRpYyB2
b2lkIGZ0Z21hYzEwMF9kb190eChGVEdNQUMxMDBTdGF0ZSAqcywNCj4gdWludDY0X3QgdHhfcmlu
ZywNCj4gICAgICAgICAgYmQuZGVzMCAmPSB+RlRHTUFDMTAwX1RYREVTMF9UWERNQV9PV047DQo+
IA0KPiAgICAgICAgICAvKiBXcml0ZSBiYWNrIHRoZSBtb2RpZmllZCBkZXNjcmlwdG9yLiAgKi8N
Cj4gLSAgICAgICAgZnRnbWFjMTAwX3dyaXRlX2JkKCZiZCwgYWRkcik7DQo+ICsgICAgICAgIGlm
IChmdGdtYWMxMDBfd3JpdGVfYmQoJmJkLCBhZGRyKSkgew0KPiArICAgICAgICAgICAgcy0+aXNy
IHw9IEZUR01BQzEwMF9JTlRfQUhCX0VSUjsNCj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiArICAg
ICAgICB9DQo+ICAgICAgICAgIC8qIEFkdmFuY2UgdG8gdGhlIG5leHQgZGVzY3JpcHRvci4gICov
DQo+ICAgICAgICAgIGlmIChiZC5kZXMwICYgcy0+dHhkZXMwX2Vkb3RyKSB7DQo+ICAgICAgICAg
ICAgICBhZGRyID0gdHhfcmluZzsNCj4gQEAgLTExMzQsNyArMTEzNywxMCBAQCBzdGF0aWMgc3Np
emVfdCBmdGdtYWMxMDBfcmVjZWl2ZShOZXRDbGllbnRTdGF0ZQ0KPiAqbmMsIGNvbnN0IHVpbnQ4
X3QgKmJ1ZiwNCj4gICAgICAgICAgICAgIGJkLmRlczAgfD0gZmxhZ3MgfCBGVEdNQUMxMDBfUlhE
RVMwX0xSUzsNCj4gICAgICAgICAgICAgIHMtPmlzciB8PSBGVEdNQUMxMDBfSU5UX1JQS1RfQlVG
Ow0KPiAgICAgICAgICB9DQo+IC0gICAgICAgIGZ0Z21hYzEwMF93cml0ZV9iZCgmYmQsIGFkZHIp
Ow0KPiArICAgICAgICBpZiAoZnRnbWFjMTAwX3dyaXRlX2JkKCZiZCwgYWRkcikpIHsNCj4gKyAg
ICAgICAgICAgIHMtPmlzciB8PSBGVEdNQUMxMDBfSU5UX0FIQl9FUlI7DQo+ICsgICAgICAgICAg
ICBicmVhazsNCj4gKyAgICAgICAgfQ0KPiAgICAgICAgICBpZiAoYmQuZGVzMCAmIHMtPnJ4ZGVz
MF9lZG9ycikgew0KPiAgICAgICAgICAgICAgYWRkciA9IHMtPnJ4X3Jpbmc7DQo+ICAgICAgICAg
IH0gZWxzZSB7DQo+IC0tDQo+IDIuNTMuMA0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkphbWluDQo=

