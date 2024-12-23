Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E625E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmSQ-0001xc-1r; Mon, 23 Dec 2024 12:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPmSM-0001uN-EU
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:43:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPmSJ-0004vx-Sn
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:43:02 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGunfX027490;
 Mon, 23 Dec 2024 17:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=YSEU101Zl6KEse2uVnRDPGBolWMaS6+JF6KWCB5GzuI=; b=
 Y4vd+Arqf0qqP/g42+/LSbyntRWopnN4+FMWUAOSrBLzuTEOdjMX0A8cwDNy7Y61
 dg9/tqRbMA7/iLNe7dMOjLpV9tcN6PC3w9sWHlW5MRqqTKRJtpCET44v8x6RYmbL
 wRsaJ7WEQQhVtHcSDrdcxAA3Z7gm9kH/bHQ4RpkhWK+EAsWzl13vgFj4hzaqOuYt
 uli62zGJOn4L8X+3SB39GzOcDjb4ST8OuEtUMHf6WSINYeyDpH3NOX9HrJQOK/t6
 ZN2ROMaAAiLt9B10YPY2BfeG5UXJTJxy5mnDblFXBXE9hw2FOKbbQAGbthXsK9y/
 kjLBLkzVPov8wJzR3cufbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq74aygr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 17:42:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BNFqMXS004672; Mon, 23 Dec 2024 17:42:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nsdg0pf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 17:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm0pw/J18bBrR5nkovrP0U99xxuHGkP5OCVQLzDL7e7/pefxT/1431zoNY9fHf99ULeSh82MMH96t/VB2LzMHl+0FPqnmUhuj7/YgfFkMc6ao/YJPQt45+Oqz4aL2+ywmMBS+H6/vxUWHDyczovQCw2nLibe6zucDliNIa3P+9s4vES9FKRItWBRWAc066k4VG1zze0VVFBETGqb5anYJHGTSXAdVlCC9sXxecmtSEmagtdyhsvQVw6HIP5fOdhwtbD4Yx9l42URi7BH5bHqXKjvM4/j4OF7yOgJigzGIdYj+hBNYM93U66MJpCNHdoxst2+X6ESFwMHTg5SLzG3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSEU101Zl6KEse2uVnRDPGBolWMaS6+JF6KWCB5GzuI=;
 b=Ura+M7+kOUIg3Wbh1pj+ldPws8DPeXtKp4DxHOZiY/putRPNi89fQpnkZVUqyOQmiFKvJ6oifAQjtctNfROU2NA4ni2WvCDyQLXr6t6F0IGiIq5VU8lKBeAPzcAinGmwQ8UbB/vOwnVmK5Yz/id3Zt5gGzqVE4xGB1MtdceR0AxOZqyu5z66y+UCEi4EU6uYU0zhR/WDlt28o6w17uaimXgnHTCfLS4i4ij4bMuYnp6kw+d28hIzfa2FI1Jh3cgst3cP0kYHnpAMkgwRL4X8BSTLVp+r7Lws8k08por76E2SG119mtvUcujCnSz/9HvbTcfTTFUnkAVr6M85CodVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSEU101Zl6KEse2uVnRDPGBolWMaS6+JF6KWCB5GzuI=;
 b=b4SN7cUHAUihJy4rSyh5E5RJWr2U9r2D3UDbolte9PFmtPhGShIpPyq5akTGs73VO5Vs1aIG4tBtj4FptCuFh4TJjykrCz/ioEuY+YiJdothBEpAzm/3EwWj/XR+Da/2CM28J0rsrnR+kuhuQPklAD9qjWzaCh+sB4cDcFynw2U=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6604.namprd10.prod.outlook.com (2603:10b6:510:208::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 17:42:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:42:45 +0000
Message-ID: <55e03a1b-82a3-445e-9c0d-f8d9b4c414c3@oracle.com>
Date: Mon, 23 Dec 2024 17:42:37 +0000
Subject: Re: [PATCH v2 2/7] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
 <20241218134022.21264-3-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241218134022.21264-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 259ef528-af07-4102-19be-08dd237935b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STN4b3g2dm1GM01pdlViZVlleU1uUTBVQVF3cEpIOE5uOUxQNi9UVHZjNXZs?=
 =?utf-8?B?cWE0TC9TQkhXemp2ejJlaWZuWmtrQzVyTTZtRGZIK0ZvS0dRVnNhZXpTUWEx?=
 =?utf-8?B?Sm5ORjFyMURLTUNtam5UMUVMNVUzQ1NENDJQQ1Y5TWpERGJiU0hUZG9BYStw?=
 =?utf-8?B?ZWZUa0RzSWtKZjdMbVN6WG0rNDRGdVFDT25pQVZLUHc0d0dpaGN1WWg2Yndv?=
 =?utf-8?B?bHVUVHlpd3lDbFRHdkRyc2dsZDdyYm10aUl4ci9qeWR3dHFqd01hY2dNQ1Z2?=
 =?utf-8?B?aE1zSGtsVmdwR245Q1dKamlFM3l5RlI1VVAzUXBtMTVWd0ovOVpyNWR2WjhE?=
 =?utf-8?B?dExXMFBqd0ZyWjliYlJFdGFMaGJhWjNpVTR1Zmh4dHVWWmZyZkoxYzFBVEFh?=
 =?utf-8?B?ODIwVGhPM2ZFVnNYTWRWQjZWNE9mQml5dDhtS1RQMGF5NGhoNDJZVmc0Und3?=
 =?utf-8?B?bEhWK0FwRi9YY2NjYUVIQk5SSm8vTUFqMjk4dFNXWUdlQ3hlNW5Ram5xakpi?=
 =?utf-8?B?bndyWmFQdFhBeFBJVVdmMTFkS3hWeWdSN2xTS0RjOUtBaWZnbHBhVmhjdzNN?=
 =?utf-8?B?UmNTU3NEREltaUFQNHJTNHNDRy9RQmxRV3FxSjRQdVJ6Y3dISGNvOVJJbGlU?=
 =?utf-8?B?TC9YV2lIbzRyQisyM3p2Vm1DK05EYUQ0NFdzeStQVkM5RHd5NDg5MURoNnJv?=
 =?utf-8?B?TXNPaG5ISndCbmgxU2lBaklKNTkxaWZKSEE4YU4zemZTNmJIL1d0V3JROG0w?=
 =?utf-8?B?QzJRb3lNbUpOUEFuTkQ5VWtBTE4rMDNmZ0hpckN0NURWL3RRYlMwbzlCbnJs?=
 =?utf-8?B?eEdlSnJwOEtJZ0NBLzc0TXFsWTJiRXNMeUlFM0RET3hLK0NmdGVyLzJYTm5D?=
 =?utf-8?B?Y2tUN0w3Sy9jVXV6SzRleE9QekRFbXdvOTI4YXhJcGkwV20zWVFGMmp6S2pN?=
 =?utf-8?B?dS9BeFdTV2E2enpaZE5pZU1VOEtZUytQQ05ZTDh1M0xQWTBRTTMwWHVTeksv?=
 =?utf-8?B?cVBMTjF3ejVmbVNmL1hlS1BaSHVOV3ErQzU5RXhhMUZMZVlOREdyN0MzdTE5?=
 =?utf-8?B?WFZmZGw2NjBxK1VHY0JGTnBySFV3WCtDUktVaVRQRHN3WHJzczlWQ1N2WW5o?=
 =?utf-8?B?by9td1NYUTYwRDJjcy9hbUNRdjF5ZEwvY25FUU1ta3FDb3BUQW8wT2VUeWpo?=
 =?utf-8?B?TUtsNkcvRitLS0lQd0x4eHREZkN3N0grUTIxSERrc25iaGpWUWxKQk16KzZ3?=
 =?utf-8?B?RS80RG8yNnltT0Z2ZC8wQmZuWjJXVDRDYnJwRTRjaEtDTnhBWHdtTkRpcmQv?=
 =?utf-8?B?ZXQ1cWx2TjkzTXhEcTBtaXYvZGYzQUxHUFp5aC9sSnUzZm5TUjdyYlpQbm9F?=
 =?utf-8?B?VUZqanVFS2xna2hNOEY5U3NyUzhOZWM0WGFwc2R2dC84R2JYMmtlc3BXLzVn?=
 =?utf-8?B?eEtNSjZ3OSswL2F2bHlaNkRtWHBmUkJGTkNmQXBrQVRmeVc0ZHVRMHhlaUl4?=
 =?utf-8?B?OUpydkM0cmJDV1gwUG14TTVsU2JhZnVtV05HbzMrelRjUlBwdEdTVnlZLzRv?=
 =?utf-8?B?MWlPWmg5MEY2eENLZy9IMEE5OHpOZmVJZFpzVUFXMjZIOGZUQmt5VEdYK3pE?=
 =?utf-8?B?eDJCTVZTRUJpaGdTRXp3eFF4SmxFNFVSemVmSXFna093L3MwWFZtREM3VEha?=
 =?utf-8?B?Tklta3U0YjJ1a0Zld0RLcVFXVnRMa20wd0NYdWRyZDZ3Vis5TkZyeHJPb0xJ?=
 =?utf-8?B?UW1tWW5SbkdUZWpud3MyOUhUMjJmdmI0b2NxblZyaDc0OGRUazJhUlFVRHpa?=
 =?utf-8?B?Z0FzcEFvSWUrWmVDNk9xd0RXYmxSVXdBd3VZcVJMZGZEa3JYdlRtZXYzU21T?=
 =?utf-8?Q?ZZfwXgNDWAFtC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJPVjAvazlzMzFISk5Ob3JXWmV6MWE5VWIzZG1jKzgrb0JUOG42a3BEWjRh?=
 =?utf-8?B?UkI5QStBcVJCV3V3RUNXLytmb2o4eWFtSXN2clRsZnlmZGtIWUNtYUM5dXBG?=
 =?utf-8?B?Nzk5bGZYM3cxMlhLZ3Uwelp5cTN2TXk2dkhtSVlhaXZHTm5Jc1BsTWhRSFhq?=
 =?utf-8?B?QlloN2FvNmgvOXQ3SWM3Z2UxRUZVNkhwbVFrd0drdTFxWHdobERnL0cwcFBl?=
 =?utf-8?B?Sm91dk1ZcHVYK08zOGZ5MGpJR1c4YXlFZGJ3Qm8vWU1DcCtiNkp5eDRhdnAy?=
 =?utf-8?B?Yk1Ga3RSZHo1Z0J5VjhEYUhVRFBjUjg3emJPWjB5dDJZOHJSSUZxbysvSFp4?=
 =?utf-8?B?SXhWUHF3Tjc3QTZCUTZpV2xHQldwSkJpQ3NENEpiMXpGYjEzaWhBSGhtVmxH?=
 =?utf-8?B?WGUwVkNkMExQRGN3TjJjdlpranA3QW54SzI0bzBPUWZzNElkNEl6Zi8zWGVE?=
 =?utf-8?B?ZlVDYTE4SUtIMU1TQWNYbXF3Ym9VcSsrUGRGeWptMmZHQnhpNXVLK2xOaXdV?=
 =?utf-8?B?K0Q1RzB3NjJDTjl4R0FqT2tMYmtPR0NtbWtUelhHNGpLZXBqZE5yaktjSHQw?=
 =?utf-8?B?NklvaWgvZGVyMU1GOStjdHpYZlFYaGxlYUg3ajJmVGRNVm5RYUxYU0JsOVdK?=
 =?utf-8?B?ME5xYmNTOS90bThlK2duOG1QcW1oK3AvVExzdjNQYXVMa0d1cEt3Q1ZQbmty?=
 =?utf-8?B?bXpuNjdnQUpIZHFQSmhVaC9rNjUrUnA0ZEJXY3IvRmg4Zk1uOWN3dEFJeFRJ?=
 =?utf-8?B?c1hYQlRXM2RNUHc1SDEyTFhab2g0cmo2MVJ0N1J0ZkdHWHdyS1VWNEhydzdO?=
 =?utf-8?B?NDVWWk5Jdjl4SHQ3MWpUQjZ2Y01JbVF2enBxb3FqOHlEZ0d6Q1ZEOFRXaGdB?=
 =?utf-8?B?b1pkMHBiWEtlU0xIYlhpbndxVVZsUGQwUUg4VHlLdlpodmE2cUk2TWNaRGRh?=
 =?utf-8?B?bjNadWszb25rbXNJYmZ1OTZtYmN5QXNOQklpbCtUd2Z1TzlaNjIwbit0Vnly?=
 =?utf-8?B?R3lPd0h2SHhpYWdEdTI5YjlCZm9iY05QaDlvRGhYWDJLSFNJWk05V0ZSSzMy?=
 =?utf-8?B?WjBNSkdIVVhEbVZtc2RUeFJHN2ZZaXp1bXVUME9hdWt0REZkNVdMaFN3TXNo?=
 =?utf-8?B?YURVOFNTcUdTaTE3ZkgxVXBHTGYzc3pYSTFBZmFCVWF0alp0VXpicDViNUto?=
 =?utf-8?B?OGdJZFJNRzBqeFp4SWU2c0xDRjVDUC85V2wrSnh3eXRQUXJnVG1LMDNUY09q?=
 =?utf-8?B?T0tkdno5Q2VhdjU3L053RXErbUt5b3ptRWdKSzZ3andqRDJ2TnpiTE1lbzll?=
 =?utf-8?B?dHRYb3ExelQ1WDVhZVVlenFnNG1mZkFwWm8xQmQ4b2hoUUFsNklkcVNSNFBB?=
 =?utf-8?B?enpYbERraW1rSnVKdzNReEdrdDFKeDU3cjNCL0FBRjlMU3NEbFZNVEFsMVVU?=
 =?utf-8?B?K2lhRElmYzJRNTZWV01CdGNkVmx4SWZBa1NXUzduc1ZnUytVb00xUmxOa2Uy?=
 =?utf-8?B?VzdwRWV1WGVXa1NoenZQVksrRytsc0lHNnlaNGp4c29mZkVOcXI3R2lZMVR0?=
 =?utf-8?B?MVhpNVZmdFI2ekdnZ1hhQk8waXQ3NUd4UG1TOURqclQ3Wm1rTzZnWDZaM2pC?=
 =?utf-8?B?Tmt1V3I1SG1nd3U2MmVrSlBZWjV0L1o4OTBEd2UrV08xbU93QXZyVWgvS2ZI?=
 =?utf-8?B?NzN2bm9GYXd3RDYyekJsWXh1anA1OGhxZnVwVE1PSEdkRkJnWGFVenNXQ3pF?=
 =?utf-8?B?Z2RBdm9id2xRRTZVUVg1K1VvOC9DcTZPamdGUGpWeFFERUE1NG1BTm96ZUJS?=
 =?utf-8?B?VVY2TjBOemVpU0Z4YWw1THUrL3dHWnpmbVJNSkROMDNMYm5UaFhkQkJsNDJW?=
 =?utf-8?B?R0JHeFY5cWVERjhJWFg5Q1RFVnRiL2FhS1d1SlZUMTRjMmRoU2tRYUVhZXpw?=
 =?utf-8?B?dE9jSFV1VzN3OWM5V0pvUTJpUVgrajVwMHc4MnUyb1l3SlZpeis3amRRTHhR?=
 =?utf-8?B?QU55SWI1bTJLOXJ0emwvL0dmM1NwcUlCeGNQTStRalYwWVpHeTlKRmFPWEZG?=
 =?utf-8?B?THIxYSs4b0I1NEx3b2U3US93TlBRMHpaeVpuMXk2UEM3WE40RXBOTG44Z2l2?=
 =?utf-8?B?czRHN05TeElNcDVYZndod2RmbVFrVmkwWk9Sc0dOaGQrNU9aV1pnNnZwbnp4?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d56jAECN6vUyqugIZC+DFSyM9EM2VhJnlwaeD2uOYX1K3Zd2X/0oPGDl8QG8z+/eltxZO3CHLBQSpDc2hg4WHffQ87lbZnMfSo8fe4gxDWVZs5ep+Pt4f8tVZHYuu6G7akMLjnWbg/kV+m88XXBUMQfeaCQjaJStRYOq+HRKUVvnyqm2Fm8dXFHexorJnaN5v+TVh+rYv78WQj+kZZ/5xRLTmgyHRInKdxzwUnXi9ezUGTNwbXighiFbvXNRJ/qoMU36vXU6x0D/XMObrE+J609pRvRCwgeSqrWq6AxAJNaRmcHRPoGGNSprNS/Pfz2D7oH7pQev0/7qzNWJb/pjO0i3wUUVfEGFNpYwRr4EsvaW4d0Fap7qXmwdCSmHKcLsX85B78GkPdr2uDUQo/uTC/+qTGZLLZ1ss9l4TbBwVAhRAxsl7PKKPC+Ci66JNgKIXyQGLVi6a/urV5LWeLk8I95vvMpa5ePPpAiewGxf+KgO2e6RTQ9l+iteLZEC2FgPbbfbuRmo+CXf8vT39OWhIH4SWW3vxtSZpRdS85NAdBSLd8K+ZuwFZljdbO0+WR5racqN7pew6sdXM5TxBJIHGrtm2IvLx8SnInF+W2yE4w8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259ef528-af07-4102-19be-08dd237935b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 17:42:45.8510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFRxOiwIs8dqJpe398NrH+LEY7AVKBP+9NUTEA/G/EsiIEqiux4JPz9MUT9fNDvPoqnYUyhXlb4G/f/3u28lTYaUJu1gC6zIlT3+l9ZOg8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412230157
X-Proofpoint-ORIG-GUID: B9tdoP5wYigEzV2HZJPFDPtWHgeMYImq
X-Proofpoint-GUID: B9tdoP5wYigEzV2HZJPFDPtWHgeMYImq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 18/12/2024 13:40, Avihai Horon wrote:
> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
> check if dirty tracking has been started in order to avoid errors. The
> current logic checks if migration is in ACTIVE or DEVICE states to
> ensure dirty tracking has been started.
> 
> However, recently there has been an effort to simplify the migration
> status API and reduce it to a single migration_is_running() function.
> 
> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
> it won't use migration_is_active() and migration_is_device(). Instead,
> use internal VFIO dirty tracking flags.
> 
> As a side effect, now that migration status is no longer used to detect
> dirty tracking status, VFIO log syncs are untied from migration. This
> will make calc-dirty-rate more accurate as now it will also include VFIO
> dirty pages.
> 
> While at it, as VFIODevice->dirty_tracking is now used to detect dirty
> tracking status, add a comment that states how it's protected.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-common.h |  2 +-
>  hw/vfio/common.c              | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e0ce6ec3a9..6c999be398 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -143,7 +143,7 @@ typedef struct VFIODevice {
>      OnOffAuto pre_copy_dirty_page_tracking;
>      OnOffAuto device_dirty_page_tracking;
>      bool dirty_pages_supported;
> -    bool dirty_tracking;
> +    bool dirty_tracking; /* Protected by BQL */
>      bool iommu_dirty_tracking;
>      HostIOMMUDevice *hiod;
>      int devid;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index dcef44fe55..e032ce1b6f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -170,11 +170,26 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>             migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>  }
>  
> +static bool vfio_devices_all_device_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer)
> +{
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        if (!vbasedev->dirty_tracking) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> -    if (!migration_is_active() && !migration_is_device()) {
> +    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +          bcontainer->dirty_pages_started)) {
>          return false;
>      }
>  


