Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568D8FEC0E6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55Mq-0004kQ-Uk; Tue, 24 Mar 2026 13:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w55Mm-0004k7-6o
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:16:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w55Mi-0003pm-EQ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:16:31 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCBoh52735825; Tue, 24 Mar 2026 17:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0tmkrtpT5tEVdd1QBdFlHWTDMFYBJb1SSDsyihxa2PE=; b=
 f1AnrLT3MpY8kULHONCI+1YkLRPYl4hOVt65HRFBhPhsiUZsBeqdIG9CB0pomQCW
 zZVALNtvSXJHB6JLoll0PE0zaHkmHc6OxFSN9B6XJYz2rEzt9rv3WVIO/95Cge43
 E3Qb/9RyV3R3CdhNWxHaZrOjD8rX0WuUViAUlrNxSoI5bwu8hTq/KtxK5m373al7
 iLVBWMs7X/aTbJXpWsY+tZ4uyIAvko0dBtOwJVkT5ebK/2ahPHH2ZcSLMpvMXFWR
 jTLkUDi2G+LGPs7HlYz2uPe8t3HNzVohBoP4jGLRPkGzyb9ELhEcDOojT6n7ypx5
 Q1vzVDF0Q2huZex7M/3o8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khvvre4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 17:16:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62OGcUQF012322; Tue, 24 Mar 2026 17:16:17 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hsg941k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 17:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFeUiApINqGlCwIL4VjFRDtjVy8YJ1oM6DKbrtSKeG8oimbashrf/MV8i7JMEpkV2RbC/Tr/WvYe0g16RJ8B4Hsi/pUQE2rC8cWAm29wGI2cbkstH4iMQ9WvYcJqDQy1RJt22HMfHlQHyuVeJjijPpipCcLRA+/K9/4cNimWHj5TPoGEdOtpSMdQAQVEQCJDvlJlYffjF+ONiclzt909bgk8xZj3GXlQ8xpDlVVVx7i4AgNiIGdBN2wxjOMCC2h+DUbYhqfVJp8jdH+o7sdKzJDTY3uvRe/S7mlkHeBie2GSyN9IC4w7KFYo5HkNJABB5CrsjyyxcZ5rhGYESrzeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tmkrtpT5tEVdd1QBdFlHWTDMFYBJb1SSDsyihxa2PE=;
 b=nIkvJrx9fjxAnFljvZvOUZjDDrE+GZmJsbX5TaNtnuoaopn+oDuKqObXRRpMk2DyPt0RBTfQRUyA95lUptNQQWlQZfy66TSFmys/07qNmKnxIKfU1kjs22Kqlt5Imk920JgWEGapr/8MceOx/+Hec5Qx2okb0NbFyECuGjZO+c9Ywe6KbRA5e3u+I7sBn2iV961+R3ZOqYDSJJgCdSTqhHEHor17RQcA01+pFHQzV3+oTc37ATvC0nmhT5i/O8aNa6vJgm6TAkQqBExuvYm/AYU/ynvWK6EkYORj65bJxNubhcinO4OWOHEZUY0NdyjPby4MI9TRuLxDPotwtnlN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tmkrtpT5tEVdd1QBdFlHWTDMFYBJb1SSDsyihxa2PE=;
 b=WOsmU6CQH+LhJAXQrOiEa/97bKQOHfRfuCqzR3SLPlniwrgfubxzrJ2o0XoFSFinMyk8EA2Zsr/7Ebm83K4uo3wKZxUuAI8TL1G6BEb7NqbvtCboeNUwLymGV7wraAKluHY6ch19xRuW3a5fIGevNGslhHWB5z+WlaG+R7sidMg=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:16:14 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 17:16:14 +0000
Message-ID: <ab5b612c-643d-499a-aa3f-2b730e175fc0@oracle.com>
Date: Tue, 24 Mar 2026 13:16:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/14] virtio,virtio-net: add initial early VMSD for
 setup-phase migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-3-jonah.palmer@oracle.com>
 <CAJaqyWfsr8GUfcXPz6xwcXn3TA2_k4o8+_ySr6znExj34p5VtA@mail.gmail.com>
 <cf9b156f-725c-4443-b25f-b82911cd10bc@oracle.com>
 <CAJaqyWcMZC3NCQ4qHTypPfiNe--SpeXue7FCrOob4iAoj-FSiQ@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcMZC3NCQ4qHTypPfiNe--SpeXue7FCrOob4iAoj-FSiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::23) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 0103afdb-e0b7-4785-54ce-08de89c90d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: dnzSYZ3e8zRNiTPkh8K9s9H/9xGKtOJCki5gkrEua6GEviR1MMHETKYAOJGWY2I6Ie8JBbCS0FmYcUR6szBp7e6G+uTtMRZoMY760lc0m4/BP8QRRb2PuqzyKDFV5uhgKhFmcJyEkqHcoV68jfgG4Tkai4ogB2f/mSIKbaQGkcuAFFh8NnnvXVUxFV1upUQUSFH+Rg2BCvLzs+ptSYQQs2loFtZqjfZ8xP2mQpy2FUfN00CToXY3p8FBWLm3Yi8LSaecLp36uvRgk2Z3ij40Jp32kxx9GVo9P1bwVNhclBHh+G/bSGJ+GlOk1zsDyzfIFoyyUQjSOy/9aC7QC0D8yrrKjk877a4dU5CkbzjGJISiBRsmvxnUE0p2+Cj/Bo/2HCR+kZuHvS0vUZkN5CC+by/FMIrAMPEwAOKagcVPfHVVgoBDXT2+VfYf6yUD4jrOjUXyYAFS144fig+7aSS2rYwsw7jlWAhRlMeREBR7hq9Xhusv/symifQeLuVf1Sf5P6iCcoyN5bGfLg5eBw9/n+MmPghepG2hM81MoMQeD8113xq9vsb7pNd/2Gnyt7/XW0vSFDrAVGhEcgzCJHDO41wzki53o//lM23OyT3pEtEardl2IfxX6miOFNnz5FHb7/wHmBUdqaerJr/xLVP9EV73Ob51nngO2ZokUXK51dlgxxyGgkbJ50ttyaC1R1B70LoYxlUrpMXMBsdqHlWDWqoR+Ek5910PPs2T1J+2cpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhkVEMzMWJWeTBRUFNXcEwzSTJpUkpVVEpSZzVkVXNWYnBHZEIxMHFBUGEr?=
 =?utf-8?B?RzlFTm40QVh3OExZYTl3ZWRhVms3dlZ2NlI3NUd5VFB1VkhZakxKUWpCdmk1?=
 =?utf-8?B?MXE2REdpY0J6UHlrZ2pJaWxvam14M2pnSFhHUlZUL0NjM1hrc05PMWpyT1Q4?=
 =?utf-8?B?ZXI3SVdHeVI4MTVZZmNDT09DcDlkeVp6NHNFUitPZGxiQlVmanZYSFM3Y1ZO?=
 =?utf-8?B?WW1LaG9zbTZ2aHZ0WnpubGMwYldRL1dXNE8rMVowVW1SQmtOV2k0OE1SZ0x0?=
 =?utf-8?B?Q2djdVpTbDJHdG1ueE9rMm1rQkhYblZ2THJveWNBbE9ZQzB6OHFrZ3pTVytB?=
 =?utf-8?B?STErc1VZa1h4NXMyRVZpWkp1Q3VBLzczY1ZzTE9CQmxDL3M5c2hLRDMvekk4?=
 =?utf-8?B?TnJwZW5DSWEwNWdlZjRuMHU5ZTFFZGtvM2VmUGYvWDFqNS9CZVJWN0RYaWs4?=
 =?utf-8?B?cDVFbk54bGRFRElhMGZqQnpiajJtK2FGSWlKejB0VzRkci9VN1FybDVsRWNR?=
 =?utf-8?B?cDVaWGQwYmVDSFBQRFl2SlZ0TGMwenlDS1Jka2ZwQ2hpSlBReW83NFRBZnNV?=
 =?utf-8?B?N1Nxc1EzNXFmcHhwcVh2R3FPREFTUG1lV2pyN29IZU9rZFlBVmxCWVNVaXRY?=
 =?utf-8?B?NVpjWFA5eTVvckRINUZjVllFdDNyYW9vRjk2UjBDeldNOVlqT0k1eDRKNGgr?=
 =?utf-8?B?RzA5aURnMzUwcFk1cDNEd09nVmxIL0FTcjZvMjkvMkFJKyt1LzlZMUVOL0lr?=
 =?utf-8?B?MXB0QUw4YVlGWGt1dHZKRFBjSzVDeEdzb21jK2ZldWthMnNGNFRRQlJ5dzVL?=
 =?utf-8?B?blpaNjE3UDNxdGNaT05Dek1kN2dwbkRqNFcwcDFKa1VEVEppbldiNVp4ZUJZ?=
 =?utf-8?B?a2FRNnBrVWQ3cFZicThvdnAweXdYNkxRTXlHL2dvN0VYOHpKMTlnbGI2ZU92?=
 =?utf-8?B?dWVSUVZLdTNyMU5jZlVhVGZFODJib2c4am1DK2tUV2ZhTlZxMk5KeUFTRGRF?=
 =?utf-8?B?bUxzOFVxVUI0MklBWW9sUmRabElWdytlaC9uMjNicGh5akxqN3ZQMmNBMFB0?=
 =?utf-8?B?cFI2NjRNYXdFemtIUTdoS2R6TGlLektoaVl5MzZQYy93MDJPam9LSU9vb09q?=
 =?utf-8?B?S0Vsd2psTjhPYW41V3hqM3d6UjEwWkxpQ2l5a01ocU4rcUhaKzJiWlp5cnZI?=
 =?utf-8?B?bVN4YmVVRDlqYUtOWHpRaEpTZFFOMzNzTXpDQU1aalc5Mng0TVZzVnJVakRV?=
 =?utf-8?B?Z3pGcUR6bXE2Zm1RbHhtRlBXTmwySnVEQURZSTkycVJRL3NKaXluRUV3NzBF?=
 =?utf-8?B?NVc1Si9kdFFNMUdhT1FnZXFIZVpvZ0U5ZDM2UDU0SnBEWFBRRzRxeDRJUUQ4?=
 =?utf-8?B?bkU3NjR1RTdBZWVkb0UvYkZTNHR4YzA2cE1zTDB4dXNSdlFQYStUNDFzQkVB?=
 =?utf-8?B?YzhCYjFGVWpCS25LMnF1bDYyNlBaMisreGFDMDBRRDFyMWhIR0lERkVXNDli?=
 =?utf-8?B?dndPbXpRckovYkhCVDh2MnNocjNYZW43KzVFVlIxeHVnM1hIT29sdkdKS1R0?=
 =?utf-8?B?NUl6Q0gxYy9Xc1NKZzNaTWF5UmJTZkRieTErcXYvMEs2eGpOK1ViOG84M3lC?=
 =?utf-8?B?M3JNZ2UrZFMxekx2ZUtWSnlKZURpNC91cTFrL0tjWnJURlNFN3Z6a3J0d0VR?=
 =?utf-8?B?L2c2OThhWkE0UDNVcExKc3hVRmthQUhUMDlsR0lzUkRYcDZhVmFMWSsrQjcy?=
 =?utf-8?B?S2hIQ3ZQekZBL1RmUGIwL1BpV2hyM2hWUTRrWUNFcitzVVl1eUF1eitsVS9V?=
 =?utf-8?B?SlVxSEwweHAxQlZLSlRjalFlc3Z1MjVSaXBTMGl0VjRpK21lOGx6UUxlT216?=
 =?utf-8?B?Ukp5aVVOY0dabnJCK1FBMlRHL3VTaWVvYmgyaWFlMkRyTXZ1aWFNVy91Y2pB?=
 =?utf-8?B?N1BLbWFiNnBmR3hERFpmR2hEa1lSRS92VFUrWUwzMnhuNi85RG1hM2kwTFpl?=
 =?utf-8?B?UG03YVd6OGlldUlxcDlhK1JQdHRnczc0cWJFVG95T1Vqd3psbzdpRzRpc1l4?=
 =?utf-8?B?aHZMOE05WkhBc3R1QTR4UWdaU3hobnMwdWVKNVExWHVRUVRGWWR6S1pTbnBk?=
 =?utf-8?B?Nmg1bGFacWxPbUlkaEhqRGlObUNZc1J0c2VnckNpaVdteWJ4ajhPWEU1bkhy?=
 =?utf-8?B?bnVnSitZb1BDelcrSVZpbGRVV1FBOG04alpERVRyczkvYlhvZ0EweG02cUxZ?=
 =?utf-8?B?b0JMb1g4UE9lNHZsdGlBbDBFeDdMZE53RU1YQ09LVVRtS0owQWRVSy9TbEpR?=
 =?utf-8?B?SGxxRHZTYlB3dXY2NnVLaGRwVmJFRWV0SkEwbWYzRkJXT0NINXZ4QT09?=
X-Exchange-RoutingPolicyChecked: HI1c8RhSkKGUrB4X+oZ9k+b+bMeml2HkZy/02DoaAoIvtPQi5V7veQb331ZhE71VBOhhvuGO3fG9xsaCV49n9qeirLn5uOZdnSUD98dfsZ7NzAp/eLZ/FgmX6EI4hiUoDr0RspYDjxXW6WKorRcFMQMgnOPSNuHaOMhMrz7n0xJD3779yZRFItSOCay4gd+7zWOmnvrRcEgNEo8x/3IJ5owyXlzGkH/xUY1BDuha//JXU8xptLeHdFLd0iCmzkQ0/Yvjb1mcjTgs4WEBdquAFp/l6vKGpcPYxYTQGb/LQf0KzUxr+/QnNIjLYnBU4ZQIzTWI9B3Uasyzc86rbAOpVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vymprLrdNh8IT3DYNr2IazPACfkoN+6dn1uzUd+QaSFbaSmtNL6CU9FgNt24FV1pE8V05tBoYHgoTqih4U/sX4XCyRtAV6qw1xWLJUkrL5kGdUcoNwu4UjMQJbb8VJtPDdbbtON8+lNpQn32vqGd+BZnCav94nmpO0jdS9y679FY4pEOUjQnd/2JlW717V7kXMkak3/+ZrQZ9czH9fkmQGrGxzMj1mWtFlmPkCLImkQAe6ki656NqqT7gjAw9SemAzT0KTit8x9Wxn/4k6be6ouBm4g4GGWvcIjkhql3FAni4EA5NjBgCNz1aT9EygsBlOf7ogXeZ/0pojrCL4GZDp5XvqRN0OlA6aN8xH/u8AAGafszEn9llhUtO0g+xSeyWurDqFN/6uMgDtG2RS/hbT7+dhjMR7WXD6/1Y9SHRjcbgq38VjQyDB4WpaICFWvfNupag072pkN1dUOS2UYl6hKsvb/vt2MQIsSHIBJYFtnyEF0Zznz9IZ1DwpKT1E1ApapE8XRLsmojEwVZWEG3iBH2X7a3r59R1GR8Ib2afSM3HLEPIu7f7dxV9FU54V+6Y/YiKhXPIdYufgaddb56Ez4u9Hl5goenG4lHrLiA+k4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0103afdb-e0b7-4785-54ce-08de89c90d86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:16:14.3255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL/GDcFNxV8Ng6gIXm7O8kLdAAWq8gvkZYTJSyWmHDZ+3vgTHE95hF6lQqAAK4b3hl4ftPgkfnUM64WKUgGTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfXxESyklnP0tWs
 aLRx3u1d5g40wzu5bTBSg6s8tOPWCOpPaBX1xg2PRLZvcvDOM/xdIOO5AfwP9wnh8FfzbZhkrbm
 A7eFJvJUmOncyRUL61ezvmLW6E7MrqrN08tHxEQCAGZD3h/09TOZaGa3jkBmn2PKlBI5OTMmdde
 5Wba0KQzEgD/kJxOxuE3BtA13YPwsRZZEKYhfVdumcCmQx0a6UCuHWHHGAde4LBEvttgVHliUPP
 vos3O/Qzeob8o0hZ9v0D5zTvUEOCFH1DupzlPjXMt5/FY3j98w64YvLnUFbJGP0QxNausittuaw
 luXBdy6HGB3wt+emrIZSYAD2z010MDVKi5WnmP3oA8Nzlx4Vf9Pj0THc2c1Fv517bkmbyAO73Xf
 e5bnJk0ih9ydd2fq06+pEjr9TYOyvqLNLSqnOiV9i5nKFZwFcTSOkE/pvjOhR2DAGzxVmg9Lmiu
 4ZyeUryoHdrIXxgeamL33c4CwV02Nu2ioxstcIQQ=
X-Authority-Analysis: v=2.4 cv=VIXQXtPX c=1 sm=1 tr=0 ts=69c2c6e2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=EGenY8X69EMedjcgQdAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-GUID: s0yKGeLCmmj4mPV82hsut15NNvHvtzoU
X-Proofpoint-ORIG-GUID: s0yKGeLCmmj4mPV82hsut15NNvHvtzoU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/24/26 10:38 AM, Eugenio Perez Martin wrote:
> On Tue, Mar 24, 2026 at 3:29 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 3/24/26 5:27 AM, Eugenio Perez Martin wrote:
>>> On Fri, Mar 20, 2026 at 3:25 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> Adds a separate VMStateDescription for virtio-net that uses the
>>>> .early_setup feature. With this feature, we can migrate a virtio-net
>>>> device's state earlier, before the stop-and-copy phase.
>>>>
>>>> Future patches will utilize this to move control plane operations out of
>>>> the stop-and-copy phase to reduce the downtime latency caused by
>>>> migrating a virtio-net device.
>>>>
>>>> A VirtIODevMigration migration data structure is also introduced here
>>>> for VirtIODevices to help track the current state of a migration.
>>>>
>>>> The early_load member is used to signal that a VirtIODevice is being
>>>> loaded early and to not throw an error regarding vring indices.
>>>> Inconsistent indices shouldn't be an issue for a device so long as the
>>>> final indices are eventually loaded before the device starts.
>>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/net/virtio-net.c        | 53 ++++++++++++++++++++++++++++++++++++++
>>>>    hw/virtio/virtio.c         | 14 +++++++++-
>>>>    include/hw/virtio/virtio.h |  9 +++++++
>>>>    3 files changed, 75 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 12b3456ca2..ddd6ed6e62 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -3864,6 +3864,37 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>>>>        return qatomic_read(&n->failover_primary_hidden);
>>>>    }
>>>>
>>>> +static int virtio_net_early_pre_load(void *opaque)
>>>> +{
>>>> +    VirtIONet *n = opaque;
>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>>>> +
>>>> +    vdev->migration->early_load = true;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int virtio_net_early_post_load(void *opaque, int version_id)
>>>> +{
>>>> +    VirtIONet *n = opaque;
>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>>>> +
>>>> +    vdev->migration->early_load = false;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_virtio_net_early = {
>>>> +    .name = "virtio-net-early",
>>>> +    .minimum_version_id = VIRTIO_NET_VM_VERSION,
>>>> +    .version_id = VIRTIO_NET_VM_VERSION,
>>>> +    .early_setup = true,
>>>> +    .pre_load = virtio_net_early_pre_load,
>>>> +    .post_load = virtio_net_early_post_load,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_VIRTIO_DEVICE,
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    },
>>>> +};
>>>> +
>>>>    static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>>    {
>>>>        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>> @@ -4046,6 +4077,21 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>>                n->rss_data.specified_hash_types.on_bits |
>>>>                n->rss_data.specified_hash_types.auto_bits;
>>>>        }
>>>> +
>>>> +    if (n->early_mig) {
>>>> +        if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
>>>> +            /*
>>>> +             * vhost-user backend is not currently supported for the early
>>>> +             * migration path.
>>>> +             */
>>>> +            n->early_mig = false;
>>>> +        } else {
>>>> +            vdev->migration = g_new0(VirtIODevMigration, 1);
>>>> +            vdev->migration->early_load = false;
>>>> +
>>>> +            vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
>>>> +        }
>>>> +    }
>>>>    }
>>>>
>>>>    static void virtio_net_device_unrealize(DeviceState *dev)
>>>> @@ -4090,6 +4136,13 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>>>>        g_free(n->rss_data.indirections_table);
>>>>        net_rx_pkt_uninit(n->rx_pkt);
>>>>        virtio_cleanup(vdev);
>>>> +
>>>> +    if (n->early_mig) {
>>>> +        g_free(vdev->migration);
>>>> +        vdev->migration = NULL;
>>>
>>> Nit: You can use g_clear_pointer(vdev->migration, g_free) here.
>>>
>>
>> Ack. Will do!
>>
>>>> +
>>>> +        vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
>>>> +    }
>>>>    }
>>>>
>>>>    static void virtio_net_reset(VirtIODevice *vdev)
>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>> index 8fcf6cfd0b..48de4a430b 100644
>>>> --- a/hw/virtio/virtio.c
>>>> +++ b/hw/virtio/virtio.c
>>>> @@ -3323,6 +3323,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>>>        int32_t config_len;
>>>>        uint32_t num;
>>>>        uint32_t features;
>>>> +    bool inconsistent_indices;
>>>>        BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>>>>        VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>>>>        VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>> @@ -3460,6 +3461,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>>>            if (vdev->vq[i].vring.desc) {
>>>>                uint16_t nheads;
>>>>
>>>> +            /*
>>>> +             * Ring indices will be inconsistent for a VMStateDescription
>>>> +             * performing an early load. This shouldn't be an issue as the
>>>> +             * final indices will get sent later once the source has been
>>>> +             * stopped.
>>>> +             */
>>>> +            inconsistent_indices = vdev->migration && vdev->migration->early_load;
>>>> +
>>>>                /*
>>>>                 * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
>>>>                 * only the region cache needs to be set up.  Legacy devices need
>>>> @@ -3481,12 +3490,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>>>
>>>>                nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
>>>>                /* Check it isn't doing strange things with descriptor numbers. */
>>>> -            if (nheads > vdev->vq[i].vring.num) {
>>>> +            if (!inconsistent_indices && nheads > vdev->vq[i].vring.num) {
>>>>                    virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
>>>>                                 "inconsistent with Host index 0x%x: delta 0x%x",
>>>>                                 i, vdev->vq[i].vring.num,
>>>>                                 vring_avail_idx(&vdev->vq[i]),
>>>>                                 vdev->vq[i].last_avail_idx, nheads);
>>>> +                inconsistent_indices = true;
>>>> +            }
>>>> +            if (inconsistent_indices) {
>>>>                    vdev->vq[i].used_idx = 0;
>>>>                    vdev->vq[i].shadow_avail_idx = 0;
>>>>                    vdev->vq[i].inuse = 0;
>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>> index 6344bd7b68..4c886eb48b 100644
>>>> --- a/include/hw/virtio/virtio.h
>>>> +++ b/include/hw/virtio/virtio.h
>>>> @@ -99,6 +99,14 @@ enum virtio_device_endian {
>>>>        VIRTIO_DEVICE_ENDIAN_BIG,
>>>>    };
>>>>
>>>> +/**
>>>> + * struct VirtIODevMigration - Common VirtIODevice migration structure
>>>> + * @early_load: Flag to indicate an early virtio_load for the device.
>>>> + */
>>>> +typedef struct VirtIODevMigration {
>>>> +    bool early_load;
>>>> +} VirtIODevMigration;
>>>> +
>>>>    /**
>>>>     * struct VirtIODevice - common VirtIO structure
>>>>     * @name: name of the device
>>>> @@ -168,6 +176,7 @@ struct VirtIODevice
>>>>         */
>>>>        EventNotifier config_notifier;
>>>>        bool device_iotlb_enabled;
>>>> +    VirtIODevMigration *migration;
>>>
>>> Can we use something like net "struct VirtIONetMigTmp" for this so
>>> VirtIODevice does not need to be expanded?
>>>
>>
>> I wanted to keep it under VirtIODevice because it's meant to hold
>> migration scratch state that's common for all VirtIODevices, not just
>> virtio-net. For example, it could be reusable by other virtio devices in
>> the future if they were to implement their own early-migration path.
>>
>> If we made this for virtio-net only, we'd need to modify generic virtio
>> code (e.g. an extra callback) just for retrieving the state. I thought
>> that this would be the cleaner way to go about handling common
>> VirtIODevice state.
>>
> 
> I wasn't clear enough. My goal was to move it to a struct allocated
> only at migration time, not through all the live of the device.
> 
> Moving the allocation and freeing of the struct to
> virtio_net_early_pre_load / virtio_net_early_post_load is a first
> step. Removing the pointer altogether, the same way VirtIONet doesn't
> need a pointer to hold VirtIONetMigTmp, would be even better. But I
> see how keeping it live during all the migration may be problematic to
> achieve it.
> 

Oh, I see what you're saying now. Right, I agree that, ideally, the 
lifetime of this struct would be during migration only instead of the 
entire device's lifetime. This is something I'll look into.

With regards to keeping VirtIODevMigration out of the VirtIODevice 
struct, this might be a bit trickier. But I think there's some options 
worth exploring that might not require us to do something like this. 
I'll certainly look into this as well!


