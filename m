Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED6C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 11:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNwm-0001Cl-NL; Tue, 20 Feb 2024 06:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNwk-0001BF-A7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:05:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNwi-0006HM-AL
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:05:58 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8wpla030916; Tue, 20 Feb 2024 11:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jtx2k39eeY5gLehyL4Kc15d6Yyy1akiZdkQgPizLoSA=;
 b=gyKg/wTKyRTt/vs1H6vmVHPteHd88YVjhFnq7jCm92Ht2pDXHmst4Y+duDHB+XGCuGS7
 jPkrtBI14Ct7npvKBPIWb2KtLryu75ERsKwY+VL6ev4QNLYtL/xYCeIJuwuWjptEPHtT
 8Edl1/fEoE1+UpKi2zU68aaOF3nLjkDsIY3YilYuHZ1wMJjT2aAbVu2dHpv0iKrdCSOc
 jpapoOD6mO9Di+yc6AtybNiY5TnnCEiR/6mzWUNtsbNQZOrvqSq2RcxOmDkf0cpVosip
 xCkvnA0vS+9LZDpJ+8pREAVwvhfdhQaGfIEQfr4qNN46ZiXIl00Dt/TrBiK0/Yzu+kJt Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucxe10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 11:05:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KA06FM037770; Tue, 20 Feb 2024 11:05:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak872q6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 11:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISi8SFW9lf6pq1grIhkgl6PDEH7dbtTPiTW6KPs4ERsnfXT/07khX/avhk1P2nW4/xPTbpJPd7WBnL0fhRJYzkzDEIex+OrW1m8ANRM25Gcpj5cv+ZrzjdHZ+Vso8QKTQpbq4GHYH6QWcxkB4h7iNzzsuFqdvJF/py7I9E7yAa7wbTP7HJA5diwxS/dBC/oCoZAIvsoFH64+9U+Wo/AT8UIdWcOxvrHfbY+rMwTiV33d/Kl1m1Bja4GoiHGKJ+v7TP+/NccADW4g0+MNf67OG22t/ak1hg1xZMmimnolK/7iaUkuQc2N9VpmE0/LKUy4DRaOMzA393GhLYSjzeU4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtx2k39eeY5gLehyL4Kc15d6Yyy1akiZdkQgPizLoSA=;
 b=cTspwZUhzWInJt9DVIvn/OcIHvrTuW2wIw+ckhaSPv/mwp3e6YOYj2sdv3sz2vlkIYYfwggxrR+oTrchN1QXzAxecTOoCYlBApdgZycP2jeb6fUQ1aPh9w7FT/6ue+NVXO1zK4I0eRvUCHohnSgyXAmo7fr51BYPUlZctpK+6OXwAqdH2cdVhOPcpuPlGTwp9BVl7P52lwBQtSt0IGRqrdORBnrnVP7sl/gMIgX6fZ2VHGzBECtVBqtXGtmMQy6V4Rw8HxZOK+IbO6b8Ww5gcJHEWnAG3v9iCwu8Q4+/GMVSc06pRtpv66Lyv9QJALuhLGeN04TM3j4jB0FtOFEUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtx2k39eeY5gLehyL4Kc15d6Yyy1akiZdkQgPizLoSA=;
 b=G4rlKqgA6MuwpGeyMlBh+bUA6fdKpAr/xEoaOKckX9bq9cPrfjZpkTMYk6cTopg8M/heXewVyMLFs0JAX/C+1THAZmQRVK6WBjjj9oM9Vnnh/2YZAXRv+rVA5kiFO3jNerEBrWhZeTH2zSteaqkDwIDAsD24sU8c1n3XVtGGlII=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 11:05:49 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 11:05:49 +0000
Message-ID: <5452ac66-61ad-4265-9a4d-d99c3bf3fd07@oracle.com>
Date: Tue, 20 Feb 2024 11:05:37 +0000
Subject: Re: [PATCH RFCv2 7/8] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-8-joao.m.martins@oracle.com>
 <cfd8f7f8-4d9c-4373-a127-1f07a3d6e26e@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <cfd8f7f8-4d9c-4373-a127-1f07a3d6e26e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 034c94f8-33fc-4b02-33b8-08dc3203e56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzFGKWmk/9A8ax4F6/1umLWggNhqhHSAp23HYN5ILppD8lScmHrLIXx+AYNnYw3lv6p9MzxZfWo3sNmqer0BROnpOZ1TPY+32kVvY00Ln+ZHsl/LepicGitB8D/eMBaDW9MVzbUzZ86ovHzWSy9Z+Uco1vmgATpKl94EloGdPGSptuaRNNw/e/2quFpmGNJY/GvXlhEFkE8L0ByrZ6Vijkl8GisiMWXYJZJH9654XpzSogfgzxyPeD67j08QTTgDZnX4ngFYVoEJGNxOmMj1H8XzZ+uUo5zv0Z8WTM0Ug2bUcgArVAgKtw4bLRPMr+iV+W9VUyUTORJZ7Rz6F5Z4G0mOFFqlC1lIjvCZLjLAww3lJDV4Dcvf2k3/Z2Ha/Z/248ttdqpHVJS/jr9kJe2HDUIQ/euzG8bw3jbgKXYxjl8uYipkDtv5wV6bGQVm59hAMlthfVhJzVBEggFPm073N6XI7odydooZZeHwpec6YwGECN8SsE66kwPKxAmzwEA+uR1kdKaWNPpKzi1BXjsVxLZZQhkzy4hEfP/O9npeCtweZFMfPdyIhSBKOJE6HkPr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBSbi9OOGFOOVltNU5WZ3VHV3J6ZDdTZjBDMDRuQTVTMnRCejlsM3puUzFz?=
 =?utf-8?B?akFJRG5ILzBBR215WDR4SGdUSXQ4SUFTQVUxNDFMYVcvRG94eGhWQ3paTjJ6?=
 =?utf-8?B?WUFWaE9SbnRnOHlIc2h3MDB1aFBmbnpHS3diY1VSMEI4S3JSOUQ3c2pLSDhP?=
 =?utf-8?B?NFY5ZTJ4Yy9MNVVvYlBKekF1UjNNRkxwM3RlWDA5RWFxQmQwSWtHVVFwWmtV?=
 =?utf-8?B?WndndHQyMWI3NFlGQVlLNUo0ZnNGRDNDWXVpOEM3NWgzNGFOZEgwT3FIdjYw?=
 =?utf-8?B?d1g2Wnp4NTY3MGlhdTk1eUluUDNJdEczVzVXODAyQXZxUlJGZDFGK1h1NVQ2?=
 =?utf-8?B?QkxyWThaODNiZVJ4R0YzTjJteEVZVk9ybW9CZEh0bDY0TCtwcmJHd0wyZGto?=
 =?utf-8?B?K0tLeEdMVkw4Zi9OYjM5blhjcDlYaVR0N0FsQS9la3crQWJZNGpjN1FVdlBB?=
 =?utf-8?B?NVY1WjVsaFhEbzBLRXhuUk1NRlBxTTZLbXhkQ2tTU1VCR3pzdkR4Yyt2TjUx?=
 =?utf-8?B?cytIMmJOL2FxKzNaUHVlNXlUdUVNZ0JOckg1Z3FNaVVKMGh3VVBQTlZ2b3JK?=
 =?utf-8?B?ZThaaDk4U2hDR2tPV2RocEdkNXd3bmV0QnMxWU5rYWkyelFxZlRlbFJ1RHhm?=
 =?utf-8?B?b0N2QzFuSzZhekt0eDVWNmt4dkZ3T2d2NHEwOTBZU1o2VFBtZHgrcWg3L2lU?=
 =?utf-8?B?aVF4eDUyRHBwNC82L1BEV1R6Q2NuTTk1andjd0VVNWZUaVBocnFHUytnTFU4?=
 =?utf-8?B?emhvTnJxcnJ3c2xGT3VYZ3pYMkdjTXY1TWNaQVNnVEI1Q2x0SkUvZUd5WnZp?=
 =?utf-8?B?L2ZMbU51NExDUGNhd01Ta0RTeEJHYmdid01meU1ONUNRSk5lTzcwb2U5akhW?=
 =?utf-8?B?VXN5Tkg0UkQ3Yk8wTXNXZCtNUmdjSHJRN1Qwb1RYRFBVbWNKUTF6ZnQyMDZu?=
 =?utf-8?B?VzVGNC9oaFhzdG1KN041d3RDeENsdUk2OXhDQXdZUzN0c0dtT0xtNEd4ZUlk?=
 =?utf-8?B?VzhpQldUVVBDRU9QZ2RXMEtRSXlmMlRxQjRPWEZ2ME1Hc1kvNWZnTXZYL0lM?=
 =?utf-8?B?YnR6SkxNYkx6VWV6ZnVuMVg3Rk54bERXZHRMWm1zSnRFcEVjb2FMOC91QUU1?=
 =?utf-8?B?ZE94WEZwWm1NNW9WMENIT0ZGNThpdlpLaFhCMWVVTG41bk5oUUJGMFVoT0tH?=
 =?utf-8?B?d01HYXV1dnpmV0s3UWltMkpxRzJIenovR3VLdkY3blBxQTNVTVBVVUVKdURu?=
 =?utf-8?B?RGlianI5MGFNeG0yekRaUGQ0ek9Eek94TU1LazhnSnZwWU83N2k0N1krOVdC?=
 =?utf-8?B?QkRJQnMwTWg3UisvWmFJTzRsSG9XM2xJU2lZS1VqZ3ZGTmpodFozdXYvQUgy?=
 =?utf-8?B?RlpuQVhubzlQSXlPR3kvWE03Rnc2djkvVWdjRW4rYkhBcWRMRnlJZzUwamRI?=
 =?utf-8?B?SUhpNXhncG9ERjhUb3E2cCtTYVNiUTRzZjU3Mng5bmgvaWFvZ0svbUQ3aHRM?=
 =?utf-8?B?NXBhdDdKaTBVOHRoVkFyM1I5Ym41SUxhVTB1T0U5NEhaNG9CV1Q4YzloRjhh?=
 =?utf-8?B?WXd1TDFEVWhLOEVMRnpNcVViazJBOGs2R3JaRXZRcTg3UUxQY0ViYlFFaEJS?=
 =?utf-8?B?UHNVSEFCOEhYaU0wYnJIWjhuLzRuMGt4TmNCL29WR1JFNjZMRTh1SHVhV2V2?=
 =?utf-8?B?WTB0R3RuTGZPTW9saExKaGhBcHRZdldJRGJydkp6VXJaYjBld1A3SHROaVdM?=
 =?utf-8?B?REVmWGE4YXVTOTlNb0JLN3NTR3dtNmJuYWVQb1haTnBGcEVoTG5vNVluU0Na?=
 =?utf-8?B?ZDA4K05jb0FkSDBSMVo5cmxNby8wcGxlbmFzRCtzSHhsOWp4MzNzbjZRcUoz?=
 =?utf-8?B?NEljVFhERm9MOVJFT1c1VmUwejJ3Z3ppV1RPSklUeDEyUVl6Z2grTnQ1V25P?=
 =?utf-8?B?Z2IybEdQbDlxbzhLZUp2MkdHUVVWOVpZY25kVlpFU3Z0NnJFbHN3OEQzUkdN?=
 =?utf-8?B?MGx0b3hFVDhyRUlRVmxqZjhEMm5vcExxZUh1Sy9KelltdFVyUjVZVktvNi9s?=
 =?utf-8?B?bHgzcFRUUDFpQWpXZUVzVGE0dThBc0NHM283YjkxLzBkMm1TNGRYSWZxN1V5?=
 =?utf-8?B?VVlxeDZIR3VvRWV4ZkxjQVFnVm9qL3hGRnBSSlRaRUxmWTJkdXdJRnBrZ215?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ijH53nmVgvRbv62L/DDZMF7x8nsYHEJJBl64f+JjVwlgOn0tpRMFnsmVzP26d5vVWYhpkJ085sAoFwsyi54o69U60ADUGwEh9pbRZkEci9uGCWSEyyOwwdbsaHrCBVQbHoQJy4hqdyfOv+v5l+bT0SyO3lJg/gqW4ICfDCoOneqiCkZye6yWIWR9TFsQ7wsZpMcZZ27on9PJryrlzBM96DvL1DOynYpzvSDP4hq+6zRKOQ+X1rh9QNsVqW8LPzKhcX153Q4zHBNrNIk1l1nOBMru4ShJkhODjbSmy70cRIxF8C1WevZvgWMjAhjRdzQ9oKQGGuybVNm6Q2OLP2DNLZ7iGLLetTETtRTPL9oNgyM1l4G+4sWpsS+vygzdxymfa0Tw3xggWWWw+684zwbLH/FHo4cz/s234/pC2d1Eah4gn0d1RW4gbJeLPZdbVahwW6cZZY/rRWY2JrIe9Clt11LtbnhujIhsud0tSxSNwN7nqkADUhSiF6nqKaGBqqiV5nvdIu+nyAaZOOF7H9zTgfFvO16k3wkXVTMNpSWKSWKkS0SdjRU7NZbrb7JN4yV5oYz4Q55lEPbxj3hKne5SpNoxtGSBRU+lRWoefCJtX5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034c94f8-33fc-4b02-33b8-08dc3203e56b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 11:05:49.7881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRSSEAkTdW4Ua7zn9C7x9/Bvg21BMqqh5m8V8o7IN4H2Wk4FsFV3r1g+tN7Ipc+iYeh4Mw65ehEmxpgNd5QvDymnd+DVwSYSZzU+VhNZn84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200079
X-Proofpoint-GUID: ZpHnb4w2yqUg2M98CFndOsCavb-QfUQ2
X-Proofpoint-ORIG-GUID: ZpHnb4w2yqUg2M98CFndOsCavb-QfUQ2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 19/02/2024 10:12, Avihai Horon wrote:
> Hi Joao,
> 
> On 12/02/2024 15:56, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> By default VFIO migration is set to auto, which will support live
>> migration if the migration capability is set *and* also dirty page
>> tracking is supported.
>>
>> For testing purposes one can force enable without dirty page tracking
>> via enable-migration=on, but that option is generally left for testing
>> purposes.
>>
>> So starting with IOMMU dirty tracking it can use to acomodate the lack of
>> VF dirty page tracking allowing us to minimize the VF requirements for
>> migration and thus enabling migration by default for those.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/iommufd.c        | 3 +--
>>   hw/vfio/migration.c      | 4 +++-
>>   include/sysemu/iommufd.h | 1 +
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 697d40841d7f..78d8f4391b68 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -275,8 +275,7 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice
>> *vbasedev, Error **errp)
>>       return ret;
>>   }
>>
>> -static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
>> -                                          Error **errp)
>> +bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev, Error **errp)
>>   {
>>       uint64_t caps;
>>       int r;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 70e6b1a709f9..674e76b3f3df 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -938,7 +938,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error
>> **errp)
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>
>> -    if (!vbasedev->dirty_pages_supported) {
>> +    if (!vbasedev->dirty_pages_supported &&
>> +        (vbasedev->iommufd_dev.iommufd &&
> 
> Shouldn't we check the type of base_hdev instead?
> 

This was just me trying to be less tied to Zhenzhong series, but yes

>> +         !iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err))) {
> 
> Maybe we can store IOMMUFD DPT support in iommufd_dev and use it instead of
> querying it here?

It's a good idea, and originally I had the ::capabilities stored in the
iommufd_dev and I was mainly checking this there.

I could fetch the capabilities after we get an idev and then this just tests
against HWCAP and this avoids having to call GET_HWINFO all the time

