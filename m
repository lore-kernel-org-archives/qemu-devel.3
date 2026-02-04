Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2C9E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8i-0005tE-VG; Wed, 04 Feb 2026 02:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZI-0004ct-UH; Wed, 04 Feb 2026 01:40:52 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZH-0004KA-6M; Wed, 04 Feb 2026 01:40:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfa3j/cEgvYFs5VeY+InwPxOhTUu5MPN77B1BTh8XbjHFZ9oCBtBkro7tSNOEve2LFZkzh3N/Db4+13y9f2XhrLNkelvZvS4v7b13i3wIm92W+exWXXfoh9fvMHrL99tpmoCMhXr6eB7yENmVuFk3dETMq2DOhAsg1KlzDVe4Lek1LZTTlzhmLBMbBQ2hgY31a9Lu/H7KAMmHpz6zRmfZZgarS8M2KM1t8uDBpCRwfMBYR6biNAsFQbFAv2/587fbO3PZOzTO1NlKCZyI27z/H8Mm5N57BUxnlJY5i/XcFNicaGl/tYeK1akRxqL1UXZNmMC8zWbI+icRIPE80OyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1utkksajml/H0TzsMuYaz07WJlVYCtbYxp04dwtxmc=;
 b=IimwNpZMzz6oOg2BtrfBKrfWERffHvHQnuVo9C4ee9bgjOkgbKMqw9i3+ohAtQQnwIKhpDgEtiWttdj+F6ShXAmw8iXEr8jv12Rpdzs4PKpiso1gMEI3wU/WBuP/ZXRyNdpRiwxhIu/pfR/o+x0ZrNBTs5n8x5kroMKpxVaJlWRAR5Y+IQQ4uJ5cgso/yHFVGx0TDw14AJqdUPYfl8zNDlNTknpSTDuEVy1i8kUNrUTOUn7VUqvmXGtU52+mTlnhQRtUaV0KxDJKccF859VBC8Gzuohsgpyyzi7CqjwrnOHysil6yEDAYdWke9/NmjaRqGIwhBboF60/cl5YSCi5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1utkksajml/H0TzsMuYaz07WJlVYCtbYxp04dwtxmc=;
 b=O/cxwBfr7HUQQVy0/DiFP4WvP4s+tlWLdt+MHzHNIKO+AmKZQXU8Hp/IprnqUXnZ6I0IR6/jEtcjzcmeGzGNe4hXRwCqpp6S1PXAHnBoTHgSKwcQLs0X2H87CuioGCmDZX5jrScKhdGfLFimYirxEWgvWefpizYmOJqYe6gUl76S6uNA3Y0r5CxGlNH68oMawff4ov/8AhlEv8850P/vAzcO/7QAThn2lML7Sie6+bkeC97mozPgm+WlMbMjNcMjGMGPc3MZszOAHFO61hCgAImXEs9NybYCGdOaqjY+Wi310Ae1KkuIiCSL+iGkxsPB90oIvAgRxcLiIRf0ojs0Fg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:30 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:30 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 09/22] hw/arm/aspeed: Attach SRAM device to AST1700 model
Thread-Topic: [PATCH v6 09/22] hw/arm/aspeed: Attach SRAM device to AST1700
 model
Thread-Index: AQHclaEn24/Drvw4R0GSBhYkI+7fGQ==
Date: Wed, 4 Feb 2026 06:40:30 +0000
Message-ID: <20260204064016.3515639-10-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: ba10e142-a34d-415e-0c8b-08de63b84a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dHB6RXByT2hQL1BBdWw4Q0g2QkFJUk9zcGtMTkFTQW1GYUxGTXAzbi9Oc1Na?=
 =?utf-8?B?MGlsa21naU44TVFNL0pGdlBjQmprVm1ITUp0a2NXUGNMQlQvMTBmTGZOZU9N?=
 =?utf-8?B?b3dEUHdNa1pmQkVCUGlYTDMzc2s3SWtYanU5Z1I5WVNkMkorakVCc01nWEw2?=
 =?utf-8?B?MGkwc05ZWEFzY29vSmtaREtpZStRZHYvNHhwMjZlbEFvTnorcXRWQ3orOTFM?=
 =?utf-8?B?SDF1NktERjBGTTV5NUNTSjkraUpTWUdnNDQrQTNLY2xMWFdldm5vRjhWK3FM?=
 =?utf-8?B?YmVrRzJYR3djMTlXYzdCbjVhYVR4a2Q4UlJwa3dJbVFqYXZoMkllVm01c011?=
 =?utf-8?B?L2ppSHVnWWJUUE1hMmcvYXFsc0VlRGVpdTZmT1RDMmR1MjZpYnR4RFRiVWhs?=
 =?utf-8?B?K2hWTElPYWdia3k1TytLS0pveFRvUm02ZkYzejBabmZ0MGVZR1pOYWx6cU9V?=
 =?utf-8?B?clRxdUxQOEhLTWRWUE9ZZmo0NkVtR0FGb1YxcUVDZWwyVDFMZjd6ZlcxbTJM?=
 =?utf-8?B?ZWhhVnh5WXVZZmtDRmRpVGwzK1NBYURkRjNTMVFlU3ZpMzcreVVvbGlGUVBx?=
 =?utf-8?B?bEM4NkpuU3ljdDEza1YzK2I1SUsrUmNzK3Q5Nys5UzJlblRYQWNPU0RTbmRW?=
 =?utf-8?B?SjljOEdwbk1YdWRlU0xEWGRRUXA5NkNobU5yaENwekVHUTNUNTVJczRyMFRD?=
 =?utf-8?B?ZGY1VURUQzJUejZVSXNaY2ZNNmRva3FCVWY3WHVQSWdMZWJuMmJPMFRBaXU4?=
 =?utf-8?B?dzZxcXRCUE1XelExelJ1ZHRRRjJ3VDcycEpPa0lseGtaQ0JKRjM1RHJiRVpB?=
 =?utf-8?B?MVJiWGh0dCtJZFUwYXNRL0xjZlZYV0ZVcjZtSG1iOU1HZi9GRlNmRHJNVkdF?=
 =?utf-8?B?TmVIdUZqSjdOTWprd2gzNkNyVWoraVVxczZMeXdBWFJ4NlhPWkZMZDRNVVN6?=
 =?utf-8?B?bys3SzdzbEh3bHFjR2lnUUxqb1grQzcxeUs4LzV5Y1dOc09ka0hKc2NqSmIx?=
 =?utf-8?B?MkNmMmh5NXJkU2dldFZLdmJoR0Q0VkU1TEJ1Z1NGL2JFR0ZKRFQ1ajJ4RElm?=
 =?utf-8?B?d256NHJzVTZrekQ0L3pkQ1BzVmkwLzZZa2hCSkp3Rm9aYnZDSTZPQW5qZ011?=
 =?utf-8?B?b0ZRZ2FRakNIbERXYlBLcnEyeVRSYjVEWlVHdkQzeTFKcEFHcTF0K21vcExs?=
 =?utf-8?B?a0FQRkNHZkpxcE5XRFpnOXNQTTAwV2RLdW1VOFhFOVV6NzZTc2V4RCtEMkdQ?=
 =?utf-8?B?SnYvMm5jRDFSYmdVU3RLdVpqL1FlamVGUE5mblNjUDEydjdCVFdNcUNSQ1M0?=
 =?utf-8?B?UUV0VnZPM1BSVnErSnlGbW1oL1dRUVF6Y2gzTzMrenZSQXQ5NENPU2srdnRj?=
 =?utf-8?B?empXZFJjbkV5L3ZROUNpRGc3Y1o1SnYwM1YwNFMwMmJoazhuaHEwaUJxMEsx?=
 =?utf-8?B?bEErOE0rZW9GOC9IWWpFQk00WkpZdGovU2NNYnNsNGVPNzdyMVYrcFFDdTB1?=
 =?utf-8?B?MFVRNTk4RlNjSGcrOWZUY0RHT3kzdk5KeU1kWHdQSzk0bjVJN3B1aDM2SCtO?=
 =?utf-8?B?R05USnF1UExOU3pZQlRTZ3hDeCtJa1lKODFvNU9JOVYvWVhNeG9oa1RUQXgv?=
 =?utf-8?B?L1Z2UnlhUkN3dVM2UHYrUUtsSS9FdlBWSFF5RDdSVUIwcVBBTmdZcnFWaytV?=
 =?utf-8?B?UzhnQkVFclVZRVdOSUttakoyNXQ4cnV5RzZMb2ovc0M5dHZGbVNPa0o1Nlo3?=
 =?utf-8?B?M1ZuQWYwNmFZOWxjUUVMdytKSDlpODdhc3krOWF5Ym4xVi8vWHgrT0duVGw5?=
 =?utf-8?B?WEMzYVNSOWJSTUFCVHZPb1hqTkp1U1drN0ZqbHJCZG1wWXJIeU90ODRhTFpW?=
 =?utf-8?B?dmtDYlhLYWNsNmFicVduUzJFTGRZZEZmMm5GQmp4cHBWSnQ4NE1GcjZUYmZi?=
 =?utf-8?B?aWhVV2prQ08xeVJjd3IzKzl2b3RJZFJyL2t3WktTY09xcTdpUExFb0RKU1ZI?=
 =?utf-8?B?RjZxenJZaFpXdm8yRjFEeHZVSFgxc2dxVnB1V1NiZXJtZmUzUGl4UlFCKzVz?=
 =?utf-8?B?UXFkaXJvQW1XMFNUaTBLV3IvcDIyNm5yZThsbkYzc0c4ZjVoWVdLb29NWUNx?=
 =?utf-8?B?VzNBUzRJdUpvSHpsR3VVVGdzVVkySkp0azY0dDQzbGVraUhaMGhuQzc4RUcx?=
 =?utf-8?Q?tdrJn87jguY2Ntyzxmwg/ew=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0ErclF0eVk0MmczRmFMVVVXRWtBRVpRcnVCRjE1eFJyYitSRkJ5NzV5cE0y?=
 =?utf-8?B?QlNyTCs4MVlVcjlEZ1RQRmVxUkt2NGZWWDc0bFRTb2Z0SXNJWDJOQlRSY2xr?=
 =?utf-8?B?RHNWWExpa1o3U3h0MTZWZmpkODZlbnE3cXh5bWtCdEkrcWNXeVJhZVNGUGNL?=
 =?utf-8?B?LzhsNGI0M1lPaFVpK0hpcXdFYUJ6aHVheEVMeTNJd1h3VUM3MERLV0ZxRDAx?=
 =?utf-8?B?MXVvU1FwZDRvb0RlRjBlV2tONXZvbnRwMTRyUXRVRzZwZ2tkSFdpUmh3OUgw?=
 =?utf-8?B?N284OEdvVStFRzRQaDA4Q3BWYW9wMXJXTDJkZ3p2NVJNWFV5Qm5vb21aWmtC?=
 =?utf-8?B?M3JxSEVEemNKOUtjUlpVbnl0dGxvN1BpRUpPcUJ3U1BYY0ord1V4OVArVkxy?=
 =?utf-8?B?emtsNGFsb1dWallVaVRKb0VsT1FNTjRGQzBQNXoycFFFYjZFU25yUlhWdEhs?=
 =?utf-8?B?bjdyT1p3MzZvTFdnYzNSbzFNNkp5ZTVVNGlGZWVJQlRQcjZ3L1o0c1M3aFB5?=
 =?utf-8?B?c2NhTnR5blNnL05WZ241SWZMNHNCeGhyTTVTQkhmMG0xblZuNi9ycUNQSkdN?=
 =?utf-8?B?TzM1RXZSWDF5aWtEQ25wa2JYekxQa3R6TmtqMk5aTDg4WUhsaTB1N3V2Z1hC?=
 =?utf-8?B?b2JyVmx0UDd1Q0NhMHYybWFYamF1MldwSjBvVVhOVnYxalpDdXk2K2Vjc0xj?=
 =?utf-8?B?clhzSThsb0orb2RRd1B0cFJ3UmVOM2lWdW52SUJWdlVCRi94eVllNUxwWTYw?=
 =?utf-8?B?RjBLTHhFWkU5RXF6MmdONDRwNEJudEoyVnd4U09XSGhxdFFEOGd6TFBqVHg5?=
 =?utf-8?B?YkhaRG9VZzhyTE5abE81NDFPdUVpN3pkc0x4ZnBxMUMzWVhVTlN5d2tjZThn?=
 =?utf-8?B?SGRMU3lVZ1JFSjE0NENwenJrUCt5M2VJYXNIWDI4MEpWbkFzWDQ5cW9RM2NO?=
 =?utf-8?B?M0NyV1oxbmFnRTZXTHpGR3dwVFZQamUzYlpoNVBhOXFBYWtrNVRLUi9uZ3By?=
 =?utf-8?B?TjVkemZ6WkNoQXpBZVArTjJMOU5YWFYycXZkOFkvK05nNmdGOFhaS0g3RHBV?=
 =?utf-8?B?RUlZbnVoRTdaMS80cFVXcFBtaWkvVHFWdTUxWXQ0RERCbGxiTGl3SWNpSHE2?=
 =?utf-8?B?QWpBRUZJY0pIOTBlR0hTekh0MEJ0WHJtRFY3eHQ0OGJKU085RDhha2FoYlYz?=
 =?utf-8?B?bjdSd0NicHd6WmJkQXNjbGRkQ0dkZmFSMTM4SVBKMHZoajVTSWxBM21raWY5?=
 =?utf-8?B?ekF2c3J6a3ZqdWxuUmEzTGl6TnhIaDcrSUg4WEt4QzVzTXRBdTN4c0VpNnJO?=
 =?utf-8?B?WlFMMllDTjVrUzd0a3Q3L1ZmcmlBMDFKTFNYRHdua0dqTTdaTUpUQkJERE5t?=
 =?utf-8?B?ZFVQd1Z5RFU3T2M4NVEwc0F0MFNKTllZWkd0T3M5M2tjQ3dSUlFEaVFCbVJy?=
 =?utf-8?B?NVQzNkdhYkFZLy93UDgzRHZBd3BPSUFybDdjbmpOQVJGMHY1QnJpMTFlcXlJ?=
 =?utf-8?B?d0xxNS9hOVlDOGZ2UGZZVDZGZzRkcXpMdGo0c1A0elpjTmNoNHVSVk8xR0FY?=
 =?utf-8?B?ZG55aldSd0tHWHNIQzMxNktmVW9LcEVHZkY0MHBJcURYZkMyZ0N3Ym9iMzBQ?=
 =?utf-8?B?VGJUbURPeDk4emZiRzVJZ2liU1hXSzZWVm1ERGx0OWNIZ2JHVFZWcHZLWlZB?=
 =?utf-8?B?YkR5VEk5aldYTHhNWFUyMkE2N3F6L0FoaEVTc3BTTGJLazN0RnR2VHRuMDZV?=
 =?utf-8?B?TzRPWW9EYXBUK3kvZEFjb24wbi9TRWRCVGgzTjRBZ2dtTmZiakF2Wk1aZ3l6?=
 =?utf-8?B?bVpNQjJBM0RRWGYzWkdhdkttcC9GbDhTQ1BzdFc3dXVIek41UTk3VGcraUJj?=
 =?utf-8?B?cWhpazRKOFhpM2RqTEV0d3JqR1N3TFdTajJlTGErcHNPb0Q5aEpna3F5bXUr?=
 =?utf-8?B?QUVwQUgxbGFpa21IOWZhRkRtOThwYWdyUExGdlk0d2NJRzFlYnI2TW1CTnNO?=
 =?utf-8?B?S1IrdUtNaHRkT1BQTjZyUExZMDg1TlVka1kzMWpicGlZVVFSby9zOWY1UFpI?=
 =?utf-8?B?QjZzU2xVd0RBeW0yM2h3Z0dnNGIyVnljalhmTjhidW5uMERtSG9WZk1JVi95?=
 =?utf-8?B?eW93SUZuUXM5K0ZzTUFBT3o4RWdJWWJ2QU55RnZpNlFwTHF6NkVrSytGWWZp?=
 =?utf-8?B?OHR6dFNjZGl0b2ZqbmprUklQSWViN2w1d1BiQkZ3UFcwYlRHcXQ5d3BJMTQy?=
 =?utf-8?B?ZitJNDBlLzd3OC8vUU5yMG9Sa25XUStwRlc0YmpsL2MxVGxma0Y3TGZxWk1l?=
 =?utf-8?B?YlBKZ253Vm1wamZ4eUxiWkY3akNpTFFUZGpzcGE4OFU1RHcwMUF5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba10e142-a34d-415e-0c8b-08de63b84a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:30.0995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mayORfK9Ohur0eupREi+yAnSlYSSnIMNeweHY5c5BWTm46yjX76K7/KPAbUVWw3ufOqPVzgBEvUafZieRl43wqDx4FzvaS4jQwojJ0DqRD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:21 -0500
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

TWFwIHRoZSBTUkFNIGRldmljZSB0byBBU1QxNzAwIG1vZGVsCgpTaWduZWQtb2ZmLWJ5OiBLYW5l
LUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4KUmV2aWV3ZWQtYnk6IEPvv71kcmlj
IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBOYWJpaCBFc3RlZmFuIDxu
YWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4KVGVzdGVkLWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVz
dGVmYW5AZ29vZ2xlLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oIHwg
IDIgKysKIGh3L2FybS9hc3BlZWRfYXN0MTcwMC5jICAgICAgICAgfCAxNyArKysrKysrKysrKysr
KysrKwogaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICB8ICAxICsKIDMgZmlsZXMgY2hh
bmdlZCwgMjAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVl
ZF9hc3QxNzAwLmggYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oCmluZGV4IGIxNWIx
M2FlZGQuLmE5ODFiZmYzYjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3Qx
NzAwLmgKKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaApAQCAtMjAsOSArMjAs
MTEgQEAgc3RydWN0IEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSB7CiAgICAgU3lzQnVzRGV2aWNlIHBh
cmVudF9vYmo7CiAKICAgICBNZW1vcnlSZWdpb24gaW9tZW07CisgICAgdWludDhfdCBib2FyZF9p
ZHg7CiAKICAgICBBc3BlZWRMVFBJU3RhdGUgbHRwaTsKICAgICBTZXJpYWxNTSB1YXJ0OworICAg
IE1lbW9yeVJlZ2lvbiBzcmFtOwogfTsKIAogI2VuZGlmIC8qIEFTUEVFRF9BU1QxNzAwX0ggKi8K
ZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3Qx
NzAwLmMKaW5kZXggZjYxMGYyNTkzMi4uZmQ1ZGIzMjY4ZSAxMDA2NDQKLS0tIGEvaHcvYXJtL2Fz
cGVlZF9hc3QxNzAwLmMKKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMKQEAgLTEzLDEzICsx
MywxNiBAQAogI2luY2x1ZGUgImh3L2FybS9hc3BlZWRfYXN0MTcwMC5oIgogCiAjZGVmaW5lIEFT
VDI3MDBfU09DX0xUUElfU0laRSAgICAgICAgMHgwMTAwMDAwMAorI2RlZmluZSBBU1QxNzAwX1NP
Q19TUkFNX1NJWkUgICAgICAgIDB4MDAwNDAwMDAKIAogZW51bSB7CisgICAgQVNQRUVEX0FTVDE3
MDBfREVWX1NSQU0sCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMiwKICAgICBBU1BFRURf
QVNUMTcwMF9ERVZfTFRQSV9DVFJMLAogfTsKIAogc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRf
YXN0MTcwMF9pb19tZW1tYXBbXSA9IHsKKyAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1NSQU1dICAg
ICAgPSAgMHgwMEJDMDAwMCwKICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMl0gICAgPSAg
MHgwMEMzM0IwMCwKICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTF0gPSAgMHgwMEMz
NDAwMCwKIH07CkBAIC0yOCwxMiArMzEsMjEgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBf
cmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiB7CiAgICAgQXNwZWVkQVNU
MTcwMFNvQ1N0YXRlICpzID0gQVNQRUVEX0FTVDE3MDAoZGV2KTsKICAgICBTeXNCdXNEZXZpY2Ug
KnNiZCA9IFNZU19CVVNfREVWSUNFKGRldik7CisgICAgY2hhciBkZXZfbmFtZVszMl07CiAKICAg
ICAvKiBPY2N1cHkgbWVtb3J5IHNwYWNlIGZvciBhbGwgY29udHJvbGxlcnMgaW4gQVNUMTcwMCAq
LwogICAgIG1lbW9yeV9yZWdpb25faW5pdCgmcy0+aW9tZW0sIE9CSkVDVChzKSwgVFlQRV9BU1BF
RURfQVNUMTcwMCwKICAgICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMF9TT0NfTFRQSV9TSVpF
KTsKICAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwgJnMtPmlvbWVtKTsKIAorICAgIC8qIFNSQU0g
Ki8KKyAgICBzbnByaW50ZihkZXZfbmFtZSwgc2l6ZW9mKGRldl9uYW1lKSwgImFzcGVlZC5pb2V4
cC1zcmFtLiVkIiwgcy0+Ym9hcmRfaWR4KTsKKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKCZz
LT5zcmFtLCBPQkpFQ1QocyksIGRldl9uYW1lLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
QVNUMTcwMF9TT0NfU1JBTV9TSVpFLCBlcnJwKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJy
ZWdpb24oJnMtPmlvbWVtLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFzcGVlZF9hc3Qx
NzAwX2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9ERVZfU1JBTV0sCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnMtPnNyYW0pOworCiAgICAgLyogVUFSVCAqLwogICAgIHFkZXZfcHJvcF9z
ZXRfdWludDgoREVWSUNFKCZzLT51YXJ0KSwgInJlZ3NoaWZ0IiwgMik7CiAgICAgcWRldl9wcm9w
X3NldF91aW50MzIoREVWSUNFKCZzLT51YXJ0KSwgImJhdWRiYXNlIiwgMzg0MDApOwpAQCAtNjks
MTEgKzgxLDE2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAwX2luc3RhbmNlX2luaXQoT2Jq
ZWN0ICpvYmopCiAgICAgcmV0dXJuOwogfQogCitzdGF0aWMgY29uc3QgUHJvcGVydHkgYXNwZWVk
X2FzdDE3MDBfcHJvcHNbXSA9IHsKKyAgICBERUZJTkVfUFJPUF9VSU5UOCgiYm9hcmQtaWR4Iiwg
QXNwZWVkQVNUMTcwMFNvQ1N0YXRlLCBib2FyZF9pZHgsIDApLAorfTsKKwogc3RhdGljIHZvaWQg
YXNwZWVkX2FzdDE3MDBfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQg
KmRhdGEpCiB7CiAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsKIAog
ICAgIGRjLT5yZWFsaXplID0gYXNwZWVkX2FzdDE3MDBfcmVhbGl6ZTsKKyAgICBkZXZpY2VfY2xh
c3Nfc2V0X3Byb3BzKGRjLCBhc3BlZWRfYXN0MTcwMF9wcm9wcyk7CiB9CiAKIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBhc3BlZWRfYXN0MTcwMF9pbmZvID0gewpkaWZmIC0tZ2l0IGEvaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYwppbmRleCBkOTg2NmMyYzNi
Li42YTE0NDc0MmVhIDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYworKysgYi9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYwpAQCAtMTAyMyw2ICsxMDIzLDcgQEAgc3RhdGljIHZvaWQg
YXNwZWVkX3NvY19hc3QyNzAwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJw
KQogCiAgICAgLyogSU8gRXhwYW5kZXIgKi8KICAgICBmb3IgKGkgPSAwOyBpIDwgc2MtPmlvZXhw
X251bTsgaSsrKSB7CisgICAgICAgIHFkZXZfcHJvcF9zZXRfdWludDgoREVWSUNFKCZzLT5pb2V4
cFtpXSksICJib2FyZC1pZHgiLCBpKTsKICAgICAgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNf
QlVTX0RFVklDRSgmcy0+aW9leHBbaV0pLCBlcnJwKSkgewogICAgICAgICAgICAgcmV0dXJuOwog
ICAgICAgICB9Ci0tIAoyLjQzLjAK

