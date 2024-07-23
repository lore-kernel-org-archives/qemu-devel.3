Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A3C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBKc-0001Sg-Jx; Tue, 23 Jul 2024 04:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWBKV-0001Ri-Jh
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:57:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWBKR-0007NV-5P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:57:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BYBN028959;
 Tue, 23 Jul 2024 08:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=KrwqH55YXyaKnstW8cXJL7EUrLWy2h60gWPGYBUcSq0=; b=
 gwp1sA5wf2cXHGw4t8YIfSTy9hr8PtCgWu7HJgZSg6MgMouPFIsZJrKvYgToLFaY
 SX/x3ZZyotwfMj9H0gv5han2JCHs+bUbh4zaWz8P8sgtZHZ7Ld1pRZt/rcXwUZJS
 mmPL5+LWc885UYyiUOi8CAwZeFFEjk2/7XJTa51hGvhiD1SbspcjQvyR0n4EYukD
 gDfajyh2dYLNn6e+WXMPnpfXsw1XCca+xByzXWpP6cO4nYalK35ODa4myrDfPSmY
 wbm3AvwsDOxDKZfitBP4+c4Y8W8zzrLP2nO1I+OnG9Tkm/chlrHQGySeSP6ebhiv
 8/niuOX3v3X4lc0I+yD/CA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt5s67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:56:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N7qlLN011043; Tue, 23 Jul 2024 08:56:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qw2fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PycxF+uMGUpskJ42xXnNvHa+3Lc7B/HaKpvgAzyXlkRxuWyByV86Nlkve04a7onqCWbEEQpn0rhdwiIVT+BuUlbWscRvpRAbjpemzoT3VB4c9Emi3jJIxDvGWfGSWUw8fGW/i9n/zSlau9lJu0G2JvszC7Ll8LeFA5/U+Y3BGlMMqTU/bvdZPS2mXidhAbcxg15amdv4fjWJzvLklLhCAdDztgzpsZEBn/V56PUm/Dszl4welnkldwDTEX1BQojH5roMZGqA3S6VTKlvbsgvB6EqByR8RLwueJLff2BwjHmnT8tPD4u5lOhPQDvF1y1V/y30mN3Al9lfistSz3WA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrwqH55YXyaKnstW8cXJL7EUrLWy2h60gWPGYBUcSq0=;
 b=kbIcgXS/ijuWeL8w2V4jpeM52ByLg63fAX6skoCIgNzRsfbcIQw+XdNh2YsAEM8lzEswwN+jHAZ41YY2FapR/qANvZjfqSOkZyA4VoucXnrTOkxnJ+pw1MLVgHLxXtHgsINYhYXmgvE0rH91AdtlH1vT7TIzE6vVslNbu0ZNN9+LHrHAt/cJD7Fkbbby/3wK5MGfoo5TPu/BsPlcoFuENHOkm7TvFOCrJxpA2W0qaeR6vXbsLYjAwPLQV9q21+4fPFdjtJN/jQd6LaF6o3CQbIemmpUmSiPCJ3OSHE4YBrrH2+6r8+79tHReMKRWrap0IpfXfkVQ6LGeR5OAuFSZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrwqH55YXyaKnstW8cXJL7EUrLWy2h60gWPGYBUcSq0=;
 b=YM1ekL7d2XGgJOHwvHfxB1yY08S2E5Rq9rf1O2fNTo3khEyqkebOgr2cWz1Tyv/rRDbVk+jBOA5Z9PRz0I7YWKSGtIRxrePrN3QKPHq/sxiIprd/dKGtuDlgD7p9PfpGXcup/UQPKDlaLf5zyYXGe9cG93JsIij4y9aub/PoiMI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 08:56:53 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:56:53 +0000
Message-ID: <511424c2-90e3-4751-9776-1a677b6ecf15@oracle.com>
Date: Tue, 23 Jul 2024 09:56:47 +0100
Subject: Re: [PATCH v6 0/9] hw/iommufd: IOMMUFD Dirty Tracking
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <11941abb-d401-4056-b293-ef5f1fd3756d@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <11941abb-d401-4056-b293-ef5f1fd3756d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: f4453b98-3019-4dbf-795f-08dcaaf56584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0M4TlBjY2M1VVVzUjM1MDJMK1ptcVNocDlJUTg5K0cvUEw2aUJhdzlDbHRQ?=
 =?utf-8?B?SklId2xpa0dVQkY0L1QxaVFBWmNMSDhiNlFBS0Nrc0p4d3JBN1JJV0ZDMURq?=
 =?utf-8?B?ZFpWNjJUWmordUExM1U4Z1VUL2FUYjZyYnN6SmF3L3M1NTgzUTBiQmpobzdt?=
 =?utf-8?B?V1dWVk81U1JubENZNjhEdUp2bUZjdWVFa2hkQWYvQU1xQXRIbVdmbG5rQWRz?=
 =?utf-8?B?V2pINmRWVXVvQ1VOaVd3SUMrdUFhWDdiQjVDRHlueHM2MDlSNkVXWlVERTJR?=
 =?utf-8?B?blVnWHpCWGNHRlFFWXpDSi8xMmFiMWRzTFQvZjhuM3hZNDVnSUxCU2ZKdEFx?=
 =?utf-8?B?N0pDUXpkbjdDd3M4REpNUWdlcHE3RkY3L2tYSk5PMFovOElMTkIvLzlQSGtK?=
 =?utf-8?B?WUZYMHpCM3hoc1g1aHB6VjhpTXNpY0puMmQ5RjBVWEI1REFldWxDZWE2NGhC?=
 =?utf-8?B?KzBJTGdVSWNxTU90eHpGUkNGczdLbGFvRVFIU1dSclhsUk9RNWNqNXVzUlpw?=
 =?utf-8?B?eG1xS01tdk9rclN6WE1KM1cxQ3REb3JyV01rYWZ3K2M0VCtqVFMwcm0wTXBB?=
 =?utf-8?B?U3N0aldBa3hQaWEvTG1hU2lUaitUajY4Mm5LQ21xdWVOeEk2OUhGVXhnbzZN?=
 =?utf-8?B?SUVMa1p6bG5Oand6RE9vTE9KVHpqWUF0TEdPSlBNU1pmUlR2RUltNVpVSXZE?=
 =?utf-8?B?RXZXNGxSSTlHUWNiejZFeWxsMjRQeVpDbWxZSFFKaVZ2NWYxWDdqbXRuMllU?=
 =?utf-8?B?VGtxeC9keFRaaTdwUlYzRm84WnB5NitMdG1iOEo1S05YOE12Z0JMM1FJOEor?=
 =?utf-8?B?SjBiN0hiYTY2MDZsSE0yUFpJRmREdk4veTM4Ujg0U0pTNng2UThRaVVXN09s?=
 =?utf-8?B?dGRad2pLcnlqQzRtVHNBWlRZa1Zsd01lUE5JQy9UUy9HMzRXcFYwdGxUemhY?=
 =?utf-8?B?bDFuR0FZSWlrdEVOK0YrdmtwQ2JwOWgyWmxUcDluZlFkQjc0Q3I1OFgvOC9M?=
 =?utf-8?B?NDBVa2RlZ0w3M1VLMXNuUDJ2SllVSVlFVDdCdU9nNU16cisrNWxrOUdMV3Jn?=
 =?utf-8?B?QkNXMlIvY2l0dGNrdVEzV0lTYzVpbzBWMm5hOUhjOFI4M1hSYVg4SzFiYW5m?=
 =?utf-8?B?MEpwVFNnRzdDdjRoSmRwTkVvM2wrUTl6VVh3eGJ5N0VCeDZ3TVgzN0NtUUJX?=
 =?utf-8?B?VG1EZGVyTlRhZEFydU1nVk43V3djSmFZdEVMWnF2MHJJaW80UWNyZUF0N01w?=
 =?utf-8?B?WDY0NHV5bkVnUmpRZEt5REkvcWgvbng4TjZ2R1k5eCtXVDBtQVZEU2o1NTRt?=
 =?utf-8?B?WlZ5YUplT2F5VDN1aDVRb0ZURmpWQ3VXR0lqaUZ4aFRaTkx3dVVQSTV2TUxj?=
 =?utf-8?B?NlRBNDFpK2U0N29LMmJ2UzEvd3o3MGxKVUIramFqWE5DbUJNd3lhK3JaMitH?=
 =?utf-8?B?NGtUaytNOFpuT1hjTzR4WmIxV3RKRnI4YXI1aFltdWtuQWFsZHljT3JsSUoz?=
 =?utf-8?B?WWY3dTFQaDhDc2FNdE5iQlFRcWNvU1hYRDQ1bzROZVZiQ0VCMkc4SEJnaGMy?=
 =?utf-8?B?Q0FPY0RwUmVUa2NEbzR5dUJ5QlpSWHdERFRqNDM5Z1ZTUXlFcWV5Si9tVDdi?=
 =?utf-8?B?b1g4TUdXYzZZalpvWUpuUHY3QnRuc0duK2ZjN2xZSXU0Mk5pM1JPcnFqK3RH?=
 =?utf-8?B?cmM4TU5OdXo5dnBjbkVLb2hEK3Q0NUJ2YytReHlCeU5iM3VwU0JqMmJUT0tN?=
 =?utf-8?Q?0vsXCkc3ionSLonnpnbLnUbXh5HThGgEqqeZJII?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUpkYWFvTE5QZnBqd3JVSHBJMjJYY1ZsOEZUcFByUVBXdk1hWFFtYnBoeEV0?=
 =?utf-8?B?M3VlYlRGak1KMXZWdGVwYTlFV2I2NjJuTk15cXFEYklLZlJyWTVDVWZCVXVD?=
 =?utf-8?B?YmdBT09KeWRMWHdjUW5lOG9UMXNuWmVYL1ZITUJCeWRRU3RjSG5UdDR0ME13?=
 =?utf-8?B?WVlYeGRNU01FZlp3NCtFYW9FU2JBOUxyZmJRbkdid0ZDK3hBSElDK0NjMVRi?=
 =?utf-8?B?Z1QvL2drSmdDY0ZHZWFuclF0NXZUaFZwODRGZHVyMGtPR1lvdmxpSG1IcEhN?=
 =?utf-8?B?alRLYkJjaGVQSTBEdzFxVStYakNHays0MjJwZ3VTV3pkUE14aDNpT3NPOEJY?=
 =?utf-8?B?dDkyVC9VWEkwUFFrcjdrbGM1b0VLVHJDVzY0R3JrSjRVVHNoeUNPS0tBWmpF?=
 =?utf-8?B?MGtSbHgyZUl2NmpyQkZyTWZBTUZ6N3JIWGtJcm1YK1Z4bHV5TnFuTWpnSTkv?=
 =?utf-8?B?SHhZVExJQ25pRDBzSnR2YWNWOHl5cGdtc0FFZjFXRkgvQ3h1TnhYN0NDMGQ5?=
 =?utf-8?B?Y0xISTV2ZmRyTzhMOVdZMCs2T1R0MHkrZ1JvM00vMXZVczVZa3l2ZlZNcjND?=
 =?utf-8?B?TFVKemF0VTdRcDVqWFZBUFRMYmVNN1pOcnI0eUhvNmk1YnBhK1VFTDF2MzVF?=
 =?utf-8?B?cHppOUdWMzA1T0loTGFQUzBjQXpIR2I2OG5oUytvVGlXcExHejRSbHBWL1Qw?=
 =?utf-8?B?cEhoN1ErL0dXOFJSTmxKR1I4TGFOb1lhWHlZT3owOEZ2cTlSckgvTmM0WUo3?=
 =?utf-8?B?aVVpakRndVlwTlpmaXdQNWVOODNKMWJ3akdGTHQ0Q0tDR2NxTnJmYmQ1elNK?=
 =?utf-8?B?dnFPQ2JWVkhaMVk1dDMxdzhiRm9iZExUUFpyay9jeFU5MVJOcFRCWThjeUFa?=
 =?utf-8?B?dVd4dVRLMjZNNzgrSUE3bHlZZFBBMXh0M0k4Um1ZN3VVdEhxMjdSdkRRdHdr?=
 =?utf-8?B?b20wZDl1WFR3cCtTYzZLdzZsd2pycHZtY01OYWFiNWFFUzBRMS9ZQ29OVTYv?=
 =?utf-8?B?enRWMTdMYWdrbFZTODJWVDNnRjAzc2lob2FtRjhKbWIvNlFsNmozcTYzc3Fs?=
 =?utf-8?B?R1kzVjM2dk80VWMrRjdiN0pwWkVqWGxVN0ZXWXpNeFZhUjJyTUxLQUh2b2xa?=
 =?utf-8?B?WUhYa1pwd3ZyNGNoa0ppcTRnMkpMMG56czQxbElKTENpNkhnWGNWNGlxeTB2?=
 =?utf-8?B?U3djRkljRjVBL3YwYmZ6WTVvamx4UFFEQ3B5aWRmY0hGMS9FRWt3Q2dGSmxN?=
 =?utf-8?B?SVpsOUh6cExZK3pUVHVyN1p3RnMvb2dIM3kwMWRhVTgxQ0UyYmt1bHp6aXFS?=
 =?utf-8?B?ajhnV2Ywa1VmamhEYXg1RGhEK2pES1JLNnR6bFlFTmt5R29RdlZvM0J3dU9x?=
 =?utf-8?B?Y0ZDdnhycGEveVdsSVQ5eXBqWEhLbGt2UUdFU2RNNGtRNVJhVG05NkVUSWY4?=
 =?utf-8?B?RzVHL05vWDNBemx1anpQdFR2UURuamticU9hckVDdnNQQUpta2pObjFvcFlP?=
 =?utf-8?B?bXNnSFBMMzVEeHBTZ2cyWEZMcU5PMkhsTlFOVzFQKzlLSXdZSzEvK2hnRnc5?=
 =?utf-8?B?NFlVekFydzJqTFJsVlJmRlZDc3lYTUdBQTZCNWo3aHdnR2JabzFSbFZzbm5a?=
 =?utf-8?B?QkExWFI3bFhCZmVKSUlFLzVKY1hrajdtUi80cVJRU1l1cUI5bGxlbVA1UnNv?=
 =?utf-8?B?d1l6c2krWWtOK09xMUpNSW5oaW9TdC90ZW5QRkhBdDlTaWsxN3doMS9pNzJE?=
 =?utf-8?B?UHIwOTF0cWkydXdUUkYxcEdNdXVwVzl0V1R1KzNacjk2YS9hUjU4Q0ZucVFk?=
 =?utf-8?B?cXYyNllRa09NcUs2OHBBSVhoL3BZb0d1OEM1M0duQ0Zqckhsai9FdUhUak5B?=
 =?utf-8?B?K0RNZUdtUjlRVHQ1VGhjd3JUV3A1QS9LMzVMZTNXdUI4K1FEZnVOL3UvTVlP?=
 =?utf-8?B?OVNqUVB0T1NiK2FNMXU4am53ZlJ2TVB2U2dUdUZQM2xpV3JWZnc4MGs4VXpW?=
 =?utf-8?B?TkVzdWRtRS9PU1pqWTkvQUVYblRiOE5EYnFnNGJoWEJuTm5jeWpGdDBNZ1hR?=
 =?utf-8?B?cmIwL0VzbDE2UEZSSFhzR0U2aFZ2K2VoclJscWFsa0hWSlBxcGU0aENSbHc5?=
 =?utf-8?B?L0EzMnp4ajU4cktWZlAzM3pZMXJuTm9vYnNMajgvMU5aTXVualdpRXJtZURO?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y3C9hcNMIYgi0tWxDLxNct/bb+1JiHp8XdW/UNWbpW/XoM0IE6NRH7TrcchmklRItg8yFnADNjUq/DDSjEY90nCBuJwdqaRFKM9KriBwXarC9y7HxJD2Nc+8LTIpOUcbCQA5v3WMl3dOX3d4aR48sbX1+YRXeAgG2ePdMZgrjnMhqzMiFmch8JwTqMIJtX5KZaUx+WRWKLyR9cWJfgX/Md8aLDj2cMmGRLu1opcFaHtwVp+cgEV9fjLP34YK8OOhrohwhaPVNPFIIuI60K7NNhjmzk8A3ii/9EWUDrJ6Gn5m6/zMuv17X3o2cf24wDCLnrHrzH4wL5IdmRx61kMSwZ1ycPbsUqqlcZ9LfKVsb+ckrRgXciCwZDrNM75RjIThHpE3pzFXrn9PneNNkM6N2O+nynzZLoXoywqtwNzNgWXJn10XyGzth7yzTIF7bYqE29Eojq8eNvObLWlPY6OA7HpY2JS4FEedOboRWq2JOGpPze4ezD09/YKvFOLZfsFCM07OJmwxb6qP/1gIixuWCKz64rPaILdQLnc0Zh1IJhCCVZ2j6yKARjQ/wYx8Yru0SA9I2awqU4DfPn5Ay19kofIP/f0clHiCVee1fezT3Zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4453b98-3019-4dbf-795f-08dcaaf56584
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:56:52.9646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJfsGHGZJDSHDT0onMWzeu0OXp9tjLg5R1C6CBF63gnWmcqeoM46cpkeHBbqE4qLIyh0uPMEL9zVfUWNkd9Zuud6FgCjofi0Icn0Yiiz3H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230065
X-Proofpoint-GUID: cJCAU5wviM1_tqEebTnLgrjvOawCIOMn
X-Proofpoint-ORIG-GUID: cJCAU5wviM1_tqEebTnLgrjvOawCIOMn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 23/07/2024 09:35, Cédric Le Goater wrote:
> On 7/22/24 23:13, Joao Martins wrote:
>> This small series adds support for IOMMU dirty tracking support via the
>> IOMMUFD backend. The hardware capability is available on most recent x86
>> hardware (and these SMMUv3 in upcoming v6.11). The series is divided
>> organized as follows:
>>
>> * Patches 1 - 7: IOMMUFD backend support for dirty tracking;
>>
>> Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
>> we will find and attach a device to a compatible IOMMU domain, or allocate a new
>> hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
>> workflow is relatively simple:
>>
>> 1) Probe device and allow dirty tracking in the HWPT
>> 2) Toggling dirty tracking on/off
>> 3) Read-and-clear of Dirty IOVAs
>>
>> The heuristics selected for (1) were to always request the HWPT for
>> dirty tracking if supported, or rely on device dirty page tracking. This
>> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
>> tracking even if we ask during hwpt allocation.
>>
>> The unmap case is deferred until further vIOMMU support with migration
>> is added[3] which will then introduce the usage of
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>> dma unmap bitmap flow.
>>
>> * Patches 8 - 9: Don't block live migration where there's no VF dirty
>> tracker, considering that we have IOMMU dirty tracking.
>>
>> Comments and feedback appreciated (on patches 1, 5, 8, 9)
>>
>> Cheers,
>>      Joao
>>
>> P.S. Suggest v6.11-rc as hypervisor kernel as there's
>> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
>>
>> Changes since v5[6]:
>> * Remove patches 1-4 as these were commited to vfio-next
>> * Add the Rb by Cedric and Zhenzhong (previously patches 7, 8, 10, 11)
>> * Introduce VFIODevice::iommu_dirty_tracking and use it on patch 5, 8
>> to store whether we can use IOMMU dirty tracking.
>>
>> Changes since v4[5]:
>> * Add various Reviewed-by in patches 2,3,4,6,8,11
>> * Change error messages to mention IOMMU (Zhenzhong)
>> * Better improve the checking of dirty page tracking in
>>    vfio_migration_realize() to detect per-device IOMMU instead of using
>>    container dirty_page_supported().
>> * Improve various commit messages (Eric)
>> * Extract the caps::hw_caps into its own patch as it was miosleading to
>> be hidden in another patch (new patch 7)
>> * Restructure patch 1 helper to be vfio_device_is_mdev() and use
>> vfio::mdev directly in rest of patches (Cedric)
>> * Improve error messages of set,query dirty tracking (Cedric)
>> * Add missing casts to uintptr and uint64_t* (Cedric)
>> * Add missing commens to struct doc from aw_bits removal (and hw_caps
>> addition) (Eric)
>> * Fix the detach flow in auto domains (Eric)
>> * Set hwpt to NULL on detach (Eric)
>> * Spurious line (Eric)
>>
>> Changes since v3[5]:
>> * Skip HostIOMMUDevice::realize for mdev, and introduce a helper to check if
>> the VFIO
>>    device is mdev. (Zhenzhong)
>> * Skip setting IOMMU device for mdev (Zhenzhong)
>> * Add Zhenzhong review tag in patch 3
>> * Utilize vbasedev::bcontainer::dirty_pages_supported instead of introducing
>>    a new HostIOMMUDevice capability and thus remove the cap patch from the
>> series (Zhenzhong)
>> * Move the HostIOMMUDevice::realize() to be part of VFIODevice initialization
>> in attach_device()
>> while skipping it all together for mdev. (Cedric)
>> * Due to the previous item, had to remove aw_bits because it depends on device
>> attach being
>> finished, instead defer it to when get_cap() gets called.
>> * Skip auto domains for mdev instead of purposedly erroring out (Zhenzhong)
>> * Pass errp in all cases, and instead just free the error in case of -EINVAL
>>    in most of all patches, and also pass Error* in
>> iommufd_backend_alloc_hwpt() amd
>>    set/query dirty. This is made better thanks in part to skipping auto
>> domains for mdev (Cedric)
>>
>> Changes since RFCv2[4]:
>> * Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING even if
>> we end up not actually toggling dirty tracking. (Avihai)
>> * Fix error handling widely in auto domains logic and all patches (Avihai)
>> * Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
>> * New patches 1 and 2 taking into consideration previous comments.
>> * Store hwpt::flags to know if we have dirty tracking (Avihai)
>> * New patch 8, that allows to query dirty tracking support after
>> provisioning. This is a cleaner way to check IOMMU dirty tracking support
>> when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
>> device caps way is still used because at vfio attach we aren't yet with
>> a fully initialized migration state.
>> * Adopt error propagation in query,set dirty tracking
>> * Misc improvements overall broadly and Avihai
>> * Drop hugepages as it's a bit unrelated; I can pursue that patch
>> * separately. The main motivation is to provide a way to test
>> without hugepages similar to what vfio_type1_iommu.disable_hugepages=1
>> does.
>>
>> Changes since RFCv1[2]:
>> * Remove intel/amd dirty tracking emulation enabling
>> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
>> [Will pursue these two in separate series]
>> * Introduce auto domains support
>> * Enforce dirty tracking following the IOMMUFD UAPI for this
>> * Add support for toggling hugepages in IOMMUFD
>> * Auto enable support when VF supports migration to use IOMMU
>> when it doesn't have VF dirty tracking
>> * Add a parameter to toggle VF dirty tracking
>>
>> [0]
>> https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
>> [1]
>> https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
>> [2]
>> https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
>> [3]
>> https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>> [4]
>> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
>> [5]
>> https://lore.kernel.org/qemu-devel/20240708143420.16953-1-joao.m.martins@oracle.com/
>> [6]
>> https://lore.kernel.org/qemu-devel/20240719120501.81279-1-joao.m.martins@oracle.com/
>>
>> Joao Martins (9):
>>    vfio/iommufd: Introduce auto domain creation
>>    vfio/{iommufd,container}: Remove caps::aw_bits
>>    vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
>>    vfio/{iommufd,container}: Invoke HostIOMMUDevice::realize() during
>>      attach_device()
>>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>>    vfio/migration: Don't block migration device dirty tracking is
>>      unsupported
>>    vfio/common: Allow disabling device dirty page tracking
>>
>>   include/hw/vfio/vfio-common.h      |  13 +++
>>   include/sysemu/host_iommu_device.h |   5 +-
>>   include/sysemu/iommufd.h           |  11 ++
>>   backends/iommufd.c                 |  85 ++++++++++++++-
>>   hw/vfio/common.c                   |  19 ++--
>>   hw/vfio/container.c                |   9 +-
>>   hw/vfio/helpers.c                  |  11 ++
>>   hw/vfio/iommufd.c                  | 170 ++++++++++++++++++++++++++++-
>>   hw/vfio/migration.c                |  12 +-
>>   hw/vfio/pci.c                      |   3 +
>>   backends/trace-events              |   3 +
>>   11 files changed, 318 insertions(+), 23 deletions(-)
> 
> Applied to vfio-next with the changes that were discussed this morning.
> Please check.
> 

I think the only thing missing is in the fourth patch to add the comment Eric
suggested (see below). Other than that, looks good to me.

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 50ffa4b77090..abb6f1a4b4a8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -488,6 +488,13 @@ static bool iommufd_cdev_attach(const char *name,
VFIODevice *vbasedev,

     space = vfio_get_address_space(as);

+    /*
+     * The HostIOMMUDevice data from legacy backend is static and doesn't need
+     * any information from the (type1-iommu) backend to be initialized. In
+     * contrast however, the IOMMUFD HostIOMMUDevice data requires the iommufd
+     * FD to be connected and having a devid to be able to successfully call
+     * iommufd_backend_get_device_info().
+     */
     if (!vfio_device_hiod_realize(vbasedev, errp)) {
         goto err_alloc_ioas;
     }


