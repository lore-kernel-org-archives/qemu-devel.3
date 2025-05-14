Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B85C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 21:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFJzS-0006mn-HX; Wed, 14 May 2025 17:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uFJzQ-0006km-1I
 for qemu-devel@nongnu.org; Wed, 14 May 2025 17:50:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uFJzL-0007sk-VU
 for qemu-devel@nongnu.org; Wed, 14 May 2025 17:50:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJsSso014446;
 Wed, 14 May 2025 21:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+xvzWZZ/z+7wlXaLvTKoNc1wY2WwX+VGmFYAoIxr3FY=; b=
 NsiAinqMcjPkfHcPgGr8fRfirmGxoPE+07hPcLDrlZyA6A63y3HxnfsTJjIUnslZ
 D4H9Hk5eqAK5L0YI7U3Ck4MqWmiSqrS7X2eXETB0uagJaI4LBwGzMoSVI8MDqdBK
 woJM+80M6IOhq7EFY4fU08ot7pww5VkVjMHmBT/8hB+s2v0cHqIiEp6qXF3mvMD5
 Mc78LlvGtAY9vRUvCOuqxEfDEuQom4WujARdbY5t4rEUgNJ0GaLPZg7nQs+7SdU6
 XUDQJJ3FljIjpqjLUDc8H12jaVgDaQALvFE2XEz87KL4fb4cRTNbBjxJ+ZPsjCAC
 eSipAvaHDQu1CE+6WEn6ew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgtt0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 21:49:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54EKETw6004068; Wed, 14 May 2025 21:49:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmdau8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 21:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6NTqHFubHkBrVNeunx6ftE03RNT9Ym5WVyyr495EJl7YrVSz1iyEC5TlMMyqkUKCrLGXrr5nfOGTN9LBP339BhpIoJsWkhN+Qoqrf2uniPRfTyQQDkT1ADPoz0ZU8m84/Jy+/DnCT5bhtWKuxaM5mNrOvKKHaVIQvR0QxJPbBabudIC7dWbBH8LbICqwmwAJoo6jmCuUtyiq8XZwIX/FmOhH91H3kIotv7sv3/v7Q303EO/uLM/Avxes5eImX0k7OGgNdbWv31l/inG+p1LlxoQjo7UNLvhUH1b9jkFI8uJcKuXfJfWJipS+eGB3+PYHnGts6YZVaV504i5DFIPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xvzWZZ/z+7wlXaLvTKoNc1wY2WwX+VGmFYAoIxr3FY=;
 b=lL/IKL5X60+waW1EJ9fxqBzdObbq63853G97m/Sa8L0mVs4kNIezVVRQdsk/Hq6BQzo2QOf3deN6xcYs2I39w6S9ybGNXOyHX8qZO11W8wrIxRddTu1fKY6v6/Q0cUvsXvHgtvKXeBVw8t7eb1Krz4xWAYfuJC6iLJxaHr6CHKgbDm276GPbnZDGPwpaDOvWY/+zXzgdw4AOZqWGqFP4lkGcKPI5VuHGVy/FaX6PjQQ76oFQfL3KmcJwOMuV2XJGeJYWilqwyoc3PLMVymL3RtsLwl6azXP3d49Bl/okceS2UTxnc2vBNu9jNzUKpexb2+q8nJpX0G5KgOIn9vKrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xvzWZZ/z+7wlXaLvTKoNc1wY2WwX+VGmFYAoIxr3FY=;
 b=g4IQkUTqL2QRVG9ar4KmVqX83oh/YovEte3UFRTgN7AYntD8LNaLkw4d2OUPOx3Yjy0+g+4q14f2Bly6XsXBOd7K3uzn0BFK3JscaYPNjEOdCStyfH0PArQZj1XWQkE8ei43vdGMktzzV12gZkadpxZ7lCNYHFqPntWzTMzPxHE=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Wed, 14 May 2025 21:49:54 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 21:49:54 +0000
Message-ID: <26c95126-9305-4e01-8526-f450d91da926@oracle.com>
Date: Wed, 14 May 2025 17:49:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] amd_iommu: Do not assume passthrough translation
 when DTE[TV]=0
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-20-alejandro.j.jimenez@oracle.com>
 <8cc41515-73d4-4d7b-b908-679e3fe2e923@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <8cc41515-73d4-4d7b-b908-679e3fe2e923@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:208:178::18) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7193c294-6d87-496f-0d1c-08dd9331432c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SThSOVg2ZkN5NUVTQjRyRDZNbThWamV1OG9BYjI1WkM1RkxyTEUyMDA4OUJS?=
 =?utf-8?B?ZThCZUF0QVMrSElaUmd4MEdLcDFqbzJlTDQ4NGQ0ek11d2dIYkR1alhNVnNw?=
 =?utf-8?B?eE0xUXl5bUZxakVpRm9VWFhleDlTSTd4QTFjYVZDUjhFZEljRkJxVTJvVTJz?=
 =?utf-8?B?Q2pRUUkvMWZSZmdMMThNdC9YaHVCekkrY08wN05YcTVFZ2JWek5NcXhuczVk?=
 =?utf-8?B?UDdPYmhKbGRueFVUM2YrRHBFVnhSOUZMTGZwSXhpMTUzbGRIZzZ1U2lvSzUx?=
 =?utf-8?B?eHYxT0x2bG5ZTE5RVGZsVUR0MmJVdWxzYXVYUEpKVFVwaFJocXhLdUlyL0Fw?=
 =?utf-8?B?cXFSVWNOQS8ycDRsNkF3dzF4ZFZaTHorRWxTSGYrbURBUU1mL3JpOUg2eDZI?=
 =?utf-8?B?TmJLM1NmUFk2WWlRYy9iTGlBcTNqL2VTOU5hUERnM0dyc0c0ZWNCWldycHJG?=
 =?utf-8?B?UEVvU2xaZTU2ZHNVdVBIaG04aDZwZEx5Q2VML2lpUXRsTVZ1RkZ4b2lwMmtt?=
 =?utf-8?B?ZUFZNElVdC8zNkVFOGR6Q05rSU1sdldoYzZQV0hoR3pqNzUvYlZWVWpJRjkw?=
 =?utf-8?B?RndWR3l6SjVKaDFmME1tdEFLbzd4ekV0aC9HNGZ0MzNDOHc0c3IraldzWDdL?=
 =?utf-8?B?TzNmWmtXcGJtajFWNVpxaGFoLzFlbTAvc2JLUXVvaHVFZWdKSkpMQytvSlNk?=
 =?utf-8?B?RDU2bkJSV2lOdyt3dTFnUHFtTTFGNE1UN1N1dlFsUDdNaDNJOGZGM3djcCt0?=
 =?utf-8?B?UUJkZGtjZ2hWK0dsd1krREtkNG82aCthYm5mVXZGU0VuL2taaHhvVFFMOWp5?=
 =?utf-8?B?TzRIT0p4aVIxUldhMWtNZzc2YWtLbXB5OHdpTjdlZGNPSEpUZzBCSEwweHpY?=
 =?utf-8?B?RU9sODVjck92OXBib1FXYmFLWFpPcnp4NkE1cndIYWo4WXRHTUdxQlJJcHZN?=
 =?utf-8?B?S0kvR2xVQjlrL1FoWlB1bGRpcUppeTR6amI4RXk0dUtaUDJiL2I1NEhDbzE4?=
 =?utf-8?B?UG9PYUpBVW4wRW02Q1k3dm9QZWx6MFozcmVMVWFXN3ZrSHZ3cGw5RWJ0bUND?=
 =?utf-8?B?SDJaSEVMNGRnVEFLMjhhdWtkS3VaMkpQb05PMkpENDlpVVVEY3c1UjJkUHQ4?=
 =?utf-8?B?VkdTc1JXaWE5Z2ZZNU5ocGJYT3dMd2xYc1FDZjIzUk01QThaUTZQSFhVcmZW?=
 =?utf-8?B?OVI4ZkVxY2NKSldLVDIwQStJQ042VmJPRTJ3ekx2RmRLYjVTbjZhRmp1a1NN?=
 =?utf-8?B?OGdGQi9KN1VQZy9IcW9YWm8xYlV5UVl2Zk1mbTVERnMvcE0vOHVoaE9RRGEy?=
 =?utf-8?B?ZmdYOVVtK3pCd01JclpZT3BFZHArUGdPR3k4MDBrbVRHMGlVSk43QmVaRzhX?=
 =?utf-8?B?T3N3VWhxT2JZaVpQMFc4UFJYOW5GeHJ1OEdNS2VGQU9qeDBTZEU5TXhoK21D?=
 =?utf-8?B?STczbmUwTS9weHJ1Sk81TFk4VWMzN3RUM3NpWVp6WndkaHpmQkYvSkVuaFY4?=
 =?utf-8?B?alBGeC9QdlpCWmRxdlpWMzZ1VE5CMU4vcHh0ZElCd1J1UlByZytMbHRFaUI0?=
 =?utf-8?B?NTJ2VVJoRHZIaVdHMnBWbmxMVXp0TDF3K1lzM2k3cXhiN1d1VExpdGorZXo2?=
 =?utf-8?B?TzhQejB5N0dPWCszZUNhaUV5K3RwWm5PY3lIVUZCZFBFcFI3WE5YampmTjFZ?=
 =?utf-8?B?ME1xbDNUNHJ1MTNlOUNvYVRTSXpocWNYbWo4S0xmR2N0Vmo3WXBVNVhDWDM5?=
 =?utf-8?B?VmhkbFVwR2dVYjZ0anBNaHJ5RHB3aHhab0lEaXBiQVB2dmQ4UlBxY1Zka0FG?=
 =?utf-8?B?a2x1WVl6NGEySXZybUFTdXNyVjJSaWpSMHF5OElXSUl2Q1NwN1V4UlVUWHpl?=
 =?utf-8?B?cG5qS3hYYitScDYyTGJGc1N2Q0p3QVhEUGx1T2VFRW1WRmI2TFkrLy9IOStM?=
 =?utf-8?Q?bvpnk3iCHvQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFJazlGcWRXMlM3RHd6ejhFZW9PZmZyeitwMzZjSzlEMEdYcDArMXNMMnhI?=
 =?utf-8?B?MUpzUkZwWGsxMWxyTXo5TVRpbW5OenJOQlhCWHBraTNjbnNIUUFuZEwrcURC?=
 =?utf-8?B?YU9vSTIvTXQ1ZVhvNjBQTjNMV2VSUzFQcTRabXowZ0xQd0ZCL1pmeGRhTC9m?=
 =?utf-8?B?RHlvdVFQeTRhS1hGcGxZdTIyb2txNGt4elhjcWEyK0g1YjI2aFcwdkZMcXhY?=
 =?utf-8?B?NVpueisySTVDZUQvU25Wcm5aZnhOb3c2b0hPWG5FZEVNeFYvTEx6MklLM2Jj?=
 =?utf-8?B?N0hZVVEyVFRkSGF5Tlh2QmQ2Skd1bE5US3NJdVEwUm9NY1Z2VHZvMlFGVDdU?=
 =?utf-8?B?a3VmTlBVZ3h6Sytub215QUFqZ2xMVnREd1hQbitneXoxaVNRMVZPWkQwVkVJ?=
 =?utf-8?B?V2dCd3AyN2VwUyt4YTNQdFd5ejZqZjJXbG9jZ01BdVl6M2lyRWJ4MjRyb0My?=
 =?utf-8?B?QmNwMlhGai9OM2pzcnoyQ05ndkpiVW1nRlltb1RhUTZlMmpIQ3lhNk9TYXg2?=
 =?utf-8?B?Z3ZRelZBSnF2UkFqbHhIVDN3QjJuZmVvZUtqZmdsdmVjREMwVGd0VGlyeTQ1?=
 =?utf-8?B?ajd2OURjQVB1azh1NEhvOWd3QkZMWDg0Sy9GZjRvK2xpUnhMWm1Scng3K1dP?=
 =?utf-8?B?TUJJZ3djZUoxU2FQNkdpY1lQOEs1dE04NkFPeXA1cEpPVlRYZU5GcXNJaFdG?=
 =?utf-8?B?eGpZdytIdGtqNnVicWF1SHBpUE1zaUZON0NnWFBwWDZybmY0Ukt4cjMwc2RS?=
 =?utf-8?B?YkRMUnpGQzhYZkhNVlhkeXBtV2pVMU5Wc05SVFFJM3RNZTJRYlNHdTZWTTMr?=
 =?utf-8?B?T1BuRDc1UGlMTVlXVUNBZVdKRzcreTluZFM1SDlGc3Bhd0JKQU55QWlmTFFF?=
 =?utf-8?B?QzIvNjNVZStnbUhqaEFxMTB5UkRYdm1BWmpmM3JVcWJLQ3ZJWGVBcXAvLzlh?=
 =?utf-8?B?UCttL1haUUpjek5KdUlkd3h1QmJNQ0Z1azlEMS9sK2RnamlFeHVrWk5kc2Iy?=
 =?utf-8?B?VTlVL3JFU3lYcHE1b2YxV1JudW91MlI0TnVlNEJ5bnZBN28vR2t1UktVL1h0?=
 =?utf-8?B?U3dhRk9pd0RwNlJCaUg3RW9ySnlsY1lSWXByL1lyYWRENWNoVnRvU3ZZQnBV?=
 =?utf-8?B?c29XQ1pFaGMyVUpNbDRTRmEvOGJJaEYzS2Q3ekdibjlzbk1Fb0RQeDVSTFI0?=
 =?utf-8?B?QjAxTVNITk5DN2h0RHZ2cHlaRm05a2hoc2pkWHovakVrcGN3WGtERDhzdG9M?=
 =?utf-8?B?QVFxZlZVTkFaWHQrZU5FZlA4UzkzNWx3ejQ4bkV4eHBFaGN6Vk8vaWxTSHA5?=
 =?utf-8?B?R2tOcVlZQ00zOGxJMDRVbXdnZU10UUZPNVZibGFJL0dFZUd5bThsUk1DNlg3?=
 =?utf-8?B?Ni9VYXhYNWNRcVFFMVRZQ1JVQWh6alVQejRkd1Z4NUFZSGFyUlpOMDMveXIz?=
 =?utf-8?B?MDVoMjQ2VFpWemJUeGcwQVlYTUF1ME1IeVNpVzNvdVpNazN5c1JmQzJYRG90?=
 =?utf-8?B?a1hyZDI1bFJRTFdHM1E1dFZkVFA2RTA2SjZFTnNRNGNIakNWZHpJemFEdDQ4?=
 =?utf-8?B?bnZSb3JWL0VhcHZmMVliZ0pkS3RsYTd0eklNK2F1VDBFaDFucXdwSkFUcFlu?=
 =?utf-8?B?OG1qY1QzaU54QWZjTWVsUlIzU1hZK2c3bEVrMVo1NVpaVmp0OUxiOHpEYjZV?=
 =?utf-8?B?c0NiVGxIbHRncUNnZjc5ZDhya2MzaFczSlVkaUhuajhUYzFVQXFtYk12QTlV?=
 =?utf-8?B?Y2tsRFZvanUxS0tRUG1zTkovN1ZPYVlQOWd3dCttZ0owTU9EK0cvejVyZWht?=
 =?utf-8?B?bEFsS2U1NFBaUmVXbWg0M0tnMFhNOXN3emtDOGZnVzl0UmJIbVI5RG1JSVRh?=
 =?utf-8?B?enQ0UzB6R2FrNEJ3NHdNamwvdi81OSsrdk82SHFobVNPcVdzSE4xWEpNRWpV?=
 =?utf-8?B?a0RaWVlqZ2I3eVNCNHc1YXJxNG1HQXB0VVl3b0c4QS9BZGJIZDBlVEp6aGZH?=
 =?utf-8?B?RVRrSVBVV0J5NmxIeXZEODlXQ1AvVUhiaml1OGJsb2FwUlNYdlkyVnluRVhX?=
 =?utf-8?B?V0xKdUpHQkFwUFA5eit6dVNYTTltc3lWZ2NVWE9yR3lkZ2VDMk9HVlhVMXZ0?=
 =?utf-8?B?YlB0dHVSM3hlYzNRbTNzVkI0NTNXMG4vcmVpcXFBZ1FZUTFCWkhxVUIzWS9B?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xUSPaSHd++6WVIcH9bbBSnwJHzmw2QhDcFAZ2f/TVSTq9kHZgDYZlo74FBZTvJ3I5M+1fVGqqmQqwOa3+AkWf76zNd7DTR3ILp+s17MzXQO+aWnXw6xmO8ZEzAMsc8rsWX0rR4Q/10FngZATrlCky/91G04tLkvcnmy0MjxOHeov4GtAcQHwUi8Uy9sGlSeWc4iMgeMN9/Vlr4/rpfoF9NZ03gtY17BvHX255+oIHAF3Y+l/2XxL5AaV0qsflXM9pwcTGTNFa6joJ1HSXwYIgGFMCKRjtOD16oTNWB2GLTxMA45J+vzi808PiYMSnh1lUEG5Mn4uz8jQWLW9wVtVNRtAu8HvXyKQC3Mgm0dCnqTWLuYWHI8d/EObO7PvJtBBU2nYkZZaL0PmDCdTGMJytWfdMk29CwDPBcKH1hVc5OHGZU5nmwkGvkJAPKntpr8xN4EwQkZ2AvzENTcP3SJte1nZtpwQrx+X52Wp1c2RVtb7L/viRfcHUlB4Um4wTt2wTj487tW/8g7ZI0QKtmY9MM9+56X6FWjMfTvcr/5HDj7XcQuXVGMXOtGD4C9W8L9yD0TIQmSd8n9ekk1Hc9pT8+HAL8d793PuVoX2GIz1nuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7193c294-6d87-496f-0d1c-08dd9331432c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 21:49:54.7708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv2MuND395H9n0+R4pRe3BxEaXNfam7FqSJLywADBS1cca4hYv1/MO4IwUXgZIhbD0T7+Vrr9cnYgbul3KIGZcgSMK4L3h7W3NAMSFmI7eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140202
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDIwMiBTYWx0ZWRfXxK13MUY2hl6s
 Bcza8hF9i4rO6dA424SuABVw6Yx7NrkNuHyfqEX/W9jmyRYhOBY8hPTNck7adfrjPD8S35MoTM5
 Jv8FR2gLv1Fmr6eNo4vaaqkZDt3nU+OaAE2wNpt8BipRmFUgUJxHj5/UK/ydyj/JqcbV+tKELpm
 AByKnXz2x9okGydVGWTqrURCodOFgIqoi/qQTMhnHxmtRd1qK0mIDpYL1HWwKrBiwkP+KJ+FA/Y
 PpbbsqG+Y+sh1Syhd8poqSXf1p3SfQmqs7c/BV2rU6okazXpT85vZzVu9mP9/+vefTDNfWwDIQ/
 YxNYV8ULL15SmCMs6GaT//WM3Esk+rmZV2JZZolCL0/vBd7XLqZcOTHH+trMI+97ZG5S2aib4eu
 AMuQpobc7gDs1pG2cAcq2Dykm0Uml3yGav+f9c7S7GJ/wBNz4QUecKxrXSzap/aKyJxdzM3G
X-Proofpoint-GUID: DZ_zRp9yA8PtMoUSkO-BFcGIwlaWp16X
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=68251006 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=szhyUjBjfx4nI-DQ8lMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DZ_zRp9yA8PtMoUSkO-BFcGIwlaWp16X
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 5/12/25 3:00 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:

>> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
>> -        level = get_pte_translation_mode(pte);
>> -        if (level >= 7) {
>> -            trace_amdvi_mode_invalid(level, addr);
>> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
>> +        /*
>> +         * A DTE with V=1, TV=0 does not have a valid Page Table Root 
>> Pointer.
>> +         * An IOMMU processing a request that requires a table walk 
>> terminates
>> +         * the walk when it encounters this condition. Do the same 
>> and return
>> +         * instead of assuming that the address is forwarded without 
>> translation
>> +         * i.e. the passthrough case, as it is done for the case 
>> where DTE[V]=0.
>> +         */
>> +        return;
>> +    }
> 
> Above change seems redundant since caller of the amdvi_page_walk(),
> amdvi_do_translate() checks the return value of amdvi_as_to_dte().
> amdvi_do_translate() returns when it encounters -AMDVI_FR_DTE_TV and
> does not call amdvi_page_walk().
> 

It is perhaps redundant at this point for the reason you mention, as we 
are already checking the DTE for all sorts of conditions earlier.

But I would like to leave it in since it serves as a good validation 
that any future callers of amdvi_page_walk(), which might not check or 
care about the return of amdvi_as_to_dte(), are passing a DTE that 
specifically supports a page walk, which is exactly what this function 
needs to proceed. Plus it provides a nice place to place the comment 
detailing the IOMMU behavior in such cases.

If you are concerned about efficiency, this is already not a very fast 
path, and the 5 assembly instructions this check takes (with a non-debug 
build I think is ~2 instructions) will certainly not be what brings the 
performance down :).

Alejandro

> Regards
> Sairaj Kodilkar
> 
> 
> 


