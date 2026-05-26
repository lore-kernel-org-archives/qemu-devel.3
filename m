Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95A5CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 05:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRkD1-0002q8-7W; Tue, 26 May 2026 01:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRkD0-0002pW-8n; Tue, 26 May 2026 01:20:06 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRkCy-00005D-AJ; Tue, 26 May 2026 01:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQOO8wsB8+z2ThpoE95qM79lqRPic9sZFaEtwttRg8SYpJXcvKcJC2QVLHbBbVZtuPKyStm2Ec+H/S3QxtSpcxU03p6BaJEBhQaHXFKQFWiAH/lzZTAzWdy8uao6rvh73l1nfj2+WuAtY2rL7DCmNXhKaDTYIlRe44AMg1cHO9P3IiSvVkDkH9rhAMGwqhOncQvjZM4xxloGjONKfeNRffiD7U+awfeTmcOzC82N7y3eEdhGOeV8GD+CUEEL/edFiDH1NnWffDLd1fPnfuRtFex4qL5M8fV7ZJjvdfM3PVtdIakJp3uYKm3yvZLXViaR2ExDohkGIjkAnAfce9WMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeeO3tDuMn80D8dsJI/bO6mSUhWMBWbP7/dhMV8jO8c=;
 b=cy1LAT38xzJ1PIrDgibBxDj6w9RHdu2/I56APpDTVfH1sKbe530ldrAmkGf+H4B1EF84qCkQavk2bb0E/F6V4F+2d+SYy88q+TguIXfCw6bEU5X92PKtbDpkmNkaBIVVQCQlnS9NY4Xc/cJAJDc1wxUM/MOExme95AGuULcOMAxzQUfTBKAIogrLrj2oXgbQGM/fbuSYrLkvGEakriYAh0ICtx0tT1smba6ho9jvkm5jPNlG/079zfY5/PXR9os/su3MneOjWGWp3EyuQFb9Y6hhBXEZwN/70ZqrLW6tWuofVJtnV2GSQoSshsnZ0vGN0bcacq/K7KmGWUb2arjYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeeO3tDuMn80D8dsJI/bO6mSUhWMBWbP7/dhMV8jO8c=;
 b=A1DHXWJgpo3Y1YDDZ62GmtAgtcvbIM19Ayor9qqvnUTBWgl/kNsY219TFtx2dshFr+dH4G8xTo0K+4527fW+7iNpD88E4/F2M+4COZV9+Nc+oLLWwqMI09GJcCKabwRvRUkFVxCRRDRN8dzCxTrANCCLqHkizoZW1x6nIw062WDoBUTgAUagl6yN6tRdetQT9/lKHTcaSU517ve9X42tcwoWWy1rSiR/T0fZRHpyC5rZEGCcRcpmhFXIRODyPg9aMXDwk45SfX0OALqjNNVW5AXgeKYQ5HgUHUjxs3G7362nr0VtHagjwR75ug9P+/2p1K+5FzN0eXtG8WFuSnJ1jQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF2322611A7.apcprd06.prod.outlook.com (2603:1096:408::90a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 05:19:56 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 05:19:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Topic: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Index: AQHc7ADBTVFYQA+5Q0qXUei6Cq1nDbYeKeNAgAGa0YCAAAAzwIAAASmAgAAAQiA=
Date: Tue, 26 May 2026 05:19:56 +0000
Message-ID: <TYPPR06MB820648C51641C3248A26735FFC0B2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
 <TYPPR06MB8206D1D6B283918E5FDC9172FC0A2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <5207df68-1010-40af-a369-ac4b8a11e57c@kaod.org>
 <TYPPR06MB8206D1FF1AE00706FD371E82FC0B2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <ec384f92-fd55-40aa-a66f-7cf360576986@kaod.org>
In-Reply-To: <ec384f92-fd55-40aa-a66f-7cf360576986@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF2322611A7:EE_
x-ms-office365-filtering-correlation-id: 18e40b5b-01a9-4022-4914-08debae66cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021|4143699003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: WrzCj3/ujR2eHhOzManAcY5HRtGuusA/UUsixg0bYnJCzrDDG81jx/Kq7mD2LPO/FFdNztLbXcbeZn9Mw10cMVbj2QQSKLZKHVM73rxEfNP8kArdBWShO+oT6ZfJpV79qZ9YIabNT5D3QSEcobY9EICpG8stCaenc5/v6vCJdsqnDVnVaWN7Um2pIAuGfMUc0N+xlsGX+n9UTyIZTpBNxYVBeXjCBmTdd2UA/6AR7jhVmjBIz+KZk5ysj+QJRRxPYGErSU+yHNtA9p8ZbxsHOzoBDCiL26POir/INGMUWDDdajb7A8N57p8agTu6ztVUzGVs0Fv4eNoXnPLbSbY/P353jkYfIyNkSMn0QR//AwScSzhs16BivJ1f71SPNZzj+NJk4xf62erKWBy2GVyAHbMeVR36sHiQBOFsupHGTjvwbqwxk5edRjDZFPJFd82qQc6XF7VJ+JtwYKbtVFhKYgTLCUcenfekdNKINoKMXfBMKxmo7iKDo816OXdGh0FVXUcqD3W+z/Lel9TUt9cq8xTgaIp5q9aFqHMuHlGTOE4/2TVZZDZW5KUeO8Q0GnfQfPUsoaZDBpMk+W3VZtnP3uA4HI4QwqR/ZdbO/QP42JdhFgWimRoFDmcZiFzLXu36r7uHd7xHlnvb8ync8sXeqbXAApbV7JdAfVD0Yh1A50ghidinku7i+jtLn3H/UdePdCe+An2y6EKP996XqV66dqq94YcMuYstYv3X80OtzAZ9clu9m0N0r+NPOFx51YVghei2cl8uz0aWJr496SuFhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWFjWThkbG42WVhZU0xGenNZdktHeGhLL04za1FCZ0xXKzdtOXR5UGNvOURl?=
 =?utf-8?B?c3Byb0E2VS91OVFKbkZGZE96QjAwUHNZQ0E3SmtsUEVKUUcvSTZmaENGK3Jw?=
 =?utf-8?B?MFloeVFlaEladXY1RkNEN1FqdkJnNU1oeVUxMVo4cmtrNzV6MVFaL3RGV1NF?=
 =?utf-8?B?a1RRTklUUElCUmFTK2pRRHlIOFQvTGZ2STBScDMzUlpYKzYvU3BIZktHWGE0?=
 =?utf-8?B?cE92SEV4ZllScFM5YkNSMmt3NXNtamJNYTJTVXEraHNnUzVJeFFDSVZmR2gr?=
 =?utf-8?B?aEdrb2ZoRVM2dnQzVmltSFdESEtaWHUyNHZKUzV2ZTFvb0Fsd2NUSFFpQllO?=
 =?utf-8?B?bHBBYVdtV0EzNk1XVVRIUDNrbEQ5dFpPVDJuSnJkcHl6Sk1pOE11dS9VWko1?=
 =?utf-8?B?c3EzK0NVNDJETGFLT0cvaXEvUWtsTmxMS2FOSm80ZmxuZWlyWHIrcVdCT2J3?=
 =?utf-8?B?WDcrYXVIaFFmNW4wMGFwZElXQlV1cUtJWVJ1ZnRFc1N1dEpLalJQZnN1b204?=
 =?utf-8?B?aHhsbzIxM3VENFU5NHFZYWVyMHl6ci9LbWxWMnZWdVNaYnh4ckdrOVE1WHhJ?=
 =?utf-8?B?WXRCY2x4Nk41KzdxdmpSWk9NOXRQdmNYNk0xTnhuOTBvcVR5c2hmTUZ5bXJ6?=
 =?utf-8?B?T2wxWkI3QTV1c1J1WlhSbktDbWVSTnBJbkxTYWh3N3dlY3lsYWsyV3ZZNFlp?=
 =?utf-8?B?VG45c0dKeStEVmlFSHpKUVQ1NUhpd1g1K2FwZlYyYlppdzJKTHA4dmpBZkVN?=
 =?utf-8?B?bExrZHJlTmhsN2VhdDJtZkM0Mk5rd0x1Rk95UUNkYk93dHgvUm5ISGNIMEx4?=
 =?utf-8?B?eXRMa3R6WE9mRFB4YXlwSVRvUURNNEpXTGUzZEtKdk5CSERRUE1LVE9ndzV2?=
 =?utf-8?B?c1RIK2JHRjUrc2VjaExkaVhFSEcxOUc4dGlPRjJvRHV4UUQxdVFGcndyaWJt?=
 =?utf-8?B?WDB2ZlhuN3N3c1QyVHFiRThwcnRpUCtvWTJrbFoxNnNhbDFva3FCbHg0cE5m?=
 =?utf-8?B?Vno2WGJSblJpVE4wNXc3dHVLWisyekorS1J6VkFta3h2RDJnRFI3dStJQTJZ?=
 =?utf-8?B?U1o0UUFDTGN5amRQZWRvY3Zzei9vM2l4dzJDOWdxbUFRc3hmMjlWTUh2Y0li?=
 =?utf-8?B?eUNRa1pRNjVZUW9OK0x3OGl0ZmZYWXBza0JEMzAvMlJ4dDdQZzNlUDBkdC80?=
 =?utf-8?B?YmJqaTZ1VEZIVzdMejRWVG9BSFJ3amJTSWJUZXZQYWZ1NktYNnFDeEVTQXdl?=
 =?utf-8?B?QndrYzlmQldhMTZDUVo3Z0NRK1FIMENQWlpwaUwzT2FaendIQUZjYXYraGJw?=
 =?utf-8?B?TlFoNkFBSlJId1RUMnU5WGNFRjNmZk00Q3BoMk9KS0JhZWN6NFRHNlVmSEJU?=
 =?utf-8?B?UU11WnVSbHhZUWlwaDVZUXMySi9wWFRhZmFlbEdkbkRORGRYMU5nMW1rb1Rs?=
 =?utf-8?B?bm4zcDhUY1oyVG5LdzRKbXpaR3FEM0lQVmhkQnVaNzVkU1FuOXRxQ1AxOHRH?=
 =?utf-8?B?NzRsa0RMUFFFbHV1OWZXckhSaUxPcXlPVHo5bkZDUUxiY2xmWUxUdU1PZjlN?=
 =?utf-8?B?VGJuVjBhZEgvN2t6SXNQVytYZDh5NFVKdnlmbWo3NTBPUEwvTGxibG93VmI2?=
 =?utf-8?B?bys0SDE0bEZEM3ZpM2hsT2kxcFRybTRReXppMGx0L3JDblNHZ0ZBa1IzSmJH?=
 =?utf-8?B?RFlmOUJyUzJ6SVdvblptME9mN3NQNytEOXdqbkYxYkhMTFIxaHIvTmpPQzNV?=
 =?utf-8?B?eGRVYUd6K2JpSE1YZzlFR1NvanZxQkhoTHVmMHNJNzA0TFd1V1VVMFd0REVE?=
 =?utf-8?B?SlRuRHZkSW9EUVQ1UUoxQUFPcng1UVdPNXp3UHkyQ3MrTmt4YmlRM3pEYjQ0?=
 =?utf-8?B?a01sMW85T3RINlBFSFRUZnFkeXBoZ2lBeVcxSzZpSHpBK1B1a05Bbkd4ay9G?=
 =?utf-8?B?V2x2WFp0Q0NTYmxBbEtvQkFteFh2TDRtV3oxVGFoQkkyYVEzSmJuc0x3S1FX?=
 =?utf-8?B?NzFiUTBrMlp2ejNCOUlVRVF2YTYxTjlzZ0dQamd0V0ZvcmtIWGZHQVNXaE8x?=
 =?utf-8?B?MFkrTFNFbU45Z2pUcHBmYnNtOTI3T0VFS1ZSb29HTzloclBMMllSRmJKRnFV?=
 =?utf-8?B?YnI3dUUxS0xHY2RDd2E5ZXY3YTdwSVpuc3hseWdOdFQwcUx0REoxd2MzT3RY?=
 =?utf-8?B?UVpHbmRWUnhaRTNHNmFKUzV6eHJWeHI2NEtyL3NzamxRbUZMOU9yOFRPclQ5?=
 =?utf-8?B?Sm5ncDVFMk4zV0U0UHdQNDU3NjhrOG5DbkJmT1lya2RFcWwyZ1lCQTRsMUs4?=
 =?utf-8?B?RTcranp5RWY3Vm02VXF4bHdZTnlBVHd4MEtXRmxaU08wQ05Ba2FEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FIi0FIj1rXwyhn/MG6tBprHtbdJ3/kRVigGNZ2wPqRmR/jGtqeHan0DAlwaTCAFlrxTyTr53hBVg0an6ILP2RZv2AoSf8zYJ+NRW9E2rHDNlfXCb6DJY/63ABzHzPsyAU6HA3DlOdRePtfH0OpLMeapeeq6ze7SGBhRaj/0d87LkyDdd5ICgZPL9ta7IkecopYuIc+bThQy5ZtIwDe0G9Nt4ZjAr+zwTGWzH+CkBpu8Kkq/ySPelykJbv2spro7KW4B78JiNLx3p3aCdFL2oqOLTY0LH5OonR33ZGojf505p7+63quP+6ADcvwT4sWdjAMrbd2p+G/aKj2jFepEtZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e40b5b-01a9-4022-4914-08debae66cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 05:19:56.2482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f12ukToNvMRzwj3QBnTAD6z6jaoxsKsZDlcs2qRodK4QepcZ0BrMVHDlx26wvwLZyqGGB8UiQ3yzcuOz9tbq9LevEl6/ir6vAqhKgP1q3gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF2322611A7
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAwLzIzXSBody9hc3BlZWQ6IENvbnZlcnQgQXNwZWVk
IGRldmljZXMgdG8gdXNlDQo+IFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+IA0KPiBPbiA1LzI2LzI2
IDA3OjE0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAa2FvZC5vcmc+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNiwgMjAyNiAxOjEzIFBNDQo+
ID4+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEthbmUgQ2hlbg0K
PiA+PiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnPjsNCj4gPj4gU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFRyb3kgTGVlDQo+IDxsZWV0cm95QGdtYWlsLmNvbT47DQo+ID4+IEFuZHJldyBKZWZm
ZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkNCj4gPj4gPGpv
ZWxAam1zLmlkLmF1PjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT47
IE5pbmFkDQo+ID4+IFBhbHN1bGUgPG5pbmFkQGxpbnV4LmlibS5jb20+OyBKb2UgS29tbG9kaSA8
a29tbG9kaUBnb29nbGUuY29tPjsNCj4gPj4gTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdv
b2dsZS5jb20+OyBKYXNvbiBXYW5nDQo+ID4+IDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgb3BlbiBs
aXN0OkFTUEVFRCBCTUNzDQo+IDxxZW11LWFybUBub25nbnUub3JnPjsNCj4gPj4gb3BlbiBsaXN0
OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gQ2M6IFRy
b3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MSAwMC8yM10gaHcvYXNwZWVkOiBDb252ZXJ0IEFzcGVlZCBkZXZpY2VzIHRvDQo+ID4+IHVz
ZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+Pg0KPiA+PiBKYW1pbiwNCj4gPj4NCj4gPj4gT24g
NS8yNS8yNiAwNjo0NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IFN1YmplY3Q6IFtQQVRDSCB2
MSAwMC8yM10gaHcvYXNwZWVkOiBDb252ZXJ0IEFzcGVlZCBkZXZpY2VzIHRvIHVzZQ0KPiA+Pj4+
IFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4NCj4gPj4+PiBIaSwNCj4gPj4+Pg0KPiA+Pj4+
IFRoaXMgc2VyaWVzIGNvbnZlcnRzIEFzcGVlZCBkZXZpY2UgZHJpdmVycyBmcm9tIHRoZSBsZWdh
Y3kgcmVzZXQNCj4gPj4+PiBjYWxsYmFjayByZWdpc3RlcmVkIHZpYSBkZXZpY2VfY2xhc3Nfc2V0
X2xlZ2FjeV9yZXNldCgpIHRvIHRoZQ0KPiA+Pj4+IFJlc2V0dGFibGUgaW50ZXJmYWNlIGJ5IHNl
dHRpbmcgcmMtPnBoYXNlcy5ob2xkIGRpcmVjdGx5Lg0KPiA+Pj4+DQo+ID4+Pj4gQmVzdCBSZWdh
cmRzLA0KPiA+Pj4+IEthbmUNCj4gPj4+PiAtLS0NCj4gPj4+Pg0KPiA+Pj4+IEthbmUtQ2hlbi1B
UyAoMjMpOg0KPiA+Pj4+ICAgICBody9taXNjL2FzcGVlZF9wd206IGNvbnZlcnQgdG8gdXNlIFJl
c2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3L21pc2MvYXNwZWVkX3BlY2k6IGNvbnZl
cnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3L21pc2MvYXNwZWVk
X2hhY2U6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3
L21pc2MvYXNwZWVkX3NiYzogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4g
Pj4+PiAgICAgaHcvbWlzYy9hc3BlZWRfeGRtYTogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBp
bnRlcmZhY2UNCj4gPj4+PiAgICAgaHcvbWlzYy9hc3BlZWRfbHBjOiBjb252ZXJ0IHRvIHVzZSBS
ZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+Pj4+ICAgICBody9taXNjL2FzcGVlZF9zZG1jOiBjb252
ZXJ0IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+Pj4+ICAgICBody9taXNjL2FzcGVl
ZF9zY3U6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3
L21pc2MvYXNwZWVkX2x0cGk6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+
ID4+Pj4gICAgIGh3L3BjaS1ob3N0L2FzcGVlZF9wY2llOiBjb252ZXJ0IHRvIHVzZSBSZXNldHRh
YmxlIGludGVyZmFjZQ0KPiA+Pj4+ICAgICBody90aW1lci9hc3BlZWRfdGltZXI6IGNvbnZlcnQg
dG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3L2dwaW8vYXNwZWVkX2dw
aW86IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3L3Nk
L2FzcGVlZF9zZGhjaTogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4+
PiAgICAgaHcvc3NpL2FzcGVlZF9zbWM6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJm
YWNlDQo+ID4+Pj4gICAgIGh3L2ludGMvYXNwZWVkX3ZpYzogY29udmVydCB0byB1c2UgUmVzZXR0
YWJsZSBpbnRlcmZhY2UNCj4gPj4+PiAgICAgaHcvaW50Yy9hc3BlZWRfaW50YzogY29udmVydCB0
byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4+PiAgICAgaHcvaTNjL2FzcGVlZF9pM2M6
IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3L3dhdGNo
ZG9nL3dkdF9hc3BlZWQ6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+
Pj4gICAgIGh3L25ldC9mdGdtYWMxMDA6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJm
YWNlDQo+ID4+Pj4gICAgIGh3L2ZzaS9hc3BlZWRfYXBiMm9wYjogY29udmVydCB0byB1c2UgUmVz
ZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4+PiAgICAgaHcvcnRjL2FzcGVlZF9ydGM6IGNvbnZlcnQg
dG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+Pj4gICAgIGh3L2FkYy9hc3BlZWRfYWRj
OiBjb252ZXJ0IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+Pj4+ICAgICBody9pMmMv
YXNwZWVkX2kyYzogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4+Pg0K
PiA+Pj4+ICAgIGh3L2FkYy9hc3BlZWRfYWRjLmMgICAgICAgfCAgNyArKysrLS0tDQo+ID4+Pj4g
ICAgaHcvZnNpL2FzcGVlZF9hcGIyb3BiLmMgICB8ICA3ICsrKystLS0NCj4gPj4+PiAgICBody9n
cGlvL2FzcGVlZF9ncGlvLmMgICAgIHwgIDcgKysrKy0tLQ0KPiA+Pj4+ICAgIGh3L2kyYy9hc3Bl
ZWRfaTJjLmMgICAgICAgfCAxNCArKysrKysrKy0tLS0tLQ0KPiA+Pj4+ICAgIGh3L2kzYy9hc3Bl
ZWRfaTNjLmMgICAgICAgfCAgNyArKysrLS0tDQo+ID4+Pj4gICAgaHcvaW50Yy9hc3BlZWRfaW50
Yy5jICAgICB8ICA3ICsrKystLS0NCj4gPj4+PiAgICBody9pbnRjL2FzcGVlZF92aWMuYyAgICAg
IHwgIDcgKysrKy0tLQ0KPiA+Pj4+ICAgIGh3L21pc2MvYXNwZWVkX2hhY2UuYyAgICAgfCAgNyAr
KysrLS0tDQo+ID4+Pj4gICAgaHcvbWlzYy9hc3BlZWRfbHBjLmMgICAgICB8ICA3ICsrKystLS0N
Cj4gPj4+PiAgICBody9taXNjL2FzcGVlZF9sdHBpLmMgICAgIHwgIDcgKysrKy0tLQ0KPiA+Pj4+
ICAgIGh3L21pc2MvYXNwZWVkX3BlY2kuYyAgICAgfCAgNyArKysrLS0tDQo+ID4+Pj4gICAgaHcv
bWlzYy9hc3BlZWRfcHdtLmMgICAgICB8ICA3ICsrKystLS0NCj4gPj4+PiAgICBody9taXNjL2Fz
cGVlZF9zYmMuYyAgICAgIHwgIDcgKysrKy0tLQ0KPiA+Pj4+ICAgIGh3L21pc2MvYXNwZWVkX3Nj
dS5jICAgICAgfCAzOQ0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPj4+PiAgICBody9taXNjL2FzcGVlZF9zZG1jLmMgICAgIHwgMTQgKysrKysrKystLS0t
LS0NCj4gPj4+PiAgICBody9taXNjL2FzcGVlZF94ZG1hLmMgICAgIHwgIDcgKysrKy0tLQ0KPiA+
Pj4+ICAgIGh3L25ldC9mdGdtYWMxMDAuYyAgICAgICAgfCAxNCArKysrKysrKy0tLS0tLQ0KPiA+
Pj4+ICAgIGh3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmMgfCAyMSArKysrKysrKysrKystLS0tLS0t
LS0NCj4gPj4+PiAgICBody9ydGMvYXNwZWVkX3J0Yy5jICAgICAgIHwgIDcgKysrKy0tLQ0KPiA+
Pj4+ICAgIGh3L3NkL2FzcGVlZF9zZGhjaS5jICAgICAgfCAgNyArKysrLS0tDQo+ID4+Pj4gICAg
aHcvc3NpL2FzcGVlZF9zbWMuYyAgICAgICB8ICA3ICsrKystLS0NCj4gPj4+PiAgICBody90aW1l
ci9hc3BlZWRfdGltZXIuYyAgIHwgIDcgKysrKy0tLQ0KPiA+Pj4+ICAgIGh3L3dhdGNoZG9nL3dk
dF9hc3BlZWQuYyAgfCAgNyArKysrLS0tDQo+ID4+Pj4gICAgMjMgZmlsZXMgY2hhbmdlZCwgMTMw
IGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4+Pj4gLS0NCj4gPj4+
PiAyLjQzLjANCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNoIHNlcmllcw0KPiA+Pj4NCj4gPj4+IFJl
dmlld2VkLWJ5IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4NCj4g
Pj4+IFRoYW5rcywNCj4gPj4+IEphbWluDQo+ID4+DQo+ID4+DQo+ID4+IFRoaXMgZW1haWwgZGlk
IG5vdCByZWFjaCB0aGUgbWFpbGluZyBsaXN0IGZvciBzb21lIHJlYXNvbi4gQ291bGQgeW91DQo+
ID4+IHJlc2VuZCBwbGVhc2UgPw0KPiA+Pg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnkgSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gSmFtaW4N
Cj4gPg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEMuDQo+IA0KPiBSZXZpZXdlZC1ieTogSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IA0KDQoNClNvcnJ5IEkgbG9zdCAi
OiINCg0KVGhhbmtzIGZvciBoZWxwLg0KDQpKYW1pbg0KPiBDLg0K

