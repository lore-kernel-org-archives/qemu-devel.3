Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE56C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rpj-00083j-KE; Tue, 29 Apr 2025 16:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9rpg-00082e-TQ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:45:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u9rpe-0008P6-Sr
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:45:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TJHDTU015518;
 Tue, 29 Apr 2025 20:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Wl5L2+eFw+3qDK9Q+HsOmUVmtweQQwOt8qWdoTq2HMw=; b=
 acbZ9P2DhuefO+E3xX0roOt+xOZ4daalgt/QI4Fi3oUdtQzHIlERs3M15TXvZOXF
 pzgErm4UO25Rhu30l80bwVB3yd+E+7gQCzXC+eWvB48kkhquET2/7fricUH+7/mp
 MwHDM9sy8cyJwrH6aP/gvOou2mImeqZ2GUWgBwAZXxTf00YwBHGpsjfsRz5pUEmc
 SBA9Q65EXr8sPwMsHxQRv4lTfZHRBAArwgYIOJ4Ik22JRVM/oqP1WNn6gBqxXKq2
 oOXAuRZxs0bHrK8FMywJKUQchCyGHzTEddDLW0rnEZIG5J/IOzvvU7hFHD7Gknk3
 PvRhTvJxxThYFPavei+Jtg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b4spr5ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 20:45:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53TJ4d9h011359; Tue, 29 Apr 2025 20:45:21 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012011.outbound.protection.outlook.com
 [40.93.14.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxaxgkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 20:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWH+L9Ee1QCnQhLvP3WrWrwOTna9cze4aYcEBcGvaLQ35LULdcdQ+QYhpFnFqSJEeo/yfGm8yxsHl8XNPqI8c7DNGyPWMw6weZhgNIz5HUzsLSFLgSHYJMy4hX4/oJ0ywqP3TEuKwm/8X4BmGJnPYVWZ8+iksDReFmbRt1QJTKGKpJVyxZHopwWJf7VWpGMcVOVd0Nn01XmnJ4T/vV4optod0h/P1i11L7t+jAFjFd4muOX5TS0WrVWF8lSmzniD5haUSPMq+hh1AvLGLWWTU3ZhFmpqaNtn8XHO8qFNLvwa38RZHdMfj7g1WlFNDjQ+51xf0ojAfM2pjCK9yyGrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl5L2+eFw+3qDK9Q+HsOmUVmtweQQwOt8qWdoTq2HMw=;
 b=vdXv0nZFuRbBd4P10N+koxDa5xafbcF4WAFq9Iftp2MNJPaWsAkwLTudcVZXmb3GGKhME/RAXKA83akmAqsVX5wUj4Gv15Z/ehmiE+nzFCjUGfzdL88Iz9X5fBIMgTakODXoWXB6p0lOAgoeJPQLS4TJ6at7oqNF2SxdbuXT+Epy/yQ4JhU4YV+bt1B9rZHF5wSltDcbbULgWfYQl0JtYb3JoHSyu0vN3EIDWlK5Aix/Aaa8BWBNv7xmXEtt1nxp/eEj7eUF1pDQCm+gW0O+gr7Tk/Fe9b1BHWu9BEOv2jmQ54ub64gJc5EJyi6PhCJuk8snrL6vpA1AdauK2W6nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl5L2+eFw+3qDK9Q+HsOmUVmtweQQwOt8qWdoTq2HMw=;
 b=lQ3wBNzPANkfrKSujfdJiLGaKf8d4aNSlgssGX7Mos/11dwUHXv6IqdXj0aAjt6rhheWmKkTdOQ/XLzLfoFZBqMg0ONUTnyeoQRAV8mH8sSpnXeitALe29IUWJKjnrMzAqv2Q8JRyiIi06QDZHt0e2JbT0SI6JDdfW3UhxVGziA=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS0PR10MB7052.namprd10.prod.outlook.com (2603:10b6:8:14c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Tue, 29 Apr 2025 20:45:19 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 20:45:19 +0000
Message-ID: <db4c09ab-45ab-4d9d-a680-e4912fc73f65@oracle.com>
Date: Tue, 29 Apr 2025 16:45:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] amd_iommu: Toggle address translation on device
 table entry invalidation
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-15-alejandro.j.jimenez@oracle.com>
 <ead40e48-868a-4ee6-a23e-ee11e1047880@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <ead40e48-868a-4ee6-a23e-ee11e1047880@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:208:23d::8) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 9918e419-39c6-4522-6bde-08dd875ec0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TktsZVpLck1rblRSSHlZcWlmMkhDZWFQMndZSm9UZ29WWHU1S0laSHlQNUtB?=
 =?utf-8?B?TXNtSE9LU2RraVlxaE8rVHM1NDdpemJqL0FDL2xnVzBBaWRqcjJVNEFBcWx2?=
 =?utf-8?B?Nzd4dmZrWTZJaDdYZVNjdEg5Q2pyckJmTk9ZL3F0dk9iQzc3SXppb1o5Uk8r?=
 =?utf-8?B?bzNYM0grc1lqYVFoMmRNRWRpUkw0bEFhVFZBYUtWRmlicm4yUGNURjJPSE1T?=
 =?utf-8?B?ZVBnelk1blRFSFp4KzluaWo0YUVDMzFGZUdLcHRYeGZFMkhFdzk0cW1IZjBr?=
 =?utf-8?B?SDFKd1lsWjkvb0NUN2lPVzRrMU1mZzhULzVLYnZ4SUk5TXcwQWY3WHBMR0Jy?=
 =?utf-8?B?bVhvN0Z2a05meGVvbFRjbEVpeEEvWjEyOXBWUjY5RTlBYjQ4UFp5OTNwdUxr?=
 =?utf-8?B?U2owR2RnTU5zK2I3R2FSSjhGL0JiR1lMWldQZlpscEI3RHZ2OGREcy9ZV2pp?=
 =?utf-8?B?TVBXR3ZLR3FCYmVDTUtsUlc3Q3gra1RhMm9JNVlnaEloczdVNjJXR0FpQ0RE?=
 =?utf-8?B?QVIzR21vQWNXbjdHOFF4bXBVdnR4WVptYTZqMVp5cEdFdnBhRXVySHdNa05w?=
 =?utf-8?B?bUJ2UjV5YWZSQ3lFcHFCNXBqZ01PNWIxSjRvT0Z5UlhaajhoWGNsSFVvT3Ux?=
 =?utf-8?B?RTE2T2pMMmYrN09XQllwV3lZenNrVnE1RmVkNGlVbmlBUng4MExLemJGK29z?=
 =?utf-8?B?SHI0Q3k3WnBMd0M4VC9nUW9lSCt3QVU1OFhUd2k0b3QySk9xWTBKUzQ3RGhK?=
 =?utf-8?B?aGFzZWpKMzhqbFlEVHBjazRNNDVwbjdnZG5YOVhmOU0vRktaaTdUay94ZzVn?=
 =?utf-8?B?NzdrM3d2V0lwQ1JWcTM3ZzlpMTJzWFlFbXJaK2NGNVNITWxEUzlnVUU2bXo4?=
 =?utf-8?B?bkxaV1NER2ovUldZT1VjR0NpemhFU29ZeEhsREJoUG5wYzlTWWlPdkFsMTNZ?=
 =?utf-8?B?N1IrYjlKbnI2VnlES3FIeGlaRW4reEo2TmRYdFJpM1BiWlJSTDh2NEk2UzhT?=
 =?utf-8?B?OXoxMnpzaXFwWkJJWE9HdnpKYXRvOHdhMkhDZUZGbnhFNit1T2FHemR5K0kv?=
 =?utf-8?B?bm1UN0d2U3ExN3RhME9FVU9qeEh0ZGc4c1g5dnhQNnYyNklSbkpTajhUSkNv?=
 =?utf-8?B?QWNqZlBKbVpKWm9nOTBSN2ZCbEh2MFYySHlkSTd4Y09MeHNOVXY2K09QNjRx?=
 =?utf-8?B?QVpWVEhuS3p6UU02US9uTmVTMDg0QVU3MHVzZ29lUUkwdXQ1dHNGTWttNnVl?=
 =?utf-8?B?SkJzaDU2NkZUU016bVNJR1UxaTdxSjJoQXRKaFBuOU8vbGdnRFFRdFMyd3VH?=
 =?utf-8?B?aG9IYllNTXI2UVJCTy9hbmUzM0xSdG1sRGpjdkx6UWxvNENLZEFndm9maEk1?=
 =?utf-8?B?OWx6cDZTUlFoYzd5ZWZsdEcvQmJ3TnROQklKY0VyNE9uQ2k2Y1lnOE4wZm1i?=
 =?utf-8?B?YjFYR0lPZnV1L1hML3lGRkp3M21tZEpianBVR1hhNE5hNGZpeXdWdlFMY3hI?=
 =?utf-8?B?RHJJZDlsSkEvMU9VcDVaRDJaVDR3Uzlma1VQaHdGd3pxZGQzWDBaSkJ1NnJB?=
 =?utf-8?B?ZERLblNUd1JIV0RldkdjQ2JoM1ZvSUl6VC9wTnN5M3F2YmsxWTF1czNHdjQ3?=
 =?utf-8?B?ZzY4Y2xPYVZ1enpLcTBhNm5lSFp5MDVxQUVsT1ZDVTh0L2dxV3NpMVVsRW4r?=
 =?utf-8?B?dURuL0RLOTJkeEtDQjVWL2wwV0xqZUg3aE1WT2ZLQ1NyVnZUVkZlc0FwV2E4?=
 =?utf-8?B?bG41VU1YbnNUcXNnN0JLK2ZHYjZSNUZUeElFVkVySDVnQWxQdHhKUlJ6MVpC?=
 =?utf-8?B?eUdYM2VSQ0ZVY2JiT1FSYVZmM3lybS9raDBmU2FZTGM2cnJjaXNqb1hFYWkr?=
 =?utf-8?B?SmxCMWM5SzArUFBDQ2NSaldjaTJhK09oNkpCNUMxTk5NYlA2VjRZeHRML2ov?=
 =?utf-8?Q?cVeSwRiawsQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFranRVbk9wWitpV2FjZWNEcWFaSys2dFd1d1ZkMUU0T3RjYlFlOUlFSjBx?=
 =?utf-8?B?VjFWQXdvRThQbXVWOE0vNnJRSng1MG94NEQweGV3NWJmR3NicEhyVEpWSWhG?=
 =?utf-8?B?S2lpNHZRQWVtVVM3TGtjQnBZVTJ6WFMzanBxL0dZK09xMGIzSVdKbkNWU3pU?=
 =?utf-8?B?ZUgzdEtraFZ5aklxdm5mZlM5S2Z0aFQwQVJocDFWOE9aQ2JobjUxd3JqcnVO?=
 =?utf-8?B?VnVYbjR5YW8rL253cVZmbG5ZNzk0aFJzRzM4QnFpY3FRbk9CTHZwLy9PemFa?=
 =?utf-8?B?TDNYY2lqejA4K1hoUUs4MTVJeVlvZTcxdWxTRmJvdXlHZnNkVDF0S2Y3bGVS?=
 =?utf-8?B?dm42TkFzaHZLSU9WcVNCZWhWYWZUbnFNRHcvWmpMWGJYWVZNMFRKMkROZ3ls?=
 =?utf-8?B?WmNMaGxqM25DelNZTFBaWU1Nc1ljTUxZcU90ZlYxS0l4UW9EeDFNU1doNGIw?=
 =?utf-8?B?cHo2d05GdE9sTHVqaFJtVURJWVFISGswMFB2cGViQ0hDWVVkZzNHNlJ2QzhD?=
 =?utf-8?B?cFkrV0JacVpiUzFCbjFVdVpzcHFsWG9TM2pyUXVNWUc1ZW8zak1CRWYxWm5m?=
 =?utf-8?B?UXdXaTcyb2NNaGhmUGxJMjFRa0lDQVdRc2ZzT2hxemtyVmh1T3FLTTliS3N1?=
 =?utf-8?B?WkJER1o3K21Tdng1MGQzWVFHUXBJZTVlMy9nbUY2WkVORFZ4UEc3bjNmN0Zz?=
 =?utf-8?B?WUozMzc3aXFqUmJJMDcwQy9YTk15MzdBa1Y0bjd5Z1gydlNtVU9kSE45VVNq?=
 =?utf-8?B?MVpZcWJmVXE4UXI5TG5OaFFJU3RDOXU5QTBoSlJMWkN2b2NEK0o4dVhaYkZp?=
 =?utf-8?B?VEplalZ4QnFLSDBDS2lIYWlSWTFiRVNKemtwL3lJL00rUFFTVncrQnBycU5N?=
 =?utf-8?B?WVRITmlVNUt1SFB0K29rMmZETmM3aXczTyt0QnFWOWxTYUZGWUJrOXA0cHY1?=
 =?utf-8?B?M2RMRXRIMzJGQ3ZXWnZNcTBGWlhlSmN3MEt3ajJrZWZYejNqRnVCMlYzU1Ry?=
 =?utf-8?B?b0JDRnNacVlmVlpXdTRXMHdKa3VFQ3AxL0tER1VNY0RCREYrNUtXdzJwbXh6?=
 =?utf-8?B?Sk5hblYxbzRaQkc3NCtneUVNTTBDTlA3MEhEUlhIWC9ydW5vcDh6anMzUm0y?=
 =?utf-8?B?VlM3Wjc2eXFmak9zdHRiNDg4aUM0REJ4YzFIazYrbU8zTWsxNzlra01tTFpT?=
 =?utf-8?B?Q29xMmRRRE5QSkp1NGQ2Zmt0WU1xWDgzMnVuQmhVa2RzdFR6dGtkTm5IMGV2?=
 =?utf-8?B?d3hLcExnOEM4ZUx6bnYrcENHTldQb1JhTnIyMWpybXA3UllvYUJkdndCT2RZ?=
 =?utf-8?B?dHFTZllsRnFvOWhzdkNSaGxtbmx6Z0dQREUxOU9QaHZ6RTZRYU5CRW9pdmo5?=
 =?utf-8?B?ZlBnbWErL3pMQ01tdjZSK1JnTXNxai8rdW5PYmNvMXF3aVMxeHJZOFZaYmtM?=
 =?utf-8?B?RDl1UENnQWdmVzZOaTZYMDR2S0dQdWFwUTBHeVB6RGlBekx4QWxLYjY4a1dj?=
 =?utf-8?B?aGNVMi9nVG1hcUo5ZUlkQUNiVGt0aEpMMHZZemorNnF2WUdGMlBEcnhibGlp?=
 =?utf-8?B?QTlvYXV0U1cxVUV1WUVWdzlhRHd4cGZnMUdYeVBNellOSVo5Y1pMT1F3V1dS?=
 =?utf-8?B?b3FodGNqTTljZXN3NFlWcmVia2t2b25yM2ZhQUZ4ano1TGVCQTJZT2cwN0M5?=
 =?utf-8?B?UXFjVDZPOEJYbkQ0NGhVZkFOMmtFMlkyZWd5aEVjN3ZpN2lEbkxyN3VRVHlD?=
 =?utf-8?B?Y3piZmU1Z1czTXNNbFBCNDdQMi9nOFdvNWtLZHMrVGpFM3dGck95RnNNTTFh?=
 =?utf-8?B?N2RERE5IMVJadUtzaGJ1K3BPZ0ZsU0dKRlYvbEZHSHhsQWIxTGNLM29xL3Fv?=
 =?utf-8?B?MUcrSEJ2aUkwNGQ1VFNlMkNlb3RTSENVQkxRbVpNbDFpa2dYdjdXeklFWDZI?=
 =?utf-8?B?MEllVW15MmVkSFh1NWZqWkoyM2JUMzJQOVRId2tXdWIwTld4R29MczdjSGY5?=
 =?utf-8?B?NzZjTEduMm5hL3N0amNFSHJoTFNnUFM0Y0F3cFdoeEJ1Qk1zaGs2MmFJS2tq?=
 =?utf-8?B?Z2cxbXFBRTI4bzQ5THRIcVorNk5uN3pTTERITGQvRE03VkJ4R3JWei8zOHpS?=
 =?utf-8?B?VXNJNWZDZ0Q2Z0ZaWVVENG0rdHptYnViYzF5dGkzdWxWMjlYaloreTNuVnlt?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p3JZA0pNDHDTpRZhTlOe0bcMnVfOySNB7C9JXU4D6RLfsEGHZvJmL399wvZNMTO9nhPUuoAsim3vR3q1PBJAx36GvbCdKCn3VFmzqPuaGTanFP0w33ouu8qehgHlZdxbdO1E2C6BHWv+opuMt9yJtPiGWXtZPCNgrzR0nxlGWsIt2OvxbJyvnkembVKydqXUnJJiZqyACSjatwAXEfDwBPHwD39GDX7HDKFjtTkXXp9w7jepY7RgW012qz/N1T63g/P56NRfiVCzm3xtDGlSTRb9dZINzVOutT7j+wfZO5J2Z0d/r6oHpBpjp4q+QT3i8QMBAIcVw8PZmxehMO8ilaYYDbK3DVUlevz5sNOJmlcBSGHljSe7/BhQr/UNqHl9DPQaM1nU1RabBN0KaBa+nFvSiHZAus8qM9xsaBcbb6Uoq+z7CSDYTwhWKDmhtTc0MjmDN9wLUWSSza+i0zY+cMZGpeZxzQJak/RZOrxYudJJBmZ2H01jvMigjT6GIgX0vhc+DcFhzO1cjwPT0aQuvQDWwZvdF/Ne39BWcW0yajeKT4/TGhsx7Qq0B9nMcN7kAqzj7kub2kt3WV0pc0rQC2y+1tmkqQkCood6/hLKKDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9918e419-39c6-4522-6bde-08dd875ec0c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 20:45:18.9998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYFcKq0PpcGbid2zfo9cV+nyyJ/Bm2HfcT69/35H6bcMKFoRO+hNdSZ/QeGSojfztBeStMyXzeVW07sA5AZyFjQ3UdMvqTWgUWwLLXzEHSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MyBTYWx0ZWRfX9rrh/3j5mb8C
 czAJFVjU63oVAqtpxdDAU7pb40x7mzZ9dID5gw2xPDOOrDOek5/oETiG9w43NMMXhZjcEmHdmLW
 Wzqq1cV5Ii5HGAC+3NeBy+xNWmAMX/Vc9OWJD3icsc9XWXNxMU4j/aLt6Q7HYGG5H+6fetrATVa
 XMam4wPOWWlFZpYiCalVtAq5y+AQIwpQ2j7USpOOTQNstFOZlWS4GACjlLpSTxxlaiSc9SBYPMn
 VsoJYYqONlJRSvDKQMDite28KWIsQRfXzRQ/j5tgVWjLwmWau9jRU1IZFUg/6BLIzsCU0xlYWas
 YBS5zWqHeQTM2w6hfcCxXJpmnmNiPVlyUdX4wbmmRv+hM0lsfytpkGhv1zsF4FFpunzhh/r/tVo
 uoynohia
X-Proofpoint-GUID: iDrceYQIyqlqWqA_QEBFRhCvIOVWCG2Y
X-Proofpoint-ORIG-GUID: iDrceYQIyqlqWqA_QEBFRhCvIOVWCG2Y
X-Authority-Analysis: v=2.4 cv=TbOWtQQh c=1 sm=1 tr=0 ts=68113a62 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=HGFjPks7JAR3q70_678A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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



On 4/22/25 8:48 AM, Sairaj Kodilkar wrote:
> 
> 
> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:


>> +    if ((ret < 0) || (!ret && !dte_mode)) {
>> +        /*
>> +         * The DTE could not be retrieved, it is not valid, or it is 
>> not setup
>> +         * for paging. In either case, ensure that if paging was 
>> previously in
>> +         * use then switch to use the no_dma memory region, and 
>> invalidate all
>> +         * existing mappings.
>> +         */
>> +        if (as->addr_translation) {
>> +            as->addr_translation = false;
>> +
>> +            amdvi_switch_address_space(as);
>> +
>> +            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
>> +                amdvi_address_space_unmap(as, n);
>> +            }
> 
> Hi,
> I think amdvi_switch_address_space() should come after
> amdvi_address_space_unmap(). amdvi_switch_address_space() unregister the
> VFIO notifier, hence mr->iommu_notify list is empty and we do not unmap
> the shadow page table.

Good point, fixed it.

Alejandro

> 
> Code works fine because eventually vfio_iommu_map_notify maps
> entire the address space, but we should keep the right ordering.
> 
> Regards
> Sairaj Kodilkar
> 
>> +        }
>> +    } else if (!as->addr_translation) {
>> +        /*
>> +         * Installing a DTE that enables translation where it wasn't 
>> previously
>> +         * active. Activate the DMA memory region.
>> +         */
>> +        as->addr_translation = true;
>> +        amdvi_switch_address_space(as);
>> +        amdvi_address_space_sync(as);
>> +    }
>> +
>>       trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
>>                                PCI_FUNC(devid));
>>   }
> 


