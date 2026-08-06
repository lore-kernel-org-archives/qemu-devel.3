Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921CDC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 22:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws6Om-0003Tp-On; Thu, 06 Aug 2026 18:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ws6Oj-0003Te-O2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 18:17:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ws6Og-0005ml-VJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 18:17:09 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676Fu1LR3084675; Thu, 6 Aug 2026 22:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=emT9JraSjdoofYlG7DGkBQ6M+edIfzLmK+6WhG2HtSo=; b=
 EjWMPG0PTd1T/UaKrgq78sj7Xa44G8Bc29+znpQvVvmKBLz5jAr7nFaNQXIdCocQ
 mxIZKFoMHp5LDG6qlft3rKDl8rv6YsjdNPrgx3p+ohG4fqC4GLlvqTgtApXF5F6Z
 l6LvmoH2xgDKN4D1OJt3o2x+72iyn9//5Ra1Arz/eDAa78KUm3hIdZLt/cHPrjKM
 SJyi4XlumQLBeAqThk3y5A1TwWaeunNPEuC7Anu4qhyvVIrfR274m4kvq81FIFLH
 id2OsW2Awg3BR7BA0M7QPzFg/j8I5a1Yt10UKHXVRMUHDRXhUMgav55uZ7jokooW
 4MADJdGOWqRjbFZIH9TAUQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7k3puv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Aug 2026 22:17:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 676M5GjY017896; Thu, 6 Aug 2026 22:17:02 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ftpyvcq0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 06 Aug 2026 22:17:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTGk/DoXb5p+fhMoexGjwgiBr7eSB3jefX7yzX4Ec1DvWBAYOkm2uBP41ombCbVUmEHwgm1kHsDOiYmT+I057eE6SBbJ3iprN6J97agWTnTbh00tI8hfsbW56kzYfA8Qp2QoZKyikT019MEnEzJj5UdoUhIujnYXt7pmgcbUNQNXguG7G/A9NXOAJaC0B86ZsJACW0Nn1mPMo+LurZqDawQliwQ3RJdy/+LsJ7HuRbt0F4nj4GQIO1US0EDpE2KJ1BTWuTuFbRCwLSCLBPLXbY//BMOZw+hzL18MLSFllbdNtczdHCciergpJSXKGxKAKBSCp/fdXLcJndrW0Z5gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emT9JraSjdoofYlG7DGkBQ6M+edIfzLmK+6WhG2HtSo=;
 b=xQVoziGooEiEEqF5+s0GmTjtGGoW2v1keRE8enkd0ZdbyPB/TDi1o7CJBpYL0OhQmUYO1cFN0J+Cfr1RCVftJUE+Qz6SJRhTNhLEMestjOQQ7mRJHTUvtg+e2c/ZFsflJaea2LS3ICoXiv0jwQD2w6eLxKAxuLm5ZG740gGlGagGS1m5uwnLJqA8VOzntILiQL3ETQRYjNMvY3Fi8i5Mt1aLpIA7be60XXfVA8Msl1ZqVyrLgsIBcxNg/NNGZxbEknTQnW6k6ZP9/bDA0Rxnc/J954FGx6uTBrJEF7oYrNGJFtDQTdS/Iy2kZOrg3P7aPcgkja9zsk0bUfdjpg7rKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emT9JraSjdoofYlG7DGkBQ6M+edIfzLmK+6WhG2HtSo=;
 b=KcO9m9ad2I5FZEzNNkgh3vzyu7UZI+c0Rwh+uj0DuPqweDZbF1hOFLdBPRVMclZJPudor9LlwYiPjNhwYBo5uSf6wg+Lpi3ArcAaaVGXJ2L3o97AN8OIBcNL7wlY98DvZdnOp0BXWntG/sfOsaT+ZnB2TDqqjNV0Fq5TC7zEWBU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA6PR10MB997635.namprd10.prod.outlook.com (2603:10b6:208:5dc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 22:17:00 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 22:16:59 +0000
Message-ID: <2eb6965a-6743-4f76-a232-77e4dddcd6c5@oracle.com>
Date: Thu, 6 Aug 2026 18:16:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Avoid undefined behavior in
 amdvi_setevent_bits()
To: Thomas Huth <thuth@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260731140229.259272-1-thuth@redhat.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260731140229.259272-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::9) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA6PR10MB997635:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c29901-fbfc-40ec-b781-08def4086f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UW5rmTOHdQY3q8bX3B4wDamjZt+EEi/dKTmkV0paKrdn1OruFyoaUqAGE2CKRzYCIF4kuslqHvkiyrDjshyrB2UQ3nMGsFCwkBgVgMKO//OdhgPDQoM/GEzXzHtnLw8nSfMTDE86cGzl1qdmjTUrz19SO89ICiL5e/W9BN7eLJlIWFIkgMSXq3eSKtqz2nWCdp3A+M3IbRxZU43Pb9d3ECMfILdv5jybt+D5zbDCmxjGcSOcyaeKMyX/n7s88siejL4Egk5D2svw0GbhveB9JF4/2GDcQtfF/S8GKlD93zIGwHrnGbMqTOoOOayHK9kFn+i+Xv3I6pbZ/l8RLejWW3Xr78J0Hx0BhoEpG6WWywmQCNwIcx1DkBPc7T1yr2BfFEUYzwK6h7a3stiH1ckAjhxRJW6EmzhH94sfHaxqaLongvSL7HFcUvoLE6a4AOx6KeuyU1LISUqy3ALBMNUEHrFBLjifzCwn10aKYmJvgZvE1+P5NejI3SZtd1a0p1NjYRrSCtrrJYQxc0FBXA7lijpeKuCjX/lIvCKHUNjHWMIzB+BjUcCLsedJkNXaPuTC9JY7bhfZhRQgEzA3kG8hIYdDbPChqQ7yqr8/ae7/dPtywAZn2jYbseJThWPYdH+AFAKnIq8+Z7/edejBkjGtTcjbxEHdjYlfsCg78iVyZLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVRNWQ1SWtWSDJhaENlM1EzL05JdVNXdHdibU9QRUlWREhaZERaUDA5YmZK?=
 =?utf-8?B?U1lZTm5pSTVyS01oOGxmdnVMaHFoYW5RblRxRXViUWhSVVFHQzJMbGZURmlU?=
 =?utf-8?B?ZmVzN0w0YkdxOVB2ckJ2dmlTWERWcEFFSXhjRWxWWitya1cvcnhQbnJiNHow?=
 =?utf-8?B?WjhGNzl3QnlNbUtxckh3SC9wK0JZbTVJSzNmTTFld3RCYWNuSVROZ3BuQzFG?=
 =?utf-8?B?REJFQTZvVEtkZk5HSDczUDRmbEJpdURoT0pLRSt6aHhvOU1rdEdHb1hOcUgx?=
 =?utf-8?B?UmZPM2tOZ3ZxdUhva2g3ZWJsaStadnhPTXg2dExsRFk5UjBtSGdZQkFYdTJn?=
 =?utf-8?B?MldyRUJyUHhaUnRsVEFpeW1haDQzRTZFUmhKaUUyelRZaFJEN2hyWVVRWWZ1?=
 =?utf-8?B?KzNrUDJWbFoybmNtbHdHMk5mOHVnbDRYZy9YTnRtZVNSa0dFZ2JKZm9pb1gw?=
 =?utf-8?B?RGxORWZNQk9aTnN4d3NPdXg5TlhHeXF1QWdBUnpSZEFvVHBTZ1FjaUk1NkxZ?=
 =?utf-8?B?dXhGMXorbFREdXFxU1NORHd1SE1GaVEzQmRiTHYwd3FUSWhIbkVKYko0M1pQ?=
 =?utf-8?B?dVpyNndXN0xSVVlUTktKWnMzYVp3LzFha29TVDZaN09WRWxQNXFjblZiekMy?=
 =?utf-8?B?di9zK2tFd3hzZVE3N0FXQW84N0xmYVNZcE1PeENzU1BMSVBPRTBPZnFxK2FB?=
 =?utf-8?B?QmdUeVhFUzlSZkxWZ0RIYU90Yzl5NEdHYjMrTTJjL1hJUjVPdGRaTjBPaXJ5?=
 =?utf-8?B?aXRqY2syQk9vUEd1UUlWaHVpQnRnUW8wZnFQazRtWndkWFBBR0RrUEsyWFZx?=
 =?utf-8?B?bjM5TVEvWGxoWUV6YVN5Q0pBQTVjOHUwZkh0MjRRa3Vra1FzZ0EvWUtYOThq?=
 =?utf-8?B?VnlUVGZpbnNHOWlWYTMwK2o0aGtycTYyR09JRlhjK3JHZGk4Uy9BQ2VGN0lm?=
 =?utf-8?B?ZHJ6REt2OVpJZUdESmlHSThyK1JRaWYyMWlVK0JjVG1MV0tNQXI1WGVYWkk1?=
 =?utf-8?B?VEwwRW9QbFd4UzFxRXpWSHVpYW5nR1cvQzRiNVpZdzl4c2VrZitGeU5sdEM1?=
 =?utf-8?B?c0tNbU9mWE5IcDdoczVXUFhPaDgxMUJjQUZFelN3UHZRc2V4eVFNNU8rWXgw?=
 =?utf-8?B?NVkxSXNnaGNIUEpLOGROV1hpQ0lTLzB4YnFBT0lFL25sazNJRkxDUjJST0x1?=
 =?utf-8?B?US84UEZDUmx3MExESnhhc1JsVk9WWVJYTS9PZ2NXdkRrU0Rwd0JaU2pDb0FI?=
 =?utf-8?B?eGM0R0hWSnBqMlVQcHh0anRPSGltSVNydDA5b0dwSXJhTGEzUVpMbTR1NHFQ?=
 =?utf-8?B?bGVrWkhJZjQ1MnB4Ynl0WWhWNzNhS1U0LzU0UldWZ0tRMnhxSTFjYTZlNlU3?=
 =?utf-8?B?d2Q2d0l3YUxmd1lybjM2MDl2UGJJS3FqRm5FbVB3QnVveTkwSk5uRCtWSXZv?=
 =?utf-8?B?c3d0ek45Y0xKNFpydml0WFV6Z1hIWEZXR0xSdkRJRXVrWm5KSWxoQkU4c29R?=
 =?utf-8?B?UklNSUF5Y0hoRmthdjhqSEg3eklVeXhRekZPaXhBTFdDMkkzcURsUEhCNEUy?=
 =?utf-8?B?WmE5SkJOMXl3aVdXUmo1bXJKYzBvTlVFRFZ3ZUpwVmRFdldWdmg3bUdvTmd4?=
 =?utf-8?B?T0RQclZsRWNrNlQvN2dPQTRoMm9HS0xvUTd3UFRoUXhnUFhKWkFiaVFKU0h0?=
 =?utf-8?B?K2RpMngraEErcXpsQkRuY2k0Mk9SazIyeGM4SWNTUElwUkt4dU8yeFoxNFBG?=
 =?utf-8?B?WHMrTVhXQ0R3bUVoN3Iza3VlRHp1ZEhDYVBYQlAyeG1menlPRHJSR2Q2R2c3?=
 =?utf-8?B?aDNkVmRoaWpHbDhUeVdDK09RNEQzRHFGZVpzU0FQYVRWMVVjU3Zra25OTURz?=
 =?utf-8?B?NExxQUtuNkhPQ1JQVnlWbmNFTEtrOXo1b0dUdWt5VUtyc05KVkQrSGNvd3N0?=
 =?utf-8?B?ajZUbnFiYXBDOGpHUndUdVdZVmNWQ0RBWVFLWXdYYXcwMmplU3N1NERReElq?=
 =?utf-8?B?VkJGaHNneG9WVklZTHY2cGMvQklKL1cxb29wTGFkMVdHU05ITkJNYjlsVFlE?=
 =?utf-8?B?UXl4c2kxNnZxREd1TERpeUk0QitOT2FNajQxMVI2TzNrRUlKZWpMbXZnOTB6?=
 =?utf-8?B?UGM3RWV6OHBrZ29mNU9HOE41cS9LbnI0U0xzemF4cFdJbjVvVGNMcUZheEEy?=
 =?utf-8?B?SUtGMmRxUVExVmZPbUM3V2huMHYyYzVXQTBtbW1EYXBUNWJVSGtwelJpbTFs?=
 =?utf-8?B?UWVHNUtDY2hUOXd1NEdJSnFTb05velZRbnk4Kyt0NWp4dW1mT1RQc3hPWU5T?=
 =?utf-8?B?VXpaVTlFcmFLbkk3OXpNY2ZvZjhsZ0N1VmNXQ0JVS1N2djRUcm5CMU42bng0?=
 =?utf-8?Q?LXzC67J87bEnDO3w=3D?=
X-Exchange-RoutingPolicyChecked: PzXY9dUxqp4kDQKWaExsGwAfq/RIseSWOp99C+Ed//WY0nBVmDX5N3iKDLFHnNhULg0clZjm5Ok8F1UPfczTopWub29NHNXF743v1YS8SvTo/DtK1uludJ4SuTRznMF2EKhN46Sk4o4GT0gvXfpXuZo4fG7C5Oz5V8758Zn/XyglK2lMPaAd9TCyQV7AZUCirPAz68ZwJ5J34V7WfyI1kDlKwRTAgJHcPjGDvFpPo1R7qUt57w7j5z+Yq97417dN3qOpW0cWRhP5usd9O+Ni6vKzrrNo42iR1bWrXU/PxTszP+G68SyKNULanG5uu+bAyrWuxA7XzJkroC8JlVxGhw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NZquTOnZiqu8ZITYDyZppl0n4m+sSVewJB01XYygvWAkvqsL694elTWy3FOvaf30TE2uvnoPhIZm9cCK9ZNt9LkVyOLefONI+0bvEXhasUVj7xo5ZFhMtSeMlBqPAR5PVfKIlvaiiMa33mKgx4egcd43U5aQpKzkXfe5Bs8Wvtkc6Dl6jW/CZYrH7A0IgoQHfjK3EBOR4uuwFVt6mz0nPc55QqhG/ztJ2S3MBzLScCnnHM9OWIPt/z+r/Ft0mD0r1HN3NWi+tARL87ucnzuiCOleIsF5B/+VSQ1tToTMEI/5ArWHjmPFuAPkBQA3ljt1AbwVhXvt1feDf9nuXv7CUSmMuDV6bl+i9zh+CB4x0tlhM8UxEn2+X6oog3KfLegrmBiNsnVXTEVMoHFd3iYQCTWfBrSjNuLQyC3pRrkgkjSSPg5C0myERsF4a6D2nDUIMR1Tv1jsme1PXYaNtonAs/yAh2ygybsXFKS5eogi2T5THoBbn7HGklGo7oPJDoCXddAw5yRcz4roTuu/kZMTfaLpMboLdSPXN2d8fS4uck442xIV6UWwt1OgNyDGrWPif0b9AHtIQsVTJa82ez6Bn3ZXlp8Mg/M+/LI1QTWIGe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c29901-fbfc-40ec-b781-08def4086f2e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 22:16:59.7357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxBuwzeeTz0dOQ6RYgq78wbsp8HzstCf3L7cL+5+RYWXUOpvyY1yePE2QP6VmXkul7TiecmC5eJgmo0qNCx4kh8FiXt4x+RHn5IsJfX7Ej8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_03,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608060173
X-Proofpoint-GUID: OMZ0FDLYCy8igiKNeOC2OBZi74aSdJOi
X-Proofpoint-ORIG-GUID: OMZ0FDLYCy8igiKNeOC2OBZi74aSdJOi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3NCBTYWx0ZWRfX8Ihqw6RkK8Fs
 BvwwRd2fMKZfEiYvcI7O/wrPEAzWSxQU4C3MPPI622lifltfYtTSYK/DbCwv9lGw5B4e8Su7KST
 OOcDD0Sw7yV/UIb+nbouWnUX4kVreXek5Mag9HdVUiQ2Ayfd2bSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3NCBTYWx0ZWRfX+sPou5T8oqK+
 jor77w1PweOmfcYM2tvdzE8lpyb8hXG8yk3KWlNnvgYn0G29h4Up62RNd6n3UYX8I2Wd8rEZgzw
 gHW5NKj3h2NpgKTAfm888j/sdf583CoZZgZ7T6ow9BzM+U8J880u7dpgV29PHIDiWBkubTC/1s9
 acHOuaO1vIR7gT/pUtRsXlSsm3Pud8543a4pc859CqM2nV2nxomoUYsJ7rav/XVDLneERc6lmn1
 mM/iIT2fPTjW9PzowBkq1gddVkCe5ZiruTC8y7KRuoZnypRmDAQ79K7wV0dQsBemRspLf2ugBAk
 cErFu6varOJ+YOMt33nq6wLrSnn5DpW6a5iF38itkk80ZGIVWd8TOZ5cuoibbNN569cMsIkbAFy
 Nsz5YMrFd6ryvvy49nb+jOAf5TsPeRmF2MS7M6OSRMTGZvqgenH8VD7kFkg40j1bbBLSnT/0Dfe
 rabMAUmM/GjWYZh7o4Q==
X-Authority-Analysis: v=2.4 cv=Iqcutr/g c=1 sm=1 tr=0 ts=6a7507df cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=p0WdMEafAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=vGRkSUyC4P8OHElq2qIA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Thomas,

nit: The commit subject prefix should simply be "amd_iommu".

On 7/31/26 10:02 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The code in amdvi_encode_event() calls amdvi_setevent_bits() with
> start = 64:
> 
>     amdvi_setevent_bits(evt, addr, 64, 64);
> 
> and amdvi_setevent_bits() then calculates:
> 
>     uint64_t mask = MAKE_64BIT_MASK(start, length);
> 
> but this MAKE_64BIT_MASK() macro shifts a value left by "start" bit
> positions. Shifting left by more than 63 is undefined behavior and
> could have unexpected results with different compilers / architectures.
> 
> Fix it by using "bitpos" instead, which was likely the original
> intended behavior anyway. (bitpos is calculated as bitpos = start % 64).
>


Fixes: 1d5b128cbeea ("hw/iommu: Fix problems reported by Coverity scan")

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3633
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
>  hw/i386/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 90252c52af4..578c27ccbef 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -323,7 +323,7 @@ static void amdvi_setevent_bits(uint64_t *buffer, uint64_t value, int start,
>                                  int length)
>  {
>      int index = start / 64, bitpos = start % 64;
> -    uint64_t mask = MAKE_64BIT_MASK(start, length);
> +    uint64_t mask = MAKE_64BIT_MASK(bitpos, length);
>      buffer[index] &= ~mask;
>      buffer[index] |= (value << bitpos) & mask;
>  }
> -- 
> 2.55.0
> 


