Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6338ECA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0j4J-0002EP-BX; Mon, 22 Sep 2025 12:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v0j4G-0002Bk-9f
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:07:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v0j4C-0006bb-Pa
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:07:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MFg09s013025;
 Mon, 22 Sep 2025 16:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=XnJ+kV2EL1k+8J/Yl8EGWMxrKAxVNS9lBywnwT+niZk=; b=
 Hfilft93giFHFnnkkrWIDWjRUlEA2KQXgq68OTfLqv+TBF5E29ulFaRpG9o65e4i
 XtJPb185ZEsNwTl8/jh9mF23KhJ77Do1YF8RTxwvMK7jLOmlm4e6wepeYHf2u28f
 WgjEqr/fs/rKU40w//waOgewMFpcEzwRGAQyIG6i9dpf+jo1KC5lnTTzvbxAhniv
 9W7eJOYdK2KbYcRMfMlzT12AnJbgmre2ILO65wGjWR+2HgmtxxcIgAqWvIMRBUhk
 ipGIoQ2O2i6NYwnx+oyVhXw49Xv0+zDsRy0M/BmoAxW+aFjHO80cqA6KM8Np1pMV
 0DZ9aGC1WECzjWLC2RY8vw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23ate4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 16:06:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MFpmbJ034255; Mon, 22 Sep 2025 16:06:51 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhfr4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 16:06:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbZCgJ5zu4CcdFGWalEMomunkkioveheYiqvINEJPelYw74M3F2oRgjUtZ6hUo6DQcSTOEovh7ZUSas0orl5bB5KcYTznw42oPILAc2lmYUzfRErKAdOW93Fp+znD/OmyHBSghBJ+gOJJdJl4DlnQBGMaJ2ZKBjw+1cdXJfBG0o/gOzsz+T0JjLcWAGnVX3q0sNnyYODJ41xw3ifrO45ZYGBEvN3LweSgiVm32ewqyy3BlQuRXScuGZ5XIKIWRYYY6dWvY3DUDzMFWEvv/qUjDHWRKfEimkaLqLLOy4QXgZ4twyYAKnI1eU5bd3wi6lyUYWgJJC9lXG614/9PNB7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnJ+kV2EL1k+8J/Yl8EGWMxrKAxVNS9lBywnwT+niZk=;
 b=E+D0Tx/PoIL+38ICcd56/YMnNvv59X0Xbky1dUWs/T83HRAI5lK58frQ07ZiFRN0jXmZLoV+2fK2pUi8z5H+6yBxJ50MiST9txWuHjcKqsbe7P52UzCdZUby5wM05iSA0KxX7UFWgRjyq/Y4PAoYff7eNEAQYTyQ5eAChD8YcrBjJa2L1u0aGb3fva4i5BbnB056jSvcliARFBJiU8hvLUoUTAikYsDjhzQV4aK/xIkc2cAzhz/XFRMeKE/JfWlmZrek2WpI6/Ax84Jc2osPSMpmnzfdgAViR7xQ8X8e20cBeUu+FOOJkgybEqekHtz/gFP6QW41rYXKQR9uebgK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnJ+kV2EL1k+8J/Yl8EGWMxrKAxVNS9lBywnwT+niZk=;
 b=WkOACmYZVBw695fZRjpghHjVQT+3x/PgzPfDuoWX9MwW4YCK8WcSJS1HxiDqZJcfegKfB7xAKSNqQ2MBNzQheY2wSYLkTV5WXxzmQ0rxl08LDSsC+I7/HDVrLkB6V1LsLiJ9Poy+fsH44RSUaQ5SCF373HZLVGkzqyJedZ29y/o=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by IA3PR10MB8395.namprd10.prod.outlook.com
 (2603:10b6:208:57f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 22 Sep
 2025 16:06:44 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9137.017; Mon, 22 Sep 2025
 16:06:44 +0000
Message-ID: <ce629779-42ea-4850-924a-5803a7547998@oracle.com>
Date: Mon, 22 Sep 2025 17:06:37 +0100
Subject: Re: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|IA3PR10MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: c35e3654-1e04-4484-13f9-08ddf9f20645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkhwUDY2aDk4eHRDaDdzTjAvdmtWMklIcUZVVnZsZzJNMmdaMFFVVUZZQThr?=
 =?utf-8?B?UEhURHMwQVZ3NWI1bWN6aUt6d2xndVk5Q1hUS2F6LytkMTJ3WHo3WTFucU1H?=
 =?utf-8?B?UUFnM1ZtSWV6MnlzdWxEcGV6OWMvdVQ5bUVvMk9kdW1DaG5VRXhROC9kOEdR?=
 =?utf-8?B?Q0haN0FDbVJpbERyWkVjSHA2VzRvck1YSUxiZENnSUVqMmh4SWZMdmd6K3pr?=
 =?utf-8?B?MUovMmU0RjBuN0FDd0VmdU1WTDBCUkt4UnBraUFVUXhPak10ckVxT1VVc3N1?=
 =?utf-8?B?alFHTGtkb3ZoNnozQjdUVzlrK0JrU3B1SWpDZnUrelVWa3h2NE1uSThLWnQv?=
 =?utf-8?B?QXY3eTJFTWhUanNGaGhSUHo3cXJVbEZHTWJYU0NhSHFOK1V3UWlxQWFKNlBJ?=
 =?utf-8?B?dGF6TGNZd3FLZGFCdkltZWw4Nko5S2RpVjJTK25SdXFsMDlqOGNjOE1QVGlY?=
 =?utf-8?B?MlNISG9KV2JnVFBVaWllRUgrQ3E3ZUQxNi9jMENFVDJQU3Y5WWdweXBocnJD?=
 =?utf-8?B?K2FoVFRqaXJJQllIclF2VFFzUmRhS2JtT3pWVGZPSC8vT2orV0FHU3FTWnZU?=
 =?utf-8?B?ai9YMDVXQVpXalV4N2E3UUQyNkJWeFMwaHRkQTB3MklXYURXMzdtNFdkWTMr?=
 =?utf-8?B?Z3VPdGV6b2U4TkdJdHJSaU5yaDNBc2lkRTJ0VURqK1Q3OU0wRlVKSVYyRHdw?=
 =?utf-8?B?N3ZySU5VSms2V3JJVzZSWGY4UDhoMWkrU0FGeXdrNllyTXFVbllMc3JSVlRT?=
 =?utf-8?B?d2FrbG1DejM1dXRwRFh4OExhb3EvOWE4NGdaR2hCWkIzWWNkQmUvR3J1bm4y?=
 =?utf-8?B?ckxVVW1FdUNXaTVMZXA4V2libFN2aCtFMVpMaDMvSTdLVExXZzRuTThIdGVl?=
 =?utf-8?B?NlF0K0gvTHl3blZKaUZwT3VTZ09JL0g2RTAveWVacEp1c0FkVGVGL3Nxamkr?=
 =?utf-8?B?YTNIM0EwMHhSQnlMbWdaK2NiTUF5YWF2S3RLaGNBZjVXODB1VFZSK1BLVFBV?=
 =?utf-8?B?R0xMUzc1aUlCQVkycXdZbUJjWXZYNE1NV0pNOHZIUmNvSnpuR3ByTEI2MTlr?=
 =?utf-8?B?cnM1aXBVWSs0emh2eFVzTHA0Ym5zelRSeWtEQUpOd0RRSGFjNUFEWnVlNWli?=
 =?utf-8?B?a01kUVVaRWlYTldHUUNEd0tuUGdWanpOVmh4bVd5a1VFZHRDa0RnRGxNZjBH?=
 =?utf-8?B?R2lVQ29NeUlKT0oyV1dXaU1Ma25sTzdVczhrTW5vckpmcit5Nnc3dW5rK3FV?=
 =?utf-8?B?VWZRWndGTnIvWkY5dlU1TGpqRVBDamd3Ujd1eEs5VFlNSUJyRVhXSUhTZzI1?=
 =?utf-8?B?ZWdhbFY5NFo0dDA5Y0UvYTNXTmRlRG11UUk1cTNFWWNURExwWlJCajIwbWQw?=
 =?utf-8?B?Q1hlNnVwL1ErMWtTNkUrdDhVYVN1QnErcGh1Yndxb2FzV0hLT0ozTXQ3ZFRV?=
 =?utf-8?B?Z3pvalZCVE90bWZRZ0tmc2NmOCswMUVpWlNiY2RyT2w1b3gxY2VwQTRrT3ox?=
 =?utf-8?B?SHFiMDY1RVF3VERBYVI4UEhzK3A4VG8rd0VYTCt2c09SUi9pa0F6SkFjSUdJ?=
 =?utf-8?B?bko5QXNBVW1Ec2ZHSUc1a0Y2cFNiNVhzdC9ZZ2pDakhXNW1IODFabFB2b3U4?=
 =?utf-8?B?ZERJSTFwdGhlR2JuQzErTGc2OTN6Z3FUN1UzUi85d3FRUms2QW8wVytKZGZp?=
 =?utf-8?B?MkFvc1lDV2VkclZONW5kODZFTTBDd1I3LzFtS1FDRFhycG16ODFKVThyQU5M?=
 =?utf-8?B?UG0zSnBEVDdOamVvT2I2VXNHandWTGUxUEZBV0hUMkhKVzdhUytRRmphb1ZH?=
 =?utf-8?B?eXA0aWRQYW9xTWdjNGFkNGpvbDNWK1UzdXpIZFEyNVpZQmpOWGVqSDIzM2JK?=
 =?utf-8?B?NWhhODFyQ0g3MVBKRTZKZ3l2R2p4eDlXTU1Rc25nSGZPSzU0ckdzZE5UaUJh?=
 =?utf-8?Q?DGhydRjhTJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRRUnh6b2plYVdxamJKaVdUTC9UNHZsT3pWdGlFenZnSkdHdDFFbFRVd205?=
 =?utf-8?B?YTYreTJDYnlZdkdQbHRrYjVYV1l6M0ZzZi9MRFNDcDJEYk9kWWl0SnAycVJm?=
 =?utf-8?B?OVNYNFJoNE9saWZJR1ZINTN3Z0tKL2JUcXhSWld3ZElHaHFCZkI4UFlrNnM2?=
 =?utf-8?B?Z1MycE5kUXB1b1A4b1Yzd0JObVlVNHJGUHVhVG1XWkRnWWdobnBUcVZvUFg0?=
 =?utf-8?B?QkJOS0dENUtPa0p2RytMVzBsM25Xem5HT2xJQk13Y2J0a3UxWUY1OEZHMllu?=
 =?utf-8?B?ZlA5RFdvS1FsbUowS2tBNGNMeCsrVkdPVk1lcTd1VEI1YUFzWjVCYytYelFo?=
 =?utf-8?B?L1YyOXhuYTdScXZqMWY2Y1BOU3plc1RQVDVGY0N5bUk4Qk83ZGR2bkdFa05p?=
 =?utf-8?B?eVFRTnR6OTJNSEpZU1RxZVlIZmxNRHJtVmlhazFIQWlYN0h4b3R3clZvMER4?=
 =?utf-8?B?Uko0RE94MmovaGM0WEdrK1dWTDlEZG1EK1dMSGVTS1BmZE5Nd3B6YjV2K01X?=
 =?utf-8?B?TlNHa1JVekwrYXExTHRRMDE0Zld3SDNBQmt2RUt4bE14MzkwM2ZxNzV4UFpm?=
 =?utf-8?B?V0xCSHZQbDVhTU9pbkZzczRabVpqVG9nZEhDUDBpL0pyWmhkOVFjY2lmUnpj?=
 =?utf-8?B?SGNRay96Q2NYQTdtaE1RaDRNTDVzdHorSGZXc2ZYdkJlTjFUMHVNeUpMN0lH?=
 =?utf-8?B?MjJVamwrVS9FeW5TeG9GTEViRUVlcW9xMTR2OUxsd25hOUpvMjZsZTJsZlMr?=
 =?utf-8?B?dk9TTWRLdXBRaWtOWWlBS0dKMDg3cGxzZTBXeSs1Q0oreEJvYnNhL3pod2o4?=
 =?utf-8?B?bFdzL1JUM3B0MEhNOVdodmQ4ejROVk9sL1Y1aEwza1l1QVlsUUZhMU8yekpR?=
 =?utf-8?B?K2VSbDVzVWFpU1ZYSjZMcmtkVmFuekszSEEvY21SYnhITk9HTmpJUCtMTU1P?=
 =?utf-8?B?d200b1BNQUppZllPZWluOVp0NDIycXVadEN5T2ZqOSs4b1RVWE50bzB3T0xp?=
 =?utf-8?B?UHl0TmdhZThUd2FYejA1WUFGRTZOV2RGV2tDYVl4aEZIS2xjSkM1emp4RVRV?=
 =?utf-8?B?bUw2djA2d1VkQndXbVVGU1NxZmRiNlhpSVBnOGlyVFJUcThrdSs2MVUrWXJQ?=
 =?utf-8?B?c1pZRkRJMVlOckNpZ3MrSnhoMTlySm1MazllTFpzeEhpWFIrZTU4dkdhU1Nz?=
 =?utf-8?B?dVk2aThUbDQrS3NqM2dpcTkrQmNFd0o5TGJTRytMY3Jkd0xmWTZNRWYvUGM1?=
 =?utf-8?B?WktIM24xRmR0WlliNTBrOVliMFVWZktIZmNXamFrSnE4a0dZejljSmtIbUxR?=
 =?utf-8?B?YnJsKzFOWmdzV3o2NHRLSW1WaWZyU0pjNGpiUGF6anJuL0ZLaXc5MTFaWi9F?=
 =?utf-8?B?ZVh0bWl5MEM1amhHZmJ1ZnFVY3RmM01XR2cvVnhBZlY3NS9vRThjRCtHTTQ5?=
 =?utf-8?B?REpMVlYzNCtsQklKTExjQTZyOVBMbVJRWk1zdUIzV1dwRG4xT0ZIMEdZNGJL?=
 =?utf-8?B?eWxBL3dMZjBMU1V1dE8vai80cCtnZXBkK0lJQkNyeXVPT3RBQUNndHJsZExX?=
 =?utf-8?B?NEdYNlFvOVlQOWM5QjFKVllJVHpVd1FJYWFCRmxOSmM0YUJiTnhlM0dGOVQ5?=
 =?utf-8?B?ek12ODBJbWpIVWhITzNReWh5eTJuTlF4T3lYVXN3azQwd3ZwZms0YjJ2ZGdp?=
 =?utf-8?B?cG5Qa0RmT0dEdkltdWczekhiZlFXWlJZa0UxazBCckdva2l2U1NPUGlEKzU1?=
 =?utf-8?B?QnZrZ0tvbFRQb2drVEJFYm9jM05hN3FNOVpFTkNENHZWOGM4aVZzZ09jUDB3?=
 =?utf-8?B?bTNacmNkWDYyUE83ZThkbXlDQjZjSytoRENZaXdjbndhMVJWaGNmN1RZUWha?=
 =?utf-8?B?UUsvbDlIWlcyWkFwYzlKNDlpc25GVWJzYUN4M1htaEtodXdSdExjNnRFSDJh?=
 =?utf-8?B?ckZHZHJ1SzVXZndhKzYzbzVpS2dsSEgwN25EdVhUVmxEZE5hTGlEUUxJUmVI?=
 =?utf-8?B?MnVhUUdqTGcrUHdKQmxWMWFkWUJzdjZabjdtZzAraTJ4ZHZVVi8ybnJZNlpH?=
 =?utf-8?B?SEs0emY2Zy95QjNOdENrTkNGbGxzWWgvUUlJOTgzUWVFL1ZxYlNIZVB1c2tR?=
 =?utf-8?B?b0xGMEsrMTJJNUhJdmRxZFcrZGFidldib1kxMlk1REpHcU0yNWh0SDhHOUcx?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LPXD8HW9BeeqEgh74TGT9UuaqBrQcx6BgBZakbii4wXnKFmyT9+IZGYPUu7CZ4S28EmXYImPSPQ5NirMCNPadfkGodNjLEDfMQ2YBTIEBNOaVha9BuU61glcSQakIkfyzyc3WqHW36nZSpBnEkei8pfXcfvyjwyq/5PFGNkf2xxXUZCSrYZARGD0OUbkF649SzfBi+uDizcefD0xFTaOZcrG/gR2Larug/2RBewcV+d41bRHpo3Q869iYIVwtfABcpywnOR8dv+/zpmcH4WF3AgOsZ+Tmxw/s8OthaUP7112bsS6D3J1XV+5mnx7mBYp8jKAj0n26Om84k+cJXap26S31kQcGbUjpJ2SoCHC3dfvaRS6hIBahCYFtzTXXivj9cBORMpQgELoMF2oQCd/RVXGnzJ/UMfVIBHOiNBfQEtoZL13CdIIqzDLZuXObDgaajq6FlVIpbIn6xhrThe5gNxOC5UHlfwmrJxAqh7XjemOsEuY0S/f6PPieQfaGtCQUGEsj/W2n0hSqL4pTYYQw+XIzMnjlvmWLjOhBwodP7U7YEHok4JqgCBcjUbIcfJGVS9VX3YZTUrS0b8QVuCq76Q/4x2/caJBNl4ULd5nMcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35e3654-1e04-4484-13f9-08ddf9f20645
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 16:06:44.1779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1/n8uUdaZUorRG+EPZLU4asD3NXu+2XxBdWxJ2ty+brF6labeEY5Iw76rNx5M3NvYyCi8dS31q3rmqKzWCYVfgGKRQvCH+MVlZPRT8pUfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220157
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d1741c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=34TstRkoMSmd9ct9NhMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13614
X-Proofpoint-GUID: Z7GEicQv9CBY0Vd8PWJASYojUfb-JM1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfXwMbE27tOIWz6
 H25Peua9LXfaYeFVEDWYc5zlhBX3IvJUOpT7jYEJmdCyvYaCsUplto1u9vHgaPRwfDqNwyx5Ftt
 13iALHyw+iWi8waffu9wLR7pNK0IMOFXpJ/kcLeHYShVxL4Oj5ANfMlkLUmgoUcfyIxUPvOkAT4
 7aYZP8QWc1C25Ma6mjpN6ukGSdyojrqnrMrIiWQ9oUL0aeql6qsXe4QE8V3l9J6j/kBwt8deXD1
 lBD6icHoJGVBdJP1ZLrHgwc3I/On2gtPso57uVpUmcyJdmNonMv7McDNuIBxio/RyGjFohXi7lU
 ZNt4BGxnwxAYT2FXRGiumgG1W2Sntz8WU0cpxBNPwE2wl8IkFPm+V7u5UFkumwQLJxQ9CAhN7wA
 P39JEBTmAGwX3PPhQFpcmor68hvJ0Q==
X-Proofpoint-ORIG-GUID: Z7GEicQv9CBY0Vd8PWJASYojUfb-JM1g
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 22/09/2025 17:02, Cédric Le Goater wrote:
> On 9/22/25 07:49, Duan, Zhenzhong wrote:
>> Hi Joao,
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>>
>>> On 10/09/2025 03:36, Zhenzhong Duan wrote:
>>>> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last
>>> dirty
>>>> bitmap query right before unmap, no PTEs flushes. This accelerates the
>>>> query without issue because unmap will tear down the mapping anyway.
>>>>
>>>> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
>>>> be used for the flags of iommufd dirty tracking. Currently it is
>>>> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based on
>>>> the scenario.
>>>>
>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>> ---
>>>>   hw/vfio/vfio-iommufd.h   | 1 +
>>>>   include/system/iommufd.h | 2 +-
>>>>   backends/iommufd.c       | 5 +++--
>>>>   hw/vfio/iommufd.c        | 6 +++++-
>>>>   backends/trace-events    | 2 +-
>>>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>>>> index 07ea0f4304..e0af241c75 100644
>>>> --- a/hw/vfio/vfio-iommufd.h
>>>> +++ b/hw/vfio/vfio-iommufd.h
>>>> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>>>>       VFIOContainerBase bcontainer;
>>>>       IOMMUFDBackend *be;
>>>>       uint32_t ioas_id;
>>>> +    uint64_t dirty_tracking_flags;
>>>>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>   } VFIOIOMMUFDContainer;
>>>>
>>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>>> index c9c72ffc45..63898e7b0d 100644
>>>> --- a/include/system/iommufd.h
>>>> +++ b/include/system/iommufd.h
>>>> @@ -64,7 +64,7 @@ bool
>>> iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t
>>> hwpt_id,
>>>>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>> uint32_t hwpt_id,
>>>>                                         uint64_t iova, ram_addr_t
>>> size,
>>>>                                         uint64_t page_size,
>>> uint64_t *data,
>>>> -                                      Error **errp);
>>>> +                                      uint64_t flags, Error
>>> **errp);
>>>>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be,
>>> uint32_t id,
>>>>                                         uint32_t data_type,
>>> uint32_t entry_len,
>>>>                                         uint32_t *entry_num, void
>>> *data,
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index 2a33c7ab0b..3c4f6157e2 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -361,7 +361,7 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>                                         uint32_t hwpt_id,
>>>>                                         uint64_t iova, ram_addr_t
>>> size,
>>>>                                         uint64_t page_size,
>>> uint64_t *data,
>>>> -                                      Error **errp)
>>>> +                                      uint64_t flags, Error **errp)
>>>>   {
>>>>       int ret;
>>>>       struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>>> @@ -371,11 +371,12 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>           .length = size,
>>>>           .page_size = page_size,
>>>>           .data = (uintptr_t)data,
>>>> +        .flags = flags,
>>>>       };
>>>>
>>>>       ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP,
>>> &get_dirty_bitmap);
>>>>       trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova,
>>> size,
>>>> -                                           page_size, ret ? errno :
>>> 0);
>>>> +                                           flags, page_size, ret ?
>>> errno : 0);
>>>>       if (ret) {
>>>>           error_setg_errno(errp, errno,
>>>>                            "IOMMU_HWPT_GET_DIRTY_BITMAP
>>> (iova: 0x%"HWADDR_PRIx
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 0057488ce9..c897aa6b17 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const
>>> VFIOContainerBase *bcontainer,
>>>>                                     hwaddr iova, ram_addr_t size,
>>>>                                     IOMMUTLBEntry *iotlb)
>>>>   {
>>>> -    const VFIOIOMMUFDContainer *container =
>>>> +    VFIOIOMMUFDContainer *container =
>>>>           container_of(bcontainer, VFIOIOMMUFDContainer,
>>> bcontainer);
>>>>       bool need_dirty_sync = false;
>>>>       Error *local_err = NULL;
>>>> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const
>>> VFIOContainerBase *bcontainer,
>>>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>>           if
>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>               bcontainer->dirty_pages_supported) {
>>>> +            container->dirty_tracking_flags =
>>>> +
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>>>>               ret = vfio_container_query_dirty_bitmap(bcontainer, iova,
>>> size,
>>>>
>>> iotlb->translated_addr,
>>>>
>>> &local_err);
>>>> +            container->dirty_tracking_flags = 0;
>>>
>>> Why not changing vfio_container_query_dirty_bitmap to pass a flags too, like
>>> the
>>> original patches? This is a little unnecssary odd style to pass a flag via
>>> container structure rather and then clearing.
>>
>> Just want to be simpler, original patch introduced a new parameter to almost all
>> variants of *_query_dirty_bitmap() while the flags parameter is only used by
>> IOMMUFD backend when doing unmap_bitmap. Currently we already have three
>> backends, legacy VFIO, IOMMUFD and VFIO-user, only IOMMUFD need the flag.
>>
>> I take container->dirty_tracking_flags as a notification mechanism, so set it
>> before
>> vfio_container_query_dirty_bitmap() and clear it thereafter. Maybe clearing it in
>> iommufd_query_dirty_bitmap() is easier to be acceptable?
>>
>>>
>>> Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH for
>>> generic
>>> container abstraction was to not mix IOMMUFD UAPI specifics into base
>>> container
>>> API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend
>>> could just
>>> ignore the flag, while IOMMUFD translates it to
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
>>
>> I did port original patch https://github.com/yiliu1765/qemu/
>> commit/99f83595d79d2e4170c9e456cf1a7b9521bd4f80
>> But it looks complex to have 'flags' parameter everywhere.
> I think I would prefer like Joao to avoid caching information if possible
> but I haven't check closely the mess it would introduce in the code. Let
> me check.
> 

My recollection was that it wasn't that much churn added as this series is
already doing the most of the churn. But I am checking how the code would look
like to properly respond to his suggestion on why he changing it towards
structuref field.

