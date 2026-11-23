Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DB606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=cUrZiPDG;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tNjebKyu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKDH-00076N-T3; Sun, 22 Nov 2026 21:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKDE-00075C-PA; Sun, 22 Nov 2026 21:55:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKD2-0003cn-HS; Sun, 22 Nov 2026 21:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795402512; x=1826938512;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kwGQ+QhC1xenH0xARrnjRzzFeIzVZMqm2AKLZ8VhR80=;
 b=cUrZiPDG4ZZjDnqHNWdA6Evr1WokM63yDg+hdPm46KDbiFwOlygk8kia
 5qcZLNqmMqLt9lqpBjgiRhiYTHidEVSdWA1qkMh4WCvEQyW3FYEtFclL7
 CfsV+4mRyu5giYkzKBx9wYT8D0LaR0gO6bIlIIi56fOBi40ZV3m7GLnI0
 Ue9jzt5vs83HBzz1nqtpRpSGF8qt8aLSBCry58+o9f4KsBcJEcfLtHkbH
 g0ssuHG9eE5YsfUde3XLwDCppocCM3aEKTanMreJRKaXo263HjotlIPD/
 rNXVu4PBy7PnF18EV8C3MfU2n21W8YGH5jEpdHdmmcnG8Hts9dINq9GMB A==;
X-CSE-ConnectionGUID: 2topXhTFTqi/3y+dHY1hxQ==
X-CSE-MsgGUID: 9fh574gPSk+b6c/dO7evOA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="162503858"
Received: from mail-centralusazon11010037.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.37])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:55:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igFhM7OwxXgU99yFVsqLKyRNRS1NbYnpyBvNjsUPGWBolf3SuILhxGBZtus++pSiNDY+p6iDnTslO5UCg2boFKkGcZU/nf8d3UjNxESkskdCOvX3K5q2+BOUO8stq1uIhHCUM97exuQAHrS2Iwg6v+RF0vJGKzhjkYLQcGDoW9FzMZCJv+g13kjskv4Fn6M4pqWzaRzqdkn0F1IYQl6wDThwYxMj6dOSDbuqxYfIl7qdcMD32v6Ork74OhYmWoOdeKKp7exg+yx01KDO4oott6zQuWrgynXM/h/ZGsbydvn5Lt7/gE7HZd+U4k6pbTZev1E14XN2CBUwFBK2hmN96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwGQ+QhC1xenH0xARrnjRzzFeIzVZMqm2AKLZ8VhR80=;
 b=n9SjUhbyNiQieVf0FqRcgSiOQj0ilnnj9KaKX6LIjhosJEz5c8+KixcKI00C+GOxmhMHgLKq8H8aJc4io1p5Hgyku5ZICuEPHKkdZzugDJ6bxPt2XLP2ZuGtOEwvcFnC0GdNjzrtw1o7qQE1RuRsWwpfF1q6ydS/FN4EcUxpBPSN883AHiiLbHwt4vgOBMS8osT2xUKcyOAbTeJOtyN/C5HAr4qj3aK9TjKAL8jaakqpEeEyzMlhlj/oQqMcvoIb9qFqPuw3TCb8vjyGyn1lUdv4pgSCv2XlBKutrwkjLB7CEZ8IfxdhHPLkvmSveiGTGFubvB5bp2Cfc9lOJAcxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwGQ+QhC1xenH0xARrnjRzzFeIzVZMqm2AKLZ8VhR80=;
 b=tNjebKyuwidBCTx61V8rfnN7GG15QLacrYHpAQMkunLzSFX/tdaIB/VtT0WSdNf1V/ekpas4RE/zB4gNLoVd8Ccbt8jpNrC9mecnTlO1KFXxLHv4aY0sNr4v+sT/i0OtORilq3i6an2jvMh+2O66DxdllqUKZ1f3VfhhZmj9Qkc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CY1PR04MB9764.namprd04.prod.outlook.com (2603:10b6:930:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 02:55:01 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:55:01 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: make pmpcfg R=0|W=1 bit combo reserved
 [GL4820]
Thread-Topic: [PATCH] target/riscv: make pmpcfg R=0|W=1 bit combo reserved
 [GL4820]
Thread-Index: AQHdc7nAi4bfLQ5fMEmLaTuyAwBqvLc7BJsA
Date: Mon, 23 Nov 2026 02:55:01 +0000
Message-ID: <a8aca65d60cd91c285fa6b93aceb7bddd407fc0f.camel@wdc.com>
References: <20261113215537.158118-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261113215537.158118-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CY1PR04MB9764:EE_
x-ms-office365-filtering-correlation-id: c84bca88-1bcb-414c-3f48-08df490d2b06
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|23010399003|366016|19092799006|38070700021|261102123227099003|261028144727099003|11063799006|260925021911599003|261026121527099003|260925022911599003|261026140227099003|56012099006|260925021311599003|261021121427099003|10067099003|261022075727099003|261009223027099003|261022105027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: +ZgGBV7ric2wF23h7H5KTEA4o1PUczrMpzWOZMqT+9Fp1W2E8XMTa4bNK0MQNPTUzMDCcNbVY27MXQ3J0VgHLltLUMMHdrbmLel5+FuUrZdV1fkfsT57G38TalbhFKIQ8ofr5BFHC/kBKszo6+PdJNq0RwRqV/gcBMrdVgJdDwlY/8vdjhHwOD3HW9WPxMkKBPbNjUVo/9haM5fREKU1qMg6r31B5tvcYMPUcRDElbI0BOd7kBtmnQ0OUKCrgK0HiTX9eu+F42DkEeMlAz3fChb7Lxga+1Ks/b7JeM4gs04gBlgRPbNvtg5SbcT35eIWWMM8yE/n1NEpcwnAetZqnfFXH/i3t8FOtnUOT5bFSmaGMabpa+gJ2/TLZ4bYvBIWiUC6t9wNCnn1s4aNKUk0Q8PQV+ymGIAfhZeeWJJWx34nPSqkB91qpuWTLVW8FcHDk3cyMv9Iq4l7ungGAOKB7K13hWCoCbZNZqikbcw3IDj3QKEu4jteIpSjK91rm1s7hymFnETvDqTbbLB/ZIloGtQAzMKl4GAwSyUyCbctZ2W5NcJZLYwOXcrNjo+wEHz6egbMNTsM8LPy/DRhw6WeYrA2fBY6UxqXFGKBio2VkfpKgdNKlcBI1vUyoPfCMLvvEzVMjyjkLYTjg4YEvVBLRZW6cHPZjn4oslJbNaUZBToMqt+3iWmFkfU2qtQ2G5waegy3LpNamf4rZ5tzkyzz8xgbu/MU/AA25U5+Wab3vKQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(19092799006)(38070700021)(261102123227099003)(261028144727099003)(11063799006)(260925021911599003)(261026121527099003)(260925022911599003)(261026140227099003)(56012099006)(260925021311599003)(261021121427099003)(10067099003)(261022075727099003)(261009223027099003)(261022105027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmVGOWdYaGg2UzEzaHpqZGVXaW54Zmdvd21ETGZxWEpPYnF0VUFnVkpmSHdo?=
 =?utf-8?B?cDhzVGxVN1BSUzh5MDNubTAyRUhMaCttV0ZMM0RXRFIyU1hNR0R4cFN0RXRm?=
 =?utf-8?B?SDR2R0xveVMycEdWV3pOTEh6NkQwUnpCeXEyVW1IZmFFb2pyS0pMQWRweFFj?=
 =?utf-8?B?d0tGVytRTjFWNjFYbTQ1NklJWXZvSTFwVzU3ZjRwQS9zTXcrbi84R0JzS1RT?=
 =?utf-8?B?dGJlOTdNaUZlU0phWG9oKzVQOUFxNVpMbWZLSkVZajJUZGlTem5EUTZ5UWw5?=
 =?utf-8?B?b001YTdER3IrRGhSS3A0YUg2UUZGQVI3cVVURXVoMGkrYXVHd0ltVnJFZFk2?=
 =?utf-8?B?alB3T2kyMzJpRVRhenVRNFVPeXlOc2daQkg0WEh3L3BGSUlCZEVlOWdXdFd1?=
 =?utf-8?B?Uko0b0RCYjR0dGsxbDlYc1BxaUFsRVE5eGJXOU1QVUkyakV1Rm4wZFk0ZjBF?=
 =?utf-8?B?aGhvMmNyZ1hXcVNHMjRjeHVhL1VlTURPdFRUMzZOMVFObys5cEtUQUlsZlBC?=
 =?utf-8?B?R0dVd3lmYUc5Y2VsYktYQkZyN1J5Z0xmNENicXI4Ri96VWFocUdoVjNrd3pS?=
 =?utf-8?B?aStmMTN2elpGMHZVVmdkUms3eUU2NjBUeXRBMGVwZkpTcGZ5YXdvOFRaS3Qz?=
 =?utf-8?B?MW04LzBzZFlmMXUvWUR6U0JESWdLbGpKZlRHZURnK282dE92bWo5bXZlajI4?=
 =?utf-8?B?ZjQveUJPNUxPQ2dzRzdiK0V6SUZlY1ZZUGJ4cUxoOHAyejZKNS82WmlrQWdG?=
 =?utf-8?B?akpPd2tTZWJvRmpLNlVVU0FtL2ttVjAxQi9UWW9rWU9hazVqN25ETVdVRmEz?=
 =?utf-8?B?eHJhUy9kSGJJRXdidWt5alhSZGUwK1N2YVFna2V5K01md1hNWTlJaDVwb0dY?=
 =?utf-8?B?aGtkTHRTWXM1MzdGeUZYSkx3ZjVYMkp4cktidDRTZ0xNRXRMTmxrWVZIN0Vz?=
 =?utf-8?B?dVgvMWErVEVYTHhmQzdxWlc1QmJPWlV3NnkwbWxyRDMyRDRXbmx6Z01HU2tM?=
 =?utf-8?B?QWZGVFl1WWtJQTQ5VTZZcXpzUThOUGpxd2p0cm01M25nZU56SjJZRnc3dHRu?=
 =?utf-8?B?Vmd3OEZiQUtXWVc4bC9kdnJ1WVYxdU9RR3RFQkovYTBJVTFJS1pwSkx2SXFh?=
 =?utf-8?B?aEFmYlRKcGo5SnZhWlkrdUxRbHpCOFk5Z2pmR3lZNkRlclo2eXZxRDdhZEJY?=
 =?utf-8?B?Yk05dUR3aVVVRFlHS3ZHYTIwRUNlU3RpVHJkai83V3NxbFRseEI4cVo3R3pT?=
 =?utf-8?B?b2NnOUJjRWR2WTNUWGpnV2crRGc4S1lvdURsUFJiRlEvbG5LUnJ0SDJZbzdR?=
 =?utf-8?B?dUJGekFSckpQWTU2RnA0MnFNTG9hNWZPT2YzbE9Xc0huU1pMa2dIM293eDZt?=
 =?utf-8?B?cUlKK2trVTRiak1CZzFqckhuUnNWM2tkM2F1TVc1UW1SS1c1UmZVWS9Rb1FM?=
 =?utf-8?B?bFJRQmx5QXpPTWZkb3h3MUthZGN5ang2VHJYWGZFckdTM3lGd1lxRC9KRzcv?=
 =?utf-8?B?cWtmWld6eENPLzlPOTUvTmpFMnBDL3BlYXJOTmZXc3FTSjZ5dUZzTTc3dkU0?=
 =?utf-8?B?RnlBTmdoN2tYdTRKNFlUT2dtZWhzZEROZWNWdlE5aUdMaDhHNm85U2Z3UzZ3?=
 =?utf-8?B?a05tazc2b3Urd3BpVTROVk9SUGdaRVVSS2ZHVjJ4Y213dUhVRERxS0UvYS85?=
 =?utf-8?B?SEJ1dm14L3JDaVh6dzcvVksxc1cyN2gzTUJrRzJpMkQ3bTl5dTJNM2gzblV2?=
 =?utf-8?B?L0FPMUprV01OSlFvQ0tUYkNqbENRaUV6SDgrMGhnbEV2d2JVbGhVMUNSQlNL?=
 =?utf-8?B?U0E1Nks4cFVocmNjKzQ1a0E5Qlo2Z2I0NVRScVBMeFdyVzBwUjJPRktTZUtP?=
 =?utf-8?B?dFZtREE5UStiYzkrMTEzTUdEVjU0YjVvN0VwOEJmaG5PemFhVnp1MU9tNHI1?=
 =?utf-8?B?RXIyWUpJa3d3Q0syUTVsNTMybkdjTy92aitMWGtiWkNHY1lrVklyS1NBT2ww?=
 =?utf-8?B?TXhJZlc5UVIyQ05lMEYvMkVydjFRZ2RabWpOOVluUVBIVmZ5emFoNE5sTjht?=
 =?utf-8?B?VXVGdEw2OE5pUy9MV2FPZkpwbFBMZG5DK2lLRUlxWTVlVGRYb1RwUVlSbnlB?=
 =?utf-8?B?ZkpBMHc0WWcwc3ViMTNJa0c0dm9oZ3l6b2tMa0hhcEUwSC9BeElXNVJlVU9W?=
 =?utf-8?B?MGJsdkpHN3BmN3FGNzhuNnk4bjF1M1BDTjJLRkxvZDZ0UUM2cnpLR1hTTW9u?=
 =?utf-8?B?SE43bkQwK1Ayd2xkNWhuVWdmcnpNenJRUWV0bzBldEg3dGxhY2IzeEorQ3E0?=
 =?utf-8?B?NTE5WlVyL1FZSGFMQmtyRk5JYjBTL3BNY002TkNhV2xJN2RxMzB2RlFXSXp1?=
 =?utf-8?Q?PAf8T71vuAonqxBbaawmUQwXKxDtqLNITY5Gr3MbLEeNx?=
x-ms-exchange-antispam-messagedata-1: 7Rfj04ik/E63HwGCsnNszoDxSHUrHfUZZvw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D8C83129C02114DBC0E8C2230E9AD72@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iEXLRKqI8xeIGQ8vb3vnVFx9r3CQQFbdXncAzIt7utasENuQmv/wAJQ6OZa4OwfnL8Wo+WO//3J/+vnanSFuUX9HX43jldDDqN6xjfcgVHFQ6I6a7tFQZ0iMRzAUpGQMvuPT/M6spqIeyfQ/I7wGXT4cHeg3K1S3xgydynXL0LpKZHuZyfU06QPRgYcTLgmaI0Xj9jO7Jr6CW86aCYtyac3uYpZg0LyK4OTn6owLSgsRIWkOaWTpzwxlkLiqfWakLqwvdiYRAfExBy3oOsWyLsWGvk3CivUrKeptS/mgIiLbN2JyfmYrIPpTQ3cimeIwDO4BrERsqStNLS2B+4UMYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sQzyExFvoMSF1Uoo8MLw+QSEue44sl805S1rV56rGQbxyApofwEtvSGahhb+CJXB7mao+vGheE5UG0TEftoDaPKdZR3Pl/dLXqyX0fOAj21YsodLCqFd7P6n7klDrB/HVlfv75I/AT14RsVF8Y6eTQtIW9DV9nyLbmYbF6dTCCaCbY9ZWOUcJF23qME34YzdAUCJH0BlgAHRk1ro0L4Di4FRf6vzcat/1PdTJ9Y53iSV5AcmuhHCJl9jceyXVr/88Xd2hF8eclcxDTgqytbNGxNnAv+YUzt397lclorBUtjoUnH46cvOVKoP7MBDW8SGRhhATBGO3KboKvfYtnfuwxJt7rxIzfcBoLsHEZTPGegmHw7vNeaSKqE8tjqy5rQJchDbeks2TYMXRcrg0g60P20SZZzMTJXPa3H/M2HVJKOxmiRl6H8DDNZUSfxoDIa7gEHquSYzyU+umMYk9hErghQ1aJsZcRllbEMaDD2agdcsbYw2efL78RZnOq4JVl/2IsSH5TViHsEXuy58O9sFgg/2OQCMLRYvbseNBMmXbpLVuAU9rW/8bbtqX/Wc5WmEHiROgwcHYmdSfXEVi3GXeaDRjCoJf/JrSzINDc0D5e6DqsuRfDr+NUzgBLpjBNBJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84bca88-1bcb-414c-3f48-08df490d2b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:55:01.4824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeigESQLFswNlMXC270j/QPslkM2BNK3ErqtKkEKGo01PIUhdHG1/82PIzd9g0KGn+oiWFa2B1KBZeIUIj7qRv/XnHDaopKOpOKkj7jqXMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9764
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTEzIGF0IDE4OjU1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gUHJpdiBzcGVjIHNheXMgaW4gdGhlIFBoeXNpY2FsIE1lbW9yeSBQcm90ZWN0
aW9uIENTUnMgc2VjdGlvbiwgdy5yLnQNCj4gdGhlDQo+IFBNUCBjb25maWd1cmF0aW9uIHJlZ2lz
dGVyOg0KPiANCj4gIlRoZSBSLCBXLCBhbmQgWCBmaWVsZHMgZm9ybSBhIGNvbGxlY3RpdmUgV0FS
TCBmaWVsZCBmb3Igd2hpY2ggdGhlDQo+IGNvbWJpbmF0aW9ucyB3aXRoIFI9MCBhbmQgVz0xIGFy
ZSByZXNlcnZlZC4iDQo+IA0KPiBTbWVwbXAgY2hhbmdlZCB0aGUgbG9naWMgYSBiaXQ6IHRoaXMg
Yml0IGNvbWJvIGlzIG5vdyByZXNlcnZlZCBpZg0KPiB0aGVyZQ0KPiBpcyBubyBzbWVwbXAgb3Ig
aWYgbXNlY2NmZy5NTUwgaXMgY2xlYXJlZC4NCj4gDQo+IEFkZCB0aGlzIGNoZWNrIGluIHBtcF9p
c19pbnZhbGlkX3NtZXBtcF9jZmcoKS4NCj4gDQo+IEZpeGVzOiAxOWNmMWE3ZDllNTkgKCJ0YXJn
ZXQvcmlzY3Y6IHBtcDogZml4IGNoZWNrcyBvbiB3cml0ZXMgdG8NCj4gcG1wY2ZnIGluIFNtZXBt
cCBNTUwgbW9kZSIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS93b3JrX2l0ZW1zLzQ4MjANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVl
IEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0
YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0
L3N5c3RlbS9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrDQo+IMKgdGVzdHMvdGNn
L3Jpc2N2NjQvdGVzdC1wbXBjZmctcnctcmVzZXJ2ZWQuUyB8IDk2DQo+ICsrKysrKysrKysrKysr
KysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKykNCj4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1wbXBjZmctcnctcmVzZXJ2ZWQu
Uw0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMgYi90YXJnZXQvcmlz
Y3YvdGNnL3BtcC5jDQo+IGluZGV4IDA0ZGY1M2MyMzQuLjAyMWVjOTc4YjUgMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAu
Yw0KPiBAQCAtNzcsNiArNzcsMTQgQEAgc3RhdGljIGludCBwbXBfaXNfcmVhZG9ubHkoQ1BVUklT
Q1ZTdGF0ZSAqZW52LA0KPiB1aW50MzJfdCBwbXBfaW5kZXgpDQo+IMKgICovDQo+IMKgc3RhdGlj
IGludCBwbXBfaXNfaW52YWxpZF9zbWVwbXBfY2ZnKENQVVJJU0NWU3RhdGUgKmVudiwgdWludDhf
dA0KPiB2YWwpDQo+IMKgew0KPiArwqDCoMKgIGJvb2wgcl93X2JpdHNfcmVzZXJ2ZWQgPSAhcmlz
Y3ZfY3B1X2NmZyhlbnYpLT5leHRfc21lcG1wDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8fCAhTVNFQ0NGR19NTUxfSVNTRVQoZW52
KTsNCj4gKw0KPiArwqDCoMKgIGlmIChyX3dfYml0c19yZXNlcnZlZA0KPiArwqDCoMKgwqDCoMKg
wqAgJiYgKHZhbCAmIChQTVBfV1JJVEUgfCBQTVBfUkVBRCkpID09IDBiMTApIHsNCj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiAxOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCAvKiBObyBj
aGVjayBpZiBtc2VjY2ZnLk1NTCBpcyBub3Qgc2V0IG9yIGlmIG1zZWNjZmcuUkxCIGlzIHNldA0K
PiAqLw0KPiDCoMKgwqDCoCBpZiAoIU1TRUNDRkdfTU1MX0lTU0VUKGVudikgfHwgTVNFQ0NGR19S
TEJfSVNTRVQoZW52KSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGIvdGVzdHMvdGNn
L3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGluZGV4IDNjOGIwMThkOWUuLjRiOTA1YTA3
NzQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0K
PiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gQEAgLTg5LDYg
Kzg5LDEzIEBAIHRlc3RzICs9IHsNCj4gwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiArdGVzdHMgKz0g
ew0KPiArwqAgJ3Rlc3QtcG1wY2ZnLXJ3LXJlc2VydmVkLlMnOiB7DQo+ICvCoMKgwqAgJ2NmbGFn
cyc6IGNmbGFncywNCj4gK8KgwqDCoCAncWVtdV9hcmdzJzogWyctY3B1JywgJ21heCcsIHFlbXVf
YXJnc10sDQo+ICvCoCB9DQo+ICt9DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0ZW0tcmlzY3Y2NCcg
aW4gZW11bGF0b3JzDQo+IMKgwqAgdGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKgwqAgJ3Jpc2N2NjQt
c29mdG1tdSc6IHsNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtcG1wY2Zn
LXJ3LXJlc2VydmVkLlMNCj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXBtcGNmZy1ydy1yZXNl
cnZlZC5TDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjk0YTBk
NmYwMmYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXBt
cGNmZy1ydy1yZXNlcnZlZC5TDQo+IEBAIC0wLDAgKzEsOTYgQEANCj4gKy8qDQo+ICsgKiBUZXN0
IHJlc2VydmVkIHBtcGNmZyBiaXRzIFIgYW5kIFcuwqAgQ29kZSBkZXJpdmVkIGZyb20NCj4gKyAq
IHRoZSBHaXRsYWIgNDgyMCB0ZXN0Y2FzZS4NCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIFF1
YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzDQo+IHN1YnNpZGlhcmllcy4NCj4g
KyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsgKi8NCj4g
Kw0KPiArLm9wdGlvbiBub3J2Yw0KPiArCS50ZXh0DQo+ICsJLmdsb2JhbCBfc3RhcnQNCj4gKw0K
PiArX3N0YXJ0Og0KPiArCWxsYQl0MCwgdHJhcA0KPiArCWNzcncJbXR2ZWMsIHQwDQo+ICsNCj4g
KwkvKg0KPiArCSAqIFdyaXRlIDB4MiAoUj0wLCBXPTEpIGluIHBtcDdjZmcgKGxhc3QgYnl0ZSBv
ZiBwbXBjZmcwLA0KPiArCSAqIGkuZS4gYSA1NiBzaGlmdCkuwqAgU3RvcmUgdGhlIHJlc3VsdCBp
biBzMC4NCj4gKwkgKi8NCj4gKwlsaQl0MCwgMHhmZg0KPiArCXNsbGkJdDAsIHQwLCA1Ng0KPiAr
CWNzcmMJcG1wY2ZnMCwgdDANCj4gKwlsaQl0MCwgMHgwMg0KPiArCXNsbGkJdDAsIHQwLCA1Ng0K
PiArCWNzcnMJcG1wY2ZnMCwgdDAJLy8gcG1wN2NmZyA9IDB4MDINCj4gKwljc3JyCXMwLCBwbXBj
ZmcwDQo+ICsNCj4gKwkvKg0KPiArCSAqIExpa2V3aXNlLCBub3cgd3JpdGluZyAweDYgKFI9MCwg
Vz0xLCBYPTEpIGluIHBtcDdjZmcgYW5kDQo+ICsJICogc3RvcmluZyB0aGUgcmVzdWx0IGluIHMx
Lg0KPiArCSAqLw0KPiArCWxpCXQwLCAweGZmDQo+ICsJc2xsaQl0MCwgdDAsIDU2DQo+ICsJY3Ny
YwlwbXBjZmcwLCB0MA0KPiArCWxpCXQwLCAweDA2DQo+ICsJc2xsaQl0MCwgdDAsIDU2DQo+ICsJ
Y3NycwlwbXBjZmcwLCB0MAkvLyBwbXA3Y2ZnID0gMHgwNg0KPiArCWNzcnIJczEsIHBtcGNmZzAN
Cj4gKw0KPiArCWxpCXQwLCAweGZmDQo+ICsJc2xsaQl0MCwgdDAsIDU2DQo+ICsJY3NyYwlwbXBj
ZmcwLCB0MA0KPiArDQo+ICsJLyoNCj4gKwkgKiByc2hpZnQgczAgdG8gZ2V0IHRvIHBtcDdjZmcg
YW5kIGNvbXBhcmUgdGhlIGZpcnN0IDINCj4gKwkgKiBiaXRzIChSIGFuZCBXKSB3aXRoIDB4Mi7C
oCBUaGV5IG11c3QgYmUgY2xlYXIuDQo+ICsJICovDQo+ICsJc3JsaSB0MSwgczAsIDU2DQo+ICsJ
YW5kaSB0MSwgdDEsIDMNCj4gKwlsacKgwqAgdDIsIDINCj4gKwliZXHCoCB0MSwgdDIsIF9mYWls
DQo+ICsNCj4gKwkvKiBEbyB0aGUgc2FtZSB3aXRoIHMxIC0gUiBhbmQgVyBzaG91bGQgYmUgY2xl
YXIuwqAgKi8NCj4gKwlzcmxpIHQxLCBzMSwgNTYNCj4gKwlhbmRpIHQxLCB0MSwgMw0KPiArCWJl
ccKgIHQxLCB0MiwgX2ZhaWwNCj4gKw0KPiArCWxpCWEwLCAwDQo+ICsJaglfZXhpdA0KPiArDQo+
ICtfZmFpbDoNCj4gKwlsaQlhMCwgMQ0KPiArCWoJX2V4aXQNCj4gKw0KPiArdHJhcDoNCj4gKwkj
IEFueSB0cmFwIGlzIGEgZmFpbCBjb2RlIDENCj4gKwlsaQlhMCwgMQ0KPiArDQo+ICsjIEV4aXQg
Y29kZSBpbiBhMA0KPiArX2V4aXQ6DQo+ICsJbGxhCWExLCBzZW1pYXJncw0KPiArCWxpCXQwLCAw
eDIwMDI2CSMgQURQX1N0b3BwZWRfQXBwbGljYXRpb25FeGl0DQo+ICsJc2QJdDAsIDAoYTEpDQo+
ICsJc2QJYTAsIDgoYTEpDQo+ICsJbGkJYTAsIDB4MjAJIyBUQVJHRVRfU1lTX0VYSVRfRVhURU5E
RUQNCj4gKw0KPiArCSMgU2VtaWhvc3RpbmcgY2FsbCBzZXF1ZW5jZQ0KPiArCS5iYWxpZ24JMTYN
Cj4gKwlzbGxpCXplcm8sIHplcm8sIDB4MWYNCj4gKwllYnJlYWsNCj4gKwlzcmFpCXplcm8sIHpl
cm8sIDB4Nw0KPiArCWoJLg0KPiArDQo+ICsJLmRhdGENCj4gKw0KPiArCS5iYWxpZ24JNjQNCj4g
K2Nib19zdGVwOg0KPiArCS53b3JkIDANCj4gK2J1ZmZlcjoNCj4gKwkuZmlsbCA2NCwgMSwgMHhh
NQ0KPiArDQo+ICsJLmJhbGlnbgkxNg0KPiArc2VtaWFyZ3M6DQo+ICsJLnNwYWNlCTE2DQo+ICsN
Cg==

