Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6149606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=s2Xc/2p4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkWu-0007Cw-B0; Fri, 30 Oct 2026 07:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xMkWt-0007Cc-IP; Fri, 30 Oct 2026 07:12:15 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xMkWr-0001zD-Gy; Fri, 30 Oct 2026 07:12:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR1FdpDsvLB2TYvJtJ9eo9DRR0W1L2YmliFSCS8mciMZ4wX05CrjO4wLTLLZGGUVSkzYnrUTUx5o5oC+74UgI89ayH+MdPYaSeHjQ+Iz1bLAe72AdjLgIz4rcOj6Mdk9OiWn4CV+TxSNZMSX5N8JoQCmAPe5Hfg/941czfUGW/7FIShl0REJCciRm9NSSOb85IN0JhevlrUouhIRS2mmx4JysivE3zTeuQ3KbvBCXlM60VMYNS/Mh34dRvdo6prygJnTT0eGXvvtttru0agzrCRTT1i9QrGi9Jp2fSZQ0/0pZKsT2TS/X+RWtGANNcpG6NuXXJ+qpIcTN8DXmdoQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyKpcMcdYvOcO0V7qgdUr//KaWaYtpdnXo1KRUuOrSA=;
 b=TwNRfDD4WVJTvzRkIPdPf83DgKSm6FDRhAZOsuw99s3xeTBHEROrcIp38n41NDyEZNSddAfWP2bZ6S7xBsCoW9y6qMeR+P/iBWHqDdBHkLhNpzd5LrKygFvmA0RN9GCiz1QynbTo+ceg23AECD0cmqYcMpmvbUinM3km4NvfFqf1BKNrh8i5YKWCa8iO2sPKWA3MvbdPOhP+TunADJF92EU/JIjK/aoLjLPfZFPZ98ZXDsf5qVzRTeFgiXX2OxGN0IIE1GXUW6JjqD8Vllh5zwMj6NpPMltkZx1Lxk2QUMPD5+zsRACc9Uvr93odiSzYzSGPzyTG75A8oQpTn9/MfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyKpcMcdYvOcO0V7qgdUr//KaWaYtpdnXo1KRUuOrSA=;
 b=s2Xc/2p45NUTFCDashugFFXfMPudsnW5Rv1x4tYoBO0DIB4ntvmSFMJGN4p3lB2l8SnWoSr2NPP67wURazlgJCCQarR35bY5VXbOwzxhcaLG4Sjvd2v7d3/y5rHEQftulgC+NUOLLAbP4fskPiciiuE+obwrM2rEjfYAHgJU8MuR/kXtZkNdS7+SicACc2VPQikyc8puH9XgyQ3ZjjgLJiLx17vy3R80swHLoJfL7YlTlma3oN6Turjt07SETyyjWkXfTwyE/1dNV2poPQAz7pnqd817Xl+bPB+EbGKL8TnfWTniv16HKUN4g/ZhQfdBX6G5i0xcqaLVR5v85CB9yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA6PR08MB10647.eurprd08.prod.outlook.com (2603:10a6:102:3c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:12:06 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 11:12:06 +0000
Message-ID: <075b5093-afa5-4d4d-a8c5-8a1157fbeb62@virtuozzo.com>
Date: Fri, 30 Oct 2026 12:12:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] block: fix data loss in the preallocate filter
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260930165000.303236-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0022.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:354::6) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA6PR08MB10647:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a1e2f1-0473-4594-a6b4-08df3676a256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10070799003|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|5023799004|261028144727099003|261026140227099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: acIh4OSrqPy+K/RjlrGMvF4NYNJFE8MBMlnJFvXkR1qUM5WPMHuJPcTZUacCqLL+y2wZEESJwqTtOsVCw9Q9W6h/Z5Qxd0jIGuElgIhAfJRJ+FyaTj0qov7wOmYJx3bWhZG9KVZ08yKYG/T0v58X3L0J8ZngVUs+iPkyUlvaLhfll0YsXPYrTTNfQQa3C7CmKSz7ksmeVW7tx6Jd3F+P0v+wOlbKZBVDCqgPdSJhXMtnyVabdzEppezyKFi3jjlbEvvH69aho+tU3s8zuTGrF9B5C6+SeMVEwxaEQ8UCmmfY0JQPWe32h1NwNW/KfblUW56/5YX9R1RwBodr50RpTSrn3azQkMAGERPLqGZMLmz4vbmHwHd4jF8pJCMeJWiMUj2wro//j1k7DLFLe6A+HNa8ocSGLtJwwhsE/aKA6Fv2QahwRVt6UyIFFlG5ygw9xXZy7S7IlbxHPaXi9ZQsIdVyNkvX18Uf+SQJN3PQj8NwpRrUUxi5+i8V1zA0aU2PbX0sMvXuUtgiluL8lHHuuCxpMs4yBia/AKcqq0EtXmcxpeGLpr3g59gLfruz7+7hqGeyloA+TPpBOfii1jkHURYnER3M5oQR7Zv88aPJ2Ss3hRzMmoK+YstbX0pAy9nbAcpaS/84a11eIOyBR4ByUUaBh51F2aRfWx2+cI7lU7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10070799003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(261028144727099003)(261026140227099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NVeEFrdWhVYUdFYTBHb2Vtbms4dXA2bjJTbXRpYlVELzBPM3NtcndHSEZ5?=
 =?utf-8?B?YzNaT0ZGblRkQnY5MnRKc0lUdWhlWkN5blV5cHE5TmZCZjlDZDlSVkZmWGhM?=
 =?utf-8?B?K1crWjlFdmZWTDM3dEhuVjRUT2RyN2lDcTA2QmtSTStUVWVnY0xvVytWSEht?=
 =?utf-8?B?R21sWjBNc09KWFpSa1JaaW52eStSendRODNsVS9mZ0kzRnNXQ1E5NzNiK0h0?=
 =?utf-8?B?eWJWVDhwdkd4S3lxczhTakFaMkEvbG96L3dPZmlCUHR2WmZXejhyZjFubkh4?=
 =?utf-8?B?cmM1d01WN21UNGl6b3ZXMi90cllMaFBiWkpIQnptUFQwMG9admZ2TDZJOHlF?=
 =?utf-8?B?RFdmc0FkditBRXlUUG1mTkZRcXc0Z2xlYWp2ZTVkRzhjYjN1NmFYYk9pNERF?=
 =?utf-8?B?dGsrVm9kL3MvMWdQNjB2aDV2ZjRJcEZWb1ZwSVdMNkd2cWRyaFlubnplVDJI?=
 =?utf-8?B?dlZqRmc2dkZvQkpvM3QwVDV3dTNTQlNESDRhelY2VDhYaldEeS96R0ZnZ2Fr?=
 =?utf-8?B?Z0l6M3dvandNVitIdk9MN28rdmlzbXJyUXZ2aEhveFRXNkdNMHFLekZ6QUNC?=
 =?utf-8?B?VlNCckE3RU51NmJ1VkFvcGhWNWY3U2dBYzVoYVptTjNsYkRBelVHR1RzODdt?=
 =?utf-8?B?TmEzQzNZUnRPRXB4NE16bHd1SXFOZW1CMkNqUDNhZG5ONm0wK1plU1doeHpt?=
 =?utf-8?B?WUc3OXdNaVNST1JxdnN6UkFkQ25uWFJGNzFKSTB4YnJ5RTVMS2VhZ0lLWmNw?=
 =?utf-8?B?ZXN0S2ZzcFM3ZjFaaFdnaStQQWpWSVFRU2E2YVFyQk5YSlkwRTUvVXl6SU4v?=
 =?utf-8?B?WEJObmFIb2sreHpoUTFtRDV3dytob2xnY2R1VEZ1UTFJWU9sYm1PQ0M1Z1Rs?=
 =?utf-8?B?ZjVsOVp3VHRPM1NWRmtzS3FtMHQvb2N2bHZZaTFqcnNwdEtEZGFCR1RaM3BC?=
 =?utf-8?B?eWo3dXl0M3RaQzVtTUJSelRZb0NCZ2o3UDRIUFlqNFU5cHExVWNaMGJtZmFQ?=
 =?utf-8?B?RUZ1M0I0d1NtR0R1V1hiOUNRV3Q1Z2R3SUFudGtaQkZLbHYxd0FZcEhrRkJi?=
 =?utf-8?B?aHlqRVhRRGtZR1NteDJMeGJoME5aRWVCcTZyenV0MWx0VWZYTStXMStCVU1S?=
 =?utf-8?B?VHVyeWZXUGI3VzhwTzltUlpPVzFvVVF6YWxxK29iTjdTb3k4ckw4N2lZOHZC?=
 =?utf-8?B?emRJMHp6VUM5czN5N1hMZW1wT2t5dTAzM2UzUUZGYmd0Mnppa3ZPaGcybzNo?=
 =?utf-8?B?QXQrUXdVMVVLN3N6NTQ4Y2xZclppQmU0VVRneDR2WDdzaE5JR29IV1F4U1cx?=
 =?utf-8?B?RnczeVIvQ1Q0SitCdHJFcmVRbWlSSjdQeW1TS1ZHY21mN3lhdVNjZmNRa0tM?=
 =?utf-8?B?aXl1SjNPTHFhcGNYdTB1VU8raXhKbkRDeVFQMXBmSi9FbEkyVG1WVjRMcHNV?=
 =?utf-8?B?bUI2R0t5eVRrQ1p3Zms2RmtMRWVLQ3dFZ0tsWnN6SUE0cVdNRDgvbTRCbzdj?=
 =?utf-8?B?RnhwNUhSa0huYkJPekU0NmdDRHUzYWlOdG8xNlZYQ0JPWk55MzlNMDkweHd6?=
 =?utf-8?B?N0FVQ2FmL3g1WklmcDgxN1pZVG1ZZnI5eWJaUnFGekY2Q04zZXF0Lzc4S1po?=
 =?utf-8?B?SjZ1Z0VBUGk1WkluZm12MW96aGRIbVFuWGRBaUFoTmYzcTVqbFo3OHRPWUw5?=
 =?utf-8?B?ZG5qOHFyaExqRnlEMWpRdi81WC9zdWtoVlhDRmlTVGNMc3VSNW44K3Rsa3ZJ?=
 =?utf-8?B?TDV5clNkNlNSRzBmajRLbkVacTBXWG9ucjJIbzFPWU5rYTBFQzNnTFIvb1hU?=
 =?utf-8?B?NU81c2VSM3pNU0pWbitZRDJNeWhXUy9jUkNnQ0dyOER4dHU4QmlpTjhWMThz?=
 =?utf-8?B?WmRCVjg5aTNTWU9KYnhsdWJ2R0R1MWlqUkdJREF5djI4TXBaK1VRT0NxQnhK?=
 =?utf-8?B?WjRWTnlJSDVxKzZkbHAyQ0hDMFNSS2xET0JWaGFmemVBYXQwaTRoekkyMGdZ?=
 =?utf-8?B?ZjZRM1NzT3JsbmZPWTV5Z0RWTXlrNTZNcTFOSXozampoM3pQZlZTSS9tSUNy?=
 =?utf-8?B?NVp1aVNRcXlrVWRCL3dKZ3FMakxvRDVuRVEzczFpeE9saWQ5V1drclNVc3Jj?=
 =?utf-8?B?RGlQSlFKUW8zeFJZUlNxdDZVMnFYQnUzMC8vK2lGWFBiNHJONDNaTC9scURV?=
 =?utf-8?B?b0RvdXNWbXlEYUV4ZjRBeU02TzJ6aGNWSWNwY3U5NE1OZ2FDd3djK2ZWQVNS?=
 =?utf-8?B?Q1RDd0cxaTdRRnhvQ0dmazJQUTdRWmFsa0Z4bDBKRlpvVEgrbitIejVRZHZL?=
 =?utf-8?B?d0xTZHQ3T0xPNDhRWUhhY29vVm5UdjJ5SFNYRHA0elk4UkordHQyWmx0SUR0?=
 =?utf-8?Q?WDWgHhPNtiKbSgcWRoyTdPFJVc9JImEteo5Gs?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a1e2f1-0473-4594-a6b4-08df3676a256
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:12:06.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf49F8p6Yz9d7vXyU76ttFCtBK3+5GzAT9dZf/dLoQ8DvsG7qRjRwp+0mp94HCha9uULTo9v3QFWB4PjcEkP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10647
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/30/26 18:49, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> A guest running a container workload came up with 164 files of an image
> layer hollowed out, 45 MiB in all, reading back as zeroes where it had
> written data and been told the writes were on disk. The damage was
> scattered in guest offsets but contiguous in image file offsets: a
> qcow2 over something that zeroed a range of the file.
>
> The storage underneath records every change to the file's length. Over
> a tenth of a second the file grew thirteen times in unaligned steps,
> one per guest write past its end, then once by 82 MiB. A preallocation
> sets the length to the triggering write's end rounded up plus 128 MiB,
> so 82 cannot come from the length the file then had; it can only come
> from a zeroing that started where the burst began, 49 MiB lower, which
> is exactly the range that came back as zeroes. The fallocate ran over
> thirteen acknowledged writes.
>
> So the filter worked from a length the file no longer had. There are
> two ways to get there. Neither is proven, the record cannot decide
> between them, and both are fixed here.
>
> The first is that the filter meant to let those writes in. It raises
> data_end before issuing the preallocation, so that writes below it
> pass straight through into the range the fallocate is about to zero,
> trusting the block layer to order them after it. That trust is
> misplaced, and it needs no race to go wrong: two things meet. The
> file-posix widening that patch 1 removes parks the preallocation
> despite BDRV_REQ_NO_WAIT, and bdrv_find_conflicting_request() skips
> any overlapping request whose waiting_for is set without looking at
> what it points at, so a parked serialising request excludes nothing.
>
> The second is that the length was simply stale. The filter's lengths
> are plain fields, read, decided on and written back with nothing in
> between, and the guest that broke was a virtio-blk with its queues on
> two iothreads. A lost update on the reserved length gives a start 49
> MiB low with no ordering subtlety at all.
>
> For the first, the straight fix is in bdrv_find_conflicting_request(),
> and it regresses iotests/077, whose "Overlapping multiple requests"
> case then verifies wrong data. Patch 1 takes away the other half
> instead: the XFS bug the workaround guards was fixed by 249bd9087a52
> in v5.5, three days before the workaround went in, and predates every
> stable series still maintained. Without the widening NO_WAIT works as
> designed, so it is the one patch here I would not drop.
>
> For the second, the same state turns out to lose data three ways:
>
> - a write into the range the filter records as zero leaves the mark
>   behind it, so a later write zeroes over that range is skipped and
>   the guest reads the old data back;
>
> - two writers extending the file both pass the compare on data_end and
>   the smaller end lands last, so closing the image truncates the file
>   below acknowledged data;
>
> - two writers both preallocate over the same range, the older
>   fallocate lands last, and the first writer's data is zeroed. Fixing
>   this also stops the filter leaning on the ordering above.
>
> Two of the three have tests in iotests/298. The data_end race has
> none: there is no hook between the compare and the store to hang one
> on.
>
> Six patches are tooling, because none of this could be tested: every
> qemu-io request ran in the main loop, blkdebug could neither wake nor
> wait for a request on another AioContext, and nothing could hold a
> request before the block layer tracks it, which is the window the
> filter opens. None changes the output of an existing command.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> Andrey Drobyshev (1):
>   iotests/298: add testcase for async writes with preallocation filter
>
> Denis V. Lunev (12):
>   block/file-posix: drop the XFS workaround for post-EOF fallocate
>   block/preallocate: keep zero_start above written data
>   block/preallocate: collect the state assignments in one place
>   block/preallocate: serialise the filter state
>   block/preallocate: hold back writes into a preallocation in flight
>   tests/unit: prefix the iothread test helper
>   qemu-io: accept --object iothread
>   qemu-io: add -t to run an aio request in a named iothread
>   qemu-io: add -g to write past the end of the image
>   block/blkdebug: make a breakpoint work across AioContexts
>   block: add blkdebug events for a write before it is tracked
>   iotests/298: cover the preallocation races
>
>  block/blkdebug.c                  |   3 +-
>  block/file-posix.c                |  34 --------
>  block/io.c                        |   3 +
>  block/preallocate.c               | 139 ++++++++++++++++++++++++------
>  meson.build                       |   2 +-
>  qapi/block-core.json              |  10 ++-
>  qemu-io-cmds.c                    | 116 ++++++++++++++++++++++---
>  qemu-io.c                         |  41 ++++++++-
>  tests/qemu-iotests/298            | 113 ++++++++++++++++++++++++
>  tests/qemu-iotests/298.out        |   4 +-
>  tests/unit/iothread.c             |  28 +++---
>  tests/unit/iothread.h             |   8 +-
>  tests/unit/test-aio-multithread.c |   8 +-
>  tests/unit/test-bdrv-drain.c      |  32 +++----
>  tests/unit/test-block-iothread.c  |  28 +++---
>  15 files changed, 435 insertions(+), 134 deletions(-)
>
ping

