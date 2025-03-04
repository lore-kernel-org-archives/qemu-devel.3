Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA4C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 19:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpXap-0003F1-JB; Tue, 04 Mar 2025 14:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpXah-0003Di-4A
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 14:06:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpXaU-00084j-4Z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 14:06:04 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HMcY4031104;
 Tue, 4 Mar 2025 19:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=5bFpsVeFI9i4w/i9vM
 Y3njdDlF1zyMh1mjAlUKWAXv4=; b=WIdtrI9H1iEL3XjTHJHGJ/XkWoxemCsavQ
 hfyuYIZHyAypHT/PtbkdfGhlYocnvk3YC2Z8YiwGRaCiS+kBMt6FGxoQItDWXO5b
 EqDOWC3zGEizEfKestdDJBPBMvxmqb16UF2WqGdAQPvo0NJGbc/rzUtHztapA1Y/
 Z+YO9df2ylr32trw8w9idDrn1WsT/kOfq8/wmzniCD/bm1C5SviukqruxACzPzM6
 LkAkGCoDhj/+XRAkTIMiwsy9i85RrQOO/vhTsXm9bb6d1MaC1AdC9qa1P9tZ6ZwQ
 Cl+yUof1aVxvBe9pmUPaQ4Whm5j1RRN+zPkOkk+zLJa5rLqkzZdw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86nx3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Mar 2025 19:05:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 524IxLmV021913; Tue, 4 Mar 2025 19:05:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rwvawu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Mar 2025 19:05:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+bTyFCKHYV1yCcOE85Tj17i10fuWBz3LMgHr0Ag7S6Jhq5Lpm4bASZnNIw9e4CwgT2Zu6oBvyZeLY6AF2NDhnWdcOxKrK7FLN2k0X8mOOuHU+zVaG55jjVih4gyF3l8D2m5XWFUpt/gj9lOkkfc6kHpioVs/Re2ecKQK3L597U2NrFSEzY/x+NAm8aFqcEyF45LI1UPd2nHQrBeQx4X6mj7yOYAn6HzSMKWlzVeId5nBdMk14VOB/sImwV/e4BV9v2IZAlTMAtB8QaTX+N15/m1T6e+sZgKzpn1h0ikG26Ruh1GUKZiq0hp9v04HyGmaVCJ+hqxe+LRd/Ifc95Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bFpsVeFI9i4w/i9vMY3njdDlF1zyMh1mjAlUKWAXv4=;
 b=VzAq/GFU0CRj1yXnpPfgk/DBG3+oDFiTpPpd6Z27EwfKjaWiC/6/TvvUzoCd5SvPHrki0KFbtyqvYCujw6A/wfBHGS6anS5Vdm5ZYE0xXRDdLgGE1Tin/JDVLscUP8Ze7rjEV2+jBatZDjdhVCSXUWmvYtInP9HyS41Hg4RScg2lF6jdNhsov3Y2/P5l658buKbWKnD6pv2DLYqd4rbRbB4uiLf9m9ttuaAfAMpCr7AKO3tFavt+2SsM7l4SG0Ho1UEIZgsDruGCqLehr4EoGZTWJGWEigd0By8FGfS/eWMs/lqPuzj1HfITH73o5hni0AShtwmv8GKbSa1xNzyHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bFpsVeFI9i4w/i9vMY3njdDlF1zyMh1mjAlUKWAXv4=;
 b=Sj7af3O1hP8KOkJCw0rkLjSAoLRbU8WmMBeJKE1ketftZLZz1+DKrB1h0PqjjWRU18tK1iaeG0fyqDcvma3BYZrbBARmmBTyZEaykJUbIi0sv2eCnVWiBV941o2a/Bt1venJCij8NIZ1H0Wg2KyjKlhQLJ/Fb/q9LR0iHMyElmA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4449.namprd10.prod.outlook.com (2603:10b6:303:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 19:05:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 19:05:40 +0000
Content-Type: multipart/mixed; boundary="------------vSml007D2fnq5GFJsrQHCM7t"
Message-ID: <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
Date: Tue, 4 Mar 2025 14:05:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
X-ClientProxiedBy: BN9PR03CA0486.namprd03.prod.outlook.com
 (2603:10b6:408:130::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 184e3908-16b3-478d-e72d-08dd5b4f8e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEdYclpyaCtQbkV5UVZaK1o1OUtwb0lFNitMRGVmTU5jNU5aS3MwMVZaTEYz?=
 =?utf-8?B?bDY0RFhxbjhkdEJaQ0E5Tjg0WEg2aHZaUDE1Q2JOdENzdndXVUFtSWFROC9Z?=
 =?utf-8?B?U3ZGMnZyRFphbXVBZC9jVzRjcUJCUmFBekJUeDFPOXE5c2lQRE5hYW5NaHk5?=
 =?utf-8?B?dEN1MVdMMEdIMEpreVR6L0crSktQb2ZpdFNtL0ZnV25jZ2NHSDVNaVh0MU5u?=
 =?utf-8?B?L254MWF1anhONDZJSm5pd0NDWmpCYUZGVSsxNTJkVTlMRkRGUDR3WVFCcCtm?=
 =?utf-8?B?bHBYUzNXVEZNdWQ4aXhoQzNRY0VrMzVyV1pJamhaVklJY2doQWlVZm8zZW9w?=
 =?utf-8?B?d3c1VThrQ1BzUmZDZUhSUEs4dDUzL3lBc2grWURLY3hkUVFUOGM4R3g3Vk5I?=
 =?utf-8?B?eW1yQS82NUI4Y2RxdUNtcUNmYWtFNjM4ZzRqQlVhRjNNeE9DbDJKT29RM2sz?=
 =?utf-8?B?VThMNUFmWmJHTjI0dmdsUTNNcVcwckFFVy9uOVc3WVliZlBsL3JYcmVIQkRm?=
 =?utf-8?B?Zkp5OGFFNWsraHkyNFBJTG0xeWE0UlpXaS9ER2Z6Sk5FNjd5dTJhc1RabWZS?=
 =?utf-8?B?SDlFVWNaQnpqTkRJcHRqdk5UdW81MXl1R2hqOW5zZVpWdWVkdmc1d09VM0JN?=
 =?utf-8?B?d3QwWVpWanJEL0JnWVlVbXBVTGIwc3RTeEpyVXZDSzFpY2JzOVBNSFloa24x?=
 =?utf-8?B?ajdXNnZNUFQwRS9Lek1VV0FLVjZXRDhrMlJneUpZam9EcjczUXZSSDdydTN0?=
 =?utf-8?B?dk05WFMxSTh0dUhsSjlXMW9rNHNndzJWSjJLMDlDNnQ1VHViemh2SEJIQ0dO?=
 =?utf-8?B?Z2w3RWY4ZENzOXNxQ0lUSG1WaWxEczFIUjFCUVFHem04Zk9VeHVUV2t0N0ZL?=
 =?utf-8?B?WXlqd3E5SS8rdFhFUUZBeG1raS9mSzdhcmZxWllFSkhiRk95TmdhbnM4Yk8r?=
 =?utf-8?B?aTYxd3QxWFV5WThoTHRYdzdtdnRuSnphcFJYa3BjdSsxaGphK2tTL3Q0Y2Iz?=
 =?utf-8?B?SjVpOTZ0TkR6V0xNT0tMNVo2czFkUUxINmtNLzd6Tjk3eVhUYzUzMm1sT2Jl?=
 =?utf-8?B?Rmx4cFBnRThCZStCbVJ5MjU5QWRBWFQyRWRub01Za1hGZWgvVzVhY1VVK0I1?=
 =?utf-8?B?U1Vtb21PQ1FVZHJEYkg4YncxUXZuOUJnc3dXSEJXRU4xSnFEeVZBQ21LZDhM?=
 =?utf-8?B?UmhjT0ExMDY1RXY0QUc4UUFnY2pjeFNJd3IxQTFyM3Nmdm4zczdVYUhmWUNQ?=
 =?utf-8?B?S3JMVUI3cjBSektCTHJOVmF4aWFNVTdFRmRmeUhidW5kbmVuUGEzcXluQ2M0?=
 =?utf-8?B?RUNld0FXbXlKNHhtTVpOVkdTZ1kwcVBTOWpidDRQdmF0VmREYzdxSnRsMVNK?=
 =?utf-8?B?R0R4MTNDSUtZZ2s5aEZwMWROTm5MWWpsalFqK29VNHpYVWxhQlkwa3lQK0dx?=
 =?utf-8?B?U3JCYmhiblkreFRiVVZZemI3ZE1LbDFsVEhLVEN4QndWdHdOaWY4R1lBblhF?=
 =?utf-8?B?UnZTN3JraEZ3ZmNyUFhPWjdwbFRzRHV0aWRBWWZDOUFyNnlodVpPdXdleTJX?=
 =?utf-8?B?K25wSXN3czJGRWJTYkZFSFkwN1crZ1hVQmcwWENEeTRhSENyZUUwdUZUVjNB?=
 =?utf-8?B?dFdhditjZ2FEZkFpeXRyNW8wbHhVYjFoU0NZU2JGbzF0TWVicGJHeFEyTVp6?=
 =?utf-8?B?dG8vNnJWakVHV0xzU0I4S2hxL1dBNUZUYTFCellTa1JkS2Z4OGU1d0x5dytr?=
 =?utf-8?B?WDdkbkFmd3o4My91L25QdmhEQzY4elI2dU1OazBDTXFwb1B0SkVKN3hmT0ph?=
 =?utf-8?B?YnN3TkNVK3NhVVcxSmt1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjIyNmNIdEd6aEplK1VrMENqMVN2Z243M2pmS3pBMkd5S0w0MlJjY0VkaFBF?=
 =?utf-8?B?RmNCR01wb1p2QmZpVDI3UTM1K0o0NmJxdnovY1QyU0dDRng2Y2pENVVhNC9x?=
 =?utf-8?B?c3kyR1FIWXUrVy9hM2pEWUxsejl6OEExenkyeFpiek5nN295cFR3SElFQW40?=
 =?utf-8?B?bW92YTM2aFkwaVlqdlNzVHVXZkJtMFhWQU9oSFVSMFZoaFo4OTJuTTRkb1Ew?=
 =?utf-8?B?WEFka0psdmh5eVFPNXJZUlNOWm1Fa09yVEVDMmFSb1VRb2dOMjVDOUpVcllM?=
 =?utf-8?B?aWdkcnZndEVZbWpsaXBLcUdOTnhsV0FjcVZXL1NOOTJ3OHJ5SDk0RDdpc294?=
 =?utf-8?B?dElJbVozWEdnZkVvdWp0bTFJWUFjREhsMnhpQ1VjUkdoYS9xZDA3RGI3T0p5?=
 =?utf-8?B?WWlKS2QzdVpHc2orOGNxR1ZTTlJYREF2bnlrRENZeEg4QWRGLzRBL1YrazJo?=
 =?utf-8?B?S21LcGZxVGhZWnRYTk9RenRONVJRMmd6SVBOODVXOWJ3aU5qaUlFbkQrczNX?=
 =?utf-8?B?ZCtzSlE3SDJtQ1hJQUVmaU5IVjFmbEl6UmZIdWg4UkU5WDhPbDc0NTNwU29r?=
 =?utf-8?B?SXN3aDQ0cGRCaHJJWU1VWFdhMWpvdXlpcHVMZ0t6Sk4xazVtZnUwSzFBWGtG?=
 =?utf-8?B?TGwwTnRXTjNsOXhzMEVDMVEzazgvRFhYYy9tQTVUTDNMWERFVEhobkZtQzlt?=
 =?utf-8?B?Q1pBM1pQdjBHQis0eTVvRzBNa0lCUnl6RlUyUk1PZlh4dG9TV21ZRWtpUzJW?=
 =?utf-8?B?KzRKVGdQVnRha3hZeXRjdlR1VG9OdHUrMXNIUFdwcG9RMmN2N3ljZmt5aXJ4?=
 =?utf-8?B?cm5pTHJISkFNNGhQdktNcVVNc1krMnpORkcrelh4RVhPUGRIK3lQZjRYdTll?=
 =?utf-8?B?SG1vSlpOMi9VK2R3NnZCYTNqZVlWYU9SSDZzbHltVFQxbFduUnVubTArVFdH?=
 =?utf-8?B?VVNVNkJpTVJRYlBQdnBXR2ovV2xHMkwrQ0NNbTZ6TkJ3emlZVzE4Tk1aYVlH?=
 =?utf-8?B?QlQvaHBFaGRhUjNLT1ZsL2E3Yi9UMHlmd0hoL3pHZG9mUUlUWWNlKzFJQnBG?=
 =?utf-8?B?NlhSV0hFM3R6akY2K1QwYjNtOTdvWnFuWVRxZkQ3WDZ5R3VsVWN3OEZSWjk5?=
 =?utf-8?B?aHEyNkZUM3FaUmh0c2xmdFZzYW9rMFA2UXlDcWc2dFVzU1ZqckFDVElRS001?=
 =?utf-8?B?ZlZrUlAzbklVS00zZlVQUzdrNEQxSGpneVk4WmNDWENBMlZCWWFjWXJsUDdn?=
 =?utf-8?B?aFgrSzZnMDZENFpFVEpMaTVFTXprWnA2TWsrdmtybVFQUEEwY2FITEZqVnZl?=
 =?utf-8?B?UzRVcHdKRHBCTHdFM1JDYzRaSHNrT3VKRlVxSUt1by94QVZYdmxwNGhUUnpQ?=
 =?utf-8?B?Zzh3N1Z0YUJPSXZVdXFrUTJBZFBWTkorOG84SktGdnJiVkxTQzNCS29RZ00w?=
 =?utf-8?B?R3paRGE5SDRncEdPOHhwalBvcTVIV0FBTis5UmlSdmVZTmorZ1ZmNTlLWWZ6?=
 =?utf-8?B?U3dZekJvelZSZ2dXMHBPbWI4RTVqY3EyR2g3SW81WW1ja2x4TWc2cnloNDcw?=
 =?utf-8?B?QnF1VWN4TGdZVWtIT2pURFVEV3RxSVdlYVdmN1JqRUU0eGgrbHlJdm85ZEdm?=
 =?utf-8?B?MVZhVjJwSGd2QkRQWllqaDAyTTZWSHFIYkVIbHdneWtOU2I4Uk0wdmwxc3Fz?=
 =?utf-8?B?Tm5wN2FwQVc4YjFBLzRwdmhiK001cWlzOEcxQXp0Mmthdk1FaXJuVkUwMk1E?=
 =?utf-8?B?Z2VyaXRSZmFjTStEWVNTdGxRQ1NOMVZoNk4zSFZKTmMrbG5Zbys2NTlicXlR?=
 =?utf-8?B?M2JraHNKUzZ6NWFWbUNEQVBvQmVySEZkUmJDOWlka21tekk2d2dkMEhrcks5?=
 =?utf-8?B?VGtyaldTL0JpUGdKSmJYQSs3TVFha0NCMGc5SVNGdUpaM0dEa3d4amZMd0JM?=
 =?utf-8?B?UFAybklndHBlaXE1TnVqYUtCQ2FseEtVMDZTWUlKblViaUREQmVic3V6RkQv?=
 =?utf-8?B?RmM3VzZ2andIeEhhM2tHOWpkaTlpU2xtNG1TQWJ6eVNDZzgxZEtzVzgvek4r?=
 =?utf-8?B?OVBwMkNLNHRxMnF1ZmVKcGEyMzV3RmJjcEZldUtpNTB2cS83WlFzYzkzSHE2?=
 =?utf-8?B?WTVIRHExaFZrR2JobWRyWlRHeFVMSy9OWXExMXdZU1JIRGFLRWxqNDlWT1RO?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dyDXTyRmHlIjQhB2iFpAkrZ+BMnaw5c5PgDgdjLXUZD3p3DrtZEwT4sToCxWRCcynnUnb5bLpeKIjix4GrPp4QSdOGrX3SFZQSvpih8gixOUc3+TbQwRwGGX3STqLCkIaCmjteK0E5nK6m6rvB2h7bTXBFoe27hwNtcS+PgW7KxeMvKdNFFfBCvk8r4SXBLxj6g1pYsukpSbN4dXoo2ipbh8eCYfhJooJKB63DJRsoox2aKRPHEhPMd8rxP0oy93d82izQHfp3P68xC40+KUK3gNz2veQ78WWDTWoRgVn2/q9qbHQCJhZM5zb56vmLKyt6uAhpzAJ0LPW+jfXvUqvwQcrL33WR17auwfk0yW/hZB7u4mTxBCnQ/xJ8sABbo72V0LoqONXPxal6eonAdBUqehEFgdIqwyFz2EtLnjls4Pa7hslvsB9mN1eaAZlBm4fg+p+RCtpnv1QZth+d+obvZqx7+oaIeXO9Ux10S1BnddaiiNYjYMrGsmBn7IGGjEdypCqFciV0LSN1oFHCoIrgtQUhVXaWvHbND3eJiogOkrWhvrJMApeG/3b9pzgJ0Q9sIJ7oQB8KCP+OYHwp+Q7TuG7b+wbztxtPn0FkWIoy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184e3908-16b3-478d-e72d-08dd5b4f8e45
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 19:05:40.5767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQwLyoorwYMsnmmJllp+igjCP0KJSq3BTJ5AqyB6ILIWDY1advHrB/U9Sur5ofd032CJIZEDCeWldGyOcTZjUhfJSNFVYZoav+sw0te5gbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040153
X-Proofpoint-ORIG-GUID: _FxeXppMdl8641gBluRpkzzSxIYDarG7
X-Proofpoint-GUID: _FxeXppMdl8641gBluRpkzzSxIYDarG7
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

--------------vSml007D2fnq5GFJsrQHCM7t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>> Hi all,
>>>>>
>>>>> We've been experimenting with cpr-transfer migration mode recently and
>>>>> have discovered the following issue with the guest QXL driver:
>>>>>
>>>>> Run migration source:
>>>>>> EMULATOR=/path/to/emulator
>>>>>> ROOTFS=/path/to/image
>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>
>>>>>> $EMULATOR -enable-kvm \
>>>>>>       -machine q35 \
>>>>>>       -cpu host -smp 2 -m 2G \
>>>>>>       -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>> ram0,share=on\
>>>>>>       -machine memory-backend=ram0 \
>>>>>>       -machine aux-ram-share=on \
>>>>>>       -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>       -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>       -nographic \
>>>>>>       -device qxl-vga
>>>>>
>>>>> Run migration target:
>>>>>> EMULATOR=/path/to/emulator
>>>>>> ROOTFS=/path/to/image
>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>> $EMULATOR -enable-kvm \
>>>>>>       -machine q35 \
>>>>>>       -cpu host -smp 2 -m 2G \
>>>>>>       -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/
>>>>>> ram0,share=on\
>>>>>>       -machine memory-backend=ram0 \
>>>>>>       -machine aux-ram-share=on \
>>>>>>       -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>       -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>       -nographic \
>>>>>>       -device qxl-vga \
>>>>>>       -incoming tcp:0:44444 \
>>>>>>       -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>
>>>>>
>>>>> Launch the migration:
>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>
>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>       migrate-set-parameters mode=cpr-transfer
>>>>>>       migrate channels=[{"channel-type":"main","addr":
>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>> {"channel-type":"cpr","addr":
>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>> dst.sock"}}]
>>>>>> EOF
>>>>>
>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>> following messages:
>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>> 0x00000001)
>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>> allocate VRAM BO
>>>>>
>>>>> That seems to be a known kernel QXL driver bug:
>>>>>
>>>>> https://lore.kernel.org/all/20220907094423.93581-1-min_halo@163.com/T/
>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>
>>>>> (the latter discussion contains that reproduce script which speeds up
>>>>> the crash in the guest):
>>>>>> #!/bin/bash
>>>>>>
>>>>>> chvt 3
>>>>>>
>>>>>> for j in $(seq 80); do
>>>>>>           echo "$(date) starting round $j"
>>>>>>           if [ "$(journalctl --boot | grep "failed to allocate VRAM
>>>>>> BO")" != "" ]; then
>>>>>>                   echo "bug was reproduced after $j tries"
>>>>>>                   exit 1
>>>>>>           fi
>>>>>>           for i in $(seq 100); do
>>>>>>                   dmesg > /dev/tty3
>>>>>>           done
>>>>>> done
>>>>>>
>>>>>> echo "bug could not be reproduced"
>>>>>> exit 0
>>>>>
>>>>> The bug itself seems to remain unfixed, as I was able to reproduce that
>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>> without the cpr-transfer migration the above reproduce doesn't lead to
>>>>> crash on the source VM.
>>>>>
>>>>> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
>>>>> rather passes it through the memory backend object, our code might
>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>> corruption so far.
>>>>>
>>>>> Could somebody help the investigation and take a look into this?  Any
>>>>> suggestions would be appreciated.  Thanks!
>>>>
>>>> Possibly some memory region created by qxl is not being preserved.
>>>> Try adding these traces to see what is preserved:
>>>>
>>>> -trace enable='*cpr*'
>>>> -trace enable='*ram_alloc*'
>>>
>>> Also try adding this patch to see if it flags any ram blocks as not
>>> compatible with cpr.  A message is printed at migration start time.
>>>    https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-email-
>>> steven.sistare@oracle.com/
>>>
>>> - Steve
>>>
>>
>> With the traces enabled + the "migration: ram block cpr blockers" patch
>> applied:
>>
>> Source:
>>> cpr_find_fd pc.bios, id 0 returns -1
>>> cpr_save_fd pc.bios, id 0, fd 22
>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host 0x7fec18e00000
>>> cpr_find_fd pc.rom, id 0 returns -1
>>> cpr_save_fd pc.rom, id 0, fd 23
>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host 0x7fec18c00000
>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size 262144 fd 24 host 0x7fec18a00000
>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size 67108864 fd 25 host 0x7feb77e00000
>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192 fd 27 host 0x7fec18800000
>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size 67108864 fd 28 host 0x7feb73c00000
>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536 fd 34 host 0x7fec18600000
>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size 2097152 fd 35 host 0x7fec18200000
>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536 fd 36 host 0x7feb8b600000
>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd 37 host 0x7feb8b400000
>>>
>>> cpr_state_save cpr-transfer mode
>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>
>> Target:
>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>> cpr_state_load cpr-transfer mode
>>> cpr_find_fd pc.bios, id 0 returns 20
>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host 0x7fcdc9800000
>>> cpr_find_fd pc.rom, id 0 returns 19
>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host 0x7fcdc9600000
>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size 262144 fd 18 host 0x7fcdc9400000
>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size 67108864 fd 17 host 0x7fcd27e00000
>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192 fd 16 host 0x7fcdc9200000
>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size 67108864 fd 15 host 0x7fcd23c00000
>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536 fd 14 host 0x7fcdc8800000
>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size 2097152 fd 13 host 0x7fcdc8400000
>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536 fd 11 host 0x7fcdc8200000
>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd 10 host 0x7fcd3be00000
>>
>> Looks like both vga.vram and qxl.vram are being preserved (with the same
>> addresses), and no incompatible ram blocks are found during migration.
> 
> Sorry, addressed are not the same, of course.  However corresponding ram
> blocks do seem to be preserved and initialized.

So far, I have not reproduced the guest driver failure.

However, I have isolated places where new QEMU improperly writes to
the qxl memory regions prior to starting the guest, by mmap'ing them
readonly after cpr:

   qemu_ram_alloc_internal()
     if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
         ram_flags |= RAM_READONLY;
     new_block = qemu_ram_alloc_from_fd(...)

I have attached a draft fix; try it and let me know.
My console window looks fine before and after cpr, using
-vnc $hostip:0 -vga qxl

- Steve

--------------vSml007D2fnq5GFJsrQHCM7t
Content-Type: text/plain; charset=UTF-8;
 name="0001-hw-qxl-cpr-support-preliminary.patch"
Content-Disposition: attachment;
 filename="0001-hw-qxl-cpr-support-preliminary.patch"
Content-Transfer-Encoding: base64

RnJvbSBlYTQ0OGQzN2I4NDViZTFlM2QwMmRlZjc4OGZhOTFlMzVkZGZmNDliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUdWUsIDQgTWFyIDIwMjUgMTA6NDc6NDAgLTA4MDAKU3ViamVjdDogW1BBVENI
XSBody9xeGw6IGNwciBzdXBwb3J0IChwcmVsaW1pbmFyeSkKCkR1cmluZyBub3JtYWwgbWlncmF0
aW9uLCBuZXcgUUVNVSBjcmVhdGVzIGFuZCBpbml0aWFsaXplcyBxeGwgcmFtIGFuZCByb20KbWVt
b3J5IHJlZ2lvbnMsIHRoZW4gbG9hZHMgdGhlIHByZXNlcnZlZCBjb250ZW50cyBvZiB0aG9zZSBy
ZWdpb25zIGZyb20Kdm1zdGF0ZS4KCkR1cmluZyBDUFIsIHRoZSBtZW1vcnkgcmVnaW9ucyBhcmUg
cHJlc2VydmVkIGluIHBsYWNlLCB0aGVuIG5ldyBRRU1VIHVzZXMKdGhvc2UgcmVnaW9ucywgYnV0
IHJlLWluaXRpYWxpemVzIHRoZW0sIHdoaWNoIGlzIHdyb25nLiAgU3VwcHJlc3Mgd3JpdGVzCnRv
IHRoZSBxeGwgbWVtb3J5IHJlZ2lvbnMgZHVyaW5nIENQUiBsb2FkLgoKU2lnbmVkLW9mZi1ieTog
U3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KLS0tCiBody9kaXNwbGF5
L3F4bC5jIHwgMTYgKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvZGlzcGxheS9xeGwuYyBiL2h3
L2Rpc3BsYXkvcXhsLmMKaW5kZXggMmVmZGM3Ny4uNzBmN2YxNSAxMDA2NDQKLS0tIGEvaHcvZGlz
cGxheS9xeGwuYworKysgYi9ody9kaXNwbGF5L3F4bC5jCkBAIC0zMCw2ICszMCw3IEBACiAjaW5j
bHVkZSAicWVtdS9tb2R1bGUuaCIKICNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCIKICNp
bmNsdWRlICJzeXN0ZW0vcnVuc3RhdGUuaCIKKyNpbmNsdWRlICJtaWdyYXRpb24vY3ByLmgiCiAj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIKICNpbmNsdWRlICJ0cmFjZS5oIgogCkBAIC0z
MzMsNiArMzM0LDEwIEBAIHN0YXRpYyB2b2lkIGluaXRfcXhsX3JvbShQQ0lRWExEZXZpY2UgKmQp
CiAgICAgdWludDMyX3QgZmI7CiAgICAgaW50IGksIG47CiAKKyAgICBpZiAoY3ByX2dldF9pbmNv
bWluZ19tb2RlKCkgIT0gTUlHX01PREVfTk9ORSkgeworICAgICAgICBnb3RvIHNraXBfaW5pdDsK
KyAgICB9CisKICAgICBtZW1zZXQocm9tLCAwLCBkLT5yb21fc2l6ZSk7CiAKICAgICByb20tPm1h
Z2ljICAgICAgICAgPSBjcHVfdG9fbGUzMihRWExfUk9NX01BR0lDKTsKQEAgLTM5MCw2ICszOTUs
NyBAQCBzdGF0aWMgdm9pZCBpbml0X3F4bF9yb20oUENJUVhMRGV2aWNlICpkKQogICAgICAgICAg
ICAgc2l6ZW9mKHJvbS0+Y2xpZW50X21vbml0b3JzX2NvbmZpZykpOwogICAgIH0KIAorc2tpcF9p
bml0OgogICAgIGQtPnNoYWRvd19yb20gPSAqcm9tOwogICAgIGQtPnJvbSAgICAgICAgPSByb207
CiAgICAgZC0+bW9kZXMgICAgICA9IG1vZGVzOwpAQCAtNTM5LDcgKzU0NSw5IEBAIHN0YXRpYyB2
b2lkIGludGVyZmFjZV9zZXRfY29tcHJlc3Npb25fbGV2ZWwoUVhMSW5zdGFuY2UgKnNpbiwgaW50
IGxldmVsKQogCiAgICAgdHJhY2VfcXhsX2ludGVyZmFjZV9zZXRfY29tcHJlc3Npb25fbGV2ZWwo
cXhsLT5pZCwgbGV2ZWwpOwogICAgIHF4bC0+c2hhZG93X3JvbS5jb21wcmVzc2lvbl9sZXZlbCA9
IGNwdV90b19sZTMyKGxldmVsKTsKLSAgICBxeGwtPnJvbS0+Y29tcHJlc3Npb25fbGV2ZWwgPSBj
cHVfdG9fbGUzMihsZXZlbCk7CisgICAgaWYgKGNwcl9nZXRfaW5jb21pbmdfbW9kZSgpID09IE1J
R19NT0RFX05PTkUpIHsKKyAgICAgICAgcXhsLT5yb20tPmNvbXByZXNzaW9uX2xldmVsID0gY3B1
X3RvX2xlMzIobGV2ZWwpOworICAgIH0KICAgICBxeGxfcm9tX3NldF9kaXJ0eShxeGwpOwogfQog
CkBAIC0xMjQ1LDcgKzEyNTMsNyBAQCBzdGF0aWMgdm9pZCBxeGxfaGFyZF9yZXNldChQQ0lRWExE
ZXZpY2UgKmQsIGludCBsb2Fkdm0pCiAgICAgLyogcHJlIGxvYWR2bSByZXNldCBtdXN0IG5vdCB0
b3VjaCBRWExSYW0uICBUaGlzIGxpdmVzIGluCiAgICAgICogZGV2aWNlIG1lbW9yeSwgaXMgbWln
cmF0ZWQgdG9nZXRoZXIgd2l0aCBSQU0gYW5kIHRodXMKICAgICAgKiBhbHJlYWR5IGxvYWRlZCBh
dCB0aGlzIHBvaW50ICovCi0gICAgaWYgKCFsb2Fkdm0pIHsKKyAgICBpZiAoIWxvYWR2bSAmJiBj
cHJfZ2V0X2luY29taW5nX21vZGUoKSA9PSBNSUdfTU9ERV9OT05FKSB7CiAgICAgICAgIHF4bF9y
ZXNldF9zdGF0ZShkKTsKICAgICB9CiAgICAgcWVtdV9zcGljZV9jcmVhdGVfaG9zdF9tZW1zbG90
KCZkLT5zc2QpOwpAQCAtMjIwNiw3ICsyMjE0LDkgQEAgc3RhdGljIHZvaWQgcXhsX3JlYWxpemVf
Y29tbW9uKFBDSVFYTERldmljZSAqcXhsLCBFcnJvciAqKmVycnApCiAKICAgICBxeGwtPnVwZGF0
ZV9pcnEgPSBxZW11X2JoX25ld19ndWFyZGVkKHF4bF91cGRhdGVfaXJxX2JoLCBxeGwsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmREVWSUNFKHF4bCktPm1lbV9y
ZWVudHJhbmN5X2d1YXJkKTsKLSAgICBxeGxfcmVzZXRfc3RhdGUocXhsKTsKKyAgICBpZiAoY3By
X2dldF9pbmNvbWluZ19tb2RlKCkgPT0gTUlHX01PREVfTk9ORSkgeworICAgICAgICBxeGxfcmVz
ZXRfc3RhdGUocXhsKTsKKyAgICB9CiAKICAgICBxeGwtPnVwZGF0ZV9hcmVhX2JoID0gcWVtdV9i
aF9uZXdfZ3VhcmRlZChxeGxfcmVuZGVyX3VwZGF0ZV9hcmVhX2JoLCBxeGwsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJkRFVklDRShxeGwpLT5tZW1fcmVl
bnRyYW5jeV9ndWFyZCk7Ci0tIAoxLjguMy4xCgo=

--------------vSml007D2fnq5GFJsrQHCM7t--

