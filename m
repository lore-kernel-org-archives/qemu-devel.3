Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5907DCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQlh-0007YD-Mz; Mon, 24 Nov 2025 02:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vNQld-0007WI-EJ
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:13:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vNQlb-000487-6p
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:13:45 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AO3jETR215374; Mon, 24 Nov 2025 07:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=GdHARX1UaKvhnLFMUfPuydNKr8C76NYgkndUamMp1K0=; b=
 NqX/+SEyOmKAdl2LNEIPR3Pqshc3hmWJZ+NHHSRazf5yE6sbwSxbRp+Y8Up86x2l
 rRETqW0tJxFreBfHgzeyHerf6mAR6wyEFv19pCdptKVT0Mt6lZ7ivZiYbUVfnvzM
 9laXIVCGg2Sx/hYSonnDm6SJFvRklYsDpFq28dtoQtboN6EobCAQpUag3UnDS9cn
 rGJjBowHuAdVLGF9zz5DUvP+chyep0yFEYxpNcLKFuuhtT9QYnnjeBN+HGMVpRRX
 AoBicnPzbP+OfUmtx8CUYOb1Lz/qt4TQIGeLhLNIx0pBrpumu7IdtJvvWe4R+W6r
 badLtCg7z6aLybmNNEVzNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak811hfs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Nov 2025 07:13:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AO6AqmW022160; Mon, 24 Nov 2025 07:13:37 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3mbhcut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Nov 2025 07:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS5Xigb4dgoPVDpTKY36tsN2V4otY8QmDf0r6dYJHYMuDUBtpqyzw/rH6H5MBumU51deO6D9VqC7EQWLLWVXdgyKdPXUUJUbe/BTGIP5XTu05IL9V6on9pMogiIu9OxYtzcAR69Y5iTbscZaV5TvF1twa5D0K/Me0fnH8G3Lz/2yQe3TGi9l+pyAJ70AcKJUuktQ+vKfSM8O01xaUUq8ElmZQ/7L13yEKNDlbrgYSCZ8MO0qGe6tcJN4T44gORAinDtXoPnHXePup2K8m/KPTt2asl5oYdmaeqwhDeTCgE4NIjbEpD5vP0XkVQa9kNRI3mG6onlwsLMa2HrB9Sc43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdHARX1UaKvhnLFMUfPuydNKr8C76NYgkndUamMp1K0=;
 b=aO7BWL7YqZbuB2KPDObaiAJ9K9YGJQTAGqp6FL3oWqmXKhS2KtekSXXgTt9+yHGyaGcqIq/DWUelVYpTlLg6Zd0WrUBI7FGZTDP+hF44UmzYyxA1uLNnpEI5Eob/E+Ya9IeCPgc7QdzB97JxL5IDm99WSYJ2KPdN0w4eOYTWD7YUnmJ9+FuqBsnq/7C/qjTNgvTEMrJXBT2VwRAW9fKU0nGg7lGxQK+tBLEBRTSzMTGi35+fxTpy8SPT1VZUqJD4rMwWozk0ypyHuak/mIB3iHChW8g5BRBESkzDrqzObx1JNckjyyphHuEi8QhBYI7jpgYwdr4NNgsWL4oCvPp0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdHARX1UaKvhnLFMUfPuydNKr8C76NYgkndUamMp1K0=;
 b=NhO/RUhftVG/hPIuglxMdpA+nojke7BjCHXffo1X8fv3V9oGCVspOikTM5PpYVr66XDKd/iGxsQyZAonGKsQtERZqbLxXkOsK+UPIIK4LzP6Zg/XNlZQnntKZs5EzpKJvTFlmyPvlbSsJkOFSxcsdrW01B9zyod4QJepIWApKqo=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 CH0PR10MB4922.namprd10.prod.outlook.com (2603:10b6:610:c6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 07:13:34 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:13:34 +0000
Message-ID: <e44d1f5a-9e0d-4b0f-97bc-6ece9a36c5f5@oracle.com>
Date: Sun, 23 Nov 2025 23:13:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
To: Peng Ju Zhou <PengJu.Zhou@amd.com>, qemu-devel@nongnu.org
Cc: HaiJun.Chang@amd.com, Qing.Ma@amd.com, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net, pbonzini@redhat.com,
 mst@redhat.com
References: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:e::18) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|CH0PR10MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 817cd6ba-efca-4ada-330a-08de2b28fa95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEZhdnZSZnBaeUQyY3JxSVQ0RStFYnFaRytGQThzbG4rWFJuQWczQklaQjIx?=
 =?utf-8?B?WUt4R0cyeHB2WGI4elZqVHFJcVpkcFdhUWsvNGpMNkNKc2pDSzdXdjBjV29z?=
 =?utf-8?B?QXJZTlVaaVY1TGZZbGx6eHVMYm9GR3dmVVg2UHh6cGxNWWd0dW8xUkx6T01m?=
 =?utf-8?B?TXYwNVBXMldxNTlhcFRveWJDeHpPZnNQdkdtQnlJei9aRWZsYU1ReUhzMU1O?=
 =?utf-8?B?U3hkd1lKVnRJaHowTUU2T016bHpkWkVwbXQrRk1MSlpteXRRLzZaRjNXY1gw?=
 =?utf-8?B?NUZHbFpncXJDK3lvVldlWEhwcy83cW91VysrYngxMFViWlovQ2lSN0NlL21E?=
 =?utf-8?B?c0xpbHZGQmdyK0J1aFV0RVdPaWZhSExDems0ZU84YXRvZmpPN3psVlpJWkln?=
 =?utf-8?B?Zmw2Q2xVZTIybWE4OW5SeFdvQ1pqNmp3MUUwUEd4c25La0plTG1FU0o1a0dt?=
 =?utf-8?B?NVlNdHRvUjUzQ3lkNGFHQ2M5MUc3S3RETGlFQVJubUVLQzdzZWxTUHI3T01w?=
 =?utf-8?B?Z3FYamVUQU8yNFhoNG9qelFtLy9SQ3VZaWZKK0J4KzVqcmp6MjNqdzIvVWFr?=
 =?utf-8?B?SUd0QWpTWUQrWG5UWXIwSmsyaDM3LzAvOWUrMTZNdkVLQy9waUlVNkc4UjRQ?=
 =?utf-8?B?bERQV291QkRIbGhYYS9Uamg4WmJMa1BjVW5UaStVWjJ6Znc4dkZTdldnTWUr?=
 =?utf-8?B?ejAvdkdkY1pyTjNmWjh1clFQNjV1UGRVT2QxL3YxczNiM25Pa25HenBhWlJs?=
 =?utf-8?B?R0owU1BXY0pnb3VqOHhhZzNkSHdyVVNtWUtNcWdreko2bkp3c1dDUDQvT3JL?=
 =?utf-8?B?eXEzbGNFVmNxdTFHcEhKZExIYXMyVFBpVnBZSDI4QXR0RDYvcXFjQ1MyWmVT?=
 =?utf-8?B?c0c5OURiazh4TytrQWtRT3FSdEhHM3Y2Z1l2SnoxQXFBbWNJU0ZKUGRQTVBB?=
 =?utf-8?B?UUU3S1Jra3pwdFhIYkhMUE4wS2cwTXAyQmVDeWh2RnRMczg5KzZpY2JydW9V?=
 =?utf-8?B?b1BibS85c3N2dFJVQjF6Yk5uRVdPYWRXRS9rcHdCeENRQkRrcElLTE5SRjQy?=
 =?utf-8?B?RVBPRlhtUDdNTGkrSVhFZ3lVRWtZVCt5aUp3OGh1aVBUbGVmQ0MxeHBwSkUr?=
 =?utf-8?B?MjAzdlVpZzNRRkp2TkdpbUhjNHNLcUJGclNIbG83ZS9vbEx3SVloWTNvYmpE?=
 =?utf-8?B?R0k3dGRRNTB5ckdNRDR1UHMzbXQyQW16anl3aTBEKytncHFFaHJLcEgwcHpC?=
 =?utf-8?B?NG51TGVaaEpISy8yZnhkOXE1ell5eWdlTHU5a3JFSmVQa1dvUGIyMHlYZ0xu?=
 =?utf-8?B?aHo0WEZvWENKS0JYVFg4UjFiQXo3TGNBU01IS21ZUEhMaXgxUnU1K3RkcVlQ?=
 =?utf-8?B?NWl4TW81bHFYTmtmZFRETkZUVGpHd0gzaUhPVWpqWS9UZjMyZVFOWHI1VjEz?=
 =?utf-8?B?d0NxSUhuZzAxRVVlSHNIMERMWjduYnNMMFE3UEN6MHVqamRCc2J0bnZPMTVS?=
 =?utf-8?B?Wlp0UDN0WEo4bWZhcXNxSlJPQ3EyVXZSa3BQanUzZjgwVWJsUThFUTJlOHpu?=
 =?utf-8?B?b3lzcVFiR08zaVpick5uaDRWczNQTHR3c0xkWUg5WXZsZDA1S2hKeEIySEZm?=
 =?utf-8?B?MTliNnJJamJpdXhtVXJCYzdWcGIya2tRR3Q2UEpBakFYZmxubVI1OEEwelU0?=
 =?utf-8?B?NWF0MlNBTW9ZRkc1U1o4TFlCV01uWVJZVUhDZHNFYy8vUG9sY3YzcC8yd1FQ?=
 =?utf-8?B?Q3dZNVdvWExTNGlIMjNoUE4zNWI3Sll6c215Y280UWI4SGtMWFZHa0xMVWg5?=
 =?utf-8?B?K3hERlpTVzg4YXFaNG1RS1pKUXdGcVN0WHFHeXFMWVRKalFYSjBwTzJLOGtv?=
 =?utf-8?B?TWUvRlZqWVd0VzdKTk1VSEpadnFoMW9icjQ2VHhmY2xuUVY1KzRtQWVRZmhR?=
 =?utf-8?B?Q1RUVVpHRUU1b25EdEp4QTFNd0hIMnJKSDVwVFoyNklKRnJiT3RUV3pDdFEr?=
 =?utf-8?B?RVNxUW5ZMzlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uko1M0VMMXhzN1MybmFrQUQxRThQUks0MldhNzJMcFhjY1BNdFVPL0Vlc0RZ?=
 =?utf-8?B?cnBGSzFuekpvUmxMZ0k1R2s4V2E3VUpETjZNWXFJUVMrUVVLYWpPSG5TMVl3?=
 =?utf-8?B?OGI2aXozQXY4UnZ2S0ZLUjZCZnNBekp5OG9vVmlMTUNoNHFsbXJnUWlUdGh0?=
 =?utf-8?B?WWw5NkIzOG5vbm1CSTVQTDZFNWcxUlY3NWJZMFpKSjRPbk1SWTVmSzVkd3NM?=
 =?utf-8?B?UVFHS056UWVEdmUwYkxPbExxQ2dFQ3lHMkJrNlJ4emdyUkpiZ0RJVjljNGp3?=
 =?utf-8?B?OHhOVGNBS1VhSm5uanpkTHc4M1pRRUF5T2xsVFNiRDEzakFnUkRveTI5d1ND?=
 =?utf-8?B?alBqRkRWRU5WcFoxb2w4d2ViZzlzUTNLMTUwR05OdDN3a2wyV1ZueGcyMWxF?=
 =?utf-8?B?OGJHekpORVBvYWZSMVFQTmFCNXhWaUlVUDZKR2xERDF4dVZvOUlST1B6UjM0?=
 =?utf-8?B?MmN4dHdQY3JLVnFNbWRwTWFldnoxQUNoM1REU1E4OU5iZk5ETzZ0cm9EUlFw?=
 =?utf-8?B?dVlBaEh5M1RnMFluSDBaVmdERFRXZjlKdUFIMHFMMisxZk0xa3ZQc3FpT0I4?=
 =?utf-8?B?L0lsQ3Q4blBWZmpkRXF2MnZNMkpSdTJRcGpEWXpoSnhzTFRVdXY5Z2pCaVcz?=
 =?utf-8?B?U1UyZEY1Y0JXQlA3blVhOWMrMGUxS2hOamZkSjRQYlhiSFNnclNyUFY0Q2JT?=
 =?utf-8?B?ZHFGYm1Id0N0a0J3Q0JQMWxGV0kzaFA4bHFnVjFRNXFHS2xLem9LelErSlo0?=
 =?utf-8?B?TGYzQm9FUHJlblpxdC9hd3IxaHlUbjcyeXZyZlZmbmI0SjNRVDQwU1lVMUNJ?=
 =?utf-8?B?Rnc0Q01rQjQ4ZlM0UkdlMms2WkZQQ09ieVNDSk1tZFhvYmdhd25hN0JscVdI?=
 =?utf-8?B?VC9QVVlwRUtNMk14eVhnTThQbnNBMWltbW5kY2ovTDN1bjVvVncrQ1RYcU1x?=
 =?utf-8?B?bDlhSWpFWEc5Z2JVVWhzNE1LU25tNS8zcjh2MytSUmx6bWtFSm41U1hERGVD?=
 =?utf-8?B?SnhpbTVxSGQwUUVWTVdyQWNRb2dPQnN0cjlIZ3JNcFNwaDd3UC9aZFUxRFdq?=
 =?utf-8?B?RW5CVjZZbFVTTHA5SksvTFYyM1lwZ0R3WU5mOFpWSHdDaU94aTQrVlp4Wm1Z?=
 =?utf-8?B?VCtHdDR6NXk5UUM2VW9ETzM3ZzYwVGZ1U0pMcWRQZCtFaTVPY2xNSDM1OW9a?=
 =?utf-8?B?bzhWU0xTcHhadGhZaWR3N2dweWZhUlFyb0toaVBsWlZ5UkQ0LzR1TVlCWFNQ?=
 =?utf-8?B?NmI2MHdxVitoazlacEorUm9oMmkxSTU1bmQ3OGpVNy9SUTdKVkhmN1lzS0xH?=
 =?utf-8?B?UUJuazkxN1p5TmxhRmJaUmJwRWJCVHVITFBwZGx6dG9RV0FUSTYrcnBUcVNj?=
 =?utf-8?B?TWFGRjBKRkJHRDRkMEZOTG00RXFlc0lIVWNxWXVubXNGMlUzOHdxT1ZFTUx2?=
 =?utf-8?B?TERuL2Iya2syZVdhdVJZM2R5bFpuMzlOMjg1cGp6NnVlY0pPMVdhMkVsem9R?=
 =?utf-8?B?cFoxYWIyMUF4WWN3cHpLVkNqa01uUk9NdjlHKzFnL2ZJNnVOYTZYUUN4ckk3?=
 =?utf-8?B?ZHNtTnlyVXB5MG9GaUFlcmREd1l1dzJhVWNJQi9INURXSWdIQnlvOGM2MDRR?=
 =?utf-8?B?bjNDekc0ZUJja3FSUlpucWlSSVRvVXR4djFoMVJoMVpXTDRqUkYwWkN4aDY3?=
 =?utf-8?B?TllRY2dYZ1JNcm1ET0oxd2grVGVYV0pCN0YzcEk3amU0TkZSRGQ5NGRDYVZp?=
 =?utf-8?B?WUdOTVVITkQ3c3hHOFh4SmZNdmJFNlc3dWc2RkdHREZOaGxjQUV2QUNVN1dP?=
 =?utf-8?B?QXQ1b3BKalNkSHcyNmhmalhpRHFka0dpQ2R0RjdzTk5tVUY2cVp0MlBYdzM0?=
 =?utf-8?B?NHdNMVk5ODluaGxPQjE0R3MzV3JsVFVLWXVGcE83ZWRoN3ptSW1TZjlESzBq?=
 =?utf-8?B?KzdSTW93dkxPWjR5d0MzUkhWMjJmR1RNelgzbnI3U2FrMXd2azJrS0dCWWMz?=
 =?utf-8?B?Z0hSdUx4eHlLR3BxK2hLcGtqWE1YMmg0b3YvNjFUR1ByYUZUTCtRK1ZudXRB?=
 =?utf-8?B?ejdaRmVjOERpSGk1ajBUZ0U2WU15Z3k2VDkxclNSUFZSb2RzZ1ZWU0x0WFo4?=
 =?utf-8?B?ZXhsT2ltckx5ak84dWpNYnZzVXJzK3RDWmtZaDhOQjlrQkJpWVk5QmZaN2Rr?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OFOQhLjRu0zG5/G42YFnW0FuHV6OQlT6ROt3K+U6fOy+J+5RAfPoFlrJN3xhhJU3rR+X9ZrRza+RmSLw9cel23GXJjwk64Nw7n4kwNJr9owPH4zwdlkc1E7VGMofclS1ZI4knA9cgCaUcwtxY+zgsZpF+NGQh0QsMLW497WcMx9dM4Ovosig6UYjPXO/eLyJonKV61O+dtRR/Zok5OFbf3rgc5LhlceriWs9waPLR9Bf80bU5bjR3Kp36e2u5ekbCyQFg3PiKYk2TruFzEp7P8WfQFU4xwVB8sqJwyV1P7Fh5cxW2USIVGPJyLjjTkRRaag2kH/kHoltwbW28dw2QbVW9sgb1fN/8eaSlV1M4zzHCtwNCidbAPcEvuHB731YKLgg4y/InzUQuLlHwPWORqgcjUtmrayA1A5L6emLOFE3qi8mDX+y5hGmQo9dsZdj6drGBoE8CgEqLvT0IpCusmlUYXcxH/vvi9wnvDY8vT/oVpvvZT49yZfOg590hL9+/ZAHYUs4+SJP/xHwkSYEq5HQK+Quq1XMYK3/Y/L7p2kySlR3IqUaVB+BSIdAN54T6m44KwX0hSKLOTOQDgQybBliXc1KuklWn6kvTPDx54w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817cd6ba-efca-4ada-330a-08de2b28fa95
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 07:13:33.9111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xDGURGYKx2tRFJssd0fovfX2rhEzPYWKCNcHwiN9jNoJw9z70K0JwKraS+k9sfzF8j1edEWTcg3MldzKT8UgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA2MyBTYWx0ZWRfX3e2yHQP3ugkQ
 617rLsZg+w4jT0pLWieoPWmC7Q43MDR77zS/WsShyAr4CktiYxd8VZg2NmTbSCF/Xb4UnR38N0o
 TCsUmw9IDM0Vr6KJ5ac8/4rAXYqElQWqopQznWTsjOq+igZpxTgCZZ8QbQaXnzddb70+UQj7Z/J
 A60u6hKWsCfViCXt46FrmxRBxtcs1RubTj4GNMjRLktMEItwo2RZFeu6yF1B2HDuNSx21g2AlRy
 QrEv9I9tu2S6Mcc+THegsr3Ovev8VEQQM2zvk8ZTnUeKq9OSJCOYatz3UX+/23FF88AvA3dxUSq
 whftpn1pyglV30muRvVeRyiYA3/Y/JoeMw6HAM2Qt/ISSQE6Q0Hd8KNbsk+rw67yF195CImSpH8
 Z5STZS+glS7YtXXlDO9914bE2Awm89aqgL6MvdjbTS7GxLwRVSU=
X-Proofpoint-GUID: ZruK3lTpS3-jmKlTigJ_P-NoUVWPq5X7
X-Proofpoint-ORIG-GUID: ZruK3lTpS3-jmKlTigJ_P-NoUVWPq5X7
X-Authority-Analysis: v=2.4 cv=KKpXzVFo c=1 sm=1 tr=0 ts=692405a1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=4PCAv-f3hJP6LGYlbjQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12098
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Peng Ju,

On 11/20/25 12:44 AM, Peng Ju Zhou wrote:
> Problem
> After live migration, the guest monotonic clock may jump forward on the target.
> 
> Cause
> kvmclock (the guest’s time base) is derived from host wall time and keeps
> advancing while the VM is paused. During STOP_COPY, QEMU reads kvmclock twice:
> 1) immediately after the VM is paused, and
> 2) when final CPU state is collected.
> Only the second (later) value is migrated. The gap between the two reads is
> roughly the downtime, so the target restores from a later time and the guest
> monotonic clock jumps ahead.

According to prior discussion, it is expected to account live migration downtime.

https://lore.kernel.org/qemu-devel/c1ceaa4e68b9264fc1c811c1ad0b60628d7fd9cd.camel@infradead.org/


That is, the jump forward is expected during live migration.


I used to send a QEMU patch to account live migration downtime.

[PATCH 1/1] target/i386/kvm: account blackout downtime for kvm-clock and guest TSC
https://lore.kernel.org/qemu-devel/20251009095831.46297-1-dongli.zhang@oracle.com/

Thank you very much!

Dongli Zhang

> 
> Fix
> Migrate the kvmclock value captured at pause time (the first read) so the target
> restores from the actual pause point.
> 
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  hw/i386/kvm/clock.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 40aa9a32c3..cd6f7e1315 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -43,6 +43,7 @@ struct KVMClockState {
>  
>      /* whether the 'clock' value was obtained in the 'paused' state */
>      bool runstate_paused;
> +    RunState state;
>  
>      /* whether machine type supports reliable KVM_GET_CLOCK */
>      bool mach_use_reliable_get_clock;
> @@ -108,7 +109,10 @@ static void kvm_update_clock(KVMClockState *s)
>          fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(-ret));
>                  abort();
>      }
> -    s->clock = data.clock;
> +
> +    if (s->state != RUN_STATE_FINISH_MIGRATE) {
> +        s->clock = data.clock;
> +    }
>  
>      /* If kvm_has_adjust_clock_stable() is false, KVM_GET_CLOCK returns
>       * essentially CLOCK_MONOTONIC plus a guest-specific adjustment.  This
> @@ -217,6 +221,8 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
>           */
>          s->clock_valid = true;
>      }
> +
> +    s->state = state;
>  }
>  
>  static void kvmclock_realize(DeviceState *dev, Error **errp)


