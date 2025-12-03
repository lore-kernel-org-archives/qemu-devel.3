Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB7AD12D69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQntr-00031d-1N; Wed, 03 Dec 2025 09:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vQntJ-0002wc-IT; Wed, 03 Dec 2025 09:31:43 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vQntD-0000Iw-3n; Wed, 03 Dec 2025 09:31:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcEX7wXUabcsP1i/azSJe1imRPXlAY/8zG6UHtwjcL8CWp8ZI2Ot1/q4V6XPC/gfsUITQvuEktA+byQHgNsDgl/FWsbjNya1WpAbiPMtYKhASeplvmUB2rDSjTM2SW7ukcPbV6nWX6hgOfwC2J7t9cUXQ4cHVy/Xe1f+YS5gBwlTDS3kEpo3A6jNy0Kmd/UYKPKa/XuGZoqvsd7TVoKCaqNe8uX9Nwwyv+pXB0oBbJOMlf/4ixt+YgrSpNIUAI/LO0zllxhmn8qHMAcS9jS3ahWtARznz+undkDrGMFubNmwXSDCdYUamVI4Ff5D2p5LrwJoAIYTsSDNKtgWIgHdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0qVRJp5WuyL84hLvmDEYDpVK0bXxTsIgkE1hUwij4I=;
 b=JcffJOrz3X/k/ecOaU/ixMOmF1mT/qJrRVe4I+ag9wKyFWIJr6z+3P5e+Oo4WSy825OcPbwsQ2OKvnyqUEHmu6JLeaoCFuXqEGeuKsZ0tv6eZvjpkT8vBlsyjSBN2GSIS7xV/4BleVkrAr19lYlkDutGyrdwysWMS5bxaiUi78j47jBroAGPQSU3w8ubFd8qoeUnG2OuP7lcGrmw2gq1P2O5QXODilSDA0nRaFB2TPaptZjAE34oOGWRF55ofHflHhp/+DgCV3RNuH8AYSYrfSHHrzzwvOcYZrfzRVcJ+qeeXeKD7gTLjJjOPd9IC6jfk7p620v8ncKQ810P//4RZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0qVRJp5WuyL84hLvmDEYDpVK0bXxTsIgkE1hUwij4I=;
 b=C37rjfyBOfvSnAwt7zFeX/5mANWK0zoB8O42iNm3eRnLHokrxVxEgs5XYmgkXOnozwovFzmG09yShSfpp1i+5sa5FpjLQzi5YoZIGxam8Lot7+QDhzuKtWHsUNJrMbtG9DJzPjZjEqgKJsDElNbisAy7AYVa6hoClWxm17xjLPeQ4Dp2utmf98JuhtXwev9G5Z9s5XM1x7uLQz/sLZ0XRsHVzfGTHi06VLiJls2iyKK9rPNIQx5GEj085d10PzIJlUqePJEXksi+NscQr7iGuTjfTEgEwR0rUYTYBppXE5n0gdb3bHlUFkhnw1JbUW/zGVlNKScTwiNxzP+3HpAYVw==
Received: from VE1PR09MB3471.eurprd09.prod.outlook.com (2603:10a6:802:b1::23)
 by DUZPR09MB6851.eurprd09.prod.outlook.com (2603:10a6:10:4df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 14:31:23 +0000
Received: from VE1PR09MB3471.eurprd09.prod.outlook.com
 ([fe80::ec5d:d9c5:f6b6:1f19]) by VE1PR09MB3471.eurprd09.prod.outlook.com
 ([fe80::ec5d:d9c5:f6b6:1f19%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:31:23 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>, "thuth@redhat.com"
 <thuth@redhat.com>
Subject: Re: [PATCH v14 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v14 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcWGlzXWwAZOkBrEyyKNzERrDbDLUP3fUAgAAINACAACwCAA==
Date: Wed, 3 Dec 2025 14:31:23 +0000
Message-ID: <9893e4bd-a0b6-491f-95dd-6a23e102a685@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
 <d11d7f92-d992-4d4d-8456-707cf42f93b6@htecgroup.com>
 <88c37ed0-2e1f-4a6d-8032-f153309eeaac@linaro.org>
In-Reply-To: <88c37ed0-2e1f-4a6d-8032-f153309eeaac@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR09MB3471:EE_|DUZPR09MB6851:EE_
x-ms-office365-filtering-correlation-id: be7b765a-8968-41e3-5c65-08de3278a21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WEFEaXZiamd0WVVhY2tpM084RkI2K2xzUDlWWHhzOXllZDQrVWlyNHB0YW9s?=
 =?utf-8?B?d0V0MHZwUldFcUNybHJwemxjdE54d3M0U2dpMG5JbjBXaDFEa0FxY3NjQ0hR?=
 =?utf-8?B?Nk5qSU9tNDQzVGw4K1Q4bGk4bkZ6Qis5MEtIbERoaTVYZ0I4eUtWQktKcm9s?=
 =?utf-8?B?QXdZUisxam9aVXhROU5GWHlWRDJHTHh1S1UraXdGSEMzSGVmdUthdGtoQnlM?=
 =?utf-8?B?cU1HanE5c0t1ZFNmT2c3amVQSDcrYW56UjRaZHdvSzc5UTNPOEFCRVFIN1Rl?=
 =?utf-8?B?U0dKOGhwR0F5Um94MVBuRjBVdnUvNjJ5YnA5QlA4aVF2MFN0cWlobHkvNWxz?=
 =?utf-8?B?a1VKRm13SU9MTDFNQUlkVjVCbmRJNmhSQlJxc21Dcnk2eWJrMnUyU3ZPWTZF?=
 =?utf-8?B?Y1E1dnE2ZG40N1loOHN3QWdrWHg4NUVMVllMNjFqQVJxRHFFcjhIVTQzS0lW?=
 =?utf-8?B?SDY0RXovYlU5Q2Q4M2M1NVcwTDdLUG9waGowakhtSUkwbm5GWlUyVFRBdlY4?=
 =?utf-8?B?dTdpMmFLVktHUDhsVTQ5eklNWHRUaVJuKzdKN1IwekZUVWpRTnVpaXV4cDh4?=
 =?utf-8?B?SDBucVl3Vk5DRmpJcjRkRUk1VDFwN1RnVmJ2RkxyZCt1VkFvMkFyZ2ZOWTZB?=
 =?utf-8?B?clVucTB2TkNmUXR2YTllT3lHVThOQU9QbWVHdzZsY29XQS9QY1piaWJqSTY5?=
 =?utf-8?B?cWhRbnI0eDVWWXhyZHFOUkZ2ZGlGYWdhQm5kZEZsWFYzTXhObXIrMnJQazNO?=
 =?utf-8?B?MEpGWkRFTllrU2hkeWZGMUlrbnZNb3Q5bS9qT1dNYk9ZU2ZQMnFyTVljR3lV?=
 =?utf-8?B?cGE4ZVpNYS9UV2JBMVJwWnFlTlhBZnpSVGIxSjZLYlRpTnkwN0JoL1kvUWFx?=
 =?utf-8?B?Z0JHSlI1R1VjY2cvOXRBTnJsZDJ2aE5XQlREQjNHM0ZaOGU0ejNUQkxjNklm?=
 =?utf-8?B?NTJrN0xjdjJXZ0s2N0NCV3ozSTBubGp6TTEwcGJoR1BKTW9pamUxeWs1UXpR?=
 =?utf-8?B?MXc5Z1doZkxZTlRQcEhqSWRUZ3AzYUtEWDdtLzVxQi8wOG5ZZzJwZmVuQSs5?=
 =?utf-8?B?aUlac2hBV2grTUNrcXlVZktVUDQ3NDRaTVRQbEl6T1Fuc2hnWS8rdEhGUG9w?=
 =?utf-8?B?dEhiYm41cnJiaVJrWlBZbmpDWnhGWnZIVnI0b0V1SzdVRnRxSlJkd3BjTG5h?=
 =?utf-8?B?UFIxVHZoRmVTcE9kS0JjVzkvQ3FqQ01NdnhwNVk2WlIxdFpISG1lV2hkcDBq?=
 =?utf-8?B?WnJXc3UrSStJNmYyS21mVngzMHVYUlQ5MmVITC9INmRqVHQwUjB6RFErMkI0?=
 =?utf-8?B?L210VG5MdHlXdk9ROGozUi9LYWpIbk1UR3AxaHZURGRkNngwKzlSSWVGUzBS?=
 =?utf-8?B?RVQzNWtySlpUQUxPOXhiUTQrK0FxQXlFTi9zZlloWmFaS29DVnYzaExMdmg5?=
 =?utf-8?B?aVdTMCsxL2JLMGxqZnlBdGNVSTNuNDdveCsxN2ErUGZrZHBvdDlaV2Jad0Zs?=
 =?utf-8?B?VXIxdjJLV2xBNzF3dEdCdWdXQ3FQUjdZK2MzNjBjR29FUHZMZDB1N0FhSitJ?=
 =?utf-8?B?blVLNW9sSFZEM3MrVG1uTXZNQWs5MkdRZ0thK25BTngvN2Rsb0gyM3hvSm5i?=
 =?utf-8?B?aEJSZHl3WTBvZDJ2YTJEYlRVK0RMZHhRT3MyTG1CRXc1VnRZVVZLQWJLT1N4?=
 =?utf-8?B?Ry9QOXIrZ2FVcTJjTGNSWkUwYjZpdlluN0t4L1QxOTJzcHFTYzJIdG51SFFo?=
 =?utf-8?B?dXpCWGQ4R3czMHpoZldMZkNHQWdEQXRNSk1yNSszc1doWU9qcmxwclEzUkx5?=
 =?utf-8?B?TzdCRG1IQUdqdXpMZzBLNFBpcUFmbjVjRldwYTAxVFkzM25QbTg4dTJleFdI?=
 =?utf-8?B?SWhlbzY5dHdUZ3luT1Q2NXZFUHJmMFZ1NC9UcDQydjhRWEMxZkExUHZSUnNv?=
 =?utf-8?B?ZTJ0TEQxVVg1Z3lkVkRZUkluSG43SGJ0ankrQXJ3MG8zTVpSanc1aUdQUlBK?=
 =?utf-8?B?OGh0bkNuem5FUHplazN2RVdvckkra0lWU1I0TDdhUGhyVkVRM0RHQjB6R0lx?=
 =?utf-8?Q?4fKtPj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR09MB3471.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1sU0Q0bmdNcjgwYmoydlVkZ0JIRUhHTmd6TlVYZ0ROU2IrdG5WcHVxZVBD?=
 =?utf-8?B?dlBBeG14di9UUWRWd1FPS0J5SEJQaENQV0lhbnI1QUdPMU9QcnRkN3BDOU9N?=
 =?utf-8?B?K0tPRkNMZ0xCaDlVTUFlYjl6UkptRzhPbjVHaFBOc2xORGFRNXdEZDZuS2l1?=
 =?utf-8?B?MSs0bDZiMVhoSXpoY1p0MjdoWStWTTgyL1RmUmJvRXlGT2Jwd0pNZUNVZW14?=
 =?utf-8?B?c29VQThVRTE5REtoZ01laExYOEhydllBdFFpbmZVOGZudWNCK1NSY3BoTWNI?=
 =?utf-8?B?WjR5Vk9Ca3p3TURabG94NGVZUlE5UnYwTlc3VndqdFViYzhzZU1LTmdzRDdr?=
 =?utf-8?B?NjF3QnV6bVhkTUxjVkI5RS84TDljWXdpb0NZMFNZMERaN1pYNnR2b2E2ejJ2?=
 =?utf-8?B?VFBkY250dVZkR2UyMzFzVkg2K0RsandtaTduNkFDVkN4MjQvMkRHWmJHS0pG?=
 =?utf-8?B?eFNSRDkzU2JSUm5BWWFxTVBPbGlUWmdxYWpCRURvNklaQlpkMVFGbS8wQmt5?=
 =?utf-8?B?UFFCRlc4bnhDVjRuN2R6U3htSkFKMkVBeHQyZHEzNjlQU1ZhRzgvMDRoeXNC?=
 =?utf-8?B?Zkt1ZVI2aElvTjVuVjVmNGdPTk9wVFlVSlA0eURzanNHQ0xtWjdOZFBJcCtU?=
 =?utf-8?B?bjJnaU1YeEp3VWhzS2RUNWNjdThhNmFhTGUvZEp0WTBxWUpDUGlpM0VQWldK?=
 =?utf-8?B?TDNDd3Vud0RBVUJ1a0lDbHhSajZVUDdQenRhWDI0TTEyUWV6Tm81cGdNS09N?=
 =?utf-8?B?NHpmbWdoM1pES09BY2tJTlh5WVF5cU9MOVMzUEszMENmUzBSa0ZyUlNqSCti?=
 =?utf-8?B?OHNTQXJ4QjhyUlhhWmRhWFVkRHQ0NGlSeHZrWWYxYmkxY2lpUXJhYm1HUUsw?=
 =?utf-8?B?ekM1SHFSMG1UT0FSKzRCZlpaN0YzRkxta1c1My82RDlZTmJLLzhRNDRUT2hw?=
 =?utf-8?B?Yy9vY0RJWDZlY3lFa3pHNG9BTmM4SXVRKzlQbjJhSllmRVUxaUtTQTEwZEVJ?=
 =?utf-8?B?T0NNMVVLK2ZRU0dRTWt5UHovQlA4M0wzNmhLU2d3elQ4L1E4SXZVY1JPb1ZJ?=
 =?utf-8?B?Skt6ZHlDZ0Zjd1czRkh4WUNmMTVBa1l2bmhpR0REZTBPUnhFQ0lnOUQxVEdx?=
 =?utf-8?B?MVNOWW1ZUXdpSjNmMDhVbWhxaU9vTjl3RE9JNUtoZ3JrNEk2Z0U0Qk9JTXNC?=
 =?utf-8?B?eGFkTUtQZldUMWhNekx4S0d1VWxJY2NoUC9QbW90ZEp3N1JneTMrWHV1d3NF?=
 =?utf-8?B?TlYzVW1YalZLSlYySlk5MmozZ1pYNVgwZ2lRcU14QnpudGFGK1VkemxuSW5a?=
 =?utf-8?B?R0hPRnhXMjF3d0V0TzhtWVlYejk5c3NkaFpWZmxBcVVHNXpmdE4xU1VISEtT?=
 =?utf-8?B?UG1tT3pmcVlwUVdLR2FCb0IwcEZTRlBOc0NwaHprT1hBNEdtY2xEV0oxajV5?=
 =?utf-8?B?YjZBdVRhZWJYWXk3empUek1NcHpBakRUeEJibmpRYVFxSWE2ZURSSFZVZnQr?=
 =?utf-8?B?UjdweGpjNy9IS1hNNU4wK2ZGeW8wdE00V0d5czA3c3lDQldvaXFJcCtUdUlO?=
 =?utf-8?B?YXA0KzlrbkpUc0JBUmoxMkVDZHZOYWFCSDViVG5QMm1Kb2Q5bE9ndlpvTkx1?=
 =?utf-8?B?MFBIN0dzcnRXOXNsV051N21JR1VablI2NXo2SHpLdlVBdGJkR0pPdjRIdVNM?=
 =?utf-8?B?NTJKUnYrYkwwZGdxVEgxNlBpdmp4ekh4cFF5ZU9sU005MExXYTRsbWFxR0ds?=
 =?utf-8?B?QnlGcWVUTVpYOHZnMzBpTVhKU1hKQUsvcTRrY0J6ZWdDK0hENG9iUnVRT3Ba?=
 =?utf-8?B?d2M1UU5YbllQZ2ZSank0Yk5BcnJqNi9nNUZtbmd4M0RFa3BXUVUxVUwxQ0g1?=
 =?utf-8?B?dFVmcHFzSDJaQ0N2ZXc5UWEzOGJXQmNKQU5Ibll6WHlEbnorbGo1NjlWSzVu?=
 =?utf-8?B?TXNyNUltR3VmeFZzakZqRHJEZXZIdHU3S001czY3V2hKYnlweXNBeHNZQzhl?=
 =?utf-8?B?eCtTdmxPYk5JdkY2L1p4N1ZkRkhENW9xcDZLamgvSWJMKzV5SkNzU1ZGOWNJ?=
 =?utf-8?B?ck1CeVRUUXdTWkE2TUJScHZSR2ZIZ0tZOG1xKzhKbURoMFJ0ckNRRjFiZFZp?=
 =?utf-8?B?ZjJXL2ZxUHUwZng3OTh3bnJMbEZZWU14TEtFRFpVdFB6K0U0UFNrMndLQ3ZC?=
 =?utf-8?Q?P5XvYWYL3QpJcI+accrCDLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <850D089555CF0A4B8A892F542096A546@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR09MB3471.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b765a-8968-41e3-5c65-08de3278a21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 14:31:23.0317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UteTmvfBapA5SfRscPglSuB3VJEEAfcWPYTHDWHb4xymbzXJlTqebbI7k8RFz2Hn8eXk2DnFTjYenVLv0rc6Bzbn8VGf2LqazYodIHbY+uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR09MB6851
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGksDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIGZlZWRiYWNrIQ0KDQpEam9yZGplDQoNCg0KT24g
My4gMTIuIDI1LiAxMjo1MywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IENBVVRJ
T046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlv
bi4gRG8gDQo+IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
cmVjb2duaXplIHRoZSBzZW5kZXIgDQo+IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
DQo+DQo+IEhpLA0KPg0KPiBPbiAzLzEyLzI1IDEyOjI0LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90
ZToNCj4+IEhpIGFsbCwNCj4+DQo+PiBXaGF0IGlzIHRoZSBzdGF0dXMgZm9yIHRoaXM/IDopDQo+
DQo+IFNlcmllcyBsb29rcyBPSyBmb3IgYmVpbmcgcXVldWVkIGJ5IEFsaXN0YWlyIChSSVNDLVYg
dHJlZSkuDQo+IFFFTVUgdHJlZSBpcyBub3cgZnJlZXplZCB1bnRpbCB0aGUgbmV4dCByZWxlYXNl
ICh2MTAuMi4wKS4NCj4gV2Ugbm93IGFsbCB3YWl0IHRoZSB0cmVlIHRvIHJlLW9wZW4gZm9yIGRl
dmVsb3BtZW50Li4uDQo+DQo+IFJlZ2FyZHMsDQo+DQo+IFBoaWwuDQo+DQo+Pg0KPj4gQmVzdCBy
ZWdhcmRzLA0KPj4NCj4+IERqb3JkamU=

