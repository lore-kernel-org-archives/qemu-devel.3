Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D184C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFdwr-0005tw-Ia; Thu, 15 May 2025 15:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdwp-0005tR-VD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:08:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdwo-00056g-0f
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:08:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1oi4006321;
 Thu, 15 May 2025 19:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=VvFyK6032cyTPYPeVtzlQeLPYg/w0hz/zznsWDpAi8o=; b=
 DX7DWR/FPJH8jHYhAXYxZcJGXm3EdGfPMQGzFyI83nI66gTRFK8GBGMqlrx2lPpy
 gjIz89PBRCenNUZpsAGiMDi9+dk6sTdIhimWechTzyz6ljlYR3NaD9pZkwmYitFB
 PhC9mgRVPG2H+2uSXOSufrmSsAxTLQjQaWUre4/FMWkGi8mqrNc/RlQhTaTtO/Ko
 Kq2yiuRsJLI2WBWPYJ5PI4Rmm+nozWVOIwzha9an+FLaWVoW5pv9Ol/rIHCLza2o
 +6S//po4oBs+IcfyX4fGd7d8d+fchgLYdyWRcTjgxLJ6pmajcIwKsz4M4wOyoK1u
 nxS7w/5CtZOfg6HDcsl1Iw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgvy5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:08:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FIV1vx004253; Thu, 15 May 2025 19:08:46 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013063.outbound.protection.outlook.com
 [40.93.20.63])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mqmdu666-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAvbKQAonRysa/nFbMpLE3UGO/UKGbkJV3rWB3HS1MqhVqg/Qig8Ki90aPm1g8L8pj/YpKLYhtgzUvYOS+AXepiYz6SyqCfoA/Bhl2qJ4VFn8iZTSKd6+DiKTeWeaMQrNDcbQgcMZZvk75s9cFq94dcZuie5kvegBy0Z66lMFXZMXfTkaPsEfXM3d8cx2n58AWYRoszrnGgnIQLNP79hqSSOgy47SCJVLF/7pNrRgq4AFAJL9eDN/X9nCPf6slOHDSoVzcXmVho/kfmGHYeCoqBnH4Wj7MPMmxRaxpzpd56Lb+b2/aO1qNR3o6YnhfWE/2wAE/QA1AxkLs0ni312BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvFyK6032cyTPYPeVtzlQeLPYg/w0hz/zznsWDpAi8o=;
 b=pEtO2HksTgFTpMIzGQct1Qxlo7dZADVLn+471a62eFlcFStnL1Igwca0w5YArqKRTGTgk2EVqUGmOVqRKUBv2qyveRTc7qCGnew47izpoT+vVlrto/U/SNZU5La8PdVXsFn0aAl8eV7dvj9uj8GwquveOvsW0Av+GpJHjXNrg05HjWKSUaFZ0KsXRPUEMQWSLxwhGu+C2cvrKUAReBnOb4KWdbOmm90Fd3PW0UYRKU8ANnsh9SqjR06XERKtdtiMOJGnXLQrd2UgASrRzWBOnTFNbMo/bgydXxGtjDVk9x4nwhl3ij19kts4wxYS6cSvMNde264O1W7ZTzlSoRdGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvFyK6032cyTPYPeVtzlQeLPYg/w0hz/zznsWDpAi8o=;
 b=N+74OxyXqr4al82Lh8keJhnpzL+iLiB6xHcPk0194B8a0tRCyTVseyUgC/B0py+nNlgcpvzA1+bAzZeEAKNXapoySYZywEcNoFYetrSMAaxYBVVLvyMj6c5FYVGMkGG6AOSXWDmL9fI1ylyzn6lgrl2wtKyPBUsfwnA/5wsZPaU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 19:08:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:08:42 +0000
Message-ID: <f67b2a28-ef6d-47e0-a35e-4938622406f0@oracle.com>
Date: Thu, 15 May 2025 15:08:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/42] vfio/container: export vfio_legacy_dma_map
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-9-git-send-email-steven.sistare@oracle.com>
 <45f4a597-f25c-4386-a410-e8892fd584ce@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <45f4a597-f25c-4386-a410-e8892fd584ce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0893.namprd03.prod.outlook.com
 (2603:10b6:408:13c::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: b717d3c5-7276-4590-8952-08dd93e3e87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGZQNXhiSGxOMXMxMzhVR2hDUFcvYjZ6bkh3THdjbTZTTVo0UlNJZHVEemZx?=
 =?utf-8?B?N1cwL3VGdVE5WXE3T1NqUWQ0SFEwWTVPa1JLMzdLNUpPUmtQWFlBdUJtLzA2?=
 =?utf-8?B?SzdLRnQzZGFFZ3NpOXhUWHp3K1U0cWcrVkx1azNhODNPODRJQ2p0OXg3V3c3?=
 =?utf-8?B?em1rb2Z3TjlzSzFjQ0JVaUpUV1krQ1l5dTVob0pYeUFlYXFha3BrdnMvN2hC?=
 =?utf-8?B?TTFKeXRPTG0xamJ3YUJFWXZOSUJuVThsTjlnOVIxWGJEWU5VZlZJYUJnWXpq?=
 =?utf-8?B?a24wUnlnV0NWUFM5SWdRTUdyS2N4Z3UwUSttVi9hYTc0WWY2RVYvVlRTWFM4?=
 =?utf-8?B?ak5wc3ZHMlJhZkd4RVB1SGZNVHZFWmZIQjZBK0Rvc01vbnA5Y3phN0VHV0E3?=
 =?utf-8?B?NlY3Ujduc216cFFpQlBVYlp4alBjbWc5L2VRU2VvSS9HN0dnbjlMckc2RG5L?=
 =?utf-8?B?MmV4a0s0WDFSdmF0UzZNZDZWN3JNdGwyMUI1UDUvWEZOcmNGdmx5TnBESmh2?=
 =?utf-8?B?Z0ZybmUyMW1iUVpyOWJ4TVMwT254cGszWmQ4VDJUUHFqdzhZVkJFanBoMmNG?=
 =?utf-8?B?cUcrWVJ5WFZDSmVzMkJPU3FYc1p3TnhPKytscSszcHo1UWRVTzRiOXowY1N2?=
 =?utf-8?B?REtLdEpSL3J1UVhUYitSQkN4THR1M0x1cDlQaU84YldjQWxZWFl5c2JGRFBW?=
 =?utf-8?B?MUMvRHB0eG1JdkRZa3pyWkxKME1wTG5wdjVIVVhzdTVhRCtIVVZkdXUwNzY5?=
 =?utf-8?B?MUxzTFkvcWZHZmtPaXhOdVkvbDV0N0JpdmRUcUhhNG1lS3N0My9MaEs2cEE1?=
 =?utf-8?B?Q1daUnE3YWVYQzloTW5nOCt3b2V6VSt4QXYrOWQ5NHVOL0xkVnVyd04ycURv?=
 =?utf-8?B?US9KNE13YnU2VXVIb3c3THNRZ2V1VjFUZk0wUGNmVERLZ255ODBkbDNYUlRt?=
 =?utf-8?B?Z3YycytZRUZCay8vVk5DQjZ2SnN6blhIbisrTE5UYlNQWDIrU3VtYmYyYWY2?=
 =?utf-8?B?MkpIbExkcHlNL0hPV2Z2amgyeHZYcFNMSjg3aEJVTWdPTUJnSjVLQjdYcE9L?=
 =?utf-8?B?N1FreGxWN3dnUXdObmNkRWtLeW5FTW1yRXQ3NHdBKytBZEVpb2xKekJtU01s?=
 =?utf-8?B?clduZjd3TUhsU05aZUg3UUhiUFhLN2NvdkFRbGpJVmVHN0pZMG9NRTdDUUpm?=
 =?utf-8?B?OGNKSTBJNmh3M21rZHZsTnZDd3JKQXBFZzZBS1AyV3lUenMyRTVia1NHcEZs?=
 =?utf-8?B?cWpwUFdwT0g4TFgwaGFuWnB3dGlDbWFobWhZN2wvL1RxUnJLbTRZUThqTlVB?=
 =?utf-8?B?ZVhMN0tjTDhtVzRKaElQTTRoQlM3MzBYNXRmME1tSGhnc29sS3kzUjNabG5Q?=
 =?utf-8?B?c1ZzcmRQVGtFNUJ4bWVtd3FoS2E4UjJxc3ExeVViR2crSW80Y2hRZmlIdUZD?=
 =?utf-8?B?VXd6UmRackI0V3pxWStRam9mZWY2a3FCZzZZRGQ1WlpRN25zS1YyWGNNS0hW?=
 =?utf-8?B?UGNtcDhjWkZIMHVnYTUzNkVQZ3BxdytjcVdtdzM4STdUblNOLzVtRGRYd08x?=
 =?utf-8?B?N2tjSCtibnorOVV4Ny9ab01IYnJmd2NzR0kxeUp1dHU5aFdYZHNGS3kxUnVN?=
 =?utf-8?B?eDV3Y25COWtudG9TOUIvOUR4UExBWGJvSmdrbVp2RzBCQ1hWWHJyQWJQL3Z6?=
 =?utf-8?B?L0JyNXZmSE5PNXh6N2taMzIrOWVDdlJQNWVuSzBGYTVGVG9sSDcwckVMWTll?=
 =?utf-8?B?a3VZNnlpMmNzR0JiYnU0NmxCZGdXcmE5VmlvWnVxdmRJRFdUU3Z2Z2FGak9X?=
 =?utf-8?B?QW95M1RUUnVBaHZ3clFCczJvU3dZTHh3K1M1RFl3VTI4UXBoUGR6ZXJDRDFD?=
 =?utf-8?B?ZnZhd0xlSkhwWElFNVA4ZzJYNTNSMXBTSGlTeUVvTTFjTTZnc1YrR1hJRkor?=
 =?utf-8?Q?+hUiUuCuvTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWkzZFk3OXJ0aW5PMUtEb0p6UEdEd1p0OWRzVkxmd2lBWXlNeWlnY0dYeHRX?=
 =?utf-8?B?S3dZWkY2QjVFNHVVMkc3eStId2NIOWZQT09sODdGSUNIOWVhTzRBcllqdWwy?=
 =?utf-8?B?NE1LTXZwcllFRG5XSy9uVTlUc21NUENDMytQZGhReHVQam5rOUwzY3BFeVN5?=
 =?utf-8?B?Zm9PcVZFamtaMDRraUc2WGdJd0JhV1I0bXRHRnUzTjFhcHdkYW9yanRZTmZC?=
 =?utf-8?B?d3ZSMkphZ2x4dzhhdEQ2QUhTY2tjd3BTQ0F4Ykowa2xzY3BaZGJIY0JoS2tW?=
 =?utf-8?B?TWE1WnZTU2swQmxYRjNKZms4c0g5TWx3VkxsOUtsRWJvblJCemp3aEtjWlJ2?=
 =?utf-8?B?T0I5dGZsNGIyZ3YzRXZkOVNTYW8yZEhCT3NWN1c0WUZtVlN3bVlWV2ZNdkxK?=
 =?utf-8?B?VXdLUGVnc0lyb1Qvd3Y1U0Z6Z24zMVYwZFZSc2wxSlVWMmI2WExBVkF6TVV5?=
 =?utf-8?B?Skh5OEkyemFxOTU2V2h0RUMyYUxhRG13Q1hFdXNaZHRMd25TYXNodzNObUlk?=
 =?utf-8?B?d3ZFYm9yNHVQeUZJeGdHeFdrNkx3VEVmbzhLTG9EWElWR2FWQTVEZzBmRUFi?=
 =?utf-8?B?ejV3Zk1uN3ZZekFSUWdrOXF1ZE13SjgyazU0OXRKVXBpUXNnTWQ5VU5rUFc1?=
 =?utf-8?B?YlVtcjEwVDBwVkp0Y3ZKajYzRnZXa3RxU3BEZGVNR1lqZld6K0lPQytjb0RB?=
 =?utf-8?B?SG0xeGtXSkNXaUJXT1l4NkJ5QTJHaDd2Y1NaK3poa0ZnT1BFNVp4VVRYRTlT?=
 =?utf-8?B?aVBBdVJHWXBrT3hYYk5uUkJaOE1HdDV3UThramtHT3ltRGRHZFF4NEFaaFVD?=
 =?utf-8?B?ZEVQdXJBMEtPc2ZBdnIvcmcrSk9BME5mRXBCVVFtVzhwTld4d0FGRlVZM2wr?=
 =?utf-8?B?M3Fscm50cmlvdHQ3OUVVd01Sbkt3QXZmN1BXNzlPWldGa055eGpIOGhaQzJu?=
 =?utf-8?B?cFJMWEpwejJaTnJvQWZqaE5NMjFKYndJMkZMNHArQzZ1RkFpYXhlcFBUQ3dw?=
 =?utf-8?B?UGt1Rm1Odys2aTM0enNOazRkK0s4YkNZbHAwb0JnTWtnbWdjaGZmbHNlRXk5?=
 =?utf-8?B?d0VXMENMZFdqM3Jvcm91MEVIQXJjRlZPZFlQK0taQzJGbzFXNzZPaE1HRzli?=
 =?utf-8?B?eDNxZW9uaEp6VVNZUUhRRzY0VE8raFl3d3JGS2J2ajE3Z29PV1VyYWVnYmZR?=
 =?utf-8?B?WG55dEE1VlBXL3IrZGdkUVVCcTUrUEYwcFd1TE1OTEt5UmtRdTc5akhIV3Ur?=
 =?utf-8?B?Nzk4MHpENkd5aE1QdDMvcVNxUmc1d0l5aDIzRVFUMEJkZTlBVkFIS2dTLzFq?=
 =?utf-8?B?aW1pZTVQdmVqYmdFVXh0RndRVGsxTXVOek53emgzVWhsSGJ5K3JQREZEUnlu?=
 =?utf-8?B?Mml5S2VkczRreGE0MjZuc3VNa3BnZWNHRzA4WEwraG5vSkZ5d1RST0tKMENL?=
 =?utf-8?B?a1h5eVdCdlBMV3hPajZxelZBcmJiSDJmRStMcHdnZFp4S1NWTVhhdkMzSUpp?=
 =?utf-8?B?Y3NRb2IrcFZYWXRjVTVZZUJJK3FWNlFtOUdIalJUSGk0bUxBN2NOSUpxcU5j?=
 =?utf-8?B?a3pJTXR3bmJ5Qit2dWUvMU1hS0JFU2llSlFZNmF4eCt6dy8wWHNieDdqcTI3?=
 =?utf-8?B?c0FWZnVZQTRRVGI2cXpKTWhtNnVpRi9VeWxOREJIckdCbktzR01oTTQ4TWp4?=
 =?utf-8?B?b2RWaTRsL0tBeUZTaFRabXJrZ2kxV3Q5Qlh0UmpVUHduMUtnVUUxa2tFaFVC?=
 =?utf-8?B?K1hDVUM2Y1B4RHhYQWc5WnZBdkV6d2N0ZmxrUzFucThhOUVyUGxLcCtzRmh1?=
 =?utf-8?B?dWxlYm1nOEN1Zm15YkVoRTdwNWpkSUNtb2NTQlJ5Vkl0OTdYY0tFWm9ydmRw?=
 =?utf-8?B?KzdTMm1ac3kxTXluWVdXZmFoRDY5bWFQMExVaG9mT1djNHRlZDZ0VFVLSHMx?=
 =?utf-8?B?djRJejZ2WS9aWWQ3WXJyM0U0TThjcmlNZW1uME9rKytzdk1TSmsxd0ZSNHFK?=
 =?utf-8?B?dmh6N3pTTWFncGJScjFFVEY1VXkwSFQxdWdPcHJvQ01seThtTzJZRGRsU2JT?=
 =?utf-8?B?a2hEQktpV1MzK29USXpab1c1d3dCcFVCa21xeThPUGFpT2dFajhEWlZVcVRt?=
 =?utf-8?B?Zkg5Y3FjS0o1MmtCcnludGZNWHdOYmpxWWgyMllueWxvOUJ5YVo0VkxIT1Y2?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qzwa06W16zmKoZPKh12CmKRiVnVpl/ocMo/XAsVLyu2v4p5Y/a/G4LaykFfzMckozDpP+bQbFyEoKooEWF0HXL9+hofGEjpf4s6x1gFSQvg+eOHsktp0vMdWPHl8kBC1F11eGh+7IZYOgiMUGWNtLFJ55E/6zUfNRiAZYOZETrghBSxx+9HTSQc9M4ZiWq0w6KRaV2gqDLG2e/s0zqZHKt8ucG4lAxcR/EIx8wW2DMvFWM7ggrRnsXHerWQVoENy0kW+Zbkb8h3DiuklSbnEUko1Dm4JHQYe5BxJrRcmwVIqVEyV8TbcDA9fzumd2Rk2HTB/CMPDWTEqfkdqAmMKbCNN1FhgTuUJIrce5H72c2svvk9JHeg85fjJgjuoPs+DMdt6aIIzTH9uZTkCHeQnyI1f5jZfhirdykSzs2OCDD0uUH4Af3iqhHnKzoUN0jT1U6T2SaSOTdPwVibiCoHWo6ZTbmwYbYQtSm/o4xew7L9kSuGtnpKNygTJBSgt1Uqx9DvdOUTak5I8xwYC4QxhI+QNPIJNOMmHj0TNGP4FZq8zfb2/hw2vJ+zoX5IUp+M9F34h8gXplsNijYkwrdNg93EvdbaP+HJLVK07AKw03P0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b717d3c5-7276-4590-8952-08dd93e3e87a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:08:42.5084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w19Kq1m+QzUohbfSk21GwH9ATJJLIPXq6izkx0h9ixc4NGyGKBYOHMouOJmRy6Hlda+GnNKLFWLmaMGZflHduJsXvHVjwME/jy7V8jGs3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4OSBTYWx0ZWRfX2nUHX8q4dAFx
 jjIo8tY/Fxt8BArVfJPwQMD5WeFUganozBdOKtBA/TFGwPofBogzAipYFQVjuEf3vTcDqIYKk5J
 hHjoLfSpropa0xFnzuXenSEKch5wsr5aV4jg5mqADv4rCgeHarhLbppYIJ3HnV4ZIIwveSzabZ2
 XzlXOhagdNO8JbrOPEhh5Iqb2RR4BdbeYQIAlDbTBT/o0LyII+40mlgmS7oDkEZTkiX1CaW0LX8
 ctjqQkPbHfRNoteOlA7fh6rNN44PO/i9zaYyS6RNSHSxcl4WyebSCQe6ky3CSoXFWBTT1v31k9Z
 Q4m9TBz0QJWgmq7Jkzpe9eF1G8du99e/nS/t7ORWm80YeMIiSuTFPphZzmn8qyzn3k2gf2Ugj6M
 rUu/e7KUqg2K8Ua69kURvtRCSodg90B9xzuPvIQQx1MTXUp27oLtVLNMvp5LvrcaxT5CmtM0
X-Proofpoint-GUID: d1xjwht1HnrZMHLiZyAAk_R41zck_fGz
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=68263bbf cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=VaJYI7sJDJ9SQ48ImukA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d1xjwht1HnrZMHLiZyAAk_R41zck_fGz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 5/15/2025 9:42 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> Export vfio_legacy_dma_map so it may be referenced outside the file
>> in a subsequent patch.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c                   | 4 ++--
>>   include/hw/vfio/vfio-container-base.h | 3 +++
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 278a220..a554683 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -208,8 +208,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       return ret;
>>   }
>> -static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> -                               ram_addr_t size, void *vaddr, bool readonly)
>> +int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> +                        ram_addr_t size, void *vaddr, bool readonly)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 1dc760f..a2f6c3a 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -186,4 +186,7 @@ struct VFIOIOMMUClass {
>>   VFIORamDiscardListener *vfio_find_ram_discard_listener(
>>       VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>> +int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> +                        ram_addr_t size, void *vaddr, bool readonly);
>> +
>>   #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
> 
> I don't think this export is necessary. See comment on patch 10.

OK, I will drop this patch - steve


