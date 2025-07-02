Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C397C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWypb-0001qZ-2E; Wed, 02 Jul 2025 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWypV-0001ma-Do
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:52:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWypO-0001RQ-MG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:52:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BiVfL020585;
 Wed, 2 Jul 2025 14:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ag2A5MaIm3ztysretIA/0ug0NaEJW5T1DRLHEMhRD4s=; b=
 cojSEGmdNsWvHoDVIURjBRkwG/Gb0mvTMfTUmczeD8b7N8SQ5NY3nEhHiTnbUaFQ
 Z40S9gLx2HZ2Q03KpwTFhn8f8pEChaA9cmcF2Nk7HiYiMDk6TYSdKkNkQBvrpgVG
 PasLHrmupSLTOrs0PaPswYND9UCL1QsvBPVldb6BZswJmxxabBK3NIj7HoAetKL0
 GsokN49hZPdVa9HHSZOyh46neTCJhpD7bjAi6LmXauPGuvJBmC0lm4Q9gS+y+g8G
 5L8J8UuxYwjzkV5PJJbNSodnl6Th/9nwPyKLXpY1y7a1IM/Xvt4eLOxhVzF8kolT
 g1eUC+TxVb2Z02lAB7qtCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7xcrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 14:52:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562ER6Yj019310; Wed, 2 Jul 2025 14:52:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1g392b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 14:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT+OFkqJagEKHhY/hfUgy6idNlNbTmGYFRsXiDT0a7f/0Z41UJhnMJ+A9MuwBPwcy8icYnfWMT98n/p/hmTbauwq6pm7wJbKcKHguQ/tia7BzGPVqq14OfyN3N4XFZfv687L7hm9HHAK+GuVvpJx3pgJaVIz21JQ0XRm64tlOjAe5RRlcCfNj35BjflbeARkZrlPjJe6Wr6bLFKxlCocB11smDWKS97SvL9tkv5qR66LiFyodgS5R3vf0LvX3qNIyC3gd/zhTgPt/fh+fSRdWJ3AJFcjWybB6W7jMpkR7sQwZso75ZTI31XeTVaOnoCAIAWWNI8JvmORixUzKbQ5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag2A5MaIm3ztysretIA/0ug0NaEJW5T1DRLHEMhRD4s=;
 b=V7xbXZ//Mib2N2ak2YQJxyyZd+EznQWOZnKWjy2rkD5DReMm/F0xj0yl86HFgTVXi7f2KKlgACx2HPBTCPDKtTZDUdt96MkZ8oimjHz+OuRZLFyElAPLx5RqlAwuSk6HfO7On1C3bF3KqavQNqOWy8ZWikdUd+OhinTFmP39MB2eDD3SYYzDExVNVNCSCAtoTyMPrznhah0nsagGmqDFEaODmWVxUBvkAIr+Ym3lDWXf0LcbeRQZroOLV2UBne+2Bc3tCMgh7nvvFZQO+4pfHR7yFuyzpqPKHxoc5rgOcIhDKyO89fV/bhQzhWuNG9xPAlpKOgQIw7j4Uk+8PoTxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2A5MaIm3ztysretIA/0ug0NaEJW5T1DRLHEMhRD4s=;
 b=gEErFPcmthbPgMI5fMG+nrp+jKhH7gb1DrgSE1DgDl/1BIf2bARNukw3E6K768AsOrBT1yveUlLLeUjDtUoCieeqH80AgvXTk572mbah5N21jC6c3NeRu9kmarHLo0u9jG0L91/P6A4GAvySR77nNq4CIZudCRIbG7rbSWV/3qs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB5751.namprd10.prod.outlook.com (2603:10b6:303:18f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 14:52:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 14:52:33 +0000
Message-ID: <6669a680-8f1f-46f8-be12-a2029e1544be@oracle.com>
Date: Wed, 2 Jul 2025 10:52:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 29/38] vfio/iommufd: register container for cpr
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-30-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136CF09743001AFC31A93529240A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136CF09743001AFC31A93529240A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: c4544fab-c6df-4b5b-3804-08ddb97813d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTkvTXR3R3ZzSGpWVm10dGZ1M0REcnVrbnBueFc3TnRSWkNVelBYaGpXNVQ3?=
 =?utf-8?B?UmY5K1VCcmRqZ2FRcUlhL2tqdXZmaWo4RmtSRHZRZFEvUWNYOHdaczJPTlZ4?=
 =?utf-8?B?eTB3cnRpTElnbWlLQThEWHliYVQvN0wvbTdaRnZXSU53K2ZBeGhzZk9Hazds?=
 =?utf-8?B?d3lCTnFoQUdTY3E3RTBxdE5mYWlHd0d2aUp6L2JEbW10djNEQVBhODVqd0ZY?=
 =?utf-8?B?NGtZejJnaVdEanR3aktTdGE0RTl2V1phQ3VJaHVIRzhPZXV4QUtzd3VvVXNp?=
 =?utf-8?B?V0twRU9pTWhVYlRrRUpMMjl1QkwxUUxxeXV0SHk5QzhLbFNmTytyaWdETWth?=
 =?utf-8?B?MEc5Y3pvenpzdFhkQ2NPYXVrenRGZ2w1VytoZ01CTUdMSHBNbUVIVkNHR1Iv?=
 =?utf-8?B?OUJicmo0R0tNVlluajBtaUhVTGJqRWlrekxRMTBFUXJnU0cyR3ArTXkvUVl5?=
 =?utf-8?B?TC8vTVN5SzI3YUNQclBZRnhJNmwzZHFxK1pjaTdVUnd1bG9zMWZDRlJkOVNn?=
 =?utf-8?B?aWEveWd1ZStVNTdrdmdqbUdYY2l2M3BMNHAwWS9saFRMbFN1dFNrUUllbUVw?=
 =?utf-8?B?b1BZMWNYalYzbEVRUCthYjFDMEcxb0sxbzZIa3ppbkJGL2lDM3pRMkU4Z2pv?=
 =?utf-8?B?WjZRY1d3blVpNzF5V1BQZ2lFcmx3NHFZTWhrM0Zzb0pqSTVCR0ZyVFNuRm43?=
 =?utf-8?B?cjQzc2cxN1BrL2Q4M2dPVVRWeG80MWJha1hVUFVnczFWUUJnV01VZlBaM0xu?=
 =?utf-8?B?WXZ5eUJNWExTd0J0aEdmdzdWaDBRWVhNcXhpWWYrRHQwY2JrRWhPTms5N0tR?=
 =?utf-8?B?dis5d0MvMUZ5T0hHTmlCcVFYKzlDZnQxOXlJSHJTYnc3c3BYaHh1RUgzRnVJ?=
 =?utf-8?B?bWdrRGtCQTFHVDFvK3R0aGNaSHdBNW1TVXRlWThPR2I0USt0TXdnYVJ6VWdE?=
 =?utf-8?B?enZybjZ5dDFBdkwwKytaSzRmNC9TVXQ2a0ZQaVJSbDRvei9YTjBMNEYwRkdn?=
 =?utf-8?B?ckxaZ1lnZXdHTy9ra1FsbkMzOXJFbkdrcnM5Tjd0QWZEQmNGcjFCQ0hlaGcr?=
 =?utf-8?B?bU1qNmFGVGRyVXYwZVFOS2lmSzRjNVh0YnNuYm9rallwWWpIYUVXSzFUelY5?=
 =?utf-8?B?M0JTaEFwd1lEa2UvcjNQb2hwZ28wVkxaK0t2TWQrcFVIZSt5Q2xwVUV0Z1VI?=
 =?utf-8?B?K1FGdS9OSzNnbFZ6VDZibTA0OWwwNU9HbmlIdDU3RlBBM3pkc0l5VkF2WHlw?=
 =?utf-8?B?R3BtTkpER1JyYnppVHp0SWNIcUNMS3BmNFI5Vy9ZY09xVmlUdnZaNmp0dkZy?=
 =?utf-8?B?Mll5S2U4RHNHMzN5YUdkMFE5R001bGM4Sm1ZMWVsSlp4VVd0MU1yaC8yZlVG?=
 =?utf-8?B?c0gyNHZpTmlYekdsdTFYdFJFaGVDWVVLM0tSSHhoYmVzQTM4Y3FGUEtrcXhH?=
 =?utf-8?B?WjRjSlY1OUdiTkFocmRjcnl3SzRYSmhiMCt1R0VzMFhoTFh4SHRDenRGOGNX?=
 =?utf-8?B?UlNFUDVlazFKaDlTbWdzTVFocDBIMFcvaytydldYRGo4VmZWVXZQRnN0ZTRK?=
 =?utf-8?B?bnVpTGVpU2hXRC9Qb1hzT0dTNWgyNWx4UHI0THVzWmtuSEYrUTY0Ymc0enoy?=
 =?utf-8?B?L1htb2t6TlRvWFZHbmNaSitsZk9lbjdZVFZlZUhPa1VwRVZxNUhBVS85MmVJ?=
 =?utf-8?B?V3owSzZiU3h4aU9VdWpielR5aUJhT3g2QUxBdDhhZ3VqSjlmR01zR0NVTTI0?=
 =?utf-8?B?Q1BXNUVFOFBTVnNuaitBR0FlSmF0ZVlBYkpYWXh1RkxqSnhZUDR2T3FCbVlO?=
 =?utf-8?B?ODhxOVRleHZUak8zVzRIR2M5emR4c0lnd1pBOStqUmlBeUlkL2d4d3hVdUpD?=
 =?utf-8?B?NFkwcmpaRjRSbnFFdmFQaGdEei83alNDNC91aFFPdEVVTm9wdkpISzNLQVR3?=
 =?utf-8?Q?gsMOXf2R0RU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRzMW1oYU9tNTNEK1UwU1FWdWVtRGg3dEEzdWxPVWlkQjYwT01DbW5mKzJp?=
 =?utf-8?B?Qk00ejBHRzFtOGY1LzNyZGVqWUg0VEo5cWdja01nQzRselRMdjI1MHgvb05x?=
 =?utf-8?B?Mk5xcHd0ZEpMSGdlQlRzUHowbGRRbEppNjByU2VHNjBXYlR3WVZNMm8wWm00?=
 =?utf-8?B?ZzhMS0NGRGxLNUNxMzQvNjBvVC84aXdGUWdFQ1Y5Qnp2c2I0RHNuZDdIcFpY?=
 =?utf-8?B?VUpBekZUbzFIeFEzUVZsOStjQi9BeDlEbC9iQ0VaR2pMeFdNTElVaktRY1ZH?=
 =?utf-8?B?MWpkTFZnNk5XUkVIWm9pci9zQmJEa1VlRTFCTFVDYnRpTVpXcTFZbEtFWFJJ?=
 =?utf-8?B?RitmUWZZc1VlQ2p3ZG1ORGUwbCt1MHoxeWd4ejJveDJxTWRtYk4vZGQwN3Z6?=
 =?utf-8?B?b0JEV2tjQzlsL0tpZ1dHWXlPRVVhVS9rNG9tdWlCckJNdC9kMlJNTTk4aGw3?=
 =?utf-8?B?ZHN3d25wTWYwczJFczE4RHFqQ2lDWjFic2U1eEMwK05uWmZZektCMEkrUE5s?=
 =?utf-8?B?Nm4ycTM0dFI1eFBISVZzdjM3MXhWM01wNjk0ZXFvUWlUNDFXeHVhdWk3bGlF?=
 =?utf-8?B?NFkzRHI3TTcyRUhRVDk1VW9ETk4zeERwVm5wdHkveEhpSFdvOE5oV2NXd2tG?=
 =?utf-8?B?N1BNNEtYYzZtS1lvTGRJKzEvNEhxcmYrc3pqZ01xYzdmNFgwdVhYbWVHQjR1?=
 =?utf-8?B?YUw4TDVVK0tCbjBwWkw4RWh4Z1NRNk96V0NOWUlHdS9lWWNIUUhJSUlBbVlZ?=
 =?utf-8?B?NjU2US9qcE1hTThiVUtJcHVKUGd4Ty9PNVd4eU5Zakpsc1h5UUU3QTZUa211?=
 =?utf-8?B?Q1owSXpTTmVGRzlJVGgvUHhqWTk0TGdGM0tSOFU5dTFSZER6OTVvd05HZDhj?=
 =?utf-8?B?b1hvdWpkWDZGdnA0bVZwSnJqaHRqRUFBUWd0ZlRKK2RKc3hDdGNkTWpPeVQ4?=
 =?utf-8?B?bytmbXQvZ1BvZnQvYmNNVWM5N0FvYmVDTGJrL0tpQ29Ga21ueG1mQnZEbUJn?=
 =?utf-8?B?azdJN2lOMGg5RmEwYWtzMGVrTHluWmpuNTlkd09hWk4yQTdINVRueEc3c3Vp?=
 =?utf-8?B?T0ZQYWxxL1FhOWJ5bzZzb2lqazRJR294bmt0ZndBQWNnTWhXZ25pS1p5akRn?=
 =?utf-8?B?YTR0MmhtUndMVDNPMXVpT1YyOElwL2NubEdiaEtHRURaMXRYV0JYSjFIRUVV?=
 =?utf-8?B?dkRMcXpLQjM3QTUrVVhWUGE2V3o5V2ZieDd5b1d1QTRXKzFaSkxlMXRQR3JZ?=
 =?utf-8?B?ZFR6RkVmZVdKRnQzMDVFUDYzbHJIVnlyNDBFbzZOU3JuaXpsRDgzNHFCUS94?=
 =?utf-8?B?TXpyZXJwd2dDQkYwcVMwaTZWRlFld1Fsa2R1WTBldld0cEgxOFdMVVJkWVox?=
 =?utf-8?B?N1BjdTJvZldnRGY2WnlCcE95dldEZ3V1YlJwK0tqM3l1SWpaUUtmNVU5Q0VV?=
 =?utf-8?B?WnBIcW9KYWgzN2praHFRWWlBWVFFcS9jd1hmNFJlVEtWOXlsckZ3aE9KZE83?=
 =?utf-8?B?MkdReFBzc3htWEJxOFNuVGdRQzBlcVdPK3R4Q1dudnNSeUsySUJLT1pTOGVK?=
 =?utf-8?B?TUc4c3owSi9CeDArV0VGcStScnh2RVFQUlVINjJpRWdpVHk0d3FPMldrRmN6?=
 =?utf-8?B?ZG1QWkNFbHdBUkVLOFJxNlhPQW1YbkdSMDF2UU9UUjM5MnNOTFVjY1JTbTJk?=
 =?utf-8?B?MnZ0bTBuRHc5YkltOC9DTUpZbWNUOENnUTlFVjhYcElra2JPaC9WN3F6NTdo?=
 =?utf-8?B?ajhrREVxK2ZjeGQrNWdEVHQ3eHF5c2xaOGdoUUd3TmMxenVsVG4rbGFYVTZI?=
 =?utf-8?B?ZVZScGtXdHQ4dXp0TzE4ZWEwRHRqZDhXYzJtejFVMmczbWxxSXYvaWxxWVhy?=
 =?utf-8?B?Vlh4NCtyQmVHdWhPQXZaakprajdXWEFIY3NINUJrcHpYaTVXekRKRUVWQ2hn?=
 =?utf-8?B?bFFWVU1zZU1aZTFLbWhpd1ZvTzNacWlrRHpDUHZoUW5zaXR1UFpOdmR0T3hl?=
 =?utf-8?B?ejFrb2hwNHpYK3JhM0JnRFovR1RtUyswL24yeUxxa2RsQ1pjNElGb1JXVkpm?=
 =?utf-8?B?K2RKYlp0UGxFRVJJTyttTUIwY045Y3Bzd1U4dTIzYWN5b09Ud3ZueXZvRkNU?=
 =?utf-8?B?eVY0M09XdzVSeXZyZkJBRHlLekdtZXlJdFRMOUNYL0N5S3lXR0cxU1lja0Vo?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m1GZ7vARFfDsXQUzVyiSvOIn2H/THXjaaA9n3dCUMZoyDCbnlELuTTxYFfIr2DM14BC3t2qFqFYtmCRY6NPI6lOQfVfg23u28Khqclw+RhpkgAREZFqNN4ogdkME2UoTkxqa6r+B5IlBukYMJjEe5Ntk9pZHDnyh9GJg5eL4vYbYjkp6wA9+UTxaXePg47cjpr5l0lt6b23Q/cH8RAVpPMl21a0ChBdxW5PE9inv1ZJpS4ypMpqkyJInYXIMuUdH4YVTkAnTPc7y3hns1iNd9ldd5o+OX0lBZJmRiebSD8i3lr8J5gcWfi6Whd/E3krwpBpLUH2OKBGLuKrSoSqNbQb1D/F/kMp6ra7bRgTroqQe+x8hIQXfxJohEvTKjhFvEwiHiczfoI/sGvCvWpNZTgZLCJto1oyJLvO2kDbbFVeP7g891MyvZRAAb3nb8A1FxKDrlCU+pWdeZ5eKbY/H/zkSBxtTH0qx4K8pRIxgj7C5mIX5SaOQ9foB+9JNQ0m4GBd0+gxTpbbOL5VCRKqIp0tXYJ//sP6Cqj5PHaBOrJOjKDFgWfC9JSb2EA+CX1m83DLMKSY2VPsois1Y/FDYvd6eE0XjGXG51SRZX3ogtR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4544fab-c6df-4b5b-3804-08ddb97813d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:52:33.8507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN/hIndYw08337UxWinlbqq3HP3EGLa4SXTodC6uwpVRZdzlnmRNB5sAolvJ5sQm2oIi2HB93st6ajf4vRFj0KoMLFJEX9hZdnQrzb6zHhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEyMSBTYWx0ZWRfX3NCpxV9TU4Rn
 qQ1MjBtTf8I+bkpsn33DPDUfuWJYffDm3PwAxaHgofVJ75i/D8RYNjOTSXRGbwc+11VVVY4ya7l
 ZKQMhcKQwvg3qFxcV8TwBEDqHjApNyWBXTLfFT7EQ1Ku5VmZX6B6/txTd1Iz41zoxwNPz/4fW3r
 4UG25MULp63XCIiYDhXahVx6gL17PVrgZ34w1elxA9hiz1OobRwBdooq/nCGFpOU6ubENRwreb4
 nfYu6Q+r1nWolYlzbWGtAt2+6p/+2ofUbLWyVhjWBnhElLAa9dZzf9pc718ycPU27t8ei8VKDk3
 435eP5OV9TxnMINzsfxqXFduFVz8pieHWlPWE2X/wTwN+D4ejUMBpaG/de29Jt4ut3f1g2jZGrO
 Jd4gdAYrD6T6FB4IGf/73tlt5OLdBWP9+xcSZ9Gpma4PjMiv09oHLmIMNyU/jOYUqY4Inn8w
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=686547b7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CxKlTwGkE_exVfhpc_oA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: MRPuu_76or3aqUx3sM78DIvencKCobdQ
X-Proofpoint-GUID: MRPuu_76or3aqUx3sM78DIvencKCobdQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/2/2025 10:17 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 29/38] vfio/iommufd: register container for cpr
>>
>> Register a vfio iommufd container and device for CPR, replacing the generic
>> CPR register call with a more specific iommufd register call.  Add a
>> blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> include/hw/vfio/vfio-cpr.h | 12 +++++++
>> include/system/iommufd.h   |  1 +
>> backends/iommufd.c         | 10 ++++++
>> hw/vfio/cpr-iommufd.c      | 84
>> ++++++++++++++++++++++++++++++++++++++++++++++
>> hw/vfio/iommufd.c          |  6 ++--
>> hw/vfio/meson.build        |  1 +
>> 6 files changed, 112 insertions(+), 2 deletions(-)
>> create mode 100644 hw/vfio/cpr-iommufd.c
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 170a116..b9b77ae 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -15,7 +15,10 @@
>> struct VFIOContainer;
>> struct VFIOContainerBase;
>> struct VFIOGroup;
>> +struct VFIODevice;
>> struct VFIOPCIDevice;
>> +struct VFIOIOMMUFDContainer;
>> +struct IOMMUFDBackend;
>>
>> typedef struct VFIOContainerCPR {
>>      Error *blocker;
>> @@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct
>> VFIOContainerBase *bcontainer,
>>                                   Error **errp);
>> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>
>> +bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer
>> *container,
>> +                                         Error **errp);
>> +void vfio_iommufd_cpr_unregister_container(
>> +    struct VFIOIOMMUFDContainer *container);
>> +bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be,
>> Error **errp);
>> +void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
>> +void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>> +void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>> +
>> int vfio_cpr_group_get_device_fd(int d, const char *name);
>>
>> bool vfio_cpr_container_match(struct VFIOContainer *container,
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index db5f2c7..c9c72ff 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>>      /*< protected >*/
>>      int fd;            /* /dev/iommu file descriptor */
>>      bool owned;        /* is the /dev/iommu opened internally */
>> +    Error *cpr_blocker;/* set if be does not support CPR */
>>      uint32_t users;
>>
>>      /*< public >*/
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 87f81a0..c554ce5 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -108,6 +108,13 @@ bool
>> iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>          }
>>          be->fd = fd;
>>      }
>> +    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
>> +        if (be->owned) {
>> +            close(be->fd);
>> +            be->fd = -1;
>> +        }
>> +        return false;
>> +    }
>>      be->users++;
>>
>>      trace_iommufd_backend_connect(be->fd, be->owned, be->users);
>> @@ -125,6 +132,9 @@ void
>> iommufd_backend_disconnect(IOMMUFDBackend *be)
>>          be->fd = -1;
>>      }
>> out:
>> +    if (!be->users) {
>> +        vfio_iommufd_cpr_unregister_iommufd(be);
>> +    }
>>      trace_iommufd_backend_disconnect(be->fd, be->users);
>> }
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> new file mode 100644
>> index 0000000..60bd7e8
>> --- /dev/null
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/vfio/vfio-cpr.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>> +#include "system/iommufd.h"
>> +#include "vfio-iommufd.h"
>> +
>> +static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>> +{
>> +    if (!iommufd_change_process_capable(be)) {
>> +        if (errp) {
>> +            error_setg(errp, "vfio iommufd backend does not support "
>> +                       "IOMMU_IOAS_CHANGE_PROCESS");
>> +        }
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static const VMStateDescription iommufd_cpr_vmstate = {
>> +    .name = "iommufd",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_incoming_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error
>> **errp)
>> +{
>> +    Error **cpr_blocker = &be->cpr_blocker;
>> +
>> +    if (!vfio_cpr_supported(be, cpr_blocker)) {
>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>> +
>> MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
> 
> I suspect that blocker is never installed. Because vfio_iommufd_cpr_register_iommufd() is called for first VFIO device and before memory listener is installed. iommufd_change_process_capable() will always return true.

The blocker is installed if the kernel does not support the change process ioctl,
which was added last year.  iommufd_change_process_capable() will return false.

- Steve



