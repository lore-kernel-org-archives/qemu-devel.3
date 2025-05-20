Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF0C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNCJ-0001gi-7J; Tue, 20 May 2025 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNCD-0001fx-U5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:39:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNC9-0001mE-IE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:39:53 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDMM7b009860;
 Tue, 20 May 2025 13:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=r51/MlJsFENycj28x4hM6hcvW1mojL4Xft5Duzv+lsQ=; b=
 O697BtRnT1jSjzawnpWWHtMCeW8JkLQ6LvZRRr4GG7LelTWYsPBBsCJ7aROwMJdj
 h3o+w+mLQfGGJhoYzEn74SEV1nglGwuTBF7INa0B8z2Oy+z2DnNMr4uslbltEWx0
 XOSkafr+eSS18XdeyAfbYQgsuJmRqe0jjrmHatXcjdq/Tsumu30kblVloAuzNQH5
 McYyblzpyugxkZv8h5F0A8a4mAFlBolz2pTj8I7bWYn58/xbSbxNRnlcV7p1waXO
 OP1b3P4QShiIbZJGec6Mya+l3+6XzhNp9j68y+v2vywlMTmdaAJheLWnGfmi7mi6
 RquksqVY4jcDx8vLppqUKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rtjcg1d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:39:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KCMjC5028870; Tue, 20 May 2025 13:39:41 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw80jqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/nJiiycFsgshwwZS1KEJWK/xoMf2awjnkKMHuCR3tlgqNsgMZB+5FEIO5e5vzeJM3wY6+5pxWKomN/XUsiQL0hm5IVAaxSM+6MjVIjuguRlYAY/WThXJFbL7vxsWGaCAK8KKliIaBaY7JuV/IbT2hdqrQb5gE2OqyhgTOyjAAcVOA+ZUXEd1XHw8nMxcDhPk3os6s3EsoVQ7ypoRfC6p0YzxRWkUjUkTQpqYyfnV427jgx9RlVGRixmFXvl7PO4VTK8zZOYOTT8VsV9BgUMn+t91B5pfgW0lNP1LW+C4kL0gCiri/ecBoH2jt9Q3/K9fN9guCE3o3giLTCC7TO8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r51/MlJsFENycj28x4hM6hcvW1mojL4Xft5Duzv+lsQ=;
 b=uoVaZrUJN/ZTP/SmIj+embsEx1OjAx+O1Ck/++qsLUDCyiqPsmFUgc5/c1rH/w3F72Wl1PUsKqhhzIjL9KDI2kNf6t/knSIcqgduc2ShvVxqeoJgIkzbo5pAQ2XQlyJp5HCbPq32aZF0soltEFw3IjLNIZL8cfL7aM60V2PRbShLIbSTL4pZE0Fo+J1AyO2cpWud/Y2fsl260CKKhVVYrJfBbkZhm5+yaMFg7v+l++r/8W1jlqH+NCMVFIx5ke2wxGSKfYlf89mqCuTXJFaXRq8mi8y9+qITfYEgci4cxkOgST206XTJMSr9oKUEVvWqpzbHs2XU6+yJUkBm4oHdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r51/MlJsFENycj28x4hM6hcvW1mojL4Xft5Duzv+lsQ=;
 b=Z0z+ScEl+0DVzJZaLfXAceYoNTfg1/OvNivLi7VoPvBYy68g/B4b8Nu9Q3w1n4YwsAeU0A647LUVmz3oBYwAlfEXYMWK84DNBKFEhmSYV7VK6Kht7hy0adDP//xoAcwiGacoej+v/zvODUcpjxHFppf4/nJwWdWpe1KkT1536mE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 20 May
 2025 13:39:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:39:38 +0000
Message-ID: <c3430e52-396e-47c6-9946-6a1fe78dfbe7@oracle.com>
Date: Tue, 20 May 2025 09:39:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/42] vfio/container: recover from unmap-all-vaddr
 failure
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-13-git-send-email-steven.sistare@oracle.com>
 <af8772de-5469-4736-99cd-ec917a855aac@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <af8772de-5469-4736-99cd-ec917a855aac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb266d1-2f68-4a2c-a3b8-08dd97a3c459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0FrVytWZmFVVTA5enRpQlVHNDFwUVQ4T2ZvSnNrejN0MWpPdExTUXJEc0Ft?=
 =?utf-8?B?RTFSZ05mald6Unc2ZVB6azZqY25ZNEtVSllvdElobUo5cUF4UzU2NUErZFZu?=
 =?utf-8?B?Vit5T0I3Mi9zYmxlc28rb2x5eFdTRk9pVUVubndFc1crOEUxSkNZalpOV0NK?=
 =?utf-8?B?NXIrTVp4S2lmY3F6d1BBVmpZY25HeVNhQ0xDTGtITzhIeERrN1BlcU5UTmFP?=
 =?utf-8?B?Y1JNZkVjdHpMTnNmenhWUTBlSkl5d1ZCOWZibmdicVdVSXBBZTVla3ZGMzBW?=
 =?utf-8?B?WFI4N3ljTGdwVFpNbmNidWNGaDAweFRySFc4SEM0a2pIQVl2Z2ppTFBiWTVG?=
 =?utf-8?B?bG8yRWlJa1B5ZHNuS1NRRmJYVjhVamhhZWJFdE9CVEFoVTNCR0lLakpPUDc4?=
 =?utf-8?B?MjVEY3dKNnpzWVQ5SHBMSy9OZVlUMkxwdUwyQkdJK3E3MFJ5Nk85TWVSTnNw?=
 =?utf-8?B?QVA1UWx0MWJLRXNQVjIvUWQxbkYxREgySHFGbXpkekJTQ1pkVXlHckY1Z2Qx?=
 =?utf-8?B?YzljL3BGb1RGd1gvcWRXdzFiMk0wSm11dnFkWXFVc2hWSzd4T1FuM1VuOVdu?=
 =?utf-8?B?T2RTcEVKekp0N0tRV0YyQjM2YUlUa0E0UitxWnVFdm8zRlNNMzljMVgxT3Iz?=
 =?utf-8?B?SFlkNDAvbXc4SFJoM3h3aVYxQ0FScm5rQjJ3NllCdWNwYy9zRzZkT1ltWUgw?=
 =?utf-8?B?bzlPd2J1bTkzQjNTSmY2VStyRVo2NmN2ck5nUWo3ZCt4cHVvNlVkKzh0d0kv?=
 =?utf-8?B?WTc2eWFPenYwTlhqeHFUVHRtMkdDTXZKR0taZzUrd1dGVk5HbnpTcVlpNmlE?=
 =?utf-8?B?elhYTWJBdFVkNkw5WTRUQXF4NGtnYXdsMXNnNHJWN055cnh5RzZpdXpUZUpa?=
 =?utf-8?B?UVh2ZTVDbG1BQjJlcHAvMWMyaWc4ZEIzRXVKNkhOL2kxMERrVWFvK0RaU3hN?=
 =?utf-8?B?b21MaEJHaVBNbE1Ib2F6Y29CRVpncWUyeDVBN1Z4TTFNV2pBdzQ0OW4vUU52?=
 =?utf-8?B?VFZHakJTQkNVUmNFTWgzamtNaDJiTGNSL3FlMWo2TUhMUjhXODF4cnl6YU9Y?=
 =?utf-8?B?UnpIN1FoNFZSZGNRN0MwYkRDNG95cmppbEYrUzlsTFltR3RMUXFwTlNQdWxw?=
 =?utf-8?B?cC9INHZaTXhORzh5UG9OVGtQbUsyTm1Ja0Q0d1ByT3BQQzFVbjhoNURCVXYz?=
 =?utf-8?B?T294N1dpcVl2ZkxCM3ExazJ6THRQYVBoV2VSQVpKZnM5MGhRdGJtanNlSUE5?=
 =?utf-8?B?K0R5cVc0Z1g2YzFta0c4UUJrRnB4UGVmeW41cTc3L1hCOVR3SmpvanQ4Z1NY?=
 =?utf-8?B?UzBGREdGVW1QZVYrKzVhL3d0ZUVHeU1nQjJldjJBTjUvTjcxTWhkd2JIcHhW?=
 =?utf-8?B?RTNMSzdMQjBqamdLcVY0T1ZLczA0dzVETlovclJjWFNxSU5udEE0Mks2Y0tQ?=
 =?utf-8?B?UFZycjl3WDRUWU1FalVBcFhtOEdydzl6eHVPRmg4eVRmK0lhLzZ1YUVaUmov?=
 =?utf-8?B?VkdOSU5XSEZkaXFkZnBScngyd3kwWmdFSXdMNUxCZEhZMjNONTljL0Z2NklX?=
 =?utf-8?B?eG9ZZUNZUUR6djJLSjBDSHlhY3FuVUNiSkhuVkkrK1pGWjB0SjBQV1hBOE1n?=
 =?utf-8?B?YnRUNStCOTN2eHRPcUdkZ0pXeHZpVWc2UHZyMi91bG1pZzRPM04yVkp6R0VW?=
 =?utf-8?B?NGJZR1E1bTByVWVxSUdWbVVmSnNseXFOUUFBTm5KYm9rTyt6MnhBVDB6aEJG?=
 =?utf-8?B?NmZrdzVwWDhwS3pNVGpWVWgvK0JWSkorRjhLZDVCQ0JoOHEzeWRZRkY4QnNn?=
 =?utf-8?B?Y2FMb1ZTVjJjNnN6QTMzM0FjZmRlT2dQWkRyWGpaZ3NCVHZFTjZMcUk2RjBN?=
 =?utf-8?B?VjJJemFST1dUNUtNR2ZwZE9YV1pzQ3F1elM0TlM3a2p6aFY0cEx2eFhETDJ3?=
 =?utf-8?Q?Q345p5/UPN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE5MNUhreDhQQkpVaVM3ZUhidUU4K2hiL1ZpNDhMR1grS2xKRjl1eno1WnFj?=
 =?utf-8?B?K1Y4N1JzTy9kWHRZRkE3aXNpeWJDdDFEZCs2dm4yWHhWdExCREJzMVZyZlA3?=
 =?utf-8?B?c0phZmZKR3V3STFVM0YzdmxtaUdJR2ZmL1ZrZmJhRktQZlZMY3BCc0FZWDUy?=
 =?utf-8?B?KzIyQXlWVEpoMllDRXJIaElSNmQyVml1U2ZJV1RNTGhoVTBENmp4bC9JTVBZ?=
 =?utf-8?B?QWc5U0tJTzgxOWVHUEFsbEpaMjFPcFgxRVRmYlM5Y0NPYmZKM280S3pDQ1VL?=
 =?utf-8?B?cVJwNGhmWmsxTjI3bkpFclhyREx5T1NaaDgzSzVncWNuL2M2S0xQbHYxWnpJ?=
 =?utf-8?B?ZUpub0cxTWl4WVJFNWxGWkc1ZmZqaVE2MkgzbFRwRDYxYnlNOHFYRVNpcHcr?=
 =?utf-8?B?d052anFkRm8rZVpOZ3NRNGUrVDRiVjhtOVFTQ0VpTm9LR0Q0bDRtT1ZiWGIw?=
 =?utf-8?B?aSsza0xNN0V3R1BmeG1SR1A0blV1SFd0Rnd1MjVGUERnSFVKaHE0K2paRFJo?=
 =?utf-8?B?LzhaMm1NNXZtZW5zUlFjTExETFRUTDJzUnlMb0EyUWpMQjdVTmxrK1IvajJU?=
 =?utf-8?B?M25zVWcrM1B4QnkxaDB5Nlp5ZFVNTzZ3Q0laclJ0YkpCc3dxY3pqOURmVFQv?=
 =?utf-8?B?L1k1Vk56OWJmRzFGOE8wY2tJZlhYTXAzb1pPejhaVWNUdC9MVitiZU5PcVBy?=
 =?utf-8?B?dXFaM05YZEZ5RXZNRmVnSUU4VmQyNWRDZDB6aWc0dk90WE0wVGhmVVdyVkx0?=
 =?utf-8?B?V0Q0MnVFUk9vYmcxWVpwNnNDOW5RajNxcHZrL0RSUWFWL0Q4TVhTRS91Nzdl?=
 =?utf-8?B?VHlBbFRxclN1YnpkelJwY1lEQmhNeVN0Tk8wQ1M2NExFQ2JFZWt6Y004VUYx?=
 =?utf-8?B?VVlTaEFScmRQVzZQNnpQbmJnT3JvT3p6Q202dlo4cjV2anVwN3BZbFd6Y2Rv?=
 =?utf-8?B?bmFLek1rSEZTcHBJeDM5QWRjeHBDa0VGc0pJYzkyajhsY0lLdmovbWsrY2ZJ?=
 =?utf-8?B?YWNsdmxyYWZWSHQ2WTQ0c0xCdk1DaDZnNElpWGpHUHdvaWlhQzdaVldTemZu?=
 =?utf-8?B?dVhiR3FXWUpQYjlJZUdpSjBFdFNLZ2V3OGNkRVk3ZlVXMmxsNy83bVFVMDdZ?=
 =?utf-8?B?Q3lpOUxQdkFvZ2NPTG1LcS9aQm56SE9HRjdtVkM2K2dmRFpZcDdscXFhMjhl?=
 =?utf-8?B?VlVqZlJ6RHhPYU8xdk42dXl4R29BYnpVWmNsQ0I0UUx3UGxaQlRXci9PVUxp?=
 =?utf-8?B?c0xEdzhIR3c5bHdVV253WGlOMFYwSUNyUkNHbll5RzJaWmQ5ZlczUnE0Rm5Q?=
 =?utf-8?B?bzBJVWJYQnNyOFJ2TTAyZE1EQnNmMGVsME1ZRGFtR2RoWlQ5dlB1SmYydHR3?=
 =?utf-8?B?KzZjcGxJaTZQdm03czJ2T2VTbG5sb1M4SEVxZnA5Zk1tS1h4ZnVMME5CQSsz?=
 =?utf-8?B?STU2MlpmZWhWeGJaY1M5MUIxSEtTdDBJTHkvcGgyMFFYT2plbmtoems2dEli?=
 =?utf-8?B?ajJQdFVnbTJwZVJJUHFtVU1rckhJTUxQcU1JcGJINTZSK2NpU2g1WGNUWTB6?=
 =?utf-8?B?akdKQU5CRytvb3dDRU1NYVNPaVVMWTJDYWJXcjFlUlN0dW9xK093eHo1WWFC?=
 =?utf-8?B?SzZQdTNLdDZKM0k5bXp0MmpGbFZFL21IOHluRWkrU2thdlVWNTY2eTZ1cU1i?=
 =?utf-8?B?Q3JwRjlGTHluN0VseFVQYmlFWUR1TjRiWE9iODI3eTZER3JWSDN5K0ljTjVi?=
 =?utf-8?B?aVBod3ZvdE9JWkptd0VpUXduT3RTV2cvSzV5K1BhbHdqSFJ2cGIzOG9JbHdR?=
 =?utf-8?B?VENzSktQQmZlUTZPY2NUcmpJdllZb0x1aFhrMmZhNUJmeTR1T3RsUTRnWXRu?=
 =?utf-8?B?ZVp0V2lHcTFzRWR0TkhMSUI0OVBHQ29wTFZUbFRwQkw4dHZ2MEtmbmVBME9j?=
 =?utf-8?B?bUNkOXR4dnBnRlpYUmwzaUhpK05vTzVuT3FiVlRXSmZTZUNxVEZWb3B4ZjFX?=
 =?utf-8?B?ekNPQU41ellVQzZmYzJJcjdMVGxYQ2d0MlB3RVNnTDMyUS9CVWZUSUdnVElm?=
 =?utf-8?B?cHpkQVRtSUVkWUxSUmMwWU1nRi9OQUgwMGMrM2p5Rm9GcThPOUo5R0JmUzIy?=
 =?utf-8?B?ZmNRSTFzR2M3U1JXSHdUOUFETGFzQkxOTUU3Um1sK3h5YUhrbkNEZWJDRDJR?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jI9QT0vRRuRyW9oFxiCUBB03zkFWzEasFRD3MkZEhRM/zbbpL1QtqtN/634fvabbU/Ju5EzZUPlZME2wqAwaDgn2itGe6nkgNEF5o+WMAZbzSog42biEDhAD4y8cyz7WOE9DkILAxT9wexotq/AbVnv7ig9dZ98OZSzIXkmUsVs+A00D+FCeaOgNT8F6UvfqQLgSv6RwrFcWQyyjLg6/mLzDj2ekAeVSIhmMZtnEn2iiFruKlMbz4s5MyaC0VVXluBLXIFMyZA8ZUc8mU9+rYM3WGqVfTIXaGt4+Cct+4s3cHJmihobt9W3HdSQKvDZAqH+ApCsLuHb0Ag3JzGrfVFG4+QoLPWwJLa5Ry+qUpBoggUYWcwDDeafIr6VcE8txhwS7SUfIbYn7gWtGFcmr6AXAq98ld2hGEpsiJhsPEo4WLrAaNrJBh99IIBMwyKgw9p8KI9OkTD6vvP0iJod1P4O5nrly2GTMcXgygcwekenBnQTH2SErpzTUZYbpu76rORhQ615qbHsKnWT82nsGvP/Dzg/diWKxR+LofrP37dX1rG/i2WPWDQ61jbuRZmTUfPSHzu/eHqFtPvMDiniO3y4PvM0yuX37aSj68gWER5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb266d1-2f68-4a2c-a3b8-08dd97a3c459
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:39:38.7804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nORk3HlU6SvRjxxeSQP3CivPWvzrbXKOjbrK2yGCWvysyQNHUTDjebIbFT7EEu6R69CKdZw5Yot0YjaP0hQzxbf+eTrhUflr0e299uD3RKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200109
X-Proofpoint-ORIG-GUID: QHDGGHGWH7yf0ZYSsUnIpSRFX28abnQW
X-Authority-Analysis: v=2.4 cv=GK4IEvNK c=1 sm=1 tr=0 ts=682c861e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QNj-AsWLWpcPGpgAMz0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QHDGGHGWH7yf0ZYSsUnIpSRFX28abnQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwOSBTYWx0ZWRfX/zwp3lOBPgTg
 poVlNDpPT9Xx2nTb1fQqjFretGtLoXOY9c5NbL2qA87Nq06BjnVpl3Fz6JvRjMQ69iMKlrcpv83
 6dgf8oDDHIeEU7bXqkTvZq9d49ipViTTLHdVBpPABk3K6BmAikk6zx2XC/A5BInT0vNO58B10ta
 qcRO7bAXFCtCA6y+Vaqwj/Cs1wZavua1mQjCQGKUXN4XKpNHEZ+FXFMCMUQttuTnGYMFGl7tmuu
 5pIaHCXCR+Zcwo1cjzPYbjouND2vdy76kszvZdltzhk51od2woxgxZc1yd312fhPQEyEIVLyy2u
 unVuyn6xgZTRySyKlQcwsUDzr5Jp7qfQ/9NOIt1g9rbdxdtaBnJi+OrK8qjyBhAITdajgFWswX3
 kzc45t6X1E0DbjvK3uQ82AJDidp0BM7dKBngvtf/uLBY6Nc3Ab7zf0ahpUf5N8tzCtqvHQam
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

On 5/20/2025 2:29 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> If there are multiple containers and unmap-all fails for some container, we
>> need to remap vaddr for the other containers for which unmap-all succeeded.
>> Recover by walking all address ranges of all containers to restore the vaddr
>> for each.  Do so by invoking the vfio listener callback, and passing a new
>> "remap" flag that tells it to restore a mapping without re-allocating new
>> userland data structures.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++++++++++
>>   hw/vfio/listener.c                    | 19 +++++++-
>>   include/hw/vfio/vfio-container-base.h |  3 ++
>>   include/hw/vfio/vfio-cpr.h            | 10 ++++
>>   4 files changed, 122 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index bbcf71e..f8ddf78 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -31,6 +31,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>           error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
>>           return false;
>>       }
>> +    container->cpr.vaddr_unmapped = true;
>>       return true;
>>   }
>> @@ -63,6 +64,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>>       return 0;
>>   }
>> +static void vfio_region_remap(MemoryListener *listener,
>> +                              MemoryRegionSection *section)
>> +{
>> +    VFIOContainer *container = container_of(listener, VFIOContainer,
>> +                                            cpr.remap_listener);
>> +    vfio_container_region_add(&container->bcontainer, section, true);
>> +}
>> +
>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>   {
>>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>> @@ -131,6 +140,40 @@ static const VMStateDescription vfio_container_vmstate = {
>>       }
>>   };
>> +static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>> +                                  MigrationEvent *e, Error **errp)
>> +{
>> +    VFIOContainer *container =
>> +        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
>> +        return 0;
>> +    }
>> +
>> +    if (container->cpr.vaddr_unmapped) {
>> +        /*
>> +         * Force a call to vfio_region_remap for each mapped section by
>> +         * temporarily registering a listener, and temporarily diverting
>> +         * dma_map to vfio_legacy_cpr_dma_map.  The latter restores vaddr.
>> +         */
>> +
>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
>> +
>> +        container->cpr.remap_listener = (MemoryListener) {
>> +            .name = "vfio cpr recover",
>> +            .region_add = vfio_region_remap
>> +        };
>> +        memory_listener_register(&container->cpr.remap_listener,
>> +                                 bcontainer->space->as);
>> +        memory_listener_unregister(&container->cpr.remap_listener);
>> +        container->cpr.vaddr_unmapped = false;
>> +        vioc->dma_map = vfio_legacy_dma_map;
>> +    }
>> +    return 0;
>> +}
>> +
>>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>   {
>>       VFIOContainerBase *bcontainer = &container->bcontainer;
>> @@ -152,6 +195,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>           VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>>       }
>> +
>> +    migration_add_notifier_mode(&container->cpr.transfer_notifier,
>> +                                vfio_cpr_fail_notifier,
>> +                                MIG_MODE_CPR_TRANSFER);
>>       return true;
>>   }
>> @@ -162,6 +209,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>       migrate_del_blocker(&container->cpr.blocker);
>>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>> +    migration_remove_notifier(&container->cpr.transfer_notifier);
>> +}
>> +
>> +/*
>> + * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
>> + * succeeding for others, so the latter have lost their vaddr.  Call this
>> + * to restore vaddr for a section with a giommu.
>> + *
>> + * The giommu already exists.  Find it and replay it, which calls
>> + * vfio_legacy_cpr_dma_map further down the stack.
>> + */
>> +void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
>> +                           MemoryRegionSection *section)
>> +{
>> +    VFIOGuestIOMMU *giommu = NULL;
>> +    hwaddr as_offset = section->offset_within_address_space;
>> +    hwaddr iommu_offset = as_offset - section->offset_within_region;
>> +
>> +    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>> +        if (giommu->iommu_mr == IOMMU_MEMORY_REGION(section->mr) &&
>> +            giommu->iommu_offset == iommu_offset) {
>> +            break;
>> +        }
>> +    }
>> +    g_assert(giommu);
>> +    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
>> +}
>> +
>> +/*
>> + * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
>> + * succeeding for others, so the latter have lost their vaddr.  Call this
>> + * to restore vaddr for a section with a RamDiscardManager.
>> + *
>> + * The ram discard listener already exists.  Call its populate function
>> + * directly, which calls vfio_legacy_cpr_dma_map.
>> + */
>> +bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
>> +                                            MemoryRegionSection *section)
>> +{
>> +    VFIORamDiscardListener *vrdl =
>> +        vfio_find_ram_discard_listener(bcontainer, section);
>> +
>> +    g_assert(vrdl);
>> +    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
>>   }
>>   static bool same_device(int fd1, int fd2)
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 5642d04..e86ffcf 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -474,6 +474,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>   {
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>> +    vfio_container_region_add(bcontainer, section, false);
>> +}
>> +
>> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
>> +                               MemoryRegionSection *section,
>> +                               bool cpr_remap)
>> +{
>>       hwaddr iova, end;
>>       Int128 llend, llsize;
>>       void *vaddr;
>> @@ -509,6 +516,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>           int iommu_idx;
>>           trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
>> +
>> +        if (cpr_remap) {
>> +            vfio_cpr_giommu_remap(bcontainer, section);
>> +        }
>> +
>>           /*
>>            * FIXME: For VFIO iommu types which have KVM acceleration to
>>            * avoid bouncing all map/unmaps through qemu this way, this
>> @@ -551,7 +563,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>        * about changes.
>>        */
>>       if (memory_region_has_ram_discard_manager(section->mr)) {
>> -        vfio_ram_discard_register_listener(bcontainer, section);
>> +        if (!cpr_remap) {
>> +            vfio_ram_discard_register_listener(bcontainer, section);
>> +        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
>> +                                                           section)) {
>> +            goto fail;
>> +        }
>>           return;
>>       }
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index a2f6c3a..5776fd7 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -189,4 +189,7 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
>>   int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                           ram_addr_t size, void *vaddr, bool readonly);
>> +void vfio_container_region_add(VFIOContainerBase *bcontainer,
>> +                               MemoryRegionSection *section, bool cpr_remap);
>> +
>>   #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 0fc7ab2..d6d22f2 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -10,10 +10,14 @@
>>   #define HW_VFIO_VFIO_CPR_H
>>   #include "migration/misc.h"
>> +#include "system/memory.h"
>>   typedef struct VFIOContainerCPR {
>>       Error *blocker;
>>       bool reused;
>> +    bool vaddr_unmapped;
>> +    NotifierWithReturn transfer_notifier;
>> +    MemoryListener remap_listener;
>>   } VFIOContainerCPR;
>>   typedef struct VFIODeviceCPR {
>> @@ -39,4 +43,10 @@ void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>   bool vfio_cpr_container_match(struct VFIOContainer *container,
>>                                 struct VFIOGroup *group, int *fd);
>> +void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>> +                           MemoryRegionSection *section);
>> +
>> +bool vfio_cpr_ram_discard_register_listener(
>> +    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>> +
>>   #endif /* HW_VFIO_VFIO_CPR_H */
> 
> Please add to your .gitconfig :
> 
> [diff]
>      orderFile = /path/to/qemu/scripts/git.orderfile

Cool, thanks for the tip - steve

> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.

