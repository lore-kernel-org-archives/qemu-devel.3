Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BADC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYlZh-0007Pc-Em; Mon, 07 Jul 2025 09:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYlZE-0007Fa-8B
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:07:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYlZB-000848-0z
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:07:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567BMRtr027112;
 Mon, 7 Jul 2025 13:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wPRmYRT/tQ3ZofjYgUuEOkEDSmlVdrOq8UqnUgM+F/Y=; b=
 aBTuszAHZrFimpHI3lXv5CRutda+XSBFFroSFydMt+ZQ8GLRKym5IIhmYQZtjiiN
 84cgPVpOJ7O54T3E/IkBshRLMBUjWjZC4mU96WmvwdUpdnKjUT3GIib7oQ/pTr2Q
 /u74ESsY2uWMKMGQHG+ooQ+am/FRs9r3bCRzQKAt8LPUKP7Rs/iC8mrWDn6F6J9Q
 sYMDMbAjuqX8c4oUd8oWw8+wkG9BCGdDDnqU084785k57WiXEt/f10ulSOFcioKS
 Vkhi77H6oWQgCXCyA8Zb28DL6PIenle2fu54ovcsLsTjDDnUaH2OpBRGmV1DI3RU
 KmIopJXO4u6bI0tQBq6zcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rda186m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 13:07:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567B7i8r021551; Mon, 7 Jul 2025 13:07:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg8795a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 13:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE+ci3JYSQOrzq9fqaNKL+kOqie41SP0x1+CP0U64fYvEJk3UhL8VkhLEmdkRuT0fknUO5hAnM+EN6PjM9qB//aHqAGXL3No8WXcXVm+OuiBabyc7kM7+SiRqvCXWELyCeHZDCZMewXw2Eah7XJECPn3y6Gvo/Hhp0DwXXm2mVZZQJmX/fBW/Q8YSIdZ/cmmcNMLCScefupx9YIbNkvv8HlH6x9kmtsKqFbMc7RBbewvj1kDCHphDCHtZHEw8M2OkH/tg8utMBa+vSmimtvlHMAI22ugd60zm6T2TnFsRlD6RQnQrau2d/k3+2+0aORvHkas5tHpJPqIVVPcW+X0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPRmYRT/tQ3ZofjYgUuEOkEDSmlVdrOq8UqnUgM+F/Y=;
 b=YR/mw8qxC9omj2i7MqrZgL7utNupqyqhO3UGR20j3j8+WcKKMjqpIoykbqasa4LBD43FqWFa2WIczi6kxC4E0HBzRofOGM2+hfRIBjjRwsX47lRnFqC2URgDevw8TxXLgVMXGws776H8oQGFfgybHYcXGKn7r3ZPHa+lwOZCAxubc9yLnCZBZ03FoNBqVf9Ga0x+SK+8XmveeWt9DW7m8QtcZWnhajNf0G3m68P2qShHwrqTfxe1J6vaA3N1TWCvU+0PYyJHKZfmNTTf2PVAAZADBTdmo1P/KcTRaAfuJt7/PpmIhW5xwHVyJK6Rou9xBIa+RB5CInb4VPSOf6o4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPRmYRT/tQ3ZofjYgUuEOkEDSmlVdrOq8UqnUgM+F/Y=;
 b=oK1efwxjGDuSKb+N1vQlUHQ89kYZTyC0mvnryNYes6PJbd9/AMH3wd0tJGdTIVHZToxSmiSQaI/R5kKXZZvFRhDsIzlOLzz52sO3KSljNcFbPWM9ID9SAcB1564d69LQFjfx45U7TPVUSxczgmvd0LXh01ujB6dI4EQ3C7hp/to=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 13:07:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 13:07:05 +0000
Message-ID: <e59077f9-b39d-4eaa-8e16-9aeb37ec91ec@oracle.com>
Date: Mon, 7 Jul 2025 09:07:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/21] migration: close kvm after cpr
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-4-git-send-email-steven.sistare@oracle.com>
 <e51734be-8949-4856-9107-16acdb6a80da@oracle.com>
 <IA3PR11MB9136B12D6587CB5C96D763A59242A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136B12D6587CB5C96D763A59242A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a99441-0ea5-45d4-a3a5-08ddbd572c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1lWODdkbElsOTR4Ym43WUF3YnN3SlBKT0RGU2l0TUpMdkR1bEljNHFac0tM?=
 =?utf-8?B?L0xWT0E1bngwN0JVQ1lpcW1mQTYwempGeXFPclFsMHpVYXdidUJQaVRrRmE3?=
 =?utf-8?B?cnlieXhyMUc4NEdEd3FHcTN0Tm5vM2hNcXFRbkJmK3RQNTFTMUJVaTJkVllt?=
 =?utf-8?B?R3pHOWQxUTh4YVJPVTJjaEE3S2RYWTFDSUJYa0dVc1o3cDFnWWNsNEY2dHJu?=
 =?utf-8?B?SjlEaWdBNVBKWnVtNnJZSE0va2hCbWhxak1hbHJlUTIwTUo5QnRTS2ZEeVZN?=
 =?utf-8?B?N1pYeEVDMW1tb2p1SndDMUZDdmFUL2ZZcDBEWXJlN3Y1TC80VG1YbWdFejRl?=
 =?utf-8?B?czRkTThkOFRjWk80MlZldzZHQ1dpbGVLWE9VeENHaHpZMjFIekhWWGVac1lB?=
 =?utf-8?B?eFlBNHlQK3lQbE5kOHN6N0k4U2d5NUZYbnVGMzdBV0cxQlpDbHZJVmVPS0tP?=
 =?utf-8?B?eDFxbEQxQmJTWFNiamVvSG9LRmJlZDFUWmdXVlJ6dmJxUzZoMU5mYWhUaVl0?=
 =?utf-8?B?NWJsQzZXbHVWbTZCcDF4QWVabktCR3RIT1RPdkhTcUFRWm1SS3ZGQzNwdEtz?=
 =?utf-8?B?bCtCMGdoUEw5alVZWmFRNkthTllvd2hWaXFGR1R2Vmd1VUZwcnVoc0dUcTdS?=
 =?utf-8?B?ekJiTnVxTGk4dzdUOTFvTjN3Y3Nxd0xaako2VWQ4TzF3YSsrWFJaTHZhTW5r?=
 =?utf-8?B?bUFpeVJMTmFiblBWYW4xWVJYOE9lZlYzQjRsSmxRMDN4QWlGSUM2TisrYU1B?=
 =?utf-8?B?eHFyaElXOHphZWJFQzhHNWNyUUQzS1BOZDRaUlRDZlBpekkyaHQ5RHUxajc0?=
 =?utf-8?B?aU9qK0NGc2pmeHlZa0cyc1dPNTBsS0N3eFcrTHRRRzdXeUdVbk8xMjRrQmIv?=
 =?utf-8?B?VmhQNnlrS1Q1K2c5cHdQbGc3UVZUVlRGbEZEaE9YQVN3dWdCanB4NklsZW1m?=
 =?utf-8?B?Tk5NRWh1NlpTdkd3UHdBTkhFalpmekVJblFuUWtud3lGRVlXVDUrdUw4OUlL?=
 =?utf-8?B?RFk0MzhoNFpRbUViTzRycXUyRlBRSXNRcW5QSmt4UExvRWl1RFAzVHZiaEhu?=
 =?utf-8?B?MTNXRmg2aGJNODZ2Z3dYVWpibzFjbTRvT0x3WnJwc2d3ZldZYkc2cGx1cFF5?=
 =?utf-8?B?MnFrRU9FaVJiVFZZbitrNHRPaEQrOU43alhwa0NBendNSURGM0JTOXdQWmky?=
 =?utf-8?B?K0xjalNiMCtZS1M2Um5TQURXeHRsTDhCSnJ3SEZpUWZIMzBuVk0wbDNWSmNH?=
 =?utf-8?B?ZmZ3aGJJZUh1TzR1V01HcUdNWHV4SlR5VkdWcHlQcmVSTVBuRUNjTjFmSWFB?=
 =?utf-8?B?cDduQ3hxemJlbkdjRGVna0xZUHhUUGU5dkZSVThIdEhXNVp6Z0pIeHl2RURK?=
 =?utf-8?B?SFFFU3pyeTMzdHRlQ0hIOEdhRmE0NldnVDljaUUyMXg3dXMwcmE5N1dTcTNi?=
 =?utf-8?B?b2tXUndsN24wQWNIQVVnR1Q1Nm5aQWo3YXBQcVM1bUFqMXNweFh0K0lEMEhl?=
 =?utf-8?B?TER0bENYazVtM0hTZ0ZubXRTazNROHh3Z2Y0QU4vRW5tak95YytSZWhRQVJ5?=
 =?utf-8?B?cUtCeDJ2ZFNHYnpZYk0wcnA5SzJwSGxZYU1KS00zUVhuMThzYlJwaU5yMGVR?=
 =?utf-8?B?cVRNMUYrMEtMSG94RVRQeTlITjdoWFJGUmZpc3lWbVlRNkk5amtBZ0pVU1cx?=
 =?utf-8?B?WG44UVNEZlNKcnY3TXFCODRoM1YxdWdMTVFDTTAwRWRLcFNjWndtODRBeU1T?=
 =?utf-8?B?cEpzcXdqZUVSaXRJN1RyZmxTNFFDK1pXWVg5dTJrQ1FteU5MN2p2ZW1nZW8v?=
 =?utf-8?B?RVd2RXZueHYvMkM0TTRxc3Z0eERKc3FiakNPb1ZqYlZpaWdaTCtJcDNxYUVQ?=
 =?utf-8?B?b3pHMXI3Uk04b2cyMi9LeklCMFR2MkJnK3kzaTB1UC9ueEE3ZHJWR3B1SURS?=
 =?utf-8?Q?YneugdjCAso=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVlZmE2MzdiWHpkclVobHJVenpKVDVtT1ZhRWFYTVRITExZQm9xRHFicHEv?=
 =?utf-8?B?S2N1d3MvcjhVNTU4cko0d0RzRTVaRFRiL1pxODJqdjlaZDB3ZTBXMHYyemda?=
 =?utf-8?B?elRZekhJYUNNVC9QcTNFN01lTzBOdFl3YVdjZE1SMGh3eG5lQldKT3NKdHN2?=
 =?utf-8?B?UXRnTk45ck0vajFQRGhSTzFkSGJmOFAvZ2VkS3J3V0tJc2duRzBMMkdPUWwx?=
 =?utf-8?B?NHdEWkpZZnQxaEpoSHh5bm5UZklBMmNxaGt5Z0I0d1RMQmdvWUxhV1dyckpW?=
 =?utf-8?B?T3dJRC9BR1U5Nk5pZDNJQkJQQVk4TmpzTEljQWpaWXhvd1FialQ2aWhscFRo?=
 =?utf-8?B?UzlmMUFXclhBUy90VTJxaTlJRGdZem43VDMwdlpDOTBNbTc2djdoZmpBMzNG?=
 =?utf-8?B?bG1pTmllWlUxdURhSmNFSnNybEl3cnJMRzJQUG8wR2lzRml0dk10WW5IcVBo?=
 =?utf-8?B?OTFmSFdFdFZLSkZxN2JxblhDWWh3dmhxNUsxY0pMSlhLMHgvWjFmdDVyam43?=
 =?utf-8?B?T3NEMGkzTzA5bkRGcmM4VjYzNk9MbkVocDczcEJWeHJlSEJGRmpsWHJJRVVu?=
 =?utf-8?B?Wk5HSUNJR2szNlNXRzQvQVVPb09ObWdudVZpVEhMNTFGdFV4L2xWTDVJUHBE?=
 =?utf-8?B?SDc5cGRTV3RmK1VpR08xQ3doTGdzN2lIaFFBZExDYU8wdWtpR0NPSVd1M04v?=
 =?utf-8?B?QkdmMGFpa2dpaGJlb3M3UzRzTGI4ZlZhZXdyWG5DV0dsdE9JVndYekdsdXBt?=
 =?utf-8?B?akpiYU8reEFTT3RGTFB4ZmhkQ29hV1FIdUF6eGtVcVc2dGlndHhMQ0lYcldy?=
 =?utf-8?B?RHdJbVRSSGxtbXlER2EvcVFDWG9tQmliMm0wcWlqTUxPSzZhTW05T2tFaEpF?=
 =?utf-8?B?c0dhN2diRlVjaWkyc0MxcGJQWWNnbVpKSUFzaUh3NTNPM2VKdlQ3ZGp6UkE5?=
 =?utf-8?B?L3IxSGJSVFBhVXBKTEpnb3gyVlcrT2dxWGo2bUhDY0FZQ3F1cUFDbVNxNVo5?=
 =?utf-8?B?OURtUkVRQXpsUE13WDg5ZVMxMUtYOWhXakV1RmxyOWIxNEh0RFdNamIyalQ3?=
 =?utf-8?B?OU91N2FERkgrQTM4T3NFVTRUQ0d6N2pyNW9lNHdZeFN1bzFqWkdFZ2laekNW?=
 =?utf-8?B?V1F2anZKSHI2djk4M1BURTNSYThHYURneE9ISDZTSTZyS0xtK05GeUViZzBI?=
 =?utf-8?B?OWlYcDM2ZFFtbFhhSkRZd2RrN21WU3Jua05QWjdTaXFIRXdSWnluZGRhMnU0?=
 =?utf-8?B?Z0xBUW4rdWF6RnJTd005TU5ZZDdQc0dISzRmd1hmVVQxWkgwekg3R2ZJRklO?=
 =?utf-8?B?YmJjdEZrU3g2engyNm9rZ0szdGdKMmV4bVhsVkFyc0tYMHdVd1RzVmszMlRP?=
 =?utf-8?B?aUlVdVJYL3VWTTRKYlF5ZmhVZHNzVENtOWVjZCtVMDlKcmVTdTdoOUlqeDhZ?=
 =?utf-8?B?Yy8wOXRBc3Y2MHJSNytzZEYvSU9TQnNuYlNGUDJ1VnZ2RjRRRjdPLzJaS01U?=
 =?utf-8?B?S0NtSk9abWhMOFJ5ajJOOTRRVDc3QldVbmcrYU00ZkVOZGV6SktrbFFmbVB3?=
 =?utf-8?B?dm9wTXpPNk5tZ3pzQ285RHkyZ3lxUVYwa2tPWGtZYmk4RXViV0pBWDUyTkgv?=
 =?utf-8?B?SUJqclBSaVBYaXVMZVlpMXlsY3d4R0RsQnF3ZUYxY1liWThsSkxFbDdGeWtu?=
 =?utf-8?B?R3ppTkR2cDZ5OUNxRlhJOU9PSFllNS9SYlpUbk80ME5XVDhrT3NuVCtjQkYz?=
 =?utf-8?B?ZmRMazY0eFpSeTlVWG5oYlRRL0lqV0ozczFYMEdiWm94a0YzUGpqdllxd2hP?=
 =?utf-8?B?SEROektIY3pXczFoWERMSlplZEdraEMxVnF4UDlTSTBKcmlEeE05dGRmOVdu?=
 =?utf-8?B?ZHZ5ai9neXF3K3VEU201dXFIalVxM3FhQmZZR0pLK2YrdU5OUndZWmw4UEdm?=
 =?utf-8?B?S3hPeXZHWEFnbWY1bkhkKzl0MTNUZzFlY1pwZ3ZCSTN5K3VUbXhvZytVTEh4?=
 =?utf-8?B?em54VTVxcGNBK0hWMG91bDQ1UENCelRGZnB6NXB2NXBkS1FLTFRkTUpmdVhp?=
 =?utf-8?B?TkV2eXhCTC9qdEIxbk1PUnhFZkhIMUwxVGZsdnhLMHl3TjNtMFpSeWRYSnQz?=
 =?utf-8?B?YlRhUm1qSG9QTEZLbUg5bEtpNFlOajlTbFFNMFVScHFtQmZia3paQXZFL3JJ?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EUBPHhKXC6oz5MxQaOAMqFMc/Cv2vok+zurMrCOFZW75PZqfyV1L0J3BUtlPRgrrn5fHkTd1eLDQ1xx5yKrS/+JhE8PdemXO0nkcSoDwxoCov+KqBEZsGSAOMMrpkT77wGPVd+dzWIserFHxItfCOJVM6JJN/ObUipOVnnbUqYImT1gype/ORbI4/LTIgDooS4zVG/2tL5Qw2xIlgcuB9YWMw+XsCPfIzXLl9F2TXaLRhn4Nc4by+lxHl40UQE7LSM9fLIImGJ8YxkWc2mXLgkuumkqjShj1Y9Fgc5GniCPMf7kt7XcO/rMBUM5rjDAqq7ZQzdsX/Xb9OzefEZYFqvnjzi4doWeeiWkhT7ya5n0eEO2t0QHSSKgfcPauqH3l8/wxtyxBrQiZX2txyCYYt0IACKwxaclsC4xdg115FTBK+5e2+l/OEdkdqokB5nOkmWQJH88p9MPohCzgICNEIjxoRSrL2lkpKAV+tdE4csmLvsYOUwp/cXfRU8nvtkrf3chqxXQNTEu/URS+MEFVwxn8606vdfVzwd56+9OKGZwSC3fGuQBtKb8eta5djYiyMXRJOh2BNJ71SBy3fENykQYhSdqStdiCgE9IYCd1nXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a99441-0ea5-45d4-a3a5-08ddbd572c06
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:07:05.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z5lBrL9Ff+PO8JHGaJL6xZYQnlR9jylveGOQnqqvjCc3+aPrM3BM396D+SpH+YFopxNcdD1k+WeV38oFkCAsOsRxqMrNI/7dcU5PdNcpw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA3NiBTYWx0ZWRfX38ROKcMJGxGy
 7199l6gA38mr67MR0pW5EYjqW+P6glVQZc29JcTFpz962TWgDiszUrWo/A3plFaJsMWBH29ikq8
 +bQE4r1A3JBbvkARHfHAItR3SjYrKi1LxZwkXB/cf5U6Cbo8a2iYgEMD7cNmQ1It+r7mPf/sIBG
 uecW+/qTkeyC3MK8HC2+QGrzBBapuHvXKThIO/BzbFwY1RjbO30fQ+8Hkacir0zJ2N6HHRH2wuz
 noST+qXkWruyLQSOAC54vh1RVtnE1Egj5gXLQ+O+wN+IhjBagKMNMGpX/d2U2hkTkmF9yaNqkOa
 FuFQGuGAqaxIQspo4CMtMR51t1hWjU4EvJTUwusL5WaHNGIyx+B0WyA1OobZs7n598o63bOLo+p
 Oh7UqrVlS0EngeGaCq6+FgRGJx/weGFTVAE9qfBWy9zZ5ysRhgudOae5HDr7pcAvQJUQ46Lq
X-Authority-Analysis: v=2.4 cv=QMNoRhLL c=1 sm=1 tr=0 ts=686bc67d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=dljVSj5mP-xQco8bpeoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6KJO3A4gwgSfxDrFuz9zvQeGhuV4zhlW
X-Proofpoint-ORIG-GUID: 6KJO3A4gwgSfxDrFuz9zvQeGhuV4zhlW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 7/4/2025 5:50 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V6 03/21] migration: close kvm after cpr
>>
>> cc Paolo.
>>
>> After incorporating Peter's feedback, IMO this version reads well:
>>    * kvm exports kvm_close
>>    * vfio exports vfio_kvm_device_close
>>    * vfio-cpr registers a notifier that calls vfio_kvm_device_close
>>
>> - Steve
>>
>> On 7/2/2025 5:58 PM, Steve Sistare wrote:
>>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>>> the host system log shows:
>>>     irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>>> which is EBUSY.  This occurs because KVM descriptors are still open in
>>> the old QEMU process.  Close them.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>    include/hw/vfio/vfio-cpr.h    |  2 ++
>>>    include/hw/vfio/vfio-device.h |  2 ++
>>>    include/system/kvm.h          |  1 +
>>>    accel/kvm/kvm-all.c           | 32
>> ++++++++++++++++++++++++++++++++
>>>    hw/vfio/cpr-legacy.c          |  2 ++
>>>    hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
>>>    hw/vfio/helpers.c             | 11 +++++++++++
>>>    7 files changed, 71 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index 25e74ee..099d54f 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -62,4 +62,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice
>> *vdev, const char *name,
>>>
>>>    extern const VMStateDescription vfio_cpr_pci_vmstate;
>>>
>>> +void vfio_cpr_add_kvm_notifier(void);
>>> +
>>>    #endif /* HW_VFIO_VFIO_CPR_H */
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index c616652..f503837 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -283,4 +283,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev,
>> const char *str, Error **errp);
>>>    void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps
>> *ops,
>>>                          DeviceState *dev, bool ram_discard);
>>>    int vfio_device_get_aw_bits(VFIODevice *vdev);
>>> +
>>> +void vfio_kvm_device_close(void);
>>>    #endif /* HW_VFIO_VFIO_COMMON_H */
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index 7cc60d2..4896a3c 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
>>>    int kvm_has_vcpu_events(void);
>>>    int kvm_max_nested_state_length(void);
>>>    int kvm_has_gsi_routing(void);
>>> +void kvm_close(void);
>>>
>>>    /**
>>>     * kvm_arm_supports_user_irq
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index d095d1b..8141854 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>            goto err;
>>>        }
>>>
>>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it
>> */
>>> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
>>> +        s->coalesced_mmio_ring = NULL;
>>> +    }
>>> +
>>>        ret = munmap(cpu->kvm_run, mmap_size);
>>>        if (ret < 0) {
>>>            goto err;
>>>        }
>>> +    cpu->kvm_run = NULL;
>>>
>>>        if (cpu->kvm_dirty_gfns) {
>>>            ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>>            if (ret < 0) {
>>>                goto err;
>>>            }
>>> +        cpu->kvm_dirty_gfns = NULL;
>>>        }
>>>
>>>        kvm_park_vcpu(cpu);
>>> @@ -608,6 +615,31 @@ err:
>>>        return ret;
>>>    }
>>>
>>> +void kvm_close(void)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    if (!kvm_state || kvm_state->fd == -1) {
>>> +        return;
>>> +    }
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        cpu_remove_sync(cpu);
>>> +        close(cpu->kvm_fd);
>>> +        cpu->kvm_fd = -1;
>>> +        close(cpu->kvm_vcpu_stats_fd);
>>> +        cpu->kvm_vcpu_stats_fd = -1;
>>> +    }
>>> +
>>> +    if (kvm_state && kvm_state->fd != -1) {
>>> +        close(kvm_state->vmfd);
>>> +        kvm_state->vmfd = -1;
>>> +        close(kvm_state->fd);
>>> +        kvm_state->fd = -1;
>>> +    }
>>> +    kvm_state = NULL;
>>> +}
>>> +
>>>    /*
>>>     * dirty pages logging control
>>>     */
>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>> index a84c324..daa3523 100644
>>> --- a/hw/vfio/cpr-legacy.c
>>> +++ b/hw/vfio/cpr-legacy.c
>>> @@ -177,6 +177,8 @@ bool
>> vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>>
>> MIG_MODE_CPR_TRANSFER, -1) == 0;
>>>        }
>>>
>>> +    vfio_cpr_add_kvm_notifier();
> 
> Hi Steven, I just noticed this, do we need to do same for iommufd?

Yes, and that call is added in patch
   "vfio/iommufd: register container for cpr"

> Do we need to delete notifier when all VFIO devices hot unplugged?

No need.  The notifier will be called, and close the kvm descriptors and
vfio_kvm_device_fd.  Not strictly necessary if vfio devices are no longer
present, but not harmful either.

- Steve


