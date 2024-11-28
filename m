Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06541D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjH1-0003jE-5p; Thu, 28 Nov 2024 13:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tGjGy-0003io-Nv
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:29:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tGjGw-0008CA-4d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:29:52 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASE63Z4028021;
 Thu, 28 Nov 2024 18:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=KysSZmW5IvEgw7p7vGPBO1I4xUPyxJKcQwTfe/ZA7J0=; b=
 DOKE3t0JUgin3FX1f+orZ5oqbvGLf1UZVU3+ivnTYEwAIA9kN172/9xlpVxCD5FE
 r3wrqHGZdeP+Lut44mP1TkpK7rXxGLFfjI3Rb73k9cFNL2gnCqfl5qLiaI2jj3Q/
 javLU+0im4lwJRs+p4Ra5EjhIJqdRPe3d7uoH9nx04WnHva1dv/gXEUldBigiWO1
 SyHoTeY9ayea62ZIJkKLJ9CvmAEgeoo8KBolRARKHwIvQS9NF0hXZ4hGb4RXHliP
 k79h7Lr0aZMhn+gkDg5LY6MsURSLr8w5XUCQayb/mprrfVpdwghfUCDHwqM0YyoE
 M+KewVhzYKAFCXfDeU8qLg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xwa8bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2024 18:29:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4ASI4pmG027476; Thu, 28 Nov 2024 18:29:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 436704c1ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2024 18:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h74qJ+oGLNijDjYdbXZvlBfXnUVcbnnTKVrAV2x+x4bwZ0y8BKrOusrqS9pG4L0j4eC9qlEAvowAQsLDkK/Zqnh9zI7y9amrA6/RqLiIdrzHpkcVdhRiprkOi4TKa7JNZ/7NKUAyCHhFZUio93zDpWEpsVIeWmKNt8fqb0bFMg3iZuS7y+im6BxoSnXwnZ2cmhX13s0Ox3dzI+QXFlYXL8EW9He+MqBTRZgczkxUBGiAyT7EWfY+fmMPHcBRyNudoqww7ZhjBu/nap6KhNWQ03NFI59L6q/As8piiEuwI0T+E5djJ3uwbSTIcvbkK+yXAnnp/UciIGBa38W9poG/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KysSZmW5IvEgw7p7vGPBO1I4xUPyxJKcQwTfe/ZA7J0=;
 b=Y5SOfo/lOxPlZkUyHf8v9ZZI5+63Zf9UhJEqnuHLKJCiKg+OK8Tp2pt90g1M3fwk/Dg6rKn4EKxTVRX/DDWQuEWUJp88NfbDb2xMSqcPDGWNiTG7qCxMIZVO6CEbO/QZeRBcSVt8AAyPB05JFt5W+KQwMGjcfICyHub2Oq83/zvs+HGP18i1AWWE0hOzY+v5KptWBPimnEFllzFi0Rl9EU6zoQrmXTlyyNTGMnPWx6/4PfIKmjLWMfg00rJ4Y/i0xLQdPytFJZhwGwKsT52I2Dz1wpeeDztV/pv/NWXrZkTGEcxrbJd2jnC6YYFEsUpubt9xKx2Ddj+ZeM7wZHGbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KysSZmW5IvEgw7p7vGPBO1I4xUPyxJKcQwTfe/ZA7J0=;
 b=VpftvgvbukCmEYTrfn4+NBaaZV3M5OOt35KBVQif9v925NTgeINRwiIzQ7dH3a8csIP6jq1pv7ZCGqT+U2azVcjiqUdr4ZxRxSuMOyKiI8SUHrGkSwhmj7PGBMSs/pTYg5ifG9IGOdnnid6Ld8XWd/b+U+a5KQPMb34faZ49KRg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 18:29:40 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8182.019; Thu, 28 Nov 2024
 18:29:39 +0000
Message-ID: <021568bc-6463-43a2-9312-12417c7be558@oracle.com>
Date: Thu, 28 Nov 2024 18:29:33 +0000
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <CAMj5Bki5gaHrOnj=JSrv3nmva6N2Y2OrDB7sE03WQHkqyXSheQ@mail.gmail.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <CAMj5Bki5gaHrOnj=JSrv3nmva6N2Y2OrDB7sE03WQHkqyXSheQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0258.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: fd001dff-8d0f-40f7-ddbd-08dd0fda9e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rit3VnpFT1FkOWlRemJMUndkNysrR3dlY041M1VaUXdVbjJ2czFKWmJZWlR5?=
 =?utf-8?B?THFaN002SGFrbFppc3N2dHZ2UFJ5eFBBaTVkTjluWTlEMlFyN2FoQ0d1cEY5?=
 =?utf-8?B?KzNxL0xyQ2VMMnNWaG1WL2lYeGtOc0dCZXpWUDRpKzcvNVBGTTVFYlE4aHFt?=
 =?utf-8?B?bVZiREliYjZyc2JpT2JmVnlPVkhEaG9vU0Nra0FzdHR5TFM0ZFRYMFpBd0sy?=
 =?utf-8?B?dmd0ems3RkdaU3lqc2FnZVNNQ1UvcHMyUUp0dnpOUlEzNlVkVXVPN0pVaE9B?=
 =?utf-8?B?SGhFbzZEbFdSRzRRTDVwRlN2MkhvbGl0Q3lUdnppYVNmREhNT0FwYzBhbzcw?=
 =?utf-8?B?elIxZ2J5TVVwMjZCamczUTVLbXdRSVJibmtKMjdrcXhHWFoyZFppOHN6d2Yz?=
 =?utf-8?B?TS9BTnpEUlJHbGVjM3RwdjZoelY5RTZJK1B2dTBnUks1d2pRVTZHZURxSjBR?=
 =?utf-8?B?aUFsZllhTk5VeWR6Z2ozVkZRS2NWS1VldG53eEU3a0lFdUQrR2pvZEg5ZVh1?=
 =?utf-8?B?YUZuc2hrQjE5dCtmRjJ0QVR1czBiMjFUelpnSGZqMUJZV2ZwRytDYjRLZE9h?=
 =?utf-8?B?ZFNHV2J0NzRhbG9VMGxlQXdoaFp1RnUreGtNWkQ0NnN2NWRMLzJ1Q2dYcWJE?=
 =?utf-8?B?aW1lRFJGWkZjUnJHdjU2V2d0UHdGbnFYTVZoYXRJVlZTbnhhTVBBVEd1ZmQ5?=
 =?utf-8?B?cDlpdjRkUldoaUEwUnFBc1NEckdhVVVTREdrRWJDbzh2MGhSNHMzMEo0ZVJu?=
 =?utf-8?B?ejd2LzJnR2pZY1lvQ0MzREhnOEc2MHp4SDFLUVhBaGFsb3k2ekkvQVZ0eitr?=
 =?utf-8?B?QzZPWlEzWmRwMS96V0dtOFdKeG85d3dUVGxvM1ZvNnRFN25qUWx0SFJDeW5a?=
 =?utf-8?B?Ulhob2RhSlJmbDhKS2NYc3BFejF3RnBBZGlLM3Y1NnBHc2tXTCtqajVwRUgr?=
 =?utf-8?B?aUJYVHUyL3V1ODFlT2Z4K0lUOHBSdjJiNUEvSlpjaU1kb0xQVmJpdzg1YUhw?=
 =?utf-8?B?QnRRNDhVSmZZQ0h2NXQ1ZysyeCtHcGRXbG5pNmNxQ04yOCtJTEhQMEdIb0Jq?=
 =?utf-8?B?SHB4dGdZRFZwYUJmbEdTKzZVTlRmWDVQd0xxYlFHTkZ5U1hpNG1QcWRtVkNi?=
 =?utf-8?B?UFYyOVFKa3N5eDZ6Mjg4b2dqOEVSSlNUb2cxVmNHSVpWTk9GMXJzSk90MG9y?=
 =?utf-8?B?L0hicVY5RldKSU9JTEJDM3l6czJJKzhlOTQ5ZzZjQVo5WkhZTC8yZldlUnIw?=
 =?utf-8?B?V0Y5Sm93dGxHbEdHWmdxM1Q2UlpQSnF4eEQwVG5PL21JYnF6blU1SHpna2p2?=
 =?utf-8?B?RzZDSW5qSlNhcXlSa2EyNFhVcHVsdTVrU0djQXN0NG5aSXovNEZYczI5R0I4?=
 =?utf-8?B?ZGxIK0U1aFhyaVhSUy8ybnQ5ck45YkUxSUcwallRcnNmRDRMQWdIRzBEaity?=
 =?utf-8?B?dWVMeVVNckUxQzFPSWhibzJxc0VyMGZYUHpsRXdJK2FyT2l4OU1IRm42TnJK?=
 =?utf-8?B?dFlIaExOKzlvc3AzdHptNkswNi9LOExIS1I0a2xYMkdkMVFGd1p0NEs3bldS?=
 =?utf-8?B?czJ2VjFvZnlOdzc1Mnc0d0wrSnFlb3JFNEF6ZkdtcUdTVUlOeWtFTlAzTlJz?=
 =?utf-8?B?ZzRQVnJ4T2NMTEVkNVBmb0I4b1J0T0JlMmFrZTVMQStsNDFNVEFDUUJEd1NW?=
 =?utf-8?B?SUxQK09Da0M1d3hjKzFTbld3Tk1QOW9OQy9ZZjdkS0J2b2c3UjQrVlpBQVRu?=
 =?utf-8?Q?C/m2vxXtRj8/FR4wt+G4bIK/lgsR44cr6JjUDX0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVJNGtiUjFCaXRhYUQxdEM0dGh1V0lmL3NwWDlQQTc4ZDFVM3J1Mm4zcmwz?=
 =?utf-8?B?V1A1VE9tNElnUU8ydFJYVm9keFJzYlhGS2ROY0xrQS9DdnhWek1KUDBoMTRO?=
 =?utf-8?B?eFlZbnYxb0FORVFpM0FheURka1lENFlTaUFha0MwRVhyWnJNaGJodWEzNjJT?=
 =?utf-8?B?VlVuODkvT3YzM0taeFN0bU11MWlyUC9mUWNhWnR2TFFnNVE1UXYzQkdHOXpN?=
 =?utf-8?B?L2gvdWlZUHlQY3FUV084WHNsWDMwMzBVMjF4VVlncXFmc1k4NWFXczBVUTRS?=
 =?utf-8?B?aVBjLzNTM2lKYk1RZUkwV1NoZWJTZ3lwNmZPcmU3T0hqdWJzb3dsT0ZSd0VE?=
 =?utf-8?B?ekJoR0ZLY2ExYk05MnlJL3IvS0dzR0ZDaERJN0ZHeVpFay9lYUFrQ2ZEakpn?=
 =?utf-8?B?UGZ1R3lldXlPS0oxYURCMkhwcWpkT0NWSWh2OVlERTMrc2hSZk5sdEZvRXpp?=
 =?utf-8?B?dmkzbkJHc2lxeGswK2dTSTdEbktQblN2Z00zSDRGOVlNY3E4K09OM0NvUXh2?=
 =?utf-8?B?dHlnWlgreGJBK1VKRC9aWWlObm9KREUzaFFCVnBidmd2VVNDSEplK2VtMm9z?=
 =?utf-8?B?Qk5oa2xmaUJua3d5RXdPY0NjbGhRZWV2Q0dKSFNSVmNvZnFEd0pXU0FxM2lz?=
 =?utf-8?B?bkdrc2lsS05Rb0VTNTYwcS9zYXI0ZVRteThlNWFBTWdWV3NhNXZQRmd4ZFdx?=
 =?utf-8?B?Vm9iN0k2SjBNMjNGaTN1WEdIdFdLR1V6OXRhY1RVOVBSMzJURTFqTStMeUFY?=
 =?utf-8?B?bE95R01OWU9qZG9TTkVOY2QzQVN6d29HR0tHczk3aTFHWkdkeEhpN2tJa3p4?=
 =?utf-8?B?YjBIOEdvU1ZzZXZYUlhzaUlOUW50Y25CNkNiTXE1SjNmR3JYdUNMcm1BbHUw?=
 =?utf-8?B?QXphbVdJQ2lEalpoL24yUjk5ckJMWEswb3VrcDN6ZnVuelYranAxN0RHOVFH?=
 =?utf-8?B?bWh2WTkwVXZPMXQybHJkUFFHamVXMTVZeWNkZCtOZ0F0QVl4NFFIckgwSmtI?=
 =?utf-8?B?YVpTTjRsWjFnWjcrWUJ6K09XVnoxWVRXamFPam1LODVCOHhLMGZvNFFxS0RK?=
 =?utf-8?B?V2JhMXFzMDdxYURxQzFaN2NSNGNFYk5BaXBLeElMenRrSGhxeVVhMXowZTRO?=
 =?utf-8?B?L3JnNjZscVVUNUphNGpQc01sdjZMbnV3RG9tb2V2UldZbGtaUmhwVmpXZXNv?=
 =?utf-8?B?ZGR2bDM0bXVrdC9lbzBPdHJheThSTmoxWHE5a095QTJybklTQzBGZHpKWXdJ?=
 =?utf-8?B?aFhZMjU0SjhkY2hrSVpITTNEdlR4WDhXb0Jpd21IbjVsN1cvS3lUSytrOTV2?=
 =?utf-8?B?RkhOeFUwN0E5V05ncjZIT09VU3hQRDZRSXhGS29NTUlyYmFJTWZKTkg4SllV?=
 =?utf-8?B?SGJnTjNrYk1xaGFJRUROalJIYldOclRZUytEOG1VZmpaR3dpaEhZcmE1c0U1?=
 =?utf-8?B?R0JWTXZ5SDZJdWtsbFpKbEpoT2poZUVmR3Eyd1BILzdIVjFNV3lTSi9jdlYx?=
 =?utf-8?B?WHJMd200bDR1elFvNmRJd3dGdS8yV2dvQUpoSkN3ZW1OQVArRGdkQTVhM1dT?=
 =?utf-8?B?ajB1cTJGbXM1Q0lKblJJUnNQend0N0lhNk8zMVgxWkptTFIzT2x2Zk5rNXBS?=
 =?utf-8?B?Q1ZnVURHUWpKK3V1blc3aEpSSWJwMWZDb1J0NUtaZVB1SDhxZUU0Tm4yeDYw?=
 =?utf-8?B?VFZqQmorbG9SUCt5WjBOZVlDRXFjL2Y1dEpNUWpObTFqbjFXdk5Vd1F4OFQw?=
 =?utf-8?B?L3h2MEI3NDBpdHhtMVVtbDFzd09pOUxtRFo3YmxNaTdBZHJHdFZqeDlmc2tU?=
 =?utf-8?B?eDRJTUFSanJuSWY1cTNId3FlamgxbmZoM3FoZjBRL05rS093dDdwU2lpYjh5?=
 =?utf-8?B?aHZUY29hbDZ2TnJXQW9vb0FnclVhZkpHN1FvZkFrempTSWhwako3dys2RVVH?=
 =?utf-8?B?RGFTSVRvUVFDaEFYTkxvb3FxZ0YzamE3S090TnZlcENhUElIbFF0dS9GTE5O?=
 =?utf-8?B?RTdNR0tyVUpqU0RxMGRYZ01VS1ZJaTdJck9sdk5pTUhuT1MyYjBMTERpZmxi?=
 =?utf-8?B?ZkJMcStXMjVaNm9abnRLL2k2N2tTb2RHNGNTdmhidkh5TTRlYk1LenFnMkxY?=
 =?utf-8?B?clpZWS9Fc01LVlU2c0tGOSs1OUp5cnFHK3JjMjRUZUZzb1hBeUVZS29NaWxI?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O325gMgIbvaVBW2+wY14lhpFUUADBgS/ujisRUvayWq6AVso/XCpMf8Hhsf3NR6sQbGYX/ZWdbAOZzWxHjXk4pgpEPKqngPbzSuvMsVmwCYTZzsnwhR2/r8M+cqWLnfFGxHQcvz407r3XUqIwP5hF+PsKUk4VVaA0B9exVfOJDJdC0GjCggCQJy+WQU2lyZfKMoX+WmhNXkiTowhcExSFRp0hlUS5Lz1Q5nnOxUYVlfHH41RKgAe8COKZ8OtxHyALUndDSNowflB802VRhWI+fV0qSYIhBNToF28XBeXn8q8Qv7t6U4gd/XagvUIpoQgaieOt5zTeh20naJcI4jGeKqAWourYI33fTyyS/fIZ0fLJOH9fBu+fwW/ZUtBZF4zG9+DILlwHU1TAiRedCeAMcbEBpZwuOvTMeaNmnzLeqIOAfTrLDnhhbogfD5RaUIJJdc4UQIKlLjKqA2rIgOpI7efkH4yML53R6lHIJ5L+mQIPbPMAYcFZjufMSus4+E89cMgp368eOnLs13sL7sPiDynK/hD8/y3DPqPE+fTQHiYOg+6siJNBpHFn7E5irdS0DgPNV2a7kyMqL6GnmlKsAN+btNEZTfsoVIg1yG73zU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd001dff-8d0f-40f7-ddbd-08dd0fda9e4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:29:39.2379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6hqlaD+8P/sxHNsh9+hguIwABty/GreC7ol9fOruzmhgoFPI1XfAtVB4Obo/RaOW2aHrD2jVxwRR2ZTRIYOGnpkNmk3SkOQo094XD0top4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280146
X-Proofpoint-GUID: bo0RCyx6E81qvug6r-Y8ULqSJjCPH2wk
X-Proofpoint-ORIG-GUID: bo0RCyx6E81qvug6r-Y8ULqSJjCPH2wk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/11/2024 03:19, Zhangfei Gao wrote:
> Hi, Joao
> 
> On Fri, Jun 23, 2023 at 5:51 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Hey,
>>
>> This series introduces support for vIOMMU with VFIO device migration,
>> particurlarly related to how we do the dirty page tracking.
>>
>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>> provide dma translation services for guests to provide some form of
>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>> and remove the migration blocker when vIOMMU is present provided the
>> conditions are met. I have both use-cases here in one series, but I am happy
>> to tackle them in separate series.
>>
>> As I found out we don't necessarily need to expose the whole vIOMMU
>> functionality in order to just support interrupt remapping. x86 IOMMUs
>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>> can instantiate a IOMMU just for interrupt remapping without needing to
>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>> the same, but Linux doesn't quite support the IR-only part there yet,
>> only intel-iommu.
>>
>> The series is organized as following:
>>
>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>> establishes their first DMA mapping via the vIOMMU. So these first four
>> patches add a way for vIOMMUs to be asked of their properties at start
>> of day. I choose the least churn possible way for now (as opposed to a
>> treewide conversion) and allow easy conversion a posteriori. As
>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>> was doing in v3.
>>
>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>> DMA translation allowed. Today the 'dma-translation' attribute is
>> x86-iommu only, but the way this series is structured nothing stops from
>> other vIOMMUs supporting it too as long as they use
>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>> we've then tackled item (1) of the second paragraph.
>>
>> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
>> IOVA address space, leveraging the logic we use to compose the dirty ranges.
>> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
>> addressing limits. This tackles item (2). So far I mainly use it with
>> intel-iommu, although I have a small set of patches for virtio-iommu per
>> Alex's suggestion in v2.
>>
>> Comments, suggestions welcome. Thanks for the review!
>>
>> Regards,
>>         Joao
>>
>> Changes since v3[8]:
>> * Pick up Yi's patches[5][6], and rework the first four patches.
>>   These are a bit better splitted, and make the new iommu_ops *optional*
>>   as opposed to a treewide conversion. Rather than returning an IOMMU MR
>>   and let VFIO operate on it to fetch attributes, we instead let the
>>   underlying IOMMU driver fetch the desired IOMMU MR and ask for the
>>   desired IOMMU attribute. Callers only care about PCI Device backing
>>   vIOMMU attributes regardless of its topology/association. (Peter Xu)
>>   These patches are a bit better splitted compared to original ones,
>>   and I've kept all the same authorship and note the changes from
>>   original where applicable.
>> * Because of the rework of the first four patches, switch to
>>   individual attributes in the VFIOSpace that track dma_translation
>>   and the max_iova. All are expected to be unused when zero to retain
>>   the defaults of today in common code.
>> * Improve the migration blocker message of the last patch to be
>>   more obvious that vIOMMU migration blocker is added when no vIOMMU
>>   address space limits are advertised. (Patch 15)
>> * Cast to uintptr_t in IOMMUAttr data in intel-iommu (Philippe).
>> * Switch to MAKE_64BIT_MASK() instead of plain left shift (Philippe).
>> * Change diffstat of patches with scripts/git.orderfile (Philippe).
>>
>> Changes since v2[3]:
>> * New patches 1-9 to be able to handle vIOMMUs without DMA translation, and
>> introduce ways to know various IOMMU model attributes via the IOMMU MR. This
>> is partly meant to address a comment in previous versions where we can't
>> access the IOMMU MR prior to the DMA mapping happening. Before this series
>> vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by the
>> guest. As well as better tackling of the IOMMU usage for interrupt-remapping
>> only purposes.
>> * Dropped Peter Xu ack on patch 9 given that the code changed a bit.
>> * Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers.
>> * The patches that existed in v2 of vIOMMU dirty tracking, are mostly
>> * untouched, except patch 12 which was greatly simplified.
>>
>> Changes since v1[4]:
>> - Rebased on latest master branch. As part of it, made some changes in
>>   pre-copy to adjust it to Juan's new patches:
>>   1. Added a new patch that passes threshold_size parameter to
>>      .state_pending_{estimate,exact}() handlers.
>>   2. Added a new patch that refactors vfio_save_block().
>>   3. Changed the pre-copy patch to cache and report pending pre-copy
>>      size in the .state_pending_estimate() handler.
>> - Removed unnecessary P2P code. This should be added later on when P2P
>>   support is added. (Alex)
>> - Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
>>   (patch #11). (Alex)
>> - Stored vfio_devices_all_device_dirty_tracking()'s value in a local
>>   variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
>> - Refactored the viommu device dirty tracking ranges creation code to
>>   make it clearer (patch #15).
>> - Changed overflow check in vfio_iommu_range_is_device_tracked() to
>>   emphasize that we specifically check for 2^64 wrap around (patch #15).
>> - Added R-bs / Acks.
>>
>> [0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
>> [1] https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a3b@oracle.com/
>> [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
>> [3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
>> [4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvidia.com/
>> [5] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>> [6] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
>> [7] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/
>> [8] https://lore.kernel.org/qemu-devel/20230530175937.24202-1-joao.m.martins@oracle.com/
>>
>> Avihai Horon (4):
>>   memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
>>   intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
>>   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>>   vfio/common: Optimize device dirty page tracking with vIOMMU
>>
>> Joao Martins (7):
>>   memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
>>   intel-iommu: Implement get_attr() method
>>   vfio/common: Track whether DMA Translation is enabled on the vIOMMU
>>   vfio/common: Relax vIOMMU detection when DMA translation is off
>>   vfio/common: Move dirty tracking ranges update to helper
>>   vfio/common: Support device dirty page tracking with vIOMMU
>>   vfio/common: Block migration with vIOMMUs without address width limits
>>
>> Yi Liu (4):
>>   hw/pci: Add a pci_setup_iommu_ops() helper
>>   hw/pci: Refactor pci_device_iommu_address_space()
>>   hw/pci: Introduce pci_device_iommu_get_attr()
>>   intel-iommu: Switch to pci_setup_iommu_ops()
>>
> 
> Would you mind pointing to the github address?
> I have some conflicts, and the github will be much helpful.

Yeap, I have a series -- picking up from Cedric's rebase since 9.1 soft freeze
-- but testing is still in progress.

Give me a couple days and I'll respond here as there's a little more changes on
top (now that we have IOMMUFD support) will get for v5.

