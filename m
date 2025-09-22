Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C29ECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 17:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0jvE-0004Hu-KY; Mon, 22 Sep 2025 13:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v0jvB-0004HY-R5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:01:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v0jv7-0005uH-5A
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:01:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MGuT3Q025928;
 Mon, 22 Sep 2025 17:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=BpsusPBPkC4qBuxduK39iS18SQHxY3G4gKEtj5jFluY=; b=
 JqB7R+1Uo+OY+qd7Hy9ZcOgrp5EyEBF+dxJ3nWXxAMu8Ewcwu3qQVOoI/hfGvCAE
 yrjW1nXqsX+VscS8jAwXo7IrT9smkBihLrxdSkJQk6OEwe1OL8KwG7qPcOfnZf4+
 avroTi9OI/tDGLWzhK9RiB4mss/LWP3Ai4OKT/IZz00YQkSBKVA3eAHddLfoOtHo
 R5NcMF8njSesiKJDDhkbCpFdLdv4AbMQiCMEUKbidPOm1Y+8/w6XL2eXIYrEJgAQ
 31wfFB8azWFsWF7IXSSoG5zPiuCgrIO45qWAdbqXfnxSSAicBdRnwUSVC8wrEPif
 y6sPuuGWHUokM1XyWB9dCg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdjw9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 17:01:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MGnxV4025308; Mon, 22 Sep 2025 17:01:34 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 499jq7aajk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 17:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifPGWI5XWE+7idbw+fHYgG4Y1QpOF6AZnH5k+ruPZOaHYuryoPGOWM2z8119Pr79OMaJizP9RQBr0nLFHdEUeBy6LHc/9jXceaJgkcC1HHhbG3gYpA0HJA2IXBJl0LYpJvGx9r0W5a7fXX1KZa0v5B/npqO/F97Csp6vNBYxx3g+cTxcJolhDjdhXYfpFZJuxxz7ByGyP+9F0rn9ok2f4RsdT4O3+dgW2IQ404N3iqhC+1Pir6UYGV8T8vHRBZ+sRVgW2N0RjBq6dT2o5JlaUKDRBainSZXzatwaa2mrfKtXyYiqjcQd7yuiNjEPZ4HklcN9+cWO+oKLYS8FZ9yRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpsusPBPkC4qBuxduK39iS18SQHxY3G4gKEtj5jFluY=;
 b=PediKU6W6NUc5cuf6G6G7PA2hwNz7lUBFhKatl1px7g9wIwF9owPVb4cHLnbp3EtpFKoTsJCQ/9CzTn47we5zRNck+xOPuFGCRZKrJX5+B2u6I+sz9PTHFwEAxbKQT1am9/evvePMGsWzustmPNrl02JVR9eGknNkUwj/r7rNllZiPbGak+xcky0g0l5s0UtzfaOccBjRTfidl5stkQ0+Dgh1HhTQjI1HzmPb2ICySwECZAP5tMmH2EDcglzBJGEWug+AVdrx+C7R9HrUyVZcv1grUS3CS3UpXbbV5pvQ/vZIoS7bzobiI987rSU8T1B41wBUm2YcGE/r8VMPdRYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpsusPBPkC4qBuxduK39iS18SQHxY3G4gKEtj5jFluY=;
 b=iDHZ88KfdfjMXG96YiYPtN/Nh0PzQ+fcj0ljt9cu+31S0pNSE/KYK27LR/Ma63ypvtZJs4IdJTIxPndL4Tz81Vo7Fg6FtVc70BzTyybn/B2asbqNOZfb0mTC3OA+0osf4JVgoI/3zYytLJbbGH66EsPTfSuv3gOCdVTLEuccqsI=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by DM4PR10MB6765.namprd10.prod.outlook.com
 (2603:10b6:8:10f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 17:01:30 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9137.017; Mon, 22 Sep 2025
 17:01:30 +0000
Message-ID: <4120d83b-9f84-466d-b359-d73a3e7192a8@oracle.com>
Date: Mon, 22 Sep 2025 18:01:24 +0100
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
 <ce629779-42ea-4850-924a-5803a7547998@oracle.com>
Content-Language: en-US
In-Reply-To: <ce629779-42ea-4850-924a-5803a7547998@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|DM4PR10MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdf12d0-5c5f-4d88-7cd6-08ddf9f9ad33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTVYUzladEpHeEJTVjN1bHIvRjF3MEx4TWcxdFBLZHFQL0hQc0VhdDFTQWFm?=
 =?utf-8?B?Nmp5ZFEzajhKVjZGVnNkY25NUldlZStYeUdlVzg1a0REcVRzR084Z3lIQjdk?=
 =?utf-8?B?N0dhMno4eklDaFI2TCsxd0FMZUYxcW4zODQ1OEVHK1VrZXVOcUlhRXFLaWU2?=
 =?utf-8?B?bW1ubGg3aVB5K0tLTHE1SVF5eWxadWs0U20zRTBGNWI0bVdTNklITTJMY0Jt?=
 =?utf-8?B?amFiY1JsOTBGenVwaWJFTFZGS1hGL085UHFDbWl0b3dKdFl1VWFHeXBoMmZ5?=
 =?utf-8?B?eDNVdVdsS2J1cnlLUjFGRjI0L0pFTHMxOTd5aW9XVUZrL1ZMUFMvSHlrM0J1?=
 =?utf-8?B?MmdleGZQRzB2WEUrUnFLMjhFUFNMUTZiQ2VmRlV1V05rRUgybUxzYnZzMzhH?=
 =?utf-8?B?czZJRlhoRUtwbEI3blpzNGw4Y3dpQnRzTnpITlhKeTg5K3hSU21ia0hxc0Ft?=
 =?utf-8?B?UXJHL29wQVUxcktMQytrZElWV0ZoQXl3Rm41WFFmMnJJMXhXUzJjbytrby9s?=
 =?utf-8?B?L3B2dVdCU3E5eGJMUGJZNWdVa0J1L1dSSkZtZVVwZ1k5OGk1OXZDR0JvNUlz?=
 =?utf-8?B?b1JoQ1MxMGt5RUxGMmtxZmdFaWt5YWNDcHRhdUo3REFQZ05HZm94dWdHek9a?=
 =?utf-8?B?VnRZNVlmcFdtNnNYcHVuRStQNkl6RFgrZkg0L0JkeUM2Yi9wcWNMQjl5TnVK?=
 =?utf-8?B?M2ZheWNPVFpQMmFhdGZOVjJ3T01xbmZzWEcvRm9qWG9QcjIrRUVCWC91NTda?=
 =?utf-8?B?YTgzUlEvSGpOTkNIVlRGcjFSZG1rTmxTQndtZWZnWWhlNnBEczZoY01TWXBu?=
 =?utf-8?B?MTVXaWFQaXdnK3REOGtBRnVXZzNCVytaenpUdENmS1AvWjNsQU9oZjhHTkNZ?=
 =?utf-8?B?amcrY3hOU1RMK2dwNkZoWm9YVUNCZGdMcXU3RHZpMUd3Ly93WjA1RXA3VlJr?=
 =?utf-8?B?elNnU09EU1VHYkl0Z2dmMkdTbmpCZGF5RmMwWU1SL0YydjlZU0hhd1FkbHk3?=
 =?utf-8?B?OGJlMzUzVDFUanh2L0k0WnFUZWN1amxQVmR6NEdpRHRJRW9OdHU5bFl6V21K?=
 =?utf-8?B?Zmo4bjZYVklCZ0krRHRnTFJCZU5MaUJZZ1R3bUVHdi96YTlpZXREQ0c4TFhV?=
 =?utf-8?B?dDF5Zm5KdjJMSXRPQWxaR0VNcXgzamdnOGE0MDg4NEdFTXdYanEyM2JqK3l6?=
 =?utf-8?B?Z3JscHVIQlNreHJFcFIxYTFmM3dQbk10SGdLY1JIdlNMYTlvMG8ybWpQM3Ir?=
 =?utf-8?B?TzdOd2hBQnlPL0ZKRHBCeE02STBaam5BbXpSVjNiTGtZRnpwZjFKMGdZQ0lY?=
 =?utf-8?B?T2J4Q25TNzdWck1RNlZTWXhJY2Zjb2xKNDdEanU1bHFFMWNZbThMNWlmRE1z?=
 =?utf-8?B?OU1VZlVBL1duYjJRVlZIRUhKZmdKM0tTanBYTm5FbUlsRzg0VWxZdmRRTG9C?=
 =?utf-8?B?ZGhkMFJleC9LdXZQVGMrcnQyTU44dHFIQjNMOUt4TTZESVhzQ2doZUh5RUpo?=
 =?utf-8?B?SkpJY3ppTmF6ZVBZK3RuMlUzbDFZYjNZSlRxdkloSVMvWGpLK1NXTS9hU3RH?=
 =?utf-8?B?UngranpZREJOVzd4S0pIOFRTVnBFSWx0bkIrUXNSVXdOdFp0ZFJUcWppdXli?=
 =?utf-8?B?dU5zbVRCclJ1UzdUcWVTREZRQndiNFlUa3NFK3lrZWpITUM5UnR5cVdaVEdn?=
 =?utf-8?B?V1lpUTl3THFpQ29uQlZGbjE3QUk2QllkampKdkpNM04vSHg5dTNqdHYzd2dS?=
 =?utf-8?B?NUtybFoxSUxMWElQb1BKRU50SWZUUXgxR1UyYko4dWNQV0NRTDFQSEVUVU5N?=
 =?utf-8?B?QjJZL1hTU1M5anJUTnc0UFFhTE4vdktzMk1tcVN5VW5uMlFTTG1PZnFPVlRi?=
 =?utf-8?B?MklZN05najJWY2pKeTU5SmNMSkpnM245MWlEMzNxaTVEUk8vL0ZERDNkNWhw?=
 =?utf-8?Q?JFEeBi+F4QaZXQJSvl+n5lm/2qj9bZIO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZiU2xIaTdaY1B4Z3RZMG02ZjUrdGJLUGhzTzBQOEJyUmJxaDY4WVVIY1c3?=
 =?utf-8?B?NFhYaDl4ZWxHMi9Ycm5TSmp2MGxvdm4wRWxRclJGaVRHK25EcUJ1bTFTdncv?=
 =?utf-8?B?aS92ZytiL0htb3IxRkZ2YzJtQVBXeVIvNCtFNnJETmZRK2tnaE9MZG82ZFRZ?=
 =?utf-8?B?NHhiQnVwMHA1TU9hOHpyRkMwSWV1bVR5dUQxQVZ3dzIwcDE3dXJkVExVZllV?=
 =?utf-8?B?UzlUOTgvSU94Yk1GUUNJK0hSREpCRmNvN0dITTJRZ3p4ckRvZStCcjNoNDRv?=
 =?utf-8?B?UTNPVUg2bzhQYlM4TlJQQURFZFNGbGNZcTJUM2ZNalpqTHpqUFpHemc0SURR?=
 =?utf-8?B?T3ZpeFZOdEplUEk5K0xRanZScmd6SmV5VE00SnE3Q0tNM2t0VExzT0V3SHUz?=
 =?utf-8?B?U2tkU1ZTY0RubFgrbjVhWWxUOUJYVXRQeGU0bjdzeFFjT2Q4TGliZnRiZ2hu?=
 =?utf-8?B?VW0ySGtHQzVDVk9CUVFvYllQMmFQOXBCT1pnZmwyRjhiaUtERXJDeHJIM0pZ?=
 =?utf-8?B?cjdkd2dtdjV3aCtHQ2dhYUFzdGFoUzg2aHlFeVJUMVFZRUVqTG9lbGpNTkVu?=
 =?utf-8?B?enpMVERXMUo5eUpFTktyT3NXdGY3ZHhxQldMZmYvQ3F0ZlhXMVBjbWl4Tk42?=
 =?utf-8?B?aWdmalJvZ3BkWFRVZ3kwZXBIVlRmdnp6bGFhNHZmVG5tM1RzalhVV2w0M1ZM?=
 =?utf-8?B?QldDSnlJTTNNSUszTENvK29NT2ExZU5aZnpNbDRuS1JOQVJmM0tDUSthUEFV?=
 =?utf-8?B?WUtOcm5Qa2pIODljc2N2YVc2VXEvKzY5alBReDBVcU1Ca2xkT2xnY3F6M2J2?=
 =?utf-8?B?QXJaV2ROWFo0enJUQnNiNzhHTFg5TmlIMXZZUUVtc3dEaWZlQlA5TVBTT3hm?=
 =?utf-8?B?dkVkLytuVU9hbUJFUUkzR0F6UTJZanF0UkdmNk9WbkVFSm1sVXRWYTE3djZv?=
 =?utf-8?B?dnFmbTVLTWF5aTZjUFk0ZVphRTVLTnlpRlVoQjJzWGhBeUFtcXhIcnBhQmNB?=
 =?utf-8?B?VWEzcTAxRnMwM0xIT2Ftb1BjeDVrQnlEVHE5K0JtVm16cVpSV1lPM0FaWDR0?=
 =?utf-8?B?M3h4MS9XbStrTGljZEtrckgxZ1g5bHc0QStacFMxck43KzhPTlRhcUdJVDRH?=
 =?utf-8?B?R3oxb0tTcy9YMGJUM2NrNDhhZ21lSjdmMWdLWnZmWmRBWEhKM09yM0pxRzZ1?=
 =?utf-8?B?YzVzT3Fja0E0VzZ0Q20rYUtBdjBVRklPdmUvbGJ3TjdXcmc3Z1VJeFVRZFRW?=
 =?utf-8?B?b3pBOGE4U2p6a0lwVCtZcXNNakJBTHlJZ3dnZTc5NU9IVS85KytJSXNxbGtQ?=
 =?utf-8?B?cE1PdXFNM0NFdFYrMUNEbkh2b3ZCcWZIWTh0MHdpdWZuT3k0NjFRYzZNdGdn?=
 =?utf-8?B?ZmpzdlJLT0toUUhkMUdWd2hEYTBVeFk2MVNURHViSkxqcEVhWEs4ZGhhWUFW?=
 =?utf-8?B?TlR3VjhyMGhTcTZ4dzUrZG0xRUFuQXFaZGlBTzhKRVRBZy9JN0tCRVBpWEVy?=
 =?utf-8?B?aXRQZlNNLzBZbTRuZVhhODB5STJtUFZSdmlYZFRMV3VNWm9pb0VTWTFUV1VZ?=
 =?utf-8?B?c3Z3SnR6RkZ1UzdYZ285RUJiVGRVY25yVVlxQ1BvWStRa0ZaY0l4dHljUy9V?=
 =?utf-8?B?N0R1T3hCVHZHQmcyTFhaQThidktwSG1IcERtcE1JRTJ6bUh0dXdaeDhXdG5S?=
 =?utf-8?B?ai9KVDBxdW01R3RmTnBOQmU2L3BiaXJCZnNmZzNYUEhhNXBrT3VDSytWb3BE?=
 =?utf-8?B?aFlzVGU1OGh5L2NGaVo2ZTQ0Q3hUT2VqZmMxRzBQVXh4cnk3UWpXNCtSTEZv?=
 =?utf-8?B?RUdXY2tleW9vMHVKWDlmK2Y0U3J4b0tycFZuVE95T000UEVQRjJ6Y01JWXoz?=
 =?utf-8?B?UVZkRW9SMlkwZjM1OEZsWlRQbmRwY3FBenNUenNtMytmVzRHRXYyWExUYVNh?=
 =?utf-8?B?UUdvWVA0cjRyVmtGV0xJU2RZMFpVejBpRVVwL0VZZTdPWkQ2RTB6eUhBNmkx?=
 =?utf-8?B?YnArd1FEU0txQjI2T1FNckUwOXQyQXFTZDM2UWgrbGVpaXJCSzkzV2xPUGZi?=
 =?utf-8?B?TDNlTkhtV0VuZytYYTE2R1RIU3lXcjl6cndVSWRuK0RrWldIWFZySnN1d0hG?=
 =?utf-8?B?ei91QjlZeU5TTCtZY1BtSXdaWGN3Y2F6Sms0S3JFSStmb2xFRUVETlhITklr?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1SZyCdA0dUX2Gaz9DQmY2ZkcBMjEHdo9X7XPr4ZSfLimS6A7G+JZ51BgphhSnnat1oJ63JKSdj5JjCFVdNjSsflCrHvEomTvtbNZTnFRRfL6L1qsX3dlGPjxgDo0LPBmAJLEfELA8fa3ld7Ui/3hkz4izc43jXdOuu9CFof4o44t5jEAF9h+De/AIeAwT2LORkzazT9WwAPMlaX4IJ4f2YfO5Si/zqwN7assIdrRruWicocxs2tT+t97gvxcAzzLDKeI7Q2YeHNvFXXCeV+/M27kUjYJ9idyWCCsNu2d3R0T+LNE9hubcmC3XDHDysrDlT1HQJUBCPbME0qUqAqth8CcIujjfqCi+N8gyRcYtNoiGUnLrukLeE57DyZHGZJ38L5xM2aUo/GNmML1FipeuPFuuosgizRcAC2UmaSakIYvF2M6/RmiEQw8S90T/EQ5Sw8AjPBvbGXksjIQR3zG0kL+aLfjr2r3XaVxHSxw1cIm0EFaDPfWPcxw8tmyvjkJVlK1bD6TaNqG81tPVmhpJnscRRlOqBuagl91FVOdprdHQ2AdG40gVdec2IZDeqXUk6xaqaS3tZZpUwN3v1Ap5Qz9calOp9kzTdZv84ckves=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdf12d0-5c5f-4d88-7cd6-08ddf9f9ad33
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:01:30.6870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtbHizF3wnTEvxVFKeZGkmMPcMa3E9IClqpeJlBUAhfAjmkTiN3o4D5zWRq5f9No900bvFUJWZizRxMk8o1EnmSo7SzD4nu04kKZn8492WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220166
X-Proofpoint-GUID: K69OrJLpZPg9TThw8Nl26Qpn1p05Ff2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfXx3vO4IXgTSoY
 HCR2tAHe6VxnzF/WCJJzqjhKEpzcJ7tNfO1PdluUKCm9hgZMVrXNocf8j4VOsZPELb9FWpNIzDC
 qXuhHjTJ4SBlP93FrG5xmIj5HITq3bD38Bs85FsbHRA1biqiVD5gRiswGUQ0fAYu3raVOj1nd7r
 wWhc8ZI3lADn2E9ZlFb0kmy+UrkotvRj77vwedhgEYl+C9NzHQZz2eNyN2HyBqJNgoZJpHFh2AY
 A6VWp4d3wDUnCj4AqUaSXvaRpylaMadnZ96PXooaQHivyciLbPnheI3B2Bk3WhxNJqP1ldrH/V+
 Ruo7Z1x30UJYsxlhhL1Jx12yAE4jGYhVRGwig5a1yNInw42lR3lctG4Lcdy8X6Vy7jGuEO+HWtp
 fs92Y1ez
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d180ef cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=DkI9saNw7N9N60L2OvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K69OrJLpZPg9TThw8Nl26Qpn1p05Ff2M
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 22/09/2025 17:06, Joao Martins wrote:
> On 22/09/2025 17:02, Cédric Le Goater wrote:
>> On 9/22/25 07:49, Duan, Zhenzhong wrote:
>>> Hi Joao,
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>>>
>>>> On 10/09/2025 03:36, Zhenzhong Duan wrote:
>>>>> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last
>>>> dirty
>>>>> bitmap query right before unmap, no PTEs flushes. This accelerates the
>>>>> query without issue because unmap will tear down the mapping anyway.
>>>>>
>>>>> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
>>>>> be used for the flags of iommufd dirty tracking. Currently it is
>>>>> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based on
>>>>> the scenario.
>>>>>
>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>> ---
>>>>>   hw/vfio/vfio-iommufd.h   | 1 +
>>>>>   include/system/iommufd.h | 2 +-
>>>>>   backends/iommufd.c       | 5 +++--
>>>>>   hw/vfio/iommufd.c        | 6 +++++-
>>>>>   backends/trace-events    | 2 +-
>>>>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>>>>> index 07ea0f4304..e0af241c75 100644
>>>>> --- a/hw/vfio/vfio-iommufd.h
>>>>> +++ b/hw/vfio/vfio-iommufd.h
>>>>> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>>>>>       VFIOContainerBase bcontainer;
>>>>>       IOMMUFDBackend *be;
>>>>>       uint32_t ioas_id;
>>>>> +    uint64_t dirty_tracking_flags;
>>>>>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>>   } VFIOIOMMUFDContainer;
>>>>>
>>>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>>>> index c9c72ffc45..63898e7b0d 100644
>>>>> --- a/include/system/iommufd.h
>>>>> +++ b/include/system/iommufd.h
>>>>> @@ -64,7 +64,7 @@ bool
>>>> iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t
>>>> hwpt_id,
>>>>>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>> uint32_t hwpt_id,
>>>>>                                         uint64_t iova, ram_addr_t
>>>> size,
>>>>>                                         uint64_t page_size,
>>>> uint64_t *data,
>>>>> -                                      Error **errp);
>>>>> +                                      uint64_t flags, Error
>>>> **errp);
>>>>>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be,
>>>> uint32_t id,
>>>>>                                         uint32_t data_type,
>>>> uint32_t entry_len,
>>>>>                                         uint32_t *entry_num, void
>>>> *data,
>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>> index 2a33c7ab0b..3c4f6157e2 100644
>>>>> --- a/backends/iommufd.c
>>>>> +++ b/backends/iommufd.c
>>>>> @@ -361,7 +361,7 @@ bool
>>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>                                         uint32_t hwpt_id,
>>>>>                                         uint64_t iova, ram_addr_t
>>>> size,
>>>>>                                         uint64_t page_size,
>>>> uint64_t *data,
>>>>> -                                      Error **errp)
>>>>> +                                      uint64_t flags, Error **errp)
>>>>>   {
>>>>>       int ret;
>>>>>       struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>>>> @@ -371,11 +371,12 @@ bool
>>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>           .length = size,
>>>>>           .page_size = page_size,
>>>>>           .data = (uintptr_t)data,
>>>>> +        .flags = flags,
>>>>>       };
>>>>>
>>>>>       ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP,
>>>> &get_dirty_bitmap);
>>>>>       trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova,
>>>> size,
>>>>> -                                           page_size, ret ? errno :
>>>> 0);
>>>>> +                                           flags, page_size, ret ?
>>>> errno : 0);
>>>>>       if (ret) {
>>>>>           error_setg_errno(errp, errno,
>>>>>                            "IOMMU_HWPT_GET_DIRTY_BITMAP
>>>> (iova: 0x%"HWADDR_PRIx
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index 0057488ce9..c897aa6b17 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const
>>>> VFIOContainerBase *bcontainer,
>>>>>                                     hwaddr iova, ram_addr_t size,
>>>>>                                     IOMMUTLBEntry *iotlb)
>>>>>   {
>>>>> -    const VFIOIOMMUFDContainer *container =
>>>>> +    VFIOIOMMUFDContainer *container =
>>>>>           container_of(bcontainer, VFIOIOMMUFDContainer,
>>>> bcontainer);
>>>>>       bool need_dirty_sync = false;
>>>>>       Error *local_err = NULL;
>>>>> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const
>>>> VFIOContainerBase *bcontainer,
>>>>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>>>           if
>>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>>               bcontainer->dirty_pages_supported) {
>>>>> +            container->dirty_tracking_flags =
>>>>> +
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>>>>>               ret = vfio_container_query_dirty_bitmap(bcontainer, iova,
>>>> size,
>>>>>
>>>> iotlb->translated_addr,
>>>>>
>>>> &local_err);
>>>>> +            container->dirty_tracking_flags = 0;
>>>>
>>>> Why not changing vfio_container_query_dirty_bitmap to pass a flags too, like
>>>> the
>>>> original patches? This is a little unnecssary odd style to pass a flag via
>>>> container structure rather and then clearing.
>>>
>>> Just want to be simpler, original patch introduced a new parameter to almost all
>>> variants of *_query_dirty_bitmap() while the flags parameter is only used by
>>> IOMMUFD backend when doing unmap_bitmap. Currently we already have three
>>> backends, legacy VFIO, IOMMUFD and VFIO-user, only IOMMUFD need the flag.
>>>
>>> I take container->dirty_tracking_flags as a notification mechanism, so set it
>>> before
>>> vfio_container_query_dirty_bitmap() and clear it thereafter. Maybe clearing it in
>>> iommufd_query_dirty_bitmap() is easier to be acceptable?
>>>
>>>>
>>>> Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH for
>>>> generic
>>>> container abstraction was to not mix IOMMUFD UAPI specifics into base
>>>> container
>>>> API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend
>>>> could just
>>>> ignore the flag, while IOMMUFD translates it to
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
>>>
>>> I did port original patch https://github.com/yiliu1765/qemu/
>>> commit/99f83595d79d2e4170c9e456cf1a7b9521bd4f80
>>> But it looks complex to have 'flags' parameter everywhere.
>> I think I would prefer like Joao to avoid caching information if possible
>> but I haven't check closely the mess it would introduce in the code. Let
>> me check.
>>
> 
> My recollection was that it wasn't that much churn added as this series is
> already doing the most of the churn. But I am checking how the code would look
> like to properly respond to his suggestion on why he changing it towards
> structuref field.

The churn should be similar to this patch:

https://github.com/jpemartins/qemu/commit/5e1f11075299a5fa9564a26788dc9cc1717e297c

It's mostly an interface parameter addition of flags.
But there's now a few more callsites and I suppose that's the extra churn. But I don't think
vfio-user would need to change. See snip below.

I've pushed this here https://github.com/jpemartins/qemu/commits/relax-viommu-lm but showing the
series wide changes for discussion. The thing I didn't do was have an intermediate 'backend
agnostic' flag thingie like the original one
(https://github.com/jpemartins/qemu/commit/1ef8abc896ae69be8896a68705fe4a87204709e0) with
VFIO_GET_DIRTY_NO_FLUSH

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 56304978e1e8..2fe08e010405 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -211,17 +211,16 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 }

 static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, uint64_t flags, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);

     g_assert(vioc->query_dirty_bitmap);
-    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
-                                               errp);
+    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size, flags, errp);
 }

 static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, uint64_t flags, Error **errp)
 {
     VFIODevice *vbasedev;
     int ret;
@@ -243,7 +242,7 @@ static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
 }

 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp)
+                          uint64_t size, uint64_t flags, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -267,10 +266,10 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint6

     if (all_device_dirty_tracking) {
         ret = vfio_container_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                                        errp);
+                                                        flags, errp);
     } else {
         ret = vfio_container_iommu_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                                     errp);
+                                                      flags, errp);
     }

     if (ret) {
@@ -280,7 +279,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint6
     dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
                                                          vbmap.pages);

-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
+    trace_vfio_container_query_dirty_bitmap(iova, size, flags, vbmap.size, ram_addr,
                                             dirty_pages);
 out:
     g_free(vbmap.bitmap);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3f89cf..86c4d06298f7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -169,7 +169,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
     }

     if (need_dirty_sync) {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                     iotlb->translated_addr, &local_err);
         if (ret) {
             error_report_err(local_err);
@@ -267,7 +267,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 }

 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, uint64_t flags,
+                      Error **errp)
 {
     const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index b82597de9116..c1c8755c6d7c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -73,12 +73,10 @@ static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            container->dirty_tracking_flags =
-                                      IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
             ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                    IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
                                                     iotlb->translated_addr,
                                                     &local_err);
-            container->dirty_tracking_flags = 0;
             if (ret) {
                 error_report_err(local_err);
             }
@@ -95,7 +93,7 @@ static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
     }

     if (need_dirty_sync) {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                                 iotlb->translated_addr,
                                                 &local_err);
         if (ret) {
@@ -235,7 +233,7 @@ err:

 static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
-                                      hwaddr size, Error **errp)
+                                      hwaddr size, uint64_t flags, Error **errp)
 {
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
@@ -251,8 +249,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
         if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
                                               iova, size, page_size,
                                               (uint64_t *)vbmap->bitmap,
-                                              container->dirty_tracking_flags,
-                                              errp)) {
+                                              flags, errp)) {
             return -EINVAL;
         }
     }
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e09383316598..27cbb45282ae 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -1082,7 +1082,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     translated_addr = memory_region_get_ram_addr(mr) + xlat;

     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
-                                translated_addr, &local_err);
+                                0, translated_addr, &local_err);
     if (ret) {
         error_prepend(&local_err,
                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
@@ -1118,7 +1118,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, 0, ram_addr,
                                 &local_err);
     if (ret) {
         error_report_err(local_err);
@@ -1203,7 +1203,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,

     return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                                 int128_get64(section->size), ram_addr, errp);
+                                 int128_get64(section->size), 0, ram_addr, errp);
 }

 static void vfio_listener_log_sync(MemoryListener *listener,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e3d571f8c845..ee18dafdb2ae 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -105,7 +105,7 @@ vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32,
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" -
0x%"PRIx64

 # container-base.c
-vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t
start, uint64_t dirty_pages) "
iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t flags, uint64_t
bitmap_size, uint64_t start, uint64_
t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" flags= 0x%"PRIx64" bitmap_size=0x%"PRIx64"
start=0x%"PRIx64" dirty_pages=%"
PRIu64

 # container.c
 vfio_container_disconnect(int fd) "close container->fd=%d"
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index e0af241c75cf..07ea0f430496 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -26,7 +26,6 @@ typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
     uint32_t ioas_id;
-    uint64_t dirty_tracking_flags;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index acbd48a18a3a..e88b690cf423 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -98,7 +98,7 @@ bool vfio_container_dirty_tracking_is_started(
 bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainerBase *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
+    uint64_t iova, uint64_t size, uint64_t flags, ram_addr_t ram_addr, Error **errp);

 GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);

@@ -252,12 +252,14 @@ struct VFIOIOMMUClass {
      * @vbmap: #VFIOBitmap internal bitmap structure
      * @iova: iova base address
      * @size: size of iova range
+     * @flags: flags to the dirty tracking query
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error.
      */
     int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
-                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
+                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, uint64_t flags,
+                Error **errp);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);

