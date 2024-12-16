Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A871BE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCaD-0004gC-Va; Mon, 16 Dec 2024 10:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCZz-0004eR-GS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:00:21 -0500
Received: from mail-dm6nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2417::628]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCZu-0005dp-By
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:00:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji6Sc94I51wWpRPowDOWgUTq468Hs8e00aGOrQ/D6n7NKBKBatZMfcxGa6wvweilFwxOygupCxGdbuEzcpmH+foOG/il0WQ3f12yZPLozFgWVLccpsaeDu+GsdqibtdWrKkSX84PMjCOSY/+iUUEnDej8c0d1KL7YUeCTYRhyEav6Pc8O6Pye1Ztl6zdZ9gqDEa4bH228qswGLn0YO3O4nj1sTwhZe2JRklDDnBZJjPFcE/2fIm8Inm+/t8KBOyp+MTnnSWHS1ebGPILuQidUH34W58gG6Lip9JQOd1Q2fDNAtt18Xq4wW31dpsWU2PZpB6BTIVz5bYMGnGCI1CEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdqSdIxO2gzMLp6bbFS2aXmTrYkmo4vl/44DsRz5j0A=;
 b=rQl6rfmCkVdPaK2T0PqABVtCFFm9fBOnj1uu8uc7RnV3zeW9fSzwZ8rWykHMJm+r747HLAh8Gq7ry2GaOJwjS0mK6Hb6iIGUgZ0vjYNef7Ob8OutMpg0R2s8BNa5dwjXU6e50WRdr86HCkK5d08q/QwT2OIb4+YUmlQqSMlo5sPn4VQ81WHQfHwQeranjl/Y03aRM+5viAdYl8C1KUCBnlh650ua+3I3ejzrxrZs7U/RZBdmzDSCCp2K+xGHj9P72839OrweK27ck4dYpSlUDRCyhh/B7H2Tf7YeY6kWRN+nIixX4fXCGgnqEPcuWWXtT47MZ6dM8zDi3panBpewTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdqSdIxO2gzMLp6bbFS2aXmTrYkmo4vl/44DsRz5j0A=;
 b=btgSES9Z5EI3AS1i1tR6/IgelQcM/mDwbdMe0D9p27g5aHbgwMRpURiYlQQUMxorbAsNMzEnU+XmScA2NBztaYu/zHnjHNcNir8v+PDOoSBYOvDw2Lh4tuIlB00oUR5RMQeHTO2DXWTAnGcL9eSGJFly4MQ7FVYtmrsmRdodXZoEvViFtHTBGVCuo3FcMaGct3iIklhmkyk6LdR/toE5gak4UewuuqiknH6nXrj9Odj/zoKZB8sA7/Mux/cBnazfgib+ItgSOG9WdeBuuj5Es+yv6IDeXr+kLbpmhPETGUgnIJgSLVwc+KQWb1NpsWFLdWKIIcJ4sTH+p9k+koiQfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 15:00:03 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:00:03 +0000
Message-ID: <8ce838de-e14a-4432-8d14-6b0fcff4e071@nvidia.com>
Date: Mon, 16 Dec 2024 16:59:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vfio/migration: Drop
 vfio_dma_unmap_dirty_sync_needed()
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-6-avihaih@nvidia.com>
 <34bd8988-b9be-48fd-82bc-fab465f67f79@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <34bd8988-b9be-48fd-82bc-fab465f67f79@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: a4af0a4c-9b0d-4572-dbca-08dd1de25238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXR6b1FCRDhRblV0eXdMSlBpMFhwZEZueWNFdVVKeXFXRGs3dGE0VUIvdFBF?=
 =?utf-8?B?NlpKN29lVTJaQlgwUm5iNk5JOXcrNldlRm9qRjEybkM1RjVKMFBLOWZYQ05E?=
 =?utf-8?B?NHRvbHlrdXkyVGQxMTNXUmExVHpya29HTlJPUlczOEpLR0JLTDQzVmJSNUhm?=
 =?utf-8?B?ZE5aRVVXT0M4WTZ1ZWF0NmdSbnN4TzdsL1hKa1JkQmpkek85ZGNod3RNT0JC?=
 =?utf-8?B?YUNxWWJnNWphOEdINDRmSTJtdkg5dHFjeHV6SjNreE96RVU2N0tKNmtvUksw?=
 =?utf-8?B?dnBLTUFMS2YwRXRYbis5dyt4NUZYNFp0OUxrK3h6WGU1c05UMkFLVnhHL3BP?=
 =?utf-8?B?NmVjTzdQVEpweUR0ZWdvT244dVgybnVqaElKa3dXQS9HRWl5ME41bVBPWUp2?=
 =?utf-8?B?YzJJNE05WnpObTd2ekRTNVhQM2tuN3B1T3poeXJjb1VHd2xkbmlLTm5mM25O?=
 =?utf-8?B?WUJRL0cxRTBJakNheXpaQzJBUngvSmFTTVZjUHlxUTVMQU9GcTJqdklsZU1D?=
 =?utf-8?B?OThQUDEyTHZDQitVeC9FekcrR0w0SEQzV0xpS1ZHU2ZmaEpIaFVxUnlhTVJJ?=
 =?utf-8?B?ZzZJVXFkVDBKeStOS01uK3B2T3pGdlN0WnlveFVSdkZxTHg3MjZSZENIeVFO?=
 =?utf-8?B?M3RwMk4xNmZPWGl1SHNHRTUrYnV6dC9xS0FaMll2OEMyVVBabE9zU0s2akxv?=
 =?utf-8?B?U2g3aDBEUFNxOGxBeHJtNFVHQzRyNSs3ZWFmKzZUYktEOUpuMVp2cGlSdS9X?=
 =?utf-8?B?OXh5N2R6eTdSRWlTSkhrRDVXeDRoMVZscGdCWDVUUDBsb3VjNXc0a1g3SjJq?=
 =?utf-8?B?bVEyOWRUM1VEVTFvS0I3R3RaU2RLTUZpbmQ4Tk9jaXpQc1E4Q3hLUFA5aVl0?=
 =?utf-8?B?bmtuL2pobmN4V1VJZnFvVExyZVN6UGJmQUgvSlFBOUEwRENJZlgyOFBORUlC?=
 =?utf-8?B?QVZZZHJyekpUdFRub2NTY29JTW0zczN2TFRXbU9Rdkk3Qmd5Z28vcklEN1dz?=
 =?utf-8?B?cFN0YjZpQy9ZMHN6V25sZGxSZWxwQU5vSG0vYVE3SEEvWGloQzlzQkFjTlQ0?=
 =?utf-8?B?UUZ1eC9zVmx5LzNXQkgvWFE4dkpCRjkwdWc2YXZKNGtEVUI2Y29DV2s1ck9E?=
 =?utf-8?B?ZU9TT3BFUGJBOHMxaVlxVTdtWGhnUTBmUkcvdzIwL2lsOUN5K1FYeHB6SmRP?=
 =?utf-8?B?cUtBdFZzdkEvQnZucllpeXlLb1dKejNBY3NDOGVMSEoxS0d5VVVtdmJac29Y?=
 =?utf-8?B?K0Z6anlqa28vY3EzUTZFVThmRnVJR0JxNVV1eWxEVVlNOEZyUGNObmpKa1ZM?=
 =?utf-8?B?WmozQ2RZYkt0ZXEvVmE5ZVMxcXNsTDIrc3dKRDJWSGV5Q3lWclpGYnY1dnUz?=
 =?utf-8?B?Tzlpb3FJV0MyNDVsaXQxRENXSDR0NEtIbURFZzBHaEE0ZDZYTFJkZVYzdVhE?=
 =?utf-8?B?d3NrdS9tNzVzVTl5MWhNU2RrMjJ3OG5zYkRIYWt1OEI1Y1FqTTNZcVZqT2VV?=
 =?utf-8?B?ZVlCdU5BclJnOU1JMjkzRnpYb2dwUGQ2bTR4aWdPL1k4cXEzZDc2c2R3MVg4?=
 =?utf-8?B?ajBJRGMxWXk1OW5XalIyMU1pNW1UaGxMM3ZuZGNuZHpZT0ZVQ3kxbGhGSWJu?=
 =?utf-8?B?THlzb2h5U20wL2p6RjJYbkF3NTJ5VGgydHY4MVc2bkN1TjV0Y0FiMmcwOUs1?=
 =?utf-8?B?SDNHUDJRQ3RmZWZSZ0RTVWFOeENFNXpzNzBWOEhWaXhjUzl6NUE0SWsxeDZ4?=
 =?utf-8?B?ajhPRDBmYjZBK1IyaHVVMTJrekVOWlBKck9wdWM3RWhDS3hYZGd4ejBUL1hP?=
 =?utf-8?B?S2xpbmV2ZXZyWlp4Q1ptQXppeXplaFVMSzdzZjB3MGk3dm0wR1lRQk9YbVRC?=
 =?utf-8?Q?k8mVd480rbGLp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0ZLMzZvMmFwNXF2Mk1uU01tWTlCUnFkRVlKOUw3VEFVQ0JCWk9GNVJMMWVL?=
 =?utf-8?B?bUlYK0xNUUdPQVZhUEsyMWpieXkwSFhXOFBXSWdHTlJqVTMvKzBvbEZuZ2xK?=
 =?utf-8?B?ZTM0bXJsQlJ2MHN5UlRXOGtOYzEvb1Q3TlI5NklJUzE0UEd2UktTd09DNnF1?=
 =?utf-8?B?NnFYZWxWeFp4Vm9LSy82Tk12eTBsTUhrMk9hakc5cW1iZ2Nza2VEUm9ndzc2?=
 =?utf-8?B?SWFHQWVueFE2S3ErTXByK0JVTEJySWxyRG9jcjhxdzc5WVJtNkxSbGFoNWxJ?=
 =?utf-8?B?cEk1UTRDeXdwdVdUS1RERDVsWTkvdUtKaDd6R3Rac1JKZTZ3SXdKNHRMYU5C?=
 =?utf-8?B?dno5TWZKaERucG56bXd4OHUrbnFKekFBNm9UOU1ZaEQ1N3ZGNnRodlJXRS9P?=
 =?utf-8?B?UUhKZHdlOThTS2xMbTNpM2IvaCtJRzFXd2NRL1U1aFE5c1NIdlloK2VCQzNP?=
 =?utf-8?B?U2ZaUHhQOHU2a2lHWXZIcWFYeDdoYlJOTS9jdzQ1T0pmcURickF3M2REUmpK?=
 =?utf-8?B?QjBMV1B4MzBwUytscWZkT0t5Qm91U0xEUFhCUktid1lHUGtOTE1ub2VFRzlh?=
 =?utf-8?B?ODZyTHdtQmdjZDBONEYrOUhxSWt3bFRhbjZxcnZqU2FnTElqZk1ENkM0Zjg1?=
 =?utf-8?B?OXVaYzE1THlyUzNMNkJubjNrMy9BRGxMU2xjTjFuNEhpWnFNdUlEWnQ0WDdZ?=
 =?utf-8?B?RXdKaUJTdmVMamN3ZDcwNGRDSGxOTm5CeHRqdjF2dkZDdHNSVXZUcWNPc2tY?=
 =?utf-8?B?dkFvOGZMalhTbGdoLzJ4UG5xcFlHSEdUMkxEeHp3SkNRQTQ4alFpZXBOemgz?=
 =?utf-8?B?QURDM0JnUUlaMzBza09BTDliYW9Db1pMUVd3ODZBakJ5WWVkSzBJM3dERlhZ?=
 =?utf-8?B?Qml3aWxSRElSZkR3dE10WEFQR1Q4V29LSVdqQ2hrQVRxUmluV1RvWnd5ZHZ4?=
 =?utf-8?B?bEYwMEIxVC93bFhqUnZJNXBCc1d6SzV5OXFFVkkyTnVZVExFd2JiaktRKzRt?=
 =?utf-8?B?N3kxYjdBdmJrVVV4eDhXSkh3ZWdsWDYrVDkzN2cxTzdnbkcwMGpSSHdYZVMx?=
 =?utf-8?B?V0I4NFpkVDI2aHNOSU0vREhRMHFHMGMxWWxpU2JkeHN0V3hCL3N0Zmx6M1V2?=
 =?utf-8?B?UjEwUGUzckVBR05vbW5hWjZqTWhjRzBpSFZTaGd0cVpYeTlnLzhpZzhTblFF?=
 =?utf-8?B?WHRTK3VBRXlaMWhuVFhZZ0cyUzZINDN6a3MvbW91bWhDeW5Ba203akRJdGd5?=
 =?utf-8?B?R3E3Q2hzNkZSN0tZb2tsMk9vdlhPQmpZOXVEeXgrQWhSV0pnMUhmb0lQMXpw?=
 =?utf-8?B?MjZBMEQ3dXQxYTFpRFJveHQvb2EwbDFuS05IOWV6em0wMFdOM1VNbjFRUDJo?=
 =?utf-8?B?WTFuNXpYMURrY3VIWTNVWmZjNG9NL2dZcEpwOEg5SVNEbzNlN1dzWDdIK1Zp?=
 =?utf-8?B?VGg4eU5jSXp3cUtjRlRaWkg4V2gxVVl2N0docksrRVQ4OEE1SUsxTDBoaGFD?=
 =?utf-8?B?UU5RNS9PbmppR2pPZ2IvaS9uYmd1S2Y0aEJVbURZOThUa0dZeWRHTWQyUkhU?=
 =?utf-8?B?cnN0UENpSng5ZGhXcTdJK1hGM3lwbHZjemlscHltYk9JaDVNdnBZcFIyWVZI?=
 =?utf-8?B?bjBxYnBESHUvd0d0OFpHaE9aS3BTZ3pibUNYVFhBSFhpOGRnYUFDVUo0RGNh?=
 =?utf-8?B?MGxiZDhYeVFicVZxdGNCT0dhckxvek5qT0hmRmxmTEVBUHNDNzAyaUwxTmdn?=
 =?utf-8?B?RW9Xb1didFVoaUxuOHhGT2lsY3dSQXJKc3BBWU9DemJMaXJ5SFlaZlk0S2Ns?=
 =?utf-8?B?Z1dnR0FsSFJsbHErdWNKUXlXSjFmWTgvR1ZXb1duVTZkKzFWYTFNcjZGdnJF?=
 =?utf-8?B?UUJwOXQ1VTFkT215TXhqR3BMMWt5YXpWRFJUZ3BzWjFOdnVaeXp2ZnBxTWY2?=
 =?utf-8?B?VEpRdFV1ZXhuMHFQTTdIdHQwTlZLZjgyTDgzc0FLTjI4eUVwTDE0NzJZcjZn?=
 =?utf-8?B?Q0RteXQ4dlVZY3dEcWdEbXF1NzJGNUxMNnlzQkxlajZ6dFFIQVhEN1VWQ2hL?=
 =?utf-8?B?VkRDM3Iwc2NyZXNNYm8xbGJLMnM0ZDZ5cDB1Yy91bTY3TjNSTjFwRmhrSzdj?=
 =?utf-8?Q?HuVNt+sUFcK46uVyW4BRiHzgY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af0a4c-9b0d-4572-dbca-08dd1de25238
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:00:03.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o31gT0A5dqrmdef7OgyTwkHTU1Z5iVYVSlfw1ZCgXERpjYsDa887ckWsGgSBMyLQTU3aLxs0CZfQEhKj04MnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
Received-SPF: softfail client-ip=2a01:111:f403:2417::628;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 16/12/2024 14:57, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 09:46, Avihai Horon wrote:
>> There is no need for vfio_dma_unmap_dirty_sync_needed(), as it simply
>> calls vfio_devices_all_dirty_tracking_started().
>>
>> Drop vfio_dma_unmap_dirty_sync_needed(), export
>> vfio_devices_all_dirty_tracking_started() and use it instead.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h | 3 ++-
>>   hw/vfio/common.c              | 9 ++-------
>>   hw/vfio/container.c           | 2 +-
>>   3 files changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index c23ca34871..c5aa606890 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -296,7 +296,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>>   void vfio_migration_exit(VFIODevice *vbasedev);
>>
>>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>> -bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
>> +bool vfio_devices_all_dirty_tracking_started(
>> +    const VFIOContainerBase *bcontainer);
>>   bool
>>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 45783982c9..6e4654218a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -184,8 +184,8 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>>       return true;
>>   }
>>
>> -static bool
>> -vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer)
>> +bool vfio_devices_all_dirty_tracking_started(
>> +    const VFIOContainerBase *bcontainer)
>>   {
>>       if (!migration_is_running()) {
>>           return false;
>> @@ -235,11 +235,6 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>>       return true;
>>   }
>>
>> -bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>> -{
>> -    return vfio_devices_all_dirty_tracking_started(bcontainer);
>> -}
>> -
> Why not just renaming vfio_dma_unmap_dirty_sync_needed to
> vfio_devices_all_dirty_tracking_started() off from the start? We are introducing
> that helper name to just remove it again. And this patch wouldn't be needed anymore

That's what I did at first, however there are several DPT helpers with 
similar names that check similar things but with subtle differences, so 
I thought that having a few changes in a single commit might be confusing.
To ease review and make it super clear I split it to be a step-by-step 
cleanup.

I like it this way, but if you think it's redundant I can merge it again.

Thanks.

>
>>   static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>   {
>>       return (!memory_region_is_ram(section->mr) &&
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 8107873534..15deffe3e4 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       int ret;
>>       Error *local_err = NULL;
>>
>> -    if (iotlb && vfio_dma_unmap_dirty_sync_needed(bcontainer)) {
>> +    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>               bcontainer->dirty_pages_supported) {
>>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);

