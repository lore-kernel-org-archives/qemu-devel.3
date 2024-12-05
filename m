Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18163E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 14:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJCmN-0001kc-Ng; Thu, 05 Dec 2024 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJCmM-0001k8-7w
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 09:24:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJCmJ-0001pP-Hj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 09:24:29 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5Dfjid019955;
 Thu, 5 Dec 2024 14:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=qzRbEAmxA9Mk8LKAVqkYS/5tQmAESQb2Lt2KZfVBS0o=; b=
 RsWvme3MO9B7fSZqyfCu5rByM9nUrPt/qaifJF+SOWwSVm57PXw3W0LwoO/FFiPW
 aRxkgRjEUMrVhRrFngKFTE86o0ACE/pMK0sWkXncuOYMHlux/0gZQbdZk11llreV
 ng97phLJIAge1aTNm/ljFDUtM3QZ3MSHcs25xMjNhYf7Pif341DyF1sX6vk8NHpR
 gkLW5E3+Y9wBH3OXWzB6CLoz8fpSIfh4P1hJfgzTe52XkVBeV6XRUrCyvQ44T97F
 IPvDxUba1+1sG66keRGC8B68gWyxsaNePoQUfr+k3fvuV/mWCesKnTXn9ltM4VvW
 AyrBxNX17uMcEoXFHv5+fg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2b3we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 14:24:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B5DaktL020287; Thu, 5 Dec 2024 14:24:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 437wjfj4ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 14:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBPtiv4FE/fcpeUn8QuRFTo+V1X1FjLx08im7pt9i4ab1ONOjL6R6R8C0Xbee00txJHESxzsZnS+j/0NgxNycMaygsl+2ugkuCSrR2EYnI8EednhfUwuZqAh3pAMuISO4mqYFv78q79zloPFvkgZk6fdS2NyS9vpjd+XrL/D5RhsECvgZrTIG7rSpUiaA6h0M/UHMx3ofCldY+ZIQ8saUuW9FvZ34x7qBAjDlA0P/P2i6jK1qfp7yOJZ5t7ybMxvUVA83jSGG7CiFd2zeoLBmv3CctTY/ln0kLnuhz+dP/m4xav2+nhyWL5n9QN4xuNhYCewUTzTt1LAoNkJ7i7uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzRbEAmxA9Mk8LKAVqkYS/5tQmAESQb2Lt2KZfVBS0o=;
 b=qznPj7YABKJQNVkInlTxuXIfZjiRxj3pbMS5vMUyNY+02dllgvG2c5miJZPX2qbWqi13nEDKAvDRFZzzaeakkbQo9w/ap0UnqrWfNmdutB8ugtISzNoJ6GjxJYbWTDyNcEtWC5Wgxklo1v9WNVPlxmIxExWxZLdicDatGD0hDsUSBDGbv4vEQl8PLygcTmds1ST/XVCAwzjxfZR/7Ite4VQtKy6VwWxGS7A3m0pmFaWALWPdlpPuFcgrtUEdsMSCV3nQCAu5dYeY7OkbRn18IrbvwRCUllXkLf7hNeicCnYNiPARDyFeQAMIYcMsg8LtBBPLtyCglgdTt61tz+MG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzRbEAmxA9Mk8LKAVqkYS/5tQmAESQb2Lt2KZfVBS0o=;
 b=Mmfmqa8hoxovU2Mf73oeO3/InK4UiR2OC5IQ2R0EiKR7iwysdBs3c4rPpqeNtSFrTCcquW8tx0G/5k44Jq0/NA0iygapUmhHJAMrKw0xvjR76vnANDILBTm5vu7EiOThEdxT9BXY8qVRji/ubppCRPqN0xhPUi/jfoH/2upHQ+k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 14:24:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 14:24:18 +0000
Message-ID: <818318da-cd4f-421d-bf30-608392c82fd7@oracle.com>
Date: Thu, 5 Dec 2024 09:24:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
 <87v7vyfi2u.fsf@pond.sub.org> <87ikryfhk4.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ikryfhk4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:408:f5::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 655ad8b3-d31d-43d9-c854-08dd15388141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXdCY0tLeERuN2RscVpudlc5eW5uY2h0TVhVeHJjRVRHZTBjQU84RjFZOU9H?=
 =?utf-8?B?ZHpkSWxDU3VpKzRCM3czNSt1UG9Bd25pZWdyWFJpVDNsbDNVWnlqMmE1Qldn?=
 =?utf-8?B?czZxRFlrWDFGSnJxVWZKeThOeFRUSC9WT0pYSHlIZzdTVW1JcUIrSlp4NUJy?=
 =?utf-8?B?S3E0bjJEZFNDclVEZ1Z2TGNKZzAwR3JnbnorT1d1NzJHV1hnRHYwZ3ZEODJP?=
 =?utf-8?B?VVZVZXFZR3UxcHo3aTh0QVZZcmpQek5hdVovZnNWYzZ3WGFrVndlRmVvdkd1?=
 =?utf-8?B?U3dEU2Q2SGRMMFArQlNhaDd1QUVvL2RaazZic0t4clBuZ093T3BmUTBjcXhr?=
 =?utf-8?B?MlUrbllQbk9sTUpRbWl0VE9lSXN1UGFDa3FaeVR3QkYzQUhMUVFpSlFkODlN?=
 =?utf-8?B?cURUTFBPaG4yaWJpN1ZVZlk0SncvaWZHbUdJSUswRENnUFMvSnNZaGZmTUFV?=
 =?utf-8?B?QmpuaGN6ZUpWOGZEQW95YVhlYmxjUWNNbFdOZnE4ZzJQQVJaMzVYUC9CRjI4?=
 =?utf-8?B?Sklyei9GMmVzUW4xbSt4T1VUbGFHZFM2VXV5TnM5ZzI3T1cxRHZUU0ZGVGNE?=
 =?utf-8?B?QWlIYnM5cjE2MjVMNGF6UzZVVkRTc3BCVENzL2d2R1JNMzZQSlpLcmFubmFs?=
 =?utf-8?B?YldneURmY3cyNFFnL3B2VUlpUkNJMjhrRlVBa3RUUEJiNnoxQjdpYldlU1ZI?=
 =?utf-8?B?UWN4VFh1UU5zaVJwRzFZMGhBbzc2alZFVTdVL1lFTlpJMUVSRk1VS3Q2blpF?=
 =?utf-8?B?UVJpQnJxSnlNL250dWJvRy96aDFUdmJzZjAraWlUblVKeFpFTzZuTHJmenZj?=
 =?utf-8?B?UkROOWJzcDJ3MlkzVmZUcVJYNVdnUUg2aVBiejBBaEN6aHUwNm55enU1YUtq?=
 =?utf-8?B?emZOTU1WV0pGQUdXK3R2VXBzdUtJZDZkUFZ0U0lUYzZIWFZoWHdTOU5xcWti?=
 =?utf-8?B?Y1h5WTZMaHBoTG11U0trbklTMlNlcmpWWGY1STdIWndIQzVQSVBHSjF2eHlo?=
 =?utf-8?B?Z1ptdGNOZml5Ym0xQ0o3cmRCQW94L3lQbDVqbFlzNkJUdnozV2ExbE5WVmtL?=
 =?utf-8?B?Qm0ydklSMVduRTlmK2FtSzV5V2lVM2piTGQ3b1ZhQ2NwZmhleFZ2aUdqVmJX?=
 =?utf-8?B?VHo4R2NZdDAyRDI3eUNadXdEM20rS0pLYmxrQkZzSjhUUnFleEdoVUhCZVlq?=
 =?utf-8?B?b2xHdmR1S0xObGRqNWZCOCtiSUpXV3YzdjAzMGpFbVJHTU0rbkFmQ2dQdzdV?=
 =?utf-8?B?b3I0a3QyWDFpejFBZ0lrU1kwV2RSTjNXSU9HTlY5R1llOUlNV0xhVkpDeWIx?=
 =?utf-8?B?VXJTcko3UC9LM29zZk5uTkFvTUVTZ3o1cVNoWXliL1BsNWJzc0R4ejBBOTFz?=
 =?utf-8?B?QTNmREdka01rbmlhZlQ1ZHhzZEVjYmxURWhDR2FHd2lFb1lrVVIwdWp2ZEo3?=
 =?utf-8?B?Z2FHbWNxUnVxaENUR0NHaEpuOW9hUkgwSkVrY3BRSUtHQnZkQ3VFM1hSdFhI?=
 =?utf-8?B?a1FTajR4dE9LVE1FWDJRSk5sUUxJRTFEYVR4TXlXMy8zMTM2b0dlSVNaaW5V?=
 =?utf-8?B?SWd6YTBGMzFUVFJpTll0Smh2clRBeGhtZ2VsVnMyWjY5UktlcG9qRFUyL0c3?=
 =?utf-8?B?cUdKYVNVUUp1dUNSdzk0dFlraFNaWXI1VnovRURwYXp6U1B4L0o5QkpNTE94?=
 =?utf-8?B?cXZkVEdMdFNCdGxpOTBFa3pIR0k2ZDZFSExjajU2RVc1MHlHQ3ZJbEw2SGIv?=
 =?utf-8?B?YzByQlc4UXNYbDNNVUFsdkxHeHRuc0s5aGpKUncwUERKUHVxTWFjd1lYRHFl?=
 =?utf-8?B?eFZ1Y3lPOUE1V0d1VC8zZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZwdUVyQ2JUK1pPNms0YkxvQ2NmKzhIWnZ1TzIrak42MTNEd3VOUENIcTlX?=
 =?utf-8?B?Ylk0YTBjalViZVQwM3RLMExLTEREbFNJYXRaeUllS1l3NERmdXBBSzhwZlJ6?=
 =?utf-8?B?VUt4ZG5jSkUrb0h2c0pnbUpuRGt6OXFjbUxaUmVkYkg5TklsZXczRVJzOE5j?=
 =?utf-8?B?MDM0eE1DcVk5YUlsMk1QQVRiMkdhOWVBZThKRTRmQ0RGRW5QYWlFMG1NbXB3?=
 =?utf-8?B?MGpuT3BYd3drUGpXem1pQmI2eUdvRUJlVUpQdWliS3VKUlExeU45VzVFWTli?=
 =?utf-8?B?M1VJcTFUOG5oOGY5UzBhWWJwUk5KQlp3b2hpZ1MvWUoyNit5VnVaMmtHT1gw?=
 =?utf-8?B?aHVIL0NITGNwY2c1QnFBMzhRSWJVRklZNXZRRUlwT0QweGxXOXg4Z3JtRlZ0?=
 =?utf-8?B?ZFZ4ZjhGUVlCVExZdXVUR2xyRWtyM2Uza2lYWFJzcWp3SmxWU0wrdmtjQ1J3?=
 =?utf-8?B?SVpCdDFSWllPMWdyTkVSWmxyeTFtY3c4TVZVT0ZsQXBKYUs3S1RDTEpTSy9r?=
 =?utf-8?B?N1BhdGwvMCs3N1VnVDljdFRzV2EyWEE3akp6cUtDZkhYeWRSOTU1OE1SWmFR?=
 =?utf-8?B?dXdpVjZENWRranNnK21FeWdXYU0yYzB5Rmd4VnFEVk82Z1lrWE5pZGNsRmNE?=
 =?utf-8?B?dkNuUDhFdm1NOGk1RGs1a2dXTHluNlNGN2xGVXdkSmg3L0xlY296ZUZGOXBk?=
 =?utf-8?B?VjNhOGlUcVhTeEx6U3hiM3VaMmxnc1NKZDJhSWdUeTBDV3QzTDhvS0NybkVH?=
 =?utf-8?B?WStJMCswTDlJQi9oRDhnZzZCK1BGdGV5MlAwU3NVNytMTnNVUHdUWE55S2xi?=
 =?utf-8?B?clYzZVNPZTVmWGp4RUpJaUlUcGJFTkhOU0lZcjN0ekNLai9YTnM4dHJZZ2dK?=
 =?utf-8?B?a2o2aW5mRVM5R0hUVXpGY2JZQVF5ZC9OWlJoR3BnS0UrRnZZdlNDNDMwVEdR?=
 =?utf-8?B?WUtjQlFkd1h0STJnbzlsWHJVSmJvb0dVQzVIUWVvc2tXWk8zOUE2VUpSbmhR?=
 =?utf-8?B?eEZZMEFoUDdlUDFCK0tNR0hXNzloUFA3aG5ZWEdrYkxXbnhiZ1lSc0dPbno5?=
 =?utf-8?B?QU1yS1dHRitOSGFYTWhjc3VCZTZ0VnBwbXRINTlEWjJ5TTR4ZzdibzFyWTJp?=
 =?utf-8?B?dHkxb052SE9iNWZ6amVCTnp6NEpLK2xYbmhZaGJ1TXZKbEQwdlkzT1lFME9P?=
 =?utf-8?B?YkZ5TEtTeWVTOHhWOWU5OVdHVDhqTjlJQ0RwdHVLOFJ1eFUweHpxRlBQUlps?=
 =?utf-8?B?QUo0OXRuSzdHVGF6cXVxMi8xVm9DVEVEZEhiT09hNUw3OWI4eTZkL1FUSzB4?=
 =?utf-8?B?VXViNXFGSDFCYzk4Nll6cVl5dFdIbzVIN3h5TmF1Mm9OL0NldzZpSHY4d1Fh?=
 =?utf-8?B?SEc5ZDUvenZKREhOY3lvNlMwS3FzZUpoVWZSL2tySjVNemdFNWFVN3VWZHR4?=
 =?utf-8?B?cXl1VVR5Yk9XNXpmNHhtbVQ0MGNweEliL1o3cWxkajJjWGFsWExMWTNBbkVM?=
 =?utf-8?B?cEVOUmhxZUExdURuZ05BSGtELzR6YXdvMTJBVEdtSGNScXdhYnpFVStJaDRG?=
 =?utf-8?B?YlhwSGMzVUY4ckxTOW03Y3NtaXZOSEdXNkxQZDN2ZlN2L1BEeUExRDRWdDI3?=
 =?utf-8?B?R0x6S0Q5MW9VLzVNTXc5U3dvZkwwZGM2RzlPMlNWYVFSdGJJc3lORmJLS1ha?=
 =?utf-8?B?SURhaHcvc1hSMjdsWmxxSitNTjdFaE1oSmRBSVozTmxHK0tyQlcwSXB0NEt6?=
 =?utf-8?B?RWpVSmFBU3UvMVM5ZVVZZFlBOE9kV0ZHblEzcFBTVXVTSkJXU0FVbVJDUlFj?=
 =?utf-8?B?Q3hZZkFXNHc5VENnQ3JsUXRBbm9NbFBobnlyOWxLWmhVK2tSRDI2NXo1Z3lM?=
 =?utf-8?B?UklnNjI2WXF0S1N3OU0wTFhEaFBZNEU3eWpZcURBRkZSWEtVYTYyMWR4VG1C?=
 =?utf-8?B?bTZGNjJsaklnZmtlclBHZGFSSVc1STdEVlJYZE9oQldpbUdEWVUxTGtEbGYr?=
 =?utf-8?B?dkVXV1pPL3hqNlpseS9Jb043OU81US9PNlB2dTFWZjdPMXkyVDRnVmF6Q3Ns?=
 =?utf-8?B?R2Q1SVIyWUlVNTJCSUs3YzlCVGFHTUJDNUlvckNFRkZ0OW1MTy9tUDdTQUF3?=
 =?utf-8?B?a2lNUUdvMW1jcCtpamFZcnhOQ01RbVlPK2dRN2NKaGFJK0tpOHFKWTVLcFFz?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xMwQAeqRvKJ81o42uBgOrV8f66SrBR6GwIOeQ3PIRV9gcZFsMP5zDfProCBg83FyEPd/tQyIfv85L4il4Hyk8FGutP+1GkKszTvHNBP92gCv0VgQ/nTU9ysaw2jBzo6QRrNBB/jqhmBxqeU5NvsW5xL0tL7+BjppAVdwa+o7Awfc8c2u2sTlwIYThtU1KiL92GLF4Avyx4W2ackBb/+6/XlIKVeSoyjoUJ4JVydvR63ju+RKYJ5qTpcGwJc0NhegSIYsGdFsTQb1UG+te8+LbDe2J8mu7DDCEoWp0WIFztrQ3P6FtQbwNzo2ga5IPcuTWS8M+GbUBTpVkO2MIWoshBoylDYTZLNA7TqzOnX6pT5dYWNFtXSy5xHi72CTVOylYjjtpOuDLM/f2qa/NvIUDNrqluPe5Ne30rMz+MfI3In0YYi6Oj3rE3WmhiKLw+L+5FZDTrp6206hQEu+An5d2VB1GMjm5NQxgWNv3A1EFtqNe6bOgJ1dgRO9Y8BKMq5kKQwvWATx5rh3ZJSJr+GKj9qG98inGTEaPq2NIu1fKtot1YLGcB5B6DItIHPCAPuQR6VVG4FVBPL0crHrjPcUX42RC1h+rPScaRe0dwwT8sA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655ad8b3-d31d-43d9-c854-08dd15388141
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:24:18.9086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XrojpU59SBhQxBsyfcENEeFPw8y5x0MKod7tO0oDWsuk6GhXSmNosZcgFXOGByU+bPdmiOmxDQtptCsTs8Knkcj914XEfvPgk1vU0vs6nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_12,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050104
X-Proofpoint-ORIG-GUID: Uczmu-P1srYzUP8jbKi5hvXmTImP0YFa
X-Proofpoint-GUID: Uczmu-P1srYzUP8jbKi5hvXmTImP0YFa
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/5/2024 7:19 AM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Allocate auxilliary guest RAM as an anonymous file that is shareable
>>> with an external process.  This option applies to memory allocated as
>>> a side effect of creating various devices. It does not apply to
>>> memory-backend-objects, whether explicitly specified on the command
>>> line, or implicitly created by the -m command line option.
>>>
>>> This option is intended to support new migration modes, in which the
>>> memory region can be transferred in place to a new QEMU process, by sending
>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>> and if the mode also transfers device descriptors, then pages that are
>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> [...]
>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index dacc979..02b9118 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -38,6 +38,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>>       "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>>>       "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>>>       "                hmat=on|off controls ACPI HMAT support (default=off)\n"
>>> +#ifdef CONFIG_POSIX
>>> +    "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
>>> +#endif
>>>       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>>       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>>>       QEMU_ARCH_ALL)
>>> @@ -101,6 +104,18 @@ SRST
>>>           Enables or disables ACPI Heterogeneous Memory Attribute Table
>>>           (HMAT) support. The default is off.
>>>   
>>> +#ifdef CONFIG_POSIX
>>> +    ``aux-ram-share=on|off``
>>> +        Allocate auxiliary guest RAM as an anonymous file that is
>>> +        shareable with an external process.  This option applies to
>>> +        memory allocated as a side effect of creating various devices.
>>> +        It does not apply to memory-backend-objects, whether explicitly
>>> +        specified on the command line, or implicitly created by the -m
>>> +        command line option.
>>> +
>>> +        Some migration modes require aux-ram-share=on.
>>> +#endif
>>> +
>>
>> I get
>>
>>      Warning, treated as error:
>>      .../qemu-options.hx:117:Definition list ends without a blank line; unexpected unindent.
>>
>> Putting the blank line before #endif works for me.
> 
> Actually, #ifdef does not work within SRST ... ERST.
> 
> Elsewhere, we document build-time optional features unconditionally.
> Simply drop the #ifdef here.

Thanks Markus.  I see the "#ifdef" literal emitted in the man page.  I'll delete it.

- Steve


