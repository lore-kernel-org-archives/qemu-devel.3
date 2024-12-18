Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C529E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO06m-0005j6-8g; Wed, 18 Dec 2024 14:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO06k-0005io-6v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO06h-0001ff-TN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:21 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIHQkub012898;
 Wed, 18 Dec 2024 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+nL+0HV79mytbqfLsvEOmM+vVGpHH6zb/yqluAamvHI=; b=
 CDSpGlfWkqxgmq3COj6EB1ru/zKjGv69iLcX//A6WdzJPeO4zcYUYd/Zpv5NL+Wy
 jtrUO+b5fScXFsHGf3k6IFyToWpPHWLpxxvttoGwSWlqt03AY1y1uklw1KOGxDT9
 v2vkiGvE0pX6GmHMlvW4QPlyg1GIvc1DDxpa4ZfGQ4WfgciDpopHyPVI0Gf1Lkqh
 5KeKOi0U4MN/nEL7dNY+4154B4WCN1yYJOMCuXo63AdRWiIC0oKmEUoPJjEgzxcP
 cDIZkpcXAqiR6UO9s0/v+IXvuoCiwaUo35+cda87TEAKD+Rx/BcrTTn3ye82Ip0I
 hNwde/3xh0oFFhl4rBi6PQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xb1jas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 19:53:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIJHuYo006389; Wed, 18 Dec 2024 19:53:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fb5tu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 19:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epn1TUdsIRYv8keQHyA/lfSdysowFVCPHSRAcZEAriWEj7m1EWpPnZMZ3DTeyYbaxkBJUSGmOx7haDNOOBVaoDt426zWQKOd5U6w6Z0kRqN5tG5IyJ5loDPkzU6ZPTRLJtv4QRXKmdNvzSXo9ykGmOdgKjbbFeVuCua1ASmr8hxXlycg6XhoHLWr1mfbgrkub3aXBeMvzioCKK0shOJAbaPsfH+jcjxKe+9MzE7+xnEYn+NMO855iTXEu12YPfXKjdse6NSi4h7J2Z6nyik4KmJCzZolM6l1VAU3sV6I+Ptw/mK9DGAIWPpu9PoWdgpZTbRzZJbw1tjOxekNspy/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nL+0HV79mytbqfLsvEOmM+vVGpHH6zb/yqluAamvHI=;
 b=SLBUZwP+EFmy0gc233d9aHDGdu4HT5qsh+oYoMa6sFoYa9hYAPfjUoqXl1dhTF5Uk1FlNpxfY06jBoHgpyU26vNJ70YescTh6srJR8z2/W5efFMhb8owj04aVXFyzN26rcp7s3EYutcs0tAjyrht2sa25bIpBpGKP/eiJEcULy8x4XibF26WkKNlxsd1B6RA701YSpEB1+xSwnYErHxxXWH0OdZjUY0f4tPnEpMeYuTM2CbwfE5OAEfcN4+dZbOM6zO3FE8NlVdeH8ElgiP4dCe++woJPYnLbXxiTb/2WauRZJK4pg20ryq/1X9s42I129JJBSTV4TqA21qRomg3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nL+0HV79mytbqfLsvEOmM+vVGpHH6zb/yqluAamvHI=;
 b=nSLU8NmuvTWQW+oUDB39+puHVwNJLA5MQkVaLhZV9aPmxNLgTxUInt6WQJ7PFFCOsWXoOnCDnYtFwo5LWm5OH74LPjLnEj3H3qLf+mIjrvjP2FfSE4Qb85l6D6CcEW01hcZnWPRgR32LG7tLC+POQ/N+jH3bGtPZeRSZm81W8pA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7203.namprd10.prod.outlook.com (2603:10b6:8:f5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 19:53:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 19:53:10 +0000
Message-ID: <4ac5545c-cbf9-4bfc-8300-826d90e88496@oracle.com>
Date: Wed, 18 Dec 2024 14:53:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 07/19] hostmem-memfd: preserve for cpr
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-8-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1733145611-62315-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a9623b-14f9-4b73-8463-08dd1f9d9953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um9GSEJmV1M2ZTZpb21ONVowREF4ZzVKaUtOU3JRMGV3eXN0U3U5U3A5bC9D?=
 =?utf-8?B?ZitTekNTMHRtd0NJMU9IeEMySk4yc3NmaTdTTHBIZVdsVk15Q2RwQmVQbVdY?=
 =?utf-8?B?RTlCNEF1SVAxVzFDTU9wMGpzT2hxd1ZPTmN1VlJGK2xEUk1UVHhkQ0t0eHVs?=
 =?utf-8?B?dkwxYTRIN1owd3dQMnAwUUd1WWVQRFVTT29ud2tuUVBPR0FWZGVFb2xxdFBu?=
 =?utf-8?B?YXNuR05vRG5xeEtLYjZ0MGthSmdHekt4b0w3bVZxak41T3hYdndUOEFiMjRa?=
 =?utf-8?B?UWRLYWRYSnRoNEVYbWhJVE1oQXRNVUtSV0hOWGRpVWdiN21UcDlmSy90c1Nr?=
 =?utf-8?B?emlVT1BVNXRPSTNtbldlWEsrTWtDT0ljUWNTQWJ5Ty96bTVWVE80L0lwVDZj?=
 =?utf-8?B?ODI4a2hrR29HQzdNdnl2NVFkbjlkNU9sMHNmOGtZWkl6TDFyZit4dHpSTnh1?=
 =?utf-8?B?bmpoT09JLzVyM2lvVm5nM2MxS2J1ZmI1d3FoNElNZ01WWE9yeTVpallsVElG?=
 =?utf-8?B?ako1VVBRcDVGRERlcmFXVzN6NnNoQXFoWnFycjI0akVqOU5ZOGNSTzkyT3ZY?=
 =?utf-8?B?dEhCSEdlUzhFWThsZzdmVmMwQmFkWFJ0bUJyUVNIdEFjanpqa3Z6ZGVETDF3?=
 =?utf-8?B?WVhyT3hVZFZkbm5iVEJQSmY5Vzhmb2dWcWwvdjBuaDRmdWZkMHpBRzVnVFJN?=
 =?utf-8?B?VytId0ZUUWtIdHQ3Tk9QTW9KbWZ0R1J2aGZBVUtpbU1SMDY4SGpsTXNrbWdi?=
 =?utf-8?B?WEFNbi90M01xbmJQeWhySlVsTlRkbWNIMjFwL0gzQTdUL2VsdU1RUVdWeDB1?=
 =?utf-8?B?OWtCc0xqbVRuTUFRZzJ2bmt5ZjJ5RmhkcUdqNmhoTDVxU3YxVDBQT0h3eEVy?=
 =?utf-8?B?QVVldG00aFl5cmtoN09GYTU5WjhxNVAxSloyK0VjMDhaRlFabEpuSjJiZWJw?=
 =?utf-8?B?ZExWSTJTWGNxN2dhK1BGeTFGTE9EZFhFYXI3TlI0eTZ1cSs3b1lmb01UVVlO?=
 =?utf-8?B?MVJMdXV5L2RSRnhDSU1tYkV1bjl2QWhELzV0RW44R0lKRjFhSjFOUFhBY2ZO?=
 =?utf-8?B?QSszclpsS1R1N0ZqRnVLT0ptM010aUVEdHVzSGljTFRCVllMU3lpSFFVWEM1?=
 =?utf-8?B?RnUvck1SNlE2V1MvazVtTWRpV0xJS2NHbkVOK3VXZUZ3KzBuYjVxb3ZQamc1?=
 =?utf-8?B?dFZOdlVmN0tnQkJ2WGlEb3docVlQZURlN3J4RzJCUmFiSlFvZndhZ1ZwcSt6?=
 =?utf-8?B?KzUrLzhZTUEzaG1BSVdZMXoyU1pnTkN1NUpVK01yOUpET09VTFBTYzFOeVhJ?=
 =?utf-8?B?TUpRM0dDZzVlMmxXeEszSDZFSndLSHNVQ2hlVFZkeEl2WVQ3SWkwY1Bjc3hk?=
 =?utf-8?B?S1NRZTJhK3RydHdtRnhGZ2NYOS9BL0d0bU1rQy9xQW85aFM1VFovZ3ozRmE5?=
 =?utf-8?B?YXY4Q1pTRmhTSlVJOUFWTEI3eENTajA1bVQrbTNaaFI1OGxzS0lqZkJzdWRT?=
 =?utf-8?B?VUdXMjRGaVB0Z1g1M0RFTy84VU5wZERVQWRSZXFNZmJySzFiaHFsemxhNlZp?=
 =?utf-8?B?bE9LNXUwR1ZTZW50cmFTTXlkeTBlMzh2cmJkVjdDbGpteVdQRWFEdU9xZmIx?=
 =?utf-8?B?MGxyQXc2TVA0a2l3c1Q1WXRLTko4eFg4c2pmZ1I5ME5GSjZCUzhFV3FxcjVU?=
 =?utf-8?B?NDRTY2x3a0pMQjUybW1scUxxZkxTSWdSNTJzUnNDRHdlYkcwcTg3cFVicXFX?=
 =?utf-8?B?cUZHd0svSkErc3dOSFRySzBtcEx6VFZJUHBPUFBOSXE0WjBlNXZwak9YZ1I4?=
 =?utf-8?B?SzdoSzlmaXJ4b1pzNlVweHRtVURPYUhIOFU4eGhUSk5ockpQeEFpNDdnckx4?=
 =?utf-8?Q?du8eINtCarDFD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZ5cFFtSWlScjE5VzlHOFNWZitTVHRkaTNOa3R5RlZtRHRvTG9BdWdOWWR2?=
 =?utf-8?B?Qk9IWEp0Vm4xRm5QaGo3T2VDc2RGREJ3cjFTTmV5bTRmeVlNcVJxUC93bSs4?=
 =?utf-8?B?NmZ1cW5CU0dQYndJRE5OMGNWOUYzc1ZLZURhb2tGd3RXQ1RmNVYyOEhyY1lL?=
 =?utf-8?B?elZvbEFudjVMM0dEZmRvRlY5R1pvVUV4S1R3ODhDci9oTW5NWk5LV0NsbWFa?=
 =?utf-8?B?a1o0eXdzeUNWUXoxWjgzYzJVRFIxSmM2cnJGNDgwcW9sS0xCUlhUV0xBYWQz?=
 =?utf-8?B?T2UyRDFjbFJNbnhtY0J0Rktmdk5wQlJlZW9MOE8wQVJUQkk0Q1FnSWJhVTJt?=
 =?utf-8?B?NklDdVZPNy8xbnJNOE9WSXdUeU9DWVdMNFNMQkpGWW9ONEs1YUs2RzBtSUpF?=
 =?utf-8?B?dmRSMzJsVkVUcjdtazFhZFkxek4vSXVlUDNrQVRSR0Y0MFdSWlBlN1BQbmlI?=
 =?utf-8?B?bmJMZUVRNkRjbXNacG1nLzU2K0FuSmpMRUZzOUVWUWQ0eGIycFZjeWdCTDBw?=
 =?utf-8?B?SzA1MEFyUjZkWkhTUW9PVXA5MzM4SWYyUHMyREZLY1NmM0ZjYnhlVm91Mmtu?=
 =?utf-8?B?T2c5dllnZFJUT1JmQ2F1NTE3Um52WUJFMys3c0F4NFU5N0pHK2RjRDVKR3hl?=
 =?utf-8?B?MzZHN2YrY1hWMWRsaHNlRHpubFVQVENFR0Fad00yU2NIODZXNW5GcXVVQ2ZP?=
 =?utf-8?B?dWRRNU02dFVHMjZpZ0ZteGpzSTV1YXUybkhBTE5mak43UHY0OVRidU5uOWVk?=
 =?utf-8?B?eHZkRFcvYWRzVFJPbkZ0eXM2OFg0Zm5CbHc3ZUZGSzJWeWtQK1BqUUY4N2xt?=
 =?utf-8?B?Ym5tdmhtOG1pRVpnaHN3ZzlKR1QxYlovRmRZbjgvbUtLWUdKOWtaNTkrWUxt?=
 =?utf-8?B?SVFOVU5mSlFvRTNTVUg3akRmY1M1VUR0NFlHZEVYa1ZwUWN2YkxXVElUV1lz?=
 =?utf-8?B?S0czQ2RoSktzQm9XY3NNcUZYdHFqVWtqYzZueVorKy9zMmFZL2pkMEh5SFpH?=
 =?utf-8?B?VEZ5V1RCS1ErblQ4V2RFNkZ2Y1JEWWd4SVNHenBQYWhBZStkajZWZnQzanpJ?=
 =?utf-8?B?WFUzbk95LzVxQ2VWK1BDQ1daYXJqSVRpeU1OeTE3Q2FLVXc2dWM1UjBQYk5l?=
 =?utf-8?B?Nnh3YS9McGNVaUJDVGVXWmNUZm9PNGk0ckF3TTJaL0I4aEZtb1RmN3NUTVF0?=
 =?utf-8?B?dGZEK05WN003bCtTZVh2OUV4TUlZc1Nic1BMTUVTKzlkdmVOQkVEM2xpNUFq?=
 =?utf-8?B?RWhjRUJzZUc2V1hvYXBsQnptMVhUc0RYNXJUVzBKSk9xOGVKNjl2ZVhDWUpt?=
 =?utf-8?B?c0VDeVZrck9QRWJ2MWMwdlh6cXp6L0cwanhUNmw0UVB3WEhKVzl4TXhJTXpr?=
 =?utf-8?B?L2FNWGtLVmU4MUJ4cE1GamJJYXZ4TUVEbDZzMUh5RTJoRFFqV25ESVJwZTJZ?=
 =?utf-8?B?TENwREhPU00zZ0l0WVEwUHNhYTRtZHJ3cVhybGhvRFhHN0hESjRQRi9HanZJ?=
 =?utf-8?B?NnhocTNBL0ZrczVrSFhYbUNwVkFKaHo4bTFRQ3AreFlhMDBoMFN3RENLK2ZJ?=
 =?utf-8?B?cHdoa2pzZ2tUV0M2ZmlLUWxBemk1YWdveUliaUNoQ0E4RjA2OHhJUlZkQUIx?=
 =?utf-8?B?elFmUE84RmtHUzFUUDdpYVhJVlRNcVZRQzhBZGcwLzJ2QlpaM0hYcnN1RW1R?=
 =?utf-8?B?M2RvSGZ2NFdmeTJtMUJ3NTczRGVFRXpteklOU2hiL0FIaTJ3NU9FTXdOay93?=
 =?utf-8?B?T1kxaEVxV1RlcUFGSGMvQmoya29uSk50OG9zbW1DYnRWS2I1aXBmYzZiekIw?=
 =?utf-8?B?VUVRMGJKZlpVT2U5U0d1eExFUlBGL1Y0R1RLRjdJbHViZE02cFRiaTBRVnA4?=
 =?utf-8?B?QUtzV0FLWHRGUENUcVE3RnB4SDQ4eEtkNm5McEg5cXoyNFFJUmVhT05aRXNI?=
 =?utf-8?B?Q3NYNWQ1MGZINW5zTitjRXcvRXg4SitMdlJUb21ZaFAycmREeFpadk5LMU1l?=
 =?utf-8?B?OVBTcTYzN1UxM2c2dkp3TDNGTmtWTXVLZUhDMDZYUFVlbm5BdGpmdGRLNFhL?=
 =?utf-8?B?bE1pSloySDhoakI4Z3l0eXNQZEVQQW9uT3JtVmVacERDeEFLVTdURFpvTGNV?=
 =?utf-8?B?STMrV3A5czQ2SHNoa3YzK2Q0bEZtb2VEZlEzT2tHZHpsSS9zVmQ1UHNia3RN?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wBW6pXq5Udeot7nDKWrFaTBOJMqHhNEMmBFNWpr/NwWRJQHN7Q7954wzfcQw9gWCb6BNJki42BFr4iM0sg2nffCrcBQ6jhS55Zn8l0p3KBG7zSFGehfwn8k/gTLHOKS2obsAe9lWQxHcUckK463ORkRgn2eOU/uorO8JIlbxGOLcPj2hnyCtkOwMze05rvZpf9juqgsLWIH8vSK2noAAzuiWSqxcUdisYb5yQcR12EIh1fTNXFZQskzmXGP11iHEbGqiFGoBsAhCttznVQfwyAUplrcbLn0DxRwlwmDKiLxRJDjIlCAh1E37xeqpfTVxvq5iMCnphpyRBmdFhIiwvzAbxqKTEGH7kRdiG26596j93k82ah8vQamuaEVrngS4ZBbcvKm4C4OcELUvmsbnT79aSyQcB6cgxI8AwWEy/4OR69fNM/BxuDyoROoT0b7PYtmGfuxuVEqD61VLa6pcHcBspdr9pNP5dsR3lqEMZDooazBxE5J6iA5p9L3SeJDANl8Yjettek87byQjoCTi8ZJ7Ads2UYf3C5XCpFEfL5wPzfYvh//WpHf+sR1lO4CMN6HZouVRTtBMG7ZaM/rLLBrWhthuk47TBVQnVDDuUYs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9623b-14f9-4b73-8463-08dd1f9d9953
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 19:53:10.1436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgpHfuB6lRHhkkGQdXecyOGZG81mbdXy3JTmgh3qRKi8SCfc9xd5yr/ioXQATpIr0K/QTV+cbtMDibPdOE3CMdogIpPwaXT9WEi6mDd2aJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_06,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180154
X-Proofpoint-GUID: sjdNiRwHUfa0hr8oSP8De6CONAiP3tPT
X-Proofpoint-ORIG-GUID: sjdNiRwHUfa0hr8oSP8De6CONAiP3tPT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.116,
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

Hi Peter, can we upgrade your Acked-by to an RB?  You gave RB to the
similar patch "hostmem-shm: preserve for cpr"

- Steve

On 12/2/2024 8:19 AM, Steve Sistare wrote:
> Preserve memory-backend-memfd memory objects during cpr-transfer.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>   backends/hostmem-memfd.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 1bcae4b..497d63b 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -17,6 +17,7 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qom/object.h"
> +#include "migration/cpr.h"
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
>   
> @@ -33,15 +34,19 @@ static bool
>   memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>   {
>       HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
> -    g_autofree char *name = NULL;
> +    g_autofree char *name = host_memory_backend_get_name(backend);
> +    int fd = cpr_find_fd(name, 0);
>       uint32_t ram_flags;
> -    int fd;
>   
>       if (!backend->size) {
>           error_setg(errp, "can't create backend with size 0");
>           return false;
>       }
>   
> +    if (fd >= 0) {
> +        goto have_fd;
> +    }
> +
>       fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>                              m->hugetlb, m->hugetlbsize, m->seal ?
>                              F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> @@ -49,9 +54,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       if (fd == -1) {
>           return false;
>       }
> +    cpr_save_fd(name, 0, fd);
>   
> +have_fd:
>       backend->aligned = true;
> -    name = host_memory_backend_get_name(backend);
>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>       ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;


