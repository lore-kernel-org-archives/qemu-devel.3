Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ED0E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 22:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUq6-0000c0-Pp; Wed, 11 Dec 2024 17:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLUq5-0000br-Jl
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:05:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLUq3-0001Hq-48
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:05:49 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBKD1ET016427;
 Wed, 11 Dec 2024 22:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GG3+Rz4bQPB53ZC95xi29QGlGl1yPD83jDPVZvezCM4=; b=
 nX+gsZCnvKH4vLCv+PGuCUX/tP7WVxXgIFnzLtu6Jb8RJJDByRo1ey9nuoqUHTY4
 3772ZPd+4LgzKH6ODW33osS2FNpKYG3IPpB7CmagavQV0mgDPNH8NODUKnWjYIlR
 +JUHsDUnv3CMrGu2Y/MvEvLjjKrFhvcHPhNTzXfn1LVzl0VcF5vEvsLGO4icvJnv
 BLEdqvc998XayveQTMpopQDYnHpLmoXAzPbXctpCCPIZKmtemVpvxMLpI+7ZAPXm
 TRuivnepDbfxnPoeg0aOQJdrUSdsASKlVZhEVs1ZedFS8CsmohdV31SS6sKr7Ewj
 I4mIjMwJOOxb8LxeiNxoHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9asuv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 22:05:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BBKJaFV034911; Wed, 11 Dec 2024 22:05:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43ccthsjv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 22:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC2Xg8H4Vj+ApfoukcruYQ7k1E0NfdWS6/HinFP1Gq/M3m+vag4e6VK1CPH626Y1exGt1ciGxhDZXfZ2zvUIqptRfFnhOEYoAc18AMSN8rRx6E7PB1m8ei4qatQNTM0TRhQRWW8GBMJDiA+lcAZME3AyJQLRvOhAz6u21MyI9u94ZwnSEiAnr0JOq78VgLmyHqTA65HaTxDn90arXp0Jx8Qod7bOTjJ5G8RM0seSHJ+B80ZS2DHfGhfOCJj8oPB38/e53uQUUhiuyXZqbYewc9dy5NAN53OKPdr+PEUupZoNCJ74cEsCE7BHevzuSHjp7ETfXdoMhISgWOZq52bzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG3+Rz4bQPB53ZC95xi29QGlGl1yPD83jDPVZvezCM4=;
 b=p1+JgQeNgu3DCvZrrAvMzjdJSXZDto0f6PvpvAPHNQGCHpGniHAQdDI4CZPCZ0zMqsHHoSOqGd9lnUd4M/169QJU9SSnw7D6cPk737RUCyEuEbjy7f5/Vch/ZXHa/EExcEfYF/V2dxtP0Q60HuNr8MPOgakDwMRRy6kzzRGJ2rthUcmDGGp/dzMTk5aFI0Ku8U4qVxu07pLvKHemuHt70I00P9h3DwgXT+Zrl1e+t0A2lP/jiTdjTS6v/diyy5neZBwxX1yUDiQpaBB770WI5tfEgbkxiuJm5GmLC0ccPNPRGpOkKbXi8RdB6nY7LzcIGZbeVNvSEwQ5+sglPvxZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG3+Rz4bQPB53ZC95xi29QGlGl1yPD83jDPVZvezCM4=;
 b=qtmQD2tcI6k4sEKffFRhMiyFKZu0eTUs4esOOZGG0DFAzyK0fvCBLK7Lqm1QD3YJi8ZxKmRTAbpekLXdC5H7e6AS0WOmh9QYCH5nf/+Wjcet+XfZouJX+AWJS3Ujo2mWSvgg2OfoMlvtRpC0yufrYcsxwimrzaTlt80rBw0fI2o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7153.namprd10.prod.outlook.com (2603:10b6:8:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 22:05:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 22:05:37 +0000
Message-ID: <aa58ba20-d250-43d9-9e1c-0dccd3511fb4@oracle.com>
Date: Wed, 11 Dec 2024 17:05:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/19] migration: cpr-transfer mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-15-git-send-email-steven.sistare@oracle.com>
 <87ikrr67w4.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ikrr67w4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:408:d4::36) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c418826-a485-437b-0995-08dd1a2ff183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1BqQUlnOFMwaGZyZ0NEV3d6RUI4QURSM2pRdGFxL3pxcVdEVHZqRGpBd3Nj?=
 =?utf-8?B?NTBuL2pkT25SaUI2blF0SGVmR2pDMmpBWmhaTDZrTUdUWmZtajV3NVpML1pw?=
 =?utf-8?B?SHRvU20yV3FmRzJTL3J0cUpqNUJGZ3ZQK1B3TlRPaGJoMnBDMDNPdU9sTXg5?=
 =?utf-8?B?UWVpeTlpbXB3TXJwREcxNEN1S3lVK3dWNFJLa2VsUTBPUUZZcllRVklmd2Z4?=
 =?utf-8?B?V3NmM1FCMUdneVdkc2RUbXZZSTBNQTNWZ0pHVFQxRnBhMmVBVnFaTkRFWVFH?=
 =?utf-8?B?bEwweHU0bzRoUVFlaithQ0NmQjRpclR6VDRScE02WjVJMWE1RHNnN1VRM29O?=
 =?utf-8?B?azBXazZWNEZFUlB2QnYzL2lZWmJ6NE96RnJZbFhrVkZ3MC81cFcyZFIxTjVY?=
 =?utf-8?B?NzJHKys4endTamtzRGtLVUxoeDc0cHNEMlljRHQyRXdlMlJBZ1QreUlPR21F?=
 =?utf-8?B?cTJwNCtsSUkxc21KZjBKeWVXb29DZkdGc0dDMlZoZHNpZEJ3WVJxeTk4NERB?=
 =?utf-8?B?SlJlUCtGMUJXclpRVi9XZmFtMEFtTVFFR3M5MHZsUm9Vc1ZXQkZrVmhEdXoy?=
 =?utf-8?B?WUkrdlVBOTNzM0RYWUx2djJVUm1ieWJIbGlTRmNSNUFicFoxcXlhZmNpV3dD?=
 =?utf-8?B?WnRmWTUxSFVlQTE3RmEwOFZrUjBBR2tkcEJ5UXA2RDBaUUNBNlNxTENaOGJu?=
 =?utf-8?B?aDlWNStNTStsVTRDaS90bEdEQmRQVk1RQ3B5c1I4dG9tbDNyOEhRRjIxZG1P?=
 =?utf-8?B?TzJiUGsyUHZFVlRJU2RFNzVkbHJkakZNQ1ZXa0huelBqcGdvMkRXckdYeS90?=
 =?utf-8?B?b3VGTkhBUURFYVYza3JkMXhSek9BYzlOQ1R5OERhVDJkeis5djk4c0lBa0dl?=
 =?utf-8?B?bFNhbWlaYjVJZHF6aFVXaGUyYXdCSEhGUEpvb2JFRC9kT1N4RU54Z1picHZs?=
 =?utf-8?B?SnlqenVTSkoyZGdTcmo2VVlKejdoSXg4aXROV1JKdFFFc2RQQXpBN1dmdktZ?=
 =?utf-8?B?eTVXaXo4MzBNSU9CeEh5eVNsUDV5MTFJV3g4VFJmU0x4VHBTRE1xSEJ4Y3ds?=
 =?utf-8?B?eW1GN3BPYXRPNUFESjJZSnE5MjQzWkhOSEhVQkZLZEhITVNXRlZKZWJDazYw?=
 =?utf-8?B?Um5tdHduTkQ3QnJYKzZCQjB2TDRkNUlmUHlaek1kZEN3MklqQ3RiYVNua05V?=
 =?utf-8?B?MWlmai82bTBFb3QwcC9veWVXQ3ROMHAwRkxZbEx4NEFZajk1WEdyckViM0dJ?=
 =?utf-8?B?dVlVSHFsaUpCbVlOZEpNNWNmS3dwelhnbmdjdE0vRzV5amRlcVpwSmhVQ1ZB?=
 =?utf-8?B?VWRHcGthV0kreGFhSjB2VmlhVktVS1F6N0ljbXBGNUtkVForaHhyTElXNGdJ?=
 =?utf-8?B?NUFwQ3Y4VExqK29IdVhQNVgrMHMvSm12anNLbEFTV01wR0JTZENyZW4rMGVV?=
 =?utf-8?B?Y3BkK1k1NVlETXZvQWF3bGtsSXZpdmVkTlpaRFMrSWRCK3B0blpSS3JLTTZa?=
 =?utf-8?B?cjBheERIUkF3dldXMjNNR2VseERQNk0wWnBlMkxHMlVnR2ZGMzRmU3Qycit6?=
 =?utf-8?B?eDF3MThDeEdrUkdaR1NFd2lGZUJmOGdjUFRlU21NL3JkOStYS3dsOHpvcGNv?=
 =?utf-8?B?bnNvbjkzZUVxbGh1RTFSSHZ4Tm9qaW5vUkxCc3E5cHBwcVlzU1lrYUtPVUZn?=
 =?utf-8?B?MFJzajBUZlorS3lXTkFIcnhWaGUwSVlzTkNuL1Z5cy8zSFZROVdObG0yM3k4?=
 =?utf-8?B?VmZzRmd6R01BWUxjNHl4a00vQmgwb1dCSTBSNWlFUk84dGV5SDFHYWtOMzRu?=
 =?utf-8?B?MDVhaUlNbU5GN2NvRWZTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9MbjV0ZFNWUGlEVU94eXArbndDbThqNHFab0ZwL2p3NzdaUldhNUUxc2xO?=
 =?utf-8?B?UDZWTjFaOUJaV2I0MHNPcVI4Z0hFZHprL2FGaU4vVVY3TmVHSHVBMzlaS3di?=
 =?utf-8?B?YytjNk5kNWw5TmlWa3QzM2tiakk5elk4M0pUcjJUR21YZSs1VVRxWG01V2lU?=
 =?utf-8?B?NlBtN3VnbWgyN05RN0FEeGw5enQ3OGlQbVJMRW11QlcwSjZNYTVLY0RwaWZD?=
 =?utf-8?B?Y0ZKbnpiU0VaZkVvNTNXT3gvQnp1eVB0TFhPRmpueU00VzRJZkQ1NUF5Tmc0?=
 =?utf-8?B?WlVzL1QrWG16T016MHpKR2EyTFdoUkdOSWRMMUZ2OVlkT3N2alYxeGVMbVNQ?=
 =?utf-8?B?WWROTGx2QjJVTFVENXpmUmxRZFQ0T2VMbFNmOEsxZFpFQUQ3cU1FZzJRNWpH?=
 =?utf-8?B?NWRJdU1ockJnd0k3RW9MS1pMWm1Vbm1jOWtuRFFDallUK1c4b1RnVU1IQnYv?=
 =?utf-8?B?dmxkRmRRR1F5dVVyeVFTWElOYjcrWmF2Mkl5VW1uVVZmYVRmdTNaTTFHNlFL?=
 =?utf-8?B?QWNvUEVaT3J2V2N4ZjYwRUVMZUpGb3V0L2cxYllINzdURjFScWVXQm83WDNB?=
 =?utf-8?B?UzNsSzlkZnF4UlhPSnJILzdYdFRsYmpFZDc0TmxEMGZCRFFNaXg5RTRGQ2FH?=
 =?utf-8?B?V05IZSsxT21pZGdEU1ZJbW5jVlBPVXFzdGQ3MG9VdGR1M2VJbEpjM3dKVFZy?=
 =?utf-8?B?YklrYjRvaUtzOTN4K3lGdnB0QU9QQi81aW5VczNhWWZTZUxnTlZOdmw5U0FQ?=
 =?utf-8?B?UGZ1bDVLOXc0Sk1tREFSaFVkTmltYWJ3R1oxa1VLNUYyb3pKUVU5dUZ4WTZm?=
 =?utf-8?B?dEVLaHQwdHhvd2RBOEljNzNmZXR6SUxhS1RqaWpVWVVxQlpYVzgrdjdlaDV2?=
 =?utf-8?B?Y2o2TkoxZll6NGQ1YjVPSXNoNkNOSUhqSFFxNXdkUGsyeFBiMHpEUC8rakFr?=
 =?utf-8?B?VjJrU3M1U1Q4OW10bHVnWGZYMWhqSTJUbFRZZ0w3WGFjWWxxYU5RSTlCalBi?=
 =?utf-8?B?TXJMMzlhQVlBTDBYMW5NYXNZY3ZlTjlhTEg1aEV6VlZMQmdvdHdEdHl4K3FB?=
 =?utf-8?B?OW1vblM2cWExWURpNE5EVnQzbEdTc2NDSnE4endxWVJqRjM1aG9PR2d3d3JN?=
 =?utf-8?B?U2VXWXZNcDA4KzI2aWlLSzdXNEZweElQZzlGaXZsbGxFZUpmZTVwQW9iQXQ1?=
 =?utf-8?B?WVdpeXVDTWVpdlVxQzIzNXphbXZ2YnpHeFJHbTF5YWVtc1pVekhwVzRsSnBO?=
 =?utf-8?B?V1VDZHZtbjd6SUhabmZYL1YyL3lMRHBweFVIcG93NWEwbUI0YWtZTWtnNndM?=
 =?utf-8?B?aFMwUWgxSmNBdllTZnUrUHZWODVFOUQyaVZpaWg4S1hSUllPL2dXYkU1WCtn?=
 =?utf-8?B?akpRQlVIRHF4dXJmWUJ6MXpYaDYzYWV5M0JRZ0NSamxndDBMdnhhZ2FPeVhB?=
 =?utf-8?B?ZlNpMEs1aUR1VVd3ZGVoSmNGYlVxWkkwTnZ4em4vZUtZdjBOeUI0K3c1OGln?=
 =?utf-8?B?VXlkQlBsQ2F3WVRzbCtJaWpzbElsdzByVFpyeEF0N0MvL21JRkYyQjZIOHpn?=
 =?utf-8?B?SmpPVm9zdEFxSlpKTFdFbHgxdGswNmVCZ0Z6Q2MveVdZVGQwZ1h5VGgrV2o0?=
 =?utf-8?B?LzZ4NE5sdU9KeTZMcG9ISksyck5kYTF3VFI3UmNqWG5BVlFTb3RESVpLZnMr?=
 =?utf-8?B?amgwbmh3elN0S2NYUG1DTDRnbXlrT3lRMi90cFF0ZUUxQ1hxaFVOSFZMWUNB?=
 =?utf-8?B?aklJcG45cmlrR3hWZEh1UmNCRmpnQWZTd3BYWTVNMDl0NkRRcTVLS25yRlZa?=
 =?utf-8?B?ZlU4d0hrWW1iNEV0dU1YVlJvclRjYVBjN1Z2OENxQjN0QzdLS1FaSExiMlR0?=
 =?utf-8?B?bXlCSm1MNVdQWVJuYURLeTR1MG1ERitQY1IrNlRRK1hKMW9EVktHRk1SdlFp?=
 =?utf-8?B?Uld4K2pXVUtwbU1EaXFLMkt3NG5EZ3Q4S2tiRG04YU1YOGdmQWx2K1NKWXF2?=
 =?utf-8?B?MlBIWFpINVhhMmsvSXZmQlRoZkNmTlFrUTVyYjlIenZVMWJqWVB1R1M4ZUlF?=
 =?utf-8?B?ZVFDeVFaRzdjOTMyd1ptM243ZUFZclVpdDlBL1o4cndoOUladzlLOEdqL0Zm?=
 =?utf-8?B?cHFzVlVHZDdQa00wU216Zkd3d1hqeTU0bEhtSTdEanpscVFuK2pmazR3VUh4?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q0ZUKZWxqOarCH9Hmbfa1aHYUDZ3HAlzyzuPOv7JSJM4qh78AH9tb7Ce8x47XdSocKiq3ZZy7RiQBf2jkjsJXk1LAaWPWhwigVwUQWUutOhlErBTfK+1iJaFWxc0sYZfC0x8I8NEhUwvvY683vlMDh0K81cUZewI5aDj7ucwcfa2if/fllddPN+INhGg5hL657gJhAyxPb/1YuD/YEh7B5npinlku3hOzYMerp9bjRHRCRb+/e4g+svYMLw62Hr/pn0gZQ/ZqWQ1VAQI3MWc9Bb/sClK3SdqIIctyFPGET3F/qymeY77LbBS8yMH8/le9RBhDLtMP7AZVL/5dRkY10XvYOkVOakHDPKA4TgRIsVjD5uNi0sD89oWZIF/HW5NI7K9lWU6WTtY/IK/fPopvY/hg0H4pKiiuLLWszA+u9v+hVLtzuYQLYjBZ/BsakzMsOJB4+gRf1mPXvhKwf17Ggok6flffScdWAUvxhLm7RA8YK0e4Z5qiZJxWMz51YfMv1ikpxtaW297/SOIq0rwO7bjnbosK8c59tBrt37bxw/m/XYBmxI16YvEtdNFRzFvmds0nOAwzoKVjg5SNOt/t8lDJNSydii2Ajq9UFMQR0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c418826-a485-437b-0995-08dd1a2ff183
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 22:05:37.5848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mor0ZP6AdPGn7Z0K9D170xhi6FSXA7Itq+BXOgerQeQGjOL8movlXx/qVN3QIBil9YZenDE51rBc9fENXsl7kxS1Z2PJRQ2Ts222AdGZ5pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_11,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412110155
X-Proofpoint-GUID: gtDOHLApSUU1mtV1jwQbRowkDRQT1hy1
X-Proofpoint-ORIG-GUID: gtDOHLApSUU1mtV1jwQbRowkDRQT1hy1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/10/2024 7:26 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the cpr-transfer migration mode.  Usage:
>>
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>
>>    start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>
>>    Issue commands to old QEMU:
>>      migrate_set_parameter mode cpr-transfer
>>
>>      {"execute": "migrate", ...
>>          {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
> 
> Much technical detail here that won't make sense to the reader until
> further down, but next to nothing on what the thing actually
> accomplishes.  Makes the commit message unnecessarily hard to
> understand.  But please read on.
> 
>> The migrate command stops the VM, saves CPR state to cpr-channel, saves
>> normal migration state to main-uri, and old QEMU enters the postmigrate
>> state.  The user starts new QEMU on the same host as old QEMU, with the
>> same arguments as old QEMU,
> 
> Any additional requirements over traditional migration?
> 
> There, "same arguments" is sufficient, but not necessary.  For instance,
> changing certain backends is quite possible.

No additional requirements over traditional migration.
AFAIK there is no user documentation on what arguments must be specified
to new QEMU during a migration.  No words about "same arguments", or even
"same VM".  I am trying to give some guidance where none currently exists,
in this commit message and in QAPI for CPR.

Perhaps this is better:
   The user starts new QEMU on the same host as old QEMU, with command-line
   arguments to create the same machine, plus the -incoming option for the
   main migration channel, like normal live migration.  In addition, the
   user adds a second -incoming option with channel type "cpr", which matches
   the cpr channel of the migrate command issued to old QEMU.

>>                              plus two -incoming options.
> 
> Two -incoming options to define two migration channels, the traditional
> one of MigrationChannelType "main", and an another one of
> MigrationChannelType "cpr"?

Yes.  I will elaborate.

>>                                                           Guest RAM is
>> preserved in place, albeit with new virtual addresses in new QEMU.
>>
>> This mode requires a second migration channel of type "cpr", in the
>> channel arguments on the outgoing side, and in a second -incoming
>> command-line parameter on the incoming side.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started with
>> the '-machine aux-ram-share=on' option, which allows anonymous
>> memory to be transferred in place to the new process.  The memfds
>> are kept open by sending the descriptors to new QEMU via the CPR
>> channel, which must support SCM_RIGHTS, and they are mmap'd in new QEMU.
>>
>> The implementation splits qmp_migrate into start and finish functions.
>> Start sends CPR state to new QEMU, which responds by closing the CPR
>> channel.  Old QEMU detects the HUP then calls finish, which connects
>> the main migration channel.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I'd lead with a brief explanation of the feature and its benefits.
> Could steam from the cover letter like this:
> 
>    New migration mode cpr-transfer mode enables transferring a guest to a
>    new QEMU instance on the same host with minimal guest pause time, by
>    preserving guest RAM in place, albeit with new virtual addresses in
>    new QEMU, and by preserving device file descriptors.
> 
> Then talk about required special setup.  I see aux-ram-share=on.
> Anything else?  Any differences between source and destination QEMU
> there?
> 
> Then talk about the two channels.  First what they do, second how to
> create their destination end with -incoming, third how to create their
> source end with "migrate".
> 
> Finally mention whatever technical detail you believe needs mentioning
> here.

I'll work on it.

> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index a26960b..1bc963f 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -614,9 +614,44 @@
>>   #     or COLO.
>>   #
>>   #     (since 8.2)
>> +#
>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>> +#     new QEMU instance on the same host with minimal guest pause
>> +#     time, by preserving guest RAM in place, albeit with new virtual
>> +#     addresses in new QEMU.
>> +#
>> +#     The user starts new QEMU on the same host as old QEMU, with the
>> +#     the same arguments as old QEMU, plus the -incoming option.
> 
> Two of them?

Yes, I will say more.

>> +#                                                                 The
>> +#     user issues the migrate command to old QEMU, which stops the VM,
>> +#     saves state to the migration channels, and enters the
>> +#     postmigrate state.  Execution resumes in new QEMU.
> 
> The commit message also mentions file descriptors are migrared over.
> Worth mentioning here, too?

IMO no.  The user cannot observe that aspect, so they don't need to know.
It's an implementation detail.

>> +#
>> +#     This mode requires a second migration channel type "cpr" in the
>> +#     channel arguments on the outgoing side.  The channel must be a
>> +#     type, such as unix socket, that supports SCM_RIGHTS.  However,
> 
> This is vague.  Would anything but a UNIX domain socket work?

I debated what to say here. One could specify an "exec" type, in which the
executed command creates a unix domain socket.  However, that is only likely to
occur to a small fraction of clever users.  I could simplify the description,
and let the clever ones realize they can fudge it using exec.

> Applies to both source and destination end?

Yes.  It is generally understood that the same specification for a migration
channel applies to both ends.  But not documented anywhere AFAIK.  And again a
clever user could specify a socket URI on one side and an exec URI on the
other whose command connects to the socket.  All true for normal migration.

>> +#     the cpr channel cannot be added to the list of channels for a
>> +#     migrate-incoming command, because it must be read before new
>> +#     QEMU opens a monitor.
> 
> Ugh!  Remind me, why is that the case?

The cpr channel (containing preserved file descriptors) must be read before
objects are initialized, which occurs before the monitor is opened.

>> +#                            Instead, the user passes the channel as a
>> +#     second -incoming command-line argument to new QEMU using JSON
>> +#     syntax.
>> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine aux-ram-share=on' option.
> 
> What happens when the conditions aren't met?  migrate command fails
> with a useful error message?

Yes, via a migration blocker.

>> +#
>> +#     The incoming migration channel cannot be a file type, and for
>> +#     the tcp type, the port cannot be 0 (meaning dynamically choose
>> +#     a port).
> 
> Which of the two channels are you discussing?

main.  I will clarify.

>> +#
>> +#     When using -incoming defer, you must issue the migrate command
>> +#     to old QEMU before issuing any monitor commands to new QEMU.
> 
> I'm confused.  Not even qmp_capabilities?  Why?

Because of the ordering dependency.  Must load CPR state fd's, before device initialization,
which occurs before monitor initialization.  The migrate command sends CPR fds which releases
all the above.

- Steve

>> +#     However, new QEMU does not open and read the migration stream
>> +#     until you issue the migrate incoming command.
>> +#
>> +#     (since 10.0)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>>   
>>   ##
>>   # @ZeroPageDetection:
> 
> [...]
> 


