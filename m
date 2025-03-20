Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FF6C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJCS-0005uy-2C; Thu, 20 Mar 2025 12:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tvJCO-0005rA-A3
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:56:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tvJCI-0007FM-SV
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:56:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGj2pV031588;
 Thu, 20 Mar 2025 16:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=k/BGtD6+onqqN4KoRRafFKsHfWcH4sN7iBlX3RS8SK8=; b=
 fC42vUCuD/f5VGUDKOylx3RgAPqwsV7r1bKfPph6qlsqBrzLPBj3TBCIIme8U9Jj
 GaB6t4Jf4kXQGsyV3sAQO9rD74MaVqYH/rBV2nGHna19Mmwg5xXn3p5U7yOdlylL
 xQICD6g4Zn5EwVIm60+564rDezn5D1mbkqvSeCQTg9dS97Wx/wUWlOcTWWj1PzFi
 HnAF5pz77wPc7wfiLhhi4ydK7dWTdaW6sEcGeUSjEyj0ly4Ji1jAn5vebt0We0uJ
 akrasYo+bRBXmVyeBZaJP751d7UlYy93F/qQUaKQMipuSsWnTMFccXpeAzLFHbo9
 SDV5DBr0CuBLOYm5vo58kg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg6s2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 16:56:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52KFSg8d009582; Thu, 20 Mar 2025 16:56:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxm2ycfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 16:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiHrKHpNlVI6SgBmd7dLkBLRP+yi/xWcoY2ba1HuCUZjr5Yd7gTpvFO1Ls0maZqeUUhUVLkKtsurD3bSbYrQaR+FGGgFISsdI2dZptf9FpxVKZQqUfQO6HFFRrl+kXt2IWd1QirN+NxTWeya+0NdpUmiVbIUauQyIgIGrfR7HJMbK4FfdhIFmTgcFJdhbBEQucSpB1dFCGcTPuQr6C6U1mPO/Nvda9hjV+3hTjBh0aa5UNMeygZuEZj2UE+TyfmVmzGb9dvUKafwR+Ce38DZyBfFbCnHNdH5Dv/+OZdeUF/mUQcmJtw0gH7lmglAWxgFnoUaoTrHKnKKxVPcgOjpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/BGtD6+onqqN4KoRRafFKsHfWcH4sN7iBlX3RS8SK8=;
 b=NBfC3vXIJTyTEaysF2cDunKV8glDIyzSSW/Suky3+my/LBIC4EAybslIU37Mcob21lon559OHcX4Vr3418bDcgqv88uNJbNODV0lQ7wZgP+T8coMFt58LRjERtzrs0WLFFou+CURBzmLCuw3wGVopbSKdTp0AL1OATLp0zcclJ4NID5MjOoSNHfP44dPb/OPC/pym1ZlCMtIJSclCQYtjRMerHxtLg8/7Jnem1OlxIqU5fFNA3Xr5Tp16IevMEJ6GeX7b9F7YlvwfpGlMxNhikcd2QT8hiXfHHA1p2nXyfZl63QZlQRFjP9OrCLIjgCareEbSPm3FDrGvnot31RTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/BGtD6+onqqN4KoRRafFKsHfWcH4sN7iBlX3RS8SK8=;
 b=LXk3ucU6FB5Hjbxa+H+jqP3/VjqXfWMItsM6JS1NIA7plSTdO7/Z6DZjdwww4mWVLl/1jlry5orkPpzLWykhqdKKLSQ1YI5MOWQHHpHOVz4vrAumgpSH5vNKl1zYDz4esuFmQUDI3oJnrrKvDcEn/tfy9lf74elWfv5qKQXC2nM=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Thu, 20 Mar 2025 16:56:36 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:56:36 +0000
Message-ID: <c372079e-4d20-4196-be2b-6a7ea9b23622@oracle.com>
Date: Thu, 20 Mar 2025 12:56:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] amd_iommu: Do not assume passthrough translation for
 devices with DTE[TV]=0
To: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
 <48b257fe-f3e6-4882-a7ee-9a790b1eab3e@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <48b257fe-f3e6-4882-a7ee-9a790b1eab3e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0772.namprd03.prod.outlook.com
 (2603:10b6:408:13a::27) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9c6cca-a8d3-44d8-295b-08dd67d02cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkJ4ZmxEY1hsZFp5NWZWdkRrNUoxbW9QRUg2cm5OUlZ2eG15NmIxamRvWXMv?=
 =?utf-8?B?dlFEWnZpUjAyNTZ2VjNQdmJIeU1CTFJpVStjMDdOaHF3WlRIME1ETGZOT2lL?=
 =?utf-8?B?UjFlb2dHckVnMk00VjBTZDcvbWFDYXE3ak5xTkl2RERmSDMyaDErckJCTGlH?=
 =?utf-8?B?bGxGenNxM1JadXdRVWtzSUFHVzMzYndUa1BhV0dRZ0JITEd1R1V2TFJuVjhM?=
 =?utf-8?B?NUx0Mm1TYytIY3JyUnJmdTBnS3AvbzJwaHc0aGlHSnRzWFBCTXJ4aEQ1WWds?=
 =?utf-8?B?SkF5alU1THY1amU0QTlwSTNEb21FMm80Q3lBNlpVb2tOOVBoTk9HSC9nN1Q3?=
 =?utf-8?B?RzBsWUZMYTlIOVY1VXY1QjJlZ3RhYmtRNkdmMVVMYnFPdXlVdDdsc0I0Snp0?=
 =?utf-8?B?OVhCRjhxclplVHdwWHg0NkQwMlFuL09reWxwaEc5WlBYU3c4a3lYWkpwK2Nj?=
 =?utf-8?B?dk41THhMTVhjRXNqVDRGZnZyVTQwS084QWxzUHZmSXgxL1J6eS94RW9YMDVz?=
 =?utf-8?B?b0dZbDY2WTdkZTBvM2xXMjZaS3ZSNTk3eDNkNWRncHRHdE4zRXBjc25oUGhN?=
 =?utf-8?B?UytZRytmUUQ5eitBTnhGajJpdjFDRGErYXROdk1YM2h6WXltUkdYdkJvYTlZ?=
 =?utf-8?B?eTJXVkFtTVZrTENVYVFGOXE5Ym12UmdXL0NRWEJXdFdmRjRHOG9ZdWU3dUdt?=
 =?utf-8?B?bXRRSnFUSDByZ0VncnBsTnE0Zm00VFF1c1oxV3RXMVNwbHltWktscVZHNGZN?=
 =?utf-8?B?THE2M2p5OU9uZkZvN0RocFZvei9pTSsvczM2ampMOTNSdDFjdHlzVDZSdjdp?=
 =?utf-8?B?djdIRWV2K2ZQVFdNeldYTWpPRnI1ZDQ2VXdGVndUcVpUS2tEeUtDY1Nub0xB?=
 =?utf-8?B?WG1wZXNtb0tUdXg0ZVRDV1FEMG9odUpLa00yYkRsQXVmSjdZeU5MQzZVNmRG?=
 =?utf-8?B?TTVBZUgxc3JKTnZrNEYyTUF6MkVwTDZ0M3JuQjAyNlhxckVPZ3JoRUNhUmlP?=
 =?utf-8?B?MWIvaU8zbytXNVhxVzdtYWsvSzJDTWdOeVJhMGJ1ZVBXQUtsbzRuSEx3RkdK?=
 =?utf-8?B?QUhRbVhNQXZ4c213cWJtY3ZhNW1wVDE3ZVdMb2MrTTkrdFIwZnM0Q1pvVnA3?=
 =?utf-8?B?dzdpSXBMejIzNVgrM1ZUUWZVWVJkTzl0TGptZTVCZmRhTCs4Z2xyWE5ldWVF?=
 =?utf-8?B?dGhaRDlZVUNjazBud3FIOUNPczk1b2ZScU5ObmprdlJCdG5YamRxdHF5THg2?=
 =?utf-8?B?WGFmT1B3UmNpbm1OS0NTOFdLT1Z6OXlpRXJNcHMwMUZTanJDVXRuTks0VFNk?=
 =?utf-8?B?RDhJMFhJTXdSWFJzaElTekkyd2tQZjVQOE83ek5DVlJLVk5SWnd3UytvczNR?=
 =?utf-8?B?WmhQOERFWmxQbjdSNjZlR1I1VzNYc1p1NWYzYVFwZTdXUlpvb0FkY0x1bG9R?=
 =?utf-8?B?aG9CM0Y0cTNpUVl4N01BdmJVNkJYdzcxVkh4WUxFUHJoMitvTWhQd2dQV3VZ?=
 =?utf-8?B?SzZGdjRFNTYwK3F4aDZJR1hwMHd2N2pxd3V5clhOUlVIZENKWW1hTkZSU0gr?=
 =?utf-8?B?RXFHakZUaE1NUFFINWhpVXVIZTN0WldZc0dUZlROT0lRMnFnZWxSL0h2Slhi?=
 =?utf-8?B?Y0dzQXF3ZjJ4TU1JOVhyNTA5aGhnMEVRMVZUdkx1WFhnbjRhUUdCd1BhTE9X?=
 =?utf-8?B?U0tYSlNSUzloK0VIUUE5QTI0L0M3aC9LSEU0ZTM5Wm9zalhDYXQyVHFteU1y?=
 =?utf-8?B?YjNxWDltVDI1dnRJeFRIZ3p4VTB3QmZOR3oxMGFhMTZVRXZwcnJOU2dNQm9i?=
 =?utf-8?B?NUxMTzdvM0hEbWpoR3ZGcit4RzlMMDhhN3hNem9NUkN5WVNzNzYyMDE2SUpH?=
 =?utf-8?Q?P2Bak/HkxhHrA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdQcXBjRk4vUTM1SHdQeGtMVzRKekdFY09tMWhNRTNTb0RxV0MxU0FCdStr?=
 =?utf-8?B?VVMvSjhYb0Z6VXBGeHZxTFc5bmVCM1BKdWpibmczdE9ud0F4bGxCaE9sTHhZ?=
 =?utf-8?B?cHU2WmRBb2E4eEhnbjNBNUtZSTQrVDJzQzNsc3ZNZXZyTjA5YnpodUhydzcr?=
 =?utf-8?B?MngxUGRiMzVGVFFUbzhCYVN1MitoSVhQVktRT0ZabEx2VUgza2o0RUJ3UlMv?=
 =?utf-8?B?VFYwbERJSEs3YjNjSC85RGQ4bElzNklVMFV6U3lZWGhYbkJzKzZXWC8vWEh4?=
 =?utf-8?B?eWE4b2RyS1JkcS9qRUM5aXUzV216VUdUbU9OMXI0ZUN0eHQzZnFCS2h3dkhU?=
 =?utf-8?B?dUtLVFQyREdyM3p5YkJvRDNaN1h5OTk3VSsvUGp0cEF6Z0EzY0RiN2ZzbWQ4?=
 =?utf-8?B?WG5DRTZyM3BmMXhZVWJjQVI4akwrVlNHZEs2cVFmbjFzZFRPY3c4UkpQTGRT?=
 =?utf-8?B?SCtzSDlpWUUvT1pmdExESWc0WTRIUHFuVVZTaHBPVFhXMzMzMXlpOWNwSWdO?=
 =?utf-8?B?UnltTHBYNktYbDdkWnFXanBXbTd2VVg0WjM1MTNVYkZPcW9sWkNlL3lQM0ZJ?=
 =?utf-8?B?NFMybnpJZC8vQXQrQmpscWs3S2gxMEFBWm1MelBnRWoyRUpWNFU5aThmNUNh?=
 =?utf-8?B?eFRja2tteU11M1htTTBXUS9WaCtBUHZORkYwTXVSdFpRZkI3cU1aOGNYUFJ3?=
 =?utf-8?B?TkxoYjJhY3h0ZHgvL2pqdUYyeHJpN2p4b2xCT2JtTlVqNmxYY2lNUE0vZlJz?=
 =?utf-8?B?c2xXZ25WSWdDbjVyRXE1MFF1b252ZHZDU293TlZ4bzlsL0VlU3UxTnJDQjRO?=
 =?utf-8?B?RzQ2ZUgvQUV0TXNpMGpBTFZSV0pSNkE2L0VSNEttMDJVWm9aby9lZWpWSEk1?=
 =?utf-8?B?V0dmT3F6WkJkZzNNRGpVWUFFMDE2WFZnU2l2MFlQMWlnZUN1a0orNVRHR3hw?=
 =?utf-8?B?amZ5YVR5eVpXejdRZEs3ZmJxMzdmUHJGNzZlT2RTOWZMNVFweCtKWFo0aXRz?=
 =?utf-8?B?WWw0NzZvaXk3czVYTmc2N1pRdHJ0UmxjSTJmTUJUalFWZUtpZTNSNW9rT0FR?=
 =?utf-8?B?b0xhc3UxT0RScEd2K1g0R1dJdHRKUFRaWGkyb3RaRXBEaU5rN3JGaXFhb2o4?=
 =?utf-8?B?TmZMMXdnWXNpbTFRdmNmVWZLSTBSZHVNSzkzTzZCNjlwYzBReVFybmVHaHBa?=
 =?utf-8?B?UXBNenZ4cm44bmo0ek84RHpndXBXRnRrR21sK28vTEVJTisxN1B6QU9RZmZC?=
 =?utf-8?B?NjU2dmpwaWppWWx1YUtWRnhlcENYNzBCQ2ZGd0xtbk9EWHF2cVJjUGtUWStD?=
 =?utf-8?B?NVlubEpON3ZRMFZheW1iKzRNSUVTZWhkSDFDa2djWnBqQ1dYSnh3N1dSN3Fq?=
 =?utf-8?B?MllVVjhDWm5RSGdQeUZRRkF0OEhFdWpsTEZ6bXRzeUNrWlNMWmhYVzFULzQ2?=
 =?utf-8?B?MHg4WmRqT1VjV1NpTDI3bzcrWlBpb0R5VEhHUWVJZ3I5aU5FQVhYalc5Wjl2?=
 =?utf-8?B?MXJWUlplVGFMYnFtbjFsSFFVSnhpVDJELzllUHcrS0FtdTB1azdpMnRpV1pI?=
 =?utf-8?B?WmtFTzYwWVRoNmU5L0F3VkhnZy9TSTN1MWFnTWpXVXFqeS9oN3pGVDQ4ekFB?=
 =?utf-8?B?cHNveDlCcEFsUGR6VHpRakxxSmJxZ3NLNS9VQ0Vqd2RUazgvQjBVSjhURkZO?=
 =?utf-8?B?dmNmNUx6akREWUtOZlFBTURLcGlQdm40UEZVYVdHZHkwNE96dEZOb0pGVm02?=
 =?utf-8?B?cUwxQ2RjWnp2amY4RUZrS3ZPcDV4em1iUXdMdnpBQ1lVMmd4RWRKamh6SW9t?=
 =?utf-8?B?MUx6YzRFY1FCcGNTUjhlQTFEdE81Z1NpRFlJWk1sVU8yZGJET1RSVXJMcS9B?=
 =?utf-8?B?UU82cjdpTFg4Yk9CTUE2R2Y4NE5KRnJCam52RU9uZUZyQmgycWI4QTNuSy9F?=
 =?utf-8?B?VXoxUU4yeDJoT2ZTRy9XMnZwbmVvR0RHcldLbVZYVnZEaklYV3J4Z3pTQm4x?=
 =?utf-8?B?MGhJZUJuRFhKU1BDZkFKemtsUWtVeUh3eXl2NXMzU0VOOWRtRHJGQW93THVH?=
 =?utf-8?B?T0VGMXNOTytKY1R6Y1FXZ2tLNzhiSnFlV0ZrSTRmRDBRSnRjbjIwemFmdU42?=
 =?utf-8?B?VXRXSC9kdk8rWjNDbEZmTEZ3dXU0NWVMVE44NnJiYmkxS1NuNHF6b2ttL2dO?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5f8tV3t3zqdEIxaYoPpfXT9lhq3I9WJVJ7fn+1JKX7buf5zujMu04doOdeVLVCWRTe7lcO16cu3/L6MgMDedLH7oHl5pZ/pjUbBCFIebTgJcEwufFqE5W8LDM4a+Y5h7SfKPD+X1sO//hN1hBiHWBYUuEnmUa5zCAKT8Va/noqpCJc9Dkg2MZgi/aElWIkxIFOB1GfpAgJyC+8ghE0ggEMfhdmqA5yh/QW4IikiAxETSGjOD0d7KjGAY8aq+MgD0eXSF5I2Bfp2Y048KPlpE76Cvy7f99nujYIYQcSQccqvisWO3ZcZVV+a6PCIrf0V1HF+y+nlV/4vu7j63DtjK2dMP9b1tl7F4XAN14vVq7W4w4jxSRJFee/iDk2uKnHxNJgC5rvGqCBnfr7/nBgcyyZ1UOS6sT0OOPGoT9arj/hcDrfEIGFlgPWDhNOTGPBonJdEvwu/dMnJ3kYURChIwR+LaxxbE7MXWOz7l9ZydVy44KnXl/ZUTu6d1w6jg3HsugVPD6HrzDLY+rXN1pq96EMt2mlDsUQ6FdEsEUTl1r9S8ClcO1zSwJxlyJrMFn88/EUqrFj6V0agDCoOfZA/qpJFgx4aBrQkcWsSMQAqyluE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9c6cca-a8d3-44d8-295b-08dd67d02cf2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:56:36.3174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITw4HuuYPgvbvw4kLwFZZYM0o+AIZsHr3ohEA4qW3u1SfvXvSA/CiLbnjCU3zbApmW0HrgKQiu3a//XVIuJcWljRWgCpS8Rk0I3qkiQLZdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200107
X-Proofpoint-GUID: -69sOGbA8IcTHRG4-B0nRBJkgcO4cEDc
X-Proofpoint-ORIG-GUID: -69sOGbA8IcTHRG4-B0nRBJkgcO4cEDc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Sairaj Kodilkar,

On 3/20/25 1:11 AM, Arun Kodilkar, Sairaj wrote:
> 
> 
> On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
>> The AMD I/O Virtualization Technology (IOMMU) Specification (see Table 
>> 8: V,
>> TV, and GV Fields in Device Table Entry), specifies that a DTE with V=0,
>> TV=1 does not contain a valid address translation information.  If a 
>> request
>> requires a table walk, the walk is terminated when this condition is
>> encountered.
>>
>> Do not assume that addresses for a device with DTE[TV]=0 are passed 
>> through
>> (i.e. not remapped) and instead terminate the page table walk early.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 88 +++++++++++++++++++++++++--------------------
>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index cf00450ebe..31d5522a62 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -932,51 +932,61 @@ static void amdvi_page_walk(AMDVIAddressSpace 
>> *as, uint64_t *dte,
>>       uint64_t pte = dte[0], pte_addr, page_mask;
>>       /* make sure the DTE has TV = 1 */
>> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
>> -        level = get_pte_translation_mode(pte);
>> -        if (level >= 7) {
>> -            trace_amdvi_mode_invalid(level, addr);
>> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
>> +        /*
>> +         * A DTE with V=1, TV=0 does not have a valid Page Table Root 
>> Pointer.
>> +         * An IOMMU processing a request that requires a table walk 
>> terminates
>> +         * the walk when it encounters this condition. Do the same 
>> and return
>> +         * instead of assuming that the address is forwarded without 
>> translation
>> +         * i.e. the passthrough case, as it is done for the case 
>> where DTE[V]=0.
>> +         */
> Hi Alejandro,
> According to AMD IOMMU specs TABLE 44 (IO_PAGE_FAULT Event Types), IOMMU
> reports IO_PAGE_FAULT event when TV bit is not set in the DTE.
> 
> Hence you should use amdvi_page_fault to report the IO_PAGE_FAULT
> event before returning.

Good point, I had not considered this (and really haven't paid attention 
to the page fault reporting until now). On first impression, I tend to 
agree with your observation and will include in on v2. That being said...

The current role of amdvi_page_walk() is to be a helper for the 
translate() method and ultimately the IOMMU replay() functionality. 
These are needed for emulation but do not necessarily correspond 1:1 
with guest-initiated operations. e.g. VFIO code will call 
memory_region_iommu_replay() (which ends up calling amdvi_walk_page())
when syncing the dirty bitmap or after registering a new notifier. The 
guest would get IO_PAGE_FAULT events for all the regions where a mapping 
doesn't currently exist, which doesn't seem correct.

IOW, I think even this existing call to amdvi_page_fault() is not 
necessary/correct:

     do {
         pte_perms = amdvi_get_perms(pte);
         present = pte & 1;
         if (!present || perms != (perms & pte_perms)) {
             amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
             trace_amdvi_page_fault(addr);
             return;
         }
    [...]

I am aware I am jumping ahead a bit too much, but the point is that the 
whole event reporting likely needs a comprehensive review.

I need to study the area a lot more since even the simplest/only current 
use of amdvi_page_fault() right now is not very clear to me.

Alejandro

P.S.
Also confusing is this assertion in 2.5.3 IO_PAGE_FAULT Event:

"I/O page faults detected for translation requests return a 
translation-not-present response (R=W=0) to the device and are not 
logged in the event log."

so this suggests we should not emit a page fault i.e. don't log it in 
the event log.


> 
> Regards
> Sairaj Kodilkar



