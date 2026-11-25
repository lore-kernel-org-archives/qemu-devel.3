Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB1606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wB/lu2k5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWDVC-0005pG-Na; Wed, 25 Nov 2026 08:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1xWDV5-0005op-0s
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:57:31 -0500
Received: from mail-eastusazon11012063.outbound.protection.outlook.com
 ([52.101.53.63] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1xWDV2-0004Pq-M4
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:57:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlpSFaE5+fA2jro5QSwaZvEIRmCrVhipeO+q170l58QKtLW+RD7VcanQ65CFLrYhXgTFh7+zlEe9JyciA/hnb5/IwqWXLFBQLy0LbkWjbaOihDDxR2Tk30wIC0gcHjoaktYln4Ss5Ibk5Wu1BJcBrGZk7bv7EUDPJ4qseohbXzyZTDiwYSuHIBk/5EtPHyb9RuxbrTTpPWwu5xW3Ngsiz9r6mgjYuZiyLoP2y1d5IIMqH6tkhHiNBq2ODxkowHVsjVz7qPAZRB9vfrWXGMFCidqCb5mk98yIp8gUddG+ibUDiApBxxxAYsDSppI+xAb9owSlj1beSZrUpvPIJCoBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaTvMEOUkZrpPQ2uRMISkPYjQqDtOyzBvTiqoLqvxcE=;
 b=cNpgeKvmw6S0LfDxLGMBilld3X3HrG0IPnUe3Us13uAFs5VyzopqLs5oHwoxJWGWquhHW3SGsbtkFYUkaZ8dSQTHX89Mmo7/49WqwJugyi/qrNlqN2tDIMUdd+U1at283GypgTKZt3eUpYRcEk6nqea/ta9DG3o8uwbvhI2ZMMDovahpYD2RkS+HQv3DEt7DLgGaW+p81fqiew4HqJ5H6CqbFuRnmuwtdeoRXDgTwdY3MzJtwN1zX5zrAytS20i6hvRuryt6GjS1CibiZe5kWL8udGXCsYZP3FIGpvaqDAGoDDN7jr5aOCciTyXuIKrq4m0mKcZZ/U0oX5LiGmK3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaTvMEOUkZrpPQ2uRMISkPYjQqDtOyzBvTiqoLqvxcE=;
 b=wB/lu2k5NniVok3YTJWvN9CYfHKjxoui0wIJIxc0ZIgNmveWtRD2sUuDkXx0dpv5X40efs4hTGKJZ0TIXriYD2qE4c4VeunxEZxdMwyjYzbFEOnyXOgyAl1YYIDEBAEPsryCdIpOCWgSUicnZnf1QqEzjRlffVO1AlM2VpFmLFs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 13:52:18 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::ae79:f50b:b7a6:4cd8]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::ae79:f50b:b7a6:4cd8%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:52:17 +0000
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Marek =?utf-8?q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: Re: I/O performance regression between 9.0.2 and 11.1.3 on Xen
Date: Wed, 25 Nov 2026 14:52:12 +0100
Message-ID: <179561473234.142606.6830358739051545773@amd.com>
In-Reply-To: <awbIcujrsqYLGS1B@mail-itl>
References: <awbIcujrsqYLGS1B@mail-itl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:408:141::33) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8546bc-5b47-488a-6fe9-08df4afb5117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info: 6/SOBt71G3/laz5+bRCXCf/rMUq1WMMPH1u5dJkbTWZx7Ku3ItuL9aTN5k5MLYn4+YUh4rv3h9LDhuJt/mezK7RMtgFA/F2Tb0DBrOkA6CjiXibnorg9TWkuLoGpLrhQhk2U68tXn7dHtlpDeuaoY7hb3JaGELuFyFP2ZE8ctYgJS7yJVFyrlLAKdBO9YGnKBAnfnh77bTupaTP2eF69XYVDxAwCYLHDVLnd08k+9RCC4COtqoelEHSPKOLU92oFAbdNsG0dDNpcD1n7D1SOTA84kgEq//gdnXLYnNL5eOxvSbzxaO6zseQSTw8YQ1nhdHPWr1nQK92aH7N6AIDObc1zHhXgay9Uzrpn+7ZcWRWBQfHL+8IbTCcOCArU1ocdZV4IHtZMt+iPnblKwGi8k7MoFrOr1grEvdakFAg8nFFY8c/6ROVE+HemY0dB1Td6OT5slKh39dlXYW1QhhFbKboI8P4g8qZOkkMg2DQ27scwSIk97Ctj57/MspYneOy4VtFCrEIbbeS7IMUx2/X330OI3t9HUNIHGX3JdsAJ8U8YHmMWi9NN/vhGHiLukkzFD8cmHgUXN8gcKEMX1p39IMvfZlbBbEKUZ1Z5cXBPwr/L6sh7gUZ4Ezwa09HYSWyPW5RIkzlP3PreN6wDlUsoLIj804j4VHn+DBaPFwfvcek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdvcW52NDdTdWNyMjNaSGZFQS9UMzNrYWJxZGJ2NHRNN0x4OWlwdEN2emdS?=
 =?utf-8?B?UEp2VlhBd3RXR080bDBPemw2bm1sWlhOM21qVk0zNEp6aW94WWRiSkZBZ2lH?=
 =?utf-8?B?eXphajZYZFo5UkJNZXRrc3lzNzJIL0RuYmtiMFBXZ0w3b1JkSTFnUDFxU1pK?=
 =?utf-8?B?RnNpRTBPcHJINHUzRENJQ3Z0THdNanhYdnF3T0V0QUVKWjBNcmRLMnZqd01V?=
 =?utf-8?B?b2V3bVB1L2FObjRhM1N3TER0RjMweFhiVXVLVXo1bXgxSUFBNVN2N0dxRGVV?=
 =?utf-8?B?R1IzUlBZKzJ6V0Z3RHZBU0dqcTVWT09RTTBqQ0dJOWhUa2V0enZnS1J2K29O?=
 =?utf-8?B?TGhrUFNlc1E1dkNXWGhxR3NFYkQ0Qjh3YnhWVVQzSGpxWC9nR3VVd0xkYS9N?=
 =?utf-8?B?YW5QYml4UDdsS2YwNHRHVnVrOUhWV1NZUUJvdzBPeUw4aW1pZm1mZUppeE9y?=
 =?utf-8?B?YVh0SE0vNHhRRE11OEpJeDlnNDdYakFVaWMrNThaVno1N2lQL0xpZlVtVVho?=
 =?utf-8?B?TWZOY1ZHWlNSZnVOOVFBTTkvQUlFajVjWmJURTJ5VldLVlh6cDZKSzJtVGp5?=
 =?utf-8?B?aThZazg0UjRJM2xZeWc1ZnJCL3EyaXppSkNYSlVsSGcrakN3ajd3Q2JHTlg1?=
 =?utf-8?B?eFErT0x5M1dnWThKcVZxYThQRjFTZzBkckpZUHFtanVZSUdsOVhlWHQ1VzVT?=
 =?utf-8?B?OGMzVi9iTTNISUMwWWRuY1V1VC9FUjErUmJ5cVJmS0xhNTRvKzhvSXdFZ1Q5?=
 =?utf-8?B?QnhQR3NFbHkwREd1WjhjS3VHc1FWYWovMElZMlBDSVQrVU01NGtPSUM0Y2h2?=
 =?utf-8?B?VktZVm55Q0xuRkRNejYwdkQxclFMVDhJdlNWTzlHUFFsNll6V1Y2UFZsOXpP?=
 =?utf-8?B?V3cySUFCRWxkN3ZxWjFpWUs4Mm1ETkhveEFmTUsxeWdsREpuSzVoUG9Wd2dW?=
 =?utf-8?B?azRpZHZRMTU0cngyWGRzVll0OTJQT2ZzRkdpdHMydnJaVjFyODFVd3M1b2xw?=
 =?utf-8?B?NWhGTE5KVFZRYWUrVmpPYU4wYUVWa1hDV0g2ZE55em1weURtWDBPdkpKTHhu?=
 =?utf-8?B?N2FISG5OY0tPVktGY2VVTDREQ1hYZUlLQk9rN0Zlc0J1R3JKNHc0N0V1UUl3?=
 =?utf-8?B?QjN6RUJub0dpNE9oeFQrK1lFeFh5dERxcnNXeTgrT2sxSXIxMzJGWlJyLzhY?=
 =?utf-8?B?YmZJcHBoQzNDOGJ3a2xxT28vK2lNQzN3QzZsTWhkSXVxdVJuQlg0RUt5RTU5?=
 =?utf-8?B?QUY5NVU2M0dnaGFMeWdicHNwQ0FvRmhqUU5oeUVOeWRxd3EvcTFmdEYxMVJk?=
 =?utf-8?B?eXFnLzZrdnpDeC9Yc0JxUUN3NnlSUS9aMFcyQlRSY3I3UlJ1QThKa1VyelRT?=
 =?utf-8?B?cDFFc0FQOVl0eEZFckRwYXBQOXRrZTdCY2FadE9CYU5rcjVZcTc3b3FPMkla?=
 =?utf-8?B?ODNOekx4OFljQUJ5cXpRT2UwWUJVZThYWEhFbE8wUDVxUSsxRUJwdVBndW5O?=
 =?utf-8?B?Q3F5NWJqSExMaVdMZzZNdlJvMThhWjV4SU50S28rMU13UDBPemc1V1cwa3Ft?=
 =?utf-8?B?YitjY2xUd25LK002Nm15azg5MWc1dzNyU2ZvRGwyWTUrT2s2UVg2ZXUzbW1v?=
 =?utf-8?B?SzlodENFbFJZdWhkblVNTE9oRE5XbllVWDh2MDhlTzdON21zTEJVZXp1TWJp?=
 =?utf-8?B?b1NJRmZ6WmxxcGJKYkhCRTlSZER1YjFXYXIxR29jamZlY1hEeVRjcnV1NXBa?=
 =?utf-8?B?cGhnRUdMNHB5enowVG0yWCtnbjRxVVprejhXSXd2WGdXK2xnNEdZNmxVMXdV?=
 =?utf-8?B?c2draHc5TEx6UEV5Q2VJcnNiQVBWODdlby9pS3BWMDM0bnZpZnhnMk1ZaHcv?=
 =?utf-8?B?bWNpb2I2cmE2NWxOeTJhQmFCWUJ3dmJmVjIyOVlDbmM1RmIrSGllZEg0T2FB?=
 =?utf-8?B?K0k2R3dWRlp1b2NrSDNGTzRvYTAwNWZncllpSlVFYlB5cUo2Wm5pdGFmaEpS?=
 =?utf-8?B?aHhYby9rYUpWK2tobSs0R1BXVTJ3RGF1Q09HZXg0TGVTUXN0aWVxNGRjM0s5?=
 =?utf-8?B?VlBlRS9VR1lCZFhhM1VJc2dTbU1qQ0Q1Ukp0Nlo3My9GejZxbVo1NHlLVTFK?=
 =?utf-8?B?cVR3TjluK0xVeXM2TE5RZ2tIR3AzendyYXZYRUYraW5zQ0hKVjAwaDl1Wm5H?=
 =?utf-8?B?Y1M0ZUhCQVMyTisvUWZUMUkvWkdvRjdnaCtCR2pFU3JEMDl0cGJ5YWpGZEVE?=
 =?utf-8?B?bm9DTTlyS01CdDNBbzBvOW5LTzRidDZGQUtqR1pxTnNxNzFYUU5RSU91ZGFB?=
 =?utf-8?Q?c4FpoIx+wZfgJUf6lb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8546bc-5b47-488a-6fe9-08df4afb5117
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:52:16.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arX67HbJ+oxOFpW7+eBD4Nfw+S5nYNTRv68Xs/PGIhDlBUSjkjD5/tbcSzikUHMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
Received-SPF: permerror client-ip=52.101.53.63;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 12:37:22PM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> And indeed, reverting it on top of 11.1.3 fixes the issue. I assume that
> page gets mapped and unmapped a lot (for disk I/O?).
> Let me know if some more information is needed, some logs to collect
> maybe? Or a simplified test case?

Hi Marek,

Thanks for bisecting this. We hit the same slowdown and carry a patch
that keeps foreign DMA mappings cached after their last user releases
them. That lets repeated I/O to the same guest pages reuse the mapping.

I have the patch queued for upstreaming. It=E2=80=99s on the edgar/xen-pvh-=
fixes
branch in my tree.

3386b77e09 xen-mapcache: Keep released DMA mappings cached
https://github.com/edgarigl/qemu/commit/3386b77e09e194ffc921c79f28241de8e55=
45748

Could you try it on QEMU 11.1.3 with 123acd816dcc still applied and let
us know whether the Windows install is back to around 7 minutes to
first reboot?

Thanks,
Edgar

