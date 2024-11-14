Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D54D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBefY-0005oM-VW; Thu, 14 Nov 2024 13:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBefR-0005mg-Jo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:34:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBefP-0001zh-Ma
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:34:09 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED0DPA001331;
 Thu, 14 Nov 2024 18:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7crWuMvCvJsC8SBkhIjsT6RV9EgDPAqBrJ6kwgqfEG8=; b=
 hgGhmvPzPmZk8NMhd8IH9Q7MtDVvwGuKSh9fdEfi/lc1g3J78Ebix/GZwvG1+kpt
 QxLK//xXqLrSlBkofmdyx/UnTu6L6gtYNu7MZOeGxrpyvo/ex+JCkxb/FiXZlkZ0
 8wjStLoY9Xau/y8k17Oymlx1gmNTxM0u6MfhiKo7gzI3MhpQD11LOrH/j8BQ44PK
 +4Q45BlMF+wxZvaBUqAFOwWVx3C5ZqF5yU+S0EKf3zFV690St/u92I2GOQQwJM5f
 CJo4WpbF0EoqSjgcj1eICohQz6/TDWUi+M8aRBDUtteAGw8R5qvYUeqDkdxb0bcR
 ydBrrZADnPCP0Q1QsdQiEg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4km5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:34:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AEI5SNh005671; Thu, 14 Nov 2024 18:34:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42sx6bkbdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEUmyAYEd+b9bVtxytsRvD09ZwTEsBApFNcfNqcyxAbIm9LoYr1v2Wu02J9nMvgWLUXTclF55j8RWdfGY4MJB/wTuLHjgxJc4IPN9LjEQb0sgiVVmyZ/KpOl2g1Dy2G/A1J6E1iuLRmwc36KcjAM5CDDPtuXKPs7TC9pGMDqm/pMwUxMlLtWMnzNuQu27xFiIQCX2yb4xIjg0PfFXc74IKcdXwfyE5NAnp8hpwwDn8C3BDwiDF8V+7n31BI3Sd4jsL1STiFFrtpCFqYOPT2PQIgUuk/TaoJa5gWjTuvNhmaZ5flVrsF2LBTeBy+zOW9iliphEebZ03e+1YVXKFVsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7crWuMvCvJsC8SBkhIjsT6RV9EgDPAqBrJ6kwgqfEG8=;
 b=yXu+MT98ywLlRBXZwS8btie0bicXnrPYPy47SXBgyT8t1gTwDXxT8pHWf0DGTJiLyzC/NsMq3ikmHsKmfK1Y7WezYUHDhmefOHSwKUxL8F5hweh11nEmEaF4zOVZR8Ijy8qdp4a3+nEgJTbevwblr8cOmvpweIWRVQSVkfRqhdA1SCHH1NDfpICVcUqfduwbWVkXSh7hQtEK1eRByts+dbByutYCZbLkU42jbIXY1lQ+wrutr0kGSvXV6ICd65xbbv6rTbdAXd9jy/HQ7ULvoleiz5GMq8pBt7jEK9/t0eqQzugHZmtOISPBP3EZQuchFKI5Q/5wpJQFGIHeeH3Sjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7crWuMvCvJsC8SBkhIjsT6RV9EgDPAqBrJ6kwgqfEG8=;
 b=yPjUmm4LuwlWF3u5h+/IjMAeMX+i98udvT3Al+aMuwICM1kUZrrgHSSTj722w8okRgw5hR19Dn1Win89Z7NxSyOXKrDsh7EnMN1nK8JLVniKnH6M4Nn6WFeA3cs76HeF/DpMsojAZgWOzgRTlcS9m4dULFQF3O2z3bizAKLdwnc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 18:33:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:33:59 +0000
Message-ID: <2dc614cb-8754-423f-8c31-e5425075af92@oracle.com>
Date: Thu, 14 Nov 2024 13:33:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/16] migration: split qmp_migrate
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-11-git-send-email-steven.sistare@oracle.com>
 <ZzUWAnYARa_G2-J1@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzUWAnYARa_G2-J1@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:408:fc::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c1ada8-e85d-4392-553a-08dd04dae78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHV3TjUxbExqeUlXUkZpanpGYlRSWStmSHpiVjh0TElOc1YxUUswUllGaUN5?=
 =?utf-8?B?ZElYMnhPdDJSNm5qMkp5SVp3dzNGZFg0WEd3UldMWHp0UmQwVzBycXQweDU0?=
 =?utf-8?B?ZDhjOC8rclBsUDlXUGYzWkwyZno4WDlBNFptK1NmQkVxdVZSRlEydmZiSjVl?=
 =?utf-8?B?ZlBqODJHakxucU1SS1hoUHYzSy9aMXpiOW1mWTY2WXIwemZvT25GWE02M0JO?=
 =?utf-8?B?Um8yb3pwR3ErR3J5QmU5VjEwcElCY2x0RnlmaXgxSnBLTnYxMDdRdVJNMk5L?=
 =?utf-8?B?M3gxZlI3anpRTDNCYmRRNFRGREpaOHdzcFJ5MGI5ZG91azh1MnhqSzFhN1M4?=
 =?utf-8?B?SjZHOTJsZUQ0cW9UNGEvQnRuQ25sUFpBSDVKbGs3d2NiaWExb0pkTnNxUkFG?=
 =?utf-8?B?QlR5cEE3Z2Y3RVBMVVc0bzBWOGhuUnBwdVFoWm9pVklieUoyeldvSEhkMHpy?=
 =?utf-8?B?Q0FJVUVoUjFQNmVOUHk3Y1dJbFB3Y2NZQ1pDMHMxY3dReE1iVjFXSnhidVMx?=
 =?utf-8?B?RGZIYTdBK2cvTXZPbDBpa1dQVGxLQlMwWWtOT201SlNOVk5icXNkVDBXSzFv?=
 =?utf-8?B?NSswRGliU2hpdFJ0SFQzWHJhOUtrZlUwbEN6WFZVMms1OWhXOGpRWDRIN2Nq?=
 =?utf-8?B?WU84S2FNcm1Qd050WDVKdkVGM1pxTm0rUWxqQ0YrOVFtSG02ejRRVEdmMUZv?=
 =?utf-8?B?eE40cEQ4TlQyYjlBbG15ZlYwcm5HRlRjeU9NSHB4a3pnNEhhSWJMSlZKcm43?=
 =?utf-8?B?b3RxQlViSDI4SWhqSGlMNkRRaFQwazJibkkzRGhDbDhDMUdYYkhiY0IzWC96?=
 =?utf-8?B?ZnRZdk5adnJibzRYWVkzQjlZOFdKeFloZUpKYy9tNUJJaFFIeFB5d1NZZ0NB?=
 =?utf-8?B?Tmh6T3FWQ0tlMkJjRjBXKzFIYnFxY0R2ZFY2L1BZVDF5bVUzNTI3U1N0dnli?=
 =?utf-8?B?YThQU0p4eVBZVUVOSEtnMUE3OGwxcm5HYmcyVDMxUmZBTFhYeWFpeFY4dXVk?=
 =?utf-8?B?REhUT3cyZ0NzMWU4STBEajBhR2FiMmNyYzBST3VCd25ZQTJDWVppY1JpalIw?=
 =?utf-8?B?bHNiZ2NRci9aTGQ2SDNZdk5YMWFBa1dKb09LWEhpRXMwTXZYRFhoWGRPWnNt?=
 =?utf-8?B?QWJvTm1sREp0SGdrdE1yekRqM1FlQnBrcGJVcHdpSTQvMEVpMUVuelk0SUNG?=
 =?utf-8?B?RnhmOGZYcWNmNWJFSjl5WWZ3SGcyejNaZVdxMGhML09rNEhGUkhoTWNOWERz?=
 =?utf-8?B?bndMVFJLTjFqZ3dYdTNqQVQ0VXk1WDNLdERNZ3NIcUx3am00dkhGbFhXREVs?=
 =?utf-8?B?ZnBrQ2o4dHJmbW9tU2lkOE1UVG9ScXlnVlBDdW1Uc2E2bFphcnEzVmpLRVpr?=
 =?utf-8?B?azNoZkxtUFNXeWVvSFljdTgwOVVMaENSUG5sc0oxT3FhSi9zNkloTjhQY0FH?=
 =?utf-8?B?K0dZTjMrUHhvZGFhd1NPdnJEVXorMnhITHJhbThWQTZJYUZHWEwrbHluc042?=
 =?utf-8?B?eEt1S1RDdElaVmtCc3BOZ3dzVFR2cXYvQ2ZDSmR5ank2bnZOVVJFWE1OWjBz?=
 =?utf-8?B?K1dvYnVScktiUWM4Rnp4OVg3RUNhODdJaDlDZ0ovTXRCN1MxK0ZiMk5LdlQ3?=
 =?utf-8?B?dTM5a2I1M0RqcGhZZ0JjTTB0V0EyQ0pWQ0trWEsyVDRGcVhsTkR6SjIzVzZO?=
 =?utf-8?B?bko1MDJMSzluSGFNcVlpV0RhRzdmaXE2VFB6TGtPeTcyTEZvZFRKL25vSHRX?=
 =?utf-8?Q?rPixZoAmZqEwUCUays=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZubG9jVlBEUUFTekc5WEE2NjJkd05GSnFHMGJpYzZ1Y1Q4bHZSczc2V2Zn?=
 =?utf-8?B?L0pRbGFaaGROc0owMEZHLzJIYm9DVUVzTWc0UlFLWWdMcm9PL1NSY21hVitX?=
 =?utf-8?B?WHZnUVVmL3NwSEhFeUFhenRWSVJueWZqcDV3TlA2Wm1mVGFQSnNqZmlGaW9P?=
 =?utf-8?B?QWx5M3VpK1VJR21QV0Y3T1JaZi9rSUhGY3B0WE5ERnhBTGRKTmZqSmIvSDMx?=
 =?utf-8?B?L0RFdTVXbEE2MkZZckdNRGRvQS9HWW52blZOUFphc0V6bWFjbS9XelBCdTF3?=
 =?utf-8?B?Z09pNElwNzZ5K1hqY1krUXliZHh4VGVIM3dDODVHaytWR00ySnFVdEh4QTZF?=
 =?utf-8?B?RjZxdjBzMTdUamhXbUtPNU9XdHozY3VzczgzVVh2UmtwMkJ1OXoxaUJyVkVG?=
 =?utf-8?B?NGNpVkxJc25FK1diREcyUXhZTHgyRGljYmdZRVFiWVNROUM2cUJJVmJyYTYv?=
 =?utf-8?B?alFjYXA4TzNEVy8xd3BLZUFDVk1hUFhrd3FyelRxekUrY3JydWtreTE0WjdQ?=
 =?utf-8?B?T3E1MFJKd2w1REJNWjhWbW13K2Q4MExkWlhsNzR4Q0RCSXJqb3NSODlwM1Vt?=
 =?utf-8?B?a0pGUDZWY0FaZGw1SEpvVlJNaFdzek9CVnZhTS9lNnRkeHVyQ2JNdE5yWUZi?=
 =?utf-8?B?RVZRVXJGTmxsQ2ltUUVOYUtwNjF4a1gyS0ppb29kdVhRNlB3SHZGcktTbmVF?=
 =?utf-8?B?bGlYdzBvOXNLRDFFYXlCNXF3Wi9zdWFpeTJQNkxMdEI0R1VJckx3TzkzeXBF?=
 =?utf-8?B?M005ZUlvc09yV0svbStKZmtNaDJZRHVuVUFZdCt4UG5heHpYcXNackdzYWds?=
 =?utf-8?B?VlVqQW9OSEIvNGZVUmlXOS8yYkRVUG5FWVZlNitXWG5LQU9oUjJDU0U5VDMz?=
 =?utf-8?B?OElJUXIvK0kvTnd3b2xvcXFRSlIxaFE1QmU1TUk2bDlnUFZqV3pVMnNNeElU?=
 =?utf-8?B?RHFwUmlxT0N1VUp0dGlMbzVtaU1aVUg3QzJrcldERjdQTkZwL2dYZ0xzSTl1?=
 =?utf-8?B?aldMbkpYbjJsNkxya0xLdjZ1aFgxdHM3NTUrRU9ETnAwckFIbkVPdnF3RUFX?=
 =?utf-8?B?SHdtZ21adzBUMDVvcUUzNGF3SEwrcnZvOFhGME5MUVFQVmJoSEx0cHRSSlV6?=
 =?utf-8?B?S1RmbVdRbmNSKzFxWU1OM2RLa3B2SGphVHpudjJYa1NuWmRGZnhWb0JBN255?=
 =?utf-8?B?VTJRRmNtTHN6c2RiSTdxZXFBT0diRUEzWkFqYzVrTitBdnQ3ckNwNEJBK2R5?=
 =?utf-8?B?QXh3clFTNjRQdmtGMU1YbFZMcXpOWHZkUnJtd0Fac3I2UktJU0x6K3lNblh0?=
 =?utf-8?B?ZzM3aE9zb1JZdnloQUhhejhFckE0TGdiZ01OSU4vNEtFOHFpbVZvTDBuTys4?=
 =?utf-8?B?TytvbmwzRkVRZ1hWSHB4bmRSVTNTbWYrNkJmUkdoemwvMENqYTVZNSt5azZo?=
 =?utf-8?B?UkR1dWYzT25MOFI5N1dYSHlZYW8yYU9PVWEya29sL3FRSVc3OEFYdUtVWnpj?=
 =?utf-8?B?VjdWZ0JSMzR4YTFMUlNIQnZoZDZIUTZZTk12QUVuSnVBb3NCbElGNXJRY2ZL?=
 =?utf-8?B?RWtRcVl4QkF5YUNEdHU3d0pxaGlGRmhoR2RtbXlFVldWcFFKa284cXpnaTly?=
 =?utf-8?B?TU1wN2dqTHd5ckUybjVlSjBUVGg2cE9lMURlRkFLdjZlM2NHZDQ0Z2dCY1Fh?=
 =?utf-8?B?Q2N5TUdqV2tmSERyL3kwdXVWSWVCRDdhTlJ5dHNBWURGd2tyKyt5cHhSRTg0?=
 =?utf-8?B?RkkyYW96Sm9Nd3pUOTN0SjFvbm02ZTljSTNJd1R5V29xU3hpVjhJeGFkMkJM?=
 =?utf-8?B?QWRNeTN1aXZxcWJwc3pMNnJnYlh6UW9KS1hRUnBpWEhIWlIxaHk2K2Jld0Rw?=
 =?utf-8?B?VUg3bTErVTRQQUgybTFsTTFBUDErdWE5S1hEcVQzVlNHY0ZnbXM1ZUFCaEpB?=
 =?utf-8?B?bS9sM0gzK0g0SzFXOGJ3b0svTmJWRlFnRUp6MjdXRjNaSHVqSHd1eW1GanRy?=
 =?utf-8?B?TU10VW9ZNDE5ZEtaeDdTYTJEWTBZK21hZHJjRGpSY0N0UjhGTkVFejdrV01Y?=
 =?utf-8?B?SExVcEVEMHQ0OFRtb013MUwrNnE4aThhbkhUNXczNTN2VGhyRVdySUtrWDZY?=
 =?utf-8?B?aXRlTUROZ084NEd2T2xLVjNEekZ4c2w5aXFEbUpmcklyRXVTb2FKRFIyT3pG?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E8hiX9XFIxSeaWh97rqISX9H6knLk2jXmObBaBUW78mnwjS8fhLQbEy6Mo5hhj97o2ijok4BBrSDsapmD1cCQ1qrPGxOBZtKq0EbfmhDGQfbjykWhpJ8sDJvgbzkfgd0X2dlcLEPDT8ARYpZsnTcuMQ/SIBLz3XxwCDk/qbkxoUAJKQhUIKzdByWtMlv7MkFLQv333bZ8j+acvJvPHODRSAUXBu9LZ+LOdy4tNJWobNgxEIjqkmpiTejWl8k4GoUvLn379ZodHlW/oyOjBO43KsJiwl+Yj+7NIAQ4YARRz42uJMvp+TMHds/nMiaoTn5NxvDnmB5MqiSDhHNaIWe2DL00uUyH29NaanYKGsTI35bcldv76HtcyNa5GA0JzklyW94M+vPaj4bSZkltwgOqMNsClOy/rNqL12AhWdOfZLIQzsnalk8swXN1DhRcN+mDcdL+VXCoXL3rapuj6qblkqFdymduq/690fU8QXYnW3dj9Nbl8BK/ruTsN5xsPyMvwVCx1i4vcUoycCUcB3JfsFfbCLW1ZYSwJ9tcRqa8k/9oI1oJ24IrSy3aNuUefPnFffKu+/9drgmSQYW/107NIm0HzC1nxxoG66nQIegTQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c1ada8-e85d-4392-553a-08dd04dae78b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:33:59.1829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Pjsm1ctqN1V6dGMV46/MnJ95mCxAFiObfCgGud+ThQU/mPBr9rvAPwvwDxJ6wZoOJ4qZtM8SZ/RAidiJeQwkDfxGRgX4AxAUhLI90dAduI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-ORIG-GUID: lnHZHKVctQQZjLItfHwEuEyrntRg2wtL
X-Proofpoint-GUID: lnHZHKVctQQZjLItfHwEuEyrntRg2wtL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/13/2024 4:11 PM, Peter Xu wrote:
> On Fri, Nov 01, 2024 at 06:47:49AM -0700, Steve Sistare wrote:
>> Split qmp_migrate into start and finish functions.  Finish will be
>> called asynchronously in a subsequent patch, but for now, call it
>> immediately.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   migration/migration.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6dc7c09..86b3f39 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1521,6 +1521,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
>>   static void migrate_fd_cancel(MigrationState *s)
>>   {
>>       int old_state ;
>> +    bool setup = (s->state == MIGRATION_STATUS_SETUP);
>>   
>>       trace_migrate_fd_cancel();
>>   
>> @@ -1565,6 +1566,15 @@ static void migrate_fd_cancel(MigrationState *s)
>>               s->block_inactive = false;
>>           }
>>       }
>> +
>> +    /*
>> +     * If qmp_migrate_finish has not been called, then there is no path that
>> +     * will complete the cancellation.  Do it now.
>> +     */
>> +    if (setup && !s->to_dst_file) {
>> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_CANCELLED);
>> +        vm_resume(s->vm_old_state);
>> +    }
> 
> Hmm.. this doesn't look like the right place to put this change.. as this
> patch logically should bring no functional change if it's only about a new
> helper split an existing function.

I can move it to "cpr-transfer mode".
Tthe remainder of this patch becomes quite small.
I should probably just squash it all into "cpr-transfer mode".

> Meanwhile, this change also doesn't yet tell where does a vm_resume() came
> from.. 

The vm_resume is needed because of the patch "stop vm earlier for cpr".
In qmp_migrate, it calls migration_stop_vm in which sets vm_old_state.
Hence vm_resume restores that vm_old_state.

However, I moved "stop vm earlier for cpr" to a later patch series, so I
must also move the vm_resume call to that patch.

> I'm really not sure whether this is correct at all, consider someone
> does QMP "stop", migrate then quickly cancel it.  I suppose it may
> accidentally resume the VM which it shouldn't.

vm_resume only resumes execution if vm_old_state is a running state.  As
long as vm_old_state is captured at the start of qmp_migrate, as happens
in "stop vm earlier for cpr", then vm_resume does the right thing.

> Not to mention checking "setup" early, and unconditionally modify the state
> here no matter what it is (can it be things like FAILED now, then
> overwritten by a CANCELLED)?  

OK, I will only overwrite a cancelling state:
   migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING, MIGRATION_STATUS_CANCELLED);

> But I'd confess that's not the problem of
> this patch, but that migration state machine is currently still racy.. afaiu.
> 
>>   }
>>   
>>   void migration_add_notifier_mode(NotifierWithReturn *notify,
>> @@ -2072,6 +2082,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>       return true;
>>   }
>>   
>> +static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>> +                               Error **errp);
>> +
>>   void qmp_migrate(const char *uri, bool has_channels,
>>                    MigrationChannelList *channels, bool has_detach, bool detach,
>>                    bool has_resume, bool resume, Error **errp)
>> @@ -2118,6 +2131,20 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           return;
>>       }
>>   
>> +    qmp_migrate_finish(addr, resume_requested, errp);
>> +
>> +    if (local_err) {
>> +        migrate_fd_error(s, local_err);
>> +        error_propagate(errp, local_err);
>> +    }
> 
> I don't see when local_err will be set at all until here.. maybe you meant
> *errp, but then maybe we should drop local_err and use ERRP_GUARD().

In this patch local_err is always NULL.  It may be non-NULL in patch
"cpr-transfer mode".

I'll just squash "split qmp_migrate".  It was intended to siphon some
complexity away from "cpr-transfer mode", but raises more questions
than it answers.

- Steve

>> +}
>> +
>> +static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>> +                               Error **errp)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    Error *local_err = NULL;
>> +
>>       if (!resume_requested) {
>>           if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
>>               return;
>> -- 
>> 1.8.3.1
>>
> 


