Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C16C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSL4-0007Pr-8d; Tue, 03 Jun 2025 10:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSKw-0007P2-BA
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:09:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSKt-00065j-2g
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:09:53 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AEm5C009170;
 Tue, 3 Jun 2025 14:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=d7zwLUenw/LRUr6T98RucgO8vpbR9PHXg7g5/wcZrjo=; b=
 Lnu8O1sd4NtTaAQMuYwFk+Thzr2dd0OhB5jc/irkoVk96d2vxsMNXpT+J6PkL2HL
 wpvvXNZT+k7FrRjzR9r9HLTMGdu09I/2fts2KtKbmPQ18vQKq2TxmDe3rScepwxT
 erb8a14yGNc7en/UxInwwX4YtiG5AMG9aEcQgtMgPteRTh+J3HMMhAIcOdYKCwi6
 BwiQUuepDtodhshRRF3umx6Tn4daiNZ8ntMbvQtKviuQHY4f45pL9QH9ZKIxSCkE
 7PIWKF1Ooj0Lv31t+lkRoKXGqPZIeOzQufwVGiQ3r5YGQfSxROc0cMnVQZUm/wEI
 r5GbGJ/ymtNkzi+5Gs5dPw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gaha0s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:09:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553DdCCS016123; Tue, 3 Jun 2025 14:09:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr79d2uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO4XfhV+WA/dwpx0QJ8aO82SbWgMfxbHgi5Um1brcTh9HfBq08VahY4TdDwv60B09yblTRzNBZs3Rq1pfAa2mCdWlD1vOb0imNW90/Q0SzQ0hmQpqNwg2Lnt2UHV1wtIvt/v0Wjl9GYKPONA4L4txJJgZ65pPi4FWz7asC9dTM1Xi1D2wnOnbSuYASK1+/KHIJxhHXjk01n21RQjxuUS20cC7MQi6ZErtNhQMRTHPIHEDRC9WlA8MmkW2iUU5xb+lYc9GQ7DIidq4nKagQY5b3FJxsDyK7+tNSAeRt0Msl3dcqm6gy9wPIe1yw8Ohg6H7nFaZlfiouEMVrvyhRcnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7zwLUenw/LRUr6T98RucgO8vpbR9PHXg7g5/wcZrjo=;
 b=ashPhJ6ucI7n42bM2ask9qP64fn5luuHTC+nka6CYuHwA6NmVSFKKYYM+y25SI/vLqQ6cXxHWzumJJpG5GmjknnYvPORMnY9LsUgrYjcFGZaX71Oo36X/nKjV3YB5PW8o1f05mpn2RXeNXnJ+S5y3Hu+ycIESX3N5YkjsW4hMZLnfkTAW86TWF3jZFK1XdWpfGyNM2yNKk1WnhG4+MNwqs0At/ezev51soiQ8jNzhWqTdTLSlCxBOxfiVcIw2VU3quDJnILlR+RQrNHirMS6mGDGolg6l0dMSCnBFyUERDnD+kGBKLnpuyRQgywypMXV2hGnqjlv6vABeLBZubgAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7zwLUenw/LRUr6T98RucgO8vpbR9PHXg7g5/wcZrjo=;
 b=s83X5EaDywHE4nRfs2OyZsZgNBBCxJ8Pcq8RyH2i6OPv5NiQ7msau8y0IdvwJtXHCCmxGLRusGAhgXx8U7ZKTVAe37lSUU7mNNlsp846qYx+Y8QrVtmgg/vGG25i+VRc/AuTMRh0OjkAjJvfap1rAPd2g8qLMfIBcSJMPs2+nR0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 14:09:43 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Tue, 3 Jun 2025
 14:09:43 +0000
Message-ID: <71730241-a6f4-47f5-b7d6-964412b4d0bd@oracle.com>
Date: Tue, 3 Jun 2025 10:09:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/43] vfio/container: register container for cpr
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-10-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136AF510081213140C10899926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136AF510081213140C10899926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:208:530::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bd9c7d-47ab-46df-2af7-08dda2a84983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VER3TWp2MWZSdUxpQnVaMW9ZT3RVaVpqOHhNeGFqTnJzMWs0aXROWEJnUEtx?=
 =?utf-8?B?Mk51RHArQWp6RkxRZ2txVTNFb1VxdFBFV25OZ040MDFkM2dKbUFnTWlKN1E1?=
 =?utf-8?B?SHBpN3pYcnljeEdhdVdaZk9EN3NPVURqeWJYU29ZYms1cFpZYlY3bnRkaERz?=
 =?utf-8?B?U3M1eDJaNUY0b2JSdTVueWVYSlFEL0NtangrTWJGRS9KUDRvSEU5azRudmFX?=
 =?utf-8?B?YlRPS2lLNGxOd3Mwei9Ob0c5M1BwMlU5T2I2THFtTDRSaW1WU0h0Q1hlR1pB?=
 =?utf-8?B?aGxVWTNMNmlTM2xxZngzSHNNL3N6VlNzTGpGcDQrNWhQOE01SkxESndvekdE?=
 =?utf-8?B?dEpLMkZrQk5JaDE5L0F2TS9ZdjNhNU1PeUJCVzdOdW5qTTlVZmpSYWIwdENx?=
 =?utf-8?B?d1gvL3A2OFdTbzFtRDByZ3NyOXZUK1lTUVk5eUdYUGZYUUhDVnBnTmpoU3VZ?=
 =?utf-8?B?MWplSnhXQVYrN3dKOWlHdnlwajZhK3ZheVlQa0txWlVvY3k4THJNNEpUVmtS?=
 =?utf-8?B?SmVvUXBDTW1zY1ZzOGt2RkZYQi9QdWFjQk1HbFhwRnJLbi9ZazRKUlZuU0Ja?=
 =?utf-8?B?L3JkYVdPRVkySXAvVWdvdmV4ZkVQRVpyeEU0c0JCSGpKa1M5TEdIbkRnQkNv?=
 =?utf-8?B?YnVKcG9MU2x3OCtEdWxUV2kwVGQxWVRaUm54SnoraHhENmJ1YlFQOXBENFV5?=
 =?utf-8?B?c3Qxb1Z5RklWcXQwcll4UlhqalI2NVliS0I5L0h2SHd6RERUSUswNjBaUTV2?=
 =?utf-8?B?OWg5TitzQzY4STl5QU0wa3FtWktsK3d1bFY2ZUR6YytsQkx1U3pPRmlGKzFC?=
 =?utf-8?B?TnI0cmpzN2JndWlYNHY3N0VWKzdBVDIySkNISEFkY1ZJbStDa2NwdVZ2S1Uw?=
 =?utf-8?B?bnlkS054QTRuWnovU1ZqOXZtbTdlSnVxRDdqUG5ScnlDcFBjM2tsTkRyMmNB?=
 =?utf-8?B?N0xVYmpzY2ZvWUFhMHR5alhaVGQ1ZHMxYzJrSWdvbnAxUW1Dd1FzNTdwOHAx?=
 =?utf-8?B?dGRrWG9YbndDYmJtUkgxUlFrNjFOZUJBWko2RENqdDZlZk45UUxKSG9DR1Jq?=
 =?utf-8?B?cnhqYmtZcTQ4MDU5UHhXVVFCSVVmSi9DSHZGWlNiTGVISmlTcks0bDU2bGlI?=
 =?utf-8?B?RUdlaTJuRDNLREZmSWdYQnNYUEg1RG4wS3ZtNWlFZnNHUEpIc0JLY2VQdStw?=
 =?utf-8?B?K3NONTZHbU1YY29TY0o4OGlEd3NRV1RRdFdpL3JaMEsxbERKYXk4ZmhXU0Np?=
 =?utf-8?B?RGVucXprdHBmOU1uZUZzM1d0OHBpMWZ1VWlLZldYbDBjeVhqdW5WdzlBZHYr?=
 =?utf-8?B?anE4cVR5dkxBVFozYXVocE9qRU80blV0eGFrY3dYRElMYzlaT1FiWmx4S3hR?=
 =?utf-8?B?bDJqY2hmei83RlhkMHg3eUUwMS85RDd6UUZJNDNjVmUvRjNQZjg1cmxtSjdn?=
 =?utf-8?B?U1BEUEQybTUxNWZZMHIvWjNLOERQa0JGeUI2cVd4Y1M3RXJ4YVVNbGhvaHJ4?=
 =?utf-8?B?cHg4cDdmcGtMV2lJdEkwaXQ5MVFrSmNndi84WGl0anJhRDJKMVZ6bUJ4TWNh?=
 =?utf-8?B?U0l6c28rcnM2UCs5ZzUwalhVSUVKOWNIc3hMMWdsMmJ2dnhnWFI0QjBzTGdl?=
 =?utf-8?B?WHBWaysyQmd5NmZLOXdObjRaazdNbUFmSzlBTk1VVHBPWklYOHRlRkFzeVdU?=
 =?utf-8?B?WmovRFR3MnhuSDBrRy9yanlsS0U2YmJFM2tvQ3h2Sk5Zb1kzMFdGVCtPbktn?=
 =?utf-8?B?RW9GQ0ViNlF4Nml0N2JrUk9TOTZNRXEyUTVOWThoWVloMytuV3RmdTNWTjNS?=
 =?utf-8?B?K1owMGZQcmlxSlRSQnFxanZIR1J4VE5kcVFoYjhpZ2l5R3U2U2VqRmNZSXpZ?=
 =?utf-8?B?VnNqc2k1d1VkUnpFNTAxNWQ4d0dCSWFKN1doYi9SR0sxekxZalFaUFJXRTdj?=
 =?utf-8?Q?RXPRaDbskI0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1U2L2QwNnNRNC9JcitmaC84T05hZ1BFUmRnbURCc0g4d2F4dndScXZENkov?=
 =?utf-8?B?VzZPQmw1T014ZEZkMklvMERQV1NId2FUd2o2dlFza2FXd24xU3VNNU5kc1RK?=
 =?utf-8?B?cEc5dHRLVEtUTXNJQS9SWmw2WDJPY1RVMU5CSnVJYzRwTWRZVHBYV3dYVHV5?=
 =?utf-8?B?YUtVZTFpdXhJOWlqd0MzY1V5RGI5dzFvcUE4bTBqOThEc3dtQlBaRmZpemV5?=
 =?utf-8?B?UTBxYUg5SEM1YysxdG9QTmY4UVVFcVBuY3Q1OW1jVHNsc1o1ZEJuY3JjeU9o?=
 =?utf-8?B?RkhCZTc2Yk5JMUExcjgyeDB4U3F5NU1WcTJVajFka0hNZHZsWjdJSlFhaUpv?=
 =?utf-8?B?aDFVQW13Yk0yWnBsMW5hU216TGtqeWNDNW5yYmM3Vi8ydXpCSThwaWprcjdt?=
 =?utf-8?B?OVlmVDI4Y1lNUzd1TTNaOWViZ2M1NFZURG83S09LSGxzMHVPcmZpMDZjQW9I?=
 =?utf-8?B?WnhMSEU2a2JydW9FMitnbUhEM3p6azJabGMxU1p5dFpXT1NIVklqeE9zclRZ?=
 =?utf-8?B?M0xMMkJEWERGWEVWTExtSnRIaU81THpFSDRDTVRoSFpOWUVZWGNtcXl6YllS?=
 =?utf-8?B?T05UN09EeVV0YVFHR05GekNxNzB4elR6WkF5bXAydmJrUk1EbnZIenFwcSto?=
 =?utf-8?B?M08yTGN4WGUwUjMzREZmK3JkQ3YvOWdnc0hJQUdTQSs3c0NoSWZQOURHTUlx?=
 =?utf-8?B?ZVJtckczSlIyNTJtK0lmZUxGaFBQVHVQd1pWNFc2WFVCNXJ4RkhIcHBUSXR5?=
 =?utf-8?B?TWpkK0F6WG9wNTM0MGdCRE1ZSXRMRWs1ZXVqRHlnQitJRFRjQmJld01XVjJC?=
 =?utf-8?B?TzdOM2UySXd6ekd3STN4NTI5ZzBNMzFIUUptUURaK2RSSVJieTc3dGphT1l6?=
 =?utf-8?B?UDJzV21iMTdLbklNcmlMRTlwK2pVUnZxdW9rZTFEUllXdllKa0dwRTVLUHhG?=
 =?utf-8?B?TU5pV25EY1F0NFJCUjV1NFpjeHlxUmM3YmxKam1FKytMenpXOEhIdlIxZnIz?=
 =?utf-8?B?MllUdWJTelREblVwaTdlK1gxbnU3K3hOWkpjYUcvRjRyUVhNaGZvQjNFTWlo?=
 =?utf-8?B?RDdnVDRVNkxlNGlqT2p3N0NuWFE4TldQVG5jcmFSZE1NZ1JweGtBNHU5TFlo?=
 =?utf-8?B?UzBJd0hpUmU5UUk4dmJYNy9MSTRJUStXUTZ3RmtlSlpCL1AzNXlRWUdhczBK?=
 =?utf-8?B?ZUZVejFyNS84T0dqNjhtSHZWMy9udWxNYlZJNDZRaTlXcEthdmllSmJHVm5F?=
 =?utf-8?B?Q3loczByWjVxbUVxdWxQM2xob3pxSjZkRld2MFdJdHlDU1hSUmNjbWErdnRk?=
 =?utf-8?B?VDdEbUZjajhpRG1Ja0dLZGFmdVNQb0N5UHhTeWVYNW4wMFBJRXhOekVwUFIz?=
 =?utf-8?B?ZVd5U0ttaTVCVmViMDhWM3dTMHA3cXJjVTcvVnI1TkMzMUdLNjFqWFl4NUFP?=
 =?utf-8?B?M2FvSDJrdERtUmlGSDAxQkFmNnZNcWlvd1YzdGd4Z0xvZ2VUaFQrckZzRXh0?=
 =?utf-8?B?RE5kTzVFVHQ1a1I4K2dTTmF3Zys5R3lMTWxhcUxBa0pBenF1eW1ISTBvZ0kx?=
 =?utf-8?B?UzhXRmpXRjZ5aTFMeExPcVNwd3U0SjZ1eEdZMHlSK01zT3JhbzFQUS95Y0dE?=
 =?utf-8?B?TFp4bEFaSFk3RG1HYWpiMnYxVGoyWThONFJ6NVduc2NCc09CazZUOTEzaCtP?=
 =?utf-8?B?SzNYNDBjMjNGWXFTaWcyWjB6YXZUOGlwWWtrSTZoSlhUc1FqRlpoa20zSGtl?=
 =?utf-8?B?YlIwSkRKV3dFREY0WisxY1FoSXplQkM4bkM3Tng5OFF2RXNDQ1RRcDJxYUtk?=
 =?utf-8?B?Y09haFJuLzBWUk5JanBncWNWV0RqNkh5SXk1ZUZjV3EzRGJBa2NNNUZGWGQ2?=
 =?utf-8?B?b0pLcExObWVaUktiYUlrcjgreVhvUzRRMXh4Y01RY2hmSlZQNjlzSjNqeE9E?=
 =?utf-8?B?MFdsYU1TMlZpbDBtZ0J6Y0ROVEhlSVJ2NlNORmNSb3c5MVZGY1YzdDIrRTN5?=
 =?utf-8?B?TW41TEUybSs3V1I4ajlacXZZNE1BZ3JaZmZLS2huVVRvMmg5UUFjVExscjU2?=
 =?utf-8?B?Skg1Ym81NlNhVExwNkVHbjgxQ0psKzVlNXZzVGRyMitwMmw0S3F0b1QvSUd5?=
 =?utf-8?B?M1ZCYURPc1ZSUTdDZGhvTi9CODV5WUlRQjhBOXBYOHp3U3dZVzQrQjJaUWNH?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UCAHV5Jz2ldrTGcLI/IdAlaCam3gWcfq+G5cq9VQJrB6pch1O7v2fwbnzPabrIU4OWhmtpnYFKMVLTk39qiYPuXI3GMdoq22bpDdJvwVzx/M5uBzU0/YpnoJ4H8HVohkXmqXNnLIYS9v8HYl7TctS7RqHBPMzSCBTfRfizoKf/lviKuVABzmNIsQCyvbsFvJ5YgkPWVsFJanE0MfcWmrKrzJcgVlkkxsI/W43B+kP0oX3xnJuVqDIV2/wSx5FPIyJAWUuuHh6+xc0nCKA0HVQpZmj0IWm18ZslGH/FBl/Ioh3KlSMDe/TSmnyYB6yZMP42/KA5/e4Qa60eJdFzCil7uSZO3Ed74dqhuWqoE/iuI/L83A4sYi3TEMENIpp5hSLzLxcYbTRKSonXexTdiXkIOox3HwN0x5d3BdDSbW1rK4/msW8+YAU1vJGr674I8uPo9vmlVfyxTwgtgA9o5ku5LAZbfeCnYeP+eD+xwvxRrBA3rR2i5GdOeMK+Xlz+6jCG/yGYzcYLVtMIE4xK4chYW5JsiKjLn+i6b5TLWS3RgrvoGzC43B2ZwZgMjGcXmF7mcoKCDpl8PXB9BUf2cgE8pbJYhS+UtCNN/b+LirP7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd9c7d-47ab-46df-2af7-08dda2a84983
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:09:42.9992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijUbDTfMC/bsKoUyrvBv6z6bVLe+U2uC6yp/kFaX7eTDVTuCi46dL2cHAFW0MVIYqPXyIQnaJsWc/Yj55cLp+Zvyrm30oDyd4tC8sTJXgOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030122
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=683f022b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QY8zXKHRbRiZMTlCtHoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xtNLPctTzZdiv4KNxOzzZefn4XrJBjWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyMyBTYWx0ZWRfX5jSzwUsantuZ
 lMgDd0j+gSplMbYobi5qfay3fkrggNeof51GSAOdwnGbJ6kEl4enVzwpsu1U4EJJNV3WDct9VXs
 PHpGhX7Qtjv5d4qUAnYoB5dqVF/RoR5eAx4iT2G4pjIiQv41WJ5UrThPOF53/1i5WbiOVXXqwZ3
 hXFjqB9VvwKyDOF9wc8zaOOmCG5X6rgIBkYoF/X0iMbQhkR04oqGyC5N3CBpj3dMjQDhFHIq6tm
 I+TM1CgzTUuz8E/46GFs28C55l8TZKqvLykIQTSgJ9+meK8S+ZQ+rN8IRP1JlVWSiwLIf8K89/U
 k3Bs/hSSw5JjJomIY8bO9GS/PuWMX3MUY7R0LWh2e+h+RgqC/OyArIK+kWwwj9OsX7V5MBb+vDK
 GNJRs+iG4JaOfqWg5WFML//zODmz9GVOhqWpRV3dwUwSIWLv0LtjMYbGdyMUtLF5zGgiO7ds
X-Proofpoint-ORIG-GUID: xtNLPctTzZdiv4KNxOzzZefn4XrJBjWe
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/3/2025 7:57 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V4 09/43] vfio/container: register container for cpr
>>
>> Register a legacy container for cpr-transfer, replacing the generic CPR
>> register call with a more specific legacy container register call.  Add a
>> blocker if the kernel does not support VFIO_UPDATE_VADDR or
>> VFIO_UNMAP_ALL.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> include/hw/vfio/vfio-container.h |  2 ++
>> include/hw/vfio/vfio-cpr.h       | 15 +++++++++
>> hw/vfio/container.c              |  6 ++--
>> hw/vfio/cpr-legacy.c             | 69
>> ++++++++++++++++++++++++++++++++++++++++
>> hw/vfio/cpr.c                    |  5 ++-
>> hw/vfio/meson.build              |  1 +
>> 6 files changed, 92 insertions(+), 6 deletions(-)
>> create mode 100644 hw/vfio/cpr-legacy.c
>>
>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
>> index afc498d..21e5807 100644
>> --- a/include/hw/vfio/vfio-container.h
>> +++ b/include/hw/vfio/vfio-container.h
>> @@ -10,6 +10,7 @@
>> #define HW_VFIO_CONTAINER_H
>>
>> #include "hw/vfio/vfio-container-base.h"
>> +#include "hw/vfio/vfio-cpr.h"
> 
> Now that we have this change, may we remove #include of vfio-cpr.h in hw/vfio/container.c?
> Maybe this belong to patch8?

Yes, thanks.
Patch 8 should not add #include of vfio-cpr.h in hw/vfio/container.c

>> typedef struct VFIOContainer VFIOContainer;
>> typedef struct VFIODevice VFIODevice;
>> @@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>      unsigned iommu_type;
>>      QLIST_HEAD(, VFIOGroup) group_list;
>> +    VFIOContainerCPR cpr;
>> } VFIOContainer;
>>
>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 750ea5b..d4e0bd5 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -9,8 +9,23 @@
>> #ifndef HW_VFIO_VFIO_CPR_H
>> #define HW_VFIO_VFIO_CPR_H
>>
>> +#include "migration/misc.h"
>> +
>> +struct VFIOContainer;
>> struct VFIOContainerBase;
>>
>> +typedef struct VFIOContainerCPR {
>> +    Error *blocker;
>> +} VFIOContainerCPR;
>> +
>> +
>> +bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>> +                                        Error **errp);
>> +void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>> +
>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>> +                             Error **errp);
>> +
>> bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>                                   Error **errp);
>> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 0f948d0..7d2035c 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -643,7 +643,7 @@ static bool vfio_container_connect(VFIOGroup *group,
>> AddressSpace *as,
>>      new_container = true;
>>      bcontainer = &container->bcontainer;
>>
>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>>          goto fail;
>>      }
>>
>> @@ -679,7 +679,7 @@ fail:
>>          vioc->release(bcontainer);
>>      }
>>      if (new_container) {
>> -        vfio_cpr_unregister_container(bcontainer);
>> +        vfio_legacy_cpr_unregister_container(container);
>>          object_unref(container);
>>      }
>>      if (fd >= 0) {
>> @@ -720,7 +720,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>          VFIOAddressSpace *space = bcontainer->space;
>>
>>          trace_vfio_container_disconnect(container->fd);
>> -        vfio_cpr_unregister_container(bcontainer);
>> +        vfio_legacy_cpr_unregister_container(container);
>>          close(container->fd);
>>          object_unref(container);
>>
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> new file mode 100644
>> index 0000000..419b9fb
>> --- /dev/null
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <sys/ioctl.h>
>> +#include <linux/vfio.h>
>> +#include "qemu/osdep.h"
>> +#include "hw/vfio/vfio-container.h"
>> +#include "hw/vfio/vfio-cpr.h"
> 
> Ditto.

Yes, this #include vfio-cpr.h should be dropped from this patch.

- Steve


