Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3C1C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNjI-00029x-JP; Tue, 20 Feb 2024 05:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNjA-00029Q-Ot
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:51:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNj3-000434-UP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:51:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8xXH1019409; Tue, 20 Feb 2024 10:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qUfRzvpr6g+98p9QckVKtzEaj/vmzBZbZ/yj1BEAd4U=;
 b=oEiBzYEv1tc+6lw6HcECgGsvWBv72ZKuxSui1AdW+JAU5Hd07niFCRUlJ8YV/66gOHjB
 bbLlVXINYCNaKpS2NetRNMouao0URN+1X+yw5fV+1QcLII7ajmt2tVURELcfbCC6tELY
 I6+danXVie+c4011P7tsOhWIcm9MlN+ILgT4ltZwY4ks1E5nF5C8N0rym5f3lCrWSmz/
 nW7YVnVqkVTfyM98UdKSA7nqv3m/aElUrTPaFks/L2egMJRPccrfynPCHDnZp8tnRirC
 Hz6COMN3PT58HhmuDIBxAsbvEk8M3i8PmtxrfYl4i0jE0u75QsxbUWZKn2hstxM7iIY/ iQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wampaxa3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 10:51:39 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41K9e81S039648; Tue, 20 Feb 2024 10:51:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak873496-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 10:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjWoIjf7p9TxW1/t49Vxd8ANO8y2i+ruhjkQjaWqzrK2LIj/9qgmiOuoGUe4o+zixWutSkF5QISgs8C6+H5AVz818xtFZ/avaRq0l29c8yl/WTfFkCS+L9eIwy3QL9XDZNeHoadBAKzUm6dkNwxkhPZzEDWs5ZLZAHaDBCnAygoVFKYYegO9Nec7t205JHNqfbz1XAdXvxURz6HVzb0Bq1E/j0NmGHk4Dh1tmk93olH9AE0tKTbjUkqLX074lW78ZVD4HgzOOG1fHiHWHtkOXfKwScv58SKnPEen+uhsalJYwn0dr5b0gJ42aM8xvJUjjCFGbBqetJ8Zb0ig/hDSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUfRzvpr6g+98p9QckVKtzEaj/vmzBZbZ/yj1BEAd4U=;
 b=CjWAua7COqub1RLOeqppvnJq7FoDVbMg8wwK/PqrSk59w1pfbia1eCOo8UUPqDQJ7i3X9DJgBy0KukYLjmMdNnEttUZDpTVqildcuIbHKDXD8kEum3mayecD1GtO+zvBhQyWopM4L2BrgMyuufA9KDmZb7G7e8vfuB4hb5vQnszJeu9uA0wN4ZivSkRKT6QFdSS6LCUuXHpbb8m0FjyzM7Emk3zUWww+sIo6O0fygZQnbdFqsaBDofrYb5+XPTGbV0oNMWYJjimnwcSWPH/NeMr+JYHPzHHyzONb2pAxs/JJ6Anxrexv0xEYzZkKIGgI1945mk0Kb2kNuJBjwdzQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUfRzvpr6g+98p9QckVKtzEaj/vmzBZbZ/yj1BEAd4U=;
 b=U1AySObUL0kE4nQYSfwLRZErtpEXO5BeazSTVgQb+mBDIy6cQMuOFEqHyGYapE+4Pyoz3A8mjjooK1QdazQDd3SkmpFttFg3JgZg9Ve41dDcorv+ZMrrC8aBwd0ia0q7MKiw2kX2TczW4/3xuQZMHZvMp/l8hXCF/yQVgv/Nf34=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:51:36 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:51:36 +0000
Message-ID: <95fe7e5c-cbe8-4c8a-b503-8b32df321941@oracle.com>
Date: Tue, 20 Feb 2024 10:51:30 +0000
Subject: Re: [PATCH RFCv2 3/8] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
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
 <20240212135643.5858-4-joao.m.martins@oracle.com>
 <341dc4a0-cf9c-4b4f-a520-b47f24ea8e12@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <341dc4a0-cf9c-4b4f-a520-b47f24ea8e12@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc9b6a8-2c98-4e5a-7439-08dc3201e8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RziV8yaWi0PCy28oCSt0g41+BhnBH8UA604tIs1FeuHwMxgu/3G3q2brR0puFnMZNNPhAS1hpvruNat8BL7nV9dG1BTsLQxm3g8X0wLVv2O7YT+xM8FLnq8p1Z5baM17NtI2e1NO1R2PZYWvH0gKSKOfK7qZJp9pChwkjVzeoueEaGOdku+MoQMMLbuJC+pl5DV8fQPu3RlMPC1Vgoh9lUz51ne1SuE+TXTn+6CkcTOd0TM3xdWHS3ZBVFrkTYXOFEoOzZe9Dv7fl2VotfPmU39nqkrk5xiTv5gLM5Cc2VXNaxMn/Ax/0WjuUW/l8N1bYl1FuiAI6QA7XcifFhfwNso4x/p4ASbRR4G4yp9fhUvOk7X1mXJYEIBLr/LsTM6DKsbIKWl3KINHGrfXViLoW+1JlwZ4E6hP/loB+kCZid2oTKfk7QRYOdWIhOdWwwvRVnyCwCQVSOJa2IWPlb2IFywxjG6w6c7fPKeEVLth/0siREIIPBvZq+meVcRTqPOuJtR3szJ7rAeIF0UVyxLquQP2l3GxiKUBFDWlFN1pmTvcE43FNA4jFY8eYX03p5f5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdBS202QkdaYW9TOVQ3dUFKdDZORHJOelNDWWNnZ2tMMWJvU2dpZHNjY0lC?=
 =?utf-8?B?ZWMzMnRiVUdYeTB0Rmh3dGNpOFZRdGxzNlpQUTlJdDZzMFNxRjg4ZkRJVnVj?=
 =?utf-8?B?aCs0NFlMK0d5ckdhVE9VV21aaCtkTllYU2RwdFNiSUtBVlpwU3hXM1lYSWZ6?=
 =?utf-8?B?Y1R3eExiVGRFMWRVK21INnFzSkNEYm1TS3hzRVIyQzhJU1cvQ09GamE1cFFI?=
 =?utf-8?B?VWtrdEJNUkdOSlh6VVFWUXdicERqTFljTitmNVVVMEk3U3FZNjBYd2tBbSs4?=
 =?utf-8?B?bjZnUytyMUpKUkhRMVhHamZ6WHE3eXdKejI3V2phc2dITndRKzFRbVdTQWJ3?=
 =?utf-8?B?MXdHQWhEUTBpZ1NLQkQvWndJNG9td0ZnNGxneWR4MzFaaFZXWTVOckQrU2Fq?=
 =?utf-8?B?N2NUUUVQTjA0YWlxaGVCNVVHVEx0MWNyaVRvd1Fyc3BEZzJpS21BaTZBWFNM?=
 =?utf-8?B?RTFkcFBndkNOb0luTld3QzVoVU9Wc3g5QmRIY3lkK1liUTM1T1F2dnRlUVRx?=
 =?utf-8?B?YUpXRFZnOXdnZzVDUzFBMDcvbExSRHFkOGpMUFdEQll5bDM3NjlPLzVGU0s4?=
 =?utf-8?B?M09sbjhpblE1UmNRRms5Ykx4bWNMSTNBcXVDUWMrajIxcHZCWklzZFh1blNJ?=
 =?utf-8?B?OHp1VzZkSzB2aGJlNjNRalNwcmxXWkNsd0RsaXJ6MSt1bHN6WGhzNDZCSkNW?=
 =?utf-8?B?UTFRd0gxbG9NNWZXMSs0dFpZMUZaQm95eEZDZXpRcU9ZeEpkQTI5VHpvZi9K?=
 =?utf-8?B?Rzd3cjVYcThZaFJSQVR3WTAvZldCWFN5VFhiWCtNMm5xSVVOa3ExODl0MEM2?=
 =?utf-8?B?MHU0TjJycVhSNTZrSkVRcnlYL1pXOUdjQ0pqOVN2bXNCNm5UVWtUa2NPcnll?=
 =?utf-8?B?VEtVUjVjblFNOTNpbTNmS3VzV1RqR0RaR3lickk0U2pYTHgwMzNlS0R6WEJj?=
 =?utf-8?B?WXZ3M0YyVkVObEJWak1od2pFbG1pbXJNbmg5b1Q3K2gvRkQ5RWduUVEvemJP?=
 =?utf-8?B?RkhxNlRWNENzRERzUFJGczZQMVo3UXFtY3Fyck1JT3RVZ3I0UVVIWjUzUUQ0?=
 =?utf-8?B?MVhVNTkrdWd0aGR1c1RuQzBRYk83SXRlNzBYZEdLU2YyQWdpRU8rSkxEQnFa?=
 =?utf-8?B?UnV6Vkt5c0JQc29zaVE0VVYvajB1U2FZV3lvaEorRGpGZ0lhNzFCVkN0Vzh6?=
 =?utf-8?B?Z1lpODNHOGZRbzg2VDlTSXR5ZmhqdzUxUnZScGh6bnhIUVRhUjhYL3FKdFZ5?=
 =?utf-8?B?dHhQUGlVWU9JUXVSSGdoYmQ1WGt5akJRZ0hxNGNhMjRSUzk5dUpvUmo0V0lR?=
 =?utf-8?B?cTRLeGw0SW5mdGpyWm4wN0VTRWlsVWFWdHJ4Nis0RjN5OW8xOGhHWUltcnJt?=
 =?utf-8?B?TWRFbWtNSTN5LzBScXgzY3hsSzNRZHZwcTRueENlU1NkelpiSUJYemFQL0dk?=
 =?utf-8?B?UWVDMC83QkRTd0x5Mi9BR0d4UTJpeFlIYmdLT0lKaEw0VVpjQUM3eG5RTWl4?=
 =?utf-8?B?SXgrcUNTTmdIZE5saDRKeWhwdWh0T1BNWUpJeHcrQzVpTDJvdHRtMWpEdVBL?=
 =?utf-8?B?Y2U1dytMblpWb3k1SGc5M3I4dk1kaGZOZUNGZ0VGZlFLQ3dKWkVmMXFNLy95?=
 =?utf-8?B?cG5VMWJZUnZHOHdqU2VzNXZ1RHZPanNJc05lYmhqYXBFaFRrajgyTzh0Vkgv?=
 =?utf-8?B?b3hFVCtjbERaL1F0NVFQTEN4WHNhNEhVY1BpdGdkZW8rYzRzQ2lheGY0ZWZQ?=
 =?utf-8?B?WlhQUk1sc1A2UWV4VjZuQ1BGRFFOWW9EbUJnMFJ6KzR0Q2I1dGkrSzEwNlk0?=
 =?utf-8?B?aGpqUm5rL2JDWmwxajY3SzlNRHFIQ1RxSm1XN3ZaVHU4SlI2Yy9DYWlnVkcy?=
 =?utf-8?B?VDJtOHdSUmorLzJkWnpJYi9zYTErYmIxQ1F1ZkhuNy84SUZsdExvcWJycXVq?=
 =?utf-8?B?dmFnM2NMS1RqYmtidkNPZHJjMmtQNVAxcUkzUnpNZkh1M2I5UnB5TjFZTUZO?=
 =?utf-8?B?VjBSVTdiV1ByeVV0SUprdG5NeHdkb0w2c1dLMktTLzNkTituWjNvb0RCUXBk?=
 =?utf-8?B?VDBpTzlYcmh5ZHZwME5aaERHMTJQUE9hZms4UmEvVWJuWEsraTkyekpJR0Fq?=
 =?utf-8?B?TS9FQ3V2SXk1RXVVTzdTNEpYRExiQUFFYTVINzByNjd3S1lBRGQzOE1pcGhT?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TpMiZ9dTyQmrywRW99TfAegiGgXF8K9h0XcR3DTBhLH3zwqIcUVYCPR3GNuAT7KRfNeO2E8JmGBcZMgwKEt5zkOBJBLGTqFkSXgnNTFDo4W6xiZrIOCpqOBQp0xO7SvwZ9HF3+FgPS3lAaaGV2auMuk5V3Ao65GPfu2NoOPIAGArm7j+S+tWWRtIcY87YIZvOyqnaa7IawCQD62uiaku+zG7RVZ+/aO1RgivmwjEnOhKH19+A4bEYcdzMvLt4goA13aYpuGhY4OFr41mp++M1JETemoezYGCiJCW5hq3D7zNLO9NjjmdX+A1eTWsSoKbh1z38BafdYPDkjYhBxRDLN99x/E3FjF+EmM2/WOefmQ/9I/HeU7mD2ke/zDAd0QJ8C1ALuheo3QOWNdYKrFDFl3iaJdZLe3ZTGRJog7uCLaNhLSQF0B9E6pbHnvLjmZAaEY7ixII+/riogQlYtN8beZ6kTP22BM4D024Hr9ljpT20Oz8GcxzalVVfnUZbGCMMOQh7A6nLFR5pBBrY1bsEJ1PXkPUlSFoXlA7ODLCkgl73qBSwf4FlNn5viYp8v++md4PAefV5fIYfTerqJUUuL5N1drH+fCZFZ0UTBbooMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc9b6a8-2c98-4e5a-7439-08dc3201e8b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:51:36.2654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIoTP4cGkxyFaETmtTmTsjqDVonLFU5zNpbTIVjmedGt2zcCrstJGLY04Vnj+srevLfsMgEEjfJ+JT4Iemk3aSsZlRDTR61/fvo6tSOSGBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200077
X-Proofpoint-GUID: llC0J2HqjH4HyO_1E1L6wQ3-wE3kAsEA
X-Proofpoint-ORIG-GUID: llC0J2HqjH4HyO_1E1L6wQ3-wE3kAsEA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 19/02/2024 09:03, Avihai Horon wrote:
> Hi Joao,
> 
> On 12/02/2024 15:56, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Probe hardware dirty tracking support by querying device hw capabilities
>> via IOMMUFD_GET_HW_INFO.
>>
>> In preparation to using the dirty tracking UAPI, request dirty tracking in
>> the HWPT flags when the device doesn't support dirty page tracking or has
>> it disabled; or when support when the VF backing IOMMU supports dirty
>> tracking. The latter is in the possibility of a device being attached
>> that doesn't have a dirty tracker.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c              | 18 ++++++++++++++++++
>>   hw/vfio/iommufd.c             | 25 ++++++++++++++++++++++++-
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   3 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index f7f85160be88..d8fc7077f839 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -216,6 +216,24 @@ bool vfio_devices_all_device_dirty_tracking(const
>> VFIOContainerBase *bcontainer)
>>       return true;
>>   }
>>
>> +bool vfio_device_migration_supported(VFIODevice *vbasedev)
>> +{
>> +    if (!vbasedev->migration) {
>> +        return false;
>> +    }
>> +
>> +    return vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY;
> 
> I think this is redundant, as (vbasedev->migration != NULL) implies
> (vbasedev->migration->mig_flags & VFIO_MIGRATION_STOP_COPY) == true.
> 

The check was there to prevent a null-deref in case the device didn't support
migration.

>> +}
>> +
>> +bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev)
>> +{
>> +    if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF) {
>> +        return false;
>> +    }
>> +
>> +    return !vbasedev->dirty_pages_supported;
>> +}
>> +
>>   /*
>>    * Check if all VFIO devices are running and migration is active, which is
>>    * essentially equivalent to the migration being in pre-copy phase.
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index ca7ec45e725c..edacb6d72748 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -219,11 +219,26 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice
>> *vbasedev, Error **errp)
>>       return ret;
>>   }
>>
>> +static bool iommufd_dirty_pages_supported(IOMMUFDDevice *iommufd_dev,
>> +                                          Error **errp)
>> +{
>> +    uint64_t caps;
>> +    int r;
>> +
>> +    r = iommufd_device_get_hw_capabilities(iommufd_dev, &caps, errp);
>> +    if (r) {
>> +        return false;
>> +    }
>> +
>> +    return caps & IOMMU_HW_CAP_DIRTY_TRACKING;
> 
> The false return value of this function is overloaded, it can indicate both
> error and lack of DPT support.
> Should we fail iommufd_cdev_autodomains_get() if iommufd_dirty_pages_supported()
> fails?

Definitely not.

> Otherwise, errp argument of iommufd_dirty_pages_supported() is redundant and we
> can handle iommufd_device_get_hw_capabilities() error locally.
> 
I'll handle locally.

>> +}
>> +
>>   static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>                                           VFIOIOMMUFDContainer *container,
>>                                           Error **errp)
>>   {
>>       int iommufd = vbasedev->iommufd_dev.iommufd->fd;
>> +    uint32_t flags = 0;
>>       VFIOIOASHwpt *hwpt;
>>       Error *err = NULL;
>>       int ret = -EINVAL;
>> @@ -245,9 +260,15 @@ static int iommufd_cdev_autodomains_get(VFIODevice
>> *vbasedev,
>>           }
>>       }
>>
>> +    if ((vfio_device_migration_supported(vbasedev) &&
>> +         !vfio_device_dirty_pages_supported(vbasedev)) ||
>> +        iommufd_dirty_pages_supported(&vbasedev->iommufd_dev, &err)) {
> 
> I think it's too early to check vfio_device_migration_supported() and
> vfio_device_dirty_pages_supported() here, as vfio_migration_init() hasn't been
> called yet so vbasedev->migration and vbasedev->dirty_pages_supported are not
> initialized.

I should replace with its own vfio device probing but the next point invalidates
this

> Why do we need to check this? Can't we simply request IOMMUFD DPT if it's
> supported?
> 
There's no point in force requesting dpt in the domain if the device doesn't do
migration that was my thinking here; but otoh as past hotplug bug fixes have
shown it needs to proof against a new device getting add up that supports
migration while and the unsupported one be removed. So I guess we might not have
another option but to always ask for it if supported.

> Thanks.
> 
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>>       ret = iommufd_backend_alloc_hwpt(iommufd,
>>                                        vbasedev->iommufd_dev.devid,
>> -                                     container->ioas_id, 0, 0, 0,
>> +                                     container->ioas_id, flags, 0, 0,
>>                                        NULL, &hwpt_id);
>>       if (ret) {
>>           error_append_hint(&err,
>> @@ -271,6 +292,8 @@ static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       vbasedev->hwpt = hwpt;
>>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>       QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported =
>> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>>       return 0;
>>   }
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 7f7d823221e2..a3e691c126c6 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -271,6 +271,8 @@ bool
>>   vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
>>   bool
>>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>> +bool vfio_device_migration_supported(VFIODevice *vbasedev);
>> +bool vfio_device_dirty_pages_supported(VFIODevice *vbasedev);
>>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                                       VFIOBitmap *vbmap, hwaddr iova,
>>                                       hwaddr size);
>> -- 
>> 2.39.3
>>


