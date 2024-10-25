Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFE1D149F6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 23:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Tib-00021U-8H; Fri, 25 Oct 2024 19:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t4TiY-000207-JP; Fri, 25 Oct 2024 19:27:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1t4TiV-0000cS-Gl; Fri, 25 Oct 2024 19:27:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdTej009560;
 Fri, 25 Oct 2024 23:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=XUt9vzmbeF1UWIhZaK
 pLuQL+OWw1vvla+iCxAO2OppM=; b=f2DX7ZH3+RBiNqP8p/0qGfIbyDuWidPJez
 EP3B4PQ+HZJdcwTWJRXcJbzAxa7HNrEjngqcaNJfHAMA5ie+BI1m7HqaeMByl6TO
 uKjjqERRZKXYbQ8+1Hzwd8m5fAv5UH5fvzr8EoBjxLbiiYoJ6+lptjKzSqrV4D15
 PqqldIiD5ASh2gA5Nh/Gv5aTd7lMbGC7UBEpEIOTosJ+mFdFjb4v2ZJ22NhxvOxD
 gpeLb3G0IOIlFmFwbixZxksyUFGkRPpm4spqemtre39BVCxlc9QSDi7t6zdB/xQ/
 aQZirJDipnbQ2nTj71fBmcyWehhyheoaEUJLB9rVUm7rFUKwYanw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v62y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 23:27:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PMArn4016585; Fri, 25 Oct 2024 23:27:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emhefasg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 23:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh+hWzhF3GLX9Ajcg4E9Jp+8ZG/KC9Od5t17xxbEzbp+vxsqBqNzLX1t1U5QFoGtM0Fppw83RCFE0TD4zxyZOeHAkZRCbOc25RXJY5ubZrSfjsr5nWjOId7YtcMOTzhonOaT40xQTYTxXmTxM8isdfpG0r8N2Io4z6O5NSDWvd8kOD5zgUxaEtbYPEvTvWVcTC+BplFFpzNOOkp7F998iQbK1tq1WD4eNoC1fw5Xz+glLcHYEN+MUaKuj8KTpqR6o8gzaqR7pPkipHku4xw6a4RiVxO98FOoMSDOJ+A8gjAnFgHY7SBFu8Ox/VtLdzLJIQfj74N7HmMt4cE9WY4BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUt9vzmbeF1UWIhZaKpLuQL+OWw1vvla+iCxAO2OppM=;
 b=qT6JJzj+j92LA4n/WGNXTNkY7s5O9Z00WA0e/nH+h2LLqJGrELOv/OhA/8EHsYB8wp0ztUAIem4z4rfSYtaTINqRVOYYs5oYIHZ5Z/h7BMeG6eBdoI986Nts1I1Ct4QHxu8DmuwXXh6qUxubRrtH7Gbaa69eWgOqR4P8EzTI1BH5o2Eib60VBhM9rRgBHKPGslIn0sCtdsr/JqBrAUKgFTc8Jyp+c8uCT5F2NNiT+YrzZsAVzyC8KbJ4HRrwiJfySvK8VvrdvT3iF/mN1Nwu7Y6DtrniNcXe59HF3mTG4HfgPwSK22a4Af29pCSY7Ph3yOUy9O9o7xKMyy84QxcekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUt9vzmbeF1UWIhZaKpLuQL+OWw1vvla+iCxAO2OppM=;
 b=X8FKfWwEK5Yb7zLJPjkdWHHfxC9d+eMQM6CZRtlSFbph75uOa0pwUfnEibs98xNXqqqFUl0fDlBa8ZtAEnhCUQJllXSuV4hgjk2bG4V/q6cmogSvjS4QLmiFBDeCGU7v0u4yjPRVnmTCCGghnLLDCQwKCS96o9rMlogwjzW6kQ0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB8141.namprd10.prod.outlook.com (2603:10b6:208:4f9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 23:27:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 23:27:28 +0000
Content-Type: multipart/alternative;
 boundary="------------hgY5tBYnC80xFaueadyA07yr"
Message-ID: <9b17600d-4473-4bb6-841f-00f93d86f720@oracle.com>
Date: Sat, 26 Oct 2024 01:27:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] accel/kvm: Keep track of the HWPoisonPage page_size
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 joao.m.martins@oracle.com
References: <ZwalK7Dq_cf-EA_0@x1n>
 <20241022213503.1189954-1-william.roche@oracle.com>
 <20241022213503.1189954-3-william.roche@oracle.com>
 <a0fda9e7-d55b-455b-aeaa-27162b6cdc65@redhat.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <a0fda9e7-d55b-455b-aeaa-27162b6cdc65@redhat.com>
X-ClientProxiedBy: PR3P193CA0059.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::34) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b00a9b-d44a-4760-e7c2-08dcf54c9729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1pWU0x0WGMwK2pZQkxyOWg0QjZuTHF4ZlB1N3I5K3B5QjdpVUZ2aUNtKzll?=
 =?utf-8?B?aG42czZOUkg2VWt6TFlSQWlLTk8vZTZSdUJScEQrell3bStEM0ZtYS9pMmx6?=
 =?utf-8?B?ZlFnTkVDNlM5Q2c0cUU2UzE4RjQwUytpMnlzVzRONVVRSlRtZEpYaGttZGZM?=
 =?utf-8?B?QVBlbEIyeVgxTGExV3NENWpwRER6WFVqZGF3YkROcXlicFltcnoxb2NnMEkv?=
 =?utf-8?B?ejlqeVJKOXd3YUZGT3k5TnhFVi9MekFQblpTN1RlNW9OaGVFVnJWWFF4UGtV?=
 =?utf-8?B?R0FHSEQ3Y2RYb2c4SWIwRGZxZUczeGQ1QldkdmhVODloK1pkejB1aWpkZGJK?=
 =?utf-8?B?NXpuTUdJZTF1R3VMU0tyWDZjZ0JIT3dtVGtPYW0rWlBjcHNnMmNnQk9FTVpr?=
 =?utf-8?B?UjJmSmRzRWkyUXFxbWRzUzRuUjcvTVV2NWdrQUZPTHNGSVlTdUdmR2xPdDlL?=
 =?utf-8?B?cEFTUWFYaEt5WGFaaElpRTNZZXJJWGR1TG5INlkvMGdDZ0JkeE8wWVBuL0hw?=
 =?utf-8?B?Q1RMeTl1TmtpZVlDcGdQbmx1Y3RTaEZlV2dkUnRjaVBlem16TUNmak1TU1Jo?=
 =?utf-8?B?TEd0b1lzbEpVRlQyL1RjUTBCSGtxRzNOeXFPdGZSZFJIYmdJQWdMNFFPUFdk?=
 =?utf-8?B?UXk4NlpIK0Y2dXdHTnZSVkd4a1dCWjcwRmlIajcxZDdCNU1WNXRiK2hFbng1?=
 =?utf-8?B?UGZsTnA1MHRKaVNteHpucGhnUHhHUkp5UFFNMExIQXdwM1JUV2tHM2s2OW1l?=
 =?utf-8?B?MzJ1cmRvT2FGcEQ0TFRYV2dnMXBEbWF4bjFkQk53NjhQSFJKcWlGaDNtT2lm?=
 =?utf-8?B?blBxMElBczV4TFhNb2d4THhUVUJuTDlSdzBjYVVTZ0FyWG9kSWxVcEdxMXVl?=
 =?utf-8?B?eTg2OHJyeFlhNWZZMEFIYzNNU3hBdkxUd3ZvUVcrMmRicG5CQnNzeTFlSlRZ?=
 =?utf-8?B?eXdXK3JlelB0eWphZ05FZTRPbzhtWlc1dTRoS3hLSFp1dWpVWEtpZWFIbkVD?=
 =?utf-8?B?R2ZNWFB2bWovdmVIRjNtUDBvUkJOWTJ4V0pvZEJlOHYxTzVTVklpdERJUE43?=
 =?utf-8?B?UXpkZDZ2d3Q3QXpGZjFCNVdUS1pRUGV4UEMwaEtDdmZJenVadHdidk1zT0Vw?=
 =?utf-8?B?NkgzRlJJQU5adXc1S3FYYnJOeEJ4NkdDc3MvVk9pNTZ1WnpCWWlaeWZOQnJR?=
 =?utf-8?B?Tk1WQjFOSkM0NkJFWnluK09FOXhaYTk0RkIzak91aktSMnQxSmdNNkZ5eG5h?=
 =?utf-8?B?MlFxcnBnUitjOUgvTnoveUVmcjBhUXB6T3daR1FpSUJuamVlT21TdWJ0ZmRC?=
 =?utf-8?B?Ly8vcHdLSTRYU013N3FGdE1kSkZpbUdxU1I3R0JKTEo5aFhCUHJoYnRTck5S?=
 =?utf-8?B?d3dwV29YL1JMNXh4Z0JTRm9Zb0V2QjEwVTV6T085bnIxeWlOWHFpenJXaTRX?=
 =?utf-8?B?MGlnZXdYcEFtK0Z6R0tCUHhaYnBuT1AvZkk0MnFIMEh1VUF0NmhMb3VqZDBj?=
 =?utf-8?B?Sko3a1p4bnQ2Qm43UnRucXlpUDJxNlczdjJQODBTYUM0QzAxaG5TVWJqUFV5?=
 =?utf-8?B?RWY4Nk9vbzQ4c2lhNFNXZlFuc1VtTWJLWlBtR1Fwekc1aWg1ZHJpZ0p6YWhZ?=
 =?utf-8?B?MkVUVkxTdUpjYmhxVDVzK0s0WWJKMkQrenBidUl3TVJObTVlU0FwdW1Odm95?=
 =?utf-8?B?S1dPNjhiVUJqcStVVDhMdjM5SDE5NWRWdmhqaFBxeU9rZXZWTnBuZjgyZ3Nl?=
 =?utf-8?Q?UP/J9ZxS3sG8rTQspXhi0R9NUVKbzzfntIlgMoP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3NKMDloY2Z2bDZVKzN1WDRWU0lEYWU2UXp1OVZqQnUzeWNuSUdQT29vQmR1?=
 =?utf-8?B?RnNkOWF6VEpDY0piemlxZytvSWp3RTYybHkvak82OEFqNldMYUV3aHVRS1BZ?=
 =?utf-8?B?NVd4bWtRbnFoTmNxNDJCM3YwUGJlSzk4V3VTczhUTDFZOVlNNGNGUWFkUmh5?=
 =?utf-8?B?SXRnaU1Jc0dQemRyanpoZFVCYmJGa1JQRUhCbk1peXE1MzR5R2dKbmsvMU9v?=
 =?utf-8?B?YnR2SytqS2o5dnBzcCtTMUFlaTg2UVp3bzYvQTVEaHRNM2tQd0hOVngyNGdh?=
 =?utf-8?B?Ui9BMUpHQkR2cEhvYlVGYlhMOWZRVUp2bTBCQ3RDS2ZjM2pEREoyK3ZSWFJL?=
 =?utf-8?B?alVYM0JtMXJRc3B3YmlJUHhDOGVFYVI2akxkQVd6L0MweGVnSm5ZNjhrcnR2?=
 =?utf-8?B?WkVEcUxrYmxYSDB1RGVQbzBrWFhhM1VNSzhsdmFrUDNSMUM2c2NsS0FkVExV?=
 =?utf-8?B?ZzlyMndOTmdqQStNeS9ZMnhLQ3N5RmRFWWtSTE1sUlptSGs0RnZmR01kV3lW?=
 =?utf-8?B?UEk2ckZXQjVOM3NtUXdqbDdDNk1uUGE3UFdxR1ZIdnpQbm1WWEpIa0NBU2xq?=
 =?utf-8?B?UjFyZ2R2NzU0SFAxQnJWZWlaODhITXFuZ2lZZzBQZ3VBOGZidjA0Sm53QWU3?=
 =?utf-8?B?dXBlSnlnRGNIbytqYnNTWkt1Wm9YWlhUdlFSQjdFQWFEZmZYaTlFcmdvcGVZ?=
 =?utf-8?B?enBjTEJYNm4rOW90NHJsYXJFclEyazhsZENibzFLNGtOK1BtTW05Mm9qWmNp?=
 =?utf-8?B?bDlpTlVOZnorRXhjN1g0QlZzQlpIZGNXd3kwSG1vaVVXMWFhOTA2dkZaQnIw?=
 =?utf-8?B?cys1bkdqMGdJdysreWIwZEZJVGpUemd6bmxWLzllSE1ON25RVk9XblRGNENP?=
 =?utf-8?B?bzVsVFBxS1JqTEd0VUNiazFzanREVmFiN1p5TEVzeVpUdWRHSWl6MU4xbW95?=
 =?utf-8?B?L2VMT3pzbWU0LzhBTjZIM212NVlxYlpha0dqYkJqZG41SFUxdUxEc1NEQTNv?=
 =?utf-8?B?Um9pYjFWbjZwTEI2YjMvSklKd2NjdzRVSkJIeU8rTHgzRXhxUEJ0eUhtVzZF?=
 =?utf-8?B?MlM5WURwU3g0bDl4Tm1Da003aWZCVElEeUlDbGNFWnlWelN0MXVtTEM3V25q?=
 =?utf-8?B?UkFYbnRRSGg1V2JBa1VoOWJEem9YdThIL21wWVlGcmt2K3NzUzY4YlhCL1hz?=
 =?utf-8?B?VDBPeUptVlZnbU1jY2VsbVNyK1dVU01ZTzRuVGJ3bWRMMnN1eVFGN3pDbHVy?=
 =?utf-8?B?bHptaTZCQnZwbW85alZ4M0F6WjF6LzluOUQ3WnpNdTB1Z3UvVGxQdXlTa0lE?=
 =?utf-8?B?VTUxa0FJMytMNjVRY0h1WHhmbXZSOERNak1PZDJWM1I5dGJWZGVEQmNIZjAx?=
 =?utf-8?B?cnljQjBqaGJwWjhwK1BBR25nK2x4bGYvc3FMWllPUkJOMkdiMEhtWGRSa1cz?=
 =?utf-8?B?RXRJWXp5c0xqNXlXODg0bDdwVG9Dc05DTUR2T2lITElGb0ZPYStRNTFVTUJ4?=
 =?utf-8?B?WkZ0QXFObnByalZOMy9KMExSdWNMT205TTdiUXlxalRPcWNFaG55OEJrR0cv?=
 =?utf-8?B?NzgyR3ZsQ3FFRG5wUXUrNEI1Y25ZdWdjZVozV1M5TlJ3TUdrNjhSWFpoZFpm?=
 =?utf-8?B?bzlGRVRqZ0ZWbm01aG94TGVkSTc0QURqcUVqMmpsM2JOK3piaGNVdVpoZWlE?=
 =?utf-8?B?TDdzRitZRkNxbFJKMEVnNXdWYnRlU0hYQ0g0QWhmVWd6bWxtWmNVVmxqR0J5?=
 =?utf-8?B?cDRGTmFWeU5OSlpPOHdsOGNWZWNBdExYSkxZV3dJdUNkdlVVeERWZmJoQldB?=
 =?utf-8?B?NlppK0pFOVljbjl5S3QvTllrVlloNEdQMHdKbVNFM2lkcloxZmxjeCtTWFBt?=
 =?utf-8?B?WnN4cnc3ZDdUOE5obktyY2JTaUtidEszd0lWTHE0ZnBvd3RNdmtCWjgwSldt?=
 =?utf-8?B?S1Z4eXBqQm5Rc0wwcCsyM2NRN3hxdFB4U0F6ci9paE1ZYmtnOFZpaUppN0M3?=
 =?utf-8?B?MC9Gc0RpZG0xaGYzYkpGSm5wWGZYcms4VzZJNnF0bWJNL0xwR3Bucjk2U0RQ?=
 =?utf-8?B?bHRpUDlFbTRWQ0lMY0dVS0dYWDRYVi9IMEZ6VzJWaXEraWhONktZcndPbmhN?=
 =?utf-8?B?VGFPQzFzaEwvVHdOMXVTbTc3dlFLZHJIekZpUW44MHFTT0t2VEY4cWx6RHFU?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nmA+4CxO2yWz3wdSIbE5hmLhYwPA5kOPPybj2k4jVsAyEkVccG8dgxqDy/SqjWKfhaO0Jdu38xyAt6MSwZcWanuizvWloen5eFWADcS4o4hMg6phiQwtx5QkicloZRSml7P7ATj9KhyMK5g4KF+g8K8gU+qr6aKmlxRf6B8y5CuiBmkYvEZZp9yu+TWKyuG9KOlD0McFGfevjlOlkOLXCo3CiJd9zF1Mpp89CxnBzKZTbBTDudUSMQ/pqrL5kIRp0a8akbmjicK64kSjuRrf43Rm1JREEjp2igDJ5OBY7RIBgu/Aa+e0uBuD5eYTHfnlk+0QMU8sv7e6J9grHv7RKS48vOHSWiT01dMGVjkZLalisNDiSC3xqj/tPGYWu3Wq3Wt6utRdiOjPlNsO2AFvCn3/6IdwyuwqbdgV04xdINZ2HqyjrriPolfq2ZxYLEtz9w4XIYgkUEY/YOfzupUrex3hXMoUSeNJp9MWlcG54ThsjgA/ip7qrSZPNd7OnULf2r4N+VUjV5s38RK3UDnrjYSfZVl3aqv4knCgncwo+0pbtbcFIp/isA+/IM0AgMc95ApXbg7U1FabHCa7XdoZ2jIiseSxtB4J/PebxWjOS+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b00a9b-d44a-4760-e7c2-08dcf54c9729
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:27:28.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKRDIFhU38R+BuToVn2NQrL1nxjDINATQPXZjO1vP1WC2qIS5XCduproZ3yI805gVmTRM8Q1EYrqaWaLRjFY3ZzxBwkqkT1M/q9uGvRFm00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250181
X-Proofpoint-GUID: XocW-tgS5B1Vu3SLqm4wVNj--h3YGVix
X-Proofpoint-ORIG-GUID: XocW-tgS5B1Vu3SLqm4wVNj--h3YGVix
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

--------------hgY5tBYnC80xFaueadyA07yr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/24 09:28, David Hildenbrand wrote:

> On 22.10.24 23:35, “William Roche wrote:
>> From: William Roche <william.roche@oracle.com>
>>
>> Add the page size information to the hwpoison_page_list elements.
>> As the kernel doesn't always report the actual poisoned page size,
>> we adjust this size from the backend real page size.
>> We take into account the recorded page size to adjust the size
>> and location of the memory hole.
>>
>> Signed-off-by: William Roche <william.roche@oracle.com>
>> ---
>>   accel/kvm/kvm-all.c       | 14 ++++++++++----
>>   include/exec/cpu-common.h |  1 +
>>   include/sysemu/kvm.h      |  3 ++-
>>   include/sysemu/kvm_int.h  |  3 ++-
>>   system/physmem.c          | 20 ++++++++++++++++++++
>>   target/arm/kvm.c          |  8 ++++++--
>>   target/i386/kvm/kvm.c     |  8 ++++++--
>>   7 files changed, 47 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 2adc4d9c24..40117eefa7 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -1266,6 +1266,7 @@ int kvm_vm_check_extension(KVMState *s, 
>> unsigned int extension)
>>    */
>>   typedef struct HWPoisonPage {
>>       ram_addr_t ram_addr;
>> +    size_t     page_size;
>>       QLIST_ENTRY(HWPoisonPage) list;
>>   } HWPoisonPage;
>>   @@ -1278,15 +1279,18 @@ static void kvm_unpoison_all(void *param)
>>         QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
>>           QLIST_REMOVE(page, list);
>> -        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
>> +        qemu_ram_remap(page->ram_addr, page->page_size);
>
> Can't we just use the page size from the RAMBlock in qemu_ram_remap? 
> There we lookup the RAMBlock, and all pages in a RAMBlock have the 
> same size.


Yes, we could use the page size from the RAMBlock in qemu_ram_remap() 
that is called when the VM is resetting. I think that knowing the 
information about the size of poisoned chunk of memory when the poison 
is created is useful to give a trace of what is going on, before seeing 
maybe other pages being reported as poisoned. That's the 4th patch goal 
to give an information as soon as we get it.
It also helps to filter the new errors reported and only create an entry 
in the hwpoison_page_list for new large pages.
Now we could delay the page size retrieval until we are resetting and 
present the information (post mortem). I do think that having the 
information earlier is better in this case.


>
> I'll note that qemu_ram_remap() is rather stupid and optimized only 
> for private memory (not shmem etc).
>
> mmap(MAP_FIXED|MAP_SHARED, fd) will give you the same poisoned page 
> from the pagecache; you'd have to punch a hole instead.
>
> It might be better to use ram_block_discard_range() in the long run. 
> Memory preallocation + page pinning is tricky, but we could simply 
> bail out in these cases (preallocation failing, ram discard being 
> disabled).


I see that ram_block_discard_range() adds more control before discarding 
the RAM region and can also call madvise() in addition to the fallocate 
punch hole for standard sized memory pages. Now as the range is supposed 
to be recreated, I'm not convinced that these madvise calls are necessary.

But we can also notice that this function will report the following 
warning in all cases of not shared file backends:
"ram_block_discard_range: Discarding RAM in private file mappings is 
possibly dangerous, because it will modify the underlying file and will 
affect other users of the file"
Which means that hugetlbfs configurations do see this new cryptic 
warning message on reboot if it is impacted by a memory poisoning.
So I would prefer to leave the fallocate call in the qemu_ram_remap() 
function. Or would you prefer to enhance ram_block_discard_range()code 
to avoid the message in a reset situation (when called from qemu_ram_remap)?


>
> qemu_ram_remap() might be problematic with page pinning (vfio) as is 
> in any way :(

I agree. If qemu_ram_remap() fails, Qemu is ended either abort() or 
exit(1). Do you say that memory pinning could be detected by 
ram_block_discard_range() or maybe mmap call for the impacted region and 
make one of them fail ? This would be an additional reason to call 
ram_block_discard_range() from qemu_ram_remap().   Is it what you are 
suggesting ?

--------------hgY5tBYnC80xFaueadyA07yr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 10/23/24 09:28, David Hildenbrand wrote:</p>
    <blockquote type="cite" cite="mid:a0fda9e7-d55b-455b-aeaa-27162b6cdc65@redhat.com">On
      22.10.24 23:35, “William Roche wrote:
      <br>
      <blockquote type="cite">From: William Roche
        <a class="moz-txt-link-rfc2396E" href="mailto:william.roche@oracle.com">&lt;william.roche@oracle.com&gt;</a>
        <br>
        <br>
        Add the page size information to the hwpoison_page_list
        elements.
        <br>
        As the kernel doesn't always report the actual poisoned page
        size,
        <br>
        we adjust this size from the backend real page size.
        <br>
        We take into account the recorded page size to adjust the size
        <br>
        and location of the memory hole.
        <br>
        <br>
        Signed-off-by: William Roche <a class="moz-txt-link-rfc2396E" href="mailto:william.roche@oracle.com">&lt;william.roche@oracle.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; accel/kvm/kvm-all.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 ++++++++++----
        <br>
        &nbsp; include/exec/cpu-common.h |&nbsp; 1 +
        <br>
        &nbsp; include/sysemu/kvm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++-
        <br>
        &nbsp; include/sysemu/kvm_int.h&nbsp; |&nbsp; 3 ++-
        <br>
        &nbsp; system/physmem.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 20 ++++++++++++++++++++
        <br>
        &nbsp; target/arm/kvm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ++++++--
        <br>
        &nbsp; target/i386/kvm/kvm.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ++++++--
        <br>
        &nbsp; 7 files changed, 47 insertions(+), 10 deletions(-)
        <br>
        <br>
        diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
        <br>
        index 2adc4d9c24..40117eefa7 100644
        <br>
        --- a/accel/kvm/kvm-all.c
        <br>
        +++ b/accel/kvm/kvm-all.c
        <br>
        @@ -1266,6 +1266,7 @@ int kvm_vm_check_extension(KVMState *s,
        unsigned int extension)
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; typedef struct HWPoisonPage {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_addr_t ram_addr;
        <br>
        +&nbsp;&nbsp;&nbsp; size_t&nbsp;&nbsp;&nbsp;&nbsp; page_size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QLIST_ENTRY(HWPoisonPage) list;
        <br>
        &nbsp; } HWPoisonPage;
        <br>
        &nbsp; @@ -1278,15 +1279,18 @@ static void kvm_unpoison_all(void
        *param)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QLIST_FOREACH_SAFE(page, &amp;hwpoison_page_list, list,
        next_page) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QLIST_REMOVE(page, list);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_ram_remap(page-&gt;ram_addr, TARGET_PAGE_SIZE);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_ram_remap(page-&gt;ram_addr, page-&gt;page_size);
        <br>
      </blockquote>
      <br>
      Can't we just use the page size from the RAMBlock in
      qemu_ram_remap? There we lookup the RAMBlock, and all pages in a
      RAMBlock have the same size.
      <br>
    </blockquote>
    <p><font face="monospace"><br>
        Yes, we could use the page size from the RAMBlock in
        qemu_ram_remap() that is called when the VM is resetting. I
        think that knowing the information about the size of poisoned
        chunk of memory when the poison is created is useful to give a
        trace of what is going on, before seeing maybe other pages being
        reported as poisoned. That's the 4th patch goal to give an
        information as soon as we get it.<br>
        It also helps to filter the new errors reported and only create
        an entry in the <span style="white-space: pre-wrap">hwpoison_page_list for new large pages.
</span><br>
        Now we could delay the page size retrieval until we are
        resetting and present the information (post mortem). I do think
        that having the information earlier is better in this case.</font><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:a0fda9e7-d55b-455b-aeaa-27162b6cdc65@redhat.com">
      <br>
      I'll note that qemu_ram_remap() is rather stupid and optimized
      only for private memory (not shmem etc).
      <br>
      <br>
      mmap(MAP_FIXED|MAP_SHARED, fd) will give you the same poisoned
      page from the pagecache; you'd have to punch a hole instead.
      <br>
      <br>
      It might be better to use ram_block_discard_range() in the long
      run. Memory preallocation + page pinning is tricky, but we could
      simply bail out in these cases (preallocation failing, ram discard
      being disabled).
      <br>
    </blockquote>
    <p><font face="monospace"><br>
        I see that ram_block_discard_range() adds more control before
        discarding the RAM region and can also call madvise() in
        addition to the fallocate punch hole for standard sized memory
        pages. Now as the range is supposed to be recreated, I'm not
        convinced that these madvise calls are necessary.<br>
      </font></p>
    <p><font face="monospace">But we can also notice that this function
        will report the following warning in all cases of not shared
        file backends:<br>
        &quot;ram_block_discard_range: Discarding RAM in private file
        mappings is possibly dangerous, because it will modify the
        underlying file and will affect other users of the file&quot;<br>
        Which means that hugetlbfs configurations do see this new
        cryptic warning message on reboot if it is impacted by a memory
        poisoning.<br>
        So I would prefer to leave the fallocate call in the
        qemu_ram_remap() function. Or would you prefer to enhance </font><font face="monospace">ram_block_discard_range()</font><font face="monospace"> code to avoid the message in a reset situation
        (when called from </font><font face="monospace">qemu_ram_remap)</font><font face="monospace"> ?<br>
        <br>
        <br>
      </font></p>
    <blockquote type="cite" cite="mid:a0fda9e7-d55b-455b-aeaa-27162b6cdc65@redhat.com">
      <br>
      qemu_ram_remap() might be problematic with page pinning (vfio) as
      is in any way :(
      <br>
    </blockquote>
    <p><font face="monospace">I agree. If qemu_ram_remap() fails, Qemu
        is ended either abort() or exit(1). Do you say that memory
        pinning could be detected by ram_block_discard_range() or maybe
        mmap call for the impacted region and make one of them fail ?
        This would be an additional reason to call </font><font face="monospace">ram_block_discard_range() from </font><font face="monospace">qemu_ram_remap().&nbsp;&nbsp; Is it what you are
        suggesting ?<br>
      </font></p>
  </body>
</html>

--------------hgY5tBYnC80xFaueadyA07yr--

