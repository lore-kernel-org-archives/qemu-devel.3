Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC7FCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux575-00085b-2J; Fri, 12 Sep 2025 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux56w-0007uJ-Qz
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:50:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux56t-00080z-TG
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:50:50 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tlOU008462;
 Fri, 12 Sep 2025 14:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=IlV/U57R9ntb9NFNCG+1EyTgh223ct4Vvk+Fy+bO968=; b=
 KmTYzLwk5re5sJ/Xk9xjBydrt/aierTr6C8/jfU5ICyUyXX3lzF1admjo24SKSmu
 kylZmeIzKRP4B8Efj2jYhdppORLc+jfQ+sPdVV/GU0b/8H9fken/Owxt360PhrHW
 fuB8shQSyKdno4qyrvpFBYemeR6O9uVPrCiyInGm99h5OH2cxVw6nErgIfTFgT11
 TYheZ4Es+oW3Oc3iSkGvBdaYXRDreaXLTfRXn4SAmqXevpPirNcDomeJQSiAbUaF
 uU5M1tIxuWsH1ouxiH/m4w8eT4GZ1EPDrKSDP+J9f7ijgNTpMDTLuXg7cSAJJ3bx
 lbtSZFnA0G46vgi/fpQ/jA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m30bqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:50:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58CEXWeb030839; Fri, 12 Sep 2025 14:50:43 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 490bddwujb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIV7WGBJ/RioU4FXzjPK/jwOKN8zSed71EwgCAfmDMe7HUOPYHy9TDA/NeHwm2PPV6jNgdbM9bePHR4IJ1yf5rVuEwkENYNvP5Ac7kkp5KkEOSjTaf3ISFNofYsVyXMKrrpJpn3KtYj8TVaHFaoGhieG3OyYywoPadTvVCnOwDhzRdyzEpQNu9ByE7muFu60pYcPRkGH2fHv7fU0pHvUNbcPdQLpbc6qPxUtTHCF2nfAZDDsRLZrxxg25TrH09lZ4bgr0aLCyKnJv4ooQdlZKs1wi/lQNv0X5O6QX0Wuv9UsPiGLB+JYoA3maYEnFFyOi6ROr/arOXGekPyzN3RHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlV/U57R9ntb9NFNCG+1EyTgh223ct4Vvk+Fy+bO968=;
 b=pWvouooygPDL6Y2jFb37p3U5IZzZBff3IoDxcE3HZBITCjcbXn3F+eNfIymO1JuhOPj3DETpZqJl2xq7YfjEMGumjuPADo4vpWXea4YidRCNXU0C+ySJvBiUk2/UIsqv1IzcKuTOdNvZPO5FbUX5hUlZe0Kgjadp/9FYhIfDnNdl/nFY8e6OWRKTTI5wNQW3PzQ4aUEi2cZeT0QuE8F0OeyjnZz+4VzahU919ilDNnfFsREf26rkK851YjZr8UN5ay6FSXOXXcZXUwKtAe8iLAHH1GCH+rDZ/9IEPwoX8FYYuIIpd1uIP/aGei09viRbLFRgLdQEzzdMzY3GQ/M9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlV/U57R9ntb9NFNCG+1EyTgh223ct4Vvk+Fy+bO968=;
 b=b0vNTyCPq4OWUWB/bjoS9g4xF3OeaVqVU5UA1bGJa5Xt+NZ3NqrBHeS4ZJkjFTwIjr4P14HAAFNCdEshhM/NJWTcDa/5dCCO8V5QSzSoDsMSNNAWP8hyPEj2/JpJA93cPj7vaqF4Hkgqwn5D9Z2xEj+Egsd+T/BZ14HYzY7mcWc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:50:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:50:39 +0000
Message-ID: <1a3c46b8-985e-4768-a3d1-e797370c0822@oracle.com>
Date: Fri, 12 Sep 2025 10:50:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local> <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local> <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
 <aMB0BL5SEGfwjTFm@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMB0BL5SEGfwjTFm@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: b0383a8a-8b0e-4b2e-7a96-08ddf20bbd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGF0dERxcXI4anEzTC9YZjMyM0s5dzRtMUxEVmNoaHNPeHZ3eVlhcWc5YXRq?=
 =?utf-8?B?SGpRZTdYUHZSRi9NUWUxQnlBYWZpRmsxbUp3b1FNN2dycnd0aTUzM0QraUxY?=
 =?utf-8?B?eWgxcFVnNEVDMjh2ajZ5TkU0MlZ4UGJheUU4YlZTTTE0enVuR1dzK1BxYlQ3?=
 =?utf-8?B?Z0lpdXo0U1NKS3F5dEZVQ1hpSVlFZUVONTVyVmJ1aW0xSVhoeUFBUitQNndK?=
 =?utf-8?B?UnZST0J3VlFxNnR2YTRjeWpMZGswT3FkUm5SL2N5SFFHdEtNZEZlYklha3c3?=
 =?utf-8?B?eEJmaU5yb1cxTFdpZWlkMTZkc3hEU2JQWERKNEtlenlIVmNxTjNrS0xSSmJq?=
 =?utf-8?B?aDc0TDVIKzA0bEVROEY5SXZ5MkphWTNqYjFLZHBZRWYxZ2NhUkpuT3liZkFx?=
 =?utf-8?B?R3VRYWR0NjRXVUpKZEJoRGRzQkRjK3N4WlZmdVMvb0RTTDFxTGpuNWJ2RC9N?=
 =?utf-8?B?Q05ScnpjTFIzQUorR3ZMUUhSZDdENEsyVko2SFhuOFRIVWxKZHROTzZIWnNI?=
 =?utf-8?B?NzhvZVgzaXNXdjZrb1JiSFozR05UYmZCVlZJeTlaZlpENk50aEhZd3k1cmZS?=
 =?utf-8?B?L0gyTHVlQlNKSHVWdThYNW1vMjJoVmVUbE1la01ucDV6cXFzU3NJT1NXbVZU?=
 =?utf-8?B?VURMNXl1NURpMnExNTYvVURhZi9WQXpNdkdzb3lhc25xK21vMEsyMGltY09z?=
 =?utf-8?B?SkpibUxNRDBkRG1jQ0JZMFNYeVZwVmxoMFYvdlJxNCtxblpIbHdPbFhhMkZF?=
 =?utf-8?B?MFo5K04rcU9rSGZ6Umo1NVRKR05xVTd1aHhBdG12MUhNaWN6YmdZR080YkNp?=
 =?utf-8?B?djZ6WUY1MGtmdS9xTjVadVh6ckdSdm5Wa1kxdldQaWhkREpXSUN0d3FCMHJK?=
 =?utf-8?B?N2tBL2Jhb0Q0b3NxVEcrMjViWC9Ha3o3enRJWGFtOUVXaU5PWWxrZnRrSGVZ?=
 =?utf-8?B?aENQQldDaXN4NGVxYU9vaXFjVDhrdlpmQmNGSXhVQmIyQ2phOUpwL3V2NFdi?=
 =?utf-8?B?NUx3WmRFS3RnUTNQRTRDcXh6K3NmcDk0V1FHWllCMEhiWTQrb3RhbEFqd2VO?=
 =?utf-8?B?N2FPeXM4QTJYRVNURlpLZ1FTK2x5Sy9lczRpZ3FkV1dvRVZETi9VK2Uyclp5?=
 =?utf-8?B?UU1kaGYzNFR6aGNuUFpsZnhwUEJSZVZCcWMvVlNrM0JxdUcwWjZQd2pNMW4x?=
 =?utf-8?B?RWVWZnlZR0JISWZMczBnZ21Ic1FXZDVOQkFzM1V5Vyt0by9OR3BXNldLTlZZ?=
 =?utf-8?B?MzVZb2s2SUcwaUdHOHZqbDU3NlAwTjFKekQya1pYUG04cXVYb1Y1RWFkcFN0?=
 =?utf-8?B?VjBmZzVtblJPNXBINERzT29mRkRXaFg0bElqUHBUb2lGazk5Q1VjZ1lnd1Nk?=
 =?utf-8?B?L0NKYUgyVW9zVGovSkNXY0J4S3UzZW0ydVljM2IvemR0M1ptTFREZnlkbkh4?=
 =?utf-8?B?aXAwT3hQbkRVQjVLOUJGMnJvczI1d1haeTI3UDVhcFNIVjJQZmZ3dXhoYnJ4?=
 =?utf-8?B?dzlIK2o3SVVkOHhVSVVMMWNwL3F2bS9EdFJFd2JRK3N4KzNzbnBzcXlNNnJX?=
 =?utf-8?B?aFZFalBOOXpqODEyenVzbzJJRTAvUFp1bFBQUXZoS1FDb2d5NTlENk1UYysw?=
 =?utf-8?B?Mk1ueHV0alBIL1BodzVPMzJoNnloRkl6YS80VmpuUHBRL1ZWdFQya2JoUnZx?=
 =?utf-8?B?dDJHRXI3dFVBeUVKVHBJNjlMWDYzWVVpQzMwMklsVDIxT01aTDJlUFhydzRI?=
 =?utf-8?B?VGtRMTh2MWRWd0dPNmgwcGhPZk11NmptNXJkSVdMOE5vb0dzbEgya0dWR2tn?=
 =?utf-8?B?NUpzRXZmNTgyd05KVVZMeWRJMys4NTlQcURKTDVRZEc2U20yOVI4eW1KNDJE?=
 =?utf-8?B?YndLUTZMaFhQTEF2YjRqczIxTUU2NTlVMlQ2akE5SnJCSmpoSDhCaTUzbWZz?=
 =?utf-8?Q?Tgdj2EJy9tQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REQwbTNFZE4yWXR2bXR1ZkV0WU9SVDJiNnZIbmFoMjZJdHVjeWVwbit6L1RG?=
 =?utf-8?B?bTZCdFI3cGVEK2Y1Y1dYVnFoR1cxMytUVCtuYzhYNGtBOFJ1cExLT25tTVBo?=
 =?utf-8?B?S0txaVA3bjNYMlhyblJ3WGdCWXdWdXNYNnc4eHZrMllkQzV2bzEvdDk2RmNG?=
 =?utf-8?B?WDFPWHh3cXNWRkUrUTRsMDMxVEVEbUcyOGlFTFNrb3FZK0h0RUcrMitLQm5V?=
 =?utf-8?B?eUZraHlpenc4MlUxbldYdThLUDNIWWRsT2pjdG02d3N5NVIxaUpHcUw3U0Z2?=
 =?utf-8?B?ckJIU3ZINTdqR2x4TmkrZnJCNWdKWEVEMWcrWWZ3OEV0YVVFMnlFTjB0cUFz?=
 =?utf-8?B?eWVtcW9KSVF1N050bmkzUDVOU0p3eldCVCtpYTIxVmRkT09DbGpORktsc2hT?=
 =?utf-8?B?SW55b3N1dkFzR0Jza2tESkNMeTBRSjV0bVg2ZHQ3ZHdNYi9LaDZlUXBaYzl5?=
 =?utf-8?B?QWhacG9DY1l0bHExNTNMdFNvcUlFenU1YVFPRUE2K2tvbWcvMGxYd2lvbUp1?=
 =?utf-8?B?Y3N3YzA0MVhXd1MyejYwOWlYRE1SMW1WdHFUei9Ib09NUE4xZG1TWm80MzB2?=
 =?utf-8?B?bUlaTGlaS0p2dW5aV1pkUFRKcFZwaUxoTUF6TEIrbitpSUhZY1UzaWN5a210?=
 =?utf-8?B?Qm1lU0szQ0FqdEg3ZEFIOXBIaWgxVlJjMWVMZC83SThvZ3FIaXdNakVDMGYx?=
 =?utf-8?B?WXVwNW5GR1dJOHJyMXA1eWMzOWh6aCtxUFFleGdEZDY3WlRGZjE3UXZxVVh0?=
 =?utf-8?B?NXJCV01mVy82SzlpUWxxZE9lU3dNYTkyeE15bG9TeCtjaEFsQ1NmVUU3WlhC?=
 =?utf-8?B?RytIblMwcHdlQmpweE1yL3UwN3lxeWVFT1hleVdoRHFoRTZhVDBNR1FZK1Qx?=
 =?utf-8?B?ZWFiMTE1bzZQcjlaT3BWNklCcEthUGZpUnF4MFhyVEx3Q1BNbk1VWGZFWkZM?=
 =?utf-8?B?L1hveXozZk9IWGtFR1Fnd2U4amF2SUwvbktyQmFqazZ1bW8vbkJYeE5lSnNs?=
 =?utf-8?B?NlFtMzdBalhEeVRSMjJrUnd5TXRPN3d5aTd6djJWampaWVVCMFFaaDRKclNl?=
 =?utf-8?B?U3lacFZHM2F0akVvSTU5dmd6MEVZODhVQXJTTVRMNEZ2RHg5SUVrOGJEbjhr?=
 =?utf-8?B?UXhjNURkelFPcVhGYnJiOUlqTUFhUGsvV0x0OVQzY3Y1TFRMOUV5MDFpbEhX?=
 =?utf-8?B?ZTVvYWtWR2xXWFFwck5HbWxsN3NvZVBMN3lNSzlUWE5uVHRrcUo3RjNpNHpu?=
 =?utf-8?B?NlBlc1lnVk01R0V3bUhKQ2MyYVE2Z3N5Z0FFdzcyU1JTNlR4SEwvMTNTd3Rx?=
 =?utf-8?B?bGxxaXVreGFpQ1B2aTBna3c3dEUzZzNud0xMVzFTWjJ1Ti9GSU4vZGMzdC8v?=
 =?utf-8?B?eis5L3pYSlFRQWdRSG5uZ3U2K21KVWV4U1QzV2NpaDRLZHU4UTVLc1djc0V5?=
 =?utf-8?B?eUVRNEdlQlZQeGNLdXFHRTh2S1AwaWtpcTB1WjdUM2RtNm95NnVmV2N3VlJK?=
 =?utf-8?B?akhENFVPN1RjOEZvYWhLck9PaTZDWnVIWUpKVTdGNm56UEp4REt5WGFmME9o?=
 =?utf-8?B?RXhqUFBoV3cydXhFRWRjTUphcGozdU90WHpEUnNqN1R0Tlk2eUpOZ0lydHht?=
 =?utf-8?B?cGRYeERYNWpZZkdubXd2VGNkYWJYS0tQM1BZNXA2WmNkNWhCbldFU1pDNUhp?=
 =?utf-8?B?UEFTTEIwdU5iQzhkRVpsOCt2Tm5aRDhIL2JFV21PNnF3TGRkU2pHK1M5MEhI?=
 =?utf-8?B?S3o1eHZneTY0YWFMUkdGMzVmbVc4K0p3dFkzU3lIYW8xbXNTRnNVY3BZTk9v?=
 =?utf-8?B?aFJoWkdkeThkOVlVb1JjNmpHZ21CNHJkaElaK3V1UDRRbVIzbnVsK0FDSWlE?=
 =?utf-8?B?VDFZNi8yV1J4c0Q2OFV0b2pHWEFQd01VMjErUlU5TG5PY3FNZWtwaitKaDc2?=
 =?utf-8?B?aXZGTUJ1VHJLbmQ4cjZ3dHFxbVhvSXpRVHhXalBiRnVIaThVQ3dmbG1qdXEy?=
 =?utf-8?B?WU1JOEFXR2tFVVZEMlpKNzB3d29wSHoyeitiQ3lIOHRIWDN1MzdpeUNvV0xt?=
 =?utf-8?B?b2hNeXkwd1hqYTYwUXFMVlFjSVhyUzhtV1pXV3pwS2dENUhkWldodXFMUXFH?=
 =?utf-8?B?OEhFb1hBd1hBMk5jaGJUUm1iclBYUzFIV2x3Rm9wRjRnYUNnQ2hxM0xSSUdS?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ta5uyVuHZ7mwSKBuL/1lStIFy7EHPSJ8KLBZWZDlvdsfYKb19ExyD88lHbjDzPr9Z8fE02IZDBoNQReGFFNcIMBlV0B7T/KKUHiu36XGc/nBoQeEfrWqmisq1iLhH1RflFO0dpb+gICGoDW0cFSi1FGp5O8Ayd+JEn6Ip6/Hb5UL76sKMIl1fDdd4AwKKHG6K932Ie8Mum7Sqqb/IPoQKiiVXq2WX6tQXvQolhpunp+nJmqLSn0wlbZT4M5CUxhKgrzfF12VHHZu2TQTg2NLZxtD2Q5Db91EfC6ls5TNjBramPnOqizvznnXafqBw5pNvoMCFjYg2AzoKgkn/LOMc3FUZ6OnVZsHReYB6QAlN3954bEpltSSeS9X3ojSMwTZq5o57QCuqNXx3c+frEoroa9gn1dEs9uGH+Cbydmz0ZT8pQXxWwTEJSLGO2oHIOy9lfU3iFXAupDjBxiexiAft5gpJ6slJucJ5UmmMXJ9SoAYgv4kZifLWajMvTpXNTVhuqV8iRmAVCSTH2T3vh/8fGTaQ1cAdV/qE4ryPn3FA4RrtFcRiMhErSyPt8VeJj2jIehRuqXuB3nUyz4+NUrLHQGhCvYGk3uG3W/fFtBZ3Yw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0383a8a-8b0e-4b2e-7a96-08ddf20bbd5c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:50:39.4080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkdXONPKr8vJFUOjdZ3XD5B43P8d2cbHOKKiu4e/QcpP6byCKMJ9CJPPnRWFstbrik9zAELnDtcSvhjeE33ThG4XnI+qQj0zUwXMtNWlBDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120137
X-Proofpoint-GUID: fPzVLS8PPfFuBaOdiOYkPB8YpqJEIILi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX9D7dJ7+3uuVy
 lZ5dfLwZ/3C0yxjtg2NkEWxkKkvQN4+QNzpjWsbgK0fw5V+/jDrT5D2E9PGmgURC22zXxe/WXIv
 0k+/FFJ8uzigoKfMJ0HYRdd0UwZjmHUYG6j5qc9uwVwSePBd1CWPt57iuMtofRTUFPM915diyNh
 dLePxMnbQZsj0RrHLmujq4xiku2HegBUROG58alBZZwD+8u5F0VfKVYZvL/pX6Nm9JkU0QgcrkE
 UN2qWI40zD1TmSJfxtyYE4LvloRlVn4AzhYawgONUQkWvvMdQHjyI6wHBjQfGnyKruIgEqn9zju
 +AewRlurFbbw+qADOBOx8Fxzq7iDDcZtgYAqbCkK8lis0x+Cliv+mv4rviMRRDYYMHoSjtK4O49
 IeWrKArX
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c43344 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QaHVeNbi0Ez19B9nJykA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fPzVLS8PPfFuBaOdiOYkPB8YpqJEIILi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/9/2025 2:37 PM, Peter Xu wrote:
> On Tue, Sep 09, 2025 at 12:03:11PM -0400, Steven Sistare wrote:
>> On 9/9/2025 11:24 AM, Peter Xu wrote:
>>> On Tue, Sep 09, 2025 at 10:36:16AM -0400, Steven Sistare wrote:
>>>> On 9/5/2025 12:48 PM, Peter Xu wrote:
>>>>> Add Vladimir and Dan.
>>>>>
>>>>> On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
>>>>>> This patch series adds the live migration cpr-exec mode.
>>>>>>
>>>>>> The new user-visible interfaces are:
>>>>>>      * cpr-exec (MigMode migration parameter)
>>>>>>      * cpr-exec-command (migration parameter)
>>>>>>
>>>>>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>>>>>> primary difference being that old QEMU directly exec's new QEMU.  The user
>>>>>> specifies the command to exec new QEMU in the migration parameter
>>>>>> cpr-exec-command.
>>>>>>
>>>>>> Why?
>>>>>>
>>>>>> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
>>>>>> container and its assigned resources.  By contrast, cpr-transfer mode
>>>>>> requires a new container to be created on the same host as the target of
>>>>>> the CPR operation.  Resources must be reserved for the new container, while
>>>>>> the old container still reserves resources until the operation completes.
>>>>>> Avoiding over commitment requires extra work in the management layer.
>>>>>
>>>>> Can we spell out what are these resources?
>>>>>
>>>>> CPR definitely relies on completely shared memory.  That's already not a
>>>>> concern.
>>>>>
>>>>> CPR resolves resources that are bound to devices like VFIO by passing over
>>>>> FDs, these are not over commited either.
>>>>>
>>>>> Is it accounting QEMU/KVM process overhead?  That would really be trivial,
>>>>> IMHO, but maybe something else?
>>>>
>>>> Accounting is one issue, and it is not trivial.  Another is arranging exclusive
>>>> use of a set of CPUs, the same set for the old and new container, concurrently.
>>>> Another is avoiding namespace conflicts, the kind that make localhost migration
>>>> difficult.
>>>>
>>>>>> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
>>>>>> is that the container may include agents with their own connections to the
>>>>>> outside world, and such connections remain intact if the container is reused.
>>>>>
>>>>> We discussed about this one.  Personally I still cannot understand why this
>>>>> is a concern if the agents can be trivially started as a new instance.  But
>>>>> I admit I may not know the whole picture.  To me, the above point is more
>>>>> persuasive, but I'll need to understand which part that is over-commited
>>>>> that can be a problem.
>>>>
>>>> Agents can be restarted, but that would sever the connection to the outside
>>>> world.  With cpr-transfer or any local migration, you would need agents
>>>> outside of old and new containers that persist.
>>>>
>>>> With cpr-exec, connections can be preserved without requiring the end user
>>>> to reconnect, and can be done trivially, by preserving chardevs.  With that
>>>> support in qemu, the management layer does nothing extra to preserve them.
>>>> chardev support is not part of this series but is part of my vision,
>>>> and makes exec mode even more compelling.
>>>>
>>>> Management layers have a lot of code and complexity to manage live migration,
>>>> resources, and connections.  It requires modification to support cpr-transfer.
>>>> All that can be bypassed with exec mode.  Less complexity, less maintainance,
>>>> and  fewer points of failure.  I know this because I implemented exec mode in
>>>> OCI at Oracle, and we use it in production.
>>>
>>> I wonders how this part works in Vladimir's use case.
>>>
>>>>> After all, cloud hosts should preserve some extra memory anyway to make
>>>>> sure dynamic resources allocations all the time (e.g., when live migration
>>>>> starts, KVM pgtables can drastically increase if huge pages are enabled,
>>>>> for PAGE_SIZE trackings), I assumed the over-commit portion should be less
>>>>> that those.. and when it's also temporary (src QEMU will release all
>>>>> resources after live upgrade) then it looks manageable. >>
>>>>>> How?
>>>>>>
>>>>>> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
>>>>>> and by sending the unique name and value of each descriptor to new QEMU
>>>>>> via CPR state.
>>>>>>
>>>>>> CPR state cannot be sent over the normal migration channel, because devices
>>>>>> and backends are created prior to reading the channel, so this mode sends
>>>>>> CPR state over a second migration channel that is not visible to the user.
>>>>>> New QEMU reads the second channel prior to creating devices or backends.
>>>>>>
>>>>>> The exec itself is trivial.  After writing to the migration channels, the
>>>>>> migration code calls a new main-loop hook to perform the exec.
>>>>>>
>>>>>> Example:
>>>>>>
>>>>>> In this example, we simply restart the same version of QEMU, but in
>>>>>> a real scenario one would use a new QEMU binary path in cpr-exec-command.
>>>>>>
>>>>>>      # qemu-kvm -monitor stdio
>>>>>>      -object memory-backend-memfd,id=ram0,size=1G
>>>>>>      -machine memory-backend=ram0 -machine aux-ram-share=on ...
>>>>>>
>>>>>>      QEMU 10.1.50 monitor - type 'help' for more information
>>>>>>      (qemu) info status
>>>>>>      VM status: running
>>>>>>      (qemu) migrate_set_parameter mode cpr-exec
>>>>>>      (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
>>>>>>      (qemu) migrate -d file:vm.state
>>>>>>      (qemu) QEMU 10.1.50 monitor - type 'help' for more information
>>>>>>      (qemu) info status
>>>>>>      VM status: running
>>>>>>
>>>>>> Steve Sistare (9):
>>>>>>      migration: multi-mode notifier
>>>>>>      migration: add cpr_walk_fd
>>>>>>      oslib: qemu_clear_cloexec
>>>>>>      vl: helper to request exec
>>>>>>      migration: cpr-exec-command parameter
>>>>>>      migration: cpr-exec save and load
>>>>>>      migration: cpr-exec mode
>>>>>>      migration: cpr-exec docs
>>>>>>      vfio: cpr-exec mode
>>>>>
>>>>> The other thing is, as Vladimir is working on (looks like) a cleaner way of
>>>>> passing FDs fully relying on unix sockets, I want to understand better on
>>>>> the relationships of his work and the exec model.
>>>>
>>>> His work is based on my work -- the ability to embed a file descriptor in a
>>>> migration stream with a VMSTATE_FD declaration -- so it is compatible.
>>>>
>>>> The cpr-exec series preserves VMSTATE_FD across exec by remembering the fd
>>>> integer and embedding that in the data stream.  See the changes in vmstate-types.c
>>>> in [PATCH V3 7/9] migration: cpr-exec mode.
>>>>
>>>> Thus cpr-exec will still preserve tap devices via Vladimir's code.
>>>>> I still personally think we should always stick with unix sockets, but I'm
>>>>> open to be convinced on above limitations.  If exec is better than
>>>>> cpr-transfer in any way, the hope is more people can and should adopt it.
>>>>
>>>> Various people and companies have expressed interest in CPR and want to explore
>>>> cpr-exec.  Vladimir was one, he chose transfer instead, and that is fine, but
>>>> give people the option.  And Oracle continues to use cpr-exec mode.
>>>
>>> How does cpr-exec guarantees everything will go smoothly with no failure
>>> after the exec?  Essentially, this is Vladimir's question 1.
>>
>> Live migration can fail if dirty memory copy does not converge.  CPR does not.
> 
> As we're comparing cpr-transfer and cpr-exec, this one doesn't really count, AFAIU.
> 
>> cpr-transfer can fail if it fails to create a new container.  cpr-exec cannot.
>> cpr-transfer can fail to allocate resources.  cpr-exec needs less.
> 
> These two could happen in very occpied hosts indeed, but is it really that
> common an issue when ignoring the whole guest memory section after all?

Conventional wisdom holds that in migration scenarios, we must have the option
to fall back to the source if the target fails.  In all the above, I point out
the reasons behind this wisdom, and that many of those reasons do not apply
for cpr-exec.
>> cpr-exec failure is almost always due to a QEMU bug.  For example, a new feature
>> has been added to new QEMU, and is *not* forced to false in a compatibility entry
>> for the old machine model. We do our best to find and fix those before going into
>> production. In production, the success rate is high. That is one reason I like the
>> mode so much.
> 
> Yes, but this is still a major issue.  The problem is I don't think we have
> good way to provide 100% coverage on the code base covering all kinds of
> migrations.
> 
> After all, we have tons of needed() fields in VMSD, we need to always be
> prepared that the migration stream can change from time to time with
> exactly the same device setup, and some of them may prone to put() failures
> on the other side.
> 
> After all, live migration was designed to be fine with such, so at least VM
> won't crash on src if anything happens.
> 
> Precopy always does that, we're trying to make postcopy do the same, which
> Juraj is working on, so that postcopy can FAIL and rollback to src too if
> device state doesn't apply all fine.
> 
> It's still not uncommon to have guest OS / driver behavior change causing
> some corner case migration failures but only when applying the states.
> 
> That's IMHO a high risk even if low possibility.

No question, bugs are a risk and will occur.

>>> Feel free to
>>> answer there, because there's also question 2 (which we used to cover some
>>> but maybe not as much).
>>
>> Question 2 is about minimizing downtime by starting new QEMU while old QEMU
>> is still running.  That is true, but the savings are small.
> 
> I thought we discussed about this, and it should be known to have at least
> below two major part of things that will increase downtime (either directly
> accounted into downtime, or slow down vcpus later)?
> 
>    - Process pgtable, aka, QEMU's view of guest mem
>    - EPT pgtable, aka, vCPU's view of guest mem
> 
> Populating these should normally take time when VM becomes huge, while
> cpr-transfer can still benefit on pre-populations before switchover.
> 
> IIUC that's a known issue, but please correct me if I remembered it wrong.
> I think it means this issue is more severe with larger VMs, which is a
> trade-off.  It's just that I don't know what else might be relevant.
> 
> Personally I don't think this is a blocker for cpr-exec, but we should IMHO
> record the differences.  It would be best, IMHO, to have a section in
> cpr.rst to discuss this, helping user decide which to choose when both
> benefits from CPR in general.

Will do.

> Meanwhile, just to mention unit test for cpr-exec is still missing.

I will rebase and post it after receiving all comments for V3.
I think we are almost there.
>>> The other thing I don't remember if we discussed, on how cpr-exec manages
>>> device hotplugs. Say, what happens if there are devices hot plugged (via
>>> QMP) then cpr-exec migration happens?One method: start new qemu with the original command-line arguments plus -S, then
>> mgmt re-sends the hot plug commands to the qemu monitor.  Same as for live
>> migration.
>>> Does cpr-exec cmdline needs to convert all QMP hot-plugged devices into
>>> cmdlines and append them?
>> That also works, and is a technique I have used to reduce guest pause time.
>>
>>> How to guarantee src/dst device topology match
>>> exactly the same with the new cmdline?
>>
>> That is up to the mgmt layer, to know how QEMU was originally started, and
>> what has been hot plugged afterwards.  The fast qom-list-get command that
>> I recently added can help here.
> 
> I see.  If you think that is the best way to consume cpr-exec, would you
> add a small section into the doc patch for it as well?

It is not related to cpr-exec.  It is related to hot plug, for any migration
type scenario, so it does not fit in the cpr-exec docs.

- Steve

