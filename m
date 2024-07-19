Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC0AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmV7-0002Ud-F8; Fri, 19 Jul 2024 08:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmV6-0002MH-1r
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:14:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmV2-00013I-Un
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:14:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JCBCIX028828;
 Fri, 19 Jul 2024 12:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=aYN0zCY3XZcGDTo6clXazwgbeBgE849E1ZqsF1aUJH4=; b=
 Y1I6K7GAQxJrnd42sDBw02I2nwOp2aT6pYOqlfg6KYeyU/rsFGlY6K1RrMB2KS5W
 plLWDqvxAEMnbmuYuYSpvPGJLOAXD9hyf+dcUql+LvzQTmiO5gJvfg43iU3uHSCB
 ssrMi+7N7ly3geb4ib4LfJlZSrT2cTCigvBBQ69mF6veV1r+08W1uDwvTbRYCWYs
 reYjRDirh4iyh9948EMLET+6rs+GCSE424EgaH8+pdPJOay7Z1+BRKW879peff7c
 ddHxeKQyEsKMZHLGKvIcSiqlrEKUs46xdY5oxWOUvfnHYZ3S2BzW6TsHOsUXHh/A
 ITmiiRe9eVCfHrUDOvRYBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqwqr0je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:14:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBTrLD031594; Fri, 19 Jul 2024 12:14:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwf130xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:14:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6emSZG4+JkaaA9KImt5twWJff7alI5AqGSkwXdel6gSWH8he4d3BIUISULZ15lszHvrpEzLZO97HPOhDzIbafPWI+h530WMIQyd3U+L1Wk294M/WJGgytqpp93IOBGN/4MDuNlJomVGPxWjqCxXo11pSefXISqcd9OwC6SRD8vKtFK5DdpuVLLki768O4sMN0KaevePWs8+1GqiKenFXNei//naL+WJgFkMRerUtA19LPxUu2kVNlKVDflrPGRlNTNqtSotZmQcWpUyGJ2z1tLhgjs6rIqWIYJM4nWPj4t8OVvcty+DVl2u+6XoxyACzv2ISkAYIbr8SLwFaw6a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYN0zCY3XZcGDTo6clXazwgbeBgE849E1ZqsF1aUJH4=;
 b=Y5pxe6lH5E4Y2jK94f0A7/qHKB3Wz3sr4mrLy8I/HCMVXwO273kmZEOMp64cUVPxdxOoF3QFgKF9VkhjItw3ReHIuKFaKIXBX8SfIgN6gI46nIgm4vQ4knenfSMBouQWcN01/TMRcmxkaFsZi8lJ19nEs2iM3FQgFrVkcPnBL2hNyVt60mybTMz5TcV5lvKB+GTJtDGw7BwX4Tj+fidMycicMeAk8ZeFciefVOIrmq59q4fNCAH+TD9yOYW5jzilLrinn2rJWpKW66Ne+ncGXB6E1sHqHqgQ1mGwCIq6NDEtXC9mmZwyPVJiN6UA2qqHgqGge3LgvfvpECuJbjV/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYN0zCY3XZcGDTo6clXazwgbeBgE849E1ZqsF1aUJH4=;
 b=dVd2HLf9d4ehnOiJyl4/bIAL4ta9AkjPZfyJB1ZvhSbj8bxmM6N9hNtAadiXrd6CCgTo6xSl8AgRdX4gfC5rWrcSUpgONc1m7ssTZYN0ded4jrYGZeiIluZC7wN1jIp6Omx3/8SZl7wXbBJzN1RrYrJqMGTLkJD04Rd6A3JjYrU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4717.namprd10.prod.outlook.com (2603:10b6:a03:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 12:14:07 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Fri, 19 Jul 2024
 12:14:06 +0000
Message-ID: <7421dc4c-a3a3-464c-86f8-aa88ca899bc4@oracle.com>
Date: Fri, 19 Jul 2024 13:13:56 +0100
Subject: Re: [PATCH v5 00/13] hw/iommufd: IOMMUFD Dirty Tracking
To: Cedric Le Goater <clg@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: b43431e6-d6a3-496b-3364-08dca7ec4979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzVkTU5nT2JvZWxjd0RIQnhJZU0zZXNza1NpSGRHSG9VbHp6dGlveG9yL1FD?=
 =?utf-8?B?NzFQdml6bDQramRYQkVORWVsZmgrWVhMZmZlRzhlMHZoTkRKSkI4WWRtUlda?=
 =?utf-8?B?dE5UOUNMT3lvWFUxYi9UUExmVkNBSERmMEpPcXhFT0JhMVhGanpwRjBpTk5X?=
 =?utf-8?B?SThERXRLS0tUQzdjN1JmSjg2c2lFRFI5dElKTVVsM1k5NlNPVDdKL1Zod0x5?=
 =?utf-8?B?OWRTN2NrOWd4VVpBRXdrOXZTdXFDOUdYT1hIaG9kM2NUeVYyS0ROTkhzczBi?=
 =?utf-8?B?R0R5QWpUN0MwcTk2OVVQN0tnM2wycHdBVklrZEQ5TnlFdEZVcGYwY2NrWkIr?=
 =?utf-8?B?a0V3VHJ1QlVkc3pGekpuQjlKZ3pPVEIrdndEZ0R4WVQ0UkJTSFVtazRMZTE1?=
 =?utf-8?B?Tlpmc3dxL1dkM1BQSmxsVDQvdkJZUGhvTHVrWEpUczdBb3MwQUVuN1VnWjVH?=
 =?utf-8?B?RFRjaVVJQ3lOV3dUQVVCTXdJN3h0QXV4QXgwTWx3K1NSbTJSL3VUcVVCa3ZO?=
 =?utf-8?B?TDdqUjJPcXhON3Z6Ymx0Z3lzRjRQYXZPSEFSZDJPOGg5K1hhZFVOKzd1RFJr?=
 =?utf-8?B?TXNQMlNaYVNZSC9nNGYweE5CcnRmMlF5V1UwQ3QwV3JWVTFCNlc3TDJ2ZXRC?=
 =?utf-8?B?dlJrdFdSdjBEcUdXbWJxNkkzRng4bFpQaVZHSU9rOUV2bmtYVjVYUzVFS0du?=
 =?utf-8?B?ZXNtaGhrWjQ5Z2dvL2wvNS9meWZqZnlPbkwzbThmcGJHbEM5LzZzS0tMbWtj?=
 =?utf-8?B?ZmdtUU5nOHQwZDJXdkVmVDVQb2psQnp6SS85c2VKeHQzSVVuQjU1TDdzR3B4?=
 =?utf-8?B?eWt4eUFuSjZ0eHBQdHBxOXduQVB3OStVNXBUM3FFMDRDYXo5dy9MTVJPSElq?=
 =?utf-8?B?WVdQRjg5M0RqcUFFK29kS1pjODA2Y0s5SzZRanhqUzk4Rk1xUS9ySXAyUHpp?=
 =?utf-8?B?c3lsUStSSWkwTUl5NCs4WHRMYThjYmZ1VUNxUGNsWGtuOEpGWVRCdTNVREM2?=
 =?utf-8?B?Uy8zaEY5VkRWTzZqQ3pQeGd5YnNPUmM1QTNwc21Mci9OS2NQSlRKeFpKZy96?=
 =?utf-8?B?dkwxWEpvNXVheTRKMjFhWVdRNGovLzZKZWtyQUVuWHR2WWIyWVA2WkxuTXc2?=
 =?utf-8?B?Q2MzWUZCdXNycHVqeG5wbm1QaXhmY0ZCMlQ1M0ozbWMzaEhxQzAycjNaUnB2?=
 =?utf-8?B?TTFYVW5ydVRwLzd5NVU4MTNWbm5jclJFNlpTWVhockU5SmRITkxNK0tvMFNu?=
 =?utf-8?B?djlGU1JueG1waWJQMUV6RzRSMk9xWE0yRnNzdk1CeW5lNkROVlIySUdpNUlD?=
 =?utf-8?B?cGVqSkVoRTdmaVNVSWNBZ3BiRyt3K2djQzdqQmdtbTB4eld4R293aEhKa0k5?=
 =?utf-8?B?VmxOT0VjV1B3Y0owWjByUTBFZ2k5UlNXd1pVZWZrVDFzQmRaeDJxUDNNMEF4?=
 =?utf-8?B?R2JsRXV3QnhIelE2ZXA5Z3R0T2hqRlQxOEg5TTNJT1BoVlhoM09IYVQ5b1Qx?=
 =?utf-8?B?NkN1M3VlR1JDS3pESjNiaWY1RlRVaSt3QWVZZER2Y0dYQlhJL1dQbUhDNEda?=
 =?utf-8?B?ZGQ4TkJBMzFnbnJ5RmUyTkwzZ0FaOFRPMEt0ZUc0QzlCQnVpNkxIWTR6UVFq?=
 =?utf-8?B?SWpKejNCZWV2M1dIKytCdnE0UDl6UXd2ZTdLRms4eG1zRDVEYmFRN2w1cVVk?=
 =?utf-8?B?UzdYQlpwR2cvMllpaXVEZTd6Q2xSelBWWDJEV2VEaFhtU0JDUW1FNCtPY2RV?=
 =?utf-8?B?ZWpQVlBOU0RhZkc5ZzRzbnhOMDNtVEpMNTl5ekFEVEhjUkFyVHpPZ1I1WU9U?=
 =?utf-8?B?YjNHZ3YzV1p1ZkNOYm1Bdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djc4YkVDYzlvbjdaSnRoVVQxbUtpYWhYUVQvSmlrOUxiRW5pTG5Na0FyQ1lQ?=
 =?utf-8?B?Y3k5T3hWZ0RKbm5FaWZHSWVXSml4RTY5enBnWXRTejNRM25NN2pFYUxkcmk2?=
 =?utf-8?B?dU5xeHBPb29kcjFkZmo5UDBPU2NIYkYrRFk4bGQrcWJEMVFHNnhIbFp6dGVE?=
 =?utf-8?B?NWZuaWtUOFRsNDkweE1vSFVmRjNadDRwaU9veHZWNTc3a2dCQXpZQ21hOGF1?=
 =?utf-8?B?SkRGaDFLajBEek93d1gzaG9BeWZEZW52OFR1NCt6c1psOEJVQ3U3ZlJXdjY2?=
 =?utf-8?B?cDRxUDQwWE5ScFlScURQQ2JrQTRxYnpKS0hWOEpqd0NJSzcrSWxZOTltOFV4?=
 =?utf-8?B?QUt2L290U05RVHJiR3JseFpRNURoTEtVbUxNZ3pGdWo4U3JjM2RXenZWODAy?=
 =?utf-8?B?dTJpK1crN1NqWmxPcXlqbGJSZXB6R3MzSjZ5bzFQUU1hZ05DSHdZeThobk04?=
 =?utf-8?B?dTE0cWpNSzEyTW9PUG16TGVRNUFKcHpTZDl0QUx6d2tCcUNkRXo0ZEhFK1F4?=
 =?utf-8?B?Ykl1aDVtSHVSUlBKbUc2KytnUkVncTFzdStPTXIrTDErSytEOGJueUpwNXNW?=
 =?utf-8?B?NE9kN1ZvZ3BJQkdnWGsrMjk0THhvT0tqVVgyZWhCRDFhaU5Lb3BGVVNvM1FK?=
 =?utf-8?B?NE9BSEZHOUgySjBKVHJyNjUwVEVHenMrNk5JM1ZjZ21BZVlteUhUTTBZejk0?=
 =?utf-8?B?S1hkbkhuNkl5Q0hrR0NWamIwYjk5SDdHVFBHMXFibUw5V2hnWXVLbC9QOG1R?=
 =?utf-8?B?Vmc2RURVdk5SMzdQaitJNTR2T2hMWHhjeld4cE4yakhHcWVpOHBjc2tkQ3E5?=
 =?utf-8?B?Q0J1a1JLK0tKTi9Sa1hoU244b0RHUGRpRjZmclhVR0dwc25MWnNwdktYTHU4?=
 =?utf-8?B?bDlDREwrWlgvVWp2QmsxMWRJMDl3NFJjWDRlREVBeDNKa3lVY1hJYkZoQ29T?=
 =?utf-8?B?Z3FPY2FSZitGdnZ2bzF2eEtSQlA3Q3dFaVFReXhtKzAzdGxrYXJPOWNlcmhj?=
 =?utf-8?B?TTl6czFxckN6U3l3ZUx2SisySEtzeDJ2dHU0b2dzcU9NNnVseEMvbmFaWW1s?=
 =?utf-8?B?eGdmam9UTzVvQmpoL0ZHVUdCNUd3REI4RFZNWWdMNnArZ3lDQnZydXpxRmdL?=
 =?utf-8?B?aWFvUk9vR0YzZTM2cVNneWpqRDUzZmVOY3EwWU95eGl2dHRkUzg1RWN3dG5H?=
 =?utf-8?B?WFN0a0pYMzV5RW53Q3NoY2x5TmI3VGxGZFRDdXRONUFGVzBrRVB6cFpCb2Ux?=
 =?utf-8?B?ZEYrU1hDdEhvd2lJQVRpb2RXZUhwbSt3Zzd6azRiRVVFa01FbTIrYjJQZnB1?=
 =?utf-8?B?RVRRV3B2d2xiVWhlaEYyN2ZGeUh6YWpnMkFvUVQ4aytOUW5rQnlCNURvUDN4?=
 =?utf-8?B?bmpoTmh4QU9mQWttNFRpL3dkVSsrZXNNS0w0YzFlRmMwS1VWSTZTUExGRlpC?=
 =?utf-8?B?L1RVYk42NmozYnlQR3B4RVJiMU9Oc1BGeHVEN05QN3FtbkoyWTBESkI1bmw2?=
 =?utf-8?B?bHlPTkFDMVZZTG1yS21ka1ZSSnBkQzk4UUx2SDBUaC85Qkh5U1lCZElOK2dF?=
 =?utf-8?B?ZGVmQkJSSEk4L2pNZ2xGOHE0UXI2dzRPcDRuSzlZY1FQUUxEaHRmYThna1dl?=
 =?utf-8?B?ZktvdmJma3hnU2R6SlQrd0FLQ0NLMk4yQ2Yvd1BwV3FGUDJUNzZQR3lJTER2?=
 =?utf-8?B?Y0U5NkVuc3RBSlpyK2JMRXU2WWxQS1R6bURWRjllNm5VNEgyMXAyKzJPNlZt?=
 =?utf-8?B?aG1hK2UyRXBrSC9UaVhIM2JQbktOTSt5MWdmZ2txYUhyamh0aUExdDBuMStG?=
 =?utf-8?B?LzNSazhTWmVFd3AxL2FQUXYxQVBtYzY5NG1PeU1FanVoMXZrUHBwdGxiSFgy?=
 =?utf-8?B?S1FyS2l5SVJYTEdrbVlhTlUyM0JOL2V2M2NSU0tORG1YT1h1d0dkdURjbEF3?=
 =?utf-8?B?d29lc0tERlJETC9GTmNCcDJ2enlYOXZKVUk3T0YzdnVFQUNwVXRXSlJRWnpp?=
 =?utf-8?B?aEpqK2RkS0tlR0ZzM280L0hnSHRONmpZenEyZWptYW9xWHowRnhVd0hGcXFQ?=
 =?utf-8?B?bW92WThqZ0JkQ05ObXZrb0lKOW9RRVlqMFRCZThyWW56eURzQ3A0YkhKcmFD?=
 =?utf-8?B?MWRPejhaa1drdkF0RWRvOHQwMVVpR2ExeUFWWndhdk9iMEZoSjhaOURUNEJ2?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +LJHTKX4/Cz5wJHP/cyyWmMFOfWuZi+p41CD3EmedmV5gE0SswIiaEPB3+YXPDgiMcd+X/dtfPSfw7s36q5wLkk7CQ0x5ycM7sPb1ZRc3s2d8ZJT4caZXKGcicWm2K88/dG2Nq5J/ZZpDcC5ysKTVnFmXAe7o2UId7BE2Yf58jrUllvsebAjdRQRHyOFXXQCVsqnTeP0Gyxnvhu2okTV8v+ICHBPcbhYsMyd1lPJtysWagTIE4wKi3uQ7r0R7cMfMSIPs3HDh3inWpHhxx1qpEuUmquV+qzcdDHzCvaoZ6JerJbMRweNxekO5TfWI7VNbw8axsn3SyR1Pu38wPLWBlKxrrzUnFz86byg/QJI91AXkLyfausYrd2wSayb7jddgT1G2RaYfUHv3OZCz1E4PLNBgivcRq5MBMWeBniQhU+hxaaK9NEF2YWDu+siLFI4TOcEvvjpHVWkIKZxHlHRp758mjhP+R+MkYGw9uJE+XLEUyql2RdyZDdqpNs7E+4zymtsx3DZQqvBSlVDiFtfmoIYDU6fGcaBa5g9TyI0nmnXmHEFpgDIuPKebiXAl0Cld5+/OdZ/GqMwOTsriyubHNUPeNJd5p/5qTLimGC3OQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43431e6-d6a3-496b-3364-08dca7ec4979
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 12:14:06.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFSdRWBB68FDyB7rBSMPTKz0wLjLTuZlW5Xlz+4T6elK8cYVCXFGG49qnnTTkcc7z0p6iWEifrO4k7uEWtcLgnTnUCNqHWKTEn8kB7hGJRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=843
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190094
X-Proofpoint-GUID: 7BJJ8qxvgitUKVxamt636aWE4D-GhuyF
X-Proofpoint-ORIG-GUID: 7BJJ8qxvgitUKVxamt636aWE4D-GhuyF
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

Hey Cedric,

On 19/07/2024 13:04, Joao Martins wrote:
> The unmap case is deferred until further vIOMMU support with migration
> is added[3] which will then introduce the usage of
> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
> dma unmap bitmap flow.
> 
A couple notes with respect to this series:

- The first 2 patches I think are needed because it addresses a regression

- This paragraph is meant to state that this doesn't support vIOMMU, and so I
haven't changed in that area. I am assuming that when the vIOMMU will get resent
for 9.2 where I would address the IOMMUFD counterpart.

In case this be merged, the next Qemu stages after this series are:

1) Mixed mode of VF with IOMMUFD dirty tracking
2) vIOMMU support (with the relaxing vIOMMU patch and IOMMUFD support)

It's not listed in terms of priority, just wanted to make it obvious on the gaps
that are on my list.


