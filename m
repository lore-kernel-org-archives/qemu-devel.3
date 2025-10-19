Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D875CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 16:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAWVc-0007yt-GO; Sun, 19 Oct 2025 12:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vAWVU-0007yW-U2
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 12:43:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vAWVS-0004TN-Ae
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 12:43:44 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J1luiQ001126;
 Sun, 19 Oct 2025 16:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qstZX83GljWa/FeOS2rtRFe8WhLfiJyE2ZZo6wpv/wE=; b=
 ToO6bU1Mx/bLkLraYt7I/2M7DLJNszLwkrLRQrfqNIWtAnld+gBYg5QIZcbPCOuS
 WYo22lU1XVs8PjPbyXBc1HVczeoYcg39/JBzCbPSo0itiq2DHzsmZNbEavIErSeq
 OeIiH94A8s+mv6x5/K+ndMR+++5Jnzt5KG/vNYKfFcQ3rZYdVqB5EuvmCu7y5VPn
 AG7L5RvcAkUbX+1AvdIot1A6pxbMDsoWktnd/iQy5kv4WinEOGpqnE8WJaRiKokk
 0Vq+CiP0BrieMreBNOH+rlYlB8vbZklH+P1rrJ2it7uAd+e/UI6wIq69jCihGWEQ
 Xbm0O76+RXxWzYAXA74EmA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d14ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 19 Oct 2025 16:43:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59JEWPc2013103; Sun, 19 Oct 2025 16:43:32 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49v1b9ysf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 19 Oct 2025 16:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4UjHO95pnI7G6MJX3TwjJ9L3MmxJQ5iQBLIeeQjVXzKXbHvu1ISU5NMa5HJTeKX0ycscK6IM3Relmz/tSzMiTloIlhjj6phiNaWsmwUxu54yFnY5C6pyQyezQeh2aGeq0thHRCREtYO1nNEOeruImNAL+mFPKgDjVB2C2rB73jgJuiGSToyG13F+KAgd43PCpVWqrdK3rrOg6wYolDhop5kpPRJiGT6HP7pkTd00jliIkxRIaL+BZJCBQpvHFX/cR0zCQn1lqXio0mt4l4x75LddVD0/Z1rlysS+oiwNIrUPAYv49QBEnG+Hsv7o5IJZSrSLMnoEzZnaY4MqZqhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qstZX83GljWa/FeOS2rtRFe8WhLfiJyE2ZZo6wpv/wE=;
 b=qoMBLTPoXR4fFlN9ZNmGemAJcbf8/0oXrgzVPqj78SckLkdJYSXNmMZjkJlrNGJGiuNcNFjvozavZnU3LYTlJMEpYwYkS9RK76D0rwtXkaWLTkjsd4O4N8UW+WtJ9yQ42X+KlmGUNnQZW3ZtYpP7kVQ+R49ftzyvqeXSjNc0zWq4CJHixHhIZWUBXoN4SCH8UvhHwHnqBL0Vg6vGLkbqhYA8cd/Mj1y6i35pEvV1eD3ga3kLhqEQXv65QT9fsezlWz0FKAgxbjerf5iWdyppG1/YSWLdAudtBeh2zGyLH+VNEDk2R9sealBE6XzOZY0ZzrKVf+4v+qVhjIK5uHCOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qstZX83GljWa/FeOS2rtRFe8WhLfiJyE2ZZo6wpv/wE=;
 b=VEQQ/IUQHKATYUA9dVfLRSbW0+OyAmIplMF5/2Yp6MbqqHe10auypn1bMaUCHPmGADKF6BoxgHnnkkuAEMzoRlmsuEvPY1uNLBqb8y6VnEOoNtu2mC6N7C392j/xxkNdqNpZG7Zi3yTMHIKqmA32Jy/AcOA5xaJsSz643zgaXmA=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SJ5PPFD1D499C15.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 16:43:04 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 16:43:03 +0000
Message-ID: <5a7fde93-9d36-4d97-929a-12d86b847ed6@oracle.com>
Date: Sun, 19 Oct 2025 12:42:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] amd_iommu: Cleanups and fixes (PART 2)
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251017061322.1584-1-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251017061322.1584-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SJ5PPFD1D499C15:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb569f2-3cb5-4f8e-7659-08de0f2e926a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clE1WEZCSko1MFFIejJGZS9qOTlUeUNieVlyTEw4dGE1Ti9ESWcvQlZlUEtD?=
 =?utf-8?B?VlJDTGxidXc1SFZsMmdDblhZM0IwMXR5eXVpNTlrM3JKWDJ4dGNzRDR4WHZp?=
 =?utf-8?B?dndTMFczUmRLbzQ4S20xSHlUV3RSSGRET2xqSnpTa3dqTkdid09lZTFTbU1r?=
 =?utf-8?B?RnhNMCs4QVkvQjc4SWhJdlBlb1M4ZWc3emxkQzNQdUJqSEFoTGRxdTRKbW1w?=
 =?utf-8?B?UTdQemphME5BeW1LaHFaK0FGOG85OS9mdGtVeHZBWTE5Tzd5dkNaU09mWUtB?=
 =?utf-8?B?bkdHRERMMnNBWlBpUEVKZG9FRUw0S1RZNmRFRkZCMkUvZElxKzBuMmN5QVZy?=
 =?utf-8?B?N3NGQTFHSXBYYkZ4K2pGWWFhWlhkNUkxeVJUZi85ZTVTaHl4S1lMQTF3b25T?=
 =?utf-8?B?MXVhV2VvZG96RG1NOGxCOXVFSHVpRDc5REhvYnVlTWlvMU1SRnREVjUyUVEv?=
 =?utf-8?B?WFhTUzZZNlJ4dmFpQ3ppN0c4cGZ2MWtMUmhyRFNTRlY5S05jWFpzYTZzUGVI?=
 =?utf-8?B?QTZVaDdxMENsUm93aE1obGhHZzFQMkdzb2ZudkZiblBZQmdKcU9LMGhaV0hz?=
 =?utf-8?B?bmVlcHN0ZExTekhjaFEzRzVuY1lwdlFvN3R4SzlJWEJ4Z1ViUXgraHhkNXB0?=
 =?utf-8?B?SGY1SmhzRlpaZGlMRnpMdWdOQ2xTcHNlT1VRckJXZjdzeHF0a0FHUCtsMmt5?=
 =?utf-8?B?VW0raHhHcW9QK0tCOHZ6bHd1SGNZNXdnbUh3NWh3SllUVG00T09aVDI0NGFP?=
 =?utf-8?B?TC82SG9CUXNIbkJmdGhkRmNsUHBrc3Z1ZDBDVDlNQ3p4a2RuR1RWWlFkdnZD?=
 =?utf-8?B?YkJnMzI4ZUhVM1pGb2RoVXJwUmNjT2NiNC9wbkhKL3dCUWNYcHdaNzJCQ251?=
 =?utf-8?B?b0pZNTZzYWFNRWNzczJIbXhGNy9tZnJyc2tKM244OGZmWnJuUXZ6RHlOcE1B?=
 =?utf-8?B?ZGQwcUxMSG91UDd6QlVDNFZWcFJ6UVV5U0loV05QRGN2bDk4c05SVDQwa3Y0?=
 =?utf-8?B?ckd3MHpqYVJPcEpXREs4YXFabHlheXRJZU1sT0ZCSkRtUkhoNTY3eENUL2Yw?=
 =?utf-8?B?WkVrcWpuUnhndlpiMHJYeWxQN0RKS1loUWVjYmRTdkg0bkl4YmVCSGsxZzJz?=
 =?utf-8?B?Wmxuc2tNeFhQMDRnZzVuWklDRlU4SVBDYTYrYm1lV3JmbWpBd3lDM2VxM2Nl?=
 =?utf-8?B?dUJpblhMaUJLWVdXTWd2WVRUMUUvV08rUkhIZjFOcTVQUFNTQUF0c2d5bFI2?=
 =?utf-8?B?dkRpNjk1ellhTldwTjFKT0ZZMTdKQmNTZGlZMEdxY3RIRThrZzEvN1VROGdh?=
 =?utf-8?B?VnBjbEhjUzFwMFE3YmpRUkZEbEwwY3FuVGZMcUtlNUU2cU0wenBhTmo2NHlQ?=
 =?utf-8?B?dmZyN0VJTEtGOGxWWWFML29vY3F2TlVYcjlUVkM3VnlvdnhOVHhMYXN6NXdP?=
 =?utf-8?B?Znl6NGRDN3liMm5LcUlaQUtPM2NhTmEreGNxWXkxVEwvdWdDNGxyT0Q4Nnp5?=
 =?utf-8?B?bHBhVUdjYTN2ZFpoYTcwM25pWWhXaGdhem5QODdGRWczNXhQazIxVno5eUky?=
 =?utf-8?B?ckRWWDdwNFNmdHM5UWJEamdLbUVDd0pvSEFmL0s4eVczVVJVdEhIaE5GMXN2?=
 =?utf-8?B?TnNYd2h5b0dxZlh3MmpZQ0FvK1hjazdYN1NpdUR5RWp0bGNzM2FPOTJWdndN?=
 =?utf-8?B?bW5EME56VG1PbEtPR3pPRWkxSW50NGc3TENKS3Z5S0VkS3oxTnpTVW5RZnFR?=
 =?utf-8?B?bDdtQ1FwYVl2YVExS212WlMvSDJ2MUtwaGtobUpQMW0rMGl6M3MzdnM1MFFO?=
 =?utf-8?B?UmZnUDl3MU1EUHRPV2RhREZ0clRRQ3FwRGgyM29qekZEWGQvbms1Ukk3VUxj?=
 =?utf-8?B?bGMrRFVQc0NZd3N2SFFSNVJ0TWFFQ3RQVk1oSzJqTHR5SVQ5Vk1XdmxWSmtV?=
 =?utf-8?B?SmQwc0phZTAxVndlSFhOSWxXNWNtbUdaMVhqSUMzckRiVitkS081K211QklS?=
 =?utf-8?B?UlBRbDRlQ2JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01uVFdUdGZJUy9TZk5MaTQ4eHhrK0VIUy9oZ2hFRWFmeUNoSE9FL1hieGlZ?=
 =?utf-8?B?cXlCS3krcEM4aXZOM1F4dnUrK0R2NVp3bUV1TXdPdkRzT1RlcTZ6VlhhczlL?=
 =?utf-8?B?VnZBRkwybDhGOWJzK0NiRzlXWFRDYU9iWnNwR2dtUG9KbWRrYUI0MEx3ZllK?=
 =?utf-8?B?aUw2Z0tsM0xVRTBsZzUwbGNJejByM0VqdjN4dEdhM2RNN0dFNDRYN3MzSTNm?=
 =?utf-8?B?cnV1ZW0wRTBjMWZTZTVGRFlZQTQ0SHRmM24vTVI2YXppYjJVb21uc0ljcVhh?=
 =?utf-8?B?TExLQkJQV004MmRhTGlGU3RWSnduYUExY1F5Q2hTZlFLbUNQL3MrblJLckpD?=
 =?utf-8?B?dGR3UnNTMTZSL3ZPTHNqU0t3Qi82aFNrZkN6QTczZXA1Wklma2tsOXA3TGJw?=
 =?utf-8?B?T0dpeW5FcXBISzlSbTFqa0pwNDl6RWFZTXV5QXdXRUpnMXNCcnFBQzFoNDcx?=
 =?utf-8?B?Tk9ENzRMN1RFMzlyVmZBK1ByWDQyYnAzOFN5TVZidWcwczNUK1dqRHB3eFZQ?=
 =?utf-8?B?N0s1V1JRTW4wMDVZZmhQaFFuSXRYOGVDOFJ0WkVreVNET2lIVHdiSGpJaDZi?=
 =?utf-8?B?cFRKNUpFU1RrYlRMelhCOHNEUGMrWXpXYi9HRURnbDBRcjZKVm9VdTdVQy9r?=
 =?utf-8?B?d1Rqd1MzclJrZjY4SDZleXZ2ODdjMmNEcThIRU10bVd3MWJCMGxQSDcxWHNa?=
 =?utf-8?B?Q1orQkppY0h1OUdLWFY3VjBrOWNmQVNvR0Zxb05zMHExNW1wZFNDUUVrWE5v?=
 =?utf-8?B?SFZPN2lHYk9zaFNiZHd2STZHQjZLaTgzSGEzWmlKSXcrUktSK3MxWXhiL1Vw?=
 =?utf-8?B?eHBqeXZXUDUvQ2R4TnB3dzREcVZIOHRoeEM0WWVuLzNPbmY4eEdsWEhHbWpX?=
 =?utf-8?B?QnlSWEZYMjZZRkhseldFQ2FDNHhyT1NKY0V6RlE5cUJ6QUIrNHZnVnBlMU05?=
 =?utf-8?B?YkQ1Q3dyQzgwSEZsc2J0MThFMEwweE81ZzFBSlp3MjJ5Wm1abHdzckZKdGU4?=
 =?utf-8?B?NHJvR0xjci9jbnMwSlY1NmdBd0RJbWJlc3dnb2lBMmhjdFR4SDJ5TDdWSU9h?=
 =?utf-8?B?MFdiV3FqK1J1Q0V6RUFVMUUvMlIyOUZkTjVPVElRRlVnVDUyT2pMNnR4M1hJ?=
 =?utf-8?B?ZHBlYTlnOE1mTEdjTjZUMVVjZzliTWt4Z1Flem9sbXZNenFzR3pzY0h5K0RP?=
 =?utf-8?B?UlpnZ1BaTk1HZG43U28rOG9HVkh5RHdMWXFyc29RNDdZSkdYTGFTNlRCSkZy?=
 =?utf-8?B?dDNEcDdWT0QvV05FM1dORmdqdklpY29PWFMzTEJ3NFVpSFVpdVd6TmJGSUpD?=
 =?utf-8?B?N1RPS3NLMDBQVXUxK0dUbnRwcXIzS2dKUTZxcFI1SThiVVI4c3lhTmhGQld2?=
 =?utf-8?B?T2h5ekc2MFdkTUVIMzU2UmtzTml1RUIzc3U1VUFKMS9NakFkZEU5SktxWTlQ?=
 =?utf-8?B?NFNid1NKWTBxMjNmYlUvVy8wZm5iUngyOTJoRHBQQWRpeDFaRjAxd0NIeWxz?=
 =?utf-8?B?K2RHK2pvVzBKVzZUa3RKcHN0OHN5Zm1qN0p1eUhKRG0rMWtDa0ZrSlJyMnV4?=
 =?utf-8?B?cmFPVGZhTWI3ZmNRNThLRlVpRE52azZZalh4dzhra1BOTjk1Zm9Ic3AwNXg4?=
 =?utf-8?B?VkNYQVBNcUM5d25sS2M1Mzlwcy9ZS1FsNjRBMGtwWVN6bVBDQXlKSzFsWGhk?=
 =?utf-8?B?ajJoUmxFRTliYlpodkJ4WFMrQ01VK1hPL21kK0NwOUF0cTlqaTBHKy96VHlh?=
 =?utf-8?B?TWQ3RjhxUEdDem00bU8xbGFsY2NsWGNiSmRuSHhYS3BDSzM0NDFoVFY3VVdo?=
 =?utf-8?B?eXZIOWNVekhGa2h6aVRaVlN6alJWV0VGMGlMemRSOW1GMjIzekJHNmJMdVF4?=
 =?utf-8?B?SEhPSFN0aWhHdEZLOUF1UlZsRDVvNkRaMUVJaURNL3B1amR6V3piY3hvVU5w?=
 =?utf-8?B?Z2pIWUJ2NndLc1pYZ24rNjRmYzROaEg0U2l6MG13SThqZlBNVzFBY1RmdUYw?=
 =?utf-8?B?OUtET1hjUTJhTE1Md1RrUkJPM09yaG0wT09lYmw3YjNoWDZ5MWtrQzRpWlJI?=
 =?utf-8?B?K0k4citSazZLZndtaTlHZUk5bU1rUlhZVy8zMy9ZV2VEK2lYNFYyWWJXWElX?=
 =?utf-8?B?MFhlMDR0Z3ZyM0FxWjNtaDkyMVVFZ3hpdzd5SHNlSlU2Qld6TjJ0QnBrNkRV?=
 =?utf-8?Q?ADSJ60G9pzsUpTiItMKIjEM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PH0LBgV8m0W5l5jldh5Luc0AfU79wTLvJDopfBBdKMdZWi8agm+B5em3CnOz/wZXxegAawDrl7u9+LYco9Fg78S6Xmvfcn2CrdE4HQKarmmdNDgkyIP9LSIYfEcEufHdKrZlEJ7vIc8hIF/FBH67wUw7maSIkdB9u0kZ0hm2r1aYk79pIM/VjyHXXQp/Prg9LBEtgxqsZIig8pEVMDU4kWKIWcIw2oOb0HdEa8lkvg3M6AbCISW/Z7Er5YHk+EVSdPzf+q56vJlbbVKU+qMH8b4/1X26FO2ItokD+boya24Dje6RVUEk1+2AhpAugU1JJEwkbQeTH2HVjS1v3WsODEkcbNfk3aaB338dSVX3Qe1zem6GmVOqp00VE/m1FFNfS5Ge6CR0D6O9qU5A69D7ayRoS096tFc5mL25VmmhMUvNBkAX/dDFLX/RDxPrZTp0WXZfeLR6l2RO70+GA4RIDdO//rSQgMiStJ88/4Yeh8v183Gyvbg1NXmLofCSyjbDjaB1CXe64m+9sQWEVAkqSWhKP8aLLBiy2wZbwXkHsP2oTzaQ4ymSv31T7IsYJfNt58siVeIjVVGIwsMRGq8HTQkeZXuldcQ9FB7GoKnLm24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb569f2-3cb5-4f8e-7659-08de0f2e926a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 16:43:03.5484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5FuvwKv3aCnLg/8hWl7OAI6wkBVWLMtYcgtQXML5lDM0IqVCPcMZojk3M1CHnmduHZnNGnB2HrB3f3CLy1AX5TKjMQhCs1hLWOO6IK08mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD1D499C15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510190121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX3lO4A4KKqvH3
 m7bTSAf6JwksrvcxlfAlFu4bxTNb1/awcxLW8CMM/Mh3lxmSQwYjMUOvbcbpZxFl053JOTFAXDZ
 wd9kV5uvcMC8qG9SagnL32aJcAg19owmbnsp0EVwLTlE6zA6PeYF7kCjQ/+kF1GKbzS+FVWVGCf
 ABNm4PrmfBElGvi0Unl2cx4GCxeTIy63OPy5p7FAGGRr1IWumUqxU4f/3QWfQP4z1XeXzyaWKsq
 U2s7jlS//0R2e8Wen6YlL+q2GGHe7vJmwC4s0Qx6RtfXQqxwHyUE8mukRPX387nDGe63KKFk55T
 L4zDLx6eid980anS1YKfyveh56K7vW08k+kT5+G11fSxU5U+5h8xJg6OOF4DkKj1zrRFAtPOfuN
 BNZalFbHjA7ZHMBoXJ1yP/51N/Y6+g==
X-Proofpoint-GUID: LXH_SGT1J3EfFjZ30K33ahTyAksRv3BD
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f51535 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=nXccF3x9X3AGaqiJ8VUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LXH_SGT1J3EfFjZ30K33ahTyAksRv3BD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Sairaj,

On 10/17/25 2:13 AM, Sairaj Kodilkar wrote:
> This series provide fixes for following two issues:
> 
> 1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
>     bus id != 0.
>     e.g. With following command line, dhclient command fails inside the guest
> 
>      -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
>      -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>      -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \
> 
> 2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
>     setting up the devices when guest is booted with command line
>     "iommu.forcedac=1".
> 
>     One example of the failure is when there are two virtio ethernet devices
>     attached to the guest with command line
>     
>         -netdev user,id=USER0 \
>         -netdev user,id=USER1 \
>         -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
>         -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \
>     
>     In this case dhclient fails for second device with following dmesg
>     
>     [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
>     [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
>     [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago
> 

Besides the above issues, I can also confirm that in combination with a 
patched VFIO driver in the host kernel, this series addresses the 
problems I mentioned earlier with VFIO passthrough devices + DMA remap 
mode + forcedac=1 on guest reboot. Thank you!

For the series:
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>


> -------------------------------------------------------------------------------
> 
> Change log:
> ----------
> 
> * Changes since V2:
> https://lore.kernel.org/qemu-devel/20251013050046.393-1-sarunkod@amd.com/
> P1:
>   - Remove cast from the pointer assignment [MST]
>   - Rename struct amdvi_as_key to AMDViAsKey [Alejandro, MST]
>   - Fix compilation error due to missing 'static' [Alejandro]
> 
> P2:
>   - Rename struct amdvi_iotlb_key to AMDViIOTLBKey [Alejandro, MST]
>   - Fix compilation error [Alejandro]
> 
> 
> * Changes Since V1:
> https://lore.kernel.org/qemu-devel/20251008164324.21553-1-sarunkod@amd.com/
> P1:
>   - Use fixed type uint8_t for devfn
>   - Use uintptr_t instead of uint64_t
>   - Build hash key using lower 56 bits of bus pointer and 8 bits of devfn
>   - Use gboolean instead of int for amdvi_find_as_by_devid
>   - Update comments
>   - Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE
> 
> P2:
>   - Reword commit message
>   - Correctly initialize `struct amdvi_iotlb_key`
>   - Remove unused macro
> 
> -------------------------------------------------------------------------------
> 
> Base commit: (qemu uptream) eb7abb4a719f
> 
> -------------------------------------------------------------------------------
> 
> 
> Sairaj Kodilkar (2):
>    amd_iommu: Fix handling device on buses != 0
>    amd_iommu: Support 64 bit address for IOTLB lookup
> 
>   hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
>   hw/i386/amd_iommu.h |   6 +-
>   2 files changed, 113 insertions(+), 72 deletions(-)
> 


