Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CFFF8E4B1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDdDr-0004Dy-NT; Fri, 17 Apr 2026 03:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDdDo-0004BZ-NN; Fri, 17 Apr 2026 03:02:36 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDdDl-0004r4-9B; Fri, 17 Apr 2026 03:02:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rtwyf0vtiOOrxlvS/7XNOjVYSqYNlYU9dn01PCaxAPA652qhLsJnQoCSMwX89oxL5cvxKmF4iazYHOFf2C9X639IFser+mlBZb+OpxOneJAMr7gbP9TlOL9DmMnjWnFfDJN1QpIi0VyYWWbJecpPNDC+pSrktUPF2UE+0ErNjOUNSyGPl97N0hF2p03cF5JHmTB/G0dVy/NMm6+oJVjYhrq55JHNOK53XdLJaSPrykhlnGlTKSnLy+HwFxcc8UBorj/wsGwKmIEw1Ln8anZTL1QsYlOJtwjJ1wKmR/H50smZiy4QXVa97dfp02czUF9qAfx5Mj96YUDdc5HHKU39uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TltnyeyLQ6ojyKrMmcabjP4qegJCdV9yJXvI5tkDHys=;
 b=ZSXL/wy7CNt/hJMyuSu8fVRq8Pv4TwOeBknbU1oyKUtjgj6zUFm8ZlxuoONJTm1/6F+3rCi+S425PVfXYKxRvp6Q8nPGrJP7ZUYIZCfriSKWYxYDxHCqtXGMwijNI6hmHhHTW7nOEwqQohv0KQkK5xJmdRRF521OoKlbbLprbyaYqCUy7IEs2RJeICAszTH0NkyaBBezjynlqVFyzVvrV4mYt4m0kZRtcKbwYJF+Uz4n+cHlF+CDc8lq7X6NrN6h7x6rUhoHT1o0/gWNVU8HEhUef87o7K1eJKAny4zxXymomfD/lH3IPCsVsXGvW4Pc4iZYb5rrDA9Kdi9FFQF4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TltnyeyLQ6ojyKrMmcabjP4qegJCdV9yJXvI5tkDHys=;
 b=DH6Zejp00NK4AXoae6KOSdcWMl30kPI+26va7S+nkXXPOflhUlXbnqBHQ2oYe1jbYN0XanP3mbfwMretFr/Wk2V0UxrJ6syOQpFBUPCUrUuzAtZygddIviw5yZ4kj0Rr4aUgtlBtmQ8eCVyjuGJ5/pDXhNHGhHW1fh+GfEEvkLJIcg+JFiNMYdp5MIk4YpaiqenhnkNJvQ275LIjYJ7OPnsTmU/inxnOQiUC0Jsu5KEzLnMtega8m3it/nnLO9LDYBxD1A6z879zD3/Tj/XTssbLVyc9R6EthbQUgQziTHkMOOXzBEfMiySNhy5ODn16R82eNnIXQdukNP1AxVhFcg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8728.apcprd06.prod.outlook.com (2603:1096:d10:a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:02:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:02:25 +0000
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
Thread-Index: AQHczUNObou9Fmh1/EmYf55F3wvnKbXitHqAgAAHusCAAAwQgIAADUlA
Date: Fri, 17 Apr 2026 07:02:24 +0000
Message-ID: <TYPPR06MB8206E85133AD461C8F7D0DE1FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-10-jamin_lin@aspeedtech.com>
 <c03af2eb-c7e9-4954-9a53-b1575c7073f6@linaro.org>
 <TYPPR06MB82062B89BEDF49BA637CDC02FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <34bf26b3-298c-4c40-bf10-fd0e29058a5c@linaro.org>
In-Reply-To: <34bf26b3-298c-4c40-bf10-fd0e29058a5c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8728:EE_
x-ms-office365-filtering-correlation-id: eba6c456-03ef-4029-e1f6-08de9c4f476d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: M8idSRR1XXDV3c3pBUM0o5nJXnkiK36ZsTW8il/GSjglR7HS1t4G6pcFkQ4lZmSG20xAVbnkDx6xLYQRgGPa/FFspHduyckHk2uigm6FhXhcIIwfMWkL/9Ga+Iqbn3/kZdcMKlUGxD9tn7qN5SI78LVKU5JrfuE2FCMiuf8YpcA9Rktt+UiWbnwD1ddiGVgOhNYt2JLFlbkVP09MqnQHdBg/Mm/eGtJ7+yDDB/zbj3lirsc8tTKMTrypG6KjZg8QvgImZ/aCXZfS8DRUEv7Wgdi3hSctlsa4vz2K5p+grTdiim/p06torC39TP/i3PYtOwZDnWQF1FehDEuri1P9U+QvpziblGd/+WIJDMMI0fbfpxQJVJR8spekgBobZJwBVsmZRRyHjM/Pym00LD+1oW/NBM7uTteRvWJvU5vzXtm99vbDVwAXqGcRRomHAeILKvMEcjM0kxZ3PjGyRYKj2Fm0UEdZvskxYnCxZi2zFrvqV7K+OCnjobUsE90xmT2220U9QI+Omi/3XtyahWDUEPkKD6fTqhAikYI0WnLByTpYzHwlvZqYGlxjHg+Aq+qX+V0xAPu2iM65cUwCrlY1Srf8TiY0dHbK91zkzVFQwYFUqaNevCAR1b+203PFIsEk/sUmuQ2+Ay3/hiSfOHtkW3/4Kf+QC4PFD1ipgiZv2FgaamLkK+1SVHfPrij63RG+KbVkYgfshSG95GDUBi4R+eFCnS50udADn/d7ja2UTKWUx0G+RkhAU+Gc6jC3OJeGBM3ToG72trRFD8wlPttwwhnUBiSHx5MhGuGPRyyXbbxuajx9auaEdCxRICXSDDjH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW9hWkxJbE9ZQi8rb3RWSGd5NEJiT25uL2ovRWovQWhkSEtIV2RjK3Nxd0VV?=
 =?utf-8?B?cmVFc2lqdXhhK0I2QWs3OGVQS3dSRkdqTzRsN3dVeTJMNEQvSWVtbUcrS0FB?=
 =?utf-8?B?TDVrenRKT2VGTXZtdUF1Z0pydlZ2dW9IRFkwZ2s2QjVIT0UrWHExVHgzay95?=
 =?utf-8?B?YVpJd0JjRHN4Qmo0L0hwWElwblVOZmt4b0M2S2czdy90QmxZL1ljekNBWlBm?=
 =?utf-8?B?TVQram5NS0huSk1FUXJiWGw4N29sZGZ6WWJoTUtXekxEQ3NDRjI1bWhML0ly?=
 =?utf-8?B?ZUIwSHIyNGJBTGJyc3dSTUUzNkpOY2VjVnFFV3c5c05uOHZ6R1FGL2lOVWdn?=
 =?utf-8?B?dlRyVFk4THVhdTZmWSthZnAxUmlhS3hxZzF4ejl6VHZRT3ZITy85VUhWR3g3?=
 =?utf-8?B?dkZyTmZvdk83YXN0cElBVHQ3ZUwyajVDbHNCOTcrWkx5akx3elVDd3MyL2Er?=
 =?utf-8?B?bitYUHZjeHBmbjNpK2JHdzhsSG0vbU5ySHV6R1IvZGxVcE83RzEwNWpGazMx?=
 =?utf-8?B?UGRPRkc5cXR0cGdKb3BFZUpzb0JITDNjUUdqQUZQK2lta01MUDVqWUJuUFJU?=
 =?utf-8?B?Mk1kVW4vK01jRlFIanQvdjBiNDFySzdSK2Rnb3hZRUhRVGJpQUs2bytudjNo?=
 =?utf-8?B?NVhFMC90MFVieFdyQ1J0b1FSa2VxNlYxeUluQUo0R1NJQkpyZS9BTWlJSzlq?=
 =?utf-8?B?K3pKZXJGVmM3SHJySUpZQXpSUkR3YWVDV1pRYWd0a0tMNEJDSS9LbGsyd3ZU?=
 =?utf-8?B?NjIrTmh2Nm1EbTN1U0hRdFQvS0FlRld3RzdiendkSSsvTHpFcFArMUNjbko2?=
 =?utf-8?B?TXBqelR5L3JOd1hkZVRNQkthdDk4cUVhZWNHNzFES25ZcUV4ZjdGN0Q3dUZS?=
 =?utf-8?B?VEd2SE5zcU5UeU50cTBlWkp4ZmFrY1NHd09TbEtIbjJTOUQ1a3Y2Ry95Wk1x?=
 =?utf-8?B?MG81Sy9qdVFGR3RRQWVwbkpZdFpCTldaNW9aTkZTdnlCaU5EdUNSKzZtZFdl?=
 =?utf-8?B?ZHJlQWZhTUpraVUvallVVzVtUGE1dSt6aWNOeVVpcjllNzBsZWs1Rm1HZWti?=
 =?utf-8?B?R0dITmF3TjcxZnM1RkVrNENTbGZvOTVueE56SzlYWnNqZFBITHVBNmxqbXls?=
 =?utf-8?B?WU1hSFhBM1dFaGNVeU1aaXBDK3N3dXc1aGhHWlZneWdjNjFmbVZkOW1EOVB0?=
 =?utf-8?B?R2J3dW9xVm9vWUhYYmxIbGZhN3BFOEdiTlJKOEovUjA3b0FxUkF5b3dZcmpm?=
 =?utf-8?B?a3pxcEhoU1NZQnByOTFoQkk2ZkhqSjZLaDlkNkNma3lteGxvK0NWRGpPNkd2?=
 =?utf-8?B?U2tMeDR4cXQzbEx6WnFnRTVXQUpEMXExck5wUERtMmxBZ2RCMUZaNGxpSnZG?=
 =?utf-8?B?b3JvWDVZcVFMTE0zRjJrbThPTHd6eVdoZ0psdXdOVmtIU2lGOW5LUWtLT3lN?=
 =?utf-8?B?THJteHVZeHRKaGR2N0JMdzM2VU5vOC91dHIxYmlLZVZoZnhXc08wbkdaMVQ3?=
 =?utf-8?B?WVcwOHlNTEM1OTVuV0k2ZmNIcVg5K1NVTEk5WmJJV3FqbDFEU0QweU5JMmcr?=
 =?utf-8?B?OWEyQzZFQkh5U0lOLzZyMHJuTk5vdSs3aE1DSXRlTG9Ra3czaDBjR2FtN05y?=
 =?utf-8?B?M1BTSGQ3WEdadCtPWk5vTzNwb1NFNldCYnlDdVB4eDd5Y0R4OVhiS2d0Z3JD?=
 =?utf-8?B?NW1FWDJSRStsQmJ4RkNiTW5SWTZiQ1pRaUFhRUtyZmRnQmowb2pxNUlmcHg3?=
 =?utf-8?B?TXpSdkJocmNKbGpLakZRTGhoVC9RQ05KMWxkcElDYW90alNtbjY2VXliSzNF?=
 =?utf-8?B?Y1hBbzYrK014amtGdDA3Y2RtMlB0ejAwRWYvZVl3QUNKem0rSElpZE1jRFZB?=
 =?utf-8?B?cmpBSDcrT0ZEWkQ0TXlPdmpFUGF5cGJqSmxTK2VqWEZpLzJwR3ZtOEJzY3Bj?=
 =?utf-8?B?aVVBZUg5WTlTSDM5R3ZybFliSW1pT3d5TmYxTU0vS29hdkIyeVlTV0tyMWJO?=
 =?utf-8?B?VG1IZ2FoVjJ4elltRVd0aWhXSi95cFg1Vy9rWEwxRVRYOTZHYWVZMUZTb3pF?=
 =?utf-8?B?WFpOWTV5VE9NdnljQnFxek9jeDlHREs3QkRuZkpZeWlmRlhzbW5BcmFXakpM?=
 =?utf-8?B?Sk80OXdvcm1QRThyUlZaN2hHUDViMVlSbVQ0ZEhvSDBXUGU4NmlnWTl4S0hn?=
 =?utf-8?B?VEJ3bzlFSHFTSzlOU1QxKzB1U0lxL3hHMmVaSmJFSzRSeG1tanZ3dzN0dXR6?=
 =?utf-8?B?ZDR4WHo3TWduNTVDbnBFOW8rbFJoVjZNb2N3LzA2SENFTEZYaXVPRlpRQmg1?=
 =?utf-8?B?akE4K1AwTGxNK1cvNkJ0dy9uVFgvQmRiZVdCd2wzbGZXNCs2N25aZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aEhA3BaT49XS/00Lp/pSzjO4kI2kHFOt1zYek9o8whRJEUDUZ36T14x1QX5/kiQByWVcGnBVSqw1f4H9hPVNzGAcxq+nh3nrRcLIG//WtPUmHHL0RRwZB8R2n1tcjgG/gH5ko3XW9Yb2TYsDJHocaHPI2fhtYkfEYDVPSjDqesjR+29x1lEvjxAUDpVaJAT5T/HpHWeoaPtf77784hcIxWFcDcrEDiAAz2e+UtNvXcrluDE4Cz0A3x3q0LV0x27BqbDNiputZTP6CnJhonWdKwoJLfw0suxDGIG8nqd7Sp1wHpteBWm8hn6eVBTQjrH6kAnFQuXN4FmRrXlsSQNd/w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba6c456-03ef-4029-e1f6-08de9c4f476d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 07:02:24.7338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKtJqU94peSLx9d05mP1u0slPb3xe2/X4u3VpIjO0rHJEX/EqZszgqVSXyoe+lXElidJ3qQ6WdfW0Bhs8E9I1tQQzu3BCveE5Fm/9vl1r4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8728
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwOS8xN10gaHcvdXNiL2hj
ZC1laGNpOiBJbXBsZW1lbnQgNjQtYml0IFFIDQo+IGRlc2NyaXB0b3IgYWRkcmVzc2luZw0KPiAN
Cj4gT24gMTcvNC8yNiAwNzo0MCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIFBoaWxpcHBlLA0K
PiA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDkvMTddIGh3L3VzYi9oY2QtZWhjaTog
SW1wbGVtZW50IDY0LWJpdCBRSA0KPiA+PiBkZXNjcmlwdG9yIGFkZHJlc3NpbmcNCj4gPj4NCj4g
Pj4gT24gMTYvNC8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4gRUhDSSBzdXBwb3J0
cyA2NC1iaXQgY29udHJvbCBkYXRhIHN0cnVjdHVyZSBhZGRyZXNzaW5nIHdoZW4gdGhlDQo+ID4+
PiA2NC1iaXQgQWRkcmVzc2luZyBDYXBhYmlsaXR5IGJpdCBpbiBIQ0NQQVJBTVMgaXMgc2V0LiBJ
biB0aGF0IG1vZGUsDQo+ID4+PiB0aGUgQ1RSTERTU0VHTUVOVCByZWdpc3RlciBzdXBwbGllcyB0
aGUgdXBwZXIgMzIgYml0cyB3aGljaCBhcmUNCj4gPj4+IGNvbmNhdGVuYXRlZCB3aXRoIDMyLWJp
dCBsaW5rIHBvaW50ZXIgZmllbGRzIHRvIGZvcm0gZnVsbCA2NC1iaXQNCj4gPj4+IGRlc2NyaXB0
b3IgYWRkcmVzc2VzIChFSENJIDEuMCwgc2VjdGlvbiAyLjMuNSBhbmQgQXBwZW5kaXggQikuDQo+
ID4+Pg0KPiA+Pj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gYXNzdW1lcyAzMi1iaXQgUUgg
ZGVzY3JpcHRvciBhZGRyZXNzZXMNCj4gPj4+IGFuZCBkaXJlY3RseSB1c2VzIGxpbmsgcG9pbnRl
ciB2YWx1ZXMgd2l0aG91dCBhcHBseWluZyB0aGUNCj4gPj4+IENUUkxEU1NFR01FTlQgdXBwZXIg
ZHdvcmQuDQo+ID4+Pg0KPiA+Pj4gSW50cm9kdWNlIGEgaGVscGVyLCBlaGNpX2dldF9kZXNjX2Fk
ZHIoKSwgdG8gY29uc3RydWN0IGZ1bGwgNjQtYml0DQo+ID4+PiBkZXNjcmlwdG9yIGFkZHJlc3Nl
cyB3aGVuIDY0LWJpdCBjYXBhYmlsaXR5IGlzIGVuYWJsZWQuIFVwZGF0ZSBRSA0KPiA+Pj4gdHJh
dmVyc2FsIHBhdGhzIChhc3luYyBsaXN0IHdhbGssIGhvcml6b250YWwgUUggbGluaywgYW5kIHBl
cmlvZGljDQo+ID4+PiBzY2hlZHVsZSBlbnRyeSBoYW5kbGluZykgdG8gdXNlIHRoZSB0cmFuc2xh
dGVkIDY0LWJpdCBhZGRyZXNzZXMuDQo+ID4+Pg0KPiA+Pj4gRUhDSSA2NC1iaXQgYnVmZmVyIHBv
aW50ZXIgZmllbGRzIGFyZSBkZWZpbmVkIGluIEFwcGVuZGl4IEIgYXMgc3BsaXQNCj4gPj4+IDMy
LWJpdCBsb3cvaGlnaCBwYXJ0cyBsb2NhdGVkIGF0IHNlcGFyYXRlIG9mZnNldHMsIHJhdGhlciB0
aGFuIGENCj4gPj4+IHNpbmdsZSBjb250aWd1b3VzIDY0LWJpdCBmaWVsZC4gVGhlcmVmb3JlLCB0
aGUgYnVmZmVyIHBvaW50ZXJzDQo+ID4+PiBjYW5ub3QgYmUgcmVwcmVzZW50ZWQgYXMgdWludDY0
X3QgYnVmcHRyWzVdIHdpdGhvdXQgdmlvbGF0aW5nIHRoZQ0KPiA+Pj4gZGVzY3JpcHRvciBsYXlv
dXQgZGVmaW5lZCBieSB0aGUgc3BlY2lmaWNhdGlvbi4NCj4gPj4+DQo+ID4+PiBJbnRyb2R1Y2Ug
ZWhjaV9nZXRfYnVmX2FkZHIoKSB0byBjb25zdHJ1Y3QgZnVsbCA2NC1iaXQgYnVmZmVyDQo+ID4+
PiBhZGRyZXNzZXMgZnJvbSBidWZwdHJbXSBhbmQgYnVmcHRyX2hpW10gZmllbGRzLiBVc2UgdGhp
cyBoZWxwZXIgd2hlbg0KPiA+Pj4gY2FsY3VsYXRpbmcgdHJhbnNmZXIgYnVmZmVyIGFkZHJlc3Nl
cyBzbyB0aGF0IGRhdGEgYnVmZmVycyBhYm92ZSA0R0INCj4gPj4+IGFyZSBjb3JyZWN0bHkgaGFu
ZGxlZC4NCj4gPj4+DQo+ID4+PiBBbHNvIGFkZCBidWZwdHJfaGlbNV0gdG8gRUhDSXFoIHRvIHN1
cHBvcnQgNjQtYml0IGJ1ZmZlciBwb2ludGVyDQo+ID4+PiBmaWVsZHMgYXMgZGVmaW5lZCBpbiBB
cHBlbmRpeCBCLg0KPiA+Pj4NCj4gPj4+IFdoZW4gNjQtYml0IGNhcGFiaWxpdHkgaXMgZGlzYWJs
ZWQsIGRlc2NyaXB0b3IgYWRkcmVzc2VzIHJlbWFpbg0KPiA+Pj4gMzItYml0IGFuZCBleGlzdGlu
ZyBiZWhhdmlvdXIgaXMgdW5jaGFuZ2VkLg0KPiA+Pj4NCj4gPj4+IE5vdGU6IFNpbWlsYXIgc3Bs
aXQgNjQtYml0IGJ1ZmZlciBwb2ludGVyIGhhbmRsaW5nIGlzIHJlcXVpcmVkIGZvcg0KPiA+Pj4g
cVRELCBpVEQgYW5kIHNpVEQgZGVzY3JpcHRvcnMsIHdoaWNoIHdpbGwgYmUgYWRkcmVzc2VkIGlu
IGZvbGxvdy11cA0KPiA+Pj4gY2hhbmdlcy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAg
aHcvdXNiL2hjZC1laGNpLmggICB8ICA0ICsrKysNCj4gPj4+ICAgIGh3L3VzYi9oY2QtZWhjaS5j
ICAgfCA0OA0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4gPj4+ICAgIGh3L3VzYi90cmFjZS1ldmVudHMgfCAgMiArLQ0KPiA+Pj4gICAgMyBmaWxl
cyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiA+
Pj4gK3N0YXRpYyB1aW50NjRfdCBlaGNpX2dldF9idWZfYWRkcihFSENJU3RhdGUgKnMsIHVpbnQz
Ml90IGhpLCB1aW50MzJfdCBsb3csDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IG1hc2spDQo+ID4+DQo+ID4+IFJlbmFtZSBAbWFzayBhcyBAbG93X21h
c2s/IE9yIGRpcmVjdGx5IHVzZSA2NC1iaXQ/DQo+ID4+DQo+ID4+IHN0YXRpYyB1aW50NjRfdCBl
aGNpX2dldF9idWZfYWRkcihjb25zdCBFSENJU3RhdGUgKnMsDQo+ID4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGhpLCB1aW50MzJfdCBsbywNCj4gPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgbWFzaykgew0KPiA+PiAg
ICAgICB1aW50NjRfdCBhZGRyID0gcy0+Y2Fwc182NGJpdF9hZGRyID8gZGVwb3NpdDY0KGxvLCAw
LCAzMiwgaGkpOg0KPiA+PiBsbzsNCj4gPj4NCj4gPj4gICAgICAgcmV0dXJuIGFkZHIgJiBtYXNr
Ow0KPiA+PiB9DQo+ID4+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9u
Lg0KPiA+DQo+ID4gSW4gdGhlIGN1cnJlbnQgY29kZSwgdGhlIG1hc2sgKGUuZy4gUVREX0JVRlBU
Ul9NQVNLKSBpcyBkZWZpbmVkIGFzIGENCj4gMzItYml0IHZhbHVlIGFuZCBpcyBpbnRlbmRlZCB0
byBhcHBseSBvbmx5IHRvIHRoZSBsb3cgMzIgYml0cyBvZiB0aGUgYnVmZmVyDQo+IHBvaW50ZXIu
DQo+ID4gSWYgd2UgY2hhbmdlIHRoZSBmdW5jdGlvbiB0byB0YWtlIGEgNjQtYml0IG1hc2sgYW5k
IGFwcGx5IGl0IHRvIHRoZQ0KPiA+IGZ1bGwgNjQtYml0IGFkZHJlc3MgKGFzIGluIHRoZSBwcm9w
b3NlZCB2ZXJzaW9uKSwgdGhlIHVwcGVyIDMyIGJpdHMgKGJpdHMgNjPigJMzMikNCj4gbWF5IGJl
IHVuaW50ZW50aW9uYWxseSBjbGVhcmVkIHdoZW4gdGhlIG1hc2sgaXMgb25seSAzMi1iaXQgd2lk
ZS4NCj4gDQo+IFJpZ2h0Lg0KPiANCj4gPg0KPiA+IEZvciBleGFtcGxlOg0KPiA+DQo+ID4gI2Rl
ZmluZSBRVERfQlVGUFRSX01BU0sgMHhmZmZmZjAwMA0KPiA+DQo+ID4gSW4gdGhpcyBjYXNlLCBh
cHBseWluZyAiYWRkciAmIG1hc2siIGFmdGVyIGNvbWJpbmluZyBoaS9sbyB3b3VsZCB6ZXJvIG91
dCB0aGUNCj4gaGlnaCAzMiBiaXRzLCB3aGljaCBicmVha3MgNjQtYml0IGFkZHJlc3NpbmcuDQo+
ID4gVG8gcHJlc2VydmUgdGhlIG9yaWdpbmFsIHNlbWFudGljcywgdGhlIG1hc2sgc2hvdWxkIG9u
bHkgYmUgYXBwbGllZCB0byB0aGUNCj4gbG93IHBhcnQgYmVmb3JlIGNvbWJpbmluZyB3aXRoIHRo
ZSBoaWdoIDMyIGJpdHMuDQo+ID4gU28gSSBzdWdnZXN0IHJlbmFtaW5nIHRoZSBwYXJhbWV0ZXIg
dG8gbWFrZSB0aGlzIGV4cGxpY2l0LiBJIHdpbGwgY2hhbmdlIHRoaXMNCj4gZnVuY3Rpb24gYXMg
YmVsb3cuIFdoYXQgZG8geW91IHRoaW5rPw0KPiA+DQo+ID4gc3RhdGljIHVpbnQ2NF90IGVoY2lf
Z2V0X2J1Zl9hZGRyKA0KPiANCj4gImNvbnN0Ig0KPiANCg0KDQpUaGFua3MgZm9yIHRoZSBzdWdn
ZXN0aW9uLg0KV2lsbCBhZGQuDQpKYW1pbg0KDQo+IEVIQ0lTdGF0ZSAqcywgdWludDMyX3QgaGks
IHVpbnQzMl90IGxvLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgbG9fbWFzaykgew0KPiA+ICAgICAgdWludDY0X3QgYWRkciA9IGxvICYgbG9fbWFzazsN
Cj4gPg0KPiA+ICAgICAgaWYgKHMtPmNhcHNfNjRiaXRfYWRkcikgew0KPiA+ICAgICAgICAgIGFk
ZHIgPSBkZXBvc2l0NjQoYWRkciwgMzIsIDMyLCBoaSk7DQo+ID4gICAgICB9DQo+ID4NCj4gPiAg
ICAgIHJldHVybiBhZGRyOw0KPiA+IH0NCj4gUGVyZmVjdCwgdXNpbmcgImNvbnN0IjoNCj4gDQo+
IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQoNCg==

