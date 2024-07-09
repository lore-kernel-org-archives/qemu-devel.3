Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9968BC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 08:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6ec-0007if-QF; Tue, 09 Jul 2024 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6eb-0007hs-8f
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:56:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6eX-0005LN-Tn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:56:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697u3vA019125;
 Tue, 9 Jul 2024 08:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=4IG87TBbdOu69uEhoaUV9QSl3/toTS46Nbo+GSXk9pU=; b=
 JlSqOuxELSAqdmrmk0qXz2EMziLhzmi6/+DAw1xFoUcOO11TEldcTldC8IXbo3or
 YZYgek241n+IWZmw7qPfJ/+3KUWi/aTzXs6XJZ/O0sdXLOA3un0kFvFiJx1hhqMC
 3SAFv9dJTcpYwDg1erdjMFk9C6AltuvVu13zDGTvekBP1B3P8tP/UU75OrkJBAgn
 hiX+h3C1t8Uos5Zky99IUq3Fg4LR2DH020wFyl8IFb8HmcB6vbkiohrL6c4KpGfl
 G+q8WwfF4dIlyTMCPOTmqonluEq1uemXgrem9QR6ejJ8H9L59Soa6yXPkrlpsWxb
 lZrtKNeK7dSMwYuwFHx31Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpvfkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 08:56:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4698UCvq013662; Tue, 9 Jul 2024 08:56:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txgn3rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 08:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPjzA8xiqun09+ATkP0jTpxTHAYQb2g8ZkoUkw7MoUZTAZqXGZojiVfKZD0ZgKdx+AfHO6pH1nCEJK1kX27ZXtT02NRTPqyW2MpaCH/BGuZl4nK9olC1weFTd0Bn0yAINwln+o7/LriF93hHRXJpVe5+Y4+zkDiIVOYYI93hHTjhrYCXLddZmpV01EhJONvRjzq3Ci+mIsRtAslJ6yApK8n0+t1A/W7VWgQqntshD1hN8qLGWpibsjgMCUtyWvdQubp/PkKBEnnO4qru/CrBxYPNCebHVWopFduNJARMY0v0nFoPvsdopiUfO0SmbDGRAEtN4sB4GDPQgFiJ0kSEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IG87TBbdOu69uEhoaUV9QSl3/toTS46Nbo+GSXk9pU=;
 b=CS0aMcipuFpTZE0hiRzeQ5GVjNPA3SxWuSxQBors1BJqk3/FMUS+qjbEoWwLvuzzysAOHUOk+IOsFgiKM9cQj+8Ru5I5t6UZDrWmFhbg52x8HwXcd1ctV3AVx3SIgEqBGBLT80mXPRZ7EPwy8foA90b2WTNB4Y0Qqszc96Rrvi6zDJnD1oDhYUI0FVSHU3jV/ri/vrnPzZP/5uuBqAQcOumeW7u3l6WmliKjYF3KRxa9AHRl0NteUeJN9Ehag0sPLkVFEyhE/kj9szF3I9ZSkxylU8iyzyBidczMWpU6pzu6IiVLBcTq1I1w49hKs9VDZP45YnYlQ1v4ikeFgQY7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IG87TBbdOu69uEhoaUV9QSl3/toTS46Nbo+GSXk9pU=;
 b=z/Jia83azvb5+kYx1P0JRC9UVjpKyCPnpi4EfiwvR46/U58sgon71J5nN8TCo+NjiON13Q7w+CoBxCfetrhnxZoL+A59mNEBvSm6FlC9i4eOwm67v9/3Gb48cJ8oYUgPfoh1JBa5TWIC4n0iuwk9W/XcJJDZn2cCylK71suWA1E=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6109.namprd10.prod.outlook.com (2603:10b6:8:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:56:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:56:42 +0000
Message-ID: <4cbbb3ec-29be-4b5d-b479-1acefee83466@oracle.com>
Date: Tue, 9 Jul 2024 09:56:35 +0100
Subject: Re: [PATCH v3 03/10] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-4-joao.m.martins@oracle.com>
 <5420483f-03cf-4383-be73-e3a8ec2a4378@redhat.com>
 <e57d4d48-0908-46f5-a2de-615c4c1edb5b@oracle.com>
 <8bf7de43-1e1c-4c42-8a1d-8b2e920b8afa@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <8bf7de43-1e1c-4c42-8a1d-8b2e920b8afa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4955449c-61a8-4192-5f75-08dc9ff50dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWRwWHl5S2k3MWd3WmkrWlZuUm9KbThLUktMNEFxclMxUnlEc2Zoa2N6dXZI?=
 =?utf-8?B?cVhxYWhRWUgxZWtEYU1EWTZicFByalhFY214V2JpZVg4Q0wvNTVJSE05anht?=
 =?utf-8?B?NkZUZTd5YUdDZWRucUduV2pQOUZNY3BkSnhmMlUrRzA2SXVMM3N4Q0NESjRC?=
 =?utf-8?B?ZU84VEVacHhXRUo3azM0UHpsMWtyYU55V2ZjTGlLQlNTbXNCNWtYU1BXei9Q?=
 =?utf-8?B?aUwwTDI4NUYrSjdDRFFCMjlIZ29GMEtIZi9CSUxRNWh0MmpzYjZ3R1pRWER0?=
 =?utf-8?B?bVE5ZmhnQzNCVnEwdURveXNJVVNETEFSWDl5cmpVc3hmajVEeW90TFNoaTJY?=
 =?utf-8?B?d0JZaDAxY0t1UzJBRHhqNVFPU0huMTNYN1lNbWI4dGxjQysrYlRSTVdLdWpt?=
 =?utf-8?B?YkZ5YTB5MGZRVjlNbkZDZ3lzQkxFazR1aWVRUlVVcFBvbXlXOFEzVW1uS0Zx?=
 =?utf-8?B?UXRjcUFoSDlrby9nOTNrMGRBSEJTTEFPM3Z1SDNjMTJqZFNQOXc4NElRNVo2?=
 =?utf-8?B?K0hyR2RyaDRnV3NsTlFIYlFFb2h4Um4zSEZaaFYvaEJ0cVdIZHoxd01Eczdu?=
 =?utf-8?B?Wkh5cGlwYUFLS0MxZFJSRFRYY2JXZjVZbFd5Y3JLMlNvOUtVMmp3ZlJwdFps?=
 =?utf-8?B?QzdwajkwTVhKK1I0NmdJbWZlL2g4bGRuaitiNndiSGNlTENMM0lycXdWcUJX?=
 =?utf-8?B?ZThCdkFhVGRJMDI0YTVUSHZwTjhiQlpJZGl4NkhqTTlVVUExRTRkYnZhbklL?=
 =?utf-8?B?UVNUVW1IQTBmT1BuSm9FdkNkNzBKdGF0NGZJVWkvTzBWNzNXaXJDVEdGT09F?=
 =?utf-8?B?UGdHdFRBZkhoc2lHNERxdStydzVUM05iWU1DaVBuczluR0dFTE40SVA0U0tu?=
 =?utf-8?B?bDhaMjZMaklkRytlMzRHU0k1ZHRDWEJGb04rdEQ3dFY0OHVMWk5lL2xwQ2hZ?=
 =?utf-8?B?NUFsYjVNaTYrZVFEUC9FQ3I0L2tKbUM4bjdCbE5xUVU1Ly8wdVhBNFRUeDBQ?=
 =?utf-8?B?YUVubVZ3WTBXRjJKbUl2UVlXVU9tQTBDeFNrRE9DNFJmZDRiSUxYK0h5M3Ay?=
 =?utf-8?B?Y1IyZFhaeVJtczVmK2VuVW5FSkNmblZoR1U0eDV2SnhOOTNPL05odEJUUGIz?=
 =?utf-8?B?ZWlGRW1MRGlIczFYWXFlb1NJbjl1WGRNSEpMeFIrcGlEVUJyelV6czh3YW9s?=
 =?utf-8?B?NEJBSG1ReUNrSEMveTV0MHVhempaWjZQV1p3R3F5b3hNbk1oWFBpcVJJYkdJ?=
 =?utf-8?B?a0Q0MUhVVHRXcXVGNkwwcFhQUnJpMWlHNUNZOU1RM3VOVXZiVmhCY3hWUHlF?=
 =?utf-8?B?UGNyR000VEN4U25MUWVSSlB1TkR4ZlRBMVVXSi9qTUFlcUlDaEphR29jbDQ0?=
 =?utf-8?B?b2V3YUtTamIzTjh4UkpKaTlKbTBZT216QnR1OWxGay9ER1piZ1h3VFhhWjRW?=
 =?utf-8?B?MGRkUjVYU1E3TC82a1VQdnRNYjRJam5lSWxtY1Z3d2JNMk1zZy9DMFpyMHVY?=
 =?utf-8?B?MU5WbXU5OEhOL0Q5TmpzQWhzRVNuMXV2SGVNdTZPQ0phaU9hSFdFNnFITzBy?=
 =?utf-8?B?aWpZWUxneDdyb2xXY2J3MHNjSU9uTVIxVWlUWEZNZ3BEcjhUeHdnQy9lU3dq?=
 =?utf-8?B?a3Foc0U5V0loL3pqMW11RFhCaXYvTTdXWXM4dXJKSUpKTHBObDVxV1BhQXNl?=
 =?utf-8?B?ZHI1TjdocG9vL002VlBLd21VVDI1TlhPMUZ2M2srZGJPVUZaenVYTEhTd0NT?=
 =?utf-8?B?bGIranVqOEIvbU5FelBoMDdWNDRwc3lrR055V0xXYi9WOStPQjVCNnlpQTl5?=
 =?utf-8?B?ZkdLc2dnYmZlYUpMQURpdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE5wVzF6V1haWnA4eWJLWHFXUmhCNWh2NmRpYmE3bmw1T1FldVczUU9pNVoz?=
 =?utf-8?B?d25nUUpxRFBOVUFTVnk4SmlXVmt2SlRDUHRZNWJkZU1oSm90SEZ4RC9sSmpZ?=
 =?utf-8?B?V3ZMc2tjaUJZRzF6LzViUmdtZkxGdTY3TzAzNmVkS3ZnSk1haUx1VzdaQm1i?=
 =?utf-8?B?L3pTVkI1bEp6WmIzczE5cklPSi9obHhpaThyZ051VHRBUDlXRlhsWDlLWFFO?=
 =?utf-8?B?YjRoMHJIV1VXWmY0YzBPaUtwUnFBbExqZVc4RlMvUFB3dGlpZHgzaUZiS1dp?=
 =?utf-8?B?RWVTczJkLzRXdnZTRldMT3FucU1rNzBIV1owN1lpUzZUZDF5US9ZbHFLSldK?=
 =?utf-8?B?OExwQjF3M2QvQWhYcTZPQmdIYXNXd3AvSjRuK3dic1lsa2JMSEQxS3d5MDNW?=
 =?utf-8?B?aGwvR0wreWRzbXYzQ0VsOERzb0Q0TlZPaWgrRjlEUkZqSkZnRER3U0Z5TnlE?=
 =?utf-8?B?NTBteHgrS1RSTHhDTjZqQ3p3SU8zWmRucy9Nb1NOL0ZNeFM0eGFVbklSOHlZ?=
 =?utf-8?B?YmpkMStEWDRCRDF5bSs3dVFhUFdoSEx6WElnZXJPYkJxc1Q4T3AwNmNSSlFi?=
 =?utf-8?B?cnZsMFZ4N2hxaUtYdjN6RnM1U3ZqWkN0elF2SkEyc0xFc1M5V0tFdjlxb2pS?=
 =?utf-8?B?Y3phMjNQaElQSzRQcCtBZTRCZTRkS3loc0tvN2tDSDZWZEZZakZkby9uRFZR?=
 =?utf-8?B?dHdibWpQcjAwRCtSN0xQZmtqTmNOOVpIVTVUZ0RRUXlGdjFBUEducUpCTStu?=
 =?utf-8?B?SURLeG0ycVRuYUg3Rk16a2dDRkdPVXIvOUdTYjZPYmVvRjdSMzFzYWtPcDhL?=
 =?utf-8?B?dWlUbFhNQVdseXI4ZUNCVDJNNGJuQ05iUFRxMlRtd1owTEdROVJjaVhUeEFs?=
 =?utf-8?B?aXZLT2R1NU1YL0pDM2kxVFNMcXhYbWwrdUpGTU1pL29GWTdoeHlOZ21sVm4v?=
 =?utf-8?B?aGt5NW1VRVJ5VnUwOGczZjlyekFLRjNyRmpsWnF4QXdxQVlUWVB5UjNFOHRl?=
 =?utf-8?B?cUFDMkJoMjlEd0FraVk3WkE4eHJyeWRiRFNnRUdBNmNyYXlLTHVFYWVjNnlO?=
 =?utf-8?B?a2tzTEpZVW5ZTWtvMXVCbWlCb2dZaVc4QnBQK09zMkxUZW5uYnUvTEZnRTNr?=
 =?utf-8?B?ZmJzZDR3aUZzYml5SHQvZmo1dnRYNjdSck94QnF5Wm5zUzAwSTdFRWtPN1Vk?=
 =?utf-8?B?NFE1Z3NmMWFneUpyaXdMMXNwYjY0elFDc25yRDU1MmdNQTJCM2plSkcyRndE?=
 =?utf-8?B?a1N5bFFmNW83NVZOdGUyUVVIZndIdUNjWVYwbXNBdzF0Vm5NdGEvd2xHZ0lw?=
 =?utf-8?B?UDlXbkR0eFFJQmMrMVozN1RaWFVJMGl4azBuYUIwWk1ibDVYSHphOXppejZr?=
 =?utf-8?B?ZERWcWs5RHowVmltQUlSczhrTEhka29DelozbzhHSGRTSkQ5VW5zRGlSb1BY?=
 =?utf-8?B?NHRzMFpIRUlpZjZ3NkdNR3FuT1VEYXFBT0RMWTdFeWcrclY3UldFN1JYSHBW?=
 =?utf-8?B?bjc1eUxpaTFsak1ScUtJc0Jwb1BaN2tzaW9WcDNZakdVbTFUM2FCK2QvbG9I?=
 =?utf-8?B?ZWhhREJ4UXh4eWFva0xmYVpNclQrRHN2VVhCY0JiaDZpQWtLTUo3c3pZSUQz?=
 =?utf-8?B?NVlUOTJiN3lVaTh3M0UwS2JYcHFsL0k2ekh5a2hyZmIxcjd1ZERMbktNR09t?=
 =?utf-8?B?TFdIamtrc0lVK2dybE0yOFl0WEovYXBMWnd4STlLUFA4aWxVekp1dnhwdE5y?=
 =?utf-8?B?Rmw1RjNZVGF6TG5RL29PMUZ4TnFCRVVaME5zb085eVZwQkJzNk5YMTZQcXZh?=
 =?utf-8?B?REdwaFAwNXQxSDhjU09od2x1LzkvbXAzVHJ6V1pCMXRzNGUveTc3MkE2Wjk2?=
 =?utf-8?B?YmJPNDBoRFJKbDFZQWkzTUdvYWF3MVQ5YzZROXdGTlEzTkl5Z0JQcDJoaWVv?=
 =?utf-8?B?Z08vdVFSekdTRjdLeXNtYlZPWU5POW5lT3FnbjV1bFFkS3FnNGZ3R1BMRm5T?=
 =?utf-8?B?bmdMeUo5bStaUWVMYytuSjNBcXVRSjh2bEx1d0RYN0JkbFIrQ0Y3eTF1VVRh?=
 =?utf-8?B?VFdpWW9zSlpxdEdCamVJei8vcVkxMUF1U0RPOVFCaCt6bXV1clBsQVE1OFYx?=
 =?utf-8?B?YXhheURVYjFXYVRabmpwTlZoUnFNOUVUejBVTU1wZWo0YXdQd1F2STZwRjBh?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y+Spe4QqovjzfpY1ZwboMSqQ8pJcmuve2ZC38KG9GVG3h3PUzXRHnJBYJ2YbzsMdDINDzt5Osm2vf+6QmUYz/0opRnAeV7c+/mROwzgHPtQvBhj8Hzk74ifbvXKtzRS3hgh3jLWc33K+lcHq9Y0CLCJ9awEijpSOepvcq6FrzNLsKCj2zNLP79TdnHwqoMmgxxo4kGL2QZyMxYV1pEjP/qvSGgQ/Y7+i40mXuKnou54p3F9fuPXk10t0BsAJrlQQgAipZ4zoUXHCAqFHVRCBGPSlehTvbkfBVlLxWM4Lnes/QRHa7khy53/XBDaLrVXtXhS9lasEjsiKWN3U0BMTRf0e/KFTuFWfe8PHIQuXzkuXt6wph3VRunV0WLq+ZLAPEl4cLpc3m4o59I/px43lhJjFVlXcpeopxsQvQAqq8UGbwZAtWBBNChcGS0A9Rdez7XhspF/KpEJ+pOFFJKpT/p9lQ3xZoLtxfBO/6ovZE2e+HtPRk/uh+zWeas61fLPjGuURafjigxK+dhTy68bKTc2Hld077SxG4fAa7gS8H/wlsMQARmiVeGQKfqVasPKM+88r+sDo4/kJ2CWiClZ7PavBPmPFVH38aNW66l5+t/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4955449c-61a8-4192-5f75-08dc9ff50dc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:56:42.8739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1TnjZJzFMkMN3tVOdidjruF0AFqaIhJNsPr74vOh+WgC7/KdWDy75z6voC7TrfAMmDfLzaJG6U3iNbDLVUgSk6PdhSvsbw7aK9f+WRsaQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090059
X-Proofpoint-ORIG-GUID: zqhYdHS_bMK_BaOupxeS-afcxc4EYiFM
X-Proofpoint-GUID: zqhYdHS_bMK_BaOupxeS-afcxc4EYiFM
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

On 09/07/2024 07:20, Cédric Le Goater wrote:
> On 7/8/24 5:32 PM, Joao Martins wrote:
>> On 08/07/2024 16:28, Cédric Le Goater wrote:
>>> Hello Joao,
>>>
>>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>>> In preparation to implement auto domains have the attach function
>>>> return the errno it got during domain attach instead of a bool.
>>>>
>>>> -EINVAL is tracked to track domain incompatibilities, and decide whether
>>>> to create a new IOMMU domain.
>>>
>>> Please leave the return value as a bool unless there is a very
>>> good reason not to.
>>>
>>
>> Error* doesn't store the errno, and thus I can't actually test the number of
>> errno to know when to bail to the next hwpt. Maybe the commit message wasn't
>> clear enough there. But not sure if we have an alternative here? Or maybe Error
>> does store errno, and I totally missed it.
> 
> OK. Let's do the 'bool' -> 'int' change for iommufd_cdev_attach_ioas_hwpt().
> I see how it is used later on in the series.

Got it


