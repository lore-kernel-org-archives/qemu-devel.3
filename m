Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3660C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UAh-0003Fc-B7; Thu, 17 Apr 2025 14:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UAf-0003Cg-Vq
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:41:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UAb-0002ff-5N
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:41:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMvZO009922;
 Thu, 17 Apr 2025 18:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=X06yxKXPjP+4qdAboiSD9Xz/FZI1GsT18SUJ49DR12k=; b=
 JMP7m4fYxi5Hu/m0LfnwANcfDumOiNIuBh4zSBqXvBOViT6nIMYhbgycXUbxUOrS
 CvG2jr/6+ApwRXFZw0LGVDRpKmjoKSZmoxKJYPxbm8l2AyWm0UUj96hqD7qqW+ab
 gkahsg7AAOz9BWCbv1HLozkpFMblohRatFkSsztzplAO8hk4NH8r4IWYDGdpkGy1
 6U91ROocOOX/5vMV1jpo4m7pJsoIPXLXESTcsGeFPq98BLuu4G93C+SKJhHK5G+Y
 AstOayzwGKyXJIjNuIHsZfWBobaOnLOqBMT3JA2ENCQ5VHWHszzGMlKaNI2TtwvA
 fzCTGSPUB1c0ah9H3Ic/RQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xy3gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:40:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HGqIPQ008541; Thu, 17 Apr 2025 18:40:41 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460d2tp0m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR2FtHdUyoowddd4IgD7/o52ArAVuRJra9AkgMret1xGpWh3+kJ4s5BbskXw314VpEmaJVT/pKZ+rdqgfsSVW66DlID7QxwHNMi6IYEjilZmgDoiZneqG0ZP8NeYjgIFpHk2AYAjfSNrVPNLFmpDsOo2B8dRxCM39VWpy0EIbJpRN5BvxeALSxQL5OfRkfLQqP85aGEHxQzbzmwKTW8mcRkoFl/zi8UJcifpyXbGNLnVTGMIP+1Uv2Ciw/6MD7Bz3TuS0TCT1Id99GYgQQyalNCYjRMWYxWCHM2fjO7DyEv2aTfYTEob4DCRd1WTmaUpVmSzYLIZrttvkU1J832KnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X06yxKXPjP+4qdAboiSD9Xz/FZI1GsT18SUJ49DR12k=;
 b=eI99sB5WU3Xv+35QDomI+iXJ9VvazyMH82OowfUNTM0NYR/3XCMIORCMCf3GY5obtOBi/X/4CbcqdX1bR7HbHOMZAzVIfa6UZs4ugRfaBBGi5Hp4qknyu1LtRaSWnP6rCvylsySezpRrKEgR9QcqLtkVnFJGUU8B+4Ur3Bl1PRZnVCIKz1SrgyJVpicfqdsM2/3y3xLsnjp6jmFe5MHT0au1/vLoWWisTaffP2pRuLG683DT+WbIWhwwJJKpX4nced3t2EBd0wGKKQPqPK6wB94wA6Q8zrP/n2tONjsQX8dZAIvnkZoRJ0yk2Ew93CgVY0+5n/0R4PsnsuQzlGZA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X06yxKXPjP+4qdAboiSD9Xz/FZI1GsT18SUJ49DR12k=;
 b=K7anvbnzkd4p4jmoVOh1fKh5ezs+vB04Q1zW1pzAo4RMxOOcmj4ntWrxUEhnt8rkbqW9LpdHcfcnsGZ9U6WJHzuZ0rdMOejsJuJrS5Zlv8IJNB3l54aftIA8PW4laSQBLqFYROSvfSPmLiuCqD6ofHymVQyCtEQoEjpkW3fqjgg=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA1PR10MB6169.namprd10.prod.outlook.com (2603:10b6:208:3a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 18:40:37 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:40:37 +0000
Message-ID: <d1c656c3-c278-4509-bbcb-115b59178c14@oracle.com>
Date: Thu, 17 Apr 2025 14:40:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 01/13] acpi: Implement control method sleep button
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: mst@redhat.com, paul@xen.org, Jonathan.Cameron@huawei.com, git@dprinz.de, 
 imammedo@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411202827.2904-1-annie.li@oracle.com>
 <75bfdfcc-d030-4a59-bece-49f422799869@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <75bfdfcc-d030-4a59-bece-49f422799869@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 8711670e-3849-492f-dc67-08dd7ddf5852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFIwVkJJRTRFcHowMjM1OWZndWtqeDk2UkRUaHRkalNObk1OVVhvMWJLQ1Ju?=
 =?utf-8?B?L3pLaEVPamN0SXhsdDh1dEM3OXBodEhQb1ZSRTV1b3NZZlk0REhsN0ozcldE?=
 =?utf-8?B?MmxBMXVMTTRiVDNuZUNMMG9hdHhYSGZRV21lUzd1d3dtRUlwNVd4OWNUeUFT?=
 =?utf-8?B?TlJ0Ty9jcEhSVWdYSlpoY0R2TTl3K3ErcmtUelh6VEoxNnZuMWNsKzRaSUNQ?=
 =?utf-8?B?RUZHbi9yOTNlZmI4N2t5dTVTejk1VlpSakp5cXd3WHU3SkZVY21MN1Q5aDVq?=
 =?utf-8?B?TE5Kb0FrdEpwZHdIQVQ3UnFScldJenFSWDNLVWo4K1JscUNSNzVoYzRjbVJN?=
 =?utf-8?B?a1BwaytkUmFnQ1RmemxJODFrakZZeXo1VHg2d2E1bzF1QUVocHJzM3lHMVdy?=
 =?utf-8?B?WnpVQjZtOFFJZ0hHN0ZoRmZoVnJqSmpDQjNGcWtaMW0wZXZPenVsRzhZaGVu?=
 =?utf-8?B?SVVKVVh4R29yRXhBMGJGREpuVFo2ZXBSSW91NFdBNkp2OTR4ZlVyYjlhTEJa?=
 =?utf-8?B?NnBFbFNNcTRRM1FBSXh4aXl5ZE1pOU5KemhTeElGUy9TK25WcU1pcTFiYlE1?=
 =?utf-8?B?YVBEc3o4RnY4cGwvMDdTNjdOd2tuRTFmRktqYUpBMGx3aWlFSDJIUW54K3V3?=
 =?utf-8?B?d2xhblAyWTJPdzhubEdPTXRyUGRJUFY2OGpJVmM0Sm9WV1ZSMFROdURWdUVs?=
 =?utf-8?B?aE5yYUYzNE5DcXZ6eURGZ3JXRTZURGFTQWNYTGVEQTBVeDBYSGMyTUNNZEE4?=
 =?utf-8?B?YUVnN0xFNGlrRGlnbU1KRWlIVERhOEVUUFNRTW1mTWhkOU1VOHdrODd0RW9r?=
 =?utf-8?B?Qk1OUUFndDJ1TzhJL1FtU3RlZFFHNjNnSlRlZnBoK3ZOY1pXUFJaME9jTGZT?=
 =?utf-8?B?bVg3aWR4b2ljT0dOcjVWd2VBNHlmYXpWWFpKK294TnYydUNtb2JWNlNNMWpZ?=
 =?utf-8?B?b2Ivd25LbGQ4NHVMYko2WFJGU0lFTVhETVU4bWJ2ZmhyblY2SXJEVlR5OU0x?=
 =?utf-8?B?eTFSdUptZ0RQcmpIMWhIWStOOTNORFRwL1ZySWdCWUpmbUZwcVhRcSthaTJW?=
 =?utf-8?B?R1owZTNwMWpoR2lEVFZUdnIzSUJiSkxuaUFKSmJVRk94ZHc4UVptV0lHNzFt?=
 =?utf-8?B?d2dORHFZQ20xVVdJS0I3OFpBb1ZjVjc4enlJK3BZME55dlk0Lzl4VFlTZkhh?=
 =?utf-8?B?Q25EQ3NraGhkT1FBSG1ZSk02R3NDMGRmREJjNG5ZclhQcjgxcXAremF2ME5V?=
 =?utf-8?B?b3EwdHF5RVpaeDgyS2syYk1rQ242OE9xSXhEeXlaZDQydmxYWG1wUXI5NGNI?=
 =?utf-8?B?eGMzTEljSE1LbTJHSTJjMHN1RGY0N3ZScUdIbE1jZksweTlQYWZzTmVXZTZG?=
 =?utf-8?B?ZW1XQjNMRGtaNnJwN2NNaXI2ZzlobmNpTEE0enVXMVpEQ3JlTTBoTktJbUFH?=
 =?utf-8?B?cld3Rk9lVVZjSGNRK3g4ZnNWdFNFNGdscGdCNEFUc1JoM2lRZWZnZjRGdXZp?=
 =?utf-8?B?MUtHT2JpWmhxNitxa0R2VHFhWVpZdTlsSUhLL211ZzFKekVlWHZmemZ4VDRT?=
 =?utf-8?B?NWpXNjVXQVFWU05La0NzaVhEZWk1T3VGMFVHY3Rram5kMDBKd0kzMXczTXI2?=
 =?utf-8?B?Nld0ZEhWMld0K0pXNnV1UTNlKzFFYU1tV0xWK0lwaWNObGVuZ1k0blRWV0p0?=
 =?utf-8?B?QjQvck9na05udHV4QmpkQmRwYWRkbDRRNllwTFp5UG93V3FUSlZRQzd3ODBV?=
 =?utf-8?B?bmg5ZFkzc3pXZjFoRXpWcjlMNlpmei9Qd2ZRaUZneU1sRFpveU5wMnVPYkFh?=
 =?utf-8?B?bURpTStYcFovZ0NwMXc1Q1lFOS95Q1pGQ1hySmxQa0V1QnZRTlNXZ0ZwTVcy?=
 =?utf-8?B?QkpRaWRFUlNya0hDYlVNNWtVUFJsUjVCYlBuOXhjNlBBTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWl5b1NaNFRnQjQ4S29XQ2xYajlVak9ncENUdkNvaUhTeityei9idEN0QlVG?=
 =?utf-8?B?VUJDT3U1VlhsUVZmWmxTc0txSGxiZ1JsTEFiOHV0OGZXUFBWSWYxblFraVJO?=
 =?utf-8?B?eHZYTnc4UmZCMFFLdm1OM0hxTUJlM08xdHE2NUZ1Sm9rdHhlcUFjNTc3NFJI?=
 =?utf-8?B?Qm9HS1NXSCtMc29zL0JTekVJbktKRDFKcDB5M3BYbndnL3UwUVZ5SUJjVXBu?=
 =?utf-8?B?Y3c1d2lrOUN2OXJMQXB3a2dtM3M3aHhKYjVPVk5PeUZGa0VxQVNMWmtaejho?=
 =?utf-8?B?OGFIbFNRcWxvaVdxTkp2TjBtazl5aFRuODhMZHFpOHJJVk5zNlg4MDFNalYx?=
 =?utf-8?B?eFdFdCswQ29aREN6OHNrYXNoSWh5cDU4dmdSUG40cW5RcGljK0VHWTg1R1hm?=
 =?utf-8?B?UUgvRktzdzdLQ015cWdGWHdLaC9jKzBzbkh4d0R4L1M2bUtMWlNEUGlOSnEy?=
 =?utf-8?B?dDlPNXhpamp6N0VnVHFpWUVJc0FvU1N1TFk0S3M0K1MxU3dNWkZFTWZsYkd3?=
 =?utf-8?B?YmVadzRYQ3dzNHhiVW1YMHF4Ym11eDd5L2JPdEtWMjUvSmhXVGdRbFJLeGlR?=
 =?utf-8?B?QTFYQjJTUE53akJoRXoxajNKNlZQVUQ2SjhFM2tqUDRHUklyamc3R2RySVlo?=
 =?utf-8?B?cnVRMGFCc01pdzRmWVdqdWZmSk8rMFZCbmtwMmJqcXN2Nzh4UkswVkQyOVpT?=
 =?utf-8?B?MDFOT092MkVwZkVjVXMzbURMaTdMUFpxNEw0SFFtcDhORFYreld6aUlDK3RD?=
 =?utf-8?B?Q2p2eTJvLy83RnFmSmRGSkZPTFVVSXRvVWs3T0J5d0Z1c0NHQXRyZGhrSVJL?=
 =?utf-8?B?VlduY3JlekUwSW5kQlhoUTh2QWFmb1UxSXY3Snp5VWRYT0VGcFpweFRqa21F?=
 =?utf-8?B?dEV5WUVMZ0lOd3lRL3NZYzNnOGJ0QldxcllLd1l0M3dJd3d6cEZJcnBMNXRO?=
 =?utf-8?B?bHd0ODFLUHBpa2FQMXVvYkxIa0lNYW9jYlhSZWZWdWp2dHZaUWJaNkdNUFdZ?=
 =?utf-8?B?SzY1eVJoV3U5QWJ1NVJnUk5ENlZmUWo5N2YwZmd0OWE1bXIxNXJSSW9hTWVP?=
 =?utf-8?B?WFNsTjlWN1V4OWZZSzZNQ3g0SmplQXVPVWExdnBqMTBRSlVJb1drRFA5QTV6?=
 =?utf-8?B?MmZqTitnWE53MXA1WVB0Z3JpKy84RkhxUVNiemFIM1o3ZDJNSWNwZW9lWFpG?=
 =?utf-8?B?dXhLTkY0VEZVdXE4TzZqS0NrcjZCY1BZQzdNcVNSbnZqR3JyTnpXVlhWNFlI?=
 =?utf-8?B?cTZjUVUvL0d4STBwaVdEWG51R1VnZVZ0UEpnT0JSUDF4T0ljWnY3VEtRRjUz?=
 =?utf-8?B?aFUxWTNWbk1EL21tK3NDNVR6TUFtUVgycCtid1B2SFZmaGNYYTNDRnZnNDFZ?=
 =?utf-8?B?OWNYRXNmcXdKck5HdHlZa3JWSXYrRWlUdXRtVlpHNUxJM1d3eXRLTy9qMFdk?=
 =?utf-8?B?azVhckt1RmNwTkNWMFNnTVdsUnl3MS9qdGplUUNsdGlIU0F5MGw5NkFTa2sy?=
 =?utf-8?B?VE8zK2VUeW1TTm5zNm5McUUyeXdWcVRjcmhkZXRMclFOM01xZDMxTDlCZDVW?=
 =?utf-8?B?d3gwRUwza21qTjlxNWZ1MGVKZm8vcUVDWVh5cjdzWjhOajNzS1hsdVdMQXVi?=
 =?utf-8?B?dTJQcXRwbWZlMDF6WThBdzBVelhmb0Jxc0pvYnZQbHh3dy9Gd2c2UjgrbStD?=
 =?utf-8?B?MlF1R2ZQVmlzZXVKMlZRSmZHRUJaVHhQR09PYkwwRWpKVEtYamx4K2llbElQ?=
 =?utf-8?B?eDBpQUo5UCtpckt3TkV6SG5aL1dWYU8xTkRRVUw0V0t2OUdFUnR3aVNJUlMx?=
 =?utf-8?B?a0hqblJxTnBKY05HUytzcFpNemJNblFVR0JxTms5c3VIVUw0R2o2Q0tES2hP?=
 =?utf-8?B?SGJkZ1h5WHhhZjR4NVB2cjJQSk05empIK01HKzZkbVRzTmlNbmVadVI1MHl3?=
 =?utf-8?B?OFcwSWNMcmRzSnhuNmlFdlJKVTE0T25RSWNXNW9Odm5uYy9WRE04eHNUTnBx?=
 =?utf-8?B?YmpxbzNzZ2F4Zm1qWkhyQjBJNTFYMkJEZUM5ekQxd3hIYmpHcE9QZXl1WlBW?=
 =?utf-8?B?TTk1c0NNSzJMcjI5by95aFNOYlBVejFiemRHLzV1OEt1MTF2b2NvU3N6b1pE?=
 =?utf-8?Q?O9VDei9tjEgUKEpyygs0D707X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u8FZq5AuErjDnHBOuycihAVp6xL2dumGwTMCl3mrKmeIpPkN0u+J3PmRT44COLlS7p9GCWdpbBPqSSTDa9NF4edDRQox6okv7jT1CollMXb6Tx7TqEJtIYK7Zrei5zg+oVnZC3JHJ5rB289jtyTbk5AFmpHShikFqgAHgGngaiZIN4UWHzf1mXcw2DVu4kZ6Y7eCA1FtrVG4tHeTdO6IQsvOwt6mfbGoKMr0diM0rxgq3q1rOYzd7ONQReyhTrabhe/VcavjA2LgQRxR4EEgo4Xd5FLXbiKw2tB2efagA2xZ6gJ0ntALRjjg3xOuUSs5JBTcjxHQVSXj7EbhCWQg3Y42WdWaIyk3sxAfqoqXj3yr7z17bNn3oZisk4uSwpGV1TMp/oLsskhXz1y+yCUdN/kg8DP+hjWlFVwj0jyV8fcrBHdt/bHtM8qJ65YKrWH0eJ+DiXuDLC2tLkk2uP2QUUu7yfwBOue5ZSWBULTOYGUNA73f03i6R6lwno3PZasdXQ3DSEUQJKB3ZnHp6+BDkT7UFVurH3bw7oFGV/Gl/GpGX1sfLEiDLs6KNe9qFqWKNwsTVnWUfNT0z0dC/CnHWnw7bTy4Dq0YQMd62gYlzAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8711670e-3849-492f-dc67-08dd7ddf5852
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:40:37.3055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+Y8kBPQ/GJKiPwepz9yk2sZEQ8T/DTrESnpKFAdN1ByTzx3Zh7+KOYGg4oDbOXxUr0PNslSH3yYdXPFE2flOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170137
X-Proofpoint-GUID: cB-JVf1UiInQIWdcR_mv71oMM8-7NWx0
X-Proofpoint-ORIG-GUID: cB-JVf1UiInQIWdcR_mv71oMM8-7NWx0
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

On 4/17/2025 1:28 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/11/25 17:28, Annie Li wrote:
>> The fixed hardware sleep button isn't appropriate for hardware
>> reduced platform. This patch implements the control method sleep
>> button in a separate source file so that the button can be added
>> for various platforms.
>>
>> Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/acpi/control_method_device.c         | 33 +++++++++++++++++++++++++
>>   hw/acpi/meson.build                     |  1 +
>>   include/hw/acpi/control_method_device.h | 21 ++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>
>> diff --git a/hw/acpi/control_method_device.c 
>> b/hw/acpi/control_method_device.c
>> new file mode 100644
>> index 0000000000..c3b1d484c4
>> --- /dev/null
>> +++ b/hw/acpi/control_method_device.c
>> @@ -0,0 +1,33 @@
>> +/*
>> + * Control Method Device
>> + *
>> + * Copyright (c) 2023 Oracle and/or its affiliates.
>> + *
>> + *
>> + * Authors:
>> + *     Annie Li <annie.li@oracle.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/acpi/control_method_device.h"
>> +#include "hw/mem/nvdimm.h"
>
> NVDIMM is out of context here, please use:
>
> #include "hw/acpi/aml-build.h"
>
> instead for the aml_* symbols.
Nod
>
>
>> +/*
>> + * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
>> + * resides in generic hardware address spaces. The sleep button
>> + * is defined as _HID("PNP0C0E") that associates with device "SLPB".
>> + */
>> +void acpi_dsdt_add_sleep_button(Aml *scope)
>> +{
>> +    Aml *dev = aml_device(ACPI_SLEEP_BUTTON_DEVICE);
>> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
>
> I see that since GPE event handler L07 will be tied to the sleep button
> device there is no _PRW variable defined here. Do you mind adding a 
> comment
> here about it? Something like:
>
> /* No _PRW, the sleeping button device is always tied to GPE L07 event 
> handler. */

Will add comments about it.

Thanks

Annie

>
>
> Cheers,
> Gustavo
>
>> +    aml_append(dev, aml_operation_region("\\SLP", AML_SYSTEM_IO,
>> +                                         aml_int(0x201), 0x1));
>> +    Aml *field = aml_field("\\SLP", AML_BYTE_ACC, AML_NOLOCK,
>> +                           AML_WRITE_AS_ZEROS);
>> +    aml_append(field, aml_named_field("SBP", 1));
>> +    aml_append(dev, field);
>> +    aml_append(scope, dev);
>> +}
>> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
>> index 73f02b9691..a62e625cef 100644
>> --- a/hw/acpi/meson.build
>> +++ b/hw/acpi/meson.build
>> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: 
>> files('cxl.c'), if_false: files('c
>>   acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: 
>> files('generic_event_device.c'))
>> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: 
>> files('control_method_device.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), 
>> if_false: files('ghes-stub.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
>> diff --git a/include/hw/acpi/control_method_device.h 
>> b/include/hw/acpi/control_method_device.h
>> new file mode 100644
>> index 0000000000..079f1a74dd
>> --- /dev/null
>> +++ b/include/hw/acpi/control_method_device.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Control Method Device
>> + *
>> + * Copyright (c) 2023 Oracle and/or its affiliates.
>> + *
>> + *
>> + * Authors:
>> + *     Annie Li <annie.li@oracle.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +
>> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
>> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
>> +
>> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
>> +
>> +void acpi_dsdt_add_sleep_button(Aml *scope);
>> +
>> +#endif
>

