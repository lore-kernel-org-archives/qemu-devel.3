Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0184AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2oK-0001A0-2m; Mon, 19 May 2025 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2oH-00014M-N3
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:53:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2oF-0000a1-4k
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:53:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEdBNa001163;
 Mon, 19 May 2025 15:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=mUp8zN3jeEgth4ZpAhGUwbF3Gp+lftAj+xTazSZr8P4=; b=
 OQgxP61Y3xWgt5hDJrUPJbk82xMyi/9zvDvPlAxD8fvKctG9BC+t6TGYYwnZ5Ky8
 szjZp+AeRnrexFeK1PNG44xrmJalCX9Der+azJKnefX3gfm7T2MkFhQrzQhJhCpA
 nqkhYpGJJ7P9ojZJiq5IUb7MGuKHNhA1mhHSfZVxciGAuhDCF487iDXhNJrKLslD
 AV2IhDSJJSrIS9PNk7GbE2b6WtD1eGrlQCCY92jTMhvOwrTjW9Sb3I4nVPMNsRza
 QxAU+rfS3brrEF36+vAD0B6L/Ht1kiZqxOqpeRx4/wAe2uAqd4QuGVcocVBXoMRZ
 xvqkZI513U+qT2/zOscnuw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuau6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:53:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JF6VRu028838; Mon, 19 May 2025 15:53:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6uwgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWJf4JIWIQQ5eJJQr8JgUZz7j3qo8u43Em48YnNCaiinVd6xnbNbCiU2RznISR3Fc7JSofKqI4IEQTnQ3JPRcfY9GM5h6PArL1LP492vVMnreNqXMjZ0h9nVZI6f8R0AR7Vm0ni8UxO4RtEFt7tgsh1hE3oIQ5XOXVtYi9IZPE/mvsRrtjQKG5gufnQuuyHO+I1Rq4yPFGyzcyhRIW+XLDJ4VcYusiex7DKZ23l+ohaLtdAgNgprCFJo1c/WeOb4vNbmrVIlJBK3gTxGzk9PeThlkKfnFWzLOEH2olewdPTiX2cQqTPZnSt9BWTj7/wLSUqqemTPbq22Vg1GTKF89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUp8zN3jeEgth4ZpAhGUwbF3Gp+lftAj+xTazSZr8P4=;
 b=fsEIRXFF2+SA6yKdcakeMGie6WLSc57cdI7gfpynK5OfCbAZnj5p+RfViOCGNExJ0vkbqUR30MIBGUGpx9sLrH3Q8TEwl52tTa8qwB7pQlNRxH//2cc1h5GdhRKi/1AdcDD/2Quyaqw7CpS3K3PVTSWPf99702qYB37I0Ww6gnpGokA5qM0QiBoDgEJ0ukqA98wQjEbVZdRTpfMd262v9lU1UCNvxdYiQ26WbmAKxrmx6SNYdWyiP26ZfAy1G8YmS0j+B+7PpcHLoOn0EMAdqU9OExf2wVQCOSfkTF1Kh/6MmuxgrF7Fz09SAk5c2tEx+HfqowOP0jNEvDPa6aTdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUp8zN3jeEgth4ZpAhGUwbF3Gp+lftAj+xTazSZr8P4=;
 b=hPstBOnNC9iBd/Tn+j4KIv58GlpWz/0wCZxecaemX5lZ1h6z6qocsi61JPBC/bKyOs/7BKyMdUMkfIFVMqAjleGpzLtTsKn/iJYq1TnjduI+v1oPBKB8vaIgFp3Gr9Y81JBqjqwtZjfw3m//0gemvYB0LtjHnmXwm4gSneucORs=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:53:38 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:53:38 +0000
Message-ID: <050ec82e-3cf9-4058-8db5-04f5263c516d@oracle.com>
Date: Mon, 19 May 2025 11:53:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-40-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744EFD14811E4BAC0C05BE6929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744EFD14811E4BAC0C05BE6929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::16) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d544ad9-2469-4dcb-befb-08dd96ed5229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlRkSGFwanFRQ2JpT0NBZ2VRa2dQaDgzb085VzE5SWxZdjFJbTk3SUtENmJN?=
 =?utf-8?B?SjkyTm8xYWdnZ3ZCSmlJOHVmR2E4ei9WNWZmZnFsUEJYMG1GSTM1TGN3M0RP?=
 =?utf-8?B?eG1vM0srcWhIQlQvQTlUZDRncHo0T2MraFUwZG5EWjFueUpWVHBBdzlyTXdz?=
 =?utf-8?B?Z1hPQjdmOTRuMjdxVlJ5aGUwTzVaYUlkOHpEUVdUMVRPZVp6anF3dmlrQXRW?=
 =?utf-8?B?RnVBNU5yZ3BnWS8vcm1IQzVFajBXU0dacS9uQnJEQ2FYc0V2bW9RaEtWM0Z2?=
 =?utf-8?B?THd6NlBDR011dy9wZUxXaFhVeUd1QWxqQVd4ZFZza3pFSndIWGdHbmo3b0NH?=
 =?utf-8?B?WjFSSVVQcXpXN3dwV2pvbFdCc1YyV20zaS9qVWhuQVNoRk1FSzBOcWIvQWti?=
 =?utf-8?B?SWlRS1c1VUN1UThSZlNmWW54WUdQWkdrMi9aOGtYcGFSaTgvUGluZTFPKy82?=
 =?utf-8?B?MmZXR2xnRUgzNnA5VzVVY1UwQ1pTZFhRUkFrSmhTeVBGRXhPUXByNjk2Y0tD?=
 =?utf-8?B?MmRaMWhMbGc5c2F6SGFrSW5Pdy9wMGVXOEhDWU5pZzRCUnF0WW5GQUtRVWkz?=
 =?utf-8?B?eFJpMGFXM1FPM0N0aDBqcmN0aVcvRSsyTGVVSis0RXBMNkNuRlYzQ2FrRlJR?=
 =?utf-8?B?U3RWQm93R09yUERNallzWjh1K3RzVGNOd0p2ZzNaVmVPTUF4ditic2phYWJo?=
 =?utf-8?B?SDJ2MTA2M3hVWXRJQmpZYjZiL1pUSVM4R0U0MjBkaG1WckVkRWx0dTBwbkUr?=
 =?utf-8?B?RTFzUmdqSTdoaDZpU1lxZlhTSWJodlR3K1MyVUxEams4SlJ3V01pd3FNTUVx?=
 =?utf-8?B?bE9ZYUFyUU0valB6dlVRNmxPYnllR3psWFlYbFBDMkVULzMyajNiMU1zOThq?=
 =?utf-8?B?U3V2dCswV2ZuR3htbnVTZGQvQ2VXZi85a0oraFpEbjNnWkdzVUdiakdYY3RM?=
 =?utf-8?B?S3ZkaXpLbktvUkdVMlNiZXFaREVRc3JnU3E0NmQxUkZmVXRzM0ZFUE5vVGdI?=
 =?utf-8?B?L3I1MjRyaSt3QWRJd0VUYVptRDlZM1BtczNCZ1RLSG9uNlZIWlFvRlhNUlpn?=
 =?utf-8?B?aVR5ZnZ4VE0wQSs2Q0xGclErRzBxbFlCYzZRR1dYL0hqYkhrMTU1Z21DcEpw?=
 =?utf-8?B?NGZyVkhqVUducG41cUxYdXM3ckR5TTVNUE5lVXBMa1pqcmhoYTNrRkVldzE2?=
 =?utf-8?B?WDRWTmRjYmNMNEQ4NTZVU2s4ZGU3OWwzNG5qUWpsMmtFUk1kZlh5c1VKa1ly?=
 =?utf-8?B?RWd6SmhkNUN4ZmJKZFhzbG84eGN0TTFLMjVZY2YyVjBVT3lOOGFGUngwUHBo?=
 =?utf-8?B?U0IveitNbENDN00zeW1GNGl3M2xjbCtYSjRaUk1mQzFoTVJmVE82Y25JZWhy?=
 =?utf-8?B?aVA4RXV3bElnZU00eW1vdGhQSmFIUllHdU1PT3ZhSnQ2UTJTR1p4eWs1T0x1?=
 =?utf-8?B?VDdJMm9GcktjNFJKMGhZN0NVNGNPMS9zbkg4WkVQdnF4VTdQaVFHNVZlcmhX?=
 =?utf-8?B?N3d2ajljUzRBb2VjZjl4Ujd1MEtOdFN1Ni92UGg1K0VJWmhOcU9OQTIrSGY0?=
 =?utf-8?B?eVdBTWN5eVMzQ1pPVk53Q3dhUHhINlJ5OWZlYXI4aE1hMS9XUmUrUjh5dGl5?=
 =?utf-8?B?ODJ0WnRlWEc2c1JhejZiSjdFdHByTkg4TDByQkNpbys2VmcyQmdyTzBxWU5L?=
 =?utf-8?B?V1BWNnVsQWJrR1VrUkVvelVHOTdxWFp2azFpN3BDdnZDU1NXaHpESnF5ZEd5?=
 =?utf-8?B?Z3VkUERZZ0tqSTZXZlc0YTI5UHNKcm5aKzZ2RHNsM0l0RGRyUmVGVjNkZzRx?=
 =?utf-8?B?bWZEeWZJVHBxTzBlVEFPeGZJVlZvQjErNzdoSGFOaGVzakNyM2duamI5Q2tI?=
 =?utf-8?B?NjROaGJjQ24rcFFjN01WL3BMZWhZTExjdlg1VzRwWm9rbVBCSGNqZXBsUytY?=
 =?utf-8?Q?CyZp5hSQV/A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtWbmJGR3NwbHIyaklOdmZRZzluZ3hFemQwVHZZc2dPQjBUc3Z0S3hEOWVk?=
 =?utf-8?B?SndTMzF4dWh3WnpKZVNOTlJXWTh6eEYyeUtORU43RW9vbytBNGZvcFhkSVF5?=
 =?utf-8?B?bFI2SXl2Q0IwY2dNZ2ZveFNwRjVIdGl3cTFXcEYzSVlXZEdocGZsRW5HTFda?=
 =?utf-8?B?SStybkVPekJGNHRNK3F5VzlZNDhRcGpuREZvaTRIdWozdlJwdVhFcGpKYTN0?=
 =?utf-8?B?dkk5OEdQUTdXV05FdlBYS1A1R0ZmU2p3c2J3cjA2Q2Eyc3RTbk9HMDB2VUM0?=
 =?utf-8?B?M0hnOVFJbGtEVnRNa0o4ZXB3OUxuYStnTHY5NVpETThPWTZnZTA2L001cGhv?=
 =?utf-8?B?TjJOV3lEc3NialNxTDBJbkFDcHVEMkpIOGkvdG40NDVhQXY1NGg3YzlURHlD?=
 =?utf-8?B?WWNMd1ovVjJYNjQ3K01UWEFneTlaUFNzSm84L0xtQmlVWURLdWhoRXRSOFB4?=
 =?utf-8?B?ZUxBcEFiWGJzYU93LzRPWVBLRWxJZ3htTGMwcitJb2gzeWF6a0pNVHR3aDRK?=
 =?utf-8?B?L0h4VXpLQ1E5cGozWG8vMUxiNi9EOU5DN3hBRXp5azl4UFpuQnFDd2c5THRZ?=
 =?utf-8?B?Y3dWMW1DVUtER2d4dmdNTWhidDZDQ3hEOHZ0eTJJUk42ZnhpczBtUlpxMUxM?=
 =?utf-8?B?Y0gwazNoV3Z3bUU0ZysvSUxhd0hoazNNQnpVcmFCUUtjK2hudURIbkYxM3c3?=
 =?utf-8?B?UUJsRGk0M08vanA3T2hJenJJS0JHMEhrcDZwNG9ESnJRVzMxYTRvbmIrcFNF?=
 =?utf-8?B?VGFaTW9tYU9RVWVNMXdXWW5TNjRHOU1sU2Y5NE9kL05HNUw1Rmp1dkZGSldS?=
 =?utf-8?B?K2pZeTREKzY2UUhFajJuRFpGVllPTS93RjNRRGNVUjBNUWZncFp4TUJtbzQy?=
 =?utf-8?B?NElwb3lZeFRBZXdtYlhXLzRyc0QxNnNvc2J3UFFHekFUTnpZSHl6b2x0cGQw?=
 =?utf-8?B?WkV4L0k5Rk5aMmxjY3MyTHhDV0FWeXlaaXhmUm96UGNtT3UwU2RQNDIvTmlZ?=
 =?utf-8?B?TGF5dlRWQ2dtN2V0VjNUK0FURmloRXlPUHAzVlpGRzEvdXYvRFlOOTg2RHN4?=
 =?utf-8?B?MFNSZjFLV05YeTQ3eEEvUklVb1BNR0RiTVh0ODl5Rk9JSU9NcTZ0L3dmcy8r?=
 =?utf-8?B?U3V5WUZVRzh2SC80RytGQUVFckowaEtmYjY3S1MxcmJQOEMyakFLSnJuQkpI?=
 =?utf-8?B?N2p0TFNzRUg3eVNyZnZ3MThSa1FWeUFteDNzSE1vbnY1aVRjaFRINHZuR3pz?=
 =?utf-8?B?emwwNDhsRFdvSnA1S1pWNlMvV1VSZjBXaEEvM2hXTGVjMXc4eGFXeG1XYkNP?=
 =?utf-8?B?dDRxaTBDWmhDbEpWSFVlZ2xyajA1TUVOaVBzSjZyNU90eVN3RUxVWlUwSUlp?=
 =?utf-8?B?ZDJmOWxOS1JGcFJBSm9GQXBLOGc5MDR0MnlocjZmWWZjZUgvVHZ5UldFY1FS?=
 =?utf-8?B?NzJGYms0TWoxTUMrUzdhTlBZTWlhbTgybmRtd0JtbGdPd3lURExES2VRVjdW?=
 =?utf-8?B?REc0TU10Ky9mUjdQcmMzc2d4MnRSNTdINkNnQlFkWWpqRjFybHQrU2FrZUIz?=
 =?utf-8?B?enV0cVNLS09yVXlhNFpiaHUvSjNKNnJ4QlA2am9CaVh1R3FXYzZsUGZnQ01E?=
 =?utf-8?B?cnlhSTFvQU40MkNmVXJhTHdsN01SOU5mZVN5OW1jSndWdTJ0SGRER0pScjVM?=
 =?utf-8?B?SzVtTzJvVkg1ZUt4T3dKU1ZlVEhLSGNHa2VXb3RFM2VYVjFNNjU5REVlK3c1?=
 =?utf-8?B?Vk4raEVTT0JYd2F1MkkxTXU1R0FxRVZmT25NSUpaOG9DN0JvMlNIMDVzV1hD?=
 =?utf-8?B?eUxib1p4b2tNS0dIK2c5SlNPdUY3NnFBYStvbXV2NC9tSWZPS2wrc0Facm9s?=
 =?utf-8?B?cyszSEVWTnRsOFUzSUZUUjV6NWhtNjB1YUpwT0JDaGxtaVppUm4vUUlqVHNu?=
 =?utf-8?B?M3ZHdFU1Y2V3TE04VnJSdHl5QisrUHhpNERnV1p4b1VGVkxIanNDeEM2ak5m?=
 =?utf-8?B?UVhEZmxaL05HbE45QWh5UlpJS3RsRGxxS2pmaEdCZXlEaWEvQzYxRmszVElB?=
 =?utf-8?B?Z3dyUnJaaVZRSWx0NERyTU5BQXJHTVpQTjNJNzFBZ1NlV2ZMV2xrQk5DdTUr?=
 =?utf-8?B?Kzd4MmN0VE5mUmVMc3pUcmtpc08zYVIyVUI5L2lHbFFBY01laWcvS05hYWVC?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wvNcMy4batI2bV9fxgfbUUA9qmOV4cR9gKq2+NnWDuHDc6/80G1miejxxx1P4osSvHFQ0SFI2aAMcVROJ92Rug4Ol9cw5Qe6p8XhYR3tfg40n7v2QPRfsClEyeY7Uahud+cFBkCSnh0EnbM4gTXpXuPKvo3OlT7TeTLhqOEhtseglcUY6BiWL7YleHOOMKTfKxufDcsXCB8/zyKT0BQAbnQllMQ6Ppqm9bfhRaxtQzGz9KPsp1X3XT+oS6KaxATYy08NZSxeN2D6jOEbP0/gqA6+YJGqFh97QeBqrv3sCgMgvL6fqlMiZ9rjqJDP2lfVOMIkaPztuoAjYp15jPfeZjSQsBkwB8nfImP7HyN2s/HRz6+nDFFOeAhZwfrucaCKz6orwiiqrwljJGIeWyEanp3pKJZZzSY7lJUOtpyGp9sNp/S6YKy43K6nL9J8ByqVD5n8LN8yP2Uf5HV8PKbCh3XgvyIngQABz8TvcAsok4IoSViuh1aJ9/rbJ5tKNolu5RpQbLlbG85S5h3rEpkfu27o0fam/1BsdagNpITm6cGvgbxAv7UbbUay6IbzdDjtHqlq50XjXSfChTvMPT+5dhgeHTlWzH7kdsgZXYVP5kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d544ad9-2469-4dcb-befb-08dd96ed5229
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:53:38.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6CtRqEqhpyuVFpxJLylUzsZXlaPtfKtTIt7hk97rmf4cR9MIlWSqp7m0D43fb3oCnM733HH793KLnDwZ0dbupmlMASBkyVL4EQRV+mm7Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190148
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b5408 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=SuSn5cj_F2-_BnzXE6sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xrODbQya6LVLwYK0Na34Q9F4Dcl09Yr1
X-Proofpoint-ORIG-GUID: xrODbQya6LVLwYK0Na34Q9F4Dcl09Yr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfXy35LgYquW0va
 zzrIKJAyPRXEwpSnvC7y/8+JRuNcDKCPYEQefiBihmf9mui439+JWS0Obc+fNa3v/QEPWBFL+07
 iizJ8Kg1CuWBtJeK3xr7kuvUVUWWlSxon0XyiiuTwNFjnB3jIX4HQQ42O8ZiknsQbDL7bBU2/M7
 8kFxgXsEcI4feI1CLTeFIvs2KHHfZJZCDP1S4LgLc7gwTosuq7x1py2pQpZll2iBzc7e49VIA89
 2U0GfXYe6g+mVpdVI8/3w1KvMfhVNUVoA+SoKIMIxAGwkjyn0CCJ9df3oqFIfyZqxzk8i/xpHAA
 3UIehFGS8xcbazlVEF5+NmXVhuctANYcZrzzQ8/HhAbp1KQYwOrL96ZWu/V+rL3V+bJR22dMHv9
 k9BNYyCZz97XkcClz0bIXYYZrOXSl6xVi5JCbysUphZwGODb86UOrkUU9cOqQTGPEBpRs+OT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/18/2025 11:25 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
>>
>> Save the hwpt_id in vmstate.  In realize, skip its allocation from
>> iommufd_cdev_attach -> iommufd_cdev_attach_container ->
>> iommufd_cdev_autodomains_get.
>>
>> Rebuild userland structures to hold hwpt_id by calling
>> iommufd_cdev_rebuild_hwpt at post load time.  This depends on hw_caps, which
>> was restored by the post_load call to vfio_device_hiod_create_and_realize.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/cpr-iommufd.c      |  7 +++++++
>> hw/vfio/iommufd.c          | 24 ++++++++++++++++++++++--
>> hw/vfio/trace-events       |  1 +
>> hw/vfio/vfio-iommufd.h     |  3 +++
>> include/hw/vfio/vfio-cpr.h |  1 +
>> 5 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 24cdf10..6d3f4e0 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -110,6 +110,12 @@ static int vfio_device_post_load(void *opaque, int
>> version_id)
>>          error_report_err(err);
>>          return false;
>>      }
>> +    if (!vbasedev->mdev) {
>> +        VFIOIOMMUFDContainer *container = container_of(vbasedev->bcontainer,
>> +                                                       VFIOIOMMUFDContainer,
>> +                                                       bcontainer);
>> +        iommufd_cdev_rebuild_hwpt(vbasedev, container);
>> +    }
>>      return true;
>> }
>>
>> @@ -121,6 +127,7 @@ static const VMStateDescription vfio_device_vmstate = {
>>      .needed = cpr_needed_for_reuse,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_INT32(devid, VFIODevice),
>> +        VMSTATE_UINT32(cpr.hwpt_id, VFIODevice),
>>          VMSTATE_END_OF_LIST()
>>      }
>> };
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index d980684..ec79c83 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -318,6 +318,7 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>> static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>> *hwpt)
>> {
>>      vbasedev->hwpt = hwpt;
>> +    vbasedev->cpr.hwpt_id = hwpt->hwpt_id;
>>      vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> }
>> @@ -373,6 +374,23 @@ static bool iommufd_cdev_make_hwpt(VFIODevice
>> *vbasedev,
>>      return true;
>> }
>>
>> +void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
>> +                               VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOIOASHwpt *hwpt;
>> +    int hwpt_id = vbasedev->cpr.hwpt_id;
>> +
>> +    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
>> +
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (hwpt->hwpt_id == hwpt_id) {
>> +            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>> +            return;
>> +        }
>> +    }
>> +    iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id, false, NULL);
>> +}
>> +
>> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>                                           VFIOIOMMUFDContainer *container,
>>                                           Error **errp)
>> @@ -567,7 +585,8 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>              vbasedev->iommufd != container->be) {
>>              continue;
>>          }
>> -        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
>> +        if (!vbasedev->cpr.reused &&
>> +            !iommufd_cdev_attach_container(vbasedev, container, &err)) {
>>              const char *msg = error_get_pretty(err);
>>
>>              trace_iommufd_cdev_fail_attach_existing_container(msg);
>> @@ -605,7 +624,8 @@ skip_ioas_alloc:
>>      bcontainer = &container->bcontainer;
>>      vfio_address_space_insert(space, bcontainer);
>>
>> -    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>> +    if (!vbasedev->cpr.reused &&
>> +        !iommufd_cdev_attach_container(vbasedev, container, errp)) {
> 
> All container attaching is bypassed in new qemu. I have a concern that new qemu doesn't generate same containers as old qemu if there are more than one container in old qemu.
> Then there can be devices attached to wrong container or attaching fail in post load.

Yes, this relates to our discussion in patch 35.  Please explain, how can a single
iommufd backend have multiple containers?

- Steve

>>          goto err_attach_container;
>>      }
>>
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index e90ec9b..4955264 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -190,6 +190,7 @@ iommufd_cdev_connect_and_bind(int iommufd, const
>> char *name, int devfd, int devi
>> iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
>> iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int
>> id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
>> iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) "
>> [iommufd=%d] Successfully detached %s"
>> +iommufd_cdev_rebuild_hwpt(int iommufd, int hwpt_id) " [iommufd=%d]
>> hwpt %d"
>> iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
>> iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new
>> IOMMUFD container with ioasid=%d"
>> iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int
>> num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>> index 148ce89..78af0d8 100644
>> --- a/hw/vfio/vfio-iommufd.h
>> +++ b/hw/vfio/vfio-iommufd.h
>> @@ -38,4 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>> bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>>                                        uint32_t ioas_id, Error **errp);
>>
>> +void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
>> +                               VFIOIOMMUFDContainer *container);
>> +
>> #endif /* HW_VFIO_VFIO_IOMMUFD_H */
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 1379b20..b98c247 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -24,6 +24,7 @@ typedef struct VFIODeviceCPR {
>>      bool reused;
>>      Error *mdev_blocker;
>>      Error *id_blocker;
>> +    uint32_t hwpt_id;
>> } VFIODeviceCPR;
>>
>> struct VFIOContainer;
>> --
>> 1.8.3.1
> 


