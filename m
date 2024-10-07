Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8BACF8870
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuj2-0003t0-QZ; Mon, 07 Oct 2024 16:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxuj0-0003sj-Ng
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:53:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxuiy-00060R-Ff
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:53:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497K0bqe014977;
 Mon, 7 Oct 2024 20:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ch8huLdJ58glb/6Eh46CoHWbC2RjIDHauNbkWRjP148=; b=
 CUpxSopt+JNihVuV5XeMumTP5QJtW2f7PFov3CygkKBs3OU8ZWBA5sxYey0hn6if
 krOpd2q4iHvq4jftbkKCgzNLC/t7iyE9jArBvdSh3PL+gpBo+5ePKt4d4D5HngAH
 d35wT6JTAVk6YiZVf5Rm+ssd2B4VKd+bruPEFJqZtK/pwzJ4iyUcXh8wbsCeSTT+
 f2idOdgEe7jvSzvwxniEigvk+z09qqRAENRI9cgXIY9rWTaDj9YQ56OF5ExdIq38
 8Pgn9mrJKlvLSb8NmPAhNqtVS0pur2JHiUCLKhTP6pUIf9VwMan1azpiZOf41Bbo
 xEUDH0Bl6ZzYMhyxTvMsnw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pc9c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 20:52:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497Kd79X012403; Mon, 7 Oct 2024 20:52:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw6a31t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 20:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY0by70HXTnPkD5lCISfeOMPJ/GD4T0WCrPwjZtkpKUrEzAwzCm7DpxjSoC0Xg8uTtUgxoLO+q8AeEcJz4onBr+rcAJWSmDnmskcL93xT/BwYj4/MWlPf88R63XMVZaa+jYbPGrvFeyGJt/9spoDAi6yKGuTTd9/zrMLdhAAxqRVMf3cv65O4lQKBXWwlPTyvadguLLoYKa7KZHfLOnP+rmr13qXiyRgqQ1WF4q67zxdevdgDahjX5BAuGnylmF4uFc8ZHmrdO/ADJGxzX3JCZbgIzH+eh2BzG0QmPWMSSMWLaFhsghJyqQ5+qfykQ4Q8/lUu1TZMqz8UJkBbBBYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch8huLdJ58glb/6Eh46CoHWbC2RjIDHauNbkWRjP148=;
 b=cUSX2r0MgXVx8pr6MpYCs2+85y52cyb9v4Vk+vMzDHZSPZjW4KkfdHdPxzwD6taLFLhEzmR/QOus5XERQWioFY5IpGtTNz4XIymjRF3Lp/khFddVjzIvCpym9Vbs9ZrNji5wxNmzbSOF6JQ+ohqcX5L9PJGcRbQwrmrmNv48kCM/WtDJE7ZN/FhCz8vygsR2yrtRzNln2fDvgmA26bHFeV0eRzZvBdfbyWMmuvojCyDbge/SiaqHne3Bd+Numr46htQIx/ipff8KMkPe5jOYOGbvMgFvIJcY3pQGgRmwVpo7YzL2FVR2dXchwbE44yDxFcvO5trEbpyvjZ0l6EpzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch8huLdJ58glb/6Eh46CoHWbC2RjIDHauNbkWRjP148=;
 b=W45fXlMjCAJAVBeLPxYf4sMDTLTzYXaySRYJQrebnrlXsYe12tZxB3tIaWlUjLP73oddXJ7FE7JpRzG8ZsW6j7d8UzASsbPAQxtAH1qSsINVE17UScEWEYLciRBrAAvABjPhE1EcXTHFLj7rhB7Y8EXLw0YefFTvocSy1L1rAso=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 20:52:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:52:49 +0000
Message-ID: <17296eae-6d66-44c9-8355-39ad6a517a87@oracle.com>
Date: Mon, 7 Oct 2024 16:52:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/13] migration: stop vm earlier for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-5-git-send-email-steven.sistare@oracle.com>
 <ZwP9ynimqzlmJ3uT@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwP9ynimqzlmJ3uT@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c18388-0f36-4d38-f4f6-08dce7120148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ti9uSWt2cTMxSU5TRStRRnJGeHByTEEzeWwxTUh3ZkNSaDJzY2NRU3ZKbjFN?=
 =?utf-8?B?Mk1lc0FKY1Z4ZWVGWUw0RzdUeGNQOFQxNDJnQlBtTWFCMXArUzFuTFRsZUNw?=
 =?utf-8?B?bGpKUFNZdXpLWkhDNUljZy9zQjVoZUVEMFQxU3RTdURGTnlrWnlwcWQxa2kw?=
 =?utf-8?B?NmdhMGgzNWNEaWRDeGp5Z1M3c05MdFZkRi80YWM3c1ZhMUs4RUZGbXdNK3lO?=
 =?utf-8?B?ZXV1TWNiT1A2dGpHRnQwM21qZlhPSmlMaVpvN0RoNUpLaVRsditRN2xRSFlE?=
 =?utf-8?B?OFpoT3V2ZUh5ZC9rYU5aZ2U2empsQkxXS085T0J3V3hRdXZlaGp1cVI4MnBV?=
 =?utf-8?B?KytqeVQ1WExlbFd6QlpHaFlEeDhtdkZ6S0dWOWs3OEpBMTlzOVJvQnhlendF?=
 =?utf-8?B?UFVRYkZPckZVVkdqajFHVUc2WHA1bzFUQ1pKZkZjMVVCRHFLU0tKeEpmdGZE?=
 =?utf-8?B?T1dNMkV4Y1RyWllkMk1oK2FVTEdmdVNvMGM3YTdSMWVPTGxEbUhTZy9HbmZM?=
 =?utf-8?B?QUpnWkpjZHRvak0zbzJqV1liNmRjcUgxSWVneXlacFNITVhoeWhmWlk4SGky?=
 =?utf-8?B?K3hwU20wYkVYbXNiZ25HWWZ0NU15NXVkT2ZKNDdxWTIxeGJQOElDcDFUcWxa?=
 =?utf-8?B?Y3JrdzRFSU1XenB4Z3hDYWd0bENzcGhuR3pmMlFYMmlDYUphTXgzL1NPQlRC?=
 =?utf-8?B?cWpjVE4ySWt3bjYwaHRiaFNzMlFYNzlVMlNLMXluZDJFT3NKYWUrbDlObXNa?=
 =?utf-8?B?SEV2VnRBMmlGQ25hc1RvRGI1VGV2V0JYZHlwN05wbmd3SHdJRUIyQlcveXda?=
 =?utf-8?B?ckNsNWEzOHNRS0ZPWktGNWJHaWJPbGZwdkZxWlNhV3E1dVpzczRBOTFYaTZo?=
 =?utf-8?B?NU9hbFkxNjVKUWVhcE1zMnZqellVZEJ0Q05aaFpybEo4UE8vWGFLcm1NRkt0?=
 =?utf-8?B?dzJSZi9Kc09FUit5cXFhQlZTQkI1ZEpVbHJGWGVFc1hDSTNQSUhtRHZmdzFi?=
 =?utf-8?B?ZVdJdEpNQis5SkhXYitXY2pwZXZEN0lWTERsaWEyUlpPd3c5SmFWcFFYUGtG?=
 =?utf-8?B?aWNPbDg4SXN1MVA0V2xPOTlKbVlNMWZkQVQyclhuQ1NFOFZrODc5WWduQzdq?=
 =?utf-8?B?Q3JhenhlSGM3TTVkVEVYblcveXpUaTBaRTlSM25IcTNvckRzT3UydUt1MjFs?=
 =?utf-8?B?d3pDTTI0dm5rMUp4R21XOUhjRmU5T1JCMGlrWDdEOWFpSjMwWUdRdkkyTEhW?=
 =?utf-8?B?L3doaFphR3BDL1dHYWQ5NnBBdUt2UmxxaHdhN3JWSXVWN2xZNURUL2NWUW9P?=
 =?utf-8?B?cDFheXdtd0F2a1dCMlBndDdOZENtQ2FhWmJWbkhoYU80UUIvOU8wTG1BQjhw?=
 =?utf-8?B?dTBNRXVIWEZGMkpHWndEYUtTZ1p4KytMWGlwWEh1QWp2bG5MeG0rQ3gwV1FM?=
 =?utf-8?B?RGJiK29kWGZ2bll4ejl6NFF2UWxicTYrK0hCOEhyT2QreC9hQ2ZZQ05VdUFm?=
 =?utf-8?B?Z2o0SGlQdXJkbE5OYjFzNDR2cE8yRHRieThhbEdMejBFMTYzZmNvQWZ5T2J2?=
 =?utf-8?B?cE1aVFFvc01SQ1VXaWNhRUtUUmFrL1lmQjhiZzl4SnF6YTB0WTdTT1JFbkI0?=
 =?utf-8?B?MEwwZEZNM2M0MitSTGlWZGVLbEJIQjNEa1EvRzNhd21scjNCZWlFUWZOSnUv?=
 =?utf-8?B?WUs5bkFYMEtGZDRoZ2lDWE1ybzVOZ1FTUExYMFUzSHFpNEhZMGhmSDBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWR6akloY2JBUDhNbit3L3RoTFZBZHpuTUoyenVuOFBIUE1EV1Zjcm9aQm9n?=
 =?utf-8?B?enZ3TGRzWXV4bk9NTjN5RkNoc1JNMGhSSmt4TFg2N1l0ZlhyTSs5ajU4aUFy?=
 =?utf-8?B?aG53Z1FQMDIrcm1Idy9GSE1TK2xoSU5jSndKRFc2SUx1K0NUczhPNW8rN2pF?=
 =?utf-8?B?d0tlT2hWV2NCVS9HRnN0ckNQZ0hTSHdEZkVaN1NzSUVTTTdVUFJPZGJDSUlX?=
 =?utf-8?B?T1lZY2ZueUl0SFNTRUM2OUVvclJxMlJBMnlHMWJiRWFXZ1RvcnhhbjBYem1L?=
 =?utf-8?B?elBVaHluWksrQnNlbGJQUkRmS2IyRzlXaE43VEkwMno5b1dJeTZYNWNiQUhG?=
 =?utf-8?B?Snl0SXJlVUhvMWNkM1JiQSs5dml6dFBaYUwvSzgzVnZGYUh2d1pha1U5cXNV?=
 =?utf-8?B?QkFETUVXdTNKejR6MDA1VmsrRjRyMVc2REJQSnRnWk0vejVaenhkVmlTK2Mv?=
 =?utf-8?B?VU9vUmpySUxRRGxzOUl6dUZrUWhzZzR2cWovaE4zakJ3cHhSV3lWK1M4cHBh?=
 =?utf-8?B?b3BuSU13L1NmNE5ndmJJVFVTT3FHdmNFTjFMSFYyTS9UaW96ODNjMGVlMFVT?=
 =?utf-8?B?RFpoblFRWU1xckdKVzNNbmQrQUxRUkZaTmNzVFY3dndyVlM1YTBvdUY0anZx?=
 =?utf-8?B?VTUxbkJvcC8ybUNLeTdRekhLWkIzRTRwUG5zTUErM2hOaEtUSmE1Uy9LVHFS?=
 =?utf-8?B?Z1NHSkE3WkpDbklZR2JqZkY1WG1scFUvTHF6RHRBanlhZUFGT05sRmRETmoz?=
 =?utf-8?B?RFg1UEwyZEVtczlUakprTnpuUDhMeVhtbXlmVFR6R1NRdjBZQThsY1hnazNo?=
 =?utf-8?B?eUhTSTdiQkg3VFJ2dUdRaTZLRDBDMmRNb0RkMVJFNEN4L1hVUGZES21RWTlv?=
 =?utf-8?B?N0d5S3c1N0F6d0hnR3BRc09TSnIyZlhXSElSemoySzJMZHV4RkVYUzNwNWJl?=
 =?utf-8?B?dW5zanlLWkRrbUFHQVJzcUdJbXBZU3A0dWUvakRLbGkrSGU0dW8wRlBGVWgy?=
 =?utf-8?B?K0tHcG8rWndMZk9aL0N4QkZUN29KWHdHQkg1ZzBrZ1JYMjhSbFk1RTREanZJ?=
 =?utf-8?B?cHpSYkJZQUxsWTUwVnUreU1nNkJKTnI5bm52d0RUNjJ5RW5uZkFLWXBsMHo4?=
 =?utf-8?B?OHRlTmZXMXhNVU5OZEJBc3UrYVBFdHBFdlFUeUx0VEtRczBkOUVHTkU0RUxl?=
 =?utf-8?B?c1BGTzdhelg4blJVNEh3RHNKQTJYZFZVZ0duSFFtV0Z3czFoNHFCVDJPeWhG?=
 =?utf-8?B?Y2UwcFNWWVFTRWhZdG14blEzRzhVVy9HSW1sQ3dqSDRIQldOd3Y4cUprdGZm?=
 =?utf-8?B?SVdMUnVRT1hlbG5vdEVLK0lseXNYenZwZVV6TnZ0ZTAvUWYxYnorMklzTHJ2?=
 =?utf-8?B?aEZuQmxXQWRmWnEyT2Q0WThOOEpCTG1XcmVKSjJGMEs5cmFTUTJ1dC9xY0dL?=
 =?utf-8?B?ektmUzUxa0o1czFJUnA5a1MrME5lR24vc2Nqczg1eEJENUhERUU3cmpRSzA2?=
 =?utf-8?B?OVJaQkNkZG9STXNUV2FuNmF6MkV1cXBTcG9YLzRrUTlsOThhNE44VFF4VWV4?=
 =?utf-8?B?aGQwT0RMWFBmenRkbS9LQ1RSU3dCUytLdzNkbWhDVkdCelpKcXQ3bTJrai80?=
 =?utf-8?B?TjJNdDJZUlVMc3BpajFYUlZVVjVOcFJZNmxwY2FrNXA2MnZMWTZMZlMyckNh?=
 =?utf-8?B?WmoxTm1CL09nVEhiYm8vVUdacG4xQ0c3eUpnUUV1SDh0Zi9kRzRBS0lLTHVN?=
 =?utf-8?B?blJXdXd2RHBERTZFMjNoSUs3NUxNdmZ5RjFNWWRtdkdabWQyR3dYMUtvMzB4?=
 =?utf-8?B?OWhEaVU1VURiR1hwWHhWeWtZS2lnRHpOWTNzNW5CYUt0d0VhSlNnUkF0Mk5u?=
 =?utf-8?B?ZDJwdnFFRmV2OWJwU1pZQWV3WTJmOEpVcjdJNWttWURyaDN4aHVzejNJc0Vz?=
 =?utf-8?B?WGhiT2hsa1lQdHJkbFd6VFFjL3VZdjk5NzNpUmx0aDlHOW5JUitBWEVReUU5?=
 =?utf-8?B?YkVESU1HWGQxOEptRlJXUFB0NGMwbVFyaWsvMVA5Wms2T28wSlBIZXhDU25Q?=
 =?utf-8?B?NWlXK3dneko2dkV3bFg1d0Y2Vndta1RFQUd3MTN5L3V2VzZKMXZqeWRMM1FT?=
 =?utf-8?B?YmtWWXYrc2JyY1J2aXJDbWt0Y1BlTnhGQXI0RGg5YnBydjhKeUtDR3BHNDJw?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ashQC9L7oTwT5rUaUPWnogy8SfN3nI5Mbrl56R/NIuNcos3ONXCud66hb2wH46Mev7WA/fjeboVJidBLgo4BMwObofg336n3taAk7XSKWRCAzP9a8GoS5yWmhhZgbcsX7NyjBQa7j6BFOeg4jiVIRzncAPw0adRlqWcWQx6r+vdwPry8cZenMEhwyBKqnWvPK/wh7Vr9RdbYPumP6dfyoMpyiW8+GOW5eulmg+f7v+GQIIR2+r/1MYfAiUYRMe0VPI3FAb7pF8fQ/DKJ8FcdGvkMClB31h80prTKQWagU+t7CN2eberYkpM9kNq/1eD6utRquDj+RMKZBmZEVrYyVJyYjfY4/0nGjlLuF1AP9tTw57NQWMj8p8u5WUvtja7JZhvKsvEgZ3Q2uid22ZeLWVUVp6rVW0jusjluU/2EDeEyh2rbdMGCBtJUBob1jGKZFeig/CLdYVML1Uzjng/5nEnaogHhYl883XWZLi3PAlh0z1Xpa1uwp00mENyyJDyqyB7qcMtIgdxJAPKe/sGJ0GMh5EHbavylxXrPYEL6FyUCEW93AhzQIYn4OM5kUVkT89YPz2dl/pL2DYJQ0PplxD9zw/7cnb1ncSDRGCzkYKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c18388-0f36-4d38-f4f6-08dce7120148
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:52:49.8859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v4EaOkocEPp23aeLEdM66V1IVnUaBNLtPoE8mmoNT7V8t9fwFVdmHeQQTQLNvVi8RUjGG7s8LgyWD+daQEAjRGN0Y7chvXdNIDGP4aGRG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_14,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070143
X-Proofpoint-ORIG-GUID: 5ojLJQ5PPHjzgnEIk8XF0xTgpt4xskWw
X-Proofpoint-GUID: 5ojLJQ5PPHjzgnEIk8XF0xTgpt4xskWw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/7/2024 11:27 AM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:35PM -0700, Steve Sistare wrote:
>> Stop the vm earlier for cpr, to guarantee consistent device state when
>> CPR state is saved.
> 
> Could you add some more info on why this order matters?
> 
> E.g., qmp_migrate should switch migration state machine to SETUP, while
> this path holds BQL, I think it means there's no way devices got hot added
> concurrently of the whole process.
> 
> Would other things change in the cpr states (name, fd, etc.)?  It'll be
> great to mention these details in the commit message.

Because of the new cpr-state save operation needed by this mode,
I created this patch to be future proof.  Performing a save operation while
the machine is running is asking for trouble.  But right now, I am not aware
of any specific issues.

Later in the "tap and vhost" series there is another reason to stop the vm here and
save cpr state, because the devices must be stopped in old qemu before they
are initialized in new qemu.  If you are curious, see the 2 patches I attached
to the email at
   https://lore.kernel.org/qemu-devel/fa95c40d-b5e5-41eb-bba7-7842bca2f73e@oracle.com/
But, that has nothing to do with the contents of cpr state.

- Steve

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   migration/migration.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index df00e5c..868bf0e 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2082,6 +2082,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       MigrationState *s = migrate_get_current();
>>       g_autoptr(MigrationChannel) channel = NULL;
>>       MigrationAddress *addr = NULL;
>> +    bool stopped = false;
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>> @@ -2125,6 +2126,15 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           }
>>       }
>>   
>> +    if (migrate_mode_is_cpr(s)) {
>> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto out;
>> +        }
>> +        stopped = true;
>> +    }
>> +
>>       if (cpr_state_save(&local_err)) {
>>           goto out;
>>       }
>> @@ -2160,6 +2170,9 @@ out:
>>           }
>>           migrate_fd_error(s, local_err);
>>           error_propagate(errp, local_err);
>> +        if (stopped) {
>> +            vm_resume(s->vm_old_state);
>> +        }
>>           return;
>>       }
>>   }
>> @@ -3743,7 +3756,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>       Error *local_err = NULL;
>>       uint64_t rate_limit;
>>       bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>> -    int ret;
>>   
>>       /*
>>        * If there's a previous error, free it and prepare for another one.
>> @@ -3815,14 +3827,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>           return;
>>       }
>>   
>> -    if (migrate_mode_is_cpr(s)) {
>> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> -        if (ret < 0) {
>> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> -            goto fail;
>> -        }
>> -    }
>> -
>>       if (migrate_background_snapshot()) {
>>           qemu_thread_create(&s->thread, "mig/snapshot",
>>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);
>> -- 
>> 1.8.3.1
>>
> 


