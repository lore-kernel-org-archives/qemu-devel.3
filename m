Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C31E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQ3V-0002TV-Rk; Thu, 02 Jan 2025 13:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ3R-0002Mz-AL
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:36:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ3N-0001Nt-Nc
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:36:21 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HXorI023838;
 Thu, 2 Jan 2025 18:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=nNWCzOF1wrp0Qj3MvW9dCWpO09ffiSlyzb3NF22J9MA=; b=
 LwLgc+PFKpN1oQUj1wxi5vjWEpWDCePcXazMz+LxFziU0Hym+yESJwi6Q5Uyxdl2
 pJiEkjpbmAuHHVQKRS/h1rj1bhGji75KWy7cPFZbzLe5M4tt2khlqLuLWUeknMux
 cf2V3CRzSdUmPK6rtj0fl5DP+G3E54Jc3F3Y+MQXJZ+ar4SLF8Xq8kFOZKSMxL1x
 O2cEfnYCB5okkeraNFuLG/gJ61pdYbqOc5Wh8gNiUbi5DHTTuOjYmd/PVBerOAxW
 ZpIa31jxAIcvb0l4Aj36zTB/gYJtJkBaPJf8YQUQTxE3e+ROyj21GRZ8pnBGINY9
 iTiwbjtzTLjo30VvRDAKNQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9chefqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:36:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502IYRBa027883; Thu, 2 Jan 2025 18:36:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43vry1xepc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCFzZx/I5Dxm0npQCT0Ygl8Xs80DEfqiXyfRffEytzYD594opTz6slu6xGo4K1Uia2r+8wCPDQdsFaqa9gusXSs+UUb+RJW8o1tPnPgbWVzmzmwtRAebelnr4gK08q7Q77Xq9zdUADtBEORMMQoCxFZFDAxbvNh3g5DXXZLTHcICL5A/fkAqx5XEUmffk1NvKLwlK2ZmwUH1LHnLIBPWKl9GtpKIRBxt10BeewhTv1+ZzYWKG9exqVFgN2vQybA81Kc2NPFnbyXlQhT5TxbsUzTXGmpuBxMWFc4c00q5RZm5bSaTWV/q1crmo6zykU0+vz/sKvq1Iq2drV4MTI1YpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNWCzOF1wrp0Qj3MvW9dCWpO09ffiSlyzb3NF22J9MA=;
 b=j6oM6cP8yoxjOLutSlasEUbqEv9n/9L9rYKwrCxEhjL2mBn0oMP2NoYVGzAogcJpt1/W/akZp0mFGXQ70mJHwTXH8ez9wMp33RMt2svuL/IqWsza6XrpuKScb1frGKsxvoCwR2DWX5Yt/GbPLMaKpLpdY44ng/6UWX/1KnXmYbAGW2bJynWh0DXUpz0rtbUofbdHSkgJ28/Q73zvAK5BouF6hoNexT4qaIoB0Hsv124kTGMyaRqvBaqLnJVPG+VYzDoyl0I9yUxwoIK+/I17ROMrjzdghHNw0pDkMCtJH9HvJcPp7lQFB45/5d1Fvq3LJb7k/KZmXtKDJaH5HBiDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNWCzOF1wrp0Qj3MvW9dCWpO09ffiSlyzb3NF22J9MA=;
 b=a1fHiAtDfGfFjGPRhxnfT6GLZDPUM4Nsrmayj52Cf2ZAGJn6U+QmdLuqKJwktLfO3gLuyFrQsUurFIUM62fQ/3ScZI88Vc7vzYeLAO3cExAiO3nfB/PHFWV3QErNpKG6UpKiLrt1/rHgQjiF6ekNdlnSAc6mbTydCNG7MCxH+lo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 18:36:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 18:36:06 +0000
Message-ID: <afde28fb-fad5-4ba7-8c28-bf9f2a05cd1b@oracle.com>
Date: Thu, 2 Jan 2025 13:36:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/23] physmem: qemu_ram_alloc_from_fd extensions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-3-git-send-email-steven.sistare@oracle.com>
 <Z2rs4nYtuXfFW4sT@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2rs4nYtuXfFW4sT@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe09052-d212-456c-c5d5-08dd2b5c517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akpxcUZLbmZJUzJmanRCb2liOHdONmorUkxDU3YxQ0ZOVmt6SEVmL09OSFlO?=
 =?utf-8?B?elVuTW5kOXd6T0YxQ0tjRGQ1U1dXNW9sNmlzV3dlbGdoZi8wQVl3UkVGMlZm?=
 =?utf-8?B?QmljUTJxR0ZVWmhldE1MMEZWV21SUUJOUmE4U1hpckpuNFZqWUxVa3FJQ011?=
 =?utf-8?B?dzJRUW9NY1A3SlhxVmQzK1JLakpxaWU0WEViaTNTU2lqL0lTUDlhRGgrQjdS?=
 =?utf-8?B?Q1hLOTZHUU9FTXE4cU9hMlhyQXdWUW1rSUJwWE94aE9ER2o0cUJmVldaK0lE?=
 =?utf-8?B?R3h3MExsdnF0akROcFMyM3NleWRJZ1YzeE5TZjJ0Q0FjOVc1d1o2NmNZREVs?=
 =?utf-8?B?WHZHZnMrY1Nia1hwVlNkQlVvdjR2YmdKNnZCZXFKcldrWnVsSXNZY0V3c3JN?=
 =?utf-8?B?cEd1cEw3VDJmZUowUXp6R0pielhLY0tyMmJVWlZvTmhNT3dZeHVFTzNlc0VO?=
 =?utf-8?B?Z1hpUjEvK1Fhbnd5cWdxSU5NTVByZ3RFeFNpMVdKTkdJQkJKU0dTbVRsbDZl?=
 =?utf-8?B?SFlXYVorU29SZDRRV21YMUlFNHhOOFNXS3J2ZXR5N2syTGpvK216Szl0UDF3?=
 =?utf-8?B?OXRRZEhHWU92aTdiZHBYb2lUNlJMN2phcDJjZ2dTS0pQbHJIZE1tWEdGMFpw?=
 =?utf-8?B?d0FCOFFWazdwVWVoNkx1Ylh1QWpRUStydUhudFpTenFwN3VBUy9VTWJnTEE2?=
 =?utf-8?B?T25SbmI0eUMrU0NzQWN4QXpPWHVwVnhqeU50alNvSXdOcTkvRElyQkFXeW5U?=
 =?utf-8?B?N1JHYWVpSjk1STMyOHFJU056MldMczRacUZIcmYzNmZvb1BFaWVQbENNOTJr?=
 =?utf-8?B?NzBuVG91cGpXR2MyRmExQmZqU0hIZSt6VGJ3aGtDTnRINVF3dDQ5aXIrVEZr?=
 =?utf-8?B?SWs3Z3lwMGRNemdnNlY1NEdNa2V4TjBqS0IxQWJBZmlxbHFZL2RYMnhZaFdu?=
 =?utf-8?B?N0ErNk52ZlgwZjl4Q21CMGJZK292K1NybzJXa1ZEOVNmREc3cjVyR0xlQ0gw?=
 =?utf-8?B?d3VrMi9yMjhZNktvMHVnQmZ6Z1ZML01yQmdOaFU5RlFTRFM2VW9uU1N0Y3hu?=
 =?utf-8?B?UEc3M29DLzloeWhpVlZiaGZMOGRFL2szZVRtcGVEbVE4ZEI3N3ZmQmdPOVJ4?=
 =?utf-8?B?dnFxYzY4Y0dmS1FqR3BBUzlhS05qUWcreS9kMjJTN2hQbWFoRTZkSytLUHRP?=
 =?utf-8?B?Tm5vakpIQ3ovaGxYbTRvN2FXOFhyS25yRzY5QnBIWmhNc05QWm1oM3ZvUTlS?=
 =?utf-8?B?Z0diUUU1VStoQUk2bkh4alI4eGFKR0k1OWdMNXRQb0RJcWFkMDkwbi9UTGdv?=
 =?utf-8?B?anRPL0dUaXY2NlBESUY3Snd5SVU4TDM1eE9jWm5KZW5BWWRjZGFTRENkVG1R?=
 =?utf-8?B?Q0krblhqNkJVaEhtWm1ENWNyR0daYWhIclZoZWE1UEtrRVpKdkxMZ3FpWThq?=
 =?utf-8?B?VHpBSzU4NllLekEyajZjZDlFWGNWUjlGOW1OTDFuaUdIOGY3Q1QxV3R1Y2pM?=
 =?utf-8?B?UW15eDQ0c3ZzbUVTMTRVdVpQend4NXU4STRGWEQ3T0RvYTRlYUFua1BWdmJD?=
 =?utf-8?B?dzlhbFpIWGUyTTBla09YOFA2RE9JN2JCd2NDeC9BbjdRKzJEbzA1WCtjb2Yz?=
 =?utf-8?B?cTh3R1JSVkVmcEs5Ym52WjlOMVNMVldUREwxNWJWQWJGREZpT0xiQVd0WTI4?=
 =?utf-8?B?MEJzc0dWMTZWSlQ3amxlV3RQcFhoQ2Z6RzQxZ1dkVDNWbnZyYkJmUDdpU1My?=
 =?utf-8?B?aitOZUhTMjFOdVlmeUN5OEQ5VEpTL3ByTmgybmdtQVk4S3lXWUF0UDJPQi9u?=
 =?utf-8?B?OThmem1SL09JSGh1c0pMNld2VWJiNldINlNBMWx4RVhrRHFhMEhVeG1zSEFr?=
 =?utf-8?Q?ly0XjsT32SPGU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5LaU9IM3pWTGJ6aGxIVGMzQW1GMGNRQ3hXR055SVlESi9CcEdNWW90U0VO?=
 =?utf-8?B?dHM4VFpQMlJCS0pvL25qSmtmZFlOeGpwQUwwcklSYmpCRE5yRmFvTXpQK0ZM?=
 =?utf-8?B?ejI0VmhXQnJIeDFBZ2c4NytDQm1CZmQ2eTNFN3JLNjJXWnlycU41NW5hT2Y0?=
 =?utf-8?B?WFo5ampmTWdMSzc4RnpoSDd6eXAxWWNpY0VFUTdyVlJQV1BaQ0F4M3FNa2Z3?=
 =?utf-8?B?bmlwSm5VUE41a2Y3NE54ZitLL3VkLzlxem82dmh4Z3hxcDBsT29wU3BiMmll?=
 =?utf-8?B?bkVZbVo5YjBXWWI5Tlltd3NaR0NjUHA5c2pRL3JVMkdJb29CN2xhWTgxQWVF?=
 =?utf-8?B?WUp3N0dCT0J0aVJ1aXNtck4vWXlSRWZKT0p4amxSMWVLcklDak1pWlZXWXZw?=
 =?utf-8?B?U1paeXhjajMvTEpOTDNwenUvd2VoemZreHZYN1FaOEZ1RlpRWkpQcC9hOTA1?=
 =?utf-8?B?Zm1HMExtcDBWZktZYjR5ZWUrZUdPME04eElQSTVTWmlOSmxmTkJBd1JObm9w?=
 =?utf-8?B?QXJNYzBvZTJXSTc0OXFWWjBJbjh0TEdnTWhEZ2NNVC8zWHA0VlhwVllZbmgz?=
 =?utf-8?B?SEtSdFQyV0JoR21Zang2L0tvazBocnEvZ21oRSswY0JkVkJMUUNaKzRSNmY3?=
 =?utf-8?B?OWxNRGNNWG5XQWdkeVRVVnpadmpmMy9KeGI3cFlUa0x5MUJBL2NUM2d1TzhG?=
 =?utf-8?B?U3NuQzhtUjBUd1VyTitOaDhKMmNvVVNPaHdxTENaMTIrT1UvbmZTN1Y0Y0px?=
 =?utf-8?B?WGVOT29qOVlQTlYvRjRWQU1BU282YjlWRnpQQllhMEd3YWxDaVVsa29jQis4?=
 =?utf-8?B?bE13R1ROV01VTzkzNlEzaDVVNTZ4dzMxT1RjZVd6VWpIdGFkNHJxZlBaZGFr?=
 =?utf-8?B?ZmNkdXRrclFhdFc3bWN2cXI2eFhGd0o3cXloTHhKK0pXTDJwdmNsbDVjUU84?=
 =?utf-8?B?RFB3ZG8rS1FiY0p4dzg1RlF6aC9Va2tJTWowYXpjcTYzaG5MOCt1YUpyTTc5?=
 =?utf-8?B?RytTNzhlWUhDemtpK2I3bXNDV1lXQ080ZGpBK2ZDSXhuL1RsT3NqNytXRXEy?=
 =?utf-8?B?OVRMcEhobzlyK2xhSVJOcmh6RmsrNFpkN2t0RWFoMjFKcDNkODN2UW1ZVkw0?=
 =?utf-8?B?Q2JmanVqTmgvcWZwWEdnK09ZVU9RV2daTjJYY2tTcUJGQTR2YjFmVkxmcXQy?=
 =?utf-8?B?WHVMa3AxaWFXTnQ0eGo4Rmo4dFVHRFByMjBLeXZUSVNicTZ6dGpBZzZWdUNI?=
 =?utf-8?B?YStwOTdsWS9wSWFraVhmMHZvb09WUmw1K1VUM0lNWWlmVWg4MWM0eE9qL2Vt?=
 =?utf-8?B?UjVRZndjanhNUFFWbTNadnhpaks1dG5SNGtHZTlxM0JtN2ppU3RPbmFxSzFB?=
 =?utf-8?B?eXdFTDlGblJyQlRtcHdieFQ1U2xBd3JOTXpSb3A4WlZaWFozSzIzOHhvRVEw?=
 =?utf-8?B?dmt0ZU50SGdXajVxQ3M2UHdLVXc5S1pnV3pZbnltKzVBZWQxMGVqcnZ5ZStP?=
 =?utf-8?B?bjFUNHJEQXcwMXBCYzNJZ3NiQVlhVUc2eXdJbGM0bHJkNTNubFNseU5XK1ND?=
 =?utf-8?B?T3RWZ0x6YnpsdmhrNUprZW1VenJVbkxjRysvdmlvcHcyaXh0VmN4ZWxtMW5U?=
 =?utf-8?B?ZlZISjhOYXFsNUVBS0Q5Ryt5SnNISWhKWkNSbVRCLy9JZHB0akllcFpzK1ZT?=
 =?utf-8?B?VjBSSnZMYVhoTVNVdi9RMDlmTmpEVDhNL2NHMUEzb3grM1RNNGxEV3IzdSsr?=
 =?utf-8?B?OHJySmk1T0p2SVpWNGxVajYzL3NFaXFYLzJvUFdveUl2UFd3TkJrTC9Na2N1?=
 =?utf-8?B?NEVFMjdSVktNQSs4TUtFMENGNEJjaWxRR0lnRFBDSDJpVW1hdUhlYzBJMmo4?=
 =?utf-8?B?aHkrY1drYjZ0Tk5CZ2VUTUN1eGI5ck1TdXAvTmF4SUltbHRvN1ZKeDVXTjIv?=
 =?utf-8?B?WWFTcjMvVTZyd0JSanFKU1hCMFpDRDR5QTFtZm9ZUVpmZWhXUjFHNzVtREFB?=
 =?utf-8?B?YlJId0xOV2ViQlRZMEl2emhNdGcyNUlLRFlMcEpxS0NHSlBYTTFnM2I0U0Nx?=
 =?utf-8?B?MGZiZGtMVG16VFdJamtJUVJMWnVLQW1RdUNzRnQ3K29SRTlCLzAzNXBVNW43?=
 =?utf-8?B?MzBxTUM5TnI4Z1VjdjZQUjA5ZHRoWUpXK0tWcVZmMFYybndXWUlGNkx3djN6?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aMOTQxrdYTzOom50vuxELmA0G59UsYP4pjVaCZHRbhFnThU1rrY2kHJzCT+4503VFsS9OEagKP7PGsux8zKUaGAgSILy1516hQOF7eve/t2sdqJ2HdvA1bj87n1aWpcZN9/3dUp3iwt0mA4l4IYoHY3Q9uhduAWQpDR71TDWuLggAyZ68NCgKRDP2IpC37N85Ng5enR/iZdoORlDITaez8CeIOBo8v7tBoy6Rs+5GOeKYrXYPzN1EKsqevQaIsyxQtmcMxghPaiWhkoUQf0p2jAL1L8QQaGSdXaLFFxzZb19JJO//nZ3qnCLrWtzhNHIVprWLamGErmpUBA64Rw+Ncv06DzNOgWs5sBvR3Rba4X/Qp913ny8KhklqApVdv9dElduHIs4HaisUvPAziJqP9O8Hpse0uTjb/IQ8uT+AM2n3+sJUzs3YXwe4IK0LdWN9JxwyRpLArTAqyXp4gTEyZHV3UkNXMqmss/FREH1oA27kAhV5gKoF8jYa5+CPja+MIg9gmvYl5jkQBhq9A1zOdbfOvH81DB67dXSlzTjWLkySc1rieMkJw+pefobvrlEX0NIImDAc4aV3N4Oak1XdFWCOaKzahSu8K3ZNLGgi98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe09052-d212-456c-c5d5-08dd2b5c517a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:36:06.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1d/mGzKqlOJke5ojt0H/ZHD3wJ1qClZRdTPkZGBtCmzrz7bLavKeUxCE3KKntVCbaliEFsuMqRpsk+kP+TSPWEXJLd2bm9m3ohPRBs/tgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020163
X-Proofpoint-GUID: _uz2Um-j0iChMRGLsO0hEg10m2W8pzoB
X-Proofpoint-ORIG-GUID: _uz2Um-j0iChMRGLsO0hEg10m2W8pzoB
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

On 12/24/2024 12:18 PM, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 08:16:47AM -0800, Steve Sistare wrote:
>> Extend qemu_ram_alloc_from_fd to support resizable ram, and define
>> qemu_ram_resize_cb to clean up the API.
>>
>> Add a grow parameter to extend the file if necessary.  However, if
>> grow is false, a zero-sized file is always extended.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/exec/ram_addr.h | 13 +++++++++----
>>   system/memory.c         |  4 ++--
>>   system/physmem.c        | 35 ++++++++++++++++++++---------------
>>   3 files changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index ff157c1..94bb3cc 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -111,23 +111,30 @@ long qemu_maxrampagesize(void);
>>    *
>>    * Parameters:
>>    *  @size: the size in bytes of the ram block
>> + *  @max_size: the maximum size of the block after resizing
>>    *  @mr: the memory region where the ram block is
>> + *  @resized: callback after calls to qemu_ram_resize
>>    *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
>>    *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
>>    *              RAM_READONLY_FD, RAM_GUEST_MEMFD
>>    *  @mem_path or @fd: specify the backing file or device
>>    *  @offset: Offset into target file
>> + *  @grow: extend file if necessary (but an empty file is always extended).
>>    *  @errp: pointer to Error*, to store an error if it happens
>>    *
>>    * Return:
>>    *  On success, return a pointer to the ram block.
>>    *  On failure, return NULL.
>>    */
>> +typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
>> +
>>   RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>                                      uint32_t ram_flags, const char *mem_path,
>>                                      off_t offset, Error **errp);
>> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
>> +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
>>                                    uint32_t ram_flags, int fd, off_t offset,
>> +                                 bool grow,
>>                                    Error **errp);
>>   
>>   RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>> @@ -135,9 +142,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>>   RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
>>                            Error **errp);
>>   RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
>> -                                    void (*resized)(const char*,
>> -                                                    uint64_t length,
>> -                                                    void *host),
>> +                                    qemu_ram_resize_cb resized,
>>                                       MemoryRegion *mr, Error **errp);
>>   void qemu_ram_free(RAMBlock *block);
>>   
>> diff --git a/system/memory.c b/system/memory.c
>> index 78e17e0..290c522 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -1680,8 +1680,8 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
>>       mr->readonly = !!(ram_flags & RAM_READONLY);
>>       mr->terminates = true;
>>       mr->destructor = memory_region_destructor_ram;
>> -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
>> -                                           &err);
>> +    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
>> +                                           offset, false, &err);
>>       if (err) {
>>           mr->size = int128_zero();
>>           object_unparent(OBJECT(mr));
>> diff --git a/system/physmem.c b/system/physmem.c
>> index c76503a..48c544f 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1942,8 +1942,10 @@ out_free:
>>   }
>>   
>>   #ifdef CONFIG_POSIX
>> -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
>> +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
>>                                    uint32_t ram_flags, int fd, off_t offset,
>> +                                 bool grow,
>>                                    Error **errp)
>>   {
>>       RAMBlock *new_block;
>> @@ -1953,7 +1955,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>       /* Just support these ram flags by now. */
>>       assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
>>                             RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
>> -                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
>> +                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
>> +                          RAM_RESIZEABLE)) == 0);
>> +    assert(max_size >= size);
>>   
>>       if (xen_enabled()) {
>>           error_setg(errp, "-mem-path not supported with Xen");
>> @@ -1968,12 +1972,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>   
>>       size = TARGET_PAGE_ALIGN(size);
>>       size = REAL_HOST_PAGE_ALIGN(size);
>> +    max_size = TARGET_PAGE_ALIGN(max_size);
>> +    max_size = REAL_HOST_PAGE_ALIGN(max_size);
>>   
>>       file_size = get_file_size(fd);
>> -    if (file_size > offset && file_size < (offset + size)) {
>> +    if (file_size && file_size < offset + max_size && !grow) {
> 
> Is this a bugfix for the case offset < fsize?  If so, better make it a
> small patch and copy stable..
> 
> $ touch ramfile
> $ truncate -s 64M ramfile
> $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
> qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
> 
> So yes, it's a bug..

Yes, it's a bug I noticed by inspection.
I will split and submit to stable.

>>           error_setg(errp, "backing store size 0x%" PRIx64
>>                      " does not match 'size' option 0x" RAM_ADDR_FMT,
>> -                   file_size, size);
>> +                   file_size, max_size);
>>           return NULL;
>>       }
>>   
>> @@ -1988,11 +1994,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>       new_block = g_malloc0(sizeof(*new_block));
>>       new_block->mr = mr;
>>       new_block->used_length = size;
>> -    new_block->max_length = size;
>> +    new_block->max_length = max_size;
>> +    new_block->resized = resized;
>>       new_block->flags = ram_flags;
>>       new_block->guest_memfd = -1;
>> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
>> -                                     errp);
>> +    new_block->host = file_ram_alloc(new_block, max_size, fd,
>> +                                     file_size < offset + max_size,
> 
> Same here, looks like relevant to above.

This line would not be part of the fix for stable.  The pre-cpr code should only
truncate (allocate) if !file_size.  If file_size > 0, the fixed conditional above
verifies that file_size is large enough.

The fix will be a 1-liner:
  -    if (file_size > offset && file_size < (offset + size)) {
  +    if (file_size && file_size < offset + size) {

- Steve

> In general, we want to either fail properly detecting wrong-sized files, or
> making sure qemu can boot correctly with the fd.  I confess pretty corner
> cases.. but still.
> 
> So the whole patch looks correct, but maybe need a split.
> 
>> +                                     offset, errp);
>>       if (!new_block->host) {
>>           g_free(new_block);
>>           return NULL;
>> @@ -2044,7 +2052,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>           return NULL;
>>       }
>>   
>> -    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
>> +    block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
>> +                                   false, errp);
>>       if (!block) {
>>           if (created) {
>>               unlink(mem_path);
>> @@ -2059,9 +2068,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>>   
>>   static
>>   RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>> -                                  void (*resized)(const char*,
>> -                                                  uint64_t length,
>> -                                                  void *host),
>> +                                  qemu_ram_resize_cb resized,
>>                                     void *host, uint32_t ram_flags,
>>                                     MemoryRegion *mr, Error **errp)
>>   {
>> @@ -2113,10 +2120,8 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
>>   }
>>   
>>   RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
>> -                                     void (*resized)(const char*,
>> -                                                     uint64_t length,
>> -                                                     void *host),
>> -                                     MemoryRegion *mr, Error **errp)
>> +                                    qemu_ram_resize_cb resized,
>> +                                    MemoryRegion *mr, Error **errp)
>>   {
>>       return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
>>                                      RAM_RESIZEABLE, mr, errp);
>> -- 
>> 1.8.3.1
>>
> 


