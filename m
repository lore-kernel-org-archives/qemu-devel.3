Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C724CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4JH-0000KQ-3n; Wed, 13 May 2026 03:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wN4JE-0000Jw-EQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:47:12 -0400
Received: from mail-japanwestazon11011049.outbound.protection.outlook.com
 ([40.107.74.49] helo=OS0P286CU010.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wN4JB-0003B5-OH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:47:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tntuOov42j/jrBA+qzheVfiIXqBcNsSAhAVA0uKEdlWnXeCn3stRB/1SR+lDgu51SLni3srE6XnN2/UNGsLYW+5NXk5oki5a8zuBsJQepVzmZN6mBXYRSmUriksnjCuizN4hGBFVHmRcIKbpSkpFvSgTC+oKI7vlXG46pzgemwJampNO8Mn4l2cCi7vLKcl2Yj6JZQaN2SdxUvTk8QO2aZKr3WTIACMcgs4s8c9RSrUTvRsE6JC+Nob4py5B+lBhZyapzX6KDJxzKzJi8Gho2s1oYTPseRZ6Mxm9LYDVIoUOH9XDzlq0dJrbQD3m4l7+cjQqrjeYERpciXzeECtOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORJ92xXy6uIaOm/cT/8yO1ZjZCqN+Nz7q3tnZjQABuY=;
 b=VH9YBd4dIu5ikPB7RsPrUVUHPkmOf7QPHBMkbnXR8w/3kncyolImMZuxObAeGTFXkK1uXrghSJFQFntlL/HN0+CTGxeF6O4KERgCyM7qZBlCZ3/QPFlp7nsDStay33mP2EVKtMRhZi0iAceXPMZo7m7uKz1quLaI1JY+tMAcYUZiEV34hEmmQq4O6hYQpk0ZvUif9oIghH9GhX/kXfQL2w20I5jqVy6uiLGHCgP/+s64ur02t4uaZd4z46KRUPspKCO4aVGVjGntr6c223ZH2oavnn8SzZhjdVJ2D4grUIxFLb4rZ3aErFAfaq+qI+UUogM5efvHI+3lQ+ThPny1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORJ92xXy6uIaOm/cT/8yO1ZjZCqN+Nz7q3tnZjQABuY=;
 b=oRBzquhIOPfjBklXp7E7RyMTHUQURjoDgcRkAb1qkUzvL91ZZw5V/Ne1f1JhH1M4eny4jnCZ/4MgpFrE+GWScf7IlpnkO0ZHpTXkAHED6uUMD9tYnHCRrsMYS1m3H7+nrG707HCnr9RKBoX5Zbarc893IPXINjkfXRHESsB0W0SHIhATn9eSa4Ro7UTYCKv9QFeZm+dyQ2Xv08JyIskZnWH85zCENVLxtmLobmUNVVNeD+DnUQHa0/sY1zJzOz05dz4wRYASx8OVM5vKI0QJ7yuyxTv4jsqsbc580WWPX6VP26TB5a+L2jQ/v7kKmcDifmc+kDI6MXi1tCCs/96jbw==
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com (2603:1096:400:3a3::6)
 by TYRPR01MB13249.jpnprd01.prod.outlook.com (2603:1096:405:113::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:41:59 +0000
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::9b12:a51d:c48:71ac]) by TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::9b12:a51d:c48:71ac%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:41:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Update RDMA migration entry with M:
Thread-Topic: [PATCH] MAINTAINERS: Update RDMA migration entry with M:
Thread-Index: AQHc4VLAhAhLD9J0WEW12e5G+Hyvj7YLlU4A
Date: Wed, 13 May 2026 07:41:59 +0000
Message-ID: <13b9ac7d-5c11-49c1-952d-25e7ef47f32d@fujitsu.com>
References: <20260511143026.1296485-1-peterx@redhat.com>
In-Reply-To: <20260511143026.1296485-1-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10926:EE_|TYRPR01MB13249:EE_
x-ms-office365-filtering-correlation-id: 56bd6f17-1a50-40da-7c5d-08deb0c31d7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info: 9nbC0iyieoD980j48YMzgbdEafjxQN0vwazxIUf68xnqpfXlNO19U0pOlW10cD3eP5i8OMChHSVTCtyeHPK37zdeOKYB+3VjDPDf/qFxeKDh4TmaDkDt4I7Sa5epYZASuqfohY/El0n6PBJGcrEKxrD/L5U/v3bB3ak8UBwRmbsp/pku/U362UoEtJgfWXNSFpPIlfHI6GbVbhjpB+walWnYXjzCftwyi2oyHy14BDULsO+wf6iYCktEUikI2lHR4/haLdIxjkYbu5/YAl1g7+yGF/7m3fnrqvFxhEcGoWasKYVJvvhx779+oZGRWeHGwx5iTb8d1FkC/Se33xEhHnPvWunyDvGmbUSRRmPgHIfnWMc/se6m8d0AKupsfwgLVBrutJj/0Sw31jTBDTMq9Mk1WomzL4P4dQWA4N/DvfJJ/tERjSiTJeA1rE5Uo6ZqefdM1hVIbykNCErRtdNzAHh+uLc/JMBbZPKg2ZQ4KTiGF+MzIRarNAtU8/0aRanHNdCCMBCoHqP11rfYoYHTJDkrwcguo/CBtaKkV9hGpk5Ji4p2CXJsT6Y1JGDOqYOt1C6i+1ltjBRjMDWLKw9XmBpXVG/L2zCJ8Pquv2hqVkRmnCQUKqiTUnqMS8EEJZ1xTsL1B1x3V3iQo3jucAkHTshbQdFfM5qq9DE90Eg2fjRVKv6zqI/o0ZO7pJOU2ySe0RCZXyfxdaTB7GvcoqqvID3M923DYEvD3y956Vnka1PjhEFQqlaHD38scR2iuKJp3Nnti7ji82/o7+LVkRJ7CQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10926.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFpyS2tMSFVKZmhiT2RmR0UwVVN2SWpCUVBNK00vV1ZDRS8zdVE3Ui9LU3hq?=
 =?utf-8?B?VjJDRm9qSENVdlh1VDRHb3o2SVFZS3dUK09NSVZpUjFWUFQ5cTh6S29abldC?=
 =?utf-8?B?clhKeGFjMjlCS2wxUVNNcGdlUExTOU12U0NwUHZ2WG9hNjNtd2lHTHV4OWM3?=
 =?utf-8?B?L2g0L2FiUkg3aFdUbEpDNlVVL1NGRmNRN2J3R2d2b0hwc2N5c3ZkbDRHbnNw?=
 =?utf-8?B?ZnhEaytGTWovVml4OWphZVIrZTRyQ1FaYTc0MFJoS1ZCQnpZdVhRUExJcEZw?=
 =?utf-8?B?QU5PMzVzcU1zL3RnUXQ3WTJMTlB5ak1kNkI2VWNhWTdqZXhQS08yUDA5UG9G?=
 =?utf-8?B?bU8wNEhnWXN5NklIWG1JZW5DNlVTLzBlcjIvRGVNTm5TN3lvb3JrUW5yeE9a?=
 =?utf-8?B?NjZsNCsyUW4vZzI0OFFZSitlYzNLSlNGOHNHdHAvUGRGUy9hb0JDYjRqbElG?=
 =?utf-8?B?VHRnZFVxRWhDR0R2TTU3eldDSllMLytyUzF2aG9keE93RlFUSExaVExDOXF4?=
 =?utf-8?B?aVVTREd0TzVGWHNtWmhpVmJpVTJuTkEvaERGTGcwKzZrdVMvbGY2eSttbG1D?=
 =?utf-8?B?L041cFZhaXV0NXBlT2l5UzZxemlVKzNYNXZqYmc3OGlBY3RabVFLcDh6bHFR?=
 =?utf-8?B?enIxcGtCSlpGYnBDeGhXMHAwYzhzZ1hUYlNHazZzZzUwT0w4dXcxZzQ1VFBT?=
 =?utf-8?B?eFBHZUc1dm1FWHkyU3FTTVBjK1VGYXljeTI1NHRZTU1UYXFSbnFiZSsrMHBB?=
 =?utf-8?B?N1RRelZnVFYvd3EyYjFIb3dCdzA1LzBvRWlBSDVIZWxLWm9BMGZSMDVmNDh5?=
 =?utf-8?B?TFJ3WllHT1YyblNPS2dqNDVESEtiQ3FTcFloeTBVODZjOEl4ai9uL2tBeTZU?=
 =?utf-8?B?d2VuaStJNUJ5emx2c3NLbHNZSEM1Q0QvcHdkbTIraG9Kc3BVNmlzR3NkYUpM?=
 =?utf-8?B?RERScmM4dCtqSlVJSFF6T3NJRWZ1aEZnY1lFRk9rejVGeFJOWGw1NW5TVzA4?=
 =?utf-8?B?WDNSUlJMbmYrNHFxUE1zbTNDMWRCWUVmKy9oRWUwSyszV2dvWGVKNkpTZkw5?=
 =?utf-8?B?NnhCVjFGNlQ1Yi9sVHc1NERuclJReGFhR1JOODY2eW1MQzhPQS9SRFNhcEZL?=
 =?utf-8?B?dFZyV0xwWUxCZ0xZWHcyeEdGTCs3MU9wMzRoNG9IMEFsQlY2NUZxUUZnRnJm?=
 =?utf-8?B?aTR3ZEJaZlNYdkdtcmVUYUNqTXBkV0k3ZlY1c1NhZFNpbktqZFVmWGlKK0xW?=
 =?utf-8?B?bEM0RVh1MDcxNnRzcU0xQUw0UDdvNkpoS0xXdTlEMWpYcWY4cUI5S3hrT0Rp?=
 =?utf-8?B?RzNGWE1DRndoQ2ViOEVzM05BVXhyb1FhNFg4ZTk5Wm1SR1luK0JQaEVrbnRl?=
 =?utf-8?B?eUxFUlowdmZnR3F0blFDempHRWtTY0pndU1FVG9JejRXb2xRWUpYUDNTaXpW?=
 =?utf-8?B?VW5ISWVpTUJvTEJxVUd2K0FNazNmaTJROVhXdWxTMG56OVlhN0VwQmxFd0Ji?=
 =?utf-8?B?OXlSRjNxaXVNRERUNCszbU4vaFdOR2Y5cnBVVUVxcW42ellmaTl0cCtrR1d1?=
 =?utf-8?B?WmhUL2xlZlpIdnBVZUlrbkE2UDV2Y2x6OHF0UUFHRFFtNGtDcUVENnEyUzRr?=
 =?utf-8?B?OWRkVnY1QWk3a1RWWHoxK2VleXpzS0wvelpFci9DVU9CcVJWSUZzRCtXL3U2?=
 =?utf-8?B?S3llelJ2WkdmWGZhZ0xhSDdMQ3JtUVBmcnlqKzVuNmh5ZDJWK0k4T2owczJL?=
 =?utf-8?B?eWQzc05sVis2UlgzbFlqNDhtR2VBNlZGM2lyaG1aaU1BYlZHVmc4LzlrQ0I1?=
 =?utf-8?B?Y1N3bG1qZDd2WEQ0d3BodnJqYWI1cXpORnJ5SmRYVW1YOVl6RjFQVWgvUnN5?=
 =?utf-8?B?YkZzeE44eXpWS1V4ejFJcnhDSEpkUytDRm1tRk9rVjhXZGN6YzBzUlV1MzhW?=
 =?utf-8?B?SzVlTDMyRUJzMjlRQUdtS1BtSDh0cGNReEpkRzk5MUNwQ1dVNkJFbGpIaTA3?=
 =?utf-8?B?ZEMzQWRBQ0V3S05uSmVUN0tPSjhsNUU4YzFpajJpYzA3OEdkbm1La2JQTkNY?=
 =?utf-8?B?U05qYjRpenZ4UkZidUorQStGUkc2WXVPR21QTDB4TDYvQUdaQzlnaWFSL1E2?=
 =?utf-8?B?NCszS01ObHFTYlZPM3ZmcVpWcGVKUzRhek5XSHJaY1FWMFN3RXJ4SlFNQ1Zi?=
 =?utf-8?B?dFRGUjl2NTdZOUFVYUpaaDk4WnVESWQ2eDVISVJZaytpeHRTSmtZb2NrdUkz?=
 =?utf-8?B?U09aQ1hqQk5LK3dwUHV1NkU3Q1g0U3RMQkI2Z0x6QkpWTzZQK25PMCtHaFpF?=
 =?utf-8?B?YTVtWFdUeFYxUmZKdWIzS1ZMVWRWRVIzRlBFU0tDeklJWjkxZm9SZGZ3L2x4?=
 =?utf-8?Q?zu/pEiNr+z8Kf5yI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <898AAD8B8D05B04BBE2E2258634BC086@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O9kqDXg9abNUFw2DgpEAwZWd9+BvXGYePE6xtLvKtHLI8FKC+5Nv7nxwMbE571JKdeSPQQa9ocaDstZgJpYxviOTq9Hzn8m8EMr2tk1djwfkwsag32HZWZX+RmdiMArw1pHAml9CSoEuhap3bxRUl+29DVBacwyNeXraBpub8FvHP7mV3nZjXfERab5CfcFTlX/y9bDVpEo+BpDzrpnOTlAGVzmhhdTsayN7pav01kwKcBEFOOMVX8fPwYjbFhN/IMCRP2RuOVlIqbhIv0gwx4gTpWUmUFdZ3rma0+eHqojqwH6Ox/QBdkMX2w10z6brSIIhjlMhR8C5WHsS+dSYMg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10926.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bd6f17-1a50-40da-7c5d-08deb0c31d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 07:41:59.2325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNZ/ESixHLF4/GouwlW2UjCaR6vrQIJG7er4zFefgbAxCS7M69ebJjfu/S/fZ/BoDRHVQfnO/k2DWlU2MnLUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13249
Received-SPF: pass client-ip=40.107.74.49; envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU010.outbound.protection.outlook.com
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

DQoNCk9uIDExLzA1LzIwMjYgMjI6MzAsIFBldGVyIFh1IHdyb3RlOg0KPiBXZSB3YW50ZWQgdG8g
cmVtb3ZlIFJETUEgbWlncmF0aW9uIG9uY2UgYnV0IHRoYXQgZGlkbid0IGdvIGZ1cnRoZXIuICBJ
bg0KPiByZWFsaXR5LCB3aXRoIHRoZSBoZWxwIG9mIFpoaWppYW4gaXQncyBpbiBPZGQgRml4ZXMg
c3RhZ2UsIGV2ZW4gaWYgd2UganVzdA0KPiBtZXJnZWQgb25lIG5ldyBwYXJhbWV0ZXIgZm9yIGl0
LCBmb3IgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzLg0KPiANCj4gTWFya3VzIHBvaW50ZWQgb3V0
IHdlJ2QgYmV0dGVyIGhhdmUgYXQgbGVhc3Qgb25lIE06IGZvciBpdCB0byBtYXRjaA0KPiBhbnl0
aGluZyB0aGF0IGlzIG5vdCBvcnBoYW5lZC4NCj4gDQo+IFJlbW92ZSB0aGUgWDogZm9yIE1pZ3Jh
dGlvbiBlbnRyeSBmb3IgUkRNQSBmaWxlcywgdGhlbiBpdCdsbCBzdGFydCB0byBjb3Zlcg0KPiBS
RE1BIG1pZ3JhdGlvbiBhZ2Fpbi4gS2VlcCB0aGUgc2VwYXJhdGUgZW50cnkgc28gWmhpamlhbiBj
YW4ga2VlcCBnZXR0aW5nDQo+IGNvcGllZCwgYW5kIGNvcHkgdGhlIE06cyBvdmVyIHRvIHNheSBz
b21lb25lIGlzIGNvbGxlY3RpbmcgcGF0Y2hlcy4NCj4gTG9naWNhbGx5IHRoZXNlIE06cyBhcmVu
J3QgbmVlZGVkIGFmdGVyIHJlbW92aW5nIFg6LCBidXQgbWFrZSBpdCBjbGVhcmVyLg0KPiANCj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci81MzI2Yjg1NC1mY2VhLTRhZjYtYTQ3OS03
OTI4ODhhOTRhNGRAZnVqaXRzdS5jb20NCj4gQ2M6IFpoaWppYW4gTGkgKEZ1aml0c3UpIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+DQo+IENjOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhh
dC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCg0K
dGhhbmtzLA0KDQpBY2tlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
DQoNCj4gLS0tDQo+ICAgTUFJTlRBSU5FUlMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5U
QUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggOWQzZDY0NTk1My4uYzU3ZWY0MTNjYSAxMDA2
NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTM3NTgs
MTEgKzM3NTgsMTEgQEAgRjogZG9jcy9kZXZlbC9taWdyYXRpb24vDQo+ICAgRjogcWFwaS9taWdy
YXRpb24uanNvbg0KPiAgIEY6IHRlc3RzL21pZ3JhdGlvbi1zdHJlc3MvDQo+ICAgRjogdXRpbC91
c2VyZmF1bHRmZC5jDQo+IC1YOiBtaWdyYXRpb24vcmRtYSoNCj4gICANCj4gICBSRE1BIE1pZ3Jh
dGlvbg0KPiArTTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiArTTogRmFiaWFubyBS
b3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPg0KPiAgIFI6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCj4gLVI6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gICBTOiBPZGQg
Rml4ZXMNCj4gICBGOiBtaWdyYXRpb24vcmRtYSoNCj4gICBGOiBzY3JpcHRzL3JkbWEtbWlncmF0
aW9uLWhlbHBlci5zaA0K

