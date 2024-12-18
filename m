Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7C6E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0Zo-0006HY-7p; Wed, 18 Dec 2024 15:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO0Zi-00062U-D8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:23:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO0Zg-0000ZH-JR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:23:18 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIcc2018174;
 Wed, 18 Dec 2024 20:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ZwZS09vkAh0Uc76nN6scTO8Fl95lNRJJmwT8duU3gkY=; b=
 FUMZrbW3UExuoQ7rgDxuPRVQd8q0DNQBw7uY7jbe8JuIcxe7cumKxsmNWLY9sTcx
 5XnjTsFAo+PmrX0T2F0nSvLdKpTFemXJpB5nt/6gdchAVNPUOnPB2eQYls6UrXIq
 0M2qGEpSHQONcifaqhSZLikFIgBXVSjc/hXGj0vkytbVM6WWZEwL7vW/25syRKzy
 Ebo0ydxTbjM+ZeWeUuY3bpT+XSnGchfMnqXE3tIamyy/kENkowrjpgjcCkM8ILkh
 KtJpVc3+rxzdY+Tqg6P/lXGc1qINrvgywnlgB7GFBzKEXJUyOrASpgDFcj9wAL5Y
 toCxwCsW0b+YrY+/yEuJaw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec9fx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 20:23:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIK1VjI006377; Wed, 18 Dec 2024 20:23:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fb6t8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 20:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDBiXPoTFvUmBSj7/GXoKaTdLQOuSz2tjIqjr737+YAETu+nhwdaru+dwskDWbN3Ue4fbgOevFgV3OH6OmLmVBFtlq2G+4meJKzAy+GbTEXiQNmrMfQhkC8naP5ylEnbl73GODdSEABm8L7hok2ypBHWAQmDHP9wBD40jhLoREM2H3dHTHeKk+eYvQCkawlwMX0Sj8T3E4lnu7bwN+sNQvHkRP5YgR5pDGb6R4g4V5OXOCpIBrGWrAycgLALTbyAnSaQLXZH12AKZs0p5kKl+8gom/EbiGvViASBnZFNzKT5HISM/Hq+tZQLkqfyF/Z2gXG4lyAhtMEkYzn0DM7J/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwZS09vkAh0Uc76nN6scTO8Fl95lNRJJmwT8duU3gkY=;
 b=x8k7cEiFv5vDl+4VZiwGA8vLgA/kBkS+W7BavS3vg9ilzFSsS8koF5CWHWzKHU8+sO6c+2AibLtRP2IQNxBGFOlmFR7nH1WtwzdE/5uR3bSp9kO/OhiVSNvVy9jMkFNxcydUBCRYw/BAFMPiim0fKSKgPM6kf/FK6oQmilS+t0M/PGQgvVY062pGn2LM1PxfeNu9ObvzyUxRbLUU62OiMSw5WjURqz5jGIeNVqW3NBOegw5GMqyrFbjDpjBkin0azdaoT2TroHO8IikoNT8IfXwae9qIoemQnXLIJkN/op20cfYHj/0sI55eJbMXHd+UP5ZK8P2HAnw9wVx0DX5hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwZS09vkAh0Uc76nN6scTO8Fl95lNRJJmwT8duU3gkY=;
 b=WrujPxNARg5WqCRkwoxa9sBULZ6MVgVOP2/YdZ8lThggoifVr7JHyUD3R0UbYqbDuJTpyYbBKEGg+YwNx6mYWAwA1SyLyTDJIRUqVhmtDOn2bmqEzT0+wm5O8o0HTxC3gfYsYo16rw+2N8ymR6YLKhvXlRlctVVCnePJANEolSA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6919.namprd10.prod.outlook.com (2603:10b6:8:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 20:22:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 20:22:54 +0000
Message-ID: <3b2e7897-ff21-46ab-a900-551f78f7ca48@oracle.com>
Date: Wed, 18 Dec 2024 15:22:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n> <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
 <Z1toIxDzI56ODYcC@x1n> <Z1xREcVCi-hn4BlW@x1n>
 <58935fbe-bb53-457d-b4d6-70c1d7b09e8c@oracle.com>
 <8406c79f-b7fb-4536-8d6a-126bb03a6c9f@oracle.com> <Z2L_mwAAEjbGRI0r@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2L_mwAAEjbGRI0r@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0521.namprd03.prod.outlook.com
 (2603:10b6:408:131::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6289fc96-9dbf-40a5-fecf-08dd1fa1c0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGExbVBtbURYSVpvcnRFemVrSWlaVStQMjVsWTI1VEpvOUttci9xVTQwVFlp?=
 =?utf-8?B?QlZ2dHR0OThPbUczOTdhUUZudk5vUFFDMk9uTkV4bGRRdzlSR205QzlkYXl5?=
 =?utf-8?B?d0FWTENlNVRmMU1wRHVlYmwyVHFMSWJCb1RKOFowVEtsYjI3dlpqc3NNRm96?=
 =?utf-8?B?L3oxV0tnVkxwZFl2U3JDeklDeWM4S3YrODIwLy9nOC9TS1p5RjVrVEpFL3Jl?=
 =?utf-8?B?cU5peUJSVmFraUlmc3lmMmxHcjFISXRkUG1RZnhmK1RQUHJSWFl3L3JmTlpO?=
 =?utf-8?B?YnJwUGNVWkgrV2VMM2taT0p0ZFJlMVNqTGtaajFKWUZRQVZGL3dUMHd6YVVm?=
 =?utf-8?B?T2poakZUVVRXRHNpTVZIRDA3SFNhc0lTU2tVUitVMGtLZHVmcjNCcWs4YXh1?=
 =?utf-8?B?b3ovRHlXNVVPdVJnekpKY1Ntb1laQXE1M3l5RkEza3BtZlo1aGpwaWtPWmhW?=
 =?utf-8?B?eGw5eFZ1dUZKNisvMEsrTzFvcG9FalNqSlZaRjlBZ3liZTBLbUN1ZFc0bW5Y?=
 =?utf-8?B?YjVjL1NhaTRnMERvSDNmUllXdWFPUVdKSUtGUzZUMHhVdytIWHJmRWF1ZWR0?=
 =?utf-8?B?bzliMis4aEFYVzFQRFlPb25qRGE5UldUNG9jd1ZNQld6MForYVNDRE9JUzlH?=
 =?utf-8?B?aTlpaUUzVDdjZWdseFNKblpNNFR1alo3a3ZBdzVIdnlzdHJ5U21GcUdwSFpm?=
 =?utf-8?B?SlpkQ0dtbVBleXlONS9OZVFrOEhXWmdqVFdLVXV6NXJremVOY1pMMFpwUDhH?=
 =?utf-8?B?MU5rK2VzblNZNndqRHF5OGhjOFdLUFA2a2U0MjI0aHVGc3RURzJLTERWYkpw?=
 =?utf-8?B?ZHljNGN5a2gzeTB1RmRvT1IvVW9PVUs4cmdrTTJiRUFkc3BudklQNXB5T2hl?=
 =?utf-8?B?QVRHaFlEWndtYlVBb3czUkhsSExRNDg2R0hBR24yQjVOV05YUkJQa1BLaFFH?=
 =?utf-8?B?bVJwdzNtTjdNb05TU1ZERUpSbjBpUGtGQzlPVEN5bmZxVnlPdGhPRUZKek5T?=
 =?utf-8?B?RVVHVmNQNHVyQmo0TXN3b0dKVmp1aHdiTmhUa0Z2N3RzdWd2M0RndnZvNGpq?=
 =?utf-8?B?bXYyM251aTdOT0JGYWNod2VXbFpUZmVQNmhkQ2Fqc3JjOEtqN2ZwR0R0NWh2?=
 =?utf-8?B?azh4eUo1MXgvV1UzY1lseHhSUUdsQURCRWdYeUZGMVk3WFl1ZHhDRGRzYXpm?=
 =?utf-8?B?OTJiZC9VOHVzUHRFQ29EZXhhVDhrZWx1cUh1S3JuTU5vTFRYeEVuZkp0eXg4?=
 =?utf-8?B?Um1LdnFnbkRmUmJKNWxUajBuRXMxM2hJZ1BkREw4aVdxNThwSTBuallvYmNz?=
 =?utf-8?B?QWN5SHBOMWhXVTFYWnNGU0RFTUxISXNWcktuamxLRldEQVRDbTh6QXRjdUFz?=
 =?utf-8?B?NEZkanNrRExxRXdKWGZ3R3dpOUpVWDFQY3ZVMUtNajZxbncvRTVQVlN4Sy9D?=
 =?utf-8?B?WWE1YXY0bXlkWVRPcnI4MkN3Q0lMQnd2dGlrb1pGTHFISi9uc1ZGK1ZHNXJm?=
 =?utf-8?B?WmYxeXdRZGFkNlRDaldQVVIyUTR2N0owSTQyRktLKzJ6UnI5SkoyZ2dpWmp3?=
 =?utf-8?B?Wk03Z3g1ditjODA0ZElIU2VGMWZTOFBMZzg3WkZlL1grVDNsdllYendSVUtC?=
 =?utf-8?B?TlpMK2FlbWs1b2ZRTzVQdk5FdExndGhQdU9LcHJRQ2VOd2YzcU85Wnp2YmZj?=
 =?utf-8?B?d3RIbEphZTdIUVVNcHFnYzZxUjJYQWNoWlFaYngrVUxKODZnZ2VEcEJyQ3hq?=
 =?utf-8?B?UHZvVUxWWFV6UytmclFZVERLV01QZzVvYk9HeklpNzduVnhDalF0V1AwVmg5?=
 =?utf-8?B?OVlCNnVDYStmZStKemlOWG8zWEJGSzQyeWlEeGREaU9hK0NGREF2ZXB5QS9x?=
 =?utf-8?Q?SaldnGVWK0Ka7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJZNWFKNVB2QkJUWkVTSXI5aks3SEJzSk45djl4UEVxZGxTdHpXU0dFWkVi?=
 =?utf-8?B?WmZvTTZyaGx3WG0wQzk0WmRSdUtwNFIwYUNXbnR4VFdOK2ZjUnhNYjJMRGl2?=
 =?utf-8?B?aVJ6WlRZeXBUaDZkZVRGMTFFSFVQQWRQems5N0pqbHlsbEVPY1UvelRxSTVQ?=
 =?utf-8?B?L3FnR0oyb3BZMkNIelAvMUc5R0EwdHhnaU5FMXE4VDM4WTVPVTNvZFpKL0Ju?=
 =?utf-8?B?YkhJaU1MMVlJMExaZzN4czNCNWRIVkRBUDJKZWQzQVNQV0twc1FxdEc4amYv?=
 =?utf-8?B?bElTcDBwUFM4NGgwa1RDWmJoeXVkNWRCaytQaFNNS1hLclRxUC9jMk1GWkd0?=
 =?utf-8?B?NmNJd0hSejZMMHNud0hLZnRqL2x1UmJ2MkFNQ0JUZHVvVHhmbjJSVnhrcUZu?=
 =?utf-8?B?YWZsTGxaVG9ES2djbW9lOVVLdWkvb2lRZVlzbldyZG9pVHR0RHBKQk9IMUtP?=
 =?utf-8?B?UXVYc0lUMmxseHVQSVEwdVZpZDdYamlEbm5wb08xbGJaUnd0K2JLV1dkcy8y?=
 =?utf-8?B?YzRYV2Noa09uZmFtV3JaQXVDeUQxNDVOU3krRHRpTFQ1QnJwenYvSjQ3VlRQ?=
 =?utf-8?B?cjFXcndxSTVQWm9WMVd0ZnVNa0VIUHJxNGc4M1pBVGJRT3FQejZJTWZyWFJD?=
 =?utf-8?B?R0FmYk9GTklYVUVCY05pOVFZN0EwRVdnZFVERmpkOWhzMkF5TEhjaUIvRWlm?=
 =?utf-8?B?L0M5MmpFSWlWMHNuRkFtcW9TRThReVV3WFVaNDJGNTByOVUrSXdBZmdBeTVn?=
 =?utf-8?B?Q2FWTHBKS3NtSkxXUVJBTXh4cHUrQ2lqS2Z3cEdsZmVmSTJqcXprV1N5bEVu?=
 =?utf-8?B?b1pZSHdxVXBEVVFUdTJWeVVkVDhpVEcwV0NqcGR0YjBGVGJkQlBJV2V0bnBv?=
 =?utf-8?B?dGUwZm5nRlJlMVdUaG4rOHNVdnV0bDExc0doVXhqU1ZZWTNVbUUvZFR3OWMv?=
 =?utf-8?B?Yy81ckhyUTFBMEJWSW5pYzYrV2lidjQ0bjdwVm43MDRHSlc5SFZUeTVRRGdB?=
 =?utf-8?B?cXpyemtla09peE90VHJEWEVqM1VNbXhXK0ZUc3YrbjZoNHphc2h0ME15clRn?=
 =?utf-8?B?bHBwN2h2ck9WeXd0T3lQSVh3L0VkWjFCK2lQbW9CWW52SHQ3aXJTdENTbkdK?=
 =?utf-8?B?YldKZk5SZjdmWFlST2RFR3JTSmZ5TjB1NHF6WXUzZFVMN1ovOGcxL1ZueUpP?=
 =?utf-8?B?VTZuYWJyQnVhc29Id1NJTHBGcThDczd2M1VZVm11bXdOakU3cFdKcDJ4TGRI?=
 =?utf-8?B?aVdhVENuQndpSFlGKzlXMjlaaG5yQUVhRVYyaFBZaTZXQzV4eDZqMXd4cmFR?=
 =?utf-8?B?Q1dibjBsNFRFMnAzVWxtNEFJY05wSW44K2FuUlZpb1BIc25zRlZ0dUg0ckpj?=
 =?utf-8?B?UVJLL01nd0Z2RWhaeFdKWUphWnhxemIyNDVRZC83UW41Q3ovTW1BZzFmYk8x?=
 =?utf-8?B?UEM3dSs5U3FGbjJKc3dFOGxieFpGckZ3VTlFdDdZek9aMWFYOWN5WGd2Qzhw?=
 =?utf-8?B?RkJNdFJZZlNRSXdXRkxuVkNheE9FVms2eFVFajFwbmRWdDl3YTlsRHdlQThR?=
 =?utf-8?B?ZHNKRm9wMGIzdDNTOUdPZml3VkpWdW9rZVhhYzI0UWRqeGovZWpFZ2FyMEk2?=
 =?utf-8?B?N3IyREdFbXVvc2xTZVpMbG5JU2RuL0swcWhtWnI3aXVUakVrcU5sdHkycVd0?=
 =?utf-8?B?QXpTUm9KdW9MVXpMWjE5YzlwWWJld2NOazRJOWFWYlpGK1hrTHNBR240bmJt?=
 =?utf-8?B?R1l2N0tkeUxDaU1sT3VwNmF3cm1tRlRhbWxKazFXZWtqQnZXNjJhNExNUDdr?=
 =?utf-8?B?SWc5UkhiQzZKM1VYemNoWVExLzE2K1BXb0dYTkFQRkExdUIvOElQNEF4N1hi?=
 =?utf-8?B?U3VsS3lSNnJETXVMeWJBRGRTZWliVnZlUnBSMTdRU0ZZY3ZwdnNqNVNkNjBR?=
 =?utf-8?B?cnpRaENwNEFyV0FCTEdicXV1dk4rZG1OWm1McWJZUkRMNytyNEFuQjBZaWNl?=
 =?utf-8?B?c0JNYkFxS2NjenBWMzltQ1dnc3BTZG5oQ04rRGEyMy9oODNVNWkvYXV0VzZw?=
 =?utf-8?B?Zm9md1p0MmlxY1BPK2huSmZNSDd4RnUyOXorOEJEUmVEUzBMYXE0cHN2eGJ2?=
 =?utf-8?B?T0c5QUtvUm03VjhLQk5JMTEyRytQZHhMcTlJQmZwUjYrb2dRQXRBTzBYSzg0?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nksGWqjmtwsUFC/tPKbl96VZPK/anZBKc3cdoPcc3cjpEoC3y/UFuem1Gg5jS30IuGlugoMy/HrciZ7faN/IhW8Z1ZgEBZe2cvsL8euPcJzbOKyKC8oPKuzhb26a+Zu3ygFl+2e31Hy0CIbWtB2w1paTKWneY5DBuDkT0Vq6oPIc12ZdszokeiI1NnH08biVJAYSE7Hc8ooERZmup1+DoINopY3wfLUckJCmBI7CKP8uMmyHqnnXkc6OGlVYmuM2IrnQkEoyJJVDsOU/RNwIK01q+H9ax2DcQixRLLNJnR4xwP8yVjbQJfj/cV62aMhGigqBhpBprdrBRp6AuJVg7spIY5OFxXMq+Ezs5yawMWlV+UvLPjlooNU0ka0SwjOy0mV/gHB7tiqY8KaHFBjcMewSEoj5VPl3Z4EWgm8UMzq6m3FJp3Evaz6cAgkcjbcodwWRpYKqeEqX5EtQVJOfr7LN7BiLyphLL/9Z4yVjPdkGEtn7z4Gomh0LgtvK316XMb41fqMocQQvCpxpZmoq4h+8pAtOHhXKYuk193TvVPpxLOjNB+8zyJbTbTaJoD3yy3G2z8lvdt2LkD8CSYgrqpR/R9Mn/Llb6kxyCIjzHfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6289fc96-9dbf-40a5-fecf-08dd1fa1c0b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 20:22:54.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Og4ULOtoRNW7zhZtvquKbgUGvhLD/MVFEuuW6BaBcpqtYUh0jgyM02QFM4vKbU3cn7mUOYSjO+U2mcvPQKoLksExgzmHsxpMV625Oeea81w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=966 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180158
X-Proofpoint-GUID: JbLYEiFV-SEUeBcGIMAZPHhRSMHZC3Gh
X-Proofpoint-ORIG-GUID: JbLYEiFV-SEUeBcGIMAZPHhRSMHZC3Gh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/18/2024 12:00 PM, Peter Xu wrote:
> On Wed, Dec 18, 2024 at 11:34:34AM -0500, Steven Sistare wrote:
>> After adding resizable support to qemu_ram_alloc_from_fd, I can also tweak it
>> to grow the file while preserving error checking for the general case, and
>> delete the explicit ftruncate in its caller:
>>
>>      /*
>>       * Allow file_ram_alloc to grow the file during CPR, if a resizable
>>       * memory region wants a larger block than the incoming current size.
>>       */
>>      file_size = get_file_size(fd);
>>      if (file_size && file_size < offset + max_size && size == max_size &&
>>          migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>>[...]
> 
> Firstly, this check is growing too long, maybe worthwhile to have a helper
> already.
> 
> file_size_check():
>      // COMMENTS...
>      if (migrate_mode() == XXX) {
>          return true;
>      }
> 
> Said that, I think it's better we also add the flag to enforce the
> truncation, only if cpr found a fd.  E.g. we may want to keep the old
> behavior even if the user sets migrate mode to CPR (even without a
> migration happening at all), then create a fd ramblock.

That was my intent.  Normally mode becomes TRANSFER only when outgoing migration
is about to start, or is incoming, but conceivably the source qemu user could
set mode early, before creating some object requiring aux memory.

I can add a grow parameter to qemu_ram_alloc_from_fd and pass true only
if the fd came from cpr_find_fd.  Sound OK?

RAMBlock *qemu_ram_alloc_from_fd(..., bool grow)
     if (file_size && file_size < offset + max_size && !grow) {
         error_setg(...
     ...
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);

- Steve


