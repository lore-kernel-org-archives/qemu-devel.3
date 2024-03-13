Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB07C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkPRR-000284-B0; Wed, 13 Mar 2024 10:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rkPRP-00024C-A3
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:18:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rkPR7-0001Lk-K8
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 10:18:46 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42D8hrpP000680; Wed, 13 Mar 2024 14:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dGLQdy4WyQFF26/g0ok/O8WN9V9SLGFZKcUD/774/Dk=;
 b=Cw5M3Ks3NY5IZy/380ZTU+4Xt14sMRoijQVQwiconPMabkhwnxsGA/pN6MmSkVpQaSQd
 gQpilyUvaNs19CQMe1Sg1TAwhf8cDYWLSEqcYkRYO3j6RYFeBmiXqOa+wiwWYpAFg5YI
 I8C2wjcdr2DB/+8Zfcs8a/HUZ/67MU67F2sXUA0xrqxsAmrGAdZbQA6N/ESVsD0+8jpb
 WZmg4421CsmcKlz9gQDlhcVHQdaI9pKdfI+tMQmnh2BIcR+lw9ejOVa5o7OIOoJRcqdL
 hV+rFmTACbi4i4/5xgyhl2W4O1zFinovLG3aMz/uP/LPem9FTs89SIplfMFUMaYH8zxi IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdh6mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 14:18:25 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42DDd79l009153; Wed, 13 Mar 2024 14:18:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7f3d7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2024 14:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCf7A3j9TL1UyQnMYfizAlyRmSqfdLPZENhegV7NCRewx3RZHnKc5LwrkzWHGi8aoq6XPCNVj6yxysOVyDnFJfifnna8xGUEBeLIRhNxXJbnWt1y11/lY3iFrkx/5FfgfpD9+gKNukY8GHeS5CZb9M3R6Tb8647WVBBgTNyyQDeW9e1RLHnLxvCc+BAtF0jvAqhI/FDy8Bm/cDHgGM+tUCatFiOfXCEXQ733oIwpUyQLOgZTHLGCYJG9bmhV5evpYsgJq/OasDPbTfrbWX1Ya2e437IXARfKHoKJ4rEvBOpszarj1qJ5DdDpfJBDuzH+dJ3YhYawYclpCmjSIXYb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGLQdy4WyQFF26/g0ok/O8WN9V9SLGFZKcUD/774/Dk=;
 b=Oz1Fwv//KwTDRud9qV/1bSa9WSfIGUv3LGeRBKvumRIlq1ZYDi8+aKETxTADQ7BBEadijdRZu/WIficBxl3Wwp+lcOkOshYzpUsSVPzMwZLO4aR1ladn75j8LacTkvKneXPsMNnHmFegpcWL9kYv6X1o7twbkr+xlF1kjYjnKoMfQw6jqtDX7ceDTl9AOpEnNYxX8RcDUykNsPi9EsP5RZW4ugd/0EZjIo/TKKA77WpO15c+QVNUReeAQzvvVRhia68yHPZQ+u9km2csuwcFQypoX2w545xMUrV5rY67W8V8Jk2jHS2dwrTLakFw6yTOukfzsDDhBDJPFLKSdwk6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGLQdy4WyQFF26/g0ok/O8WN9V9SLGFZKcUD/774/Dk=;
 b=Fas3TJPQD2etgZmaLF9osffOUyvIcBjkGabFBeAouKxnOhzxkG0uJ12nC1+2PAbjg2SsFp4CRxztAw8M0WTByHPgNGSJ7yx4KpH7bVsbOlSe4K/NBSwzUECbH2nu3S20uH+aIwuFtFvyF7XQHJ49mzy55h5bazciMsvqZ0MhP78=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6595.namprd10.prod.outlook.com (2603:10b6:806:2ab::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 14:18:19 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 14:18:18 +0000
Message-ID: <00ac45c5-2c46-41c1-9cb3-585498d0ded9@oracle.com>
Date: Wed, 13 Mar 2024 10:18:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/14] migration: stop vm for cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
 <ZdvyuazPp6Lrn5Mr@x1n> <9d560585-8f3b-4ad4-82e6-333e8c74b496@oracle.com>
 <ZeEvSLgKW96KCy-N@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZeEvSLgKW96KCy-N@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:a03:338::33) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 712418fb-8225-4122-4d1f-08dc43686dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwc8qIAGZhLL3EgAQelU52COiQVNGr04OpAtpOxt9ReWrP2gtWiptpFwWef6dBRrnsdlSs+lcAQ7CBulagwrxEIAEnY5UJYyeGd77BUfkO68ukE3SgvtP5lKVDe0zGW8fQl1nJ8E+0gIpSZzF+YHEFwAALbfFlRqVJ2xChuEbaWSXPUlS6qW6HgUtJ6PptSdpM7OQsl8t0kqMglSWd+ciyLzvt86IVGk2S3BkK+BUJccPpMhSHtLYrxkJ5bLB/jfh6Mwn0cX0tYYtqMvztVIEhLqAbIH6ccVQe5qdJcgNtzbrrBQ/4b9VWs8u55M5KoQra/meRI8SymMeYndlI4bVtP8wTLY54UHriO+O4UmpFYwKPbNKWx1j2cHZ3zNl8AcybLSTYUYaCRKODUSBIZEyLPrKvI/BEV3/Q2JBdTOaDq86txKqBmi24qQvyQoN7M2tF9pGhUQfkjdc4+xFQ2pL+BzooZAt+dFATO5l66Ln0SwnD525JcKz7BaL2FMPEUCHrCB4uq7Q522b+bE8KRpgNYsyOSdR7pqRmWHmNFSFpVgR46ZiNFnSkWAsxPY4HoXhHzxcKMHYKaph/LrmEr6FTHwx7Q8safl13wcUeD/6LqSphYRZmQpuOTk+3YPkQpQ3bq+q59+Eet6FbWNtXFfUdNvO/QBIW5lNBJyOHg6+0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERmOUlXTjRHRCtacjd2UGJycGZKaG0wQmdrcWhiZnRhMjV1KzRrWVcyeEpG?=
 =?utf-8?B?dWtmRzcyWU5CeVZZUFZBMkt0WWl4NVhyTjRlMVA1OTRwdGpGM2RSWjJIbUF6?=
 =?utf-8?B?STE2b3FvY1NEbXZndjJ1OTZ1Tk9Nd2phQkd6cnM0UjFGQXdUZnAyV1ZBZksv?=
 =?utf-8?B?Z0ZOd3IycnhYeXhvYTY4MEE3M1E2NGo1eFgrSW5wempxY081MWh3SDdzLzk2?=
 =?utf-8?B?MElMSlloT1JSMkdaS3h6RFB1NjBPM1pWRktxaEVTelVkMkErTWdRekNuT0JD?=
 =?utf-8?B?VWRFMDdiSWdpSkdpN1R4TE9NV2hkQ1RjbFpwL0JhR2UybzNCQzd3MEZveGpi?=
 =?utf-8?B?TUMzaWdMejZZSG5hVzVIS3Q3S1JMd3JLY25wVnpFM3ZZbFB0YkZxQW8yWXIr?=
 =?utf-8?B?dmRqRDFtaytlUWUxeldhUVgzYnh5cmdzTEUxOUo3K0FSQXhGbWtUN0p1c0dK?=
 =?utf-8?B?ckgyZk5uU1l5SjlYTE45SlVKUXZwMmRCUUY1dHcrdnBid3NQSnNmNXc1ZXdt?=
 =?utf-8?B?VXh2alcwUTRQdmdWRk1QeDZaYk9UUFlKZjZzL2RPb0Q1WGNWaDZIdGJoaktN?=
 =?utf-8?B?MGVBZkRhblJ0VkJ3MUYyaUx3ZStEZm1wTlJicjN3NmdDd2R4UTI3ZWFwWVJk?=
 =?utf-8?B?WFp3dEd0TDE0cTN2bndsdTZPVmxQc2I3aGV1V1B3S1ViREdzR0dRdVQ3SHBs?=
 =?utf-8?B?aXljejlkaHpYdUtleEFhZC9OclRZWUIvSjN3M0VVMEV4TEt6a1pmVHgrWEI5?=
 =?utf-8?B?RktXYWZndXErRXErZ1JjL3NiUkg0NnlOYkloZHdaUUM3Y1NqWnVUakUvK2o2?=
 =?utf-8?B?RG13VU5XdWdnMHAzWEFsYmhVRHF6YmhoUEoreGo2R1d6dXZ5bGNicmpRMFNr?=
 =?utf-8?B?UmNiUG9rcGhpMWUyeEtpMlVKZ0Z5N0hWNkJxWWpSWlNGV1IxdnNTWmFKVDRH?=
 =?utf-8?B?R3pzUzJFbUlwS1h5SWh5dGpzZUszU0NYNmVqOE9xYjlLVWZ0bEN2S1JmTTh1?=
 =?utf-8?B?VVdYakJ2TndaVDQ3UG5QV3libER5L0tocFF0bUhXQXliVExERXdSK0JlaVAv?=
 =?utf-8?B?cDBKR0JySmNHQzlWRzFwZzNKdzhtbm5IclBpZnYvWStPWjlIT1JGLy94QXZK?=
 =?utf-8?B?ZVk3T3FIWkN3aWFQMWlKWTA0UkFnZ2h1OEU1WTFnUWlsWWE2M0tlRjZVbmpu?=
 =?utf-8?B?eEJEOGM5eXpBcExFdTFpSXEyTlNySFBVc21HSEtIMElsL0JFbnM3N1lPUXVQ?=
 =?utf-8?B?Rnk0eHY2Nk5RVEFDR01PZHRicmlvS1UyMTViamorWUF0Y240SUROT2k5cEZ1?=
 =?utf-8?B?VlFudGt2K0hMcTdLZjNwMkV5ZVFsRStSWGFSUFlVMGthYlpHN003eHhWL0VT?=
 =?utf-8?B?NzlselZrUjdXd0dNQWx5dGdYd2c2WjFWSzBIS3RNa3ZvaFFkSG1DL1QrdGJn?=
 =?utf-8?B?eHZQaEJpdjNGMGk2bzc4NlRQU3J4MHQrQ0tFalRLVkFPd3RSZUdxR0x0VG9i?=
 =?utf-8?B?aml2MklVT1J4K1c5VkJQcHJRQzE0ZCsyTHQ4YWhpNk93ZXRxb205QXJkNG1M?=
 =?utf-8?B?RWVSR3dBUzdibDZ5NkNMdFdzN1p4OE16K1g4aUk1L3lpUlYybVNBQXE4SGEr?=
 =?utf-8?B?MDJFRWsvT01ZNWMwOUhGSy9zR0kvUFFNaDk3YW41NVBTY1ZxOFg0TXZtTUph?=
 =?utf-8?B?cXQvMTBrRnh4WkU4cWxibzRHK1Qvb3lTb1ZLOEhveVlTMzgzVGxnSEVoUEpY?=
 =?utf-8?B?MFhFOVU4RnVVcWNZNXJIcG1ub3VqNUFGaCtVYVF0VDRlZjl0MFJqbzNNOXJh?=
 =?utf-8?B?VzFmMkkyKzJ6b1FLWWpvdUc1c2Exb3RWNTVGd09GZUFZU3M2ZFFqNlllQm5x?=
 =?utf-8?B?bUJKQ0U3V2tqdW1uN2xhUHJNQWZ0dDd1cFVsS1owT2pIUnVNOFBlcklleUht?=
 =?utf-8?B?ci80TWNnN2QvbkswUlFtNDJ2OXR0dlJVTzFIWUJMRld6MDJMT0MzT0NGZWZ2?=
 =?utf-8?B?UUpqdnpQdFlQek5WcjFuZ1pldzNtamppRmsyZEpLVjBNcHI0bEh5ekhiOUo3?=
 =?utf-8?B?T0U3aVJzTE9sblBadTBUUUlKUXJvVjg2VUVLY2I1MjNVdW1rUUNHNVRTa1Zv?=
 =?utf-8?B?RzlsQXRlMXNQRWpnQ2NNc0Y2azZkVGxhUlErdlowcG1OWXBZWDFKZmxsYitJ?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 73ITWJo/k5YCp20+Z2FjA2NMbtUcUHVB7NrqW3DNFZz+gIc0uphnNDD8ZBmmbpWt1Kb96j3dJuS4fqNZK3zenzeutRjN4+079yG/EjEmOLUIBehv3gJ1tZ4hvDrwDoJOMqBNrs+Hs4e1ZpIQt420BJEcgyoRNEYcDdfs08PJNznvXs/CGLhWJs04LJunX6ingpW5/MEPADLCyUBEknyRJQwzcdHp8Iv+1HR6yiPgNwP0woYQxiSKEdNzYlBn4a8LDuBV5qMb3lHiXbLwIp6Fph9f+3Wk5lcbg26JBFy4htOBUjgVPhN+WFzeTUXmIIJegkB/6YCvv9tNZ2OwO+6FRShdUCLVEumQUtOaP22lmJ/Ydgn7GYckSURNMgpNXyyWr2PwW0oQBBzmGYn0ai4b1OlchPQthYfr8C3chccYK0KM6j9C+CZPDmFUJEcSse5772GJFtDux7sqmjaU/8A+UvVX9JCgRaiqRQgaiqTiWiKu55Y+XHs+o4g3C+SYoMK/nCvfceRREOdmpZEzkgXw9QcFpz60KKBm6+Z7VgIU7T7BdIaNz7yC4j5gVXcRet661vzY7fVOvWAWfRk2yrc9JtH10z2Zg8yWnijtIsO4djs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712418fb-8225-4122-4d1f-08dc43686dcc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 14:18:18.0316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2CwW5SB/Ur2MFQX+C42sDXSGv21D/uCBh5piXmBn6tU0bRWhCSu6GVHxTU0WEe43RVASDAZE8E7wIBikONN3ZxNbJEisr63JfJ2Lyx/AK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130107
X-Proofpoint-ORIG-GUID: K74YiWaLXibRKKW28RmsXpj87C48kiTL
X-Proofpoint-GUID: K74YiWaLXibRKKW28RmsXpj87C48kiTL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2/29/2024 8:28 PM, Peter Xu wrote:
> On Thu, Feb 29, 2024 at 10:21:14AM -0500, Steven Sistare wrote:
>> On 2/25/2024 9:08 PM, Peter Xu wrote:
>>> On Thu, Feb 22, 2024 at 09:28:36AM -0800, Steve Sistare wrote:
>>>> When migration for cpr is initiated, stop the vm and set state
>>>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>>>> possibility of ram and device state being out of sync, and guarantees
>>>> that a guest in the suspended state remains suspended, because qmp_cont
>>>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> cpr-reboot mode keeps changing behavior.
>>>
>>> Could we declare it "experimental" until it's solid?  Maybe a patch to
>>> document this?
>>>
>>> Normally IMHO we shouldn't merge a feature if it's not complete, however
>>> cpr-reboot is so special that the mode itself is already merged in 8.2
>>> before I started to merge patches, and it keeps changing things.  I don't
>>> know what else we can do here besides declaring it experimental and not
>>> declare it a stable feature.
>>
>> Hi Peter, the planned/committed functionality for cpr-reboot changed only once, in:
>>      migration: stop vm for cpr
>>
>> Suspension to support vfio is an enhancement which adds to the basic functionality,
>> it does not change it.  This was planned all along, but submitted as a separate
> 
> If VFIO used to migrate without suspension and now it won't, it's a
> behavior change?

VFIO could not cpr-reboot migrate without suspension.  The existing vfio 
migration blockers applied to all modes:
   Error: 0000:3a:10.0: VFIO migration is not supported in kernel

Now, with suspension, it will.  An addition, not a change.

>> series to manage complexity, as I outlined in my qemu community presentation,
>> which I emailed you at the time.
>>
>> Other "changes" that arose during review were just clarifications and explanations.
>>
>> So, I don't think cpr-reboot deserves to be condemned to experimental limbo.
> 
> IMHO it's not about a feature being condemned, it's about a kindful
> heads-up to the users that one needs to take risk on using it until it
> becomes stable, it also makes developers easier because of no limitation on
> behavior change.  If all the changes are landing, then there's no need for
> such a patch.
> 
> If so, please propose the planned complete document patch. I had a feeling
> that cpr is still not fully understood by even many developers on the list.
> It'll be great that such document will contain all the details one needs to
> know on the feature, etc. meaning of the name cpr-reboot (what is "cpr"),
> when to use it, how to use it, how it differs from "normal" mode
> (etc. lifted limitations on some devices that used to block migration?),
> what is enforced (vm stop, suspension, etc.) and what is optionally offered
> (VFIO, shared-mem, etc.), the expected behaviors, etc.
> 
> When send it, please copy relevant people (Alex & Cedric for VFIO, while
> Markus could also be a good candidate considering the QMP involvement).

Submitted.

- Steve

