Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B20DECD6D3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEfk-00013W-Rc; Wed, 11 Feb 2026 13:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vqEfk-00013J-1h
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:10:44 -0500
Received: from mail-westcentralusazon11010028.outbound.protection.outlook.com
 ([40.93.198.28] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vqEfh-0002XS-Ap
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 13:10:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc+p4j3d9Xdq24avXqZIxWjrgJ1oidzJwpMr/EBqx3YV4wgNLRkP2LfmuYJdh0PXZg2tjWWNfd/hkaI4ZO3tlkebq7lveAoprEp8LQg30+rIUZMDk7yvlMGQsEHnP7C5QTtYmgqXMANYfcRsPOBfQX0HkVFOknGaUrqEkD6YYSrekPSg2DrYXmeSWx8ZyIkEDk8pWhXNxVfOaovvY3u9C89hSNEOLqwR1aep64/1u3MK0kh2VywKkibJe8FBG3Z6qirHNKHlq8frxqwEcgVJKDTXyEqEXn7mnt5bUsNpQR7mg5Xhr3e/s6l9ICA1TZ5C7f7+CKgc/e2lIdrmOz7x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Umzj8Y9NPP9KodYDpQO07zLDTz5mo6IAZ1cqkUpiFI0=;
 b=IYWrhAeGz0gB8aTUWbljHH3vAFEjk0s4z73yFjXv0SmwX0tZMqWdOTywQ2kDWRjAorwccwDqvY6J4LmdSaYbacd0Rm5N8GnFzYhsu+c5fXBBKHD1YxjchXr5IS4qZ4PfE27dadJ7NbeUf6P00D4+xSX3dWyUXdRJluHYJlziAQ14r9yRmi41EHctFUM+0jz9q6hBANFtNLg038y1AO0utr0meagTk7FsZ4/PQas3bT3MQJ3ls4yqK29N33Z05rkpdK61zNxAbjRwBu3J8N48ZvG8IjUdWmxLcLIW0SP/HjhUm5X1YzCHS9miRH1G0PV8djMaaugsjUuj5J25+oWvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umzj8Y9NPP9KodYDpQO07zLDTz5mo6IAZ1cqkUpiFI0=;
 b=kIN8tFAAN8vqXRoCMNFJwYaHukB4IZOPig3K2VW4k2eV1hr5rKRo21EsCQ+CmZ5Kg3leywHwysdYRIpm/1fuqkS7C8W+idsTRXwATfPIlGYEUA+5EzKXylB5ous23/0N6kkwElq9xjxxJXbJLbKCpghQwYzTegIlUVBALweiRwxasDi4vGbENqTYSD/Scynnsi+NvN1RI2ZlxLGHWS1kTCx1m5Kc2uKE2aaZBHogwrEIJ+/WeMovQM08YTDa95Uqsb5tvrxH2SyW2lYyWff9UVNAbHJeUyHcALxMZ72zDxyPFZANZxLimMzd/JVzi17raSlrK0Jy+3Opy1X66ZivzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 18:05:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 18:05:28 +0000
Date: Wed, 11 Feb 2026 14:05:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: ankita@nvidia.com, vsethi@nvidia.com, skolothumtho@nvidia.com,
 alex@shazbot.org, aniketa@nvidia.com, cjia@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
 mochs@nvidia.com, kjaju@nvidia.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] hw/vfio: align mmap to power-of-2 of region size
 for hugepfnmap
Message-ID: <20260211180527.GB1218606@nvidia.com>
References: <20260211030615.3202-1-ankita@nvidia.com>
 <20260211030615.3202-3-ankita@nvidia.com>
 <7db83d35-eace-404e-a31b-fff1f6ddedf2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7db83d35-eace-404e-a31b-fff1f6ddedf2@redhat.com>
X-ClientProxiedBy: MN2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:c0::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d3368c-f0b9-4d11-8059-08de69982374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzV4ZkdEUFh4cFhXVDRYSVBYc2JQU0ZFZUdXdkRtQjZXMUI3bm51dWZOYjZ2?=
 =?utf-8?B?Yjg1NnNjNE9pQllvMnRDVGZjL0VkSHZibFh3dkZ2SlJzeGlGUDhYMTRLS2p6?=
 =?utf-8?B?eFpBbW96WmdMaFBDaEt5SWxKSnVKV2VIRUxiNVNucVBBbloxMkhxTm1KMmpG?=
 =?utf-8?B?M2tUSXBrOFI3Y284Y1lYdm85M0lRbmpVK01oSnVtV29FeXdSeTlLWnVMT3hm?=
 =?utf-8?B?WUt6NTlMYWNHTElzM1hYcmhFRjcra01GclhXNnN0Vmd3TkViWkpyamJBeUhS?=
 =?utf-8?B?ZjZiZnQzYWMxdEtzaWRjS0VONlNFeFNsaUxRUnNJamlSelJadmlUbHBkMU44?=
 =?utf-8?B?R1dDOFJKVVRqSHphL0Mza1k2UWdIYnI1NUN2MndlajNKd2lFdGp5UHllbHRm?=
 =?utf-8?B?dXhXNG5EaVN5OTRkdlMzVEd1TFJVNWtBQnFHYXFOeHlZRUtDRXBsYVZvMG5B?=
 =?utf-8?B?MnV2RjVtUFgyeEVlZTlJK1dNcnRlZXZsRHNtKzR1OFJkOS9SbzVoczE2Y1hV?=
 =?utf-8?B?bTFDOXNtUTFiZlp4Vzl0b21vQlZ2RUozenVVTHZZbVBUZjFjNEdrdkN6TDV4?=
 =?utf-8?B?emh4UUowVTMxR212QVArOHlZWWpRLzB1ZEtLc1FjeTBvQ2FJNmVUVkxBS043?=
 =?utf-8?B?bTU2R25PRVh5VkxCZUd4UCtVWW5SZVRmR0tSRmdhYWwzZ2hvekVGaTI2dVkz?=
 =?utf-8?B?N2pKU1ZSSFE2RUx0R3oxL2RVQmF6VDhwRExEdmo3RHJNOEhOUWJYTGxFTENw?=
 =?utf-8?B?dHFBajd4MGtHOGc3WnZ2bnhXK3lobHNzTmRUWGlxSXJxckRXRlIxMEtjbHJ0?=
 =?utf-8?B?emJKQW94NHh0QjFxaVI4dE5zb204NkU3OUNWMnNjeEc1Q0ZrN1VZVksrY1Vv?=
 =?utf-8?B?K1kyanBsQk1PNk13QThkYnFDODBQYXFXNUxlanBTQVl2VUVRSU1FdFFMTVND?=
 =?utf-8?B?VCszbDJXZ2orQjNqTGdGZTBMSksvUWhrUnM3dmYweW1XZFlGYUhLalRqUW8w?=
 =?utf-8?B?M0FGVkNoMzdFT29hS0RUbFU4cnNTR1liaVg3L0ZrV2ZDbDhYNVJDY0RINk1B?=
 =?utf-8?B?a3lYckRKTHR5Wm0yeVhWOW9OenF0eXVURkxkNHRYRTU0MkhNWlhETkNWYXRR?=
 =?utf-8?B?NzVTUVB3RGRZR1B5QzVKVndhK2JVcWpHZTlMRXhGQnhPb0REcjFBaFI5UnVq?=
 =?utf-8?B?WHJHUi9FZEhybWl1elFjM2V6QkRpeFZsTHdxRW1xSEI2Zkg0czZoQURGcTdh?=
 =?utf-8?B?aUZkTVA1TnpxbFZVR1BRTmJocHRQSHdKZkVoeEdGNVBRRUxvaXRuUmFBalJL?=
 =?utf-8?B?MVVnMktVeGJ6WEtoUzdlekJxc0Y4WlFneGxHV0Q1cFhyNjMrOWNpbS92V1lo?=
 =?utf-8?B?SS9HcnlEdmtObUFtNVJrUS9ZajJHTkpXMm0rQlNOc2hyNzcyUi9BcHhWUXE4?=
 =?utf-8?B?ZjI3U291a0Vmc1BTQ3dSK1dQcTVLQTUvRGVGeEtickV1ajcvZ240a2FHUEVY?=
 =?utf-8?B?SjZ0eGo5emdvRlZLNzhnZEpVL0xxY2FRTElEeG01eVUzdFZkdXhGNlRkNlJD?=
 =?utf-8?B?TWs1azhPUmpmcmZPZDRQOTZOd203NUFiMGVjWW0rc1grRjNURmZQRTZzM1hC?=
 =?utf-8?B?NjR4RDBKaFZUb2VnK2d4d01lWlJKaDFqMU5LMU5yZUl2ak0wMnVYYVpZOURI?=
 =?utf-8?B?N2pvVHI0QkpzWGJjUDBza1pwYWdUN1ZMZ2ZHamltSDBtYXdYN2hDNnBMRU8y?=
 =?utf-8?B?V3F6cXIreUEybmpJay9nYTlzdHFSV1d6WjRrendJOW9WTjIyZ1RtRjVIekpJ?=
 =?utf-8?B?RzNnRjlkVnQ4OGJIZHZ1Y1c3R0xGSnNCVzh4cnQ5ZmFJd3J3TWkvQjQ5bzFF?=
 =?utf-8?B?b2s5M3YxNjBuYXhod2NLdHFZSVpKTUY4Z043aW9yOHBNeEQrQkI4TThiNWdV?=
 =?utf-8?B?MkMwUWxzT2RESVhFckV1cGRLQ1ptWGJKY3VrMnlmNitON0YvbzQvYkpsa3N2?=
 =?utf-8?B?a3dKL1E1Z05rd2cwSkJ0Z0pLNDdHbXRMRkw4ajAzZ00xZnlPMXpZOXlYMEM4?=
 =?utf-8?B?Z3dpY0RjWjdlZndrMkluZ2ZOallIUWwwZFF6MnN6dTZjUy9tL1hxTm9IU056?=
 =?utf-8?Q?Uhlk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlJTjVkaDZBNEsyZUdCbGx2MFprUnFCN2pMRVJzZXBwQit1eEs4ekJwL2Vx?=
 =?utf-8?B?WlhEeEt6blZtOTNDa3RCUVZXMUxNNFJUcWczdEJoaThFNzFaOStSRGorbDF0?=
 =?utf-8?B?TWtLamt0dmthTjBhV0lxM2xOdEdtODJSY1Y1RnFZcDI0SnloNXhaWXZreTlz?=
 =?utf-8?B?KzVwVkw2R3RwbTFNcnFUaXFHblVjUjJlZ252cjNVZXV1c3A0T0cyRWVaTnpj?=
 =?utf-8?B?YnRkc3RDb1FzT1VWQi9kRFRzcE5HWjFidzRFVzNod0p3N0xncTlkckE1Uklr?=
 =?utf-8?B?ZDB6R3pzQ2prZFRZMFdLdkwvQU9BRnVndEdDeWhteVVCT2JRTWtYMmMrUFJL?=
 =?utf-8?B?cUk2UWNBMG44VUNud1V1eFNWNGNWVVpQYS80WXp1SWx2UjRKQldCeUhUNzgy?=
 =?utf-8?B?bVhHWGg0R0szNUU1K25PRXB4WkJIbzlkTGVacVVyVnMrRys4OUQrZEE0UzNP?=
 =?utf-8?B?K0xnb29wUVRzV0xsN1JMb1o5QU1RTWUzamRpZW5leDIxNEhyRjFaeGZEUkkz?=
 =?utf-8?B?VUdvdFVFaVVUOUVqWk9LbStmY1lQMTRXTTkxcUhoMkFLaERZczJTNU1Dc3Y4?=
 =?utf-8?B?MjdhNS9FcGxqS0FPMWhncUdZQ3d4a2JBc1ZMcEIvWFl0RHhuaVRzczZ5bGJr?=
 =?utf-8?B?NUFsLzNyWnpaMUllWDhGSFpMZXd1Ui9iS1VTMGhrK01QTCtlak1aZ1VjVU1k?=
 =?utf-8?B?MktVWE9tQ3BOSnVycVRsYTlCVmIzYUE0VlJWdGZQYUgyVDlYeFpEZk9hbUZX?=
 =?utf-8?B?OFNJOTlaNDhQR3ZFODk5YjhOQXJyRGRTNDkxWU93MUhRVUN1bExQQUpyY1BL?=
 =?utf-8?B?Q0RTMHlxMjhxMHFGNjlVQktUbUJaekVGVnNEQ25DemRSclpDK1NwMzhhcXlZ?=
 =?utf-8?B?bzNTWnJwMDJZMWVEMC9rUGF5NFpLSjh4U0prZFN3RnNxeHpEQ0xtb2ZtQTBu?=
 =?utf-8?B?dWorWEVPN1NSbFNXRXNubVJibk9yb0RQRisrZWF6bWhTd2NEUm9UV2RkMG13?=
 =?utf-8?B?Nk1IRFp3MktYdmR6QXRHR3hiQ2ZNQjAxUGlEM0hvTXo2MnpLZnlIUjNhOG9h?=
 =?utf-8?B?NzJVS1BueEJZVzNDQVI1dHcwOXB3NlRDZm90OFdGbWlock56Qk54NHZ0akJ0?=
 =?utf-8?B?SGl1a0hzUlRiVS9CVTJoUXVRZHV2VDhrRjBrU2VpazA0a2pyUEYwQnl0NmQw?=
 =?utf-8?B?bjJHVDV0U2JRZHYvUWhnTUh0OWpNczZVTVA0TzRmdTI3S2FsNW9EajkwbTZX?=
 =?utf-8?B?QmdGY09tOVlQQXdlY2hob05IN2RSdzRSVHA2OU1wUGp4S3F2OUtiUXF0WjRR?=
 =?utf-8?B?dkxaYmU5YWNLc29mMm9aTVNqSW4wQkV5Lzl0enBySEFKVUJ5NHhTN0N1MG1Z?=
 =?utf-8?B?TmttamRrdWMwMnNMdVFsWFJSbVdrYUczUWJJK2pWRi96UjdEeEJ5M25RdGZo?=
 =?utf-8?B?Njh3cTlPUjVYWmJGK09tTU1KYW5XcW1SWWtNaHhMNmNIWmtyOFpHRTMzTlBu?=
 =?utf-8?B?Y0lQSlBsQkNIb1EvNHUvdlRGU1JXaHhaVmhvZlpOdzJHVHRWUWU3RUppaHhq?=
 =?utf-8?B?YVIwRWd2OEZLdjdjSXZqZkk5WW5qY0lVWmhWNUlieDZ6c1QzU3E5dm5STW0y?=
 =?utf-8?B?Q3pxSWNQVzV1Z2tqc1pNeVVsb3o4VnVRR0VVSENGZEFaQXZUOFY0d2RSNDNI?=
 =?utf-8?B?Y0JRZ3RzZEkwNXRJM3lsVkJadkN5dWlEbkFzaURHMzV0dnhrL09RUTBqZnBn?=
 =?utf-8?B?YlBueDZEUzVMeTRLR1ZVZit0L0lVWHJHem9LOXl6akVVZlo3SGtmWDZmR2p3?=
 =?utf-8?B?amNxaTdmeFF1K3d4TEx2UW1KMmRydUhsR2FXQ09YL0tPdzM5TjlFcjA3Wmda?=
 =?utf-8?B?aCtmUDBoanNjTWtCdGZ3OGorNkRYejBmUEgyQy9yZXRFTkZPN2UzQm9CQi8z?=
 =?utf-8?B?dzNOVWk3eXVJckc0VmxYSFNXNnU3d1JmeW1XcHFDczZqS2t5RkhVZmFlMFBm?=
 =?utf-8?B?cnd4SGFFNElHRFJPVElGT1g3TjNUcVRHaDl0U3JZbVJ4Nm15SE92WmVqMnZo?=
 =?utf-8?B?ckFWa0pFa0RmZ1lZbFNMVFFjdnhmQ3Q0a1lVcUNIdThyNjEzbGFzWVR5NWlJ?=
 =?utf-8?B?Wk04SXlwY3loNjBINHZJVnlIdUdybU9tTExNRXJZY21DNTFuZXlDUWhjb3dT?=
 =?utf-8?B?bG1tQW9pYlhtdlRPbDczUkNuUmZVT0NoOVFqRlBFR2xvc1hrazl2MTRNdGVF?=
 =?utf-8?B?aHNkQlE0c2Y4eDFNRVVWOUZjdkx2SVJZakJaeHA2ZHlvMkEyR3lRUFZCellp?=
 =?utf-8?B?Vm9iRmhnU2swdHVtRVpod0pKeHh4cW90RmhxcHExNUk2MUtSd082dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d3368c-f0b9-4d11-8059-08de69982374
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:05:28.6651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvpfrWZxnp27axsHT079A7R/peCWqQnBvaaAay24TqqIRNvF03xn5it88pJXqGFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
Received-SPF: permerror client-ip=40.93.198.28; envelope-from=jgg@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 11, 2026 at 06:58:11PM +0100, Cédric Le Goater wrote:
> On 2/11/26 04:06, ankita@nvidia.com wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>
> > 
> > On Grace-based systems such as GB200, device memory is exposed as a
> > BAR but the actual mappable size is not power-of-2 aligned. The
> > previous algorithm aligned each sparse mmap area based on its
> > individual size using ctz64() which prevented efficient huge page
> > usage by the kernel.
> > 
> > Adjust VFIO region mapping alignment to use the next power-of-2 of
> > the total region size and place the sparse subregions at their
> > appropriate offset. This provides better opportunities to get huge
> > alignment allowing the kernel to use larger page sizes for the VMA.
> > 
> > This enables the use of PMD-level huge pages which can significantly
> > improve memory access performance and reduce TLB pressure for large
> > device memory regions.
> 
> 
> Could you share some figures regarding the startup time of the guest
> for example ?

I suspect it doesn't make a huge difference as with the new dmabuf
flow we don't have to fault the VMA to startup the guest..

The primary purpose here is to get the right page sizes into the KVM
S2 because small pages have a significant negative impact on guest TLB
performance. KVM can only use the PTE size in the host VMA.

Jason

