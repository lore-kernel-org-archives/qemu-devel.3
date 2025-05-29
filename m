Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343B7C5B549
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 14:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKeh6-0007mQ-BB; Thu, 29 May 2025 10:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKeh3-0007ka-EG
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:57:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKeh1-0000I6-0E
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:57:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7tua0026776;
 Thu, 29 May 2025 14:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=58tradUzbhLlUEmBq2i5xGjOyE5E4AOjovdMc2nW7Yo=; b=
 pR6FFsTK0+wLETSvIsUJbVIeEBvWie/dpd7/HVcZJ/jgxfn+cfZ4zPBtpew+F0Qu
 FYIv38B4YF9S9/DjOSlEKy/C6GQYNq1fgJdHjciSC5YyL6yHOneB/CVlAOhZdut2
 XF/S/hVJJMj12oVnQUocQfrSfVg1wbtcpvqVbVRLxPG/MNbG6RZb7gSkPWF5pH7l
 kw//jw+QkpfK/zE9ZI5Pr7jW94Lp/D1699EYbpWBtKTxUJ0bNi9kFjOntIN1HJKq
 njKH6aDBQ7gPX1JIzd1bB1+3O0L/EiFC+pkleykyBhMX1AHE7mASopWz6RDHwYU2
 anI5rLsd8qs7lEiAoVG6Pw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd87dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 14:57:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TEGNYG019271; Thu, 29 May 2025 14:57:05 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11012036.outbound.protection.outlook.com
 [40.93.200.36])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc2n94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 14:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2R/gVtjgGpGokZjTGgplJ4lEb/5wTXr6rk7DjHN25G3XbjZAc9qCOWWmneBRDMVYfsWPe476oBWt+7FSyZO+Z6GBE6Tx3dagk3if7rIChFmQQjqwidXdIKXoghlxYVNWyoap2hioHdX6lzBlH1crgw0DIGdcKF3KJFzGsAv7kAGMV1moxRxGCG0OmE4rIwfKE9tbi2++9BnQB69NAG547FERSKlhDeqghBJ4uihVo8AieiM8ot9F4+obLXWLkTnKUiNrWN4jDgFwqMFxSfiMDiC8fgpNZ8dFdaOp+IieO7YHKbCvWGM/H1C3PGuLUDCeVLESBjxeZC9z6OM8X/1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58tradUzbhLlUEmBq2i5xGjOyE5E4AOjovdMc2nW7Yo=;
 b=P017XfzLuieM3/lp3qTUA5IXoi56ybdP83bMuMUFYPnk7sFXUDYsj9ZN+Sppy6jkzM2U6JEIq2w6CzsVKAieOqimLppVpp4+YvJVJFjxgd5L1C0h31i63/cpUNiw3IfcF83uJn3uo2bIncbw1t49i/PPN75uJqwvh8/edyeiOLRwLctfVtdAxOCfUQQkN0SJ+MqgQwigwP5miT1rHaB5JopHCCLXDcBsajV1rjcOwPSHxhYiqxGhuWaedcRTNQJHaRB0MsyX2hI9M4INsouGvyYZdy516W7lAIp6k4m2eeZDG+nL7O+9PzFMI5tS6X3rvzBTDvClowHWZj2dXFmlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58tradUzbhLlUEmBq2i5xGjOyE5E4AOjovdMc2nW7Yo=;
 b=x2y2t3dzocJxbw+IGuq0InDf1M35Q5kRC6JNtezZPYKoHauCOd9YHGumuJ0vb3uS4sfWrVkbZf2bJMC2Pu9N5o2Obr6g5DtelUCjLmVTYfp6sM8POgTkeCHAKtS9Q1ql20oS4/IoLCzM4ROk18eEubU9yLV935MXlQLdjZrRSVc=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.34; Thu, 29 May 2025 14:56:54 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8746.035; Thu, 29 May 2025
 14:56:54 +0000
Message-ID: <ee09260d-ab53-4f08-81f0-c5c7d45f6c40@oracle.com>
Date: Thu, 29 May 2025 10:56:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] amd_iommu: Fix masks for various IOMMU MMIO
 Registers
To: Vasant Hegde <vasant.hegde@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
 <20250528221725.3554040-5-alejandro.j.jimenez@oracle.com>
 <13142886-d48e-4b4a-8bb3-ff11c291e977@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <13142886-d48e-4b4a-8bb3-ff11c291e977@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 788f0d19-035c-47e5-0fe3-08dd9ec10cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXhUS1cwWVNreHIyZEZ1UzNYSWt1bll3aHRqbElmV3VYNi85WXRpUTFidi9F?=
 =?utf-8?B?SkQwbzEyQitndFNTUHFTUGN5RjJWYjFKRlRHWFJycFNHMXlYTDRWclRFTGlj?=
 =?utf-8?B?aGpXNjZBbWpzRW5yeGVwRW9mNDFIYXZKWnJORkJuS1lpTXZ0YW9JM3hUWU56?=
 =?utf-8?B?cFFWZEh6a2dZeVVpY2JBS0ljVTBMUVg4NjNUay9hTXRIbC9lY3d5aDZXM2l1?=
 =?utf-8?B?eGxIdlhmUWpLQWZubVVJeWtNM3lWRXNwMXlTMGFpYjA4TFRNbE1aT1ZDQWtJ?=
 =?utf-8?B?T3h3QjdhdmNpRW9HYWp1eVBYV1VLQkJ6MC9IblBpTHJBYjlzTjg1cjdjNG9v?=
 =?utf-8?B?TU9kWUhEQTRrSGdPeTU1NWcvbndibjFzZ3d2ZGpnenBEdDJnQnVaY3BmUVRq?=
 =?utf-8?B?NFBHVUxyM3N4SG9UOVE4ZU1JdVdlenJHSGoydFFLQTBKT2xSN0kwZSt3LzMw?=
 =?utf-8?B?Q1hweG5BemY0dStWVWphM2llQVlPQ1JDQnFveG5HZjM0aTA5dGIxT3hOcFZL?=
 =?utf-8?B?TCtjYkQ0ZzlqOUVtUlJ5eXhXWjBzems0SU9EODVFNlNTRmMvalVRdVBoZ0Vq?=
 =?utf-8?B?NTVnYUxJdjVCZis4c3lSN2pBQXZVSEk5ak5IVHo0U2JFejlyaUgyUG00eS8z?=
 =?utf-8?B?MmI4YU1STDdvamQxZm1wcXhBNUE5NVhWUHVBNWo4ZGZkQU5TTWdUWkVGTEh5?=
 =?utf-8?B?MFFxQTBQSWRFSGRraHBQc3JGb2FncnA1eUhMRGpDdHlCYjhEZTNMU0JVMlda?=
 =?utf-8?B?ekZWbFdnbzhxV21xb2tVVGY3cVFaTXJFWkd4VElSVWxuVngwV2d2aW5KdmNL?=
 =?utf-8?B?bENBLzVsVnRnTGl5bCtYYzBINWxkWnNJQTRzR1IyaUcrUy9KWTRoeHZiSlU2?=
 =?utf-8?B?cTlXMm1xRGRhV3ZWek5jZEJDS0NPUktIUlk0d3JrR3phbzFqaGJ2MWo0Vk5x?=
 =?utf-8?B?dktxQVlvMFY0bFJxVVFuRVFsWjlKUTFSNU05QUhocEZpaWYvTmg3c1FJc2pO?=
 =?utf-8?B?Y01ma1llVXJFUTR3NDdSS2JmaEJGUVduenNPMGZ4L1p0Rld2OW5xa0wra3Ba?=
 =?utf-8?B?THRFVmhSVkFCTkhRNzBQWndGQnBwb21xUStkeElvMTdldTRNMkR2ck40ckR3?=
 =?utf-8?B?MFRSS3oyMXgxWUdWbDFiU1hpcUMyTkJzMVlpZFMrZDBSYk1hb1ZKUFl2d2pQ?=
 =?utf-8?B?c3RENm9vREhLTHVuRlhuZXhRS3dxdkVRbytPeWZQK3E3QUhBYjJLWk83Q3Rw?=
 =?utf-8?B?RFZJRW1nWEhKbmpacWh2YkJFWGZlUUJGeGtRd0Q4dW5MemFkQkJVdnhyVkVh?=
 =?utf-8?B?bGtKTExsN3krZHo0empZTDg0c3haSnE4N0lPeXJKVmplbG5lblp2eEM1V2wv?=
 =?utf-8?B?enRoOTJ4WFIwVEZNUXR5ekkwTC9EV3FnVnAxV2dod1lwZ1B4bGVNemxXOFpa?=
 =?utf-8?B?Q21QbUlYK3pOSVgyU0tRa25haktDRDBlUFB4QnFUMjdjbDdTU1l0a3AzczhI?=
 =?utf-8?B?TnNJMjJrZ2hXU3grTmtvNmRUVGZhMTBtWnYyS0VYeXZNZy9Lbll6ekF5Vk1T?=
 =?utf-8?B?cCs1Y0F5c09tR1JYb2ozK0lXK2crODJzR0tuM09vRUFpWmJtS2cvZnIyYjVt?=
 =?utf-8?B?OUN3clVWWnhKY24yZVpCekJYL1Jrb09rejdGWG9pdUptM00yWEpGeVM0b09z?=
 =?utf-8?B?d0NUR3hsdG5OYURlc1lRdFdwdzlzOHN0OU1jN2JSeVVuMm94bkJKMTdkVDdw?=
 =?utf-8?B?VFltdzFaMnNxRDAzQnRUVllyOWkwRDM0TXRLOGRTc2F1RGh3aVBPMGR5TTJX?=
 =?utf-8?B?d0RLTmNLU1d4ZzlqS3FOR3AzYmhlSG1xRnZ2LzlDWDQwaGRpN1FyOStjSWtx?=
 =?utf-8?B?NGtNZHE1c0NrUGgyQTAyUnVoa2RzdnRtT0YrdHhRbVhsMGhhenJFVEYwOGd0?=
 =?utf-8?Q?BJYsI+nlGTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZFa3JnWjRsbDBYWlRWRzdKTlowSkF6OGUxalpiQUpLeCtTUnNWVHN6bkZv?=
 =?utf-8?B?ZlFWMU1TSFJYRDZTTjhqRDR3dnNhN1dpbitHUm5ENjgwdzdTT3JjSjhXaEFS?=
 =?utf-8?B?dzJvRUFUQ1c2UDludWtnbElwNG83bG1QRDN3N1Z5bzZOQWQ1Q3IvZWZSOEE2?=
 =?utf-8?B?QTA2MXlZWGxGUFUyNWNVZDBLUS9wMi9oQ3loczlqNjk1cVBQOG85cjNxTURD?=
 =?utf-8?B?OTMwVVB1UWw2elpuNXZhNXRiVUhUV1B2MTh5Z2VVeW5zb3JjdXhWZlY4eExq?=
 =?utf-8?B?TVdRQnRQV0Fxb2tBb0E3V3hHMGNibjA2Vm9wS1VMbGZJc1RSNEJxQldmMDN2?=
 =?utf-8?B?R1IydW9aQmViNlFCNkE2Z2hMR0kyUnZsVk9SbEtBcGxZYlI5d2tKZ1AwbHY5?=
 =?utf-8?B?RTBCTzBRVkRLdlBEUFl5a3g0b084WUp4WkhhYXA3VFQ0RElndVZta3JCUjBQ?=
 =?utf-8?B?WmdlN0FvcjdyeFd1bEZzS2Q1YlV3Ty9pSkpvYktNb0xNYUkveVhvam82VmRC?=
 =?utf-8?B?Q3ZFaWZxdGx4Ukg3V0JoVFBxM2pzUkJkSE9jWkcvamo4WWpGKzdRb204L2VI?=
 =?utf-8?B?MnlwRHcvNHV4QUNkZXY0Rk9pOWE5SXFtcFhzM09FOS9RTGxxc3haTjg4NU55?=
 =?utf-8?B?bVNxN1M0ZzNJdktSNlhZUENXSGZyM3gxVUd5dzZkV0R0bEdvMHRuVEQ3Vms4?=
 =?utf-8?B?WDJlbVNzaFd2bml2NkhBWDlneUFla28yY1dmak4yREk2Q3BLZTFRY0RLYXc3?=
 =?utf-8?B?MFA5RTNITXc4TGRxNkhYVHRCazgxVjdFbVd3M3psSkc3R29YbHAzc1AzMWdH?=
 =?utf-8?B?VWtob2VrWDdXS3JyVnlIT3U2TXpwMU45ekFsRURmUFRQdUhJL2ZzeXYyUGZT?=
 =?utf-8?B?NVoyRCt5WlM3NnM2a20xdkFRVDNabVJqUkZMYmd2TG13VERlRTdXWk43cUZu?=
 =?utf-8?B?eFplckZINFNrNUF3T2k2OFNQZ0p5Q2FKSFJNcW9US1huNDQ4aE53c2RjWmRM?=
 =?utf-8?B?eXl4aklaYmRIYTNDWjVCUExDR0t1K1pEbmM2QUxXWlhzTFlNQmhna1hXSUFr?=
 =?utf-8?B?SnB3cWxZVkNiMHpEWFg5ZTR3anlERS9KWGMxbDQzNnQxQ3JZaUY5eThKYjZQ?=
 =?utf-8?B?eUYyTkk3aHg0RkdXQ0FyT0hNNUl1Y2U3Q3hid2wwOGFaMHp5bFlVZyt0Tm5w?=
 =?utf-8?B?NVVvaGtVNnFnNFBrQU1MSFJXQ1BKcVNJUXNCdWthZmhuOHNuTWkrOHlVVlhy?=
 =?utf-8?B?VU1ZUTVFekoxYWdXa3BGb3BYWGRZNDBmY3JxSSthNmNqM2hReCt1L2dlOXM4?=
 =?utf-8?B?MUpuVXJ4OWRWR2pZMkpuOC9CMkNYNWhPV1VMM2M5RHZXWmd1WWIwZ1RUWHNV?=
 =?utf-8?B?YkMveVFFMWVmZXJvSjJxNnZPSnFxcDlCUitqWWxKTWdaNHZnY0wzRDJwLzRp?=
 =?utf-8?B?bmZtaVEySVVWREV1VlRiWHZHUXZiODAwM3Y2QWVjU0lPTWNCU1hZb080SUQ3?=
 =?utf-8?B?Q1ZnOSthT2RaOGE0bGxIMEVreHAzeE5vOHVZVXFnUzRwOGxqK2xuSGtSMXhr?=
 =?utf-8?B?QXhWRWxRaUIwVnVsYUpQUHYyUDhuMmRiNkpEdDA5aCtoNWo4QThGODJSMEx3?=
 =?utf-8?B?ZVlNRm9jMEhpS0tNRTlOMnVhZkNOOGRWQkhzblFWOVQxWjVqOGRlS1VtUGVV?=
 =?utf-8?B?RjExWGxQeUNsUG50UFhaUWR0QnZIZUlmYXR1RG5iVjU3RUhkaklia1V0bmdC?=
 =?utf-8?B?bTErNDY3THExWEwvUkpJNU5rUUZkVzlMZDFtNVdPNmJ5V1YyUTZBY3pHeTI4?=
 =?utf-8?B?ei9IZWU4eDVlQ1I1VTV3bXNxY0RJeG40WHRxUkczSjFQNnc0emVWWEdtRzJL?=
 =?utf-8?B?cjRjbXRHOStUZ1RtcVY2dTZpYllUWjJjWnJxZDJxZHozbXB2ZDdyWDI5bGpU?=
 =?utf-8?B?S1FFZDZnS3dJN3QrbFV5ZDB5L1lNWktNRUxDZncyZERZTnl6V1VGalY0MjJm?=
 =?utf-8?B?TXlOek50RmVrTUtoQlFZV2wwdVRMVEw5YWM2QjdxOHFBd3d2TGwvbkZnSzFV?=
 =?utf-8?B?TSswdXYxY1I4WlF3M284U096T05EUnI5NGxaQ0tRNkxpdjlKSnNlRDhyVE9y?=
 =?utf-8?B?bzhNRjRXSkQ3V1czZUNMbUptdUZTUEZXSjVCSTVtcE1HcTYvblh6clh6aXg3?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LQwZlVx34IAjQk1iXKmPuhTiQuGZ1F37Jb9e5+bSa6ztlgkzw8ukqgsKjoWdDys+K8HCD5Jb0Yz6+2M1p94qReBwZf/JPGLnrKbSdA7/1hcupRZRPxZkXwoqaBcdNXe3x4eweqaNIZYwxbv1pOqHHkWarq2qTYRpbhin0jQ/U8kxZzA28rckkZK3U20njRPdD5DXUfDCgLsrCx5CJfZc9Py3/TMazxpeoO8IhM0Fhxhbk5B3wKNe89i7tuDae7eTS2drUjo9j/VnQfRypu63Gus+K0hkpP0S5om80BgqvRVyRzZQNblQebzTdDsjZeTXZzyz0ammwE/yGWktBSh5VV74ckHDMgYnp/OauEA9+BAtyOt6DIK72Dow/v7ooFd0vcak71/Urt7DYEOFZsm+BTSJPZKYZ99O2zkM0ikOgarydMqBC/ta6vXJ85iUlO1MjoFmYVR8SuXtp2PLfGIcJZofQ9m4qUV53sIBl/ZywBUZNy/Ol+aadcpS63ymR4AjOnImZUIiGfHVwyb1rhLgO1+oXf5NI7pEIftTgjf557fUZE5i6ly8tDXfmKKWiCGPGH2c1sXMdT8wg+6RRfaIav3UCp6qFLhNtIklfSj8BQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788f0d19-035c-47e5-0fe3-08dd9ec10cbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:56:53.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM10FGLne2IlRuvMCIPsFWLMW5SfSTEp4Qhf9mYZg6o56GDD7FELdfP6KTLYeTuiRk8OFtVzSN2gI2I8L5j+yozFAHO45Ci3rMQs0rR4j6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290144
X-Proofpoint-ORIG-GUID: tuW9he3MlEKOttqQXbb2zsL_gbJZHEUn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE0NSBTYWx0ZWRfX0RZeFKaXLeiV
 dN3HSOzIe5sdH3VlEOocm2yfBXvUHhAnVxN2KbKiCE+grWsIgLJF9jl6yULTkM6+AfK1LGxEy9F
 AZbP+XLryDwVRbAQmDc0+KoPUPPUlBc7VHoQstGKIFg0OOGO9OW5Y++MzCJ58WOHC4tKefL7IOH
 tiqdkcMmkyhuSuLu0Tcqr7HFsX+rauS1MMj/m5Udnw1jbSCt08JiEVy6rxL+qfYvywBweqY3WVF
 +bxGuoM9rF3xy2nv8aQYr1NB9zaMevtZzrLGAfZ8gAiDrTPu1/9x0lPH3VVpisoZSHSj/WHwSfi
 z9vjhEg3HEFoDq4YTIXgQ8SQsPwa4wgh9L96UFXY4py9MXLhOEMLjOBc1/mRhuU9t9uyxHYiQtg
 bHfnL5jige/CP9VV+EHhUu4QztxsG8D2RoimmKcO34y1jYz84uM2Xyhf1nYw0l+Z3XJ4Sg8X
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=683875c2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8
 a=zd2uoN0lAAAA:8 a=2iQ5LejF3G9JVjqSboEA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: tuW9he3MlEKOttqQXbb2zsL_gbJZHEUn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/29/25 1:23 AM, Vasant Hegde wrote:
> 
> 
> On 5/29/2025 3:47 AM, Alejandro Jimenez wrote:
>> Address various issues with definitions of the MMIO registers e.g. for the
>> Device Table Address Register, the size mask currently encompasses reserved
>> bits [11:9], so change it to only extract the bits [8:0] encoding size.
>>
>> Convert masks to use GENMASK64 for consistency, and make unrelated
>> definitions independent.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> This patch makes it easy to read macros! Thanks.
> 

Easier is the goal :). I was tempted to try to remove duplication since 
these registers all use similar offsets for their fields, but I figured 
it is better to keep them independent in case they diverge in future 
revisions.

> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> 
>> ---
>>   hw/i386/amd_iommu.h | 38 +++++++++++++++++++-------------------
>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 45a997af861e6..09352672bdcc2 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -68,34 +68,34 @@
>>   

>>   
>> -#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
> 
> Unrelated to this patch.. I think we should just read the AMDVI_MMIO_EVENT_BASE
> register and extract the length. Same for rest of the buffer. We can do that as
> improvement later.
> 

Agree. The current approach is technically a bug since it is also 
reading data from the next MMIO offset, and breaking the requirement 
from 3.4 IOMMU MMIO Registers that says:
"Accesses must be aligned to the size of the access..."

I looked into that area because I was initially confused by the 
*_SIZE_BYTE definitions (it didn't help that the one above is incorrect 
since it uses the wrong starting register).
I considered renaming them to use something like *_LEN_OFFSET instead 
since that would match the naming in the spec more closely, but decided 
to limit changes to the header. And with the correct fix as you mention 
those definitions won't be needed anyways.

Thank you,
Alejandro

> -Vasant
> 
> 


