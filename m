Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDA0C2A077
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 08:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcgLo-0007NY-M6; Mon, 05 Jan 2026 03:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcgLg-0007Mx-ER; Mon, 05 Jan 2026 03:54:00 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcgLe-0000K1-HH; Mon, 05 Jan 2026 03:54:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJa1zoLdpYBlMftn4UY16lxo7vqw5QCyq2deKNT8y3hMSc0Kq1GX7hhJaDiSbupQ+Bem+Jy5Pp2xecovK77D0tQ/VX2ET/Jwe9aUABJea4rf3uW7s7POkExaiSWuTc6gTZhclCsy2iFOWfnLxmC/DFGlpDfHeBp1e0VNZPsL2wQt4VLvGqo6dwKqaGQ6zwKkZgF6TdX+TvtHl5lEzv8wDEM7c8sc7tfMDuV9Kmu2VK20ilXxdUUh9MuCJjCETb8JoqM4mNJ5TZuehGUDcuwe1GKDLO62Fs176Jk1tYTfqnqSf1ceIcyyFBv4GKRlSfmCyLkGoRpx8LcSFKoFBiPZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO7iwFxUXykCwKBq/zFTjlQD9X9WzkBO/HybxIdY/0c=;
 b=KvxEOw0ymJrK75CkoaxV5xAUUEWWfOCjRalH2M3Q7Y9Tq4AbvOzQuUhFGMDpmKNRtqBCk4BjIO55zhVYGMLUYluZZwLNJcRy+jGh2v9SXWkvfWcOI6wkbhnQf85+Pz6XVRftmIFVXUUofFNe24VKjja1Tf8MFuWHNbnyWkbI+A7xKmQD4hmFOZpf40DQIGEPgCEvzGueCI/5XSE+GYQezIBtIZiYB/xOb4BxkbticMYuQ1/ihQKQ/9ElDogd8t2TB+MSajwrJhm86LKr1+/yqg3Yfe6yCs/PpVaq0SlTeHC/LkuVVOD++xRT43vNJipxeAHoLsPwJfo2ulyaOeTF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO7iwFxUXykCwKBq/zFTjlQD9X9WzkBO/HybxIdY/0c=;
 b=mHq558hz0xfb85yRiHjQQWmI27sIdQF6ef/Un+SOEsW+qyoOAxYnk0RtOqeJW/RXGs6cpgeS+ST6XhVyiN2QckuqBimFdDlR84cWiwTxIesRbc+BKNOtKjOti465zCJ2vmhnqlhFkfBMF3fWqpojT1CvcZMmGnZG1Wut25T5obqGO9YGyTJxxdfUYkfOkyNECNEEYKB1ECl3ZMFK71WQmQJkTOpC42eTY4GTJEdQyZv5D0ymNGoo9KMjkDkx3kvIMM3HTF7XVHGm6b1xVUDexP4XltEU34PxyzxRi+O6DWRvJcKWCEp4IHn47875d+FeVhsTwzn2l4I/YvaGxtc7eA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF1C65AA8C1.apcprd06.prod.outlook.com (2603:1096:408::787)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:53:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:53:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 00/19] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH 00/19] i3c: aspeed: Add I3C support
Thread-Index: AQHb2/a2CcL7KROFtkqdhplaCpqsBbVEhicggAADV4A=
Date: Mon, 5 Jan 2026 08:53:53 +0000
Message-ID: <TYPPR06MB8206AF1C575D00CE50F879EEFC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <TYPPR06MB8206E110D0A959596D8E9DC0FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB8206E110D0A959596D8E9DC0FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF1C65AA8C1:EE_
x-ms-office365-filtering-correlation-id: a1d44e19-57c9-456f-bf1c-08de4c37f45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NU8vK1FFMXRLeFVCcjg4ekdaMmFSYzRDMlZrbkFZZWZ5Z1pFYUI3WHh6ZW1Z?=
 =?utf-8?B?ZUdlaU4wVm1JS01VNzR4RmlicFI1Sk5wNlcyc081QVhieCticGdPc2FTcUps?=
 =?utf-8?B?WWdXRE5JdTN0UVkxK3lKalJJUlBwQ3RiR3FBdTJGb3lIaVlmYzlMdWtlVWhW?=
 =?utf-8?B?ODIyNUY4cVg4eWZhdCsyaDhHYnZLRjdPM3IzQzg1ZTliZ203cUtwYWdndmND?=
 =?utf-8?B?djhSMnNsNTRtcWZCMDkwbU1VMG5FVnNuZXVlK3Jjei9OM1psdExCeGgvaEZC?=
 =?utf-8?B?NFVQQi8vdXBpaVU4SXpPNmdVOHE3RXBWWUFVNUVGZTcvVnBGVTd1ZHgwLzZs?=
 =?utf-8?B?UWM0bkdXK0hETFZqWitKcEpTVklmYkVjYXZGMEhxQnA3RjZjTHA4UTBvNDF3?=
 =?utf-8?B?b2MrV3FubGlRK1I0K0pIZjEzbFpQRmJUTjBnZTFhdm8yRlR5c1doS1FnSFp1?=
 =?utf-8?B?SVl0N1h3NGdqWFBSZCs4T1hOZFlBclFiSVJhTm9IYmhJellnRjNOclpIczg3?=
 =?utf-8?B?ZXV2MFRkYkphL3VURkUvdStYMXkyNzMxMThiVm91TDFKMS9rUG45elFpUUNl?=
 =?utf-8?B?ZFowcGQ4VXZuTVRhMFIwZ0JwRm5oenYvajc2QlA2U0w1OFRQc2FReXp0VExh?=
 =?utf-8?B?YitwMjJjbTdIdWRPbDl3S3VZd1M1TnhUeDlmbFpmM1ZERzRqaVJ2d1c4VEp3?=
 =?utf-8?B?SEl6bitoNHdCRHlxeUQ0dmt2QlNWaFNKUE5JaS91UW0vRFRLVkxiMDZQNEZU?=
 =?utf-8?B?WHh6Tk9oV21mdU1jeHFCdW5MalZDWUNURFVUMjRYVFRGejZxcUt6Zi81WFds?=
 =?utf-8?B?L1pPbTNoejRhMk9XaDNnelpTOHpleWNUV0p3V2RxN0JFUjJLRlk2aEdhR2Q1?=
 =?utf-8?B?MU1sN2NDTkwya0JadFQwcDJ1eEVaVDJwTGZOd2NmZDRRZ3FSREdOR3NPdkhn?=
 =?utf-8?B?NlJKTDZldGJjc3QrM2IrR0VsMTNvaVN5d0QyOFNPdFAvdmV2S2tPbjU2VmI5?=
 =?utf-8?B?WjBSa3F3MlhrK1doU1RnRHdzdmI3M0RVaEczQ3VGclRhRkpmS21yOGNvSGox?=
 =?utf-8?B?VXVNZkFvL1ZEZ1hNMldnekhIZ0Q3Ni8yTE1HendqUVJIVkNJWTl3ellPSWFT?=
 =?utf-8?B?VjRYZm5NRlFrOUVOTjRISWJYdG1rZVNEelZwMEhxTktqcXl5c3Q2dUV6M3NI?=
 =?utf-8?B?RU1ud3lWNEE2eURzdVhUQ3JkUWFBUlRZV05vN2hnRTBTQ08zc1NIVmF6bGVj?=
 =?utf-8?B?Vlh6OTFwQ1ZRQnJsdHFLaCttR3QyTGg1Y2hjVUwvRUhOQjdrdS9DTXI3b2hT?=
 =?utf-8?B?RVhZL25xZW9oY0I4eHh1SmVBTWpUeU5kaHg0OXo3eW9lb096U3dMSTFqZHNC?=
 =?utf-8?B?Y2xvbXZvbjhkTTd3ZVNXMTF4WnJHWXNhZE4wOWRvZENndHM3d1Y4eVM2UVZZ?=
 =?utf-8?B?TnF1bk40TWxkYUx4QU9wR2JXYmpnN1E3SDBrQytpYW1nY05panRSUXRwK0c3?=
 =?utf-8?B?am9OUFFBZDRySnoxa1RsU1d4UjVVTU40YkN6OStwNXVvMXpQWDBKOEpkZnF3?=
 =?utf-8?B?L1UvWE9ickx3VWtNQVB1d09henMrU0xqQmp1ZTBJYkFVMmVoNG9FL1c2R3kw?=
 =?utf-8?B?RkVxYXdWT3pqN0lLL1hKaTY5eFN3QjJmNmJEcGJ1V0h6NzhLemJkWGMvTmV5?=
 =?utf-8?B?OGFrZnMwNGlBWmZwUy9WaTRHNW5uVm5vT2RsOGdYWUR6NDBvcUxISVk5NnBF?=
 =?utf-8?B?RW5hNHJoSjdGcktRQmVvVGYwMzRHWmtUcFB0TUZvc0VUUUREN28vdHoyaEtF?=
 =?utf-8?B?UmZVVDZwSCthMExOL05hTVBrNHV5Y3NxYVVzSHFCSkNCcC92c0FSQlAySGVy?=
 =?utf-8?B?VWIwa2lNcVlSN3B2UU1obkwrQnZiWnQyZVdmYkJsUXVnTk56Q0NJWXBhQzR6?=
 =?utf-8?B?NGh5ekh6L0Jnak9qdlF0Kzh6N1pielZhMUxKeDBSWWlud0grSzUrWHlIRzAz?=
 =?utf-8?B?a09CNnlveEZabGtOcGNmYkVqWEhHQ1hFOS9zNTVNSXBoUFRBV2FlUnQvbVYw?=
 =?utf-8?Q?tYKrpE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEJtSVEwVDJwQStZMEFSaVppMjBtOFBUYy9wSzFFYnFxTVBJS21rWk8ycCtl?=
 =?utf-8?B?dTRiZjh4UjlLS1hiTzREazRjd25mOGdyekZxY3Bad0NWQXZkVWZxc3RaS3Nj?=
 =?utf-8?B?dEpVRUsxa1BuYjhBWkRxcXZUbFd0elIrb001WGRJbWs5THhqQ2VUMmhSTG9m?=
 =?utf-8?B?alpCWUt3SHlzSzZ6RllDekdRUk51cG5xM2MzNkpkd1FuSk1lQlpNMGl2NlBi?=
 =?utf-8?B?OXd5RThtckRYUUd5c1pWV0IyeHVIZFk0NnRPY1RGMll1M0l6Sll4OThGOVFF?=
 =?utf-8?B?cGhxNGk3aVQ4ekM5MzNET3VRdWl2Z3NiUTAzN21VMnVjbDdYeTdRVndvMkZo?=
 =?utf-8?B?U3hXSU5NR1FBbENjbUNaK0JiTlFQWWdhSDVBaHZBMndEMTZWR1lWZWw5Mndl?=
 =?utf-8?B?WTlOMVV2eHBhY3FxUkZwT1RqMXVOOE9GUnZHTEFqbEdINk14cTEwcnVMRlBJ?=
 =?utf-8?B?NlZHNnlHVnNWMzU3cUFhZU9yQkRsQ1gyOTNtUk5VUjl6cDJMalRHMEVZUWJz?=
 =?utf-8?B?KzlWMndiWHBsbkNvTEQxdHl5aytFSmJaWEdxRzdBZFFYV1RKWVV4dU1QZy8v?=
 =?utf-8?B?ZDRUdE9ScGlTWnowSlk4N0lHQlBtZWk5aUozaWhIbXpTZGtzSjJsaWkyMFl5?=
 =?utf-8?B?MDVmdVhZZkhYYy9HUlZJbWM1V3ExV05kbkVjWEtTdUJDakZFUEpXQnYvaFFY?=
 =?utf-8?B?M21kWC9EU09jUFd4VDRyWFNPOGF2Q1hDUTBJVk1QZTN3VmdjdHZmMjVUaFND?=
 =?utf-8?B?SWRmM2x3UGxlOU5Ea1RXNGJuUDk0cHNxdTFmaVZiOEpnbGs0dGZJOGx0L0RV?=
 =?utf-8?B?a0ZMT0MrZEVmRTUra3ZlL2Z4QXJ0VXEyVkt5L0NKWDhDa05xNWltK1JFR1Q2?=
 =?utf-8?B?NWVjeVRaRXRwOE1HYjJCMGRKd1BWZ2ZqQmNCb0p3M0oyWXkvaDZFZTFwWlJT?=
 =?utf-8?B?a2J6UVE0SDBSU3lMTUlvNWJNR24yYWs2bnRDNDIxYWRPTEdoUHVxN1R1QVdZ?=
 =?utf-8?B?L0d0UGlMTXJqSWZKM3l5V1A1MEYyNFIxN2VzdVBHT2pDanJIMVFKbnVBS1Q3?=
 =?utf-8?B?Q3g0UTBpTGVoakxIR1BVaS9XcDVrbHQyeGc2cjZKR0dLMlFZaHdtVGlmbmhE?=
 =?utf-8?B?Ums2cWV4NlF2c012NVFVRHZ4VWVuSVU5eVN4SXhjblRqcnhzQUJQVmNJNmdk?=
 =?utf-8?B?bjVhd1VRZCtSa2RNUDJDZkdtZ1BrS0VPV1p1NjRZTm9OYnhwWWNSSWExdjNW?=
 =?utf-8?B?TDUxQVl5eHJ5VW55eFdNY0paTVd3ZDRjbFRZbllDT1dGalU0UE1EM0V4UTB6?=
 =?utf-8?B?aUxoZUlUU0RVV1NUOFdwMy94NXRwSFdsa1VTaWpiZFFTcjVSY1B4MEVNV1Zt?=
 =?utf-8?B?YzBUdTlJWDc0Z2JFVHlpY2g3VUdidGNvNXVUQ3A4M2ExdHEydTU2VENCU1c4?=
 =?utf-8?B?UVQ0YklQeFQ4RWJzNm1LQ0xYelBza0VSSm54a1FicmxCdlY3bnIxcjVFQW40?=
 =?utf-8?B?Z0FJdGtRYURUUjZlZ0hXTU5ocysvVzdLTVFpQkZHdmkrdGRCVmZiV3ByMlhL?=
 =?utf-8?B?YWVnQ1dSektIdVZISSsxWVp6VThQYWRrQm14dFE4Q3JOMHhaQXloQmFDTStO?=
 =?utf-8?B?amwyMHo1NWljZWN6VE55bjE3WEJYYmpjeWZwUmFsY1IxNW92WmhNSUpiNmVX?=
 =?utf-8?B?MzQ2UnNSajVOc0d3WjdWYXlJQldESGlLQ3Z0T2RMaWpUZTcxWDhDZzEwSjk2?=
 =?utf-8?B?Z0s1RVJESlBuNFFEQmZLQ1hsNzBPNWNZUFVGdzdxYkd3UHNncVBMVzM1ZWFo?=
 =?utf-8?B?ZWFqNWszbVpadW5TSE9ZbDcyeVZocXNMZE04NUM2SkpzN0U3angzLzUzcmI4?=
 =?utf-8?B?MDh2ZjR1NlN2WVlmWEwrdmtKaExNTE1jOGljcTVnT3VNU0hqMXppeTFKRHZQ?=
 =?utf-8?B?MlNNeFA1bUFKYURqY3FTZmplMTlUR1dwcTA0a3UwUVovRFI4OUF2a2MwMng1?=
 =?utf-8?B?SmhlWFhBazNLdmZGWUNRbVRuZkcxNDJHdWN6VitMYUNwUHZkUUdqV2U2WFRq?=
 =?utf-8?B?eElOaU1jOXdoMTVOeW93S2ZNTjZ2S0lMTEpja2JHdVBhRjlpdTlZMzZtcTZX?=
 =?utf-8?B?QVpnR0JaU3hNVUdRSEFETzZVWE9iZzE2OHE4OWNjVkpwYnVtcm9YMnNhcUdz?=
 =?utf-8?B?OVptVzdMTGdqZFd4dEhxNk1EOG5teUlhQno1T3BtVEVxNGgxNEc5ajZrNjNN?=
 =?utf-8?B?ZnlJZlpiYk5zME1QalFxQXdDdFRYeUwxTGZMOGFSWEFKUnBCQjZDZC9mbnJF?=
 =?utf-8?B?blVKRkQybkdVbzFSSEM1RGRGWjRkTVRPdkVLWmZkT0RrU3JNWXB1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d44e19-57c9-456f-bf1c-08de4c37f45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 08:53:53.9567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqfEPHKGZHgoMdz1bBPchNKR+riYZPkuy2stEGjzZBg7ZDq8GjfEUwklmiiSpU0cVwLU+BFE0+H3BmmhNsxRyuULfKhWuyZftfxa7u5RbSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1C65AA8C1
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

PiBTdWJqZWN0OiBSRTogW1BBVENIIDAwLzE5XSBpM2M6IGFzcGVlZDogQWRkIEkzQyBzdXBwb3J0
DQo+IA0KPiBIaSBKb2UsDQo+IA0KPiA+IFN1YmplY3Q6IFtQQVRDSCAwMC8xOV0gaTNjOiBhc3Bl
ZWQ6IEFkZCBJM0Mgc3VwcG9ydA0KPiA+DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gVGhpcyBzZXJp
ZXMgYWRkcyBJM0MgYnVzIHN1cHBvcnQgdG8gUUVNVSBhbmQgYWRkcyBtb3JlIGZ1bmN0aW9uYWxp
dHkNCj4gPiB0byB0aGUgQXNwZWVkIEkzQyBjb250cm9sbGVyLg0KPiA+DQo+ID4gVGhpcyBpbXBs
ZW1lbnRhdGlvbiBpcyBhIGJhc2ljIGltcGxlbWVudGF0aW9uIHRoYXQgaW50cm9kdWNlcyBJQklz
DQo+ID4gKGluY2x1ZGluZyBob3Qtam9pbiksIENDQ3MsIGFuZCBTRFIgZGF0YSB0cmFuc2Zlci4g
QXMtaXMsIGl0IGRvZXNuJ3QNCj4gPiBzdXBwb3J0IG11bHRpLWNvbnRyb2xsZXIgYnVzZXMgb3Ig
SERSIHRyYW5zZmVycy4NCj4gPg0KPiA+IEZpcnN0IHdlIGFkZCB0aGUgSTNDIGJ1cyBhbmQgY29u
dHJvbGxlciBtb2RlbC4gV2l0aCB0aGF0IGFkZGVkIHdlDQo+ID4gZXh0ZW5kIHRoZSBmdW5jdGlv
bmFsaXR5IG9mIHRoZSBBc3BlZWQgSTNDIGNvbnRyb2xsZXIgc28gaXQgY2FuIGRvIHRyYW5zZmVy
cw0KPiBhbmQgaGFuZGxlIElCSXMuDQo+ID4NCj4gPiBOZXh0LCB3ZSBhZGQgYSBtb2NrIEkzQyB0
YXJnZXQuIEl0J3MgaW50ZW5kZWQgdG8gYmUgYSB2ZXJ5IHNpbXBsZQ0KPiA+IHRhcmdldCBqdXN0
IHRvIHZlcmlmeSB0aGF0IEkzQyBpcyB3b3JraW5nIG9uIHRoZSBndWVzdC4gSW50ZXJuYWxseSwN
Cj4gPiB3ZSd2ZSB1c2VkIGl0IG9uIExpbnV4IHRvIHZlcmlmeSB0aGF0IGkzQyBkZXZpY2VzIGNh
biBiZSBwcm9iZWQgYW5kIGNhbg0KPiBzZW5kL3JlY2VpdmUgZGF0YSBhbmQgSUJJcy4NCj4gPiBU
aGlzIHRhcmdldCBpcyBzb3J0IG9mIGxpa2UgYW4gRUVQUk9NLCBhbmQgaXQgY2FuIGFsc28gc2Vu
ZCBJQklzIHVwb24NCj4gPiByZWNlcHRpb24gb2YgYSB1c2VyLWRlZmluZWQgbWFnaWMgbnVtYmVy
Lg0KPiA+DQo+ID4gTGFzdGx5IHdlIGFkZCAgaG90cGx1Z2dpbmcgc3VwcG9ydC4gVGhlIGhvdHBs
dWdnaW5nIGRvZXNuJ3QgZG8NCj4gPiBhbnl0aGluZyB0b28gY29tcGxpY2F0ZWQsIGl0IGp1c3Qg
YWRkcyB0aGUgZGV2aWNlIGF0dGVtcHRpbmcgdG8NCj4gPiBob3RwbHVnIHRvIHRoZSBidXMuIEl0
IGlzIHRoZSBkZXZpY2UncyByZXNwb25zaWJpbGl0eSB0byBob3Qtam9pbiBhbmQNCj4gPiBnbyB0
aHJvdWdoIHRoZSBEQUEgcHJvY2VzcyB0byBwYXJ0aWNpcGF0ZSBvbiB0aGUgYnVzLg0KPiA+DQo+
ID4gVGhhbmtzLA0KPiA+IEpvZQ0KPiA+DQo+ID4gSm9lIEtvbWxvZGkgKDE5KToNCj4gPiAgIGh3
L21pc2MvYXNwZWVkX2kzYzogTW92ZSB0byBpM2MgZGlyZWN0b3J5DQo+ID4gICBody9pM2M6IEFk
ZCBidXMgc3VwcG9ydA0KPiA+ICAgaHcvaTNjOiBTcGxpdCBEZXNpZ25XYXJlIEkzQyBvdXQgb2Yg
QXNwZWVkIEkzQw0KPiA+ICAgaHcvaTNjL2R3LWkzYzogQWRkIG1vcmUgcmVnaXN0ZXIgZmllbGRz
DQo+ID4gICBody9pM2MvYXNwZWVkX2kzYzogQWRkIG1vcmUgcmVnaXN0ZXIgZmllbGRzDQo+ID4g
ICBody9pM2MvZHctaTNjOiBBZGQgbW9yZSByZXNldCB2YWx1ZXMNCj4gPiAgIGh3L2kzYy9hc3Bl
ZWRfaTNjOiBBZGQgcmVnaXN0ZXIgUk8gZmllbGQgbWFza3MNCj4gPiAgIGh3L2kzYy9kdy1pM2M6
IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+ICAgaHcvaTNjL2R3LWkzYzogVHJlYXQg
bW9yZSByZWdpc3RlcnMgYXMgcmVhZC1hcy16ZXJvDQo+ID4gICBody9pM2MvZHctaTNjOiBVc2Ug
MzIgYml0cyBvbiBNTUlPIHdyaXRlcw0KPiA+ICAgaHcvaTNjL2R3LWkzYzogQWRkIElSUSBNTUlP
IGJlaGF2aW9yDQo+ID4gICBody9pM2MvZHctaTNjOiBBZGQgZGF0YSBUWCBhbmQgUlgNCj4gPiAg
IGh3L2kzYy9kdy1pM2M6IEFkZCBJQkkgaGFuZGxpbmcNCj4gPiAgIGh3L2kzYy9kdy1pM2M6IEFk
ZCBjdHJsIE1NSU8gaGFuZGxpbmcNCj4gPiAgIGh3L2kzYy9kdy1pM2M6IEFkZCBjb250cm9sbGVy
IHJlc2V0cw0KPiA+ICAgaHcvaTNjL2FzcGVlZDogQWRkIEkzQyBidXMgZ2V0IGZ1bmN0aW9uDQo+
ID4gICBody9pM2M6IEFkZCBNb2NrIHRhcmdldA0KPiA+ICAgaHcvYXJtL2FzcGVlZDogQnVpbGQg
d2l0aCBJM0NfREVWSUNFUw0KPiA+ICAgaHcvaTNjOiBBZGQgaG90cGx1ZyBzdXBwb3J0DQo+ID4N
Cj4gPiAgaHcvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+
ICBody9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMyArDQo+ID4gIGh3
L2kzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE1ICsNCj4gPiAgaHcvaTNj
L2FzcGVlZF9pM2MuYyAgICAgICAgICAgICAgICAgICB8ICAyNjEgKysrKw0KPiA+ICBody9pM2Mv
Y29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDY2OSArKysrKysrKysNCj4gPiAgaHcv
aTNjL2R3LWkzYy5jICAgICAgICAgICAgICAgICAgICAgICB8IDE4ODENCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGh3L2kzYy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAg
ICAgfCAgICA2ICsNCj4gPiAgaHcvaTNjL21vY2staTNjLXRhcmdldC5jICAgICAgICAgICAgICB8
ICAzMTEgKysrKw0KPiA+ICBody9pM2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgIHwg
ICA0NyArDQo+ID4gIGh3L2kzYy90cmFjZS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAy
ICsNCj4gPiAgaHcvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0K
PiA+ICBody9taXNjL2FzcGVlZF9pM2MuYyAgICAgICAgICAgICAgICAgIHwgIDM4MyAtLS0tLQ0K
PiA+ICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgIHwgICAgMSAtDQo+ID4g
IGh3L21pc2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgfCAgICA2IC0NCj4gPiAgaW5j
bHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oICAgICAgICAgICB8ICAgIDIgKy0NCj4gPiAgaW5jbHVk
ZS9ody97bWlzYyA9PiBpM2N9L2FzcGVlZF9pM2MuaCB8ICAgMjIgKy0NCj4gPiAgaW5jbHVkZS9o
dy9pM2MvZHctaTNjLmggICAgICAgICAgICAgICB8ICAyMDEgKysrDQo+ID4gIGluY2x1ZGUvaHcv
aTNjL2kzYy5oICAgICAgICAgICAgICAgICAgfCAgMjc3ICsrKysNCj4gPiAgaW5jbHVkZS9ody9p
M2MvbW9jay1pM2MtdGFyZ2V0LmggICAgICB8ICAgNTIgKw0KPiA+ICBtZXNvbi5idWlsZCAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIDIwIGZpbGVzIGNoYW5nZWQsIDM3
MzUgaW5zZXJ0aW9ucygrKSwgNDA3IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2
NDQgaHcvaTNjL0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvYXNwZWVkX2kzYy5j
ICBjcmVhdGUNCj4gPiBtb2RlDQo+ID4gMTAwNjQ0IGh3L2kzYy9jb3JlLmMgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9pM2MvZHctaTNjLmMgIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGh3L2kzYy9t
ZXNvbi5idWlsZCAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9tb2NrLWkzYy10YXJnZXQuYw0K
PiA+IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvdHJhY2UtZXZlbnRzICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiBody9pM2MvdHJhY2UuaCAgZGVsZXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNw
ZWVkX2kzYy5jICByZW5hbWUNCj4gPiBpbmNsdWRlL2h3L3ttaXNjID0+IGkzY30vYXNwZWVkX2kz
Yy5oICg2MyUpICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBpbmNsdWRlL2h3L2kzYy9kdy1pM2Mu
aCAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaTNjL2kzYy5oDQo+ID4gY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaTNjL21vY2staTNjLXRhcmdldC5oDQo+ID4NCj4gPiAtLQ0K
PiA+IDIuNTAuMC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0LWdvb2cNCj4gDQo+IA0KPiBJIHRlc3RlZCB0
aGlzIHNlcmllcyBvbiBBU1QyNjAwLCBhbmQgdGhlIHJlc3VsdHMgYXJlIGFzIGZvbGxvd3M6DQo+
IA0KPiAxLiBRRU1VIGNvbW1hbmQgbGluZQ0KPiAgIEFkZCB0aGUgZm9sbG93aW5nIG9wdGlvbiB0
byB0aGUgUUVNVSBjb21tYW5kIGxpbmUNCj4gICAtZGV2aWNlIG1vY2staTNjLXRhcmdldCxidXM9
ZHcuaTNjLjUsYnVmLXNpemU9MjU2LGliaS1tYWdpYy1udW09MHg1YQ0KPiANCj4gMS4gRGV2aWNl
IGVudW1lcmF0aW9uDQo+ICAgQWZ0ZXIgYm9vdGluZyBpbnRvIExpbnV4LCB0aGUgbmV3IGRldmlj
ZSBhcHBlYXJzIG9uIEkzQyBidXMgNToNCj4gDQo+IHJvb3RAYXN0MjYwMC1kZWZhdWx0Oi9zeXMv
YnVzL2kzYy9kZXZpY2VzIyBscw0KPiAwLTRjYzMxMDIwMDAwICAwLTRjYzUxMTgwMDAwICAwLTRj
YzUxMTgxMDAwICAxLTRjYzMxMDIwMDAwDQo+IDEtNGNjNTExODAwMDAgIDEtNGNjNTExODEwMDAg
IDQtdGFyZ2V0ICAgICAgIDUtMCAgICAgICAgICAgIGkzYy0wDQo+IGkzYy0xICAgICAgICAgIGkz
Yy0yICAgICAgICAgIGkzYy0zICAgICAgICAgIGkzYy00ICAgICAgICAgIGkzYy01DQo+IA0KPiAx
LiBSRUFEL1dSSVRFIE1PQ0sgRUVQUk9NDQo+IEkgdmVyaWZpZWQgcHJpdmF0ZSB3cml0ZSBhbmQg
cmVhZCBvcGVyYXRpb25zIHVzaW5nIHRoZSBpM2NkZXYgaW50ZXJmYWNlDQo+IA0KPiByb290QGFz
dDI2MDAtZGVmYXVsdDovc3lzL2J1cy9pM2MvZGV2aWNlcy81LTAjIGRkIGlmPS90bXAvamFtaW4N
Cj4gb2Y9L2Rldi9pM2MtNS0wDQo+IDArMSByZWNvcmRzIGluDQo+IDArMSByZWNvcmRzIG91dA0K
PiAyMDAgYnl0ZXMgKDIwMEIpIGNvcGllZCwgMC4wMDIwMzIgc2Vjb25kcywgOTYuMUtCL3MNCj4g
DQo+IHJvb3RAYXN0MjYwMC1kZWZhdWx0Oi9zeXMvYnVzL2kzYy9kZXZpY2VzLzUtMCMgaGV4ZHVt
cCAvZGV2L2kzYy01LTANCj4gMDAwMDAwMCAwNGNiIDJkODQgMGQ4MCA0NWU2IDZjOWEgM2QyMyA5
Mzg0IGIzZWYNCj4gMDAwMDAxMCBmNTM0IDMzMjggNWUwNyBhYzk0IDVjZDYgMzkxNCA4NmFkIGUw
ODUNCj4gMDAwMDAyMCBlMDQ3IDgxZTMgYWY1MiBiYjg4IGYyMGMgYzI4MiA2MTQ4IDUzNzQNCj4g
MDAwMDAzMCA2YjdkIDU4YmYgZmIxYyAyMzgyIDEyMWYgMWE2MCBiZmI0IDFlYmQNCj4gMDAwMDA0
MCA4MDI4IDBhODIgNDc0MCA4Mjg3IDU3MzcgOTg4ZiA1OTdlIDlhNjcNCj4gMDAwMDA1MCBhN2Y3
IGIwYzggZGI4NyAyNjMxIDgzMDQgZGY4OSA2OTc3IDJhODINCj4gMDAwMDA2MCAxMmQ4IGZiNzMg
YmNjNyBlY2QwIGViYTIgNTc1ZiBhMDUwIDAyZmINCj4gMDAwMDA3MCBhZjRiIGZmZWYgZGE1YiA1
Y2IzIDE0YTMgNzA0NyAxN2FjIGQyMzgNCj4gMDAwMDA4MCBlZGE2IGFlM2UgYWM3MiA2MTEyIGJi
YmYgZmJjYSA4NDRkIDAzNWUNCj4gMDAwMDA5MCAwOTcwIGY1OTEgNzUzNiA4MzEyIDA1NTIgZDRm
ZCA4MTdiIGIzMjMNCj4gMDAwMDBhMCAzOThiIGU2MzMgZGY3NyA1OWVlIGZkNGUgNjkyMiBlNGE5
IGExNjANCj4gMDAwMDBiMCBkMjA2IDk2ZTEgYTkxNSA3ODJiIDFiNTMgYTliYyA3MGM2IDU2NzAN
Cj4gMDAwMDBjMCA2ZGZlIGEzZGUgY2ExZiBiZDBhDQo+IDAwMDAwYzgNCj4gDQo+IHJvb3RAYXN0
MjYwMC1kZWZhdWx0Oi9zeXMvYnVzL2kzYy9kZXZpY2VzLzUtMCMgaGV4ZHVtcCAvdG1wL2phbWlu
DQo+IDAwMDAwMDAgMDRjYiAyZDg0IDBkODAgNDVlNiA2YzlhIDNkMjMgOTM4NCBiM2VmDQo+IDAw
MDAwMTAgZjUzNCAzMzI4IDVlMDcgYWM5NCA1Y2Q2IDM5MTQgODZhZCBlMDg1DQo+IDAwMDAwMjAg
ZTA0NyA4MWUzIGFmNTIgYmI4OCBmMjBjIGMyODIgNjE0OCA1Mzc0DQo+IDAwMDAwMzAgNmI3ZCA1
OGJmIGZiMWMgMjM4MiAxMjFmIDFhNjAgYmZiNCAxZWJkDQo+IDAwMDAwNDAgODAyOCAwYTgyIDQ3
NDAgODI4NyA1NzM3IDk4OGYgNTk3ZSA5YTY3DQo+IDAwMDAwNTAgYTdmNyBiMGM4IGRiODcgMjYz
MSA4MzA0IGRmODkgNjk3NyAyYTgyDQo+IDAwMDAwNjAgMTJkOCBmYjczIGJjYzcgZWNkMCBlYmEy
IDU3NWYgYTA1MCAwMmZiDQo+IDAwMDAwNzAgYWY0YiBmZmVmIGRhNWIgNWNiMyAxNGEzIDcwNDcg
MTdhYyBkMjM4DQo+IDAwMDAwODAgZWRhNiBhZTNlIGFjNzIgNjExMiBiYmJmIGZiY2EgODQ0ZCAw
MzVlDQo+IDAwMDAwOTAgMDk3MCBmNTkxIDc1MzYgODMxMiAwNTUyIGQ0ZmQgODE3YiBiMzIzDQo+
IDAwMDAwYTAgMzk4YiBlNjMzIGRmNzcgNTllZSBmZDRlIDY5MjIgZTRhOSBhMTYwDQo+IDAwMDAw
YjAgZDIwNiA5NmUxIGE5MTUgNzgyYiAxYjUzIGE5YmMgNzBjNiA1NjcwDQo+IDAwMDAwYzAgNmRm
ZSBhM2RlIGNhMWYgYmQwYQ0KPiAwMDAwMGM4DQo+IA0KPiByb290QGFzdDI2MDAtZGVmYXVsdDov
c3lzL2J1cy9pM2MvZGV2aWNlcy81LTAjIGRkIGlmPS9kZXYvaTNjLTUtMCBicz0xDQo+IGNvdW50
PTIwMCAyPi9kZXYvbnVsbCB8IGNtcCAtIC90bXAvamFtaW4gJiYgZWNobyAiUEFTUyIgfHwgZWNo
byAiRkFJTCINCj4gUEFTUw0KPiANCj4gVGhlIGRhdGEgcmVhZCBiYWNrIGZyb20gL2Rldi9pM2Mt
NS0wIG1hdGNoZXMgdGhlIG9yaWdpbmFsIGZpbGUgZXhhY3RseSwgYW5kIHRoZQ0KPiBjb21wYXJp
c29uIHJlcG9ydHMgUEFTUy4NCj4gVGhpcyBjb25maXJtcyB0aGF0IHRoZSBtb2NrIEkzQyB0YXJn
ZXQgd29ya3MgY29ycmVjdGx5IGFzIGFuIEVFUFJPTS1saWtlDQo+IGRldmljZSBhbmQgdGhhdCB0
aGUgVFgvUlggZGF0YSBwYXRoIHRocm91Z2ggdGhlIERXIEkzQyBjb250cm9sbGVyIG1vZGVsDQo+
IGZ1bmN0aW9ucyBhcyBleHBlY3RlZCBvbiBBU1QyNjAwLg0KPiANCj4gVGhhbmtzLA0KPiBKYW1p
bg0KDQpUaGlzIHBhdGNoIHNlcmllcywNCg0KVGVzdGVkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K

