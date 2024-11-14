Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593C5D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBerD-0005J7-6G; Thu, 14 Nov 2024 13:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBerA-0005I3-Ci
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:46:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBer7-0005r4-NM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:46:16 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED5wcn002334;
 Thu, 14 Nov 2024 18:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=hjxiU711LXVt9wAb8CzpZbn5tUcX6UcDZ/pKnmbm6Fc=; b=
 XlaUvav9lLojI0O6svBjIbJtoxKuA7i8ifAfZwS95LfLX+UtJOKx/rNClZoVDXf9
 MGPBRi+7xmCi0XXpT6iCgFrlFFjLTjcQUolQdmOIQ4rhpcbtbHLsNoRak4RnqQfB
 n/dS72z0bTTvPwd8uDvKl/3sUH9v8ltMLmPT++AyNl4Xq3MnJjufG0/8FUFa5yhh
 1Ga8+wTV0470rCHItBXI24kNS7ktCPe4qhJuIk8ZKxwlBIsTNYVsEWawn45zMZUr
 HvUsKYyFwu4JMW3igWNMHnEFIr07yTsSdTjhXxImtDSG1TEdQshgwuoDqiWEqlmK
 nCN1mUzmMtrL4aOpzv02EA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5htbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:46:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AEIF4Ph005808; Thu, 14 Nov 2024 18:46:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42sx6bktnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nuy+4K3IrMan3bp4jbGrV2Ae/MCewTbVWX6eWz8lTu28oRWbQC+8PTx3s2Q0htV6b02rTWOyHy5Z67KgMfeo5lDjvp2bMSSvsdNKfPVRtkM5rOdeY7rY2a3eOdtPbb1WqSvMh98gyBeEJi5EWgLfc9OkpLlskraXQE+3/RrsFmzbL5C7/IZndaQ84JBGkKAOUp+H/9uSunh1QCJhCLvRWWXkCqE92+q1nIiG6qfu6Huo4+4eYeWRNqVIVZkJdF3ZBwrnJa9U0R3LLBuxzBqt1AojgpuBNT0/4FyPGUNR0BydeuC4MV8vZxHyZ7IlhQ6LW++URFtEt/SodxGxo76OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjxiU711LXVt9wAb8CzpZbn5tUcX6UcDZ/pKnmbm6Fc=;
 b=m1Ak4AUvgyDE+t+6Kzlpbdle+X22T1rpDR4Df+gynDQBcIReG2eyCilVDeCjAdbqDaDvEr7QfLP2XS2rT3Rejwi9cOZU0t4c+fy1zZoQkpHmyKu9wpvw2dio+JC9nlSBlXoscINbn7F7Z6AJaNbLJM2uDijO3U8lBI+GF/qYXBEKOEJ2S1WUP4gQ7QsA8Oo/xJJXpw+rDQhRVFJEX0EnYN/pfTWRLEg6RNzgMRxhQLcKhcCtdPd4N726H8LI4Sxit/SKEUptKESYbI02ZSKriKIGxUW0VYoQ80qVr5K1AgeygD0WJeBdAGCmdZT0UKVB1fppht0Fhw6JnBb0Cwza2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjxiU711LXVt9wAb8CzpZbn5tUcX6UcDZ/pKnmbm6Fc=;
 b=Oj8NMqt1Hnt5PLXth6mJ3kCf8xpvaqDXeTLYaz0D4LSDi8RAp4wOf224D4idfs3eFX1OyBZ4O6UWZBDwOQqOX2vqJe/H092ChTwqwzb4j5ozKXqtCmzr7Vyi0gQB4ZImSUdM6Ps9La9LxZ64a+tSiGoPAD89ZIw/Ru8rdjQYMcU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7780.namprd10.prod.outlook.com (2603:10b6:610:1b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:46:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:46:00 +0000
Message-ID: <d7867951-36d1-4e91-8349-f085a7655086@oracle.com>
Date: Thu, 14 Nov 2024 13:45:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/16] tests/qtest: defer connection
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
 <87v7wqhics.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87v7wqhics.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:180::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8445ff56-ed02-420f-adb7-08dd04dc954b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3JrNTZrTTc3Vm5McnViQklzOTJ6TGMzRUdlVk0wZXlUQi9GbDlZSSsraUsy?=
 =?utf-8?B?UVR1dnJDMm9MeUNFNGV1djJlVmxiQXlpWldNU01uQ2lWNkdDNDlxaDlWOEN4?=
 =?utf-8?B?R21SV0xDVEEwdDJMaldUVHJFck8xUC9mRi9aSzZRdnF4d1BNVUZTWnNGZUMv?=
 =?utf-8?B?QmVjb0xQb3NXejdyWStudVhSYitFalNQWDA2UWpzZml4S3hCNUVBVjBoWUs0?=
 =?utf-8?B?azNOcWRaNEhDTFNzTnMyVm9FMmc3UXpVOEZkZ0JIeXArNktScWRDSjdnRDBv?=
 =?utf-8?B?ZEp1dXNYTG5BU3g2dW9SK3VDblRlZm9tV2QxenpWZURWUG5FV3AwUTFxVFBN?=
 =?utf-8?B?RFRDYVZ0dzJySG00UVJKcWpoOG11M2xWWTVKSjVaU0lsY3pDOHRKM3FORHFk?=
 =?utf-8?B?U2Vobm4wbnhpVEM0K21RTlBKNC9EUzNYWFFMTVIrNUUxZUl2NDc1YlpWaUZB?=
 =?utf-8?B?OWZYM0NIMEJRUnRkakwzWnZsYnczYlVLc0R6Q0lkMy9jczZxZjl1eUJWUlFq?=
 =?utf-8?B?MTd0RFZZREVER2xhUVk4SDFyNlFhWXVMUVhVb3d5dHRqRm5rV1RhV3B2cmxy?=
 =?utf-8?B?cUFCVVY2VjdEV2xETzNFUXRzVkN6cEFsZXJWdHE2LzljbEJKL0xBVXJ4Zno3?=
 =?utf-8?B?elBhdGxkZWNhM0gwU2NsZ3pqdDE3SG5TNUh3dno2QWJzeG5BT3JpRmdNVnZK?=
 =?utf-8?B?aTkrQitiM09zTW00ZlNUUTFXQ3ZsL2N3RzQxSVcvbWJuV0s2ZzRjL2lNRnVG?=
 =?utf-8?B?eXI4b1pFYk1zclY5WHdrOWNnOFZaZVd6S2xrbVpYNEdXbTVIN0M3dkxNKzF1?=
 =?utf-8?B?MzQ3SG1KRzJzWGZtQ2dmMmlNUGhmVFcwalF5K1NTQUdjdk15Sk5oanllLzA5?=
 =?utf-8?B?eUZra3E0NnhIS3h5NTFPUWl6Wm9yYmFRNm1wbEdUWGtYam9YVFNEczZtWVV6?=
 =?utf-8?B?azhScDdpcEphNk4yOXFNdzBGcGw2NHBnOXQ0RDdyM1ZwNDJGU0RXTkd0YlBl?=
 =?utf-8?B?MWN2d2xNd3RWNGpZbGYxeVF2N004T2Y4ZUpTMEdlOUNoQmxUNmJTeEdTNnEv?=
 =?utf-8?B?SzQ4M1BCU2YrYXZQZmtZcDduZzlxSFNBdGNhaWd6UllLQlB0TndOZmhyeTVZ?=
 =?utf-8?B?RWd1eFJ6cU80dUZkaUwvWi94ZUNZWXBNTEdmanhkZ3ZmaE5FRWEzbW5TQXRL?=
 =?utf-8?B?K0ltRGNNM2c1eEZ3cmxYOVhTMkdiRy9NTkttbmZCMXR4SFZaQW5wWjlkdkV2?=
 =?utf-8?B?TkFmM2NEeW8wdzRBemhrTTdmNy9ibSttN2RCcUhvMk9LS25tdkZRMWxwL1hi?=
 =?utf-8?B?RUNPYkpuUHhubkUra25US1ZqUTNQS2FuVmZyOGJQN2U0UXc2dEZGZ01QOU5q?=
 =?utf-8?B?TUFzd2hOdHA2YUw1Q3E2SmpMcENncTdkSk1tclkrcy9vVWxBUkNqMHQ1R0dJ?=
 =?utf-8?B?UldRWHh6eHFOSWtTL1ZnQzBKdFNRb3FtWGg5SHlwbThValNpRTNXSjFRN1hn?=
 =?utf-8?B?V0JQemgvOHpNYWxsR2QzcTA3dXFpWXpadFI1NStsME9wMG53L1k1ZnJxd2tq?=
 =?utf-8?B?VDVBY1NqRkpmRTNGK1BtZWRXUUg0QWI4dC9neHIyeDNnVEpna3BzdDBhejA5?=
 =?utf-8?B?bCtNOVpGRXNyU3JlQm9PejZHL0VCOC9LWVRITHJiaXAzakIzbythd2U2NElL?=
 =?utf-8?B?SjQxT2RTMVQyM25uay9sVFRkWHU4R0tOOEdkN0pmalg5dEwzdzN2MndZQVo0?=
 =?utf-8?Q?Ld/9wsTVI2smT5SWh/yN+LeikClQ5AdS8MN7YPZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFplWFFxZGwzYVVHc0dWLzhwbkhxdVNqN0R5SGRaeGhCMWNoTnl4QW1ObXRL?=
 =?utf-8?B?M2RpNldKenZhWmpQRDRvanNWeEZBQS9weldjSldOR0FXOTdQSjJrSVFseEh5?=
 =?utf-8?B?YmlFZVhXTVFGQlh0bzk3NXBzTWtIVDFEL01yUENWbmpaUjljMHVvcjZSMzVt?=
 =?utf-8?B?ekNBL3pYVThFaW85cVRBRVBWSFd2NmZVKzRxN1Z2eWF6ajJjVnVnSXRSN2dO?=
 =?utf-8?B?VG4vc1Fjck1EdUNGRFM2amJPWkRFbWN2Tnhrb3JXNXZzMVN6a3JtNGo5OGwv?=
 =?utf-8?B?L043RUJZVXEwZWIvOUhlUmx3N2tHMDZ4a2thQUxZUzBOejZMUG1GWWFUWUZ6?=
 =?utf-8?B?bG5wU3U1b0Uzb2VXcyt2MTB6ZVd4WnpZYkxRUlNYQWNkL3J0TzdqSkFHSVhW?=
 =?utf-8?B?dTBhN3J3M09TdlpPNG9nMnBiMktPWkMwcmJWZVd1YUFRLzA1Z1E2Mnc3YzVM?=
 =?utf-8?B?OWw0TzR3RUZTblI4Y3dwUmNNdG1XOHdURTFEeG5CVnptZ1ZwcXQveGdOYlJw?=
 =?utf-8?B?Ym1jRTVPVm9ZRzByMnlzMHFneC9RdHpoTWVlbHNMaVRaMWxFLzFhTHlBMy94?=
 =?utf-8?B?ajhVR25QZEh4eWY4SHBucFQ3cVIvZHVoYWhodUp4U3Z0SEQyaXdkNkJtUk9T?=
 =?utf-8?B?VWFFaFdZdnRQdDdQODQxdWVpT052R2dPaEJlMjRHSlYvdG9qRzA4NE4yelRY?=
 =?utf-8?B?QUxmZWpEUys5cktRRHRxQXdiV0llTjZUYXJXZlhrUWZ2K0tsOVRJL2l6Mzla?=
 =?utf-8?B?NFFxMDN1bW9NVkllMHg2L3dpb3Y0L0FNU1E5c1VXVDdCSnNEWFNRS25BaWpy?=
 =?utf-8?B?ZGdTWjVKNjVNejVjVSt1UnVLTm5yZ21GdDlNRWQwSytkYU9KVW1GK1hLbE5y?=
 =?utf-8?B?R0srdXg3YjEvajFsM0FOQUhaVWlwNE1IRWlTcXd2WUNZQ2dEMjFhekRxczBh?=
 =?utf-8?B?S0UzRGFXWmN6Y0FZQmU0bDhneDdUNlpHcTllMnZwUGZxQ2J4NytVNk4xVC8r?=
 =?utf-8?B?UG5DYWc1R2NMMWRZQmpDWGxEaFhZTkhXaXZaeDJHZVlaV1BxY1kzV0FVakg0?=
 =?utf-8?B?Zi84QWZ5QXZhdGRJL1Vwb2ZoVVpGV002dWZGRmdKcHZZdFFMNEVlT21mQXdI?=
 =?utf-8?B?V0NrUTMxRDVZVHBoVWpLVUwzdnNmdTYvMXdPRUQwT1R1NWl6ZkFCVTR2dzBj?=
 =?utf-8?B?QTdGNkhpNkpSSmhZbVVPYTZuRHQ4bmdpOS9vN3pzQkFPSFhLM0MrR0Y4Qm5h?=
 =?utf-8?B?aUFJZk9IS0MwN2U0Q1hWalBFaW85eGptK0dadk8wRFRXK0xqSzRFNVlCOWRF?=
 =?utf-8?B?OXNYMHFyQ2UwU1VQRWQ4WkNQdlhGOWQ2a0ZSekhCdVJUQkJHcGxCUURUcnJr?=
 =?utf-8?B?YnMrTkw1bVF4NmJDSjViU01qS1U2L2JIQno2a0I4OVk3SUNSOWt5UXFCK3Bl?=
 =?utf-8?B?cEZPS1FtcGZPNy9aVEFzN01aU0ZqNXpYektzeUxmYVNNeVAyazBJQnErK2hK?=
 =?utf-8?B?OFdodlE2dzA3SDJ0OWxZcU02NjRGMnpmT251ZnB0SE9BRXVRT2hiaEFSYVlx?=
 =?utf-8?B?dGEwM2pJK1o2UEJ5QmVjMnB6elkwaXgxUFFOajYvM0pEcW5sYUFtV3VRaEM1?=
 =?utf-8?B?Y2pVdk5XUXVzb0ZyVlhWOFJoaVpjb2pzUzFESUdVZEFYcDEwMmRkTjFubzgw?=
 =?utf-8?B?TkRjbCtaa2RHS2RGdHRsVkNla1hWbkhTdGoyV3h6bFdzNmhDMTFhTi9RcjRm?=
 =?utf-8?B?ZXdId0tsMnJNWmZwNWpXTUh6K2pBRzhldVN6c2FNc2dlR3FRQWxGSkFzeVRu?=
 =?utf-8?B?NEdUbFoxUmh1OUlXbnFZbnkrcUc0K1lRdFkydmJDOFRQTnczVUtkUlZVQ3Fa?=
 =?utf-8?B?dzUxdWtEc01oZEpJbHhtVWtLa0ZzT3pCdzdlRVNLZm9lOEs4dUZGcHQ1VW90?=
 =?utf-8?B?YWVvTTJXNmRQVm91SzNRUXQwTDdzLzg3RVNualVlUFZYcml0bjh0NVRzdWtC?=
 =?utf-8?B?K1RZdVViUFJFeStvOFNaTG9UQjZGZXlUUU9mR1lZRUQ5cWlKeGtJdHo4dnZj?=
 =?utf-8?B?UjVjMkx5UXIwbTRra0N3UG9mZ2VTc2pRZk5rdi9RWTBQRU4raGZMM2VSSTg4?=
 =?utf-8?B?UThIc2g0dmRHT3ovdFMzY1FlRDZFZnVwaGIzck9MNlZoNktUVVpHTFJVeUdk?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j8vKE1XvCU9Ps9xQxbYsNMuq5tro7HjeQutSKLI8kAxAdVUnrjCBAOdlc/pOVHqDlCU/5ON2RiKn9LqAnyhfWQBvPg55kCkWVF9PxGEQHLQZyGpypLl9tduntfJ/OBPfOM2WvKxA/XVDqPBYpryqxCEkTwPLjEAv4W6wUIAdYQmZj+LhoU9y3CYAp14WNWm3bRwQAgC2u1Zpxh/q+zBQf+JjRnEo0luGh53Nmb7mhplAjukBsw6G/r1ZvR/J03Qn+F1SDLGv6HnJ8zHn467NKjR1yR1tqbioVGFkV/m1NaGbdMzJpcISb8nQ/KdXA5BUfYUlqd2ruI+Nr6TNi39alcfvCiHucOKyTtFNhUZsWYMkKgdG9ZLIzuyNzpWJoefv4QOoxauSKqv3XEh2/Ppe6pijmrHlBogbEPlxhf4JEgPBPcjMw9oA5jEgkiJXH6BRw0gR9/yjNvdxecxWXW89uoETkaq3xgzWFM17sQYRlDLC5GFPTrVtTl3JMInMxqiL6dt2kVir6U4nyuQ/IdLGYAKa365/mh3kycFqx8lVq8HJ7j1Q2cmSdBNtu1bys11/9a1v2dO8NJRGPgplGw5+0qa0zsioxKwz9cRq5Rhsha0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8445ff56-ed02-420f-adb7-08dd04dc954b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:46:00.3228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAHdd5AFt5E8e7PFgQFG3h9CwjmAY0KPJWbAHgwxTk0cRihKyiYtW7TouOQJq+Amax4u/kohbBXmyuXCp5mPRGuXG2i+tq+5ANP5UesyVIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140147
X-Proofpoint-ORIG-GUID: lUSm8a5xkMsrHJtf-i0Kny_cn6-m6MWw
X-Proofpoint-GUID: lUSm8a5xkMsrHJtf-i0Kny_cn6-m6MWw
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

On 11/13/2024 5:36 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add an option to defer making the connecting to the monitor and qtest
>> sockets when calling qtest_init_with_env.  The client makes the connection
>> later by calling qtest_connect_deferred and qtest_qmp_handshake.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/libqtest.c       | 69 +++++++++++++++++++++++++++++---------------
>>   tests/qtest/libqtest.h       | 19 +++++++++++-
>>   tests/qtest/migration-test.c |  4 +--
>>   3 files changed, 65 insertions(+), 27 deletions(-)
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 9d07de1..95408fb 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -75,6 +75,8 @@ struct QTestState
>>   {
>>       int fd;
>>       int qmp_fd;
>> +    int sock;
>> +    int qmpsock;
>>       pid_t qemu_pid;  /* our child QEMU process */
>>       int wstatus;
>>   #ifdef _WIN32
>> @@ -443,7 +445,8 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
>>   }
>>   
>>   static QTestState *qtest_init_internal(const char *qemu_bin,
>> -                                       const char *extra_args)
>> +                                       const char *extra_args,
>> +                                       bool defer_connect)
>>   {
>>       QTestState *s;
>>       int sock, qmpsock, i;
>> @@ -485,22 +488,17 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>>       qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
>>       qtest_client_set_tx_handler(s, qtest_client_socket_send);
>>   
>> -    s->fd = socket_accept(sock);
>> -    if (s->fd >= 0) {
>> -        s->qmp_fd = socket_accept(qmpsock);
>> -    }
>> -    unlink(socket_path);
>> -    unlink(qmp_socket_path);
>> -    g_free(socket_path);
>> -    g_free(qmp_socket_path);
>> -
>> -    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>> -
>>       s->rx = g_string_new("");
>>       for (i = 0; i < MAX_IRQ; i++) {
>>           s->irq_level[i] = false;
>>       }
>>   
>> +    s->sock = sock;
>> +    s->qmpsock = qmpsock;
>> +    if (!defer_connect) {
>> +        qtest_connect_deferred(s);
>> +    }
> 
> It might be cleaner to just leave qtest_connect_deferred() to the
> callers and not plumb defer_connect through.

I considered that, but IMO we should not force all callers to complete
a deferred connection when only one caller needs it.

- Steve

>> +
>>       /*
>>        * Stopping QEMU for debugging is not supported on Windows.
>>        *
>> @@ -515,34 +513,57 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>>       }
>>   #endif
>>   
>> +   return s;
>> +}
>> +
>> +void qtest_connect_deferred(QTestState *s)
>> +{
>> +    g_autofree gchar *socket_path = NULL;
>> +    g_autofree gchar *qmp_socket_path = NULL;
>> +
>> +    socket_path = g_strdup_printf("%s/qtest-%d.sock",
>> +                                  g_get_tmp_dir(), getpid());
>> +    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
>> +                                      g_get_tmp_dir(), getpid());
>> +
>> +    s->fd = socket_accept(s->sock);
>> +    if (s->fd >= 0) {
>> +        s->qmp_fd = socket_accept(s->qmpsock);
>> +    }
>> +    unlink(socket_path);
>> +    unlink(qmp_socket_path);
>> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>>       /* ask endianness of the target */
>> -
>>       s->big_endian = qtest_query_target_endianness(s);
>> -
>> -   return s;
>>   }
>>   
>>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>>   {
>> -    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
>> +    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, false);
>>   }
>>   
>> -QTestState *qtest_init_with_env(const char *var, const char *extra_args)
>> +void qtest_qmp_handshake(QTestState *s)
>>   {
>> -    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
>> -    QDict *greeting;
>> -
>>       /* Read the QMP greeting and then do the handshake */
>> -    greeting = qtest_qmp_receive(s);
>> +    QDict *greeting = qtest_qmp_receive(s);
>>       qobject_unref(greeting);
>>       qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
>> +}
>>   
>> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
>> +                                bool defer_connect)
>> +{
>> +    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
>> +                                        defer_connect);
>> +    if (!defer_connect) {
>> +        qtest_qmp_handshake(s);
>> +    }
>>       return s;
>>   }
>>   
>>   QTestState *qtest_init(const char *extra_args)
>>   {
>> -    return qtest_init_with_env(NULL, extra_args);
>> +    return qtest_init_with_env(NULL, extra_args, false);
>>   }
>>   
>>   QTestState *qtest_vinitf(const char *fmt, va_list ap)
>> @@ -1523,7 +1544,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
>>   
>>       silence_spawn_log = !g_test_verbose();
>>   
>> -    qts = qtest_init_with_env(qemu_var, "-machine none");
>> +    qts = qtest_init_with_env(qemu_var, "-machine none", false);
>>       response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>>       g_assert(response);
>>       list = qdict_get_qlist(response, "return");
>> @@ -1578,7 +1599,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
>>   
>>       silence_spawn_log = !g_test_verbose();
>>   
>> -    qts = qtest_init_with_env(NULL, "-machine none");
>> +    qts = qtest_init_with_env(NULL, "-machine none", false);
>>       response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
>>       g_assert(response);
>>       list = qdict_get_qlist(response, "return");
>> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
>> index beb96b1..db76f2c 100644
>> --- a/tests/qtest/libqtest.h
>> +++ b/tests/qtest/libqtest.h
>> @@ -60,13 +60,15 @@ QTestState *qtest_init(const char *extra_args);
>>    * @var: Environment variable from where to take the QEMU binary
>>    * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
>>    * arguments are subject to word splitting and shell evaluation.
>> + * @defer_connect: do not connect to qemu monitor and qtest socket.
>>    *
>>    * Like qtest_init(), but use a different environment variable for the
>>    * QEMU binary.
>>    *
>>    * Returns: #QTestState instance.
>>    */
>> -QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>> +QTestState *qtest_init_with_env(const char *var, const char *extra_args,
>> +                                bool defer_connect);
>>   
>>   /**
>>    * qtest_init_without_qmp_handshake:
>> @@ -78,6 +80,21 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
>>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>>   
>>   /**
>> + * qtest_connect_deferred:
>> + * @s: #QTestState instance to connect
>> + * Connect to qemu monitor and qtest socket, after deferring them in
>> + * qtest_init_with_env.  Does not handshake with the monitor.
>> + */
>> +void qtest_connect_deferred(QTestState *s);
>> +
>> +/**
>> + * qtest_qmp_handshake:
>> + * @s: #QTestState instance to operate on.
>> + * Perform handshake after connecting to qemu monitor.
>> + */
>> +void qtest_qmp_handshake(QTestState *s);
>> +
>> +/**
>>    * qtest_init_with_serial:
>>    * @extra_args: other arguments to pass to QEMU.  CAUTION: these
>>    * arguments are subject to word splitting and shell evaluation.
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index a008316..d359b10 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -844,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                    args->opts_source ? args->opts_source : "",
>>                                    ignore_stderr);
>>       if (!args->only_target) {
>> -        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
>> +        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source, false);
>>           qtest_qmp_set_event_callback(*from,
>>                                        migrate_watch_for_events,
>>                                        &src_state);
>> @@ -865,7 +865,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                    shmem_opts ? shmem_opts : "",
>>                                    args->opts_target ? args->opts_target : "",
>>                                    ignore_stderr);
>> -    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
>> +    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, false);
>>       qtest_qmp_set_event_callback(*to,
>>                                    migrate_watch_for_events,
>>                                    &dst_state);


