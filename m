Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAFDC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txREa-0005Hs-0S; Wed, 26 Mar 2025 09:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrgalaxy@nvidia.com>)
 id 1txREY-0005Hc-2i
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:55:54 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com
 ([40.107.243.79] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrgalaxy@nvidia.com>)
 id 1txREV-0002t8-3V
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:55:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKHgpS2GKaea4jqT/Pc2AI2H+KDTM3BMaEE3o27XCUjexMDuVoVCUI5MC1puq3RSKprC5z5H1jaJF3XeVZgfc73EAvgRVd9c5mH8QqxLANkdpNf4iHSmcT2DWuW7JIJyMu2cEt2ribm6Kk7YNzyQ3bFU+W7hlW8rx2IzDac/vwUWvwMmfEaTPye0lR0MBbUH3yQYF3NV5He3o8nOroSHr+c73X9DlXG8JGOlhGkIxmZr1EgokYdGAI0WROb9wfdh2L+EqjlN6LXycl2EDClXyGuG8Y8Q25BzjS5qFYDrEb6ev94sKxXv8bJ+20nHkR2U0XsWu2hY105bEwmtyxLuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax5lFX139BPk9d3S7TTDm6jMba2cHRIDiR+xdzgQcB0=;
 b=rZrZ0b7wNeXyVbA6wDwyY+TFCNp1Jpv5aCZ2+H5QEGAHMSI262cA6LEngHylHRKX/j0bJHv3tUG7Zxhu18Pj+d4mkbbo7gSUAPTDAdcvFzMoCb1NFD31GONivarNI09fTib6TmDTNSnZN+gHC7AemJPkQ3OiPEmX/Q+y5gh16Wydwg25DAIQ2C55sUlxgdwb5QMRk7jjDr3fVSrOiRiAjhGYDwJpEpwnlYntN9YOyorwim3OxaONqxYOAV+LVFWNr6441pdS0e3W/75BvYNnQoe0CVsVUlIGjfNxmQ0QizNC5CFAET43tFRaEmtFH3MI+xipct2wIanoIPvqc3pYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax5lFX139BPk9d3S7TTDm6jMba2cHRIDiR+xdzgQcB0=;
 b=eBfLmLOuK1mfo/DqtFq8hlg/BzTGnq5fQTijzNzKeh/MQpNPDguJR0Bx5xNzH+ZFwCk64xQ67NON2C+k+aF0UOYVocTs3d+jM4FeATAEjmKyoPjPhI75jkYZdCcfUXnpGOy3ljMY/HdnrN09tm03oZF7MhCrkp8QgkwY4AxtE7+2/ZQH6iI0nJ5sQ8xcOrJHLZrnMiIfegLuZ5T2u4OIxerlM19V7xBPeq5DBBfN4L77dka0poQgeHM03UWqlS8yvCNmBwEWAD1WH63V15i4uuRYKnUDwZ/8HFeovlDG5YOcCIJ9VAIkzz14xWmlKOwuka1j5Bl0lnSEjajXOfXgMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 13:50:43 +0000
Received: from SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::a6ca:bfb2:4cbe:12b]) by SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::a6ca:bfb2:4cbe:12b%7]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 13:50:43 +0000
Content-Type: multipart/alternative;
 boundary="------------Pyf644Y1Nk0FsbWa84RwlokL"
Message-ID: <7ab8fd8b-7a75-45ae-9a07-b682f577c245@nvidia.com>
Date: Wed, 26 Mar 2025 08:50:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: michael@flatgalaxy.com, Jack Wang <jinpu.wang@ionos.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peterx@redhat.com
Cc: Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org
References: <20250326095224.9918-1-jinpu.wang@ionos.com>
 <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
Content-Language: en-US
From: "Michael R. Galaxy" <mrgalaxy@nvidia.com>
In-Reply-To: <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To SA1PR12MB9004.namprd12.prod.outlook.com
 (2603:10b6:806:388::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9004:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad17e2f-9c89-4b35-5c8a-08dd6c6d33e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M25yck5mc20zV1Zta3oweXBFdnZ3TzNSclJSNDgvbTkva29HbzVsVURSRmlS?=
 =?utf-8?B?dUVUZFNEbmNPMk5XYTBNOGg0dVFYWVNIQ3AxZ1MyVkVDS1h2RERGVWplSE9G?=
 =?utf-8?B?TGtST3hrQlZBZFFndWhyR1F2Y3NXbHFMZXZvb3dSVVYzd0FteEhPTXNxbXFK?=
 =?utf-8?B?ZWxWYWYweEFKL1IyY2hZaC9nSUZEWmlpY3lEck5aYlRLMmk3UTFSRXNsaGxj?=
 =?utf-8?B?emZEN25jdHVMREdqbXRGNkdLVkpHcGdWV1VhaFlOamR5eDBTSFJZYVBpUWU0?=
 =?utf-8?B?OVNQQVBLb0NKYXBQSStIckdxc25CR3M1YjlydXlqcmJqTmJGbTdOcEkzYWtP?=
 =?utf-8?B?TDRjVWQ1ZjVqalNkY056dm96Ykh6RnY0NGxNMzd2TEQvdm15bksyRWNEekRD?=
 =?utf-8?B?WUdxR0VWZkJJemV0VGpaRGppcFBZU1UydTFSVmNnUUNVd3pacEl0VFJjWEY0?=
 =?utf-8?B?ek9Oc3F5NzRPMERqRExqZHlnWGNTUm84UndhSitwanl2bC9XWEwzbjhxTEoy?=
 =?utf-8?B?amRQUUtUUlVLQ1E2Y3hBVGZWaUpScFBvYkNhQWlMelNMaXNkdjFpYjJBZ1R6?=
 =?utf-8?B?TnNTUmFjSVdKR1Zab244dThiYWtab0tqNlVVckUyNVlpWHR0enlRc0I1cS8w?=
 =?utf-8?B?R2FvQThraDMzUzJxeHg0VkFKV2kzdkF1cnB1Z3dzVzZlSXFYVGJVbjhtV1M3?=
 =?utf-8?B?SnFUdDdxTE54WUdDUUNRSXpNdTU3L3EvOENOL0R1dXplQ0JGWmNQQWd6cnRQ?=
 =?utf-8?B?RHR0WEdYRVROQ1B3MDRQTWxvUHhFb09hckRtbmFLNXRDenIvaGJnUjlPcVpQ?=
 =?utf-8?B?djdvM0ZDZ0dBajVTRVRLMENOb0pqVGZmS3JFMmZJcXkzWmZrVXlsc2tJYjNP?=
 =?utf-8?B?aEZadWY5bzU2YUY3VFN2Wmk5Tlg4QTZEb3lSa3h6RnZFUmdEMXUvV25STXVV?=
 =?utf-8?B?eERQbDdzWkgvNm4rZ2FHTFFkZitCY1k3eURuY2xuaDlLTFFNK2owaVFsYnVM?=
 =?utf-8?B?WVdLUkpxMUZEZWxqUkNCN0U5WC81NlRNVnZMNWY2bVhPbHZTQUdFMHlqR3Bi?=
 =?utf-8?B?bHp2ZDZpN3ZsQmszek81TENKSnhDMmpjYS9vby94bk5OU0xiM3BMTXZVeFJF?=
 =?utf-8?B?RHY0Nm50S1NPVTNtUTFwd0kraURVVzVWajkzTUpGMXJjSDRuaSs2ZmlKMHpZ?=
 =?utf-8?B?aXFnVy85dFgrRFN1Nk5yUUhoQkVvSGdvTCtIVy9UblArR3NHZDZIMUh2VXU2?=
 =?utf-8?B?akFWUWNYcjk0UEViVGJybGoraTd3azBnRU0vQWRLSkVhRjhIOWk4emNJWVg4?=
 =?utf-8?B?WG56clNzQmxtQmlvRFhmaFNHMDhDTmpvZTBYM2lwZkxBZGlBK05lUDBxYk9u?=
 =?utf-8?B?NnFSdzB3eFhDcmpnaDc5ZnpHc05GVHRHamxuRUEvYzBDT3F5RGdTWlpIbi9T?=
 =?utf-8?B?UkJQQ2NNc3Iva0JNTVNIWS9ERStmeW01VGJiek9xbVBtSVlqVE5uRCtnVTM0?=
 =?utf-8?B?MDI2V1pqKzFJdmFNd0dyZ0pJUlNGTG9OeWRvVlJkS3o4OG95TEdlMTdmeDhI?=
 =?utf-8?B?bWUrWVF4Umt1Z0ZxZ1RmSHFjZXM2QVAxbzhUOU5ybE0xVk0xTWFWWVh4RUFV?=
 =?utf-8?B?V0xnS05lRENCZTRYTDFIeldDSFB0bHQ0Y3hsa2xHS2VGdVBQRzRyYmN4aVMv?=
 =?utf-8?B?ekU5VWJSL2tjTGpHUXlNQWRxdW9zV0FnYjJyd0xDcGFrbGhRajNFZ3p3aVRj?=
 =?utf-8?B?aUh0cU9FU0h0b2VmYUZtbHh6U29zTGNUNDJzR2haOHkzRmpxUytBRjlIQmpF?=
 =?utf-8?B?OXZiZUQyOHJ5QWc3cDU3azAzZkhibGFQWllLeTJsc1JxSGNDNEl6Z2p5R3R6?=
 =?utf-8?Q?NzB5a32vYx2W0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpjZTd0dWQzVERSc1h4dW1wdHVGMDRTZ3VYWDU2S09aYSsvQ1lhS2ttcDBx?=
 =?utf-8?B?dmw3QzR3VnJ3bktzN09SdjdOaWhJTnZqdHBMQ2dRYU00L1hBTSs5Ui9lSEZx?=
 =?utf-8?B?cHlpZElGTVZETnNGUGM2TGRBblFuOEZ6bjJvc3NGTjlJR3hVb2ROcTlSaEdv?=
 =?utf-8?B?a0VBdC9zK1ZpRExHRGxuaXpoSitNTkRXT1JNbks0QVZVc3gvQVZIUTVmSUE4?=
 =?utf-8?B?aE5YdFUwZVhxZjgxelpGWlFFNVFBa1ZZRmVLakFFSFc3Nisvb2dNZnFwbVpI?=
 =?utf-8?B?czRadE1GM0lFOUxCRU00OVRuUEx4Z2JZYm5yNUJXcjVkSVZiQW83QVh5TzY1?=
 =?utf-8?B?eWtTajM4MVJLOG9iRmZkKzc4eGw1b1FKMDhwcWRieVdwclJ5Q0VjUiszT2E5?=
 =?utf-8?B?MGNaSWgweks2dmNIdHYwMDh4dEZnaFJpQlZDT1lnQTJIeE9FeFg3akFvNExO?=
 =?utf-8?B?SE50WHFWVklscGpabExTMEFtbXFCeFh0cTlYbElKS0pWSWRvVGoxcE1mb2t5?=
 =?utf-8?B?WFBJOGx0NlUrU1pyMUN1T3ZOMHU0RE1SaUxBRjZENll6UmlZZXNHMlJLck5i?=
 =?utf-8?B?ZVE2YlpHWWV4NTVXUWRKa3lJb2dVd0xuRTdaZ1krRW5zamNWUVEyUENBdTdZ?=
 =?utf-8?B?UTBmVzNBRGk0akJIWnJOc3huNTZEbGRPcE9KTDdteUNSaWs5Vk90VnppMUU5?=
 =?utf-8?B?c05jbXp5QytPZ2JxYmF3THBKaGRua1VhOXdKeFhHVjloRStzZjBlN3ZkMFFn?=
 =?utf-8?B?dkNpblNmaTQxOTlKQmIzZ0ZXNHpvQXhrZkU1TWJpQUtCTC9SSnNkZTdPeGdC?=
 =?utf-8?B?TnpPUVgyemh3akFZU01COVhWdmJHNnZsUWU0Yzg3dUU5TnF2VFJrMldQZTFF?=
 =?utf-8?B?TnFPYndkaW1pSU5jQzdCamliaFhpdzM1dUZHcUdEMzFIRVFzbExjY1UrQ2d2?=
 =?utf-8?B?ZStCeisySlhrRnlRYnE4K1FmcjJ3L1V1V1NHWHFlSU82QVgySHRoUWh5QWh4?=
 =?utf-8?B?Z1FNeG5kT2hzS1BjZGx4dkNTdXBzT1BKRzNXeks2azlLbWVESEhQN25UUnA4?=
 =?utf-8?B?NGY1dTZEcUhDVy90M0VzdE5VcXZJNlVyZFh4SzV2Q3RnSXBSSzBVZGFoUEdL?=
 =?utf-8?B?bDBUMUdjcFh0ZXFSMk5XdWdQZ1lZcUoyQVN5dXpTQ2wzS1F4aVpXdDBGRWFi?=
 =?utf-8?B?UkJmRUw0VGtXVjFNZWhCWCtHWlIrQ2VITllLTGNNbGk5TmR5WkV1TDZzQTlZ?=
 =?utf-8?B?R01oSUliNTRIQXN6dUFvR2g5MlBzbVFCMjFndDQxZTh0K3I1WTJhbFdBWUtV?=
 =?utf-8?B?Tk5RN21SUFE4cmsvQ3lFOEhNUHpvQmR2aW5DWXBzS1R3WFNUUTZySFU4WnB4?=
 =?utf-8?B?WnZjeU5MOVFmS0pDc1lwTDVUNHZTdnNSbUkwVHVrZERmazU4Q1llNjRXSHp6?=
 =?utf-8?B?dURHMjBMUTl5T01mL0NzWFhOOHBUVStqMWs1K3NRSnF6YmMvU0lLK3hyZmdv?=
 =?utf-8?B?M1dpWU1JajFPOThOZnBFV2hIWlZ2VitFaUs2bE5ReVR2bGFCcXFvdDNweFl3?=
 =?utf-8?B?WWtzU3d0b2NwS3k2WmdiV1E0TVpUMnhHVUUzdVZDSXZWa0RhMHZHSlBHcCtu?=
 =?utf-8?B?KzkwSkh5Z3VIczdFcm5NZ2ZSdzZuNFhYWFVCNjRwenZ4YURFWDMwMlNiYlND?=
 =?utf-8?B?Y3lUdDIvVXdSWWdZWTVIaGRsVFlMYlM4cVBJREl4ejFab3JGcmVKT3YvMDE5?=
 =?utf-8?B?SURxSk5pVks0eWYwWEgzbEl1SzFwRE1wek5FTmQzUENLZ1V6WGZBV0pWRlpJ?=
 =?utf-8?B?QkFPZVdRNzZvOEJza2lOOXQrTjhEZlhLY3p0TmlHV3Z6aFoyYnlVVllVSklx?=
 =?utf-8?B?dkl6UFVBR1kyVGlKY2ZaL3BsS25pVmV1UnZCWnFNMFhIK0ZmRGJFbFFaTzla?=
 =?utf-8?B?NkRDcUdJZ1BtZkdpak9JVmxQSXJhUnRqZnR0SnFXVFNFV0xWcm1IZVhpK3pn?=
 =?utf-8?B?ZklEMUpBWDA5QUZQZkcwYWJmN1AxTEh1UG9mWXBUYURLQlU4OUViWWFmclFm?=
 =?utf-8?B?QTF2V0VDWGErelBrZGFDWDdEWkYrQkl1UG1LZGtRV1ArUmgvbTJNSTlTNlVH?=
 =?utf-8?Q?jgrafC/oU7di2NcHobK1YhVMs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad17e2f-9c89-4b35-5c8a-08dd6c6d33e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:50:43.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkWynAeqk3JnYVDLgsoRiJGz1LCZfgj7gpnCVATh5kk7Jm5d0QV8P0Bwj1glquUa7dU5Iao6kcOw8WjyfiyYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
Received-SPF: permerror client-ip=40.107.243.79;
 envelope-from=mrgalaxy@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--------------Pyf644Y1Nk0FsbWa84RwlokL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Excellent find. Thank you very much for checking on the history. 
Hopefully my comments were not too hard to read. =)

FYI: I've since left Akamai last year and now work at Nvidia.

Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>

> On 3/26/25 04:52, Jack Wang wrote:
>> I hit following error which testing migration in pure RoCE env:
>> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
>> systems and your management software has specified '[::]', but IPv6 over RoCE /
>> iWARP is not supported in Linux.#012'."
>>
>> In our setup, we use rdma bind on ipv6 on target host, while connect from source
>> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
>> fine.
>>
>> Checking the git history, the function was added since introducing of
>> rdma migration, which is more than 10 years ago. linux-rdma has
>> improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
>> back in 2016 seems related to the issue, eg:
>> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")
>>
>> other fixes back in 2018, eg:
>> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
>> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
>> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
>> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
>> 3c7f67d1880d IB/cma: Fix default RoCE type setting
>> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
>> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
>>
>> So remove the outdated function and it's usage.
>>
>> Cc: Peter Xu<peterx@redhat.com>
>> Cc: Li Zhijian<lizhijian@fujitsu.com>
>> Cc: Yu Zhang<yu.zhang@ionos.com>
>> Cc:qemu-devel@nongnu.org
>> Cc:linux-rdma@vger.kernel.org
>> Cc:michael@flatgalaxy.com
>> Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
>> ---
>>   migration/rdma.c | 157 -----------------------------------------------
>>   1 file changed, 157 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 76fb0349238a..5ce628ddeef0 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
>>       trace_qemu_rdma_dump_gid(who, sgid, dgid);
>>   }
>>   
>> -/*
>> - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
>> - * We will try the next addrinfo struct, and fail if there are
>> - * no other valid addresses to bind against.
>> - *
>> - * If user is listening on '[::]', then we will not have a opened a device
>> - * yet and have no way of verifying if the device is RoCE or not.
>> - *
>> - * In this case, the source VM will throw an error for ALL types of
>> - * connections (both IPv4 and IPv6) if the destination machine does not have
>> - * a regular infiniband network available for use.
>> - *
>> - * The only way to guarantee that an error is thrown for broken kernels is
>> - * for the management software to choose a *specific* interface at bind time
>> - * and validate what time of hardware it is.
>> - *
>> - * Unfortunately, this puts the user in a fix:
>> - *
>> - *  If the source VM connects with an IPv4 address without knowing that the
>> - *  destination has bound to '[::]' the migration will unconditionally fail
>> - *  unless the management software is explicitly listening on the IPv4
>> - *  address while using a RoCE-based device.
>> - *
>> - *  If the source VM connects with an IPv6 address, then we're OK because we can
>> - *  throw an error on the source (and similarly on the destination).
>> - *
>> - *  But in mixed environments, this will be broken for a while until it is fixed
>> - *  inside linux.
>> - *
>> - * We do provide a *tiny* bit of help in this function: We can list all of the
>> - * devices in the system and check to see if all the devices are RoCE or
>> - * Infiniband.
>> - *
>> - * If we detect that we have a *pure* RoCE environment, then we can safely
>> - * thrown an error even if the management software has specified '[::]' as the
>> - * bind address.
>> - *
>> - * However, if there is are multiple hetergeneous devices, then we cannot make
>> - * this assumption and the user just has to be sure they know what they are
>> - * doing.
>> - *
>> - * Patches are being reviewed on linux-rdma.
>> - */
>> -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
>> -{
>> -    /* This bug only exists in linux, to our knowledge. */
>> -#ifdef CONFIG_LINUX
>> -    struct ibv_port_attr port_attr;
>> -
>> -    /*
>> -     * Verbs are only NULL if management has bound to '[::]'.
>> -     *
>> -     * Let's iterate through all the devices and see if there any pure IB
>> -     * devices (non-ethernet).
>> -     *
>> -     * If not, then we can safely proceed with the migration.
>> -     * Otherwise, there are no guarantees until the bug is fixed in linux.
>> -     */
>> -    if (!verbs) {
>> -        int num_devices;
>> -        struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
>> -        bool roce_found = false;
>> -        bool ib_found = false;
>> -
>> -        for (int x = 0; x < num_devices; x++) {
>> -            verbs = ibv_open_device(dev_list[x]);
>> -            /*
>> -             * ibv_open_device() is not documented to set errno.  If
>> -             * it does, it's somebody else's doc bug.  If it doesn't,
>> -             * the use of errno below is wrong.
>> -             * TODO Find out whether ibv_open_device() sets errno.
>> -             */
>> -            if (!verbs) {
>> -                if (errno == EPERM) {
>> -                    continue;
>> -                } else {
>> -                    error_setg_errno(errp, errno,
>> -                                     "could not open RDMA device context");
>> -                    return -1;
>> -                }
>> -            }
>> -
>> -            if (ibv_query_port(verbs, 1, &port_attr)) {
>> -                ibv_close_device(verbs);
>> -                error_setg(errp,
>> -                           "RDMA ERROR: Could not query initial IB port");
>> -                return -1;
>> -            }
>> -
>> -            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
>> -                ib_found = true;
>> -            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
>> -                roce_found = true;
>> -            }
>> -
>> -            ibv_close_device(verbs);
>> -
>> -        }
>> -
>> -        if (roce_found) {
>> -            if (ib_found) {
>> -                warn_report("migrations may fail:"
>> -                            " IPv6 over RoCE / iWARP in linux"
>> -                            " is broken. But since you appear to have a"
>> -                            " mixed RoCE / IB environment, be sure to only"
>> -                            " migrate over the IB fabric until the kernel "
>> -                            " fixes the bug.");
>> -            } else {
>> -                error_setg(errp, "RDMA ERROR: "
>> -                           "You only have RoCE / iWARP devices in your systems"
>> -                           " and your management software has specified '[::]'"
>> -                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
>> -                return -1;
>> -            }
>> -        }
>> -
>> -        return 0;
>> -    }
>> -
>> -    /*
>> -     * If we have a verbs context, that means that some other than '[::]' was
>> -     * used by the management software for binding. In which case we can
>> -     * actually warn the user about a potentially broken kernel.
>> -     */
>> -
>> -    /* IB ports start with 1, not 0 */
>> -    if (ibv_query_port(verbs, 1, &port_attr)) {
>> -        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
>> -        return -1;
>> -    }
>> -
>> -    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
>> -        error_setg(errp, "RDMA ERROR: "
>> -                   "Linux kernel's RoCE / iWARP does not support IPv6 "
>> -                   "(but patches on linux-rdma in progress)");
>> -        return -1;
>> -    }
>> -
>> -#endif
>> -
>> -    return 0;
>> -}
>> -
>>   /*
>>    * Figure out which RDMA device corresponds to the requested IP hostname
>>    * Also create the initial connection manager identifiers for opening
>> @@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
>>           ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
>>                   RDMA_RESOLVE_TIMEOUT_MS);
>>           if (ret >= 0) {
>> -            if (e->ai_family == AF_INET6) {
>> -                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
>> -                                                   local_errp);
>> -                if (ret < 0) {
>> -                    continue;
>> -                }
>> -            }
>>               error_free(err);
>>               goto route;
>>           }
>> @@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
>>           if (ret < 0) {
>>               continue;
>>           }
>> -        if (e->ai_family == AF_INET6) {
>> -            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
>> -                                               local_errp);
>> -            if (ret < 0) {
>> -                continue;
>> -            }
>> -        }
>>           error_free(err);
>>           break;
>>       }
--------------Pyf644Y1Nk0FsbWa84RwlokL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Excellent find. Thank you very much for checking on the history.
      Hopefully my comments were not too hard to read. =)<br>
      <br>
      FYI: I've since left Akamai last year and now work at Nvidia. <br>
      <br>
      <span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;" id="docs-internal-guid-a0b80d43-7fff-af1c-cef3-0fa87a1a56f8">Reviewed-by: Michael Galaxy <a class="moz-txt-link-rfc2396E" href="mailto:mrgalaxy@nvidia.com">&lt;mrgalaxy@nvidia.com&gt;</a>

</span><br>
    </p>
    <blockquote type="cite" cite="mid:e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com">
      <div>
        <div class="moz-cite-prefix">On 3/26/25 04:52, Jack Wang wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:20250326095224.9918-1-jinpu.wang@ionos.com">
          <pre wrap="" class="moz-quote-pre">I hit following error which testing migration in pure RoCE env:
&quot;-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
systems and your management software has specified '[::]', but IPv6 over RoCE /
iWARP is not supported in Linux.#012'.&quot;

In our setup, we use rdma bind on ipv6 on target host, while connect from source
with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
fine.

Checking the git history, the function was added since introducing of
rdma migration, which is more than 10 years ago. linux-rdma has
improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
back in 2016 seems related to the issue, eg:
aeb76df46d11 (&quot;IB/core: Set routable RoCE gid type for ipv4/ipv6 networks&quot;)

other fixes back in 2018, eg:
052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
3c7f67d1880d IB/cma: Fix default RoCE type setting
be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
63a5f483af0e IB/cma: Set default gid type to RoCEv2

So remove the outdated function and it's usage.

Cc: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com" moz-do-not-send="true">&lt;peterx@redhat.com&gt;</a>
Cc: Li Zhijian <a class="moz-txt-link-rfc2396E" href="mailto:lizhijian@fujitsu.com" moz-do-not-send="true">&lt;lizhijian@fujitsu.com&gt;</a>
Cc: Yu Zhang <a class="moz-txt-link-rfc2396E" href="mailto:yu.zhang@ionos.com" moz-do-not-send="true">&lt;yu.zhang@ionos.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:qemu-devel@nongnu.org" moz-do-not-send="true">qemu-devel@nongnu.org</a>
Cc: <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:linux-rdma@vger.kernel.org" moz-do-not-send="true">linux-rdma@vger.kernel.org</a>
Cc: <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:michael@flatgalaxy.com" moz-do-not-send="true">michael@flatgalaxy.com</a>
Signed-off-by: Jack Wang <a class="moz-txt-link-rfc2396E" href="mailto:jinpu.wang@ionos.com" moz-do-not-send="true">&lt;jinpu.wang@ionos.com&gt;</a>
---
 migration/rdma.c | 157 -----------------------------------------------
 1 file changed, 157 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238a..5ce628ddeef0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
     trace_qemu_rdma_dump_gid(who, sgid, dgid);
 }
 
-/*
- * As of now, IPv6 over RoCE / iWARP is not supported by linux.
- * We will try the next addrinfo struct, and fail if there are
- * no other valid addresses to bind against.
- *
- * If user is listening on '[::]', then we will not have a opened a device
- * yet and have no way of verifying if the device is RoCE or not.
- *
- * In this case, the source VM will throw an error for ALL types of
- * connections (both IPv4 and IPv6) if the destination machine does not have
- * a regular infiniband network available for use.
- *
- * The only way to guarantee that an error is thrown for broken kernels is
- * for the management software to choose a *specific* interface at bind time
- * and validate what time of hardware it is.
- *
- * Unfortunately, this puts the user in a fix:
- *
- *  If the source VM connects with an IPv4 address without knowing that the
- *  destination has bound to '[::]' the migration will unconditionally fail
- *  unless the management software is explicitly listening on the IPv4
- *  address while using a RoCE-based device.
- *
- *  If the source VM connects with an IPv6 address, then we're OK because we can
- *  throw an error on the source (and similarly on the destination).
- *
- *  But in mixed environments, this will be broken for a while until it is fixed
- *  inside linux.
- *
- * We do provide a *tiny* bit of help in this function: We can list all of the
- * devices in the system and check to see if all the devices are RoCE or
- * Infiniband.
- *
- * If we detect that we have a *pure* RoCE environment, then we can safely
- * thrown an error even if the management software has specified '[::]' as the
- * bind address.
- *
- * However, if there is are multiple hetergeneous devices, then we cannot make
- * this assumption and the user just has to be sure they know what they are
- * doing.
- *
- * Patches are being reviewed on linux-rdma.
- */
-static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
-{
-    /* This bug only exists in linux, to our knowledge. */
-#ifdef CONFIG_LINUX
-    struct ibv_port_attr port_attr;
-
-    /*
-     * Verbs are only NULL if management has bound to '[::]'.
-     *
-     * Let's iterate through all the devices and see if there any pure IB
-     * devices (non-ethernet).
-     *
-     * If not, then we can safely proceed with the migration.
-     * Otherwise, there are no guarantees until the bug is fixed in linux.
-     */
-    if (!verbs) {
-        int num_devices;
-        struct ibv_device **dev_list = ibv_get_device_list(&amp;num_devices);
-        bool roce_found = false;
-        bool ib_found = false;
-
-        for (int x = 0; x &lt; num_devices; x++) {
-            verbs = ibv_open_device(dev_list[x]);
-            /*
-             * ibv_open_device() is not documented to set errno.  If
-             * it does, it's somebody else's doc bug.  If it doesn't,
-             * the use of errno below is wrong.
-             * TODO Find out whether ibv_open_device() sets errno.
-             */
-            if (!verbs) {
-                if (errno == EPERM) {
-                    continue;
-                } else {
-                    error_setg_errno(errp, errno,
-                                     &quot;could not open RDMA device context&quot;);
-                    return -1;
-                }
-            }
-
-            if (ibv_query_port(verbs, 1, &amp;port_attr)) {
-                ibv_close_device(verbs);
-                error_setg(errp,
-                           &quot;RDMA ERROR: Could not query initial IB port&quot;);
-                return -1;
-            }
-
-            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
-                ib_found = true;
-            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-                roce_found = true;
-            }
-
-            ibv_close_device(verbs);
-
-        }
-
-        if (roce_found) {
-            if (ib_found) {
-                warn_report(&quot;migrations may fail:&quot;
-                            &quot; IPv6 over RoCE / iWARP in linux&quot;
-                            &quot; is broken. But since you appear to have a&quot;
-                            &quot; mixed RoCE / IB environment, be sure to only&quot;
-                            &quot; migrate over the IB fabric until the kernel &quot;
-                            &quot; fixes the bug.&quot;);
-            } else {
-                error_setg(errp, &quot;RDMA ERROR: &quot;
-                           &quot;You only have RoCE / iWARP devices in your systems&quot;
-                           &quot; and your management software has specified '[::]'&quot;
-                           &quot;, but IPv6 over RoCE / iWARP is not supported in Linux.&quot;);
-                return -1;
-            }
-        }
-
-        return 0;
-    }
-
-    /*
-     * If we have a verbs context, that means that some other than '[::]' was
-     * used by the management software for binding. In which case we can
-     * actually warn the user about a potentially broken kernel.
-     */
-
-    /* IB ports start with 1, not 0 */
-    if (ibv_query_port(verbs, 1, &amp;port_attr)) {
-        error_setg(errp, &quot;RDMA ERROR: Could not query initial IB port&quot;);
-        return -1;
-    }
-
-    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-        error_setg(errp, &quot;RDMA ERROR: &quot;
-                   &quot;Linux kernel's RoCE / iWARP does not support IPv6 &quot;
-                   &quot;(but patches on linux-rdma in progress)&quot;);
-        return -1;
-    }
-
-#endif
-
-    return 0;
-}
-
 /*
  * Figure out which RDMA device corresponds to the requested IP hostname
  * Also create the initial connection manager identifiers for opening
@@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         ret = rdma_resolve_addr(rdma-&gt;cm_id, NULL, e-&gt;ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (ret &gt;= 0) {
-            if (e-&gt;ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(rdma-&gt;cm_id-&gt;verbs,
-                                                   local_errp);
-                if (ret &lt; 0) {
-                    continue;
-                }
-            }
             error_free(err);
             goto route;
         }
@@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         if (ret &lt; 0) {
             continue;
         }
-        if (e-&gt;ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(listen_id-&gt;verbs,
-                                               local_errp);
-            if (ret &lt; 0) {
-                continue;
-            }
-        }
         error_free(err);
         break;
     }
</pre>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------Pyf644Y1Nk0FsbWa84RwlokL--

