Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D19C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KfG-0007Go-Jw; Mon, 14 Apr 2025 10:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u4Kf9-0007GN-Tq
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:19:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u4Kf7-0004Q9-Lb
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:19:51 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ED6iZn001469;
 Mon, 14 Apr 2025 14:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/E6MoY7Ujwood5zMFv94ToPb1toNAY6is4rSkHqX69s=; b=
 Db0ZGKc1hN0iq7Kp4KpwNbRGcI+u4vxqBxhARlURlScCrSBKrqUHI9halbefrZ1F
 cejEHBwU0S1SjfunCPnfzB0j+n12/aA2knUGqt3mbVRHVftTXXEdJTfKvbHiBq5o
 t1oiEhi0FDQSSoH1a9gBdffHzkUmHikcuWvybj+i4uy4JG3zLsUUnaW9gi9RbNph
 agW4S5EPVwRy2ooVFhT5ZrH2Vh64+uXlPfFNNdXH080R2h3yHxZXNAagjV39Sb/6
 B4T5RzM/pd8oJ1rM45Rz7eB7m0Eqv7cxIq3xsYztf2XDuDC92t3yBMoJBxDlqStK
 Gyv0eNPB2fWKRKrByTrEvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4612y605eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 14:14:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53ECZ7HD008691; Mon, 14 Apr 2025 14:14:35 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460d2nk32w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 14:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmpHshgQrpxYlBqZ5nc+PUJTm4oKny6LGl9UgQ4fCRTaqOA5V3mmThHb7gAV0YPyTWd0qlnW0Qo1kIhvwE/761xFPXsUfdQ/SnosCI35zuY6i8bD5OFTlSnjLAKXsLCgHIFARoBRRfqNudAm1kiUZhirq4jIRgoilzccHeCo+AE1CBNru/a00LyDSGAXAcRgpr2gxR81tmz+QJOs3oS/yKzBC3mTm8AsSlr7DRp3i8H5pjMo2NVuHqvNQMlduxzNE4cOmqqmpQuYrrM0VVuHJFR7SN4ygwiV//KKAmKlH1s3W4YyVHoGzJyJMYQVQNdG4wbcLE0fY4PTiWj3EUA9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E6MoY7Ujwood5zMFv94ToPb1toNAY6is4rSkHqX69s=;
 b=MLHqNThPQCy0+0uoOgsftjH3kHhFrXa70Y36VKfTAtQF1WE40QFD+Hcx+x8enfrVg4I8+Bk2RQkcVcEzVQ90cjLINnujGAUzxD6EgXl1FipdlI37KRxZCJszYa69TSPvB2vNYhQWlOEfCy43Rv7FMJotE5s5ZX0yJzD/6uDvZwbrxKXzW5ss6/ocxHRNTKYG786CPfEu8APj2FuI3Knz97LkHJ7pju+2UBMwm8efkdhitijA6T2wt9dy4RN9YaWTLEyIXPPmwRC9L5bgvSrJJnRmj7zK69yorVfi0WtSo7SUmqIcozpDM13g0IawHHlFeju9LA5mNuBOfIwtsEipmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E6MoY7Ujwood5zMFv94ToPb1toNAY6is4rSkHqX69s=;
 b=KUx5HkVXZta3lNVkCroRT25Se7iBovABEu3jBfeUCDEz5F5TSQ0ivOf1mxKtoGEEqNgYqPJ+olJT/iHdH9SlaEtooSwe0J9FuxXoJiWs3/GX7HiwC/b3sxm1wriIaEWcikDWYmGYxRiNEZW0a4QMdfF2XUSlvc/j+I+N4cXSbUk=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by PH7PR10MB6601.namprd10.prod.outlook.com (2603:10b6:510:205::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 14:14:32 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:14:32 +0000
Message-ID: <d2b18212-495a-469f-8c6b-50f0cf54dc96@oracle.com>
Date: Mon, 14 Apr 2025 10:14:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 13/13] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204517.3043-1-annie.li@oracle.com> <875xj71cg1.fsf@pond.sub.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <875xj71cg1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|PH7PR10MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: e22a54e0-bb1e-4dc5-3652-08dd7b5ead97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE45ajg0Q0hkdU52L3g0QWJ1UDRudDdHcDQrNkZQdTl0ODJMMUtVOXh0VnI4?=
 =?utf-8?B?QUpMRnpBRzJuZkIrUnEvOGxUSFNPdWkrR3dJVVVHSnVPNzQ1d21XOEgwTWw1?=
 =?utf-8?B?N05wQi9YZkp6N2pBOUl0QWFGUzRMWkRBd1VSVlB0cUhIU3VzaUtHYWV0ZHN6?=
 =?utf-8?B?WVlQVVRPdWh0Slo2VFZSazVmZmFveVhwYkU3ZGordUZyMlNJM21SZmk1Vlo5?=
 =?utf-8?B?N0NQWEFwV0dtRGNERU81cXRmTTV3UmREWmorYm4xOTF1VkVFbFlzN09iWFJU?=
 =?utf-8?B?Wm9IbmswdnFaSllUN2YxdEFpTUNXYmJnSENHZkxzaEhJYmRLRDNHM1ZjSnlz?=
 =?utf-8?B?YnU3dWt2NFNDSW50NTNqN1libGVnZ3ErWUlaSmhDSmxkWFdDT3ZKbmxPTGVU?=
 =?utf-8?B?SUNibTZId2NGai9rcVhkdXYwcjcxWVRKSUgxUE5sUFFrckxxOThOK05jZHVT?=
 =?utf-8?B?NTZmUG5IZTJlSFR4K1ZHRDhzSFNkK1BnVWJSNzRPQ0xNam9jZk9GWjR0dGlD?=
 =?utf-8?B?MUkzYkF3enlwcUFOVHpaQ216eFhnbnhEYWFSWld5dUpJM3h2MUJxUVFoWlpC?=
 =?utf-8?B?S1JUUnoxaFpVOExrWCtyTHlEazcrMmt1OW8xY2F2MlR6NTRxeitnUVVQSU9y?=
 =?utf-8?B?UHNZLzBFMlpkdUMxTGM3bWpXYVlyeGMxbS9QRWRyVXBDdnVvcDcyNmcvSnNn?=
 =?utf-8?B?c0toSng4TmU1bHJXUmluZnZOdXlSUjVLd2lEV0FSNlVPK2hsa2YycFpCdC9s?=
 =?utf-8?B?ckpFdHhRNXN5T1V4SUFLVkV1SVYzYmtYTWMrdWpwbUdJcVNMOTRUSUg1RXFv?=
 =?utf-8?B?TFRyOU9OQVdQZUFiUzZCTDF6VUJVYUJkTFcxbWNrZzdaa054d3BQcXRZSmMz?=
 =?utf-8?B?aXJTaWp4YzhPUEs0M2ZqTFNCZW0yL0J3Ris3WVhUNVFrS202RytDYmZBQndn?=
 =?utf-8?B?NVJ0NW01cTVGMGNXWldMN2hIQU83V0grbGFMME1sTnJ4ZS9QUGNWODM1RHVa?=
 =?utf-8?B?MGdkZlJhaTV3dXBmbzNueFdoMFU0VGQ2aklYZlpTY3ZTVkh4clJ2TVNtbFo3?=
 =?utf-8?B?MXI2N3Q4Z2ptcHdqWHRTZ0NId3R0QzFlb1NNeU9IL2pDVXJVMy9XWUhFUmtB?=
 =?utf-8?B?TTRzQ2NUcVZpMlJPWDNCbnV0N0xXR2xjeFJiMk1MOEpXN2RBNkpiU2toVG5z?=
 =?utf-8?B?SjlKell1YnIvVnpTM2ZBak9xV21zRTV4d0Y4bzNKanZ0MTVEYnNuQUp6OFVS?=
 =?utf-8?B?UUpZM2djdEVTU01NZ014MVNueHBsR29UNDFPcmFxRGxQclYyOU56MkZEdmdw?=
 =?utf-8?B?TFBxV0ZkYktDenhCaHhaaG9LeXF1TzQrQ2ZITk5Yc0E5WXBaQXdrMDZmNEtF?=
 =?utf-8?B?dExld1JEM2NId0dIMTZydSs3ZWN5cG16S00remptVXQyK0Y3M2NYaFVIdjgr?=
 =?utf-8?B?Ry83Q3V3TmdibENwZElybGJkd0pjUTMyeTZjdFkwL2w2bTNtaDV1b3dCMjlQ?=
 =?utf-8?B?RDRraUFvUDNnZStuWStvam0xOUVLMUZDS0tRZ1FGV1Fud3pIQlhtcE83dmpo?=
 =?utf-8?B?cUk1OVgwekIxa3JXUHVaejZrK2pPd2dmZE94bk5IVzlEaUc5d0diSDZqS211?=
 =?utf-8?B?eXBiRDBJWmxuVzV3Z2puVjNya1JoRThZS2tKMGgvTlpDcVlUc1ZCdk5TQ3Nl?=
 =?utf-8?B?MlAwdyszZ2Y2Szg5SERLM3lkZ2g5M1pMc0VSczI3WUFnV1o5K2JPLzh3Y0xX?=
 =?utf-8?B?bGV5anlTNEF1TDIwT0Vtb1BuRVpHR09iNU9BN0sySWVJcXhEakpUdUdndm1Z?=
 =?utf-8?B?RkRLYzJ1YnZGSUIzemRvcVo0dWtkTzRSay9Wemo2cEh1c3gvanRiUURiSkZQ?=
 =?utf-8?B?WTYxTElyblZDdjJSWGdiVFFTTXJnU1pZcG5pUHJlYUlkc1JsekIrQSttK3R1?=
 =?utf-8?Q?EmK0o+Zqlls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBFakRaNEdIQ3RCLzJMSS82c3RQZ1prNjBYMWZqSFVMRmNXaUJMU0x0Y3Rq?=
 =?utf-8?B?UWRSeG1OSUpRZkdNaWZ5aDJmTmoxZWRkK1pBVW9Hb2lGZVQ2Z0hINWlJZTZh?=
 =?utf-8?B?R0NWaVBSbXRYVjNKQUc2dU1QcDEwSWl3Y05xR0JMSzNhcGxZOXpGY2tHWDN4?=
 =?utf-8?B?aTNOUEVuVThGQVRkbEQzWVp6M3VKQTB0bGxIdVJaVFpVQTViMmt5cG9Xazd0?=
 =?utf-8?B?Rmx1cVlrTStiRDU1RVU5Z2w5SFBoUFB1WGhhTjc0OVNKSWxDbitNWGNUVXFv?=
 =?utf-8?B?VGlaQkJHSlUrbGJmdTNwQmtKK3VBd01mWlpxSE9CYXJrSXIzZXEwYUhvVnZP?=
 =?utf-8?B?Zm10YUNqcjJRRmZHVzZOb0NCUG5pNjhoY21qcUhYU29hV3hyZlcwNkdqSmIr?=
 =?utf-8?B?UUpTeDZ3NkVkV3ZlK3JOSWZGYXlpamtMNmdiVlBFRk9PQ0RxeFVEU1ZqUG9R?=
 =?utf-8?B?aG85M1NqT24zWEsrd214cFh6N0FhR2tjcXYwRE1LeEVtakJwejJJNVVkZHVV?=
 =?utf-8?B?NWc3QmN2aExoWVBEM01hVVUxWUNKbFdTV2FnbjBFOWpQOHhkanhoYzZyajU0?=
 =?utf-8?B?MGo1djZHOTl0T1c3Qy93VGxMaGlGbUlUNWI2YkhpSkZqS2FVajFrblJiTHJk?=
 =?utf-8?B?K0cvTDVLRTNIOExTZzZha1U2SGhDc3VzVU50WmFPYXBKS21kYUpPbWt4TDIx?=
 =?utf-8?B?MkN2NE5GR3B2Y3dFczRXUXVKLzV4MS9Fc2dCbXhRbXI1SnQzRytDS3A1dmV4?=
 =?utf-8?B?NEJEWTNDRVhVVkw0L2hYTE9Ra0paRElKcWdnb0xPTEwrdjJiVElvRXBxRHhK?=
 =?utf-8?B?dkM3dlkrdVEyQlFEaWoyWXlsMWJZd05GQmNzZHRGaWEwYUJkNkJrZVg0ZkFp?=
 =?utf-8?B?VEpPQjFCS2puTHNRVTQxNTVHVGYxV0pPckZ4bVMxMjlCbTNZamhrd3Z3S0Rp?=
 =?utf-8?B?Nk9qVmJIOVd4aC9qNUw3NGt2aHIxbXhKR0YzbjM4NGZtdUpvRllFRHd3SHg1?=
 =?utf-8?B?OEdJN3I0MXZVZ2pGVCtFU1gzaWpnSjhWTVhEWEx0TTdQRFNrQWk2em1qWEFq?=
 =?utf-8?B?S2VxWjJ6SXJURnpOdkExQkFLaHRpWnc0TFhzWkl1QnU3YXlZc2MraThkaVVV?=
 =?utf-8?B?UnJCdTMzWllPY0syZmh3UmUrNWIvRHdGT1pFUDRtRjVRQzI4ZFk1SXFHMlJi?=
 =?utf-8?B?OWN2ZXFLQW9neTZqeGkrN0VId29MN3YyUjdhVHFWV2tpbTVsSnBJVjMzY081?=
 =?utf-8?B?T1JnSitzZXZoWHpJbUp3LzZ4dC9ZWXkxQTNmU2JGMytSQnlNbXJsSk5LTjZk?=
 =?utf-8?B?dSs0MGZIaTRrdFN2c2FGSzI4djJhUXpwZVF6SzJPWlFZYzVmVi9lc21CanJ1?=
 =?utf-8?B?bVBSWWFqeE9BZ0xJVDVpSDJFSnp5ZHFsc3FIL2hXUkM0c1pvS2owU0xPdXN5?=
 =?utf-8?B?RlJpWndaZWo5S0JTa1k2Mk9BUFpaQy9tam9NbGxiOVQwcWRpZFk1TlovUjNs?=
 =?utf-8?B?RXpjeEFKMExaQUwrVWtzd0ttdnZuRXZSV2VoTW1qOWNtc3VPbHFIL1pNbThS?=
 =?utf-8?B?Y28rZzUzV3RWa3VRWVBxSnBnbVRNYWZmSXB0ZzA0di9NMmtUUFJpalArZ3VL?=
 =?utf-8?B?c0pGdEtPOVBXaG9MSHl5MXQwY0hYWXRYczNlaDM4MlZsa2htZ0VHbXdQVmkz?=
 =?utf-8?B?SVQvYitCOU9JYUszVVJYR2NNUDJ3WlFMaTdzRnloNDB5RHY2N2dNVUlQN0RU?=
 =?utf-8?B?MmJhOHFHYnpWWUJmQXpuRkkrOVh3dDBKRzVWRVlHdmFBRDRybnZyU0lmMzBL?=
 =?utf-8?B?eEFPMjdJd3JxOU1wcnRpeGU4eGp5Q1pBeFlJRGlFK2c1Z1dTY2UxZ1hUOEg1?=
 =?utf-8?B?dTFrYWk2QWZOWVNxaXpWMGdLQXZRV2FJQzBlSmdGZEVYNUxDTTZqL0pjSWJH?=
 =?utf-8?B?TmxQbXRSYkxzWkhrMVV2bjFreFMwdGY5cXFocWx0ckV5S3p5czB2clZxSTha?=
 =?utf-8?B?TmdYVXFZYUxKZ01BWlR6bjZaVDFhWXBpa2lobldydys2aElkd3o2NG9yN1Ar?=
 =?utf-8?B?MGtYYmtYTEtrZWRjZzJrWnNLZkx2Vzk0NG5CTm5PS3hSQmp1SUxndzVuQi8z?=
 =?utf-8?Q?K7bqgfZzLPnVm5ufn4D08hGsd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TJAVM5HHyfsN0SlFkyBNbboTSn293c0uRZzUp5l6H/ZRwLf3/9sb1HaAck8WVpbpzNaT0LWv5/QXlcPzJT2G91E9AO93KOO/dOj0TfEPwaaJWhyra4oTVYBTKVZbRZxXWcanW2FpGfOUl7fmCgacrFEY+v6qaTUJRSp6Jnfr5qdpDnxtklLyFjczk38lgNwziNqXWMhiH2BdeS9XjF0/NMewU9h1YpIJNAVAMd9RaW0JdzQ2DEyaNCHBg/xuG0YI4jseBcGV906+YWD7/WA2G5AqkeIz3RIiKYnRYL1hrnG2oFohTZxFvBGNn0JNAqZfUEuyLkWYUhDcaBbs1W/16pYIb0hIT5y+/IhohhINs+E3YuSVkuIY1ZvxzyHot8pZhY/7REPvFZ7qlsYb6m0cEWzk5/uLSLbeJuK87AYrPAu7TdhwqFfeLTRslNUfAgL4uY6EIdmnlJeD8/ufPymFwZmaGa3jJdEcq8xFvcbfn9r5bo19RJ3cVItYpNKYq24RoDMqP7hkv3wImWgHLyhU9lJ/HrEPgP8++s5aULgUd/cMkVWxztBK1d4aTv3hqdW4wm9gXqmN+5KKF2ptW2W1UAygRbvmmmMCmJyIceOi/zo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a54e0-bb1e-4dc5-3652-08dd7b5ead97
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 14:14:32.7953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96zi5wpo3GjZOTolvMKD2iyjbBSI6B7OsNnSj7qbclFJb7DelvGE+AeIprWba6MZjm0XTldIHxYR3/PfoYXXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140103
X-Proofpoint-GUID: QQ1CGcvyCU55sVycpLWOEj8uH4V_OR95
X-Proofpoint-ORIG-GUID: QQ1CGcvyCU55sVycpLWOEj8uH4V_OR95
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/14/2025 2:31 AM, Markus Armbruster wrote:
> Annie Li <annie.li@oracle.com> writes:
>
>> Followng hmp/qmp commands are implemented for pressing virtual
>> sleep button,
>>
>> hmp: system_sleep
>> qmp: { "execute": "system_sleep" }
>>
>> These commands put the guest into suspend or other power states
>> depending on the power settings inside the guest.
>>
>> These hmp/qmp command are in '*_*' format, it is intended to do
>> so to align to existing 'system_*' commands.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
> [...]
>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09..0965e78f4e 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -361,6 +361,26 @@
>>   ##
>>   { 'command': 'system_reset' }
>>   
>> +##
>> +# @system_sleep:
>> +#
>> +# Requests that the guest perform a ACPI sleep transition by pushing
>> +# the virtual sleep button.
>> +#
>> +# Since:10.0
>> +#
>> +# .. note:: A guest may or may not respond to this command. This
> Two spaces between sentences for consistency, please.

Didn't notice this, thanks for pointing it out.

Will fix it.

Thanks

Annie

>
>> +#        command returning does not indicate that a guest has
>> +#        accepted the request or that it has gone to sleep.
>> +#
>> +# .. qmp-example::
>> +#
>> +# -> { "execute": "system_sleep" }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'system_sleep' }
>> +
>>   ##
>>   # @system_powerdown:
>>   #
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index 023a2ef7bc..285ce82e9b 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -23,6 +23,7 @@
>>           'set_password',
>>           'system_powerdown',
>>           'system_reset',
>> +        'system_sleep',
> Additions here are always sad, but inconsistency with the other
> system_FOO commands would be worse.
>
>>           'system_wakeup' ],
>>       # Commands allowed to return a non-dictionary
>>       'command-returns-exceptions': [
> With the spacing nit touched up:
> Acked-by: Markus Armbruster <armbru@redhat.com>
>

