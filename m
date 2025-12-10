Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FBED3C92B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTNTt-0006V4-Ui; Wed, 10 Dec 2025 11:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vTNTp-0006UR-PQ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:55:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vTNTm-0000NS-3d
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:55:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BAGOwXG3577204; Wed, 10 Dec 2025 16:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=PfwQYORTxzHclNSVi2F6hegsmQMPc4nCX06mWPlZfQA=; b=
 Y8sK0aEdKoEsTz2Z/GwOiq8islpaD2uzU4dgVa+jlk6F2LL3PKTiDNd3yqS0BoCL
 L9gSrDYUixqvnMdpaBsMETTNXpxcuMyQNMNaOAbl1SkObUgrFoYztAIickPfpQ1u
 KNAUKXsWKgFebBy8F9ugAVxusZzAB4fK1Ngrb2qvOgMI87JUo/I/88VdIRFKedKu
 YW8EtsVFU+7bygjpUZxWNczdHuD9DYOcj0vCinUG3pHQs4PYSxDauNd5ISJqnAQU
 CxrIogQEgIy0j1UHWjAPWt1p6oWjpM+TiYM4uvYEte1RpJBqU08d1ksI31CdXkUY
 vaQaE1UmtZib4KGD82MnJg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycc1r1y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 16:55:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5BAGb6AY017467; Wed, 10 Dec 2025 16:55:48 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4avaxahev3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 16:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7pNqylqr4BaBRrFmu50rcHjkXnkhOm6XOMMQhEtLHYQXcxi7Be1qdFoldwOaK7yvJW4zZ1TWZUq61LOMLpL9Jq+Sj9xINUecitzsjGfVXKsneoe0AIaM6lFSUyHzK1nREzR2+DfHChuNphG6nxQS+pF6gc25Z3lcuZkrYsNhRmJ07SE2YajQnC+SV9kQjjjVt3eXbGCThb7OAmHorUsykoV9bGb9Q1syYtaAwiOFCpB0fhROzh/8VZQjfL6jU99UrrFjbgXFXFMG+f5iwraiueNTXAKZe+M5Sgvljis53uX3b4F53m/Mrviaeh7Gks+h5dMKPPVLFuo1SkGtrx8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfwQYORTxzHclNSVi2F6hegsmQMPc4nCX06mWPlZfQA=;
 b=XmW5HFEk1rqLh/sCT3s/XB4jEy6rQhK62OTo/Hs07G9iy2BfEd4b3FpCsZmglvZoGDSbP/x4gYq9R1s3BlPFCK0lVX/Um9evFds18NfGGPgedUKohT6FMPvO5KP/zGhIZEWPvjM9eeBtMNZxGftEk9PVNeh7a6q2VBaoKs7sXVex0aNWw2hFvyJtmUP/m7+5wDK6e2lpyWoFC8tvYeqI6CcVB271jPg7P/k4vpcGyO+a4OnXLcX9DEcfsyZoRz0ZfQDisc8avTu84ejEGA8TFjMsyJFL8Dg0gykwckLvYeCYxaqfNup1gSGtSkU2NTWYURR+9c/NDpsb9j3ca6JEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfwQYORTxzHclNSVi2F6hegsmQMPc4nCX06mWPlZfQA=;
 b=h1baAmBE1glmxqepf1TvoNc2xgTts4O8kCk1XsAvBBdYnlKjYtxJBt4wseCXpPsrHXQZWG9R7ADdxzgXwQ3tXhuY7cA2qcE9eoBUZPcwe/Rktm12wITk1uHfKBWSddbU5i/DpvDz80C+lQCn6OnClmcrCLOSJf1aSn+89McvIQ0=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CY5PR10MB6094.namprd10.prod.outlook.com (2603:10b6:930:39::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 16:55:45 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::b33b:40ac:22e3:1de]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::b33b:40ac:22e3:1de%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 16:55:45 +0000
Message-ID: <2929f151-0f5e-40c0-ab76-632649f328a7@oracle.com>
Date: Wed, 10 Dec 2025 17:55:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-scsi: Make max_target value configurable
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Mike Christie <michael.christie@oracle.com>
References: <cover.1763999544.git.karolina.stolarek@oracle.com>
 <dcb4ca40497dd88f27b345c708402885abdad776.1763999544.git.karolina.stolarek@oracle.com>
 <87h5u1hye5.fsf@draig.linaro.org>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87h5u1hye5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CY5PR10MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fe8315-c422-4f90-4975-08de380cf615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFpvTGpwalNvZUZKelNsdnpnRk5jeFRDUzVoZW00em5TMnBoYUdiRUtqTTlG?=
 =?utf-8?B?Tm9RWEFQWEh4Ri9DUVRyZ0UxRjBiV3dJQnBURFVqVjBvaFN0SFcwellBZGpa?=
 =?utf-8?B?c2R2RzJNWXRmUUVUVjlVNEpDSmZpaS9SVUxBYzlreGozVE9wNkY4NTRUUWFu?=
 =?utf-8?B?RGNyMDh4TEZMNFBDenUvYXF6M1dtbGVBR2N2OFZVZ3E0MTMxSXBSeTNHY0o4?=
 =?utf-8?B?akYyWmVSaUZQRXFvTkZPeS81dFBoTVJrTW1OYjgzWjBpR1lVbzBGMitOTUdE?=
 =?utf-8?B?b1BNbHdhWGZ0VXRlYnJuaE1rTERLUEVwcEtuWmRyeHkwRWpsWE5kdDNMOWFX?=
 =?utf-8?B?N2pYMVlpZ0ZnSmFrSlZtdWJDNnkvcmNSdzAxOEdhSHlOdEE4QkV0aHpSS29p?=
 =?utf-8?B?N0dnUFRNUms1MXhBQjl4eFh4VnA5QlQxN2RPdEJOcWx3cElVSWdiYVJBeXJt?=
 =?utf-8?B?eWMxS24reWJhdlpmZ0FXWnJrSUR3WFdhV00yRS9LQ0JHMzJNYXd2N3pHdkMv?=
 =?utf-8?B?OTUzd1ByOFZsZU1yUWI1emFZNEFBRmRMS05qVjYrci8rb1Y2VEduZkNDMHgy?=
 =?utf-8?B?L21zQmRoRU1SaGVrQnNYaHgwRlovL0ptSVRIT2Zpa2EwOU40OWQyM0YvRDlC?=
 =?utf-8?B?cmorbXlNam1taHJWREkyd2V4bEFnVGJ0R0V5cjIyNjFjZmZZa25JeUk1dzM2?=
 =?utf-8?B?N0lybnhSSVFPeWFFMEV4QTR2M3ZUaElheUxWUmZvK3EvekhLUmRxeDFkNkZV?=
 =?utf-8?B?SFdldnhNbTVHWnFLNWt6SE5BNWQzSk5zd1JPdjI0dnF1TGM1aE9LVUhWb1U0?=
 =?utf-8?B?NnFJbWd4aVQ3MVBLa3RQQTQvWDNHN1YzU000Nkw4ZlIxbjB0WlJwNjgxcUpy?=
 =?utf-8?B?bHZsVEJrUzNpMC9tY05LVHcxdmRRQ01OYUpnTjNQWVdPTFlyNTBiTXlhbnBx?=
 =?utf-8?B?V2l6RFhsM25tOGw2MHByM1pqUE56L01LcDlZZTY4TkxQYWlKZDU5RGpPMm1m?=
 =?utf-8?B?RDB1Y3BPSnFpVDU0c2V2SUxwbU1YTi9VQVFHanpvZHU4VlBYT0J5QjkyVUlM?=
 =?utf-8?B?cDNpSWx5QTdyU0ZwcmxhYmhTUW02LzBHeU92eW04dEpoTWliL2NVUzRqRkY3?=
 =?utf-8?B?NjA3L3VhUnFQdjBabFdHTko0UlJhWU5pQWQ2b3BFMjdNOWZWcWhmNUREOWFO?=
 =?utf-8?B?b1ZLdTZLbHlQck1laUxiZ0V0L3loeHhTV1FUTm5SWHd4NmxFcmZQRThJY2lW?=
 =?utf-8?B?MVZ2aXNVbndRdkZZV0FFUHhwbUxndlFmTkpabnRiRmZrNmJySVU1QTZmYzha?=
 =?utf-8?B?UVZGSE94Z2pFWHhEUUJ3ZlFDSzhlcURicldMQlNGaWFiamZtZWFoTWo2N1dC?=
 =?utf-8?B?NEdURmw2bDJkckNUR0RKUVcyaGcySzVMTVJUNVRuOFJlR2ZCL1YwTVpWUjVv?=
 =?utf-8?B?THJESkNXOUdTWTFHcFh4TURKdVFlbHRvcW8rVGFCRDd6Yjg0czY4ajRuZlVo?=
 =?utf-8?B?UmJTUnNJWm1GeE1UYjQ0SkNaM3JnNEdmcktEaUhLM0Z3b2QrUTZaUU1EN0pC?=
 =?utf-8?B?NXhKdDBjWXVjY0wxOTc2VlVsdlY4RkpzR2ROYXh0RjN2bkFtZnFFMmtkdWMv?=
 =?utf-8?B?MmRQNkhRQkpUZ3NDU0ZDOXpUQ1hLUlIwMVEvVUE0aThydGpxRUJFRkV6OTQ2?=
 =?utf-8?B?SXJPYy8rMzJ0bmNYM1ZicHJFYkYxVlZpL3p1Y1dOU1JRZlZsMzJzVk1OcXNQ?=
 =?utf-8?B?L2RoOUtZS2FJbHZ0UUxmZmN4WmplL2MrNmJ2L0MvV3Z5c3NrOHhZWUpBaXZP?=
 =?utf-8?B?WHkzaFhZVXpzUjhmZ3pvWkFlQy9sbDlGSW9mOFhyYUUwTGM1czhleVRmbmQz?=
 =?utf-8?B?UGQranJJRnlJTHVzSGkxVDBEdXJZM09Fc2tYL2tQRkdLVGx6SlNpaS9td1pT?=
 =?utf-8?Q?H+wUmrM5b188qu9PCwIls1PpjzsaGMeo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR10MB5396.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGcyS0daSGZYTWU5Y0FnTit4S3hjSlV2dW82cGFaL3NiVGJiNXp2SUI2dENt?=
 =?utf-8?B?ckNTRDFtVGpjc0JYMjFhQ1RLUzQ3eFBFN1NZTHpaZy9PeUtmWHRhWmJYWkFG?=
 =?utf-8?B?OElBT3hTTEdJdTVPVWdzVDNDekZqRlhuTE9mUnRabEIyb0x4UHY4VFBlKzZz?=
 =?utf-8?B?RnJVTDBhTHA1TTdxeDM2cTV3VWgyRk05MkZPMGFUUjdqZFlhMDhPOVZoVkFD?=
 =?utf-8?B?VEZlNFdCcTBRQ2QyRlYrejkyZG8yRmZDbWVJczNibmNLN1pIYVBKcEFpVEUy?=
 =?utf-8?B?eE5CcDlkOHZWMFNqZVBRU2N3T3NkSFRtc3FtYmZFV005bXdHVTY0cnFRSkQr?=
 =?utf-8?B?T0pabHVYRHZqRFRodks0dFN2ZkNTTDRQcFJLWk0wYjRieEtpZ0tHd1F0UUZZ?=
 =?utf-8?B?cjE0UnJ1bHdWNnBqWUFiVGFIV2UzTHJkcWp1bVllZEl5N2tMcjNJZ2RSem5G?=
 =?utf-8?B?T1FCczVuK2FkcE1pOW5RakNWU0FKSWFEWEFQaFptL1RXUEw1YWlra09yZzZC?=
 =?utf-8?B?djdiZWdla1I0bDlBN3hHc1hQamd3WCt3eXp1dlAyUUVIcFk4azRrMmpQbUVl?=
 =?utf-8?B?UlNQUWVaV0dHNTFiZ2R2M1lXRVNRWktPbjJyT3VYZ2pFZjRFakdWaGg5VStV?=
 =?utf-8?B?cVB4dVNzWDhFWmIzaVlmaVBMcXdrNDU1SzVXM1U3VDVZNERMZVUxTzl5eFNI?=
 =?utf-8?B?bFlkY0tOelNyUGVpVW9HazlvRjQ1OXl6bDVtdy9wSjhKMlhuQjRaRmdaR05L?=
 =?utf-8?B?SjQwMjNVS0JMbkRaMUJOUkpJQTNFSmVZR0VvOHhMNSs1UDZjNG5NRUkxK3J4?=
 =?utf-8?B?Nng2REs0Y0tFUitiZWNBTEpEN245dkhyTnpUZktRZzFDY2VHVnEyUHlkNk1K?=
 =?utf-8?B?a2dYTnN3SktaVzIzb3NteG5VVGV6VUZReUxHVjR2a3V3Vy96MXJVZll0NUdr?=
 =?utf-8?B?bGs5Ym1aZXFaU1pnSkVDMTdWMzVEN0pvbmFLK2xwYlpaU3JMUjIyWkJtSDN3?=
 =?utf-8?B?OVVMVTZyUG4rSmVjaW4vSzNjSnFJbXAwSm9Gem9YaHhUb2NRUlZmRC9uV0Nx?=
 =?utf-8?B?Rm9kUEVuUm9vbFc2NDNyWitFOFhRNkh4TXJLRTRiaFR5dzZiVWplVDJVcW4r?=
 =?utf-8?B?a0xINXoxTEZnaVFDNUN1SVVieDNKOW9BYmlIeFg3Rzl6Q1Bib2x4WVVuejlw?=
 =?utf-8?B?bllEdU5wamZ3T3pFL2trTEdUV2JudXRJb05zNUdJQlcvR1pvQUp2VURSOWRy?=
 =?utf-8?B?dW41Z2dOUTZaZzErNTl2bThibC83a3RoaWsyRCtZNGxOMkVCV2VFY1Q0aTg1?=
 =?utf-8?B?U1IrZGU3NmZZeklmcVhVUFZlTzFEOUg3TUhUVjRBZWxrQlQwRlJ4dDJwREFE?=
 =?utf-8?B?UEt1b21UY2U5dVA3aUhwS09vS1NESGVCeUsxYXVRWUdvRGpXNndxenFQY3VJ?=
 =?utf-8?B?UTU5UG1oMlNpOVV4TUxZZDA5UHM5SXUvMG5YdE1FN3h2UlJXUm80bW5mRzZm?=
 =?utf-8?B?YnJxelZ0TytnUDgyTEliZlp6VFhtdUxvQ1VtKzliT1l6UjRRTGpiN2h0U3ln?=
 =?utf-8?B?aldqMUVpUVdobDlud0lvUlFZUVJBODhqK0JleXlVdjBNWTFmeUJPK09KN280?=
 =?utf-8?B?aklEM1RnOW5OMHY5VzdleUxKSnJpQ0FocmJ1Rno1NGpvZEllUitDUnBncklx?=
 =?utf-8?B?UFZEWnRWQTM3dmUrK2RCdkRCOTAybHZrWU9uSjI1UWFDd1h0SmhZckVxN1kr?=
 =?utf-8?B?YWcyQ24xOG5hL3EydHA1YzVoOTJJQWNvaGp1bXEzbW9lYnZDbDdSdzNnRjAw?=
 =?utf-8?B?SThmaHYyeFRkYjNYWGd0d3RXQXk4bU85ZW56WnZER0NFRzMxMnRsTE50UktI?=
 =?utf-8?B?TjN3cVUrNFQ2aWNpUStVK2lTYk9aMy8zZ1M4WUdZbVVOazk1TEVjdTVHRDBY?=
 =?utf-8?B?cUtLbjA3ekFWemN6aHYxV0lzRWl5a2FSUWo4M29tVWd1SVBBMEM3YUpnclFr?=
 =?utf-8?B?czNGVE1WWEtSOVllZjgyejNub1BpYy9pL0JZUFpNR2xGLzBxVUpUMVRabkJk?=
 =?utf-8?B?dXh3UTlkMGxKQ05aWkQ5RHkwRk00WnpOSHBXaE5nWjFiTmZkb0cyR1gvV1By?=
 =?utf-8?B?RlZ2dXZ1YWZDK0lBVHBKcjNzSzNLalBhZHRvMFBSRDBmaDNCdVRncnBYQVpH?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pDSczlDkbY9rvyothxmK5CbhoNXe1WTLURMxc+UCpDMbSqABzooXAp4bnVFrYO8VjPue6vxQr1gBJBLEWUPCW4r1thEINwD2wOXjVaZEDhZfd5uwD6TB2L4Fs4CTLtiOsIAljcUWZWDU1OIvMOHtArxvK30vfT8c7ZU30Tbtl+dB17QHnqjObyhlBNloSAJxAf0adBiCaLft/q9LtzTdu/zVfW49+NVZY/L5dpqVAVMkjvSk9GLrtsc5z1+0hXa6L9TrsDmpI0zmhQjgi1GxmgsAVl5s2l+6oKozOLN1Gg2Qc9jzE0s+qSspo3PYW9XVZp8zhbO/yE8JEz/slr93HeeZht7NszWY0QI5vFjMZBYG2ha/dekN5ELxnL4oSvbxS8Bowxjwi6bgeMLhbtm1jKSWCyh3qnFQLR0jQBoO1VvnBR1CJTEPaI3bi0+o6OFQL21fKSk+ZBRqOErjEl0QzUDXxkrOqZTqg8CDA9swUD5qmeymfJyk1dK/wtFTpTcmiBX0gRl4ftEfoMrQvjDRMy0b87TL6kKziSh4gfgyK/Cyi/4lfSgWrREm8R8ghylZsLttaNgMg2bDdTpwMm7Vixkb1NJMQbxYkxFszBj56QY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fe8315-c422-4f90-4975-08de380cf615
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:55:45.4989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMTvnHe6LSfa6t8JKavFpb/K3DdkkP4kRADSNfrqbvrYB2572+W8z89p/ZpFSNsUkCBL7hizK/8Hj/goiAHBwYjKHUiHuoze9FMX79UODnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDEzOCBTYWx0ZWRfX/YZKY8qZlqaf
 UFcH0Hz8vs4cM4sz2axIqsstfFJ6AjiHxGxGauZBhy0tiKFEbWUntuHo5VD1daXbgwSNxGy7TpI
 lPFmlwyVQVKM0tLyOS8eO87fsr1HJlN70bvN+AhUmlbnmv7+dNQ23Vs7gX2xWXD0Z8wDOWIKtUs
 O/nI/0dBTEZ2WMGWT8jJfqSkUpevP+WSqpghjIloazziDpJOff5DgLppkp9ZRlOHHneHzOVjII+
 LlYijcd7t72FddMHKBUdjNa+1kD/DdItRB9x+/hgVYna2Z9Tr/VjKlmmLSRU5aunTqKzftlVMk9
 vpGD7bLOcmf66wxQFGNatcP1xxj8kZZsjfdXBfebnXF640ZSSX3YMcTOtMI1CylYwofkA5xLtn6
 SpFV7Dwy81HDXDy4/KzWgHKPsZxnRg==
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=6939a615 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=L7d9th1ZF4LV-MdJEzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mLKc2oEDASzrnvYjxJ6m-6H1C8qlejTh
X-Proofpoint-GUID: mLKc2oEDASzrnvYjxJ6m-6H1C8qlejTh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 08/12/2025 14:54, Alex Bennée wrote:
> Karolina Stolarek <karolina.stolarek@oracle.com> writes:
> 
>> -static struct SCSIBusInfo virtio_scsi_scsi_info = {
>> -    .tcq = true,
>> -    .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
>> -    .max_target = VIRTIO_SCSI_MAX_TARGET,
>> -    .max_lun = VIRTIO_SCSI_MAX_LUN,
> 
> See bellow.
> 
>> -
>> -    .complete = virtio_scsi_command_complete,
>> -    .fail = virtio_scsi_command_failed,
>> -    .cancel = virtio_scsi_request_cancelled,
>> -    .change = virtio_scsi_change,
>> -    .parse_cdb = virtio_scsi_parse_cdb,
>> -    .get_sg_list = virtio_scsi_get_sg_list,
>> -    .save_request = virtio_scsi_save_request,
>> -    .load_request = virtio_scsi_load_request,
>> -    .drained_begin = virtio_scsi_drained_begin,
>> -    .drained_end = virtio_scsi_drained_end,
>> -};
>> +static struct SCSIBusInfo virtio_scsi_scsi_info;
>> +
> 
> We can't have a static structure here otherwise all the VirtIO scsi
> devices will share the same configuration.

Ah, that is true, it escaped me.

> 
>> +static void virtio_scsi_init_scsi_info(struct VirtIOSCSIConf *conf)
>> +{
>> +    virtio_scsi_scsi_info.tcq = true;
>> +    virtio_scsi_scsi_info.max_channel = VIRTIO_SCSI_MAX_CHANNEL;
>> +    virtio_scsi_scsi_info.max_lun = VIRTIO_SCSI_MAX_LUN;
>> +    virtio_scsi_scsi_info.max_target = conf->max_target;
> 
> I think we need to allocate a dynamic configuration block for this
> stuff. Although given we have ops and config mixed in this structure I
> suspect the cleaner option is to re-factor SCSIBusInfo into
> SCSIBusConfig and SCSIBusOps so you can keep the static around. But this
> would touch quite a bit of code.

I understand, that sounds like a better solution. It might take some 
time to finalize this, but I'd like to try it for v2.

Many thanks for your review, really appreciate it.

All the best,
Karolina

> 
>> +
>> +    virtio_scsi_scsi_info.complete = virtio_scsi_command_complete;
>> +    virtio_scsi_scsi_info.fail = virtio_scsi_command_failed;
>> +    virtio_scsi_scsi_info.cancel = virtio_scsi_request_cancelled;
>> +    virtio_scsi_scsi_info.change = virtio_scsi_change;
>> +    virtio_scsi_scsi_info.parse_cdb = virtio_scsi_parse_cdb;
>> +    virtio_scsi_scsi_info.get_sg_list = virtio_scsi_get_sg_list;
>> +    virtio_scsi_scsi_info.save_request = virtio_scsi_save_request;
>> +    virtio_scsi_scsi_info.load_request = virtio_scsi_load_request;
>> +    virtio_scsi_scsi_info.drained_begin = virtio_scsi_drained_begin;
>> +    virtio_scsi_scsi_info.drained_end = virtio_scsi_drained_end;
>> +}
>>   
>>   void virtio_scsi_common_realize(DeviceState *dev,
>>                                   VirtIOHandleOutput ctrl,
>> @@ -1289,6 +1292,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
>>       int i;
>>   
>>       virtio_init(vdev, VIRTIO_ID_SCSI, sizeof(VirtIOSCSIConfig));
>> +    virtio_scsi_init_scsi_info(&s->conf);
>>   
>>       if (s->conf.num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
>>           s->conf.num_queues = 1;
>> @@ -1379,6 +1383,8 @@ static const Property virtio_scsi_properties[] = {
>>                                            parent_obj.conf.virtqueue_size, 256),
>>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>>                         parent_obj.conf.seg_max_adjust, true),
>> +    DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
>> +                        VIRTIO_SCSI_MAX_TARGET),
>>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>>                                                     0xFFFF),
>>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
>> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
>> index b6028bb5cd..3998b241f6 100644
>> --- a/include/hw/virtio/virtio-scsi.h
>> +++ b/include/hw/virtio/virtio-scsi.h
>> @@ -54,6 +54,7 @@ struct VirtIOSCSIConf {
>>       uint32_t virtqueue_size;
>>       bool worker_per_virtqueue;
>>       bool seg_max_adjust;
>> +    uint16_t max_target;
>>       uint32_t max_sectors;
>>       uint32_t cmd_per_lun;
>>       char *vhostfd;
> 


