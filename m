Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB13AC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoVZ-0001yK-3J; Thu, 27 Mar 2025 10:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txoVL-0001wv-EX
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:46:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txoVE-0006jJ-F3
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:46:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCT3Kw006364;
 Thu, 27 Mar 2025 14:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=favthSkHPQTObryeG2e+iWqqxjPOwAlicHwdzQAeNzw=; b=
 fV4pf6mgHiLccN7QoTECrHBq0228sTvJaD/koqvQos35TO3S0SfmPQnlleUtmWiw
 qtjLeh5xUGELgcJOWINN6CP+8kvVXTECKka3Nq+HfWHr7zyQYaPm0IuRocIqPkQw
 s8gdMP6nX7Ec1fBOmfb2+vDeTi7KMoezgmC+SN25j2gBLq1DkndOR3jb+Qz+ldJ6
 M9Ibuk8PTqnH3uJyQJdw1T+h9elXgHCfslIQ2kiFe7RhKLhUBwSjm+dsYSZLj3rr
 tzu4XKpr8UQJchizmYvfT33EmKzbwR2BQC+YaFEXFrZuWqbxtaGwSs+g2ojM4btE
 6nuzY71j439oJ1pRHGm5kw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45mqftaesn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 14:46:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52REAMjZ028702; Thu, 27 Mar 2025 14:46:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45jj6vfa5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 14:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqz0wvuINSwm67Fi4tmxU/U5G0t1alsVd8RGERsWl0khz0sHgPLyvUY/LVI7jVxetGucKgdHlg0esUdrW7wsO4peJXtRLUDD/9JUlwyYuSXSlLMfTecLyJ+L+NQX3V91T4lQ/XfvbUc1lCYp4TkD4syPFIMbWNBzQ/BB6XFSbEhv+9OR+ADajpW00TG/C6ICMLJgfK+gunKdJ4EAEHogWnMzC08ffUgPlg4smwKsxpK1fuFY9ehSpgzV5ZR9lBpvQB6liwBzXBYXOLw7gYevzfhlXS9TQKSZr7TMarJw0tfveK0RKl9R3IY34+b9MMV9zZwDr5H7CzH42PpePygx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=favthSkHPQTObryeG2e+iWqqxjPOwAlicHwdzQAeNzw=;
 b=yOM3bQbHK9bg5Vv69vAs+YB1dC5xcQYTW7ldTTcjYIX8hSamC1HRPYsN8g9UU6XFLhfDZiqWROfVKzQY5POOk2YdJe0F1+XsP0kwv7sKvXyG3swhhdM6EZHa0fX3LJXP2YHa0LKLAC0cF3li3oRstFAANXByDcsuMdNCYzL2IU9vsojy5qh1pwqGHIxkq241WF2cf+36+PWMUzHxa01Wn4zZPtCestsoejAsrglJpW5agQki7oYmjnzZ4t9pQx4zGe74fvbkxf1b41rqro6nGKRMLjrKkVTllydpLj8EM63dI+ZXzoDeDIER2vkeMBYE/UR1WUeQyakF0hv8Ixp+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=favthSkHPQTObryeG2e+iWqqxjPOwAlicHwdzQAeNzw=;
 b=nEhTp1/V5EF/4iKA3/TaNS7Mw0YQBC3N59a1pJhCP3izDR9wYY2/aiM5s19GphnPeB0EQj9vlg6ogzjThq+wod+ieKjXwadq80aMA8mRWCH0DwUoUYnEyRciNQSiX/fShgGmHRQnbMfF5Cnav8iw4DIlpZ0G/ltlJfH4rrLOuvI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN4PR10MB5608.namprd10.prod.outlook.com (2603:10b6:806:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:46:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:46:23 +0000
Message-ID: <0ecbc966-fdbe-48d8-ac3f-401d0f0565a6@oracle.com>
Date: Thu, 27 Mar 2025 10:46:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] migration: cpr breaks SNP guest
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>
References: <1743082598-428927-1-git-send-email-steven.sistare@oracle.com>
 <87iknua70n.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87iknua70n.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN4PR10MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e74f9a-849e-45b2-dde5-08dd6d3e250f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1FtY2w4Y1IxV1NJVWJkWGNoNGJ6K0VlSFcxYXlHOUZEMHFSbUFNc3BublB4?=
 =?utf-8?B?VnlLQ0R6VzQrdHVWQks1Ykl6QkNHVk0vdTNROHJSVld2RVB4SnIzeUFZSWtE?=
 =?utf-8?B?QnFTNlBpWjk2MkNCVVpSK3hlc1ljMVlsOThIdlk0STNiMkc5T2xUUjhrWGln?=
 =?utf-8?B?RERwdDhJelU4QURMYmhndXV1bmgxV3RqSCtYVjBueENPNjJDMFdTRGxzMTdC?=
 =?utf-8?B?Njc4OUhpSENOczFDTDRlVHB4VUgvaHlteUU1Skk3UjFjb3FqenpzTUpHYnFl?=
 =?utf-8?B?NEdwakJyR1crejVOaTdPcGtQSURnVTJsM3IrRE02bU1UV1Q2MHhlK0t2NDFa?=
 =?utf-8?B?bFR6WGY1cURsUGUzODYrcHJ6Q2FZKzRlbXlHRFgzUWFwMzIwdEdTVnhUcnQv?=
 =?utf-8?B?ekoyRFY5MnFxRXpvVUx1c2l2YmFSeWpoVFZhVGs4bXFWdmI1K3JPNkNXNVR6?=
 =?utf-8?B?UzVPcGF0SjFSOGR1dXlqMVROTVNoUE9yRkMyOHUvSHQrQk1mMjg4MFFSM205?=
 =?utf-8?B?Vng5K1BiL2lYUm9PMEpUaFNsRnVFYVFjSXhuV1lJek1uSmxlUm40UWNmbjJW?=
 =?utf-8?B?WjIyWFFncVV6b1RmdHBUemZwWjVXa2FWVzhDa1p1V0I1YjRQTFBISjFUSURj?=
 =?utf-8?B?STFNUG5zbGpORm1jOHhkek1SdmdZK2N2OEV2eXlRaHlrK2tFNmlVRFkzc29w?=
 =?utf-8?B?T0hHaFVEQklNbGpYYkhKRVZuaXNOWHhFRzBuNFk4bEJWMnYzNTF1WDNlRU80?=
 =?utf-8?B?enE0R3V1T203WWJwOW9JTmlWYXJjd3lsM096Z3p2djVCUHdFTjkrN1J1SHRP?=
 =?utf-8?B?S25HNlFISnV1bnBTaS9kRmd1MGlJWkpYcys5OUJjaFlRNHpMREpuRW41MCsr?=
 =?utf-8?B?SFJUTk8wTTZIYjU3M25ydThpckw1N0RHOWdIbWJCTmdrNEJjWmczeWJUTUZL?=
 =?utf-8?B?WDRvS2hzZGc1R3FDc29GdkVkdm10TXRZNFpISUl5Z1hFb3lYbVRWMFFpWHFG?=
 =?utf-8?B?Z0JSdDRRQjRYWWI2MTljcGtaSDN3S29zeS9leTRGVThsME15VlkzeXo0L2JO?=
 =?utf-8?B?R3E3SDFXTXZWV3FYOUs2WHJVY0tJRXA3bUgwV3JVOW1VeU83SU9wd0lQV09L?=
 =?utf-8?B?dHpQSG1HU2oyZUFuWHpBUDFEaW51WnV4Z045aFJ1L1RIMFR6eUVvb1RFK3hU?=
 =?utf-8?B?SWxsU1F5Y21ZY3pNdS9Rd2U1ZWoyelR1L2VMbUZjNFFqaTBLMjNQWHdZM1Fr?=
 =?utf-8?B?NXRIV2oxSzhOOEJTUWMvU2N0V2lwbjM4dlFoL0hNaFFTL25reFo3dEtPbFBr?=
 =?utf-8?B?TFJSdU1lYjRCN1ViRHg3OUR5VEg2THFLZE1LbDBVdUpiZU9rQVhYMjRxbHdB?=
 =?utf-8?B?Y2RUSDA1UXk3dldjM2RhS2p4SVlSdkRRY0owU2ppODF6anp3anV4RTlrWjRK?=
 =?utf-8?B?SUliVHljc0JkbXl3YXpXcVFHQ01tcWY4dlYxMU5ZRFpXQURleHFMWUhIMmgx?=
 =?utf-8?B?bEJpakhPVFVabU1yeG9CMVBQRGJyOG1zbDcrQzIwY2xMbTRZcmFPVEFuU28v?=
 =?utf-8?B?aFZha0hPdFFsSkFnUzR6ZDNhTzRyRy8yaGM4Qmh5OU5ST2Vrdy90S1RvcUt4?=
 =?utf-8?B?Vm9yQlNYQ3NqWU5sVlliRkFDVlVyZUxURWp4Q1l2bnZmRlY4citRam1VYkk2?=
 =?utf-8?B?NUJGU3Z5cEc4RzJaSUdDRkJpVm9MMjU3M1ZrWFBDeFJtS1dDUW1waHRiQ2hl?=
 =?utf-8?B?bVhIakxvMnFFK2RzckN5ZTVQRkM3VFJIU3gyZ0t4M01KNnJUUlg5Vk1OZXpY?=
 =?utf-8?B?akllbGxUTzNJYlNvVmovcThPR0Z6MDAyMlhvMkFtdnFlT0dSdllkUzBDWDhv?=
 =?utf-8?Q?vEqYJl3ZIJayy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpYckhiMDAzMUFDVVkyL0xDOVA1NjJ5Z0o0bEs0eHJEc3FGb3ZSSWtWUnVT?=
 =?utf-8?B?RERmNDJQb0RWQ09SZTIrYU1rb2M2Um5MSHovbjEzNGxPQk1KcG9Wb3JxUXJZ?=
 =?utf-8?B?OGdNcEJHM0pBY1VZY0xIcElEdXBGNnZrQ1YxNHVtK1lRUXhFUnM4QWUwcXFl?=
 =?utf-8?B?a09hYmVoMzlBWVV6ZkZDWCszYVMvWmcwWDMrbzIvb3QwWUtmNVI5TXNQM3lv?=
 =?utf-8?B?Mk1OZjlhWGFXK0tROWhYdk5TR2s4aDBQQm5XYlRiUHl1MGxPUnBlRHNERjE2?=
 =?utf-8?B?QXRHS3pCazVodkpPV0pNcWR1dkVzNlU4Ty9xS0V5dlJjOXBmQkV4Nit0aHg2?=
 =?utf-8?B?ZzlFZ1ZnR2ZWNkM2a0ZIUUdiZ1c3clZWdDhLcDk2MTcxT1dVclNjRm5nNGJn?=
 =?utf-8?B?MjB1YnA1aGNCY2dvejNrMnlnNUs3TWx6VmtrRlp1RmxMRjBFUFNMSVg5OXl0?=
 =?utf-8?B?d2F4SzA0UkZuVEt3SXMxNS9CaVlkM1ArYytReVNRak5GNHNVUE5sVitvWHh6?=
 =?utf-8?B?SjRPMElLVmMzQU5DSURzWkc5bTM0d3V6VzhvMEx3RSthRmlNZjczSFc0c3Fu?=
 =?utf-8?B?R2FvamJsQ29zWWZOaG0wbS9kTFBpYnd5RmxpTGF1SVlOQXBxL2ZMSWhlaVlZ?=
 =?utf-8?B?dTFLcHlFQU1sV3RvcWRidFkxcG4yRU5SajhqRHNHSFFOK0d3UUJseW93M2ZZ?=
 =?utf-8?B?QWYxWDlOUWlyd3hhT3Y2cVpIb1VJMTNNdEJnTW5GNFRMZEhzcXV3ZW4vVGJD?=
 =?utf-8?B?ZGxFaG1RTXgwWHVjZFRPblN1MmxJVEpPOGZHL2d1bTZzYzI0SFczVlhjVGJW?=
 =?utf-8?B?Um5KU2ZzTnAwN2E3RURHaVVWU29Yc0tWQkNpb3hyVUQ2SVhrdjNMU25ESEdL?=
 =?utf-8?B?MlZyb3V1STZaTGo1OU1tcVZlejJuVWhmSWFacGFkQnZtMmNnU0J4VTFIUDV5?=
 =?utf-8?B?bUdLYk15TGtBUEpPNXpLanFPWG54SkRGd3dMRit5SFdXY1VNSXYwY0RueVVD?=
 =?utf-8?B?ZGhwaTliTWVvK2JGVVpVUVh4dVVPZ0FpTUpVSkJkY3VkOWc1T2Flc0dKQm5Z?=
 =?utf-8?B?OHlFYURHOUxNTUFVcUkvOFlZR25mSFdieldNS0VSZFJBNFMySHRFQXA2ZEI0?=
 =?utf-8?B?LzgvZ3ZhQkpzTUxobmxlcDJ4dTBmVHIrNkRaeHZrOEZNS1g1SGFUbTR1c0sx?=
 =?utf-8?B?dldUcDluQ1BSUE9NaTUrSlBPTGVJNmZ4RHo2U3NWa1UrbWJHZGVyYnlQY0Fs?=
 =?utf-8?B?clR3WUlZYnc1QUJVY2tYaFArOHFnMmIwNWdLZ3c2L2VvTmJhNHpOMEtKOHEz?=
 =?utf-8?B?M0gxalhMb0pvTnA3SlVHQjltQ0huamFCN0FqUUZWQlYvVFNUL0psS1pLL1BL?=
 =?utf-8?B?UW00NzRtUk1GNVA1ZGQ5KythZGtmUndlNDF5ZDlzcVpWdkpabTZuSTFaUHJV?=
 =?utf-8?B?dHVRaWJmN2ZHblhRQzhYUzlkSUZLTHhDWWtVeGJKeTRRaTJiN0lBczgwUW0z?=
 =?utf-8?B?TFN0UXVyYkx4U2xNcmREaWNiTTFYY0dHeGs1NVpoRDM0STVtT0VlWXVYc2xH?=
 =?utf-8?B?WEVmYi81NFBwSnBXNUFUNWY4SEIwaER1REpKaXhZdzRvbHJPWlpWQmUvbzZp?=
 =?utf-8?B?c1ZJcnc0UE9ERGt1c3UreDRaaDdhbEtobkMvYnIxSEhkcmcwQjgvYTdaUFV3?=
 =?utf-8?B?MmVsS3U4UmhhSTRyTi92bG5vNHN3M1czS2xaZm1NQitoVDNDcGpJWW02emlr?=
 =?utf-8?B?blNyWFJ5OVdicWQ5UDlEMkFGL2ZBL3l3bjFsT2NwcE9NdlpmbGxuaCt1clpC?=
 =?utf-8?B?eHhmbWY2UzIvM0RiREZ2TnhPWVRvaDdWSm5kZTJCN0RXN1FKb1J0ZGRUUlJY?=
 =?utf-8?B?OEFqc0FLbVE5dW9kNVJGNXQweEp5VWN3WklVTzNuNzB3UDdJZk82WEcrb3kr?=
 =?utf-8?B?TmgzSSttTThDVEQ1THg5V3dGNktWc29qYWZFOEFLWElzK2M0MEJPL2ttaFlH?=
 =?utf-8?B?Sks2M29FSUcwaGhHQVc2cWFmaUJhMTlsOUZWaitmVnczQWUzSzMvTzJYV1Vm?=
 =?utf-8?B?aEhXWFo0YklpYm9EY1BWOEdUM1UzNDhZc0hjdndkUVU1V1l5UDF1OFZPSFJ4?=
 =?utf-8?B?VVdkcWZTZnNScnp0UVE0VklNS3pTT1YzclQ2UUlteGVIVGhUdjB1MDhMTU50?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: owjO4a8y3suQUb64tDEJV3DsQ+jc784aU+s1EetSH3GFJy4i9Ogzwoh37nHKjUkXrn2B+1jq8ex25C+420haeS/1Fttqqi8x2TYmEfbeJ7AxJ9N5F3upVWRQjr/SnZg4GsvXnYPI6jQ+R5748I5cSst6HnGbD+SvfUoxh6rU9tPlASf8us5dIe2aiYM7/W74JvCTJVzEaH+6NThpxYK0o8HteDDtAH6ElfuU1dkeo3ZoqPn1AWMwaPBTsCN++THJsrzLOg4YT1bWbjI8+cmMir6LabU54PHRcw5Omu6OHwwFE+SCf6xpyLqnMBvqU4OHeasAJyYay0VX+L+ka1W3y5GVVrhYedlFfGYuuCkdSfXDdt21YO24dVCa0AGoGL6WPlLSUehXhk8zwSJBSyaLHy7WwfOxN9H+TfnKf1sF0isWAkVswN7ebyE00EVmML0XkYwoBjl1G7KTxVrtY7oADyATT5H6wopMQ/gRJBhlJ+XbC9SpNM01VPuQA+gBdz3v3fbDzX/S7+0SmE9aiIse0ydAaac+yUtWH5P5H6Ud4QFc/xXw/eem5I8KDHeYRAbIHQV5KAsW+dPbmregc1s4j7fOQf0JPG1dA6d7+lNmqvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e74f9a-849e-45b2-dde5-08dd6d3e250f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 14:46:23.6480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I76fj9yCqSQrCqEl+eqsL+fRqBENe5SM6ggpgX0zblGJ0ekvK4wyGtn/m50ehNllEX8fRdJwh7bDlzoCgKAGBuwfkSEE2GFnCmuC2K+t3jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270100
X-Proofpoint-GUID: MVZVUrtyFEmSxV_oS8jgf4fmV7oaxLlv
X-Proofpoint-ORIG-GUID: MVZVUrtyFEmSxV_oS8jgf4fmV7oaxLlv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/27/2025 10:21 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> With aux-ram-share=off, booting an SNP guest fails with:
>>
>>    ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
>>
>> This is because a CPR blocker for the guest_memfd ramblock is added
>> twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
>> rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.
>>
>> To fix, add the guest_memfd blocker iff a generic one would not be
>> added by ram_block_add_cpr_blocker.
>>
>> Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
>> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Reported-by: Michael Roth <michael.roth@amd.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/physmem.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index e97de3e..cfafb06 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1908,13 +1908,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>               goto out_free;
>>           }
>>   
>> -        error_setg(&new_block->cpr_blocker,
>> -                   "Memory region %s uses guest_memfd, "
>> -                   "which is not supported with CPR.",
>> -                   memory_region_name(new_block->mr));
>> -        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
>> -                                  MIG_MODE_CPR_TRANSFER,
>> -                                  -1);
>> +        /*
>> +         * Add a specific guest_memfd blocker if a generic one would not be
>> +         * added by ram_block_add_cpr_blocker.
>> +         */
>> +        if (new_block->fd >= 0 && qemu_ram_is_shared(new_block)) {
> 
> Can we avoid having two instances of the same condition that will need
> to be kept in sync? What about:
> 
> /*
>   * Preserving guest_memfd may be sufficient for CPR, but it has not
>   * been tested yet.
>   */
> if (ram_is_cpr_compatible(new_block)) {
> ...
> 

Sure, that is better. I will send V2 shortly.

- Steve

>> +            error_setg(&new_block->cpr_blocker,
>> +                       "Memory region %s uses guest_memfd, "
>> +                       "which is not supported with CPR.",
>> +                       memory_region_name(new_block->mr));
>> +            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
>> +                                      MIG_MODE_CPR_TRANSFER, -1);
>> +        }
>>       }
>>   
>>       ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;


