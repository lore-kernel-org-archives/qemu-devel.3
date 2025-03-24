Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2669C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 15:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twjaK-0007jt-JT; Mon, 24 Mar 2025 11:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1twjaH-0007jJ-9z
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:19:25 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com
 ([40.107.220.50] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1twjaE-0007GK-SE
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoZGSMkw10t6vAyUHXDQqqcG4U28tiikeSzm+NzM6fSKjKOdioA4Mpw/6pEiRkQdmC94exPU7+H07UHT7zK5X6cmwZ2ugEjgGBW4meaWgYq8NaHKP70hZE6afUoEjgmmQFo7ezHBsaJ4XS7Q4yTNclm7X4qsqb4345TVYvYdoQZlQwv3y0hubQcnN6c/HzYybk8KxIKpfFnoH406NVLXOK7z5MFPJMt6TsteT8Dq1V02u+R3e0diAsqRh07SFV+YrUn29FHrVeOYhx6lZ4KbW5TzhZoRhOuHRFMH/MLNXv5KV7UCkSIiMlotLlE5REpuF3YG2tPreYeNk23w5PshWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hah5GGMcSjjg9XJQhAzrfktNHF2LHL8DUSv2QKRanA=;
 b=Uj3apIHYpMN6cOOi7HI4DFrMYXDM4RAO19tdUpKt/LNEu0xNyqL9cEzITLmw9NBG8vR25KxfygIis/9eHcZp/kfj1MDtLU6n3RxGfup3rFGdof2Wjn3So/pAocbGYJE11sODpOa6ddfl8Gyq0OPYD5ktL7/IEPP7Ejc4CCft33lW2ecja9jKlVjMTpxd6/fl/ML3X8x1wsojoO1DC7jYzhGhGgq4Nh8/is54zHOAAPwWJp9M8iQus6C/PyKXICCguJi1ZQSiXcjx2qupQGJY+6aN07juTjOXKuHQQGsm8BIMmCQuTuTppxPwFbPuKDPndP6278PjEiXLNoUgVXQJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hah5GGMcSjjg9XJQhAzrfktNHF2LHL8DUSv2QKRanA=;
 b=YQrLg8cri9wjY1ekAJKVOL/1kXk4rqM50pRA6MNjiX+s38GRuIV7y8DuIEoLPeAnC5IbYjdurpoF7Nhhj3BfzNdtfUvlXXrnDuj15gUnTMFnA1eJgxv4RPacj/KyW1NuElvhlp2WndlqDsHpt2yyTbM4mCMX5N6W1uOppHn3/wV9PwmZWYPCNL5/AFVevE7OJ8QU1eCS0D71xjl85+f/mNVDYVREvWLBxdaXZzGYBFTLlr6WSAX7WP/DJ/mVHme42F+wt05LVXsT2q8ameCucYge7QNz3XZ08KAAf60rPCDksZHh9SKVE2V9FT9uvMb9/2K0MLjUUp8Y8IYW77OQqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:14:14 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:14:14 +0000
Message-ID: <cb21eec3-0489-4413-971b-40954e64f72e@nvidia.com>
Date: Mon, 24 Mar 2025 17:14:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Open code vfio_migration_set_error()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Prasad Pandit <pjp@fedoraproject.org>
References: <20250324123315.637827-1-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250324123315.637827-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 827e145f-7785-48eb-9071-08dd6ae689be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU9KUkdUVGlYMVdlYUhrOWNCZWlnVmgwOWZ5Vnprd0krd1ppcFY3UFcxYm5k?=
 =?utf-8?B?N25lNnMrZHZIeENZVzl4MmhEWHY0N2JVZi9sd05TQi9Ndlh1V1NHcWF5TXI4?=
 =?utf-8?B?ZytBeXM5eTFCQStIekZLaTlheDdTYzNQSDVGMXozc1Z5TThGRm9IRmtFc0Nk?=
 =?utf-8?B?N1pWdndsWmRnb3ZpWG5HR3JEb3hvTGhvWkg2aDhWWHZLTEExZm1WSC9rR2gw?=
 =?utf-8?B?Q3hrWk91eXU2ekJJeTcycTJSVHF4V2JMU3BPbHNhZDY0MjBwYmtJaXVxZXl6?=
 =?utf-8?B?YnpxMlhkK0dvbHRLQUpjZnRUdkFtbzJDVkZKbzBNWEd3b0MzVkpHSkxxb2hD?=
 =?utf-8?B?K25kZ0lZYUVOOXpWK3lweDhCYUJpVWxGREhjUXJQYWUreGpoRWMrUU9tL3Js?=
 =?utf-8?B?NUovZ1V3MkorRklVdnJKVStudGhFM2IrNmdzRWRlNkJZQVF6WEM0a0d5VUll?=
 =?utf-8?B?Z0Q5aWlOOHBoNmpoOTdZTXBLNHFFU2ZzV2hVeDVLR0FWYnZqUXFQSzFla04y?=
 =?utf-8?B?eVZSNm1ha1VlREJHVmJkVmdwSmdFK0hrRG9hRU83WmxTM3ZQb3BVeW5qRkd2?=
 =?utf-8?B?elppYWV6Q3RwQ01iYVlIcVErdVh5TFNTUFJSVFdtRWhxSC8zUjlnbFlRT1Ns?=
 =?utf-8?B?Q051ZEJyM2RXVVJHd1gvUGpHUE0wQzB2MXhWUnBob2t1U3JERnMxektlVEdG?=
 =?utf-8?B?ZHRQNUpEMHBvUmVFZjlRZVB4N1o2dUFVT3FkVFdvSUo5Y0VsZEd3QXpTMnhR?=
 =?utf-8?B?SnQ5cys0VFE2WGljV0wzWm5yUHBQamVQdE1hV3hsOTBqU0ZJVmd3L2ZEbU5p?=
 =?utf-8?B?SUlYVVF6WnJWS3hmZXFmVEtvTWVOWllJOThVaXpNT2xYUnBoMmhDWkcwbkda?=
 =?utf-8?B?QXNuU1FWY3VRU3Fjb0lHc09LNmZQZ2pzSmlRTnNvRG16ZGZNV1ZXcHl3WVds?=
 =?utf-8?B?Q3FnS0hiTUZxMkdJUWdwMDZMcjhzTk92R1FsVHRNZ08vbkd1TFArQVRhR3Rn?=
 =?utf-8?B?aU4yUWZ0S3k4L0l5ZW9KWUE4OGI2NVBnaEdsMmF3WHNWQnkzT1p0b2xaU1Fo?=
 =?utf-8?B?WFVldzIwN0MveHJ6YjdWUnNWR3FteCtSQlYwWnJvZ2d1a1ZuQVViYktKQWo1?=
 =?utf-8?B?TkdGVUdSOS9lQ3RjNXlPZlhldUVDRVMrN2JranhvZm5xSERJUzFJcXRPM2pl?=
 =?utf-8?B?cXV3VnRsWm82Sm1BRHZzWk51TEZ2L0RycTZZcmVlZmRCWVBicjV2N2o3T0FH?=
 =?utf-8?B?YlJLbmJjNGlJaG5kV0IrQ0xEUzMzRTBLbkdwa21UbTZPdkFtSksxaU9VNWZI?=
 =?utf-8?B?Q0pvVXQwNWFuNEZtMGpYcWtBZ0k5VUxyTUZVakhmTWFBMkViQ2xOSUlxbGk3?=
 =?utf-8?B?L2FNSTNRdVZaRjF2WXU5RzVVMys0RmtzcnZXem1MYlNTa1BnbGF2Q09pTmF1?=
 =?utf-8?B?RE9ueDdOWktlMEJTMzExakVZVU94T296UStSNmUrMzd3TFlHOVBBWGg5Wjlh?=
 =?utf-8?B?T1d4YkIzMDc0UU0wQnlsMjUwcm9ZTDlqOTJHUiswM1N3QjQrZEhhR0R0dmxs?=
 =?utf-8?B?MVV2ekJxME81YjFzdkt4OHV4T2VmZ2VmRkZmdFBFUGF5OENBakh1TnBtTHBN?=
 =?utf-8?B?VkN1bjk5VlpLQXZvQ0w2NnpFaWo2RXdTdmQ2Y29nUUZzeHVPNzIrdHhxVGFT?=
 =?utf-8?B?MFlEam5KRWRlcFo1dnBSU2U1SVVVTjJjd0MrdnJBNE5rY3RHcnZPa3RNVVVB?=
 =?utf-8?B?ZTJVeUgxNE5YNE9lR2o1aS9QVUZpUnRNSnVZM0lhdjV6L2ZiMzFzNk85cWEz?=
 =?utf-8?B?dVJ4RWplTFRmSWg3YTNuL1ZYR1AxaVppcGM5N2dyaXBYRUxoZFBsTG9TN25u?=
 =?utf-8?B?MXRwYjhDWlRCZDcxVkV6ZllJbTB0M1Jad0VLVjhZTTZiNEhVVjIzR0wyRXRv?=
 =?utf-8?Q?xyTMWkeytlY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXMzelp3bC9qaElUeWJob01CZXJNN00xUnk5bVJUSFRRMkRTWHVGUnVNUTFL?=
 =?utf-8?B?Z0V4TE5QR0N2U1pxd2l4NVgwWUVZUTVudk1qTVlTbHhRYXQ2ZGFtOUFYajNr?=
 =?utf-8?B?MEgwNkk3S2NveUVXQXlYY0ZWRmY0UkErbzlYOWZNdTR3UVVwcXNJcG9iODU1?=
 =?utf-8?B?RG1lZGo5ajBTbHF6RDY1WGdQejQ3MExzT2lscStWOVdMZmxTRkVkTFBRQlFB?=
 =?utf-8?B?bkkrRklTcm8rcXJCWW9yVFZsZFBtTnhxbkY2cCt2WTVjWnpiMlpKclhtdEJI?=
 =?utf-8?B?TWhnU0puYlB1ZjJVU2dIcksxT0QrVWZkK2Y1blF0NDcxYkxDbGJSalJuYUgz?=
 =?utf-8?B?eHc4N0NpVkFKeURxUHgra2lSY2p2QlpKM3ZpL2ZiZVMzTFZMS2ptd28xdTRY?=
 =?utf-8?B?b1R2d25SbXpqMWZnRjVqL05DSWNXdDg1bDh4a2x1M253REcvcTJjaThVUkEx?=
 =?utf-8?B?bnAya3djMmcxUHdpaFBycm4vNW9meFVJOWF6Y2ZVVUo5cEY1NmdJT1V1cjIz?=
 =?utf-8?B?aXh1MWd1aDFlZzU0NStUbFFRMHNrcEVsRm9kM3MwZ2wzT0ppcXp3MG9tS2lZ?=
 =?utf-8?B?RnRXbDJlVU4zVkMzYU01a0VERDBsYldYcGM3Q2xmajRTS25WWXd3ZUFBQTky?=
 =?utf-8?B?aE5SWlpGUG5jYnIzcW9hbENzR0VTdUdnWlNxSEtYVDZXNHJTNWUwT3FvU1pH?=
 =?utf-8?B?MFZlQ003Q1RVUXRkcGxCczR3MnNreWZtNkhrQ0YzOU54RlkycktKdFY2Qkxl?=
 =?utf-8?B?MEl2TnhlTVIrRjJNNDVVV1ZLb0hXSDR0eXZnelRnNEt2eFJxOStrQzVoSlpS?=
 =?utf-8?B?WUgxZkRGYkEwR2p3VjJLdU5OcURyaHZkQnd5ME9xMEtFOVF2QitZYW9zdlgx?=
 =?utf-8?B?cWx4dktQM0tYbHZjcitjVXdmckM3cGowTk1xSzErTzhZS1BUZmM1aHJuWnpX?=
 =?utf-8?B?SUdXd3oycCtrOGN5a2g3ZzNWUVNNOWpRZ0U4TGNudy9PaDNuMUVJbU5sSWNs?=
 =?utf-8?B?ZGpBd293TGsrTEl2SEpERDNBL2FCSzZJdTVpejhvOXNzZWk5aTkwTlNJUi9l?=
 =?utf-8?B?QUErN3pkNkJtWUNYa0t6VVpmamRxQXF2NGxnSjJiZWx3VDVLWHl0QlJ4WU40?=
 =?utf-8?B?cGFucENST1lGeXdPWVVFaSszWnBxSzAyQm1PTUs4RXFSZjZlNkMxcFFPZFZj?=
 =?utf-8?B?cDMyRjFPdGtHN2FhdWN5SzlQMFJJY0t2Z05NQmptek04bVJIVUNMVDlkNG1j?=
 =?utf-8?B?YXltOVp6bUthNzNBT3BKKy9KQ1ArNHFsOWxxU3EyY2dzODBZSFl0eDBXSzZj?=
 =?utf-8?B?RzA4MWRlZzFacVFyU251UXN1dXdmQm5VRjB6bnBnbG5kZG1Rc054dWFzNDFj?=
 =?utf-8?B?bndGSmdJZ1NkcG43dzFrQ3N5Z0ZLRjV5NzlLMVJNTmJXcXJGcDlaUlpTc1kr?=
 =?utf-8?B?TU1aUU5GSHJOYWVKNklvSmV0OHhBZXEvUkdqWDE4aVdqbVM2emx2cDZYM3lS?=
 =?utf-8?B?b2M1NHBhN2xxOWRvYlhRVmRycEtVRkxINzVFNVR2UUhHYXRvNmRVTEcyTGNh?=
 =?utf-8?B?Ty82dHpUN1dTWUxPVzhqenJ6TzhIK1h0OHNRZldndDk4WXFuSGl5eHRPMEpP?=
 =?utf-8?B?aFZISSsvbjVRbEZiYzVtK0c0VXBMVUpjS1gzbEtjTXYzQlJyekhCdFRjVWxT?=
 =?utf-8?B?MmQ0cXVaRHJRd2NQdVpPUlBEcmVpbjQ1d1dWbi9KdHZZVEJCNHNsWlFmRkVr?=
 =?utf-8?B?ZDVkN2dFNkVkL0pFeVZhcGxFWmd3S3dzbzU1UVZYTU9wcUUzYVliaG9Jak1u?=
 =?utf-8?B?ckFiUVlNbHRmMlliMllpaHlJTzVWQU9DNCtUVzV0Ty8xdDJEb1E5Y3g1RVBI?=
 =?utf-8?B?SDNWUVFVRDlSTW5KYWhJL1ZtaHNzL0R5Ump2S0hVMTNYblBDOWJxMlhhTWFm?=
 =?utf-8?B?eC9NVUZMdmpxSkE2cWN0T1UxSUxzMHp1Z2s5bHJlOUNwNWNwZ0J5YlNEYkl6?=
 =?utf-8?B?eTY1Vlp3ankzQ1pDREZTcnZPQlRSV21WaVQzbmVvV1FQUlV0ME50VER5dFJP?=
 =?utf-8?B?NDJqVkQ3Qzd1bkhNaFZqeitBMFdrTlgwa0ZROWM4NzJhKzRNcHN2SUtKOUR1?=
 =?utf-8?Q?1Viph7ad7rsdpO5n17PYkKFz7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827e145f-7785-48eb-9071-08dd6ae689be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:14:14.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qFo0kOJ6FW55rnXgRSrTVXqU4eXSdtAMkt51m2/11QmK/ZrtkPGI7VY0VEcPymbmuzChdhavtGYGuB9zDk+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
Received-SPF: permerror client-ip=40.107.220.50;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 24/03/2025 14:33, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> VFIO uses migration_file_set_error() in a couple of places where an
> 'Error **' parameter is not provided. In MemoryListener handlers :
>
>    vfio_listener_region_add
>    vfio_listener_log_global_stop
>    vfio_listener_log_sync
>
> and in callback routines for IOMMU notifiers :
>
>    vfio_iommu_map_notify
>    vfio_iommu_map_dirty_notify
>
> Hopefully, one day, we will be able to extend these callbacks with an
> 'Error **' parameter and avoid setting the global migration error.
> Until then, it seems sensible to clearly identify the use cases, which
> are limited, and open code vfio_migration_set_error(). One other
> benefit is an improved error reporting when migration is running.
>
> While at it, slightly modify error reporting to only report errors
> when migration is not active and not always as is currently done.
>
> Cc: Prasad Pandit <pjp@fedoraproject.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 60 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 36 insertions(+), 24 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 1a0d9290f88c9774a98f65087a36b86922b21a73..a591ce5b97ff41cdc8249e9eeafc8dc347d45fac 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -149,13 +149,6 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>
> -static void vfio_set_migration_error(int ret)
> -{
> -    if (migration_is_running()) {
> -        migration_file_set_error(ret, NULL);
> -    }
> -}

Wouldn't it be better to extend vfio_set_migration_error() to take also 
Error* instead of duplicating code?
We can rename it to vfio_set_error() if it's not solely related to vfio 
migration anymore.

Thanks.

> -
>   bool vfio_device_state_is_running(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> @@ -291,9 +284,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                                   iova, iova + iotlb->addr_mask);
>
>       if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> -        vfio_set_migration_error(-EINVAL);
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        if (migration_is_running()) {
> +            migration_file_set_error(-EINVAL, local_err);
> +        } else {
> +            error_report_err(local_err);
> +        }
>           return;
>       }
>
> @@ -326,11 +324,16 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           ret = vfio_container_dma_unmap(bcontainer, iova,
>                                          iotlb->addr_mask + 1, iotlb);
>           if (ret) {
> -            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova,
> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
> -            vfio_set_migration_error(ret);
> +            error_setg(&local_err,
> +                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                       "0x%"HWADDR_PRIx") = %d (%s)",
> +                       bcontainer, iova,
> +                       iotlb->addr_mask + 1, ret, strerror(-ret));
> +            if (migration_is_running()) {
> +                migration_file_set_error(ret, local_err);
> +            } else {
> +                error_report_err(local_err);
> +            }
>           }
>       }
>   out:
> @@ -1112,8 +1115,11 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>       if (ret) {
>           error_prepend(&local_err,
>                         "vfio: Could not stop dirty page tracking - ");
> -        error_report_err(local_err);
> -        vfio_set_migration_error(ret);
> +        if (migration_is_running()) {
> +            migration_file_set_error(ret, local_err);
> +        } else {
> +            error_report_err(local_err);
> +        }
>       }
>   }
>
> @@ -1229,14 +1235,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>
>       if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>           goto out;
>       }
>
>       rcu_read_lock();
>       if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> -        error_report_err(local_err);
>           goto out_unlock;
>       }
>
> @@ -1247,7 +1253,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                         "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>                         "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
>                         iotlb->addr_mask + 1);
> -        error_report_err(local_err);
>       }
>
>   out_unlock:
> @@ -1255,7 +1260,11 @@ out_unlock:
>
>   out:
>       if (ret) {
> -        vfio_set_migration_error(ret);
> +        if (migration_is_running()) {
> +            migration_file_set_error(ret, local_err);
> +        } else {
> +            error_report_err(local_err);
> +        }
>       }
>   }
>
> @@ -1388,8 +1397,11 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       if (vfio_log_sync_needed(bcontainer)) {
>           ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>           if (ret) {
> -            error_report_err(local_err);
> -            vfio_set_migration_error(ret);
> +            if (migration_is_running()) {
> +                migration_file_set_error(ret, local_err);
> +            } else {
> +                error_report_err(local_err);
> +            }
>           }
>       }
>   }
> --
> 2.49.0
>
>

