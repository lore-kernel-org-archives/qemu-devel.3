Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514F41125839
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KuW-0005va-QS; Wed, 11 Mar 2026 10:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w0KlQ-0003OY-J0; Wed, 11 Mar 2026 10:42:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w0KlN-0006tU-BS; Wed, 11 Mar 2026 10:42:20 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BDMoYV2570273; Wed, 11 Mar 2026 14:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=z8IVThxV6wG63T35xlWb1WHSmGin24CtLcFVu3p9mOc=; b=
 QTTzMH6ziJdkxew45TLvr+G9UjHJ0+aekxOQcVmdoIYaDxP3aBO7YSKi1NmmmdJX
 EuQb8dEDOteeEHhoFpBds9QNfoLoOY/OufFIeVsTlBEWbgNOi+POQ9w32AN7fGBs
 nGY+MggUwiM2rJyjsN3w45OQTmFZhIIafOcZ45e2fM/WZEe0kAkHHaqTWTjtm97p
 zwamaKHA2tE1FUBAtJhhdN28F8/KWRl5m7cR3OyYVnGIE1q/KfCpxGBlJdtcXEwK
 SuPdmk9QCan4jGWO9gb1+o2DKcn9Yfxid3EJLcBhAH7SvGx26s3lTUefShn1sjqY
 j//yNH7K1fo0ovqQLEXvBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csks2n7kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 14:42:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62BDCYWa039601; Wed, 11 Mar 2026 14:42:12 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafbpke2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 14:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upADrZbjLqTsK5x3jnJVObV6zOwjwbptbcUuZTwYJB4H913J5Lt2oaJWPFz+MU4IYGGCvdcufimeFF6rNOC8TtC/J4qqon4952on5nH3wJMa7artYfXB56h0V4v9Z+O3bQhQ/NBLvQwHCTPka8qMbmbjs/PWim/0A4quTu5enSCTO1LUqwFCRCvqtsQwmG+uSL5CAVk17DHxpQa2sn44lUTOCOuJ5ENuWT+04D1JzVHTNJ47fctmXp5Vvz9BTj1HJvONI6ngkol9NifyZmtncMnfRvVKs5ueOJxrvEjQmAxKzhck0WLpxNHSPSXyQXK8XbNNBufS3JDjvVTjpee0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8IVThxV6wG63T35xlWb1WHSmGin24CtLcFVu3p9mOc=;
 b=WiahzAWm6te7uX/EC1VU0spSJt5lNbJgRkJp0hNx0oLNfOI7PehvDfx59Jv8tqvk6ia6a+J8QdTfNTMoCAhgTht5sGcB3CoECO6QislISmde1zdS+F66n1YLO4Vjo6s59l9MZyYXRYh1DGddR3D8i6Xd5bC9uEu11Sb47NftArG6Ee1b2h4UHwTGFm7PLMGVwt9jG+f2BbaXBN1xvcEAwmiuyHb9v1XJlgkzWQVOMs27L7CLNNeYvDgll34DVc8BtWQSjHdJ7M9Y4PCYDWoeFSNA02fAxMmhKb/TAskPTX9SecZt9hZh+Fjy+rnTPJC1jWYntOGLqWeIbJ2ydQWMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8IVThxV6wG63T35xlWb1WHSmGin24CtLcFVu3p9mOc=;
 b=BACZtcXyf/OQJOB3iSc/G6+C88a5XOugap1UWI5wAuPcW3n/UByQPyWyb5ZTSoHgnnBURnfIaU0S0n5w08Q5qP2KRBzF/CmXQO4tSSZSAoWWz7VTDB5KhkgmYL4QMmwbvwbh0pzvHMssWRbh8NlBO+7tLkZ8+n0fVSC3K7FfeEY=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 14:42:09 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85%7]) with mapi id 15.20.9678.023; Wed, 11 Mar 2026
 14:42:09 +0000
Message-ID: <5bcb14c4-6474-47e0-829e-3d4973522941@oracle.com>
Date: Wed, 11 Mar 2026 10:42:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] virtio: Allow to fill a whole virtqueue in order
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea DE <dtatulea@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
 <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
 <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
 <CACGkMEt09WkCgJmbrdmyDYdB8HUH=Y-DrwNChJGrfH2afua8QA@mail.gmail.com>
 <CAJaqyWfOdMkeXEfHKadN2zrXmxNytC+uzFmf8pF7Ldrr6i0o6w@mail.gmail.com>
 <CACGkMEv2-pfUwMi0_b_FO0-FTLn7t3RDBvpYBPBT9+CdsSDY2A@mail.gmail.com>
 <CAJaqyWfC_hjCveqtnhx9cU=EA66oj5amLCGQ8b9Jf3pbzeuwYg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfC_hjCveqtnhx9cU=EA66oj5amLCGQ8b9Jf3pbzeuwYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f54df5-d4e2-4a28-bd88-08de7f7c5f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: gmcZ8soJWRkVpb8+OefHddK0HMv2eyeNWg50+ln9eRcETXDMnkv9GSlFombdwUSpvL5V1WTCxT3Xl16NSmnPpekDDopElD3rPNbZY6tFLza4wP7WVYH0OH+WwQ5bFY0gVwI9zaUHrXfIMfhqmEPxQu1C9wixk+bYrtnKFJIL0qaTATTW7ST+KtDhcFKd+b+BvyXmJpd0fkciEQfotx32dm9V8QG0IHkptyl52ILIKgBrGOIEMlicfIfus2YcyxR0D1HPBsqcwnkyqRYnT83RC7BiERAZMttqAlPdT4tbAZ5bA5U/1DL3A79160g8GaNdpJxWRTlrt8I3tFOaCJr2JQoPJpK/rkwMo0LTeU6e+Shrz1+2MCEnY5Zb1LdLw88/rYzTlkXmJ0QHxx3YIY3yB1X/HNRhCsOkInPBuetd16k8nCbA1NuHHZY4fAehhYP1qo2uXA0mGiBWkNoux0w1beINdeb3p3dwDJK53dHY7EQkpqmsU7FyLTpaK7hJ1WiZg3qNhFfztGk7picokQd08TGwibn6vJpvC2d22bT9EMasl0yNhz+2UYwNfCQ6iElDu2JRYMnRd+aFjOp+NRzeJUjLjsOU4ydHhH3VLsRSlDijxFn73hchO6PnG+pJOH0f3/e/EGu5eIs4wWQDWuAN9S2YDdDGhbrETNV5Kbn0spRhWbAO9dKv+77iyjM2KLSc/RTCb20nUY0/Eni6NIzmS19HZsKQE7J+dNEUvnF7lro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJnNmw3a0tyaHhaOTZCcHlwOU1TRzVxendvckdYdzNtZDIrdzVGNjI1S0p5?=
 =?utf-8?B?dHpCOUh6NUNUOXFFU29ydFdpemtvRG1zU3VoUjQ0L0RhNG0zRVIza001RDlB?=
 =?utf-8?B?OWtMcm5BK2ZXU05ldGc1QjgxVWRYaE5oVnIvSVpobWtGWHBBVWc2OXVmazZu?=
 =?utf-8?B?ejZZZk1tR2RNd2pDVTNXN1JTSDk3Rkw1T0FPSld5bDBVMFF0dFp0RkJZckpG?=
 =?utf-8?B?dTFRN2VVdzdBeitrK3lyRFp0eGlwcXUvT0tER2N6TXo4UFBwUGUwMmpMN3gw?=
 =?utf-8?B?bXRvU0h3cGx5UHkwc1Z5ZE1qY0NEL1Nqc3B2bWNRdGVHTEVROVZTVml1Y3Jk?=
 =?utf-8?B?eHorc0l2TzBXak9JRi9lK1hCWDNyb0xDNlVsbW1ydStFSGl3dGdYM3VSQXBS?=
 =?utf-8?B?MktERXNxSjJPRjA1Q2tRSmVmbWRPdVpWRWFVOXlrMkhLUHJFZEV1SDV5OVB4?=
 =?utf-8?B?ZXp4bEZwS1djYlQyZ244NU5yT2htR05HdTNyaU9lUlZTY3QrNHY1ditLUitK?=
 =?utf-8?B?VnN1N0w3bDZnTHRtZlMxaWRITW5yblZsc3Bnak9KQW1kLzIrU01Mek1sYjk2?=
 =?utf-8?B?SFFrU2NpbDdiR1dPTisxdnRyZXJ2NCszbDBkemJaVFZNNmpCMHgwZ0YzRVQ0?=
 =?utf-8?B?RG11cUtqOCtnaExJaklDWXRYdXFzZDVuVUw0Wi9NbWJtT01HYnBjZkgrdlB6?=
 =?utf-8?B?VkVDV0VkUmsrenpwL1VJSndGVHlCWC9OeWNDMzM0U0lYKzNta1NaYU9aNUZJ?=
 =?utf-8?B?M1JCZGgwYWNCR0ZOSExnbWZMMitDeDU3aWlXd1hiSmVuS1FOOFZqL3hjTFB4?=
 =?utf-8?B?YnFIKzV1VXNHUlJXc0hEWWgyaFlab0hZclRPS3BPUVdHc2lkVHROU1ZyWXNw?=
 =?utf-8?B?QUlHUmJON3JOK2tPVWNuNDhwQXZ2NWFOQnFSelJSdDJTWC9wVnY5WWhpM283?=
 =?utf-8?B?VmxNZzNxMndlaStNYmIySVRnUXcycnJYdWZrVkZuY09ZRGZ1TVg1T2gvSDk0?=
 =?utf-8?B?eksxQStONkVmSEowakFrd2lUc0NHL2FrVGRHQlNqMnE1U1dNWVhmd3V4aVVm?=
 =?utf-8?B?ODlHQmIxQS9vSGJFNFREdE5KQmE1VE4yeWZ3Q05EUDM1T0JDRE1naHF4SUhl?=
 =?utf-8?B?cFQ0cU92THNVUWVOckt1cDloNUR5V1c4RU9OdUI0NWVjK09FQ2JIYXFZcGFv?=
 =?utf-8?B?bWJpdDBla3NnejNBMytBSGVqR3dXeHZJUnVEemEzMnJwOHdTcTVBaC9WRTdi?=
 =?utf-8?B?Z3paem5sRWZ4ZEJYQkxxYVVSaFNaZjAyYjJ1UmszUWVZYXBrV2RvTWlXOUlD?=
 =?utf-8?B?dzIxRVM2aGtUZ3B1RmcwOXlzVkEyWVlRQUxyN0xyNmVvR21meitKQ3JiZkUz?=
 =?utf-8?B?bGJZektUWGZCald2eFNZT2V2NFhKazBNVVBMcDFNcEdCNTU3Qnh0NkNiRWJL?=
 =?utf-8?B?RkZLd3h4YUd3RnNCdm8wVmpSSFdyU1dGd2FoaUJ1eG1aTllOUENCTVUySGh6?=
 =?utf-8?B?TVltdFlkc01mb2c0RUdNaGV4dUxEZDhSQWVRb3FURWpFcWF4Zm5YSUxBVzd2?=
 =?utf-8?B?ajYzQnlhYjlrazNoL0hlLzk2L00yTWk5TTNZUDh1dkV3WUt2UzJSMjNIcGc4?=
 =?utf-8?B?UW5ESHB2SzFwZDJUYUQ0aDBXdXc1QTNBWmQ1MEtpV25TWDlNVG1SSElQZmRE?=
 =?utf-8?B?MlpwR1I1bDA5L2pnaElpbkxjQit4SGZwOTZHeGtIVjJ0VDFwdG1YQmhpSTBr?=
 =?utf-8?B?KytlckVDV1U2NjFmSlVFZFNPRWVXTUxoaElzUlVVOFZBMGdqRm01cEY0cEpq?=
 =?utf-8?B?ZEx0eVlQamlSeFQ2Um4ya2hjUy9SNmpZNEFoMW1NNHJETG00Uk9MMFYxUm1u?=
 =?utf-8?B?VHBCOWh2SHJoRXJGZlpHcUFDWjAwQzBidGkrdjN1S3NxMnNRYUlDbEp1V2pk?=
 =?utf-8?B?SStJLzJ0TGg1S2gwS2kwSzRVMGthRWxIOHJYWHcwSVdaZVVHTmdvUGViRnky?=
 =?utf-8?B?TUl1OElXVnBNMWs2N1NZYldJZ2c5VzBwQWRYVkhXeEFreG9SdVVXbFN2R3dh?=
 =?utf-8?B?VDJBcW9PNkJkVHE5WE80MWxMRFo1M25acFA5UjgyYkJwQXpFcjFZMFVGSnJk?=
 =?utf-8?B?VG9oNmVFYTczWU4zdHhORTd5aENYSTZlZEs2aEZ5NVdUTjZvODVVQi9aT1Zy?=
 =?utf-8?B?QlNtdWtvc2tWaDNFMk9ObG02Yko4YnI0RktqUlNzMmVyWFFuK0MyV0FtV0RV?=
 =?utf-8?B?QXdGVkFpcm5ucGE4YkZ1UTJ5Y01qV0FLUUwzcHVibEkwbm0yQnpZZFZva1Mx?=
 =?utf-8?B?WnU4U3pINnBSRE1uWkxJZ1B5TFM2Y09waDBPbGVxVFVTbE94eUxpdz09?=
X-Exchange-RoutingPolicyChecked: YoJlb7Nx6lFkhOpVX/6tLdJW+woT3gLduO+ggFd0bmaZMYUuH1GbbnweuwprpHprJhoWcGBBC453U6KwTMllT1S0EmhYg5WHGO44mAdnEeWklpmDS89O07RIECciunCQJauV6WV5hLcXXiFEIAn1YhZzhmZa85kTw0Hof65uB0/Fgq7Urw894sA9yOcvZnDEzPAL0QiAG28crHWm3bsSZ/duubUgqzGO2xum5QbLj1aM4xlQK5Ink8ruZIriy1NhhY58L/S2nEqhN6qNbFuM1KjlMjYNfEQsBjtcD1FotFgNaKLQdQVMU7mm4Y+XXkh9v1cn6HbEsJwZE+R+d7GWiw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uKk3tXo5sRSlnGPlIFMeuX9FeNUPbEdnObhSYYyE+usJZh2S5ch6mcviGFh9qHuNpJdPdrzt6iJAdVIQlhlY9nPVchFhYm8N8gmHjy70TCzoKaxnr0grjrnL+ut4JXfM9EdAMqgqIbvExIivu01EVXZVTo9XoxpK+/WP/Q/yZSmacVoCUK62/Fnfbc23ywvveV7O9vomo+xykLlnnFbdGoyTQNXVJuKcgq/AhPEKQ5fQOlsUFAQwxyflEFFFGYUG3OnvFKSes6oSDbvM4jEWbENi6xPYtOQDmuGy/l/xmhOiKr5ztxI4MchCt62CzGfmdMuC1oZ5a/C1Xmqgg3aEF4weod5yl08VEPXKw18n190OohPHwuTwlWXtyAXYooAeijx6YcOOHkj/YhRrxkIOvhkjTGJyJTD/ECIgTtioprzQs0XxTiNWsadns2UbS1jMzpBTduZ+WAWRkXJHMGynMuHudmz+2avM/KI3P2q0hbZzobcRlBwm9gee2AIDhNqLf+aUvM2k26Dgoubi+0XKWP1RtlRQ4b1bwz3EV1NdXMUyF6ev/vGBKZaNpWTeI0MPyhFrpBeYH/lfsyythavDDbsqdQSJj6YnZ8/BVjQdbvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f54df5-d4e2-4a28-bd88-08de7f7c5f99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:42:09.1618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxg8g43Xd63kxRM4+vqayJFFfoNmxc/HZQqD1bsPYkPQjfvEg9I0gE0nabetqdgIbFgdD6ciM4QD6TRh2XMChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110124
X-Proofpoint-ORIG-GUID: RwdrNHrRv19XeOdgeGp4omXGrWcFlCZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyNCBTYWx0ZWRfX+ZWl1msb1RyG
 hVeuJr8ZsN7UpbljdmEytxVofBAFakDMN8EXQ1s23Keol7WJZScT339/Wq9HuFjut2bXLsYkX7o
 ccUprVDyUkKOovPtnF5zjoomMVpoUbNJCTW0svm3e+OmVWefpqxEgT2Ct3MxDzZbzV5VLgxc07s
 UswnXHtZXOr4ktV4AhyFkzlgGRc1fB6TpBju/J4yLHHx17YaDzlPOFCHCqzOHwCg0W2eMNlf3HO
 lW9qRaDHAoUYB7r7NceaiQcsUKLPylTkpqnH1XymObToZEoIWjIvLPnIK+bnGu5+3g4X+w5fohn
 18VDHfXMgXU5ydgO2e1VNsJONDJ1xSOGPIIA1mYQvdMoICWIiYaYeDv8JK/Iio+E4iIPZz6+49S
 AXDbQ7kLsD0khxC4kDPGW5l97aCzCh3QAnxEsbbNTCjExFX2NxcbVjuOSpSbicpxpw434XYLHLS
 vLNQKnhP9VtGxeeLHvQ==
X-Authority-Analysis: v=2.4 cv=S4vUAYsP c=1 sm=1 tr=0 ts=69b17f44 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=ON-Zg8xfM4ASiRX4:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=20KFwNOVAAAA:8 a=CspG0oRO_Vk-tGPoVZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RwdrNHrRv19XeOdgeGp4omXGrWcFlCZt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Mar 2026 10:51:41 -0400
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



On 3/10/26 2:21 AM, Eugenio Perez Martin wrote:
> On Tue, Mar 10, 2026 at 4:09 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Mon, Mar 9, 2026 at 2:19 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>
>>> On Mon, Mar 9, 2026 at 4:17 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>> On Fri, Mar 6, 2026 at 2:23 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>
>>>>> On Fri, Mar 6, 2026 at 4:26 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>
>>>>>> On Thu, Mar 5, 2026 at 1:35 AM Eugenio Pérez <eperezma@redhat.com> wrote:
>>>>>>>
>>>>>>> As the while steps < max_steps is already one less than the vq size, the
>>>>>>> right maximum max_steps variable is queue length, not the maximum
>>>>>>> possible remainder of % vq->vring.num.
>>>>>>>
>>>>>>> Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>> ---
>>>>>>> Personally I'd just remove max_steps and let it be vq->vring.num, but
>>>>>>> let's make the minimal changes for now.
>>>>>>> ---
>>>>>>>   hw/virtio/virtio.c | 2 +-
>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>>>>> index e9d553295257..17f171551892 100644
>>>>>>> --- a/hw/virtio/virtio.c
>>>>>>> +++ b/hw/virtio/virtio.c
>>>>>>> @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
>>>>>>>        * We shouldn't need to increase 'i' by more than or equal to
>>>>>>>        * the distance between used_idx and last_avail_idx (max_steps).
>>>>>>>        */
>>>>>>> -    max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
>>>>>>> +    max_steps = MIN(vq->last_avail_idx - vq->used_idx, vq->vring.num);
>>>>>>>
>>>>>>>       /* Search for element in vq->used_elems */
>>>>>>>       while (steps < max_steps) {

After looking at this again, I realize my original max_steps calculation 
is wrong when the ring is full (outstanding descriptors == vring.num).

virtqueue_ordered_fill should only walk the current in-flight window 
from used_idx, not the entire ring vring.num (of course unless the ring 
is full).

Speaking of which, IIUC, last_avail_idx == used_idx if the ring is full 
and would cause max_steps = 0 when descriptors are in flight. What if we 
did this instead?

	max_steps = MIN(vq->inuse, vq->vring.num);

>>>>>>
>>>>>> Not directly related but I found that the virtqueue_ordered_fill() and
>>>>>> virtqueue_ordered_flush() can "emulate" an in-order device even if it
>>>>>> isn't one. I'm not sure this is good for the device that can benefit
>>>>>> from out of order completion like block devices.
>>>>>>
>>>>>
>>>>> I guess the benefit is significantly reduced if the device cannot use
>>>>> more than one descriptor in the same used entry.
>>>>>
>>>>>> It seems the correct approach is to let the device decide whether it
>>>>>> can operate in order, not the virtio core (as vhost-kernel did).
>>>>>>
>>>>>
>>>>> I agree with this.
>>>>>
>>>>> Currently, `in_order` is off by default but we could enable it by
>>>>> default per-device.
>>>>
>>>> After further thought, there's another reason. For example, for a
>>>> networking device, virtio-net should know nothing about the networking
>>>> backend (though some tricks exist in the code). So it can't know if
>>>> the backend can handle OOO or not. Starting with this seems to be
>>>> fine.
>>>>
>>>
>>> Well, if the backend exposes in_order, I'd assume it works better if
>>> the feature is acknowledged. I was talking just about the emulated
>>> device.
>>>
>>> I kind of agree with what you say for virtio-net+kernel tap or
>>> vhost-kernel case, but we're already assuming that the virtio-net
>>> backend works in order in Live Migration anyway.
>>
>> Could you point the code that has this asumption?
>>
> 
> Actually, the lack of code to migrate the inflight descriptors is the
> fact that the migration code of virtio-net assumes the buffers arrive
> in order :).
> 
> It is easier to reproduce in the packed vq: When used entries override
> the avail descriptors, all the overridden entries for available
> buffers are lost. But it's easy to reproduce in the split vq too, as
> we only migrate indexes.
> 
> It does not happen in virtio-blk, where in-flight virtqueue elements
> are migrated.
> 
>>> With worse
>>> consecuences that less performance. To be coherent with your mention
>>> here, we should support out of order descriptors in live migration.
>>> Not saying that it is urgent, just pointing it out.
>>>
>>
>> Thanks
>>
> 


