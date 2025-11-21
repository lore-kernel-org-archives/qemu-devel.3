Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ADACFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcuw-0000OT-Ul; Fri, 21 Nov 2025 21:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vMbwh-0007XT-Da
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:57:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vMbwV-0001h8-GD
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:57:44 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEh8ur028608;
 Fri, 21 Nov 2025 16:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KBzs7SOGz92vpjFvRsiXkGu3L3Q/BrNdf6H6GphlLrc=; b=
 V/qsDIQtInKwhZkek0gD+EdbylhYCFoGoyi48IEdohczjRV7+jy9gnPliIDUW/1H
 l2KcLe1b3EX/c4g+LgB6GBL39DbbNjPknnIdSFjMeItfiXADftvueeB4EZ5/9Pow
 vVJ3Dache5NCuiB/WwMWUUzDysmKvzpljdV2nb7ZFJWf0Uo4uewz2izb7YHuXroj
 g5J1LneCfYACJCfUGSKm+Ngr9/D4pLq6l7UhWKSIhIu2A4UhMrNhJbWZ33Ahn/8Q
 pLFqEG2pCowZCXjcsefvnRer0qXgmMXNzqgfNMPv48uMJaiCmg8U6NOk6zI8vC77
 K1G71Y9pbU829bbq1vymmg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej96btbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Nov 2025 16:36:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5ALGDD9U009444; Fri, 21 Nov 2025 16:36:55 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4aefyhwus5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Nov 2025 16:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW8ZGINY9nKOP413/JMO8VKKDaYvM8lB5LnqJKXH9XN8IH4w+xu12pVGfW53/kvPsfE4JgaP76KRIbIwEIJnB9zjyntEi6QfuyPnS99xdGbE2TdaH8F4Fj8/OJ8TW8jBM3G3n0oIQX7/6z9q2ewKjcGqwa0XF/LmoEecoslvjVHMCdKgH7d+bBnGRm9fLAzDVYQHykBSYNMJY619815bV8OXSdA2GTNC7nTdUTTiOgo65Qe6/rVHYvbg6y3XnGCLu5viEW3Q9IpLvqLVzaoziHJMto95xjR6xWyPTLa6kh/jGdMgH7aHGIM0DLZL7mEbRM8y3Xj1WvPzBl5kQGHI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBzs7SOGz92vpjFvRsiXkGu3L3Q/BrNdf6H6GphlLrc=;
 b=QufT4+KtWylIy7igv/QSSXrPhEzhPflF1r+nUR7w4yUdZJWuNWcEmjdZsPFI5XUXXbLjbZs9yKR+e3b5bt0W8kSLXJxDj22tG+aywORTJD/tCv+8Je6uXVO8iZ8i7xNV+6rkXTVBIw7tiRXd8UmMnP1uxdo+IFkH+okPmKszuy+TD10TiRkrYoHEp8HtmZMXFjWBLZkb0GMADy9yjhOW8oVXzvahGhZqtaKE8u6fyAH093LwCfOtHLMXMNKCAtvYfDMVOxmNWmJqQm4nx0ke9joLMgP9ubZ68xjnw6EX04XC/JtySySKb/T1Kwv7ntqBeEQTcvfbKmnVjK15vP17bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBzs7SOGz92vpjFvRsiXkGu3L3Q/BrNdf6H6GphlLrc=;
 b=t4iZ9GsLaADafjjFcG21GV5wYlpaYDOHapVzK2ET/vR0W7ayxL2BC+CHakOX0dO9OSfZpCl41c+flSkIkQy3ecjWigrcfodpZKpf7Aecl7+KelWr4Q2wxTMMfcdB26L4DJqf6bcjC6bco4NtZokZn3bOKWgiEdHI7Jbk6/WNUfs=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CY5PR10MB5985.namprd10.prod.outlook.com (2603:10b6:930:2b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 16:36:50 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 16:36:50 +0000
Message-ID: <6ed6db13-f23d-4e76-8e1b-804fe6a91e53@oracle.com>
Date: Fri, 21 Nov 2025 11:36:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd_iommu: Use switch case to determine mmio register
 name
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-2-sarunkod@amd.com>
 <eaf49cf3-e56b-40f1-974d-207969c7371e@oracle.com>
 <c8e2ca43-c577-411a-a8de-176c5f85c15f@amd.com>
 <53a08e47-a9bc-484e-b510-faa76541dbbc@oracle.com>
 <503782ef-f764-4263-8493-d18c162e0615@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <503782ef-f764-4263-8493-d18c162e0615@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::15) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CY5PR10MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 676b7785-9cac-472f-cfd6-08de291c2bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0FTbEVBSWtjZXBVRDlCS085TGNNOVN1QjVYUmhPZDVGZERyMVdYM0pxS1BG?=
 =?utf-8?B?Q05RMUVMRXpKOVhCaG9RTWVDT3crbjNVMDhxaWxNRWNxSHJzSjUyVkUzU3Vj?=
 =?utf-8?B?R2N0dGt1NUovOEpiV3UxSVZEbnA5bUM1Q05qNmYyNVgycjMyMno4bmJ4TVR2?=
 =?utf-8?B?MUtFaE1JcTBHamdzOEwydU8vT1RTM2pkQlduTncxeW9RdzJvMjNyUDl2RHdF?=
 =?utf-8?B?TmRyalR2R2xOVnhjM2RtYzJJK0lRUDJHbTdxcEhsWXl5NnVSdWpoZWhGd2la?=
 =?utf-8?B?UmZJY2lMQXU0WlY1L1N0SVdiVE9sNUttVWg2YjhnTHdBOUJvamptdndWZEoy?=
 =?utf-8?B?M0xldHBxeGpIUjQ2SkdlYlYzaXE2aWp2NzlXWjNRNVM1dmhaYnc5Tm5VZ1BE?=
 =?utf-8?B?TGR4dUdtUWhZbXI4WUh4RXRNcmZLRW9Wc0VvbDVDZG9iM2ZCeU1WZENIaXhq?=
 =?utf-8?B?V0VRZ1pUQXhPU0xMRGZCc2FmenBqMnVHSXpuTDBQMzRQeCtXdUpndUxQTjZn?=
 =?utf-8?B?Uk0veENoMnNCRzdaTHVWeFFSK1FuNmkrR0pSbE1TMUF3VmZ6Vjc5UjI1a3RL?=
 =?utf-8?B?QkRjU3BNWXZLM1hXb0ZZeFlDU2xObXRCRnNaQ2xRK2lPMUo3SzNSTnBNYmt3?=
 =?utf-8?B?Zmc5aml2aUVvWHkrMElaQzd5NXNxdkVueTU0MXlmN1gvUngzcGtoVkVJSnk1?=
 =?utf-8?B?WGFVTUVGSExNSlJqRkNhaXpBZFRzWll5SWdhME1pcnlIYXFTVmU4c05yM2RO?=
 =?utf-8?B?bklnZkdyS0JqYS82dUR4WWFDUGRVaU92NlB2SGxKSlhNUWxHREdLbGJoWXp1?=
 =?utf-8?B?TExKNG5DemxPWnpkanRaek5vdnhjN1FxTXptb25ydmtOV2ZwQ3JLOTRCU3VN?=
 =?utf-8?B?bDY5N29tVVAzQWluUk5qbnBndWNqUGRpTUQzU2JhV3h3eG56cUJhQUZLbEZy?=
 =?utf-8?B?NGZjazJVNjNrZGdSRmQ3OUN3TUFIUE9FK0hMYmg2TjR2QmVoZnRQcGk3YXZw?=
 =?utf-8?B?TkR2TXhYc1dJbFczSE8wdHFVYlYzMjlDRUlZcGJJRmFYQ04zR2ZFeEd3emFv?=
 =?utf-8?B?Wkg4bVZDcmx3QXdKKzFkWEltMy9MUXh6blZFN3hVWU9qNDM5M21qWjkrbjcv?=
 =?utf-8?B?RllMeVJzY3Avb2l6TVMyeG9uMmo0dld6ZDJ6bUNHMFZyRm9uNlFoeC9SZTh1?=
 =?utf-8?B?MCtBNXV1V1FUNndnNitYL09vMjEyZDRzZXo1ek16bXlGaUFpQ1Y2UUNqZGox?=
 =?utf-8?B?V0paRTBOcmRXQzFWNUptaUJSWG1Qdnh3TjAxM1lYcFhpclVtN1VSMDJzTHlO?=
 =?utf-8?B?YlNnSkVSb2JVQktpTlRvS1VYZVpGOCsyMEtvZUVSV3VvU0l6UFBmQ0dVZEtI?=
 =?utf-8?B?MGUvRWg4T1hPQkVWbHpGdlEydXBWZUVSM3ltSmwxYUVxRk1kM2ZYb2wycGxK?=
 =?utf-8?B?MXhlaXdSeUdaMGlPdDFkbG44ZW53TWc3WGpaLzdPOXE1cHFNM29sa1IzSUhI?=
 =?utf-8?B?S0lTellSazREZG12WGJEaEY1aUpMMHpjYllaZGZSWkdIeHI5TFZoT2xxaHMx?=
 =?utf-8?B?UnJ5cFE1b3g2NmVXTitGRmpRL2VGdTF4aGRUbWV5cnJScnRZcEhkTVg0UmJh?=
 =?utf-8?B?Uld5eFVVSVVRNVhGaEVHaHFpMytrWkZqd0VCRFdOTHhKOEJYQ0V3cWFISVBE?=
 =?utf-8?B?MERoVENKWDdiQkJPVFJ2dnV4MDA4UEtNRVNkcWJrRHdxbytNQkpWQ2F2bHhW?=
 =?utf-8?B?eVRsL3hNejdHMUtFTklxSnBoMDhOQXBCUEF6ell4L1NXSjdmQVNIWkR5RDlV?=
 =?utf-8?B?SDYrNE1CZnhRY3pHSzFhd3k1dlRPNGZmUU1MUDE3Z0Y1RmxxVGJ6c1dkbys5?=
 =?utf-8?B?Uk1ZSEtTQ3F0SEVUZ0RTK3orZlpZaU5hbXNUVkF3eWE3M0JuaUh6akVPWS94?=
 =?utf-8?Q?VU6+OuKWmtlP09VqFJa/KBLcDhuktrOt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBnemhKeGRHSDcxMm9rMytUM3pWQlljM2VYVEJLWDZFVTVIRStqb0R2RWVN?=
 =?utf-8?B?c3VOWDlpY2RiSjFFZERaalFtaTZqdnk3SnRYMmkxaHlHZGNHcWtzdCtFRDFw?=
 =?utf-8?B?RWx5YlBuMFRTcUZRSXFHMlAvd0FyUnp5UkJhNVhBdXdJbWZncSt6bVN0TjU0?=
 =?utf-8?B?NExJMjJkNDdhZTd0QlMxSnRaWjAwVmlrRTJSQnBUODdzOTRvbjFCR2pVWXJV?=
 =?utf-8?B?RTNLTG55Y1BYTFBoUjh0ZHEyNE9pbEdFMkVvVTZrQUxsQkRiczVYdVZHSkM4?=
 =?utf-8?B?ODBnSzZCeVUvck5BZVZndC85Qm1MdDdCNGRMb1kvZTVlNVd6Y2FGRmNFY2s5?=
 =?utf-8?B?RTkrWGg3QzJ6ZEpBV1p6Ri9WYTFxNHZIaTl0eXM4YlB0VnIxdUxTdlRVRnEr?=
 =?utf-8?B?MHdqRVVtMG1qdnUxNURIcmZ4d3NDQXVrN3lnd04xWjhDRkUrU1kvY2NnUnND?=
 =?utf-8?B?STcrdXo3d3o4OFhrL1NPbEM3dGFCUkphclQxbzl3dTRpYjBaTjB5aUdxME15?=
 =?utf-8?B?ckx4V2cwZEw3S1AvU2VlYWk3YTEyRUs2VkdRbEZyTG1RbTErL1B1alJaamVa?=
 =?utf-8?B?Wkg0T0svRUpFWVJlOWtUbWxKcXpCK05oMjk0NkYrUFdQT0VCNG1BcmpGL3J3?=
 =?utf-8?B?cmhXd1pYTnhOdW5IWHlPQ1dMZzNwS2tPRkV3SVRhVFN0cFNNWVc4V0pZZUxT?=
 =?utf-8?B?L29lUXZEUENVRkhldTBiWXd4SkIxZ1Q4OW9qTXZiNVRxR2FJczhwU0ZxM3dt?=
 =?utf-8?B?SmdKUW0wUHFOOFpyVUF4ZjhVMTVFZ1VDZTBSbWFJUDlKZVNEQzlhWHd6QnFZ?=
 =?utf-8?B?dUJrR0pLcEJVbHgxM0J5a0M2ZEdsSkJOQkxoZE5WUDV2UWppV1NLcnZna0pO?=
 =?utf-8?B?Q1ZPMzc1K0UrOTJ0S0NXNUxoSlJlQW1nd3lHRElFWjBpNUJRUjV4TnIvZDFq?=
 =?utf-8?B?NDQ3SlBVYjJYb014YnNHSDlmZVREaFJPemhoMDd1NThaNmVoRzlzVmxna0p4?=
 =?utf-8?B?M25uMHJacnlRcnZFOFpreWRsam95akowREFxZVRnWFlqVmM3UDh3K1FuVU0v?=
 =?utf-8?B?ajJ2SVgwbUp0YlpOdGpObEkxOXRzbmpQK0RGSUZPQW5lVlRKUDcwelErZnM0?=
 =?utf-8?B?amZvSkdPRklFWE9FSkZGWk4wWGd1eWJNWnVDbko1RGxuUk1BUTVFRjN1VDZZ?=
 =?utf-8?B?Y2xTcXMrdEEwRy82TWY4L2x3V2RqdWVaMVp6KzU4U1d5SWhUSU5tUC9hWGoz?=
 =?utf-8?B?YzVoYU44U05MbE83b1FGMmQveW0vNHU0TDE4ZVZkQTREV2EybU54bU41NEZT?=
 =?utf-8?B?MDR0c2ROQWI0UFVhdTAzL0JjTjZlUnZtWXc4V29mbk9ZaXByUzFFVDVxRlBy?=
 =?utf-8?B?d2w2UlhySklnZ0dFZzVzWEI1NkdyeG1wNnFoc3p1VmY2M2duaFRnRW1WVW1l?=
 =?utf-8?B?N3liWjZNT2FJdGliMDg5ci8xZ3pLMlBCMzVoT2IzenZ6MDVqbUJLTnhSQVB1?=
 =?utf-8?B?SmpmcnFVcXZzanVXVUxLR3JaelovaGdmOGNPcnA3MEc5RVk2MjhqMC8vNHJx?=
 =?utf-8?B?RzJ5eVZwdjZ6aWtDQ0lsMjkvYWROTzhDM2FxNHZ3eUhJdm92djJja0lqQXZn?=
 =?utf-8?B?OVdVdHkrb0MxM2lmZGtoMHVUOE1haGhFTElmKzNaVXJnWURqeXBPalJuaDRE?=
 =?utf-8?B?Y1NDYm8vVit0dHlPWnZodDdDT2hDaVhiL0tNeEZ1OHBRNys2K1R5M3NEaFo4?=
 =?utf-8?B?QnJoQ283QzBGSGU0LzRnQVVjalpTS0lneVNIREIyRW81WHQ2aEp4ZkpCZmdh?=
 =?utf-8?B?Y1MvVXh3bWo0amxlZkVpVTBtUGdIcTNmNkljLzUvaWtNV3Ivaml6N2hNT2hF?=
 =?utf-8?B?NHMySFRZTXdvU3RZOUVIbFNNOUJvR1g1elAxV2lQNXZxYVdyRE9KbE5uWFBE?=
 =?utf-8?B?dzU2MHhFSk13bGhHZjVCRU5EMXhTTzlTREFQUUkyWi9UQzhJYlBIanpURGN3?=
 =?utf-8?B?Mm5KdFd4RGRmZkNmaFlZMUk0bDZLUjhCaUpQOXFkTExrekhOWXpsNVNIc0xl?=
 =?utf-8?B?OGpRcUxIb01EWHVReHZKTSs3amZrK2xpWlYraTNRb3Uzb2MvZEdpMDVBa1l2?=
 =?utf-8?B?STlDWU12UTdEUVFTSTFhZFZqVytHdWRYeDFKcjFGdmVqaStyWkt1QytIM0Rx?=
 =?utf-8?Q?mnabbhKXmgkzNwqF8SCwZZg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F6v53IzEQrKlI2KuROo7NS3+V1yc/frkFlh9u8dfHNw9ylFUbTDMQuuT+jmPwDsvKdEpZv0Ok6aqo/mfh216Vww5tXdi/yoFMdrj6lDfLiOMpr03zWyqQ8sQsJXTVaqhkF65iw0hbgPAWiAfUMiqXw3v7sHZy1MGiX6OjZsWB80H2l275aa1XX421+LRq8WoLBaQukSm2zCDzJI6Y+PLCimEdpW11WICSZHA+x/Rs4R3NboZ3yJqgQtTnZOvO/GYpLDPRXBj6+DM3Bon/Tymx08i4Srf7es1+mdo7IMKfgGYrsQ2EuqeJ0ujLFbCL4szSBgqQjDs0/ytkCdW1MppfVKK905wktkVWlsWLy+NINRPlv7azxJ/vQmZWENPjTmWGkGae9NWZHsN6LarX7DDM1SDP7QsctpZ3v1JCHhWg43T1XL4j0jbJ+FM4MQ3XZXJU09ZHrUecdRYbmipEJeDFwwhF6MdWQpPyS2r0pTcE7QPzHiJfLo+BXYOOtrTYEvGkRPtFGH2l3Q9J8blNjAhHlnv4YPDUmC8p+7mxSMAYY+5hdKoZnqJk/v32axC8CMSYcBok+vmaI58TVNWXCg42MWSS96wOWdi3juZi85kcxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676b7785-9cac-472f-cfd6-08de291c2bdf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 16:36:50.7091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CjVXxYUbaR8/UfCWk8zoZ4iIAoJ5cYM6kw1rNPODD5ojHKiAjJQko1ZljN7RTE9dcALPNEnL+gr2a6bhRc9tLR2PdODEQu4yNr5SsIShtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210123
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=69209528 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=UvJYUAcIRtX6ouBY6RMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13642
X-Proofpoint-GUID: Gs_bjci5vHeaV3uk-3QGWT21d6a-Wm8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX4D/ju65FvZsq
 trmlX47tlncQG77QwwkYIN76qEax2kDN3lp7JJVwocSGBoxUPwhliPFufaJ8WUF8aiR4B5hVzen
 a/e7+gpMUfb+eoLVXsPLF+G2cdzmUBnbJHbIZUzBQRBQEa5O2K7mdcd1YXDIchT5gKituzek/MK
 6IQe69hZyg9R5BqGrad0TPSUbOzhE1Kgzk4uXFvFnn2qKch/LOAcWF/m71m0abrBn3BwvOshILQ
 ZCsM22qjDjlq7WituXUwZ7tXxqLaW+4l+B6yij2ODMHZH/OkbXB2DlGXewIM1YdM7P4Ege6Djiw
 dmu3r27NrUL9DWgN0PZ27k3asSzbEeDX+QNdCCWHDLflzLS0QYhzP0oJ7gqN32aJEDVKV9AHbTm
 TaSDboBnhHsJU/OGq65scnE0VQM7+ari3ylmyP4mI/5sEEHp4Fo=
X-Proofpoint-ORIG-GUID: Gs_bjci5vHeaV3uk-3QGWT21d6a-Wm8T
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 11/21/25 12:20 AM, Sairaj Kodilkar wrote:
> 
> 
> On 11/20/2025 7:01 PM, Alejandro Jimenez wrote:
>>
>>
>> On 11/19/25 11:43 PM, Sairaj Kodilkar wrote:
>>>
>>>
>>> On 11/20/2025 7:06 AM, Alejandro Jimenez wrote:
>>>> Hi Sairaj,
>>>>
>>>> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>>>>> This makes it easier to add new MMIO registers for tracing and removes
>>>>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>>>>
>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>> ---
>>>>>   hw/i386/amd_iommu.c | 76 ++++++++++++++++++++++ 
>>>>> +----------------------
>>>>>   1 file changed, 39 insertions(+), 37 deletions(-)
>>>>>
>>>>

[...]


> I am in favor of this approach. Will do this in the next patch version. 
> Could you please provide your signed-off-by ?
> 

No need. I suggested some adjustments, but I think your original idea 
still stands and Vasant's R-b still applies (unless he has an objection 
to the proposed changes...).

I'm still reviewing the other patches in the series, but might not get 
to reply until early next week.

Thank you,
Alejandro

> Thanks
> Sairaj
> 
> .../...


