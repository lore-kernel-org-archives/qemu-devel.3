Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E2BCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPjI-0001XP-Rj; Thu, 30 Oct 2025 06:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1vEPj7-0001UZ-H6
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:17:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1vEPit-0003rs-QW
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:17:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U9NPe2023567;
 Thu, 30 Oct 2025 10:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=38sMz4fsk64OV58DgJbm2gEH8TXlBuGRwjLd1brM6SM=; b=
 AAIl/slP+i056KYGtluLDBQv9fmvYitMPfBFmTZLa10Dx6DuoFNgoytwvS86U4Fa
 wzmMsPgedVCo1ChG2Zmv+2TZQkjCIehl4i3s+N/oxsWjxsyhVVyFRkWEKNjMiuqU
 Zd9ggcWRvPgtv1/pLQhXr8RX7awaqg9pjxwPvw/fnlXN31AaT+qgSK1dqurvNhYP
 wnyDqNJgsfm3Wf8po6bUc3nNKbz2YLdmv6fTFodBIvefEWuyVP07hZtgH6+A/wGK
 c1EL608Ji00W0dtDAo8y7vs3MGiOmB9fP5Z8Raaeg4divY66iQBiXa5YnBuc2JP4
 kT1PcTsK2cOi+RZHv6Dv3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a44j6g8ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 10:17:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59U8LdFN024216; Thu, 30 Oct 2025 10:17:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4a33y0efx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 10:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycSAWB2K6U1J7jG4nCxRslVbUhR/KIT77AmThTSyvNfWEtjAtZ7aN2FxY+U3CE1+TKHNmUAJYWv9C4178UvUT7uZQtmmqOmB/hdowNt6nAy2YPoTLPqn7HPF+6ULtNADAnAzwNprHG34qzYnXukmAKmRmzykgkXh5HYusLiXvdMvlM63uB9g2QcOyea3I4SMl3/4+jukrqul4iQncGu6YIpCpOEyV+UxGy7UbeqB7sTPrJe8sStG/Cnl1qoFRD5/rV4DRp9uCguOVvtQGt/lbDFFok88pleniyFr7kfybJio2BP9Qw8R5ahbrqvBwx0ydwJZ2ZqQyyGbB2QIYJgNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38sMz4fsk64OV58DgJbm2gEH8TXlBuGRwjLd1brM6SM=;
 b=ZPI9+AMF7Kzh9fDrSOlWea3cU5dtr0pQ751hEY1L0NMeqMotVtCpL3e7WV8cZZfABPF1a2LxrYIMO5WPM2jrA2y0gDdvfxej0iehTwSqH8GwTEEsA/FN23VvJG7rJVv9mDq36I+hHg2dCpDV2ZCmOcCE2JaO7ZQP44S+xua/X/T4yh7DwRh4dQYx1hGhuez56qq3UUc4fmuFocHTsloNQO43W43+CweBfQ2U5Ps0MB0+TJRVjljGRrhCY8IAClJwshkN89N4cM8uY7x+QB3HX5j8tpe0OR3kwLs61OvnoICLm35YAcaUBM88rS7our+vO/+IGe5dKyAzoerjJOxhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38sMz4fsk64OV58DgJbm2gEH8TXlBuGRwjLd1brM6SM=;
 b=RxEA5Kcgn++uM6317LEckw0koSkHvSR4t5YroKxpg7RLyfsEIPvXkbIvwd/Mql3q+eWFAvwBG4WcNDA1inAqdWBdsv57BKwK4nEeBK/VqxWsPsMqv9WcspFEpX7GuNNABg/KlgL72365jf16UmJeV0nRtITJRfF0zy71eH6OLbA=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by SJ0PR10MB5891.namprd10.prod.outlook.com
 (2603:10b6:a03:425::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 10:17:20 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 10:17:20 +0000
Message-ID: <fbfe567f-c8d0-4342-a593-efe48d7050ad@oracle.com>
Date: Thu, 30 Oct 2025 10:17:12 +0000
Subject: Re: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>, "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
 <20251029095354.56305-9-zhenzhong.duan@intel.com>
 <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
 <IA3PR11MB913625D418E023D14D4ED0CF92FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <IA3PR11MB913625D418E023D14D4ED0CF92FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0254.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::7) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|SJ0PR10MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aeebad-e18b-4339-c987-08de179d826c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajh4dXVMR0plb2k2TnkzNktUaldZL2FjOUtnbDQzenVIMER3aHllQjVQQ09K?=
 =?utf-8?B?LzhreENlandVeEh4OWNrNzF2dkZjU2lvYWhWbURyMll4YWxZWGlFTEt0Zm9z?=
 =?utf-8?B?K0ErZnVacUdTV0czZjFPcWxybVNpRmZxcU1xSmd0NXlXSy9Id3RkczRVWkFL?=
 =?utf-8?B?S1ZaRERUbDdtN2MrOHFqTW5FWW5mSnRrSCtyMHlKR1RCeXJqY2ZBQ3dyUGw2?=
 =?utf-8?B?V3ZoSHpadE9XVm1EdSt4OWJxdjJmaW9Vc1JNM1lXelJvWHFlT2ZXZjZMcFov?=
 =?utf-8?B?MFZHS05OOFM5WUovZG9MaGdEQWFFWEN0eGdhdXVRcHU3M0RvMVhraWZXQzNB?=
 =?utf-8?B?c2xEc3JodTZzWkZodSttYXBRb2IvQVZYbG9oUHM4cys1bGlLdXdVaFdkczlk?=
 =?utf-8?B?cDFZdUhady9SOFcvTy9TWlJ3bzlmakVCQmpQS1d2cG9FYnpQaHRDSld0YXJY?=
 =?utf-8?B?bFpmcGtzQkxuTDZHUGhSTkordWJEZW4rK0xibVNvcmQrZ3RSQ05yT2JmRjJG?=
 =?utf-8?B?Mk5DajROdVU5cEJuQnFRQmZrNnlTTFFNVytIY2l3Z1BvVGkxUFBHNERNY1B0?=
 =?utf-8?B?MFY3Y3IrQis2N0FJQWlzdSsvNlBzS0I4SDdTbmlVek1WaUpWM0FCWTdNd29Y?=
 =?utf-8?B?cXl1RjRNY1ZUYnRXWHlpSnpkcHhvMmJEVVlvSm50RTFQaXpTNlNPQTkveXp1?=
 =?utf-8?B?YmNwSVliUkdjaFFIdHRrV3NleENlbXd4OVlibWs5ZGppNENWRjRmOUsrK0pP?=
 =?utf-8?B?ZWJvaWgwT0dteXBtRHVTTExtcDN6VzdOODUvaG9GdVVaYy9pK3QrY1o4U0xr?=
 =?utf-8?B?VXpOQjdrQXo5a252WC9rREthWTJsRDFkM2M4MnlXS3hJbWd0aEhsa25jL0pl?=
 =?utf-8?B?bGxKV1JkUktSeGNTMmdpTkNFczhrVnNuQXEwYUMvck1ReDJnMkNjQVU0NFNq?=
 =?utf-8?B?QWVneEVUWlJtZ1Q4MTFYN3JHZXB0Rkp4c2djWUhxRnR0S2QxVlYzYm1hZ2tp?=
 =?utf-8?B?TUJNMzhkWTM5N0RDQ3hUbEo0VmdreVRvV0U3UjlzK1Mxakw4U0NkV3hRWjds?=
 =?utf-8?B?eXQ0Y1Uza1YvMHl6NVNFSFA2Ni9uMTVpOENOSVVEdnU5R0JKSVAzc0s1UnE4?=
 =?utf-8?B?TnlMc2gvdzRuQUhWZUt2Y3I1L0Q5VHJxT1VEKzRRMCtIeFptZ1FXRGttU1M3?=
 =?utf-8?B?T0tTY2NlWkVJcUlhTTU2T1o2aC9Yc2pYaGdqTzZDYy9adkx2WGFLd2M2VXhs?=
 =?utf-8?B?amE2bGJwUUN4TDc4WXBsVys2UzA0Si9mbU1pR290UnMyVXVEdjhvUjBacFg1?=
 =?utf-8?B?NGVYblI0QmxjcmJ3Q1EwZFdhdU56QVB4MWQ0SjhkRDQwanBCL3ZHRGlxL0xH?=
 =?utf-8?B?cU55VmgzNnM0RTFqeUcxeGVWWDNMTmQ5RDhsRWFMUlRrU01ER1hOUFNEMm15?=
 =?utf-8?B?T2lrQ3g4V3U2TWcybFpRaksxV3pqb3JSbEJjc2VtcGR0OTRKMy8xUTFwbDdl?=
 =?utf-8?B?ZTA0R21UV3FVZWpMRE1jaWgzd3RRUVUyVHpEaXVvTkNza2J5MVdIaVZ1MWNx?=
 =?utf-8?B?bm40aHpQZnNFaEVHSXA1TExPcDd5RkJSZnoyQzQ0VWwzZTYxMnNPZjBicUVz?=
 =?utf-8?B?dU51ZFFrakhXUGxLU1Y1WUIwRndqOWNqL1RKVnExcitjb2N3UDQwb29WeW1J?=
 =?utf-8?B?dURETU1vdG5HNTNJbW9sSUxaZzltR0V3aDR3M0M1Z09mOFUyWllYR0NqdHZq?=
 =?utf-8?B?T0VQNFJJOHNPS2dLL0FlVTBTZHNxREx4a0I5dm1ZUFRmMndWMmJGZWpYWTRV?=
 =?utf-8?B?YjdEWTdRYUdHNit5SENNUzNhdWZEV0MrSGxKczh2QVAxdGZLc3lBc1F3Ri9Z?=
 =?utf-8?B?S1JsOXY0QXdSaEZHRUl2Q1Y2MGtIbjM0QUt2ZHNicDJlVU9DNGNQUHhrZlJs?=
 =?utf-8?Q?69+WYTg8rvuReuJVtQnOWQ4nR5K+JOJY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVvbW5TZTVZK0RBTTdGeU1VRlNlblVhaGZLMmJqdE1YNTUzbGJqNGtuVnV4?=
 =?utf-8?B?emJHSHE2enFXRkZ3TFBJeUlJNVRSNVIzT0d1T1dubVBjbFI3ZkJrTWtacTBy?=
 =?utf-8?B?VWVqU3lPRXRpMVJLT1JXWDVhUG5tdk5pV2xPZDRWQlJ3UFRidldhTXZjTmoy?=
 =?utf-8?B?bjIwNUZ2MUl6dzVWZGlJWWdHVVljb3pMcDd4TUJ2c2JLSW1vN0NHeWx6WkhK?=
 =?utf-8?B?VmFIcEJyM0xaL1VnaGJmazB1aldzNW9mb1M5VUJwZTR4cmpvaTRLUi9NUGVz?=
 =?utf-8?B?Tm14S21TdHdVZzBLV2ZJNHh2OWIzV0pwbXhhUDVuaWNFa29PcjdDWVprRTlk?=
 =?utf-8?B?c080aTYxMXE4Mmg2NTNFd3JUWHhLWnY5ZWhEdTBiWnU3ckIxTlRzcHZMb05O?=
 =?utf-8?B?eWxFclc3V0c5ZUJaZDM1cHFtdHhDSWVKSlEyYmR3MXg3ZkQwUzBNMzNZS0d5?=
 =?utf-8?B?bkY5T3YvZVJRQTh6cjlXc2JqYmx6elMxbDRPaWVuN0NtdXBoZ2hjVFU2VnRO?=
 =?utf-8?B?YWdJZGJSd3FJM0lwejZLR211WjMrM3ltQmJ6c0pjU1dVRkRHR1B4WnhlT09T?=
 =?utf-8?B?QXFjRXl4SWxqZzZpVmtHMCsrcTF4clltazFWRmRTV0MyK2RDUnh0WlFreGxt?=
 =?utf-8?B?dmhCWmJCMUFWKzAwbzhxZDgwU2Z4c3A1dW8vRDZmRzlacWtOdEdaNWpPZW52?=
 =?utf-8?B?TFNncW03dU9pM1Z0UHJZVmU3MjFjN1pMZjF1czJJNUxjZG1UaVJXTk5BdEJP?=
 =?utf-8?B?bTZ5TWExbHVLMVZCMldRbXBBeXJsSEptUm9kZ2g2OUJUQWVFc0ZMSGNKaVVE?=
 =?utf-8?B?bnRad3BUaWVlNDZkYW5IMFpOSmtHOWkwS0dFSG8yY0FTYlNIaFhNLzZ2OTJm?=
 =?utf-8?B?YXJKaVlEb2g0S205aldibm9NOStlUDB3TkRoMkNWY2NlcS9IcFQ5WmFGU1FN?=
 =?utf-8?B?bG8zNU5qUWltZEc0L21xYkpWVU8wQ3NvR1F2c25hK3pUdGkzd2NlRXZJYUZQ?=
 =?utf-8?B?STAwKzJOSVE3NEphZ3F2bjd2WXJuaHE3MmVDZzZ0M1pxNW5yUFhuQ1dHaE5Y?=
 =?utf-8?B?ZHltdlpUL0N0UVhFOVgwdTR1YndJUkxDTWNuUmh3RlRCRVRKekNxUDVvY090?=
 =?utf-8?B?M0l3RzIxRVdhdjhORlY0bkdFV2s1dnlIK1lDaDZWTmsxWFNncW5oZmVUVWQ3?=
 =?utf-8?B?L2I1eEk0djlJTUplRm9yS3RHSWJqVDhiT3B4MjNxZnVPRjl1TVhkeDdHZzNF?=
 =?utf-8?B?TTFhZ3hRWC96SThaZmZ2VDd3VGtKZTdpdC94K1dtcEpMQXUzTENrZE10SEpn?=
 =?utf-8?B?Q0k0Wk54WG5LeWVzZys3NXpVVmNIU0lQdTFsaXoyM3JyQ1Z6cFU0N3I0OGxt?=
 =?utf-8?B?Y0dvT0h1MXU1NlhFNGpmVW1tekdxS0UvMHJGRHhxbndyOU5yT3FGRFZqVUls?=
 =?utf-8?B?NVZnTkdhbG0vdTFweENPVGt3VjFYSDAvQ0dCN1p1cEdiYmQ0WHQyS2Q4ZHV1?=
 =?utf-8?B?aUMzejZ4ZGE4b1Y0aGhlK2FyaElmSHlQNm1EY3RYOTFFekRrT1crdVVpdHFk?=
 =?utf-8?B?RHlEc3NTU1p3ZjBiSUthYmNLTVhZeTZyZFU2U0lOMjZCcVRTZmZGdUNGbWtK?=
 =?utf-8?B?eFN5ZWgzUTMrdHhHZWd1a1JPRWhRM1hndWlhMlZxY2g3MW5zTklXQnNkak43?=
 =?utf-8?B?RktnNTJWN1U3ZngybjVLMTduNDdtQmJGc21nQXY5ZktiVmNMWlJ0ZzBDOXJH?=
 =?utf-8?B?UFBhZkNFUUVFR1llN09SMUVPUmNQei91RjNxNk9GelNCOGl1SDlaU3N6cUQr?=
 =?utf-8?B?SWtWQWtXWUlGNHBqMnFWdXJSL0hKOHlWNVRvaVUvY1hWNWxzdzlRdENJckZn?=
 =?utf-8?B?Z0NGRk4xbEZZWW5ESXFwVFZaV3FPSDU3U3lhb3ZqN3dqZnI5T0p2ZUpvWm1J?=
 =?utf-8?B?VkJBVHpaNnFrTXNvY3VwUnBNc0ozSGVjaUFCeGduVUpJNWw1bURMMW9raGxF?=
 =?utf-8?B?WjJnUGZHTXUvOWp2akl5ZHlOTUtSanRGSmtqWWNmbXNZcGpBYjYrMFJVaEJt?=
 =?utf-8?B?ZVptZlBXc3lsNUF0NTVkWW1Bb25UMUpXS0RrMUJIZGhMcE5TcDJXaEtxdGYy?=
 =?utf-8?B?NDNWQUhPKzJHeFNpSE02aVJFa3dFV0tiV2dVbnk0WTJMd1N1bVo1ZHVYVWdF?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9xaFkLhhDk7/DMNjEDEGfIPceeck0PZspNnJc9Hy9cem53ubE+Y1mq8JUsHbPVzMBrgio9L1LJd3AOoyEoMscFLl/PdJ81C1e6ZzbyGh0e1TZGeyVTc0msxarzu9wGcTlUAL7GatxNh1znjZ2wMYB/yspZScoLsdS2dD+oGqXp2Erl9We6DHx97JCJBxxll+jKRELa8zeLrMz7DIbv46KxNcmIXhSFlmW/nTgO4+LGrEE7k17ugSTp8zVUNCwZdDjJi6cyEWGPTjj2Htry36V5Rbb1Bw/2Mdj/zxSZMEA1KkKnKCiXAhfi50YcoFA2YxXjHqwN4TZFyh9RiSNleTXaKCWPD90YwdaOsaPF6Qv1rYOX1ukZJQAtI5pBwv248wUzz3xw4HyfbH5YuIwQGx+uGwoXfSc6bcRdXM976iYomGzeMwGF2QbXMRnf+VckTNfHdSL+YmwRwkWoUdwPkhX0GijmljNUW2SNQxZ+A0XCHHrpLQjn1wVsfqhgqkUos7+3sV+iWehyMxdYg7HGwsOv/KxJB0v8TCZMl6UpPQaBotibP38khpuwR1zd5l7WTaxM7LbU/wR90QsONP8zRrl/JmD2Ao7QBbwYDp/TCIkoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aeebad-e18b-4339-c987-08de179d826c
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:17:20.1482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oKbG7+FjhHYHPb8zI737MFZ2zPPoyNTlA15NF0cLzAZBqjCbYe84PRryni3RdtLSYlSGpiuvpKStWjwKshTBz90lbw50uF0T3876rQBZuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300083
X-Authority-Analysis: v=2.4 cv=JJI2csKb c=1 sm=1 tr=0 ts=69033b34 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=sKqh4AOlwAV7GTBN3C0A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: FHK3N088bbEV7eLfiEPO_4TpOMML34rD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2OCBTYWx0ZWRfX9RMRmaRlzEF2
 NgCfumcgPWlS58Su+RTxoQTrmQdLgBhR0OnaJwCHJGtzF9RE894Hz2+WqIDxh+p7JV/c97mHJx3
 lUJR2nwXeL5/NsaReABwP2fs+2W+yaOzkx/Ruytrxnizwy57SNt9/+joAaafnqbyTWo4XHhcXa8
 VEJagENA7j4+HuiMs/1tiH/J3FqGQIAQ9AlRRaYxtCA39MO0FQeRUZnKAyaOj0cvJLtZ22NzC4z
 GCqJ42C4GGK09kCaTL40MpQ7yBPitABIUT1bHZnYcFGYNS648MKo/RKlatYPa+jmweNPr/FYDgH
 GGDzli227r2oBjF0PNlVpiHj9bJgJhPAEdEHoAPs5SMQs25ln+B5GJvOF9fN7DYnxf1YoPkr6Ix
 KaHpT0aPlDhrPlzHXO55NvDe+q8uwA==
X-Proofpoint-GUID: FHK3N088bbEV7eLfiEPO_4TpOMML34rD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 30/10/2025 09:10, Duan, Zhenzhong wrote:
>> From: Avihai Horon <avihaih@nvidia.com>
>> On 29/10/2025 11:53, Zhenzhong Duan wrote:
>>
>> BTW, do you have a real production use case for migration with VFIO
>> IOMMU type1 dirty tracking? I mean, is the scenario you described in
>> patch #7 a real use case or you just fixed it for completeness?
>> If there is no use case, maybe patch #9 is not really needed?
> 
> patch7 is a real use case, in guest, we switch device from IOMMU domain to block domain and see the issue.
> We need to send accurate unmap notification with actual mapping during migration, for both backend.
> 

I think the real question is why you are using type1 backend overall for
purposes of dirty tracking.

type1 dirty tracking just returns everything in the bitmap as 1s. There's no
actual dirty tracking and we usually call 'perpectual' dirty tracking because
everything DMA mapped as write is always returned as dirty no matter what you
do. It doesn't look at pagetable neither for the unmap get dirty.

It's only (known) use has been for testing (in the lack of IOMMU HW + IOMMUFD)

But reading your statement in a different way: you are saying that you use *two*
backends at the same time? Why would you do that?

