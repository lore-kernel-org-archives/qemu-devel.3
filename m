Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C863FC0344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvhP-00029E-L9; Thu, 23 Apr 2026 11:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wFvhK-00028Z-7a
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:10:34 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wFvhE-0002hu-Sc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:10:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCGUaWDvfBrVJcNZBLC62Pw0oI0+SS0Pyd4BLg093X/mHpj7F4/xpQcjx5pT8wbSJvViFzbuD/iNjCC+2rFGACqjD+vX8fEaML1ICuR3I9mIxzgcw19Uj6o+L3GeAe6mFoJNH0muh+hjp9Qx6rmXFKC41liw2Rp2Y0oQd1XKCLMLGh6EqHZXgFmZAFA6phBB5TwrzClPpkx1bT+fMslPmw5Be7qs5z1p3KnhDspVM2vdV1iHgSvoIjyhGlGdTe+xevBCD9Mkm80E7srMxEVFv22I9MkdUExA2VsThBw8xpcSsKNdauVvS04w3oFHb5Yeu0pF7GxAajU3hgJBzW1fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGIYD5MZ180lwH7oOyJvmWpHoXb8tcvjBQPxvNpTf2o=;
 b=qYVPl+rDk1qnBnTdDbu1cJt7fgmiJF5pE3jobGNVU1UITfWISNKDu+dbPfE0/mDO1I9lrnPD/im+/H97lXxS5VXJol44qbqnJ/8kwDIWClNprXkgv2yY2zzq3+cKS8pPdFw/gAkWM57qAWPNY3DjbdG6qbUdOmSPtxGpc0J9irklsI0PbGwJKAtM+sBxlVDaaw3rpp7mQN/zJa3rQt3gNJbLsoa3dWagF4R5BBKlIOtyJ8Lrpx/6DnSbY+6gyz5x5EsENup404WI2FiyrKNXuN350/aX32j/6Md1Vd/VTCwPv4XQFkjGnkcNOGBDyXZ4O+Jz1F418mXoenw2VXF1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGIYD5MZ180lwH7oOyJvmWpHoXb8tcvjBQPxvNpTf2o=;
 b=pM1NS1FXE+Eip61nViMv2y0ZkNZn4T1s+AOilVXZXoy2AIjwXTZk5x+qgE4lbINecFHxNmblCkEfOKHx8e00wD4c4LoRFAexWi6Cx0NYz94U9ItN0SfT2CnPxFNG/R6Klxp+8FLcu0zouruCGLlgGLMCntAXtSOPDXgQ5fXuA8i2twMFGB3waLzT7DT/DCvfoyQiT6YiiNFaWQonwioB9sIz/2pcB8V1e8jcwSGRxvlqGxrwcAG4TPvqJQu2VOnypSqjkAYHAOww1TMMDR+oNGWRz1R8Z9vEO7filwc+Ub4llJQqqa7u2x0YpwGd34lAtNtvvubFfR/rlp2rZcgOyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 15:10:20 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 15:10:20 +0000
Message-ID: <aa1a5867-17dd-4fd1-946f-d8d89ba80381@nvidia.com>
Date: Thu, 23 Apr 2026 18:10:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] vfio/migration: Add tracepoints for
 precopy/stopcopy query ioctls
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-17-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260421202110.306051-17-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1d64ce-6563-46ce-a0f4-08dea14a6f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MfbNZBR9S2lCfEpgHi8Pxnz//GtXEgM4bd/P5HGkJ9fSueTk75SJ0oarAGrgYsPYw0Af7Tq7+I18yfAJcRxTpAoGLjQhVrzFJEnincS3PGc8z00IibZwgjtAhcJY7SyxoRhRAclYnDVRv9hdo6yyENcfp/3JiYWVuGD44AvwmZv/V+AgOcsH+ZM9PBmTV9JZ3nMVyoPKP06H9Y0Kyw9Tze+9Dcpu5z5dslMcdAWDnHCgztF8Sf+nlkxIkci+vlElFFM2JYLHdKMFcLTTc4l0tQkROmSCCx5cwGdlRXUIn8VlxLUfPunXrtN518v+BkRqs+Yw4eImdt5sc02xXx2j0dpENbpdZj44rOyni/IxRFIP58WcenjN7nvANjGDjM6+xFe30Zw82Nw6wNOHX67+0qAi9ogvbNjAg+PxqJxgLcTk+9LT1P+96DHH5c6Mauej+TluXpzZ7IVlZOhDJLGr56sRQ9Tme7lp5oud+jjNNYkL6XgskYpd+q7tiAD2STgp2t0s9eIhL9/aL5jyBbNRTWKfM4gGuET9mGipPta3/kpoQkpcZsjfHYfA45Ay7dB0GfCsZ1a8PyCl9DffvFUebCZ6EKt5rKBCwzUmSKFweis5VSs/DkWVthU2uX0S2YnpFMFnOBbGlbpNxurIlPOy+8cSptqVx47Rq1Z+c+hNwRMphg0OhJoP1Vd4N5ljl6Q0i+Sj64DQCo1orWyo/5BPwi6kViDhyXkCEFd9tIew8n4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy9jMTJXbk52SkJ6aHhqQXJ6alpXWkllSjFGT0owZGQ3QVVNOGcxK3ZCT2hm?=
 =?utf-8?B?YmVmV2J4dWlLMWZ5aGY4ckZyb0g0UlBJWGhYOVhmY3pINUVQbFJaaU5xYUMz?=
 =?utf-8?B?MzFWYlFlelJWZUJOL3BpVDFGM1AwM3lEeUc3czBrYU51bjBDUE5ZeEE1Wmpw?=
 =?utf-8?B?ZndGdE00d0ZVQ3RxcEhuNnhnYTRzWWF4R0xBQUhxajZKUVdDK0xsMlp5bGJ5?=
 =?utf-8?B?ZXprNythbGg0d3Y3ek9LcCsrdk43bG54ZlhoV2lVQ0FjN0lLL2dJUFJHakls?=
 =?utf-8?B?SnlHQUVVeEtkdm0vZUVCQXFKQ0VRQ24ydzdSSW8zTEdvSmRMdk42RWh5dGwz?=
 =?utf-8?B?a2o1YThVUEJLUE5WWmlxQ21uM3Zta0VBb210RlNaOG4wRjhEc1FwUTFhSWVN?=
 =?utf-8?B?eU5lZUVDQkVHRFBMWjVRVjJyN3BhSCtBSzh6c3phazVTcnFBMHdQci9BRmlV?=
 =?utf-8?B?RndVRTF1YndzdFc0Mi8xekxmSEJkVHhoODBnSFBkVTRnU0EzN0FkZVlxWmFT?=
 =?utf-8?B?Y3BLWGFuNWRtcmc1MmNsd3I5aVVJSDJTb1RHRDV6VEJLeWR5TFoweE5CamJL?=
 =?utf-8?B?S0VKS3RQWEdjL0t4anJNMXk0RkdzZHVjNTNQYUxJL2lVd1FMTCtGNmw2aFkv?=
 =?utf-8?B?L281QXBYRGkvaXVNaUpXYkZSdWNrVHlhSHRMMTB1YUc5VWh6NmVLNnJCZzVG?=
 =?utf-8?B?aERLMmtKU3F5eXlYT2tFTlpxZWpNVWxMRHFLZzJZOHZySU56b3A0QnJjSjRN?=
 =?utf-8?B?eWh4cGQ0OXFxdGRuVlZDdDNVZ2Z2SHM4OU9vL0IvRGFFUlhlSzlxNjFKekpQ?=
 =?utf-8?B?MVhXQVdzbW0wUENWYWVZcm5iZEd4S0J4MEt1UEJsVkxYbFhKYlVwRmp5TDhJ?=
 =?utf-8?B?TVV0Rk9yNHR0SHhKZW15enFtTE11RCt6Um8xMmQydlN5aWdFNW81OVdxaG03?=
 =?utf-8?B?SXNSTkRFa1hpM29pZWNyR3JKWWVTQ20yQWhKRS8xYURaT0ZLWStiRTcvcnZO?=
 =?utf-8?B?MXFzRFpQdndyT3hoQWZKMFdjUDFiM2liTytZTnh1akRLRUM4eW1xU1l3QTdp?=
 =?utf-8?B?NWxGOGJNWWxKL3lHWmxOZ0NZU1FGNTk2L0cvblN4alQrc3Y0U0hucHpISmlL?=
 =?utf-8?B?cTh3RGNueWsvbUtDcWpUU3VxQXFHeU5LYmJ1QVlYNHI3czlNQVNuSEhaKy91?=
 =?utf-8?B?c3E3V1RuYlBZaGF0MksvMXdZcEdFRlVSWndQSTBJWDI0Qmt4NEV5NVNxaDRs?=
 =?utf-8?B?dk5UeTNiM0s4OCtYNlAwQ012YWt2NDJwY2NWOGwxL0YvTmlnS1ArcmJXZmhP?=
 =?utf-8?B?UHpVbWc5K2NkRUc3VHZaaTNyVFZYdGI0aEtzeXB6bDRZTWg4RStITW9hOFNC?=
 =?utf-8?B?TUsreXd5bTdGSis1bU9ZM0lxb1RKRC94YjBVc3BjbVFWeTlWQTBGaTRpdjRD?=
 =?utf-8?B?Yk5VODErdnQwVFEzSVFzVEZiRDJ3SnlMN0RuY3ZOVGo2RmlCa3dITllVS01D?=
 =?utf-8?B?Rm8vQ2k1UU10SDBqblpnRkJHcnNJRHltMU91dkM0N0k4aThHT0VvRUVsaDBO?=
 =?utf-8?B?Q1dTMTluSW5ib1FDVVJqeU9DUzNmaTZYdHh3R1VlTWkwM3BFbVk4QlluRlUw?=
 =?utf-8?B?QVgzN1pDM3dVd2NSdkFSSmtXVVJDQ3JCNFJWT3JVQ2w5eWd3UVlhTFNhRm8r?=
 =?utf-8?B?d0c3dG9HS1BCMHB4K3VodnpUVVZvQk1MUnpxcXFiSm41dkk5VnhoNmt4d3hI?=
 =?utf-8?B?WURhQ2llVE9oMVVlWmU1Mzh1dkV4TkZNdVJmb3VNL1dhaVRyTVlobkRaR3Na?=
 =?utf-8?B?YzdGeWNpZDVlVDZSMnRURmh0dFRtWXVqRmNERW1TeEtSSUpjTXlScFE4QUl3?=
 =?utf-8?B?QkRWbWJIOVNsTDFPOFBIbE9ja0lRemk4cHBUdlJMRjVNeXRXWkUzblNGbVNv?=
 =?utf-8?B?WE82M3FCRm9odTlURXJUK3pKV0dzY3UzRCs5Zk1iYWtKa1ZORTc4NXNCU3Bm?=
 =?utf-8?B?cnh0eklTUWlaTkdwSTRyRjJFckQ1UVUrQmFSc09rRHAxcEJSaWdsdGsyQTVw?=
 =?utf-8?B?N0NlMzc1SlZPMzExMTRjaW5jZllNVTNpQll5US8wNjF0T29KNWFPbUVaYTBu?=
 =?utf-8?B?d2d4TTBxTnBmTFpwbytWSW9XWS9HYW02d1FzZ3RMTy85cmVJU1R2eUR4Y3Fh?=
 =?utf-8?B?OHlHbnBhQ1c1eDZUT1VIQjBicU9Yck95c3E4dy9WQ0luaWc5aFZqVTNnb25T?=
 =?utf-8?B?OGg3SG5rZ2hKTWJiRWc0TjNWQm9UUit6N0JmN0dnTmVkcTd6OVdGNEw0NEUr?=
 =?utf-8?Q?epibsyUayBeWY+uyVe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1d64ce-6563-46ce-a0f4-08dea14a6f23
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:10:20.2341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5Zm245h/fmsVGOAoYzcFHSd93m4PW/RIPAy7Yp99kah47Q69RtInLXutDUuR0CDBQnHY7PAjYd5yjtRt5Crow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 4/21/2026 23:21, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Add two tracepoints for both precopy and stopcopy query ioctls.  When at
> it, add one warn_report_once() for each of them when it fails.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c  | 33 +++++++++++++++++++++++----------
>   hw/vfio/trace-events |  2 ++
>   2 files changed, 25 insertions(+), 10 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


