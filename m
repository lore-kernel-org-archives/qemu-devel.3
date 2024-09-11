Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C49EE499C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 19:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soT5k-00063l-1M; Wed, 11 Sep 2024 15:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1soT5i-000639-DV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:33:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1soT5g-0003Mu-4K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:33:26 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BJBclN025923;
 Wed, 11 Sep 2024 19:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=8Vx+zydAls6p9gMOo82cnv7LSTKv0LFYaU08FVmt3Xk=; b=
 f81ME0Q89tTSQSbPcXMIM0030ZX8DLPFNvswyKQ5NsafOweDbz044sIk5SIL0uT5
 pAoET1XG0KucKkph9ub5Ny0VPUhurRQ69H49eSMYjDB9ADGWvCSPC7LScUaZ5t30
 nn1UHgB86Rtl5Nqox4Ejv+IohUr33xu1nvc0Ar6rU6aDvnewpm383lkNgXxw/jya
 zJM4gdc+7aCjTXHoOK7U6c3Nb7+C3UnA2+pLQy8oZZdLlNk8bIeOs6XXldUAxIxr
 1osEjxcpNXNCqASJ76echUHNKDoKneJ2MOkJRsMKjgrl4ZgLsfUesGMVxjgL9S9s
 uMa89t60OhJNCQj8NmoJwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb93mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2024 19:33:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48BIgeSS031613; Wed, 11 Sep 2024 19:33:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9avebq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2024 19:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6pijv6IM7XeF/x1HGjQLdkmrt+0pYDEO/+MocfJYKVIrtkhUyihq8HaCRtMJck1tfEMt4vapmdTJvDqfxwkiPOEANbKQlF/Z/5F3mRhwYL0+2DbKaPQy8w2Lw97HrREaCfRHsi9ndnp/0mGPLWgimCeYAWXbrP9S4OwlFuOseoYsEHN0pN6Rm/K3BI3YaYFptVDBKfVqYXheqrl8fY+0i9kXzKPz7X5jZ+n/b7oiO2zeX6RS9n9cDiKHuH+yoUNNYRI28lsbF7+LAXcuPK2DdmT44LXkIsv0RIXql56qKLF7eunsz760P3GjEfm5AFjuwuv9m3boY3EMoJPRmqNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Vx+zydAls6p9gMOo82cnv7LSTKv0LFYaU08FVmt3Xk=;
 b=I6CAVZncq9zmnkJK9b+4G03EPzRUWq/O8z7Z4PSEHjtIDg77G/hyackl61XewpPQjxoVsQa1HspazyYtXVMCEsGi6Njhmmhzb/gxlM1lSTSLG7/a5zMAl6MAFt7fCoBIEfUulBSEX9I2r5C6XUY0QuJgAdoQkSZeo6npVGqeoY2jBUdCeQHWieEjkW+xu5naAoLNkjLNbebZEouIGumAfHtn7huEvijW7YeWUId2A41ESyHU+Q4evS6VQB2jziq9ejVVTIvdk0FFncq7yCV7LJkb6VMUAT84AsFlzPxkeQwhtHWgRv9Q3okoBncWjIhPCYCs4CND03nD+zL0p4EKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Vx+zydAls6p9gMOo82cnv7LSTKv0LFYaU08FVmt3Xk=;
 b=FYSBPmL5xz+nbsmhK4Z5s08hpc5Y+SGD0kSkM2I28yHjVKuvIXlNtGUOUqst24qeSp7bRXsHSmpkb5EPjKagEYC/oH7QdUypnk9FSRLi+YXC1f2dk7iZrLuMQUSYVzG0/zU5CP6dGVamoDoCa/7rbVwVEWgrBL8lMeW85d/YqDg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6759.namprd10.prod.outlook.com (2603:10b6:208:42d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16; Wed, 11 Sep
 2024 19:33:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7982.003; Wed, 11 Sep 2024
 19:32:50 +0000
Message-ID: <f576816e-4302-4da5-9ab7-ee66d35c62a2@oracle.com>
Date: Wed, 11 Sep 2024 15:32:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: no hw_info for mediated devices
From: Steven Sistare <steven.sistare@oracle.com>
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
References: <1725990021-107183-1-git-send-email-steven.sistare@oracle.com>
 <73f10bc0-5e3f-412d-8e2a-44d013c4b7ba@oracle.com>
 <329e22e2-9cfe-4004-8b28-1aaff79ab350@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <329e22e2-9cfe-4004-8b28-1aaff79ab350@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:408:e4::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: b91a6435-e8e9-445c-cbf7-08dcd29885b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk0rSWlpaVhpbGhoRklKWUpic1ExMkw3cldOamlFeTBqZUNrS293dVlNTkpq?=
 =?utf-8?B?TGx6MzZxelRzYUZwK2Z4Rnl3ZklISCtRZ0pxc2VVKzZrVXJoRElrRjc3MVJV?=
 =?utf-8?B?eXRTWFhSL3R4SmJDellac242b2lIRmFIaU5ySFVocGo5QTVQMG5IL3VCcWNm?=
 =?utf-8?B?RXBlcVQ4U3ZNa3RHc0ZaWW14MEhWWkc1RkFRVzBBL0F1Uy85MzBHMEJEQzkv?=
 =?utf-8?B?UEFTd2ZVc3J1Q3V6c3puWkYxQloyMzFFSTM2akRIL0tSNHZQcWkrVHlqczRJ?=
 =?utf-8?B?MUt1eTNadEd0V0VFaW9pU2EyVmlQWkdFVGtST0JxekZ6dlk5bklJcEl6azd5?=
 =?utf-8?B?R29aM2Npa0xnOW4yc0lvUjAycW5ETlNqUU9VY3l0WDAvYnlDdUI3aHpkeUd1?=
 =?utf-8?B?SnViMlQ5bTVlK2tZY0c5K2RIOSs0NnpaWXBNWUo4M3VGbER0MGFlYW1GczZL?=
 =?utf-8?B?ekorS1RoQStwa0FtbDVVaGlLSGQyVThBV09OY0E4UnBFbndWbVh0Rnlaam1l?=
 =?utf-8?B?aWpPZ0oyekR2VVh6d21qZTFLcUpCZmZjMUZmOFYvT203WE1uRWxURmVXR3Qv?=
 =?utf-8?B?UUdqV0xyNGFPT2Z1cUhjK2RRbUR5RlNLV1dWWlpmTXhmcjV5a2tVTnpxNkpH?=
 =?utf-8?B?L3VBVUFIbHNXeXVpeGExN0tiWEJRNUFEaFFIdzd1Z2twaFY0aDdxQnBjWlYw?=
 =?utf-8?B?SmMrZmcwTVowZzZHTWs2RWhpTDlCMnVlUllrR0xBa0krZWpseHFGSHUwakg3?=
 =?utf-8?B?eXVycG5OSzNYT0loSjhKd2dxT2ZPYVhUOGszaU9RMjJaenlUVVJtNEhabmx4?=
 =?utf-8?B?Si9jS2NNNmlSYk9tU0ExNzNWRFB4c0hSQUFWY2grQmxTSDArbE5KUWNCbWVX?=
 =?utf-8?B?bC9HOE5uQ080SHBKZmxocVQrMytOeWxtSzdiN3BKKzJESEp0b2pOUlBWMXdO?=
 =?utf-8?B?c1d3ZkVaRFg3Q2M0M1RZN2syNXB4MmpFK2w0dHJIWTdseldsYWxMaVFqWkJn?=
 =?utf-8?B?RW9EYmlEYnNsSy9ZeTJzVFFsS1NxVUtRYkFkYldKVk1zaFV5VHNWazcrOVhs?=
 =?utf-8?B?ZGF5cmRsSnFockJ3dmhza21WQ001My9PVHFLczdXbk5PRzJlcitjbCtUSG1L?=
 =?utf-8?B?bkxKQVArcHVGV0FBTFBUallFYXdtdlU1SERBUUJBL01EMWJnbVE3aFN3SWY5?=
 =?utf-8?B?N25HSGtTbXFLSzgzcTVKZ2xMMjEzTmlNU0t6ckdDelIvTm5lTkt4cmgra2du?=
 =?utf-8?B?NEFqdElXdSt1NTRIOW5SOVkzZGlnWnNueVBOWlViSExDekdSYVV2N1BBM0xl?=
 =?utf-8?B?MVhqN0ZYd1dYNlMrcGE1K2RoUmJNelZ0UHdWV3BwWi9WcURGTm8zWEUzNXpa?=
 =?utf-8?B?L2l6R2N3aDhzOElneUtnQ05uSjlyaS8ybVFNQWFvOTQvdDlIajBBMEJMNDUx?=
 =?utf-8?B?TFlUT2JPZGUweFlNNW12Z0IxQldzYmRxQlcyY0YxSWtxUE53REpJenhKcmZi?=
 =?utf-8?B?ak9rRVRnMjE1Z1h3MTE2MlRrVG4zTmtjSEFwandUVTZNR0VJN1pLZ09xcFJ0?=
 =?utf-8?B?eWlkUmcwNHZWQ3A2TjNRTGdzSGFwOFRHQW9mdVcwR2dPbktMWjBHb0hUR2F2?=
 =?utf-8?B?eEFaOFZtaDRxTk5rN2tHc0Z1VHdPa2oxSlNOYUMyallBR1ZNYnl1bzlyNVd1?=
 =?utf-8?B?YXU1bm5kY2E4Nm1vNkY5MjJSUkFRa2s3Y1pCTENhQldvRis1MXpObWdtMjBZ?=
 =?utf-8?B?aFJCdzhCSkk1VXlUMUZNSCtiektZWkFpRk1TR0RPcTE5L0didzVZVDErYy91?=
 =?utf-8?B?Yk5mRWxsNmt6YTNNT1hsZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9QeWdiSC9NcGhYNlBJNGJqVzBPSXd4dkZ0QTJCTXovcHlva1dnVURTUFJO?=
 =?utf-8?B?M1RSbkdDd0dQSFNXL2pMdU12R0orYzIxZ3FyaXpSSWpITis5OWpkMzZFamNR?=
 =?utf-8?B?ZEVJaW5ZZHhoeHQ0MUJtYjVieTVsMjczN0ZYYVNuR0dwUmdiR3QzK0p1OGRT?=
 =?utf-8?B?TW9rUnVHeTFDWnVHVVNwbUFoL1BhSDdERjljaEpHQUtHR1VlZzVTZG9MY21l?=
 =?utf-8?B?YXUrRGE4UWlPaXhqR3BWbjl0RmZBcWlONlB1TzhsYm9EaXhhb2JpS0YvZlJu?=
 =?utf-8?B?QWhGdWduOGliMFo3UGRGd3E0L09od3FKMm9qRExWemVpRUhOa3dXd2ZLb3NP?=
 =?utf-8?B?b0YzZTN1OTNvM2FnWUlwdU91d2hlNlF4UTRwYk81bVZQWHlqNnN1cGZxRUxh?=
 =?utf-8?B?YUdlQ2VTK2pReTlGVGh3MkJWSU9uUDJuK3g3aTFiNFRkS1JhdHZLQWcvT2Fv?=
 =?utf-8?B?ejZTOEJPTVhsN3FtZ1JQQVhhbEZJWEZvZmRoTHkyK01EZGh1YTZtUUpsdEtK?=
 =?utf-8?B?azhORXRtUis0anlmS1g0SldJam13aWFlQ1pKSVFvVVo3aU9NRmNpTFRtTU5U?=
 =?utf-8?B?bjRZbDN5OThWMDhGTkI3SmpJNTMxdHZ2akpGVTE4cHd4UlB6L3BBeS9zSVdZ?=
 =?utf-8?B?YUwwcmVEd3E1Q0tMSHl5VTFTQUpRTHpOTWVsTG90MndLSDBnRHZ2OFNrNlh6?=
 =?utf-8?B?NmdQaUN4anYyZk5iUWhhVlhjSjJSMEJTSlMza2YyZ3FocTBhOWJKQlVSNnht?=
 =?utf-8?B?eGpHMkl1RG5UaVZLRmxaNzZCNFl2ZkR6c2hBWWU0ZXhsWGdxSkduaWllazF6?=
 =?utf-8?B?d1JIdjNzTU9wdnMxQTkzTldkenZ0MjBCZTR5L1FQaFVqMWJQcWk0Z0E0Y1FL?=
 =?utf-8?B?cTdKQmNqWmxFYS83UnhoVW0vdG1vbGhBUlltWmQxbGVuTmpPcHp2ZGFnRW43?=
 =?utf-8?B?WTcra3BWa0dwR3pIVnhPRG1jQ1FtQ3FYUEtkcStENXpQSkxnYmdEWEpXMTVh?=
 =?utf-8?B?SVh0QTI3dHdSazI2ZFBlSThZMklIaWNwaTc2NUtlNzlEUVRDY2R3bFRFbFpL?=
 =?utf-8?B?cmFVOExoN05uSzk2Z3F6L2x3VHJNNU5jUnROQVBGZUZncWdMNzlHdmpIcUxk?=
 =?utf-8?B?QW1ZYUk2MENIcmVuNlpvenVDcWlDNmY1RjhLZmhLVGJqdU1Vb1YwTjJMVnBU?=
 =?utf-8?B?dGtCc2o1bWNlQ2s4MWlyU25oalRlZTlvL1JrTlZPMlMzSk1kRGEvd0ZyYWYz?=
 =?utf-8?B?RDBlK056aTR3TG54SjYyMEpRUmJvT2NCWk9Vc3hFZU1xMXNuN0lUTlN5d05x?=
 =?utf-8?B?K2lPaURBNXdFYTk5eTRRbjRCZ2s5eWZZY2JZWEV5eEJrZFFHTFdWbW1VVXdi?=
 =?utf-8?B?ZmJ5NlMwcHdDb0tvbjFQT2FYU1ErL1IzUGU4RXNUM2g1bVlBYTRYeUg5Yk9q?=
 =?utf-8?B?ZEdtZHNhQU10VE94OWxjQWZia1QwQ0JFMDdDTjhKcUc0elM0T2xCeFZDSW9a?=
 =?utf-8?B?NGJCRm1LNlY1ZGpvcTA0WEVZQzkwaGdFampDRjFvYVRSVHBZSkpyOWpMUEZE?=
 =?utf-8?B?Rkt6MnpkZUJXenB0K0VzY2w4dDdveFhKVFRvWWZEcHRIYlc3cXg5V1J1c2tE?=
 =?utf-8?B?azVjSDNTVjhVVyszcHoxdWY4UThNRTBQNDQ5TExvNjFuWUZEWHk0SHRRYktQ?=
 =?utf-8?B?T1NwcW4wK05SUmZJVDZjeW5IclpqUUdjOUljcWhzYjNMeEQ2bDMvTGc3akNu?=
 =?utf-8?B?bE5pblI1Mk9yQnl4c0VURWFxU3F1TzQ4TFZFcnl3TC8wQ1RuOTA5SExkdUFT?=
 =?utf-8?B?dkZBdFpuTE5Pb3RvNnBPSDBnVy9xL0UvcWY2N1ZEOC9PS3RNQzhCTlJFV1p6?=
 =?utf-8?B?cTZjR1JucEZPTkdVTDhzaG9WZXdGRnpScGprczVyZE80YkpYSFAvNmNtNEV4?=
 =?utf-8?B?NWk1Y1pqUXdyN0xxRFFieUlhejFPQ0pWU3Z6RGsweWtwRGc0OVRIVTZjaWJN?=
 =?utf-8?B?b3hrM2NFaXBKUWxWcHI3dTFlNU5LTlpJakpaeWRkQzhxSFMyeTJLbkErbGQy?=
 =?utf-8?B?SG9zZ3dnWFBuZDJXelJJRFNhLytvdjR6ZUZHdnJxTU5KTGRqUGpyRGphZUc1?=
 =?utf-8?B?Skd4VjdPZ2ZQV0pKSm5kTUhrQzFGZkJKSER0NnRSVHlmRndDK2RYeUZKR1cv?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mG3p5JwoDb1yY0cx+H5gcTmUgBnPQ2zBU4StNcSTXYOm8QfQcKEak7xYMURYBLHQgFR+uMqNu7ANpA2RA1C3Z6hFrTHM9ODlYK1DtC1LAzgkfGyf5e0kgfUdK48uGrgU4O+y3UdAmvowuUmaBUoNUymGo6LGYLH/0FmpyXFkUSrOiP+x2fgQV0j/dstR3rQ5TmK1isABGQGmsTWa+LOrgegrLkczdfy2rAW+zLk2aV7t73mzgwK1R1l+sXlBJPjN6BwLCb6t/v2XUwDjMxPAT0KTT6TEKWTqRNLJOf4zTNV5DQY/RlfCYtn5QlQFGI5Wltkm557vqNa0PpjqNV8OlkcC0lPQVVmbFHh5GZcH8niRK9Cc/01WKOVYZVyETI8xqdKONlEWlM3n0e/M/sFSkywiAPeMuhY2K2loXn2kVbKxruekBsm/tBvMH5BuUKXpTTB1c184kK+sI7oO7eaDqO1EmekzKi2RMPM+7ygq5Bf1F2wapfdDt68nQwKpENQ3DsQtAfpnKhGHP/hHoY/Db6GZbmgmRD/kFip1yH3547Kxzp1CXfDDkOCQM6MgRcC8blY2bGUuXnViG+YQ2lWW+B4yQCOidBkNjdUbqwPRiBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91a6435-e8e9-445c-cbf7-08dcd29885b1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 19:32:50.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SukThcvOXWgfNuwO5hyAHfcMTdhUiSyGipa80118Mil15NDudMikbJhOJxtjeiVwvcgThTdBHTv6+vLRPjrm6wb/tWeikMdaE9mAIK/IHKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409110149
X-Proofpoint-ORIG-GUID: smH1LSrXPqNAs1ks9Ir8GH6W0VJkQa3w
X-Proofpoint-GUID: smH1LSrXPqNAs1ks9Ir8GH6W0VJkQa3w
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/10/2024 3:51 PM, Steven Sistare wrote:
> On 9/10/2024 3:29 PM, Joao Martins wrote:
>> On 10/09/2024 18:40, Steve Sistare wrote:
>>> IOMMU_GET_HW_INFO fails for a vfio mediated device (aka mdev), because
>>> the devid is associated with kernel type IOMMUFD_OBJ_ACCESS, not
>>> IOMMUFD_OBJ_DEVICE.  Assume IOMMU_HW_INFO_TYPE_NONE and proceed.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>>> ---
>>>   hw/vfio/iommufd.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index cb7257b..d8928d4 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -635,6 +635,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>                                         Error **errp)
>>>   {
>>> +    Error *err = NULL;
>>>       VFIODevice *vdev = opaque;
>>>       HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>       enum iommu_hw_info_type type;
>>> @@ -645,8 +646,9 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>       hiod->agent = opaque;
>>>       if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>> -                                         &type, &data, sizeof(data), errp)) {
>>> -        return false;
>>> +                                         &type, &data, sizeof(data), &err)) {
>>> +        warn_report_err(err);
>>> +        type = IOMMU_HW_INFO_TYPE_NONE;
>>>       }
>>>       hiod->name = g_strdup(vdev->name);
>>
>> At least we aren't supposed to call realize() on an mdev.
>>
>> See commit 9f17604195c ("vfio/iommufd: Don't initialize nor set a
>> HOST_IOMMU_DEVICE with mdev"). There's another refactor later on in commit
>> 83a4d596a93 ("vfio/{iommufd, container}: Invoke HostIOMMUDevice::realize()
>> during attach_device()") where we also don't realize() when vbasedev->hiod is NULL.
>>
>> Unless the stty mdevs aren't matching examples, then this shouldn't be possible
>> (I didn't have one with real hw behind to test).
>>
>> So if you are hitting this codepath then vbasedev::mdev is false, which I don't
>> understand how it's possible?
> 
> I exercised this with the mtty sample mdev, and mdev is true:
> 
> [...]
> 
> My qemu tree is a bit old, I will update and look for the issues you described.

After updating all is well without my patch, so I withdraw it, thanks.

- Steve

