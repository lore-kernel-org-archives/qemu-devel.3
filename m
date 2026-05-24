Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C90CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 16:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRBHE-0006Tl-Py; Sun, 24 May 2026 12:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wRBH6-0006QD-RD
 for qemu-devel@nongnu.org; Sun, 24 May 2026 12:02:02 -0400
Received: from mail-northeuropeazon11012071.outbound.protection.outlook.com
 ([52.101.66.71] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wRBH4-0007VL-FX
 for qemu-devel@nongnu.org; Sun, 24 May 2026 12:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imJQth+6pvVsCM6QL+/0LauaejmnbZRJLEwydjwO9rvOXvuaMJrf8nUDhnf1DaHQKcQruABqS1j25qXD7qhB/bsa/Q2FLyx8sfLSwrgXQGle7Nr4kMCV8h2fatjMFFmA4sPLbq502mcGJJ0Mm5l0I+9L8PSau+bu+DnvsgKq2vd4iN9ub2MuVRLj8A5W5a4xnwK6iXV950l6WWxCzTXHZz6FMOy6Mr8L7CTsweXgksP9POJZTlxP585J5KgqOD3bNtL4OhcaotODFJfp8vtfypdLQK+FTgJ50ccXYlaCI/MSkaDPzY0RRO2Vmux83yqB5dVrqGez2nqh9uxknAp0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/bG/Whrz57nXa60syUlWVQKkEJT99J2ROf2LBlcKbo=;
 b=dgB8SQONAuimlVH9hmoxiDhzHWc7wiqI9A69UgUEPHW+tizdYhXrqYs60gYhrQv0Kh5nTobs0oqtzs86dxSxqwNdqCvcITUpARjZQz4GxN3p2qVW4jy9N93CxQeSXHKrixiMs5+b99Q+mroZqRnnV1dDN8f90SzWselKYIK0+PrGoRljr5zSKI5SNjXt6lse6/MAD+uNVxOPsOYVQL+mi6szjSXf6GIQER2H3oWEhdAcpurVNTiLwRVAAT9EQViaQB0I+SNZVdUwXDkipX6sbs2FMvmfp8Rbk2dpRJqmaThULoRyXTl47HPxPQ7AYlAXbikZSnF2vDjZAhNmpjW04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/bG/Whrz57nXa60syUlWVQKkEJT99J2ROf2LBlcKbo=;
 b=Vkjwx3YXySt05fXPOukag902o0IzWRTUOp9Ldb3jQGz1ulQLiIBTyceSyPGvTgd7dCOsAJS0IqmKOdqSery6POsaom0iRJPaunQSxDVKi7zthp+EvQZ9gYay6vz6vNajFgt+5+i6kL+8LUUvkuZACLoCdxFwmuPneM2ubjODMtSE1JwGxTcFnAhpzYdy+wKsRxCpJpTBsSwPh/SkQNz/xrkWG0Aovluzn2K0rjdOHdUS1Xr5ikYl3TUdqkqogjR26HVuErfFTjP7pDgJrirx19pNJ9apCfSWVc0D7VChylFagqAlx2gFP43e75Si9zj1kX2zkbe3GnUOjGN9Fz10uA==
Received: from DB7PR04MB4378.eurprd04.prod.outlook.com (2603:10a6:5:30::33) by
 AM9PR04MB8731.eurprd04.prod.outlook.com (2603:10a6:20b:43e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:56:53 +0000
Received: from DB7PR04MB4378.eurprd04.prod.outlook.com
 ([fe80::309c:a565:2bac:2f49]) by DB7PR04MB4378.eurprd04.prod.outlook.com
 ([fe80::309c:a565:2bac:2f49%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 15:56:52 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "shentey@gmail.com" <shentey@gmail.com>
Subject: RE: [EXT] Re: [PATCHv1 3/7] hw/misc: Add SRC (System Reset
 Controller) to i.MX8MP
Thread-Topic: [EXT] Re: [PATCHv1 3/7] hw/misc: Add SRC (System Reset
 Controller) to i.MX8MP
Thread-Index: AQHc59m9fR91yR5IYk+xqPR6iCzXULYdW5/Q
Date: Sun, 24 May 2026 15:56:52 +0000
Message-ID: <DB7PR04MB4378F5A94598767D7E4422FE870D2@DB7PR04MB4378.eurprd04.prod.outlook.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-4-gaurav.sharma_7@nxp.com>
 <59747973-1075-4db9-b3af-2aad0c7f15a7@linaro.org>
In-Reply-To: <59747973-1075-4db9-b3af-2aad0c7f15a7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4378:EE_|AM9PR04MB8731:EE_
x-ms-office365-filtering-correlation-id: c7104567-0159-4b83-504f-08deb9ad12b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003|11063799006|4143699003;
x-microsoft-antispam-message-info: XQjx0ZJgRX9ipwv/POg1CX7UN4X8QkC0DMjEz7luv3Xy4DQF5GHIm9XXXQ3H4GbYe3V6qhHJlEn2PpPU3D70UdtQ0QC+t5NhvGUghG7AOP9MrAKu0Sq1WrDG5SRiN8sR/D7UuL7m8Dbw4yZWIqZUAEPzk5M6lgZdSZzC1/FIZqgUO+RtgE3Gc7KNshduLkTTIGEtCgQCQ8MkVHcdDCXunYcqeeGjb3HX4TsFd9lPgk1nX90wTLIVbOSQKq0+fmcwGuf3lTCIZm+qlTVga9jgm5waTX0Z1tXM1/Ns0khPbdG4kx8gNMQfX9mJszqXb14rl0HREuJ2iaFV/luXhldLQMHkELMB2Z9L4Q7fCIxK5FJf07zD+iX33i9FWH2mNYOko5y88Cj6pEdYG8kOVn3qZ+28O2ht8/oL/J7vXuWIgmQU1tSS0xXUGKuIUqtTlMjkJMlLmgY8fs4wk8NkFPj4taAqhqipWeGaTJRPVYFHWYrcVtZaGE3XQmQ8y0DjnkxBiY1Tb5ycoDa5YNxalFHJ8CwrvlWxft1VacIipgkFRttQg5mZBVx3oQBsuAQdojAnFlTQVqDlmKhfW4RoS9xG8mkKgyqBSnSZWCOX0cJ2BW3+jpzTzOarrwRcYWl4MUIwSBNhiDlKCzjnzVG6TZoi097ud5Ve6aBL/vDsVrfDKpePA14TqfTXZfXFsgUKmON4Hb2SAvDfpEjIlsGWGvo0mBXYsnOJzf7nlbWA+cUWgACFll+DxTMPx9o5p7tcE81x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4378.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2toZlVQRWpySHU2OXVqQzd3N2taZDQ2K3ltaERPbzlVeHVkM2htdFM5NG4z?=
 =?utf-8?B?THpFZC9SbmF1K2lJemdxVDF3Y3BiVllMa3l1R0krQ2oybWE3RUtubU1MTmxi?=
 =?utf-8?B?VVp2ZHlwWHpyRmJoclZwanpGdEJGZzdPVjRlR1JNT0ZMV0h0UTg3M1NTR3Zh?=
 =?utf-8?B?NEtOWjRxYzM2UWlNSElGVTNKSFhYckdTbUlYSU1HUnlCTm1CMWJEZm1BNDVG?=
 =?utf-8?B?dVVmcVQzVFkzWDNPUUE1VC9qK2d6bCswb1BpZUtHeHQzVHlJc09TeE5ZZE9B?=
 =?utf-8?B?NEdsbXBQQWFRMnR5MGZTOXVzRkJaaVg0NHpDakZ3UmF2WXorL3VzR1NJMHov?=
 =?utf-8?B?NDBxaXc1Mlg3a3BJNFM5ZG9mZUNGQ2ZmdjNCMWpNTG1XalhvWFVacDlyTDJx?=
 =?utf-8?B?bVVRUlczdlB3UHozZ0R0UFpEUjJ4YkJmR1MwZmMvSWk3a21XU2Eyb3pKVkhy?=
 =?utf-8?B?Zk5NRm82OXlHUHdVSzU4cHJIOTQ2cEl6L2hPa2JIdXlWNlZnTld2OGVyTFds?=
 =?utf-8?B?RFV4UGoxQzBEMnVXNEFsbTFCQnpXQkZBQ0szWHZmT0NTVVFKMzY1UnpyQ0NL?=
 =?utf-8?B?UjI5dk9GaWFnN2NtY2hId3hBOXQrcDBGcStVR3g5YW1ZT1BId0FMMUpDaGJw?=
 =?utf-8?B?b0M3L1QvdjNuWmpBZXVRcHZsN05VU1BLOE4vLzZheTR6cVptaVlBZlk5a2du?=
 =?utf-8?B?ZFJaUko0Tk03akpObUVlWjFGK1B1MU9CV2xWU2UzRGJCOXBsZ0pBQ3NXdzRn?=
 =?utf-8?B?SURKL1FmR2Q4UFBFdEhrMnZoQy9GM3hyT2liTDVQZVlUS1pxTEpndUllbENV?=
 =?utf-8?B?TTROaUlNTnRlY0xsYTI0RDRLaStadC9scHVYbHUwQktmMkl2RGFTdktEeXJ1?=
 =?utf-8?B?cVFQNy8zUzZBQXdWUE1XZG1pQmV6SmVnejNCcVdqUkI5Z0xVdUxIL2ZZSDZ3?=
 =?utf-8?B?aVI4YUpZMXUxTnM2RkxXb0tubnhLRXNqMDVnYnBvTU1ha3Q2ZElFRHQwL0VX?=
 =?utf-8?B?a2FzTDU2WFR3aXRiWUY0dkphK1hKTlNNNCtyWVE3dCttc1B2ZmJ3Y0ZialU4?=
 =?utf-8?B?Nlp6d1RTdk5GMlJ2U2FDMUtteXhZc2ZKKzBnemU2TU9RWlZYTDQrQm9Gdnh0?=
 =?utf-8?B?VTd3WTBqYVRCNXV4K0JTaHZpeU1vNXF4a0xIbU5wN3daV0hzdk5aQ0I3eGlt?=
 =?utf-8?B?ZTFjMzRmQUEyNHJURThaYTJYNTJxcFNPMmRTUjAxdytCRDlNQmQycGNoOG5t?=
 =?utf-8?B?TFpWTlZPVDA5ektCOGFPUkhtU2syU042OElMRWZkNWg4MXVWRU5SaW5yVHRj?=
 =?utf-8?B?RUhEQzdEdVcxeCtoUENRZ2ErNnFhUTRZeFdXd3ZiUjhyQ2hJcHV6VGZvdExW?=
 =?utf-8?B?ejB0VDRZdVBNb3FtVERhMjhiemtDVTA2VTdHdXFNRFpwbHc5dDAzeXdiTmhZ?=
 =?utf-8?B?Ym1yRFV4TlBtaEdHQkR4cEhrOWpGZzRsRkVoN3JPRXI3NTlwR1MxU0xSUWFh?=
 =?utf-8?B?cmhDVnFqd1RIb09zcWVJZFl4NU0vQTVWNHU5enk4dG5vMWtLWTd1NlQ3Kzlo?=
 =?utf-8?B?WUNoQkFxY0piSjRlM0RPM0FIbDcrR3BXMTFnMzkzVVRkNXJ4ODlQUzVMOEhh?=
 =?utf-8?B?cmtXR1FEbTVac3dzQUltTlZrYmYrUEtqRklWdmNTNERkZGJMK2VpbjN3VDRF?=
 =?utf-8?B?M2dLNzZLVmdWVFkzcURhTTRjWjVDYmxUMEs4bG9BVzhiSjQ0bkNINTVCNXlU?=
 =?utf-8?B?c1pUVXBDTzhZWGt6ZTNPMWlJbVpiTWZhSEJvUDFjYTFrSXJHMTJDZWpUVXll?=
 =?utf-8?B?OE01MkloYkJWV0ovYSs4OGF1VUtZdGRMek44UEVjMnhiNG9wYlBkNWNJMmw5?=
 =?utf-8?B?bzkzNXE2TTd3dUU3U0VCeXZpRERPdkRTVWtjUm9sYkNKYzRKSGE0MWhrMHlC?=
 =?utf-8?B?VHNTOFBTSjJTWWxoRUVOT0svQ0xVS3pRVFIvc1BoSWlheTFidVYzblEvT1VW?=
 =?utf-8?B?UVFJNDZINmVCenJscVVOVVdvSitHTFVHZXNRT3pLRjlkOC9ERFE4V3VaVHpT?=
 =?utf-8?B?S21TM0VXMVJVSWhhOGpyZFZ3a0d4NzJqTHUvWitxRDRhL21yamtmSTFObjFu?=
 =?utf-8?B?SE5VSzJ3OEI4NTh4UlY1dFhSaGYzRmtIdkZFTHVLVGQzY0EyejdYNGxpVUVw?=
 =?utf-8?B?MFpxUGFWNmxyZXgrZFQxbUlKbHQzT1Q5QXAxQTcxV3B6VFBad2RRZzBSK1hF?=
 =?utf-8?B?S05nb1FtVHg2RlVETWVoVWFGS2dSMS9HWlYvNjd2R3ZNK25oK0tMYU9xSG9t?=
 =?utf-8?B?QjB4NlJXNm9xb0pYSytaN2paVm1HL2lWV0lpbUtYaHNEZ0tPdjRjQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7104567-0159-4b83-504f-08deb9ad12b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 15:56:52.7304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqkXXy7pY1Q3XznScrnVzc8LLXAqcOlD5vqx8/NkITui65s6mRb8IevaH2qvoGgE1NxOoGSELVmyvpUHiqOccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8731
Received-SPF: pass client-ip=52.101.66.71;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAwMzoyMg0K
PiBUbzogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+OyBxZW11LWRldmVs
QG5vbmdudS5vcmcNCj4gQ2M6IHBib256aW5pQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZzsgc2hlbnRleUBnbWFpbC5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSHYx
IDMvN10gaHcvbWlzYzogQWRkIFNSQyAoU3lzdGVtIFJlc2V0IENvbnRyb2xsZXIpDQo+IHRvIGku
TVg4TVANCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0
YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBX
aGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhp
cyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMTkvNS8yNiAxOTo1NiwgR2F1cmF2IFNoYXJt
YSB3cm90ZToNCj4gPiBGcm9tOiBCZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdtYWlsLmNvbT4N
Cj4gPg0KPiA+IEFkZCBlbXVsYXRpb24gb2YgdGhlIGkuTVg4TVAgU3lzdGVtIFJlc2V0IENvbnRy
b2xsZXIgKFNSQykuDQo+ID4gVGhlIFNSQyBtYW5hZ2VzIHJlc2V0IGNvbnRyb2wgZm9yIHZhcmlv
dXMgc3Vic3lzdGVtcyBvbiB0aGUgaS5NWDhNUCBTb0MuDQo+ID4gU1JDIHJlZ2lzdGVycyBhcmUg
dXNlZCB0byBzdGFydC9zdG9wL3BvbGwgdGhlIE03IGNvcmUsIGhlbmNlIG5lZWRlZA0KPiA+IGZv
ciBBTVAgYm9vdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlcm5oYXJkIEJlc2Nob3cgPHNo
ZW50ZXlAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZG9jcy9zeXN0ZW0vYXJtL2lteDhtLnJz
dCAgICB8ICAgMSArDQo+ID4gICBody9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPiAgIGh3L2FybS9mc2wtaW14OG1wLmMgICAgICAgICAgfCAgMTAgKw0KPiA+ICAgaHcvbWlz
Yy9LY29uZmlnICAgICAgICAgICAgICB8ICAgMyArDQo+ID4gICBody9taXNjL2lteDhtcF9zcmMu
YyAgICAgICAgIHwgNDMxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgIHwgICAxICsNCj4gPiAgIGh3L21pc2Mv
dHJhY2UtZXZlbnRzICAgICAgICAgfCAgIDUgKw0KPiA+ICAgaW5jbHVkZS9ody9hcm0vZnNsLWlt
eDhtcC5oICB8ICAgMiArDQo+ID4gICBpbmNsdWRlL2h3L21pc2MvaW14OG1wX3NyYy5oIHwgIDMy
ICsrKw0KPiA+ICAgOSBmaWxlcyBjaGFuZ2VkLCA0ODYgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvaW14OG1wX3NyYy5jDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9ody9taXNjL2lteDhtcF9zcmMuaA0KPiANCj4gDQo+ID4gK3ZvaWQgaW14
OG1wX3NyY19zdGFydF9jcHUoRnNsSW14OG1wU3JjU3RhdGUgKnMsIGludCBjcHVpZCkgew0KPiA+
ICsgICAgc3dpdGNoIChjcHVpZCkgew0KPiA+ICsgICAgY2FzZSAwOg0KPiA+ICsgICAgICAgIGFy
bV9zZXRfY3B1X29uKDAsIHMtPnJlZ3NbUl9TUkNfR1BSMl0gPDwgMiwgMCwgMywgdHJ1ZSk7DQo+
ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKyAgICBjYXNlIDE6DQo+ID4gKyAgICAgICAgYXJtX3Nl
dF9jcHVfb24oMSwgcy0+cmVnc1tSX1NSQ19HUFI0XSA8PCAyLCAwLCAzLCB0cnVlKTsNCj4gPiAr
ICAgICAgICBicmVhazsNCj4gPiArICAgIGNhc2UgMjoNCj4gPiArICAgICAgICBhcm1fc2V0X2Nw
dV9vbigyLCBzLT5yZWdzW1JfU1JDX0dQUjZdIDw8IDIsIDAsIDMsIHRydWUpOw0KPiA+ICsgICAg
ICAgIGJyZWFrOw0KPiA+ICsgICAgY2FzZSAzOg0KPiA+ICsgICAgICAgIGFybV9zZXRfY3B1X29u
KDMsIHMtPnJlZ3NbUl9TUkNfR1BSOF0gPDwgMiwgMCwgMywgdHJ1ZSk7DQo+ID4gKyAgICAgICAg
YnJlYWs7DQo+IA0KPiBDb25maXJtaW5nIG15IHRob3VnaHRzIG9uIHBhdGNoICM2LCB0aGlzIFNv
QyByZWFsbHkgbmVlZCB0byBzdGFydCB3aXRoIG5vIGxlc3MNCj4gdGhhbiAnLXNtcCA0JyA6KQ0K
PiANCj4gPiArICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsNCj4gPiArICAgICAgICBicmVhazsNCj4gPiArICAgIH0NCj4gPiArfQ0KPiANCj4gDQo+ID4g
K3N0YXRpYyB2b2lkIGlteDhtcF9zcmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNv
bnN0IHZvaWQNCj4gPiArKmRhdGEpIHsNCj4gPiArICAgIERldmljZUNsYXNzICpkYyA9IERFVklD
RV9DTEFTUyhrbGFzcyk7DQo+ID4gKw0KPiA+ICsgICAgZGV2aWNlX2NsYXNzX3NldF9sZWdhY3lf
cmVzZXQoZGMsIGlteDhtcF9zcmNfcmVzZXQpOw0KPiANCj4gUGxlYXNlIGRvIG5vdCB1c2UgdGhp
cyBsZWdhY3kgaW50ZXJmYWNlLg0KPiANCg0KR290IGl0LiBXaWxsIHNoaWZ0IGl0IHRvICdyZXNl
dHRhYmxlIGludGVyZmFjZScgaW5zdGVhZCBpbiB2Mi4NCiANCj4gPiArICAgIGRjLT5yZWFsaXpl
ID0gaW14OG1wX3NyY19yZWFsaXplOw0KPiA+ICsgICAgZGMtPnZtc2QgPSAmaW14OG1wX3NyY192
bXN0YXRlOw0KPiA+ICsgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgaW14OG1wX3NyY19w
cm9wZXJ0aWVzKTsNCj4gPiArICAgIGRjLT5kZXNjID0gImkuTVggOE0gUGx1cyBTeXN0ZW0gUmVz
ZXQgQ29udHJvbGxlciI7IH0NCg0K

