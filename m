Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BEAC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyQk-0003pK-RG; Fri, 14 Feb 2025 11:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiyQi-0003nv-HW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:20:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiyQg-0000kt-4t
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:20:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBXxv007099;
 Fri, 14 Feb 2025 16:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rkkLWjEMw6vlIC18+pfQteQz/GdzGtMXv+r/TgDx6SY=; b=
 MX9+1hjimav0ZyUNDnERcqYStSdZ7YHjnvULv9aIS2rCB6JXxAMFW7PA1Xo08as7
 98It6T66HtYZs0Y7NCw7m+Zebyajueg8RzAPZVfeaC+GJqsJlUv8VKnWNSNaKPsP
 O6TSj4NRwp7kuZFYTDCcnn+rWL+opVPcQ6EqelRKWFjocIIbpop3+OAsAD7KdQcI
 TV+XMdQwDgB/8I4DFIiURzWiimzmVW/shF5Qv0MgplJ/ZQVFgRFm7bSW9rvpNIMm
 a2Gn55TCLutO78HqNPTuchiOewQzdL9d4K7l9DYwKdjt7uJxR5UZ+TpxvsET7Gc4
 MHeUfyxcgpxqOVK5NJY0/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgc3k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 16:20:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EFprW6006727; Fri, 14 Feb 2025 16:20:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqdajch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 16:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ46Wkm2OQAFzFr/uqIteJF+na9j/AahfmX7cKN9sYeyQWshcU3F3AwazulCRkDmZtr0y63jkRc8cbumckFycL7YwISP3XgDalKYkzD95x9uQMDpOWm+sElpasz7sNBYVVaqWhrrFuqdwVgA3g+hv6RuZEnQhgp/C9sg4z0ydzpZqM4AXwDSASPRdqPs5xIm9HTc9N907cw/rgB86DzD0WGC8ogmwZ3a7miKVYqGwaiv6J9/DQJxDjW6Nk5YQWdHNuta0OesMMkIN2Q8iel8HwsmS4Tnu8kXevHz2uGaXOMvk6FvFy5k5wA39K6657LqsPmcdBcYp02zTRebxQwpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkkLWjEMw6vlIC18+pfQteQz/GdzGtMXv+r/TgDx6SY=;
 b=jtILz+ayiSEI+NN60yuWtkTNWKjUXjczSOEdnsy5RIbUzOYc09FlQ11hS/RNZaVI9ZEkc7wHZYQR45VvNJzUn5fsAbg+6gZpTqTpBUFM+UIl1rkOQDUJfe5kC9aGxsPwwCnO01F2Cxn7/Gyl1V3vpMVvivD0O1EWbJLx0TenrjeK3jUlCZfEglbV63Q2U+Worw4D65IowDmlIU52AGbmEr6j3VCzUvGaDucqsSb2SBGAOhiEMPHvcSho57jURcKmlB6Usj8oaqidXEzLLD8K6cL5Py9g8FZKu+uUt2h40km1BwplIbY5GDG3tQHsbreILV0LNCNaE7bLZFW4unDTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkkLWjEMw6vlIC18+pfQteQz/GdzGtMXv+r/TgDx6SY=;
 b=ES7dz011yFRix5Eg77YPAV64T6pWjo2UoiUP9cVUvSAtXINhl0VvOaKu8PzZZ/B9YEooremfCEAsodITyKcq4CCQSSpJBtjDUYBvTvs5a3PfOKxXf0shiCyZgA74lspKhCdzJ6KD++j7oTYtUNm8OaMI6l9UhGNgJ4uNvEG9N4o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 16:20:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 16:20:30 +0000
Message-ID: <8b30c6b4-1c5f-4bb0-9a85-e364ad2840cd@oracle.com>
Date: Fri, 14 Feb 2025 11:20:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/45] Live update: vfio and iommufd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <45420461-ead5-4b72-8f84-cddf53e2b95b@oracle.com> <Z69qDWTaNCQobUiq@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z69qDWTaNCQobUiq@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b85bb1-b398-4bbb-4958-08dd4d137fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWR6aFh4WEhxTHZ5d1lCVWRDaFZaNFBsZnhEZ0ZLTm9keXA1TEZBVlFQR3R3?=
 =?utf-8?B?Sm1wVnhGUElVbGREM2VRU0NLd0ZoWXFSVlFDcC9aQ1crQU9lR3ROdVozRndN?=
 =?utf-8?B?c29mdldJVzNMeFlYUzNmN1Jwd3ovUTU0SVRGTWJXakRLcEVacTBLcU9nUHlI?=
 =?utf-8?B?dUllRFRjU29jcEM1UGdNU1B0Z3FtV1RhVGpNQ20xL21nQVdTRGRXTjdlRHJx?=
 =?utf-8?B?cWwwdTdYL3BxcmIzTVFCWWp4SzhGdkpOMkVGaEFkR3BRaWVvUXIxelQ5dFRy?=
 =?utf-8?B?b0l3MlNWeWFCZzRVWXFGYUEzUVoxa0xydi9uZHlpK2ZERnVMeWRlWlJyRjk5?=
 =?utf-8?B?RnpXdUhyZHNBaWkrOW5CRTJpL2lTUGVkM09kRkF6dXRTWXErRTFIbWs2Q3o2?=
 =?utf-8?B?V285VGJvNmNlSWxmQnVzWmdFWE5zc2hpb2I1ZW5CaFpqWHhkd2E0TXFuVFZH?=
 =?utf-8?B?SzdlN0VLUVBBWFY5a0RSOUlXck5jdjIzMGdWZEZQamxsZVVzcnNIYk9aaWxB?=
 =?utf-8?B?K1l3b3N1RW1zOXN5OW9FaGxVSzN1QjhmeERBZk80RmVLVzFlc3hneDVLb25w?=
 =?utf-8?B?RnJxcTE1ckpYOUlUVUVIVG1wRW4vdkpvOThxNklCbFQzYjJmSmRiTWhLRzVB?=
 =?utf-8?B?dnVFMFovZWhZTHNNUlQ5cFY0Sm1jeTVyRWs1Zk96RTNCWEVGbHhVZ1NoZnJX?=
 =?utf-8?B?NUtScndSVVZCODZXMTAyMTJZalhqcmdpYmZtMElPWWdoUDdUME9kbEQ4Ujlk?=
 =?utf-8?B?R3VYZzhwMlZLcm0zbS8za3kwejRndkExaVZ5OTlnL1EvcjlXREhJc041T21U?=
 =?utf-8?B?WE8rOExjM2E0SS9tbThBVlFKU1lxQnNZLzkrd2p2bG8zS2tkRHR4QkNpa1or?=
 =?utf-8?B?bENpenVVVmpmZHdYd2kyY05iekw5aE15WStYVEpUT2Z6dHlwMmQrL2taSnF3?=
 =?utf-8?B?NzBuK25ncStlR3pQOFExTk5WV3QyWXdBTENGakhRVFBzWGxTeDdHQXZIOEts?=
 =?utf-8?B?bUZwU1hrQVNaL3JWZlBHc0tFM0IrWTB2ZkQrQ1hxZzFhTlRBSlgrZStmYVZS?=
 =?utf-8?B?ekVxSmtLanRzVDdyZkZieHhKdkVqSDZMYUZncE50NXVVdE1CcUtvWU1PRUtS?=
 =?utf-8?B?NGRXRFV4d0ZGQytiZnBocUk0d0c3SWFwMGN5a3NHaXFZR2NubDRtcVJMSkdP?=
 =?utf-8?B?MWZqRFAzckNqb1k5QUdwRHNKb0s2eFhxQkFvZE43eDlSa3VzZzZUdkNrbGhQ?=
 =?utf-8?B?dFpkamZxZUtJUlc0bFROYm9mQ2pHY1daVEJsTUx6QzRHdzZtSkprYzNHOUxp?=
 =?utf-8?B?cXRDTzVnKzF3cGEwUlN1UGNNUVZ5SGFuY0FESFNCQzQybnhxVWwyemtnWTlG?=
 =?utf-8?B?RUQ2aXgreDhNUmp3emVQU2RxV1VsQ1ptQUo3eGhjNlZiUGZJWUNEU01LRTVu?=
 =?utf-8?B?SG9NcHBZQlNOU29qa05aV3daRkNVVnFsSGsrSCsxSzNzNFVhVG11WnpWRFAr?=
 =?utf-8?B?em5hWE9sOW5tZnBuMHRSZjMyMjhaSkNISFU0R3hQSWc4eFVtRFU3MTI3bXdT?=
 =?utf-8?B?UThaTnFhWjV5cmZTcmlUNG5jQVFoMnNRTTk2emdmYkEwTVhjVjVzclBiS2lG?=
 =?utf-8?B?aGlMUjJ5NlRxUHcxRU12cDdNRE4xYngyUjk5Szd3VnpWQlNjd1FXcEhtTWJE?=
 =?utf-8?B?Qm1mV28wdDRTVHQwVVZRZjM3dzNuTVVkSmxyQS80bkhOdEJSYlNjZ1plT3dO?=
 =?utf-8?B?ZDZFY0w0WFJyTzkwYVFkVHRiZ2l5a3lQUW5IZDlyd3RxaHZlZkRuMXYzVzd6?=
 =?utf-8?B?UE53SHVXVEc4V2VXMDdxUFBMbEtHVHlVVFRSTkFIRHVxSG5CTWVhRWVER1Nr?=
 =?utf-8?Q?GKTN3ke+kCnmt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnF0SDFFTi8rUUVRSlNQYVZkQU4rQUhKK0tpSDhpL3FTcWtWVWNYeE1mN2tP?=
 =?utf-8?B?N0t5Z1k3YWxXa1Y1a3RZcFo2ZysvVjNTWXg1N2VSejlsK0plZHpvdmt5OW5Q?=
 =?utf-8?B?L3dJdU40QXBMVXlDWnJ6ZjRUSFlmcVorL0JRUXJQcjl3OXBQL1Jxd2YxcTR4?=
 =?utf-8?B?TU9jcDRPKzZuVjJTaEU3LzZvZVZzcGNPNG5kSEFWWWQrcTg4SThScUozV0VU?=
 =?utf-8?B?T3lsc3NEaWR0UDZrdFR3VDRSK05mMXFLRmFQWFdKQ0xTRWM4MTYvV1oxbXVr?=
 =?utf-8?B?SklkNjMxamVSbVBKbmZwQllHK2hwTllUMy85NDcxWkdZdW1Wd0JqZk9nRGJp?=
 =?utf-8?B?a2IwMHVWK0VNYURzVlBPWlBMRjFDSjNCbEZDSWYreHlMOGVEa0NhdDNERytH?=
 =?utf-8?B?Um1vQit3Qm1rNlhkaWFKWkg2QTh0Q1pzWXJLQ1RtT2lJb25rKzVTRXlHLzVv?=
 =?utf-8?B?RUlkNm1RdHQ4TGx1ZnZicXhzNHFZTTZwNXNYbjhzbWZIRUdsMGJURmRpYUpY?=
 =?utf-8?B?T0VXR3g4eUx2dnFhRzJKcHZhRFAwdFFpMzhNVTFEOCtHa1JFemdPWlZucVg0?=
 =?utf-8?B?RWphOU5HT2llc2paTzI4STBnYmJLdkxpNFZ4a1JVYmFxWC9qZzNWYjdyRkdD?=
 =?utf-8?B?STI0NGVONnRTQjZTMzdnT1piNlJBbnRFVFJtRmIwNFNQQW9GbFEwbHNDNU9Y?=
 =?utf-8?B?cHQvUll4eVZySWErVVU4Nk9jZDVqMytJazFRY0J1WXp5bWNybFp1ZWNpeDBG?=
 =?utf-8?B?c0l6ZHlsMWFURkNQNCsvMmltR0JvdlFJSi9BRHZDN3lxVUR0ZE5LaHgrVXRW?=
 =?utf-8?B?Rm1nY091cVZaY0ROQnR6a01XNUF1TDg5dTNGbytiUGFVSXRuZnMvaWV0WTNQ?=
 =?utf-8?B?L2ZPMy9BTnF1UVByU0E1WWlCd29HVkVUU01rWENnQm1xTm5JbUovR1dZSUNs?=
 =?utf-8?B?MEtWSG1ndkdEUGlENElILy8zbFVKS0NxRndCV29EZVVUek9TUHRnZTh0MTBP?=
 =?utf-8?B?YWQ1clQrS1ZNc08vNDUzM3V0aFY4OHBmUzFsYWFWbWtxUDRIQThydGo5RHBP?=
 =?utf-8?B?dGE1bUpBdnhMemk1a2E5a0JFOHN5ZkxUZS9YWXQvMHFmSTNFR0Yxa0h3aHJV?=
 =?utf-8?B?dy81K1VDSDExbFQrOEttSVBjaVpCdkVqUVAzWG5KMy9SM0hzUEJaVFFwRUlz?=
 =?utf-8?B?c2xMWVlRREZqbG95Ti91QnhmbDZNUVVIbmk3RUpwcWQyM3NHelUwZTZqcGtW?=
 =?utf-8?B?S3NFbG5tTHFHd2tQUEh0UUljYVFWT3VOZ1JxbWQ2N2NSTk1rN2E5RURQRytF?=
 =?utf-8?B?OUwxS1RuYzNkdytITjlaYXVkcXNKb1I3aUptbFR0YUY4Wml2Rm5FZDNYM3JO?=
 =?utf-8?B?VFYrVjRqYjR0U2xwcCtLa3M5KzlqQ01oWmlTUG1MOUVjWU5tMlRCWWR0c284?=
 =?utf-8?B?TGtFRXlKZGFqSHZSWG1TR3BVMVJYUVFPTDhmcmZhYmpaU0pqVncrQTdSNytx?=
 =?utf-8?B?QU51U1pyL0p4aUNUY21ZVDZ5bGN4ZHpobW00ZU9iaklYY2VmbEczcWdWdFRR?=
 =?utf-8?B?WExzMTJMOTEveWVLS09XS2d1UStUZEtQaDZ4MlRjV3BySzdkODNNblFPQTlh?=
 =?utf-8?B?QUlVV1NhaVlLUVdDa1pWY0h4NzVzRS9pREtRWW1BckszK2s5Ylc4ZjNnS2FS?=
 =?utf-8?B?R1R3SFdpZksyZFo5Z1BXaTdRZFdvZHh6bTUrek9VVWFDUStzY0MwWkJsTEk4?=
 =?utf-8?B?RHhvaThvL3k0aU5LK1NOR2xneWtqbVZBdk5HN29aOS92SHNyTGpBRCtBc3cy?=
 =?utf-8?B?d0V6VXpualFVbEwrcnY5QkM4eElieVFheTZHdGF5VUxWcFZuOGZsUVpZK21x?=
 =?utf-8?B?UWFkZkxKUTFoOWFEUXU1VXhwRGI3SHhoaUFwNjREVmFLVExkY0NOdWVXQ1ZM?=
 =?utf-8?B?bEE5TmJvSCtHK2pDTXhEcWNaNDhtWmR4MnVjWXR3bVFwenFHNzhkQUxYeVBF?=
 =?utf-8?B?TzdGbTRudHlrQnd0WXdQeEFSL2VUUExpa2M5UEZDejFteUFadzJueEQ5UHg2?=
 =?utf-8?B?UWdnbFlIcnI0UGNXRGJ6M3NmT3crOWxwZ0U3OUFTd3BodEhLMVo5TVpNTUFt?=
 =?utf-8?B?SFd5Slk5bnJtK1dmTEhrQW85Yi9jS1kza1hNVTk4SkhSdXVGek56WG5UV2E0?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hr+GzgFYe+PKK6TorJBHI6hM2blQA0A3+Zs1Yzio8vKoMuYaGcrfsBGWj/ecLEscZvYmaEVVcAze5QAhukdNGr+FMgszzmMhvgB2H++iCMgIMLwSKTOei9gcbXxOLV8h9Sp7eCmBQ4BWtjGBRlnUUXoCqw2KGFvwRSj6FUNLawe7sMznLz/+UAIVO3E6w++Y2O1YW9OEDmLbM9zUXy/r0/GHPtRNKEh7gEGg0hDyill6vhGYmA9mIY6+jMOx4Pa/Qqxnvl9HutDbyKuD+Fk2rngkPd8asHx+OQlTiJZYiqAtBsbz1gkg6PflvcisJI2ZJiejVSqSdjF/PML8eU2UP0lFcor6XSYbTk7qEnC+MmuxXG2OwAl7tojzWFhXuRtKoHEhUqFomY/pNoyu2+kMEix1Xjtq8KiKXyXdqHeHU5NcQIfdkgSA8a9JXsSbiH0bMyxB8DDPUCVgkwwnSafUp+2ex0RQKenDSXjinUscqYzPgSlE9OT5qZT8aKqMRmAn3w81+OKJnSnpo5uUo9WBjolZE6ZcvhJmqekIFKinSiPHU9zw5dmgik3HRo2mD3A/tTdzpjNTtYL9nXhAFlvLwX6HJS6WjHYd//A3ekvHTaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b85bb1-b398-4bbb-4958-08dd4d137fca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:20:30.1934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwNfLw/vVvjQzKXqWPu+XjReJi1MKqyCrX65HYPoL2oXoQXZd/YpJO4KzwZ9XPVYfqmqXbTloUwiz5HSue1LmWI2h3VE/EeBPhdjurii/pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=694
 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140116
X-Proofpoint-GUID: go5HHyaX9_xIgYVmgkcUbiIQzTgRGAGJ
X-Proofpoint-ORIG-GUID: go5HHyaX9_xIgYVmgkcUbiIQzTgRGAGJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/14/2025 11:06 AM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 10:56:02AM -0500, Steven Sistare wrote:
>> Hi all, it would be nice to get this into qemu 10.0.  Without it, the
>> basic support for cpr-transfer already in 10.0 is much less interesting.
> 
> True..
> 
>> Soft feature freeze is 2024-03-12.
> 
> Said that, targeting 10.0 for such a huge series across multiple modules,
> and especially during the time VFIO review is on heavy load.. may not be
> easily achievable.  It might be more practical, IMHO, to target this 10.1.
> Review can still happen during / after soft-freeze.

Understood.  Let me know if I can do anything to help.

BTW, the series is less huge than it looks.  I divided it into small patches
as requested.

- Steve

