Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A001D3B7E1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 12:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSaCe-0000x1-5y; Mon, 08 Dec 2025 07:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vSaCc-0000wt-IQ
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:18:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vSaCa-0004tx-6K
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:18:54 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8App1m2285055; Mon, 8 Dec 2025 12:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=X92ibXHcJVpzRUE1IRixS2wvK+rYdiLbaGXEUpTVA/E=; b=
 sbim4vANWk8Vrn/wJ5Te7NRpjsNdUV0d5lo3CVbbPTPuf8khyPtJsR8S6wZYtGHP
 dzjAsoBZLIezqZwmqO0L7Mda9Vu1nOi+DNJw5+fAuvgLE7kWA+fxlHvpA/zrnW0L
 Yc6wFisUxN7BCVjeWSy5qqeqeVuLPs1sVlUpxp8j9kffMsxCoPj1z1dQcQASrdM+
 KGcDANrPrNPj3Ciecr07DLNGCwM5+5RLCLPAxAQ9GN4ZLn58yYSALgJgYu+q7UE/
 OyGf2WwRVPaUZIa4pyQnDBDAhxpmBzi/FRHHSQ6/Giy8ap9v/+B71dfsYZ2mW8dz
 GtvLuGdWlKYPwVNnwxVsXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aww99g2sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Dec 2025 12:18:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5B8BLTDK038137; Mon, 8 Dec 2025 12:18:45 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4avax7pjh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Dec 2025 12:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKpxlDdMa6mWdIMl5cQ9doSbILU3Fz63wE8844iFXb8ElHmt06we7KMn3pw+/c++DNR7pnnYC1pNJJS6PPgX2n5/z5k5atJh1ekFfDi1cFUEI4yzxDvp8/yKy5c5OOolI5wiL/DdSwXoN9KVI4F68umI/89VYatSXzQg1PNgeG8RbCsh04CxpWjk/zwMnHR44CvTB/CaqwUILXxcqOoDOuSp601S4vHh7sx6f2UJ6JXQscq0AGfeV2jAy+JIgBRW278BdQpLSU9r4sPFU5WYCAiTC2XZI7l6c2BNxp7IGsASGITmCM8zCRSLfPfbVnokKqekBFqK0aFOAg0ZKqC0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X92ibXHcJVpzRUE1IRixS2wvK+rYdiLbaGXEUpTVA/E=;
 b=ps6ZUms4D4+kTBnMLz8N5vXImaXYabu4KpP0B68g330DhlzXWtHN/HApeqxj8G30gXbWn4DCmUmIPw2kxC785r+rXYOEAVDC7rfFdwhJhlJ64QFLxaT/+DiTP4EEXGCK16dVP+qSHwyXFceJHmt1UhBdlspsSESi7cYNpQGcZMje+tvtBBFQ/4vNgfF7bRTF/bkg0hOmqjYxGRi+iwh30Z0ZLIV4xvph4ZWVbmycC37JP/tmXb8EjCV7ptCTePNToIQ49jSXwtfLYS/HJppSVYh4Fj/M1koalOe0aue4V8QeD+dCSnacPWsb65NiwIABLmhk0LNypE5tbOkVCKdrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X92ibXHcJVpzRUE1IRixS2wvK+rYdiLbaGXEUpTVA/E=;
 b=e3svQNJBHtA6PkNn1r05EmDvoALCZ9hXgh/AmL6CSM3Q3bsaNUi9fBV9mn85KRNIQrToE/L9GSyay+zFBOMcJYYAnN2DhtdroNTYxppd4xaaEmRmF2B8GHW9J45AWVdEio/xMxQKhH2vxLp/vJMsS5/etwJ4/5/EkMyCfR49xoc=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:18:42 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::b33b:40ac:22e3:1de]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::b33b:40ac:22e3:1de%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:18:42 +0000
Message-ID: <ea2be9b3-1d79-4f2c-8a64-9ece50a3f343@oracle.com>
Date: Mon, 8 Dec 2025 13:18:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-scsi: Flexible max_target and max_lun params
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Mike Christie <michael.christie@oracle.com>
References: <cover.1763999544.git.karolina.stolarek@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <cover.1763999544.git.karolina.stolarek@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: d1605c72-0c3e-4e7c-04c3-08de3653ecf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elJ0ZldwejMxU3ZUUmhReXRwL09aSFlMWVVjZUI5UmJRdGYxWXNVYWZ4VEha?=
 =?utf-8?B?NW5YdVUzTWRtU1F2L3NBWTAyZTltcC8xVVJIQW1ONmJ2bzlIcGNWWVh4aUtU?=
 =?utf-8?B?WUI0SklYUmNXa0hNKzRQZGtpVHZacDcwN1MxVG5KbVFoeHVVM2lKYWQ3dnBS?=
 =?utf-8?B?Zld4dzljaUM0NHh5Vk5Mek8vTStXTmtRTjEvK0lPcThQL1dpdFVCR3hUMlZR?=
 =?utf-8?B?YVREc1FZRDBKeGVUN3hsbE12NWlVWGJPTWtCaTUvYjFaazdlWFllTFBmRFl6?=
 =?utf-8?B?OEs3ZzVBV2htRWcwQmFQcW8xYSs2MU5YZmtDNjh4VUkxWS90Ry8zc3lzdlFn?=
 =?utf-8?B?ZDVBL24wdWk0TlZiME02UXRsOVNzK3hydjcyQU0rZXdlYUpZSFRPU3JXbmI0?=
 =?utf-8?B?Yis5RjZCY1JzQVBURlBCS1NIRWErZlgyZjV2SmpRUDJsTElEN1hvSWhVNUxq?=
 =?utf-8?B?ZndLZVd6UWJJY0tLSHB4c2xxbzZVT1g0TnZCeExmZC9LUm81aGt5c2RZb0FB?=
 =?utf-8?B?eWxpRm1uZVJUUDIxRDVNUFUxTVdvSHNISWgyYjZkOGlvNlZpWHpGbjVxU1FB?=
 =?utf-8?B?VDh3bWR2NDhZNkZkd3pPbU9Ua21nbmJTYXN5OXd0S2tIaVU0SWxxVEV5OGkx?=
 =?utf-8?B?Z3NWU0pkQ3hFL3RRVm4reVFFcExtamt2aWtKeXA5b2tMYUFiSmtyb3Y5eENz?=
 =?utf-8?B?cEUwUm9CZ3NKd1prVGljS3VYaHdVSExvS21iRVBncDMzK09aaEFMR1JySTRB?=
 =?utf-8?B?STJUSTRRSzkzMVgweCs1MGM5TkVtVzNNeU9ERjdKSEFTeUJSUjNORVYxQ0Fp?=
 =?utf-8?B?bkgyTjVrbmJTcnh5OElaTVZTVWRRaDBjaUJyWHBkN1lEdDJKbzdicTIzQk9j?=
 =?utf-8?B?MkN0MDlsdEFKS2d6cExHdElLTmEwL04yQU1rZFZGbTBpSWVvOFlVUWdadjN1?=
 =?utf-8?B?ckg2N1kvd2hJYy9Wc3I2R01IOSthcU1wMGFza0VzSkpHemFBWXlZb1N2RnQ3?=
 =?utf-8?B?UitVbTI4UFZGQ0syMU9vN1hSekNYT1NoRmhYL1V3NTFiYXV4b0VwNFhuM2Na?=
 =?utf-8?B?Rk9kVXovYklmd0tlZy93dlNsSmZmOFZobkdCMUJDSktKR09PMVo0TXBkYVJm?=
 =?utf-8?B?dUNZbGxJMVloTDdxWHVVcnc1dlpnSi83UG9zZGtNc1RzeFBicmE4M0JnQTln?=
 =?utf-8?B?Q29JZW5BMXZvNS9TVEpMRTJKYTJrSXF3dGw2cVFTRGcwRTJreUc1TEtiaW1B?=
 =?utf-8?B?a0Z1NnhrdXdKVktIdEkva0ZJa0VvRDhkNWFnL0F1NmxtRWhEYTlucnNlZ0wx?=
 =?utf-8?B?angzZnR2czRpM0c3b0p2RXFSWWJIcWlLdkxvdkRqRWU1RUNvbndydFllMTdq?=
 =?utf-8?B?M0tDUHdablJ6RkE1amdBTUpRZGswYnR3Q0pHcm9EWnpuSG4xaGsyZWNUdjMy?=
 =?utf-8?B?NXVMTElIZ01JaXZoUWh2Mm9qTUxwYml6cjZITFVnUGJrQW5sVzRabFlqZlVr?=
 =?utf-8?B?bEtOTE45VVVzWlZXOGtKUCs0Z0RyOWwvUzczMTRrYVJXdGJlWEJUV053bmxM?=
 =?utf-8?B?SWtlb1lWTkttakwwUFlpV2krZGxndFVsNCtYUVlPMXhRMDB5S3kvdklRcDZJ?=
 =?utf-8?B?VHB4T1R2N3dNWnVEUGp6UHVoelNEbE0xR2hGcnA4ZEkwWGxqVFI5SFphenN1?=
 =?utf-8?B?eUtGVTN3UFN0V21BbXNTZkV2TXp0TlRxNVo5NGtVbFdHRS9PMGI0MmxKZGVO?=
 =?utf-8?B?YWRKZHpUM0Z3UHd1VVByL2FvdUZlWHNFbXpsZkZReGVvU1MvUWcvMkV5SFJr?=
 =?utf-8?B?ZCtEV2tXVmdIZVdaamg4cnpndTdjdm5PajRmNFQvS3JCZVRNVjRvcHpOTlgx?=
 =?utf-8?B?YVVJMXorM3I5aEVvclZRS3k4cjR5MFA3SFhUWnoxMUJDZjNEVUFVTGdYZnNw?=
 =?utf-8?B?V0svcy90K1AxYXJtL1EvT3RNbXAxL1hIaE9tb1dTd0h1b0ZkZ2p5WGJtZFBx?=
 =?utf-8?B?QVhkY0EwOHBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR10MB5396.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2pyczRYSE9wQ2FTdHA4M3Z5QTlMYzFyM0pHYXJYdGtETVQ5ZjVPejFDRDFn?=
 =?utf-8?B?SnhFQmVDb2lxWEhSbnhXZldZTWdnSFJyeGxJRFcrOG1BVHZpNE53cSs1Y3Ny?=
 =?utf-8?B?ZXBjMUphZ0E1Ylh1eU1WN2RObk80NjdycGZvN1FYSVc5YlpmRlFxeE1xTGZS?=
 =?utf-8?B?RmQwSEFyUDg4dW5HSElpQnVwQkpNNk1WVHg2cEUzL1dWeDN5RC9xSHZiUm9R?=
 =?utf-8?B?a0RWNkVKZFE3Z0ptaDdWTmFRS2pac2pTdTJEMmc2emUyc2hWQ2NzK1QreUcx?=
 =?utf-8?B?UHVnTlFXK2hmZGxiM2FlS3Rham5vRDloWU9rQU1uSFF6RFowWTlGSHJHaGtF?=
 =?utf-8?B?MUY5WkFNOTV0S3RqSlJVR3hHNzU0K1FncnlPaitGc3VQQ1RzWFgyWjVOczEy?=
 =?utf-8?B?MHJvOTRBT2VZaFh0dWpiTzNjdHFWMDZJb3N5UjlRRnhTTEFBTVFqY2hoMi9y?=
 =?utf-8?B?akRTbkpwaUJFZEVmbHZ3d1hjOE5ONGpxVG9WK3FPdUMweGR3dWh1UzZMQkov?=
 =?utf-8?B?U0t1TEtOME1GT3JzaTBOSHVzK1BzSkRzRWl3aHRzS01mUGVYVGVacnlDWW9i?=
 =?utf-8?B?R3A3b1lFYTUzTDU4a2FHSkRYVG14YkFyOEtnQVVMcjFSUGNrVVh1QlZPYXRZ?=
 =?utf-8?B?TW5CZVIwZGFHL0htNEVWbGJ2MDFyemRWTUVQb0N1OFhpLytVRFpYblJtb0c5?=
 =?utf-8?B?VE4xNzdZOU5rR3ZKTWNzWlFBNEQ4dHJWU2hzQ2d0c2xTZkxpUkJabUtxQ2Rk?=
 =?utf-8?B?ZTZTNGQ3bGxuYWlBUEcreW05ajBTK2IyMXBFcDYxeCtMWlI1M2IveGhnak0v?=
 =?utf-8?B?bks5ZktiZGFLbVFiWGFpWkNxdTlrWDlGNlhkNVVqemVJUThvdUZFcEtMQzZW?=
 =?utf-8?B?MlV0VTVLb3hlZU9xS2lEaFkwRllGMDFuRzZKZGE3dFFqbDdUd0lrS1ppQjZn?=
 =?utf-8?B?VWwyUjd6R3N3dFhtajZnL3lDOGdUMllKakpybTM4aUY2K1QrQWVDdGM4N1lV?=
 =?utf-8?B?M0hXaDJlbWQvK3FBakFEbENEQjRmU1hDTkpWUzlVTm1MOUQwYy8zeFkzMksx?=
 =?utf-8?B?c1FDLzZwZzZNTldVNUszS3lFNS9XczlXdXRRdndEQWZGT2s4azljOEs2NW93?=
 =?utf-8?B?WnlIQkRUR2JXRmx5WkZ2Q3hYcnNQTmZZSWc4RGd4bWVydXBNZ3dpa0VVL1gw?=
 =?utf-8?B?aG9qQkw1KzZIMEwzb2tic3RGS2hkM21nM0lsa3FWb3JKaVBndkNQbXcxelg4?=
 =?utf-8?B?c1o2WWRSMmxBS0xKaDJUYnB2VlB5cTJwUUs1VDJwL1BOb21mRXFQRUNNWk1l?=
 =?utf-8?B?UGp4Wmk1b2w3WTJwTElWY0EvTnZ4K1pIL0lhQ1ZRVU5LbS8rUFczTVl3dFIy?=
 =?utf-8?B?dE5wdWZDQ29LZUlGd0JCOFhUQlRIZ1EvYjI2SU5vdkJRZ1NoN1BwYytMdE55?=
 =?utf-8?B?bEVCYityZ2tlNUpGRlk5NnpwOVROOUFySUJCbTZRRUVVaGJwNHZGN2taMWVU?=
 =?utf-8?B?ZkFkakd2VGRLazBhUWwrd3FCUUt6d3RQQ1FwalZlS1ZlMmdlejdMa21vTXcy?=
 =?utf-8?B?d0pEazhYWnVlL0hSa2h5R1lobDkxaGVIUFMwRGR3UlpYRHoycWRDcVhQV2Ur?=
 =?utf-8?B?dDVpYnMyeDZIK0YyVHhSbGl2aWY4RWR3QVI4R0NJVWVUQVI1Wm9mNzZXditF?=
 =?utf-8?B?TUNXbUtHRS9pa0VrK2VqZVZLSXFUWWk2N01DMUFFVC82L1ZVbkJKOVl1RDJL?=
 =?utf-8?B?OFRPTzB4NUdSMG14SW9ZbVVySTQrck95VTBHNDFkY0ZFS0s0dFp0WVF3ZW8v?=
 =?utf-8?B?ZmlJUmZvajBQSy8yME05UGFuVytpR3hEQUN4ZzNOL0JnK2NwaWtMa3kyYXd6?=
 =?utf-8?B?RHdVckhZUGc0K1R2YzFKN2U5ZXNVeE5BQ3RtcVExKzJrUDRGRHVhU2NTU2J5?=
 =?utf-8?B?amd0OG0zY1RJalRiUDJpblp4SEpNSHMvWmdWakRKdTNYay9YQStZUSs4Mkwy?=
 =?utf-8?B?eXpjWTNhbTRPRVNSanBvUEhSTFZRM0MvTGpIMm9qdnFJc1RzdU9nRHBuR2Ju?=
 =?utf-8?B?ZzNkKzkxMk5qeDc4ZEdoQlpwaTZtNGYvK1V6RGJ0NWpCRFhDTkNmNG1zWUdB?=
 =?utf-8?B?RVNEc05uUDcwVHlpbWdpWTRxNGJuc0Q1Mjh6N21pUFVHTVBJNzVyNkw2QUpn?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FmZds6WMPaiTbqPTx+NqES56Z5t5ifmwGVoZN4kXoPwLf86syUmG56xhdBjKVqX5QLrvdBheX6RNpLMl4FJqRRFlrnhQO0RO2kgbhvYh82dgCFUNoXuPkOqkZ9rMQguXBDFtvZQu4BWAH0MJWxDIBVYKnM/YXeR6KvTm/9cYhXC2OXex9/j8Yxq9wbIBODQfnGPC/k4NVGyXWa6Jxc/+SPhdOohnfCjpXjwOHwj+R0Q1JywHZjBXConoq9iGvRJXz/Pl4oIKnhgXPKC1evHxOi6QB15jk81QV8oWw8wI9mDXWlZ2nlb/Epge8AoigGWeym+QVTT/tA2Pxokd1BXMPnr73dnMO9bH9rN+OPWd4jPNEsOtn+Uej3ZDNCWHssjQ8OnRczp3ac+hKWIVlhwo9HbQDht8CIWySYLfpLlXmxFObSBpQ/sATYizHmEe9toknSmNdWK25PkFJqH7Kf3OR8ToeuUT6QPhD0LR8qiTz1+MP9+KJXgdYfBeukMhiarMmmsMQqUOfasd1E+D6jW6cA+t3tBYZg0oe6fwI15pStyPcmNajZcrJkMjx3BHBWuf7gSo13PmINfj3rdpKf8PQJIE8XmvzlySiuBm0AOkU5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1605c72-0c3e-4e7c-04c3-08de3653ecf2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:18:42.2853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un3lRpUVIplpDSiINaSiPnhI+PVe73dLgg+Pd7PWPHG/s/cTiorbjV5Te+UfFESjeZNPr2GjXdQFqIU9j3Mv38DipAmCVySmPPmbKQynkds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512080104
X-Proofpoint-ORIG-GUID: BsQVgydvuCIKdtr__I9-7f34fGwqjrkv
X-Authority-Analysis: v=2.4 cv=dsLWylg4 c=1 sm=1 tr=0 ts=6936c226 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yXdbMK-Kjw1NLgw69ZAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BsQVgydvuCIKdtr__I9-7f34fGwqjrkv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEwNCBTYWx0ZWRfX5L1eoNgiuapW
 sQFaC0ihfhrJTVWuXFfq79aFrCW4MK4krJQAtIQNGpL3LKfDVrxm5+DhDBcJ684L2EA0/fE7n+p
 p3RwuoMDv87aRe21B+ASh1P3/G8QDNgcI+lmouBoyz2qkpamUwx1WNLObmmvIdDRhVB9zwhiNbf
 usu3AOwocrKfWBjLw2LXWXwToImq7YVQW/VG3CUCLnakVuH4BhrO0iPqEVMKu+uSJJ5fIgwJHS+
 OOTxyzcWfmWfqygk8QM8/F61mc1oDEqljxzqHh1D7TSvcJFyCD8lZhswm2IwB9t42AZQb6+zdY4
 0/v87li0BtlIKJM+NA5SAf1XRokrwtW/ouLDpU5/dDzL49hnaH1NPhj6FHic/T/Ucjv3ETFfVZP
 coZVvLnaSKKOwGBkmJJgL3DbBUTxPg==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi,

On 25/11/2025 12:01, Karolina Stolarek wrote:
> Currently, the maximum number of targets is set and dictated
> by virtio-scsi. On probe, the driver walks through all possible
> targets to discover which of them are available. In the process,
> it sends INQUIRY commands to request device information, also
> querying devices that don't exist. This can be observed in
> a guest with a single scsi-hd device and verbose SCSI logging
> enabled:

A gentle ping on this one.

All the best,
Karolina

> 
> scsi 0:0:0:0: scsi scan: REPORT LUN scan
> scsi 0:0:0:0: scsi scan: device exists on 0:0:0:0
> scsi 0:0:1:0: scsi scan: INQUIRY pass 1 length 36
> scsi 0:0:1:0: scsi scan: INQUIRY failed with code 0x40000
> (...)
> scsi 0:0:255:0: scsi scan: INQUIRY pass 1 length 36
> scsi 0:0:255:0: scsi scan: INQUIRY failed with code 0x40000
> 
> In the vhost-scsi backend, without the kernel patch [1], the issue
> is far more noticeable. Each command queued up for a non-existing
> target triggers vq_error(), registered by
> vhost_virtqueue_error_notifier(), resulting in a flood of
> "vhost vring error in virtqueue X" messages when booting up a VM.
> Even with the [1] patch in place, we are still sending commands
> to phantom targets with no way of limiting the scan. The first
> patch in the series addresses this issue by introducing "max_target"
> property for virtio-scsi and vhost-scsi devices. A user gets
> an option to specify how many targets are used by the guest,
> and to stop scanning before hitting VIRTIO_SCSI_MAX_TARGET.
> 
> A similar issue can be seen with Logical Units in the existing
> devices. By default, the SCSI Host Adapter instance expects
> 8 LUNs, and some drivers assume this to be the actual number
> of exposed LUNs. This results in executing SCSI commands that
> refer to non-existing Logical Units. This can be easily observed
> when using vhost-scsi backend, as such messages appear in
> the host's dmesg when booting up a guest:
> 
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000001 from
> naa.5001405277e02c68
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000002 from
> naa.5001405277e02c68
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000003 from
> naa.5001405277e02c68
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000004 from
> naa.5001405277e02c68
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000005 from
> naa.5001405277e02c68
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000006 from
> naa.5001405277e02c68
> TARGET_CORE[vhost]: Detected NON_EXISTENT_LUN Access for 0x00000007 from
> naa.5001405277e02c68
> 
> The second patch provides a way to say how many LUNs are actually
> there by setting "max_lun" property in virtio-scsi and vhost-scsi
> devices. If neither property is defined, max_target and max_lun are
> set to the default values, making these definitions optional.
> 
> ----------------------------
> [1] -
> https://lore.kernel.org/virtualization/20250607171815.111030-1-michael.christie@oracle.com/T/#u
> 
> Karolina Stolarek (2):
>    virtio-scsi: Make max_target value configurable
>    virtio-scsi: Make max_lun value configurable
> 
>   hw/scsi/vhost-scsi.c            |  4 +++
>   hw/scsi/virtio-scsi.c           | 46 +++++++++++++++++++--------------
>   include/hw/virtio/virtio-scsi.h |  2 ++
>   3 files changed, 33 insertions(+), 19 deletions(-)
> 


