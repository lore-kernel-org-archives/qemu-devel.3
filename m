Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B73C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1SI-0006UJ-Bt; Thu, 07 Aug 2025 10:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uk1SF-0006J4-Er
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:18:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uk1SC-0005gb-Ka
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:18:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NFtv009203;
 Thu, 7 Aug 2025 14:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=DQB4+QE3QDwGI7eihhna5JXd1DsW1qzhXW1oDbYx1oY=; b=
 fcYnlX+n5/RTK932iu/J3nvFj1NDTyep03vcYviZyKJi55169PwkYtkoYzE3rkVZ
 DOqgn9gxm/ByGNGmVkIMUzuH1iPS78Gd/9P8xXy+FDCVRKcZxOTflvFrbLo6hIT8
 WwJ5SD0U4xsbJ8m0lTws4fHkZAs/7BEXp5rY4ixs3zVBasWhURUgBmRs04LdWYIV
 2K1+yDvuJLw8h4o2PRPdYJ+nt0buEIUQfNK88SGTJ3gIeZiuvJP+pZDicNjaEkVN
 ffdp9n4shNszFggaw73AQMiYEsgzqXQwjNmkRq0SfQXLQuxGPg6jLTe/aqhxICJA
 8hrsQZF7XeL8XoHUTCWVCg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf46vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Aug 2025 14:18:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 577E1ur0028548; Thu, 7 Aug 2025 14:18:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwnqrkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Aug 2025 14:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQsjdZCNSu0+cAPS609D06P16tRtintX702NQoYJoZj4gQelKplveGt8HM0RO+U4AdFtuZmRVUuYMDFtTJPIimm0mM/oVTcVBjuP6lJ94jOsiXXo/SsFuCXra+wiYwzLbK92ocZ/sWMdqCOUv/M1LJyF3pEtdyd7y4ubCRyxXwdkfc9CTRr15dPmllGkHYqWUfqPYIcTJ209AksPgcaNSi1B9Jei+Mo7guze8+aaqwZuLZMhKyg+h+0Chuk+bkF+06kL8J3joCVabj2+EyxclW/OYRT6X6jFhnWi21+0Bgh+Sb1en8/F2n7fvepvFWNJDrc4ZvljceObk3Z5GMHnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQB4+QE3QDwGI7eihhna5JXd1DsW1qzhXW1oDbYx1oY=;
 b=vBLzNSvNhpkHKLE7t40z69ZXtJP63v4lK1Hyl3F01nqjw4tiJd9d9f8K+YnCJkQrT0H5Djqt8Aofbrvai738wtqLIK5t0iBMbZMQ5oVqCDlUAEXyucctuShBjt6Qd50/p357byoGGqr2tuuNvNx6PSHAsof36oEncD+3i7lxv3GV3WD8I6PaYCrLfZImFySlmhEmxrTChWDT22RllMitQP/kIwSe1nd3ZTyw5CAtp141sEsmKDp7C4wS47VI6vLtXl0utxcjhZJD0x3/Lr8ZxIhnXz3eKsQ7J5khjTn9r7hBdyH4VmkHaNJ61fpKR9ROdihMdhyVlJDnNCBh4ca0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQB4+QE3QDwGI7eihhna5JXd1DsW1qzhXW1oDbYx1oY=;
 b=eIN7ZhgWmApn0p2KOg4/UsGb8xpNf0jwNhDTkkLhQsOJ8IxU/eEc0d24IbT5vYNC3SXH4NVfRcP1bOFk1G1oG1xMvevV+8PKJjSROFWV4dC1ci2BmFkvwBGn/if5Zpie45ZIrw9DumJRNejBNCYZ8gOFziCVXq7eQPsHofuar7A=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 14:18:42 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 14:18:42 +0000
Message-ID: <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
Date: Thu, 7 Aug 2025 10:18:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <aJOCiUPp0dckmgAn@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:33d::20) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e69e60-6471-422d-5552-08ddd5bd4fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K25jQXE3WUdCNndEQVNKMkhEcDNrTXFKV1JMRmVOaERvVXM3eFEzdWZsUi96?=
 =?utf-8?B?UERwdWQ4L3ZuVDUxSjlRWjA5cTNyVUNocHo3RW44WlZrWHlNQzRYSlljVXJi?=
 =?utf-8?B?TzlXdFlWWDdvTDJ4M01TQWNoemxuUS9PbmR0bTRqa3lhc2VMQzBPQ09mb3No?=
 =?utf-8?B?YUZqUVdjcXI5eFllQStLUU1Dd0RBbTMwSVdvOGRYSTBPS2pBL0pQaUlsOEZn?=
 =?utf-8?B?K2pGSTVSUVQ3bG1EVGFBdkJSOGhqZXRPZGhtN2FHV3VCYUZhZXByVnJLdXdB?=
 =?utf-8?B?NXlCTkorQ2NLWUw5SmF0b01wVGNKNzNVRkc5T2owODB1Lys1U3BYUUVQVURM?=
 =?utf-8?B?NklHWk1DTVFaMjgzakJsYi9VaTkzS25vWWdFM1cxbko0cnFySVVqWEx5d2VX?=
 =?utf-8?B?K3hNdnkrQWZ5OURjdVMvL2FsSWFvK3ZjUkdzVEZ1bEpEUVRuSzc4TUVzMEJi?=
 =?utf-8?B?U3ZDR3ZsYk9NN0s1VGdNTTFOWkhMc0xnU3QyUUF5ZTNNam5ZK3pZVGJIY1hS?=
 =?utf-8?B?UWVqK0xyMXhNTnZ3OFpwWnF0bjU1UUN3WHBmYllWNi8xYTlkL1JVM2ZvVjV6?=
 =?utf-8?B?L3UrWFljSTYwWUQxMDRmTGl0ZENqcXZrVkg4TTRTUEFJR2JHMldNbTR3SlBL?=
 =?utf-8?B?S05QbEc2emdUdU0rVE1kZlc5cC9odDRleXN6MVh5QzRrS3VIakUweERWQ2Iw?=
 =?utf-8?B?OXNhQURvaVJkY01XbEdDdys4aCtGOGcxdHNUWDhQeVBEYVhrWGxVd1ZWekdl?=
 =?utf-8?B?VTV1Vkl1ellmVTl2dU9VWGhCbUxkQ2lnb1VaWmY2VHYvVlVQUnI1K0c5VTdO?=
 =?utf-8?B?SUx2QkliUW9LdWNoZFljYTVuUHllbEczZ1hISmpoWWw5RDNsTVVTU0FOdkZ0?=
 =?utf-8?B?TVRXdkplaEhVMlE5VVdtL0R5a1pnc2VzYnJzYVJDTUpWY2UwRzFrbVZ0VUhX?=
 =?utf-8?B?Ti81L1BMWnFiQUZoYmgwTHQrbXlpYWZ6RXJFOU95cnRBMlVqQVE1YXRqQUht?=
 =?utf-8?B?cm5zNXczRUJXNkM2YnlnK1kxa1ZtUFJDd1lOVFBSU0NackorU2UrOVBXU0ZX?=
 =?utf-8?B?a2phSVhnSHRxa295dCs4OFQ1UGhhS2s3WVYyR0dTRTNvQi9oWGlhZ01Zblox?=
 =?utf-8?B?Ym5EUE01RUMwemFaQ2lvS2ZzWmdzeGUrSks3d2d5R2lxdCttWXl4Y3hXMHc2?=
 =?utf-8?B?T2VoQS9oRTlaanVCU3FIeTBsTUpmUDQ0YlJvak0zZmczeVRBbXhPZy9mc3Jl?=
 =?utf-8?B?ZWpGOHJEUkMyS1duM0lUVk5UTWs2dlJXVTc2QjZIMjFIUExNZFUxdXp0UmVE?=
 =?utf-8?B?VWNWTlVMMU9vU1pxbUVvTE56U3R6SDlrRjl2MzhXWlZ2RjU1UEF6YmJTT1Jn?=
 =?utf-8?B?d1dKcmJBbFlNRHZnd2FSVnVFWjlGL1AwdmNvOFBWbFdZRno5eXlUUU5NWkt2?=
 =?utf-8?B?K3diano5dzI2aTJwZ2pQVHdxYkxhWVdkZ0JiZW4xU3BQcVAwRVNMajNZQUhi?=
 =?utf-8?B?MnVwNi96MW82TWV6NGhKbzZYVzRPeUM5K21zNlJMNXl2WTZFLzh5bHVpMVhM?=
 =?utf-8?B?Sm1GR1B5bUJ5SGphTHBjZFlWcE5aaDlhcTFPS1dOdm5xak94eFhYYjRqZEVJ?=
 =?utf-8?B?UEVHZ0Nmc3kzMDRRWXhZWTJsVkZYQ2d4UHQ3UGxMemhETkN2SUh5ZXNYUHVU?=
 =?utf-8?B?L3kxLy9RSFZiTEtJU3JWUUpoN0Y4aDlhSTgvZEZDblhHWVVzcEhQYkUvNDV4?=
 =?utf-8?B?KzF6ZzVqRkZEU0I2K05yWkxtaDhpc0tvemtreVZ2ZXJHYXN5MlVxcnUrZEFV?=
 =?utf-8?B?YlA4ZjV4dHlRTEcyZytTV2U5MXVDL1dTVmZHQk1qU1NqNXZTQWVacW9qZ3ll?=
 =?utf-8?B?WTNIMHBQUytDSWhib1NmNXBtL2tkendwWlZpbjE1eTlQd1h0QUU3SG5nSXBX?=
 =?utf-8?Q?9/0E6Tnpr/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDI4c0hjU2xCTEFGK2h5Wnc3aDY2a2pKZ2o4MUJhYWwzSUFWeFl6dlUwM3lz?=
 =?utf-8?B?OXNaN1dpM2FscUJzTXZCSGZSYmFzR0xkRzE3YkpQSFV0d2pseDJkK1cwbUJC?=
 =?utf-8?B?RkdLQ0NWL3lhYWRXTUtheVdSaU5XR2JJWEU0bys1ZCtZNnZZOTdQbHFTQlc4?=
 =?utf-8?B?KytRaGxPRURWMDhOZHRVOVNMaXJ1QlFnMjFjNmptNm1mOTdraUJUbGp3d3Ro?=
 =?utf-8?B?cWhQeVpnNGZFczh5aER3VFlMeVg4U0hxcFhzNlVJWkNMYk10ME5iTk9sWVc2?=
 =?utf-8?B?K2RxQ0R0eEJRSy9VcU92THE0U2lweE0vVmdFdmcyd1V1MjBMamRJbTU4Y0hJ?=
 =?utf-8?B?SDdoNktCZDJNdUsxUjgyRCtSL0lrQitqanA0dUJHZTFJc1NTYXUxanBJa2hI?=
 =?utf-8?B?WTFUYVFQajBGTjlSK3VkMjRqMWx0dTZwQ3lZRytIN1ZJTUozcUNIdjJxTmdO?=
 =?utf-8?B?b1FxY0YvR1llODhmaU1XYWpNSXlqOWVTSVIzenZLWThzcFYzMXR3czVtWHNE?=
 =?utf-8?B?T08xUmt6alY0cXBuRFF5SjAwRnBwTW9zN24yeXBiQkRTTW0reHh3Sjk3c2Nj?=
 =?utf-8?B?M2Jmbll5WnVEQkMyZVBqOEYwM1ZzVVd2SFFDbnVZRjZMNUdrNnRnSktZSUR5?=
 =?utf-8?B?LzVPaE9mZmsyVkN0VmJRcnR0VjluK2hDMnl3VCtaMEtiMk9Iem5KQmFPM0Vs?=
 =?utf-8?B?NUhkTXNCVTRJdmpiNnNLMTU2dWFyRVRhQVVtV3k4d204REJENWxsLzdNdmRZ?=
 =?utf-8?B?RGVFQW1RZjVpZDZiaUk5aTRZOEhyZkhVaVZyVXlRM280ZS8vY3FXTXZUL0JT?=
 =?utf-8?B?M0tEcXFMZG9FdmxsRlhMNTEvc3RMOGFFUnVORHF3ZFVkb08zb2pZTXFzd0Y3?=
 =?utf-8?B?My8zbjRrYWRSVXI1K3VMeFVMQjdGZTBJRUdXVTdyY3A1QU1xcXBwYWRxaGdR?=
 =?utf-8?B?NzNmeUtZOEtFU0lseDdPRHp5dXJBM2wyUm02eHhsUzJHT21USFIwKzh3bFln?=
 =?utf-8?B?RmlXRTJNSmV5dTIyUkZRSGZFV3crRndHbW92NjNDL1BOQmhneDM3UTlJY3VO?=
 =?utf-8?B?QmpDZk01UjNZeXBvbDlWMFpkVnlVcHdHM0UxdzRnL1gxbzVKaTRKcUNMa3NI?=
 =?utf-8?B?RUZBcEg5RjdoYnlSc2NuUDZRYU9POGFyVE1YRWp2d0tTOC9EOFU5VU1jMzJX?=
 =?utf-8?B?eGxJM1BQOEFIaWFLMHNmOVpWa1BlbGxTbzdhYzg4aGtDeDdoR3drV0tIcE9w?=
 =?utf-8?B?QlhyN1llNWJsMktuTUxLUXU3VkJpYWRxTFBrcUxPNUM1MFNKUWMyNW1QRGVS?=
 =?utf-8?B?aHJ1eXM5RlgrbC8vSDV5SHRTTUtvUkoxWTA0dm1HMWpzVXZJVFNZUDBhMXRN?=
 =?utf-8?B?WC9lYUMwUFhsZXdwMEV2SEJDcWgvRG9sSjU2TlIySDhzdkFPMG92aWVBOUIw?=
 =?utf-8?B?em85OWVKaXdPZGQyS2tUSCtsV1VvQ2ZLdzlvV0h6NnJmMVA3Q0R6UmlDbklm?=
 =?utf-8?B?eXBlVkNtZ05ib2t6M2RjamkxM2xqOC9VMzM3MDUvVmRlRk03UXlSSFdZOVk3?=
 =?utf-8?B?SjdFS1ZiVTNPNVNuc09NeG9ualpzNEdTaXBMTGtMcmFHSjJMcU1Tb0k2Z3U5?=
 =?utf-8?B?dzBXcjNvaFp3VE9CeUJndUQ4SEZMNTZDTUtNdTZqQUEvbzd0WHJZbCtFL0Zs?=
 =?utf-8?B?bTFRYTV6VmJoMHIyR2J6RDRDYWdDa3hYclpHMU9wRCt3NDlNV0ZyMWI1UHpD?=
 =?utf-8?B?eFhKTm5JaWdBTEZrVmV6b29IeGo4Y1JRcWFnaFJobkx1THo5Y3daRlRUOHlS?=
 =?utf-8?B?ZVBuRmpRU0hYaFZqTG9oVmhoQTY4cTA3WHkwZGs1M2pVYS9IQTVFT2VRMkg2?=
 =?utf-8?B?M0orY1gzcVhJTDF6Q0M4YkYrd1JnVC9PazJGdUY2ZXlRTWlVOER4TUZROGps?=
 =?utf-8?B?SElQYnJuR0lBc21xcUIxSGwxa2hvdTNHSzJMckNzVW0zZ0l4bUJTcC9qdGRT?=
 =?utf-8?B?dGpPVW15NExUVHM0ZXJvTkZnUFN2aEZJTE8zMHFzZ3c0TEowRTExMEVTSVpL?=
 =?utf-8?B?Z3lOQkVxSFEyMWNDVWJNRXlpWVNiRk9oR0g1K0VVUERPTWcwWUYvUWtCRUw1?=
 =?utf-8?Q?ueOABUR86EZbx2nb7y0bcpepe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 41dPjG8Ajoy3/aZ/Xq842y1qhhbuMs/rNxJrDsbV6VaH59JRwcKfnYJP/Y7lcMVimlGs7fWnPskBW6JcOebJFw7DMRdrf521/XxReKmnwqzcZ6dgE7q9T/Y1DAup9K4pVNVmD2Qvt6vrItMdKNIAvC0I+8iWiU9dB5GyjR123dE9JqPud77pd4XyWUbcdONqAsP91SJinXg2/kxWHa9sF/QL3xUXLlyNoeEZD0+1qzsQQ10eyRoANCZvxZE5/syCeI+WhQ/66UIg5foCftYjxCKp4VpwiHY0uWN848FVHAM09y9qE2tIMPHIC8YpaFNE6EolGWPev/jZCQ6JzYAWtZnpSwU42Fm1aJiqowvRl0+9T1hIncBlfW4Nz49q3X4Xj+Yo28VzxZhyuvT6x8G/ZyGBIi5pB1teOt2nflX1OS3qb+pkIphfC/UkozhUBlv1IgTU7Go1e1SjvPF8ywdqbbMshatKj06NF88NjHUOHw8YdEvoTjPYRVFA+GEUThvlESJCABj2LDIEkZ/bpAcI4h15bhZFR0WlME4XSsyZC368Op2xfrZ4ve7yppHUNtaJKDPrTM7pptl99HypJvcrT30sa81Dih6LiujXvA4S6o0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e69e60-6471-422d-5552-08ddd5bd4fcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:18:42.2393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fg1oJdzHfPnJkI3lnidyAjyTUv0zWzzSg5ITsHWd7IrqBA8Nj20JKll8VgMfGAYwHzof2WW53OPNmVdqjl3+Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExNSBTYWx0ZWRfX8Pn4q/t0o2CS
 93C0THk2lGQqJ8CL/1L8g9xDqhepGXknKv58XEqvu7GJ2XC6+uZL/+Wu9SSUwRy6wnqa5AIPlmS
 2Ws6HxFA7h0+Gzhc4vsFiwGGI+1JI4LjZfBC5UQB6zCXQF2OrEnHVqzSIUP+76012/VTSzXJ4mp
 JLh6udhj9v3xvRm9vCytFKMzIZI2dj3qM/ai8m5SMK32JkDgaYK3tLSMqOTj+tKza7d295QFvZt
 WBLyy1ICOt91fs0nyj2iqKOCE9KfpVw9D1Rr/noLX/EDu4MbXBu97KyIWnXOwbf65OrqNgZJ7SD
 8wDE5p+dht7S/7y9HVuS4EHjE5orMZoxGs3ljaPEq2zast54FXI4XN22oKFdTSreVorSWc0EBW/
 PWLDN5oELVkm0oVaBosstE8xclkc1q6lbcvNSP5wk6HVFaWUOkhgaHbzovj829FswAyJibjy
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6894b5c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Xv3t53ZdFXovULEPVEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d9xPV3LmS_CKlgacEcfFK68yxkJ6wg9A
X-Proofpoint-GUID: d9xPV3LmS_CKlgacEcfFK68yxkJ6wg9A
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 8/6/25 12:27 PM, Peter Xu wrote:
> On Tue, Jul 22, 2025 at 12:41:26PM +0000, Jonah Palmer wrote:
>> Iterative live migration for virtio-net sends an initial
>> VMStateDescription while the source is still active. Because data
>> continues to flow for virtio-net, the guest's avail index continues to
>> increment after last_avail_idx had already been sent. This causes the
>> destination to often see something like this from virtio_error():
>>
>> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4
> 
> This is pretty much understanable, as vmstate_save() / vmstate_load() are,
> IMHO, not designed to be used while VM is running.
> 
> To me, it's still illegal (per previous patch) to use vmstate_save_state()
> while VM is running, in a save_setup() phase.

Yea I understand where you're coming from. It just seemed too good to 
pass up on as a way to send and receive the entire state of a device.

I felt that if I were to implement something similar for iterative 
migration only that I'd, more or less, be duplicating a lot of already 
existing code or vmstate logic.

> 
> Some very high level questions from migration POV:
> 
> - Have we figured out why the downtime can be shrinked just by sending the
>    vmstate twice?
> 
>    If we suspect it's memory got preheated, have we tried other ways to
>    simply heat the memory up on dest side?  For example, some form of
>    mlock[all]()?  IMHO it's pretty important we figure out the root of why
>    such optimization came from.
> 
>    I do remember we have downtime issue with number of max_vqueues that may
>    cause post_load() to be slow, I wonder there're other ways to improve it
>    instead of vmstate_save(), especially in setup phase.
> 

Yea I believe that the downtime shrinks on the second vmstate_load_state 
due to preheated memory. But I'd like to stress that it's not my 
intention to resend the entire vmstate again during the stop-and-copy 
phase if iterative migration was used. A future iteration of this series 
will eventually include a more efficient approach to update the 
destination with any deltas since the vmstate was sent during the 
iterative portion (instead of just resending the entire vmstate again).

And yea there is an inefficiency regarding walking through 
VIRTIO_QUEUE_MAX (1024) VQs (twice with PCI) that I mentioned here in 
another comment: 
https://lore.kernel.org/qemu-devel/0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com/

This might be better handled in a separate series though rather than as 
part of this one.

> - Normally devices need iterative phase because:
> 
>    (a) the device may contain huge amount of data to transfer
> 
>        E.g. RAM and VFIO are good examples and fall into this category.
> 
>    (b) the device states are "iterable" from concept
> 
>        RAM is definitely true.  VFIO somehow mimiced that even though it was
>        a streamed binary protocol..
> 
>    What's the answer for virtio-net here?  How large is the device state?
>    Is this relevant to vDPA and real hardware (so virtio-net can look
>    similar to VFIO at some point)?
> 

The main motivation behind implementing iterative migration for 
virtio-net is really to improve the guest visible downtime seen when 
migrating a vDPA device.

That is, by implementing iterative migration for virtio-net, we can see 
the state of the device early on and get a head start on work that's 
currently being done during the stop-and-copy phase. If we do this work 
before the stop-and-copy phase, we can further decrease the time spent 
in this window.

This would include work such as sending down the CVQ commands for 
queue-pair creation (even more beneficial for multiqueue), RSS, filters, 
etc.

I'm hoping to show this more explicitly in the next version of this RFC 
series that I'm working on now.

> Thanks,
> 


