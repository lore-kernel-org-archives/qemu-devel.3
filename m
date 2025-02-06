Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0DFC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg26x-0002JY-0k; Thu, 06 Feb 2025 08:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tg26s-0002Gx-HE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:40:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tg26q-0000hN-4Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:40:02 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161fqtB003926;
 Thu, 6 Feb 2025 13:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=B5cej1AJlFZc/BaLsFc4o5Avxosj/h0XKA6oVIPPFSU=; b=
 gY99bdSTyiAX/dQTAUk0rfRXREe9APm0HFTs/AX/rR8n9HCC5h3j1PfTW5DeSM8M
 qllC8pfzeAb1vto0yX/eEFl850wZtmfOsCiPjSl2zLrlB2u5dM86t/fEC3pj4ZK9
 ivAyQrmqNSiyidfjBFPd8Obj01U5NO+weAdDo/BSsN4UTfUQoCbetSqsLvnEJTJ7
 OVKLf9HD8HEOijrvhacLaS601CCno95hAAmxoUYjCm7Lp1rTJzNTKLHV5SKFhKFn
 i4ekw5QAB5V0mO3dKTbqeY4xhAKdZ3C3ltN+0ok8LoyH0VD281xTxyZrpxXPdCS1
 6LcJEfQUkpJKE1YizMCfoA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhju17fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2025 13:39:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 516CDnTQ023083; Thu, 6 Feb 2025 13:39:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8eagdnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2025 13:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP/iqFnvhtn7VYt0416o+nyA1svW4qQ1e9RYTucgHBsRg5VXLBYnXN9lPJr2tBEGolf8k8dDcM2YKyku6nzbqTgAjJ7ElJeZNtfr7Tw188zy8l9K6DFaqoo8DmxUvx9doZyvEMWjPLg8UKx9Vi6UPIazmpbNPOH7K+aLiS2gpLaAyuT5TZpcNzlY/mt0kUx65oN3k0lFQoEZZX593r5IE46HTrxEygg1gqD0yi61Tql6bYFC/pamTuoKQmp/FpOcSDHaZx+Tu4qfSa9LFPWciQcVT6I0BvNCTamtMvxx1S/tsOD5dltDk+Yyqv+vOm6ODggYfhlcU1xoHyBOuEV++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5cej1AJlFZc/BaLsFc4o5Avxosj/h0XKA6oVIPPFSU=;
 b=MUr8kBRYBc6++VKi0kRnCxgxATWFKSQ0Fo0cOUNbqwcTbudpCJXBD9tyciez8H54H8jMiCP/iXxosC5HiJd72/7jBbDoizoHe75EtsFPPZ160Xgq0OR2WnN7hCBu6CzDp6Zwney0BlfxFGaYL4o9QNaD1wqxzaPeKZJGjmAvqSeVY+vmIF3QqwZZp+ubIfVUMTACaOyX13jwL/GaBPFNuXmvcjLW2Pep+HdoFV57gW+LSA/LUF/txyS2nq3SQ4Ppo2DrpzxMdIBctFL+XxxoTEvCxY06q1iSMSiSJVeGhVkAN+CdLy5Yf0M5FiIkWtYKBBtG1A2w4mbdh+xhx8QcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5cej1AJlFZc/BaLsFc4o5Avxosj/h0XKA6oVIPPFSU=;
 b=VvAnBlAgJSSgfnujCSF7DLrTMnHaeXGQtQZoTrzuH+SdnL3ze3bGdu3fqSKMe75z52AAT9ORyf8UvwQGpxQqWahueTESF2jN4sNNspw0pxh+XNaUBfr44JObE+jfQ3byT4Kpu10G6oUCfR+cL3Iaa3uR8zanO8k/mVGCg0CDdYU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CYXPR10MB7951.namprd10.prod.outlook.com (2603:10b6:930:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 13:39:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 13:39:52 +0000
Message-ID: <6df65afa-b46c-4128-a634-c56f9368827a@oracle.com>
Date: Thu, 6 Feb 2025 08:39:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 02/26] migration: lower handler priority
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-3-git-send-email-steven.sistare@oracle.com>
 <Z6D1m_jZ8hb0jBHL@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z6D1m_jZ8hb0jBHL@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:408:142::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CYXPR10MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: c46dd171-1ece-4e8a-b8fc-08dd46b3bb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFdXSjVvVVhIS2JOVzB0My9yM2NVMXlqUWpRM3JhS05qaW1yTlZyQ2txTUxO?=
 =?utf-8?B?di9BdWFiRG1UbWF2YmRTdXpaT3AzSmdPZUZMMldKOGNrVzN4by8wZDlnRXRL?=
 =?utf-8?B?UXlsRmtXSGJxb2h5MWtHNTRTZDlTV1hlVW1JcnMxME5xeVNKZ0NUeWJ5ZEZ3?=
 =?utf-8?B?eGk2V3lZWTRleHBTYklWdHVjR3REQlFFSlg3aksweVBreFpsUXJNK0FpR2Rh?=
 =?utf-8?B?QlArbkVNUDFVTmxPZTcwSHZGMkovR3pTc2RGRW91V0xkTE1ITkFLbjJRaEpZ?=
 =?utf-8?B?MGVCL2lYUXNGcFQwczVNcWdkNDFKRk9PcGlxL1RWRDF5ZGlENGEvUThpbzNK?=
 =?utf-8?B?Um5Hb25oYUNQd29UVmxYb2lZNTg1UUlRNWZkNU5HS1RJbWxlRS9LQmVyQUF6?=
 =?utf-8?B?L0pDRGdlSWlsV1Y1L0tqU3hFRmF1Y1I0SFh3YVFteFFGQkUrV1k1SDhUWnhC?=
 =?utf-8?B?NFkzd3NYWXYvamdjM0JSN2ZvMEdwRC83ZzA4WE15U2ZWVXgvcFU2OUxKQzFq?=
 =?utf-8?B?VFBFVW5idk5JMDRzbGoxYWZ2Vy9TU0pRK0sxZ0tsdjlhL0JlSHN6ZnNBQnJY?=
 =?utf-8?B?dE9rRWRDR2wrVEpzaXFkM1pESnZ4ZzRVNnM4bmpDN0tDYjZ1bHM1VU5vTDBP?=
 =?utf-8?B?L0tpQUdrRDNhYU9YODRqdHZvODRRMnFCQ2tyQVZZd1YzYkxIcU11cW5IcUF6?=
 =?utf-8?B?YU80S2FyTlh5aU9QSlMzc1JWZi9rRGxFME00bDRoTTc0cSs3bmxoN3BPOW9G?=
 =?utf-8?B?YjFVVGFPQlhXVlNBMjhPSFppdmo0KzhsNTZoVDBQL1hrU0RlRHNxSlZwSUQy?=
 =?utf-8?B?ZU9xY1V1WVlRQXlJaDNYU1lVWWtyUEhQY05FalMxeVJpVDdZS1RVMFlTMzU2?=
 =?utf-8?B?NStQeVArd1dxcGJCR05nZExTZHdiQXJzQnZqYndZVHpwaVFjYTRzQU5NUHJF?=
 =?utf-8?B?Qk90RmltZFJKYTNTSkVobDBKNDFYMVQwVTV3TlBWc1p6M3k0dlpwSVlPanpB?=
 =?utf-8?B?ZEdLR2Q0SkZTWG1DNlpWU0x1b01MRllFU1V4RDdQY0ZXelB2K3lnS0RoRXJ4?=
 =?utf-8?B?NndCNzJFa1Y5cUU0NGpacVd1Yk1hdmNpa1hKZk12TGFqK2lVc0pvNnI1MGx1?=
 =?utf-8?B?Y0JGNjhabHpvZWU1ZW1rOW13OUdGUXMxVTh3YmFOTlJGem1icTMveHdIbUFw?=
 =?utf-8?B?L3hRdDFaZkplY09yaUluVXFNMS93SmNjdHhxUG4yNUh1MXVtL3dPeGJ5Qlpj?=
 =?utf-8?B?RURyaUpBMnVoTEJVNUNCUVp4N2JpL1VBc1ljbURwKzBuQTZKdmlJdlNuZTFo?=
 =?utf-8?B?YW5oYU9lemlpTHJsS1dtVkFORWdJQ1lyQTVDbWg1ZS9pY3dSSGgyMU4zV3Rh?=
 =?utf-8?B?eFU5MnBFa1ptdERvWjB4TGw4ZE9Bdk1McHFwaG1pajZGeFY4Y3Z4Zis1dFQx?=
 =?utf-8?B?RGd1VDVyN3dpWkV2aEtFMlAzNDF3d3lRWEdxQnJDNy80RFFMUmhla2R4NVdq?=
 =?utf-8?B?M2I2TE96TkRhM1FkV2RqVWxTcTZMQkx4ZVZRSWVlcnNrdFNxc3BXbzNpUklj?=
 =?utf-8?B?dXlXaWFEN1IzRlRvNlN0NGpqcGdNVW5SeFd0aEExRUg2cU5wRWhST3cvNlFx?=
 =?utf-8?B?TkRnUGhHUzMrYW95K251Z3lGa21rNGNrOS9yNFRNa3ZSOHp1RVhtcXlGZUpW?=
 =?utf-8?B?dmFVZTVEbHQvdDh4YUxBT1JNdGRheW84Vnc1OWVGNEhiR1hDK2hNY3lyNVlD?=
 =?utf-8?B?eSt5L3IrbkgrbXpVUzFyTWdvK1pMNmdheWhjekJ3aFp0MlFVOEtOS0NvZTNK?=
 =?utf-8?B?bm1BZTNOM1FrazN5ZjdVaWQvaW9ZM1hURFUxUnhwaDFXUHd5cGJRUEJPQVNN?=
 =?utf-8?Q?r9cW+sNXE3LoL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBiVUdjbEJtWXQxV2R1UUVWOTRpSUZ3Z3R4dFphRytNMDA2Sms3dCtVV0ZQ?=
 =?utf-8?B?Mld3a1BrSFQ2OWNXQjc2ZHR4VE1UQ0hhbHM5SVlSaVZkZ25QOGZ4T0xYbEQ3?=
 =?utf-8?B?Zk5teWNmaUswRFRHS0drUjl2OWxiUTlzOHpxVHg1TitWbmtnOExPQmJ4cmpJ?=
 =?utf-8?B?NW8zMlZwUUJHQlp5c3VDUkg5YmZnQzdCemc2M3lSSU50cHFDNVBFVDVFSjNL?=
 =?utf-8?B?SXBKZmtpWTJpS1dJRHdjakN4SFg4MmhDc29sWVZMYXFab2dWSXpOTFJtQTlv?=
 =?utf-8?B?VDFjdGNyK2IyUzRocVZTY29qemEvYWxvcjNEeUg3a2lkd1BGVGV1WXo2aUhu?=
 =?utf-8?B?RWROdFlMMWRjaHlLOHU5d1p1aERVR1IrbzRpWTU0ZGlUNktabVNEQWpabkhN?=
 =?utf-8?B?RmZLQjNEbi9MT3Q2R0EyM3E3eEsxbmUwRlhJVUwwcThIUWJJdFI2TlV4ZTFk?=
 =?utf-8?B?Qm45a3QxQWVQRGZnRVBwNzcxQW45V1VnMWhBMy8xaDZBcXRjOUtpUU1HckU5?=
 =?utf-8?B?UDdPUTJkdGp2RUpYY2FHa2t6NkxJMG9hZHB0Ylh4dHhxQll5dUlRNUVRd1dM?=
 =?utf-8?B?dks3UUZqNTZTaGZaYXh0ZWtYRjBUS2E3V0lTR3JIblVtVlJSYmEwRnJKNWNx?=
 =?utf-8?B?TWpvK2ZMcFFQU1ZOM0VRdFI3Y1Q0Q3pSZWZ1ei9UdlNGbG80cmVzdkkzb2U4?=
 =?utf-8?B?VGtVSnVqdXdmUm9LeUp3SnllNERYTXBwOUt6R3hWbWRvRjE4SWVRbWdLWUlu?=
 =?utf-8?B?RnZMaHJubm9YS3RTR1JRdzZPVUZia1NBY3dlbm41YXFQTlZUUE9GQWFlbXJh?=
 =?utf-8?B?RWlOOFZNUTdNVlloajBhQm5Gci9wRmd1UldkMksvL2Z3QmpMbGxGOXdKMjN3?=
 =?utf-8?B?Y2MwQlczb1c3SlJCMll2OSt1azZaTEg3dCtYWVRucDdFQ1RUUElCYW9TeFZi?=
 =?utf-8?B?bVJNZDJNU1JwKzJ5KzFIYWlkbFFEWTdOZDJYZDE1L2J6Rkt0Y1BJVkd0K3BT?=
 =?utf-8?B?WGNvVXRxenorMUFhTWNEYmpmajU5bjhHc3Q4QzFvQkdVT3J2eEJYS1RpdXN5?=
 =?utf-8?B?aUJ6Ni9qVnc1R2RFRzVycnYxRTl5ZEdWRFhSWnl0T2VJRmx2MVd5S1czVUhx?=
 =?utf-8?B?QzdBaUp6SDZXdThCU0ptZ3d2WE84RjM3V0hGK29YTWJXZktYaFl1WHUyVjZP?=
 =?utf-8?B?cTNsWGppcUdQbjBnOUhtQWUrc0FXTmU5NTV1dEJhUW1PREFPcko3WjFlMlVr?=
 =?utf-8?B?MnhaNzQ5SUt6bUV2TlZxS1A0S2FWMGZNWDB3NFJFcmVmS1NGbFBZSXBFOUJ4?=
 =?utf-8?B?RGFLNGt1TFFtTWkvZDU3cTZ3bEJ5R0FKNUUzYktLTzlwTk1xbDBpbmtRZVlo?=
 =?utf-8?B?bnhIUjFoc2RtRU9halhoVFZKTjdKVS9aL0crelJEeGJNOTRDT1dscURsR09u?=
 =?utf-8?B?aHZTV2kvOHl2SU81VVYrSkVoT2RSb1o2cGlRSmRJVktZc2pucVZjd0Rrc1pw?=
 =?utf-8?B?c1VFK3BFZ3VLVmFTTU5IYlN1WVUxajFtNnM0alh4dkZ3NHU2U3hJbnBKTmdG?=
 =?utf-8?B?OXd6UVVobTJXVkZhNnhhS0pqaXJkb1V3a1BGWTFmRXpySXZTNHJhZFNkVUsz?=
 =?utf-8?B?aSs4aHNuU3JGbHN6TFppUlV2dS9GRVNnMWpxZ2pyRSs2cEkxOHk2SFlxUmtZ?=
 =?utf-8?B?a0FVMWorT0VJV2Nra24zTW43SjdwOCt1Q0lseGdRL0NyQTBJcXN4UEZQQVBR?=
 =?utf-8?B?Uk1hUlplNGRHa0pGUmxyRVN0cUZBZnhLUTRHbzdqelRuMGpjSFRaZEhmMjhV?=
 =?utf-8?B?OEdtNlVha2V5QmR4TWdDNnlSYm15QTRDV25TOUR1OC9LUlFiMWpzWXRXQzRH?=
 =?utf-8?B?WTZtdHBnUEpadEJkbUNwL085aDVocS9pSW9CQ09pVnhKRFFrMTBaWVkvU05B?=
 =?utf-8?B?bDRaeVJJT2xQVUYvNjVXdUJiZzgrT0N4c1JqSk44RU1OaFE5VlRwOUtmajY1?=
 =?utf-8?B?bUZaNFBTYWxJUVpMZDZadmE1UFNtUzJZZU9NdVl2ZlluRFVZVWVSY0ZPeEZS?=
 =?utf-8?B?UTV6cnJ6Z1BENjl1eE15YmRRR215QlJhbG8rZlZnNG1kWW9vMDh6Qi9QRkxz?=
 =?utf-8?B?dGlnSlZreXNEbG9xb2JBdUpRR2poMmkzQ1BqTS92YWNMK3UxSEdIWTIzTXVM?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j/YIpOp0OhpCA0/4ubI43OaaEWsWxpfefpD8TnwdRiDrYI1wg0aIysEcCC5g3fps4ynXI2JjfBzvofshrrN7Uo/YA8Bsk09UnHoBubXGp2hosjibI3/KEjW3rsxaKy9ziPTRM0E51rxICM6hn69Ltq+593PWmGpb8Mq0nb7gHmxadwLkwCK9P1NVITeu7hpPREBczaY+2v1jbt/Cl9zu1YoagrbToNPzWCEU5MC21LxYUlA/Ip7MUviZ6Wg75LbevkoLzLpwWql/499I0wB7VsYhsauIiHwoW+A2FmhPMJGRyCEp3tiTnRdRstjHCllGzXBJ6CZWQI6HGhD5an1nf1qKu6CU7yelrVfP7/TY4mcJbQrUCg3WFaIlEcwJ5/WJWlDXosjcDsIT7wqRdS6vLuexO9/8IVsnTTH3gU78zbAgitglW90Ng4FHFMFPKjBO9z4zyl9V66qlUmMECq/pRIXW5O1sZqTojYV6yMwhvcu9EPucboRiTlz7AUkCHKG5+T0WesKTqISHov89MkfnMf+ZPxixubzcEM7lfvVqzrRTbKDd+xEwQCo+4LV8jcbEtXrkA17IJ3vJBoHjdROSGV6Y003l5AAA1AbeWM9E43o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46dd171-1ece-4e8a-b8fc-08dd46b3bb99
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:39:51.8779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZYzZMZb4cBCWvjHgiX9hv/DdjnqCq6elFV82GH36vhCNhN0INKjAGNhactaOhvfxhQn3f2gu2sjEDggWSCT3uTs9m4TAmzHPAlQpUYKZ6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502060112
X-Proofpoint-GUID: dMJXS4-O5esfnttMeJFkrk5o1YnZb8p-
X-Proofpoint-ORIG-GUID: dMJXS4-O5esfnttMeJFkrk5o1YnZb8p-
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

On 2/3/2025 11:58 AM, Peter Xu wrote:
> On Wed, Jan 29, 2025 at 06:42:58AM -0800, Steve Sistare wrote:
>> Define a vmstate priority that is lower than the default, so its handlers
>> run after all default priority handlers.  Since 0 is no longer the default
>> priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.
>>
>> CPR for vfio will use this to install handlers for containers that run
>> after handlers for the devices that they contain.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/vmstate.h | 3 ++-
>>   migration/savevm.c          | 4 ++--
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index a1dfab4..3055a46 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -155,7 +155,8 @@ enum VMStateFlags {
>>   };
>>   
>>   typedef enum {
>> -    MIG_PRI_DEFAULT = 0,
> 
> Shall we still keep a defintion for 0?  Or at least add a comment link to
> save_state_priority() - it might be helpful for whoever jumps to this enum
> defintion when reading.. and get confused how a default value is non-zero.
> 
> Or define it as something like:
> 
>         MIG_PRI_UNINITIALIZED = 0,  /* Most devices don't set a priority, it will
>                                      * be routed to MIG_PRI_DEFAULT */

Sure, I'll add MIG_PRI_UNINITIALIZED.

- Steve

>> +    MIG_PRI_LOW = 1,            /* Must happen after default */
>> +    MIG_PRI_DEFAULT,
>>       MIG_PRI_IOMMU,              /* Must happen before PCI devices */
>>       MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
>>       MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 264bc06..5dd2dc4 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -232,7 +232,7 @@ typedef struct SaveState {
>>   
>>   static SaveState savevm_state = {
>>       .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
>> -    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
>> +    .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
>>       .global_section_id = 0,
>>   };
>>   
>> @@ -704,7 +704,7 @@ static int calculate_compat_instance_id(const char *idstr)
>>   
>>   static inline MigrationPriority save_state_priority(SaveStateEntry *se)
>>   {
>> -    if (se->vmsd) {
>> +    if (se->vmsd && se->vmsd->priority) {
>>           return se->vmsd->priority;
>>       }
>>       return MIG_PRI_DEFAULT;
>> -- 
>> 1.8.3.1
>>
> 


