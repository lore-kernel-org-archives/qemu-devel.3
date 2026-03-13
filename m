Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC15106ACFE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0qDE-0004Db-0p; Thu, 12 Mar 2026 20:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0qDC-0004DT-No
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:17:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0qD9-0000A1-Fc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 20:17:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CLGnDn1929966; Fri, 13 Mar 2026 00:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ivViiANlyQ1n3z2gpTsomBWoYt5hRE9DonqIEEWCt0Q=; b=
 rXvy25qK8yDYmajP1YnaTAjJzJ7ps9R/La7SrXyVREBG/2RKlpVRXk2ViUoUebwS
 XSALZwdft9g8GFhtlrvUONnVneyl+zMVGTOY04mBPf6T/cnQH8Ws8W1HecwU1AOM
 +bG8GnOiUyyYZTMWzZyqB0nHSU/p1JxUkG/BbQdxwQSbedKo2uceLxKCwAoY4IyR
 H2cWV1BKrGIyFVx8PbTm9F++kVpoFdRaX9vp5nY3tOVht2qAO7X7i2sAvQPCt1a1
 e8uj9x5I9dwlKq+ILk5TCD0hgWHVy/ec0KsoWfl5z0iXTjSck0t/fi/8xK/uRiRD
 TkbjHJT8l4r20a7gpDBGCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4fj13m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 00:16:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62CN0XQX032966; Fri, 13 Mar 2026 00:16:51 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cuh5eswtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 00:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWRkFLlZiNCtpvMSRai76LphIpt4OB/sKfRbit2f3+e2Lr+iNJM7Ssj2E6A989Z/flFBMIqxIr2KT3rrRRBMMvCznHy7Vhpf09XMYBRF36SVvsMIvf7vt+3EScJO4oK6VMEjQ1X71SUe9wmtxGkVfQFNyqYzqfabJ1cUqT93PjoE9bcQqz/0X3bGkRbLesBg6zC8wqht+r/sZPhkkbfV2BwA2y1lp2ptFZT3V2oopGR5KK3l+n/jfQCz/umfXW29mha6IX9RRykGYagb5yUw6eZty612NkVYa/imDAgouAo7Cleiip6pHRuX9ASbKkYv9h4Ek/ZBm51iUry0+Cy7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivViiANlyQ1n3z2gpTsomBWoYt5hRE9DonqIEEWCt0Q=;
 b=OoO+gGFge2Q3uvfadLKPg+AtjB0tMs52M/OlcOikwvOvGoY4zFnE8a4zxz9HP9oeOhsukV/sG3PXp3gsVS7DY/hjDV+ST1FRqGT5OsVrlzSXgTV6FXU9vmxRLYrsztMk2dOHqCIlp7MymIkJzgI0JnLSaX8D6aaebshVl7xiqhJxagIcFPCQ4+B8RvCvW+C5XiJcLD4OQqloeWKIbEll2RILmvOk/NNscLq1sXkBETyqgmiv3Fo4AkIZ8+rLSR+FRlSLE6KoBlfr4KVQBiRv22U87rhWZPzYmiojcH6rTSGgzv4AmnegxuUpzh6yJuEh/V5DSztwBPatbRnttNpqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivViiANlyQ1n3z2gpTsomBWoYt5hRE9DonqIEEWCt0Q=;
 b=Ei9S4s3Teqzb97uWiR8867IM1f9kjCWjTSFSCv2q85TP0drTFfIZ4Si7T6ESMKL5gOsKfYyav2jLWAiVRsT9dCg/57UaOpDyZnFQqUioWi0PM2JshlVQqsktSJW8irhgKmrJ8FnJ5xHui++uua2PlJdqj1eMtB8k7dmcpzZ3fKU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA1PR10MB7813.namprd10.prod.outlook.com (2603:10b6:806:3a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Fri, 13 Mar
 2026 00:16:46 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 00:16:46 +0000
Message-ID: <a04f4989-20b9-4bf0-b69d-350bd5982394@oracle.com>
Date: Thu, 12 Mar 2026 20:16:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
To: Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-4-sarunkod@amd.com>
 <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
 <6bb7196c-3f0e-4164-ae3b-fd780c40c933@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <6bb7196c-3f0e-4164-ae3b-fd780c40c933@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA1PR10MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 939d44a7-095b-49cf-b9a6-08de8095cfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k+YPHCun+3Q35Tdp/uHCWb6C7m01/Hfb4Pq013IyRQeapIhI2KCvrj9KN3eo1FMmdXWzBk0zlN0weBB59kKxQcm+3maJszF51RW8Hl87BIkMAL/721bOMQ/WVxbroW/qqDIZheXR+P3fP56cxTUionRCPjFYcS/i7P7eflCfFyqr17Tv0zlmTxqsvs8A3nReI/dlfklmzuUa8CiUPx/TyActUD+mAm2qJ/L/gCTmOC7n7tuXYGFxWHL4lcltVD7vyMF+yTTMcK1o9b+7kA+1atvWLJhQMxihypEQuaXb+5YchY1Twy+W3U8Rcu+bJeDprhOMNVF+ZkR8T5kWqmpoKkjE9X347JMHnU8g9Q5J2FinFNHtb1AHDinKDIsUKaFxZ7LzuTeJfdUYr57HZzfus0zsgL7PQkBRgEv5cAs4YAfoaOcm5iK06r7j6BP148EjENqibtwxZbQhjbJBBRLiUBpv7Opy4uHo+OB3jmiI3I/V0DXoQvYvRc6tdl8pexBcrcqcryuR1voooe/2uHQv8ZzZHH4x+hpKIWhidG3b7kyFBLKEh/XCkt59jIPW8QgO4La8N5ItKduF1HXbvDfvskHeGhG6EQSy4fiVWj26RfuWCIsuEZqtvreNJCzmrffdr8/+0eJwH89rIjweVLcAZKZBpzasnWo6EbvhyC9D2eimDOo72PnM/besSGIN73zFJNZg50CNDcF2pN8FgzBjFkQMYFLLynqzHMGTaIyBiaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWl2ajVidzYyVjRvR3I3RkVKU0FTMk5FUUJyOTVxdHEyeVlEQ285KzJmd21l?=
 =?utf-8?B?OGc5VWMwVExsYWhGUEhnYnlPcmNnRWxoOGREQkhRbU5PWnlJc0kzUUpnVlRW?=
 =?utf-8?B?UFdaR2J6WUp3UmQ5V0xaYjBtcHpuaFFQNENXSmI5d1FsQVp4Wm5GWUx4blBw?=
 =?utf-8?B?aGlXSFI3Rk5iYXIrVkZJOTBkNWhlaEovWi9leWtuS3VsR1NreFhOMFBNaHdF?=
 =?utf-8?B?YThlUzlBTkh0ejg2UW5acmpXNGpEVTZGQ1ZiN3lHRUxreXBMVHVHelBXeExY?=
 =?utf-8?B?UXo5SnZ0a3JEck85Kzc2WnVLMXJDSEljem5rajJDSzdrZUhHaTdpT2d1Y28x?=
 =?utf-8?B?c1VtOGNmSHZkc1VDQ3NHWWhkTk54YVZpaGdxQ0x4SnQwSlpDWkJZdE9INXRN?=
 =?utf-8?B?MFJjWEIzck9qVnhHOW1zQzFZSlVRM1U5WHBTb0lESUhxQ1I2cVY3Q0JhZG1o?=
 =?utf-8?B?R2xMUkdBL015OWlMUGxSTEFIUWZtK2huNkpycGk0VGI2TUs3b2RDWWo2RlYv?=
 =?utf-8?B?S3BtQmxFK1p1TDVKTGRnRC9Da3cwMExRdk9sRGo4RnRLMTJ0bW1iMi83YmdJ?=
 =?utf-8?B?enRjU3d6dkM1bnNDcU82aC9LV2p3QzdOd3M1dElmRC9OVGg1NTROeEtyakx3?=
 =?utf-8?B?QmFxdnBZdmxpNHRJbUU4YzRqaUZhL1ExZ09kWS9ZdlhhK1ZFcnFFc3hTb2Fx?=
 =?utf-8?B?c1k2VDN3dzdrK2NHZEY2b0dCYitCOENRTVhKem9ZcytETmFjZEtGT3Fjek9S?=
 =?utf-8?B?MzlBakdaL1pYMzA5UnlQVWpUY0xsMnVVV3RxT3J1RGR6czkreWE0NEpMRDV6?=
 =?utf-8?B?MDZ5czMwazRVVk53bmk0dXQ3WUZnSVdsRUZIZTJtWk9NMDgrUUwvRm5RVGlh?=
 =?utf-8?B?NklUTTAzQWQ0WUQrMmRmMjd4Qk1VdjRPYzVpbHArc0w0dHh2RGdBNGFWMDBl?=
 =?utf-8?B?RCtXODdnaEplQzBua1VQeWVXbGE1VTZyZEZpaS9JSGlaYVh4NDc2Z2dLM1hh?=
 =?utf-8?B?eHEyV0swYUpOU0NlVFZKN3g0Smp5bzRxUTJ2RjlFOUpnRXM0RGJ6YUdEQis5?=
 =?utf-8?B?MDZ6QUVQaTBTY3NsV0dIa0lWMnAwV1lNS0ZwQmg5OWdRK29DbThRelBxei9q?=
 =?utf-8?B?d2srTDdmRHdmZUlzblFVUEZzM2h0eVJJZXVpVHdJa3JMNHlKODRvdWlZTG5p?=
 =?utf-8?B?c3hnbG5ubWt0VEYrOCs1amdxYStRL0VpZ2NTOG16UytYY1RLUlA4bmhId3I3?=
 =?utf-8?B?bi84YVo4VEZKeXJyTFYzczNDM3dGazdlREFRT0Nzbk1ZdWhoempiTkRqZHFQ?=
 =?utf-8?B?bWY2Mnlob2orQ3dDeTJsM1pyOFNHakJpem1RZENVbnR6dWxsQ3lEMWZoajVZ?=
 =?utf-8?B?RkdYaGlaaDZOZVNHT0Z4clFOTDZHSCs1T0dOUmZJZENUanBsR1BkZ1dHeHZM?=
 =?utf-8?B?YTF4MXV3cE9tZzRHcWpRV0RsWDZlMFZJVWFPZnExWENZSEcwZUVFaVlEajJ6?=
 =?utf-8?B?aXJZdVFrdVRNOElENVl4REFvazBkb2IxRlcwdmNvMmR6K1N2V3ErdmpxbHRh?=
 =?utf-8?B?czBRSVRuZVRtWWxMZXdkbW5IS2tEWTRFWVJuU1NzdWtxYTU1WlVyL05KU0Rr?=
 =?utf-8?B?NEJJQ1ArQ3IvVGJVS2h2MmhsRWQ4S1B3Slc0TFd0MmFtaGhiN0F3cGFqRjRU?=
 =?utf-8?B?QjNTVXB0TU9ZcVp1Wkl1cTE0NHZXWVlvc0U5aSt0c1MrQkE0K3pjUlRTMlpS?=
 =?utf-8?B?SmVKTkoxWU5yaVVYbVVLSEFWNDJ0eHVjYzN4YXFmMnBWMXN2ZFVaeDdyNUZT?=
 =?utf-8?B?bVNpdmdzNmhsaGFrVVhrbTZLRkFuMUJWaFY3TmhkMm8wS2EvVERzU2RyMUVR?=
 =?utf-8?B?TzVRUDJsTk42Wmc1YUdmMVBFemdTbGt0TlpDemZiK3UrMzJsY1l4QjVTUk9N?=
 =?utf-8?B?alhHVVphYUs4dmgxREpVZXZpTzVzQ2F5cnE1VURYRzBqNFI3dUdSeUxCZ1Mr?=
 =?utf-8?B?TEtuRDBiSndQU0ZRUERURnNPMDd4aFpxcGg0WGtZdGhwZzhFbGNEZEI0SXoy?=
 =?utf-8?B?WkZiVWhGdWh2N0VBUU0wV2ZiVU5TU3kxYVhnQ25pUnhPMk93S1lGMTlqWXlG?=
 =?utf-8?B?bXZ3RHhReldqczRDN0NhMHE1RW5JZ2ZjV283YVJtek42bFp6dmxoRG1yMlUv?=
 =?utf-8?B?TXpqYkRaUEcwNEc3Wk4wYUJQalkxUll0WlAzanZQMmhISEVBQXl0Zk1NMk9q?=
 =?utf-8?B?QnFVZzNpQ3hZdXhxN0FSSDk3TUR6cnVvY3J5Nk1sZ3BFNFBmRTdqUWxiUzNQ?=
 =?utf-8?B?b3hSSEZpbXErK2IzMzQxaVJBREhBVjk4dHU1dzYzSEorOEo2RzdHWUU1bm1x?=
 =?utf-8?Q?2k3cN5ZdOAGFO8kQ=3D?=
X-Exchange-RoutingPolicyChecked: gEB1Sk/Nd8H+wME9SYO4sbG4mG2TqtXy66FUEXmI7Iq7KlsJ5xLvBWJfFammLq+Z+LqHRDUaNoTzPPamDC7dljQCY3i1U++VJdU2hqwv7huvskJVpupbddVuKVeupzlBiUf6Z+ZWZ63eVOrM/3doLGVRHl5XAqmMKY9Kbha4Lx5jiN/1jn7a2d+AkLD96IoPnoF6u148zg7WXd7HdeZ1FZ98CC7eZsZYk/tCD01tOmChHd8n61c2RVyLsxBHbzf6kzqed2xUdJJL+kHBjwDh0yjxxWeYrSZcNaDELXyB+QFMHufYQ14WesA8WmFi8N2WNashLMiaWMCEjC5lfOD9JQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ObuiwFmEljbFeX426ajaydmHlSlcMhORUU7T5tw/LrLIGpnrbY1FPHGRPwvGQPxlpROMKV9G0KdO0r62nqm2GbYizaCgUi8nFT1AKkmC+Db85b5FK25kg+l7qrDaaEu/N2D8rrPfcRgNpPoWKvQJYkwutKEu/CuvRXKuEPv+tDiKhFpVd6+jWTtoUiDgNFvYpNFf62GgGQJ09xbkM3e36BwDIEDZOBr4HdbDxzqreuVmbS7XbBBqtwiaDUcVU1o2zy+Nd29A4+TZ0Fi9ek9/2T4NdsXHasgZ36w/P1qgrVO3wn8ZSWJgYLYAP/QLs2WeVEASDzHf/t6eTaYV6JtUq4slHUA15t/QUlov1jRLJTsDpTLiSgLpsHMiobAZiq7YFn2Yy7Jtcm6ZYZ9AHu95s4Zytku1lSIx6TAMuNXp3KpPQnE9WcroONetyeJ05XoiDXJhVhXW1pc6A0AGJuwZA0HO6BFhgd3PAHcet4v/xJzPIlKRqRpWonJhi48EI5ikJbV+fQ6rqYReygunu1pNrNuyPn+3p4eqMat1l3vyLJH9u+2Qfvk6oWe0YlapktjuN1wZg2cGkGckwaWm0jfUbZhGAtKoVCCKNWUfCZjdHqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939d44a7-095b-49cf-b9a6-08de8095cfab
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 00:16:46.2056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRjX1kt4SyGs0x7kGnAP7nga/LQdNP9qOB+86qrEE9XIp3X84GZ6a8b9Jx9LrGFiHxKkeyFrTZxAx2/nBlBtGenY12e5n1l8dZVrYZ8YZD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603130000
X-Authority-Analysis: v=2.4 cv=c/qmgB9l c=1 sm=1 tr=0 ts=69b35774 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=olhhzjs1nk1UKyXZK4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7Xtnjexz6QtdBkeo9rvEdB55lw7F4B7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDAwMSBTYWx0ZWRfX4jdG3PZ84XWm
 vTfxz8lz/sAlcLE8kaaV5LN8QxCksKW5iYUHTgunx9MrywKsFYisboqzxML8wxtrSsh8BNW+JRn
 HySXBy0ZDsV4KqlyUw9gReWQC/HmU+8gR6I5KLv/TwnzDMA7Sv9NSaERIyzHuem/1Jnb9jBX2kU
 +dIXUtsxYvvj5A7ePbYozVtPQnipJFC4p2Lmt/iuLyiRfLu4TaZxsdewMpBfSpjhE4jnHyH+ZWf
 lL+38GF9IWdJiuKhEzDSEK4Pvf52olUTChBFIL8/sFrz+rodvYhfKte+dB1XWKKtJQYl1AQktzu
 0KvjsFomwxJLfysO6h0n9Zs9jfx65JPG0zHnT7wPDjTeVExGPQwnIZl7E/C/cJPx5ZZY3EO0Og1
 1eoRKu4kBV3G+rdsuLyNOAb2MEg2nw217Wfd+AJw7anXBZiVBNZLbpwUSB4tVtkUxAvOeTQw0xa
 pb6jI37pqbJzA95ItJw==
X-Proofpoint-ORIG-GUID: 7Xtnjexz6QtdBkeo9rvEdB55lw7F4B7j
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/3/26 4:55 AM, Sairaj Kodilkar wrote:
> 
> 
> On 3/3/2026 3:17 PM, Vasant Hegde wrote:
>>
>> On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
>>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU
>>> itself are
>>> sent based on the programming in XT IOMMU Interrupt Control Registers in
>>> MMIO
>>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability
>>> registers.
>>> The guest programs these registers with appropriate vector and destination
>>> ID instead of writing to PCI MSI capability.
>>>
>>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>>> MSI capability and does not care about xt mode. Because of this AMD
>>> vIOMMU cannot generate event log interrupts when the guest has enabled
>>> xt mode.
>>>
>>> Introduce a new flag "intcapxten" which is set when guest writes control
>>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>>> the XT MMIO register (0x170) to support XT mode.
>>>
>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>   hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
>>>   hw/i386/amd_iommu.h  | 17 ++++++++++++++++
>>>   hw/i386/trace-events |  1 +
>>>   3 files changed, 59 insertions(+), 6 deletions(-)
>>>
>> .../...
>>
>>>         /* update the flags depending on the control register */
>>>       if (s->cmdbuf_enabled) {
>>> @@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr
>>> addr, uint64_t val,
>>>       case AMDVI_MMIO_STATUS:
>>>           amdvi_mmio_reg_write(s, size, val, addr);
>>>           break;
>>> +    case AMDVI_MMIO_XT_GEN_INTR:
>>> +        amdvi_mmio_reg_write(s, size, val, addr);
>>> +        break;
>>>       }
>>>   }
>>>   @@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
>>>       s->enabled = false;
>>>       s->cmdbuf_enabled = false;
>>>       s->xten = false;
>>> +    s->intcapxten = false;
>>>         /* reset MMIO */
>>>       memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>>> @@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
>>>          .minimum_version_id = 1,
>>>          .fields = (VMStateField[]) {
>>>              VMSTATE_BOOL(xten, AMDVIState),
>>> +           VMSTATE_BOOL(intcapxten, AMDVIState),
>> Do we need to increase the version no?
> 
> No, because we have introduced a separate subsection, the older and newer
> qemu are compatible.
> 
I thought that was the case because the changes will still be part of the
same "release". I don't believe we guarantee migration compatibility
between random/intermediate commits, but...

If we are going to follow the guidelines strictly then I think Vasant's
observation is correct. The patch changes the layout of the subsection so
we are in the same scenario that lead us to include a subsection to begin with.

Because the two new values are still part of the same xt support domain, I
think it makes sense to keep them in the same subsection and the simplest
way is to do:

 static const VMStateDescription vmstate_xt = {
     .name = "amd-iommu-xt",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_BOOL(xten, AMDVIState),
-        VMSTATE_BOOL(intcapxten, AMDVIState),
+        VMSTATE_BOOL_V(intcapxten, AMDVIState, 2),
         VMSTATE_END_OF_LIST()
     }
 };

That change is on top of your current patch. There seems to be precedent
for this based on my search in the git log. If you are ok with this
approach let me know and I'll apply it, no need to send a new revision.

Thank you,
Alejandro


> Thanks
> Sairaj


