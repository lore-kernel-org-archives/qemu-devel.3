Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343D6C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 18:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb1aI-0001vR-In; Thu, 23 Jan 2025 13:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1tb1aG-0001v1-Sd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 13:05:41 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1tb1aD-0006A1-4x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 13:05:40 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NBhEh6002913;
 Thu, 23 Jan 2025 10:05:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cLqd9ljRA68EMfi5HncZiX3GXrB0ct7ZCu/AHvrDa
 wU=; b=Xlo22zVPd5hvnFj6648AgijNBW9U4G0HsjXjVkfrftYeeLSM6J57sHuiQ
 gtL3P2dfMXWN4SN/p+xdzU3NRPHBiQvG7s10GXIsJSWXddmt256xgPPPaStuuI3w
 nvQ/nbsg5ZLCwPB8PcSIGO4rqUZ9bNaXolQ09lNyrDm1YkZOy7UBdlurbaLG5naM
 y/6EgLg0wZ8eW6T1koxewK9tcqCE9fqs8nLbZVd38Qh+STyza7j0UXxguTY7SAH3
 hhlL7FpxjdVP4WR0mn8ZOmoPdPhOU25In5HbQIRAV9To+d/TbOMmSr5W4gtJu3lc
 h+Y02lfIB3acByBD98oObXqSW0wFg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013059.outbound.protection.outlook.com
 [40.93.20.59])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 448cgemcaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 10:05:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=na9llaQOxj60peiAY7dcxb1IckpgIgsk1vjJP7V7QOXHGMk71lTQcFuc5HT/boQ1JF48bzp1+XptYBmwRpmsEdN1Kyf8eaKychs98vbE9tkejQTKmSaqjlfDGHyvWpLUIhf0mZysu7QR6ej1wJJ0fSTVBxwPQQ8hAzesGLoNz2+8OPbTFzPMhu+9zO300ejhlPHE57HqPgdm5gm/OmO1bk3e5z6y2wgfofYpvUzVXroIitPpCO7lt6BLRPRHXgX9W/7BSRSj1tYUhxlUzzYXsNQVtwm15GIjR9pOOMS1jyY66cD/1/0j8Nb5IwNcDdJIKkNyEiJtErJWsPVZZpCeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLqd9ljRA68EMfi5HncZiX3GXrB0ct7ZCu/AHvrDawU=;
 b=bgmdJEnoTzDaID8dM8id2bXCJNzNKXg6cfRM9vATowhIQC0MI6Lsa2wgsTVE1UyvRF3xS5/gLbPkIVXHMX+fPAr1zFNmMC81sBm5hW0f8AFTGUtwAVQ9Y9fgTIpw5elpUQfZVcp+hkPMXoaEQtbN8I+gyBqxwKKwHwn7ez6wB9D+Xugauxk3Ma1RaOUkSzyANUmrL2LzwMfL6vBeNvuLuyvccoeIctghcnstLIvxkpesQhKqti3TuN6V5ZPHEbs380hB9W9nW8+fU6eurPWejwm87pW2meZCAf6imSKss4+IFHdnNTSE99J63FQclO0tlkILbM1g6S5PxaVPV55ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLqd9ljRA68EMfi5HncZiX3GXrB0ct7ZCu/AHvrDawU=;
 b=hz9VXkvDMvNMOww6MqhlUx9WBwoNROe+ytip0FN6I/KtWaF9/Q+OHbz32HxkaGRRnzYtSEk9Se0tIhgVaDgvU4aZFRuTTvNhBOnCP8XV44zLcU8WuP78erQYWwOvURrtyXuot6BC0WgVSt+McEj7X2kxPi7jn4hbCtysEvshvr9lywCTv0VRZb/jsTKZQP/M646R7MYV9Jvi1jn4kEL7Nvd2rkt7zsuW3OgUJ/ejusmEK5zXxcReD6T9eUuk1OQxmJBM5Ut0yhYgMwnsgdPRsVkJu9P4HdzhkAnYmM0DSsYoF+IEFgKZVu/4+EvlNOjo27p+lLZZNX4mGrUSYQ61gA==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by LV3PR02MB10302.namprd02.prod.outlook.com (2603:10b6:408:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 18:05:28 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9%2]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 18:05:28 +0000
From: Shivam Kumar <shivam.kumar1@nutanix.com>
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] Fix race in live migration failure path
Thread-Topic: [RFC PATCH] Fix race in live migration failure path
Thread-Index: AQHbY0dxbhiAa4q+s0eX0DbBG5ink7MP+z4AgATu6gCADccyAIAAYLEAgAEgmICAAG4hgIAAG2SA
Date: Thu, 23 Jan 2025 18:05:28 +0000
Message-ID: <CA955950-188F-4FA7-9405-D7BBC81EB84E@nutanix.com>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
 <87frlqerxp.fsf@suse.de> <Z4U_emPVDfTb1VmF@x1n>
 <0C92F4E5-56EE-4036-927C-2F06F9F29252@nutanix.com> <Z5EfapuXuV7oFL7A@x1n>
 <35F19D15-7FD0-43D1-B6A0-2FBB5FD9313B@nutanix.com> <Z5Jt434QBy92NnBM@x1n>
In-Reply-To: <Z5Jt434QBy92NnBM@x1n>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR02MB7555:EE_|LV3PR02MB10302:EE_
x-ms-office365-filtering-correlation-id: 3b872bcf-98af-4734-9638-08dd3bd884ee
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R1NBajJnQmFBajlBbEdlMStBOHFMdHgrVEYyUzcwV1dNKzdveWltQ2NsTjNv?=
 =?utf-8?B?Vlo3alpxcVVYbGlZbGFVanFQU3M3MDFYakZhR0RLcFI3dzAvWXlwV0tjOExC?=
 =?utf-8?B?SmQ3b3lzVWV5SHEzUC9YODVkcEc2cTZ6RFkyNnZtNUFiRmJkZTU5K3Jkd2o1?=
 =?utf-8?B?ZnA5RzlYdWEwZXNibUhkUjhOOU54Ky8wWCtCNXdGYnZuRFJlbEFFQWg5ZHR2?=
 =?utf-8?B?YWl2UmhOOWFjMWU2MGFrWnFzUjhyY1NWaHVmczlIZVpRRG1zKzA2c2hidTUy?=
 =?utf-8?B?Z1JrSXpaOHdkcWNNOVBDWTI4S1lkU2NYaVZ0SGtLWnBVQmdLd3pJK3FrcjMv?=
 =?utf-8?B?WlM2a2tBUlRYNnY5aERKYTA1UVBXNlA3WlFGc0Z2SGJXMGpjRXY1bTV1N3ow?=
 =?utf-8?B?Ui9HNUpkNFk3NzBnTXFkOFlzR1dodlRmV0xGN0JDS3ZFT3lHaklWRzh1bEVa?=
 =?utf-8?B?aVRRandtc2poZm5hR1ZMR2NoSE45a1g5cE5GdE1DeGZvMlNMY0E2S2RzVjEr?=
 =?utf-8?B?azY4N1NCN0EwazFhSzRlWDJTWFErbENpMnQxNTVXN1ByNmlXeWZTTHhDbmZi?=
 =?utf-8?B?WU52WmJVVis5cGtONkIyNFBtZ0VrWTRhK2NOSFdlL0UzYWI3UGJ6cHhJVWJo?=
 =?utf-8?B?NXpOSXArWmJsTEVCcWpLREs5TVRQbVBMZi9icmVYcitUd3pwYTRKU0xqa3l4?=
 =?utf-8?B?d05Tb2hmaEdnRnZHNlRjb3E5SFJCSVhaOGp1R2w2NFZOZk9ZQVEwUzZjY0c5?=
 =?utf-8?B?L0xTS3NRL0JUZ2QyUkh0YUFwTjFhTkNhdW1UMm5jcVQ4NDlBQVF4cEtjdGZH?=
 =?utf-8?B?a0dCaFF0Zjd6dTNNN3h3YjZXQ3Uvekp4WCtsaUZ5WmRPa3dPOE42UHlKcmJB?=
 =?utf-8?B?Y1dZMjBzOVJqcHdDdldZMmxuRU1mTzhsSzlmRXZGc2x2VUxDN08rd3NzWFhj?=
 =?utf-8?B?U0t3TFpvQS9uRzlBaFE4RG40S055d1E0SGVpemU0dVhFalV5TVBTaUtkOTUw?=
 =?utf-8?B?ZnJSaXNEOEVaUEVVT3JndzloSU5hbUFTTit1UHlZd2JRYUVZT1FsWHZONi9v?=
 =?utf-8?B?MTAzMGZwUWQ2RS9yQzEyeWRSbEZiM3VaRlVIUzdvcDFXcFNuWEsrQU5GbnB1?=
 =?utf-8?B?a2xIcGJPZHVmOTVsQ0h4YmpOYkRqcnl0ZjBwTmRYUGJURnV5TmNuUXo4N1JI?=
 =?utf-8?B?aGlTeEJrd3F1aVBVcHM2cUlJQmRWTndYSmxJQnd6UHVyTGJoYVBjd1NuUytS?=
 =?utf-8?B?cEhsZXE3a0tPVkh1eGdnKysvSzFGOFdURWJVblVNUHA3UTVBdzBWaGtHenh3?=
 =?utf-8?B?UVpHZE5STU92S1JPbHFucE9pRWlEUVFxWkwzKzk1czcrTmNIUUx1UFdNMUkz?=
 =?utf-8?B?eDl3Uk1jTlBpNmZVcWk3YWROb2ZLalJwOWd5T3FzSzhVaUtQQ1ROUDdrTElo?=
 =?utf-8?B?a05PSGhrMVRGL2JhNmhkakszSmFhOWQvUjYxQ3ZpT1NHdmFBN2cvY2h6M1FL?=
 =?utf-8?B?SHZjc3JDSkxHR3pGSDF5SFNUc1UzRzROKzJDN3VWRnhwWVczMkI1N01rSU1V?=
 =?utf-8?B?c3ExOFRPZzVGQ2tWbVVXTEVjaW9aZ0FQcDVHYVFaS1N1SkE3K3BCc2Rla2Zp?=
 =?utf-8?B?NDRUUW1ndHhEeTUrVWhhdjRoTUc3Mm45MmxJSElkQVBsUSs2RnhpQ25tby84?=
 =?utf-8?B?T2hESWN6ODJqTlAyMjd3bjNsajM5THcyQzZQbFhMTW9IRHk2RndvQnpKSkk0?=
 =?utf-8?B?U1J3c3RWU2dmc2Zxc2wrVGRkYUhtT0NyTU9VZEhaekxnSmJiRjFPSlIzTG41?=
 =?utf-8?B?dDVrZG5Ma1pXWDdLdytTU2NhM2w0bEc0RmhJeldUYTNRWHlmVWZmTTN0NjMw?=
 =?utf-8?B?dUhZSXJ5T0xPZ09CWklSa0VnZytVSlBuSWtvTnRULzlmV0tKY29GM3E5YnNK?=
 =?utf-8?Q?Rit8l3xBNMJc9DL9LII377nYgIYsqvv+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR02MB7555.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZTQ2dCSWhRcHcrQTJRWjU2SnBaRHJ2V0V5ajBybXBUQnBBdzlCaEpjMDRu?=
 =?utf-8?B?UkZpa1A3RWVVTkVkVENFaDdiRHhzTndXUGdDS2dnNTJLQ1VRRFE4MGZKbUlM?=
 =?utf-8?B?d05VdHhhNU1PMk84VTZiL2FkdEFmZXg4STRqb1BQWFZ4SytFRXBrZm9mTG9V?=
 =?utf-8?B?cHRnenJrN1ozTExwSTBJVHpXQUZXdFNtc2RMUklVTFRYMjVlOWU3cHc5aFJs?=
 =?utf-8?B?WUdsVUNMNHJUdTcrV1FQTWdYOFZ2c2xkVFJJVjlqVnJXY3NpQ0lMbXRDQzdX?=
 =?utf-8?B?L0JBSXh6S05hQW03SkpIWmZQcUZpSjRvRnJtVGRiRXZaK0Nxb1ArY1VDLzY5?=
 =?utf-8?B?aFEyVnMxQ2JNdUlsRlhma3h6bFNHa0QwRHVFWTFaVWR1WWFtMHU0L0pXMXhk?=
 =?utf-8?B?dENKVk4ybzh6TS9xQjF3Nkl1Vld4VW5XMnMxMUE0U256bEs4blhiSDdUN3VL?=
 =?utf-8?B?N1JrOHQwUmhCS2VyTmJqTEgwMW8xSHR3cHc0ZWM5QkQ4S3ZpaDFHSnhmekhV?=
 =?utf-8?B?Y3ZtQ3dWdk5VZjIvVlliMEtNYmh5U0UzMzhOeWUwWmN4eW9xNWxPelFXWW9n?=
 =?utf-8?B?djlpa3ZCa0NRMDhEc1lPT3V4MXhCMC93bDk4VlVOQytScCtpdUpwS05LaUsr?=
 =?utf-8?B?K3N5MDFROVA3SmhhSUxoUDV6OHJqRStjanN6WWFsMXlMbDNWVmJNa045aDhh?=
 =?utf-8?B?dWNwd1NqNFNma3Z0a0lSWVpzLzR2RXZCRDFUMU9Cd2NKUkxRQUszK05PcWhU?=
 =?utf-8?B?cytvRENMaHFRV05jblRwRCtsWFFlS0VHQkZFdVRpa3MzUTRpZHVhWXRpMUtI?=
 =?utf-8?B?aUJnMnBjNlpGSi9nbGFNZlJsaVRZUmZtSmh6ajhHSUxhMzZVY0ZjR2pnQmNp?=
 =?utf-8?B?T2VqMGRDcWx4dGlKQ3Z5L0ZQWW04cmFNcG14MndUV1RhcEltUVNJK2V0K1ZE?=
 =?utf-8?B?UXFScVUrSlRjSnk5eTFPcDMzNTBsTGZCcW9SRXlPWGcraW9pOEUyb1FrUnpR?=
 =?utf-8?B?dzV0VTlwL3ZvRStkL1l6ZHBHUk5SQVliRi9Ld1BPL0lvRm9zZUhZVmNIekVC?=
 =?utf-8?B?RURKcEVCRnBSTkZDNTJkY0laTlBYOEZnaDZlMFdib0R0b0hLYjhta0llZy9j?=
 =?utf-8?B?OTJ4OVBybUVmemlBd2R3Ynd0YVlraDJXZ2hMMDkzaU1DSHhaZ2kxeFBBRGJR?=
 =?utf-8?B?aFJRUGtYcnhXZmhmdVJOWlFBL0tIOTNCU09zdkpKSmY5Y2VGaVNnZHozVFZv?=
 =?utf-8?B?OHZQWVZKRUUyY3NtdmQ4YWxCUU5SL2tkNzFjSVp4QTFWMmpvY1o5V0xsL0VB?=
 =?utf-8?B?WUJBMTN6elF5aTc4YlpqMkRMUytmdnY3bG5WczBPSklJejkrMlIvVDZJWFBM?=
 =?utf-8?B?SjFqMVhUUTUzOFEwUmI2ZlNzMWFhbWVKclh5M3RKdkYxTm5URGdMUmRLTjUr?=
 =?utf-8?B?ZUpyN2xCdGFpK0tVaVJLM3d3Z2c5NW5UQmhmcnFPOUJGc0U3NURKRXpBSGtM?=
 =?utf-8?B?SzBkaE1oMHNHTW1CeHJpWllqTG1WeEg3RmxpcXFlQmhnUWFEanpmVDJlMzRP?=
 =?utf-8?B?QTRmdEtvWFRJVHZJRHZNUzhQb0NxbUZyYkllTnJhR0RTOFM0Nzh4VzF6SlZX?=
 =?utf-8?B?cFh3c3RTbVpuQll6NnBuUlV0T0ZRbGpjRHB4NVFvVUZYN2FYNFJHNlkxZE1H?=
 =?utf-8?B?VDFrbzB2SEdpRC9qN1gyenluZUZNSXpIdkY0RUgyNkFiYnhIcDYwbmpjTVQz?=
 =?utf-8?B?UHVtNXlxcGNvOWo5MHRObG9ud2I1QWxqQWs5QlNsUWwvUUJjclpCNlU5VVZT?=
 =?utf-8?B?REF4VnJMWmlmQ0gxVEt2NGh3cGYrdVdxMmFXYlM1MVN1N1dSblJURks2NWFa?=
 =?utf-8?B?WEdTL0puWnJwMXVwNXl0SnMzeURJOWRVZVU5RkRSZUlkK20vV0pGcDgzMzR1?=
 =?utf-8?B?U0VqREFQUVYyUFU2TVFmZ3dIcDRvdVowNVh6bWNVcmRqNC9ySGEvSHNIQy82?=
 =?utf-8?B?aUZja1Q3L1BkaFdpVGVRdUY3VSs4R1VFK0JsY25rUnlGQ2NkMSthalN6dUJv?=
 =?utf-8?B?ZW0vQ2x1cTE5KzNOQnlGYmM5USsxSnFHbVFoS0p0M2kwRmFlbEJsWmY3NS93?=
 =?utf-8?B?WHh6bllNWUJXT0t2NlFXb3JDTDVhTEltcUxnVi9OYmdHWTJLenNJd3kzZ0RH?=
 =?utf-8?B?dUtIRFcxWXA0L0EyQmt2UTdIaEFrWG9QaW1idDRjdFB2SS9pZ0Y2M0ZIL045?=
 =?utf-8?B?T092M0ViL0FBc0x6cjQ3OEY2UFRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <448A5E2C758D5449B77E07E2C48A6AE0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b872bcf-98af-4734-9638-08dd3bd884ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 18:05:28.5590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Wq1sKhAA47JtioNG+0CtCh2WyKAd5Zsq/zbgUPOHXy5SNmUHhKGgs+mxgAlwIJvpmGTL2Tnccg1MqWfG6YQPGyhDiwrATaTieBETrSZaTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10302
X-Authority-Analysis: v=2.4 cv=Kvm32XWN c=1 sm=1 tr=0 ts=679284eb cx=c_pps
 a=rrMtUIbNwx6LnGB7sifIYw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=hmxowieGlSmq6giR9h0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: moKPFtugc-Teg3jaEMPBGYNHCp5Fmo5F
X-Proofpoint-GUID: moKPFtugc-Teg3jaEMPBGYNHCp5Fmo5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=shivam.kumar1@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gMjMgSmFuIDIwMjUsIGF0IDk6NTfigK9QTSwgUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjogRXh0ZXJuYWwg
RW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gVGh1LCBKYW4gMjMsIDIwMjUgYXQg
MDk6NTM6MTZBTSArMDAwMCwgU2hpdmFtIEt1bWFyIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiAy
MiBKYW4gMjAyNSwgYXQgMTA6MTDigK9QTSwgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPiB3
cm90ZToNCj4+PiANCj4+PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4+PiBDQVVUSU9OOiBFeHRlcm5hbCBFbWFp
bA0KPj4+IA0KPj4+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPj4+IA0KPj4+IEhpLCBTaGl2YW0sDQo+Pj4gDQo+
Pj4gT24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgMTA6NTQ6MTdBTSArMDAwMCwgU2hpdmFtIEt1bWFy
IHdyb3RlOg0KPj4+PiBUaGVyZSBpcyBvbmUgcGxhY2Ugd2hlcmUgd2Ugc2V0IHRoZSBtaWdyYXRp
b24gc3RhdHVzIHRvIEZBSUxFRCBidXQgd2UgZG9u4oCZdCBzZXQNCj4+Pj4gcy0+ZXJyb3IsIGku
ZS4gaW4gc2F2ZV9zbmFwc2hvdCB3b3JrZmxvdywgcGxlYXNlIGNoZWNrIHFlbXVfc2F2ZXZtX3N0
YXRlIGJ1dA0KPj4+PiBub3Qgc3VyZSBzZXR0aW5nIHMtPmVycm9yIGluIHRoaXMgY2FzZSBpcyBw
b3NzaWJsZSAob3IgcmVxdWlyZWQpLCBhcyBpdCBzZWVtcyBhDQo+Pj4+IGRpZmZlcmVudCB3b3Jr
ZmxvdyB0byBtZS4NCj4+PiANCj4+PiBZZXMgaXQncyB2ZXJ5IGRpZmZlcmVudCBpbmRlZWQuICBJ
IG1heSBub3QgeWV0IGZ1bGx5IGdldCB0aGUgY2hhbGxlbmdlIG9uDQo+Pj4gaG93IHN3aXRjaGlu
ZyB0byBzLT5lcnJvciAoaW1wbGllcyBGQUlMSU5HKSB3b3VsZCBhZmZlY3QgdGhpcyBvbmUsIHRo
b3VnaC4NCj4+PiBJIG1lYW4sIGluIHFlbXVfc2F2ZXZtX3N0YXRlKCkgaXQgdHJpZXMgdG8gZmV0
Y2ggcWVtdWZpbGUgZXJyb3JzIHdpdGg6DQo+Pj4gDQo+Pj4gICByZXQgPSBxZW11X2ZpbGVfZ2V0
X2Vycm9yKGYpOw0KPj4+IA0KPj4+IElJVUMgd2UgY291bGQgYWxzbyB0cnkgdG8gZmV0Y2ggcy0+
ZXJyb3IganVzdCBsaWtlIHdoYXQgbWlncmF0aW9uIHRocmVhZA0KPj4+IGRvZXMsIGFuZCBpZiBp
dCBzZXRzIG1lYW5zIGl0J3MgZmFpbGluZz8NCj4+IFllcywgSSBjYW4ganVzdCBzZXQgcy0+ZXJy
b3IgaW4gcWVtdV9zYXZldm1fc3RhdGUuDQo+PiBAQCAtMTY4Niw3ICsxNjg2LDYgQEAgc3RhdGlj
IGludCBxZW11X3NhdmV2bV9zdGF0ZShRRU1VRmlsZSAqZiwgRXJyb3IgKiplcnJwKQ0KPj4gLSAg
ICAgICAgc3RhdHVzID0gTUlHUkFUSU9OX1NUQVRVU19GQUlMRUQ7DQo+PiArICAgICAgIHMtPmVy
cm9yID0gKmVycnA7DQo+PiBCdXQgbXkgcXVlc3Rpb24gd2FzOiBpcyBtaWdyYXRlX2ZkX2NsZWFu
dXAgY2FsbGVkICh3aGVyZSB3ZSB3aWxsIHNldCB0aGUgc3RhdHVzDQo+PiB0byBGQUlMRUQgaWYg
cy0+ZXJyb3IgaXMgc2V0KSBpbiB0aGUgc25hcHNob3Qgd29ya2Zsb3c/DQo+IA0KPiBJIHNlZSB3
aGF0IHlvdSBtZWFudC4gIEl0J3Mgbm90IGNhbGxlZCBpbmRlZWQuIFdlIG1heSBuZWVkIHRvIHBy
b2Nlc3MgaXQNCj4gdGhlIHNhbWUgYXMgd2hhdCBtaWdyYXRlX2ZkX2NsZWFudXAoKSBkb2VzLg0K
PiANCj4gU28gZmFyIHRoZSBzbmFwc2hvdCBjb2RlIHJldXNlcyBtaWdyYXRpb24gY29kZSBpbiBh
IHBhcnRpYWwgd2F5LCBzbyBpdCdzDQo+IG5vdCBjcnlzdGFsIGNsZWFyIHdoZXJlIHRoZSBsaW5l
IGlzLCBlLmcuLCBvYnZpb3VzbHkgaXQgc3RpbGwgbW92ZXMgdGhlDQo+IG1pZ3JhdGlvbiBzdGF0
ZSBtYWNoaW5lIGJ1dCBpdCBuZXZlciBzaG93cyAiYWN0aXZlIiBwaGFzZSBhdCBhbGwgKGV2ZW4g
aWYNCj4gaXQgaGFzIGEgbWFqb3IgY2h1bmsgb2YgZHVyYXRpb24gdGhhdCBpdCdzIGFjdGl2ZWx5
IG1pZ3JhdGluZyB0aGUgZGF0YSB0bw0KPiB0aGUgc25hcHNob3QgZmlsZXMpLiAgSGVyZSB0aGUg
c3RhdGUgbWFjaGluZSBvbmx5IGdvZXMgZnJvbSBTRVRVUCB0byBlaXRoZXINCj4gRkFJTEVEIG9y
IENPTVBMRVRFRC4NCj4gDQo+IEZyb20gdGhhdCBQT1YgbG9va3MgbGlrZSB3ZSBzaG91bGQgZHVw
bGljYXRlIHN1Y2ggcy0+ZXJyb3IgZGV0ZWN0aW9uIGxvZ2ljDQo+IGhlcmUgb24gZGVjaWRpbmcg
d2hldGhlciB0byBzd2l0Y2ggdG8gRkFJTEVELCBpZiB3ZSB0cmVhdCBzLT5lcnJvciBhcyB0aGUN
Cj4gaW50ZXJuYWwgInNpbmdsZSBmYWlsdXJlIHBvaW50IiBmb3IgbWlncmF0aW9uLg0KSSBob3Bl
IHNldHRpbmcgdGhlIHN0YXRlIHRvIEZBSUxFRCBhdCB0aGUgZW5kIG9mIHNhdmVfc25hcHNob3Qg
bWlnaHQgd29yazoNCi0tLSBhL21pZ3JhdGlvbi9zYXZldm0uYw0KKysrIGIvbWlncmF0aW9uL3Nh
dmV2bS5jDQpAQCAtMTcyMiw3ICsxNzIyLDcgQEAgY2xlYW51cDoNCiAgICAgcWVtdV9zYXZldm1f
c3RhdGVfY2xlYW51cCgpOw0KDQogICAgIGlmIChyZXQgIT0gMCkgew0KLSAgICAgICAgcWF0b21p
Y19zZXQoJm1zLT5mYWlsaW5nLCAxKTsNCisgICAgICAgIG1pZ3JhdGVfc2V0X2Vycm9yKG1zLCAq
ZXJycCk7DQogICAgIH0gZWxzZSB7DQogICAgICAgICBtaWdyYXRlX3NldF9zdGF0ZSgmbXMtPnN0
YXRlLCBNSUdSQVRJT05fU1RBVFVTX1NFVFVQLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
TUlHUkFUSU9OX1NUQVRVU19DT01QTEVURUQpOw0KQEAgLTMwNTQsNiArMzA1NCw3IEBAIGJvb2wg
c2F2ZV9zbmFwc2hvdChjb25zdCBjaGFyICpuYW1lLCBib29sIG92ZXJ3cml0ZSwgY29uc3QgY2hh
ciAqdm1zdGF0ZSwNCiAgICAgUnVuU3RhdGUgc2F2ZWRfc3RhdGUgPSBydW5zdGF0ZV9nZXQoKTsN
CiAgICAgdWludDY0X3Qgdm1fc3RhdGVfc2l6ZTsNCiAgICAgZ19hdXRvcHRyKEdEYXRlVGltZSkg
bm93ID0gZ19kYXRlX3RpbWVfbmV3X25vd19sb2NhbCgpOw0KKyAgICBNaWdyYXRpb25TdGF0ZSAq
bXM7DQoNCiAgICAgR0xPQkFMX1NUQVRFX0NPREUoKTsNCg0KQEAgLTMxNDksOCArMzE1MCwxMyBA
QCBib29sIHNhdmVfc25hcHNob3QoY29uc3QgY2hhciAqbmFtZSwgYm9vbCBvdmVyd3JpdGUsIGNv
bnN0IGNoYXIgKnZtc3RhdGUsDQoNCiAgdGhlX2VuZDoNCiAgICAgYmRydl9kcmFpbl9hbGxfZW5k
KCk7DQotDQorICAgIG1zID0gbWlncmF0ZV9nZXRfY3VycmVudCgpOw0KICAgICB2bV9yZXN1bWUo
c2F2ZWRfc3RhdGUpOw0KKyAgICBpZiAobWlncmF0ZV9oYXNfZXJyb3IobXMpKSB7DQorICAgICAg
ICBtaWdyYXRlX3NldF9zdGF0ZSgmbXMtPnN0YXRlLCBNSUdSQVRJT05fU1RBVFVTX1NFVFVQLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHUkFUSU9OX1NUQVRVU19GQUlMRUQpOw0KKyAg
ICB9DQorDQogICAgIHJldHVybiByZXQgPT0gMDsNCiB9DQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8N
Cj4+IA0KPj4gSSBtZWFudDogaW4gY2FzZSBvZiBwb3N0LWNvcHksIHdoYXQgaWYgd2UgaGF2ZSBh
bm90aGVyIGVycm9yIHNvbWV3aGVyZSBhbmQNCj4+IHMtPmVycm9yIHdhcyBzZXQsIGJ1dCB0aGVu
IHdlIGFsc28gc2F3IGEgZmlsZSBlcnJvciB3aGVuIHdlIGNhbGxlZA0KPj4gcWVtdV9maWxlX2dl
dF9lcnJvcl9vYmpfYW55LiBJbiB0aGlzIGNhc2UsIG1pZ3JhdGlvbiBzaG91bGQgZmFpbCBJTU8g
YnV0IGl0DQo+PiB3b3VsZCBiZSBwYXVzZWQgaW5zdGVhZCwgcmlnaHQ/DQo+IA0KPiBZZWFoIHlv
dSBnb3QgYSBwb2ludCwgYnV0IEkgc2VlIG5vIGdvb2QgcmVhc29uIHRvIGNhbmNlbCBhbnkgcG9z
dGNvcHkNCj4gbWlncmF0aW9uLCBubyBtYXR0ZXIgd2hpY2ggZXJyb3IgaXQgaXMgLSBlaXRoZXIg
YSBxZW11ZmlsZSBlcnJvciBvciBhbm90aGVyDQo+IC0gc2ltcGx5IGJlY2F1c2UgcG9zdGNvcHkg
Y2FuY2VsIG1lYW5zIFZNIGNyYXNoLiAgVGhlcmUncyBub3RoaW5nIHdvcnNlDQo+IHRoYXQgdGhh
dC4uDQo+IA0KPiBTbyBJTUhPIHdlIGNvdWxkIHRyZWF0IGl0IHRoZSBzYW1lIGFzIEVJTyBlcnJv
cnMgaW4gdGhpcyBjYXNlIGFzIG9mIG5vdywNCj4gYW5kIHdlIGFsd2F5cyBwYXVzZSBwb3N0Y29w
eSBubyBtYXR0ZXIgd2hpY2gga2luZCBvZiBlcnJvciBpdCBoaXRzLiAgQXQNCj4gbGVhc3QgZm9y
IG5vbi1yZWNvdmVyYWJsZSBlcnJvcnMgd2UgY2FuIGhhdmUgc29tZSBhY3RpdmUgcHJvY2VzcyB0
byBsb29rDQo+IGF0IG9uIHNyYyBRRU1VIGluc3RhbmNlLCBPVE9IIHRoZXJlJ3Mgbm8gZGlyZWN0
IGJlbmVmaXQgZm9yIHVzIHRvDQo+IGRpZmZlcmVuY2lhdGUgZGlmZmVyZW50IGVycm9yIGNhc2Vz
IHRvIGNyYXNoIFZNIGVhcmxpZXIuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAtLSANCj4gUGV0ZXIg
WHUNCj4gDQpZZXMsIHRoaXMgbWFrZXMgc2Vuc2UuIFRoYW5rcy4NCg0KVGhhbmtzLA0KU2hpdmFt

