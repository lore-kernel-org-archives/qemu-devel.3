Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EB8D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t847v-0000ps-0g; Mon, 04 Nov 2024 15:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t847t-0000pi-6O
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:56:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t847q-0004QI-Hs
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:56:40 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KMXR5003621;
 Mon, 4 Nov 2024 20:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GlVETZT74R9wb6O1yV+ZUkBkLsIyj2iFvdOBbpHBSTw=; b=
 IOn61SkhKsVFjsX9T6uIz+e2kBAfnyRMQUUopMFnZ0Uu0Wel5p8L/Mvba0BQnoMh
 /+koiJ8YAswLVhMt2GoKkm8qaoT+2Koo4Kgs81uwt1m219e4BptDwbP96Irte79p
 4w/KJf27zAKdG+iNOxCzDzQSMCqIx1G4G7DuVLDb+Do9Q+Wl7o7e+7baD4ImLUel
 KpevkggJ2QmMaDMOHP+xiMwbORL18117zu05cYpBjsl+i0k0sUp5v69O6Q6YP6cV
 7z0pZ5zovlSYGNzM3vonsaNFplUEHB/NzOQgQ/MFLM2QKOkGFhXrDoZkoByzq1JY
 NWBsX/1mj6aOONHkAaYaiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4buuwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 20:56:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A4KAoAx008426; Mon, 4 Nov 2024 20:56:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42nah69ye2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 20:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B34/cYns7UoK1nZydIR0f9HE1TgBiIzTUeykQpoTLXIrLrNBOYqF/L6bynwMZkxOOVU3gNwqdyGgniZylEIw90rlHtoqsbETAHg9+XUfovuSSvW1o20RpDxlXg24EwHnnBGzZ688nj7fLc1W2nJg+jImnEhXragvWVGwN+Rcgl+jN9RkGVBy3cwrQdHAmZ31ZYi1D6LA3vciT3sHP5nSaBDUNqPbluwQsC/whws02X5/4K2b8doGMTHEq1gBzcD/hNU7RWi2p4b/VoxTi6NNbXHaEVBotBtdd28+KY/zOS6yqa0/SGtT39UwuBYsZW+POeoROBjpiAQpceYdACGvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlVETZT74R9wb6O1yV+ZUkBkLsIyj2iFvdOBbpHBSTw=;
 b=wnLxqDQcFnmmUX2Map5gRismLohg++ixbnU8dnDuTNAtSfygxF/lOxoZrP2n3md9isBLq1E2eLGQrRPqErbjdn+mjoy+zdkDosE9QA8QV1d+oXwiWZ1oVU4LfiqYod672C+9u6u84d1jaRm1l9RQbvDnvAfIb+SxVM6uh6npRTpYuRbR/u82gMI0tXqcVMXTHu4qR0+i4sInOXY9BXeUcI83ye7UigPszw5kxDl8t7JRRwFoje7xjg5bi2C2mXyeY+d5WxXiW9WKns5uCTX5pbOqwr76xlp1yjzodGt+NsK5+3aqxYWnmtj4/g+RxKgDmzySi6XQg6ryocp+AdzlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlVETZT74R9wb6O1yV+ZUkBkLsIyj2iFvdOBbpHBSTw=;
 b=o0LskyQCvmW9kpuuBLrYAiPlRBxtqYQHCobhlxJgH/dGca/NYcJyDqFYYoy/4cCq9Oi9KZO++12GTahjZHp4gLOa5NoJjwWd1Wmgfvw4WXXA+vy1o81WD8R7oXSvti1mBQkW5W14sjtbx2UwIlQrx4jbm9uRXuvEcBYapesAaiY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 20:56:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:56:30 +0000
Message-ID: <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
Date: Mon, 4 Nov 2024 15:56:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: c3709287-8992-41e3-5bd8-08dcfd13280d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REFnUEcwZW5pdTJBNTNuVUtReWM3UnU1UlB5K2Njb2F3dExNM1lLVHp1MFdL?=
 =?utf-8?B?L1R3VFN2dnVpdnhLSUZvN2lXWVBIUjhLbDNnSUdlMGZscnJNU0ZJQWEzZVov?=
 =?utf-8?B?WG0zTldibWZaN2JTRU40ZS8wMzArWGVCL0F4NjRiRlVTWVB2cVc4OW9qMkRs?=
 =?utf-8?B?YVlQaUk5MHh5LzRYSW1OeXpCeDBKUEprcTZRcEpzNGZsbHhEME85T1dic3Zy?=
 =?utf-8?B?SEFuWVlqREpuVzlYb3Q4VDNkSktUTlVFeStuQ0prc2NQdk5UT0czcEQ4ZHRq?=
 =?utf-8?B?RmVoR1p1TDI2MFV1KzRtYTJ4d3dCZnY0QlQ3cDFPNDZtWDByVkkzZDQxQUtE?=
 =?utf-8?B?L21OOC9lSGJacnh3RzBXamViUUlqdmVRNGw1WmJqdTFlVHBUWGw1dHhXdnZZ?=
 =?utf-8?B?bWREeHJqZUUzSzFOdmw0RVVMVVlkY2doZTMzbjJrdVBzMW5RY2lnc1FsL1h3?=
 =?utf-8?B?YVY3TXNTMDVCN1AwejBJQVJrLytMQlQ0RVV0c3RvWDhqdU94U3ptSVlmMnlS?=
 =?utf-8?B?cndHazdpTE9OZXZCWVNTTHAvNURzOVVYT0l1SDFlN0ZaUHh5WmpIOTFDWkxP?=
 =?utf-8?B?MlU3ZkRWLzFJNjh6VGJEMkFmQzN2Q1Y3OW1ML0pIZUFZUVcvMEJYUWcxK1Nk?=
 =?utf-8?B?SFNTdVR6RDVsUGNsSmFVNmlnZ2YyWk5tQ3ZEa1FKVDJqQ1h2Z05laVN6dTJ2?=
 =?utf-8?B?L1o4aXF3Q3R5R3AyS1Zyc2RsbTdDVkg3YkF1K2lyTGF5KzBBOHJDbThHbG4r?=
 =?utf-8?B?dXJ2V0tOSXYwc3lCMTBXaEZSTnVRS0VDTjBNYTFzRUhScU9Cd2lLaHFkUzlH?=
 =?utf-8?B?ZnJURjQ5Q3lpMldDZUJkTE56bkhZWDFucHR4Zk1ZUExEZWJicVVOTnFVL3VQ?=
 =?utf-8?B?RStZZXBCMVJ2RDVxKzE5Unhwb0xaSThnTCtVSklmbUwzSWNFaFo4d3h4bHJm?=
 =?utf-8?B?Q0pzcnduYTFmUTVzVENlYk96b25PMG1jbHNYN3kwNU5tenYwTDNRNU1hTDR6?=
 =?utf-8?B?TWtoMzhXWXNVakUvR2JIeE81N2dDY0Q4ZnIyZlpCbURBRUtPZE5jeHR6M3VM?=
 =?utf-8?B?b0N5dGhmRDJrUHE0R2dBUTQvR3RNM1NFYW02eGh2MmZ4akVLWU9JRE5ENnRR?=
 =?utf-8?B?RFA0ZU1PMUlWRTFUeUJldmVUN1JjQzlNZlU1bnJNTUFHeVlyalE5Wjd2ZFVk?=
 =?utf-8?B?MVVxK05LT2l5a1hCQmgxSDdpWFpPbkpBcnlmOXU1VFZ1Y3BTOGNTSGNGNVk1?=
 =?utf-8?B?eW1ZaTh6WUEyVlkrUERZZzhBU2xObTZ0OEZNeXpmY0FCUTNKKzR3VFFVR1pJ?=
 =?utf-8?B?bENQZHdTbGUrUDBnWHZsSklFRE5YRkIrN3Z4VmIyRnZJR2QwWEpJdkwvQlB3?=
 =?utf-8?B?T3EybUM1eE5YUG5mM1dEdWx6WmdiTUM0bTNyLzl4R1p6U2JvT0tsUTBxbDRO?=
 =?utf-8?B?azhod096WURsbDdubEljOXE1NERWZFpoZFNnUnpSTk0rSHlhUGdYajJCekhF?=
 =?utf-8?B?bkI4d2YvckNZMisyMkpIZnBmZE9DVlN5RHI3WC90QTFLQ2pJS0poZnQ3OHgw?=
 =?utf-8?B?cGpWczkyUFhaTGtxY3JMaUZCcmpXRmd2bGVKZUgwRFJUYUhvM2I2SU84TnFn?=
 =?utf-8?B?WXh2Q2NLcnZSTGFXN0gzTmNoOEx4U0ZqTTdqMHBuTVZSOVRhTUk2dXhjUGJp?=
 =?utf-8?B?VXY0VHV5djZQVGR3ak9ocFQ3OXJqc3N2VzdSVFFHell2MS8zS0xxRDlHQW03?=
 =?utf-8?Q?grtGC9btjpSnx8zACwZtUcD//oyz/W2pQqOsHtE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVDR2NEZHNnUTFsczFWMVpyR25vNkJSb1lqSU9wUXRCOVR6eHBFY3RxcDZQ?=
 =?utf-8?B?dEF5LzlKL2hBbCtTeVl6RUlHTXQvT2tzTGpIV3ZrZHlDMzc4WWRURC83dk1I?=
 =?utf-8?B?ZXIvSm92UHdQVXlQTm05RHdlVlBOcVRqbU1UcDlFVDBZNXUzS3IwU2t5SENC?=
 =?utf-8?B?MGFtdkkwK1hWOVdPV3M4eUZpNHdWc3M0dWxWbHJmSFRDbEpvSXhvM3ZpOE1W?=
 =?utf-8?B?bFRqRElDK2doWTdwd2YvOEtPL3lETlBWSXh2WEhKVFRuU2U1M2ptNFErTjJ4?=
 =?utf-8?B?MFZtR3Z3MVVsVmJBMHg2bVl2bVRKc0VlWm1nU1FDTURPVU9INzZLSjhtUEhF?=
 =?utf-8?B?NDRNUElyN2xrVjV6VFlScjVJNkM1aGZxdzFHRmF6YUFTOGhuckFaelR5VE9S?=
 =?utf-8?B?Q2NES1h6cWF2T0Z5dkhLZU9YeFpWR0trZkZpbkNUZTlPSm9UdW85eHVNNG5j?=
 =?utf-8?B?amZMcSs5dS9GRWZpUjRpcktrRmZoTVZ5VUw5T043Si9nQTBZMGVBbGwzanRl?=
 =?utf-8?B?Q0ptYm9zRnpTWldFN3V5T2NwS1J4dTJIakV0MTk2LzE0OXJsUHRiT1FyT29u?=
 =?utf-8?B?MzBWM3dndTdJNUQ0SWJwaHBmbitLSU41VWR6UFM5cElURUN0MzRVbDJpc1pC?=
 =?utf-8?B?d3pMVThaZDhpSGdLOGtHeWNDbVdYdjM1ak4za3NYSzg2UEtZdkRwMEExY0NP?=
 =?utf-8?B?WVh5QUlhOEZTcjVjWEdkeEUzUE1KL2ZhM0tRQ2l3ekY4bjBPTVNGTWtRYlZv?=
 =?utf-8?B?b3ZORzlXaTNpaXZ3Snh0NHRjOHpZVnJEdk5tMVZhbTFGK1ZLbVFOLzdhSG9x?=
 =?utf-8?B?V1FPTjFRanZtT2drcnh0SUdScEJFeDNYblRNNGpMeFFIcURRTERwSGk5L3Vj?=
 =?utf-8?B?ejZTbDB3L3NLTUxFUjllakM0ZkRxZExIM1VmTDRMQUpWeFNJbXVxTmZtTWQ3?=
 =?utf-8?B?WFVFY2dSSHZ1Ym5EbytRQXFMMWNscjc5VTA3bU5ZUW1yQytFR2F0amVoeEdm?=
 =?utf-8?B?djRGQXRWbG9UQ0kyYnpVUERsMG9DRzhWNWZFdE9mRkdFQ1hIN09aeG9tWklE?=
 =?utf-8?B?QmdjSFVpeVBtRDllcUtReC96Q1JaYnd6dkYwdEoxTVoxNDJhYmtBR3RxZy9w?=
 =?utf-8?B?V05XQVFXVDlpWlNVZ0RNNkRFVTY1YnhWUnFzVFRBTTNUbTYwMzc5dXB1Z2FJ?=
 =?utf-8?B?Z01ZWlNaMC8vdXNIZ0xYNGhtZ1FnNlBDR2RXUUllUmpkWmlZdEEyUnQ4Q0ZR?=
 =?utf-8?B?UDZHb0REdmgyU3gyRTRIWGlicjAzdG5aeC8vZy9URzJuV2lPUy9WZ0l6WTBS?=
 =?utf-8?B?VC9GS2o2SU1LRXU3YU9tV0FVWmk4WGpOV3lsRjdpbFhXRzFqcnNpSFdEcHVQ?=
 =?utf-8?B?bEdYRkNlUjF5U0M1WngyZThCUHQyQ1k0VWRvZHNoakRuWkloV2RFbklLM09v?=
 =?utf-8?B?cmExMHRlZ1NiakVyZlVnUXR1ajNIQkNML3ZUQUZaK2MzcFYzWGFlbXgvYXBH?=
 =?utf-8?B?RW1qRnFsZEEzbDFJcE1UbmlVSzh5bEtkUlRiR0x4cUl6c240M1VsU2tvRzRP?=
 =?utf-8?B?OTV1TXZlQXdmR3VKVXB5TmZvTXlDQ2ZxeW1WdTJtNEh2K3YrNGtDZEMzcmc5?=
 =?utf-8?B?ZDVnbzdydGc2L3ZvbHhHdWdIc05sQlYxSWNkR0NHL3czMHZTREZlZVVHWGE0?=
 =?utf-8?B?TmsxbzhHVm5FaW4wd2dYbmRSTHAydE1tVWNkK1NOb0hQaXdXeEhWbklWTkEz?=
 =?utf-8?B?dzNSYWp0S0tEcC90ZW9QaEdWWG1FQ1hRa3MwMGw0djA0SlZLVjBlVzJuOHcx?=
 =?utf-8?B?azd2RzEwS0pySW1hSWo0TUUxNi9aa0c4YzF4TFNiOUlCRTdqRjhDT1BLNHJj?=
 =?utf-8?B?Q1k1elRQRnBTWmF3TkRhTytJYTBtSWpwK2w5Y1JnU0VNTmFoQ04zd0FHOGJT?=
 =?utf-8?B?TUFLM3pmUzIrQkhsNU8xWmNqZ3BJSE1hazRnbUFTelROTDM2dmM1bWVSenhM?=
 =?utf-8?B?YzJabjVOb1hwSy8wZ080cUUxTWo0cHNHUnlxVFl5cXg4Zkg0T0tlMFR5M2lu?=
 =?utf-8?B?WVVJd3hCWGlWcUhJd1F2eXM2L0h6Zk1OS3grejgvQmN3KzdHakt1d3doaFBD?=
 =?utf-8?B?MS9OMjNsL1ZzaXYwT2VoZnRTeU1wUndiMmE1d2lDR2d6MVJUZHcvZ0Nnem1B?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0/GmY8PP0/yOMryDu4wSsa6ATwBnkJOYHxmnq5u96ILsUP6HgB5mxIRAubKszX8EVcPYfXfXHGMUNBDCvOyYpM2CKkoiPu9SLOvkLbekAy8C3dajGe0lJNZhLpOA7gudCfJSuH/aXJeTboZe88EKk9zTeYsPrIbVTrM+K5AsUDJ1DKoAfJAwvKJ9HyZ9/2DzZRr1tcXrqTy0HaIaBN24fpGhFbL5lPgLt0bCRQWJTTdrPgJKCmm6sSJ8uOvUCw+NqGZmf6kEnss/IeTQmopmn//1aIM4adr2fapjnaSn3dMFP9zqEl2tF856G3uV0ePH7j0kKRbl5GL92jy1VPtV+TSvFBzDkVFT9nc9ThtYd00241F0DexzE1jb6pLypTXqs3G2ZQcvhWTXIobg4IyKxALgQ1eegAqCoNU5TfB/SPaOkk8TC2qhClKMh3eWGsMooeP6OSJ+1NmTXgT7PJkmm7Bef/YlhOHQ+RO260S+Mu/HLulosWkr+W0Kniw9bLfACMeCv16b2S7QMZK5ty4nBaUas88o4pPi0hSrTZvRv0JUEjcjA6BwqOE+MHglG1034nZAYjao4p1OiwcxKRrcgeJk8nWENVsEGUCltZameh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3709287-8992-41e3-5bd8-08dcfd13280d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:56:30.0081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUwR3wJ4bnfYlumFCIGiLWkcmIEN58y4N7LBthheG+iJJ8CwIHVGSLZ1q34ODtGzt3IusZi3v4M1bJtZWD533e0qV5HQPjLcWItNtVVOCcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_19,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040168
X-Proofpoint-ORIG-GUID: xHv2WMQCTDftxAw1AvWylay-saloc-Wf
X-Proofpoint-GUID: xHv2WMQCTDftxAw1AvWylay-saloc-Wf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/4/2024 3:15 PM, David Hildenbrand wrote:
> On 04.11.24 20:51, David Hildenbrand wrote:
>> On 04.11.24 18:38, Steven Sistare wrote:
>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>> memory allocated as a side effect of creating various devices. It does
>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>> the command line, or implicitly created by the -m command line option.
>>>>>
>>>>> The memfd option is intended to support new migration modes, in which the
>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>
>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>> similar to backends/hostmem-shm.c.
>>>>
>>>> Likely we should be using that instead of memfd, or try hiding the
>>>> details. See below.
>>>
>>> For this series I would prefer to use memfd and hide the details.  It's a
>>> concise (and well tested) solution albeit linux only.  The code you supply
>>> for posix shm would be a good follow on patch to support other unices.
>>
>> Unless there is reason to use memfd we should start with the more
>> generic POSIX variant that is available even on systems without memfd.
>> Factoring stuff out as I drafted does look quite compelling.
>>
>> I can help with the rework, and send it out separately, so you can focus
>> on the "machine toggle" as part of this series.
>>
>> Of course, if we find out we need the memfd internally instead under
>> Linux for whatever reason later, we can use that instead.
>>
>> But IIUC, the main selling point for memfd are additional features
>> (hugetlb, memory sealing) that you aren't even using.
> 
> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).

Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
To do so using shm_open requires configuration on the mount.  One step harder to use.

This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
if memory-backend-ram has hogged all the memory.

> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().

Yes, and if that is a good idea, then the same should be done for internal RAM
-- memfd if available and fallback to shm_open.

> I'm hoping we can find a way where it just all is rather intuitive, like
> 
> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
> 
> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
> 
> Thoughts?

Agreed, though I thought I had already landed at the intuitive specification in my patch.
The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
of options and words to describe them.

- Steve



