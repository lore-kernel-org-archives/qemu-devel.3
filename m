Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B2ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28MG-0008VB-4I; Fri, 26 Sep 2025 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28MC-0008NM-45
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:19:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28M5-0004GS-8J
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:19:27 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDH9wE028487;
 Fri, 26 Sep 2025 13:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=GH8LVbesi46U2NXbe9izDr1LLOVUlwMUHC714JUbyRM=; b=
 etgz0a7+rt/wwhIuM3ZICvR/qezbCGE2jwA6swOd5o/R34Qovvg26Po5V4f0IfaD
 l6DazZ4DVhZnEsIEvAiKvB4PwCZZw371JL62DXw2GyFTguPvwA5v6cvPEmMDqqTi
 1zEThKzKYDa4K+fD0h7uNmkuWQuTWB2guNq2IwJHE/htZXAYs/WR73lYtociLU0k
 JQM0opmiGMwU2I54oNqnCDratfsr+IhZrvE0gu5xXflGCCKWVegrUY/y6AAyH2az
 djcGpPVgx4n1JsQVUy+rK+XRsXNiFsrN072klHhqoej3Re/IJR+BFSR4Tyk90+QY
 Zs4N9LFOtgr54zWpmCTfEA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dtxy02pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:19:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58QCDmZP010152; Fri, 26 Sep 2025 13:19:14 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49dawkyqfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMX5kGCnwjOP5vEfc/D69oURIjATqnSwtSin6QFB6w8wCq2AVWBPge22PSYXW4ZhnYfiOswIstcuKnTvNJBG4PbR/wy7+uSl9J5yTXQe6Lz/EYh8F9IsDnyhtrJwuoLW82sVQBWZfzBJA4kRW7CEBkHP0aI3U4onJuf8pMIBoGPqKOCINQD9RuXcEs+uBnj2YNq48VOTQiG6uf2bpyMI4mhTQ0TelXBN027DGIuOeHI67hYBteIavnNDrm9Q+33TrTNRgOFN7zhptrVrHgI4IKnc79k6zf3XqJp0LGLuxkEXA+tBcofRBntXyaCrLYaf4l8U1VrZHSn/eJfh6bgeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH8LVbesi46U2NXbe9izDr1LLOVUlwMUHC714JUbyRM=;
 b=WTyW6V/n1oHG39HQct5lGzPakJQUTPxX200qewmeualbnd9H4Qn1VQJEU/K9CwHsH77NzBA8g6EAWns9KDswmLqvnwzEpZEbi3SWk9i27sg7ntnWmg/a/zvOPfmgZoaFgm4uYHHGueL519R/8JZ4kVBmmeQ+vCamBfIgQAL2GPkU3zSpKW57QdVVFe/A0DsRsE7e1243RdAB02vFgi0yrtV1y3XQNY0jQw9rOU41bofYCyukC81GL29ZXmurWUetntofeODwtFi4HliygqZpHQoenjCHu3yJ0tGHD7/4EFN7ajAVc0TUiiKke6oszn8jFRlFWO00EpkD/qwgxxO2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH8LVbesi46U2NXbe9izDr1LLOVUlwMUHC714JUbyRM=;
 b=OSUM87XShuZa7y7cI1LZKZrx7bmKoKUy5hGDZ3KtRIMySkI+tmsdhyJR6AEhUt4dm3mQds5Usb+JaY9rt9BZ/KcYNxuO1w96wUh+g9SV+zz2F0mqumdMz9rNzNp6V/liKtNfWYVuMZvM3o91LnmZcPJPZjHvnCxdB5gCLhvX35E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 13:19:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 13:19:11 +0000
Message-ID: <5ad8b79b-2e59-469d-99e8-2c7e5e51e490@oracle.com>
Date: Fri, 26 Sep 2025 09:19:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com
References: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf554eb-42ee-432f-13cd-08ddfcff482c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTRPN1RhM1JMZFEyM2sybnlFbnBSdGNtYlB2a1pTMzRpa2FzemdwSnI4NGp3?=
 =?utf-8?B?WDEvMWNsRVZlRnNRaUtyQmZQZU5wN0hHSzVwdHpmdXZKdmE0QnhCeUxXcFpQ?=
 =?utf-8?B?TDl5bkpiZnZBdGJDV1J6dUpxNE5MOStUb3ZFY1AyK2I2UU1tMncyVEc3b1hV?=
 =?utf-8?B?WjRQbDYyMmpGcG9mbEhhTm5ka1NudTJSQjN2aVI2aHVSRGlPb1lKVm1MYi80?=
 =?utf-8?B?U1VqZG1wZnNQTi90Ymk5dEU1UkpMQ29MLytxY1pDTmpIYTB4bVl1ZUpPSGpk?=
 =?utf-8?B?WjM0SFZpZTBWV1RROUNDNzlvbEQrVm1PNFg1MVVycDZpVFhWUy9taXZxVjRG?=
 =?utf-8?B?KzBNSS9tcXpjam52UjhBdGNDVFkraFBybStuNld1TWlXVHpzdFlwbkJ5MDJE?=
 =?utf-8?B?L1poQzFNZkhsOGIyUm9lSWMzeFR6MmJCbDEvYkVWL2ZmYXJycFh1ZVpuMjNF?=
 =?utf-8?B?d0lyNGNiL01XaXJLR1FucmxlTncweGJKb0ZUQUNQRkcvM05wTWwzc1Fjbjkw?=
 =?utf-8?B?QkZGdUM5TEFZOFhZNWNsQ0t1eVh3SXc4azlxaHl3b0hUQnduamFmMHpwQ1Q2?=
 =?utf-8?B?UjBRYnZoZTQzQXppUHlHYXl6eXYydktwdTNlVzRpN2VvajBOdTRnUkJjcGF5?=
 =?utf-8?B?eVE2bnR5OUh4U01hMUhHcFdPc0NBUkNpSXVDaUJaVXlxSERCaktqQW1kWXJr?=
 =?utf-8?B?ZHlqUXVnbzNXUjNPWmVKVGNkbGRiUTVoSUFqVXdyalFRZFhnSXFMdThwTmhh?=
 =?utf-8?B?c2hXZUtzcGhtQXB5amxaZHJ2alRlbHozbE9zbENuNnBqbU1BQTRqUHl4bjM3?=
 =?utf-8?B?ZTJOby9MYzlpRDE4YTk5T2JLS1p4RTNtVmpQMmtMT0JEZFRjT1VGNWdoSFZu?=
 =?utf-8?B?ZU1kUzZ3VlZ3SHN4anJQUVpoZnBTU0FsalA5RUZiZ2RKeERhTGVSQXFDMzYv?=
 =?utf-8?B?R0VKUWVUd0daVGxwd01XbWNKVzNTSmoxdjZLb0lkTXV4ZnRhV2pWcE96d2RW?=
 =?utf-8?B?RDVzMVN4OE9GZFlrR05PaGF0cTJqaExuTlVGbEZLQ1h2QU4xYXY4K1NFY3FP?=
 =?utf-8?B?M3M2VzZvUDlOQXhLZUNnTXg2d0tOblFMdHlFRlRRU1VETEczdHd3TVp4Skx6?=
 =?utf-8?B?ZjFyZmozZUVLbGFyRmRYcml3VHNVa2FTVTVPVklBY3o0QnlFeTNtS1dSVVNS?=
 =?utf-8?B?dFZsYUJORWtQN2NtK1MxVzVTd1B0b1A1TDMrbXcySWtINkhyQmxFdU14RXFF?=
 =?utf-8?B?cFpqMTBTZ3dtbjFxSUw5dFdYVFY3cmhuNXZaNS9OanU3TU44TlRVbHcwVWdz?=
 =?utf-8?B?cWdoSmYxUE0yajZob05FL0pIcm9FblVHRUZLQTdnUFBnOUlLYXAwOFZIbCtH?=
 =?utf-8?B?Q1o4YkRNblN1RnBpWGU2aEN3RHc3L1BwNmZveGxkSE5HMVZkQUI3d2tVU2NV?=
 =?utf-8?B?eTlMVlMrOStYYVlnb2k3YkhZcXd0a1VaMlBWSUgyMDdadEFqWWNESkN3aUIz?=
 =?utf-8?B?WHJPL3hIdmNxRTdqZDM2Rit6SXEzMFkzUkwvenBOc3FNWHAxR0xPRGJzS2FJ?=
 =?utf-8?B?blpPWjhTSTJEVmxKZ3RGeFRnbVFLTEdxUG9EQjRCWkhRbVUvM3V4TFNRaHor?=
 =?utf-8?B?S09sM0NIa2xtUCtwWU82SHN4WDN1SExNNlIza2lnOWgyTTQ5cnQzeG1Kb1dz?=
 =?utf-8?B?K2RVMmIzdXdqWDNQZGdzcU1OVk5JTjFmeXl4bGxvbDRPZU92a29TbGdMamhR?=
 =?utf-8?B?L1FvemN6Ulh5UWp4aUZacTE4aElJZlp3MWJDQ1VOOGJ5QXNmVVkzNXNUTjRD?=
 =?utf-8?B?bzhCYUFVSXErR1pLS3FGdTBVdEcyekxac1ZQVzEwaUVRb1N4dTZJQVJuVFNy?=
 =?utf-8?B?Um1sR2N1VUVzcmtmTGx0d1F0U0k4VUxicG02L0t1d0pVbXZyUUZYdktOdTFq?=
 =?utf-8?Q?Q1tcHJ5K7Uk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXpkY0UzUnIvU1FSRjhxUVJJUUhXTnFUd2tHbmUvT1gxOUY4Mm4vNm93OGhV?=
 =?utf-8?B?M0doK0l1NUJmSWRTeTI1ai9LbzBSNGhCUmJlM2FWM3Y2TlE2cmQ5NG1UckZn?=
 =?utf-8?B?ZmgwSWxqVGh1MFRwMTQ5aHdTTW5mZG1wMU5idDZWYTFwYzY5U1ROMzg2ZGVL?=
 =?utf-8?B?TFhJUnd3N0F2MDUxbm1jZEZXTGlyaUM5andWdTdGVGFyWkp0UGJucjV2Rllv?=
 =?utf-8?B?R1ZZeTNGOFdZb0NWWVg5TjhLb1NYZ0U2c3hpVU9IZ3JkOGFyakNxMFZibzR4?=
 =?utf-8?B?dXNzTXhrdGtxeGNodnl3Ky9oQi9NSXNSRjlwaE9neUs2aUVGOXEvT01Nb3A4?=
 =?utf-8?B?SGZHbWdqOGZYektSYlUrQk44dTNNQXFwSEFDVnMyK0NDUTM3KzNmSHY1KzFK?=
 =?utf-8?B?a0hZTEt4VzRoMjIwNldiNnM5MzRPNFEvUEMwTTBDM3U5cDB6My95K3FIaU9k?=
 =?utf-8?B?ZytpYzdZcDVjT1VOdjBmRVRuK1ZrSkl0Ym9EZ0NsZkpWUllCMlRmYnlxWG9N?=
 =?utf-8?B?bGh2TS9XR1NsTUFrdzJkbDVNRzk0M2VIbS9LNEVoeFVUNXZGMjN4aDJhRFY4?=
 =?utf-8?B?bXpYRmhDYnpUUkd3dVdlT2RGeEVPNDRzcWVzanRWZVM2STBRa0FvQjFkeld4?=
 =?utf-8?B?dElVSDJMNDJNdVI3aitYbjE2VFdHUzhkM3ZtVENSSmkxcmZlS3prc2N5WGhq?=
 =?utf-8?B?SjVuS1o0Z1EvK2FPRWdSNXBHeDVFOGh5eXlQMEJCTTZGUUd5cXhEdVlld2dh?=
 =?utf-8?B?YmdSTWZEYzdHREhmR0VIY01vQTdDQTZTWmFTTGhWeUVuZmVlMFdVSXVUTzlw?=
 =?utf-8?B?WUxoclhRSlpHc1pWZks1S3h0aGdvNU5UNzQ5T0lodXAwb3A2UnhQSTQ3bDN6?=
 =?utf-8?B?QzZyamtqZldybUxDNmNRcVdVWTA5Z011N3o4TWlHcTdicDNVZk9XNlBQMlRP?=
 =?utf-8?B?N0M3VjYxYlBRZHVRVnB0UGxLREs0dUtyVlptUUQ4ZUo0aDJOK2V1Tk03K1lP?=
 =?utf-8?B?ZlhFckFBSUFCbTQwTUpJS0RvSUxRUFVMeGdpRUhVYXlVZ2V2bzg2eE5CaFV4?=
 =?utf-8?B?YXFpa1NyZWZNNGwyWWtBa3hLakhXYnpiTDRGb1VFNXdXRUt2YVlUQnR4bFlP?=
 =?utf-8?B?Sjk0bXlkd0lZUDM4c01KUGRYZ1dYeDJCdXFaVnF1U3R4Q0VkYk5JSVB2T2Er?=
 =?utf-8?B?c2RVRG92MnNCaXRRcUxsYW4xblJPZlZmenZUU2lJdkNKb2VVTTF5UVZGdUxX?=
 =?utf-8?B?SStGTnBDT3B6ZWwvLzBDazN1MzhLcW43MjBKMmJrRXJOSnRIaDFpT3JwTFZD?=
 =?utf-8?B?RWNkTlByb1EvS0ZrRUhwTjh3Nmx1UnBqYnEvU0R2akxhN3doRmd0U2MyR09U?=
 =?utf-8?B?aXJRYmxYeUR0SkQ5bit2ZFl5NFllRFhBcXA1a1VYbFFZNFJJK25pY2Q3aUlm?=
 =?utf-8?B?YTlobFhXdytkMytOOW9uS09RZWlxckt6L2RBMndBTThEVldEdnFqMXcyZkx0?=
 =?utf-8?B?b2JxN25CQmM0NGNJZWhFMVdWMUpNNC9ZQXRqMFV4eVZKc3VmYTNweG1RdENa?=
 =?utf-8?B?TFdKZnYrZ0NmUHpqOFo1eXZ5N2xjemxKSHNLdHpPYUZDTng5cTkzWUhmZXJy?=
 =?utf-8?B?akx1cEVxajlDQUZjdnVnZ0RZaUpCVVlYazcyTmorSXo2SUVSQWthWVV2OEdO?=
 =?utf-8?B?ZGhuWkZua3FGOUFwbjBnaEdoQkJDOThBMVo2SjRSVFlEYkdaN25QWVNva25v?=
 =?utf-8?B?S1MzenhRRzZ6WXJXRTJaK0Nla0ZVcURzOTRaTjFuL2JycERVVldGTTc2MFI2?=
 =?utf-8?B?ZEdwbnEwNmZwdzJwYUNLMndYUzZYd3A5T2hxNWNabjBpVUVLWUt5bjJaeUo3?=
 =?utf-8?B?U085S2cxVUhsUGN2aVhPV0czWDk0YU5xZC92WTl2YUp3N1ZkUEFVNlMyWmFj?=
 =?utf-8?B?NUVKdDkxS29OMm5XVHlCZFFTbUt1MHNzK0Vlc1NkSFRqQURTb3EzS3pYOVJP?=
 =?utf-8?B?RldMQjlRNlJSVjIzYmdxSFFOMWIrRDFZNHduSEFPRzdlRDFJY1BlL2I1RFNY?=
 =?utf-8?B?Rit1QlNwVUc4WFNhZW4rQUYyR0oxTnc1NGFyNUdNdDBwQ3U1WWxkY1c2MG1Q?=
 =?utf-8?B?anJZbnRxVCt5elZ5TWRYSXdPVk81R08xOUNEM1JOSUdKTTZubmkrai9FUnRH?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hGyepmPdEM16u5spzABrvosUVHu7lcr4yTDxwzJ1TTWdUVG3L49y3fp2s0vqyxUhPgUEldv/5BQe9on5xxATioCLrfmOPeohRLuhtC8xWy1L9Qz1L4A6lOX+N0GH52T4Gsd7AcdQkbaGWnNRPh2p7ez58JPmqF9VUfv4xnPIYywwd00UIYnZ1j12MZ5SIve7Tl0SFrAQGqcPdBJPJCbxosNA8zgR+Q7m2PNMFokYf1jZGpA873x2pwdvrziUaBYy9wvrGxR3jnUK/BZzWQLdmL5pP1UsvrZEggKdhhhYWaY3tw3/IWjXikZ/go7E8XVjywgYLWWtC5RPR0o29u7pYDb8Ms7JNZJXQZ38cdBuenUaIoaxuxkcH9q8oRRevbAuifVcfznquNkJ+lNI96YHWjzcqWTTReek9cbtGzHyICPQhUBq1xNBhjN2E5sbYpz5GrzxMIYePvb76AN3jo8rmtltHD+hNuRLBhAzagMJqJS04S6ys7+sjfDb7/3PhVFjbd0lKPW/21kzakh1u5BdiLQ7DE619Ya9fmaxqKouxVYpSFZe8MYKmB8EuZtFjiCy23UHrHHObwQqa24w+jgJrk6ILEvekltmsO4zjNVZS6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf554eb-42ee-432f-13cd-08ddfcff482c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:19:11.5563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmpRUUMzoZ8bJ37eR6zvYGGDTol5gEo9NvclBP7S5OUg4n6/j8uLuvywMzcqY9G72q2dneX6c23tOCjwxAk1xG/obV/Q95kw/4htVY4UokI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509260123
X-Proofpoint-GUID: eMXVtFQIguJ--UnSa2Wl_FScvhEAcrqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDExNiBTYWx0ZWRfXwiPRe8bKwbel
 vBlXOdQFarRSfQiDJyDQCQr9ykAhs0zNemUZpP5/UySPtRJ19wlyrcLhg4p4nYFjNEaJf3RLEmZ
 U2IplBPB3naA5+OOY5fApkBI9xWImNpZH/I3DYQcQfTwgC/TZVDePO2Sbilf8irP7FqKPCK7Tb1
 cAIN/C4iRCdcOx5Zsign5dXGfCKkJTx1ix0a7NUPGRvgXns/8vecZ0x7zVKVAM+VvG54hlB9qap
 d92Q0PlH/FNW0kfnx4yBZY1Ffy8EFhIp2lc7pHjG1BLw4xoPvw/cdNOZcCdT/semfTrOhK/1yJd
 BXVXoYCf/vm+R7oW5mzVyDYhrgCyVHj787EFQ1PRZzAydT/IAIVpq5xQJ1p/fB2QVwbwbH4w+gk
 DfL4FUui14vhWRlqLh7Ys3njELw++Jc5S5GEZn41FbxKWmHYB28=
X-Proofpoint-ORIG-GUID: eMXVtFQIguJ--UnSa2Wl_FScvhEAcrqG
X-Authority-Analysis: v=2.4 cv=L8AQguT8 c=1 sm=1 tr=0 ts=68d692d3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=0rb1dxCaVmGMe61BUjUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf
 awl=host:12090
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

On 9/25/2025 10:25 PM, Zhenzhong Duan wrote:
> After CPR transfer, source QEMU close kvm fd and free kvm_state,
> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
> pointer reference.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9060599cd7..a3e2d11763 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3479,7 +3479,7 @@ int kvm_device_access(int fd, int group, uint64_t attr,
>   
>   bool kvm_has_sync_mmu(void)
>   {
> -    return kvm_state->sync_mmu;
> +    return kvm_state && kvm_state->sync_mmu;
>   }
>   
>   int kvm_has_vcpu_events(void)


