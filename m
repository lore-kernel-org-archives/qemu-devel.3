Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C09BCF64AB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 09:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM100-0000Xg-Jm; Thu, 20 Nov 2025 04:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vM0zs-0000Vr-8c
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 04:30:36 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vM0zp-0004oR-Eh
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 04:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1763631034; x=1795167034;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iqQyll21OHYsp0Mb1a8Hu4WMQY4tntYceUrO6vnZrRQ=;
 b=PGHBdve6N943R8yrXka3Lryh+SpVqkmeHh1gkIWOhLOJUFFm5IhhzSd3
 Jtr1Oxo30WylV9Np1wFnldKtY0Lfm64lSUgFkSDiQXyAEUlfABOaGJZiB
 8qGoiEVzn6MRcU9lsZwj740TizbEMSM7QS2GkImNo9O7RfzwaHNnepTep
 GD011HR7+lYs5yQFLP0cohIDcahvdcGsm8tHuJj0AtNtb+P3q30VkoVxZ
 05MWpUeYioArJhJYtXIO//RGvgpQ2drnWD43X07gnPKTxDVc4oESiKGSZ
 x08mxgHZY4SCh8bbcyrjycWukFz+io1+4qF7WzzDbL87FSVAPsFA8zU3m g==;
X-CSE-ConnectionGUID: A3jxn4eHQduK/6mfibFKXw==
X-CSE-MsgGUID: 2M+K3Y5TSYuF/CHsBmbovw==
X-IronPort-AV: E=Sophos;i="6.19,317,1754949600"; d="scan'208";a="44724446"
X-MGA-submission: =?us-ascii?q?MDFs223Pm7YOG0n9c3+y1AvtyaD1og3TcNloS6?=
 =?us-ascii?q?PGPCNG1zejxNPzHpSIdLnLscEPyJtZMvxHiMrwrjQD0s4B0YofhvL18D?=
 =?us-ascii?q?DQBe+9nrKcTvfhP2fviRxXwHauM7p7sUMp9j5aFuQa9n2jW/w63SsRnM?=
 =?us-ascii?q?kwnR6Lp2cHxkkybOwSazw8iA=3D=3D?=
Received: from mail-francecentralazon11013022.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.22])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Nov 2025 10:30:29 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guXUzhBv02acI8IF+UUfKoGMhX8K9W5/PiFzIydIfQGQEURG1/7rKJnUMUfv4WNShAsWDnGjA54xluFP/IWxqvOUrbdblz6KyCI+2jg4iawBrE9+9R04qX4+lQSkwO/FJkv2IPzhkTfe3TiOmdyyBLJHx/WR6eU5RwdEIAiUP+OMjH7j7rVJcINXOKocBORwh7RT/SIk3cMgNHtwFaiwb9f89lpcbTTnStBMCQCKZE/p5Le/InM03QGWmP2Z+YTXRtlvbHGm0Q6mR/ElruS6bS1OHGFnIBvTw1TjPNuNNynikcfqux+VmuBlKrAQJ+xRoU3oIOiZDM1/FgR3PHiY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqQyll21OHYsp0Mb1a8Hu4WMQY4tntYceUrO6vnZrRQ=;
 b=kws/cagCbmnl5URbq11wCEwlaEPCd7MAtRTcI93K0192mFbljI0sZJVLZKRCx9iaiHbUflO/XH5DUSNqif9onHp5ZG/9IgCYk00YSKX7DKeehPNmJT1ol6Ef7uCo1zFhyVcEEJoHwksu99zIW6BgPX94bHToH3VU8CEHsLmxYmEIKi5ddpG1B77qFjcefY4oBrpeX9F5d3CBFA2wvBHk7ckKK848+PqnFq+srZ1fmRvD0j8xdLWFci+M2ngM41bc0mTPw6UHg3fZZvNAT7e8Lf4AwZ1LTMzMR01yPvtvlYwoaDsgO0a+RmvfRqsCyUhU0o8qDLuH7ucyNJ8n7d0BoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqQyll21OHYsp0Mb1a8Hu4WMQY4tntYceUrO6vnZrRQ=;
 b=IM934Hj+Lc6aF91RAKDnKquo92n4SculqIQ0qV9LsdYEnu+w0Yzmx1i+md0t3ntE8CVMLZHupFf/MXSqANyWAW0F9/efCLgqh7wThh0IHb45RHI2KUZYuWbsPqnlGYIo3wBs5dcJeAYTNTv/O/Z8ZXzHlRPk9v5KqFYqHS6LC84NhVWa/VkT198BYxLTfgeVkbgQvGVKV/Pcv0UOdhJV12WFJdgG8fGpnMu1unl/he88Ig1JIX2G9pNATOTp56gw2gVQwgB5QTFt+EN5/h8r66m726Y+3CLZuHdQ5kAG44tR6Gu5Nh6UY1pHp2qZMYlnRG85PDVV5wTb2A1Ed9VQbw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6244.eurprd07.prod.outlook.com (2603:10a6:20b:15d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 09:30:25 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 09:30:25 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: DAMIEN BERGAMINI <damien.bergamini@eviden.com>
Subject: Re: [PATCH 6/9] contrib/gitdm: add mapping for Eviden
Thread-Topic: [PATCH 6/9] contrib/gitdm: add mapping for Eviden
Thread-Index: AQHcWUk+wQB1U1B7gkidLVaTN0jIx7T7TgKA
Date: Thu, 20 Nov 2025 09:30:25 +0000
Message-ID: <27d93b877e5cbc9d937489830b07bb9e4be1da4b.camel@eviden.com>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-7-alex.bennee@linaro.org>
In-Reply-To: <20251119113953.1432303-7-alex.bennee@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6244:EE_
x-ms-office365-filtering-correlation-id: 0f62d0d6-dd8d-40f8-d096-08de28176fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?M1NNbXdScEx1VXRTOHR1NVM3TDA2M3dYeHNYV1ZsUXIwUlE5YURvZEZSSjZR?=
 =?utf-8?B?RUdvU0FEbFcxTE03aHZSclRxNDNJSFVVckxibVpnQ0NNNGlwSmpQdDJGL1Ax?=
 =?utf-8?B?WitGMVU3U3lZWVFZYkcwY0kxQU1kWFZrWXY0ZDJQS1d2R1cveUYxUXl2N1Yw?=
 =?utf-8?B?dDJkRFR4RFA3elBZaFIySExXalhWZzhham84dFB3SjFDWURBSXVxelQ0ZlVP?=
 =?utf-8?B?VmpuMmJzcUZ4dUdMSXZYaUx6d0pISis2a1NVZWVUSUdhdld3amZCUWdTbmFO?=
 =?utf-8?B?VE93aUN6Z3JnYzhJSnV3aDZJWDBOY2NITU43enhYajlRK29CNGdwdE5TZ0hE?=
 =?utf-8?B?YUpJOEFjamhTd3RiZUQwUUdCRkpSMWRoUU1QOFFSdjM1QWhMLzAvdURvU3hh?=
 =?utf-8?B?elgxc2Z0VkVWUWpzTkgzbHE3czdQSGE3Vm5qRVpLRytXTFV3MFE5WG9XeEhU?=
 =?utf-8?B?K0JrL0ZXcFFPbEYrcXY2VFBNbzRVMW1rbWdpZVI1YzNiUTdYYjFwWVBuL0xV?=
 =?utf-8?B?MnhqVjZLOHcwYm1HSng4QVJsdnluNjdxeGRrR0NSb2V6L211clhSc2FNclU0?=
 =?utf-8?B?Mm1Ta09sR1JIQmJGNzd4a05mbEl3RGoxVFAvU2JBZWhEakRvUDNBaUJsZ1ZV?=
 =?utf-8?B?NTNBcmtDR05CVGJublMwNEFtVU5OQ0Uza1Nud2hUMFZJK2FuMVJnNlBCNmdx?=
 =?utf-8?B?a240RmxGa0FSS2t0K3NmRjRmYlVNY1NhUVlHaGJDY0hLQVNaRStGVi8wRWZV?=
 =?utf-8?B?QXZPbFpJQWVaOTdTV1o5OE03L2VqK2J5MlZacXpkYzNQYzJwcHpGNVdZdUNu?=
 =?utf-8?B?LzFJV2VOdDJLSGpJdUI4WFQ0UDBQUXUxY1F2RzlZbWs2c1IrajlnN2lPN0NU?=
 =?utf-8?B?ZDVjcDVFT1ZzVjZRcUNXZ2svbWdwUEliN1Zray9Pc0FmbHN5QXR6bThPR0I2?=
 =?utf-8?B?aU0xRUgxajRYYXRBYnhBT3g5cG9FNUFvWGZPRG9odkxjOUsrejN4NFhJbC9Z?=
 =?utf-8?B?eGNVNFNOUlphekpqazdzV1dOVkdUMDNVdnpJa1ZUMG1GMzJNU0t0akF6N2li?=
 =?utf-8?B?MGhLemcwdnZObFA3em5zZk5HNGE5d2Q0NUpnYktrMEZSZWNJSDUzd3J0Qm5a?=
 =?utf-8?B?eXhwUld3NnRmblp2NlVGYWZxNnJvVThTOWZrNlJOUG43VDNxY0Zkek1DWGNQ?=
 =?utf-8?B?dGUyYnRYLy9CeGFwaDZBSC84d2lzQXkyVS85YnRxRmFLaXZJUkgzaWRoM08r?=
 =?utf-8?B?UDQ5NzMzd2VvT2k3T0JiTlV6TGhhc1J2UllDMFIwUXh1dnJOeVU3YkVTNzBy?=
 =?utf-8?B?cVJKdzY2UmpxN1JpTU43a3cxa2Y3TDJxR092Tk1ma1dJcFpVY2dPeDlOcnBv?=
 =?utf-8?B?eGxRcDJvek1MQzRnTmZPaWZBMFpxTWpZOW9KSmZtWEVEcW43dGo0SjJJYWJZ?=
 =?utf-8?B?bUhuc29Vbm5ZZkpoRm44SUdORERab2xDM25xNmlVV2w1UHRYZ21TVkJPK3Jy?=
 =?utf-8?B?NWVJVHNEb2JaVUtGdW9acktsN3pPVUdrUmhJRlQ1RjBhWHdmMTJsQWtPQWl5?=
 =?utf-8?B?QW14ek1HODRlM1RjN094M1c5VlExTFp4ckE2QllGaFpkZEh5RkJ1blZlb21M?=
 =?utf-8?B?ZkkyVEJBN2JOR2JuNEdQaVVOWEJDZnpCOXp4a3o5RVU1eHV4T1htKzRjTkg5?=
 =?utf-8?B?UnF5eVU1eXFULzJUZkR1eThCVTlKTFB4aGFqQis5cmIxREJZc1JHZ3h2SE9F?=
 =?utf-8?B?T25DcUh0Umt1RDlzTHRmL05WcjBEV1NIMUtYdTVpbUZrZkFmVVg4SFdzZXIy?=
 =?utf-8?B?RWM1VDdkb0IxU2NEN0hueGlrZDV3THBrMjdjeURKK3UyRVpyS3FvYVNuZGV2?=
 =?utf-8?B?WXRYYjJGRUt3dXRyS0VOTE9PWmtwYVVGWFNrTDhJajBDU2pkdTVJMUx1eEtv?=
 =?utf-8?B?Z0NZYTNlRVcveEM5eWtvQzVKSVpJNURIVkhyT0RycnVJK0YxN2ZheUc3dGFw?=
 =?utf-8?B?NkJsM1Q0c2JxWjVTcU5nWVNZeDZ2V2owYlNwWENzZUFuRTBFby9aZUZSWnNM?=
 =?utf-8?Q?XoyJJr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1EveldKTEZzMUUxQXRTaEZGc2Zyd2tNelppUTdzc3djZllRSmlRSHJnYlgy?=
 =?utf-8?B?YXRRNGlHMnlmckloZXpCekpwR0FRN2pGTk9TR0Y2eFZTVHY5amtaL2xGQ1g4?=
 =?utf-8?B?bGZPWFFCZmx6czFoYmRjRHM3TWJDdllXVHp1a1NIQXNmQ0p4YS8vTURwalc2?=
 =?utf-8?B?eGY5b3VlZllHazNlaFFuUVZsekxDTXJYQlZlbEVzTHdVSmN6Y3dPc05rVThG?=
 =?utf-8?B?NTM2aFVZWFZxT09aai9yOXQ3Tk1UeUJXaHBieURtRUpjMTJiVW1LSURkK2xt?=
 =?utf-8?B?VnM4eCtsTVpyQVhPelgxUGxqVTRuRnhpRVl0L1FSRHBoWmVRczJUbnRJTlc1?=
 =?utf-8?B?NVAyTWNFYTVDZGdFTlJDeVpIak1jVlhteDRzblloZ2NwcU80aWN6OFBCREk0?=
 =?utf-8?B?VXZnbWVYZTI4R1llZmkreUxhNjNkR1E0RjF5R2ZYVzEvRW05TWhHQjB6TGZ6?=
 =?utf-8?B?bHNoYmpoTFR1YVh5anZHRWkxbjlBcTd3MDI4UHF6T3dQT015SkU2djhSbncw?=
 =?utf-8?B?eXVVT3NMNWxGUEZKQWVjK0tvZFRkVjl0YVRaLzNFc0RWc1lPOWNHSjBnaFJ4?=
 =?utf-8?B?c3gvcXQ1bVMxYSsrRkdqc0l1cHYvbmcyUkV5UnRzbFkySmxXWlkxNlhobkVO?=
 =?utf-8?B?cW9YWlQ0RlZndFdKY25yOWdZQkVCbUZVbkJVbTlzNEwxK0wwaHpGNWFxSlVu?=
 =?utf-8?B?MTY5aEtralRaRGtURDZuSldzZzNKdDZuMHc0Nkp1SkdNV283eitUeVo1MS8r?=
 =?utf-8?B?M3U1eTVKazZseTMvRmQ1UEZ4T2t3NkVQTUdHNEdicUYyY1VxaFJiTjZyUDRu?=
 =?utf-8?B?VHA4WDRiMW5wc2hYdGN4OS9hL0cvcytnN3lrcDVXUnFVdjlRWnJoTGFwNGdX?=
 =?utf-8?B?YkhOU0dUU0N6MWNrSVNPRkFpMzM3SWl2aHZrb21kbDN1WERwUThaUjBVOHNa?=
 =?utf-8?B?WXNxdk1uOEc0WklrMkIvR0xvSG1wVVVDU1ZRa2RHZmJ0MTlMeTdKdEYvSEZL?=
 =?utf-8?B?UGJMbWhYZS9SaDNRaXpnd1d2aUFZL3hpbWlYSmg2eWJmT0VBckVUY1BvVU9w?=
 =?utf-8?B?M2FjcS9KQml2UUE4d1RmeFloRGcwMkx3MHRCNlRPTERSMjRHMHNUMFBnTHgx?=
 =?utf-8?B?RFpNRE8zYVVpSHk2TzFwQitVcjNWWmNCTXdRRkdQTHFOYm50SUtmMDBvaThG?=
 =?utf-8?B?UWkyR2tGS0tuTk5YVlZvOGMwdEIxb3dXc2M2RkdYMFg1Z0I2RVhhUE9MVVNa?=
 =?utf-8?B?TjNhK3ZHcFBmUmhHVU5IbnB5Um1KdE1uVkx1TCtTM25SRWQvUUFCUnByYktH?=
 =?utf-8?B?YUpGalhMd0NZZXd5alhBUGVSTWdINFpyUktyLzAzUndWUCt5R2Y1OFMzaEZ1?=
 =?utf-8?B?alFpeEtDbHcrc2U4aVZ2a3ZTOG1CZDV4S3FKaEQzUmcwSnU0WXRrUHBvYXRX?=
 =?utf-8?B?bjdFU1BMTkZFVUFTS1Jma3pLaTM1NFloT0ZFcUppbGFMVUpmOFY5NC9qTys3?=
 =?utf-8?B?UktWMC83TjlNUjFWcVRscVlGR0NaMzRJSDlJVlI0SU1oczVmdjFLMnYrVU1K?=
 =?utf-8?B?MHlSN2xRdTBDSUNDbWkrUlhQUU9JbFIxM1JPa3B4WUZwMFRUdVJYdUR1K2hr?=
 =?utf-8?B?bmhoZTc4ZW1RdTd2a3JHdzdHWlY2Qy9WaWI0VS9PTVNhdzNjWjVZeFNaRHF6?=
 =?utf-8?B?Y1FnRkdRRi8zSzk1WjFLeXdwSmlwTGc4WmRncWIwbmtRaEI1QTFJWXZ6M0tF?=
 =?utf-8?B?Qm94UFpBS0Y1ZlpoSGNqb2Y1bE5aNERxRkM0aUVBZk95R0haUEFrR3VhOSt1?=
 =?utf-8?B?M1hoNU9hc3RRMHJLUFZlcFljQUo3UnNHdG5JMWZqSVRuL0doYU1pWFlxU0Mz?=
 =?utf-8?B?Y09uREtXUDZiT2FMY1hqUXVUaUlGNG5va2ZQM21DcllVY2lrOXlSNlBscmU3?=
 =?utf-8?B?QUNUdE5oNTFvT09aRzkybmZTZXVzSE56aVc3dlNHK1VKclR3SGxIVUdNditJ?=
 =?utf-8?B?WlZYL2JYdlFHNmhSSyttUy9PaU1RZ1dDempMYklmOVRmNWlVU2pUNXJiMTJU?=
 =?utf-8?B?bGYzZXR2SVllZkg1eW92dlJ3cklFa2JaMGhaSDlQL1pFc3ZRc3V4YVRuc3dz?=
 =?utf-8?B?Lys0SndjRDBMK01haDNaci9JSGYvSnplY2xQNFJWNUNmZFZDays5THhEOFZ6?=
 =?utf-8?Q?sT5Ply4T+lIorIW83F6UDAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86173BD9BE91F142B8D59A9F92A18334@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f62d0d6-dd8d-40f8-d096-08de28176fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 09:30:25.5823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ahuh6+6rlnNeMQwgblxXngduVM+2PMtaQ4mMkaQP/VkKyuS3E5n5HchYreGGs0tGoZuNTFPTPV3TLN7T6fMC73auHbqzy/0a9RcKd3eXaiw6nMf2vTFB/sguyGQ/tZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6244
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNClRoYW5rcyBBbGV4DQoNCmNtZA0KDQpPbiBXZWQsIDIwMjUtMTEtMTkg
YXQgMTE6MzkgKzAwMDAsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwg
ZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLA0KdW5sZXNzIHRo
aXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRl
bnQgaXMNCnNhZmUuDQo+IA0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llDQo8W2Fs
ZXguYmVubmVlQGxpbmFyby5vcmddKG1haWx0bzphbGV4LmJlbm5lZUBsaW5hcm8ub3JnKT4gIA0K
PiBDYzrCoCBDbMOpbWVudCBNYXRoaWV1LS1EcmlmDQo8W2NsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20NCik+ICAN
Cj4gQ2M6IERhbWllbiBCZXJnYW1pbmkNCjxbZGFtaWVuLmJlcmdhbWluaUBldmlkZW4uY29tXSht
YWlsdG86ZGFtaWVuLmJlcmdhbWluaUBldmlkZW4uY29tKT4gIA0KPiAtLS0gIA0KPiDCoGNvbnRy
aWIvZ2l0ZG0vZG9tYWluLW1hcCB8IDEgKyAgDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29udHJpYi9naXRkbS9kb21haW4tbWFwIGIvY29u
dHJpYi9naXRkbS9kb21haW4tbWFwICANCj4gaW5kZXggYmYxZGNlMDNmZGUuLjRlNjdjM2U0ODRk
IDEwMDY0NCAgDQo+IC0tLSBhL2NvbnRyaWIvZ2l0ZG0vZG9tYWluLW1hcCAgDQo+ICsrKyBiL2Nv
bnRyaWIvZ2l0ZG0vZG9tYWluLW1hcCAgDQo+IEBAIC0xOSw2ICsxOSw3IEBAIGNydWRlYnl0ZS5j
b23CoMKgIENydWRlYnl0ZSAgDQo+IMKgY2hpbmF0ZWxlY29tLmNuIENoaW5hIFRlbGVjb20gIA0K
PiDCoGRheW5peC5jb23CoMKgwqDCoMKgIERheW5peCAgDQo+IMKgZWxkb3JhZG8ub3JnLmJyIElu
c3RpdHV0byBkZSBQZXNxdWlzYXMgRWxkb3JhZG8gIA0KPiArZXZpZGVuLmNvbcKgwqDCoMKgwqAg
RXZpZGVuICANCj4gwqBmYi5jb23CoMKgwqDCoMKgwqDCoMKgwqAgRmFjZWJvb2sgIA0KPiDCoGZ1
aml0c3UuY29twqDCoMKgwqAgRnVqaXRzdSAgDQo+IMKgZ29vZ2xlLmNvbcKgwqDCoMKgwqAgR29v
Z2xlICANCj4gLS0gIA0KPiAyLjQ3LjMNCj4g

