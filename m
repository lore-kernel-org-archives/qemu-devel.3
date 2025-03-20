Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1019CC35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvF1p-0008Fz-Mr; Thu, 20 Mar 2025 08:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tvF1o-0008AR-2D
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:29:40 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com
 ([40.107.92.69] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tvF1i-00015D-F6
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHfMdNcoyWJflEA8FIIUoovp3pDjTN47uhHNlQJEIXk2/7gJZ+dUIdPJ3/hpLmhRRq9ntgfXp0jXuxMER5+TXfCQB2EQuBwtSYgZhmbbdvGk51KCRSRbkZmooGxW57tCJDtK49CyX0TreosTRn7EUNmIYFoLDOTNkI8G0luVTyvLHZDpZvGX1h6hufq1vBtKQopcsiy3jKLkxH9wgUEFwYu0VzDICp10x2S7EWlyp8zfh1V5UsQ1l6rPa+2ryzmAT3Os3cj2NTt+elZdzq7vT7qBkZymdQ9gXz89h/oLP/sip+WW4fs6MZOi/fM/W/mD0tCpdkS1h8RC9d1Tx6FRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi0ZQKCjTuIei6MDApJLERqeysCd6B7YNMToR+qDarQ=;
 b=SUMKK9GmP4qcDGwuJN8ruqOkHILvYjVxHJcvFIislVWPdH/k9+QY+028PVYh88mqsQEOBouTSppJBti+S9AgPg2RmU+PXRkpQ3sMd3LM7aqmFGGN/I2jE7vO5jUYdxFFMkD8ZBl/QMUCVr4ESRVLi3GBhL7gmePmyTAITNjbbmmNH3UliO9LyVTEUY9jG6xEOtY6ybZnOLbXF0gTM/cDZpIIGTYgjKvPU2dRV/kOGB7MNgLSfLoVKx92kVPGkMpK+wW5w4DyeSHKjQHkUt7wgRh/PsvHEmsf+wLoQ3ToQHPMELMKjnPlmKmMMJ1MJYbxNBmrmDWEgxjUhwgsACQ0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi0ZQKCjTuIei6MDApJLERqeysCd6B7YNMToR+qDarQ=;
 b=Ldz81QXfNf3MxWPslytJashdk36gzMUS+doZvhGXOZO8vtZpAZLn2vT6WWWX7MBOBdtfErTAZSbTVJcm5AuvQFFDyD9eXWCwkTWHkH0CFYp+1VSntOPlP0oXGEEjgj4Bos7sAKts30dnMEe17N25r3lb1OgmMHthm/hrdrPKNLPLktc4n43crv5+UxccPcPF98vlVDQdMx9heFn5fhagvuun834P9K+jjOu5DXLtExY2kq2KlnltJ8rD8MzjzO6PiDikwsRfz5wzcd+VZhhu2GWxSGBiHdIy193aJbr1JRypYY84qznLz5zt1EM9ZrpXcVYxWMs0K+145zvY9koZpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:24:25 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:24:25 +0000
Message-ID: <ab479fe9-4162-4c8d-9ed1-6b3835274a2b@nvidia.com>
Date: Thu, 20 Mar 2025 14:24:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
 <621d6268-ca2d-4028-814c-f4c2ddf5d567@nvidia.com>
 <ea1b19e8-245c-449c-a7bb-31b79c62b799@oracle.com>
 <ff5edbbc-b6f6-4064-840a-5ba146190ae1@nvidia.com>
 <3ed50b04-f783-4e1e-806b-7ba4d218950e@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <3ed50b04-f783-4e1e-806b-7ba4d218950e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0412.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::21) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b74ab0e-f8b5-462e-013c-08dd67aa26a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXVjWW9zV1V5bmdWdHUybU5kT0h3ekZKNldhWGVFVy9YRGQvYjFmbUFvajBt?=
 =?utf-8?B?azlCczBsS25OaEhLQy92WEcvcCtxTFV6OENoQmJkSEpWcTZ5eDVqdlVGZks3?=
 =?utf-8?B?WW9rSjVrT3pCQitsbEsyTzBGcUo1NXhOeEpDUXVkRkV1T2s0djV3dFJkVU9o?=
 =?utf-8?B?VDI5anFjTHFNbnlINkhWbTdrZEpYY1lqTEl1UGxqYmhubjNWODFiSE9NUVMr?=
 =?utf-8?B?ZFlXd3VCcFMvaGRaSUlIYXVtT0pJWWdQK2E4bkpIRHFZbnJiN0IyUklONmdO?=
 =?utf-8?B?N2NPNnFROXVqditkTjVJNitBWldYY1F6elowOTM2V2dwZ1VFS3IrNXVYMGZt?=
 =?utf-8?B?NFB4WjUrS2VCc0tuWVovWm5vSVhvZDJDTDV2bUViUUFUdXNrVmk5T0ppQTlT?=
 =?utf-8?B?cGcrN1VtREpsNE5RdGRyMU5GL0tzUW9mVHF4c2xuRXp4RERwRmVmckZyRVRI?=
 =?utf-8?B?T1l4ZWxkcnNFbzZPaEpPZDk5d2I1Y3YvL09ORC9lZ0xpUlp0ZGFrbGFCQUc5?=
 =?utf-8?B?YlNvV2o0ZWtMZy9kR3kvVzhuOXJueHZtbU9mMHdwalVkZUE3K3NFckpySS91?=
 =?utf-8?B?L0xkWkJZRzhDbG9EcmVkeW5rRm1KMXR5OFZTNkd2MEQvNTFybzVOUytoUjZD?=
 =?utf-8?B?UTJzS2svOEM3aUNwZzdTZXg5aGhxUWU3aU5KaUcySy9kOWc4cm4xZitQeno2?=
 =?utf-8?B?T25wOUVJYlY2UWlUYUl5MzYwZDVxZXBxc05kT2lWMkpTaGlnMUkwVVRvR1c3?=
 =?utf-8?B?WE9rbmE2dWR0blFTMVFBcXlkSjRaZ1NJZDJDT05weGpzb25ubEltbjJvTVJi?=
 =?utf-8?B?WG5lZEw4RWc5MXNnWk84TTc1MWdqZUlVVkZmL3h4anlNRmZOb2tMbWlMamxJ?=
 =?utf-8?B?a1VOTVM4cXppdzdKWk00VjZ4SlJCL3MrVXFnR285Z0RUSngxUEJXOWRZeGFv?=
 =?utf-8?B?VTFiLzlOckkxWlZwK203TkNWWGhLejNPejdzVjdTenBseVBmM3lNcEtDQWds?=
 =?utf-8?B?NTBnOFE2eE1rUEE5TVhuVWxYS1dCN2ZRRE1WWU80bkdDZXcyMVo5eUpFcDVq?=
 =?utf-8?B?V1ZvQy9pZ0lhWlRrQmFSS3AxM2lUMnRqWDlSQVF3dFI1eXdqb29UcVdMWVFZ?=
 =?utf-8?B?dGd4K1pTK1lKaDlUUTRJM2Z1Y21COUtXTmE1aytzK3VuUWlSUGMreG9iYWpm?=
 =?utf-8?B?b1RkdjA5UDkxY05aMTRLM0NxUFFMVHp0a201VXlSTTd0cjJUTXpDdVk2NkZT?=
 =?utf-8?B?dko4cjFPTW9neU8vL1gybUlyc3dxU0dLMDAyaXNlekpVT3FqdW9YWW5OWlYw?=
 =?utf-8?B?WlBEMC85N21MNURTZVgvQWFGVHF2MFF3V3QweGxlalVVSER5YVZ6RUNGYmVs?=
 =?utf-8?B?MmhLUUJDVDRrY3lnQ1VBRVNFS2hET0hPcGNhenk4YUxJYW55bU5Td25EdDBu?=
 =?utf-8?B?aEhTSVRhWUgxTDM4cTNwYmJKUjhiUHNtKzNTSUVOSng0TFh2c3FCYlN3bHRm?=
 =?utf-8?B?UytKVEVWUDNmSzNoUE1OaWQ0YVJTY1RxZUlaWXh1a2N5OERZMTk0cC9jT1JC?=
 =?utf-8?B?TGY1T2JKbjFtZnFlaERTZHBvc24yak1PVmFrZml2VGVLS0ZSWUtZUnZNZzJj?=
 =?utf-8?B?VktGNUhoMFVvbUlPbXlaSGRhc1dKL1YvMlZkTW9saURMa00xL0orSXNWMmFC?=
 =?utf-8?B?V21OR2pqQnRHWlJqQldsZlNORGxoYjdiWDdQMk1PdnBVS3B6R0tmVE5NQUxM?=
 =?utf-8?B?bWxvWm14ZlJGTHlGVkFhUEswalovY2h2cm9LMi8rK3R3bDg5TEUrMjFBN1VZ?=
 =?utf-8?B?eldxaWpXRDVBWWU4OGpkUUpJQ2x1blgrQUhIck5BY1dXNmVxeG9oRFo0TjBP?=
 =?utf-8?Q?fcCwGo6pKlJPk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVHeHIxNE9wemJPUm1CclJGQ2ZoVERpUmtubWxUOGQ3WjVWcENmM01KbW92?=
 =?utf-8?B?bGQxaUVEczJKRk5YZ1B4bUxSUCtuSzBiT3MvYUwwOEFQYkt3WTNpcU45U2l2?=
 =?utf-8?B?djZjOTlqT1dQL2kzM0xmN0ozSitEd2ZlUDJnaUlTdEIyRktHTDJ2a212KzB5?=
 =?utf-8?B?blJvZkVYOStKWHhkR2xkcVlZNC9jVWEwQkNLVXFVdEV1a2w4c1l5UmlEdk1J?=
 =?utf-8?B?VU1OcHVmTDZidWFmSmNKY0RtZjZEa0FqOFFpNmp2elA0R3JIeCtPYUkyWGM5?=
 =?utf-8?B?WEVIRnR5RDlHQ3ZnZnJNSTBqYnNtVmFNeXkyQzdpdzdaeWs4bEc4M1NhZDIy?=
 =?utf-8?B?T0FRYiswUW4wNGxOeFlQUWZmSlR5em95NVE4cU5zbmJVQTlkZkRINTZpNGJC?=
 =?utf-8?B?ZU9rM3ZnM2NyZ0lSSHJ0dk9xMFY1T0Y0bnFNeUlaVkQwUG5pM3FVYkx5NHB3?=
 =?utf-8?B?d1VSWEdwMkxIVzBvM3JXd3NTUGVUMW9JMTlORENRam5jdlE3L2tlYU15Wkpy?=
 =?utf-8?B?SFpSTzlKTFh3R2N1N2NGc0lmSkVyZExZYnI2eTZyM3BDeHRxQ2h3bVVLN2ZL?=
 =?utf-8?B?RDZTY3FHbDRRcHBGbVNLTVlodTg3OFNHd0ZZTzlycjRXQXNtRlFkalpiSkdF?=
 =?utf-8?B?NVJqa1o5OVljZ2JPR3B6NFllOXQwOW1GNm1NK2tndWhDR2pOTjlINlNPTmFQ?=
 =?utf-8?B?Z3RRTGJJaGIrSU5OUE9RTUwzbDRqNC8vd0V0SG1Gdk1SbElDK213aGptY29t?=
 =?utf-8?B?RUIxQXpjbStKcUttV2hienpRNlkrM3F1MUs1dGMraWZaWTJYMTZ3U0RhZXN3?=
 =?utf-8?B?M3hxUG5IWGdoSTZvMWc5YjJDbDRWdDZXMGFRcEpZaEIyQzkwa2R5bTk1ay9V?=
 =?utf-8?B?OFZPV2UrRkNHVTQ2VjVJeUc2eHlZL3VHQVNNYVUwdmZiakZWZ3hSVXcreTJk?=
 =?utf-8?B?djRHd1RLZ1pIcHJWTC9Rd2ZWQ1RPTmM5T3VvWGR5dDNYWm55eW5EeDlKbFo5?=
 =?utf-8?B?V1pyN2h3ZWQ5WFpSN0Q2bWErMjNSKzFpNmpEaUl4S0RuZ25ialFtNTNub3ln?=
 =?utf-8?B?b1FHcjFCWU9LVUp6TjJzR2J6dUc3YXBlZ1EwN3J1b2RFM29nbzdBaDVOQ3NJ?=
 =?utf-8?B?MWs2bkQ3RXZsYU1sUk43eHFYNXkybkdiU002ZlI5N0YrMjJuMXlBQmhDOHVV?=
 =?utf-8?B?SlZRcTFFT2d4WVRoRE45UWtHVHBXRm9iSUt4bnora0dGb244TEE5UzZlM2dF?=
 =?utf-8?B?Q3J3VklnRDJoUzc0cFBodWZIWXBFY2lHK0dJN1RDRW5aM28rRFZjcFZ4RVMr?=
 =?utf-8?B?S2xTcE9SOWhrYUI0SysrOUtQRGdIdDZHaGh1aFRYamQ1aTd1dDd0c1lmVTZn?=
 =?utf-8?B?eDQ5bER4OGRHZnNITWNwVk1saFd4K016S2lnQXNoekR4NzRCY01jazhKZW9X?=
 =?utf-8?B?TlRMT29YN2t3U2V1Ulh6ZXBaWTFpOUNZbStEenNWTUNWcm1vb2FyUjZBSnZp?=
 =?utf-8?B?VmFLK2MyUnp2MHhudVRxbHNjc25FK0dMTnMxMGtuaDk4cGJUdDNvbEtKVmR6?=
 =?utf-8?B?RW1MTHBuSklnVkF6cHVtY01SMzVCcTZIMUdVM0FVWUU4RkFIRy9lZm1jeVRD?=
 =?utf-8?B?anpUbVBUd2xxUFVmdjZNdGU3eXd3dklZT2RJZ0tzamJOMFh3OHVSOGo2WWJj?=
 =?utf-8?B?d3RadU42ckpiZmRIQUppSlZjVEtacnJwV0JCNVFFRFVzMkZFekpYcWhlRWJT?=
 =?utf-8?B?SDV1Z3Y1cHNxQ3V6ak5MeFJ1UTlUNm9xZkFFQ3pOL1ZWT2ZhY0FtZGk1K1Ns?=
 =?utf-8?B?UVRBVTNCVDlxU2xkTE1XZnJ3cEhiekl2My9OeE51S1RlcWhmY0JrV1hGSlVU?=
 =?utf-8?B?TzJyWUxwMVBLcUgzS2NRUFVlL2JuK3N6U3JXYVZIMUpXOEtOVDE5T0twYkJC?=
 =?utf-8?B?dkV3Tno4WG5DQTFIM1RwWHB4d2xubVZya1pmU3NjaVpzeGFRem1kSVVVQmVB?=
 =?utf-8?B?MG5VeEU3ejIySXladk9lQ0hCOThNd3Y0YTlOZWhWZWlGY3E0MlFSekpFczRy?=
 =?utf-8?B?T2R4Y1NaT2NDTVlRTlczWmt3SW5Sd3loYW5BTitvQjZmd0RleDBDd29OeHho?=
 =?utf-8?Q?XE3pdOFm9k7BDZJlUPlt06VwO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b74ab0e-f8b5-462e-013c-08dd67aa26a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:24:24.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJBZwEdiluiTvXc8SixqVzC7+e5TMO9hhMbBY6UrPj58rUhpSqlWr51KuXRC1PlbwvMtipkm1XTnL8sxJdmMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
Received-SPF: permerror client-ip=40.107.92.69;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 20/03/2025 13:56, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 20/03/2025 11:45, Avihai Horon wrote:
>> On 20/03/2025 13:18, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 20/03/2025 11:13, Avihai Horon wrote:
>>>> On 19/03/2025 14:21, Joao Martins wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 18/03/2025 09:54, Cédric Le Goater wrote:
>>>>>> Rename these routines :
>>>>>>
>>>>>>      vfio_devices_all_device_dirty_tracking_started ->
>>>>>> vfio_dirty_tracking_devices_is_started_all
>>>>>>      vfio_devices_all_dirty_tracking_started        ->
>>>>>> vfio_dirty_tracking_devices_is_started
>>>>>>      vfio_devices_all_device_dirty_tracking         ->
>>>>>> vfio_dirty_tracking_devices_is_supported
>>>>>>      vfio_devices_dma_logging_start                 ->
>>>>>> vfio_dirty_tracking_devices_dma_logging_start
>>>>>>      vfio_devices_dma_logging_stop                  ->
>>>>>> vfio_dirty_tracking_devices_dma_logging_stop
>>>>>>      vfio_devices_query_dirty_bitmap                ->
>>>>>> vfio_dirty_tracking_devices_query_dirty_bitmap
>>>>>>      vfio_get_dirty_bitmap                          ->
>>>>>> vfio_dirty_tracking_query_dirty_bitmap
>>>>>>
>>>>>> to better reflect the namespace they belong to.
>>>>>>
>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> The change itself is fine.
>>>>>
>>>>> But on the other hand, it looks relatively long names, no? I am bit at two
>>>>> minds
>>>>> (as I generally prefer shorter code), but I can't find any alternatives if you
>>>>> really wanna have one namespaces associated with the subsystem:file as a C
>>>>> namespace.
>>>>>
>>>>> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
>>>>> when talking about this stuff, but it seems a detour from the code style to
>>>>> abbreviate namespaces into acronyms.
>>>>>
>>>>> Having said that:
>>>>>
>>>>>            Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>
>>>>> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
>>>>> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
>>>>> shorter.
>>>> This file is not related only to dirty tracking, but to memory in general.
>>>> Maybe a better naming would be memory.{c,h}?
>>>> Then we can have vfio_memory_* or vfio_mem_* prefix and rename to the below:>
>>>> vfio_devices_all_device_dirty_tracking_started -> vfio_mem_device_dpt_is_started
>>>> vfio_devices_all_dirty_tracking_started        -> vfio_mem_dpt_is_started
>>>> vfio_devices_all_device_dirty_tracking         ->
>>>> vfio_mem_device_dpt_is_supported
>>>> vfio_devices_dma_logging_start                 -> vfio_mem_device_dpt_start
>>>> vfio_devices_dma_logging_stop                  -> vfio_mem_device_dpt_stop
>>>> vfio_devices_query_dirty_bitmap                -> vfio_mem_device_dpt_query
>>>> vfio_get_dirty_bitmap                          -> vfio_mem_dpt_query
>>>>
>>>> dpt can be changed to dirty_tracking if that's clearer and not too long.
>>>> In patch #31 we can rename to vfio_mem_{register,unregister} or
>>>> vfio_mem_listener_{register,unregister}.
>>>> More internal functions can be gradually renamed and added the vfio_mem_*
>>>> prefix.
>>>>
>>>> Will that work?
>>>>
>>> I would associate to memory if we were talking about Host windows, DMA mapping
>>> and etc. I believe that's more fundamentally related to memory handling of VFIO
>>> to justify said prefix.
>>>
>>> Here the code Cedric moved is really about dirty page tracking, or tracking
>>> changes made by VFs to memory. Calling it memory.c would be a bit of a misnomer
>>>    IMHO :(
>> Hmm, yes, the majority of the code is related to dirty tracking, but maybe we
>> can view dirty tracking as a sub-field of memory.
>> Dirty tracking doesn't seem the perfect fit IMHO, as this file also
>> contains vfio_dirty_tracking_register and .region_add/.region_del which are not
>> entirely related to dirty tracking.
>>
> Ah yes, it's a small portion but still region_{add,del} is indeed about DMA
> mapping and not at all related to dirty tracking.
>
> It's almost as if we should be moving ::region_add/region_del alongside
> vfio_dirty_tracking_{un,}register into a memory.c file and leave this one as
> dirty_tracking.c / dpt.c

Yes, this could also work.
Need to consider if it's worth the additional split churn. I have no 
strong opinion.

>
> Which reminds me that perhaps vfio_dirty_tracking_register() and the name might
> be misleading and should instead me vfio_memory_register() /
> vfio_memory_unregister().

Indeed.

>
>>>> Thanks.
>>>>
>>>>>> ---
>>>>>>     hw/vfio/dirty-tracking.h |  6 +++---
>>>>>>     hw/vfio/container.c      |  6 +++---
>>>>>>     hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
>>>>>>     hw/vfio/trace-events     |  2 +-
>>>>>>     4 files changed, 29 insertions(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>>>>>> index
>>>>>> 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
>>>>>> --- a/hw/vfio/dirty-tracking.h
>>>>>> +++ b/hw/vfio/dirty-tracking.h
>>>>>> @@ -11,9 +11,9 @@
>>>>>>
>>>>>>     extern const MemoryListener vfio_memory_listener;
>>>>>>
>>>>>> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase
>>>>>> *bcontainer);
>>>>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>>>>> *bcontainer);
>>>>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>>>>> *bcontainer);
>>>>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>>>>> *bcontainer);
>>>>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>>>>> *bcontainer, uint64_t iova,
>>>>>>                               uint64_t size, ram_addr_t ram_addr, Error
>>>>>> **errp);
>>>>>>
>>>>>>     #endif /* HW_VFIO_DIRTY_TRACKING_H */
>>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>>> index
>>>>>> 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
>>>>>> --- a/hw/vfio/container.c
>>>>>> +++ b/hw/vfio/container.c
>>>>>> @@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>>>>> *bcontainer,
>>>>>>         int ret;
>>>>>>         Error *local_err = NULL;
>>>>>>
>>>>>> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>>>>> -        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>>>>> +    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>>>> +        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
>>>>>>                 bcontainer->dirty_pages_supported) {
>>>>>>                 return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>>>>>>             }
>>>>>> @@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase
>>>>>> *bcontainer,
>>>>>>         }
>>>>>>
>>>>>>         if (need_dirty_sync) {
>>>>>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>>>>>> +        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
>>>>>>                                         iotlb->translated_addr, &local_err);
>>>>>>             if (ret) {
>>>>>>                 error_report_err(local_err);
>>>>>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>>>>>> index
>>>>>> 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
>>>>>> --- a/hw/vfio/dirty-tracking.c
>>>>>> +++ b/hw/vfio/dirty-tracking.c
>>>>>> @@ -45,7 +45,7 @@
>>>>>>      * Device state interfaces
>>>>>>      */
>>>>>>
>>>>>> -static bool vfio_devices_all_device_dirty_tracking_started(
>>>>>> +static bool vfio_dirty_tracking_devices_is_started_all(
>>>>>>         const VFIOContainerBase *bcontainer)
>>>>>>     {
>>>>>>         VFIODevice *vbasedev;
>>>>>> @@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>>>>>>         return true;
>>>>>>     }
>>>>>>
>>>>>> -bool vfio_devices_all_dirty_tracking_started(
>>>>>> -    const VFIOContainerBase *bcontainer)
>>>>>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase
>>>>>> *bcontainer)
>>>>>>     {
>>>>>> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
>>>>>> +    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
>>>>>>                bcontainer->dirty_pages_started;
>>>>>>     }
>>>>>>
>>>>>> @@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>>>>> *bcontainer)
>>>>>>     {
>>>>>>         VFIODevice *vbasedev;
>>>>>>
>>>>>> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>>>>> +    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>>>>>             return false;
>>>>>>         }
>>>>>>
>>>>>> @@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase
>>>>>> *bcontainer)
>>>>>>         return true;
>>>>>>     }
>>>>>>
>>>>>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase
>>>>>> *bcontainer)
>>>>>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase
>>>>>> *bcontainer)
>>>>>>     {
>>>>>>         VFIODevice *vbasedev;
>>>>>>
>>>>>> @@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase
>>>>>> *bcontainer,
>>>>>>         memory_listener_unregister(&dirty.listener);
>>>>>>     }
>>>>>>
>>>>>> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>>>>>> +static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase
>>>>>> *bcontainer)
>>>>>>     {
>>>>>>         uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>>>>>                                   sizeof(uint64_t))] = {};
>>>>>> @@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>>>>>         g_free(feature);
>>>>>>     }
>>>>>>
>>>>>> -static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>>>> +static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase
>>>>>> *bcontainer,
>>>>>>                                               Error **errp)
>>>>>>     {
>>>>>>         struct vfio_device_feature *feature;
>>>>>> @@ -940,7 +939,7 @@ static bool
>>>>>> vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>>>>>
>>>>>>     out:
>>>>>>         if (ret) {
>>>>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>>>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>>>>         }
>>>>>>
>>>>>>         vfio_device_feature_dma_logging_start_destroy(feature);
>>>>>> @@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener
>>>>>> *listener,
>>>>>>                                                      listener);
>>>>>>         bool ret;
>>>>>>
>>>>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>>> -        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>>>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>>>>> +        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer,
>>>>>> errp);
>>>>>>         } else {
>>>>>>             ret = vfio_container_set_dirty_page_tracking(bcontainer, true,
>>>>>> errp) == 0;
>>>>>>         }
>>>>>> @@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener
>>>>>> *listener)
>>>>>>         Error *local_err = NULL;
>>>>>>         int ret = 0;
>>>>>>
>>>>>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>>> -        vfio_devices_dma_logging_stop(bcontainer);
>>>>>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>>>>>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>>>>>         } else {
>>>>>>             ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>>>>>>                                                          &local_err);
>>>>>> @@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice
>>>>>> *vbasedev, hwaddr iova,
>>>>>>         return 0;
>>>>>>     }
>>>>>>
>>>>>> -static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase
>>>>>> *bcontainer,
>>>>>> +static int vfio_dirty_tracking_devices_query_dirty_bitmap(const
>>>>>> VFIOContainerBase *bcontainer,
>>>>>>                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>>>>>>     {
>>>>>>         VFIODevice *vbasedev;
>>>>>> @@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const
>>>>>> VFIOContainerBase *bcontainer,
>>>>>>         return 0;
>>>>>>     }
>>>>>>
>>>>>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>>>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase
>>>>>> *bcontainer, uint64_t iova,
>>>>>>                               uint64_t size, ram_addr_t ram_addr, Error **errp)
>>>>>>     {
>>>>>>         bool all_device_dirty_tracking =
>>>>>> -        vfio_devices_all_device_dirty_tracking(bcontainer);
>>>>>> +        vfio_dirty_tracking_devices_is_supported(bcontainer);
>>>>>>         uint64_t dirty_pages;
>>>>>>         VFIOBitmap vbmap;
>>>>>>         int ret;
>>>>>> @@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>>>>> *bcontainer, uint64_t iova,
>>>>>>         }
>>>>>>
>>>>>>         if (all_device_dirty_tracking) {
>>>>>> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>>>>>> -                                              errp);
>>>>>> +        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer,
>>>>>> &vbmap,
>>>>>> +                                                             iova, size,
>>>>>> errp);
>>>>>>         } else {
>>>>>>             ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova,
>>>>>> size,
>>>>>>                                                     errp);
>>>>>> @@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase
>>>>>> *bcontainer, uint64_t iova,
>>>>>>         dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
>>>>>> ram_addr,
>>>>>>                                                              vbmap.pages);
>>>>>>
>>>>>> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr,
>>>>>> dirty_pages);
>>>>>> +    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size,
>>>>>> ram_addr,
>>>>>> +                                                 dirty_pages);
>>>>>>     out:
>>>>>>         g_free(vbmap.bitmap);
>>>>>>
>>>>>> @@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier
>>>>>> *n, IOMMUTLBEntry *iotlb)
>>>>>>             goto out_unlock;
>>>>>>         }
>>>>>>
>>>>>> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>>>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb-
>>>>>>> addr_mask + 1,
>>>>>>                                     translated_addr, &local_err);
>>>>>>         if (ret) {
>>>>>>             error_prepend(&local_err,
>>>>>> @@ -1147,7 +1147,7 @@ static int
>>>>>> vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>>>>>>          * Sync the whole mapped region (spanning multiple individual mappings)
>>>>>>          * in one go.
>>>>>>          */
>>>>>> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>>>>>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova,
>>>>>> size, ram_addr,
>>>>>>                                     &local_err);
>>>>>>         if (ret) {
>>>>>>             error_report_err(local_err);
>>>>>> @@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase
>>>>>> *bcontainer,
>>>>>>         ram_addr = memory_region_get_ram_addr(section->mr) +
>>>>>>                    section->offset_within_region;
>>>>>>
>>>>>> -    return vfio_get_dirty_bitmap(bcontainer,
>>>>>> +    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
>>>>>>                        REAL_HOST_PAGE_ALIGN(section-
>>>>>>> offset_within_address_space),
>>>>>>                                      int128_get64(section->size), ram_addr,
>>>>>> errp);
>>>>>>     }
>>>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>>>> index
>>>>>> 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
>>>>>> --- a/hw/vfio/trace-events
>>>>>> +++ b/hw/vfio/trace-events
>>>>>> @@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end)
>>>>>> "region_del 0x%"PRIx64" -
>>>>>>     vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t
>>>>>> min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64"
>>>>>> - 0x%"PRIx64"]"
>>>>>>     vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>>>>>> max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>>>>>> "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"],
>>>>>> pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>>>>>>     vfio_legacy_dma_unmap_overflow_workaround(void) ""
>>>>>> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size,
>>>>>> uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64"
>>>>>> bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>>>>> +vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size,
>>>>>> uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64"
>>>>>> size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64"
>>>>>> dirty_pages=%"PRIu64
>>>>>>     vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu
>>>>>> dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>>>>>
>>>>>>     # region.c

