Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096A9C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0fu-0003I5-RC; Wed, 17 Jul 2024 05:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0ft-0003Gq-0x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:10:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0fq-0000N1-KJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:10:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H95oCA010156;
 Wed, 17 Jul 2024 09:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=iJMJNjfecN2SmyqLo5cBLZ2RQA96Wc+U9xXl0xk0tA8=; b=
 l2FdVIM09XhjfFU5j9y+FpREH2Mo2+KKgV71Y4N4Lf8+y0MmiZakp0aPIPgGZBDT
 X41VB2+96WIDr7l/8+kr2V4Bwpkz/0eIUdeWrMROA7YNQQX+JFABWsYe6NMGpPPx
 Ktut668h+cMaIaEp4tSikU/722nL/pnL+JLOygICzFIYBzmSy5NOC+dM2ZuZX4XK
 IAbq5qEq8j13lD27MYkPqYTguBwK5xUrCp0aUImIuckrojEslSXAGkYCggG2AZ38
 Rbf/WjgPPu0tvxLqUnAmsqhhBAmsCD+4NB2TqP/Qh0M0RixELwmdb3j1P5nc6R9/
 W1NKk2Hwq2DQU6RQGI7OLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eb11807a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:10:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H8KD94019520; Wed, 17 Jul 2024 09:10:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwext613-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBVMxrY4dfQLj02BycUNwswOG5GD+wD3CNKVoe19eafX54gf0lzwiGUPFFVn7xFWql3NQFZzkWCrU0VoWi70zP2NQnmOu9vMClZVOBF/DzW+RTsB6x7uMOvfnoYuINc4C7f6J+w7NagkgEsNCkLVbefmyk0wma1jRemUqS7h4aMhPmTrM2jtCSDmnuVDDVV2O32EzG19qDXHu9T2StIaWYP8l2FA9MCPX+pWdxsT/UP+9EFhYhJPOFvuzOzwWeaUlvzRcuKcSjsh3SdANBqjYvhQ11sV8t66vDuNkD+KXn3tucfsFiezFaBg+j0Krh/SdJiTmnPO0h1fMDXySfeTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJMJNjfecN2SmyqLo5cBLZ2RQA96Wc+U9xXl0xk0tA8=;
 b=i0hx6SOYbHlJoNpy7DMCKPBj8P8XpZy4LSBuNVAvIg1NSaWPG0ueT3YSUXXrU1Hd0DEWwmQrCCVYGOtgEAfKeGQwwyluyA5DVTxV/6iMqb8NCJpgIymnbJOi0ORhtNBE2SAA+FT0F/G8uRnAHyV4JgGFludLjQbzqm80hyVP+9aljmP++UqpOOGz2dmJkRlXBGF9giS1441M/+hTVGHFNnCh1l30j8bfPbZa4OapZ3cXsmUPM5uKGQhWVsykLLOKlUxmiox5KBVaw6KVw8Oy/wtsHvVArG9Z+zFElkkljpBQUl/HP+rbTJHJ/jy0iX43bIldI5CpsgZLipp7KLpn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJMJNjfecN2SmyqLo5cBLZ2RQA96Wc+U9xXl0xk0tA8=;
 b=Fft12SysU0EWBKerSt6vGiLwgzFkGr1fZdXZwyJg7DKccO7x4MEKItoWFhAgFeToaWeb7afcX371UCbTD0yOlxDLRVlUOipF3zDpyNxuBH7IFkIqkvtwd67em2TYtYC5gL49bLK7AlbrEpLfooOwqEC1puSUybJROWW+uxNBYEU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA6PR10MB8109.namprd10.prod.outlook.com (2603:10b6:806:436::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 09:10:04 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 09:10:04 +0000
Message-ID: <6ce29c92-d9f8-413d-92f3-8a30e937f746@oracle.com>
Date: Wed, 17 Jul 2024 10:09:56 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
 <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
 <a67edbc5-68ce-4967-b8b9-a440904ed1b1@oracle.com>
 <SJ0PR11MB674475CA28136228FE93072A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674475CA28136228FE93072A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA6PR10MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c2bfe1-e245-4438-a1e5-08dca6403e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkRwbzMyZ0lCY3o3b3MwVjdVSy9NZkxwUXJBNzBPN2pPekVNc2FTcTZlMnZI?=
 =?utf-8?B?TTVuaDBUcmRNdmg3S0VraWlPSzlRSEM3eGRTeTZTYjFCVEJFcFNuQ1JweGVV?=
 =?utf-8?B?em5QYjNjT3VidEl0QlNWdjRSZWM3a1FzdEdPNDFYYU43dExFZmJaa2pLb2k1?=
 =?utf-8?B?NmJFN1o1NHd0bjZUMWZjUW0vRXp6eUExMEZCTmZ3c1hXbWxCWjZuZUZWZHBp?=
 =?utf-8?B?dXRkQTlDR2RkSlpKRzV0cUdqYlVac0M4UU9TQytsZHhHQzhGQit6R2FHWnoy?=
 =?utf-8?B?TVl2dGhBRFJSZlZlMVBsK1lYVjZ3Z1AzSTVmYzB3WThQaW9zWDJwRnJ1Y2p5?=
 =?utf-8?B?dzhDTWNTZDBjTVl3d3Z0QzRPdEFlMDdxRHQyWmJPcXM3Nlk0VmIyWlV3Qmoy?=
 =?utf-8?B?QnF0WnFBamM1SXFTcmc2RHFFSmJxUlNCeC9BMHVIUzJ6cHhUSXVmZHI5d3Fo?=
 =?utf-8?B?RlB0SG02cE5GaGxrNW50WDd4VUd2bU85ZUo0ZnJENDdjN2c2U2svNUlyTEZ2?=
 =?utf-8?B?c0dMRlVDc2xyVUxCTi94dDFDR1ByMmxPWWhSTGYzM2htd0NDRmZyUWZkTGdR?=
 =?utf-8?B?a2QzSk5TcjIwWjY5VThqcnJtUVFTNWJoVmRkL3NudS9hOXVXMTdDVDFkWTZ4?=
 =?utf-8?B?Q3A1ZFN0VVdHclYzZ3Vtb2paYVpVcnFwbXRtREUrYzJvRnhodllIUm03QlJw?=
 =?utf-8?B?Zk5PaDJYMDV4d0xRaGNOcFlZeFVISHJjOG1jVDhYYy9Cc0J3Vk4zdkNvZVo2?=
 =?utf-8?B?MTBIUkYvWWZyTk0wYU5nbS9BL2YvNTl0M05KOGdQYWZKZjdJSGpTN1VWaGRG?=
 =?utf-8?B?NE1Yc2xHcUxCb1hiSXBFSzZBbzhMTDJEMjNsbk1sQWFnUlpqQ3JUOU4xTk1m?=
 =?utf-8?B?eHV0VWlidDQ4dlVhcEYxZ1lEZjVsdTV0QkhETUxEcVI3ZTVyM2pXMEpMVGVp?=
 =?utf-8?B?QXNiMFZmcDJrM1lWRFRMUDlVb1owUlpzZkFJOTFqMUROMVFRNkhJdUczYlhF?=
 =?utf-8?B?NXN1ZHo1cnNaVjRHaithd1pvZFVXbjFNQkRtUUdqTGZYT2VEQXEwTEx1RFBL?=
 =?utf-8?B?L2pFaVZTTmNjOUtMcHY5aVpRcUI1Sk9HVUZHVDNRbGpTNkFIdnFCVU9EVUpJ?=
 =?utf-8?B?aXZBbXpVVC90YmE1eDdYRHBQS2hwQVFzckJGQlFXQVhvT1djL0RkaHYxQXFm?=
 =?utf-8?B?MG4zUGovOXZiMy82OFJIcUJNZlJ0NVF2TjB1ZEk2RnNPN3JHSTdqa3RPK205?=
 =?utf-8?B?eGtJcjMvb3BqcWtLaWFVbEhLR3BBZ3VjbnJ3YTlvMkpkUFRlbGlOeTI4THlG?=
 =?utf-8?B?UFNBSEowbWNaeFVtQ2Zzd2lYYnRMWTQ1WFpsSis0dUNKQ0t3eGxVQzBkKzV5?=
 =?utf-8?B?VEtidEdKUTh5NGp4dWpQVWhtNUI1RTBsN0dJN3ZxNEk1bHA1MkxRTzJobDha?=
 =?utf-8?B?d0tiQ1hCbVdSdGpQZ1EzWU5WSG5NQytUWVdrU2tKR2NSQ1RZLzByNDZtQ3Fl?=
 =?utf-8?B?SUtkbG9WYzJNbmtpQWRkUEFGM1ZKZ3M3YjR0ZmV5MU5BbHBLaTNWS1FGSURR?=
 =?utf-8?B?RmFmYWx2Zk1LT29OSjhaUExLcDlGczNKV3N0TE16TXdUYzVlbGg2bjl6YkRE?=
 =?utf-8?B?bWV2TXFiZ1FubHVIS1lTWDZQYjcvZjZTS21QNlVZTHFHVHBha3QySExKbzhM?=
 =?utf-8?B?ajJwcEFnUk1Da2k5MVpaaU52dmtyK0hDMmU2YVZOOVFTc1ZsUXdQVnowbXlJ?=
 =?utf-8?B?Uiswd3FaNmU2OVBMTHBLUzZJOXo1d1N2RDloZHB5eXc2dDJvY3ZyK0FWUkZM?=
 =?utf-8?B?S3c2SEJBMmExdXJzKzdNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U04xNW8vMHB0dGk1VEZRZ3pmUUlvSHhpUVJuZ0NrYlpqUFdCanB1NzZiM1ZU?=
 =?utf-8?B?VFc5NXQ4S1M3c2dOd25hTi9KbUlXOGJ2bkxIeEJwMmg4elNWdDVLR0RuMmh6?=
 =?utf-8?B?UGxjNmh2amlQa0hvS29JR3p4TEhwWU1Yamt2KzVmZ0RraWkxcEtxT1U3NzVx?=
 =?utf-8?B?dHpKNVA1NTNINTRyZXZkK2xvU252aFBSekFKa1ZmQjBQajRZZGVLYVUvWVJ2?=
 =?utf-8?B?OEMrekxiTzhlbWJTUDRuVUEwcjQ3T0dSTUVUb3RqS0ExUUF6QldiL0h3ek1l?=
 =?utf-8?B?bUQra25WTHdmN3dFK2d3SVhTS0crVWNXcUZ0MCtXVGg2bGp0WlFnamRsQmVw?=
 =?utf-8?B?c3FRSnFiayswc1BzY3crbldZVVlhWnZTck5Wa1l1NUhnRVl6MnkwYk4vUStW?=
 =?utf-8?B?OVlwUEVsbG1hQ3BoVmhVdy85WStnREZMaGVRR1djdit0dFMzRTNOZ1dmZGk1?=
 =?utf-8?B?V295ZW1ybHFBU2JCbU5ZNk5NMHpvVy9MNXZNcy93RkxaL05Oc0lreGxLQXc3?=
 =?utf-8?B?NEl3a21KKzBCSUlmeWpxeVBqdllZNzIrckpJM00xOHZUNHRRdm1EWk5hdnFC?=
 =?utf-8?B?dUszVkJ5dFhuMHA2KzVXb0UzUC9laG1oSWN1ZjRFR2IydzNxWXdaVUN0dzlv?=
 =?utf-8?B?aGJiRFhPRU9JYTc3a1g5WjVYWnZNenlETXBtL2c4VGtsRUlRZFcxNkl5QmtL?=
 =?utf-8?B?WUZnQVhETkxDM00zTm83ZE5tQUNqYVdCbEs0MENscVE2MzV5Qk5rUGh1S0lu?=
 =?utf-8?B?TGFaK0RUREJWS3pyZ1gvVnpEekhKdnpFczNvU1IxcTVYMTNZM0tDZUF6eTB1?=
 =?utf-8?B?cVMyU0ZIdHRCVld5ZVZzOURYbmJmYUVuV1JnQldJTFdkVWduRHZUN1R0c2VG?=
 =?utf-8?B?UDlDYWc3NzhyV29oNHBmMDZBZC80eXVqR1BYZ1FqNW5QaENoNkM4NE12VENh?=
 =?utf-8?B?RVdaaU9RTWVSUVhBNkVjTWo0bHVUcTBZYlRZZ0M2K3BteUE1OHZaSW9qL2Zz?=
 =?utf-8?B?c0hLdE1NSytBK3RjU2RyZDZlWHhGZnEzVmx3TU1kbTkwMGYxSVZETXhSeUMy?=
 =?utf-8?B?Q0JGVWkyaXN2MVMvT0daUzlVRjh0TmZrY0FEaVozazFYb21iamQ2L2x0d3Bh?=
 =?utf-8?B?VGQ2ZFphVmZzWFB6T2VSL0pJaFlnZDgrODVUck04bjIzYzZLbDRlRlp3N3Bv?=
 =?utf-8?B?V1ZFSU9xNldmdmpxbGE0d1BRQ0FKd3ZrYmJYcStSVUtUQWQvTjlZd1dTcFVR?=
 =?utf-8?B?dU9SS3BOSmxHVkN4K2ZLNEtLdkNydjNOYit6R3RFWXZtVmhaeXl4cEhSZ3V5?=
 =?utf-8?B?U29oMDZ4aFdpUVJaUXVqSytVUVBnQ05GS01PdWFrZFF1TFJiVVVDdDFxWVk2?=
 =?utf-8?B?ek9KSVdCTU1pODVxTHNGamRtK1JSZFNJS1o5eXR3dlluRHZnb2R2K2NVMWlS?=
 =?utf-8?B?ZmRtWXdnQzlYMG9XOTI1NDZHNVJTazRrdDh5cmNncXJaR3RCRmIvVmxzVzR5?=
 =?utf-8?B?NHhEVjJuVDlWZ1N0VndRQ2dtYVZCNTFDWDBBWnlBS2M3MnFoQUFKTi9oeWhl?=
 =?utf-8?B?M09kRUs4VzRZSEFLeHZNd3VDY2lFZ2Flald3TG1LTG1wc1BmS1dBbU1VK1Nx?=
 =?utf-8?B?dkZKTXBKK0gyS2lmcThBVFNXcUVzLytsUG0vNDF4MHVUSS83SlpORWlUM0xT?=
 =?utf-8?B?cVlkWG5hRW1Pa2gySjhqUTg4YUMwdHpCcXJ0aE9rbXZqU0NZK09MMzZsM2NI?=
 =?utf-8?B?Z3lISTJ5ckdwL1FpSHJQdWpycU9aUDU1YnNMSkwyaG1FN2l6WDFRSk8xNHcy?=
 =?utf-8?B?dHdrWm95UUlZaHlXcHpPMldibCt6aCtJaFVhUktTK3dGTFVtd2Eva0ZrQTAr?=
 =?utf-8?B?SDkyd1hvUVgxS0hNOGg0cWJyRk40YUdsa01kek9UTEtLT1I0emdkSjdGa2xO?=
 =?utf-8?B?MTJCa3dBNnA1VjB5aEdHajRZNUxMOFNqYlpHRWFWQzBYa2JNblBnaEJsSEUy?=
 =?utf-8?B?R01hMGd6VVB6V1FuRkpqMW94dElDUkNsS3A5NEZHczhmUTczNnV0V0xpK2lw?=
 =?utf-8?B?WU10Ti9WUUJTS2ZUVUdvRHVnQkNDS0FUcWxaS0duNGlnV3ljNmFudGRYbWdx?=
 =?utf-8?B?Zjl4UWlHWmxMVnpjSmdGMExFS0h2NVNiTVlTWkxrdFNyd0ZFc3kxQUkxSUxY?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cStvWHE89vXlXNkQhQ98raqdREplKZcO5vtJyk03aPN7GsuefH7dNo3KRHgf13JvqgbicfTdl7UUHdrjmewLNzqM0j9iFj5mncRaA/Yh4iN82llslbBJTq3VpVJlfhQvgaDl7T8OL8YiyRQN2lEqBBI94QLGlEk+hHpxm0PzH+C6S5Sb/LIfZAIM+S6i8WeVmihPIoxDb51IfUqLfHcDc2X3H5PKqX6x8XiJ9+SVkfVq17dOYUoh2bcNvQ8twTWv7sFL8VnUClNUCCzL+Jr57GJJI9kmfP8T0PeGpeDHpeJzZke5H+HdFSxNISmn64O1JtAeTrnMBNhY2UFqs5vPHxYHaV7NN5ZtDtyNwCEsIrNRdFUz6eCzbDsNT7H0uMJMuxHXmEhut+vSFgCQniHhXcgQYZL0xax3T2b6Q8aPXbJ6J6IVdjhl5RetF0kP6EEJEXqs/0pYfFF0Z94l9rQH9EVzfUoBfcWlDxsTk+VtYK4eyZA3dM6JVp6uJy6NlBb/KgNqTa1MJq1gM4w5Lz8Jx6WrycMqK4NTKxZeQvfiI6SWx0vVsGeE40LfjXK5XE2Bu2bBTmrpZf/8M3BuK+JoOT3OdixXrzW+C/uWPRfdqDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c2bfe1-e245-4438-a1e5-08dca6403e9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:10:04.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fG2F/GFE7220wLrRDvGFs9N2oDcRH0l1d1lHcnDkdwkVAlm2gIAqDziBXZBvqNhADpAxl4LQ/lH3OTDCkDwvVAVO/9soGhBVTCNEesr3oQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_05,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170070
X-Proofpoint-GUID: YIMC9Bj7OsrhY9l8SlqaQOJ4B51TmXTf
X-Proofpoint-ORIG-GUID: YIMC9Bj7OsrhY9l8SlqaQOJ4B51TmXTf
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

On 17/07/2024 03:52, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain
>> creation
>>
>> On 16/07/2024 17:44, Joao Martins wrote:
>>> On 16/07/2024 17:04, Eric Auger wrote:
>>>> Hi Joao,
>>>>
>>>> On 7/12/24 13:46, Joao Martins wrote:
>>>>> There's generally two modes of operation for IOMMUFD:
>>>>>
>>>>> * The simple user API which intends to perform relatively simple things
>>>>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>>>>
>>>> It generally creates? can you explicit what is "it"
>>>>
>>> 'It' here refers to the process/API-user
>>>
>>>> I am confused by this automatic terminology again (not your fault). the
>> doc says:
>>>> "
>>>>
>>>>   *
>>>>
>>>>     Automatic domain - refers to an iommu domain created automatically
>>>>     when attaching a device to an IOAS object. This is compatible to the
>>>>     semantics of VFIO type1.
>>>>
>>>>   *
>>>>
>>>>     Manual domain - refers to an iommu domain designated by the user as
>>>>     the target pagetable to be attached to by a device. Though currently
>>>>     there are no uAPIs to directly create such domain, the datastructure
>>>>     and algorithms are ready for handling that use case.
>>>>
>>>> "
>>>>
>>>>
>>>> in 1) the device is attached to the ioas id (using the auto domain if I am
>> not wrong)
>>>> Here you attach to an hwpt id. Isn't it a manual domain?
>>>>
>>>
>>> Correct.
>>>
>>> The 'auto domains' generally refers to the kernel-equivalent own
>> automatic
>>> attaching to a new pagetable.
>>>
>>> Here I call 'auto domains' in the userspace version too because we are
>> doing the
>>> exact same but from userspace, using the manual API in IOMMUFD.
>>>
>>>>> and mainly performs IOAS_MAP and UNMAP.
>>>>>
>>>>> * The native IOMMUFD API where you have fine grained control of the
>>>>> IOMMU domain and model it accordingly. This is where most new
>> feature
>>>>> are being steered to.
>>>>>
>>>>> For dirty tracking 2) is required, as it needs to ensure that
>>>>> the stage-2/parent IOMMU domain will only attach devices
>>>>> that support dirty tracking (so far it is all homogeneous in x86, likely
>>>>> not the case for smmuv3). Such invariant on dirty tracking provides a
>>>>> useful guarantee to VMMs that will refuse incompatible device
>>>>> attachments for IOMMU domains.
>>>>>
>>>>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>>>>> responsible for creating an IOMMU domain. This is contrast to the
>>>>> 'simple API' where the IOMMU domain is created by IOMMUFD
>> automatically
>>>>> when it attaches to VFIO (usually referred as autodomains) but it has
>>>>> the needed handling for mdevs.
>>>>>
>>>>> To support dirty tracking with the advanced IOMMUFD API, it needs
>>>>> similar logic, where IOMMU domains are created and devices attached
>> to
>>>>> compatible domains. Essentially mimmicing kernel
>>>>> iommufd_device_auto_get_domain(). With mdevs given there's no
>> IOMMU domain
>>>>> it falls back to IOAS attach.
>>>>>
>>>>> The auto domain logic allows different IOMMU domains to be created
>> when
>>>>> DMA dirty tracking is not desired (and VF can provide it), and others
>> where
>>>>> it is. Here is not used in this way here given how VFIODevice migration
>>>>
>>>> Here is not used in this way here ?
>>>>
>>>
>>> I meant, 'Here it is not used in this way given (...)'
>>>
>>>>> state is initialized after the device attachment. But such mixed mode of
>>>>> IOMMU dirty tracking + device dirty tracking is an improvement that
>> can
>>>>> be added on. Keep the 'all of nothing' of type1 approach that we have
>>>>> been using so far between container vs device dirty tracking.
>>>>>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> ---
>>>>>  include/hw/vfio/vfio-common.h |  9 ++++
>>>>>  include/sysemu/iommufd.h      |  5 +++
>>>>>  backends/iommufd.c            | 30 +++++++++++++
>>>>>  hw/vfio/iommufd.c             | 82
>> +++++++++++++++++++++++++++++++++++
>>>>>  backends/trace-events         |  1 +
>>>>>  5 files changed, 127 insertions(+)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>>>> index 7419466bca92..2dd468ce3c02 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>>>>
>>>>>  typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>>>
>>>>> +typedef struct VFIOIOASHwpt {
>>>>> +    uint32_t hwpt_id;
>>>>> +    QLIST_HEAD(, VFIODevice) device_list;
>>>>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>>>>> +} VFIOIOASHwpt;
>>>>> +
>>>>>  typedef struct VFIOIOMMUFDContainer {
>>>>>      VFIOContainerBase bcontainer;
>>>>>      IOMMUFDBackend *be;
>>>>>      uint32_t ioas_id;
>>>>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>>  } VFIOIOMMUFDContainer;
>>>>>
>>>>>  OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>>>>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>>>>      HostIOMMUDevice *hiod;
>>>>>      int devid;
>>>>>      IOMMUFDBackend *iommufd;
>>>>> +    VFIOIOASHwpt *hwpt;
>>>>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>>>>  } VFIODevice;
>>>>>
>>>>>  struct VFIODeviceOps {
>>>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>>>> index 57d502a1c79a..e917e7591d05 100644
>>>>> --- a/include/sysemu/iommufd.h
>>>>> +++ b/include/sysemu/iommufd.h
>>>>> @@ -50,6 +50,11 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>> uint32_t devid,
>>>>>                                       uint32_t *type, void *data, uint32_t len,
>>>>>                                       uint64_t *caps, Error **errp);
>>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>>>>> +                                uint32_t pt_id, uint32_t flags,
>>>>> +                                uint32_t data_type, uint32_t data_len,
>>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>>> +                                Error **errp);
>>>>>
>>>>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>>>  #endif
>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>> index 2b3d51af26d2..5d3dfa917415 100644
>>>>> --- a/backends/iommufd.c
>>>>> +++ b/backends/iommufd.c
>>>>> @@ -208,6 +208,36 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>>>      return ret;
>>>>>  }
>>>>>
>>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>>>>> +                                uint32_t pt_id, uint32_t flags,
>>>>> +                                uint32_t data_type, uint32_t data_len,
>>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>>> +                                Error **errp)
>>>>> +{
>>>>> +    int ret, fd = be->fd;
>>>>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>>>>> +        .size = sizeof(struct iommu_hwpt_alloc),
>>>>> +        .flags = flags,
>>>>> +        .dev_id = dev_id,
>>>>> +        .pt_id = pt_id,
>>>>> +        .data_type = data_type,
>>>>> +        .data_len = data_len,
>>>>> +        .data_uptr = (uint64_t)data_ptr,
>>>>> +    };
>>>>> +
>>>>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>>>>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags,
>> data_type,
>>>>> +                                     data_len, (uint64_t)data_ptr,
>>>>> +                                     alloc_hwpt.out_hwpt_id, ret);
>>>>> +    if (ret) {
>>>>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>> uint32_t devid,
>>>>>                                       uint32_t *type, void *data, uint32_t len,
>>>>>                                       uint64_t *caps, Error **errp)
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index 077dea8f1b64..325c7598d5a1 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -212,10 +212,86 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>>>      return true;
>>>>>  }
>>>>>
>>>>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>> +                                         VFIOIOMMUFDContainer *container,
>>>>> +                                         Error **errp)
>>>>> +{
>>>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>>>> +    uint32_t flags = 0;
>>>>> +    VFIOIOASHwpt *hwpt;
>>>>> +    uint32_t hwpt_id;
>>>>> +    int ret;
>>>>> +
>>>>> +    /* Try to find a domain */
>>>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>>>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>> errp);
>>>>> +        if (ret) {
>>>>> +            /* -EINVAL means the domain is incompatible with the device.
>> */
>>>>> +            if (ret == -EINVAL) {
>>>>> +                /*
>>>>> +                 * It is an expected failure and it just means we will try
>>>>> +                 * another domain, or create one if no existing compatible
>>>>> +                 * domain is found. Hence why the error is discarded below.
>>>>> +                 */
>>>>> +                error_free(*errp);
>>>>> +                *errp = NULL;
>>>>> +                continue;
>>>>> +            }
>>>>> +
>>>>> +            return false;
>>>>> +        } else {
>>>>> +            vbasedev->hwpt = hwpt;
>>>>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>> +            return true;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>> +                                    container->ioas_id, flags,
>>>>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>>>>> +                                    &hwpt_id, errp)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    hwpt = g_malloc0(sizeof(*hwpt));
>>>>> +    hwpt->hwpt_id = hwpt_id;
>>>>> +    QLIST_INIT(&hwpt->device_list);
>>>>> +
>>>>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>> errp);
>>>>> +    if (ret) {
>>>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>>>> +        g_free(hwpt);
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    vbasedev->hwpt = hwpt;
>>>>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>>>>> +                                         VFIOIOMMUFDContainer *container)
>>>>> +{
>>>>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>>>>> +
>>>>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>>>> don't you want to reset vbasedev->hwpt = NULL too?
>>>>
>>> Yeap, Thanks for catching that
>>>
>>>>
>>>>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>>>>> +        QLIST_REMOVE(hwpt, next);
>>>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>>>> +        g_free(hwpt);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>  static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>>>>                                            VFIOIOMMUFDContainer *container,
>>>>>                                            Error **errp)
>>>>>  {
>>>>> +    /* mdevs aren't physical devices and will fail with auto domains */
>>>>> +    if (!vbasedev->mdev) {
>>>>> +        return iommufd_cdev_autodomains_get(vbasedev, container,
>> errp);
>>>>> +    }
>>>>> +
>>>>>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container-
>>> ioas_id, errp);
>>>>>  }
>>>>>
>>>>> @@ -224,6 +300,11 @@ static void
>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>>>  {
>>>>>      Error *err = NULL;
>>>>>
>>>>> +    if (vbasedev->hwpt) {
>>>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>>>> +        return;
>>>> Where do we detach the device from the hwpt?
>>>>
>>> In iommufd_backend_free_id() for auto domains
>>>
>>
>> to clarify here I meant *userspace* auto domains
>>
>> *kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT
> 
> If the device is still attached to the hwpt, will iommufd_backend_free_id() succeed?
> Have you tried the hot unplug?
> 

I have but I didn't see any errors. But I will check again for v5 as it could
also be my oversight.

I was thinking about Eric's remark overnight and I think what I am doing is not
correct regardless of the above.

I should be calling DETACH_IOMMUFD_PT pairing with ATTACH_IOMMUFD_PT, and the
iommufd_backend_free_id() is to drop the final reference pairing with
alloc_hwpt() when the device list is empty i.e. when there's no more devices in
that vdev::hwpt.

DETACH_IOMMUFD_PT decrement the hwpt refcount and it doesn't differentiate
between auto domains vs manual domains.

The code is already there anyhow it just has the order of
iommufd_cdev_autodomains_put vs detach invocation reversed; I'll fix that for
next version.

