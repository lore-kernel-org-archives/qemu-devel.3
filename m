Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D701CC48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 01:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9zE-0004Dc-Rn; Mon, 05 Feb 2024 20:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rX9zC-0004DU-V7
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 20:10:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rX9z8-0003W1-BP
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 20:10:54 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415LFnrU018432; Tue, 6 Feb 2024 01:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=qo3Ku5ravU/z8SvTIf4yn/DpdJbVEK11TOLPAPcly2k=;
 b=DavfGRQSGEbwBfFbHJ131DmKsN1hdHXtt9D89de4N/3K1j6AcvJ8uAt6anPPl3Qdfe1I
 jaH6BSGmer6OgSnzX+BuSrTqs19Lc5VffB+wSXLaM3/agcrNUCGmRJAjPM77J98xlXyz
 o/rPUHzwH4H957Gf9YgFYy92pUrdcWH9ZIcIleeMVDQ7CvXP4wC0wMesU6nAib2HBy3t
 nTwvppNdEns2Ct3/1Jgp5yPTNv1sb4nVWMDfEX4AH3VsxX6iLpa5jcyouVdQUv1EI8RX
 xUcieXfLHfCs45K3wMeKebMV3ZMbVEnq5BY1SuJOeSxqEzDFShM6o9Tuv1y6DP7Ntp+Y Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcwhhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Feb 2024 01:10:44 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4160bEKi038362; Tue, 6 Feb 2024 01:10:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bx6bvag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Feb 2024 01:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeAmHoREA/CcvoVL5bSQNZ6FAzwkVQzqgY5IkXVdiICuTXI9GxG8gwevm685LUcpydltNe5Mvm5Q5V92bA53sZviXM9bylphdhqRpjXv16yuLs5tLwDTt5D87OcWdwNWhBzqFycNdNySfIwPE/w5n6EGPUjz4mJWE5HCuHZa8tb4UH35NqOW72fLce4KK7FtnjlpkzUp1jlvCttqCSrmog+Cu4MvO7mR+bTfMjGbQFKDq/gczi+JnZ1QyAHNF3MnCmHh4gkd92eYoQWvkHYZiiCVqO/QyPijd/m7pozBUMlnDQ2R+LUxc4NupJSCZM5uc6WkK5KfMkxmWr1s0GsO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo3Ku5ravU/z8SvTIf4yn/DpdJbVEK11TOLPAPcly2k=;
 b=d2XYBLdz34/QBZgGsk1eOJhvr0vxJwgW19dyMhOk+aC+IvLD8+u15W8HVc8ytt9J/lh+H/fni4gu0otdChZwpTQJr2OjeX4mpU0Ylgh6e+hzpupH3sW5Q7KjpTtwOix9R7/WUK3NFbcpPKrP5HJQjPa7AtwKHXcQJh4kt2Mw+T8A7U3E0aprmSvyYJntGOBYu/7fmlMKU5q2toGpyQgEqZpMzVg65ybE+17AYP4V0csHUXpERnYLCYxK+ZdE4Ye+246LHW4NnTsoZV1mNmL3YC8nc7RkOF/HdKCQVOdoWNRqFYo63NRFAB6uODrZ3EvB7jjqyzZQiW+3MzZ5qjSoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo3Ku5ravU/z8SvTIf4yn/DpdJbVEK11TOLPAPcly2k=;
 b=PwKzX9fzL66eIj6wBf6lJceZZiYBigEc+ZxIz1bzgOi5nUWbsiatoKkapxbIh45De4vnUgld6depj2K/W/YUAAio3F86QIa/ROQ+N9fYxnRYAXvkTm15ljkeniaWj1sdh7O03G71qKiyxw3ufD+1bs6DNekNk60g02PSNxseLh8=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 01:10:40 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::9374:8c76:f77a:28a7]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::9374:8c76:f77a:28a7%5]) with mapi id 15.20.7249.027; Tue, 6 Feb 2024
 01:10:40 +0000
Content-Type: multipart/mixed; boundary="------------JlmWQTQaDzUpNfn6CzrGiMiW"
Message-ID: <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
Date: Mon, 5 Feb 2024 17:10:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240201180924.487579-7-eperezma@redhat.com>
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|PH0PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8e2385-ae35-44ab-b777-08dc26b06f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BtDrY8o8BoRZkxqAHuO5l5ECyTxEPG+raoaZG7P4KlfVV3/VrJXrmP4/dEIqXX50YsJwDIXo9vDik8tFRI+KAkormvJEnMGzm1MZ8t0KQghI5DPFRi6h/eo4pJprmn/kbIB3DkxoZjhF49Ff7w9wCmjInrqALfERXehVwiNjJ9h90jtH7UbKc9DT6NHMQO3mzl0QUcDuv4vapJLFs4jIaJEftzdUZE03XTOjp9BCwNvOIg3z4Wto/zxeEB/VzX3APAERAOybqZrhLsimJSUxD0Ow/mUvbHGLqR8itIwnpoL+42SR8PYR6lubSdZjgJY6lvNG93dHzR0pwS8Ekj36aQyctlQF1Sm52nVtNGu/f3s5pRpughUODE5T6K/L6Gf/Es1gtPWJuUEykM573x2s554ybNP8n8555hMYledDMhmGx7kp59C+1J2IebwTKVzv8YKH99nJIpbqKzl3hMXG135o7/o5UiGdveq4WEcfKaeJ4kiKy2IPFoy8CcapkQjy+GhzC1nfYZKbWSOA63BZU+kJ44DYwRoxef8NG4EHMexOLwI/FnWFaxgDyIM+Vwe+I8jieKS+bchMNIXE3MiDC9NkVKCvmBdylT6i8YeDZVMeWA0T/pv316JJXPQHBmTrIYdt9FvBbO+fVsTiiSgCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6519.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(41300700001)(86362001)(6512007)(478600001)(6486002)(53546011)(33964004)(31696002)(36756003)(36916002)(21480400003)(4326008)(66574015)(2616005)(83380400001)(26005)(66556008)(66946007)(54906003)(5660300002)(2906002)(6506007)(66476007)(316002)(6666004)(7416002)(235185007)(8936002)(38100700002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtONWhoMXE1MEVDTFA4YmsxeXl3Vit2TTVhcVVyN2pob05LZkZKNlE4ZVFB?=
 =?utf-8?B?cGdMeC9FVk5FdS84UWpuRXZTanBTRC9vZ0xYVHptei8vS0xabnVlQzdGUkU5?=
 =?utf-8?B?YTlvWnhGOTRDaG15R21QT2pONXN2TlBxbG50MHpnbTlPaVR1Sys2VEh3TkRk?=
 =?utf-8?B?Q2I3TUpRTGM5NVR5M3ExL1VQeUIvYnVtSFBoV2w0bWtZTnB0NExJQU1uTVl3?=
 =?utf-8?B?YXZ5ZW5pOVMrRUhZZzdWcWZweWFiZkxHYndJVFFxREo3ZytnYjhzYWh2WEpj?=
 =?utf-8?B?dG16eXh2VWMrTC9qM2dVdGpJbDFTZmlZMUtMdlBWT0FBaVFSYXhZLzJRQk1Q?=
 =?utf-8?B?L3E3OEswc1c2amErTEhHWTdpOEFyaDRKWmkveDJUNVcwbVFnVzBXVEVUVTdY?=
 =?utf-8?B?RWUxOU5GNnNRREwweUR1ek9uZHpzRFR0ajVRa1dxR3JjdFQ5VTlQMCtLYkpk?=
 =?utf-8?B?bi9RRkdqMzJwaVE4MDkvK01lRzhIZDhqS0wxcnBNdUxyVDh1cHpFUDkwNFp1?=
 =?utf-8?B?Z09JNmdsdS9YdXF5TVJBUXYvQitURDlwNVRpNmdld1hsTTRtYWVlVUY1dlIw?=
 =?utf-8?B?WitzVFNoUEovbUVDdTJNVUI5QkFvZ3pjdDZwRXJKTWZZNlBQcld5cW9kRU55?=
 =?utf-8?B?bnFzRVdFaWpPRzFuYklDSlJuekFRM2RvOUhKOTlESkJWYlhQeXVoMXZnY1JD?=
 =?utf-8?B?MUJkWXFGZDBHUXhGMm14OSs4eCtXTDNyR2IybERKS1pFZDR3RjhCeUJSTDNR?=
 =?utf-8?B?QkNPMk1Tb0hzQTh6NUR5T2tqRnhzZVlZSERhalc1NU5TejV4WTZHeElDWXR4?=
 =?utf-8?B?UmU2aTRWU1FieHNheHlEbmtQL3FNRVUrZldtb0VMV3hDdzdMMy91cVRZZnRN?=
 =?utf-8?B?R1dhNU84a01sYnU0Rm9WTjAwbWtwZXE1T1R3elJjYzhNbHlKQ2g2bWhwMnIr?=
 =?utf-8?B?ejlpdlJqa1lpS3dzSjFtNkU3MUxiMHU3N0EzRDA4YTFnWGFsZUJHYldlTEhn?=
 =?utf-8?B?SWxuSDdMdWZMcmlhSWs2M2U2NXN4SzcyN0tMT1BxcFhjMjh0bWpCSDZpRzhN?=
 =?utf-8?B?ZHdUNVZYVzhITzBzMEpmNkxBenBWZHFyemEzUHhyd0k4UFM0WkFiMEVLdnZJ?=
 =?utf-8?B?SFZES3ZkNGQzQkE2cDNPdlpPQW8ybUhUTzVXWW9DOElTeFFMOGZxbzlIeXZS?=
 =?utf-8?B?V0cyTGN5azR0NFp1NzlCV2hPeTRPUVZGWCtuMWhTNWIwTEExTHJYMmxaZ2RU?=
 =?utf-8?B?ZG50WDRaWTVGSllRVWpnZFRIazlhdktJdW0xMDVHRjlza3B6bHBqaFUxWEdN?=
 =?utf-8?B?NmxkNUZKNW9kWE92MTVpWkFRWERwZVVIdGF2eEdtMkZ3SThac05LT3dwMklL?=
 =?utf-8?B?ODB0L2RiN2hQTlFKSDhHVDZPN082VTBHRkhlRmh0dkNSc1F2SkU4YWFLN3BN?=
 =?utf-8?B?bGdyYkw0UE1ZUk9HcU4rdDFOUEJvZUYzdWVNbk04L0FLMlNDSmt4QWEyTS82?=
 =?utf-8?B?ZTAzR3FFZ2lyZ3BvcG9JK1JBaXRQcDFZTGx2cTRJOHNYYVF3SmJPM0pyemZp?=
 =?utf-8?B?MkxpbkZ5a2x6MGdKeUk4aDlTTzBwUGRQcHZGMmFvank2Yjlzc2l1RENGY3Qv?=
 =?utf-8?B?RTFUdnR2UHJKV2JwYTk4WEN2b3RHOVhTS1BtWGs2WWRzRTY1WldqTjFRcHRU?=
 =?utf-8?B?NHBhM0dMQUUvRm5PSHJXTVBja254cWdRZ291YkRJc2dTYkVCWG9jMmpFWE9J?=
 =?utf-8?B?azBlRW85cDIrQzd6VERiVjc0dXhTaXFuS1pTZGJSOS9MS0dwMTVjV0x2cGlH?=
 =?utf-8?B?ODJMTVZDQ1Y5VUJnMkREdTFxamJ0N0dUNGtpUmpVcG9jc1ZKVzRuRGMwS1Ny?=
 =?utf-8?B?UWdWdWs3VjBJUUpaMm1GMk9uS1JtYStKWjBaMTUwSGYxZzhwRFRHTW4vTkc4?=
 =?utf-8?B?cGg5bHVsLzhrM2lZelpCVDF4Z1RuR3lyQzNSd3I4YUQyVmVsZlg3c29iY1hP?=
 =?utf-8?B?bnN2VjJTd2JYK2p2WFVLV25iZWJsT3RkVHMwZGpoanZWUE1jNWRFa2hPVzkr?=
 =?utf-8?B?bkZxNXZVZ25KY1lpNTFkYmNQdHlTeThMWUlvd2dkcDB3R1BzaDNqTEFMd0VG?=
 =?utf-8?Q?haDMOerMSUULMYfNbEUdCOpkS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WgXO4df+KMJ/oZ8gLEzl7IHFyFkunMVUGWCbdEfhbhrSJWWzDyh6py1Q2IPwtE+dioW20W7/dhMmzsbCfRmHXhYCUijr8RC/QSi75sjOgVRG1ExAUa9rwd+SqAPxnnWBoLtnUsun/WMnG0lk2VB8M8dOSsh9upKedq2eOlvaee9X7+1vbDX+W6PUj7ZFoc+zDzZmMBtUENBijnHGzlIbWjGxoS2TasA8q6rfQ7YCG5d4hDT6bQ6jF0/kb1/V57cwICawf8SjGykH6GdYFp/47gkyKGoRYmDY7P1rz12oOYWSXXSVuHhLnsJ+ajshPTwK/PVfrpGoSKVAfo+LstIAVIJZVyAGnOp4D8VHd4QWviP/hS+Fxvh0tCZ7d7ImOZ3UOfqQndx+5blogL5KY/zf+AMCQpuUHxtV2hFGUAgZ0s4cGag1TT5B92VjrC1WzQTUavYaiJ79aCP9q8OO/tFPlqkp/f5R4bcjDFVK0cQv+ndQDVh+WVwaxxU/yZZ1JVmVubt4Un3XfpaaU7ECIfXMAEf4atY+rUfCE++wmnt1xBZSafZRmmQjI8qHcHPnxBKoW6KiOSroMwIKMyxbQvcoSzxKJJrkxIwQNkAKlprYsF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8e2385-ae35-44ab-b777-08dc26b06f6a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 01:10:40.6307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8Yys0WEEM7mYSDGH4+scbo55/bmEY196iVaHWxLBL1U2BLyXf8JHTymNoJ081pjTyWwyBjED30vBhbxDOg9dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060006
X-Proofpoint-GUID: GKTOJugQnFMfpp-EiN4teG6TenyFoPCg
X-Proofpoint-ORIG-GUID: GKTOJugQnFMfpp-EiN4teG6TenyFoPCg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--------------JlmWQTQaDzUpNfn6CzrGiMiW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eugenio,

I thought this new code looks good to me and the original issue I saw 
with x-svq=on should be gone. However, after rebase my tree on top of 
this, there's a new failure I found around setting up guest mappings at 
early boot, please see attached the specific QEMU config and 
corresponding event traces. Haven't checked into the detail yet, 
thinking you would need to be aware of ahead.

Regards,
-Siwei

On 2/1/2024 10:09 AM, Eugenio Pérez wrote:
> As we are moving to keep the mapping through all the vdpa device life
> instead of resetting it at VirtIO reset, we need to move all its
> dependencies to the initialization too.  In particular devices with
> x-svq=on need a valid iova_tree from the beginning.
>
> Simplify the code also consolidating the two creation points: the first
> data vq in case of SVQ active and CVQ start in case only CVQ uses it.
>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   include/hw/virtio/vhost-vdpa.h | 16 ++++++++++++++-
>   net/vhost-vdpa.c               | 36 +++-------------------------------
>   2 files changed, 18 insertions(+), 34 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
> index 03ed2f2be3..ad754eb803 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -37,7 +37,21 @@ typedef struct vhost_vdpa_shared {
>       struct vhost_vdpa_iova_range iova_range;
>       QLIST_HEAD(, vdpa_iommu) iommu_list;
>   
> -    /* IOVA mapping used by the Shadow Virtqueue */
> +    /*
> +     * IOVA mapping used by the Shadow Virtqueue
> +     *
> +     * It is shared among all ASID for simplicity, whether CVQ shares ASID with
> +     * guest or not:
> +     * - Memory listener need access to guest's memory addresses allocated in
> +     *   the IOVA tree.
> +     * - There should be plenty of IOVA address space for both ASID not to
> +     *   worry about collisions between them.  Guest's translations are still
> +     *   validated with virtio virtqueue_pop so there is no risk for the guest
> +     *   to access memory that it shouldn't.
> +     *
> +     * To allocate a iova tree per ASID is doable but it complicates the code
> +     * and it is not worth it for the moment.
> +     */
>       VhostIOVATree *iova_tree;
>   
>       /* Copy of backend features */
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index cc589dd148..57edcf34d0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -232,6 +232,7 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
>           return;
>       }
>       qemu_close(s->vhost_vdpa.shared->device_fd);
> +    g_clear_pointer(&s->vhost_vdpa.shared->iova_tree, vhost_iova_tree_delete);
>       g_free(s->vhost_vdpa.shared);
>   }
>   
> @@ -329,16 +330,8 @@ static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
>   
>   static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>   {
> -    struct vhost_vdpa *v = &s->vhost_vdpa;
> -
>       migration_add_notifier(&s->migration_state,
>                              vdpa_net_migration_state_notifier);
> -
> -    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
> -    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
> -        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
> -                                                   v->shared->iova_range.last);
> -    }
>   }
>   
>   static int vhost_vdpa_net_data_start(NetClientState *nc)
> @@ -383,19 +376,12 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
>   static void vhost_vdpa_net_client_stop(NetClientState *nc)
>   {
>       VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
> -    struct vhost_dev *dev;
>   
>       assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>   
>       if (s->vhost_vdpa.index == 0) {
>           migration_remove_notifier(&s->migration_state);
>       }
> -
> -    dev = s->vhost_vdpa.dev;
> -    if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
> -        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
> -                        vhost_iova_tree_delete);
> -    }
>   }
>   
>   static NetClientInfo net_vhost_vdpa_info = {
> @@ -557,24 +543,6 @@ out:
>           return 0;
>       }
>   
> -    /*
> -     * If other vhost_vdpa already have an iova_tree, reuse it for simplicity,
> -     * whether CVQ shares ASID with guest or not, because:
> -     * - Memory listener need access to guest's memory addresses allocated in
> -     *   the IOVA tree.
> -     * - There should be plenty of IOVA address space for both ASID not to
> -     *   worry about collisions between them.  Guest's translations are still
> -     *   validated with virtio virtqueue_pop so there is no risk for the guest
> -     *   to access memory that it shouldn't.
> -     *
> -     * To allocate a iova tree per ASID is doable but it complicates the code
> -     * and it is not worth it for the moment.
> -     */
> -    if (!v->shared->iova_tree) {
> -        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
> -                                                   v->shared->iova_range.last);
> -    }
> -
>       r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
>                                  vhost_vdpa_net_cvq_cmd_page_len(), false);
>       if (unlikely(r < 0)) {
> @@ -1674,6 +1642,8 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>           s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
>           s->vhost_vdpa.shared->iova_range = iova_range;
>           s->vhost_vdpa.shared->shadow_data = svq;
> +        s->vhost_vdpa.shared->iova_tree = vhost_iova_tree_new(iova_range.first,
> +                                                              iova_range.last);
>       } else if (!is_datapath) {
>           s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
>                                        PROT_READ | PROT_WRITE,

--------------JlmWQTQaDzUpNfn6CzrGiMiW
Content-Type: text/plain; charset=UTF-8; name="qtrace-fail-map.out"
Content-Disposition: attachment; filename="qtrace-fail-map.out"
Content-Transfer-Encoding: base64

KyBxZW11LXN5c3RlbS14ODZfNjQgLW5vLXVzZXItY29uZmlnIC1ub2RlZmF1bHRzIC1tYWNoaW5l
IHR5cGU9cGMtcTM1LTguMCxkdW1wLWd1ZXN0LWNvcmU9b2ZmLGFjY2VsPWt2bSxrZXJuZWxfaXJx
Y2hpcD1zcGxpdCAtY3B1IEVQWUMgLXNtcCA4LHNvY2tldHM9MSxjb3Jlcz04LHRocmVhZHM9MSAt
bSBzaXplPTEyOEcsc2xvdHM9OCxtYXhtZW09MjU2RyAtcW1wIHVuaXg6L3RtcC9xLHNlcnZlcixu
b3dhaXQgLXNlcmlhbCBtb246c3RkaW8gLWRpc3BsYXkgdm5jPTozNyAtZHJpdmUgZmlsZT0vdXNy
L3NoYXJlL09WTUYvT1ZNRl9DT0RFLnB1cmUtZWZpLmZkLGluZGV4PTAsaWY9cGZsYXNoLGZvcm1h
dD1yYXcscmVhZG9ubHk9b24gLWRyaXZlIGZpbGU9L3Vzci9zaGFyZS9PVk1GL09WTUZfVkFSUy5w
dXJlLWVmaS5mZCxpbmRleD0xLGlmPXBmbGFzaCxmb3JtYXQ9cmF3IC1kcml2ZSBpZD1kaXNrMCxp
Zj1ub25lLGZvcm1hdD1xY293MixmaWxlPS9yb290L3ZkcGEvdG9vbHMvaW1hZ2VzL1ZNLWVsNy45
LXVlZmkteDg2XzY0LnFjb3cyIC1kZXZpY2UgdmlydGlvLWJsay1wY2ksZHJpdmU9ZGlzazAgLW5l
dGRldiB0eXBlPXZob3N0LXZkcGEsdmhvc3RkZXY9L2Rldi92aG9zdC12ZHBhLTAsaWQ9dmhvc3Qt
dmRwYTAseC1zdnE9b24gLWRldmljZSB2aXJ0aW8tbmV0LXBjaSxuZXRkZXY9dmhvc3QtdmRwYTAs
aWQ9dmRwYTAsYm9vdGluZGV4PS0xLHBhZ2UtcGVyLXZxPW9uLG1hYz1lNDoxMTpjNjpkMzo0NTpm
MCxjdHJsX3ZxPW9uLG1xPW9uLGN0cmxfdmxhbj1vZmYsdmVjdG9ycz02LGhvc3RfbXR1PTkwMDAs
ZGlzYWJsZS1sZWdhY3k9b24gLW1zZyB0aW1lc3RhbXA9b24gLS10cmFjZSBldmVudHM9L3RtcC9l
CjU1Njc0QDE3MDY4NTQ4MzguMTMzODc3OnZob3N0X3ZkcGFfaW5pdCBkZXY6IDB4NTU2ZDQ1OWU2
ZTAwLCBjb21tb24gZGV2OiAweDU1NmQ0NWM3NTE0MCB2ZHBhOiAweDdmOTkxYzg2MDE5MAo1NTY3
NEAxNzA2ODU0ODM4LjEzMzkwMTp2aG9zdF92ZHBhX2FkZF9zdGF0dXMgZGV2OiAweDU1NmQ0NTll
NmUwMCBzdGF0dXM6IDB4Mwo1NTY3NEAxNzA2ODU0ODM4LjEzMzkwNjp2aG9zdF92ZHBhX3NldF9v
d25lciBkZXY6IDB4NTU2ZDQ1OWU2ZTAwCjU1Njc0QDE3MDY4NTQ4MzguMTMzOTIyOnZob3N0X3Zk
cGFfZ2V0X2ZlYXR1cmVzIGRldjogMHg1NTZkNDU5ZTZlMDAgZmVhdHVyZXM6IDB4MzAwYzMxODJi
CjU1Njc0QDE3MDY4NTQ4MzguMTMzOTI0OnZob3N0X3ZkcGFfbWVtc2xvdHNfbGltaXQgZGV2OiAw
eDU1NmQ0NTllNmUwMCA9IDB4N2ZmZmZmZmYKNTU2NzRAMTcwNjg1NDgzOC4xMzM5Mjc6dmhvc3Rf
dmRwYV9nZXRfdnFfaW5kZXggZGV2OiAweDU1NmQ0NTllNmUwMCBpZHg6IDAgdnEgaWR4OiAwCjU1
Njc0QDE3MDY4NTQ4MzguMTMzOTMzOnZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4IGRldjogMHg1NTZk
NDU5ZTZlMDAgaWR4OiAxIHZxIGlkeDogMQo1NTY3NEAxNzA2ODU0ODM4LjEzMzkzOTp2aG9zdF92
ZHBhX2dldF9kZXZpY2VfaWQgZGV2OiAweDU1NmQ0NTllNmUwMCBkZXZpY2VfaWQgMQo1NTY3NEAx
NzA2ODU0ODM4LjEzMzk1NDp2aG9zdF92ZHBhX2luaXQgZGV2OiAweDU1NmQ0NWM1ZTY3MCwgY29t
bW9uIGRldjogMHg1NTZkNDVjNzUxNDAgdmRwYTogMHg3Zjk5MWM2ZDcxOTAKNTU2NzRAMTcwNjg1
NDgzOC4xMzM5NTk6dmhvc3RfdmRwYV9nZXRfZmVhdHVyZXMgZGV2OiAweDU1NmQ0NWM1ZTY3MCBm
ZWF0dXJlczogMHgzMDBjMzE4MmIKNTU2NzRAMTcwNjg1NDgzOC4xMzM5NjE6dmhvc3RfdmRwYV9t
ZW1zbG90c19saW1pdCBkZXY6IDB4NTU2ZDQ1YzVlNjcwID0gMHg3ZmZmZmZmZgo1NTY3NEAxNzA2
ODU0ODM4LjEzMzk2Mzp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTU2ZDQ1YzVlNjcw
IGlkeDogMCB2cSBpZHg6IDAKNTU2NzRAMTcwNjg1NDgzOC4xMzM5Njc6dmhvc3RfdmRwYV9nZXRf
dnFfaW5kZXggZGV2OiAweDU1NmQ0NWM1ZTY3MCBpZHg6IDEgdnEgaWR4OiAxCjU1Njc0QDE3MDY4
NTQ4MzguMTMzOTcyOnZob3N0X3ZkcGFfZ2V0X2RldmljZV9pZCBkZXY6IDB4NTU2ZDQ1YzVlNjcw
IGRldmljZV9pZCAxCjU1Njc0QDE3MDY4NTQ4MzguMTQ0NzgyOnZob3N0X3ZkcGFfaW5pdCBkZXY6
IDB4NTU2ZDQ1YzVlYjkwLCBjb21tb24gZGV2OiAweDU1NmQ0NWM3NTE0MCB2ZHBhOiAweDdmOTkx
YzY4ZTE5MAo1NTY3NEAxNzA2ODU0ODM4LjE0NDc5MTp2aG9zdF92ZHBhX2dldF9mZWF0dXJlcyBk
ZXY6IDB4NTU2ZDQ1YzVlYjkwIGZlYXR1cmVzOiAweDMwMGMzMTgyYgo1NTY3NEAxNzA2ODU0ODM4
LjE0NDc5Mzp2aG9zdF92ZHBhX21lbXNsb3RzX2xpbWl0IGRldjogMHg1NTZkNDVjNWViOTAgPSAw
eDdmZmZmZmZmCjU1Njc0QDE3MDY4NTQ4MzguMTQ0Nzk2OnZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4
IGRldjogMHg1NTZkNDVjNWViOTAgaWR4OiAwIHZxIGlkeDogMAo1NTY3NEAxNzA2ODU0ODM4LjE0
NDgwMjp2aG9zdF92ZHBhX2dldF9kZXZpY2VfaWQgZGV2OiAweDU1NmQ0NWM1ZWI5MCBkZXZpY2Vf
aWQgMQo1NTY3NEAxNzA2ODU0ODM4LjE1NDM5NDp2aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9h
ZGQgdmRwYTogMHg1NTZkNDVjNzUxNDAgaW92YSAweDAgbGxlbmQgMHg4MDAwMDAwMCB2YWRkcjog
MHg3Zjc5MDNlMDAwMDAgcmVhZC1vbmx5OiAwCjU1Njc0QDE3MDY4NTQ4MzguMTU0NDE5OnZob3N0
X3ZkcGFfbGlzdGVuZXJfYmVnaW5fYmF0Y2ggdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6
IDE2IG1zZ190eXBlOiAyIHR5cGU6IDUKNTU2NzRAMTcwNjg1NDgzOC4xNTQ0Mjc6dmhvc3RfdmRw
YV9kbWFfbWFwIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBh
c2lkOiAwIGlvdmE6IDB4MTAwMCBzaXplOiAweDgwMDAwMDAwIHVhZGRyOiAweDdmNzkwM2UwMDAw
MCBwZXJtOiAweDMgdHlwZTogMgo1NTY3NEAxNzA2ODU0ODM4LjMyMDc4Mzp2aG9zdF92ZHBhX2xp
c3RlbmVyX2NvbW1pdCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6
IDIgdHlwZTogNgo1NTY3NEAxNzA2ODU0ODM4LjMyMjgzNDp2aG9zdF92ZHBhX2xpc3RlbmVyX3Jl
Z2lvbl9hZGQgdmRwYTogMHg1NTZkNDVjNzUxNDAgaW92YSAweDEwMDAwMDAwMCBsbGVuZCAweDIw
ODAwMDAwMDAgdmFkZHI6IDB4N2Y3OTgzZTAwMDAwIHJlYWQtb25seTogMAo1NTY3NEAxNzA2ODU0
ODM4LjMyMjg0NDp2aG9zdF92ZHBhX2xpc3RlbmVyX2JlZ2luX2JhdGNoIHZkcGFfc2hhcmVkOjB4
NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiB0eXBlOiA1CjU1Njc0QDE3MDY4NTQ4Mzgu
MzIyODQ4OnZob3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDog
MTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDgwMDAxMDAwIHNpemU6IDB4MWY4MDAwMDAw
MCB1YWRkcjogMHg3Zjc5ODNlMDAwMDAgcGVybTogMHgzIHR5cGU6IDIKNTU2NzRAMTcwNjg1NDg0
OC43ODI3MDk6dmhvc3RfdmRwYV9saXN0ZW5lcl9jb21taXQgdmRwYV9zaGFyZWQ6MHg1NTZkNDVj
NzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIHR5cGU6IDYKNTU2NzRAMTcwNjg1NDg0OC44NjQxNzM6
dmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fYWRkIHZkcGE6IDB4NTU2ZDQ1Yzc1MTQwIGlvdmEg
MHhmZWRhMDAwMCBsbGVuZCAweGZlZGMwMDAwIHZhZGRyOiAweDdmNzkwM2VhMDAwMCByZWFkLW9u
bHk6IDAKNTU2NzRAMTcwNjg1NDg0OC44NjQxOTc6dmhvc3RfdmRwYV9saXN0ZW5lcl9iZWdpbl9i
YXRjaCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTog
NQo1NTY3NEAxNzA2ODU0ODQ4Ljg2NDIwMzp2aG9zdF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFyZWQ6
MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHgyMDAwMDAx
MDAwIHNpemU6IDB4MjAwMDAgdWFkZHI6IDB4N2Y3OTAzZWEwMDAwIHBlcm06IDB4MyB0eXBlOiAy
CjU1Njc0QDE3MDY4NTQ4NDguODY0MjIxOnZob3N0X3ZkcGFfbGlzdGVuZXJfY29tbWl0IHZkcGFf
c2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiB0eXBlOiA2CjU1Njc0QDE3
MDY4NTQ4NDguOTY0ODQ2OnZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX2RlbCB2ZHBhOiAweDU1
NmQ0NWM3NTE0MCBpb3ZhIDB4ZmVkYTAwMDAgbGxlbmQgMHhmZWRiZmZmZgo1NTY3NEAxNzA2ODU0
ODQ4Ljk2NDg3Mzp2aG9zdF92ZHBhX2xpc3RlbmVyX2JlZ2luX2JhdGNoIHZkcGFfc2hhcmVkOjB4
NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiB0eXBlOiA1CjU1Njc0QDE3MDY4NTQ4NDgu
OTY0ODc4OnZob3N0X3ZkcGFfZG1hX3VubWFwIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZk
OiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4MTAwMCBzaXplOiAweDIwMDAwIHR5cGU6
IDMKNTU2NzRAMTcwNjg1NDg0OC45NjQ5MzI6dmhvc3RfdmRwYV9saXN0ZW5lcl9jb21taXQgdmRw
YV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIHR5cGU6IDYKNTU2NzRA
MTcwNjg1NDg0OS4wNjg1NTU6dmhvc3RfdmRwYV9zZXRfY29uZmlnIGRldjogMHg1NTZkNDU5ZTZl
MDAgb2Zmc2V0OiAwIHNpemU6IDYgZmxhZ3M6IDB4MAo1NTY3NEAxNzA2ODU0ODQ5LjA2ODU3OTp2
aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRldjogMHg1NTZkNDU5ZTZlMDAgMDAwMDogIGU0IDExIGM2
IGQzICA0NSBmMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCjU1Njc0QDE3MDY4NTQ4
NDkuMDgwNDUyOnZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX2RlbCB2ZHBhOiAweDU1NmQ0NWM3
NTE0MCBpb3ZhIDB4MCBsbGVuZCAweDdmZmZmZmZmCjU1Njc0QDE3MDY4NTQ4NDkuMDgwNDg5OnZo
b3N0X3ZkcGFfbGlzdGVuZXJfYmVnaW5fYmF0Y2ggdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAg
ZmQ6IDE2IG1zZ190eXBlOiAyIHR5cGU6IDUKNTU2NzRAMTcwNjg1NDg0OS4wODA0OTc6dmhvc3Rf
dmRwYV9kbWFfdW5tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBl
OiAyIGFzaWQ6IDAgaW92YTogMHgyMDAwMDAxMDAwIHNpemU6IDB4ODAwMDAwMDAgdHlwZTogMwo1
NTY3NEAxNzA2ODU0ODQ5LjA4MDUxMzp2aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9hZGQgdmRw
YTogMHg1NTZkNDVjNzUxNDAgaW92YSAweDAgbGxlbmQgMHhjMDAwMCB2YWRkcjogMHg3Zjc5MDNl
MDAwMDAgcmVhZC1vbmx5OiAwCjU1Njc0QDE3MDY4NTQ4NDkuMDgwNTE3OnZob3N0X3ZkcGFfZG1h
X21hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDog
MCBpb3ZhOiAweDEwMDAgc2l6ZTogMHhjMDAwMCB1YWRkcjogMHg3Zjc5MDNlMDAwMDAgcGVybTog
MHgzIHR5cGU6IDIKNTU2NzRAMTcwNjg1NDg0OS4wODA1MzI6dmhvc3RfdmRwYV9saXN0ZW5lcl9y
ZWdpb25fYWRkIHZkcGE6IDB4NTU2ZDQ1Yzc1MTQwIGlvdmEgMHhjMDAwMCBsbGVuZCAweGUwMDAw
IHZhZGRyOiAweDdmNzkwMmUwMDAwMCByZWFkLW9ubHk6IDEKNTU2NzRAMTcwNjg1NDg0OS4wODA1
MzY6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBt
c2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4YzEwMDAgc2l6ZTogMHgyMDAwMCB1YWRkcjogMHg3
Zjc5MDJlMDAwMDAgcGVybTogMHgxIHR5cGU6IDIKNTU2NzRAMTcwNjg1NDg0OS4wODA2Njk6dmhv
c3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fYWRkIHZkcGE6IDB4NTU2ZDQ1Yzc1MTQwIGlvdmEgMHhl
MDAwMCBsbGVuZCAweDEwMDAwMCB2YWRkcjogMHg3Zjk5MDgyMDAwMDAgcmVhZC1vbmx5OiAxCjU1
Njc0QDE3MDY4NTQ4NDkuMDgwNjczOnZob3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDoweDU1
NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweGUxMDAwIHNpemU6
IDB4MjAwMDAgdWFkZHI6IDB4N2Y5OTA4MjAwMDAwIHBlcm06IDB4MSB0eXBlOiAyCjU1Njc0QDE3
MDY4NTQ4NDkuMDgwNjk3OnZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX2FkZCB2ZHBhOiAweDU1
NmQ0NWM3NTE0MCBpb3ZhIDB4MTAwMDAwIGxsZW5kIDB4ODAwMDAwMDAgdmFkZHI6IDB4N2Y3OTAz
ZjAwMDAwIHJlYWQtb25seTogMAo1NTY3NEAxNzA2ODU0ODQ5LjA4MDcwMDp2aG9zdF92ZHBhX2Rt
YV9tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6
IDAgaW92YTogMHgxMDEwMDAgc2l6ZTogMHg3ZmYwMDAwMCB1YWRkcjogMHg3Zjc5MDNmMDAwMDAg
cGVybTogMHgzIHR5cGU6IDIKMjAyNC0wMi0wMlQwNjoyMDo0OS4wODA3MDZaIHFlbXUtc3lzdGVt
LXg4Nl82NDogZmFpbGVkIHRvIHdyaXRlLCBmZD0xNiwgZXJybm89MTQgKEJhZCBhZGRyZXNzKQoy
MDI0LTAyLTAyVDA2OjIwOjQ5LjA4MDczMlogcWVtdS1zeXN0ZW0teDg2XzY0OiB2aG9zdCB2ZHBh
IG1hcCBmYWlsIQoyMDI0LTAyLTAyVDA2OjIwOjQ5LjA4MDc0MlogcWVtdS1zeXN0ZW0teDg2XzY0
OiB2aG9zdC12ZHBhOiBETUEgbWFwcGluZyBmYWlsZWQsIHVuYWJsZSB0byBjb250aW51ZQo1NTY3
NEAxNzA2ODU0ODQ5LjA4MDc1Nzp2aG9zdF92ZHBhX2xpc3RlbmVyX2NvbW1pdCB2ZHBhX3NoYXJl
ZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNgo1NTY4MEAxNzA2ODU0
ODUxLjQ4NDU4NDp2aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9hZGQgdmRwYTogMHg1NTZkNDVj
NzUxNDAgaW92YSAweGMwMDAwMDAwIGxsZW5kIDB4YzAwNDAwMDAgdmFkZHI6IDB4N2Y3OTAyYzAw
MDAwIHJlYWQtb25seTogMQo1NTY4MEAxNzA2ODU0ODUxLjQ4NDYxMjp2aG9zdF92ZHBhX2xpc3Rl
bmVyX2JlZ2luX2JhdGNoIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlw
ZTogMiB0eXBlOiA1CjU1NjgwQDE3MDY4NTQ4NTEuNDg0NjIwOnZob3N0X3ZkcGFfZG1hX21hcCB2
ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3Zh
OiAweDEwMTAwMCBzaXplOiAweDQwMDAwIHVhZGRyOiAweDdmNzkwMmMwMDAwMCBwZXJtOiAweDEg
dHlwZTogMgo1NTY4MEAxNzA2ODU0ODUxLjQ4NDY2Njp2aG9zdF92ZHBhX2xpc3RlbmVyX2NvbW1p
dCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNgo1
NTY4MEAxNzA2ODU0ODUxLjU4MjI5OTp2aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9kZWwgdmRw
YTogMHg1NTZkNDVjNzUxNDAgaW92YSAweGMwMDAwMDAwIGxsZW5kIDB4YzAwM2ZmZmYKNTU2ODBA
MTcwNjg1NDg1MS41ODIzMjk6dmhvc3RfdmRwYV9saXN0ZW5lcl9iZWdpbl9iYXRjaCB2ZHBhX3No
YXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNQo1NTY4MEAxNzA2
ODU0ODUxLjU4MjMzNTp2aG9zdF92ZHBhX2RtYV91bm1hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3
NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDEwMTAwMCBzaXplOiAweDQw
MDAwIHR5cGU6IDMKNTU2ODBAMTcwNjg1NDg1MS41ODIzNDk6dmhvc3RfdmRwYV9saXN0ZW5lcl9j
b21taXQgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIHR5cGU6
IDYKNTU2ODBAMTcwNjg1NDg1MS43OTA4MDI6dmhvc3RfdmRwYV9nZXRfY29uZmlnIGRldjogMHg1
NTZkNDU5ZTZlMDAgY29uZmlnOiAweDdmOTkwYmI3OTQ2MCBjb25maWdfbGVuOiAxMgo1NTY4MEAx
NzA2ODU0ODUxLjc5MDgyODp2aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRldjogMHg1NTZkNDU5ZTZl
MDAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAgMDIgMDAgMjggMjMgICAgICAgICAg
ICAgCjU1NjgwQDE3MDY4NTQ4NTEuNzkwODM2OnZob3N0X3ZkcGFfZ2V0X2NvbmZpZyBkZXY6IDB4
NTU2ZDQ1OWU2ZTAwIGNvbmZpZzogMHg3Zjk5MGJiNzk0NjAgY29uZmlnX2xlbjogMTIKNTU2ODBA
MTcwNjg1NDg1MS43OTA4NDE6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBkZXY6IDB4NTU2ZDQ1OWU2
ZTAwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAwIDI4IDIzICAgICAgICAg
ICAgIAo1NTY4MEAxNzA2ODU0ODUxLjc5MDg1NTp2aG9zdF92ZHBhX2dldF9jb25maWcgZGV2OiAw
eDU1NmQ0NTllNmUwMCBjb25maWc6IDB4N2Y5OTBiYjc5NDYwIGNvbmZpZ19sZW46IDEyCjU1Njgw
QDE3MDY4NTQ4NTEuNzkwODYwOnZob3N0X3ZkcGFfZHVtcF9jb25maWcgZGV2OiAweDU1NmQ0NTll
NmUwMCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAxIDAwICAwMiAwMCAyOCAyMyAgICAgICAg
ICAgICAKNTU2ODBAMTcwNjg1NDg1MS43OTA4Njc6dmhvc3RfdmRwYV9nZXRfY29uZmlnIGRldjog
MHg1NTZkNDU5ZTZlMDAgY29uZmlnOiAweDdmOTkwYmI3OTQ2MCBjb25maWdfbGVuOiAxMgo1NTY4
MEAxNzA2ODU0ODUxLjc5MDg3Mjp2aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRldjogMHg1NTZkNDU5
ZTZlMDAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAgMDIgMDAgMjggMjMgICAgICAg
ICAgICAgCjU1NjgwQDE3MDY4NTQ4NTEuNzkwODc5OnZob3N0X3ZkcGFfZ2V0X2NvbmZpZyBkZXY6
IDB4NTU2ZDQ1OWU2ZTAwIGNvbmZpZzogMHg3Zjk5MGJiNzk0NjAgY29uZmlnX2xlbjogMTIKNTU2
ODBAMTcwNjg1NDg1MS43OTA4ODM6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBkZXY6IDB4NTU2ZDQ1
OWU2ZTAwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAwIDI4IDIzICAgICAg
ICAgICAgIAo1NTY4MEAxNzA2ODU0ODUxLjc5MDg5MDp2aG9zdF92ZHBhX2dldF9jb25maWcgZGV2
OiAweDU1NmQ0NTllNmUwMCBjb25maWc6IDB4N2Y5OTBiYjc5NDYwIGNvbmZpZ19sZW46IDEyCjU1
NjgwQDE3MDY4NTQ4NTEuNzkwODk1OnZob3N0X3ZkcGFfZHVtcF9jb25maWcgZGV2OiAweDU1NmQ0
NTllNmUwMCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAxIDAwICAwMiAwMCAyOCAyMyAgICAg
ICAgICAgICAKNTU2ODBAMTcwNjg1NDg1MS43OTA5MDI6dmhvc3RfdmRwYV9nZXRfY29uZmlnIGRl
djogMHg1NTZkNDU5ZTZlMDAgY29uZmlnOiAweDdmOTkwYmI3OTQ2MCBjb25maWdfbGVuOiAxMgo1
NTY4MEAxNzA2ODU0ODUxLjc5MDkwNjp2aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRldjogMHg1NTZk
NDU5ZTZlMDAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAgMDIgMDAgMjggMjMgICAg
ICAgICAgICAgCjU1NjgwQDE3MDY4NTQ4NTEuNzkwOTE3OnZob3N0X3ZkcGFfZ2V0X2NvbmZpZyBk
ZXY6IDB4NTU2ZDQ1OWU2ZTAwIGNvbmZpZzogMHg3Zjk5MGJiNzk0NjAgY29uZmlnX2xlbjogMTIK
NTU2ODBAMTcwNjg1NDg1MS43OTA5MjQ6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBkZXY6IDB4NTU2
ZDQ1OWU2ZTAwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAwIDI4IDIzICAg
ICAgICAgICAgIAo1NTY4MEAxNzA2ODU0ODUxLjc5MzQ2Nzp2aG9zdF92ZHBhX2dldF92cV9pbmRl
eCBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGlkeDogMCB2cSBpZHg6IDAKNTU2ODBAMTcwNjg1NDg1MS43
OTM0ODA6dmhvc3RfdmRwYV9nZXRfdnFfaW5kZXggZGV2OiAweDU1NmQ0NTllNmUwMCBpZHg6IDEg
dnEgaWR4OiAxCjU1NjgwQDE3MDY4NTQ4NTEuNzkzNTc4OnZob3N0X3ZkcGFfc2V0X2ZlYXR1cmVz
IGRldjogMHg1NTZkNDU5ZTZlMDAgZmVhdHVyZXM6IDB4MzAwMDAwMDA4CjU1NjgwQDE3MDY4NTQ4
NTEuNzkzNTg1OnZob3N0X3ZkcGFfYWRkX3N0YXR1cyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIHN0YXR1
czogMHg4CjU1NjgwQDE3MDY4NTQ4NTEuNzkzNTkwOnZob3N0X3ZkcGFfc2V0X21lbV90YWJsZSBk
ZXY6IDB4NTU2ZDQ1OWU2ZTAwIG5yZWdpb25zOiAzIHBhZGRpbmc6IDB4MAo1NTY4MEAxNzA2ODU0
ODUxLjc5MzU5Mzp2aG9zdF92ZHBhX2R1bXBfcmVnaW9ucyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIDA6
IGd1ZXN0X3BoeXNfYWRkcjogMHgwIG1lbW9yeV9zaXplOiAweGMwMDAwIHVzZXJzcGFjZV9hZGRy
OiAweDdmNzkwM2UwMDAwMCBmbGFnc19wYWRkaW5nOiAweDAKNTU2ODBAMTcwNjg1NDg1MS43OTM1
OTY6dmhvc3RfdmRwYV9kdW1wX3JlZ2lvbnMgZGV2OiAweDU1NmQ0NTllNmUwMCAxOiBndWVzdF9w
aHlzX2FkZHI6IDB4MTAwMDAwIG1lbW9yeV9zaXplOiAweDdmZjAwMDAwIHVzZXJzcGFjZV9hZGRy
OiAweDdmNzkwM2YwMDAwMCBmbGFnc19wYWRkaW5nOiAweDAKNTU2ODBAMTcwNjg1NDg1MS43OTM1
OTg6dmhvc3RfdmRwYV9kdW1wX3JlZ2lvbnMgZGV2OiAweDU1NmQ0NTllNmUwMCAyOiBndWVzdF9w
aHlzX2FkZHI6IDB4MTAwMDAwMDAwIG1lbW9yeV9zaXplOiAweDFmODAwMDAwMDAgdXNlcnNwYWNl
X2FkZHI6IDB4N2Y3OTgzZTAwMDAwIGZsYWdzX3BhZGRpbmc6IDB4MAo1NTY4MEAxNzA2ODU0ODUx
Ljc5MzYwMTp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGlkeDog
MCB2cSBpZHg6IDAKNTU2ODBAMTcwNjg1NDg1MS43OTM2MDQ6dmhvc3RfdmRwYV9zZXRfdnJpbmdf
bnVtIGRldjogMHg1NTZkNDU5ZTZlMDAgaW5kZXg6IDAgbnVtOiAyNTYKNTU2ODBAMTcwNjg1NDg1
MS43OTM2MTA6dmhvc3RfdmRwYV92cV9nZXRfYWRkciBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIHZxOiAw
eDU1NmQ0NTllNzA4MCBkZXNjX3VzZXJfYWRkcjogMHg3ZTQ1OTAwMCBhdmFpbF91c2VyX2FkZHI6
IDB4N2U0NWEwMDAgdXNlZF91c2VyX2FkZHI6IDB4N2U0NWIwMDAKNTU2ODBAMTcwNjg1NDg1MS43
OTM2MTY6dmhvc3RfdmRwYV9nZXRfdnFfaW5kZXggZGV2OiAweDU1NmQ0NTllNmUwMCBpZHg6IDEg
dnEgaWR4OiAxCjU1NjgwQDE3MDY4NTQ4NTEuNzkzNjE5OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX251
bSBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGluZGV4OiAxIG51bTogMjU2CjU1NjgwQDE3MDY4NTQ4NTEu
NzkzNjIzOnZob3N0X3ZkcGFfdnFfZ2V0X2FkZHIgZGV2OiAweDU1NmQ0NTllNmUwMCB2cTogMHg1
NTZkNDU5ZTcxMDAgZGVzY191c2VyX2FkZHI6IDB4N2U0NWQwMDAgYXZhaWxfdXNlcl9hZGRyOiAw
eDdlNDVlMDAwIHVzZWRfdXNlcl9hZGRyOiAweDdlNDVmMDAwCjU1NjgwQDE3MDY4NTQ4NTEuNzkz
NjMwOnZob3N0X3ZkcGFfZGV2X3N0YXJ0IGRldjogMHg1NTZkNDU5ZTZlMDAgc3RhcnRlZDogMQo1
NTY4MEAxNzA2ODU0ODUxLjc5MzYzMjp2aG9zdF92ZHBhX3NldF92cmluZ19iYXNlIGRldjogMHg1
NTZkNDU5ZTZlMDAgaW5kZXg6IDAgbnVtOiAwCjU1NjgwQDE3MDY4NTQ4NTEuNzkzNjM4OnZob3N0
X3ZkcGFfc2V0X3ZyaW5nX2tpY2sgZGV2OiAweDU1NmQ0NTllNmUwMCBpbmRleDogMCBmZDogNDkK
NTU2ODBAMTcwNjg1NDg1MS43OTM2NDM6dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbCBkZXY6IDB4
NTU2ZDQ1OWU2ZTAwIGluZGV4OiAwIGZkOiA1MAo1NTY4MEAxNzA2ODU0ODUxLjc5MzY3NTp2aG9z
dF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBl
OiAyIGFzaWQ6IDAgaW92YTogMHgxMDEwMDAgc2l6ZTogMHgyMDAwIHVhZGRyOiAweDdmOTkxYzgz
MTAwMCBwZXJtOiAweDEgdHlwZTogMgo1NTY4MEAxNzA2ODU0ODUxLjk4MzkzMjp2aG9zdF92ZHBh
X2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFz
aWQ6IDAgaW92YTogMHgxMDMwMDAgc2l6ZTogMHgxMDAwIHVhZGRyOiAweDdmOTkxY2EwYjAwMCBw
ZXJtOiAweDMgdHlwZTogMgo1NTY4MEAxNzA2ODU0ODUyLjA3ODE0Njp2aG9zdF92ZHBhX3NldF92
cmluZ19hZGRyIGRldjogMHg1NTZkNDU5ZTZlMDAgaW5kZXg6IDAgZmxhZ3M6IDB4MCBkZXNjX3Vz
ZXJfYWRkcjogMHgxMDEwMDAgdXNlZF91c2VyX2FkZHI6IDB4MTAzMDAwIGF2YWlsX3VzZXJfYWRk
cjogMHgxMDIwMDAgbG9nX2d1ZXN0X2FkZHI6IDB4MAo1NTY4MEAxNzA2ODU0ODUyLjA3ODE3Njp2
aG9zdF92ZHBhX3NldF92cmluZ19iYXNlIGRldjogMHg1NTZkNDU5ZTZlMDAgaW5kZXg6IDEgbnVt
OiAwCjU1NjgwQDE3MDY4NTQ4NTIuMDc4MTkwOnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2tpY2sgZGV2
OiAweDU1NmQ0NTllNmUwMCBpbmRleDogMSBmZDogNTEKNTU2ODBAMTcwNjg1NDg1Mi4wNzgyMDQ6
dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbCBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGluZGV4OiAxIGZk
OiA1Mgo1NTY4MEAxNzA2ODU0ODUyLjA3ODI0ODp2aG9zdF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFy
ZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHgxMDQw
MDAgc2l6ZTogMHgyMDAwIHVhZGRyOiAweDdmOTkxYzgyZjAwMCBwZXJtOiAweDEgdHlwZTogMgo1
NTY4MEAxNzA2ODU0ODUyLjI2ODIwMDp2aG9zdF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1
NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHgxMDYwMDAgc2l6
ZTogMHgxMDAwIHVhZGRyOiAweDdmOTkxYzgyZTAwMCBwZXJtOiAweDMgdHlwZTogMgo1NTY4MEAx
NzA2ODU0ODUyLjM2MzY1NDp2aG9zdF92ZHBhX3NldF92cmluZ19hZGRyIGRldjogMHg1NTZkNDU5
ZTZlMDAgaW5kZXg6IDEgZmxhZ3M6IDB4MCBkZXNjX3VzZXJfYWRkcjogMHgxMDQwMDAgdXNlZF91
c2VyX2FkZHI6IDB4MTA2MDAwIGF2YWlsX3VzZXJfYWRkcjogMHgxMDUwMDAgbG9nX2d1ZXN0X2Fk
ZHI6IDB4MAo1NTY4MEAxNzA2ODU0ODUyLjM2MzY4Nzp2aG9zdF92ZHBhX2FkZF9zdGF0dXMgZGV2
OiAweDU1NmQ0NTllNmUwMCBzdGF0dXM6IDB4NAo1NTY4MEAxNzA2ODU0ODUyLjQwMzI1ODp2aG9z
dF92ZHBhX3NldF9jb25maWdfY2FsbCBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGZkOiA0NQo1NTY4MEAx
NzA2ODU0ODUyLjQwMzQyMDp2aG9zdF92ZHBhX3NldF92cmluZ19yZWFkeSBkZXY6IDB4NTU2ZDQ1
OWU2ZTAwLCBpZHg6IDAsIHI6IDAKNTU2ODBAMTcwNjg1NDg1Mi40MDM0OTk6dmhvc3RfdmRwYV9z
ZXRfdnJpbmdfcmVhZHkgZGV2OiAweDU1NmQ0NTllNmUwMCwgaWR4OiAxLCByOiAwCjU1NjgwQDE3
MDY4NTQ4NTQuNTkxMzcyOnZob3N0X3ZkcGFfZGV2X3N0YXJ0IGRldjogMHg1NTZkNDU5ZTZlMDAg
c3RhcnRlZDogMAo1NTY4MEAxNzA2ODU0ODU0LjU5MTQwOTp2aG9zdF92ZHBhX3N1c3BlbmQgZGV2
OiAweDU1NmQ0NTllNmUwMAo1NTY4MEAxNzA2ODU0ODU0LjYwMzEyNzp2aG9zdF92ZHBhX2RtYV91
bm1hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDog
MCBpb3ZhOiAweDEwMTAwMCBzaXplOiAweDIwMDAgdHlwZTogMwo1NTY4MEAxNzA2ODU0ODU0Ljcz
NzU2NTp2aG9zdF92ZHBhX2RtYV91bm1hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDog
MTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDEwMzAwMCBzaXplOiAweDEwMDAgdHlwZTog
Mwo1NTY4MEAxNzA2ODU0ODU0LjgzMzk4Mzp2aG9zdF92ZHBhX2RtYV91bm1hcCB2ZHBhX3NoYXJl
ZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDEwNDAw
MCBzaXplOiAweDIwMDAgdHlwZTogMwo1NTY4MEAxNzA2ODU0ODU0LjkyOTIwMzp2aG9zdF92ZHBh
X2RtYV91bm1hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIg
YXNpZDogMCBpb3ZhOiAweDEwNjAwMCBzaXplOiAweDEwMDAgdHlwZTogMwo1NTY4MEAxNzA2ODU0
ODU1LjAyNDE0MDp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGlk
eDogMCB2cSBpZHg6IDAKNTU2ODBAMTcwNjg1NDg1NS4wMjQxNjE6dmhvc3RfdmRwYV9nZXRfdnFf
aW5kZXggZGV2OiAweDU1NmQ0NTllNmUwMCBpZHg6IDEgdnEgaWR4OiAxCjU1NjgwQDE3MDY4NTQ4
NTUuMDY0ODQ4OnZob3N0X3ZkcGFfcmVzZXRfZGV2aWNlIGRldjogMHg1NTZkNDU5ZTZlMDAKNTU2
ODBAMTcwNjg1NDg1NS4wNjQ4NTg6dmhvc3RfdmRwYV9hZGRfc3RhdHVzIGRldjogMHg1NTZkNDU5
ZTZlMDAgc3RhdHVzOiAweDMKNTU2ODBAMTcwNjg1NDg1NS4wNjQ4NjY6dmhvc3RfdmRwYV9saXN0
ZW5lcl9yZWdpb25fZGVsIHZkcGE6IDB4NTU2ZDQ1Yzc1MTQwIGlvdmEgMHgwIGxsZW5kIDB4YmZm
ZmYKNTU2ODBAMTcwNjg1NDg1NS4wNjQ4NzU6dmhvc3RfdmRwYV9saXN0ZW5lcl9iZWdpbl9iYXRj
aCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNQo1
NTY4MEAxNzA2ODU0ODU1LjA2NDg3OTp2aG9zdF92ZHBhX2RtYV91bm1hcCB2ZHBhX3NoYXJlZDow
eDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDEwMDAgc2l6
ZTogMHhjMDAwMCB0eXBlOiAzCjU1NjgwQDE3MDY4NTQ4NTUuMDY0OTAyOnZob3N0X3ZkcGFfbGlz
dGVuZXJfcmVnaW9uX2RlbCB2ZHBhOiAweDU1NmQ0NWM3NTE0MCBpb3ZhIDB4YzAwMDAgbGxlbmQg
MHhkZmZmZgo1NTY4MEAxNzA2ODU0ODU1LjA2NDkwNTp2aG9zdF92ZHBhX2RtYV91bm1hcCB2ZHBh
X3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAw
eGMxMDAwIHNpemU6IDB4MjAwMDAgdHlwZTogMwo1NTY4MEAxNzA2ODU0ODU1LjA2NDkxNjp2aG9z
dF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9kZWwgdmRwYTogMHg1NTZkNDVjNzUxNDAgaW92YSAweGUw
MDAwIGxsZW5kIDB4ZmZmZmYKNTU2ODBAMTcwNjg1NDg1NS4wNjQ5MjA6dmhvc3RfdmRwYV9kbWFf
dW5tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6
IDAgaW92YTogMHhlMTAwMCBzaXplOiAweDIwMDAwIHR5cGU6IDMKNTU2ODBAMTcwNjg1NDg1NS4w
NjQ5MzM6dmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fZGVsIHZkcGE6IDB4NTU2ZDQ1Yzc1MTQw
IGlvdmEgMHgxMDAwMDAgbGxlbmQgMHg3ZmZmZmZmZgo1NTY4MEAxNzA2ODU0ODU1LjA2NDkzNjp2
aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9kZWwgdmRwYTogMHg1NTZkNDVjNzUxNDAgaW92YSAw
eDEwMDAwMDAwMCBsbGVuZCAweDIwN2ZmZmZmZmYKNTU2ODBAMTcwNjg1NDg1NS4wNjQ5Mzk6dmhv
c3RfdmRwYV9kbWFfdW5tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190
eXBlOiAyIGFzaWQ6IDAgaW92YTogMHg4MDAwMTAwMCBzaXplOiAweDFmODAwMDAwMDAgdHlwZTog
Mwo1NTY4MEAxNzA2ODU0ODU3Ljc0MDM5NTp2aG9zdF92ZHBhX2xpc3RlbmVyX2NvbW1pdCB2ZHBh
X3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNgo1NTY4MEAx
NzA2ODU0ODU3Ljc0MjIwMjp2aG9zdF92ZHBhX3NldF9jb25maWdfY2FsbCBkZXY6IDB4NTU2ZDQ1
OWU2ZTAwIGZkOiAtMQo1NTY4MEAxNzA2ODU0ODU3Ljc0MjM2Njp2aG9zdF92ZHBhX2dldF92cV9p
bmRleCBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGlkeDogMCB2cSBpZHg6IDAKNTU2ODBAMTcwNjg1NDg1
Ny43NDIzNzQ6dmhvc3RfdmRwYV9nZXRfdnFfaW5kZXggZGV2OiAweDU1NmQ0NTllNmUwMCBpZHg6
IDEgdnEgaWR4OiAxCjU1Njg2QDE3MDY4NTQ4NTguOTk1OTUyOnZob3N0X3ZkcGFfZ2V0X2NvbmZp
ZyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGNvbmZpZzogMHg3Zjk5MDhiNzM0NjAgY29uZmlnX2xlbjog
MTIKNTU2ODZAMTcwNjg1NDg1OC45OTYwMTA6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBkZXY6IDB4
NTU2ZDQ1OWU2ZTAwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAwIDI4IDIz
ICAgICAgICAgICAgIAo1NTY4NkAxNzA2ODU0ODU4Ljk5NjAzNjp2aG9zdF92ZHBhX2dldF9jb25m
aWcgZGV2OiAweDU1NmQ0NTllNmUwMCBjb25maWc6IDB4N2Y5OTA4YjczNDYwIGNvbmZpZ19sZW46
IDEyCjU1Njg2QDE3MDY4NTQ4NTguOTk2MDQyOnZob3N0X3ZkcGFfZHVtcF9jb25maWcgZGV2OiAw
eDU1NmQ0NTllNmUwMCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAxIDAwICAwMiAwMCAyOCAy
MyAgICAgICAgICAgICAKNTU2ODZAMTcwNjg1NDg1OC45OTYwNjE6dmhvc3RfdmRwYV9nZXRfY29u
ZmlnIGRldjogMHg1NTZkNDU5ZTZlMDAgY29uZmlnOiAweDdmOTkwOGI3MzQ2MCBjb25maWdfbGVu
OiAxMgo1NTY4NkAxNzA2ODU0ODU4Ljk5NjA2Nzp2aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRldjog
MHg1NTZkNDU5ZTZlMDAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAgMDIgMDAgMjgg
MjMgICAgICAgICAgICAgCjU1Njg2QDE3MDY4NTQ4NTguOTk2MDg2OnZob3N0X3ZkcGFfZ2V0X2Nv
bmZpZyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGNvbmZpZzogMHg3Zjk5MDhiNzM0NjAgY29uZmlnX2xl
bjogMTIKNTU2ODZAMTcwNjg1NDg1OC45OTYwOTI6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBkZXY6
IDB4NTU2ZDQ1OWU2ZTAwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAwIDI4
IDIzICAgICAgICAgICAgIAo1NTY4NkAxNzA2ODU0ODU4Ljk5NjEwMTp2aG9zdF92ZHBhX2dldF9j
b25maWcgZGV2OiAweDU1NmQ0NTllNmUwMCBjb25maWc6IDB4N2Y5OTA4YjczNDYwIGNvbmZpZ19s
ZW46IDEyCjU1Njg2QDE3MDY4NTQ4NTguOTk2MTA2OnZob3N0X3ZkcGFfZHVtcF9jb25maWcgZGV2
OiAweDU1NmQ0NTllNmUwMCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAxIDAwICAwMiAwMCAy
OCAyMyAgICAgICAgICAgICAKNTU2ODZAMTcwNjg1NDg1OC45OTYxMTQ6dmhvc3RfdmRwYV9nZXRf
Y29uZmlnIGRldjogMHg1NTZkNDU5ZTZlMDAgY29uZmlnOiAweDdmOTkwOGI3MzQ2MCBjb25maWdf
bGVuOiAxMgo1NTY4NkAxNzA2ODU0ODU4Ljk5NjEyMDp2aG9zdF92ZHBhX2R1bXBfY29uZmlnIGRl
djogMHg1NTZkNDU5ZTZlMDAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAgMDIgMDAg
MjggMjMgICAgICAgICAgICAgCjU1Njg2QDE3MDY4NTQ4NTguOTk2MTI4OnZob3N0X3ZkcGFfZ2V0
X2NvbmZpZyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGNvbmZpZzogMHg3Zjk5MDhiNzM0NjAgY29uZmln
X2xlbjogMTIKNTU2ODZAMTcwNjg1NDg1OC45OTYxMzQ6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBk
ZXY6IDB4NTU2ZDQ1OWU2ZTAwIDAwMDA6ICBlNCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAw
IDI4IDIzICAgICAgICAgICAgIAo1NTY4NkAxNzA2ODU0ODU4Ljk5NjE0Mjp2aG9zdF92ZHBhX2dl
dF9jb25maWcgZGV2OiAweDU1NmQ0NTllNmUwMCBjb25maWc6IDB4N2Y5OTA4YjczNDYwIGNvbmZp
Z19sZW46IDEyCjU1Njg2QDE3MDY4NTQ4NTguOTk2MTQ4OnZob3N0X3ZkcGFfZHVtcF9jb25maWcg
ZGV2OiAweDU1NmQ0NTllNmUwMCAwMDAwOiAgZTQgMTEgYzYgZDMgIDQ1IGYwIDAxIDAwICAwMiAw
MCAyOCAyMyAgICAgICAgICAgICAKNTU2ODZAMTcwNjg1NDg1OC45OTYxNjI6dmhvc3RfdmRwYV9n
ZXRfY29uZmlnIGRldjogMHg1NTZkNDU5ZTZlMDAgY29uZmlnOiAweDdmOTkwOGI3MzQ2MCBjb25m
aWdfbGVuOiAxMgo1NTY4NkAxNzA2ODU0ODU4Ljk5NjE2ODp2aG9zdF92ZHBhX2R1bXBfY29uZmln
IGRldjogMHg1NTZkNDU5ZTZlMDAgMDAwMDogIGU0IDExIGM2IGQzICA0NSBmMCAwMSAwMCAgMDIg
MDAgMjggMjMgICAgICAgICAgICAgCjU1Njg2QDE3MDY4NTQ4NTguOTk4MjUyOnZob3N0X3ZkcGFf
Z2V0X3ZxX2luZGV4IGRldjogMHg1NTZkNDU5ZTZlMDAgaWR4OiAwIHZxIGlkeDogMAo1NTY4NkAx
NzA2ODU0ODU4Ljk5ODMwMDp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTU2ZDQ1OWU2
ZTAwIGlkeDogMSB2cSBpZHg6IDEKNTU2ODZAMTcwNjg1NDg1OC45OTgzMzY6dmhvc3RfdmRwYV9n
ZXRfdnFfaW5kZXggZGV2OiAweDU1NmQ0NWM1ZTY3MCBpZHg6IDIgdnEgaWR4OiAyCjU1Njg2QDE3
MDY4NTQ4NTguOTk4MzcwOnZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4IGRldjogMHg1NTZkNDVjNWU2
NzAgaWR4OiAzIHZxIGlkeDogMwo1NTY4NkAxNzA2ODU0ODU4Ljk5ODQ3Mjp2aG9zdF92ZHBhX3Nl
dF9mZWF0dXJlcyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGZlYXR1cmVzOiAweDMwMGMzMTgwYgo1NTY4
NkAxNzA2ODU0ODU4Ljk5ODQ3OTp2aG9zdF92ZHBhX2FkZF9zdGF0dXMgZGV2OiAweDU1NmQ0NTll
NmUwMCBzdGF0dXM6IDB4OAo1NTY4NkAxNzA2ODU0ODU4Ljk5ODQ4Nzp2aG9zdF92ZHBhX3NldF9t
ZW1fdGFibGUgZGV2OiAweDU1NmQ0NTllNmUwMCBucmVnaW9uczogMyBwYWRkaW5nOiAweDAKNTU2
ODZAMTcwNjg1NDg1OC45OTg0OTA6dmhvc3RfdmRwYV9kdW1wX3JlZ2lvbnMgZGV2OiAweDU1NmQ0
NTllNmUwMCAwOiBndWVzdF9waHlzX2FkZHI6IDB4MCBtZW1vcnlfc2l6ZTogMHhjMDAwMCB1c2Vy
c3BhY2VfYWRkcjogMHg3Zjc5MDNlMDAwMDAgZmxhZ3NfcGFkZGluZzogMHgwCjU1Njg2QDE3MDY4
NTQ4NTguOTk4NDk0OnZob3N0X3ZkcGFfZHVtcF9yZWdpb25zIGRldjogMHg1NTZkNDU5ZTZlMDAg
MTogZ3Vlc3RfcGh5c19hZGRyOiAweDEwMDAwMCBtZW1vcnlfc2l6ZTogMHg3ZmYwMDAwMCB1c2Vy
c3BhY2VfYWRkcjogMHg3Zjc5MDNmMDAwMDAgZmxhZ3NfcGFkZGluZzogMHgwCjU1Njg2QDE3MDY4
NTQ4NTguOTk4NDk4OnZob3N0X3ZkcGFfZHVtcF9yZWdpb25zIGRldjogMHg1NTZkNDU5ZTZlMDAg
MjogZ3Vlc3RfcGh5c19hZGRyOiAweDEwMDAwMDAwMCBtZW1vcnlfc2l6ZTogMHgxZjgwMDAwMDAw
IHVzZXJzcGFjZV9hZGRyOiAweDdmNzk4M2UwMDAwMCBmbGFnc19wYWRkaW5nOiAweDAKNTU2ODZA
MTcwNjg1NDg1OC45OTg1MDE6dmhvc3RfdmRwYV9nZXRfdnFfaW5kZXggZGV2OiAweDU1NmQ0NTll
NmUwMCBpZHg6IDAgdnEgaWR4OiAwCjU1Njg2QDE3MDY4NTQ4NTguOTk4NTA0OnZob3N0X3ZkcGFf
c2V0X3ZyaW5nX251bSBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGluZGV4OiAwIG51bTogMjU2CjU1Njg2
QDE3MDY4NTQ4NTguOTk4NTExOnZob3N0X3ZkcGFfdnFfZ2V0X2FkZHIgZGV2OiAweDU1NmQ0NTll
NmUwMCB2cTogMHg1NTZkNDU5ZTcwODAgZGVzY191c2VyX2FkZHI6IDB4MWVkODhkMjAwMCBhdmFp
bF91c2VyX2FkZHI6IDB4MWVkODhkMzAwMCB1c2VkX3VzZXJfYWRkcjogMHgxZWQ4OGQzMjQwCjU1
Njg2QDE3MDY4NTQ4NTguOTk4NTI3OnZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4IGRldjogMHg1NTZk
NDU5ZTZlMDAgaWR4OiAxIHZxIGlkeDogMQo1NTY4NkAxNzA2ODU0ODU4Ljk5ODUzMDp2aG9zdF92
ZHBhX3NldF92cmluZ19udW0gZGV2OiAweDU1NmQ0NTllNmUwMCBpbmRleDogMSBudW06IDI1Ngo1
NTY4NkAxNzA2ODU0ODU4Ljk5ODUzNDp2aG9zdF92ZHBhX3ZxX2dldF9hZGRyIGRldjogMHg1NTZk
NDU5ZTZlMDAgdnE6IDB4NTU2ZDQ1OWU3MTAwIGRlc2NfdXNlcl9hZGRyOiAweDFlZDg4ZDQwMDAg
YXZhaWxfdXNlcl9hZGRyOiAweDFlZDg4ZDUwMDAgdXNlZF91c2VyX2FkZHI6IDB4MWVkODhkNTI0
MAo1NTY4NkAxNzA2ODU0ODU4Ljk5ODU0Mzp2aG9zdF92ZHBhX2Rldl9zdGFydCBkZXY6IDB4NTU2
ZDQ1OWU2ZTAwIHN0YXJ0ZWQ6IDEKNTU2ODZAMTcwNjg1NDg1OC45OTg1NDY6dmhvc3RfdmRwYV9z
ZXRfdnJpbmdfYmFzZSBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIGluZGV4OiAwIG51bTogMAo1NTY4NkAx
NzA2ODU0ODU4Ljk5ODU1Mzp2aG9zdF92ZHBhX3NldF92cmluZ19raWNrIGRldjogMHg1NTZkNDU5
ZTZlMDAgaW5kZXg6IDAgZmQ6IDY5CjU1Njg2QDE3MDY4NTQ4NTguOTk4NTYzOnZob3N0X3ZkcGFf
c2V0X3ZyaW5nX2NhbGwgZGV2OiAweDU1NmQ0NTllNmUwMCBpbmRleDogMCBmZDogNzAKNTU2ODZA
MTcwNjg1NDg1OC45OTg1OTg6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1
Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4MTAwMCBzaXplOiAweDIw
MDAgdWFkZHI6IDB4N2Y5OTFjODMxMDAwIHBlcm06IDB4MSB0eXBlOiAyCjU1Njg2QDE3MDY4NTQ4
NTkuMDAzMzg1OnZob3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBm
ZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDMwMDAgc2l6ZTogMHgxMDAwIHVhZGRy
OiAweDdmOTkxY2EwYjAwMCBwZXJtOiAweDMgdHlwZTogMgo1NTY4NkAxNzA2ODU0ODU5LjAwNjc1
Mzp2aG9zdF92ZHBhX3NldF92cmluZ19hZGRyIGRldjogMHg1NTZkNDU5ZTZlMDAgaW5kZXg6IDAg
ZmxhZ3M6IDB4MCBkZXNjX3VzZXJfYWRkcjogMHgxMDAwIHVzZWRfdXNlcl9hZGRyOiAweDMwMDAg
YXZhaWxfdXNlcl9hZGRyOiAweDIwMDAgbG9nX2d1ZXN0X2FkZHI6IDB4MAo1NTY4NkAxNzA2ODU0
ODU5LjAwNjc3NDp2aG9zdF92ZHBhX3NldF92cmluZ19iYXNlIGRldjogMHg1NTZkNDU5ZTZlMDAg
aW5kZXg6IDEgbnVtOiAwCjU1Njg2QDE3MDY4NTQ4NTkuMDA2NzgyOnZob3N0X3ZkcGFfc2V0X3Zy
aW5nX2tpY2sgZGV2OiAweDU1NmQ0NTllNmUwMCBpbmRleDogMSBmZDogNzEKNTU2ODZAMTcwNjg1
NDg1OS4wMDY3ODg6dmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbCBkZXY6IDB4NTU2ZDQ1OWU2ZTAw
IGluZGV4OiAxIGZkOiA3Mgo1NTY4NkAxNzA2ODU0ODU5LjAwNjgxNTp2aG9zdF92ZHBhX2RtYV9t
YXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAg
aW92YTogMHg0MDAwIHNpemU6IDB4MjAwMCB1YWRkcjogMHg3Zjk5MWM4MmYwMDAgcGVybTogMHgx
IHR5cGU6IDIKNTU2ODZAMTcwNjg1NDg1OS4wMTI5NzE6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFf
c2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4
NjAwMCBzaXplOiAweDEwMDAgdWFkZHI6IDB4N2Y5OTFjODJlMDAwIHBlcm06IDB4MyB0eXBlOiAy
CjU1Njg2QDE3MDY4NTQ4NTkuMDE2NDUzOnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2FkZHIgZGV2OiAw
eDU1NmQ0NTllNmUwMCBpbmRleDogMSBmbGFnczogMHgwIGRlc2NfdXNlcl9hZGRyOiAweDQwMDAg
dXNlZF91c2VyX2FkZHI6IDB4NjAwMCBhdmFpbF91c2VyX2FkZHI6IDB4NTAwMCBsb2dfZ3Vlc3Rf
YWRkcjogMHgwCjU1Njg2QDE3MDY4NTQ4NTkuMDE2NDY4OnZob3N0X3ZkcGFfc2V0X2NvbmZpZ19j
YWxsIGRldjogMHg1NTZkNDU5ZTZlMDAgZmQ6IDY1CjU1Njg2QDE3MDY4NTQ4NTkuMDE2NTU5OnZo
b3N0X3ZkcGFfZ2V0X3ZxX2luZGV4IGRldjogMHg1NTZkNDVjNWU2NzAgaWR4OiAyIHZxIGlkeDog
Mgo1NTY4NkAxNzA2ODU0ODU5LjAxNjU2Mjp2aG9zdF92ZHBhX3NldF92cmluZ19udW0gZGV2OiAw
eDU1NmQ0NWM1ZTY3MCBpbmRleDogMiBudW06IDI1Ngo1NTY4NkAxNzA2ODU0ODU5LjAxNjU2Nzp2
aG9zdF92ZHBhX3ZxX2dldF9hZGRyIGRldjogMHg1NTZkNDVjNWU2NzAgdnE6IDB4NTU2ZDQ1YzVl
OGYwIGRlc2NfdXNlcl9hZGRyOiAweDFlZDg4ZDYwMDAgYXZhaWxfdXNlcl9hZGRyOiAweDFlZDg4
ZDcwMDAgdXNlZF91c2VyX2FkZHI6IDB4MWVkODhkNzI0MAo1NTY4NkAxNzA2ODU0ODU5LjAxNjU3
NDp2aG9zdF92ZHBhX2dldF92cV9pbmRleCBkZXY6IDB4NTU2ZDQ1YzVlNjcwIGlkeDogMyB2cSBp
ZHg6IDMKNTU2ODZAMTcwNjg1NDg1OS4wMTY1Nzc6dmhvc3RfdmRwYV9zZXRfdnJpbmdfbnVtIGRl
djogMHg1NTZkNDVjNWU2NzAgaW5kZXg6IDMgbnVtOiAyNTYKNTU2ODZAMTcwNjg1NDg1OS4wMTY1
ODA6dmhvc3RfdmRwYV92cV9nZXRfYWRkciBkZXY6IDB4NTU2ZDQ1YzVlNjcwIHZxOiAweDU1NmQ0
NWM1ZTk3MCBkZXNjX3VzZXJfYWRkcjogMHgxZWQ4OTIwMDAwIGF2YWlsX3VzZXJfYWRkcjogMHgx
ZWQ4OTIxMDAwIHVzZWRfdXNlcl9hZGRyOiAweDFlZDg5MjEyNDAKNTU2ODZAMTcwNjg1NDg1OS4w
MTY1ODc6dmhvc3RfdmRwYV9kZXZfc3RhcnQgZGV2OiAweDU1NmQ0NWM1ZTY3MCBzdGFydGVkOiAx
CjU1Njg2QDE3MDY4NTQ4NTkuMDE2NTg5OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Jhc2UgZGV2OiAw
eDU1NmQ0NWM1ZTY3MCBpbmRleDogMiBudW06IDAKNTU2ODZAMTcwNjg1NDg1OS4wMTY1OTU6dmhv
c3RfdmRwYV9zZXRfdnJpbmdfa2ljayBkZXY6IDB4NTU2ZDQ1YzVlNjcwIGluZGV4OiAyIGZkOiA3
Ngo1NTY4NkAxNzA2ODU0ODU5LjAxNjU5ODp2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsIGRldjog
MHg1NTZkNDVjNWU2NzAgaW5kZXg6IDIgZmQ6IDc3CjU1Njg2QDE3MDY4NTQ4NTkuMDE2NjI1OnZo
b3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5
cGU6IDIgYXNpZDogMCBpb3ZhOiAweDcwMDAgc2l6ZTogMHgyMDAwIHVhZGRyOiAweDdmOTkxYzgy
YzAwMCBwZXJtOiAweDEgdHlwZTogMgo1NTY4NkAxNzA2ODU0ODU5LjAyMDQ1NDp2aG9zdF92ZHBh
X2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFz
aWQ6IDAgaW92YTogMHg5MDAwIHNpemU6IDB4MTAwMCB1YWRkcjogMHg3Zjk5MWM4MmIwMDAgcGVy
bTogMHgzIHR5cGU6IDIKNTU2ODZAMTcwNjg1NDg1OS4wMjUwOTE6dmhvc3RfdmRwYV9zZXRfdnJp
bmdfYWRkciBkZXY6IDB4NTU2ZDQ1YzVlNjcwIGluZGV4OiAyIGZsYWdzOiAweDAgZGVzY191c2Vy
X2FkZHI6IDB4NzAwMCB1c2VkX3VzZXJfYWRkcjogMHg5MDAwIGF2YWlsX3VzZXJfYWRkcjogMHg4
MDAwIGxvZ19ndWVzdF9hZGRyOiAweDAKNTU2ODZAMTcwNjg1NDg1OS4wMjUxMDQ6dmhvc3RfdmRw
YV9zZXRfdnJpbmdfYmFzZSBkZXY6IDB4NTU2ZDQ1YzVlNjcwIGluZGV4OiAzIG51bTogMAo1NTY4
NkAxNzA2ODU0ODU5LjAyNTExMTp2aG9zdF92ZHBhX3NldF92cmluZ19raWNrIGRldjogMHg1NTZk
NDVjNWU2NzAgaW5kZXg6IDMgZmQ6IDc4CjU1Njg2QDE3MDY4NTQ4NTkuMDI1MTE0OnZob3N0X3Zk
cGFfc2V0X3ZyaW5nX2NhbGwgZGV2OiAweDU1NmQ0NWM1ZTY3MCBpbmRleDogMyBmZDogNzkKNTU2
ODZAMTcwNjg1NDg1OS4wMjUxNDE6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVkOjB4NTU2
ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4YTAwMCBzaXplOiAw
eDIwMDAgdWFkZHI6IDB4N2Y5OTFjODI5MDAwIHBlcm06IDB4MSB0eXBlOiAyCjU1Njg2QDE3MDY4
NTQ4NTkuMDM0NTE0OnZob3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0
MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweGMwMDAgc2l6ZTogMHgxMDAwIHVh
ZGRyOiAweDdmOTkxYzgyODAwMCBwZXJtOiAweDMgdHlwZTogMgo1NTY4NkAxNzA2ODU0ODU5LjAz
OTUxNjp2aG9zdF92ZHBhX3NldF92cmluZ19hZGRyIGRldjogMHg1NTZkNDVjNWU2NzAgaW5kZXg6
IDMgZmxhZ3M6IDB4MCBkZXNjX3VzZXJfYWRkcjogMHhhMDAwIHVzZWRfdXNlcl9hZGRyOiAweGMw
MDAgYXZhaWxfdXNlcl9hZGRyOiAweGIwMDAgbG9nX2d1ZXN0X2FkZHI6IDB4MAo1NTY4NkAxNzA2
ODU0ODU5LjAzOTUzMjp2aG9zdF92ZHBhX3NldF9jb25maWdfY2FsbCBkZXY6IDB4NTU2ZDQ1YzVl
NjcwIGZkOiA2NQo1NTY4NkAxNzA2ODU0ODU5LjAzOTU0MTp2aG9zdF92ZHBhX2RtYV9tYXAgdmRw
YV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTog
MHhkMDAwIHNpemU6IDB4MTAwMCB1YWRkcjogMHg3Zjk5MWNhMTkwMDAgcGVybTogMHgxIHR5cGU6
IDIKNTU2ODZAMTcwNjg1NDg1OS4wNDUwMjU6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVk
OjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4ZTAwMCBz
aXplOiAweDEwMDAgdWFkZHI6IDB4N2Y5OTFjYTE4MDAwIHBlcm06IDB4MyB0eXBlOiAyCjU1Njg2
QDE3MDY4NTQ4NTkuMDUwOTIzOnZob3N0X3ZkcGFfZ2V0X3ZxX2luZGV4IGRldjogMHg1NTZkNDVj
NWViOTAgaWR4OiA0IHZxIGlkeDogNAo1NTY4NkAxNzA2ODU0ODU5LjA1MDkzNDp2aG9zdF92ZHBh
X3NldF92cmluZ19udW0gZGV2OiAweDU1NmQ0NWM1ZWI5MCBpbmRleDogNCBudW06IDY0CjU1Njg2
QDE3MDY4NTQ4NTkuMDUwOTM4OnZob3N0X3ZkcGFfdnFfZ2V0X2FkZHIgZGV2OiAweDU1NmQ0NWM1
ZWI5MCB2cTogMHg1NTZkNDVjNWVlMTAgZGVzY191c2VyX2FkZHI6IDB4MWVkOWZlYjAwMCBhdmFp
bF91c2VyX2FkZHI6IDB4MWVkOWZlYjQwMCB1c2VkX3VzZXJfYWRkcjogMHgxZWQ5ZmViNGMwCjU1
Njg2QDE3MDY4NTQ4NTkuMDUwOTQ4OnZob3N0X3ZkcGFfZGV2X3N0YXJ0IGRldjogMHg1NTZkNDVj
NWViOTAgc3RhcnRlZDogMQo1NTY4NkAxNzA2ODU0ODU5LjA1MDk1MTp2aG9zdF92ZHBhX3NldF92
cmluZ19iYXNlIGRldjogMHg1NTZkNDVjNWViOTAgaW5kZXg6IDQgbnVtOiAwCjU1Njg2QDE3MDY4
NTQ4NTkuMDUwOTU2OnZob3N0X3ZkcGFfc2V0X3ZyaW5nX2tpY2sgZGV2OiAweDU1NmQ0NWM1ZWI5
MCBpbmRleDogNCBmZDogODIKNTU2ODZAMTcwNjg1NDg1OS4wNTA5NjY6dmhvc3RfdmRwYV9zZXRf
dnJpbmdfY2FsbCBkZXY6IDB4NTU2ZDQ1YzVlYjkwIGluZGV4OiA0IGZkOiA4Mwo1NTY4NkAxNzA2
ODU0ODU5LjA1MDk5Mjp2aG9zdF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUx
NDAgZmQ6IDE2IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHhmMDAwIHNpemU6IDB4MTAwMCB1
YWRkcjogMHg3Zjk5MWM4MjcwMDAgcGVybTogMHgxIHR5cGU6IDIKNTU2ODZAMTcwNjg1NDg1OS4w
NTcyODQ6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAx
NiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4MTAwMDAgc2l6ZTogMHgxMDAwIHVhZGRyOiAw
eDdmOTkxYzgyNjAwMCBwZXJtOiAweDMgdHlwZTogMgo1NTY4NkAxNzA2ODU0ODU5LjA2NDA4MTp2
aG9zdF92ZHBhX3NldF92cmluZ19hZGRyIGRldjogMHg1NTZkNDVjNWViOTAgaW5kZXg6IDQgZmxh
Z3M6IDB4MCBkZXNjX3VzZXJfYWRkcjogMHhmMDAwIHVzZWRfdXNlcl9hZGRyOiAweDEwMDAwIGF2
YWlsX3VzZXJfYWRkcjogMHhmNDAwIGxvZ19ndWVzdF9hZGRyOiAweDAKNTU2ODZAMTcwNjg1NDg1
OS4wNjQwOTY6dmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fYWRkIHZkcGE6IDB4NTU2ZDQ1Yzc1
MTQwIGlvdmEgMHgwIGxsZW5kIDB4YzAwMDAgdmFkZHI6IDB4N2Y3OTAzZTAwMDAwIHJlYWQtb25s
eTogMAo1NTY4NkAxNzA2ODU0ODU5LjA2NDEwMTp2aG9zdF92ZHBhX2xpc3RlbmVyX2JlZ2luX2Jh
dGNoIHZkcGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiB0eXBlOiA1
CjU1Njg2QDE3MDY4NTQ4NTkuMDY0MTA1OnZob3N0X3ZkcGFfZG1hX21hcCB2ZHBhX3NoYXJlZDow
eDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDogMCBpb3ZhOiAweDExMDAwIHNp
emU6IDB4YzAwMDAgdWFkZHI6IDB4N2Y3OTAzZTAwMDAwIHBlcm06IDB4MyB0eXBlOiAyCjU1Njg2
QDE3MDY4NTQ4NTkuMDY0MTE0OnZob3N0X3ZkcGFfbGlzdGVuZXJfcmVnaW9uX2FkZCB2ZHBhOiAw
eDU1NmQ0NWM3NTE0MCBpb3ZhIDB4YzAwMDAgbGxlbmQgMHhlMDAwMCB2YWRkcjogMHg3Zjc5MDJl
MDAwMDAgcmVhZC1vbmx5OiAxCjU1Njg2QDE3MDY4NTQ4NTkuMDY0MTE3OnZob3N0X3ZkcGFfZG1h
X21hcCB2ZHBhX3NoYXJlZDoweDU1NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgYXNpZDog
MCBpb3ZhOiAweGQxMDAwIHNpemU6IDB4MjAwMDAgdWFkZHI6IDB4N2Y3OTAyZTAwMDAwIHBlcm06
IDB4MSB0eXBlOiAyCjU1Njg2QDE3MDY4NTQ4NTkuMDY0MTMwOnZob3N0X3ZkcGFfbGlzdGVuZXJf
cmVnaW9uX2FkZCB2ZHBhOiAweDU1NmQ0NWM3NTE0MCBpb3ZhIDB4ZTAwMDAgbGxlbmQgMHgxMDAw
MDAgdmFkZHI6IDB4N2Y5OTA4MjAwMDAwIHJlYWQtb25seTogMQo1NTY4NkAxNzA2ODU0ODU5LjA2
NDEzMzp2aG9zdF92ZHBhX2RtYV9tYXAgdmRwYV9zaGFyZWQ6MHg1NTZkNDVjNzUxNDAgZmQ6IDE2
IG1zZ190eXBlOiAyIGFzaWQ6IDAgaW92YTogMHhmMTAwMCBzaXplOiAweDIwMDAwIHVhZGRyOiAw
eDdmOTkwODIwMDAwMCBwZXJtOiAweDEgdHlwZTogMgo1NTY4NkAxNzA2ODU0ODU5LjA2NDE1Nzp2
aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9hZGQgdmRwYTogMHg1NTZkNDVjNzUxNDAgaW92YSAw
eDEwMDAwMCBsbGVuZCAweDgwMDAwMDAwIHZhZGRyOiAweDdmNzkwM2YwMDAwMCByZWFkLW9ubHk6
IDAKNTU2ODZAMTcwNjg1NDg1OS4wNjQxNjA6dmhvc3RfdmRwYV9kbWFfbWFwIHZkcGFfc2hhcmVk
OjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6IDB4MTExMDAw
IHNpemU6IDB4N2ZmMDAwMDAgdWFkZHI6IDB4N2Y3OTAzZjAwMDAwIHBlcm06IDB4MyB0eXBlOiAy
CjIwMjQtMDItMDJUMDY6MjA6NTkuMDY0MTY3WiBxZW11LXN5c3RlbS14ODZfNjQ6IGZhaWxlZCB0
byB3cml0ZSwgZmQ9MTYsIGVycm5vPTE0IChCYWQgYWRkcmVzcykKMjAyNC0wMi0wMlQwNjoyMDo1
OS4wNjQxODdaIHFlbXUtc3lzdGVtLXg4Nl82NDogdmhvc3QgdmRwYSBtYXAgZmFpbCEKMjAyNC0w
Mi0wMlQwNjoyMDo1OS4wNjQxOThaIHFlbXUtc3lzdGVtLXg4Nl82NDogdmhvc3QtdmRwYTogRE1B
IG1hcHBpbmcgZmFpbGVkLCB1bmFibGUgdG8gY29udGludWUKNTU2ODZAMTcwNjg1NDg1OS4wNjQy
MDg6dmhvc3RfdmRwYV9saXN0ZW5lcl9yZWdpb25fYWRkIHZkcGE6IDB4NTU2ZDQ1Yzc1MTQwIGlv
dmEgMHgxMDAwMDAwMDAgbGxlbmQgMHgyMDgwMDAwMDAwIHZhZGRyOiAweDdmNzk4M2UwMDAwMCBy
ZWFkLW9ubHk6IDAKNTU2ODZAMTcwNjg1NDg1OS4wNjQyMTE6dmhvc3RfdmRwYV9kbWFfbWFwIHZk
cGFfc2hhcmVkOjB4NTU2ZDQ1Yzc1MTQwIGZkOiAxNiBtc2dfdHlwZTogMiBhc2lkOiAwIGlvdmE6
IDB4MTExMDAwIHNpemU6IDB4MWY4MDAwMDAwMCB1YWRkcjogMHg3Zjc5ODNlMDAwMDAgcGVybTog
MHgzIHR5cGU6IDIKMjAyNC0wMi0wMlQwNjoyMDo1OS4wNjQyMTVaIHFlbXUtc3lzdGVtLXg4Nl82
NDogZmFpbGVkIHRvIHdyaXRlLCBmZD0xNiwgZXJybm89MTQgKEJhZCBhZGRyZXNzKQoyMDI0LTAy
LTAyVDA2OjIwOjU5LjA2NDIzMlogcWVtdS1zeXN0ZW0teDg2XzY0OiB2aG9zdCB2ZHBhIG1hcCBm
YWlsIQoyMDI0LTAyLTAyVDA2OjIwOjU5LjA2NDI0NFogcWVtdS1zeXN0ZW0teDg2XzY0OiB2aG9z
dC12ZHBhOiBETUEgbWFwcGluZyBmYWlsZWQsIHVuYWJsZSB0byBjb250aW51ZQo1NTY4NkAxNzA2
ODU0ODU5LjA2NDI2MTp2aG9zdF92ZHBhX2xpc3RlbmVyX2NvbW1pdCB2ZHBhX3NoYXJlZDoweDU1
NmQ0NWM3NTE0MCBmZDogMTYgbXNnX3R5cGU6IDIgdHlwZTogNgo1NTY4NkAxNzA2ODU0ODU5LjA3
MTk2MTp2aG9zdF92ZHBhX2FkZF9zdGF0dXMgZGV2OiAweDU1NmQ0NWM1ZWI5MCBzdGF0dXM6IDB4
NAo1NTY4NkAxNzA2ODU0ODU5LjEyMjM2NTp2aG9zdF92ZHBhX3NldF9jb25maWdfY2FsbCBkZXY6
IDB4NTU2ZDQ1YzVlYjkwIGZkOiA2NQo1NTY4NkAxNzA2ODU0ODU5LjEyMjM4Mjp2aG9zdF92ZHBh
X3NldF92cmluZ19yZWFkeSBkZXY6IDB4NTU2ZDQ1YzVlYjkwLCBpZHg6IDQsIHI6IDAKNTU2ODZA
MTcwNjg1NDg1OS4xMjI1MjA6dmhvc3RfdmRwYV9zZXRfdnJpbmdfcmVhZHkgZGV2OiAweDU1NmQ0
NWM1ZWI5MCwgaWR4OiAwLCByOiAwCjU1Njg2QDE3MDY4NTQ4NTkuMTIyNjAwOnZob3N0X3ZkcGFf
c2V0X3ZyaW5nX3JlYWR5IGRldjogMHg1NTZkNDVjNWViOTAsIGlkeDogMSwgcjogMAo1NTY4NkAx
NzA2ODU0ODU5LjEyMjY4NDp2aG9zdF92ZHBhX3NldF92cmluZ19yZWFkeSBkZXY6IDB4NTU2ZDQ1
YzVlYjkwLCBpZHg6IDIsIHI6IDAKNTU2ODZAMTcwNjg1NDg1OS4xMjI3NjA6dmhvc3RfdmRwYV9z
ZXRfdnJpbmdfcmVhZHkgZGV2OiAweDU1NmQ0NWM1ZWI5MCwgaWR4OiAzLCByOiAwCjU1Njg2QDE3
MDY4NTQ4NTkuMTIzMzAwOnZob3N0X3ZkcGFfZ2V0X2NvbmZpZyBkZXY6IDB4NTU2ZDQ1OWU2ZTAw
IGNvbmZpZzogMHg3Zjk5MDhiNzM0NjAgY29uZmlnX2xlbjogMTIKNTU2ODZAMTcwNjg1NDg1OS4x
MjMzMTc6dmhvc3RfdmRwYV9kdW1wX2NvbmZpZyBkZXY6IDB4NTU2ZDQ1OWU2ZTAwIDAwMDA6ICBl
NCAxMSBjNiBkMyAgNDUgZjAgMDEgMDAgIDAyIDAwIDI4IDIzICAgICAgICAgICAgIAo=

--------------JlmWQTQaDzUpNfn6CzrGiMiW--

