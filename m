Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AB6CF07B7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 07:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1synAJ-0005Ej-Pb; Thu, 10 Oct 2024 03:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1syn9x-00059j-T6
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:00:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1syn9t-0004tL-I4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:00:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A2trql028358;
 Thu, 10 Oct 2024 07:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2iuD6BlRN6dw/HRn84GwNBdFs4cT04neAcnjHT54r+E=; b=
 admxx6T7bev0jYA/Tze4SGpiuFEZ2la0YFo7se4O+ZctJhYpUg3jSCSFETKwMMql
 p41ClXj1wVITKbBG/9Gzt3ipVSYfe1U1xSlayUc6QLUimVUW9kWDv0JCDgfQSvNL
 5eO4yhhL7d7XCZ2fvR8tTJWmrXL89GWPy/wxsB5IjL7HImrp4kLTSbEaa+Wf39mI
 dDH5uYD2sAC109HGNiAp7EZDN2kad4F6Q17Dve7pAr1BlW2ax5qxX+IaSh2QxqBf
 oYBfXsguOmw1430T9tsXl4wRD79MhXZTbwEAE5B8iQ0aD3vIB8FqLYVEBZgKhjNw
 b9eBAPX0CSIzMmPzovEQ5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302phwnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 07:00:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49A5dgGK019110; Thu, 10 Oct 2024 07:00:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwfxc11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 07:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9NyH4CDslrOkM1fX1jRwAKf0jnC1CSJNi4He/ItXoQB+BFogwoZSGVMU79V7XWew7SJDxz3p7cBWpaXRMcxuz/NiL9DtZC5DJW37IgXex4kQL+WtYZKF2znId1NEUaItAG88SjQHkH9+FQyE9wUk0EvLF9y/9815tbJuIND0bvNBNsoy2jkQ/Kt1iPjpLwWOJ3NWRD+njrl8r8HhvsfLbgNA+YkvK4Z4jhpYCFB9SUXneAkmkohl2We29NB8cRAIhRw+d3ySb8Xpom6ycglpbaLXXuuy4iEKbpcVS57RT/Aj42X95EZXlmJfIiog3YoNSFtEVF0HUg6TQJIDBdY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iuD6BlRN6dw/HRn84GwNBdFs4cT04neAcnjHT54r+E=;
 b=nLAcEiJjgqGc0YLfYcmhMrLLqSjTrR/md65qvv+Ae/e0wnrHTrPxZI1QMau1OPhuYxLTJNA5TjDb/j+3s8I+gKUawpxj1gl0kSA4RVWT47WglsPtYfMaqcQ3ErkqNEN2TZRuN8oIBOAadT9Y7/cB4qTZUuaPEMakARyUCi9VqbcvU1ooJjPkd9aG458cnU2U/6NbhLxYXXMoWnBCQpLDvvf/oCZrD7mKBvJqCyYFpoNHKILNIcpcvEN4ZXjNjGaup1KANgJzvljgALVMoXY7+YnWZYeN0Js3G3NHR7R2Zy43jOsbVUzd/LwjC9Wg7TghkzJUxL7BDpEQ4x2uuQvG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iuD6BlRN6dw/HRn84GwNBdFs4cT04neAcnjHT54r+E=;
 b=JMzo234EZ4joCWQY6l66W8cdnGRcXOewWYaeqWVPKxknmlW6mUyAqDuLuLX9GdtuqRUq/EuHSV545f3g2YzcUq6SYdS50QGG7g2ngLWp12VDYftU7Y/ch29eo2E0KjrVaEVGfqREF9UNJgI1fjckMh/6mhgwwNkx7IkS2/EP0vo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7576.namprd10.prod.outlook.com (2603:10b6:610:17d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 07:00:15 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 07:00:15 +0000
Message-ID: <5444a3e3-d004-448a-bdf7-d366f37ea3b6@oracle.com>
Date: Thu, 10 Oct 2024 00:00:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, boris.ostrovsky@oracle.com
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
 <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
 <5ebfd766-c8b5-4fb3-86ad-17a74212ef5e@oracle.com>
 <c0983e7c-b857-46fa-a6ec-82215829bbc7@oracle.com>
 <CAJaqyWcP8EyE+nyCF1JBouhQp8Lgi5RwoK7SCJe8QKoshDfbhg@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcP8EyE+nyCF1JBouhQp8Lgi5RwoK7SCJe8QKoshDfbhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a65ce5e-3ede-4177-455c-08dce8f93104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjJNTkpZYVFwOS8xdWtsRUhkTFp2Zjg5Wlp5M0dYZVFKWEpVYmQ2MWxVK283?=
 =?utf-8?B?ZUxwaExlcDJTSXNZTUlDbTRXYjh3emkrMTNBZDBPL0hZamVEYjU0bDFncnY0?=
 =?utf-8?B?Q2hDdGhPNDQxRFVxaUxzeHg0eEpReEQ2WkJ0TVM4Y3plbmhyWitjU2NJOWZT?=
 =?utf-8?B?MDRsc05kVkI0MWw3Yll3OExBSE85VkwrMndyUnl2MzRCRmVFRmxUZFdmSDYy?=
 =?utf-8?B?cmUyU29vUmE2NzZVVmNyNHBMSHVBVlcyQU9lM3pJdDNIMFpmMzhSMkFoNCsy?=
 =?utf-8?B?RTMrUEN1S1ZkTUFpVm80cnV0OEpLc2xHWGZVSmVITVYwZkFWWDFsWVEzUkly?=
 =?utf-8?B?VW5jN1YxWWxrTENxNkFCNXk1UHRZOXgvYVBQaG1ndXRQNktJS2FjdkdNUEFs?=
 =?utf-8?B?c0JwcGREMWFHYjBOOGZrV1ZYa3VMbkhWRVNvTDlOTE1lYmdtR2JSakZweE1v?=
 =?utf-8?B?KzQxKzdXMkpReVNSMVA3YTRBUk4vRHRucU1SM1lJMkNOTFNKRFN4ZkQ1ZUdM?=
 =?utf-8?B?VUc2MXAzbS9CRXl6SFpzV3BsVm5ZSTJyeURDMC8yQmRyNm5qRTc1SGplZy9v?=
 =?utf-8?B?LzZoOVRwUkFtaEdJUDVDdlNHM1l1c0lOQS9UOUt0dm1pWWwrSW4vWjJBTnFl?=
 =?utf-8?B?RXlLQlZNMHJHdzBQK1VCNkUwTlBBMFBsS3RFQ0pPZ25JSmZGczZlamREdHlM?=
 =?utf-8?B?RmVkNjE4VEV5UmVudWFSZnZzME9QVjIwY0loZW5iRDRyaXlEbDZkcVRKcmZX?=
 =?utf-8?B?TlpBeGhmVG5FWU92U0FYT041YXhGdStDMDNmK2JyYmQvMm81ZXJMcXR3OFZo?=
 =?utf-8?B?NXhsTGlhWVdNZzJZb3dIZFAvK2FzUVV1WlpIbEgvVFUwTWhqNkJVc1orYlhB?=
 =?utf-8?B?L3kzTCtQb1ZSaS8welJJMnZ3QkRieWdxc1RpZkw2THNEaEFaYjJXL2dQcFZh?=
 =?utf-8?B?RllNM0pSSHJ0NU9STFgxTkUxeEFabEFFUUg0YVdhRWhScitsK09vR0N0WmND?=
 =?utf-8?B?eDFZakxlL0hNWHBHbzYrZVpiZXZTbncxTWI4alYrQXFKNHNkczlLRWVsL1VW?=
 =?utf-8?B?TkJTNjNUdGp1dW5OYnFJMjdrNzZpNmZ0NDZZMXRhUVoxWlBUQzh3SlgvTDNK?=
 =?utf-8?B?aFVOV1VTZ2dZNG03SDM0YVdRZm9xNWpjWU0rSzJsYndLdmxDOGsrTFNGUjNx?=
 =?utf-8?B?aU4wcWZibmlwWTgyTzNFamxZMDJxcEhRWXBRdXVwd1g1bmpITHRyUXIrQjR4?=
 =?utf-8?B?SEVXVURNQVdBaEtkREcyYThsS0RIRDBGclpHdnFjSXZ6c0luRFhjYVpmMm5W?=
 =?utf-8?B?eElVcjR1UGRjSHF5VlFKT2p5ZGRPYVNxZ3VXSldtN1o1cE04MlhrRDVRaGdQ?=
 =?utf-8?B?aitQR1ZhWWpWM3JLeXFKMlZwVGJGVHgvWGdBKzI3aXd0MTRXNFo5dFRMVTVM?=
 =?utf-8?B?NGs4a2dnUXZZOGp0VWhrQVdOTHZxdnZCYTN4Rit4TzRVcUVIMXlNdnNMTGw1?=
 =?utf-8?B?SVR4d1JqeGVMN2JSZm9ZeExnUG9wUTNkMEFEdlBXM25XN3Qxa0l3cGdJQ1dX?=
 =?utf-8?B?RWxQNmxLc1VEcVgyZEpIcGtISFNlc3BZNTRtNVU2bCtCQTZYeTRKaTVaZUMx?=
 =?utf-8?B?bU55VWtpejJ2bUp0ZDMzRHpXVktxRFVDVE52ZGplWHRxZWk4Zm9HRUg5bXpN?=
 =?utf-8?B?TDdwVnFaN25GazkzeTR3WFZSQUtCVERaQk5selRuU1JnOHJidGFEOUNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1ncms5MHkxOW4wM29odmhveVowYVdqTWJab0pjbmRPL3hPRllaTVhVWEIr?=
 =?utf-8?B?SDlZSDB4UXhYUXJoTDRTWEpBU1Y0VXRNVUw2czBLVVNFZVBPRkRDcnlNclRp?=
 =?utf-8?B?VXBzbVhlQkF0UnFYT2E2bzhqeFNkY3dua1UxeE92Mjd0N3VwcDdXVTNpM3la?=
 =?utf-8?B?T3Jwa2dvbU03VnVpVE11OXZ4NDBiN1BrMWpwZ0RHM3hncmJmdkpYcGt3NkZw?=
 =?utf-8?B?d0VBNlhaQkpaVFlETkJTOXpwSU9aZWt3VEU4TnNrd3ZyekJzbFh4WGw5eUxa?=
 =?utf-8?B?ckdDY01NYS8vclJpbzBJSjU1RXY1cW10K0YxRENIZTJHSHFqTnZ4Qmhqdmcx?=
 =?utf-8?B?RFM4U3VsTTNtUW9PNjdZVWQ3RG1qVCtILzlRNnpHMGxSNmVhS3JxZTBkQXkx?=
 =?utf-8?B?RWdzU1Fmd3ZzSlhsdE5WTmN6Mkd5RElSZDRMQ3pLK3p1TGFyWGI5ODNzNy9H?=
 =?utf-8?B?a29DRCtPR1BpUUxFRDNURXlDcGFMbnJ2WGFEKzZ5Rms4Nm4wUlJoR096dmxa?=
 =?utf-8?B?WElaQ3VCN21PVnZBdGtscHB0R2NkSXZ1SGMxOWw3djhZVnoyZWcvTlVZSk9l?=
 =?utf-8?B?K1RpQ3Q1U2R2NWsyNUE3Y2tNWjBOSDRaZnpnUWRENXNEcm0wZTNoelN6cjFE?=
 =?utf-8?B?SEdDRCt5ZmlNQnY2b0N3dnNuMlh5NE1WMTZoaHpLaUxUaFlJZWVUN1kwWXA5?=
 =?utf-8?B?ZnlSVDVaY2FTVXBBSjF5dmF5d3E0d0sxMHZoOEZpSm5oWkxaS0dTdGZTQjE2?=
 =?utf-8?B?UGRhYU5DSFloRU9WTXVsNWY2dE5JczNwWVZaM0piVVkvOTR3SUVtcFVRSlZE?=
 =?utf-8?B?bG1tRVZ4MEl2cHNpTDZldW4xdDRtYWJtanAyNDJyWENQQ0NncWRkZ0Q4UWFU?=
 =?utf-8?B?cDNHTTR6WDFlTjNFTEM1d0FrTTd5VGZzMXVWdHFvRXJuaVNWQXd3RW96aW5u?=
 =?utf-8?B?bjI0ZCtlblhGSEEzL3dPN25yR2FzbVNUc05TM3BnUUJqMWcvVVdVYkhzYkk3?=
 =?utf-8?B?RVVKMVR4ZUl5akxEazNIWjBvelpTc21RWVVkYUJnWXV6bzNlZ2xJMmNTMko0?=
 =?utf-8?B?Yk54RnVvWXNvZlZ6cGpjaGExUVZIZWx2alpYWWI3eUhMTXFSc0F4TnpWb2NP?=
 =?utf-8?B?ODUyVkdxMTJZdi95YXRJSHQxZ29LZmlvbG13dVZvU2lyZzNSQk1YWFBiUXFK?=
 =?utf-8?B?RDRwUmpRZ1hMTTVpOWdwdTRjcEZCcjdrdElzUGRpTW5EZzg4V3F4ajJOOXBF?=
 =?utf-8?B?S0syNnNGcVBJVGxldWpwaThqa1NROC9acjFNMnhzdHVhdUh2Uks2WTAwajRq?=
 =?utf-8?B?K09IWXFMYnpGcnprNUFIdHlXYjdWTFlmR0JPZ2xjK3VpaDRVOVhpNjAzVHhV?=
 =?utf-8?B?dmRxMUlwRTlzbU1DVjh3MVQra1VkWjVzOVAwTmNnSmxCMU01TlhuU0N5UUY4?=
 =?utf-8?B?dGd0VXRlMnBXbExkbnVpVFhRUEplcDJhcUNlVVhlVDJMdUI1QmxTWVZRZGhS?=
 =?utf-8?B?c3d1Q3dLaFNyekRHQXpKblpKRm5lNmlPd2V6cFFQUzBTK01vNkQxMjZsNGZI?=
 =?utf-8?B?amN2SkZkTVRnbloyWUlwMEJXNi8yeHgvZk5HS01HM2JnL2dnaDVSYVFJZEIz?=
 =?utf-8?B?UFpveFJQWkt1Mm5VcWI0dEtNajRuWWJrNjRpM0lwOWV3ZGdSQmNPTWdvNFhZ?=
 =?utf-8?B?OFV1amIydXFhSUI4Y1pxUmNDLzllU3Y1blVYYTVab2hZMDQzL1lYTnFObDlE?=
 =?utf-8?B?VEEydnhtRDN0VEMrMHNiczJDRHNoOXlkbmwxZU1YaEpkQ2hELzl5VEFEUWcz?=
 =?utf-8?B?cFlvWGdNcnp1S0h3WG4zaXh5TGZub0NabW5Xb1pnVkdBandhQlM3RGRIMUFT?=
 =?utf-8?B?YWFtTU9sQXZxblE5TXJ2TUpzaEJSVDlmNkxsQW4zUlgzaUJnT0F1Q1llN3Y1?=
 =?utf-8?B?VldTUWo4d01DTUtTSDAxQTBrQkVTa2VOSkc4U2dvMHlDTEhpYnM3WVJvT3Q0?=
 =?utf-8?B?Mk00MnE5RmVCTzdHQW94em8vYzhjMjNtWjliVnB4VmIrOGtkem9Cczdad1Uy?=
 =?utf-8?B?UGRpTHNnbDBBZlRSNkJtNDY4T1VUdWJGaGJEVGNmS0crYnVESVlIdGY3MFRK?=
 =?utf-8?Q?EZpxl9P4plmAAMK/hBiQToica?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a7xIm5YsYFgz27+qqGCylzs3scjvJwxwDJ0o+kTM7drlHx7Xm2ZzyUrU9O7zx39fAZw/9k4VQynKUtF5v+auW0D3Qils1mGysBVZWKlWMtwPWFW54vTLANsFNa7igWMVtLY5hlDU0YJnWNZLaWdJEVaTTgD9t1yhZITVdWQUlBQ9uTVGXchGZmGOojjSg6F2EaWBAEwp+iOHumHQ75Mm7j0bruPEPsMNcRDucC6CIYPGm01a6z59ENj+bDsIptmIaW4z/9/DwP0iKEaXmo5hwaOleLYDWFpiPPcUbpG/k0NyD9XvGBecpMqrYRGw6oIxUll6Yz+Lr4FUFH1xZQDJcTQQb5UZU10eEhV8SrKpD0ubbC5Wc49uasBB47YYq8cQGK0Ewxt+maw+KHmHFfc6d8NlwCJYLgdD/Bypw5+5o7XFGE/MGygg73BvsPa93bnLT9t/l3vT75av7D0MuH+TSVv4DZiWIss5GQZAJE/V541zPNcxrPme0FxTqBFbunQmGFLM5W5rrNuw211gzXl3Vp1ZjCLe/i18ygmY6w36dPxvOuBHbOSVysSoCa642qaAS2TUmyktj2hCfHFnpsIsC1ZeYj4Z677zlK1D8R3rsC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a65ce5e-3ede-4177-455c-08dce8f93104
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 07:00:14.9030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i2Rm5dtg6opEnVY+dW4g2rgtgvSp/ihwvx5fa3ZtnCuxZCVbYKPWyXENGfIMZyNDPoTHkMZJMnKmlzQ/uJu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_04,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100045
X-Proofpoint-ORIG-GUID: tiq9nobm8y6J8oDeC3yC5KFlpFbRHUOi
X-Proofpoint-GUID: tiq9nobm8y6J8oDeC3yC5KFlpFbRHUOi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/9/2024 2:29 AM, Eugenio Perez Martin wrote:
> On Tue, Oct 8, 2024 at 10:30 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/8/2024 8:40 AM, Jonah Palmer wrote:
>>>
>>> On 10/8/24 2:51 AM, Eugenio Perez Martin wrote:
>>>> On Tue, Oct 8, 2024 at 2:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>
>>>>>
>>>>> On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
>>>>>> On Fri, Oct 4, 2024 at 8:48 PM Jonah Palmer
>>>>>> <jonah.palmer@oracle.com> wrote:
>>>>>>>
>>>>>>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
>>>>>>>> On Fri, Oct 4, 2024 at 2:45 PM Jonah Palmer
>>>>>>>> <jonah.palmer@oracle.com> wrote:
>>>>>>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
>>>>>>>>> translations for guest memory regions.
>>>>>>>>>
>>>>>>>>> When the guest has overlapping memory regions, an HVA to IOVA
>>>>>>>>> translation
>>>>>>>>> may return an incorrect IOVA when searching the IOVA->HVA tree.
>>>>>>>>> This is
>>>>>>>>> due to one HVA range being contained (overlapping) in another
>>>>>>>>> HVA range
>>>>>>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use
>>>>>>>>> GPAs to
>>>>>>>>> translate and find the correct IOVA for guest memory regions.
>>>>>>>>>
>>>>>>>> Yes, this first patch is super close to what I meant, just one issue
>>>>>>>> and a pair of nits here and there.
>>>>>>>>
>>>>>>>> I'd leave the second patch as an optimization on top, if the numbers
>>>>>>>> prove that adding the code is worth it.
>>>>>>>>
>>>>>>> Ah okay, gotcha. I also wasn't sure if what you mentioned below on
>>>>>>> the
>>>>>>> previous series you also wanted implemented or if these would also be
>>>>>>> optimizations on top.
>>>>>>>
>>>>>>> [Adding code to the vhost_iova_tree layer for handling multiple
>>>>>>> buffers
>>>>>>> returned from translation for the memory area where each iovec
>>>>>>> covers]:
>>>>>>> -----------------------------------------------------------------------
>>>>>>>
>>>>>>> "Let's say that SVQ wants to translate the HVA range
>>>>>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>>>>>>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>>>>>>> with addr=(0x20000c1000 len=0x10000).
>>>>>>>
>>>>>>> The VirtIO device should be able to translate these two buffers in
>>>>>>> isolation and chain them. Not optimal but it helps to keep QEMU
>>>>>>> source
>>>>>>> clean, as the device already must support it."
>>>>>>>
>>>>>> This is 100% in the device and QEMU is already able to split the
>>>>>> buffers that way, so we don't need any change in QEMU.
>>>>> Noted that if working with the full HVA tree directly, the internal
>>>>> iova
>>>>> tree linear iterator iova_tree_find_address_iterator() today doesn't
>>>>> guarantee the iova range returned can cover the entire length of the
>>>>> iov, so things could happen like that the aliased range with smaller
>>>>> size (than the requested) happens to be hit first in the linear search
>>>>> and be returned, the fragmentation of which can't be guarded against by
>>>>> the VirtIO device or the DMA API mentioned above.
>>>>>
>>>>> The second patch in this series kind of mitigated this side effect by
>>>>> sorting out the backing ram_block with the help of
>>>>> qemu_ram_block_from_host() in case of guest memory backed iov, so it
>>>>> doesn't really count on vhost_iova_gpa_tree_find_iova() to find the
>>>>> matching IOVA, but instead (somehow implicitly) avoids the
>>>>> fragmentation
>>>>> side effect as mentioned above would never happen. Not saying I like
>>>>> the
>>>>> way how it is implemented, but just wanted to point out the implication
>>>>> if the second patch has to be removed - either add special handling
>>>>> code
>>>>> to the iova-tree iterator sizing the range (same as how range selection
>>>>> based upon permission will be done), or add special code in SVQ
>>>>> layer to
>>>>> deal with fragmented IOVA ranges due to aliasing.
>>>>>
>>>> This special code in SVQ is already there. And it will be needed even
>>>> if we look for the buffers by GPA instead of by vaddr, the same way
>>>> virtqueue_map_desc needs to handle it even if it works with GPA.
>>>> Continuous GPA does not imply continuous vaddr.
>>>>
>>> My apologies if I misunderstood something here regarding size &
>>> permission matching, but I attempted to implement both the size and
>>> permission check to iova_tree_find_address_iterator(), however,
>>> there's a sizing mismatch in the vhost_svq_translate_addr() code path
>>> that's causing vhost-net to fail to start.
>>>
>>> qemu-system-x86_64: unable to start vhost net: 22: falling back on
>>> userspace virtio
>>>
>>> More specifically, in vhost_svq_add_split(), the first call to
>>> vhost_svq_vring_write_descs() returns false:
>>>
>>>      ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num >
>>>                                       0, false);
>>>      if (unlikely(!ok)) {
>>>          return false;
>>>      }
>>>
>>> Maybe I misunderstood the proposal, but in
>>> iova_tree_find_address_iterator I'm checking for an exact match for
>>> sizes:
>>>
>>>      if (map->size != needle->size || map->perm != needle->perm) {
>>>          return false;
>>>      }
>> The permission needs to exact match,
> Care with this, read only buffers can live in the guest's RW memory. I
> think the only actual condition is that if the buffer is writable, the
> memory area must be writable. If they don't match, we should keep
> looking for the right area.
Indeed.

>
>
>> while the size doesn't have to. The
>> current iova_tree_find_address_iterator() has the following check:
>>
>>       if (map->translated_addr + map->size < needle->translated_addr ||
>>           needle->translated_addr + needle->size < map->translated_addr) {
>>           return false;
>>       }
>>
>> So essentially it does make sure the starting translated_addr on the
>> needle is greater than or equal to the starting translated_addr on the
>> map, and the first match of the map range in an ordered linear search
>> will be returned, but it doesn't guarantee the ending address on the
>> needle (needle->translated_addr + needle->size) will be covered by the
>> ending address on the map (map->translated_addr + map->size), so this
>> implementation is subjected to fragmented iova ranges with contiguous
>> HVA address. I don't see the current SVQ handles this well, and the
>> reason of iova fragmentation is due to overlapped region or memory
>> aliasing (unlike the GPA tree implementation, we have no additional info
>> to help us identify the exact IOVA when two or more overlapped HVA
>> ranges are given), which is orthogonal to the HVA fragmentation (with
>> contiguous GPA) handling in virtqueue_map_desc().
>>
>> How to handle this situation? Well, I guess Eugenio may have different
>> opinion, but to me the only way seems to continue to search till a
>> well-covered IOVA range can be found, or we may have to return multiple
>> IOVA ranges splitting a contiguous HVA buffer...
>>
> Not sure if I followed this 100%, but we must be capable of returning
> multiple IOVA ranges if we trust in SVQ to do the translation anyway.
>
> When SVQ starts, the guest memory listener already gives the GPA ->
> HVA translations fragmented and unordered, as QEMU can hotplug memory
> for example. Let me put a simple example:
>
> GPA [0, 0x1000) -> HVA [0x10000, 0x10100)
> GPA [0x1000, 0x2000) -> HVA [0x20000, 0x20100)
>
> Now we send the IOVA to the device this way:
> IOVA [0x2000, 0x3000) -> HVA [0x20000, 0x20100)
> IOVA [0x3000, 0x4000) -> HVA [0x10000, 0x10100)
>
> So we have this translation tree (assuming we already store them as GPA->IOVA):
> GPA [0, 0x1000) -> IOVA [0x3000, 0x4000)
> GPA [0x1000, 0x2000) -> IOVA [0x2000, 0x3000)
>
> Now the guest sends this single buffer in a single descriptor:
> GPA 0x500, len 0x1000.
>
> We need to split it into two descriptors anyway. Without memory
> aliases we're covered at this moment, as virtqueue_pop already solves
> these splits for us in virtqueue_map_desc.
That is what I said above, this case (contiguous GA backed by fragmented 
HVA ranges) is well covered by DMA API called by virtqueue_map_desc(). I 
was aware this case has been handled in the current SVQ code, i.e. 
reflected by below comments in vhost_handle_guest_kick(). This is 
definitively clear to me.

                     /*
                      * This condition is possible since a contiguous 
buffer in
                      * GPA does not imply a contiguous buffer in qemu's VA
                      * scatter-gather segments. If that happens, the buffer
                      * exposed to the device needs to be a chain of 
descriptors
                      * at this moment.
                      *
                      * SVQ cannot hold more available buffers if we are 
here:
                      * queue the current guest descriptor and ignore kicks
                      * until some elements are used.
                      */


> Now I realize that SVQ may not be able to cover these splits with
> aliases, as we might need to return more addresses than MAX(out_num,
> in_num) in vhost_svq_vring_write_descs.
Right, this is the case (fragmented iova ranges with contiguous HVA 
range due to aliasing) I was referring to, and is not handled at all in 
the current SVQ or vhost-iova-tree code. This means we have to handle 
the 1:N mapping for each iovec, which essentially introduces unnecessary 
complexity rather than simple or straightforward change as claimed to 
be. Sorry for speaking straight, but I don't really see major benefit in 
either performance, extensibility or flexibility following this 
seemingly interim solution.

On the contrary, instead of simplicity this is becoming more than a 
headache now - Jonah and I have to take extra caution of not breaking 
any other device which is not using aliased map in the same way as how 
the mch device does, as the latter is the only case Jonah used to test 
this patch series. That's why in the morning meeting I asked if more 
test case can be shared like how Lei Yang did in his previous testing of 
your early page pinning series (I recall one failing case seems to be 
related to hot plug) as the early pinning would open up Pandora's box 
that potentially break a lot of things while memory layout keeps 
changing in the early initialization time.

Even so with one additional test case, it is not sufficient to prove 
everything gets done in the right way that can unblock all the memory 
aliasing use cases, as our direct customer may use vdpa device in 
various VM setups together with whatever devices, GPU, VGA, VNC or other 
device we don't know yet but is using aliased map. It'd be going crazy 
to exercise every possible device, and I don't see the real benefit to 
build yet another sub-system out of QEMU memory system's realm just to 
support all these existing devices, given the relevant alias supporting 
code is built-in and working quite well within QEMU's own memory system. 
Don't get me wrong, it's not me who asked to add this code but patch #2 
is definitely not an optimization patch - we have to make sure the code 
is being done in the right way no matter what.  Functional correctness 
always speak than performance or other thing.

>   So maybe we need to allocate
> the translated addresses array in vhost_svq_vring_write_descs and
> return it, or allow it to grow.
>
> Having said that, I'd keep the plan as building something simple that
> works first, re-prioritize if we want to focus on reducing the
> downtime or in increasing the SVQ throughput, and then act in
> consequence by profiling the advantages of the changes. I'm really
> looking forward to the switching to (GPA|HVA)->IOVA tree, as I'm sure
> it will increase the performance of the solution, but to review all of
> it in one shot is out of my bandwith capabilities at the moment.
No problem, and thank you for your time in reviewing. I think after 
almost get done with the other assigned work I can work with Jonah to 
implement the desired code changes for (GPA|HVA)->IOVA tree. It's not 
for optimization or performance - just I feel it's much simpler than 
take extra burden to implement and maintain those unwarranted, 
duplicated or preventative code in SVQ or vhost-iova-tree layer just to 
get around various issues in memory aliasing or overrlapping use cases. 
Actually I'm already getting regretted not giving Jonan the right 
guidance in the first place to implement all the necessary virtqueue 
layer supporting code than use the ram block API hack, believe me it's 
not a lot, and the code change is really simple and easy to follow or 
review, there's zero cost in GPA-HVA synchronization than what the 
current code already did. Otherwise past lesson learned told me it would 
spend 10x more if not  building it right in the first place - there'll 
be more cost in future time and effort to refactor or rewrite all the 
code in later point of time once all kinds of features are already built 
up.


Thanks,
-Siwei




>
>> Regards,
>> -Siwei
>>
>>
>>
>>> During the device setup phase, vhost_svq_add_split() ->
>>> vhost_svq_vring_write_descs() -> vhost_svq_translate_addr() ->
>>> vhost_iova_tree_find_iova() -> iova_tree_find_iova() is called, but in
>>> iova_tree_find_address_iterator() map->size & needle->size mismatch. I
>>> inserted some printf's to give more information:
>>>
>>> ...
>>> [    8.019672] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
>>> [    8.020694] ahci 0000:00:1f.2: flags: 64bit ncq only
>>> [    8.022403] scsi host0: ahci
>>> [    8.023511] scsi host1: ahci
>>> [    8.024446] scsi host2: ahci
>>> [    8.025308
>>> vhost_svq_translate_addr: iovec[i].iov_len = 0x8
>>> iova_tree_find_address_iterator: mismatched sizes
>>> map->size: 0xfff, needle->size: 0x8
>>> map->perm: 1, needle->perm: 1
>>> vhost_svq_add_split: _write_descs fail, sgs: 0x7fd85018ea80, out_sg:
>>> 0x7ff8649fbb50, out_num: 1, in_sg: 0x7ff8649fbb60, in_num: 1,
>>> more_descs: true, write: false
>>> vhost_vdpa_svq_unmap_ring
>>> vhost_vdpa_svq_unmap_ring
>>> vhost_vdpa_listener_region_del
>>> vhost_vdpa_listener_region_del
>>> vhost_vdpa_listener_region_del
>>> vhost_vdpa_listener_region_del
>>> vhost_vdpa_listener_region_del
>>> vhost_vdpa_svq_unmap_ring
>>> vhost_vdpa_svq_unmap_ring
>>> vhost_vdpa_svq_unmap_ring
>>> vhost_vdpa_svq_unmap_ring
>>> 2024-10-08T15:12:22.184902Z qemu-system-x86_64: unable to start vhost
>>> net: 22: falling back on userspace virtio
>>> ] scsi host3: ahci
>>> [   10.921733] scsi host4: ahci
>>> [   10.922946] scsi host5: ahci
>>> [   10.923486] virtio_net virtio1 enp0s2: renamed from eth0
>>> ...
>>>
>>> This is with similar Qemu args as Si-Wei's from way back when:
>>>
>>> -m size=128G,slots=8,maxmem=256G
>>>
>>> There are also some error catches with just the permission check but
>>> it appears the vhost-net device is still able to start up (when not
>>> matching sizes also).
> I think this is because of the forced check for equal sizes, but let
> me know if it is not caused by that!
>
> Thanks!
>


