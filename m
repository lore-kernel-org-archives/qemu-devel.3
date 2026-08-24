Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48262C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMuR-0004tM-VR; Mon, 24 Aug 2026 01:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wyMuO-0004t2-57
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:07:44 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wyMuL-000702-JF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1787548061; x=1819084061;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mRy1R9HMCdR9kkY7BYb3b5kRAwbN0BBSqh8vzJeCVS0=;
 b=iSkO0IeCV78NU9CbOfWssea1rztMD24c3CNYlTQI6vocKYS6MrSWmici
 LhsiNIfA8I+4pgb4vgzHXQuyJoPEBV5WEah4qZEeaiIjESXfDRg1Q8A5b
 xxo71c/Q6Hs+Bw9CG/LcrLS1m4ANZzfij/1KWwiZScnWVKiFQWR7FM/jf
 USEO8ekJzZus4v8eOEDJqEHjicVq6KJp7Csr5dulgYcE3+WbnikyXP/6u
 yh7A1LrI1blDW9cQSTPPgwmDyVyXyM+dfvKQkRQIw5T6+dvSS9GfSMjqS
 NGkbG67u3l1+LGy/iyUWhwUUmEvSKFV+LUO2TXzZWW54ogxQQEVZ3txtk g==;
X-CSE-ConnectionGUID: Lp3RKZUcTI+yTJP85D4ADQ==
X-CSE-MsgGUID: Ftk0Klh4QXyeNJjt4IvXig==
IronPort-SDR: 6a8bd192_HAU+to9ERSJ99oPuWW/eWayyN2w/Xav48kGAfvQ/BaMMFkw
 4ylMqkux4y9Cl69Kdi8N3NNzaFV6wyi463gAKOQ==
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; d="scan'208";a="50746806"
X-MGA-submission: =?us-ascii?q?MDGDKzY6qisKQds8tIJhCMMUHiYWYoxwzQJ/ry?=
 =?us-ascii?q?BteTqAjB3KIkcvBUaEdBtAEmZmmeuEnyjTR0p3q8E0zSZMvWoLcwDm+N?=
 =?us-ascii?q?lAKVrvlzV6GeTwe7Jn4jPEBJUu4C24/uRlTB6luq5ai9zZp3BRBXJDoy?=
 =?us-ascii?q?8Sx1xdm7ocqe1sHLfDojE0UA=3D=3D?=
Received: from mail-francesouthazon11011048.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.48])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Aug 2026 07:07:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6DPE3ZFdyqtCnGqPwoH3S2JHBXge6wIP5Z6X5Hfa/xL6svpZAzOtbWS7ExGVFsqUnEzHf4zBMBURNRCQxXRFKEbMckt4HouciJCuihDlyLV6SKJ1HJjTL5qGNW4Yn/boSJweHaNVNiaTV4er4PZ4hwpHmXWtfkjksUlRv4ro8yJ6J8oXX9PL3vQ6uPigSq1BQopsvfMhINQhj5tJ1OCWyAwz6s1ySRkcxOcVrKM32HUcekzH9O2ySXZaawYrjlH/okquGMbJ/3PL/CajFn12xh4OPmBhYdwGwXLpjghogLx7NtIc2Kxz0bPIH7eNyqxmcibhpP+KR6xWUmvaepiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRy1R9HMCdR9kkY7BYb3b5kRAwbN0BBSqh8vzJeCVS0=;
 b=ZY6Kd0Nt9gMrVQpZPQz41QTSEDgLDrGMYMnxpkxdFXUs+CU4sB62QLcaoWGyl2bAG4cXQd/XeUZtGLDcXwPUQgpAz9bAA99B5g/FkceFq3TJxQmq8G8QBO5fiaos4iYRwrF1I/JMSOBp1ZkYWE1mHrINsMYJGXTYkTMhP5pk2fdlR75Ecjfv0Oi10pWu7HB/ubln5iHL6GrXoGquDiyLr6wxUMA35gu26G+3xIWAQ3rd+dGzm0QrsJH9DB8pKFdSGtIdjmD92OYt3ecXH9pINpbaCeigy9t2LwIXTfRgUS9XNS9rLpgJ+UpLCqznCCZzfPWVe5SOvOgioqTmAG15PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7213.eurprd07.prod.outlook.com (2603:10a6:102:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 05:07:28 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0360.005; Mon, 24 Aug 2026
 05:07:28 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaknO6gra3UQkST2flmIiB+OLaUUwKAgALN34CAAAZzAIADSi+AgAALfQCADWYGAIAAOkKAgAARnICABJMZAA==
Date: Mon, 24 Aug 2026 05:07:28 +0000
Message-ID: <b8ce9b7d794b684cb0ff2456d2397558a1149146.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
 <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <2d811cf876963acc75673078a869a63fdccdaf06.camel@bull.com>
 <IA3PR11MB9136C8AC130468162F9EE8A992A32@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ecedc1b02ec279c36e84377f415730b44f879df8.camel@bull.com>
 <IA3PR11MB9136C9DD34DD6DC631A2ECBE92A32@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136C9DD34DD6DC631A2ECBE92A32@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7213:EE_
x-ms-office365-filtering-correlation-id: 4d41f02c-c386-449b-3d6e-08df019d982b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: 0ZMLy3aiSVUHH5XZFa6YAXEEO5dWw3tTry8ymZciTuhki68pdKzLIeheHKZSsZLODXaxh0U/lsxfKAmZ2VysGUqUc/JJ5JQWangDNbSLehbv/kJEhsdqbkV2dojH8srmauSNoJ+dA+7fbjrgKxMq7X0QjJoHWPThPLr7dLhWBLzlUEHgZabKzpzsuYB6Yz7vs48BfihK+PE7UNk0uaOSDLkjxmA5Qq1poXSIHx/ij5I+pki+1n2S+s1NJPyZnVYncHqxIdj1uutgW20sh6nV62jfmBw2XP3wUN3KDUX9ePkGUkdvZdD8nvJlc4DGKiz+o44aDVBSBbANcu0MKF+pK3JjAKWENvn0tikNtVAyeAnvjW1uR+BvQ8YrSRuO5myKqcu5Z1rn0Wvm3yNQ/y/3QM4mh/dzDeFni2EVUZZsK5dQD27SmcgpIdtdaTgEjmgZQOb/CAnjz5RMVeGli37y3qGKMumJfrPSJRK6FrOuedL6+sgrZp3EACVCTr4WujewIKJk3kLJqB780ZIn5dwGYDXGLSG6HCMY9wJXeVstjNg6F+Fe75OuP11pvGP3MIatyos8hbapsGuQe+pbhXW0Hi+uiRrVqV8M8RvDQ5SFmloFUNBThE59Ezhndt3g7S7nxrrfLy7yBBGy6OfWP3mIW83SOAlTd8gE0OHxIozv5GQxXb6ytOoJM89n3DL3heliV5VjrqJ2281QYnSPrpznCwnZjfM3ghyRc2Ej+jolznM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnB2dVdTMlpiZngxSmJNWTM0QVByd0ZZYXdNYVFPRitUVDBGeGJMZk9Namxt?=
 =?utf-8?B?ZjNnV3FkdzZ3ZFJzS25WQmFHaEU1dWhVOG9GYTF2NXYwRUdBSndkYWlHTzhR?=
 =?utf-8?B?dWdsYThqZ25qVlF1NDVjSFhBRmFqZENoczVNK2Z2dThRcklCME5MSUpFejE1?=
 =?utf-8?B?TVJtUlU1NVlMUFcrWDIvcXBadDB0M2hybTVaSVd5OEVyZ3ViWm1wZldJSWNC?=
 =?utf-8?B?Nks5blBMbmo4dGwyTWZic2hDcVJBN0NOZ2dhL3JCbTZSSlc3L1QvY2tPdFR3?=
 =?utf-8?B?UHVhOFQyWGRHMzFZdEc1VjlSWCs0Z0xIY3NRM2xEM3JvVzBXU2UybFNQRXJw?=
 =?utf-8?B?a0lTNDZYcUJIZ3ErT0twMTcrVFhMQ3F6WWhXMUF2cDNaOWl1TTdHcTQ5WUdV?=
 =?utf-8?B?MWM4bmRpbXZvM0RKMkJwR3ZBc1Q4K1ZsQUVSK0NvcGVaam1kS1Vlb3VOVWtG?=
 =?utf-8?B?bnU3TzhmWnJzK0VxZ05KalBBcmhjN1U4SjVZak5MY0d1enFKZmtlTThOUnFC?=
 =?utf-8?B?ajBTdnNzWGdtV3NUWENHSTJWMzR2dHJCcjA3MTF4ZUw5ZnhUazJMSUlHdjVX?=
 =?utf-8?B?YTJYVTRsT0RpWVZnMGszNmZyc016VHZNNUE2eDBpVVpLb2VobGorY3B0d0lh?=
 =?utf-8?B?S0VnZE1IYktORFFibGxVek1xZDJTRVhOR05yZE9hek1CSnJMTGlGSWRHTmxD?=
 =?utf-8?B?ODdIM2NrN1FUMENaMkY1bmJ1elJGdHN6QThFM0YzTjFabzBlMGF5WXJCK0hs?=
 =?utf-8?B?S0dhTWNuSEpSVGdkdHppYmgzUkJuWmtZUkR5ZllZR252eUt4bENIWGpjUEdn?=
 =?utf-8?B?anZOdC91TCtER0ZmZW5MVUJVYlpLTlE5a0pxbkJHMUxqeVoxaEdOM0lWWWtE?=
 =?utf-8?B?SjZiT0Q1K3FKOGhkQ2tkNHI2WDdJM2NEemErRzJDNzFYeVArTWp1aWRJSlZn?=
 =?utf-8?B?U3NsUFhoY0YwSlBHd2ZmUy8zbkZ0SnpEbHNFQmtBM1JjdjRWRmt0RWQvTkRv?=
 =?utf-8?B?ekUzUUtDYVR2ZnJqK2g2MFpoMEJ3U1FHaWxkMkxOV01uQUZFTGVmdWNFaCtE?=
 =?utf-8?B?MFIzVS9uWGhpVEFhZFRxL01WQ1FFRU84SXB1b3lzOXhQK09FZnhPQVZyU3ZH?=
 =?utf-8?B?VW5zT2RxZ3JRbk80Mlo1aDhBMUN1Q1E2eTBad2x4Yk9tWUhtTDVnL0VBQ3lk?=
 =?utf-8?B?V2FsUWNWemptaWZDa05UZ3ZtTys1UUdhN3VqN0hIV1ZGdDhnR3dpY0JBQ044?=
 =?utf-8?B?RWh5ODVtVEFWMnN0cWNMVng2Uk4rUzZpRFI4dDlLWXo1TG5OZ2FvK3BKekRM?=
 =?utf-8?B?R0xrOGg0R29JR0VPU2xLbStGVkM1MWFiL04wMlc3Y3MwWmxwYkt6L3dQMmZV?=
 =?utf-8?B?NVVCUlUxaUcwSkRpMDQ2d1BGSk9VQUF6V3l4Ynh6eTRmRkQ3dkJHVGRMMW43?=
 =?utf-8?B?ZjF4ejNuNDJsZ29pb05wZ3ZCVUE4V1dFTzQrdlRBYXJGc3J6amQzRm9hVk1K?=
 =?utf-8?B?SXBaRnkwZXp4ODlzeUFWRzc5RHNkTlNHd2xsK2hrMTZyWC9COTFqOUViL05I?=
 =?utf-8?B?T3VTTzhrRU1qMEdSWmxvcngwMVBUUGhDV1N3RWdJay9pL21DcFdOUTIzdUx0?=
 =?utf-8?B?bHVXOFJVNXhuTXYwdUN4OXNBVTZ0NVhXVkd1WGhNOTBoeDV5VkNCY3l3dVlt?=
 =?utf-8?B?OHpvZHQ5OHN1dEErNmRtZm1EZzhCV1RTV3FsbU9PM2FzL1g5em5lek8wMXlG?=
 =?utf-8?B?YkpGSEZrKzBwZER1aWFNOGRrU0xXSDhBTms5NWdWWE1sNG9xYnQ4OU5nQ0VB?=
 =?utf-8?B?ZFZPYkhPTnJ0TDhaN3MyVG1iVlc0UlRQRTBtbHhHRko3ZnAzRVAxd0pycWx0?=
 =?utf-8?B?RkdXdnJoWWZYWlNwNURqVVpUa010ZE5XNW9FeGNpZ1c0eUx2bnlKVERvaGV3?=
 =?utf-8?B?TTh0SUVUWk9aMSsxVnNmMUNOajVpRGNDYXpGNWxxSU0yRVpyY2FiN2lHNXZ5?=
 =?utf-8?B?QlYrNm9jZHBGRTNlVm5wcURZL0d1MkNkV3I2QkNkaStxL0JmR1VyNGdqYjAv?=
 =?utf-8?B?a3RiS3l0K285REl3VXdXL1E5dUROWEZZdVV3QVRaN2I5Q3cvS0NqQ3J1NGta?=
 =?utf-8?B?ZEo5VlNDQjYzblJWbkRxYmYxQjE5cktRZlpmVENld2pxay9TSjVsam5VbGJH?=
 =?utf-8?B?VHBzWjk4ZDVrMHpCblMvVEhBUXpldWJTOUloc3VHbjFPeGd1ekQxeEIwU2xS?=
 =?utf-8?B?dEc4amFiejhUTlQ2OVpMV211TlgvMmVnU3lwZEZMTzg0Z0pGMWVvRnFXMjUy?=
 =?utf-8?B?ZC9odTRFMzJGQmFiOVZZL2ZiVXNJT3kzRWpReTZLWlRrTkIvV2UzczM2amdB?=
 =?utf-8?Q?kRliVXR5FSJBsYDUrBNEJ0869c4MbHWvJpXgv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA762C45F6E268439F3F046B945C9E7D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3RmZQcj0SC+SeOP14WOTHzR2a9DE7ZVEEcMxs/rpwzwBw60QF5qjoAXWakVnrZFJ6aU76iiDcLX8j/FZ/PJiPcvWrggAz+lkp4AYAHNjsa67+RjAp31ZY+3umAhmUTCDcMpMOE1cCGvkDGHuRnLjchENVXmLGb8Ehd3jxd/jBwXEE+LQnjoe6oDFnIe1HxL5Fsn1M8Dw105Ow+Th2rBQtFeE5KGEg5zvUWCv0Zquhqqu8VHb+KeyoqmvxW8VPE5svKcJiedAsRDtZy/aNXExfwlpje8tubSigMIhEtotkZdjOTkE0ZJ4u8g1POnFd53K0EvvlnakVCcZ5jKg1ljeyg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41f02c-c386-449b-3d6e-08df019d982b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 05:07:28.4055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCTBYE6vJTnrso0B368Jh3s/HGY3PeXvMz/i0MD3NJzu4/lgi0QjVDf1nlBAskciILfTq+FKbGNIwyJrMrdQKL37Bneb8OlhHZfJurC6h4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7213
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

DQpPbiBGcmksIDIwMjYtMDgtMjEgYXQgMDc6MTUgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQ2zDqW1lbnQgTUFUSElFVS0tRFJJRiA8
W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0t
ZHJpZkBidWxsLmNvbSk+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzZdIGludGVsX2lv
bW11OiBFbmFibGUgUFJRIHN1cHBvcnQgZm9yIHBhc3N0aHJvdWdoDQo+ID4gZGV2aWNlDQo+ID4g
DQo+ID4gDQo+ID4gT24gRnJpLCAyMDI2LTA4LTIxIGF0IDAyOjQ0ICswMDAwLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+ID4gDQo+ID4gPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90
IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsDQo+ID4g
DQo+ID4gY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIaSBDbGVtZW50LA0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiBGcm9tOiBDbMOpbWVudCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS0NCj4g
PiA+IA0KPiA+IA0KPiA+IFtkcmlmQGJ1bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1h
aWx0bzpbY2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGJ1bGwuY29tKSk+DQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAwLzZdIGludGVsX2lvbW11OiBFbmFibGUgUFJRIHN1cHBvcnQgZm9yIHBhc3N0
aHJvdWdoDQo+ID4gPiA+IGRldmljZQ0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdl
ZCwgMjAyNi0wOC0xMiBhdCAxMzoyNiArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPiA+ID4gPiAN
Cj4gPiA+IA0KPiA+IA0KPiA+IGVtYWlsDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
IGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiA+ID4gPiBGcm9tOiBDbMOpbWVudCBNQVRISUVVLS1EUklGIDxbY2xl
bWVudC5tYXRoaWV1LS0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
IA0KPiA+ID4gPiBbW2RyaWZAYnVsbC5jb21dKG1haWx0bzpkcmlmQGJ1bGwuY29tKV0obWFpbHRv
OltkcmlmQGJ1bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSkpXShtYWlsdG86W2NsZW1lbnQu
bWF0aGlldS0tDQo+ID4gPiANCj4gPiANCj4gPiBbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZA
YnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbV0obWFpbHRv
OmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSkpKT4NCj4gPiANCj4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDAvNl0gaW50ZWxfaW9tbXU6IEVuYWJsZSBQUlEgc3VwcG9ydCBmb3IN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBwYXNzdGhyb3VnaA0KPiA+
IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGV2aWNlDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gTW9uLCAyMDI2LTA4LTEwIGF0
IDEwOjQ5ICswMDAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IENhdXRpb246IEV4dGVybmFsIGVt
YWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiB0aGlzDQo+
ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBlbWFpbA0KPiA+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSGkgQ2xlbWVudCwNCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiA+ID4gPiA+ID4gRnJvbTogQ2zDqW1lbnQgTUFUSElFVS0tRFJJRiA8W2Ns
ZW1lbnQubWF0aGlldS0tDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBbW1tkcmlmQGJ1
bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1haWx0bzpbZHJpZkBidWxsLmNvbV0obWFp
bHRvOmRyaWZAYnVsbC5jb20pKV0obWFpbHRvOltbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZA
YnVsbC5jb20pXShtYWlsdG86W2RyaWZAYnVsbC5jXShtYWlsdG86ZHJpZkBidWxsLmMpDQo+ID4g
b20pKV0obWFpbHRvOltjbGVtZW50Lm1hdGhpZXUtLQ0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFtbZHJpZkBidWxsLmNvbV0o
bWFpbHRvOmRyaWZAYnVsbC5jb20pXShtYWlsdG86W2RyaWZAYnVsbC5jb21dKG1haWx0bzpkcmlm
QGJ1bGwuY29tKSldKG1haWx0bzpbY2xlbWVudC5tYXRoaWV1LS0NCj4gPiA+IA0KPiA+IA0KPiA+
IFtkcmlmQGJ1bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1haWx0bzpbY2xlbWVudC5t
YXRoaWV1LS1kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwu
Y29tKSkpKT4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzZdIGludGVsX2lvbW11OiBFbmFibGUgUFJRIHN1
cHBvcnQgZm9yDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gcGFzc3Rocm91Z2gNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IGRldmljZQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IEhpIFpoZW56aG9uZywNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiBJIHdpbGwgcmVhZCB0aGlzIHNlcmllcyBlYXJseSBuZXh0IHdlZWsuDQo+ID4gPiA+ID4g
PiA+ID4gdGhhbmtzIGZvciB0aGUgcmVzcGluIQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+IGJ0dywgcmVsYXRlZCB0byB0aGlzIHdvcms6IGhhdmUgZXZlciBzZWVuDQo+ID4gPiA+
ID4gPiA+ID4gdmZpb19kZXZpY2VfZ2V0X2F3X2JpdHMgcmV0dXJuaW5nIDQ3IHdoZXJlYXMNCj4g
PiA+ID4gPiA+ID4gPiB0aGUgaW9tbXUgc3VwcG9ydHMgNDg/IFRoaXMgbGVhZHMgdGhlIGZvbGxv
d2luZw0KPiA+ID4gPiA+ID4gPiA+IGF3IHRlc3QgdG8gZmFpbDoNCj4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiBgYGANCj4gPiA+ID4gPiA+ID4gPiByZXQgPSBoaW9kYy0+Z2V0X2Nh
cChoaW9kLCBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUywNCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBlcnJw
KTsNCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBpZiAocmV0IDwgMCkgew0KPiA+ID4gPiA+ID4g
PiA+IMKgwqAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiA+ID4gPiA+IH0NCj4gPiA+ID4gPiA+ID4g
PiBpZiAocy0+YXdfYml0cyA+IHJldCkgew0KPiA+ID4gPiA+ID4gPiA+IMKgwqAgZXJyb3Jfc2V0
ZyhlcnJwLCAiYXctYml0cyAlZCA+IGhvc3QgYXctYml0cyAlZCIsIHMtPmF3X2JpdHMsIHJldCk7
DQo+ID4gPiA+ID4gPiA+ID4gwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4gPiA+ID4gPiA+ID4gfQ0K
PiA+ID4gPiA+ID4gPiA+IGBgYA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEkg
Z290IHRoaXMgd2hlbiB0cnlpbmcgdG8gbmVzdCBWTXMuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gSSBhbSB0cnlpbmcgdG8gcmVwcm9kdWNlLCB3aGF0IGRldmljZSBkaWQg
eW91IHBhc3N0aHJvdWdoPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIHVzZWQgZWR1IGZvciB0ZXN0aW5nLg0KPiA+
ID4gPiA+ID4gQW4gSSBoYWQgYXctYml0cz00OCBvbiBib3RoIHZtcy4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBSZXByb2R1Y2VkIHRo
ZSBzYW1lIHdpdGggTDEoZnN0cz1vbikgYW5kIEwyKGZzdHM9b2ZmKS4NCj4gPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gTXkgY29uZmlnIGhhcyBmc3RzPW9uIG9uIGJvdGggVk1z
Lg0KPiA+ID4gPiBXaGljaCBrZXJuZWwgYXJlIHlvdSB1c2luZz8NCj4gPiA+ID4gTWluZSBpcyBS
SEVMMTAuMiAoNi4xMi4wLTIxMS43LjMuZWwxMF8yLng4Nl82NCkNCj4gPiA+IA0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+IEluIHRoZW9yeSB3ZSB3aWxsIG5vdCBydW4gaW50byB0aGF0IGNoZWNrIGlm
IGZzdHM9b24gb24gYm90aCBWTXMsIG9uIG15IGVudiBJIHNlZToNCj4gPiA+IA0KPiA+ID4gInFl
bXUtc3lzdGVtLXg4Nl82NDogLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwOjA0LjAsaW9tbXVmZD1p
b21tdWZkMDogdmZpbw0KPiA+IA0KPiA+IDAwMDA6MDA6MDQuMDogRmFpbGVkIHRvIGFsbG9jYXRl
IGh3cHQ6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkIg0KPiA+IA0KPiA+ID4gDQo+ID4gPiB3aGlj
aCBpcyBleHBlY3RlZCBhcyB3ZSB3YW50IG5lc3Rpbmcgc3VwcG9ydCBpbiBMMSBidXQgaXQgb25s
eSBzdXBwb3J0cyBmc3RzLg0KPiA+IA0KPiA+IA0KPiA+IE9oIHllcCwgSSBmb3Jnb3QgdG8gbWVu
dGlvbiB0aGF0IEknbSBub3QgYXR0YWNoaW5nIGlvbW11ZmQgZm9yIHRoaXMgdGVzdC4NCj4gPiBJ
IGFncmVlIHdpdGggd2hhdCB5b3Ugc2F5IHdoZW4gaW9tbXVmZCBpcyBwcmVzZW50LCBidXQgd2l0
aG91dCBpdCAod2VpcmQgY29uZmlnLA0KPiA+IEkgYWRtaXQsIGJ1dCBpbnRlcmVzdGluZyBmb3Ig
dGVzdGluZyksIEkgZ2V0Og0KPiA+IA0KPiA+IGBgYA0KPiA+IHFlbXUtc3lzdGVtLXg4Nl82NDog
LWRldmljZSB2ZmlvLXBjaSxob3N0PTAwOjAxLjA6IHZmaW8gMDAwMDowMDowMS4wOiBGYWlsZWQg
dG8NCj4gPiBzZXQgdklPTU1VOiBhdy1iaXRzIDQ4ID4gaG9zdCBhdy1iaXRzIDQ3DQo+IA0KPiAN
Cj4gT2gsIEkgc2VlLCBJIHJlcHJvZHVjZWQgdGhlIHNhbWUuDQo+IA0KPiANCj4gPiBgYGANCj4g
PiANCj4gPiBKdXN0IHdvbmRlcmluZyB3aHkgc3VjaCBhIDFiaXQgZGlmZmVyZW5jZS4NCj4gDQo+
IA0KPiBob3N0IGF3LWJpdHMgNDcgaXMgd2hhdCBob3N0IGtlcm5lbCBzdXBwb3J0cywgbm90IHRo
ZSBwdXJlIGh3IGxpbWl0LiAgDQo+IEZvciBmaXJzdCBzdGFnZSBwYWdlIHRhYmxlLCBQVF9GRUFU
X1NJR05fRVhURU5EIGlzIHNldCwgIA0KPiBrZXJuZWwgbGltaXRlZCBtYXggaW92YSByYW5nZXMg
dG8gNDdiaXQgZXZlbiB0aG91Z2ggaHcgc3VwcG9ydHMgNDggYml0LCBzZWUgYmVsb3c6DQo+IA0K
PiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHN0cnVjdCBwdF9yYW5nZSBfcHRfdG9wX3JhbmdlKHN0
cnVjdCBwdF9jb21tb24gKmNvbW1vbiwgIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50cHRyX3QgdG9wX29mX3RhYmxlKSAgDQo+IHsgIA0KPiAu
Li4gIA0KPiDCoMKgwqDCoMKgwqDCoCAvKiAgDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgdG9w
IHJhbmdlIHdpbGwgZGVmYXVsdCB0byB0aGUgbG93ZXIgcmVnaW9uIG9ubHkgd2l0aCBzaWduIGV4
dGVuZC4gIA0KPiDCoMKgwqDCoMKgwqDCoMKgICovICANCj4gwqDCoMKgwqDCoMKgwqAgcmFuZ2Uu
bWF4X3Zhc3pfbGcyID0gbWF4X3Zhc3pfbGcyOyAgDQo+IMKgwqDCoMKgwqDCoMKgIGlmIChwdF9m
ZWF0dXJlKGNvbW1vbiwgUFRfRkVBVF9TSUdOX0VYVEVORCkpICANCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1heF92YXN6X2xnMi0tOyAgDQo+IC4uLiAgDQo+IH0NCj4gDQo+IFNv
IHFlbXUgZ2V0cyBob3N0IGF3LWJpdHMgNDcuIFRoaXMgaXMgc3RyaWN0bHkgZm9sbG93aW5nIHZ0
ZCBzcGVjOg0KPiANCj4gU29mdHdhcmUgdXNpbmcgZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24gc3Ry
dWN0dXJlcyB0byB0cmFuc2xhdGUgYW4gSU8gVmlydHVhbCBBZGRyZXNzIChJT1ZBKSBtdXN0IHVz
ZSAgDQo+IGNhbm9uaWNhbCBhZGRyZXNzZXMuIEFkZGl0aW9uYWxseSwgc29mdHdhcmUgbXVzdCBs
aW1pdCBhZGRyZXNzZXMgdG8gbGVzcyB0aGFuIHRoZSBtaW5pbXVtIG9mIE1HQVcgIA0KPiBhbmQg
dGhlIGxvd2VyIGNhbm9uaWNhbCBhZGRyZXNzIHdpZHRoIGltcGxpZWQgYnkgRlNQTSAoaS5lLiwg
NDctYml0IHdoZW4gRlNQTSBpcyA0LWxldmVsIGFuZCA1Ni1iaXQgIA0KPiB3aGVuIEZTUE0gaXMg
NS1sZXZlbCkuDQoNCk9oLCBJIHNlZSwgZ29vZCB0byBrbm93ISAgDQpUaGF0IG1ha2VzIHNlbnNl
LiAgDQoNClRoYW5rcyENCg0KY21kDQoNCj4gDQo+IEJScywgIA0KPiBaaGVuemhvbmc=

