Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46003E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN9m8-0006Ry-9q; Mon, 16 Dec 2024 07:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tN9m7-0006RX-0o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:00:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tN9m4-0005Xz-IE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:00:34 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9Mqpn016426;
 Mon, 16 Dec 2024 12:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UCL7ZdKYUxKFNiONPkmANjh8BdK41wE1PA6SNg00Z3o=; b=
 JBvh7dc/DhtiA0M1v0rdeAGhXMt24QNgzH+amV4kdhHQOpxFMBrritl7tHnLI/eb
 aUAMnXYL8275s8EcnNW44rrOtl5ME3utHjYmWbpiGU6CikFlSn+MbaPaePjSM0Lt
 KLFKOo/i2BieOS7mdzZb95Rwc6CgzgljjrbrKnj+iMrKLjQ+1G0YieTR/9BNUaRs
 /vifKQOHWMDVeiC2MvVp9X7cBNpo1BmC6qj25/QUrW1pTR78w29pB1v+4PPsdbzW
 TeOPcJYLFXyM1O1lp+UoXCCSNlRiH3qXvUyTyb6SqgsB0xbDawgE8B/24MXzWN7W
 8HA/M7qUrsBvxF3hfuRkDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec32g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:00:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BG9qx1w019032; Mon, 16 Dec 2024 12:00:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f7692w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFdU8gRYqM4L3Qlim0tyFtI17jY1XvcRGxszVNLBP917e6XuLMUZr2gZJzgP4Q72Ft6xizMcYeM2Vz6yrTn+o3AZlDdwK80BwWDEtVYRYujeeurIuzvnPJ81ASsklntbkSnxeDfKT0w4THhlU5AZ7/cBdqmgsTr6BjJV8QqP1JUzd+gQiG1mGvnkBRGi+VMvq5qTVbU/WK93J/RhGEW83weD1DSyZLdMhu8fdV97R5X37X0PTvJClG9d6FCPPj48h1ZNthHoojZYw9uR4LyobglaImst4x7V3IvbrCakHJmF1ReDlr5C32vi0h6EWaCWej9BMBgANkxP9Rh2s/hK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCL7ZdKYUxKFNiONPkmANjh8BdK41wE1PA6SNg00Z3o=;
 b=M3HR9XWnrHLFo+lXxG+zjiZesYVprDUHCzN5ttguNyopm72KVZUzUUHV9dx6IJiPnLB6X0WTf70YgxBcUJeeqXbsvbSdPd7OH1PKVsTdnkn6AmwpW89+cd+eGvXmczaKAhIADhjHtAAtUjpONr+57RE0GHnm8h00MUNlzC0SQpy2LAivG4hTPGqZxj3JoaMjHLv8v4Fwihi/2AilqwdhbYtxhBFpxR85GvqpaysBcsZCADEV9AcnmZPiT55/PMvvao7hcagGCYBHY8QtAlLlb461THSk5h2Kxz5zp8NlKUu6KERdxLWcg639blITUbvIbn+XXIHBqb5sHL4S5QvT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCL7ZdKYUxKFNiONPkmANjh8BdK41wE1PA6SNg00Z3o=;
 b=K/lHbhE7nJAGBa0CWD6Q5KKSDnyWMDas9fH8E60l9LV9nEnaLrcmta5xrB7xsyg9PBc9HWK0gab1uPWyPw5lJ/0nMXvuptv1haT1wg02OT+KV0pvSt9upm3TVBOlXRUBBR6H7E7+0SbvqFcfvrBuFoy16+/pshyLFAAjK6p06dg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 12:00:24 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:00:24 +0000
Message-ID: <934927b9-eaf5-411a-8151-7617218d0cad@oracle.com>
Date: Mon, 16 Dec 2024 12:00:17 +0000
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 76be8ee6-8e53-40a0-21fb-08dd1dc9393b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTd3K3dCMStpZFp0UVJjOTBxUVZhaml1eG5HS3lkNFgrWUtxRm1HcW5PTWQr?=
 =?utf-8?B?Z3JuOE1xTlBWYnZHeDdYRkZ1ais5QTgwN1BielNTWmltUmVreUhKbkgzQ1Zw?=
 =?utf-8?B?ZFVQSjBwUXBUaXB5MGx1dGpIcWFsSUZMMk9GMFpWZ0Q4Y04ybjV1NzZaVWhC?=
 =?utf-8?B?VGlTUmxGTGVHdkhwVkU1Q3pnYkpRNExDTTFUNXd1YW13cFcwUjZlUDhFOVU2?=
 =?utf-8?B?Q2hZS0xZcmZIZmZjcVpFN09wUkFFTldpN1l6dElKZDlYWDhhNFpPUUd5Mlgw?=
 =?utf-8?B?SjVNZC9WR25uci94T1h6N2hmaDNaT1lhektwdGdoYlBXb3c3TFVHVkhTQkNO?=
 =?utf-8?B?V1M2cTdOK2VQcHVzOEJNYzcwK0JtUWxzdjZFelNsUEpPMnVPRUkwTy9kNjBF?=
 =?utf-8?B?cXhKdnU1VERWNjFDZGV0S1pBWlJXOFJMdElxY3VRaCtJRDdnR3lSSDBxQ2Na?=
 =?utf-8?B?VXpyZCtmejhMdFltZG85WEZjaXBSbzN5TVVoNXB3SXFGYUpQbkN6amFrUlA2?=
 =?utf-8?B?bDVCazZsaGxOdEVjU1dFWnF6b0UwMVdQdjgxcHhCbHpiYjBlRlVpZGhXakdn?=
 =?utf-8?B?bkFDKzhQVmNNV2tzNUc0emNPM2c1dWZOUktweVRpYkR5SWsvZHRaZW9SQWJ4?=
 =?utf-8?B?WnJDNkRPMnQ2bG9mOVZDNDR0U3pIc2xGdS9PUk1VYTRoYTFlR2VIclBlZklI?=
 =?utf-8?B?c0luelIrOFJYZlVPekVHczBQYlpaY0Y5c3k0cEYxV3FZVnJiT2NUMTk1SFc0?=
 =?utf-8?B?SDlweU4wcmphT0xBOEdvZkg2UzNpd2hCcXo4WExzSHhRVEcySVN5bElMTE1k?=
 =?utf-8?B?aWFMV0hhUXNxYkVacmF5RkJMZTc2S2NTRHlDNnZDSWVyc1VUc1l1VDZ1VTVO?=
 =?utf-8?B?WmJjSVZlSmt4cHc2MU5qQlBJYkRUREtCVHhzV1FCbUgyd1pYQ2NScitCN2hM?=
 =?utf-8?B?d0Jlc0JXK3g1QTNtcWVZZ2JaY2tNVEtmd2NCZVkrWUhjM3dBUEJ5VXRPNmZi?=
 =?utf-8?B?VUJMRk1SZE1lVi8vUENUVEJNSk5ZSWZDK21lMVVtZ2phQ0YvaThyRzlOZUpI?=
 =?utf-8?B?WVBjcUVESllTTGVaYXlsOGNJMHpXM0dXUkEwVS90VXhhS1dRUWpVd0dzRlRE?=
 =?utf-8?B?emJ6RklNNk93dzh1OTJFOWhVeFVwOHVUQlh1bFcyU2RYY2FTY0cyQzFNZGhi?=
 =?utf-8?B?UGJrYlAwaWNVQVFYVHUvWGlVWitlS3p5SnJYTjZXRzA1M3JsT3poRy9zOGk1?=
 =?utf-8?B?a3dRTDZFYWpLbWtKOGZScDd6R0xKdmttMkVWZXdlb21PTEZ0a1pCcWdFK0VP?=
 =?utf-8?B?bFNWYk12UFJvekZoeFdwelZYOVhBbThPQkNFTW1CWXJTT0drQ0FYRUIwai84?=
 =?utf-8?B?NHc5RFhXclpsZXM2NzMzcjdUK1RLekYyTFRCK0ZiTkxBRlBnN3FqZlYrdzRX?=
 =?utf-8?B?dU5MbVBWUDk4aTdJamR4bSt0WjJyaWk0eUl2am9BN1p0WWJvcVJIc2M2d2l6?=
 =?utf-8?B?Z2YyaGQrcm12ZUZZU0FIZjVlRDZ1RmJqaXByQXFxalJxQ3VDV1FDQUw3UThQ?=
 =?utf-8?B?c09COW9pSVl2VzE2djE1cmRGV0ZvVHNKbmgvYUxxTjNZaGVuU1VkQjJ6Rldo?=
 =?utf-8?B?dDkvTEI4bmovQkJXNWk3T0hLN0dYMHJNRDdQSVNEMlVOaEtJTXJ5NExUVExr?=
 =?utf-8?B?QkhLNFpDSFFQZHFXcGJBZjIzYWpBQTE5dEVndlZMMU1zbWlwRGZxK0pZR1JV?=
 =?utf-8?B?SExOUEMxZTRyVDluWTkrai9pMSsvTnVDOVdqdWRhM3Jtc1pxeG1qRndNSkho?=
 =?utf-8?B?bzJqOG5ORHMvTzRpYkhURW91MG52Wm05VnRxTnBSa2NlUGttQ1EyUytwbU4r?=
 =?utf-8?Q?Lw5FNAHS91HaU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDVCZDJCTjZYRHFoYlBPVVlJanovWFJqNmV3Y1RtdGxSd05BeGdIRnJzVmpR?=
 =?utf-8?B?aThVWjlOam5iTi9WeWxhQTJoaFljNU9GMHp2WktRbTFCdjQ4a3FvWGZwYUov?=
 =?utf-8?B?SWVDSncvNHErdWF0aHkvdnZrTTB0emkzYWcxZ0tISEcvMWNyS244Nk1KT0Q4?=
 =?utf-8?B?SURIRThHcEJidnNvYVpQc2NoUzJXeFZYdHNFQUVSYUNpU1MxZDF1aktLOEJH?=
 =?utf-8?B?NDhCNDR1cXVEdm9tK2dXL0RRbHNQYktldzRmMXRvWHM2Y0Fya1h2NktRcmZq?=
 =?utf-8?B?dVF3N0tmaE1nUUZhNFN0UGdxVHhNMnhkbmZ6RHhDNCtHRTkzQk9FdXdvdm9y?=
 =?utf-8?B?WTJPblpPeVV5Lzh5ZnBlYWljdVJXWHhjVG40Q0p0Vjl1cWxrS2RiOWRvQi9K?=
 =?utf-8?B?MEhSSmNHUm1EK1FXUEVXakt0aXhjUnFuUGZ3VUEwVVgwTVRNTjk1cjIzUW01?=
 =?utf-8?B?a2FVZXB5a2M3YTdIalhqY21XMVBpL2hQTVJoTmdaaEhzRVRZdVJ2MUZadG1y?=
 =?utf-8?B?dTI2WjMxZCtoU1MvMkRDckdlZjJpbENYL0NFaThxS3dqU2FESC9jTktGNEtR?=
 =?utf-8?B?QVBuZFJhOVcvbmNqaVJhSUJzdy9qL3I2NzR4WHhoYWhubk1DdUFNQlZoeS95?=
 =?utf-8?B?NHN3NkcyYjB1K0wrbFhCRTJvTXpqWVF0NFB2Uk85cm5oMk9LSFArQndOdXgz?=
 =?utf-8?B?c3ZXb2lhV0tTS21la0dMMU5wR0VVeUovdTBqL09SRVZMSFI5bkxuL25ma21J?=
 =?utf-8?B?NGhYMVE2dm5KZ2huSlR2cHZuR1RQYXY0bW9Bbzc5L0o1dG0wZ1djNk1iRFFl?=
 =?utf-8?B?RC9xcThkMllyaTRpWU9NMUsxalI1UWdZMFlpQlZhaGk5NEtuemsyQkhLUnJH?=
 =?utf-8?B?SVRTNnphMDlRRFFmaU9TR1RhaDBDVUxRSms1NGpzQkVhSUpmODY1aTJLL0pa?=
 =?utf-8?B?OWcraFhjdnlDNjVkRDliTFRIaGs0cEkxbmtNMTdYNnZSc2J0Wk5sQ0JuK1hQ?=
 =?utf-8?B?VTRZU0hGMlpTMXpmbEY2NjRvSE9vSmlYYlBWaXY0d0ZjRElhY0pzYWlzWEhW?=
 =?utf-8?B?RVcrdEE4VFRSMm8rWkZaTGZSSkR0LzhNWm4vN0lLMldZNHlDZnUvNXErQ1FQ?=
 =?utf-8?B?QWh4dmIxdWh0ZFNxNTZDRHpoSjN4amlwa2IzV2V6YXR1SHE1aDNxQitGQW9K?=
 =?utf-8?B?c3dpMVgxOW95cUJwQUZoN2d1R1Q2QzhqdnFjUzZlL2JQTGZabmZZSk53NUVu?=
 =?utf-8?B?N3hWZTBsckFqQVpOemIzekxBK2Z4NS8zdURyc3M1UHM1eDBJVU5zNHdsdm1X?=
 =?utf-8?B?SHhmOGlaeGk1QzVYaHE3K0F3aVBIQ3lKNkxPSG9iUnQrTjFhcjlrWFU0RmpB?=
 =?utf-8?B?ZmFiNlNUbE8zaWdGcnVrbElKNnhuWXoxMHpHd2RiNVFDV3k2RG50WXZFblcy?=
 =?utf-8?B?ZGR3aUpTYXNvZW11Um9Lc3ZZaWxNVXdGclZJN2kyQmVBSjZha2lXN1JEUzk3?=
 =?utf-8?B?MHhqZ1gwelZyVUZKcThSQzJZeHhzZTRxaVBjSlB1M0l6T2s3c0dyTm15cXBE?=
 =?utf-8?B?M3dtbGEybkFVbWQwSVlxSlZHSWRQT0ZDMkhCdmJZb05SOWlTTm9EUUg3REJ0?=
 =?utf-8?B?MGtaUnhlakJsaVZRaUhkQy9BQVo0YUd5ajIyd0xETlVSMnJsZ04wMTFpNDFR?=
 =?utf-8?B?UFMwYnJTZCttNVYyZTdqQ1RTaS90Rk9xVkdRbzNuQnZhbkd3MFJ6QVVwNEtT?=
 =?utf-8?B?YjRBa0luYVlQMmFXeVd2d2dWVUw4THZYMU1RdWJwS0JkTWlQVHQyQisvcEs4?=
 =?utf-8?B?YmZvRWF6d1huZzRaV1MreHpYdHFOWUNHM25KL0tLbWtMNC92RWR1djJIbjV4?=
 =?utf-8?B?Znl4SEYraTRsQytEdDFSN0VtR2pTNHJ0U1lEc2Q4cUtPbGRxbXY0Y3hERDla?=
 =?utf-8?B?VE5NSkRXYkRrb0xZYUtzS3EwQnR6ZTgxa3JmTWljZlBlWDJPUEQ2akFmLzlx?=
 =?utf-8?B?eVUzREJxZGpNdExFdUk4b3FmeUZnbkluempERFY1TUd2T1VqQmVzWWhQVnlI?=
 =?utf-8?B?WVZ3cXdKRkJzQm05RXJoYUEwU0x0SHI5SGFXNVhlQ1c4Z0dTYnRGRC8wb1Fy?=
 =?utf-8?B?akJwaDVlbm8vVUloc1M5REp6d0M0V3UrZTl6M3FVY2FwVE1OcFYxaU9QYVhZ?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PLhl3c/9Qe6z+r0TGcnyNO++hVxtabKBJeAvxUvX70N7cn8D6tEBLXWLZNjjaeUV39dz/GqJWEf2jPaxrdDTrFkLd+rAWhhYqWunMZerxVXWKgGbkkvWhBZnIHpc0katGG8F2bhJERASIPWhICqgkR3tsLKZoUfG9TgIZ5PrHg9r8A1p79qIqMxJEXy5SlTx3yfyjAdr2+DA/YZOkWvldy81cH9g7MEV0+Y3Ra3t7CqyB2g1l9g19UCZxHIK3XvaxVMoi4JgvOJEVjyYhjfYBUZoD4PVHWIUC+daBbUHvgm+93WFgxocm37Utr4jZ7cG1wGCftw4J9Wvi9ihtAjXoMJrmDxGYWI0jHqHgQpMJxPEv7X+VrkgxpW+hBvQoZ6tgiD4yiTYbAvDL/RDpOd8L0AZT0tW5hKKRqPCGA2a7q3dUhpEzb0rxGFs+uJqThwwT1EE6BkDAn3OXy0kolq3oJC/PBGk3K0w6MKx0IobYtSN1Tm+0LgxEgfSILOyLO4/HX9VkkXI32OzK2ghl0vpcyrrNlXfw8/4JV/FUcdUzOmw5seBPNm6u1/JywitXVqZE3lIT3rOEX4wS8d+d9x9tzLFfzi5vmmQafj97ytFIz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76be8ee6-8e53-40a0-21fb-08dd1dc9393b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:00:24.5234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvg5TIH/rcBKk8OooEYvyB1aHUBVcinf6NLsTO34+roy2Py/rm1Or5yaMf0XodhX9//dxpB3dnSF+T9BLO4JdIouLyi5yKYJuhh7aEmMQxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=869
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160101
X-Proofpoint-GUID: FVkBZLQX5eC4DNcdO5rmEIG4UTTjm8bf
X-Proofpoint-ORIG-GUID: FVkBZLQX5eC4DNcdO5rmEIG4UTTjm8bf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16/12/2024 09:46, Avihai Horon wrote:
> Hello,
> 
> This follows up on Peter's series [1] to simplify migration status API
> to a single migration_is_running() function.
> 
> Peter's series tried to drop migration_is_device() and
> migration_is_active(), however VFIO used them to check if dirty page
> tracking has been started in order to avoid errors in log sync, so they
> couldn't simply be dropped without some preliminary cleanups.
> 
> This series handles these preliminary cleanups and eventually drops
> migration_is_device() and unexports migration_is_active().
> 
> The series has been migration tested with the following:
> - VFIO device dirty tracking.
> - Legacy VFIO iommu dirty tracking.
> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>   currently blocked, so I used a patched QEMU to allow it).
>

vIOMMU on IOMMU HW doesn't suffer from the same problems of VF dirty tracking
where there's a aggregate limit into how much VFs can track in terms of IOVA
space. So we can lift some of those restrictions for IOMMU even right now
provided we implement the last remaining pre-requisite. I also have a much
smaller series for that sort of unblockage that I can give you a pointer.
Though, eventually the optimizations we will do for VF dirty tracking for vIOMMU
will apply to IOMMU HW too just so we minimize the amount of calls to get dirty
bits.

> I didn't test it with iommu DPT as I don't have access to such HW.
> Cedric, I remember you said that you have such HW, it would be very
> helpful if you could test it.
> 
I am starting to prep the unblocking vIOMMU for Qemu 10, so I can validate if
this series works as well -- but from what I have looked so far it should be all
OK. If it helps I have some pending series that lets you test emulated x86 IOMMU
DPT support (either on intel-iommu or amd-iommu) that can help you when you
don't have the hardware to test.

Regarding this series, since you are looking at the the dirty tracking 'status'
I'll comment here too as one of your original patches introduced it as it's
related to the use of migration_is_running(). And since you're looking at this
exact part of the code, might as well cover that too.

