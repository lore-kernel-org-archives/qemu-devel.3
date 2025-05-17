Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38243C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 13:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGI18-0007zd-QW; Sat, 17 May 2025 09:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uGI17-0007zV-Mt
 for qemu-devel@nongnu.org; Sat, 17 May 2025 09:55:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uGI15-0007cv-I7
 for qemu-devel@nongnu.org; Sat, 17 May 2025 09:55:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54H3Y2HG021109;
 Sat, 17 May 2025 13:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=LS8DufqtGlBguiIPPiXy61qmFkFtUI+3A5DRG94O2XY=; b=
 ELwEEPa/1dt+V9oDR+fHPgpk/bZV3BfzvxBA6ehlLBHFB907d+UFS1I5/N5fHA+2
 P1mtviGvBdn28127QxpA9vMF9Oy1hV+r5EaSRGErKQhnHqG/QBxR1711V6uSXSYn
 HzhDWqJmrNNwDiIVqT+ZuFHTG8CkblxypVdKhJ3IToSkCyxJVpAqmluiqBAoQMnH
 VDTkAG3zKLc/D2LCO/IVLXZqIiSXhU/oPVwOovTIeGouISJ1/seeAccLiVgHgtNV
 eCkzj93yiBl3My3MXYW0ovectmHAprLXVoN8JeQRVJS22NKKq2Qy7x317UeuGVKU
 ekmWPwVT49gKJxqKb1RxcQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46phcdrcty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 17 May 2025 13:55:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54HCVSY2010741; Sat, 17 May 2025 13:55:50 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012039.outbound.protection.outlook.com [40.93.1.39])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw5a3c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 17 May 2025 13:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUrkvNqXnIV4v1LNA2f4pYf2my3VPaeH7hybvJ6bAhK3cKB5uc2L6PrG2IpHNZl7X9atqajbMYJY6e6JQOoF8pJDUP+TrVJMvI1w/jCNU6S/wSobxzuNWwgtsUp9DythNGH7vp7dD0xeQgq+4RSlcqJ2CnblSIjGCHVXNCuqiTKtk13MwTUwfstOmyzI7XA/pzlQfOBRikh5A2bYparvnK5vv6JTAuI0LlVHzqzjcQEeRylzDy42fxVDVa8Prws1sLF78pX03rRuJ7Umx4Q/davwBsuneSI+IA/BxTVO1dN0+URNQIjcQidrxz6ZHXzmSKSr29JTd5yODeIPhNVKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS8DufqtGlBguiIPPiXy61qmFkFtUI+3A5DRG94O2XY=;
 b=NjQRpowgTAFDwX9cDWxtQy+1f0XuoABkiAjZv939dLy3lg5HqTuqvLjZMnuvbAoAYCl27ayh4mH3h7ecHDVC54kCreal8xiPXq89lifsw5D9p2PCAure7lerzAP2nO9+shaZbhniJk0i2A1+ioR+96Y6qi41moEOF0U4/0gPCn3vE1i03q0cFCmgI/WsLCItQT3H0STCSfluE+admHxM9Axth3DLI/w5C7GfMD/JZTZGiituPqkVQZM/CLsuKjFi/OGXYunCRQJQDqfxIqPw8NN0HJZaE0zPaAIvQRk2+cM7U8TjX8rMNeBJ7DfGxsZe3IZ3hmkoFwej5j6aYUbMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS8DufqtGlBguiIPPiXy61qmFkFtUI+3A5DRG94O2XY=;
 b=aDptXyVL9EIa2CWaVkRVYfhQ3ntVivZOuEafI+POzOMkWbWkqVuc3CBc30uv8vXpJV0jLZ2B+Mwufe4Nlb4yKtaMDMt3OKkuG4HXkyq8WUFiRsCcFl2uL09BwXVy2R5Njx7eBtLop2T32sZ6RVNfu/SUcRjUhFZzql5AhRdWGwI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Sat, 17 May
 2025 13:55:47 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 13:55:45 +0000
Message-ID: <5a2a1347-5a98-49fb-8416-4f8d43250491@oracle.com>
Date: Sat, 17 May 2025 09:55:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] vfio: return mr from vfio_get_xlat_addr
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747415599-131553-1-git-send-email-steven.sistare@oracle.com>
 <e6b1e5ee-f8d3-40b5-a608-67469a8b599b@redhat.com>
 <717acf0a-bdeb-45ed-bd44-7c054247836e@oracle.com>
 <31cf87f6-94a4-4801-bbe9-882043cd88f2@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <31cf87f6-94a4-4801-bbe9-882043cd88f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d829442-7226-44ab-0cec-08dd954a8571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0kyY0RQTlhGWmhUMWp2aDZVdGVoVFBuLzZuUFhHWnVFdGdUajQxL2xVQys4?=
 =?utf-8?B?MklMUFJkZ1hlZWdxS3k2Tkx6dFJiVkIwa3Q1RnJYaGlTZjEzQWs3aDdWSXNt?=
 =?utf-8?B?dzYwMDVueW1NaHEzUDhwcm1PajhlekdUQzFJRW5kRktCZUQwOUxmSjRaQ2Nw?=
 =?utf-8?B?Snp3dXBEL25MQzZWSHk2cTNIWnplTHNVbHVzWUtTZzlnamIvYldkUXZKTy9K?=
 =?utf-8?B?MmdsNWlLZUphUnA2dkczell0VnpHazRqM24zTzNSU1VZTlNuRUNIVnVVZXBE?=
 =?utf-8?B?M0pSNmFlZkM0c2NoWnhJMU1RU3BWcU82d0Q5ZWJSTmRrR1RtZnhMUGZ3Y3lJ?=
 =?utf-8?B?bUdNYTdyd1M0KzdNeFp4NmFEazVvL3hWU2FXQmRaZUxOaXdFTk5sRUlubFh6?=
 =?utf-8?B?KzhhTzBZbXFqV05yT3prdEl3Sk1Kb1pCS0g5R2s3THYyZ3R3RTBxT3RtMHgw?=
 =?utf-8?B?SWpSZURpNDQrdUcwWW5td0Q0dnZ5OVRMOGthSTJxaHVtOGNNN2puNjlOeUVh?=
 =?utf-8?B?dGgvVjMxeTB6MER2bkprMmUzekNkcmp1aHE5WGtrV1JiUXQ3OTFIUDhxU3dq?=
 =?utf-8?B?MU5obHNGZXNQTUd3Z1dIc2puSGt4bUg4TDg1SzZaWmtMTTlQSUxtcXUxVmRW?=
 =?utf-8?B?T0RFZ2toSU5zczNHMGNPTWFRazNEcmduK1g1SUxucW8rOEVLUHh5UnEyZU1V?=
 =?utf-8?B?N1pmL1VTOGtSaDVaRUVGNExwYmZEV2JydDR1eGJGSlRIbDJSQjFVbjhMa0p4?=
 =?utf-8?B?a2JQUDVnbVIrNFJLdlJMUGc1QWJXQ0FWdU13Vkw1K1g4U2hCYkd2OXhGdHAv?=
 =?utf-8?B?aktBaHJFaTFvR1VaTUlDWVVtYkhpTXdUSGgyemd4Y2tiTlc1R0M2b0lqNmkx?=
 =?utf-8?B?TUVhVGNEd3Q0VUNIRE81ZjhNOUJMbnBaaGxtcGZlWVhFemN3cHBmSUYwcXhD?=
 =?utf-8?B?ZXprYUlHL2o2c3JGWCtOZ01RTk5HRGQ2R0hYVVZ3clRUS2NrOVJocWl2emVN?=
 =?utf-8?B?NWM5NWJlUFZEbmlZUjdlcnlqd1hMcGF0SkFLWkMwcUhDMC9GRHBuOHN6R3NB?=
 =?utf-8?B?RUgzcnRmWjZKRUNLT3FhMlJSdEpzSmpNK2IzVzdDZTRORjZJNnArVTcxZklK?=
 =?utf-8?B?bzcrK1BIaDJ0T1hjOGtWMEpIeHFmRGtwOHgwNjFrc1htZnZOd2h3ekhjOUtw?=
 =?utf-8?B?bkRtVE93RXNnVm1YY3ZydHhzUlRtdVhDM2hBSEJtS3FMd1VWaEl4QnNuNGsz?=
 =?utf-8?B?NUZGV0ZnZWpVY3I0bTBrbEEzdERQbHdkUlFBVHYzcUNlKzlkTVE4Q0xTZE13?=
 =?utf-8?B?U2JxQXNwTmtZL3NjYVZFblFadzc1V2QvaU45azFuMmZ3NW9WU0FJaWJhbkov?=
 =?utf-8?B?blBJMjFqM0dJWW9DTytUd01tYy9vZ0JscDhDM2djY3Noem9lcmxZRWZDOWtV?=
 =?utf-8?B?ZUlrUU5kMjAvOGpKeDBqMUwwcmkrbnYwNk82Z0JBSmh4UDM5L2tPZXJZVkFl?=
 =?utf-8?B?cWdGU08wVGpiWm1kYnBFVzRtc1pibG84ZytydDJiTG5WYlBWeDByTFZNMjdE?=
 =?utf-8?B?UC9QVGtoaVlrSW0rRC9GRlhCbmtZY2FMV1gvS1p5OUVSSjk0TGExTGVheTVW?=
 =?utf-8?B?TzlDQTJSOHFtK2NGU0ZMaFlkajBLeHlWNjVrbnpsMGh5eXdiWU5zRlZXZTVw?=
 =?utf-8?B?VVAxcFd4TUlwOXVyeFdpSHdDMmxma2VHMkRqdEtvTVUvNUxBTzNwMzRlTStv?=
 =?utf-8?B?aGVRTFp6Z1dsNVJxTFM4Q3MxYWVsaEcxZnBNU3loMWg2L3YwSXN3aTFCQmcz?=
 =?utf-8?B?c1ZSeC9OQng1dHpyL3prcU41ekF6cWJXZUxGcXBZYnd6VlJTeFB1UDNqNGh6?=
 =?utf-8?B?c3VPTWV1RjE4YVQwa2wzNTFBYTNST25HS2FSdkUzcTJQdFZRZ25STUpiSytK?=
 =?utf-8?Q?ikjIb9/hIZ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9qZTVad2hvbENqZzJGdi81bEQ2YTRUQWVvd2hNbmVEcG1vQUY1K2NUd1RK?=
 =?utf-8?B?Tk9iVzJpUmNSdG1scnJYL1N4Sm5GbGZJc0trRjZVU0ltaUdrQ000ZFB3VHJ6?=
 =?utf-8?B?NWJNbXdXRFpOdXdPT2VuU0RDeG96Q2JZZlM2b1dMNjJlUDE2RkJCSlIvOHVk?=
 =?utf-8?B?alJlR05EY1lIL21ROVFlaHJuQjRpVlJnWjkyZWlVSnNCaTJYQUlhcm5heit1?=
 =?utf-8?B?SjVGRmlpUE5IcGV5UFNFYjR3OW8rNWVUZDNtUmhnREpObWZqaUozeDBwZDZN?=
 =?utf-8?B?UlNRUGdBNy9jVCtUQnkxU1lkbGZLSG9OYi85Z3E1SmF5eTZEenhtYlBod0VO?=
 =?utf-8?B?NXhwZ3pHRUdYWEg4eGsrTUN5aWVUcU50UU1lT0s2ZjJvY2hSRGcrbGNlTkJx?=
 =?utf-8?B?dkJDSnpJcGhRVkttekk1Yk1Yb0wzbk8rVlJINVJBelhTcFNoMisvWXhOV2lj?=
 =?utf-8?B?VVlUcUJqTzB0TW5HNWljR0VLTlNCd2FyUGVRTGg5U1lZVUEvbU94NHBYRWRv?=
 =?utf-8?B?OXNOQlcwV2VFTUk1OWZkaWJJczV5WWtUWkJMakpGdTFhVTY4Rm0xWnM2VStJ?=
 =?utf-8?B?djlRd25rUDg0OVhPaThheGw3cys1T1dsWExFdzRJUzBHYkxMYWg4Z3orRncy?=
 =?utf-8?B?bE8vTVlkankzTHBVQ1M2TVk1NzNrdWt4Rit4QWpyV08wRGVoRzlxRFZndjRz?=
 =?utf-8?B?UCszNnY5YjBUMGg5V2YySXF4SlV2KzFIcDRDL0lMM1c0cGd0c1krZzdHVTlW?=
 =?utf-8?B?czd2bnpKdnR1VmhTTDRjZHlnSTJQMHFrT2dBZWRiT3htekxwb0pRb0g1VHdW?=
 =?utf-8?B?eE5tbE9KVThERXd6UEZlc0s4aGRxTnQ2RWxpVGw5NnoyYnUvVUJSbGxmOS9v?=
 =?utf-8?B?N2YzZ3NBY1V3M1V2eFpaSE0yS2tGU3dEQ2JzT1hiY04rUTJFbDhPR2dudEtF?=
 =?utf-8?B?bXpnSEl6TzFJWkVIUGVvNTJQVUlPYU9mU0NOeTRmeFJMSGxHK0lUbVppMlhJ?=
 =?utf-8?B?NHNoRi9CWS82MytGSlEzTS84RG9YN2haKzRVT2Q5S29OSlEwRTFVbU93Z2pn?=
 =?utf-8?B?ZDdzbzFhcFFNSHN1Wlhjb1RaOW5nd3FJbG9mQ09KU0w1eUludVlVQzlJRjlx?=
 =?utf-8?B?aDMwcFJmdXJFemttd3I0OXBIVFZFQ3YrN3YzT2NrT1JOVVlKZ3ZEQTJJc0E1?=
 =?utf-8?B?ckJsdk16RXpYekxSeWpDTG5aRml2QnRtWVh3a0g5clVTQWxPY2lrTTBPTXdP?=
 =?utf-8?B?YkpmZ3JuS2JKRm1zTlVsLzVCN0pVSjNFVForOVJ5eXQ1V25XZWNGNEpycGRE?=
 =?utf-8?B?b3lyN0hSem9TQmdnVEw2bURES3BrZ1AwY0RLSHdzVlV1Tk1iWEV4TXcvTll5?=
 =?utf-8?B?U0RuTjdvbmd5M3VoN2tyd0VCZVZQNE5rVnd3ZlFlMHRXcUxsSHRIS2xIdFFE?=
 =?utf-8?B?RlJmdFlhNWJRc2U2ekxqSnFmYmtNR3pqc2FKU1RsY2tTaXN4RDR4TWtVU1hu?=
 =?utf-8?B?aUpEYm5nSzBQZllha1JsSnd6NThEaWczLzdia3NxOFk4bU9FOVBHMkVJTUpQ?=
 =?utf-8?B?SC9sSDNmbXFlTk9zZkpUSDdMQlUzM2k4UlM1cXU2azFhenFKdGMyRTNkQmFW?=
 =?utf-8?B?dTVuUTJzTnp0RDV3bW44TTZYQ01JZERLU1lkNDRNQktSVy82ZG1pT29jZTFF?=
 =?utf-8?B?VCtLSHVQdTI4a1dCK3FVMitseC9TNENhSkhYaGlONTlKditJcTFybW5zcU9h?=
 =?utf-8?B?RFVRU3JYK0ltUzJhT0ttSnRGRm81VlV2QUU0ekxRQ2FDenRheFllYksvSVU1?=
 =?utf-8?B?Q2tmQ2dQZTFOWER1UFI5Z0kwUW91T1c5YkJ0QjlJN0NQbEFGU2tLaTljdG56?=
 =?utf-8?B?clMxOUhNM0VaQU92VlZoZ0Y2UCtSa3lnbmxkK1J1MVBPZWJoV1NyK3dUYm1F?=
 =?utf-8?B?WEFWZm81WFJsQTZPRDFoc0RhaG9OMHVybmViSVh4c3Nza2pONWFPV0dwL3Rw?=
 =?utf-8?B?eXpnS3h6VFA5dzVPSXpkNjBGZ1ZtbU1VM3FncWVjSnVpaVVQUTZpdHlDVlk1?=
 =?utf-8?B?ejhEcC9XMjZkWlowNWk2SHBEcFRJaVVvV1NXWWxhRVJEaTRSOEVzbHFpK2lW?=
 =?utf-8?B?VGlGaGFtTXdSYXBvOG5kN3ErR3JMWTlOWGtPdGJDaU9CelJwSEFMalZCSVNp?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RKJYGnhlC6MlBV5Mm/cEkAxy8eHx96sSMrfBzgioNA5prcA+4rPqwrrWfW+JvXI7I+WJi9Xrivk6DU6W6G6uGpomIT4WDPS6E0VcX8XpXsopGpVTsRbaDm32eHQQTDssUqoMYufwL8/Bdk3BjZx2rXiTFDs5E4pEcI/3nJ5JZJKieB81itwAGESrlAIKwZSGnxqSQiMYcMQBr9c7s45mr0YAzTffFONSzL2Q4ABykBI1bKATnFp4h1LXeUON0HM0M5hx3aZNwRT2yEJ7qmOiC1/QneI3/K/Nk1fI8U5aqnQrA65iMaK6ZFi0nb6DsDH7MbYY6A3DtuIFflT0d2PnAP0qkTRstuq/eSsiIvEyCZVT51EJttEmP1onTWXd/JiDiS7tbbTdRVGFCV8ee6Etp7+QP98xrk+43vnFWh0Eg5d+GrdHtUh9AMR4z/57KhQOWiMG1FbVeZ759cO3gyZ2tEqqpXdb48UxuR2FmtfHzBJGPWevTdjnb0CUW122oGnEUpKmQ+/qn3QTnh0r93SOCvjAC5RdOx8paCM6qgzu8XcVJLQG0MAHCOob/hwI0u+fgCrn30R8kSYldTQXaHG3I1oM8BcvrX38qi1OVT03DPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d829442-7226-44ab-0cec-08dd954a8571
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 13:55:45.7362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsUfKxiesIOQPDSQT/p2ee5tLC49u0lG0PpniXcSppSfu+fnPA4VvStJlmC4IgXoT5AfmUdrHPasfJqIzgMn2+5HqM1B+5sqTmVjE3TKtCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-17_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505170136
X-Authority-Analysis: v=2.4 cv=a6gw9VSF c=1 sm=1 tr=0 ts=68289567 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=LNm_CG2neVRKAgsGVWkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14694
X-Proofpoint-GUID: e0ZGxno-DcidDAsTUz5s5wbCI8TxZ4qT
X-Proofpoint-ORIG-GUID: e0ZGxno-DcidDAsTUz5s5wbCI8TxZ4qT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE3MDEzNiBTYWx0ZWRfXyGwI97C34Vue
 Lmu7OPNxMDacdBFd/a++UWxHdo3B171NWXiKDY0U/bxrIn6Jh7VM6YnDUs7CyLLS6iap6S7vE1Z
 WPikLUu0FU1erMZcS8bmL70Tq9BE+M409qNOL0s5ckYUO1rKQue6rxMwiFKMzKm3wfRqI0vxCZ4
 yn88LlBPPf+vjHP6IprJEX1hjS7vriSlm/xdWvEwl5JKBY+tDT7mrPpBRfjWYsUJXTsvsGOdhEy
 F6FDHYCRUqt/34K574rq4O/IIcYalUC9FfC6GBS/q1Mfk9/fDPt2lU67CeP4kL2IBOidWAvPTZ+
 d2UWj10elB8YvFJKkj7SKxUM6033N2qyjQzBE5Fo+obXu1gs8okNV0cVp8Ji1UWnUjF2HwdARBM
 vDiLgdHbOpCprsFAfFp7D1D2zPacxy0j2a3BtRhQKEhYvvyVx6Aa75JZ/neGHsjTgK/7oVFT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 5/16/2025 4:50 PM, David Hildenbrand wrote:
> On 16.05.25 21:26, Steven Sistare wrote:
>> On 5/16/2025 2:58 PM, David Hildenbrand wrote:
>>> On 16.05.25 19:13, Steve Sistare wrote:
>>>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>>>> region that the translated address is found in.  This will be needed by
>>>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>>>
>>>> Also return the xlat offset, so we can simplify the interface by removing
>>>> the out parameters that can be trivially derived from mr and xlat.
>>>>
>>>> Lastly, rename the functions to  to memory_translate_iotlb() and
>>>> vfio_translate_iotlb().
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>>>>    hw/virtio/vhost-vdpa.c  |  9 +++++++--
>>>>    include/system/memory.h | 19 +++++++++----------
>>>>    system/memory.c         | 32 +++++++-------------------------
>>>>    4 files changed, 45 insertions(+), 48 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>>> index bfacb3d..a4931f1 100644
>>>> --- a/hw/vfio/listener.c
>>>> +++ b/hw/vfio/listener.c
>>>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>>>               section->offset_within_address_space & (1ULL << 63);
>>>>    }
>>>> -/* Called with rcu_read_lock held.  */
>>>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>>> -                               ram_addr_t *ram_addr, bool *read_only,
>>>> -                               Error **errp)
>>>> +/*
>>>> + * Called with rcu_read_lock held.
>>>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>>>> + */
>>>> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>>>> +                                          Error **errp)
>>>>    {
>>>> -    bool ret, mr_has_discard_manager;
>>>> +    MemoryRegion *mr;
>>>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>>>> -                               &mr_has_discard_manager, errp);
>>>> -    if (ret && mr_has_discard_manager) {
>>>> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
>>>> +    if (!mr && memory_region_has_ram_discard_manager(mr)) {
>>>
>>> Pretty sue this should be if (mr && ...)
>>>
>>> otherwise we'd be dereferencing NULL :)
>>
>> Hmmmm.
>> That is why we cannot return mr as the function return value.
>> There are cases where the function can return error, but the mr is
>> valid.  We want to take the branch in that case.  From the original
>> code:
>>       if (ret && mr_has_discard_manager) {
> 
> It's late in Germany, but didn't we return "ret = true" when we would now return mr != NULL?
> 
> I mean, there is no reason to warn about mr_has_discard_manager if ... there is nothing to translate to?

The issue is that mr_has_discard_manager has been replaced by
memory_region_has_ram_discard_manager(mr), hence mr must be returned to
evaluate memory_region_has_ram_discard_manager(), hence we cannot return
mr == NULL as the error indication.

- Steve


