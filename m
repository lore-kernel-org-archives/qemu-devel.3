Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=xiub0VCw;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Q8jEcNSO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLNR-0006rD-Jn; Mon, 09 Nov 2026 04:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLNP-0006qH-7f; Mon, 09 Nov 2026 04:09:19 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLNM-0003D8-KZ; Mon, 09 Nov 2026 04:09:18 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96Bb4K860565; Mon, 9 Nov 2026 01:09:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9N+PJ2rpEhwdIU+nrLIA4rHTwc20CsxBSoo794X8f
 K0=; b=xiub0VCwHL40iPNgi8at+RCZIHL5dHT6QrWEh3NEh9C+48O/S3jYapBiH
 TMkK3L2pVYRQuP2LamBI2IrM14fq0V9S/PFS9QREWLQfXXsTjld11zzRCM2G5yGT
 H8iRiMeM1iws1VJhnnzLwu5WC7Ade7mJQyaE3jU2ezhsfW7XrnSYA3qLij+Hx975
 FwnviuztRT7FQiwwpfw2Xmsjd49VzsGzz/sU0JsiTHcZSD90Cjm+j41dcfY5v6f5
 9CTuU9n0SWsU+E8KdPe7bqCa1MAbrAcZZ61lPaihLPLY76Sy3u9s9g/AIhHGQpPV
 w2vuQYS7fmisKSaAdk5HY9fySE+Mw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021134.outbound.protection.outlook.com [40.107.208.134])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht4e1ac8k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 01:09:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2uTJdamoRqSl+JOTT89VH4X6/8XWipb1ImuAV2kdNFjakuJlPlftI5vTqEApNb4iZNru6466ysT5W92CssFg+E24hVO6ZE13TG8EHnOjMAdQTLlLLLeyy0o/XZYHcFfjH+7uzV3Bze0LXJfqm8pq9RAL0XnV+KmjB1KrPfxD7zMeL6l9jMTgO4adcVB6VRD53ceUc3DjoJax+8wK+6O77HExf87D9o3eLLhh61926CKYYmV/TgqMUdwss0ds94lzQ+3mqIUvwWotnuIsCFOpaRVlR2RtKX4wG48R+qibwJ5Erz/LuUfjj3eOUQ1M5g/VFTtTVMJ+6h2fmuHDvGW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N+PJ2rpEhwdIU+nrLIA4rHTwc20CsxBSoo794X8fK0=;
 b=v9FYVwJN/lNwNflxO8p3X4o+eMvItcGMQ6EukJ8vEo0rcPQPDFKyMNASV9vWlRfx8P32AwvAYf05Ez9piqDERriLbw9ycZI/96YvCiIf3Ou2EMzIJbMUpBd2VqQSW59447W2y6ywSnKLWkljpE7hKAS4caEfHeSjMz+SRhETw2BvdPwGxYdeAd80Jy1QuA72x9NfraZoUA8uVYUDfE/kcCtmKE60ruFszoeA1aqQc6ewndUmz2ve+f/r09tIx1PnSPd2o3y4YHp377psC+x6Gwdh37PDhe0QNhcUX9VN5tWJdix2ZuGDNasK8jN+84XGgxU4ALaeSAxjuBSZCIV33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N+PJ2rpEhwdIU+nrLIA4rHTwc20CsxBSoo794X8fK0=;
 b=Q8jEcNSOhHu68+dYoyCKvRSj7k2u4yBnKyUtEPChRm+e5oEPJFYgdxlyQlUaL9eTbcEzGjWTD4lnhJJISgRtAuMhKTV2f368oH7vneP79UhkjRQnsjlZczsmmZbP5bwoNmDO6DHkxGZAJgQ0S5L3jXdx1Trl+Q/3oL8MswYL17zpNvfEImwQk7DlGp12FPdmFjxVDGeZQ4/qeb7KLEiDai2VjTkx8z3pe5pCc1OXAFY6O+14/IB+r30V67pmlvq8nCwbXJ1gDd2IOvbAck24aCEJ8XBLtHkOr0a3hAE7ES+SvZ+huVNsF8i8KlOvPMMqJMh1OR42FIcq5zGoCTZxNg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by SN4PR0201MB8837.namprd02.prod.outlook.com (2603:10b6:806:204::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:09:10 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:09:09 +0000
Message-ID: <291007a5-c42c-4efd-b4ef-3d11924c3944@nutanix.com>
Date: Mon, 9 Nov 2026 09:09:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] hw/gpio/pca955x: Simplify pin and led getters and
 setters
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-9-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-9-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|SN4PR0201MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: f0581107-7a07-4110-bb65-08df3e411d48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|10067099003|3023799007|4143699003|56012099006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: vWjNtkKH21F/oGj6VnQy+23K+cYoaqwuptnDe7Eu5LmJUBFyQ1xJmo91bJ9Qn/wc9RF2cU7AYXVFie/WrcpdAy+r/VfyyoYFSQD5O/6hN8IVIns/v2uO8t/o/fBwyxXl3U5UZZHJYiVCNEFgdSapKKScSwF3Cib36bhSy3dtkamF2pYMv+iqy61kaX+kVwVWvKrqKEDOF01LKRtH7S4T60AE3lGr0HBoWOurAdgzIDUACRZcNozXNoRs0BLUWYtz4ey31ex8fnZJdPVz+kCAp/wMCdfKy5kRJZhTeGLZNEvDikfKlNkP36jlTSB2LI1Vtx/sPop6OHB5l9LZKuPZrnzSfobhkhcp4sCPXRFCAkOgs8ZedP9O6LAa7gyAk4OL7sRDD/yPDmhD/Xj3QQOV5be057TmTBv3czZqArYtCRD0Li0hUy7fmoE0t0IJBX/MbLTXrVk49W1DIvdElqc70lkLExm77ocpnnHcxwLzRHJMHwLY9JxeDI/xmpSJW1sL4IuT693txLxZj7VS3FGb4Yv56DQDFGw2tTXnQwr4Mf7W2wP1Smgm7lxiFcxsnZnI05vuYCsnuHMeidIDhawzXCTQ9AnSmC+vrkVMCBkf6jzis+J/IgI67BNMJiGMaUx4ltzCQrq4NrdmlyXFeJAqrSB2olzFOcM/yh+S+8tYPLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVkOGtXQzZnU3dyZWtreU9FSEVKb3ROdWZXMHhROTZJM0hFdjNZOWpubVVt?=
 =?utf-8?B?dThhdXRXbExnTnp2aExXQlBUaWZkTGFzeHdnZjVrNDJDT3hyOEtwTGt0U1Aw?=
 =?utf-8?B?YVFTaHZrWmRpZDNzRloyWjBiYWErQ2RpZ3R1V1ptdFhCUklkbW9ZNGNSMStU?=
 =?utf-8?B?LzJBK3VKRjUyOVVFTFZHb1VOcWFFQkFVRlRpT0p4WFpNckdYSktTQ0lqVE0r?=
 =?utf-8?B?d2kxRWlLREhVa0xabUY5OFd4NjBERTcvTWw1RE9EMEtCd0hEUUNXR1l0S2lG?=
 =?utf-8?B?bitUN0szUTFkUFlBZU9ZcmJ5Smg0QlNSWStORXVKbGNsZXhLU1JGWXVjTERC?=
 =?utf-8?B?V2FYTTdZU29CMWx4U3plbFRXSTlBNDhXL0ZWMi8vSkNoM2pYYWJOMGZMMnRw?=
 =?utf-8?B?QmpwVS8rOEtnZlhITXBHNHMzUkM5Q2VLd2ZwWTZJREVwKzN0RHI1YzBKMkxx?=
 =?utf-8?B?cXB0UjRGQ3FxSEhlK0ZjeHA4T3luL1V0R0R0RHRYUEFGcWFLb2tBLzVzb0h1?=
 =?utf-8?B?RDlNNWs1VUppY3M4bWZwcG9qRjNTNFpNRXpYakxvakRQMFViRlhQVDlWOU9F?=
 =?utf-8?B?Q3RUUnFOTktkS2xiWThJbEdxZ2E1NjR6aElIZWxLd2E5N2YwLzlFanhBWi9H?=
 =?utf-8?B?ejlPVHZGc0tmbk5jL3R6R3BmVnIySlZYNFhSVjU2LzZ5RVc5amhxYWRDam9Y?=
 =?utf-8?B?K1BncVk3THpuN3pURkZja2Z0a25STGlyQ3VYM0NDcGZ4Ri8rR2J0djJCZURL?=
 =?utf-8?B?YmlqMmhVbGlvQ21xTU42emk0OUt2ZVRnNEZnM3FXeGFvaEJUdEVGczBXeEp1?=
 =?utf-8?B?ZzdDS1NSWnhkMzM4Y1p0YVAycjUyZzY4M3lYd1dTWFRHNUc1MkRkU3ZGZW94?=
 =?utf-8?B?ZXJwYmJyZzFRTHYzT09QU1FRdjB0ay93RVpUQ1BlRTZzZklLejNCYytOdUtR?=
 =?utf-8?B?WVYrTXhnNjZ2cG9ma2lsMzNueG5mY1RkbnFaYlFOTmNpVW1BNGwxSXRHMXl4?=
 =?utf-8?B?L3pTREUwaWhxdFJMZFNVT01DWktodW83cjgzMHFvZUxyQk1hVE9IUFZsbXM4?=
 =?utf-8?B?TEtzT21iamZ1Y3hGd2s4R1l5M2FTOW12RDYyRjh5Vk1Wamx3UWNzTjJkcHY1?=
 =?utf-8?B?THJDZE9sOUpGaVVBMldYNWkzaUlUYVdCbG12VXY1VTlxZmFLMFVSSnN1bm8z?=
 =?utf-8?B?S1kwc2hVRCtja2t1YWIxM2dXNlMrYjRldWlwTmxMejRXUVY1QTUzaThOWVV1?=
 =?utf-8?B?NGRGcDVxa3RTRkNDTk5sT0t1ME51UVcvd2kwOFYvNWtHTG9yNXluYjFkRzgr?=
 =?utf-8?B?b21OZFBjZkNMYkFiNVc0NzBmQTdnMElTcWMraURVVFVZSWdCOEIzVVRIUktW?=
 =?utf-8?B?dmtZK1ZlY0dLZC9uWEJTdklSSlUvZFNIVm43T0F6WEZYMG1FampPU2FDWXF3?=
 =?utf-8?B?Vkx5aFNYZm5DK3llMFE1cU1jZFg4S0FRRnQ5R1MrR0pLUUFDelNxb3lrOUdB?=
 =?utf-8?B?YTNLVUhlVFBsUzN3bHJDd0FWWkMzUFY5N0tIMVY4K0J3S0ZBbnhwVDNINjFU?=
 =?utf-8?B?R2ZrWVRtOFgxQTJ5VUZjQUNxQ0VJU1YrVnArNTVTcXNJQkJxcXNpZUxLVUND?=
 =?utf-8?B?MkwxNUlBMERucHg2NFZoOGt2aHhkOUEvdGhFSlZmRkRBSlI0UkszZi9hbHRF?=
 =?utf-8?B?bDZ3L2hkV1k1OHoybE54RTh0NHYzVVZxbWZBd3lhc3dvbWFIYmh5ZVMraHNS?=
 =?utf-8?B?TTY0VzlsMHhENWFDYVpuRVJwQTNaZ0VEeDcvZkhTdC9KSC8rTHQwUno4bDRY?=
 =?utf-8?B?TWlyUjdqOFd6NXc4WWcrb1BybmR2TlFwMGxaZ1JES01tZGpzNjdBeWgrSWdz?=
 =?utf-8?B?K01rSGM5b0wyMzVYc1RqekNDQ2NLUmhPT1ViejNIUXl6eWV6QTRwOE5HeDNl?=
 =?utf-8?B?emtxRllYUmI4dGMrVWU5TDFSaHRBZks5NDR1LzNQVXpiK1kydlFJSVhrTkxr?=
 =?utf-8?B?bmNYVlFmMEhsVUxRNm8wWG5jL2QrN3FYZDVUdGtNYWdnM0hVQ3ZmNUFCc1NL?=
 =?utf-8?B?T1RvYWRFWm8rN1FBZksra3JkZDEybk5ibFppZFVyeUg0L0hpR2IySUlseHNH?=
 =?utf-8?B?Q01uekNJL0hZSWpoZVVpTnE5TkRSRzFzaFkxZTRPWVR3Wnd3dXh5NkI0TjI4?=
 =?utf-8?B?MkREWWlESENXQVQrZkkwTnFFODV2Z1F2QTVPdE1DcTVPUlkveEdQQm5XQ3lY?=
 =?utf-8?B?dzF3dHI0dUpKTTVJMjY3bWxpeXErQWYwNzBzQ2xtR09lalR0RmNsbjZSa1Uw?=
 =?utf-8?B?OUV2RzdRTzE5YVhmL0FjKzduSWtKR25VU0o2VnJNSGxhMEZqdVA1OG5RcVEy?=
 =?utf-8?Q?egKudj0GErVQmYqE=3D?=
X-Exchange-RoutingPolicyChecked: HuY3MQMr8hl6FL5VPaHqN5j8XP6dScmi1Nh5iGwabhzaZ/VXu/sBHyWsa5bEq1V6qU0gr126++noWxud7YjhuwuitBbhkHeQePG3kEqUWbrdEqYtVaqYggn3m7q52PaeIONVCP+KFSX768o4W723WUfkMn5EiprrcEqr3zzG4DX60DCckZ5UBvW+0p3bMZqz10ViixfJzcOR93UhNm3BTCfH3VO+3beFBA889vm/Qrllk+fwnE59RSDNVs4pHxDZBWA91vX39wwHyLIiyp2zZ9RcJsZ9NcGQq3GMhdinZYMFMNeoI2Oq5INEOtPmfD0NsmDebwDwAniVuRT0ihN7ug==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0581107-7a07-4110-bb65-08df3e411d48
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:09:09.5935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 746/IBjXVZ7wF+5bStqIPDoQ5I+izQ3zSf0Zm+cJrVW4V4FcIyzp4PEAJPV7PqUHzThH9axkX2bckDMLWBzZdWXZIuwDLI2gQe4OBZ27Jow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8837
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX7BR815nJAe8p
 6egDdKT5aXy++izvymkZCSUGBehKJ/dwVXruNfjof8m5VYDA0FEqiyMtl3ec+zBAcHh7knvCPFj
 KinRVRPW/rJp7/25KgCrv+9OASGNteA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX7NN7CBoivniR
 jivWQg+cGlqN5A1cJ+241l3lroTwyvcZcFoEF9mxjXcO5lbeAUKxihO0G1brxCP8FLJfxRnT5dm
 QwGr7QASk3zgn48LwCi0bZGCJihFkhuPC0SwHQ/+Q1FtKcZGZlEGKft3Jt4vK3C9J8039MEej6E
 qvQubDU0K5qMra2rQJLaJ5lRHWxx7cf67SWuRGjw+diJFy3jlooxx8CPoPsF+1F3x52/aDNIWNu
 le2bDdVvHCj7l7KsYCMTitb2E2d/miH/J0DYGhVla1mY7CHjewfja66UCk+ZB/DPPa3HWmv1C8G
 DoEcbeiWrp5WIBaD/jZ/WuBwWfI6ztla6ZInNsnBrhKRvCmnJiQZs+lUuPqu3JsmlPS/v6LejGE
 LiM+u+Dth2ycD0R2QL5rm2USn74H+DWXTBxJbXghiEt2211uYhOPlTd4Sd6ywcdcWqYmcrTdakr
 ll6rCPn4mSPTC/qTeGQ==
X-Authority-Analysis: v=2.4 cv=eJ2GH3p1 c=1 sm=1 tr=0 ts=6af18db8 cx=c_pps
 a=FeeVHR8rqpo+Pf7fuAv9nw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=QbIeL1_GCSYT9WONWPgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qw9MJRl9sRY59zx8HIMqKKMQyoK62kqc
X-Proofpoint-GUID: qw9MJRl9sRY59zx8HIMqKKMQyoK62kqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 11:04, Markus Armbruster wrote:

> Pass the index via object_class_property_add() parameter @opaque
> instead extracting it from the property name.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/gpio/pca9552.c | 60 ++++++++++++++---------------------------------
>   hw/gpio/pca9554.c | 30 +++++++-----------------
>   2 files changed, 25 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index f97ad6d083..c8d0e9a16d 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -360,18 +360,12 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>   {
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg;
> +    uintptr_t led = (uintptr_t)opaque;
> +    int reg;
>       Pca9552LedState state;
>   
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
> +    assert(led < k->pin_count);
> +
>       /*
>        * Get the LSx register as the qom interface should expose the device
>        * state, not the modeled 'input line' behaviour which would come from
> @@ -397,21 +391,15 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>   {
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg, val;
> +    uintptr_t led = (uintptr_t)opaque;
> +    int reg, val;
>       Pca9552LedState state;
>   
> +    assert(led < k->pin_count);
> +
>       if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
>           return;
>       }
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
>   
>       reg = PCA9552_LS0 + led / 4;
>       val = pca955x_read(s, reg);
> @@ -426,19 +414,11 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>   {
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> +    uintptr_t pin = (uintptr_t)opaque;
>       uint8_t input_reg;
>       GpioPinState state;
>   
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> +    assert(pin < k->pin_count);
>   
>       /*
>        * Report the raw pin logic level; polarity inversion is a read-time
> @@ -454,28 +434,22 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>   {
>       PCA955xClass *k = PCA955X_GET_CLASS(obj);
>       PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> +    uintptr_t pin = (uintptr_t)opaque;
>       GpioPinState state;
>       uint8_t config_reg;
>   
> +    assert(pin < k->pin_count);
> +
>       if (!visit_type_GpioPinState(v, name, &state, errp)) {
>           return;
>       }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
>   
>       /* Only input-configured pins can be driven by an external device. */
>       config_reg = PCA9535_CONFIG0 + (pin / 8);
>       if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
>           qemu_log_mask(LOG_UNIMP,
> -                      "%s: pin %d is configured as output, ignoring set\n",
> +                      "%s: pin %" PRIdPTR " is configured as output, "
> +                      "ignoring set\n",
>                         s->description, pin);
>           return;
>       }
> @@ -549,14 +523,14 @@ static void pca955x_pin_init(PCA955xClass *k)
>               object_class_property_add(OBJECT_CLASS(k), name,
>                                         "str", &Pca9552LedState_type_info,
>                                         pca955x_get_led, pca955x_set_led,
> -                                      NULL, NULL);
> +                                      NULL, (void *)(uintptr_t)ix);
>           } else {
>               /* GPIO variant: expose the pin logic level as pin%d. */
>               name = g_strdup_printf("pin%d", ix);
>               object_class_property_add(OBJECT_CLASS(k), name,
>                                         "str", &GpioPinState_type_info,
>                                         pca955x_get_pin, pca955x_set_pin,
> -                                      NULL, NULL);
> +                                      NULL, (void *)(uintptr_t)ix);
>           }
>           g_free(name);
>       }
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index e2d481866f..d987b16cd0 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -173,18 +173,10 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>   {
>       PCA9554State *s = PCA9554_BASE(obj);
> -    int pin, rc;
> +    uintptr_t pin = (uintptr_t)opaque;
>       GpioPinState state;
>   
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> +    assert(pin < PCA9554_BASE_GET_CLASS(s)->pin_count);
>   
>       /*
>        * Report the physical pin level. The input register is kept in sync by
> @@ -200,28 +192,22 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>   {
>       PCA9554State *s = PCA9554_BASE(obj);
> -    int pin, rc, val;
> +    uintptr_t pin = (uintptr_t)opaque;
> +    int val;
>       uint8_t mask;
>       GpioPinState state;
>   
> +    assert(pin < PCA9554_BASE_GET_CLASS(s)->pin_count);
> +
>       if (!visit_type_GpioPinState(v, name, &state, errp)) {
>           return;
>       }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
>   
>       if (s->hw_dir) {
>           /* Warn and ignore if the guest has configured this pin as output */
>           if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
>               qemu_log_mask(LOG_UNIMP,
> -                          "%s: pin %d is configured as output, "
> +                          "%s: pin %" PRIdPTR " is configured as output, "
>                             "ignoring external set\n",
>                             s->description, pin);
>               return;
> @@ -290,7 +276,7 @@ static void pca9554_pin_init(PCA9554Class *pc)
>           object_class_property_add(OBJECT_CLASS(pc), name,
>                                     "str", &GpioPinState_type_info,
>                                     pca9554_get_pin, pca9554_set_pin,
> -                                  NULL, NULL);
> +                                  NULL, (void *)(uintptr_t)pin);
>           g_free(name);
>       }
>   }

Interesting. I think I had a similar issue trying to get the index of a 
gpio when converting one of the hw/adc devices. No objection here, but 
we should try and be consistent about how we obtain the index in these 
cases as I can see this coming up frequently.


ATB,

Mark.


