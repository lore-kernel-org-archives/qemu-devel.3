Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC164C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk05B-0001HM-5S; Thu, 07 Aug 2025 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uk058-0001Go-7T
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 08:50:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uk055-0004Us-OT
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 08:50:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NTlt017945;
 Thu, 7 Aug 2025 12:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=H6w4i5VQxxDWW/zlfBSpiUQ6Bh6flY+QgY7sImTE+4k=; b=
 KJtEGWU8oTLtJzweaE5cWdqgYO6Wr5v+E5D6C3RQq4jbatfIC6fq+zHtf8C9w1GT
 GbVsDszTvWYKIg9aIJUy2yEsuW52hsiZJeGV8YF8Kz9WSj8EzrV/MRBVx0MIO+Vz
 X6OvH3pG4wdi+3NJeYP3DuS3TbGEGIKFcIjuYV7BpfpzdtOnUI1N76OWLslK/ocQ
 qDeYsb8Qb1LHqi2rGK65Vjob9Oey28kpuSnHjnuEzzegH2KRsmMF+tAu7o1vNOCK
 UWbCFG3j/mg+0p6ylBlsPujKZDRY3ZiM3yO2eYcPUNPRGgoNg2adpS+BiRXAdx3x
 Ck3e8VnDGfTlXUDNRFiVWw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve41m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Aug 2025 12:50:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 577B241B027106; Thu, 7 Aug 2025 12:50:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwpchcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Aug 2025 12:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtqvY0/tOk6Y5gIiXnrUNkI9bVVm8N/Kh0yhrvXYKf2kJWNfZcna4vRsCtR1njS/QcPA0hpXkD8sI0WmIHfZvLrB/SetCFVX66GGyWfbQO5knkmPWBy3J96N9jYkO2hHnnIS/B+5ALTyD7khyQdTBcAumXqD1dRLSGnbdzTrCFXCt4+MHNwFIU4prl0iW1cMUI42oJ7++KoaNh9g74SFhlXTEcqK5rhv8uzBUFKAyAqs2rPtaqgDFNTx1IjyoU7guGOGrZN/kwbpfRvzcscIQ1dqBsreEFA1uoiDKekNjf8085aKl59ak41eVMahIV6m9s2rS5Ja0wDnkrlSnCnQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6w4i5VQxxDWW/zlfBSpiUQ6Bh6flY+QgY7sImTE+4k=;
 b=rCBsK6HTWL0HYCzUgf3V1KxKTPy+eBrfVYktCPTUnekDeAVror8ODdqMfrgQ/5xkIz0UTtAxqHAbLWtO2DG5w2NacsFbOOYnlTBEVOB69IfCn972iNIAMORkT2XepPxdSxHODLVy7hkbqqTv5j/GuDFhPuk85Ql2SGoXueD4tVjAq0xwyJl4DgX6BJRqAyo59K/YcrJADOkVOmWia/D2LZ+Z3HT0lsZp+JNUEYOTcR2qwJ5ew+WL9eJ1Wa7NIxIU3K7V/i52wsjUpK7ZfAQ/YBEI62SWzwxMoat9P/Oc4ALSmpIAf81rTpJs6cdsvwJ1CSHWIv/vcQUgt7manjnuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6w4i5VQxxDWW/zlfBSpiUQ6Bh6flY+QgY7sImTE+4k=;
 b=dPeRjL9maKlOyBQDLSQczR1QosIEtRpyE+szwwz0WPjKMKneJF4X3VHIiNPub5ovurA3FYzysPFfF/VIqkyugj7s1JdZwNliC5EOz0IzYz2d9K4kaf6gpmN6rAP/Ww3BAV3T16TOa6c6ODUs8zEv/OT8kvQ6MtriUejhGyxu/Dk=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SJ1PR10MB5977.namprd10.prod.outlook.com (2603:10b6:a03:488::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 12:50:42 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Thu, 7 Aug 2025
 12:50:42 +0000
Message-ID: <71a1cb1b-49b9-4a4c-aa6d-429aa3cf8a8a@oracle.com>
Date: Thu, 7 Aug 2025 08:50:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <aJN7uOWSt10U7DMi@x1.local>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <aJN7uOWSt10U7DMi@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SJ1PR10MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb95b1a-e3f9-4e54-7530-08ddd5b10449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3NXZjlJakZIME55UFVZakNmTmlkT0VBZzRHbmMzdlRmc3IrcGhnN3FhL0Qr?=
 =?utf-8?B?K2xyWUU5TzFlRkxuK0U4V29IR2NNVVB0U2Q4MUdIdWIzUko4WWw0K0xGd0hn?=
 =?utf-8?B?cEYwTTh1Q2Q3cEtXUmdQcndNRTJmaEdJNkVaUk5jRUF5a3hjNjhtTUw3QWRn?=
 =?utf-8?B?bGxmdHBLbWlpZGY5SHZoT0F0cTY1cGFSazBVQnVCMDVlbThVZWhGNC9lY2FT?=
 =?utf-8?B?dW13dGNtSzZJZFdZZWJNVnJlQjhDaHJTdUthK3pvbUgzRXdCM3ZPL0E0dmZ5?=
 =?utf-8?B?Q2N5S0pocHZUVXVuSCszQ2NWWHNseDB6bkJvK3lHRkxhTTFXSVJybU52QTZv?=
 =?utf-8?B?YTRaTnhGZnR5RzdPT09ic2FhSVZQVDJJc3ZPSFNJcE8vRER6dWZLbG5WbG1N?=
 =?utf-8?B?WjQ4TFhOUzFlNG1ZcjBYZXBCaFQ5WFVrMnBrRnVVN3U4amxmQjl0dUVUNmh1?=
 =?utf-8?B?SWNlQkdJWUowdHZNK0gzOTVVSjVCelVOeFpaYjhLalF2ekhjYUs2WlptOWlN?=
 =?utf-8?B?Ly9HdzMxeXRGTWY1VEs0SU1uR21mc0RHcWFSSW5RSmRDUVdXWVFvdmZ0ek5v?=
 =?utf-8?B?dTZNNE9sLzd4VXZpaEZGL0RGN2ZOM29zOS8xYWRSazBPMWRLSHIyQ2w2TlBV?=
 =?utf-8?B?amd6QVhDaVdjbUVUMkVMSGxpY05QV3hZL3g1RHlFVWRROFBIVldYZVlwaEZY?=
 =?utf-8?B?ZlAvUWx1b25mdU9RZlhjN1FqL1VhSWJxc1ROMzk2bWM5REwyWVJ6a0h2c1dm?=
 =?utf-8?B?eFVZeUY4YnRyVWVqZWNsNHNzNVI4YkQway9UbkJkNEZKZTVmVFk2WGxuSFdH?=
 =?utf-8?B?elRCMGQrV1RMS1lzczhJTitTVHhuSytTdTFBU242OVZUS3BIc0xqSWJRNWZo?=
 =?utf-8?B?Zlp0OWVBZmFxTEZkMGQ5dXZSNnRHYVBXTmEzSXk4c0NHT0ZxTVM5Ri85Wk1F?=
 =?utf-8?B?YWNDNWN3cy9aNjNKT3djU3BEVUVxVDQ3enIwUTkrN0gwZkluMkxFSHpuckJ6?=
 =?utf-8?B?bWtXeVhVTmVxYXM1OHl1MUdySko2SWxWcFRzL3M1cTZCbXhXc1lZMVNISHRS?=
 =?utf-8?B?NVM4VzNDamN3bGpoQVJxMmtFNDZ3QTA5QWlLdmhWV0ZpZnZycHRNSlhPcXRU?=
 =?utf-8?B?SnVOUkJJTDFuU1JidXBHWkF4LzFMQjNVSWVLYUdWL0JEc3h2elUvdnFhNHBa?=
 =?utf-8?B?Z3JUeERxRk5ETlZKcGpyN1dtNjY2YTRNZUMxV2hsV3gyRmhKSHduY3h6OTNW?=
 =?utf-8?B?SEhMMVNWWHJYZjQvNE54SEdvdTlnMzZHL1dQcEZ3WXNpNFVwL25MMnZJTTli?=
 =?utf-8?B?UXpsSXJmNDZ2QUQ5eExFcTB6M3h1NGk3VGovU2x5bWt1eEVlbnpmbnRUZkQx?=
 =?utf-8?B?WDlFck5DaTcwVjJ0MHVoZmMxTE85RE5xM0FIalVNZWVOelNaclphZGJBTFdr?=
 =?utf-8?B?UG5kT1d1VkVRWDI1Y0xRcVhhU2lsSDJ3N0hWUTZ4UjFLc29aQ1lqVXpJYjhG?=
 =?utf-8?B?YzNVU0tpSXFvbm52bWNKcEM0YUxBUEF1NjVhaUpHa1E5QW5nUHZhZnNKdHlr?=
 =?utf-8?B?Q25rdkR5YkppVVRqK3Y4Tlhwenp4Umpsb3c2QzQ4M1Y4UlFoNWg0bDE4WEdi?=
 =?utf-8?B?SDRBQ0F0UUhPVy9lTTFZTzFTdDFBU1pxRUJpdktxK29zUXdub3lPakU5NTJV?=
 =?utf-8?B?aGhLQjJQNU5kR1d1ZnAxMlQ2TW4rTU5BVHhXQnVwZWtzcEc5ekxWMnZwbUhh?=
 =?utf-8?B?MDV1Nnd4RGR3YVYwY0E4NVRhRlg4S1NaU3pzRWpKN1JWaUROeS9ZTkFlUDB4?=
 =?utf-8?B?WkZDQnF2eHVkakRqT0Via1A2WW5zOFhNWElGZlh6d3QzVTdWRGJJNVd3akFy?=
 =?utf-8?B?YU1IZDZuNy80bUNROVlVTDNaWklxVnhxZ09oQnl3cTNPcmhydWZ2TWRTdlpK?=
 =?utf-8?Q?8iUCziHgZNI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dwZG1XMFlGWWlCb0JvK2d6aUkrZDhNcGgxQjhSbEdsTDBoT05wWksrZGJU?=
 =?utf-8?B?MlZYMEU1UTBHc3JaYlFyTGZ0dDg1WFM1Q29Tbjd0ckJhcGM3aEdyNUpUcHl6?=
 =?utf-8?B?WVowdUtUaDc3bUo3UTJqZnM1R0swNjVwT1JURXVpRjY4L0ZOdjV5RitZOG5R?=
 =?utf-8?B?ZWxEZXpUUU14MUZkbUpGWkdVZ1pjQ0ZoNy9lNWV0Q0tZYVNMdFZ2K1Fhcm4r?=
 =?utf-8?B?V0pJVVV4TnhVRHdGNC9ydEd5OGR2OFN4STA3ek44UVd3elhXRXRPZlhNNHdZ?=
 =?utf-8?B?RVRjMmdHYVJJbVU3RDZUNHFSMUgwdDgwaFMzbC8vb3c1OFA2NW5YUlZvZGMy?=
 =?utf-8?B?bUJ0c1BsMzZwSUxTa0pEV2RVSjN2Q1U0RHdNUDBtcjlEVnRWdHptZW11MlRO?=
 =?utf-8?B?YS91d3FaRXNXOUoyYWZvaUl5WitpWkJEc2QrbkhGQmlVdmJzMmt6bjJzMWpM?=
 =?utf-8?B?ZC81TmordENTeWNTbW80L00yNldxTzk0TU9Ec01Qa0VaK1FkQ3FwVWpxd3ps?=
 =?utf-8?B?ekxNTFYrcjNyWUJyVUFFRGUvOTF4M0FlYTRPNU9wdWtEb1VDbmo2dllYZlNG?=
 =?utf-8?B?T21OUzdSQm9aTUNLK0NHQ0lVekxVREhLUDJCNXdRMUlDcDRHOStabHFXRDc1?=
 =?utf-8?B?WlJEWEErMy83K3NnbVoxTlJiRFNpNHVWaUFnTnBVR0JIcXhFZU9nODBvazZI?=
 =?utf-8?B?d21BdmlDWWlPbmVnMEd5UWpVMWVaZldNTUcrQ2NyWldLb1Nvb0l4aVV1R1p4?=
 =?utf-8?B?ZnFzK0Y1Nll6TzBtc1ZoM1NhcW9GSXhaK0txc0hFRG5WeDJNU3B2UVh1Nkx3?=
 =?utf-8?B?WlFGK3NreWpLakxJbGpTNmdTT0dvR0NSY2hCSXRYOUJpVERlZDVMWmhMVkY5?=
 =?utf-8?B?VFVhNUVBU04zTzJ3VXRDVzZGNE5sb05ub0pJVmpYUzlxYW94VGFuTi9OdEl1?=
 =?utf-8?B?bnhrcXdpWllNN2krS2Q5UjM0a1JxMW9yZ1RDT3hzaWhJSlFiY3ZueTJlOHc1?=
 =?utf-8?B?U3JJaEt0eWk1UytQU2dwRjAvTURQZTV4azhSTlVMUFRTRFdEYnNmaXA2VCtO?=
 =?utf-8?B?TERBOU51cktqTmJJR3NySTVuVXM3Y1dLMVBqcjlRYkNoSGFvZytJVE1UcFZL?=
 =?utf-8?B?SmlONDljYTg5aXk0RnFwSnBQK0ZDU3E2ZVl0ZTBpbnZEd0h6dUh2MVREUDNO?=
 =?utf-8?B?VUdWNFJUb1RldHBvNjBjQlEyWWttQTNseHBra1R0TzlndEZyV1Y3dGtYajNi?=
 =?utf-8?B?V2x6S0RDUVJLSU1wK2ROb3pLU0IrOW5Iem9TRWRVNzhEdktrSzZmSjJLT01N?=
 =?utf-8?B?bTE4dDlWanp3eEFiTE03d0tkNEtLclJLejc4VDQrQXpvYTNFYUEyenBoVlQr?=
 =?utf-8?B?aHhhRnRVT3psZjBJREp0STd3aVBJbkNCRlA2T2w4UUlKc3BCU3duU1RIeGU2?=
 =?utf-8?B?MzdpTEcxUUFQUGpsWXNCZTh1WjBmS1V5K3g5VllqVW1aQnFDZWVibWxtRTB5?=
 =?utf-8?B?aStaRktlVnFJQUo3SXpHblplYmlkZTh1WVFjOThvdUtsanErL3ZvSTF2TE5Z?=
 =?utf-8?B?T0pyOExkOWZNd05QYXk5aW9LSWFWdFRmbG9EL3JiRWZZUjhYaHJ5aXVWalNl?=
 =?utf-8?B?TlFVT0VweHVNOFN6bjJYUkRQSmhRREI2NW94WHlCcm5FVnNJbTlKVDVEZjdH?=
 =?utf-8?B?YlVTOFFXSTh3MDJGRkNqb1UzY3RvOWxsdFdvbUt0SzZZREhXd05PT3ZoMGpp?=
 =?utf-8?B?Sjg2aUNQUHI2eXN5QzdDR0Fac2dlVG10QUNtMnlkUUFtN0lVOStCdTM3Rk52?=
 =?utf-8?B?ejFrS0pqditPenVwWUN5eW4zcnN5em9JcUdoY2ppQ3UxRlhQc1RURitXQ1d5?=
 =?utf-8?B?ZG1XS3Y3bndsOHRoUTJ3aldVd09rUDczRWR6NlZiS3dNQlJmOWIzMzhTbnJ1?=
 =?utf-8?B?cTJkd1dsMy95SVhKcDJMbmZ5STg3dXNSbGg2NlpBSHo4RTViRDVsUVhXVmR1?=
 =?utf-8?B?bHZPZWVjL3hNTElIaXRmRVNNSnd3cEg5ZnhIMDJWTkFtQmhXWjRLNWFBdkFJ?=
 =?utf-8?B?bkZwNmJxYmVRWmtWcVdYa3FpaUhXZW9odE1uWXczRGc5UHk4WVQ5M09pLy9z?=
 =?utf-8?Q?GI6r8jczCcqYKpbPssO9lC0qb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IoxoGjKzr/yH8yoMFuyVLVV7m6y8yrJXapvuITL325kmgs2AIBuGACRdURtmNYdwIyksNmlq2PjCT5142qZKlRUiUBCAxVztYjqD+xZMsARJDeNIOkl7TZmqn5Lgsxyh+W+OF1LwQzYfturMVrhIhUQbkaBFshi9AuIkVLKli61cAZ1t2dYGp6rrHCgPJIaf7fqfq96o3TbT+WKPuOtSeZqDUTSCW4Nx0xVbvUZD9KeWkEz4cNe8vjp+ZcvLOcS4IxCwsaSUf+M/dw9MVlmX9GHb1s5gitHneArIUUoqfStwUVlFUIb/ggFMGAMz/XOqcIR/YtDbhmdWIf+iJIhXWGUNccPrdSND33LCDHYf0QWYwvwj11e8anTVniZOe6SbzOBNcSgLy0KY1pJXnYOMWGxdw/Oiq3YYEYgJ7Nj/CMaIsWwqOIroR4uwRoDW5bW7cm2WKb8cDc79nqce/f7qzfsRaGh28XLXHw+H+4Og+M07j2W3g/BEbxDbqSyOewcjyF2o10BchSGbjj/wbCTfLNgvhvd/d1z/6OZnW9SLCfjGkD2flwqIXvZvZQToF/Y9fMVHVyLXWKYz5nwNARo/Ui/nW6wXXxuyQ+bxV3t8snU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb95b1a-e3f9-4e54-7530-08ddd5b10449
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:50:42.1134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pGoNX2HoNCXAhJRZMMEsYgH8fLP5lpmtB4yfoAZTzIhcX5qFby6Gau4VlSnh1z6/CMBQ8QKU/vr6nMDSj0abQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEwMyBTYWx0ZWRfX3qzsUSMoBq8H
 Yt3X+NhnnfWkbBUr/VGJGi8ALTieVrn70c/0UZ/z9feOOXcobdkqbmlCRV8BMovossJF3PHuthZ
 okUKwwhScsppY5rVqwZ/FgXkfv0zrgAxjYmvx+rHRXIzH1+3/cvebmJ6S7Tdw3QShb3FYPsjkXg
 qhv1HXvFmO2vrwfaP3F4h92jSVlG8l+4o/8xFklKuoGJiPD4/NFGgu7XEf+EGGFn8w8ejlS9NrI
 JpPeJMh9q7FX5nJxglynVREN5w633+RAplpxNiUcjcgOs3uOP6DixuMPMMk4d7LUGYeTr3jE+Mx
 /zE65IDU144Fb+FF8y0BAXtcjiaaglGvJ2QeR5HQDJn3Y8l7WraNiH/tEaJ4M7IEb9z/s6O92AA
 yKEZANSekXQGKRf6qqPRkEsIy0BIpXYydNFFwKrVPEHiwOjsDk9wU+HGH54ZinSuI6PDH2JY
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=6894a126 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=yJHClvY6FQyTz9MAU5QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: f10Wfvmmq2bXMgGoVrVZZAmjy2ppTOjT
X-Proofpoint-GUID: f10Wfvmmq2bXMgGoVrVZZAmjy2ppTOjT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 8/6/25 11:58 AM, Peter Xu wrote:
> On Tue, Jul 22, 2025 at 12:41:22PM +0000, Jonah Palmer wrote:
>> Adds a new migration capability 'virtio-iterative' that will allow
>> virtio devices, where supported, to iteratively migrate configuration
>> changes that occur during the migration process.
>>
>> This capability is added to the validated capabilities list to ensure
>> both the source and destination support it before enabling.
>>
>> The capability defaults to off to maintain backward compatibility.
>>
>> To enable the capability via HMP:
>> (qemu) migrate_set_capability virtio-iterative on
>>
>> To enable the capability via QMP:
>> {"execute": "migrate-set-capabilities", "arguments": {
>>       "capabilities": [
>>          { "capability": "virtio-iterative", "state": true }
>>       ]
>>    }
>> }
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   migration/savevm.c  | 1 +
>>   qapi/migration.json | 7 ++++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index bb04a4520d..40a2189866 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>>       switch (capability) {
>>       case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>>       case MIGRATION_CAPABILITY_MAPPED_RAM:
>> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>>           return true;
>>       default:
>>           return false;
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 4963f6ca12..8f042c3ba5 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -479,6 +479,11 @@
>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>   #     such as a file.  (since 9.0)
>>   #
>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>> +#     the device supports it. When enabled, and where supported, virtio
>> +#     devices will track and migrate configuration changes that may
>> +#     occur during the migration process. (Since 10.1)
>> +#
> 
> Having a migration capability to enable iterative support for a specific
> type of device sounds wrong.
> 
> If virtio will be able to support iterative saves, it could provide the
> save_live_iterate() function.  Any explanation why it needs to be a
> migration capability?
> 

It certainly doesn't have to be a migration capability. Perhaps it's 
better as a per-device compatibility property? E.g.:

-device virtio-net-pci,x-iterative-migration=on,...

I was just thinking along the lines of not having this feature enabled 
by default for backwards-compatibility (and something to toggle to 
compare performance during development).

Totally open to suggestions though. I wasn't really sure how best a 
feature/capability like this should be introduced.

>>   # Features:
>>   #
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -498,7 +503,7 @@
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>>              'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'mapped-ram'] }
>> +           'dirty-limit', 'mapped-ram', 'virtio-iterative'] }
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
>> -- 
>> 2.47.1
>>
> 


