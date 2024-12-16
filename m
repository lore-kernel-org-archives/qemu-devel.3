Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E88E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA0y-0001oi-5z; Mon, 16 Dec 2024 07:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNA0h-0001kJ-Af
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:15:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNA0e-0008LL-P4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:15:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9NQvN017299;
 Mon, 16 Dec 2024 12:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=c51t1JMBJuwme/s3cXda40Dow4JqsjrshYrhVryz1RU=; b=
 ZzFcCHb0W/YKVFKvVI4AAFHK0O9C43H25IKYf8mUXjx6f0qPwyKom6zxcWpcfoty
 Efymz4eWEVsJoNumVZrh2a3XG7IgwsPPRarFBJQbmbtWG2uPhkZSjEQA/ASe7XpZ
 NgKio6Bex4W3wtSR5iPuTlGuwm5fCkZkNeVGWmCgJLywdtdXXikKQVlr0nC5okLz
 sLkWWYu3MYgGReqFref8biO4s42J8KJoVce9ePBTjy8koc+Ektn8rGXQPx3POgQr
 ydVpfepX+44/vcwWCm4Z99XF9gRFZnz2vLakK4+ydALvrMfNDg2Ne4vMr2i1NUov
 Fw7SbPn0QKrbmXC7zoC7hw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m034mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:15:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGB9kHw000719; Mon, 16 Dec 2024 12:15:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f76m53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:15:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq7vqVY2sdSFIqArTAdnljXGxWfcBnlsjYCipgBVY0Jb/E07zrmfPEPk9WyZBbGIykFkn1bn6V+8UP6MS9VMGgGGSAnv49QcmHAMzR7ee+etBkh6JKMUAy7VfMCfMmVLooIOPAfPMrOovExaqc/PyFnDHTrWYU61dGWr8QEmaS/Z6bc3ZPC7U2OAHO8kk4WiiSGMU9PNkY91cG52oDhHhq+izF/31j+KfTp2kWM3Jk4EnhaOnUY3TeIeV5z9PE3bGJMOG9J5MGWdApEjXimg5KGHuVCFds1yHcxgCELOQXxIb2FL2DG039v2GuytZSeh+wDtOFbKW3AOHLvGTZc1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c51t1JMBJuwme/s3cXda40Dow4JqsjrshYrhVryz1RU=;
 b=sr+xjSTLtKxGzKEoIszlO9xa66RtbPZlPZmgGCzB515IU4cYszj+44jYRYTWcnmsXpRThZP+Z9Nv2JhmYvxqGhCqSz+fqYVA6C9+byMWkw1ccIlNjbBxwebdglfvv2tTBsgibitlcigWiiC1F5zBnSYXtpsAbCTy7JAWY5aCzhrrpAiL8bfAzvHqNU360rMUD/1cbYDlkGCT4XWH1YZrNOPCfPN00nYMlBlcTe7P5yxCQk0uPXKbQOPRP/O7rLbvJS+l0cD4nE5Kg3fCwvkXHIFKYOXejtFge6rEOTgHzR5LZZctEhnX6alHyIM6nrdSZcZmt5qTRtozJTVCXCENdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c51t1JMBJuwme/s3cXda40Dow4JqsjrshYrhVryz1RU=;
 b=n6+ftoXCa6NR7//MHu1+J74ifMfFXvqee29lzwhyGVWuYybLLzBgMVGJqAnVK6zOqSkqcLfNZcag6M3KQ/X1oN5YF7kmUyXTxuGsyPzNoDxHtR8D6s4tzTnKrXvgKWMgcXprfIov9tNBc0Jz7AnjsSXkyqBYhdXWzckA6cpfY48=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 12:15:30 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:15:30 +0000
Message-ID: <6aeef4b7-728e-47e8-b51f-eb2870d6df7d@oracle.com>
Date: Mon, 16 Dec 2024 12:15:23 +0000
Subject: Re: [PATCH 1/9] vfio/container: Add dirty tracking started flag
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-2-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db43725-3abc-4656-462d-08dd1dcb5521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHhJNHBJN3lMeVMxdDFucVVOcjJaRzRrRXVtMVNoK055azFuaDk2Y2JnZVY0?=
 =?utf-8?B?OFNERlZXa25La1B3L3J0d0lYeWFLMkVxTlQwTmhBWmFaK3c1T2VZMzJjVjhH?=
 =?utf-8?B?OThDWVlMTTVuTy9HOHNQcms3NnFxOW5ZQk5jZm1neTBKV2thWG85QnFpZVph?=
 =?utf-8?B?Z3VqTUlmLzEyVGdmTWV3UkNSSyt5UEtzaUFJQ0I1UWxQdnRXNGhSWnAySFR2?=
 =?utf-8?B?UU40STk2UlI4eS9LSHlSMkhMalhBOU1MaUU0N1M4dlArckxPaEYzN08yMHF1?=
 =?utf-8?B?OEV6c3dpbmRlQU52NHkyby93MUd1aVVZT0drT3pMeWtZK3pwbXhLMU5Id0dp?=
 =?utf-8?B?MlhhUnlBTTFSbjg2L1Z3ZzF1TXd3Q2pMQlpVaXdraTBUWnJ4MTVNTHZaU08w?=
 =?utf-8?B?djYyWlZXSVFhK1FOZWdqY2VnS1Qyc2htQjV5OWJRQnU1R0c0RzhnYXBMNU9n?=
 =?utf-8?B?elU4VUh1aU5oRWVPV3FNVytMbW9LeWFibUh0SGpiZTVXSGNvUk5aY09tSVJy?=
 =?utf-8?B?eUFRZm1sUE0yYU9DdGxIcVJVMnBwMDlMMG1Pa2Z6UXJvVVpjRng3ay9pREJH?=
 =?utf-8?B?S0UyUWRVRkZLSDVHZXNaRW82OFNleDc0cUhWcGs5RTVXQ2JsSFdlVEdVYy9y?=
 =?utf-8?B?OFozVGtOZjR0VEZjMlRXeTBrTHQ5NG5FbnlnaW9FTjZhVE5BbElYNk44NUs1?=
 =?utf-8?B?VVRNY2l1ekF1ajNYd2pTaFNxZ1V1d09hZzdEM3BLbS9MWjJ0TmcvKzdleHhP?=
 =?utf-8?B?WW1hQ3N1UEpZRkExaG9QYjVVQVFRWFNmcUhLZTVNRGJHbGZLd1N4QnFWS0cx?=
 =?utf-8?B?VTBhNFhtYTBDR1d2U1pRa1NZaVJVRjJrSGZza1cvNnV4cGNKeXBMNEhienBS?=
 =?utf-8?B?NDgzOERlOGEwU2xid21seGx6MDdOWnQxQUJva2J2UmNaVlhLN1NCamtlSG52?=
 =?utf-8?B?OXVyY29ENFdDUkx1QXdiR0xUbGdmaVFBa0FnNmhCZmIvNStYcW56S0xKWmpM?=
 =?utf-8?B?N0xOV2kycGtQaE4xRjZyM0VvSmpaa2NKajZFVGFEUUFwOHFNN2NiUXRwdlc1?=
 =?utf-8?B?eVQ4RmZXc1E2MDN6OGlybWVLdE80TlpGQlR2U1ZwSlVweTJCbXVERUJGV3lZ?=
 =?utf-8?B?WEltdTRhTmNybCtKQUR3QW5XZCt6cTk2SlRkSTE5cnBQSWQ2SnA2UmViMi9G?=
 =?utf-8?B?UDYzUDNhZ1Fzdm93L3NmdXJESnBSejVlbFZabytQQ0lvQkNmalJ2VEtDZ2JP?=
 =?utf-8?B?T2ZMVUtjZ0MybDVtd1lJMzdTcnIvUktOWXM2T2greW5LcWQzQlZ1bUc2Umph?=
 =?utf-8?B?K1dRWmQreG0rY2x6eFEzQ3ViZlpDRCt3OU92WTN1VXB3WmlKdnBmTWxraEQw?=
 =?utf-8?B?Rk9FRkRMS1NqQkN3cWFPOWdkdmVDOC9EN2dkT3JPL0xhYlBOTy9wMUdBRElt?=
 =?utf-8?B?VHk5bXNVS0xWWk9XdzByQmtOUk5EODVqWjhKM0JNcVRyS0hhc0JxUDZWWlVQ?=
 =?utf-8?B?b2FWQTRRclR1TnZubUpnYXhLdWtDbTVsQ3p2OEU4byt2bkd2YkpWZWlMaHlN?=
 =?utf-8?B?U0tjSkdpZ2FILzN4QTk1ci9qYW1Xb0pSVnNKTk0rMTgxM2orbVU5bTFDaTFx?=
 =?utf-8?B?Y3gwVHA2V3lpQ3JIYUN1N1Zxdjhqa2hiS3llSGFvOE1MYVlzeS9MdU5wOGp1?=
 =?utf-8?B?eHdoNDV5MFJPU1cwTDJoTmFBd25ScGRYUEtreEFGaXNNRWlNVlZwQm4zclZN?=
 =?utf-8?B?ODZ1Q0xCS2VUemZQcGkwR21hc3UzdFRwYWdjbnZKTjJ0ZGw0N21TaEhsclVW?=
 =?utf-8?B?VFIwc0g2bWQyNDBhTVZacVRVWmRhdTloZmRVeHAzS2FxOFdReXJSd1hRVWlq?=
 =?utf-8?Q?XwmYsLAOk8WJB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzgwTmxSdjl6cmQ5d252NTRuQk9JSFdteHdoS0hOSmdmNlRBYm8zZ0ZWbnNT?=
 =?utf-8?B?QURlKzdRbmV6YURoTWptY1BsbTN4NmJnR2RHdHVYYmlzQzBaMnh6QUMrNFd3?=
 =?utf-8?B?Y09zU3N3OG5CejA5bytYWi9IOGVlS2IxSmYvcXdyVGRyeFNJR28yWTg4eWQy?=
 =?utf-8?B?Q1dVWGp1WHRhcWo1WjlTakZlN0lRenZSWVVRN0FXeDBFWkc1NHczVWdmenpa?=
 =?utf-8?B?NlEyREVGaFR5b0dFN2k4cUZCZUgwK2xXZSs3Y2FlY00zZ29zcTBhUXFqUGxM?=
 =?utf-8?B?WEYxRk5SaUhKYTRtOWc0SWpiMDFEYUhGeHBsbURFRVFEdklLL3AyZHZweHdE?=
 =?utf-8?B?T2ZDUmxJUlBXS1RMcVhjRkdVQnVVK0owSjJ3YlJVN1dEUmQxTTNqWkFpZ1l3?=
 =?utf-8?B?WW5HK3RoSWFkRUs2UG9SOHZMZC8wc1BCY3dZTUl0S2VoZDZja3lxVEpNM2Ex?=
 =?utf-8?B?bVJmUSs5L1MyZVVBU0Nzak5CbGw2SCtXT0pUN0owWXlxK0xGWDNIblZhY0Rh?=
 =?utf-8?B?cExWQXQ3dkZTanBRQzdwU1oyMTVKblcwSklFd1RNWTR5Wm1sVFZPNHZmaXM2?=
 =?utf-8?B?Y1QwYTc2TXJCWXNic2I4TmFPb29kai9zVjZPeG1iM1JSSVBkYWdXQXppRzRt?=
 =?utf-8?B?U0hIcVFvWWs4YWdmSTRjWEhqdFhpS1JtTWJUU2FQdW5ybWlrUjBVTDVXNy9n?=
 =?utf-8?B?NXIxR1FPaXlRZTZsdmVacFBRK2VjNGRrYXlJWFNGK0ROOFJLREJZZ0lRU0Zl?=
 =?utf-8?B?d1V1VmVGOXhvUVpGOTFyR1VDSXluK2FTVTdxOGU5RUgrL0FmV1Q4ZUxHMVZT?=
 =?utf-8?B?K1hYR1ROcm9JTytlbUplWDFoKzJiK1JMR0tYMUNyVEpqayt3S0srNXBiQmU2?=
 =?utf-8?B?TStqaVZQMTFNTmkydnZmTzAzQ3NWOHRLeUZ4dzYrdEhaVThXaDRkQ3ZiRDFM?=
 =?utf-8?B?US80emdqY3NwQ28wVVRqNEVPT04zOTVJN01xdWVQZ1MwSkpnQ3ZiRjM2YVRZ?=
 =?utf-8?B?eUttZ1VuYXA3bU1pY0h4SEgvTjcrQTJ2ZEJMa3ZZMFZnSFNDbDlrVVU5SWNa?=
 =?utf-8?B?WTY1ZEc5ejRBd0w1WGhINlZNcUVsYWFUbkVwOG1GNnBvZzhqV1VabTV6Y09R?=
 =?utf-8?B?RStIUmpFT2hTUXpNRWRDOStPV0J5aXdBR3Q3dzFOTWwreU9nbnd0ME1iNVZ4?=
 =?utf-8?B?M1k5WGZ2NG5kRHVqMkZHM1p0OVBMTFk0cVp6LzZ1TzdkZEQzQlRFNzkwdmJw?=
 =?utf-8?B?TER5cHY4cWZNRlFnRDFWZkVyeDlURFFHVFc0RXNJeHhhaVZCT0ZhVjNpajk1?=
 =?utf-8?B?SVNYWXFHUGxQU1NHWTZNZWdUOVRsbXlMZXdBL05mdlJKTE1JeWVTM3JtRHM0?=
 =?utf-8?B?eUZPV2xDM1BDUUNKRzZqWmE1Znl0M2tvREJFYkhXSVNVQjBHSEhCZ2pSUDRJ?=
 =?utf-8?B?VUFQNnN2RkliS0YxeFVVSm5EUGdMNkxDRzZvalBEYytrWnRnVXA5S2NMcHFp?=
 =?utf-8?B?SlM0RTh5WG53ZUZ2dDJ6ck50ZGlKSUxoa056UXliVjlLdE84a0l1MlJGR0RZ?=
 =?utf-8?B?ejRwUS9NWHpFcWsxREFTaEpkK1lPeXF5UVh3YVNOVVJnWXRRNk42U011R0lk?=
 =?utf-8?B?TGxLK3BESUNHaWVpSGRQczlBc1JSVXcrZngwQUZGSk1OaXdDYmczTnRtK2Nz?=
 =?utf-8?B?RTRNcnQvTWttdjNJbU5LRWJidldjVlhrL0pOdTZ5TTIyakVxWTB6QVNnUXdP?=
 =?utf-8?B?WXB3VGxIK1Bwak4wR2ZZNkF3RkN6K1VTNFNvMlYzRTBBZzUrM3pwZW5MSFhy?=
 =?utf-8?B?dFQrc2VoTkdRWG14R0tJV3BTck81ckRLT1BHNjZ4UmNWWWlwb1dvY09MVWxn?=
 =?utf-8?B?bktsYXNQQnJIS1U2WFViaVR5dHh5UDJIYmVDZUNGRGNGTnJ0ZEpJK2VjeWVw?=
 =?utf-8?B?SlJqSDVrZk1tK1diRldYeml5RHFzQjQxUHhZVjMrZG55Q0N1ZHVncTFvdTJK?=
 =?utf-8?B?ZWJuRzA2ejR6ZXM5aWNxT0ZEQXBKQVp0d0x3MGliTXlaQ3R3Y3plQzRBMnFE?=
 =?utf-8?B?RW51MGM2YithMUNsMkt1VXYyUy9IcUVsc3JzZFRQeU1OekJ0S2FqL3loQTFZ?=
 =?utf-8?B?Tnd2QWxEU1VsME8zdDR5QmpWZFJOZ0dxNGFHMXQ1NS9saGpJWGNENjJ2RmZH?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: amftcEJPf41YBv494W/kiXHicFAExVe4G8z94ibzQ6JrtOsEdDUG12coaZVURZX/qfmmeNVBBiuQY0oGuxSoJyLsMkbpjR/WsxlSjY2kKuj0eR4JiE2wDFTDWGBf5+9l9i5wcy4TaiL+qwzuT4mHrIEXZMUIXBmlt+EfuthgML0WoSNmidoQx8jWy9YcmhDUzXrkZJTdiDKaSCUYNGuZntKERXZZPw6wkw/MFzBtxCtBXPW27F1yVkQM+BFxgPy0j2BqOkHzYNNxneXDvSZKc+5lLpfP9O7a7ZP3w6G6m2tgPPwt/Lu/sy1jVlZDa0qp/cLgBhIU3UlPFnQjOGXDduWwlq2srYQtv1Ta/A8Cz1DbLgRAGFSjAM6KmTMWc2zglIDWE3uW/LQjZhqa+Lkw5N83xaSKmMufAMZVK/pxTLZeg24V4D+Qawewmqm3NtZrFMEQBf+/MZcNNYk+w1mfgLvGB2UTPl5vfNvO4A8rU+RVwBUGcfLq06KL7vSc3WCZShqER9wQnRw5DI735kdOyzMdK+FGZz+Oo0wQ+V3k/6ylLYkD+xU6ym1x39af7+yfI71PasBYny+WLdPTlymAhjMMDY8HnCL4DBoivjtUbZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db43725-3abc-4656-462d-08dd1dcb5521
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:15:30.2817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N/ez1BytZTChp3Yiii+WK28ed2QTl3Nq2rwmDOcRTVkesPSIpywV0W02yn1FI+TIDs6jI3j1XgUhsK1e71ctCLb5YdlJT0L+Q8OLwDDPGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160103
X-Proofpoint-GUID: gNn4L2j8Raq8ux9b27_JGvRtEwtwwwEp
X-Proofpoint-ORIG-GUID: gNn4L2j8Raq8ux9b27_JGvRtEwtwwwEp
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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
> Add a flag to VFIOContainerBase that indicates whether dirty tracking
> has been started for the container or not.
> 
> This will be used in the following patches to allow dirty page syncs
> only if dirty tracking has been started.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

Just a nit below, but it's optional.

> ---
>  include/hw/vfio/vfio-container-base.h | 1 +
>  hw/vfio/container-base.c              | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 62a8b60d87..4cff9943ab 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -44,6 +44,7 @@ typedef struct VFIOContainerBase {
>      unsigned long pgsizes;
>      unsigned int dma_max_mappings;
>      bool dirty_pages_supported;
> +    bool dirty_pages_started; /* Protected by BQL */
>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>      QLIST_ENTRY(VFIOContainerBase) next;
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 6f86c37d97..48fc75cd62 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -64,13 +64,19 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start, Error **errp)
>  {
>      VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    int ret;
>  
>      if (!bcontainer->dirty_pages_supported) {
>          return 0;
>      }
>  

It's a nop when no state is changed; don't know if you wanna capture that here.
Something like this below now that you track container dirty tracking status:

if (!(bcontainer->dirty_pages_started == start)) {
	return 0;
}

>      g_assert(vioc->set_dirty_page_tracking);
> -    return vioc->set_dirty_page_tracking(bcontainer, start, errp);
> +    ret = vioc->set_dirty_page_tracking(bcontainer, start, errp);
> +    if (!ret) {
> +        bcontainer->dirty_pages_started = start;
> +    }
> +
> +    return ret;
>  }


>  
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,


