Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82CACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 22:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMvnS-0002qO-A1; Tue, 12 May 2026 18:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wMvnL-0002pO-Tm
 for qemu-devel@nongnu.org; Tue, 12 May 2026 18:41:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wMvnI-00039M-9g
 for qemu-devel@nongnu.org; Tue, 12 May 2026 18:41:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CLagvZ2354666; Tue, 12 May 2026 22:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=G2bdcfbg0qWe9+S77EIFkR/3xSbDYsmxdZkCW6QsdtQ=; b=
 JpO34Kq/mZpef7szeP3W4MSvYGF6lD8B60OrCeK8ZSBMsmSASsELWYAqdb0xYGpe
 nRagtR/pXmK2ooqdPrbRivY74+YOR83JhAz8gwyfgZuZUP9jx9hFhWQ7e38nqOBr
 VCmY0CDUur/Ltjl8RNEZFisI+6gNkFlG1RFCj+60CF16Vullq5P8z4SR2j7ZCSs1
 zHhmGJ69ZdBwfa7y2FZ/pwML9pmeCsoKfgvr7lMzMUrfvjY5UzHhwBCC/ElPUDko
 My2dDl6Y32xBV7dQjanIYrelXuxAyMVQK5WuEfgVggQe3i8RUKMXAQgOmdQnTV6b
 75aG7z3QBMp6dOhH3n8mjA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c97r4kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 22:41:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64CMZ3Su000680; Tue, 12 May 2026 22:41:19 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4e3neav7xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 22:41:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcFtajOyGXKTrHSZlJr0vhZMlZZ4xhb7jqJebewM3ef3C0lq1ur849Mne/IpH4XMV1M7Ss4yVz5ltfud34mapDovOOG6VBBSjasGVJfU7ERiN8F7IIGjkHblIKP8BVNKbj+WsEowLGsTegEwTR0T6tj85EuTcGinqgCC38oJZ8/5b65O9YGLMfU+3gp/FcHN/B1X1jPZePsakehf9Z4eB0MklFTncsbasY6fqJi+i35lUsTNXRXpsMzTRzb6OT00xxa676aEwR25isX+jMUyGabarRZNercEFE49fb1InY3r1IPopv3jYDI4KHLmLpOVJ6pEBLuFjg9/PGwAs0mLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2bdcfbg0qWe9+S77EIFkR/3xSbDYsmxdZkCW6QsdtQ=;
 b=P6f5L7cfpZb93Nc1FWSi0eKDHRnharOm4JwTiWzAb5+1iRh/VV1atWEhNaDQI9Wx3JOt2YlMWDwJJ0Y3U1ngmXov91z4eVGbaLn4po57HUI97vkmxWMMfUkCflbQ79W3DVn7BbOJF5gyLe/l/KDB1hcT6BC43zo8GcVVGEwN4+4ZUfbqH/M3PWD/C/Os0mtDX2AuQsKwiPWoCwRdUdFjnVm8wb3wtD0+EtavkneAqhQecS2A/ivX2irP7imwgv+srtFA4QiFeZH2iyPG9tkXEX2qfSYGKAZblTl27smbyIzwXBICVlx9jTtvgLTIXrqJ0iH3HvRs6LUIiUcrl7Bh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2bdcfbg0qWe9+S77EIFkR/3xSbDYsmxdZkCW6QsdtQ=;
 b=gIivknT7Ex3Pby5KcNWzSpqqYR8Mst35cVjsHm6Y3q3udVauQ6oM0h+V9j4lAJBr/kplwv1kvCg/3wgZcdTm4rNjmnCTfjuXg6mZmh6WxSKW6m3imJrQWK8aQuYTDJVF/7pUYWDI1wXcMOZqFDqrTWd9kzKTYbEYKqWNUMA4mcw=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by SJ0PR10MB6430.namprd10.prod.outlook.com (2603:10b6:a03:486::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:41:11 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 22:41:11 +0000
Message-ID: <ff57f46b-9cd5-4647-bdcd-3aa4d6cc778c@oracle.com>
Date: Tue, 12 May 2026 15:41:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/nvram/fw_cfg: update bootorder to fix SeaBIOS
 bootup failure
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, kraxel@redhat.com,
 joe.jin@oracle.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20260310170712.46336-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20260310170712.46336-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::11) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|SJ0PR10MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 03432315-781b-470f-3493-08deb077902a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|4133799003|22082099003;
X-Microsoft-Antispam-Message-Info: nqnemdjt24DR32PVchbnqJphMO8GBfCe+lGJ50zCi8e3k8vYJlqHMiinnXsbFROb3GANaUfhejZU+mfbmOM+OizYIsOjDxpgNLYid2DYk5czfe54kh39yoRc+45uA41YB0y91szIpPCNuh3SxAFvJWEbwx19fa2QHnKIahmqizPHGPTepJKWDRcFv4Wi1xcfle4rfvMvGlR24Dy+UBWSnUt+Q4JFy1byuB8LLrFFp/9mJZE0dATuu7O+L2peF9NrUmlLWm+0475hFiVTEe5SvXEZRXznTDBK1foUqbrSUiRjJxO6UNJak5MY3fQ0am9qPP8kkH6flyy5kokLuamPycrmw2RsVoFAwHOwpY9MSmuYjBXlPx3Frry9SG8LtSEpd+Z1pD05ccIZAdTnrnYBwssRlETmpr6EKTeb28jygbGr2fmr8M9ZOJry1Uj2z21xKxKywMsq96+Lef8iyLkWnKPCN8JjHx4J+nPSqA9LJN3PAIhvnLjPj643tf7Yq0izu+ToKqjTF7VH4/ZJJKnyAFAhdUDmom7XWMF/CgdyqspPGdtP7gYF2evG+TR9OyHdqzkNNOdAn8IVdBPr/GuZvLio+5F5V31lXjj13B1SMLrvQuTPFOLjHaug5jqCxm41MoO1oq0xhG2NnjABhPbF8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(4133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNzVmFDWlk3QlVFRkJwdVU0UndwSW85QWJONmZJRTJXQ25ST2xxNmVTNnJo?=
 =?utf-8?B?M1Z0OUh1V0RjNEw0cHlZMWlmc2dyK2d5Njl2OWVmeUlQMThuc1ZNeUlWZ1N0?=
 =?utf-8?B?dHowZHhaWDVDMFk4MEY5a3FpRDN5NjU0V2oxbU5xT1ZrV1JxaU1rRTBHZWRa?=
 =?utf-8?B?bS92SElIWVcxc2l4N2VVRC9sMFlnWmpRZS9WcHJnRWFwcTlMMDUzZU13SmYw?=
 =?utf-8?B?NWU4SGtSbjVJTVhtWVowM1c3SVBzSThBYVV2aXM3YVdvS1VOYnk5SzZ2cmR5?=
 =?utf-8?B?M0d0blpwWVU0cXdFT1FQelNGYis0R0VTeGFza3A4ckR0L3RZS0JHZWJRM2Nh?=
 =?utf-8?B?dVNyTVRCN0RWT0lHSWRPcWI0R2pDK09pVndrWWIxNlFCY29DNG0xRGZXR2JU?=
 =?utf-8?B?MmsrNWpEN2FiaGJtcTEvSnUxMEQ3amQrUFAxY2QwREhpWGdSRUhhR2dqNUla?=
 =?utf-8?B?NFhPb3lWUzRCalgxV2xvbTdJMWNWd3R3NmZrK2dZVnB3UWkwaklSQnErV2l3?=
 =?utf-8?B?T1dNKzhnL3NVbjRLNFRXNVNCS1BIMFFVOGZZOXIrMWVnWUk3MFV5YlYyV3BI?=
 =?utf-8?B?bzR3blQvMWNIWUZxMVUvdjBBL0FxaEVUQTFIVXg5R0FWYkRKUGdpWWVuUjBX?=
 =?utf-8?B?NEdCR3pjRThnRm4yMjBEOUZMWU53WDlWcCtNODZDYVZTaGFLNjBwVnYxM3I5?=
 =?utf-8?B?MFh6QnNxVUtRWWFadUVuT0c1UzhFYm5mMVFoRWtQc0FKdWgxdlJOSldMMVln?=
 =?utf-8?B?MFVJQ3EzOUtrOExBOXFnMnYvV0tqNVVveVhXb2V3OVRzS2FZY253YWFVK0lR?=
 =?utf-8?B?cStoS0VackEzamlyL2NZb0tvLy9velVqU0VNaUorVXRBUDJ5SGFLNmxXNGpF?=
 =?utf-8?B?dHFzYkNBWHhhSU5WcTlMUlYxbWpZUlpNVDREbkQ4OFZBTEp5WTZUM3J1OUVm?=
 =?utf-8?B?R29LN2txTmFKU2ZsbzJsaFRoQ0l5Ky9WWnNrZlVINDhRbGtmUGNGSkJFeDRL?=
 =?utf-8?B?dFFTZGp2dk5WY1Z0NUcvdklQNFM4TTltQkFwNlZTVHZOVGdLYk50bUVzejhs?=
 =?utf-8?B?YVZtZVVGVDdCaEh1cStwMkdJVzY4SjRRdzQvNUFFbC9LemFiaGwyVHY3WTlL?=
 =?utf-8?B?eEY2czQvTVRaZGdkdElXbmMyQWdXSFlQeVltUzlVQjdxZU5PMDh4QUFmWTl5?=
 =?utf-8?B?U1hpdFVIemtxa0tib0kyL3BCQVNlaXJ4dy9lU2paa29pemVvcjR1RXBFRmY0?=
 =?utf-8?B?c3dMaFdzYTFSbWgyTHBtVTRJZnM3SUMza1JjNElFOVJvcEpPb1RGQyttaWZO?=
 =?utf-8?B?MG1uSVgxTzQ0bFpLNkFIWGpwanNLYXQ5eWZpYlRxYXBydk05ZEJwWFd4ZlZX?=
 =?utf-8?B?aDdIeEdvR1RFSGNUc01rUS9uTFpJTWlDR2R5dUpNdlM0QTFMNmE5aUlmcmM0?=
 =?utf-8?B?cXdtZXEvd1dWOTdBdGNmeVVCM0t0ZzFjZmpFRFE5Y1l4Q1lWQnZMQStWWGgv?=
 =?utf-8?B?cHBZVUFDdS9zSmpOUzRtRTduUjUwcGRtNW90R1RKMXhiVmI4d0crU2JxZzZ4?=
 =?utf-8?B?OWxxR2VPZHdQdDh3Q3JxSGt2eTZCQ1lJWE5JZ3k2WkZCdGNUQW9scURieVk0?=
 =?utf-8?B?YmNhL1UyYkE0ZnFwd3RrdWZ3OE1XeWJwOERoaDU0eWRyck9vWlN5NS9NU0Fv?=
 =?utf-8?B?Uy9RQUNHeGdCdEVnOXZiaG5iYWFFRFVVY0VtMXR3M2ZIYjI1SmdZR3BUa1pX?=
 =?utf-8?B?aEI3ZTFjTCtOQ0tsY0JjSGhxeXBpUjJlbDRYUUY1UDlaYzhIeUlXSllWazRi?=
 =?utf-8?B?aVh5ZlRmQmlSOUdTbkZnTml3YXVkYkhOT2J4QlJYUmJ4NHNPZXhiNlNqMEFO?=
 =?utf-8?B?bTk0QVliY3ZXVjZla1B5aGJna3JLZGN2aWxzclZONG92KzA4emJVS2p5WnZz?=
 =?utf-8?B?RE9rQXdYTmdodFFheWp1ekdwd3hDVXlSTlV0RURhTmJkSUo0MFh3TnB0cS82?=
 =?utf-8?B?L3BMN3A1K1czMXFjSVVwWElYT2h3aVpqSDQ2WlRnbzhZUjBaeTNQMWEyZVQ1?=
 =?utf-8?B?N044SzZrM1lOMnJpdGxSZnZSSmtaUmNHeHQ4akZkVmQ2UzZ6Y1VOdHdRQVZ2?=
 =?utf-8?B?ZnA3NGhYR0VRR0Y2K1VrNTBObXJ3dWdnMFVCMXNXUEZTQmUzNytLY01kN2Rr?=
 =?utf-8?B?VjRoVmRPdkNabER5MjgwdGFybjAzNTBqa0d6ZHZ4VGtrTzI0NE5zeWJVeVZV?=
 =?utf-8?B?dGhJbS9tcG5WVUZPQk9DUEFZVFN2QUlwMjd2aGtzR1dDL3NmeEhmUVFzMFFK?=
 =?utf-8?B?VkFRSTNhQzJGTFFlK3loU254NmIzS04ybys5ZTZ4MHlpSkxVM0FaZz09?=
X-Exchange-RoutingPolicyChecked: uJlBtNaZqilR/6WKEh7vyruYfluwYiED9hGKhU/31YzJ3s3zDLL1rDCRJs25tevAfcfZlMBZOatb1mBXt2WxH9oTM/fPKnStLRxD2Yjqzj53x8pjD7MZ1/NZXfZnjsaX8C6+hb+BtccKbjMZWJEmWN4fAlyTpeMYxTLccwgr9zqApli5P0VlUUYhqecvN1ABq9lA9DnVOsK3Zppfh1ux2zsFNBPPtfbuyFEa9eI2gzqiK+72iPPCAtoQFs+na/WhYHcdaylGJh/p8P7UOuJvfLQ6jA/t9euuIAiW82NhJPaeWVBHev4HmK1oz5VZbXJ7a/evZjTTiayELzY5YMzcuw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 98cRFKabusYwum81eTSLjxxhCaPeHR+FlOOMHHwmDL2WHTVKbJXCAFyWGej2Lrwu7ShcqTvTe5tkGAOtCGwYq2lVqkpCUpRHzy2dtLOIEaDV8BDVTGCfHB3UfFp6fP6WPvhHY1NdiBcHBsF+1cOX3JtLl3x3aAM3QvpXR55Utt9Bd/oN2uNBc3NRDGv1riahOd22R6QKGobuEZJsTuHohClPlat+yStZcbDd6JyNU/Zp23tPlfhssuqhlv0ZxEtqt8gCKvPEfjzmeYFvyU2PqgZdl2TuVGG3fuf2aQnBMUMzhS9QjXVOrSpROYa31yXvdRKFiIC/N99HPX7n/784k5xuf5VYeZcqW7jbjd2nND9MTYUdXz8v3adFqKUq6m3LY8krbCVfkDFLYLBMttjJfGzZxPP5ndo6GJU32/PP1oiQ9WreRLULrY67797b7Ztw5vhejB/T+iGGW+LY09Ot+YXBwPj9qmWqOA6AkaTdExnCbEIqTPU70SRA8medOdVZkOUktHHWhgJE5JNWj8oC+Sl8KewUN7heMrih/TF1zfJwHbZtBHy2LyWxHP/evbhQpTHUWyQiTCj9a5Afa/Bom/Z9xCcyJVSPM6y0lHu4bic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03432315-781b-470f-3493-08deb077902a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:41:11.3376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udD8nf5txmL8iopY3ScYE3hNSZYviV83j88hpjJeAgaNx/wBB7KdnW39RqLdMRGfUFGc2tiRVIKU/7++Pn/eVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120231
X-Proofpoint-GUID: qTuXAIUcjAdQ7IK5YhvLD1aGzf1stMgP
X-Authority-Analysis: v=2.4 cv=AeCB2XXG c=1 sm=1 tr=0 ts=6a03ac90 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=Hnm2Hy9fAAAA:8
 a=xDyOQ7S2AAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=taVDWLPRZv95-ixF4LIA:9
 a=QEXdDO2ut3YA:10 a=qByqzKpv1oajCkFmDuv_:22 a=xG0zjm5BtbRCg84i2bc1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIzMiBTYWx0ZWRfX19NR5Cp1LAiR
 0tOJlLnS5cJMEmT0h4o3z8Ev7mAcIoafSmirqJlUGyz0g9i3oNce1l2iXdBmnhxFgrgrxGGJX9w
 /5CHs6PPyoUCDDVybaOmSge0uv5R9VF74DXu/Jb395YuccCQtycTQHbPpG3xR+kIEbyfwj4+lsm
 a52XEF5ghLkO0EujZqQPT/TW1E4tLkITkwsIoMBRvSXUHvGfabDLI8+6GQnlh0scJnA2hciQj+G
 wSopiF0cSENQqncF2Ilx08VtxNVhIjY/ZEC252fmIxB/R3ibKmHWCYzt+BieU1MqogViJhxP8FO
 +/J7KgtNPhAznsdWvz+2hLHgYuoBxB/PYKypgSObQ4UjomK53O7Vof8BItKmtJvsCLo2+3g2no6
 niMaDizkPMqxS3Fd2hRTCjLccONy3nJpME2YWq1GqY1EKUKxNSL8Q/KLaG+T/liyHpuTEb7gPc5
 cEjnv4cryXz6Crkr6rQ==
X-Proofpoint-ORIG-GUID: qTuXAIUcjAdQ7IK5YhvLD1aGzf1stMgP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

FYI the SeaBIOS patch we used to submit to SeaBIOS two months ago.

We got the same suggestion from Gerd: system_reset before starting the instance.

[PATCH 1/1] boot: try one disk after another until system boots successfully
https://mail.coreboot.org/archives/list/seabios@seabios.org/thread/KECOCJCQOMPUF3WMIVN6YUJ7JVF7EAYW

Thank you very much!

Dongli Zhang

On 3/10/26 10:06 AM, Dongli Zhang wrote:
> During system reset, and only during system reset, QEMU updates the
> "bootorder" and "bios-geometry" entries in fw_cfg based on the contents of
> "fw_boot_order" and "fw_lchs". After the guest VM boots, the firmware
> (e.g., SeaBIOS) can read the boot order from fw_cfg and boot from the disk
> at the top of the list.
> 
> The reset handler fw_cfg_machine_reset() is invoked either implicitly
> during instance creation or explicitly by the user via HMP/QMP.
> 
> However, users may attach or detach disks while the VM is in the prelaunch
> state. Because there is no implicit reset when transitioning from prelaunch
> to running, the "bootorder" and "bios-geometry" data in fw_cfg can become
> stale. As a result, the firmware may be unable to locate the correct disk
> to boot from.
> 
> Here is an example that demonstrates the bug.
> 
> 1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
> prelaunch state. Use SeaBIOS rather than UEFI.
> 
> -device virtio-scsi-pci,id=scsi0,num_queues=4 \
> -S \
> 
> 2. First, attach the boot disk, then attach the secondary disk.
> 
> (qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
> (qemu) device_add scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
> (qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
> (qemu) device_add scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1
> 
> 3. Start the VM from the prelaunch state. Because the "bootorder" and
> "bios-geometry" data in fw_cfg is stale, SeaBIOS attempts to boot from the
> secondary disk only once and then stops. As a result, the VM fails to boot.
> 
> One possible workaround is to require QEMU users to explicitly issue a
> system_reset before starting a guest VM from the prelaunch state, if any
> disks have been attached or detached.
> 
> Another option is to address the issue in SeaBIOS. Nowadays, SeaBIOS
> attempts to boot from only a single disk. We could enhance SeaBIOS to try
> multiple disks in order until boot succeeds.
> 
> Another option is to update "bootorder" and "bios-geometry" everywhere
> disks are attached or detached. This may require identifying the relevant
> functions across multiple device types, such as SCSI, NVMe, virtio-blk, and
> IDE.
> 
> This commit fixes the issue in QEMU by ensuring that "bootorder" and
> "bios-geometry" are always updated when QEMU transitions from the prelaunch
> state to running.
> 
> According to runstate_transitions_def[], RUN_STATE_PRELAUNCH is allowed to
> transition to four states. Only the transition to RUN_STATE_RUNNING
> requires updating "bootorder" and "bios-geometry".
> 
> v1: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260225220556.11049-1-dongli.zhang@oracle.com__;!!ACWV5N9M2RV99hQ!OFofhPtLZFckBZ3aal7MYLiV9MLmAf5-4SKkVHOmWOb29_2JORlCE7NYn_NXBBOOZ7PC12n-UbJjmxaiPAqLJSHt$ 
> 
> v1 -> v2:
>   - Add new runstate tranisition notifier to track transition from
>     prelaunch to running.
> 
> 
> Dongli Zhang (2)
>   system/runstate: add runstate transition notifier
>   hw/nvram/fw_cfg: update bootorder and bios-geometry before launching
> 
>  hw/nvram/fw_cfg.c         | 31 +++++++++++++++++++++++++++++--
>  include/hw/nvram/fw_cfg.h |  1 +
>  include/system/runstate.h |  8 ++++++++
>  system/runstate.c         | 25 +++++++++++++++++++++++++
>  4 files changed, 63 insertions(+), 2 deletions(-)
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> 


