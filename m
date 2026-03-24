Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C652BF54ACF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54Xt-0007Th-Bw; Tue, 24 Mar 2026 12:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w54Xh-0007Sh-1b
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:23:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w54Xe-0002vD-G6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:23:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCCEDU1157363; Tue, 24 Mar 2026 16:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=GNz7ZRyCNTqN69YeaCh88SMzd/FoHggWn5NuhArH3Sk=; b=
 rqIf6RZegJpGZ66RJNa3q7r4zGEhYlW1/ONusQdA03mheBWrpwSP6poNyURsoa5G
 sUFZ4oc8J5kfsVlTSZ7sfY0zO7PsBo4SytgzzdTOCq0FffHeZ2BfiirkI6V9FjAZ
 vY1aGAt9xgvIiTqRPdsC3T9R0u/CRDM/gK+z1usrlvZ7KR7qs5ssQDf9DOQEM0te
 DL8khZg9xEEeiXlrM57eCZ2LIin7heygFK9dG1RAxcDmfa0bIfSr0/BjIGWuRhsX
 kOJ1rx2JnWTBJZHPY4zZgYnwKG8vpi0Xa/1cV+uapC0KEbWDkKrwr3U5J/Cl5bUk
 qc2LzSorb4wtHp/KF0hCRQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfmkf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 16:23:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62OEoTfP012374; Tue, 24 Mar 2026 16:23:21 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hsg6uem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 16:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2+2MbDJluBizevJB0eriamL28VYT4fdomnmK/hcb9eaYUWT8Z2Tkn44vsB6NZ6u5CfRl3gf3Efw5KGTyEnR3TmdtyVDzArEESLRSu3UN+LVchM4BW31Abs7ulN2Ww4b5iu6txYi3A77nr/B2ZqvXbo5gBp10z9Gzl5p9XQKIpwjVZFGcu9cohXxnxq35SD0VwJOScfjpo0Gm0gAhYastpOF9wNgiQaI9IwHwN4BbWw0xo7pcSnlALhVqJmEcRmTYpEYd6VnobxtJgsG0hs4B56mdJEsxUdljlJxr0KJ8cUQBS5fyLL+tt2eEl5EZBem4E57lGjZaSw2InJ5LogO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNz7ZRyCNTqN69YeaCh88SMzd/FoHggWn5NuhArH3Sk=;
 b=TusUXtkSuia6w+66I+7YZ/j4xCNc4woXWnIAqOMc03OBwJJxDETJyBt5zeAr1hKRvjojErIBFOarGvbla671/+oEaNWzcHoPc5rSQLJFgx2vY/mvAfuLq1ouXxbKg1sGdtH5wReGoCmrdReZgI9vYOpQ01fxFWMVnR1mE0GGWcX85xKWC2Gri52ffKaSGLZ5u5Lg3Eo57quBd7c2xe6eHeOMXkHbtxLzFSulNg4eBMdu2hDe7n/1Xefk71J7f2bfLA/KLV73IuZBggBapfihzC51jpk4nHPTVHK+P0/9bM/QgaltL2j6KdntZ/ltm/dVnOYt35obtLns9c30TVQBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNz7ZRyCNTqN69YeaCh88SMzd/FoHggWn5NuhArH3Sk=;
 b=iKpIGhQxhWN2p+Drg8y6kOagbKkbL1h2eD5Cz/SrPxY/WUSNTLFApOZis7qfVkLDKdWmyw9knnpszKL9FFu1+VZxke0h4XENeiRlTGR94WoGgWMK/24qzfqJj7IX1j2XnUrpMd0vpp48gvw8zb8drzsGKrsXMlx6PxnDtQJQzZk=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by DS0PR10MB7522.namprd10.prod.outlook.com (2603:10b6:8:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:23:18 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:23:18 +0000
Message-ID: <32947c99-004e-4c6f-9e9b-abf50f52813f@oracle.com>
Date: Tue, 24 Mar 2026 12:23:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 08/14] virtio-net: detect VirtIONet status mid-migration
 change
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-9-jonah.palmer@oracle.com>
 <CAJaqyWebEJN0GL=5yotWcF=48FW6r2yO+q21ZZ-7DeawbTNocQ@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWebEJN0GL=5yotWcF=48FW6r2yO+q21ZZ-7DeawbTNocQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:930:d1::10) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|DS0PR10MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b9a865-0cc4-4d19-4a9f-08de89c1a88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bR8jQSFqs6AhEusBUSkMUs3Lk7lKf5foy2ff+Oghye5AcrgihAs5/ej9OvJa7P8egE4yJOHf2QTW6rGwqnw1pi2oMIJzGj6yCWcrrPeAEmH8eKi0R0t5yreCuzjQqtChS+SZSoLVT4wSHvMpmzsvuCoysac8iwDX+4TQfpwXw8CE/J0kuMex1LTIqY+8P3zUl4GqwqyqTvtvjEWXk0YlN7Bdbmi+ohS3JSlMbvNHQyKUWxkzUFf4QmGizEdwyc7N/mHI0fR0UQXBeAvcV0Kgnjz3gr+LmqY3ATu8eYdxBSOFfsOJBT+ujaTe3DeHbac+EmID4uKZWJLSK8/ktA2N5KAJ0dBbx7gCJqsLv0JMEXm9IX3HUk5vbkrO6WHbAhjfTK+RlJ7FlH7Xkm8iEw3Y0OIXWGckJD9dbXCF+/KmC3VxZckPV7gzRlqncCaavVXdZ5vlKRhCTuWtoACntlo5836WVZ84/ubxgqn5jIRufYbefYnx9EoYjejzwzDRy3J9PfMpI3f+87tQnGGPjSQ20pjN9Q8uGOikhIxFYuFmUa++tm0V4SNNb3d8lWiUDG1gvTusLCcD0DTTRqMNB3nmNWUZa8MuRXHUearBVjGZcfzdmQbneO6dQhY2CG+4lxiUqhbEZeCN2QegeJHpv4j6vUhmz5cQpAytGgw48jKDYtHhD2smzhyx1EwzeZ7eiWQZBpEKQaVKe9Y7EkpSp7D3NUXSJ0Qlp73jEFydmGP+0xE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNMMTcvenAxR1Q4WnkxaHFMcjdGYmpFNlZIUUc2Y1JSZUo4REZBOTE1Y1Vh?=
 =?utf-8?B?R3I0TzRGM3dNaVJXdDMrSVFoUTJaaDNxUlRnQXZjU1NjQXBJR08wOUVVMGpL?=
 =?utf-8?B?NllYdk5ETkQ3aXpRMnMzbkFVQlcwTVh2ODd0d2N5WFU2VXhuQjhXcTZHZ0Zh?=
 =?utf-8?B?d1kwM0FFRjhqSk9kaWlzU3lweVBieWo4YndrcU1hTXRqeW5ZQWhQRjlMa3k0?=
 =?utf-8?B?Y2tXamxMcnlPbnRzZitkc0dkR01wN3JqZkw4ejNhb2RqUyt4MDZ3WUdUb051?=
 =?utf-8?B?K0VLRWlPWGdod2JtUEJnMnUwZFpydVN0Wjk4N0pNUnh4dkYzRFNVN1FQcG5E?=
 =?utf-8?B?emtmaVdCd2ZoTlhqWWZTQUUyaTdxd0RCL01EZ3RlQndWSVUzbCt5SE42NEk2?=
 =?utf-8?B?NVZESGlsZWQ0dmlUanBZUVc3QzlCTHo1VzM2YW5vUlFQQ1lUNWQ2M0I5MFJH?=
 =?utf-8?B?enhzbW9OanhGbkw5WDVQeDhNZWRzaUhtOWJEMThMK2owODhPMlNDaXRuQmw0?=
 =?utf-8?B?c1o5VU1sdW9LK01VelI1MEhsQ3ZjSWVwRmZkcEFaVkpFbUlQMXNBeVlHK3lw?=
 =?utf-8?B?OGt2RkhNSEtXSVRYeE9qZWFZR3FINm9GbUhpekMzTlZsQ3VrME1zK1RhTDM1?=
 =?utf-8?B?WHdyNG1UWE1nZjAvak91RFlpVXFJQjBYZmpnc2UvbE5xcloyd3Z2ejZHbG5y?=
 =?utf-8?B?Yjk0aDNxSzdwMmJVODZVU1liVVR6allqbWx3cXV4T1VCWjgxZUd6Uk5XS0p0?=
 =?utf-8?B?aE52MmxJbU9vY21Cc1RucUVZbUF2Wk5YK28xQXNGS3FXSWd2bnRNRlNQdjdj?=
 =?utf-8?B?UDNMblQ5NGtTRXNPcEFobk4rTjFkblVtZDUzOEJXNTdOY1ZQejg4dnc5SWNZ?=
 =?utf-8?B?NEFwUVREWlJMWitRQkg4Yis2MTlIbC9aVTRJcnB2S2hKYXQwS2VQSlBaVURK?=
 =?utf-8?B?TXgrN2M4aCs5eEp3WDMzZFhVSUdYRU1mNUhrbVpwTzVpQWJzTld6eTNFaXEw?=
 =?utf-8?B?blBoczFmMmVNZWJrL1NERGcvMFBPMnptMTBnaFgzeTZ3dTFkR3Jrb3N2Lzlm?=
 =?utf-8?B?UmZYbFVXUi9XTktzMEJicWgybHVlTW44MGhaVnBKMGM5eXJpRkVsMnk0TTh6?=
 =?utf-8?B?QUFiM3FrSWRDMkN3aURxcVg3UVdzSWV1YXNTa05jMU1OWmozdGE4V1p6R1dI?=
 =?utf-8?B?enZYQi9lSGdmTEJleFBVZXE3b2NSL2lxSnZGUzJ3ZXhLOHFKdVVaUHZHVi80?=
 =?utf-8?B?SVVTVDNHVU51YnJYb0duOSsraTVzcWkrakt5SWtkT1FFWDdUK0xDS29qeDV2?=
 =?utf-8?B?NmJRZ2RZYlo4cjQ2c0JVK2lyWGVvM29nQlVScU1CSG0wQ3ArSTJBQ1dqME9K?=
 =?utf-8?B?U0xDWWdaQnNVQzlRdEZYUzdYMzNlbDJOQjFKeHhtYi9KWDREVi8xN3hKT21N?=
 =?utf-8?B?dW04TW12V0hBMmdyVWZOK0lVc2cyajBlN1FHN2NDUklKS3RPZGxZNnFDc3RW?=
 =?utf-8?B?OEpsNkxIcFlTN3JqZmVxWmVZUWFiLzZXUzdZY2xzeGUzaGFaa0tnUWFDVU5G?=
 =?utf-8?B?NTRiZ1lqTVpZaDM3bzVmZlNFc1BJRWN6QUJRelpJQzJwMG1TNXlDRGE3My8z?=
 =?utf-8?B?ZzE1OWg5d3cwT3ZqY2hYTHZjdWxVdTFOSmFSSGRZT1pzY1ZwL2tpNnZ5V0t0?=
 =?utf-8?B?UlIvaXFMaFFtZXNvQWdRZlpvM3FVVXRZaE8xQ2pNK0FhdlBDWlVNbzdCYlc3?=
 =?utf-8?B?Nmg1eHB3czR1NVpaZDB6eCtiOXVoaW1UUFRBUkl6K2I3UG5aUzkyR3p5MG5a?=
 =?utf-8?B?VHNpT0tCcVllSjZXNjhSQ2RicENqL1RuOHNlbU5jQ0FlTUFoYnVlNloySy9R?=
 =?utf-8?B?L3R3VjVpVHVmYUZCMnVOSC9IY3hoZTFRUGZpQkhERWRNVHRCN2ZnWHFJNENj?=
 =?utf-8?B?cnFVUXpzK0hSSUNLeGxVbDFKN1k0MStrek5HOUpZaldlZXdqeVBCTFpKaE5m?=
 =?utf-8?B?UlJRL3gzUTl5MG9wNXNDaWFqa2N5UVFES0swSW5VYzJMY3RjdE5ZZTNobmJx?=
 =?utf-8?B?blZjU0wvbmVOVCtUY0FoNjJyU2FIem1zTlNIUm04NzlJcGw0TVVSaGZKVmo4?=
 =?utf-8?B?bWdXSmo2SjNCNSsvbGV0NW5MOEZDdUxnM1RNcWI1b2VSRTFGRllnbUdzOEMy?=
 =?utf-8?B?UVU3Zis5SDMxMDFHTDBiL0VtSG1reTlOT25DYWNuRkJDLzJZREhDUk13Z2hr?=
 =?utf-8?B?akxqOURNSjBZUUg2MjRwYTlYMHN4dDM4WnJzNFpoTGZDVkRoVkFscWkxdFR5?=
 =?utf-8?B?V0liTHhGVDA1Z0dzSW5RSTlWRE8wYjJ5WEN4QzA4dkVOUlRIM2Z2UT09?=
X-Exchange-RoutingPolicyChecked: I/WB26Gh0WVl9JYRCrgdX/rUHwTzLVOTgM3/I2k/3z3kO1QqX7h/0x6MEK4WGoEPmAy52JSImvnF8ghavFQHJTlegYGShqw5JMnIZ9t7Sl0Q+G8t2GAcEHDnuX+RW41kRUKft7qJhi07sN0jXUFD+5Gl760MB/4wrbQQ4Ttl9PWPwsVcXeckTWatKAcPMZx0USFm4pCdI/TVZi7n7aKCCwhmjmUIxeoU77hV/SrGguNgNue6BB66+0iXxe604spicuK6o6FVHDm+88AM7gkGtIF9yWlq04vs0CrVlrEsz3LslN6lxCQXyLxsN8zhtaVeyKPWG4iRlwQA1nW6jRoWmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4AzQzHGYslIbHtX/Zp+FaRnr2l+FierH22mugqjU21Ns3kqb00lV8NOG7+E/AAV1vahKwUL4grxHOOgtK+TdwR+3UP9RWPxIL13uAMAh5VX6sGiN8kupqHgYcgDhhmvDS7JGBbFYowZV2+Px/G3Y6HVgcUx/Y4vyY/nMhu2wuV43gYX16IkzeFRJVuuEm+1Gh0YxPEznWx7xbOkVrLrYWSnAn1HNUVt4st5gMOnDkf8DZM5WSQaZxm+3ENekjLjJxTDa7cvbWV59bE0YdPvuXChMYaLceSAAux6JFRRh5y5vRqHSJkf5bt2OfC7fN6VZAUDMJgnPGTVyvmgkTEeAssgWQvBfDGV6DI038fywJxqlW6kChI+QWPRcSxOLvP4JSxOfoCGO1qPaV3+YzXldyK9FWV9MA+0Zep6mpWdEIC8CbjJuYNsahRwtFldJ97NcJxa3mN7OQPMlcKYl2oRPjWSFfkyDfn0U20AP6GP1iAQ7DiyGgGY9B1TJs6nSbjctlNbBf7V6RNWdpR/LlrWKRUbuRkhlHK2r8sDEM4FZdOjHza6I5uYo20m1dJVpG7ZPAxN0ajKops7HNlNczrPyh1yDxViQcBXrATt44YeZTkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b9a865-0cc4-4d19-4a9f-08de89c1a88e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:23:18.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7Hbh6/Yvz41NNE7bIdr2ybkZc9nvtK8RyNvzpdR62wT4s8gHstR921HSaj62t3mPyFwgVt1NB/qtojZ2a8cBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEyNyBTYWx0ZWRfXxumV43gtmOUI
 PAw8el6pV7YSWtvYw0ceCnicWpwxyyHlHwd5B6clKkt+eB7qHBVJEu3z1EOo48ojKoocjgkhpQr
 0bM+HQwEuyeTUoLEnBQ8CGszXSBBUcA9cs+pmEiUMExezg9fTTi71TYQcM/RVBbSN+YDpp9SXv/
 JqeMKV1lvHpdyO22gIJjoCwEBChoa6Q9IZ2H88t2IoQOLuInYVo4gL7dl2ehjShAn/u9Azg42RV
 O9RhMbdvyvE6Y2BdfwE82MBCnxYlbndQJAZtiFXhvwttFC4New5vUQDVEBFB7OAJ0TK8n1gmGYq
 xlClJWDJGmb60TdtvMpLFCjjBlV2VjReQEWxKUqVuZRrTn3mZekuJVlDjBeDNxKTcNqRyha8KmZ
 cB5xqLigVvM2DlDi8WyWO9PqQSQn4RJsCzc0/zJBRbBMi2LF3aWwYJSn8xWS7HSEzTwepN+M3UJ
 zCR+udsc07ALYfXODqGr6sFhzTS7UlIs0i0feifs=
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c2ba7a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=TrxJptTvz8vbOFjcR2MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-ORIG-GUID: j-W7-nYL3O7McmvLrmIM58lEzrjVj_wc
X-Proofpoint-GUID: j-W7-nYL3O7McmvLrmIM58lEzrjVj_wc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/24/26 7:26 AM, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 3:21 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Save VirtIONet's status field during early migration and compare it
>> again during stop-and-copy.
>>
>> VirtIONet keeps its own status bits here, including VIRTIO_NET_S_LINK_UP
>> and VIRTIO_NET_S_ANNOUNCE.
>>
> 
> These are particular to the device, so we don't need to migrate them.
> If any, we should check if the destination device changed the link
> state so we can update the guest, but we don't do that as far as I
> know.
> 

Sorry I might be misunderstanding something, but isn't VirtIONet's 
status member being migrated today (vmstate_virtio_net_device)?

>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c            | 6 ++++++
>>   include/hw/virtio/virtio-net.h | 2 ++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 2dd130777e..88ce33b1d2 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3872,6 +3872,7 @@ static int virtio_net_early_pre_save(void *opaque)
>>       VirtIONetMigration *vnet_mig = n->migration;
>>
>>       vdev_mig->status_early = vdev->status;
>> +    vnet_mig->status_early = n->status;
>>
>>       /* VirtIODevice config buffer snapshot */
>>       g_free(vdev_mig->config_early);
>> @@ -4304,6 +4305,11 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>>           return true;
>>       }
>>
>> +    /* Has the VirtIONet's status changed? */
>> +    if (n->status != vnet_mig->status_early) {
>> +        return true;
>> +    }
>> +
>>       /* Has the VirtIONet's MAC info changed? */
>>       if (memcmp(n->mac, vnet_mig->mac_early, ETH_ALEN) != 0) {
>>           return true;
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index 1e1f1a3995..59345f1811 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -169,6 +169,7 @@ typedef struct VirtIONetQueue {
>>
>>   /**
>>    * struct VirtIONetMigration - VirtIONet migration structure
>> + * @status_early: VirtIONet status snapshot.
>>    * @mac_early: MAC address early migration snapshot.
>>    * @mtable_in_use_early: In-use MAC table entries.
>>    * @mtable_uni_overflow_early: Unicast overflow MAC table entries.
>> @@ -176,6 +177,7 @@ typedef struct VirtIONetQueue {
>>    * @mtable_macs_early: MAC table entries.
>>    */
>>   typedef struct VirtIONetMigration {
>> +    uint16_t status_early;
>>       uint8_t mac_early[ETH_ALEN];
>>       uint32_t mtable_in_use_early;
>>       uint8_t mtable_uni_overflow_early;
>> --
>> 2.51.0
>>
> 


