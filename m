Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767DC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Uiv-0001yU-7G; Mon, 07 Sep 2026 04:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1x3Uiu-0001yH-8D; Mon, 07 Sep 2026 04:29:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1x3Uis-0008Hf-0g; Mon, 07 Sep 2026 04:29:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686NS7Zj155496; Mon, 7 Sep 2026 08:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=GoWkOocCrR6kERzkLPXbFWN+S4QZEoZqyUBx6EmTCoI=; b=
 apysbmjR+oDlPsoumQ87OWxVFD9e3i6EtfcH2Na0Eb7P0+fEF/5LMdkxMllLcwSI
 68B0kbNdsyzbr21Wo5s61B9ZuV/dfGeuD7uTjAOFPgLAIg4eDly0IPRGAP6R0Svv
 DvtK6JLnZ/VXyHDb75uNqZPgQCCvIDjufVBNdDC/v6MNQppLm0qa4SPnvtGDeIUG
 6Pd1A8kJEegpnQUEyXv/MlR2KqHrw2T2JCaIM14rzQ3bHx1yp1paLr5wy7SgtN28
 PBNY3gKWJcGJ6+v0MPPFSwlrXazygXXgQQv3T+FeSfz9DNP24mDtVWPyHU9WVZXZ
 3i44lid2Kpv1dvUQByYA1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbhuhmts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Sep 2026 08:28:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 6878PVe6013773; Mon, 7 Sep 2026 08:28:40 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4gh7atk5vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 07 Sep 2026 08:28:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgxkXQVBI9TianvL1S3g0RFDGVuVwXCbURYfz4KDNtdQY0SvgnZASzgQ7HtFnOULZheImkLs3AkXmkwRO2xOrUm4eDXf1s7+j2hwyzKQY4P+7A67iNoTjCxxcyOWLkWSVx2XfyZne43aaEyLmX5nz/plerNL0AtmVgYsKEX9df4Gq75e/H44kwi4x6u1f7Wx+6HDPoumLHKZV+EbBa7psHGGrvnLq2GBH24vNLjN5BvVYI1nHywxxMcyZiLYEkqRr777gmpr2jyxp+Xh8vjnzFWnrGdRrnz/KJJlJaIBSaKdpYcinrKy5Mh3hs9zkfnuG13EbrWDgJc7Hb/IkHgJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoWkOocCrR6kERzkLPXbFWN+S4QZEoZqyUBx6EmTCoI=;
 b=c1NgDiffIEKt2B+b4xWJsEwbH3eK7VEPRMJyxU4DN8Nd/AvdwR+uE5OLyvEtghrh7USTP2ADPnVGfvbiNtNCVRLs4kp5YHAPjskvEfds+a7T1weZumznzNXzyy8GbNoGlRGYN1fiS82ABE5RSPzwZiMt4BpA+rr6vXjgca3sMRgXcP+K5ZZiW+9SKM3M1QQ6eW+4C6WtB8nYu2ggujV+7JXPpvAW1tRY5P5x/bJVKP7CqJNHX0nTKVp0cw6D55ySobBwwfDuxtV5UOMey0uAXXm5VzI2Ff/zCKOKmMg9/rZvk1eQlCSu0Nby9fbMOl/QxH4dI2rVbmOqPOml8n7vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoWkOocCrR6kERzkLPXbFWN+S4QZEoZqyUBx6EmTCoI=;
 b=Dm0VC16r2r/cDyGfZhZz+qRxsjlCCd2aCfkEBzkzPEcC5t5XPoOgkk7CyOzrSHSd7AqwQZXr9lTLV1kEvXb7pfq2sESDAGdYjUcw0el+elUhLFbp8Xxlh9U8I+KewNegoy9T/1R0AL17/DPnsCCPNb+I6W+4oZUrqUmsZSriw5I=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:28:36 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 08:28:36 +0000
Message-ID: <d8ac681e-ee3d-4924-badb-4c8f32ea7cf5@oracle.com>
Date: Mon, 7 Sep 2026 01:28:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, mjrosato@linux.ibm.com,
 alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, joe.jin@oracle.com
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <20260903160401-mutt-send-email-mst@kernel.org>
 <20260904130709.6769caee@imammedo>
 <20260904072052-mutt-send-email-mst@kernel.org>
 <20260904140824.177711f8@imammedo>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260904140824.177711f8@imammedo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::13) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ffa852-8bb3-4879-6ae0-08df0cba02fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 20+8T+ZhIErWgQbtZ83DQvsv5PU11k2HXzHYEtt/XvuXf2K9BUoadMGlGAEBxzXNmsBDfhhXFJK7NZHPe5XO8bISURH7ob4KoXllTMpR9xV7dgUJzcVKT+2bhREj08DUavpaPoPU9qmqK10dPkDcJwR4a6IU33CyI1llC0ArrNzoy3FH+BUUqUy6oPI0z8hnYtVWxymKb0ldkQfDE/XI+VByY1qg+lfKWxBeqOj6BGIC/9/XFM0KxxiXnUcFC3WUEYM+SQvJFIBQgUMpZp/paA2YwcZGHAv+foyB9rjSbB6MuNtwP43oOZ17ij1KVeavAUypaPPyboHJp4QeI6aYYE25KNsUy0xLOvOnd3Udlc6rbKMqBlRXq1HXtXqQq4eYEj3AGkYY7JUzVKbUCY8z5woiE8cLOtaLWaJZKE4g6S7BAKVi9atTxP4d762yStc9U0Qu+dpAJwIFkIWx9qshDvBX/0jQBiTAXK+tdqR4N40rROkkkLQGz53yF+c9UHJB0wobBJNDtUJ8ZRz+KHOaBlobJB4f0RsinMav2OUlwMzvX0W+P6HT4o+YY4ZXRf5peKSj9rKgtEwh219R6ZztG3ABLDrlrYpbu5vX6wRylwIdU3+ksrpQZA0s6s+Vg07aO3AIoXJmRcvhvfMwiL8279igUZsWfVc7LPJc0+d9hDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JzYWZ0Z2d3MlZGdnI4eVpDeFcvdG9xck1URklqNXJ4NGpzc3Bielo4VnMy?=
 =?utf-8?B?RUJoVzFSMHVISlZBczZxVy81WGROUmwzUzdzdlhHKzI1c2hHQVNSdTBXWmxo?=
 =?utf-8?B?bzcydDRqVVNlbkpmSW82UFpvaHNrenBTK2p6Ylk1RDNLODc0L2tiaFdqUTZI?=
 =?utf-8?B?ZVh1M3pDUFlRSEdYb3FmYVhUR2t2U1hrcW1WSk5ZYWxnNjNMWGE2UjRla25w?=
 =?utf-8?B?dlNFY21zQWdQM1VkT3RDT3BFdkx2SWxITVEzOWRIMndIK3JQMGV1STRjN3BF?=
 =?utf-8?B?MktWVXZ3U3g1U0U2ZUwyT3B2c3JYNTFFSHVKN1ZHWkpybHpPNzBXVjRtQURM?=
 =?utf-8?B?SnZhbWJlU214U1AvcXkxZ2lCSlNhVEJQdEN4OGRYNFpwbzZGNFBQbVBXc1BT?=
 =?utf-8?B?UEVXY0NTMk55dUlYZUg5MUZENXNjVlZva3ViZ2xLYjZ5bTNmVFVTcEpnNklU?=
 =?utf-8?B?WkV3VkdkWk0yUXFFaVJvanpFbkVrMWxaend6VWlXSEdQa3dEUCsxdFJDQ01C?=
 =?utf-8?B?Nkl6cDgyeExpa3lUZGV5R2grL3FMT0lHNnZsZldRSUFIYUp6dnJ1Q21jc0Yw?=
 =?utf-8?B?cVY0TlJWV1dIMWVsdk9QSmVJQTQ1S0FTemNzblNtNlFlNGpLVG1UeFA1alJS?=
 =?utf-8?B?YkxaRk5yVjRQOHhxb2xSUWdyNHJEWUdFRmhtYUZrb0hybGhKcHBIQm05M3l5?=
 =?utf-8?B?SlYyMW5UcFQ4Q2NLakhUdmxZVjF3bU5nUXFmSlFjQUs1ZXYyQnJsOVkrcko1?=
 =?utf-8?B?N0tudnlDVVBCRlcxbCt1V05FSW9yWERZTGxtT0dkZ2wyMUw2VXBuOHFWTDhZ?=
 =?utf-8?B?MHdpSGJnQmtSOWpwd2xVL09iS21XRk84Z3FONkV6SnZ6TG1MK3NMemhzZ2k1?=
 =?utf-8?B?RDAyY3lKdFNqck8xTkdFY3ZrTWQrc1dPdWpBdXRhY3NLem8waFBKbzBhQzVm?=
 =?utf-8?B?UzRsU1VRclJveE9pRUUrZUdwZklVMjBKTDVsMXcyV1VCM1BjOVNSeXU2Q3dP?=
 =?utf-8?B?dW1LdGpYby9keVNzQlhLa2FXdFR4UVNYTmpQei9mV2MxdWxMTkN1Q05uancy?=
 =?utf-8?B?ZzF1Y0NjeFBIU0FTOXBMZmdkRGg5WDVDSDR0MkJOVGxLY1Q0M0N0MHpIYzVO?=
 =?utf-8?B?SEpSRVh1R0F1SjR6emJtaW42aGl5TEVhOEUyS1MzVE9XSWJwWHpYbzJWRHk3?=
 =?utf-8?B?NWJXck5RQ2prSHZNd0NNVTZOcVZtZXdhb1I0QUdaNjkzMHNnMDIvVDR2aFgw?=
 =?utf-8?B?Vi9rZ3d3c1BWNmErREZOQnZXYkJnR2E2M3R1dGhtN1BlZmUwYlpMbUorTTht?=
 =?utf-8?B?M0NJeGpET2tsNEVFazd1RnBSRmozemxRT25adE9ad1NWNmoxZHdoZnhVTXBn?=
 =?utf-8?B?cXNqSkZ0ZnJCbnZWVzc5bExiSmF4UjRUaHNCT3NnRjNOMW4rS3FZQTZYZ1Yz?=
 =?utf-8?B?cEFzckRXV1QzcmpkemFEMHdTMVdhSGJDaHV2cGEzbVo1c3RlVlhUdlhKZ2x3?=
 =?utf-8?B?czdaZ01LbEN2K1dIK09KMVI4UkxNV0dRenJyZXJpKzJSSWRVYncwR2ZqMTRD?=
 =?utf-8?B?WXQ4cklieTRLbUQ5SnM3aUpmMWZ4VWxUTWZlelJ1ZENRMkdTcE9XSmJPaisz?=
 =?utf-8?B?MkdBdEZUMEZKa2NwQmw1MUJ1Z2xqLzRNQlFVa1MzeW8vZFJuTmdOY0lZMXF2?=
 =?utf-8?B?aGRubkk1Sk9FZGdsdlRLazZsdW1mdTF4b25oWlVvNXRrQ1pZSnY4aTB0S3NV?=
 =?utf-8?B?aldXdzg4OFpYeGxQYUFGRnlMQUs5M2ZaL1diL3J3cEt5NzFIL1dLVlFPQ3U0?=
 =?utf-8?B?SG9ycFZHOUVhekZMNHVxWlFjeGF2MHFaeExibFAxVzdoWTBiVll1VkM2bElG?=
 =?utf-8?B?eFlXd1R4b0hmdjVaY0NGdjY4RTJBWUVHNXdJMWhKN3JzcWJDNU16UG9ESWhM?=
 =?utf-8?B?ZGV3ZnBva3hTT1hxOHprc3FENklTaTg4UWs1VGlUZVRqTkJualJqNHB5WURy?=
 =?utf-8?B?SW9UVk5GczQwZEE3RlJEMkRUZXh4dGpqaUFyUG5mZmhVMW5aN2V6aUR3UnZr?=
 =?utf-8?B?eVUvbE5mNk5CQU1YTGxyOUZDZjk4RUtsSjZNdDJhdTg2cDBBL2JOeWszZzVD?=
 =?utf-8?B?S3FzU2FuV1VGb1hPUG9YSHk5ekhlZU5ZdXo2ZjFSOHUyWXp4SXZ3TzFtRUl6?=
 =?utf-8?B?TjNHWE0ydU5zS1JSdUpuY2RxdlBDd2E1cVM1K3FhZGdMWmlMMDd1SlY1bXl3?=
 =?utf-8?B?V0xqcXVMWHFoOFZoZUtDM0tsaU5GbXovay9BOFd2cnJ4YmlTWU4xdGlkcnZk?=
 =?utf-8?B?Y3QwMkc4VEtEUFpTODRDUUF6YkFlcE1sY2dUUTJJSFBBMHF4RmRmZz09?=
X-Exchange-RoutingPolicyChecked: lPgq6YuUeK03QXo35Gq5HDwdJXWAfSq3NxWI0yoNZOiM3sR2j23UZCDcmZO1z4VqZ+qZXI+fZtFqfuJQ0BGRmYt5uNTUZ51qieRIqujdmTcFJzQzf4IIMxyVodR+2At2yGbZ02z/bkOlKO4ep9WyC8Lwl6nrdKaDtMjye+R8OsH9gE7nLDSkrvbm8h74vWqCuqgMcF25XzgaZMaULDoHdVwmkcDMtf9Wgoy96X0e/cescWEiGYE6KNZnhFKFWb4y/KHePOzXoQ9ghVnahI9bcRFl/jpZcpCCS41qnHzRBQRo1zlw/so7CJeQu/HZBfnMxaxq0hAdArwAfqDE9HsQkA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dORxooCUcRh8LExhKuOezGRxw3GorDuN7VhdEwU5Z+9bQaYdn91kkMZtjQiIU4mxy4Do8Q7T0fW36+OpCAsmyNwIQrLR7s2JcZ9ZDIgV1LNIJoo0MQNpEJVxafFS5FbUEfDyttN2RuayDGfPgyTrfA7Cn9mwRODThQ9bc1j1EFGIl1a/b77UF+m9kZSumcXONSTCCchq7sYdxszLCoLScn074f7gz1ilLYoaQVBVZFWJUDNY5pPFMkuxZ8X9bCKv97ESd7P2EpMh/67QiLOcLqp85Vv9nIbocCFMPVgL0hjCHf9XDOs/0w1T0rKGdxaotsJH86uXIqU2Grv/zhKj2q4V0SDSJOZH8djTZ5dy6OgpM1UbYNKpvoa2nDoMWsdOYOyhL7l3bLwA1EeUgX/Z07Mb/sAeoPab3nVUPh4jWXK1jMu4TMCsti+ZyZqTO2dvGVY2y08EyiECOAFjUG6U2cFCm0abgsAYIKrjzcu1xdu6Rh6kFZylPpH1p75P+S7LiLrBQ361irhcVZuF+rquE7HvuBslOjkztfq/yVUU3SkGMQRSfdaG7Uy5JTMd23HwEN4vq3GO3T6XyJ233NmzttkIQJKfEeL8dqQXcoVrrdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ffa852-8bb3-4879-6ae0-08df0cba02fe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:28:36.4361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrVHTw2cLdK18jAJ9BDfdHDwDkxE+b4nltCMUvgPh4WeT3LlEUZZD7N4H0K+R2MPDfRyzxlxfUT/H6KCPeCAzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609070091
X-Proofpoint-GUID: s2gACWvghr1jGpjJpTwv8fA1zrMakTkx
X-Proofpoint-ORIG-GUID: s2gACWvghr1jGpjJpTwv8fA1zrMakTkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5MSBTYWx0ZWRfX2zmlbpi9oHKm
 zakFWOSeFBu1Y2RUjLQqRThWJU/uKCtMA/9vVEtTXomeboMvBv+TawjIyYUVjgomrZY9ERxLwT5
 VYJemWb0Eatengxl2+//r0GgsmVQy5ObLAzaGETZNiAoPQSyc72n1ahHK6sXkbLYDgRTA3ljKLN
 KkQ+OUJ4qtfnDyghmIaBJ4cP3sJSeyxbyAvF5uv1cdr1cMflhizNmuxCMDH0iXgjHr9EDY/I7Gr
 Ev1DhBurO/rewfZ7bBtghWXRnYMUTiIoDGy9RSHA8LzVUBwicPeAG+LkMPZ4wOfLq+0Yv7bDDH8
 r+ViY/nR3rlbCMoMVvU4C89Z0R+64vPK7CAc1svVQhS6vO3pTHGEMp+BzsFPuOV95qKjePViD9q
 dt0Wnzjq5fS6Nxy82vynrDRVwgtzDTi7Xwqpn7s9MxMQFL0mOUjpbl8cvMGXHTZBmFTvnykUvZ8
 QkA3BNe85qrIjENxqg7C1ESpLuDlvYh8N0+w6XNs=
X-Authority-Analysis: v=2.4 cv=S4HpBosP c=1 sm=1 tr=0 ts=6a9e75b9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=ty4yZqpHH24XlNHnSPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5MSBTYWx0ZWRfX4usfcJ1Sx0WX
 hxpc8Jcd1Hwn0LXGmoWfO1HcPPpUunHgVQcODe6rAte2AYr65hbM5kPrCb0RzReOMXnNyyKKLfb
 9SXTOQhX5hSFShhl6uCD+JatGnGjGXfL/zn6Lkw4Ajg6xAFyDkuf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On Fri, Sep 4, 2026 5:08:24AM -0700, Igor Mammedov wrote:
> On Fri, 4 Sep 2026 07:22:10 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Fri, Sep 04, 2026 at 01:07:09PM +0200, Igor Mammedov wrote:
>> > On Thu, 3 Sep 2026 16:17:20 -0400
>> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >   
>> > > On Thu, Sep 03, 2026 at 05:28:35PM +0200, Igor Mammedov wrote:  
>> > > > On Wed, 26 Aug 2026 09:15:47 -0700
>> > > > Dongli Zhang <dongli.zhang@oracle.com> wrote:
>> > > >     
>> > > > > On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrangé wrote:    
>> > > > > > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:      
>> > > > > >> Hot-unplugging a PCI device can require cooperation from the guest. For
>> > > > > >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
>> > > > > >> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
>> > > > > >> QEMU notifies the guest through the PCIe hotplug mechanism and waits for
>> > > > > >> the slot unplug flow to complete. Only after that completion does QEMU
>> > > > > >> unrealize the device and emit DEVICE_DELETED.
>> > > > > >> 
>> > > > > >> This can leave a device stuck in the unplug pending state when the guest
>> > > > > >> does not cooperate. Examples include:
>> > > > > >> 
>> > > > > >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
>> > > > > >> unavailable.
>> > > > > >> 
>> > > > > >> 2. The guest is stalled and cannot handle the hot-unplug event. For
>> > > > > >> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
>> > > > > >> for ACPI-based hot-unplug.
>> > > > > >> 
>> > > > > >> 3. The device was attached to a slot that the guest cannot use. For
>> > > > > >> example, a pcie-root-port only supports slot 0. If a device is added to a
>> > > > > >> non-zero slot below a pcie-root-port, the guest may never discover the
>> > > > > >> device and therefore may never complete the unplug request.    
>> > > > 
>> > > > all of above is actually expected, no (functioning) driver => no hotplug/unplug.
>> > > > it's the guest problem. Once device it exposed to guest its life-cycle
>> > > > not longer owned by QEMU.
>> > > > 

[snip]

>> > > > > > 
>> > > > > > If we actually wanted this to remain a warning, then that shutdown
>> > > > > > crash would need to be fixed.
>> > > > > >       
>> > > > > 
>> > > > > Thank you very much!
>> > > > > 
>> > > > > I see that the issue has been fixed. The ticket mentions the following.
>> > > > > 
>> > > > > "What I am observing is that it seems when the slot ID != 0, the guest OS seems
>> > > > > to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
>> > > > > 
>> > > > > Based on my experience and evaluation, ACPI-based hotplug is more likely to
>> > > > > encounter an issue where the guest VM does not respond to an unplug operation.    
>> > > > 
>> > > > I'm not sure it's a good idea to delete device when guest still thinks it's there
>> > > > (you can make guesses on QEMU side if it's in use, how useful those are is questionable).
>> > > > 
>> > > > as far as I know, ACPI hotplug has no notion of surprise removal (pls educate me if it's not the case),    
>> > > 
>> > > why would it not?
>> > > 
>> > > how do you think you can pull a laptop out of a dock?
>> > > I expect bus check + _STA and config space saying it is gone
>> > > will do exactly that.
>> > > 
>> > > 
>> > > Here's linux code:
>> > > static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>> > > {       
>> > >         struct acpiphp_slot *slot;
>> > > 
>> > >         /* Bail out if the bridge is going away. */
>> > >         if (bridge->is_going_away)
>> > >                 return;
>> > > 
>> > >         if (bridge->pci_dev)
>> > >                 pm_runtime_get_sync(&bridge->pci_dev->dev);
>> > >         
>> > >         list_for_each_entry(slot, &bridge->slots, node) {
>> > >                 struct pci_bus *bus = slot->bus;
>> > >                 struct pci_dev *dev, *tmp;
>> > > 
>> > >                 if (slot_no_hotplug(slot)) {
>> > >                         ; /* do nothing */
>> > >                 } else if (device_status_valid(get_slot_status(slot))) {
>> > >                         /* remove stale devices if any */
>> > >                         list_for_each_entry_safe_reverse(dev, tmp,
>> > >                                                          &bus->devices, bus_list)
>> > >                                 if (PCI_SLOT(dev->devfn) == slot->device)
>> > >                                         trim_stale_devices(dev);
>> > > 
>> > >                         /* configure all functions */
>> > >                         enable_slot(slot, true);
>> > >                 } else {
>> > >                         disable_slot(slot);
>> > >                 }
>> > >         }
>> > > 
>> > >         if (bridge->pci_dev)
>> > >                 pm_runtime_put(&bridge->pci_dev->dev);
>> > > }
>> > > 
>> > > 
>> > > so weirdly it wants bus check on a parent bus, otherwise it will
>> > > not trim devices?  probably a bug, but easy to work around.  
>> > 
>> > Modern docks would use native pcie surprise removal path.
>> > 
>> > As for ACPI, my old laptop, had an unlock button => _LCK
>> > and that relied on OS processing ACPI events, not so surprise.
>> > 
>> > There might have been ACPI/hybrid docks that did surprise removal,
>> > but then one need to find one and model after that instead of 
>> > just blanket force removal. (likely out come would a doc device
>> > support only, not an arbitrary device removal)
>> > 
>> > (not the case described in this series, though. hence my request to clarify usecase)
>> > 
>> > from what I see in spec there is _RMV method that says that device
>> > supports surprise removal that can be used for devices that support it.
>> > However I would hesitate very much to blank apply it to every PCI device.
>> > (it's not even realistic to ask for proving safe tear down across various
>> > drivers and OSes/versions)
>> > 
>> > Rather than a knee jerk treatment of misconfig consequences,
>> > I'd rather see patches to prevent misconfig in the 1st place
>> > (subj to deprecation but doable).
>> > 
>> > As for the cases where OS mis-behaves (apcihp thread starvation,...),
>> > fixing guest to follow hotplug contract is a proper place to do it.
>> > 
>> > On QEMU side we have it covered as well. If unplug was not processed,
>> > mgmt is free to repeat action.  
>> 
>> 
>> Sorry if I am unclear. I just meant that it looks like we
>> can support surprise removal with ACPI just by reporting
>> bus check events on the parent.
> 
> maybe, but that ain't SPECed and might be OS specific.
> 
> The way I've read the cover letter, that won't work for mentioned mis-config cases.
> Also what would happen on bus-check 'cleanup' would be a lottery.
> hence I'm for being safe here.
> 
> It's better to implement native PCIE surprise removal if that's really needed.
> 

Suppose many x86 users use q35 and pcie-root-port. Since commit 17858a169508
("hw/acpi/ich9: Set ACPI PCI hot-plug as default on Q35"), ACPI-based hotplug
has been the default for q35. arm64 still uses native PCIe hotplug.

Therefore, in my opinion, it is more crucial to support ACPI-based hotplug than
native PCIe hotplug. In addition, native PCIe hotplug can still detach a PCI
device even when the device is erroneously attached to slot 1 of a pcie-root-port.

Although surprise removal is not explicitly specified and may be OS-specific, my
understanding is that it involves two steps:

1. Force-detach the PCI device.
2. Use a mechanism to notify the guest VM that the device is no longer present.

Therefore, may I assume that this can address the use cases mentioned in the
cover letter?

Thank you very much!

Dongli Zhang


