Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84B606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=ZwhmnIxG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfX9-00073X-Gp; Tue, 27 Oct 2026 07:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xLfX1-000721-QF; Tue, 27 Oct 2026 07:39:56 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xLfWz-0005bY-Us; Tue, 27 Oct 2026 07:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMJjRIdiWxnAGpIgXWvtMQITd16mnC16sOGEx3v6T7poAfEuEHDJcc9jnuPbzVGhEqrPWfGcofbShZQPrcnN7AEbRyRrLvTXLPnwyKyHZcIuE2HXSnTmHkk5jsM8D3SdvUirc1XmI1KLXd0Ug3YS6916ixVBmgU40JcpUdaN4nHkf7qjnM7TiPEg6VwuQpABBJFIT9QyUUp6oDf+U2gFoJrL4jB1tqrlQgALU1hDUAOQNvOw0penCwrhMKh2levNg/AbRTKrAGB1wvLHfARe0iy41RO1Z2LnHRBj5gOZPvRD9eCy6DVlPyeU5lbyExxZVqDzM8ui5z+smZnM/TGCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVqSQbtB19S7zCz3i/ysmRvV23RkgjUlho5C8piiElU=;
 b=lfRRt8/ZidjnfVglx44k79Ov3ZReYSUq9iW9v7ZwgtJZkpq/PnawXyTdfevXwvuun8RrIUy2Yw06VbELIAp4t9YthNKJElBKJ6ZtcmU833wFlwdWC40xxnHAKdQmv1rXJXDRkxN0XhxDBJhS00Sb2wn4spKBbWC5cRW9rWp/k+mpJULlB5kIuw2c3B0QKMqf+osevfo0p9Z4qHLmN8hSubll1fLOzalDAfAFTYkGVbDcCkZgg2OT6zO4O/1QRQenE3DffIopeDhUGoah0nVohskTKDVgdFgKu0D+vstvu8bMT7zQXZYXvspH4M6NGBs5JbYQr4VLwL0wAH0RaQYU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVqSQbtB19S7zCz3i/ysmRvV23RkgjUlho5C8piiElU=;
 b=ZwhmnIxGE0rUBHc/cjA3E7XDPSwBY7/CeGe4HNOc82+nTb6NfFRJBRrCIgHaVNayVX5xvQEe3bgOwrIrmYHjq0ASHnGwQKxd/iv7ToL/bfPCsJaNV7s/MMXZZD33ciIP9vAq0P99qgfcawUE/8+lAwx/60GUQNPSPQSfdyq80/vjoF/jc9vRo+5XAugRxykhJDVEc6r90zwePk0j+9IE6xbFJkuf8OMXmCB3tB/IEdLmNMfdtq5wAwdOs++K4A/Qs8NY+L4g6u6RL+adYAA/nIJzvov3V7/H5G3nqj3xRERdd6NTPb+mr/+dV8eHaoV4arRGRqyLeNHpP+SXbtgIqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB8699.eurprd08.prod.outlook.com (2603:10a6:10:3d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:39:46 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:39:46 +0000
Message-ID: <58b2ddec-7dd0-4001-9708-185021f474ea@virtuozzo.com>
Date: Tue, 27 Oct 2026 12:39:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] qcow2: fix discard-no-unref=on data corruption
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, den@openvz.org
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0048.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::18) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 52361a89-4e89-418b-41fb-08df341f004c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|1800799024|56012099006|261021121427099003|261009223027099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z6FviBbISr/EEAD5d1OQ9L8iVV/bmiSdMzM6kIGhORJxTkfn4KudrdWLrxf1RB8m0Tr5D1VaSrVv0xXrUjq2Iv0WIoMPMsdxvQoFqrjby2PdkteKlW/uwYAn1IPfrjaMTEh3/VaMKwlUyiaWDSQ6msTWfqPgC0c2n4SQ8B5QmJaTNZZuUUjdYrCn9OjXUbZhGn2JD90gzYfonvy8foTS7pgGba2FXOgDoccDmORelj1LAdM7mJ31VMvZk+r/AJOmbfNkodjaoRmcfmi7MJbniKVHIYD/GwHtRQYPPNrrEqfiPMKYdpL1nHylZ8sl1+vnWy/mNPD2bSeM0eyOvnswYDhApFoIWnlGgiSsa+tSz9tQmIu1lSgytDqepfNzCvK2Fn+JRu1L0nAtHCFnlLW1t2InujKbN3WKdcIy83asXnt9zltrGt47fq0r25u354vb2YBah1WmoZQ7hGGN4uNLqIxV26n5GrHb4ntbsIfAY1tLVX1SlpMstvFTuwqfMC6EwW2Q6Jh5kXRNXmu/kg6xewRYrY++fR3eAjcbnBck9OQQLMfsiasqgb86OHdfeUSFNEanT7zAbit8vMFVgvXlHl+rlQDtlw94Wjb9N09eHvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VzbFdCTUdTMjZSUDcwMjMwU1RIZmE0NTNKRGVqd3lpc3c2UTZtaWpNR0po?=
 =?utf-8?B?QkN0b2VRdHBJSWdRYms1anJyOHJKN0J3R2xuYlJvLzF1K2xsSXVyT2VaTGJZ?=
 =?utf-8?B?VzlxUGNkNzNXOGxCenFyMlowbzFjTDZyOHpkaWIxbUVPL2w5SU5ZQ2wreDg4?=
 =?utf-8?B?bkh6Z1F6MEc3djJRbzVuK1BJdFAva3NKZ2ViN3hzeERPYURvUWhjcDFrMVhZ?=
 =?utf-8?B?UFA2MFVPU2dhbzZHVE1EeGozR2xoUXdBVC9DMUNHWXNEcFUxcGxZVEx1UUR5?=
 =?utf-8?B?a3lWSVVObXd0ZHhscGZybEZPcithak1TVGhMR1VXbXM0VTN3cllXT1YzN2ZX?=
 =?utf-8?B?em8xWlpuZlFja1Bzc3FzYzN1TTdBeFBxZ3U5ck4zbWRXWEhBQUVYS09TRWtB?=
 =?utf-8?B?ZG5XVDU0ZEN3MENtb2FJQUlGMXRnUm5zTFdaNzIvRDcxdkcza1VyTTNQeDFP?=
 =?utf-8?B?QmdTd1NwOHhxbXRIcGRGSlBpVmRycnVRbzkwNVFTcGpsVlpjVkgxZkhvVXR3?=
 =?utf-8?B?WUJIcDA1czlLbFpvZytuaWtsNWFsT2M2Z3pkc3BhTXk0by8xR0JNKzJqWGJ3?=
 =?utf-8?B?L2dQVUdRQWxjeHpSU3NNK2gxcVVickJWc1lhOTA4dVBsNGFNQW5ueDFFSm56?=
 =?utf-8?B?ck9zUnVRZlcxeEN3OUlYZ1R0V2p4clN1aHUzOG85Vk9aMk9YYlN6cS8yOTRv?=
 =?utf-8?B?OFRkYWhzdzR4WFZVNzg4VUNaRzQ3dWF2OWl6ZWhnSkh6Y0hHY0VWT2E5V1B6?=
 =?utf-8?B?MlB4N0JERStqNWg5QVZTU0lQd0lJRGlOWlE2RzBmcStrWk5LNE9PR28wMTJn?=
 =?utf-8?B?b3MrMzRtWmkva3B6S2ZmdUxiazE4Tmc0REhQb08yaGhMUEFBM2JOaVBRTjUy?=
 =?utf-8?B?VjlPNkt4dGJzRTRmcmVGVkZadkxldzIzMVRwQ3FKM1huRVpBMjRTeE4vSkJy?=
 =?utf-8?B?VGtvN3BYSXA4aDdHaTNodHVlTUJRazhEUjFZRUF3dU5Kc0VkcDk2dWtDNnFZ?=
 =?utf-8?B?V1IzWEIwc3FWWU9iaUVNRnI2OUZGUTZYeGlNdTI5OC8rZGpyOEsrOFplWVY5?=
 =?utf-8?B?NjZxVlpnMGNURE9oN25nUDhHc0xKYm9SK3lWV0lsQzBqL3h4b2dxbVRIWUp3?=
 =?utf-8?B?V05IZElMOWlwZnB2VDlEaDdnUExlUUU3Q1dIbURFODVGRWVZU0dwdTBoK1RN?=
 =?utf-8?B?V3dkSzNUeDk5eG1XN2hKRFhqT09LZ3lMVGI4OWZ5STZJT0NIU004K2I0MlU0?=
 =?utf-8?B?dllDUnVnOHh1OHNPcEp3ZDd5cVlpUUltY2lSd3o2N1dwcjF5V1RESW03eTBs?=
 =?utf-8?B?NVBDeFppOFIzSVgwQnZiQnhlT0lHci9NSUxxTmIrNzkrM2svaHVIdjU3SlA4?=
 =?utf-8?B?V2QyU2xWUUJYVmJtTmFhdlBuTXJxdjVuQzZNZDF6YmdGTGJhK2JXa2psTlli?=
 =?utf-8?B?ZkZ3Vmc2REpRVWVCbGN3N3pGcGN1TEwrRDlIZmVocCtZb3BTc1l1RWxkRytI?=
 =?utf-8?B?Uk5HeUFteDEwTWVPR3p2Ujc1alAzc2ZuNUtyai9pSDVPMUVEcjdoWG8xc3Ry?=
 =?utf-8?B?NWtyTHplYUk5MFZ1QTVMYmpiRWNsWmdoQ3dDVnR3bE41anFraEZqM2NFSlI5?=
 =?utf-8?B?dktLWExLSEhFRjMwN3g1NWZDQ2lKRmxHeksweW9mUERiRXRXZ1VQTGx3bVVq?=
 =?utf-8?B?ZHdnV0ZHaHcwV3c2ZFZEd2Y2MmtEMzVlb1NKSDdMaXlqdXJEbDgrWEZyWjRy?=
 =?utf-8?B?WWlnbEYyVmRhRGtLbzlqUHR5K3p5YUg5Ly9MYnN2Ym56MTdnZWJjRk1nb1Vw?=
 =?utf-8?B?NWluRHJBNkQ4UDM3WVN4NVpBQUROLzIwb0JYWkVIRVp2djdRZEdBR1FFd3NK?=
 =?utf-8?B?QmNVNndrVzRaMUYvenJWQ0hxbUg4M01aNFlUOGt3T250dW54blRtS2lkVXFJ?=
 =?utf-8?B?TW1XMTRKQm1ibFpNZGhmY2dCUHFGUkJsbFl6VXBIM1JBbTlCTW9DRTFhU1BC?=
 =?utf-8?B?QVNCcG9RTTNYbFVhOVhTS2tyaitzVXh1VG5NdWZjdVNnWUNjRUlibmhKcXFE?=
 =?utf-8?B?ekhqeWQ3Q0lMOTBlUHJwYjdiYis3SjRHdmRxc2RUblpTWG5EdkYwL3p1OWNB?=
 =?utf-8?B?eXZidUhJNjBFMjZvbm16dEZCK1JQOVJpLzR1VzFTTUZNV1pHbkU2SHJRbE45?=
 =?utf-8?B?a3huaGlGeVNkM005SkkzQXp6M21BZFhBZU9VczhFOWdENzIrcDUzbzNoRkRP?=
 =?utf-8?B?SXFlRXAyTko2aTFTNml1OU9zMmpxQWdBb3p2eFNONG1jd0trNUFDVDUxNFR3?=
 =?utf-8?B?R2pwNTdwVHdNZXZNMG9DZDIrcjJJKzVpYmtMSEE0bmhCM3o0bzRIdytzYmNO?=
 =?utf-8?Q?UszL94S/hQN5aXju0jBLpP3khG4WVtWaLdYyy?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52361a89-4e89-418b-41fb-08df341f004c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:39:46.4539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+eyjrmNKQ5oki/sI0C0q9uP4Gav3rriq0Uu6tyFKpObikNNI7o5NA+8QqtZwbYfckbb7C+OEyNphiwtQI5N/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8699
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 10/27/26 11:44, Andrey Drobyshev wrote:
> 1st commit with tests is my own old commit from previously unmerged
> subcluster series [1].
> 2nd is the actual bug fix, 3rd is the regression test.
>
> [1] https://lore.kernel.org/qemu-devel/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com
>
> Andrey Drobyshev (3):
>   iotests/290: add test case to check 'discard-no-unref' option behavior
>   qcow2: fix snapshot data corruption with discard-no-unref=on
>     #VSTOR-151885
>   iotests/290: add 'discard' and 'write -z -u' case with a snapshot
>     #VSTOR-151885
>
>  block/qcow2-cluster.c      |  6 +++--
>  tests/qemu-iotests/290     | 50 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/290.out | 33 +++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 2 deletions(-)
>
Reviewed-by: Denis V. Lunev <den@openvz.org>

