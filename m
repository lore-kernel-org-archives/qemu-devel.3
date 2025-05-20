Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7A9C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHN0e-0005jS-4K; Tue, 20 May 2025 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uHN0c-0005jF-Dx
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:27:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uHN0Z-0008HV-9X
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:27:53 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCttcC014951;
 Tue, 20 May 2025 13:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=mryw22YUQxm8yrnvI1
 o4qn/Ge3cvecONNqz8PXW7Owo=; b=X63uTlIYKo2UCKnpCZmbgUKvPRczeeJ5vr
 k+nFzZE7swRZDZWlHsz76k3c6t6bAyxEJZsw5RuajZWAmLwcjpZcC66M6MVdIL5G
 65ZS8fAvFCjSKKXEzrryXGKV+lBt07nKNs5SkO/p9g4DWk9Ni5XJyvD+QoWiX36H
 yglmvFnLOgJnuWH3pox+led52LXpvZlavFSjFdi69oNgQrrbPIexPKwTeUq5Gy2R
 lXBm1GmHmdfSlE66b7h6jY0WXpwbdo0nvJcz4XTnEvqeoy7JkNirP6QjPiz476Gz
 ZStfpcNiO2P4Q79pFzDP6Hd5uctKVVtHIB+ZvoXBoUnA1/oIcxIw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rshtg4s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:27:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KCYRPd002325; Tue, 20 May 2025 13:27:44 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw7rtc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPxHrBv28U3DVw2LokS5QmivUcYOf/9mWNWPex/mW45FpZni+Qn5GG4OVKxZPGSDsoc0KjajApTbbW/D2zfSVtLc3/FCI7zQMq4R/jBgSWDjOwUrIhn5VwF3R65za1GEEkAA+648XusW8oSabQRhJ2stDUORhyC5vTtyelqG4nt/mBT4MDCWcbOsEc4vxfrgQv8zLZIBbBt27HgyMW+0lihekyF/6vmTeyKiLEvedXxxGqZrKEq/IUaFq46vKlG5ExPMLzUGNE5Cv4j1o+hI1QpZetpaZfihhXsYj9ozok+kWli1DCLaG7dG8IYZ2BB7DYRfcOIfQukOvJQPSLuM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mryw22YUQxm8yrnvI1o4qn/Ge3cvecONNqz8PXW7Owo=;
 b=lxqn9XsYn8dAP/JdBWWaMzFErd3UAhZqe8MScaiRI6z5FSyq5fFmxe2HqI1mlTnRZTw5hJjcLosXHN1JwQzdUH3RFWV/6L9CnWZkDZvLf3g64lhsuljfhDT4Wf4OuG+zMbVh+F+WPLi1RHPP2PHxi2sLGioKyWWXHmW2pXJb+VcHaKsOSt3gRtKFcKS5FwtYF5xeo/54U+fPnf2fFv4uQn6Q4YWGoyrcIpbIx/Gc4UV+APiLzQ4nN04f0WfiZDdn+1jxKFCdwwzS6U9THTX6x+Lvqz5we6/rVsphZb7oie3xle06g4NBUAmyB6mKAdRwv1zm1W+CcAdB701f9pT+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mryw22YUQxm8yrnvI1o4qn/Ge3cvecONNqz8PXW7Owo=;
 b=fitR/UgN4hd/uPrTfiKt++UN9US/EiBdB08CoDhftm8tIhhPKundazRGHvEdo1LjianL/ivxNk0q5qdbwnqA5A6f7lU0VjYnSCwDi58mgYu1rJ5CLAIXZ9puUOIJimE3RO1ZjKwHNNqkSjuxSslAbMxXeQoIrwCbWqDawrRVgpM=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 20 May
 2025 13:27:42 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:27:41 +0000
Content-Type: multipart/alternative;
 boundary="------------i07I7LPUYt2peHYJrlNZGao3"
Message-ID: <6076b863-a52c-410e-bdb8-2d3f48cced7b@oracle.com>
Date: Tue, 20 May 2025 09:27:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH8PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f63a87-acd9-4e75-20ce-08dd97a218aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHp5Uy9OaVRLRDRXamdnY2RXNjRPdUZXSFZZOGZaS24zanFhT1UyY0VKMHlI?=
 =?utf-8?B?M1V2M0FwVGgwcXdOOVM5eUFXOWhIWVcxRjd4alZZVWJMSkRVeTJLNU44M0d2?=
 =?utf-8?B?V2U1NTZxU1RydEUzSVJMU29qNGVVQ05rNURQWlpXSXB2Nlh3V2k1TTM5dmRZ?=
 =?utf-8?B?RE1JU0RzM200OWJJcmFRMTM5V0paNVVFTG5jUUJia3I3Z2dnWUJFeHVFQXFR?=
 =?utf-8?B?eWFFbDkzc0YvYUZLUjQzbDhnNXZwYVoxN3JyM21UcERTcWNtWElMYkxtQnNW?=
 =?utf-8?B?T3NhNEVXaGh0WnZQeDQrNkdrN21TTG5PTTF6NlN1TUM0NjhBd2xaQ3VGaHpz?=
 =?utf-8?B?YzNVM1Fub1JGcldCUVVyRERMZTE2QWN5WWdYYnpIdUxmZlRYYk9qdFZkd0gy?=
 =?utf-8?B?S2w4cEdrYlA3N3orMG5qMjhlYnNyREVSSVNyOUdDcm5Ud2d2Z0tKNElaSy9Z?=
 =?utf-8?B?c2NCUk1rWHJVTHVaQ2k2Q2F2YUtmZjFoTWMvWUZEbElvOUhvdXZhNmZHV2xh?=
 =?utf-8?B?OTRxSWtXbEQ5cnBoaFNUTTJJVzl1QXJ3NTkrZCtWdHlhQ296L1Uya3ZxY0pJ?=
 =?utf-8?B?STFzTnBVWURNbmU2ZWUrUnBaVGQ1ZFp2Y1pxYXFLK3lOUlUxT1JZL2xyUjVH?=
 =?utf-8?B?YXpYZVRvSEtoK3IrZFNvNnYwOElWdGZ6YmdpR3JjNTQwSmZ3R1pCQjVJSVEw?=
 =?utf-8?B?M1hOTmw3Rm5zaGNXaXZJMVkxaVJyMlVaVEJYM3dia3ppNXpMRThYZEFzdnlj?=
 =?utf-8?B?bStjdmc0WDQzQi8vQTVlaklLSFp5eW5EL29BUTJqUkszM29XREFyVFlISWZp?=
 =?utf-8?B?WmRTSlZyT213UHpyQmhXamV5UUpXMWRVMDl1bW1Ha3hreklYTFpzaXdxZ0xV?=
 =?utf-8?B?MzdhSlhLZnJMcVBFTDRyVklMNHBtdTVESEVPNTlNT1diNDR1Um4vZW9LbWlB?=
 =?utf-8?B?Kzd1citHVXp3WEdlRkRYenJ0YmpGWk9RVjdxdUp4Vm5XMlhDOEl4RGc1MEtU?=
 =?utf-8?B?RUJudHVFL202eEcyb3Bid1ExWjRldGpIeFA0S3poSVFoYysrQlZIbFNnU1ZC?=
 =?utf-8?B?Mkw3aFg4OG1IalRzaDI0eGRuL3pQYkViejV0MkxKSEN4OEJDVTU1QUE3ZGZF?=
 =?utf-8?B?YzAxUmJDZ0tUbnJNTU9vR0huejNyUzZSYUJ5K2ZzRU8rOXZUWFhhdSs5Sks2?=
 =?utf-8?B?UFFDaktCbStLVk93UWY1eElpVUdKUHJLa1BYZTN4czZFMmNyZE5MU1JYTnp2?=
 =?utf-8?B?TWE2NDZpYnJhNXExNU0vR1VwckxSR21OV2Mrci8vejlmWVBkd0p4eS9WNVNN?=
 =?utf-8?B?YVFwalFUT01vUWh2aEhMNWdOSCtvbTRjb0VXWTcvRzA4VEoxdnFSWlljNWls?=
 =?utf-8?B?bEtWYVpOMmJjNTBZNTIyWlAybGlsdTNLMXMyNEpvMTBRU3JUSUxGUkhpK3pp?=
 =?utf-8?B?bU5oQ3YxaEN4c0haSGF2Rmw0S1RITW81dXVYUDFpL0xTMVR3eURIQ0JhSHB2?=
 =?utf-8?B?OVBXb0g3Z0hTMENRRmU5MStTR1IxNG9SS0NEaWprRnhXZ2lkRjlkb240ZTQr?=
 =?utf-8?B?WnVqTmRnbVFiekdwajBvOTFJZFRYMlVtQ3krSGxXaWJXbHIzaGZ2Qzdxajdm?=
 =?utf-8?B?K0ZPbzB0Y3o5aytEMlF6OTJTempybW8vSHBQNXBiQVU3OGUxZGJDOEo4UFNZ?=
 =?utf-8?B?eTN4NktzTVlTbUFqRUNvMmFTT3BwVGlUOUUzZGNZSUQwcksxQjVIVFFLNDI3?=
 =?utf-8?B?ZWVPR3BXeTJqNVA3b3BocWs0RXJ5OWtPSkxjbE4rQ3QrQ1NNSThWcUJHVzFh?=
 =?utf-8?B?YzVMdWNzM1FiYXBQOGZjVnBFdE5VOTE4L3dCQkFHMDV5ODdrTDFLaGRZNHcw?=
 =?utf-8?Q?PthibO5JYbWcD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWM1QlJKNUFJQmMxSXVsYXFML256S013eG1tWWNuSjRsMWVCL09abjhDNmpY?=
 =?utf-8?B?LzFEaVlaNXZreHdqTnBKZzVaVDcyRjRUbko2bnVPWTlyZWJKemkwOVdvVU96?=
 =?utf-8?B?MTlKMFJablVkMGF6UVAyWmlaMXU1RzNBMWpQTXVzZ1ZLSlFkM0JNelBjQXlP?=
 =?utf-8?B?aXVYSXFGVkNXN3A3b3Y0U0xTcFlPdjlWS25ycnBnUjFDTGdDWkRmUVk5Wm4z?=
 =?utf-8?B?MFNtNmJGcDdCSzBNOVNhWC9xOEY2VUdWKzBtQWw1TGw3K2F6dlE1UjBFVjB1?=
 =?utf-8?B?eEVsMG5aWlVNL0hCMGVZQXI0Z3AvNHEvOEJqUlEzWHM1MVNjTTcvTzV0bS9i?=
 =?utf-8?B?WU1zbGhFWmRWemRkZDZhbEQ4NUt4dTUzMEFqelFuMkk5WGlqMUt0Tit1dkRF?=
 =?utf-8?B?MEprYjhZN08wMmUyNTFENUUwcGZIUzd3eHZaa0lCSTdGWFA0RmIvdlBZaGJq?=
 =?utf-8?B?aDRXTmg1NEcxVnZ4dU5xM0lqZm5TYWM4QzJMSFk4dG1jYS9MWldhVGNucWU3?=
 =?utf-8?B?OEpkT2pUWkdvaW9xQjc4WXhPUFZBQ3lWZ3VBU056ZGg3N1VlQkR2N2xySERk?=
 =?utf-8?B?WHR4T3k1WnFZME02eVZQRm1FcVlqc1hOMEhkUTBGWFI2ZzdXY3hMWnFydmtP?=
 =?utf-8?B?U2d1M1RUREtDMVpJRW1HNlhxTDFwa1JwS3N0V2k4VHBmWEdCZzJhcWpxRXdX?=
 =?utf-8?B?Sk9xcDBYQ3pvU2xHWUhOUUtXNDFhZzFFV09WeEpMRTFWYXd3Zi9YekI5RGVD?=
 =?utf-8?B?c3lveHMrejIyYjJQYmZLcGZIR3Z6R005dTM1WkpvY2VWcTFaRkt0WnFOUGs4?=
 =?utf-8?B?WTMwTFYzYVNJZFNUeXhrb2Q1NG5zeVFuYlljTDJ1VFRGT1E5QTQ2OEJ0TUhF?=
 =?utf-8?B?QTdCTk1UdW0wL3ZNcndHRzk0eFpEV2xQU2dteE9EVkxSeFJKU3FFV2I0dDYx?=
 =?utf-8?B?RllVUlZPSDQ2OWduVno1R0plcTIzZ1ZhemZvWVdzYURDZStlZjU1VjlPcXB4?=
 =?utf-8?B?K1hDbGhvNWZJTHBXZCt0YjFzUjB0Zzl6WVE2aElqRlZUZitiZGpQNGxEOW83?=
 =?utf-8?B?ay9aNUI5dXRsWUduaUF0NTZORDlMckJEenBBOUppSnBQNkllbVI3RndIMFYy?=
 =?utf-8?B?TWppbUNSdEVDK1NnNnNsRTgyTmE3TllUb0x2MytlREdMSjZVY0NqZytUTTJi?=
 =?utf-8?B?dnNuT1V2NDhXV0MzbnpYM3lySldmellRUmNvdDJjNE8zWjRUK1JDMXIrVm5U?=
 =?utf-8?B?VXJvK0RwOCtock9Ld0Z0L0lwd3kwNnV1clc5UTJuM1BDU2JQdlY1U1BCMTQv?=
 =?utf-8?B?ZC9DOHJJb1J5UEhiZ0NxVGJWbEplOUtJUWw0TkVqT1VKT21xQ1h2Qk8vcE9y?=
 =?utf-8?B?dHZQaDExakltQS82VURBd2o4WTlsKzhZTkxFdE4zSmVieWxjVE1uZmNISW5i?=
 =?utf-8?B?eTNYd24rVnk0Z2NNYnNLeVN2SUVOSjcwL0k3b1JqWGZxNXoveEtod25lUjFo?=
 =?utf-8?B?OXpBYzdhQmREeFExMGN3b0N4Mk9adklDVEI5ZjdITlJ4MWtjT09kc2JSRmJF?=
 =?utf-8?B?dlhiTUJhMFlpV2RkamI5MHU5Ykg0RUZMSXJQckhYTGZFUFpYdGdHWWwra3dR?=
 =?utf-8?B?dG5WU01CUllFdUUwcFdCdEV6QjNMU2p5aFRDeWErK2pRS2FnNWt1cm9tZUU4?=
 =?utf-8?B?Nm5EZko4b0k3bG1qS0R5K3VlZ2VQK0lXeGhsK0tjcXJjbGJCdGlsU1lLWk9p?=
 =?utf-8?B?clpMcU9zZ1NjaEVPUTR0ZjljbDYyOXJsNTBXWktwRVFiZU9HWFN5ZmNNK1Nz?=
 =?utf-8?B?MXRzSnF0TWxRdlgyN0xGaE9GME05dEFjbmpzZ1ZaaEgxc2pUMk9CSXRJVzQ0?=
 =?utf-8?B?RWo0Tzl6cG1UNlQrVHFKZERPTEh1UHpHWkhEcXJ5eUdRNnZQK0tGUDJCbmFy?=
 =?utf-8?B?VnMvY2Y3MWw3YklhOTFGcjl5V05tOFM4Vnl6VU1peWdYbFBuMFdneHp4dU16?=
 =?utf-8?B?L2pVRUsyZ3hTNUJrcUx0WG52ay9nbzNnNzhDdXJ0cVM4REo3eitjdjZLZk5r?=
 =?utf-8?B?Tm5CTUZZVFh0aXI4OG1LQzRCZDBMcm9VNTBPTWZwRGNOSG5IbXE1N3NJVkpj?=
 =?utf-8?Q?JwmodZtM6Jj9jRkmqar4iUXr6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l42ubkqaOKMM4TE5Y7p1f6p/WEcFVyT5aD6ddj7Rf+r5Qbf6qDB0qgklgHTqRYrm6xAB7lcsiqK4w2br7uskRXJNy/lLYepilJEkok0K21bcN8IdonpYjKde5oHoMggdtCQnsT4NbfqUPR2UuXB5q2mHwcJbNkLsCJ/V15qGvaJASyVqAaMBjk15csNkBFWddV2sHIL+Bd2eQPVE7sE1k/ZtOrbi8F5DSnYVzBkkYn01lgedb/zIsdGILQHZZ3e8O70uF9G2ysdEm7nhKQ+zaEumDHSuAh1D9kGrgyzw9jZ5b4GT5NF3Ihu+1g5PLjrMmvdUd/9BuGE6rkKPO9QjURRF6k6Er0ImFtPJkJ6+1mFnoBFmN8OvvHqf+8fHsgdSBBimUaVDBKn02x9kE3Y8sR+hKa6HsdS8qJY8zt7TIHoryUMg305yQtKu6l5kNNbkYANWLHyG+IoI1dKkAYtivMSrLxIR6LHftp/to/4CGmC1lnS8iOSP6FM33ZpTHjgKIXTUAWRxUSLS1SeX7rls9ANi4n8xfyJzAMfRheqPlCgvbROKbKEDLO7wmjBCzTaau3HzD8vtT3HZrp5hr0pJ3j8CKsnPwRYYL0P086VlEhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f63a87-acd9-4e75-20ce-08dd97a218aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:27:41.2868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRR3+WmJ16D6hh7QlJGUqtTZUkX5v2o0KNsb0n0QaWZCLuVkJO8fz6VwOrM6NoOOwEVV21g9x2lXxL8eBYbl7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200107
X-Proofpoint-ORIG-GUID: gwz2Ga-FsntXcpr5anDWeIkv2tL-wvnu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwOCBTYWx0ZWRfX7lLiO0oufVEV
 vxWJ3Z0SvRt6igJ0ZLb/eFMC5mUEzkq+KcDD58pdMeBLgxfQ8rCr9rCPb553QfvuvzYw3YH8gwb
 zjnx0z6fmbLXCfaUbtRAcD4kcjDupsPXFVn91Bz+YnEs9bqGe9dWunHVihVF3wiOkOG5KHamdnM
 7cVazuFUvFcD9HjCJ3Agi/fnyalKHZmpnw9aELepsoa9Dnvz++VtYTLCoLVHj2+iLgpOA7wLoWD
 mV1vqruNTr+jHsgbBT/l0heNWSL8PQ6RPzlw/etLK5xIE8kZfLtvlyqo1l/xCiyK6bXZ7bEYHlo
 LT0TRpJbes8fQta9NWf7UKEVEAIqMjnR9auMJADqi2Npj6aZ8lkqF2WWIbBDzdfYZwHH0BgMwc/
 U+JBNI5+7bV8HjmTNbQSuM1mkjgZIsa7Tds4J875MMk9g7L6mXlZS+N+dO6GEVSjt41Fkgtu
X-Proofpoint-GUID: gwz2Ga-FsntXcpr5anDWeIkv2tL-wvnu
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682c8351 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=y053s7req3-Ykj_3lo8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=5WABlXvFAscA:10 a=n0c7R5xxTHgA:10 a=pGLkceISAAAA:8
 a=SbWVW7OGsBoHnvfx1CkA:9
 a=7irWGkJSaOBlbTx6:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------i07I7LPUYt2peHYJrlNZGao3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/14/25 11:49 AM, Eugenio Perez Martin wrote:
> On Wed, May 7, 2025 at 8:47 PM Jonah Palmer<jonah.palmer@oracle.com> wrote:
>> Current memory operations like pinning may take a lot of time at the
>> destination.  Currently they are done after the source of the migration is
>> stopped, and before the workload is resumed at the destination.  This is a
>> period where neigher traffic can flow, nor the VM workload can continue
>> (downtime).
>>
>> We can do better as we know the memory layout of the guest RAM at the
>> destination from the moment that all devices are initializaed.  So
>> moving that operation allows QEMU to communicate the kernel the maps
>> while the workload is still running in the source, so Linux can start
>> mapping them.
>>
>> As a small drawback, there is a time in the initialization where QEMU
>> cannot respond to QMP etc.  By some testing, this time is about
>> 0.2seconds.  This may be further reduced (or increased) depending on the
>> vdpa driver and the platform hardware, and it is dominated by the cost
>> of memory pinning.
>>
>> This matches the time that we move out of the called downtime window.
>> The downtime is measured as checking the trace timestamp from the moment
>> the source suspend the device to the moment the destination starts the
>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
>> secs to 2.0949.
>>
> Hi Jonah,
>
> Could you update this benchmark? I don't think it changed a lot but
> just to be as updated as possible.

Yes, will update this for 39G guest and for 128G guests :)

>
> I think I cannot ack the series as I sent the first revision. Jason or
> Si-Wei, could you ack it?
>
> Thanks!
>
>> Future directions on top of this series may include to move more things ahead
>> of the migration time, like set DRIVER_OK or perform actual iterative migration
>> of virtio-net devices.
>>
>> Comments are welcome.
>>
>> This series is a different approach of series [1]. As the title does not
>> reflect the changes anymore, please refer to the previous one to know the
>> series history.
>>
>> This series is based on [2], it must be applied after it.
>>
>> [Jonah Palmer]
>> This series was rebased after [3] was pulled in, as [3] was a prerequisite
>> fix for this series.
>>
>> v4:
>> ---
>> * Add memory listener unregistration to vhost_vdpa_reset_device.
>> * Remove memory listener unregistration from vhost_vdpa_reset_status.
>>
>> v3:
>> ---
>> * Rebase
>>
>> v2:
>> ---
>> * Move the memory listener registration to vhost_vdpa_set_owner function.
>> * Move the iova_tree allocation to net_vhost_vdpa_init.
>>
>> v1 athttps://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86V7C4DccE$ .
>>
>> [1]https://urldefense.com/v3/__https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VTze8nNQ$ 
>> [2]https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VNYsAGaI$ 
>> [3]https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VXyDekTU$ 
>>
>> Jonah - note: I'll be on vacation from May 10-19. Will respond to
>>                comments when I return.
>>
>> Eugenio Pérez (7):
>>    vdpa: check for iova tree initialized at net_client_start
>>    vdpa: reorder vhost_vdpa_set_backend_cap
>>    vdpa: set backend capabilities at vhost_vdpa_init
>>    vdpa: add listener_registered
>>    vdpa: reorder listener assignment
>>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
>>    vdpa: move memory listener register to vhost_vdpa_init
>>
>>   hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
>>   include/hw/virtio/vhost-vdpa.h |  22 ++++++-
>>   net/vhost-vdpa.c               |  34 +----------
>>   3 files changed, 93 insertions(+), 70 deletions(-)
>>
>> --
>> 2.43.5
>>
--------------i07I7LPUYt2peHYJrlNZGao3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/14/25 11:49 AM, Eugenio Perez
      Martin wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, May 7, 2025 at 8:47 PM Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as checking the trace timestamp from the moment
the source suspend the device to the moment the destination starts the
eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
secs to 2.0949.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hi Jonah,

Could you update this benchmark? I don't think it changed a lot but
just to be as updated as possible.</pre>
    </blockquote>
    <pre>Yes, will update this for 39G guest and for 128G guests :)
</pre>
    <blockquote type="cite" cite="mid:CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

I think I cannot ack the series as I sent the first revision. Jason or
Si-Wei, could you ack it?

Thanks!

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Future directions on top of this series may include to move more things ahead
of the migration time, like set DRIVER_OK or perform actual iterative migration
of virtio-net devices.

Comments are welcome.

This series is a different approach of series [1]. As the title does not
reflect the changes anymore, please refer to the previous one to know the
series history.

This series is based on [2], it must be applied after it.

[Jonah Palmer]
This series was rebased after [3] was pulled in, as [3] was a prerequisite
fix for this series.

v4:
---
* Add memory listener unregistration to vhost_vdpa_reset_device.
* Remove memory listener unregistration from vhost_vdpa_reset_status.

v3:
---
* Rebase

v2:
---
* Move the memory listener registration to vhost_vdpa_set_owner function.
* Move the iova_tree allocation to net_vhost_vdpa_init.

v1 at <a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86V7C4DccE$">https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86V7C4DccE$</a> .

[1] <a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VTze8nNQ$">https://urldefense.com/v3/__https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VTze8nNQ$</a> 
[2] <a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VNYsAGaI$">https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VNYsAGaI$</a> 
[3] <a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VXyDekTU$">https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/__;!!ACWV5N9M2RV99hQ!IEW1otcaS4OGOE7TX094yfNmZ7WbibjJQv_DaSJxTjMB4HYFNEjgaFdHMUKQMiGgWKeRhMBCS86VXyDekTU$</a> 

Jonah - note: I'll be on vacation from May 10-19. Will respond to
              comments when I return.

Eugenio Pérez (7):
  vdpa: check for iova tree initialized at net_client_start
  vdpa: reorder vhost_vdpa_set_backend_cap
  vdpa: set backend capabilities at vhost_vdpa_init
  vdpa: add listener_registered
  vdpa: reorder listener assignment
  vdpa: move iova_tree allocation to net_vhost_vdpa_init
  vdpa: move memory listener register to vhost_vdpa_init

 hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
 include/hw/virtio/vhost-vdpa.h |  22 ++++++-
 net/vhost-vdpa.c               |  34 +----------
 3 files changed, 93 insertions(+), 70 deletions(-)

--
2.43.5

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------i07I7LPUYt2peHYJrlNZGao3--

