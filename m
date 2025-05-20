Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C5BC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSjH-0006ox-Il; Tue, 20 May 2025 15:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHSjF-0006oh-9e
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:34:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHSjD-0003dH-C3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:34:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJMoBt009328;
 Tue, 20 May 2025 19:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=h4cGJU/UM8d2ty4yjuFDa5znuLG7IbNBeO986AlWKw4=; b=
 XPtA6tkfkEETgjCB4MJANAUNKeRMoPKNvIyTF0c7yzDmCSLIZKw8NHZNg+udLIKl
 AB3M97Sq102B/gStODnFNLj6mwi7zlSlp/Mtdnr/jS3JRTonhxo6Ne8MMO3VRVm2
 s+c6IrI41t2RbS47LAofbhoU7xh6psoL2rsYDcUQJ9E9KiojPCvmLeDdlhclSvNe
 TS7vcD5SY+1abLpOJz18zcCX8bCMEFde2JsmlYTr+83OmXdx0EIKvny08JzsiSoD
 usvVqDOfAPcj2UTkH/9U8HJm1Z90ZAHnTuaLdBdAaFXwnYzojI6lmShdEhncd+mO
 JE08Vt+S1+3Efqtq/YYXzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ryu880v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 19:34:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KI6ark024337; Tue, 20 May 2025 19:34:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwekf820-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 19:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWXLNtLuGnC/fWIITRrCF0/d+0ltxNDH76auUihwWmyIGN3+2vcXKeHTYUG2DXRScUGdEiCWFF5c0iBrFbY5aIBo4MlW9x0HWKc3I8Ern1dvt7YhmdC7YnLm0DUDbXNqDZ3AsdDQ1pvI4L92dbu22OysO37ddueYxRhbJzowjRraGAo7HooO9YHfAImF7bW6fMtYiHg2CmNZc7pXUuB5krWaYgUOTqmm/66x+Lnjd7J2/Vzi0fSPF0lSyXEUQ5D9ie3LX06HrlU64wDn79Oz9moj2kfqROJZmKFdOwCAjUkp5fidipvbboIEoTymcJB7XjeCbs0/6fvx2J8WzhsHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4cGJU/UM8d2ty4yjuFDa5znuLG7IbNBeO986AlWKw4=;
 b=uIs/Mtnnp0AkQTBykaYbVcrHPFMnKMBzkNG8U9pLOcJiRXCaPIkSpK7FGAsWJTNj3vYpNrYxUTQJCkBlNBnGoo+vwxDifY10RdP1wdNpFRMwXlJQW57BjITe8/qpSpw9Km7tgtRvB9IK2ZxSvYZinNL1s3fXYEbgcPyuWXOhwDlBWAZvTnMfokSE1wkfVMRk88jS2VaTpnP7jr/KfFrIaZXNHUcg+QujKfwo3yspVyIA750E5Z8dn1ftBImqlQwQcNjcVh/HXvik/uv9FE0PfV0oxt1/MbVJb7tMnxppL6rwjwma6dgE+FUxEnogx+9fCO1P0Vs0OJAwthOEP3iF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4cGJU/UM8d2ty4yjuFDa5znuLG7IbNBeO986AlWKw4=;
 b=njj9rhjW5NhMp9dOrbJBcFQDRVGkH2eQqWqsrkrCNaKe/BiRhA5qgNwRjlsGGimw3pbh1u3qR+L71m4xCTEipfDfCAOrhnUhhNZqOZJdmgnrqMaxBM/acjiZxBTAkvIriIurxzuJLo73EbhWlUM94TjXLXppSgsPTTdcvaRXbDY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5666.namprd10.prod.outlook.com (2603:10b6:303:19b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 20 May
 2025 19:34:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 19:34:12 +0000
Message-ID: <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
Date: Tue, 20 May 2025 15:34:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
From: Steven Sistare <steven.sistare@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
Content-Language: en-US
In-Reply-To: <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:208:35::39) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf8be83-6750-4855-97f0-08dd97d54c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFB6WUhOK1ZRQ0FQZXZTSGc1Q3V4L1RNdkFwWnhHK2FJaU56QUlWSmpuMnp3?=
 =?utf-8?B?VXZDZWdQUWF0VEltNUJkenRIaU13S1pzR1dXeW5iZVBBckR1c1g0MUsyTENh?=
 =?utf-8?B?TzMzenEzWkVNclRzRUtyb0JaMnlJLzF0SnVPK2xZWTR0MUtMMUtSbUJzYmN3?=
 =?utf-8?B?ODU3VFVwK3MycHM3ckF2aEZhbnpxV2NZblFMNEV3MzZoK0dZejA2d3N2TFd4?=
 =?utf-8?B?bXVnOHZ1bGRNSDJZNlJzR3NuS1ljNjhMcUp6RWQ1a1BPUFdTOENldnlMdjVa?=
 =?utf-8?B?WGJOZGZUVVRJNU9VRkxONHBtYmlBcjlPUFBvRUZHeWRyNnJvbzMxWWdjc1Rw?=
 =?utf-8?B?blpNVENrRTd0a21idHpQVzcrdUxMa3FSQjQwYVlBMWJiZC9hMThFV0l1NGZm?=
 =?utf-8?B?VzlmbWF5dWptYWNodWJ5SU5ZeVRSU2Y4UEhIU0xZR1VZWkI0NjBNMk5pUXNJ?=
 =?utf-8?B?U0RwaDZoSE03NVRXVHZvMVVkUEdVc0MrWjBGNWlvR3I1YUFqZHJuN2JBSGta?=
 =?utf-8?B?aWV4MzFleThKSGEzMlRoVmRDOXEyVGh5Vk9Kalk1UmgwcWNOOXhydm12OU1u?=
 =?utf-8?B?Q09salliNzB4dnYrdkRDdUczaVhVbWxUdVJxdDFhY002anRoOWdGdkxNWExJ?=
 =?utf-8?B?U3NUdWxmRUFIMnBwZzJYT0FmZ1FDNlZWVEhxME5tUDdyM0doQ21BZ3VGSWJn?=
 =?utf-8?B?OTJxSTF0c0NNOTZSWmlsSDBlUHBaSmpvczdnbEVZNER5cGN0RnBlc3VGR0N3?=
 =?utf-8?B?TkRJMDN5cVdsR0YrTUE0VGV4RVB1c0g4L3lobXRsS3lmSlQwK2VUVCsxZXEv?=
 =?utf-8?B?YVRBS1ZVZVZ2WHJYOXhsQks4amhjVmhhdm04UTN6bVNuT04wK3JKdnlzdVRE?=
 =?utf-8?B?bVFuUDg4MFVQTmtuaHhzQ3FPV1QvcTF4Qkw3VWRJYzN6VmU5V0NKVGFBWFBJ?=
 =?utf-8?B?MUh2RkNKaDNneEw1RDNaRmtPbXVPRDJJd3BBSmprdzNiQzk5eGlHWlFqUE5m?=
 =?utf-8?B?YmFnRnlreTVUTWlJNSs1Yk80M3JHNXRYY1ZOMHVlcGc3eHVadzlabzFVcEJz?=
 =?utf-8?B?S1lWVUl3NXRBazJPRjdnODJMQ3dteTB3eVEvWEsvL2RVY1Nncnk3U1hrQXd6?=
 =?utf-8?B?UDNrTkpla2k3aFVCUWZISk1uZHdjak5Balo4NTFERXhZSGJwS0ZvRjNXQXdI?=
 =?utf-8?B?dlc0RTZHLzByK0U5ZkxFQ25XdG1icFVzOWEwemdQUkV4R1RhYlo0S3NKWkRX?=
 =?utf-8?B?NzUyM000cStIWHNoSVVrOG1FbVlpVk1RM3lKUzQyYXdiZmcrM3prQW9KcDVu?=
 =?utf-8?B?OUdzc1Uwc0l3Zk1DeG5pWHozRXIwYW1aQ1R0NjZNMkpWVTJHVmhxQWNVN21t?=
 =?utf-8?B?QXV0RXpGWXBhUEthNjVNblVTNDJ1K0oyN0RiWlZWQkxEV0p5Z01TejlaalFq?=
 =?utf-8?B?eWdHWFZEZWNuUElZdGZpSTM4SFV3dGE4VCtGMnkzK2pBZGhYL052ejVIUHRM?=
 =?utf-8?B?bHd4Um1CeGFaVzN4NzBIaHZWK2xrRUxjME1TUkRTVGY3Mm9kb1FYRE8wRjVK?=
 =?utf-8?B?V1pJVEFGUmROdCtCSkpZYUE4MW1heFRCSlRrTHBqdzhVYTRFMDB0OTR6OHMx?=
 =?utf-8?B?T3pwZms5L2Q1dHlwRktKL0tGQ2JiVzd2aGZGZ2tkd0ozd2RUdDVWUHRueE5Y?=
 =?utf-8?B?c2hzbFQvMWpIMnhpYWtMZW5va2ZaT2puNUVXMUZIck9lTTZxd2RacVcyaGRS?=
 =?utf-8?B?V2laUFQ4dFpPczlwVFY2WFkxODlYZ2dRVXc1Qk9IdzBQR1puMjNZSWY5dEhI?=
 =?utf-8?B?N0FHK3l6ZzlpTUROUWNSTjA2Y25VUWx2NTZnYVB4YnZwWnlLQ3Urb041YlNQ?=
 =?utf-8?B?R2VWcWlQK3RuYkk5TXNEQ0JSUlJNemwvcDkxZWVBWmMzZ1FjTXh5NjZmbW9y?=
 =?utf-8?Q?89aeAPmWUJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpIU2JtbWxzNm81WVN5VkU0UTliMEZDa2JTL0dPMTZuQVg2RHZ3WDdnL2J3?=
 =?utf-8?B?UWI1NnlzSHdmOW9UM2ZjblhUNUdnTFVUamw1cDlaWDhnbWtpVmM3V0ZmZ012?=
 =?utf-8?B?eTg4N2MwTy9vSUovU1NxM09mNkh1SzJNYlVwZ0ZKcEsvZ0FHZyswc1JUS0ho?=
 =?utf-8?B?OVFiQlhpVCtGV2FibXRvV045Y0JoWFNNQlY5andJcmRBT0JXS0xBOE15RjBE?=
 =?utf-8?B?eXpHQVd3aisycnFEYmJmb2hId0Fma2hmUi83RC9RM2svTEY3TVcrK1R3dVVV?=
 =?utf-8?B?WW1Ic2VqUkMvTkVkeTh0RFVMR1hxTDJtTmxNM0tlTnFYOExBNGY2M2VZTVh5?=
 =?utf-8?B?K3BxejNRY3Z1UHVjbnZVdVhPUXVpTVR3Z3hXSDNkQnNkZm5jTmorUURWeUVM?=
 =?utf-8?B?S2dlQmhSWFZQL1Qwd2d6OXZBN2o3TUVGdVl5OGtmMlFmTEZSczlwV0pyMGV6?=
 =?utf-8?B?VjBEQ2RsbG05Mi91WWFGSitOQ0tHdW8wa1U1elloaEZCcS9wWFRpT0hZb3V3?=
 =?utf-8?B?R3ZjVnNRTGh0RzNQRWtYRTRSY1Y1bmVIeDZLV1YwRXRad0hIM2kvcTluSDc0?=
 =?utf-8?B?SlhrV1JLRzNHUkVydzA2emJjNW9hZU9FL0xvaWpNL3ByM0ErUU5rRERUL0pI?=
 =?utf-8?B?TC9TUklwR1RDQ21JZ2QreWJtaG5ZNXdkQUhlbmNCaWNwSEJDQm5iaHFVdjZX?=
 =?utf-8?B?ei9LVzJiRG5XL2lhWVlBcmNvY2dnWjNTb21vWnJWbkxYei91c2NlMEZCSFo4?=
 =?utf-8?B?eVUyNjRWaVUybGhoNkRodE5ZclNzazVLZjcvR3JzQ3h2VjFySTMxZVpqeVZH?=
 =?utf-8?B?ME5TK25BKzNwSXl3Q0NieVIvajdaTUZESUp2TTFxeGhFcFJzZE1nZzFldFRn?=
 =?utf-8?B?aHRwTkZiUnFxWVA1TitOWDZ2VkNBVWVuajBBdXR3NlNsdE5LQjM3MGhac1FY?=
 =?utf-8?B?S3ZIQjg0TTQ5MWRQL2VFQkkxWlVBamljWFRub3lCd0tvT0ZiT0M2d290dUU5?=
 =?utf-8?B?MVVBRUoyb1pMYzF2aVVhU2hDNldDWTBMaS82YmpKRTdrOGFiZlViakVBcnpJ?=
 =?utf-8?B?clNRTmRwVUkxRHNNRmtJSko5RjJlWDhvTDUzME1kcXN4L2hIRzI3RzF6aWlt?=
 =?utf-8?B?d2RxbWdycHo4TjhmR0lmeFM0LzFQWU0xN1Z1WXRQNW05NElDUlBIYUZFQzVv?=
 =?utf-8?B?WS9YcWVuNEQwRU9JZmhpWFlqVVNieGsxbVFmbjBqNG1YRHNZVzJoWjFSNUZM?=
 =?utf-8?B?WTg4WkZQLzlIVUZHUkZHcDBtbE5EcFBsWk9MSGNrYzRLbXR0MWhZeC9xeXpS?=
 =?utf-8?B?NVM1UDhJR2h6dFFoN2VndTN1YmNma3RTWlFpRDNyeGhqa3NXdjNOOE9EeW1o?=
 =?utf-8?B?dEltb2QxSW44VFVQbWhFbGpYQW5icjRmOXdqMmNVbGdIbGlWSHJJcVNlRDFG?=
 =?utf-8?B?bm0ydjFzTmFONWI3amcramUzaEh4WHR6dXpXWG93TlMwbTdyU1BOLy9nTWNV?=
 =?utf-8?B?aWR1R29iTnAwMmNxK0hrTEgyWmVVejU1emxUd1ZzbkM2QmNaQ0tPa2RENFVW?=
 =?utf-8?B?TUswazB2VGxPUEdaTDlQc1duVW1hVzB6dUwrdU5jUWZQaDZyK0pGWTczTlFF?=
 =?utf-8?B?bklGRmYyME40Tmh0cVVFUWIweklFU2d2MGJ0MkVoZzlyZm9HYzByVnBCU2Q5?=
 =?utf-8?B?aVhiZTJRY29XL0s2RGMzYnQrSVNhdEE3N2pmZ2FCYUxzZEx2Ukt6WGEzd2NN?=
 =?utf-8?B?dzF1ZllqTkhHanFKVmJvNmx2enhlcWR3WkhibjRhb2w3cHU0SzV0K2JCcWZM?=
 =?utf-8?B?SEF4cjAzeUtwQmJYZFRQNnZwekp3aS9ya2dyWDdXNXM4cmNCWjFPODdhblFw?=
 =?utf-8?B?aDhpb01SdjFWYlh4bTJvOStyMDBjeUJ0SGZMcHVpV0hBbVZvRmZvRThsZVpy?=
 =?utf-8?B?dXF1UEY2TEJyUU9Gekt2RUxEdjk4RHFlSy84cmhJK2paZzVHc0xpUGMzRDN3?=
 =?utf-8?B?bnZDQVROWW9yL1dTRGZtTTFvNmNvL3F3VzljOEZDTGdWdURGQW5GR0ZtNW9K?=
 =?utf-8?B?T3dnVVB0YUFEcTJSNlpZWWlaRlBkVC9KWUVpNTJod095aHBrUUlRQnVXLzJh?=
 =?utf-8?B?cFZTUXRmOGF1MXFPeVlNYy9KblhiamZXQm1QTlFDbmxPZU53Z1JiRmhGM0hh?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BzCLpzrGumZsbM1V/OUo1m7TcIOCVmxK/zZRUrzBcOAztLkIYMDHhcBS0zj8UZEH7Aps/dt/Rp76Vm3uDX/l4p4q7MVlq01frClsREhSwvHkvfVoRL5yEwH3juYolaheaU3B6A7aERaDDtG6GLgm0MOzCh7ZpM40+uNFLPKVaAsvQ1ZRD+Sc/yfmvmsJz4lipxB++tT5yHDVrRYvMYcESnjrD9xLCao8gjDwwN0EIZ3yte7tY1+fDXrNFeRu3/P0H5+S5vxTr7PbFALxLINffyo/4c8SyWW7xOgisgARf61ok/Nb5SVxNIJ3zSGz+PxweRMT1EYXADNFliKm4lGz9DFR8NGW3pVlfV6voa0uqXC9GGN3Lrur4/ojiXVs9Ct+v7HKwO+t1w5hNC3ID1tN7j8Tat9lZKuXAJJKg1XbXukaWAUckRgtiGg5P0SUSKC9LUecebrFsy/SBuNxadGlTASrk4JB8YOk5qDY46HY3dwkfSn1lYOQeL6fhd/r0zs3xaV9VYWFpwmXJUA3+09ZudfXVp2NKenFP7JiuYsQlrOqRj93ovqiEGgIYRoBQnExW/aYJzqR2+0rPsPjhQ4cZKibl/5Myx7EZm6ySwYoZ94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf8be83-6750-4855-97f0-08dd97d54c78
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 19:34:12.4241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVYqW0st0rAu6KJ01ToltNEBYn4IlSZY9c7PlfAEwxQmWdRE0c39v57R2+cx9fH1lXc5jTN16gy4MjwEtKMqhqIELXPN5ykXzxEC3wkCH3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200159
X-Authority-Analysis: v=2.4 cv=HaQUTjE8 c=1 sm=1 tr=0 ts=682cd938 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=Z0155avhQ0J_jkPRXvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: npYOMTgeEeBRux_LZc9S9ebxOYtLSpvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE1OSBTYWx0ZWRfX6oPGEsRdCIhj
 +OWt3N1OthMYDdo2jfs2mWrtIbourLbWq4OAW66xHNmJli9eUZRljUt1UBL7IcvYosVN+dsdmRp
 3Me4qvvYy+KfwnzNQBsZubJtm0qrp8xmSyqcytenS4SQ0oP1vEsb+nLuz0HF3nPbPMeWq7VkWIS
 EJbeuimy92axk/HGYjOsO1g86KpHgqIyrZKmRYdOA0rtVR7p+aARHoa8XqPl2IS+Molocu5a0xx
 xwRmPCb4gN2AEaEnY6FtudKjbHhdeuOjqOkvaakQSCK4cDVuJwCvKJcglv84ojaNVzoJKe6E1L8
 4GmPEKiYS/YI85LS2b4bPiQ+LYLfCOYNVCCxVhOlo6lFuvatbp4pCs6ELXhKmnK8LP4OZfiMhGg
 eIiiB9IFJ06WD73VbZWG7j0HUiag/jr1RruKkD3kvKOSs+0PtZkv7ZWlYIuEZgoTWXwXeq7a
X-Proofpoint-GUID: npYOMTgeEeBRux_LZc9S9ebxOYtLSpvt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 5/19/2025 11:51 AM, Steven Sistare wrote:
> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>
>>> Define the change process ioctl
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> backends/iommufd.c       | 20 ++++++++++++++++++++
>>> backends/trace-events    |  1 +
>>> include/system/iommufd.h |  2 ++
>>> 3 files changed, 23 insertions(+)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 5c1958f..6fed1c1 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass *oc,
>>> const void *data)
>>>      object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>>> }
>>>
>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>> +{
>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>> +
>>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>> +}
>>> +
>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>> +{
>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>
>> This is same ioctl as above check, could it be called more than once for same process?
> 
> Yes, and it is a no-op if the process has not changed since the last time DMA
> was mapped.

More questions?
RB?

- Steve

>>> +
>>> +    if (!ret) {
>>> +        error_setg_errno(errp, errno, "IOMMU_IOAS_CHANGE_PROCESS fd %d
>>> failed",
>>> +                         be->fd);
>>> +    }
>>> +    trace_iommufd_change_process(be->fd, ret);
>>> +    return ret;
>>> +}
>>> +
>>> bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>> {
>>>      int fd;
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index f478e18..5ccdf90 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
>>> dbus_vmstate_saving(const char *id) "id: %s"
>>>
>>> # iommufd.c
>>> +iommufd_change_process(int fd, bool ret) "fd=%d (%d)"
>>> iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d
>>> owned=%d users=%d"
>>> iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>>> iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>> index ac700b8..db9ed53 100644
>>> --- a/include/system/iommufd.h
>>> +++ b/include/system/iommufd.h
>>> @@ -64,6 +64,8 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>>                                        uint64_t iova, ram_addr_t size,
>>>                                        uint64_t page_size, uint64_t *data,
>>>                                        Error **errp);
>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be);
>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
>>>
>>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE
>>> "-iommufd"
>>> #endif
>>> -- 
>>> 1.8.3.1
>>
> 


