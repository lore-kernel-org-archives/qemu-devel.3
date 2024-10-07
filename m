Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655B9CFB459
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtSC-00031S-5z; Mon, 07 Oct 2024 15:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtSA-00031J-Sd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtS6-0006IG-Pg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeh3030896;
 Mon, 7 Oct 2024 19:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rWQUGzaYYjjPc24+B8uSNX0zcNvvG6DiiR2IZsk516s=; b=
 ANDRpl+L2+C+t0fUeIFZOGSTM1TS/1WeWUGjnGS37goELvafkQOuHpkHdesPzHvP
 nOQm3ldhXydit+eIIAkUCW/HLT6MEW9xLhwPOe11LZ1MJfhMSUN+hQNWT2VlbQvt
 LlU6cTOLTRmD6JwYiAILiEXed/u388b+r0bvOUxIuB8eqxxoaA5OiiCc1JwzxsQR
 ijIg1W0nNMTWg7FrJhkrZp/3r0qM80cs+1I2WmK8Au/KEYyOvbxMFbWv9bpi0dTd
 64VpLlw+Ry6TKLRLI0eLmKsfZh641eS/jtp5bXG2wDckaLom3l1KoedvU/RWa74f
 OxwhsGc7tqQ6D1YVWyCOFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063m7as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497IGcab001184; Mon, 7 Oct 2024 19:31:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw68jn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvsbW6AkNyDI/OdUZJM9iEgyqvtik8zzBPAaOHz+2Vo9kUdj1QxDA9LjJYtwmcdyVvoBpFiLYEn/7PhB6ubtEHxhNYnPPJqWnVbQc/O8V2BlsptBM8stw0cdW9cpe3+GFqG4gOj2ilhJQnp1JXDnBgoQ2zTa3nwFFf0QM3S5o9wHkou9kdVOthg3yF5xewD6lS/QOmoAoT5qCxIZYHcxQaaG31MSfEBdpa13JxN17yMX7dIVq8sCW6IGffeove+CrKHtJFXOMLsRTAR0MsQTSIN8bzHTgopL+XL9vNZ89VJnif0/65d+cPSb5tU3/6QKrp43lc8MZ6Z1HpicrCcyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWQUGzaYYjjPc24+B8uSNX0zcNvvG6DiiR2IZsk516s=;
 b=rTuHZNTC/RZVuCvihVisQIsdUxxjLQu1yfa/DWl32GRIMv3tEtxr+YNHTkzXjwg8DhVVpc7JIoefC7YAdJyk7hCTZAvpanRJT7GuHTcGGYLBin86vsBih9XwAEpLvFTV+8ujT1zCEtculXZCkHyvrDmW5YJNzL7VmuhVAoEmwSO7TMR9eWzS/0I1dnZTBuTZsG8L60GPmsqp/cBzORdcUn/RtWXUnFYlqlXUc9FvzRxBIpUZevxFUxpY0wFcxELRFW5Tu0TohBG1d9AayWsz0oXVqptrNHFhEjyZafJHMt7D2RV6Ycad3tJBfGww11b5fIdS/pAv0EwLKxfBi5ILUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWQUGzaYYjjPc24+B8uSNX0zcNvvG6DiiR2IZsk516s=;
 b=rFop5sGRxSww+2C48oHLf9rQu+YeAacGU6QEk3LRp2dlqWMvBLOMUClDh+9rcmPsoMYXMsejL3j27PHav8hLmz6nOw7Fka/GsA5aDxk6wLSX9zlNzHdJAY2zNvIf9hto/Ya++R35OWoyqAeDq9X5A/7eWQM8f1tnU71/4aqnr80=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:31:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:31:23 +0000
Message-ID: <4ddfebeb-a1ec-44c4-9f73-a1618427a61d@oracle.com>
Date: Mon, 7 Oct 2024 15:31:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/13] migration: cpr-transfer save and load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-10-git-send-email-steven.sistare@oracle.com>
 <ZwQQlFkguUCp7UH1@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwQQlFkguUCp7UH1@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: b07c546c-96d6-40cf-ae3f-08dce706a0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dndnWGJCMDA3aHhjWG41LzJtMUw5ZGExbkJPK1BBUkVOZ2haSFQwM01WMEpB?=
 =?utf-8?B?bmI1ZFUvRU5KM05Fb3VWVERGYnFPWklpNEcwd0FZY2pGSmVaVW8rRFZ2MFlJ?=
 =?utf-8?B?RjIvbFJsdkNDL1RvZUgwTUd2NkZZMkhIZ2gvSjhtTkNNVm5PbVpSSzFaOTlQ?=
 =?utf-8?B?UU5sRnNjbzJuS0ZNWmNZcE1qYnZNa3Z4ZXlaU1EzbXZ6S3c4cEFyOGlaZjNS?=
 =?utf-8?B?dVhYQ1ZWK21sMS8wUW1jMVQrTG9YRzFvRUs0cytxL0ZaOW5oQTFMVEJSMjVE?=
 =?utf-8?B?MEVneVpHcDVVNUJxaE1JVk5JZmY1ay9xa2ZqUk12bUcxN2VVT0RCaCtWYzhS?=
 =?utf-8?B?RGFSY0ZuTFhVS0ZHaE9HdEJCcm9NZit4cDdwQk8zVVphV0w2aTZTcXF5VEhB?=
 =?utf-8?B?ZDY5QzZSTjlDTTNiaCtxWnNEWUhGSnU4VVBuWlgvYmVJdVRNUSs5SlJNcmVN?=
 =?utf-8?B?WGtRclpaeUtkQWM1TFRzRG5WYXJVRTZJeFBPOFJHM3h5aVVLbU54b0t0WnVt?=
 =?utf-8?B?ZzBKTUwxTCtkY3VCZ0J3cnJxdDFnSEQxMXFtOUJxUCt6RU1qcEoxTzVZejUz?=
 =?utf-8?B?K1M3bnhSUzJiSmZMZHdQQWxxeURxUWcyeXVwRVk4dFJwRU9oMElkMytPeXVu?=
 =?utf-8?B?UG9rRGkrWE02V1E1YnZkNDM4T0VVcUplaUV4bGkxS3pXKzBHTjVJanJhT3pz?=
 =?utf-8?B?bnRBdjZ0eXY3dSt2MVBQQVNKdUVBMG1YeUVhcCtYU1duS1E1cSs4c21EaTZE?=
 =?utf-8?B?Nmd6Z0c5V3pqc0UzdkprM3FSWWprZG03TVoxQXRGZHZKV0llNlVQV3ZVM05L?=
 =?utf-8?B?NGhzdlg3dGE2N1prM0FsNjlDVmw4OGlMakNiK21RNVhFWlFTa1dlKzc2RTFQ?=
 =?utf-8?B?SVNtZ1k5amRGZHpUWGdDbUFYUVhHOG1rdnBzVnROS3l5OVg3d2tHbk9uUGJ5?=
 =?utf-8?B?cmt5emlXN2xEVzlnRjc3ejlnSlk3eStuZDVYdlJiUnlLVzVoQzVWbkxzRzlF?=
 =?utf-8?B?bFphekJsN3FIVnNsYStsSkhBQ25pcU5WNmQraXVibzhMaytCb3pVYkxhVHJy?=
 =?utf-8?B?Y0VPYmM0VStBR3htNUE2N29qL1N3K05FTm5zN01oU3JOcXVVMi95SEk3bDBX?=
 =?utf-8?B?REp4MWVUUFowNXQzVnFLMjBLSkUxYmxvd1FnYWoza29jeU9oV3JRbzh1QVlo?=
 =?utf-8?B?TVduWUVWQ2lGZVVON3VyYnBxT1Z1NGw2aHQwTlVBTWdUMWQ1eWxib2ZjRDcr?=
 =?utf-8?B?V2o0aXpzSU5MdEVsT0pVK1dnL2dST21KN3FlSEJLNmpsdlJieGNBVU5HSUJZ?=
 =?utf-8?B?K3RPbVcyOW1UdVQvZlJFY3VGNUFQelVRUmhaYjQ1UUMwNDVVVzczdUFXb25X?=
 =?utf-8?B?cUcwQjFpVW8rMDlKOGlGWTBjMGU5b3JsV2tpa29PMDNEY3loZ0ROaEtuaWJ2?=
 =?utf-8?B?c0hvTXBhbHUxaWd3ajZnU2pDdmNMNmRQcGdpRENGbWhhbDNUWm1xalVGWjZu?=
 =?utf-8?B?aTZ4WnZyUjcybmxjTXB3NzVzUGk1QnlROVNPbk9GNTFiK3lMeG9DbFhKaDdj?=
 =?utf-8?B?VnRmczM3K1JxQXVCQlFtZ0Y0UitxY3hoYnJZZFBYdTVBdmlENGxScVlmQmd6?=
 =?utf-8?B?OG5lZ1NnNUJPK3RTRGlJNTVMWE51NEdMaUdyNnJueHplT2RJOURidlFrU1p4?=
 =?utf-8?B?SUdydkk0R1BVeXhPTHBwdnpsMm5nSjUyRk9xVWw2WEptcVlmSzFmTS9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnc2bEl0VGptbWpHY1ovRHRUZWVWb01NYkRwOUZ2UkJ4aTdNQjhXemdyWUV2?=
 =?utf-8?B?ZTYzME94dStwUnpDVmRVNmVOQW0wZWNkMWs2S2c5ZlpoTHltQkdYU2hGbTVY?=
 =?utf-8?B?QkRGK285ZzlpQ3ZJNFJVUDhRSjJJQm5WcDNsaE41L1pPL1VWTVdEajdBZVBR?=
 =?utf-8?B?cFVUVWlJVmRvYllNb1M0elhJWTB1QmQ0N3lNTmtGbDlsaS9ST2FucXNqL3ZF?=
 =?utf-8?B?dXIvNy9NeTZCdHAwVThCTjFDRDNQbXNIRzkrYThYNWhLWTR1NHVCVjZCY1NZ?=
 =?utf-8?B?NTFqWXRwNXFFUlhMZlBZVURJd2ZRYlVJWGd3SjNWdlV1YkROWE1HNHNZS08y?=
 =?utf-8?B?Q3hPaURJWjlnS2xCOGZxTGlLVHRGLzEyMlpGa1VQRW15aTZ0ejJjb0NZNXQ1?=
 =?utf-8?B?KytFSmh5V3BBQk9aTm1YUkwvaml4K2JiNldINFQ2OFVPQUF4Rm5Wd2dRcVl6?=
 =?utf-8?B?Y3FjVW9QYXIycXpEWlJwOVRaekZJY0c1RXdtZ2pDR1gvNXdZeThQeTE1Nzk3?=
 =?utf-8?B?UlFYODlnR0ZJSjlQZys4NkZ5UjkyLy83ZTFTOFpPOTNjUmllai9BSGR0MVZ3?=
 =?utf-8?B?SVZObEFQVHZNbUJDSHMwQkwvckdGNU9WRUZVVkJjTVoxOHRObEtpZU8yYlR4?=
 =?utf-8?B?UEx2Snd3UzY1amlzbzk2V25sUUNXR2hiQi9IZFhJV095UmN4ZUF1bk9McnhH?=
 =?utf-8?B?cjZMOVVhMHczUnBpZGUyUEpEL040eHU2akgxYnlPaFMyWkVqc1JmZFVESFNz?=
 =?utf-8?B?bVVyNzc5akpMYlhaYVJzK09FWktNNnJDYVZuY1RJWDErc0FLZzBiT3Y4cEV0?=
 =?utf-8?B?NXFmSzlxekdaRWF1WmR0bTlDR0tWRnZ2NmlzR1B4SUFYRDJrKzNaQWFjeEpU?=
 =?utf-8?B?MndyclpFaXZ2VE9tNU5LdTd5VFNMa3Z4V3kvaDU0cFBUU1VRVGdBNkZ6UkQ1?=
 =?utf-8?B?Zk5xUGFkRHBzVUkxTVhqbXo1YXB6U1c1Y0Z5ZlFoQnlKUFEvQklmSTZabjN6?=
 =?utf-8?B?UW96Uy9RR2xJN3Z5TGdzNlhmQlljSlhCM1lxSUhxVWJyckR5K2tWNThIa0o4?=
 =?utf-8?B?YzQwbTJwUlY1VG1aMDVSR2VtVzkzNU1VbkJ5blYrVUJYQ21GUWxiNUhjeWl0?=
 =?utf-8?B?OFRPSnU5TkYxcUpmd04zQThOeHI4Tjk1UWRFSnNUK09oS1IrN2x5M0huMy94?=
 =?utf-8?B?dmR6aWc5a3BCcnVtT0t2MzZieURuckRGUkhDSEkvRzlOeDJLc1dzYlQ4QWZ0?=
 =?utf-8?B?aUM4YkJmZ08xajhLNEYwckxqazM0dzBGYWRxTUZybDVJdmRsMi83ZVN4Z0gy?=
 =?utf-8?B?RGJTWGVvd0c1VWxtNWdadktsM3UzQ3N6UGx4dDVLTTZ4RDVBRFZsMGprczFO?=
 =?utf-8?B?QmdzVmtYUEplQVNjSGRZaTY0b3ByNGt1bXVkOGVtVGRCMktSU2t4T1dqdTIv?=
 =?utf-8?B?TldKRUoydm9GRW5meldVeUlhbVIwU1JaQVBqang4THBPeWVFVHpSMWU3UFZ3?=
 =?utf-8?B?cjJnWXFodS9YZ3VFS0JhWlZuN2pkYnNHSjRZYmVDUnYzd1g0eE5oLzJIb3l2?=
 =?utf-8?B?akhIT1ZVZ2N4dlNNNVZsTXVKVVFJWlVubUpleWgzTkJGRDNHUmtSUk1hd3Nl?=
 =?utf-8?B?ZHZuMi9LaHJSTHJodlJqYzFKa1JzVW5aUmVaMDNobUZQQThMNU85NXhDNjBL?=
 =?utf-8?B?ZmVJU2kza2Rpd21NWExkYUxHZElyMzg5azNyaU9WUTk0OWUrOTFiemY3NTIy?=
 =?utf-8?B?QlRYT2tNb2NVZHFxemZPcTcydlJkdUJKdHpEdUduZldMbWhra2lWUXlmWmli?=
 =?utf-8?B?SWVpRzgwWkZXWVdhc2JTNGJySVVkcDZWbjBjRE9ISlJLYkZWRnI2UkNSaFpa?=
 =?utf-8?B?WlJicDMyTlZLUXJXaENjazFuYkt0OFVFd1dhNi9QS0FUSmtNcERnZ0M2OHlQ?=
 =?utf-8?B?blZ0a1VNWkxzRm9uVG1pYXV2ZVlSTnBRTG5qZ1VtZ294WGVLRUVjNnBEMitQ?=
 =?utf-8?B?VWZsZTZPQ1hIMjF3V01sdVFleDRydnM3dzVTMk8vb1hHeGJHWEoybzBXaDRw?=
 =?utf-8?B?b1NFcUZGWW1UU3pSenBRc1ZUNWlSMVNlVkk2bHF4UlR0WnlYOXRRUHhvTDli?=
 =?utf-8?B?L29YbkZaeXN6K2RVRWJnY3RCMHVaZUxxUElITGxTdHhzWDZEbXF4azJBMGZC?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A6NbWCHIGf/VRY8fgUyZIFnT+TpnZn/NeTjIKIwedeNfIEqGRW3T58byoEROGFBNFdDdDrL0uQc4HWQdvHq1OrXQKw61LQff588C8pzMkYyTNsMeDDAtygD1jNdU+eRTh19qaJ1l5UL7g9aarOn0QXIRedraH/MG4NycIPHFzqVEMnG4MxLTXz1a313TLYwDVM9CfcmLx9W/CIdTWpvAPZiDUnpS4uDAudU8YJkdZQhs4nDEa87/hweRNPHl7RA1S1lfLe+8u2+KpNTEznj0fhOMWGhZ2FfNVlhQTyW6ioClR9QeF/GxLlKm47BOwo7OgEJ2HV7VLbUbFWD9qJT/c5AdkvHvI7NshTUVAkO3DUA0bTwZBvfufblEqm4MeXOtyc+42cM3QyH6y3qVTgSUfhA96EPMeQnw5ao10WFUy3WErEWpv3e1kiQSPysNJ4nV0E8lk0vT5G7s/CL3kxH0Oq6N1s3AtygN8jT/oT0PyKDlO5SNCTmVNTeAPF9X1wlsaNbo7u78q7yKuskjfxgaUis8jVReIHDoSULBDjY5Q+iY4XiOpYEUqSF39/G0CVqHbejitIEUi//6/er/hFw23ZSwCnlIYpSOs11lrT22YbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07c546c-96d6-40cf-ae3f-08dce706a0fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:31:23.8168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvowwHNLiiScZS13Dp+YUnzz7wcokRGzVW96fCkaJ8Yzsbj8HPwy5usUS3ORkQq/FQrmwfBUslBlF21zKgD7InDXHtTBh1FqrMapxx2YwgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070134
X-Proofpoint-ORIG-GUID: UyThEdynzuxjVrRycDwfTUsI5lajnQnE
X-Proofpoint-GUID: UyThEdynzuxjVrRycDwfTUsI5lajnQnE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/7/2024 12:47 PM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:40PM -0700, Steve Sistare wrote:
>> Add functions to create a QEMUFile based on a unix URI, for saving or
>> loading, for use by cpr-transfer mode to preserve CPR state.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> There're a few extra newlines below, though, which could be removed.

I added the extra lines for readability.  They separate multi-line conditional
expressions from the body that follows, and separate one if-then-else body
from the next body.

- Steve

>> ---
>>   include/migration/cpr.h  |  3 ++
>>   migration/cpr-transfer.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/meson.build    |  1 +
>>   3 files changed, 85 insertions(+)
>>   create mode 100644 migration/cpr-transfer.c
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index ac7a63e..51c19ed 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -30,4 +30,7 @@ int cpr_state_load(Error **errp);
>>   void cpr_state_close(void);
>>   struct QIOChannel *cpr_state_ioc(void);
>>   
>> +QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
>> +QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
>> +
>>   #endif
>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> new file mode 100644
>> index 0000000..fb9ecd8
>> --- /dev/null
>> +++ b/migration/cpr-transfer.c
>> @@ -0,0 +1,81 @@
>> +/*
>> + * Copyright (c) 2022, 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "io/channel-file.h"
>> +#include "io/channel-socket.h"
>> +#include "io/net-listener.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/savevm.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/vmstate.h"
>> +
>> +QEMUFile *cpr_transfer_output(const char *uri, Error **errp)
>> +{
>> +    g_autoptr(MigrationChannel) channel = NULL;
>> +    QIOChannel *ioc;
>> +
>> +    if (!migrate_uri_parse(uri, &channel, errp)) {
>> +        return NULL;
>> +    }
>> +
>> +    if (channel->addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>> +        channel->addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>> +
> 
> here
> 
>> +        QIOChannelSocket *sioc = qio_channel_socket_new();
>> +        SocketAddress *saddr = &channel->addr->u.socket;
>> +
>> +        if (qio_channel_socket_connect_sync(sioc, saddr, errp)) {
>> +            object_unref(OBJECT(sioc));
>> +            return NULL;
>> +        }
>> +        ioc = QIO_CHANNEL(sioc);
>> +
> 
> here
> 
>> +    } else {
>> +        error_setg(errp, "bad cpr-uri %s; must be unix:", uri);
>> +        return NULL;
>> +    }
>> +
>> +    qio_channel_set_name(ioc, "cpr-out");
>> +    return qemu_file_new_output(ioc);
>> +}
>> +
>> +QEMUFile *cpr_transfer_input(const char *uri, Error **errp)
>> +{
>> +    g_autoptr(MigrationChannel) channel = NULL;
>> +    QIOChannel *ioc;
>> +
>> +    if (!migrate_uri_parse(uri, &channel, errp)) {
>> +        return NULL;
>> +    }
>> +
>> +    if (channel->addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>> +        channel->addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>> +
> 
> here
> 
>> +        QIOChannelSocket *sioc;
>> +        SocketAddress *saddr = &channel->addr->u.socket;
>> +        QIONetListener *listener = qio_net_listener_new();
>> +
>> +        qio_net_listener_set_name(listener, "cpr-socket-listener");
>> +        if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
>> +            object_unref(OBJECT(listener));
>> +            return NULL;
>> +        }
>> +
>> +        sioc = qio_net_listener_wait_client(listener);
>> +        ioc = QIO_CHANNEL(sioc);
>> +
> 
> here
> 
>> +    } else {
>> +        error_setg(errp, "bad cpr-uri %s; must be unix:", uri);
>> +        return NULL;
>> +    }
>> +
>> +    qio_channel_set_name(ioc, "cpr-in");
>> +    return qemu_file_new_input(ioc);
>> +}
>> diff --git a/migration/meson.build b/migration/meson.build
>> index e5f4211..684ba98 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -14,6 +14,7 @@ system_ss.add(files(
>>     'channel.c',
>>     'channel-block.c',
>>     'cpr.c',
>> +  'cpr-transfer.c',
>>     'dirtyrate.c',
>>     'exec.c',
>>     'fd.c',
>> -- 
>> 1.8.3.1
>>
> 


