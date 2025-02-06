Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EEEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg34o-0003i2-JZ; Thu, 06 Feb 2025 09:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tg34m-0003hV-Iu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:41:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tg34k-0006fY-2m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:41:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gS7P005605;
 Thu, 6 Feb 2025 14:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=sS5firgYL2V1ukNmzxqqt0hOnzFrTyeFWuvN+sgY9yY=; b=
 Y2h/+JJXwJKQZ1GbETfDCZX6jgfbWR67nXkyEcs4qeMpOuD/M98YYQ8EMQMSIRyu
 BfDrOspsVoSchi3OW7rv8u90hOIYYkhrFb8kw/uwbXSZ3w/K2xJl4+Y+5xf3BKDC
 /ky3YGzRA/mfBxEKbD9YFgVoLos0aHALS4nkJ496f/T988Oar9t5AVt/2zcM1ZOt
 oZD9PPmhl2FM09z9x1QLTVRq9NmR08WaocoaLCPcc+RVelzUPc+Zxu3IHAskfq0w
 xdljJohOxjjjrSrTA2DhaOBSMkDruEbESJ06OJpbM/o8ome1anHvgArDwz+LydHe
 1wlcMz9zxsdFs50Ia2EFJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhju1bc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2025 14:41:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 516EJU1h020782; Thu, 6 Feb 2025 14:41:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8frx240-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2025 14:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QG78Ow+tMTOMOS3MAzxSYIte6UgJL3SP0y4ckHA2pHthW8AurMLMnmg5tKug7IX36bpr5zXaX+c0CKPvuL7vAVen5KvNC5c5A+mvSoPOjjPbCvR6MfEX4/KM12E8KBZNEKRkQpj7A9M40Suv7vo9jjOGrgJkfHe1wKar8cnhY/S9gPKtlx5GrgIkaxeewX5uE8urefWskIjj7flRp3kE6KgYTfrvtXKc4w2FzfO80IH5w05n/b5k+Nf9tFYq92BQIBSH0V393vvPPWv8oyfYSAcwOze5fDxG59PmiS1xEMW5Jsw7IeTHczUCbem6iycCT5P2F6kfSnFzMNc3ntocpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS5firgYL2V1ukNmzxqqt0hOnzFrTyeFWuvN+sgY9yY=;
 b=wPoY7MPHByTr553xQMti+/GB+YBLalJmzJR/NnH561QFJW1lxsTs+C8CClWjfnYiADx60DBo3wWJfkDWt5xH0BslOHrJX8/yrwaG3qYGJRxV0EKaT1JuJ4S2cC14kNPqv/HXG9UXLxGNtxN8ODIvGOFaAYaJ0uNvFCTqXswjU5rO06WizKTFyi5exw8UuNsBs7C4Cdo7WBopFolQZpxVLLtBTp8uqXeH9p8wh1Kmz/hrL0pVegORDEpQ/xkidvmv0nXfRj+Lt1Gd6MMtB2hEgzqP+MkRp6pnNytIXJgLS9FNk+OjrZSvbKJHFJY6wy2GjXTjld+3MuxYrbS6yABdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS5firgYL2V1ukNmzxqqt0hOnzFrTyeFWuvN+sgY9yY=;
 b=KzKflO0sJRiY+O3KP7Stetl8yasj15j0BNAlS4mHJC4p4hxAG01nD/gvVVt7YJWK+ljie5XZ03FyjX0O5Hg2LF7h8G1WKZv5vtB0Z/VyWtADKHM3WIoNDPo7p3vNUVQR90fNRju6Yd3buIB7E3iOxC6uIGKdawbo6t8OHh3aPcw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Thu, 6 Feb
 2025 14:41:45 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 14:41:45 +0000
Message-ID: <4b5b7d7d-847f-4e43-9e22-4d307869ab8f@oracle.com>
Date: Thu, 6 Feb 2025 09:41:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 12/26] vfio-pci: preserve MSI
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-13-git-send-email-steven.sistare@oracle.com>
 <db848b31-540a-4446-98b5-dffecf9edb38@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <db848b31-540a-4446-98b5-dffecf9edb38@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:408:ff::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de81d8b-7d70-4be9-21b8-08dd46bc6104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0c0OU5iMk9zVjhSWWhiWERlMWtsaHFlSGVIVytOcWdydEZ2YnV5Smwrd3FQ?=
 =?utf-8?B?TVR2MXpWU2pmeEJFemRFeUtKdTdBMnFzcTBkK2NaYXZ0TW5rckxKVytJcnJJ?=
 =?utf-8?B?dGJLc1RzUThDb250M2FBSm1Pbm56aTlZdmhnSzZ0NklZUzhCMWgvaVhTcTZS?=
 =?utf-8?B?L29sM2MwRDZuUUd4TnRhc3JMZTFqWnNqQzhlOWthSTFCOGo4MTBZRFVhaWpK?=
 =?utf-8?B?aGgxOHMyNGdINGtiTnI0R0o3M1cwSTBBQXI4UlQwaFMvNFBoZE5lcXpneERW?=
 =?utf-8?B?eHZaMTZSMHo2Wm8rVHpMK05aQlhRUjBLNzRKY2xrVGZ1ZFR5cWNjZG1uUkJS?=
 =?utf-8?B?dXM4TVZZWUhPMmFKUHVwSEh2RUNCanoyTFRRaEt1UExDWUVFNDh3TUlxSUQ3?=
 =?utf-8?B?NGFrVmpnV29wRkxxQjRFY0RUUUdlV2NDQzYvbnlsQkJXcWI3THkvS3BxNFRh?=
 =?utf-8?B?dXJPbmhMQ0NzbmQrWE9hNUFCV3pFOU9uZ0QvZXdjUHBpMGxoaWtVSWlEREdq?=
 =?utf-8?B?SHdTVHh6ME1xWDljMWQ2VEpmSWpmcE5aK1pxb1E3Y042TUkwYmpNRzdNOWNy?=
 =?utf-8?B?bWlqUjEvWURweUhPNStVVkljQjBGc3ZUOWFrdnhmV0RJRS90QnFqMTU4TlZM?=
 =?utf-8?B?RSs4dDI2OE9TT1dlbjZ6U3RuNllLc2JmQStGNVJ1V2NOK3JQZ3dkWjBXZGZS?=
 =?utf-8?B?aHdIYnkzTVhFQXkxWFFpZy9rbnh4RGlaME5JY2pwTWh6c01iR2RubTZkelNm?=
 =?utf-8?B?M0d0RG4xOUV0L1lsZmNjL0ZvUkFtVVh6cmJuWlJSSjRPNGpOQmJKMUZNS0J2?=
 =?utf-8?B?dUZGMmpEc003UjVsbGFEOGZQS3BHME1zbGVRY3RxZjAzYWJxMm5uK1VSbEZn?=
 =?utf-8?B?NzRpSDFyVjdpNUFPamlPQm4xNCtWckQzWkI1dG80andyeUtwVHR4VzFvUktR?=
 =?utf-8?B?VmpJeE9JTWVleVpPYjdJeVVLZHhRajdRQmkyYjZiSHdacGVOVU5uVTRubVNU?=
 =?utf-8?B?M2ZqMTluQlI4dlU3QVk4cUQrRFRIUGVmSmVFOUlwY1RGdGt5TFczYmdGVVBW?=
 =?utf-8?B?TEJtVkMxMEZuWlFWeXl3L0ZJU0U1emNQdmk1NU81Y1AzOFIwVlRucHFDSndS?=
 =?utf-8?B?WFJFUnFvYUpjWHVxSFZpWmcrZThkVmNIOCtCakhBN29ZNjBHRXZwRW1hRVVk?=
 =?utf-8?B?VUVxRzZCNFcvNUw5a1BSVkNSTjd2YVY1blY3cUJObm5lOE93VmtraW9hWVo0?=
 =?utf-8?B?dGNYVDlPZzdHVU14SEx0d1Y3d0xHOWZYUVNHVmc1ZjluazBVQTZLb01lMFQw?=
 =?utf-8?B?WUNhVUFYVTJUVHVWbjhHL0lQQ0hObVArdlhSV1NKWWQvY1pPd2FxK1ZKMk8z?=
 =?utf-8?B?Zm91OURWbEVpMzlrc081aGVMRzNMK1VNRFJRSWFBMFQ2aG8zc0NFdVNwNk9s?=
 =?utf-8?B?Q3VwT2pWelQ2bmphdFFoTnluNkg2TUljVGk5S3diTjlXcExOa1JWSkpFYkxr?=
 =?utf-8?B?alZRYTV5SWNRZlBRN2NSTnp1bUZSb0NxcnMwY3BCRFFTMGphc1dIWUh2TmZO?=
 =?utf-8?B?aGVRMStSdXl4NVdEV240b3BaV2gvUndPK3VDWHFIeDZoL0xxa2QvSE9qdEp4?=
 =?utf-8?B?SWo4TVh5V1p3dVkwNndFcHRiSFh3d3piSzNRTFNRenNmZm1TQ2JIa3FlbXlM?=
 =?utf-8?B?QVdadU1KNkNReDZWaXQyOStGMzJmdkNrak0xZzBjREY1dmo5RWptWk05YmFt?=
 =?utf-8?B?bThIVlhJRzZsTlhOd0g2SjA4c1F5Y2wyRHI5QXhyWnBOMExWMmY5bUhNaWpa?=
 =?utf-8?B?RnZieUxseHI5TG5aRUNWMm83dEJ4VHMvdnBGYXd5ay9qOGNUcmR4KzVRenhJ?=
 =?utf-8?Q?GprqrkgnuMr2F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9MTmNtUHpUKzltak1VcmZPS1hEOFlNdXZ1TDR1YWJ4ekplZUh2WVQ5dkJa?=
 =?utf-8?B?ak5heTl6L2lDRU5HUFVOY0picVFRcWRIOHJ5N0tROFVTd3BkOStTdWdkQmVR?=
 =?utf-8?B?UjNpV3lHWmpKeFRnT0h3WEZMYi9kdnVnVSthMy9wUnZ2ZGYyUzFGeitTUHhI?=
 =?utf-8?B?Znl1Y0I2Q210S0h2TENhbmhSejlOd2RmS1lYeEJ4RU0vcldpUWNOUE9rVGtR?=
 =?utf-8?B?bXFhVU1qU0xoYWJ3d2tINGx2UFp6d1NYYUl5M1RxbnM0L21ZL2NJbDREQ3Jn?=
 =?utf-8?B?Y2Y2bCtUMWdlWjAxbHEwd2FVK1RlSCs5UWpwdFU3TytkVVg5blBVNUdGWkpx?=
 =?utf-8?B?dVNxcmorb2NTMVRWelRGS1ptcHhIMGowUnFOWUZWZ3cvZDFhYmp3emdrRW0x?=
 =?utf-8?B?WFdaYm1pdC84MUltZ2VpRURHOWNZUWdPV3dmNG5zSzZHSVZxb29QaDRncGRO?=
 =?utf-8?B?RFd0NFVMWktzYVpyUWEzYW1EVlU2OVBFNmplTUN2TGhyeWFyNG9VdmYwd2lr?=
 =?utf-8?B?c0x1eFF2UWo0NDVSbUptdUFLdlY1RnZ4SHVMOVQ4dFpzVjBnN3hXcUFaOXFP?=
 =?utf-8?B?Tkd5ZW1GNENIU1lXN3VNdE0xVmZxSlhXa01WZWxGcEp4aFN6RVVWREVVdSs4?=
 =?utf-8?B?UENTYUJvYXRzZkNTY3dRUEJjT2dNbHNwN3lGb1lUdmtPWlZXT1QwZE1ScFVW?=
 =?utf-8?B?TGZkczZkZ2dkNFVqd2M4aEp4VWdJS3FQeXRGTUd5K0NzWDgxVnJkVDNxa2ZF?=
 =?utf-8?B?R1phcTBhT28xV2I2akRLUjg5NGtTWTFuSi9sbUwwOUFOOEk0TGVkZnlXRDBM?=
 =?utf-8?B?a0FQZmV3K3pNeGpHWGJtaUpySGlKSHJ6ejJjYUJib3diRG5FdkZDTGRzcENV?=
 =?utf-8?B?R3ZjcTAwYWlOVzZSbHZVdUkyUlJ1SVpKSXhYZ0ZTaVBiNUhGMTZXdGtCYzNH?=
 =?utf-8?B?KzRua0hhWmdEeUxYUW1oUWx0TzMyRzRaYzVnVWlEd1NpTWEvbzJTbHFwYWo2?=
 =?utf-8?B?czY1eHdveXAwb1NQVjBwRllkL2NwZHp3NDNlVlVFYU45UTh5aERkbXNwQ2Vo?=
 =?utf-8?B?dlVrcWV6SWxNT1lDc1ZrWmRDODNjejZkS2JnK1pDZFlPeU5qWS9BbFNNdkhs?=
 =?utf-8?B?RGRqYjk2VVZweXVwSE5NZS83QS9UZEgwbG42MkdDWGpjemlhVytDSGEyRFBq?=
 =?utf-8?B?MXBjTzFGTzRuK0tING40akVkWVpzNnVSTjhRNVc0TytGYXBCVEJRdW4xaEZX?=
 =?utf-8?B?clZkdjdIZEFBR2U1TCtOVXliWms4L1VNd1dvN2dQNDN1U01FWkFkaVRtVG1E?=
 =?utf-8?B?RFlXKzVpQlBWczFFeTBhVDhLRjNBY3BHYnJwa3FKdUdMK0diL3kyY3lMZloz?=
 =?utf-8?B?MDBDYjhURWVZMEtFNHRIVlY0cFQzVlBZTm1wbHVqdE91MzN2cDh4Z2t4S2NR?=
 =?utf-8?B?S3JtaTM0alVLQUY0amNUNXdOa0M0VkZBbXdrOHUvZ2E1L0xXcS91Vk9xcHhZ?=
 =?utf-8?B?VXUxU0pwRVNzYngyQnNaTVZLZUdUTGZiVHpEQjEzMWJzdzBDbW9yQnkrdzJo?=
 =?utf-8?B?NGY5RWpSN1BKenlvQ25pc0djeUdHcHhiRVo3VHdrRVhnNWxyUmk0R0ZNZzF1?=
 =?utf-8?B?cUpueThaYW9ycmxtZFN2ME9jTFQyQlluRUR6cU85ZU02eVVHSlNWaEd2TTlK?=
 =?utf-8?B?c0F0ZWtHbVQzYTlvQkVKV0hGWDNoNXYxd2ZsMFQrU3o2VFB1R1o0UXJsdndN?=
 =?utf-8?B?cVFOU01jQ09XMkI4RzhuQUdBQlRFa01DWVNTMXQ2akN6N04vR3Ayc1Nxa1Zt?=
 =?utf-8?B?M0hmVkZHVk01Q2ZXdDh5eG1xNE1JMW1TSGJlRkN2MG1HdmRtRjFOdGRXQ1Vk?=
 =?utf-8?B?WEVET3RMc0NyVWNRMDkzRnRNUFpMZkE5eDRvQ1F3bkFSZ0lmUlhJMXV3eDlY?=
 =?utf-8?B?WUV1RW54dUsxVWI1WjZtQk5Uc0FHeXdzNmhuMDBlYVUzOTZQYm81M3YzRmtt?=
 =?utf-8?B?QzJVU1dBRkNYckYzMTBEMlZGRFp6eGxMRGtTR0RadzVWa2hNWGhxaG9qS3JX?=
 =?utf-8?B?ZG12ODU0eGQydWcxWUlsM0tubS9EL3NUY0lyWTJVUmJiSFQwTmtnNmlNUno4?=
 =?utf-8?B?SE1ZbWFJN2ZlcFpBM1dOdVJoemJMYWFGN1hqcTZ1cFJDNmkveGlxOHFyQmhZ?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vex95xKOq10N/PT8v/WVwm4b4ez9k9LZ7x6bfQ98Cr78s7pcvstc8XFn8oclk1rAZrJI4CQ4PzMbIUvq+SK8BvD7JY6LRp0jU4RzRxVQXyxG/MzGPAPPTg1WPgsmLsxmgiIgQrVwOaz/SoyTJYGYzdHntU07sL3/ljq04XL/sqKG73x4mSMU0yV7ZrlTRCvPsaUyhWJLy71vCMFGd5Vd2EGYroZIrR1WX1eT353wvTuV/0U4Y066Vks2Fhidm1ynzLxmz8PMD4vfwBEmgKmhLXgVwfZ6oYGBJbEKW7vOR502dyAMrT8RMERc5OnTmIXU0bsP2OUR+H37zoHRp24Ci4jz7B9K2/BRDYAiHchujj01Jbn5bi+2ovOtCie5TB41lox9JEYIaPmEyhMzFgugeTfJ/MKnUBnMx3T6KBR9NJQAvGXu1qxfW4uMUuEMUYp/GzISL9pCmAA5++Er4suZC6mPsv6OxHP3ZjjgJh1RbugosRjrc894iQPplLo+QphthDGCpexTRWdaR9Aav30h4UkvtjeeZ1lcADsFioaqEYSdOoGaeqxecSXYD0QmpSLfmuikbnTZIL9q1oqMWxh4+AbLtBvAT/dUS2lhcSkQqX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de81d8b-7d70-4be9-21b8-08dd46bc6104
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:41:45.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEjhPiBpylWHNWQAKNKmKM9Bk4FSxs53HNpNRvHDtJKB9sCoOjojCLhykPltDHIZx+6lFjiQ4I2HNod8wKWwCeK8iZY3NIS/tum6dwXaLTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060120
X-Proofpoint-GUID: 0VVufNWpWGSwPIfenN8epqaSf4qcRA78
X-Proofpoint-ORIG-GUID: 0VVufNWpWGSwPIfenN8epqaSf4qcRA78
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

On 2/5/2025 11:48 AM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Save the MSI message area as part of vfio-pci vmstate, and preserve the
>> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
>> then the vfio-pci post_load handler finds the eventfds in CPR state,
>> rebuilds vector data structures, and attaches the interrupts to the new
>> KVM instance.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/pci.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 116 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index fa77c36..df6e298 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -56,11 +56,37 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>> +#define EVENT_FD_NAME(vdev, name)   \
>> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
> 
> hmm, this helper could lead to memory leaks if not used as done below.
> Being explict would be safer.

How about renaming it ALLOC_EVENT_FD_NAME?

If not, I will uses g_strdup_printf at the call sites but define a symbol
for the format string.

>> +static void save_event_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> +                          EventNotifier *ev)
>> +{
>> +    int fd = event_notifier_get_fd(ev);
>> +
>> +    if (fd >= 0) {
>> +        g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>> +        cpr_resave_fd(fdname, nr, fd);
>> +    }
>> +}
>> +
>> +static int load_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>> +    return cpr_find_fd(fdname, nr);
>> +}
>> +
>> +static void delete_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> +{
>> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
>> +    cpr_delete_fd(fdname, nr);
>> +}
>> +
> 
> please move these helpers to a cpr file. They are not strictly VFIO
> related too. So they could me moved outside of hw/vfio.

OK.  Moving to migration/cpr.c.

>>   /* Create new or reuse existing eventfd */
>>   static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                 const char *name, int nr)
>>   {
>> -    int fd = -1;   /* placeholder until a subsequent patch */
>> +    int fd = load_event_fd(vdev, name, nr);
> 
> 
>>       int ret = 0;
>>       if (fd >= 0) {
>> @@ -71,6 +97,8 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>               Error *err = NULL;
>>               error_setg_errno(&err, -ret, "vfio_notifier_init %s failed", name);
>>               error_report_err(err);
>> +        } else {
>> +            save_event_fd(vdev, name, nr, e);
> 
> I'd rather move the CPR related fd handling which is done in
> vfio_notifier_init() in a cpr routine which vfio_notifier_init()
> would call. This comment applies to all the series. Anything
> related to CPR should be handled explicitely :
> 
>      if (cpr_in_progress) {
>          cpr_do_cpr_related_stuff()
>      }
> 
> It will ease reading and long term maintenance.

That design pattern does not apply to this call site.  The event fd must
be saved unconditionally, in case a cpr operation is performed later.

>>           }
>>       }
>>       return ret;
>> @@ -79,6 +107,7 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>>                                     const char *name, int nr)
>>   {
>> +    delete_event_fd(vdev, name, nr);
>>       event_notifier_cleanup(e);
>>   }
>> @@ -561,6 +590,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       int ret;
>>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>> +    /*
>> +     * Ignore the callback from msix_set_vector_notifiers during resume.
>> +     * The necessary subset of these actions is called from vfio_claim_vectors
>> +     * during post load.
>> +     */
>> +    if (vdev->vbasedev.reused) {
>> +        return 0;
>> +    }
> 
> again, I would prefer some explicit CPR test. Same below.

Reused is an explicit cpr test, true iff an incoming cpr operation is in
progress. I prefer the short name, but if it would help you to see cpr
leap off the page, I'll rename it cpr_reused.

>>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>>       vector = &vdev->msi_vectors[nr];
>> @@ -2896,6 +2934,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->err_notifier);
>>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (vdev->vbasedev.reused) {
>> +        return;
>> +    }
>> +
>>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> @@ -2960,6 +3003,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->req_notifier);
>>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>> +    /* Do not alter irq_signaling during vfio_realize for cpr */
>> +    if (vdev->vbasedev.reused) {
>> +        vdev->req_enabled = true;
>> +        return;
>> +    }
>> +
>>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> @@ -3454,6 +3503,46 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>>   }
>>   #endif
>> +static void vfio_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors, bool msix)
>> +{
>> +    int i, fd;
>> +    bool pending = false;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +
>> +    vdev->nr_vectors = nr_vectors;
>> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
>> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
>> +
>> +    vfio_prepare_kvm_msi_virq_batch(vdev);
>> +
>> +    for (i = 0; i < nr_vectors; i++) {
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +
>> +        fd = load_event_fd(vdev, "interrupt", i);
>> +        if (fd >= 0) {
>> +            vfio_vector_init(vdev, i);
>> +            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
>> +        }
>> +
>> +        if (load_event_fd(vdev, "kvm_interrupt", i) >= 0) {
>> +            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
>> +        } else {
>> +            vdev->msi_vectors[i].virq = -1;
>> +        }
>> +
>> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
>> +            set_bit(i, vdev->msix->pending);
>> +            pending = true;
>> +        }
>> +    }
>> +
>> +    vfio_commit_kvm_msi_virq_batch(vdev);
>> +
>> +    if (msix) {
>> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
>> +    }
>> +}
> 
> move to a cpr file please. We can have a vfio-pci lib/common file
> for external users. It will take more work to get the interface right
> but it will benefit other proposals. I think vfio-user as more or less
> the same needs.

OK.

>> +
>>   /*
>>    * The kernel may change non-emulated config bits.  Exclude them from the
>>    * changed-bits check in get_pci_config_device.
>> @@ -3472,13 +3561,39 @@ static int vfio_pci_pre_load(void *opaque)
>>       return 0;
>>   }
>> +static int vfio_pci_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int nr_vectors;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
>> +                                   vfio_msix_vector_release, NULL);
>> +        nr_vectors = vdev->msix->entries;
>> +        vfio_claim_vectors(vdev, nr_vectors, true);
>> +
>> +    } else if (msi_enabled(pdev)) {
>> +        nr_vectors = msi_nr_vectors_allocated(pdev);
>> +        vfio_claim_vectors(vdev, nr_vectors, false);
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        g_assert_not_reached();      /* completed in a subsequent patch */
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vfio_pci_vmstate = {
>>       .name = "vfio-pci",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>>       .pre_load = vfio_pci_pre_load,
>> +    .post_load = vfio_pci_post_load,
>>       .needed = cpr_needed_for_reuse,
>>       .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
> 
> 
> I think you can move vfio_pci_vmstate out of hw/vfio/pci.c too. Only
> cpr needs it.

OK.

- Steve

