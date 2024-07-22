Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F48DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpCv-0004we-BI; Mon, 22 Jul 2024 05:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVpCY-00039A-K8; Mon, 22 Jul 2024 05:19:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVpCW-00074h-S2; Mon, 22 Jul 2024 05:19:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7d6an002424;
 Mon, 22 Jul 2024 09:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=QUdC3g6WANRjNekq//gQPRrtIbPeXImQla7RNbRBptk=; b=
 JcdQXJZqzjHgG8W/svOaNncSj7Uw3IJhK3lNPMAFgdvOJClE77M94IDVK/dRn0Sh
 aFLFuiyYGC+TLCwPITS98VfGPWlpfOnYtBQT6aKlr/uJI61vp/wxR+sXDzAGPbrJ
 llzyP0qaqc0h3VUVXcnlPiwuFFEkRBapuEFqZ0E1KLkMByCUyE/yRCHcfauUdJGN
 tjtSwZcSnQjFkh0p237K6npYQ/Qik+A0F3DNQSnCFRlNdk2vWkz74hFbyPYQ15+1
 XzL0NMxSBhi31HV/MAxvPTL80ffCZCz+wpoz4ucSx5wg6J7JMn/uhUi0oFUzpfkN
 TG5Q1EccSnFaS3LxcV4TXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcr8x92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:18:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46M91iu7009067; Mon, 22 Jul 2024 09:18:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29ypdd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFMpnf+AgnsplPg99K0n9wfGQ4rbPlBygAZRzAKHZwB/YuZjONX2hLr979kZejzvA1jgg1SMh68OJyMsH716IT1iDyZomc4sixqSeoxSuJn1Yp8tfYNYtIY0qxL1mGBpJ/g1wRmA3GQ5vs9xNCcHGbFiydBiOxn79pG4tbuiGijzO9kCV3LykM7OooVD8ci2M8bnKHetZF6sviggXvJuOsDIe/SpcNpfrfbhzbA1+QPnb6N++YwBdnCYyqzi+86DyM0BJ+1OHJ+utlVxev0BHVJ3IMu5UKBxnRgTdR0H8IMWI+FUSm3KNL/YC8wftFjerCZOkRXW7l2bWGmknRl+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUdC3g6WANRjNekq//gQPRrtIbPeXImQla7RNbRBptk=;
 b=PEu1rWYe7OpYIK5dRYTekBGFzcRCQXWcPSG5aQuo9FjMXe3k3jDTuq9as52vvNlSL1yOmyHUjbAcV6Dr7kddXEoNf1YavOTsw16gR95+7g6ypQDjc/M/C8z0dYmahaoetolMLVxsqfnDMnPsy/jpY5iZz3LacDHwBfTb7GxNCH7TlikNLWmTyI8U9j3Vvx46oFX8lHhanNJQYPhfBR5QWH4XwnlslT405WOkrQHpLHL14aEs0OmKJIeJYXWykGsomc9zKZXtdsdrochDUwlO5rmQmFZ4XcvL/xLP4KngIzW0YMgdlGfrcgXvVv0N8cHbbFv5e9Q1/+x5FXMu5JJjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUdC3g6WANRjNekq//gQPRrtIbPeXImQla7RNbRBptk=;
 b=ZKVZDGJLNphQMf10D3EtzTbWCCYdH4TcoeXTFzjh4KUhwH3nk0aJquLMMo20Kc7uyzAwVYhB8pijNsaG1sef0Ip2LjR9u/vdZPpxHZCEQvlF/BfxECNIeGGS58wDSotGsvu6z4nocVmSodJYNMONNcyxHyzZfg2jh00qe8HZuRs=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 09:18:56 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 09:18:56 +0000
Message-ID: <ebd01af8-9e39-42e9-93bd-a5a4368bc647@oracle.com>
Date: Mon, 22 Jul 2024 10:18:34 +0100
Subject: Re: [PATCH 1/2] vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240722070713.1342711-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8cdb33-d7f8-4e55-e83b-08dcaa2f4ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUk5bGREa0xFOFJweHNDemVQcmxxMDIwVzZNWWVVbVZGbjBCSzVxYVZST3lh?=
 =?utf-8?B?ZzNobXdWUnI5WmpHQXlRZVVKaG44dkFsaGU5TjhmRHdTU1lKOVNkVnh2TVpC?=
 =?utf-8?B?aUZ0WHpSM0Z3VkxQUFlUblpHb3VYaW1rR1JDdXRJWTFtWkRSQWI2L0wrTTg0?=
 =?utf-8?B?eXlGMzJJR3BDSHhhbHI3dlhKV3pTNHRaQjgvTkU4UGZGNitxYjBUaU5EYU9X?=
 =?utf-8?B?OTc3d003aWlKeEQzZEhqZ01OdkltNVM3SENsN0tFbjFjSlhKUXRQSXlOVzFj?=
 =?utf-8?B?RlRmYlZpZFROMXl4dGZUKzZkcW5Yci9ycmJnQi82VTEzL1Q5SHNlWk4wUWYv?=
 =?utf-8?B?dm1lWUVHY0R4dlVhV0htN1l5K1NlY0M4elNHcDdRWllJaXpSVkVjbVBHOXFZ?=
 =?utf-8?B?Q2tlZDE1Qmk1cEZVbm9XVUx2cHFJZE5ua0JXTnU1R1VtQVZDOSs5RFY3OEN3?=
 =?utf-8?B?RWFXQkNFVFRWL3N4WElkeFo1Uk9oVUZ4bVB2YXlqV1F5OElaZWdMZG4yUzF1?=
 =?utf-8?B?T3lLTmlNRGFwelJxbDAwb3F1Y0hPcllINXhYcUZiQ3VERlR4SHlTYndqNFVW?=
 =?utf-8?B?VGd0MWp0ZnFFeWt3b2ZBNCtaVVJZT1hlV3RDbmxRbXNwUWFqM2J0dXFVMHVl?=
 =?utf-8?B?UmtJdUVORkJIRVlxczl6bEYvQnhtVGdVWGJZQWlaZElQYTViaFJCUGc2bFFo?=
 =?utf-8?B?Y0FncDFabVE4aUdUOGtQREVGY1FxanpQU1dMWHJZQ1A4THJPVWNNUnQ0M2lQ?=
 =?utf-8?B?a1ZVbjlzbmUxc3FhMTlFWXhwcFIxNStzZGErOUdRZzVFRHRhekdnRjhlWCtS?=
 =?utf-8?B?Z3k2U0hZam9RNGFsMWozcE9CNXFvUmJPRkRFazFSS2dYaWQ4KzQzRWNQcGNX?=
 =?utf-8?B?OFRNajFkM2NtVzNaQndxOS9zazB4WUxzZnY1TUtHNFRpS3Z5anBHbG9GRUZE?=
 =?utf-8?B?UDlFUGN6ejdPbTVUeVlUUmF3a3UxVHRaK2JtZmt5SWo3WTBjYlFsclJ0S055?=
 =?utf-8?B?TUJpUHJuM0l6M2swcU5JenpTdmNISDB3VzN4K3lwSHd1ZTJhSnpRNHFSOVU1?=
 =?utf-8?B?OW5iQ2E1a1RHRVI2T2twemUyRC8xWlRvZG9XRmtlWVVUclB1UVlPNUFjL3VJ?=
 =?utf-8?B?TkZKUy9qREx3MStQa3g3SmdwdTNCVE1oSE56L0o2djQ1YnZWc2VaU0pDYWYy?=
 =?utf-8?B?MmkwOGErVllPT3krZW9YVUl0TzlCRGRIcVZmSzRYcnlEajJlaDdMUTAySXNv?=
 =?utf-8?B?U3pxSXI2dHZUNDFwU2kyS3F5aW1EdEVldHM1aURlNHNKVVJnNnM1RXNMNDB5?=
 =?utf-8?B?U1FvalE0SmIzeE1uWllLNy9QQnFieXZZeVZoMDFjYWRpQ3o3M0hhWHBvYWRu?=
 =?utf-8?B?MFp5SllvY2x6OEIrZUMxTlBDRHBRMXlLVTR0RlYvMGE3YzZvUHdsdkY1dWRv?=
 =?utf-8?B?REdUQUprb1FaR1BWd09KaTcyUDRPV2JMNDdNc3IzdHVuejY4NVY5eHVHYTNq?=
 =?utf-8?B?TC9PWUJRRkFLdUJBNW1GQVhrS0RDUGVoNlFuekNla0tQRjBkVkcrdHdXeSt3?=
 =?utf-8?B?V3hhWGtqSFY5b1RzVEJ1WmFyS3FXNUViVm5XWlE2cmRpN0ZTVDZTb29qVklQ?=
 =?utf-8?B?eGJsYmdNcjdYai9MN285dDM3dVNRREF2OUdMY0RJaTFEUG1hbHZWZXNSOG5l?=
 =?utf-8?B?WjQ5V1I1VGMrSk41WkpydGZBT0pMS2dFVTdWUzVCRlppb1JQVkpmMHFSMlNV?=
 =?utf-8?B?NXJPL0xSZE1Ec01pY0tpMHF1N015Yk1QOFBXWml1L01ZMFZNdUJCQnk4S1cw?=
 =?utf-8?B?VjJQVWNRbWM3VjlvcE80QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEwrZUtEOVhqUmxSc004ZVQ5eXNFWjZrWkd6bTFUaVpMQ3Y1dnUwWWQvUU5L?=
 =?utf-8?B?WlVNd0h5ZW5ybTQwQkwwa1g5VnpialIzcXc3STdNSnhIcWRpbW16djc0U0ZY?=
 =?utf-8?B?WHRtdFZpZHR4bktsaTZQV2xFYlhKenhYcDBER0dQWWFOMjNxWnF1WW9vY0ZI?=
 =?utf-8?B?dEV2TXUxeDQxVkZUWWlldU9XMW5mMFYrak9KK21RVExFVHpEOGZiTXJsRWpo?=
 =?utf-8?B?dVBsSnE3MEwzUEVBQ09BVktYbmVKME1sMXpwbDMrc2VmVERjL2tVQU9DbDZl?=
 =?utf-8?B?b3ZGR3hnTStVNTNyc3pUMVV4NEgyeGJmeEtnR29MRHQ2NHJab3BKNzlGRWRp?=
 =?utf-8?B?WDQyZ3VTVlVORlAzeWxmNDFsNGRtNFBGL0RIRElXNmp3VmF6OHUwNUI4L09R?=
 =?utf-8?B?cHFkUHFOS1Y0KzMzZERCTEJHK1EvM003L3hzQ2lLUHM5bWNVR01qTHppS21X?=
 =?utf-8?B?eEN5dE1WTmNKblA2YWgrTDlkNlBNTU9zY0ZuU0dqbjdvTFBzMDdXdm80dExE?=
 =?utf-8?B?S0pjL0pXRXhQNEdhZjBwK3g0NDBsRzlIRDZrRjRnR0VPbW5ESTVSbVdpNVZl?=
 =?utf-8?B?cTNNUFpsM2RoR0dHNnJFNVpMZzdnZU1UeEZQNVNZdmFzNXF5MGdBbCtIeXlw?=
 =?utf-8?B?SFMvWHJSemxpRXpIaTBtVHAvenp5dVZKRzc1a2tsdXhLTDltUVlHTUthSTJq?=
 =?utf-8?B?ZDdjNFFFbmw2cWlmMCtCWjRQeHVkdVdNam1idERnUFIwTnpZZGM3OWxxWWpJ?=
 =?utf-8?B?OEV4aENvSHYxMDlNZlUwQmFxZ0R6MmFPN2lXQS9Nc0JLQS9oeTRtQldtYWsy?=
 =?utf-8?B?SktNUVlnN0JiaDJyMzlXa1ZvQk1sMXJRR3FHUy8wZjBZZDlIRXA2VzJkUHRo?=
 =?utf-8?B?OU5QcU85NzN1SjJ4VHZYZ1lJWndyd3BoZXBTT2h0SVNNNUxRTmdtbHJmNjBX?=
 =?utf-8?B?bG9aMkRFcVV1R205R3RFNEtEZTBSWDNzZmdjK05hNlRoWXp4ZTRMSHpCN2VI?=
 =?utf-8?B?cW05bHJMYS9MdENvT0VsWWxHY25LdlNWSzhtK29vNnI3aXAvcDMxaXFwanc5?=
 =?utf-8?B?cTNwTXM3RE96dG5tbEo3REZZY3g3d2tiRzZoNFdOdXg0ZGU1bndON3NLeG8w?=
 =?utf-8?B?WFUyY1RXWHN0L1A5NzVxVFcyUUlWZXFnbjJuVHgvYStmdzRBbkJKZFVrT08z?=
 =?utf-8?B?eUNkNitOOUFCdFI4Z3FLd3h6eUdFMWlWNzB2T2ltMFRjTi80cU8wclczTDdF?=
 =?utf-8?B?VTRjZS9BY1h5ZlpvL1RseDdBVSsyc3VoWWVWOUtPeHl1UlVtSzNCYkh0aS82?=
 =?utf-8?B?eFpsNVBLazdaSk53VFdaSW5GTHJuSjRWYkVRUk41TXJFR1VxTXI3VnhuL0RD?=
 =?utf-8?B?SmxnSzlCbkoxZW9aL0xERVl4bzU1cnNSYkp6eFp0VkF2ZVEweExrcHRRWUpZ?=
 =?utf-8?B?STZWWWV3VVBOSmRTU2QvZmY4UWpHM1gzTmZEcktIVVUzQmRwemFjdmYzQ2pJ?=
 =?utf-8?B?eHhsUStGSFhMdFI1WGlYZTlhakFPSVBRTlNvZ3Y4ZzE1YWtlK1FlZ2VsL29H?=
 =?utf-8?B?MmUraU1oRFI2WUsvVkcyZytNYWY0NStmRHNROHh6YjNEc0JVaFgxYkNlcDVs?=
 =?utf-8?B?QjF6YkE5ZGJpcEU0bkgycnNoVHdlbHhlK0RVTTNqSndqdmZCY3JVYVVDeXQv?=
 =?utf-8?B?NFhlWGFoNW1FblNvMHdzaG5GYVZINUcvOXhwejVSWStlQW94aE84U245STBn?=
 =?utf-8?B?MGEyd2VSbzB5WVBlWEZOYXJEenhjSTBzMmVnUWpnd2wyeWc0aGhIK1JRUUZn?=
 =?utf-8?B?eGdhYlhhcTVjbWNhUXZoTXpwRWxmMkdsdmZCRXZHOXJRSm5kN0F6OUdTWElG?=
 =?utf-8?B?b3FHN2RZY3hEYmFFS2kyeGlmaUg0dTQwQ3J1Z2JMeEN5aEwzQmttQkJwWjVC?=
 =?utf-8?B?REVob3IzMTFqMmF1YzNNL0FWMnZVeVNCako0OWc1eDRQdTk4MjJUdkdoRzVP?=
 =?utf-8?B?c1JuN1JlaWt3NkVhVVdNc3JwcG9TMlk1Rmp4WWszSG1SVDZLMHo5ZzBJSk9r?=
 =?utf-8?B?bER0NDFabnlYeDgybFFvSExiRUhWNm5qNVZDL1ZJa1lobGd4OGhlMzdBcGU3?=
 =?utf-8?B?cW1hUXJ0MDU3QU1MOElna00vNmdmM24zMkRWNmhtejVpWXNZR292U3FXWEFs?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jb6POKbcWHiOKbNTzJeb317WVz1VoV+2iXX+3url14ZgsHueMaUEgVBCwj+DQV7q3OMuNSW8GQdrrYMZh0KmEUUX9BGegA8o6ljK3bH0Fz2ywRHMlgM1Z2ZV8gnq+3S8Ir6vlHvZkeKXJWS/0wYUUQQvYheK+0yKxb8lfIsIC4i7d+CBmvNcWJ7F31t3IvzaE665U1uAfyyScPU/7im5vyOmU/LkMiSh72Rj0iwzuwknrgekUlXvsK3aO5Rv0C+0OIAHCHRFIkzpCUx8HiWCz7SleEC10+wPNTbDsEwppP3DlZJ+PbcY/cmlRxXdc87F093UMrgRYuMQegDQPJ5AujAl7DrxZdS+6AvPnRH+ehaDbp0K2c0Xlh7DytmJ9yzfPmnR2Hpe1biECYREXjQvQ/TsptclsDwXmFQdf+DR7ZWQINXLE8mAagj6Kn3TJuaE698rvmRo6R7TUs+NVTY2y7CkgPrhAp9hU+FItiFq9cWIPdyrLULvzWVxGro2+6R3enJNaGn1jQn6B4xeKD2L0Ot14a1id2T5meRcsmvRD20SB4Z+C/lNHBlCbhd/sGsClEG9gCUrmooFfP4xQ2MrjWkYISKgojMXN9+0jezKJNs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8cdb33-d7f8-4e55-e83b-08dcaa2f4ff1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:18:56.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVYyaUjOg7IdP4B5XuaECzMqpSq8T447PB/MW8qfma0mgls5t6X0xKT8SB9xciQjXdWMdsuoNZg7f3EQVk2OuG0TUyk+W53GIvbzPtK95Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220072
X-Proofpoint-GUID: po7D6UAKLO0LkmJ0jPnGOgEX6Bo_VL-h
X-Proofpoint-ORIG-GUID: po7D6UAKLO0LkmJ0jPnGOgEX6Bo_VL-h
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 22/07/2024 08:07, Zhenzhong Duan wrote:
> mdevs aren't "physical" devices and when asking for backing IOMMU info,
> it fails the entire provisioning of the guest. Fix that by setting
> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
> presence of mdevs.
> 
> Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/ap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 0c4354e3e7..391bfb72ca 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -230,6 +230,9 @@ static void vfio_ap_instance_init(Object *obj)
>       */
>      vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
>                       DEVICE(vapdev), true);
> +
> +    /* AP device is mdev type device */
> +    vbasedev->mdev = true;
>  }
>  
>  #ifdef CONFIG_IOMMUFD


