Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8370FC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQr6-00080z-8U; Wed, 26 Jun 2024 07:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMQqw-0007zM-CX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:30:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMQqs-0002en-Eg
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:30:16 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sH6E025745;
 Wed, 26 Jun 2024 11:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=RjPeD3v7dT6U8umRO57llWSIxk8EsfeZkOPy0BzBnZA=; b=
 cz5+qH0Cxt4wBMmYrb1pDRKVKdj96CAeENWTJDEHSZWgZHrOuK1ytclHs6aZuiqB
 hwGnHfpCjl9imqzAsookfbiOUtVxn728GfENJF0qmoH4E+1t9dbQqmxnpC4IPWh9
 2Lv3Gjn5/7MBHBi5E3M/A76twGFdvj8Nd04dPAWTkQ7B+AlrwxTEDGl9RKzR+twZ
 P+huQ5o2LR6C9OsnAinMJAp6jxbt7Iej6cYgRoQiycnRiVc0x0aGqctjEcgJkl6x
 qUPLKdYGBNA0utzAu0xR3arLnmqmmu9xZPvpR4HExu2yDMvUAzGmm7eYMX6F1aW7
 2W8kAnYrPknpXEs34ELunQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn70b2kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 11:29:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45QA5FVf017859; Wed, 26 Jun 2024 11:29:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ywn28v4f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 11:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaSFGs9pZZ8fro6tiLmI+0rsaBmN7Hv92r/Cbqv5j3nbRFfkn6KwaFMDIlHvSrJG42dLFTKcCO0RpCP7JwiurOLsR9s3+3UQnUboZ8rF6HKjIjOXBS+LKwrG37nfOduj7gvPFkhrPjv8Z6Arj9GLyq8LR9TV4nlVkAzVXk2FDiJgVv19u2TC+DGpBYtZkuJj7Iwc2mnGANWbSQgLgDW2WrFI93d0EIAeTngZHXgdwsIbddmbDYk/R3PE1/vbNMx6L0FKElbIRnm2qz+ewffpaWGhgAw/nJZsUDMMuhBLQ3A0RxPlkelsMQB9MzOA+xlmX7bBGA/bCEKytsr0DrGWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjPeD3v7dT6U8umRO57llWSIxk8EsfeZkOPy0BzBnZA=;
 b=LfhJ+VrqcII3IHfKspxFPW8g77F/Qio2mm0M4hxFoSPxRA9LVxh8hLYszKDUn/8G6CKvSkEm7VG2dN1NFz7wFQfMUxSxps/kU+UktNhnGiHb+4cHccQInJ5dz43B1LoNdsQX1EL7zZB1fg8RB2e4OHL9PjSPM1xFct7FKprByVQoUUeyAVmZKY3QX8mf8jSvL8rNXOJOrsN6O/mmP4RscwgpAi/zUM/Nlw4Q+Kak9HEiS2RcgvgGcIqH3wKMdApFJWHjoM+HrBSPwD6xjZDcyhQcQNdUWuLf5tmGwWEc4uYcfGWSzMnMbVH0K3lNDQJ3gl+rCNlRtpK50GATFsvkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjPeD3v7dT6U8umRO57llWSIxk8EsfeZkOPy0BzBnZA=;
 b=b2q9UHOjBzaEmZ4Box+DXRi3nVtm07n8Fq7Alv7ofRWy/ecwJ9NOwkaCTOjwK27+eJ//9TYf2NCK9SH6IgT7wHjip3ovFXguhIb1KoDAi7W7/lnC0VhMJuiK1NU0aWNqN161DahPTQdX2aFU6X56OFMUPwameF432RqK6sKM1C0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV8PR10MB7941.namprd10.prod.outlook.com (2603:10b6:408:1fc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:29:55 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:29:54 +0000
Message-ID: <9b6c50d2-5c42-48b2-8e0b-b6304f225679@oracle.com>
Date: Wed, 26 Jun 2024 12:29:41 +0100
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com> <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com> <ZnrZ9W6WpvmDBpgv@x1n>
 <ZnsOdiHACtL90f3J@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZnsOdiHACtL90f3J@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0285.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::20) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV8PR10MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0435f2d2-68c7-4897-c664-08dc95d34d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|7416012|376012|1800799022|366014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHdEUThkVkRIZmFCdXprZUNVMnBTNDNEbjZNUWllRFRiNlRPWXNqNy9NaUw1?=
 =?utf-8?B?Z0dpWFBHcStKQmQwUi91NjI2NFIwdVlKTUNuemlCcjJjZ2w1Z29xK2tHRndY?=
 =?utf-8?B?U3RoNVZlSmlEbFVUWW8zZE1QckJrZklQTjE2UkhlYjZlaHQvd0hRaXY0L2gx?=
 =?utf-8?B?MzRRNGVxeDJxYUlEVExqN0ZhSGQxbTN1S1AvT013bDBlNjhVenN4b1YrZlNr?=
 =?utf-8?B?QldST0VXZTE4eGt2ZlpGUE03dm10c1NaU0hWM1dVZ3hjVFlGZE8vN3F6aDJl?=
 =?utf-8?B?RTV3cmJJZFpvUW5uZTRTeHM4QTZXbHlXeUIwUzF2dDJObG9CRThjUnh0TVFY?=
 =?utf-8?B?Rk1MbFlvZFBsdnorTU5pc2lXbjNPbm9FSmdRT2JXZzRRdk9CMDFaU1VGN3l1?=
 =?utf-8?B?M2N6aXorT1BRaFkvQ3VQT1pHNHdlR0llK1ZKMnFWeDc4cXZVWTFpSjNJcEFz?=
 =?utf-8?B?NlBNUSs5bll6eTd2Y3FRTVEwN1dydW02c1IrY0owNldmWkRIOGUzVUw3d2Qv?=
 =?utf-8?B?RjlpY0JIT2ROT08vNUNrVjROcUFhM09kT09kL0MwQVpnT0lwTjFPMVFHeDht?=
 =?utf-8?B?TFczQW5PUUhmd09vanhYMkNhQzRGVGVUdXF3eTdZZkw0QSs5eEltQW9tbXVm?=
 =?utf-8?B?Vkhxak93SDBDZzdrUzc2YkR5cC81WmhSVERKUzhRK3RTNzduOGRyc2Z0cWxH?=
 =?utf-8?B?eVREUUowa2FGK2VvRktleGhVTnFtMFR2YndVSFg0eEhMVzJsNy9uQUt4OEhD?=
 =?utf-8?B?TVBFK21TUFUvbThiQVdhTmdMSStTcktSQ0tKUGVIaVUzeGJub1A2NWRBVUF4?=
 =?utf-8?B?ZEUrWnF3azhib05NUU5vMHVBd2hDYnZvS0VCSXNmZFR5Lzdkak5OT3hMVnEr?=
 =?utf-8?B?TmllcnQweUl5SmRwbzZ5U2ZTd3VpbXY5Z1ZFSysydkR1TGFONGN1VFprU01R?=
 =?utf-8?B?UTEvdUF6YUt3V0lYWGxFYno0ZW5xTVFUK1A3eXQvbkZVbWRWR2lBUGVmUk1x?=
 =?utf-8?B?QjMzSTBQeUI2WGJqWEMvU2swZ2l2TXdvUkF3Ylh0UFdtZzRaUjlUNzQ2ZC93?=
 =?utf-8?B?WDlMU1pzeEl3NW5NMEl2enFKNFZ6VEh3Vlg5MWFLVDRqN3JKY284MHZhaWx4?=
 =?utf-8?B?VTBVWlBRbmlXeURxWk1zc1VRUFpyUE5oWWNUekN5WHJUQzRVQ0E3QmcvZVBj?=
 =?utf-8?B?NklpZFl1Q1V1cVZCcUxnSTAzSFU4RFNIN0dBNmpmMDFHOW80WGtaM3VGUDdn?=
 =?utf-8?B?UGVJRW9FTlhOMkFyMzVFcmd0Q2wrL2lsdFR3ak9yWjJKRWl3QS8yVUJuSWV1?=
 =?utf-8?B?dHFTWkJNQ1ZlZkFTWnphUUZJOXpmd2hkYm9CcjE1aWVjekZFWkpNYWUrZWpN?=
 =?utf-8?B?N3ZKMVA1cU1rejByZ2wrV29pMGlHSUtOemV2S1IzRElVeU5CdCtPRXdPYndR?=
 =?utf-8?B?K0Y3WEdKbThKdWlvZ3hhd1VQbVl3cE84U3NXcW14SVRPWFJRZENBaE02d1Jl?=
 =?utf-8?B?TWprLzBJMnBvTml5TVBZcEhjNEVleklobm9KTXQ2QW9waWwyenlGU014UGt3?=
 =?utf-8?B?KzNPWVdwektRN2FoeFk4eElQNm1oSVhVKzl2VDhwbE4yS2I5S1FaMkUrdmov?=
 =?utf-8?B?bEtHVCtLQ0VyK3NSSVRLa2RLMHppNDc2YUlDU09pdHBEZUtaR2FUTytyM1J1?=
 =?utf-8?B?bFNMd0VwVW1sRDNPMllheXB1cythSVRKRjkwU1Nqc2UxNHFFNG9ZVld6OTBn?=
 =?utf-8?B?MWtKb2tvS2hnb3JqY2lvc1Y1SExzeExHeEJ0c3RTK24rb1dPSEYweVZmYXgx?=
 =?utf-8?B?OUdHNnl1d2p6MVZQbyt4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(7416012)(376012)(1800799022)(366014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ViTzc1MU50NC9BUjRNQjlYWHdDTEdyaXp6UVh2OG1LbENXT3Q0MWpvVmRs?=
 =?utf-8?B?bE4wdzN0V0NkZVI2MVhMWlZUMWZIRHArNUxSMElRbDMzZzg1NCtaK0o4eVRp?=
 =?utf-8?B?dzYrQkxjOTVIT3k2RVFMbG96YVdnaG5HWEZOY0MvUTlabmxGeHB5bk9JOE9F?=
 =?utf-8?B?OW1EelVvSWxNczRCeWk1dGVPeC9zS242MWdnR0ljbWZINHB3TDZwMmFsZCs5?=
 =?utf-8?B?N3VxaTl4dFgwREFnNnlmb01peTFkaytuVW9hd0s2VmRWR3NoRkxrUHgzTzlj?=
 =?utf-8?B?WDFIQlAvMzhoOVFKYTNXMFI0Z2UzeHBQcGdKdVdKWkRwNWpCaDhIc2gvT291?=
 =?utf-8?B?NjlrdGZibWo5ZVZ3SmR0TU1GVlNIbGE0dStkd25QS1EzOW5GQU1iaS8zdFJN?=
 =?utf-8?B?Y0RGMHRFZlF5bGxXaGhWVVpjMmltWENqbGdrRGUyOTdWV2U0QXE3UkxWTVNC?=
 =?utf-8?B?OS96SU5xUzZZL1lpRHJFMTBiZ2tobVpUbTVoa1lVZTdWWFp1cVk1Sm9YMnNB?=
 =?utf-8?B?RzlQN2RJUjdmQnpnUnQ5Zy91bHQ4OWZ6eEtyQ0g3TEk4a0FmdW9KY1NNR1Az?=
 =?utf-8?B?N1FoeWxzZGJTNjZ5SlBpVkFta0gxWU15OHVoUVVMekJobU1aSzVUWk5IOUls?=
 =?utf-8?B?b2V3YTFMbWJ6QVdyNUxFS09DdTBtbERRaEJHeUVJV1JXUWhxRU1NbFZ0cmJl?=
 =?utf-8?B?cTRTSXAvRy8xaFh4QzZCc3FzTDE1dUxweWZxZFhmbXo1cDR6MXVHa0ZvSm9j?=
 =?utf-8?B?RTB4MzVmR0RtMnZPNnp2d3lScnlIaHBUMWh6Q1NiUmI0T0lDbU5PamxHVjB1?=
 =?utf-8?B?c0Rvc3BFR0NYbTJucGVZY0ZNanZSOU0vQ0RMRTdHUW9wS3ZLdC92VzRqM1g1?=
 =?utf-8?B?Mnh0cTZHbUJFZFlmYU9HZGhCZGcxL05sc0FzK0oxNWV6aG5SOTMwRFpRRjZR?=
 =?utf-8?B?cmhVWWY1czAzdkUvTUFHSkwwdFZpZXh3b0xzR3Y1aHhXL2xkTG9VeVVNWGxQ?=
 =?utf-8?B?QnNYbUtCTFNUdU11NFpQT2ZxZ3VmZG1za2MvNTNGOXllaWhvVW9ZRWFCZHho?=
 =?utf-8?B?ZW8vU2NBY1o5SEZuaVRTTXpaQXg3bE1jQmtnZXJjVGxSTVBpWjJjQ0kxTHNz?=
 =?utf-8?B?RzJFc1gwWEJlSTdrZ2w4eHhuZUtIMjFLbFB6K3hsNDJKK1AzVm9nNW9HOWdJ?=
 =?utf-8?B?cDVrTEtVaUtpZ0R1VFRFUkJUUzI3TmxTT2JtUVNsQjdGV05ta1ZvcHVpU2Vk?=
 =?utf-8?B?enNkYjY0TVhzK1BhczRYU3FBMWw2ckRUWDNIcWRzRGJpOXpKN0xtVEE0dWRO?=
 =?utf-8?B?YjZLd0N5NEhOTWY4azYvM3U5VDdHaTArOTFjZzFpQ1I2MlYrNFJ4dFhqWUR1?=
 =?utf-8?B?eXZPakhhY1dQZnRnVmdvSVdHQUgvK2hzUEtoMm43eW9vZFNvZ05WM3ArdHhv?=
 =?utf-8?B?Tkp5M0JiTlZPaGxFa0xjTnVmNHZYdWRNbkRhYUhkYVFnbndYRDdEbFVFMWh2?=
 =?utf-8?B?U2lqeFMxTXFyS3NPaUk0dDRQckpEU2lybG9vMDRWOVo5cktuOHFNU1pzUHlF?=
 =?utf-8?B?QmJnWi9HSTBIVzVRZStUNERFRk0rNW56UDZMbC8yd0UrUFo1YlgzNVhySHdH?=
 =?utf-8?B?NHdJSlpNaEduM3lGOWJ6Y3JVQUg3dEo5OEw0dXg2RFFZdUtHNlN3N29hTHJL?=
 =?utf-8?B?MnFPYU8vU09ISkduTGlxamRwZVVZL0F4dFVWRVhvR0tNVU41NEN5enVSNE9R?=
 =?utf-8?B?NHNsOUVrelQyWmhIN3JPcDZDUUJNa012OE9rbFR6eUN4cjl6cmdYdkZ3bWhq?=
 =?utf-8?B?djk3c3VNaXlqK1dOVWtQaXAyN29xalVuSUtEQWJqSkpxeXVOendISFVVWXQ3?=
 =?utf-8?B?VTA3WmdSS2RtTzcrR1lxU1lhbUF6OWlVS2RVMWFvWTdTd0lZbStpSjFtNFhz?=
 =?utf-8?B?N2FQRzltNHBUTm50ZCtMWWtYNDI2VVZvZ1FnSGZLZkpzOFk5R0JBWXNXd2pn?=
 =?utf-8?B?WU1OZWRybmNwUUtEYXZEQTcycjM3REl1ZGFxQ3NnWVF2TldNczgwbi95OEJv?=
 =?utf-8?B?M05YM2xlSExRWWxmeG9FU3VsY3d6dnJZUnd2SkRuNDczd0dMeU1NbndodzlI?=
 =?utf-8?B?amxFVks3RTRYcFBYdlRWTWRjdnFQeU1KUUpieXlMY1E1Tm03VkoxaU9kZnIv?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ihpbcFHWEBnMn6D2NBgRk77lYC2Taw29ryPB6fA2cI9X3t+ykd9JsGzgtNokP0Z4k1nd6VjWG3nod/oVSGu8/+NNtzgpA2Tjr9840vwAssyT6+XORbTTYrF2mH58fC+LiMl4ehAspddt2xI4RlSS1AVBPlvAVPkc2ReZYiWUiLt9g2chYN4Khlyz4QdqGXrqq6yAxcMeq+x/cd57E6Gm8vVxhI9JUWepfoTbRJZ2CUEpVytaMz5Y+AGwKTAMyRRkNIIevPkcC/HB8ABwACEOuTWDTJ5YXB1pjkEXgIzgLhMeN3fLNz6rDzbfXTbzw7xUNfKxh/USvPC0QTnFjTXTTMUSGGxIvRI8bo2Jarr+DTRHL+R/hAFyDlof3AQL9zQgS7KPHFxoxj+we776EksZhQwrjYSsyQFxVmHN/QPMMGWGA1V2zh19g3IVV4Y1UDqTA97AeR/ZrathpAjkdN3dMMxF6pvBCgZo4ZCLUn6IqKSQnrfXJOqzDEn1veUGjAhjZAi9BcTV/HUH1yBUE74Rrz03D330ZtA17HWzIXz+9/37mLwfKBsKs/q9l06PqTuSoF8R4bEDxWqOwJuIzDgKmNciLAggU5iYKwbl5BiFzmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0435f2d2-68c7-4897-c664-08dc95d34d3d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:29:54.8458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfcy144AAUe4Do0lN8wxMtFpu6SV5bb32hMwvQz0itqzgMOpHkhDYocwQUEhLJrm5X+X9xJIEgCmUrHdV8QkG2vFzkaYHx/SXkLqVZFsq6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260086
X-Proofpoint-ORIG-GUID: xczwPMSB0CTFcu1HAPbDQ4ORgHGzt1cO
X-Proofpoint-GUID: xczwPMSB0CTFcu1HAPbDQ4ORgHGzt1cO
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

On 25/06/2024 19:37, Daniel P. Berrangé wrote:
> On Tue, Jun 25, 2024 at 10:53:41AM -0400, Peter Xu wrote:
>> Then the question is how should we suggest the user to specify these two
>> parameters.
>>
>> The cover letter used:
>>
>>   migrate_set_parameter downtime-limit 300
>>   migrate_set_parameter switchover-limit 10
> 
> What this means is that in practice the total downtime limit
> is 310 ms, however, expressing this as two parameters is
> incredibly inflexible.
> 
> If the actual RAM transfer downtime only took 50 ms, then why
> should the switchover downtime still be limited to 10ms, when
> we've still got a budget of 250 ms that was unused.
> 

The downtime limit is 300, it's more than you are giving something *extra* 10ms
when you switchover regardless of where that's spent.

If it makes it easier to understand you could see this parameter as:

'downtime-limit-max-error' = 10 ms

The name as proposed by the RFC was meant to honor what the error margin was
meant for: to account for extra time during switchover. Adding this inside
downtime-limit wouldn't work as it otherwise would be used solely for RAM
transfer during precopy.

> IOW, if my VM tolerates a downtime of 310ms, then I want that
> 310ms spread across the RAM transfer downtime and switchover
> downtime in *any* ratio. ALl that matters is the overall
> completion time.
> 
That still happens with this patches, no specific budget is given to each.
Though implicitly if downtime-limit captures only RAM transfer, then in theory
if you're migrating a busy guest that happens to meet the SLA say
expected-downtime=290, then you have a total of 20 for switchover (thanks to the
extra 10 used in switchover-limit/downtime-limit-max-error 10).

But keep in mind that the migration prediction *does not* account for anything
other than RAM transfer. It happens that maybe your configuration is cheap, or
has been optimized enough over the years that you likely don't care or noticed
that it /could/ hurt the user designated SLA even if by a little.

Regards,
	Joao

