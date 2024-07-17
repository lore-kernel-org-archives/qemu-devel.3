Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C8FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0fp-00033a-H0; Wed, 17 Jul 2024 05:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0fo-000331-0k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:10:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0fh-00007o-Cw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:10:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H8p0J2020535;
 Wed, 17 Jul 2024 09:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=ZQnzhkgPJdqByUXu731Qx02JUe0Rb0T2XO67o/E6AAA=; b=
 CCJ5z7XRAgeqSdpeltntAS+gSftxeydDnr/r8KgsYAGXEyqJMS2NxJWgWc0wa5wN
 A0/mRI1mPU3gUm+Ylb8ueTUQr5VoSFZ+VuquVNGfaorsc3eQYw2dATuW5J98UV4n
 QVE7F9RgnC60IybOp/5Q283YZzvYy0jKdjpT//cCezabxzcIXsbUh5ewuV9uI7vl
 rAi0qmB2xMFm636/PpUxWoqvb+d3dD37ZX6QLhwcZkTRoMDUfr8Y9VBWoVXnpVoZ
 AGIY6msC5aP9O5dKcVy4FN+tN+3u0A7YWBbjKR1qIP9ekg03mjXWNZ6TwB4wNuXB
 smvHrH4d6JwW+Sy0Ud/AiA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eat001ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:09:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H7qQ47003660; Wed, 17 Jul 2024 09:04:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwext1fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMkPURyZhDQN8zCiXtWyp/49ZiyFwRdTbFecuenuzzbvj1L/eiRFpcK6ti2VdtU9iCBjXf/7BCSXzel6S9eHU7dH+uIew+A00m5gBz+4JS25NfIcky4V5ERpeEfSVbgHwAyZtkfkfLrwa8+IMbhWAXYf8xxgTtnKcLHPYc7l7in5Vun2re7WcQ9tGiIwRN9HWHR96ORJCXdg53gqfCUiDYqneHAKoM8wWsjuFXbdkA4D1Wi1NPWcpkV6bOpqFMtZKEhMPrRSWUvRCGMeLQ4H/AdQ6PrW6U2UhqvjfuI88SMglQEDSiHmGxmfZnN1bcGfdz6UjcCjRY9BdDemyKtcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQnzhkgPJdqByUXu731Qx02JUe0Rb0T2XO67o/E6AAA=;
 b=Hn1RYDJFXudwKWS5V+ZJ7Gb4QXUJ8flkaOf3gjRhwge2MI0ivUR944Y5c123PFIESVZUSGAdTMXLk2ZaaZpqZuxRAupQ/idxug9TdNpoxPrkGpJi+xpjj7pNZv0yCCOE3JJ8pecWQneDPtL6b81wmptmF0hQ8kc0M15/QUncsq5YUl8TnsQWm39CzwALefd3S+4B9jNQGJNpInFZnse2I1GUGdtfMng1uglKT19NDO+nN51BZnqRyq2EO9CT0gu053l4Mg9LoEaYFmlb+Vs85qI5wPweQ4VouDXELg4esNpdCpy92zflxRaWFEpoaI140ckd2ddzTmDz9Tua36ec9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQnzhkgPJdqByUXu731Qx02JUe0Rb0T2XO67o/E6AAA=;
 b=lhNtXcrmBKtssrPmS46DnWdWEuXf6NFyCWxfbGiQ5Yv36FtjsAOMjf0HP0l+/wuyZX16Sqk4kSecv1kr6ZuoRl/C3eHpC8q6tpkAtrM/DeydcrAllyQM3lrh3TrJKx4OsPWY42Tgs2amh4/dXqEXU/QLGwI1SytzlByeZUyEMQM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA6PR10MB8109.namprd10.prod.outlook.com (2603:10b6:806:436::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 09:04:53 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 09:04:53 +0000
Message-ID: <91d16e89-4733-437b-9674-b5a96f4398ec@oracle.com>
Date: Wed, 17 Jul 2024 10:04:47 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <SJ0PR11MB67443AD929EFB426B4E4FBBF92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67443AD929EFB426B4E4FBBF92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA6PR10MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4e3993-cdc5-416a-4624-08dca63f855a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3RudUpwTVhZS2ZPQzlVWDU3d1VGTWJ6VFo3ajJRWGgxYkpsR0hYNXhGYWlw?=
 =?utf-8?B?WU5BTXZRYlNINEtXRWxibmtYTERsRDJBMGFqeHpoMlJTTWpGaXR3OFY2Vmxm?=
 =?utf-8?B?KzRyS25kS3dLRzBOS1pjQkRtS2QzRUppRWJMWmx2WXJBdkZGM1NjOTRNLzhD?=
 =?utf-8?B?V2NXZG1lK2xadlkrTlI5b0xaZFJRZjNlaFNBNExJOGthcUpRSzU3WTgwa2h1?=
 =?utf-8?B?Y0lQdWMxSU0vb2Y3Ui9nQXBQWXBMUUlXYWFzbzRETTlvQlQza0V4MFdlL0xF?=
 =?utf-8?B?cTc0TVNjY2o4ZTNKRW55cTNrUmUvbWErS0RnWFJQeE56cEJTdFNSYmVncW5i?=
 =?utf-8?B?USs4eXlyMFBoak9UU3ZaZEE5NE1naWdSWmJ0ZkNHYzR2VlNEazY3ajVtU1Nh?=
 =?utf-8?B?ck1GRDNiaVdHUllZZWFyOVhibDArQ3NqdjUrQXdyblRFanhxQTRXSUhzUDdy?=
 =?utf-8?B?MTQwYk1rSGhEcXBGQ0ZOQTNLdHM5NDJBaFJLKzIrbUxaYnJ0akszdUJxS1ZJ?=
 =?utf-8?B?SFdwVW1hUytNekQyWFUzZkN0cWo5WVBJZ05BK2ptTHhoUTlhK21pbFNiZ0Nh?=
 =?utf-8?B?UTgwYUpMRFlhQit1VDdoRnV2VTUvZVpFTDU3OFpCK0VkNVhXRkwrdkJ2bnA1?=
 =?utf-8?B?SWRKS2JFcEhKcjg1aDh1dGRJVHdhT2F0NjhxTXo3bnVQaUcxaXdnRWMrUFBq?=
 =?utf-8?B?b01WQlJMN2JKNnM1WGNXT2lCR0lOT1RVRlh3ZnlHQ3krbHpCUTVZdVNmYnda?=
 =?utf-8?B?ZTJGZnBYZFpRbGU5ajB1R3F0UVBwd1ZsVmlYQnVOeWsyZzlSNSs5alFtLzF6?=
 =?utf-8?B?SGg5Z0hYUHREaUpKME1oVWRwRUk2WlNWb1BwdlNWdXNXYVRYUXQwZ09GRytv?=
 =?utf-8?B?UFZkN0hoMHp1ZVRrQjNlQU0wdEZiVVVTVmQxS0pXMU05RGdCVzNkNXlXUlor?=
 =?utf-8?B?T1YrTW0yL3VwQzJicTRGUG1mQ1JtVm43OWhDVk5pZFYvb3JPTG5qbGg3MXIy?=
 =?utf-8?B?YTYyckFBQjh5c2NMM3hjV1BXMVFwWGRiK2p6bk5Ib1FWbjF3eVFJMlpVN3Nq?=
 =?utf-8?B?dFFEbkowMDZLK0xnc05KYnE2U2h3MkJGNktuZWx0d1VMWHMwbHVHeXEwVlUr?=
 =?utf-8?B?ZmtrVXJ4b1FpMWpVSFNHeFBsOG95T2tLQ04rVllvL1RzRlhiRWpOMkkyWXJz?=
 =?utf-8?B?dVFNOGd5Uy9ETFNnbWpDN25xbm04K3BqRzNJYmFHRVlOMnNRckx4emlXSVhO?=
 =?utf-8?B?WkZxZUc1cjFXYTFzOVlNblFqN2IwaElGY3dQY0hxNkJsQW8xZW5LeC9RUlVR?=
 =?utf-8?B?ajdPWU1LY3VqSnRWMFNGaFNKVzYralFsTlZxUGFMaU5QaDVldm1qc0YrUjJz?=
 =?utf-8?B?cG5ubG9hejR4Z2lpbGVNbEc2YW9EVGxGREQwVVZkSG9TR1p2OXQvTlIxc1N6?=
 =?utf-8?B?Z1NEb0FndXkwMldzNncrRllqZTBhRE1MQzFUL3czVWM3TXZFbjlLMklBTEVT?=
 =?utf-8?B?MFl3VUYwb0pwbURBOE1oQ2VVZlFhcXlXamtmVFVkSDhZTC9xcHdlK2pucEtk?=
 =?utf-8?B?ZDFPZXcvL1dCRllFWnZneXBTZEI1VmREMVJzTTNObUJpRnVHdEtlKytoUS9h?=
 =?utf-8?B?RkwraGpySHlaNGxmQUdGRHlXTWp6Q2hWZTRReWJ4YUtBa2dYZmdPWWlHdUk1?=
 =?utf-8?B?NGFwOU5pSjl6UmVoZ3BwdXAvbjBXN1NpRm1nT010RllqaWtsWS96UkhvR1Yz?=
 =?utf-8?B?SXBFS2Z3ZlMvRzdyMnNBazZmOWQ4ektxNnp0SEowUUprM0RQeXlvNHpDSXdv?=
 =?utf-8?B?T3p4NGJIVWRtZGJ2RmdWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RXNlFCZmJSUU5aaHFKaVBVSkNIVXdtb0NSSWZ4YWZSRDU0MTkwQXZoZXR5?=
 =?utf-8?B?RVVvZGdWZGRvOVJqQVpqRXpVdDZSL1BZOUlnbUZWcmU2aTAzOTlCcmxZQ0NE?=
 =?utf-8?B?anBSZ3ErN3ppaGpVNE9vZFhUaFJjWGw3M0JCSWthS05wM2M4Q2xkYmtjMHFG?=
 =?utf-8?B?U0hKdGZrTWtiQlZPZkc0SC9hWE9zeTA5QkJLb3VlSUhEOFdrWVh5eGNSWnRS?=
 =?utf-8?B?eVE2UWN6UFJLMmZKNE5MQkxmN3V3MHVuRklKT1ZvZTQ0dkY0ajRHaXVUSDNh?=
 =?utf-8?B?Qm9KQWNUdHdXVkpvLzZwK3I0L0UvemRlVkIwVXdoaUVwUW5UUjhScWxHUzFr?=
 =?utf-8?B?L1Q2Uitnd3BURkNBRjlyWVYzanhMTklJVlFjYmtWeVI1MWQ1dFNYZ0MzRC9X?=
 =?utf-8?B?aXBTTXdVczF2K0NzMlM3amFUSkYyQTNsWDNsNWM0dWgrblZPM0QvVWpLdWVP?=
 =?utf-8?B?dUZWNXRyUWIzbGs3cUxWMm1QYnc1dlVWUEF3N3YzblIwZzU3VFJmRUNMZUd2?=
 =?utf-8?B?QjJKY3BkTlN0eWV6SkhXMDlhS3BMUWViK3VmYVRrLzZBYjRVOGFDemZQVnVT?=
 =?utf-8?B?dGd0NDZhUlFjUUk3R2dXM0t1NmRBZFhHelBSLy9QMEl3U2xiSTVra3V2REFz?=
 =?utf-8?B?TnFiOGcwTC9Wc1d1Wmc3S2libzE5S1NPM3c1SmQ2UTdQcGNsVmZPN0Y0Z2t5?=
 =?utf-8?B?Y1NVOHpNVHFPRXl1TlVVNVh6OWZSVEljdmt4dkFhNFJQOFBUTTgrZUdvRTJk?=
 =?utf-8?B?bkJtaklXWnJkelhqYWdzN3pzWXV1cW55Lzh6TmUyZHU3MFFZZGhrQnRSNEd4?=
 =?utf-8?B?RHc0RmpuQ3NOODMyeXdQaGVlYVZvUGpXQkI4VEJYNXJPUDZESUE5MDVXVEhu?=
 =?utf-8?B?RFFxbkN0V1lTeGkvdkZmak9sSmF4UXhSR2REKzJaN3lwdkJ5a2p3LzJvaGRy?=
 =?utf-8?B?czZzSkRxNktsQXlQQlFYQkdXRktsSDVQOWtLV0dkNmo2dE1GZ0VDZnVaZ09B?=
 =?utf-8?B?VHdhVThHUDhOYkY0YkNYanpVemlQcXhLUk9Ya1l6NDcvdGZ2cnFHVkZqSW1y?=
 =?utf-8?B?L2tlNVZaeEdQa3E4SjNxa2w1aFd4QkN5VDdiZWt1SHNtV1RXbE1Vc2VVVy9p?=
 =?utf-8?B?aWhrUTRGU0lJTTBWWmxBNnlGN3ZwL0g2TDVjTGZoblZGWU4xekVVeitpWk4x?=
 =?utf-8?B?eUlaWjZLclVtY1BuTWJIYUJOMGxKVXppanJpL3VMUll5L1pDWW5GL2c5bTNH?=
 =?utf-8?B?dEszY0FDWUxMRDA1V2phd3QrNXVaR2p0UDhPMWI5MVpIb0d3U3JVRFNJZU9h?=
 =?utf-8?B?ZjYvaDgzc2R1bERtRThhWm9TcUJIUVF2Z1VXUVZxWUEralllT2pBa2FmUXJ2?=
 =?utf-8?B?YVFDVkpMbXlRdzRvd1kvYnV5cW9CemFxSHJieTJ6UDhtV1EveFpnZnpGOXJI?=
 =?utf-8?B?dklIc2ZlQXZkVDRLd3UwRFBNd25TVzNNdUxiN2NEakxnQm52NVEvZ2lCanE2?=
 =?utf-8?B?NUhKcXVzQ2h3S2ZhNmtJTDBQeVhKSGpHZDJMWUdteTE1YnErcXRBRWJObjEv?=
 =?utf-8?B?YWhSWlFQQXN2TU1razh3eVBRK2U4bEZKK2duRkp0a0NGaGxyZDFtZ2RNQmd3?=
 =?utf-8?B?YW1zMjMxZ0t4NXl3NzV5aWkrc1I2VjhPOHo2Ukg3NmQ1d3NpeFBGdnY5cHRj?=
 =?utf-8?B?QlVOb3luTk9nVEdWeDBoUVcrWFRnM1E2QlpPb0VBN0hYSG14dW9YRTlYOW93?=
 =?utf-8?B?bkpCZUdqYi8waWxKSGFTZGprTDJ5YTcvT29ReTl3c1B4SHJKdSs2ZDgyZkJv?=
 =?utf-8?B?UFBNVEpYYm9YUVFIZ1MyWlRadlRMLzZ5UGxyYUlnd1lZSkdpNlhoWklYWjg4?=
 =?utf-8?B?VnZYK29PWDRaMDI5Sm4rWTIrUENaTVFhcEdvUTJJRTNoRTBiMXVBanp0TVVo?=
 =?utf-8?B?STBUL0k5VHJaZG5qNUUzbEVwODhWcDZoUkxiUUIveGF4QVZNbGtxZnU1SEVQ?=
 =?utf-8?B?bVNFMngvQkd5MWRKSlBkSU9uMlJlaGhidE0wcVI1Wm02MnNScWdRblpiUmc1?=
 =?utf-8?B?K0FpZEFUVEJFelFyNXV5L2ZBWk82dStnK0VuUFYzWFh2VTBMOGZzNWthS01v?=
 =?utf-8?B?YXdjRCtrb1p4WlFkU1pWWUovbTQ3bzgzMjNjZEpJdGs3ZGpSZVh2RTdaN0Rv?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UaFiIbftmvLc6pX6cJQCGbGQAaOwgq3+Yjbf+dk3gla+e6GIWwcfQVlbECeEGnT6suGaQq3V2W2+PPmXhroRwuJGFDuWhJ7NhvfuuoknfoSnjsjrTexmLsnROpJr6W9MaBXqRgRU9tWcq2WWK7nHmA7MWlTptdhlNaWu4ckoNmAo2IjEBy/RYzHgFS1ypXou9QRd67gatyO39JStVskE5YmL59UAyqww42OIlcG+APZMdd1NViuTaIsaZtlHRiGVapp9bbSVWAwJ0/n6LLcCC+ti21rp7DrlXgsdtVt32zxQiIn+nPQo+u21C37cSRrNKe2sgUuW1EADtxBzgCqb+HX8sKy0WR/WZ9EIeyfcfPDJkN7Qnv352LPTgD/YbumZf1DGoCxEBlXi4Nvvf5LgmnGAssz87H2XRE8/p2HR9MihJn3eMSrd7aa0NwAn89w3vUX2P8uVlYQ0V9FsMqV3cbbeqUPUWQb752EoR00IFftCW3UycdSIagdRCdEGqUcEQiuQvCnQGjtzPzIZAkWFs1SuuH3oIiPAIKZf6/OMLWvFIUFQ1HbYM0kjb0yvMif7ffUZJuso+eRA505u99oJ4og2VOYwu3eeDrF0d58MYB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4e3993-cdc5-416a-4624-08dca63f855a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:04:53.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFunYQtzq9C0lavDYe8E1A/V2gjOFIRhnmHDKOeyKUU4+5cft8M1K4azHVacr8IMF6yopAvFvm6xZx29bVPbbjg1tlvdko2/CTYsxVq8otg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_05,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=998 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170069
X-Proofpoint-ORIG-GUID: r5oD8ZJDRBcYZsaCygF3ZQTBekpBTr-z
X-Proofpoint-GUID: r5oD8ZJDRBcYZsaCygF3ZQTBekpBTr-z
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

On 17/07/2024 03:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
>>
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>> responsible for creating an IOMMU domain. This is contrast to the
>> 'simple API' where the IOMMU domain is created by IOMMUFD
>> automatically
>> when it attaches to VFIO (usually referred as autodomains) but it has
>> the needed handling for mdevs.
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
>> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU
>> domain
>> it falls back to IOAS attach.
>>
>> The auto domain logic allows different IOMMU domains to be created when
>> DMA dirty tracking is not desired (and VF can provide it), and others where
>> it is. Here is not used in this way here given how VFIODevice migration
>> state is initialized after the device attachment. But such mixed mode of
>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>> be added on. Keep the 'all of nothing' of type1 approach that we have
>> been using so far between container vs device dirty tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/hw/vfio/vfio-common.h |  9 ++++
>> include/sysemu/iommufd.h      |  5 +++
>> backends/iommufd.c            | 30 +++++++++++++
>> hw/vfio/iommufd.c             | 82
>> +++++++++++++++++++++++++++++++++++
>> backends/trace-events         |  1 +
>> 5 files changed, 127 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index 7419466bca92..2dd468ce3c02 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>
>> typedef struct IOMMUFDBackend IOMMUFDBackend;
>>
>> +typedef struct VFIOIOASHwpt {
>> +    uint32_t hwpt_id;
>> +    QLIST_HEAD(, VFIODevice) device_list;
>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>> +} VFIOIOASHwpt;
>> +
>> typedef struct VFIOIOMMUFDContainer {
>>     VFIOContainerBase bcontainer;
>>     IOMMUFDBackend *be;
>>     uint32_t ioas_id;
>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>> } VFIOIOMMUFDContainer;
>>
>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>     HostIOMMUDevice *hiod;
>>     int devid;
>>     IOMMUFDBackend *iommufd;
>> +    VFIOIOASHwpt *hwpt;
>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>> } VFIODevice;
>>
>> struct VFIODeviceOps {
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 57d502a1c79a..e917e7591d05 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -50,6 +50,11 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp);
>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>> +                                uint32_t pt_id, uint32_t flags,
>> +                                uint32_t data_type, uint32_t data_len,
>> +                                void *data_ptr, uint32_t *out_hwpt,
>> +                                Error **errp);
>>
>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 2b3d51af26d2..5d3dfa917415 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -208,6 +208,36 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>     return ret;
>> }
>>
>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>> +                                uint32_t pt_id, uint32_t flags,
>> +                                uint32_t data_type, uint32_t data_len,
>> +                                void *data_ptr, uint32_t *out_hwpt,
>> +                                Error **errp)
>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uint64_t)data_ptr,
>> +    };
>> +
>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>> +                                     data_len, (uint64_t)data_ptr,
>> +                                     alloc_hwpt.out_hwpt_id, ret);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>> +        return false;
>> +    }
>> +
>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>> +    return true;
>> +}
>> +
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 077dea8f1b64..325c7598d5a1 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -212,10 +212,86 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>     return true;
>> }
>>
>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> +    uint32_t flags = 0;
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t hwpt_id;
>> +    int ret;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>> errp);
> 
> If there is already an hwpt that supports dirty tracking.
> Another device that doesn't support dirty tracking attaches to this hwpt, will it succeed?
>

It returns -EINVAL, and we handle that right after this statement. Which means
another HWPT is created.

> If existing hwpt doesn't support dirty tracking.
> Another device supporting dirty tracking attaches to that hwpt, what will happen?
> 

Hmm, It succeeds as there's no incompatbility. At the very least I plan on
blocking migration if the device neither has VF dirty tracking, nor IOMMU dirty
tracking (and patch 11 needs to be adjusted to check hwpt_flags instead of
container).

Qemu right now doesn't handle heteregenous environment, it's all of nothing
approach even before this patchset. Additionally, I am not sure server
environments are applicable here. So essentially I kept the status quo -- more
follow-up is needed to support a mix and match of IOMMU + VF dirty tracking too.
The challenge is having the migration state of VFIO device initialized early
enough that we can make all sort of decisions whether IOMMU dirty tracking is
desired on a per-device basis.

