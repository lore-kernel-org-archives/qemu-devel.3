Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15898C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukMN9-0005Kb-3l; Fri, 08 Aug 2025 08:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ukMN7-0005HV-Na
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:38:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ukMN5-0004ha-Sz
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:38:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578COlqA021413;
 Fri, 8 Aug 2025 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fgVo9YjV5eLJGllNRfKVyam/RDFZGeRRDWS5B+VXDnQ=; b=
 puK87VrEt82FNQJ2qiHeXrnsspIJagc/2r7AyrrrwT4WarrKbPItB9n/DAX4BHro
 vZJHDGt+T2DloIy+a2XIvEVz46+JUixG5sdNu9MdbYFhiFrLjz+n5hHYFLj885OZ
 Vv6iyziWGqeAoItXIFu2gPjZvyYxMvd2KH/uYwe4QAUe1fL4iWeRczcAOQZO/jQb
 qF6ZrKjte8EJ5CINUgXfmKxlHntASvexvRaj8kWY67FdCxpKN/nuZ7mfRCKUNm8/
 7GWXvLcyQA8YxhKJ6h+ScRiUOvxUrFE5iOaH74n0eu2720R3ILmlSIkyjWp6Jzqr
 +ioLbVgZoYHpcDUduzV9MQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve66t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 12:38:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 578B7ZbS032053; Fri, 8 Aug 2025 12:38:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwt8e3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 12:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiEpU+kuKLNh5zRyVg2lMEFn4eaKLG4W0QriGROvbszNYfu5PqRMHOiaeVMEQUWiJKXUojjLwDF5hZ8+bQ85o4uavQP+RkVYzz9yCIaSiZF9iQw7bKuaQHXC2s6xik2fD8FYeQGHNzRY3jnNsAzxu6du0cO7ZEVi89A6ukhIK/YfovOwKL0OfMq0FjiyWbAmnHfsfMIoWhFm4ZQoZy9JdkZG41E765NhkqqfTion8PkolXAj9XKHqv3KSodp3W9dc4Q8dMBJ8fWZ8ASsYUHfYeR57FznVRkYHTPWVl+jLt48Ec1xCLUwvNZSTOZ1xVGE92bJ6Zw0i+rgTGN2AOio3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgVo9YjV5eLJGllNRfKVyam/RDFZGeRRDWS5B+VXDnQ=;
 b=oFQXkuN2ClWZRmhJyiZXg5ZupNzqZ6JFPkz6e0eisD3LNNuC7SUtj+0Amkf8Voyxl9O1G7vxAEDNmaPT0VAY4OWMaxEBHNGPuk3/91iO2Qj4NHJo9wL3IU7dIWA6DfStFozKD1wU56ogCakFv1Yvbcn7H8waXQgBXzZZG54DUm6DdJSyIWhmESA/3DcxeAxQ/rxHytFNibOwWK9raezevR3Ec4dF64sqZsDbm6aSym4OtVEMPtgSG6PTr2eSlTnkA19BQxubi6uMbWT+DoMb19Fcq79/0vULmDS+5w4koYjER+ztDZBNmUxP6C8OzGqgBkM4QvePngls+eTIHnLNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgVo9YjV5eLJGllNRfKVyam/RDFZGeRRDWS5B+VXDnQ=;
 b=Ww3TzEn16kMohLBIvE9FggfsqPqRuQ9UZbfMNNCAANW1VNQYjS4/W40UmcOb/0DKNPsIgCblNYnWZ2nnLs2zzbqYoLAktIKS4X+iwg/BlnSrY4ICQo9rtcpqMX90TtXtBRsbAX5ZAheip+JDov1GzKGeb4cfnm3l6WvV4ewOcEs=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by MW6PR10MB7613.namprd10.prod.outlook.com
 (2603:10b6:303:23b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 12:38:50 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 12:38:50 +0000
Message-ID: <6a6d33d9-c5d0-4b80-89aa-cad41a23e563@oracle.com>
Date: Fri, 8 Aug 2025 13:38:45 +0100
Subject: Re: [PATCH] vfio: Allow live migration with VFIO devices which use
 iommu dirty tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250808040914.19837-1-zhenzhong.duan@intel.com>
 <9202e1ea-7b83-4caa-85ab-7621413a50f2@oracle.com>
 <IA3PR11MB9136FA0497C10AD0234EEACB922FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <IA3PR11MB9136FA0497C10AD0234EEACB922FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|MW6PR10MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3e5196-c44a-487e-f228-08ddd678868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjJ2T3Zkd2Q5SlFaK3Q3WEJwNHJPaVpwS2h5d0tEa21mTWRDbUNza3BMc0xi?=
 =?utf-8?B?UGV6RURxSGhYNXFUNnJrOEZnbmM5dTZOM3AxL25FQ2hheUpPOVg3YVpwVWRZ?=
 =?utf-8?B?by9mM3dVZW52ZHlUNlZKak56dUZDQkdTaTRIUEthcjZKditEOWUxMm41NHBy?=
 =?utf-8?B?TWNteUFLQWM3TEJUbDlxNWZuTVhuN2FFbHZHMFJ5c2trR2cxZTFaNFZrYW1a?=
 =?utf-8?B?ZjJhck0yNHJiRURNVnRLaVEvalBMaVNZU0cwdHkwQ3NTT281UVpqMVRlQmJC?=
 =?utf-8?B?K3JaaytCTVZLbUVjZkU0V0d3ZWlWVFNGa3Z0QWZOVFplbmc1ZklMNHB0VUlm?=
 =?utf-8?B?VWNvTlVlWlR4WUJ4UmREMHJpbTVkU0JkVVQxKzZvaXFqaENMbXQ5VXJGbE1O?=
 =?utf-8?B?KzdNVENEMTZhN3pXaHVqb2F2YjVnTjNuc3Nka2VTeElFazhqSW9qeGx2Rnox?=
 =?utf-8?B?NHRGMkVvRFh3S0V3WVE0WEladXFmbE5mWkd6N2hvYkpTU0RhWndTNm5QQi9a?=
 =?utf-8?B?WGJObjdFdGJNUUMyaFlFaWRaWEVrdXEvZi85WDJhL1B6VFlNU0VKUThnZ1lt?=
 =?utf-8?B?RzVhT2tXWTdpL1Nvd2hkd3hkT1NDdy9ENWVab1dqMlN0dW5FTDdTWFpxQlNH?=
 =?utf-8?B?TU1sTVdRZ0dmRDk5a0ZieFR6K3lyNlFWM0hjVkVGdXpLTUdleEJJRkpFanlJ?=
 =?utf-8?B?TDkrZlo3MUhJQmhHMXBiNjZGUjZIVnEvR21UL1k0S3JKb3VxdjhMMVdPMSsx?=
 =?utf-8?B?L3E5WEF5Smg3RVJlRHVwbStLR0NtYW1md1l2YXNPRG4xYTZ5NW1XamRCR05t?=
 =?utf-8?B?V3pMK2RvLzBXV0pMMDNFYnJwVWxycERkM3p4T0ZPZnAxNjRzUFJyVm9zalB1?=
 =?utf-8?B?dDYyajd5QjJtYXhIdjg1WkJ5eW1ZdExnVEJUS0haTWcxSU9iOWpxMnA2Uzhl?=
 =?utf-8?B?YkE0SUVqcktuVkNSYzBVc1dlOUhPbUxCRnJacGRvZkFzbDFkWjVsTi9yL1NE?=
 =?utf-8?B?c21rR25JVG5aRlhzK0Y1Mzc1ZDFkS0RVdXZWUlBDMXdqdjQxOEpzTytEd3RR?=
 =?utf-8?B?ZElXa20wdW1UUUtIL002M3hXYnBmc3Y4ODJ0ZlV0TDRJVVpncWc0ckJ1TWVS?=
 =?utf-8?B?eXZWMzdIeW1YeE5IaUtHOUw4WW1tZVRhb0hSZ0Y0Z3lLS3FKMFluOERBWVpT?=
 =?utf-8?B?RHIyNkVKUWdndFEzMmxBMkFDMU84QUdQTDJwR0o4dmJCc1VSTUJCaXN1WkRF?=
 =?utf-8?B?UTNuck14c2lNdzNuK3VWcVoyai9JMVQ2YlhpSm45UGtBTitHczlESkZyRVZD?=
 =?utf-8?B?dEI4VWQyZ1F0RXB5cEkya0g0ZnpTdjExYjlyclBaQnp2bnU3QzJIaVdJcE1t?=
 =?utf-8?B?OC9VOHk0OXJRVEt3NnZUcXFEcS9pVkU5UGJMMWZQYnhNdmQzOHozM2JobkJ6?=
 =?utf-8?B?dC9KMUdqMzg1WUF5cGQxYWlZclhQajduaFhGUUFvVWo4SVRvNm5BcEVIQjg1?=
 =?utf-8?B?UWpyZnFLVGV4cExQRlFUQXdieUlMM05ZTUhTWlBUb0tiTWszY0JYeGxTMTk4?=
 =?utf-8?B?N29XdTlNTkN3SzRDVkcxak5XRHFVMjVDWE9oQWRNQVlZQmJTdW9USVZkbEMz?=
 =?utf-8?B?eUtRSTBpL2tqei9WTzVFcHk4c1Z0a2Y5U3RYb2I0OEVHamxuZ1d6NStlN2Fx?=
 =?utf-8?B?MkZEb1JLQkFDRGswcjNCYUNsQUtRY2VtVjVob1k4U2dUTVRzakVWMXo4MXpx?=
 =?utf-8?B?Q3RicHRsd1owNnBFenNES2RGaU5heG8zQTVmVmRvelZLcHNWNS9MeDVoQVRx?=
 =?utf-8?B?SzNZVEhES2ZkTE1LSTNDZzVhOHNRMnZHdEtaVXRxazdjWSsyelgrZFFQcXlu?=
 =?utf-8?B?SExYVVFCNGo1M1JuYkNZLzhKdURVeXM1Rjl2YjJOTjRWNzdRY2xMNjdNYUZy?=
 =?utf-8?Q?HeX17nuIdQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThmT2EvbXV6dzNlWGVNTE5jeklMZmRYTlJFRnpNQlFjcy9xcnFQVXpNQlAy?=
 =?utf-8?B?bVc2MXBkYkFBQW50UkxwL0NiTm53TDFyYTd4dlVTckQ4dXZYOFJjSVl6SWhG?=
 =?utf-8?B?Y2k3SUQvOHVXLzJ2Rks4RFAyYzhtYlZ5RGtqYy8yN2g2RFdhbWdsR0x1emt4?=
 =?utf-8?B?Y1ZhYWZRemxtdldMRU9UM1M4UnRKQ1picGI2VFYrb2tPSDJpSGxhOHExamxK?=
 =?utf-8?B?Nmc4NHBtb3I4RjVSR2NwcHFNVnI0K1BpaUR2VmY4d2Z3QndpNHBkWmEwL1Vp?=
 =?utf-8?B?d0NRSmsxNnNWalNqM2dhMkNJSUVodEhNdUxxUWRvZVRldU9iQkFZKy9kTXdv?=
 =?utf-8?B?b3NyM1kxVlFoRGcwZHhlLzRhYVI1ZVBsd21taXZYWVhsYjg4N3hvYzhOUVBi?=
 =?utf-8?B?TktJalFFcDNXbkgwWGZhbHlqdXAzMk5vNTVSMVdSSW5ndmJoeTZsbFpOVlZ2?=
 =?utf-8?B?aXBNbXV4YVNCNlp2OEo5R3h1RGM3dkxuR2RiMDU0WW10NnFMTld6Zm5wS3h6?=
 =?utf-8?B?dkZGL0NjNW9SekpmaTVXMjBrU2hHUUxVZ3lqQVhsdGRDRVpoYjkrWnhCd25S?=
 =?utf-8?B?bkJoc29VUmQyR1p5NHdHU3BLcENCc2FWZ0RTK0tBY0JQQUVCdjkvckJVcURu?=
 =?utf-8?B?cVNSLzl3TTR2Vmw1Q3JySTN6dVBlMXhFWGtkM0dBRi9mMndTKzBOam5PMGth?=
 =?utf-8?B?UVpnQ0xkcng0N1FBd3p4MERmRE5vSXVEbTlzSldSbkQxQ3lvQkwreXdRQjlJ?=
 =?utf-8?B?cjRmR0U5aTRUNmFSYit5S1I3NFNWU0d6RDRaY0dKaW5CNjRrcDF1ZVhtbDNk?=
 =?utf-8?B?U3ZFejQwMlc1R1lOYzU0ZzhsK242V3FNNEhCSWdFQ3IvaTVSN0VKbGtzWDNP?=
 =?utf-8?B?RzA0MjBlREhzMFJRNU1xSkZqZkl4c0tEOXJONjFraDlMc1JJMjRsOXoxRDJj?=
 =?utf-8?B?dTFTTlR4WjZZTjU2OGIzTXZmNWJzSFRReWN0ZEFKclBGdjVCQ2J0N0pzSVpI?=
 =?utf-8?B?aENoaCtweGZ5VWRNR0l0cjJ1Y1dyVkx1N2dBdlplWHB4dXNjTFcwdm04WHdR?=
 =?utf-8?B?UzV1eVBNZTNHZFB6MWxHWStOTFJ2aUZWUkxzT1R0Z1dlbm9VMWczd2pjVnR6?=
 =?utf-8?B?dnkya0xtcUFhZEVEamVPQ3BHNXZOQWJaZ3NwOXhobGtrc0JZbHJTQW5Gc1dI?=
 =?utf-8?B?c1QrbE1wcy9PTTBVcWdTd1R1elk5cnlrTllmakVQb0E0cHVINHFra3FJU3dH?=
 =?utf-8?B?dW9LeFpILzh6VUdVcDVuYnVLaUxMaUhWbW54UXVkU3NYZHoyMmxWQ1F0eWpl?=
 =?utf-8?B?bi9weVltbEp1UUQrR2htM2ZycXgyS0Q4VmFrTUVJUGJ0czg1bWdndnNxWmlM?=
 =?utf-8?B?WUtWTVBCZzh2T05qenhiRXRONkRmNFNHSlRtQTREdE9jeWw3ZVJVcXBDTDQ5?=
 =?utf-8?B?bmg2ZGpKZmxVNmZNZStUS3Y5NkRZdENOck8zUm8wL25tMG5aTzRwRGowTmV5?=
 =?utf-8?B?blZnYTRVZEZuSFBscndPSzFhcXVjTDJudCtkTW9QMkRoS2VmSjZlOFBsK0NH?=
 =?utf-8?B?YTNwTmZDbnZaNFF6ZFpwUlJOWThSRzdrWS9vUEdyTUFuS3RBd2VmS1JDUTAw?=
 =?utf-8?B?SnNBSzYzdFZwMXlqbzRNU2J5bEdZUm5KVEp1cExrMk1wQzlBY2tXbmdFUDF2?=
 =?utf-8?B?NUVaQ2FqNG9HVGtQL3NHUXVjanVNNTZRbzZKemcxVTl2c3JMNlNrNmttMUth?=
 =?utf-8?B?eDBlRE4wQU9qWWJjTWVJWUdka04rV3pVdUYram9FMlpmNGRXbjQ4QlNFN3Zn?=
 =?utf-8?B?dHk2bU95QTNwdjhsUUlNRW5Td3E2dHp1cnFrM05ZS2wyQ1F1bFN6Nm9mRmp6?=
 =?utf-8?B?MEM1dGZPZkJoZllSWmNwWG5kL1JtTVVyRGxUaHlubDMrT0tyUG1OdHNFTnho?=
 =?utf-8?B?OVBwT0tmWktyY2pERC9zQ0FaSUJtQzMyYmNrUkx2d2Y3YWkxWHhaa0ZvYzVK?=
 =?utf-8?B?WWw3S3p5K3JvWjhjK2hQdTAva1ZGSmJrOVVNeko0NlMydkhHdTNiNm5LMWVm?=
 =?utf-8?B?d2hBQkxpVmRuek1pelc4dGF0d2pIUGNXMDBqOXJwNVZicldTSjgrcC9XZXhT?=
 =?utf-8?B?K203ZURyQWNZSm5xb2FxRHA0bUNHKzBZQ002dGg0QXRGMW5ueGhzOUdrWWxx?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HxNcPzmgprJxvXo+PiOg1TJFPA5TfydfIKXLlHqpW4JB78Lk6Bp1boVCMwBW4eEUhgDXPPxDw6ii94aJL3SpRkI4iq4dw6fSFhNb1l/620Vdrwqh3Cws3eZ2c7J6hZp5Hp6oBY6wEqVW0S9dOpsxDWX3VgF4O++srHjJN5IXHFoFi5TEoZ1R+SlI71w1tqYeQHDP+skUxrlP8/3IWD+MMopSzY1YmcHyTuFH2ZXAcFk0yiQPMJyEl3ZXC7C1BPaubNni2ivTj6vZ0+g3p4X7GpnttdHRlBjkD2Z0meN5WVg2CA8+OrzoqAWwhzt3gwCehneX6CE0wNmcPSDsH/6ISK/aY1w4WOKQkWZYwHAvkRcrO6QcJA24+O+9iL8xaSb3ZBxDodlOviP1DA0tTC3GdljgzxVJ4G6NpWwNpX0jxXjza+PjC5XY9I3RDxeDCLrtdZGAuyUuUWTWpVYiW2aEHZk+Wzj+regEWi82CETOJfhMeFvhBv2FTDWDUowSVBEeqHKt7T7PwDqbCKUDltLGcTBuEd+JI/yKp8CpxvQf0NLPSr8mru62I8kMYFGaHdcJbZu6d/9ULzxoiS2DmjsxEo3ESWMKGjiLUdgfkDRBCJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3e5196-c44a-487e-f228-08ddd678868c
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:38:50.1335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoWxCOKICKGTEuanKZV3/2QLkAsUV2DhLkHVgVuYSNXR8uN55xscR/QNZEgMmrEfbxZJlgw+lqFegWEl9iT1k/8wrMiVvuPk5oxWYzChmWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEwMyBTYWx0ZWRfXxpSTd/ZYH4BG
 8Nm8rWfsfhbugorMHgynDctMXLk4KDMx2TpM8vzz5ewyTlF5J6ooWXm1OOkFSJy0/J7zbCdGlY4
 H674vQw1Ac/xYkcpdosS6QpiX7cDHwgv4d0BxkPVXkU8mgoUMNIe9MfPiGH9l1Kw3VKprwJmrE4
 kV5Bvvc01WFPuFTMxYcFbMjwgifdx2HOQAavNE66BvvJYLv8tHoUT9XevZ0GCbuilVyxCYRQrPo
 5xWxvGQPruwwMFSS15aj999GNUN9I8IyuGkE18A7MBg2B1YMy1WYFK/9fOmF1R0Na8Z43CvU0wR
 u9sKR4VHmFuKyXMhqrfLNXrQtDicCdPEFK1JzY/rN1WyHXmS38zFfkuSRL0Xb9ue2BzhW58x+eN
 S3cmP6gjKKgN52bw9MyH6e82pd2HqIjL2tMZ6XmOJKfLgZ87DQROlga5ffHq/NNwZttAsKO1
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=6895efdd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8
 a=ZEY5637gxsA_7r0AVtQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: RaijUlaxJCFgRTimDGxHWbTpVB-cLcWt
X-Proofpoint-GUID: RaijUlaxJCFgRTimDGxHWbTpVB-cLcWt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 08/08/2025 11:06, Duan, Zhenzhong wrote:
>>> Introduce a helper vfio_device_dirty_pages_disabled() to facilicate it.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> This is unfortunately not enough to unblock vIOMMU migration with
>> IOMMUs.
>> Have a look at the first four patches of this series:
>>
>> 	https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/
>>
>> These 4 are meant do this (41d778dda00^..d27e5a5db5f4). Feel free to pick
>> them
>> up. I hope to take care of the rest of the series; though I have been heavily
>> preempted internally that I hadn't had the time to clear this series but I think
>> it's finally coming to an end
> 
> Thanks, that help much, we have internal team in intel needing this relax with
> vIOMMU enabled.
> I'll pick your first 4 patches with mine and send an update.
> 

OK

>>
>> The gist of these first four patches is essentially that we need to query the
>> dirty bitmap before unmap, and we have an extra optimization that let us
>> simply
>> read the Dirty bit (without clearing it) and so the query is much faster as you
>> don't have a TLB flush.
> 
> I see the legacy backend use dma_unmap_bitmap to do the same thing in one ioctl(),
> will you add that support in kernel?
> IIUC, between query and unmap, there is a window in which we will miss dirty pages
> if a buggy guest still raises DMA.
> 

No. My first version of the kernel patches had something like this (but not
quite done fully correctly), but we deliberately not handle it and we accepted
that race ... as it was a theoretical use-case and not worth the cost/complexity
it would bring i.e. we would have to write protect the IOPTE, flush, then read
the dirty bits and then unmap (for something we are not aware it exists).

See commit 609848132c71 ("iommufd: Add a flag to skip clearing of IOPTE dirty")
for the history and inside there's a link to the thread to the discussion.

This flag is meant to make it easier to get dirty bits given the next operation
is the unmap which will do TLB flush (and also destroy the dirty bit).

	Joao

