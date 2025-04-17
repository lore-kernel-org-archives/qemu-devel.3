Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57A3C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UIE-0007zb-ON; Thu, 17 Apr 2025 14:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UI7-0007je-Aa
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:48:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UHv-0004r5-OX
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:48:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMqkL004089;
 Thu, 17 Apr 2025 18:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=s93t4QiqKRK5VUNl9O9cgKn6WAva0xcfsxm3ZT1Y+6w=; b=
 Q29X4wETwkb8QIVCoxp/2KFu1cp7IT5Mi6Jo0i0VK1jNC1ru5SPYE35P+lkBvQXW
 rMeQLtnq2nWjFz6uSdaMx/6V3FzUow+HXmLc+vaU5ifSVxuXFGJl11RZXM/VCm0y
 coIqUyh9dQPbLpwat7ZS1wUJm7tB+dVw2VBQZ/kKEvzDAKmsonrZXw7xaAWd6wUK
 fbS2+TiOJh8VjlDp6ORfClQtE3UeSR31TmMfCKveANP8ViufyAc1SbZzyuNPdFtu
 UF4rvNVZ685nih67FdBSyBuM3VycRFZbDJf7+VHxnUGSWXs9ywaSXFVkSKzSiXIm
 D1fFUotr1jwVVF/PC5gxwg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf7a2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:48:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HHL0GD009267; Thu, 17 Apr 2025 18:48:31 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3nnanf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sae6bCtYIDa0YfwwQEJhOuz/BZMFdXO2b8/Qt5/gi/3KeASQSCml/jMRm1aCP2zEKAcsgymM5+bwMiHiY1EDqk3r3WamaWcEBwaolKwkcO4YgWEuMi6MSEi118na19BmzDzA3uAQw+6LcSCAE+H3nUz0vNoUg/ciD7kTpuXTxHazc2ZNTcYnLWGrwMP4A537TSuO1mQOsgVwljadkUM3YMVHRyVOAW38u3cLH/EN3DNt9PZon5+PCGvmHxKMA+UObZU8CWFMC+gdt8KWm1381O+nq1V81Q3jHdBt1BDIiylRJCW4UpdxkyoeWL0PwwA/c8qMPXpzE6QPTV/hPyJOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s93t4QiqKRK5VUNl9O9cgKn6WAva0xcfsxm3ZT1Y+6w=;
 b=VSyAjxDv4QfY3kPhmGsUxH1Ww0/vutFL/dwREaLs/XY9wL/byT19PFZi6JN2QExbxqzCkvDqglfKpTKE1aB3Qq2A/NOn+vDi4XZFUTpIOItcQhXmu8HBNxI4x2HDoVhK0S/79I4f4BHbUsaQQIHmw4oOUJVX8xuEhgpseyzzGPGsnTAm/32OtotiMp6hq0mPQPbzWNdB/QAqwvC4BSSTey8WWRuSTjW9232SVnhMU1nxzwt+TdBvD4uhmYZ0ZAKJcVDoCA6rbxONdEoefs3Y1xpnqeKVp4IrdbGefez2cDrlHEDaBI8Y0I8ayHxWHziSGnUYyCbJ49yfd0qF+U6PQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s93t4QiqKRK5VUNl9O9cgKn6WAva0xcfsxm3ZT1Y+6w=;
 b=LlSwUgagCxsuS8okJAcqwEJig9zuVArruUff7UgsGSkvLqjjqoMDKTV6nt7RmCBYviS1cg19dPiitNL+CRS0uq8dxixECIFZ70VlOv/e1bkHUAYsRQ29ewJFJW65aACSEoiVBUgiEnbF08ooWR5D41Ido3pngU/8+om/7dUd8z8=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 18:48:29 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:48:28 +0000
Message-ID: <5ec7596c-8a3c-4d6a-85e4-cdeb7e9e403c@oracle.com>
Date: Thu, 17 Apr 2025 14:48:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 06/13] test/acpi: allow DSDT table changes for
 microvm
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204204.2966-1-annie.li@oracle.com>
 <045c7cc0-f67d-4511-a695-95bee96de087@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <045c7cc0-f67d-4511-a695-95bee96de087@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN7PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:408:20::24) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b91789-3ac8-45d9-42cd-08dd7de07141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzdHRHBySzM4QjIrZ0dGN1h5R1UrUnUxZ1NiTzlGMXB6Q2p2TXNPWHlzWVQ5?=
 =?utf-8?B?c2cwUWZoVHU0SHhpTjE2QVBIOUVob1J3QURlSE00UmVlcDlSdG00YSthcEhp?=
 =?utf-8?B?QlVIZWNrbDBMa21NQTRvTWx2djhrQlIwSFNUSCt1ZmdtZ1VWYW5mWU1VYnhh?=
 =?utf-8?B?WTJxSkZXWVBYZU9EWnlDaGlGR1RlNXJFNDg0azVId1BSR2ZORXJGSEJFVms3?=
 =?utf-8?B?TlhxZ3dockhsU0lKUG1Dd1BLendlZTF3WUxZMFdRQkYvZjRsNGFEd29DQ2Er?=
 =?utf-8?B?aVN6VkVvR0tKR3pBL3hQbkdQNEpKcEt3V0lrb052NTBYcWZCMzVYWmRLV2tY?=
 =?utf-8?B?QUxjQzVPaU5hR3JadGgyS2tNUEthMXhRZG5DR0crVGs2aHVQR3o3MGIwRWhu?=
 =?utf-8?B?eE5iZFBWRVlUV0F5SEV1YjhYMksxaTBCdHlSL3dycThiaDRNd0Y3RVZJREs0?=
 =?utf-8?B?U2FJeU9rTld3c1ZWWmhrSzVTTFVRSlJyKzF4MVc3NHJiM0RCNERXemlIV3Nr?=
 =?utf-8?B?Z2c1aDVMWTAyVHlabnNuYitQdCt1N2FQaTlGR1NGUkRJcFF2bm1Bd0d4cmRm?=
 =?utf-8?B?d1JrSGRQMDRob1hJT1psaEtodU5IcWNXWWU4bFdtejArMzNNY3NOWG9zbWVH?=
 =?utf-8?B?bE9udFExTWlJZWd4UXJHdXBHbFEyMDVCYlB0OHlXNnRWWGV1cWszUjJ3LytT?=
 =?utf-8?B?OU85S0ZSTnA5T3dQYXdqZjF3Q01FZ3dsZGlwNnk2NDRDdU14UVdIMGsvUjRz?=
 =?utf-8?B?TWlBeDNBZUtnc1gwdkhRK0hPc01yMDdCWE5tNFJEazAwK242cVZyU1RMUUZW?=
 =?utf-8?B?U28rOTFpWHFGNGVTS0RwUTA5eGJITmhVam5EazlKZlpTN2RWWElZYlEySTVy?=
 =?utf-8?B?enBUck53aTlzYytycnRBNE5mMDl6M3JsUXJMTXJ3NHE2ZEMxYXlQSmRMcld0?=
 =?utf-8?B?U0dNb01RMG04djlNdCt1WU5WenhZa0xrdERqUy9TTTR0WjVEcElxbHBHREU1?=
 =?utf-8?B?cDdUejdGZTFlVERXcVNUZ2h0dEt3aEptc2s1S3h0WVJ3bEZudlNjWWVVWTFj?=
 =?utf-8?B?UkRPZlgwdnYvVzFlYzBPUjBEQWZqQ3A4MnJuV1p0dWNFemd6azNHSms5bTMy?=
 =?utf-8?B?V2NyU28wRjM2azdNWnJIQVRWZ3JaNzVpYWw0K2E4aEM4aTJjcHc5TzRPczA3?=
 =?utf-8?B?NDVUaGtTYmtWL1cxSmVTNFNhcE1RaEdQOTIrcGpjRzNXNnRuSnBCNTVuQ0h5?=
 =?utf-8?B?dThHNU5RMXdEd2ZyMVBBRzNCbzF4dWIrNzZlZXRwNGpSVERRbzd3VTRxeTgz?=
 =?utf-8?B?eW9NL1k5NjJ0aHdhQnR1N2xLVHphcFZKNnlydERneVBJaUxWVkJLK1RNaHZl?=
 =?utf-8?B?dUU0QnN6czVKZWVISllKUlhBbmRsaVd1VXI4VDFleW81USsxT0U0a3dlYU52?=
 =?utf-8?B?T1NjQXJXSU5CRXovN3hlbFVtbWNjWGh2WjV1K002UEpLSHFCcHFaYjYwb3NQ?=
 =?utf-8?B?bWFkVE1sRmg4Y2lrbENBcnNmQWpHV25wc3dLVUlrV29ack9Lc04yZGRuOUNr?=
 =?utf-8?B?cmw0WmlTcjNmNEJZalFEU1VPN0xSOEx2YzVmYkg4VXFhQXdHaG1tM2VuMkEx?=
 =?utf-8?B?dXh6RytLaGtUVEtRaXlXWTVlYzFnNWVnUUJQZUhRWG5FYU05S3F4RE14dDBm?=
 =?utf-8?B?QjhjdWZxRGxIRFVqQk92YVU4MmM3dFV0dnd2Ly9vM2k4L0I2ZXVNeXlYMHpy?=
 =?utf-8?B?MkZrSFdIM1YwcnViMHdVdXpPbEJPNTVoWmJKeXczckNDYWV4QXcrSW1JOTY3?=
 =?utf-8?B?N08zU0UxS0xZNVlvSDh6dmZHODFaRkRnVVY1R2R5R25URTFSU1UwMFFmZnlm?=
 =?utf-8?B?OTdxTys1aVJJMVJCOE5VOWozZ2JYZWJBcUcwSDh6MzJnWGVZcDJ6eVZ2Q0tG?=
 =?utf-8?Q?WtssQHsyplA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dWNklvMEZVcGQ1dXU1cW1yczB3cERUZFp0c0c0TzdWU2sxdkNFMmMxY3M2?=
 =?utf-8?B?a0x5by9EYlhxZU9BazdDNG85L3JISnl2L2k3bUxVbmwrK1NsUG4xcGloSlYr?=
 =?utf-8?B?ekEwU1g2WHRBVjg2cW15SVlmcFNYU20zY2sydUtZb01uQ044U25ZeFRsTXhY?=
 =?utf-8?B?RDEweEVHVjBub0hEMGZvTEZJVmpDQXk1RDZtMGdqT1JqMDJ6Yjg1VDg3ejc5?=
 =?utf-8?B?TVRCS1dkREU5NGRUc21EeUNGUEVSZ1JEaTJwWGhBRy9RT3A4OWJnQjc2UEtN?=
 =?utf-8?B?eDlZTDFzeTFDODNuYXdXR2RzOTNNRHlSdTg3dGpFZWJVZjZFSjZjWkc0S1hC?=
 =?utf-8?B?MnZ0MVdSZC8xS0VkVFB2elJjVGMweERtVHRnK2hKV0VnT0tocGgwM1hUeFJC?=
 =?utf-8?B?dS82cnFSM05SbDg3emJGZ2FxZGJpZktobGhmWjBHcUJsajVvWHRnU1FWOWZq?=
 =?utf-8?B?czB3RlFtNi9kRVEydTBEeStpOG10TFkyQXdOenc1Mm1pMGFWdG95QjJxV3h6?=
 =?utf-8?B?UzgzTU1LdzIwNDd5YVNDdERRR0w2ekFSVGllL09TUGNpOFRFV0RlTWJSdHVM?=
 =?utf-8?B?MEdaTzhoWFdDUldXaE5RS2pYbmRNeGhEdEM2NXZNR2dsbDlWY0RkaWlxcWZr?=
 =?utf-8?B?NS9IdVRlbGduOTU2elFQSUZxNWpsT2xEdUJFWDBXaGR5TGVYMkNuenMwUks2?=
 =?utf-8?B?ZXBtb1JLTk1rWWREYno5UUdYUUdtS1J4NGtjdlAzcFpraXV6VjdmQ2VselQr?=
 =?utf-8?B?WWpTVHBIRUNycThUd3d6MldMZGxhUjdqRWdDUXJvRjhKZEJ0Vis0bUJ4UVU5?=
 =?utf-8?B?UlgrWjBKaTNsK0pmQ21LdjZuVnB1cHowTzl4bGwrNTkrMDZkamwvYitOdEJK?=
 =?utf-8?B?RWMzdzFhWFl4ZzFMWC9DU21pdEdRc3VXUjlpMlROTTliVEtsYmNNNW15UE53?=
 =?utf-8?B?UEF1TkF3TUQrSnFPVzBGNzdzcGp6VjBjT0VRRmh1bEFJWGRCTHZCOGx5NTlu?=
 =?utf-8?B?RzlOZWUzeDQrcUFrdndRU3NWa3RVeldBSUpRbXNySnZjSndKc3VUYXFXK1pM?=
 =?utf-8?B?Z3hiUGpWVlJIUDlhWm8yWkJucEhlSDBUOFRlQXM3MlBLVTNXdk1nQ3FLVUl3?=
 =?utf-8?B?UzR2OFFmd3M2dzlpYmJiTitVczZYZ3Vkd3RoTWFVUks3Wk1IUXhZMGYxbHIz?=
 =?utf-8?B?YkVQaStxODUzclN0MzF1dmlUVXMwZ1AvaHMrckNMMUU5V3JEaElRN1lmcnVV?=
 =?utf-8?B?ZkcwajlQVkI4alRCQ2NLaUoydXFPQlRBUmpIemluOUw2aytBUTdBNEdXR2JG?=
 =?utf-8?B?b0xiUXlzcUM5RWxEVURKdnRad1FNYkJFV1Bqa0tDNDl2aFAyYm5RaU1nMHk2?=
 =?utf-8?B?ZFVlQlZKdzNPanNEZHNtZ3FTdGV1WmY1M2s2aGVXZWcwNFVKNUZsOWV2bW5m?=
 =?utf-8?B?K1U5M3BtWnlKeXh0NFNKYkJTMWdEU28zc0VpY1ZPYmQzZnl4dXNES3JiaXI3?=
 =?utf-8?B?Rys0QmxmbnRxUkw0MXk1UDF1WjJST1YwQTlyd2lNZW1YZExrbmZTS2E3Mzg2?=
 =?utf-8?B?bmJuYjJOZmJUaTdHd0xDZTAxQXhKV0Z2NzBCNkNNODJwZGkvRjhCeVVwWkx5?=
 =?utf-8?B?WjkxS0lpT1J2WnZ2dnZMR3VHa01yWWJEN3hpT3lpM2lsNitRaU1aSXU0QjI2?=
 =?utf-8?B?bHZvcEZRcXczQjdhZTVBZ1ZRYXUzNjZmRHl3OTRVS1hsb3A4dXJ0Q2xDUjVS?=
 =?utf-8?B?alJ2T1Z1cDJhbFgzQTJlSUpmTEd0ampqWHl5VW93OXZvVW1PQnJ1ZkUvMHZn?=
 =?utf-8?B?TlMzS1haZWNrL0hkZk5WTWtGVVZHeXlFSSsvVDZVWjNQZDR4WEZya2JKTjJE?=
 =?utf-8?B?Z2tYZnA5RjN3bTdOZFlUbTRTb0U2ZVlzcGVOZStkOFQ2dCs4ejBtMHY4ZmJw?=
 =?utf-8?B?TDJRZytGTFg2Q1R3SlIzdnA2RmZreExFY2M3QVFIdjBaWG1LUmxRb1ZGbVZs?=
 =?utf-8?B?bWplU0JzUThpa2QzSnV4SG14Nk4zU2FkWUJTaE5WWTR0VUFGUUk0cjVPdWU5?=
 =?utf-8?B?ZEt1YksvOURBODVCUHhsMHNpdTJJdEJtY1RFRk5qYkRlQWEwR2t1RVZCNWVk?=
 =?utf-8?Q?bo2cyq5bVDPZRXEIxEN05q2H2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OpfpEWaScWKTMIDsjOI0oJl9pUKvyoih/vl6H5oeryvKv+KCnf/pq7+Q+S/2Yw3BMplj22r190I/RSlNhl337xODXD8rGLAH+b4voFUPBvouiXD7bMYvENwPuANjvL6Jtmdb8LerzLrL746hGZVG7vhhKNdY37NuDAi5TgRjvNXh1MwfPHNgPpKe15w0xNedPb9tS9P24mCG724U4/UTLW5X6LQcrohFxmDrxL0ig3uv5KN2/vSDkvnl2e5pblyUCrFTJVx4gmP5ExP3vFaiXSoBiikjQE3M/HQGMaQRvovcKzs+DPkL21OJY3yQl49kcKbFA2i5rUhFiannFXdWG0hqAZyUwEIajW+VfWRyn/BmtlWSmk96/QFTWw86Wgv5FZgjURfnOYIUFv9wBHFh0OnJdXm8XFN8KKmZFLEwOR5EsRo7OfKvwRbTKk3Ct2gTFRepvCgLR2UQr+5z8FUur7AMvXjag2bGg+DrzGSfOiF+Xokv2/gRr6ZPtLA7QeuL3n/AY+SBsNPi8061JnDCpKilJQTDBMn7Zv//vaPh9JYXLvZiFVA2no3izzHz7Wv/4DuWozDCHJLgKuuzT2TxBD3z7vK7ocUJoURQrrm7/o0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b91789-3ac8-45d9-42cd-08dd7de07141
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:48:28.5045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wprbtFE5TzK66TN4RmRf1OSw6jRMrwWGdov8tMpHEh7PsZbbQr+jEeaywgnMIVW+vUypJPXC35hwZKQNgM1apQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170138
X-Proofpoint-GUID: J1DBCMD7lC8TPhpNsgwYhd-fchUJwmU_
X-Proofpoint-ORIG-GUID: J1DBCMD7lC8TPhpNsgwYhd-fchUJwmU_
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gustavo,

On 4/17/2025 1:33 PM, Gustavo Romero wrote:
> Annie,
>
> On 4/11/25 17:42, Annie Li wrote:
>> list changed files in tests/qtest/bios-tables-test-allowed-diff.h
>
> nit: List

Good catch, will fix it.

Annie

>
>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h 
>> b/tests/qtest/bios-tables-test-allowed-diff.h
>> index dfb8523c8b..bb028db137 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1 +1,6 @@
>>   /* List of comma-separated changed AML files to ignore */
>> +"tests/data/acpi/x86/microvm/DSDT",
>> +"tests/data/acpi/x86/microvm/DSDT.ioapic2",
>> +"tests/data/acpi/x86/microvm/DSDT.pcie",
>> +"tests/data/acpi/x86/microvm/DSDT.rtc",
>> +"tests/data/acpi/x86/microvm/DSDT.usb",
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo

