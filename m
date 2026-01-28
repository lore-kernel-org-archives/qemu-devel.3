Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31D5D3F06A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl69b-0004tQ-D9; Wed, 28 Jan 2026 09:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vkxH1-00050I-Ou; Tue, 27 Jan 2026 23:35:23 -0500
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vkxH0-0008Vx-3f; Tue, 27 Jan 2026 23:35:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj6GJz+vW8n6EaEGtpItg3XoVH7AGd6I/GkhS19M8/gYQ1lg1z1xeV4IPhJtT7ilIWRYHEGQAivedC1auKjMn0aIKkJPQ3UQms0OGa8X+sFfrRo+3IpS/Y8pivVQHTYR81Ty+h/MSUOa1uFfaM6QC4IO4kts6aSbxccSUx828sRxxc+ysLELO59+iZrIGN7Wu3KsgcTq8aVxv5Uk9tNOUCtAXU0KkExFX2EQuOXNfWwvI1ld/UhiI84WtZ2M5QLmP6T3d4IDHz+1WOYkTQIpz/YN6l24eJ5kmvlY2MNvpn7xLG+eesuzzr+QYOWXHaLoaIgVbVb1isc27esNGAzIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXnt2/xawsByAiSkACEJEYSAXo8wPI9yPVJQYpHQqPE=;
 b=k+U9PfmEJc9zhFaHlr9LHtK5RKQyxHK7Ag8i8D5P1RtETy2D4g2cJYCw2G5XVM+BZg138n1FsfAEU9TiWhhcwbWFCp+6LPkAG20U/V0A3nmd9toMKMt3twLxxl6MFemPE9ic7km5fWVGF63SvrewNPy2Ap2P7OqJoSORQxNr7P5VLm8n+8CB2H3+J+PqLV9dy4DN8IjdZnq2iB95VodruYGjkiqWmBycq4/AdAhiyfzO62P910jdehVU+m2SDvp/23wO1bS56jRW6hp/szx07HCoemh6VfinKbZ2fvPCTNhb1c7mIwPgNCEnwxCzMLrbTeTavzDyyTHzJk7Iztme0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXnt2/xawsByAiSkACEJEYSAXo8wPI9yPVJQYpHQqPE=;
 b=uK5gWrXcZJIFk4wRjYJEcVP+EByodarq1IjhrZo9bEs6CxUx83LL0Ijba2V5ooJPhROmsqEni5gX0xFcmUZ1uEXNh0Cw/n+2AEyaxCUEjQrxzTVizDujpdRWzjrOy71OE/QtoxvYRRFD9GDEYwhCspPPqppsrUUIv5CVV81WFK7hj/fup2Gp4tVnaBK/qcRVgHChjUM8r2FFAbzU87tpJGW7noABfjdygX2I5YWNS0/qAGOkt4Pj5oVrSvu7j1Dj2aCo+xsNVP/Oac/4hiT2vw2vNbpHG1UAs3R8YexM0sNkFU/xEf2tKAJqr9aIGbCpC7YUZhrhIxpP7Ad8STAPjg==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by SEZPR04MB6754.apcprd04.prod.outlook.com (2603:1096:101:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 04:35:14 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 04:35:14 +0000
Message-ID: <KUZPR04MB92650E89128FEF4F0F07BE06F391A@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Wed, 28 Jan 2026 12:35:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv/virt: Move AIA initialisation to helper file
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260114012846.981884-1-joel@jms.id.au>
 <20260114012846.981884-2-joel@jms.id.au>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260114012846.981884-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To KUZPR04MB9265.apcprd04.prod.outlook.com
 (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <29a767f2-fd3a-4ae6-bd79-39f29528509f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|SEZPR04MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe6ce8d-9f3e-4657-b932-08de5e26a157
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6d5vbofsfC/jnGJ+j4hG4EC0YkT44eIXGUImgEeBGLb1R7tvYn4RQwIEs/eJsSh8ilUCUwe9AM1dn39RZYZj/j8CoSQ1T57jefaX842uiUOTopH8UpCNe9Rh8fMf6sf/a4W1+DRNyCdBNpiwm6hDSB/QIOh/TKp8yBGTcghyYvX8UFgkkeln6LlFHoGgPrXQomnREnzU1wmSOAD/6iHlPufen3EBEpm45g3EZeh5RsPIyDPDcCC0ED02hUDFVB7GQvJBiTfy2yqm8nYLSzouJlpJ4Z67rshQyTGmjRkY+UtDvKWzlG/oxOMqDcR1A/2IvZiL94goaaCG8QTmSpOA13VwyRnbF2Ypubg2UbiBbe1M0bxwdMejaRIYDV//WDcFP/4JEtSx5QP5OdRW/Yi/zMf7Dk2N7l53bbSLuozTPGo2vfLekutou3wQ0wzadPUGczd/auKGzrX/euzIR3QJ4I+smvVYsqUaMAstWGveTtoaxy8VCvTXbqHs1Le5lut/s+VRZwdytCDTrgE4mnxkmPVI/pnsUj0iWoDYZF0UugM3HvJrfOMO7kkI/4jwWlUXfUSDsWIRK3eQQr3GWDa16g9CxZ3feM1eIk8kXQR0gHOoIgVvz+WhZ15zAlFshU1PnKVibAFgd0XqY7bhQmX5f4WlxrSDe3RHfg/cg1NNV96Bc2somt12E/Xm4lmFZCcZdHzc4cXV1U641diBmqtX55YcOnzbFg1u/psbHvBcPBPxtvtn/YNhPgaTMGeIZYQ5YE=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|6090799003|461199028|8060799015|19110799012|7042599007|23021999003|15080799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?end5T2tnUE1pVTk5dGN4aWw0VnNjT2JFc1pMOStGc2lxNjJCWkRIcVJaSVhm?=
 =?utf-8?B?aU1jV1ZvN0lFYkthQzJMTWRIbXZVQlJYb0FiaWNHMmhteExzVDV4dFRkRnNw?=
 =?utf-8?B?bS9jS0ljczRWQlhnSThMeUFwS0RUVkQyakNjTmZZbkIydlMrTjNCZGsvTjQ3?=
 =?utf-8?B?WGk4UTJKdXMvMjlxN1c1WkpWU3diMmkySysvQXU3SDhNbi93Y0RYWkpQb2Va?=
 =?utf-8?B?MzMwKzBDMHQ1dnRJQ004R0tFUjVOVXlFalFkTG82RCs2dkovQ0lFRjI5OXlJ?=
 =?utf-8?B?NDhua2NibmxFWHprS0FiN2duelE4UmJONVYzbUFDU3QwT3FlaVBoT210VTFC?=
 =?utf-8?B?S1ltNC9pd0VhZzRyQkpzVTBPT0JYb3UwVXZyOEtGT1c3TVBiUW9UMDZRSkRG?=
 =?utf-8?B?SjJ1R2l0UGJxdDJKbCttaGNOdk1iZE9xcnBBNDNIbXFrK2pTcWlxcHp5TGFj?=
 =?utf-8?B?b0wvMG53SVhBL05Md01HSzM4RmhHQ3d2RjhUR05idjB1Ync3MkxCL2xPYUZ2?=
 =?utf-8?B?VmRZeWFJamx4N2NHUW1iS1lSbXp0d3h1RkhsUHBJYnpHc0puU3Y5QWRsZVI3?=
 =?utf-8?B?TFJURkJVT1lZYTA4Rk1LamwvaThEWDczbXdYMm9kOTlXT2loVW5CZEpVcm9I?=
 =?utf-8?B?aWtuOGUzcVNNTUhjaFZpK0RnVmM0YzlmNWNxbm15QVBMc2hWM1prR2ZKQ2VD?=
 =?utf-8?B?a2lvQUdQSlNYdDFLaER2V1ZmaFNNR1BtNFdkNWo1NDRDTExBMlN2RjJUUGJH?=
 =?utf-8?B?SXBQOW53OUk2NGlYL0FYNmErT2JZcmNORGdiSkZ0WVAzdXpkQWhJWjdlbG1B?=
 =?utf-8?B?dmpoWjRxc1FrbncxeVdqalR5cThkMDQ2OUVqM0lMSFVXY1RsT095dDlhUXB4?=
 =?utf-8?B?Tjd4aVNaekhyNlUvUTBlQUZYRU5jNFh5VHgrT2VzMmpSRFVzNmVJNW51L0Rl?=
 =?utf-8?B?VDM2M0Rwalo5RmRlQ0x6LzF5Z3lHRUIvTkNGYjlWUjBXVGJROVFUbk1ZTWNy?=
 =?utf-8?B?RzU1NGgrYlErbUpzSlNsVUtVVFpnT3dwTllwTE84U3FrU0RLVy9jOTNzQU1k?=
 =?utf-8?B?N3RJd3dieHovZnpNOUJuNmEyQUJYSTZXcXJEOTFpYitWcTY1ZDhuSXFJUVV0?=
 =?utf-8?B?VVc4b0ZSeUREWGZvamRlWVM3ZGtocU85TWhhYXFwM2JxK1ByL056bFIrSk80?=
 =?utf-8?B?dkpXSlRadlloem9LZjFMS2haU2xDa1BFVVJLSkdQTmpZcGY3dVp3djE1QXF3?=
 =?utf-8?B?WWQzQVVpMXFDZ0NoNERnK0pjVFJCMURoWUo0Ukhqa0lZd29ZKzZyM2p1Q0pL?=
 =?utf-8?B?N0NsSGY0L09tbGgrdkNvelprRDVuVEVQbE5XZzZWaDdCT0VyM3ZJTTU1enNB?=
 =?utf-8?B?MTZ6cytLRVBYMlRla0paOTRHTWNjQkJ2THJqSEFNc2xQc1YycTFYR1FZa2F6?=
 =?utf-8?B?TmNCK1pGZWZCYTdTRzRrUGJuak8yVityNDVQSnBwTGZRRS9ydktyZTYzZEtE?=
 =?utf-8?B?alkrNlhCYmVTb1NJdElqQzNwbW51TWRpa25ncFRLVjlQUG53RUJSZStHSGZi?=
 =?utf-8?B?YmdDNXRSbGlVNlMxRXhyckM1dHZUbHN6UG54NGhqbWxXdnd6Tnh6MjhXNm9a?=
 =?utf-8?B?MnpVaE1WV3ZwNE5TdjVIV1hyMzBTOEE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFXQzdFVnRobWVpNVNiSUR6TEdocjlTekhLNEFxeStGckdvYWZvTkV0SlZT?=
 =?utf-8?B?VEsrVTBjRjhEeVlMQWF2ZE9JUUUwRjRFeTNEMUpVcjE1U0FFV1dDRTJmVURI?=
 =?utf-8?B?OEpMZ2IxTHYxRmIrZ2xSSVU1SENpMTdMTzdiUlZFK3FrN2ZaRllmRnc4Mk5G?=
 =?utf-8?B?Rm1BSWljSEZ6SXY1M2J4c0pFT25EU2hhOTNWWHlKQWxOWkFVMUZuWU1JN1Zs?=
 =?utf-8?B?ZG1VSkdvcFl1aVJnM3FueGR4bzk1dkM4MXFJVjJuR2tWTEpqV3FteElWSSty?=
 =?utf-8?B?S0s0bmVSZElGTWFMUTRVTGRwQTVBcDFDcWpPa1A4bzRwby9aS2JKSXFEOG5q?=
 =?utf-8?B?NG13N2lBZm9reUhGQ3dPakRNWHc0THJJR0hxN2htM05ZU0puQkNRZG5TSVhi?=
 =?utf-8?B?RWg2RG50MVpUbGVPWmlCMDJLMGV3djJzb1B1R3BpMThkOUVqM3VzTTllYVpP?=
 =?utf-8?B?bEllT0RHbGRzckpJQUFSM2tPc2Q5bTJLbVRGNXI1Z1RmblErTDdCajI4ZEFL?=
 =?utf-8?B?TEZTZHhHaVowbWNuL25LYXZMVVBKZlFSZUxoYnNCSUxKTUZsNk5JUGNsUHFp?=
 =?utf-8?B?MjhRWnV1V0lhbFk1NklVS2daNXhSR2VEa0tzaDBSVHBrUkdrUXU1NlBmRVFH?=
 =?utf-8?B?UXUxWFcvblpLOWU0bU51ZWM5OXhZaHdXdGd5dW8wdW1pdDhGK3cweTEzTnN1?=
 =?utf-8?B?VXdYY0lDNHVreWl4ZExxa1BpU2dxYnRqMWRueDFuRnNQM3dDUkFKQStFRStj?=
 =?utf-8?B?U1B2RUF5RzlvY2F1d0pMVlE5OGJKWkQ1MitNTDQyMDdEclRaU2VpV3p0Y1R5?=
 =?utf-8?B?T1NTL2lUUVQzczRJdk50Mm11UzZBZmM2N3lYOFh1SHY2UjNoVlVqM3k5Wk9y?=
 =?utf-8?B?UE90WjJoaWR4UFNKOVF2QVVVUG5WaUNTL0JFbWtDMDZHNTBVbFdrYks5NUJB?=
 =?utf-8?B?ZjFIZVp5SEdsbEp1TFZSTlYvRkNSbHgxOHVZNjBOOVBGaURlbS9PYXpqTHdt?=
 =?utf-8?B?VU5GQWNyRUhOT3J6QXovVHVhQ1ErNVFURUdSTnkzQUg3LzUvT3NUUVA5NE5R?=
 =?utf-8?B?MjVqTVhUbkZsYlRvT2NQa05BdXBtSFFhYTIxc2pqbjh4dWc2N3p3ODdHUWRJ?=
 =?utf-8?B?YStnWEtvRmhyZHJhOEtOaFlZT0ZHaG1jdzZ4YTY1TXBTU01PY0czZFRPcS9I?=
 =?utf-8?B?Y3Z2aXFCM29VY1VCRjVuQnlUMm9IcFptekpwa1JFaGtvajBPM3FDcE0rcmlu?=
 =?utf-8?B?Nm9lYjhxNFFZZ2txTXdHZXNCVU9IZjBudmRxYmUyS3NSeXlqci9LZVlwYmNm?=
 =?utf-8?B?Q1ZDeGdhRndzYm1Lanc4UThnN0tYMEhlYU9nNUg1VnRaMTZtOFpyU0V5RXJ6?=
 =?utf-8?B?SWR1SGpOY0hZa2lVcDUxWUhwbDQ4LzAwakxmcnlveGMzZWE2T1kyaWpXM1Bj?=
 =?utf-8?B?SjV6U0VxWVQ4Z0lFSU9iMmtoZjBLU3ZiZGtyMFdYZWhWdHJBMkpGcUVRSjFC?=
 =?utf-8?B?Y0gyWDF5NnpkTTNxeFhZTjVNS3lnSUYydjRiTFdtS05XSEpLZ0hYbmdHZnMw?=
 =?utf-8?B?SzNib3RRUWpwQlJBTUk2Q3Rjcm1OaDB0aENvTzlTYURNSnhpV29JNnZJVHg5?=
 =?utf-8?B?L1dxakFyUEN2akxQUE1IV3liaENoaUpoMk5JeGYxKzVBNjliLzVrRWhCbHBr?=
 =?utf-8?B?SldJR3laM0o3KzJ6OTkzenZTdEExeFZhVGhHMC9zbHdwcXBLa0hPbm1zMnVn?=
 =?utf-8?B?NkExajcxazJicS9lejhGVjFjSTQzZTlGc3c2ZGRKM05NRWRBOUJXZFQyZ0E2?=
 =?utf-8?B?L3h0SXBFK0FWRmN3c0hZRS9XcFZxTlJlOFg1T2Z2bytveVBabDBIbDBCbVRl?=
 =?utf-8?Q?J6KRn6SuTmyHE?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-515b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe6ce8d-9f3e-4657-b932-08de5e26a157
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 04:35:14.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6754
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Jan 2026 09:04:16 -0500
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


On 1/14/2026 9:28 AM, Joel Stanley wrote:
> The AIA init will be used by any server class riscv machine. Separate it
> out in order to share code with such systems.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
> v2: add Daniel's r-b
> ---
>   hw/riscv/aia.h             | 58 +++++++++++++++++++++++++
>   include/hw/riscv/virt.h    | 29 -------------
>   hw/riscv/aia.c             | 88 ++++++++++++++++++++++++++++++++++++++
>   hw/riscv/virt-acpi-build.c |  2 +
>   hw/riscv/virt.c            | 85 ++++--------------------------------
>   hw/riscv/meson.build       |  2 +-
>   6 files changed, 158 insertions(+), 106 deletions(-)
>   create mode 100644 hw/riscv/aia.h
>   create mode 100644 hw/riscv/aia.c
Reviewed-by: Nutty Liu<nutty.liu@hotmail.com>

Thanks,
Nutty

