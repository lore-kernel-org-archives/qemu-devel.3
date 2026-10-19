Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5611CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdQk-0002kh-9f; Sun, 18 Oct 2026 22:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIdQe-0002k0-IP; Sun, 18 Oct 2026 22:48:48 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIdQc-0003dG-Vk; Sun, 18 Oct 2026 22:48:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS9Ps8nive/8vT9INuGPiNcQ5XniIB2j0xL/RttJrXumDMwJbkikD0LrnEjTSo5YSmGBvsmxREOqQS5biV9KjMt13dpAuHQq1w8j2KU8My+uq6k6K0MW2wZPduTSARhj+umapSDwvsyg0GP9sQdfxLIv0i0mT9iXOWcbdbAYASB0xr8lhd8LyYD0RxnYrrNXOmeDO8QOBqRuSKluaGZymlC4+0ttMk7O7sxZwrZASMs0ZPcTAe6yLldyE0TT4P/zNH7Tfa4eFr5cjpg9eolQgOWUBpXMEKZC2cVG48wMH7BZvN1brnPOQeGzupo316KrpNGI4Zlx9C1kZSa7NqM0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki9ubdWD3fsSOEnIPYNN7Ix5sfUrPk4gVOddbSY/lBQ=;
 b=pNDXWlvCLU9lXqonVE4yNI/Jw2pc3vSpMmC4ydB9csI+1QXnPzl5fMZG/G2pQuvViRIqMOuMxo9Crjhy5xDjC8cBoW6fibvduKv6mHhJwAkIjD7CmK8kfhX8MvXwTqVQsVaCPLE4Z3mfGDCqdaNurt91Z0iBVOKUIm9RsNHhfbVV4xBYktjt8GPmr6F7QzXu34Y58OViV2qaXo9LYzjJlPaGfO5cMVNEfE/3U/QIWLT2Nz16gDrU1FmJQNtzhSCMcexiLPO6BQotQoyJL0SG4p1QMMVBtkGoLc9ITRh21k4sg/6fXKNxW0nxRglBx1IS3Wkjvc2z3t2yJ5cImuR7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki9ubdWD3fsSOEnIPYNN7Ix5sfUrPk4gVOddbSY/lBQ=;
 b=ENKjp6kxNtZ5WrVw9MHnHqHofsk1gEjharksoOEbqj7P1w5oVa4ePrQiHu88K7KP/JHgRoCe+5NairBvHYtfGmXk8Qm+LDOxjyVU71ERrStewxDFP85JQtijEw6BZLgr+sKtq0thxXNzHeZUCqmmU32f6EV0FZnUkqkpDoTGBv7kVkqCyLfiVqBmNTy1FoVOLmHDU5iJeFDqfVo4wuBGlFgCdtLy9GxUb2s3M3JaHENQUV9B2Cf7x0gSO3Fsi/HHd8SPPttQx5aqbfRiuUVM23JuUHpl9ccaPq8NcpyOhJPxxkfMCyrFRf5RhOG9XTPu5JlrXCy8Wet1RFYeKajARA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by OSNPR06MB8211.apcprd06.prod.outlook.com (2603:1096:604:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:48:41 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:48:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Marcelo Manzo
 <marcelomanzo@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
Thread-Topic: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
Thread-Index: AQHdXk5+XKvco56d8k+3dnrLUmlJ+LcEIR0ggAAKIGA=
Date: Mon, 19 Oct 2026 02:48:40 +0000
Message-ID: <SEZPR06MB73626D3F165D892EEA295A9EFC982@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-17-clg@redhat.com>
 <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
 <SEZPR06MB73624DCE6F9E2F004231387CFC982@SEZPR06MB7362.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB73624DCE6F9E2F004231387CFC982@SEZPR06MB7362.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|OSNPR06MB8211:EE_
x-ms-office365-filtering-correlation-id: f43fcae8-9678-4171-3ba6-08df2d8b7bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: oekOWtCh8fOcp7FUPlx+PmdAVb95AGOpPgNuDAaB1fCFbhn+0y1AN5ZASFBfbNDs3uS4548vvxeObv6+3GEg/dAiYKz5DA2YzT2arU92hrRuR6Zfb0G5JgGRonDkJrv0RWnzYheejnW5Ge8NYajWW5dXXrARdPxgXvBJZvgSv2F2qbPFYGV53DLU61QiOgoQcg+/iDpVhp8SkCcnDvewXw2Ujwg6QyB/uPT87At2qvjfPr3+XBsHhkZ0fK2FxvuoRCFuEZg4Ww/1PibC5E+IugNjSFpgLmc4JzmYgisJlzMkOXzslJX2hYK60dTWOpnOoA6G3xfnPQVg5fOmyIJejZF6P6VmaV488QnO2h4/YUNZbhvobWDEdNEnUnhQOp/UhJSId2DXnAU162D4MVFT2s0uW2zAtKXzlIOG/+XOja7NMRjuJ4D28MvMDRjPU28JNNWf3PpI+aD9hHsEsEch/UM5sVIFt8bBt2pVKTbV7OFHBU8CZE8E+5ZBEk7b7BXXqm5dE1Qby1rxEuesKe0M6yXfubXb4SHo4VmMHcpgyJ7bRgktgPzHzKfCbWsM53kTOK2a5dzZWimZeY3D/sB4PCSzQRnGIyxnitipCwwDtySb2NlezuTArcayMgE/YpN+DDmYYdUiGcz/3y6WipSrIvyQ7VOd6HgqaoNKuqdvhA0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3dRazh0eDYzYUtyNHRQSWg4NE5rQjBKa0tGblpLZlh4RGMxU0tmZGRlQmRN?=
 =?utf-8?B?WHNidmc5OWk0SE96UkZ1RlMrNGVrVmJXMDNTWXExYk5tM2FYWW5ESlJtWUNz?=
 =?utf-8?B?THRaWnZvVGRtbUtvYTdOSDRobUlpZXdIWmxzdDZBcUtkdnpkOGQyU2xuektZ?=
 =?utf-8?B?M1JIVVpaMDhYNFd0Zm9ncG9uZkJDdnNaaE92cXkrNkd0V0JoOU9HT3dVdndT?=
 =?utf-8?B?SDY0MlpsR09lRGVJMVY4am5QK09RSHY3Q2JIYW9JN0k4U3c4eTVXZjFQL1J0?=
 =?utf-8?B?TkZSUUdwTVNPQzJ4T1FuOUxXRmNYNmh2ZW1Eb292bGQzaGt3NVc2TzlKbDI0?=
 =?utf-8?B?VlNaMTV2QW0xRUZibHk0NHlBaU43Zk5hem01QkhKTTNTQXo4eDZrMDh5cXBM?=
 =?utf-8?B?VHJWNXpQNzFJb1JXUlNWK1BGSUVHYkIvNWl2MXIxRkphWmd3VnNDWDQ2eHFG?=
 =?utf-8?B?amxZWHpEYUxVL2xXd3ZNNUsya3ZBTWlZd3ZHUmR3WmgrbnFXWkpMQWFrYng0?=
 =?utf-8?B?Y1NOcy9SdElMYkFscnZXMWRMcUdIOUVna2V0MWZiRnExZ0JuVERkYzEza2gv?=
 =?utf-8?B?RXFWcTVzRDZOWG1lOFZlS0JBRjJmSTM2Z0EyVGRoYmlibFFwWjB5dmtmTUpL?=
 =?utf-8?B?T1JMS3J3TW5Kd0ZzQ3QvVStWTmc3blRqTnpoM2k4THhSQXhtdkhoblQvbDZl?=
 =?utf-8?B?aGJqak8vaTl6alFPSC9EMkllTGdRQ2loYzdRL25CT0RIZDhmRjFHMERuaXZn?=
 =?utf-8?B?eHNsYVJTbWJqYitXRFNPc1J4WXRDaEV1TGlMSDBpeFF4RVordWZPalQ0RExS?=
 =?utf-8?B?RUloQjBEeVpJSmNuQ0ozZThIdldsMnAyS0FLcGpUUEVJUTlUeWw1bHpKTisz?=
 =?utf-8?B?NnpYdFlnSzdYZmFYRUoxVXU3bjJndStmaDllYk9LOUxobFgrMFlobklQSnVo?=
 =?utf-8?B?VWNqRVJoQUVIeFlYOGtGZk1hWG1iZkJEMGdBdUNpNVhrOGhNUmpXTXZ3L0Q2?=
 =?utf-8?B?VFhtekJZdXpoQ0V6anF6KzRXelFKVDJ1SGRia1VhSzh0enhKWE11cU5EOGJl?=
 =?utf-8?B?RjBVYVVCT1p3ZTZXTkhLQ0FrUmFvSUxnTUc4MllRVGRWNi9ldjNxV3NZRE9j?=
 =?utf-8?B?Q2hjZFFqRjVISUJNMTl4OUtsMVM1WWJyRVMyREFtL2pBZXVGNHczZE9yMDhZ?=
 =?utf-8?B?bWM5YUFZVS9EOVVQS2lJQTJXUDdmWitDRGNYczRMVTl4Q3ZuSkhEektUNGEr?=
 =?utf-8?B?UnRnZXFoMjRQQ2JENmJPdlIrZldPbnRSNCtRVVJOdlkvc0pDWXUyVThLWTZX?=
 =?utf-8?B?SEF2WkhyWmkyY1ZQRElOakk5UnNFU2ZPRlZVeTVsbS9EbWlsSkhpQjNzTnlQ?=
 =?utf-8?B?SzhiOWFmNlFKNTZ0TUtsR3YvUU5CQnRKY2U2ay9JSVUvQm5nbk1tTUR5RUJY?=
 =?utf-8?B?YXltWFFjVVVJY285eFlpNGhuSTdPWHhCZUpEZHEwMWpJeGZTL3AyUUtIV1VV?=
 =?utf-8?B?RGdVZVlCTGZYbmp2OXN1aWlBeHpjTEVqdlpEVjRuYUkrMjRGcnU1ekovQjFv?=
 =?utf-8?B?V2xOZndvNitldUo5VlNUbDhFME5VVldwaUVCNzYydzBMbXdzYlNtcmx5WXhu?=
 =?utf-8?B?M1VMOVpBQ0pTU1lIeXY2K09NUEl3bHJyOUhweTF5TEs5djZVYSt0cHZLMytn?=
 =?utf-8?B?WnFNOTNDQnQ2MzlzUE9zR3FuOW4rSXNWVUZmRU5WcHI4VHBMa3gzejNSWXgx?=
 =?utf-8?B?OGZRWUVza0FsdHVuc0RmUFVvN1FPVXkxZFFiMnF3RGVrYTBLUVQ5MUZCakJC?=
 =?utf-8?B?TEJUbnAxWDdHSEJoVlRTQmhXMjlRTVRVSE5VNjQ4ODVEaGVFUE1oUVdaWmRl?=
 =?utf-8?B?akJVcXowb3N1bCtDL01mRllQUEVZcXowcUovdHk0Y2FnajJGV3VsY2syZFph?=
 =?utf-8?B?NlFjekh2enFka0NEVnI5YU52TDBoTnVjcEdla1AxVldKRHRISWNvc3lDcVlu?=
 =?utf-8?B?MGVsUlhlYythaE1WcWh6Mk9yVjllQ0FRODVnSFUvL1UvdndpeExQbzBRN2px?=
 =?utf-8?B?aEowa3J5TEFvWndDVTlYbTZxN3AvSUo5NEp6R0M4RWtLNlVyUENWcTJMQ0FP?=
 =?utf-8?B?VGNqRVFEKzd0eTNFTGZWRGprRnVCWWNSeGZRR0VzOWJkMGY5bXArY1ZUWTdE?=
 =?utf-8?B?YU9tWndtbmhCTk52N1VzUkRFWm1LelRoNUsrSjVlOHVWMm92QmhFUlMvL2Jp?=
 =?utf-8?B?bFRuUFNIWmo4R0RVUi9LcllvbnBrYjQ2SXJTY1cxdlpwYk1KTjcvWHlFR1hK?=
 =?utf-8?B?bjh5K3EwdWU2OFJYeWdlVEs3d1dMbVJnQUpRbHVLRnVxRFRkblMwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hC+/yxkjXisr2CRLH1XD9uj+ZYHhnb76UwDc/U1QBekKdqlTCWoKUUgNzE0YC37TfPUkd6GBX9yMeDMxvHQGrpWo8Tiqdy/hXW9Vugth81qFM+msj76law+/8KOmo1xZsEf5jnAxr7vztc0dQ0dokAY1B2sD70kKwyyxJUCkM1GQnK+jcvDo4qkzjXGSSQ3Gwdz2fDwxi1RYupP5I3G65j4yAvi7K0ASF0HpKg4s6XtPuSL5qCxG4QaVZfrOdOty17I9BorJ1D90RJ70WtcoYEevsziUtqHjTfU14VIFc6wXoCvXQScRsXHPKuEsawwxPuHcbIjAtbc1DlLBnrU1fA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43fcae8-9678-4171-3ba6-08df2d8b7bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:48:40.8353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hH4avMGaQ0yHlgZoGJeUT/fRnz/6zrDfULe86q9G0RUQhRx3jWO86XY8xdDKk/ZXl/nt2DER6pGtPw2KJQtiHoa6uyM2JiJt4c/3+I4hP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8211
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

PiBTdWJqZWN0OiBSRTogW1BVTEwgMTYvMzJdIGh3L3BjaS1ob3N0L2FzcGVlZDogQWRkIEFTVDI2
MDAgUENJZSBjb25maWcgc3BhY2UNCj4gYW5kIGhvc3QgYnJpZGdlDQo+IA0KPiBIaSBQZXRlciwg
TWFyY2Vsbw0KPiANCj4gKg0KPiA+IFN1YmplY3Q6IFJlOiBbUFVMTCAxNi8zMl0gaHcvcGNpLWhv
c3QvYXNwZWVkOiBBZGQgQVNUMjYwMCBQQ0llIGNvbmZpZw0KPiA+IHNwYWNlIGFuZCBob3N0IGJy
aWRnZQ0KPiA+DQo+ID4gT24gTW9uLCAyOSBTZXB0IDIwMjUgYXQgMTc6NTQsIEPDqWRyaWMgTGUg
R29hdGVyIDxjbGdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gPg0KPiA+ID4gSW50cm9kdWNlIFBD
SWUgY29uZmlnIGFuZCBob3N0IGJyaWRnZSBtb2RlbCBmb3IgdGhlIEFTVDI2MDAgcGxhdGZvcm0u
DQo+ID4NCj4gPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yY19jbGFzc19pbml0KE9iamVj
dENsYXNzICprbGFzcywgY29uc3QNCj4gPiA+ICt2b2lkDQo+ID4gPiArKmRhdGEpIHsNCj4gPiA+
ICsgICAgUENJSG9zdEJyaWRnZUNsYXNzICpoYyA9IFBDSV9IT1NUX0JSSURHRV9DTEFTUyhrbGFz
cyk7DQo+ID4gPiArICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+
ID4gPiArDQo+ID4gPiArICAgIGRjLT5kZXNjID0gIkFTUEVFRCBQQ0llIFJDIjsNCj4gPiA+ICsg
ICAgZGMtPnJlYWxpemUgPSBhc3BlZWRfcGNpZV9yY19yZWFsaXplOw0KPiA+ID4gKyAgICBkYy0+
ZndfbmFtZSA9ICJwY2kiOw0KPiA+ID4gKyAgICBzZXRfYml0KERFVklDRV9DQVRFR09SWV9CUklE
R0UsIGRjLT5jYXRlZ29yaWVzKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgaGMtPnJvb3RfYnVzX3Bh
dGggPSBhc3BlZWRfcGNpZV9yY19yb290X2J1c19wYXRoOw0KPiA+ID4gKyAgICBkZXZpY2VfY2xh
c3Nfc2V0X3Byb3BzKGRjLCBhc3BlZWRfcGNpZV9yY19wcm9wcyk7DQo+ID4gPiArDQo+ID4gPiAr
ICAgIG1zaV9ub25icm9rZW4gPSB0cnVlOw0KPiA+DQo+ID4gVGhpcyBzZXRzIHRoZSBtc2lfbm9u
YnJva2VuIGdsb2JhbCBpbiB0aGUgY2xhc3MgaW5pdCwgd2hpY2ggaXMgcnVuIGZvcg0KPiA+IGV2
ZXJ5IHR5cGUgY29tcGlsZWQgaW50byBRRU1VIGF0IHN0YXJ0dXAuIFRoYXQgbWVhbnMgaXQncyBl
ZmZlY3RpdmVseQ0KPiBmb3JjaW5nIGl0IHRvICd0cnVlJw0KPiA+IGZvciBldmVyeSBtYWNoaW5l
IHR5cGUsIHdoZXRoZXIgaXQncyBhc3BlZWQgb3Igbm90Lg0KPiA+DQo+ID4gWW91J3JlIHN1cHBv
c2VkIHRvIHNldCB0aGlzIGluIHlvdXIgJ3JlYWxpemUnIG1ldGhvZCwgc28gaXQgb25seSB0YWtl
cw0KPiA+IGVmZmVjdCBpZiB5b3VyIGludGVycnVwdCBjb250cm9sbGVyL1BDSSBjb250cm9sbGVy
L2V0YyBpcyBhY3R1YWxseSBiZWluZyB1c2VkLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IE1hcmNl
bG8gTWFuem8gPG1hcmNlbG9tYW56b0BnbWFpbC5jb20+DQo+ID4NCj4gPiB0aGFua3MNCj4gPiAt
LSBQTU0NCj4gDQo+IFRoYW5rcyBmb3IgcmVwb3J0IHRoaXMgaXNzdWUuDQo+IFdpbGwgZml4IGl0
IHNvb24uDQo+IEphbWluDQoNClBsZWFzZSBoZWxwIHRvIHJldmlldy4NCmh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL3BhdGNoLzIwMjYxMDE5MDI0NDQxLjM1
NTQzMjktMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQoNClRoYW5rcywNCkphbWluDQo=

