Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3528E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 22:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOP6y-00083O-Kr; Thu, 19 Dec 2024 17:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tOP6v-000832-3J
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:35:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tOP6s-0003Cp-Ru
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 17:35:12 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJKeqvR030414;
 Thu, 19 Dec 2024 22:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=E7tP/SPInc7rFZ8/QvkDwB+wkznmdrDbDBbys5nF23E=; b=
 F2p60ZKPPdi9DSQ1AXzsR/GXlkwBOWzfKN+egIBgi/NxyNxaBLo8j4jTEgcg8QwH
 uF6LoY6dFev3EVyrnCwrUFPx9oK2TprsdMGrErEOIqrJj9JFjCDG6QeLsPgvIlQU
 kri2bdMBUHGBKv7N3ckpwYzKX12ts0Ky+4ZThGxtGaIYtWeAReKpOX3ZjFTrDJbF
 4orvbHbb1O/KgkWvOs2INZA9pih8Id/TUezcTXFPyYpXUPY5+LdGWz+tQv/Z4r+n
 UVx1xFd3t8GItSmfwHzkXOy9ylmrQNhDHDaHPTy6kTRA6sI53S5LCLXSXVvLrXut
 is3jFfagtThoivnlOX+sVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ecc2wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 22:35:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BJMIsKE039263; Thu, 19 Dec 2024 22:35:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fbx5sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 22:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDpZj/bEFoxffssw3lnyyqZIAY4j6MIp3K8KRRURMbKA0mfglyMvrySGz+Ek5hlpmfWPXzFqMjaWEtPHqizfW4maILsOumXtIDi1dBZ40cA1hmNDoz2RZHl4riB9bztQkVKA0vTx9YcInrajzUndPEpEzmpTJcsPcqTdwnURel06uTpYWcDeTN1vFS3HU7dPqNM3IhKnqZJ+3fFYR/zf4ZlFtAGnSzJ4jy0CcPL/AlZ0szbU4Zq84zdKDNnE31KzpbALXepnqBz+lsO6Um5XVf//WeeDij1QZ1udEDZwLVjvtFHp2PumqXgmxlYH8sx309YoJYoXw7ZmlHIOX47Ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7tP/SPInc7rFZ8/QvkDwB+wkznmdrDbDBbys5nF23E=;
 b=oQFigpByXufzjMMmfe7RNIkek3L0J4VZWa1OYMcbBc6TQCvqxXQ/buRcqX0/dbuHrAIrK9SoXjxPwV9ZKQi1Cfnv04bFxzfkX1T5Bh/BeqF9IZzLsOLT3Fzv6we8sNq/fRamvY7RN8lqw7lV8r3S0ftvT3XQzZukbZMC1yukipyK4cDrRr8mH/mCoB5JnQRBQW728ByvrjT/UKu7yu4KfeBZoCOdhmLtrm+SEQKyaNthffjbboF0t5yJsqZE2qR7qeK5A+43weOhb1MOWmqHEVju7BOjhY5WVWc8eOB+6bM/8h8G4oY7YzHbpIWz54loTRJQLQ3cJcjSbpkx0FtKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7tP/SPInc7rFZ8/QvkDwB+wkznmdrDbDBbys5nF23E=;
 b=TZfJl3Gx4i+Ke4Do2HENd4sR4acOfwPnb69HxViTBWtOeZvtIK3afifsFbC6QHtbUOw5KRipmllJL32jyTp5fi+1rFar12xkIXrZlPR2AcwlUCUAG7XBoBS7J2/F4SjMt6SzZC5KpG9ZvFigWDY7AxJH7LUlL2JEHviVpxE+t6s=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7515.namprd10.prod.outlook.com (2603:10b6:208:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 22:35:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 22:35:03 +0000
Message-ID: <b4bc3c30-45f2-4224-92a8-33a1b06bc34c@oracle.com>
Date: Thu, 19 Dec 2024 17:34:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 18/19] migration-test: cpr-transfer
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
 <Z2RQQwWuj1v1aarN@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2RQQwWuj1v1aarN@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:408:e9::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3faab4-7d72-4ee6-1003-08dd207d6192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE1OWWZkQlJsajQrVkpyd0ZwN1hMY0N6em56UC8xTWk5SlRkZXR1YjhYSnUr?=
 =?utf-8?B?UnZnaERPd3c2RG9YNDR4aS80RVhMZWhPNVVhc05Wek1GS2ROMlNndkFCcFFa?=
 =?utf-8?B?V3JsT1hWSXJnN1NjU3VhUWdSTnJZSUh6VHd3cnIyS1c4TmhuNVRkc1cwcHdZ?=
 =?utf-8?B?eGRWeisvZDVpNVhvZHNjcml3elFSS2JoblV2TU9KMWRZU00vajNuR0RoKzIy?=
 =?utf-8?B?T2RiRDQ5UHc0Y1grTThHemZDVGpTZFV5dExXT2VtcUZjLzNZa3NXMWtIWXFq?=
 =?utf-8?B?VFJHMkp4aHpWZHliSmJsQlpQK3pCOTFVdWVlY3RvMSs5b1RUWGJQREZVRnFK?=
 =?utf-8?B?b3laUU8ybHdnMlN6QVlCdDJWcHFWcXVQbUJlSlJnVk43RW5iUDJVTVFVVGdQ?=
 =?utf-8?B?N0hBenZkN05lTGJoOUdHaTZsWEpERyswZElraVZsSVJxVnRLTkJ5K3hkdDdt?=
 =?utf-8?B?Q3E5dTR1MFc5L2R1SHF4ZWpmODhSUFMvOHd2VHFJYnpqZnplZXJTMFhmRFBp?=
 =?utf-8?B?eHo1cFZnejIwcUpTU09vUXVDY0cxY05wY2FHWnY5SVZKYitRN2FmVjNvc0Fa?=
 =?utf-8?B?SWlvemJJa1l5Nk9mTDU1RGFzelpqcHJEb2ExK3dlQkZMcEg2aDB3dkhTR3k0?=
 =?utf-8?B?SU9pN0pBd2JkT053VkplM3JrMkl2a0xxZjVDT1EvalVsTm1ubDZ1emtCWTIx?=
 =?utf-8?B?RUJCTFkzMS9Wa1UwU2VWZ2VNSG1LVFh0enNzck9FVHRzd29sY2s2RU5DaG5O?=
 =?utf-8?B?WmU3TFJ3RW9sbmN4UE9RMG9CdDV2eUJ4ZW5lMFZNMDZyZHhxOXRzMmdSQ3cx?=
 =?utf-8?B?Q1IyVnN6aWljMjlkejhCV2t3bkRDa1FLTzVVT2psTFM0MEJnTTRzaVJjZ0Zo?=
 =?utf-8?B?dG91SzFRMmR0WmFnUW9XRWVieE1KNXdsd3J6TkFmVDhobmdBcEZ0TVdzb0po?=
 =?utf-8?B?MnppSk1pZk8ySHdUajhRdGkybkRRbXdLTFZwMUxTeE1ZTE9wdStNb2Jlb3VH?=
 =?utf-8?B?U29YUEpuWmdCOW5jNE1RdjBZczA5cVQvT2ZHU2VGWkVTV2Zib05TRnZMQnY4?=
 =?utf-8?B?M2wzUW5lTDlPNmtJVnpKZUtDTFdjNlUya2xaNysrdTRMMnR1Z3d5ZGFaa0Vx?=
 =?utf-8?B?alFLbXVaRGFmUWFtWnBTdDNwK1ZFOXRGaWZlSkRXVyt1TlNEQzNMcmFjZ1VV?=
 =?utf-8?B?KzNrVTM3Y1ljQUNtQmFHaUxqZXZqZmJVejRVcml0UVQ5Nm4yNXpuWkEvTHRL?=
 =?utf-8?B?eElWVk1MRHlQU3NhdDg5WnJBSU1ST1lkVjA3a2VwWm90OG9xcFVZdkdMcy80?=
 =?utf-8?B?aVAyWDFBN0tWcDVkd1J5VFdMcWVaTzE0ZGpTOGE0UWEwS2lEZkVvS1g0RmF1?=
 =?utf-8?B?Nll5Sk9MV2graGYvYVpJSEZzdHZOdHFFUEQwRGwzVnUvRkl4MlFHRVU0d1Vn?=
 =?utf-8?B?MGtIbWorYXdZRUJQQ0xmeWpmL094dFJVWmJoMFdNMnpPMjRpeWk5aGFndmdD?=
 =?utf-8?B?RFdob3dnVzdqWlROSGdwbkxrL2pDNlJSOUdDMi9VN3BnR2pmelR3OEZQVVIy?=
 =?utf-8?B?TXpzR3Y2eXdFUWpHQ2xUZDhWNFE4cjg2VmpuTVhxRzFXZ01RSXBVQ3dkNTdx?=
 =?utf-8?B?Z3RsbHRyeHZrNHV5bXZhbUdxUkZyNXh3dyttbURCaWdJeHYzN1RrZmE4S0Jx?=
 =?utf-8?B?MUlOQnM3MzRZbXR3eWY3cXFuZFNIUkRoVTVjU1hIQWtlU29ENmdXK2d1cFdU?=
 =?utf-8?B?SHpaaW1zTHFiK1lzUy9OV0tXMlgycnZBZXhMK0huYlNadTZ3QlRrRWhFb3Vq?=
 =?utf-8?B?RmhKeEw1OVU4N1BpR3FXdzBQZ21HdllGTU40QnhNMWlCbkQ2UlFLSVBFa0hS?=
 =?utf-8?Q?waCmsJpwDi+gJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFuVTFIUW4zckJVUmVtZ2lVOEl0ZVFtenBvOHVabzVxdjdRRmdRcllWM3Vx?=
 =?utf-8?B?VE1oOEZNcUZZVGZDK3N1eVN6bG13Nll4UkRjQStDVU9zd1NDdlUvd1JUQ1Zr?=
 =?utf-8?B?UExDQnMxM0ZaYUhXTEZYNUxtM215NEUzVzVjRlZweTZ6OG00b1gwT0kvcmJi?=
 =?utf-8?B?VksrSXRWdFpXOUdqelh4YUM4Z01sMll0dFVIOGROTkQwWFBwMlE3SjNabGw1?=
 =?utf-8?B?VFlSUFJVcEpYck1Qajdhc1VpTThJVXBVamRua3c1RGJWbENyRWZVa3liZDNG?=
 =?utf-8?B?Z1dGL0w5UVdLSTdwbjlNV3l5K0hEYkFUa1RrNDlwRlIvYTBlbENJbE44TmV1?=
 =?utf-8?B?aktJbmVRT0VOM0ZXT1BVNTJRQzlMQXlVVVVUVUZYR0xnQ3RiY0hIRUNxTjlB?=
 =?utf-8?B?UzhBbTdiS1cwUUNibU1iOEd5WGpESmVXOWNidG1wYUM5ME4zYTR5Z3ZDeGxB?=
 =?utf-8?B?VlQyY0RLRzZQbWpqMk5rbDNwY0plTG51SnJ2eGJkRkJaSG5XUTJ3MlNNRnFU?=
 =?utf-8?B?VGg2MmFOZWZWL01URWxBQWw5L3NPVXIrWlRaSVdxK3Zob0JZUkNScHlOcXJj?=
 =?utf-8?B?RVVqd1ZUUjl5bXZEWE1xT1ovZU5VZ2ZNWWdZbzNaZUNBQ2dvSFZuK0hXYzds?=
 =?utf-8?B?V1MrNW95ZmMra0hRd0tna1RFSktnVHBmSHRtMEZTQktIVFVxeHR4YmtwTCsr?=
 =?utf-8?B?SW16dU42aFpKTDF1cldxOUZKQnIzdGpDWnRTck9ZVTRFN2o1UUJsRzFwcUEy?=
 =?utf-8?B?YVNFZm1ackpIelBPcmFzK08wK3RPV3ZzYmxOUlJoSnpQSnd0V3ViK3hvWUVx?=
 =?utf-8?B?N3pLRnpGSStKY0FIY0Y4ODRyTTJpK24ySVBaNTJRTXdMVzNORmVHS2R6NFl6?=
 =?utf-8?B?emRKbk1YNkFiRllDQlVlR0Vwcmh1NTB5encvS1RqaUZTdjZsemlqRENOcWxp?=
 =?utf-8?B?OFNOQzhrNG1YaDVub08wTGhEWFpUZHovdnhtUUVrTXIvYVRGa1B3Z0pnUzdl?=
 =?utf-8?B?R1NLRnhSelVRY1hlYmZObU1hMXh1QnMyQzY2cGdyOEMyV3N6d1N4WUdWS3pk?=
 =?utf-8?B?dE1FUWY4dUptMnA1NGdUc2JHbEFxSENUMU1MRDhUaGQyb2pBQTFxNWF1dEhr?=
 =?utf-8?B?NmJsRThMTW4zOFhNbVRrbkY4VHBDazlpRFZaRktsSmE2T283aitmQ3pHRDN1?=
 =?utf-8?B?bG5sZXU2L1R1QXFTQ0dISFlIa1Y5bUpRMVRNY3JDQ1E4MXVtbnNRSEU5UnQw?=
 =?utf-8?B?NXNxZVlZT2hhNmRXaGhCTHh5em8rTmZZVTZpVm1DZW1tdHhONTBPRXJZd1Jk?=
 =?utf-8?B?Ym9aa3NwTTd2eW92MENuVk5IajRwd0JWQVBjTkRXTHhaVHBHQ3ZDejN0VHYw?=
 =?utf-8?B?UVVUKzZhK1B5K3pjK1FNTUxNOHJXYTlCV0FaWEphU1gwUlVjeW4zMTdLL3Iv?=
 =?utf-8?B?Z0RISzNnRTdYYTNaNC9mR2VpWjhKWHp1V2hLbW9XWDYvcTUySHZQWGV6NmZW?=
 =?utf-8?B?Wm0rRTl4eWNiR201Qi9LZ3V2eEVUbmg4TG9YQjBsSDRVQThVdTc5eE8yeTZC?=
 =?utf-8?B?YnoxYWxTMCt6dEgvanRRd01uU3FJTVpqZHFMVGNzR1hScmZyZEs4aW9GakNC?=
 =?utf-8?B?VWxjcVlEUXdKS1ZjSEFoamNqZjEvWHhUbitXaUtkNGNVRFFlbE1SWkpLaFRC?=
 =?utf-8?B?NU5NUUU4elhzSmhkOUQyV2RRTFh1V2VnYmVXS2RkOFNSUUlqZnNWeFBTTE9O?=
 =?utf-8?B?bGhVL3FOU0hYa0ZUNmYvTmZQYitGWXRGUE5tTW5LVXQ3eHRQSnNyM1JaN1Jv?=
 =?utf-8?B?ZUhTS2c0aVJxWlhzTEVYTEJ1cEN6WU9yd1p5RTJiMHNVSzZob3VPcW9MU0FL?=
 =?utf-8?B?d3FCNlp1c0xIajFnOWdHa2RaazI0bGRYWjRmSS9BRFFRUytrOVB3OVUrc3N4?=
 =?utf-8?B?ZlRxWTJrWUJyek1KOEJnVk5uenRabXhhRmFxcDFrakJiSHMrTSs4d0lXWUx6?=
 =?utf-8?B?NmRHWnRsMEk5aFJGUUR4Rk9qdTBJWWsvVkhzTnRjRHQ2S0tvajNyUUNLckg2?=
 =?utf-8?B?K3dPekhXRExKZFUwQVMwajhudnROamZVZEx4QXl5enZ3WmgzOVg5NUtIdmxW?=
 =?utf-8?B?QzZMbmwrbEtNaWhIQzg4Z3Q4a1JVZy82UktnREo5T1BLakYvdXlackNMejVH?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lGnkYJO9/oALdxx94PcPe2d5Jhfwr1hZDdJ99DsznStuQZA6nmfcSCY5ZSrrL0PMgVYG/2c/mtj932EuObw6I51ZDXchICgA8eQ8Jna/33H/lg3rUauV1VMgh0khHAWvFvtHGlt9LCQkg+0e9qISfhu+VYKlW5a4awZYWrieA2srGF6l62l8oFWhx8v2Bn435S8o7qX0S1IKStDFYft49nLm5grFXlUPwVX2kF/NQ2TBd3iGA27zUqu2Jr+HHKceoK1YmHC5c0tr2LycUQkmmRgT0A7VDloqdVwVh7+wqtOZiv+1XNI0WnoFQwKjyhbpPTbYff+7luERXDxExzSVGtqBk10dHSr8gKrzhVfM/5XyKETwC9t+fRjvI/OTYqvXC5YaZZ1heZwhfuqPIzDfCZY8ba+9ezsmm5YbtcdYg09EEZ3DnXjpZGCO1cT1yCp6u5THXqSrrjdyDyjgiRPSN9oJFY+qpJ/8FvXHh6O7NJAUdZbL79lsvEy5jS2oY9hwLQfwBojC/flbGcptxcCPgoO+rAcsTWJQjRnO4J2lKsOFY6wHQFTpwvmU5NQrwk+EVyauPgEGDIXrezpsjc8XM4KM5JDyS2dMuuVWmJJXWjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3faab4-7d72-4ee6-1003-08dd207d6192
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 22:35:03.7758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU8pieWi/m8cnVIJTogR9+gClhTnlaDim/q6n9WcketMwm0G5OLZIaEZuDQnupC+ezHGUy43m37ualEs66cOu0EkdmkIv1HznR7NQkE9/EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_11,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190178
X-Proofpoint-GUID: NukAFZhNaKrI23LZcy6fPRAZ1GHragD_
X-Proofpoint-ORIG-GUID: NukAFZhNaKrI23LZcy6fPRAZ1GHragD_
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

On 12/19/2024 11:56 AM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:20:10AM -0800, Steve Sistare wrote:
>> Add a migration test for cpr-transfer mode.  Defer the connection to the
>> target monitor, else the test hangs because in cpr-transfer mode QEMU does
>> not listen for monitor connections until we send the migrate command to
>> source QEMU.
>>
>> To test -incoming defer, send a migrate incoming command to the target,
>> after sending the migrate command to the source, as required by
>> cpr-transfer mode.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/migration-test.c | 72 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 8bc665d..4eb641c 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1729,6 +1729,7 @@ static void test_precopy_common(MigrateCommon *args)
>>   {
>>       QTestState *from, *to;
>>       void *data_hook = NULL;
>> +    const char *connect_uri;
>>   
>>       if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>           return;
>> @@ -1766,11 +1767,16 @@ static void test_precopy_common(MigrateCommon *args)
>>           goto finish;
>>       }
>>   
>> -    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
>> +    /* If has channels, then connect_uri is only used for listen defer */
>> +    connect_uri = args->connect_channels ? NULL : args->connect_uri;
>> +    migrate_qmp(from, to, connect_uri, args->connect_channels, "{}");
> 
> This smells like abuse.
> 
> If the test case sets connect_uri only because of below...
> 
>>   
>>       if (args->start.defer_target_connect) {
>>           qtest_connect_deferred(to);
>>           qtest_qmp_handshake(to);
>> +        if (!strcmp(args->listen_uri, "defer")) {
>> +            migrate_incoming_qmp(to, args->connect_uri, "{}");
> 
> ... here, then IMHO it's abusing connect_uri to start service incoming
> ports.
> 
> We do have solution for "delay" incoming, right?   Shouldn't we use
> migrate_get_connect_uri() instead, then never set connect_uri in
> cpr-transfer tests?

We cannot use migrate_get_connect_uri() to get the URI to pass to
migrate_incoming_qmp, because the migrate_incoming_qmp sets the URI
returned by query-migrate.  chicken-and-egg problem.

I'll add channels support to migrate_incoming_qmp, like migrate_qmp.
The cpr-transfer test will set listen_uri and connect_channels but
will not set connect_uri.

>> +        }
>>       }
>>   
>>       if (args->result != MIG_TEST_SUCCEED) {
>> @@ -2415,6 +2421,66 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
>>   }
>>   #endif /* !_WIN32 */
>>   
>> +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
>> +{
>> +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
>> +    return NULL;
>> +}
>> +
>> +/*
>> + * cpr-transfer mode cannot use the target monitor prior to starting the
>> + * migration, and cannot connect synchronously to the monitor, so defer
>> + * the target connection.
>> + */
>> +static void test_mode_transfer_common(bool incoming_defer)
>> +{
>> +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>> +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>> +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
>> +
>> +    const char *opts = "-machine aux-ram-share=on -nodefaults";
>> +    g_autofree char *opts_target = g_strdup_printf(
>> +        "-incoming \\{\\\'channel-type\\\':\\\'cpr\\\',"
>> +        "\\\'addr\\\':\\{\\\'transport\\\':\\\'socket\\\',"
>> +        "\\\'type\\\':\\\'unix\\\',\\\'path\\\':\\\'%s\\\'\\}\\} %s",
>> +        cpr_path, opts);
> 
> Nobody will be able to change this easily.. Maybe use g_strescape()?

Agreed. Fortunately incoming now accepts dotted keys after a suggestion from
Markus, so this can be:
   -incoming cpr,addr.transport=socket,addr.type=unix,addr.path=%s

- Steve

>> +
>> +    g_autofree char *channels = g_strdup_printf(
>> +        "[ { 'channel-type': 'main',"
>> +        "    'addr': { 'transport': 'socket',"
>> +        "              'type': 'unix',"
>> +        "              'path': '%s' } },"
>> +        "  { 'channel-type': 'cpr',"
>> +        "    'addr': { 'transport': 'socket',"
>> +        "              'type': 'unix',"
>> +        "              'path': '%s' } } ]",
>> +        mig_path, cpr_path);
>> +
>> +    MigrateCommon args = {
>> +        .start.opts_source = opts,
>> +        .start.opts_target = opts_target,
>> +        .start.defer_target_connect = true,
>> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
>> +                                " -machine memory-backend=pc.ram",
>> +        .listen_uri = incoming_defer ? "defer" : uri,
>> +        .connect_uri = incoming_defer ? uri : NULL,
>> +        .connect_channels = channels,
>> +        .start_hook = test_mode_transfer_start,
>> +    };
>> +
>> +    test_precopy_common(&args);
>> +}
>> +
>> +static void test_mode_transfer(void)
>> +{
>> +    test_mode_transfer_common(NULL);
>> +}
>> +
>> +static void test_mode_transfer_defer(void)
>> +{
>> +    test_mode_transfer_common(true);
>> +}
>> +
>>   static void test_precopy_tcp_plain(void)
>>   {
>>       MigrateCommon args = {
>> @@ -3905,6 +3971,10 @@ int main(int argc, char **argv)
>>           migration_test_add("/migration/mode/reboot", test_mode_reboot);
>>       }
>>   
>> +    migration_test_add("/migration/mode/transfer", test_mode_transfer);
>> +    migration_test_add("/migration/mode/transfer/defer",
>> +                       test_mode_transfer_defer);
>> +
>>       migration_test_add("/migration/precopy/file/mapped-ram",
>>                          test_precopy_file_mapped_ram);
>>       migration_test_add("/migration/precopy/file/mapped-ram/live",
>> -- 
>> 1.8.3.1
>>
> 


