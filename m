Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AB2D711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 05:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXYHg-0005qL-Bj; Mon, 22 Dec 2025 00:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vXYHI-0005me-HK
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 00:16:29 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vXYHG-0005Xo-ML
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 00:16:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNheRf1vWhx0bJwytKMhUxVA9RiB41NcehMFDokUORXQXq7YfS0AIY8qhR4/Dd7MPf5i/YHOfcKPTL9x3YGO+DTmXD++NrkGPzRs5gs9lpgDhLIUF6obylIbKJM4KlObq+MTpOZYW5U+gpigW8ZG/s9GBKX4d7H+BY9oQdMBE+srzIQ+E1QI2NuLUMANZPXhRJgjuNgYEwrN0xSaZjm4dKTX4PcZWBhLrNezb9tbGdmrTgBCdM330rzOr9zYWLXsZ+X8L4GiFmkn+05V8Wwyukdil+sMKQMCIMSwikKIGLBBN6YBYfqHDi8ENlUdEWmxWZ0LQAImXodNMT14aO1N8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/K0FXnq5sacZWowTSPySBUzERON5Ss+ytJzwZ82R7U=;
 b=xwj/hLxFJwp+Mx+aVMMhSWXZs3DWp4hQmyvC8c2XLJm051yfoF1sEsuhVR4fJSdHYy+Mmdbc3NaHkchaJF9gVRAvGDZ7j5SdghumGKpArd+TcHx3qs3pJzFl4xMuPDhU8niYFOs/3v7JdDoM0yqeeWdWne+UDOBJNzreC5hpfKI8H2B7pQnOpj17zVWx+bOvmrErNX8z4aATS5jn0FejvKZruS9Inlfb/tNzCHRnp6Yybs2a7YEQ+B0cL/a6gwbTk1PssffbUmgC1fbUgJQhEQZ4X7jcF6jdA/R/jhQPu1faTFuCup8i94VOFifQSUNft0PC5aBxwUIRO3UZSLIf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/K0FXnq5sacZWowTSPySBUzERON5Ss+ytJzwZ82R7U=;
 b=PXFyn4LiKGyNsLY5c4CoY5Khd1882AEmip5S9S5lVOemIBRhkr/MeUE6L2DmxsJoQve0N51qGAG1YLbCHdcf91tAvbkjkoQ8NhRWhHnbR76Vf89AzimrlJYPBXZgUKLkWXzZvWOVnPJ7AnltK8+dgaaTge3srTT9EkQb1s+j8rctOKdxhnOhWwV0eN6d+XnyNfga4lF3B9hvos4F4aQHcmSLUeKUZt+cfxmEB+JNRL3eHeKKHGePvn5hbUhqBzQo4elbKfKEyLXJb7WL8AopZtmF5fuhKLMK8Dah8Qr5aPjlSYTmveYuAwcH5qrJHY89yRxnulaf0ZSy6R99lUP9NA==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEZPR06MB5270.apcprd06.prod.outlook.com (2603:1096:101:79::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 05:16:09 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 05:16:09 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH v3 3/4] vhost: SVQ get the indirect descriptors from used
 ring
Thread-Topic: [PATCH v3 3/4] vhost: SVQ get the indirect descriptors from used
 ring
Thread-Index: AQHcbi9KYr7ZEq1QEUCvf001/NpuLbUoogyAgASEJ2A=
Date: Mon, 22 Dec 2025 05:16:09 +0000
Message-ID: <PUZPR06MB471314C8439265FD36DED158A2B4A@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20251216015701.6601-1-wafer@jaguarmicro.com>
 <CAJaqyWe7tdPRg=cMzEytEa4jBqtQk1vCuDuwJu5Kzp-j074=QA@mail.gmail.com>
In-Reply-To: <CAJaqyWe7tdPRg=cMzEytEa4jBqtQk1vCuDuwJu5Kzp-j074=QA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|SEZPR06MB5270:EE_
x-ms-office365-filtering-correlation-id: 6711fa9e-10de-49a6-7f6e-08de41193758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QnJtTUs4c0U2YlprekhvVUZXanZGS1ZuK2E5WXlrSDAwUFlmVVZGWmxGemFh?=
 =?utf-8?B?QUNlcU90bkxsNytxT3RKd3gxT0RtSTAxdXNGUHllM2lDRmFzK2h5NzJLc1Zi?=
 =?utf-8?B?Q2wxbmR2NFowUkFmNnk1aUhNbCtPbW1LdjI5d3BkQ25XWERsNzhMQ3hNdUJJ?=
 =?utf-8?B?bHF4SjBveEZSa3hnb2t4eXdkZnBOK1FkSTlRSmNrUVdMb2Fvamw1OWFOYnd5?=
 =?utf-8?B?aEE0QWJjSlhGb3RGZXIxSHhhUmVGdFlEYU5RTEh6dmpPaDZJTGMxNE5iUGEr?=
 =?utf-8?B?RnFBZ1Fja0syRFFLVUVQdkhRaDlkdjFiRE9WbldkMnRMVkg1NDlHQWZzbjdq?=
 =?utf-8?B?cEUvUUk4b1BhVVBoVC9XWms1UkgzVCtyVmZwYTU4Rk8zN2p6cnFxTzFycFVn?=
 =?utf-8?B?eDNlTElQRFExaUJWY1hXdzlrdnNkWEFFdlhyMFVUZkZZWFp5QWhFdWRBQjVv?=
 =?utf-8?B?TU1uQjZDRkhveHd0cm9vZTBSeDZzdmtKSDhub0xXV1c5RDdoTTlrODhhUURq?=
 =?utf-8?B?WkxkaHJIYUR5MlFpWlRFaWpYd0NXUlVlYThYQXNjVmtmTWNUUGFONnluM3ZE?=
 =?utf-8?B?Vng4Q01SQWMvVE1YUnFuc1JGUDVUZFlCQ3h4UzBzTFdxWW1Ua2hodUxFaEhj?=
 =?utf-8?B?OHMzZndzaVovYUo0NVA5aldaRXBvK09Cbk1WeVZPaDlSNk16RXBidlNwNkVZ?=
 =?utf-8?B?ZzhGWkwxVHBOK1d1bUs3eUJ5blRPNCs2WmM3WGFscjg4UU56YUNmRndhVmJD?=
 =?utf-8?B?bGs5cndNckljN1R2OVo4S0xkbGdtM2dWSnF4bUttdythanNabktmQUFraTlO?=
 =?utf-8?B?SlZmaGNDN29JSnBvNzlxZlJSeForQnB2V0JHdzdnZXhyOUwyM2R2T01Da0NQ?=
 =?utf-8?B?ZXYyVFBBM1hpZWMzMVBtODZaQXRFU3VFSlFISHplK2NxbWZKblBOby9ySWtw?=
 =?utf-8?B?b1RaSjk1ZmJ3dGVjb3RWcTBOVVlkZnRUdk4wTUNlaGZkTURJaTlIS3loRG55?=
 =?utf-8?B?aEtITGpLREY0WnVLRWc5VmcvNkp1WmVDaVpuaE85VWdHKzMrZUJsUno4MmJt?=
 =?utf-8?B?bTVLbUZmem5lYlRIRU5XWTd6NFlJWDdUVEtyRy9mZGd0SmVxek9XYm16aGZZ?=
 =?utf-8?B?YXhHbWM2R08wcWxlQ2VJZUIxUkRHaCtqNURoTjZyVEM4R2x2UU15QTN5cmFR?=
 =?utf-8?B?Y1NKdUhiRlBOM0dvWTVFMmlTamVRMTFKS3JWUWduR1RZRWNSdmJuRzZCOCsr?=
 =?utf-8?B?M1JjTnJsMHN2cFphTHJNMUZjSktERGh5L1JQQzdSRzY1bGt0dWUvYWRjbDUy?=
 =?utf-8?B?SDZ2QTlmVDlqbnRBcDY1RWxVV3pBYXVpOFZ4QkM4QzZqNHJTUjVpTzcxWDdD?=
 =?utf-8?B?UTJUOWZub3FwaDRJcGtDNUlDTmJzR0dqOGx5M1lhRlBWWkJCdUNOUldMQ2hQ?=
 =?utf-8?B?Z0YyN1BhTmcwZmp3djhVbkpkRlREOFlFdlFzRnQ5Sm1kcjF5ZjV5QnQ5ZmhO?=
 =?utf-8?B?RHdCWloxOHlhdmNhVW80aG5Qalk1ZzVvSlpVdUwyN3owUGdlTXE1dm12R1RN?=
 =?utf-8?B?MmYxT09NNFloV1NjdUtvcEVyMXl6T09hS3FPN1lMSng0NWxaOHlTcmhGVHdB?=
 =?utf-8?B?VlpxOXkxWWpORmRRem1BbXRRdTVFcXlRcm5BQzA4NE5UdmZaRGdEVTlsdHdC?=
 =?utf-8?B?M2pvWmhRbUlnRVJlcVhHM25mSjlwUXNSbXRldkRsVlFQWDNNZWJvekIweS90?=
 =?utf-8?B?MWNZRkFsUnR6Q096OUlBWkpMeHgzb1J6UHpRdUN4blVrUGlSbElpVnE5elBT?=
 =?utf-8?B?bTMxWWMycnVzYjYwaXM1WlljNm1Ud1g2VFZuRXlGVlFNY3lBMk9GeVY4MG5T?=
 =?utf-8?B?NUNPRUR3UTVFK1lSc2FwVUpKbSsxTWJSWjVOaEFDTk9uV3g3SzhwaW5tOUEz?=
 =?utf-8?B?MjNycjhLKzZYR0pPMWxlUjZMcHR1RXB0Um9KSU50RjgrbGJUMmZtWHJPd0tD?=
 =?utf-8?B?YnRYS21wNWpNVXlZeDY0YndFS2k0M3RxcUs5emljcnp1TW41eUd2UmJNc3E2?=
 =?utf-8?Q?AcMiD1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkMvYVlxS2N5M3VpWDNzZWxJeTBxY0RCTkdDMG5QMHZwaHZMWWR0dFNTR2JF?=
 =?utf-8?B?OTNPZlFWd2FkenZ4MEhQYkVDNlRKaitSOGl3MlgyRFRWbW9BNm5YODZSRmtO?=
 =?utf-8?B?YmxjVWJPUmljSGFwbzhHT0pDWGFkQzQ5dTNRY1lGTUU3Q0t2TTNGdkpVS2dO?=
 =?utf-8?B?K0cvZTBNS1ZxUEg2bDFYN2xBY3Eybi9DeEV3Y2EvQ3QwQSs4WUdmZGVpODl1?=
 =?utf-8?B?alJBaXJNQUFzeVhXM0loYnp3aEpTaHBYY0lDLzhRUmNMRC9YU3RRQW9SdGIz?=
 =?utf-8?B?c1R2emdyUEQ4T2h5Y05XUENlVVE5d3FET3hVL2xiQmF0bUwvaVZleHRSdWJ1?=
 =?utf-8?B?MkJBLzMrc2M5MUx4SXhIS0dIM3NhWTlJY2JUcGRnYUVkclM2MG0wRjV5eDdr?=
 =?utf-8?B?VGg0RVAyaE1uMDFaZFRkL0ZyczZvbjdvT2J6RGcvakRXR3pyejZETjU4aUps?=
 =?utf-8?B?cUFyTmZjMXk0MW15NVk5Q1pEVWp4S2t1TWN4RWtYd0MxUlFzUGEvKzBOS2NJ?=
 =?utf-8?B?NnRoSVJ1ZDRpL0p3OVJRZlpPS0xhaTBDTUpjTXloZ1RRZEsyaVVhVkZTaG05?=
 =?utf-8?B?K3p4ck9QYlo1dndzMjBrSllqeFhqQWhZRCs4OXQxdVdBekZPdEdac1FJYlB4?=
 =?utf-8?B?U2txaUxaOHNHTm56QlB4OGNsajZEMGhlOXJrZFFxOGllNGpicEdwbVd0Mzd6?=
 =?utf-8?B?blpWcmRnTEtHV2hWV1J1Y1RpdnN0K2J6VW85NXAxL3hRejFOV1ZocGQ2Q3RM?=
 =?utf-8?B?RE9kK1RqWkRxTm1VSnBNZWhrTkVuanJ0K1FsL0MvQ1gvWm5vbEJJZEFzR3dx?=
 =?utf-8?B?azRMWDZiSXhHUzJscTZDcXNHcFRLWC9FNVpad2JNSXpWcUFHUkJYYWYwV0lJ?=
 =?utf-8?B?bnAydXdla2p5RjVNcWdlbTkzYmkwQTJjeTFEcVg1VUdFWjNZNFQvMUlxNXJS?=
 =?utf-8?B?dVExazlGWk9ZTkIzdUMxanEwOHFRNzZSR1ZBeGdSM0xlSDJWNVJ3eXk5Q0hN?=
 =?utf-8?B?ZkxqWXJyN20wWk84c1hOb25CVE5tZHNVdTFPM3NYNzVXYlkwL1A4ZzMzZitq?=
 =?utf-8?B?dkRaTm92TktlMXJlV3VDdUZyOVc2NUEwQlZ4Y084b3VmQlpvaEQ2TUV1RVk3?=
 =?utf-8?B?RnlPTGFwUVBPQTdKWk1NbFZDdWJVUnNVUGJYYXdRUFBYZ3pHSWNjVGFJb0k2?=
 =?utf-8?B?Y0RQQ1dBRW9GamRDbzNuZXFyb2ZJUlBMZGtjd0J5QTZyTmhqMFQrbGNidGt4?=
 =?utf-8?B?Y1BXcUd3di82MGJjRll6YkdiUlcxS0luaU1sUE9FUFRwNGtsMGdudkpBQ2lq?=
 =?utf-8?B?bDBpb05QS0tjTXBwTWdDditaemFPcHpEQUZsMXlyUnZuUldtQVFCSmxjOXpK?=
 =?utf-8?B?d0EzVmNKbHZjdmtpanBuK1V3RWROMDRuc0RkOFhOZW1HYU81clhZMnJ1Vzd4?=
 =?utf-8?B?L0FneW4zWmhYWUdBcm9ub0x3RTFqK0ZVT0puVGFkOVlFZHlJNW4zTFFQYVZC?=
 =?utf-8?B?NGhtRGVLcEYrc1hSNHY0RE96WHVsKzdGQ0lFcGlyZ0tSbWdqUkxxcEZwZE9l?=
 =?utf-8?B?Mno0QmcyZUw1VmRqWGhDSFNyQWtURXF2S0c0NGVuYkIydlJVckZDSGozNFIr?=
 =?utf-8?B?MkdGYVRTVFhGWjV6a045Q2NKZFJFMzFvWWZrdjJiN0hNTkt6M0wvR1NlTDhz?=
 =?utf-8?B?TnpLVmZpdDRtbFZNbmU5VGNQQmNPZkNzYUU1RCtlQ2hOUmtZalZ4OExWWkha?=
 =?utf-8?B?bHNyYWtKZDRLZ1BPSkV5NmpBcXVFbElTOGkyMkV0YTRnK3NuNlE0VjlGU3lU?=
 =?utf-8?B?b1ZCTVBNVFp6b0NTRGZVbjRlZFY0TFkyNHZiWGlnRjQ1Y2Y2NVp0dlQvaWw0?=
 =?utf-8?B?SExkZlM1UU10cHNHM01BWGtpMlF6ckxTMHd5bG1nMUNvSHJoNVdXWnFhVDho?=
 =?utf-8?B?cnlxekZCUXFIazUwYUdkSnY1MWVPZHdpOHVWUG9uYk92TWlFbVFaemlxL1NR?=
 =?utf-8?B?NTZUcFJJUzZoVEw0MXpDUkhTR3grbHhUbXZlTGxuTFJwZGpuNm5tdDA2SDZ5?=
 =?utf-8?B?MTJjSkJ5Q3laZlVQOGYrWjREZFRRU0IxZllpUFUveSs0T3pObGNrZ0lxMjlT?=
 =?utf-8?B?Q3AxelhialBySW5yRWRyek54V1ZpVkhDWWJLbVVMQ1ppSjhsU3BvQ1g1NUNO?=
 =?utf-8?B?UmNhL1hpMVJHUENvcjBNV2pyM2puWHRGaEduKzkwY2loNzZFVkFKZXQxMUxl?=
 =?utf-8?B?S3hjaEoyQllYc3U4SFhPWEMwemhPN3lsM2lXSGRrTnlsVUN6cXU5aGxoVktu?=
 =?utf-8?Q?HmqojoLROsZ4qyyG+p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6711fa9e-10de-49a6-7f6e-08de41193758
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 05:16:09.1631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2OnN/KHy35ziIWvUqp9VdjCf/q07Rwfplw55F9h/OOKS6bgDxGZL27z7hvN9h4AISwJXvcwvmcQPG1UoAstQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5270
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXVnZW5pbyBQZXJleiBN
YXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIwMjXlubQxMuaciDE55pelIDE2
OjEyDQo+IFRvOiBXYWZlciA8d2FmZXJAamFndWFybWljcm8uY29tPg0KPiBDYzogbXN0QHJlZGhh
dC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gbGVp
eWFuZ0ByZWRoYXQuY29tOyBzZ2FyemFyZUByZWRoYXQuY29tOyBBbmd1cyBDaGVuDQo+IDxhbmd1
cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzRdIHZo
b3N0OiBTVlEgZ2V0IHRoZSBpbmRpcmVjdCBkZXNjcmlwdG9ycyBmcm9tIHVzZWQNCj4gcmluZw0K
PiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VUU0lERSBv
ZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVu
dHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25pemUgdGhl
IHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIFR1ZSwg
RGVjIDE2LCAyMDI1IGF0IDI6NTfigK9BTSBXYWZlciBYaWUgPHdhZmVyQGphZ3Vhcm1pY3JvLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiB3YWZlciBYaWUgPHdhZmVyQGphZ3Vhcm1pY3JvLmNv
bT4NCj4gPg0KPiA+IEZvciB0aGUgdXNlZCByaW5nLCBiYXNlZCBvbiB0aGUgc3RhdGUgb2YgdGhl
IFNWUSBkZXNjcmlwdG9yLCBpZiBpdCBpcw0KPiA+IGluZGlyZWN0LCByZXRyaWV2ZSB0aGUgY29y
cmVzcG9uZGluZyBpbmRpcmVjdCBidWZmZXIgYnkgaW5kZXggYW5kIHRoZW4NCj4gPiBpbmNyZW1l
bnQgdGhlIGZyZWVpbmcgY291bnRlci4NCj4gPiBPbmNlIGFsbCBkZXNjcmlwdG9ycyBpbiB0aGlz
IGJ1ZmZlciBoYXZlIGJlZW4gcmVsZWFzZWQsIHVwZGF0ZSB0aGUNCj4gPiBjdXJyZW50IGJ1ZmZl
ciBzdGF0ZSB0byBTVlFfSU5ESVJFQ1RfQlVGX0ZSRUVELg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogd2FmZXIgWGllIDx3YWZlckBqYWd1YXJtaWNyby5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L3Zp
cnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCA0Mw0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93
LXZpcnRxdWV1ZS5jDQo+ID4gYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jDQo+
ID4gaW5kZXggODVlZmYxZDg0MS4uYWRlZTUyZjUwYiAxMDA2NDQNCj4gPiAtLS0gYS9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jDQo+ID4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuYw0KPiA+IEBAIC00NjksMTIgKzQ2OSw0NyBAQCBzdGF0aWMgVmlydFF1
ZXVlRWxlbWVudA0KPiAqdmhvc3Rfc3ZxX2dldF9idWYoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2
cSwNCj4gPiAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgICAgIH0NCj4gPg0KPiA+ICsgICAg
LyogQ2hlY2sgaWYgaW5kaXJlY3QgZGVzY3JpcHRvcnMgd2VyZSB1c2VkICovDQo+ID4gKyAgICBp
bnQgaW5kaXJlY3RfYnVmX2lkeCA9IHN2cS0+ZGVzY19zdGF0ZVt1c2VkX2VsZW0uaWRdLmluZGly
ZWN0X2J1Zl9pZHg7DQo+ID4gKyAgICBib29sIHVzZWRfaW5kaXJlY3QgPSAoaW5kaXJlY3RfYnVm
X2lkeCA+PSAwKTsNCj4gPiArDQo+ID4gKyAgICAvKiBVcGRhdGUgaW5kaXJlY3QgYnVmZmVyIHN0
YXRlIGlmIGl0IHdhcyB1c2VkICovDQo+ID4gKyAgICBpZiAodXNlZF9pbmRpcmVjdCkgew0KPiA+
ICsgICAgICAgIFNWUUluZGlyZWN0RGVzY0J1ZiAqYnVmID0gJnN2cS0+aW5kaXJlY3RfYnVmc1tp
bmRpcmVjdF9idWZfaWR4XTsNCj4gPiArICAgICAgICB1bnNpZ25lZCBpbnQgbmRlc2NzID0gc3Zx
LT5kZXNjX3N0YXRlW3VzZWRfZWxlbS5pZF0ubmRlc2NzOw0KPiANCj4gTml0cGljaywgd2UgY291
bGQganVzdCBwb3B1bGF0ZSBudW0gPSBhbmQgcmV1c2UgaGVyZS4NCj4gDQoNClRoYW5rIHlvdSBm
b3IgdGhlIHN1Z2dlc3Rpb24uIEkgd2lsbCBtb2RpZnkgdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9u
IG9mIHRoZSBwYXRjaC4NCg0KPiA+ICsNCj4gPiArICAgICAgICAvKiBJbmNyZW1lbnQgZnJlZWlu
Z19kZXNjcyBmb3IgZGVzY3JpcHRvcnMgcmV0dXJuZWQgZnJvbSB1c2VkIHJpbmcNCj4gKi8NCj4g
PiArICAgICAgICBidWYtPmZyZWVpbmdfZGVzY3MgKz0gbmRlc2NzOw0KPiA+ICsNCj4gPiArICAg
ICAgICAvKiBDaGVjayBpZiBhbGwgZGVzY3MgYXJlIGFjY291bnRlZCBmb3IgKGZyZWVkICsgZnJl
ZWluZyA9PSBudW0pICovDQo+ID4gKyAgICAgICAgaWYgKGJ1Zi0+ZnJlZWRfZGVzY3MgKyBidWYt
PmZyZWVpbmdfZGVzY3MgPj0gYnVmLT5udW1fZGVzY3MpIHsNCj4gPiArICAgICAgICAgICAgLyog
UmVzZXQgYnVmZmVyIHRvIGZyZWVkIHN0YXRlICovDQo+ID4gKyAgICAgICAgICAgIGJ1Zi0+c3Rh
dGUgPSBTVlFfSU5ESVJFQ1RfQlVGX0ZSRUVEOw0KPiA+ICsgICAgICAgICAgICBidWYtPmZyZWVk
X2Rlc2NzID0gYnVmLT5udW1fZGVzY3M7DQo+ID4gKyAgICAgICAgICAgIGJ1Zi0+ZnJlZWluZ19k
ZXNjcyA9IDA7DQo+ID4gKyAgICAgICAgICAgIGJ1Zi0+ZnJlZWRfaGVhZCA9IDA7DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICBzdnEtPmRlc2Nfc3RhdGVbdXNlZF9lbGVtLmlk
XS5pbmRpcmVjdF9idWZfaWR4ID0gLTE7DQo+IA0KPiBXaHkgbm90IGNvbnRpbnVlIHVzaW5nIHRo
ZSBidWZmZXIgaW4gYSBjaXJjdWxhciBtYW5uZXI/DQo+IA0KDQpUaGUgbGFzdCBkZXNjcmlwdG9y
IGluIHRoZSBhcnJheSBjYW5ub3Qgd3JhcCBhcm91bmQgYW5kIGJlIGNoYWluZWQgd2l0aCB0aGUg
ZGVzY3JpcHRvciBhdCBpbmRleCAwIHdoZW4gdXNlZCBhcyBhbiBpbmRpcmVjdCBkZXNjcmlwdG9y
IHRhYmxlLCBhcyBpbmRpcmVjdCBkZXNjcmlwdG9ycyBtdXN0IGJlIGNvbnRpZ3VvdXMuDQoNCj4g
PiArICAgIH0NCj4gPiArDQo+ID4gICAgICBudW0gPSBzdnEtPmRlc2Nfc3RhdGVbdXNlZF9lbGVt
LmlkXS5uZGVzY3M7DQo+ID4gICAgICBzdnEtPmRlc2Nfc3RhdGVbdXNlZF9lbGVtLmlkXS5uZGVz
Y3MgPSAwOw0KPiA+IC0gICAgbGFzdF91c2VkX2NoYWluID0gdmhvc3Rfc3ZxX2xhc3RfZGVzY19v
Zl9jaGFpbihzdnEsIG51bSwNCj4gdXNlZF9lbGVtLmlkKTsNCj4gPiAtICAgIHN2cS0+ZGVzY19u
ZXh0W2xhc3RfdXNlZF9jaGFpbl0gPSBzdnEtPmZyZWVfaGVhZDsNCj4gPiAtICAgIHN2cS0+ZnJl
ZV9oZWFkID0gdXNlZF9lbGVtLmlkOw0KPiA+IC0gICAgc3ZxLT5udW1fZnJlZSArPSBudW07DQo+
ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIElmIHVzaW5nIGluZGlyZWN0IGRlc2NyaXB0
b3JzLCBvbmx5IDEgbWFpbiBkZXNjcmlwdG9yIGlzIHVzZWQuDQo+ID4gKyAgICAgKiBPdGhlcndp
c2UsIHdlIHVzZWQgJ251bScgZGVzY3JpcHRvcnMgaW4gYSBjaGFpbi4NCj4gPiArICAgICAqLw0K
PiA+ICsgICAgaWYgKHVzZWRfaW5kaXJlY3QpIHsNCj4gPiArICAgICAgICBzdnEtPmRlc2NfbmV4
dFt1c2VkX2VsZW0uaWRdID0gc3ZxLT5mcmVlX2hlYWQ7DQo+ID4gKyAgICAgICAgc3ZxLT5mcmVl
X2hlYWQgPSB1c2VkX2VsZW0uaWQ7DQo+ID4gKyAgICAgICAgc3ZxLT5udW1fZnJlZSArPSAxOw0K
PiA+ICsgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICBsYXN0X3VzZWRfY2hhaW4gPSB2aG9zdF9z
dnFfbGFzdF9kZXNjX29mX2NoYWluKHN2cSwgbnVtLA0KPiB1c2VkX2VsZW0uaWQpOw0KPiA+ICsg
ICAgICAgIHN2cS0+ZGVzY19uZXh0W2xhc3RfdXNlZF9jaGFpbl0gPSBzdnEtPmZyZWVfaGVhZDsN
Cj4gPiArICAgICAgICBzdnEtPmZyZWVfaGVhZCA9IHVzZWRfZWxlbS5pZDsNCj4gPiArICAgICAg
ICBzdnEtPm51bV9mcmVlICs9IG51bTsNCj4gPiArICAgIH0NCj4gDQo+IEkgdGhpbmsgdGhlIHR3
byBwYXRocyBhcmUgZXF1aXZhbGVudCBpZiB0aGUgZGVzY3JpcHRvciBjaGFpbiBsZW5ndGggaXMN
Cj4gMSBleGNlcHQgZm9yIHRoZSBudW1fZnJlZSArPSBpbmRpcmVjdCA/IG51bSA6IDEsIGNhbiB3
ZSBtZXJnZSBib3RoIHBhdGhzDQo+IGFuZCBqdXN0IG1ha2UgaXQgY29uZGl0aW9uYWw/DQo+IA0K
DQpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLiBJIHdpbGwgbW9kaWZ5IHRoaXMgaW4gdGhl
IG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2guDQoNCj4gDQo+ID4NCj4gPiAgICAgICpsZW4gPSB1
c2VkX2VsZW0ubGVuOw0KPiA+ICAgICAgcmV0dXJuIGdfc3RlYWxfcG9pbnRlcigmc3ZxLT5kZXNj
X3N0YXRlW3VzZWRfZWxlbS5pZF0uZWxlbSk7DQo+ID4gLS0NCj4gPiAyLjQ4LjENCj4gPg0KDQo=

