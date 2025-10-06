Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EBCCCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 16:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nhN-00046r-CV; Mon, 06 Oct 2025 12:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v5nhD-00042Y-Uk
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:04:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v5nh6-0002I3-TX
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:04:19 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Fu5bO015561;
 Mon, 6 Oct 2025 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=1YVCfjsFQJcGLJpf6ZKlWb51siYkmMMAoCLkEZ4JUas=; b=
 dXyJ0TVhFAroFYrEw3rmTpVGG9mfhUUq+Lkx5zMbNI/2FWCMvW+DE90Au1AxD46e
 o+xFhEyB6CAzixDyViXJvZo3ohdjCIRsaSNatzWAhI1qtbP4Oi1U57tnd3xfqLb5
 WxaUkt8GxUx26YHaBu92THSerbhGonChi9FGmFh4uLAs3ibOvx7K7lL/uUXGpQ0o
 dbN8/1NVwu0avyTvm5vCoYTq3ue6G+gzTz0n4DmXNPYzQXpgVd+gM064+NsG7can
 6OAogPDwE3iW6ro3adntpQSVG79iXJdpDPg7tFcznvr5fqjImq1d9ZhgEblOWATM
 wtiqNoPM82ia5iQ8XEpqvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mej2gfb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Oct 2025 16:04:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 596EaEE0022442; Mon, 6 Oct 2025 16:04:00 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49jt179dvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Oct 2025 16:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM6XAGFn/J0aUi5SQpr+FGUHPS3KLCza+n/rXKqo+m/LR5rM7OLdZvLJqsZAWW5qsEHSp4WfizuGlaaCtafHKSLlBHixCCZfOof/8+zu0TUkrXITdVVAIpXIqdO99Ve5bEJJTk1DYPQOQyaXy99IwJFOm4DNREIGm1EGxvjQ32prizVkv7Vg5Q6RpPjpK2UkLMYbXcrYj1kp0Ie69WriRwST/ehD8RvbNLADuLEq+5Fbm86j4lQn6xTjuNPXNCjqA259jcfN7qvcWhZ5vFnYvJZOykhnTAY6az/kAkuHXhRjT+x3Hrda6eqaNqRrS2P6wH17IpOlFgkYeayx9HSAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YVCfjsFQJcGLJpf6ZKlWb51siYkmMMAoCLkEZ4JUas=;
 b=FPaJ1aWHYEzTrb49rwRsyCBxQKRTcZoJ8nBN6bebqxJNfYZppbu/S96aK4fF2Rlnj3T0GMoIMqAA9zsGOiP3IAcd7nvYW9d0QJPP1MkYr/X4sHFRDfw/OXfhJxj0UVIOfkr8drvDGkionDInrUUFcIYN31tSWL7oQgxYBn1hdwL9GB5aHuKogQeBkAuR91JvN2UfpN1iHiuglxzu+Rh2X04WJHHkwciyrwV43sriZDbiZ48untIY5QDLnwgF9+KvVKISWbf1MGtMZhzOvASPALbgztRG5dXkXjHT8QkEPELBVauJi4HY5mlf0NSDPV7yEChBesbAe7T0TJkD3TrqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YVCfjsFQJcGLJpf6ZKlWb51siYkmMMAoCLkEZ4JUas=;
 b=LPzMYRQ2rOY4OLzWooMezSCOF+Hr2EWtoqnmCTgOX4eF6vVoQbIBGrZFz6owxKzfObiCX+UUEJobVWDd+QvVxJl08+X7uqcU6RHJFY6Bx3E0+Za1sPo8S5CI9utlbTbd0qrYXAkXqUW62qUAkNDqqC4s7UOGcUJGmFBlp7O/ZF8=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CO6PR10MB5619.namprd10.prod.outlook.com (2603:10b6:303:14a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:03:51 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:03:51 +0000
Message-ID: <0a4f2e62-ccb3-48f7-b14e-d3c55e992c9d@oracle.com>
Date: Mon, 6 Oct 2025 12:03:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/22] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, clement.mathieu--drif@eviden.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, Ankit.Soni@amd.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
 <4856d645-ad17-4660-8012-3d315e56a463@amd.com>
 <20251006021525-mutt-send-email-mst@kernel.org>
 <37ebf4e6-5127-4e59-a990-905ac3342c3b@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <37ebf4e6-5127-4e59-a990-905ac3342c3b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:408:f9::13) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CO6PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b416f9a-500a-4728-112a-08de04f1f0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rys0akRwWm1scWV0UUtnWmhXM0dwSUVmRWU0N1BBOW1Rci9uSGZVeTlyZHNk?=
 =?utf-8?B?djFSZXpmRVhwVjRJM3JiTjlDVlM0bks5Y2h4VTZmcktGaE13QWRpTGNaMVQ3?=
 =?utf-8?B?cVkyc3Y1QXBoL2dISHNkOUlIdmxmRVM4RktHUlVpVlc3dkFKL0VpRjYyYnI1?=
 =?utf-8?B?RTlEU0tRanJMTUNlVlFLNlczWGpHSEpNdm1JeDBwclNQQ2lIVS94K1RGNXFl?=
 =?utf-8?B?c1lGZ2FSbSsveUJ5cHljTXBlbzFFaVExc1FUQnNQL0o1NVZFVFVmZjRrT1ZF?=
 =?utf-8?B?RTRiY1NvM0tyNGQxOGkyUTIxcHlEcGcrd1hQVkVZVnBKb1FpSDc3c1JMUlVR?=
 =?utf-8?B?ZGwxYWhXZ1RMOE51WThpZVE5UGN6aXlMaXVTc3ZCWHpWWnFEVzhYMXhtaUdv?=
 =?utf-8?B?NzBURHEvSTdDUGRIazgyNmQ3dWFtR01lTzF1MTZwN3FPNjZUV1J1VS9mQmNy?=
 =?utf-8?B?djc5TXoyQnM1enYxTnJDaUdvRVUxL3V5TUlYN1lrRHh4VEhNajU0S2xzczBm?=
 =?utf-8?B?UDF2KzBDMnE4ZlJlcFBwUTFWN2FlR0VhMGRZY2tUS1UwZUNGRU5lNXdzajda?=
 =?utf-8?B?MWFRWmprTzNxZzZteXBoc0R1R0hhN3lueG45NVl4dHV5V3NrMEI3bmhPV2pq?=
 =?utf-8?B?RmRZa2JMTk1oREc0VXo2bUFnQ1djdmVJTHRjQm9MaXBJQmprWVZEeDAwNGh1?=
 =?utf-8?B?dFc1TndQWHRxMUtIbG15NFZFdmpKOVNjVzBwVXd5QVNSRWZmMDE2WGxwRUZw?=
 =?utf-8?B?dWJUMnNqcVR2TjBpNEl3bi9BaXNKRVBZYzJQV0d5cWt3clJIbWlYMkUzVWNp?=
 =?utf-8?B?V3BlUUJCeUk4dExqQi9zVWJqb2MyL01tRWVZSHZNcDVJWUwwSzJTYzIzQWlK?=
 =?utf-8?B?Y1pXT2l6b1JiOEZrbXlUUm5oM29nWExYRElJQktGT3pvTjNIR2tFcnc5eHl0?=
 =?utf-8?B?RU9DOXpBdjlOUDlZSVZtd1JXb1ZIZVZMV2pUOGoxendDV1owbTVScWs0bzZD?=
 =?utf-8?B?OGVZU0NCT1UzZXBRYjJMYnF5c09RdFZ5cDVSQlgycC9RZUJ2QzZ3a1REUHNn?=
 =?utf-8?B?dDlNSS9tckVOUElGQUdPazFQU1d3NmRUYk8vWnNGN2UzTEREek9IdmlTeEJT?=
 =?utf-8?B?dTVZK0txSWs3VVJvNGFUNE9WOWhZT00yNTdSY296cmpQUk41N0J1M2x2Q0hy?=
 =?utf-8?B?bndlUWxLUC96dGFQcks4VzFsMmg5UnF5eS9QMGRRbUJMbmpaakRVTW9ybnNV?=
 =?utf-8?B?Nk9NTk5kNGZ2TlEybVZDZVpHSjJhbCtjTHh3ZEsvYnAvdkxkTDlRcWtxbzZ0?=
 =?utf-8?B?aEphdThkTDgxWmRJcEQwSERrMDRFa2FPbzRlUHJxQXRLeEczOGdqWXp3ZDJa?=
 =?utf-8?B?VE44RVB5N2VPT0VmWVU1QjVoR2xndUV5ZmFCMTc0RjRJVG9iL1FZK1pJTnlq?=
 =?utf-8?B?YXNsc0JKR1NySjg0ZUV3MW5uVFZPYW9kcHJER01hYm41VUw0WW9zTEYvb3pj?=
 =?utf-8?B?bmJISm4wTEg2NGh6dlNyNUUvcUVMT2FuWlFIMThpWDFsenJXc0RneXRBbjI0?=
 =?utf-8?B?NENQTE9IdTJtYlFhWFlTaTBiU2xUTmdTTndvN3p6NFo4bjJDVDRlNGpsL2pq?=
 =?utf-8?B?cHJNaVdVYk5vZktWdjY2c0hWTGpLUDhsZkVXM015WnBocFEvSDlNWjQ3ZEt2?=
 =?utf-8?B?a3lkcEFVSThmcHBiWG9vSGFMNytOMkFGeVJwOEw1dVZDbFdpL3I0dFVnRFdX?=
 =?utf-8?B?Z0o2b2xFWjdzKzl6V2hlUmN4eXovSTU2emlEaGlZa2l5a0V2QVphc0JlcEZD?=
 =?utf-8?B?WS9ETlRCODduNmh5cGkrSWN6c0xYRUQyYWo0dlk2eTJUYjk3dnU0NmN5MmRF?=
 =?utf-8?B?eG0ySVdJcmJWYlNEb0NEOXlxZWtyZ0FFVTd6R3hvOWtzN0c2RDNOVXQ3NFBy?=
 =?utf-8?Q?X0T0PlHD4NyxzG2oMvt75nqwV/HB6Xn0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWc2RkZLU3BHVTFxcndCd2U2aFJWMElLZ0c5dkUxaWhEWjQ0V0tXT0lUakR2?=
 =?utf-8?B?bUM2WDkwYVpwRTBuTXdibnRUL1ZaTnFwNnk5YWtKZ3M2Z21zSzZjOHB3eWwz?=
 =?utf-8?B?dUlVOSs1a0c5RG96VXRNbGZwL0pJOE0vN3YwUFZFZ21pa1pNZlFVMVVkNUhR?=
 =?utf-8?B?NFVMMXVZa1dlV25pS0tZZzFrbWxjL0dQbDJBSkJkbEMxclJRYTN4TS9pSjNy?=
 =?utf-8?B?WS9LY3NNMjFLOUhsVnZ0NGFDa0tXeWptK0pTNTZGOXRNd1Z2T0ROekczWUJs?=
 =?utf-8?B?Qmd3VnhMak9QSmxqRVNhUVVyMHYwSUYvcVZud0JrMUw1WU51TDJPYVFtank0?=
 =?utf-8?B?YVZDWHZKaWxTcGZBSUgxQ2JNREJvYXhEYSsvOFFDYXNIWWUzOFVuY1ZZNjU2?=
 =?utf-8?B?R2o5ZHlCUThDaXF1Ry95bW9kY2c4Ni96OW42S3lkZ2tJQmhyb3BndllUZVBE?=
 =?utf-8?B?S0ZiazhlcTBoeUhxOE41cDN4Qm1PNkw2L0tBdnlkNHh5U2lUa1NOTmRQN2pt?=
 =?utf-8?B?dlFrSWVWNUVxSHNsbmtZOUZmSUN5VkpRTUZFK3dGaUFlMEs3VjErUTc0K0c0?=
 =?utf-8?B?TWRQUU5VUi85YnhneDgvb280RUxWalBjYlE4ODZOSzRFRUhONVppcHQxOTZN?=
 =?utf-8?B?aVR5ZU1XMUZXcTlLRGw4VEdUS01DV0ZGQlA2bVl4KzlqYldDeGZCYjFwSEU0?=
 =?utf-8?B?QWpnOWZ2ZEhqRW5CS0JtaVBMMmhLTVhEeWNSU2s3Wm9vMm9tMTlIaW1QR1d5?=
 =?utf-8?B?U3RRTmFuN3YxQ21NamNHaUFqOEZ0aDR5cnVHMFo1dDNIU2p0UTJ3Qk9iMkt0?=
 =?utf-8?B?QTQ2Nm9oY3IrWjBFR0U4R3EvN3lxa1lDT1hob3VEOFROeUlkWkhrUkg0dFZ2?=
 =?utf-8?B?Z2pwTUc5OVhVYVlvVlUzL2pwaitrcmpmUHZzcFcwRzIzaTFMS1FKS3pzTUp1?=
 =?utf-8?B?M0w3NEgyOVo4OFAwcmx2My9NbGlJVFF2clJ1c2tlTmJ0bEVFbklyVjRSUWth?=
 =?utf-8?B?OC9EdS92bmVZNGt0cjJIdzNDcnBqaXdmdkVPZjdvWk1lVkc4OWhRM2VFQk1n?=
 =?utf-8?B?T1RmTnF3ZzU1Z1lkdTg5Q0pGVlhRbVZKSlM4ZldNUS9Bb0xWd01KZWZ5bTVB?=
 =?utf-8?B?ZUUwUGlsZzBEaXQ5SFhZekFPbGtTc3IyZjZjakE0Z3VYekFsOVNpRjFoaFZV?=
 =?utf-8?B?b3JIWkJkSnRJK0hyUXQwQjVJeXpMQ2l4TmdUM2dYbVBuSzN4WGtGbmRFRkgx?=
 =?utf-8?B?ZDNkUldwUDZicS80cjZCTXV4YVJMVXFPNVNqdmtpaFFYemlXcEJ5NXpRem1u?=
 =?utf-8?B?c1dKVGJ0dmhMdXc3aFYvWk4wbWxSS05Vc1BqTnpwdTJvL1pxN3hVTmV4VURp?=
 =?utf-8?B?YWxGZzRCOHF6WkhlQk4xY0JHUlBxU2pBTHV5eVNDb0tLU0FvZmozOVovSzFm?=
 =?utf-8?B?QktQbm9XNGNmZ0I1SnpyV3pLT1hjTWxBeWphM0VpK2Y5dmlmU3owS3RFTkl4?=
 =?utf-8?B?azY1V1BqSDhQSzFoV01WaWFKRXNiTjVrUXdiK3VHZXZCRlBEankrYW1ZTDE2?=
 =?utf-8?B?aHExZUVCUWE5YU05UmM4L2djTEdNNmxCNzB4OGFmeDBlVFhLZ3I4K3daSFVx?=
 =?utf-8?B?ZFBYV0VxYWNzV1lIdE15bW1uQlRwUWpkMVBoa3dLdG9SeVhwYXUxQlFWM0w5?=
 =?utf-8?B?VXUyaDV4MDJyV0N6RlYrNW5CeFNyRitvd3FzS2oxSXZBUEw3S2R4OXF1c3N4?=
 =?utf-8?B?ZGdweUJrM1ZwTHBodTVXWDNYbks0OGxwcTNqVEpWMlY1ZDFaSVYxWXFXODBw?=
 =?utf-8?B?VndpYkJ3WXJSOHU5cnhHRUJsVUtPd3pSeWg5QmprOUpxMkxCeDhqK3dqbWQw?=
 =?utf-8?B?aDg4M0tUa1lGUTJEdW1oMVdDRTg2S0pnaFlJRmk4M21Vcy93OFdSVUFUYzVR?=
 =?utf-8?B?MzVQN3MzU3VhNHJSN0JKeXNvdXVoSjNlYnN1VW94T1hOQWdkS3lObmsvV01R?=
 =?utf-8?B?anM3bzVsK1NqV0ExaldpditzRnNjeGtTQ2VJeU9tYThhZFFDNC9EdVRyUmo3?=
 =?utf-8?B?QlF3b25tWVFSNEhGY0Q3by9kaHFUODlFTU5DekszRXBRZHh2MHFma3NheDIz?=
 =?utf-8?B?WEl1aTJ6b25Uam5wQmJ3Z0o1dGNXRCtJVE9yNkZDRGs5S0lWUWJkM3VQcWZt?=
 =?utf-8?Q?NWW3d42/FrcnUA4te7KRQfi5PnXFtR424qDGljvu5TzL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aKjiolbGOdiPW/4lKcKHUxJLkpcFhZ6Ic4QznW6gSUDOzbyU4xZHpIWSp+4LWRhhnpXGPHXC9uL4zZMkVnA+l24ssLCIC+DRarTQqCradFwGIf3uegdKeZ8gwAdvxTHUBK2Lb9KDEgi7siYtXLq5ck01j2ESG2aeLC+smOZWcKUOZlJfAlwki/+Ro90yQfJSUomZ/cHtIs3FbHumep1Zw+bjgstlxIDpxVaWDpU/uF5PECH3UAv7rLgMMmsY4RYa2I8fyCwqVal8aJyRt8rtbd3bB1qhdXkSq9C4QuswS0jqgBU5dNhwHtV00JzlHaIVjgDfBjkyFKorfcJiwYwyWWaryKDoLJ6GcTiZ2Lf0oL4qtpy9MYcapvuZC7FOnmPH4HTrVotMGM+P+aMuUKE7YxI3UP0SNKMy0ddIROukRIWibEqGY2xw8G2AieO+1OSfD/5/O0M554UJoJxxHS1g0/xA/6BM2adGUM7v5QJ2cX75i684ttvGDfftv7dJ5nMaNV7YNrEF0Eu0ZIFEngihUb9AgrZ7fQ8Y3ikyIlBYLnGI4NWKPayAojFBRPNKCIX1xKd6y/9t9ZpmLJTBTFzDluaiUYwB/7Sw8R+wQOTLSEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b416f9a-500a-4728-112a-08de04f1f0cd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:03:50.9645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWM4+1HG+HoF01ow2UItrkHMPtBdSWeBsYbu6speeSfmCc7NIxpaMtDyyszzLenaLBS5a5z6QKxc0pTX+mmuWaX7fnJoPxXwqzC3774jz9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510060127
X-Proofpoint-ORIG-GUID: Wy_f8-oLfKqAvaFMWbgfv6O9_c4mLgrY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEwNyBTYWx0ZWRfX/VwArgOOErKS
 O9l1oIJNDLUHQGuenaUo+cKRSRA0I4fOyToK+DBpIZ1LNY84kxb3bd3DgVsmowcZm8ArIMTbXMA
 msaHVcrn+kQMWP1mi5u4DidtYhw1ao1WUi32rySaaLX1KiUeOpNl0zl4+xB1vWOqojzQZXp0Wrd
 zqeobF01JSUp9xDfdWH17zRnFITJbbJRAhSsXHdW9Bn5hRs/b/mEfJoqV+HvnTQXiHaHfQ9uQAj
 Co4zlcXfg5qRnE0uc6Kezqg6NptCC5BJ/AAlaYQhvl+X7l9B6EShvxYWCbyKjfzVub8aSG6JaLm
 ei5KNKtbzKo7hOsyuk36zMu7y3AKf5NOjWZ9V/I3AeNVUPkkK2QHKuilDWVW1S+A4D6zdKI83Pm
 pyLfYcQAWrT1mjyDcHOsykMo/BGN6g==
X-Authority-Analysis: v=2.4 cv=BM6+bVQG c=1 sm=1 tr=0 ts=68e3e871 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=nzGnj0mPZ7wKwvvbEqYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wy_f8-oLfKqAvaFMWbgfv6O9_c4mLgrY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 10/6/25 2:25 AM, Sairaj Kodilkar wrote:
>
>
> On 10/6/2025 11:45 AM, Michael S. Tsirkin wrote:
>> On Mon, Oct 06, 2025 at 11:38:28AM +0530, Sairaj Kodilkar wrote:
>>>
>>> On 9/20/2025 3:05 AM, Alejandro Jimenez wrote:
>>>> A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
>>>> Device Table entry (DTE) e.g. after attaching a device and setting 
>>>> up its
>>>> DTE. When intercepting this event, determine if the DTE has been 
>>>> configured
>>>> for paging or not, and toggle the appropriate memory regions to 
>>>> allow DMA
>>>> address translation for the address space if needed. Requires 
>>>> dma-remap=on.
>>>>
>>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>>> ---
>>>>    hw/i386/amd_iommu.c | 122 
>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 120 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index ce5d4c36624fd..e916dcb2be381 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -1032,18 +1032,136 @@ static void 
>>>> amdvi_reset_address_translation_all(AMDVIState *s)
>>>>        }
>>>>    }
>>>> +static void enable_dma_mode(AMDVIAddressSpace *as, bool 
>>>> inval_current)
>>>> +{
>>>> +    /*
>>>> +     * When enabling DMA mode for the purpose of isolating guest 
>>>> devices on
>>>> +     * a failure to retrieve or invalid DTE, all existing mappings 
>>>> must be
>>>> +     * dropped.
>>>> +     */
>>>> +    if (inval_current) {
>>>> +        IOMMUNotifier *n;
>>>> +        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
>>>> +            amdvi_address_space_unmap(as, n);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (as->addr_translation) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Installing DTE enabling translation, activate region */
>>>> +    as->addr_translation = true;
>>>> +    amdvi_switch_address_space(as);
>>>> +    /* Sync shadow page tables */
>>>> +    amdvi_address_space_sync(as);
>>> Hi Alejandro,
>>> I think we can skip amdvi_address_space_sync, because
>>> amdvi_switch_address_space will trigger
>>> amdvi_iommu_replay. this replay should unmap all the old mappings 
>>> and sync
>>> shadow page table.
>>>
>>> Thanks
>>> Sairaj
>> Well I queued this but this speedup can be done on top.
ACK

I rather be explicit and avoid relying on replay(), but sync is 
expensive so this could be worth the trouble with an added comment. I'll 
test and will include Sairaj's optimization in a different patchset.

Please if possible also add Sairaj's R-b to this series, he provided 
valuable feedback and testing so I'd like it to be recognized.

Alejandro

>>
> Sorry for the delay in reviewing, I was on vacation for 2 weeks.
> I have reviewed all the patches.
>
> Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>Thanks Sairaj

