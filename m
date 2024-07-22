Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FAFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvLC-0004GB-Q6; Mon, 22 Jul 2024 11:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVvLA-0004ER-Nu; Mon, 22 Jul 2024 11:52:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVvL7-0004x3-P3; Mon, 22 Jul 2024 11:52:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC16GJ031930;
 Mon, 22 Jul 2024 15:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=/WsjbYhUrqU6j0W/g81LqRRTz8+Xuzm3W7XqAI8MgWc=; b=
 h2Vk2reZwuZWh1yJd/BTAjWvOHfnhfXmmyfmCQlh693dhTgVFhXr/YoP+2T5DCGv
 gilQiXn1lSimBfZzWD6vEoZ53ZO1SnMdeHIHLHMOjQSuMLynyvhdbqSv7K7d82KC
 y0P8hdr6A+k60Tej8juU+dtiWAmYCt039SR+Wk/39CCxXoWAMPRrXYQOUNXq+09X
 TIy7wjIC3k23MxLd6wXTwS7DidkVpc7VA9H0bOMRfXLydOppT4T4Ovy1dWtzPxYd
 dRtwETojwss69KgPpxN0qr+9IF/RptnRwl9B1dmBSeglY1U2Od6GfGKVONWBydVa
 o0Mmw4tyyTEW+cfqz3wwIw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpaa9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:52:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MEPwNk024974; Mon, 22 Jul 2024 15:52:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2a04spm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiqsQ+X6eW7Kq1x7Ft4c/wdFTODYwXKDZ9C+VBMPLMCwzc4L0wyOvr66D0d7sZM+wYqLCPNviH8nPWbCI2beuhjjI5wo8FXbE8R85MyjRoQWh4RBtHxgCp8hV5mJsspxryyoiCxVeCtEOH87Kn5X3V21p84zEHCN7OKN5OwmTMaJ513vEUz3JU5mf/ILks2P8poOuzVErRyHrk7f3ZrmGBNdqAQnEVzS5JKWfQi/jvK1US7GCI6XqKyEmVWhBJmg5jUU8DqMG7E43zK3/3enwYy0KIAWq76mMZZh4T/VUxmRgVDQFBXct2vt9MmMrOeei1yrHObwg8AjgJAvMu089g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WsjbYhUrqU6j0W/g81LqRRTz8+Xuzm3W7XqAI8MgWc=;
 b=TH+8lEO0tdcQZJ8u1qLb3LGLAW1p9yxCTsqztsQaXmfeZCHnpWCjNGeWaSG13/iXEQkOI3/q2BZGVc/YZi6vMOlfrmdhyXaPpZ/oXAx8iw8EoHl2EKdIC7CowFpAa4zP/hNfBxJT0qTGfIv1Wfd4FBSLGfxPIn2qJ1imhwWer2OU7IF56CYdhd9v169X8SzPQaJVwFD35eI8NDUHSOsRVOrJOhVS4/7d0fetIooZuBy5p/ij2HJC4owzafymya12+mfiNmlv0WBFKgZI7F9xpRRMQWQBw+2/N6S86hyO/Uyfh9DfZ0mP0uzUI1LV1zYfTOtOeUbhutSJNkGunVwETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WsjbYhUrqU6j0W/g81LqRRTz8+Xuzm3W7XqAI8MgWc=;
 b=MaTkvw8x7bujCo+WNGRC/Jm9qSxyJM+WCYI2CTyvzvHbL6DDAFmY1DlvRp/kPqp47Dwej4OtvGKaGizxJwlvvVzoLwipZtX/K/Bj6DqyVKDH6smPAoVwvW9rog0er08tSzQ6awyj37FRfrYTYP8VBKss+GmPr+rYn6vo/KWjux4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY8PR10MB6585.namprd10.prod.outlook.com (2603:10b6:930:5a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 15:52:32 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 15:52:32 +0000
Message-ID: <78def100-c088-4d87-bd9e-d7c87d054cf8@oracle.com>
Date: Mon, 22 Jul 2024 16:52:26 +0100
Subject: Re: [PATCH 1/2] vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
To: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-2-zhenzhong.duan@intel.com>
 <ebd01af8-9e39-42e9-93bd-a5a4368bc647@oracle.com>
 <aeb1fd39-6a2f-4bab-8cce-84d3b113a667@linux.ibm.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <aeb1fd39-6a2f-4bab-8cce-84d3b113a667@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY8PR10MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 69740f47-e68b-4f87-1b09-08dcaa664c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU1Zd2MwdVBySGpueVQ0SHdUa2xYY25pRWlabTJ0NVZRcjRqNWlIYWZaazR6?=
 =?utf-8?B?SGs2RlUzaWpxcDB6MnRvVGU1NHk3bzRzUnFOcDd2MUlablJ5TWV1YzFteUdI?=
 =?utf-8?B?QzhrSkJXZXJjWUpScXJQcDlDNnBSS0ZaSktRN3JOcHQvaTNMZ3FvOHJtVEs3?=
 =?utf-8?B?cXI4TndsQXcvc0UrcTl1Z0tLR3l3S2FiOEtGdFBEay85aE4zQlBla0J5a1RZ?=
 =?utf-8?B?c2E2TTdmcWdPeVcvc2xEemJaQVJSaUVyMDJWZnBtVjFXNDRMRDJXd1VOcFVG?=
 =?utf-8?B?Qm44bklDSE5PeFZLdFVlU1JabnFpNFFiVGlqRG8ya1JwclhCWTMwdzc5ZUls?=
 =?utf-8?B?c2JNVGtsU3I1aUZmUklOM0xQdXpxeThhcVg1VG55NVZkamxwYWtQU0ZzT0sz?=
 =?utf-8?B?NTNuU0s0d0dyK2NWOHNQZ3pNdlh4ck91QVBtb3RidzZaWkJPcm1zS0d0KzNS?=
 =?utf-8?B?TU9vQVZJaDMxZ0RqdEJQWFdpOXIrQkkvVnhjOXZQMGRHVFdlNm4ySm9RdENr?=
 =?utf-8?B?cFkzMEJVUGppb0M1M3VrYmJOdnVMNzl6dmg3UlJJaVNXTGxQUXp5VFAvV2lB?=
 =?utf-8?B?c3lqa0VOMDE1TG9oOEtZbkc5cDl2NWZIak5zczd2Tlo1SkFwV0NtR0tXZ2pi?=
 =?utf-8?B?VjYvR2J1cG9KNk96NmJzNjVpRmtBZTRadVl4dDZWYmxXNlBOblNES1ZXRmdw?=
 =?utf-8?B?a0N1enRuenh6RkZpSldpUm9mWXZpblJXV2NLYVhZU3NvbU1zNzcxWTlUUTNN?=
 =?utf-8?B?VEFVaFNjT1E4M1NpRDJLVm9rUEtkWXhrTjM0ckJVUGxUeUl1eUdEY3BkWWNz?=
 =?utf-8?B?WCtsL3VkUFc1YzdtNW9TR3drOXZRanZVWTNpb09rT0FzVk9JamFpNHowZWNa?=
 =?utf-8?B?QVhjSkN2c1ByWjFkMXFWdGRaS0xrbVhicy9EWXpFbEdyNXY3VithQXB3QmxO?=
 =?utf-8?B?c3AraU95U3hibEpLa2Y3Mk5hL3dENVZYbTFnWFJwbkNLUzE0ckZPUFVLdGZB?=
 =?utf-8?B?STVKWEE0VnZJME1RVGpHUWw3a1A5c3FoTVFGVGRQYmtJdmRVaWRVdFdGWW9B?=
 =?utf-8?B?NExJM1FHdlJ6cXgrQjFpak1iQkRvdThtRDlHV2x4c1lqbzhVNUhhRHdVWXlU?=
 =?utf-8?B?OVdHTEZwNEpUa01qeFBIU21uMkx0eUJ4ZXltaDVDSVpkTjNuSGo0UWNaSjRo?=
 =?utf-8?B?WkJjMDFoNGR5V25kNEIyUXROM0EvbHhPa3lZZlMwbmdabC85cElkaVlGbUJ2?=
 =?utf-8?B?TGZRUzlQUGJjREx3b1l3WVRlT0dnYmpuR0dOSDJxMkxndjdzalVZemhKZUxT?=
 =?utf-8?B?b00wMG5HbDRKb1NFUm1TSGpuTUZHR0xQTkJtV2ZlQWdxMmg3V2ZLTm1sQ29u?=
 =?utf-8?B?Ri9qa05iVmZlSUN4aEk0cGtZbXRVTTZHNGNxMllYWDBRY0xYN2VoSkRraldU?=
 =?utf-8?B?KzJGOTFaV3hGMVJPTDZPWkZ6MVplcVByZ1VkSyt3dGxNVmtHZG13bkc5eG1L?=
 =?utf-8?B?WXVnamh1MkRpeFB4eFBrMnQrSG0wUjYxcEVqMmZGbE9YbGYxNnMvZFp4RXFz?=
 =?utf-8?B?aDdZbTBDd29WSUlyY2lXWFdBVStPRGhNREh0MEQwSFg4RFZoT1RxdVJ0TlFh?=
 =?utf-8?B?WXVCK2VNdGIzakRMZGN1QlNCMWNIcGZvMFl5VnVCWHhBQmY1Q3BHNjU2eUtx?=
 =?utf-8?B?M3RoZ1R0ZHZsNlBGWk1ZSG80UnU1ZTk1aVZnY0JIM2wraEp3RGtsWjZNdmxu?=
 =?utf-8?B?b1JRTmt2OXAwMXY0RnRyajZIQ2hQaEdxc296WmEvc3lOT2lFcEc0WEtIQXdy?=
 =?utf-8?B?VmtYR3luemVYS2VNdzJ0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmt0MDN6RGl3Mk1yT2tyeHFyVFVtQkQvY3Z3U3JBRUx6ekI1QW9VTktycFNB?=
 =?utf-8?B?QVJ1bmtGcm1rQmlIczJWdlByR2hQcXUyd1B3Q2hNbjdXWjFIVVNmV1VJUVRu?=
 =?utf-8?B?eEVDeWtBUmMzb3dkdkJPT292YzJCaDJna3N1TS8zUFZyRTh1SklrTWtkaGFR?=
 =?utf-8?B?cnZUSnlOcEZWN0VqaE1JVkxLd0h6VWxnaEU5b05RaU1ZUzJmWTM2YjZ4a1NT?=
 =?utf-8?B?SWFhSldEM2dwdFJjTysvT3ZSZS9rNHZJczB4MDVldGNSU1prMXI5QWhaWUlL?=
 =?utf-8?B?QTNUSFlDSzBpWWZNbytBN0U4cW42WkVIeEZqbFpyZUFsb1RqUnpSVXZUd1Y5?=
 =?utf-8?B?UWkvaklWZ01JUjhReFVQSCs1dmRnekRGL3pVd284NVpBRkdPK3h4aC96RDBH?=
 =?utf-8?B?aFlUSWtNSHNDdDlzS2UxUG5sUGhBZWxxNmtySllxOEg1NWIzYVErcXV2MFRu?=
 =?utf-8?B?ZnFCVVZKSTBBQTdtYlM2dzgxb3dDelBJTnhGc1NMWU1iODRnODdBVGh1Tkph?=
 =?utf-8?B?REcyWXZEZUcyb25GOHZNODAycDBxUUpEZXM3d3ZoWUh6RTlFRlptazZLRWFE?=
 =?utf-8?B?TjM0MExkQ3hZMmdhTGt2djFDc0VsR05iY1Y3cnFiUk1kV0E3SENtUEM4MkdD?=
 =?utf-8?B?UHRUeHdUaGtHMGpkWkltQXdDRzFDMFh4Z3NmNHlpRTVDbG4zMEVQRHdqSE82?=
 =?utf-8?B?Y05LVWVhQ1g3NDhSUG9hS1ZHYnkzTm4xMXFQeXorRGJJZlR6eDdZbE5wS3NS?=
 =?utf-8?B?Vmg5ZmROby85WU9xVDh1c1R5L3VtSXZXdFBNWEpOdjA2Q2kwL1U5RGoxbU1Q?=
 =?utf-8?B?bCtuK2pUMk80Tk1VM1JxVnhMeHc2dnV5M1dTVjdqN3pUK3dZUTdjSjVVK0NR?=
 =?utf-8?B?U0kyZldscGdhb3VKeVRCaDBQVzFpUjBsbFlIK0hhZW05bGZDVGhZZ0hVT3lp?=
 =?utf-8?B?aWV6dTNjMHFlYUVaeEV5OUZseTgyQndBTXkwbm1YTUMvQlhBSlpRcElabzBw?=
 =?utf-8?B?RFE4THJjMU8zNHVzYmk1TGZLdCtjQ3JqOVZlMnU1UU9VYS9BT1JNWCtZL1BE?=
 =?utf-8?B?ZmxzNnJwQng4RmNqbXQvbWQzekZXNktNdGo1eEcyUk1kT1VGaHQxSDhac0VN?=
 =?utf-8?B?OHYvQllIWXVkQ2FzVlZSNm40MWxjNTlpQkhrdzZISDl4b3dzZzhGTWE0cDBn?=
 =?utf-8?B?VGpDWVRkTG5teExJTms2UGszZTdCMUYzTHRKVkpCRUpUb2lpdDBXSGh6NnFE?=
 =?utf-8?B?SnBobjBqdDJ0Ymw1M092WW05ejhCS0J0SVRhTVd3eWx0eGJGNk9MWkNYUmdX?=
 =?utf-8?B?VHgrVEtvdHlQeUpETHpaZ3RJRWV3UDFNcXBuRk03L3kra0VjQWE5ZUppN1Qx?=
 =?utf-8?B?Y2QzTTJXak14VStZZmNPN3VDUnN6Z2pjS05tZkUwRVZPcHlaV2daWmlhcHNw?=
 =?utf-8?B?V3ZjWnVNSkpmc3dDM0RsVDB4cHRjQ2xWemhaMm9STjZxZnFXWmptVTN3OEF0?=
 =?utf-8?B?TVpFNkJBbDBRZVFtWnRtMEZ1RnVaSCs3M0RVT3B1MU1qSkJNZEp2eGlrT2Yx?=
 =?utf-8?B?TUNmWWsrbDR5dnRRZTVXZWd2Y3p2OHhhUXNmYmNLQ2p5V1pFM0ozMld0UXZQ?=
 =?utf-8?B?Z2lYbkVYN2puc2V6UXBOc2Z5YmlmNWx1WVBzdjZZbTBrVzBGVjBSZ1hvMWVI?=
 =?utf-8?B?TUo4akdSTkh3RzFYalhzQ1RPdndnSU9WbzdzeDExaXJFV1hjQTdoZm9nQURr?=
 =?utf-8?B?OFFJRTREMjlkbEx1ZE5yMEs1Ylp4Q2pkYVZxWkxiS3NHNkU3RDliZ1B4dzRl?=
 =?utf-8?B?bmlGNGlBS2YwVS9XK1BhMlQ2c2VDck9FbGJJb2MzTVBkUW9ySXlwVkMrcnBW?=
 =?utf-8?B?aXdrVmhFdUxKQVpXZGRCM2NBRmxuRVpDLzhTYXpCVWFlUjQzOUk3eFNnb3c2?=
 =?utf-8?B?a3Z3TTBZVzVZMEtubHlpRHpYbCs3K0JlZnJLdFkzNmw1UEN5S1JOcDdqODk3?=
 =?utf-8?B?Kzd2R3lpbjdvekN4L0hQSTVvVHVoS1RCRGkzM0c5NHM0cHZ2cEorU2t2ZTJl?=
 =?utf-8?B?WHlrblVtcE90b0NKSzR2Zmt3bHovWE9vbzQrenBTOU1yV0hxMzRMcEE2M29p?=
 =?utf-8?B?ZTcxcFlSbTRXUUtFaWNsU2RpcGptREtqUUk0VjA4Smw4YWw2UXVNdWh6WjBu?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gaej/qH6C7+XkZvah5smNhn9Tq+XKAtEh0n3izk7SoEVPV8/MtDJeAQQHd+5UMYMugPeFPF+Spq1My9lh84JN4XprG9JNV5qV5V2GfhHat+BudQQyp3gBcfkQPqsoS5OVeam9tf3LRmqzo4rMLfaF0cjNq8Kc8jTsGfQSQOkqiHBi/hQAacw4lRV+8QlD6TlcTFWQ8vEjmm4KICmFnnw5mqTTgciA99RVlzFbdFpQh8PGxybiilM3dq+qB4Yl8UxKP6h09qSClowu76wpuzOr9tjAWGF6MBbZIivTnHFElwsjpWkTjBEJcDMUJf7Scfr5JCWRpVe4WWBLIctyIw9RpqdiAMH3hMc5u23ZlbC1EJ7WeG3M9geNPnkkU1HiZTilGkIdfOTdeQdi1WjRwJj2ROL5pv+iIzTU35JoOORCnSxnoHJnvEScIclN5zZvQV+B/gCnd6PaQ21mizAuxXJc5+1K08ZrrxCVUysZ6tycLmygNf+TTq78/woGMOjKnE1zcXsr8YwlJOIRI/7Hr0wsM+sd8pIG8creOPYxySs65xydQB2XhskHh10wZiAK7xpFZjrlM6UvFqroTpL/dQpk3x895cUrCR2pKckMtdpDAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69740f47-e68b-4f87-1b09-08dcaa664c74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:52:32.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4Ca+akIITxike7dsZW4YjPoB0GiWs4/Go4Eaa7Uyh0G6C2IhQOXvHm78NLQDa2qIQIbETDpAi0qN2YiHJPcuyrfPQh+jDACiMmnRWP3ZNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220119
X-Proofpoint-GUID: 5ZAeUZFsr2GpmpKbOgXrQIYMxWb4w3hg
X-Proofpoint-ORIG-GUID: 5ZAeUZFsr2GpmpKbOgXrQIYMxWb4w3hg
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

On 22/07/2024 16:46, Anthony Krowiak wrote:
> 
> On 7/22/24 5:18 AM, Joao Martins wrote:
>> On 22/07/2024 08:07, Zhenzhong Duan wrote:
>>> mdevs aren't "physical" devices and when asking for backing IOMMU info,
>>> it fails the entire provisioning of the guest. Fix that by setting
>>> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
>>> presence of mdevs.
>>>
>>> Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize()
>>> handler")
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> 
> I'm at a bit of a loss here. We've been starting guests with AP devices being
> passed through using VFIO for years. Did the fix for
> 
> 930589520128 precipitate this?

Yes. The fix commit ids introduced this and it was not intended. Also the
failure, again, is only reproduceable with IOMMUFD and it doesn't apply for
type1-iommu that you are likely using. Both are different IOMMU backends.

	Joao


