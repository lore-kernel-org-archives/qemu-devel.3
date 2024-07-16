Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ECAC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTenM-0007Vr-FU; Tue, 16 Jul 2024 05:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTenK-0007Om-MW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:48:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTenI-0000Zl-I5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:48:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G2tVTE005464;
 Tue, 16 Jul 2024 09:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=KaqP6Yp7VZUnHoKJss1F97tMInwTnkmenW9xNKxH0/A=; b=
 UR2Vse4Eo8t/pQs1im4Mjwi/M+GWYvvZdTmJsAftcA+qMvGbwYfqScpcTgQ8kSvK
 8Bq/2Epjq4i0v8jhBB7layAmGqaWiBy3kUwjPPo680zYNI2sG+85U1m89fKYwEQw
 4oN+S0jAM4fWLLMKoDMKosSvXTSGaOkzkYrjvtzczFxDNjCItx9Mjq9T3fENngtt
 XDaQTfiZRHJQMXoUcOVIYHg26DuSY643qyNuCObul0k2XeA6vkL/Mb+5mnOZGzvy
 D+wEFI3M+fx7+0MoB/7kO1f1IZ7RvanxliNSpWt9YockFz35P3hX2ny2zj2yMjVw
 x5nDD2ijklNzx5dgndMmEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bj4tn5bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 09:48:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46G90GgZ040645; Tue, 16 Jul 2024 09:48:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg193ug0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 09:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6Vt2A7UHRPNwhYMQIjMlBdGumBuG+yT3sBCzfY+M5khQUlj8Ku9JhzfnzzSu6oAVN6H0Yl4oyp4tEKf2Yvo/8nwwVwy+h/J9vT7H+3Pu+JzZA57wS1mH9SDoHPvCeg8J1f/H8+VTUzc7hAzGdPrWqUwA8oOSQt+bphlDswImPP6A+FZCzXeDo4lqNRFsQUKJ3EZIUMg094pl0U2+twWEIb6mFvI8DyDYlVBy6xhA9UKjyes+pS6v8wkM0CgVespCcRrGtUosS8rkD2bHZiR/Xf+Q0tr2HZqBMVweW/4rbiajXvtnAhRKmPtNqyqojV1hW6gujr8Z8uF0DQxnsMAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaqP6Yp7VZUnHoKJss1F97tMInwTnkmenW9xNKxH0/A=;
 b=Jy5rCwpfyRHgdrx1gvWet5oZyHxjDE2/32nWfT6a8Kn1rXsIvTo3jx4Dl78lhaQQo35d1G1dooi+NZD3RGSTnZBkACI9reINPDfKmzczj0UUtANH9QeMH0oIjsTZPw0RupeJx3VIUCeHeK/TCpAFeVCVpyDTBqaOu5jH7vbPdXBkPASpl7ZVMybWOAGpStJmBlK3x3LSCB7uuH8zDXkoTjTRYn3n/HxuExOzjYOBGznk9M9ZgvydvWL9wbfJv92jU2RKKN5m1umNcGM3NoL/G434fLN2//4UqDuStcun8J4DAcJM0np5VlL7JzwmU+jMKxdWl/tnyrLlzrFkL1oU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaqP6Yp7VZUnHoKJss1F97tMInwTnkmenW9xNKxH0/A=;
 b=rmu7aTLqqiS9vc4JDWbEs4cAHIF9+tp48MwIjGMSJw0F1sGUZz5dAnUN4D2bMi3F53V9M7fE/+PeCdC2H7r+La7DAQK0jdBdq+QA94h/XdFZyuMDxQk4HTUyABFZx7m2VY/0/DrLuDhP1LhsnXxe6ThAc6JYD2WC43n6+sV8420=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:47:55 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 09:47:55 +0000
Message-ID: <e9dfe18b-9f0b-46f8-b6c3-3fe453a48bd3@oracle.com>
Date: Tue, 16 Jul 2024 10:47:21 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <78c7c331-c4cf-4239-a875-b321ca5d7e08@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <78c7c331-c4cf-4239-a875-b321ca5d7e08@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e280b6-56a2-4334-aadd-08dca57c5dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWlyYm4xNzhRMk82dVhFSzVacGdwTHIwdVk1Uzl4c2h4YnRGRFNRZ0x5T2d4?=
 =?utf-8?B?UlZIdU9aL29vRDdQUzdmaU0vMkJuaUczNnFwMjAxTmdwV0I2U3ZBbmdac3NU?=
 =?utf-8?B?M0lNWnNmT1VqaUZETlpRN1FJcjZucmx2SnpaNml1TnFMeEhBazVRS1JEZ3VZ?=
 =?utf-8?B?TlQ5RG9FNGQ0c3VVcUJjVXV6YzZlMjE4eUtSeEZQdlQ4bzFkZFBYbHZrWHB0?=
 =?utf-8?B?MnRyWlVwNE96S01oRkxKMHNjeHQyUDU1NStEYXVmdHJMWERWallpK0ZLMlU4?=
 =?utf-8?B?RTFVajRYM0owMEMwZGFod051YVg4RWtuY3RsdWtHb2VuYW1HcmVGVTlsdStw?=
 =?utf-8?B?a21kTE16YW41ajBHMTRmaUlyVXVPZFFBd1VTeHJjWENtdjFNRU1wZkpReEs3?=
 =?utf-8?B?ZE1oYVJLbjVzUEZOTjE3SXNNcHFGcUhEUUFUMlFaOXQ5UmxNMDJINjBXQ21q?=
 =?utf-8?B?TXQvYWVKTmpUMzJDMkJIaHVFeVRxbk9VNFFmOWcrZk9OL0syeE9zUC81ci91?=
 =?utf-8?B?WG9OR3ppNEptYXNvaUp6bVhTbm5wdm02VWRidGVGckdTY2NJNklkYksyTXIx?=
 =?utf-8?B?bWtZRkF1QVhNSTdSVm1kMytXVWlqSE9YTkZiTGlMeXduUTYvOUs4MmhBdmFI?=
 =?utf-8?B?akMzV2JyUGJLbk90WmxHcGtjRW5rTEJHUzUvYXhPeklneGtRcDB3RTNObGtG?=
 =?utf-8?B?ekViRmFOZjJZQUozYnNsQi9DZldmK1FtSjRtQjhyK3hORUJ6SjFidkZCbmZ5?=
 =?utf-8?B?bjhrWklBR3pzZ0lmakM1UzkySWxrY29YV3lzcWJkTWVkNTRKS00rMExGdFY4?=
 =?utf-8?B?WFhLZ3BCaXdzK294aGdzQlRsbzY4aTUzYW0xZFdIZUxMQUlkUWlTZ0duVkpm?=
 =?utf-8?B?RUMvSkRETnBERVhVc0VNTm9PZmxDOExzWXZNSzFWTzN0SGlEcmRyVkxnb0FX?=
 =?utf-8?B?bGFUS0NXbVFjMnY1bUMxa1BlcGpaZHljTzRRbjhvbGx0L3J2dEp6eDJWZ2tk?=
 =?utf-8?B?UFZHM0VwcnU1VTlUanlDN3gza0VVSTN6Rk5Yb2ZGL2RQZ002U2JwV29TZ2VB?=
 =?utf-8?B?cXAzTmRIOVdJMG5vQktJZ05wSE53WXhNRGFaMXJiSlNzOGdXeTQ1YlhPYUtz?=
 =?utf-8?B?dkpETkdvQ2lCTVNnZjVMcjcwUCsvM25OUWJKTi9LMjkxZHZEWThCOGdCKzRq?=
 =?utf-8?B?L2ZlTk01WnZScm12UUhQaFBEbHhEMm1FQ2dzaTF0NTZ0YW14OVU5LzVZRmla?=
 =?utf-8?B?UHhlQUh0d2ZrWG9GQkRTWTdXeUJHbjAvTE16T3dXYlVId3M4VUpxa1QrdzNo?=
 =?utf-8?B?SThWWGpka2NFSmc4bGEvS294ZFFwekcxcVNWTFlIRCsxS29NM0VwZmVGeXZP?=
 =?utf-8?B?MXc4V0VCQmppT3RnM3BaTkd2cjFLQ3dSTzJzREdyUTk3SHBHbGJuT3VkU3pR?=
 =?utf-8?B?Q2JoQzd3Y1AyWlVFcVFUMUcyMzFadlQ3NWRPSmc5RmdYTk9YWEU5OHlvNUtV?=
 =?utf-8?B?QkdRUlVMYlRsS3oxcUM1Z2dLS0ppVlFDSWhxdlI3eDg2cTcvWkpYODkzSWNv?=
 =?utf-8?B?bkpXQzBVVm5La2xQcjlsODQvZXpSNkxCa2cwRG03ZnE5NjlwRy8xempBSUNs?=
 =?utf-8?B?dGtQdHR3Ym02c1NnWlNpRXJSNUlwditKclo1TEd5cHNWNi9xWFhTYS9KS0kw?=
 =?utf-8?B?ZnBSb0hEdUJJUEdDU2E5Wk9JVzBUU2pmb09xY0RIM05mamhjekxzS2RTL09Q?=
 =?utf-8?B?WklGK0U2a0pUZUNLZ3Z5NTU1TEx3OGFxdTE4T3VVL1VaSTUxU05YSGlEVHNY?=
 =?utf-8?B?ZXlYb1JtNjUxTGd2TFp0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDl5Nlhtd1l1T29ZcWMyRTlOajgySGhBMGJmOFJIQVArVTAvcHRHdDNRRndJ?=
 =?utf-8?B?Q1E3TEtTQVB3VEpjdmlLaGZ0TjhKS05LUXBhSWFHSVZzWktSejA2VTRLQ1Zj?=
 =?utf-8?B?WWhNejZRbjVhNnNCRkpQWldleGFiNExEa05oSVZNeitPMDRpeVR0QnQzdHNr?=
 =?utf-8?B?NzB0c1hVS2R5UnM4cWVsckJiSjlCcy9WWXJaMVBVZ3U3VG81QzU2WER4K1Ax?=
 =?utf-8?B?aVVQV0hGYTJZamYwWDh5MU5KeWtHUGFpYUtlVS91djhYdWh3Z0JKOURpSVZj?=
 =?utf-8?B?aFFaZm8wL2NDaU5wc0lFVWJpcEk2VVRQaG91dXF3VWViTElmVFN6Y1AwL3dt?=
 =?utf-8?B?Mm1UUktERXU5cnQyeDZ1TUJVVk5WY2p3SzNJeFB3Y0l4Q2RnM0kyU0FVMGs1?=
 =?utf-8?B?Tm85NHV4eU9KTkNuUUw1S3kzbVFCN1ZaOTUvanpPWlZhejV1Y0ZIMUZicUxN?=
 =?utf-8?B?TU1wSy9qOS92TmcrQ0tqWmZ4b0Q3K1pKSlBhMmpPYVZxcHkzcndGY1NiZG44?=
 =?utf-8?B?NnNDNFl1VHJGUW1uVGU1SlVaTHhUdC9pc29ORTZZL1FHK28rRDBKckFaSFkr?=
 =?utf-8?B?QlBaWlRRMGlQQnNpZnREQXNnZno3QzF6MlM5cjFLZzlMeWU5NHBTYVVmSlYx?=
 =?utf-8?B?amtyTnpkcUdLenZ3WHMyRUMwZVdsMTg3NzBMelR0UHFkbm9idTlZTmxUR0RY?=
 =?utf-8?B?aDJ0d0xVNlF1UWdibTVwb25LcUxkWExEUmhZcVFQTG5oNEJ1Umg4bzRONmht?=
 =?utf-8?B?RTdRZnkwSmFHZVBFM21UYy9CckQ5aEt1U1JqREtqamZEOWxYeklBRkN1c3Ez?=
 =?utf-8?B?d0RBYU1KZWVWYUp1NjM5SWhjaWtvY2RmNTJIY2xzeVNsbUlYNFhzT2M4NW5t?=
 =?utf-8?B?TkttTE4xbzJrekxUWVB1bGZaWXloajNOQmVFUWRtSlhzN0VGNHVOT0R0ZUgv?=
 =?utf-8?B?NlArSituWFd1NTBWRlVsREpOamEzOXZReWI4M2hDT0J4VS9xU2NYU1FRSkgy?=
 =?utf-8?B?dmsvdnY0QXZWaHZGRzZaMjlUR0dOOE44SzBCL2dYR2I3UU5vRlA5bmdZM2pR?=
 =?utf-8?B?RG1MVlVwSzFXaFRRQzhjdVpiYzZ2MW5OL0lZdmVYbktBTDRnSzN5VFhKbXlL?=
 =?utf-8?B?RnJwVHMyL3YreTg1WE12aEdBaWtqQUYrWExBaGFWYjlRUWZ6Q1ViS1hFSWYv?=
 =?utf-8?B?amg2dWkrWjY2elVQcVAwZk1UR2c5MHB1aGFNckMwMEtVTnQvV01ncGFkSG0z?=
 =?utf-8?B?R29vRFZPYVZKaGNsMHdVNUNyeTNZaFo4M3dIaVc0clFZcXN0aHh5VUZuaytp?=
 =?utf-8?B?U0VaazhtZnFrSGN1YkRHcGlsdG5DYjBxL3VBc2RJWDA5TForWkFFRGhHdE1u?=
 =?utf-8?B?Q2NySERpT1hMVGFSQXQyQXZXRmJ1T295Z1JlZ1R1V1ZVdW1IczNhcnJjSXQ0?=
 =?utf-8?B?TTcybW1VV2k2VVNJTGJtNllVV2lGbkVJQXlzZEU4M3VKRkhXbC9STEtIZzlm?=
 =?utf-8?B?VDBjeUt3QlNYeTRpUGpTbTNKWHA1L1VRT0w1V0JEK0Z1NU8wQldBK1hENkx6?=
 =?utf-8?B?VUlNbndxSE1EVTZUaXN2VW1McTgxbzNJT054bEVKVEEwTWlLeUhMWHFGMjJz?=
 =?utf-8?B?S0M0Nkk1R1U4aTN2aDVsdERtVDl1Z1d5U2lVMlhKWHdmZDJFSUkwdFphaDJG?=
 =?utf-8?B?NWhkSkFuQWdPNStSVVVzdzhFUis4ZHBGRkl0RStvSy9IV0xsMjh6ODZ2SytQ?=
 =?utf-8?B?bVRpbkQyNVRUUEYwNnZaYUg3c21NVEpRM1hFZGRaVVZ0b0N6by8vSmFZRDFj?=
 =?utf-8?B?QlVtUFpZa3Qrci9mUURzaS9PbkV6dk91RXBwZ2dvZ0hnQldER21MZTd5bEx5?=
 =?utf-8?B?Ni82RkJMNUMrb3BtMFpoYUQ4eVFDcFZ0UHdOakpxOTZZdHBFTnRyL1lxK3ZX?=
 =?utf-8?B?Nk5ic1dBbE5ORExxNWtvQWhkNDNjY29xWXpSSm40TXVnRStBUnNpZ0ZPaXcz?=
 =?utf-8?B?ajZRSThhUmNtdlV6R3MwK21MaVhIbm9VVWtpeEJNM1Z6SloyM2dpcHJWSWtQ?=
 =?utf-8?B?dHJVS0hHcitBYktEM1JhalljL1NUMHlycC82Z0tYelY2a2JWMHg1Z1lMdldp?=
 =?utf-8?B?by8wbWJWczR6RTd1OXc3SHM2MDVuSjJVenpxR0JvQ3hLT203MStqLzNZRm11?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ozmth1phlv4Y+2j9rOOFonJOvsKEMYBaTXUzW4xVJtsLuCDX/yWynpGrQGRzb7pLMTmAwAhVZFP52ra1N/Nuu1i6AQigETqwvBnwh0aES6G+XmwXV6AhjkRYZ+9bcf1ho/2qlB6a7CBBw5+H0jDnV1DM4I2Vgwz8RaoDjlaFtzTprdEkiF6nvCVzLtAzY8hTexCmkZx5+OCA1q2/CDvfgurBZf3lIZVXWhQn+uTiDuBGi6zdC0gQ1HzGgHGou4S8tr3gyaIsENfYLAlWoDkjjJdiKEscU++UoGqoz6Kuviv4K8eDfj5/Rto97TRkf8l2h61vNAP3gBORDaE+KCVWmExu8CVw+b2+nlv6BrOo1oW6dUAMVKXuo68A70BBDIrypiORZQ51lp6PLETlo197CsiI2qKiAwYJnnGm9omyQYCbTnSkKjH6HpmWHFnf1gkuSGwJFS+/HwrKUxvGyr7/GuEu6vJZwvY2wLdF1Ild36GoOmyNfMggO2CeRQe63BoMAQFpOmw12YOp5ivQ5pUuBSSOGhJJGfwBsRjLqgvRzCWHJpu5cCmXTQC8l2gSeSCFheF2de3dfhkqhSCxFgQmyieAeuF7n9SG2nmr9t8C3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e280b6-56a2-4334-aadd-08dca57c5dd0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:47:55.2849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8A4fkiJz29rAVCGNuaEWKcCTNqShEHhYLMfsgglYUthyZ8lhe+a38wOZ4f3cvUqSNcB/kAxW+FQcaDJdittyFhCwC9lOdoELn+2IsBGpI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=621 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407160071
X-Proofpoint-ORIG-GUID: KEAhpItAJF3uMFXqv6ZPd-EjgEIAH3r4
X-Proofpoint-GUID: KEAhpItAJF3uMFXqv6ZPd-EjgEIAH3r4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/07/2024 10:39, Cédric Le Goater wrote:
> On 7/12/24 13:46, Joao Martins wrote:
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) 
> 
> I suppose 1) and 2) are the bullets above ?
> 
yeah

>> is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>> responsible for creating an IOMMU domain. This is contrast to the
>> 'simple API' where the IOMMU domain is created by IOMMUFD automatically
>> when it attaches to VFIO (usually referred as autodomains) but it has
>> the needed handling for mdevs.
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
> 
> mimmicing -> mimicking, I think.
> 

Ack

>> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU domain
>> it falls back to IOAS attach.
>>
>> The auto domain logic allows different IOMMU domains to be created when
>> DMA dirty tracking is not desired (and VF can provide it), and others where
>> it is. Here is not used in this way here given how VFIODevice migration
>> state is initialized after the device attachment. But such mixed mode of
>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>> be added on. Keep the 'all of nothing' of type1 approach that we have
>> been using so far between container vs device dirty tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> This needs feedback from IOMMUFD experts also.

I take it that by IOMMUFD experts you the ones more familiar with Qemu side
(Zhenzhong and/or Yi)

	Joao

