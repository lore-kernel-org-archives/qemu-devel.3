Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18EEC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 22:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5B4c-0001U9-0O; Wed, 16 Apr 2025 18:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5B4a-0001TB-Fg
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:17:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5B4S-0003bi-Fi
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:17:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLMxuK012478;
 Wed, 16 Apr 2025 22:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/YisKGr9r3i4SHt7DRTRybnh4owx+v7A5yHoG3zY5Xw=; b=
 d1oqEDn4ZmU5SAAiuLKMKdH0w5TztQTotSVi4l7aF5OZVPRixb4Zt0zHixO6t/yx
 /1bVf1dXXo4Ts0P8KDmnhZS2CgCFeW+b6HFt9IrXzBEOaZ0cPDgSOw1j8beWF2uf
 E5Bh1x/a2xfXcOM0orvezbMso0/fF9o058j+2BKB2CPR8EHavDSPDR6emuvXbM27
 mmh6dBZjTDBtg+3CLcPdxw17pYvZpuFqnqfFQtNMCLv2n7oBZGvf3usCtSO9y1rP
 FUGKg+hNWaBZHzk1ySdwkBUu1BBpRqzCYEeozRlmDKRJMjUAsA/vE+DsqSO2gpCK
 kaYWG26Ip+PWF5cAjFV7iQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd524h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 22:17:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53GLFkw8030979; Wed, 16 Apr 2025 22:17:18 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460dbcvas4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 22:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiZ5G2UI8DK430jm8XO8PGWklYCCmzje4EtJgvXeVe9PaexqhIn/HrTCLP4bmrNQSyZRDDLAatK6aJhdaIgcXiDdakOVi6RZNboP1CXBAe1OJSsXAwQ85FniZDFg1oiDQZhT+LQnsaETqcQ1xaYElUm+hZRInUCW56160OMP2SEwky+MEfLCtz40jBDF4ApO1Ml/pzWy2pW7bf5t8ePjdwXEE4Yc9B4vSZ+qAviZjVNOKb/Fv0KdM1x88nkkRgOv4cw2Eb/1CG/x4/nV1+yd8yXGFl0ymWZJHJ/lmg800MnLxTawIM0xKYAa0CNNaE0xMOSkAeLaQZplrhbzSpZ/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YisKGr9r3i4SHt7DRTRybnh4owx+v7A5yHoG3zY5Xw=;
 b=ygxU6waWkVbFoIcqIGyZCb66o+mZzj/JIievAE5TKF0k4YhDYKzk3xpY908dxHGy/pBQDqFuNGmc7gD2E9bkODduSNrqAyTel6nbQhqZZE5zy9j7/d7POROZZIX3Un1xozBIIZuHEbTJFy3vOB3VKkJEOw7crwkx3PfEP+uIZIx8ekLBowznTAMYYkapcvhs3SYUb78c2sLq8w1VE8ZoXRZwOzQQyEaeDxCafGfKO+xI3WsC/f81rgU9Jsdvf17MMVwXgXypqO9nzV/Er5+dMRQ0jXbB2GI8VKS763xWCIE4PUvAdcDzOb1yF5wojmiCFfCLHOtOwLrIBYU/6Jsu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YisKGr9r3i4SHt7DRTRybnh4owx+v7A5yHoG3zY5Xw=;
 b=J0Nvn2QxTWBNO9ZyImaJo26HxFVt+sgY8kamL9dSct44iPF9RUiugUYkax/PicpW9oNSzYTaGGBLHnVrAOq7aTnzws82gHxNT3ALcBOTdtO1zllHaFrMVoETONnZuCOW1zyZRGRbeMyFgx/hIGGi7lgqNJ8YE5971bvss6me/1I=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 IA0PR10MB7304.namprd10.prod.outlook.com (2603:10b6:208:40e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 22:17:13 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 22:17:13 +0000
Message-ID: <f14bf894-0c95-4bcf-8a7c-25dfa7ebe76d@oracle.com>
Date: Wed, 16 Apr 2025 18:17:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] amd_iommu: Add support for IOMMU notifier
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
 <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|IA0PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 162823c8-d952-49bc-336a-08dd7d347033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHVhUDBGVmxQTnBRMXd6QjkzejFoUVVKamhVZmYrQjhZOHdPb3llcUZzSlhr?=
 =?utf-8?B?em95ek44b2tPM0lQOEgyNUxWUGhrRkhJR2NsbVp4bnk3SHhxS1Z3UW9jNnNK?=
 =?utf-8?B?WWU4clJUVkxQZ3gzQXRrN1lFcytweGZpTHNBbXdBYVRrT3o5bjFUaEVGZk01?=
 =?utf-8?B?OHBHTlJQSXdrVWFCRitMT0JDa1M1VGJOZmJaL3BjdWtvVU5wVjUyV0NSdlE5?=
 =?utf-8?B?NnRNTVN1cHEycy84dFdrSDYyOFJib1VRTVlmbFliTmJpL2lpZUFYWFlZeUdR?=
 =?utf-8?B?ME1WcVVFZlA0dmQ1SVFZS1k0UkdOODA4blUxMk5nVFJCWHNreGtDdXRHYldL?=
 =?utf-8?B?N1pHNGgwa1NLZitDRUVLK01NSlZWbXVZOGNucG5GRDIxNjBPS1Y3MUl4UEps?=
 =?utf-8?B?bU4wdlluT0dqbjRXZExFUmNkYVRLMjE2U01OSUNFbVhpNjVkT21NanFBMFE3?=
 =?utf-8?B?NUprdy9zaGVaUnY0S1RQYzA3SXdlaC95N3VsN0lQa1VLdEwzUERuM0MyOWdw?=
 =?utf-8?B?QVgrUVZGZ3VzQmlpWnVDdmsxMzdjWldWN1lPTXBJNzZjdlVOWlBkVVBPQWlF?=
 =?utf-8?B?My8reitVUTFuOUV6YVF2NkRFWDFhUldrb0cwUjZwOXJQejBWZVBsWVI2MWY3?=
 =?utf-8?B?OWkvN0V3ODNRUWpXRnplblc3UksrRGE4Mzc5MUF1VWJWNk9ienpjVGVGZlhC?=
 =?utf-8?B?dTVCd2VDNUp2Nm4rNHhSeG5jTEhKbmNjVkhUMmFyWVlXUVYxeUg0WGFWOTVN?=
 =?utf-8?B?WTFVNm9vVWFmeklFZ2dBblFVcXp6clRhaG9SZG5wMXJ0K3N2cWZJbS9sUDFt?=
 =?utf-8?B?NGFGNjRRSWVnOE5XVzR0bisyNHUxQkRaUXpZMDd3TFBYNVdHSlJ4MkllMzdK?=
 =?utf-8?B?Vm9TVDhEMkt0cHdZb1pPZ05NSG5yTEp2U1FBU0x0OUxlU3VPcURvRGhKTFdj?=
 =?utf-8?B?VCsva3BkZ1F3QkR2KzNQYWM2UGZrT2s0eHp5ZFo0b2prL05sNUJKZ2tuUVB1?=
 =?utf-8?B?YVlpU08xMjZvNnhxRU9sY1BQNHFJNUJXVHdaY2ZFaUo1a29KR2cwd3MwcitK?=
 =?utf-8?B?ZUJQVUU5ZFVTZFY2VlZMWVNWSXp2ekRoVWtlZG1hdWd1dlQ1VlE5WHk5QmlO?=
 =?utf-8?B?T3g0cXo0WitqOFFjblNDc3puWnhrZUMzdE9TOXRKM091Z0xRSGhINkxJNWVk?=
 =?utf-8?B?TGRtMjdxd0orNmw1SGdrajZIM3ZDcnFvODh3cGZINi9BM0t4bkZDK3ZEdTFa?=
 =?utf-8?B?MG51S1RSY1NQeXhnS2RrL0pEc2JxSUhjaWlzTXg0ZnFkbkxpam1STjc2d291?=
 =?utf-8?B?TUdQK1JRTzVmblZYVmVWZ0ViTy9XQVAxOXVUTHVGdm80K0hyYUxoemoyY3Bu?=
 =?utf-8?B?aDEyMS9hamtwWmNYaS9sSkx3R3cxUUlXaGJrTVhoSmo0RFd4bkV5T3dESnk5?=
 =?utf-8?B?MjVNVk5qN3hCUVBkRlFURFFIZ1NsYU9IMlR1MHNyVWxTYnJSMEFGSDVEOS93?=
 =?utf-8?B?WHQ5cEVKNkc1WlN2Z2R0UTAyTHFsOWNIZGNZOFdWMlNYRkFwaFppUXN4T2tq?=
 =?utf-8?B?RUhVTmFDN2FFV1VtditoMjROS05zNTc2RCt5YXcrR3hDSlRWUUhoYTZ1b3Zm?=
 =?utf-8?B?Ry9TS1VZS0FKQW9EQTJ0cUlIVXpMZHBVTkJSSVh6ODI2YjE0V3JiT3dLdGJp?=
 =?utf-8?B?bnFmdXdjK1kxbVNrM0dXUjI3cUYybXR0elc5OGZtR1p0T0UreFRwNXBPay9r?=
 =?utf-8?B?UFRUaWhobXowNVZEYlV5SmlaZFNVMEVvZ1dVTkY2ZTIwbWl3Ymd6ZWhJWnMr?=
 =?utf-8?B?ckVMK0FJelVKUUE0bUt6M21yS0ErYWRyZVRibXRVa1ZPdkdHSmQyQkFXZENo?=
 =?utf-8?B?TUVKRUVkZWpza1ZlNnZZTXl2QkZ3WitFbFhuZnNibFV1eUowL3dUQlNHTGxi?=
 =?utf-8?Q?tYQShBjnFas=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWw4TUNJd29zZkk2WDhrejZ2RVJGMGc1QTdNbzQ3RlpWeUJMSmlKbkFDVmcy?=
 =?utf-8?B?V1FZSGxxNkpTNGVESEw4VnBxMEJUZkFQUExIK2hCb0VlSUJpRmFlWVA0TUZS?=
 =?utf-8?B?c0RNL0lJaGhQWkUyMVZzVE5OUTlUNDY0WnltRHJGcTR4blA1Z0RXZnEvcTJV?=
 =?utf-8?B?YlY4OHRQT1NhUWJRa3VocmdrQlJvS3Y1cjFnM1dicjcvVzR3UUNOUW5YT0RI?=
 =?utf-8?B?MVY1QlpDTk9pb1pjVmFxWGF5Znl2bnFnS3lncVoxdFlOazJ4RFVCV3NRRjhU?=
 =?utf-8?B?dlh0WFZNQXMwdlFTVWQ5U0VOUmxCY3JEakFkVnVyMk12aEQzS295VHNvNCtt?=
 =?utf-8?B?eDNlZnBYL0d4UHUzZjUzUXJLWEV2WjREWjlLZHdnNllsOFRucXBoOUlycG1D?=
 =?utf-8?B?UzBmUWNvamp0WkpNdzAra09CaW83dFhjdjNyeWZjTENsaFNySm14YU56dTRY?=
 =?utf-8?B?OER4eSszbEgvRnF4M1UwNk95MFY2TXN0aEhNaC9hU0VDNGZzY0ZCbzRHWTE4?=
 =?utf-8?B?MnhIZnlGZUwrK1B5Tm9OUitCM2U0ZjNLblRGcUFSZDZBUzl2SDZnMFNTSzdV?=
 =?utf-8?B?N0pPeXB6SEoxUUNjb0RFUGQrZzZNbStHWE5FNVBMU01OYlFLdkhGUkhTZ1RQ?=
 =?utf-8?B?VWVHRWpsbW1ScG1GL2RvWmRQck5MS1dGNkg1UG1zMHJJUUd2WjNaMzBQbUw5?=
 =?utf-8?B?S1pmK2RuK3dsZ1lhZnVlOTgzUTlTcDJtV3doYWtRSjg2SmJ2VVB4SUF5VHR3?=
 =?utf-8?B?b3cvbUx1cmpjTEk2OStRTjArY05pQkNMcFFtSDRtdFV5bTlSYWVJNDZ2MGRT?=
 =?utf-8?B?MUlrS3h0YnFYWGF3OXNmYTAzdXlkWmJ2QmIwaUZXalNjekN4Q2QvV0J0S25I?=
 =?utf-8?B?dGJob0F3bXR0NFdhenJXOTJHQ3dNK2EwTmZ3K1NjMGNtVHVDb2tKYzF0UGZH?=
 =?utf-8?B?anZEbWhIV1hJUVo5ejFRVmtIbE1DNHdTY1BoVDNiM1dRY0t2RFJUZ0xOZHgy?=
 =?utf-8?B?dC9HZmN5dlp0T0hFTUVCWlRkTFFmdDJDUk0rSnpxL1dYUVBxcEtQWEpPaUFG?=
 =?utf-8?B?NXR0d1EvWjVtcVNtaGIrK05hWHFWMnRSUk5JOXVtcWFGaXE4Y0h6T0Y0QzV5?=
 =?utf-8?B?TlZFSStGbXBobFdoZFBKeWRXT2ZSVnZzazBjUHRyWDk4c3czL0VpaFhVTnFN?=
 =?utf-8?B?emM2WE1OS0tOY3BCK2NwQmRQelJtb0s1SGlyeFdST3FoRTNoOUFCRXFtYVJr?=
 =?utf-8?B?OTVpb0s1U2RPcHRzYjF1TzRueTlkVStjRGMzYTRiV3hFb3BJdjBndHF3SDQ3?=
 =?utf-8?B?ZWo0dFBKckdtMjBRU2VneXVyb3VNbkNMSG1VOE1wcFF4dzRDUE5XZklSRjFY?=
 =?utf-8?B?eGhUb1VuMS84ZlViOHZXeHFWb0hDOUZFQU4vN1kzRFlmWktHa0NpNzNWQTd1?=
 =?utf-8?B?MW5ScmdWWGpQWjcrejVvMmVIQzd4YVg5cXdhYjdpdUUvdS83clB0NTROME82?=
 =?utf-8?B?RC9NK3Z1cHc5cm1TVjhkd0RTVFJDb1BDQnhzVUcwQkQzcU9aS0ZkNlVIancx?=
 =?utf-8?B?MU1lMkFNSlVzK1llOTdRM3ZxRXpiU2pUUHJPVVFkcUdNM0tRWWhvU0R0a1kv?=
 =?utf-8?B?RzI5djJNcGNncGZCdlRTdEdlYndwQXdPWlBZcnBwTDVxVU9Ia2MzZElyK0pP?=
 =?utf-8?B?TlVZT3ArRHBiOGxvNGJMejJtZE1NMURpZWpRM3E2cjdnYmMxS3lqNTd2QjVE?=
 =?utf-8?B?cTZwV21LY0VBZzBsNUMrbUlxdmduL25WWnBpdHdXMmo2ZDdheXpIMVp6b0VO?=
 =?utf-8?B?eTY5UkNyR0IzdXcvZW5vT2RiT00zK1EyNUM0RUx5LzFHcURqSGMrb1dQZU9s?=
 =?utf-8?B?K1BNckVxdTFhZ0FSdytldGQvQTh2K1FOMWFVVHo4aU1Kb3QzK09qVUV4YjJs?=
 =?utf-8?B?am5FSy8vbWYwdGFsRFowNytpUVNjMytoNUpDRXlLQ3dXOWZWYlVXUXNpelFx?=
 =?utf-8?B?WWN3NE1WekhPcUV4cDd5aFVWbHB4cGlhQXo5YzE0NnZlRUp2WFNBWStwbno0?=
 =?utf-8?B?SVE4Y0x4eGh5NXJLV3k5WGE4NWRMWDl1bDZYTHpBay9GdTcrQUtRMW85OHJZ?=
 =?utf-8?B?QWZSNU5VZ3VlaERsYnhFMmQ3blR1ZFk5Qm9sVk4zNlNnc2htM2dnMFJtUkhL?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FoEDqTd2sCeEgH1LPGUb7s1gUr6YfI9j4feuHDkwYA+UKGJbgNJ+IkIJ/F9mHu0ZoGwmZChw2J0EsQNjErUQnQy4u1DeULxm8meivB3cPOUm2k8FC3QBsqkRFhMfTNhiZ4SFvglmJ/Z7wOqvYHulmuwpgw6AFXA2Nxgg+JsEEQ+JAHBJdENyMRZlp2QV6glJi39+kZCtCBTjAlbpBQZRIRsFWQ4XS/y/MY6E8oE6YzkB0xRFm4t7WZmarf9UeIWFbiOuw0STKCz8RSjLtvXr2NkBjIGp5BGuB2PVVwsK6Pc4H2X/a1rlRKHX/SUmAJ1UTGLErorQOtNpdxC5T3jEnGhWzdAVrnlqwuIe9FWZkH/VILIPE6W1z9kX/FpiLq8oKKVuIrauTYN2OIbQbdelvIZMZL8JRsP/KXdKs4gYYTUNCh9aCSu2ukoLe/gTCPElhyZTYHCRJzpRs85dz5cNzHMrOd8iHEgRJ62pdm9H/PSzXZAPc/uyHLzhgNys94HyC1CLc6kMs0kWkdeC/78fvvsqtncIHpAbOPtVIvGi0Z5eEBL0aFbmx7LiIyjL8hGhIBdyJYFlU0hgnJeAfiZVYRUKxLoIZtNETuqHo+/jTBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162823c8-d952-49bc-336a-08dd7d347033
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:17:13.2827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdJmmc0b8b0L0o15yL2Ew6p9SWm6bCi0SRRudvesintqAaAnqfvyrGRiXfmzyNBIapYSBbwGYaskL3dntbC9iRSpniPGxL1jIVe4HEqr56s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160178
X-Proofpoint-ORIG-GUID: FpcEIJ1VY7j-O0xvxwe5d_v-7n60xtko
X-Proofpoint-GUID: FpcEIJ1VY7j-O0xvxwe5d_v-7n60xtko
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 4/16/25 8:14 AM, Sairaj Kodilkar wrote:

>> +
>> +    /* DMA address translation support */
>> +    IOMMUNotifierFlag notifier_flags;
>> +    /* entry in list of Address spaces with registered notifiers */
>> +    QLIST_ENTRY(AMDVIAddressSpace) next;
>> +    /* DMA address translation active */
>> +    bool addr_translation;
> 
> I dont see any use of addr_translation in current patch.
> maybe define it when you are really need this flag ?

ACK. I can move it to a later patch. My rationale was that this patch is 
adding all the new structure members that will be needed, but it makes 
sense to split it.


>>       return 0;
>>   }
>> @@ -1700,6 +1721,7 @@ static void amdvi_sysbus_realize(DeviceState 
>> *dev, Error **errp)
>>   static const Property amdvi_properties[] = {
>>       DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
>> +    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
>>   };
> 
> Please add a description in commit message for this flag

Will change in next revision.

> 
>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 28125130c6fc..e12ecade4baa 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -365,12 +365,18 @@ struct AMDVIState {
>>       /* for each served device */
>>       AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
>> +    /* list of address spaces with registered notifiers */
>> +    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
>> +
>>       /* IOTLB */
>>       GHashTable *iotlb;
>>       /* Interrupt remapping */
>>       bool ga_enabled;
>>       bool xtsup;
>> +
>> +    /* DMA address translation */
>> +    bool dma_remap;
> 
> I think you should use this flag in the remapping path as well.
> I am aware that you are using it later in this series to switch the
> address space, but current patch will make things inconsistent for
> emulated and vfio devices (possibly breaking the bisect).

The change in behavior happens only if the user explicitly sets 
dma-remap=on property in the command line, which is why I made it off by 
default.

To eliminate the possibility of using dma-remap=on before all the 
infrastructure to support it is in place, I will move this patch and 
[5/18] to the end of the series. Does that address your concern?

> 
> Also newer AMD IVRS format provides a HATDis bit (Table 96 in IOMMU
> Specs [1]), informing the guest kernel that V1 page table is disabled in
> the IOMMU. 

Sounds like this mechanism could have been used until now to prevent the 
scenario where we can have the guest request DMA remapping and the 
vIOMMU doesn't have the capability. Seems moot now that we are actually 
adding the capability.


Its good idea to set this bit in IVRS when dma_remap=false.
> This way a "HATDis bit aware" guest can enable iommu.passthrough.

I'd need to research how to implement this, but isn't this enhancement 
better added in separate series, since it also requires a companion 
Linux change? I don't recall the Linux driver being "HATDis aware" (or 
even HATS aware for that matter), but perhaps I am mistaken...


> 
> Also, is it a good idea to have default value for dma_remap=false ?
> Consider the guest which is not aware of HATDis bit. Things will break 
> if such guest boots with iommu.passthrough=0 (recreating the pt=on
> scenario).

That is not new, that is the current behavior that this series is trying 
to fix by adding the missing functionality.

As far as the default value for dma-remap property, I think it must be 
set to 0/false (i.e. current behavior unchanged) until we deem the DMA 
remapping feature stable enough to be made available for guests.
On that topic, maybe it should be an experimental feature for now i.e. 
"x-dma-remap".


> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech- 
> docs/specifications/48882_IOMMU.pdf
> 
> Regards
> Sairaj Kodilkar
> 
> PS: Sorry If I missed something here, I haven't progressed much in the 
> series.

No problem at all, the feedback is appreciated.

Thank you,
Alejandro


> 
>>   };
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s);
> 


