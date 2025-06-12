Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFEAC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPpeF-0008G9-28; Thu, 12 Jun 2025 17:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uPpeB-0008Fn-BP; Thu, 12 Jun 2025 17:39:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uPpe8-0006vd-N3; Thu, 12 Jun 2025 17:39:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJhbRB013359;
 Thu, 12 Jun 2025 21:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vc3i4/2e2dNa21kfDSW/vk8nY/zCcT1s3kUV6Vq5P/Y=; b=
 G2AcJXerlnPt2rcd0j8ce4rXxWgqHC8v4c7MM37Oablprchg4Axiw3tg1fE9vgZ1
 mOTsmrUquKoVMK/pNuvbewJXV/5jP3xOyfT616W2d2+Hnd8YkQGA4FTyMnGaH92S
 erHALGL2McZh+pdRVz2TQrtoz6RxphJljQB6uMERf9J9cXf24y07f4gJJzaB3flq
 QIUZtKMEFfXSuyKeZD+ussSXqAOU1MvfXC21f0bM5AmE1heoQFnR6xrOaPy3oh+Y
 /R2w8HITPL+PXqEpaumr4Nd+2I9B1TerLBIc5nWE1q/pwmEmdk2F7K33RvcIC0EO
 vDiiND+wMkedHs94Xe6fQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c752mug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 21:39:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55CLN5Gn040797; Thu, 12 Jun 2025 21:39:25 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11012033.outbound.protection.outlook.com
 [40.93.200.33])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvd4tgy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 21:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APXcvxs9S61fZ18W/7o1fCQMqhQJNaZrOx9CZ+fivQXCHYA4zNHbO4yQsRndxveZv5ZZhCFwHhh0oZQQ14mLjLbyqZov5WWanK9sRjP6a55JYZ31OViNAkTQllgwFcO15iNw40AuyjgH6GUAKgIXiVi4e+YxqZokmsexeBUpX/s71Acs/b8eoHPJZoJ4RR8dr2kem/pufkiwIOL/1Wr4dVNObZjuFf9iXuz8KnIqT6iZl/OnXLuIzC/wRL6gbjJEyqtA/U8C2kKCG+KeKqVmYbd5/yWJb8l21QQYgOFsPls8fSzNmK3vvd8LGLwABbk94JhXwT3pZ/tL96vQaNJG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc3i4/2e2dNa21kfDSW/vk8nY/zCcT1s3kUV6Vq5P/Y=;
 b=xbolDrHMBOq3naxJQaqleOL10c4sKEGIQ9eic8ucSDPlWoo9hVlW8Ij+bDdONiB2maa47hl1JqPVsBFOKGUVQKRyUCo0B0gqnxeVdNPPvDW0tRsXGcqKbxX1MIgckQPxW/DTDjzcNFRRg6a6PUPe1etoJUBLTfmLWCPSYVCj8LU7YphzNv4lGnZ4V4Aav8tzUED62CBi8K1lagwl+NR6DBa+uN0ntRGqgJXE+BASo8m5u96toD8XszEZI95GOzGCGd5Sb3xBdI1nHWidjj44zkcf/wHS16sDu9yWYBLj7oVVEtiYcIV0dr21tWYeyazvjqUC0BYob0ejiaZSrSGyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc3i4/2e2dNa21kfDSW/vk8nY/zCcT1s3kUV6Vq5P/Y=;
 b=jicwhCigypylklV8F2/QYbbATthjjAODk3s9DsLZUkTfjCPcULh0lFHtMPv/gqXobSfOwFGyg4WMGSN95/rZbWsNTKfLl0qYxJ5RWlydDzS0fCj4/txemOJgDniqpCLLpxq80QPFNKJoHtDncIAgluId4pp/xsloVAmADI8tJIM=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DM4PR10MB7451.namprd10.prod.outlook.com (2603:10b6:8:18e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.18; Thu, 12 Jun 2025 21:39:23 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 21:39:22 +0000
Message-ID: <06a32bb9-087e-4508-881c-df26176ab71c@oracle.com>
Date: Thu, 12 Jun 2025 17:39:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] hw/i386/x86-iommu: Remove
 X86IOMMUState::pt_supported field
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, peterx@redhat.com
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-19-philmd@linaro.org>
 <20250606154219.37957b34@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250606154219.37957b34@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DM4PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 3853e79f-43a2-454e-6a27-08dda9f9983f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0xSc2thekFuUG5LVjhSdzhDU1FaZWJVazdxLzZ0eWptMEtZeXlReHdtZm42?=
 =?utf-8?B?VTlpVDZuekw0V1lZbnMwaEhkL0VxeEhxbjJCSVVKV3ArcDFZTkp0bXVTV0JD?=
 =?utf-8?B?NWhoalpFall0MGdRWEM5WGtQVHNSeHVsS1FMd0IzcHF3c2pnb0NwalpXUWVC?=
 =?utf-8?B?SjdFbUhRaXhSdW1rYytvQ2E0YnF0aXN3WVlqK0Qzc256TVY3aTdnR3A5alJx?=
 =?utf-8?B?K3hVcFVsaCtsQ2pJdlVaRHZkQUhQb00zdFdlY2kxWU8rSm5ZMmY0V1RrNXUr?=
 =?utf-8?B?SmJlRkNMUmlZTDVOWU1SZFZ2MXpESEVlVGlDSS9veTh5Qm9HTmpzUkppV2lp?=
 =?utf-8?B?eUpjWjliUkk5ZnNKWXJOVmovT3owSXowQjQ3WVVERjExRUhkUDJ5RW5hZkdu?=
 =?utf-8?B?ZWVnd1A1NmIxM2V1Q1kwTzV2Mnd1c09YdXRuZitXYlJjM1c0eXFUS0V4OHdi?=
 =?utf-8?B?UFRQOVhydERJY0xaSmY0cUlZN0VTTFUxWEkvZHptQzM0cjV3anlGbFpSTjJW?=
 =?utf-8?B?WU5wVFV4aFFSbEdXVFowL0MxQVRyYWNHaHJlTkQ3ZzFxZHdWRlN6azd4SXc1?=
 =?utf-8?B?a2xhb1dwZURHZXlSM0EzUmNVK3dhTk9OUjgzZGpLem9adEZ5aFpCb2hOTHBr?=
 =?utf-8?B?WnE2bnQyTEh1R2szUmxDVUxUZ1AzWWZlTHU2YU5aczFZTWRwckZveXYzTVRV?=
 =?utf-8?B?VHA2azQ0UEx4ZjA3THBKY3F3QjFRV0pDUzFmcXFiU1FMTVh1UjVhcXhpajFy?=
 =?utf-8?B?WklBS09SODZ5V2NCMUF6MUw1TVlUUm5YOXNzVFVCZ3NMYUI0MXBzSlFIUmoy?=
 =?utf-8?B?SmJWOWxFZkQ2Z01wbHlZcUtQQ1lUakpvaEZJVVJweUg3SjZuY2YvOVphUGR4?=
 =?utf-8?B?b0IvYjZUQUp5SjM5WWEyaTd3SU90bFQ3ZE16T0FvMGQ3TTh6Qk5RU0pGL2gx?=
 =?utf-8?B?NzNtcjQ2dEluODVMVlN3eXBXVHQwVW9adktmRkM5MGIzcUZuZm15QjJDcEtI?=
 =?utf-8?B?TEdxNU1IaDFDZG5sd0RMcFpLelZBU3M5K1lCWGJXalU0anBpVzczemtWc3U1?=
 =?utf-8?B?K1JRN1F3QUdzMmlEVTVxZ2RPaGpzRUhlK09YczV6Z3lHT0EzWnl3SUhSVkhi?=
 =?utf-8?B?QytHdXc3T0VMNlBtV3laR1ZISCtPVXI1TWNjQXR5ZnlkMkQ0K00vSzNxQXZi?=
 =?utf-8?B?UjRZVFpveUpZUVVZWUtRT1hSY2tUS2dEYzNlUTZoRndlc3duTFR6VnFXQ083?=
 =?utf-8?B?c3ZZa2QxeVdIQmNONFp5cXBLK3ErZDJUSjEvKzdRbk1YQXphUFN5T0R4em1J?=
 =?utf-8?B?VVNhWlpsMlpXdHBLMTRxZWRFWnovbmQrYk1wOURIMGJHMmpKNjU3VFdUdjAz?=
 =?utf-8?B?YUkvQmlJcXU4ZXkxQUU0UjV3WlRnNmF2QTJHV3N5Kzk1OEtKaHBvRmZPb0hH?=
 =?utf-8?B?Q2JYVkQvSzQrSEFvV3k0NnJUNHdsbUpGdDdaRHRPd0dzbkR0cmUrV2dlaXJC?=
 =?utf-8?B?RVhwV2RKQS9UclRkUGdyUGkxenpmN3lybEZGby9RN0Yra0lTcC9qYUk1YzRo?=
 =?utf-8?B?T1lCNkxXR29tSFk0ZnRxdlRkQUJqeS80eWZTZlN0dWgvS3RFTjI1OFMvQXdq?=
 =?utf-8?B?TDBQalZ5VXJnM1d1b096ajZoSHJvWCs4S3JvQjluRHVBNG9uM0VIQm56cnd3?=
 =?utf-8?B?TWJFRkdvRTdVRTFhbXJFRFZROFVRdnN3YU91K2lBdlAwOE9rOXRLelNnWXJW?=
 =?utf-8?B?eTRVTldEbDd3bnlLWmNiZm9VUGMzK0RraXNJd2pKTTBoRWl3NXJ3dHBUMVBv?=
 =?utf-8?B?WXI4eldBUE9zcStidC9yNnQ3RnBxRU9UOUlRaVJPbXo3bmIvdW9NNzhqOEdl?=
 =?utf-8?B?cHhLcW5lOW4yK0hLRndIZElzcjV1MDlpWkhJUUc0K2JqM1BRSU11a0pmYVp3?=
 =?utf-8?Q?onwn4+3L+Cg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJEZlN6cnNQRHFYQXNqSkMyZm5LME54TDA1d0cyMWlVR243bXBzRUxGVTkw?=
 =?utf-8?B?N0lBakVSUC90cHREaGxET2tPUkh6RTVKak9TR0UxVDdZdHdYSFhteU52MFVz?=
 =?utf-8?B?Umxpb3orK2FIT0puNGthOHMvRUVFUlpTbUNiNEx4em9BT2FuR0NpV0RObkx6?=
 =?utf-8?B?QUxHSFU2SVNES0tKamJXN0ZPUFFmTHRXelBPZ21jR2R1b2JEUSs3TG1vcVhD?=
 =?utf-8?B?eDFlWnRmeWZRZDY1QllJZDRaeXBRWWJyTmJCREZqeW9QNFFGNU91NkJ1bG9R?=
 =?utf-8?B?Z01rd1pTQk8zRTlieERHYWFkc1grZHMvaTVSazdPTGZLT1Z5dzdDdHdtWkkw?=
 =?utf-8?B?Z3ZsdDdGbkdvVEJaK0NhQW0wTkFPOXJXRnkrQ0VoTFJtT2hNZlQrNWRQdUVm?=
 =?utf-8?B?ZThJUVdSa3lqZmNpSEEvM1hmdEZzUVlmYS9McUU2TGJXYWIxK0d1aERPRktl?=
 =?utf-8?B?MGRINi9xb2F0R2szbnpQb09lOHpFS2VSdEtqZURJUy81ZnF6VUhhaXdMenF1?=
 =?utf-8?B?Vklwa1N2c2xqU1lmQzA5OFZnRk1FZFpIUHE1a0luZDdMbnVVRmM1alA0Q25t?=
 =?utf-8?B?R2VJQU1YRnV3U2Zzd3hpSXBMWlpGbyszMXA5TmFaL1hlQ2FlWEExSFFpNmxu?=
 =?utf-8?B?SjkzMy9PYk84Ni8zMnAvZlJ3TlVmelZVcXc1TVB4bTJHTnBpNEVnL0pzQURD?=
 =?utf-8?B?anRqOXl3eVRtWDh2MFZwaVh2aHpuS1FGYjQxa0dpYmlPaXhQUTJaTEwrZnBr?=
 =?utf-8?B?bmk1bUZpanF1cHJtYUlxVjQ5RU5NZEtFQzlXd1p2VVpqelNXLzJKRHl1aks3?=
 =?utf-8?B?VEttWGRyWWRjaDU0UWtzRVk0WjllZlBEYlNyTm00bFFPUDVVMG8xMkQvYVcz?=
 =?utf-8?B?M0JiRmJKV2Zob3lFYnZvaUV0TlMzcGRXK0dMeS9uR2taVSswbTJwU3dIRnpN?=
 =?utf-8?B?dk9VclI4Z010Sm9HVlM1eTIxS2dESGNDYkFZQmdNOWh6cEY3aVZTNER6MW00?=
 =?utf-8?B?NTZmZ3VIK0NMaUhETHZCUVZoS0EvWXlyZDZaSE9MVEVHTGFCcHNCSkZBazhl?=
 =?utf-8?B?YXdkbHAzajJhTWh5MHB6YXBXSjBYUnFkb0xIZUtKNjB5Q0g4U1ZkZkI4Nk1L?=
 =?utf-8?B?d2ptdzJLcVh3WlI5eThRclIxMTZxbHVhVVFOallWVmNLNFhqSURBRU44alBU?=
 =?utf-8?B?cDBwSjJzWmZtdDRDYVhyazNjZDN4cHo0NytOcUdLQ3RHTXMxcmt5QTVQdHFy?=
 =?utf-8?B?dFFlM1ExWnlkNFNvOTZOL0pLSXY3V0VsUnJKV0Q3QjYyOEYzWVBQMzErMmhp?=
 =?utf-8?B?N1N2UCtoSjVzRGJTQUdaRUdiUXV3UlpGYVY4QlUxZkxZdlRxNFFIWCtURG1v?=
 =?utf-8?B?ZXZFR2Y4cWIzVjdERk94NjM4TXhjenI4UlZnY0FSU05HalRyakl1SXNsOSsz?=
 =?utf-8?B?WEZBbHk3UWxJRkI5cmRtWVRzYmhQTU40RVhJOEJmY3ovc1E3TFpPTnVvNmx3?=
 =?utf-8?B?SUhlSkF2U1NnM1VBRDYrMmtPVDdVZmtnTHJ5a3V6V05OdFd6VllneXdmVDJI?=
 =?utf-8?B?WlNDNG9nQzRhbmYvQ1MvMTdYdnVtdnQvc0lPVklTWWxxeHlVbXNzVFFxMndP?=
 =?utf-8?B?R0o0bTdWdmdUc0JIKzRhUWFGU0J6QUV5dVI2UkJUM3RGQzFjUkV5UW1zOEhs?=
 =?utf-8?B?SGN0NDZ6cXAxTlNxQnh5T25INVhsWEhoQjlWNEdXbkNidUdKZ1Y0ZWRBZVB0?=
 =?utf-8?B?VUdrangzaEMwMXJFeUgyOTZBWVlCK3F6OU1sTk9YdFVJVWNIejBITkVxOXJw?=
 =?utf-8?B?QWw4aC96Z0lSTjlZZTJCOXRzYWZ6aXF0aEVsdi9rTzdsc3M3ZUx6OXJTSHRW?=
 =?utf-8?B?TVoxSjNodkhNc3gwMlZyOUZZTnNPL0pRODduZWVLcXpseGt0V1BiK0huUUVF?=
 =?utf-8?B?eGxuaUx1bDNsdENlK21KUnZmTXJKQjI0c3JCT09RcnhCdGxCbnQ1ZVdmQmRV?=
 =?utf-8?B?M2VNN2pkT3pVdHI2MDREVDdCcHVhZ25vWFZnSmJQUC9LckRVTEVwZEw1V2Zw?=
 =?utf-8?B?bExocmxsY3Z2Tkh1N2lDME55ak1jYXVIcjNqM3E0QllPNURWaFE3VlpyeDBl?=
 =?utf-8?B?dkhBZXpZS0dEbzI1Szh5RklMYVVIbmwxZ1pGcHgxRXRJNnNHMGdLK1c3QXFO?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rDN5iam/NptAg+rUxtYQlokYjzdtpJxXKBxiQj9kczoxrU0Jf31wjRuawEefVKBT1XLyjKO2wizEEhy6e9sce531FtLVViLBr2BKcIfb3VtcOwlxXPsor9fp9pnz5BTohJHDNlwIq3XfqDvksOVmzGZHNNmDGVyP56+UShdTwZmmhXBiXnspkOBhk2WUbisrYQc+5bJ39/xk4L2AWfOc6qRY40nI92RWKozNEQiaoTDQdHmLewh7NqVmK0i/KeVaBE1SSbaPY/cWeFAdYWjSesSh5c8dX1PGVdSp0BTLqnrfmHKonfFukDdhY0cHJvUAfqB+fbAL+OEe2mG4kaqGONcz52U3v4oaTX3pc4UHlpncCvxdIQhWZSLYFDpsFXLFvRZ3EAd9cBqbO4UUq72+MBYzYCfynV7Wd+0PIm4M9DusJZ9Gen9oXulPeflZZjYj1JYuEyp7fFcsKzNt8xg9wb4KvmvjJ0DqOupoJHM7Qg+emBTV+rLVy0y9BvCuhOyDnYq6haUFuoxOKoV4uT/yAVR7Sox1FOfEmlSP7V0zD/k618WDW0l3RcY0c8ln6eJjC98yjw/5+ScxRGb4wH3/p2HbLBg/S51Ywxvypq0w/rE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3853e79f-43a2-454e-6a27-08dda9f9983f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 21:39:22.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4AHdoVoObpd/o5tA7A0jfA5otOXtGJyGzSu6oPiu+CYe2A20vRWU3XEym43DhgZQLR/fMAB4SKM5WP/u9fKc99eSN/xgnLKWYKzL7HT1dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120166
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684b490e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=KKAkSRfTAAAA:8 a=PHw5SOS1e2Nrf6HnxfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6rGf3a8psT2lCSl-LNgyfQ1DEDQAf7g2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE2NiBTYWx0ZWRfX1FsGbSrTHFes
 sBWka3L7Iw/s3T55wAjNFkdw6+e4e3gOT+yeb02D9LpOk/UC8041F+PH2yFfRyLB54wVdWOiMTa
 yZW+YUWA7wsiNg8ZA5oqeUzBKljlaW49SnW6IBvphe6UrAIrLyTm83p5qFz70ysFnCEePzK7Pfv
 1nqjk0xU1sGxUJAnX0aJNlLdzCxXSNIFWglB4aj4dQVDqiY3DFsWP74eXfbrltA0at1lOUC0I5C
 /DP7snnWFydrNtoGz+FN7xsjbF6sleJ36pIgHLl/IjIX9UCojsfMahsm1kQAjYbtEN1wUYErDbe
 52jk1AjJNIHEuZdOmLztiSKaFp0+REpaOO2Pe2GrOHExF8MzaqBm50kJ7MRAT6AHPoMIkT2u1Ju
 Mb7eJAqVUWVgxGQkpltbbdz+YhuZvW5KjvBHqYwjN+m1GBl5shsdVkd8lCvgGatvxSc7ckxN
X-Proofpoint-GUID: 6rGf3a8psT2lCSl-LNgyfQ1DEDQAf7g2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 6/6/25 9:42 AM, Igor Mammedov wrote:
> On Thu,  1 May 2025 23:04:56 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> @@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>                                               AMDVI_INT_ADDR_FIRST,
>>                                               &amdvi_dev_as->iommu_ir, 1);
>>   
>> -        if (!x86_iommu->pt_supported) {
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
>> -                                      true);
>> -        } else {
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
>> -                                      false);
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
>> -        }
>> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
>> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
> 
> given default is 'true', this hunk seems to be backwards,
> shouldn't it be 'else' branch code
> 

I believe this is trying to preserve the change recently introduced in:
31753d5a336f ("hw/i386/amd_iommu: Fix device setup failure when PT is on.")

However, that doesn't explain the logic of enabling those specific 
memory regions, which I think is also prone to cause confusion. I tried 
to explain the "trick" and argued against it here[0].

I am ultimately rewriting that code in a series to add DMA remap 
support[1], which hopefully makes it easier to follow which memory 
regions are active under specific configurations.

Thank you,
Alejandro

[0] 
https://lore.kernel.org/qemu-devel/914314b3-611d-4da3-9050-3c8c1b881e40@oracle.com/

[1] 
https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-alejandro.j.jimenez@oracle.com/

> 
>>       }
>>       return &iommu_as[devfn]->as;
>>   }
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index c980cecb4ee..cc08dc41441 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -1066,6 +1066,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
>>   {
>>       switch (vtd_ce_get_type(ce)) {
>>       case VTD_CONTEXT_TT_MULTI_LEVEL:
>> +    case VTD_CONTEXT_TT_PASS_THROUGH:
>>           /* Always supported */
>>           break;
>>       case VTD_CONTEXT_TT_DEV_IOTLB:
>> @@ -1074,12 +1075,6 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
>>               return false;
>>           }
>>           break;
>> -    case VTD_CONTEXT_TT_PASS_THROUGH:
>> -        if (!x86_iommu->pt_supported) {
>> -            error_report_once("%s: PT specified but not supported", __func__);
>> -            return false;
>> -        }
>> -        break;
>>       default:
>>           /* Unknown type */
>>           error_report_once("%s: unknown ce type: %"PRIu32, __func__,
>> @@ -4520,7 +4515,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>>   {
>>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>   
>> -    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
>> +    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
>>                VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
>>                VTD_CAP_MGAW(s->aw_bits);
>>       if (s->dma_drain) {
>> @@ -4548,10 +4543,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
>>           s->ecap |= VTD_ECAP_DT;
>>       }
>>   
>> -    if (x86_iommu->pt_supported) {
>> -        s->ecap |= VTD_ECAP_PT;
>> -    }
>> -
>>       if (s->caching_mode) {
>>           s->cap |= VTD_CAP_CM;
>>       }
>> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
>> index d34a6849f4a..ca7cd953e98 100644
>> --- a/hw/i386/x86-iommu.c
>> +++ b/hw/i386/x86-iommu.c
>> @@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
>>                               intr_supported, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
>> -    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>>   };
>>   
>>   static void x86_iommu_class_init(ObjectClass *klass, const void *data)
> 
> 


