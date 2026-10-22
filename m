Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE40606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=n9vli+d6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmWT-0007qX-PE; Thu, 22 Oct 2026 02:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJmW8-0007nY-GC; Thu, 22 Oct 2026 02:43:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJmW6-0003si-4p; Thu, 22 Oct 2026 02:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th4iU26pDVzduMYcz40W6CgoSxRlfvzdGG1ql0OqrBf4B/1ZynXlJjeclQCzD3fs7YMEk3iiylyh0mg3TLDlg1xP/LC9WFts0vexa+crI7BTnn08sfRzvENOX9p8S88i0kojWoAYoesKu4KTRqm9KgWueCZoCAI6RincnxQP51pTEtr2HsyP9rvL1MtXycZXH9WS1qBQzvMIVtJy/NJqYxdB/3NDU9eugLb5dtXwwkSXMmk1bbks6ygVwHimVR/VscGNtCGtFv+ATlVRX69+SdUYCdd7Eta3YM3+9so7FKowG6NqpRhCTf3MPonDIF+//ISAwRMGpXBQjBzbGqMLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg7kyG7ftex54QxsPmZ7mswtsxTFY4Sicte0w2FVpYU=;
 b=qu0NRP0oa9+2RrUHBl82ga5WsVODoW/w2zZDpM+g8NWSKYWoykk9CFM3GadWUl5UCuXGoIUm/IPY+8fFKJP7oN0WOY9blTQV3SA6zltK4y7isOHlHd4QsceA6eEFF8Gnyo+MtB7n+0MWXIc5b3ThHbTtTYF1K8bYVsdd1OTeBGv2PiX8XNnyo7TpmLXWalLQduK/H1zGegfJq4xSTgqHO1r2wtKHMxVLrsn9IbuwtDW/7udnlniA1UZkGlLEuxw8aA5KrLuA9F/ssgmFAKoDQNtVLQBkStDaox3U0KACLnei+7gwCKLbMheZJS3idsIXTOSYMU5HzGA8g/iGcLYufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg7kyG7ftex54QxsPmZ7mswtsxTFY4Sicte0w2FVpYU=;
 b=n9vli+d6WUSfpF6kC46V286xlQGurjD5eYM73XLZesSROsG4mkS/0vASjVUYRqKsCgkPzp5m/BEP30GO7rTXOydCXdzyq+oesjzCPDVW5k1M3aSdFwoCYJn+fnbwQ/T9ZkFtK+O6OAA9SAuL6cgdgj45K9oYybBuwHEriVIy2LgUjKQCPETAsWEyBP89aQsHfVL6N76HxW3Ud43KysO7yKSq5rEAjsdzESbLIaY2YpHYSuETMp3pPkyGC9y8daHdF9vtJ1v/JMtmTRaOvloTZbdr+knYFJ0CkQwDEwBIcP9lK89cdZSlZ7wx106OVqsW/8EqxWe6+yPSelY2Iau/6g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by OSNPR06MB8980.apcprd06.prod.outlook.com (2603:1096:604:49b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Thu, 22 Oct
 2026 06:42:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 06:42:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>
CC: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Troy Lee
 <troy_lee@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>
Subject: RE: [PATCH v6 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Topic: [PATCH v6 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdX6u11f7u0GqUe0WINlKGYeDSzrcJGEuAgAAHu5A=
Date: Thu, 22 Oct 2026 06:42:59 +0000
Message-ID: <SEZPR06MB736252A8952704EAD52C57DDFC652@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-8-jamin_lin@aspeedtech.com>
 <20261022060855.941871-1-junjie.cao@linux.dev>
In-Reply-To: <20261022060855.941871-1-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|OSNPR06MB8980:EE_
x-ms-office365-filtering-correlation-id: 9cadf900-1372-4f8a-bd3f-08df3007b69d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|10067099003|261021123027099003|18002099003|4143699003|261009223027099003|261021121427099003|38070700021|56012099006;
x-microsoft-antispam-message-info: hngK9hmJQxnINjEz6z1hVHgGmuRysXi4vUAwLkfTQ834OXpQ0LSU9d1uETd2U+sR85oAwRGXLXmHv2P1K5dvil/EQWDlbywUDZLhWR0Sl/ZN++94QP7qSxpF1MPuw/o2vftvOZfqHeoqm1c4roKDw+3BKXdyaxrAChsN4ySNeAF6MIUQlPAmtF97JhGkR+6L6GFaIK3ujKUSQzoc69RPQxwC23Q6CjtJhvdTSkH/0zlnJz5rVPeQY18SZ++dt1NSZvP9pNpAm1kCiVStOUm4zajYtmKEvWInQTnYeepBr586rO0UZX4lDqWjzqq/gZ/LaLSJ76X2aTx5z+f+6MyuSe6JyDhsEmTHwWSpKJSX6vlNYC0yBgyha+JgXJn+c9E0P9R07QUAWvryd6c3PnubST/0EZ98eA26i6I4Gt0aob5xHldQ3cQDpmBp0YUWTCpmubkTymwi6OmVBzpw54uk0/TYCgcv4tcufYvv5jjMWgEaPCgH3GZNc3iSoPAlYT5xyowO/Nyi79T30s/14NC6L1n4POErhM9BhVM+E/Q3CDJwn2N+gjWQyjUvSCyRhAFnCn7tus9FAHN8XUPe8SlXCQQAmzl8KoJB5DRLeEFcCTu8PvI1w2hiCkNNLPzILDtetFEOtbiLfWDPiei3WhM58moEqOdHRfS3f8Ax51JXc5iYpHvTkRhAEXS79cXxtZPiNp58Jq6ZVParp+Jv2GFsMaQY/PAytEIVfFllw0Q+tO0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(261021123027099003)(18002099003)(4143699003)(261009223027099003)(261021121427099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anRvS25rMHJiNGw2cG16bHU1eERwaHhnNy9FSHRvUXVIazZLRmk4WE9JVUR1?=
 =?utf-8?B?OGhuRExVTVViNXgzdjd2VmJhLzJCTU5ObkxVMy9XWU1QVzdsVHNaSzlJYmF2?=
 =?utf-8?B?UWtqdnJWV1pSMlYwQ09DU04rSHhBbjFUUzk5VFFrM1U4WWYyb0RObHozNDNF?=
 =?utf-8?B?MnlheXBac3hyem1pVTRWZWxlSWNWaGV0Qkx5TG5VcXQzY3BUVXp6Mk83Rmha?=
 =?utf-8?B?eWtWZ0FpaFJwUU10VEF4bTVXbitWeDJMS0l2U0hCMlQrcUU2WjNaTHJoTGpu?=
 =?utf-8?B?emdGK1ZHcVVhMTVEMEZKcVJYOHVIdXRFby9YRmQyS25HUGdnUUN3akhpUit6?=
 =?utf-8?B?TEJlZVZiMlk3MDRaTlZWNVNsejRFdGErQ1ZtNlNPWWRhcnl6MkpqM3VPRitE?=
 =?utf-8?B?WlhnVHk1ZU0vNVRlcVBLck0zMEU2MUk0aW05bUZ6TjJialFUSlBqbm9ScXZQ?=
 =?utf-8?B?eTFDNDg2Nk5KMVA2TjFPNy9OcVI5OWhzcHU0VTh3bDhUMUdFb0l2VmExdUVP?=
 =?utf-8?B?UWZJMkxYRERRVFhUelk4OTVRZGQ1cDBoWlh0bjZ4ZTFDRGJpczNrNG15ZzND?=
 =?utf-8?B?TERhSGFIV240S1plU05VUk9kODlCdXBLeFhLS1Iwa05kc3NCVkZNTitxTnc3?=
 =?utf-8?B?S05qcjcxaDRyNWZxZS9jLzhRZkJGaFlWdWNxL1JjdHF0MHlRYWFYMGxjMWYw?=
 =?utf-8?B?WkhxVjk4c2dlV1pDWTNsL2JhdVhYbmNCT0tBVklOMHVUTzhzYjBtZ3hJd1Rj?=
 =?utf-8?B?M2pLU1hWekY2ZHFGYnd0dWxGSW5SZnpxTXQ1VGNtVFE0TVpnT1NScC9NbVM0?=
 =?utf-8?B?RVBFS1B2TVoycmk4b2l1WkJwWFZsMWlMS1N4V1dpbi9xTW5KU0hZSy9scE9q?=
 =?utf-8?B?Mk9rN3IraUhWQkZudjJSYnk5bHFrd3huSlZaa25sUEpHdkV2WHp3OWZrKzll?=
 =?utf-8?B?Q29EKzlMUytPaW1QeURRakIwcDZ2WDJBbjdNSU5nOXc2amtqMElubDhPZ0Q0?=
 =?utf-8?B?aTJzengzTDNkUXUyTGdxVWRtOVRtT3M1Q0kvSjNRQ2JPS3orSG4yOFpCU1Uz?=
 =?utf-8?B?d2ZheFhCRmVEbEwxdkFUK25iN3lxQ1Z5Ynk1OStIcEVzQnRDd1dLWmVxUTRI?=
 =?utf-8?B?dmgxUlU1ZFozeENsNS9zdW1qSE1lWnpCTGd4cW52OHBFSkY2ZExYMXBmejkz?=
 =?utf-8?B?czRrTU1NeG9DMmtGcFlmMlpjQVRMaExyV1Jzcko1M2NZZWlUWUFJdzkvMmRo?=
 =?utf-8?B?TUp0NEg1bDlvOVhmOEtnQ2hiWlBHUzR0ai9tazFWZmRRVlpSSVhMWFhJVGIv?=
 =?utf-8?B?VnhKaC9YS1N4Wjg4TmZYRk1PYjJRdTdjY3BVTlYvbVVlUFJyZy9VaUhWTm1L?=
 =?utf-8?B?V0svblloeU9YTUVkRndNSm9XYktaK0xwUTdDaFU1a3NLWFJtZnJza3VIQ2RS?=
 =?utf-8?B?TU0zTGI2TnpCcHFoTSthZ051ZEVGdFUyamYrZ2EvN00xcFpzUTczT0c4Tko2?=
 =?utf-8?B?bytDSGFQU09pWlltZ1V4SHhiVDI5aW83dTF2ZHhZcDZFK1VQenZvUmhSbjl5?=
 =?utf-8?B?c29WdzRxTkRhMERYMFYva20zd3pLQWdiOXg1djRVZm9zSW9xcjNrbWl0Q1FQ?=
 =?utf-8?B?VnFwRGRGdXRVZk9Rc0lNU3RIeW1WL1JYQzdYMHg5aEFEVkc3TkVjL3VJeXli?=
 =?utf-8?B?Vnp2eW13YWt1TUlxUzQvQktoVVZlV214L2tXY0NPNXBuL3ZYSGZCL2djdTRD?=
 =?utf-8?B?TGh4MTJlNDY0MHVobCtRYTN2OEdXK0tVcDMyTFluUzlFdWlLLzJ2ZGVXZVc3?=
 =?utf-8?B?dWZ5a2h6enJHNGRtdGR2NU96ZmZxcmRuSVR6Nzl4UTAxcGxvUGRFY1ZsZFZK?=
 =?utf-8?B?VG5za3hZZEZsZFIvZWVtRW9GM2YrOVpSNktvaXk5em5MbzA0VlIzNHdHcEJH?=
 =?utf-8?B?cTQwMGMvYTFDYWV6Q2ZLeEx4TGhPejdIQ2pqblczQUNRK3BrT096akRlQ2tG?=
 =?utf-8?B?eE5wS1RuZFYrT2F5OE5wZzdUZnlqVy8ycHFrN0ErejBFd3pQTkpFNVUrV1B0?=
 =?utf-8?B?NTF1aWpmaEV3UklRZXZkYlI4cEpGUXNidjR4ZTlVRURIWFZxZHNWYmJJeEtC?=
 =?utf-8?B?ZjlCREpWVSs3dFM4dnNpbEtlYUVtZU1GQ1dYK2lpWVNEdDhVT21VV2dpT3RX?=
 =?utf-8?B?UmF3T014UUlhbGhxSHllU2MzejJHelJ2OGN0am10bkNsWGE0ZjZRKzdkU0pF?=
 =?utf-8?B?NnkyUE5QQlAwTjlEZUJnOVBrcFU3cUp5cHl2bEk4VU9IeThLTTFRUXFtMjBH?=
 =?utf-8?B?K3IrdW1KL1czUTdDazZFeU9TSk5sUFM1ODNwNzBvUUxUVlgxaXUzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cadf900-1372-4f8a-bd3f-08df3007b69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 06:42:59.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkEH4dNRuiiaUEG2pqB75PBisWwuKPg9a+DTBJlR1IvAikD3P75Puy75Oh8Y7mhcJ4caLwrvbS8vzMY6JKXcK6PvEs7F3Gpvo3CJ3ZOKKAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8980
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSnVuamllLCBtYXJjYW5kcmUubHVyZWF1DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiA3
LzhdIGh3L3VzYi9yZWRpcmVjdC1zZXJ2ZXI6IFN0cmVhbSBpbnRlcnJ1cHQgSU4NCj4gZW5kcG9p
bnRzDQo+IA0KPiBGcm9tOiBKdW5qaWUgQ2FvIDxqdW5qaWUuY2FvQGludGVsLmNvbT4NCj4gDQo+
IEhpIEphbWluLA0KPiANCj4gT24gdjYsIHRoZSBsb2NhbCB0ZXN0IGRldmljZSBkZWxpdmVycyBk
YXRhIGFmdGVyIGFuIElPRVJST1Igd2l0aG91dCBhbm90aGVyDQo+IHN0YXJ0IHJlcXVlc3QuIFNU
QUxMIHN0b3BzIHRoZSBzdHJlYW0uDQo+IA0KPiBXaXRoIGEgYnVsayBJTiBlbmRwb2ludCBhdCAw
eDgzLCB2NiBhY2NlcHRzIHRoZSBzdGFydCByZXF1ZXN0IGFuZCBzZW5kcyB0aGUNCj4gZGF0YSBh
cyBhbiBpbnRlcnJ1cHRfcGFja2V0IGFmdGVyIHRoZSBkZXZpY2Ugd2FrZXMuDQo+IA0KPiBDb3Vs
ZCB3ZSBhbHNvIHJlamVjdCBub24taW50ZXJydXB0IGVuZHBvaW50cyBpbiBzdGFydF9pbnRlcnJ1
cHRfcmVjZWl2aW5nKCk/DQo+IA0KPiBUaGFua3MsDQo+IEp1bmppZQ0KDQpUaGFua3MgZm9yIHRo
ZSByZXZpZXcgYW5kIGZvciB0ZXN0aW5nLg0KDQpJIGFtIHJld29ya2luZyBwYXRjaGVzIDUsIDYg
YW5kIDcgdG8gZml4IHRoZSBlcnJvciBjYXNlcyB5b3UgYm90aCByYWlzZWQuDQoNCkp1bmppZSwg
b24geW91ciBmaXJzdCBwb2ludDogdGhlIHN0cmVhbSBzdGF5aW5nIHVwIGFmdGVyIGFuIElPRVJS
T1IgaXMgb24NCnB1cnBvc2UuIHJlZGlyZWN0LmMgY2xlYXJzIGludGVycnVwdF9zdGFydGVkIG9u
bHkgb24gYSBzdGFsbCwgc28gZW5kaW5nIHRoZQ0Kc3RyZWFtIG9uIGFueSBvdGhlciBlcnJvciB3
b3VsZCBsZWF2ZSB0aGUgaG9zdCB0aGlua2luZyBpdCBzdGlsbCBydW5zLiBUaGUNCm5vbi1pbnRl
cnJ1cHQgZW5kcG9pbnQgeW91IGZvdW5kIGlzIGEgcmVhbCBidWcsIGFuZCB2NyB3aWxsIHJlZnVz
ZSBpdC4NCg0KVGhhbmtzLA0KSmFtaW4NCg==

