Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB65BC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 17:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ8SO-0007Us-To; Fri, 13 Jun 2025 13:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uQ8SL-0007Uh-Vz
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 13:44:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uQ8SJ-0005nc-N1
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 13:44:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtdgI007824;
 Fri, 13 Jun 2025 17:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=iDba6GoyvYmXhHsHo8ED8mI/fP0XqXeab/chuOtWhIo=; b=
 gXo3j0CSqUeZc2JNfHmpF5h9goXZbNb3NGyzUnQaeVw7SU0zs5g745pQrREoHn7T
 gVKY/mSvcF03Bj7bVsXHDPc+0/hZGl3am4UgAMkEkd4W92YLDUQN29xFLJD3DRmY
 1XmEmlf0GPmCXZzh7vMHaIV+z6na7SrNyIdtqAYATgT3lX/Yhy3gc/rMEUZ8oo3O
 OszSZRlxZoS+9iutxByFr6ANSgG/9t09OaRhGgQXIJ9Z3wBtjrH1Hy5GMHMFBUWQ
 WCXcU9ry2iQOeIYxLL2RKqhaVtY3jn66Kgh844UbKIEdyX58F9Yg6gllIPFdZsaO
 wb0yUvwkdxhpNA3m2CIvRA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx44m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Jun 2025 17:44:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55DHSBEd040772; Fri, 13 Jun 2025 17:44:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bve5uc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Jun 2025 17:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcCKEKKZVrQAgxRi1yPjC/UEJBhV1TysD1RwlPof1pAg8AOMEjLFSZSnIFz5nbsL3vTaH1J3PhPYCoKAA2bpz5ojS/xajrwEgWK/2RWdp0t3gRefaKkRyKYjplJk1FQzB15urvenfu0N2SKxjJ1BvZMy/0i8nZayJccOvzyOWgVRo+7PailmdQWnvIjAO+rppqh7j7vWx2eCAT32TZgCkoXhcIspAjo0XK/DL5nyuTihq3XxzZTLQ1gup6Dg7LlH1cQoMI/B/EZ216X3IDEwiPdXxoE8gc9WaBIA2DSXio+jzH03Qk8B6IGfFOza309CgLQPMUDDFs3ctio3IysMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDba6GoyvYmXhHsHo8ED8mI/fP0XqXeab/chuOtWhIo=;
 b=JLm5o98efSWv7Wk0BiQBOyTpv1RYt5rh2O5YTli+2WwtqP6NGHbsFhFnogrpIC/cnFgqI1XtOnjyuVMs5MQzILGH5B272sz+UsFCL+RPAOnUGLUaaILn0BORvLLBvedMvodGDbaebSS5u8IVqTzXRyx5KaoaMicHa7k8cGAMpE4cW8FA/KUr79oOVv+a3xjEptzZHqX7C7IL6O++zUNsUjdtjvsKr1Nmt/RF9fC++XWvx6+fEAgQo/4B8BLdj2UW4EOtaXXukjXlhMgKq8po41WWMTHRSG2ER1sl6AM0X4tnQSFghqMtvpF9EFR/o+ynYHcKSVInxsIbur2B0Gy4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDba6GoyvYmXhHsHo8ED8mI/fP0XqXeab/chuOtWhIo=;
 b=ioprZcgFkNDObBQIKUo94zvM1NxQj4RqeTez1m3vnp+idnUaFB2OBTZJL/PNrNrEsGxQ5RU2SvQKNmRCPLYfYmctiye9tjFLHjlcZgQGVzPrFOvUHmoTbu3n/QcARR6xV6EGYXkbZoraF2ZkpQ+lqL4jAnGWwxgQ9I0pK+HW9aQ=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 17:44:30 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%7]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 17:44:30 +0000
Message-ID: <9a41920a-691b-4179-866e-a3c6fc80565e@oracle.com>
Date: Fri, 13 Jun 2025 13:44:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] amd_iommu: Return an error when unable to read
 PTE from guest memory
To: Vasant Hegde <vasant.hegde@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, clement.mathieu--drif@eviden.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-7-alejandro.j.jimenez@oracle.com>
 <34197439-8045-4fee-8fcf-4fad005379a6@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <34197439-8045-4fee-8fcf-4fad005379a6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0688.namprd03.prod.outlook.com
 (2603:10b6:408:10e::33) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 7357c198-45eb-4245-a133-08ddaaa1f2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEtJTWdLV21xakFSdi85ZUd0LzNoVmRKSUpaRHBqZlpGQlR1VXhLYnM3V0Ni?=
 =?utf-8?B?VVBZeE03QURRaGpEaFNUZW82QzhsYWlkdE53NE8wbzlJb2xZbEhMdzFWTUEy?=
 =?utf-8?B?VjhwaFBqTitMeFBTK1VKK3h3S0RvTjBqK1hBcGNGYVpDT0VvanN3dFdoeUdz?=
 =?utf-8?B?ejNOOE1DMFFKU1Z0NkpjZUtBMG1zZ2F1V3FMbEhPc0hlUVUrQkpVbTg2STg1?=
 =?utf-8?B?V1FjV1hMQXRWVjhHK2dtRnZ3WDJ1ckhlWVNCNDZFRFFoMHZqL2xBWmNiU21R?=
 =?utf-8?B?RnBSMmVCM2twQ1QxaGJ0cEZ4Q2dKSWtLUS9PMU5wRVRQM1hrVG1OWjJWRGJB?=
 =?utf-8?B?TG5yUlRWZ1d4bnhEa0dlNVhzdkp4Z0dxQzdnZ2RzbUVMcjNzWGcvUzRXYnVo?=
 =?utf-8?B?cm1nSDZPRVIrZGtkcDJGUnFaUWh0THhNVENGNmRuN3ltblNOVXpFSi95dHF1?=
 =?utf-8?B?L2RIaWg0NzlEOEU3UWUwTVdKWTJtY0JLU1lhU1h5NithSjl1bGhlblVnSVRq?=
 =?utf-8?B?ODJnMDFYV3htUFlkdmxZOXpaZ1l6RDJJWkJsWmJralVKKzZWRFQ2dDVraE1p?=
 =?utf-8?B?TFhhRmsrYWJ4aGhOUzdxWDdjSnRlWmdNenhoc2ZSN1Q3RzVDclpaZG5TcmYv?=
 =?utf-8?B?QjNXdnVnTTliTkZSRkNGZllpbGsxN2ZaNlVUY1Jud3FLTUpaK09ZK29yVGpG?=
 =?utf-8?B?SklGR3JXSFRBOWhWTlVpVWMycU9wejVZa2M3K3lnL1pUaE9pcGMraXppOW9B?=
 =?utf-8?B?VmRtcEVEQ0tSaU9RVjZnOXRsZHlRQzU1NTFVSGx1MlZnSldtcW1ibVVIaDBY?=
 =?utf-8?B?dDFJNHkzN0lpU2dsZ1Yra2VsUmVjUWc0dzdtNnZZTVM4UHRsOE9zcXljeXFh?=
 =?utf-8?B?WXBETjdnNVJtL2I0WklEb2pjZlB6RGxBeEc3clh2aE9pSXYwcStJcW9DTjlC?=
 =?utf-8?B?d0NpWFJDWWZiQVVtcGxFNzRIZjcvU0R2VUNpQXQ5SG5WUzAyd0JkdmtuZGs1?=
 =?utf-8?B?UW0wcTFLekNPa09hSFVYeVVzYkxpRVVGRjdpL0NVTndPd3phajlCQ3lPRG9D?=
 =?utf-8?B?K3JlWEFPUTJ3UFUyc0w2aVBoOXFxNnk0MDNKMkNXak1Cck02YzJzZkgzYS9y?=
 =?utf-8?B?VWNqWE92V3pHRzIwbEhvMy81RDYybVkxbEhGMWNoL0VlWlFqallWY1pROXZ6?=
 =?utf-8?B?KzZsSjBVd0FDdFd2ZzlNUlFEMXlWNEZWSFBaL1pOUlZ0MVlTb2FiZzB1MkV2?=
 =?utf-8?B?aGJ1NkcxT3N3RzNIWHJiZU5wVkxCREJIM3VydWp2NDJyL05WOU1DSmprMS84?=
 =?utf-8?B?YUNzR1N4c3NFN3ptSEFHbHErRm1jOTRFUW9ZZWN6TzJzcDJ3NEZublJwRHVF?=
 =?utf-8?B?dGpFbEFPZEhCWGpGMHdjeFpWYnRMMG9zQ25hbTlQWG1IUGJBVlFlMENSbDYw?=
 =?utf-8?B?U0wrWm9KNU5qdDhUQVkzQnQ0MjdYdEExY3E1RjJFeWZHYlIydEhEcHpaMmtn?=
 =?utf-8?B?UFlDTTVvcXRxQjllbSthZk05TXVJUWtLZWgralU3UW9GOGxrSEtVZGhQMG5O?=
 =?utf-8?B?akNsWm92SVlLYmEwM2w1Yzd6d1YyazdCaEJJM0RxbHZqUEtUMGViT0lGYW0y?=
 =?utf-8?B?ajU4Y1NIa3Q3R3ZxV1d4Y0xkM2NGQ1ZKYkI1aXExS0xuS2FOQmFlUGxsaXpE?=
 =?utf-8?B?dVFLSU5uWVhFREEyRnMvdnppUjNvc2FjYVk1aDVweFlnamNHaW0rMWRkTWxQ?=
 =?utf-8?B?VVZaMTVSZXRRdE1jd0RDenAxM0FpbnhJV1drclA5K0JmSTZPaHNrU0lqcHps?=
 =?utf-8?B?cjhJMDhjeXg2Rmt3WWhFZ2lrTzB0YnRJdy9WVWV1VVhCZkFjZTdnVG1sTzRG?=
 =?utf-8?B?Slk2S0piUnJHK0VlNnFnZGJFNDJRU0txUEh0eWlhTGZ3TlZuWXJyb0pnNlFa?=
 =?utf-8?Q?quuEjoYB/+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3pZdHFENUxHbVFMZDF3SENsVDJDSEwrMmR3bUFvUXVZOWcyaWRDWVZhOHlt?=
 =?utf-8?B?TEFVL3k2NEVUYlR3ank5NzRLcjQyTUtJWnJObjg4dFhDcjJEM1g2QnRMSEZ0?=
 =?utf-8?B?RW42ZFdzdGxJNE9vc29tWk5BVGQzQUR3ZGZ4ck1IWExpdlNtdHYyUkpJRXh4?=
 =?utf-8?B?TEU3YzlBTVpwV1NFVXErTmpvSkoyOXlVT3NTcDFqZG9PZm5BYjFsREtjSlI1?=
 =?utf-8?B?aC9pbzMzMll3bmpzeUxKWmg0Wm9iZnNPNndrdDJlTzQvVEgzS0kwQWpTUlla?=
 =?utf-8?B?L2pOSWczdGNna2xtYXR1NkVLdmJucjFqMTNCL05maHZ1ZmZscEpVRjJJNS9k?=
 =?utf-8?B?UVJDTW1CMWxjOGdKbVVTSGhoWGRyd1FONlNNS1ljSVhxMjdMYnJUZnNDSEZU?=
 =?utf-8?B?bng2cW1wTWgwZkVEcnN4WW1DQ2NJZG1CeHpjVFFiYzlHaHY2RG90OFg0aHhG?=
 =?utf-8?B?MUlLZFBqd1Zia3c1VHQzS1c4MjVMQ1pIZVM0RmJwWitMeFk5RlkrVHdWbllP?=
 =?utf-8?B?a0ZiYjRoMWNYM29mRVBlMDR4cUJYTjdFRVV6K0Z3T3J1R29HQ2dLM3VGYnFk?=
 =?utf-8?B?KzdkRlhQUFBuVmZnT3p1U1Vnd290RWwxeWx5aXRJZUx6MU00dlZiYlVxcFly?=
 =?utf-8?B?Z052TGlXOHYwVEhSbXZnR1Nac2Y2WDNwMDZTbGhuUzZRdk5paE9uZlA5dEcy?=
 =?utf-8?B?WGhFdkV3cTJkQjFqMlZ5OGZPTkZSS2UweVZNd0ZQUTZzRTlwbVBWNlgvQU9Z?=
 =?utf-8?B?OHo1Tm8vOFhVY01SMG5qUUtNYTZWUnJ4dThtSmk4b3hScTZwRkpjLzZtQmFF?=
 =?utf-8?B?aWRvZ2N0ekxMWm01K1BCOEN1V1J4WFJ1S0c0eU9tOUl0UEtkSzNjU1IyUlp4?=
 =?utf-8?B?YnBaQWxtRDJOZXkzamt3d1RCTzQxcWlaMVNLbWpkbi9aRFloVThZSTVqZjhj?=
 =?utf-8?B?bVdHY2kyRCtkdVFQVEI0S0l2R3lac0RTc1VyVjlXamE5Z2hJZGJtMEFraTFl?=
 =?utf-8?B?Qitha2lFQy9vK2hQNGhJMDhmaXNUWnhzclY1QUlrMGpRWEpEOVNQWTlDL1lX?=
 =?utf-8?B?RExxZGM0Y2lhcENwemNhdFlYNVpaTVpOUGpvbUh2T2FMTHhMWFBWTU41K2pz?=
 =?utf-8?B?SHJ6NzQvbWVOU3dyOFJjc2NYR29FS3htNEVmS2x2NjJmY0pGL1E2MEtPQ0JR?=
 =?utf-8?B?ZTFZTVdnc3M0QVBQeHNtd1IxcHJIaU5BSG9Gd3QrbGJ3NkthQUhUa3BDcWFN?=
 =?utf-8?B?L1dGRjg1K2p1UmliOHhsYlFLOWFJTHdocjVCK2UwRWlrckZCdkpDWDFncGV2?=
 =?utf-8?B?TVdSdEtYeFJGZklsUFJWTFQ0dmJVN1NIeHIzc1BNLzFvbjgzOGVKNnhqVllH?=
 =?utf-8?B?WHpnZXJBVXZ2bUU5c1k2UVpMelVkVEsyMFRlNm1SQ0gyMXZuOWRSeFk5Qm5w?=
 =?utf-8?B?VzhBY1FkQkhBc2pnUzJEWUgySjR1aUI4NHpZTys0SFp1dzN5RC9ocWdiVm8z?=
 =?utf-8?B?WEJvSy9RZjEvNGg2eGJmY1RrVUNreUZRek1HajUraDMxMEszSUVHdjFibjRw?=
 =?utf-8?B?VE9yNzlBZGxZMFk1TndRcWFGc3lMQnVqRUhQa0pzQVczb01EamcrM3BIVWVZ?=
 =?utf-8?B?OVJMRWpNdDNYT0xYN3A2a25lMmcrMlczRmd2STdjeCtscEN3M1dTWitHM2dV?=
 =?utf-8?B?cXd2UHRjZUpJMjRoNVI4Zi85MGxacG9EcU1LalUrbDZqb09BdHUvaXRIc1p1?=
 =?utf-8?B?Wm1XM1M1MGtTNE5YZk8yTENReERNejRRZnI5bHVhWTBSTHpiTkt0T09mMkdQ?=
 =?utf-8?B?NHJsTTY4N3VBTkM0L3RWUTRFWGRWVUtjUXVJTi93N0tVY1VZY21aN1dwRW1W?=
 =?utf-8?B?Q2duaFpTU1BKN0hIS3FPbFgxbncyMEF2d3ZVUEp3cGhaVTFVSmU0MENLZWtW?=
 =?utf-8?B?Z3FEZlM0cmMwSlVkOTQwRklUejVKbU1lQ1ZMWnZpcXRXVXZlYjhoajlWTnQz?=
 =?utf-8?B?UVZaQU9DQVpmZFV5aXlFZEVqckRsZHZ2OVBBYW9BZ0RITldwU211V1M1SUFF?=
 =?utf-8?B?Yldyak5Ncjc4bFRIL0ZOZkorU2cvRnNGcGtSa3F5R0ZjYTlMMmJkNzZxRW1y?=
 =?utf-8?B?UE44aG5vR05mazBhSFNtQnA0SnBGMnhoTnpjUzFtSE9DWldzS2kyTjg3N3lF?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V2WOuKjRsBGECv5lyOIKa7030D+Bju2A2w29yU1bq0knS2S0TYul/FkWBeYD041ivXFWY5f1zcR1IWhdQaxkdyz98MCD1ikgIyu0EeDsdfzydzhfITwpI0QRusvy3uuf67yMjvqTMxjkHoDYztSrNDe+jBkWco08k+/SKV3hN0Y6Tm9OdBZ9OcWrASF3+YACIj4BtVBcq//KFdVV2yHlumwQ/TzX07F7X7kxx5ki7GQstm5ra6f0H8XY2ei5IgHn8OhW/F2NXPyzRk64Jym0h9ni3KBMa65+v+lPFUq0AeQfGi8aD/QvNvO85jzBzGDDaoeirTzAm1yZLWVjp0/T4rsCvBOwpr9hCsxJmyxJIiKD5JYAFTowlN2AjbzOEZorQETZQEkWcqAaDmzBtfBu+CCQekR/yN+FFqmWkOtY31zs7FUltulXkMlL03SSIPXr+AZAydCJ3EOwFs9v/789hBCCqtCBlt8Ye3ZMT53WHave6gJdj2iLFFhBILJsm90QxPZo8SEjinIPsAlk3E2ZZMMVBt3DSFynqqKRbYj+t0W45LTgV7zsens7l2I0tJJnJChBEGaUDgu4SziAMw5ISRiEPIPm7VPnjuI6EHiWiII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7357c198-45eb-4245-a133-08ddaaa1f2b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:44:29.9906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcPdHeLiEdSU16oqxMP9DR8Ar4hhueyiRZGpZD9CLK1NLSuCStR8HnmFsKhHbJGso3x7KC4mXSVH1kkg0xkbRXU5vrAjd47BvD8eMIQTQ2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130126
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684c6381 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WwDV167dCkCJAzUH7-AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Kf3CJeVsq1SGLZmisMe60_ZvReGWkcjI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEyNiBTYWx0ZWRfXySMopD/gnklG
 +qQqcG95Sp6l4hFVpxaquXce04YEk/J7s0U97FLvJIEIzvaopS0aNQGb8nxSOIJjLrhpWAFcj6Y
 9Tk/9nTsUIYpwHKniMaupzzmJgERI+f25x0HtF+pbHaNND1PN3i6eBXuL5D7ZvmoXdGeg1mVn4J
 zvwDQHA77mv7UemhEbqZZkYdg0U6U4mkJskx5tnT6q7GzRC0GcJQta582xxY+QwTPrq50EeJ63t
 lXE10dLbWNHHYDb2cEdKrSW50LBeeA4Y90GpqSHmuqsei9O+/xZj/gVkW0OmU0AEIPuDHftt7Wn
 9Qf+YyUgU0gTTHf7C6/OyNQzYXgGgMxpL42pFN2CYjBAxveqH+XIn9W9qDGIMzh5kjE0sdIfHLX
 RLoXdltIHPJ3dYekfrcxYSvZLukm1MZvKVRrU/oCvUSxMM6a8HfXDj0zwEtzIcS1t10sAqfH
X-Proofpoint-GUID: Kf3CJeVsq1SGLZmisMe60_ZvReGWkcjI
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



On 6/12/25 6:37 AM, Vasant Hegde wrote:
> Alejandro,
> 
> 
> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
>> Make amdvi_get_pte_entry() return an error value (-1) in cases where the
>> memory read fails, versus the current return of 0 to indicate failure.
>> The reason is that 0 is also a valid PTE value, and it is useful to know
> 
> 
> If PTE is valid then at least PR bit will be set. So it will not be zero right?
> 

I can change the wording in the last sentence to something like:

"The reason is that 0 is also a valid value to have stored in the PTE in 
guest memory i.e. the guest does not have a mapping"

What I am trying to convey is that amdvi_get_pte_entry() should return 
three different states:

-1: Error attempting to read the guest memory that contains the PTE i.e. 
dma_memory_read() returned an error. This has likely nothing to do with 
the guest and signals a problem with the emulation (e.g. problem with 
QEMU memory backend)

0: The guest memory containing the PTE was successfully read, but there 
is currently no mapping in that PTE i.e. *pte==0

 >0: The guest memory containing the PTE was successfully read, and 
there is currently a mapping i.e. *pte== <hopefully a valid IO page 
table entry>

Before the change, amdvi_get_pte_entry() returned 0 for both an error 
and for empty PTEs, but for the page walker implementation later in the 
patchset we need to differentiate between those two conditions.

Thank you,
Alejandro

> -Vasant
> 
> 
>> when a PTE points to memory that is zero i.e. the guest unmapped the
>> page.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 5322a614f5d6..698967cc1a88 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -496,7 +496,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>>                           &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
>>           trace_amdvi_get_pte_hwerror(pte_addr);
>>           amdvi_log_pagetab_error(s, devid, pte_addr, 0);
>> -        pte = 0;
>> +        pte = (uint64_t)-1;
>>           return pte;
>>       }
>>   
>> @@ -1024,7 +1024,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>>               /* add offset and load pte */
>>               pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
>>               pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
>> -            if (!pte) {
>> +            if (!pte || (pte == (uint64_t)-1)) {
>>                   return;
>>               }
>>               oldlevel = level;
> 


