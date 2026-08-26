Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DF1C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGId-00078P-3H; Wed, 26 Aug 2026 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzGIX-00077F-R6; Wed, 26 Aug 2026 12:16:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzGIV-0000R6-Hb; Wed, 26 Aug 2026 12:16:21 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QEtr842160199; Wed, 26 Aug 2026 16:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=eUlWXSPmG5Oj35GDHQ8dXvXUpIBp8XGO8wlhNWDuUtQ=; b=
 BtDjGgokf6867I1MUhOJRG+jIMwpY5sQVKVIcvPQ8iAJ1L0xJSPJjERwPtycHdQQ
 bE2yzJumJGAyPWr0MH3DwjxW9H0Yx2FE3pBcvqCMPZcpQbeH+uNr137MbRDgnpO5
 UTaELf2BVdJ1vyhrMzcDMMpf3h1Z5P7tsrbnBfNI/yjAckf73ezAoRYc/udSQi6f
 AlTLYqA6PtzBEM8nXe64T/Y+ZMUH/7m6NS0uJRw/MZ9XVVgub2s1KHJbImdaxSFV
 1etcg7Vfx45Mp+Wit3/u8GQvHEMdx6fk5EZwSalbRNzJCvRmgeBuugHxE8anxET5
 hnRzS6JPy6evayieQmqJcA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73csxcr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 16:15:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67QGAG0p018105; Wed, 26 Aug 2026 16:15:54 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84bsbas1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2026 16:15:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cle9CLSKWY5ML+rAO+MSFehHgL8ePD68pNmMvgMddW+jAjiPYm4xLoY8YagkMwcCTiX3CiyExlTlDGEnjzXkyd11cxHpJW/if6wBB82fF9x5qu5Tef1TXyzhZDxMAUuDXNCG+nQc4xstIs0o/ZTy6p2n6A2Y84yZHy67dqAi9n3UbZy/BM8KPFyWZWYWfJdCugC1fhp/T5FBp6CzDZO+R0cresrP8C/gCqM/oLbLaHwQJHZBPvpCHLoMCtxkzcQrnmnmW3Rm13lsI2rSiUZMBA1e1GVciUVRMTaYyGrQ+6vOqTrcOWfeLIokjBG3s74cK9H+0sCbD8v+lHpODp80Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUlWXSPmG5Oj35GDHQ8dXvXUpIBp8XGO8wlhNWDuUtQ=;
 b=m5lX8TxAe3CjZXG3hZXzwVtcUP8vbrj4k3drJWrLQ81r8AOLUB9XfSdQ6qbuvYbP2UpRLiwgER10J4jfvfAq19DRSFm9B8Yifjm7d9LTz/SY8EkbLykO2LsPUSG6QxTUODabgz9MxZ6kSAF2RgQIWk9SD1zSfIR0CMQL+XNLX+INiSemCdasPKPzySEYlTNChAhyUWHFyHBk5AJQMatTv668moW2ZVVmX8ya8VGkVmlTcleMGIu4KyomRm3PP3uuCD3gnLwi4/T/PRyYCtvP35ybmaio29O261n03GaP9GLM0qwcE3RTWnxfTDUM8ap+o9D1GS+N6p237utT6ZGXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUlWXSPmG5Oj35GDHQ8dXvXUpIBp8XGO8wlhNWDuUtQ=;
 b=0AtQWX/vdUDIbfU1MsguoP3nMa1ls29OVszdO1RbzUwt1MNW06zIpTi6ffmmmqLswSBDWf79C4DirkcWYN+q54Lb/hk06XZZMIYNZsbbuCgUA0JSYedZWWeZ91VEcuhDXShOIRmPF1EII6PYtAiknNhN//IuDYBbfDBfEBMhaiM=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by DS4PR10MB997596.namprd10.prod.outlook.com (2603:10b6:8:31a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 16:15:50 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.005; Wed, 26 Aug 2026
 16:15:50 +0000
Message-ID: <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
Date: Wed, 26 Aug 2026 09:15:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com,
 akrowiak@linux.ibm.com, jjherne@linux.ibm.com, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, joe.jin@oracle.com
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <aoxY4Rxst2qAyn5z@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::23) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|DS4PR10MB997596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdca74e-4c30-4f12-7c7a-08df038d4b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: xkMoaoHhCCBC0C9Y8ZsWcIIxBZYPUfy/Oh3/lBn1WLEVBksuw1364bY+TCXt/JsEEPrciz7FhTv7rCkEm2V8soqc40a7O/ZFiNgoBlk1JDmOT1W3peQYhYU/9cGI7WmJiNVhXhxCjp91hazFOtjg8dy1YiIl86PmQXwmARk7w24jbtamRP3P/8BI7TwzPBpaekQg+9tSpYtbIcGefhZZgS4scP/7BGJRZW+zLHIe7DHDDLFZuK41lXCa5VMULX8vs744ioVkQ0/9dLk8s/LOhx/Q94Wc3WKEgB967Arzxh6pMqSTwtnn0ZdSke18V242cu/iGd07+pAfGdovLv26PnYTGVYsanCTYxoAnfX0kNWHIdh/gifyotlWbD5d9m4SqU2NqIA9ttgiCfI9RXSwl6gNiLpvA78QGD411Ka1GOR/YOrE281UHZ+ela21RTBOHZCZYI0Bigb5zRjq29JghT+iQvgcluvIQzndVblPv6vEHU6bZRe4ZPMesN+j/0kS/q9Fd6JwyTJFuG+CkZ9JTGJjAMVo8pCc6aPhsvhXwbaROvg4CwCmtjyKBCKM7Xtq91M3BDx2ronn8LoY88cQts3TSnUamBbWAo9E3xtoNZv656uVWd/21l7JhkFuUevVPeeLET6ZV2oAmekHuKT5/SYTJIn+LoKRdP2758dqFWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2d5Y1JtbzNrOEkyaHZEZVhxOUxRVStCVGpJYWg4N2NudWN3V3p0K3RiNnY5?=
 =?utf-8?B?WWc5aFVkQVdWdXVXbVRLY0NEaXkveGJJVEVlNk5Id0RnVUtRV1hWbGh3bXh0?=
 =?utf-8?B?Zk9iaUpXeWQvdXJUZU5tL24xNGdWMXUzZ0pmVHlBMDFUZDJMZUc4RzhoT1RD?=
 =?utf-8?B?OXdsSTU0MlMzS2VLVXZyckxMdVZTSm82UGhEenVZWUR4S0NXa2hoZlVRQ0RV?=
 =?utf-8?B?TWhhQnNsWmcxbXRGd3c4RVBnUFpVR0hmZWlGRlpCY1E2MVE2ajFORVh4MWho?=
 =?utf-8?B?SDN2eFEyUVVUL2gyemVJK0RvdUc4MmZoQlB2Z1huYzdlYXdNdSs2aTRhaWJ6?=
 =?utf-8?B?TEc3TkJHU3ZWdi8zbjh6WjBFcm5uUXNtRmpjNjUxcWRNcXhzZ1JEejZHNUdZ?=
 =?utf-8?B?YU1IQUdBSVBXenZPNEljMTJvU2NqbVZsc0NjckQ1bFZXT0IyVy9DOFU2d0hi?=
 =?utf-8?B?a3hHT2E5aWtxTSt1N28wcDRFb3d5S0t6WFl0djhBOFh5UXFkVVRSVXVycnFt?=
 =?utf-8?B?dUYrRmtTbnBvSGRaSTQweGJJKzJEWHhyMlhlY0xyS0pmMVN2UG9KMVlsKzd3?=
 =?utf-8?B?WENwbitTSC9yaWJPVjNBSHhzY2Zyc0Z4eFd2SVBQOFo0OEpONUxudmJlQUZG?=
 =?utf-8?B?VVlJVjdoY2ppUm5OQy95YU1EWGVWd3pjbkNmTER5MGZRY2xBREx3SzcyTDBp?=
 =?utf-8?B?WE96ekhSTmExTjdEdk9FYWVIb1FHeUJVdFVQVFJTZ00yR2dvRUhuNGszd1Er?=
 =?utf-8?B?cExCTzNnZWdiVW1ib3ZuVjA0OU1MYU9SRVJHUHd5ekZ3d1V2UTk0UWVrL2p1?=
 =?utf-8?B?VXh6VXdnSkV1bEJmaXh1djVzZVVrdlM4czlpMnRuUFFaQVRBQ2FLQnMxOFpQ?=
 =?utf-8?B?R09sNDhHVEJ4WGJLb3ZIZ0RqU2JCcm14eGpuTTAwYlljQ0JHMTRtcndEVHNO?=
 =?utf-8?B?SHg3STNNV2QrdnVzdDA5QzBZbmZiaHluY2ZZaytmeHA0cTJwemcrRW9GejlX?=
 =?utf-8?B?YTdwSm1jQ1hjeUdwaVM1cCsrUEdvSG5YNUs0R3F5NS9XbEtuMnEyQnluVHVk?=
 =?utf-8?B?aXNmVVZjdVRYQ2pkZjVEc1ZIQWZKOEt4R1BVVVZNT2trVkgxVlMrKzFWREVS?=
 =?utf-8?B?aUdmRVlzQ3ZNdFYxVkk0NDNWck9vbVZvTW0yS21nVmtDWFJidnp2dmhMbHZO?=
 =?utf-8?B?RUIxY1phQkdBc1dzaGVYL3hnUDBsczlNQUUvR1VTV0t0TGZWck1QTjE4cHFN?=
 =?utf-8?B?Tk0yamlnaUFrNFQ0UzBBeW5JNGFFTjcwVHVnMTV3TXlCU2FmbE1FYWk2RGU0?=
 =?utf-8?B?YzhXODdMMXB0bVM2eTk2aFlJTXVKdjdKRXgrUlQ5RCt5RFlTeGFYNVNxYlBs?=
 =?utf-8?B?OXp0cHZDeFNaQUQwdzFMV3ZFelNzeU1SNVI3cW5MMkM4Qzk0T0xUeGkvRkZQ?=
 =?utf-8?B?WmoyY1drcVhTbHdFM09sVm9jUld6cGdIN095WFR6dGlCOGN3eTROcTJueGw0?=
 =?utf-8?B?VFlqTHNVU0Nvc1NWMmljMjltWGdmMFRiNlp6NWJjalN1R0JRYWNTcHRodGI3?=
 =?utf-8?B?MldCOXpjYjQxQTA5SjFJNHMvTjVnSUNmRHQ4WVVIaXpkemF3aEpmOXFyZjMz?=
 =?utf-8?B?Tmh2bVdOQ0dreURrN3NaS1dFQThTK3Qxemd6OHVSZ3YreWpkSm5ZOGxDYk5o?=
 =?utf-8?B?WjU3dVRrOU0zOGY5QkJHbVVUVHhkamNxdkZteFN5OVoyTmh4RHBFa3hxRk91?=
 =?utf-8?B?clJXK1Zqa3BoSHNZUTZSb2FCblpCbSt0RU81RGdrWGptRFpSUUFIcG14VVpi?=
 =?utf-8?B?ZEtkTmZGQmU2RFpuNlpSaTNRN1lPMENhMWhVUUR1K0UxaTRTM1RjNWUxdXZX?=
 =?utf-8?B?aDhwTjNtVzlrMmVJN0w3TmplempTdTBPdFNMbElwaEV4b0c3MDJmUEYyTmFl?=
 =?utf-8?B?WlBKWVQ5aDJ4S284ZU1tV0VDZEExNGtGa0NIT0JZR25Td1VkeVdESy9hMHB5?=
 =?utf-8?B?d1kxZDlCK0xQbWhNdFdUNEFyZnBrZWFJcW1YeEhsOFFTbFhrTTdzZGlXMTZV?=
 =?utf-8?B?MDM1YnBETnFmeWpBb0RTblF2QkJQT2phQW9OaE8rRXd4TmtFK1VLWnF1Z0Za?=
 =?utf-8?B?WkM4YUpEWmd5WDhjc09aTkpwbWdaOXdpbENkSkhZSy8xZWthVkI3WnR0MTAy?=
 =?utf-8?B?bUJsZ2xZVmlobytpaW12WUdtaXFDK2Z5L3ZTUjdUa25TQ0xiM2RrM1FNUlZi?=
 =?utf-8?B?OFlURHBZWkxwblZFY0Q1cnNTTkhHTERjUEIxWENvdWdFWXExa0dNRDRsWENy?=
 =?utf-8?B?Tm14c003THlTWCtYcUpBRTFnY29YVmFiTE0wZGFHQTdqdGRqTkI4dz09?=
X-Exchange-RoutingPolicyChecked: nPPvl2TLjsJb81E5M+fPcqscphimuHbBWGbES/hvGzZ1ljUNZA7mkOEObqESPxxeNTYWeF9XAzQJIcYoQEzmO6sPpoabLbdKfAK2YuZE65mWMkwUpkhe+Hl+ObkXX8bc7L2kFaF49K49EVpvamsvBNYbOJfT3oemXWLxQ5M34/o57ghpERLJkUzh2MLPK+oEsPO5QjXbgpHRTHTWUjCQmHvzo5XFkNrWZ0ngd4ALBxVsk5aF8zJ3p1enG11r5Eu5zvA5aAkcrw2IQvAvV2SoUSYPRGGHxmw9DpWQE+/92xOhSXIG+u1Hc41/SocE9JIA8lTLV9xsLKFijTS1ZypIlw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WZGJ3XZP2HtT9XiWiHCLMkhaqwvGXO/IRretTw66IuERUQd0ZLpdtEbzHgzV5jnOP4Swz8LlgnLmcn3sDlPJ9OejG0bj9Spsl6F/TehxiB9qIv4S5Dd6Bi+PJcf850MYcfIYoOesmQEwmzlJK0UxcygQ7af0+Ouyuclq4W5JUdKiLPHQ1PAvixEei9t2GukyGiZKzo8NVqU5uFEU4IPrC8mQts1xX0rcasvaG42ROrhNS0IJgzeBFx0ZpuP8Nsfz4xthNunXhRQWvY8MML2nLRjldxbR6Fc+KwaW21jD6nloi1ZEYWmQu05NOmgHI/PSOW0+a4v1A6KultTxL39JOog3icK08mZEsn1t2IfcBEuwNWntNG6aAw9oHSorTqz/ymyBlT76rQzXXE+6EuB4drW9nxZ3H1kd2eMWUZ0BnEo7ILJ4jIBI5+gUEtP2Le2lU0nOTpgg3se1D0HYAlwVLK/bvY6NYl6Ue9wA9UyBQhUBrtQwbwi5J0oF4VOHqMX8rZxI+kChko4K+JQvxADzE3rfMHQ67ihyYK0gYxtigcfFdzlkb+II1dEvmXA4IeJfIU/I4lHX7bG2GcZqpHE7KvxVK8/v4UPv8nciTH7DwbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdca74e-4c30-4f12-7c7a-08df038d4b5b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 16:15:50.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJ1CcUO2ZwseAwzuVNSdL0VHzniH7iCey94xIL4TsZXSe/VvHhXzXfrWbKqLpb0bbHOlXIYew3y9Zu12eSFQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608260135
X-Authority-Analysis: v=2.4 cv=D+h37PRj c=1 sm=1 tr=0 ts=6a8f113c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=p0WdMEafAAAA:8
 a=20KFwNOVAAAA:8 a=qYsLzjvYBfPyXXnyIu4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzNSBTYWx0ZWRfX5dCmTLm/Be4P
 OPr6WfIVh7vXU7Ap9h2RE6A4iTzMxzmi4pzZtnw8SFkqWsjVzN+QjODZZ49UlIgnAyYBKKr4EU2
 8i+eGC/uetvMUHH6WTxoM52MdPNTVzdRSMy20D95jFrVdTU3w7S7
X-Proofpoint-ORIG-GUID: aNDFm8w0a05hj3U6IyaBU7ioYmWHrVxq
X-Proofpoint-GUID: aNDFm8w0a05hj3U6IyaBU7ioYmWHrVxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzNSBTYWx0ZWRfXycupZ1cz3UD5
 GW1Mfwwz99AFVbke+3L4oz+dzvc/kL//LXIz+yzscFABiUAeZKL0dSF0MN5y2j7Wa4H78CcUocy
 7OFRAgXJZYshluFcpfa5GeZWVwgrCf9Ex0WNcocL7qAQPUZsSp2kW8hN81jNb+14ZZWmWkK7eSX
 BzzpqFC04kashfjn1E9ys6J/mHLBuum3beMBNdaBeX9I1GatysvPQfQhtILEeh629ECKP2XNVs6
 YPQuU3yjXvGCOZx4uzIkQDARqO5XY9DlOQ+FbsE9uTi8jZcFp6qrFtCowbXEbAMMDu2owiBfMNB
 kK6vUXi+LEzTu+AFdh6mCDnB+IgDXfJabDnB4qKb0CcC7lP1upa2rEdnUizqML04xC2cDDm5WMj
 +yRnaY7wG3QUetT1QJQURwHqN/OVzF/qTb+FH5geDDHH4e1HdtxL2QwiLpLc9Yv/KoYETKRTu1i
 kgmcdSuWkLwRXg4idog==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrangé wrote:
> On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:
>> Hot-unplugging a PCI device can require cooperation from the guest. For
>> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
>> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
>> QEMU notifies the guest through the PCIe hotplug mechanism and waits for
>> the slot unplug flow to complete. Only after that completion does QEMU
>> unrealize the device and emit DEVICE_DELETED.
>> 
>> This can leave a device stuck in the unplug pending state when the guest
>> does not cooperate. Examples include:
>> 
>> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
>> unavailable.
>> 
>> 2. The guest is stalled and cannot handle the hot-unplug event. For
>> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
>> for ACPI-based hot-unplug.
>> 
>> 3. The device was attached to a slot that the guest cannot use. For
>> example, a pcie-root-port only supports slot 0. If a device is added to a
>> non-zero slot below a pcie-root-port, the guest may never discover the
>> device and therefore may never complete the unplug request.
>> 
>> The non-zero slot case has also been discussed in:
>> 
>> hw/pci: warn when PCIe device is plugged into non-zero slot of downstream port
>> https://gitlab.com/qemu-project/qemu/-/commit/
> ca92eb5defcf9d1c2106341744a73a03cf26e824
>> 
>> hw/pci: add comment to explain checking for available function 0 in pci hotplug
>> https://gitlab.com/qemu-project/qemu/-/
> commit/67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5
>> 
>> pci: don't skip function 0 occupancy verification for devfn auto assign
>> https://gitlab.com/qemu-project/qemu/-/commit/
> e228d62b4af29bca698ec57efdceb46f392f5444
>> 
>> For example, if root-port.1 is a pcie-root-port, the following command adds
>> a vhost-scsi-pci device to an invalid slot:
>> 
>> (qemu) device_add vhost-scsi-pci,id=scsi01,wwpn=naa.5001405324af0985,bus=root-port.1,addr=01.0
>> warning: PCI: slot 1 is not valid for vhost-scsi-pci, parent device only allows plugging into slot 0.
> 
> This rather looks like it should be a fatal error, not a mere warning.
> 
> If I follow the commit ca92eb5def it links to https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> which states that this configuration is going to lead to a crash in
> QEMU on guest OS shutdown. IMHO that crash is sufficient to justify
> making this a fatal error.
> 
> If we actually wanted this to remain a warning, then that shutdown
> crash would need to be fixed.
> 

Thank you very much!

I see that the issue has been fixed. The ticket mentions the following.

"What I am observing is that it seems when the slot ID != 0, the guest OS seems
to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."

Based on my experience and evaluation, ACPI-based hotplug is more likely to
encounter an issue where the guest VM does not respond to an unplug operation.

Thank you very much!

Dongli Zhang


