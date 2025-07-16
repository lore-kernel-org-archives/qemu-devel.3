Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C188C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6LL-00040T-M2; Wed, 16 Jul 2025 13:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6Il-00015S-8w; Wed, 16 Jul 2025 13:52:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6Ii-0004LH-BH; Wed, 16 Jul 2025 13:52:18 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHhHJ5017556;
 Wed, 16 Jul 2025 17:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Latpa/XeXrUd1BURJKZ4faOgeMy3amUj3zg33fFyHuA=; b=
 qpw9WDIK7LX29+x8c2Kv3kdsvq16P0xf0JRqhENjiLxQGMTG/IFV1YqXHqWCGm/h
 ZyGW0LEJsdeVzz2rQaDhCq5cuWUSrAkV+tMHZTr+jAe8h7f3ijE8CzwhkAx5ruc6
 R0RjEQ/xqYDNBl7jUooYZBWmQJoSrTcuZRcdMCSZz2aJtSFc3bW1kEP2+hj/4Kn8
 ViF9IvkivdA3RCm3mkxbOJB0IKqE2DaA1y6BX0k9MIAZvc0tjuIW6MciLgwA10eY
 KhCAhDRJcGNRAUosue9405n2QynmR1jCrNWI5ifkwzDUuRQ3OVvaYz6tDkGw+hSm
 pgQOVYDfPuyGoadEfuWi9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4sdbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 17:52:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56GHHGrh024100; Wed, 16 Jul 2025 17:52:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5bn6dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 17:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atfsfVwOaPqbXZas/vaFQXdQkfJ7/hwNkdAwf8vHBN/GeMdFlHKL/muVQARnEEebXFXt1TcuQ8PRCq9QUqyoPfIuP/Rmf6AEuA+zQ+LV0awbE5hwaYbVy2waahLRdcFYq6PIMlYohhwUrAXZJAmrlHAOEaO+1zDOO9vx9lm2fCKoIqh6S8v1USZr3yrjFtkwOVJkEodEO3q94UgBjEPzzol1xThq2noMDqllt4RXL75642IDDhK3NHo0ofSU6Vbornam1nTb72rzOhH21xJuBRaoQOzQ6WvhyFNjsehW/OwmV2oH/DVa/U9T+xMrh+aCXJvw8G8Ge4dOBxB9mby04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Latpa/XeXrUd1BURJKZ4faOgeMy3amUj3zg33fFyHuA=;
 b=iF355laZchQwZBa8xHAnrjdBNR/XHBLLxzuLzQTl/WTU5CAAgq62pg+dRJJ+cHNN/UPmzrQ1wn5lY4oHZABaM7uZeIJON8Xv1rbjZpUFAs3irv0xTvAUjD8Mdjfx4dVmdiZ81iQMtCl4olxKujoe9JlkjfZwyCeereVRW47LKwoB2QWSehS10/8U4s2C5eHO6hQp41zX7KhSIzTne7NyFkMCkJjeWwuQHKORplIApOzSFTd5QMRIm6Xj++OG7YqxhK9oR06uDLqMWKqJfnAoqjIWlJduNrmbBGBcRc74splkM65cCU4CNcJKk3ydYS1VSUNAn0sAhYRogyE7kCkGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Latpa/XeXrUd1BURJKZ4faOgeMy3amUj3zg33fFyHuA=;
 b=YjN2LTFS6CCKyC52J/u/ZyRmHW0W+kzQKs7ePaCf5t52njRjIkp35i2QB2u9bU0zcf7iNCtv7jPAgePtSBFIL0EMAT45BrKv4N30FsOJHnxaY2CPc7Bs3+Q+JdWFHMA+ZAX/AQMmvlvKjKxZWG+3NcA3UesZQg+Jd8L6Ug0iy98=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8472.namprd10.prod.outlook.com (2603:10b6:208:56f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 17:52:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 17:52:07 +0000
Message-ID: <ead1b259-0082-4f4e-b335-2205e728205d@oracle.com>
Date: Wed, 16 Jul 2025 13:52:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>
References: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
 <1752503239-222714-3-git-send-email-steven.sistare@oracle.com>
 <CAFEAcA8yg19zB=xWqcywe+bj57bHjfRaZ5+TBy6GhKwoeJBV-Q@mail.gmail.com>
 <b86946a3-14e4-4c0b-a4dd-d42c4f592adb@oracle.com>
Content-Language: en-US
In-Reply-To: <b86946a3-14e4-4c0b-a4dd-d42c4f592adb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd2ceda-5b32-41ca-91c1-08ddc4917b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnBBaXE3a05xeit6dFRaK2EzVnIwd1lkNnlPM2t3MUd1N1kzcm1lUlNsUUNz?=
 =?utf-8?B?WVdqdVp3d0FiVjBSdUVuT2RQT0VRV3AyVHUwZHpWOUFXb09VOWpJWG1Na0hq?=
 =?utf-8?B?YndCcVEvdzdGZXBqY2dERkg2U285cDhJQ3l5QTNPM252Z3c1NGY4SUp0WnQy?=
 =?utf-8?B?b3ZsTDMvYUluODFDRDV3OWkzZ0NyaCtKZGVnMVcyLzUyNDB6TDAyaDhhdjRQ?=
 =?utf-8?B?cHhoTFVUOVdGTzg2RjlRbUw4NE5Ta0pkQ1JSS1huTGljNjFqZzkydkVtOEJp?=
 =?utf-8?B?VHErMWZHd3RKMjBhN0ZKbkR6MnBENld2RFdtazVhcW9MUXlHK3BwdzZQMnBi?=
 =?utf-8?B?T0xrZDY1WWkyeFYvWjQ5KzhZS2QwdHdnQmZ5Y25zeEJUdEo1Tk83U2d2L1Fz?=
 =?utf-8?B?L1hmaFRpUFd5RlFrUGtGNVMxZFNwczFEV1hqVTBQMytpTkxhVVJNM1BNeDRL?=
 =?utf-8?B?K2R0dnNnQ1hJQXZTZktrMkJBRzhETWFvTi84L2xuaHk1MjhBQU5qWHc2MWJ4?=
 =?utf-8?B?dHlpaUpUWnBZdGNITHZ0cS9yN0IxbExhNWlvTjBKd3V3cjhLbi9rbnQySk8r?=
 =?utf-8?B?bGlRTCtOU3owS295aVYwcVVCakNXTG9OOWU0MHpCeSt4Mk5tdEE1NEJFb2Nq?=
 =?utf-8?B?Q0tUcUNNOTdiTDM1bEFaZTc3ZGtlZ2t0ckRDNy9OUW9kRnZJaEFGaTBMcmtS?=
 =?utf-8?B?V0xBekcvakNqTUlIMDdYVTUzcHB3L1lDR2s3YnJqdFJKc0dEbGxsZWkvTGcz?=
 =?utf-8?B?MzFjbUhSUzBFcGhIcjVJbTJmMzdNMVF6dGRmYWZEZk1YZWptKzFDblFXTStw?=
 =?utf-8?B?S1hNS3JIdzBCR0pzR0Z3ak1WL3IrcE9ZUTBQb1lmeG1DZWtZU21tT21XSzNE?=
 =?utf-8?B?YlRqTzR5blhCbXUxM0ZhQy9HRDZiV3htOU9vcDJlYzhUODZXTm5PUU1KSFBt?=
 =?utf-8?B?b3F4dkp4U1hIUjFleFVwZllVTnZKK21HQXRNTlBFTlMybUFPZCtpS1I2T1hI?=
 =?utf-8?B?QUpmd2Y3eEs5bDZQVTZRV2FORUVsYWhxdGltWFRaVUM1Y08vL3dlUHVLZDV2?=
 =?utf-8?B?cmcvMWp5bU4yaHg5VEcxVUsySGRGRWIvVUFYbXdVUXVScDVjQ0RnOGYyMXhL?=
 =?utf-8?B?V210VVdSZ2JqdlREMElwRHQ4ZHNjL2drUHdNODJMdTN6Mmh3TURNVDVNelRS?=
 =?utf-8?B?WHNueFhsQUJTaUplVURiWldnUWVnbDJzVlZxNWZZdXpSdVRnTXhVa1hCdWwx?=
 =?utf-8?B?azlFMDRvUUI2MzhUcmxrLytiS2ZiRWlHK1JWTzROUDVVdDlJVkUreklZTkN5?=
 =?utf-8?B?UnFWMkZON0xTQUlPUis1N2RHM216OHJaRnRjcU1lR3lNMTRob0JyWDU0M3ZI?=
 =?utf-8?B?U2JqS3JKTXRFRWs4dFRSNVVDY0VwOEI1emlVYTJlNzFVTTFxYUU3SzBBWWxh?=
 =?utf-8?B?aEIwM1YvR0JWNUFXRFhLaGg2akVJR21Pa2tZaE15cFdwQm1XNXRVb3NVOGNt?=
 =?utf-8?B?U2hGdHQ2NlltNTBCakN5ZTFVUjVSbUJQYlEyZ0g0cUUrRGdXaW1GaXRvL1ZO?=
 =?utf-8?B?cU96OVFyZjBRTEVVWjdzWGgvTVZ4Tm5LM1hIajUwNFVwQ055dGRZKzRtWThi?=
 =?utf-8?B?aWVIQVJLeHFMREJ6dUkrUmJsR213a3JUSDFYWUNsM2Nwa1lTMjFSa25rUm1N?=
 =?utf-8?B?ZlBlVHpoVnZpZHNHS3lJYWhwMG50STZqOGExZk11cHI4R0E3NGYybjBmMXlw?=
 =?utf-8?B?NTB1a1VvNXRjMWt4eGdsaTlEQllJVTF1UWM2Um44TFZDWGhXenNVeFVnWWtY?=
 =?utf-8?B?dTh4aGZkUnozOXhqbTdMQVNoUHdJZHNBejBYdXFyN2RPdFlXbmZIUS9LZjd3?=
 =?utf-8?B?RjIvSW1vMGxFZUd0TTZBRTBGZXAwdnFzaVIwdkdEU1VSWEVmWktSTzdTMnJM?=
 =?utf-8?Q?YUKjOL9qvaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pNcUNIcTl6WHBzaEYrdzdnWm9KcC9LN3N4d2dLdTBVd29FQWVMNFQxZEtk?=
 =?utf-8?B?M05qZWVueGtVTG5GVE5OMm11UmMvZFNPekxHTnZoeGFjN0pObWI0cGJSeElL?=
 =?utf-8?B?dlNOQ29CWm0rKzlqMGVYV21ibWVWbEcya3g3eFFIUUtuRG9pd0w2bW9jbXM4?=
 =?utf-8?B?NUVBaHdtY2V3Q0IwZktlVVpBRzRjZmNFUzZhUEdiVEo3QmM2V29uZ1ZqVkpy?=
 =?utf-8?B?WFpReXkwMno5WFZRZFB1QmcwWFNZaEpzazlPRXVGY1JMNC9sM21Kb3VTRG50?=
 =?utf-8?B?bW1BVm5LNEdpU2ZnMmxPSUU4SzdGZXN5T08wczFmbXZkanB1eXBsTXAyaXpL?=
 =?utf-8?B?bXJ5azRtV3VhZndFamhyNjF6MnI1K25lR28vQ3lNSFJ5d2toL2U2N2cxZHIw?=
 =?utf-8?B?NHl6dE45VjI4dXB4OHIxZUZkNzFNS1R0NlluV1ZkajVKb3JuZlY3U1VFWVFa?=
 =?utf-8?B?ZWRhaGw5ekNzZXQzZzIzSXZJZVVyc3JQbzkyTS8rWGh2U3dGcGZ0MXBCRDlZ?=
 =?utf-8?B?UDlXYTB5dHJNODdYN3BTR0Rqd0VsUXMzRlNYLzNKMWxiTS92QkVTVzFxdkFv?=
 =?utf-8?B?Vko3VFFaWkhaRjZaWkV1aHVsWVRkTnkvTGxGV0pvdU1kcXpBdndCSnhKZExp?=
 =?utf-8?B?anl2NlAwMzcyUThuaGx4emhuWVNTNWoxSkNzUUpJZnFhVkF1VUtVaFl0VVRU?=
 =?utf-8?B?clVCSGJuZTROTkxEU2U5djJXZVJMajdSVEdxZzFkZUhKd0RKRzNWWDU0aTZy?=
 =?utf-8?B?a3h2LzVCRHlVUlBrbWJMSTNKNm9DR0VSc0gwOWg1ZEpnbElZNFBaM0NJR2xF?=
 =?utf-8?B?Q2NsaENlbUdyd045MTFDQm4wa3hzM0JQcjlZeko5SjhKUkVhUWNTUllqelF1?=
 =?utf-8?B?WEIzSlVjYU92UmlyanorTklndEFTNnppdkJ1L1hWNWoxMXZkUzBiN0xPak1W?=
 =?utf-8?B?YW1rN0ZwUERWZk1lZEZYOGxQWE8vbjdMK2VSL0ZNeXJ6Nkt6NGhFYmsybzQz?=
 =?utf-8?B?bnd4c3BsU0huK0IrRk13QjdicHFBVjZRRW9WWFExSW9MbFgxdEVNTGxyMXdQ?=
 =?utf-8?B?K2ltc0JoSjR1S2JKeXVKQ2V5N0FaMmRqclBOcW42SWhISmVPY2RoN0lOSzNB?=
 =?utf-8?B?U3MxdlFNNWhrcmZxckZoVEZoOFlqaGFSVTZBODYyc2NSMFFBTC9DMXRjSGNC?=
 =?utf-8?B?ZEY4eWJNeUpPR1Y4OWNBNzg5NWpmeXRjTll4NmdkY2UvbGxzVVNMcVpiSXhR?=
 =?utf-8?B?WW9XdVpONXZob1AvQ2xJQSs5eGdKS0xUNXhVYk45dDRFS3lSWlJFZmRFWFFz?=
 =?utf-8?B?T2VxRjZJc2IvR09iRXBlR0lNM0s0eHJiaEFraENGSWZaNy9LZElzQVljb0k4?=
 =?utf-8?B?alZxZHFkelRvVGtWTXYrOUhXeWZ0eC9XcVJkZ1NBMWFwaUhiMXM2T0FsamJE?=
 =?utf-8?B?MmJpNTdCYXVIeVlUTWdCQ2pQYVFOdElXNE1rTnkwelpBbDNvVDBhdkdNczZM?=
 =?utf-8?B?VlZGTEZKVmRuTWJpdHRkVWtXdklpWUFOTGhBV3ZPcXNEVjFKUElEK1A5RHRC?=
 =?utf-8?B?NldkenAva2crbU4xRGhJUGlnSlVrMm9UQm0ydCtyNlBrNndWM0NCQmFFTTIr?=
 =?utf-8?B?S3hIL2V1a21SM3dDMU1uUlJKZWZTdFN1cmNnN0VwNXZiY0xBcTA1ek9PVEY4?=
 =?utf-8?B?T0V1bTM2U2tldGx2OHh3TTZkNFFOaUpVamdiWnZIWW1rV2xHYW9GdjFlT3Z3?=
 =?utf-8?B?SnpUTkJZcGVwMk9VWG5NREFNNGxNQjZLNXVBZ2xGalBUUitaa2FBcGhGQy8z?=
 =?utf-8?B?b3IyVnhDRGdVejEyencvNzBualpDcHdJZnp1eGlFOUlrTHRqcHJsM2FGWFAz?=
 =?utf-8?B?SXJtT1lkKzJ1aTlVOHlQTldBcVI2SHgxQmR1YjJHUG0zZEk2S2xsMGhnZVRa?=
 =?utf-8?B?VVQwbnA2dWJJekhzMnU4dGI0YW1vcXQySkJxTk01M2d3VDZJZlVmQlRrTmdq?=
 =?utf-8?B?N3hjTThONGJHQjNlMkpGSmkxbEN1OWdZUVVDQjRiZWszdkdvR1p0dkk2YTVr?=
 =?utf-8?B?SmlLZWtGeENBQlVSMXc4WUsvelRKK1ArSmU5bHphSm9WaDNsZ2FKZ0pBNlc4?=
 =?utf-8?B?MGdwVzIyaGIxL25Pd3ZUU0tYa1k0V1Q1Z0VOQnMxcGRjU25oN2sybU9yazRI?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QfgZhfVyFTh13zpCGDBb1HzGy+xkv/2h0riOMliqWIv+M95wFvIjQMT1uKI+BXiPPx2SgDRXGc2MRDJCWR3dd1riGpg/MT4Ca5WQ089eAz8Zc8SNU9Afw4nbpQ3M2u9G8Vn3Dhji7Y+6pcN4SCJe+h3x7ZL+AaRG5BYzkDoAqugcPK0jOI1ZGS/teH605unXWzGGhQQwHzltWOFNriv6Lmj13hsAGA5ONu8xxiJcPGqFUwaw08w0vt0bQQO4tsB6+4Q7aguDVe4zNQB2NLuopE4EAaerYZKUZ55sYq/hYD6F3mqH3gFnQwqI3aO7+GIHd1D6Ble6EMX/EqOv075HTmTQKZQWvZhw/nNrkit+Ibti201SHUOq8C9dyqH+SShdTkJBrBvzRsNOVUuhAvn4PG005j+mRue5nkd42xqv4pBIzrxDHNrweA8ftnsyR24eId4RyHe4+YPmsM0j2XTdh4tJcWT+tkcSVdNDZadGiWlayozafSV0cASOL6Sa4qEamthIp5UHGxpv7bhqvJzjj7mSxCv066PsKowPE1iQLnWPlUIH3D6Zpu7QpMpg1VVV/NF6MuItnCTyZEw2nvUIbW1ebhXK5Q9mcQnLB1Mcz4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd2ceda-5b32-41ca-91c1-08ddc4917b11
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:52:07.2858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4QovTKUfs++2wp7Ordcs+JbGwT7SoAGovpqdCuQfHyDIS1bKQusU9lCD3MaljRmpjRqG331RpoGz/ezl7XcmtDY05xaz8S7/UiSpZv/z2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160160
X-Proofpoint-ORIG-GUID: XMFb-lV7Q0y1PI3VgZ_WcVuDYeMiM8aD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2MSBTYWx0ZWRfX/Rmr0PVXmDiR
 YEjGHHIs06b5c9rduFC1KBE5AXs0XWO+AAIB6A2FHSCbVTbFO2+rJIcLqOVGZ5oWEnj8F9StzDB
 bqUms8ToFKRSmp0jdZqkN8tkWn6E7zb3QXUh8Qd2d61far/2ARK/Q0foeVtys4vGwpPK65C4jn/
 +gQo+5Ak548r8Io5BEAlfO3zgiscXaTwxIl6p+Ps6jj5hRwehNVvNpyGqcNc0Z5xBK+vbgGtECJ
 wnXlME/MEFtZDoYuraoO84KwA6x1KrOyI/lNtLP6GSXIYzSDsPxKRT/wyjY6SVvHyjBIZxR4fJm
 oJmNfibT3xmWzMC+5qGi6AaniPRdmKtlUrEBgYx1zKq3i6akux8BHHUrYAbdL0gPAd04s6JGyJK
 p20WdwesYQllv/vK39w+z2FIgOrDGXT7sk2guNAuXNDgqR9HHjRlt1GgLSNc7OxcsZ0MUcpq
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6877e6cb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YKTaT5gP-L50zSJaVDwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XMFb-lV7Q0y1PI3VgZ_WcVuDYeMiM8aD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/14/2025 10:51 AM, Steven Sistare wrote:
> On 7/14/2025 10:32 AM, Peter Maydell wrote:
>> On Mon, 14 Jul 2025 at 15:29, Steve Sistare <steven.sistare@oracle.com> wrote:
>>>
>>> Close a race condition that causes cpr-transfer to lose VFIO
>>> interrupts on ARM.
>>>
>>> CPR stops VCPUs but does not disable VFIO interrupts, which may continue
>>> to arrive throughout the transition to new QEMU.
>>>
>>> CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
>>> future interrupts to the producer eventfd, where they are preserved.
>>> Old QEMU then destroys the old KVM instance.  However, interrupts may
>>> already be pended in KVM state.  To preserve them, call ioctl
>>> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
>>> they will be picked up when the new KVM+VCPU instance is created.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/intc/arm_gicv3_kvm.c            | 16 +++++++++++++++-
>>>   include/hw/intc/arm_gicv3_common.h |  3 +++
>>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>>> index 43cba6e3f1..15245af2fd 100644
>>> --- a/hw/intc/arm_gicv3_kvm.c
>>> +++ b/hw/intc/arm_gicv3_kvm.c
>>> @@ -30,6 +30,7 @@
>>>   #include "gicv3_internal.h"
>>>   #include "vgic_common.h"
>>>   #include "migration/blocker.h"
>>> +#include "migration/misc.h"
>>>   #include "qom/object.h"
>>>   #include "target/arm/cpregs.h"
>>>
>>> @@ -783,6 +784,15 @@ static void vm_change_state_handler(void *opaque, bool running,
>>>       }
>>>   }
>>>
>>> +static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
>>> +                                  MigrationEvent *e, Error **errp)
>>> +{
>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>> +        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
>>> +        kvm_arm_save_pending_tables(s);
>>
>> This kvm_arm_gicv3_notifier() function reports an error via
>> an Error pointer, and the function we call inside
>> kvm_arm_save_pending_tables() can report errors via an
>> Error pointer. So I think kvm_arm_save_pending_tables()
>> should propagate the Error up, not ignore it.
>>
>> (Or if there's a good reason we should silently ignore
>> the error here, we should have a comment saying why.)
> 
> No good reason, I was just mirroring the behavior of vm_change_state_handler.
> I'll propagate the error.

The kvm_arm_save_pending_tables becomes trivial, so I will just delete it, and
delete patch 1.  I will submit a V2 for patch 2 alone shortly.

- Steve


