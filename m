Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEBACAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAcu-0007Ql-7J; Thu, 18 Sep 2025 05:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzAcp-0007Pa-HH; Thu, 18 Sep 2025 05:08:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzAcm-0006TB-0I; Thu, 18 Sep 2025 05:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm8FjvX7jdoYMkGsdizCeMIpH191VMxvHpqQYhBMCWdtYjBYNnP4xiaodzuB5syaQT9+E6fZ8Zem3mVW4+44BXKk2iwlnf2CB+RzxxcDH7Ta3y1jZGcqMtQYcTY8+tnO59vALNZ4SXsLyIT+odjdlEtcBv1Qkmpr0otWGOknqf3Aygppl4bPFUGrhlUHu2OjdVHNSxSyxwkdTv7K6MN9ldcN0EbzR92UFte7Que2MePaDHrYhJ1lf/Vhf9U9WSvgX7HIeqyr++GRnG8/xGmCDs3lf/dPXUIw9qPMoUm9T8os9EH4NDAaTJL+Y4OgjldtttFfj2m5p3OCHylNHjyPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrpEskXqh9IEDwxn3mZ5602FXf4Q99Fz/t+4QuAmKpg=;
 b=VPX2ypm+E3eyP5HNmZ786FoEQ2EyRG8e9audnMU7J7xixvIHgnq+qu9Y6Kwkcht6PLmvtYA4XGlyFg76D6wf/ZHGYnQMp7LTW71wuVS9i75sI/pqN22b2LLkluLY7fbkYrtCvzfncQxsIyGDvUhA+ftUNhibxP6+AC13ZmioAOJmY3FoRJSem8mnVuHOCp6jkcW4CrjMILUBmnBekNmEIicAGCbOTeyuIV8OYT0umnBHtaKdrocWZgu8vTjurATWctvb9LlC/ZwoYOmnh9/6yTzWvXmrDYbG3HiGNqKoZkzXlnJmhubl/SQlaFvVL5USPhqESujDNqnCBWD5gRh2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrpEskXqh9IEDwxn3mZ5602FXf4Q99Fz/t+4QuAmKpg=;
 b=rbge4OjCEibebBiK8wViCnkJeMtCAMbyGlHv5wSD1PHuBuWoPSFqkfDnwEqLkUeRpX0PAlgX9j8i42ugCyrqSm30m4WghpX25NYdVOX+tQnqPf55wwCuODqHlPyMJ6qAWL6RtSeSudG/Qiosc+gdyzeehmnSXJGvfCzvaFhX31rgn5SosnPKoM1uiSK6D69SJWHfIUOG4BI4+uZYe8HpCvtFygCzPUPcTO/keW43S590jr/va5B950Colev6NX+weWF33gLvddmqIXMZcGpp9UfwsSqby+N391qrrr6mrnJRU/z1eT9MfHM4MiVnQeeYdDTmqa+xLEj2c/HkKidpkg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6438.apcprd06.prod.outlook.com (2603:1096:990:2c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 09:08:07 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 09:08:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: [SPAM] [PATCH v3 00/14] Support PCIe RC to AST2600 and AST2700
Thread-Topic: [SPAM] [PATCH v3 00/14] Support PCIe RC to AST2600 and AST2700
Thread-Index: AQHcKEpEW4PgDW2RVEKIoV4l754gn7SYlLWAgAAR0QA=
Date: Thu, 18 Sep 2025 09:08:07 +0000
Message-ID: <SI2PR06MB5041C7EE49F5A61C6E8B2DE3FC16A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250918031348.3991681-1-jamin_lin@aspeedtech.com>
 <2e5f260b-dafa-42ab-953d-f0781cd3601f@kaod.org>
In-Reply-To: <2e5f260b-dafa-42ab-953d-f0781cd3601f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6438:EE_
x-ms-office365-filtering-correlation-id: 5ffff9b8-1b16-4398-d34d-08ddf692e222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?NzNXQVRYaHpmN1UyZzJ5Znpnb0FZaUw5ZlVXcGxHMkRPRVNUR2k2cFNuazhZ?=
 =?utf-8?B?aDVYaEZkOWw3Zi9TWHVkdUdkekNIMVI0Wnkrd3NLc0diVHdnZXNWempjelNY?=
 =?utf-8?B?aDFwcVlkZGwwN0Q2cG95dUxVSitFdlkyRCtja2EvWnFnZGhSVldYcDUva1Br?=
 =?utf-8?B?eVJwWGlmbHIrNitpdUx2M2xxQVVUcHpHTzFreWM5aHpMaXltUFhFOGdzazdS?=
 =?utf-8?B?WFUrb2hYcW5sME04Smw1SkhWZDd0ZjV3SFh0dnlTdW5jelpCUXpXQ2J2STZY?=
 =?utf-8?B?eXRlUXphN2FFc1kwQlBJRnNqRC8wOWlXbXdROG5ydWRzV0hyY3FITFhNQ2Fv?=
 =?utf-8?B?ZG9QWDhXdEZPdUx6Z1dnNXFmcEtUaDkxdmtCS2V3YVY4WGZOelJIdWU1ekd2?=
 =?utf-8?B?RnRodVFCbHl3Ym85UFVyMWJvMVQ1RlBMbWNqTW5oK3pCSGVna0QrY1ljUDN4?=
 =?utf-8?B?ZnRLSkxrNFh0NUZTNWRES0tBWUdTUm9hbysxdzlHWC92ZEx0MmUxZ3Yyd2RZ?=
 =?utf-8?B?eTlvdE1yb1RTVk9DeUxyT2EzZFB1TEgvdEZubE5LajNjWlBGKytjMFJUMUlW?=
 =?utf-8?B?Y3NBaEFQMzdRVHhPSDdlMnRYczhNUXMrZkFHdEpqcENmaWZrN3g4a0t2a241?=
 =?utf-8?B?NGRhREwyOUpVaFlYUVo2czZnQkttekhUZWtya1NmMFRZVWRRa1BQVE5iZjhN?=
 =?utf-8?B?QXNUcDBZbHBVeDZoc29ENHdkUkJBMDBlNm83V3JiNWZPK1U4N042MzBsc05N?=
 =?utf-8?B?SEpYSy9ZMldsdHZOVDg3bDBmazVQRlA1RkxFbVRCZjNGTTcwZFRVZlRyTzNp?=
 =?utf-8?B?V0JLSjBVQWYwb042d21GWmtmTmdtQXZ3ZEQ5dFpvaHhpbUNRYW91TENIa2xG?=
 =?utf-8?B?TjR5T1oxU05FV2ZUQTRIV0tyaXBielRUWHJJY0NBaTVlcG5GbE53N0cvc0lx?=
 =?utf-8?B?ZlNoMjFEeVdZSjk4c1JLblQ0UVVodmlhaU9Dc3lqcmQwVGFabEM4WGtFTUFF?=
 =?utf-8?B?S3JDY1d6TUlhREdVRjEwR1VmR25Cb2UrN2dpV0xvY3ZVZmlzdVB4Y2d4N2tt?=
 =?utf-8?B?aGZqajd2SkZJcWRGWVJhbm9jSTRJUzNDbjhUYlFEL0xFOER1WldObkd2bXJR?=
 =?utf-8?B?TEVmWGtLNmpxV09pVmZPU3kxcVhxeU16eTZ0aFRncGdXUTdRK2tCRE1rczdN?=
 =?utf-8?B?cGg1MlM5WW9Ick9TQlMweUZCZWhMdm5XTFNUMDNvRG9ObG1kYVB0N3pMbWFT?=
 =?utf-8?B?RG1IOVBRei9PV0VGa2NWVW1kQ2FvZnFWdEZFTlRTb2ZOWHhEV1BER3A2N2Fx?=
 =?utf-8?B?MXZMSUMxZ1UwMVE1MG9PTVdGcW1FbHZlMDM3dmVsTUR3NkJFZXc1alVKbjE3?=
 =?utf-8?B?eEg1U2RGTEJOVXpscU8rS3d1dENVM25lanRsRTlScEhIc1A4Q3lQWmlFMjcr?=
 =?utf-8?B?TDNBY3ZRL0todENudWUvb3pZZ01CUzRNWUUrbkNta2p2U3RlZFpFeGEvTnRF?=
 =?utf-8?B?OWlsenhLelB6Uk1VT2sycDlrYXFKNXZFb05tL0xXOFdSeWc5R3dKYjdXa2tp?=
 =?utf-8?B?N0VlVnlQaHdQOSs3YktYb3pReVFQUTBwUWhYM1JzYnhORVEyaE5hOTA3dURK?=
 =?utf-8?B?UEg0WGVaQWswbzBkS1RuK1BZbW9DaHR6aGhvTS9HYVZ0MWFvNXpteGRqdXov?=
 =?utf-8?B?bnRhZk1wVkNuUEVJaVNwRVBldGNub3FHU1RscUNML296cWtTMzZqQjhaSk9N?=
 =?utf-8?B?Rkp6QmszeTJXM2R0K0pGMGY2V0tqYi9qUU5CZEJUWThUbFVDRXZhS3N1ZjEy?=
 =?utf-8?B?VkR2ZUJUYzZqS0xuRldPaUk1cEg5OEEyM0xaNFUxZ1NGelNhNkJZTHVxMTc3?=
 =?utf-8?B?dXY1L1pveWlJeEZPUERNUmFlK2lPNGduVUxPVTNPVXYvMUo0RC9lYXFSN0FS?=
 =?utf-8?B?TGE1OHBKdnprbHJaTmtWajFpMjNLTTVRZEhGVFRnVGNDbmZXSXF1R0V5aU9N?=
 =?utf-8?B?aWd4dWlZV252aURyRDJBTEhmb3Z2dkI2MklRZ3B6RFc4bnFJbC9PS2hBQWlv?=
 =?utf-8?B?MmJ5TVZycnRNZk9NMDJVTFk0UW8vWVZ5Wi9idz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk4xVGFmblJDNzFkQzEyOEJlNnZUZ1ozcFNSOG8zZkxNalpIMXEza1dlMlpH?=
 =?utf-8?B?cFFWdkQwZmxlanIwZmtIOWZkNWFIMUNyVDZjN0tkdDl5SDRSK21DOCtYbEx4?=
 =?utf-8?B?UVRRTkQrRnJaVEtGOFJ0VzUzNUNvaVlOR2p3RlkraHMrSk5Rb2l1UUJ1SXpE?=
 =?utf-8?B?dnVlWjdFQmRGQWE5MSsyL0pxTUlISElhVE9HZzdDTmxtL0sxdTJ0MTZyZlVN?=
 =?utf-8?B?VzFtZWRzdSt3T2lDYWpPR1Y4aFJGVHZNVm5EUDJNZnJqNkJ1cS9iZ01YazBn?=
 =?utf-8?B?a3BWc1o5WVV6eCtyZDRWeXpVMWM1VFUramNOcXFESjFtNmdvQU9Eb0UvQW5X?=
 =?utf-8?B?bERGTVA1R2cySzhqVnN4elkrL0NEdXFJam1WYkxQSVBwNUkvcDJMaVlTSDA1?=
 =?utf-8?B?bUZ1QXBTZytwc2tFeHZCUHJHb28za2xtSVBpakQwRGdQUWJmRGYzbEFvd2gz?=
 =?utf-8?B?eVdMbzlXMDY0cEFmV09DTWtITjBRT3RFdEtsa2tCMGpBenRha3FZWldLcVRj?=
 =?utf-8?B?R3ZlMXpqYU1LZFNUZ3RRK1R2Z1RmdTFwVy9zcGY3bkZyZmRSc3hTc1FnSVUv?=
 =?utf-8?B?V1FDcEFHVEJkb1VyTmFlUURCckpXWjlLMFROa1Y3TkM0VlFNVDBCUkIwY3lL?=
 =?utf-8?B?SWxwbjNzUDlBRTdSQTlWSUhhdk1RZ3RWWkg0MG1RMEtsaVRtTklDNjNIRlR1?=
 =?utf-8?B?eG1xQW5md3p6MXJxKzM1SllJek9id3cwL3Jnb1hZbWhwNDQ1ekcrcjNmRXd0?=
 =?utf-8?B?dWJKckxmT0lUVjBwWWZjMFU5VElHaVNkTk5UejBTZG1kWjlZSThLdXFSekpo?=
 =?utf-8?B?UlpvZVRWT1pCUmJYQ1pFKzN3L3lHaS9STmhpY0plNTNOK0NWczNRT1o4ZWts?=
 =?utf-8?B?ZWZuYS93QTlmdkg5Mzl3TnZRMVFLWFBYLzFwVnRQWGRvZ1ZEdG5CVzZTUUp0?=
 =?utf-8?B?c3JWTEdPWFRnTDVVWVZFZVk2UjNITkRsWkgrZXhVYUEwZFF3T0puRjVNL0Ni?=
 =?utf-8?B?bDZBY3dGbEp5eTIxNXJGTzEwRHJ3U0oyRkYvdkZnNWNzMDlTV0Z2cGpucEJO?=
 =?utf-8?B?VkhhWm1WL2VBcXc4TE1UaktDRDNVR29WdEhnbEpIQmdXNi9kRVFFQ1ZSTHBB?=
 =?utf-8?B?WlpNeWIvMTFicVZYTmM3cDdHcU1wTHRvU0lwKzB3c251M1VXWVZ0T3c5Ulll?=
 =?utf-8?B?WDk1cVMxK1FBMTR6VHR0NVd0OCs4Z2hKSitHUW5QRHQxYzd0UXVlaktVVUNO?=
 =?utf-8?B?YTVTYlpscTBQRTJsTVd1N3RyNW0vYi9CejhYSkRNSnBabzEva2NTdGJQRUlK?=
 =?utf-8?B?YkxzSWtqNjFBUzFGaWw5SnNkOGR5WUN3aDRRRVJHWEpzNmxhWmJIN1hJQ1hl?=
 =?utf-8?B?R3lGRVJJZE9VL1lPczFJK1IyOHlJcGN4Kzg1dHdoNi9kcUdicC9UQ1JTcG45?=
 =?utf-8?B?cU5IZ21VMU9yK3gyd2VtTlVsRVNLOTBiUEtmQWZLbzRKU2owaWJtaW83WFNL?=
 =?utf-8?B?NFdTb0lZVkN5L1U2NkFZRHVpWk94cnMvaXl3VnNETDZoTVZySGRLcDhBbUph?=
 =?utf-8?B?VlZJNS9JSjhCNU9jTFBManB2RlVtQXplanlGN3UweDhFNmoxd0RPeFJsVmVI?=
 =?utf-8?B?ZzMzdFVoLzJRN3l1SXZvLzdEd3lmczVYR0tOd0dpV2pjOWljK01RamxjSUJY?=
 =?utf-8?B?d2IzWDl6czVkQWg2alJWUWdIWmtZTzJRQnRLd1hyTUZpL3NFZmROZWlqY0pQ?=
 =?utf-8?B?dGprb2tDSXk2QXNUWXNMUmoxbzJBNHpHLzhobHNmNnBYNXpEUG16dmFjOXBV?=
 =?utf-8?B?N2Z6U292K0xnNVM2OFFJalZhSjFWaFRrTXp2RVBHWS8rcEhjL2RqcG5UV0Mw?=
 =?utf-8?B?eUE5Y0traFE4SFh6K3N5YUJiMDBYRXhVNE0zWk1pSTZOeTVWSVFLa0VQV281?=
 =?utf-8?B?d2FqOXBzeStNZThLYzJwNXpLamROcVRjQTN5VVJiVXlOcUNCclBVQkptQWdw?=
 =?utf-8?B?V3VRNUN1TmlpU25SYVZDcnU2NVIrblM5dVpFRkk3OGE0QmtsZ21jNXJ4emxo?=
 =?utf-8?B?WVpWN1oySkJtNnVxckUwWElSZkR3VDF4VTdwVkordW4rUHVqU0E0VEdJaU43?=
 =?utf-8?Q?/eVG2AhyMfGuBoh7W7kJy08EX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffff9b8-1b16-4398-d34d-08ddf692e222
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 09:08:07.5942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpNfvp4u1ocMOU8myQ1yRZXmzuSBJwRarhrkEwOB6QoG0+xFru1C/ph3+2VOV+gYHwgrbjwcqIsbKgEQYrfBRLTiFvrcdZT6+27X1xHJo2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6438
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYzIDAwLzE0XSBTdXBw
b3J0IFBDSWUgUkMgdG8gQVNUMjYwMCBhbmQNCj4gQVNUMjcwMA0KPiANCj4gSGVsbCBKYW1pbiwN
Cj4gDQo+IE9uIDkvMTgvMjUgMDU6MTMsIEphbWluIExpbiB3cm90ZToNCj4gPiB2MToNCj4gPiAg
IDEuIEFkZCBQQ0llIFBIWSwgQ0ZHLCBhbmQgTU1JTyB3aW5kb3cgc3VwcG9ydCBmb3IgQVNUMjYw
MC4NCj4gPiAgICAgIE5vdGU6IE9ubHkgc3VwcG9ydHMgUkNfSC4NCj4gPiAgIDIuIEFkZCBQQ0ll
IFBIWSwgQ0ZHLCBhbmQgTU1JTyB3aW5kb3cgc3VwcG9ydCBmb3IgQVNUMjcwMC4NCj4gPiAgICAg
IE5vdGU6IFN1cHBvcnRzIDMgUkNzLg0KPiA+DQo+ID4gdjI6DQo+ID4gICAgMS4gSW50cm9kdWNl
IGEgbmV3IHJvb3QgcG9ydCBkZXZpY2UuDQo+ID4gICAgMi4gRm9yIEFTVDI2MDAgUkNfSCwgYWRk
IHRoZSByb290IGRldmljZSBhdCA4MDowMC4wIGFuZCBhIHJvb3QgcG9ydCBhdA0KPiA4MC4wOC4w
DQo+ID4gICAgICAgdG8gbWF0Y2ggdGhlIHJlYWwgaGFyZHdhcmUgdG9wb2xvZ3ksIGFsbG93aW5n
IHVzZXJzIHRvIGF0dGFjaCBQQ0llDQo+IGRldmljZXMNCj4gPiAgICAgICBhdCB0aGUgcm9vdCBw
b3J0Lg0KPiA+ICAgIDMuIEZvciBBU1QyNzAwLCBhZGQgYSByb290IHBvcnQgYXQgMDAuMDAuMCBm
b3IgZWFjaCBQQ0llIHJvb3QgY29tcGxleCB0bw0KPiBtYXRjaA0KPiA+ICAgICAgIHRoZSByZWFs
IGhhcmR3YXJlIHRvcG9sb2d5LCBhbGxvd2luZyB1c2VycyB0byBhdHRhY2ggUENJZSBkZXZpY2Vz
IGF0DQo+IHRoZQ0KPiA+ICAgICAgIHJvb3QgcG9ydC4NCj4gPg0KPiA+IHYzOg0KPiA+ICAgIDEu
IEZpeCByZXZpZXcgaXNzdWVzLg0KPiA+ICAgIDIuIHVwZGF0ZSBmdW5jdGlvbmFsIHRlc3QgZm9y
IHRoZSBlMTAwMGUgbmV0d29yayBjYXJkLg0KPiA+ICAgIDMuIHVwZGF0ZSBsaWNlbnNlIGhlYWRl
cg0KPiA+ICAgIDQuIEFkZGluZyAiQmFzZWQgb24gcHJldmlvdXMgd29yayBmcm9tIENlZHJpYyBM
ZSBHb2F0ZXIsIHdpdGggSmFtaW4ncw0KPiBzdW1tYXJ5DQo+ID4gICAgICAgaW1wbGVtZW50YXRp
b24uDQo+IA0KPiB2MyBsb29rcyBnb29kLiBJIG9ubHkgaGFkIGEgZmV3IGNvbW1lbnRzIG9uIG1l
bW9yeSBhbGxvY2F0aW9uIChnX2F1dG9mcmVlDQo+IGFuZCBNTUlPIGFsaWFzIHJlZ2lvbnMpIGFu
ZCBvbiBmdW5jdGlvbmFsIHRlc3RzLg0KPiANCj4gdjQgc2hvdWxkIGJlIHRoZSBsYXN0Lg0KPiAN
Cg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQga2luZGx5IHN1cHBvcnQuDQpXaWxsIHJlc2Vu
ZCB2NCB2ZXJ5IHNvb24uDQogDQo+IA0KPiA+DQo+ID4gRGVwZW5kZW5jaWVzDQo+ID4NCj4gPiBR
RU1VIHZlcnNpb246DQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQv
ZjAwMDdiN2YwM2UyZDdmYzMzZTcxYzNhNTgyZjIzNjQNCj4gYzUNCj4gPiAxYTIyNmINCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGRlcGVuZHMgb24gdGhlIGZvbGxvd2luZyBwYXRjaCBzZXJp
ZXM6DQo+ID4gMS4gaHcvYXJtL2FzcGVlZCBNb3ZlIGFzdDI3MDAtZXZiIGFsaWFzIHRvIGFzdDI3
MDBhMS1ldmINCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1k
ZXZlbC9wYXRjaC8yMDI1MDkwMjA2MjU1MC4zDQo+ID4gNzk3MDQwLTEtamFtaW5fbGluQGFzcGVl
ZHRlY2guY29tLw0KPiA+IDIuIHRlc3RzL2Z1bmN0aW9uYWwvYXJtOiBVcGRhdGUgdGVzdCBpbWFn
ZXMgZm9yIEFTUEVFRCBjaGlwcw0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjUwOTA0MTAwNTU2LjENCj4gPiA3Mjk2MDQtMS1rYW5l
X2NoZW5AYXNwZWVkdGVjaC5jb20vDQo+ID4gMy4gdGVzdHMvZnVuY3Rpb25hbC9hcm06IEFkZCBP
VFAgZnVuY3Rpb25hbCB0ZXN0DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L3FlbXUtZGV2ZWwvY292ZXIvMjAyNTA5MTcwMzU5MTcuNA0KPiA+IDE0MTcyMy0xLWthbmVf
Y2hlbkBhc3BlZWR0ZWNoLmNvbS8NCj4gDQo+IA0KPiBUaGVyZSBjaGFuZ2VzIGFyZSBpbiBhc3Bl
ZWQtbmV4dC4gWW91IGNvdWxkIHVzZSBpdCBhcyBhIHJlZmVyZW5jZSBpbiB0aGUgY292ZXINCj4g
bGV0dGVyLg0KPiANCldpbGwgdXBkYXRlIGl0IGluIHY0IGNvdmVyIGxldHRlci4NCg0KSmFtaW4N
Cj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

