Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18072C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRc-0007yL-4p; Tue, 02 Jul 2024 01:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRa-0007xs-PG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:46 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRX-0006TL-KH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899565; x=1751435565;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=K6mzCmicblBSrH+FNCrs3vX9tZhbIalc3GmnTb6vzms=;
 b=kaP9EHUfPELJrIW/+6Z2m44M2UwMQHqRLe6/MIAFuqOOwsupJHI/PH7U
 F/PLVZQu0Dx37E2E2FcJlYLvziDYM+2RgNT3Lv1UmX8HnHrRPXAy3AvFX
 Bktx4ju5tAh2ft1eV9e/iRyII6jJlD+TqsRfZ8iWbH2zTyGkVzbaAvQZz
 OSWqwPQFrErRxn9WXiIbHiYSgg0OSqPz8tJ2AKiFO4nU05YbJ8s/7oneb
 UXnxHicGIvRY5SY4pMipDxmQJ5x0f561L9Qe6BzXztFn229DBsXjN3shH
 Txnv92Lt8f42pkYyizdPTcCNGJS5qMgqjD/GMBz6Ib9s09WPFZ/dG8jXR g==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15715678"
X-MGA-submission: =?us-ascii?q?MDHgLr/retlpPHDf5X6gpbxnJbSyBiK4I7cQdp?=
 =?us-ascii?q?1t68ZPrrC2xFpC3SOEfGn7D9O2CfA/ad1u+m/SjQTDK40uAlOzEzA4Sz?=
 =?us-ascii?q?oOP8hvKLxQ6OqvW53il2NVifDvKJ4H2pTfgR4Au8ZKfV5AduCDPA96uN?=
 =?us-ascii?q?8WsZJx8htw0qH9e1CSKcnySg=3D=3D?=
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.113])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:44 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCS1I2iMJ4CO0U8kVbiaH9Kj7oVKelKupTou8bzJ3ywCHIjkkvBcOEAr0NR2hWcpvhZFBr81x2Y4m4MemwtH4pbp3fzEKGB0f4KgT4p83vEsCRoqbLU53WlNHmyyhZoT1o7Mknm68YQL3PAkRg8LPNknmPSk+iA9JABdOIld+SFl+PZRR6S4dcrEJiq+Dm+KHDAGUXL3Zs2frsmwQ1gw+m3xqUzukr+dQOLgPc+7PqlM7Oe28OOzlUZvtagLnN15bc2GVIflnBk7kSVYMNjywAn8+9LkMDHUZOKmBsqxIvStBEOL1Fjz+DjRihu1iLZ11RKa3qlEQsqTUuzlPs1ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6mzCmicblBSrH+FNCrs3vX9tZhbIalc3GmnTb6vzms=;
 b=MIHPIVthm5+VcUMY1pWwXUvxgc2E3jd/ypxA/u+a+CWZEU0LKNVBv2V/M8egGYG17NE+6n/i8xUpJJ6CYtwgqTfktV2PJ2tU94sMuj2WyrL/d69/BtrCYEk9TfrDguDuuRwkOCCNLRabYoHtnFjr52jhBGr0Zkynj1pAThM3i1zQr4C0i+MY7Lf16YFmO2DATU7sBtIItClfMgrwq/uxqEl5vdE5YrZvhxkGuE3VZ39WvN2NuH3/PHUYVYWUDTZvqZ/g9yOv5Hd4SMINID1c30CovOgBQR63hxiXKekpxAW/DlYoZA7ISZHfuSK667Q36T6lJZ+53/meSzu/RQBmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6mzCmicblBSrH+FNCrs3vX9tZhbIalc3GmnTb6vzms=;
 b=lYr2hSvXE8dS3tViqPY2fTwdKM8s3/i2IedljZ2cXgpO5Jw8L6s6DmkHGTdUfQZWC3PwpyaxVhEsSwLTsrGbUX9Cs9rTcaaTLpedX1aWmJNnqzf9LYlI2JY4W25p8Lb7qrMZLSeHzVqMy3sGvwSSqS4GeHoD6178LIRoXLc6dloMBsZuETwarNuJEZb9EfaggEfzy4NOIVcEWZgrihgnW2obccLVtWQToa2yqoL89bT1RzY+g6y4khRkXqCsZf1Q/CZhC+H2SX/neOL1Zvy1i5Ex/GyzeGic/iF5K5i/ifP0f+EVlW+s8Jqj4WYjHqwb6MtQ3RKyvSUfwL9s1kyx5A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 15/22] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v5 15/22] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHazEQNjcnQQpm5JkC8kevAoXdYEA==
Date: Tue, 2 Jul 2024 05:52:41 +0000
Message-ID: <20240702055221.1337035-16-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 9c80b53b-74f7-4e16-41ba-08dc9a5b2ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tm82Y1VORTEwRHl0KzBDalpSeEgyWnhtY1BwcVlTM0lYeDk3eHhVa2ZlRHFM?=
 =?utf-8?B?ckl0V2VsY29rNmlVVUgwc2YwcWtDOUllTzkvcis3RDhlcm5FZU9sbHR0VFBS?=
 =?utf-8?B?RVpxcFVTTEdtUmpJRElOUTNXVVh2UFBWNEhaSmNjZTRKajdTc2ltTVFUeEZS?=
 =?utf-8?B?YnRYNUYydmhGRmZGK0ZkODl0L0V2d2huMDhHZitZc0VnMFl4L2NvUTJnVGho?=
 =?utf-8?B?UGo4NityaEljSEVwcUpsQzk3K3JudHdhbkZlUXI0dlpaUlA4VjhjS0ZWOXkv?=
 =?utf-8?B?ckt0U3RpTkltMTRIVHlvaGg2YnVlMUZmRWxpSkJ4MDhlZFNucFZQVXppYmdt?=
 =?utf-8?B?ckh3WWREVlpROXYvbmtkdStXKzlJRjZFa3pYcHJGSEwzMEV5NHp0RzRkVnpu?=
 =?utf-8?B?d3ZyNmhKdE5VUElvU3BkKzFrK3JiSUdkTVZ6SE1HY3RzSThHZHhYS3NKT1o1?=
 =?utf-8?B?UTBpS3pQelp6OGZaSGZIZzNjVHBhZjdLNGZ1dzJsdm4yMDUyTUEwb2x0S0Ro?=
 =?utf-8?B?d1IrZjRMSUlub2RDR05QMUpPa2RETWFBWHp5UFVCM0lkSGFLeENVNkNBTzNl?=
 =?utf-8?B?UkpCbW9UbC92cUFGM3RnTVVkemNoZ2YraXZZWnZpYkxIRVUrQWcwYXI4MW0y?=
 =?utf-8?B?UDZqOEZISFVmTW4rUGROZ0J5SjR2VHBrNllZdlM1ZDVHa2NDeGpLc1JmTy9u?=
 =?utf-8?B?NGpSTytBRnk2OGwzdDFwQUFHa0ExOVo1U2xPZHVZUVZWdDZHcUVCR1BXM3FP?=
 =?utf-8?B?NTVLak9NVVF1Mkt1dEhTUmNYS0srLzIxWEZrUVJVWXhqaTZ2WkEvdHJuMnI0?=
 =?utf-8?B?Q0xiMTMwTk9iZ3hiR3RkSkNnbUJvWSs5TEJEdzUwaGRnL2FXZExlSHNhVFRy?=
 =?utf-8?B?RU85SWwxSS8wYlQrUWlUbmcvZlBVSm9kcTRGMDF3UWh1Mlc2NGNqZ05SMldw?=
 =?utf-8?B?dlZSYXAyS3M1eHJjS0lDVTNPNFpHdmc2TEM3QWU1ak5OTjZDekNvejhGKytK?=
 =?utf-8?B?UDhjVWxpTDhRMmZXSlkzYjI3emNNSEZuMmhORmxaVDg4VExOeXhJdlBqeXA1?=
 =?utf-8?B?dnN3eGxZSGpseVhQT2E3WVo0VFhBclRkaUxLR2prOW84eFQrWXVzZTloZ2ta?=
 =?utf-8?B?TC9sTlhGdUZBVXVMckNoV2pvWVVQaS9VaDNPSlBVVWY1c0dBTFJVaXFJQnFR?=
 =?utf-8?B?cUlaMXNEWmd5TGZDeU9nNnVlUU0yMXEyWXBRQVNQMyszOGpDUGpIYzkzeWJr?=
 =?utf-8?B?d2g5aHhsSVZWUy91ZGE4U0VVS3VkT3RoQm5CanR0SThCNFlsK3NHVkljL2tC?=
 =?utf-8?B?MXhWd1g5b2pycFJLWFZsUlQrdXFld1ZQYWtLcXhaSWxzV1hCYzBWcUlVaW94?=
 =?utf-8?B?ZFE1TU53VjRWajJXc093YitiYlJBdlBUck5GNEl6Rk9FbURaRjh1Y3p4T1Nw?=
 =?utf-8?B?WnJOd2lWc0JzY3dCUkYrVUwzcFdLM1lxQkVHMTVxR3dObVV5YTg0Q0VTL0Rm?=
 =?utf-8?B?bzBRRk1zT2RUYkV0dk8yb0R2enBsck5wTXdhZGRIRkFhVm5ObTIrVjNra2lM?=
 =?utf-8?B?c3hZTDRJUWYrMnJ3bmh5Y2lKeFB2MGYzR3phM1hzQ0lxeXU4UC9KRUh3bE16?=
 =?utf-8?B?WHhLL1RBOGZ4QitXMmFRbHBrYXlvZ1NpMnJPbnlBSzBGYUNpR2Y1cXplcndy?=
 =?utf-8?B?QXhRWWJaUjQycUp1REpFUVBoYnpMTmxNRzJFcGZlNE11Z3JjZGh6U3ZGWEt5?=
 =?utf-8?B?YzZRT0I4c2hONkVINzVESFJGQWFPcFg3V3hyQ2tsczNmWFYzTGJiSjZHRC8x?=
 =?utf-8?B?Zk84MHh4YkRucmF3d3RjVHcwWVEzRkg1dnJjVWIxb1YvU0o4Q2orM2NBalRQ?=
 =?utf-8?B?SXppZ2R5ZWUxYURLMnRxMURJS0pUblJHM1ZsSWI5dWYzYXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZitKSEJCUnJyN09KcG1yKzVRQm93RlZwTk9GeHVaaTJpcTZDY003R1VZV2xF?=
 =?utf-8?B?OWtmTFowOGtWNzBYRnY4YzI3SVl4RHBSeWh1SDJHNzR2TUNnRXo4R1FvTnQ5?=
 =?utf-8?B?Y0tSSWhia3I1WlZOM1ZvRkQ4UjlhczRDd095clU2aFBmczR0dTgxa1M2WGYw?=
 =?utf-8?B?RWRTWE81aTlWMGNvZ0RxbnpGQXBscWlSSEF5SFVDZ3lxUzZMWU9ZTDlZdEZm?=
 =?utf-8?B?c1FFOWZzN0I5cWVyazFUcUY0RllQL21haGR1MTBTVU9TSG9ldWx6TmJTK2c1?=
 =?utf-8?B?N3ZISGEvUUxZMVhQODlEKzh1ZDF2QkdzTjF1ZngzU3JjZ0pDc1VWQ0NOeFFi?=
 =?utf-8?B?SFZPNVlHMUcxYXJxSDFqZ2IyME9KMUg1U0hwV3VDYWh3eUlSZEUxY3BuY1Ir?=
 =?utf-8?B?cWt6VXdMOUd2STRkVkNka1YvTFVNeHgvdWdCTWFTcnBXRk1BNWNTR2ttQWgv?=
 =?utf-8?B?dTdpK2Fhc0Q3ajNHemtWdVlDdjl5Wkt1M3N4Q0tUU3JOamIzVjY0OUtYK1p6?=
 =?utf-8?B?USt4cjdoZXZsOU9pOHlmcVJrMWJVT3MrSXAxSG1wdWdSam5rNUVHQXljSG9h?=
 =?utf-8?B?dEg1ZnBGbFFtTUJQbG5mNXVZZklPSzg1UHVQT09TLytqaW1PVkxPQ3d2L3Zj?=
 =?utf-8?B?M0NsZm5UZ1NsZmlIMWhlNTZhTU1UMlhnQTRXVnlIdGx0TFlGQ2YxVWxMWGw2?=
 =?utf-8?B?MFZYUE5YZkhYZkNGRlJCWUJQSEJGcHRUbE8yTklSQlJEOG5WZXNRUTRadzFJ?=
 =?utf-8?B?cFZoaGlUbzd6ejRyWDlTNXVDMyt6N0VobVVza3h0MTJHb2xkd3Rla3V6cjVG?=
 =?utf-8?B?amE2TmVrT2diQXBOZFBXZjZRUjZMdTUwUmtkZE8xOE05NXpPOHVGRmVSaVc2?=
 =?utf-8?B?UGtWdjh0ajBOVktNdVgyNFlqSWF6QUhidXRHNGttR2Z4M0h0Lys5WGNrbnF6?=
 =?utf-8?B?VnJJOVphRXo0SVI0eUVVMUxTa0s3c01wcmNhdG9hMXNJUGgxZVFWZmNvQmVk?=
 =?utf-8?B?QU5rMmo3TXg1SmE0dWFNeXhUdENtM1ZvbjBGaCtLeFAxYjBwc3ZudnU1bTRy?=
 =?utf-8?B?ajdJdjR0c0FTRUQ1bTNUZzhpSnFiM3ZUSkxWTU1mMHpDdHN0V2FDMVZBem0w?=
 =?utf-8?B?SnIzbmxIdXVBM1dlZUdKWG5hTHMwUHRxb1lkTEg5azFHS1cycDZLbDNTN0pW?=
 =?utf-8?B?VW1DTGk4ZEV2aHdWWHc2R2V0NnR0QWtpSWpMd0R0dnRjK1BkWkxtWEFSdG5m?=
 =?utf-8?B?cjd1ZHFIUTRHdHh1dlZIajdXRnhGeU5XcmFldmNZeVZaNzBmMSsvMGFGTytV?=
 =?utf-8?B?b0M5YWZOQ3prQk1KU3RzdTBUK0xKUUhpSnA5SHFWZHlUUUtmOGttdXozUDdC?=
 =?utf-8?B?L3FqZUtnVW9nbi9aUUtvUmJoNjYyOHZQWGxMUDF3K3hkUFE5N0JwVk4raDBi?=
 =?utf-8?B?OGg0TlZuZjY1eGt1TDlrQVpjOWV5Q09YeWo1eWtlcEpZT21UZ0RjbXRIeXBi?=
 =?utf-8?B?ZXd3U2d0c2ZiYUFKajFBQTl4c1lBYmhDYWRKSVRTbmllUE56YzdQcVluVVJR?=
 =?utf-8?B?SGRCbm9rU01Mb2x6TXVOSGF6VHUrSjNKL0Nsd3Ywa2MycU0yejE3ODBnZExx?=
 =?utf-8?B?cXVoYlJzZXVKNXhKWWxsd3R4Q0p2cWUzcFlLcXA4Q3hWdTVkS1Y0eHk2OEtB?=
 =?utf-8?B?d1dtRmVPMmJWOUo5UitxR2t0dnhaREFhcVlqbUlpa0RrdGVxeVhOQTE0WkxE?=
 =?utf-8?B?NlVvSVp4N0lLV2ErM3lvZnVRQmxuY2d0cFZ2b1BnWWdxTjR0RTJ1ZVVOaWhX?=
 =?utf-8?B?VkFmMFFmbExncXpNMVFJQkxsZ21sZEVBd2RFUXFNWEFFRUdRdDAvOXV2SGFX?=
 =?utf-8?B?MVorR1hmT2d0RzFnejN5T1E5Z1o1SjYwMVBIZlRLcGpaRlpPQ24xcmk0RkJF?=
 =?utf-8?B?a3YwOFRhV3Y3R1YxMzdRYXRuVlNZMzJ6L2VIcUpJY29pcHdIVURERDFPdmNo?=
 =?utf-8?B?SFh2T0R1MXk3T284b0FWdUVHUWo4ZTlsZWVWNk4vNUpJZFBxaU1lcXBKb0NM?=
 =?utf-8?B?dXEzZkRPR2ZYcGtlSEkwMThuVVVxeDhPMTd6MmZiYU80N01zOXVVejRrYXVp?=
 =?utf-8?B?YmYrS3c1RzJTQjBtWnNSOVJ3eEVyK0tkQ1BxMVYvWk1DMVlERTRzT2VIWVNy?=
 =?utf-8?Q?5jAWCuisAl9UBuq34VuMOZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E616EED406235043AC1563D2D0BDFEE2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c80b53b-74f7-4e16-41ba-08dc9a5b2ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:41.7249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBQCLJJChzkZQ9tJs52StG1lo0dTFe39D90u2MOrC0p1YRFEbfQj282SASwgu8269IbGeeo8iVi7IFectaV/21wLImZOJcKmRS+PU4rz4f+bEfI5+guXhzcDnGMwIXSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoaXMgd2lsbCBiZSB1c2VmdWwgZm9yIGRldmljZXMgdGhhdCBzdXBwb3J0IEFU
Uw0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCB8IDEgKw0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
eGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQppbmRleCBiZjkxYzRiZWQ3Li4w
MDNlZTA2NjEwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNs
dWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0xNDUsNiArMTQ1LDcgQEAgc3RydWN0IElPTU1VVExCRW50
cnkgew0KICAgICBod2FkZHIgICAgICAgICAgIHRyYW5zbGF0ZWRfYWRkcjsNCiAgICAgaHdhZGRy
ICAgICAgICAgICBhZGRyX21hc2s7ICAvKiAweGZmZiA9IDRrIHRyYW5zbGF0aW9uICovDQogICAg
IElPTU1VQWNjZXNzRmxhZ3MgcGVybTsNCisgICAgdWludDMyX3QgICAgICAgICBwYXNpZDsNCiB9
Ow0KIA0KIC8qDQotLSANCjIuNDUuMg==

