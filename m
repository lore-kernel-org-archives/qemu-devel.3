Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB34C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5RRh-0003Po-3k; Thu, 17 Apr 2025 11:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5RRS-0003OA-4V
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:46:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5RRN-0007Q1-OS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:46:16 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBphsj028919;
 Thu, 17 Apr 2025 15:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=zO4cpv6LikWNdy1nzq32vA/mV6dMoREKIFf2SXRgw9k=; b=
 A7J00qH+jYenWxhwj14KCGzOk0jXFbBePjxYReAMSZlrD2CLBrCiwaL11DdL1x18
 9p6BqzMcxWswh/KvkxRKvdS2WyPBG6PVFB6r2EMTIwRe08CqfpnkWddsA+EdY5SD
 nvFiYZ9euny0WL79/fblVLfsHV0FG4XDz0uWKQxtuj3nxmdErbWZRYUaUM15dtmZ
 d1kZ5hquOB8RmWhw3R/YKyeTQjwIYPVx9dWDJiE+Sp5DqI57eMeBa80iqCaAvxxS
 j4iDcRxXM9AnM3RXc1wQU88KNFl9rMbIbGKhnhwzBrGu/z5SNt7mgXfVceYGPY23
 5/pg8oTOLqcyaVT0wSnNxQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf6xa0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 15:46:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HFfxIu038792; Thu, 17 Apr 2025 15:46:00 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 460d4uq8ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 15:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSQZ7hbp4ePDNYXFQF+qrKlWqYzMnNbaUa3jPwBCSnKmyxQiWRjjIh2zfhffR3nPa+FuFwbW66z4BNc59CPDKIII6b0C440cJwBGoI6LXQodXwPbL/UY+y378njBOlGlO0/Cuj1bvYmwYwCIA2ODgK0HKGNiIVtQOrfeHQE+KgJ/26/mQ0dJgg3Bor6jiXebYS0bHF33msIaMkdexqFIR5O9j4V7YZ/6eBvf/kXsRdf+NpiHq9HOeA5m9GVRhgozEa6zP4odkscnaKdHZEP+SyotDao7a8Wn/1/gk6sm0v9/vLc4g5jaQW2FqCx3FQvkBFYAn1zIhKQjAxrzch3Hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO4cpv6LikWNdy1nzq32vA/mV6dMoREKIFf2SXRgw9k=;
 b=yWdIOO3lYfDI7KQzYDB6rYOsNe8M2ZlCROwbM9lke1PTN9w3VkwDfy6M123IUvyhWlbFurlQ/8XCqbvjoPifJgWD4unaxM7h1kJ2URp9gqa2nxj5KZcVdI/3qiMwkZ3LKevMx0u8grgxc5KOZt1DwAHuodyNY7YFqO4axxxc/YDvHHXmhMEXYAWYxka47Y7LIum0YlgY2OhreEsMS6Xdab2Wm8freNAw+entBWiRN//SV+yRxTtegJ4hW20wiPxR8b8igI1meGWyu0slYyoyflhgJJD50P6pZhVVXKd+opERFH1m+E258WiqvucBB2tzahebWzbaqvJRhjOTt+Elhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO4cpv6LikWNdy1nzq32vA/mV6dMoREKIFf2SXRgw9k=;
 b=Kh99DbeTChwYWaO3NYHMwIIBByF7zQM24qKQ0CZk3YzydKyImCFC/0bHJs9cwTqWfdO0Fhve+JwRMZZc91Zr7pWYt98N9MmmQqJCzNUOgeZ3FRkSwPz6ipQrpzqCM1YC09m+CXXmCTVH/mUhAVeuO7sFKIF6YL24UXP292XhfuY=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 17 Apr 2025 15:45:57 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8655.024; Thu, 17 Apr 2025
 15:45:57 +0000
Message-ID: <e0483cb0-034a-4a28-a74c-d7c45fcd306b@oracle.com>
Date: Thu, 17 Apr 2025 11:45:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] amd_iommu: Add a page walker to sync shadow page
 tables on invalidation
To: Ethan MILON <ethan.milon@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "peterx@redhat.com" <peterx@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "sarunkod@amd.com" <sarunkod@amd.com>,
 "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-11-alejandro.j.jimenez@oracle.com>
 <480ab3bd-e34c-4c12-b9b7-99ef754dcb85@eviden.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <480ab3bd-e34c-4c12-b9b7-99ef754dcb85@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:208:32e::9) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e149b3-4e63-4b7a-5cc4-08dd7dc6f211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVdxL1I2WmVRR013M09aT3djL0ZBb1FUM1lwSEIwcDM0MzNicms2MEhobWcx?=
 =?utf-8?B?enR4QWlzby9leG9QMWdabjNwSG5ET3BBckluZFh6M0Eybk5yQmEweVBwem9F?=
 =?utf-8?B?bmRIZ2RoU0hBWGlPdDdXamZnV2dkcXdsa3BBVzdMSjlZSU0zd0tlR0dhVDhx?=
 =?utf-8?B?NldNN2JXMnByalhROVBiRUJyaENWYjJPR1QydjNSaWt3ekdwWmdFZXEvQkNz?=
 =?utf-8?B?bFhRRU1saGM0clhSdUxYaDRFY2kyWkFvcTNRV2c5ZlZMNnZ6NUx1MThSMXpt?=
 =?utf-8?B?Z2tzRW8zQk0wOStYemJENHFkbmwzL2JMZ0hEcnI1N1FwQ2R5U1piY0Jna1lM?=
 =?utf-8?B?ZUFaNHZiRjlJYTRtOUhhZGd6UG4vREx6VnZhNmM3QkEwTXcrTUVqY1IrTHlu?=
 =?utf-8?B?KzlQc3c3cUNlRUFtY2NCUnQ4UWZ6K3dWdk5RNWJiWmJDTHpIKzJaU2haYjlY?=
 =?utf-8?B?SkZvOTZ0ckp4ZjBhTzVEL3NoVXgxNHhYVzliZStGaytKeFlWZmtXMTJLek9t?=
 =?utf-8?B?aDJ6Y1N6YU9Hb2hNRjRJa3NtVHIyU0ZHK1o3NEROQUhiMWVuWUxuYVZyb2lw?=
 =?utf-8?B?UnJaMGwyb0NWS0JMdENxRWx3aGwwYjl4QmdqdmNJZmJQUWtmN2ZCZ3BlUU43?=
 =?utf-8?B?bnVPeFVvcnZrQjhacE9KdkFKWTZXdmU5ZnVLejcyYXhBNzh2dHkrTDd5UE1j?=
 =?utf-8?B?Um5ZVVd2VnlHOWZTeVBaK21xR1ErOC9lbFZQVnVpQ0lVMldEdGh5NzQxMVNC?=
 =?utf-8?B?cTdWL2VWOEZjKzNlRUdFbnNwc25lSE0zZGRpM1kzYTlVbjdJV3M1YWhoNnQ5?=
 =?utf-8?B?K1UwQTFSVzI5TTQ4ZEk2TGpKTDAxVVNsYy8xY3BqSU5UMkpUNnhubVh4OTc2?=
 =?utf-8?B?SjYrbGVlUFpRRDNhNGF2c0ZpU0xHcU1Jd0RRZi9uRTZNdDNaK09uV1pCTHdY?=
 =?utf-8?B?UVRTTGJxdzVHWVd3UUREL1RaazdiSnNQMXA4dTlrZ1VOTUQ0dmJhNW1wWTdp?=
 =?utf-8?B?STZIWll1c3c0NDFaaTdaS2tLSUdmTXFaV1VLMjAwNUJQTW5vU3dmNUw0eUNF?=
 =?utf-8?B?bU1HOWNpRkpqK3VBMHhXTHJ3UFkyN0xYUXVrU1lrbjdZMktLTnhqaW4xMGRi?=
 =?utf-8?B?RUtFSlBjajJwMU1Ndm1ha1hwdFNmR0ZFQng1dHZZOHU0ZjRWNmFyeFgxb2RZ?=
 =?utf-8?B?UkYwQlVvclhqTlM2aThXa20rbkYxVDg1cnFrVWQvUXpaLzJhUEwxN29GczhO?=
 =?utf-8?B?VkdQa1h2eXRWSUFubXkxUWFTQ21sL05kOWJnYjhrYzQzbFdSOVdHSnFIaUp4?=
 =?utf-8?B?aVcySmdEa0dYOUd2MmRZL25TVWZDTEtHQzZIWFo1aUlGYWZ3emZnd01TdjM5?=
 =?utf-8?B?bEtwR2Q3WkdiMUdTVXpwMzNlWHJJWkV0WFNpa0IxSy9HWGo2dTRLWUlERzF1?=
 =?utf-8?B?bXlSV2JEWHJzVmtmMFhrc0JuQStxS3lrZmJOUzNFNjFOS1pjQ3JYVXlBbTcv?=
 =?utf-8?B?UTl0eVk2RG45TVdHbE0rN00vY21zM1c2ZloySTZKaTZOVVdieDNyMnJSeTJh?=
 =?utf-8?B?SVVVamJBc1ZUUjdFbUJybjA5VTM3ZDlUREZwZnA1RlhyaTd3aWxSc1BJQmFn?=
 =?utf-8?B?bU9JMFA0RzdEclFQcXJMc2U4YVF1ZVhKK2RRcFAxY0YxNzBYRGpxeHJZMDJI?=
 =?utf-8?B?T1RKTWU5WXJWRzFhR2RyZ0FVZ3lzSGs0RFI5T3pJaU5oYmVqaU5wL2VWMmlI?=
 =?utf-8?B?Y0UvWVFvRzZOVXBNek5GdFJ1UGdldUs2dnJ2c2VpSXByb1E2c1JLSVNxM3py?=
 =?utf-8?B?VjJKc3V1WlUzelZmdG5kbVIvVGlrdU9hU2t6eDNmckdhdlpKanlTbnhCbk53?=
 =?utf-8?B?YXRKQUg3ODdCS1NjN1N1T2REKzJnVlBzTXhFYXN3bWxDaGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmMxYUZhdlkzYXN1ZGVpZ3lqMnRzQTA4dkU3bmNZckdVU0s0Y1MwOGVSQTdN?=
 =?utf-8?B?NGFXWWRQUXBYRVdvTFNWUjJDRTYvQko2cnVjclMyR0hkV3FTZHNia1FnaDVR?=
 =?utf-8?B?WGZCSGZ1MUtJMXJoWUx0QkdNRkV3Qm1KUXh1QXUrZUZKT25TVG9hRUJTSUhP?=
 =?utf-8?B?LzI2b2pxc0FuVFdCUm5TTktyWGVyN2EzTHBQSVRSUG5kOEkwRndZLzRZSVBn?=
 =?utf-8?B?dGZqWS91WjMwRERrNWpuV1BDV0hRUEw4dlREZ0VUSGYzZVk3ckJZRWppKzlv?=
 =?utf-8?B?U29DcXkzS2ZEdENZekc0RXBVUm43cCtaQ3hBR2hNWFRyYWdPVjc4VnZwVy9Y?=
 =?utf-8?B?UXFUNUF0Ums1KzRQYVZKSFRjNVEvMC9Fa2duQVlERGJSZkVVWGdyamdRYzIv?=
 =?utf-8?B?ZlM5TUxnZVphRURzeUI5NlZWazM2MlgzSWtCVUh4TDdrQUx5aVkyUVBUdXhQ?=
 =?utf-8?B?dGVuL1lma2VuZlpQbzdvd0MrMzRranlWVnl5ZC9BVStkTUdPRkduSWQxNWRz?=
 =?utf-8?B?UHhSQllxazRPR1VqQ1d3YktvcmVHRXUyWkFYSEJJM0RlNTBzWDhiYW1DalBW?=
 =?utf-8?B?cy94UDFSaVZCeTkyUXlYVFhFdnZDVzRYcVNLak8xemxyVUl0THN5eDNEd2Fv?=
 =?utf-8?B?SnlscnMyWmlKaE01dUUxSlNET00xT29PNTBSNmNoVDlJUzExZzlGelFldjM2?=
 =?utf-8?B?bHhGK05wNHY2bUpMWUNYdDIrd1dkd0hqMURXQ0ZrVnNUcWFjTEREaUVMV0dj?=
 =?utf-8?B?QjNtcE9TUjVFVW1Wa1JTcDE1dnlneFlia1JuQ0dYT0hIQVYwdXRhdnhzNCsx?=
 =?utf-8?B?aUd3RnJ3M0FqLzJ6c25nanNtSmVwMVo5b2FBUGhmTy8yN2pQRWhiYnRPVDVV?=
 =?utf-8?B?ZDl6S2JnYTFkSHM0eGIyd241bVR2Mnc1Zjh5MEFnQzRyMERQeXduVU9uNWNq?=
 =?utf-8?B?WXd5NWk5am1mWEpweWxxdGJuVWJIc1dvczdDNEtkeEFZL2NobXV5SWs4TkdY?=
 =?utf-8?B?L2dkem5lYldXUHdmZkRGTjB4T2F5VUp1ZllnUEpYaWRtUHJUL3g3Y2pyUDhO?=
 =?utf-8?B?aFowQzRBWE5HYU1oRUJudVJCM3dXcGhMREE3TkFqSmJwUFFHekZKL3l5aGRj?=
 =?utf-8?B?NVVWSkRpQjM4VE5CdkRGUEw0UE8rbVBzYUFWVGJjWDBBQ1J6NmpGOEpUV3ZB?=
 =?utf-8?B?Y05nRm5rY1lORDMwL1RhT3NHZjlpdHNmMVZaamh5L0lTdS9iWWN4cmtCVjFs?=
 =?utf-8?B?MUM1ak5pWFAvbzIwT21LZHR0bnpYRFloNSszTm0zdXlDWDQxcGVxcWpYQkhM?=
 =?utf-8?B?dWZKK2tXRmRyVjd1L1VrN0gzVWxsQlNXZklaekFYb1huZ2VOL1F4K1dwSzdB?=
 =?utf-8?B?WE94ZHpuakQzNkhaV2xQZEI0OEw5SHQrUjhZN0ZoQm1LWVVjNmJSTGdFblla?=
 =?utf-8?B?ZjQvQlB0eEhlbzVRVzRoSWptNC83ZGJEaUNWMFJ5SCtxRUl4WWRFSUl2Q21z?=
 =?utf-8?B?aDRsTG13b25uNnlvQVg1RDBRSjc5WG12UHFKcE80cXJLWDhUUWNPdmtodFVm?=
 =?utf-8?B?a2JEOERpdW5INzN3T1NFN1VkSmJlUVU1ZDIxdUNyc01UZHBUNnloejNsajZz?=
 =?utf-8?B?S1ZVeDladFQrNnlyQlAyZVZ3R1d1QjJ4dmcrREZZUFdDckVseko2R0g4YjVt?=
 =?utf-8?B?L3grVEtadC9kdmF1UHlEMjZwakNzMXZXdU1idUYzNTQyNEF3ZC95cHN6clQz?=
 =?utf-8?B?eEU4YXp1MUFObHNaK3hjMCtudVZOdE1la3VYTXdOOWJuRGhGd1dFaDgxSy9j?=
 =?utf-8?B?eHpRazZJL3JyQzhvajJ1NHRpVmVOcjVoSXBPcStVc2g5Z0J2N0lxbEdTcXBU?=
 =?utf-8?B?Z0Fya0JhSUYrc1dVTlN4cEQxVm5WRUhmMkJjWGt2UWJHOG4zYnNaKzBRSnZj?=
 =?utf-8?B?aHJ3ZzF6R0k0YzQrYTFyWEZCNm5TVUU4bDdDNjBTZHQ5cklHTTJZcTdwNkl6?=
 =?utf-8?B?OVdLdnJMbGdQWlNYcHVRYmExc1l0NU9ybElsN3hzbnVYMERSVVdVajFkUnAz?=
 =?utf-8?B?UktqZjZ2czdQUHgvZE53MTE2Q3pFMUFkblZ4ald1dW0rUjBoQ2FwWi95d0JO?=
 =?utf-8?B?Y0hmZFF3enVqcFVuejNZNUJpeGxWdnV3UjZEY1ZUTGp6TVEwWkNaRFNIUnN1?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gyjmayiPV8b2UdkjPaZ6YLRdDyAlDpvfrh2ZsAUOGzmM6EOb3ZNHoLLiIo1z6NmGQv2VT3ZuARAM7YeLYe7otIDdAxaVA/jTvoMJ2WaWCb46HUGnTI8J6GtkIKGrGIsTgQ5Zi284K3cekTKZnmrloFu+f9x6a3mux3SwgtIsybpjQd/9qMZEz/k3NFMa3UdhCT3x/d51nknCqiPMN81w3Sp/VdqSrh3EKEqWbDHqwlzWp0XfxjfMGXDPImHV1f+R0jZLLWHdXKzwY+KA3Qqn1Pd18t5OIjzZUaUr2iQGFSzJzyRppQvynfoFwZo0JT5VW0/ERV9dp8B9UCUgJBIDrV2gbDayPNeyFB4sCUIxgaLy3GpuecG/s8dyAi8VPOfS8YfAvX8gp4sNEJ7yvBtu7HWnYTLt6BIk1Mt6OYfL+rIHobf7eLuiDZakAAZDxXKX/vc3G1KxpiqWsybZPMNAJAy/f8etBohxTSNejw22Y3hC6666DrEvObPeKoasqqfipNCgVscBlXFTyNAs1G/hYHwFaMme2NxuFMXxjaV3YmHk+qzt1PbDgIHDP8Uxk+en5TusyJckRsfRtVIY777tjNy2SnyltT7uSiQm0bL6A10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e149b3-4e63-4b7a-5cc4-08dd7dc6f211
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 15:45:57.6378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSCIR03qHEOeWHLjfm0cy4SZBiZHVAmonRMK3Zv44jyzASoyNCotrJASapdAWQeeftcy9aXct/ATIYKT1xNp9IgC5QticNoge41//TSbjXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170117
X-Proofpoint-GUID: Z9tb2PYzPmOcLMxwIq-PkzQHMPfZ0fa5
X-Proofpoint-ORIG-GUID: Z9tb2PYzPmOcLMxwIq-PkzQHMPfZ0fa5
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



On 4/17/25 11:14 AM, Ethan MILON wrote:
> Hi,
> 
> On 4/13/25 10:02 PM, Alejandro Jimenez wrote:
>> For the specified address range, walk the page table identifying regions
>> as mapped or unmapped and invoke registered notifiers with the
>> corresponding event type.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index d089fdc28ef1..6789e1e9b688 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1688,6 +1688,80 @@ fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
>>       return pte;
>>   }
>>   
>> +/*
>> + * Walk the guest page table for an IOVA and range and signal the registered
>> + * notifiers to sync the shadow page tables in the host.
>> + * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
>> + */
>> +static void __attribute__((unused))
>> +amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
>> +                                   hwaddr addr, uint64_t size, bool send_unmap)
>> +{
>> +    IOMMUTLBEvent event;
>> +
>> +    hwaddr iova_next, page_mask, pagesize;
>> +    hwaddr iova = addr;
>> +    hwaddr end = iova + size - 1;
>> +
>> +    uint64_t pte;
>> +
>> +    while (iova < end) {
>> +
>> +        pte = fetch_pte(as, iova, dte[0], &pagesize);
>> +
>> +        if (pte == (uint64_t)-2) {
>> +            /*
>> +             * Invalid conditions such as the IOVA being larger than supported
>> +             * by current page table mode as configured in the DTE, or a failure
>> +             * to fetch the Page Table from the Page Table Root Pointer in DTE.
>> +             */
>> +            assert(pagesize == 0);
>> +            return;
>> +        }
>> +        /* PTE has been validated for major errors and pagesize is set */
>> +        assert(pagesize);
>> +        page_mask = ~(pagesize - 1);
>> +        iova_next = (iova & page_mask) + pagesize;
>> +
>> +        if (pte == (uint64_t)-1) {
>> +            /*
>> +             * Failure to read PTE from memory, the pagesize matches the current
>> +             * level. Unable to determine the region type, so a safe strategy is
>> +             * to skip the range and continue the page walk.
>> +             */
>> +            goto next;
>> +        }
>> +
>> +        event.entry.target_as = &address_space_memory;
>> +        event.entry.iova = iova & page_mask;
>> +        /* translated_addr is irrelevant for the unmap case */
>> +        event.entry.translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) &
>> +                                      page_mask;
>> +        event.entry.addr_mask = ~page_mask;
>> +        event.entry.perm = amdvi_get_perms(pte);
> 
> Is it possible for the dte permissions to be more restrictive than
> permissions of the fetched pte?

No. My understanding of the documentation is that permissions can only 
get more restrictive as you go down the page walk, because they are 
logically ANDed with the permissions of the levels above (including the 
DTE). This is more or less verbatim what it says on the Spec on Table 
17: I/O Page Translation Entry (PTE) Fields, PR=1

More details:
I haven't found any place where the Linux driver modifies intermediate 
permissions. As far as I can tell, alloc_pte() will create all the PDEs 
with RW permissions, and only applies permissions/prot requested in 
map_pages() to the PTE. So the effective permissions during a page walk 
are really determined by the leaf PTE.

The above is why my initial prototype didn't bother to check the 
intermediate permissions in fetch_pte() and only checked at the returned 
PTE. But I had to implement the intermediate checks since this code is 
emulating a hardware page walk so I have to comply with the specification.

Thank you,
Alejandro

> 
>> +
>> +        /*
>> +         * In cases where the leaf PTE is not found, or it has invalid
>> +         * permissions, an UNMAP type notification is sent, but only if the
>> +         * caller requested it.
>> +         */
>> +        if (!IOMMU_PTE_PRESENT(pte) || (event.entry.perm == IOMMU_NONE)) {
>> +            if (!send_unmap) {
>> +                goto next;
>> +            }
>> +            event.type = IOMMU_NOTIFIER_UNMAP;
>> +        } else {
>> +            event.type = IOMMU_NOTIFIER_MAP;
>> +        }
>> +
>> +        /* Invoke the notifiers registered for this address space */
>> +        memory_region_notify_iommu(&as->iommu, 0, event);
>> +
>> +next:
>> +        iova = iova_next;
>> +    }
>> +}
>> +
>>   /*
>>    * Toggle between address translation and passthrough modes by enabling the
>>    * corresponding memory regions.


