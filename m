Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18070C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrOF-0003F4-0P; Wed, 21 Feb 2024 13:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcrOC-0003EY-OX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:32:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcrOA-00055Q-4F
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:32:16 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LDitfw028136; Wed, 21 Feb 2024 18:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ywFG90dfpYBGIMAQRPzRtY2dp2ahdFU1Sxkd91TZxOc=;
 b=G5y4Ir+8NvSUBLE5iR09DluLhwiGYrUaog6bvdCKUvaqqTjPbDr0bQYBJWRo+6HXFTmX
 KUDJIWDmEgd5ZFI4jeV4FJkkZoCgX3TcZKnTWyNe75MS39XeXA3C74gffiRbt6HPlzz6
 eNtoKMss//jGTn75ePXbi12kD0bA9Ie5tohzLQJ8zb35gu85A+ifbmfZiQma+Tmytg6u
 BxJH6E2f5ff17Jh311K0yHuQDCUD+LdCYlkNO7iiQDWRl1d68uxEa0FQo2sOzPZSdzXl
 4x4dGAhATKmHgtXlWyQyUqLuZDmvAZoNXtrNGdzvUI9ejUNpchxSG0U2sPZxJkVR2YDB AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk42nba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 18:32:09 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LIERvp006570; Wed, 21 Feb 2024 18:32:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89ngbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 18:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LppjIk+d9tgGXCuhh1x6DUqkh50UkzdJalPYNdISNZfwCgyAV3sXMKb+FANVMZOhLoVLTAGU33RaiRygxftEX/jYsoksnfyKFMYlDv66PqXDAE3Hi5X4KL+E1seguG2ZpK55vIMN3HMpYuJnBWALfxMbuakrDBfL8Fq9npAtzdMDwXHIvWnBasz8ZWRb7mcDYkehgxctrJKcUj5opW/xRFbyvNJGG09a8wiDIgIAj/aVur0RqCih4lKzIGveeOAdK22LTXfGm5KE1jaszMDz7d2KkCJSNhJkiWyNXFbO+q8rvEI8nJ+jsaGiuv/PzgM09kmkh8EYeK4keoAEqOX4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywFG90dfpYBGIMAQRPzRtY2dp2ahdFU1Sxkd91TZxOc=;
 b=PbncGVap6YXw55VBNhA26JfMu3D8w9qVUIWltrn/Qr6Kh6DuDUM0xGsQCWH4k+h3ZAAvEjgMiPvzC8+c3fd9kaxXCtYzqlkec+1aYcHQBsv4kaEaU4b0HR4aLq2N5DFNGpRk9DdadvvFE9YP3KoD0ZzcaChfQVYHRNQx4J0nvpof594NnH5gK9e/024osqQgG93+DPhEO1ya0CV6A4nfImytilggZ1GKSkomPVZmjzja95CMXNyUqOXWgtSCq+RS4wJ5F7hxBATcNkwQS6Ta0lFfLvtujgitBfvqWZAobeThWJiEVRpVQ2ZHTRCGA5w5HY2+xbRVdNo4loPiocuE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywFG90dfpYBGIMAQRPzRtY2dp2ahdFU1Sxkd91TZxOc=;
 b=EKsWCLyjXtBX7H0B1Cd5eZ/dEyJS1YCDjU1ylo7j/w8k49mLsEAuvyYITwlOSUT39BIPpMBiyre9BViLvWleJbxu/AlrbdutHeyJvz1nLe6K4XRVkbPguKAfaPvNoZSyuRINrbY/i/0YfovvDGW1LZypaLxD9xSnYXZ4mYgnQo0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN4PR10MB5624.namprd10.prod.outlook.com (2603:10b6:806:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 18:32:06 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 18:32:06 +0000
Message-ID: <25fe8dc4-84c1-452c-a1d7-bae1bf52e56b@oracle.com>
Date: Wed, 21 Feb 2024 13:32:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] vfio: allow cpr-reboot migration if suspended
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-13-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1707418446-134863-13-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN4PR10MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: b69f7720-c5bc-423c-8819-08dc330b6815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkwNj1FQcEWbKUdpwlxy16ZjYG+VBsNGTGbAlrkT0ooMCi5uK//5dvNNJ4OL0gk1KboA4HnrFUbDDrXGlFgmCjkLWBlH/T6PColYZPJY2qQmhVXwnuQ011t6O4UmefCDvp8CVAo6nXmNGtoOZGMe/v9eyEC9yUwh0/KPUNeB9CphpZc3smoC7cn9k70f1qnGMf4uZBfzaqRSE4kOU2zu7V3BPcMSiJHerlk+S6j5xA/ZlMcdiFoexNqvZUv8fUOncLrJYRS3KCwSYjeyIkOH0zNULQoKLx8H97rCnuFUXLor0Nj0/azdcyY/8eVVHOhmZoDalwtl9EMuOzQN4wMghDmQVoVTAHlK6UDi5+1ZUTUIAKax/5NcviHy11hQvdoGe3fqHABriAg6/3z1OrZRMSpFyzQKYHZqgtXgGGr0rtv10hR8dM+6k15awsjKEnp4XgTZtAgplFkktr074MiJuPgcUju1w79S40lphhRmOteWDqgAvt+4hGbU1UQ7nOnE6qqT0O8jZRozXKTWuowCHlpGsoQyev6W9AC8tMzCS3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhzMmZiUzEvcHN4Z3d6Z2ZWdUhpZFpGSnhSZ24zUFRMVmIzaVRTNjczOVdE?=
 =?utf-8?B?RnpBUnc5czhpdFZWRE91SE1QU091VG14TDhBbnM5ZHRVT2djYUYzekVnSTY5?=
 =?utf-8?B?WmNLbHpKQjVCZGdaOVFrQWp0QVpHU0Q1RkEyTGc3YWludmJlSXJqd05jaDJJ?=
 =?utf-8?B?VGp2TWtKM3BJVjhwcDlaSURwQ1dwOUNKaUJPZGJDYmx3TEtpZnZDekxjVlNu?=
 =?utf-8?B?WnRiUGFxc0xXYUxMcjYvaEIrVi9IVlhLbkN5ZlBoTXBFem1LVHpQc2ZiUVpJ?=
 =?utf-8?B?MlY5T3VncGI0WUxsRjRtYzdnLzBLSCtxc203TDNCbWJKZ1F3dHpYOCt5TVUy?=
 =?utf-8?B?ZzEzVnVFRWRxTEV5TERvNGhldjFrVTIxZ1BnSlgzUW41MmlLenhWT0NoUjk4?=
 =?utf-8?B?M1dDR3NnUzlZYnJDNU4wdHRTOHZSeW8vU05sQzBtREsvVmhCWGdqcXZHQ3p3?=
 =?utf-8?B?OXR1ZDEzdUFlL3lRSlVLUzdHNGQya3VvQ20rSzhDUTFEeVlGUXZhMGgzZGtH?=
 =?utf-8?B?TWtScXJDNWQzeUpkbCtFVWlmVm1MbWt4NW5iTmtiQVZKdzY0Q2dBdWQ5S3hK?=
 =?utf-8?B?d0ZMb0k2Qlk3ckZDQ3JVeE80U0JYQWxmWC9CaDA0M3ZIejEwemg1QlphcmVG?=
 =?utf-8?B?a2twTjFBN2kyNEE2d01RdExpbGlmZndKYUxhMmowNTQyUjJXNFVFeVJHZzRY?=
 =?utf-8?B?WGhleXcrWmQwWWR2dktMVk5VenJZcXJOeVAzS0pEN3ZFZTJldGZzVkMxVmFG?=
 =?utf-8?B?V0FlTkV2S1RnSUJVMGpIaEVWVFZSQ215QkFoL0NSakw1VEtCMHdmYnFKcXBF?=
 =?utf-8?B?L3g1ejRpU3pONnBzQi9CRkJ4UG41bVdqdm9OQUkyaTVmNmEwa3o1TXRWcU5q?=
 =?utf-8?B?MmsxWk0rWjAzczdIVWptZm1RWDdsZFA4LzlCa3R6b3lCVml2RGt2aFlPSjhF?=
 =?utf-8?B?cXE4WHVJNEx6SzRIbHBiVFg0NGluNXNwZkpxdDI0ZEVrQ1Qwbmw0S2xnMFcx?=
 =?utf-8?B?Uk03KzBYOG95dmNsRjFkME91c3g1clVzQ2N6dGJhK0UwS0JORWhROVkzV0VY?=
 =?utf-8?B?Z1pKZ3RDNTUvZWU4YnpaZmRGY0V4V25zdExUTndLNjVXbWMwYnpGWWNYS1NM?=
 =?utf-8?B?SG91aHNpc2VYTTNQUVhXTXVkUmkxSkROdGY5QStQZHZLRTVKb0RzZnNJM0V6?=
 =?utf-8?B?VWw2bSttUzB2cFdWb2JEMjZsSWRJZFNYdk1XRlhnRm5OMGlVdkZ2ZHl4R3cv?=
 =?utf-8?B?TlRZdXpBalNwVDYwbHBZRDFOYlVlL2RUS0FkVDBXejQrUTRlb2J6WmlTYWRB?=
 =?utf-8?B?a2pobnFHclc4TUdEai9PclFUT2hLdFJIdW55M09EN0RaeGF3WUMxbU1iV1BT?=
 =?utf-8?B?MUlJa3phbmlJRkcyK1FFUzgyT1pHUmpsc0drb0sxTGJVRXJSclhkK213T2tD?=
 =?utf-8?B?R1p5OGRnZGdSTEZZRHNkQlJXdWR1UVk3VlRiOUZZTzFudHZ5WndPejliM0lx?=
 =?utf-8?B?Y2I1R1JSd25PR3ExOWN1NEYrOTArRXEzKyswN1VJbmwwZm9Da1VXVER0TVM4?=
 =?utf-8?B?ejhZL0pua1orWm0zelRDbWtsSENKOS9Uck9NTkQxMVRqNVhxM1RxRlhXTDFp?=
 =?utf-8?B?dFJvWG9xL2JETzBnTndGMG1Wb2NVdk9GRTh3UmlEK2FydTFLWFVYN1M2TVB1?=
 =?utf-8?B?QlIrTmVERHduY1l3VitjRHZoVmJvSlpmcTJsRXphWXZqS1RNSG9tRjhqQzZV?=
 =?utf-8?B?dmR0MkIxMElZYnlUYjVDKzNHWjlaazdFUlAxYU5nMGVjVHdWL05iNmhIK0l0?=
 =?utf-8?B?RXEwODV5cjN1K2xNUkc3RVpHM29ZeGdiSHE0VVYvM015cHBwSk41VWNKZDdP?=
 =?utf-8?B?dTJ3dmFUMmduTnM2dGR6aVUvL1R6WFNxUEI5cXg5NVlhRzFBYTJOcXVJTG1S?=
 =?utf-8?B?YTBGRERHQTJmb0N0dm1VZzlrM3VGb1pnS0ZtZ2RaUHhwS080U2JZbXBpTUFP?=
 =?utf-8?B?bWlpRnkxVWdBdDREZ3I4MUxTeE9EZ21ZbG8zM20rSmNkYVo0eW4zQzR2aGpI?=
 =?utf-8?B?VzY1UWZ1UGpKVlpNd3VXcmtlVlM5dEtuemFmeGw2K2wzVmxkL3pHUEZxRDV1?=
 =?utf-8?B?RTdyM1ZRYjhWa3ZqQVFmcW9URjZmMXF0TldHaVJUV2VRb3h5SU84cm04eG1q?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2xNJVf0t5xGKxDFD4k29396uj6xEkFUlf63lSRWijhCrqEmRBT90NAfiuq7KejzxXupQwF3WZjLrlWLCNOR1yZyKqMQyzT5tZ6N+DMiF/vl7iY0mbW29ahEwQTcsFUcDsFLWB7jlXIMS8tlYrrQrHNEsro6qBXdS8d6TEmrFxW4FwDF76Wid+PrmaTCZvsIjqrzyahNXZxl6m3fYvMxVa5CM0G5YZ9KkWcLnt8sEeOkAN+OlUHuffLuFRDitoZ/VMChqfiutg6wCUdk09C39ZyXcdBOFslms1pCCkvrTIO6AKyhY48CKkE4/XfV7pilUKiTdj4X2AW1KBEbz0h7I5NXVMNixjad4O+ZTnn5PQb/T5fma6YQy/2Q2if4NX5MgYNAxoQkIKiEj/Wa69jObowdofESQLnNIxdWsVoEp4Sl6mfNCRcP9As/BCHQBPzVcNe/9/RLi0JHqHAegmZOOxfzFHVlB6VkuYpyjHl/c7lhTUdR4Hbaq103YhGDp7enM03wH70jzVy2AQ/D5eDfFRNXNJE2hBOlMJmdNOHLFptJsput0NL6XEEzbrJmx+cBWiOKqSOmxImMUj6O9vqRmDT3Ybuqk8f3asF/rqU4+0m4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69f7720-c5bc-423c-8819-08dc330b6815
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 18:32:06.5514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13nLbSp2UbHTdyT8tkcIWs5a1JTnVdEaoGo2XM/JUoMEt7hI4iD6BkUAoeBu1uKfd4sFLxppHvf+wNUP4Y+qHPCKLdSPTSBAck8vLAmbRuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_05,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210144
X-Proofpoint-ORIG-GUID: aK9i3kKWrZ5-s2DfAmbRwrtF2hifbWDq
X-Proofpoint-GUID: aK9i3kKWrZ5-s2DfAmbRwrtF2hifbWDq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alex, any comments or RB on this or patch 11?  The last few changes I am 
making for Peter will not change this patch.

- Steve

On 2/8/2024 1:54 PM, Steve Sistare wrote:
> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> guest drivers' suspend methods flush outstanding requests and re-initialize
> the devices, and thus there is no device state to save and restore.  The
> user is responsible for suspending the guest before initiating cpr, such as
> by issuing guest-suspend-ram to the qemu guest agent.
> 
> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
> verifies the guest is suspended.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/vfio/common.c                      |  2 +-
>  hw/vfio/cpr.c                         | 20 ++++++++++++++++++++
>  hw/vfio/migration.c                   |  2 +-
>  include/hw/vfio/vfio-container-base.h |  1 +
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 059bfdc..ff88c3f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>      error_setg(&multiple_devices_migration_blocker,
>                 "Multiple VFIO devices migration is supported only if all of "
>                 "them support P2P migration");
> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
>  
>      return ret;
>  }
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 3bede54..392c2dd 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -7,13 +7,33 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/vfio/vfio-common.h"
> +#include "migration/misc.h"
>  #include "qapi/error.h"
> +#include "sysemu/runstate.h"
> +
> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
> +                                    MigrationEvent *e, Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_SETUP &&
> +        !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
> +
> +        error_setg(errp,
> +            "VFIO device only supports cpr-reboot for runstate suspended");
> +
> +        return -1;
> +    }
> +    return 0;
> +}
>  
>  int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
>  {
> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> +                                vfio_cpr_reboot_notifier,
> +                                MIG_MODE_CPR_REBOOT);
>      return 0;
>  }
>  
>  void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>  {
> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>  }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 50140ed..2050ac8 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -889,7 +889,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>      vbasedev->migration_blocker = error_copy(err);
>      error_free(err);
>  
> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
>  }
>  
>  /* ---------------------------------------------------------------------- */
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index b2813b0..3582d5f 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -49,6 +49,7 @@ typedef struct VFIOContainerBase {
>      QLIST_ENTRY(VFIOContainerBase) next;
>      QLIST_HEAD(, VFIODevice) device_list;
>      GList *iova_ranges;
> +    NotifierWithReturn cpr_reboot_notifier;
>  } VFIOContainerBase;
>  
>  typedef struct VFIOGuestIOMMU {

