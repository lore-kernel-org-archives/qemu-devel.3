Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B091CCA476
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 01:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Ifk-0006Lo-Vz; Tue, 07 Oct 2025 21:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Ifi-0006Kh-IK; Tue, 07 Oct 2025 21:08:50 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Ifc-00051f-JI; Tue, 07 Oct 2025 21:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWPYcv2Lpd0zgbgpwKnx3kXJ4LWRQT0Dnmj/95jkASJlmYjonRzZv1YFpg0Nz0x9RB0motQPIOWGaealVrLX+1GDepm2qD/zRGzMKVHLDLAy20B65YT1VjITo2Vd3Tt1dYSUthFImHsaptOxn56F2DLO7ObVksf6XTRY/VmkKRnvDo+MPDyVpKez2oaQNm71mVRUriZ6sggH+abnPw7E8iuZ2oYbZbyxdX1UC7CvpwRAe7FdaSIsj8EkrwEAMaXHUJv7xC4unW5MmKQSz01DYBkky+d9ZD9q2XZz1JEpBN/ST8phrj6Ul47GKR63IECXnen5Q5mMyrRaI1C2sex2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTPzCJtmXqD3R8xsGoXk9dQpv1cQ2TFaqXHcoXXiBvI=;
 b=iU++pGS4smUcdODX8ePQK33FCtKv3715VmBtKl0om5jN9UC8AY3paV4KzuG/p5GHRgDJuzsplB32OJ5qMSAwT3bz2fSZ0FJrY+3A4Pth0rlxWe4i0V8pJUIhbEDszDsVFSp7iq8gAU89e7NdC3J7nz9RUEQCWgFlse+OVTKygHOpMNfqx+LPgtHblJyPTX3EIdLqsLkZj/f0XeCjy2jYlbBQcEAqKLOLeoVv8wLvTOewMivO1HwEJvrhUu/+4usOVZgJdAcRx/IpYgTmhfzt0USLgVDXaqZd+QRCwZoXxp9wnL4F0ZHjBFv803vqzgzC0ejlvijeTfbSW2To5qXdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTPzCJtmXqD3R8xsGoXk9dQpv1cQ2TFaqXHcoXXiBvI=;
 b=qcQVsf62GzqTrRHYyhDkvZGiUyE3cIifAJAERiLf27St6Wt/kId/59Dy4MxgFhqEHt/+l/aiYv0HniQidIXq401iXGoDCDvlFNGXg/pg2HY9MHKJvsKXtzmoRWyOBoyNZzJKPlNVThC6rIUWrjiXFdEJxSZpCSbEHzEWifH+gigQdbqzB2sKy02kemchEK9QRZwxlrbQ1uvEBPxFKs0+F+2TK9lmcHwZFdkPVu9aHw3MObWgYaRsI0AKZjppU+Jx/06h8lFxhJL1qvJ+nm9YuqpWkA3ac2sDhq2xcxUMtxsAFyVhg+ESezMaaOh5ykHaI8wCc7rC5DyfoGW55vEDrQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7063.apcprd06.prod.outlook.com (2603:1096:405:40::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 01:08:29 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 01:08:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Thomas Huth
 <thuth@redhat.com>
Subject: RE: [PATCH 5/5] test/functional/aarch64: Split the ast2700a1-evb
 OpenBMC boot test
Thread-Topic: [PATCH 5/5] test/functional/aarch64: Split the ast2700a1-evb
 OpenBMC boot test
Thread-Index: AQHcN5UTZqIdm56JQ0mPhMySjRdbmLS3cMwQ
Date: Wed, 8 Oct 2025 01:08:29 +0000
Message-ID: <SI2PR06MB50416932485AD7B2984B0343FCE1A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20251007141604.761686-1-clg@redhat.com>
 <20251007141604.761686-6-clg@redhat.com>
In-Reply-To: <20251007141604.761686-6-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7063:EE_
x-ms-office365-filtering-correlation-id: 278fcca5-4813-4ca9-7175-08de06073129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L3JTOWkySlYvSW5RUWpBZGNZSTd0VlJVWUVUeDlEelV2SkQ3WFRjc0lBVUhR?=
 =?utf-8?B?QzB4K0diQmlXY2V1R25KdkRJcmplMTIvMURyb2ZlR0Q5MjIxMW9ab25vYXZz?=
 =?utf-8?B?bnBZdkZINndURk5NeHlSczViRC9rV0tJZjM0ZnlFK3ZJNjl1MmFVZy9YUXBW?=
 =?utf-8?B?MTNCWmoyUDRvcXk5dXh6SzdRcTJYVnA3UjByUU9MOGd0K21Oa0puVnZ5UWxp?=
 =?utf-8?B?S0xBYlkxVGVTTFB1YjR4bkEyVEtQeDFKNUlqVm5NVkxUZmkwNkdCNG4xYVVI?=
 =?utf-8?B?M201cjM0QjN3eDFUY3VoaXdLeVQ2UlROSkRXRytEV1ZoZTd2NDVmSFZreDdH?=
 =?utf-8?B?Z1ZqM01TVUhzZHNiOStLc0pWczA0a3B3RG9zL0hwdGU3VlB2NE0wbVdITTRa?=
 =?utf-8?B?d0xUUUxIdWptemVXbWV4Y0NWenJsak5PNitid3VIRjVwK0NiQ2FkSzhWWjFj?=
 =?utf-8?B?SVorT2pXd2hEQW9zbkRnNktrT0M3WFpZQlR5OGtlMEkzY3dVU3J1QkdrSDha?=
 =?utf-8?B?VVkzamo0RmM2MEVUN3V5aVpLUEladG02V1U1N0lGc1JhdWVuR3Bicy9XWXgy?=
 =?utf-8?B?dlA2Si8zejNKRVBpQzNHQTFjN1VDaWVWOXk2M09ZOHFaN2srWGdBczRDTUQz?=
 =?utf-8?B?UE90elJSUUxFakRVTnhSN1lLV3ZlYlNCRm5Cb0M0akh1YWFoVDVQUllJaVR5?=
 =?utf-8?B?Vm9JVzV4Q25GZnA4aFdwQTE3eVRaTDVZbDdXQ3NUTlgrZlBOSXpEYlJoc0RW?=
 =?utf-8?B?cGVsTkN1YVRuRXJSTXk0WlpXUE9zc1NzNmMzUHAvVWJIK1ZZVkdZVXl4QXNu?=
 =?utf-8?B?K0xkRlplSHhzUmJWVUhZdnhDTWllbWgzUXJSZ1NwL21qNEJmc25wNlBBOGMy?=
 =?utf-8?B?TnFNdmZqWkxQRmdoY2RTTHJYOW5GYmc1YWtUVHBrQ2xDQS91Sk9vWDJ0dXlw?=
 =?utf-8?B?c0lCQzRsdXBrZHMwRis3Y3NURlJjQncwMDRzYlpXSG1BKzNUdUZhcEs5ZGlG?=
 =?utf-8?B?T3Z0TnNEOXpVNEVGbWl4dHJLRTA5UFExWU5pYi84Q21hMlRRczlEMFdHVnVk?=
 =?utf-8?B?Mm9uOFBqa0d6SE1Gd0Rub2lyVHFrQTM4dXlKbXJURWFaNTNkcS9kZ004WHdE?=
 =?utf-8?B?bU10Z3d5QVpuejhaZzBMbXZxNWlkMTg0V2paaGx5bUZYMEQ5NXFTbENvM0Y4?=
 =?utf-8?B?cXN5bXRQUFhWbk1RSTVYVzVxSmdBUTczS093ZEVEVUhkdjI1dDdEU2NHcjRR?=
 =?utf-8?B?RjN0YzZ2QXZJREt1UkMyN2Q1REZVM01nYWR3YVAzc0o2RkVpOFdLOFIyd0tV?=
 =?utf-8?B?QVg1MTg3dWRUVE1PTlorNjhFdXlObWNFeTd0b09GdURCMnJJekVaMitMa256?=
 =?utf-8?B?RGdTSTJFNW5pSXRYZDZTUHpVK3NqS3lsdmpDdnRpNm5YekkxZU4zV0pyS3dv?=
 =?utf-8?B?V2NDOHBmbEVMM09kQjhvMU9JTjlPalRvQVFEU1pmeEQyL3NqemFhQ3hwL0xZ?=
 =?utf-8?B?THUzaHNyTDJ6NGNYZ0xnL3R4YmEvRnJOUVZyelRTYURQQ2lDMzQvckRBRTBp?=
 =?utf-8?B?c2ZSWmVXbnVGRy9HMGRIYyt1ajhENnI2REJ5bVF1VDJKTmp0ZjQvR2dGYVNE?=
 =?utf-8?B?K3ZSMGZXUVpUOGJra2RJdWdiVEh4VjNRWVJWK05ONkhhdnBONmh3c2hDeWdl?=
 =?utf-8?B?b3o5L3B3eHlvdTREYmtLelpsd1ZnQitaYldKU0tpdVhOYWhRVjhubGhFRTAw?=
 =?utf-8?B?U2F3bmFKekhxeU5hRyt2OFBQckV2VU8rTEZXQUVrS01yZlZUOEt0Rm9EYnFz?=
 =?utf-8?B?Um5HcUtXOGpwc0RkK0ExdTB2Q1F3OUZNck1lSGJkS05oYVBJaHJGNDlHeWpr?=
 =?utf-8?B?M1hxQXlUaHkyaFMwUDRkcVh3dVJPWWFWa1JlMG5FMDZMWG1rSjRYMXJvdStk?=
 =?utf-8?B?cUZzQm9qeElqd1pwZzFtZ3JHZWVkU2dkcTZBbHE4T1JNWkZDbVFMVU9TbElY?=
 =?utf-8?B?NmtvVFMwcGVYVTRZQWNmWnZVZnl0TFpSa2J2TXZHR3dzdHdmbkhUMkk1T0lv?=
 =?utf-8?Q?6rp8bc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0VFMVdqTmxPaGdONlNnMlVRMEF6RUtmWVNUakRvK2o0b0hRTlliamYvajVW?=
 =?utf-8?B?Tm9GWG43VmRlTDFrVGdEcFl3alZPT01sd0Y1NVNDcEd3RFNXa0VseFdRN3Ex?=
 =?utf-8?B?dzFKNzN4Sk9FbG1nbFhkc1owZEZVdllaKzJWVUZ4bndIWGpkQUtZVmlwMmV3?=
 =?utf-8?B?U3pHT0ZoTzIyUjZ0eFFCc01iY3NaY3YyVlVLYUYvdHNkVVd5YWU0ejByUGxP?=
 =?utf-8?B?MTNxbkc5RUoySUd5TkJCTFFRK3JXL0hDYzZqT1FrV09iRkhONCtGKy9UWkZX?=
 =?utf-8?B?bERscWRXWWtOU2FkNGgwaGVFWDNYRDh4QmpaMzdWSHk1MFFDU3N3SWYwNGEz?=
 =?utf-8?B?RkM2TENTMG8wWUZwM1h1cWRrU05nakQyeS9wRVYvOUJ4WjBnajlIQldvaDR3?=
 =?utf-8?B?ZnVPKytTR2N5OUdiTjEwa2tOWjBKK1lCM2lPZW1GSDlLYSszQnBEWXh4Uzls?=
 =?utf-8?B?RkVMQUE0NWdWTEgwbG1NNG42bjhhakZyalhBcm9kT3BQbVNrcEk0b2NHQzlM?=
 =?utf-8?B?ZFU4RVd1Zkk5NnVpSlc0UWJOYlJzNk5xYWcrQjk2alRrM3VOYTRCa3V5V2Fx?=
 =?utf-8?B?TGpDZWtCMWRVOEo3TVhiNGIwcFkvcEM3TS9KNHVvSEt6NkhCOUFIMkJuVFhM?=
 =?utf-8?B?bENEMU14dytYRWhaUGxudlNtTVF1b0ZzbmlGenI0ZzVsRjZlZlJpSE01SVJY?=
 =?utf-8?B?eGx3Qi9pbUZBMVpqVDV6NE40eFBOcFprQXl0clh3QWg3MkZMaXdHTHlMRGNX?=
 =?utf-8?B?YlFydnl3ZHNrQjhockRIMWNRYmVPUzJnLzQyUDZXTWp3emF2bWZRN0U4TkZV?=
 =?utf-8?B?RjZUS2h0UDlVQzZJSndxTEozSEpaTUN0VnRwTCt2Q3VhNDlub1QxSzdUQmN1?=
 =?utf-8?B?N3UveVdadUkrZ1JMR3RoeDZueXZhTWw1a0dHMVBHTVFjc3dML3VaR21uLzhV?=
 =?utf-8?B?em9vZXc3OTVQUTRsNElLY2d2NWFlYXl5VmlYRkJwSmtKR3VVN2p6UnZhMkxh?=
 =?utf-8?B?SzdldDY3VEVaandoZlYxSDFjY1B5QzhsVVcxTkZqOXlTdlo0YnV4RDNsZmtm?=
 =?utf-8?B?R0ZyblJSZUVWWW1UKzRQRDFLTlYrNXFSK0Q3dGRyU0JVVldUMVkvd3lvZFcr?=
 =?utf-8?B?dUp0d1NWaFRtUjRKUEh5b0p1a0Y0emF2dFdMUEphY2tpL2JrVGZ0SjY1MXo2?=
 =?utf-8?B?c09ydmNCK3hRRnRKR1huRkU3MmNIVmlqNUVlTjRjZ2NzSk51YSs4L0lnZjBF?=
 =?utf-8?B?czV1N2JXVkVtQUttME1BblVjL0F4Ym51NVhOWWQvakZkUytFdDVVK3BMNUpE?=
 =?utf-8?B?SU1QM0tEejNPRXh0L0FpRzNqdFowb1A2QjZhRHFrLzhkOFpRVDI1OGFheTFm?=
 =?utf-8?B?OFRSc1ZRY1VHNEwwQW4ySXlWZXhPVWtRSXVCdVk2cFBqb3BTT1F4cU5od0dI?=
 =?utf-8?B?V1BYSDVVMWRMSDZKYUVvczJOQm5naGVMZDFDeXB3UEdOVWp3c0NBKzB6Qm8v?=
 =?utf-8?B?d3JCdVllSFR0cCs3WUU0czFIUWJNeUpDQ1lmdnlUQnF1c3VGckxrL25kNFAr?=
 =?utf-8?B?U3prd240YjlleUgzeXoyRnRoWnZXc1kvVjB2N2ZtbXJCR0NkZXgxL29oaG9Q?=
 =?utf-8?B?dERwQnV0MEtjQVpoZ1lmbVowTmlLUkc5OEFHYlZLby9FeDFiUVVGYmduMHhX?=
 =?utf-8?B?TTFjNktFQWFnYVBucFRDcmZpTTNFbVZ3SWJVR1M5ZjNTdktocWYxWnlOMG1y?=
 =?utf-8?B?NjFOVGgzQVJLOTF0Ymdyayt4YWc4UnFZeEtxY1FpeHBCMUxNeGl2emFVbUNt?=
 =?utf-8?B?dWxVQmpZakdXdGVqNWVxdCs1eGY5WC9FS25NZmE1SGRsUWJQcG01WkhpU2RN?=
 =?utf-8?B?Tm02V1NpVE9FN2ROcDd2R2I0Nm9VdGxZUVhZb0tuM1liV2JydnBkQ2pieVM2?=
 =?utf-8?B?MFB2RUVkNU5HZ01GKy9oYUlxQkoyLy9rQThEazFrSEgxT0ZxQWRSQzA1TlNM?=
 =?utf-8?B?YStybHowVnlqbitlTi9kYjE4RHprSklGRzBTQ3BsUGh3UjFXNTVsZTlwamRW?=
 =?utf-8?B?UVc2TTJtMXJrSkR0K0NNVGhNcHJaUCsvMUVQVGpqY21WVVExeklRdm9PL2Rw?=
 =?utf-8?Q?Pb61Jhbntcpm0oth57nCcenqc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278fcca5-4813-4ca9-7175-08de06073129
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 01:08:29.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hq73Tn4qMm+ZRw/k/VGa1+FoYmDqUaE2K/QwMKkiWffx3p/61SSw9Co8fMkCnJeprMd7M1dKKOeb1jaQ4Ulqc/Ezj5pgRe0TD4a9Lzt0nZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7063
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

PiBUaGUgJ2FzdDI3MDBhMS1ldmInIG1hY2hpbmUgaGFzIHR3byBmdW5jdGlvbmFsIHRlc3RzOiBv
bmUgbG9hZGluZyBmaXJtd2FyZQ0KPiBjb21wb25lbnRzIGludG8gbWVtb3J5IGFuZCBhbm90aGVy
IHVzaW5nIGEgdmJvb3Ryb20gaW1hZ2UuIEJvdGggdGVzdHMNCj4gcGVyZm9ybSBhIGZ1bGwgT3Bl
bkJNQyBib290IGFuZCBydW4gY2hlY2tzIG9uIEkyQyBhbmQgUENJZSBkZXZpY2VzLCB3aGljaA0K
PiBpcyByZWR1bmRhbnQgYW5kIHRpbWUtY29uc3VtaW5nLg0KPiANCj4gVG8gc2F2ZSBDSSByZXNv
dXJjZXMsIHRoZSB2Ym9vdHJvbSB0ZXN0IGlzIHJlZmFjdG9yZWQgdG8gZm9jdXMgb24gdGhlIGZp
cm13YXJlDQo+IGJvb3QgcHJvY2VzcyBvbmx5LiBUaGUgT3BlbkJNQyBib290IHZlcmlmaWNhdGlv
biBsb2dpYyBpcyBzcGxpdCBhbmQgYSBuZXcNCj4gdmVyaWZ5X29wZW5ibWNfYm9vdF9zdGFydCgp
IGhlbHBlciBpcyBpbnRyb2R1Y2VkIHRvIG9ubHkgd2FpdCBmb3IgdGhlIGtlcm5lbCB0bw0KPiBz
dGFydC4NCj4gDQo+IFRoZSB2Ym9vdHJvbSB0ZXN0IG5vdyB1c2VzIHRoaXMgZnVuY3Rpb24gYW5k
IHRoZSBsZXNzIGVzc2VudGlhbCBJMkMgYW5kIFBDSWUNCj4gY2hlY2tzIGhhdmUgYmVlbiByZW1v
dmVkIGZyb20gdGhpcyB0ZXN0IGNhc2UuDQo+IA0KPiBDYzogVGhvbWFzIEh1dGggPHRodXRoQHJl
ZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+ICB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0
MjcwMC5weSB8IDkgKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvYWFy
Y2g2NC90ZXN0X2FzcGVlZF9hc3QyNzAwLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0
L3Rlc3RfYXNwZWVkX2FzdDI3MDAucHkNCj4gaW5kZXggYTYwZGMxMjU5ZjY5Li4zMmM5NzFlMTM1
MjggMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9h
c3QyNzAwLnB5DQo+ICsrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9h
c3QyNzAwLnB5DQo+IEBAIC0zNywxMSArMzcsMTQgQEAgZGVmIHZlcmlmeV92Ym9vdHJvbV9maXJt
d2FyZV9mbG93KHNlbGYpOg0KPiAgICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2Vs
ZiwgJ2RvbmUnKQ0KPiAgICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ0p1
bXBpbmcgdG8gQkwzMSAoVHJ1c3RlZA0KPiBGaXJtd2FyZS1BKScpDQo+IA0KPiAtICAgIGRlZiB2
ZXJpZnlfb3BlbmJtY19ib290X2FuZF9sb2dpbihzZWxmLCBuYW1lKToNCj4gKyAgICBkZWYgdmVy
aWZ5X29wZW5ibWNfYm9vdF9zdGFydChzZWxmKToNCj4gICAgICAgICAgd2FpdF9mb3JfY29uc29s
ZV9wYXR0ZXJuKHNlbGYsICdVLUJvb3QgMjAyMy4xMCcpDQo+ICAgICAgICAgIHdhaXRfZm9yX2Nv
bnNvbGVfcGF0dGVybihzZWxmLCAnIyMgTG9hZGluZyBrZXJuZWwgZnJvbSBGSVQgSW1hZ2UnKQ0K
PiAgICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ1N0YXJ0aW5nIGtlcm5l
bCAuLi4nKQ0KPiANCj4gKyAgICBkZWYgdmVyaWZ5X29wZW5ibWNfYm9vdF9hbmRfbG9naW4oc2Vs
ZiwgbmFtZSk6DQo+ICsgICAgICAgIHNlbGYudmVyaWZ5X29wZW5ibWNfYm9vdF9zdGFydCgpDQo+
ICsNCj4gICAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsIGYne25hbWV9IGxv
Z2luOicpDQo+ICAgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxm
LCAncm9vdCcsICdQYXNzd29yZDonKQ0KPiAgICAgICAgICBleGVjX2NvbW1hbmRfYW5kX3dhaXRf
Zm9yX3BhdHRlcm4oc2VsZiwgJzBwZW5CbWMnLA0KPiBmJ3Jvb3RAe25hbWV9On4jJykgQEAgLTE0
MSw5ICsxNDQsNyBAQCBkZWYNCj4gdGVzdF9hYXJjaDY0X2FzdDI3MDBhMV9ldmJfc2RrX3Zib290
cm9tX3YwOV8wOChzZWxmKToNCj4gICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLW5ldGRldics
ICd1c2VyLGlkPW5ldDEnKQ0KPiAgICAgICAgICBzZWxmLnN0YXJ0X2FzdDI3MDBfdGVzdF92Ym9v
dHJvbSgnYXN0MjcwMC1kZWZhdWx0JykNCj4gICAgICAgICAgc2VsZi52ZXJpZnlfdmJvb3Ryb21f
ZmlybXdhcmVfZmxvdygpDQo+IC0gICAgICAgIHNlbGYudmVyaWZ5X29wZW5ibWNfYm9vdF9hbmRf
bG9naW4oJ2FzdDI3MDAtZGVmYXVsdCcpDQo+IC0gICAgICAgIHNlbGYuZG9fYXN0MjcwMF9pMmNf
dGVzdCgpDQo+IC0gICAgICAgIHNlbGYuZG9fYXN0MjcwMF9wY2llX3Rlc3QoKQ0KPiArICAgICAg
ICBzZWxmLnZlcmlmeV9vcGVuYm1jX2Jvb3Rfc3RhcnQoKQ0KPiANCj4gIGlmIF9fbmFtZV9fID09
ICdfX21haW5fXyc6DQo+ICAgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpDQo+IC0tDQo+IDIuNTEu
MA0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoN
ClRoYW5rcywNCkphbWluDQoNCg==

