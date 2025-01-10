Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0859AE7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 01:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW464-0003xw-FL; Thu, 09 Jan 2025 20:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1tW462-0003xm-Bn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 20:45:58 -0500
Received: from mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::725]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1tW45z-0003LD-PV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 20:45:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meF2xeh7+lnDtWjmr5hBiLoKYKiudFx99IVi1rAXTuBy4jlDNGVtRnWbjLZRChQ2anViIgUyqW2d2jhSo+quh04jT3GXjdHrWwMw942tQKi7PlmVwcsCuM9XBC4ChRRt2N5vf3oMvRsM/vWHRK2MEmKsBBEChoCCgTlOOuOsiTAO1IzfFcsD/mX8YVtBPUnJcPwqfYDvXEPharz65LI934ASl84KtNfQin627JHBp3gU7uZxCyA4olvRB9XP5/C8s7ciwNV8TVUiegGSTq07qRpa4/e/PharMXU/+YYNK1VC1LdWyCUzrFfnViCS9RlTqu+Zj5QFRHHwldcDPr8csg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAkO3toFyln+yxf02Bw7nCTqfYeJafwy9MAqsriEoiQ=;
 b=Bx1XFDRwblCTbp+4FOqvwqo18xpNXFevB126qb78oyKiV0sKzTKZQcvoPTb8iLed9WK2LrDeKuvOQYNLlKv1FSJUUhVSR48I5Et9udNJyeqWfZgHwSLN76zXv5ncBY3usDNsDl1iLsDeM+BAxvFkb01IktC7Q3ZU7gHJqcMZp9+YwDUvsOr22CzRO52PK0iABwemWYxrevAOUOwd1HaFmeoMHwhoEC8/RamdNpOG/ugmICT7aHgJiaJ5QrWVh8FpHHa4Qac1vsmspr+0Mfww7uN1kXwOnZLynFwvEdqqvs7bCKWhjLJMhDvIKL2ToayRIAV5ntKA4cQv2FLxtFzrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1255.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 01:24:48 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::7c03:71ed:a774:fa31]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::7c03:71ed:a774:fa31%6])
 with mapi id 15.20.8335.012; Fri, 10 Jan 2025 01:24:48 +0000
From: Demin Han <demin.han@starfivetech.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>
Subject: RE: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Topic: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Index: AQHbLDyPsgVEn9ocvUKmJf5ZUtvEebMOw0+RgADdqfA=
Date: Fri, 10 Jan 2025 01:24:48 +0000
Message-ID: <ZQ0PR01MB10631B52B9B9AB6F96DFF442851CA@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
References: <20241101090032.1413255-1-demin.han@starfivetech.com>
 <87v7uo8ags.fsf@draig.linaro.org>
In-Reply-To: <87v7uo8ags.fsf@draig.linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1255:EE_
x-ms-office365-filtering-correlation-id: 6f25c8ff-c70c-41f4-5520-08dd31159310
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: VOaI1noI6JwDmCyV8XTOpTUnwQnpqIh+R77ufAHGASRvpQczKrezublZS7BqDeMVMBcJHYxAjFQ5/FzLoApd313vazR6X+GAJrSZ8YrGNwv9muwKoez/fuslAxBa9r6115nf0t2YB25wjXQXaAv4YYJ6ycqkVLJ/5t3Auh8rSsD0ipE+fmx1d/ybk11+vv5rGSSBGldYbhtDCgfOmRVA09V3VNoVc/OKiZ5yUzbAsH5zl/EzDbeJaoIMT8V1tUdPXXZRf6r28bZxaZ5qDlkbGKTz4sfbcGwz4DQ9poOM0TFeKHdecTvNLBXpWNIMnh1Q1PB9lrK4fhT49/bvX6nrPTEKXD4XMs793sxADMy+6vpnkBOo5MxRqce7fH+Ce37bpQBX3MKSAO/FsLEjvPCnnmphPGkSrAEQ82w2RwvbC4a2UgggM3vDatYig64uptsW4LtTB0XeW2qY0D1URhA/tof5v2puiXEH3e3PQh/X9duE1AO4D99qu1B85ufP/ZnBXKzvCo8Jwu8dHK/jQax2UQNnO9u+Gy5qJl/3PjAnleOqrLe2z2+cDPSnuSJSVqkHDHS3wKF1MlEuXJ0bFLuKHiG9BvSCbhB8sWaN3hQphIM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW5uVmxUeUE3TkdrMDFXV2QzcEl4Y0pRT29vN1IwUU1FQ1o1VGs4Nmtsd3lw?=
 =?utf-8?B?Tm9YUHhqZ2t5cXdkTXl6RTJoSThNOFNNakhicC9hNFlVSjVGWjNlVk1MekFW?=
 =?utf-8?B?T0tHalVXN0pVRkd0YVozdDk1YXhPYU9kN25uYzJuNVR1V1JVeWFwV2x2Uzdv?=
 =?utf-8?B?MlNRYU9lajdibVRnQisrZ1JBYnFiRXdqdlZ2RmtscHRCbW53ZzBlWEo1S2hY?=
 =?utf-8?B?RnJRajVYUm9iMW5BTVJTVVNrbk1zWWxaaFZOZkh5cXB4azA4VXBBVy9JZXVC?=
 =?utf-8?B?Y1VmZ1ZYakRuY0lKb0liVWFDSTdyemIxTENIaklvQkZjODFidy9jMitpMGo2?=
 =?utf-8?B?c0hzZE9VRmxnbXpuaS9oSTgra2FMRk5odXl6NlVEaGl0Z3BjV1FzUlVROHht?=
 =?utf-8?B?YmUwRUUzdDZOWkRrYmlvZ0p0SEhkNjdEeDVkU3VCbVJsU2x1TEt6YVgraHNH?=
 =?utf-8?B?RHRSb0VST1dlc2o0K3JKakN2Q1NEQTQ4a0w2NE8rNnR2dUhpYk1iVHpNb1R0?=
 =?utf-8?B?TVdqQysyQTJ4eWhaTVZyWG9Va21YWld1WkR4OE5lM01ieTV4WjZra2ZFOEVK?=
 =?utf-8?B?ZktSR05WMkNpY2dTN1pmVkMzUUhobzQ2a2NJODlnOG1NbC9ySXlHTHFIME9R?=
 =?utf-8?B?QXpjNzA5cDVRTUNFTUJtR3I4RXZiRTdDUnY1bVgyY0dMQ1JCYUprcC9jdytt?=
 =?utf-8?B?aTBRQXFQdnM3a2hZVWdWbTVtTERZMnhKanptRHR1ZndTQXZ0dkhDZjVla1Vy?=
 =?utf-8?B?a09lR0oweW5WWXV3a01DbEZwWXhMQ3R4RVZPNXBSUCsrZWZGQllOYjExMDQw?=
 =?utf-8?B?TnZDVks3WWxBR1NqMGNReDhEcDNPWGpnRjREVitmc0wwU1JDa0hTK09IdHFi?=
 =?utf-8?B?SDFHWFhHb1VqYW1JNWRrb3BHWTVYVk1QTXlNbWs4SkFiOGltcEo3NnFFb1R4?=
 =?utf-8?B?ajhMRitpR0w2NGJwS2tJWjNMUzQ5c3lHWTBKWTFwZmVGL1ZKUmQ0d2JITjZv?=
 =?utf-8?B?YW9CZndJdHVQMEFoR0UrVzdoT2IzZlcvck5KY0x2RkRKZTU2R1Z2RDZLdnVa?=
 =?utf-8?B?WU1iVmtiUDB5UVN3YTg2b3FVWVhXelhQZWRQYVp3SkN3TVhtSW1ZSk5JNUg2?=
 =?utf-8?B?RmpySFhla3gzN2ZDTk1tdlJISjNIRVBsUWxJZndqTkIzQmI5T2wrVTgrU3Ar?=
 =?utf-8?B?ckpBWmdMalNBd1NWWGNiazRIVlVJUnBKaVhpVmM1T0NLTTlTcFVleHUvZW9i?=
 =?utf-8?B?bEFQd0lqRm50UnorS3lOWVFFeDBIRmNuT053YklNZUpDT3pzRnZOV0syRDEx?=
 =?utf-8?B?T0ZtQk53TG1OLzNSQjNua0cyb0lkRXYzK0pIbDlwb2svZy9hZ1B5Q2M3VjFO?=
 =?utf-8?B?blVKMWE5WEwrSzNsSkU2Rld1Q05IaWgwb0thU1lvcFZ4eEYycEt2c0w2TnVB?=
 =?utf-8?B?UzRCMEVHYzBVbUJVNU9HMnR3ckhoa0VsNDl4TDk3dHhoNXNKRjdHUm9YalRv?=
 =?utf-8?B?cWxMVTVkcXNvTjBLdEN1WHVhU1VnWnJRbGxueVgvU1FPcjk2Sk1LVVF2QkdJ?=
 =?utf-8?B?cWJBZU5sdjMwQXJxSTlwNWNiQ2V4SkVFQ3M2bERaang4bThXbXhQdUErcWh4?=
 =?utf-8?B?d1d6ZnBhWGFZTVZJTEg0SG9aZFZDVHlTWmRCOFlmNWFEMFI2a1UwWE8vSGNH?=
 =?utf-8?B?OW9TS3FKRkM4U2pSRW5FMERTdk40N0hRYnVMVUdBSTR0Y2R1M1MxUUk2VlI3?=
 =?utf-8?B?bjVFUmgvZVFmblZkREgyZ3lFUUhjWjhzMnRwNjRERVoxekk4NEREQWZxeGQ1?=
 =?utf-8?B?TjZLMG1ZM0laRUVpQ1AxSm1oTmp2QjhFcVZkZzg3cXlZWEtvOUN4a2pSRmcz?=
 =?utf-8?B?b05QSGN2STM0TUcrM0w5R2dpSi9vaEhwdkFVUnRTUHRpV3hyNDFsUCtWRGk1?=
 =?utf-8?B?VEVTdjdIVC82K3Q4R1gvc3VQY3o0ckFlaFNRdWZrTm1yWWt2NFJqc2I2NEFy?=
 =?utf-8?B?RlhMeTA0RXBoOFFnMi9BNy9NS2FvblNnVG0veVRIc3FWUStTdzViWmVabFVY?=
 =?utf-8?B?cFBQeFJrN2JjN2JsOVJmakl1Q0NURDBESDV5Z05FUksvS2lMSU9mYmR1TWVV?=
 =?utf-8?B?cEw5dWp4b1FJY2F4SUM4dFdqQXRJWlVkaW1FZTlvS05va2ZmZmRQUXV2aHdL?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f25c8ff-c70c-41f4-5520-08dd31159310
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 01:24:48.7516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bH6BkKCfahIVtB4j/xvuoNQ9MIn5ELmVU7TodtMg32Zxtos9zctTwR6rWmZ+kgWW9Mmb3y3+az17hOYODSYLS1gL81MmjUKu/kI+5+Tk+10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1255
Received-SPF: pass client-ip=2406:e500:4440:2::725;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBCZW5uw6ll
IDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0MeaciDnml6UgMTk6NTkN
Cj4gVG86IERlbWluIEhhbiA8ZGVtaW4uaGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBxZW11
LWRldmVsQG5vbmdudS5vcmc7IGVyZG5heGVAY3JhbnMub3JnOyBtYS5tYW5kb3VyckBnbWFpbC5j
b207DQo+IHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBwbHVnaW5zOiBhZGQgcGx1Z2luIEFQSSB0byBnZXQgYXJncyBwYXNzZWQgdG8gYmluYXJ5DQo+
IA0KPiAiZGVtaW4uaGFuIiA8ZGVtaW4uaGFuQHN0YXJmaXZldGVjaC5jb20+IHdyaXRlczoNCj4g
DQo+ID4gV2h5IHdlIG5lZWQgYXJncz8NCj4gPiBXaGVuIHBsdWdpbiBvdXRwdXRzIGxvZyBmaWxl
cywgb25seSBiaW5hcnkgcGF0aCBjYW4ndCBkaXN0aW5ndWlzaA0KPiA+IG11bHRpcGxlIHJ1bnMg
aWYgdGhlIGJpbmFyeSBwYXNzZWQgd2l0aCBkaWZmZXJlbnQgYXJncy4NCj4gPiBUaGlzIGlzIGJh
ZCBmb3IgQ0kgdXNpbmcgcGx1Z2luLg0KPiANCj4gTmV3IEFQSXMgc2hvdWxkIGNvbWUgd2l0aCBh
biBleGFtcGxlIHVzZSBjYXNlIGZvciB0ZXN0aW5nLiBIb3dldmVyIGZvciB0aGlzDQo+IHVzZSBj
YXNlIHdoeSBpc24ndCB0aGUgcGx1Z2luIHVzaW5nIGdldHBpZCgpIG9yIGdldHRpZCgpIGEgc3Vp
dGFibGUgc29sdXRpb24/DQoNCg0KV2Ugd2FudCBhIG1lYW5pbmcgYW5kIHVuaXF1ZSBuYW1lIGZv
ciBwbHVnaW4gb3V0cHV0LiBGb3IgZXhhbXBsZQ0KLi9hIGFyZzAgYXJnMSBzaG91bGQgaGF2ZSBh
X2FyZzBfYXJnMS5sb2cNCi4vYSBhcmcyIGFyZzMgc2hvdWxkIGhhdmUgYV9hcmcyX2FyZzMubG9n
DQpJIHRoaW5rIGdldHBpZCgpIGFuZCBnZXRpZCgpIGlzIG5vdCB1bmlxdWUNCg0KVGhpcyBjYXNl
IGNhbiBiZSBzb2x2ZWQgYnkgdXNpbmcgYSBzaGVsbCB3cmFwcGVyLCBleHRyYWN0IGFyZ3MgYW5k
IHBhc3MgdGhlbSB0byBwbHVnaW4gc3VnZ2VzdGVkIGJ5IFBpZXJyaWNrIEJvdXZpZXINCg0KUmVn
YXJkcywNCkRlbWluDQo=

