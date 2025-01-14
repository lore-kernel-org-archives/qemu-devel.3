Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22055E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXktd-0007h3-DI; Tue, 14 Jan 2025 12:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXktS-0007eV-NT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:39:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXktP-0002ar-DI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:39:57 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0pKe008511;
 Tue, 14 Jan 2025 17:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=LDM9LGp9b25fFRAhDYXA/FhjDNrN3+9a/IQA+tWlncw=; b=
 L1q+/2yfVYGy1Z/WBhyRoq2LrO8IwDWaAihmPCdhlfL57GLhCPX4eEVhncPqPJSz
 mruXfnpdWkZmREXaSEo2UtDDLqOuqibq3dldGT2OTG5zDyvZM3mdW6rLhGimRky3
 d/I1EpWaItMth7ADVFpc/TNGcYp4tp1oN7q0GBAJd7OLSdcX4RtgqJUp3V/UUF7O
 b96Yrn8EnY7E7w4g2/6PE4yiq+q8OC/TDw+JcG/Ihs9mVYuoQ2rrB9Ja97Dks+t+
 AV0YKNMGdaCq/UrEoq6JqtX49QEKQXlYdRYBdMPbXv4tIxpNPT/QQfzQtEtlSowI
 rcwA+8h9IE7DXm1ZMfCvKA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjap7xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:39:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EG0ZDX020424; Tue, 14 Jan 2025 17:39:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eqtmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK8qqNJVlX3yQTmbqna4QvLxoMf+tDfLRK5oSTVU+VcAeq2EpadWfwrNPBX2notNgIf8MXS7eHPzVP95gwwrGFB53Ps326hXs/u3/XMsN3vbIj5LH1SPcgwWK8ICw68ZCnX5eAbPTe1Lja9J8xgmHsWsp5NrpIlPTmtqcOZKPEcntz1WWmuVxTkyGs9xKjhF/LVI05SFMIAEQE2C4CLCJKPE5iLD8b09ZB06+xKz2r7vmwe+hBmKq01M/ifOsTYZyf8BMvQH4b1RTw5UsVGSDPggcA0SbUogIOMDA9Y+fn932ASLmsafj4fsLsciGjx70LmGWsb+KrgFXO+jvA6Cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDM9LGp9b25fFRAhDYXA/FhjDNrN3+9a/IQA+tWlncw=;
 b=u1epF5BQMU/sa36KxTiyayaTT1ZCwTVCM/oq7KNipHscz3PJu+v0/t681BaFhruce8XJTCGs2VJR8Z5ydA+YkX1ugYmNo/wyirxXftnVEp5eWTvsbBKv1mfcTz4Ky3o1c5bK5nXvrUu+JGInNPCcsuzqQyD+bDWhlHOX1EEBM4ZEIzK8zHnqW2mV/n1idkMa2C7JwY3ab3SkmNu0Qs1+eWEKzlzdQc8WPLS/MsdHTgY7LH/VBMFvdGcyEzbc46q+C5AGUzJyw+cv2tzX9cbG8nTixxjagne4lz+Hh5bUrJHM59c+2UhiiVuuslBvut5g7evagcDvA2+lyAeuPAPdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDM9LGp9b25fFRAhDYXA/FhjDNrN3+9a/IQA+tWlncw=;
 b=SFBEUDawXIzSI3VFfhh+I6liBE+r2dzCVntzI/thMyEycO/76ruSPwxJ/LBRD8taM2q7kdasoguMqlfCFOsDfPrf/B1GfszONg2IOs2D3RAfCL400YIbuF6bhc49AT0G5PADYngqp3Hseeyir9AUIMJqbfoBDKCCKPJm1z57CzE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 17:39:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 17:39:45 +0000
Message-ID: <0ebb0dca-8c53-4049-b706-a76e53c95888@oracle.com>
Date: Tue, 14 Jan 2025 12:39:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/24] Live update: cpr-transfer
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <74e95503-f59a-4b5c-87de-2216a1777538@oracle.com>
Content-Language: en-US
In-Reply-To: <74e95503-f59a-4b5c-87de-2216a1777538@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:408:34::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9bef7a-a614-4841-b232-08dd34c26fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?di8wMlhEc0Y1SEdEbE44K0pDL0VJZFFqNXJ0NitZaStkYit5TUcvRzVCckNF?=
 =?utf-8?B?TG5YT2plODc4N09aSHJVVVZNSTZFUll1a082TDBzSFJtSGJGQmdTQWx5dG5k?=
 =?utf-8?B?TitKTDZBVkpBeVNhNjRTTXF4S2grZTcvNGZOTnRQOHRPbmxTZmFMUUV3b29n?=
 =?utf-8?B?SUxOR3p5NTV6bVhiRXp1Ti9ERCtzZEZjZUhKV0hhbXlUR1RWTzBzTVlmcTZV?=
 =?utf-8?B?RENCUnViaDhwTjRyTEYvNVFwbmd0T3dVNm05b1BmRGtLR1NLdmZTVktqaFh2?=
 =?utf-8?B?b2oxZ0N5WVEyd0R2UUxidHo2cTh2TkhIVytBT25NQ2l3bUE3NnBIMFN0RTdD?=
 =?utf-8?B?UWlyempVVER0eFlLb21UbEc1MjNDbFN5bi81dlN2K21PUVdaQUxkcm5mdnhn?=
 =?utf-8?B?RmRVSlZuZytaWHd4SXJ6cWoxYll3Nm5qdFdQOHZVVVlxR0pPdndUc08zT080?=
 =?utf-8?B?YTFWa2JHOFZBdFlaeFI1TERINTNFS09TUG41TDlCaFI5UVZUZFBLTDdiSFdW?=
 =?utf-8?B?OElCeWNwdFYxcXFaUzFQRkdjN1lYbXFhQzRDYk1RRm0wYzFSNXozdXJZM2tF?=
 =?utf-8?B?eW1kU1V5ODZCaVU3Y3pkbllqZ2J2dG4xL1lMNnBXam9nMjdYVG5rS2MxSUNk?=
 =?utf-8?B?NkxCZFRNcHBRcUtkWmkzM1BSWCtIeEk2QWdtSjU3bnJFTStjOEdNUnllMEpN?=
 =?utf-8?B?TFlMVnF6dXk0R3ROT0srbVhkY3FRZk03MUlEaVB2UWVWc2FmOTFlWXdueUda?=
 =?utf-8?B?d0p3dXRSMWNzOENzVkN1MVhsRHFKTkRFa3J1UmIya0Q3ZTk0S1NMVkFJU1FU?=
 =?utf-8?B?c3pzaDFxNjBLaXZFMVJNU1JadHgwTVg3ME1JdWZ5Y1Z0ZEdWYmo2alQrbkRk?=
 =?utf-8?B?STBKV0treThhS2tHRU9IeVJVOHRZT2wzdFMzenZ2V2hSaURGNWQ5RUFxN0pZ?=
 =?utf-8?B?djdXc0lWVkdhWmRpTEtpbE8rQTZQN1NtMlZyaE41d1V1NG1rODAyNkZnNFNj?=
 =?utf-8?B?eEZsZHFoUWFpZzlQK3MyRWRkZVdNNms3eDIxa0Z0VHBGclJPWEg3T2s5aE0v?=
 =?utf-8?B?dm1BNW1VZVM5N1d2UjZOMDU5Vm1Pbk9sNVM3Y2JXSGZYVFVRcFU2M2NHMnYz?=
 =?utf-8?B?ZnlwWWV4QnMxUzZpSEYwUkZQaFRzTkZydWQ3b2ZtN2pUSnFiSHY1Wi9rZTho?=
 =?utf-8?B?eTFJUEdQUFVpSng2cW05NnFEUEMwSi9JVDdwVUlrNDk3aWU0M0JKb2l2SGVo?=
 =?utf-8?B?WVdwSlI5TzdieGMzZ1ZmSjNJS1JBYkRQUUo5cXREYWZFTVB5ZmdjK0xCU1Ns?=
 =?utf-8?B?YlFsUnUxRlZtWUNUcnNoNU5UQWlxQjVMdUlIUHk4R21RbGlZb2xOZGpkUG90?=
 =?utf-8?B?dWVPcGpxZEpqVmF2ZHRFMG9lVzUxRTU5Qm9JMnUrQmdiSzkvYy91UDdCdmt5?=
 =?utf-8?B?c0I3RnNxS01SZlUwanc1elNPVis5SVNpL2xwQzU4OHhiR01SQTNnbW9PSzA0?=
 =?utf-8?B?WndYZU44RDF4NXJwZ3FlVFpKSzhMaEJ0bmVTUitGdnk2c3k4U2grSHNuL25M?=
 =?utf-8?B?cWk5QXhzYURqa0tqK01OMHpud0NOZEJVSkozRGc5b211dHNSQzJGc0RuV0NW?=
 =?utf-8?B?djlib21kWkxKcGJSM2lOSjUvM2RCdHNxWWkyMGNZd2t5aXZkeE95a0NqOTkz?=
 =?utf-8?B?bHFJYmZMQ2dhc01zQVBnS2puTDYvRFVBNUxhTTlGRWJKVC9yWlBncEk4K05q?=
 =?utf-8?B?TzEySVMrbU92ZzArVFRZcWRBNHZyUEdUdTdiWWFUWFBVTkQrSi9PdkEzbUp2?=
 =?utf-8?B?ZkZneWhTRUpNQU1RcUdXZVoxUFhCZmFNU0R5eW13OTd3dXQveDhyM043bXEv?=
 =?utf-8?Q?bQUr3UCYFeoF0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtMV25SNk1DbmplalFxSGh3RG14VndrK0ZYTzZoL0wrNU1KWXg1akFlSW43?=
 =?utf-8?B?MmpFV1h6S2sxYngzTnRrb3YrS1IwcXoxQzd0NHRXVUhUZHFVeFpRcUp2VWNT?=
 =?utf-8?B?Zm4vbHdRTjNkVklMeERvNUpUczNTWGVxdmIycTM3NmlsTUp6LzBYZDI1V1Bh?=
 =?utf-8?B?TmtRcGM1aVh3TGxFL1EvVzhsUXduNnZlYXErdjlkLzc2bmwza0pkOGhOVjBF?=
 =?utf-8?B?WDhTVWNVK3pPb1ByZUlQOWVWU2xVdUN2ZEJaMlVDQ004N3JxZmdCbWZsbUph?=
 =?utf-8?B?czVZNUU1SlM1cE1SZ2dGMHJzN0daNUZLSGdtclZRcWxLR0tKb25IT1RrdnJt?=
 =?utf-8?B?TEl0Z1ZYcHhaMThyTGd5N0FjeU5EMWh4Yi96a2JZNStqVk9veUZWc2g4MFlz?=
 =?utf-8?B?WXE1NXQxcVdYelEveHBqRm5FMVZONFZoTENoWFRQbVRpdUhpYWtZcmFNdzRv?=
 =?utf-8?B?TDl3YkNNSmxFRmlLN2hrWUtOQUorVzRrL25LeG93T1ZHOW81cmdlYTZReGFV?=
 =?utf-8?B?M0ltbnZxZEMrNGw5V3FSMjBLanZiNW9PQ1RVVHpvVUpxVUIvN3ZZbFo1dEdT?=
 =?utf-8?B?SWR5bVBTZ2NhN0RQRy8waWJ6RHArMnlZUy9BdXhZRUU5L1BIMUVSdFBMZTJM?=
 =?utf-8?B?Ulg2UE1mY2hKQ1NSSkNZeVhSQ0RHTE1tY0dWU29tUU1UR2ZvSmNzcDNFeUFH?=
 =?utf-8?B?MWJxYWttOEhOLy9WUHRxT2JDd29VSy9acUxxdDU1MlByQjNyZCtueUsxUDhY?=
 =?utf-8?B?SENKN2ZVcitmS0k1VjRjY2FXdllQOGIwbnRCUlVLdXFUb3FsUUY2WEhwTy9L?=
 =?utf-8?B?elh3eVF1ZWxPdmc0UWF5MFlNek1CNzJSZXFNRm9XdXVPVWs3ak0randvczkx?=
 =?utf-8?B?T2V6bnlBZm1NSjJqZ3ZFNzlFem5KbHZ3S3ZEbkJCYlZidjVndGdZSk9tVHU0?=
 =?utf-8?B?Z3NiWi9ZN3QwL2dwakMxVHpSRXZXOXFjMTFBU3VjSWNaWVNGMnR4QVhrdHNJ?=
 =?utf-8?B?emYvbjNWNkFOT3BiQk8xRUNVOWJvWi9aVEljdXNKTE8zVGhlUDc3SHhzNmlH?=
 =?utf-8?B?MW5DR3VZQjd5aEkxeEFWMndQMmlqYkdOZXpqY0ViTTZtWThGdnJvNEY3VG1o?=
 =?utf-8?B?NmJ6am5tWEZyN2tWOGlpdlJKM05mUlVFMWlmUzVMRzU3Sk0rT01HaTh2akJZ?=
 =?utf-8?B?VHlmN0h0R1EzTFVNeFpISkpDL216WGh6ZWRkdWczbGF4KzBqZmorZnVaS1Zk?=
 =?utf-8?B?NGpZMER1UGdEVWRSVmRiank5YjhsczJ4WFgzc1Rab3BUQVdLd28rbUhLa0Uv?=
 =?utf-8?B?OHhFSU5sUkFtUDRNWEhKWmN6dUpRRGM5Rm5HSG4xa2RIZXZ5UVpDaU1NQXNV?=
 =?utf-8?B?SnNmRm5OcGhrN0dXSVhDY2hFeFJDaUFaT09wQVVURGVDVTJLOW5pL0dHUGND?=
 =?utf-8?B?RjBaU3plczZuQzhseW1VZjBqMVJUZnZhK0ZnZnk0aDJjWFVZL256bXZyZVpM?=
 =?utf-8?B?RWhjelhpQXJxTUc4cVp0aTVjaGF5TUsxZmxnOUJLclR3L05jWnd3NjBnUWlD?=
 =?utf-8?B?QWhwWnRLSGRXalgrQ0g0aFQrNlRQZDVFOVowSHdOWEhGSWpXR01mNHNmWUkr?=
 =?utf-8?B?QXFHWjFBTzNmNFVHaEExeDlidDdwRGNMVDZ4dDBOT21PTkE2L0dNYllLTzY3?=
 =?utf-8?B?Z3NGanc2a2hRQ1JQMWNYRmxIRFpJbVJNelA4MHFWbHNHZkY1NEdhMXhWN2g1?=
 =?utf-8?B?S1p2cUU0eU5JRDhnUWM0UmMxMlc5Smdpb1UyMDd6dHhKTXlLcUlWenYwSmxH?=
 =?utf-8?B?V2g5N3B5c1pJdFBISkhncm9CZFl6Y0swR3RRYkxMbFZJcDVMZzVSdFMycURO?=
 =?utf-8?B?SXlIbW1SSjJjc00va3dMRGRxWnBVSThUV3RRSklFdkd4d0pZN1R1dHhYenBo?=
 =?utf-8?B?UTBPcTVNMzlOUTZ0NjE4UzhpM0lMTUgwT3ZsNVZOVFhIQ2w4QjEwWHJIbWpw?=
 =?utf-8?B?NVoxWituWEk0QXNmc0tYK1VsdXlWSk9walllekt1NUxIUUFoQVAyQ2F1b0E5?=
 =?utf-8?B?akFRVlkwQ2hRSHYwSGtBU0MrNC95YTllQm9HUmRjd0hsN3hFRjlrTDMzZ01H?=
 =?utf-8?B?bTV1aTNKcDljS2oxMEk5WkQvaENDVWZ6SXppUzhzZkZxSXY3dkZaTGl1dFpj?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9CAVXuGyWM1XQedV6NBN3Ta3TA7qM0ylbB2DWQ4dF2Xnle74LXXNhDBKmpwd2zPUce1efTfvEeghQ1UsgOkPReih9qT1ht+ih6beV6dydpK8ByJTpB8UI3+NPTvQukN0xV+6COVT+n7piTAcOkbgPWnWIEVG6WNGaREDUaOqDQSqc7ewuin+JONRRMaR788VQBcAtdOSJuxU7XkiaFHde2mTlPBKoqa0EM5MMP5G6dc8twau2H3zpyYgJzMPMsbUrHh2dQOeAvV/D3b2jPGjBf8ReaPP2eKkUQcDfz4cMyEsdeaFqyzuQt7397FG0ykWyas7qknmjoebwN0frOzYKNlBnZesoKHJmgnrt6rXoFkPED52bF2g0tF6/VWdS5MpeJTSl5XQkaccERnrLB0wlzR7jlYYcKjANbLUJH+9wQOf6vqoiVkpZIwIDiE8bpX+9AJ2TGuqDxbwBL21kBtYZ/r2DuepGejLx84F4QLD/pyXkegJYRb8tioUMd1+mF5+RIl5flEqR8uuY3G6pqpEDyxmdIH2FpolC8j/txj+TXMMlOVvwtuq1ohZnpnE+6I9hnV60qncqShO+STF0LGDNx7GDLozAkhEjBcvP0y8/uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9bef7a-a614-4841-b232-08dd34c26fa4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:39:45.8811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu8WFfTeYm2UWMljpPjuPc0tNoz+ga5mD843QuOJyZLk8X5oQfXhQw5h6Kiie/zSpOVN+4KBFHUHOlFtMlCTr3/3t26AHvkJ5qyF+54JaIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140135
X-Proofpoint-GUID: fVQPrdh71b8GaC_hnrmx5j8oyWbZIsLy
X-Proofpoint-ORIG-GUID: fVQPrdh71b8GaC_hnrmx5j8oyWbZIsLy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
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

On 1/14/2025 12:38 PM, Steven Sistare wrote:
> Hi Peter --
> 
> These still need RB.  You said the first one "looks fine" in V5,
> and I only needed to split the qemu_ram_alloc_from_fd size calculation bug
> to a separate patch, which I did in V6:
>    * physmem: qemu_ram_alloc_from_fd extensions
>    * tests/qtest: assert qmp connected

Thanks Peter, you were quick on the draw!  Our emails crossed.

- Steve

> 
> Hi Markus --
> 
> Patch "migration: incoming channel" has an Acked-by from Peter, but it would
> be good to also get your ack or RB, as I updated this patch in response to
> the comments you posted for V4.
> 
> We are inches from the goal line ...
> 
> - Steve
> 
> On 1/14/2025 12:23 PM, Steve Sistare wrote:
>> What?
>>
>> This patch series adds the live migration cpr-transfer mode, which
>> allows the user to transfer a guest to a new QEMU instance on the same
>> host with minimal guest pause time, by preserving guest RAM in place,
>> albeit with new virtual addresses in new QEMU, and by preserving device
>> file descriptors.
>>
>> The new user-visible interfaces are:
>>    * cpr-transfer (MigMode migration parameter)
>>    * cpr (MigrationChannelType)
>>    * incoming MigrationChannel (command-line argument)
>>    * aux-ram-share (machine option)
>>
>> The user sets the mode parameter before invoking the migrate command.
>> In this mode, the user starts new QEMU on the same host as old QEMU, with
>> the same arguments as old QEMU, plus two -incoming options; one for the main
>> channel, and one for the CPR channel.  The user issues the migrate command to
>> old QEMU, which stops the VM, saves state to the migration channels, and
>> enters the postmigrate state.  Execution resumes in new QEMU.
>>
>> Memory-backend objects must have the share=on attribute, but memory-backend-epc
>> is not supported.  The VM must be started with the '-machine aux-ram-share=on'
>> option, which allows auxilliary guest memory to be transferred in place to the
>> new process.
>>
>> This mode requires a second migration channel of type "cpr", in the channel
>> arguments on the outgoing side, and in a second -incoming command-line
>> parameter on the incoming side.  This CPR channel must support file descriptor
>> transfer with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
>>
>> Why?
>>
>> This mode has less impact on the guest than any other method of updating
>> in place.  The pause time is much lower, because devices need not be torn
>> down and recreated, DMA does not need to be drained and quiesced, and minimal
>> state is copied to new QEMU.  Further, there are no constraints on the guest.
>> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
>> and suspending plus resuming vfio devices adds multiple seconds to the
>> guest pause time.
>>
>> These benefits all derive from the core design principle of this mode,
>> which is preserving open descriptors.  This approach is very general and
>> can be used to support a wide variety of devices that do not have hardware
>> support for live migration, including but not limited to: vfio, chardev,
>> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
>> to allow a descriptor to be used in a process that did not originally open it.
>>
>> How?
>>
>> All memory that is mapped by the guest is preserved in place.  Indeed,
>> it must be, because it may be the target of DMA requests, which are not
>> quiesced during cpr-transfer.  All such memory must be mmap'able in new QEMU.
>> This is easy for named memory-backend objects, as long as they are mapped
>> shared, because they are visible in the file system in both old and new QEMU.
>> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
>> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
>> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
>> the device that locked them remains open.
>>
>> cpr-transfer preserves descriptors by sending them to new QEMU via the CPR
>> channel, which must support SCM_RIGHTS, and by sending the unique name of
>> each descriptor to new QEMU via CPR state.
>>
>> For device descriptors, new QEMU reuses the descriptor when creating the
>> device, rather than opening it again.  For memfd descriptors, new QEMU
>> mmap's the preserved memfd when a ramblock is created.
>>
>> CPR state cannot be sent over the normal migration channel, because devices
>> and backends are created prior to reading the channel, so this mode sends
>> CPR state over a second "cpr" migration channel.  New QEMU reads the second
>> channel prior to creating devices or backends.
>>
>> Example:
>>
>> In this example, we simply restart the same version of QEMU, but in
>> a real scenario one would use a new QEMU binary path in terminal 2.
>>
>>    Terminal 1: start old QEMU
>>    # qemu-kvm -qmp stdio -object
>>    memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>>    -m 4G -machine aux-ram-share=on ...
>>
>>    Terminal 2: start new QEMU
>>    # qemu-kvm -monitor stdio ... -incoming tcp:0:44444
>>      -incoming '{"channel-type": "cpr",
>>                  "addr": { "transport": "socket", "type": "unix",
>>                            "path": "cpr.sock"}}'
>>
>>    Terminal 1:
>>    {"execute":"qmp_capabilities"}
>>
>>    {"execute": "query-status"}
>>    {"return": {"status": "running",
>>                "running": true}}
>>
>>    {"execute":"migrate-set-parameters",
>>     "arguments":{"mode":"cpr-transfer"}}
>>
>>    {"execute": "migrate", "arguments": { "channels": [
>>      {"channel-type": "main",
>>       "addr": { "transport": "socket", "type": "inet",
>>                 "host": "0", "port": "44444" }},
>>      {"channel-type": "cpr",
>>       "addr": { "transport": "socket", "type": "unix",
>>                 "path": "cpr.sock" }}]}}
>>
>>    {"execute": "query-status"}
>>    {"return": {"status": "postmigrate",
>>                "running": false}}
>>
>>    Terminal 2:
>>    QEMU 10.0.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>
>> This patch series implements a minimal version of cpr-transfer.  Additional
>> series are ready to be posted to deliver the complete vision described
>> above, including
>>    * vfio
>>    * chardev
>>    * vhost and tap
>>    * blockers
>>    * cpr-exec mode
>>    * iommufd
>>
>> Changes in V2:
>>    * cpr-transfer is the first new mode proposed, and cpr-exec is deferred
>>    * anon-alloc does not apply to memory-backend-object
>>    * replaced hack with proper synchronization between source and target
>>    * defined QEMU_CPR_FILE_MAGIC
>>    * addressed misc review comments
>>
>> Changes in V3:
>>    * added cpr-transfer to migration-test
>>    * documented cpr-transfer in CPR.rst
>>    * fix size_t trace format for 32-bit build
>>    * drop explicit fd value in VMSTATE_FD
>>    * defer cpr_walk_fd() and cpr_resave_fd() to later series
>>    * drop "migration: save cpr mode".
>>      delete mode from cpr state, and use cpr_uri to infer transfer mode.
>>    * drop "migration: stop vm earlier for cpr"
>>    * dropped cpr helpers, to be re-added later when needed
>>    * fixed an unreported bug for cpr-transfer and migrate cancel
>>    * documented cpr-transfer restrictions in qapi
>>    * added trace for cpr_state_save and cpr_state_load
>>    * added ftruncate to "preserve ram blocks"
>>
>> Changes in V4:
>>    * cleaned up qtest deferred connection code
>>    * renamed pass_fd -> can_pass_fd
>>    * squashed patch "split qmp_migrate"
>>    * deleted cpr-uri and its patches
>>    * added cpr channel and its patches
>>    * added patch "hostmem-shm: preserve for cpr"
>>    * added patch "fd-based shared memory"
>>    * added patch "factor out allocation of anonymous shared memory"
>>    * added RAM_PRIVATE and its patch
>>    * added aux-ram-share and its patch
>>
>> Changes in V5:
>>    * added patch 'enhance migrate_uri_parse'
>>    * supported dotted keys for -incoming channel,
>>      and rewrote incoming_option_parse
>>    * moved migrate_fd_cancel -> vm_resume to "stop vm earlier for cpr"
>>      in a future series.
>>    * updated command-line definition for aux-ram-share
>>    * added patch "resizable qemu_ram_alloc_from_fd"
>>    * rewrote patch "fd-based shared memory"
>>    * fixed error message in qemu_shm_alloc
>>    * added patch 'tests/qtest: optimize migrate_set_ports'
>>    * added patch 'tests/qtest: enhance migration channels'
>>    * added patch 'tests/qtest: assert qmp_ready'
>>    * modified patch 'migration-test: cpr-transfer'
>>    * polished the documentation in CPR.rst, qapi, and the
>>      cpr-transfer mode commit message
>>    * updated to master, and resolved massive context diffs for migration tests
>>
>> Changes in V6:
>>    * added RB's and Acks.
>>    * in patch "assert qmp_ready", deleted qmp_ready and checked qmp_fd instead.
>>      renamed patch to ""assert qmp connected"
>>    * factored out fix into new patch
>>      "fix qemu_ram_alloc_from_fd size calculation"
>>    * deleted a redundant call to migrate_hup_delete
>>    * added commit message to "migration: cpr-transfer documentation"
>>    * polished the text of cpr-transfer mode in qapi
>>
>> The first 10 patches below are foundational and are needed for both cpr-transfer
>> mode and the proposed cpr-exec mode.  The next 6 patches are specific to
>> cpr-transfer and implement the mechanisms for sharing state across a socket
>> using SCM_RIGHTS.  The last 8 patches supply tests and documentation.
>>
>> Steve Sistare (24):
>>    backends/hostmem-shm: factor out allocation of "anonymous shared
>>      memory with an fd"
>>    physmem: fix qemu_ram_alloc_from_fd size calculation
>>    physmem: qemu_ram_alloc_from_fd extensions
>>    physmem: fd-based shared memory
>>    memory: add RAM_PRIVATE
>>    machine: aux-ram-share option
>>    migration: cpr-state
>>    physmem: preserve ram blocks for cpr
>>    hostmem-memfd: preserve for cpr
>>    hostmem-shm: preserve for cpr
>>    migration: enhance migrate_uri_parse
>>    migration: incoming channel
>>    migration: SCM_RIGHTS for QEMUFile
>>    migration: VMSTATE_FD
>>    migration: cpr-transfer save and load
>>    migration: cpr-transfer mode
>>    migration-test: memory_backend
>>    tests/qtest: optimize migrate_set_ports
>>    tests/qtest: defer connection
>>    migration-test: defer connection
>>    tests/qtest: enhance migration channels
>>    tests/qtest: assert qmp connected
>>    migration-test: cpr-transfer
>>    migration: cpr-transfer documentation
>>
>>   backends/hostmem-epc.c                 |   2 +-
>>   backends/hostmem-file.c                |   2 +-
>>   backends/hostmem-memfd.c               |  14 ++-
>>   backends/hostmem-ram.c                 |   2 +-
>>   backends/hostmem-shm.c                 |  51 ++------
>>   docs/devel/migration/CPR.rst           | 182 ++++++++++++++++++++++++++-
>>   hw/core/machine.c                      |  20 +++
>>   include/exec/memory.h                  |  10 ++
>>   include/exec/ram_addr.h                |  13 +-
>>   include/hw/boards.h                    |   1 +
>>   include/migration/cpr.h                |  33 +++++
>>   include/migration/misc.h               |   7 ++
>>   include/migration/vmstate.h            |   9 ++
>>   include/qemu/osdep.h                   |   1 +
>>   meson.build                            |   8 +-
>>   migration/cpr-transfer.c               |  76 +++++++++++
>>   migration/cpr.c                        | 224 +++++++++++++++++++++++++++++++++
>>   migration/meson.build                  |   2 +
>>   migration/migration.c                  | 139 +++++++++++++++++++-
>>   migration/migration.h                  |   4 +-
>>   migration/options.c                    |   8 +-
>>   migration/qemu-file.c                  |  83 +++++++++++-
>>   migration/qemu-file.h                  |   2 +
>>   migration/ram.c                        |   2 +
>>   migration/trace-events                 |  11 ++
>>   migration/vmstate-types.c              |  24 ++++
>>   qapi/migration.json                    |  44 ++++++-
>>   qemu-options.hx                        |  34 +++++
>>   stubs/vmstate.c                        |   7 ++
>>   system/memory.c                        |   4 +-
>>   system/physmem.c                       | 150 ++++++++++++++++++----
>>   system/trace-events                    |   1 +
>>   system/vl.c                            |  43 ++++++-
>>   tests/qtest/libqtest.c                 |  86 ++++++++-----
>>   tests/qtest/libqtest.h                 |  19 ++-
>>   tests/qtest/migration/cpr-tests.c      |  60 +++++++++
>>   tests/qtest/migration/framework.c      |  74 +++++++++--
>>   tests/qtest/migration/framework.h      |  11 ++
>>   tests/qtest/migration/migration-qmp.c  |  53 ++++++--
>>   tests/qtest/migration/migration-qmp.h  |  10 +-
>>   tests/qtest/migration/migration-util.c |  23 ++--
>>   tests/qtest/migration/misc-tests.c     |   9 +-
>>   tests/qtest/migration/precopy-tests.c  |   6 +-
>>   tests/qtest/virtio-net-failover.c      |   8 +-
>>   util/memfd.c                           |  16 ++-
>>   util/oslib-posix.c                     |  53 ++++++++
>>   util/oslib-win32.c                     |   6 +
>>   47 files changed, 1473 insertions(+), 174 deletions(-)
>>   create mode 100644 include/migration/cpr.h
>>   create mode 100644 migration/cpr-transfer.c
>>   create mode 100644 migration/cpr.c
>>
>> base-commit: e8aa7fdcddfc8589bdc7c973a052e76e8f999455
>>
> 


