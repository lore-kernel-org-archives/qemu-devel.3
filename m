Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3741EC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdsud-0006Js-9C; Tue, 13 Aug 2024 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdsuc-0006JD-0w
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:54:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdsuZ-0000u5-T1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:54:13 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D7tXKa006131;
 Tue, 13 Aug 2024 14:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=xkshsH1uoST7L05JSDMSfIbe0zOWahBxY3ZCB3qdgjg=; b=
 aPNhThmxvCn/Y63s4QNj7ShvIIhltVa0eO2yBs31feSGBX5p5QKU2I3f+Z7VVHhQ
 oKroTKt/xzzXUh1kTNLAETFGmwkpHyaJSuteYxL/J+52P+YU2nlsPfKAEA2/oj7M
 o4vctJeyrhDEbzUl7ySkG5DUY0flzF/Gelj7DJTxYM2Zf7H335MTYRX7RPoCAdoF
 iVXwLGOj9v7vy7yrFeA6Yd3j+0ZWvo0sTYN8yNVv6XXFcjKzkHwjNsGTyoFeFXoF
 sgN4TV0peGoy+gJYKyyGieh4Nt4hTivRnIT7OxD4lrdOpLWXbU8QZiFHwJ5RJUQp
 lsJutUucGS07F5eHkXMBpg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtp60s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 14:54:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47DELl8L010840; Tue, 13 Aug 2024 14:54:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxn8mfkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 14:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bier0BCDnvxo8Mt/AtT1bQebV6IU1PdERbQvQhd+MuKxPju0wldB50MSD/pGl+VPXvukSAKgYTsjADQOgbJ6itd7m9YZoJ74pH5gqrfRgxvi3Me+CmhZZ8v4xpT50q7c9Y5LtiIYV5cQm5rtLbfgBlg+TcbIjB8mekb4+EGm1c+X8GR78KxYMrq0H1+4flNOXL4vlTd0HLpni8Z+hqS9gROu58KAmdcRAsyKlbAw1/qDziO+sEYDnfEdUlsdGnymyYoiPn2C9Kal+zIpUgYPVHoDnz/+aYz960nqgSJKiRmWG11aAwW6SIsfpaoVr+oc+/owJkVklk1RbETaeWjmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkshsH1uoST7L05JSDMSfIbe0zOWahBxY3ZCB3qdgjg=;
 b=O3X5L3hN6AhvlsQkrutPILAAEZiDyhUHk+fAGDKcqO7vbeZctCSAbwDnCJkAWFDOVfyyayWE3ERUcpIgmF/M0NSfMR5qSFy1im/NBwGX/mrMu7JIBLJx+0hXM3ywcVCw8dUGXMxxh4TVH3Uz8k4zxNjXjxj73hk2PMLV5uE3FCoyprJTrhFdv3Uzm5IXLPUwOOxP44nlN3bVnskFOUejZpSMjsYcvHrdfaOmjrkI3VIRlFakabnXFt0sC3gBpbRnfMuIBQESFjAhSxoiMRLqnRLXzFWIzftDvIf85yQNqikhdWwtU39jz0V1jN8AXcVfHlLJGUxDYIp06loVJwN2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkshsH1uoST7L05JSDMSfIbe0zOWahBxY3ZCB3qdgjg=;
 b=WreTBaFamM7y5hrWmU/LR0I09fH0KdUHGrVIrP7NWmy7kPdUWib8gI7gMgefuabtatA1goe66c/R+DaJb1DJ27YJDrTeigox3So9hbTdOb4kgsGdkly2HatSqVFjtaxeSfUPrl6o9ZEDprafGPSmggXRIRHQ+5ABDj6QtqS4jlY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 14:54:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 14:54:01 +0000
Message-ID: <09e41cf4-78fb-4d31-9ada-8493247fec61@oracle.com>
Date: Tue, 13 Aug 2024 10:53:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 02/12] iommufd: no DMA to BARs
To: Yi Liu <yi.l.liu@intel.com>, qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
 <1721502937-87102-3-git-send-email-steven.sistare@oracle.com>
 <ff0fe127-bdca-41a4-86a7-c72e9fcbcf3a@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ff0fe127-bdca-41a4-86a7-c72e9fcbcf3a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5a1bd1-0282-4808-36a5-08dcbba7c46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1FCbk1XS0p2ejZ2NUJscFBnL29neVk3Y1NhakQ2SXlZdEtrUTRUVDArWjM4?=
 =?utf-8?B?eEp4L0JWZkVOV0pWNnYyNXB6OUZ0bDBxOTJVOStTeUd3RXllVzR0ODlOM09o?=
 =?utf-8?B?WDVEcnNzandDMUwwTHNaUk5ZOHZNZENHYzZWbjU1SkREMmIreE1HRmpBTk5y?=
 =?utf-8?B?Y2tyWTJRV0hDS1pFWE1iWUE4NGdaWFlpalk4dy9xZlBNcFNtdTVyLy9RYjUx?=
 =?utf-8?B?c2J3K1E4TjJISVBOVlpsNFo2RGpGekw4NkxZSG9EN2I0K1pSTEgyYU1MaWM0?=
 =?utf-8?B?TWtCNHcrY3RtR0U1dllLZktja01UaElkZ1BuOTJnYzZUSnJYT0RzMzlMaU5J?=
 =?utf-8?B?WVBkcnV3eUExSDFDbUVMU21KckM2L0RmN09SNDNJOVh0MWFmTHcwVTVoYjUr?=
 =?utf-8?B?UUROMkgvOVBPU1hGM0ZPODF4VWNaY3pvL1BpWFZSdUZSa2FVdDVmT2k5TTRa?=
 =?utf-8?B?TGhmeGZwZVJKelpNQnArWnZtdWRkR09vSGhtSFg2dGcrWlN1TmlWL0JLbkI4?=
 =?utf-8?B?YmFaVCs4dGk3cWE5bU1BNE4yNjNYby9xU21XaDgwaG16TjJldmZwYWt2K1dm?=
 =?utf-8?B?N1V4bXVlS1FMMEs5Z1dUa3BEY2crMHZPUzBrZElNTCtjNDBVNW5NSS9ldXd1?=
 =?utf-8?B?amtlUS9ZU0d3ZFkyK0I2ZHQrMDJ0REVqN1J1azc3dHptTWxxZDBMUXBRVkVN?=
 =?utf-8?B?MWFKVzA5NkZLYithZHNnZ2NaZmw4K21BdWVxRjB5ZUh0ZkVHZnBINVVteEM2?=
 =?utf-8?B?cHYyZlUrclVkNWdJR003ZlRpaEdLRWZCRVdXYlUxMXpOUDFNNWx0V21xWW5k?=
 =?utf-8?B?MVhCKzdidXFEMnIvRHI4bkk0OWhqOElNcjBVbytubkFHVitTWnJ2alkvNHla?=
 =?utf-8?B?cWgvQ0VlR3B0cEtDeTVYbGtWSERXYVlML2l6SzZsT083aEVOcGN2SVR5OTkz?=
 =?utf-8?B?ZHFSRFdrUkYwTlM5aVpmclV2cmxyS1h2NG1WSjRTVnE5WGxUSm5pUWFoOCtu?=
 =?utf-8?B?LzU1WnFiY3JVSmZ2THF3S3FsaitpMUYyYzh4aGpMTXdEWWR0U24xdVNkaXl1?=
 =?utf-8?B?WjIwYys4RkMzMFc1QVRvUzk3eGhNMkFiNmpER2ZnNEI4WDhkajlJejNwZlV5?=
 =?utf-8?B?YVlMc2RRdUkvSG5ZMGs4N1NNcFB2MHFoblNSKzladktFME5pMXU0TkdKbEVM?=
 =?utf-8?B?WFZIUExQcCsvR2VFb0o0aFVXMXFrajNqc1o3WStRVkM3VnRVVU1xa0tyZzhh?=
 =?utf-8?B?Mlp6dXk5UUxNT3hSQkhHVTRyZnNVRW9QQ1IzcWNvL283WjVvVGJ2Qk5mQSt3?=
 =?utf-8?B?SG1rcUVzVm43RjhSa3NRV1FRMlhJUGtVR1ZHZHJQa2FhMzV4R0YzQzE2R3pK?=
 =?utf-8?B?VDdNUVNMbDZOQyt0aUR1YXZia2NsUWFoVE1nZXRpbVhacUtZNk1SZTRtYkwr?=
 =?utf-8?B?Q1VsOXFSRFZZYlRuVW53cmltZ0Rzdm9DYnlGNFM3c3hodng3TE8wdkZiclBZ?=
 =?utf-8?B?azc2WTUybkZITWkxa2JESFdwNVY3dTlQWVNGalBjL1ZJNStSUnEzaDdDdGFa?=
 =?utf-8?B?eUlEQTNMWlpyWWxhZHJkVUtJNTlIeFV3dk1GYTNZWjNUak5OSllVM2h3eE9K?=
 =?utf-8?B?WmVhYXhJWlRjQjdXQkRKTmtrbUVGYVBxN1c5SWplT1dvZi9BY0pidjFuaERI?=
 =?utf-8?B?Qzh6aFhKOWpIeG1lK0tvaEU3NlI0V2FpNmV4K0R4RmI5cjBFK3RqOFhKeTRR?=
 =?utf-8?Q?CAmLytYWzU16o1kcPc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVZkYWwyOWpiU0I1NFJzblJTdHh4WHFSMVpVaFNiZVZRZG9pMG5QbkdrU1Jp?=
 =?utf-8?B?SEFJOExZTUY1Y2pZeG9XYXNNUTlWVHNDek9naEp4RTlSSWt4Qit6RW9GYUw4?=
 =?utf-8?B?ZDZyZjFKOEV3amZjbEJBR3hHd3ZoeE8ra2JZVDg5N1RlUmoyWFdkeTJGVStl?=
 =?utf-8?B?aEtTRVpURklhekFiaEtTekQvMUFZVjlENkdudzlDb2RhdEpxSlEvUXQrS0xv?=
 =?utf-8?B?Zng1QzRvRXhrWjdRdDRzTWdkM2RaNUVHbXN5SE9UaitIaEJSSlBZOGJzczh2?=
 =?utf-8?B?Qml1bGNEM2M3bUx0SjJoQ01hRVZoZFBvUHFnL0lmNWJiYXdJQjQ0S1RZM1Zh?=
 =?utf-8?B?UUFTYkl6ck5QSHRmb0RPUHR5eW9ZMmN5dWxrYlYyVWRDcVlEY25kUkgzTzFo?=
 =?utf-8?B?b093Y1I1eGY4MG4rYWtjc1I1K3lLajFhYmh2cG5kWVBZOGVFbWIyR1pHYlBY?=
 =?utf-8?B?R3JNNjdVQUlVS0llU0lpTU5wNENwWFR1TnJDcXpuQzBXM2gxTTZWYVJaY2Ix?=
 =?utf-8?B?Z1JWOW5TMXlCMjRwZ1BhSlNPMEdldXFHTlZ4SlRUQ0xxbTZETE9wYXNMVExR?=
 =?utf-8?B?dy8vRXMxWXpsSkpaUFRaVUtCMjVjaHpRb3krZlB5SWk2cFhVQ2dGUXRGNmFG?=
 =?utf-8?B?Y2JTSXNNYS9nSnFDZFM3NXlnNW1CMFRtSXB0QWw4cnpTRnByRXZoK09nMkVS?=
 =?utf-8?B?MzF3eFZic2pRTHBnVk9sdzNybnFlbFJQdGlNWVBDSFFjd1VYT0xMWnp3TW0r?=
 =?utf-8?B?bU9vNWpXdnU4U2RBc09pdDBjV0lnU3N1R0lkd2RkWmVBN2FGU2RrUHp4Rytn?=
 =?utf-8?B?Yll3d2JXMmNKa2V6NzJSdFFydzczdGRnUnplWElyaWRsRU12MkQ4K2NWc3N1?=
 =?utf-8?B?MDg3V0lDbElGQVE4RHFrMUt3bS9iL2dMdjRnTWFtVXBBeHlENmVqaGJFOXFj?=
 =?utf-8?B?Ukh6ZzJoTUVtZ2pROUJvTGo0VXB5YWV0U1VjT0pOV1pXdUVYbXAxZjZtLzlC?=
 =?utf-8?B?Qmk5TFArdWNJWXlhK3dRQ0JKRTViVUpHd3k3RW45UDJkM2JpZlVOU3dyNnFS?=
 =?utf-8?B?Mk9pbUJya1B1ZTJEczRFQlhlMTh5MGV0U25zUE9jaUVWNTREMi9NcS9YMi80?=
 =?utf-8?B?eWtuSzc5L2xpL0JzSjhwWEU2RTRhZGt0RHkrU2VGTkRMMkV1NE5EeU1SYzJS?=
 =?utf-8?B?SHFYNHdWNXBKNk5GQ29zNFlHdU5ucVc5Vkc3bWx4emJOZCthNUw0OEJMRVBr?=
 =?utf-8?B?QldsTE5sS25EMFFTMmRWc0F2Z09jdFVTdjgwT1FaRUpYVDBrU2dwemdQYkVs?=
 =?utf-8?B?ZmVoY0dkYkJPdXlZUUhyRkhySnNRdTArcjV4MXI4dkxSVWtCR0l0NHFUWGhn?=
 =?utf-8?B?U1c4VTFVQWxMNHhxeStEcWJEMzdaWFl4T0lCMlBTblJZUklCVTJnY0hHL2Zk?=
 =?utf-8?B?RnlkUjB1S0JwbnlBYUNpd2RQMksrL3daTTMwYUVWVjI3NEdEdldnNytxTjhy?=
 =?utf-8?B?NXMxbUlPYnlNY1pPODNEYkR0TUVyWGN6a1o4YXhHNWo1SThWRWFxMWN4UXY3?=
 =?utf-8?B?UXR4UWVoMTlZU0RWOEpuNFhsWXdkSU4ySnF5SkE3VUdOandyY29ZdjhSUzFI?=
 =?utf-8?B?VXZveVBtSmxyZDVxRy9pV3RSSkYrZnZ4QzF3clJJekE4S004a0FzRy9WbDlJ?=
 =?utf-8?B?MG9xa1ZuTmp4NEZDWEorNERjdGc1Uit0QW5CUTdVTGdDcjJyZTAvWWVWZDJM?=
 =?utf-8?B?NXRraWcvYzFXOXhVczhTcUpybVRvOWVORzkvM25kRXBCYU9ZaHl2Z2F0di9I?=
 =?utf-8?B?Q3RrRkdKUEtNL3RIdjRPaDVQajBQNWFTZHVLeTc1T0ZRN2hGSkVGTlhjOTBv?=
 =?utf-8?B?SjV0cWVMcnBqQ2k5KzdzOWx1djByZG1TdFN5VkVCSkxnbkVsQzZWanZlc01Q?=
 =?utf-8?B?RktrQlRLQkN1NzRIMTlkelNaamNnWlluQjFxYWdlSHJ2TWRXREc2VzBYekxm?=
 =?utf-8?B?NCtqQythaGhnZE9Kem9TbFBoemJUY0RFNmZKWTFWaTZUa2xjU1dHSWcvY2dX?=
 =?utf-8?B?L3FaS0xCYWkvOENBQWNBNWpRNTJZZUt5NVI3SktMeDRlZXFUQlViMXY0ZzEw?=
 =?utf-8?B?Q2dLcUhRMjkxRWhMaWFpVHdGM1F3Q3BCT1d4SEE5STlDUFdjNm03cWFQOHdi?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0EVG/r8PaQRwxvNTYnMdfvOxRkNoGg53yCmcOeR5jRLO6N3zxGWPYyS9MKDOyh4q5wLI+g8NCrYlNaRbXfu0aHFM1MbYW+Zhf3uziIM7jgfhmUqX6XYaYpRmTt8gCHjWI8ryDSQRx+PtZNt+DFsXla01mbEBkWDPK8QEWu2nthLRfojYKGOBkd9lzjkQ+E8i69H7KLo5rxfLE8s30Mo0xh/xvscwtKDNCV9IaRolYihKkHtwM4cCrkQryMl+tCeEHDG/reynkbKLCvrwz2BAO09ct/zWumjfmhs3r8kw0MvROt7tcR/ts3ZxZYmObr5SymFFLLYmOWBob+K6T94Ia7e9AHtFlAOvxEfdSH0x8pDkS0bW5C0gsoDFPE4lk+MFBaKiwQ5b8oCX3BPI2z3HzQP5A63dt6HD5nauO53IKMhxU7NynbL1WgwWQkUlE2T2RtWOIwc2eQr4n9U4Wqv3Y9i9Ge8S1LYMyPXlYRIhUUsNGxoicoSeKUag/+ite+SxGGSck9m5jJkQMpqF0lVobkNwTwQmppbap8JfMf42IvpT0uPSGPHHgbxD8/7fmTtlS5OGpsl4fhGqL3TWKr/+EA9fVZnKOBxoXYzQgYZkqNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5a1bd1-0282-4808-36a5-08dcbba7c46a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:54:01.3858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3eouzFHm0G7oSq58JOhpsDEtt1XsdWVfqbXWlUBdo3vVJSj+BfO6P0bkr6SbYtos3Np/lCjIPAExqpeNY71LECGJHpI/Ova8A5YXKZaqrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130107
X-Proofpoint-ORIG-GUID: RmXAB-YsfNm8M9404X_8pjvdGm3xUdAF
X-Proofpoint-GUID: RmXAB-YsfNm8M9404X_8pjvdGm3xUdAF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 8/12/2024 9:39 PM, Yi Liu wrote:
> On 2024/7/21 03:15, Steve Sistare wrote:
>> Do not map VFIO PCI BARs for DMA.  This stops a raft of warnings of the
>> following form at QEMU start time when using -object iommufd:
>>
>> qemu-kvm: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
>> qemu-kvm: vfio_container_dma_map(0x555558282db0, 0x8800010000, 0x4000, 0x7ffff7ff0000) = -14 (Bad address)
> 
> It is required as Alex pointed, so no need to pay further attempt to hide
> this message. And there were efforts to make it. But not done yet. Below
> links may be helpful if you are interested about the history.
> 
> [1] https://lore.kernel.org/kvm/14-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com/
> [2] https://lore.kernel.org/kvm/20240624141139.GH29266@unreal/
> [3] https://lore.kernel.org/kvm/0-v1-9e6e1739ed95+5fa-vfio_dma_buf_jgg@nvidia.com/

Thanks for the pointers.  Good to here the problem is being worked.

- Steve

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/common.c      | 3 ++-
>>   hw/vfio/helpers.c     | 1 +
>>   include/exec/memory.h | 1 +
>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index da2e0ec..403d45a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -248,7 +248,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>               * are never accessed by the CPU and beyond the address width of
>>               * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
>>               */
>> -           section->offset_within_address_space & (1ULL << 63);
>> +           section->offset_within_address_space & (1ULL << 63) ||
>> +           section->mr->no_dma;
>>   }
>>   /* Called with rcu_read_lock held.  */
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index b14edd4..e4cfdd2 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -435,6 +435,7 @@ int vfio_region_mmap(VFIORegion *region)
>>                                             memory_region_owner(region->mem),
>>                                             name, region->mmaps[i].size,
>>                                             region->mmaps[i].mmap);
>> +        region->mmaps[i].mem.no_dma = true;
>>           g_free(name);
>>           memory_region_add_subregion(region->mem, region->mmaps[i].offset,
>>                                       &region->mmaps[i].mem);
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index ea03ef2..850cc8c 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -794,6 +794,7 @@ struct MemoryRegion {
>>       bool unmergeable;
>>       uint8_t dirty_log_mask;
>>       bool is_iommu;
>> +    bool no_dma;
>>       RAMBlock *ram_block;
>>       Object *owner;
>>       /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
> 

