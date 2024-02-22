Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD76AC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 01:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcyAx-0007Tg-Ps; Wed, 21 Feb 2024 20:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rcyAv-0007Sz-9I
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 20:47:01 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rcyAt-0004F0-10
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 20:47:01 -0500
Received: from mail.andestech.com (ATCPCS33.andestech.com [10.0.1.100])
 by Atcsqr.andestech.com with ESMTP id 41M1kZW0006909;
 Thu, 22 Feb 2024 09:46:35 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS33.andestech.com (10.0.1.100) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Feb
 2024 09:46:35 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 22 Feb 2024 09:46:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.40)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Thu, 22 Feb 2024 09:46:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDsRWNShgbsSWhgw33QHRtEJw+wqjnfCIFFnmkIMjiXAlFdPL8jJgFa2oBm1NeYV3LaIqBoeo8jv7nvZQSVbzVKBqfhYQLTcFuHegbNcAEA1XB2L0YDkUV7kg3GIVHTN7MVzm06JYQQ24YHQCj40m6Z/7qSlurbInAarA7Q6tk4ozQA+NXQ0yky3w9c0YqLx/DC6pL/Ms084l8U6uXO+n2y8yeU8pruln4SUGbB44r2w3vD0Y2fQS89Rl477nzrX17mn1xRsz3ZsMnF0ndu5P/t59yfQSjj1gzOGG1ypHjVpYdy8WVm91bFftaKXBiY/MzFkffuvJQnQNRy2iVT00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zxRexZN5XZBLyso2FACpGEbG4tGGup4DnJoBzVALeE=;
 b=ZQ8B/erePs5Jrfv2fHFSq1o6fNknBR90XC0i1J1B469DtPUTWFotjdP18ScZp9RVPDpQ2iCHpFuo7AD0EdjPk9b3p+K03aIJoOauNMjH1Lcr3tCSEZIZUs0woGrci+wzakt8sUkWRP4fGsqW6lPRatyu3bS3FXIstkOgxxswNFzFlP+aV96KzhyEKtBBibbCs5zp3qrayIMYUfzcyj1PHrzbLMO/pFQprt5DHm7VabYwScT/dUaH/DpfAvo3lRPuOioXMoi+T2BSe5OQwzcJA4Cb2L5Q6fc41Hh/PRi9hJcsuBFA7+Aty47H4BndABRwy0FqfTZxBjzH18S+wJGrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zxRexZN5XZBLyso2FACpGEbG4tGGup4DnJoBzVALeE=;
 b=xi4vZlPdzA2dvwwYUPvF+G2jK8JgtmSiOWh74loAdAPC3jlR7VVX7Nb9gD6vo0Do/vBX60cUc2k+jXrMyIEMqk9Z7DjkkOoicU7qVRTILeeN5B65N5VR2UN3X5MjX/oBgior7dE73RONSTKx0dMXY15JXlxGAuYPRdcVEpU0xgaZjnl5IdaiSMns30w7nDe6D3o+WIQrFiSklnSn62XzK5mew8iR9Fgh4KUewQq7ope6TzVS8frqnQbb6nEtK1+RG2NfLWfaOEAQ9QY4STyxCV7cgP9c6y6FKtR6WmtrgmC7fymkZBCcofQcy9RpR3jCSWFjwC4g965o7Q2Erz7gHQ==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by JH0PR03MB8812.apcprd03.prod.outlook.com (2603:1096:990:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 01:46:24 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::42e4:f684:dde2:fd45]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::42e4:f684:dde2:fd45%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 01:46:24 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH 2/4] target/riscv: Apply modularized matching conditions
 for breakpoint
Thread-Topic: [PATCH 2/4] target/riscv: Apply modularized matching conditions
 for breakpoint
Thread-Index: AQHaYuNpUNShoD8YJkGriH3bZbCB/LEVEDsAgACIa3A=
Date: Thu, 22 Feb 2024 01:46:24 +0000
Message-ID: <SEYPR03MB6700A34DA4F22756C3C72CF0A8562@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-3-alvinga@andestech.com>
 <801fb2e4-bb09-47e9-b7f6-899de574c4a3@ventanamicro.com>
In-Reply-To: <801fb2e4-bb09-47e9-b7f6-899de574c4a3@ventanamicro.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|JH0PR03MB8812:EE_
x-ms-office365-filtering-correlation-id: 90dd5e02-2b05-4914-58b6-08dc334813bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECHc9mvGBxpWX8VbL/bFjQ1FJE3F4gSxpPq3sxlvagt4vN+mMelh+D3j9j76Tl5I0sDrKPkB60qgZfdwI5uyvvurUyLZwnd3CbyVDrwe+Jj5why2+gYHUP0MbrGHsg6wjaR0ES5hgRUI+gSX3YXGeF+ks0g5oXXj6VsOVffeRg2RfA1CORSJQjWJjsbWIgcB7UdPLt/1oLjqzLmpPFeJ2+9a/YngmOg/uappj4wUYF2gyo2OFf9GaZb6RHnP7yzEAaFFS4XC0Mtz9k/vbucAQua0OosmRaX9Bi81VoMZj+slUI9iLMqeMBFkzRL+Wf/gevi6NwQRbVaQtLtP05YMjJJRnLxxxlUFCBW3EUR2DQ6Bgxids5m/oqw1nPBtDNd1sRbWhzY20t0E6YAumZWNBNW7CMzIBZQ+Nqj64T+/7cHdJznrK/AXkf4waWiGV4CZml56sYCmH50KW/3TPXUIyqw3G0sV4vcygGSzyZF6t/hbA8S/VU+z8oo9dx+7CCtoyfDyl7PC+u1DlailBp7/JRQEIa4KfF6Tu2Vv17RrNA49xHHuclLV8sA4BusfzPv8wjRfBMXTRwukebzX6dUo84c0Y7VWSoPwnIDgFd1KPgHgDTs3r6yXsZntwpHXmSNy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUxPRXZ0SUZpQm1mOVRERlplSzY2ek1RdFJzMGZhdHArZlpqQ0YzRHhWNmhh?=
 =?utf-8?B?dXhseVpSejlDSTVmS3ArZzZUTjYzbmh5YzRhK0lROWNwSjlNM1FTVzRwckVQ?=
 =?utf-8?B?bUk3NmpQTi9UcStBNjZkSTdPL1d6SlpnSENtdVROUDZEbUM0ZGZuYmRsQWgx?=
 =?utf-8?B?ZFo0RGs1N2hzQi9ZQkF5UFU1UExLTmtyL21JME9hMGpNNHY5Wkcrazl6ZkRj?=
 =?utf-8?B?Y0ZIMXBxYmVpTVpZbGVvMThtQUcrMldveFlNazZBMTQ1MGdzYk5iRVpJZndE?=
 =?utf-8?B?OWNjRHM3MUZ6eWp0OUVhWUI1L3lyaDI0SzVWUlFXeERFTktkTlZSRlcyM2Rp?=
 =?utf-8?B?WHgvM25EbjlPNVRCcUFGcHQ4MjBoZWZSb244SWRRd21mOHlESFBMUmI0ZFgz?=
 =?utf-8?B?T3ZkbnlKdFB6cEw5UmNXUkptekdESzVWWDZ3RmxldWxuOU5mZkF0WmVGRUJ0?=
 =?utf-8?B?M2tPUTBvUTg0TG8wQ1V6Z1hONWlYL0VHVXRTQlhsOUVGV1crR0lpVjIxNnd1?=
 =?utf-8?B?eTVNWTFpRFh5QWl5MWZOMUZlbEgzclVISkQxRU1JUGc0VUd4MmNYaWJ5Ky9Y?=
 =?utf-8?B?UlpXNlV6cmZXL2hDUFFzNG80SWs0UnpKRHBtUEVidFN2Q0JWOU8zeSs5S3l0?=
 =?utf-8?B?YzdONU5rSFliN3h3cndXcEEzSDZvK3VSMC9YZ3JUK1Q2Q1IydURYN2NhMkNo?=
 =?utf-8?B?VldISjU4OFAwdHoxeHRYaEdGck81ZlZkZkE1M005NGdrTzVzdG1RT3BPUUdi?=
 =?utf-8?B?a0NEbEdpRkVmYU9KempidFd3U21ZWkJLTXZvODRGeU5BMDdGL1pVUzVRSmRG?=
 =?utf-8?B?TldmUk5aWVdYeUxTMmNkTXpjczl6bFVkdmgzZkpjb0VEaE5qVjdVWkpxM0ph?=
 =?utf-8?B?U21ZNGs0eHNrWlFnZnBHWG9ZVHlUaHIyb29vd1k0WjVyQlg3b0RSUXc1SmRh?=
 =?utf-8?B?RWdnNmpuYkdRZGpJN09oejg0ZWUvL1d1TkFYNXFxTzJjM0RORTJzTEFyaExx?=
 =?utf-8?B?czNXQmtLYkJsWEtZMmJEYnljNGRGbDZmOEhCVXFvM0NaWEg3OU5KUjk4SFNJ?=
 =?utf-8?B?d1NiS1dhYzlZMTdPeENUWGpwZ2JucTJ2YjNQTVp2S2xXaEM4SFVHaDgvWUxQ?=
 =?utf-8?B?SHdNV2FLQk83UmwrNDVKWHdlamY3UWpNTEVac1I2Um5WeGhlakpsY3R4UW41?=
 =?utf-8?B?WXZ5b3htbFRhZTlNQjdvbEU5d0dxNDQ1b3F1aGFiNG5WZUpVUG54dzRJQ0Yz?=
 =?utf-8?B?YlkyL0h4Y3d4T0ZBczhsTjJZMDMyVVIxU1UyVTk3Q0pHZlZ6cUhiWWs1VWxm?=
 =?utf-8?B?ZHQzR29KNnpyQzJDYlBVcEJiWmRZYWNKZFdzV1lUbWlKbmVnV0N0K3N6cmJU?=
 =?utf-8?B?RTFKQ1k4OUJWTkRJc05hTXZVanhUM2ZNVzlnbG0vTzhMNFpXRmg3RE5yRWlu?=
 =?utf-8?B?eWtuUjNwMGpZTGpnV2FLUlVHYy9aMisvYVc5VDU1WlBTazYvVk9yem91VFVE?=
 =?utf-8?B?WmhqOC92Wk1WWmIwSGl5UlRieXZGU05RSExlazF0VUJLTWZRdEtRWFVsM0Nw?=
 =?utf-8?B?aVBmKzJqNFIvT1AvWDgzdWRpSlhoVlgzVnN6bjIxampIZk1FRE9hbzhJT0lE?=
 =?utf-8?B?NXdOU3N1MHNFN1laL2IrNXpRaHVDcG1qL29GUndaZWNsTUZYVkEzV1Y1blN0?=
 =?utf-8?B?QnpsSW9XRkwzc0dTUENuWlhEM01EWVArOXFyRmFuT0NGNmk4Q2pVSWhwY04r?=
 =?utf-8?B?bm5FUnJ5bmhMZzlpeFp0SFRHWno0d0FWMGU2ZkVQQnBha2hYcUVXMTdCYVBa?=
 =?utf-8?B?RUJjbjVmbnAzekxzQnozZXpSM29UWnZ5TUhRaFBaUUZkeFViRlVpNTUvSFh4?=
 =?utf-8?B?Z0FSbjJ5LzVJQU4xMVdYdWhuckJvMDJsaGdZdGdJV2pwcndyNG9ORzRRYkVW?=
 =?utf-8?B?czN2RWlzWWJXU2JhQzlrc2g0aUdzYUJhY0d0bFJVSCszMHJpWFYwVUE2aFdZ?=
 =?utf-8?B?L1N4Unl3TFVNNHE3N3h2Z0tKVUNxNmdydzJlWWhDSmNoQ2R3RlNQSllDdS9S?=
 =?utf-8?B?SEpySE0wNHhqZ01aaERTQStjNm5zUHpJSmsyMlVPa2pUZW94VHN2QVdYRW9h?=
 =?utf-8?Q?5nP56+85hbexvMof/ONcDGsNc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd5e02-2b05-4914-58b6-08dc334813bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 01:46:24.1544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmJR0t/dHawkYCEGV5DNheNXFA3f6IakqFhPyXSsG4ozhjJBCi5QGFLapNjAzEeLqQYn0VApkv4o/rj0Q7tWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8812
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41M1kZW0006909
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgRmVicnVhcnkgMjIsIDIwMjQgMToyNiBBTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEg
Q2hhbmco5by15ZOy5ZiJKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPjsNCj4gcWVtdS1yaXNjdkBu
b25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbTsgYmluLm1lbmdAd2luZHJpdmVyLmNvbTsNCj4gbGl3ZWkxNTE4QGdtYWlsLmNvbTsg
emhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0g
dGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBjb25kaXRpb25zDQo+IGZv
ciBicmVha3BvaW50DQo+IA0KPiANCj4gDQo+IE9uIDIvMTkvMjQgMDA6MjUsIEFsdmluIENoYW5n
IHdyb3RlOg0KPiA+IFdlIGhhdmUgaW1wbGVtZW50ZWQgdHJpZ2dlcl9jb21tb25fbWF0Y2goKSwg
d2hpY2ggY2hlY2tzIGlmIHRoZQ0KPiA+IGVuYWJsZWQgcHJpdmlsZWdlIGxldmVscyBvZiB0aGUg
dHJpZ2dlciBtYXRjaCBDUFUncyBjdXJyZW50IHByaXZpbGVnZSBsZXZlbC4NCj4gPiBSZW1vdmUg
dGhlIHJlbGF0ZWQgY29kZSBpbiByaXNjdl9jcHVfZGVidWdfY2hlY2tfYnJlYWtwb2ludCgpIGFu
ZA0KPiA+IGludm9rZQ0KPiA+IHRyaWdnZXJfY29tbW9uX21hdGNoKCkgdG8gY2hlY2sgdGhlIHBy
aXZpbGVnZSBsZXZlbHMgb2YgdGhlIHR5cGUgMiBhbmQNCj4gPiB0eXBlIDYgdHJpZ2dlcnMgZm9y
IHRoZSBicmVha3BvaW50cy4NCj4gPg0KPiA+IE9ubHkgdGhlIGV4ZWN1dGlvbiBiaXQgYW5kIHRo
ZSBleGVjdXRlZCBQQyBzaG91bGQgYmUgZnV0aGVyIGNoZWNrZWQgaW4NCj4gDQo+IHR5cG86IGZ1
cnRoZXINCg0KVGhhbmtzISBXaWxsIGZpeCBpdC4NCg0KPiANCj4gPiByaXNjdl9jcHVfZGVidWdf
Y2hlY2tfYnJlYWtwb2ludCgpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWx2aW4gQ2hhbmcg
PGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRhcmdldC9yaXNjdi9kZWJ1
Zy5jIHwgMjYgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3RhcmdldC9yaXNjdi9kZWJ1Zy5jIGIvdGFyZ2V0L3Jpc2N2L2RlYnVnLmMgaW5kZXgNCj4gPiA3
OTMyMjMzMDczLi5iOTcxZWQ1ZDdhIDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9yaXNjdi9kZWJ1
Zy5jDQo+ID4gKysrIGIvdGFyZ2V0L3Jpc2N2L2RlYnVnLmMNCj4gPiBAQCAtODU1LDIxICs4NTUs
MTcgQEAgYm9vbCByaXNjdl9jcHVfZGVidWdfY2hlY2tfYnJlYWtwb2ludChDUFVTdGF0ZQ0KPiAq
Y3MpDQo+ID4gICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBSVl9NQVhfVFJJR0dFUlM7IGkrKykg
ew0KPiA+ICAgICAgICAgICAgICAgdHJpZ2dlcl90eXBlID0gZ2V0X3RyaWdnZXJfdHlwZShlbnYs
IGkpOw0KPiA+DQo+ID4gKyAgICAgICAgICAgIGlmICghdHJpZ2dlcl9jb21tb25fbWF0Y2goZW52
LCB0cmlnZ2VyX3R5cGUsIGkpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4g
PiArICAgICAgICAgICAgfQ0KPiA+ICsNCj4gDQo+IEkgYmVsaWV2ZSB0aGlzIHdpbGwgY2hhbmdl
IGhvdyB0aGUgZnVuY3Rpb24gYmVoYXZlcy4gQmVmb3JlIHRoaXMgcGF0Y2gsIHdlDQo+IHdvdWxk
ICdyZXR1cm4gZmFsc2UnIGlmIHdlIGhhdmUgYSBUUklHR0VSX1RZUEVfQURfTUFUQ0ggYW5kDQo+
IGVudi0+dmlydF9lbmFibGVkIGlzIHRydWUuDQo+IA0KPiBOb3csIGZvciB0aGUgc2FtZSBjYXNl
LCB3ZSdsbCBrZWVwIGxvb3BpbmcgdW50aWwgd2UgZm91bmQgYSBtYXRjaCwgb3IgcmV0dXJuDQo+
ICdmYWxzZScNCj4gaWYgd2UgcnVuIG91dCBvZiB0cmlnZ2Vycy4NCg0KT2ghIEkgZGlkbid0IG5v
dGljZSB0aGF0IHRoZSBiZWhhdmlvciBpcyBjaGFuZ2VkLi4gdGhhbmsgeW91Lg0KDQpJbWFnZSB0
aGF0IENQVSBzdXBwb3J0cyBib3RoIHR5cGUgMiBhbmQgdHlwZSA2IHRyaWdnZXJzLCBhbmQgdGhl
IGRlYnVnZ2VyIHNldHMgdHdvIGlkZW50aWNhbCBicmVha3BvaW50cy4odGhpcyBzaG91bGQgYmUg
YSBtaXN0YWtlLCBidXQgd2Ugc2hvdWxkIG5vdCByZXN0cmljdCB0aGUgZGVidWdnZXIpDQpPbmUg
b2YgdGhlbSBpcyB0eXBlIDIgYnJlYWtwb2ludCBhdCB0cmlnZ2VyIGluZGV4IDAsIGFuZCB0aGUg
b3RoZXIgaXMgdHlwZSA2IGJyZWFrcG9pbnQgYXQgdHJpZ2dlciBpbmRleCAxLg0KTm93IGlmIHRo
ZSBzeXN0ZW0gcnVucyBpbiBWUy9WVSBtb2RlcywgaXQgY291bGQgbWF0Y2ggdHlwZSA2IGJyZWFr
cG9pbnQsIHNvIHRoZSBsb29waW5nIGlzIG5lY2Vzc2FyeS4NCklmIHRoZSBzeXN0ZW0gcnVucyBp
biBNL0hTL1UgbW9kZXMsIGl0IGNvdWxkIG1hdGNoIHR5cGUgMiBicmVha3BvaW50Lg0KSXMgbXkg
dW5kZXJzdGFuZGluZyBjb3JyZWN0Pw0KDQoNClNpbmNlcmVseSwNCkFsdmluDQoNCj4gDQo+IFRo
aXMgc2VlbXMgb2sgdG8gZG8sIGJ1dCB3ZSBzaG91bGQgc3RhdGUgaW4gdGhlIGNvbW1pdCBtc2cg
dGhhdCB3ZSdyZQ0KPiBpbnRlbnRpb25hbGx5IGNoYW5nZSBob3cgdGhlIGZ1bmN0aW9uIHdvcmtz
LiBJZiB0aGF0J3Mgbm90IHRoZSBpZGVhIGFuZCB3ZSB3YW50DQo+IHRvIHByZXNlcnZlIHRoZSBl
eGlzdGluZyBiZWhhdmlvciwgd2Ugd291bGQgbmVlZCB0byBkbzoNCj4gDQo+ID4NCj4gPiArICAg
ICAgICAgICAgaWYgKCF0cmlnZ2VyX2NvbW1vbl9tYXRjaChlbnYsIHRyaWdnZXJfdHlwZSwgaSkp
IHsNCj4gPiArICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgICAgICAg
fQ0KPiANCj4gSW5zdGVhZCBvZiBqdXN0IGNvbnRpbnVlIGxvb3BpbmcuIFRoYW5rcywNCj4gDQo+
IA0KPiBEYW5pZWwNCj4gDQo+ID4gICAgICAgICAgICAgICBzd2l0Y2ggKHRyaWdnZXJfdHlwZSkg
ew0KPiA+ICAgICAgICAgICAgICAgY2FzZSBUUklHR0VSX1RZUEVfQURfTUFUQ0g6DQo+ID4gLSAg
ICAgICAgICAgICAgICAvKiB0eXBlIDIgdHJpZ2dlciBjYW5ub3QgYmUgZmlyZWQgaW4gVlUvVlMg
bW9kZSAqLw0KPiA+IC0gICAgICAgICAgICAgICAgaWYgKGVudi0+dmlydF9lbmFibGVkKSB7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+IC0gICAgICAgICAgICAg
ICAgfQ0KPiA+IC0NCj4gPiAgICAgICAgICAgICAgICAgICBjdHJsID0gZW52LT50ZGF0YTFbaV07
DQo+ID4gICAgICAgICAgICAgICAgICAgcGMgPSBlbnYtPnRkYXRhMltpXTsNCj4gPg0KPiA+ICAg
ICAgICAgICAgICAgICAgIGlmICgoY3RybCAmIFRZUEUyX0VYRUMpICYmIChicC0+cGMgPT0gcGMp
KSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgLyogY2hlY2sgVS9TL00gYml0IGFnYWluc3Qg
Y3VycmVudCBwcml2aWxlZ2UgbGV2ZWwNCj4gKi8NCj4gPiAtICAgICAgICAgICAgICAgICAgICBp
ZiAoKGN0cmwgPj4gMykgJiBCSVQoZW52LT5wcml2KSkgew0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gICAgICAgICAgICAgICAgICAgfQ0K
PiA+ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgICAgICAgY2FzZSBUUklH
R0VSX1RZUEVfQURfTUFUQ0g2Og0KPiA+IEBAIC04NzcsMTcgKzg3Myw3IEBAIGJvb2wgcmlzY3Zf
Y3B1X2RlYnVnX2NoZWNrX2JyZWFrcG9pbnQoQ1BVU3RhdGUNCj4gKmNzKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgIHBjID0gZW52LT50ZGF0YTJbaV07DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAg
ICBpZiAoKGN0cmwgJiBUWVBFNl9FWEVDKSAmJiAoYnAtPnBjID09IHBjKSkgew0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgIGlmIChlbnYtPnZpcnRfZW5hYmxlZCkgew0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAvKiBjaGVjayBWVS9WUyBiaXQgYWdhaW5zdCBjdXJyZW50IHByaXZpbGVn
ZQ0KPiBsZXZlbCAqLw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICBpZiAoKGN0cmwgPj4g
MjMpICYgQklUKGVudi0+cHJpdikpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiB0cnVlOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgLyog
Y2hlY2sgVS9TL00gYml0IGFnYWluc3QgY3VycmVudCBwcml2aWxlZ2UNCj4gbGV2ZWwgKi8NCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgaWYgKChjdHJsID4+IDMpICYgQklUKGVudi0+cHJp
dikpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICAgICAgICAgICAgICAg
ICAgIH0NCj4gPiAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgIGRl
ZmF1bHQ6DQo=

