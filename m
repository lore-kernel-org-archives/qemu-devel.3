Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3548CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lBA-0005wM-F4; Mon, 22 Sep 2025 14:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0lB8-0005w8-7g
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:22:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0lB5-0008UV-7p
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:22:21 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MHNDLk019021;
 Mon, 22 Sep 2025 18:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wrJnDnk1LI7UsbsOSjIv6vTfKX4IhyUGUQaqPGqlSqE=; b=
 UQf/6ouox4gmu8pav3UZEe7d7mc8RhPRy+IZy+t9AeQ7jdBOpHYA+LiJVqYJCkTv
 XOQg7V6bN9/AX3MrwcCB6bxLPBwO1cPD/QBCzpLni07vVkJxFfdSLW0bkILKbShP
 D/2CIHLrMIhzUdeHT15Ceryz7dN5R6UDQ1+/Jl/cRUz9zOsj8ksEY2WEAHUeqrqv
 YbyuRt6KGs6int01BumbO1dCx/Vu8LQhZQP6gpHa2b/emLo0CA3cKHC8lPNDWz7R
 /AURX+LsUHmCtOwyxtN6qXW0faUSumWOoyTAm8R7N+8acq3ED8VZhQvrs+rbOfPa
 1zCK6roxdlkgpCGH0dcRiw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvtu1rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 18:22:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MHKTqY030562; Mon, 22 Sep 2025 18:22:13 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a94xakdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 18:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOyeRxK7rCmoSdWSLYBINaLA14+uxjDig9XpCtcvEKuaOu2fPdonJOI93aZFOurrvoiPGf3nHVqG1X9KPpAyG+2vCu22yHBIpkbZkGrBS4dNcy1vKYlrKyS9Amw5r8c1Obm7VNSGHzcC2XCbm3tEahkQ6BFDIjWxkf+J613N7IBCQNeXh5OQ0U8PCNKP3XA7D7HhZy30+D44K194s1pXdgzaZ1qAaOEuEO/pxExgQjATdk2FFRgL3WcslUkA9bFU5EXVLJy2VrpKMJfe1iWsRk9ee3Nv8I0V/DNzTSP83UH3Xi2zwwjFunGtsTaF3mdGDMJU7PA3XCAHKLf4nl1nYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrJnDnk1LI7UsbsOSjIv6vTfKX4IhyUGUQaqPGqlSqE=;
 b=LVRh0LNOaaQLSTT69gnJY3scKbP8Tbhf66ld+ZjUu7vvSIF6O0pveCB4zQ7K8e7uOpDn7OVXyyX/q50sGklF9yX4tKS9ODjueZKH0Yrc/6MoEuNmRFjMKQtAyET5bNfWdMW37OwkjWo6zgAn7d3IQdhVCnqSgsbyGo5nc783kQM6WMQ8dN4Ei6C5zSo3pDFJpW+FMVOfz8+ReZDdgQpGrmYRApWMiEWb4GWDgkJIs9cvsj83bKt25sNyblhGAkRIMRdTU1wckWuufhigPO8XZ74kl8Exw2Tpg+9SjB3UYAIskVwTNkijbz3uHS+jJUGYLICtB47BtJmlwPrc3R39Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrJnDnk1LI7UsbsOSjIv6vTfKX4IhyUGUQaqPGqlSqE=;
 b=P7d+uUlCicizVrPs1ZMbQWXOiw/zZKbKzF6sR/aqxdEX/f6ku0nyxM9YBy0jK8du1DDHedOJkEi2nTFyT3Y9QrFeXrWx/92UUfRhXfDvClHfJ76KYBXyrK5XxmGO012AaXQH4o1nWPsIL7+iV+9rcqbElunN1qCY1XWe2sGBGSU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5690.namprd10.prod.outlook.com (2603:10b6:303:19b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 22 Sep
 2025 18:22:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 18:22:09 +0000
Message-ID: <9136ecc5-a6cb-4c16-a0a5-a9090790667f@oracle.com>
Date: Mon, 22 Sep 2025 14:22:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: optimize qtest_get_machines
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <1758290310-349623-1-git-send-email-steven.sistare@oracle.com>
 <87frchtx5j.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87frchtx5j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba29b45-4c0c-47b4-f598-08ddfa04f15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0wxWXJzelQydGgyWU40anRZNlppWTdSL0NBZk1jSEpKLzBtcUg0ZnJra0lJ?=
 =?utf-8?B?Y2ZxMVVzd2U2RmdpM3podmhZT1NCZ1lJQWZaTFZoenJyTXRodlN5eURLdnE3?=
 =?utf-8?B?SWRZSXhhZXYwTHcwc3ZmdktNYmZvNkdEb3VIRHRGUmRGRVdXQi9UZTNsQnc1?=
 =?utf-8?B?ejZyYkliNU5INWhWVldmT2ZONlk5ZmJ5VUVldnNoaWh2ZGdTMk5IZDlpRnRz?=
 =?utf-8?B?QzkzQlQzVUZOU1RLWGw2RUQzOGJHZmdmdVJ0WU9YbW5GR3pKemVuV2JNUGJo?=
 =?utf-8?B?Y0lvNVlUQktCMGhiS3RUbTNyN1E5SzdxODA2ajk4Tmh5WWd4M1U4V2ZpYlBM?=
 =?utf-8?B?S1REYW43SWIrMTVURnd4cWNyZXVibG51UHUzTk0vZ0NoWkFWR04rblVtYUd2?=
 =?utf-8?B?bWlENmNCWS9oUkJUVnQ2KzlaSnZEL3RSSllQOGJLYU5ERFlmVG1sek90bmdD?=
 =?utf-8?B?Z0JUKzIyMldiREl3RW51ZWh5SjNId084U3B6dUY0TTVGYmtmOHlpYmo4eDE4?=
 =?utf-8?B?REhCL3B1dGl3alJHTUp5aGlMcjd2eVAwbTJoR1Z5U0ZXWHNxcU1veVR3Ullz?=
 =?utf-8?B?Yk9mNnJveFlrNUhMcU9hSm5uMVZEenJ4RURDTWw0NlI4T3l5TkYzYU9FRjA1?=
 =?utf-8?B?QzljK0pZL254NmZ1OHJXZjMwWWRhUGNibHBIczFuK3ZwSWRiQWlNQno2V0hu?=
 =?utf-8?B?VmI0KytLZUlmWVN5VUIwRHhBL08wZXNERVB3Y0QrL3ovQ0ZQRUxZdDNXMUlW?=
 =?utf-8?B?bFFRWng2YndUOXpMOFdrRW5uYzBBTkVadFB4L1c3cG5jdXl2T0FHRUR2L0Za?=
 =?utf-8?B?VkVSS3B4MEdsc3VLVWJpTEdEUVpGbklYbXRPUEp2Yzdnbk84YXdNVEdJQVFl?=
 =?utf-8?B?cnNFQ05RRTd6NndiUnkvR2gvSnNtdXVtWTJXc3FJenFXOFBFVllhRi9mZzVp?=
 =?utf-8?B?Umd5c204SVNIYVVDcktEWDExbktDb2JqemEyVGpMUUg4c1RCYzdja1RUa1px?=
 =?utf-8?B?d3ppNVMyUU14bkRpYlBoN2VRams3SGUzdldhZEhMYVVrUTVwUEZuOXZiR3VY?=
 =?utf-8?B?cjdoSk1Yc3lhVlkwNXp6TlJPOEVQb0RxU2JGT3RhNHdna2dLZVZIY1ZmUnRH?=
 =?utf-8?B?amZSWVBXRFVXZ1FuSFExRSthVXlVNUhxbk9NSDViSloxd2Q5T0lSZVE3Z0Fr?=
 =?utf-8?B?QnRNdzdRTWJPdW5sUDljWGgwN25VYkdCNDVuTVhLZzRlWnlhbE5SVU92Qkt0?=
 =?utf-8?B?R0d5dXQ1enNCWVZXemNhdStHbVk5Ujc5QTV3cXhCYXJ2SDdjNkFOeVdOVVhi?=
 =?utf-8?B?YmNtc0pseHRpZ0dpZDRHR2VoMm9VaklySkI2Uy9vMDA1STVZUUh0eHcrdG11?=
 =?utf-8?B?dE1pcCtZL3hCL1RndkdiNjFMN2MySWJtS1o4d0JpODJkS2RSSjRKYitMM0Vk?=
 =?utf-8?B?S2p1QXBZelFXZkdOWlNRcFYvOERyUkt5NkJhWCtwaGttRlphQXZUdlRiQkQ1?=
 =?utf-8?B?bnQvRXBVWHNOUDRWaW5EUnU5bGp5MVJUMjFsd0w0Vy9GZkdrY1EwM2VwRzF6?=
 =?utf-8?B?NEd4VkhxZ0lXZjdwd25ybzdrc3A3bDVScFduU2NBYi9UWmk5Qm5oa3pCT09r?=
 =?utf-8?B?UkZ1TEtQVCtZZVlBL0FXTDBtcC9kYnBjY1oySjU0Z2gzUTZnL0czS0t6YlA1?=
 =?utf-8?B?Z1p4UlhIZkp1Q3VzSGhEZ3JTTENieGRyY3RnbXRhNjdWeU1Kd3VpU2VHQmE2?=
 =?utf-8?B?RG1Nb3grb3ZEVVNpQnI0YXBDMVFvek5UL283OE5ZeTNPUkMrRjVSbDFhTUJC?=
 =?utf-8?B?T21mK1RaRnBpWkVUdkNJWks0bmFka2FPK0h0Yk51L1AyOTNCS2k4aVZoZXZQ?=
 =?utf-8?B?bWVDMHFhYnlSd1NERTBEQmpkelNtYmlXdnFVWXFrMUxJRXhvVTg5MHJVVUda?=
 =?utf-8?Q?b3qYTUGVkTY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0p6MUtQM05BSlNxVzh4K3lHNkU5dXFnZnQycnAwSTludlJ3WnRsZFAzWjI0?=
 =?utf-8?B?L2YyU3ErM0swNE14Mkxqdk80a09rL0pqOHBsUU54dHJjbStQOVVkRzNVQ01V?=
 =?utf-8?B?WHJMTzUzQUN1MlkrL1JEWGxQWTlMK3U4Zzd5S05xYXRFWkFaWm9VT09hY3d0?=
 =?utf-8?B?RjNIdmQrUVd6SisrYjVhL3hkSkhpaldSUVlvZ3hhOS9tKzNxVHFvOXNPWnYx?=
 =?utf-8?B?RkNXUTVDb1V4b3c0RHdHT0gvNG9qdmI2bFFxYjNiMG15eWxLY1JJVmtQUnJt?=
 =?utf-8?B?K1ZKei9MZTg5QjNqbFBsSkpwYVMzTUh2cE1KbnQvMWloTGVsYTczK20zaUFa?=
 =?utf-8?B?L0toM1BYN1U5MGRxcEt1QjBCWktWeVdaYktzSjQ4K1hQNVJucFJ0eWw2ZUFp?=
 =?utf-8?B?Z25rZkdqQW1tTnRTZm5USHAzaXVSUXZoNTlXbmVhUE1NNUJ3WTV0SjJJYlZD?=
 =?utf-8?B?VTdsSVFveWRJMnllZmhXRkZ1VER6a0Z3ZHVrTG16Vm1tSjY0SWxVYm9LMTZz?=
 =?utf-8?B?MEZKRVhzNlgvRTVCbXA2VTllOGxiVW9lcTRSVE9KVGxlRks2NmVrZnpUVzlH?=
 =?utf-8?B?RHdqemZsancybVo5WnhCc2Z0QkVDZXkzSUpQK0FGVUNBR0JGOGh0Y3Rza3Uw?=
 =?utf-8?B?MmF4QWp2SDlZUkdaSVZkcEQ2T0lUNzJZN0lQUmRxUmhLVmFBQVd6UDRPdlhh?=
 =?utf-8?B?M3ZhQUY0UHJ4SGtnSXBPcGxvbm1wdWtjSElYUkVXN0w3WFdTTzQrWjZNQitH?=
 =?utf-8?B?N1VTelNDcWYzc3JnTHk3YzhDVEl3OGE1ZHlodjl3SC80K2JPOVp4TTRyekZa?=
 =?utf-8?B?UnY5TkNia3ZweS9xdit5N0g3c0dnVElPTWQ4ZmdUcE1KYkhpWW14RnpwZ0hQ?=
 =?utf-8?B?cmtLc0ZGV1lwMlBxUWlRQjNiaUtrWTFDQVNxeWFQejFITGkyM3luVU9zUWwx?=
 =?utf-8?B?QkdaLzF4U1Q4RmlYU1I5NnVJZ2lOc08rbGUrMUEzZGFkSzZoTU5Kd2ovY2Fm?=
 =?utf-8?B?T3VkblJlNUlZRkdsZzRXazY5VUFYVXZFd3k3b1JhRTgzL3BxRkx2aG5Edk9p?=
 =?utf-8?B?MElzNkdTaExzR21FMjdac1cyR1owSEdiaGkvb0xVZVVUZzdzaitXVHNBQjZK?=
 =?utf-8?B?bmJLYUFYYjB4MFVNV01NczkwOGs1bUt5SnVYajVYbW51SWlGMlhDQWY4bmFT?=
 =?utf-8?B?UkxDKy9jRHlaOGpiUXU4WFc2bU9VT3RNWEdpWUJXWVhSMUs5ZHREenV0M2p1?=
 =?utf-8?B?L0FZTUZCWXRyUUxycyswT2ZFWG1FblFHR1J5M1VoaEZLR21yZ1BWSUtQUWJ2?=
 =?utf-8?B?ZEdBbmE2Vk94TVFkTWYrbTJOd09WYmwzNnVXWEVMSThjZVhJeUpYanpwTmM3?=
 =?utf-8?B?eFNDVmE4UHZGWjltZWJMaWIxS3gwUDM5aWtKZStjOU9ZZ2l2RXlZYkZUeUlk?=
 =?utf-8?B?WEwraWVoRmVKY0pNYnA5VEtkVCszMWJCM3JQSVFjZjR4UWxhZzVKZjRjeXo3?=
 =?utf-8?B?aTlnRmNkamNBNEtiZHN3aHFkTWNrSWZYU3NRZ3ZCOEx1NG5rZVk2V0dUdlpP?=
 =?utf-8?B?TldmdWtLL3VpL1d4WE50QmR5NGxIUFEzb2plNTNSQmtqb0oxQWZmaWVmM1pw?=
 =?utf-8?B?WjVIN1hSZlIwMDZSTjNTVmlTLzBJOGg5dDBIN3FxZ3BDMERWVU9mcnZjM3JN?=
 =?utf-8?B?YXBWZ3pmZkNQTnNDMmsvay9JWFRSODNrMmJpUFQzSGF1VnNuL1p3UHFnV2VT?=
 =?utf-8?B?RHczS0tkWG1zTGJHYUgrYmVuVzdCb1J6eVFTL1p3UHQ2SENUL3dkbDlxa1px?=
 =?utf-8?B?dEF6MW8rL2hOZktEbXlVeDFod1AyNWphakR0TkRJWFozRmwyZkRJTjZXRlBo?=
 =?utf-8?B?SnFPNGlkKzZyd2xucmNCMG5OL2tRUmlhbncrWUl1WXJ3K09XVWRZajF1U3o5?=
 =?utf-8?B?OG1scC9ZWUdPYzgyOHZIUGtDeHZXdXBhWW5XTzkzcnByV0xtVDFrMUp1NFQ0?=
 =?utf-8?B?d0swRmRpMEhFZHo0aEN4MHZ5RVlrQVcvVndoT3hnTFp1SkRBQXRoaksrRmRT?=
 =?utf-8?B?NFk4aTNFRHRuZDZiWTVvYnN1SjBRcEhkYmE3RGlQMlRIVXFIbXlXWGdiUnZB?=
 =?utf-8?B?SDhxNHU2MjVnbHk3aEFlVjc4WTZUR1F1Vk52NVVhSjhLKzRya015akY0c0xC?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MhiJ4cIXEoVw+I1ihfaGh4GDMl6OWe9dy8gWBjwle5IfHC5FTtAA3ENIlafLcjkmuhgQV/EwTF8cuG7mXQhKdOzi9PMNJSc2emhRDTqeXg3lAEzkIBWYe7ZTFv4eOF1Naz0PCAQGOQZrsej3g50pANP9AzMiGBuhoM3WCPVFoEEpGhfFYnMvBAavQM4sSxtDRa1VhB68ndPSqpzdIY+GeT8fxyoPZ0E2sOiQ3lLtVY/Hgb6aYlFXY0H65uytJps7pdwAYJu/bSIzQ6jzIb4nXob7YPxBgEOcucc+ufqQn+SSdUpiUC/9HAJEmp7spsoB6UhtuVZ6YrkisuYg/zU+DiKN5uWt+52dGR8assUNQW+FqaZXxAra2j5dz5mULTGsmzcBg4qtNHEp4CyeKVEA3+P5NWZx7ONe3+d5woEY1X+94PtE5y29xW7LOPhuAay2FWI07ZCIAluFLjyuhBR7wYDi5ThRzucGZW10Ad079XPIADaVnEW44QKJ0Ud5CvIFACVTU5/qoOD7rcdrDrKf1rn+8XopVaCFxd0sqhbDLmP9p2XBBGjpWkCSMB4DGjm8oyT72YpmjIbKOhrTiiL14eluHRZcPttnKI+BT2/x2q0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba29b45-4c0c-47b4-f598-08ddfa04f15e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 18:22:09.6009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz+d0T3P9cXM6ngMvG/ALIUJBVYycFWXDCC2PTwXlHimnCYOlXWO+ZLIaQaMIB48m/Qgj0IMndAU1L+g9bt+HZGiQiiPEYXT02UyLy88l5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509220178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX/UMc1G/SKVhS
 MHhHlaoemoUXa5sBxgxtrrGyJlNryQLaDLJGB1RoSW08+1djSmqiNXftdBUrbkQIKx8m1nYhhp5
 bOkVYNNEFs2GC4PY/MJJcVKUJUg9Tq5ARu2FKOibq8FsR8rVPpuZqAvqq085aV9omkt7+ndArBd
 +Y3OXsDRwt4Hm5KU++PWU/hxAdf2ue0MN/w5o5FNBWaE/qJaEHDjcnmY+uDFXsD5eUoIZ3hiuYz
 BFM+Nu1N5iDhaxV6WTT7h+Ao5ySk7RzVEtaITwvyR95vRzPe1b4v5kj8DA4E1JzHqO8DdFPjCDB
 SeCRXHReYqYrZ0n0JZbTIs3BT4K7RXS3q/s/ex0V4l7HYSNZZmZ5dCUYrm+RQiWJYgItHXom4i1
 sSuEoJMpukCzcqWb8MBqjrz2tcKXKQ==
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d193d5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8
 a=yPCof4ZbAAAA:8 a=DyOEfawNwmn83JOOdMUA:9 a=QEXdDO2ut3YA:10
 a=KohFQSMcaiS2QNUyYz07:22 cc=ntf awl=host:12084
X-Proofpoint-GUID: -v-oQkGcUIVSAhVLoNTIxafEMjPG864-
X-Proofpoint-ORIG-GUID: -v-oQkGcUIVSAhVLoNTIxafEMjPG864-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/20/2025 3:12 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> qtest_get_machines returns the machines supported by the QEMU binary
>> described by an environment variable and caches the result.  If the
>> next call to qtest_get_machines passes the same variable name, the cached
>> result is returned, but if the name changes, the caching is defeated.
>> To make caching more effective, remember the path of the QEMU binary
>> instead.  Different env vars, eg QTEST_QEMU_BINARY_SRC and
>> QTEST_QEMU_BINARY_DST, usually resolve to the same path.
>>
>> Before the optimization, the test /x86_64/migration/precopy/unix/plain
>> exec's QEMU and calls query-machines 3 times.  After optimization, that
>> only happens once.  This does not significantly speed up the tests, but
>> it reduces QTEST_LOG output, and launches fewer QEMU instances, making
>> it easier to debug problems.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I guess this is a followup to an observation I made during review of my
> [PATCH 1/5] qtest/qom-test: Plug memory leak with -p:
> 
>      Message-ID: <87h5ymdzrf.fsf@pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87h5ymdzrf.fsf@pond.sub.org/
> 
> Appreciated!

In truth, this new patch is not intended to reduce leaks.  If it does,
that is a bonus :)

- Steve



