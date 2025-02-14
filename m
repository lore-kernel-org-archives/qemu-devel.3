Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77E9C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj23F-0007Hw-6k; Fri, 14 Feb 2025 15:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj23C-0007Hc-EN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:12:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj239-0008DS-EB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:12:38 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBWNc017960;
 Fri, 14 Feb 2025 20:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=5xlAZvN8KVxuKjgcNEkcCSKOboQZ5vcutVlNPCiHrjw=; b=
 G+rG1u8KQcK6hMFwdn62SrcEcIOCbIMDVzmardHzRifPhnfXHKQ0u8LU/YYJFTz7
 E6A2/dTwI8xfcLLrcvf4Srle7BWmgyc5/hb2rIPyKLclomJAAJORtvXu/Gf+1OT1
 uLt4BgbXp1rXrAQSnw0J+92gBB6HBU9gojhYz1Hj5K5xpWwD+whnB01huODMySxF
 DIaplkB77c6NqBYabG4HNPc0OrJIM989jfFtfVQj5vP6Fu6EGk1rs/85BJIsFFB+
 kgf/NQwnf2dPTm54Knbeh5NUW2T7z2aAJTF361Ff+xqiYnbyQQ0jhRMyZ1KVAAc7
 z8PjCx499bu5z5aB9Zcy0A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s44dts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:12:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EJQTJW014153; Fri, 14 Feb 2025 20:12:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqm6nhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv236LdHZ8k9dbl86rAd04IVRAl95ItlL5QpNBceA3BBoVr9wcvR9VLoIwts3crmuAuc4j31QCwafeiqscH4PTORTNfebcnReocRTVp1WTTCcd+GNur3PBCDsaUUnIf0sEdEJUWQgfsmt/tDMuQ6jwJzASx8DXNtpjmv/OGE2dGCnIHzgaZ2BtvWjcnJjAT0CzLN+C1suJ7UjkE+YNpBXspH5txasCQIVO3eQamJKBha1ZqbxzD2K4EtCEM2vb08DVXEJo13Pn5SuwjnFSBjohG5vKrnVTnzg+BkMqbcw7SGyqskkeG2x/dipyTxz/eVtRnsz6aYXo2V5rsGwTakRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xlAZvN8KVxuKjgcNEkcCSKOboQZ5vcutVlNPCiHrjw=;
 b=o7zv22nM0H040N8fFW48FpTtvqSU6uoceTk7gAQbtTcqPM8g/I72uJAUdogJBB+qO9wop8UibjHAPHQz6GbsPPaTA8r2g+N0raRffc3N5QYZUZwz1DI7V02V8vC/YyIYZw60pb+kd+8e7qOlUmWIpV8HC+FhmMrmbPO8hAs/4LFVpIVJlQwYdwcV7gzcg0TI0+T8n/xQBLd6ZMQpz+XTvXYDOOtHtp2fhCzREhcSWLQHBugbYUigqYgDVdyXQZ6DTWq5ik3GrFLeiLXE/qNn+OzvGD0ujAANripik3KQxtTUYUK/GM3UzWVTzpQ7+Yh8D3EWBqpm/nLbPwlj/+40ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xlAZvN8KVxuKjgcNEkcCSKOboQZ5vcutVlNPCiHrjw=;
 b=MTEVN3vEnoGzOf4pDmXhCC8DIsseq8ZEx6OZnXruw5Bs1Qg85VGEJzGCODfPqv+RPL2u0nnLYxsvAF0eqqbnt3cyeu/MnuiF4vK2076n4bab6+jJW/SX0BUeTKxKHoNohmf30URSi6a4g7IXKjiFXrfMCAvuorbvyf8aZe+MBhU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4894.namprd10.prod.outlook.com (2603:10b6:5:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 20:12:27 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 20:12:27 +0000
Message-ID: <f1f1c640-367d-4966-93f5-a98e3b764e28@oracle.com>
Date: Fri, 14 Feb 2025 15:12:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: ram block cpr blockers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n> <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
 <Z4ruhpH28-GnnTq7@x1n> <20674b54-3c88-4d2c-a590-3b0ddaff86f9@oracle.com>
 <Z5uwUNtYhQfJJlg3@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z5uwUNtYhQfJJlg3@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: 86401aec-1b6c-4b03-7881-08dd4d33e70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDJnWDNBZlYxS2Z2ZUpZYjFNdGNjOHFoTFBXQ0tIM2dYVnJDemNrZXNHNWsv?=
 =?utf-8?B?aXZPTXNSNXVNdFI0cXlCbXhRVkNmdnVMNjZrMjYvWVpDUTNaTlZhQ1VoM3pG?=
 =?utf-8?B?QWJXOHNGU1daakswM0tLa0VGVzNaMVhYQ3FGRFd0RUtLNWRDZHpMYmV5ZTY2?=
 =?utf-8?B?a1FTMTA2U2F4Z1VjaUdnc1dWWWJ2NUJOVCtaVS9WWXlMeVg4Q0lvYVlHZ3BG?=
 =?utf-8?B?bGZWRlNiOUxmK0NOSzU3M1VSS3hzRUNEZWwydFg3VDhkRmJjbit6V3B0L280?=
 =?utf-8?B?MTY1ZGpuWkpHdGhXZGNFc3BZVFdIY0krYUdCc3BmcUFtb3kveXMvQ0xNcDE5?=
 =?utf-8?B?ZU5QUytwNTllUWJFa2lZWHpzeDdjZEFRbmx5cG1UQkZDaUpESzlYdDNEUDRt?=
 =?utf-8?B?YjhFdlQ2ZG5IU04yMXJkdVQvWTBqTnNRNUY5QVEzNnBCcmErOFVtNndmeDll?=
 =?utf-8?B?SkxDTFh1aDVwNzVJcmlNcWxLZ3Urd3VWRGxGL3BCeUY5Tmk0SWVub1Y0UTly?=
 =?utf-8?B?MmlPTDhTMUNpbjFFQXI4VWhvYjNvQU1lMG16UkttVitqRXJVeEtyVUxFdklr?=
 =?utf-8?B?OVdDOS8zSW5hV3lXZjdKaGdwSGtXeCs2UmZwcER3VWpTZEdtQmt3RW94OVEy?=
 =?utf-8?B?amdDamRFNEZ3SnE4RXpzc1o5OGxEL2Vvbm84QjU2OWhONTU4dnRERFFFTG1t?=
 =?utf-8?B?NUE5eFM5Zlhobm45bTlTWnpNU0ZBRnBTRDdEeGhGZWZPaFRWM2w4MUZMYlRP?=
 =?utf-8?B?NEN1K2dYencyUDNMSWRlNnBYdCtCZENVdTRyejJ4Y0xMeE1BQ29WR3NFR0oz?=
 =?utf-8?B?SGFlVEp6bFB4QkNtYzlRVmR4d3BWdE9WUnhVSXZqeXpmODFVOUhUVjZ0WUtz?=
 =?utf-8?B?bytHN1QzR3VLVWpqaVh0QlIyNDZCNTIvV1NJR2g4TzdrRERZTVptYjdvV2ZY?=
 =?utf-8?B?YUEzbFVMaHRSTGIxWWtaaU1oNy9FS2l3Zmord0U3R1NsL3FrcXhESThTdkZ4?=
 =?utf-8?B?QW5CMGFTUUNtY2JaWkowdzNqY0lUMVN6VGlkczE1QUxUWGl0UmRXczNzdmgr?=
 =?utf-8?B?b0RyNlhCZjdqczB6dE5TelVrRzRCRGN6NGF0ZXB1VnNsaE1tTnVlaUEzSWZF?=
 =?utf-8?B?MEt3RWpTdWJXNkRZRlZ5OVRkcWNLYkdhTHkzYUVHNlZ4dnRRbGRZTjUyMkF6?=
 =?utf-8?B?ZFlzcmVSN3drQXdFT2lOSTJqa01HREErRU92RWFONS9tVmxJUWlrQUowV25Y?=
 =?utf-8?B?ZERwdk1kbjJ0ZVdlc3JRcXBIVzhzamI0aUUvZkRwNGtsYkxadDdhSVkranBx?=
 =?utf-8?B?NGNCM3g1NVBhQzBaeUs3bnh6QUVER2FPOUhyQmlQRkdydzl6TUtpUmJ5ZlpQ?=
 =?utf-8?B?alFNa0g2bUVnTHJFaERtT3pZZERQVUtoNXdFUXNDSDVNcFFBc1NXVkZqdzd6?=
 =?utf-8?B?TyszMFJGQzdJKzMybXlET0lsRUJZN0NDb0JqL3AwMStoSDJLR2FQemN6a2lO?=
 =?utf-8?B?UEI3YktZRmtMYzd3ZGxFSURMWnMxQUU0VUNOeFNaekhleUhmMmpFWlJTSmZY?=
 =?utf-8?B?T0ZzRDhrSzJZcktRcUpneng3aGE3ME5yL1VrWEo2TmdBV2pDZy92RmEraGhR?=
 =?utf-8?B?dnhPTHp1Q1FYZklUUTUrNVJPN0Z2elFSd21HZnQ1aFJ5Rmp4WDkySHdMR21J?=
 =?utf-8?B?bFZuamVyamNLWmNPdzBlQ3JLbDZGYTRrbUkxUWM5N1lGa0ZId0JJelZyUkpq?=
 =?utf-8?B?czBpSmFNQ1M1SEJGY0dUM1RWdm9mRURIbHJKNGh3b2laL3BRNmI0ejl1eFo4?=
 =?utf-8?B?bGZwTStubWI1dTUvWHJKQmc5VC81dzQrTmtxQnByZVVGSFVhd3p6eVlBc1Vv?=
 =?utf-8?Q?AcjIV5+DU+Lhm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRJbTkvYTZZY2lPL2J6dGRYOGp3VEdKOHFGeVZlRzZNaGxoREpEaVVGM0FD?=
 =?utf-8?B?V0ZxckFwajZIVmZubFM1MVhZZ0huWHI5SEVvUVlDSGhVNE0yUy9SbUxWT3Ez?=
 =?utf-8?B?OHB0ZE1aMG84TWJQcDhyMVloZ3FKZUpTeGoydjVRU2pLWWhZczdrMjYyOEha?=
 =?utf-8?B?cmZaRFI5QWtjOFFJRXA2R1BmcHlUQ01FM1RJb0tCbDlEUVQ4S29lVzJWQzRk?=
 =?utf-8?B?UHpkWmlUcERPalllRmgza2hnWFROazljZGFEbk9LKzltQUQrQ0M3bGtERmVL?=
 =?utf-8?B?S1BQVEdEUjJKZ2pVWENrUVNOMlNlY0xRTmVTSll2VklTd1pSUzl5TkhQTml5?=
 =?utf-8?B?dHkyUHhTSy9RdUljUVZsSWQydVlOcGhaSXJNd2Y2SDVUaW1aOHdWVG9Idmhu?=
 =?utf-8?B?Q3lKSFdwNE5UMUtjN3gzVml3Y2dkekFsY2pBRGtRVlAvc09zK0VySCtJVHVh?=
 =?utf-8?B?MUtqOVNhMUhmTjhsZ2RKOGhET1h3YUtXT2ZkeVZiMXBRaktxbFkyb0hBeEFn?=
 =?utf-8?B?K09Oay9NQmxJcDhCcXNHM2JrcTgxS3hXYzJWeHd5S3FGOFlwMmdCUWJWRyty?=
 =?utf-8?B?ZW9OMzNXTmpDM1k0aDVIblZObkNTUmVUU3ZtUENYUDJOYk40RGVLR0loL2dU?=
 =?utf-8?B?NkE3QitFeUNvVHN0RFJseHduWGppL2xaVHU5NnQzOWhBVXFuWkJkU1MzYk9D?=
 =?utf-8?B?WUpRcGc3RDBiVE9QWmY5NGxhZmE2T2x2MW5ocGpvbmlxK0VONWFzR0JDMlFJ?=
 =?utf-8?B?ZmhBOHkvZFJjdDFDaU52THR5WmJlVGttRWd4aC9LMnFsTzZlbzlrSERtdkUz?=
 =?utf-8?B?OERlTXB6Ky9XUlAvQWlqL2xYQUZiYm84ZDllalJKcVE4bjVYN1lzR1dDZ0I0?=
 =?utf-8?B?YTJWRm51QVgxMDd2bTVabUlveFk1YXUyMmNRM0t2dmZsRkNSdWJEVktoQXl6?=
 =?utf-8?B?K1ZNT0FubUs4eGY4NG4rc1kwZEVJL1VScEwrR1R3VmdJRkllMjMrdkErSFcy?=
 =?utf-8?B?YlZmWUpaT2RaZTFENEVyNWFlSzRaYm9HandBRzJYY25jR0N2ZzVKb2VBRXRU?=
 =?utf-8?B?amNJbVIrK3FYaDJVZUt0MUV5T2xMMzVLQ2d1cHlGaUJsUFo0ZDBoQnNrczl0?=
 =?utf-8?B?SDRHcnplUDAwYUJBMDhOblVacW9vQmhJTEI5NU51cmNEQ0lFbm1rdXYvckpv?=
 =?utf-8?B?dGZxY2xGalNybWFoYklTOFpUZWVZeXo5blJKZGcvSUZwd2p0czhDbjNmSWk0?=
 =?utf-8?B?Y1FMc3ZkMVhaSno0dUZvZTV2V1g3ZnlRSlJjQ2Z4aFA1MW4rNzJoNUU1Y2hU?=
 =?utf-8?B?Y29KY1dlUlIxRzJFQmduVnhJZ3pNMXgxNEkrWHpDa2VsZ2ZBRlNBcXJtL215?=
 =?utf-8?B?dkpnWEpXT2NOdGZNVGlETjYrdnc1ZSs0bFgwUkFVSjRDdElYY3JocDA2UUly?=
 =?utf-8?B?c1o4ZkxjU1BqTW1pRDBJT2xmMCs5VWxORE5CcWd0L1MrTWR3MmVMUnZNWGlI?=
 =?utf-8?B?bDNHSm5MMG9zbENueGdYVUh5cDhheFM0bkN1bUVpS01KcGFrRGxZNDMzK2ZP?=
 =?utf-8?B?bVNKUnlmVC9wbkNkajZ2dWk5TktOZ1lwcFBDNEtKcUFscHA1OXNwQy9Nb3lC?=
 =?utf-8?B?NjRzaGoranoydCs5Szg5UE81Mm9qMXZnZEZaOVlXenZPU1VYaG0rbjRtNGkw?=
 =?utf-8?B?ZUdUSFpJQ2ptY1lNV1ErdVA1TVB2VHpFamordWpGZVdVTUUySzlwdy82WG9X?=
 =?utf-8?B?KzBrQ0ljVjBlZzQrdU5aSTdGeTBNMXVYRnBHcTBEMEIxVGJvUS8zUmE4bEw4?=
 =?utf-8?B?RHcyazVPT2pLcEFncVljc0k5eHFMNy9WbDhDb0lRcFZ5TVc4d0tLenArNGlJ?=
 =?utf-8?B?aDZwYzhKTlUzSnE4T2VWWjJWb3BRVmNwMHpRSlhJdEt0ZDJFb0FObGxLcGdS?=
 =?utf-8?B?TldSTW1TZjlsT0VjWG9uc3crTkdHbmtpdmh3ZENNTUhtV2s2clJjdVQybmdI?=
 =?utf-8?B?azVkbElyUk9McENSMkRDa2plOTg1TUd3Q1J2ZUhqdkZjN0ZYQUhpaFoyT1lm?=
 =?utf-8?B?NG04SFJZVTFLWmxpcEVDVUxDa2lQRjhrQkluZHVFRDJwS3BXelNaMXllL2RT?=
 =?utf-8?B?RUg2MWg4aEJ2SCt6aldkNzhiOVpJaTlNWSthT0FHZDdCVk8zMDFsUFJ2UmNr?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lTfVjEviFTTcrYG2CwAVGkor+434YA53CCbRlIzytcuCVYXCa7TH76HKyLlEDGSWSckMycaBubDTA6yZNgQepc/l8rCNJqEFhlslCNKA/DD7dZYVYXH1Nc/jKSzwdRr7U5AXY2muXeVtx/g0LNQN51gAhyLTq1NcSLZvep8l9u7G8m0qDO2U0240QvXiqhj0d3gCRLsE1pFoAjaEkDK+mT61yi2Qkk8j7Unzoh7mTwXLhIOuCFatkxyStJqqhKDemd8dmfiFqeBvzZKhgxp8d1GdX2J7aDffkpCE7P0//5RFOH/0f/x4OZIOyFmX+xWkbX1+xKjrkeUf/XMhhQSmQQPdSiXTptN3JpKANOi/l6t7Q/rJDNIfbQCqov1nDFMyX7FLHsc18Lmu+ULtLWEOwlDUgbLcRgOAYhn/JUH/BRQ9YzsoKZTv9vcpyBieo159/P/nHb4POLQUUex0ZcHbpiSHHZU5d8oI4R3/oU0P4SyEhJu+vP+FkHOeNRH0dxNp3fPajq7pVpExp1feuRnSEwv5aYerm+KbHY40FgcqoCo84WhdCGABbhmYMwcOgkCXxK9a6rfr7WGAZtL/vJYV/SCUfGYW32L0KbDs1sWLEcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86401aec-1b6c-4b03-7881-08dd4d33e70d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:12:27.3722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYsYHzv6J6O62s+4u8yfP3OWpOd7fTcOokx+dKH4A3y1bISipDvx7NiEXLHFzlg+YIcn1/FuRF8V3iQFxC8oU93G/4FoObNcOyf1+nIdIH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140138
X-Proofpoint-GUID: ZvafppHmR2_w3N3hkDgcR6PIQ5u1Ms-5
X-Proofpoint-ORIG-GUID: ZvafppHmR2_w3N3hkDgcR6PIQ5u1Ms-5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/30/2025 12:01 PM, Peter Xu wrote:
> On Wed, Jan 29, 2025 at 01:20:13PM -0500, Steven Sistare wrote:
>> On 1/17/2025 6:57 PM, Peter Xu wrote:
>>> On Fri, Jan 17, 2025 at 02:10:14PM -0500, Steven Sistare wrote:
>>>> On 1/17/2025 1:16 PM, Peter Xu wrote:
>>>>> On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
>>>>>> +/*
>>>>>> + * Return true if ram contents would be lost during CPR.
>>>>>> + * Return false for ram_device because it is remapped in new QEMU.  Do not
>>>>>> + * exclude rom, even though it is readonly, because the rom file could change
>>>>>> + * in new QEMU.  Return false for non-migratable blocks.  They are either
>>>>>> + * re-created in new QEMU, or are handled specially, or are covered by a
>>>>>> + * device-level CPR blocker.  Return false for an fd, because it is visible and
>>>>>> + * can be remapped in new QEMU.
>>>>>> + */
>>>>>> +static bool ram_is_volatile(RAMBlock *rb)
>>>>>> +{
>>>>>> +    MemoryRegion *mr = rb->mr;
>>>>>> +
>>>>>> +    return mr &&
>>>>>> +        memory_region_is_ram(mr) &&
>>>>>> +        !memory_region_is_ram_device(mr) &&
>>>>>> +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
>>>>>> +        qemu_ram_is_migratable(rb) &&
>>>>>> +        rb->fd < 0;
>>>>>> +}
>>>>>
>>>>> Blocking guest_memfd looks ok, but comparing to add one more block
>>>>> notifier, can we check all ramblocks once in migrate_prepare(), and fail
>>>>> that command directly if it fails the check?
>>>>
>>>> In an upcoming patch, I will be adding an option analogous to only-migratable which
>>>> prevents QEMU from starting if anything would block cpr-transfer.  That option
>>>> will be checked when blockers are added, like for only-migratable. migrate_prepare
>>>> is too late.
>>>>
>>>>> OTOH, is there any simpler way to simplify the check conditions?  It'll be
>>>>> at least nice to break these checks into smaller if conditions for
>>>>> readability..
>>>>
>>>> I thought the function header comments made it clear, but I could move each
>>>> comment next to each condition:
>>>>
>>>>       ...
>>>>       /*
>>>>        * Return false for an fd, because it is visible and can be remapped in
>>>>        * new QEMU.
>>>>        */
>>>>       if (rb->fd >= 0) {
>>>>           return false;
>>>>       }
>>>>       ...
>>>>
>>>>> I wonder if we could stick with looping over all ramblocks, then make sure
>>>>> each of them is on the cpr saved fd list.  It may need to make
>>>>> cpr_save_fd() always register with the name of ramblock to do such lookup,
>>>>> or maybe we could also cache the ramblock pointer in CprFd, then the lookup
>>>>> will be a pointer match check.
>>>>
>>>> Some ramblocks are not on the list, such as named files.  Plus looping in
>>>> migrate_prepare is too late as noted above.
>>>>
>>>> IMO what I have already implemented using blockers is clean and elegant.
>>>
>>> OK if we need to fail it early at boot, then yes blockers are probably
>>> better.
>>>
>>> We'll need one more cmdline parameter. I've no objection, but I don't know
>>> how to judge when it's ok to add, when it's better not.. I'll leave others
>>> to comment on this.
>>>
>>> But still, could we check it when ramblocks are created?  So in that way
>>> whatever is forbidden is clear in its own path, I feel like that could be
>>> clearer (like what you did with gmemfd).
>>
>> When the ramblock is created, we don't yet know if it is migratable. A
>> ramblock that is not migratable does not block cpr. Migratable is not known
>> until vmstate_register_ram calls qemu_ram_set_migratable.  Hence that is
>> where I evaluate conditions and install a blocker.
>>
>> Because that is the only place where ram_block_add_cpr_blocker is called,
>> the test qemu_ram_is_migratable() inside ram_block_add_cpr_blocker is
>> redundant, and I should delete it.
> 
> Hmm.. sounds reasonable.
> 
>>
>>> For example, if I start to convert some of your requirements above, then
>>> memory_region_is_ram_device() implies RAM_PREALLOC.  Actually, ram_device
>>> is not the only RAM_PREALLOC user..  Say, would it also not work with all
>>> memory_region_init_ram_ptr() users (even if they're not ram_device)?  An
>>> example is, looks like virtio-gpu can create random ramblocks on the fly
>>> with prealloced buffers.  I am not sure whether they can be pinned by VFIO
>>> too.  You may know better.
>>
>> That memory is not visible to the guest.  It is not part of system_memory,
>> and is not marked migratable.
> 
> I _think_ that can still be visible at least for the virtio-gpu use case,
> which hangs under VirtIOGPUBase.hostmem.  Relevant code for reference:
> 
> virtio_gpu_virgl_map_resource_blob:
>      memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>      memory_region_add_subregion(&b->hostmem, offset, mr);
>      memory_region_set_enabled(mr, true);
> 
> virtio_gpu_pci_base_realize:
>          memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
>                             g->conf.hostmem);
>          pci_register_bar(&vpci_dev->pci_dev, 4,
>                           PCI_BASE_ADDRESS_SPACE_MEMORY |
>                           PCI_BASE_ADDRESS_MEM_PREFETCH |
>                           PCI_BASE_ADDRESS_MEM_TYPE_64,
>                           &g->hostmem);
> 
> pci_update_mappings:
>              memory_region_add_subregion_overlap(r->address_space,
>                                                  r->addr, r->memory, 1);
> 
> but indeed I'm not sure how it work with migration so far, because it
> doesn't have RAM_MIGRATABLE set. So at least cpr didn't make it more
> special.  I assume this isn't something we must figure out as of now
> then.. but if you do, please kindly share.

AFAICT this memory cannot be pinned, because it is not attached to the
"system_memory" mr and the "address_space_memory" address space.  The
listener than maps/pins is attached to address_space_memory.

I am submitting V2 of this patch with more embedded comments.

- Steve

