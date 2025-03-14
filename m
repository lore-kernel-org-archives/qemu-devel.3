Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B9C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6Lh-000499-Vz; Fri, 14 Mar 2025 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tt6Lg-00047j-0t; Fri, 14 Mar 2025 10:49:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tt6Ld-0001oc-Qv; Fri, 14 Mar 2025 10:49:19 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBlrMK024491;
 Fri, 14 Mar 2025 14:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tBzKejVfL0HkcAMi4YgZOXGyQjTYAtok7/Rs0c8R6bc=; b=
 aQIwjxBbixfmUnOzlAbbQcjc3HKduv4ascksGPNk+4ZeKE+7BExX8w9u+M6tVn7m
 0Ab5Y8JaUncVo96vQ4bd7yfg7aknTou9RqGo2VAs3DonMUEZYsgotjIv9rq/G6lF
 ykXQPj0qAaGHgwoNmiRnLS0TuOFgOtuAA8B+e52/BD+WTtR1VuWTZv0slZe23lCd
 dS2F2p7TB0PYNZzPDh22DuXpF0kvsM2M/OqMLMslyh4mwXTvzlBh4wIKSGIR9oiZ
 UJib8v4r04UX1+E6bbWi8BMFnUW0tTgeBghwR7diOH3m7fGIDl5AC0LhiKkBmysZ
 0xsErBsQLKUjWM8ef0JBng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4hempd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 14:49:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52EDL4w0011976; Fri, 14 Mar 2025 14:49:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn455sn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 14:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCuAGGTis1uroHbrlwcRNJWUN8I5ZHIYaLyWf7/4xvCQXozft5QHxWq4MwrkpQWZFNDxxt4B2HS49su5uHimMVKkQTMBxQBtvHVXLdV01KcwFc+KRzZGDfkUTVRcnBHHaKEt2Xllxt/atkCNTZf8PaFUDzFjTOolOvqwSELaxUmnMz1DIFoG0pu8a7TYO0CRsdh0uuix/6E5SLjbKc6mcsR9Oto5Wt0rDgvTfKeOuLvxoAZxhtu87j/uB2mmxoL2wlqQsT8GwbUZLQnX3JHWHqt0ZbdBR/gT+BYPppHKtLOlb3+xHY02u/M8xLcal62ac/c/0pEgP2K2m0ArpE4djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBzKejVfL0HkcAMi4YgZOXGyQjTYAtok7/Rs0c8R6bc=;
 b=kAUFSSa2LD1j1kiRoEgpUI7mf2RVqzfhQohQTzaKrS4bgdNgZOEKF2fnHiQv2V2WEWhkWi5Jwz/2tYXHNYZxSqXX4Ym/HnRSQR1fywPugwp560rZTpuEHKsGxfKMZ9BPr3UNwenQIhKuAGJspldLES6DlyGAioU0EB3khnLw4X5dy91fovLprqFrcNC7iX/ANYytvIOenVSvWlEtWQ2+bL8qmigIw7pTmNlih10E4Ay3ucaPZJeGK+Q5/BlVtO3fWJZEGp1XmjQcFQpxiwuBHlXvQm8nFjPc+9DkBJ/RgH+Ynl6KxTJWmWhmxjeokQkUk0PQyTiMyJA0SlTMhFcItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBzKejVfL0HkcAMi4YgZOXGyQjTYAtok7/Rs0c8R6bc=;
 b=rB4EX5UUXiiE8b3kBxM7xboZMga+fX5VdW4pZVEHDce3/R+H68D9uOuzS949rp0KbYJ2ZSec/xZE/5IFVRizCWKsnJGRAdkGWfXXCegKEjAumq1FTNga4i4BwfQADXOcOmDkZQp/ZdYD3oJ4BgfegDbRD5E36up+am2fTaBnoTc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8138.namprd10.prod.outlook.com (2603:10b6:208:515::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 14:48:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 14:48:35 +0000
Message-ID: <b2d15ca2-c014-4cf4-aafb-f16a7ebceba6@oracle.com>
Date: Fri, 14 Mar 2025 10:48:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/28] vfio-user client
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <5910cf36-ca6f-489b-a7f6-b720733f16e1@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <5910cf36-ca6f-489b-a7f6-b720733f16e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 460d4200-8d8b-48a1-e4bc-08dd63074c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2pZS2YvK0xJWGR1ZVJyRXdDeWtuZGRPZlJlRFk1NzM5NUFHbWhiNGNuUUI2?=
 =?utf-8?B?Q2VFYzBNWkZqU0dqU0x6aG1YbHRGRGhtNjlaNnpzWDNDWkpZeTF3L0grZFcw?=
 =?utf-8?B?K3NFbG1ZYlQvRWd2Qkx0cm1YdWU0eFNQY1Z1OUVWVUJYSVBwbmhlYmlJQklk?=
 =?utf-8?B?OERRdFVJMllYeUpjeTRiYzZIYXdPRUxUTUx3UDc3Z1F4eC9Pa3l5Lzd3Z29s?=
 =?utf-8?B?eVp0NE1XVXJvSm5heE9WdHcwQUgxTE9Lam5ZQk1JM2VpdWJNSEV0QkRJblha?=
 =?utf-8?B?TlVzQlVaR0Z6YmtrY3NkVktDSXhhV1lrVkljaFhMeDlKNExFcnBxRDBveG0y?=
 =?utf-8?B?ZDV0ejdhbnh3M1p4bERneVpOc2V6emI3VzVyT1MyUjV4VVZSUmtyNmtGbklx?=
 =?utf-8?B?SHJ4eG41WXJONFNmbkFTWUpzTmNYZkFtcnhlT0FlUzR0SHprNUpwYnp1U0hL?=
 =?utf-8?B?QmFhMDJaNUowanVTMjdEeTlFU3RKWEd3bTlzOERsOFVKSmpsVHQyYWN0QVcx?=
 =?utf-8?B?RTMxTzdyWUljdEZzd29ZRkxZbUpwa1FPUXF3VXVGeVFYa0VydzhnWGtDSlhE?=
 =?utf-8?B?T00xdFVCRWZhU3h1RHpCUTRjYWxzdStBT0x0WkxrZG1TNlhuajZhUnIwZTBK?=
 =?utf-8?B?b2ZEbVJBb2RIZDNoeEtmU2svTWYzQ2R4QU1JR0RUcklPYlREMXFIOEFmdWtx?=
 =?utf-8?B?ZVhzNUYrT09qN3RNbE42dElsT3BLbmNwRnk0VU9yQWdXUTI3N0FUMVhIeW9B?=
 =?utf-8?B?bjBtamtNcWwydGxqSlRIODZ5Q1NlZDJtWUF3eW56N3VXNlNSQVhQMVZXdkp0?=
 =?utf-8?B?eVVDY0Q1QlYzc3hnblVrY0dpTG9zOThzbFJMMnFWNFN2OS9heWR3MUZ5ejNk?=
 =?utf-8?B?VElKdnZwTzBwNnJTbkYvaDhMV3ExM1NyVjhMc3BpT0F3WEVoRVI2Vkl6OWJY?=
 =?utf-8?B?d242UEtNd0hZbEdadzlrMW1RYzlsNkQvRWthenhYYXNhMS9pQktwR0hna1lj?=
 =?utf-8?B?SzVlaGtlRE1SckxyZUl6NXR4bzFURXUrZVhTYnJTV3FvTFF1QVZ4OFJDNGEy?=
 =?utf-8?B?NkJnbEdLVmlFZ1pna3lKSUwvZGZpRUpYcEg3WXFTWk55U3EwRjd0S05xaDRt?=
 =?utf-8?B?Wjk3eFhQM0V0ODl3OTI1N1ZoR2tPL1ZMVW5lTUNNVC95SE5PTTN3RTNaMkIz?=
 =?utf-8?B?RGtOSlBQd2JaWEdEV291dXlaMWIvM0FVb2d1alloUWNjMVJsYmhEbGtqM1RV?=
 =?utf-8?B?Vlp3dkc0cFE1ekdOaEZoTEFMeFhOZWpKTGNsYVl2Uml1M0xmYVhXMTdwV1Rw?=
 =?utf-8?B?ZzBJM2ZRSS9KSDR0U0NIeHdKczV2YXljWFhpcnNqZEh2blltOUVuc0gzM21X?=
 =?utf-8?B?eklnTm5TcWpjRGI0RmNUSE8wWS8xT0VKQTArbnVNOFR1UllpakMxUzlzVnFK?=
 =?utf-8?B?OWRVWDRBZWpBVC9EWlVKcUY3dS9OUVRoTTEwWE9TTTE1WjdWd1FYU1RDb1oy?=
 =?utf-8?B?clc3cmxpYjBmZ0VrNm4zU0RRVDVlT3Q2NGs5akNxdnlBREJVR0VaN01RSnEy?=
 =?utf-8?B?b0ZMRktNeEp0M1dEVFZKMWFxOE5PUTJ5TEFlTjFyYUZ4b1lZaGVkMnpVeUFR?=
 =?utf-8?B?dlkwbisxdzBydXN5aTU5VlBvbEF2bHdDaDl6U3pGS2JvNEV3aVlIRU9CaS9s?=
 =?utf-8?B?NkRyYVRodHdZYTR1MGJkWVF1cHRvRkVDUVAzWEswZ2lSZThaL1RJd3FmbFA3?=
 =?utf-8?B?NUxjcGZ1a01YajlBWFpxUGFoZ3dMTlM5Wk9SUUNsQWxqeFA1dVpvdXBmUVMz?=
 =?utf-8?B?OTJSTU8yckxGT3UvQm1rVGFzVXlORVAzUU12TWNhYjU4SjMzbzg2ZUFFeEQv?=
 =?utf-8?Q?wpJzg5A72SPgH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTAxeEczaDdteWxjcDIydTBtdHJYYWNrQ1dKOXc3aG9McVhXNzk1WSs4U3dG?=
 =?utf-8?B?MVJNTU82V1Y0UDdFVnBYeTFwYWlNRHFMZzhGS3MyOWxudlRXbmNJaSt5Wm5F?=
 =?utf-8?B?L29yNENSUjcrM0tsaHJmRHFpS0NlNFVQeDhCOCt3MzhhOUFZZVBBTk05UXlY?=
 =?utf-8?B?UStnem1aZWFIMmlrVmR3bGpRQy9tbE0rbHgrbThaT1pXNklWdDZZdFBZUDRj?=
 =?utf-8?B?cVp5R3NDZDNSZ29PenJvS3M2UU1BUXZxTnpHVEN6OHM4SGY2SzFpQ3lFU0hG?=
 =?utf-8?B?R1lnUW5iVDNyZjdWYUNKbllyOU81UTA1TTJzTW5JZUtFQWNLS3paMkthSWdq?=
 =?utf-8?B?aG1PTS83QXJ4cnhHR1NOTjcwVjFEVTArVVhwaHBuMjR2SVAwdS93enRoRCtY?=
 =?utf-8?B?WDNUTjN2MlBSQmZGUGpYczc3Q2xyVWZTOGRSQXBoMzJXV0hOWFVac1oxbU1D?=
 =?utf-8?B?WnJZWFZDMkFMNFFzd1JZdURNbldiaGtaSmhCMU81ajVSVnozQXRlSlVDcGJq?=
 =?utf-8?B?QVZVZlp2UUpieEdPcHh4VjdoUHZIOTIyUnN1RnNudXk5Ujd2YjVQT2kweXNM?=
 =?utf-8?B?VDJRanBNY29Meko4ZW4ydFlRUVlXaWdkMFVyTEZoYkJWTjNhTjBQQkYxWmJn?=
 =?utf-8?B?SHdJSk8wMmpqVjB5S2E2NTZoZHh1STJTdnplUGRjenNuUXNsUWwzZFFpdHBF?=
 =?utf-8?B?a09ucG53eHN0TVN1VzJMWlFGL0QwZFJqZUl3YS9BYWRrU3kyNk9oTmRKZTc0?=
 =?utf-8?B?NWhORTM2WXRDbGRkVVMwMGFuYTBpcFVOTC9aV0E1SFUwTStJMERub2tGY3Zr?=
 =?utf-8?B?d01FalNlM0hvSXFaUkxXMWFCSitGa0dRVG14UkRNdXdEMVdnMndpWEE4b3pL?=
 =?utf-8?B?Rk1qRkdtTHZPYlhJU0tKMUZDSDEwaStCR2RTNUFVRjltYXNrbG4ydEM1QnlM?=
 =?utf-8?B?MXVrQnlYa2ZJZ1crYVp3THJEYlRHd2ErM2h4VGs5aVFmaldkaGh0WkZMcWZN?=
 =?utf-8?B?Szg3Vkh6dk01aFlKV2tsTWQybEtvNml4T0IrR2YweVREQ0FyeFhhQ2dQWkZP?=
 =?utf-8?B?UVMramhBN0xZSDhKcm0rN3FnYVYvWnFBRnYvNkk1eG0rQ1lNalVqZWVGTmtK?=
 =?utf-8?B?V3BQeDdXNUxyVmVQYzFLNG5sY3lobnVtVkdkSzBVT2wvZDJTLzFPc2ZDMUhV?=
 =?utf-8?B?dnJKV0pYYjhSVUcvenVwZDB1Ym85Mmp6dkEzT0FzOFZ0eXhNZzd1eXVYd3pN?=
 =?utf-8?B?bFJnL0VrR0NUREhKSUtUbkg2d243bWx0QTNoMVBuRTdzbTJVZjJ2enVScjlz?=
 =?utf-8?B?SCtrV2lUTWJ4Q09WUjR4QnZYd2ZzaEdGbTdQdm5VeGZya1lFcXFENkRSWE1N?=
 =?utf-8?B?MTZlY1BKSVNma3EvYU5Id3M3bTc3TXNCN1QvTHBXV3Q1MklGcnVyL2xwb3RE?=
 =?utf-8?B?RnBlRVJ0ZWk5aDAzaUZ4NS9UTWkyaWZCSUVibkpXVkFvV0dTb1F3N2ozVTA2?=
 =?utf-8?B?aUd2amlnS1NNc3RIR2owcFhiUXFreCsvTEViMkYyczl5QU9rOWszWlliYTZq?=
 =?utf-8?B?MkU2QW1zallTZ3JqUFJlTlVZYjFoZGxDdW00NGRDU1Z6ai9yZUJwUUNMUkRk?=
 =?utf-8?B?MkkrNnRMUEt1enk2Rk93ZHhsTzZkdmxma0NFdU96RnZQN3JEZEx1QktHSlow?=
 =?utf-8?B?bHd5WXE2WThpV0NWY3I1VHZvQWt2QTdnNzhsZE1aRDI4S05CdHZDM2JtcjF0?=
 =?utf-8?B?TXlNSGxyZk9UTXV2R0N5TmhNU0lxNE14QkNDaXg4dTU4Z29lOCtlSjQ1am9y?=
 =?utf-8?B?OVRNRjA0ODdTSXZVWU14TnBEam11SlJ3SjA5ckw3c21lQzROWWd1Y2E2LzR5?=
 =?utf-8?B?N1NtWmpobWxNQzNDdVV6TlBaV3I4U0ZYbVZxSDlxMWU0ZVBNNjVGdU9sOW9m?=
 =?utf-8?B?WU5oMVJmdnZRaEJtcGJDZEI0Z2ROaEw0bW52Zkw1VFVTOHFHWTQzNXpoUUhS?=
 =?utf-8?B?WURDZm00VTdMRmdXeEt6clZ3Y2h2QUpsZjQ2aWxMRlVyK01YLzFGRnBNamF2?=
 =?utf-8?B?VHJWckJJTzBhZU9oSnBjWXRRTG1hVkZtRU5pYjl3b2hGTWIvOVdaV0NhbCts?=
 =?utf-8?B?VHBycFM4dmR6NGtobjRPSDY5alUzdU9WYXB3SGN5V1k5VW5BZm1IaDNOeENp?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: haF9TAqjnKmdnJaKaqRL0+kK0xzBtZyC18YDNtYdbPkF5Rq7WVYw0MLlHwlDRNXbY1OQZemYm/cNR26Qo0pubBFOiWrhX0yXSqZZpctq0YYUig4KDDnhySi/m5TZfNs33UVtGIlHpuDd9uU5t4tBBpL7t3gWprYI8zvZlE2tzBoB0Ub2mNpzkN7fnU5x6e8dCdOMqpnIP9DgtaTKi8VRXW/oUuyqv/d03hD8xJ3j9WrbdeeGcr0us9z/FOoyGKaVTS+9fwGB31QUn4GKSEOY8hYbBuJJyKl/YoX4INQaMiNf0smnZv0BXOsaibqYlsYDk3YwiW0piWbh/Wjcss1x3t0oL9vCSHP7SwShxjX0c1e9zAzfxvedX7rqe5GO4wxQQl9r6AJWpq114ZH/3rucM0HmwFYLDvGU5qqJGeiDmgPzI1BzfowDLZBMbcIg5l++SAUbo1W+dGRAP1FuKGNVMZnL+d6AKMYE99JH5SqNpGX/Wbm2vxBolLLoClbfbySYrlKnwlF0EBVu24wo9r9QNXC5VJrkVfSUglJVfCAt+UH+9qIeUeyOlIDUx+gK6AEL0DkAGPj4oMhSscdzCt4jbPQdpVVFgHDKxeErpzDi85E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460d4200-8d8b-48a1-e4bc-08dd63074c41
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:48:35.3614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz3T/XHWqBufN3TUQBJ4vvsv9jk2Xv64mh65hISVk74JlGiMqjgGYqr2KBKANqa0DVCmSjjwrBBPmG6O5jwk8NvqASdxl/KcVvxo+knsvfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=681 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140117
X-Proofpoint-GUID: fjvDKVVs0VucK5-Vn1HjBhWk5E5LeYkX
X-Proofpoint-ORIG-GUID: fjvDKVVs0VucK5-Vn1HjBhWk5E5LeYkX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 3/14/2025 10:25 AM, Cédric Le Goater wrote:
> John,
> 
> +Steven, for the Live upsate series.
> 
> On 2/19/25 15:48, John Levon wrote:
>> This is the 8th revision of the vfio-user client implementation. The vfio-user
>> protocol allows for implementing (PCI) devices in another userspace process;
>> SPDK is one example, which includes a virtual NVMe implementation.
>>
>> The vfio-user framework consists of 3 parts:
>>   1) The VFIO user protocol specification.
>>   2) A client - the VFIO device in QEMU that encapsulates VFIO messages
>>      and sends them to the server.
>>   3) A server - a remote process that emulates a device.
>>
>> This patchset implements parts 1 and 2.
>>
>> It has been tested against libvfio-user test servers as well as SPDK.
>>
>> Thanks for previous reviews & comments.
> 
> This series is going in the right direction. Thanks for all the
> changes. However, I will postpone my review for the reasons below.
> 
> VFIO initial commit in 2012 was a single file adding support for a
> "vfio-pci" device. Since, the subsystem has changed a lot and it grew
> to +16K line of code. Over the years, we've had numerous additions,
> VFIO platform devices, s390x VFIO AP and CCW devices, migration
> support with dirty tracking, support for different host IOMMU backend
> devices, multifd, etc. All these additions never took the opportunity
> to introduce a VFIO interface for external usage and PPC, s390x,
> migration, backends subsystems happily and randomly peek and poke into
> it. The subsystem is now a happy jumble of disparate functions, with
> weak organization and names. The vfio-common.h header file is
> good example of the result.
> 
> It's time for a global code reshuffling. I'll take care of it (and
> I've already started) and this means nothing new (fixes are OK) will
> be merged before this is done. I hope I have made enough progress
> before the start of the QEMU 10.1 cycle. There won't be any functional
> changes, but there will be new files and new function names, so it's
> probably a real earthquake for your series.

Hi Cedric, as part of your reshuffling, can you incorporate the code cleanup
patches that I submitted in the live update series?

- Steve


