Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964DCF8870
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuWB-0006vr-Mb; Mon, 07 Oct 2024 16:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxuWA-0006vg-9y
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:39:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxuW7-0004ib-D6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:39:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497K0ZXV031771;
 Mon, 7 Oct 2024 20:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/N47+4YUBp+rgf2/c8VNyIbIx+B41E68sdVQboI/RFg=; b=
 jji1ZAapS/bE2U4Xj0D2tJy+lbOedbfg8gR6L+7VHPtqoYlgafhSwY9lstruA1ik
 OV3Frrd6KzMTZaMR96bEykR2Lgws+KGErF30ZGq+k3Z5P2GkjRZY8y/dKB0Y63hn
 xkCSb5jylHG6OFUvgHkz5sQyZ1OcaUbhBubLJhlSk2dsScCjXhLdDIoQjhCDBmuW
 RAyfIBR0Bca0jJv5lnWi0+W5X9aKeoMcW8CUg/RI50k2d1pmUgxunkhJkp5aa2IL
 tP1BKl/p+2soPXzMUsUGtFlYwXk68TqTE/CGMS1o3lO8RQ3ab+ZQZicjmjXxTMmO
 YgiSPHtsNleRqGWIW3YQkQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ecayq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 20:39:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497Jl7aS001354; Mon, 7 Oct 2024 20:39:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw6apbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 20:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS3T6weIHb9RWbAs02TuFXXm7IIEPF2FrjwtujbfwZeJHdX9i5c700DNxoNur9lShmP0DgrIqwwDuO4EpmNGHm8+suN+hkfp1L8KDxjnxsIBinLsONF9N1nKODDVpW24ddL7ZVdaC2B0mgYHtIlCutys+WXRiMS167F73I30omuiqeaaW7RRehVaJF2PxZ9hY9XLvepguCMNQIasOed4utgS+5GuqyUGJPm3MZknVLP72jcCum5hivICyo3GdutrE9zyVXNkgwBuymXO5MEPqr60+01l2uw28iSc2/dj5BLVViLT4rldvxPibKP1CTHH4j8dJBY8qx11r0/w/582sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N47+4YUBp+rgf2/c8VNyIbIx+B41E68sdVQboI/RFg=;
 b=HgQnjVu6Lq7Kh258y1CorcGWqaLhaHUPL0WCvP8ixMJ1EE8p2/C+g5FpU4JkKLk3MjGoyhgnCDUR/KigtevSxbZPFTZNK9Pko4xm9sehYBeUOC/CPb7pkaFPQackhYV9MkIoYCaBt9Wl5vdL2UJWtFJV/cBG6ve2Tr+SYSwCcwzs9oCce4ESpUeTpO4OpYbAeKFhAEMUAJ6kvLM5iXRJWceiYOcg72sWxQQwMNaUzgdV/uM7q4kMKi3B4hCHJaxoruRx1qXhAA2EfmlQeSICmRKp6AdppFPuIC2f65Lj5y/Aemv2Lk6d4CGjDTxA2xAnm/wSe4sWXYbWzum2WknVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N47+4YUBp+rgf2/c8VNyIbIx+B41E68sdVQboI/RFg=;
 b=FgSoGADsqDOZ3POQHIO+RAJVBP5WiZvDL+HgGhzC9ic5WOrUxJTKneUAkhAfwJZmyj9gjuq8K7Mu9devYmyhL0HZwmOecmF0ddfEqhrC+GEzayANKCaAbjcxv7l/tSH0+t2RxdqJgjZOthLAGgCMtTRJFS9FZ9iOzdy4gtFUD4k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 20:39:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:39:28 +0000
Message-ID: <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
Date: Mon, 7 Oct 2024 16:39:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwQ6GbVCmitlills@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:208:335::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da7871a-537e-416f-1083-08dce71023b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elZYZGMxOXFGTjluTUh6OTJ3RTZJWjZreUI3VjQ0MGZ3cGZNOEkvZjBMYzdQ?=
 =?utf-8?B?clgvL2RkVFJqc0x3Wkw1TC9FQUhrS2ovYkdwaEZDb0ZRL3Uwa29sNU90bUlk?=
 =?utf-8?B?cEdKYnFaQzhaZFRaR0JKTmZUUGhuZ2hUNnhlaGVGR3NGU1l3N2ROZW5sdjlB?=
 =?utf-8?B?bEN2Z1R3OE1TTzFQU0oxYlRRWVR4L0xROFgvZWlCZTB4MlFOcWdiSDZISTJu?=
 =?utf-8?B?WVZIM2NuRGFGZWRqS1RZTkE1Wjk1OVJWd1llM1FLR082WE5DWlBKb2NpWEk5?=
 =?utf-8?B?c1VsY01FdG5DUlhMYVgrWDFjRTJuRUlWam5aS0lBV3M5QTlhNDNVemFVWWgv?=
 =?utf-8?B?QllXdE53WXFuaEZHUXVITXZoZXFpS3FKZXdhcVZqa2dxM2FnV1Vuc3ZPQnhG?=
 =?utf-8?B?VXlvMFF0R2hMMzd2dzhnU0hyL3NBemYwTkJPTW01Um4vODBGaEtYaGx3N1R5?=
 =?utf-8?B?aGoxOXhrMG5nMjErNnFJZXR6N2NCR3ZUQU1qaDI0V0ZsZjY3RWh4eUQxbG9V?=
 =?utf-8?B?czl0V2k1c1JGdzNKNHhxUUMzSW1iUlV0RzB0WVc0eWFua3duV3VtT01acDlj?=
 =?utf-8?B?OFBMNmZnSGUzb0xRekV6OGxWOUkzMXUvZGpJc2VNRy83Q0dHK3g3Uk5EVnkx?=
 =?utf-8?B?akJRb3RSWnVuUFR0b0lOaThpVG1IVUNBRUtoZnZGN1E3UXNNVFdHWGx6VkpF?=
 =?utf-8?B?blVoQzRXQjR1UHNRM2pSTWlIbUF4bE5kbDlsdGR0MUhmOFZSSmVkaHVCNFZr?=
 =?utf-8?B?NlFOM2I0alpPTUQyN0hyTWFxZnpHR0VFVU52WjZraFJXQXIxYmNiRldJT2NC?=
 =?utf-8?B?TnFxM2lTODhJUHpFSkxyZXBubTlsa1JUUFRpSXNodmczcEtUYjFTTVhpSlpO?=
 =?utf-8?B?TUhLMmwyVHg0aEltNy9GZDJUUFJlZDNVVVYrVjh2YnNUSUJqa2I2SzZiUXk2?=
 =?utf-8?B?SExQTmFhSmpESWxyMkpQZFkwbFZCTTNMUEFGWmppL2ptUCt6OWFVaGRHNGh5?=
 =?utf-8?B?aC9XVDFHL3VWSjdHdUwydkszVnJIblBBUHJyWGhtWFYweldNY0lZaXFmOXFT?=
 =?utf-8?B?RlJHSGZtT3k1U1o3bW1IWUU4NVZ5Skc1ZzY3bHpjV1BidEhJS01EaXhWbVlx?=
 =?utf-8?B?NmZZNXczeXRkN3liekVmcThWZDBvUVBoaWlEa2luK1oraENpODFZMWRBa1NW?=
 =?utf-8?B?STlRVnBXeURqWUdEeG1nZ2kzUGgwNUdWaCtwcUR1amVndXRSRXZXN21kdXBm?=
 =?utf-8?B?aE15UFpvZTk4MlQyQUw5cFBzVVdBVCttMUk4RUd6RjBWRzJJZDFQeEI5RHBx?=
 =?utf-8?B?d2tHUGZnNHdsUjFLMFBVRzZMZ2dRTERiMzVUSndMRUVGaXA4VjUzdnpOelNI?=
 =?utf-8?B?NzZ6aU5yeGhwb2NnTVpMdVpybVByUVBnTml6QlhTM1JzUmFKYWl2ekJWWUQw?=
 =?utf-8?B?VnRzdWVwcHUxVjMyazZ2TEgrZ210bTYvMklYcW9OUGYvYjVuMyt1bDY1ZTVG?=
 =?utf-8?B?RU4wazNncC9PN3B6VGRiMGRXaTgzSFNtaHhMWUdUNUJQOE9ESW11QWtYTmd2?=
 =?utf-8?B?QW4rdEdMakZKM1VvRXZkdTZhOTdOa2g1Q1dsNUJDTGlJMHVjbUwrOE9tRWg0?=
 =?utf-8?B?bmtRMllsRldaaS9TVEF1OUU0OGsyaC80MTZRZEs1RENTZ2tWRTI3cnEyK04v?=
 =?utf-8?B?ZmNSZ3FWemRqeVg2WDZwQTh2ZFJiSm9sSllVY2I4ZGp0UkZNRDNaU1JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJsSmpWOW1wS3R5RmZGR3UrUUNkcEFkdTFONWNKZVNOR3Qvb0J3T1prNW1I?=
 =?utf-8?B?R205U1k0a0ZYa210aG1XYWp6cXRBOHNYcitHQWdCdk5TL3J0bWNXYVZYL2dv?=
 =?utf-8?B?bSszcEpoY2k1N2dGM1NkVjJyczdQNXdNeXA3NlFTbG9vMmxvNGtxOE1yR1VM?=
 =?utf-8?B?UENDQTN3aFBhSjdxWVl1dUYyNFg3Skg2N1BYRGxKcDZiSXJuTTlKMExaVEZV?=
 =?utf-8?B?dEk0MlpvYi9oNXBEMy94ZElPb0tYYkY0dkd1ZUZNQTdUck1yb0x0ZGlvZW5X?=
 =?utf-8?B?c1R4WUlJMklHV2dTV1p4NlRWWEpETks1cFpZdXNyRkVZSkR1MDM5MWtvQU1E?=
 =?utf-8?B?ZmU3eXJUNG1RNjdsdU5yUUtVeldvaWhTc2RPNiszaHltTnNyVFZqalBwVFo2?=
 =?utf-8?B?WmUzM1ZES2lSQlMweGg3eEg1MVlvTTRqc0taUnlWYXIvUWhaUFF2WE9FZ0Ew?=
 =?utf-8?B?bkVoRHNySE1Oem92UHRyRlVSS3hkTGdDbUtrdjN6TTl2Qy9sbmJSQmpyVHMr?=
 =?utf-8?B?YWk5ZGREMjZwbjlNKzYyVW92T2xKWWppYzhwbmxZeWl5SG44V1BtUXVIY01z?=
 =?utf-8?B?UktKZC9YRGlJcG9YYzl5VEhMNGxha3JFUXpwREpSb3RINXlVZDIrcnlEOWVt?=
 =?utf-8?B?NnRxOWYyRlUzYXpDdkkyY3FyODlQbTlnRmQ2Qk1qclFxQWFxRmdKcFZLc093?=
 =?utf-8?B?U3JoSDFwR0RISHlFb0x4Vm8xTlRxL0xOQVRlN2hhSlpiNCtvcSt1SGJkempL?=
 =?utf-8?B?QWNkaTlETUVJTFlMT2pDRE44cDNxajdjTjk5VEphcUM5akF2RXAvTy8ybDRa?=
 =?utf-8?B?Ulk5ck1RcmlPYVJEQmhhdXNiRWxwOTNCc0xOT0VYSzNTbG5BNy82VVYrVHNj?=
 =?utf-8?B?OEJTWFNRQ0Rva1BBUTVZU0ozQVpRY2dONHJ2b3UxVEI4dTVEeXhrUUgvcDYw?=
 =?utf-8?B?YXFsZ0RxeUVDRStzMlYxRmZlUGtnbUlaM0xaNWlIMlh5VVB0aXVxWS94YU9u?=
 =?utf-8?B?NHNvRHZ6Q2dHQUVNazREcWFHelFsbzlBQVlwMW9ITXloZGNlUzlTSEh3Z1Vq?=
 =?utf-8?B?RDZ1UDdLclNzVlhBV3VZYTNRcmtFK2JvbmlzT3JXNmJDaWkreVlMTFczODhO?=
 =?utf-8?B?d2JOM3VxaGQ4VUxTdUtZYlVpMmxpSzFHK2RLb01ZcFhjQ1dya1c4R1hXRnN2?=
 =?utf-8?B?RTg2YUV0Vm10L01KVEVBOHE4QkQxdHcrZm9jRCs1WTZobkRqNWdQYk9Fek1l?=
 =?utf-8?B?ck1NazZGOEpyVXdzY2xtanFDQ2MvMHFVbEk3U1AweHZTWEdTQlRuQTdLbDQx?=
 =?utf-8?B?K0xCZnBqc1F1L0FqTkJvK3d6SXFHZ2J1SDArZ3VET3lWci9tc0trOUtZRGc0?=
 =?utf-8?B?SWU2M3hpS3V1S3g2SXZJdE9ONmtnbW5CZ0trNUxpSjZZSGp1bVBYbW1UNkFE?=
 =?utf-8?B?ZnJSUDl5L3Y1YmhtS3g1M0FlU2tkMHV0M3lsWkZZSkNyZEtMN3dzYnhWcmZO?=
 =?utf-8?B?N2htS2JneTVrZXpMRGk4aHhScFdxL0YwZWpPMkZSend4emVtblk0ZHIzK3lQ?=
 =?utf-8?B?cUE1ZGdnbkJXekNHNk9ZY0FvYkoxZ013RDJBN0RsZFh6ZG0rWHRGcjd2VDV0?=
 =?utf-8?B?MHQ0OEpBQnZGc0hrRG9pWlVkRzRqZ3VsbWd3amdtM05ZejFlY2NNRkQ0amRG?=
 =?utf-8?B?ZkQreTEyNytXSzAxMHBrRlZRVmdjNXBwYXYxZGFTcUE2WGVyOTA4akFNb3gr?=
 =?utf-8?B?MWtJQjdDNnJBRXFLS040YWRGR0Z1a0ZkSStYczV4SHAyVjZ5R0xNRGlMT09F?=
 =?utf-8?B?bk9taHB3TERXOXAvZzY4Z3JVUHFPNldZcERXNDViRGJobVFVUElTTHYvb3Qw?=
 =?utf-8?B?OEt0WlRuY2NnSE03Rmk0a2g3dTRrWlpKZ1hxeXRiWEpDZzBUWlZXSDdqc2ZX?=
 =?utf-8?B?SFBuRzgwN1lvMjJlS0F4anFDRU5NckRpOXpsa2V5OXlRQ0hkR0hmTGFwWEVL?=
 =?utf-8?B?TGdMdzlTOUNKdlVBQU1LU1NDUU11Uzl1NXFTNEt5bU9adGtyUGo0enZoSm1S?=
 =?utf-8?B?MlV6ak80a0NWZkpoanZ3cEZiL1B2a2lGN1RvTUszMWhrK3F2bis2dmVrZGcy?=
 =?utf-8?B?YjRETlNYV2lLY3p4Mjh1Vnl3Z0JoVGVkVUw1Mmd5MkdHQ3V1SWk3V0dvdGJN?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LXnSg0bwYblDOa+K7iXXkv866ozZ0HbtGjrOr3j2Uy1rnDNBIWRLoai6aMsWu9/ca6fuTwe8YHdqftlqN6sy4ptt4km74SO9RMfcj4dXHW30QTj+UWvl+oVHiPIi2wn7LM/WWQjjIBhw6tk0TIpdBrXrcYVj30u4rgxMsnIqiz/dW34vmhygWBGFGPuLWoL6N6O+L3j+YluNreEXnpfOMvLDOQ7vwD2igWplr5SlSPK5Za2LBkUEGUk+bBV+7UNnFXIx8O0VXLGxdl4SMOdMYvFjn74uyzAzodOZJHlaioDXG85yVE902ZAYaJXh5A57SZ4EIxxdgEeKP4Cilb8FoM7FEs80VmJzqbgyY9yVnTXha1QFOHocf/FYoLgc+Lvwd8RGanlG11tp+PCkNFoA614LzKTardAZWt6UuWPtHh6gJv6gg0pez3nQggWbReezbbmWdwLxJD7vDsq3+K9Kqk9Ek7F14WaQCEpEEaHWLX1+N25bEqdgSp4TMacu5XuWnfYUpFimJZ3HRtCzFxacLE/9fgpudLHzSwaEoA1FVX6CCbyDBoPsXf4ik7yCWu/RBkIGKuaaWebUADYtf9FRp/DbkEi15vjdxxQWQfTBu3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da7871a-537e-416f-1083-08dce71023b0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:39:28.5617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RMZJ5tl5M6g4iU+djcz+GXoq7VqCjvGQC+FUTdVopEO7iKDDmIRdG4Ds9gomKUoatac8Nr+BfMmoTZA3z6vrz6MNhtXhW/Ec7xBRhfsUK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_14,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070142
X-Proofpoint-GUID: ucJG8V7CB6y49L-643Qxl9CIzUri_EQY
X-Proofpoint-ORIG-GUID: ucJG8V7CB6y49L-643Qxl9CIzUri_EQY
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

On 10/7/2024 3:44 PM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:44PM -0700, Steve Sistare wrote:
>> Add the cpr-transfer migration mode.  Usage:
>>    qemu-system-$arch -machine anon-alloc=memfd ...
>>
>>    start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>
>>    Issue commands to old QEMU:
>>    migrate_set_parameter mode cpr-transfer
>>    migrate_set_parameter cpr-uri <uri-2>
>>    migrate -d <uri-1>
>>
>> The migrate command stops the VM, saves CPR state to uri-2, saves
>> normal migration state to uri-1, and old QEMU enters the postmigrate
>> state.  The user starts new QEMU on the same host as old QEMU, with the
>> same arguments as old QEMU, plus the -incoming option.  Guest RAM is
>> preserved in place, albeit with new virtual addresses in new QEMU.
>>
>> This mode requires a second migration channel, specified by the
>> cpr-uri migration property on the outgoing side, and by the cpr-uri
>> QEMU command-line option on the incoming side.  The channel must
>> be a type, such as unix socket, that supports SCM_RIGHTS.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started with
>> the '-machine anon-alloc=memfd' option, which allows anonymous
>> memory to be transferred in place to the new process.  The memfds
>> are kept open by sending the descriptors to new QEMU via the
>> cpr-uri, which must support SCM_RIGHTS, and they are mmap'd
>> in new QEMU.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h   |  1 +
>>   migration/cpr.c           | 34 +++++++++++++++++++----
>>   migration/migration.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++--
>>   migration/migration.h     |  2 ++
>>   migration/ram.c           |  2 ++
>>   migration/vmstate-types.c |  5 ++--
>>   qapi/migration.json       | 27 ++++++++++++++++++-
>>   stubs/vmstate.c           |  7 +++++
>>   8 files changed, 137 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index e886c98..5cd373f 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -30,6 +30,7 @@ int cpr_state_save(Error **errp);
>>   int cpr_state_load(Error **errp);
>>   void cpr_state_close(void);
>>   struct QIOChannel *cpr_state_ioc(void);
>> +bool cpr_needed_for_reuse(void *opaque);
>>   
>>   QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
>>   QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 86f66c1..911b556 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -9,6 +9,7 @@
>>   #include "qapi/error.h"
>>   #include "migration/cpr.h"
>>   #include "migration/misc.h"
>> +#include "migration/options.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/savevm.h"
>>   #include "migration/vmstate.h"
>> @@ -57,7 +58,7 @@ static const VMStateDescription vmstate_cpr_fd = {
>>           VMSTATE_UINT32(namelen, CprFd),
>>           VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>>           VMSTATE_INT32(id, CprFd),
>> -        VMSTATE_INT32(fd, CprFd),
>> +        VMSTATE_FD(fd, CprFd),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> @@ -174,9 +175,16 @@ int cpr_state_save(Error **errp)
>>   {
>>       int ret;
>>       QEMUFile *f;
>> +    MigMode mode = migrate_mode();
>>   
>> -    /* set f based on mode in a later patch in this series */
>> -    return 0;
>> +    if (mode == MIG_MODE_CPR_TRANSFER) {
>> +        f = cpr_transfer_output(migrate_cpr_uri(), errp);
>> +    } else {
>> +        return 0;
>> +    }
>> +    if (!f) {
>> +        return -1;
>> +    }
>>   
>>       qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
>>       qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
>> @@ -205,8 +213,18 @@ int cpr_state_load(Error **errp)
>>       uint32_t v;
>>       QEMUFile *f;
>>   
>> -    /* set f based on mode in a later patch in this series */
>> -    return 0;
>> +    /*
>> +     * Mode will be loaded in CPR state, so cannot use it to decide which
>> +     * form of state to load.
>> +     */
>> +    if (cpr_uri) {
>> +        f = cpr_transfer_input(cpr_uri, errp);
>> +    } else {
>> +        return 0;
>> +    }
>> +    if (!f) {
>> +        return -1;
>> +    }
>>   
>>       v = qemu_get_be32(f);
>>       if (v != QEMU_CPR_FILE_MAGIC) {
>> @@ -243,3 +261,9 @@ void cpr_state_close(void)
>>           cpr_state_file = NULL;
>>       }
>>   }
>> +
>> +bool cpr_needed_for_reuse(void *opaque)
>> +{
>> +    MigMode mode = migrate_mode();
>> +    return mode == MIG_MODE_CPR_TRANSFER;
>> +}
> 
> Drop it until used?

Maybe, but here is my reason for including it here.

These common functions like cpr_needed_for_reuse and cpr_resave_fd are needed
by multiple follow-on series: vfio, tap, iommufd.  To send those for comment,
as I have beem, I need to prepend a patch for cpr_needed_for_reuse to each of
those series, which is redundant.  It makes more sense IMO to include them in
this initial series.

But, it's your call.

>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3301583..73b85aa 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -76,6 +76,7 @@
>>   static NotifierWithReturnList migration_state_notifiers[] = {
>>       NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
>>       NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
>> +    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
>>   };
>>   
>>   /* Messages sent on the return path from destination to source */
>> @@ -109,6 +110,7 @@ static int migration_maybe_pause(MigrationState *s,
>>   static void migrate_fd_cancel(MigrationState *s);
>>   static bool close_return_path_on_source(MigrationState *s);
>>   static void migration_completion_end(MigrationState *s);
>> +static void migrate_hup_delete(MigrationState *s);
>>   
>>   static void migration_downtime_start(MigrationState *s)
>>   {
>> @@ -204,6 +206,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>>           return false;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
>> +        addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
>> +        error_setg(errp, "Migration requires streamable transport (eg unix)");
>> +        return false;
>> +    }
>> +
>>       return true;
>>   }
>>   
>> @@ -316,6 +324,7 @@ void migration_cancel(const Error *error)
>>           qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
>>       }
>>       migrate_fd_cancel(current_migration);
>> +    migrate_hup_delete(current_migration);
>>   }
>>   
>>   void migration_shutdown(void)
>> @@ -718,6 +727,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>       } else {
>>           error_setg(errp, "unknown migration protocol: %s", uri);
>>       }
>> +
>> +    /* Close cpr socket to tell source that we are listening */
>> +    cpr_state_close();
> 
> Would it be possible to use some explicit reply message to mark this?  

In theory yes, but I fear that using a return channel with message parsing and
dispatch adds more code than it is worth.

> So
> far looks like src QEMU will continue with qmp_migrate_finish() even if the
> cpr channel was closed due to error.

Yes, but we recover just fine.  The target hits some error, fails to read all the
cpr state, closes the channel prematurely, and does *not* create a listen socket
for the normal migration channel.  Hence qmp_migrate_finish fails to connect to the
normal channel, and recovers.

> I still didn't see how that kind of issue was captured below [1] (e.g., cpr
> channel broken after sending partial fds)?

Same as above.

>>   }
>>   
>>   static void process_incoming_migration_bh(void *opaque)
>> @@ -1414,6 +1426,8 @@ static void migrate_fd_cleanup(MigrationState *s)
>>       s->vmdesc = NULL;
>>   
>>       qemu_savevm_state_cleanup();
>> +    cpr_state_close();
>> +    migrate_hup_delete(s);
>>   
>>       close_return_path_on_source(s);
>>   
>> @@ -1698,7 +1712,9 @@ bool migration_thread_is_self(void)
>>   
>>   bool migrate_mode_is_cpr(MigrationState *s)
>>   {
>> -    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>> +    MigMode mode = s->parameters.mode;
>> +    return mode == MIG_MODE_CPR_REBOOT ||
>> +           mode == MIG_MODE_CPR_TRANSFER;
>>   }
>>   
>>   int migrate_init(MigrationState *s, Error **errp)
>> @@ -2033,6 +2049,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>           return false;
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
>> +        !s->parameters.cpr_uri) {
>> +        error_setg(errp, "cpr-transfer mode requires setting cpr-uri");
>> +        return false;
>> +    }
>> +
>>       if (migration_is_blocked(errp)) {
>>           return false;
>>       }
>> @@ -2076,6 +2098,37 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>   static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>>                                  Error **errp);
>>   
>> +static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
>> +                            void *opaque)
>> +{
>> +        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
>> +        g_source_set_callback(s->hup_source, cb, opaque, NULL);
>> +        g_source_attach(s->hup_source, NULL);
>> +}
>> +
>> +static void migrate_hup_delete(MigrationState *s)
>> +{
>> +    if (s->hup_source) {
>> +        g_source_destroy(s->hup_source);
>> +        g_source_unref(s->hup_source);
>> +        s->hup_source = NULL;
>> +    }
>> +}
>> +
>> +static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>> +                                      GIOCondition cond,
>> +                                      void *opaque)
>> +{
>> +    MigrationAddress *addr = opaque;
> 
> [1]
> 
>> +
>> +    qmp_migrate_finish(addr, false, NULL);
>> +
>> +    cpr_state_close();
>> +    migrate_hup_delete(migrate_get_current());
>> +    qapi_free_MigrationAddress(addr);
>> +    return G_SOURCE_REMOVE;
>> +}
>> +
>>   void qmp_migrate(const char *uri, bool has_channels,
>>                    MigrationChannelList *channels, bool has_detach, bool detach,
>>                    bool has_resume, bool resume, Error **errp)
>> @@ -2136,7 +2189,19 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           goto out;
>>       }
>>   
>> -    qmp_migrate_finish(addr, resume_requested, errp);
>> +    /*
>> +     * For cpr-transfer, the target may not be listening yet on the migration
>> +     * channel, because first it must finish cpr_load_state.  The target tells
>> +     * us it is listening by closing the cpr-state socket.  Wait for that HUP
>> +     * event before connecting in qmp_migrate_finish.
>> +     */
>> +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
>> +        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
>> +                        QAPI_CLONE(MigrationAddress, addr));
>> +
>> +    } else {
>> +        qmp_migrate_finish(addr, resume_requested, errp);
>> +    }
>>   
>>   out:
>>       if (local_err) {
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 38aa140..74c167b 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -457,6 +457,8 @@ struct MigrationState {
>>       bool switchover_acked;
>>       /* Is this a rdma migration */
>>       bool rdma_migration;
>> +
>> +    GSource *hup_source;
>>   };
>>   
>>   void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 81eda27..e2cef50 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -216,7 +216,9 @@ static bool postcopy_preempt_active(void)
>>   
>>   bool migrate_ram_is_ignored(RAMBlock *block)
>>   {
>> +    MigMode mode = migrate_mode();
>>       return !qemu_ram_is_migratable(block) ||
>> +           mode == MIG_MODE_CPR_TRANSFER ||
>>              (migrate_ignore_shared() && qemu_ram_is_shared(block)
>>                                       && qemu_ram_is_named_file(block));
>>   }
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index 6e45a4a..b5a55b8 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -15,6 +15,7 @@
>>   #include "qemu-file.h"
>>   #include "migration.h"
>>   #include "migration/vmstate.h"
>> +#include "migration/client-options.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/queue.h"
>>   #include "trace.h"
>> @@ -321,7 +322,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>>   {
>>       int32_t *v = pv;
>>       qemu_get_sbe32s(f, v);
>> -    if (*v < 0) {
>> +    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>>           return 0;
>>       }
>>       *v = qemu_file_get_fd(f);
>> @@ -334,7 +335,7 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>>       int32_t *v = pv;
>>   
>>       qemu_put_sbe32s(f, v);
>> -    if (*v < 0) {
>> +    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> 
> So I suppose you wanted to guard VMSTATE_FD being abused.  Then I wonder
> whether it'll help more by adding a comment above VMSTATE_FD instead; it'll
> be more straightforward to me.
> 
> And if you want to fail hard, assert should work better too in runtime, or
> the "return 0" can be pretty hard to notice.

No, this code is not about detecting abuse or errors.  It is there to skip
the qemu_file_put_fd for cpr-exec mode.  In my next version this function will
simply be:

static int put_fd(QEMUFile *f, void *pv, size_t size,
                   const VMStateField *field, JSONWriter *vmdesc)
{
     int32_t *v = pv;
     return qemu_file_put_fd(f, *v);
}

>>           return 0;
>>       }
>>       return qemu_file_put_fd(f, *v);
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index c0d8bcc..f51b4cb 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -611,9 +611,34 @@
>>   #     or COLO.
>>   #
>>   #     (since 8.2)
>> +#
>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>> +#     new QEMU instance on the same host with minimal guest pause
>> +#     time, by preserving guest RAM in place, albeit with new virtual
>> +#     addresses in new QEMU.
>> +#
>> +#     The user starts new QEMU on the same host as old QEMU, with the
>> +#     the same arguments as old QEMU, plus the -incoming option.  The
>> +#     user issues the migrate command to old QEMU, which stops the VM,
>> +#     saves state to the migration channels, and enters the
>> +#     postmigrate state.  Execution resumes in new QEMU.  Guest RAM is
>> +#     preserved in place, albeit with new virtual addresses in new
>> +#     QEMU.  The incoming migration channel cannot be a file type.
>> +#
>> +#     This mode requires a second migration channel, specified by the
>> +#     cpr-uri migration property on the outgoing side, and by
>> +#     the cpr-uri QEMU command-line option on the incoming
>> +#     side.  The channel must be a type, such as unix socket, that
>> +#     supports SCM_RIGHTS.
>> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine anon-alloc=memfd' option.
>> +#
>> +#     (since 9.2)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> 
> No need to rush, but please add the CPR.rst and unit test updates when you
> feel confident on the protocol.  It looks pretty good to me now.
> 
> Especially it'll be nice to describe the separate cpr-channel protocol in
> the new doc page.

Will do, now that there is light at the end of the tunnel.

- Steve

>>   ##
>>   # @ZeroPageDetection:
>> diff --git a/stubs/vmstate.c b/stubs/vmstate.c
>> index 8513d92..c190762 100644
>> --- a/stubs/vmstate.c
>> +++ b/stubs/vmstate.c
>> @@ -1,5 +1,7 @@
>>   #include "qemu/osdep.h"
>>   #include "migration/vmstate.h"
>> +#include "qapi/qapi-types-migration.h"
>> +#include "migration/client-options.h"
>>   
>>   int vmstate_register_with_alias_id(VMStateIf *obj,
>>                                      uint32_t instance_id,
>> @@ -21,3 +23,8 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
>>   {
>>       return true;
>>   }
>> +
>> +MigMode migrate_mode(void)
>> +{
>> +    return MIG_MODE_NORMAL;
>> +}
>> -- 
>> 1.8.3.1
>>
> 


