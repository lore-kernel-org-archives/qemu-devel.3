Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85055C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIA-00006a-6n; Tue, 21 May 2024 09:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0007id-4i
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHS-0001ak-H5
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297110; x=1747833110;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t5mVqTcx5EuY4FPFmulO8TLnQw3iEaKvV6PBbG7z9y0=;
 b=RK17mXXRFAwQjYPEqPQJMimvAWz8a72mGI0xMbdIiCKiv0YTsaLQSll7
 Yu4VIJbnACqbgQLFxqOCp74j/89BRlKfnELotfem8VOX7tx1ZFNEyiZab
 5ZeL4R3+gABM4RoLqVmR6wEVBTIpnhYE/AmcVbPo0z+c1fWm37bU7IRiD
 wHk4MayTLT6+cMvHaMAtG1SZLL8yvxhNE0c9CZKfuOon3CaNof3VumGeK
 LgSJw/ruslLzw9lZ1LoUqkint9roCzHYwKRJu8dzpILATC+S+YdEBRVfj
 ZSf81rlGcgA6lSwlE9otsXXaHr42232FJikK/6tfvM85qofK2zXY2zKIQ g==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13007992"
X-MGA-submission: =?us-ascii?q?MDG3KGaSd9eXyJfGcnepW5ktAhIYgAcijKwSUn?=
 =?us-ascii?q?lUy/QvENqA9BaI3XMWqvrWDeKT9pCf4dFCpurFWnCCQ2eNd/dfjicgmH?=
 =?us-ascii?q?rrzIo8eVZYhkS47HJI7rl7aqImgU7gkCeimFPRTgBWHlMMxVz08TuHrC?=
 =?us-ascii?q?eNvMpCsjpTyloS1Lixo5tzww=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:41 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjHSGFxwsj5r2jrLDiBo+VOlTrAy5XytEU3DyvgVBYHD+pFjnLGS840SW6t1kRz8RDqgrOPAWNBXFDP7oezfn5DVf3iLQAO4c/vLfcT7ZTw7aZfT2JFJF+A1C4rsgwbWXtvAIwAJHuC5fJ993gmBbpjRAR83FOXNaICtfH8yFfr4sL7ZZ8UxbQvBZ/ssl5GYe1Dzm0esMBviIvkb5qAXjvJ6+JsGpAAW/xZpzFg/gYt8ZOvKNoAv5rQ/mUoau//+jgIpdFFeAVdo2jjcp5hD6+EEHIQCuY2lXxqpft9fxAdB/vvUYO2k2x6dfannSfKfdQXcfFe2+KMsqEUIQd1zgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5mVqTcx5EuY4FPFmulO8TLnQw3iEaKvV6PBbG7z9y0=;
 b=jrhQ8og6xmLsZyyjugWqGKGaSrmn7F95E4MW6+p88qNxDE3+2jPz2n8n1A3/u3hascrB74DjHHQF1/hK405ZQPfvZEM5bCq3miZmxkbgukZILCZX8adqj+o00DMGerLw4ZaZnZy+ogu6iw/y3SyijPaca6SwFVsyPWXEdGy4FpRUkuyMidq/e0XP6my80jDCe/K+6vJ/zfak5n4eS+aK5gJVU2yIudP2LcoXGavCbeJUiZdrmAaOLDSw2l5CqUjE1qAVg3oWolNPe3vwlk1szwowhrdNhX23j8s/Zabnulp6ftByBo2B7pAX7GMXbHhBJ9U9re7Szvs+Qhb0nD5IVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 03/22] intel_iommu: return page walk level even when
 the translation fails
Thread-Topic: [PATCH ats_vtd 03/22] intel_iommu: return page walk level even
 when the translation fails
Thread-Index: AQHaq4Bq+GxgjpkMDUSei0iYZLnFRQ==
Date: Tue, 21 May 2024 13:11:39 +0000
Message-ID: <20240521130946.117849-4-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: bbf1ddbb-f278-45ef-550b-08dc79978d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OXAybnA5N3EyQitBQStldENsMEVmYkdWY0dBZUV5RzNIVlRuMzJFbm1pZEdK?=
 =?utf-8?B?eGRzWXNKM2s2OERqYU9LWFZuZzFORTZYV1BkRHh0cTgxZUxJTldDb0hZRlRs?=
 =?utf-8?B?bFlmc01ISjJ6cFROWlQwdGUzZ1k4amJkSGdPdU5jblVVa09ZanM4VWY1SE80?=
 =?utf-8?B?ZHpPclQ0bFFiUXllMzdORWsvUnh4eWpId3pmbDFmWS9qSmZOR0FGUG5UeWtw?=
 =?utf-8?B?WmZqbWZ1NTZmdjQxa2ducXlFSXk5WnlYZlpVUC95Wm9YTHQwaDNxaHBmcHVw?=
 =?utf-8?B?aHd0aXVjWVBBVkhpWFBma3RGRFBmTWJnU0hieUMzNWpXSGh3aGRiakxUWlVR?=
 =?utf-8?B?Tmk0RzF1YnRFNlM3VEFjekV1bGRxVVVEOGZ5RUNUN1FhOWh3UGM1U3l5S3ZW?=
 =?utf-8?B?NE04a29xSFM3ME0rVUhtcC92bStuNHdVMGpYcE43eEUxSy9pcHJxazBPaXRU?=
 =?utf-8?B?SWxTT2h4aUdUcnFUUVFvRjNQb1BTSGpPUlRnOWx2WW1ITVpPQnhaazhPR29l?=
 =?utf-8?B?K1p3cEtlWm5QMU4zcUsyWTRVSnJETHp4Z0RPZDdtNTBKM3hBZTFjREkxOXVa?=
 =?utf-8?B?UHRZMEt1UEdWdkhqdFZFdEYrRU5TRiszaVJScHBHSU9jR0VPZTh5RTZpME1O?=
 =?utf-8?B?NU5hR042V3dFOS9rN0hiMjJvL0Mwdm9ZeEZNVUhFczBCc2V6dDNUQnY3cWhu?=
 =?utf-8?B?b3pDdFFWT1lXT2NidndqOEdIZWZxZ2NMM1dyVlNGUUNXeVl5aUxCdFJoTDIx?=
 =?utf-8?B?cVIxNzl0aWhPSzA5ckc0UURUOE15a1EyUWxuWEFqOVZyNTJHTW1kWkpUYVhD?=
 =?utf-8?B?R2ZYSXQ2TWlsSDZRVndVUmJaTm9STUgrelcwV3RwRkVkSWZYQUVlaUJiakt0?=
 =?utf-8?B?RWVJRk1OTXUxQ3lrRjFZZGhkalhIQ0ZJOGd2MlRxcmJNSFlocjlJa1ZFVy9D?=
 =?utf-8?B?QlBIMG9ENUY0OUVkUWRjc2M4WTBNVWJ0cXY2a3p2dkphWS9BNDhYQjQzY1lM?=
 =?utf-8?B?ZllCZHlyeWVsbEVxVkdxeUptMTc1WVdjZUhhZDZqOWRlZzc4N0xuZGphWFV0?=
 =?utf-8?B?U1JwcUxKRFVqaWR6TDRROWFNMXFZamhPWFF4T0lmSkZBUk5Wc0xzV1JhQWdj?=
 =?utf-8?B?YlcwWFhnUFdzQ3BCZjUzY1NDWTNrdmFid1VsQS9CLzcxUmdjWEc1ZkRyRGZt?=
 =?utf-8?B?c1A3MmRwZk51LzNuNXRvMzdkRjRMeE5DSXlnTE9sVWZodHJsaDgxQll1UVJE?=
 =?utf-8?B?a3N4MUM4djRVRkptMFMxQWU5SWcrRjd0WU1wTlhnZE1zVUZTczNWeDB5OWRG?=
 =?utf-8?B?YWsrY1JteUQ1Q2g2M2V2UjNpMWdPWTVUTWNxYXM0OHFuTk5YYzdBT2FSdTVa?=
 =?utf-8?B?K1p4QVVmWWRZM2FiSDkvSzVkSGZvdDBnaWNubG1wRGNrN3dZUUdvRDI2cXB0?=
 =?utf-8?B?N1lGRHdCbmJHcFhzQ1VQRXRLYWVqaXVORVRBWmtsbTZHQXBpQ2s1K3lVT1BE?=
 =?utf-8?B?TDF4bHVxTUY4SVdTZ2d4MXl6RlMvdVI2V3BuQzdiOFVHclJsUFVENVRvc04x?=
 =?utf-8?B?eGpITVJjSmIzRGVta1ZsSFd1RzBoQy9tNHJVZ3NKYm1KV3lLMUcwZlhoWjlD?=
 =?utf-8?B?K0RtaWhQNVduYTB3QnRDUGVPbFY3MzdkQkNPL2RmRVhwWjk0SFkzemJpbXpk?=
 =?utf-8?B?bmJseHAzVmZjaDduNjVLejgwYVN6L04yK1Y0M09pcHdML2tVQnlyeUNjR2Qr?=
 =?utf-8?B?bkNiZVBSVUZWMzJRbTVCWmJqV1dJTnBZL2ZOOE9GamoxTWxGa2d0QXgzWnRG?=
 =?utf-8?B?bEQ1YWpCU1dHRVY2NnYrQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymx5bFhmUnR1OXVIcWpTUEV0VzNHTkNmN21JcXdkWHVneHE2YmF6ejQxOG90?=
 =?utf-8?B?R3JmVmplNU0vOGJNYnRYM3doUjBDc1VrSlR5LzZMWE5SNm9wRGxuZGIwK09K?=
 =?utf-8?B?dWErSjB2V3psQU56SDdIUUtuUnM0QjhYcTdvcDRkQTFZenJ3blFPa2V0K1JC?=
 =?utf-8?B?eUNKNHBRZzdsWXAzTitWVVJYcU5tREhXTzVxREwzemRXcmpGRHpaeHBrc05y?=
 =?utf-8?B?M1RVWmx1ZC92WDQ5cnpFVWxQQ0NncDErWHRBUnRnMlhQTk1HY3ZJbXhmNGhn?=
 =?utf-8?B?NWJDdkZ6UWdHM01LOVhUVmpBR0pQanJuT200MEpKM1RTMnp0ZDBDSHFMMWZN?=
 =?utf-8?B?VVUxOHRGSDRKbmdJdHRTUjVYUVg1Z1hvbVJrQzBxN0g1Ulk4Y0NLeFoxZXhZ?=
 =?utf-8?B?d1BWMWR6T0tmUGhCSyttd2QyUTlRN0szb3hITVFvUTZtTXFpeTloUmlLaGJP?=
 =?utf-8?B?ODJxak9PMktDK2ZGWHRlOElZRFBHQlJjSHdyS3pkbTQ5elNTV3NmRWl4M2lz?=
 =?utf-8?B?eDl5UUNEamJlRXJGdWZhR1g0aU9wUy96NlpPQXEyZ0lsRUNEV2ZOZW1HWUhV?=
 =?utf-8?B?Z01wckJjaEVBSkk0MEhnWTByWVdKK1BqZUgvb2I1TjNEc05yZTRwV3pLWmkr?=
 =?utf-8?B?b0lHN3VDbjNXNEtoVVY3SlRzNVpwQnI4ZFkwQVZVQkhUMEt6ZmpsOFVndGNn?=
 =?utf-8?B?b0tDTVEyNjF1Y0JFS0VOU0dPS2NEcTZ2TFh2S1cvckN6clZKQ081bFdnc3Rk?=
 =?utf-8?B?MWNwV0lFamp2L3JWZFNoOGRsTVo2aVN4VTJyMWJ3SWNoeEJYT0d2YXNkdG4y?=
 =?utf-8?B?VEhuTzZIMlBoUWtqK3FBWkFqUlVFUEhSUGk4M2luWk5pUDF6YTgzN3EzUUNn?=
 =?utf-8?B?T3pjYUd1QkRuQmNKVHZJVzNzd3NSUXFFSG9jVUVXR3M2STE2b3QwT21Na09j?=
 =?utf-8?B?SllRNXY1R3lXYThHY0RiL2xnczdIdlVQQXh6dXcrY1FacWJTaWZaWFN1VzVo?=
 =?utf-8?B?UnZFalp6YTRoVGMwVWNvcnU5WWFFTVdkVVJpbGJ0MVI1VFQ5YmZVWEFPcXN0?=
 =?utf-8?B?eGMvbkVENmZ4eUtOZTI1ZlUwRHM4cCtNbmNJcjdtVmFvNm9PcGRxai8zMWhw?=
 =?utf-8?B?SXN3STJnQVNVQXRBRU5GTmhPWVVmUHhqMzBTajRsbk1DcEpQNXJScEJDTlRa?=
 =?utf-8?B?aHpyWEk0Ull4LzUzRDNTcTB5YjRJalRYcEljU0p4M2JZTUMzVWdKM2dUd1dU?=
 =?utf-8?B?cGIrMng4Y0IwZHJsZ3E0QUFXd2xzTzNDSWJwaXZjTFpoS3RFY09yK0s1TTV4?=
 =?utf-8?B?cUpuQmhJZGRSV1hQajcyYmVLUDJFR2hUb1hkbFJIdUhJM1FyVy8zcEdmWVkz?=
 =?utf-8?B?VFJXcGtReG9pRkprVlhNLzM5RHZ5YmU3eTJLM1VHSWV2ZGpjNWR2MVgxWU1W?=
 =?utf-8?B?Y3ZWTFY4WWhHQldQZ3B5YkpuQ2NseGdBYzlQT0h6QXFtTVVkRTVmZzJDWkNk?=
 =?utf-8?B?T2Mrekt5TTRDY0l6V2lLZ3dKNFA1U2J3bmU2ZFFjRXJYU0ZkN3FZdDVXSU5w?=
 =?utf-8?B?aUV2V3NVOFBFMDR0MU9UTE82QTNZTEVzbnhyYzV6N2RzZ3JXSGI4Y0FmNUsx?=
 =?utf-8?B?ZTY4Qm5rT29LcWNSVm9sb3dkbkhlTHlSWExDV0xKc2xUN0svM3hsN01HMjJm?=
 =?utf-8?B?cmUwL0g3dUZ5UndDKytRNGVOSXcwOW5DMHorOUhSVmNoMXRwL0F1VjFYdytx?=
 =?utf-8?B?Vy9WWGt5eVpHckYra0MyWkxHUzBWOHkyT3lnbEg1WGZMU3VXaktCZnRRcjhW?=
 =?utf-8?B?N0pwKzVhZzI3YTBlZDdBSUsrbVF6WUZ2cEUvcFZsMDRUcnd4RGIzSCs4YTNp?=
 =?utf-8?B?bllpSjI4U2FsWXFQOEFpQjc3U3Y5VEhVOEZWc1JmNGVoVUVKRTBGY1ZkY0ps?=
 =?utf-8?B?T2Q3R0hNK3g0MEd6cWhzdU5pMnFITzAzTjM4bElTNm9nY1FMamx3UHZvZzBW?=
 =?utf-8?B?NkVYMy9pOTZlaGJqUGZHSURVV2pvRDhqTXA3TkpsWjZBdHNUdEpobVdJQWxV?=
 =?utf-8?B?Q3U4c1hFNVZxSCt3cUs4ZnZ4cGVHbE5WZWU0SEYvOHY3NjVjeURRaC8vODYx?=
 =?utf-8?B?OWVNWEFXMUU4Y2FFOFhtVzcrOHZXVTI3K3gzM1kwYk83N1lJUDM1a0cxYzJR?=
 =?utf-8?Q?fM/2FeRpnjrxau/05cTY5o4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3DAB958DFE59247AE27B9D340BD20EC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf1ddbb-f278-45ef-550b-08dc79978d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:39.7770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2b15sFV/mJMGzVT2m3uBjbb1mSeBbcfovUg3mfbufwYjHRU1fl1HXdsGWJO6lhGF9R1FNB0YedVP5vWFS3W8i27XphuDVUYLm1jZVpdH8FIpXW0qRD29Gv2DynAnBC6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

V2UgdXNlIHRoaXMgaW5mb3JtYXRpb24gaW4gdnRkX2RvX2lvbW11X3RyYW5zbGF0ZSB0byBwb3B1
bGF0ZSB0aGUNCklPTU1VVExCRW50cnkgYW5kIGluZGljYXRlIHRoZSBjb3JyZWN0IHBhZ2UgbWFz
ay4gVGhpcyBwcmV2ZW50cyBBVFMNCmRldmljZXMgZnJvbSBzZW5kaW5nIG1hbnkgdXNlbGVzcyB0
cmFuc2xhdGlvbiByZXF1ZXN0cyB3aGVuIGEgbWVnYXBhZ2UNCm9yIGdpZ2FwYWdlIGlvdmEgaXMg
bm90IG1hcHBlZCB0byBhIHBoeXNpY2FsIGFkZHJlc3MuDQoNClNpZ25lZC1vZmYtYnk6IENsw6lt
ZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0t
DQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMTEgKysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCBmYzg4OTBmNGU2
Li5hMmIyNzUwMTZjIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0yMDc4LDkgKzIwNzgsOSBAQCBzdGF0aWMgaW50IHZ0
ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0KIHsNCiAgICAg
ZG1hX2FkZHJfdCBhZGRyID0gdnRkX2dldF9pb3ZhX3BndGJsX2Jhc2UocywgY2UsIHBhc2lkKTsN
Ci0gICAgdWludDMyX3QgbGV2ZWwgPSB2dGRfZ2V0X2lvdmFfbGV2ZWwocywgY2UsIHBhc2lkKTsN
CiAgICAgdWludDMyX3Qgb2Zmc2V0Ow0KICAgICB1aW50NjRfdCBmbHB0ZTsNCisgICAgKmZscHRl
X2xldmVsID0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCk7DQogDQogICAgIGlmICgh
dnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKHMsIGlvdmEsIGNlLCBwYXNpZCkpIHsNCiAgICAg
ICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0ZWN0ZWQgbm9uIGNhbm9uaWNhbCBJT1ZBIChp
b3ZhPTB4JSIgUFJJeDY0ICIsIg0KQEAgLTIwODksMTAgKzIwODksMTAgQEAgc3RhdGljIGludCB2
dGRfaW92YV90b19mbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2Us
DQogICAgIH0NCiANCiAgICAgd2hpbGUgKHRydWUpIHsNCi0gICAgICAgIG9mZnNldCA9IHZ0ZF9p
b3ZhX2ZsX2xldmVsX29mZnNldChpb3ZhLCBsZXZlbCk7DQorICAgICAgICBvZmZzZXQgPSB2dGRf
aW92YV9mbF9sZXZlbF9vZmZzZXQoaW92YSwgKmZscHRlX2xldmVsKTsNCiAgICAgICAgIGZscHRl
ID0gdnRkX2dldF9mbHB0ZShhZGRyLCBvZmZzZXQpOw0KICAgICAgICAgaWYgKGZscHRlID09ICh1
aW50NjRfdCktMSkgew0KLSAgICAgICAgICAgIGlmIChsZXZlbCA9PSB2dGRfZ2V0X2lvdmFfbGV2
ZWwocywgY2UsIHBhc2lkKSkgew0KKyAgICAgICAgICAgIGlmICgqZmxwdGVfbGV2ZWwgPT0gdnRk
X2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkpIHsNCiAgICAgICAgICAgICAgICAgLyogSW52
YWxpZCBwcm9ncmFtbWluZyBvZiBjb250ZXh0LWVudHJ5ICovDQogICAgICAgICAgICAgICAgIHJl
dHVybiAtVlREX0ZSX0NPTlRFWFRfRU5UUllfSU5WOw0KICAgICAgICAgICAgIH0gZWxzZSB7DQpA
QCAtMjExNywxOSArMjExNywxOCBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVs
SU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwNCiAgICAgICAgICAgICByZXR1cm4g
LVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsNCiAgICAgICAgIH0NCiANCi0gICAgICAgIGlm
ICh2dGRfaXNfbGFzdF9mbHB0ZShmbHB0ZSwgbGV2ZWwpKSB7DQorICAgICAgICBpZiAodnRkX2lz
X2xhc3RfZmxwdGUoZmxwdGUsICpmbHB0ZV9sZXZlbCkpIHsNCiAgICAgICAgICAgICBpZiAoaXNf
d3JpdGUgJiYNCiAgICAgICAgICAgICAgICAgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zm
c2V0LCBmbHB0ZSwgVlREX0ZMX1BURV9EKSAhPQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhfT0spKSB7DQog
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsN
CiAgICAgICAgICAgICB9DQogICAgICAgICAgICAgKmZscHRlcCA9IGZscHRlOw0KLSAgICAgICAg
ICAgICpmbHB0ZV9sZXZlbCA9IGxldmVsOw0KICAgICAgICAgICAgIHJldHVybiAwOw0KICAgICAg
ICAgfQ0KIA0KICAgICAgICAgYWRkciA9IHZ0ZF9nZXRfZmxwdGVfYWRkcihmbHB0ZSwgYXdfYml0
cyk7DQotICAgICAgICBsZXZlbC0tOw0KKyAgICAgICAgKCpmbHB0ZV9sZXZlbCktLTsNCiAgICAg
fQ0KIH0NCiANCi0tIA0KMi40NC4wDQo=

