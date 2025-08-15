Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22CCCA0EE9
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un0DT-0000sq-FD; Fri, 15 Aug 2025 15:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1un0DQ-0000sT-Tn
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:35:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1un0DN-0005lX-HO
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:35:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHkCtL002234;
 Fri, 15 Aug 2025 19:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6TawFBgIV4bpbpbVXZyFzUaQBNwRs66oAdySE1o1BVY=; b=
 Wuzc7fOVHm4uJCXgOeuWFjsWyf71PDoHif3rTnkv3RcDoQd7lVbNCHVG5BP4wQi4
 Xi42xjxEI6VJtK1mZwy2LpLusyWZZ2zW+OYROg2ktlvtSIIEhA8nNAm01ZqrJS1A
 f91MsX9YNKjhew6fEgVOtwRTHI0JtbJMXiypKgwCG+9TmaqAEi5NsOfBx8pr5SDe
 RHjxib/K5ET4+yWjiRR+OpjvTCrqlbNkTgMLhSRDQdFCEOJZ+Fy/QktI+Eee2Gz6
 BDNZqomnG6DFXQB3TtFRi1lKFESE73PNmDY/GYzju/IqPqJepfb7euabgcNqP3qV
 omd22n2Ze/OZai6VtQ9U/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvx4e30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Aug 2025 19:35:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57FHScOx010435; Fri, 15 Aug 2025 19:35:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsmp3p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Aug 2025 19:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1undTAFHfeS17277+ZueJBBkYSU+kKkV9o4rNdtveJX3YQkWiEJafaDteWP/8w7TQqc4iXKWGsNE2iZLhFnaWwBMd5OLTOFt465hL/qkWMG6v5CnlVbNIB+99yLttbwqAdqhNcZTTOqYo6b3OLhPI41SIU1HL/OAtymMARna8VAIM/yo9k5kN9j8RUsmFalpbt/dRA4s2vXqF1LbcIXFa9Mf9dIyMkohXKifyQCcsy3CsCJ8TsgOh2h7yZdfUxM6LD3eBkpYRWg5JrKyYnu7Qm6qroQ2OKT3ILX3pGhcBtSELWu0EB5aiIuc9fWeA6YjMCfkC2YfAQm3gwR+jQY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TawFBgIV4bpbpbVXZyFzUaQBNwRs66oAdySE1o1BVY=;
 b=PRdKmKvklbgZFmHsgmOF1H9d8Z2QhWrHPcDojUmVhocjWv6v54E/Gt89u4Xuk58zJEkIqoni7tQvzoDXHNCtzTgEiN2YPssdf3VfEiUau1q6h/s8q5Po0ME+sy2AE4EmOiIhXfPE9ok7KkLn7nQyqR7IOBqwHrK9ARFFHosWzfyfGeIRZIfaGsG8/rIbctu54niM2Bt6cxwWws/UysKZ46YefSnSM8hE97X6c5B2PIkXfIEx5mre1SOLnBJgH13Awtj2GRb7VtglJ5cT650xDk2Yz7uG87sSggNJY/kqiIXLXmj7FvOU6JUWMePIyU1PIAVjnfg0OIcR0FNwAd5r2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TawFBgIV4bpbpbVXZyFzUaQBNwRs66oAdySE1o1BVY=;
 b=S9sH/oDLOOiwjyf0KLwiMSb11G/VKXoWA1K68SwHnsXcxfHKIwoe+jyk4IngFBqWxZT1ckHu9phYM2TcKSjjo/YC2SBcOPpY0wulkguvIIbfVuWz0jZ+mNp/cHG4u33TwpKuKrs3ru5DvM4TVytWfRdV2a+V/PzJKg3ZkfGoir4=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by CH3PR10MB7355.namprd10.prod.outlook.com
 (2603:10b6:610:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 19:35:38 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:35:37 +0000
Message-ID: <97b193b3-970a-4fd1-ad7d-5e752474292b@oracle.com>
Date: Fri, 15 Aug 2025 12:35:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio Perez Martin <eperezma@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 boris.ostrovsky@oracle.com, Dragos Tatulea DE <dtatulea@nvidia.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cedba48-e5bd-48d1-86e8-08dddc32e914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVBkR1FrSjFnRldBSTIxeW9Sd25YQUNBeS9OcnA4VHZtOXozUGx6Zk8zdTNI?=
 =?utf-8?B?bzdBRDVYdm9EY09Cd1Q2Z2lFQ05IbEYxcXd4UCt2U0ZCeEtEZ3ZHVW9BZjBs?=
 =?utf-8?B?eWJqN3V3UVg0U1pQRnRWMnVGNUYzcFRKUjdkb3NzRVVHdVhQa09xZGU1aE9k?=
 =?utf-8?B?SnR4WFpFSUU4cEE2VXdsVFZTc1k5TnYwUjlSZE9qN0o1NmhuYm01Mjg3dGg0?=
 =?utf-8?B?R3pOYm1td2VrOHBGMzRPY0IrMlZaVTFlRnJ2cU1FMUs5a0xRT3NPOEJMNFBt?=
 =?utf-8?B?QnFvMDFlUWxwVndBaHVDSUh2MmVvaGU5dFBETUVYT0x1bFh5amVYZkFhTTJJ?=
 =?utf-8?B?MDkyd09LZ1UvTEV6KzFVSzBVVDUrQWFRTnR4Q3F3STM5MXZja3p0NmJZRVNx?=
 =?utf-8?B?ZnFuUDVuQ0RKSmpTT2EyWDZ3NDNtT2s2Sm9LdmUwZ2duWUU4WUxsYURWa0xP?=
 =?utf-8?B?dTREZHFYR0M4KzFsRUJHYjI0MFJsN05MVjFzT0RKY0VFbXo1aXluSkM4RzRp?=
 =?utf-8?B?NU9HcHEzUTlqc1p0UlJiZEdrL2swOFlMVDZkOHF4NG1nZXNjRXNVM2I1WlNk?=
 =?utf-8?B?R1U3RTZGNlpKTllBdVFFMlNtcGsxTEdESzUwb0l6T1FJZnhvNEpnTGVNaW1G?=
 =?utf-8?B?T3pDUkVLUGZaZlVEVFlycWw0VTBMd0kyb0ovQ3JqendMN2JuMFJEVVFFNFho?=
 =?utf-8?B?Z1NuMCt0dlMyWkEwQlE5aVJUNlAwVmtzOEZrR3BkV0RrN3lNWDl0RGdkcWpi?=
 =?utf-8?B?QUxxVGtFRHM3Rk9aUmZTTjlpMlluR2d5bVNxVTQ3c29DNkovb3czemlMenM4?=
 =?utf-8?B?WDFYK0JiaFdpUWNNWGhQa0ptcTJCM3VhdlZuNFJUV2wwT0YvMU40Yy84VFMz?=
 =?utf-8?B?dEkrY01FZjBoUGdxY0I3Vm5BSytvamkzTmU1alBlbUsrMEpISGNneFFEN0o3?=
 =?utf-8?B?WGhIVlg3TFJwaWQ1TGRmalhISVF6REs4RVkrMi9aRnBKZTJQcndscTFGTW9L?=
 =?utf-8?B?Vm9ONDJtdXFSQ0xoaW5FU1QyY0k1Mmt5RlU0NGJXeStGa1hTa0tuc0RvQUFk?=
 =?utf-8?B?elhQVlFET0dkaEFDSWtKMnAyOHRWYytZcG5hRnFOMGNUcmJCbzFRa2J2WjVY?=
 =?utf-8?B?enIxWC9YbWNmS1gxUDQ0ZzZFSmhwN1RrUng1aEU4ZW4rVDg1amVmMFljaXJB?=
 =?utf-8?B?aVRhNHgvRStnMzJhckExNU5HRXNYWk43a2djVDNNclpXbDIxdGI2dHNoOGdn?=
 =?utf-8?B?MEcxV0xBNWp3bk5XMno5dXhHaU8vMVppNlNDeG1oZWtyMWkyem5ob1BNODFx?=
 =?utf-8?B?MDkwSEc3VmpNVlh4b0xIdEdDeVhGZ1hxRWZQU2ttNEVISitodHlMV3lSV0NR?=
 =?utf-8?B?MjRTUitMbXBkMVZFYSs4RjcxWGZtc05ENENBN1dnMmc0UFl4VGVOazJSKzdn?=
 =?utf-8?B?RitUb0hQS0swa05mblBaUWpQYWQ2dTliSlp4SjlhRXhEd3NnTjZJL08xME1E?=
 =?utf-8?B?WlA0SjZ0NVZjTkxNSjRtOFZLQ2VrVm1hd2tkd0VCOGJxUVhqR3JwdkxXRHdO?=
 =?utf-8?B?MnMvalNjcmZUSnRzS1VCYngwNFFrcStrMm53Z2QzVFhsSC9CY1loK1BQYzcr?=
 =?utf-8?B?RGd3QWlsRi96Y2FkUDcwN2t0SUw4QW9xeEZIN0lRSXVVbFQzQlBpd01ZWHlo?=
 =?utf-8?B?My9lQWtYZ0ZsT0RKZmZEU3drUXlRVUxnQVBQSzcxLzh3cWwwQXl3Zm9ncTR2?=
 =?utf-8?B?djF3V1hpR0oySlk0TCtDWWxkeUcySTBPYjEyRUlVdW9aZDQ3bUtrRDNpSndx?=
 =?utf-8?B?MXp4cnowKzNmT3RKeGcyT3JBRFQ4TGlNMXhYT3dXUkxzcmhYeDY4Slg3U3V6?=
 =?utf-8?B?cGNhOUFCYXM0UHV0S0pBK3B1MEJNT3d5MnRxYTlZb3RSYXU2SXBUOUF1SnpR?=
 =?utf-8?Q?XUCmd3MHwao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdTQjEwNzRVWG1yaWRIY0l1WW4ydEo5MDRGS25Pa0pzdCtDUGNzSklaUHFE?=
 =?utf-8?B?V05JRVVxa2g2UkZtQjBHeTFFaXdpTzFjd2hJSXR1cHExeTVrbko2N3VmUmlM?=
 =?utf-8?B?K0R6RjlmbTFQREdiL05VYnNVQTg0ODU5eFJRUDZmRlVaKzNpNjVEVXk5MWp4?=
 =?utf-8?B?V1hFT1RrNWRrSWw3M0ZFbjFsU1l5UzB1bWRNWUVvYVBtRUQrMldZRnNhRkVj?=
 =?utf-8?B?VlVHdFhwZUdTNjVhajZTZHVDeUVLZjA2eW4xMU5YNzE2WlBmaWdSVW44RENR?=
 =?utf-8?B?Y2V2U1RQMjZxQmNjb2VqcFg4akk5TVBleGpoYWJGRks3REVXVDgwN3lpakZW?=
 =?utf-8?B?Z3BJY0dWNHc1Qk9tdldUYzlOVSt2YU11RG5IKzhkOTE5ZWpuRUVXUGc4Slda?=
 =?utf-8?B?MlR1bTNhVFVNenRXdy9HUVAxczZqSFZaUHpLNWF3WllHcFlnVkFCcjUyTGxR?=
 =?utf-8?B?ZXdqNlNzT2l0MHpUb2h4anNyMFVXbDV5dWh6eXdUNURwbkxPQ3E5dXVaakN0?=
 =?utf-8?B?KzNQak1TMmViQzQzTVNvT29iQncwaVVtMFNsR1EydFFqNC8rMzNXMnNhb0Vp?=
 =?utf-8?B?ZWJNTHByL0JEZnhzcm1pakJaOWl1R2pPelZvbTFRQlFUZkZkL25pek5mVDFq?=
 =?utf-8?B?dFRIUGQwN2J6Vjl1RzJydStja2ZMVDI1dWprS1lJZkZjNjN4OGREOHQ2K1hK?=
 =?utf-8?B?Q2JEUTlYa3N0eVgzdS9zenhhd3lXTk44aEsxTGx4UDF6cnBiSUY1ejVnTmR3?=
 =?utf-8?B?SlhFWHBuNUZaR2NnM3FhM0FHZVc1SGY3T2JoYTJJeEw0MHRZZVZzZUc5NE9W?=
 =?utf-8?B?RGZRNCtkNEpmaFhlRFIvRUgxWmNKVUsyVGQzak4zSURER2xmSkxxSXdyNzFF?=
 =?utf-8?B?S2o4YkFUMG5xZ3BDTFJ1ajQyYzEraTNBeG4wYzF3b2lQMDlwSGVLYlNod1NE?=
 =?utf-8?B?YjRHNFJmalgreFNia1FYaGkvQ1p4S0Y0RmVKdWxHSW5tcDVYUjYyOHpnUmx1?=
 =?utf-8?B?VWFtV1FQUEI2N2picnhhSmhrVjNPZ3c1d2dUaU91cjJSdlUyNU5iWDVqRXM3?=
 =?utf-8?B?YWxSQzNIclhXUDlCeTk1VXFGSUowMmVhNkhGTGp6VFh4WGNuZ09pS3RoZk9N?=
 =?utf-8?B?RGhGQlFOcGUzendkeWFpbGNRd2lDbnVZejZ0ei9zSnlsNGpXb0xGWWpCeHk2?=
 =?utf-8?B?YmdTWktnSXMyY09HalRXV25WU1pFZmdYeW5hM3ZtN2NzWEVlVklSZ0IwZUhq?=
 =?utf-8?B?cDRkazZoZUZ1c0FWWkxtVXA0dnZsR2lHbG16ZmIrU1NPM1dlWkdtQkM3TFRS?=
 =?utf-8?B?ZzZsLzc0ckd3aHh5b092V1cxM1F5ZHJiQ1NselFHb0d4enl1VURhZTBCWTZ3?=
 =?utf-8?B?WDN2aE1tTWhzaXRUZ0pIeDdjeDlEL0FoT3R3K3dWR0VESXNWZU9Xc1FPTkFV?=
 =?utf-8?B?QWh4eGdKVzhIZCs5QkgxK3dtbUttN25wNmlpK3BFQ05aK2l3WU4wSnBPd1dG?=
 =?utf-8?B?bFpvUmNLNml0TGhNT0xZVGVGSUZEcWZVL1dHV2NONXNYQlhUZm45d1Nrd0VO?=
 =?utf-8?B?dUhuMW1xaG9UVmNhSEQxQ05ybE8wS1htYzdoOUQ5eTdWMWtDUTgzRVRqRER6?=
 =?utf-8?B?eEhNWm9zN1o4Yk05bkY1ZThwM1J2T2RpQW9KN3YzcE1KR1pPYnIvZDRmczFN?=
 =?utf-8?B?NXVTQnpsVEV2ZzVKZmc0Mk5FVkhISktwRmRSMmEzVnMrZCtDTlkxczJNUjhF?=
 =?utf-8?B?WlVCOFczaHJVUmMxQ2NwRnNGOFd0UEhCMTV0dEhNWjAzcVVtbGpqRXhSWEpG?=
 =?utf-8?B?M2ZQeko3enkwZkU1M1ozMEpnVHBvNTdHc2hDMG5xelBZaklwa2pGcU1ZMWNt?=
 =?utf-8?B?WUtDQU14UGQ4T3dLOWRXVTJzeTZNL2tVRGYwMGlweldwNENTSFBzVEMrOXgz?=
 =?utf-8?B?VlJkTzNuMmJIY05GMjByU0w4cUlhbzJQQjZmRDJWdmpmRm1hazFTd0hZMHNG?=
 =?utf-8?B?dWpqY29hYk5GdjhESk4wd2FCdHRrcW5jUE5KQTFON2laTG5NdnEyWG8zcytD?=
 =?utf-8?B?SjNEcDJqUEZWVkFXeUN0TmRxSml0Mk1kMjUyQU5sbWdvMzg2NWpvcHYwS0FM?=
 =?utf-8?Q?+++XbBHVi5zOQZwV/u3fiZ+Nj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IKib3cgpAG5AimVys+eHLE9HjZbYgdq2mTBvp7NgHzTqdyFIBpRKPWb4VLFUtnWlBhK7WJh7QkgOCftrId0Fli/+Y59SXMZD/J8BJb46p5i5PPwPPvadcEWEe9gMxaUcq2QOoqu7aG+8J1THR6Ule4EtTX2a1iCX2Zen9ZdR0Sr2fRC5f2mTKwgMVNhc+kQGVUb4CIUVBLc9+CEraX40eRLhr2Vy5MoDDjl3psaovwcZGb9OBp8SGnt2S+O3RR/XJiMsQNJ4vOsmtKdenobIQhNGP5QnOkSPct5A1IA9UAk7AibnDwpW64GSNVvu8/N5TRAJC7Y7+DrBThzj6T1rMyO5TnO2OKKoZyLRQ2EoEoufPsEQiLmCfYZdua5M56pxL+F2RuIBUCqwfP5oE6AB8z2XyH8wE3tyD7QPVPJN9nnD3vpzpLvxHfhFxi0RT1oqcm1CIgzRKol2wixAfllajaHN/uvezyPWm1T+HwtPB7x1+BnQMJhnahT+6e6k42MQ4pqk6qKDhocNqoVo41uZxZ7VEE+0IYDO1MSHtrxujHncIk0JpmDHzKEEMcASoGDRl5DeU+M+q/UH0VSa4p715aoFyUyvBK3QxsTenExzQgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cedba48-e5bd-48d1-86e8-08dddc32e914
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:35:37.5079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRY23CcU2O5tUXFoFMxNy/7qxt20ZQXd63eXCf5/QlqUg6IliXKkGU+4g+C+O8T/H3MEBYbCYrcv/vjGx2iHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150166
X-Proofpoint-GUID: 31liV1iVn8eglFIQM6UnpmetrHCUmvNl
X-Proofpoint-ORIG-GUID: 31liV1iVn8eglFIQM6UnpmetrHCUmvNl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE2NiBTYWx0ZWRfX+g579u/IZkho
 zF5Lz8ocCm2W0Sgkje8sD/3Ee2eqKSxwcTubDdseVvy/HByW/W4cKu8ZxH+jAWIzpp/fswwh5ev
 eweE0Sbwq7U+tSluCUctgSMGBtQ34aJm97aUfggTCJfwP9kg/SjtKqpwLK4PLpTRS0HEetPd8QB
 Gdk0u9Wbko6c97eUJWHCrndk3FRHWK1Vv7p1FGfw5AostZhk3KS3V8ETR27LETitXgDT0DRCTxu
 2gS6wNzPegdiPvGuJSf2/cohz+LyNBVCQiBO8KU4gt7O7fP/pD404DNTp5adreAnU+kH05wDLIE
 ALZ03g/IDFj3wrOI7CCWbZ70S/zA+HPKfjtYimyn/S6P5b6OKqW3Slrr1P3p/DXZ/iMFV0fUR0G
 NjhD2PmPqkijr5sgzt2nts24eCks0c/8bPSrrwhXd1pZ05oQgPItyrsl82hbqpwJKBzzJ5Te
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689f8c0e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=20KFwNOVAAAA:8 a=kHqSnffNLQoS9699VEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12069
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Jonah,

On 8/15/2025 7:50 AM, Jonah Palmer wrote:
>
>
> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
>> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>>> This effort was started to reduce the guest visible downtime by
>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>>> vhost-vDPA.
>>>>>>
>>>>>> The downtime contributed by vhost-vDPA, for example, is not from 
>>>>>> having to
>>>>>> migrate a lot of state but rather expensive backend control-plane 
>>>>>> latency
>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN 
>>>>>> filters, offload
>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC 
>>>>>> operations which
>>>>>> dominates its downtime.
>>>>>>
>>>>>> In other words, by migrating the state of virtio-net early 
>>>>>> (before the
>>>>>> stop-and-copy phase), we can also start staging backend 
>>>>>> configurations,
>>>>>> which is the main contributor of downtime when migrating a 
>>>>>> vhost-vDPA
>>>>>> device.
>>>>>>
>>>>>> I apologize if this series gives the impression that we're 
>>>>>> migrating a lot
>>>>>> of data here. It's more along the lines of moving control-plane 
>>>>>> latency out
>>>>>> of the stop-and-copy phase.
>>>>>
>>>>> I see, thanks.
>>>>>
>>>>> Please add these into the cover letter of the next post. IMHO it's
>>>>> extremely important information to explain the real goal of this 
>>>>> work.  I
>>>>> bet it is not expected for most people when reading the current cover
>>>>> letter.
>>>>>
>>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>>
>>>>> What are the data needed for the dest QEMU to start staging backend
>>>>> configurations to the HWs underneath?  Does dest QEMU already have 
>>>>> them in
>>>>> the cmdlines?
>>>>>
>>>>> Asking this because I want to know whether it can be done completely
>>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>>
>>>>> If src QEMU's data is still needed, please also first consider 
>>>>> providing
>>>>> such facility using an "early VMSD" if it is ever possible: feel 
>>>>> free to
>>>>> refer to commit 3b95a71b22827d26178.
>>>>>
>>>>
>>>> While it works for this series, it does not allow to resend the state
>>>> when the src device changes. For example, if the number of virtqueues
>>>> is modified.
>>>
>>> Some explanation on "how sync number of vqueues helps downtime" 
>>> would help.
>>> Not "it might preheat things", but exactly why, and how that differs 
>>> when
>>> it's pure software, and when hardware will be involved.
>>>
>>
>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
>> about ~200ms:
>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$ 
>>
>>
>> Adding Dragos here in case he can provide more details. Maybe the
>> numbers have changed though.
>>
>> And I guess the difference with pure SW will always come down to PCI
>> communications, which assume it is slower than configuring the host SW
>> device in RAM or even CPU cache. But I admin that proper profiling is
>> needed before making those claims.
>>
>> Jonah, can you print the time it takes to configure the vDPA device
>> with traces vs the time it takes to enable the dataplane of the
>> device? So we can get an idea of how much time we save with this.
>>
>
> Let me know if this isn't what you're looking for.
>
> I'm assuming by "configuration time" you mean:
>  - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>    before we start enabling the vrings (e.g.
>    VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>
> And by "time taken to enable the dataplane" I'm assuming you mean:
>  - Time right before we start enabling the vrings (see above) to right
>    after we enable the last vring (at the end of
>    vhost_vdpa_net_cvq_load())
>
> Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
I guess what Eugenio may want to see is the config with SVQ=off (i.e. 
without x-svq=on in below netdev line). Do you have number for that as 
well? Then since vhost_vdpa_dev_start() it should exclude the time for 
pinning, you could easily profile/measure vq configure time (the CVQ 
commands to configure vq number, size, RSS, etc) vs dataplane 
enablement, same way as you did for SVQ=on.

Regards,
-Siwei

>
> -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
>         queues=8,x-svq=on
>
> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
>         romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
>         ctrl_vlan=off,vectors=18,host_mtu=9000,
>         disable-legacy=on,disable-modern=off
>
> ---
>
> Configuration time:    ~31s
> Dataplane enable time: ~0.14ms
>
>>> If it's only about pre-heat, could dest qemu preheat with max num of
>>> vqueues?  Is it the same cost of downtime when growing num of queues,
>>> v.s. shrinking num of queues?
>>>
>>
>> Well you need to send the vq addresses and properties to preheat
>> these. If the address is invalid, the destination device will
>> interpret the vq address as the avail ring, for example, and will read
>> an invalid avail idx.
>>
>>> For softwares, is it about memory transaction updates due to the 
>>> vqueues?
>>> If so, have we investigated a more generic approach on memory side, 
>>> likely
>>> some form of continuation from Chuang's work I previously mentioned?
>>>
>>
>> This work is very interesting, and most of the downtime was because of
>> memory pinning indeed. Thanks for bringing it up! But the downtime is
>> not caused for the individual vq memory config, but for pinning all
>> the guest's memory for the device to access to it.
>>
>> I think it is worth exploring if it affects the downtime in the case
>> of HW. I don't see any reason to reject that series but lack of
>> reviews, isn't it?
>>
>


