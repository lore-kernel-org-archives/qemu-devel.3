Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6EFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVuXp-00048M-Pv; Mon, 22 Jul 2024 11:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVuXZ-0003wo-QB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:01:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVuXU-0003Gc-9p
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:01:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCLI6R015851;
 Mon, 22 Jul 2024 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=0rHioZaYtNUCq5tbATtjhIET/hOUXY/T/29DkPZ++bE=; b=
 R2WZ17AJ4Zi5DkeVkLLBh5AOB9SBakJgMevxs6PC+b9gDoACDRs4VQjjbkl0Mbcx
 OrF6tnfMftw3C/hMbpbgZIE8UDexLDN0WwZIepKARffYfax0I/ZFscXmrBe1tdhy
 oZuLPh+h/ZJ2QUdbcl1vudNSqDrcHMgaKEoyBOcdqtDKYMcbj5pr0ruaJfX275Y0
 FO28FTdZ5d6uXSHi5a/PLp2cZCgFCt9ij2l7uV4z8UwxC0Y3RzYVaMssLER8E0a4
 nNyo3xKh5dEicljq4qVqV+YJtairJYYyOUJyBBTMXBbOpZCpthfneNoJ/B0GAqX4
 oMkoum/7APZRPQERirA9tA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkqsytj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:01:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MEQs10040045; Mon, 22 Jul 2024 15:01:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h26k2qbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:01:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjkSIv5EpKd3lPVubs+i3QCuLIq3Yo8TM02KVOA6xW0HrcXYX6XLjH+54r7QVGvEeXuro8DiaBOBfsh+JPKkuUr48JCKQCKDYcLc359nU0jeMQJ1faXPqf4w7JypUeSLbuzPurH9yqAZUXwmjoo3RLRsBkM+4rGD93GxvsKm3D1Q+kKHm1Lcmo95UFG1xhnRlYUahtXHz288Jz8k2EePR1sDdzbqh6G+0LtOnfomp9HizekR+kkQkRg0+mAZuGFd+dIdhKZ0bPb0biqpxPy92U7D5e+0M1tBcgYG8dnHnZLR6AyLAADLeGBUJQ+NxYFHLercOw2ldw4lyjAKlBHrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rHioZaYtNUCq5tbATtjhIET/hOUXY/T/29DkPZ++bE=;
 b=MwRca5AQ3ZdhUf5L75pFZGNq1oEPJ2t2ydijHQ0tFHQ0FMoiHFbabmixVOVnX8JkRK5k6J1XAaGU5xgwSi2qNuNyZDEuLNwuxMlRzZe//BdGh7s4efXYdjULtud+2dc78bhgh0RXns5I7Z/LH+OYH4J4PvWlentQdSRt/EIxoUDgqz1o7bP/uUCp+d2N1uTXBhdPu48otsGdHAnUnENr9fN2OGRAHbPIlPyrPJdPJ0F7mY46PpISDJnnG3GrfH9STBdPP5EkjE6xVS9wiHERkltKf8DBqYwUR1FsXRObPtvBYbXVh2zopJWGONYHRaGRMCiXBPdGohq1MwHF8ot5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rHioZaYtNUCq5tbATtjhIET/hOUXY/T/29DkPZ++bE=;
 b=fDSmK4/1faB6ZmdsPb6NAAACNQjdc2xwNtjXTclSiigLJUoUSQR6srAY7MaD6UmSzK8fUb9rWswPMU+T4Vvh6OVU45fuTLJ//CfiRFw3AHB75qPuq0rgyIhrhZwm0ixzki81c1/hcyWoYCGJDswDoKBNLNBladxd4zp59dvTikM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 15:01:17 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 15:01:17 +0000
Message-ID: <103a2101-3f9e-46da-b45b-b8a4eaa7d6e7@oracle.com>
Date: Mon, 22 Jul 2024 16:01:09 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
 <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
 <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0614c3d6-e38d-4cbc-f988-08dcaa5f2368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm1CTkVDY0h4cTNXYUZpa0NaWFhQVHpBN1lwekU3eHhkMG0yemcwYUwvNjNI?=
 =?utf-8?B?YmdXcEVVdktIL3ZqOWcrcHlaSmRsV1V6VU5JL3BEYndvdERwMDR3NUs4L0pw?=
 =?utf-8?B?a0NWeUZXQkJZaU1rSCthdnYwak9hRFA2M2c3Q0tSQ0ZENkg2SWdOc2x6a1pR?=
 =?utf-8?B?MEZXMzdYcTNHcVBxWXlJWFlYeEp0VGI4akV0VmY1eTE2c0Qzb3NhUjhtSzBk?=
 =?utf-8?B?MUNqVDF3RHBCY3U0dTFvd1FBZGR1dHRibW9IVVU5SS9FUm5LTWl4czVwQWNQ?=
 =?utf-8?B?enAwblc4S2dKd25ic0w1T0t1TExvMXh4TXYwVUVLMHJxdSsvM01jQW1VbnBL?=
 =?utf-8?B?cnhveDFBZTVBV0gwRXJ3b2x4Z1hJcXpUR3p6Z3pWS1VKT1phRXJmUjI5OW0w?=
 =?utf-8?B?RW44MllRa1JDRUc1dGtQeWxGZlJvWk1uaS9MRzlUQ053U0k2SnR5eTA0MUNV?=
 =?utf-8?B?Vk5majJlQWJZSk5ndlRmdGh5QWJ4Sm1nSTJwdHdESWhFK1laQjN0b054c2RP?=
 =?utf-8?B?bFRLRndyaUx5Y3hmR0U2OHlPb1hlU3MrbnZ6Y0FLQjlhSGFvTndjSXJIanZj?=
 =?utf-8?B?UlR0UXZ3UXdYMmdNMlFweW1Ebko3QnVxY1RRLzhEY3BOTnBiSkRvdllmMkhr?=
 =?utf-8?B?N0trQ3Z2eVQ2MXAvZGZIOEhDQzJyMFR0TFNhNmxtMXZtcjBacDRHakI1ODVw?=
 =?utf-8?B?dVJYb2xGc2liSXNONXRjWk0yRGw5L3JQK2Z5T3pRS1BXODMrQzZqclVvMUZT?=
 =?utf-8?B?MUtEa2l5VXpCK1JHeW9sa3BLS080TXNFNWtzK1E5NllKRDV2YlZrQ0c2d1RB?=
 =?utf-8?B?RHlSL2dPOTZnZ002ZWRrdGVXeStUZEhqNk50TzNVVkM5SXpRSmxEUEN6ZFRW?=
 =?utf-8?B?N0pCZHBZQmtkcEJOeHFoOWNBbTh2RFhya2xIL2tsOGRoZmxsYUFpNGhsUTgy?=
 =?utf-8?B?UVBqa0hzbmM0emU1LzgwSWJsTHhyR0h0bU5tMUJYV2JkUHQraHFxSDRlR2s1?=
 =?utf-8?B?b3h0MXBpdE9CS0QwWW9wOWxyUHhINWxXeDcxY1g5eDBTWDR0aWhoRksyRDln?=
 =?utf-8?B?bkhpNHFTeDFSa3VkSkdVYytTRmhYWHhKamwyQ1N0VlA4VC9iN09iZmNoTm5o?=
 =?utf-8?B?TGo1Kzd5dkc0bFRWY0RCaE5SaFM2UzFkRHV2S2pDSVR6RktWZEhETXgzbVJv?=
 =?utf-8?B?QkhadGdMQUo4VFI3R0x1aTNZM25ZWXhYdzI3ZHpQVUtsNDA0Y3BUU2FkcHZ5?=
 =?utf-8?B?ajRQUC90cWt2eittTlpaSkE5ZHVSL0ZPZXlIS3ZnSFRwQmxXaGt5c0puWTlV?=
 =?utf-8?B?SDk5NDcrSlZWb1VTSmozTithR0RHMk9pZ3c3a3l1YkVCNTlDalBHTVd5QlRK?=
 =?utf-8?B?UVBzdms5Z3c2OVNsc2lFMUlUWnFhR20wSzkrNFFkLzRaYnNBbXVJQVJoMWsx?=
 =?utf-8?B?b3JnMzFmUmxCeG1pWmU2VlpmdkM4bUkzRFRKTmo4M085SFFEcWd5WXFWSytS?=
 =?utf-8?B?RzYrZnA5OFZpbitJY2FsQTM5VmVyYkxSbmVhZHhhNllrQ2J1c1VvN3VtclZ6?=
 =?utf-8?B?L0JlbWc0NytiaFkwdWxpYm1WQ1RPUFR3dWkrQnZvR2I1aFVyZ0tHREd3amJG?=
 =?utf-8?B?UHZEYlBpc2VuLytQRmd0MVFqQmZhbFRtNWdQcm45bW5XbDZIOHBIajZ5Y2pw?=
 =?utf-8?B?WFUwaGZ5dDV5NStKVGJWTnF6K3BsNktrSUVzZHZ5bFVjUUF6Nm1WVHU0TVY1?=
 =?utf-8?Q?WiE2EU4x5WXmac/FGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVVN01xbEFKaVhuOUthSkRCS1YrRy9OVWNIR3pyOUlva3MweDF2TEI0N1o4?=
 =?utf-8?B?Z3l0cURYaEkxQmdBejdsVi9nZS92UEhRYW1TblNXUFJ5eHIzZWNXTzZ4bWRk?=
 =?utf-8?B?TmlwejdvMFA4OGRtV1poME9IOXNwNnpUN1Y5QXVyUjNIOStTbWkyb29tU0NG?=
 =?utf-8?B?TStwWDB6WkxzYllOeUJWT0diVHN0b09TVW1SZHdPREdScjJBMEUycWpJc2Vl?=
 =?utf-8?B?RXR0NUhRVDdOWFlFT3FlejIzeTNEdnBvMUgyWG9wSkZXY2dxV1VONjA4MFNH?=
 =?utf-8?B?MmpNaWtVNlR4S2lJN2VaWVY0ZjFGZFRCcUZlcTNSWTFBTW5jcnZDbmRJTFZ3?=
 =?utf-8?B?ZXN0b0dRVU9IbVE1bFRnQlgvNFMxT0JDUEh4b0MrSEp1VUE4cWJmcUxsWktR?=
 =?utf-8?B?MlBFNEtyMWFLMzNTUjRrWko1R3dTa1MvZ3dTNzhCSVhDRDNHb1NQYzN2a2J3?=
 =?utf-8?B?OVRPUndmdnJTZ2dLNllDQW1ER0dOUEJUalR5eGxmM3J4cm00MGxVWmRVVzJ3?=
 =?utf-8?B?YUJRY0tRUi9VQkg1TVQ0L0hoMTlFSHZOVnBLcnE2b2NudHFNOCtsS0syUk5z?=
 =?utf-8?B?ZUNhd0ZXRFhuOU54NTVzKzM5UzF1b0F1UzBVU2RpWmh5U09MeGZ6NEtCYm9W?=
 =?utf-8?B?WWYxb0pWYkM5WFdDd1FJREV2dXBqcjRPZUVDajNRcTNvd3JZclhWY2taL2Rp?=
 =?utf-8?B?NzBscjcwUVBoTFl1UnFLRlNoczZYMlV5L1BLb2dCZWJlM1Z3RkZwcm5EVDdp?=
 =?utf-8?B?ZEthMVlqTFhveDM3U3NoNktIR0MxbTMvQ0o3TDhkQklDeUdXWm5lelVBbElD?=
 =?utf-8?B?WlpncTNJR0ExWFl2MlJzSVNJQ2x0MFBtNE5ibGdCK0Eyc1BCTHRab2VrUWs5?=
 =?utf-8?B?OC9sSUNtZHpKTTR4KytGdytqa2FRcFNtWXBsdVlMSkM5TG14bGV3dGlTZWh3?=
 =?utf-8?B?SXNPbjd5SVhHMERkSVhVM3dwR1M4N0N2QmlaYmdVMmlodzBSVmpmQTJ1UnJq?=
 =?utf-8?B?M2ZLeDk1R3RUUlRQM3BIYVNKZGhPTGxPUlhBS1lHQUc0WVIyc05NRzhyekRs?=
 =?utf-8?B?djZjeUJGQkhxeGdoL2RRQ0lZUkdRZ1UyRU9GQVlUYzIxeHRkMEdPR1N0TmNB?=
 =?utf-8?B?STRVU2VXbm5nMS9nT2ZZKzQrWDF5OWJXaEFDbGd4cmRWc0dFZkhIbVlrd2tO?=
 =?utf-8?B?d2o4M2pHS3NCK3p4WG9rNXRsL1NScThYc0RESnpGcVVQQU5rMzNOekppWm9P?=
 =?utf-8?B?K081TCtYbEo2anFvY29kRDRxUG9nN3NqaXhMOXJUdWxTd2UxTnVNVkx3YTJF?=
 =?utf-8?B?cEpIeWtKVU1LT2FIcFQ2TTlWM0x2MGI2N3N1TTVkb1ZpR0VibFM0VXhFNFda?=
 =?utf-8?B?ZGpMelRnSmtQZDdYWWxhTXJJRERUZ05XU0tVUWxEU0lwbTdydnVIUjFvKytG?=
 =?utf-8?B?cGFoWkcxQzhPZFArbkRYaGxPYXpYSElQSWRKK2l4UXc4TFZIdnNtZXBRT2Zy?=
 =?utf-8?B?VnluSkFqcjhQSk1QSFJtVElQU3h2SllxcDhWRzdkUEgwWWh5SE55NzZnaGxt?=
 =?utf-8?B?aUk0ZElZcE9OejR5NkN4emx5ZXJGY3VNU1Q4MG1XYkNpTnBvb3BFYUJKa1Nq?=
 =?utf-8?B?bTV6eTF2b2JjVGptL0g5TmYrTXNGTXFPZE1OYkp0VEYrdFhwZ2NpQjhYN0xV?=
 =?utf-8?B?dEhhckpGTWZEaUNZSGhLdFRwYVdIYWs4ZGo0QVcvbUtZeVAwZlMyVkt4Z0Jp?=
 =?utf-8?B?R3FUWGRmcGdWTTdBQ05QQVl4SG9XSW42bi9HRmI2Mm1ZYjFzK0drdlBFeVg5?=
 =?utf-8?B?QjRJOWRpNkErY0hkeloxVWhHWkJ3VlpNZ2lKVkNCQTNEUUoyaEltLzJQbzBL?=
 =?utf-8?B?U0QyalFjVmxueCtLaU1UQW5UZWZvblJnMWhEMDJSU3ViVVFNSGt5RjZqbjZP?=
 =?utf-8?B?cjFyWVF5ZVE2ekdVbjRTanlTdWVFV2Frc01HbHFiYi8rMWQ1cU8yVHFzV2FW?=
 =?utf-8?B?NkorREhCZGhyc2lXNDJrYTgzTmpjZTJIdnlSVnoxVzl0Z1kvZGFKOHNJVzU4?=
 =?utf-8?B?YmxKL21mQU15eCsyOFgrU1A0Z2o0NGQrcEw0a0tZMWV3QzF4dE5JQnhSZ1Vp?=
 =?utf-8?B?Z3RicDlSanl6dk5sRGtWQnpOcm5HUURwOTdMWGlVMXJ2SlRFdzdlUFQ2d1VW?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ceVR3lkMXfFpGMZ0ayIV4MFpyL5dapn+AxwaJQ4lYLQWXfTkcHUYzfHhXSCD/imAEXwmdlOVxgkLcpSkHByAo2gvWOHSpvXWpMCsUquENH1Ni1yfgHIkZ8VewwUGAGiyjQ14m4KngVRIN5QG3OsRx5cTwBXlPCCyn/um6wf6rnIBK/AkfFubc3DO4NMmBpfOWYDz3H86cMkbUenuL/aqcMEpMlgk7xrlPPvj+DZs39KMu1WQc30yIEK4LS02oFqZoDOsqLO6VW8cD0L3U0W44SCLsFfybl/HJK4dOJx7SiTP1g+lVcfaPBfbPvvhXSrWEn3RDZtXSi75xOCqqVpZvdDD24R9VQHk8CdgNBhG3+ApAMUYqYD1CrbUstWlOOk+kFu/QpOWT3q7i7K/8HJmBmKEE/zhFQctzyS1OSm+gVQZ/YrCA0hzRB5FNpq5NGw80pw6cAl/xxbdvsleLSnj7aP1PRQUnl+/HBIJbnnhwPgrq2324fyF9Nk0LiZHGby393yGCAST1ZmQ096LfTNrzPRsdMTIgOudaKC7UrHZKeUCBW7V2fOyGwVt3ElLtj0fGIi5CQgHQllgoynxjFDPz+lYqd3ryhGcQqRvTRZLHSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0614c3d6-e38d-4cbc-f988-08dcaa5f2368
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:01:17.5221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+8c/+pNuRt1VJkXQvdjC+C4jcbh+bbZUHButsoErWX5WUdX3GFXwRbdfukkZ3bJ3DDJ0Oc5EcnxX3znr1GhlBWx3e48558xlKY1UUAf6mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220113
X-Proofpoint-ORIG-GUID: c9vEl97YwDke16oNN3n8jetuYibGEcE0
X-Proofpoint-GUID: c9vEl97YwDke16oNN3n8jetuYibGEcE0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/07/2024 15:53, Cédric Le Goater wrote:
> On 7/19/24 19:26, Joao Martins wrote:
>> On 19/07/2024 15:24, Joao Martins wrote:
>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>> By default VFIO migration is set to auto, which will support live
>>>>> migration if the migration capability is set *and* also dirty page
>>>>> tracking is supported.
>>>>>
>>>>> For testing purposes one can force enable without dirty page tracking
>>>>> via enable-migration=on, but that option is generally left for testing
>>>>> purposes.
>>>>>
>>>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>> migration and thus enabling migration by default for those too.
>>>>>
>>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>>> well.
>>>>>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> ---
>>>>>    include/hw/vfio/vfio-common.h |  1 +
>>>>>    hw/vfio/iommufd.c             |  2 +-
>>>>>    hw/vfio/migration.c           | 11 ++++++-----
>>>>>    3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>> VFIOContainerBase *bcontainer,
>>>>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>>>    int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t
>>>>> iova,
>>>>>                              uint64_t size, ram_addr_t ram_addr, Error
>>>>> **errp);
>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>      /* Returns 0 on success, or a negative errno. */
>>>>>    bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>> *vbasedev)
>>>>>        iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>    }
>>>>>    -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>    {
>>>>>        return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>    }
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>>>> Error **errp)
>>>>>            return !vfio_block_migration(vbasedev, err, errp);
>>>>>        }
>>>>>    -    if (!vbasedev->dirty_pages_supported) {
>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>
>>>>
>>>> Some platforms do not have IOMMUFD support and this call will need
>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>> the IOMMU backend.
>>>>
>>>
>>> This was actually on purpose because only IOMMUFD presents a view of hardware
>>> whereas type1 supporting dirty page tracking is not used as means to 'migration
>>> is supported'.
>>>
>>> The hwpt is nil in type1 and the helper checks that, so it should return false.
>>>
>>
>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
>> consider. Maybe this would be a elegant way to address it? Looks to pass my
>> build with CONFIG_IOMMUFD=n
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 61dd48e79b71..422ad4a5bdd1 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase
>> *bcontainer,
>>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>> +#ifdef CONFIG_IOMMUFD
>>   bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>> +#else
>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return false;
>> +}
>> +#endif
>>
>>   /* Returns 0 on success, or a negative errno. */
>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>
> 
> hmm, no. You will need to introduce a new Host IOMMU device capability,
> something like :
> 
>    HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
> 
> Then, introduce an helper routine to check the capability  :
> 
>    return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>  
> and replace the iommufd_hwpt_dirty_tracking call with it.
> 
> Yeah I know, it's cumbersome but it's cleaner !
> 

Funny you mention it, because that's what I did in v3:

https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/

But it was suggested to drop (I am assuming to avoid complexity)

> That's not a major problem in the series. I can address it at the end
> to avoid a resend. First, let's get a R-b on all other patches.
> 
> Thanks,
> 
> C.
> 
> 


