Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90232CD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJV2I-0008KP-Eo; Thu, 13 Nov 2025 05:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJV1h-0007ht-Sm
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:58:06 -0500
Received: from mail-francesouthazon11011007.outbound.protection.outlook.com
 ([40.107.130.7] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJV1d-0003B7-2H
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:58:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwqvx4ZdKjRLhY1kZzRWGfHVKuvXD24Qw2YWqijmkD0HK/tA8OJn3Ur+uov3h3SVw4mc8QEImS46pYII82Z9bhUYqataCcNfju53sahPLgVyOxpQ63LXYVQszBMcwPoBFIr29tJfx/3329uXQTaJCgDGPfP4UX+VVlzDFzkO3wSAljy0OXEnsz0942PIJyLtFMq7ggr7Znwm30s1yXGZDO4sgu60EKo5wa7sXjYELgqy2jvAyPcU8jV5AONHXqFjDIeV6nGliu9S+rrRRJlBoc/a064eLSz/aJardQs6mJAqm3WnNVpcT1ycz2Yq4JfOlQTPzI9SGatpTIsHRb7n5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaMIFZwpPtMHxbMUNcgAZg1ExfxEr13HLuLVcLh0OS4=;
 b=aSrpP1rTXNxMtRHy0mSCxPMcBng5rAGLt4CkrI19tx9tlguYCfODOjIsDjyaT5QtPkVCewzj+oNX7HyVewTB+8uwUHNH7vNt0k396b1YU64dIG1CNwjrwBUNW3auHlSGg1ChANr1+X/9Z0Ap5NbEk+5F04MEis0dwMOQucbxb9oMlV2viUo8BMMoEt+utUEpeoGMC54FG6HEb34fLB9zi1/yBnTun7bIK94irIGH6rEc+gqmgAKnuRG83OumwDVILXAFWFeQSHxjEfPAve8kaSj4YUpXyZFArDtmhN82XXHt77VJKbQj4wJ5/Pe9l3lmfTogIuiabacz2yIgjCXEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaMIFZwpPtMHxbMUNcgAZg1ExfxEr13HLuLVcLh0OS4=;
 b=g5SCsS5ZS/sd7g6Uwupa6Y25Zjh+HR2Ftd0ku3DPXD1VqQKaO5Uvi6guiJvud3ntWBEJCmeX2QOB+j5dXqZmAVwJvE6F9VG6P9ywCUA5inv1kOOSO7e1UCW2BPNPtN6/DOupiY1fuhm7vVZ8RU8XpD+QhWsWuwVojZsLGXvCFAw28/W1KHVVbxyRH6+biBnG0/9f0LeezF+u2P2fRMHJjQQtSvoCPQhfGDQJjkmFCm8cQiSstm6bRsDTowW/vobR/f3IajPemDgMbqNQsWprxGi+MC3vc5FpuiYki8FMrYWuPPNefJYdC6ms2pQSOp3pSXL6EX6QtFMJOA5efwTshA==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by GV1PR04MB10845.eurprd04.prod.outlook.com (2603:10a6:150:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:52:54 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 10:52:54 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCH 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Index: AQHcUjRwGlPwlBhZz0miSX67uwfg6rTuJcwAgAIcKzA=
Date: Thu, 13 Nov 2025 10:52:54 +0000
Message-ID: <AM9PR04MB84872E6EC84C52E32DF8039E87CDA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-2-gaurav.sharma_7@nxp.com>
 <456712A0-D581-47E8-8EFC-FC32B2C23445@gmail.com>
In-Reply-To: <456712A0-D581-47E8-8EFC-FC32B2C23445@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|GV1PR04MB10845:EE_
x-ms-office365-filtering-correlation-id: 100599e0-c2e7-4fb1-1672-08de22a2ccc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?cEI3Q3AxQWhYb1krd2g4UG5GalI2b2s1c1dpUUF5WHRGSkJuTStNc25T?=
 =?iso-2022-jp?B?Z1pqRkNyb3BpSTMzamNNTUZ4bzk2ZzdKQlI2R2krTVVScERtaS9taDZp?=
 =?iso-2022-jp?B?aGxRZ1F1U2pmMnk3N0ZaQmdzYjh0R003Wk1WdndQSnF5UjJVWkJJOTdL?=
 =?iso-2022-jp?B?VEpCWmF4d25JY0NlZ1ZSU2pYSjlCMGw1VEdwMmRUWFlrMitvaGZYVVVP?=
 =?iso-2022-jp?B?K2xCMGN6ZWlDUXp0S1MzcXVNdUdia0I1WXg5VE0wcnBXRHlxSDRHSmM2?=
 =?iso-2022-jp?B?ejNtZlBQQklKcEZrbEdlb25SaTQ4S2pteS9vbFBhNHNIMXhxcG5nMmty?=
 =?iso-2022-jp?B?dExtSzdYc3dyTEM3aUwvUXpzWHcybkZ3YXlvYjJieWR1VUFsd1NEQmhl?=
 =?iso-2022-jp?B?QXhBbmhHNnlZYWErY1V6ZXVTNEtnT2hvc3AxbjV4eHFoY01IZFBBTG1h?=
 =?iso-2022-jp?B?TmVaSzh5aDRaRkE2MVJIbGFldHdIZStiam1xakdRN2g1dWZjbzN5R203?=
 =?iso-2022-jp?B?NUlwblk2bHZhamU5QVhqYW16R05JcFgvNFRmbmZ1L1lXSXJ0UlpKZkxF?=
 =?iso-2022-jp?B?b2tOdXVRTHJreXFHWXV6UXFmQVJNL21KMGJKVGkwSXE0Wm9TMHY2aTM4?=
 =?iso-2022-jp?B?bXZodjVpcnh3YTdQQjR3N3RVY2hMRjQwVXI4SFhLQ0c0ZWlrM1gzL1Bm?=
 =?iso-2022-jp?B?NHMvcG03b1R4VWRzRjB5RkpYZVoyc2JmNzRXSmdvdndXdVoyMkJ1c3Iv?=
 =?iso-2022-jp?B?VUJJcW80ZTRkSXB3dlg2THRva3YrOXpCMXgwRUU5Y3hJUEs0TGlWT1JL?=
 =?iso-2022-jp?B?T1JKYWdIOHFCdnd6aHlXMTZmZzhqbkFBRUNVczc0UlNoQmloeVV6ZHI4?=
 =?iso-2022-jp?B?Z0cyTXNFTXJkb0RodEVpVjRjRFRtaytpZ2dHczRPNHQ0ZDFTbjNoaTBG?=
 =?iso-2022-jp?B?T2hhS2ZwK2VSVXcrY3RDaloxYzE3eU4xN1EzeFZZb1lscXFhSjZxK1dV?=
 =?iso-2022-jp?B?b29ITS9ocHlxeU9XaVhSbUFnK1g2SzZOQlRKcUtDRzJzOU94OVhGTXg3?=
 =?iso-2022-jp?B?MWRKdlJSaTlobVZkNnVyUlEwRzY5bkRDREVXOUpHSGd3TUR6eTVMcUFW?=
 =?iso-2022-jp?B?YUFxWFNseE9ubTBRUGkrR1huWTZtb0U4OVJjWC8vZUp5ZHFjbWFPZlBO?=
 =?iso-2022-jp?B?VXhoMXpzZlZybHNYa25hZGwyTmlYY2QwRlkrbE94UHBLNmlFVnI0K0x1?=
 =?iso-2022-jp?B?bDhmdFVMakV0dGF6ZHYvdEg4N2VGbXBxSElnTDRjRVVzRlIzd3FhVE9I?=
 =?iso-2022-jp?B?VDlQZWFyQ0d1bEJFNkpEQjBZeWF4eVNqblFMQVdJNXVoQXVXRGlTbTlw?=
 =?iso-2022-jp?B?dE1TSW13QTlHcGhMT3h1RnFGbzAyc1lROERteng4WDkvdEFLMm1JOFNj?=
 =?iso-2022-jp?B?bVgzWUJlbm5VaFZ0TTBqNFpndWRiVFFzWDBNRmtybVVYTU9hVk0zdW9V?=
 =?iso-2022-jp?B?cHBlOS9KUTRiSTJrSGViaGR4ZDcyOUxFOTV0clM3dGt1bk1OZCtTMFFC?=
 =?iso-2022-jp?B?eU5rNWg3N0hRdk1wWW5VQzhpSTBxelNTU3VHWHhaTTUyMnFLb2tDK3dB?=
 =?iso-2022-jp?B?U1R5V0ZtY3k4TENHdlJBcGg3dnBjMUpnK2ZDOXlmRGJoczZIYnlTaE5J?=
 =?iso-2022-jp?B?VmhMN2dTcEMwbWNFKzQyM3lJTnRRR2ZzWG15L0w0UjhVSWlWVG03Q2NC?=
 =?iso-2022-jp?B?RHBNZkkzeGZDaHB4WDlXZTAyQkFhVHlkMDBxTU5uRmF2bHZmZ1g3aHZP?=
 =?iso-2022-jp?B?N1dyZGlaZlNyVU92TXcxajFPb0gvVjFPeE8xSkR3SzhHbzdiWEVCcjFP?=
 =?iso-2022-jp?B?OFBOZThDTHVlY01sTTFFU3oyUmV6RiszSVI0cndkNWJXaDl1S0pZdlAy?=
 =?iso-2022-jp?B?enFHS0hnbGtlWURVTHpwTWNyMWVQNTBGUlRQRHlicXpSQUQvU2dkcmxM?=
 =?iso-2022-jp?B?QlpUdk4zYUVzdzBXdndOMG40a0tkYlNxNU9xZmdSajNQY1o0TTFtMWJj?=
 =?iso-2022-jp?B?TDRmUGxRZUlqQm14Y0Zpdm1wc0J5YllWOExscjF2TmhEbEF2VDhxMXcw?=
 =?iso-2022-jp?B?T0FqL0F1VUIwSThEaTJpYlZVYmVtZThHVWsxeWNXREtPSTRzN3hzV050?=
 =?iso-2022-jp?B?Mko3c012b2ZjUEp6dU00T0ZibDZ6d3RT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MVpiSHZaNXNpZllyYzNWNWIxZ1pNam9XQWVYVS9yMXhrMDViVlZhRzZP?=
 =?iso-2022-jp?B?a0pHZkFpSnBMR3JyVnEwdm8wOCtNVFdoelBoSVFFSXAxcGE4WFlscVdP?=
 =?iso-2022-jp?B?NU9XVTJDTkIzMFdzS1JsMGQ4a2YrZzNuRXlwdFZnUXM4VWNYaEZZRG9k?=
 =?iso-2022-jp?B?N2pLb25SYlhuZ2d1WFNzZzFLSkxGbDk0VzQ5YXpGWmJodHBBZEZFVW9p?=
 =?iso-2022-jp?B?NzNBSVh2YkpWRkwvU29iUnM0WSt2c0xOMkVDeUh0RlpuVnZWbG9PYnl1?=
 =?iso-2022-jp?B?S1dJY0U0ZnNBZmpFdDZhV3J4TElxUzIyWWhMNVFXNUFRMUNjTGVNNjRY?=
 =?iso-2022-jp?B?ZVZudjhyZldtalpJZk1PODQ3L1NMbHAzYURrZWNuUWNRTVBHRDBxZ2hk?=
 =?iso-2022-jp?B?U05UQlZ5S3pRdEQ3VWdaZDdhdjJZZ3FPYys3VkZ4eDRpM2RZbFN5ODc2?=
 =?iso-2022-jp?B?ZlhUSFJIaHN5azYyMHNJcEZPTWZHOWpqYnNxRVlwcmpFd3ErRzhoK3hD?=
 =?iso-2022-jp?B?aTNINzJ2T1owUHdxQ2NodXNBTGdLS2hqMnlOZDhWcUt1dmhBR1lXNitB?=
 =?iso-2022-jp?B?eWhrcUJkdThoYytSbS84bytOcW10aVVvVjZWZ0djbS9tR0d0MEFNNllv?=
 =?iso-2022-jp?B?VlNLYkl3K2VZbUdYaElHNGwvWE9FNU9DcU1QZHU4cDEwOE4rR1NKQldC?=
 =?iso-2022-jp?B?K0V3RzRpWW50am5jT3ZLVDRqVTlKaFZzZE9Xd0VIQVgzU2dOUE5LUnBQ?=
 =?iso-2022-jp?B?T3l4ZWJRT3BDU09CK1hQMjVMNHN3Q092OEZWWFJkanhyRTBxTHFyeExt?=
 =?iso-2022-jp?B?V2x6Y2RtT3NRVWdtU09pM1JhTjhXMmQrMUZtdVZLWXp0QktpWXd0WVMy?=
 =?iso-2022-jp?B?b0NTdEZGbXp2Q1l1TVFCa25UV2J0dlFRMmNUMGp6d0FtcU1jK05BRjNS?=
 =?iso-2022-jp?B?Tm1pY2dyd2I4RTU2Y2pzUDNwVStqbU1TRVlLUHEycDZ1L1pmQk9Ycmpq?=
 =?iso-2022-jp?B?c0VrbG5UYlREMFFLVzZrU1VFdVdRWmU2VDRHMzV4MnVDL0RUSjBxTXIx?=
 =?iso-2022-jp?B?SzhWejNiSVAyd09TbWdicmpSUnI2ZUdjZCt1QnJ0OUdrV1Y2MmZqbUtJ?=
 =?iso-2022-jp?B?TGFMZDFRWGtYbWZWWGpkSDhIKzNrQ29aVDd1citHQXVucjVHWHNrQWZT?=
 =?iso-2022-jp?B?Qm9tZW5YVlpvUnVydVFRVFNXVk5XNUg3S1psaERiT3JqbmQvQk5Wc3lK?=
 =?iso-2022-jp?B?QzR2VXdwMTJCSEFsUVlXTzRnUy8zakdqUSs4WWkxVEpPOFd2cjFoZmp4?=
 =?iso-2022-jp?B?T0tmVXBGQUF3OFVRd0FjWGgwUWwvd0cwSStveW1keVB6S0dXL3lhNzVZ?=
 =?iso-2022-jp?B?Wjh1RlEzOFdqbURvM2RpTXY0U1p2N1M2UzB5WXZ1ZEdSd0xOdFMrTmly?=
 =?iso-2022-jp?B?eXdjZlNLSG1GTlBENGswNEVDNE81UlV4S3FIMXkwTlFLc0lqMEZlQWlG?=
 =?iso-2022-jp?B?bkg3eWxXMnJqbjRHVjcwc216SUh4MHZsZ0psVFJvSUcwdTRERkllTUM0?=
 =?iso-2022-jp?B?RkJGdDF6a0FsZjJFTXU2bXpibGxqOWxZcDcwemtxNytyb2pQZ245S2N5?=
 =?iso-2022-jp?B?MGN4VE5CdVA5NnJ1U3BpM2M1cmZ2NWUzR3hJZXZzQ0VUVXVnZHBINlBH?=
 =?iso-2022-jp?B?RDVPcEhDd0NsRGhsZWJjU0t4ajdDSHpPTkxJNTFMbVpZcHdhbnJtcmpW?=
 =?iso-2022-jp?B?ZzF6RTJNZG5oV21oanBMSldOWnlNeFUxRGE1SDE2YnhhQVVZQlVGZU9o?=
 =?iso-2022-jp?B?MldpZTYxVEVMQ0pDb3UxVW9zNU5wNlFHMThaeVZiMHlFMXZ1VzNMVUc2?=
 =?iso-2022-jp?B?UEJ6N0lXNDRTL2NDUWpvK00zUjJvV2FneXdWb1FPcjBPWTRQTURZSThj?=
 =?iso-2022-jp?B?bDZvU0FwT1Q0SXZhWFYwdmFiVFdZckpiTVFoZ3NrYVprdExsZ0tBTllN?=
 =?iso-2022-jp?B?MVNVZ0VGQmRlMHozMklTQjlNWlRGV0tLNUpJeHRCdGNUT1pPQ2RmSGZN?=
 =?iso-2022-jp?B?UjhBZjRsTUw5dFpsMWk3bVdkc3k4SlhlUFlZL2V4VlRUeEVCYWlxckdS?=
 =?iso-2022-jp?B?RmxJcU5Tb1lXd1dXZE4ySlpranVGa1c5QjV5MzY4SVRMQ2N3NmlTSThT?=
 =?iso-2022-jp?B?anl1NVFBUmZaTmRUK3FSakZtOWU0M0FFK1hPZVlYdndyRkZMK0V2THE0?=
 =?iso-2022-jp?B?cnBDZ213eTFzM0RqOGJRdHJWdlYvWTBQa2JKUytnUnhIUDliOXBkRTNT?=
 =?iso-2022-jp?B?T2o4bQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100599e0-c2e7-4fb1-1672-08de22a2ccc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 10:52:54.7899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVZ17ldXMEE5u1PfEVg86+BokRfBOsHcHCnV6vzblncAw/833lIVS6zWUFSZC8rNg6rdZqATrk0a2HXwg2GOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10845
Received-SPF: pass client-ip=40.107.130.7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"s/Plus/Mini/ ?"

-- Typo. Will fix it in v2

"`-cpu host` isn't actually needed since this is the default in KVM mode. W=
e missed that nitpick in the imx8mp-evk doc "

-- Okay got it. Will remove the KVM Acceleration section from the rst doc i=
n v2

" Any idea how this works on real hardware? I've already analyzed the inter=
action with src and gpc but all interrupt channels seem blocked. Any hint w=
ould be very helpful."

-- honestly, I have a fairly limited knowledge on the subject but this is w=
hat I know about the wake up logic at the silicon level:-

Timer IRQ =1B$B"*=1B(B GIC-500 =1B$B"*=1B(B GPC =1B$B"*=1B(B Power Domain C=
ontroller =1B$B"*=1B(B CPU Wake
After receiving the IRQ, GIC distributor logic sends a wake signal to the G=
PC if the cpu is sleeping. GPC manages power domains for each CPU, that mea=
ns using some configuration registers it can decide which cpu will handle t=
he wake request. In the GPC, the system mode controller will be responsible=
 to power up the A53 core, which then sends the request to the PGTSC(power =
gating controller) to wake up the cpu. Debugging in the GPC implementation =
and checking if it is receiveing signal from GIC might help your cause.


--
-----Original Message-----
From: Bernhard Beschow <shentey@gmail.com>
Sent: 12 November 2025 05:14
To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: [EXT] Re: [PATCH 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation Ki=
t) board

[You don't often get email from shentey@gmail.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Am 10. November 2025 11:22:45 UTC schrieb Gaurav Sharma <gaurav.sharma_7@nx=
p.com>:
>Implemented CPUs, RAM, UARTs and Interrupt Controller Other peripherals
>are represented as TYPE_UNIMPLEMENTED_DEVICE Complete memory map of the
>SoC is provided.
>
>Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>---
> docs/system/arm/imx8mm-evk.rst |  70 +++++++
> docs/system/target-arm.rst     |   1 +
> hw/arm/Kconfig                 |  12 ++
> hw/arm/fsl-imx8mm.c            | 363 +++++++++++++++++++++++++++++++++
> hw/arm/imx8mm-evk.c            | 107 ++++++++++
> hw/arm/meson.build             |   2 +
> include/hw/arm/fsl-imx8mm.h    | 156 ++++++++++++++
> 7 files changed, 711 insertions(+)
> create mode 100644 docs/system/arm/imx8mm-evk.rst  create mode 100644
>hw/arm/fsl-imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c  create
>mode 100644 include/hw/arm/fsl-imx8mm.h
>
>diff --git a/docs/system/arm/imx8mm-evk.rst
>b/docs/system/arm/imx8mm-evk.rst new file mode 100644 index
>0000000000..61d28ebf72
>--- /dev/null
>+++ b/docs/system/arm/imx8mm-evk.rst
>@@ -0,0 +1,70 @@
>+NXP i.MX 8MM Evaluation Kit (``imx8mm-evk``)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The ``imx8mm-evk`` machine models the i.MX 8M Plus Evaluation Kit,
>+based on an

s/Plus/Mini/ ?

>+i.MX 8MM SoC.
>+
>+Supported devices
>+-----------------
>+
>+The ``imx8mm-evk`` machine implements the following devices:
>+
>+ * Up to 4 Cortex-A53 cores
>+ * Generic Interrupt Controller (GICv3)
>+ * 4 UARTs
>+
>+Boot options
>+------------
>+
>+The ``imx8mm-evk`` machine can start a Linux kernel directly using the
>+standard ``-kernel`` functionality.
>+
>+Direct Linux Kernel Boot
>+''''''''''''''''''''''''
>+
>+Probably the easiest way to get started with a whole Linux system on
>+the machine is to generate an image with Buildroot. Version 2024.11.1
>+is tested at the time of writing and involves two steps. First run the
>+following commands in the toplevel directory of the Buildroot source tree=
:
>+
>+.. code-block:: bash
>+
>+  $ make freescale_imx8mmevk_defconfig  $ make
>+
>+Once finished successfully there is an ``output/image`` subfolder.
>+Navigate into it and resize the SD card image to a power of two:
>+
>+.. code-block:: bash
>+
>+  $ qemu-img resize sdcard.img 256M
>+
>+Now that everything is prepared the machine can be started as follows:
>+
>+.. code-block:: bash
>+
>+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
>+      -display none -serial null -serial stdio \
>+      -kernel Image \
>+      -dtb imx8mm-evk.dtb \
>+      -append "root=3D/dev/mmcblk2p2" \
>+      -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcblk2
>+
>+
>+KVM Acceleration
>+----------------
>+
>+To enable hardware-assisted acceleration via KVM, append ``-accel kvm
>+-cpu host`` to the command line. While this speeds up performance

`-cpu host` isn't actually needed since this is the default in KVM mode. We=
 missed that nitpick in the imx8mp-evk doc.

>+significantly, be aware of the following limitations:
>+
>+* The ``imx8mm-evk`` machine is not included under the "virtualization us=
e case"
>+  of :doc:`QEMU's security policy </system/security>`. This means that
>+you
>+  should not trust that it can contain malicious guests, whether it is
>+run
>+  using TCG or KVM. If you don't trust your guests and you're relying
>+on QEMU to
>+  be the security boundary, you want to choose another machine such as ``=
virt``.
>+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be us=
ed.
>+  This is a limitation of KVM and may not work with guests with a
>+tight
>+  dependency on Cortex-A53.
>+* No EL2 and EL3 exception levels are available which is also a KVM limit=
ation.
>+  Direct kernel boot should work but running U-Boot, TF-A, etc. won't suc=
ceed.
>diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
>index a96d1867df..d6a4b5bb00 100644
>--- a/docs/system/target-arm.rst
>+++ b/docs/system/target-arm.rst
>@@ -97,6 +97,7 @@ Board-specific documentation
>    arm/mcimx6ul-evk
>    arm/mcimx7d-sabre
>    arm/imx8mp-evk
>+   arm/imx8mm-evk
>    arm/orangepi
>    arm/raspi
>    arm/collie
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
>0cdeb60f1f..7c66f3c3cd 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -626,6 +626,18 @@ config FSL_IMX8MP_EVK
>     depends on TCG || KVM
>     select FSL_IMX8MP
>
>+config FSL_IMX8MM
>+    bool
>+    select ARM_GIC
>+    select IMX
>+
>+config FSL_IMX8MM_EVK
>+    bool
>+    default y
>+    depends on AARCH64
>+    depends on TCG || KVM
>+    select FSL_IMX8MM
>+
> config ARM_SMMUV3
>     bool
>
>diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c new file mode
>100644 index 0000000000..9c8acc1e99
>--- /dev/null
>+++ b/hw/arm/fsl-imx8mm.c
>@@ -0,0 +1,363 @@
>+/*
>+ * i.MX 8MM SoC Implementation
>+ *
>+ * Based on hw/arm/fsl-imx6.c
>+ *
>+ * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later  */
>+
>+#include "qemu/osdep.h"
>+#include "system/address-spaces.h"
>+#include "hw/arm/bsa.h"
>+#include "hw/arm/fsl-imx8mm.h"
>+#include "hw/misc/unimp.h"
>+#include "hw/boards.h"
>+#include "system/kvm.h"
>+#include "system/system.h"
>+#include "target/arm/cpu.h"
>+#include "target/arm/cpu-qom.h"
>+#include "target/arm/kvm_arm.h"
>+#include "qapi/error.h"
>+#include "qobject/qlist.h"
>+
>+static const struct {
>+    hwaddr addr;
>+    size_t size;
>+    const char *name;
>+} fsl_imx8mm_memmap[] =3D {
>+    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START, FSL_IMX8MM_RAM_SIZE_MAX,=
 "ram" },
>+    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB, "ddr_phy_br=
oadcast" },
>+    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB, "ddr_perf_mon" }=
,
>+    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
>+    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
>+    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" },
>+    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, "gic_redist" },
>+    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
>+    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB, "vpu_blk_ctrl" }=
,
>+    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB, "vpu_g2_decode=
r" },
>+    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB, "vpu_g1_decode=
r" },
>+    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
>+    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
>+    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
>+    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
>+    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
>+    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB, "qspi1_rx_bu=
ffer" },
>+    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
>+    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB, "qspi1_tx_bu=
ffer" },
>+    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, "apbh_dma" },
>+
>+    /* AIPS-4 Begin */
>+    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
>+    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1" },
>+    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256, "media_blk_ctl" },
>+    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
>+    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" },
>+    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" },
>+    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB, "aips4_c=
onfiguration" },
>+    /* AIPS-4 End */
>+
>+    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB, "interconnect"
>+ },
>+
>+    /* AIPS-3 Begin */
>+    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
>+    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
>+    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
>+    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
>+    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
>+    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
>+    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB, "semaphore_hs" =
},
>+    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
>+    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
>+    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
>+    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
>+    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
>+    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
>+    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
>+    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB, "aips3_c=
onfiguration" },
>+    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
>+    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
>+    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
>+    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
>+    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
>+    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
>+    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
>+    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
>+    /* AIPS-3 End */
>+
>+    /* AIPS-2 Begin */
>+    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
>+    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" },
>+    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" },
>+    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
>+    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
>+    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
>+    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, "syscnt_ctrl" },
>+    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, "syscnt_cmp" },
>+    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd" },
>+    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
>+    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
>+    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
>+    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
>+    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB, "aips2_c=
onfiguration" },
>+    /* AIPS-2 End */
>+
>+    /* AIPS-1 Begin */
>+    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
>+    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
>+    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB, "semaphore2" },
>+    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB, "semaphore1" },
>+    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
>+    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
>+    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
>+    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
>+    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
>+    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, "ocotp_ctrl" },
>+    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB, "iomuxc_gpr" },
>+    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
>+    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
>+    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
>+    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
>+    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
>+    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
>+    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
>+    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
>+    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
>+    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
>+    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB, "ana_tsensor" },
>+    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
>+    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
>+    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
>+    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
>+    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
>+    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB, "aips1_c=
onfiguration" },
>+    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
>+    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
>+    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
>+    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
>+    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
>+
>+    /* AIPS-1 End */
>+
>+    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
>+    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB, "pcie1_mem" },
>+    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, "qspi_mem" },
>+    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
>+    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, "tcm_dtcm" },
>+    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" },
>+    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
>+    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, "caam_mem" },
>+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB, "boot_rom_=
protected" },
>+    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, "boot_rom" }, };
>+
>+static void fsl_imx8mm_init(Object *obj) {
>+    MachineState *ms =3D MACHINE(qdev_get_machine());
>+    FslImx8mmState *s =3D FSL_IMX8MM(obj);
>+    const char *cpu_type =3D ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a5=
3");
>+    int i;
>+
>+    for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
>+        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
>+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
>+    }
>+
>+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>+
>+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>+        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
>+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
>+    }
>+
>+}
>+
>+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp) {
>+    MachineState *ms =3D MACHINE(qdev_get_machine());
>+    FslImx8mmState *s =3D FSL_IMX8MM(dev);
>+    DeviceState *gicdev =3D DEVICE(&s->gic);
>+    int i;
>+
>+    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
>+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
>+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms->smp.cpus);
>+        return;
>+    }
>+
>+    /* CPUs */
>+    for (i =3D 0; i < ms->smp.cpus; i++) {
>+        /* On uniprocessor, the CBAR is set to 0 */
>+        if (ms->smp.cpus > 1 &&
>+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
>+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>+                                    fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST=
].addr,
>+                                    &error_abort);
>+        }
>+
>+        /*
>+         * CNTFID0 base frequency in Hz of system counter
>+         */
>+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>+                                &error_abort);
>+
>+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
>+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
>+                                     !kvm_enabled(), &error_abort);
>+        }
>+
>+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
>+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
>+                                     !kvm_enabled(), &error_abort);
>+        }
>+
>+        if (i) {
>+            /*
>+             * Secondary CPUs start in powered-down state (and can be
>+             * powered up via the SRC system reset controller)
>+             */
>+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-o=
ff",
>+                                     true, &error_abort);
>+        }
>+
>+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>+            return;
>+        }
>+    }
>+
>+    /* GIC */
>+    {
>+        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
>+        QList *redist_region_count;
>+        bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu",
>+ NULL);
>+
>+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
>+        qdev_prop_set_uint32(gicdev, "num-irq",
>+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
>+        redist_region_count =3D qlist_new();
>+        qlist_append_int(redist_region_count, ms->smp.cpus);
>+        qdev_prop_set_array(gicdev, "redist-region-count", redist_region_=
count);
>+        object_property_set_link(OBJECT(&s->gic), "sysmem",
>+                                 OBJECT(get_system_memory()), &error_fata=
l);
>+        if (!sysbus_realize(gicsbd, errp)) {
>+            return;
>+        }
>+        sysbus_mmio_map(gicsbd, 0, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST]=
.addr);
>+        sysbus_mmio_map(gicsbd, 1,
>+ fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST].addr);
>+
>+        /*
>+         * Wire the outputs from each CPU's generic timer and the GICv3
>+         * maintenance interrupt signal to the appropriate GIC PPI inputs=
, and
>+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
>+         */
>+        for (i =3D 0; i < ms->smp.cpus; i++) {
>+            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
>+            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
>+            qemu_irq irq;
>+
>+            /*
>+             * Mapping from the output timer irq lines from the CPU to th=
e
>+             * GIC PPI inputs.
>+             */
>+            static const int timer_irqs[] =3D {
>+                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
>+                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
>+                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
>+                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
>+            };
>+
>+            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
>+                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j=
]);
>+                qdev_connect_gpio_out(cpudev, j, irq);
>+            }
>+
>+            irq =3D qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_I=
RQ);
>+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interr=
upt",
>+                                        0, irq);
>+
>+            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ)=
;
>+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
>+ irq);
>+
>+            sysbus_connect_irq(gicsbd, i,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
>+                               qdev_get_gpio_in(cpudev,
>+ ARM_CPU_VFIQ));
>+
>+            if (kvm_enabled()) {
>+                if (pmu) {
>+                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU));
>+                    if (kvm_irqchip_in_kernel()) {
>+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IRQ);
>+                    }
>+                    kvm_arm_pmu_init(&s->cpu[i]);
>+                }
>+            }
>+        }
>+    }
>+
>+    /* UARTs */
>+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>+        struct {
>+            hwaddr addr;
>+            unsigned int irq;
>+        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr, FSL_IMX8MM_UART1_=
IRQ },
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr, FSL_IMX8MM_UART2_=
IRQ },
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr, FSL_IMX8MM_UART3_=
IRQ },
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr, FSL_IMX8MM_UART4_=
IRQ },
>+        };
>+
>+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
>+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>+            return;
>+        }
>+
>+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].a=
ddr);
>+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>+                           qdev_get_gpio_in(gicdev, serial_table[i].irq))=
;
>+    }
>+
>+    /* Unimplemented devices */
>+    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
>+        switch (i) {
>+        case FSL_IMX8MM_GIC_DIST:
>+        case FSL_IMX8MM_GIC_REDIST:
>+        case FSL_IMX8MM_RAM:
>+        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
>+            /* device implemented and treated above */
>+            break;
>+
>+        default:
>+            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
>+                                        fsl_imx8mm_memmap[i].addr,
>+                                        fsl_imx8mm_memmap[i].size);
>+            break;
>+        }
>+    }
>+}
>+
>+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data) {
>+    DeviceClass *dc =3D DEVICE_CLASS(oc);
>+
>+    dc->realize =3D fsl_imx8mm_realize;
>+
>+    dc->desc =3D "i.MX 8MM SoC";
>+}
>+
>+static const TypeInfo fsl_imx8mm_types[] =3D {
>+    {
>+        .name =3D TYPE_FSL_IMX8MM,
>+        .parent =3D TYPE_SYS_BUS_DEVICE,
>+        .instance_size =3D sizeof(FslImx8mmState),
>+        .instance_init =3D fsl_imx8mm_init,
>+        .class_init =3D fsl_imx8mm_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(fsl_imx8mm_types)
>diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c new file mode
>100644 index 0000000000..cfb42fe464
>--- /dev/null
>+++ b/hw/arm/imx8mm-evk.c
>@@ -0,0 +1,107 @@
>+/*
>+ * NXP i.MX 8MM Evaluation Kit System Emulation
>+ *
>+ * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later  */
>+
>+#include "qemu/osdep.h"
>+#include "system/address-spaces.h"
>+#include "hw/arm/boot.h"
>+#include "hw/arm/fsl-imx8mm.h"
>+#include "hw/arm/machines-qom.h"
>+#include "hw/boards.h"
>+#include "hw/qdev-properties.h"
>+#include "system/kvm.h"
>+#include "system/qtest.h"
>+#include "qemu/error-report.h"
>+#include "qapi/error.h"
>+#include <libfdt.h>
>+
>+static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info,
>+void *fdt) {
>+    int i, offset;
>+
>+    /* Temporarily disable following nodes until they are implemented */
>+    const char *nodes_to_remove[] =3D {
>+        "nxp,imx8mm-fspi",
>+    };
>+
>+    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
>+        const char *dev_str =3D nodes_to_remove[i];
>+
>+        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);
>+        while (offset >=3D 0) {
>+            fdt_nop_node(fdt, offset);
>+            offset =3D fdt_node_offset_by_compatible(fdt, offset, dev_str=
);
>+        }
>+    }
>+
>+    /* Remove cpu-idle-states property from CPU nodes */
>+    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
>+    while (offset >=3D 0) {
>+        fdt_nop_property(fdt, offset, "cpu-idle-states");
>+        offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,cortex=
-a53");
>+    }

Removing the idle-states ptoperties is only needed since the CPU goes into =
deep sleep mode during boot and is unable to wake up, even with an imx_sysc=
tr implementation <https://github.com/shentok/qemu/blob/imx8mp/hw/timer/imx=
_sysctr.c>. Any idea how this works on real hardware? I've already analyzed=
 the interaction with src and gpc but all interrupt channels seem blocked. =
Any hint would be very helpful.

Thanks,
Bernhard

>+
>+    if (kvm_enabled()) {
>+        /* Use system counter frequency from host CPU to fix time in gues=
t */
>+        offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-time=
r");
>+        while (offset >=3D 0) {
>+            fdt_nop_property(fdt, offset, "clock-frequency");
>+            offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,ar=
mv8-timer");
>+        }
>+    }
>+}
>+
>+static void imx8mm_evk_init(MachineState *machine) {
>+    static struct arm_boot_info boot_info;
>+    FslImx8mmState *s;
>+
>+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
>+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08"=
 PRIx64 ")",
>+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
>+        exit(1);
>+    }
>+
>+    boot_info =3D (struct arm_boot_info) {
>+        .loader_start =3D FSL_IMX8MM_RAM_START,
>+        .board_id =3D -1,
>+        .ram_size =3D machine->ram_size,
>+        .psci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
>+        .modify_dtb =3D imx8mm_evk_modify_dtb,
>+    };
>+
>+    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
>+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
>+
>+    memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START=
,
>+                                machine->ram);
>+
>+    if (!qtest_enabled()) {
>+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
>+    }
>+}
>+
>+static const char *imx8mm_evk_get_default_cpu_type(const MachineState
>+*ms) {
>+    if (kvm_enabled()) {
>+        return ARM_CPU_TYPE_NAME("host");
>+    }
>+
>+    return ARM_CPU_TYPE_NAME("cortex-a53"); }
>+
>+static void imx8mm_evk_machine_init(MachineClass *mc) {
>+    mc->desc =3D "NXP i.MX 8MM EVK Board";
>+    mc->init =3D imx8mm_evk_init;
>+    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
>+    mc->default_ram_id =3D "imx8mm-evk.ram";
>+    mc->get_default_cpu_type =3D imx8mm_evk_get_default_cpu_type; }
>+
>+DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
>diff --git a/hw/arm/meson.build b/hw/arm/meson.build index
>aeaf654790..12ecb824cc 100644
>--- a/hw/arm/meson.build
>+++ b/hw/arm/meson.build
>@@ -84,6 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true:
>files('armsse.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true:
>files('fsl-imx7.c', 'mcimx7d-sabre.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true:
>files('fsl-imx8mp.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
>files('imx8mp-evk.c'))
>+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true:
>+files('fsl-imx8mm.c'))
>+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true:
>+files('imx8mm-evk.c'))
> arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
>files('smmuv3.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true:
>files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
> arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
>files('nrf51_soc.c')) diff --git a/include/hw/arm/fsl-imx8mm.h
>b/include/hw/arm/fsl-imx8mm.h new file mode 100644 index
>0000000000..aa954ea00b
>--- /dev/null
>+++ b/include/hw/arm/fsl-imx8mm.h
>@@ -0,0 +1,156 @@
>+/*
>+ * i.MX 8MM SoC Definitions
>+ *
>+ * Copyright (c) 2025, Gaurav Sharma <gaurav.sharma_7@nxp.com>
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later  */
>+
>+#ifndef FSL_IMX8MM_H
>+#define FSL_IMX8MM_H
>+
>+#include "cpu.h"
>+#include "hw/char/imx_serial.h"
>+#include "hw/intc/arm_gicv3_common.h"
>+#include "qom/object.h"
>+#include "qemu/units.h"
>+
>+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
>+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
>+
>+#define FSL_IMX8MM_RAM_START        0x40000000
>+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
>+
>+enum FslImx8mmConfiguration {
>+    FSL_IMX8MM_NUM_CPUS         =3D 4,
>+    FSL_IMX8MM_NUM_IRQS         =3D 128,
>+    FSL_IMX8MM_NUM_UARTS        =3D 4,
>+};
>+
>+struct FslImx8mmState {
>+    SysBusDevice   parent_obj;
>+
>+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
>+    GICv3State         gic;
>+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
>+};
>+
>+enum FslImx8mmMemoryRegions {
>+    FSL_IMX8MM_A53_DAP,
>+    FSL_IMX8MM_AIPS1_CONFIGURATION,
>+    FSL_IMX8MM_AIPS2_CONFIGURATION,
>+    FSL_IMX8MM_AIPS3_CONFIGURATION,
>+    FSL_IMX8MM_AIPS4_CONFIGURATION,
>+    FSL_IMX8MM_ANA_OSC,
>+    FSL_IMX8MM_ANA_PLL,
>+    FSL_IMX8MM_ANA_TSENSOR,
>+    FSL_IMX8MM_APBH_DMA,
>+    FSL_IMX8MM_BOOT_ROM,
>+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
>+    FSL_IMX8MM_CAAM,
>+    FSL_IMX8MM_CAAM_MEM,
>+    FSL_IMX8MM_CCM,
>+    FSL_IMX8MM_CSU,
>+    FSL_IMX8MM_DDR_CTL,
>+    FSL_IMX8MM_DDR_PERF_MON,
>+    FSL_IMX8MM_DDR_PHY,
>+    FSL_IMX8MM_DDR_PHY_BROADCAST,
>+    FSL_IMX8MM_ECSPI1,
>+    FSL_IMX8MM_ECSPI2,
>+    FSL_IMX8MM_ECSPI3,
>+    FSL_IMX8MM_ENET1,
>+    FSL_IMX8MM_GIC_DIST,
>+    FSL_IMX8MM_GIC_REDIST,
>+    FSL_IMX8MM_GPC,
>+    FSL_IMX8MM_GPIO1,
>+    FSL_IMX8MM_GPIO2,
>+    FSL_IMX8MM_GPIO3,
>+    FSL_IMX8MM_GPIO4,
>+    FSL_IMX8MM_GPIO5,
>+    FSL_IMX8MM_GPT1,
>+    FSL_IMX8MM_GPT2,
>+    FSL_IMX8MM_GPT3,
>+    FSL_IMX8MM_GPT4,
>+    FSL_IMX8MM_GPT5,
>+    FSL_IMX8MM_GPT6,
>+    FSL_IMX8MM_GPU2D,
>+    FSL_IMX8MM_I2C1,
>+    FSL_IMX8MM_I2C2,
>+    FSL_IMX8MM_I2C3,
>+    FSL_IMX8MM_I2C4,
>+    FSL_IMX8MM_INTERCONNECT,
>+    FSL_IMX8MM_IOMUXC,
>+    FSL_IMX8MM_IOMUXC_GPR,
>+    FSL_IMX8MM_MEDIA_BLK_CTL,
>+    FSL_IMX8MM_LCDIF,
>+    FSL_IMX8MM_MIPI_CSI,
>+    FSL_IMX8MM_MIPI_DSI,
>+    FSL_IMX8MM_MU_A,
>+    FSL_IMX8MM_MU_B,
>+    FSL_IMX8MM_OCOTP_CTRL,
>+    FSL_IMX8MM_OCRAM,
>+    FSL_IMX8MM_OCRAM_S,
>+    FSL_IMX8MM_PCIE1,
>+    FSL_IMX8MM_PCIE1_MEM,
>+    FSL_IMX8MM_PCIE_PHY1,
>+    FSL_IMX8MM_PERFMON1,
>+    FSL_IMX8MM_PERFMON2,
>+    FSL_IMX8MM_PWM1,
>+    FSL_IMX8MM_PWM2,
>+    FSL_IMX8MM_PWM3,
>+    FSL_IMX8MM_PWM4,
>+    FSL_IMX8MM_QOSC,
>+    FSL_IMX8MM_QSPI,
>+    FSL_IMX8MM_QSPI1_RX_BUFFER,
>+    FSL_IMX8MM_QSPI1_TX_BUFFER,
>+    FSL_IMX8MM_QSPI_MEM,
>+    FSL_IMX8MM_RAM,
>+    FSL_IMX8MM_RDC,
>+    FSL_IMX8MM_SAI1,
>+    FSL_IMX8MM_SAI2,
>+    FSL_IMX8MM_SAI3,
>+    FSL_IMX8MM_SAI5,
>+    FSL_IMX8MM_SAI6,
>+    FSL_IMX8MM_SDMA1,
>+    FSL_IMX8MM_SDMA2,
>+    FSL_IMX8MM_SDMA3,
>+    FSL_IMX8MM_SEMAPHORE1,
>+    FSL_IMX8MM_SEMAPHORE2,
>+    FSL_IMX8MM_SEMAPHORE_HS,
>+    FSL_IMX8MM_SNVS_HP,
>+    FSL_IMX8MM_SPBA1,
>+    FSL_IMX8MM_SRC,
>+    FSL_IMX8MM_SYSCNT_CMP,
>+    FSL_IMX8MM_SYSCNT_CTRL,
>+    FSL_IMX8MM_SYSCNT_RD,
>+    FSL_IMX8MM_TCM_DTCM,
>+    FSL_IMX8MM_TCM_ITCM,
>+    FSL_IMX8MM_TZASC,
>+    FSL_IMX8MM_UART1,
>+    FSL_IMX8MM_UART2,
>+    FSL_IMX8MM_UART3,
>+    FSL_IMX8MM_UART4,
>+    FSL_IMX8MM_USB1,
>+    FSL_IMX8MM_USB2,
>+    FSL_IMX8MM_USB1_OTG,
>+    FSL_IMX8MM_USB2_OTG,
>+    FSL_IMX8MM_USDHC1,
>+    FSL_IMX8MM_USDHC2,
>+    FSL_IMX8MM_USDHC3,
>+    FSL_IMX8MM_VPU,
>+    FSL_IMX8MM_VPU_BLK_CTRL,
>+    FSL_IMX8MM_VPU_G1_DECODER,
>+    FSL_IMX8MM_VPU_G2_DECODER,
>+    FSL_IMX8MM_WDOG1,
>+    FSL_IMX8MM_WDOG2,
>+    FSL_IMX8MM_WDOG3,
>+};
>+
>+enum FslImx8mmIrqs {
>+    FSL_IMX8MM_UART1_IRQ    =3D 26,
>+    FSL_IMX8MM_UART2_IRQ    =3D 27,
>+    FSL_IMX8MM_UART3_IRQ    =3D 28,
>+    FSL_IMX8MM_UART4_IRQ    =3D 29,
>+};
>+
>+#endif /* FSL_IMX8MM_H */

