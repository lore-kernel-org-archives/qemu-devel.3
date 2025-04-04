Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429A7C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lDo-0006IO-E5; Fri, 04 Apr 2025 13:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u0lDc-0006Co-7J; Fri, 04 Apr 2025 13:52:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u0lDW-00046D-59; Fri, 04 Apr 2025 13:52:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534Du3b2012162;
 Fri, 4 Apr 2025 17:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=vzV8g9fJPZGF77ua2zGkv53ILveshittuorSGiKk7UI=; b=
 nmEnrLiZUz4zOkRKPNLV9PGxAx+eFkWQLdRdgrfJV2rfPn5ZxHtb1K+wkNOl3TdJ
 T6HGWmnmoRNjyrjBb7N70gde76Dqv6u64N2Y2jdo7UsYKmNkETebgjINGIhQX6mj
 JPVpdo5pZlYNIW8erZZD25pjvWFno8NBk98ES4nVhCDc4cwj74RDto8LE5HXtFNp
 qCddBX+TeJm/OYxPmFNiOMsAnYqbTS7zB8SSFgoGfalZZogGsjnUjcULYN9CO1zj
 PfGeigZ49NtgF0dmSJmaOEIUHmBl+yoGKnZPS3vO1xknyoaV+C1XSDQCiUc9niHJ
 uCo+eT+pLxeWvRXbaRk0DA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsfwn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Apr 2025 17:52:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 534GbtTK036168; Fri, 4 Apr 2025 17:52:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45t2nuc8ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Apr 2025 17:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnNL6k5gyiBka2SHeoH0xXL29WN0O2h3gXCkU1md71r2QXbUZL+fZC2AzW84COhFSnJeBHlLxjDqJ4alAdEFmOhe5cRn6tpm0gOkRo5RP2GOTGobubDe9GmJbyQhCkW15dEjBVmkFhSwoVLxJ0hA+GgZTDMk0R+RWS3c85sY++E2gjSUSEhgzUN/ft3gc5tn3ZfbQ6JE6Dfxzf/nxKg2aaGk1gR91p/XivRPntr5rukmTdRvDPaydo/FgNbkYwLUpTtzvRtu11PrW/g5B1vmQ6QR51Ir/CQ6fD5WoM5KfPEL+/56bG6lSr4xQ9tdQdoAiDzYoC+x7WI0Mvgz6Yysdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzV8g9fJPZGF77ua2zGkv53ILveshittuorSGiKk7UI=;
 b=o9JHXRiLVkdj0bUakOfuTMyo2qZcPAsR1z0dvbhDiW+wLNz3HYmT6s4Xa94z5ppVduZ/f4uBkZil5+yDsE1OzOcFGfrLjO27SYTWcpLHHWQPTe4srZ5/y8CoyG2JO1tKffCpsQyObGaRqf90zGHP6rAdGgjFYtXbaJzf8DIZdCbTCrOHJWW3QbmPmkuTXNb33/odw9dXLQMC75zROXrxCxZDdt4uYskmqlVMwHUiV5w582UYKQygBF6ujOjDDNKm6dxAbH6KeoOXWZi8+XICB4Brke2pNZkBgd2hKhNk/7BDPzkH2Bd12kI8r765RVeK/uXEUmalRsk60+q/HOd+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzV8g9fJPZGF77ua2zGkv53ILveshittuorSGiKk7UI=;
 b=tCfutWILXXjHRhhZftvCqOexJB/7SjMNy+A0pPY/V/rUe0FJ4qdOwbqyReSzNDLAxvp20imbKLRxqZ+tJTt2AOXS0pA18mS46MdgW/fp+fgkZctsBLTlud3PSvEONOsgPOf2dv/LxRs1ZkjvZ3SvlqyJpr7E5nakWJg64Cw8w5I=
Received: from SA1SPRMB0044.namprd10.prod.outlook.com (2603:10b6:806:33a::9)
 by SA1PR10MB5759.namprd10.prod.outlook.com (2603:10b6:806:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.35; Fri, 4 Apr
 2025 17:52:17 +0000
Received: from SA1SPRMB0044.namprd10.prod.outlook.com
 ([fe80::8263:a1ff:1b60:b0f7]) by SA1SPRMB0044.namprd10.prod.outlook.com
 ([fe80::8263:a1ff:1b60:b0f7%4]) with mapi id 15.20.8511.028; Fri, 4 Apr 2025
 17:52:17 +0000
Message-ID: <0e1a7bfd-ac33-4779-928c-bb486b878bcf@oracle.com>
Date: Fri, 4 Apr 2025 10:52:13 -0700
User-Agent: Mozilla Thunderbird
Subject: hw/nvme: Issue with multiple controllers behind a subsystem
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To SA1SPRMB0044.namprd10.prod.outlook.com
 (2603:10b6:806:33a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0044:EE_|SA1PR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7dcb74-9096-42ac-3a28-08dd73a1705e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0pUT0grTDJ2ek5rbXNKc1AzcmxBTVdYaElMb0syRXovam5ESFhLYmU3Nk5v?=
 =?utf-8?B?YkVyelc3Wm9BTmhMbG9Fa09FWmo0YUNVOHRZdDJnM3Z2dlFXaWZhY1Z1SjhZ?=
 =?utf-8?B?bUthb2dqeE5BRlkxOWc3S1l3OXBLWjFHRGEweVNoYllVeXIrOGhwZHZaWUJQ?=
 =?utf-8?B?OUFDUng1Q1FTeUhOUWNaT1pITXRnbnFaT1BiZ3Byck5hNFppS0Z5NnFNRHBS?=
 =?utf-8?B?OGJlOE94c1p4OTBkSUxkR2RCQUhTQUZCZ0ltYU5Hb1RGZkpxOU1ZWjMzYWZm?=
 =?utf-8?B?RHpHZUhuUTY4ODlwZDVoUUh5Z2FITHU1V3dQSnVmU0hOc2pqd1pRQU5vQng4?=
 =?utf-8?B?L0dzWVhBRnR1ZkxGZllwVEd6Q2ZpZ3crWFM2YWJLZFI3NkpTbE8yRHl2bE9G?=
 =?utf-8?B?UHllazBYVGxKaENtQUJPM2I4L21SeG81WGIxUVU0OWR3WGNTTlNkTGNVMnhr?=
 =?utf-8?B?NmE0MGNsajhkZVhLZkZXV1NuQ01VOHJZSWJvbTd1TTJDeFlnS0FvT2pzVUhm?=
 =?utf-8?B?ZDB3ZnlHcEs2bHhPcHVFbXVJajQ2L3RlUzY0eDNUWW5oNW5IUWwzdjRMUnRW?=
 =?utf-8?B?VkZyQjhyVmFvY3VRcyt0VjhHYXUzUWlvM1NKRVBQNnd0dHBoS25YVFJFc3Q1?=
 =?utf-8?B?cVhiSmRIbndpSE5EeTQ1NW5RSEYxUUhnR0FFbVNkSXdkdzRTRmN3dlB3elR6?=
 =?utf-8?B?SHpPenJwSDEzNUY4QzNWNHJPNVBHa2V1SWFVbEVHTHFsb1lnbmtMdEJ2clpm?=
 =?utf-8?B?OWpxQlVTLzh3TjVyTSttVkh0UU1ZbUhXamZuZFNDTUNxdENLcS9lYTlHU0Ux?=
 =?utf-8?B?c3FDczZxQ1FscTV0aEVjeGc2Z3pJU1F0bG9nazlsM2hFbVVhNWtJVTZMaFVH?=
 =?utf-8?B?RGJHK2NsRTJVbkdLTC9odDJiVnpOMHVjam9EUzZ4QXpGVWF0UnM4eExsR2pY?=
 =?utf-8?B?RThvYlBCN2pzUDI3WmdzS0N3MEFIakFqbi9VNEhPTTBHT2tsRkxKbWljNkhH?=
 =?utf-8?B?SWQ5N2hJbnVmSkU5RlNoUkhtUWJrVUt1bFdNTVVMMFVJVThoMFNZRjVHaHpI?=
 =?utf-8?B?QWlKRGxDLzMwSFNleVJUZUxuVXdmaDhxQkdlaDFzVXYyQTNNN0w2MWJJd0dF?=
 =?utf-8?B?NFBhWUJwY0I2Qyt0dy96TzlpM3ZQYnlEZ1pYS1lNa291SndSa1ZrSDNPNFdQ?=
 =?utf-8?B?NGZUd0xDa1dSRlBpZGhEWjVscXQ5V1BMZEM3TTBxSVJSd0lvVnlIWjJYZmJy?=
 =?utf-8?B?OXVjWlBkOTlScHNhdHJMK2lFeTkveGpkdFpiRE9lVDhqb1ExWmFvYUxyam44?=
 =?utf-8?B?cnpENGlvM1hDUmhqcmNBbjE0dGxIUnlFLys2QXdZMWZ1dnZqV1NDVkRDeFRV?=
 =?utf-8?B?OU9PRzBVb0VLdVlBWS82VGhUcU9RNXJNblVPdjVhRXE5ZXQ1R1hsTTYzd3M0?=
 =?utf-8?B?YWN1Zk93UlUxN2w5ek9PakdnS0ZyUjl5NE1ocmJhY25RSXVMREY4UzFTWmJ5?=
 =?utf-8?B?NmpUazVvRktmVnRoUmVVQm1GS2xjWUtNZWkvOUZDOXc3WDU3UmhmL1VucklM?=
 =?utf-8?B?YS92OFNjOCtQaE5NN2EvdzNrZWpPNlpNNmZtcEVRNUJtRk8yRHpjWHgxNXlK?=
 =?utf-8?B?YjU3Wnh5ZUpHOStzYzR5Zy9nNDVPdDJmU1FEdC9OdmkvUllranM0cW91NmhK?=
 =?utf-8?B?KzFSM0FzNUV1WHFzaTR4ZFZvaGw2NmF1MUhPek1kc3JrR2orRVMrcjdRZVBo?=
 =?utf-8?B?MkEyZkRMcmlaQWdQUVNhS2NlNmhDcy9yQVplRVRuR3hZeUpwUVgzNkh1UnRs?=
 =?utf-8?B?RHJRaUh6NnUvSDZiMkVSQXRFOWFEY1BJYzVVMTJ3NEhhZVZHa3B3TkZDZ0Qw?=
 =?utf-8?Q?TiWjH3uh4LjxK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1SPRMB0044.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01XU1JsSFV5dU1JNXZoYll0alNFZ3pUTWZhTzF0LzBudXlrUWl5K1BYM2Rz?=
 =?utf-8?B?ZmJkVXR4anNDZEZhTnpuUmhoeDE1WnVEOXhDWVd0NGQvdFI4ZTYyeVNxRHRC?=
 =?utf-8?B?VWhQRm5BV2JPZng2SzI3V2l0Y2Y3MHZOSWF3UkFJWmhiVlpTRnFhVVpBNFVv?=
 =?utf-8?B?bXF4TXY3MFVWSFJRSmJUMVduYXQ4ZmxMdzN0VDlhOE1OMC9XWUFKei9RV0VS?=
 =?utf-8?B?ZFUzN0F1eVBjQXNrTFZBNnJCUFREK2YzeUUxUE5QUzY1eFdpSG00aVBTQ1pQ?=
 =?utf-8?B?WmVFMEJqRWhtcXNRMXd0L2ttZWE2Y3ZPR25PWlFiM0oxa2tVU0dWODdoNWpJ?=
 =?utf-8?B?Ty90eThnbkpWTHFneEpmWDZyemFicXZVZXhqbFIyYWh2ZmRiR2lvKytBR3pr?=
 =?utf-8?B?TnNuOUlBZnBvRXphTktkT09xTVJwTSt1TUg0QUJvT09TN1NRa0tCS0JJbUtU?=
 =?utf-8?B?MHZab3hGVmYyVDU5dFRhV2I5WFc4TWZVQlBCQXdvOTBZTTRUVTA0VEVxNnVZ?=
 =?utf-8?B?emJmUEF4SHF4UENURWFUSHI5NXRrYXhleUEwRHAyMHFhN21jUmJXTGNNWnJv?=
 =?utf-8?B?YUdUcEhjRzMvcDUzR0ZQUDBiaWs5WE5LOG1idDVMOE9EWkY1MjdlaWdwdmIz?=
 =?utf-8?B?WlQxSXI4Uzc5RDJXRm44a0dUTGppMG4xQkdNbGFQRDZ0cWFYQ0R2Skh6TGtj?=
 =?utf-8?B?ZVBad2I3bnR2eFR4eE85TTRlb05rWTFGS3FnZnBjbHo1M3hNRFdLdDV4VFVh?=
 =?utf-8?B?V2hsVGozN0xTellQMU95dkdDKzZjTkVHYW55THNVQ25NMi8va0k5c0FtVlJW?=
 =?utf-8?B?SmJuMGQ4TngrRHErZzlnd1Jlc2hTOUFQOUwwd2dLYTNRRGxXOGZuMmNWeVRi?=
 =?utf-8?B?dW5lZlhwZFpNM09GeVZFOXFtTGRqK2NBQkpQeXg0ZGo1aFdpdy9id3VOcWNz?=
 =?utf-8?B?Wk81UFBNQ2dKODl0ZGpmNFU4bXJySWhYc1NyenpjRTVoVXVFdk4xa3NEbE5D?=
 =?utf-8?B?UDcxQlU4ajVwc3NiUExqUGJqOXE1eUoyNnlJbDVyRWxYb2VYelBYU1ZTWXh1?=
 =?utf-8?B?cW11VmpZWlFBc2dBSnNOcFVDaGVRZDA3a1FmeTFuUTBDd1p1cTlNV2xCS1Jz?=
 =?utf-8?B?MEFsS2VhdytVSktHWmZ1WG8yQlJacmlOd3dySnBFaTFPL3hiSFVuVk9WOW9V?=
 =?utf-8?B?dEIzcCtoSFFPQ1Z1MmZJU1Q0WmZZcXZBTUJiSFdZZmNxUlN6bzRyVkxVVGRK?=
 =?utf-8?B?ZDNScXprNzdrYkJVbzVaRHRkTXAyVkdRZ04xbHhOZnd4T1M1Mk9JK2lKWUxS?=
 =?utf-8?B?bllrcUpya0ZQUVdTcEdjcEhWOVdhRC9VR29PMXFWRHpQckJvTzh4cUN3U256?=
 =?utf-8?B?QVZWWkNCVDFlRy9xa2FYVzNYQ01pcXJVcUwxN1lYSy9nekVTMFFJeTNUVFZm?=
 =?utf-8?B?TUUwQlZ0SVB4MURWWDBwVG55aVFzZUpwRnZKV00yY3BDTnArK1lNZkFJSE9O?=
 =?utf-8?B?Q2huNjduek5EY3JuU0ZpdnJPdlcvODFOL25zYUtzZlpLODlxV252dTJ1bks1?=
 =?utf-8?B?bTdZWUxWQW45M3JXSGxsM3E3VUpiZkxVaEROakpmN1BiNmlFd280aUpnUWE0?=
 =?utf-8?B?Q251STBMRmFhT3dldVNPWCs1emM5NG4zRW0xcWVQS2Z4WVZGVXd1d2doZ1dF?=
 =?utf-8?B?ZkFaelJqZDdUWndnQk8zRW5mdkt6TXQ0SUhLUitXOVJRMVQyVFdwdE5BUFU5?=
 =?utf-8?B?S0NjZjVJWDlod1JrYXdNQVlaU2paRVVSU2VXdHFvZnV3MHlpMGF3ZmdST3RO?=
 =?utf-8?B?RWxIdkVvUFhlRFAyYThIWlJtVGg4eWhHMFVhY1BTR25JS3dSd3lScjdHckJm?=
 =?utf-8?B?THlsQnJ6S3FuRkF2YkFyb28xbUxhK3FzQmFxbVM3eS9tR1JtUVFFTDQ5QnVx?=
 =?utf-8?B?SUZreCtDTFc5cXVBeXhjZkJjMUtLWkR6RUw4VFBWbVZ0SG5CVjRjMGttVkh2?=
 =?utf-8?B?MlcyZmsvK1VyRVdsSzBnRVNkSWJ6WE9QbFcxaHZKazFKcmFpdGd0ZXYrNW93?=
 =?utf-8?B?MkZyZ3l3R21iSUhFVUd6MytyN0JyRTZlc3RuV2NVWDVtcVNpbUhoVmhXZXNR?=
 =?utf-8?B?NGJ0YXNVRk56d290bFN3SVRNUUVLL0p2QW1WRXpXV2dCTHo0aHpnVG1yOTVp?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TgRt/v/ZTUxU/W+WSUuqravLVUlRoJKy+HGArFfaLwbRydRivUUiSCH7Dzk4T5SkrwWGhgpypFhc3z8v1L/GMn4rkeIDiSMzqIEgxVh0+OH0OCnABdyBWRGNjzJ5CebL7qttfoX0shVbMS1lStXG2MZ6BB0nW61MEoUaYHzGv5ryjACq4RdAJ64+v+sO5o+VvwH0HjylYsLmj8DUZNc9agK9CBCrRbpLYuCgHVF2nk+lwWz0Y7Qa8ZyHmfnLh0nrHn/Vew6lwtaHUtcY6jhZvWAGbrpys9SyAQc2KeFuFKxA5uoQX+LYMchbtOORtMih6MU8goCYPD2ATWjclJqoYL54bxHu3dLpKjD8pCULN5RKv7RjhIXcGqs+KT0yozVJb6E4xUiOHHE5F1bQkAH4L3Q6SZszI8sbe7FL4/KWG5hQexTjEGQ/7UxW+LSzZx8I/WfLAowHRViIo5tig7Bmy3XhI0qZYq/jxDN9zURTvsKqr9frz7mE3Q5UB4RNDAbS5Ggq2Wyus16AFMUXThKDIfELaTCzkYFcfNffhLydDe8P9TrJOuuMX4DVP5EeIA2i9mVaTCR+NGdi3STm42UZGP6GAz+AUsujGmkkjf9N3is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7dcb74-9096-42ac-3a28-08dd73a1705e
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0044.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 17:52:17.1515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96mUfe7YKpCANNy0LrCj2jtkIXo7avyiUapltFRlNH8AdcoLRuH0KKZJSd0fImbCZcppJIa40CwjwO9q6xgZzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_07,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040123
X-Proofpoint-ORIG-GUID: zt4DRkUarN5hnT-XXoTkmc7cyel8pE4-
X-Proofpoint-GUID: zt4DRkUarN5hnT-XXoTkmc7cyel8pE4-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I'm running into a issue with the latest qemu-nvme with v10.0.0-rc2 with 
regards to multiple controllers behind a subsystem.  When I setup a 
subsystem with 2 controllers, each with a private/non-shared namespace, 
the two private/non-shared namespaces all get attached to one of the 
controllers.

I'm sending out diffs that resolve the problem but would like to get 
some feedback before sending a formal patch.

See below.

Thanks,

Alan Adamson




[root@localhost qemu-subsys]# git describe
v10.0.0-rc2
[root@localhost qemu-subsys]#


QEMU NVMe Config
================
-device nvme-subsys,id=subsys0 \
-device 
nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 
\
-device 
nvme,serial=deadbeef,id=nvme1,subsys=subsys0,atomic.dn=off,atomic.awun=127,atomic.awupf=63 
\
-drive id=ns1,file=/dev/nullb3,if=none \
-drive id=ns2,file=/dev/nullb2,if=none \
-drive id=ns3,file=/dev/nullb1,if=none \
-device nvme-ns,drive=ns1,bus=nvme0,nsid=1,shared=false \
-device nvme-ns,drive=ns2,bus=nvme1,nsid=2,shared=false \
-device nvme-ns,drive=ns3,bus=nvme1,nsid=3,shared=true  \

1 Subsystem (subsys0)
     2 Controllers (nvme0/nvme1)

nvme0
     private namespace (nsid=1)
     shared namespace (nsid=3)
nvme1
     private namespace (nsid=2)
     shared namespace (nsid=3)


What Linux is seeing
====================
[root@localhost ~]# nvme list -v
Subsystem Subsystem-NQN Controllers
---------------- 
------------------------------------------------------------------------------------------------ 
----------------
nvme-subsys1 nqn.2019-08.org.qemu:subsys0 nvme0, nvme1

Device           Cntlid SN MN                                       
FR       TxPort Address        Slot   Subsystem    Namespaces
---------------- ------ -------------------- 
---------------------------------------- -------- ------ -------------- 
------ ------------ ----------------
nvme0    0      deadbeef             QEMU NVMe 
Ctrl                           9.2.92   pcie   0000:00:04.0   4 
nvme-subsys1 nvme1n1, nvme1n2, nvme1n3
nvme1    1      deadbeef             QEMU NVMe 
Ctrl                           9.2.92   pcie   0000:00:05.0   5 
nvme-subsys1 nvme1n1

Device            Generic           NSID Usage                      
Format           Controllers
----------------- ----------------- ---------- 
-------------------------- ---------------- ----------------
/dev/nvme1n1 /dev/ng1n1   0x3        268.44  GB / 268.44  GB 512   B +  
0 B   nvme0, nvme1
/dev/nvme1n2 /dev/ng1n2   0x2        268.44  GB / 268.44  GB 512   B +  
0 B   nvme0
/dev/nvme1n3 /dev/ng1n3   0x1        268.44  GB / 268.44  GB 512   B +  
0 B   nvme0

[root@localhost ~]# nvme id-ctrl /dev/nvme1n2 |  grep awupf
awupf     : 15
[root@localhost ~]# nvme id-ctrl /dev/nvme1n3 |  grep awupf
awupf     : 15
[root@localhost ~]#

===================
Both private namspaces are being attached to the same controller (nvme0)


Fix
===
Need to keep track of the controller that registers a namespace with the 
subsystem
and only allow other controllers to attach to the namespace if it is shared.
Non-shared namespaces can only be attached to a controller than 
registers it.

Proposal
========
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 518d02dc6670..883d8d4722fd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5063,7 +5063,8 @@ static uint16_t nvme_endgrp_info(NvmeCtrl *n, 
uint8_t rae, uint32_t buf_len,
      }

      for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-        NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+        NvmeNamespace *ns = nvme_subsys_ns(n, i);
+
          if (!ns) {
              continue;
          }
@@ -5700,7 +5701,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, 
NvmeRequest *req, bool active)
      ns = nvme_ns(n, nsid);
      if (unlikely(!ns)) {
          if (!active) {
-            ns = nvme_subsys_ns(n->subsys, nsid);
+            ns = nvme_subsys_ns(n, nsid);
              if (!ns) {
[root@localhost qemu-subsys]# git log -p 
f4b9f10a80c30f1d6b9850d476eb8226bda3f553 > /tmp/p
^C
[root@localhost qemu-subsys]# vi /tmp/p
[root@localhost qemu-subsys]# cat /tmp/p
commit f4b9f10a80c30f1d6b9850d476eb8226bda3f553
Author: Alan Adamson <alan.adamson@oracle.com>
Date:   2025-04-03 14:10:30 -0400

     subsys multi controller shared fix

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 518d02dc6670..883d8d4722fd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5063,7 +5063,8 @@ static uint16_t nvme_endgrp_info(NvmeCtrl *n, 
uint8_t rae, uint32_t buf_len,
      }

      for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-        NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+        NvmeNamespace *ns = nvme_subsys_ns(n, i);
+
          if (!ns) {
              continue;
          }
@@ -5700,7 +5701,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, 
NvmeRequest *req, bool active)
      ns = nvme_ns(n, nsid);
      if (unlikely(!ns)) {
          if (!active) {
-            ns = nvme_subsys_ns(n->subsys, nsid);
+            ns = nvme_subsys_ns(n, nsid);
              if (!ns) {
                  return nvme_rpt_empty_id_struct(n, req);
              }
@@ -5739,7 +5740,7 @@ static uint16_t nvme_identify_ctrl_list(NvmeCtrl 
*n, NvmeRequest *req,
              return NVME_INVALID_FIELD | NVME_DNR;
          }

-        ns = nvme_subsys_ns(n->subsys, nsid);
+        ns = nvme_subsys_ns(n, nsid);
          if (!ns) {
              return NVME_INVALID_FIELD | NVME_DNR;
          }
@@ -5809,7 +5810,7 @@ static uint16_t nvme_identify_ns_ind(NvmeCtrl *n, 
NvmeRequest *req, bool alloc)
      ns = nvme_ns(n, nsid);
      if (unlikely(!ns)) {
          if (alloc) {
-            ns = nvme_subsys_ns(n->subsys, nsid);
+            ns = nvme_subsys_ns(n, nsid);
              if (!ns) {
                  return nvme_rpt_empty_id_struct(n, req);
              }
@@ -5837,7 +5838,7 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, 
NvmeRequest *req,
      ns = nvme_ns(n, nsid);
      if (unlikely(!ns)) {
          if (!active) {
-            ns = nvme_subsys_ns(n->subsys, nsid);
+            ns = nvme_subsys_ns(n, nsid);
              if (!ns) {
                  return nvme_rpt_empty_id_struct(n, req);
              }
@@ -5884,7 +5885,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, 
NvmeRequest *req,
          ns = nvme_ns(n, i);
          if (!ns) {
              if (!active) {
-                ns = nvme_subsys_ns(n->subsys, i);
+                ns = nvme_subsys_ns(n, i);
                  if (!ns) {
                      continue;
                  }
@@ -5932,7 +5933,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl 
*n, NvmeRequest *req,
          ns = nvme_ns(n, i);
          if (!ns) {
              if (!active) {
-                ns = nvme_subsys_ns(n->subsys, i);
+                ns = nvme_subsys_ns(n, i);
                  if (!ns) {
                      continue;
                  }
@@ -6793,7 +6794,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, 
NvmeRequest *req)
          return NVME_INVALID_NSID | NVME_DNR;
      }

-    ns = nvme_subsys_ns(n->subsys, nsid);
+    ns = nvme_subsys_ns(n, nsid);
      if (!ns) {
          return NVME_INVALID_FIELD | NVME_DNR;
      }
@@ -7751,17 +7752,23 @@ static int nvme_start_ctrl(NvmeCtrl *n)

      nvme_set_timestamp(n, 0ULL);

-    /* verify that the command sets of attached namespaces are supported */
-    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-        NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+    if (n->subsys) {
+        for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        NvmeNamespace *ns = n->subsys->namespaces[i].namespace;

-        if (ns && nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
-            if (!ns->attached || ns->params.shared) {
-                nvme_attach_ns(n, ns);
+        if (!ns) {
+                continue;
              }
+        if (!(n->subsys->namespaces[i].ctrl == n) && !ns->params.shared) {
+                continue;
+            }
+        if (nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
+                if (!ns->attached || ns->params.shared) {
+            nvme_attach_ns(n, ns);
+        }
+            }
          }
      }
-
      nvme_update_dsm_limits(n, NULL);

      return 0;
@@ -8993,7 +9000,8 @@ static void nvme_realize(PCIDevice *pci_dev, Error 
**errp)
              return;
          }

-        n->subsys->namespaces[ns->params.nsid] = ns;
+        n->subsys->namespaces[ns->params.nsid].namespace = ns;
+        n->subsys->namespaces[ns->params.nsid].ctrl = n;
      }
  }

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 98c1e75a5d29..9cca699b354f 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -742,7 +742,7 @@ static void nvme_ns_realize(DeviceState *dev, Error 
**errp)

      if (!nsid) {
          for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-            if (nvme_subsys_ns(subsys, i)) {
+            if (nvme_subsys_ns(n, i)) {
                  continue;
              }

@@ -754,12 +754,13 @@ static void nvme_ns_realize(DeviceState *dev, 
Error **errp)
              error_setg(errp, "no free namespace id");
              return;
          }
-    } else if (nvme_subsys_ns(subsys, nsid)) {
+    } else if (nvme_subsys_ns(n, nsid)) {
          error_setg(errp, "namespace id '%d' already allocated", nsid);
          return;
      }

-    subsys->namespaces[nsid] = ns;
+    subsys->namespaces[nsid].namespace = ns;
+    subsys->namespaces[nsid].ctrl = n;

      ns->id_ns.endgid = cpu_to_le16(0x1);
      ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 6f782ba18826..bea3b96a6dfa 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -97,6 +97,11 @@ typedef struct NvmeEnduranceGroup {
      } fdp;
  } NvmeEnduranceGroup;

+typedef struct Namespaces {
+    NvmeCtrl           *ctrl;
+    NvmeNamespace      *namespace;
+} Namespaces;
+
  typedef struct NvmeSubsystem {
      DeviceState parent_obj;
      NvmeBus     bus;
@@ -104,7 +109,7 @@ typedef struct NvmeSubsystem {
      char        *serial;

      NvmeCtrl           *ctrls[NVME_MAX_CONTROLLERS];
-    NvmeNamespace      *namespaces[NVME_MAX_NAMESPACES + 1];
+    Namespaces         namespaces[NVME_MAX_NAMESPACES + 1];
      NvmeEnduranceGroup endgrp;

      struct {
@@ -136,16 +141,6 @@ static inline NvmeCtrl 
*nvme_subsys_ctrl(NvmeSubsystem *subsys,
      return subsys->ctrls[cntlid];
  }

-static inline NvmeNamespace *nvme_subsys_ns(NvmeSubsystem *subsys,
-                                            uint32_t nsid)
-{
-    if (!subsys || !nsid || nsid > NVME_MAX_NAMESPACES) {
-        return NULL;
-    }
-
-    return subsys->namespaces[nsid];
-}
-
  #define TYPE_NVME_NS "nvme-ns"
  #define NVME_NS(obj) \
      OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
@@ -711,6 +706,14 @@ static inline NvmeSecCtrlEntry 
*nvme_sctrl_for_cntlid(NvmeCtrl *n,
      return NULL;
  }

+static inline NvmeNamespace *nvme_subsys_ns(NvmeCtrl *n, uint32_t nsid)
+{
+    if (!n->subsys || !nsid || nsid > NVME_MAX_NAMESPACES) {
+        return NULL;
+    }
+    return n->subsys->namespaces[nsid].namespace;
+}
+
  void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns);
  uint16_t nvme_bounce_data(NvmeCtrl *n, void *ptr, uint32_t len,
                            NvmeTxDirection dir, NvmeRequest *req);
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 2ae56f12a596..d5751564c05c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -92,13 +92,19 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)

      subsys->ctrls[cntlid] = n;

-    for (nsid = 1; nsid < ARRAY_SIZE(subsys->namespaces); nsid++) {
-        NvmeNamespace *ns = subsys->namespaces[nsid];
-        if (ns && ns->params.shared && !ns->params.detached) {
-            nvme_attach_ns(n, ns);
+    for (nsid = 1; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+        NvmeNamespace *ns = subsys->namespaces[nsid].namespace;
+
+    if (!ns) {
+            continue;
+        }
+        if (!(subsys->namespaces[nsid].ctrl == n) && !ns->params.shared) {
+            continue;
          }
+    if (ns->params.shared && !ns->params.detached) {
+            nvme_attach_ns(n, ns);
+    }
      }
-
      return cntlid;
  }


With this fix:
==============
[root@localhost ~]# nvme list -v
Subsystem Subsystem-NQN Controllers
---------------- 
------------------------------------------------------------------------------------------------ 
----------------
nvme-subsys1 nqn.2019-08.org.qemu:subsys0 nvme0, nvme1

Device           Cntlid SN MN                                       
FR       TxPort Address        Slot   Subsystem    Namespaces
---------------- ------ -------------------- 
---------------------------------------- -------- ------ -------------- 
------ ------------ ----------------
nvme0    0      deadbeef             QEMU NVMe 
Ctrl                           9.2.92   pcie   0000:00:04.0   4 
nvme-subsys1 nvme1n2, nvme1n3
nvme1    1      deadbeef             QEMU NVMe 
Ctrl                           9.2.92   pcie   0000:00:05.0   5 
nvme-subsys1 nvme1n1, nvme1n3

Device            Generic           NSID Usage                      
Format           Controllers
----------------- ----------------- ---------- 
-------------------------- ---------------- ----------------
/dev/nvme1n1 /dev/ng1n1   0x2        268.44  GB / 268.44  GB 512   B +  
0 B   nvme1
/dev/nvme1n2 /dev/ng1n2   0x1        268.44  GB / 268.44  GB 512   B +  
0 B   nvme0
/dev/nvme1n3 /dev/ng1n3   0x3        268.44  GB / 268.44  GB 512   B +  
0 B   nvme0, nvme1

[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 |  grep awupf
awupf     : 63
[root@localhost ~]# nvme id-ctrl /dev/nvme1n2 |  grep awupf
awupf     : 15
[root@localhost ~]#

Each private namespace is attached to its own controller and that is 
verified with the AWUPF values.




