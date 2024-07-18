Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76242C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNFz-00031F-Ff; Thu, 18 Jul 2024 05:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUNFw-0002qs-EH
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:16:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUNFt-0007Nm-6S
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:16:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I90pAE031379;
 Thu, 18 Jul 2024 09:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Us53brgpwCQhKMp/s1z1J/H46y8qIwOHhg8g6WrxWek=; b=
 Bxc5MXsc2FUQuU7tvrhu2JyK7UDG7qEFI35ENKDtoXpCLs0pM3vzr25K1H2UdlUh
 x44S+p3vZ2wg6FqNUa6We+vPdhg0ppWW6Ub4OCCzc5BidYIGK/M0uihAB0QNAdOT
 w+Sw5vuITCFw92CwjLIwttbqI10Ta+t3i4Odf5FuiX/G1KIj1vKZdhZLyvOhxNCG
 8VPSrfAg443EjxXyR7yN9a0x98q5VfIKsphPEBmNLjo+P1RpjebLhI4lVHZqEKee
 p3LF69dpTUsq0Of5sv/1Fq5cL/6jY7UKBLaj487o13uNWsJhl1yfIxatBh88zQC9
 20WLi8STJh0IZCL9gz+jDw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f01n00w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 09:16:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46I7LvXe021799; Thu, 18 Jul 2024 09:16:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dweuc5eb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 09:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NolkdUYAJi7k6CxCxN5qaWLOLk4L5lca984gYGg3J/xAb3ZCT3f6x5XMCryT7cB2Al4kzzYU7G3Yts8RFFMPuxzd9n0IIUjHdsObODiXkqk9Rdt/CDgKlB/Ytqbi/ini0Ps7OqXPI6SG86gyMnvMoVzUlFyWojPbhHEpFHc+Rl9nClBt5PI3DTpywdxeDFSEPpTZZkq+K2/W/IpudCbVaDew2H1QguuJfJKmxEFk3tDENQoFLi9qCAjuOXj3KhWwSSroFKz7AhmqY6OpwgOTN40IlLmsMnRn4MSTcbi6AESddL8cGlV22ruCJt+jEcq6XOgaVizni7XJpHNBhxpPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us53brgpwCQhKMp/s1z1J/H46y8qIwOHhg8g6WrxWek=;
 b=ciZiMcM5ZT32k4zAeOpycNV4F4AdSu/t/GquoC5tHitJwx86KNJJMpr9HCm70x5nRGPovlM/uaH2QASdRe7RAI/cP9cJzHcq8wlScAGZTl3T+vtBugi3ttc812+f0hcvj2SokLtS2XmXpYLa+TtDWzwRIodUhKmWiy8i6Dfc0MQ5odEiLQlrG/v/za/zqGCwy2I35C60Gz2tv15oI9s8p78Y3GV/A3rN1Fkx6R9Eg2NNU9zUWhPUA0Q8GjgCkTOMcG6j8dia+tuelU725gfbVsGsGeulKryLOgpajyvTRo4cjZhN6nsGXf7kfx5n74CU8E2GFmKRRiJlfNmBg3X4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us53brgpwCQhKMp/s1z1J/H46y8qIwOHhg8g6WrxWek=;
 b=EKx59U1DX5Z4AZnAD2fXYHA6O8hjxga47zp7IUqSupU4IWMaTkoww7QrUFOxQiL8Jx4Bvv9/HqXHXqzvzGCPZhOGCLKr701JT/iXIBIHeZ/kQcw90Lrb4ZhGQJUb8iWjKoElFakcvKklBi3Da4pOkUSNJIwRSd1Q16exzYaJhpU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 09:16:47 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Thu, 18 Jul 2024
 09:16:47 +0000
Message-ID: <25730f05-7652-423e-9d8f-35079a083345@oracle.com>
Date: Thu, 18 Jul 2024 10:16:16 +0100
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
 <91d16e89-4733-437b-9674-b5a96f4398ec@oracle.com>
 <SJ0PR11MB674420D8D4742A704036C9F892A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <50bf8b57-ca18-4898-9e94-fa4420c58acb@oracle.com>
 <SJ0PR11MB67445783F2A2C2EFCBD65A7492AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67445783F2A2C2EFCBD65A7492AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH0PR10MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bea049-6c7b-46c8-324a-08dca70a5996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG1HeU9RUmZ1bk5RRG82cGd5eXRyeGljaEpYOGpocXdyenhRcUdoaU5qdTM5?=
 =?utf-8?B?WXlzcXlZVXQ5NE9UdzdycWdXcHVyWEFxcDFUKzZjRWorN0tzU1BXQzA4RDNE?=
 =?utf-8?B?QjZXVVl4VW5EaU14T3BUNkZncndqbDBKVWkvcXZ4UmRkVTNYRG1sNHhTOC9D?=
 =?utf-8?B?SE83ZTJPZ0xXSXlMWTF6ZXQ0YTB3cyswSXM0ZTJlVzFkT0FoVGxsREsvUWV1?=
 =?utf-8?B?OWg0NkxNS3hvUVFSVGk3MVQ3Wjl3N3hMcXBudEM1alYyNm1tVW4vZDBUaS9l?=
 =?utf-8?B?TVhBQ3ZvZGV1RXdYOWRZTFhlcFkwdkh4QnVhT2VBYjZmbGJnTUhmdkxXTVNz?=
 =?utf-8?B?L0ZnV1F3SU04eXRqUlNnczdBdlN6UzVZZXNsUk9qbk51U3FTeHV4VWw3YTlh?=
 =?utf-8?B?VlN4bS9Kc3QwbzJyTFI1RjQ1SzYwYXUzd2VmQmZ1UXh5c29qMXdtNUJ3Umpp?=
 =?utf-8?B?SytOMTNaYkFSRDRtckdSSnJBWjBwMzh3dkljWnNXUVdES0JWdkVZUlpqTUhR?=
 =?utf-8?B?RUpaN1RkN01kQ3NMbFlCRnVhWlZOY3pJY0xEUm9jRHRReFZqMm9GbmYwZ1c0?=
 =?utf-8?B?SEE5MWhNbG0yVjJnMy9VUXJsenVDZ3FsT2svb0xPTWJkOURRVUpjeEJkbDZV?=
 =?utf-8?B?TFN4MmhxamxQRzdNQVljTVBkaXNmOEw0dVhsaldpYmJ4TjdNVm4zVXpsWTg4?=
 =?utf-8?B?Wk14elhYcDNscGw2QWREYkZVZk1XVDRCd2Rpa2hVeGQ5NEFzSXl0anl0NTlE?=
 =?utf-8?B?QkpNdWxwTkplK0MwbGZrMjB0dS84N3hwSFZLbmR3a3lKZGI5Q2VFNGFpODU5?=
 =?utf-8?B?aHZsYTY0L1B3M1RKQlRtL2VwYlFzTzFjc2tEd2kzMjhIL3l2UDRRTUNUajlr?=
 =?utf-8?B?Yjd3RCt1TklwZ0JZL0VYNnIwWkdudEI3TE5DYjI0dVFVYloweUcrcWI3NGRL?=
 =?utf-8?B?eEhyMW52MnVxU0Y4aVpjSCtVaTJaYzhIOFdWWmVEUWdmejdHK25EaDV2cWhz?=
 =?utf-8?B?MmR3cjhTVVlOWEpFTVg5SkpMVWd6YXEzMDFCVlVTakk0UzhORWZCRzk4NzhD?=
 =?utf-8?B?TS80b1lTZGd5bktSS08wT0RlSnJnUE5GNmdWMk1CWjNBemNJNHcyNGd2czN0?=
 =?utf-8?B?bEhhNmh3TmhscFZzd1M3dUpmR0E2cldiem9VYWF0RkRTU1A4L2dPczZucGV4?=
 =?utf-8?B?NmRyd2xGdjNyVVFLRWxpR1RWeEh6Q1Z3MXlsWFkvVi82OXZtUG9Udlo1dVlE?=
 =?utf-8?B?Y2RzWWIzVXBRd2RhYlhWMnJEaXZNblkydi9kdWJUcEpGWkh6TTBmV21mcHl0?=
 =?utf-8?B?ZVZMRGliZmwwUWg1bVloWVJqL01RNjZsTnAzcnRSVy92cW9DUHg4TzFlZXJs?=
 =?utf-8?B?c0VSaFFVVVU3VG11ZkhaWml0RUNHZnNmU25qanlULzBQVS9ncmhFNnNLZEtS?=
 =?utf-8?B?RW1uUm0xQ29GWHZWZWVRWDlNSHNUMTUzWDZOZGxBNFB2Ums1ZVJkbVVJcVNi?=
 =?utf-8?B?V3pNYkFuMnRpVWZuRlFCZk5nNFY4aUozdlJWa0ZnWGgyZjdVa3I5V1Nza0Vq?=
 =?utf-8?B?dlBkTHRHUWdEUFF6WUtkck1BeTE4S2laVUFxRFBnSTltaXBoUzcrQnduZmZt?=
 =?utf-8?B?ZkUwV1lKUVJUN2NFTWczcU0yTGttWDVlN0txUTl0Umsza0t0aVFUSHJmWjMx?=
 =?utf-8?B?V3oxZkJHK2IvRG1LK05wdWg5U2VvQnRzTDlodHluWUUrSmNvclhJNTlyK0VU?=
 =?utf-8?B?VlcvOFQ4Yi9TcDhTNmwyY3g3N3BBNmFQUmszV1RpOUI4dU0vWHowaUsyL29I?=
 =?utf-8?B?b3M1Ty9SRFdhQ0R1anhPdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkQzTGNqSklUcHdXa1B0NVZHaEkwTmxKb3pwcUpWSU1pN2p6NjFYa3RSWjAy?=
 =?utf-8?B?MUdmQWFsdENzUGJlVEZ4bm1aeVdtMzVHVHZFb08rd1NSV0Niald0OHpaYXhH?=
 =?utf-8?B?aExSTHlXcWF6NEJnTHJ0Uk1jdm5iZVNQbnpab1k5dXpXTjhuYzU5VDVIcWNU?=
 =?utf-8?B?U2tnVzhpMWltdW83YWJqMXhRd2xaaXE5UGUwYXMxeGN1QzFHSm1jZU5iSHRt?=
 =?utf-8?B?K2ZTcFh1bURCMmNtV21MREVSUXdYbUl0MWc4ZW4vcG5BbWc4YXRKMWxVVkN0?=
 =?utf-8?B?OVd3a3RLT2p3WklyMnNhTHcwdVgrZWhsWk52dmNMdWNRMlExTFFWaXBXZ3NB?=
 =?utf-8?B?azhZRkptcUdMM3RNMGRGQXpWYlJ4cjF5b25CSzZmRHJKTDFkVlVuajZYVFRs?=
 =?utf-8?B?SVFxZEkxNDREOXN2NW9oeXFhR3JuUGVJQStPS3NZTHJHVDZabGZFWEpieThW?=
 =?utf-8?B?akNCeGNmdFhOZDNDY2JTQzcwazUxNmlRakFyUU1oT1JFY3N4WlExWGxJcUU0?=
 =?utf-8?B?d1dJc1pMS3pkYVFoQmhyYkkxcnVHdk4xWTBJMlN2Z0V3VjArMDlaQUdMaWxv?=
 =?utf-8?B?bmNzN1k4VnJLa3ZlOUhGY2svU0xTcVRZNlEzMTNjL2t1MkpsdTlBY2lzeFN6?=
 =?utf-8?B?L1hqNnFZbWxNVktQMEtWK0ZoTkg4V2orWnBUSy9VdGNDRllLM2w5WW5JL1pS?=
 =?utf-8?B?UEpseklXeXZ2aUM4SEJlbmE2Tk5pemdVaFpsYzZRNHdGYTJKLzZGOUMyeHY0?=
 =?utf-8?B?MnBVZkZTeXgyWE9IbkwrakF4QXFaK1lSNjhWVjhWUmlIZEkvcjFqQXNXSkYz?=
 =?utf-8?B?MUYwTTdVWmZXeXAwd3NWZVBKOEVVbmc5UUg2VDc2N3RFNEdJaWpYdzB5aEdr?=
 =?utf-8?B?NUNBYWoxV2pOUERqUlg3emhMeUdGc3NXekl3OEJPbm1McWJ6ZHpRalJvaGdj?=
 =?utf-8?B?MXlQWksvUEZMMGR4N0h1YUowUlRjVGZuaG13dDhKZjhMMCsrR2NVRGthREE4?=
 =?utf-8?B?ZTdHNGNUQ0dpSXFqME5LOTVPRkhuM1ZYMzBBV3pPZVR0RmRnbkJIamxuNXNJ?=
 =?utf-8?B?MDFTa24xYU9iZ1JoUXNjS1NsdytmZVJteG85elk2SkVHVmVqYWFUTEsyUlRZ?=
 =?utf-8?B?dUVteWJTRVBzTUE4QjcyaDhQZ2gxbnRPUjY4NFFBYU5ZanBLN2Y4WmFEejZs?=
 =?utf-8?B?TGNzWjQ4VEd0a0VaR1BUb3BGc0RybXVMUVAva1d5MGRuT2JVR0d5Y3pnWFdO?=
 =?utf-8?B?NzVWM3lydmFoU3ZJbnYxQUZHblhMVG5uZGRLc3pxRG9GQlFHN3BiV2xLdFJz?=
 =?utf-8?B?N3ZITkxjbUg4RG1YRlp2ZnZSNTdFb0FQQ0tlV1F1c25vbHpLQzJrOXFNV3hU?=
 =?utf-8?B?TGF3WTg4Wkk1VitWOS9WVlFpWEVRUlRUVTZwOEpzR2MyeHJjM2E1RGRZell1?=
 =?utf-8?B?QzNvYUxIaWZFYVdicXZnK0NHRzFxY04yT01sWFdEYjluV3lJcVc4ZUJoMHFR?=
 =?utf-8?B?bmdrSEsrcDdTeTRQbXJEeUZwZDhPVXNUKzYwbFZ3VkRwTDlvL01tWG5pVG1a?=
 =?utf-8?B?N0hSWVRYYThTM1pQSDBaZlhzbitpUmxCRFdLd0crMlZXcmJvc1VzVjJKQUMv?=
 =?utf-8?B?aUh0cUxxU29RYWNyTVhrQUpmR21CY0lYNkt5blZKc3Fma2gyK3BxdHh3dDRz?=
 =?utf-8?B?dGlQc3Y2T1IvUEVwNUxWRGNYOG50cnA3SDhPMWlwTGhzeXFGZ3gwWStXZVBk?=
 =?utf-8?B?elp6Mmh5MWFlbnRSa1c2TW80OWF5VVNGZi9UVDdpN1hJT0UrNDIxUHQrRGhl?=
 =?utf-8?B?VHBBYVdVbXRKRXNFMW1rNzU1T3FTRTZPU2cyOGJtN05oSW5yWnZiSXdlOE9C?=
 =?utf-8?B?bW5QeTd6NFFBVkJMcGRDc1YxenpqNHoxZkpHamtYbUZyRXVHUWJWSlZxL0ZN?=
 =?utf-8?B?M0hjazVxbFN1c0RZMnRVb3BzMUl1eGQvdFVBZ1lobTNtTzlLNENqM2ltYWNn?=
 =?utf-8?B?VUVjKytoWmxseVRqUFN3RjZVeVJCa1F6R3RLY0J1NUZuYXhaSkUzQUxVRWty?=
 =?utf-8?B?SEZibFVMaTZ6K0o2bnh3S1FDdmFTampGd3ZUVHNXeWVaYU5lS29WYi90RFg5?=
 =?utf-8?B?aVQ0NXpxV1YxMi90NDdBMGVDRTluMVh5OW4yV1hudTcyZTNMNkRPdWt2RlVk?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yJDzBayWwxflOi0n7NTQS9jAB2KivtdaR9hQ0Sk+/dDg+sfkns8ZzLrn2d+bvub20f/IMM9P5lw7jXleA1+CA3krGJXH/x6if1oGtZ8ktL/foJvcPbfXFRSmAqNNuWHjWVKgNndjhCLkCLYmKvM2eQ5yX3+Bph/eSvvCG7TPpkUTbzoz1M4cuSQCRJJY+hZ8CX/0KKulpZPicjRVCBsNSxCdGSmu2BOjuwr2I8WY90d4ncS8VtaKIQeMEZliceEPeN2sa+ReJ1hv10bpsT7fKXuI1bWfzgV/1zqEgEUBB5N+Vup6aHSd8POE9TWPEFWxwSzfbt5auFNvB5SKmrI/BSZJNhBXayvuE5ZbKCCkcZXugK7zpTDvpxZwYozV2+kocoK8YiAUrfXxE/pyi6vm+pdcJzmYQC7zQ5udo5Yz/d/ZkzsoTXTx/JIHgxSL+R16b2UYt6n0YSPbbO8JK0OtjMe0hu/NM1ZxuV3qA5YTvyYpW4iUr0aIoSRSglKq8BJ5eR69/FpKEYCLrUWSW9wsrtyXMmq6m/E4mUyHb8im5PjZKSOkMiXUY31UWn6cGbNHHouCM1hp2G5WYK5NVmmcKMqugC3/qTjrHHODufiAQKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bea049-6c7b-46c8-324a-08dca70a5996
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 09:16:47.6167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gfmVrIVEPdUDKPIXl/QACYwE7kYHYI36QhXnVUQHkTfbnoNty7ldTCBIhRBmlQhHTnB08vdES7YyO3ptWpgnaina5zSDpxMnxO49zDFNS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180059
X-Proofpoint-GUID: iXGCBrkXDoujvGaPa3YgpjSBTS447yiY
X-Proofpoint-ORIG-GUID: iXGCBrkXDoujvGaPa3YgpjSBTS447yiY
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

On 18/07/2024 08:44, Duan, Zhenzhong wrote:
>>>>> If existing hwpt doesn't support dirty tracking.
>>>>> Another device supporting dirty tracking attaches to that hwpt, what
>> will
>>>> happen?
>>>>>
>>>>
>>>> Hmm, It succeeds as there's no incompatbility. At the very least I plan on
>>>> blocking migration if the device neither has VF dirty tracking, nor IOMMU
>>>> dirty
>>>> tracking (and patch 11 needs to be adjusted to check hwpt_flags instead
>> of
>>>> container).
>>>
>>> When bcontainer->dirty_pages_supported is true, I think that container
>> should only contains hwpt list that support dirty tracking. All hwpt not
>> supporting dirty tracking should be in other container.
>>>
>> Well but we are adopting this auto domains scheme and works for any
>> device,
>> dirty tracking or not. We already track hwpt flags so we know which ones
>> support
>> dirty tracking. This differentiation would (IMHO) complicate more and I am
>> not
>> sure the gain
> 
> OK, I was trying to make bcontainer->dirty_pages_supported  accurate because it is used in many functions such as vfio_get_dirty_bitmap() which require an accurate value. If there is mix of hwpt in that container, that's impossible.
> 
> But as you say you want to address the mix issue in a follow-up and presume all are homogeneous hw for now, then OK, there is no conflict.
> 

Right

>>
>>> If device supports dirty tracking, it should bypass attaching container that
>> doesn't support dirty tracking. Vise versa.
>>> This way we can support the mixing environment.
>>>
>>
>> It's not that easy as the whole flow doesn't handle this mixed mode (even
>> excluding this series). We would to have device-dirty-tracking start all
>> non-disabled device trackers first [and stop them as well], and then we
>> would
>> always iterate those first (if device dirty trackers are active), and then defer
>> to IOMMU tracker for those who don't.
> 
> Why is device-dirty-tracking preferred over IOMMU dirty tracking?
> Imagine if many devices attached to same domain.
> 

The heuristic or expectation is that device dirty tracking doesn't involve a
compromise for SW because it can a) perform lowest granularity of IOVA range
being dirty with b) no DMA penalty. With IOMMU though, SW needs to worry about
managing page tables to dictate the granularity and those take time to walk the
deeper the level we descend into. I used to think that IOMMU we have DMA penalty
(because of the IOTLB flushes to clear dirty bit, and IOTLB cache misses) but I
haven't yet that materialized in the field yet (at least for 100Gbit/s rates).

TL;DR At the end of the day with device dirty tracking you have less to worry
about, and it's the VF doing most of the heavy lifting. In theory with device
dirty tracking you could even perform sub basepage tracking if the device allows
it to do so.

