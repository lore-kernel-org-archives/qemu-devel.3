Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3316CC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNkd-0003MI-Rh; Thu, 04 Jul 2024 10:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNkc-0003Lu-Oy
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:47:58 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNka-0003Ik-8B
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720104476; x=1751640476;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=lIa3kLNXNtESElbT5wVQaoh2kvRUuxxFmBmpHjBfZwY=;
 b=uyQjlGcCjZNTmF2f9NKuDBQvh9KjprISe2SMlm0qAmSvGXL+Vw3QiAzG
 R6QRHuOgmHXgadCVZTZvtzvzzMBg/txllFBRd55kViIzWLdK1hjKz9jPK
 RDIyVYEAitgHlkStaSZOSY18V8HWPr+uGgeNB9gMc7bzd9yGZTnp8SVjJ
 8OOeLPDvpI0KCEOK/cQx6Xnwz/AL6bU1I5sRzOhR2RUJtHPnnbqCzV9eC
 aWyR03z/088fCfZD0dmUaMjde0XXWlvjdblAA71sFp2NUZLl8aEEk/yE/
 xQFs6UKFsP+SV/AgvSD9wc6B1N/VyKisWuNNKC82nOvhVBAPbawRnMNDg w==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="16005874"
X-MGA-submission: =?us-ascii?q?MDFqm30DOdUr4dGjubz/kzlSmSyZzjRuXMZTWP?=
 =?us-ascii?q?SUeUYAwksiL70QzutpIuBuHhzgVa9/rGewbbcu4ZkZirQo4DgNlncM8Y?=
 =?us-ascii?q?CVW2OMtZQ4I60SLQq6UMmuhHynSjNCybQjybEJAm1ppKgBtj7LahFgL9?=
 =?us-ascii?q?mXONoCx064G5S/GTpgUf8g3w=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 16:47:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5y2giFF5R++Kq8dIsD18Tut12EBHKmRBfIkGMmIHoSI05FUQuym3IpED0Ml9gJCp2UQrXgjsYYZDovNobtnC3fl93mOFdhc4FNP//7MJiw5P8f1718CXv3VD5t6PxN8kkDJPV3snEDtyTfkQZ3OanXh4dwxNyFURk8C3DNiY8L6TuIdkNj0AQ6Zstga/z/LWwsX6DAigbzGdNAiTxNz6XMTUGTZIs9P9vchCSi461T08XREI9bqCN5U58452dIFgjuOeZqBQMzYpyp+YkdJdFVs1xYy/N2iWN4v0LdJ9qWkbIKrZIJL7HfwMZryXqs32c/RrpCTgwRKYPK724E2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIa3kLNXNtESElbT5wVQaoh2kvRUuxxFmBmpHjBfZwY=;
 b=RohOsracYTImYQJwTrKMGht7f4Ckb1fah0mS2FqyU4j4OvtMGdCHRlD9psvxHh253eCH5fAKyirPqdjj9qNbF5dbZYq3XJM21X6U2AvWAPEQTKHsmDSfWJNBIptyrs691vTGgE/sZlC4LZCBIl13hFmOM2GN3Sm5uNpK7bE4mZ91ELhmVxA2oyBW9vSyK2OMzJy6tx4peTBm6os7dotsg1wlkRJPSZyFpAzcgwvD/HPCO5EUdGdpxGzVu3uhlf79MXNxY2HXKYEgRsfNl+3rijwvQKhs6Y9jzitRRwtEXvawYb+zPBrghAaTPE55FeHNSI3Ao+g23sqO6qZ9wolaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIa3kLNXNtESElbT5wVQaoh2kvRUuxxFmBmpHjBfZwY=;
 b=EG61iB7MrV3/+oK5H2U8zTZtjmQgmX0ZW092S8FxAun4fsTsaEFEY6FQ6tYPitSfGlwZiYsxpdIEPIMsJYTOOATiTtGEXoazOAWPfmpQEWRT9JyBDrBO+nfiA050tvxjjLcizBxzPNR+wBwrdup9ChZsfV4vX3JXEO79bYHydhC73oLAlNQy0lV3D/SSTqiUr3AHJ+n+dSUaRz/Pam03ndxIPg5x13iCzoHnwgtVdp6UwGRg6V2++t5gfvf1anZVTPP1Hq0m5isdsZ1abKHaN4Jp5Dc2CCTMD7kywdwRQwmr/0t0HGhmXMHi+loZ0X4rF76wAyvBWQCi9TZnHGH7xQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9499.eurprd07.prod.outlook.com (2603:10a6:800:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 4 Jul
 2024 14:47:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:47:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif <cmdetu@gmail.com>
Subject: [PATCH  v1 0/3] VT-d minor fixes
Thread-Topic: [PATCH  v1 0/3] VT-d minor fixes
Thread-Index: AQHaziEkv+1o7IJNF0+OMEZWEkvowg==
Date: Thu, 4 Jul 2024 14:47:50 +0000
Message-ID: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9499:EE_
x-ms-office365-filtering-correlation-id: fbf4cb44-015f-4b08-0a5f-08dc9c38471d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NGtVZndLQThRZXh2UXlMVGFIYmNVMmswNmIxL0dSTmdpdHNBeHFMRTlOcUZ2?=
 =?utf-8?B?THlZZXVUbzhKdHUwMXhrdUNzRm55NENyVzFEM01TMXUyMHZSZUMyWVE0TFZ3?=
 =?utf-8?B?R0MwR1JnS3drTk83Y3JoSHp1UTdkbDBmSnBBeER0OWRDdVhSdi8zcjJiVTls?=
 =?utf-8?B?b1hyRjBWZnpOMlc3NlJlRmVwR055OUIxMWh6eW1QYkd1Ykw1blUvMlVIYlAw?=
 =?utf-8?B?K2pDclFFajFwODFXNWxLSlVKa2s2dmc3Wi9GQzVoZHh4MUpZNGFsVVZyeDB1?=
 =?utf-8?B?V3h3MFZlVUhHbDJERFV5cWkyaVNiWlVIY2lJZ3lvRkc1RlJVcWdVb2pzbVpN?=
 =?utf-8?B?cTkyWnBKcWplRTQyT1I0aXVhRVdTZk1Eck5FMWFmanBxSVljTEhiMUJIVW0w?=
 =?utf-8?B?L1VZTm0xL0FBbkIzbEVZUC8rQjlDcWhVdUdXeGpqemRMSjlISldOZ3BIRDkw?=
 =?utf-8?B?QlNEMHNkQm5IQmJlanpGc2JER0RQNWZIS1JpTEJCbGlrQ2RsbVBoUTBpMm5o?=
 =?utf-8?B?ZkZwYUZUc3dtVXJ4QUJNN2tFZUpqU2FHS082bzQ3L0NnREpkV3l5WTU2Y0RE?=
 =?utf-8?B?WUc0RXozMXlDS21MRUVGb21IcThONENFRm1Hd2pkSGEwWklNRHNRUGV5dS93?=
 =?utf-8?B?d1ZWM1hRYnZxeURndHRzSzNlMEpLT2dsbjVtU3ZEYnhRN3UzU3dQNWxiVGdV?=
 =?utf-8?B?eXNVZW8wOG1Tb2pOM2pSdW55QUhkUGhEQ01jc1ZlU0ZIN2NheURMU0FzMDN2?=
 =?utf-8?B?ZDhEMkpVNnVEQ2xVL3R4am1WM1loSDJRSWZRS3NyOWw3WDVXWGxuNW5JQWFx?=
 =?utf-8?B?ZGdtY3hLbEFHUU5jTkNBYWloQjVsREtBZ0paSVB2UnZJUmVTVmR2WTNRa3pS?=
 =?utf-8?B?TnUrVHl5UmdSWStHbGgvT1lSaTU2Vk5nZEp4a0VpWnJUY1R6TUZYVHNFUHo3?=
 =?utf-8?B?UFRPY29PMFpYMmVtM0xTTm93OEpkRXQ5YjF1cENRd24rQmRSVGdDK3VVSzNI?=
 =?utf-8?B?QVN1Lzl5Y25Sa0d4eVQ3eVplOWw1NDdRc0pBbXRLS3Q4R1hucUlUZ0xhbmU0?=
 =?utf-8?B?MTMzSHVDb1VkWEoxQ1M2bUgxNXBMZW0wVWEzZzlldGJRY0lTS044allJSmth?=
 =?utf-8?B?cXE2RUJaaXJlTU4wK29WSGhvM1orUUUveVRnV3NPTU5KZ1ZLMlBiSWJrcUl0?=
 =?utf-8?B?cnNCUHYreGNyMFZUWU03dG5sNGJHY0VzdGpNUkxob25wdlpPaE01WlpEakt4?=
 =?utf-8?B?bnF3SVQwUUVOZWtRaE10b0pQT3dvM2FJNnBkUGd6RmhYUWEvL1FEbUJKUWxU?=
 =?utf-8?B?bzY5cDZSVUpQMEFVUERuRTYrRzJYUmdRYThkSzJ5UFNBSWRKMzBWWEtIWWd1?=
 =?utf-8?B?QWNKZGprZG5XUjkxdm9USlhjN09wbHpMbmFlV0FHRmgvMGhlRnNVNHV0MDlZ?=
 =?utf-8?B?alpEaVVoQ01PekxFRWNMQzREN1o0REhnZGFVL2gzOGtQMHF1YlN5M3Q4ak1F?=
 =?utf-8?B?L25OZElPcm5TQzJyd0tNVnV4YWN3bXdKRzNEeEo1UG1qQnJacjZGVnUzUWhZ?=
 =?utf-8?B?UnRPa016L3YvTmVHQVk5VUc1bDZ6R05WM2o2SGZZSnQ4M0lXWDZUZ25uNmVl?=
 =?utf-8?B?d3RGTndkU1JFN3NzVWg5R3c4Q0dKRFc1TlhKVEY5ZUpFZGZ6N0l3S01RenRM?=
 =?utf-8?B?VFdWVkdDQ2xKNythbHdrQVVQZlYyaGorK3VYUDdzU3VZS2hvV3Jvand0U3Jt?=
 =?utf-8?B?YzRKR3Q4cGF1TTNPeFlGeUZPaGpPclZZdVVOcmVqeWFYbnZWVGorbEdqejZT?=
 =?utf-8?B?dDRwSGpIWmZkVEI3SytMdHlSemNWSTVod3RrdHMrcEMwRlNBOStWZzRoMmNI?=
 =?utf-8?B?RGZVdmdUUGhZVlhEU2VWVzJLeWtEZzY2U0pjZ3gzSkY3Ymc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm4zQ0xEaFhwRVZ2T254M0YzdSt5Uy9aL21PUnc1RTVJUVVCc011TVJ0NVgz?=
 =?utf-8?B?b1JGeDNhMmI0WFo0Qi9uTkYyaWtlWkRNT3NLWHpOaUZaMDd1YTNMYTZYQ2dP?=
 =?utf-8?B?UE5iTDBPNTdzeEJ2VlQ2MG15QlhNdkZ4TnRlRDZITDZqUG1kSFdxczYxVUtV?=
 =?utf-8?B?SVBacnVrLzJ3Yzh3OEx6L0c3a1FiQ0VpSmFaalBwalQ4UERMRi9mOC9ocHpU?=
 =?utf-8?B?WnZsRTEyWlR4MlI3bGRJenA0czhtZDgvU0toOCtGWW5oSmlacVdYSldRRTg1?=
 =?utf-8?B?THRlZ21HTzVXaG1MTnhwaFVBVFVGL2RKNkRuK3hNN0NUZmVnT2ZRdmRRNlh1?=
 =?utf-8?B?MWw4Y24wOUVSaFEvZ0IwNGV2cUJhVXlDbFNMOEVVc25WdXNzaVNmOCtqVTNT?=
 =?utf-8?B?Nk9LYTlDZVppVWRybHVBakVzS3E3TXJ2OVF1dTRCNVlXKzUzcUpwVVVyNHpl?=
 =?utf-8?B?bUpRd1FYT3BKWFd4MXRaeWNFa2JIa0ZVNDJNTTFXejUxRkMrOUFHRkJGQmox?=
 =?utf-8?B?RFZNbXBFNGhONFhybDNqUXcyaVptWmM2K013MEoyOEpDbnBmclJrZ3d2eW9Z?=
 =?utf-8?B?RzAxOGRVQVoxWWR2RFk4Rno0YXUra0Z2Mk1GcmdZUTN2ZjYyN0lTU29SMnBP?=
 =?utf-8?B?UzVqS0NTV0NkVW9iakpYVjk2MVhCbXdoZlB1NDVZeXQ0Q1A3MytudmJxbklj?=
 =?utf-8?B?NE5KOWtDY004NFhkZ2puazFaSUY5RkhKbWc0NVAzUjhDSVFMUkYrdmVoWGtE?=
 =?utf-8?B?VzVQREx3aGcydVl0NEtzVUxxWGk1WGRJTnhPdHc3RStSU3lwVzJWM1NCWE10?=
 =?utf-8?B?Q1JWcEpxcEVIdGs0MVRiS3Vtdkp4WktvbGxia1ZBWXJlcCtMbzJMa1RVdTBT?=
 =?utf-8?B?YnRuU0I2L2E4N2twMzR1WitqNFpIREdQRmNZU0wybnhLV3c3anQrTmJkLzg1?=
 =?utf-8?B?VVVEZzNUbUtKekp5b3Y0NFBzSzFwNnZpUlptQzBrNmtzZUh0a1V2RHJKck1a?=
 =?utf-8?B?VHlnWmYzU214L3BKNi9xemlmL1pRYmJlNkhvUTBUeEtWS0lQenhsL1QreHhD?=
 =?utf-8?B?M2ZHekZaKzV5MFJHT3RBRld4cU1PNmpsU3BQNkFNYU1EelJiUkl0a1NTUXdM?=
 =?utf-8?B?ckwxY2lWSXh3bzgvMFdJVi9JQ1ptbDEzejlCQVZyTWFYVjVsZnJmbTVBV3hq?=
 =?utf-8?B?cUZMRUF6RlI2ZlptbmVQdzVObGVScWY1Q3J0dGhmd0xRZ1FqRUJxQVFGOEFC?=
 =?utf-8?B?NERrblJyYWhMU2JBS05OTGhyckRCN1d3MHF3eUdtM3g5WC8rcisxUnNCU1Zi?=
 =?utf-8?B?dlNXd3p6empHSUI2eUhJY0JkSnJtWkJQeXhNMFlmZ2RiTlJDYlo2d3E2QVV0?=
 =?utf-8?B?emRIYWRBM1dlMzg5YnVGZVBJMXJqRHZJQ2JJQnpIRkZkTGFUS2Z3czliYTln?=
 =?utf-8?B?VlF6NEtqT1UrZU5XMXBYdmhhSCtrS1l2bnlsQVY0YUxPb0tJdEMvMkZ6VlFu?=
 =?utf-8?B?SWUvWmdsNlp6cjN2Wnh3Z2N6WjNsR29aQ2IySWFxZ2tFekhoOUlwbENpeFZB?=
 =?utf-8?B?VGl2SzJucjBBQTJIOTB5MlhrWTBkcDk2MUp2RGlhSEFZbVprNkFRMjJrRlF1?=
 =?utf-8?B?TVlKRWFXRE56ZmdlK2grZTJFZ1FjQjBwa1ArRzE5bUtMVlB0dTBVTktLRDNl?=
 =?utf-8?B?RTJFK25MY3BrekJmWEJDSDFSUTk5N2c3MUNGTW1lOW9rVVpXUlF3RmNZRndT?=
 =?utf-8?B?Tnl5bHFGQllveEF5K2ltZEoweGlaVkk0eFZjRTQ4K0o3TGFYWVIwbGRYQVBW?=
 =?utf-8?B?cDVLczY3dzRpOUhKYkNoZGhMc1FuR1c0eTFzOGZCWGtQY2F1VHlCSEk5YVE1?=
 =?utf-8?B?UmV6OVRzNkpvSllsbmhTTGxkaC85R3hkYm5HRUVpTUhERkh0RnFWc2FhcENq?=
 =?utf-8?B?THo2ZEFYMDhUNTd5b2tLT0NrRy9wMmpZKzdXUkVtTmRLRndDOEU4RWhzOXUx?=
 =?utf-8?B?RUlNaGN1ZEU0cHpWakN2MzYraThnb2VvNk43czZnRU14bHduWU02dS9DN0M5?=
 =?utf-8?B?K2JDZ1J6L0t2c3lTRHkxMkdLWEhYNTRhT1JOSkUzU3l4aUE2QUt6Q0RjNnhE?=
 =?utf-8?B?RkRLUGJjREcvZnliOVZma0dlZnBXYjViNmZwOEExdzA2MFNyN3BkcHlVOGxY?=
 =?utf-8?Q?tj+AUrI0WbgdsmoIB+p1+l8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0A8F56234AD54AB908859389A7E200@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf4cb44-015f-4b08-0a5f-08dc9c38471d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:47:50.4785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCeyH1UeVQQTmg8CbiJSOE71PDYTrApr5phsiuaNaozcC6rUDKTxhx7HyE1EYmj8PwamZUtBAPk9fYz1AjyMMZoxNGTE1C0l7EA77mDOG6+we9CJwwo2VYIFBkwiwi1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9499
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

RnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbWRldHVAZ21haWwuY29tPg0KDQpWYXJpb3Vz
IGZpeGVzIGZvciBWVC1kDQoNClRoaXMgc2VyaWVzIGNvbnRhaW5zIGZpeGVzIHRoYXQgd2lsbCBi
ZSBuZWNlc3NhcnkNCndoZW4gYWRkaW5nIGluLWd1ZXN0IChmdWxseSBlbXVsYXRlZCkgU1ZNIHN1
cHBvcnQuDQoNCg0KDQpDbGVtZW50IE1hdGhpZXUtLURyaWYgKDIpOg0KICBpbnRlbF9pb21tdTog
bWFrZSB0eXBlcyBtYXRjaA0KICBpbnRlbF9pb21tdTogQnlwYXNzIGJhcnJpZXIgd2FpdCBkZXNj
cmlwdG9yDQoNCkNsw6ltZW50IE1hdGhpZXUtLURyaWYgKDEpOg0KICBpbnRlbF9pb21tdTogZml4
IEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvLg0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAg
ICAgIHwgOCArKysrKysrLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDQgKyst
LQ0KIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQot
LSANCjIuNDUuMg0K

