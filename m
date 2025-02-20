Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F080AC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8td-0000Zi-2T; Thu, 20 Feb 2025 10:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tl8tY-0000Vg-0X
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:55:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tl8tV-000511-Iz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:55:23 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMaE3021443;
 Thu, 20 Feb 2025 15:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=IfcKu8yLx/XHn4ehQMvnq5wqPKKohQdR9tQIuaDNbJg=; b=
 TSGaW9A2A1e1WK4dEvtleUXVWgcNG7BZM1f6Bw2uEEaVKbcJHPwD0nchMu4vbQ0r
 dKcDFefGrjnL2e8zRQENqlkGc/n0rBDhJUHDP6N+5lqoxan3rBaXoaLZC2NZZGzq
 sb8qclLbXba9EU3vHOxo4K9xMW5TbxMYIuSPU9OnLizVLJA5p0jmr4QOGEkPTbh2
 EMgHZrW2paZX0ks76bUcTyWmzLnUsb8lARldDKh9imIqqY5ccjxBgMazTlL3sB4h
 qrPx6wAXF5Eyp4cvU/CmYDg+uBNpU5qFPgfog8mAehc+NgyFkGF1+HqaZpyRJ8CL
 KVk7iwewcqKOvo1WPUBNWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00mvf2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 15:55:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51KF2MUt010501; Thu, 20 Feb 2025 15:55:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44w07f4eg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 15:55:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZC72gofSuLEa6wfmqpwQfClGkMt0FjGbPhyYdrgBiZLpPaWSB4LfL0ZnrQEvoFEc0IBCURlkTAv5z7GBKWjKPNYG67ppSjtn5QMUaEuxincDycEGcHgsWqlw/NSvuG6G5UKkypWz5Bofmjcq/Q15PUrD41mc1eRLWjReGh8CUhJxxV4p3/FKJlyrKA3XD8tVmoKG0oJJNQgIbNZwsdjJUvTgQ+kJAsSITu888dqYbshJmY/1/PIS+PLm1ygvV7AAe8fUu9x3LXWFdi5VIAnbb4vmrw8tKEYK6wIdlJX7cbW+A++b7Desnqejk1MVKKIKJOs/8q5O9nYxLyGbckM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfcKu8yLx/XHn4ehQMvnq5wqPKKohQdR9tQIuaDNbJg=;
 b=cqiWcFRzhmlBQx8d0aWLmzj9Axe7gJ5tOKakpYwaCkzMKsn6tCbPC/yqKxPY5LSDui1PlItS4rM27ifU0wI00lelentICOVgzdH/nviX+2g+mTANR9XQSsaw+fCIQELsYgjqYGzNOnMCWskOs87SVEcgk7gf7ri+3yN0eAg12VNPqsGpxaP7sxAqcybOepEbo7ty2pS0Ka98+EjgU5NGvWaM79Ftoepb/F3Sc58I+M6XdygPKBW5hR/NbvP+UPOc8yonWyat+rPG77a6YLUGKmEesVHzCcp48yX4CNi6JV5Aaq6XWy5QuRrBLLKk0U1LM1nIj0s9nIvLsteKT3mWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfcKu8yLx/XHn4ehQMvnq5wqPKKohQdR9tQIuaDNbJg=;
 b=A51wbQk+WhUXpuuiOEcC/oulkSPqcLS/JDYWrFH58QGA8okzUumPW3jln1s/reJUurcjVqAgjE63mtuNlUK1BJRNuib+dKS4uSkJutQnlB3BINCznd0evRTE6Rbg8jIScHQEyTaLJTOjPnvPg1D8MC99HDFwx3EwFsgzsWPeu0I=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 15:55:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 15:55:10 +0000
Message-ID: <75de7f2d-2cc6-4f89-87e5-b1676a3b00f8@oracle.com>
Date: Thu, 20 Feb 2025 10:55:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Don't leak memory in
 amdvi_update_iotlb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20240731170019.3590563-1-peter.maydell@linaro.org>
 <5a220564-313a-44e9-8ae9-a2faec14ebb5@linaro.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <5a220564-313a-44e9-8ae9-a2faec14ebb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0373.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c45cda1-d09e-4b6a-8f80-08dd51c6f493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUtXNXNzcklVUHdoM0h4ZWpiWnhiN0NWMnQ4N01mdUFjRGhNMHh6RmdQN0dh?=
 =?utf-8?B?dm1NcGJRR0dFb0w1OFJpaXdreUx0ZW1BQUVUSDNONVpkSnd2TWM1NzlvdFlr?=
 =?utf-8?B?N25xVG5KS3NuVmIvbEdxaCtlTHV6b2s3QndVcHlCVklHeWx4aUlCaFM0TEVF?=
 =?utf-8?B?dU9FTW5GYjNEeFhBck10WTc3dThvNkhKU0FZRS9SNElYQjgvdjhMK1V4dm5Y?=
 =?utf-8?B?bm5uRWttTkpKM1JIbWxNS0dNOTEvZFQrK24rV3ZuRnp1RG9KOGJnMmR1c282?=
 =?utf-8?B?UktmeXZGaDRNYVNKbFlzVVZObGRVL1pWVm95RitYZmtPL2xLVVBwbFRhMVV1?=
 =?utf-8?B?cHFjUk4yQm1tcjVQN0QvRElINGdGU2lWNVFJcjlhOHphaWE2Q3p1TWxRT2pR?=
 =?utf-8?B?WVNsTUVSUlZDanh2S0ovRUk2cUVUdDdoVjFIb0FzWFUvVlczNXVWbnZLNGVo?=
 =?utf-8?B?dEFVWWRIVDE2aTAwcnE3bXE4emVkcVhYK0NqcFpxdkoxdlh1eDJmeUNnR3Y4?=
 =?utf-8?B?Y0RXdjBNeG9FNHVxMm5lN0t4dC9HQTMxR013NHJOaHN4TXRMMUV5S21EaW9D?=
 =?utf-8?B?ak1EblNmU013ZzlHOXlJS01Kd2s5ZW9rNVBrSzVkT251OWtmQi93MHdJZzBy?=
 =?utf-8?B?WmI1TGpXckZiVVNJRFhSemg1Qk41SFUvaWRiMVFvMEJkVyt3ZlM3U29Tdm52?=
 =?utf-8?B?eks3TWJoNC80RzVNWjAzcGtYeDVJSXVpVSt5dWtYeTJ5Nm9nU0VUSmdCSGUx?=
 =?utf-8?B?TEREOGk3NDhDd3BneDN3VjRycHNaUFYwbk5OYjVpL3NwNS9ybDczYlM1UEk1?=
 =?utf-8?B?b2NHMjRRd3JYcHlyVUhXaituMGRoZzNKMnJhZkhaYTNDbGpxQTIrck8yRDhi?=
 =?utf-8?B?eTgxc2NLTGxGc2RYeGNtSG5KaENpM3g2UjJQbC8vNW95QldiU1BLNUFUejlW?=
 =?utf-8?B?UXhQdjlRVUtjNzNZMVJaMHNhVTlobDY4blZNSm4zTTlCOFhHOUs2TkhrQTJG?=
 =?utf-8?B?bjlPZnJKdjFvbWp1ZW1aSzdaeTREYUVNNzE5WnA4NUE5N2tEcTJaNUdkZHFs?=
 =?utf-8?B?ZjV6YXBLM3ZwWVVmdElwZzZCZVNzQStHTjBGOSsxRnBLK0dSczIwcVZqTm1p?=
 =?utf-8?B?YnBJbTd4VE4wdytDMnY1ek9QYW5FTmd2RDEzcVFoaWJ0eHd6a1dyZTl5S1lQ?=
 =?utf-8?B?YWIvZ29VUDQwQlU0WW9LVG5rZlRtY2ljSGtJZDFMaU1hV3BucU9RZVJrVVhB?=
 =?utf-8?B?ZGdvUVlKaXV6YzZUaThUeUJJS2NJQUo3WGduODV5b096WnhUTW5CQlJCbzYv?=
 =?utf-8?B?TG95UktoMzRwcUFYQndPQjNrN2lzeVFMYTF1UDU1QkVROUx2ZHBiOGtMclNU?=
 =?utf-8?B?ZHkxUUllNzB5c0N2NFhhTG1ldTh4T1g4akM0MjZCKzRnZ3M3Z1U2UkQ5ZmRn?=
 =?utf-8?B?Z1htL2RDQ0lwMGlBSEYwbEJvZ25raVlyVERkOTVIL3RFVm1aRjNtb2Q0OFVh?=
 =?utf-8?B?VjdJN25YYi80TThGMzB3dnRnZ0JrOGZUTFJyQkpFc2x6U2ZtR2JvbVlYOG9H?=
 =?utf-8?B?R1ZJWDJra2F3WUJpQXlDc21mN0JJTG8rbXQ4S3d2YklKTFUvWHBFb0k0M3N4?=
 =?utf-8?B?Yy8xZHJGV3J5Wko0Rk9VTy9FTFVaNjFHTHd3cFMyN1g1dlBjSTBEa1ZBZGZo?=
 =?utf-8?B?YUhUZ0ExdXhvRnhvRkxGaFFrdk9GV2NjNmthMHFMTnJMU2pwcE5rUElKckN5?=
 =?utf-8?B?NFBXK1lTMkhGNFI4bEcxR0IwWFd1NFlPZlM3b2dUVDRNL2JTN0kva3VPbGdQ?=
 =?utf-8?B?K3VPdUlwTU8xVllmYjh6ZTBHN2c2bHJhQ2tpak9NZTB1Z0x4NjkvSjE0T3VC?=
 =?utf-8?B?OG16R0hDNmY4amwyRUxwZjk3TGsvMXJnVkRZMmIxTjF3YlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5267.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZTQ2lJZUZKdnRlUGRVcEo4WEFscWkvZFN5Ykp3Q3FRWHVqNXdVMGNZODI1?=
 =?utf-8?B?dXdjWjEwWm1SWXNqalR4WUNhUEdSY2RIS0NuTEZKOSt5SzNCanQzeG1uOFl2?=
 =?utf-8?B?NW5pMHpSdjNueDZzdGhIWVlGcW5waEtxbXpFZWRjTmVPekhmdlVtS2RSMzMw?=
 =?utf-8?B?dmFadElDS1ZHaVUxRFB4SVlQZVQwRTBXZU1aN0gzUklLbzREOE1UcFg2VU44?=
 =?utf-8?B?aXZMMFZvQ0N5a20rTHFMSWlJaDRiYlBrd01la2NxVWNqOU00OXowMk42OVhJ?=
 =?utf-8?B?eW93MFRseHMxZDE3R3lDczJjRnRMNGVuRHNoVlU4dE4vV1A1QzZtMEJVNUVv?=
 =?utf-8?B?TzJkRHhGbFdLelRVWWU5N0h6WVZ4cS9YdnBNSCswSit4a1oyMmE0b0gwVWU1?=
 =?utf-8?B?SjQ3a01QcWdsV3daWUxxMG9nUzZXcklNT05uMlJ6K0Uxd2xkWWlVeE5yaFFJ?=
 =?utf-8?B?bFdrVjlBb2F6OWpKT0hYZjhmMTZXOXJsa0t5MU1qTFhqdHp3cmpHYU1wOUQ0?=
 =?utf-8?B?cVVqUi9URXJpTUNXMUI0VjFmcmgvV2FPTVRnT3Qyek5meDl6bnlpN3kvTnVD?=
 =?utf-8?B?cHN5NFVieTg5cmRhSGJSeHNiOG9hTFdsb2xnek82dWFBMmVRVUNSVEFsbnBr?=
 =?utf-8?B?clAxdmxWRURpdTJFVWEyRUhNQytMUDNTOUI2dTMxdzM4S0dnWFpxbHBhVFRr?=
 =?utf-8?B?WWEvRW9JTG82dUpWYlZvRVc2SGRQWWM5cG9wckZ5d0l1Yk8wRjhLWFJPSXJh?=
 =?utf-8?B?ZHpVelFkd051ekk3azdTS3NsbVV5emlPR282K1AwZ0tPTmZpblExNzh0ejNy?=
 =?utf-8?B?Wk96TzMxZHE0cTl5TTRHTG81SnlHNHVMMkY1N3hUTG10MjRwbW11a0o4bUVV?=
 =?utf-8?B?QjJvZFo0NHBjMUpEcUIyS3NhUzZXSkJldm93b2ZjOU45eFkvYXRKRGY2aTdl?=
 =?utf-8?B?MmdMWU9EUHdKdFE2UUdDUU1iT2JDVGFCa1BRZFlNVTAzaVJ5TUsrdXdJc05x?=
 =?utf-8?B?M2Z5TXFnSFFhNWoxYlExMkFzSDZXTGFQaEhpT1FibTI2OGNldHVXdU1qak9O?=
 =?utf-8?B?aFg2OUppNnMrajBrekNEZitUM0ZvNGcvdnpKN09LZkJwTUl4bW0veDlrN2g0?=
 =?utf-8?B?c0hFNHlkM0NFK1VwQVhPbUhhYW45Q3NDcmF6RnZ2YnN6QnpYQitvcGxVWHQz?=
 =?utf-8?B?OGk4M0lWdkVESXBoNmJkMzc3SzBLbzY1SFhEV05DcEVnMzN0NWdqRzcxazh4?=
 =?utf-8?B?cVdCam5RK0duK1JWKy90bnp1a3dJeVQxOFVidkxZc3Y3aGppZ0p1eFJmN2F4?=
 =?utf-8?B?Z1BBMi9senFNTUMrSDc2bVlRMXljM05EeDNwV1RNSDBGVjFNRUtUcW5EemxM?=
 =?utf-8?B?dEZKVVdubUJTS0RINXpQTkJjTFRYMk9zQjBHUE1DT3ZrdndJVVhTR3JtZktj?=
 =?utf-8?B?djVFODZnR0RseGhRMGZTVG5Xam9sY2hldHhGWlRUN3dDWjVZZ0VTaXhRQnE1?=
 =?utf-8?B?S0IzNDI5N293allNdG85MmJqVnZKNi93NUxlcW1oR2Fkd3VjZTd3WnRyUjA3?=
 =?utf-8?B?VDM5NHhYRi9xZWs5V2VnbG94ZFF1V1VIZnh6ZmhObHNoZ2lBc2ttVVVweHRQ?=
 =?utf-8?B?UWFpOUs4QUliVHFENnl2TGdzczdFdjhKQ2JqZHV1ZEx6V2tBbmdyU0xZdDdE?=
 =?utf-8?B?dm8vb09DL3VHaGFLVkg0SzNrL2RIL3V6alJoaTNPZjZHN2o3N1h3WktNVnMv?=
 =?utf-8?B?ZFkySU00YnRqNDJFc0Z6d3gvTVV4MkVRa0J6eXhUUDZjSTJsYmtOdnZlVURB?=
 =?utf-8?B?OE9hdndCVlFpMmNQUGdrSnkrZE5WYjg1UGdVUjRtZ3NocXg0Z25jT3ZMMFAw?=
 =?utf-8?B?NmRKMkxvSThINFZIUklYT3l0MXRTRmtoOWR5ZmthbXVXSHZWZG44NHFPUWxr?=
 =?utf-8?B?TGsrTXVkbWNPY1FmSkN4cU1vbmtkSyt0UXJNOXd2MG5iSnd1QjFpMkpiNzFm?=
 =?utf-8?B?UmhiK2ZhRStvVHAwSlBxeXY3QjBrdlU2Mm1mZmdjaU5MTk11eFNpYUNwNjgz?=
 =?utf-8?B?M2FtWjZPaTZjSjkxSm9rTTN1MTJ6OCtkSWYwWFF2T0gvbllCb25uNklPeE1X?=
 =?utf-8?B?d1crMGsxSTlqclViOEsrNlFGNFAyaEEzYVRuYjRnUjM3bFpvNS9rcEhSQk5B?=
 =?utf-8?Q?DcxbMFyOiwWu4IcuPtZ2o8k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rMS9Sg0Oz8oBaJPpKL+CxDPTDSwxamw3dz90Z8Yd8b7HB66tjB3fFAARoVYvQfVyAt8csBnvwiowLv6r91Nl8Eu1zFmrmc/ML5RK4En+GOqqXX5wqQAwb4TNQ9xeMWQm8LO3hyUAlnWGQ9JhnySF342U1dWqdRrwHOV8ICm15LeDW079EvhNFSXeaGITh9YStpUhUVWPdnF4BWi84HU3rCzjTSL7E9iy8dy1ELjd9O+K5ITO/r6NKiOVG5l3LXiYLXcbZbjQrI/ArHqCVjSxRSvCSZua7PiRjVxyglZZrXUgiops9eW4/64MRCZePM+1v8Ev9US84Wv5bBS34Sppxw2E6DMsDTEJUhe34gebAZ6EWj1NTaP19qGzLqJQp18wIQAdsoX8ciMF+lP76k/vqWiHxK6Vi7nfXkPDwtmo54sdw1Ju9G8PGlU6yj6bfByIGWn7ZH7I570XS08FLJN1iwkaFI54RQyUz5ADPgDRL5YKk1Z6Wvb74Xvxl8DoyveDz2AUdQTuvwk3HXkN2kjZ06sjqiMX5zBifWT1tSsPIOAsWpxw0SX1oFKysjBHmhXBMtv2d2iK7u6z4W0ZidssLHhsNud925lzNtb4gVBvXLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c45cda1-d09e-4b6a-8f80-08dd51c6f493
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:55:10.6814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RU6Q/pzGsOUwGxgPmn4KGFOxOY50de3ze5V7hLBgzfRN8bH24FtnsyAsVeH88Ou2PIgUkRUWvnrsQctHz1B+700Ui4OwwO1cG+yjliD/zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200113
X-Proofpoint-ORIG-GUID: q4SRixmrXn8j-PR6_xxhUqIzZuX1C16M
X-Proofpoint-GUID: q4SRixmrXn8j-PR6_xxhUqIzZuX1C16M
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+ Suravee

On 2/17/25 02:26, Philippe Mathieu-Daudé wrote:
> On 31/7/24 19:00, Peter Maydell wrote:
>> In amdvi_update_iotlb() we will only put a new entry in the hash
>> table if to_cache.perm is not IOMMU_NONE.  However we allocate the
>> memory for the new AMDVIIOTLBEntry and for the hash table key
>> regardless.  This means that in the IOMMU_NONE case we will leak the
>> memory we alloacted.
>>
>> Move the allocations into the if() to the point where we know we're
>> going to add the item to the hash table.
>>
>> Cc: qemu-stable@nongnu.org
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2452
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Tested with 'make check' and 'make check-avocado' only, but the
>> bug and fix seem straightforward...
> 
> Oh now I remembered:
> https://lore.kernel.org/qemu-devel/CACGkMEtjmpX8G9HYZ0r3n5ErhAENKhQ81f4ocfCYrh=XoF=5hw@mail.gmail.com/

Re: AMD vIOMMU status, this recent series:

https://lore.kernel.org/all/20240927172913.121477-1-santosh.shukla@amd.com/

added support for using it with VFIO and the guest in passthrough mode.

I'm currently working on adding support for DMA remapping, and have a basic prototype that boots a guest with a VFIO assigned device and iommu.passthrough=0, which exercises the change in this patch.

I am using the fixes and optimizations that have gone into the VTD emulation code as a template to bring the AMDVi DMA remap up to a functional state. I'll send an RFC soon once I have fixed a remaining issue with the prototype.

Thank you,
Alejandro

> 
>> ---
>>   hw/i386/amd_iommu.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 6d4fde72f9b..87643d28917 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -357,12 +357,12 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>>                                  uint64_t gpa, IOMMUTLBEntry to_cache,
>>                                  uint16_t domid)
>>   {
>> -    AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
>> -    uint64_t *key = g_new(uint64_t, 1);
>> -    uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
>> -
>>       /* don't cache erroneous translations */
>>       if (to_cache.perm != IOMMU_NONE) {
>> +        AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
>> +        uint64_t *key = g_new(uint64_t, 1);
>> +        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
>> +
>>           trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>>                   PCI_FUNC(devid), gpa, to_cache.translated_addr);
> 
> 


