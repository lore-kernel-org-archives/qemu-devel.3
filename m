Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87098C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 19:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMXDm-00033R-Pr; Tue, 03 Jun 2025 15:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXDi-0002ys-G0
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:22:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXDf-0002Mh-Te
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:22:45 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553HXxRD001267;
 Tue, 3 Jun 2025 19:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uXiytwHq8OWQ+geQGHPTdoZ9PHDpHU9Lt6B/kHrzNk4=; b=
 nlbpqxqAC3ZwUVonrMQyTtKp6EgyML6vD//vLAckioTIhNcsmFE3XxQwVAEMT9y8
 5ThMMnfUeLKu+9SKL+taQ/U7yQeSTXrG2Fj5G8VtYpI07EYnkyCQrn7UieWS9+p8
 1feofWg9T3sclWVqCvh0EmrncnjRTAywhXzYVAhUPVI+lMEM76MYWDJVSfDHMErn
 ETzUBmdfVQ4EUDvoAO0/PDt3R2wLLmFTtMK1Ek41bHdNHmc68jRjLT1pNgeZPEQF
 7bKOlpfWbU5ZbIwNapTSdd442xdAH9wBCrWpZVgWhy8JImwCTwMqKZ8pQdbLY3sz
 xX5cDZ8LS9h8Lzbh5m9Qfw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8j2mx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:22:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553IFg4P040198; Tue, 3 Jun 2025 19:22:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7a35v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPDyXrJLWgiUwYhvl1XwjfOHo3R80WyANI3UCkLBt7+GyUK1LnB+dzAi/nk0fHxgTNNwRGCoZENIOP0JyA72z5o9PnHWJpN0nRQzLSLrTePpDl0L60SDvvBly9vcIypYDYaDIXoggGrJZuDsH/4Z0EpQlUda0k7n3pir6KsiTHAx0GdKUVbG/HBQZ2MHG32yVRBXqxHo9RQnixxVSO5IAN/bFYqsbYobS3G1DXhZpNdgzyKf01szKQbsqreSDvn3XCTTPWQdIVX9u6rRjw5XYf8sZRmOk6QtPqTHITsuN6Ew3PUzLeJyE1kL4AsAOa3nVzqnIQ79pk6cO2NKUbtlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXiytwHq8OWQ+geQGHPTdoZ9PHDpHU9Lt6B/kHrzNk4=;
 b=wTw+uYbrEIzH5zVXDOzte+ibF8Y6a+CqRExpGeOf0bvkHwvZO3s2/FhvRy7OxRP++rGrwuSmOVvewunVbEC4P/Ak+oNQNV75hezyHoC0ZxKPRzVFHEAmohxU+/Efk4Z7wlwydlBoGkq7h8s+nXFUT3+hQMqMAYeHi5Mu7dRZh5sO81pi0WHxcgW5gi6btimx7Yeaj/nd4dJWxue6baXvYtKfD/+zm88v27WQKJVpe8BQiEQ7l3f+xdrDlE1/i/BH840IZQQS5H+Vl1DTQFs0TJ5M3EIzqDg2IAXiEARPhMKijEXGIIZx1kLU7mwRZ2FbfqnL3FL1NXnj6QZR00/tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXiytwHq8OWQ+geQGHPTdoZ9PHDpHU9Lt6B/kHrzNk4=;
 b=uQWOQCivFSUKLuG0Pp0piVWurEayHZlSYH3jcgAaXKlI/95gM5f1rReTTqKhB+99V81dL3z+gfo9jdh/kfrdWO+u9EMPNEWNG06i0UDARoupVyC5X9riLuhTkh3zx9/u+tGvNMKImildxmt3WrqojnpJqzvmVdduuRrRQajTRzc=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA4PR10MB8254.namprd10.prod.outlook.com (2603:10b6:208:568::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 19:22:31 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 19:22:31 +0000
Message-ID: <a01e5c67-bc1a-4949-83e5-7c3dcd9ab46a@oracle.com>
Date: Tue, 3 Jun 2025 15:22:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] microvm: enable suspend
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528164203.2239-1-annie.li@oracle.com>
 <20250603150308.5d4ef10b@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20250603150308.5d4ef10b@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA4PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f8fc84-58f0-4724-1505-08dda2d3fc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG8ybnZIWnRWYVpyTmVqc2E4VUwyYVJzU255UFVSOFFaMHJwWTVjMzRFRXFB?=
 =?utf-8?B?enVxTFBkZW1ZZ013eW14TGFpSjFTeUFIVU8yWlVhUDJwWUpYQUJNd2FBbnp2?=
 =?utf-8?B?RmFyNHpLZkRsTUpWTUJhdHBDL2k0SzQ0UnhhVkg4TjJQbGN2ZElBbFcwSGNY?=
 =?utf-8?B?U1UxWjB2TXM0Z0lSSnNHek9uZFp1RXNwUit4TFVOQ2JSWVJ0bno0b3JNR3VK?=
 =?utf-8?B?T2tUUG9KK2dhQmFpV0VBT1FVTVhxZndqNTJuNG9Fc3VxZlN2TS90WmRmWGd5?=
 =?utf-8?B?RGFERXV4R01DbHVGcEp4S1daZC85dVRNWFd1Zzcyc3JoMU1YMndNaE5YQUU5?=
 =?utf-8?B?NGpBcDdPWWZINmcyMzBFbEdkTXF1eTRIRnNMT2VtbVB2akJRNEdSYlBHN1d6?=
 =?utf-8?B?R1lXMkZSTGxVcDFaZzBXQUE5eC9uWHhkRS9EbVdCR2syQXZqVFVTc1dzVFRz?=
 =?utf-8?B?SjAzU1RaYngycWhnTjR5QzNrdGVsVGliZE1TU3hYSGxqOE0rYlFkQ0VpOU5i?=
 =?utf-8?B?YUxQN3pFS3l0eUVBZ3VwS1FCQW4wR00wMHdNUWhkL290U2NYbkxFRWZIYXFU?=
 =?utf-8?B?VWdYaFRRUk45Rk1Fb0ZMKytKMzdyYTAxUzBLbW8yd1FvTlhtblY4dUQrOFk4?=
 =?utf-8?B?ZGUrKzBpMWNSV1RMYVNDb1YvQWo3Nnp4ZDc2R0lVN2JabENlOXJ2NHZZOWlE?=
 =?utf-8?B?SzhaSmdwMGpMU1JHbWx4VmRlYnRzRmp2K2dEdEY1VmxKM1k4cWE2Kzk2dWgr?=
 =?utf-8?B?YVY4SEoycmZ3SGYvYnRCNUxBMzFkYlEyYUdvVHVvYkN3TGgrUmovZnNDYXNi?=
 =?utf-8?B?N3dTQ3EySC9pdUxHejVkalhFWGV3YTgwMjUzaXJyY3RUODhCWVFScHVYdlVl?=
 =?utf-8?B?ZlVyREJoRloyY0U1S0FXQTlmTzBEOGQ2MFJBdGFIaThBb0tHVjhxRytScDN3?=
 =?utf-8?B?UWlyOHRQZnNIRXJIbUMvSC83YlQyL1pBMG1NRExCaXdNcVdqRVZpZitJVStF?=
 =?utf-8?B?OGcyN1kxRmdxR3RjeDZVQVVXYXNmU0NEeGxYSzZYRHg2VU5UWktRbkJTYkZQ?=
 =?utf-8?B?YjJmMjFIcmJWTEcvcFpkRVNQTy8rb1gzZHJMYnpZQ3Y3VFdtSTErSnE0Ky8r?=
 =?utf-8?B?bUFUL1R0WG83OUd2WWxBUWhlVmZycWZNNm03ditUMHVleXNnTUNXMUlGSDhY?=
 =?utf-8?B?amtNYjJ1WlBTRTFMODJDdDI2UWZsQzZDYUF3NWFpcHhSREM1WFhzaGJWSHhZ?=
 =?utf-8?B?RVMvWjIzalUrOHBwT0Q5d1JhdlYzZkJ4dlg3d01sb1hkWHYwY2xtMTQrUkM0?=
 =?utf-8?B?bERtc3o1dU9HVENPTkYxa2h4VjZyVmlYYU5ud0xzcWRTREpnUWdwT2RaSXBr?=
 =?utf-8?B?ZFlKUmR5YXkxaVVadTN1c3ZzMSthMXZaK1NJY0F1SEVTUk5VelBBYlJJUmdm?=
 =?utf-8?B?WWk0aUdYbU1SWDRyWmlCRzBUMkJIWmRITnNMN2RrZitJVDNEVjZKT3Q2VU9H?=
 =?utf-8?B?WFZiVkxxdWZHNkRuNUlqakhXeFp6aFo2T1VxdkRCejFES2dWNnkvdWppVFdu?=
 =?utf-8?B?d21qWUZGWGh1WWh4dlo5WFZvOGR1S1NFMWJRS0hyTHZtM0xFNEVhZlZsWk1t?=
 =?utf-8?B?dnhHeEFxN3ZHbklkZU9Pd21xMTlFNXdweURhYW5rZWpTcmhoM0FVcFFCOEQ2?=
 =?utf-8?B?Z0NjSGNTL1lQK0tTNTRpOUpqS2RTNzljZTVnajZST1RhejBCd2M1NXpmazVk?=
 =?utf-8?B?M2lnQ1ByS0pFblhpVHptOFpBRVVzZnErQWpzemlXUUhNMHNSVkh0d0ZTSzBy?=
 =?utf-8?B?NGFleEhaT2NZMmwycFdTV1ZXZU1SVVQ4Ky9pdWthd1hKRlFiVnlxbElSckFT?=
 =?utf-8?B?c0hoZjFsTWVPZEYyeWFudFpnMFBpV1I5cmZYRVVBaDNoVm56azZYN1lLSGZs?=
 =?utf-8?Q?tROxqTAMecQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVlvWWNyeG11NFJ4bTh1LytWZmdpZE1RSUNjS1lMMHF6TkttT1MvTks2Rmcx?=
 =?utf-8?B?SENRU3JPUDZUNzd0emVUK3lyK1J4MHN5cTNDQUQwY1V6TUQrTzJWekpEOTFz?=
 =?utf-8?B?bXBWbGFPOWI2Q21wWStnUStwc05INUF4QVdnRnNNS05zMFQ5OWx0OGVvVjM4?=
 =?utf-8?B?VS9IZ1Y2YWdTTjQyUWd5eWUwdmZvVU1ES3gzZkV0aTRpV0dpNVo3Tjc2SVJm?=
 =?utf-8?B?Q3B6MTNXSmI1U240ZTdwL2YyT3NQNDQyN0lHNVhBL1dKSCtmWUp6YmZ2UHRk?=
 =?utf-8?B?ZlNZL3N2cDAyaWxCNm1yTnNzS0IzVGZyZmc2MGM1MThmWHVBWXljK0NiRFBa?=
 =?utf-8?B?em16QlJRU0JUU3FMOHE0NHBtUU5Ea3NuRHNoNHBDSElMQytrdkd2K29NdmtN?=
 =?utf-8?B?QzNMaGV1dS94OHFYdXFVL3NxSTc1QVZmN0JFQ0plYmJ5MFV3M0NXbTlad2RT?=
 =?utf-8?B?a0xQWGRNaFhJbkZ2Mk8rZU45UzdLdC95N3NkT2ZocW9SejNiSk52MzFnYXda?=
 =?utf-8?B?RkUyWkFLVFNJam5hQ0VxRWhmR0FUTkNQdmVvZ0hmVjJhc25WMHM3SmF2VGhp?=
 =?utf-8?B?L1VTaFYzMXVOM0xmWVQ0bzhDa05vVDN1NzJ4ZEVLRmhSV2IzaGw5WWJjK2xw?=
 =?utf-8?B?dEZYUDZZVjl3bU54d0hRNDl6andMZGlCR1B1bGNjc25oeDVJL0s0eVFuUlBV?=
 =?utf-8?B?dWdBclByMTFKWXllelVWV1ExR2ZiVFRGdjJBSXpiZXVKd0J6V0R4VFdHaEJz?=
 =?utf-8?B?RzNkQ0NMaXZ5enJIN0JsSHZCam8zVVJGaTBYUm15Q2pyNFpGT0hUYWNXN2RG?=
 =?utf-8?B?Z3JxR2puQjNUVFRBcFNHcHJRcjJDRWZIeW1SYklwNlJIOE02R1F2SWdrSFRz?=
 =?utf-8?B?UVlYOE5VbzlSUEdHeXlhOGdzWDBJaEMwOFFiMVNBODdJVlNISUtPVGYyVjhH?=
 =?utf-8?B?RXRCSUtXQldzck4rRWhvSGNId25DbFBxMGZ0bHNYRVIvbUExdnJseWh3dTJZ?=
 =?utf-8?B?RkFjOE1wZ2drTTc5ZEVkMkQyTXl5Qm8xYUNadllEdngzMmRjbFFwRDNmaEZw?=
 =?utf-8?B?TjJTSm03emxxMmRpS09JNnB3NjdiNXhONXRlSnlVamR2L1BvRkZPMEpVMVNH?=
 =?utf-8?B?VU1zTVpVd0VUUHBJMDlrMFlJejJOdUNZOWtGVVdGTm4ybW8zVG85Vmw2REVu?=
 =?utf-8?B?V2k1K0hpYkxSbDZOS0E1RHFrdGRpc2w3Nys4clFkbnZ6U1pBK1VGdTIvNjRY?=
 =?utf-8?B?VDZkaUR1a1FMaVcxUTBPUVFPcjNhTEp6MWVGdFJMdmZvaTdNdTdGUTZtTE5y?=
 =?utf-8?B?VHN1MUpvczhaUFp1UXdFSkI3YzN2Y2FiU0N1NjJ2a0F6alA4YzZmc2RDMURM?=
 =?utf-8?B?SFlJZDR4bmhJK3h2M21QNGUwamUxanloUGFPaFRkWFJxemJNTmFyOWxiaW9X?=
 =?utf-8?B?UXV6UExMaHVhSWloRU13WkNpaUpWUGgwRUQ3QlB6MmVjYUZ6ZkNicWJnWDk2?=
 =?utf-8?B?bzZLNXQ4NE9OWXJ2dDE2dGcxZHRIRmNUVjRDeGlOeXpKYmJSdjFmWEpSS2p3?=
 =?utf-8?B?d3RvWGNoUVVkbitXMEs5dUhSRG4yT1RMZW5EYTJjaWVyVXNKZjlaUHlOOHVB?=
 =?utf-8?B?SzMxSFVqOHlseW9NR1FaLys4QTdMZHo2ZVhvUE1xbDhqTU5ETDNUN3lDZlRJ?=
 =?utf-8?B?QitmSDRad2dZaEhXcGlvL1VWTkp1bTQxNFJSTGROWWZ5M2FsWFZqYUgwdU1i?=
 =?utf-8?B?MCtoZWlkbGtBei9RdThkbVp2bDB2RzkycWFWWnljbnFBSUp5ZW1kY1diT3N1?=
 =?utf-8?B?Mk9UOHZibnFVbmRZb2pSWlpYaHp5Y1hBQVR6TnRmVWd4a1htRjAyUG9MWjcy?=
 =?utf-8?B?d2tYNU1rM09XTXBkQitQK1NOWWd0TWFTZzBJVVNZaDN1cDZOZmNvUnZwcTlp?=
 =?utf-8?B?ZWtPSTE1N05BWVpxU011V0RCWGRCSjduUEZ1T3J5cE1Vd3ZpOTRrZXBSdjdm?=
 =?utf-8?B?dnh2YUlYZHZwWm9ZZFIzV2lLR2lnWTRQSnFLVGppYUlwSzhPTTR6d0VwWXRk?=
 =?utf-8?B?ZXFjdDdMSCsvc3FJR3dvMS9BYmEvNUFCUkZJZVZSMXlqNHpWSEVvakdmNzB4?=
 =?utf-8?Q?Uz7t4YkP3wYGKdt6/6mL/8A6U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I1ODkwiPIAJwa/ijxSwwaoV9pbTm4+6ZRVOu7WQ5bHgKPxhWnaE17T5rSKKtJ0gUhQZdVofmJGieZ4pm45s6WJ6qUnsgvHDpCKMj2eCxmBiZT9peMVvDo8oJt3jk5UTLj3XrrzrXUJsgN8oXf7jG0/UksnydoDbqrvUKU32EhhlpDoCZpyrRCJRRvDl4nUoKCe3kDsv6Zm8HyHHQp4eSejD1n1WtZ+PUe5OCv/Wj6hRNIKQeQAa/BRhCAUC5M2N3DwIw6lwtajVE4txMZvUQZ7ex1oJArdo/FHro8ji23rhN7VFxPDPIjSI38J6Sal06kkrCurWJRcuJXSz8QnbRpmYlwcZPInKEMnqGU2L8CE77losa2NB40LPVxd31k0ETcK+mEUR1LgHJiz+PVKhE08KEfe9xyKOFPtW9zOTUoy5+dW7zX+bW7FOHRn8g6sa8z0RVKP9pXl/GnJU9T6c7ZxTyohEc7zzEv0iQGoXDTF2+Tkrq4yuDkiQ4H0Qt1KrtFNozSBkj6DkW/O7AaxcVerkDX1i507bxX0of75IxSHD0oaKhN/FILmtIYAF/C1CXqx6hFe56BmDJ4oHZr1i32aLg8WgMhhT0ymO+y2k5Oqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f8fc84-58f0-4724-1505-08dda2d3fc52
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:22:31.3720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNSvXPDBaSSjlfxyJWiBIa7XDLKKmRG8+W/7B+XWQakjvGh9/cUVp8MOKY8QSyMAzyIPi49HxAJGByBitajQIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030168
X-Proofpoint-GUID: lxbVRi1Uq2LAS66Pb2aCBcjTRnkbpbOG
X-Proofpoint-ORIG-GUID: lxbVRi1Uq2LAS66Pb2aCBcjTRnkbpbOG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE2OCBTYWx0ZWRfXyosWaHr3tsrH
 2za+LOosWeXBRCClyxo5e0AXI7LWP75r1M825VR/2YQ3xir+4XI3jE0NE45Zco4ZsnF2mxkzqXH
 gxaQkFLW90ISDbNqu2EaAFRKLj4qrztsyzU65vmp4iCd9cEFKX/pDi4rY9fs1j+gR84sApVSFVk
 NZc3AfnYC+rP47HaFCTBc4RjZpTrNivcKVELL3tgTjuL54HAJIHh0U1mknZTpiIlFEq182lLlWn
 jKksh9nRjZ/49QCe8iZuDO5f/HnIZ4K9DHQ3qoQzvcjmp/LHfJ15UOG98fW4DDQFwNL26d0n9HP
 VY6eyD0JqTQGT1ASbtfsOx1PgURaV8GOAE/2sLUmXuLIvRykHwCW7sVUR9DoncCNxemfqAR5iZa
 j4qtfrCnCgZiFwj/aZjsCLMPSde5Kq8j/UsIPtdZuXgfoRvYmHr/+2hlMi1gNhYskTE9lYb6
X-Authority-Analysis: v=2.4 cv=QI1oRhLL c=1 sm=1 tr=0 ts=683f4b7b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=uWP_6MBSmYjLyoOyl_YA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

Hi Igor,

On 6/3/2025 9:03 AM, Igor Mammedov wrote:
> On Wed, 28 May 2025 12:42:03 -0400
> Annie Li <annie.li@oracle.com> wrote:
>
>> The function qemu_wakeup_suspend_enabled combines the suspend
>> and wakeup together. However, the microvm doesn't support
>> wakeup yet. Suspend is enabled here, but wakeup doesn't
>> actually work for microvm now.
> why wakeup doesn't work?
Microvm is missing the support for wakeup now, such as, wakeup notifier,
the sleep status needs to be set, etc.
Details are in "Table 4.20: Sleep Status Register" in ACPI spec 6.5.

I've only covered the sleep support for microvm since this patch focuses
on the sleep button.

Thanks

Annie

>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/i386/microvm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>> index eba33c4365..da5d4126e5 100644
>> --- a/hw/i386/microvm.c
>> +++ b/hw/i386/microvm.c
>> @@ -489,6 +489,7 @@ static void microvm_machine_state_init(MachineState *machine)
>>       qemu_add_machine_init_done_notifier(&mms->machine_done);
>>       mms->powerdown_req.notify = microvm_powerdown_req;
>>       qemu_register_powerdown_notifier(&mms->powerdown_req);
>> +    qemu_register_wakeup_support();
>>   
>>       microvm_memory_init(mms);
>>   

