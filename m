Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D09E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7ci-0005us-TN; Fri, 13 Dec 2024 10:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tM7cg-0005tg-KG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:30:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tM7cd-0008IX-F8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:30:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDjrPY022556;
 Fri, 13 Dec 2024 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+xdvF7W9AljkB7YmSCx75SGij3Gvc+uNDFoEsv1NFts=; b=
 ovZg/AQ/XY1zHgBBbJUUgvKsbLYOCl+PJH4KVo2sc9fqJxORZECb3yLpFYwWX1hP
 Z5Q1RBLERXLBiWatSu6YCmh7idQEk/RPAtb8wBJaPUKwV5SwPqDz1vVCjZJ+jTlD
 PkF3XE8P3ZhGl/AoZeEM7AjMOh8lBMODspmTsO34uIJe1Jmq9/c8hqz3N7gIBx9q
 GOBvAw6i/Xg4nUr7m9R27shfsWDIEQIyXxB1VMZ+zXIfE9oJDFBuSvPYdW9JumR6
 Oxv6Ft4Arn5zWuc+tN5pRoT4D18U91qoppLx4bN67Fg6TLXyx68J2Pblvq95HVSn
 XHgAE7vM0rcV/HIQItCvWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89dewy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 15:30:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BDEQuRa020617; Fri, 13 Dec 2024 15:30:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctcn0pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 15:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYposyBH+00jdJ/IUMp67qsgdEpBLD9pj+0jb8+M4KdHO7AOBa2kTxj7aRdt3vRhNOIqjeOYJOcEIZxVALb7fqycyfIDaBrBGFl2+yHAhdVeaHuoFSTpqnuTG3PzYy3sjUbMKqIS/nUhEbXOm9G9rUH9RDkcpiXlfuwtmIWw5+wzasmCYHI37Zs3hZXOwX0yDKtm/MUR5Zbg9qRIpTlgGLB5zgV3V6Y9BcmehaqobfMay67/cJgttooJd/Ex3Az8vf2wbAmwIkLAXLegKRzTQJgvzOOElMW+tPgQQXH1MnYogm7MjWtocAGiESXSiCXNgagmf0H2L1L707OOIX1K3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xdvF7W9AljkB7YmSCx75SGij3Gvc+uNDFoEsv1NFts=;
 b=NC/yROYMetnpj0gFhxidgB8fgcH/8SwSD8nUr3cjqqJCtekE8b9jjGqVIV/mxgxrISSKFxT0IRddzvDne6mjgRdjZ7MTlWvhMjK1I9xj9aGRiNxSO4vrsXAKsLpz3QJSKi6fkzuO6UXFf5XpKU6CJiB15zm8jWc3BIY8DzirDLlFJe6ScKFcDzFVIQjxCqNXTq6vKIuhRklMlHGBoDgGD/QGXYUZ+P/DXuxpA8VfNWwsRJxk5FN2gF+1T60B4L6ttgWtqG7ebcC+MPxIhoDmZMT46fdFcZbDXJarQjrNpKcsOGoTvZ0OSK2i22wmsvDVNI1knbNseZ3HTmfpjt/dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xdvF7W9AljkB7YmSCx75SGij3Gvc+uNDFoEsv1NFts=;
 b=MkahZ6orZkN3T8t/1pBQnPYjJGbckqMMhzQtirm15afc/0bWKNcBDUEHSPIEWLRP4HO495VoYSE6w58Sch/ZushhVpbuEVjSX5hlLd2M7hZdys+7b2lNEgV6JruhwCal52Y9QOek/Q2fSRSzuOiQjfTZUX3yakEYNALAX5QzWTU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:30:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:30:21 +0000
Message-ID: <58935fbe-bb53-457d-b4d6-70c1d7b09e8c@oracle.com>
Date: Fri, 13 Dec 2024 10:30:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n> <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
 <Z1toIxDzI56ODYcC@x1n> <Z1xREcVCi-hn4BlW@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z1xREcVCi-hn4BlW@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0777.namprd03.prod.outlook.com
 (2603:10b6:408:13a::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dc2827-bb17-4d05-6ff9-08dd1b8b0e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFMzUXNaZmlQWm9FZHkxZEREdmtIUURlcUxHdGcrb093NFg4c2NTOUtZT3dC?=
 =?utf-8?B?akhhSm9VVElwZEJ6Qk9FUFhMWVEzL0psU3FlSTdQWUlxd1RlQ2JrNFlqVVdt?=
 =?utf-8?B?ZFpyZ1JpbldIZU5Za1RPbDdNM3hIeUNYUnJVYUkzKzRQMkNLaDFxTVVHQWdj?=
 =?utf-8?B?b0E2NGF1cDhaVVh2cyszdjZ3SGtkTXhNUUdVSmZRTGpoNFUzWXR1Vm5kd0xi?=
 =?utf-8?B?VTJ0ekZjMXBZdmJPTFlYMmVndlpEeE9rTW9kM0tOZmhhRndNYjRtYWRwQ3Bp?=
 =?utf-8?B?K3UveW5UWkt2RDZzL2treXp6a3g2aGJkckZpbzYzRFZYWk9haWhORzJUN1Rq?=
 =?utf-8?B?WTBLRW11NjVsY0NJaEdGS2dnVkJPZk1ic09xZWJuWUFlaGgvTEE2SHFYckM0?=
 =?utf-8?B?SThDek9mK0dXQW9QUHlEREJaRy9YY1lWNk1XanFXNW82cHQvU2JpbitZdktm?=
 =?utf-8?B?YWhwbERVZHNlNENKWVhoR1Uvb09wZHlOZmMybzN0Si93ZWhoZ3lPcCtXczlO?=
 =?utf-8?B?bG11R2R5K1NDNHBtZnVMTzlkYldTNzhVMHJRYjNWaWR0ajJDbUdNMmF2N1lo?=
 =?utf-8?B?MXdKcmtnbUV6MnNmQ2hMTFVhZzRVd0d3bE5qZ3p6eFREVjM2YUltRjdZWU5U?=
 =?utf-8?B?bndpZUV6andLTXEwYmV2YTJ0QlcrRnlxYld1VzYrSm9FQXpRT3BuMTdhcVM4?=
 =?utf-8?B?MjJtZlZ4T1pYVk45b1pITS9CTFo1L2hsQ0lSYnlYRkpjU3NJWEtnS2YwSUNv?=
 =?utf-8?B?TEdRbDU0NUZNN1VESnFJZFFlQkUwR3VMcEtOWmZsWlhYaGt0S3ZBMkoxY21X?=
 =?utf-8?B?d3AvclFxN3ZyZ2ljQktrOHd6dGIzS1BZVVVHRStGcmxHcEw5ODdqcmowV1lo?=
 =?utf-8?B?QzVUcUxWaWZUZTg3REJnYXkycXJ3MWRNbVBrTEM1OHFIUlE5Rkl6bng1SjFi?=
 =?utf-8?B?K3hFQXRRcFB2OFFJMXZKWUxWaG1ySDRYd3VrZ2RxamhIQUlRNmVuV04rTlZQ?=
 =?utf-8?B?VXhpSUNuTkdtR0FwbTFyTldZcHVUWDNKZ2x6N2RJQTdXcTYydTV6Ukl0Qk8y?=
 =?utf-8?B?eFZSekVablQ4VllRbjF1VW5wOSszSWtnWGk3eEgzNEZzVEN2ZlYzelQrNVJE?=
 =?utf-8?B?RTVBR1Z4MU9sWmFjRjFidEdjbXVnRmJRV0VBTXQveTQ4TmNERVg2YndkQ3U5?=
 =?utf-8?B?R0pJMUMrY0hOOU9rV3ZhRzZTZVdxbENFYkpHMjFhTnhudGtXU0NIcDJIZ0dh?=
 =?utf-8?B?eHEva2prTFc3ZTlIV1AvQzFzWjNlTjUvL2Fyd21ZVzV6TXhaYytLR1puZU0r?=
 =?utf-8?B?QXB5S21nVkllT2Q3MXhkQTlDTG8yT1BZaFNZUTFmNEMwc1FUbHJFMFh3OU43?=
 =?utf-8?B?dWlyNVJjWVhLZTQ2NjljaEM0dDhGZEdPS1NKTk43ZWh3Ny9FczZWSWUrd1do?=
 =?utf-8?B?MUNtN2ZDeHFJYTFUd095c21FeEFRSWVGd0dpUVVGelVzUzVrSWptZk5yQ2Ni?=
 =?utf-8?B?WHJwWDRrVmtxOWJENXFLY05HamZjd2tCMEhJS1ljZGlWQWpGSmxoQXNzTWph?=
 =?utf-8?B?T1dmbmczVllVUytrUDNqdGZlN1NON0FIYUxsVXJ2YS9yUFJYaURJMVNDZkJi?=
 =?utf-8?B?WklJNWR6NjJXejhaUkFHaUlyaXRxWDVsL1BiTjhtQ0ZZSEZaWXpqMlJ5cndr?=
 =?utf-8?B?SWwrb3lzZjM4eHc0VFh0enRiY2diTnpZN3lBSzVQTVRTR0w4N21HUmhwRExk?=
 =?utf-8?B?eU9UZHc2UlRYaUxwTnF6czRvOUtsSU02UU8xVExnOGdWeWsyZmxqQ01KbXFX?=
 =?utf-8?Q?NX3ARLlw9gReqg5kJi2LGxbMHJXpW3eg4lMWs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpGVE5lUXRuRzJZTDRSUGdKdVJNOElQMk5pK3hGcndQVDFqRkNPaTBKVFNl?=
 =?utf-8?B?cWJiMUlicTNBZklHSWRUcDJUcFNIN0I0QVJDZll4YVVjMEo5OVRVd1d5K2ky?=
 =?utf-8?B?cEZXakhVdkd2WEk2RkZ1amJGUWZ2Q3hlcXh2QUNvRENwR1lacG1JWCsrWmsy?=
 =?utf-8?B?dzlZZEY3aDVlYmgrSTZwQlloUGJkNURvb2ZmWThxT0lSckpSZEtQSkVKZFM4?=
 =?utf-8?B?SGNRYmtYVWpKTTE0YTBsMlUvTlk4V3lXRmZNeHNwNzR0RjBCWEx0em5JOTJS?=
 =?utf-8?B?Mml2dTc1L29jM2xXQzRDbWNTNmRhMGI2Q1dXMll5QnM5aWNUdmwrRlJmY010?=
 =?utf-8?B?WmNjZDhNaEVsSUdvbytoak1RYkFKVWZybHA1TGRnd1BCSWU3SHVXS3E2cTdP?=
 =?utf-8?B?ZGxJMW1tWGp6V3UxcWR4VGtKQ3MyYUJQVE9yUDRDQU1ocmZ3Wkl6dGR0Q25Y?=
 =?utf-8?B?ZUViMWsxczVETlBLZFIzZUtyRUFQdjNLaHViUWN0Y1E1cFU1ZEhTMkd1MFhX?=
 =?utf-8?B?T1pkVnRibHY5cGk2aWVpNUhjWkNIQVpvbjFpeWljb05mQnhuSFFqK0dYUWZR?=
 =?utf-8?B?ZmZVanNPVjgybk5rdXNmbjkzMDRjWXpkdVFpZ0dpR3RneWJib3ZEdDJoNlU4?=
 =?utf-8?B?SjZNRzRBbU1oN2hEdjBhZWd2Q0RNR1pzVE9VYjNZZjkrejlUTTI3VW5zU3BU?=
 =?utf-8?B?NVpnZ3prb3EvdmJMdnFJSFVLMHNmd2Vvb3ZOd3gyeGoweGIrVWpSekczbUND?=
 =?utf-8?B?RUhMTzdOc3A4MCtZanhGZUora09nTm56b1ZHUUZhNjNkRE5wK3V3c2tXWXd5?=
 =?utf-8?B?L1krT2FQcHBZTVVwQlVDajFyVldTdkM2VnlFQU1tWi9GRC9Ub1Zha2JGMXIz?=
 =?utf-8?B?THRhL0VTK3h2OUsyelFCU3JXbWtsK1hyZ1hYSFdDN2luRTNQM3FQTkdQWVJm?=
 =?utf-8?B?TFNFeFNoL09aSE0ySFBocVlhWlhaVXpGayt6YklxNGllZjJQTjAvL1ZsaFls?=
 =?utf-8?B?VVpITDZheTZ3d2FYSkRFVXc0OHVDSndGeFdtNDUra0RZeExmL2doZmx5ZzNH?=
 =?utf-8?B?MnZ0U1VZZUdjM0gvWHZrMVA2UEo5WER1VWMvWklZN0ZGT1lGbVRqZ3F4VUJH?=
 =?utf-8?B?SUFFL3BaKzYxUDlpV1VhYVhoWUo2L2lQZWpwWkxVR2hxcTRsZWZGMWdlcVZo?=
 =?utf-8?B?QWI1RVZ5VVdtU0tYSG81bjAwY1lxRXY2V2RQVkZmY2xVS1lUUUNjUml5eHhK?=
 =?utf-8?B?bSsxWG1oMnZDNmowZGpUei84OGZaYXpKQVJ0aWNBUVZuOVI2TVRsL3dNMytW?=
 =?utf-8?B?N0hKcUU0ZnBJTFVoYktJeGZTanBUdE9sa095N2R0ZTRjaHpvYm1ZVVpDeHZG?=
 =?utf-8?B?NnVSTURweDV4d0JtVStza1pXZU5sWEExbGw2UUN3Tit4aVZFZXU1T0pBWU1R?=
 =?utf-8?B?Wit3WEw5b1BVWU9zR01DRFpQM2pnZ1FYNmRYUGpTSG5ZM1pSVGNmMElKMko4?=
 =?utf-8?B?SVlHR0R6YWJpU0ZGM1k1QkJCd3d0WmZSbmFHOU44ZUtqR2twbEVLUnZrVWlH?=
 =?utf-8?B?M2lMY21JenNRcjQyTnF5aHNwZ09zVytOZUtLZk85VGxSVmdsNXRXc21wV0Nh?=
 =?utf-8?B?Z3A0dGN4ZXVZaXpPVHh2Z25mU0J0ZDNpRys1OE9FS3BxejE2QnQ2eWZjcFIw?=
 =?utf-8?B?aVVMMFFSQzBoOW5yb0dqWUM3RFNFN1d4ZXltNE9ldUJnSmNDSlJDck5uR0Vs?=
 =?utf-8?B?REZKMHdUYVVuK3JjS2ZUTUNGTFEvSTZIQUNXK3I2TjJqQ2xrMlVjcHBHbi83?=
 =?utf-8?B?SkhFRThZd2t2WEtrTnp4bDBqTVRlR1J4OHpHUGhnZ0lKWUpQT1dURXFlS201?=
 =?utf-8?B?Yzl6Z093KzlqcDdoMTc2SEFaOHJCcE43UkRGMWE4VjQ0cW5oQWU5MWZXbzk4?=
 =?utf-8?B?VXF6Rm9wSk1yWklZOEtBcGVwSU5lWHhjdytvUWlJckpEOVR5alB6NENQYzJY?=
 =?utf-8?B?ZDF2bVRkaEtUSitCcTNCZXlTc2hUank4S24yc1dQVzVFa0p1VlZmNXM3QUZQ?=
 =?utf-8?B?NUtsNmVtV09TQkpOM1hFRWFnb2dCVE10OFNoeFRHc2EvN05mSjEwckhkZUMy?=
 =?utf-8?B?djhEMzV5VXJuc0ZLSGErbTBmbjNrRW9OamVMbzZ1K3BHVmVZU0hOZHJXc2tU?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NAy/WGoX0UpvvFUZxQMCeq568VfOAwAu/lb92+TcIE9ZI24Fln9OaRmwGy0fu6TCpcOGhbp4E7K00OfpooofTTVj1ynQIex2ozuO7dE3VmBTZbEHSTqqVBSyuGSpySvn6fyuuV7t9g6ooIJwaUqt7V8UQTmaZsDBuaa79F3XvIoB+yZacwfEELpx+uqN4UVKm5AWz7BXhMBV05Fm90f0MIlLEwvhEClklw3TDrcbZgOcdsbXJUSfBrNCSmYO0VWyzq0JTXYcqXLCz0X2b4kCUa4+6Rni6pLO0ZCEyNj4CviU1cCdc85Izh85DYSFd6G8Ps1VCLElTajZ6An5K0Px++eAKeOTjTeb0eJAwHQcAkHu4HGSCyWPsnFuDibZ8jpQgMev8eSDor7la3xeNNr82Lo9lk0lYHY9Kh4WNx1P6aDohwkQX06mdfB56akETKk7S9UIBnSgjIBXKTBJxHCnuPzcN7aIe67FS8yxsh0/J4eKY+u9YHd0nVK7STsXW0CuuHQam1zF2WrLmiemesoL/dVJvEXykczuZeTVxKwEPBKEcGVkbfeyiNjyVq1l/yniHUV8Lngceb8B8aDujoiI/AjY5jhhdZhU0ItjJe5CupE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dc2827-bb17-4d05-6ff9-08dd1b8b0e9a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:30:21.7524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJuLMfuDaGY8/mha+4PmhEKcH4SEQObBD+SjAP4HNxuxW8wBRPoVTBWrqu/9A3puZRb6oJxWe6Qek58jXoyDv2/SC689+WY6o/1xt02Wf7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_06,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130110
X-Proofpoint-GUID: nNWdl1KRGQEmO29SguNydPFN_mMNwNBx
X-Proofpoint-ORIG-GUID: nNWdl1KRGQEmO29SguNydPFN_mMNwNBx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/13/2024 10:21 AM, Peter Xu wrote:
> On Thu, Dec 12, 2024 at 05:48:03PM -0500, Peter Xu wrote:
>> On Thu, Dec 12, 2024 at 03:38:14PM -0500, Steven Sistare wrote:
>>> On 12/9/2024 3:07 PM, Peter Xu wrote:
>>>> On Mon, Dec 02, 2024 at 05:19:58AM -0800, Steve Sistare wrote:
>>>>> Save the memfd for ramblocks in CPR state, along with a name that
>>>>> uniquely identifies it.  The block's idstr is not yet set, so it
>>>>> cannot be used for this purpose.  Find the saved memfd in new QEMU when
>>>>> creating a block.  If the block size is larger in new QEMU, extend the
>>>>> block using fallocate, and the extra space will be useable after a guest
>>>>> reset.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>    system/physmem.c | 36 ++++++++++++++++++++++++++++++++++--
>>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>>> index 0bcb2cc..aa095a3 100644
>>>>> --- a/system/physmem.c
>>>>> +++ b/system/physmem.c
>>>>> @@ -70,6 +70,7 @@
>>>>>    #include "qemu/pmem.h"
>>>>> +#include "migration/cpr.h"
>>>>>    #include "migration/vmstate.h"
>>>>>    #include "qemu/range.h"
>>>>> @@ -1661,6 +1662,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>>>        }
>>>>>    }
>>>>> +static char *cpr_name(RAMBlock *block)
>>>>> +{
>>>>> +    MemoryRegion *mr = block->mr;
>>>>> +    const char *mr_name = memory_region_name(mr);
>>>>> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
>>>>> +
>>>>> +    if (id) {
>>>>> +        return g_strdup_printf("%s/%s", id, mr_name);
>>>>> +    } else {
>>>>> +        return g_strdup(mr_name);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>    size_t qemu_ram_pagesize(RAMBlock *rb)
>>>>>    {
>>>>>        return rb->page_size;
>>>>> @@ -2080,8 +2094,18 @@ static bool qemu_ram_alloc_shared(RAMBlock *new_block, Error **errp)
>>>>>    {
>>>>>        size_t max_length = new_block->max_length;
>>>>>        MemoryRegion *mr = new_block->mr;
>>>>> -    const char *name = memory_region_name(mr);
>>>>> -    int fd;
>>>>> +    g_autofree char *name = cpr_name(new_block);
>>>>> +    int fd = cpr_find_fd(name, 0);
>>>>
>>>> If to use the proposed patch in the reply of patch 2, here this should be
>>>> able to be moved to qemu_ram_alloc_anonymous_fd(), IIUC.
>>>>
>>>>> +
>>>>> +    if (fd >= 0) {
>>>>> +        if (lseek(fd, 0, SEEK_END) < max_length && ftruncate(fd, max_length)) {
>>>>> +            error_setg_errno(errp, errno,
>>>>> +                             "cannot grow ram block %s fd %d to %ld bytes",
>>>>> +                             name, fd, max_length);
>>>>> +            goto err;
>>>>> +        }
>>>>
>>>> I remember we discussed something similar to this, do we need ftruncate()
>>>> at all?  I think not.
>>>>
>>>> This happens when booting QEMU, so I don't think it's relevant yet to what
>>>> size used in src, as this is dest.
>>>>
>>>> It starts to get relevant only when cpr migration starts on src, it sents
>>>> ramblocks at the beginning, then parse_ramblock() will properly resize any
>>>> ramblock to whatever size it should use.
>>>>
>>>> If the resize didn't happen it can only mean that used_length is correctly
>>>> matched on both sides.
>>>>
>>>> So I don't see why a special truncate() call is needed yet..
>>>
>>> You suggested truncate:
>>>
>>>    https://lore.kernel.org/qemu-devel/47d6d984-7002-4086-bb10-b191168f141f@oracle.com/
>>>
>>>    "So after such system reset, QEMU might start to see new ROM code loaded
>>>    here (not the one that got migrated anymore, which will only match the
>>>    version installed on src QEMU).  Here the problem is the new firmware can
>>>    be larger, so I _think_ we need to make sure max_length is not modified by
>>>    CPR to allow resizing happen here, while if we use truncate=true here it
>>>    should just work in all cases."
>>>
>>> ... but you suggested passing a truncate bool to the file_ram_alloc call after
>>> cpr_find_fd.  I could do that instead.  However, if qemu_ram_alloc_shared uses
>>> qemu_ram_alloc_from_fd instead of file_ram_alloc, per your suggestion in patch 2,
>>> then I will still call ftruncate here, because qemu_ram_alloc_from_fd  does not
>>> take a truncate argument.
>>
> 
> [begin]
> 
>> My memory was when reuse qemu_ram_alloc_from_fd() in that suggestion of
>> patch 2, it will only create zero-length fd (with fsize=0) and leave all
>> the rest to qemu_ram_alloc_from_fd(), then with that:
>>
>> qemu_ram_alloc_from_fd:
>>      new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>>                                       errp);
>>
>> So that'll always have truncate==!file_size==1. Then truncate will be done
>> at file_ram_alloc() later, iiuc.
>>
>>      if (truncate && ftruncate(fd, offset + memory)) {
>>          perror("ftruncate");
>>      }
>>
>> Would this work?
> 
> [end]
> 
> Please feel free to ignore [begin]->[end]..  I guess I didn't really answer
> it.
> 
> Now after I re-read the question.. considering that we have been very
> cautious on the fsize here:
> 
>      file_size = get_file_size(fd);
>      if (file_size > offset && file_size < (offset + size)) {
>          error_setg(errp, "backing store size 0x%" PRIx64
>                     " does not match 'size' option 0x" RAM_ADDR_FMT,
>                     file_size, size);
>          return NULL;
>      }
> 
> I suppose your change makes sense.  So please feel free to keep the
> truncation change.  I wished we could already auto-enlarge the file size
> there already instead of failing, but I think I see why we're over cautious
> on this - we want to still provide some safety in case some wrong file path
> passed over to QEMU, to not easily corrupt the file when that happens.  So
> we assume the file must be pre-truncated to say this is the right ram file.
> 
> Though if you wouldn't mind, I'd still request a comment explaining it,
> because it probably isn't obvious..
> 
> AFAICT it's only relevant to resizable RAM and also the fact that it'll be
> able to present now in fd-based ramblocks.  Maybe also mention the fact of
> our cautious on changing file sizes on fd-based, but not avoidable to do it
> here to make resizable work for firmwares.  Any form of comment would help.

Perhaps more to the point, for the incoming cpr memfd, the file size is not 0, so
the logic in qemu_ram_alloc_from_fd does not right-size it.   Calling ftruncate
prior does the right thing.

I will add comments.

> OTOH, below comments should still worth checking.
>>
>> Meanwhile, this whole ram resize discussion reminded me that to reuse
>> qemu_ram_alloc_from_fd(), we may also want to make sure to pass ->resized()
>> hook from qemu_ram_alloc_internal() to the fd helper too..  IOW, we may
>> want to keep qemu_ram_resize() invoke those hooks, even after switching to
>> fd-based for aux mems.
>>
>> Maybe the size / max_size also need to be passed over?  As for fd ramblock
>> it used to be always the same on used_length/max_length, but not anymore
>> when we switch aux mem to fd based.  Please feel free to double check..

Yes, I had already added the resize and size parameters to the helper function
prior to this email.

- Steve


