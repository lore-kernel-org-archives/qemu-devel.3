Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D931C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmBD-0004c2-Jf; Mon, 07 Jul 2025 09:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uYln6-0004GE-If
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:21:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uYln3-00029r-Tb
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:21:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DC6PE006386;
 Mon, 7 Jul 2025 13:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=AYA81OvgS8HYvPrSH5+xLsarp0J/H7BY7KRz4RPLQrY=; b=
 bAyLbU61OIMppU2K2+EPO0NzY/Qw5bdSjhRDRdWNF3zhEw3ZxLYkkEk+E9lttX7c
 k0Y4kOiSfSiu62pHk0zGlZ87CrKn8YEcRRUq3cLuj/oXFcfS/aoWY8qgOEvFCvKh
 XQvYyHKGUuQBr9I33OkzaXkg3kusLoe5PuVVSV6GhR5DRVBjWeERiYaTNi5qHY1D
 5ApYSE2i84LtcX2+lKexVUoTt79KcK3OncUJMjIsT6ZdaZghkW35pUQvB5/mIq3L
 X70ECnBq0DArG5doRB8kwQAUY7O16c5UmF5BEPbIyDGOWDVrP4WiCS1eLx8Vz0dq
 5n9J3vLg6jfhG+NE0/58dg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rewhg0nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 13:21:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567Cnhb4014045; Mon, 7 Jul 2025 13:21:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg90083-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 13:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+in9aKtCNF6NVaDRL/uWGlkm4kw4t6GMiafSIylNn2n5LC+48IawGQ4nO6xgd02/ioo71kIRY+oUo0ulqbTsOTS0R02DnexrZPm/x/4k1nIpD7vPpPY0cfCjq3RaFC1fVeLCGmIPFY0tL8FuzWjArzdQefDz2iRynWCY2MVtWF0Gqj2LjAdwYoN6pmTS79HNTw3My2e+hMpt1VrRPxyPsx8L8efTL5vMrbzbwjeI5DUPdv46VVClPnNQTgB/XSjF7VfbUE5ozdjdWXu0oWECvOGdDW2vO+WfEArl5eDR8U53mBkSthUfMKCyhWF1/AnsYAwOEYEEcswKsE+rz7tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYA81OvgS8HYvPrSH5+xLsarp0J/H7BY7KRz4RPLQrY=;
 b=UIGb/viYm4Bd3xrX2X4Kv0MGxye7EUhpzGY0xzFOHXRItZfVRTiCQ54zboHvU+z4ydo5ZXY7ASMuezTQQOwlBym9Dhyed8nVKTQi3h/GfbgCVm3EBJL/tW+2WCQVTVZFcXFmLt4IWrJ0lCPaLoxnObdnUf6EjeOrtKtca3GReCZyyeriZ7OhjOq/cIT/zgLFy7KD+UCDMZhvfHSwlliaFWxOacUAcCuK3HRhmeVCKOahlpiiFzyZUxZVAwOQSMd30xE9xFYe4MAfJ6cOIUSmLiB1GOUGJvEeaR7b1jMEIbx1y4EeSR3EzuZOLI2TSvn5npJ5stTqWp2QsOVuKO79DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYA81OvgS8HYvPrSH5+xLsarp0J/H7BY7KRz4RPLQrY=;
 b=htyAbAfudfX/4106Xh0v2M07t6hlNMzFQ/euWcf+SLb3dnZLjeZSeNCWMYa4MNGtvnSs7NOoJvGbynJFUHbW5so/fQDdfkJYZj2OxoNlsmg9/Xnmxku/PazD0thfx5HUBitNJHd6xPtq+XcN0XhPvwL+DxWBrwFUe8sfVmoJ92s=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 13:21:40 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 13:21:40 +0000
Message-ID: <face37ee-9850-448f-914b-cd90a39d3451@oracle.com>
Date: Mon, 7 Jul 2025 09:21:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com,
 parav@mellanox.com, sgarzare@redhat.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, Si-Wei Liu <si-wei.liu@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
 <87o6v6muq4.fsf@pond.sub.org> <8734cimtqa.fsf@pond.sub.org>
 <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
 <87o6uau2lj.fsf@pond.sub.org>
 <69bc738c-90fd-4a48-9bee-bb7372388810@oracle.com>
 <87frfcj904.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <87frfcj904.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CH0PR10MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a839e5b-4725-40d9-f06a-08ddbd59353e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBNenAzS25iTzIrWXd1OG5pODIwbE5iV1dtb3VjQ3JoaUZ4QWo4S0lDMXZK?=
 =?utf-8?B?V0hKVkhQem5QTm9vd0xYMHJlK3ltUE50WkE2ZXJVRStEekZMbmp6SDczc1hQ?=
 =?utf-8?B?djJITzN5R09YTkhkRnBuNnByNTduR2ZVSURvVXBLbjRMWHFkbFN5YVVGNnFV?=
 =?utf-8?B?aTZCTUJiUWhNdkkwbGNsUzEydkFyTDZxOW93TktobExBek1QKzhLOVVzUnJi?=
 =?utf-8?B?eU1RSXZKVSsrbmp3K3NnT3lsN2U4YlFxazFsMjZEUEs0OU91ZUg5QzZFczlm?=
 =?utf-8?B?T0hHOWx2TTlBM2xWNmZSemRZVWNGN1ZocGRlYjVlMHZIRzA2eXN1T0hXYWpH?=
 =?utf-8?B?djJZcHJJTDdCZ0VCcDZISHJiSVVKc2VmcUUzK0ZLVkM5S2twQWNaWGZWYm44?=
 =?utf-8?B?bW1jT3dwc05MZG1GbThYY2Q3aHArSXBaVDVTM2ZnbVU5VVkza2VRdXZTR0l0?=
 =?utf-8?B?OFVYWW12V25WUVBhRThxM0xBYkV2dGRTZnJGQnJiemtLV1dPY3EyYWZBc0Zk?=
 =?utf-8?B?dC95alFzNEd1VktNbmY5WGU3bS9qS3lJemIyanpvNEJPR3p0NHhEV2VOVUtw?=
 =?utf-8?B?Y3hpdXpKd3V1WkJFdEJQSVFwaGdKR0g2WWZoeTBHbDZYTFRkY2xkaFpXQmZC?=
 =?utf-8?B?S1dPOTY5azFqUWRvUndHNXRlK2l5QXhNM1F5Vkw1bHluaVVvSTNFNzUxUXJN?=
 =?utf-8?B?emp0amk0azlIWm50TzA0cjlnaUxlN2JycW9RTnJEWTFYVTdXcjI0VTZpSnV0?=
 =?utf-8?B?RFBrK3FaQTU3aW1zMjNpcTc3UjArVndrenVHK00yYUNHZjlhZ0ZUSWcvdHNT?=
 =?utf-8?B?UDF1Q1NoWEd0ak1lck5Meld4M2hQUVpRWGVSUmxvUzJKRkU2dmdpdU1KOVFt?=
 =?utf-8?B?L00zc2R2RFR6SjFIaTFJZ0xNb1l5UjBCMDRHWm1zenhsQUFnQzRzV2UvZmg3?=
 =?utf-8?B?Q2dCTU1oOTFpNkp1ZENBbzdtMVZ1d2Z2RlNLcXd6bnRLcGx5b1Nxa0JSaXBp?=
 =?utf-8?B?eGlIMEZ0amcrTGNTZ1NWcFQyaHNGR3VJd3JaQXlpT1pQUU1YdFE5Q3ZQbUJL?=
 =?utf-8?B?K1JNV0xOZGRORzY0NDZVSCtweUZwZXU2R3VzMXJORWh2d3htV3QrTVpkc0FF?=
 =?utf-8?B?eHBZRmRKWkY5V3dCb2xkdGhuNS9VU2RKR21rRm1RaWVCSy9LYUtyRURZM3ZK?=
 =?utf-8?B?MG9EbFB4SnFHN1FpR2JpeHJsYmlkTWpod1JML1dmaWo4WThpdFNzcXBUMWJH?=
 =?utf-8?B?Z015SVVsUGZnVnJvbHgvM3RvRHQ0QmtKb3ZiVEZvQTBBcWNWZWVaT0xlVUI2?=
 =?utf-8?B?Z0QvNDIwTjk4REt2N0lKY2pmZUlQem14TEQyRUpzZldkMDJDQmZTdjhUWjdY?=
 =?utf-8?B?clNsWjE2YVc1SkZENEkxOGZNc1BpUlJHdlZnaWwrMnoyY25oZUpjNWY3Ty8v?=
 =?utf-8?B?Qnl3ZUtZQnh6NkIxcFZ2MUlKNk8xL1lqQTZwZVhwRXJKbmdoWnA1U0ljOWtP?=
 =?utf-8?B?dGl5eFE3cUJnVzBBeE0xRitQeC9sZ01JMWIrbGdXcCs2Zk1LeGt3ZE5pU1Jl?=
 =?utf-8?B?UXpvUXVQT3E0aHhhN2pieS81L1dhN1hMajVqeXNMN3VBZ29wek51akplQ3JO?=
 =?utf-8?B?TGlWWFNjV2k2TWIzT2JrN3JXb2JROHJtU1ZqTXlhak5JUVlNcm5iL1VYUEJ5?=
 =?utf-8?B?VStKcTExb3Z0RnBWQWxGS1B6TVdRUjFaWnR3dnBMSE5FZVl3U1J1cCt3UkUw?=
 =?utf-8?B?SFFtem9aZ0hKWElIZEJ5dndlaEU4MjArME5UMWZwbm9vWEtJSEVXTTBLWXkr?=
 =?utf-8?B?UjZvbTEyR002bmpBZ2ZKS1dHTm5WSTNLQ3NpUVI0aVhoeHJ5Q3l1T3l3b09l?=
 =?utf-8?B?WTdwaHl6SVhFRm9nMmpRRXhqN0RtaFh0bXRITG5TZ0xLNXR3bXVEWUE1VVZC?=
 =?utf-8?Q?umZAoMJJo9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9QN2s2eFdDMnJtd1R4T1pXclRWOXZib0hiZEZ3L1l3MGxrNndmWnp6dGR6?=
 =?utf-8?B?N1ZRNUNEakFRL3FyeEJGRk5mK3orN3pCaXNuV0VZN1VzeU0xZnBscmxFOXM4?=
 =?utf-8?B?S0ZlQzdCeWlBd0w4Vk9Mb2NNY3F6cG10ZFNBUzRPVWZ0ZDJSSTA3RFFPbFc3?=
 =?utf-8?B?KzExRk12a21jT0c5MUNnS1RJWUdWZHVQTkhmZ0dkREU4V012TWx4cmlYRDhN?=
 =?utf-8?B?TnVDWXBUOHpURWdQcXhrbGRVNHdWWHZodmdwcHFpcm5vQXk1cTJRRVROUHph?=
 =?utf-8?B?bjhYU21KYUlmUDViVEVZZ3dpM0dJVWFjUEhpSXp6azJhdGo1eHJqamRwWXl2?=
 =?utf-8?B?V0l3eWoveGZXZU5tdGY0YzBVMU1CV21QZ3NDRUEyQjFiamdOZGN2dEF2QzFS?=
 =?utf-8?B?SHBEdzl0TWxpV0NoRDRQbU94eUhKTlVreW0vRkJHa2ZQTkFneHl2WWZYMjkv?=
 =?utf-8?B?dXZNVjJFaDVOdXAxazNZaE5RZHZkNUsvVE5zMlE3aFdaSlFjVXVkbGV3RzNz?=
 =?utf-8?B?TVVQdlRhSkxiVkFCaE1pTzlJVUhKZDVySEVnbE8wNVVtQlZzQnVMTEdhejdi?=
 =?utf-8?B?U056WE82S3JHVzJXdEhlbTFiZGo0aElUelNOajlWL3o4Z3NBeEs4WGhNR21T?=
 =?utf-8?B?aUlPRG9qNVNzTnJ3OGZBUUtUQkp5ellYUUJ3WTd3bGh6b25aMXpoODUwOUtk?=
 =?utf-8?B?eVBBeThPNUx0eU55YlFoWk1UV0dLUHJpNmNpTGpEVnMrcjI3VGhXZEJWbmFB?=
 =?utf-8?B?OVl0ZExzcG0xY25UWVRGWmdMK20wYUI2SkQ4WXNZNEJkcktsdGU0aHdPWGpU?=
 =?utf-8?B?WVpPV1ZxVnQvcm1nclRUcm01Vi81Ynh5TTc3dStHUENyNUIrb1pmTElNT240?=
 =?utf-8?B?UHArcENBRTFhV3hnZDV4MmdKSThqV1B0bm14bTl4THlPSkk4bStmVUJ4a2VB?=
 =?utf-8?B?U01RQ0loS1hHWDJmSnJJOTBvNWJnQWp2Uk81Ky85OFR1eUxPUzB4b3FxbGVB?=
 =?utf-8?B?SDJQeXljbGtSNEt1dXA2d3h0M1pyTy9MWjFpWTVCcDIrSUxsOGNkOGsySURD?=
 =?utf-8?B?K1hqWlFtenNkcFRUNVBDa2hmYmZZSC9jU05LUHFUaktxZER2WWpaOUl4ZnNU?=
 =?utf-8?B?c0ZpTmlveWUxRzJtUWtoODgrWnhRMlYvbEYwSUQrMHlqSUlSa0gxTTZBTU5z?=
 =?utf-8?B?a2hPYTMzVVE1c3hESmxVczUwMjhWY0RyNmhRWTBGdENIMjMyWnJ0OEVYUEJs?=
 =?utf-8?B?RHhkV2tINWNyOFR5Y0Z6YnBWbzZXZXNBVGkzbjlIellRa1AxclpoTkwwYkJz?=
 =?utf-8?B?bGpPNkFWRWlHQUhLcjlWbGJmR21nM1FEeXNUakVEOUdBQ05aWUlnMFBZcmNk?=
 =?utf-8?B?bVdGcFZDY2ZqSHFwanMrT0p4Y0I5TTRHMldMVm1laTdXRzJrcXpsSEpOekg3?=
 =?utf-8?B?bDEveFFydGtNa3FrN3JuVXVMbVFSeHRrcUM1UkRQaDhmbk4yTTZjYVJUaDEz?=
 =?utf-8?B?VmpQMHJnQkptTCswSG8wdmcyNnR1dFVrdWw2ZzZjRVhYRm1TQXZzb0tXUVk1?=
 =?utf-8?B?MFhLV21MZUQrNkQ0WUtzeUdIRFljdHdTdHIxQWFIaUx3d2VubmJNb3RrRjdJ?=
 =?utf-8?B?Q2lJb2dTb3BkTWx6bjd2YzgrMUVqa3p6WkYwSmtJN1o2OHFwVzVLQUpvclVZ?=
 =?utf-8?B?UTA1NE5KaUprZTZ3cGdIRHdKZTRwVWRKdVJyZllQWTFLQXBpN05MbDllUGpj?=
 =?utf-8?B?WVR1dmZoanlQa3YrZ2RFQ3p1V1BMNGRVbXBSVDZkanJKRnNvNUZvdFBpdWdE?=
 =?utf-8?B?Y0VMUlBoUHZhN0tKaDl6aThoekRkd2toK2M0QU14WjN2Z2ZEbnpBempuZ290?=
 =?utf-8?B?dTVSTTNRVll2Ty9ZeWNvYVBncDhNd2NTMklmRisyWEtsVWZ4RmtuWjQ3d2Jk?=
 =?utf-8?B?Z0FZMUJHMC9nV2Via3d4djVPbmtnbkx6OGdZZ0pzQnBQbmZlQnNoSStYTkJP?=
 =?utf-8?B?MnllMkZwL3BPLy84aXc3UG9NK3lWZWhRbXA3Zk43SDF6SGNLbWZ5aFo1ZFhs?=
 =?utf-8?B?TFV5VTdPZUFFU2lEMmU5Y2pWUnl5YmlRV1RML3pnL1NJb01oTWpKL3pIa1lP?=
 =?utf-8?Q?adxjK2ky8MWeCfxHH3v4K/KPM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: reG5+dUi2dQZhWcclz6wuAs7x1sMBEFcZ9JCNUIFI2JGPZZcJ9nMt+0ux/xPBKXuVcKNaPGHOvcS+NExna5Sey1Il7yBY5CoKbCutthr0a5q3KThI5Au/tcj7zi6j+PXD7sdtFE9MW7ZRmdUX/wjD0TBFM6d50xcqOmsc7eSPmDNqq7IvS9X6KuGaWypseKl8MIXkjnSxEB+6C1ZGD2N1pl/W1VZJjY6vSFQCMSnKB6MVadMhdbc89v+pRnkBFve/huCATyRsdQDMrMutCQ8kuVt0njvVPImAM85m6OREbtpRS1kXUjaOIB0JOijJebTIeqguSnAsHNpar3bymqCIN3mlbKJL6AVFsN3XUjGUg9lIb90Xlaj4hrWbyA2df+rM+MygpRpsd9n9d6yVTlGjJuIiS5s0mxg7HnsJTh6LRXghVuiWjYpBR8SE8zHWC77LlVc3vAERvqNk2+GG9q1EZUeIBJP+emxcFzIjDtpA8KphC1UzG4UwhbP+NnJ43T7lceWuEEB/zYnPRjz+gJU+YtTrz/qjMYm33VhaQgyo5gWt1EUFmU5BRIj9ulbEPEVOLmYRLfJW7WYLg+yCxSwiyaLbG1Uq8y9BAoi+PeSzcw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a839e5b-4725-40d9-f06a-08ddbd59353e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:21:40.4224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAwbVmP7xeXkC/62hWJaiiQ3XitMLTfOcdEUuXaEED54X/IOe/f0wvKeKXpy4W6sOVPoT4R0+6sQe1jb0IhGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA3OCBTYWx0ZWRfXw8z6plX1RJ/P
 ji/u70eFtXpWc6k7YP/HANfS4FegNpaqEJst1WWHni3KdU6vpGb16g3kHZRD2iTG2dW221KXmSL
 ogwgLyjYNexdKVK6s1q1+IagyHnLY9Zn1lKW3rQxUNA4I9ms2DJPNqotCdK53byddUJndIfyRYN
 8+ORoPJEX/o6bT0gpSLQ40B/rVOK8sxdrJX93CCBdPF+LrdftYeBWIn9u4jQS/V8N9zjW/7mYeA
 GawTWWtTZs+ugVCVh10aCICpwaxEkAj8N9+FCRl1btWXSzLpD4wMRhSnFOcsEliIZfPcHbEDfyj
 6daSf6NbmvDSWrCZ8mfJj+BsS/bEgqzDIqBmTI2LqktC5r6y8ED50l0DYcIDnjH5Ij2bqfss3wC
 AH26anA0QGIAnStGE3BJSJaqqlnPORfDDU5w8kb/4bsUMz1Fv9wA1L/Vzk07SqtxeRlUCMCs
X-Authority-Analysis: v=2.4 cv=Fs4F/3rq c=1 sm=1 tr=0 ts=686bc9e7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=OALH68SqvVDPUdNHAmgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13565
X-Proofpoint-GUID: fRPAan4lWaIIXYg88QJampAl3wHs38J4
X-Proofpoint-ORIG-GUID: fRPAan4lWaIIXYg88QJampAl3wHs38J4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 7/4/25 11:00 AM, Markus Armbruster wrote:
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 6/26/25 8:08 AM, Markus Armbruster wrote:
> 
> [...]
> 
>> Apologies for the delay in getting back to you. I just wanted to be thorough and answer everything as accurately and clearly as possible.
>>
>> ----
>>
>> Before these patches, pinning started in vhost_vdpa_dev_start(), where the memory listener was registered, and began calling vhost_vdpa_listener_region_add() to invoke the actual memory pinning. This happens after entering qemu_main_loop().
>>
>> After these patches, pinning started in vhost_dev_init() (specifically vhost_vdpa_set_owner()), where the memory listener registration was moved to. This happens *before* entering qemu_main_loop().
>>
>> However, the entirety of pinning doesn't all happen pre qemu_main_loop(). The pinning that happens before we enter qemu_main_loop() is the full guest RAM pinning, which is the main, heavy lifting work when it comes to pinning memory.
>>
>> The rest of the pinning work happens after entering qemu_main_loop() (approximately around the same timing as when pinning started before these patches). But, since we already did the heavy lifting of the pinning work pre qemu_main_loop() (e.g. all pages were already allocated and pinned), we're just re-pinning here (i.e. kernel just updates its IOTLB tables for pages that're already mapped and locked in RAM).
>>
>> This makes the pinning work we do after entering qemu_main_loop() much faster than compared to the same pinning we had to do before these patches.
>>
>> However, we have to pay a cost for this. Because we do the heavy lifting work earlier pre qemu_main_loop(), we're pinning with cold memory. That is, the guest hasn't yet touched its memory yet, all host pages are still anonymous and unallocated. This essentially means that doing the pinning earlier is more expensive time-wise given that we need to also allocate physical pages for each chunk of memory.
>>
>> To (hopefully) show this more clearly, I ran some tests before and after these patches and averaged the results. I used a 50G guest with real vDPA hardware (Mellanox CX-6Dx):
>>
>> 0.) How many vhost_vdpa_listener_region_add() (pins) calls?
>>
>>                 | Total | Before qemu_main_loop | After qemu_main_loop
>> _____________________________________________________________________
>> Before patches |   6   |         0             |         6
>> ---------------|-----------------------------------------------------
>> After patches  |   11  |         5	       |         6
>>
>> - After the patches, this looks like we doubled the work we're doing (given the extra 5 calls), however, the 6 calls that happen after entering qemu_main_loop() are essentially replays of the first 5 we did.
>>
>>   * In other words, after the patches, the 6 calls made after entering qemu_main_loop() are performed much faster than the same 6 calls before the patches.
>>
>>   * From my measurements, these are the timings it took to perform those 6 calls after entering qemu_main_loop():
>>     > Before patches: 0.0770s
>>     > After patches:  0.0065s
>>
>> ---
>>
>> 1.) Time from starting the guest to entering qemu_main_loop():
>>   * Before patches: 0.112s
>>   * After patches:  3.900s
>>
>> - This is due to the 5 early pins we're doing now with these patches, whereas before we never did any pinning work at all.
>>
>> - From measuring the time between the first and last vhost_vdpa_listener_region_add() calls during this period, this comes out to ~3s for the early pinning.
> 
> So, total time increases: early pinning (before main loop) takes more
> time than we save pinning (in the main loop).  Correct?
> 

Correct. We only save ~0.07s from the pinning that happens in the main 
loop. But the extra 3s we now need to spend pinning before 
qemu_main_loop() overshadows it.

> We want this trade, because the time spent in the main loop is a
> problem: guest-visible downtime.  Correct?
> 
> [...]
> 

Correct. Though whether or not we want this trade I suppose is 
subjective. But the 50-60% reduction in guest-visible downtime is pretty 
nice if we can stomach the initial startup costs.

>>> Let's see whether I understand...  Please correct my mistakes.
>>>
>>> Memory pinning takes several seconds for large guests.
>>>
>>> Your patch makes pinning much slower.  You're theorizing this is because
>>> pinning cold memory is slower than pinning warm memory.
>>>
>>> I suppose the extra time is saved elsewhere, i.e. the entire startup
>>> time remains roughly the same.  Have you verified this experimentally?
>>
>> Based on my measurements that I did, we pay a ~3s increase in initialization time (pre qemu_main_loop()) to handle the heavy lifting of the memory pinning earlier for a vhost-vDPA device. This resulted in:
>>
>> * Faster memory pinning during qemu_main_loop() (0.0770s vs 0.0065s).
>>
>> * Shorter downtime phase during live migration (see below).
>>
>> * Slight increase in time for the device to be operational (e.g. guest sets DRIVER_OK).
>>    > This measured the start time of the guest to guest setting DRIVER_OK for the device:
>>
>>      Before patches: 22.46s
>>      After patches:  23.40s
>>
>> The real timesaver here is the guest-visisble downtime during live migration (when using a vhost-vDPA device). Since the heavy lifting of the memory pinning is done during the initialization phase, it's no longer included as part of the stop-and-copy phase, which results in a much shorter guest-visible downtime.
>>
>>  From v5's CV:
>>
>> Using ConnectX-6 Dx (MLX5) NICs in vhost-vDPA mode with 8 queue-pairs,
>> the series reduces guest-visible downtime during back-to-back live
>> migrations by more than half:
>> - 39G VM:   4.72s -> 2.09s (-2.63s, ~56% improvement)
>> - 128G VM:  14.72s -> 5.83s (-8.89s, ~60% improvement)
>>
>> Essentially, we pay a slight increased startup time tax to buy ourselves a much shorter downtime window when we want to perform a live migration with a vhost-vDPA networking device.
>>
>>> Your stated reason for moving the pinning is moving it from within
>>> migration downtime to before migration downtime.  I understand why
>>> that's useful.
>>>
>>> You mentioned "a small drawback [...] a time in the initialization where
>>> QEMU cannot respond to QMP".  Here's what I've been trying to figure out
>>> about this drawback since the beginning:
>>>
>>> * Under what circumstances is QMP responsiveness affected?  I *guess*
>>>    it's only when we start a guest with plenty of memory and a certain
>>>    vhost-vdpa configuration.  What configuration exactly?
>>>
>>
>> Regardless of these patches, as I understand it, QMP cannot actually run any command that requires the BQL while we're pinning memory (memory pinning needs to use the lock).
>>
>> However, the BQL is not held during the entirety of the pinning process. That is, it's periodically released throughout the entire pinning process. But those windows are *very* short and are only caught if you're really hammering QMP with commands very rapidly.
>>
>>  From a realistic point of view, it's more practical to think of QMP being fully ready once all pinning has finished, e.g. time_spent_memory_pinning ≈ time_QMP_is_blocked.
>>
>> ---
>>
>> As I understand it, QMP is not fully ready and cannot service requests until early on in qemu_main_loop().
> 
> It's a fair bit more complicated than that, but it'll do here.
> 
>> Given that these patches increase the time it takes to reach qemu_main_loop() (due to the early pinning work), this means that QMP will also be delayed for this time.
>>
>> I created a test that hammers QMP with commands until it's able to properly service the request and recorded how long it took from guest start to when it was able to fulfill the request:
>>   * Before patches: 0.167s
>>   * After patches:  4.080s
>>
>> This aligns with time measured to reach qemu_main_loop() and the time we're spending doing the early memory pinning.
>>
>> All in all, the larger the amount of memory we need to pin, the longer it will take for us to reach qemu_main_loop(), the larger time_spent_memory_pinning will be, and thus the longer it will take for QMP to be ready and fully functional.
>>
>> ----
>>
>> I don't believe this related to any specific vhost-vDPA configuration. I think bottom line is that if we're using a vhost-vDPA device, we'll be spending more time to reach qemu_main_loop(), so QMP has to wait until we get there.
> 
> Let me circle back to my question: Under what circumstances is QMP
> responsiveness affected?
> 
> The answer seems to be "only when we're using a vhost-vDPA device".
> Correct?
> 

Correct, since using one of these guys causes us to do this memory 
pinning. If we're not using one, it's business as usual for Qemu.

> We're using one exactly when QEMU is running with one of its
> vhost-vdpa-device-pci* device models.  Correct?
> 

Yea, or something like:

-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,... \
-device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,... \


>>> * How is QMP responsiveness affected?  Delay until the QMP greeting is
>>>    sent?  Delay until the first command gets processed?  Delay at some
>>>    later time?
>>>
>>
>> Responsiveness: Longer initial delay due to early pinning work we need to do before we can bring QMP up.
>>
>> Greeting delay: No greeting delay. Greeting is flushed earlier, even before we start the early pinning work.
>>
>> * For both before and after the patches, this was ~0.052s for me.
>>
>> Delay until first command processed: Longer initial delay at startup.
>>
>> Delay at later time: None.
> 
> Got it.
> 
>>> * What's the absolute and the relative time of QMP non-responsiveness?
>>>    0.2s were mentioned.  I'm looking for something like "when we're not
>>>    pinning, it takes 0.8s until the first QMP command is processed, and
>>>    when we are, it takes 1.0s".
>>>
>>
>> The numbers below are based on my recent testing and measurements. This was with a 50G guest with real vDPA hardware.
>>
>> Before patches:
>> ---------------
>> * From the start time of the guest to the earliest time QMP is able to process a request (e.g. query-status): 0.167s.
>>    > This timing is pretty much the same regardless of whether or not we're pinning memory.
>>
>> * Time spent pinning memory (QMP cannot handle requests during this window): 0.077s.
>>
>> After patches:
>> --------------
>> * From the start time of the guest to the earliest time QMP is able to process a request (e.g. query-status): 4.08s
>>    > If we're not early pinning memory, it's ~0.167s.
>>
>> * Time spent pinning memory *after entering qemu_main_loop()* (QMP cannot handle requests during this window): 0.0065s.
> 
> Let me recap:
> 
> * No change at all unless we're pinning memory early, and we're doing
>    that only when we're using a vhost-vDPA device.  Correct?
> 
> * If we are using a vhost-vDPA device:
> 
>    - Total startup time (until we're done pinning) increases.
> 

Correct.

>    - QMP becomes available later.
> 

Correct.

>    - Main loop behavior improves: less guest-visible downtime, QMP more
>      responsive (once it's available)
> 

Correct. Though the improvement is modest at best if we put aside the 
guest-visible downtime improvement.

>    This is a tradeoff we want always.  There is no need to let users pick
>    "faster startup, worse main loop behavior."
> 

"Always" might be subjective here. For example, if there's no desire to 
perform live migration, then the user kinda just gets stuck with the cons.

Whether or not we want to make this configurable though is another 
discussion.

> Correct?
> 
> [...]
> 


