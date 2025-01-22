Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3019AC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadNM-0000kt-PZ; Wed, 22 Jan 2025 11:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tadNF-0000gR-30
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:14:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tadNC-000802-C4
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:14:36 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFfv2G000500;
 Wed, 22 Jan 2025 16:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=OHas4+rna8voMtOtz2y46nfXawnyJAm/wKfXHAD+0q4=; b=
 dMkytC6deq3KnZkIJ2cOeGLF9O91YqnrLwngZfzbR9AuJgObnFjD9Ghex1y0UvLh
 dj9CS6r+SwKzZs4pSbCRkd3EXQrwFT+OtADJktOmpuH2JIwT90Jhq0bpAL0bw2Nf
 zmxFkY46T9mtDAn8O1fTypPc/8K+5mKqI5D0dHkujB018YA7PdgM3dnbEHwHKt24
 i+ok3x5Ghl89gPBRZqQSDaOWw7tVHZFPH05To9Yicvmf9vzMDbgKf4zVueDOQ3Iz
 8OchapCwEQ9ZxqIBUAAlku9p9/yqwQp1usTmgChkEV6LpecBL7anfq0khUqQQKAv
 ZVqNCkoPjG9KiEq+NpGAew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsfysu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 16:14:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50MElVQU018787; Wed, 22 Jan 2025 16:14:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491c3tr0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 16:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZCOE6oSpLi4nCyJ0Gur9mvB2T0inljCMwqHjUrbvLD4lyWtys0Vf67AAEz7QIpKlCJJRpXT/2Qk2u8Y3KXYFKSpI+1kDSarYvdlGkDPllperegT8eTGTzwUyqQLgoff37H5dnkbU8TRmpO1d7ChhoWUGrsYvwd1rbN3WS8s5kQZa6EAi0tzI8DO6+/rW3Vt0mOeZor17rKqU5gsshithQumx6gGWT0qesnX82GqluGxj8qGRfCOnPDmtc2bLD0GS/OzwhsXjdXntKl1M3gliFIY3XaXLCdfSPFLUEkKbn4uUmavdqbwhT3mngcANcFtkUpJCygjAACr+IZ9tPeoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHas4+rna8voMtOtz2y46nfXawnyJAm/wKfXHAD+0q4=;
 b=nC5A1u6r7+RDWnQoRvg6q1GUTNWuNh/Mh1FEqtTeBU5oLbQO6EsaZQN3a3Z7qPfV6RyMh1X0291f/qtdtkPfp9YZW4MUiILK6jNrPzy+O4LaVFq9gE0Bi0b67yVRvGkVVF7unJQlKNnZIjZYH75ZvEzecSrIsy6WKFDSLqdEHkXrX8EWaGy64tXeRt/q8L6V2mC2QDrR7WkEIHK2ZV5C9ypbXrmSPCFZBg6epxJzKuHmXb0rwSLP52tl33pSaYu5/vHEWgIodNZcCDMR87/Fak8xF/iHZmVZ8pZkaJVTU66J3LKrbRnXEm+vOKwPZ7SCeaSt9XFZvtnvNiNnho1JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHas4+rna8voMtOtz2y46nfXawnyJAm/wKfXHAD+0q4=;
 b=I9ZMTXHEsXHq8AjYXOuHjJ8k1OxK8xqlJq9rnDGEXIfD72UPI8K0mGSTFetLGknlNLjd+KJuPe8NmTaUGJx+v1MyIeUwCjNrNpi0ymE+pnu3syr0qYygUZK6Cr0+VAsQZ3Ks7ac3G6Uhp9j8UlU9XGNXjVmSfodUuWZW4kvxZ+Y=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 16:14:27 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 16:14:27 +0000
Message-ID: <cb8d06e2-b84f-4ef5-ae37-0c06bc028a18@oracle.com>
Date: Wed, 22 Jan 2025 11:14:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/5] vhost-vdpa: Decouple the IOVA allocator
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-2-jonah.palmer@oracle.com>
 <CAJaqyWc-ygnHZmb-aLBG9Hik3v9PbBsnFMdrxXTmGMxsMB+ZOA@mail.gmail.com>
 <74eee431-a6b5-4da3-8a5d-344a3401a288@oracle.com>
 <CAJaqyWfx0pbSzDE=taJm_OOCw_ijhu4naDYpeqB0s7zdPP+CGQ@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfx0pbSzDE=taJm_OOCw_ijhu4naDYpeqB0s7zdPP+CGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::21) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6cd510-4f8f-46d9-e8e0-08dd3affd80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmJZYXcrL3pVM1hidnphTGh2YmEwUVZZU3RWdlFGSk5henBmeWwvaE1NUkVX?=
 =?utf-8?B?UFJyV2pINUlJclRQN1R5ZmphTkZ6c1ViN2hDNFo4K2RtZkszc1l5UElrUmdT?=
 =?utf-8?B?NzVIeHNoWUg0MEJtVEVidkNTZWtXdHhuZFhYRk5zUnVnYU03Si9abzBEYStL?=
 =?utf-8?B?Ymtndjc3T0hKM29CQ2I4SURPQ1FEWVBkczJoOVF3NVdYL1FaRHZrYWJoSkZv?=
 =?utf-8?B?WDQxTENOVVhXZ2NoOUlZUVRuMkFESFlPbkRKRUZIZFcyVEFKWUdCa0N6ZWlu?=
 =?utf-8?B?UmJPWGREVk1PWHFuZ3g2L2VaNXVXVzlIZ0k0YXB0UVhLVGowNHI5V1R1NVNi?=
 =?utf-8?B?SmplMmdDQms0NDc5b2pPd1FGTGFhMkQxQ3VzOVdKakFsZk5JWVhvTFBMYk12?=
 =?utf-8?B?QW1SZkVqZFZDZVZTVjF4VGFFU0ppSVJSc1pOVFhmWE1aWFVqbFVWdlhLdUdD?=
 =?utf-8?B?bGFVMkFFbmFmZ2FvUUhqdytlZHNhbmY0dzJzbERrcWpQSUdXUTgzemE0b1JZ?=
 =?utf-8?B?ZkRib1l4N3ZFb2dQY1ZRZlg3SzduSHR0ZW4wNVh1cy9Xd25aUzhNV2dnTW9z?=
 =?utf-8?B?YUVSbktOb1pFRkVXc0cybUpycUY4YVdqd21rR1hSYi9aWXVSTU5Jank2K2Fh?=
 =?utf-8?B?NkxoV0J2V2Mvc1REZnVlMGd4bXlTaUU4N1dKNlJTaWJqZ29GblFiRU9VSWRE?=
 =?utf-8?B?dkE3SkljM0dTUXFZYkErL0lEMmJrQ1luRmtBOC9lU1ZYeHVMVFQwajF0TUlK?=
 =?utf-8?B?blVxbStHWVArdVhKbG5tclhWNXBsN2RHVFdTNzMreHRqSEQ1WVJ0OWZUckxU?=
 =?utf-8?B?NnpNSEhCVGJVcHV5SDJmTXZ5djFBY0Y5d2JjS2ppZHNDbG1qaFhPVmhvYUQw?=
 =?utf-8?B?TGNKckgzeXUzenNEY1EwdldCM2ZZTk9jeXJteTd4em4wZ283YWtWOThBRW52?=
 =?utf-8?B?OU9KT2FMeTc1NHkzTVp1cnZ5UGZrbU1CSlYwdGJKeVYvQVFRYU5jREtOaUJr?=
 =?utf-8?B?WXpERExHam4yVGZocFhRMHllK2xPNHFCMlU2QmtCNFB0OWxkNCszTm53VDgz?=
 =?utf-8?B?M3NpZGc5Z3dNNkRieHdSSS8wOFkwcDUweUdHclFNVWhKVnZ6d3NHWTRYVTdR?=
 =?utf-8?B?TE1qUE1sNE5VK0MvMHNBTVo2WGVvcFgvT21mOXE3b1VEMGo0Y3A4YnRBSWhs?=
 =?utf-8?B?Q0duOXF1OTFlcmtaa1dWcmlIdmlnN1ZhQU9ySkFBMTNJZHpFazhLZ1o1ZDFM?=
 =?utf-8?B?cE1yeWZKYlFNRFhrYzg0UE1sQ3hqZ3g1TTJTV2MxY25SUTZkaFhDUHVZN2c5?=
 =?utf-8?B?Tm4zY3QrNnYvdEFRNVRaQmNCSnpCN3BlaE1iY0Q4M21HZzNVSE5ad0lSNGth?=
 =?utf-8?B?NXBvb2FIUDEwK2N6R2JGR2FyOHB4ZmxTUDRwa0w3b05aNXZ5WkRnZVI1Z09B?=
 =?utf-8?B?ZkJTS3UrclBMQ3RwbjNLT2d4Ty95NENzdVRCWXZORHo4YzlOcUZTdnVXeUx5?=
 =?utf-8?B?RWJNTFRXUU00ZHUyT2sySkNHN3lHR05ldXJoVmJRQVBIazN3bGxRbmNwRUFl?=
 =?utf-8?B?aUUwSU92OG43dEFMUkJqdU0yQytneVNyRjZDeEJzTnVETE9NWkhzd21qc2NQ?=
 =?utf-8?B?enkwdXI5SnArTm9NWmtINzl5anNnbjZrdnhRT28vUzd3Qkg2MkJ3clZpZG1U?=
 =?utf-8?B?MEIyd2VVZjFTUUFFQkZycC9LSDVWcXNUR2djeXBRbU00VzJVaUFKK0FNNGNT?=
 =?utf-8?B?dFhiK3lBN0Nhbm9NWElPUEpaYkRDQytsQnllaUplektjdlVFYzdUUUxScW1r?=
 =?utf-8?B?YkNtQTBPK29wRlNLMmZTMDFpODlNN1Z5U0ZzNUlDVVFOeTRmQUh1VVQ3Ykw5?=
 =?utf-8?Q?5SR11i+rIy5QQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01HY2ZWTi8vaS9vd2FKUlEzOVYxdEVreS82bFVXc3dQbUtkWTVtaWdHZlVk?=
 =?utf-8?B?dUNWWWo2d1drdXBERVA4ZEk0Z1d0Rzc1QVM4ejFFZGtNZ2pKQ1pOOUhkWTQ3?=
 =?utf-8?B?cEV2aFZuYzd5UFRucHc0YXZ3QnN5VkJYVGk5SFR2aEk4SHJic3lTVHVqU2hS?=
 =?utf-8?B?OENEMEs5WTcwb2xKWmtBVVVlYVYxbVNoZndidTZFRFhLeER1d0VESTJYcWVC?=
 =?utf-8?B?eVh6WHdHQm9Ea0NGQVp4c2RVd0Y0UVpTSGtZNUtMY0NpVVBva1ZncUw2L05L?=
 =?utf-8?B?WUhhdVh2WUY1c294elErWWttV1IrS1V5RWFLY2d5ZG9Rblc4Z0VjUVBhdUFU?=
 =?utf-8?B?R3N0VXVWVHNucHl2YXo4QmdpdkMrTTFFaDZCTmErYzRHQjZFVkljd2ZnZWd6?=
 =?utf-8?B?MU1rNU55SjhMQjBpQ1pyWWdWMUFZYjRiM0pkM3ZKRE04KzJKZmo4eFpvNUlm?=
 =?utf-8?B?MjN5dllScW5iNEhMWURUMjZlMEhUTmhtYWR6dGxoTmVjbkRFVU9zREU2WXVX?=
 =?utf-8?B?Tzd2d1AvNmNIZUV1Vzlrd29IYkd4N1MxbXF1S2xpQVNabWR5T0JnSnl2ZVJQ?=
 =?utf-8?B?VEFNbHppbkgrSFk0RVVUSm51a2ZOR3p5SUtyaDBZOU5lVG5vQit4TkRwenZZ?=
 =?utf-8?B?ZFc3TzYwV3YreE1wbmMxc1gvdlhKS09yQStyTkFMSDNHL3djQVlndG9POXJC?=
 =?utf-8?B?VkdYU051Mkk1Q1dkSlJoNEYxOEdsc3c1T3Zab21ta2xLRXNGdnhmR29qTldm?=
 =?utf-8?B?Q3ZEOXlIRGtjNTloZGFCcVpLY1M3VTJSa0ZLTTREUWhYbnE0V05yZ3VqYktR?=
 =?utf-8?B?SXQzaXhFZHJtdE1PQTFYWk1aZkFtNmkrbFhsVDdNbFNtNThaZVhDcHhvNE5W?=
 =?utf-8?B?cGM4UXJzY0tJbEl3NFJXUjZNSkNGRHJDb3Yybnh4TW5nOThKbHJ4UjJxSkp6?=
 =?utf-8?B?OG5kWHpkQXlvUWNyVWd4UGFLZVMyR2lCTlkyemhjVjltK3dORWhIMS9UWXVO?=
 =?utf-8?B?V0xTR0ZUd0pIaEt4T3E2ZTBhMFNKRDcwdzZzbWd4OUJCV3JJUGVWcC9JK3c4?=
 =?utf-8?B?azNzMkcrdWF1d3pTTjlEcDdVbUFIMHB1YzlwSDZvM3VEVGZEQURhN1VlS2g0?=
 =?utf-8?B?THlXZ3U1VnNJeGVab3FHL0RHK1ZYSnZmWC9WN3cwZjVjVkEyVDZ6MW42aFhx?=
 =?utf-8?B?OGtBbHBCL2h5SGdzZlY3K1pvUXZMaSttZFh2eXN1VXYyVHdkTXBmWjA0Rldo?=
 =?utf-8?B?cDlHQkFyWVZ3S2lwN3dGc0VCSTBtemNLaFphTlBTUUdHWXRPS2ZOcUVNbGUv?=
 =?utf-8?B?KzN1M0dGOUw0clJvNzVpbktUdTlrZ3p6OHR3SEFKZzBNTDBnUzJ0ckFoRWpC?=
 =?utf-8?B?dEl5YzRVN09sZVlEK2YzZzMxWHVaWmlESnVUUHhtWGZ2SFBqd2NsMGpQMTVq?=
 =?utf-8?B?U2ZnTnhyNnFjbEIyTXpMWlRRZFdrMitTNXdFOXlDK0lHL2txcXJFdThvclVp?=
 =?utf-8?B?b2dmOHJXbFRyZmVGK1ErTWhMdXl5OUh6NkN3WFlqTnRXZzN0UExJZGtVOUJG?=
 =?utf-8?B?R1JHaVFzb0NrRG90UUtKRjZKMDZ5cUJBMWVrQ2lZc05McExySzMwOTE4a3FK?=
 =?utf-8?B?UGJlV3R4MU9WOWZPbEVacjRHdTlnVmlVVFpaZnlaTFAxZ1gyODh2Z1lnbWE5?=
 =?utf-8?B?QVp2RkhkaWhuOVFocjF5c0FEMy9hZEoxRWQ2SmhHNitQTzBsSTQzNE1sRkNr?=
 =?utf-8?B?NzAwL2ZMOTc5ZDNkNlU4TDZaY0JYbmMzLzVWSEl4STBaMktrOWM4cW1HdFBK?=
 =?utf-8?B?ZE9uTHo4a1BKazM4N2FSNTJKNUZJT1VZcGlkSk1zTHc2MmM5bENySU9BYU02?=
 =?utf-8?B?ZmdXczVGRExNRU1LWVF4Nm5OL1hMRU5TaE9WMHVZZG1KSm1OMUx1LzRLYlc2?=
 =?utf-8?B?WlpoazJDRFlMYUZuMi9URzRJdzZlVENDNkQvdEJ4MHlPVVplc0hjWEJrRmha?=
 =?utf-8?B?RGRkUlNGcER0VlVycHl5N0JxRFkrZVpWOVM1ZDNDd1BNQ2U3M0xlNWRCcTBp?=
 =?utf-8?B?MVFQeWM2WUMrV0prdDRYRldaUmxITFp4RTlBejRLc29aanhEcWxOWENlNlVT?=
 =?utf-8?B?eVd6TXJZSjlELzI0ekpaYW13UWZHV05FdS9mbGhOcmpVMm9RRjR1Z2YvNHcx?=
 =?utf-8?Q?MtV2rIWRm5ukQN+iDol5DT0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VJpvpegRjMD0iCx7fBem0AhGSR10fYJcrSDjHk01T7VWQGoE+fofdnldDGO228LqDBXN4gWKnaOOqX7B26Xao6DL25QuBq/unBImE88rM8M8UlEsc5s1zixljtTStjqdjWEe6+jj8GUvKhS95CzbFNkGvQV6uYir5+QKbG+TpdAZFv6UbwMjjc8ckD0xr6Tu2twHNTIqoUTljiEpt5sdJzEpoeMmJy6uVHiWhMbeA61gQyZZPlH7/owg1lAuOR4EuXREJuBRQeB7t08Wm9/V5h73DKeMApmn3H/DX0XJSndTH0jQM9EmGKcPR+7Kye6yy514ZBzKzymC3W1h9qFnhCcb1sNJn0zy25QC7zyh40A9XHq/Vg7wfzriO4884AhT+rTi7Wsif1CMUBy2N9oFGpZAetdJBBLxLnQAdxAUGZgvP8BVuUTBV0xZr1m/E4tPot7lUu2ao5LE7f914VT+ma5HoHLc8/USM1sGUUGhEJ/rhc5dYWtb+yhqmb33IHXVzS+kypY+leEOKLB6BxJs9yQ1MSFD5/4Jm2MEmt5WM2oVGndSi/qxO3ObvaAkwWNuWftPtAWBMxNkT8WUSvgDWC03Vs7Dk08f0ouFbHOZjYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6cd510-4f8f-46d9-e8e0-08dd3affd80a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:14:27.4483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrgTG2ojt7kMK/n51p58XESpS7Co/1ZGdD8Ca0bZysFh01mQaNvvxk/n5r7ndb2mgj+pb5UCvUZUuaGqJUtSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220119
X-Proofpoint-GUID: mcI-STp4mtE0_dsYWJTiXHGuwRXZSyg0
X-Proofpoint-ORIG-GUID: mcI-STp4mtE0_dsYWJTiXHGuwRXZSyg0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 1/21/25 12:25 PM, Eugenio Perez Martin wrote:
> On Tue, Jan 21, 2025 at 3:53 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 1/16/25 11:44 AM, Eugenio Perez Martin wrote:
>>> On Fri, Jan 10, 2025 at 6:09 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> Decouples the IOVA allocator from the full IOVA->HVA tree to support a
>>>> SVQ IOVA->HVA tree for host-only memory mappings.
>>>>
>>>> The IOVA allocator still allocates an IOVA range but instead adds this
>>>> range to an IOVA-only tree (iova_map) that keeps track of allocated IOVA
>>>> ranges for both guest & host-only memory mappings.
>>>>
>>>> A new API function vhost_iova_tree_insert() is also created for adding
>>>> IOVA->HVA mappings into the SVQ IOVA->HVA tree, since the allocator is
>>>> no longer doing that.
>>>>
>>>
>>> What is the reason for not adding IOVA -> HVA tree on _alloc
>>> automatically? The problematic one is GPA -> HVA, isn't it? Doing this
>>> way we force all the allocations to do the two calls (alloc+insert),
>>> or the trees will be inconsistent.
>>>
>>
>> Ah, I believe you also made a similar comment in RFC v1, saying it
>> wasn't intuitive for the user to follow up with a
>> vhost_iova_tree_insert() call afterwards (e.g. in
>> vhost_vdpa_svq_map_ring() or vhost_vdpa_cvq_map_buf()).
>>
>> I believe what I ended up doing in RFC v2 was creating separate alloc
>> functions for host-only memory mapping (e.g. vhost_vdpa_svq_map_ring()
>> and vhost_vdpa_cvq_map_buf()) and guest-backed memory mapping (e.g.
>> vhost_vdpa_listener_region_add()).
>>
>> This way, for host-only memory, in the alloc function we allocate an
>> IOVA range (in the IOVA-only tree) and then also inserts the IOVA->HVA
>> mapping into the SVQ IOVA->HVA tree. Similarly, for guest-backed memory,
>> we create its own alloc function (e.g. vhost_iova_tree_map_alloc_gpa()),
>> allocate the IOVA range (in the IOVA-only tree) and then insert the
>> GPA->IOVA mapping into the GPA->IOVA tree.
>>
>> This was done so that we didn't have to rely on the user to also call
>> the insertion function after calling the allocation function.
>>
>> Is this kinda what you're thinking of here?
>>
> 
> Right, I think it makes more sense. Do you think differently, maybe I
> missed any drawbacks?
> 

No, I totally think this is fine. I can't think of any serious drawbacks.

Will do in the next series!

>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/virtio/vhost-iova-tree.c | 35 +++++++++++++++++++++++++++++++----
>>>>    hw/virtio/vhost-iova-tree.h |  1 +
>>>>    hw/virtio/vhost-vdpa.c      | 21 ++++++++++++++++-----
>>>>    net/vhost-vdpa.c            | 13 +++++++++++--
>>>>    4 files changed, 59 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>> index 3d03395a77..b1cfd17843 100644
>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>>>>
>>>>        /* IOVA address to qemu memory maps. */
>>>>        IOVATree *iova_taddr_map;
>>>> +
>>>> +    /* Allocated IOVA addresses */
>>>> +    IOVATree *iova_map;
>>>>    };
>>>>
>>>>    /**
>>>> - * Create a new IOVA tree
>>>> + * Create a new VhostIOVATree
>>>>     *
>>>> - * Returns the new IOVA tree
>>>> + * Returns the new VhostIOVATree
>>>>     */
>>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    {
>>>> @@ -44,15 +47,17 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>        tree->iova_last = iova_last;
>>>>
>>>>        tree->iova_taddr_map = iova_tree_new();
>>>> +    tree->iova_map = iova_tree_new();
>>>>        return tree;
>>>>    }
>>>>
>>>>    /**
>>>> - * Delete an iova tree
>>>> + * Delete a VhostIOVATree
>>>
>>> Thanks for fixing the doc of new and delete :) Maybe it is better to
>>> put it in an independent patch?
>>>
>>
>> Sure can :)
>>
>>>>     */
>>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>    {
>>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
>>>> +    iova_tree_destroy(iova_tree->iova_map);
>>>>        g_free(iova_tree);
>>>>    }
>>>>
>>>> @@ -94,7 +99,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>        }
>>>>
>>>>        /* Allocate a node in IOVA address */
>>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>>>                                   tree->iova_last);
>>>>    }
>>>>
>>>> @@ -107,4 +112,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>    {
>>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>> +    iova_tree_remove(iova_tree->iova_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Insert a new mapping to the IOVA->HVA tree
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The IOVA->HVA mapping
>>>> + *
>>>> + * Returns:
>>>> + * - IOVA_OK if the map fits in the container
>>>> + * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow)
>>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>>>> + */
>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>>> +{
>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>> +        map->perm == IOMMU_NONE) {
>>>> +        return IOVA_ERR_INVALID;
>>>> +    }
>>>> +
>>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>>>    }
>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>> index 4adfd79ff0..8bf7b64786 100644
>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>                                            const DMAMap *map);
>>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>>>
>>>>    #endif
>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>> index 3cdaa12ed5..f5803f35f4 100644
>>>> --- a/hw/virtio/vhost-vdpa.c
>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>> @@ -1142,18 +1142,29 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>>>     *
>>>>     * @v: Vhost-vdpa device
>>>>     * @needle: The area to search iova
>>>> + * @taddr: The translated address (SVQ HVA)
>>>>     * @errorp: Error pointer
>>>>     */
>>>>    static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>>>> -                                    Error **errp)
>>>> +                                    hwaddr taddr, Error **errp)
>>>>    {
>>>>        int r;
>>>>
>>>> +    /* Allocate an IOVA range in the IOVA tree */
>>>>        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>>>        if (unlikely(r != IOVA_OK)) {
>>>>            error_setg(errp, "Cannot allocate iova (%d)", r);
>>>>            return false;
>>>>        }
>>>> +    needle->translated_addr = taddr;
>>>> +
>>>> +    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>>>> +    if (unlikely(r != IOVA_OK)) {
>>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>>>> +        return false;
>>>> +    }
>>>>
>>>>        r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>>>                               needle->size + 1,
>>>> @@ -1192,11 +1203,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>        vhost_svq_get_vring_addr(svq, &svq_addr);
>>>>
>>>>        driver_region = (DMAMap) {
>>>> -        .translated_addr = svq_addr.desc_user_addr,
>>>>            .size = driver_size - 1,
>>>>            .perm = IOMMU_RO,
>>>>        };
>>>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>>>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>>>> +                                 errp);
>>>>        if (unlikely(!ok)) {
>>>>            error_prepend(errp, "Cannot create vq driver region: ");
>>>>            return false;
>>>> @@ -1206,11 +1217,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>        addr->avail_user_addr = driver_region.iova + avail_offset;
>>>>
>>>>        device_region = (DMAMap) {
>>>> -        .translated_addr = svq_addr.used_user_addr,
>>>>            .size = device_size - 1,
>>>>            .perm = IOMMU_RW,
>>>>        };
>>>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>>>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>>>> +                                 errp);
>>>>        if (unlikely(!ok)) {
>>>>            error_prepend(errp, "Cannot create vq device region: ");
>>>>            vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index 231b45246c..1ef555e04e 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -512,14 +512,23 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>>>        DMAMap map = {};
>>>>        int r;
>>>>
>>>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>        map.size = size - 1;
>>>>        map.perm = write ? IOMMU_RW : IOMMU_RO,
>>>> +
>>>> +    /* Allocate an IOVA range in the IOVA tree */
>>>>        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>>>        if (unlikely(r != IOVA_OK)) {
>>>> -        error_report("Cannot map injected element");
>>>> +        error_report("Cannot allocate IOVA range for injected element");
>>>>            return r;
>>>>        }
>>>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>> +
>>>> +    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>>>> +    if (unlikely(r != IOVA_OK)) {
>>>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>>>> +        goto dma_map_err;
>>>> +    }
>>>>
>>>>        r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>>>                               vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>>>> --
>>>> 2.43.5
>>>>
>>>
>>
> 


