Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23929C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWALe-0005uo-H4; Tue, 23 Jul 2024 03:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWALb-0005rJ-Cl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:54:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWALX-0002gO-TF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:54:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BVMF031768;
 Tue, 23 Jul 2024 07:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=4TvBIa2P0pdPd210eZ8ooYOc4dvh1ILb+07XzN2evK4=; b=
 aB/mpKnMSM3i+QrY/K794TVk5hTu/1vgChgQ6JJxV+yQbjkjl94bMMqfrdG8osgs
 RnQxXt0yzKpYzH5rx3dejzf3DFPQJTlTdPs9lMEYWot9UwdzH6CGe8v1Nl08ARmr
 aSlMAwgSyR/zL2juM4Iz+hq7lLjjl6mxgh9Dj1v+NL9bNrZ3rbJupd7uHH2xy+v9
 qyDZi+e6jdDiB5EbKgYkDje4X2Ty/3PYdBqYvKn3P3Wjsfdo24Vq2gMwVYFKAOKT
 qlQ3Z76DtnxliE0e6iQQRVhIUY0usKOr91RzMjixNA6eKk+xyawXLitcmgdd+wuJ
 DEGuA53f157+jxt09AmQQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10wc5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 07:54:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N7JIWZ040387; Tue, 23 Jul 2024 07:54:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h26m3a56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 07:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZpheS24MzWnQUo78Yl0ZDsoPg3VPbc33L5QJlP8AdJaSGLTGNk9+4TiIOEvd8lu9N9Xuh0j0YNcnSzPcgtjG3+Cpsmug5BJcGb/VGfj9YcRQfmJ8wPSPuluLm1n3Zaxpfrb234lTWgBauCxOYi2hMsbA+tDxbtCDTWQCUAYlfIkfvdHVlHVONCklMpeSFyR43bnBIgbZzz7LTv1BUmk7ANqQwTn3xS3/XechrWG2cz4K8dRJNbUbo1M5wF7iwtqnJvc/bu84UbcaZnJzAGDya3mrYzA0iYk2UtZsdqmCLGqFsZuVDSGkg5GFKjRHRAUsbbEO6CEiUyoQUJsby8P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TvBIa2P0pdPd210eZ8ooYOc4dvh1ILb+07XzN2evK4=;
 b=N840kIYE1Wh/bxaoxL8C3Ib+ONsU5D3f4VUcZSLQUXDT+Osz1xBBur5sTL1at/QX3+QdhHPC51bZPcKJ+VjVJqlTuvfD8pfEmjMDNxHq0wcR+oNT2puNtQcAOsf+s1o4AzYEc96E7tj7gCNkCwlMQVMu4kRRGpFid+/3/73dvpfvArOKMYsSqgHbm413tDSxidi5pw4qITGkre3qoPMjcaZoq2w7q4q5xPesZXJ7A5urT1Y+lWu67cdneX+xLlwJBK4h3cWBXVpUD995JJloEo/rbgYa16s6sH4I24CjpMgU4fk+uT08U8bz2hJy7FO9U6h1Z5+PZ/0OI1hAVsRjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TvBIa2P0pdPd210eZ8ooYOc4dvh1ILb+07XzN2evK4=;
 b=Z9Xsyf5Thfof4eemmUCjwhQI3a6eqHno1ZqDHvqIwmjQCEC/aXHHAyQEJQHNBiJC8iqdsTYWd9ElASOaBmdFnrbCOjnTcGaQ1HW3S9BnPfptYszN12uYkmCisA2sWkKfiNUjK53WufTzUYfeU8z2Qm87WUUxF87aBvnzng4rxTg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 07:54:00 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 07:54:00 +0000
Message-ID: <5baed252-aea8-4ce4-b05d-1d9505a7bb41@oracle.com>
Date: Tue, 23 Jul 2024 08:53:49 +0100
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
To: Cedric Le Goater <clg@redhat.com>, eric.auger@redhat.com,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: add04957-11a3-4e64-83c8-08dcaaec9cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3JkVXNuelh0bFVWazhEUy9uMHNKOGtoeEl5Nnl4Z3Q3VFpQSzBoek1MaHNk?=
 =?utf-8?B?R0pPT0wwWlZhVXI2a1d1czhITWtKUkpxMm1UR29zWERqSFIxSmgxbGZLb2k0?=
 =?utf-8?B?QXVRMzR5V0FraW0reS84L3lkR2w5NHg2R0toVlhkOWFUMHptYW5QUXBCNUpl?=
 =?utf-8?B?eUtMa2pnVFBiRXZlL09WVU11a3d3dTRPRWFvQVIvYU5vRndlNVNqaUZFeHBp?=
 =?utf-8?B?UlZnQzFmTHRRWmhzdmpFWFlBY3hjcVFZRWZJMnluS2VHczhEWHN2ODZOakhK?=
 =?utf-8?B?SVVBRENFQzYrR3dOY2VTMG1zWnB1Y0VhOHFXSlNpck0rMC9IUXlpdU9lME5T?=
 =?utf-8?B?U1I0dzEzdnViS00vcnBndXEwTmVLSUQyYUkzWFNxVTcwbENEdkQ1TmlxUG5F?=
 =?utf-8?B?czlhOENHMW54QUVMcHA2VHJYblZMNnc2blF2UkMwK2NCSUdGT0NsTUVHWFhT?=
 =?utf-8?B?Rm1LRE5OUURHRklCelBwdWk0WmpmcjZma3RwT25wMnFjWFZFSWU3MUlUQzNG?=
 =?utf-8?B?WUs4Qlp1dk55K2ZoMW12eFo1SGhqL0hCS0RjeW0zY0hlWnE3TTliQVk0d0JC?=
 =?utf-8?B?RWhKR0NzVzZ1eWxaSjVucU9LdjlYdnUrWHRXcmZRVytZQ0JqTVEvL1RLWVRH?=
 =?utf-8?B?VzJXQ3pQMXR2WGpRR0Z4T0pjcmxWZy8yWkV0U2hUZSt5ZW9DVm85Ly9HdUk2?=
 =?utf-8?B?K2s1cXptclZsZWJhb3JRV1F2ZENKZWU1N2V6YWMxOG9vTk4zM2YyK21tMFNz?=
 =?utf-8?B?U09SM3ZwMXdFWU9DK2RocEtsSldjMEFuZkVWOGEyekVtTkJlbjAzbUs1dG93?=
 =?utf-8?B?RUNIZHJlOTlwQm1qOFNVUWE5QXZhZ09lVFc2YWROWmx1dXF5T2o1emtkMllp?=
 =?utf-8?B?eWhzZkZqZUdtalRJWEtNQ2xlRmdraWRtNDhjZmlSVVU4d2FEM25vQUxLdm1u?=
 =?utf-8?B?S1RBakpybU9wVWM0SEF6VkdsMmJRdHRqb2NKTERLd2h1czl2N2xFTUVCVWsv?=
 =?utf-8?B?aUFuS3dPSnd2K09VQjFWc21iZ0h2VEU1QlJhRHNzNDlYTjVlZkZUSFd3Mkdp?=
 =?utf-8?B?cHE2VVRoTUY1dm9LSDBiSHdzRjVtUFloSGpjVHVYS1NlRXRSU3hDSWQxd2Np?=
 =?utf-8?B?dllsYmNFdndpbUtiZEhGODViZWMwdGc0dm0xL2V2QVltWnkvdWltN3BCOEcw?=
 =?utf-8?B?dTk3M1VsaGhZejRWMUlyR2k2QVdOTU5XUjlreU1iK0FzUWF4OVhwdXNneVJB?=
 =?utf-8?B?Um1BY2ZuTWIyS0tRZUdZb1VLR01uUEdGb1doMDlQU0VObEJlN20rTGdIVUVa?=
 =?utf-8?B?cmNhSUxwbDRwSmVpN3F5MVpGQWtQY3pmN1J1SWtXQmZrNUhiY0hwN2xEWTNh?=
 =?utf-8?B?SitqblVWbXFaWXdNd0ErcllSNURPaUZrcThleUY5WDVSeGFLdnR2dU1UUHl1?=
 =?utf-8?B?bFhPcW8yTXRZVlVON2l0aXRLaFhvQlBleGFMb21jU3dJU3hrUWlmWmYycUFa?=
 =?utf-8?B?bXdud2d2Q3JEZHg5K0VlazM1ZXRlSmVTZ1BDQTJxVi93dC9nb0pVRXhEdUNr?=
 =?utf-8?B?Q3c5TFVpQmFDQTZvbGU3cFZuVFJhRkFtMStaSkwzekc3MkE3bXhVUmJObTlJ?=
 =?utf-8?B?Zkhrb3I0ZnRHTFluclk5TVl3NzU2ME1DN2ozUEFSM0sxNkVCNjlMZlBZREI2?=
 =?utf-8?B?SXdMTkNnUTBaaHpLWW5WandET1czZWl4QU9waDRmNStXTWpRSVBZOFM3M1VC?=
 =?utf-8?B?Q2JCOVc1Q1lNVS9CWDRFS2ZXL0FRZ2NidEFUZng4RmQxTURCV0ViL0xPRTUz?=
 =?utf-8?B?WXAvKzVZdVpnaHM0NE5lQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm1xdlcwVE1oRkdoR2xpVmtRTEU0ZHZZTFFoUEcyeHZOZ1BDdjJlMU00bUlv?=
 =?utf-8?B?VHRHcENaMnNrdFowbGdTZFcxRnhjL0xjUk1vWHJsa1E1dDZVVXVjc3VvRmVJ?=
 =?utf-8?B?T21nZmZjMW5KaFovU2xyL2s5NXBFMjdtMXpyNXdTVlFUeVZKTHdSRWpFaDJm?=
 =?utf-8?B?TktwTzRMaTdvVy9oSHZkNkdRcG1yZWVySXRJYXljanRMbEl6YU1qNFBDeGRW?=
 =?utf-8?B?MzVOTityQjFNN0FqamVDbG8zeVFNa1QvMHpKSDUxMzU5dnVnaDB0bUJESk15?=
 =?utf-8?B?ZS8zZXRqZFhxd2xHQUNzZG1uOVRpVUk3Wm1Hd0h5ZHdGT0szRXRHRDBKSFBi?=
 =?utf-8?B?OHFTSHhGcTVtT2lSZHBuSWZEWUFJNVJ5Y1FiWG5yV0oyeFhBOERlVmtpZTNz?=
 =?utf-8?B?SWJKOWZ3b1JTUGNLSmYzakZsRitqOEpZYVFsZzVFQjZQOU5IZGJFMGZ2Rk0y?=
 =?utf-8?B?UWNpdkJYRDlzNVNqUTN1Q2NCWk9XZklidGw5UkRkN1k4WWE5QVVUbE9yWEFk?=
 =?utf-8?B?cEhDaXYza09rdlpKSUh6VFpuZ0hRcVZoc2hsWTJKSHYzOVc1SkR6UmdLZW5T?=
 =?utf-8?B?c1JDbGcrWWY4ODQzRWlNaUViRXd5SHV0TmNMNU5RSUNaODFzL05oYW1hWWYx?=
 =?utf-8?B?c2o2VlN3dzZHdW5aREFxQ09LVy9lMFdPb3UzUVFadzJEU05xcEZoUHFDQ1Rl?=
 =?utf-8?B?S1V0d3BSSG93VGppeW4vN1hFL0pqd3dEc1E1a0k4OFVUajViV3dzZmJTZC81?=
 =?utf-8?B?OXNsdUpwRWlidzlmdURrZzRvZ0x0azdQVm1OSWRVY2Fad01wOE9QdTlaVnBI?=
 =?utf-8?B?bndBZjJFVjdDTC9JRnR6L1A2ZmROMjl0RlE5V25Oc1U4bUhGTGQ3ZVhnQmpr?=
 =?utf-8?B?Zmt4eDVPbFVuRmJ5M3FuVEtGM3VCK1JDUStlRmdxNmk1TVMxQWRUZzFFUVA3?=
 =?utf-8?B?MXp5a3N0OGxqeG1uSmQ4UmJMdkRwUDVkdm9YQVVsdzhIWWVwZUdlVWxkcVFt?=
 =?utf-8?B?UXJUMEhESUFFZjdReTRScTVzNFhBU3dKNkRNeksvUGxQcGIydmxTdlJIeTls?=
 =?utf-8?B?UjZPOXc3aERtWXNNMDRLSVpGRnowd0N2NjloS3gwTlBRYkc2ZXZmV2ZYM00z?=
 =?utf-8?B?YW9DbkdRMnpub3lDTzc3RFQzakI4VEtrNzllbnhaQ2RjSTNtWnF0OC9TOTZv?=
 =?utf-8?B?SmNtN1BybERrRTRSeGxLcFpaRFVYVm5iV3FSbXJieTJOanlZVVVRWDExQURs?=
 =?utf-8?B?OXNtL0RDMEp3bkdqWnhLWlhSZUh3ZnJLbnRpM2k5cjhXN0I1QzNTdldpd1VO?=
 =?utf-8?B?RWh2Z0pyV3c1cTU0bnlCb0h4d2k1RytBYnRBMHFBWWRlam9SdkllYUFERzNV?=
 =?utf-8?B?R1NuOFFTeE5FclA1RlBsWThvUDdRNENsNlBrTTZNckV3L25EQ0ZjaVQ4Q0dM?=
 =?utf-8?B?Q1ZLbFF2ZGdoSkIvNzFZVlovUjZlTlpIYWMrWmVtaUlHYzFTbXhNUzFDTFJh?=
 =?utf-8?B?cnlpVklZaG9nMjRpTnNSTVFualZrb1h4enMxdU1NRWxwdm55clpHemhsVjY3?=
 =?utf-8?B?ODNRQzVYMmxrbHdQbFpRY2haUU5jV04zN1phOFJBWjk0ajVOdHZhcDY1NzdB?=
 =?utf-8?B?T2JzVUxYZ3p0YUJyVmdTVGE0LzcySXlEUDdKTVJFbVFjdnA4ZFZXMFhMbVBk?=
 =?utf-8?B?SG5nVVNRQWs5NkIwcmRXZVZIdkJaY3JzSFJRSGQwWDlNcE5KTWJWRDBTVm1Q?=
 =?utf-8?B?UW1SSjdUN29UaVlOdGRvUFp4dWsycnRBeml6NkFrODFPSXhTRUpqbHVObzlm?=
 =?utf-8?B?cnAvZzZuVGNWQ2dDOHZUL3BZRzlJTUxwR2N0ZnJzZlFLeisvUWUzTEpSTUdG?=
 =?utf-8?B?dFRpK0VaUzFEWUc1dW5yTVdMSXBxTnQ4Z3ZNb0JiRXJzMjJTRDhDeEs3Ymp2?=
 =?utf-8?B?VkE2TFRVTStWb1N0ZlhSclV3aGo4dnRUV1dYb2FLZTI3Z3Q0SHp6QXB5KzBr?=
 =?utf-8?B?SVE0WjhsWUg0cHUxaHVoMEgvSStncGp6OE9LSGVwZ1NQLzhjYmtja0JCamhx?=
 =?utf-8?B?UWZRaWlmNkowRWNqVHgyNWt3MGVKNlA5bnpvQ0NXMjMvdGFIb1JxcWcyMkU3?=
 =?utf-8?B?ZERPZkpnQW1QNkkzM3NvRnNuaU9md281TlpvVEcrRE1mRkxnNnlHYitZNmQ0?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xGfH9zCJqDpqro84KeLpO0gWg1q00eqgb+V/yHUJQYVbcVexrjVUT4VXnsWNRggP+eQ4+adR3PzJ3OS2YiRJf481hbhTKPk8m9dHDF5y1lqnNqtjvx7fg9n484HGqICBWPA5KqBlifo/aNjnmzX0dDvLwU3c9a0s9ZZW1n4igpPC+/oelwi6kzw7fzwoLjZOOm+E0GCG4kylja+c8et+B/XnqHaPa6uc6N9XNqBq8QShFwvGjOTyuG3Jjxfyq4M+/9Z79Ds5zLue2XskAEYc2TPQGJlZDkwrEd+NllDg6siaag7P0Hnc132mFcgh01uELwb9gIw5QiAAjoxl4EA+1O5I7YYgRprH4agprDKfDuEbi1IOPfTaQKbv8NTWntulzVqB5ss465Cms+AVk3GFPaKuaoj+nBT9eewX8K8MQoPRP0YVW+Plrmbw8ulCJHTGSVbHGQLSeTlOUKaq2MJvjnySUXtUSmFLa0p12CjODW6OH8iHVoJ4j8+k82cVRW7pn82gBCMg0iv+m47ZS0sSSKocPRR21HOhynyBNAj9cFRjXHwjLuKxsoKnxgBEJI+QHn7OTulXtFSKtJqrGFfuRdXdHkxMT1CIOGIhwJ1aTvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add04957-11a3-4e64-83c8-08dcaaec9cdf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 07:54:00.2961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf4wi/EGykWbIXQ8iAv8Lr5+ryRH0peLjvsGg4SIU2NyKeXziu4LuLGCI+NcJ18aCZd+NZNfCmmo7sqnYYW+Xr30of6PDUXE3MwLqtS4yBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230057
X-Proofpoint-ORIG-GUID: FX6C2zGqA1kQNiFmy5xxGX1MH-nsn1gT
X-Proofpoint-GUID: FX6C2zGqA1kQNiFmy5xxGX1MH-nsn1gT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/07/2024 08:38, Eric Auger wrote:
> Hi Joao,
> 
> On 7/22/24 23:13, Joao Martins wrote:
>> Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
>> behind the device supports dirty tracking.
>>
>> Note: The HostIOMMUDevice data from legacy backend is static and doesn't
>> need any information from the (type1-iommu) backend to be initialized.
>> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
>> iommufd FD to be connected and having a devid to be able to successfully
> Nit: maybe this comment shall be also added in iommufd.c before the call
> to vfio_device_hiod_realize() to avoid someone else to move that call
> earlier at some point
>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>> different places within the backend .attach_device() implementation.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/hw/vfio/vfio-common.h |  1 +
>>  hw/vfio/common.c              | 16 ++++++----------
>>  hw/vfio/container.c           |  4 ++++
>>  hw/vfio/helpers.c             | 11 +++++++++++
>>  hw/vfio/iommufd.c             |  4 ++++
>>  5 files changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1a96678f8c38..4e44b26d3c45 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>  void vfio_reset_handler(void *opaque);
>>  struct vfio_device_info *vfio_get_device_info(int fd);
>>  bool vfio_device_is_mdev(VFIODevice *vbasedev);
>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>  bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                          AddressSpace *as, Error **errp);
>>  void vfio_detach_device(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 784e266e6aab..da12cbd56408 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>  {
>>      const VFIOIOMMUClass *ops =
>>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>> -    HostIOMMUDevice *hiod;
>> +    HostIOMMUDevice *hiod = NULL;
>>  
>>      if (vbasedev->iommufd) {
>>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>  
>>      assert(ops);
>>  
>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> -        return false;
>> -    }
>>  
>> -    if (vbasedev->mdev) {
>> -        return true;
>> +    if (!vbasedev->mdev) {
>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> +        vbasedev->hiod = hiod;
>>      }
>>  
>> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>          object_unref(hiod);
>> -        ops->detach_device(vbasedev);
>> +        vbasedev->hiod = NULL;
>>          return false;
>>      }
>> -    vbasedev->hiod = hiod;
>>  
>>      return true;
>>  }
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 10cb4b4320ac..9ccdb639ac84 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>  
>>      trace_vfio_attach_device(vbasedev->name, groupid);
>>  
>> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>> +        return false;
> don't you want to go to err_alloc_ioas instead?

Oh, yes, I thought I was doing that, but I am not :( Thanks for catching that

Your comment is spot on but in the wrong place.

vfio_legacy_attach_device() can just return false as it's at the top of the
function but here (...)

>> +    }
>> +
>>      group = vfio_get_group(groupid, as, errp);
>>      if (!group) {
>>          return false;
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index 7e23e9080c9d..ea15c79db0a3 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>>      subsys = realpath(tmp, NULL);
>>      return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>  }
>> +
>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>> +
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +
>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 5e2fc1ce089d..2324bf892c56 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>  
>>      space = vfio_get_address_space(as);
>>  
>> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>> +        return false;
>> +    }
>> +

(...) we definitely need a goto err_alloc_ioas here.

Snip below:

@@ -482,7 +483,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice
*vbasedev,
     space = vfio_get_address_space(as);

     if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        return false;
+        goto err_alloc_ioas;
     }

     /* try to attach to an existing container in this space */

