Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9CBC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmkg-0006Ii-G4; Wed, 05 Mar 2025 06:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tpmkd-0006Fa-Q2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:17:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tpmkY-0005PM-Pv
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:17:23 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255MtL2004949;
 Wed, 5 Mar 2025 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=MqdMBAP1S26SQZcam3vxO/WebG21V9AaSbgZ+y5fWtE=; b=
 cocF/RQd/GzvVUE79LvFb3XJZnN7qoKtosN2D40tjiWkoRgp+UQUm/oeLGRuvoBX
 OB2L7ZcywCMwhSyF+nTeSrkoNHAc2IcMfzJYTh1rJ6T+epVwG53EKZStmXuCndZ7
 d0Sn1FKVxQahGkIkCR36Ty9jNgD+DmbS8RHjjNbba7CzSpONwbhZtk1fLHQsKzRd
 k2GVSIzpXl8xiXc0/z2y+/hQkOeV1Fg3MSQaD9/OzTvwxq8k3z1Ai/tIJtWgaqoD
 jpzcTdTR11veCwlqqoN1J1MZA5uKReJ8X7G3n66rOvUOM2SYW9JIYiBUfZxcZWVb
 BtvgPRpsHGbd+efQjbHeCA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub77bs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Mar 2025 11:16:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 525AeK0M021872; Wed, 5 Mar 2025 11:16:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rww7m90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Mar 2025 11:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsvdGILE0KiBRhA08+Kc2B7UUDs2A2TMbET42sWOyVCW+YFumFPy8CyVTilSVRYH/LXDJWca8vmtY0onx1/MFMicjDLENpCYqlZXHxheMU7/s2C4HJN0HikGpltqKTCdmsbojPhX0IGmXiAQnrb3Rv+vrXvOMPFoef4B2ofpD0JsGd7Ti1JDZ7+y+0u0SB2IO06U151CVy1n2Ysei7Mw2nmMnhsZ4B/V9cwIkzNRbwGI5Qq7wJdjmUS/geUDZDUJ9hkzz5qBhNHkVEZQgL0uirdZLYKic7a78NZ4uhGNEHyggu8PS2WJJNyhuBpPGvTRdG2sT/2PAkjjrfuhj68gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqdMBAP1S26SQZcam3vxO/WebG21V9AaSbgZ+y5fWtE=;
 b=Rcslmmn7LlYryNbKys2LragSD6vYOTPYvGE/dK0E8dMqWDTnqRDXauoWHc7xLHAESxAsGFklgftOLEG3sYxAgvUPLTjlMD2nyqmrlE5GxTlm1jrqVYTC1NRMyKTYqTDJLD34yHV/xa7fpNeHb/DAyUidfsTXJc9rQSFr1umqE59fERoKehV9rCVP/yZpKfnyG3TdTKh7yKUDSP131ectdKmO6Sotag+u/r0xH97m8M3twJxc8BvR3uMA0nkke9ZpEI/WPg8m1BeYKpnByQJPFmC6xQVdEmio6n68dYkAE7CB+Hq+xQoUUtPyWAjGbw6fBwLxe5SMgiHtmJQ542/zNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqdMBAP1S26SQZcam3vxO/WebG21V9AaSbgZ+y5fWtE=;
 b=jmbjDmoVzN70bzK69lxy9t/Wx+keXIPHgtpw5CjjLapsiBrXiJnyKfoto/MzvPb0Yldgj5K7tRkcrHDJ9y3+pHpcQLzDfhywoWJuALc64CGSXrBSApQ9Z3vC2ovhsJQKgnGLXZYp/9ezu12IC9RzO12f+cil19CZ3980NjSEh2Q=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 11:16:53 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 11:16:53 +0000
Message-ID: <6985a62f-a091-4087-887c-361570170ef6@oracle.com>
Date: Wed, 5 Mar 2025 11:16:47 +0000
Subject: Re: [PATCH v2] vfio: Add property documentation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
 <995ef2ed-a5e0-469e-b780-6800f26d7b22@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <995ef2ed-a5e0-469e-b780-6800f26d7b22@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0452.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc46059-6b96-4e00-9d59-08dd5bd73b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkR0c1ZmeTBtb1JDTHlEcVV4cVUyNG5oZXZWNWZYc1U3NDBjNzdVUWphckJi?=
 =?utf-8?B?MXd3emtKRFRhQXRSbndPanVZR0xCYjJuSlE4SERYUEQ1RjBHdXdlTERxN0g1?=
 =?utf-8?B?cmdGYnFHVEhMVXJaZU8rVGpiUzZRRVNkLzUvRGdOTDdqcXVEMkZlejBqNEVK?=
 =?utf-8?B?dGZDckRab0tzemZUNmJmK2ZwT0NuUUV1OGV3QjU1UUowM0NIRFpteTBQQzRP?=
 =?utf-8?B?WkRsSUJJQlVaQldmTDJlOGJqdEVGMnNyNWtTeERqTWdBRWlkV1ZFRDVTZHFV?=
 =?utf-8?B?R3pyNWNIU3R2ZFhVdjROKzYzdlhEMjVZaGZSZDhpajNvTVg5VGRTOFN4Wklv?=
 =?utf-8?B?ZWhra056WUNyeG82NHpEYVJEMnp5em4vYmZCMENkenBCM1RzQlFUK0lncktM?=
 =?utf-8?B?Ykp3TnJWV2pQRVQzTjUyWWpDMFNDMWVFVzg0Q1BUNEhmcStndm5qRDQvNFZY?=
 =?utf-8?B?bkk1SUo2QkZkZTdCUG1XSFo3eW5RdHdMUXhMa1JmWmlndE9vTWxWUEtkcnlY?=
 =?utf-8?B?Tlo3dDVpdEt0ZDNibjh6ajN2ZkZLNExKQU90WUFLdVZUYnBnSVlIWnFQZmcz?=
 =?utf-8?B?RlI0emN3NkVGTkwzbGdUTDdjbXJzSXc2QnQrRFAwNlo1ZGdLVWliSHpJTjdY?=
 =?utf-8?B?Y0N2Z21PNXg3TWhId1ZUeU5CUm8vb2h6M1B1eXFSLzYwWVZkdFBZV3VHMllC?=
 =?utf-8?B?Y0xCOW5QWFV3dm5mY3h0SW5KWjNjWjZmKzJaRUNiUWFJS2pCbmFwK0hCcU05?=
 =?utf-8?B?MllvQW4zV2p2SG1IcmdrYksvQWZjU3JKd1B3V3RDeStab1RZOEZQUGZERlp5?=
 =?utf-8?B?RmQzN3dLK2cyTHpYQ3RyaVBOWld0VDFzK21wQ1Q5TENKcHNjSUtBMU5jK1d1?=
 =?utf-8?B?bXNobzhpMFVraGZjeEpGVGhvOU5sNTRlbUtqZTByclZFSnUwdVdNbXNIQnVj?=
 =?utf-8?B?R0t0TC9vejk0R2pJOGp6WUwzMUQrMmIwczFwb1NCMzdvOFJjcmtVckRkcmRV?=
 =?utf-8?B?elJzMjFTMXJ2MnozOEw1QVhkVkkwb0pPbkxNUzhxN2FEbm5aZytuTEkwN0d4?=
 =?utf-8?B?OE9aa3c4dWpycW1OOThqbFZ4NitRTVhWSE0yRGhXWko0S3hVRncyaTBuUXJs?=
 =?utf-8?B?SnMwU01RZCt3eFBnZlZSZk4xSWdIV2Y5V3FzQ2k0M2JOcHV0SjJ6YzQ4TGJC?=
 =?utf-8?B?bi9LUE1qZ2Y2QWlWRWlDbDA0eWc2eWt4Sm1YcmtJTlhZVWVEQ2p3VmE1dkV3?=
 =?utf-8?B?ZHNOMXVlSzlyRXhSVmR0OGVQMnRvN05UL1lzWGlFMHhsT3I5Nkl4ZTRaM1ZL?=
 =?utf-8?B?d0xnWEJvaS9zR2IzTTNvV2NxWUV4MTc0bHhOWm1FZXlYNk8xSWtqSk5Pc0Ix?=
 =?utf-8?B?SVgydDFoMDhJR3JaL3p2R0ovY2JFeHRRTStZWlZpL29XWTZkTGoxNnVDOEtI?=
 =?utf-8?B?K3FaMHgwMHRjRDJMYXRCWDJYVUlLTGEyb3h3WHplODJwUTBkaTk2OW4yTUtV?=
 =?utf-8?B?Z3RWMmlhNEN3NjFXanQ2QUVoQ0tZdkpvL1JnR1FqUTFGNmtpZ2lrMXBmRjR3?=
 =?utf-8?B?K2VQaXQwbDZodDJYMU04WDE1ZjJLNjcwMDl1eU5vdnltWFp1UEJoL3cyeVJE?=
 =?utf-8?B?eXpxVVVKYVBLTVBuNnVtS0R4anJZZ0VlZjFsWVJlZnNWd3F6VUJya1ZyUDhS?=
 =?utf-8?B?cUtLYk5WSEloM0dmeEJSNWx4R0xxRUwxUHJCZDRjQS9qY3VQSDk3aVROZ083?=
 =?utf-8?B?TENTVGFpRi94UFhaZWxLZnFNaTMzMTV2bjFxcEtyQVBPeGdLdUhnY2F6MHpR?=
 =?utf-8?B?dUsyMnhnRXFFbmNacHg4N1ZlOUlJcjFEbkt2d3YwblJWL1BSSGNrdVhxNVNB?=
 =?utf-8?Q?YXbhz4/2kVqGo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhrK0E0UkpWRDlmNEQ4eStZOTAvamVEOFJoOWVxeS9WL3JYd1dTeTdOMTN6?=
 =?utf-8?B?NkU5dmxFaFpNbWxPU0VvNFZZUkJzclAySm1tRkcyd1ZqK05BeFdPcmF5dVYw?=
 =?utf-8?B?NVVsdGgzM3VIcXpSak5pbThWYUFYSXVSYnAzNkdzRjZKdllzQXpQNkVMcWds?=
 =?utf-8?B?N09iNFVQYnlpaEJwNTBjeFpqNGxaTGNHU2p4Z20wT1Rrc1pMdm5Idk5EdzJh?=
 =?utf-8?B?dzV3aFdjaTBCc213OFFqMldkcFNFdFBQM2gySU5VLzVvanpkd2NCaHVFVG0y?=
 =?utf-8?B?MFZRd2t5bVJsZzRmSXU5Yk9UVlJlNTJCYTRWajVMZ0FrQlhqKzhPUHVvSmsr?=
 =?utf-8?B?YUhEQ3R4UmUwTDRFRndFaGJlQjB5VFBHRi9ZWEhuYTlDVzI2djdUb0l6R1Ro?=
 =?utf-8?B?MThnZDFmbnd1R20wQ09GdEJjaFcxZU5Qb2o0ek14Ny9TS1orYUF4Y1N0VTR0?=
 =?utf-8?B?R1VxZ0VuaXYyRTFKY2tFckxKUDE4K2NPbWk2QWFDS1VncytSWlY5OFVyTzZ0?=
 =?utf-8?B?bGMzMDNEeC9jQ3BPSG9lOWhVZnM1QS9xMUpTOHhRV2RwOWJpUzE4QzZ5bnNi?=
 =?utf-8?B?MFVZZGUzaEVrbGtTeU1pVnlYc0IvQ0EwaWxMTEpsaTVNZHlQYXY5SVpHbjJa?=
 =?utf-8?B?Mm54UmFYbGV4SHI5WHFoSlpsTDU3THBNUkNTRG9LY0pYU0RESno3S0NnU3I0?=
 =?utf-8?B?NllQWU5HZ0pIL1p3ckh1Vk9RUUlva29Dd1BSUlMyeW1saklvSWxkZTUvWTVW?=
 =?utf-8?B?anA5Ukptc1h3cUVTenlROHI3cXNXb2FZSkNBNXpXSmlMbnhCcXdKdGZCMFU1?=
 =?utf-8?B?ZlpZK0hCaWYrc2tnSkkxOEZqbU03NDExYmFtRXZXMkJWRlBjaTg5M1MzOHla?=
 =?utf-8?B?a2lXRWNKa2YwU3JsRlVmOFl5dEREUjY1WE5pYnVXNHM0V2pjMjVxeTVLdkNp?=
 =?utf-8?B?N3ByQms3Zno1MmVieFI2MytialZsb1dxaTJ6eUx4eXZXQTdmYkNaaElMeFlL?=
 =?utf-8?B?V1NMMEhCNUpueGltQVREUm1HandNako5eU55U0x3aVhUZ29sTDZ4eUEwbk1s?=
 =?utf-8?B?V3krdWJSak1TMC9yZnNpaHBpazBuSElURlpmbGFBSlBsOFovdmdzdnpTdmNx?=
 =?utf-8?B?MGs0Wm1JNzRXTXZNYVhKNngwcDZWZ3ZvRDc5bElzMmVUSDgvU0llc1Bra3Ex?=
 =?utf-8?B?RzJkN3pxam9MTjFobFc3aU5tdDlVd05GT0N0Sml0cE9nZVFFUFFMOUNSbml2?=
 =?utf-8?B?TjZTUzJHVnhvU3lyVDFBL0czMytCK3pZdU4xUDlCQlNWckxZVVJNeDhNSEZw?=
 =?utf-8?B?UVYxL0dlNEh2cTE2RERLRmhyK2ZQMzE1VFNQaVZDUHdaSEV4NFFWUlRCejB0?=
 =?utf-8?B?aE5nNUl5K2J4QUdZSjR6RXJIVjlCM0VKQnNUOFowRVRvL1drRDRWYkUzbi9S?=
 =?utf-8?B?aEZyYWQ5c3ZZQi94S3JodkkxaTM1eDJPcDI0TnRaZGJtKyt0SjBIS1diaC9j?=
 =?utf-8?B?d1lDZ3ZFa0tESW9ydmgxd1puenIwc2xoZjdEdEFVYTVKUzBhNzNlYWdOUFMz?=
 =?utf-8?B?NGVkcksyTHJUOGFMNlhONHRKN3BGS1ZvYTF2blFGWXVyR0EzT2Z5b3Zob1Bo?=
 =?utf-8?B?d1pkV2t4K21yYWd5L1B3WUJ5MFhFQWNuUis2QkpjLytTZUJBTUIyR3lXdHY4?=
 =?utf-8?B?Z2dwZnZtR1FsNmx4KzFuNlhva3M0Tkx6WWo0M0hKWFpCTzhLZk9WY1BFLzdQ?=
 =?utf-8?B?WVN3WTZhVVlXMitnYndXTFBtaXljUDcvUUhvYzd6a3Z2Y2dKemoreU5GTVly?=
 =?utf-8?B?eU15SGh0eEk4aEVTWXJ6VEhsLzdBbEQ5eGJ1MTF5MG9UN2loa0lFSXExaERE?=
 =?utf-8?B?SjN5TEYxUVJHalI3bllncGxVdVB0T0MvQTVaaUZPaHVlc1ppL0R4OGZzdm1q?=
 =?utf-8?B?SzIrVU5xaXJ5akc3MXgrZ2QrYmtYU3k2bFY1MWRZRHdqNjNYWkdKRzBHUVdM?=
 =?utf-8?B?dTk1ejRIL2J3Y3FIaGFmUFJ4bWoyQlFPNUlzZDZrc05HM3ZhcWdiNGtXUEZz?=
 =?utf-8?B?ZG5kSFZVVmo0d25KRkhOWVdIQ3lrMDFBNFZ4dmJHMnR2QzNKbFRGRldReG9C?=
 =?utf-8?B?VU5OZG5qUm4vRFlheUphRVc4cE1RTXUvY0VacDhQRkR1Ujh5YVFNVVRBdDJQ?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XQ5XquroW2WZZjcq4NfsQD7sqRxCRo9mXCRsJxnv/t5yb4W7BjTULJN1GVg1E1yizQjvp4apJSU/YMffQsTyZZA0XB02PhuR+sbc8vngznmzam5IYwuu2g+YCSUawuU9cqFFdMTPWBwEuXg//u1h+PymYD+IAPhyTC+2G+4bPhy7PAkZ0SVCBPD4hjJYoF9ed3DC30Bfu0qqkz9YtI9ho4KkhYyF+KG582ER+VVLdYzTVYt1I6Kx30Daq/rNoN5P5cmk4OohD2JhRdY30YofYTYxbRIhMYb1xsohjfC+woY/DglSRIR3c+iFGrGsl+ObUefAHk6DmFE9ljGoGNvZLLAwtGXMBHxI6TWuD8JDFfYraZNUwFKlN/4qQQJRtPqV7AaUCkOODJivqdsc2Tmwgw2YOf5+p9Kx6gVdAIOdGVk9Mrtyjf39ps3kkaWRU7umzHJkv9BDafBB0TaSjDbyQXU7WIAK9VPmi6jFodxsXhDLs9+YcaO+o+fwwovcZGqwwfXEbS4xeP6eiCAIOMOuCUU0bBTl0QLN5qzVzvJd5xmlA8bqXTbRDVLEH+lDxO5//baTm8PT7SLjuUMh6Avv3ZElIgOPT7cSmXfecCRFRA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc46059-6b96-4e00-9d59-08dd5bd73b39
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 11:16:52.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCazs6/xr+TmYBsBJgHIxm7iyf2ZldMug7iWZyYZgkosvI3yH4i6sqIe6ivkvdUSbUmY2n0PllD19Je8cCT26KiZ1OGTh5WjmRUY5RB/e8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503050091
X-Proofpoint-GUID: dUUnnlt4ZH7mFsey966oePAmSAcg2ARu
X-Proofpoint-ORIG-GUID: dUUnnlt4ZH7mFsey966oePAmSAcg2ARu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 14/02/2025 13:05, Cédric Le Goater wrote:
> +Kirti
> +Joao
> 
> On 2/13/25 22:45, Alex Williamson wrote:
>>> +
>>> +    /*
>>> +     * Migration support
>>> +     */
>>> +    object_class_property_set_description(klass, /* 5.2 */
>>> +                                          "x-pre-copy-dirty-page-tracking",
>>> +                                          "Disable dirty pages tracking
>>> during iterative phase");
>>> +    object_class_property_set_description(klass, /* 9.1 */
>>> +                                          "x-device-dirty-page-tracking",
>>> +                                          "Disable device dirty page
>>> tracking and use container-based dirty page tracking");
>> These are really debug as well, right?  They just happen to be
>> migration related debug.
> 
> I suppose so. I would rather keep them under the migration topic
> and add 'debug' in the comment.
> 
> Changes :
> 
>   commit bb0990d1740f ("vfio: Change default dirty pages tracking behavior
> during migration")
>   commit 30b916778517 ("vfio/common: Allow disabling device dirty page tracking")
> 
> do not explicitly explain why these properties are useful in any way.
> 
> Kirti, Joao, could you ?

Sorry for the extreme delay but I was out travelling for the past 3 weeks for
vacation and work.

The property is marked as x- but my intent was both debug/testing and to have
something that allows me to select the dirty tracker between device vs platform
dirty tracker if something is wrong with say VF dirty tracker or if there's some
limitations around it. These days we actually use it a lot as my default to have
IOMMU dirty tracker in use. I wouldn't label it exclusively as '(debug)' just yet.

The precopy option might be to avoid dirty tracking at all and it's generally
useful when you don't have dirty tracking at all or say snapshots or 'offline
migration'. But I have never seen real use of it, or need for that matter,
except the early days of VFIO migration during testing.

