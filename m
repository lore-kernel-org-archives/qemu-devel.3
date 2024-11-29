Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAEED6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfq-00085y-5B; Fri, 29 Nov 2024 02:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfg-00080Z-LG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:13 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfe-0002eL-W1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866251; x=1764402251;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VTiec8G5rIHL0vyL3mg9SgoFhCVnChkHAUp8DJ/M3N8=;
 b=rdOAq1EJTn1QAbAfmRWlDvBOLNqPXl1iIOSWIh5EL6KHQpK1Z1UiYvey
 mWMmqSQktvnG3EMYpo69AHHa4sALDKzY5xlphxnaaj73XHfmqqMJZY5H9
 c5Nc9O8PH7LFSFyRLdxF1DLfoavotE7YWI4ADMacahr0QUoaZy2ERJSXi
 2oVs8OpOmii/57h5IStca2mpz/DrjRWCizIIXccUFrai69Ij495VA0clL
 S5un0hrqa8yzJfX3WxP6dqHfjjDgNjNXdOZeo0+tBapLfQomH6yM1bBs1
 U7qNdpimRSVPXIXbOtBC5HpnxR21PLBqjLshUUamVlUaNoBKGXL8UQgrM A==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670818"
X-MGA-submission: =?us-ascii?q?MDF9rLqqPdRhk/SkqYl4+2pU+GWhU4rzd8mgme?=
 =?us-ascii?q?q9V/uhoN1hac8REYx4Dk4otXbs63DnL1ZvK8/5oeOdgqRp8KbeQuSPvU?=
 =?us-ascii?q?EOqWSNqjdg5HJT5jj+ANVs97aoJA22YCaiyzuGcDk2zOBCSVbt3FsQ+c?=
 =?us-ascii?q?SwNjoHoWqlfwGHCQ/xdGvOiA=3D=3D?=
Received: from mail-norwayeastazlp17013077.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.93.81.77])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:44:05 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhQH/BfjHmQISVcVvQ2C1s3xMaXLEBM+4iTpeLuc7mmHjEuuhvA7zQ6/MKLljZxnYxcWosxU73J/TL2Uf5embeYDZrh6JY4yFse9zBYYRqA/BsmOoFaB8haAfi5LKCo3sVWlc1CeENQnEJRnAIeDWXe+Ux6BETaAAJBcgaJt4ZBN81VPSY+lTmuIFmu5m3cnjJyFgg6ll2G7XmVBg0oi9SDZIGjqWmJVmNnkYzZGuerK5LGFVKzVBpIX76b3G5xWIdSh9ZMMs2N0LjgczvNONoggDywA7ldxu22Ryx/xYOhNN6gtK10vaQr7+7cSgQXYjIHpqj8aaAdboWLws34cqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTiec8G5rIHL0vyL3mg9SgoFhCVnChkHAUp8DJ/M3N8=;
 b=L3TFMwUxYPShuIzB2OLXwI9stNxoGik0UgS5FE5jc4NSEv8cclyjvKd+gr0o2U+4cjuuRIfN06aygSzxqEPo/OwkTM61hCuWJJFb50YnG2phS3GuKdfVOdzmDPRODV/fLY1bRY9FokTgyMX9cgu+d4Z+eArijafd79yAKJodL6eWgmGtpeQNGrFF6MKmg2HmG6CsSQ6rGHQRwbYqv2a1cKgwOvg5FIp+tSXj4gwFLWPHSTd73kcoGZYpveY4yHp2mW8WkhmufZmAttlZo9+fIhvyF1tJC9hW2Lbslg98hh3wftUKI71xpnDab+GfvMsFP2cCdi98X1EHtr1DEyirMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTiec8G5rIHL0vyL3mg9SgoFhCVnChkHAUp8DJ/M3N8=;
 b=YHaWhfKPDZ5zS7mY5eqkguQh/ptjqJs178S7W8AKJjxDbijueK8MU0UM1yHCafeEAB7m4vN8nREVNZQQIQPpH/dkkukPLNFNJ3q3ae/8NQuw6/yVrnYHCcve5ONnnR5zY3PB8bIb5ES4jRZdY3AbQi2VzpwyWG/roxFHkpkPjQ8/VK0+ALKhX7FAVb047y+lDr7vIs4ihSAJ20eY4Uuhc0mFQITU/Gxt3W5zfMOpkVNXKuY8wBSbR/qKxUKveQj+RxuUO7N11K3CgiiGFn4qhjxYJ4bR0bSfboY5O+oNwN/Oa9QtUEuTvkXXl4vTUdYnsfZDASyo+zGsS7B5un17Jg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6414.eurprd07.prod.outlook.com (2603:10a6:800:139::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:44:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:44:02 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 17/19] intel_iommu: Set address mask when a translation
 fails and adjust W permission
Thread-Topic: [PATCH v1 17/19] intel_iommu: Set address mask when a
 translation fails and adjust W permission
Thread-Index: AQHbQjJ1rB7nLH1SCUaPPBOjd8HJ8w==
Date: Fri, 29 Nov 2024 07:44:02 +0000
Message-ID: <20241129074332.87535-18-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6414:EE_
x-ms-office365-filtering-correlation-id: 6d5246a3-0740-4f2a-0687-08dd104997cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MWU4Z21EcWpCZUY1dU5EVU1pekFTd29iQ0MwUENiZTVIYlZNS3g1R1Z4Mk05?=
 =?utf-8?B?UWhhWEJhZUdiWTNDcmlHZ1VrWU14cFc2NDJlR3hvQUsyT2s5SXpEd2xPRlNr?=
 =?utf-8?B?QXFaZGhTZFZsQmdOUnVyUDRaTnYzNlJMZzcrOFhQK0c4SWdEaG5CN0R4a2RY?=
 =?utf-8?B?Zi9iL1pESmNuSnZjNjhEUUJMVmo4SWlpbFNrbnIyQVJUbFpJMDlvU0RHSHVZ?=
 =?utf-8?B?Q1lsMG0zRTRwbGRXWmhNVGNzeWhuSFdmVkN0SGZCa0N5ZExhV2lTZXB1c21C?=
 =?utf-8?B?RzAzZ3JiZm53UlpPYlRCNFE0M2hnbWU5dytpZFpYWVJpZ3psaEFtNGh1ZFFJ?=
 =?utf-8?B?eGh2NWsybUVKRURqd2tncmVOa2ZIMGNjQ09WNnEwQjNjVTJNZ2VKOFQzRzRs?=
 =?utf-8?B?ZWlkdkozWGc2aGl4UUttU09BcFJhMVhXcDk2dUJaQUlTOUR6YkdweUVmdlo3?=
 =?utf-8?B?bDh1RlRnZnJyUUFmbmpqbHQzYzFQOVZVVllzZnEwemZSWnRZWWtybHcrMXRF?=
 =?utf-8?B?L0RxcEh4S0RxUG1vdEpEK2MzOE1XNENCQmp1Q1NYWDY1aU00MFF6WFJmUDIw?=
 =?utf-8?B?UWpFQlVDeUp3dUVIdDhnczg5QXkwa1F4Z2xBUG1wS2ZydmN5d1lzMjdiTVZM?=
 =?utf-8?B?RjMzeXQ3ZTQ2R3hqQ1E2SDAwWWxPRW1KTHh5K2JRaWJ2ZlRrRzhCd1hYOWhO?=
 =?utf-8?B?cHVtUnVvTkIxKzNDOHoxRzZoa2VKQ3FLVHdlWnRVUEFVS3NtMGo1WUpoUjBL?=
 =?utf-8?B?MXU2YjUxOUVhYUR6R2VHUFNTQ2VWMmd3UFYxL1NuU0srNzIxVVBYWFJvOHRE?=
 =?utf-8?B?dHNrdk96eTR2d3RlVzA4RmFjZnFnRjRZdVgvRjduNGJ1Z3hUZzFHTkIxSHl4?=
 =?utf-8?B?NU1jT0tJdE9XQjZPUDBSNkdNN25mWU9iWTExOHpQL243WXJpdFVCMFBVMmcr?=
 =?utf-8?B?bjJ2Z05RTDVaQjAxQkpZQlFNSGlZUVI1dklZOXdoa0ZaWVYrMnJwaDZMQ0Fm?=
 =?utf-8?B?WlFpMWVZMEZob3BlVGhiU2tnVjNNRytJZ0dGeE40ZUE2dVJYZG14UHNJYlF4?=
 =?utf-8?B?c0RDRHlvQTVXMnU5S1EwYzltUzZYSWRjTG0xSjh3R2xTY0ZtUmVEdERKdXFB?=
 =?utf-8?B?S0JjUERQa043MUtaRWdFSDMyWXZlS0R2NmszaC8vMnl6YnZKNzV3U2pNZEpq?=
 =?utf-8?B?REhzZkE3Vk90cGdQNHB0b1ZsR0RrY0F1d2xFajJYYnJaRGdSQUQ4T0lIVVha?=
 =?utf-8?B?eVdJV1JpcUZ3QVJIMmUycjRBYW50ZHZBRTFCcG10YWlqS2ttZTRUOUlOVVVY?=
 =?utf-8?B?TnJtQUljZC9iMXFZMm1lZ0pnL3V1OXZEOTZ3NG1LQVFDS1FqL3VQK0tUZWVS?=
 =?utf-8?B?QXJvbGZwT2gyQUtjWHBLY0R6cnB1Z1RyemFBblVmREplOUVqaVc4Z0RtSFZu?=
 =?utf-8?B?Y0w3ZzZZSEZ0NzBvYVZwZm1EajJ3Y1BCMFpTazFGRHBJV2I1OGdWTUhZWW81?=
 =?utf-8?B?YW5aaDRIK201dVdYQXhETm5HbmdnUmI4eUYwaFdtbmdYTmRwcWU1ajFjNktj?=
 =?utf-8?B?ZEJhS0gyVWt5SlBMdmU1cm5zekVrWDZaQmFlYkQzZ2lnQW5NSnptck43cUo4?=
 =?utf-8?B?VXI4b21wOU1rZW8vS3Q4MFo3cUdNYW1qKzVWTTU3NVUyaFUzMTlISXRxeDFM?=
 =?utf-8?B?MWV5bWhSdDdsL0YwOW12YW5JeEtQaEdjdDVRMlNHYU5jSnhWcFVsbVJ5Tmtu?=
 =?utf-8?B?Si93cUhGMlh2b3pnUCtCRzFjMUNWSklVWGJMU3Zob0VIcUxJS1ZZZFV1bjBI?=
 =?utf-8?B?ellVRzQ2Vjk1aERlSUJobHF6N1g5TU1SZ0ZZYVNHc09qaEY5VWhoZGJDRVVT?=
 =?utf-8?B?MlRJZFFKNkY3SGh6ZjJjekR4bHJ2cEptQzRYTzJCdFBqZWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RC9Pc21hTmRKVlhBRXo4UmJXM2NQb2RoUGhYMkJYbzVyT2VSOFNUdjNlYTA4?=
 =?utf-8?B?M3YyL1B5c29XbFlVQ0hpOTA3TEZKM2M4Rll1dUVsMkVVQld2a2FTVVlWQS9J?=
 =?utf-8?B?VDNON0lJeHlrMzR5UU4wdXpxRWdSZFJIemFtc3ZleEZTRWRvQnczbkZNbTB1?=
 =?utf-8?B?RXUrZUM0RGVHUmQycS9ONEJyL3g0VmRlWFBXdnFNV1JnMWdzc2hWSzBQRHNq?=
 =?utf-8?B?eWJaUHNwNzFaTUs2NW5zL0tuZmgzU3A0cFF2ejRTWXExUW9tNkFOMGFxdFgw?=
 =?utf-8?B?Y2FTSkZHTkJjOXczY3VTZnRzODF2by9JTTU4T3VuYlJWOXV2YXd5aG40ZTh2?=
 =?utf-8?B?SkRselRpWGt1NXptQVI4UGdIU3lGbGd6WjdEbTZTc09vMlVZbkRpVzBOYmtG?=
 =?utf-8?B?emF1bHFSWVdIb0FucC9CclRGY1FsZzVXTFR6NGVCdTVRSzRJNHVjRFFOSUU2?=
 =?utf-8?B?M0FBbk5OYi9oWHFDVlBnYjJucTljcE95Q3dDTm9TVldZakQxdTJXemFhM2Fs?=
 =?utf-8?B?QW40RTAvdWV4UlpteEtMYkJ2VGFENzJ6RU1iQkZSSUsrcnY2ZmIrMEdtam5a?=
 =?utf-8?B?UnB0RmdqMXJKZitVVDdubzdMd0lLUFlPeXRmNk9SNmsrNVd2SG0zTTBJRXh3?=
 =?utf-8?B?eW4rMUJNUlJSRFFRVDVPRVpxWFlqRUVkeEV0bVJUckRwZzB3N0JVbVpCWnR2?=
 =?utf-8?B?K2VwR1pKdU5oQUkvQUZ1MUNLOStGZFpxZVA4VFE4WkEva0tnZ3hMRFFoNFRt?=
 =?utf-8?B?TjNFcE1mS1dhVGNpSlM5WitBL200VGN5T08zUmc2SmxiSDRwR3VxZUNTMS80?=
 =?utf-8?B?bnU1Q3pTang4c0EzZ3NjOFdFWCtSTjFocUtNNzdNTUV5ZFNKWnBXODdYWEdT?=
 =?utf-8?B?bTMvZENrZHFWWGJFRWR1clJKRGYrSWVnZ3ZrZmZpZXpQbjhGamJpcUM0c3Vm?=
 =?utf-8?B?Uzc3QXlQSlRhRkR4UUhtZCt1RGdGL3VURU9OKzlaaEN6RHpjTEgvaUVxMytq?=
 =?utf-8?B?eFFraTFFNS9LRGdqamdXbWdMeCsxMlBZZ0p3YVNQaXI0YkthTnhZVG55dVFN?=
 =?utf-8?B?S2tuYTdvb0ttMzJpekZwM0R0SGlTZEhBcDF1SE04NTAzOVhxVGUrQ0xTblZ6?=
 =?utf-8?B?R0hlcTFpaUQ4YWtFSXRVbm9XRnZIU2RrTzNBMkRaNXB2ODVJN2EwQm1zVFZF?=
 =?utf-8?B?SElOZ0FTTHpOYVhKS2hNbTRsZWlMWkRFUWpwZ2piZ3MyaTRlZDJEeTBVdXM0?=
 =?utf-8?B?WEZYSFVvaCtsWEJWUCtFT01xSm13MWJ5dUo5ME5RZmpiRzJRZjNCOHp2WHpL?=
 =?utf-8?B?YUZML3BQZmIxcncrOHFjN0ZSNkZTNFpjUno4dXNPS2IzNjFNSGtHZGtQck9J?=
 =?utf-8?B?aXA1cG5CNkJxSVpDek5VVFU4NUJ1OURLOHk4OTNRMHBZVi8ydm1jd2pKUEYw?=
 =?utf-8?B?R2lmVE1EUVVQbVhjOWJDN1RBSDNIYXk5SEphNjFVSUpESUhIZ0lSQTYvM1N6?=
 =?utf-8?B?Y2JJTHNkU3Mzd09DUURUSkFTQm04bHh0cE1nUC9DVWJOOTNrcW1ZSFBaU2hM?=
 =?utf-8?B?Q3JTSDVoQ2dTUDMrdzkxT0wrdFI2Y3lQRDNQUVdYa2k0cURkcGw3ODhGUEE4?=
 =?utf-8?B?aSthbC9VV1BDNGx0VXlNV0VGR3hkUS9PeEZ0cmZvUFRIYi9WU3lydjRBWjg4?=
 =?utf-8?B?TFpVcFVhVUd5YVA1OVR0VkI3VjhuTUlmTEQ0Tks5VWIyS1ljN29oWUIyekgx?=
 =?utf-8?B?TDg0VS9NbDRIa3JzeWxRNUd0NmcxRFpzdFBxeXVMcnhaUExwbTRwVi9US1g1?=
 =?utf-8?B?ckxyYXdEMmdPUFU3bE5nclFkTXcvR09kajN1aEFWaXBhQUVlZzVnMnpWTGp0?=
 =?utf-8?B?V0hFbThJa0pmZU96NVlQSWFkRnIwc1RxTjBWbHdiN0NXNmZUQW4zdmVmaTZ2?=
 =?utf-8?B?MUYrYmd4TUZFSWd3WnZ6TnVEM0ZnZXBNRVF5YnlTVENKU0xsKzF1dE1tM2JB?=
 =?utf-8?B?N1RMOEZyN3pYUU5paVlyRHl1SDdaUkowNDJlNGJjNkZtTmVialY3Z2tTd3Zh?=
 =?utf-8?B?OWFVTEF0dkNSQ0FFS2pWNXU2RlVDNTJOWEMrWmFFR1ZqQXZWSVVnWUd1R1F5?=
 =?utf-8?B?OVcrQkhCdjZxQmN2RUhCMDJEdTBFTXhoN01WcG52dHIrRGdxWHFBUDdnT0pG?=
 =?utf-8?Q?pxujQY/2UdJ46DUS/RJBkrw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <746DE87AFBF2F346A4B53915677E15F5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5246a3-0740-4f2a-0687-08dd104997cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:44:02.1539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Otnc7ndX4mrDB+SfB3Egxjdv6qBO4BWWIlFNvDAEZhsCqcA0AzpgtmVa96JTZjr13vHXGRYm6B7+Tyw60dAkedqRLM2cF7u+rA5I1Ow50814ML3EDYvhjHHCwbXQsVqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6414
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCkltcGxlbWVudHMgdGhlIGJlaGF2aW9yIGRlZmluZWQgaW4gc2VjdGlvbiAxMC4y
LjMuNSBvZiBQQ0llIHNwZWMgcmV2IDUuDQpUaGlzIGlzIG5lZWRlZCBieSBkZXZpY2VzIHRoYXQg
c3VwcG9ydCBBVFMuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIHwgMTIgKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggN2U4Njc2ZWZiMC4uMDYzNzQzNzU1MiAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtMjEwMCw3ICsyMTAwLDggQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0
ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQogICAgIHVpbnQ4X3QgYnVz
X251bSA9IHBjaV9idXNfbnVtKGJ1cyk7DQogICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19l
bnRyeTsNCiAgICAgdWludDY0X3QgcHRlLCBwYWdlX21hc2s7DQotICAgIHVpbnQzMl90IGxldmVs
LCBwYXNpZCA9IHZ0ZF9hcy0+cGFzaWQ7DQorICAgIHVpbnQzMl90IGxldmVsID0gVUlOVDMyX01B
WDsNCisgICAgdWludDMyX3QgcGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KICAgICB1aW50MTZfdCBz
b3VyY2VfaWQgPSBQQ0lfQlVJTERfQkRGKGJ1c19udW0sIGRldmZuKTsNCiAgICAgaW50IHJldF9m
cjsNCiAgICAgYm9vbCBpc19mcGRfc2V0ID0gZmFsc2U7DQpAQCAtMjI2Miw3ICsyMjYzLDcgQEAg
b3V0Og0KICAgICBlbnRyeS0+aW92YSA9IGFkZHIgJiBwYWdlX21hc2s7DQogICAgIGVudHJ5LT50
cmFuc2xhdGVkX2FkZHIgPSB2dGRfZ2V0X3B0ZV9hZGRyKHB0ZSwgcy0+YXdfYml0cykgJiBwYWdl
X21hc2s7DQogICAgIGVudHJ5LT5hZGRyX21hc2sgPSB+cGFnZV9tYXNrOw0KLSAgICBlbnRyeS0+
cGVybSA9IGFjY2Vzc19mbGFnczsNCisgICAgZW50cnktPnBlcm0gPSAoaXNfd3JpdGUgPyBhY2Nl
c3NfZmxhZ3MgOiAoYWNjZXNzX2ZsYWdzICYgKH5JT01NVV9XTykpKTsNCiAgICAgLyogcGFzaWQg
YWxyZWFkeSBzZXQgKi8NCiAgICAgcmV0dXJuIHRydWU7DQogDQpAQCAtMjI3MCw3ICsyMjcxLDEy
IEBAIGVycm9yOg0KICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KICAgICBlbnRyeS0+aW92YSA9
IDA7DQogICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KLSAgICBlbnRyeS0+YWRkcl9t
YXNrID0gMDsNCisgICAgLyoNCisgICAgICogU2V0IHRoZSBtYXNrIGZvciBBVFMgKHRoZSByYW5n
ZSBtdXN0IGJlIHByZXNlbnQgZXZlbiB3aGVuIHRoZQ0KKyAgICAgKiB0cmFuc2xhdGlvbiBmYWls
cyA6IFBDSWUgcmV2IDUgMTAuMi4zLjUpDQorICAgICAqLw0KKyAgICBlbnRyeS0+YWRkcl9tYXNr
ID0gKGxldmVsICE9IFVJTlQzMl9NQVgpID8NCisgICAgICAgICAgICAgICAgICAgICAgICh+dnRk
X3B0X2xldmVsX3BhZ2VfbWFzayhsZXZlbCkpIDogKH5WVERfUEFHRV9NQVNLXzRLKTsNCiAgICAg
ZW50cnktPnBlcm0gPSBJT01NVV9OT05FOw0KICAgICBlbnRyeS0+cGFzaWQgPSBQQ0lfTk9fUEFT
SUQ7DQogICAgIHJldHVybiBmYWxzZTsNCi0tIA0KMi40Ny4wDQo=

