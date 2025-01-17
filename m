Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7589EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 15:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYnuJ-0004HX-KD; Fri, 17 Jan 2025 10:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYnuG-0004Fh-0l
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 10:05:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYnuC-00088q-4I
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 10:05:07 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEfj2f002241;
 Fri, 17 Jan 2025 15:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=R8ZaBwiDAK+rq4lu0xytsBVoCBR19Q7S5zAXFLjMMe4=; b=
 jC3gtV5U/czRAgiAaxgwYubj/SPGhPmWHzFGtM/tqgYb3FvuDTIvwrOkEdM5gpla
 sFkBhUTKpznXmH2qQxpdbOEQYQqdjurSBZEo+b/Teqf5ijZ2kMxn4qYHp5eeo6nd
 wXbjnDpq+6yxTZMR5nNKZvkyY3YwDMTzRCmzTZS0S7+VN942txm4E04J9vGBStN+
 xpjbwomy2xQwZ4VORLSFBbVQiZdnN8af79G58e2DNGM7YBkddjzXQImR5lBMISJs
 dWxGgf9diF13/SqB8Fu4a73s84CtK6LoiqOi8ZgrA5PSYTs63GbRYFLbBWpF7+0s
 mrxiqMc5/k/33u+RMpwmDQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446pdx3jn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 15:05:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50HDADGt005208; Fri, 17 Jan 2025 15:04:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4473e6eu7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 15:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQTmzQIvGcz7BemHHW50nR5Slo9xrOu+Ul2m/XKLLzIg/W4XDDGp5k00+vKfKTiOyiprImNw1v3ZhUbCAI/6D79T9PufJW4L6cXXjx8m16eOeZKkGFohDaKtRiJb3BmPfcW8DTLVzcz24OrgE3anMvq0kfav4PcjROUhWphaia+ereP4YNNl4by8I2bGEOHT4nh3FjmAWI2vVrteIljWkzPyB6smYH3eLBZNP3k8qSsP9bYLMcWoqs6NU/xr/RO8FsA8Gq+rDxcByUqrFC1imNK3qeBiTTrevl21mIl2ItGyD/37GlpPOZYelu7L5mr7q8RblUfSiIpqQ6Tv2c2pvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8ZaBwiDAK+rq4lu0xytsBVoCBR19Q7S5zAXFLjMMe4=;
 b=zWyU2dvrSmor+kDxi87dYQ0CApdJVBxJi/1WSJCC9JLQzW+7ZOSUXLtJZyHaTFzmiCbqEjOwP4VckBeGuFR2g4lr32Zmn3BTBKHAtTl4W8ynnj80fibwGZS2fxl+wl//NLjaKk3Q4XF2HERPnGk+260PT0oBjxc9MvkJqwyV+qPJFjhHXYbD+oxs3tANHGcjj6/vHk70E4m7cPJpIX6r82hDIuTjGCs8Vs+cbbHKOD7O6DX6fazaVBEP/b63nHzPVI9QHU/YmfEYeFeGuMLwq9tXmIueN0JaJyx2GSpYyq8giw4PZIlvrNEa2/U04AJ9RhBbc/ihYZ09TwqEj5KegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ZaBwiDAK+rq4lu0xytsBVoCBR19Q7S5zAXFLjMMe4=;
 b=spXY6lzIBSdWFxcgEns/GQ1DNc9CS+dBS+eZm4tXMvbmdWCm29GwTXIy4d77JFhYCTG25AuiEOgzkouEDkfvKAF43dLFUI6di2Jpfi8FZPoPY00uEFejKcNZGFJlq5ZE5tppL4RSIRRhWidO+p1gOymjumxblTVjsgIvDPyTrj8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA6PR10MB8110.namprd10.prod.outlook.com (2603:10b6:806:43a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 15:04:57 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 15:04:57 +0000
Message-ID: <68bee183-ba2b-420c-b885-a6ba630f74fe@oracle.com>
Date: Fri, 17 Jan 2025 10:04:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 24/24] migration: cpr-transfer documentation
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
 <87tt9xec2y.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87tt9xec2y.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA6PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 9488a000-82b3-41d5-90a9-08dd37084e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXQ1b2Zjcmk3LzZjcEt6eWJIUXdSbEFFWW1MbjBaWHByK3BHWFN4OTdCMk5D?=
 =?utf-8?B?Mkg2TEs0a1o5YTh3RXdmZzdVYStBcFBadUVyUlA2TnZPc0pZaXZEVHhCMC80?=
 =?utf-8?B?TnJwbjNZY2hscVptMUdhU0RQOGNzY1lzUEI4eGRzSlhRQmhYMHFhZnlyQ2JL?=
 =?utf-8?B?M3V5UWo1U1ROKy9rM1FPd1BxWjlENStkRXN5czhCSGNtZ1ZCSWIrS0MvN21i?=
 =?utf-8?B?ZEE3VTJTUVlFNHc3QVkvWDRJYldkbTIxOTdLb0RwZStFbHRHaXp6WUlJNEJB?=
 =?utf-8?B?akNra2hPbk12TFVUbTJwdnU1ODJFcmhyd3BSYWwxVlpLVER6bk1OazIwbm1t?=
 =?utf-8?B?ZVZGTUdQaVdWUkdGd3pWMmlsVmdNS2NVRVMwMkpxaVRFVEwxUGl0bnZ0dlNa?=
 =?utf-8?B?S1NtMHE3UFdFMEZGUWM1S2V4QVVrNDdrVSt5WjFjMHFqbHhmQnRWZ01EMm1I?=
 =?utf-8?B?RzlJRmNXRmNlQlFvVitLYTFKNVpJcmtIaGQ5VGtCVythdHllaENkc25xLzJs?=
 =?utf-8?B?TDVOWmswdmVOT0dLNDJWQmZZTWJ1c0t4WnVkWWsxQTRvZEhtVmFaMmVlb0hh?=
 =?utf-8?B?bDRFUVd1TGJ5c25oZjluRzVwTVQwYjU3SW9nVWR6QTJrNW1PMDJiSjRtVDg4?=
 =?utf-8?B?ZnN1ekQ3N1NNWnhXOGFZcEVCR21KOG01V0dNSjVtZnZBVWhzSHJ4SzhiSVVM?=
 =?utf-8?B?SGVjcUtRN0IrbnNHeGYzWTFKU0lrVUFGK3JqMWhJYm4wRGl3UE9wM0FOdHoz?=
 =?utf-8?B?Ky9rVjBEc3RONVd4elk5VFdESGFoRloxSzM3NVN4RFhzU3krZzExbHlaZkFp?=
 =?utf-8?B?MEl2bDg2ZnhoNm9iTDA4aTZnQ25zVE1jV3cvSCtxeFJpWWhDeG9CKzAxK1RV?=
 =?utf-8?B?aVlVWXJ0TExXQjRqOEhKNW0xK3IwV0RKWHJQdk1jSzIxYmxzNFdxd2RmUE1h?=
 =?utf-8?B?SU9KRUkreDZoRmowa3dBMGZ3Z2xleG91SWZkYzk3UDdzMzd5dDFTUi9lR21m?=
 =?utf-8?B?UzlUUTF2Wk5QVUZmeUNSUGNBQzRZQXJRTHJyOWtrQk9iS3VnY1VMOXVnNjFF?=
 =?utf-8?B?QnlRUFFLTWtNb08vQ09ndXJEc0lwQkpDMEdsMVN3ODRwUWJxWE80VmMwUzR1?=
 =?utf-8?B?VnZxdWNWd3VzNG9yUmNYK2cxRThNUS83T0dDaTFLaTBrOFA1WkVFSXdoWGRw?=
 =?utf-8?B?RFJoZ3BmNGF1VEJUK3Z4VkgrNHdBNWMwdnVNVFI5eEtSWkVEajl1QTRpY2ZS?=
 =?utf-8?B?R2JucUdGVXFCUG9KaWE2b3dldVpsU1RlWGNPdWNQM3ViU3FLM3Z3OXNTd3Rj?=
 =?utf-8?B?ZlpJeGVMK0p1S2FjL2tGdlZSemt0bXppVXpVVC8xZmxPVllKNTR3S3hJKzEy?=
 =?utf-8?B?VENocmhBd3dSQ3poWkIwQ0RLS244S2M5VkhFSGJOQVNWRjBEb0prRE8wdDM5?=
 =?utf-8?B?ZUM0OCtaRDVJVVlEbUxLaDJieVJETTV0YkRtZ0xwSzVLb0p1NXRycWJ6bmpF?=
 =?utf-8?B?WmlYMnd1cmRobktWS2pvZWl2aUlZMUlyNWN0MjRTTDJCRWl1RlJBZmdzTGZY?=
 =?utf-8?B?dmtGcW13cjlFcEZ6c092MFR2bDlkWjhqRyt0UGVmT2tocmxWUzRCdWFiTUZK?=
 =?utf-8?B?azRkdlR0NHViVmIwSnRFSkp0eXhjS0J5a0FGTE1vbEROdXdqamJ6d3cxSWdm?=
 =?utf-8?B?L3RETHREbmJiQ3FMOUpPRGVHWkxNSnRVS2lmbjFQaEEvR2xld2ErcWs4dWRs?=
 =?utf-8?B?UEVleXV0YWtaeWhKaU5LNGxnOEJIMTRZOWJEODh3VUxESDZkaVJmblEvS2s4?=
 =?utf-8?B?VkhpN2xyZ1pMQnNsUlEzS3o1MUVLbElIRjNlQi9OT3F2TXhiVlZpbUZ2aDI1?=
 =?utf-8?Q?NkvpjUP1/kWbX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTd0b00rSzlsZ0tyVU1KK2xTSXdqd3BGcXYrUkN6WWplazVJZjlvYThLbkpZ?=
 =?utf-8?B?bGI0cE94S2o4WVpPNnNsWUhkNUJ1cXRXajRjYTBoTDE2U1FDRDhtNEUyanVB?=
 =?utf-8?B?RjFGak51S1J0K0tzN3Q5THpLZTV4a28vOE9tbVg2Z1RlSUFHSkIxcVdGY2Zo?=
 =?utf-8?B?TkgrNjhJdEZaTXQydU5adjhZOUtUeUxEdFU0SVB2MDZyS09SMkwrNXBhaW5t?=
 =?utf-8?B?bHhtVGhtc0hRUkRHZ21QaS9EZVR6T1diZFVhQ0pvVWRUNHZqSkZSTkx6Mm5z?=
 =?utf-8?B?WkoyNS9TMS80dFFiaVI2TytZL2E5R2IxVlJzTEtSVzRhd3pBYWlFVjlaa1dk?=
 =?utf-8?B?ZFY5YXF2MTh2YlBiUlFFL0FaRG8zbmdQVHUxZGJLMit3UTZWYUtMbUtoZk9y?=
 =?utf-8?B?bWc0OVFqUzNlNWd2aG5ibU1iS3hDd0JJNnJNcEpFeXNodllEcnNZTGl3SW5s?=
 =?utf-8?B?bXd5VVUzYUlRbmRIOTZIbUdjR1A2bkNrejJEUHRTWnFYaERidnc4dGRCV0to?=
 =?utf-8?B?dUluOGRZVHFFVWVDeVZEZE1CKzdFSDd1TlJSMGNJV1ZCTjQ5aGw5cnNNdHFv?=
 =?utf-8?B?d200aEhNMUNzS0FweFFOMGlGVG03ZkJjempXM1ZmVkRtaDMrQVpCZFN2RGNU?=
 =?utf-8?B?NU9qL3M1TG1xK2VROCtxbnl6VUZOb1Z1bUVORk1rZGQ4bDBLNjNaTytWNUVt?=
 =?utf-8?B?eEYrdjg1bTFUL0J3OWhpM3BMOUxkMzQzakc3aXN6eWQzalBzdWlyWGVERWFH?=
 =?utf-8?B?eTJjOUVoYllLZnpvUC9qRUVDakR6dTZYRm9aT0xrbndwN3B4SStycEk0d1BQ?=
 =?utf-8?B?WThkZkpNN0w3bXJ6OVlJZ0xOZkJERi9hT0pnbFFFSTc5ODU1UjZZVFIwTXcz?=
 =?utf-8?B?b04rcTN0dGVVcUFESTAxTFRkQnlxOGxDTEh0OW1PZEIweUVkZnV2N2VISDVM?=
 =?utf-8?B?SGRjYWVjWk95UExRNXhRQk1SOFVYRkg3TU1lc21nelRmMmF0UUFDaGpWS3Ey?=
 =?utf-8?B?NEY1M2dJSjhjcWVxS2g4a1VINVNFS2tRK1oxdWxoZTFGWnBOeXFuRGlGc0M4?=
 =?utf-8?B?ZjRwd0hmcFpoMmZPMEtnRm5MRUg1MEtJempWWEkxZWoydkc4Z0pyNUJUanVN?=
 =?utf-8?B?dEhXNVFpZnI5Zi95VkdlbGkzSVVOeUZCZ0dLc3MrTUx2eUpaalM4eVJIeCtG?=
 =?utf-8?B?eDE3c21QZWJGMGlVNzNJS3o0VEdwSisvalpkNFliUFVCeHhqbkZhK0xOZzVi?=
 =?utf-8?B?cEdqY0FFQ2FHdlF6VU04NC8xV0pQS0Viem5IZU1XazBEQmRIaGtmRUtwbjFv?=
 =?utf-8?B?Q3NRQnRpUlNNSGtQMG8rOXk5aDJ0WmhTMU1LYkpXOTQzUm8wQ2JtUG5Jejdq?=
 =?utf-8?B?cnI4a0tZT09SM1ZyeHlaSG9BMmsxcHZLUVJKdkYya2NUYnZXSEVDNEUxZFd4?=
 =?utf-8?B?U2xSakt6dy9BNGdhZ0phQVBTR0xjeDRSYW5RbVdJUHpvNSsrU1lmUFUvbkdm?=
 =?utf-8?B?bTZQV0k4NkFBb1VjaWlNMXd1bTJiZ2hFREJQMUZkY3h2L1p0Y0lKcjJDTEZr?=
 =?utf-8?B?OVpSU1REdVd1cXR1VGNTbDVBbmJ3THR5Z2YvMkFOb3JoU0E0eUl1NnlQQnRw?=
 =?utf-8?B?dFVYZ25uWDg3amJaQVltVXA1UTBVYmVxQlF6RWNpVVp1cGh4bEVERS9tUThU?=
 =?utf-8?B?cjFIYmRWQ1MvbzdzQ0JhUytvaU5FV29ibnVwYllNbnFIVTRnL09Pbng1bTd1?=
 =?utf-8?B?YkhNeGk2TWVSWHhnakNuQS82N0g5WEVOSWFlcTViQm5QOGRvRHZTTHVjelFr?=
 =?utf-8?B?Yi8wai9sMlA3UW9sTWJxbmRLWTMxc0hHQ2ZCSjNMSHZsb3JVa1pjbWVZUWlH?=
 =?utf-8?B?TlIwajlZYVZIRW1TdWNuQi9YYWJMdWl1dms0YUlJcHNYd0YrckZkMFFPcThm?=
 =?utf-8?B?ZVIxUHNMZitaYWRBUzBaVEsrcUJPK3kwd1BSdkJKWEJJbFRzN0I0SzBPQnZn?=
 =?utf-8?B?bHI4NlZwMUoxWFBSZW9yVnk0cTIvZGk1Z2c3Q1U5OUdOanBpZFJUQzJrZ3pm?=
 =?utf-8?B?Qmw4L3lueXFUK3N4OUxYQzBSN0Q4Y01RT3ZEb3lINzI0MHhUOFZlK2FJZWpD?=
 =?utf-8?B?WHdNQlJ2K2N4UVN4M0dlN1BQSWRYUU1tbm52U2J4TFk5ZzBzN1Zwb0Z0Lzg3?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Se0mqHWLj+P+w/qLvq9Z2rt2sk84fYL+orF/X4V/S7o0GY8GRPhy5u890ot6RgMwRd5smqO4oaGSawONwJ/Q1pM/wFqmfg1bCDacQH3Yag2bJHQimjeiF3Grc/j+ARpgb/s9IefnCwdRv43C8He8FhVFS8HPv5Mm7IgScrA/oAXAZ5UDjMHu6G4G8aYCot9cZO79+oZAdmS3Iz9Eu/ZKNoC1CoNqcitDHwdN0fYZ1zuv1hOdh+dqk+Broxs4vznP/MOLhXSAtKYgZ15+CKL7spfeRCPw5i2mCl2AdHz5TMxrRnkfc/Id6Vj1vwP1z6xvp9E80HxiuhYFcH70Hg2fVABNLlUq8MdpkQJg4Xx+H+beDbi+eFXcMbmPXzNVDCFLfepQ219fF9CKoMt20WN8p1xQxbSvg7X4zcimGNMBwvNQLZS3I/R3NIiQyMykYMiSht8sSY1Kq+M3Sv1TESgRtJEAm+jvfD5cKJMR7SntPqsuHHGQR8YGtu+XdyIldim1nhBZ+xRUBvCLXK4Uy1SxZYrliuCAcuJ5ysfYH0roft376kNYzW2XDWrw6q9B8GCc7owTgokreUFQAyVudPs5Vo3WONP+Ub20PVgQm9+Auik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9488a000-82b3-41d5-90a9-08dd37084e1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:04:56.8898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdgpY8jYXUsc3on9qF43SwqeMms8U48HDVxRqWc4WfKJ22qm+X9qgIIbwti/RQZufVoxyG+QWuwgd1M6dVaOL/OvxokgOhacqWWcTTfEmO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170119
X-Proofpoint-GUID: T5vNFIkVJXnUK8Z2J8EdWJGcifJMan4k
X-Proofpoint-ORIG-GUID: T5vNFIkVJXnUK8Z2J8EdWJGcifJMan4k
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

On 1/17/2025 9:42 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add documentation for the cpr-transfer migration mode.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   docs/devel/migration/CPR.rst | 182 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 180 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
>> index 63c3647..d6021d5 100644
>> --- a/docs/devel/migration/CPR.rst
>> +++ b/docs/devel/migration/CPR.rst
>> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>>   VM is migrated to a new QEMU instance on the same host.  It is
>>   intended for use when the goal is to update host software components
>>   that run the VM, such as QEMU or even the host kernel.  At this time,
>> -cpr-reboot is the only available mode.
>> +the cpr-reboot and cpr-transfer modes are available.
>>   
>>   Because QEMU is restarted on the same host, with access to the same
>>   local devices, CPR is allowed in certain cases where normal migration
>> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>>   Outgoing:
>>     * Set the migration mode parameter to ``cpr-reboot``.
>>     * Set the ``x-ignore-shared`` capability if desired.
>> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
>> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>>       ``file`` type, but one can use other types such as ``exec``,
>>       provided the command captures all the data from the outgoing side,
>>       and provides all the data to the incoming side.
>> @@ -145,3 +145,181 @@ Caveats
>>   
>>   cpr-reboot mode may not be used with postcopy, background-snapshot,
>>   or COLO.
>> +
>> +cpr-transfer mode
>> +-----------------
>> +
>> +This mode allows the user to transfer a guest to a new QEMU instance
>> +on the same host with minimal guest pause time, by preserving guest
>> +RAM in place, albeit with new virtual addresses in new QEMU.  Devices
>> +and their pinned memory pages will also be preserved in a future QEMU
>> +release.
>> +
>> +The user starts new QEMU on the same host as old QEMU, with command-
>> +line arguments to create the same machine, plus the ``-incoming``
>> +option for the main migration channel, like normal live migration.
>> +In addition, the user adds a second -incoming option with channel
>> +type ``cpr``.  This CPR channel must support file descriptor transfer
>> +with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
>> +
>> +To initiate CPR, the user issues a migrate command to old QEMU,
>> +adding a second migration channel of type ``cpr`` in the channels
>> +argument.  Old QEMU stops the VM, saves state to the migration
>> +channels, and enters the postmigrate state.  Execution resumes in
>> +new QEMU.
>> +
>> +New QEMU reads the CPR channel before opening a monitor, hence
>> +the CPR channel cannot be specified in the list of channels for a
>> +migrate-incoming command.  It may only be specified on the command
>> +line.
>> +
>> +Usage
>> +^^^^^
>> +
>> +Memory backend objects must have the ``share=on`` attribute.
>> +
>> +The VM must be started with the ``-machine aux-ram-share=on``
>> +option.  This causes implicit RAM blocks (those not described by
>> +a memory-backend object) to be allocated by mmap'ing a memfd.
>> +Examples include VGA and ROM.
>> +
>> +Outgoing:
>> +  * Set the migration mode parameter to ``cpr-transfer``.
>> +  * Issue the ``migrate`` command, containing a main channel and
>> +    a cpr channel.
>> +
>> +Incoming:
>> +  * Start new QEMU with two ``-incoming`` options.
>> +  * If the VM was running when the outgoing ``migrate`` command was
>> +    issued, then QEMU automatically resumes VM execution.
>> +
>> +Caveats
>> +^^^^^^^
>> +
>> +cpr-transfer mode may not be used with postcopy, background-snapshot,
>> +or COLO.
>> +
>> +memory-backend-epc is not supported.
>> +
>> +The main incoming migration channel address cannot be a file type.
>> +
>> +If the main incoming channel address is an inet socket, then the port
>> +cannot be 0 (meaning dynamically choose a port).
>> +
>> +When using ``-incoming defer``, you must issue the migrate command to
>> +old QEMU before issuing any monitor commands to new QEMU, because new
>> +QEMU blocks waiting to read from the cpr channel before starting its
>> +monitor, and old QEMU does not write to the channel until the migrate
>> +command is issued.  However, new QEMU does not open and read the
>> +main migration channel until you issue the migrate incoming command.
>> +
>> +Example 1: incoming channel
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +In these examples, we simply restart the same version of QEMU, but
>> +in a real scenario one would start new QEMU on the incoming side.
>> +Note that new QEMU does not print the monitor prompt until old QEMU
>> +has issued the migrate command.  The outgoing side uses QMP because
>> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
>> +brevity.
>> +
>> +::
>> +
>> +  Outgoing:                             Incoming:
>> +
>> +  # qemu-kvm -qmp stdio
>> +  -object memory-backend-file,id=ram0,size=4G,
>> +  mem-path=/dev/shm/ram0,share=on -m 4G
>> +  -machine aux-ram-share=on
>> +  ...
>> +                                        # qemu-kvm -monitor stdio
>> +                                        -incoming tcp:0:44444
>> +                                        -incoming '{"channel-type": "cpr",
>> +                                          "addr": { "transport": "socket",
>> +                                          "type": "unix", "path": "cpr.sock"}}'
>> +                                        ...
> 
> I'm attempting this and not having much success. Surely I'm missing
> something:
> 
> 
> $ qemu-system-x86_64 -cpu host -smp 16 -machine pc,accel=kvm \
>    -drive id=drive0,if=none,format=qcow2,file=img.qcow2 \
>    -device virtio-blk-pci,id=image1,drive=drive0,bootindex=0 \
>    -qmp unix:./dst-qmp.sock,server,wait=off \
>    -nographic -serial mon:stdio \
>    -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on \
>    -m 4G -machine aux-ram-share=on \
> 
>    -incoming tcp:0:44444 \
>    -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}' \
> 
>    -trace loadvm_* -trace cpr_* -trace migration_* -trace migrate_* -trace qemu_loadvm_*
> 
> cpr_transfer_input cpr.sock
> cpr_state_load cpr-transfer mode
> cpr_find_fd pc.bios, id 0 returns 15
> cpr_find_fd pc.rom, id 0 returns 14
> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 13
> cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns 12
> cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns 11
> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 10
> cpr_find_fd /rom@etc/table-loader, id 0 returns 8
> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 3
> migrate_set_state new state setup
> migration_socket_incoming_accepted
> migration_set_incoming_channel ioc=0x564dc31e7000 ioctype=qio-channel-socket
> migrate_set_state new state active
> loadvm_state_setup
> qemu_loadvm_state_section 1
> qemu_loadvm_state_section_startfull 2(ram) 0 4
> qemu_loadvm_state_section 3
> qemu_loadvm_state_section_partend 2
> qemu_loadvm_state_section 4
> qemu_loadvm_state_section_startfull 0(timer) 0 2
> qemu_loadvm_state_section 4
> qemu_loadvm_state_section_startfull 1(slirp) 0 4
> qemu_loadvm_state_section 4
> qemu_loadvm_state_section_startfull 4(cpu_common) 0 1
> qemu_loadvm_state_section 4
> qemu_loadvm_state_section_startfull 5(cpu) 0 12
> qemu_loadvm_state_section 4
> qemu_loadvm_state_section_startfull 6(kvm-tpr-opt) 0 1
> qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
> qemu_loadvm_state_post_main -1
> migrate_set_state new state failed
> migrate_error error=load of migration failed: Operation not permitted
> loadvm_state_cleanup
> qemu-system-x86_64: load of migration failed: Operation not permitted

Check for a mismatch between the qemu args on the source vs dest.  Maybe -cpu.

- Steve


