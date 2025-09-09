Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBD2CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0BC-00070o-DG; Tue, 09 Sep 2025 11:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw0BA-00070U-Ew
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:22:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw0B5-0003il-Sh
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:22:43 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPrTR024221;
 Tue, 9 Sep 2025 15:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=5IE/MVhuhGhHSRBrULZQzpGO0o/Pc7Uvy+en0oH9gWQ=; b=
 GBG9GWoq719v3YNWMhHt4sswWLRCCRctivdsV64Y7s1bMUqyVetnCQZE2xXkZ3OX
 LmpCRfzwsBmyryggKY8Su+ZtL6yHMneHVvShsyWaqv1UI5LYhh4MdC77e/x1BCoC
 /XKoP7UK8E1YXgvRWR30sh+KeyZorcciBNUWVH4FZzlb76VUo0NsJf/V5GPhpi0x
 5e4cmre7eMuGFh2jrNQvc1K/IIgvI5tuWeqQXnl+Z2E8HkFO7u6xzcMQUGwhKQf3
 DJO+b+ySCUD+E+TefpBIaZS8z64WV/Iu0OLf3J4I/zaQVikviiV6cebcC5T9XaGk
 e7s4rzepSF3foiLhWTd3ag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgt5e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 15:22:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 589F03lb038818; Tue, 9 Sep 2025 15:22:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 490bd9saa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 15:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYLzeVPNfKGmkXTkgoEiB2flbf1ezw3GRnpaxMY8K8FDi7pemkZesTeHG2olSMKfsXMoURe9huqj1/zVX27Il6/+U0AktJk7D2ILtr9eA2+P/XH7iPycIDVQKSAeiI3dvI6zq/E/LZVD6Mj1fmz2cBWNNxXvfOljWnv+aWdAluiAtwuMTmk7jEmESg2af8SaSk2ExEpuOmcwPrS+IqICHV+h13DsEjl7p6l8F1fznhO0RSeLvjgSCsw3c/QDftneU5lpFszMktJ6tiCpK+eSFrw+iBbS3+tVl551krJPU4UK5+Dso5Es/LK/y/FOZxN1JQsXFqDSB+sobu5qNSldxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IE/MVhuhGhHSRBrULZQzpGO0o/Pc7Uvy+en0oH9gWQ=;
 b=RgLPONseFFaabGZFUUv4S/2NTOEuznzeGEsVwP1rIpOhDM8fEkn4jtLvuAYQ7bIYzURUcJ8mTxQivfU2CiSQkO6rYRPMCjQnd7Kaly1t2YU0KdES2OTYrL3Vdl2UN0teBV96SbqlsKnhX+U9K0EY6k2BE0+ucDuEjHxJkmPnFRsAKvMWJxTY1T4sg4q+iOB86vhtwtjRVEOO8je6in91i5PJSBxBWC2vHomuFMG5ycXxhpgAOHWIwHKXP6mrL3kz2qsHsVgVlRgmbvPdG4KN+pnBYpazFhC7WfEVAImxRM2oInwkB+pYJ9FbjDrY1nuN81ZEIBRaKWUVjMv8JCwSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IE/MVhuhGhHSRBrULZQzpGO0o/Pc7Uvy+en0oH9gWQ=;
 b=jh9tI6+3GWg+S/9YNcPkSaC7vRboEsfX3/op+fKzCYi+UoiRMfUCb66dA6z7V6JceyLLtR6eciG+CF8LsEV55+ClASCAb1StdV0wQp2Ygg9hxoaCsQNKHBp68Mlv+2xvoUjnpQo8V0SZLh2Fz3e0rlFdMy9SiD69WxPj8DEz3wk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:22:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:22:31 +0000
Message-ID: <69da4430-b935-4f4e-8261-07ce184d7add@oracle.com>
Date: Tue, 9 Sep 2025 11:22:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/9] migration: cpr-exec-command parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-6-git-send-email-steven.sistare@oracle.com>
 <aL7_KHXT0XuvY6aG@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aL7_KHXT0XuvY6aG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:510:323::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2a8b31-89ee-4a83-7a6d-08ddefb4b1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWNyVGNhLzFrNGlQc1QrZnc3Q0cwTDR3SjFFaGxSbWU5TnpQczk0SUU5NGdi?=
 =?utf-8?B?Y1FHUHQybDN0c0VzSW9WaGRUZE1jNnd2M25BSDZXZjVFNEwxZE9DTVdrRXZ1?=
 =?utf-8?B?RFErSlpUTlJ0a0pOTldIUzRjL0ZMYklrU1BBd29GZUx5TUpWRFhXRFAzVitF?=
 =?utf-8?B?WXJ4QzFxcHd1QnNOcHZDZlBTYkdPSjYrTnRPMVVvOHlQUDJiWUZoVWd0Y3NQ?=
 =?utf-8?B?Rml0S1gza2hUTVVtdEVTVldaS2ZFc3pqSFp4MGE1UG0xeGlqaFk1NlFxWG9T?=
 =?utf-8?B?bDQ0L3NGMHhRWXBhQnFROFJrbTRGWWtZb3drdmw1OUh5M2cwUDVHVkV2Vzhu?=
 =?utf-8?B?dG84MXNWaUVvMEZwcHJ3WUo2YXBTUGd4RFl0M2RIV0VIL1hhVGFQK2NuVmQ1?=
 =?utf-8?B?djFwVkxUUHlIU21Na1pyLzRnNlQxZlp1MWRTbTkvaUUwRHhrSzRNMTNKTThv?=
 =?utf-8?B?ZmVvV3JzWHl3RGxrWkZyWWJIRmdaRXhQV2l0SEpTZW4xQk5zOG1vWmVoVjVQ?=
 =?utf-8?B?Mi9pN3JydnZVdWVaN3p5bVp1WC9vTGpkRzBwNm54dnhkdmlCeHRCOWMwdDhS?=
 =?utf-8?B?VzFVWThUWHFxYTlTMWRLaDN0ZkEyQ2FOWm03U3FvaVhRUkJUNXE4M3h0cnZQ?=
 =?utf-8?B?aEl2MDZKdW80NHVlT3NNSE91SklORUtZRGFLakdQT1E3aVkxTm0xWElrajVZ?=
 =?utf-8?B?MkNxNkg2MDVlYmg2cG5NdmtzSjdXek9JbXlFY0NmVitNaWloZXNSK3RLYW9U?=
 =?utf-8?B?WnVYRm5VV0dOV2YvQVdweC9vc084WGFhNEhJc3pITUNnM0NneG96WlFwMmlz?=
 =?utf-8?B?K2ZJajRIYm9JbVJTMGx5NjZkdzhMRml5NFVzQ3FteWFvZk1rTmExY2d1Q3VP?=
 =?utf-8?B?N0QxVkFFVmRuWElOQUZMZWN5cTNvSHJGNUxFL21uc1lTRXo4aGlQeHpETkwr?=
 =?utf-8?B?MzIxRkFjM3ZuYXhGeXltQVQvdkkwYmJtelBpSWRDbXNWK2ZOZ3NodWtjYVQr?=
 =?utf-8?B?VGZ1dEtCbFhFREg2RlpicHdvbjRTT0doMEM2djNEdjVyaGU1SkI2NW03M3BW?=
 =?utf-8?B?R3ljN1FwTG0rbUtvM2s5ZTN4NEpZYVprNzMwWWhtRG4rSHRqQm5KTE5aSnh3?=
 =?utf-8?B?QWVzSU4ySk9wMkNEcW9uWmNsekZJVjErWWY4Zm42cWxVdU1TVmpQZXpmNmtK?=
 =?utf-8?B?M0pzYUN2dEdpUFpPMDgxM1EvcmtIVkF2ZTk5M095c1hIa3BOKzFqaHJydk1z?=
 =?utf-8?B?ekRQTXVSQ2xEeGswaXY4cVp4MUtOTUhlL3UxaUJXcXo0R2V1cTRNRlF6c2VX?=
 =?utf-8?B?eE9QNWZ1SFhwYTNPZ1FkaFFWRkdaQ0MrU1FiNlVwWUIwWXkycXRubWRvNmNl?=
 =?utf-8?B?U2Y4V1Y1aitTMUF0UDgvbXVhU0doQ3hKQjJxTHJmZXJQMnkydXA1QklXblVt?=
 =?utf-8?B?UzFtWUVvREdYSmUzWVRHVGMyZ0xqajMxOTU1cFQ0eEdxQitreDFBcHI0YnVQ?=
 =?utf-8?B?ZGNIeFc5RmZGN0grVzMxcEZiUy9CN3Y2VGtFaHBJbTNXaUZWY2V6cTlvMExy?=
 =?utf-8?B?Q1hqcUYycHphRlliaG5PQ2dSenhtRlRIOUhJVVJnenU5dWd1VXhNTldBMCtL?=
 =?utf-8?B?Y0R1MmlUUE5idHFnNG5jTXVXV2ZZVkE1Vis1T0J2NU43RFllRHlFM3BjQUpr?=
 =?utf-8?B?VTVPanlxT25yNnZjUTFpSHYxL2xhN1R2UlFINU5wZmI5cVd0YUY3ZjM4MzJO?=
 =?utf-8?B?cHgyeGtnNXhHOWROdXJ2K1kwTkVIMVRxeWF0aWhNUjdwSG85UFhteFo0K0lV?=
 =?utf-8?B?aERSQ3Z1MXIxd2RqMENoRW9SblQ5MG9ucUVlN3NjM1dLN05uR2xseWwvWXkz?=
 =?utf-8?B?OExabXBmdFdGaUh3ZlArSE5uU3RhL1B5dGl3K2UwWmVzL2cyTTNmcVhhQ2M3?=
 =?utf-8?Q?EnT7rOZHCtE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxpUmlUdVBnK0lTL2NYdFlmV1pCVEZqdkwzcnRTMytHeGhNUFQ2cWV5T1lj?=
 =?utf-8?B?TERQSnRtdFd5MlNFVkNqUisvcU9NbHhmL1BndUJaU3RsUi82ZnloZ2RDdzBQ?=
 =?utf-8?B?cEZydldWRDA5d1NuVWtCM1dsU2VNNjdHSXJwWlR2U3dJYkNEQ3k4U3RCaUpJ?=
 =?utf-8?B?L2diZjJPQkRJSTNNUllSSWVWY0NoNlZ1TDVVWU5MOW5VRXFmMjZ6c0R0L3hj?=
 =?utf-8?B?dW9uQ2VhNy9TdFpMRC8wMDlmQnpCcnFldGM2ZFF5ZVFOdWd3dDlFNkpMVGt4?=
 =?utf-8?B?NHBIalV2ZE5ITGI5Z3FxcFR1bFhrN2RiV1grSTNKR1o0Si9oR1N4dGZtWUpl?=
 =?utf-8?B?UEFpNkVEeWtiOVFGS1lNdk1zNUVYNmVJaGh5RnJFVUl2Z0liZTdqczRFbHJ2?=
 =?utf-8?B?WVV1UFB0MHNQWWFFcVpxZTVCTnFiTlViWDFOOCtGeFR1TnliL0lnb2tRUTZL?=
 =?utf-8?B?TDM5dFczVGw4ZzVycW9XbWVJQldDYjlyOWFNUkJYZDRxYjg1b1pUNm5ZS1NN?=
 =?utf-8?B?RTl4QU5FL1JjcnZDNGFrRGpJVjM2dzhxdkJtMGx3SG0zdE91YUhiRk1BcytQ?=
 =?utf-8?B?VmwreWgyWC9TVHB3Nit0RE5MVjlHY21DR2daQnJ6Ym4vb2dlTis0NnVKcmNS?=
 =?utf-8?B?RVExZ2xMYldQQmFHdmhRTlVyQVBmWGtNakh1aXc0VlJvUEsrc1lSNlB6UGVm?=
 =?utf-8?B?RUZxWXNXa21ONE13MlpIWFhLZHR1MUNMTk5uYjVNb3FaNndkODlYcFoyZUs1?=
 =?utf-8?B?Y282REFrSWxZSkVqckw4U1J1ZVlvYUdjV0x6NmZBQVQ2dHBwUG42ZllHNkI4?=
 =?utf-8?B?bzM3R1dlZktocFJCMWlaVEg3U3VXdTFDZ21vTTc4VU5ieVBaeEF2VFprdmxv?=
 =?utf-8?B?RnZxNEdxd3FHV2xuc3RrczBiU0xzNnd6UXVML1BwT0RzUE13UGM3ZmxHRTRE?=
 =?utf-8?B?T1R2eWpCUnIxamMxNkdQNjZ5NXVlWHNwcjI4MmN6NFJsbUJjMjNtcnFjekF6?=
 =?utf-8?B?OWxXZnpjTlpNV0xTRzZTbzhyQjNZQ2hneEEyRzhCQWNQTmFzc3ZOQnpzYjVN?=
 =?utf-8?B?eDhSb3pkM25qa0IrQVZFZEtKSzd0VStFbkpCYnZrQXpEYnJuL0pKRWg5M3hI?=
 =?utf-8?B?WGJvbUlzdmFJQkZzSzA5eWtjUjBRUDdHTlhmSWZKNFA3R0xGdUFlZWxaNTZQ?=
 =?utf-8?B?L0xxalc1WHd5VnVBaWlhMDljMHhKYzBpUlNRZ2JQVVR5QzRyQ042R09ibHE4?=
 =?utf-8?B?dlQ4N29kYno4K0RyaTNrd29qamprcDZuelNteVJnT291NXhnanVBOTJnLzN1?=
 =?utf-8?B?VG5XdjR2NmJrNnVqUnB3a1BLeFB6bkRTUDNpU3ExR2ttZ3FXOWpJeUZ1bTB5?=
 =?utf-8?B?akxDU3lVRi9UNlU3c0VaQ1dKT1kySXRKc0JDMytMV1M1NGxwbEFLSkxkL095?=
 =?utf-8?B?ZHVZaEVqeXRUT3Z0UUVKRnd6Z2UxbUN6eEJWUnlLRVlEVnJDZmdZanczSFg2?=
 =?utf-8?B?L2dOOUJ5MFBIVC9hN0F1Y2ZPSkdLMi9pYnVRVG9EZVA0L3JXazkyQlRWUEJq?=
 =?utf-8?B?Y3RkTEZoRzBKMTkxVkhWNTdONXJ1ZTZWcHFvWGRCajNUMmFaSTUwenV0TG5Q?=
 =?utf-8?B?bHo3T3lzSjZHM2dBb3A4TnBkaERZcm9rOGN4YjNEdmttOXBrTWxHYWhTaG5Y?=
 =?utf-8?B?d0NNaEpMVmNKNVgyV2NzajdXRzd2VXZ0YjROY2lzLzIyRStNRVdFT1hSNEF1?=
 =?utf-8?B?QkJLRDFtbG5ia2JVU1ZxOUdXS2ExY2tBMTFSSGVVUDFMVzV1L3d1cUlzOGcw?=
 =?utf-8?B?UjVjRmNZWmRLME9MNHowM2hhV213b255R3MrZk5GTzU5NXJSZjlnRGF3WllQ?=
 =?utf-8?B?SmMvS3VCUTQ3Y0o4ci9rRmw5cVdVdnNOeWRHeEU3eDBvZGlvUnlZbmRXVktp?=
 =?utf-8?B?Vng0a055WXE3a0xUMVV6S1dnV1AyYlFKeDhmT3htVHNpRlYvUjFNOEZVQUFi?=
 =?utf-8?B?K1FMSnRDdkk0YTVkUnBQSnBlWm4zczdZeXVLaEdITzhRYzhkVXBRTE1jTHhi?=
 =?utf-8?B?dXQ2RUYyL09nUUFvMFJERzdEVnJETzB2VGlxWkptYmJQZWYxY1VnVU5NR0Z6?=
 =?utf-8?B?N2U1RjdINGlITXMvUVNoQTlCZnJUaWZudDBQc3RrUHBLaUY5WkxBZG5CRnYw?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3fmj8GKCflBWhl0W/4Fty/4YgqnVkCYepuiZc/noJGdyXrKt8EReK0EG7+TAaL7rhEavIV6ws9xOSj9hqEoJQVQsdrXsi3YIMVvWiF3og+6CJ2mlL6ypS94FVxS5AtCbrR0bKS5U/W8blRUc+xUjzJGPjoWwposW8uAOHxVc91ogo9JqwM1C/UVWcOJeJ0twNu5Vi8odg1ACrSHRyLFghI5FP4e46iDBmBpoWujumycc4JYn0BrER3dlzHuGHpS6ljr8yefDEQm5LFc4t9+hO5N8RfpxSbmXWIAXbMSE+C09HCoOnkwup/uUCUDXvl/akF/gKHl7wgiEnnrL0Mzx9g4jD3+zzl1BwDPE/pLIqvlHpRHaf1sEZlFiOKLG8alrXT9AUDpRqh1gpI252xL2iDw/3Fxv1MFXCJfDHcZ9zACVX3eJlk+SgEOjzpk0ACbrQslzjWs4KD5S18F5HjnB8JaUuym11O7QCrlvngpMBX7CuQ2adb9mLm+hpqZBG6bhNl2NDM/wW9UG0I7BO42jDH25Iedc2uJkjG5dXsatD7broxaHHLWNC+toEHLgFNrSs7ZvjcKQb7LWbLzJOm1oAlI97Yc6Wdtgo3GDX+IaL/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a8b31-89ee-4a83-7a6d-08ddefb4b1fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:22:31.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNyFPDmYw065tgYuUsxjlm/jj68x2vYOcX/3X49piqjkMEergXNuQAGAC62dbupgY8bUaVQ1JBzLTYiv53PX5q1n6btcHE/OtDkW1O9AKZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090151
X-Proofpoint-ORIG-GUID: NagV5d6JM5NPGuUPshFovJmTzx2ftHsK
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c0463a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_gXOAwlSsj9fRyF-JE4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: NagV5d6JM5NPGuUPshFovJmTzx2ftHsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX+OcBudhnusBH
 gksT3JXr7QGEwgZTXdtSj17R9yACs3lNuXvT8yQQoffCDkgkRG+p4568lxCY/owCut++D+mVZZZ
 NpRwElzCMZ9H7rttYxlyVWa+xMIq0ewydgBmbDsHbgr1a/QWOSkVPiW0k0NNZhRVPc/OXqHvdrk
 Akc2bvdqI/qzKmzTSPWXDkwQZcNLHeivKMtnVO5FIK3dICVOFlN5xV7IPIoiZXkKycvqMqw+9dV
 z3RtWcum45qWin3d+zqOmGUaaaSSWtwMBozWJECeZM09hQHcoca7XsvkchhDYL7Ayog0CPgQXiI
 J98B8YUl5jBqM3UU5OI7BIoyZGAGvVJd7SckbjhnJkj1ZwOpqr4K97VQjdMRW3IPHVtpqVAdiCd
 5ujrShF+EWErfqECjrvYRWGHsHBDTQ==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/8/2025 12:07 PM, Daniel P. Berrangé wrote:
> On Thu, Aug 14, 2025 at 10:17:19AM -0700, Steve Sistare wrote:
>> Create the cpr-exec-command migration parameter, defined as a list of
>> strings.  It will be used for cpr-exec migration mode in a subsequent
>> patch, and contains forward references to cpr-exec mode in the qapi
>> doc.
>>
>> No functional change, except that cpr-exec-command is shown by the
>> 'info migrate' command.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/migration.json            | 21 ++++++++++++++++++---
>>   migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
>>   migration/options.c            | 14 ++++++++++++++
>>   hmp-commands.hx                |  2 +-
>>   4 files changed, 58 insertions(+), 4 deletions(-)
> 
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 0fc21f0..79aa528 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -306,6 +306,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>>       qapi_free_MigrationCapabilityStatusList(caps);
>>   }
>>   
>> +static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
>> +{
>> +    monitor_printf(mon, "%s:",
>> +        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
>> +
>> +    while (args) {
>> +        monitor_printf(mon, " %s", args->value);
>> +        args = args->next;
>> +    }
>> +    monitor_printf(mon, "\n");
>> +}
>> +
>>   void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>   {
>>       MigrationParameters *params;
>> @@ -435,6 +447,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>                                  MIGRATION_PARAMETER_DIRECT_IO),
>>                              params->direct_io ? "on" : "off");
>>           }
>> +
>> +        assert(params->has_cpr_exec_command);
>> +        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
>>       }
>>   
>>       qapi_free_MigrationParameters(params);
>> @@ -716,6 +731,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>           p->has_direct_io = true;
>>           visit_type_bool(v, param, &p->direct_io, &err);
>>           break;
>> +    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
>> +        g_autofree char **strv = g_strsplit(valuestr ?: "", " ", -1);
> 
> 
> Perhaps we should use   g_shell_parse_argv() in the HMP case ? IIUC
> it should handle quoting for args containing whitespace (as long as
> HMP itself has not already mangled that ?).

Thank-you Daniel, that is a good idea.
I verified it works with HMP:

$ build/qemu-system-x86_64 -display none -monitor stdio
(qemu) migrate_set_parameter cpr-exec-command 'a b' c
[0] = a b
[1] = c
(qemu) migrate_set_parameter cpr-exec-command "a b" c
[0] = a b
[1] = c

- Steve


