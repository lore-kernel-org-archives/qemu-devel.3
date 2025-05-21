Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271BFC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 20:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHpbw-0000JR-HQ; Wed, 21 May 2025 16:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHpbm-0000Fc-2G
 for qemu-devel@nongnu.org; Wed, 21 May 2025 16:00:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHpbj-0000Id-2T
 for qemu-devel@nongnu.org; Wed, 21 May 2025 16:00:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LJtlnl001397;
 Wed, 21 May 2025 20:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0iTc9vUtS3RabV3JP5jFe1UfsNrkJP7YECg5N6qvdVc=; b=
 sdeJLosKAZkhH2Uy+6Wfo4Glhde7f8hgFygvlmN9Hc8jlBLL3nWm7gxV7y04BZzw
 Nswj6P2h4BNDObKxY4gcO/iMvsdj6AncP+CPvZM1w4fCwBVvGq9NXlemoc+0ChZ6
 L0thBqJD25pOeTr4DA+iNTjWUqGDB7tmmcwLghyk0FwHSEEhn4iEVn1lHBpAlX3d
 nx6npzyqeeZXpE677RcLtcJDJ+167sEQucwFz/DHRIoYRCHMW0hFrENCvvEd7GdU
 NFZud0lMupqH81PgQcreGDZrZlTaCAv87QltOV4i7WiltOF+iY1JEP1xk5HyIXKg
 sWPE0/fHFCQjzJuoeb6CkA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sn0d022b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 20:00:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LIiFO8011274; Wed, 21 May 2025 20:00:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwenjkvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 20:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9DlnT5XlKkQujflwOhRRZlrG7uu6Pz05GGKImDlrLbof5Bn6wLhClRd4ICshNP2CcMN2aluAXaoD5i975XxHmMdlBdFqBeHtzMuCnxen1x4z0XtP+YEgbGN5+XCiza+wLjccTEqtos04+c6gr6I/5o5IKO/6PuNZZo8Rsf8QFaiQCrX68NJLWuXIEhrx8Yl53O77J5+228hW4fmYIKI5rgMro2QVqGEGsKiOB3x8xp1Mmv06HoT0hUODE7jKqBUC69kD1v+7H7J71eKWcC5O/D2qCH2RObbuuCdfp+aOS9zaykIxSdukNnNJdIvrh1stjdWLy3PARPUTN3UU785Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iTc9vUtS3RabV3JP5jFe1UfsNrkJP7YECg5N6qvdVc=;
 b=L6ecEHg8iqnczvjmQIhv9bT+N1N+S2a/qZA6UGheGRhYytJlXztcG4IoL/fZ4wme1+a4dMPmTGosLMZyGDKxD2jeloKiPZc4WVo6LbBVF12yyqgxc6AGj3++qzwhMALMeOUhV0peJs1YeK2frz3ldkvpJvUN3xNm250tOOVtmfh8XM6wgPa7YKsDSYuPMB5v/XtdP9o/OF0KTS6UeJFEPT8caYmXfDYD8QmIJKvkFiNFZeUDYQ80OAErLedE1jSBBWhITvFpmtSFylcxUPvmwTyJ+73Clat6BcNbgriwpvaJf1kymEydRi0F1cSKeml3Gzi94O/6jjNSNcq67Z/KGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iTc9vUtS3RabV3JP5jFe1UfsNrkJP7YECg5N6qvdVc=;
 b=I8oNczs557bCBopIXnEApTUJ+S77DoQ2w5uBDCX9GXTPO/ALSOVFKfXx5GgHrMkqVmkf1gXJrHkbH1d3zbYmKKvHTjMuA7aRMH+Qm9xj9CBtpj88c1oBEI1MlNVH7yzZmc/NAllNO8D00L0Wa6YxJNBVCcWNRe0bCsK/8e9qnds=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 19:59:57 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 19:59:57 +0000
Message-ID: <49f302c2-74c1-410c-9be5-3163999abb0c@oracle.com>
Date: Wed, 21 May 2025 15:59:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 38/42] vfio/iommufd: reconstruct hw_caps
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-39-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-39-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: d59680ea-7848-4228-5a1e-08dd98a20fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blFLTFp0OXJQWTM4U3lWcXF1cVI5dkFBQzZxNHl5aU1YdkFvMmdxQ1k3S1pS?=
 =?utf-8?B?QUNQZVlUSHM1M2dFTFdRay95bUcwQnZ3TkpYVTBtdENGTnNBY09JSG52cHMv?=
 =?utf-8?B?NXlQaXBwUlJEQ0lLRE1wc2x3R1JEakNtekRpeHR6RlZ5TGlQN0dvcFJGeE00?=
 =?utf-8?B?aFozSGpWY2NUVnZaR0tPZDZWcER5UFg4L3J6aVVwbFZMODM5YnA5bjBBalpK?=
 =?utf-8?B?QTJwMEFOOXRVRGowSUtHTXIzakxJbHN4MGs0QkNtRUNmcmQyTVJSWE8vYnY4?=
 =?utf-8?B?akRTRmVsNHJoMFM1bFFxNzlYbVFGbERRNThvVVcrTW5pbGdyN3dDc0RNZ0c4?=
 =?utf-8?B?eTk4Vm5paDhmTXJrQU1UeFJOclA1b282bnc5cTRLNUNocDJ2UFZ4anNFWmRC?=
 =?utf-8?B?aEVLT1VnRy9HM3YzMXR3N3RRa2ZBbFJQVlk5bC9TdmlpdlZDYXltaXhyUG9F?=
 =?utf-8?B?QzIyL01WNmhBbnFMSDJHZzNUOFJIUXpxcVZMbFZaUGpib3F2dHdCemM3YnZP?=
 =?utf-8?B?ZlN2cEh0UmcvZzFxbnh2RmZWN0pMVVc4ZjA0VGtmdEdMcEZLd1AyWFdsei9E?=
 =?utf-8?B?ZDlqQnQzNzhhU0p6SDdlZnVNNlMxME52MXlVelovczVIRzlJTHYxYzg2bkIr?=
 =?utf-8?B?eE1nVG5aTVBRR1hvZGxQV1ZaRWhKcitHMUdLVUY3NFFXeVpXNDc2WGg2RjVQ?=
 =?utf-8?B?WExBVk5JMHkrU0pBOWpaNmxwcFd6MmdNRXEvSTZFMStWUmZHb3hqQlFXOHlh?=
 =?utf-8?B?Q1NKYTZTb1NPOWlMVHBwQmZ5VERsYldBWGRNclpNdzRlZmdVUllPdHBiczA3?=
 =?utf-8?B?SmZHQjA3NDBSc2s5QUhxcjVETHlWdTY0S3N1NzJFeGRvcHEwZ2RORDBCMVlL?=
 =?utf-8?B?Vm5yYi9LOWEzMEtQalVwMUlncThscWFEb3Z1SGgzU1c5ZlhRdVdidHJQVHNp?=
 =?utf-8?B?Qmg4VU5WOTFhYnhETkpRN1BhUitqc3liTDhaNDYxMTcwaTFCZ0xZbzZUMENh?=
 =?utf-8?B?RnJtalRQaDJHNTJ6bk1UMGVIZ0p3WnVXRUJFUFdwR0lGbHlHaFk5azFYck0z?=
 =?utf-8?B?MExHRWdkSWtyOGdJMXE2YzNDbDhLUUJ4Z0YwZEtYSFZVTk1PR0orcmYyUlBM?=
 =?utf-8?B?ZTNscmw1aVNoUnFneWhKcU1VR1Q1K2dNbHhGWGRUWHEwSVlBdUpON295ZTMz?=
 =?utf-8?B?U1NyazErQ0JRalZSSkNNNkp5aW5HUVQrQkZXdXNTZExTaituYWlDQ1dzWjdn?=
 =?utf-8?B?K2t5K2Y1Q21zbzFYaEtQQm5NbEV5WjFDaC9kOVdzQVdtMkozYjZsaVlJRnJ1?=
 =?utf-8?B?V1h5cEtYbFJ1WEVBUjNqOE96a0ZGMEJUVnc3cFpLZGxPdlBJK2dOeHg5V0hD?=
 =?utf-8?B?N3VyWkI2QW5jOTlEUENzWkZSa2ZaeDRLc25NQnpidkl3aGhqSmQvc2hPVE1y?=
 =?utf-8?B?OXhXdmo4VUVveFFhU3oyVEx2MXI4cHJUeVIrYmZPN1ZKclNXQi9GRE0zRFA4?=
 =?utf-8?B?akJWOXBaRlZ5YmJ1NVZiRHdxTzkveE1WOUZlSlhEOFFGb01TTGdHdHBLSVZS?=
 =?utf-8?B?YU8wWU14eEVZL3AwWWVaYWw0VkNwb1oyaENRRE02UFFOOFhwMUFtNEdmQnI1?=
 =?utf-8?B?VjZNeFU1QTNKUExLQUh2VEVERnk0NUVXNFVFcXBVS2c4SjdGazNWb1VWc0tU?=
 =?utf-8?B?cGd4RGd0QUtZYi9EMzJzdXhxWUtmZFdVNkM3MVlRdGVEYzJ2aXQ1WGNEZkw4?=
 =?utf-8?B?K0NDSDZoTFdTR09LZ0RyZzhuRnIzaDFGWElrNnJMYWFnc1V5YTFwZ2lFaFFo?=
 =?utf-8?B?eEZBNEpNY3pEWFR5Mk9Sd2VuZ25NbUc5ajlPcXJGK3JjMGR4RFNEUDh2cVNN?=
 =?utf-8?B?K1djT0tDekZLTUd3eDNUOWJDeUYyRWJNNlREOXlBa3phdTY0NEdiK1NZSzhm?=
 =?utf-8?Q?fRMHHYblAhk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujh5Ulp4d1NtOWZiY09qZHBRdzVORmJOTUxKRXYxaHQzN0lhQzBCdzJLdE93?=
 =?utf-8?B?elMxZHVEVWtvM3VUcnpwQjYwWXBxTzdiLy90YVhtajlUYlVCaUpIN3dGQTFr?=
 =?utf-8?B?a0NHcmpvSWtCamY1NFIxcmhiY3d2eUp6blRXOHdDeTcyRS9GU2VoTWxUakZ6?=
 =?utf-8?B?eHdta3dnNVVIYnJuVWR5dkVYM0JNYW5mOWNsVXRqRHpnZ3pkSjZEYmJqMXp6?=
 =?utf-8?B?NUMvZWZXaWVsSDJ3Q2I5RW5TWkRzN2xKaUZTU3Y3cnRNbjNyRDJvQ3dDa3py?=
 =?utf-8?B?SkdYMG9KQmt1anF6aGxxclhKam02bU5UbkZOT0trV1VNWGhxM0FQeTFhWFUz?=
 =?utf-8?B?cThZdXYxQ0pXZERMQ2V1Y0R6VGhLa3Jtd0I2Syt4aEpjenllVnlVZFEzY1V2?=
 =?utf-8?B?UlVrQ25wSDFMWExMN3hwREVkWTJIN01SU0swM1BITVdqMWhUQ0JqNHdlZzZZ?=
 =?utf-8?B?WFpDMHpOMlppZmZSeVIxZ3dPMGs2aXZZTHZHZnozVlRXU29JNWNMc1lvZTdQ?=
 =?utf-8?B?L1E4Y3NmT1NJamJsRjR1aGZ3c1FWSkszcE5mV2Y3dEplSWFyYnNVSDMxQlFZ?=
 =?utf-8?B?MU5NZE5LZ3F5NHduczZTZTFNc0VyUkhiTHRDK2dJdlA4SWFvTVdSNStnTXJt?=
 =?utf-8?B?czQ1MU40QjQreElZYmwrSGJoYW8wZVRLREFJQ0RjSGs0RWNxWEZCbXBuYjJm?=
 =?utf-8?B?SXQ3Z0IvOWVqNll5QXZ6d2JMdFFnSno0bXVQcUdIRUJFR3R2WDE2bE00WWVJ?=
 =?utf-8?B?OEd3cDNMRWdHSktZbTd2MWhjeW5vcTc2Ti93L3N4cmFzWm05cW9wNGkwU0ND?=
 =?utf-8?B?TitPU01ueklIMnMvaU9PMW12VVZHbkdSUlNncjBXT1NtVlh3VmlHTkZGUjBN?=
 =?utf-8?B?MzlyankxVklnVm5qYlpWTGFQMjg5WXg5L3VnSmViVGl4ZjZ2UmNybVp1b2VB?=
 =?utf-8?B?S1ZSMVJVaGx5S3FRN0ZkUzU3Y3cxdC9saGNNM3U0YW8vN0Q0bXdXTWdXcVJR?=
 =?utf-8?B?bFRMN09kNHBQSDNrSjVkVGlIZEFHMUJ4NFZ5V0MwU2JRSHpkSFpUMHRISXJw?=
 =?utf-8?B?WitVMlNsa3owV2s0dVNYSWh3cmhTUVVOSUkwVk1INVY4L0s5Wmg5VGttdHow?=
 =?utf-8?B?YitaMTIxbFdNMjk4NlNGSm5nZEJMT1RYeEVSb3lLbFQ5ZUxFTFRnZUdYcU5I?=
 =?utf-8?B?TzB5cUF1aTIxdkx1ZmVzTlF2ZEtJMVIvWkVCaHpZaTZvOUg0VjA4UmVlV1py?=
 =?utf-8?B?VXA3QUQ4dDdkT2hiaUNnOHU4dFZZbG5LMEtZcS9JQmwvUHIzL1dNWFViRmR1?=
 =?utf-8?B?Q3NSU293SEZzWHVJajlITUVoWjl4ZUsvMTdzazFTeXJwNFhzNXd4cVp4RHNo?=
 =?utf-8?B?OVJ2QUxxOVJMTUR3RHBpRDd4VGFjNkRQaGpCUjdWQWV2NTNyR2R1T2o4SlMr?=
 =?utf-8?B?TkFLOHhMdFVGWFROcEFuTG5xMmkzN2x1VmZYczB5SkJGN1NrcVRMUEtoaDBZ?=
 =?utf-8?B?WEdJVzRCSzA1bnhzVUN6aUllQXRDOWh2RHA2cjZ1QXhDZ3ZJQlBPeXZneE9H?=
 =?utf-8?B?WXNzTE05OFJDSmVQMjJhOXVua1czNEY5ZWJqUVAwNFhhZVIwRlFWaVZqbUV4?=
 =?utf-8?B?RkpxWHpOcjJuV2s0dFlOQzc4S3FmTjJjTlRaNWxaWXpnSkt2SE5sYktIYml4?=
 =?utf-8?B?UzZBM005RzB5UDh4Wk83b2VkTldkRzdzZ3c2amhzSVkzNFl5VFZtTGZPdmNI?=
 =?utf-8?B?QlUvWkNvcHZLZ09vY3RKOFJ4aVMxVG4xTm9WeXdkYlZlSGxKQWtnTTc1Y0ty?=
 =?utf-8?B?dXA0WDh4Mzl0ZklUQ3B0dFBHNFhYSWJkeHozaldOZzZrMzVkUG0yZ2xMaDNq?=
 =?utf-8?B?QUpmSWlUalJ5NVhDaUJlWWRwNjJBM0ovZkpGQlRtQUpPekFyUXBMS2pXUGx3?=
 =?utf-8?B?UEthZ21vOHpCY0VwWnk1Q3l2T1JrU1Fzbi9GZFA3N051akxNTkdlK1dHZDhY?=
 =?utf-8?B?Y1dVc2JzMHM4SUhnN24vNlBVYlVWMmNnWUlZSVNDMER0YVErYnNMVkU1Si9Q?=
 =?utf-8?B?ZDIwNWRpTEw4cmFnMFErOHdERjIrVEQrMkZ2OWVLdzd6aXpPVUF0cmllM3hI?=
 =?utf-8?B?anBqQWoxWGloUGprMndra2hSTzRBSWlzWHhSK0o3ckR2azZXUFo4ZlhuQlVM?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1kZm2eviqveUXwuLp3CM+H5Kaw2EiCyryblDmp/1Clpw8+EZBeIt3ZoO9vw6Te+p3Yu1uH6/ugbQAtVc3WYKTdjkJArXk1nKLhHnRRNzzPK474IL60DGYt0tTv/5kRq8TxRQ8wtVSAZ7SjgRr6paMXtcVjLjAuC56C1EJK7zJXTj0xsdhVSuGWtfhfDfCkq5qMecobOkrIIsR/gtTS2lLTgMjo9PNOLGwpWqPi4JnfcNVy8RecdZ5A/7YhnF1eCJJjWnPq4U8xyN+WeZvBLPiKkxCLFQ7/EhjQIrgOx45j24luHiGLlly/JCa+rvnKVG/qB/dWaLYqOeqym+eK2bWEzDWgmSJLQLLqnv6AwnoXSoJm85URx8jkq8Nj9y3sUOErGIZbQKZdVQ/3yDIqZc+DM/2n3f328fWXwZ4GiD/NRpRB7Eo417dcV09qVcg/G7Q7jXNATnHr4uuiRCa5omBPd8JEY8wp4djzYBKjxbkdwX3CSYyvN5Td+3KDowxFG42YlXqJHxqTbGOZc7l7K5UQOCf6Os9IS4hBlGuzSr6OXnUX8hOuLIdODNy9uloXgj6uWNXNRNU10UPSSU/eMLznLZf2Z8v/HB5ryzdE+p5gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59680ea-7848-4228-5a1e-08dd98a20fd6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 19:59:57.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO15znVrJNgQaRdd9Jl0ckczWGraiy8y538/9Ustkrg6KlTLoiLaWBbyCrjD5V1SVyuCWXxQOfmWEHfe/Irrz16crPxCVI4mENwXDlTBlds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210197
X-Authority-Analysis: v=2.4 cv=Qflmvtbv c=1 sm=1 tr=0 ts=682e30c2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=sSWD_89OnNp0pYD7s0MA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE5NyBTYWx0ZWRfX9ZUZNWTDeX0+
 ANfcO0SUlyvY4BHi9e+CNp+q5vdKAEpKBKg798Q74i0Giq/wQ5Dj7pp1L48Hp0toJvJWpoYWYnJ
 sjyhT4TNM4/UXvYpsBzTqrx8EA4KFd3Lm44coFN7hf+tBE7lGr9TUX46y7mxxmQLqBRVRahZvIX
 c7EN9Jsh+VRfkRjirvvogEvCDRROCd33kjgZko4xCUyIDbU1SLczdLU97L0CQfLPitklLJW6RW7
 PAM6QfBtEGx5dEqX3ItV3du3adFNfCkD+/55jlBnFAzClAJ/JBI2ZxMZGWCwHQ1YPI1UUOjdSvw
 PUEUd0djGFDjOSX8uvlXUJOkB8JENTPn+tMqr2UPWrnaOKu9ud1h/1xgxaWGKWwRWGAWNA0Vnoy
 nYaeofP+C7oQx22qQl3+QCRT5M9AXimdnlNdPVDc/9FE4tB+Hf3Qlboop1fYk0w+e+64wzXs
X-Proofpoint-GUID: GPc-OQAfWx0FIY3JRf4ZUjsdLQl9X_Y0
X-Proofpoint-ORIG-GUID: GPc-OQAfWx0FIY3JRf4ZUjsdLQl9X_Y0
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

I withdraw this patch.  I will instead save devid in cpr-state.

- Steve

On 5/12/2025 11:32 AM, Steve Sistare wrote:
> hw_caps is normally derived during realize, at
> vfio_device_hiod_create_and_realize -> hiod_iommufd_vfio_realize ->
> iommufd_backend_get_device_info.  However, this depends on the devid, which
> is not preserved during CPR.
> 
> Save devid in vmstate.  Defer the vfio_device_hiod_create_and_realize call
> to post_load time, after devid has been recovered from vmstate.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr-iommufd.c  | 15 +++++++++++++++
>   hw/vfio/iommufd.c      |  6 ++----
>   hw/vfio/vfio-iommufd.h |  3 +++
>   3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index 3d430f0..24cdf10 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -100,12 +100,27 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
>   
> +static int vfio_device_post_load(void *opaque, int version_id)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    Error *err = NULL;
> +
> +    if (!vfio_device_hiod_create_and_realize(vbasedev,
> +                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, &err)) {
> +        error_report_err(err);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static const VMStateDescription vfio_device_vmstate = {
>       .name = "vfio-iommufd-device",
>       .version_id = 0,
>       .minimum_version_id = 0,
> +    .post_load = vfio_device_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {
> +        VMSTATE_INT32(devid, VFIODevice),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index c49a7e7..d980684 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -32,9 +32,6 @@
>   #include "vfio-helpers.h"
>   #include "vfio-listener.h"
>   
> -#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
> -            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
> -
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
>   {
> @@ -557,7 +554,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>   
>       space = vfio_address_space_get(as);
>   
> -    if (!vfio_device_hiod_create_and_realize(vbasedev,
> +    if (!vbasedev->cpr.reused &&
> +        !vfio_device_hiod_create_and_realize(vbasedev,
>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>           goto err_alloc_ioas;
>       }
> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
> index cc57a05..148ce89 100644
> --- a/hw/vfio/vfio-iommufd.h
> +++ b/hw/vfio/vfio-iommufd.h
> @@ -11,6 +11,9 @@
>   
>   #include "hw/vfio/vfio-container-base.h"
>   
> +#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
> +            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
> +
>   typedef struct VFIODevice VFIODevice;
>   
>   typedef struct VFIOIOASHwpt {


