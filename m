Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8836C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAXN-0005GH-Jk; Tue, 23 Jul 2024 04:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAXM-0005Fm-1P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:06:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWAXJ-0005CZ-Dk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:06:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BTcg009419;
 Tue, 23 Jul 2024 08:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=QsbwjTWWPgdndq2hc64wHhjdaLTjlxFeakG0Y2+nQno=; b=
 JDogqFRiJCrVp5cHXWNWh06QuICIVOnMwfahHGO1QKMMFZUrXbIe+c2IBn/CZjXE
 OezKHJ1CvqVFId4nAIr7yru/RLEAxLTYeIODpFsIpobCY5oFgVrOpt6JebupKpqm
 dSmLFBD9n6jKhZGbmflXlYJ8mB1MHAz/VcUk7qnxhGzYwsVuEuYmwGb2gsbl4RgA
 uSFxtgU9wEUF8Vv0zLEjOtMrQfi9Xnnb6fAvWKtFdXn3jT4lL6w0ReO/gxDMnNFB
 qOIv4W5bVYH2S7LQdQ1kPQkkvem6s9wnQUoJyFWoT8bOcnxSreaRL6Bw8TcEbOfn
 uIO3E+YDbvCJlQX9T2i6Rg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpdrdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:06:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N7nEre011026; Tue, 23 Jul 2024 08:06:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29quhkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNemvYC9kdFFRVe2v46sgy0ldXvmqWgalu9/m04cvepysEai+zWnqdXjmwL4mxumfR96MN0qE8x51gd87qe0I3pQ3t6xq7kielqMzH+dWJYSbAlh47Iv0sqMG19VtW6c9uV3Zl6DLbXd5aOtEKOhuNqdtqHefF5K+S24uaR4iA6nE+THa10doaSAO/hzZdzZEWDiD29vfq7ltFZ87QJTkC0OlJWezjRwLSguHMd43ZqblPxm/E2Q6nnPtEOWdzkeEcwVL1WHhq5GN8OKxP3sht/Nd7CBod1rXcfKrWjb8kEIsRsvPSIHgSq9cWGrrUHeuXTNhttWmF0uGj6xEvG/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsbwjTWWPgdndq2hc64wHhjdaLTjlxFeakG0Y2+nQno=;
 b=gIMHTjPtcAucVmIwCY2V/KN+LPoMAEn+owSKSYL2CFO3flEunceU9O9G1vZC45XsmcwH/zKe6uWb2lJsWWrBVpnyE2zTqj0MIzuG3nA1CP3daGWaZEYm7iDoZRUyvvkvr4kzz5Mvj3I6Ng8AwuMX9jXWlfVb1saPw1JaQo5P+zexkhUjw+e8YH0mW3BfCgqumbpMXw0i1xvzbqkLhPshkPpByHfgvv52pvt/Y81Ka7SLGrviSV8lDMw3p3J+TaUEpE7OF3UIZIvN/nW7I0tlZfTqZhd57lUilUA+DYvIHjxdfCbCMWz94g5gLQeXIx3fHP99A+Y6mXTHenZaNRZPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsbwjTWWPgdndq2hc64wHhjdaLTjlxFeakG0Y2+nQno=;
 b=vvKNikGf1QSmeGKtKiJpUzZ0c+rnzTaYwJLsjxyFaGxRz8owY94aRQcM1rw/TTezZuqw6beBM08rt/kP9eJIZaAtkhyEdO4dOwc6npfyFN7vHCJjuxUlpvzEFJgknqZ0nDOKtV7xm9iMX0Hx85E01QgM28tvTJTi1DYPtSR1bKM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 08:06:10 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:06:09 +0000
Message-ID: <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
Date: Tue, 23 Jul 2024 09:05:57 +0100
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
To: eric.auger@redhat.com, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
 <eae669f6-f24f-4573-9934-2c6fb5b364ad@redhat.com>
 <8405600f-ffa2-43c2-8e51-7b6674de11ae@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <8405600f-ffa2-43c2-8e51-7b6674de11ae@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4886a654-52ed-40ab-03b7-08dcaaee4f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZqNURJZ1lQMmllc2ttaXoxck1WTC9IMFlOemhkMkNmZlZEcTRoa0dzTmUy?=
 =?utf-8?B?ZTArejMvdStpSlRBam1QRUVyVEVFK1ZzZkp1MldwWU9rWDBaRnlhYk9GSmZp?=
 =?utf-8?B?d2Z4bVlWeTYyUkxWOTFVZ1NzMDk0ODRIOCtIU2pDSkcvQ1c2V3BhdzBXOWp2?=
 =?utf-8?B?Ui9CdFBxeXNUNFkrTGxGaXNHK0VLZlpxc0M2TDBQR3BWUlkvS2orTWZ6UVAz?=
 =?utf-8?B?aGx6d1ZONUdIbW92dU41UXFjelRLMDdFcnhkZUxuU3NMaWtneWZ5Rk1OczFU?=
 =?utf-8?B?eFZhMDlMcUc3UFNjRnczc3F5YnZTNnRlVUNDZ2tzYzJoc0FuQXdsSUptN2xz?=
 =?utf-8?B?MW4wemhvbHB1elV0Vnl0NWhiWDJUeXUzcFRUWjhYemFsaDRUREVmWGJ6eVN2?=
 =?utf-8?B?NGFncHRMWXlrRFR2bkcwUmVBbFM2aWtwZlpTYTB0b1Vic1hXd1FjL2VpZGtn?=
 =?utf-8?B?RWlibGNsMjZXeGY0eUo0NDlUY0hNUWtyVkNUR25LTUp1V3lrQjB3d1hWbFdn?=
 =?utf-8?B?SHRodzQ0TmJEUXBRUTJNMy84NVZycjJJSFN3bHV3UisxUk9tTEhzZUs0NFVo?=
 =?utf-8?B?L1UzSFpLcHhXcGNweVJvUUpBS3k5V21pWXlxbWE0ZkZyOFVSdDhTREh1OFc0?=
 =?utf-8?B?YkRmbU4xcUl4MWVMNG9MaGs5elRtUEdQNzd3SHVqMytDenRkRGo1cDBmQkNs?=
 =?utf-8?B?cUl5ZnFxQUhDY0F4TFlaQjRYZ0ZOeWZ0MGlXVjhkWW1xTk5yM1A2cTRqVnlP?=
 =?utf-8?B?Y1BkMzJZaXd4b0FBRTVvSERXRWxESnJWUlpiMzFHTktnem1GY2ZDVzI0QWZL?=
 =?utf-8?B?OHFKNU1aRzFOeXd3VEVMU2xmei9OV2dLMm53VllyK3RHTUR2cWFWQ2s3K0RO?=
 =?utf-8?B?ZURVc0VsU2JyZ2F1cWpvdzkzTFZ1MSs0RkxNNnlOaGhqM2V5bWUyQXAwT0gw?=
 =?utf-8?B?VTJ4VXJVZmllbUJXZ2NtUHVaNTMwOEM3eGlUNWpnT1pDNU1PVnFUbmV4SDha?=
 =?utf-8?B?bWpQaFlSbjJVdkdDUGpYNjB5NkEza1dkbnYzam1FSXcwdmt3anpZV2hCOW01?=
 =?utf-8?B?QmVUc0dyZzJSZGRJTjMwWGo0RmkyUVBUVzdDQ0ZQazF3SnNiaHY3cmN4enBX?=
 =?utf-8?B?T1Z1RGllM21jcXg4dXV3cFJDRVJkZVpqOWtoUXVUaHk0ZjZETmQxV016Y0Vw?=
 =?utf-8?B?dHFiZzBkT2MrZzFZb0V1RXdhVTRMU3RYODMrUnBnVFVtQW5vUFdCSU9ZUW1o?=
 =?utf-8?B?SFJPM3FmWm1DK3VFNDZFcDE0OW5pNktxNXUzeXJuckFTZXNqeks4TDRwWU5G?=
 =?utf-8?B?eFpiQW9wVk9YK0NWVXFMajNsenVEU3ZHYzVNcWZsMDlwUWIxTUU4OFY1N0RO?=
 =?utf-8?B?QTVjY2Z4ZjNpblRKRThZMUlITmxmMUcwQlBiYkRSYjl6aE5RQXpZUlFTY0xp?=
 =?utf-8?B?azY3ODhaL214cXJTN1R0ajBjTExwaGdBa3RTNmFvd1pPeUpwRTJJaS9oRktC?=
 =?utf-8?B?WWpKZ0JkOVo1YzRmbGhUdUF6d3RwSWs0Tkw2K0x0dWh3Ni8zYm4xMEFrWHV3?=
 =?utf-8?B?VlNqaWlmZmkzNnZGejdrc2JBSFc0MURQNHpUWVNwK0FpUW1FanZRVWN6STdi?=
 =?utf-8?B?cTFxOG5MSGptN2R6cDFIMEJENkpCeTU0ckhHTlpwRWI1TmtKV3VGZVpOL2xU?=
 =?utf-8?B?WmowNkNoTDNWQllKR2hyc2wyNkxZY3hWRzJFQUFkU0xVMEdHM3cwbng1Q0ZD?=
 =?utf-8?B?R2pxUXJUR2l6MVYxQ2E1WXJ1YXVWeGVBcTMydmJEMGVpZ3FwWElEZjBSdklH?=
 =?utf-8?B?MFNkQ2U5RmFCNEhlSWNCQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGo2bCtTMVFjRitId09tdlUzditUN21VSXIwaUxPVDU0VFBYb3lnRk8wZkhZ?=
 =?utf-8?B?T0FOdjNLaEE1SG82YTZHNjBxQTVaRzZWMEdweXhXTlA2U3pVLzBpSEF5OEg5?=
 =?utf-8?B?cXJvTGlMalNtdkNPOU9nNXVRdzRTMTdJSUhFUlFLRTlhRVJ6ZytoY0JKM084?=
 =?utf-8?B?Y2tVNXY5VDFmUTdwL0tyMWo3SXAxNlkzR1hzREkxTXc4a1dQNjZNclNlRjlM?=
 =?utf-8?B?Uys4bzZodGpaLzdBNlV1ZTRudXo2MWZYYmh2RHI1NzBsVWZzU1I1bkFyR3Y2?=
 =?utf-8?B?SDd1bW5ORldVUEdObW03TXFLUitkNlNkOXY2NlZNajNHM0RRSXRKc3NMbXlC?=
 =?utf-8?B?b3AzZy9GMEVDTmllZTRFTGprckwzcHBtcFhTUE9sTGFxS0hhU2Q4TUJTeXJ0?=
 =?utf-8?B?aWU5Rkl6Z3Ztd1pncFdXM2hKMkQ5cHFtOVNjbXZUODk1cUM0SkNnZHoyejgz?=
 =?utf-8?B?S01Fdzd6MzVsQVB2anZUbGJ0N3gxMElQUXlybUo1TjkxbEJTMGZVaEhlWVM1?=
 =?utf-8?B?UGl4NU84S0M3cUJhN2plUTRybkVHdXhsdGpXVWJKd1owYTFLM3lmT2puWEtO?=
 =?utf-8?B?UWRZd2dDcUpqMnN0b29VYWR6RS9ReWNBNE0raFNFWGxLTVpJdmIxVFJwN0gz?=
 =?utf-8?B?S2JvQytwL3BzZll5MXJSMThIVVYxTjhmeEVxSUZ4K1l5K09GbHdLcXBvV0xh?=
 =?utf-8?B?WGpqemcvb2ZTdWRabC9iMkUrSFBrbDArQ2FxNkg1SDdOSGZTNHhPY0JudFJH?=
 =?utf-8?B?QjMzbWVFM041aU5ZYTlXdE5CQUEvWm5DN2h1N2RFKzFCRXF0bElkVFR2bWZ0?=
 =?utf-8?B?azk5SzY1RnNWcUpkdUhrdHRWei9sRFI0SW1oQy96ZFpXclVuR3JWQ3lkdjZx?=
 =?utf-8?B?dlhUZlppRFlIRkltUkVOTWdONlZoWTFvQm03a0xGUlhnL0Q2SVdTdkl0ZmFO?=
 =?utf-8?B?RWFCdmtwbnlUWFVscXdUYXRQOE5mc0hySDJ6MmV6cHdJWHFHamlhK0Y1b01v?=
 =?utf-8?B?Y2txcUprbmhvTzVMc29sS0JhSksrbXNJRWhlZm5jdCtPbXpmT0dDcTl3cWZF?=
 =?utf-8?B?aDhlNDhDMGZwQTlIOE1sZHhHQ0FxNmtUelBwUFM3c0llRkxtZURNbEpoUVM0?=
 =?utf-8?B?WHVqVldrMGNha0dQTVh6QjVpN2UxVlVxQktwVkhyelFId1NqM082aytCajNJ?=
 =?utf-8?B?Ni9rQXA1WGJ0UEdYSEtsYmFZVklZM2M4RWVrRkF0ZHhLVXJObGtyR0M2dXh4?=
 =?utf-8?B?eHdSL3hxY1ZuSnRicEEvYlQ3Ti9UcGEvOThONXNuVXNTbzZBMmZha2tOUDRo?=
 =?utf-8?B?VDVJa2xPeDJFWUVJYnN5RHJucVZGWVpLcEU0bTBBN3lNOW4zOURqRHJjR2FT?=
 =?utf-8?B?citkREFZdDNLODVKRVZrMHgwRy92cVdrdjhQcXA5NXRROTRCR1AwR0FrcHJp?=
 =?utf-8?B?YU5EVXRGMDgrZ0FhMHdKWkxxNUtWUENlelQwWFlESEhrTjZRRHpwcE5BYnM1?=
 =?utf-8?B?QkxRMW1BY1p2aUQ2NVg3ZDNma2dkUXMydlRxazhKNGZqZElWTE8rdFk3cDhL?=
 =?utf-8?B?aHdwRjMyamVYK2RVdGRiVldQdTVvYThCZWhLU1Q4b0lvWDh2aFJxWS9FZmdm?=
 =?utf-8?B?SWc3SU9pVGZ3YlV0cSthMjZlY0ljSkFJTDlXYk1MbHpkelkzVHUvUXFXN3ZC?=
 =?utf-8?B?UG9jYjd3NmVuM1VWeEJYanozeXJoYVZaOUtodmNzN2lWL3BWUyt1R3JETnlt?=
 =?utf-8?B?Q1dGS2dtbTBtam5YQzJsejJpbkxNdGxWam5BUHlVYjdVV0VYU3NDTDVTYjdn?=
 =?utf-8?B?S0E1dDVQKzJWK3BpN0w4a0xWbWJBbStpZGg4RU03dVdlR1dSeDhMLzhyblIr?=
 =?utf-8?B?VUFzUVRrbXFKWStBY1VGa2RpMGhKTUwyNFZnQzlCWnU3MjM1Zi9jVFVmOCs1?=
 =?utf-8?B?Q3MvaCs2cEVXK0dJNXdxTFJqcGJWWExUN0dWQmRxNFpOWWluSFRNckpDWGRp?=
 =?utf-8?B?T3haRnhPYVpTbjZQOG0xSWI3dnVqK2djTHFjM0MzeGpJUGJHclIrM0QwY1dt?=
 =?utf-8?B?NmF0dGpkT3VDNExIdnAyMVZ4M1RHYlFtNjNCdXl3NHJMOFczUEQ0Z3RzWnRI?=
 =?utf-8?B?bHdRa1ZIQ2VBdHJHT1BhQ1Bjekhqa1hIUTVidnovOHlkRnFHWkh3dWtPZ09q?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ls/Ae3i/ZNIVdW/wX104pT7nCxrMRCknqpjKUSEiVtpsYt5QWrG7N1r9WhMVrQ56szYzt04vHsH/EuuvUAKP4h1oQmIsWFuohIXfpL/+JIG4QZiiGW2JQknSvIDnWPbj3lrjjKaHNu7ALnH+ao4juw6HXfR66xFT2ZWnXquNGAAxf5T3HlgR3ErPrZOHUn6W8p68PJbNPzy0RztDbA6Lzy1rLwme4m0xarfKkBagBrXroO+7kiRZinh9K/CdkTGdBq1E2wJPnk9pB0dsnEJVhLGX5UxyZ0OJyAK7lkLWMmiNYFAH+8Avn2+xHRDFATfqDXhf5bopfwZ8cIJKgpm0aLP+Bf5S6ZTEKlt9w98mpGfwl2TmF+rHqE60EvL4gSKF9O07mUzpIZa/AOQMBpErjM6KrNg9cs7tgi79nd5B7ULS1ySfc+EkV0iEZ+pI7/RLrnyCin/PBf1fKuzliT1zDbPE2qOseezlK1qAd+gSYT6cet+DjIjea4p3qxqCGdO6LI2RHkElF+QOkblNQWhy5J4BM1hihI2J7N2cIo6MZOlOjFSK22oKJ8+I2bnggltJbZbW23d16JAraXifh6wmg55hjLmABjAFgS2DrapMg4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4886a654-52ed-40ab-03b7-08dcaaee4f6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:06:09.3505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bjl/HD+tzNCquDIdf8q8oz4uIFFpxV8pa8PixucCQSj0RTlDytmAiILRl0PEbTNMvBPLYAweawbKnY0e3hM2X+WbwMPTIhkdtL1/iaiIT7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230059
X-Proofpoint-GUID: bFaJ-3kD_Nde1vlXQbO9GeguwVClix8S
X-Proofpoint-ORIG-GUID: bFaJ-3kD_Nde1vlXQbO9GeguwVClix8S
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

On 23/07/2024 08:55, Eric Auger wrote:
> 
> 
> On 7/23/24 09:44, Cédric Le Goater wrote:
>> On 7/23/24 09:38, Eric Auger wrote:
>>> Hi Joao,
>>>
>>> On 7/22/24 23:13, Joao Martins wrote:
>>>> Move the HostIOMMUDevice::realize() to be invoked during the attach
>>>> of the device
>>>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This
>>>> allows the use
>>>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell
>>>> if the IOMMU
>>>> behind the device supports dirty tracking.
>>>>
>>>> Note: The HostIOMMUDevice data from legacy backend is static and
>>>> doesn't
>>>> need any information from the (type1-iommu) backend to be initialized.
>>>> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
>>>> iommufd FD to be connected and having a devid to be able to
>>>> successfully
>>> Nit: maybe this comment shall be also added in iommufd.c before the call
>>> to vfio_device_hiod_realize() to avoid someone else to move that call
>>> earlier at some point
>>>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>>>> different places within the backend .attach_device() implementation.
>>>>
>>>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>   hw/vfio/common.c              | 16 ++++++----------
>>>>   hw/vfio/container.c           |  4 ++++
>>>>   hw/vfio/helpers.c             | 11 +++++++++++
>>>>   hw/vfio/iommufd.c             |  4 ++++
>>>>   5 files changed, 26 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>> b/include/hw/vfio/vfio-common.h
>>>> index 1a96678f8c38..4e44b26d3c45 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>>>   void vfio_reset_handler(void *opaque);
>>>>   struct vfio_device_info *vfio_get_device_info(int fd);
>>>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>                           AddressSpace *as, Error **errp);
>>>>   void vfio_detach_device(VFIODevice *vbasedev);
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 784e266e6aab..da12cbd56408 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice
>>>> *vbasedev,
>>>>   {
>>>>       const VFIOIOMMUClass *ops =
>>>>          
>>>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>>> -    HostIOMMUDevice *hiod;
>>>> +    HostIOMMUDevice *hiod = NULL;
>>>>         if (vbasedev->iommufd) {
>>>>           ops =
>>>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name,
>>>> VFIODevice *vbasedev,
>>>>         assert(ops);
>>>>   -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>> -        return false;
>>>> -    }
>>>>   -    if (vbasedev->mdev) {
>>>> -        return true;
>>>> +    if (!vbasedev->mdev) {
>>>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>> +        vbasedev->hiod = hiod;
>>>>       }
>>>>   -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>>>> errp)) {
>>>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>           object_unref(hiod);
>>>> -        ops->detach_device(vbasedev);
>>>> +        vbasedev->hiod = NULL;
>>>>           return false;
>>>>       }
>>>> -    vbasedev->hiod = hiod;
>>>>         return true;
>>>>   }
>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>> index 10cb4b4320ac..9ccdb639ac84 100644
>>>> --- a/hw/vfio/container.c
>>>> +++ b/hw/vfio/container.c
>>>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const
>>>> char *name, VFIODevice *vbasedev,
>>>>         trace_vfio_attach_device(vbasedev->name, groupid);
>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>> +        return false;
>>> don't you want to go to err_alloc_ioas instead?
>>
>> hmm, the err_alloc_ioas label is in a different function
>> iommufd_cdev_attach().
>>
>> may be you meant the comment for routine iommufd_cdev_attach() and
>> label err_connect_bind ?
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>>> +    }
>>>> +
>>>>       group = vfio_get_group(groupid, as, errp);
>>>>       if (!group) {
>>>>           return false;
>>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>>> index 7e23e9080c9d..ea15c79db0a3 100644
>>>> --- a/hw/vfio/helpers.c
>>>> +++ b/hw/vfio/helpers.c
>>>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>>>>       subsys = realpath(tmp, NULL);
>>>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>>>   }
>>>> +
>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>>>> +{
>>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>>> +
>>>> +    if (!hiod) {
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod,
>>>> vbasedev, errp);
>>>> +}
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 5e2fc1ce089d..2324bf892c56 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char
>>>> *name, VFIODevice *vbasedev,
>>>>         space = vfio_get_address_space(as);
>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>> +        return false;
> Hum sorry my previous comment was targetting that place. I think
> unrolling is needed up to put_address_space
> 
> so effectively this does not match err_alloc_ioas but I guess we would
> need another label
> 

You're right. We haven't yet attached rthe device and that's what err_alloc_ioas
would do. Adding another label not sure would make things cleaner given the
ordering requirement. So maybe this instead?

@@ -482,7 +483,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice
*vbasedev,
     space = vfio_get_address_space(as);

     if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        return false;
+        vfio_put_address_space(space);
+        goto err_connect_bind;
     }

     /* try to attach to an existing container in this space */


