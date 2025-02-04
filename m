Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7658DC02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLYd-0003T7-SZ; Tue, 04 Feb 2025 11:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLYT-0003J2-A3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:13:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLYP-0006pG-Nu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:13:40 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DU0TB022411;
 Tue, 4 Feb 2025 16:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=SckAvWDjY6PvclZL1O7x/R17kLXS8FsHqXsfnDYWn3c=; b=
 MEKk1ELaaThdFTEMxwR0e0oleMUYrDJ4LEq0DjNWLVdF1sDyz8xlxdzzLkvhY55P
 188ctIbk4d2IxZW90KD0aI9uifN6HkAXOVCcvfEpbwCdw0ICM74/WpaEip3Bl6Z3
 2MmIBqbazmvIQQNEoZpvU1rXEDgcE2Tp/RQRDAc7DbUW7SnnoXpBXYV/BMKizrmT
 k04puREzHDUc16z26CcFfk9LOjJe2wC5Wld6kxg+iwMm0E7uku/QCrPE98bjND36
 F28t73L0MSdjQQAv6krzpurpf/PJ+ziebZO5pYKius4s7w498uXtP86AfzhAE2L4
 vrA17CI9Du3C7L6otjWROQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4rcnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:13:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514F4Z7L029065; Tue, 4 Feb 2025 16:13:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8p36ch5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JB12y08lslgFLTZi6Fr6sc9d5tJa5JUhivJ6fYS4QTi42OLUqNdigE2jMKx4YYZLJ83L//oFWhTKITv7sQCNvjDM/0rszHl2B4Jev2wHNjWENBSuDAd4UXvNBgRGZv/4LX8cMYqjzWSm6qYFveqTa79fqIsZr5+n6pI4rQECXXtVTquWeQy61fkM7Wy4MGYsGJn58DMecbuUrHThuOA23FzxuqGZ+lY4LoG8WIAiDgtijEFL5Js456fZnixg9Qkm+x2jHSH1lYPD0QRrgT3SQyPMFtSRE7qggaBrf5q5jIgRpYkSbbzFxkyitQ9KXNKqTOl2Cql1LC94r36kpFs3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SckAvWDjY6PvclZL1O7x/R17kLXS8FsHqXsfnDYWn3c=;
 b=bs1xN389Szv9h+GJrA5s9/tG4izFDHb5pVZwbK7ycl3/S4+XX5QpeURk6H59uFOWmYqNjZCODAQFvkoXqF/yUH6oF7tphFQP+aERvvhbVZKLNXHlumO584m27IXYaLul/mffiJMexSawWupyrXT0isH8lTy3PsinZnBQ4phJACGZaMSKM4VE/FMGMokbvsROgFOu9SnxsmbR4/+PrbcUOCCmk+0yxFVcFyGhGL3YWpuYzfm5ScnOx8UNDyUcBsc3VE9uIaxH8yQiAgUELLePwH1NZJ0j1j3hE77ZetNZ1Immq6se9SCq7UO6Wu77AkfzS2ZwF52j4B8y5c5pNq7cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SckAvWDjY6PvclZL1O7x/R17kLXS8FsHqXsfnDYWn3c=;
 b=XN2LNAmqZoPGfwGQr0g1Ebjz1GyYEDpU/hr8HgT/wtrEHpP5uhnSPkdW2fpGwOMQg+hKgkMB9xFn2ZAzUewu9kqkdYt0wAyPlJ0bXk3UX6dPNEuMSlYdMcSTLQMRu4GM17tHt31/dN/oSGiclAY7SwJYTTYJnLwT2nMgUi9io80=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 16:13:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 16:13:25 +0000
Message-ID: <61cc8a3c-9af4-466a-b1c1-52692a24b28f@oracle.com>
Date: Tue, 4 Feb 2025 11:13:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 07/26] vfio/container: recover from unmap-all-vaddr
 failure
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-8-git-send-email-steven.sistare@oracle.com>
 <a5a4a10a-88d6-478b-b5a9-00f744bf08de@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <a5a4a10a-88d6-478b-b5a9-00f744bf08de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2109e9fb-c6c2-4a03-f3bc-08dd4536da8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRPZFBIaUpINHVvYjNETnA1VURUSm94RlRBcnVTZko3dFFkV1ROWEtWYzFT?=
 =?utf-8?B?WEZjUVMrQzhiT2piYm91Zkcva0RkMHRYSWFhV0QvZE5kVDRmR01mLzZMRmFW?=
 =?utf-8?B?bXdhS2dtN3VEOExZa1E2MGt1bG1VcnMxZmtoeGV6QTJwWllZWlJncDYvOUlH?=
 =?utf-8?B?ajRuV3NuMi9YSHlTNk5nT3JXWWR0WS9mWWQ3OGVZbXlVdmdDM0xYVnMzdEZX?=
 =?utf-8?B?VXZiT1FRRDFqeDBnallHN1doaTg1eGhUMHFqVW9QY3RIMVFFV2hraTc0YnVY?=
 =?utf-8?B?bXBGMU9JZFVITEkvY0lscmdVbDdzSlJiZFlwcFYwNDZYcldDZUtyVE9VZS9s?=
 =?utf-8?B?MlVsYVc5QW1qRTZ0OFJLSGFlTzNza1IzTkVaZzgwNXhjRDUrcDdPdEU2M25n?=
 =?utf-8?B?TTlvdzFCZzhEeVZEOWJUQkcyUFZRMVFldWZyME14VVQ2SUtMakpOb2ZMeWFo?=
 =?utf-8?B?VTlGd1UrMnFlQXhPSyttL2JsM09iQzJ4WUM2RXAwVW9NRDdmVGwyTE41RW5k?=
 =?utf-8?B?RHM3UndWMGdETmJwNTNMNDMxQktrUXgzUDlhWDl1TkcvZWtOblhRcFBzRkRT?=
 =?utf-8?B?aE9HT1pWRlNKb2xVMm1rNFRJT2ZNeERWUCtVZndkaXg0RktjUmF4V21sY0NN?=
 =?utf-8?B?cyt5bmtwSzBNRlcvcFIyMjhweFp5djFMQklCZkI4UDl4dGxFVis0dEdoSEcw?=
 =?utf-8?B?L3V0OG5IWVFFM3pLdkVMa1JHOFlreS9BdGJIMWVlNVlmdEx1NTFHQXI1LzB2?=
 =?utf-8?B?UVJUblQ5Mng0bnk5d1hqek9XOVNBd2tJT1dveEtLT3VVSTlFWU5PLzd4ckJU?=
 =?utf-8?B?bHNaaEdzdHluSXRJTS9xbXZRdExYa0dTMzN3cUtwa1hZekxTN21DRWREVm0y?=
 =?utf-8?B?Mng5ZWpUMS8vb1JoL0dnLzFhRngwU1R3cmMzYnZaNTloWXFtYStQQ0pEYlRr?=
 =?utf-8?B?VlM5bUFsMW5zVURpeFJpdExmUDhnaWRNUlZMWVh1emRvaWplRm4zRTdQcS9v?=
 =?utf-8?B?UWpacUtrbENUTEg2LzA1aUw1VUxNUFhhbTNId2Q1Mm1HVnJ2WkJhczQ0WEQ0?=
 =?utf-8?B?M29WeFc2WEpWUVRvaWJoWS9tTTNJRks3bGpvMERGSXd1NG5qK1BaKzdhbG5L?=
 =?utf-8?B?ZjI5Rk91OGcwOVI0REMwd2c2RTFEaXlUYXBETU5JNXMxbTFRdEFDNkdvT1Uy?=
 =?utf-8?B?bzBvT25qTHFySitqdHcrMU5LVkpHWVZIRVNaaU0zYm14L0NxY1pTTlNSYmRa?=
 =?utf-8?B?VTRsM0hVRGp2VTQ4NVd1S0tWdGNZS01vTlNpYS9zNnNxREdzTzIwc1pFVTlP?=
 =?utf-8?B?K1lFVFhHUU9KVE9RNGk5MXNXWHphOGlGQ0x3U1U5cVoyUTZlMjh6aFZEUXEz?=
 =?utf-8?B?ckdOb2EybzFSbE42dS92b3VKTzVTVXN2dUpxbXRFeCtlNEpMdjZlbWY0Nkp0?=
 =?utf-8?B?aGgrU0R2RXNsaStjVjlrNGFabFhCNWl2TnBvbzhjL1NJa0xEMmxxNXlETkZN?=
 =?utf-8?B?TXdwRy9hN2k2eFFjTHhUdTVYWFJ6cEdpaHJoMnJYWXVwVWxoa1VkcGM3cldP?=
 =?utf-8?B?YkVQQ3ZqeGV2S0NQNDVOZUZ2amdkZEx1NHh5b2t6bTRLdk1kY1p0aCswbHJt?=
 =?utf-8?B?VDJSc0R4bDc5WmZJK0p3NTJoaXhxczNQWjU0MVRRNzhyZ3h5V1BCUjhjSjBl?=
 =?utf-8?B?R2I1bDRVK1JJZUtMU2k2MFF2VklVNy90QS96SFpIemRsZ1FvbmtpOCtIUXox?=
 =?utf-8?B?QUh2SXROd1BuZjNlYmtMMWlNRHR2SWJhMWg2K2VvY3VkRmM4OUpJakVXREx4?=
 =?utf-8?B?S0NzbWhnZXZodXY5SEZVVTc5ZDd1RVFqRnVra0k0K2QrVGtKWnFXVWdMQ1Vi?=
 =?utf-8?Q?GYIHtwHiAuQzq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NOaFJnM0FwS2pCMmFmZWZQazg4NHg5NWh6T0lMdEtRa3hNaVhIK2lTWDlQ?=
 =?utf-8?B?THRCeFBPakRTWnRFVWQ1bGc1bzdnLzl3SHRDVFBSMmp0OUVycmZ2akdtZzQv?=
 =?utf-8?B?QVdkSmZ3eUk5aE4wZG5jKzhqakhkWmZGQUFmL1Z0Uk1HVXVPSTBqSzVyb3B5?=
 =?utf-8?B?dy9ReWxHU1Q3Y0U1V1VJSGVRVVZURWFPMitrOVNvTXVod2FvdmFuVjkxOGlL?=
 =?utf-8?B?NVMweWZ6cGhUZmVHUlU4Y2RKbjAzaUV6TVR4VzA3OEtmT01jL3R0cTYzK1Fr?=
 =?utf-8?B?QzV0ZnZsK3JsWDBsYXBFbzl0T2k1Q3MzMTkreGZLYXIwZVJOaWN0MkhsVnBX?=
 =?utf-8?B?cXMzeFdWQ3dRV3ZGazYwMFFYb2JvSkR4U1czSlhocVBHMm9PUnFCKytuaXBP?=
 =?utf-8?B?ajQ5Z2swZkl1VEZrQVNXOTVCYUNQSjdLYWNraW5SaWh1TGZpWEhDSE5mMXVx?=
 =?utf-8?B?T1lJTmlkOFRJTHNabXhhWmdtMFY5RU1welBMdHJrQ1FwOWs5NUx0SGIxOUxR?=
 =?utf-8?B?aUxoRjREcUdzbGJTajl4UHpYYjNLMmNDU2VYOGdwRkxxRHhBNEVpbXNDUjFl?=
 =?utf-8?B?eWRua2dJT1ZTZTdCd3VDSHBuMU9sdTgwSkx1MWdtenl1Y1dHU2N4RnlWcCt4?=
 =?utf-8?B?L0JIaVFzKy9odDlhV0xTQlpCNm1oZXY3RW5UNnhTaUNjZHVkTjVmWERnS2Z3?=
 =?utf-8?B?dmh4OHJrRjdFWWQxRHJsSEdGWS9QQXFKQ3NES1RzbnlqZlVWOFVjbkprRXgy?=
 =?utf-8?B?cjhrL3VoWmRtOVRhTDFXWnRYNjIrK2VTMmMyWnBSREdCSDRXNkt4bE1WOGlo?=
 =?utf-8?B?eVlzb3lyb3h4bmlReGRuWUpvN2JaNklmUzJUWHdlcVBHVXlUcUVyWjhqLzVD?=
 =?utf-8?B?bW0xRlh3MnNGdG1zZ1B5T2pLeUZ1K0EwclV0WVlkclBQam5ralYrMTRZNkpn?=
 =?utf-8?B?L3Q3QUkrRHZVTXpudGROT3o1Y0hjVUp0RUJXUitEaWpqNW0rUGVMMUV1b3Jq?=
 =?utf-8?B?SWxEMGZBeDlvYVpMTVRuQjByT3p5OUNmcmtLem0zUmxIWDl6QUNOdmk1Vk9C?=
 =?utf-8?B?Z1FZVjhkWUFWdDAya3M4ZXREOGJSb3hIRG9pUHF0OCtMTlUxYVFvN2gwRjJx?=
 =?utf-8?B?bm1LYXhEdHR4TnNhSzU3THB2T3VYK1ZJdngrRDhIa0hEV2dGb0J4UFdZRnMr?=
 =?utf-8?B?SjQ5Zml3bWJiRkxmVUZjSUlwQkloTjNNVlNhMThZYWl3TjllM3F2R0RONWE0?=
 =?utf-8?B?amUyNUxkZ0E3TWlLbEs1MXpubnNxcTdPR1RzbGhQWEhpcGV4SCtOYjNWcTJi?=
 =?utf-8?B?VlNHQkpDaUVPako2NmNWT0xnQmF5MnBHc0tWMHVvemRBOG93NWtKTWQ3U3Jm?=
 =?utf-8?B?WUFLTzZXS2p2WlBzeFdKTlNicHZ5NzNMeG5qeTVBMnMrYnFKbVhWM1MrMEIx?=
 =?utf-8?B?WHU2TzljdXVmV2QrQno4OHYxazh3ZGtZeW10M2lsTjdOV3pwWUk0SEROMCs5?=
 =?utf-8?B?MUMvMStCbzB4UlYrKzZJYi9YSHNETzZFQVY5R0VlR3VlMjBTdUZVWWNBMGNM?=
 =?utf-8?B?YVlkTWhoaVJKeThDMDZtMlBEYkVXMk9Yczl3eG9Vbko0UzB1UFhaM0lRbWJk?=
 =?utf-8?B?Nmk5T3oybldYQUk5cnF3VGo3Skw1L0dVNXdJVXZpUTVlVG51alpxTEJERlpH?=
 =?utf-8?B?T2s0bkxXRlVpd3RBWlUxc1dLb0IwaXYrMmJTLzFjZ3UyRU9GVFZNdVBZdWtt?=
 =?utf-8?B?VENPSUk2U1JteUZTOUkvVjJMNUJhZEd5YTViS1BEOGluWHJ2U01TYVRMemV4?=
 =?utf-8?B?Tk9yRG5yZVhwQm52a3ZYY1h2a0s1akhFTUxmQnExV0t6cXlJcm1tUWNEaHNC?=
 =?utf-8?B?aDFoNU1saGIrNVBURldsZzRIcHExcEtFU0ZDN2tIWWlBdFV1dk00c2t5NnRB?=
 =?utf-8?B?eThYKyt0aXljTGt3QjdrQVJMKzhqc25kNjFTeVF0b1ZUYTh3VEZscTlVMVFE?=
 =?utf-8?B?Y0hoQU0yZjhRdlV4OGNzaWNZT3hPMExuMzgzeVlpN3MxUGxCMjZOSHNXSllO?=
 =?utf-8?B?aGtpNE1yRlR6dXpyMm5aQU1rMm8rS3QrR0xIWXlIQlA4cGNYak54YjVNRnI2?=
 =?utf-8?B?bDluWmVVSWV5cTdLMldCS3FiMXh5OGc3WURTUEFLanN2ZC9RMnRLc3dOWE5o?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oxgIxhmtM6h5LIR3BIJ84NjyijvssNDtElW28GsOGj5PEByIFnik34ZVgBzhh/Kkc3p8ad42/DDEtOfvfcdIC9O6745ggXcWfmeyQLtSTIDRI8ES3guScHepiUTH5tzF1+gdgVIutwMxMJNcwPVUuFH9qCfRo+lqPSBcYLGt+DlsRO8BAZp3vG/Hywv3mz3PC3CRBsFlu9yXrREa4IqBGSa9dGdnO1wyq67Jaik81VC1USdN5qMRNf6/dE84KY44CWyZQXpvlxKk6uN2u6uos/mmeq/TE9E9MVdQMUOclvEFY3J/+aO61zGlIH5v8mmRqwUpF6HVn0gyaNDT0YJ4HPA5QlQNSgLp2Vwv2SeTEvmQRhEUNzaXPFPguZ3p41U5E/+VBt55mitxxYDYl+w4eB+nIoSgHJm6Ow7K06sQ3TB+B6DixGWJnP1I+UY7ftssuGBZNLsGlkNxgRIUCbTzF+9uhJdcsGu+iSn2qEys8R8HoQKX76Uk7WgCGmBVpi6UXHRh8yWBAxMmF4uLFfpV/Q8dKoyN6DjDeYWSjGAEV9tP0/coISHAwSHHUXwqdqhFfYT5Rp8fOusu6PhDKnvg57ChNPSWj6qZ11n/lW6cbeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2109e9fb-c6c2-4a03-f3bc-08dd4536da8e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:13:25.5457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBIU8KjSJs5cAgS7UvnOKP1pYHH0TYKEtSdaZACuUleCuNXIfNEFTtoXCeliw4GQ2UvJmgWulN9Sj3IcbP4T7p+tHbU6Z8/mErhWEHn/2vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040125
X-Proofpoint-GUID: gIm2ZHfGGj3nNK1fxcfA4cs79-y3944H
X-Proofpoint-ORIG-GUID: gIm2ZHfGGj3nNK1fxcfA4cs79-y3944H
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/4/2025 9:10 AM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> If there are multiple containers and unmap-all fails for some container, we
>> need to remap vaddr for the other containers for which unmap-all succeeded.
>> Recover by walking all address ranges of all containers to restore the vaddr
>> for each.  Do so by invoking the vfio listener callback, and passing a new
>> "remap" flag that tells it to restore a mapping without re-allocating new
>> userland data structures.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/common.c              | 47 ++++++++++++++++++++++++++++++++++++++++++-
>>   hw/vfio/cpr-legacy.c          | 44 ++++++++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h |  6 +++++-
>>   3 files changed, 95 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7370332..c8ee71a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -580,6 +580,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>   {
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>> +    vfio_container_region_add(bcontainer, section, false);
>> +}
>> +
>> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
>> +                               MemoryRegionSection *section,
>> +                               bool remap)
>> +{
> 
> vfio_container_region_add() is already complex enough. Please consider
> doing an initial refactoring before adding a new code path. It would be
> welcome !

I'll take a look after factoring out the cpr code into helpers as you
request below.

>>       hwaddr iova, end;
>>       Int128 llend, llsize;
>>       void *vaddr;
>> @@ -614,6 +621,30 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>           int iommu_idx;
>>           trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
>> +
>> +        /*
>> +         * If remap, then VFIO_DMA_UNMAP_FLAG_VADDR has been called, and we
>> +         * want to remap the vaddr.  vfio_container_region_add was already
>> +         * called in the past, so the giommu already exists.  Find it and
>> +         * replay it, which calls vfio_dma_map further down the stack.
>> +         */
>> +
>> +        if (remap) {
>> +            hwaddr as_offset = section->offset_within_address_space;
>> +            hwaddr iommu_offset = as_offset - section->offset_within_region;
>> +
>> +            QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>> +                if (giommu->iommu_mr == iommu_mr &&
>> +                    giommu->iommu_offset == iommu_offset) {
>> +                    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>> +                    return;
>> +                }
>> +            }
>> +            error_report("Container cannot find iommu region %s offset %lx",
>> +                memory_region_name(section->mr), iommu_offset);
> 
> error_report() are not welcomed. We need to find a way to propagate
> this error.

I follow the existing practice in this function, which already reports other
errors.  This is called in the context of a memory listener region_add method,
so returning an error affects the signature of all listeners and should be a
seperate RFE.

>> +            goto fail;
>> +        }
> 
> Please introduce a vfio_cpr helper for the section above and move it
> under the hw/vfio/cpr* files.

OK.

>>           /*
>>            * FIXME: For VFIO iommu types which have KVM acceleration to
>>            * avoid bouncing all map/unmaps through qemu this way, this
>> @@ -656,7 +687,21 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>        * about changes.
>>        */
>>       if (memory_region_has_ram_discard_manager(section->mr)) {
>> -        vfio_register_ram_discard_listener(bcontainer, section);
>> +        /*
>> +         * If remap, then VFIO_DMA_UNMAP_FLAG_VADDR has been called, and we
>> +         * want to remap the vaddr.  vfio_container_region_add was already
>> +         * called in the past, so the ram discard listener already exists.
>> +         * Call its populate function directly, which calls vfio_dma_map.
>> +         */
>> +        if (remap)  {
>> +            VFIORamDiscardListener *vrdl =
>> +                vfio_find_ram_discard_listener(bcontainer, section);
>> +            if (vrdl->listener.notify_populate(&vrdl->listener, section)) {
>> +                error_report("listener.notify_populate failed");
>> +            }
>> +        } else {
>> +            vfio_register_ram_discard_listener(bcontainer, section);
>> +        }
> 
> idem.

OK.

>>           return;
>>       }
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index f3a31d1..3139de1 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -26,9 +26,18 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>           error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
>>           return false;
>>       }
>> +    container->vaddr_unmapped = true;
>>       return true;>   }
>> +static void vfio_region_remap(MemoryListener *listener,
>> +                              MemoryRegionSection *section)
>> +{
>> +    VFIOContainer *container = container_of(listener, VFIOContainer,
>> +                                            remap_listener);
>> +    vfio_container_region_add(&container->bcontainer, section, true);
>> +}
>> +
>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>   {
>>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>> @@ -88,6 +97,37 @@ static const VMStateDescription vfio_container_vmstate = {
>>       }
>>   };
>> +static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>> +                                  MigrationEvent *e, Error **errp)
>> +{
>> +    VFIOContainer *container =
>> +        container_of(notifier, VFIOContainer, cpr_transfer_notifier);
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
>> +        return 0;
>> +    }
>> +
>> +    if (container->vaddr_unmapped) {
>> +        /*
>> +         * Force a call to vfio_region_remap for each mapped section by
>> +         * temporarily registering a listener, which calls vfio_dma_map
>> +         * further down the stack. Set reused so vfio_dma_map restores vaddr.
>> +         */
>> +        container->reused = true;
>> +        container->remap_listener = (MemoryListener) {
>> +            .name = "vfio recover",
>> +            .region_add = vfio_region_remap
>> +        };
>> +        memory_listener_register(&container->remap_listener,
>> +                                 bcontainer->space->as);
>> +        memory_listener_unregister(&container->remap_listener);
>> +        container->reused = false;
>> +        container->vaddr_unmapped = false;
>> +    }> +    return 0;
>> +}
>> +
>>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>   {
>>       VFIOContainerBase *bcontainer = &container->bcontainer;
>> @@ -104,6 +144,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +    migration_add_notifier_mode(&container->cpr_transfer_notifier,
>> +                                vfio_cpr_fail_notifier,
>> +                                MIG_MODE_CPR_TRANSFER);
>>       return true;>   }
>> @@ -114,4 +157,5 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>       vfio_cpr_unregister_container(bcontainer);
>>       migrate_del_blocker(&container->cpr_blocker);
>>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>> +    migration_remove_notifier(&container->cpr_transfer_notifier);
>>   }
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1e974e0..8a4a658 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -86,6 +86,9 @@ typedef struct VFIOContainer {
>>       unsigned iommu_type;
>>       Error *cpr_blocker;
>>       bool reused;
>> +    bool vaddr_unmapped;
>> +    NotifierWithReturn cpr_transfer_notifier;
>> +    MemoryListener remap_listener;
> 
> There are 5 attributes related to CPR, please add a CPR struct to hold
> them all.

OK.

- Steve

>>       QLIST_HEAD(, VFIOGroup) group_list;
>>   } VFIOContainer;
>> @@ -311,7 +314,8 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>> -void vfio_listener_register(VFIOContainerBase *bcontainer);
>> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
>> +                               MemoryRegionSection *section, bool remap);
>>   /* Returns 0 on success, or a negative errno. */
>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> 


