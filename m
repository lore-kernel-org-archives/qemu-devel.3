Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE871C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpb2-0001Eh-G5; Fri, 19 Jul 2024 11:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUpb1-0001ED-6n
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:32:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUpay-0004h5-Le
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:32:34 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JFKkXG016479;
 Fri, 19 Jul 2024 15:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=7sJlOX1w4TcX4Y9UcgNN3jklWUYGHYKdNBqaePDKfbA=; b=
 nMZNjAPajq1RLX4FAK6kb8fzNqnsPsYhlaGGq012ULKwh3tV0PSGmu9PkZZBJZiB
 f5JcuWy0bHJ9pSdIcKVr2KbT3y5ymh36MjdqBUxsavWKJJ1FgmNAjHvONiCAEyZS
 VOq0duPpDOtoGt0aIPyVYYM1+lMQXNAMXOUKZxo9vBel8Ksq5ER3YDODAapLwltV
 H5+R2qhHJYGD5JAWZtOAyA4RcukWWX/pNMq4shmiEprWZtersEdgrryjpwmW4qyw
 mAvWEXSKp41HqvozTMRCTN+ZmU/2qkHTWBJOqLHP1GQ475+xua6XbyP3e3YfOgxu
 QoCAvy8hLa2RYH9CuRLA2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ftpsg22p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 15:32:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JEFvLK021939; Fri, 19 Jul 2024 15:32:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwew2s3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 15:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGNl2y4B/e02FRFtcZdj8tIsrQCCsLqoMOwHsYWnt/3DtHLXpxvRW6707XBGGhvY8XOBIOQOSiNUOXAFt1dwbnen2yYoJpJslmlspwLvPWybpzSVec7R4Ny8bTdxKqQmKfHF/yIpENgCU4SxQPoHsNtmPyaDbRs1zDLIUK3DalaZN8Nt2iN5+znVo2F182OJS15a1g32byxleBI2ZJjnNhBDuwr2Ryw6IqJvduy21tMg+X8B1a/j0PZWFmXMhd2NFfrQsiPcxRq5EYThs72p3Te0WuJXeI/o/sKJW+xh2f3xXJVhpxe6ZHyKqHMT6G2npwb5ETxbcFiJGd9irOnKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sJlOX1w4TcX4Y9UcgNN3jklWUYGHYKdNBqaePDKfbA=;
 b=botcvrtZwXt1XFc5LB/xGGoFfHwBVMRW0GV8spkEL72H02tsOj2mmhYbamTryOz8GzgCDf71O9opXclWN1TRc7cGbHL7D98xbWeSkXPbvytfACNo/EMBp5vUR1yfd0qbvSXIqMclNkaA//bvfwjo9LxlmlHr/sk0yjO5IhDf8R0Ya4X63JWoJLyBLFJP7M3u649kz1ZLOQ+fvFxcOP+Sx5gsOLaszgWpmLN2StzSZxZ+Qhp50tgRnRcjIvTtGtR6paSAuvjpKBYN7KeQWYEZkG3if1rH6fO83WAjQYkjVPdr0yl512/kmHhga+cWGr9StwnVXPP2nCDa8VVuPTJrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sJlOX1w4TcX4Y9UcgNN3jklWUYGHYKdNBqaePDKfbA=;
 b=Wvo+U9U0CnkFtO/uvsE2ex1cHWEMb9y1z22mIvk1Pix/XHzn5zH1dRO2ws470MOKa7DNpZwG9tO482Pic6gi1URCaMt69W/Mz6kuPoR6mblxywahJgtIUUfICv6q08wSFXMdAEwq3t/OJOR3ulh5v7hncrNYJtXvqXMg0iRZ2Fc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7863.namprd10.prod.outlook.com (2603:10b6:610:1bd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 15:32:27 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Fri, 19 Jul 2024
 15:32:27 +0000
Message-ID: <97c34853-d581-4301-9925-de24098066ca@oracle.com>
Date: Fri, 19 Jul 2024 16:32:21 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
Content-Language: en-US
In-Reply-To: <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 973f3cc2-c214-4066-f47f-08dca807fe7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGR2Q2lNYitSd1Mxc3VRclFhR2VkNHk1azVZQnpuVCtGRWpSUFVzbXZTSmpH?=
 =?utf-8?B?SnA0VXNhV0p1b0ZYS2dDNjl6MGcvYWpaaHIrMmlIQ0lUVmNRbDAwVzUvQXZV?=
 =?utf-8?B?SFQzMGp1cm53cCtpR1phaGJiUTBWOTZvQ1doOHo2NkJUQ3dYREFHbFdDWmxn?=
 =?utf-8?B?SCsyTUhMSC9pS1NsdWt2S1RlUlRQMkU2cktvdU9CV0xhZDVRZFo2alNjeUd0?=
 =?utf-8?B?aTZPbzhOb00rNzZIWFlGOUkyaFVPQnV2WkM5MFRvSThzUmNENDkwZlcySWMv?=
 =?utf-8?B?YnI4ZDh1OWZKWFFzUEgzTE9HdUxhNnJqTWpZMElRM29UVWtSVnZnTFNnaEc5?=
 =?utf-8?B?QklVeTNlVnNOMzJvMjZ0WjNlVXBpZEpoTU5ZWk5hSGlxNE9qYUxjSm9nSTZP?=
 =?utf-8?B?UWxQU2NBaWdRTjNXM2F0MzlQNnM4TTlsN25PNFltVDZhWmNBR0o4cXluU1dN?=
 =?utf-8?B?UDd1NElOM1BYOTlZL1VkWVBqckhvOWdwc3k1c3ZISzlFcDlaMlUyN01jdk9X?=
 =?utf-8?B?WlBJQjFsWmJEcGNUYWFTYlZsZVFueVBrMUgvT3lvZnpQcG01dE1HeGppOU5X?=
 =?utf-8?B?N3dYT2Ird1NIbXlPSmsweHhFRUd4ZHJRd05VZlNseEJjbGNLeWxYeHR0ZmQ5?=
 =?utf-8?B?dE50T2tnWGdDcm9nYTJzN2haeUNGNXJFbEFHQXVTZUFxRFNqR2lWOFd2aGtX?=
 =?utf-8?B?UEYwNUZlM0VZZjJLSHpjQUVpWHZaS2s3MVh4R29rNy9BTDAzTWxhRFg0dzFs?=
 =?utf-8?B?REtxVWgvNjNzWEtzQjNRYXdhMmh5eFRNOGNtWFdGRndKQzdnbjZ6Z2Y3R2xk?=
 =?utf-8?B?c0dCNDhxU0FocG53VjQ5dHU5ZWQ4REtmMjZMODZsUUtjN1pIaVY2SGh1amc0?=
 =?utf-8?B?dXUvUDM1ZDFPbW44MExsdTZaY2FzY0k4eUZObE84cDRHOU9tRTZPVGZhS2Vk?=
 =?utf-8?B?VXRRMlZQb1Fqdm9OYUs2VzZTZ3hHdFlyVk9QVXBOaEgyWThoaHpKbGthUTFa?=
 =?utf-8?B?MXhaNkZjZjNDTmxNVlpPNFhHRXRRZVN5cGZOUWFmUk4yNzFJVUY3UHErVGZV?=
 =?utf-8?B?c0paeUVZeVlFdHhKbEU0K2J6M0JFZmtPU1d1SUF2emFCMk9yM2s2MEptVU5k?=
 =?utf-8?B?OGR1SVhvL1VKTm4xdjA1Vkpna0g2bDM4anU0aEF2Q2dFRmYzanVSMzdFVUtY?=
 =?utf-8?B?dEEvajVjcm5HbjFIaGRCRE5MODgyYUpTMHZjb0VTc3NmYURMb05uSDVRVXUy?=
 =?utf-8?B?R2lXRkJwcXV3N3FHbzVKUFRydVltSldWb21WTE1NVE40bEpRbzdqc2lCZVR0?=
 =?utf-8?B?anFpQUxvekwrM2poVHB3VlIya1g3TkVOQTI1Ky9oL2l4bk9pQk82L1JKODBp?=
 =?utf-8?B?RUpDMFR6OFdOZzUza2FLWTZ0S3BvcDdBeHBjRmJFc3FvT2RqQVAwS2J1blJD?=
 =?utf-8?B?WlRaNGpmRW82MlFDVTlSS0NEbUZxRk1OckhQMlR4QWVxdlpKS015THR4aU5J?=
 =?utf-8?B?eUlCV2pFcXNUdzNoZGZ3L0h0M09LWFg2anFhK3VWL3hVVnF1VW9qcWVKaTdX?=
 =?utf-8?B?VFIzY3BPekhvNDBpdW9vYXAvbEc5dVNuN3R0UE5oK1QzTlFEcEc4dXliUTM4?=
 =?utf-8?B?cjZBcU9TaHBXa0Y2U3hVaHFPME9pYkpia0w2R3NDYzhPZjB1c09hMWxjOGU2?=
 =?utf-8?B?WUhuY3gyOHVCdGxSblBzcmRFTmJSUnMrRGxjaEZaWTBDdHFTZDlFVjhRM2l2?=
 =?utf-8?B?ejhoSyswZXY3NDZENmxGaGhGK3F3bU9Oem9jUllsU3RnNURQN3NBQWxjK1RD?=
 =?utf-8?B?SG5YZkhvMEdGemltUUx4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVVNHZqQUxvT2pjWDlrVkNPRUFUbzd4Yi9lbzhtTkRIWjQ5TTdiaTh5d2FB?=
 =?utf-8?B?NTZqd0QxQ3lGL3JCL2tQRCs1NTFZRXVuYi9IOXI1Uk9IZ0p5UlcwRVU2R1Rk?=
 =?utf-8?B?VkgxeE9McndubDlHamtwelkrUWhaMkMya1N0amZhbjE4WlB6T24vclI3cEpu?=
 =?utf-8?B?cHlHSGdncGZMZGdjajBiNzJZTnNHa2RXaUwvNlVCamVSM2NiaG9DSzJuVkhT?=
 =?utf-8?B?YzhWWHdldFVlZEowZisveTRuT3locEZCTGs2U0JFVUxUZ3V5WUxRWWJkN0hm?=
 =?utf-8?B?VnpaSG1MYzhRMlRxaW0yeVJpcWkvYW50THF2YXg4YURrQVZmUkRmc0NFMTdJ?=
 =?utf-8?B?eFZTVGhNQ0V5aXA1YnhmcjJoWDFLWlFmN0RPdHZ3Ylp5c2Y0Wk5ZSHljT3BH?=
 =?utf-8?B?b2NGRE9SemtKNkNYVllyeUlYc0FSaUZrOE0yT3M5MENGbUtIWDVtV2ZxTmRs?=
 =?utf-8?B?dlBsemV3dDVjcTNoM0FxUkhQOGN4NzJzT2Nwc1hhSkg1Q0FXdEJyWGNFeU4y?=
 =?utf-8?B?Q01PUm5BUG1xbmhGQ0JVK2U4bzdiT0ZTV1NMWm10MEpOVGQ4OU1qVnhsR1kz?=
 =?utf-8?B?bHo0dmxJZEZ4a1djN2ZoeEZnSjJHV2FZMHlkc3dlMlZMS3RYaWtNSExRK2Fj?=
 =?utf-8?B?dWZRaDc2UlQ0VExsVWNvWWQ1UjFLUCtWdFBOcklLczI4R1QwK1owWUhicm5P?=
 =?utf-8?B?dEsxN252VUFqTEJXMWZnWC9uZWJkTW1XeFBSdFhvQUNhMERzSTJhQ2x3ZStS?=
 =?utf-8?B?RTRSYUZIM2xVbk1oTzVuQ1ZYTk9FaE9UNW9GNkNNL2d0a0hVOTRaUTRiQ09U?=
 =?utf-8?B?K0xTU2JRRG85dGFUWEJrQm9JZWJyOTE5SmxsMzFTU20rYmtiNis0RituZmg2?=
 =?utf-8?B?YVI1MGhYSzhiY29aaWNldnpsdTJadTk0KzdRVThDK3Jrd2J4QSttdDl2MVlF?=
 =?utf-8?B?YTJrTEhMazV4Slc3MWdVaDdJMStHVWZEeHkwcTY3YkhUNXZiY1JpdE40ZXBZ?=
 =?utf-8?B?MTFSb2tzUklaMkYxa0FVb1g5MVdzUlpXMTFiaXhNOU9icEpvZXZIKzk2K0xW?=
 =?utf-8?B?eWg4TDhjTnJzZzI2TEJ4cTFjOFVYOEozSTlFWkxEeG1sRnZ2Ynh3LzE5YmNQ?=
 =?utf-8?B?RmlpSFFoRHVSb1NtdVd4SWF3eHA3WTBlemw0MkdQZUMyTlY2U2U2UU8wakJH?=
 =?utf-8?B?RGJ1K2kzZzd2TXo4MjA3cWFVQm1HcGRWWGs2Ry9YdE9EcXU4aHRNL1VMMzlJ?=
 =?utf-8?B?aVFWY2VqTzJhSEdoSEkrZUdQSzdEVDkyZTk1QVRROFpGa3d0L01vMkRneDFC?=
 =?utf-8?B?ajd5VlFYQ0tpaFdLSjZBRmxsQkxndW5zOVRKaForTHQ5L3lYUnBsQWhyQmpn?=
 =?utf-8?B?YnQwdm9ZOEZGaW4rVjBUWDAvRkdhZlN3YjhZcEgrcTQ1bGVsMXlpTzJxZGNx?=
 =?utf-8?B?ZXNLTTdSbCtVNXVkbGt6T2U4aDd3bE01dVpaVEpaZTkvUmt4d1E0TTZ3VFEx?=
 =?utf-8?B?cFlnRG5iZm9Sc3RYQ24yUUc0N3ZKTVpUMmVONVhid3pHYmRPaURrQ2x4U2VE?=
 =?utf-8?B?ZTVTRkp2STFrL3BQNG5LeWpYSEVGaUY5TFhETU5UaE1sNWtVcDlkUThNUzFi?=
 =?utf-8?B?M3N2ZSswTVcwT0xxNGhjek9TVFgrL29vM1c0eVR5eXd0US94M1dqTlZJWFRi?=
 =?utf-8?B?dWFoeUkwSXczMlYySXhBKzllRnZaNk5OQmtEbGtEUmtueHgzOHYyU0NSdWc3?=
 =?utf-8?B?NzJBWFpTM056bVZzcEtpZHhZUm81MUN4YnJjUnljZW9XMGY3Y1VSSkR6d0lQ?=
 =?utf-8?B?ZlczelpHN3lWK1E5OGkvSWNMU0xRUU50WW8yWVhrTDlCL2swZWJod09WSm8w?=
 =?utf-8?B?OWo0dytWK1VuTzhSaWtVRjFsc3dPUng1bm5SOWZHc0Eyc0l0Z1hIMU40cnA4?=
 =?utf-8?B?MXNGNmk4RHAyMU1aR1p5LzYvMGNNZXdPY2pMRDl2STRZSXdlbDJlUzFTZ1ZH?=
 =?utf-8?B?Q3I1QkR4RmNFOXEzVWJaZnFxdnhyMFlwS3l3R1h3eGxNUUVPSDNzWHdIei81?=
 =?utf-8?B?S2syK0VsbVlTdUI5eno0NDhXc2xzOGZzcUQ5YnI2b3EybzFaR09XdjY3ZU9Z?=
 =?utf-8?B?WW9vaU1BdkdkK3MrZXlRK2h0MlZtNWVHeEVyU01heTFXdkpiSjhncnlhSC8y?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LrTfg1HnSVlVLT4KpcKOp8V/MbnR5/bzFsFEZDjHjKy1GQ+bFnSKBLdEFeCJG8u5h1Jhb+ImdP8DFK90/9VfUBrYI9Rbfuij72riBNVZLtY/4EVulnD/TavHtNzbpNQmAYDnkcjAjwHjInjTd5CfVGjkd8w/gdy9HPqs8MdxofNvujguZiZoHlGPeQIDjAcPaRCe8ZZZqZ3u1hlE7KDFVLOBAjbVPr8y1i+WZcfVhIQ7l4qgFAeGAIDLLw2LYtT5o6pDMbGaWlqR0TRG/qKndBsH+19+Jk8zVenYuRHhnCd0qoxWN8qaWFAApEnqLjGvD4eQMgWdsixuYA8+2XgZsFWHiJfwIvSVPYwBmZuZeZ+qD0FiGME5YWaAh/f4q9YIn5bXna3Q+iM5mKMt6aCbmHXaXi8m03X2n5p0WKd+q8eGmH3Ufcmgkl1MFq2G8pW2YNoVXi0SF+/v7QLTgaeY5qBpLOHgS5ZYik1IJLtfiwG35NeZSPB3P2Xum5RfWkRsuX/A4tTDn0HBG6b7cPRRwR8cYCMYZuzK0x3e+wrywTR7k2R6eRRu2LvX9wJfejmBe1eEcepH5KpXE/TI5orj7zdMuuoRPTS1QLTdH1IetRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973f3cc2-c214-4066-f47f-08dca807fe7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 15:32:26.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5B8bdtg0BYCRGONOrc/Iv3rSwUMl0G08vhR1/yZ4JJv9ndDUXV3b2awRUJCUqxeqSlKcFGOTQKimDCAmxkfMvCrQEGOeV/AaXtZSdFkR9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190117
X-Proofpoint-GUID: QgYbFcHTMdmO7nlsBX2wLqABv4uk5w2J
X-Proofpoint-ORIG-GUID: QgYbFcHTMdmO7nlsBX2wLqABv4uk5w2J
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

On 19/07/2024 15:24, Joao Martins wrote:
> On 19/07/2024 15:17, Cédric Le Goater wrote:
>> On 7/19/24 14:05, Joao Martins wrote:
>>> By default VFIO migration is set to auto, which will support live
>>> migration if the migration capability is set *and* also dirty page
>>> tracking is supported.
>>>
>>> For testing purposes one can force enable without dirty page tracking
>>> via enable-migration=on, but that option is generally left for testing
>>> purposes.
>>>
>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>> migration and thus enabling migration by default for those too.
>>>
>>> While at it change the error messages to mention IOMMU dirty tracking as
>>> well.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h |  1 +
>>>   hw/vfio/iommufd.c             |  2 +-
>>>   hw/vfio/migration.c           | 11 ++++++-----
>>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 7e530c7869dc..00b9e933449e 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>> VFIOContainerBase *bcontainer,
>>>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>     /* Returns 0 on success, or a negative errno. */
>>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 7dd5d43ce06a..a998e8578552 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>>> *vbasedev)
>>>       iommufd_backend_disconnect(vbasedev->iommufd);
>>>   }
>>>   -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>   {
>>>       return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>   }
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>> Error **errp)
>>>           return !vfio_block_migration(vbasedev, err, errp);
>>>       }
>>>   -    if (!vbasedev->dirty_pages_supported) {
>>> +    if (!vbasedev->dirty_pages_supported &&
>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>
>>
>> Some platforms do not have IOMMUFD support and this call will need
>> some kind of abstract wrapper to reflect dirty tracking support in
>> the IOMMU backend.
>>
> 
> This was actually on purpose because only IOMMUFD presents a view of hardware
> whereas type1 supporting dirty page tracking is not used as means to 'migration
> is supported'.
> 
> The hwpt is nil in type1 and the helper checks that, so it should return false.
> 

Unless of course I misunderstood you.

This check is IOMMUFD specific, because it's one the mirroring hw support and
can be used to unblock live migration. Since initial VFIO live migration support
that type1 dirty tracking wasn't included in the checks that allow live
migration to occur. Another way of saying this is that: with type1 even if
dirty_pages_supported is true, we always add a live migration blocker in case
device doesn't have dirty page tracking. The change above is just meant to use
IOMMUFD dirty tracking which is hardware dependent and not block live migration.

>> Thanks,
>>
>> C.
>>
>>
>>
>>>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>>               error_setg(&err,
>>> -                       "%s: VFIO device doesn't support device dirty tracking",
>>> -                       vbasedev->name);
>>> +                       "%s: VFIO device doesn't support device and "
>>> +                       "IOMMU dirty tracking", vbasedev->name);
>>>               goto add_blocker;
>>>           }
>>>   -        warn_report("%s: VFIO device doesn't support device dirty tracking",
>>> -                    vbasedev->name);
>>> +        warn_report("%s: VFIO device doesn't support device and "
>>> +                    "IOMMU dirty tracking", vbasedev->name);
>>>       }
>>>         ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>>
> 


