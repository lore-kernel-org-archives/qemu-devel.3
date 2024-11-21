Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCB0D6ED10
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 11:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE5a9-0007M8-P8; Thu, 21 Nov 2024 06:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tE5a7-0007Lo-Ta
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:42:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tE5a5-0001cd-Jp
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:42:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7Fv0n026269;
 Thu, 21 Nov 2024 11:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QQXnvkbH93E3K0pUCE9WujtNPRI/G/JF9ljGJCtFfuY=; b=
 mh9qbS1ROFiDaRM9Pvnz/B6LGT1PgmBBlXxpJF5wXs0EBhj7pX1JVKxNYerBq/cw
 HlhUR0t2LcBTW7Lwm099eGQgaifmh/8ZSxwP9T+wqYLNeS6g5K7zbtr0dJQWOwfA
 KkcduiL4z9cNQPCofnvK+FFDd5hWNicg2bjl3Taap6GETvYpu94ovCWoNTxY6SsR
 Cs9ZHDJBZTM8H5AZX2inpEMW5PMPfCX8IqneY/CM2A1VkV/Rq/M3t4rgxHkr3TNh
 BvDDj91TU9TvxC91qU9cm7mQ9GQJxPhe6+rI5seZf+uFRiDB4ceWGsbe8DrF2rnI
 t7U5XP+NGK/gW537icNAIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430xv4v13p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 11:42:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4ALAAqRc039272; Thu, 21 Nov 2024 11:42:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhube4dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 11:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqqw6AlmStdtsdJTxobkYOunPICFylTI5Sw8CAStDpzdwJFOLEHISidAsDYYlGVadixhVkxPWFduk3n/fCWwN7KVe3dWPfeORmY9V8M/3KknwG2jkzCe+vOnzFpDi24C0NEwfDDrGQpa5WklM3ps5la3llrNXdNIdp8ZNWDUp2sKOU5bxPGVSEk0WbH1ptgZOyaUKv6YX9hIOc91R+wiJpD0sik37gPkrBTJP0ZNykefa7dyIHGwCV9eXPutKoV1/3/yGiF+nXYR0LMjx5Wh7lFsZ8PcKs7Cfk5kNmviZKIY6g0seMtUF8cMGF4lqifHBKAlNjWKjo2fYXIqncQ9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQXnvkbH93E3K0pUCE9WujtNPRI/G/JF9ljGJCtFfuY=;
 b=laCuyUQNDVSG36OGlRUP2Spmk2/tlydfRzRl0A+b4KRuAot3+3SC8ck8VH9PLT2z71eBU3RPeazR1idZVSsbLs/+wTN5SA/HBSOYvN75GwMqjZ655gHlhTTvniBdRGTxXCa/g2hSHyiSPuDYzdu76ycxYajYrtC7+rf02XUxOJzjGwtfhd3ThJiu5X01ICmHlfPPQUJqgjonn0UTHXLlPn8+IcpfyhN4XaUsaTa4VGcj44nZqDOPdAywEVkuNAomamuucVQt3Kn0oHzek80XxMn6tqRJzHdO8oYIv25BC9kwpWBQ/NdMJWulMOoM1bOcUsDICIZCFNwKs0Az96S/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQXnvkbH93E3K0pUCE9WujtNPRI/G/JF9ljGJCtFfuY=;
 b=wklA8XERO+oEBolpheDUW6TdvRf2qOK8YiqWr9Q4ZGy0qU52htNfb1wFQraiFscJqMyNdXyabBHjcY7loCWjv2n1a3LfkN+RQyI4WMVTj4qgENx/cqB403NJeI8sHrgCmw5H0LOJ30al/6S9wi/8WtMSApxZASqYxYFGWDdM1Ks=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 11:42:31 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 11:42:31 +0000
Message-ID: <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
Date: Thu, 21 Nov 2024 11:42:23 +0000
Subject: Re: [PATCH] hw/i386/amd_iommu: Allow migration
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, Ruihui.Dian@amd.com,
 bsd@redhat.com, berrange@redhat.com
References: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH8PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f73d9d-7221-4bd8-db7e-08dd0a219510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Njk2ZC9FUllXVFlTY20rS2JFbllGNEdiT1JJVW5NbTRUMENhaFYzMWtFejV2?=
 =?utf-8?B?N0V6TTdxRG5FZnY4NkNSK0phL3dNVmJEZmIxVXFUUnh3RDFlQ25zR2RzU0Ev?=
 =?utf-8?B?V1o2cEJIVTJVbEVTcEcwUWY4ZHFoN1V4VnBiNTNRMmlsMlZMM054Uldsd29C?=
 =?utf-8?B?cUlFYU5Uci9rRzZRTkgzd3JwSzRxcEU3QWQxTWtONWFSNVV0OHlxcmZQaUhZ?=
 =?utf-8?B?V1R4Qjh5WFcrOWticDRENE1Nb3k3NnVBVlZSQzVoZjJ6amFyVnNrbk9QSjI0?=
 =?utf-8?B?M3FFczRDZ1dTSmtJd3dSVHd6MzZmc2huWVh0S09sVHU4L3pQRWl4Z2prZlFC?=
 =?utf-8?B?d1NVdEFVTHJEdlYrblJsVWZPK0pQQk9PQjJ2OVBUZVBiTFMrZW9wM2FyN0Nw?=
 =?utf-8?B?Ym5UZGJmOE1uSmh2V3YvUEJrL29NaDZ6bnlPaDNWN3RmR2pkdk5vNWpEcmFN?=
 =?utf-8?B?bFZPbkdLN3B0SFFYZDloUnE5RWRJK2ZGVHhLZjF1OUp0VVBUb3BTeVUvVE9k?=
 =?utf-8?B?NjJOL2ZBb2Fkd2s0MmFZdWNnSW5MeHYyRUl5Tk5CZFN3WEF0Q1MwWWJWSHJN?=
 =?utf-8?B?YjdiVXpNWGFteC84ai8xODY4dGFubW5vSnFkMHlVdE1nRys4MXRwSEFPRHM4?=
 =?utf-8?B?a05hYWJ2bGtCMjZhSWRldStoQXFUWWYxUE5EQUpzMUp1U2lMaHBHZUFtSytK?=
 =?utf-8?B?VE9td1BmRmJpdUZzQzJKdHhETlJUQ2diUnhaWHJoRmxFMkpvdzEwVHNZdW1r?=
 =?utf-8?B?aWl2ZXp2emtuRzM2MmxUWE9ZenJjS2x2VkUvcENIL3g5WmRMTEIyTU5Pclhz?=
 =?utf-8?B?dHRsYjViakNSR3N5MXlUUXIzWEdyMHhUTzJrRml3ZW1VYlV1d3VRSmpwOTdu?=
 =?utf-8?B?TGw1QU5oUlY2VDdJZzRrZXdmWjBvZlQzTEQvSDhJeVcza1FHd2RLT1NxY04w?=
 =?utf-8?B?ZFhtSjVvbTNkdlZzazJ3dGlzOFBLK2RxRUdxY3ZpWlZwOVJvd01lZWs3ZWx3?=
 =?utf-8?B?b2lJV0Z3aHF4SkxmUUdSWXdTVE5GSUtUb1VZa2l4VzZ0a2RoRWd5VkFRMEtX?=
 =?utf-8?B?cWdtaDkrMUYvYWJMdE5uVitZNkU0V2JkUitwYXVZK0dETWs4SEs5YlU4Z3RH?=
 =?utf-8?B?UUNna0NyS3p3TlcwMmdzL1pVbG1ZNTZiZWhHYmFldVM5elZmNTlMZzhZcklM?=
 =?utf-8?B?ZVQ5NFRHQnB4TVhkb2xIMjVuTVQ5N1YwTjk0S1lKOWdRNXFROGlzS0FqYkdh?=
 =?utf-8?B?bG54MTZDMTUrOVRMMkxYVzRHK1dzbWMzY2JkZU1FYlIwclVMcFVoK1Rkb1Iy?=
 =?utf-8?B?cUdUVkJ1QktLUWsyc1Q0RnNUSExTcU5DTGxNZ21GYUJsOU9ObWE5RWIzSjlV?=
 =?utf-8?B?TE5kTnhoNGN6aFlMbndyRkNjV1R5ZVhzZUk5SnJJZ3JWYnFVcHQ0c1JZcXYz?=
 =?utf-8?B?L1RDd3I4cEd0djZwVTJJRkNsOVlDOFdMYi9DY0dkb000WVVxUlhLZUFaNURO?=
 =?utf-8?B?K3FOVERsL0JVakh5bnltSFNYUDJ5K1d4NCtabW53MmxyUHlRU0xKUzJ6Tjlp?=
 =?utf-8?B?MThUaVVPdVZsNEJSbHFEMFhJbytLUVYxY0plY09aeWxQZmpnSGZZT0taRk9h?=
 =?utf-8?B?b3FnVUp2WjVZRlBLRW80RCt6eUpFWFhUYUFTSm12SU44OXZIM1RCRFM5T0x4?=
 =?utf-8?B?RkpZUFBIeklmdXdxb2I4QVRnMTk5eW5BdEV6aFMrdHFHNFdBQmVNeDg4VEZB?=
 =?utf-8?Q?7EQE2qUR1GN1JHyY46YqWi6znrvwJGrYINbsZ8s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZ0NDlIbTVBd1l6T2NVT05xanJMeWlJL2ZqK0hyRVVzWko0YjdSNmlXQmVJ?=
 =?utf-8?B?a3oxU0xoK1lzZTJJcFFBQWRrTjNHL0NRb1F2MlNhZ1UwNnh0VlkxTTE0L2lJ?=
 =?utf-8?B?dUkxeUFZdDMzL2lueWd5akFyZ0p5QkFURnZJWFB2RFp4UzhNYUlMVWI4VXRu?=
 =?utf-8?B?RmpBdmtIbDBzYTNSclJDekN0UWJLTlNNOGRYSkh4NDQ1bEdnaXJBbWk5bWQ0?=
 =?utf-8?B?WUxrdHd0ZlBEZm1CRFpBVXVFZ0xWK1RBVmZDN2VEUVhFV1I2RWVJRWtzZTNr?=
 =?utf-8?B?SktiZm15WEdNNzVubnMxUVFmd0NqdHEyN3lWL0JPUjF4RFNIYXJkWUtoRWFl?=
 =?utf-8?B?YmNlam8wQXlRYy95czV2YzFPZDhlck5Na3VGRURYeWpBSkZXMjJpMjBvK1cw?=
 =?utf-8?B?a1lTaDFpKzRSU3N5RTZDRU5wbldXL011aDFyUEtEenBzYnpLQk5wN21RRUQ4?=
 =?utf-8?B?YnpDSnlndnpiRzVtZjVHUC9BOGc1U1loU1ZLb2FBSjhwV2ZydU1ma3c3anNx?=
 =?utf-8?B?OWM3a0Q1K0dUWnFKRTVmenl6K0RqUkEyTUJIWnVBMzNDdGV6bnZHTjVDcGVQ?=
 =?utf-8?B?Q09tb0ZlTnJMWlJNNHF1WWc2ZzkzaXgxZ05xc01vVkFnbHFYY1NEd3orNEFs?=
 =?utf-8?B?TUVqYUticXd1S3RnL3ptaUZEcmx2a1J0U3IwVDFvVHllaXB2OUNYQ3cweitr?=
 =?utf-8?B?UnZIaHI5RlNoT0dYa2RWL3NwT0Q3cXhGeXVyTWo2UE8zMFZIU1NIOXdLUXdu?=
 =?utf-8?B?SGxLdWpMTWZMbGZIMzI3RjRxRGg3WGgrazlqSGNHcWNWbjBPRitaZm16WTAz?=
 =?utf-8?B?QTI2Lyt2czJQYjBtRXlEY3VQNFRRM1psaDZxYmpIVnpyZHdaMTdWdUo5Zloy?=
 =?utf-8?B?TG0rd2tscko4TkZPcHB2T3pHYnFjdFRNbXJlOXVhd1p1S1gycjErSkcvcG9H?=
 =?utf-8?B?S3Z0bTNtbG9KTEJmcTh3V2VMN2FFVHd6NkNRNUJZRHhLTVhMblhJSEZYVHIv?=
 =?utf-8?B?U2NCem80SFVwQjl0REszcmpYeit2UU5yUXdWM0hNTkZRZWtuOWNCRnhOSVlv?=
 =?utf-8?B?bkZJY2hjdlh3eUs4NnFCdlB5VXl6K05obWJuR1hOTXRmRTM3YkJYd3RwajEz?=
 =?utf-8?B?UHNaYSs0ODZ2S09PcHAzc1paOXRZb3NIb05WTHNzVDBqRmU4R3JxK3NoYWZ5?=
 =?utf-8?B?UFBFVGFzVGpML01pVm8zSVJiMm5lUC9OMkxYelhiQld2UmhHaUhhd0ZhNU5t?=
 =?utf-8?B?bCt2NXg2czhUSGE5QTNoQUIydkdma05Gdi9Fb0JtckMzN0F0dEtLSHZmNXBX?=
 =?utf-8?B?NmtmaGszbE1aOU5IeTFnVEVYNWxaWGdrNy92aE82eHFvQ3c1VXhxNDJ6OWQ0?=
 =?utf-8?B?dU94N2wrYXlFZHh5NWRzSEVhRGFsdzJrZ3dMdE1JRXU5bVV1NERQTDBwdWdp?=
 =?utf-8?B?YXc2Sk1SclpndjZPMzhvY0dYZmlwUUhvVUpwR1RxRWJ4MDVvQUdqdTRRQTAx?=
 =?utf-8?B?aEpYZkxlam1sZ2NSZDdpQ0hmNDA3QjBpRVNLYzk4QjFnUTd5endVRFcxc1ha?=
 =?utf-8?B?SXYrWGQxZ28zbFdpQ0hTcGRVZmZnUCtab0dLZ0tWSTNPMEljakVMeUlqNUg0?=
 =?utf-8?B?L0l6ejU2MEcyUUZDeW5yT3lkZHlWUWV1WVVydlA2eHh4Zm9qUW5Fd2g3eTRm?=
 =?utf-8?B?TDdvQmhHRlJzdXN4ZytFSHBhd0pYUVlrR1pva0FjUDl6bmJuTHRBRTVhOXdE?=
 =?utf-8?B?c2VqT1hsYlBZcUdUY3R5YUc3YVNycWlmZVJPWlNlcHF3SjJHOElmdmREMmR2?=
 =?utf-8?B?RTgxV05RMEJONmFYWnJuRTJLQlFYSTVCSWRDOTU5U0VIME5VR05rN2ZWZ2p5?=
 =?utf-8?B?QThiTDdVMEh6TEk1Zy9qOTAyN3lySWdTMmlzQ08rWUFaZkxxaXdhb0tYNC9L?=
 =?utf-8?B?QVRpS2MyMW1odkpnUTIzN1hWS01CMzdhUkxyaTErSm9oTklvRmllYnN0azR5?=
 =?utf-8?B?SVp4U2FOdmJaZEgvc2JTZXdZRk8wMHI1UEVwYWZ3NVo2UE5ab2Y4SmxpS2h5?=
 =?utf-8?B?M2dLUU1QTkJvNW5jK0Flb1VyWVBKV0V0U1k5MkM2MjhWSkxzZ0oxdE5lZkNt?=
 =?utf-8?B?am94Z0VndjNhZ0ZhQWtFZkwyS0JBcWhSbFBYVzlCcmhGOG1hRlFFQkpQYmVC?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0p695M+hAmJRMP6HsGxEHXzP7ZwOY2M1VJJLxGFFL40Y+yE54hi26W7Z8Ql5J38HNnboFJKUMd5cIZAudCMJuSIT3F0GTCSXId8nKKyvm2vaeDjzc8I32SNHqoEgKTv5Yd72orkZiD3AKnbs+D22FwEoFBKxCLlb2+FGbKkPsCL+hWAlwCn/LWWZCrSMzDUWErkfmXF1aEnRmsWsMH7zzNhVvj+iDs1+/xCDBNJh+e5+uwJx+TZbattudhxunTl+G8PgtVwvXqNOYLPNLFei+ABfWs6XF6Rvb5f1KRIc1D7NParqknwHxACT8aZb4K4zP1nHyuQF2AVacC8U7PCas6kwmo5fzml2gi9s3tupKX7nE0dw/2e0taGKLL6h79AycvO+MWaEbOOoxNI3HV2VqZKsb59UVQFYnED8imbomdHxqcGE++x52OX63/EmOPzOIgKlP03C8a6LP6e6MKIjDsViBgB0DAgal6dR/cV542hu3I25gxcR36TjQ7dpnBV2BebfZsgT5AYANKxKNUMkzWigYIS8khdQQITH+SSJpYtymd+6fAM/9FfvFdg+il29nKuULo+5DPIy2HpM/FQKExbUbtV/AqGLdx3Nl6wM6rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f73d9d-7221-4bd8-db7e-08dd0a219510
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 11:42:31.2390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXSU1RxOL3odtFQ3IdZwpqncS8r/TUBm21hz2u/u2rG0iJU+KzXKeTvSSclinmyBsItZryv59qzYdeab8xJukf2y0yttMSD1fb3M6pgdzS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210091
X-Proofpoint-GUID: Isb1xTXSe2mXjQqGYhsBfPOidzkKTdq3
X-Proofpoint-ORIG-GUID: Isb1xTXSe2mXjQqGYhsBfPOidzkKTdq3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20/11/2024 07:31, Suravee Suthikulpanit wrote:
> Add migration support for AMD IOMMU model by saving necessary AMDVIState
> parameters for MMIO registers, device table, command buffer, and event
> buffers.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 13af7211e1..3d2bb9d81e 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
>  
>  static const VMStateDescription vmstate_amdvi_sysbus = {
>      .name = "amd-iommu",
> -    .unmigratable = 1
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .priority = MIG_PRI_IOMMU,
> +    .fields = (VMStateField[]) {
> +      /* Updated in  amdvi_handle_control_write() */
> +      VMSTATE_BOOL(enabled, AMDVIState),

no xtsup ?  I guess you are relying on the dest command line having xtsup=on
like intel-iommu

> +      VMSTATE_BOOL(ga_enabled, AMDVIState),
> +      VMSTATE_BOOL(ats_enabled, AMDVIState),
> +      VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
> +      VMSTATE_BOOL(completion_wait_intr, AMDVIState),
> +      VMSTATE_BOOL(evtlog_enabled, AMDVIState),
> +      VMSTATE_BOOL(evtlog_intr, AMDVIState),
> +      /* Updated in amdvi_handle_devtab_write() */
> +      VMSTATE_UINT64(devtab, AMDVIState),
> +      VMSTATE_UINT64(devtab_len, AMDVIState),
> +      /* Updated in amdvi_handle_cmdbase_write() */
> +      VMSTATE_UINT64(cmdbuf, AMDVIState),
> +      VMSTATE_UINT64(cmdbuf_len, AMDVIState),
> +      /* Updated in amdvi_handle_cmdhead_write() */
> +      VMSTATE_UINT32(cmdbuf_head, AMDVIState),
> +      /* Updated in amdvi_handle_cmdtail_write() */
> +      VMSTATE_UINT32(cmdbuf_tail, AMDVIState),
> +      /* Updated in amdvi_handle_evtbase_write() */
> +      VMSTATE_UINT64(evtlog, AMDVIState),
> +      VMSTATE_UINT32(evtlog_len, AMDVIState),
> +      /* Updated in amdvi_handle_evthead_write() */
> +      VMSTATE_UINT32(evtlog_head, AMDVIState),
> +      /* Updated in amdvi_handle_evttail_write() */
> +      VMSTATE_UINT32(evtlog_tail, AMDVIState),

Are we missing:

	ppr_log
	pprlog_len
	pprlog_head
	pprlog_tail

  ?

Although perhaps excluding it was deliberate given that these aren't actually
fed with PPR log entries, only register initialization. Given no PPR entries are
generated it's doing nothing useful.

Out of correctness this is guest initialized data, so perhaps it should be
included such that it doesn't suddenly see different values on destination. In
theory you 'just' need to wire in qemu a VF generating PPR log entries for page
requests, so the log will eventually be what you need to migrate anyhow like the
event log...?

> +      /* MMIO registers */
> +      VMSTATE_UINT8_ARRAY(mmior, AMDVIState, AMDVI_MMIO_SIZE),
> +      VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
> +      VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
> +      VMSTATE_END_OF_LIST()
> +    }
>  };
>  
>  static void amdvi_sysbus_instance_init(Object *klass)


