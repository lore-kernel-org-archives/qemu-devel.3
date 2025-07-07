Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF28C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnNl-0006af-97; Mon, 07 Jul 2025 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn54-0008VN-B9
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:44:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn51-00069M-SA
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:44:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Eb9vw032407;
 Mon, 7 Jul 2025 14:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Ew3lTMOw+OOMAhCZPxcRMXJM2nAazAezzIdTuwV02nE=; b=
 BtlMNCJ1jn/y+d8aq5wKwN8cMANwqXFwYOytPoLiakTRDx9fY/byasY8l8+Qsr8y
 HPWKR42XC0/WqJKR183e8tH2Xz57Qsr9g47XCaaVVRu+KyGw6cFy8ArejHGqiylG
 aA0SjeIvSv25H/duI5bOhx3GihJJZhsDfJndsfyhynL2LleN4EakP52j08XqDdad
 HFti4r3eOBS/N2mev/gYFk2OO3zlMBVBYJme2PXfkS0ukfv0AfFWK9yaao4yFxX4
 GuCd++0Zgy/ttYiztlMFsVF1UdWt5p98yy+OKs5+AE2NkZ2LFhT8b00wnzJtrJe0
 A1scNg/JaZc2ItcCvvNNuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rg5hg0he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:44:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567EUPJ0024388; Mon, 7 Jul 2025 14:44:23 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg8kk3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQf8ccAdo7RWqeiXiwPwgWTM1uSW7/vfC3viHWc/Qe4xlGGVJ2qqzWMXPygwl+HddK2HjrfG8rBtjIlXwxGLRd8rs1FtwoKwtjN4oFkBplgDk8zCu7b9AIQYjluymfyFb43oh03eEP7hemcdM5ANZAwNuzPAluLi36V7aagyDSYMEfgBwkQ0kjRBpXkkl59N7IDAV/ZVUOgPMwKs2+oRYblCH8fKavL8kXyWgMJfRco3xPpcqW5l/g5EYblY6V1SpaZ/HxIewsKCoyfqNEo8nooDlbOmeZJKQODGY1usHtWL7nNz+9Qws68JRpckCSaushaPhbzSKku0Wuux1NCUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew3lTMOw+OOMAhCZPxcRMXJM2nAazAezzIdTuwV02nE=;
 b=tri8m3ekDx7a6Y6ABD7fYmsBSHB9mbNYrCuO0oUopIgn5SeYUsy8YNTwxSzUpS3c+vuCpFAHXgGLO8dpoab1wbr1oeC6fBvl9dt6YYLhxNwWcsx5CA+w/dP9VHFc/CJnharFgW6kWDmq+oREBzSLa8ALuw7o0KM7keYg/PPHDrL2LxVR8cG14y8f3yHIgW5eeSXYVg7siBU4/6Q9B7gK8EamW9vlLL5Yf9EYmYHWizzT+h7tvkzE1hoBbjaAB0Kg/dbPwPWGpTr28PiShY8x6Dt+NtqAZh8bIJUlYXcxm865aQ9XRDa3o5C2jEdsWmg51/jXzE1Ip4VGlS4MGPmf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew3lTMOw+OOMAhCZPxcRMXJM2nAazAezzIdTuwV02nE=;
 b=NE4QsY9DCNqH5rFp+hC4TWw4JaUq5JdtqwZKP4SnVDSSvXrI44c1uov3Qh+9itoB14b1UAqCoB8ff46jR2IK4r+neClG59O53sGIH1eshqUDZ1bFoVO/x+1ViFSqR06nKs2SSxmF9jjoMWjg7avlxHd9BE4reVl8HjzZ0vAABww=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 14:44:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 14:44:17 +0000
Message-ID: <76271add-d9b3-4b45-a272-3cbe336c2103@oracle.com>
Date: Mon, 7 Jul 2025 10:44:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] qom: qom-tree-get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 devel@lists.libvirt.org
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
 <877c0ono29.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <877c0ono29.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8225143d-db6b-415f-7fc1-08ddbd64bfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkZ3UHBlZ1JqRHdNbFdXSUV1WE9maStDbVcwajVYa0FIbGNCQktlbU90WlFI?=
 =?utf-8?B?NmgyNzQ2ckl3UmN2ZHExTldaWTBqaHkwTjY3aU8yMUZQZ25oQ2FHQ3Q4VHdp?=
 =?utf-8?B?d3d1amU4L1piVXJlVnVaektaYWJUWCtwUTZJcXpKeitoeVkyN3VlM3JQRVB3?=
 =?utf-8?B?L1ZLdnRxNW5iNFdjUGsrYng0cE5FdHR1SS9UVGVXUTBCQU0zTFQyaks4VmQ5?=
 =?utf-8?B?SmR5NGRUY25TUTBEdE40bTVMOEwzUHY5b09IN04vSnFDUy9FVnRSS0pydmlW?=
 =?utf-8?B?cEhxdkZTWThPbTFNZkg3UDhjQjlnZWdiaXVyelR4OExBNnZ2clRlWXM5SVJD?=
 =?utf-8?B?NEZTb3ZTc29QMTE2NnRvQ0VUamJLK2N5dzlkY201WHZhVU84aWpuSTd4TXR1?=
 =?utf-8?B?S2hVdGc4eWlnd01maUJuOW1WSGRVb0pGdXAzZUtuZ29rODR0UEh2VldoTFJj?=
 =?utf-8?B?cktocWhQZHpGSnA1bUw4MTFneFVMcnpmTTF3bjBaVytFd09LbENyVGtyQTU3?=
 =?utf-8?B?cEFib05wb1ZoYjVxaHFzR2JCTTBPK1ZRNS9xVXNYM0N6TjFNVjB3b0pvaXdP?=
 =?utf-8?B?eU5IK3R4bDhHdHhmRkJrd1pLdlJ1WVNCNkRXUkQ1dW9UQzROb3lDcHFBdDk0?=
 =?utf-8?B?bFdwK0svNzhTczQ3bzNJd0hmNWprZlRUK3ZWeUprdWxwNVV3cXRqSU5MU3k5?=
 =?utf-8?B?MHR5MjdZaFF6VlowYnEyaWl2TEtuNkZUTkRmZy9hbXpXMVdONHBqTWtrUWdi?=
 =?utf-8?B?WG1xTDZhZGJrcmtFUUg3bjlVb2k2V0h2VWk0dmVWaWN0MmhOTUhBMUVid01U?=
 =?utf-8?B?bVpDcFBVYlY3SDdrcVBKMGE1WWxLckVZNldYSTlBakE5bzhqTGZaTUY0U1RO?=
 =?utf-8?B?ZG1aMzVXNEpvdGhpSWRIeis1YllBMFB4Wm5NbWtqUytqLzVGcFNMaEFtdkRI?=
 =?utf-8?B?L3NlWGJ4bXIwVmF2aStEQktWS0RXUkpmaXhLZlhndTcwRjF6dmxROTd6dnlV?=
 =?utf-8?B?MkV3bSt0Q1F0NkxxMTA3MWE3NW1RTWNTV0FnTXN6a3dCRWN5L09hUmdWRjlp?=
 =?utf-8?B?R2J6bU1IdmVkT0x2enpGSlJJa21WbVB1WkhHdTJudGNta0tzejFoYTdrWDZB?=
 =?utf-8?B?cEk1MUkzSVpWSTBtSitFZFNYYUZ2NnJBQlZBN0U1RlNia2x2M0dLenZ5dGhP?=
 =?utf-8?B?OEhveUtIdTRBK3lyVDc2QnZlcHcrSERFd0p5Y28zWUdVL3FIV1RJSktPMVJU?=
 =?utf-8?B?bWhXWUdDemZQQmg3N05zSUZaWG1XRFlIcGJLSFNIWm9rTnAyUWFYVnNqL1Av?=
 =?utf-8?B?N0IvTWZrTmhPUm1HakV2Qk1kZXlTR0tBRDJXaGcvalFpbE1kWHlnZnBxNXcx?=
 =?utf-8?B?VHNseGdwVFV4a3J0ZWhOT2xKaG04c0hSU2RGSWp1L0ZFK1BWWEp3OHA2VEJG?=
 =?utf-8?B?S3l1ajkxSElLWStyTzFIMWlMM3VPakF1eTdnU2NSOGNKVFFZdTE0SVdKQWhq?=
 =?utf-8?B?bTBHUGF0aXB4clV4dmVDZXU5TjN6QkFwZ0x2OWlsbnpPSmN0VmV0QVlxUHlC?=
 =?utf-8?B?SDJnQTk0ZHhnbkI3OGFVdkgxNzZLdWcvTVhBb0ZpSlZrWHZHc05sT2Z1Wm5I?=
 =?utf-8?B?aWN5RjZvZWF6aWM0TGYreDNHUk01VzZ4RmRJSjdlQVdJb1VPYUNSS2JHQ2Zy?=
 =?utf-8?B?ZGJYQkRUMXI0c0JjbVRNVWMvSVpmVVlUZGYyOUF5Z3RWNFB4M3J0ZVdJSDBi?=
 =?utf-8?B?NnF1dGNrbzFmYnJOa2lNQVBEb3EzOVlKZkI3YzF2T240WUZsNkRUd25LUmV1?=
 =?utf-8?B?M3h6QlRmT0JvUmFGaEo1eWRlTk5jaGxlczhVbjJ2MDM1Kzkra0QvYTlVYlVC?=
 =?utf-8?B?Q1gvM0hkRFRRL1pRK0xmSlNxWnFCZGZlWGlXV1E3NThxeG5uYVdhN0NEaGZT?=
 =?utf-8?Q?UptUYW1csns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmduUlJzaWJuRXBuN1I3c25JQUNRbkFadGg0eHRPSVN0QVgvc3dyY2RpYlBM?=
 =?utf-8?B?dnRGT2hzNUE3Y0lGRmpJU0xQdU1MaG1NZUxyMzRnUWQ1V28xVXgxVDlkMFZT?=
 =?utf-8?B?WitDbGlTZHJxd25obktFdVBXRXdHbTNWUXJ2VS9tNTdpQ3g1Mlh1aXhraWN0?=
 =?utf-8?B?eDlqTWpudWRSdUlaYUNGNU5HM1psVFBDMDdvcVhTVm9wQXpqOXcyR09UbkhG?=
 =?utf-8?B?YUZJTGpLOUJTU3M5Yyt0SVB5MTVITmdsNE11Wkd2WmVXMXJvR2piNVI3UVBG?=
 =?utf-8?B?SEpKbGl3c1ltb3JOUzVuR25NdkdtTzhEVEhIcVdORm9vdGpDdythOEZuRSt2?=
 =?utf-8?B?aHExWFZvRjNMblBOM0YxM1p0WTFkZ0dTaWdmQjBsdlJXa0YyaHlTNVVPNVZV?=
 =?utf-8?B?aDgxVGhqUklLRmlkSVpKR1pXZm9zMDg1QjJCVDltSktTR2FWRUZicmVZYVk3?=
 =?utf-8?B?S0ZRNzl5alNDYU1UaHpBLzJ6bXlzVGxsaUdtQkFVQ3lQR0dVVTVyektOWndO?=
 =?utf-8?B?U3NVUktSSWJ1cExzUDhmZUkrckUxTEVtRE5tbno2ZUYyZzR2cjF1NlE2ZmRp?=
 =?utf-8?B?TURGeC9hN2JNbEhHOFJvRWx2VHFRekI3SWVyejRxcTFSZG1zV0RUV1JxMzVm?=
 =?utf-8?B?N3lkR0dFakE5UXJ1TzFtK0UwYWtYNTVYcWVDM0pHTmlveUZhcmUwN1FVVHJ6?=
 =?utf-8?B?UHc2VUVwRkZYV3EwUGxGeXZZYThYdEpoYVh3Ti9GYWpaMFlaWXNZUVZKUDlz?=
 =?utf-8?B?Ukl4UHZ1UFFneFErUWJzeEwxSmJQWXZmQksyd0VIOHRueDFpUXJIaWJ0YnRJ?=
 =?utf-8?B?NDN5RzA4YWMwTUxXWHVjWDJSSTBuQU5xRXM1bC9VM0sveVBmK2pndWVnS1BC?=
 =?utf-8?B?S3NRQW84R2tWc0RocEZFclRqMm9tS2sxTExGaWJOMmtYbnpiWThwbzBlUEZJ?=
 =?utf-8?B?RHdTaUVvVWE4ejVMSnBtQVN0dEJCTFM1NGtnVys0emZYeFVuUkZCN1AwVHRQ?=
 =?utf-8?B?ck9LSUs5N1owUnNjUEFmL0hpMVc0MmkyU0VPSWJETkRlZ3lZcDNXZUtqWkhX?=
 =?utf-8?B?dW1BVy9XU3VtT3BSMXU1MVVrbmFmbW5zZjBPVUlSZUtPN2JNdUNvWWh0NVdj?=
 =?utf-8?B?cUlSL243NHJKYXV6eExSS2d5NVFNaWRaT3oxTkUrdElNUTN6WWhSOUdBeUI0?=
 =?utf-8?B?L0xWencvM1FEUXREZVZpeFpWb1BDV2RIWmcwMXRSYk8venhwU3F0RkNSVFlI?=
 =?utf-8?B?ZnBYcklvSHArY3prSloya01SV3NIdUJyZlczZGJuTWwzTE44cXZEZVl0Tnh5?=
 =?utf-8?B?K2l2aXdPdFYveDRwTlRXN28yR0MvRjNXb2xxL1BUMENab3NkVUtFQWVJajlh?=
 =?utf-8?B?QVBNT2pFcTk4Q1UxU1FFcDQvdFJNdkU0MVlCQVNwZDJrNWZ4K0U3K0VBS3Ax?=
 =?utf-8?B?bVJ0QWJLbENwQ2hYd0h2dFFQWktvOXN6eGhDckhkSC9laDAvcnRTbzVjdU8r?=
 =?utf-8?B?MVVLQ3RDdWhFM1kyQ2x2dUREOFlxTXhlRG5OUHBCK1o5VXhaeG9qQVB2WGJX?=
 =?utf-8?B?ck93TXFFU2w0dy9zc0pLWDhKQUg2MHV0QThGS1RVUFh1WGI3YU5LajFwTm8x?=
 =?utf-8?B?T0JVVDJwTHFRVmhyOGRqMTNoZDNOMlNDWC9iQ3BFNDkxek9hajMvVVdYcU1q?=
 =?utf-8?B?UVRHcHhmSXdqSWlHb1FRRHZpZ0twYzJHOTcwSHl5YW43ckNHVjVRb3BuZnN6?=
 =?utf-8?B?S2hTZThXWFRyTmNwMGEzbmlGd3d0eG1EelBCYk1wTDhVTmt5WFFLaEJkTW9w?=
 =?utf-8?B?c2c2QXBWRm52SEFRbW1DLytzdGtrcjJON24wUzVvdldTamJVNk9vanowYlZk?=
 =?utf-8?B?ZkUzc2cyeEs2QmJBSlFSamdma3BoaW5RUXptRkV5Z3l4eXFaM1NwSWI4c2Jl?=
 =?utf-8?B?cUdoQ0w2cEtkeGlWMXdwN1VGcHVYZHlTU2dUaVhMZHdob2tFTGdZVEFZREt6?=
 =?utf-8?B?dWhKS0h4VVIreVRUYklzdXpTTjZOdFdGWEdIYmZvRS9mSjlUVUpvV0hIVXV3?=
 =?utf-8?B?L24wU0pWQytZKytSVEJrU2V3d3Q5WGIrVTZLVGpQMUNUSXYzTjdCYnZDeGNO?=
 =?utf-8?B?OVh6SDVJT0pGUkJTRERBcEptUE9XeFNoYkF4N0FoaFNwMmlqWnNucXdqalRw?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OF9UG4H0FUiEf4npri81df5/hadfmQQe4SFMcOJ1H3mF5UOZPrZ3/dOPUue2OHyIJf402H2pRGCRePj9aFw9z0Ivk2o50sUrLNMqylYPukB3ATLwW0GcRm9ydn81RuuAR0bceVZazRfPiCn6dE6kYswvAnbv3/c1PnDtoNHJdJEcXnLKzTQhYtjLl3u0/aBBJixriJLy1SY9sPNcxuM5s82PjyJG95XnzlaR2zAR3mmaA69L5tiwi3UZaDfCZprqlPB9+KTrddFog2jBpIVbQDg+GIkdB0KIzG9E1gqng+klDAusUVXMHUAZK/1eV0hE6JT/a/1vM/YLYjZIYCWFPCEM4u1pAZpXZGIwLFk2uWTKa+W4+bab2a4+098yibTHzQyxT9iRnurFIUlbsO7k9GJF7fi+Sh00qsToVRo3RQoUm29a2naheosK9WMPryM4N0MbCmkica+6DcDxaBFgoBb7zFBqwjuxIURva9dlM4FnggE5fnops99IwZIsQj0VE1o5DgyaJMyc8Q68kJamuR7OE5oUM9m75sz5c/oAjG+4j1KlvK6JdzL2FP7mjzRVVEkkVfwkSooZyCU7ynvkyozVmZHRCyvwXNAFCTP4Ncc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8225143d-db6b-415f-7fc1-08ddbd64bfb5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:44:16.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI7lg2aYo8OlEkMCyAZB3LYD5VG3wuFEAHd2wSoI2H1cFqiTWjTUnmArtVpDDpfbpKaT11DEM75sy9DPGA2kKsq7VGw5v02mWTwml+o4sxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4NiBTYWx0ZWRfX2nFAhgN6MTqo
 I2P2orAP+hHO4lRpth/6nfeC0T4rdm3tdN78GV/uxX9a52exV09j9mzkKq3mtQ4ucK/yCq4iMf7
 zkLPIHAyLDcBcLjEfFVUKA3gFTdD8rpl/cWJEupewINRDFmxYO6qB6RFiNN7HFlQzjuukS6/4dR
 cufMnZsXuZdnE41DxBdNZbYzLP0OJvxeG2iQPTMwbCGJwSy6fv7IW+cPPa0Oz85+xN7rlaDIBYU
 a/Oj6Dc8g2s/8otAjTFLG9FZ5dl7oylDsCyOUoH/bf5nnAoZRmkErIs67JCY6TDVVVS4dx4oA4l
 EzciomJKMkc+vVCPZ3TifSyOffQX1Ss8shEonYmSZh1blFMypSmrY64y9thxWh5DsAsyna2q7gS
 UvTF8e9rhz9s61kfYVVcZ9hxkHbY6jFqj5iksixnYgo/SZFGzQqYjrxXUt/q28zG0tgDRNbk
X-Proofpoint-GUID: IiUeNRMikv-D2UasBC2ZCgmoLYbG4Mdp
X-Proofpoint-ORIG-GUID: IiUeNRMikv-D2UasBC2ZCgmoLYbG4Mdp
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=686bdd47 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Vi23gfwIoTsdFQIdcHcA:9
 a=QEXdDO2ut3YA:10
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

On 7/4/2025 8:22 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define the qom-tree-get QAPI command, which fetches an entire tree of
>> properties and values with a single QAPI call.  This is much faster
>> than using qom-list plus qom-get for every node and property of the
>> tree.  See qom.json for details.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
>>   qom/qom-qmp-cmds.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 128 insertions(+)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 28ce24c..94662ad 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -46,6 +46,38 @@
>>               '*default-value': 'any' } }
>>   
>>   ##
>> +# @ObjectPropertyValue:
>> +#
>> +# @name: the name of the property
>> +#
>> +# @type: the type of the property, as described in @ObjectPropertyInfo
> 
> That description is crap.  In part because what it tries to describe is
> crap.  Neither is this patch's problem.
> 
>> +#
>> +# @value: the value of the property.  Omitted if cannot be read.
> 
> Suggest "Absent when the property cannot be read."

OK.

>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectPropertyValue',
>> +  'data': { 'name': 'str',
>> +            'type': 'str',
>> +            '*value': 'any' } }
> 
> ObjectPropertyValue suggests this describes a property's value.

I would agree with you if the name included "info" or "desc", but it
does not.  To me, "ObjectPropertyValue" says this is an object's
property and value.  But it's subjective.

Perhaps: ObjectPropertyWithValue

>  It does
> not.  It includes the name, i.e. it describes the *property*.
> 
> So does ObjectPropertyInfo.
> 
> The two overlap: both habe name and type.  Only ObjectPropertyValue has
> the current value.  Only ObjectPropertyInfo has the default value and
> description (I suspect the latter is useless in practice).
> 
> ObjectPropertyInfo is used with qom-list and qom-list-properties.
> 
> qom-list takes a QOM path, like your qom-tree-get and qom-list-getv.
> I'd expect your commands to supersede qom-list in practice.
> 
> qom-list-properties is unlike your qom-tree-get and qom-list-getv: it
> takes a type name.  It's unreliable for non-abstract types: it can miss
> dynamically created properties.
> 
> Let's ignore all this for now.
> 
>> +
>> +##
>> +# @ObjectNode:
>> +#
>> +# @name: the name of the node
>> +#
>> +# @children: child nodes
>> +#
>> +# @properties: properties of the node
>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectNode',
>> +  'data': { 'name': 'str',
>> +            'children': [ 'ObjectNode' ],
>> +            'properties': [ 'ObjectPropertyValue' ] }}
>> +
>> +##
>>   # @qom-list:
>>   #
>>   # This command will list any properties of a object given a path in
>> @@ -126,6 +158,30 @@
>>     'allow-preconfig': true }
>>   
>>   ##
>> +# @qom-tree-get:
>> +#
>> +# This command returns a tree of objects and their properties,
>> +# rooted at the specified path.
>> +#
>> +# @path: The absolute or partial path within the object model, as
>> +#     described in @qom-get
>> +#
>> +# Errors:
>> +#     - If path is not valid or is ambiguous, returns an error.
> 
> By convention, we use "If <condition>, <error>, where <error> is a
> member of QapiErrorClass.

OK.  I was following the minimal Errors examples from this same file.

> What are the possible error classes?  As far as I can tell:
> 
>           - If path is ambiguous, GenericError
>           - If path cannot be resolved, DeviceNotFound
> 
> However, use of error classes other than GenericError is strongly
> discouraged (see error_set() in qapi/error.h).
> 
> Is the ability to distinguish between these two errors useful?
> 
> Existing related commands such as qom-get also use DeviceNotFound.
> Entirely undocumented, exact error conditions unclear.  Awesome.
> 
> Libvirt seems to rely on this undocumented behavior: I can see code
> checking for DeviceNotFound.  Hyrum's law strikes.
> 
> qom-get fails with DeviceNotFound in both of the above cases.  It fails
> with GenericError when @property doesn't exist or cannot be read.  Your
> qom-tree-get fails differently.  Awesome again.
> 
> Choices:
> 
> 1. Leave errors undocumented and inconsistent.
> 
> 2. Document errors for all related commands.  Make the new ones as
> consistent as we can.

Ignoring qom-tree-get since we are dropping it.

Do you prefer that qom-list-getv be consistent with qom-list (GenericError
and DeviceNotFound, as created by the common subroutine qom_resolve_path),
or only return GenericError with a customized message per best practices?

(Regardless, it will still succeed when @property cannot be read).

>> +#     - If a property cannot be read, the value field is omitted in
>> +#       the corresponding @ObjectPropertyValue.
> 
> This is not an error, and therefore doesn't belong here.
> ObjectPropertyValue's documentation also mentions it.  Good enough?

OK.

>> +#
>> +# Returns: A tree of @ObjectNode.  Each node contains its name, list
>> +#     of properties, and list of child nodes.
> 
> Hmm.
> 
> A struct Object has no name.  Only properties have a name.
> 
> An ObjectNode has a name, and an ObjectPropertyValue has a name.
> 
> I may get back to this in a later message.
> 
>> +#
>> +# Since 10.1
>> +##
>> +{ 'command': 'qom-tree-get',
>> +  'data': { 'path': 'str' },
>> +  'returns': 'ObjectNode',
>> +  'allow-preconfig': true }
>> +
>> +##
>>   # @qom-set:
>>   #
>>   # This command will set a property from a object model path.
>> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
>> index 293755f..b876681 100644
>> --- a/qom/qom-qmp-cmds.c
>> +++ b/qom/qom-qmp-cmds.c
>> @@ -69,6 +69,78 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
>>       return props;
>>   }
>>   
>> +static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
>> +                                        ObjectPropertyValueList **props)
>> +{
>> +    ObjectPropertyValue *item = g_new0(ObjectPropertyValue, 1);
>> +    Error *err = NULL;
>> +
>> +    QAPI_LIST_PREPEND(*props, item);
> 
> List elements are in reverse iteration order.  Not wrong.  I would've
> reached for QAPI_LIST_APPEND(), though.
> 
> Wait!  Existing command code uses QAPI_LIST_PREPEND().  Nevermind, carry
> on!

Exactly so.

>> +
>> +    item->name = g_strdup(prop->name);
>> +    item->type = g_strdup(prop->type);
>> +    item->value = object_property_get_qobject(obj, prop->name, &err);
>> +
>> +    if (!item->value) {
>> +        /*
>> +         * For bulk get, the error message is dropped, but the value field
>> +         * is omitted so the caller knows this property could not be read.
>> +         */
>> +        error_free(err);
> 
> Simpler: pass NULL to object_property_get_qobject().

Yes, thanks.

- Steve

>> +    }
>> +}
>> +
>> +static ObjectNode *qom_tree_get(const char *path, Error **errp)
>> +{
>> +    Object *obj;
>> +    ObjectProperty *prop;
>> +    ObjectNode *result, *child;
>> +    ObjectPropertyIterator iter;
>> +
>> +    obj = qom_resolve_path(path, errp);
>> +    if (obj == NULL) {
>> +        return NULL;
>> +    }
>> +
>> +    result = g_new0(ObjectNode, 1);
>> +
>> +    object_property_iter_init(&iter, obj);
>> +    while ((prop = object_property_iter_next(&iter))) {
>> +        if (strstart(prop->type, "child<", NULL)) {
>> +            g_autofree char *child_path = g_strdup_printf("%s/%s",
>> +                                                          path, prop->name);
>> +            child = qom_tree_get(child_path, errp);
>> +            if (!child) {
>> +                qapi_free_ObjectNode(result);
>> +                return NULL;
>> +            }
>> +            child->name = g_strdup(prop->name);
> 
> WAT?
> 
>> +            QAPI_LIST_PREPEND(result->children, child);
>> +        } else {
>> +            qom_list_add_property_value(obj, prop, &result->properties);
>> +        }
>> +    }
>> +
> 
> Oh, result->name remains unset, and the caller is expected to fill it
> in.  Two callers, "WAT" above, and ...
> 
>> +    return result;
>> +}
>> +
>> +ObjectNode *qmp_qom_tree_get(const char *path, Error **errp)
>> +{
>> +    ObjectNode *result = qom_tree_get(path, errp);
>> +
>> +    if (result) {
>> +        /* Strip the path prefix if any */
>> +        const char *basename = strrchr(path, '/');
>> +
>> +        if (!basename || !basename[1]) {
>> +            result->name = g_strdup(path);
>> +        } else {
>> +            result->name = g_strdup(basename + 1);
>> +        }
>> +    }
> 
> ... this one.
> 
> Not a fan.  But it works.
> 
>> +    return result;
>> +}
>> +
>>   void qmp_qom_set(const char *path, const char *property, QObject *value,
>>                    Error **errp)
>>   {
> 


