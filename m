Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ADAD73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZUc-0000cV-Bf; Thu, 29 Jan 2026 16:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vlZUa-0000Yf-1n
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:23:56 -0500
Received: from mail-westusazon11010066.outbound.protection.outlook.com
 ([52.101.85.66] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vlZUY-0006lZ-HB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:23:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INtCKGFhvezV+5PDkNzt01ef46bIx/0VJys3Hmaa8x0p8L5UcivJibSWfnV9KYTWSG8nZX1WPzK4b04ZoVspzoNtRWJPpLF+kr+8+crUbk5MhDOXb90hoGWaDRyqsGNzEBtEVfYZ+PgfDMu836CSU1zhrRzjdmMoi7f+y+0YgKqfuxatlWPXY3dnM/VgJAYTLyb90gDZtecNU8Rqc7Wvj8BbAvvxriDnV5Oo3O8tNdQuLC+zwX8gWdyLeCSQm866rWMZu2sG+MhExAMTJOdN6czfkTkESxnyJ95YwPArsk/xP5KJbPTqLHAgawHyNIjIB5uZN5gfyozDiJIf8UWt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI+5Ap9Rnw4T/n0EfjVVfnbFAqJOHjRXfZeJ8Fph+wk=;
 b=ib1FzBmbtl51LbxwaPzuD9g2/WHxpDOhix1PEwMQl8sos/dHpKVlfP6FvM789BhgFnG4hyeVoaS6NUdzv2K3XWlwJfnBWotGl4Hw55cdSoVH2mT6/NbWVOMsPn4izouAkj/OwAQG4TYva2pbtZ1alhGysVRPUFoKGTfFL+iTta5vXmNZtJRXSiF+W7N29JFL0bSX0bAh0w31cIFDPYW914VQGPX1NhUGfDF0ZfKLvbKmYyq8CMljFOssUmx5Z61qJbF5ltnuUQsIRUfdmVPwCi4mjZSIsvElYUDYWu+jdbIUtDomDwt9mDsyRaY2oT0tSWB6xHhTCJ04rz2JO4hZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI+5Ap9Rnw4T/n0EfjVVfnbFAqJOHjRXfZeJ8Fph+wk=;
 b=N1WAWFyOw79Y62DitKXTHdpru9PeirxZd3prf5+gp55YTntCeGbcxckzSOC7wOfyLtQ4k0yckSkjH9ByY1iYcj7VkkrWxiZ3wDC0GJbciR1jRi+W9H4FBq8J+LaTHevXefk5Ei/t81oKeYvAJ4sWHvkvxN7NeIXMwK5Vy91SJQLlIhTB21cVEVCXuk4BCj2XNd4qq/p1KcjOFmZGSaxzLAUyaClbqdHPn485OXesVtresI6DUl/e1DS1PBTHWCzNBAH1/tMRA4vO/v1xWt73BBcyBXdfzCzyvYj7fRRCoij2MQaJpUqcfDJWBJ/8hIuN+rwBHumjzWbXb4Lq8fMdoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 21:18:41 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 21:18:41 +0000
Message-ID: <821de605-20b8-436a-aac7-158a24929ed1@nvidia.com>
Date: Thu, 29 Jan 2026 23:18:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com> <aXoiAsGCWRv1nwW-@x1.local>
 <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com> <aXo3mcseNxP9bJ15@x1.local>
 <591f4e36-11a8-4310-a74a-6166698d7b23@nvidia.com> <aXpJpwLvHTAXfpon@x1.local>
 <8c5920ce-45b6-4436-a019-222643f573ea@nvidia.com>
 <f9ee96b7-022d-4520-a58c-d77afe57bea6@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <f9ee96b7-022d-4520-a58c-d77afe57bea6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4795de-534b-46c4-2b4f-08de5f7bf9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1ZNUkF4MUdweWo2OGlPT0MrdGU4OC8ra002d2w4RmFSNFJ2NnRvdFV2eWNU?=
 =?utf-8?B?YktrOUhzS0RZUk5vRHFERnprM2JCa1N1bS9XaUhMMndOZVVySXpMVEdTdGNh?=
 =?utf-8?B?b0lmVUFXNGtuYTlwbVJjWTh1S1FzNkdLRlZ4UWRFRFlOUHNuNVdiYkhxRS9x?=
 =?utf-8?B?YzZZUGN0ZmhIRjRmZU5IZzVtaDVTa0hOeW5aTkFaOWY3QzJheFNWK1c2M09W?=
 =?utf-8?B?dXE2dGVwMG9yQ0lMK0pWUjhxTlYwQ0llVkl2a1ZoSmdjTjV1a2RPOGJMQWRH?=
 =?utf-8?B?MWluNzhaYXNONnM4VUNDWkc4NGl1c3ZFaUEvNDNGOFl4VkpEYlh0cU9PWGpN?=
 =?utf-8?B?SEpGZDlTbmxTZXB0VUZTejh2WVpVc1Jia1dGd25UU2Jhc29XTkZHTFFTZ1l5?=
 =?utf-8?B?aStMWTNFRDVzWU42TThkZ2t5UVFGRFU2QWNjamtVZnl3RnRBTzZRZTc1ZmNx?=
 =?utf-8?B?TTFoaXNqSE9KODhWVWhFT3VvWXV0aGZyY2RWTUFGcTBEcUZJRnBzZ2tYN2Zo?=
 =?utf-8?B?Q1JEeFhzZFg1NlFvOUpYQWQyQnBSd1Y4R25kYzVIUlBBV3gwTDQvWDVvNndQ?=
 =?utf-8?B?aW00TUVJenlWUHBRZEtpV0dWa0RtSkVnbmNQbXNKeVpnc2ZrdG9pNldGQklu?=
 =?utf-8?B?MEtGSXpVM2tCNUI1c2VQQmdmQXdWc3pDSjRLSjlVLzNxeWZpL1hicGpZZENM?=
 =?utf-8?B?K0tkSEZjRWFHMTQ1bmNUazJaMkpqYlNoUEJEYWVjNnVvVHRic0hmeDZWb3FD?=
 =?utf-8?B?ZjRjUUt3UVBpZ0hoT2RKaE5zYTRTd0NoaHVSOU1pc1V6VDlIUmZQdjN2cDY4?=
 =?utf-8?B?aEFkQ1d6ZFdqSFdqT1pVUytYa00xSFhmRnR6M2xWbytneUZpRnFSSHAzSFYy?=
 =?utf-8?B?KzBtS25OQm5qVHpBZnFNOXppczhIcVQ0V3JnbER2RUhpTTUybFNEOHJtTWs2?=
 =?utf-8?B?cDJ0aU9GYUNIRVlQZ2xSU2RhbDdUQTRhWGdEeGJmYnR5SEVScVAyQS9YTDRS?=
 =?utf-8?B?S1dJM3YwN0JFdWM4UjQzbk1DV1RoYnhNTFdkc1IyaVRrSW55cUYvWEFaQlpv?=
 =?utf-8?B?UU9wNzRibFVFUU1mUFNkcjZkUmFibS90b1hxbk85MWJFU1duMko4YXY4ZlpX?=
 =?utf-8?B?L21vK2ttZEt0bFlKRG8wdU5sa1BaUGVSNnJiMkIwK2JWNEt4MmVhRTg2Wnly?=
 =?utf-8?B?NG9aUUk1Rk9TOG1CM1l5M2lZU3VWTDJQVmZXbkd4VDNnS1FpV3RWZklYMjVV?=
 =?utf-8?B?RGRSM05BVGEzNzRrdkNwMmRhZklNYW45eW1zcWp3UXo2cUdDMFR2Z2lFM3J2?=
 =?utf-8?B?azk5MS9Vc21rOCtiTjNQWVJTMFZETFJ4cUxOWEZ1T3Jsb0UyU251OUNndjJL?=
 =?utf-8?B?WmphMEUyNGFzQUJwVUZJbEI0VVRhRXFLejhMVWxzbWVUUHppVlpoemU2OEVU?=
 =?utf-8?B?ekdLcGhQRUFncHU4NC8waDdudEt2dkpyRzFxazZ6NURaSENwSitUOXZhNDZE?=
 =?utf-8?B?S3p4Y1ovUW9wNzFrR3JHdGwyTENNSzBPbG5LdXFDbVM1ZTNVZlQyQXVvbDZ4?=
 =?utf-8?B?cWFERWx4TWI2cjNUc2JRbHJJOEYzYkZlZWRvcVdyOENZWHZTYlhxR25GODIz?=
 =?utf-8?B?N2pXbnZvOWJUeWxnanBmSzQyK0FLTERrdEhqZ011dnBSRlROd280c0tvbmZH?=
 =?utf-8?B?Mnd3MTRhUnA0cXROWmliR2ZlYS9COS9rZEgyZzZPaXFTcEQ4RzZBanlwWlVz?=
 =?utf-8?B?NXRQUHRhQkJoQVVRZlZCd3JYSDZRRVVQRXVhMHMrUUVzMGk0dlI1OWRLNFFP?=
 =?utf-8?B?N3VzMFlXb1M1OS9iUHJ6VlJiaTFxb3FoMEJhc2VKUm5vNFdKc0FTREJFa2Zk?=
 =?utf-8?B?cFVuRkZOQ1NvaUdtMlpZQXYzR2lMT1lIZk5mcjRYTkdXS1FHN3llcnRHZWhI?=
 =?utf-8?B?NTdNNEovb0MxM3pGVVZRTVRhRG9uNDlRMWdmOGw2elYzb3ZQT3BkOWpxeGdK?=
 =?utf-8?B?bjl2eFQ2R0tXaXZBb0p4VHZCM1AvaUM0OWZLSGhtQVZyMENhcHdRc3BpWWpa?=
 =?utf-8?B?d0l2WHRsbzRZczFjU1ZmQUNsZFFTaVgrMGJXTGxHWGcyZEZRaUVnb2RSc1JL?=
 =?utf-8?Q?H7xU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29jRzBUemFsYmdDZzJWQXRiWTZEUGIwaG51dWN1cnhxOEtteUI4MTlQME9y?=
 =?utf-8?B?S2ZzeUdyaVkvdHNERGpOcHBiSVNqUER4UCtKbm8wR1Era3U5cE9xRG9lL2xa?=
 =?utf-8?B?bGtNbHpsQW5KVU41dW9RUHpDU0ljUWtGZmxTNkZvcjYrbUg1d3FWMXd3TU1F?=
 =?utf-8?B?eThNY3dTRDV2eHJSTTNqaEdlNlZCS0pRVG1GdzBhN2s3NzU5ZEpPRGZ3TzZL?=
 =?utf-8?B?NnFTUDZ0VkhpekhZVVQ0OUtjdTRmbWVWdVpITW9YaU5PS0x3ZzQ2T0VoWkdh?=
 =?utf-8?B?MlBaOEplclJDTjVIcVMrS3FrTitzeitvU3NnSnkrL3hsSlYrR0J3a2RPeVBw?=
 =?utf-8?B?MmZKL3Z0MVpzS0s1R1lzOHV4TjFpK0JhMit6VE5ubWR1R1lxU0NLSFF2QVRz?=
 =?utf-8?B?L1F5SDNBZGxGd05UU0FVelhmS0tGdFhLV1ZxVm1udzZLS00zdVpoOURRUW5p?=
 =?utf-8?B?U29MVW1lcjRZRzFQZklwMWg4K2FsRVNTb2tzVmZlSkNVUHFuUWhranRXalQw?=
 =?utf-8?B?bEpmUk11Nnc0cFhadHBUQ1BkODJOZDZsUm5lU1U5bGF0SythaTFxREpDQUVN?=
 =?utf-8?B?SDRHWEJ2NEZQeUVub2xjeFc4Vjhrc0c2TjBoejI3OStvWFVma0gxbngrVjZq?=
 =?utf-8?B?KzB4RUZLaDRLbmJVTjNveVhhNUducWJGS1pQSUd3bFJXdWdjOWt3eHdZUWhT?=
 =?utf-8?B?UGNleDRRZzh6N0lYS1pzSUdnbGZxSnM2Q215S3NGamF6Z3F4cUR5RHZ1cm16?=
 =?utf-8?B?NmFPWm1Lb1BNRlNpcDNtY0VOUDI1YzBYZFBSbEZxQVBYUGJpUGVtWlZ0RUxl?=
 =?utf-8?B?RlJDcHV5eWR0aGIwakoxZmM2N0NYZ3B6R09hVVRndWM5SHpmdzNOWmVBR29Y?=
 =?utf-8?B?MHBjREFoLzJ6VTEvRG1SRlFTei9RcW1lelIrUFJPa012amJ4QzZPbmgvNXMw?=
 =?utf-8?B?MkJZRkkwK3Zxc015NE9oWmRIVTEvNkY4R2tEc0I3b2hnam51NkVRN3RCeTN2?=
 =?utf-8?B?UDdiaWhlMkNOcFVnQ21tM21TWEQycWx6akY5cW5MRlVlbGU4dnpja2F2VDdE?=
 =?utf-8?B?eHVWQnJnTTFpKzlCVjRZaW1pV1F1Q0JZQTFJdC95YkJTUE5USWdIM05ZMDli?=
 =?utf-8?B?RnE0MmhUanZWQ3N3bHRQZnEzd1lCSlRydHZhS21Xc1BOYUZqK3d4OGhqWkRR?=
 =?utf-8?B?TGozSWx5U3VKbjFaZVp0OWpMeGd4ZU5lNVA4MWFSWkZLcndXejBhUDJLS1lB?=
 =?utf-8?B?bUs3VHg5M2pZeE5pcVBrNmFJR1N3OVFsbER6bDl3My9UTXdlMzUvV0VRZnUw?=
 =?utf-8?B?MmE5a2k2ZFdCZjlNQkJVcnZZdjRGNXVIbkF3bWZtTkQ5UWFHWkxsZmd5VU8w?=
 =?utf-8?B?bGNtVktOcTlpVys5eC9wV0RMeTA5RlRicE9PdThyZVh5WHRXQXVWcTNhUEVj?=
 =?utf-8?B?Vit5bDlHQjhpMHFWK05MSmp5ZDFKd3JxQTlxZnZHNHhQc2RhR2hkWmZzdHJn?=
 =?utf-8?B?OWxib2VHYXhkRmpVMHlGbThaUnBKOG51eGdWYWdIVFVGSVRDVDJnRTNab3lt?=
 =?utf-8?B?MVZCcXJETFZnODVRQnQvTm9uWk5zdzc0V1pOb2MrSk9Wa3RTcTVjK0xrbm56?=
 =?utf-8?B?dnJsZWJmRnQ0Wm1LV3JzN2JBemF1aUY3Nmp5RUorNlQyWVN2VmZsNjYvTlNq?=
 =?utf-8?B?N2dqNGQvUTFxTHE4N1IrSFY2V0d3SGw0dnpXNW03L0tBSU5LYjlMRHBjMERi?=
 =?utf-8?B?Z25mUVh2ZG1PUkNQaEhCZkE3RG9QMCtBUGh0QWgzMzNnWVIwV3hlU1EvWVpl?=
 =?utf-8?B?dDh1WFZBL3JJNGI2TXpEOWtlOGs3YVVOZE5nRlJoREhYMCtVZWxBWFlsb2ND?=
 =?utf-8?B?Y0NLQU9vUkJ1dURYbFNwa0VOQVF2YlhiZkdVS2pkUW5ZS2RxZnVmNUtNQXBi?=
 =?utf-8?B?UFVWTjdoTWlOVk9sS1Y5Y2xlZHJGY1VwYW9rK3o2S1ZBVU5QN256dHpjbU1y?=
 =?utf-8?B?Mmk0SWV0M1VOV1pyQ1FhTStsb0ZzLzNzUDN5SHpoMmhwT21mbTNSTUJJTitz?=
 =?utf-8?B?aWhOSVYvcmhQTEZkNVpIaHBNSldUT1RRWkQrd3pBMVYyZGFhSy9PMk05Mlds?=
 =?utf-8?B?Ri91YWRzWk1nN012UThUV3hnakVtOEIzYnhQcmdVUTVYdkpkRVVtUWtqcDEr?=
 =?utf-8?B?aExEZy9ERVFNVHhjY3VLdlIxWk9pSU4xekE3eTZ3aGNxNjFpTlk2eklSZWx5?=
 =?utf-8?B?ejhyY2FVVVhWN0VxQUErK1ZjaFFqaWdpcE5nbmZzdThEUys0KzhGeHViSGFG?=
 =?utf-8?B?Y1FOOHd3ZDFWSHo3SDllaVBpbFpvS0dlM0ZKM2N3TVpSU1hUb3FWQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4795de-534b-46c4-2b4f-08de5f7bf9bb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 21:18:41.1201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxAhqSCI8/10Ir+Iw7carYPbICKBayzRMvWOL8ARUzlHHLBeHIQoTedrfAAO/YWuLPgx98jJgY7PFNFE77kVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
Received-SPF: permerror client-ip=52.101.85.66;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/29/2026 4:31 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 1/29/26 06:11, Avihai Horon wrote:
>>
>> On 1/28/2026 7:38 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Jan 28, 2026 at 07:13:43PM +0200, Avihai Horon wrote:
>>>> In our case we only use the PRE_COPY_P2P prepare event. The prepare 
>>>> events
>>>> for the other states are ignored.
>>>> For re-enabling the timeout mechanism we indeed use the "regular" (not
>>>> prepare) events.
>>>>
>>>> However, this new event can be used by anyone for any purpose, so I 
>>>> didn't
>>>> want to limit it only for my use case.
>>> I see your point.
>>>
>>> Said that, in this specific case, my worry is nobody will consume 
>>> the rest
>>> events, and then after a few years nobody can even tell why it ever
>>> existed. Then QEMU needs to emits some never-used events forever, 
>>> worrying
>>> about breaking anyone, even if in reality they're always ignored.
>>>
>>> Personally I think it makes more sense to add one explicit message 
>>> as you
>>> explicitly need.  Then, that message can be as generic as possible 
>>> on its
>>> own.  But I'll leave that to you and VFIO maintainers to decide.
>>
>> So you suggest adding the prepare event only for the PRE_COPY_P2P 
>> state (which is used in my use case)?
>>
>> Cedric, any opinion from your side?
>
> I agree with Peter. Let's not over specify the feature for the first
> use case. Let's keep it simple and well documented.
>
> It is not a problem if the mgmt layer is not libvirt. Diversity is a
> good thing anyway. Just mention it.
>
> Let's see v2.
>
Sure.

So I'm planning to send v2 that only adds a new PRE_COPY_P2P_PREPARE 
state to the existing event.
Please tell me if you had something else in mind.

Thanks.

> Thanks,
>
> C.
>
>
>
>
>>
>> Thanks.
>>
>>>
>>>>> I do not know VFIO state machine well, also not familiar with this 
>>>>> specific
>>>>> problem.  So please treat them as pure questions. Anyway, it'll be 
>>>>> always
>>>>> nice to attach some more information into the commit log IMHO.
>>>> Sure.
>>>> As I said earlier, I didn't want to tie this new event to my 
>>>> specific use
>>>> case, but rather wanted to describe the general problem it can solve.
>>>> But if that helps, I can add some more details in the commit 
>>>> message in next
>>>> version.
>>> That'll always be very helpful, thank you!
>>>
>>> -- 
>>> Peter Xu
>>>
>>
>

