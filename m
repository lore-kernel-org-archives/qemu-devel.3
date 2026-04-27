Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C8FFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS6W-0004Al-NC; Mon, 27 Apr 2026 15:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHS6T-0003wx-Q4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:58:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHS6R-00038J-Us
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:58:49 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REMvXO1326882; Mon, 27 Apr 2026 19:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=K2Iq0dtSb6jIVKNFIiVXu/OXzTgoXR+YP7NA84yWD0I=; b=
 juoNDiaJcYEpE8OcgC3IYF/MvMaWPnTndVDUVYEy1ib2B8vrj24EHcigM16f+fw1
 cJvXRB26W2gyWAcRxxJu+NYoYJjCzSHSyJdNsCede70eVdRsQu6H6ADTvgmwF64Q
 jqNe0UTbte29spP3tJm+PidYbAoPmDx2X+fB9ZOo9J/m0AMH+19hUR7F/tlRV3rY
 3/J4uf9H5JQkS4V2/8B3u1X7JSS8Mknc1HzCfcGiwzo8C5R1UmR+WXxjCU7OSynr
 qvIMjJRfYujjiCcP4sthqXZWZfmDR4pfFqyaMT8EURxSQ3s7VCi2BdDpOAdqhWXq
 wDt3VtH2bzKrwZT7/EErYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drmha45uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 19:58:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 63RJuKgw006490; Mon, 27 Apr 2026 19:58:45 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4drm2hqcsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 19:58:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjKDssh6sj011YcwqZ59DcsreuGtQ6xN6Tmbqe6/2vg5Dyng2zmPqTi7x80XeIaaR8a4MqE9GrJSmNDD6Z2zgvjD4AyyFGbcP2NOVIaxoce8EVOKrEXc0oWPvcn1deD79UKqwWDAUsFwAwVz1bXIrAUZvT/rKQvmF66WrDyMyGTo6eBc4Ul20rM+lGunQwwwzVghbiT9T+GBN1TyQ6a19HWF14vc4edAXQdzkkuO3aocQquFksTJTA5RqTLIZV0bvGJKRrBwcU+G3lefYD59RsPq7MMDmCpuDKq9DgUBqUsoIZJR1oEGCmjd9zOIn4y6w43DzXtR7rPGhpKMo/9r0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2Iq0dtSb6jIVKNFIiVXu/OXzTgoXR+YP7NA84yWD0I=;
 b=hXeqo2ccWBbGYboiLY7Ly/e+V36D4sRTFiOKsGn36sHSnWhFghr9WKD+7RVlTc1sGUybHl5y+kGCssD67hwmZsgZBN4qHkw3zVy9U3Vngn3nJVL9j6VrsYSsYmlhVHM7r308NN58Vg9WKQE8SY3oz2jT77NKue8/xOyhdFipT3xU/i0GNnpQpzNKTR+MaPF1YpohNKkyrGilnzX8Acsb5k7ccn4cGaGCEL/2sjlaJI/TUyVYEUvvLke02RwTFKkp4EZjCEByLKC41+2P8WcmzNnjb/3YwQFcmpEgcSrS1+p0PrdafYXYGDEZoefqmk1+fc4sn6qP13v4stV6Mirkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2Iq0dtSb6jIVKNFIiVXu/OXzTgoXR+YP7NA84yWD0I=;
 b=qOQNsGt8JpNMvC77BAEf7m7sQsH4L9Dfxh9OasMNwXLykR/svQb7zdRLRFjH/UnLctRXt8kB3Nk5e8u+9sLfB/ARi9cgiLFcn6b5s7EjURi9xvwugL97m9BZR4aak2sXbYKf+fhMcsTVYfGnpkLQmftP2GC5+qz47ZNYHsGqDc8=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by PH0PR10MB4599.namprd10.prod.outlook.com (2603:10b6:510:39::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 27 Apr
 2026 19:58:41 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 19:58:41 +0000
Message-ID: <ce69a79e-5013-4a01-a333-cf979be17b3f@oracle.com>
Date: Mon, 27 Apr 2026 15:58:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/41] RFC hw/remote: guard listener unregister in finalize
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-9-c413f3605311@redhat.com>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <20260427-qom-tests-v1-9-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::20) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|PH0PR10MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: a224607b-7b02-4745-9803-08dea4976158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: RxZOYa+1ZPvCywEdkluzBl9rksrPKq9AxAKY5iCqGX6Tg9ITMHMIiW/watzdxHZBEYxJGJzDcPuUiEQcNZ8aUZOYnbmlQGiCn6/X9p+co4h/UzD2oQfIHGFwj88OsKyd/hXWmjwuaXVYT9Au8aCUEv4/qQojejQVYGEGSWzU/3TZ0ytXlHA9n4ZP9jfisXSblgON7fSIdmKeTp14Frm2RMWwywYlRzyn9VAHYr+BRs9Cc5GiQk6eySvD8q7HPDvM+2L8jQiDmiNu0rTpAo8S9u5/kbG+eCUld4rbu0GMWGUAPRdixHFDqd49KzC5Vtser5pHwesMpuwxkyz0yosby+oUXAW+c/sHCkJ/9W37LL712oXjK9uwWor7nCWNHSuX9VI/ETEjtokOMaph83lsdE/Q5kdOM1C+3VJV2+5ppyvDp63uuWRk9ok4HCW5ZYI9r1/VTecw5vb217aZmTGcH5meu0FX/2DhDPa5N4q3h4FvEC52WrCH1/e59nbFQSl1h8mY30GRtdfz4i2hOCI97UXzDvWp6ibZILLgq1mnXDF0HJeY6uAHdqPGYGFBUueoLJpc7u4JkON/5czd+cp0etsX/De2RnbnOeazXfXGSrYPHDyvgmti1Ms4ksXJs4aLClFZlt8QszHzbOxjX68WJTgJJKYi5LEPqhWsMSo54qOiXQyR/od69qV2D6GKeeif
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUVDM2syZkNDZVZwRHFiYmZEOU1Ia253Y1NXTXZLQWkyOENnQ2hoRmN2b3lq?=
 =?utf-8?B?cGErU3kwcHVKMTVPSG02VUJzSUFuTGRtZ1BGM3U1eUJvMHZRSlB6M2h2NFhl?=
 =?utf-8?B?R0o3dm5vcVV6b0dkaCs3and6ZHJxVURCTnpvcC9YTGxwVW41NThGTUM1aEFv?=
 =?utf-8?B?OHdYTnZqbVh3N0ZBZm10Q2JGV1pEczFrRTlHWnJNMjA5bFFURkZrd0NnWmtK?=
 =?utf-8?B?ZGRya1BlcUNmeU10RnNSQjArd090WXNuUjlpcnhBTEw0end4NVdOSEE4dTB2?=
 =?utf-8?B?RFNZZ1IyZXc2WmNLdlhyQldXM240eEkwbkxMZXF5S0Vlc0dHKzJKL3pMMTRa?=
 =?utf-8?B?M2RHQjdqZDJ1QWZDQVdvVXRGUkM0Uks5ZTc1UmdEalhZdVpxRFk1NTJrQnBS?=
 =?utf-8?B?dzdxRGRJSmVXTGJveGlrYjdZcW81U3pnN1Z1VDVKTytEQnF3RXU2UHZNYXNl?=
 =?utf-8?B?eCt4alhZbXErR0tCQWVYWkJkVno0eFZGOVVNaGpNRDBSUzRKMDA1bUl4UjR4?=
 =?utf-8?B?MWg0UEU0dlRQS1podmhUUWJ5YW5zYTEyUEZPMEJZbUQvK1ZuWC9pSmVXSGo2?=
 =?utf-8?B?RnlxbGQ5QVpNYmRvRDJzeVAwak14S2ZrRXVZSGNwbS9wWm9KbVBkSXErTU91?=
 =?utf-8?B?eG5DMUlibnB6MDlZcjFoelYxMXpPWVpnL0IxZTlwcjd3VHBwWXBaL2NvN1FH?=
 =?utf-8?B?bHBvU3BTd3JWY2E0RHpiNlRmV0Fia2VWYm9zZnpSVXlGMjdvU2F2WTdpT3pq?=
 =?utf-8?B?OVRCenI3Z3pYL2RubFN2TmszLzc3ekt0TStTdnd4djNKWEpPUW5xdDJJVGZh?=
 =?utf-8?B?WVNKbU10bTJWRzFZRXQ1WEZQNmFCbGhtWEdQTEFKT1lqVEU4ekM3UDhXeFIw?=
 =?utf-8?B?RE9HNk1mdUt4cmo1a3IyNHdUdC9jUkZ0RkJlYXBaR2RtUGxlVVp6RHhmWXpa?=
 =?utf-8?B?TVZ3TTRVNnFJQkV1WUdsc3NJTVQzaWMwVDBKejVoQVlSb21rNndBYXViNzZn?=
 =?utf-8?B?RFQzczhRYU5ucEs3dk1KYkFGSWQxQnF6dHdrcDNaM1hJU2hSYkJFSU1WNHFJ?=
 =?utf-8?B?U1psbGZTYU1DdlZTOExZTGtIY0liZEJOS2V4Q0NvS0sxaXprZDN3b2RlOUha?=
 =?utf-8?B?VmpUQUhNTmpiWUYvV29TcGV2K1hZajFrS1dveEUvbzlXdGxsRTE5NFc2bGo1?=
 =?utf-8?B?bDltKzR5K0lnd2JQczRIaWs0TkRrYkp6S3FjY0ZTMng1WElDakVueXBkRS90?=
 =?utf-8?B?eVFUdlp2NXQxUTVMajdqbVV3RnVtSmRUUUNLRmE5MmZDR2QwVGRHMVluNHdt?=
 =?utf-8?B?RmMxOVhZMHN0eXBvUlJzQjhvQ3hwTjZWbWxZbmtYMmp2YjhKVHpWN0FNUitZ?=
 =?utf-8?B?cm1UTXZoZDlIVmNNMnFIMVB6WkRYNEk1TFAyRkUweG5TQU9RbUgzaTZLRmJr?=
 =?utf-8?B?S0sweXh5TXNkLzJmRWs3RDlpSlJ4dTNaejZUdWlia2JXVm9mWWN5aXlraUly?=
 =?utf-8?B?MWxwQ1RsNzEyVzVWVnEzRnBPYTQ0NklNbng4S2V6bjEwQUUyMUJHVXhKaGpG?=
 =?utf-8?B?NisxdCtCVGhiYUg0Z3Z1ZkZUVWYzL2s1QnJOcENNcHF6ZHlZN0pxT0I2VzRK?=
 =?utf-8?B?OXJZeUo2VmJlWkh2czhudXJJNjRjdHJEUlNDYlQ3ak1SUThoWkRYQmliVVZB?=
 =?utf-8?B?bHU1YjYvOXdGazVkSnV3cC94TGFMbGZGTy9Md0NaTGJLbHBRTDFBOFowNXVP?=
 =?utf-8?B?YWVnb0JXOWJpVWNUVXZBaTU1UjdxSXJvclhhOUNoRVJMR1hCUnNvTEVUSm9L?=
 =?utf-8?B?Mm4zSU8vZmI1bXpnMHptSG4vTzA4N0pnSHBieXBLK0N1bld0QmtkbjRIQzJC?=
 =?utf-8?B?S0xyUC94d2kxUWZhdU9TZnh6eWJTcXJGdzJabGRNaVVPbFl3aXZZdVJmditM?=
 =?utf-8?B?ZEdtK3pWY3lnR3dVOGVITVM3Tk1WZVU0aUVSTlN1YnJ4M1lURkZ5cGpUMlIr?=
 =?utf-8?B?WDB4ajZDSXRIeHhEZFJWbDlaQU4vZG5jZFNuaUJoUi9RMjJnRU1uYmkrMDFv?=
 =?utf-8?B?N29VRThLMzV2ZzBFL3dVWEhCYTFaVnBoUk94MGt1TERyaG1xanl4MENMRXZm?=
 =?utf-8?B?NkFrR2lDWElzbVZVcThvMGRQdE1XWWF2K0VkNXlTaEI0RkMrd2hHNkdqZG1t?=
 =?utf-8?B?a2poSDQwTXAxV0RHNnNLc1MwWXgwcjlaZE1VNHNxU0NtZWpESFBSTFlnd0M5?=
 =?utf-8?B?S21wRFRnMlEyNW54Yk5mR3JLNWtDdDRTLzgzdUs5UTNUWjJqeDU4RnJuMHF3?=
 =?utf-8?B?US9JR2NZbEZGS0hEOXliWGVLZVh2em4rZW1Ccnd2YVBHZDY4RVZhUT09?=
X-Exchange-RoutingPolicyChecked: NQ84wZKNdd4ywE9W13LUuFCyHWBiPR40Z8uypB3EUhpd73hEUgpsEo/ZcGBcmZMojjI5s59JB1jLnKoe+BC5e41l0NiIyjgsPNKqVhmXiqJPZR9h4FaruVkP/JELpJn5gr/Tzcq7XhHjTd0Ke3nqtQ+nRszCvpQBpG38zguPGrRZYc1I9y7N2yoZB/MqIaWrqCdkIFF4Hs5FKtci0EnvsNmyqnWZt2njZQsqE1BmLbfyOQU3Psaup9OZSbw6ou/M1YzFHbXEcdMkOBU4c/x4kYRSTWgWDCAg4q+GmergTmS0ZXOVNPV0VQjvKRzB70oRe1mJmi6WuysqObHblonKKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yBbVi+SDoIXyGWmutQUqFo3xLlGdFzc8SUgRWNxI368FEhk6xS5jDFMwYDKN4nemJwlFS9Qg11SpbJNqTFOAyUUh37ckIEphEoTtYZ06eiYK5dnHeuWowzlbfoBPUAh23dRHHXjz/n5S5STEYh/QmA3UBL6BcFmAO9l7O1aEeHvS9Kcp4vLQd70vBvFhKeluSk48s1TIHbZ8DYKoQzaTIxyFKb/PScrzW2NklbqlVRMqUPyWOVhMNef5Vff5ypv+wlB6Qks4gmla3Oq3TxYm+Y4tAUBKGzW6GZLWiunAfyktG5k0a3isHmB8D7sBRNNo68xVAFzh+wLamUodI7eOF7ZdkQTh8ZYySWytSc9Gf6Amcaz2D5ptPUsF6rtURYq+UyhK530iv1fZU2ZJAduj2S+aWKFP8JlmhBJ5TJ3ig8VxREh63ucyShg6yHysiaymFQGWqcuRWo4skPVHqFVQtpAXbDC5crjeyN9LWdHLVEXnQbXX1G3cmsfLUzkxzd2GcHWIwhsHXFHWlqKsaF2vlsbWIbJ95tF6QQR3RxuIbUtMQRN/LNpXaZKCnczU5XjIhltREnBMPBhGvIjQJtV5YjqntKM2cBAqfzuXQub/FnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a224607b-7b02-4745-9803-08dea4976158
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 19:58:41.4552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHo1kX2eE85ESxbSeoB2RsSHH3dgZrKVwIvYtBWCpzmgvwDsJnlaQI6sPjh43FdNuuqYkRc0uUTC+ZRnMCEpKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604270212
X-Proofpoint-GUID: sr9GN1PNweKaFzGuRRC3X1RjdMn6IrkV
X-Proofpoint-ORIG-GUID: sr9GN1PNweKaFzGuRRC3X1RjdMn6IrkV
X-Authority-Analysis: v=2.4 cv=CrOPtH4D c=1 sm=1 tr=0 ts=69efbff6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=GaQpPoNlAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=4skM9U2y3GkL2T6Yt7MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22 cc=ntf awl=host:12309
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxMiBTYWx0ZWRfXxmaIHuVTSG9K
 WNh178HP1H+C3ybt71xwid3iZRduufynwUivElj9Z4o68RVplHb+hN6PGpVQIpp6FQdSyGsWJ53
 DSNfLIJDO9kHV92wfIZLtfl/InheNzRFs1FEgOZ1dbMRdfDas17tus+ypKyOkhq+gBtEOcxeRNH
 +PyfHvwarZSQqemYUt98qzrWD5XTDqFVhiYNld1A+uo/T6xUfkr6/gDUWNBKuSCfk6tL8bvaXMg
 nPkEf5Sdjsm1bfugUlkxMLLQ+4xz0QTvAouCG2fEmxGjSuvDVTapYW2eOKUge/wQfyEwgM5n9OW
 zByh41W/PGXUm4KJ1x61M3mPlq1qol25eV3OOmHjnhVwgAPx9I2CuUkVTh7ARAWkd9QMKZi2PMT
 t5EPqNAx6vMJ+E734o0l+E9C6BxttoQjaZ0Jq/dbnSQPgCs/ogZ5gUs1IBhOiWVsUqIvOcQyecu
 2/RpL8olYz2ltz6iDCtEQ7PR1Nlfb+Puq+Sd82C8=
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/27/26 3:42 PM, Marc-André Lureau wrote:
> Guard the unregister by checking whether the listener callback was
> set, which only happens right before registration.
>
> This is probably better addressed by "[PATCH] qdev: test if DeviceListener
> is in use". Just adding this patch for completeness.
>
> Cc: jag.raman@oracle.com
> Fixes: c7d80c7c1d9 ("multi-process: Associate fd of a PCIDevice with its object")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/remote/remote-obj.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
> index 86192dc8dad..4e74ae76158 100644
> --- a/hw/remote/remote-obj.c
> +++ b/hw/remote/remote-obj.c
> @@ -154,7 +154,9 @@ static void remote_object_finalize(Object *obj)
>       RemoteObjectClass *k = REMOTE_OBJECT_GET_CLASS(obj);
>       RemoteObject *o = REMOTE_OBJECT(obj);
>   
> -    device_listener_unregister(&o->listener);
> +    if (o->listener.unrealize) {
> +        device_listener_unregister(&o->listener);
> +    }
>   
>       if (o->ioc) {
>           qio_channel_shutdown(o->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>
Hi Marc-Andre,

I submitted a patch a short while back concerning this: 
https://patchew.org/QEMU/20260427162700.89750-1-jag.raman@oracle.com/

Do you want to stick to your patch, or want me to proceed with mine 
(while addressing feedback from Peter Maydell)? I'm OK with either approach.

Best regards,

Jag


