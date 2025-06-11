Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24548C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKaF-0004Qg-3T; Wed, 11 Jun 2025 08:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPKZw-0004Nn-F0
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:29:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPKZt-0000NN-Hz
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:29:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCPpTj028193;
 Wed, 11 Jun 2025 12:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=omW48+IP4SJ1qRWQC0l2bFeuvNITIjjfsb0pMXJUUsw=; b=
 dlfRh6cVRlYm+hwwY3NPwlggMFVfx9EzP2ucY9kkY8LX3hGJNyJrOHyMIflNVkd2
 jUk7oYH8heot2gHN5yaRp6JXZRtPxr5RpYd5m5IGlwu7WCRf/RyIV/cxGS0uNRTA
 pxy5PZhEfKEU3qU6oBQFUf7yf4Jk1oBI8THJjCxZ/Bx2TWX7tB9md/HRj52W9jb1
 xdxlWO/UEVjhPXjJxvawjY6KGIzCQRTF00drSMtAfJFe0TTgAPFFe0ek4Q/NtDxe
 Oy69XDRCWwc6gRvD46lrsmsEI0021lTgV+cIJvDkWBbsnGlV4jMFrMDFWRUA5qZq
 xhlqWh9NCAaDEqERmQUaDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14ea87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 12:29:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55BAoKQT003338; Wed, 11 Jun 2025 12:29:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bva3re0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 12:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfP6/LWk9u0h/NJzys3afpMQQCh/W96UUEgO/f1GGrrKP5PYv1rOryGoXfY9EDesq3OL2c1WbgbSDxIoilwtJnDxs8c6OJQuRiu2MB8vYo/4jI5oeKWKvPbB7Ev1AcCOeHq/X3VDQ94k5k185D5HX11kicw8nvL6aX5ygmK1HiqequAf09SQWat356YFZEGYA2woKbs5N0+foW8Dk2Po2X2fY9yiLzsCR5xEqh4uDS8O49zI6u9E6PCcSjdZ3zexNAlCUB20OB9JYolXfjkZHTDdFy23UpMAnJUt8OUggD4ooFbpHSD1DIjAMGN38GuQ3VjmvDlJ8Y9MB1EnWF3YzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omW48+IP4SJ1qRWQC0l2bFeuvNITIjjfsb0pMXJUUsw=;
 b=MRCkIJ/UWM5nTUDMao+1QxYsAH37YVR13N/nfoN1o+Vd0dhIzMikm5yi+dbV3c8iWsnyvoG9qpvHXR9x8HwPR2uVaD9MM6YZhfojeaWx/EtkZIU+I8zjN5yskKzCIYvbxsUolFXwk6snc0KGavCOVeeHK32HXIoUDUVs5IZOLgAcETLwkNLoWdaIPQdnqse2fw+fXsxFxgqBa6OOs7Au0n3TOLrm7BUscf30n5ss1b3YunojtvAe1nCVe0bQD8ccFm05XY6CA61xNPziJ2mfMbD7cBnzyU+QAdK6YfuEhWAoOk0v2iXEwSJ4Uw/FZ1G0ULwedCMYwIKK74wbrBBLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omW48+IP4SJ1qRWQC0l2bFeuvNITIjjfsb0pMXJUUsw=;
 b=pJDG2MYJwdnsPahIHcQbt7ryo9yo/uKJicK5x29LUPcj1JF8okcwyCoE7GGvuu2J8L8u6A6lisvV/auEWuEUJLVLSOv3+hR9DlGnY2Ye6D6Aktnuxlfy/k5BKHYMsOed/7yklVLfLMg8mb2Ya6J5sq0cJ5jRxKjZd2b2Ei3B7hE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 12:29:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 12:29:02 +0000
Message-ID: <d9deb49b-dce4-4cbc-bc7d-53a781e20977@oracle.com>
Date: Wed, 11 Jun 2025 08:28:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] migration: Support fd-based socket address in
 cpr_transfer_input
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20250610223342.553744-1-jhkim@linux.ibm.com>
 <20250610223342.553744-2-jhkim@linux.ibm.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250610223342.553744-2-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: e92494b7-7247-4d34-5592-08dda8e38c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sjh2TVZxaDFWa2diWG1MdDl0RHVNWmJaaXRGZHR1dWpzOUhvb3Y3MlU1UXJE?=
 =?utf-8?B?TElEdUZXZ3dsZ2ZFTWxFcHRac2x6NVBSZE9Ub1dKV1RWaHVBNzlhY0xpZ3JY?=
 =?utf-8?B?cjQ1aUJoWHJqdVhBanowaUxaQ0xNN3JvalBVU1Era09PeDNiYTZ0VGFKQmYz?=
 =?utf-8?B?M0VYRFhiNkZaRzIxQy94Z2hNaVBzL0VFSVl1b0xHRXNGR3ZpSnpBcy9jcTRX?=
 =?utf-8?B?S2JaR0xFQnFWMTludStNRHUwK2xzRGF1c1paUjROaEt6M0pOV3k0Yi9CWTN1?=
 =?utf-8?B?QjNVdCs3TVJNNkVNTWNaWWhENkJlTTVmSjJWV0YyZEE3T2V2MnY1eHp4WHNF?=
 =?utf-8?B?YmdyUHNaNnpZaUpDSzk0ZTlnK3RwVGZXZ0Znd2lMUDE5UVlXNGhPT3BCdmVI?=
 =?utf-8?B?OHdick1wWkpKOUI5dUdlQUtCZGxLZEY5RDk3UFlYN3BMZHl1dnBiTzJCdmxp?=
 =?utf-8?B?MllBVEtrb1JXRmpTT2I2c0NGTEJSQ056allva0lHL3hnYWFTUWdZUDE0Vk5Y?=
 =?utf-8?B?V3ZTQUhqN1JBT21GdmVuVWRtdkx0QmNJYjdWWlJzdkpYbzFwRG05VFRCQ0J5?=
 =?utf-8?B?MXpiYnFCdVF2ZzVqNk5EMzM5TU50Z3dENXJFR0lldTBHdmhrRGRJTTY3RVRJ?=
 =?utf-8?B?M0dyNE44RXVhOGdRaUx0dHpWbHo2bjkwTG00WWpPUld3Smw0WDZLZWc3ZENF?=
 =?utf-8?B?allob1dIZ3VtYUx5VGd1VmI2VG8vM0lHQ2JvWFdydW5STzR3N1YyZmlvdFVI?=
 =?utf-8?B?Q2tUS0hmVWd1NjBkdUxKN2QrUEJQTG1HcTRueTB1L3Z5ZUtzUUc3cE0waUto?=
 =?utf-8?B?THhZbEJEZ0Ywb3Nsdk5rMzVjUHhtNmdPUEFmMDNMRmNlSlI3RmU5K0lPWW0x?=
 =?utf-8?B?d3NHdlpQZ3pvcmsxUzRlbktta0NQMkx2MTAxVEF2bkc0WkZIcG1OeU5Jdysw?=
 =?utf-8?B?WTZpNFppUSt5MzcvVHIvR3JDT1NlYkw2a2xCMXBGa2ZrR3R0eERFQk1FMmt0?=
 =?utf-8?B?NlhGNFpBcndOV3V4cnJSSEU0T2hhN2JjMjR0Ym1JT0tieUlMTTEvc3hGQThT?=
 =?utf-8?B?aGxmMEVSd0w0ZGdxNXpFU0Fnbm9ycDZJTGVaQXRzR1BhbkNPMm91dlJUbmFp?=
 =?utf-8?B?bURMbjNtKzRXSWJYK3AvTHhQUkxhRXg3U2sreUtqUEQxdm5sMk8vNEVaa1R2?=
 =?utf-8?B?S0RPb2VxR0dKR1QrV0lVektrTzF0L1EvVVpnZWJEanZEZk01V3dtUXV3T29R?=
 =?utf-8?B?b0lQUEpYYUlaNWxZdklCOHIvOG02Vm1DSklOUjczcW1LOW9Oell1bnpDcEtq?=
 =?utf-8?B?S0VZSUpkRldxUi9sR2FobUMzL0JPbDdVb2dRZzhVUWgzY1hPTlNLbm11R2tm?=
 =?utf-8?B?Z0hZWkdKdk03M215UUlTTldIOGM4VjNaN25HUFM5a1pUT0tTOGZPMmtOK2JB?=
 =?utf-8?B?ZHNTT0p1SGNGK2FOdnhJeWxxUlJ0d2Iwc0lRN2NIS3RkeUI0SGNoN2RUVzBT?=
 =?utf-8?B?eFlMMGhHME9WcG1BT0dEUE1SZk96YksrejR0SW92ck1HV2Jia3JpdDBpODVE?=
 =?utf-8?B?MkFIQ1hqeVI2OGNvK0NvazZnS0JjamdYRFJJS0I5dnhHVzlzMlNmV2RzOWZv?=
 =?utf-8?B?NG4zeFpldXBWK3M1NE8xUjJiekErNEtUeUJLekFoOEloWERCaHJDeWN5K2Nj?=
 =?utf-8?B?dkVXUUZSRC96dE91T0VJd01zNjViSHZCcTJpYjh3NGZraithVE4xVGRuL0JY?=
 =?utf-8?B?Z0ZjTjg3ZVV6ZXA4U1N5eHJ1WlJVN3cyMUNtNkg5NnJMV1BuV1JoeWVPUEQ0?=
 =?utf-8?B?TEJPL3M4ZEJ5cmVMTi9Tby9YTUFRVjNqQVdCS0hySHF1bVRRbGtUVEQxYnk1?=
 =?utf-8?B?ZTJGNWxOYytNdUZ0MmVRcFZxcVh5ajN2SnZjT1V5bitXMHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni95dzhneGhqWm5rb3JMQnYybURIbEE3bGFSbmhOdTUvWk9HYWM0aFhIQWZj?=
 =?utf-8?B?OGhhZExUUTR1K0tiYWlqVDNPc0NBU3pQRHgzT1Q0MzVVL3kzV0FOZDk1b20r?=
 =?utf-8?B?N0FLejMxK2lRekViUnVFeEFpL3F3ZVZlU0VsMHhXM0d6Njk5SzdOclE1RkZC?=
 =?utf-8?B?RzBuY2gzWXNLaFk1SDNpVG9wQzcwZEdLV1JzelphenBvUGNraThmbHNyc3BR?=
 =?utf-8?B?VmxHaDgxcmVoc01IWTNRcnRtTDlNaUlJdG5wbGRKcnVjUFRwckFmY25Nc2dK?=
 =?utf-8?B?a1JaZllzZXdxaUZkN3JZdkhJYnJaV001RU9qdUYrUGFIYmsvY0hqc28xV2Vy?=
 =?utf-8?B?Y2dCZXJ3RjBxMDE1RjVXWXBKMTNBSHBzU3BJVjA3ajFXSlJxc21pK0pIRTRr?=
 =?utf-8?B?d2p4OERFekdBZmJzeTM3bmhPMk1KUzJ2eHo0ZmltcTRrTXE3dXJGdlZuMmFT?=
 =?utf-8?B?ZlpXeDY1TGF1cFVNRVgzTnJIZjh2bVFuUGFDR0RtYnE2NG0zc1VlWXkwVUk3?=
 =?utf-8?B?OGJWQVUxa295a1lyYTNTMVBmVlUrV0ZGdHpmcUJaWVFzOE9LUnhsM24yaENo?=
 =?utf-8?B?L2gzak9xUDdIUHJySUNkTm1XZ2tlZTNDc3d5Z2FzTWpSRUczY1Z6N3lDZFdj?=
 =?utf-8?B?ME9PZnUrZEN3K0tYemYxUjJSUXpRNlJDbmlQQWR3c2QxdFpsOUR4aVgxSnZu?=
 =?utf-8?B?ZGozQ2dZNDhHd091cDBPNWpHNUVQaTl5WW9SWDB6RFFFemxyQ2JObDc4Mm5D?=
 =?utf-8?B?WVhNVUhqQkx3MFF2ZU5rVTVLQVpwVG1mNGJGNmVmRGlUYjRRSFk3VncwdEtw?=
 =?utf-8?B?SGJiY1hIREdqN1hLV210OTdwcGZTQkpycEtaSTJncU9yZ0FrUThoakpwMXl2?=
 =?utf-8?B?UmYwekJJT25pcXk3bkw4U2MrcFRuVCtjcVhhcktscnN4L3pBZ1J4M0tGWGNa?=
 =?utf-8?B?bERqUEw1RFd5OUt2b09JVEJWWHlzU0N5NmRCKzBxNzhoMTlnQlNjd2FGeVRw?=
 =?utf-8?B?dmtJK2hTM3V5bGFyK1Z6YjFqNzVodDd5S1VCSER1T3FuRU1Cbys1UURFYXpa?=
 =?utf-8?B?VjV6TEFXYUVCUjJscnB2Yy9HUEoxdGdjckpDZTRUdDFoeWduTFdiNUc4MDFS?=
 =?utf-8?B?aC9jbUE4L05UZ0dYNGo2NWtjeVFYWkxOazYrUThzVnZBODN4TERSUzcrb2ta?=
 =?utf-8?B?bzFhS09yNHlMTWtkQXVlOTd0cmlnUitBY28vV0RyOVdjWmVnVWtwRUxRZWtO?=
 =?utf-8?B?Uk9pV05KeEp1ZVFzcnJ2R2l6a1pXejcvU0RNWGlNRGY2SjNwMTVYRUNoenR1?=
 =?utf-8?B?VFFHN3YvRXdnS3VVZFUweElVRThHOG1wNWx2NysyQVJwU3dNK3ZwQnZpbjgv?=
 =?utf-8?B?VE1NamcyOHRuTy9tVCtVWlBrWjA0U1FkaVduR0lzTHBvek1GM3cxM3BsUmdv?=
 =?utf-8?B?bWlZNGhHUENNVjMrYjVQWGxFaGViemc0QTAzVWFMOWEzWklncFVnRXVnN3Bn?=
 =?utf-8?B?QW1SSTZzSThTMmVSRmxQMU0wNkkrUTNMZzJoT0pIZmNlVzIrVS9XUXJnMUYz?=
 =?utf-8?B?K1pWTllRYjB1SFlqNHFsL0EzSEdwREZCbnBMaU9lSFZDYjNsbjRnYXQweVJa?=
 =?utf-8?B?a3JYSGtYU0dWRFRhYXJrT0pvRmJNdFBocFNSU01lMVhrMzZTWUJuZkI1Wmx5?=
 =?utf-8?B?YWdnTHlpaUlWYVNpVTVzYm1FZ2d6TkQyQ25WbnRETi9vUnlOQXQ3Sjd6SklU?=
 =?utf-8?B?S1NESGJpYmZHL2E5cWVJdU1rMm5yaERhU25zTUNCMXVoTm1seUVzZlQ4eFZ6?=
 =?utf-8?B?bFJkVDZkOGcxMXdnSDAxaHF5dURmNDFiOTVWdGhhM3hVV0tUb3puc3NOSE4w?=
 =?utf-8?B?YmVnUHFWN1J6VU9oVTN1SklqMHpZNHJIWWhYbXJWUDNQQ05pMzh1RE5qOXZX?=
 =?utf-8?B?UXl5NWxvUnBsVDV3aWFLUWRWN2M2OXJFZjZlNnBzQ2xhRmxNV3lqV3Npcyth?=
 =?utf-8?B?ZjI3eTNSVXZZWk5MNDRLRVRHMkdwMnE5enVWWUZFaUl1YVR3SHJQR0FPMld2?=
 =?utf-8?B?VFJBV1NtSTFjd1daSmcxQ3poclc3YWJDaHVhU2xKcnZyR0pqelNvbDJ4Y0F6?=
 =?utf-8?B?R2tuVndjaWc0MUdOK01IQnlDZ0lZcGtpMFZ5dGwrTXFFdEFVb0d4WHlSRHFx?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Ded8eoHtavpioafFxOUlRVYRW9VT3y3KJf3rSWHXXtAgkPT5PHSCQgCNrx/WneGbS8BzcbEeWy3eycobN47VH+QlfvEIg0NuoNpwe6IGDr1Lh5gCR/F+yM4MX1yU6p0wBbON3UjwgiBGlAkQXLsce6e6jlWBIgWFW5ZbBM4geWPSJb2DHMVdM/X9mDy+FZ6BjhY2xq1nz7Ye9+zPEQw38HiOzfKCvg1hMVo6fqh5J3dMxE+sglYNMlV9SIsn/UUi4F6iEDpTOdqorFbDM+uaPqDSZ6UjJCVZVfeSs4OgZ2P2lr8f1uswfaRFHkPBFar0OijgFcPYwfKREfLiWe4FqTKZ25ZhAimjW0aqROdOrqXVyUB5e5XRJf20KEwSVy73xYks2vBQxeenXfFzoG+1b+yGy1qiPG0OU2viZG2l3fFgurNeUsJDyNddW3ZjtBsQ13SSPODvwZ+yxGxT4PAcpGtj54bQVZ/eolHVSKOgUJjpzkYk/4qa3meBcjtPdn4X6zDk+GzMxWTkFS+RhnKuP10arZbWGlj61ndAFQctJNuG5V2l/UX0b35J5tbnzvwlk+Gy8+YZgoGB1BnF2m7Ww6my5QB8NH4sjG0TArEGEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92494b7-7247-4d34-5592-08dda8e38c55
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:29:02.3794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDQv/97iefhnPF3j+wyxWK5/iA+kaG9bdGsHYo1Sb9jWtkSqOaq6B2bxWW9o/LLrQIRIcItWyFveqBOdAu6TAYqKNSaQ6BffhZCfs019aiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110107
X-Proofpoint-GUID: FOSU2aYnEE-hGECh33Dz4OrQVahSXW_e
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68497694 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=cj7v5CIz3I-7UmU702MA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwNyBTYWx0ZWRfX+lEJOUH3zlJ9
 Kf73VlwN2TWoCHakScXvl5yN1LVQw6YSP9hxMVg72DTFnKT6bynVajX+VQnFIbCQylLCGKjM7Ns
 1Xaj4si+ksxSyEilJDsYeUQAqV+fPPf8cuzgrfqynOzLeUnPVW/nAuaiPuo7MwQiR4vsvFxw7rW
 xjUT41Mnxy2e/ZigOqVur9rb6iUiXK01JMpNKQqiojhOS9p3t67PC/kdgewXA3MtS/LMEXHRHsL
 YBSD34kr3wuOA5qPezEmzd7bR07/Y45i09uLAfNaMv6zQiVYsS11+xDiPCUsNurU9/Gv/5tixFQ
 BFHoZ6sgqBnYcxNQHzPYQJt4zCQms6F3CJTlL8lg7c/qvqsfB56h5HsLENQg7cRUioTrmm6cJqC
 +buvBnr6NLHP0f1ziVJ964XzeirXFGNrlFMqz11YXe1ulSOIRda/6RoteRrMiEdsY2y20rCP
X-Proofpoint-ORIG-GUID: FOSU2aYnEE-hGECh33Dz4OrQVahSXW_e
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/10/2025 6:33 PM, Jaehoon Kim wrote:
> Extend cpr_transfer_input to handle SOCKET_ADDRESS_TYPE_FD alongside
> SOCKET_ADDRESS_TYPE_UNIX. This change supports the use of pre-listened
> socket file descriptors for cpr migration channels.
> 
> This change is particularly useful in qtest environments, where the
> socket may be created externally and passed via fd.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>   migration/cpr-transfer.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f140359c..00371d17c3 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>       MigrationAddress *addr = channel->addr;
>   
>       if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> -        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
> +        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
>   
>           g_autoptr(QIOChannelSocket) sioc = NULL;
>           SocketAddress *saddr = &addr->u.socket;
> @@ -60,7 +61,9 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>   
>           sioc = qio_net_listener_wait_client(listener);
>           ioc = QIO_CHANNEL(sioc);
> -        trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
> +        trace_cpr_transfer_input(
> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ?
> +            addr->u.socket.u.q_unix.path : addr->u.socket.u.fd.str);
>           qio_channel_set_name(ioc, "cpr-in");
>           return qemu_file_new_input(ioc);


Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

