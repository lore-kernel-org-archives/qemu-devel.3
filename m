Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2945C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHShY-00062t-4A; Tue, 20 May 2025 15:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHShV-00062c-FD
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:32:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHShO-0003Tb-KM
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:32:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJMblI017900;
 Tue, 20 May 2025 19:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=D6TYdSaBDkYlK3C6uHpiLoqhv2fXUv76Iw7pgTPB16g=; b=
 ou9raqFbZMujMv4ZmfoMAlgZG+A16fFs3vcvI854qNF2pckNjEyQyLjZm04SnyER
 Pyzl/fX5NTNCCiJeOqAj3aSGv5+Seu6jRhDP1Wozp3wEwZi7NPeygFRyw8Noi4F0
 YfpvTj1yMevyltmFZCZBUXI/YrB/TeF0sOG7y3s2b0/2ra9gS9jvlt53qav1+D/C
 8WQUyit6jc6kkfaAQSlT8EYCrQw6Ch0ivKIGSEiDZHVsdl2Urq9IEp7AacThJ8GU
 ol740BYHexdOTB26vlc6IBLgfqmxMKTW8+3igtIzMreSpTHUk4dFAQBMkCLLgMeM
 fAvPMNvJOmMI974J92LM2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ryasr31a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 19:32:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KI9Ape033901; Tue, 20 May 2025 19:32:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwemf6qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 19:32:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPLbRy+9IZbNUSjALRRxOtKcvslWgFbWsNcyIyKDPo3myomXDkpNz7krluKOK1Pl1ryNAeBc0qh+FFQCLkflVII1Bjl/c4JTWRoFN9m/d9O4vqcygYNN4ZHviXwXu/Gg4eWMP0746jtUnMo+wt1ECLAq8ijUlFZdoBDlt7gxekRoH1CI5payLoNv8GatSpfu/6eyJMyJ+1CebxmGJ0nM4dk+FuDhvpM2iVVdITdGm8F/+svk+sL4Cybbzrm8INmM4ntp5vWdtComYQjPyTcH1Nz7dD7mBm04RfLaHf8oU9VjWP0CrVH1M4bYYc4dSkKJ2oVFwlvG8nec0+z0/rpcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6TYdSaBDkYlK3C6uHpiLoqhv2fXUv76Iw7pgTPB16g=;
 b=nXqEOdMz4J0QFJK3TNErL7eSUzmuIz/IVk/F1rOBzxHiQO2oxJdALfCw2eNAcpJ5JyYKUuoeHLoZwqMeYXiUgqE3IvAM9E4AQPUcysw4elh15wtq+HPPfltsyhA2RrEhOeQBVIe3v8xtBvbm+BQV1GVk4+U4J2FCyCUALunHAW5uQW3MEUy7jaEXlJEUYCwAPhRaOkGJuqH/8KwN3m6si8PaeJqX5N3zLA+JrjZ44UbAtn86pZuxow9BhGHkj+iMG6cyXTvTCyYdOnMMg2EKJlvnMdXU9EBcgyTAo32iKoa818MqNK3CtMiebmCTEFiPyGkc7io2GhHoxq6iKxasyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6TYdSaBDkYlK3C6uHpiLoqhv2fXUv76Iw7pgTPB16g=;
 b=l2vSyltD4B9Mv14G0Q+4ihsLyRX2AQU0c/tueJ1Go9tNaw6x7/is1aWSI3SSKWiT9qyQC7PnOEj3fK3aJOHlxRzPWqkDJ8EolD3vbv/+wGOh8uv1Cjkb4DyA08chxq4JeZROgh/+RktpE3rqyHlpGNXYZp4g0AAQjf5x80U93vM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5666.namprd10.prod.outlook.com (2603:10b6:303:19b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 20 May
 2025 19:32:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 19:32:17 +0000
Message-ID: <5abeb08c-3cce-415b-a90d-6659fb0e53c4@oracle.com>
Date: Tue, 20 May 2025 15:32:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
From: Steven Sistare <steven.sistare@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-29-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744903C16544B81D8317DDF9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0a4593c-dbfe-4e9e-a90f-d173b388e34b@oracle.com>
Content-Language: en-US
In-Reply-To: <c0a4593c-dbfe-4e9e-a90f-d173b388e34b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: bab8f4be-5f2c-48ae-ec34-08dd97d507df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OU8vUUt1bldrV1lkcDBLNWhQWHdpQXE0NHVpODZtMXdmS1FSL3lsYTYyZ0U4?=
 =?utf-8?B?TURlVUpXVVgydTFDeUh1SmFkZjZON0RHYUxGRGhjMkNPRDl5UVBpUTI3S1dQ?=
 =?utf-8?B?MGk4VmJMZDV5aEFGdS95blN3RmZ2MlFRUzRod0ZROE1FRkM4SThjelM0Vnhr?=
 =?utf-8?B?eC95dUlZdSsycmdqMzZDbzdBS3hNWSt0RHREeFgwK0ZwS0tGak1yRnR1NFd0?=
 =?utf-8?B?QWQwSGtFRTYxdW9JK2FwLzk4SGgxQitISXVsVnI2amRkNDFLV0tVNEZGQTlh?=
 =?utf-8?B?dDhzZlBONHZnOWxCKzhDTXZaOGVLYXBYNnVWK2g0L3M4T2w4WHVzTEFWUnEx?=
 =?utf-8?B?Nnd4bVpLVm1EK2FXbmQyQ2RvRmxKSUNUVEoxbEVuUDRRWDc5aHFrRkYvRkNh?=
 =?utf-8?B?RTRreENmRDQ0UjBWR05rbGxxRDlRYkduWlBMMTc1TS8wY0JNVzRXMVlIdHVZ?=
 =?utf-8?B?U1J4RGpjcVRQKy85Y3RPTlRMbFoyYlBSMHVGZnhxVWU5N2Z4Lzh0MmIwckVa?=
 =?utf-8?B?NmpWVjN1MVVDRm1iNDE1ZnUzNG5Nd3FoaitTZVljZmlTOVU1YjY0QUJLOTRI?=
 =?utf-8?B?UGdoYkZQSitTbXoxSkY5Q2Z0clJoMkRMMmZybzFQUTN6L1pMNm1Xck1TUjNW?=
 =?utf-8?B?WVlhLzg2aWVLU28yQkJkdnRZN01DYWsxWHdPUURyQjF6NGNvOC9LeVhuK0xv?=
 =?utf-8?B?aklMS0FoQWRybFB0dG1iMDJTVnF6cFRpRHZOcTdudHp3WnFFcmZhbG5UTTY1?=
 =?utf-8?B?Mm5uNUJkTEpYNkFleFdPeUtTZHNDOVYvanRpaFk3VVgyYnZJWTMxZTVjRGpG?=
 =?utf-8?B?bkxEZ05oNE5xM2JRVTdXYTZIOXE1Z3FpQnErRVdWL0RySEN5Z1h3OU5lQ0M5?=
 =?utf-8?B?VytMT1JydkorN3NHVCtSUVQ4dEMwTFBmaE1ZZ2x1L21sUkVnTGNURVZhMi83?=
 =?utf-8?B?VndRSzh1YzExVzlnTmdHQWRWY1R6RTdRdTRyYXJJMkJicVQyNVBkdTJCWUE5?=
 =?utf-8?B?UkluNzFkR3ZmZU5ZbUVjQjZQOXBjdGI0ZDhjU0k5a01RNEJtRTJRWGE4TVY4?=
 =?utf-8?B?enVoditiSFo2Vyt4ZnRGWk5uNmRRRkN5VHRwNllkb1NvZUtaQzROQ2h1Zjll?=
 =?utf-8?B?TWszZS8yWjQ2T25PcnBaRU5QY0QxYThQTDFKM0Z5NFVqdjNzVCsxNUsrV0tz?=
 =?utf-8?B?ZVFuakJLbnBTMkNMajlVT2JtbGRST0puT3ZvNDk1KzlSUlZzWnZvNWVRSXhq?=
 =?utf-8?B?TGNyeFhCZGQwVSttelBtVy92K1hQS09QUnRweE12ZjIvSWw5eG5MRHpyRm9D?=
 =?utf-8?B?MFB1MEdVK2NFd0NvZGt6d292VXBmRE8wZngwblM5SXRBWU4wQnZyTTlFWFdu?=
 =?utf-8?B?N1EwRVgyNG1FOEJ2ZDRMaVpmTis0UU5KQU1qRnJ6RjI2NmxZVjYwWDRwSjNa?=
 =?utf-8?B?VlIyN3J3bEpBSW1xcXQyTWQ0eDc4bjJBN00vYUtuMHRPelEwMi91RXRsWi9y?=
 =?utf-8?B?NTRRZGx0VUJKZWhKU3dFTGQ2OHo4eE1oaTB2b3c0VW9FcG5iNm1yTm9GeTV3?=
 =?utf-8?B?UGNXQ1pjQUovK3lzQkI2ZXQ2T21BaHJlVnV6UjBQME1pNTR0eEFyaHBSRy9v?=
 =?utf-8?B?bTdiYWpQQWs5ZTZ0Wmx4aVI4M3NSRzRLNWVVQ05aM2tRdjRlVnY4RFd5MkdT?=
 =?utf-8?B?TkdCRmlDZndGNEdxKzRmNWhyb21kTFJDVmZtaVROSVZWbWtGNzVxNm95ZGow?=
 =?utf-8?B?NWh1dmlkanA5STc2L05xbTU1OWlCc1lBaWd6OEZ6Z0ptS2ZTM1RJa0pYRU5t?=
 =?utf-8?B?eGN5bVdBTG0xdWlhT0dVZ0REOXZwWW5vREZndG9hbWJVQTZqVjRDaGNKcnRO?=
 =?utf-8?B?NlJldERQeDE2QytGbWVXc2JHVVN0WWJPTFVVYmtrNzkyaWoyN21NTEFYd29K?=
 =?utf-8?Q?mdpmJOoX+VA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUEzRGMxbzN0TllESFhyNDdzSjZoVFlyNytLMjJFT2dvdXZhNENUK1RKbFRi?=
 =?utf-8?B?c0twMGZxR0hHR0FTY0EvZXIzb0VkK1liNzhVQWR5RE9wNmJHc2JQclAySUkx?=
 =?utf-8?B?dERYK1Qybjd0cVBGWjdOTzRGL01aNko2a1hRL09JbFVKbitCclNrU2xvbnVE?=
 =?utf-8?B?dUJZanUxOGhkVlA5RTFWVk5VRTBIdG40aFdBNnBEM3RsWEJFMmxrWXgzNnkv?=
 =?utf-8?B?QmxQYVYzSjBFaXVoQmgxb1NGMjJpKzhVVjN5UnB6TURLSkpKVFAwK2RXbFgr?=
 =?utf-8?B?YjdTNzBjRkZkWWtoeVBubTAzU2ZCRXk0MWlvcUxwK2RuclNIZCt4M2JwbTlI?=
 =?utf-8?B?OWZJb2lBUnJ4NUw2elUrbS9aQzdESEdpN3BzNVB2N0Y1YjZqQ3Y5Rm1LVDFp?=
 =?utf-8?B?U3M1bWl4amRxTXlkUU1hVU5pdDhnWGFIYTdoVGNFb3FWYll6amUxKzE0cDNm?=
 =?utf-8?B?ODA0bjhQWGZiMit0UzFUeTd0ZHJhcWlFSHJab1prcVNpbEFPakZhUis5QmRn?=
 =?utf-8?B?ekR6eW5VZFdMbHRYZHRBWVQzTzJVQTJyVnd0UjZ1bjFVck5QVHVhZGlSWERH?=
 =?utf-8?B?TCtpU1NqYktJTHhoS0IyWXA0bGQyenJzZ2swWDFhb3pmMlJWSzJZRnBlUGRM?=
 =?utf-8?B?eDVlVmxTYi9iTEptR2pvREFSQ1pmN1dSY2FWRkhFcnM5QXh4YkkzcTQ3VENS?=
 =?utf-8?B?SjVuM3F4d1ZFenB0RUw3R2lHNm5pYWE3OEFEWHpCNWt2cEpzaWpDL09kSEFI?=
 =?utf-8?B?SUh3Zk1oTnEyVXRpMEN1K015VUMwWEg1eE83Ukt0VWM1RVhFY0pma3FTd05p?=
 =?utf-8?B?L1V0UW0yWHIrZE1uREM0TTRQejNscFZtaElyMVUxVzJiTlpkQURHVXJSNjFN?=
 =?utf-8?B?OTl6WWtScHFaVzA3QmxwRFZXNkI2MXJ6cTMxMGZIV3ExanhRV1o3eU92cTZD?=
 =?utf-8?B?cXl6dmMzVTNVOFRDRVJTY2FnZE9NYklsQitsYU5NRzlEOEUxTnN0em9sc1BU?=
 =?utf-8?B?dEtBa1BrUWMvc3FzZXlXdG9IQ3hndUM3WWNGUmNwQyt0b0I4RExHck4yOVF2?=
 =?utf-8?B?U3Vubyt4a1o0Q0N4R21GbE0wbzRGQXNDN3dNeVdzSmtDT2l4Y0tTQTVzd3dX?=
 =?utf-8?B?RFU2Q2xSWVFqdjJuSUN4djJpL0UwOTRvcVJVRFM2UUR5ZkRLSVBNbGovdUxi?=
 =?utf-8?B?L0lwQ1BJNzlyeTBmM0E0ZXVnMGNNeUpXd284ZUhiOWp3bFdJdk5NQVdydk4x?=
 =?utf-8?B?RXNjVDE5TUtYR0R6NmJjTUlrY2tXYTdEc2cwU2N5amE1ejFIR3RqaGNaZ2I3?=
 =?utf-8?B?cXM2MVdGNmFwWlFGd1RQZktNeDB4U1FJYkxYanA0T3hnZEQ1VDBjcVk1bSs3?=
 =?utf-8?B?NXgrbnRwQmF3a0lPNkhiUFhUeW44d1NJL05Hb0gwR3N0RGlIT3N5M2t2L1A5?=
 =?utf-8?B?aEVFbWR1WUlXMHZQQjlDVmxzaGYxSGU5bVRsVzYvTGhxanlXalRkMGJnbTFv?=
 =?utf-8?B?WmRONjJmcEI0ejRZbmdmK2RBSmJRUy9GRGVvWkdFQkc2ejBSSmVzVjhqMzdL?=
 =?utf-8?B?NkFyK2pQWGYrTFFyQlFQZS9ZOFNkUGVOcXI3NE55VXZsYldEVGRoY0FCNDJp?=
 =?utf-8?B?L0xvNEl4WFNHSjRWS0haWTNuMktKVDhhNTNvcUFrWW1GOEw5ZE12Rmg1NWk3?=
 =?utf-8?B?U0U0WTZka2lnR3o2Q2pNYUh1Q0poK1BxVU1idlpnVzlucVA1OGMrZmduU21K?=
 =?utf-8?B?ZHE0bzZPNk1uL3lmVjNZeEdOR2gzNHpSdkt0ZUZBb2Z0eTg3OVUvSmgzNWxR?=
 =?utf-8?B?TUtjVXk2amJnMGdISFhpM21JZkVndDZoNGVJQnZZdHBHT0ZmNnZyT3J1Qi9W?=
 =?utf-8?B?QTU1ZEY5MVkvYk5ROHlhM1dTQS8zWHM5Z2VVaFN4M3JvVUxjVkFDdmdnSGJa?=
 =?utf-8?B?SlNwdVdKMkkrekJ3MVhkRi9nSkFBRUplQVdGV1AzS1pDcmtsOGh6ZlA5RDE3?=
 =?utf-8?B?VFdZQ0x4RzJRc2hLL2F6cjVOdm1kRk80cHF1eVFQWE84REpYTWV4dEVIVm9r?=
 =?utf-8?B?N2p5eVY2N09DUDNZUlRyZjRpd0RBMGJCQVAvb2xhQXZaa1QwQ3Q0M2RjcmJM?=
 =?utf-8?B?Zmg3c29lYXdyK2hqQllYTC9BTWViRW5VWG5SMHVDT1RWTTQ3c3FsTk92QTNC?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PxHUvzfdPzXGOVqf/rfJggGITathmMIUEhjFtfXTzR9mRPQ9kCGVfc+R9Xggx5qXspkwab2UXcGAxktA0T8KpSUsLXNKigpk7syf/UQjC1eoORsIokWcNXMzhX+gl1NqM7WVXtKs8aEovA+G/LpBFmcpsl5wTV3L6J6pQ/52msE40hhH22j8pN8eDxaYZ7szamE/07pC0K+h79/eJ4Kd27Ddqe/Jhbsyn02wCDFZmhQ6X8QWlIRxsAH3W2kpvYCkZJLgnr0jleNftYKEPqbYQWDXyhLgjkRNRIt82J/jMAozriLCaE82cdLYH5Eq+Wf8v/u/ugrRnIokCSGnoDyIsji/9ayGbbFGi4t3r6o1bCC9MXFFQrCaitzNnvrgwntlREP8u1lOJ1BSgvUXRwKsY9CfAXLjqJAN6kIKzwcosAoEJZZtRPdJeKt9ma2WXWBUIcqJMYuQlMTfuc44DMblEf+ElJmf1GSTFxmKboznkyajduNbiqX1/0+0T9eKclE6pijdAiV/oJgVYCGNGHCPhJ53KvW4QcHTZ367io8dVnRm3YsWy9vXlo1HM8X+Haj4qUCyMFC7FV7VUqZu5AOxwyY0UK5VHM4jq3e+Q49wZGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab8f4be-5f2c-48ae-ec34-08dd97d507df
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 19:32:17.4454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5I7mLZi0VVvOymm38brbMOcGJFtxOm6rmHWABXX6uUuYSRizZNUQc8B4B/nc+GO3WmGaKdLU6aqZNGcpBzBEr5cE2xXLj8eOoQtCv48H3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200159
X-Proofpoint-ORIG-GUID: ZPMe29g4e0P2uFR2wIkVfAOp-MkLsYv3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE1OSBTYWx0ZWRfX3qUWnniedOMB
 k1/VlI5zbmUziQ2ar3AjwIzsEeQO3Kk6LUB7mQt6KizIhtHTwE+QCwoCFSQKdQQOkWC4b33wjE7
 A6ALdA61L3P6Jf/S5YPwH4jaffvlL2ApvN5/OfTC44L2is0h8nZ/oYCuJdedqQ+xKHwbV+h6vR9
 j/iRTuDPCRHQtLQ7+oIwUBKblHK8CmeAYPTz1e8+tsJjkL8xnpWGlNt9YMM/drd/CtPo1IVtxWt
 /0rTweydQLv8cSQkrcktpmrOIyHcwhXb7NjrPTHJPLKrLLU5F540/VAe4us6UoQo7oZoM9jTL7n
 2GewvlXEOThr+NewUj/mLNXLoBn2b2ixQrtLo418KU8II35HCSiF58IbYrE6jIZmlaC3APiJdq/
 17zNXjDGa4jy/RnI2RXDUVwfkLx7AFwip73yDmecVl0XIlV95+2WMVp7axl645H6Xtv3EU47
X-Authority-Analysis: v=2.4 cv=D+1HKuRj c=1 sm=1 tr=0 ts=682cd8c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=7aklV88KqWh84o9s-NUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZPMe29g4e0P2uFR2wIkVfAOp-MkLsYv3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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
> On 5/16/2025 4:26 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 28/42] backends/iommufd:
>>> iommufd_backend_map_file_dma
>>>
>>> Define iommufd_backend_map_file_dma to implement IOMMU_IOAS_MAP_FILE.
>>> This will be called as a substitute for iommufd_backend_map_dma, so
>>> the error conditions for BARs are copied as-is from that function.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>>> backends/trace-events    |  1 +
>>> include/system/iommufd.h |  3 +++
>>> 3 files changed, 40 insertions(+)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index b73f75c..5c1958f 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -172,6 +172,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend
>>> *be, uint32_t ioas_id, hwaddr iova,
>>>      return ret;
>>> }
>>>
>>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> +                                 hwaddr iova, ram_addr_t size,
>>> +                                 int mfd, unsigned long start, bool readonly)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_ioas_map_file map = {
>>> +        .size = sizeof(map),
>>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>>> +        .ioas_id = ioas_id,
>>> +        .fd = mfd,
>>> +        .start = start,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +    };
>>> +
>>> +    if (!readonly) {
>>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>>> +    }
>>> +
>>> +    ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
>>> +    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, start,
>>> +                                       readonly, ret);
>>> +    if (ret) {
>>> +        ret = -errno;
>>> +
>>> +        /* TODO: Not support mapping hardware PCI BAR region for now. */
>>> +        if (errno == EFAULT) {
>>> +            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");
>>> +        } else {
>>> +            error_report("IOMMU_IOAS_MAP_FILE failed: %m");
>>
>> No need to print error here as caller does the same thing.
> 
> OK.  I was copying iommufd_backend_map_dma, but I see it has recently
> dropped the error_report.

If I delete the error_report line, can I add your RB?

- Steve

>>> +        }
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>                                hwaddr iova, ram_addr_t size)
>>> {
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index 40811a3..f478e18 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t
>>> users) "fd=%d owned=%d user
>>> iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>>> iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>>> iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
>>> size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d
>>> iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
>>> +iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova,
>>> uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iommufd=%d
>>> ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" fd=%d start=%ld readonly=%d
>>> (%d)"
>>> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t
>>> iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d
>>> iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64"
>>> size=0x%"PRIx64" (%d)"
>>> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d
>>> ioas=%d"
>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>> index cbab75b..ac700b8 100644
>>> --- a/include/system/iommufd.h
>>> +++ b/include/system/iommufd.h
>>> @@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>>> *be);
>>> bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>>>                                  Error **errp);
>>> void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> +                                 hwaddr iova, ram_addr_t size, int fd,
>>> +                                 unsigned long start, bool readonly);
>>> int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> hwaddr iova,
>>>                              ram_addr_t size, void *vaddr, bool readonly);
>>> int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> -- 
>>> 1.8.3.1
>>
> 


