Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDAFE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpxG-0006XK-HK; Thu, 12 Dec 2024 15:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpxB-0006Wp-GQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpx8-0006di-Gv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:33 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJgBcc008382;
 Thu, 12 Dec 2024 20:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=aiZ4xNCvo6X9c2oYqKVT+GQecZ9r8y/NThlGppyxtgc=; b=
 hslbCG1pEc7qY6soq/zCidwhFXg/fMRyZ3LEl6PiK/puX6Ny1jNtjTUrXoJWijSF
 OCXwAr3y62ZDgTMc0SfJXiiPg4KuGgQv/1E2CwJRur2stjoLeLytbSU1k6sOWVx7
 kHFES+NtW7mPZtGkKyRnJya4aKtyJGrbn28T7rgBjlgdKYTdOZEWwzcbhwX5FtfM
 fuVhlWj8mXeiu9FJ11VIPmP90ZuTvdCV/eYb99f7czcKmij2PBXehO6s0RBfibm7
 Vq1V59JXGfZgjO62k5Gtirw38YD8m1KVf9wY1OFUAhN+GpaKoE/ao+apJxJiiOeI
 reKuHoVz3ceZDYpRXbSxdA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s97xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BCJceha038087; Thu, 12 Dec 2024 20:38:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctj98dp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzI2q5yEe6g8vT8Omj1lilic2xctms9SqSTFQL4QYrRiUBOVLZyuc0ZfdxSSUnG0wLA5oUdPzaNFmFp4tkyF6epLjR128Ke7yvey5GN9tUg6FL0OQ34zEcUwH68LCI6qWLvJH6i/VEjg4A3+eMPzS/my97bK0tFCDDYagIC2BtutQvC7WQ3DNus7DTK+W9aPV33pRG42TBgtW/hX6uNAeBV82i1TDgm4lyNCbIHF1WMGz9jKyV1Zz7XMfQzBgfxBMUew7++NL+2SbIiX1TQ1U1e0oAsyxxuuLtuKr8L4vUH5MsVu3FulUipkp5Hex/55NYYDH3mJUPwzOxewqLjx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiZ4xNCvo6X9c2oYqKVT+GQecZ9r8y/NThlGppyxtgc=;
 b=S6KtPO8b3k0BUROfuvUWcfrhr6lyr3fxXezTvv6LVX0aFK/Rdrq995F2rOul7wmc2pdAPT9CypCqX9bmiiB/tD6tcWpnOzpTsSeMaDoow2UNqK8QuWURXCwywt7hPCt02zehRI1qaKMKPoGjjG1AQkXcvwN8467EcDfLr2XreBflZAj6jQ9oGYPT6b6Hyi+MX7THggTOA6RpOREapSLE8HamgUWj/CL9e5bZZuifTRrlqdfVx7aE2olX7ndaJYTaO90qsKetazVoIWyzIgIsWoo+6ttgB16YTruVhY1NoNYDVbOxFQx7Z89IIMzVZSwzTk8HHo/R3vhAgfsOcLvaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiZ4xNCvo6X9c2oYqKVT+GQecZ9r8y/NThlGppyxtgc=;
 b=JMEdNdfpqP/h5s8zjTX/h1/lMDM/IkJzh+AOG+KdN2Rmbxlr0CerkvEOIDt4UaettZjk8REYv2qGtsk/CFIQdCO0nVXGJvftV+6NTJG0uiGHeDZmsLSvTpCLfCzSIeKG5eTWL86pq6d52KxQ2PL5T5AeWN6ZotxnOZSvrQNYKH0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:38:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 20:38:17 +0000
Message-ID: <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
Date: Thu, 12 Dec 2024 15:38:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z1dOBioqzQmEwW16@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:32d::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d24786-72eb-49d6-59c6-08dd1aece89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3ZNL3k3MjFVeEpmclloVXFFWWVKZCtUZ3FtNnVVY1h3dEsydnlibVkzN0xH?=
 =?utf-8?B?K2ErZWFhdTk5RERDdUJFTjVNdEJoQ3ZZTjZtblFES09BWVNvUWdLMnZIbzNm?=
 =?utf-8?B?MVh1YzB5Qmc1VmlYNi9WeFc4ZjZMSUJpVXc2eDFHcUp0T2IrdjJ0dVhINXRj?=
 =?utf-8?B?SCtxYWd1bjEzTmJ1TkhMbmJ1Ry9pUkVwUGlKeC8rSWZaalhoL1Rya09kUnhD?=
 =?utf-8?B?VXNCeEQyY0JLeGxlZ2xxQkpoQk1tUW1jU2lGYUZyakdrNDBiNFRBOTErNlZE?=
 =?utf-8?B?amt3d0FudExWTFFaK1N1azBybFRFSU5hai9GRVVUTFd4RlJ1eE8vWDNpSm1C?=
 =?utf-8?B?amVxYWwrZmJROFNxWmZtbXRTOWhBQlBXUnk0LytIU0lSaERlcDcvakhOdmNj?=
 =?utf-8?B?bEJDa3d6SjR0cXB0UGVrRndTY3ZWdlVoajRTbVRwUmluUFdNNW9TUmtDeHRm?=
 =?utf-8?B?Zk8wWjhmWjJkb2FzM1pFMkE3N1JEeFNxaEhmRi9sQ3lwNHVzdGxjRnZSRU5Z?=
 =?utf-8?B?UnhLU2lhMW9wMDJRVnpUN3M0Qzg5ZlRBQUZFWG5jV20rS2xPdXZ1MVNBSWs4?=
 =?utf-8?B?S09JYTduV1NzL3diZnYyUFFCT3ptT29senRLWTVjZW8vczVkNkJQbnhYNkZ6?=
 =?utf-8?B?eTlpc3N1OXljZHpGOUUyZHFaaVMxeWdob0E4eEtVWFY3cnYwckU5bHIzR21P?=
 =?utf-8?B?YzJ0dVRpMjlSVk5JbUtJTERIalZ1dnU5S2xHVGllQVZSelN6SGZMbXkyUFpl?=
 =?utf-8?B?VXVMUlJmWUV4ZnpNK0l3MmhvZ2ZRTHNIQ1YrbUtwNTdLaktlNFFBTzR0a2V2?=
 =?utf-8?B?WmtHUWJ5ZnF4aEVsMHJzTWFUQjRFem5TYko2UHlCem93OEIxVkhaa2RMUlJ3?=
 =?utf-8?B?MlFEbTl0M1VnTmdUbStuNVJ3eWZ2OWZLZTBYZDJZWHhsQU5rVWlOWVBLRDNi?=
 =?utf-8?B?cmpHbEhRUHNpSGZOS29Vc1NLM25XR0duTTg0TzBBU2lDVkNJYVExcFFLN2RP?=
 =?utf-8?B?b3FmL2tyOTZxZFE5MjVqSlllamt4alRiY3RUenk0TTNYUEpEdnhwMENaYkx5?=
 =?utf-8?B?SnVWVVN5WlZ6OTBCUjArSXJlblZrcnZTcmVPWnEzVkVhYkFKdlI1RDdkNTN4?=
 =?utf-8?B?RVVmWG41VkcrS3FxUkp2YzNuSUo2WG9PNUxyK0Z0c0FlK3BDOUlzcmJ2cXhB?=
 =?utf-8?B?cTVTV28wQzdYa1BmWDRzZVRNQ2tBQnR6RitMSmZUR3U0LzlVOG5LZHR6S3BK?=
 =?utf-8?B?VW5rMmNJYUdJQnVWUmVkZVlXZ0dQVWtLV1J5TkxwU0FpaGdrUHN2czZNbzcr?=
 =?utf-8?B?V24yY0FzRE1SZWhNcDV6Qjh6eEIybEZVVkRSL2I4cVErbXV3dERqVkZiZlFi?=
 =?utf-8?B?bEo3K3kzMFZDUFRRMS9YMnF3U1pVRkN6TVBhN3dVdXFnVzFwMTdHRzliN0tv?=
 =?utf-8?B?ZHFJQXQrS2Vkb3lUM01ZQ0Y0V0o4MXhrdkt1RHJOOWlzakdWRno4eVJkN24y?=
 =?utf-8?B?cEVscFRhMFVZalRTSkY5WCtmUm9YLzNIaDhZM3prM1kvNXBsNkpaY1Fpc0F1?=
 =?utf-8?B?Mjh2K1FqKzhRMXZVL1A4M2pFTHpPTXhnOHBBek9uUDA3OW9HQTJFVVIzbGQ1?=
 =?utf-8?B?UStHY3NFdEhCcDdBRi8vV0k2T1Q3K2VYU1pkVUg5cjMrVEExRHVRQzMxQU96?=
 =?utf-8?B?ZmxnR0JMTFErRnl2akdldnNiTUVJNFFEdXE1YnhhcHNMNUxMOFh4TTZjM2ZS?=
 =?utf-8?B?NGwrRkhwTTZUemZWOTNxak9EWWtjUUNnemh2NkUzTjd1NTB6NlZ0RmJISUc4?=
 =?utf-8?Q?mJziaDZMNwjZ0FDUx3fKkY1XbdCEr6bsCJak0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZ4VEJRNnc0SVJUOUJjQVovVnd4OXFWeWF5MzJESzQweXB4eHdxTzVseDNv?=
 =?utf-8?B?WHk5VHlhVzJYdElzQU41VHB0d0JMaHMyNnYzcmFXQjZFOFJ6RXJ5b2p4TFlm?=
 =?utf-8?B?em5yWFJKR0hpNmZ2dmtPeER4YkJjdEQwb2xCM0hiZWRiVWtuK1dMYjFlZUZT?=
 =?utf-8?B?L2xrOHg5U1RQOVQ4MHB0T2Rja3JDYTZPVFIxVDIvOEZwSHprOHJEUDRUaGJl?=
 =?utf-8?B?K3BEYkh5ano2SHBabHBtZks4cVdWQ2ZSVWlTdWZTbzFTanFzSDdnclJBVTRT?=
 =?utf-8?B?Y25Yak4yWXFDRHVyQTlGYjZSbW1meGtzeUVMODhuelNzZmZNOXZUV3BacGFZ?=
 =?utf-8?B?S3d2RFh2NWRUSkEzZGFoYkFTdUpYd3FodHFOZkVaek9VM3VrWTNIeTlWZFZQ?=
 =?utf-8?B?RzkzcjEwdXdxMWE5Mld2Z1dOT2tyRUw5QXRWWnlGWGZNQzBmK3krTW9mNUZI?=
 =?utf-8?B?djQ2a0IxMmRpY25BT04wVXZrUFV0WHdtQ2NZY2tFQzgvSlJCNFdLc0pBd254?=
 =?utf-8?B?bGhKbEhGSDNOcGR5bTN6Wm9Yc0tTVFE4ZW5teTJKV2Y2aUFsUHN5TUo4VVU0?=
 =?utf-8?B?RzdTbFhEN2FGNXVtazB1a1l4VzFqeXJXQUNyRDJYV2lsdUl4L2VtMU5qNjlW?=
 =?utf-8?B?WEUxeU5lTkJXdjcwd1c2c1ZVdnRRVm5yclJDN01jOCtOcVptSEtiSGJneERP?=
 =?utf-8?B?aTJ3ZFFVMzhnaEtabjNJanRHdGh6d1hTNmpNSTVlcElyVDhLRjlOS2h6V3lS?=
 =?utf-8?B?dUNaS3hQM3dZUGo4TFBPbmxtU2R0bVFtWktVeWhxcnMwWDNYQXZ5clpueTVr?=
 =?utf-8?B?YU43MlU3Rzc3Qk54bzZOTEpTNG9idDNxeEZwVlgzMzVid2h4cmY3RWVLSCtS?=
 =?utf-8?B?VEpVZWg4aUZDbUczanc1Vy9jY3d1YnRKYlNCU3FGMys1dnQvYkJwdTVYWWdy?=
 =?utf-8?B?dmV2WE5JK2xFS24reERuNWRTaFJOZjRFdVNtamNuK2pMcXZ6WkhhTm4xb09j?=
 =?utf-8?B?ZGJOSEQxd1o5T0g4OGN2MkJ2MmdBTHFScTBzOXhvWStXdU5IblVJekljNitl?=
 =?utf-8?B?WFBaZXU1azZETTVFeWNQaGt0eGx2c0VYSERCakxSUlUzVmpndGgyaVRqSytu?=
 =?utf-8?B?Mkg4a0s5ZjZIZlo3clZxeS82eSttK2I3dFZzT3hQNFhRV2I1QXpJSEhqRnlu?=
 =?utf-8?B?Qis5WHlSa0dnNTZjQVFaelZKZm9IUUdpdzhzZE9yc2VDUzl2alFadHVoekN4?=
 =?utf-8?B?d2dCMUlQSUJFa2dONUl0ZC9MS3hLU0RSckt2UUFVWXJkbmRQRDBLbVRPbVlv?=
 =?utf-8?B?UEZpVjJGY1dGakVocTVDTVRHTlhnWWRNRDRxZG1RaWtwNzBtbERydjgxVDZ0?=
 =?utf-8?B?eGY5azBHU0s3bUIwNWZtRGZ5ZGFLWi8zbzN0Qk5YbnQ3TmVxMDF1NFFrM2l4?=
 =?utf-8?B?WHRCU2VmMFVvTEVvWkpEUk43ZXRZNC9UMEtNZTJ0Y1VCUndRdUVvYnFHb3pO?=
 =?utf-8?B?ajNPUExzQWZyOFBYZ05ORUh6aWlscXdOUU55NWhRZHdMUFN5cjc4Y1RHVkZF?=
 =?utf-8?B?ZVM5dE9lR0cxQ25nRlF2TFY4Y3RSL0pMZm5LYXdweDNQa1haYmdHYWZrSDFT?=
 =?utf-8?B?NHpKLy9TRVd6ZitDd0dvT3ltaFZNT05HUUlUb011aXhGN3FoS0ZtOU9zWFBR?=
 =?utf-8?B?bGdOKzFpOVZoNW5BWXZ0WWd3TDJkby9ZbzBoa0JtOTZEYWZCKzZmWDNQM2Jn?=
 =?utf-8?B?dHJmSjBDZktHaC9oY0NQWkxONWlrMWhqUkJBSFIwQmZmQVZscnlFanBqZG9a?=
 =?utf-8?B?VVd3UDc1MTNRL01NQm1sdWNWbTdJV2hoL1MxWks3b3piOFloN0lFMUlWRGtx?=
 =?utf-8?B?YzkzYkV3QVlnanpvQ043blJkVEI4YjVYcGhFUFVIc01mZDFMeElJVC9RdnlW?=
 =?utf-8?B?V01GQ3YrVnl0bk5zQzVncTN6OHh6dlhIdFpWSkdrR1FDN0pPV29zODF4a3pR?=
 =?utf-8?B?VUJNcVc3azBleE9SdzNMMmN2SFlHUWdaeEo2R280VU1GZ2MvOVc3MUE0aFNU?=
 =?utf-8?B?WmdiZE1BQUl6RUJBQWp5cDN3Rm83MGE3WmdBMG5qdlRaWS9kTURvYm41MkRU?=
 =?utf-8?B?em5KOXdyWGtwTG5HZ2VWckk0RThvc2l2dnZDTWIxOXhiMTZOT3JYNTlUbitr?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BR/YwPrGK2BP+QnNbERzmbcb8Uc5wRcLxI834zNEk8yHn19Ky/fahoAETSjKKiQ3VQlAsGBVOqYCi8t/wmGT2gg/mKF/oNvpD542By0m3XTMYNrbwj9YPx6Bwww2S1M8FFSg9YVB84QDL5Njtk6pvpb4ip4H7XOPWo4fuPwwZ8tqpGPh6lN3i2DRjhuEz0zrfVZDr+FnCQoTrwvK8ZVdSblAx4kxz+JYMyjqfxKx6yk1zSMn6VWCVdpA83XRU7B7+t08V1Cv6QgJjkVQiheR444o2T3Gi8IwSq6wtHU9PizG/gXp7Q2GPyDg2SwGjOTu7ppE0Tb14xo13v5c/y1yiYqAmIo3ZTEmm31u7UMGvT4CcmOR2HqJRbpt/Fq43K6cZ/vIfGKgjYWeC0PBAencDLAuDNcpquH0uKCUJJsCpYfRMZ+xt8JrWuKnYRQHhJwySjO26IR5+f8ckO20MLhvkfd+/iycdlBHkXIxTtmG8sFToA+ww8ZHA4pRLfJ27s/m8nuKYuPH+GzQO5g6Ga1tpeYj2pkAcWbhrUTdFdJsJvj2HjyGjvdc8DHY1abZMTRaCdicblYpDGbCWX32JiI5JsMJ+CLh/Nlooz7ge+pv/U0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d24786-72eb-49d6-59c6-08dd1aece89b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:38:17.5004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6b1jtmJjTKbwhwFC1EC5dF2JLyuUJIw6nYozBBkaF76x5soaRZqpvNg4wurGumcZbE0AmQghgjR6j8JY/jWU83xL+0p+93f0lDvtUChalc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120150
X-Proofpoint-ORIG-GUID: szPJ9sEe_Ue8FjjRc4xsopplF76Zrq6U
X-Proofpoint-GUID: szPJ9sEe_Ue8FjjRc4xsopplF76Zrq6U
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/9/2024 3:07 PM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:19:58AM -0800, Steve Sistare wrote:
>> Save the memfd for ramblocks in CPR state, along with a name that
>> uniquely identifies it.  The block's idstr is not yet set, so it
>> cannot be used for this purpose.  Find the saved memfd in new QEMU when
>> creating a block.  If the block size is larger in new QEMU, extend the
>> block using fallocate, and the extra space will be useable after a guest
>> reset.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 0bcb2cc..aa095a3 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -70,6 +70,7 @@
>>   
>>   #include "qemu/pmem.h"
>>   
>> +#include "migration/cpr.h"
>>   #include "migration/vmstate.h"
>>   
>>   #include "qemu/range.h"
>> @@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>       }
>>   }
>>   
>> +static char *cpr_name(RAMBlock *block)
>> +{
>> +    MemoryRegion *mr = block->mr;
>> +    const char *mr_name = memory_region_name(mr);
>> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
>> +
>> +    if (id) {
>> +        return g_strdup_printf("%s/%s", id, mr_name);
>> +    } else {
>> +        return g_strdup(mr_name);
>> +    }
>> +}
>> +
>>   size_t qemu_ram_pagesize(RAMBlock *rb)
>>   {
>>       return rb->page_size;
>> @@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>>   {
>>       size_t max_length = new_block->max_length;
>>       MemoryRegion *mr = new_block->mr;
>> -    const char *name = memory_region_name(mr);
>> -    int fd;
>> +    g_autofree char *name = cpr_name(new_block);
>> +    int fd = cpr_find_fd(name, 0);
> 
> If to use the proposed patch in the reply of patch 2, here this should be
> able to be moved to qemu_ram_alloc_anonymous_fd(), IIUC.
> 
>> +
>> +    if (fd >= 0) {
>> +        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
>> +            error_setg_errno(errp, errno,
>> +                             "cannot grow ram block %s fd %d to %ld bytes",
>> +                             name, fd, max_length);
>> +            goto err;
>> +        }
> 
> I remember we discussed something similar to this, do we need ftruncate()
> at all?  I think not.
> 
> This happens when booting QEMU, so I don't think it's relevant yet to what
> size used in src, as this is dest.
> 
> It starts to get relevant only when cpr migration starts on src, it sents
> ramblocks at the beginning, then parse_ramblock() will properly resize any
> ramblock to whatever size it should use.
> 
> If the resize didn't happen it can only mean that used_length is correctly
> matched on both sides.
> 
> So I don't see why a special truncate() call is needed yet..

You suggested truncate:

   https://lore.kernel.org/qemu-devel/47d6d984-7002-4086-bb10-b191168f141f@oracle.com/

   "So after such system reset, QEMU might start to see new ROM code loaded
   here (not the one that got migrated anymore, which will only match the
   version installed on src QEMU).  Here the problem is the new firmware can
   be larger, so I _think_ we need to make sure max_length is not modified by
   CPR to allow resizing happen here, while if we use truncate=true here it
   should just work in all cases."

... but you suggested passing a truncate bool to the file_ram_alloc call after
cpr_find_fd.  I could do that instead.  However, if qemu_ram_alloc_shared uses
qemu_ram_alloc_from_fd instead of file_ram_alloc, per your suggestion in patch 2,
then I will still call ftruncate here, because qemu_ram_alloc_from_fd  does not
take a truncate argument.

- Steve

>> +        goto have_fd;
>> +    }
>>   
>>       if (qemu_memfd_available()) {
>>           fd = qemu_memfd_create(name, max_length + mr->align, 0, 0, 0, errp);
>> @@ -2111,7 +2135,9 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>>               return true;
>>           }
>>       }
>> +    cpr_save_fd(name, 0, fd);
>>   
>> +have_fd:
>>       new_block->mr->align = QEMU_VMALLOC_ALIGN;
>>       new_block->host = file_ram_alloc(new_block, max_length, fd, false, 0, errp);
>>   
>> @@ -2122,6 +2148,8 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>>           return true;
>>       }
>>   
>> +err:
>> +    cpr_delete_fd(name, 0);
>>       close(fd);
>>       return false;
>>   }
>> @@ -2234,6 +2262,8 @@ static void reclaim_ramblock(RAMBlock *block)
>>   
>>   void qemu_ram_free(RAMBlock *block)
>>   {
>> +    g_autofree char *name = NULL;
>> +
>>       if (!block) {
>>           return;
>>       }
>> @@ -2244,6 +2274,8 @@ void qemu_ram_free(RAMBlock *block)
>>       }
>>   
>>       qemu_mutex_lock_ramlist();
>> +    name = cpr_name(block);
>> +    cpr_delete_fd(name, 0);
>>       QLIST_REMOVE_RCU(block, next);
>>       ram_list.mru_block = NULL;
>>       /* Write list before version */
>> -- 
>> 1.8.3.1
>>
> 


