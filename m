Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6E9CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszqA-0007LL-A9; Mon, 01 Sep 2025 04:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszq8-0007KQ-TB; Mon, 01 Sep 2025 04:24:36 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszq5-0000eP-Sk; Mon, 01 Sep 2025 04:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxHXYM7rlwi96p9NM1iQbi5mfwKGtBog2J8jsOrWVVCchb7IJ+4lIBa2SUwNC2M4l4nb1K3kUMECw/Y3TPg8RUTVd6uTjKw2H9epfCieE0UcdKkm8Z6QcZGGJhD4tuShvEzXVYJR4/PghZTaO4plaPVp6dTzdUChDksBUoruMXpjv2MyFFFd+pgMyQ7RBautk25wn0Z605sJzjUMuq3mFuo9xcVRYA9jSjpBOLsXJOWf8aM5zhBS7pXGPkvL9dOgD9lXzibLI8hvnvtcmrVFiJPrd47ZPaQqSmrx5KPFGcFN1iLSyeC4EHoPQlu6XytqVw9KrB5wgeumGrASdPsS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yn0uEzrI7kNNOJyT9a7+z5qu7zqQeF4rK2F7/lpL1c=;
 b=lH9oSP32hvkR+VC/a7kk5de9epZnqeZOhRGsnpwKVsn9hXzq9ZxYc3AxJmxskpX7+hlNZ+rJ5mtmlEe8j7XhvBAgeXZcokBZdcNAP+zpVegqeN0GF/Yhx+65QlpDNcFOMjH2uDuLf/oJy9jXHTujVWXeI/fLoDwAQq9UWwEjfIAot/QVS9apje2isqyw6U+5rlQ2K7vcebPzhgMuCE1ja7E79vtMUip1qWRbnr4UXxxSB2z+6SKkMGBkt5b5KjO/2BX0K/LC4OOiPMM6D2MACJ4Kmqs7fsId1YR8q2e4POnt1/WhLHuTguf4bJdIPJdzLPp81t+PlWd7J6p0YCKJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yn0uEzrI7kNNOJyT9a7+z5qu7zqQeF4rK2F7/lpL1c=;
 b=j8zkB0WFPDr0ad7jmafjvbe80GeOWK9SGezXuPtgVNliiQgArCxbsbTf8BDbMZYYDxIjrGA8J5tUQxCPZ/Vw7wrIDNTW/QfZWF+U15U8QyugtVD8ToIY37wbrZiipSF3R+fuZxl/ItdpCevqDjsO+fxVumdZc6flMV56QHt8a0StDsIjoM8ETBz5v2x+O8TbIAKOthnSAvb1tDW2PiV4nz6fvxZaeD6NXfAj+C7uvUOUh5GQGYIeuxpvnHoD4klqnafQ4zFXTFOcK/jwMm7OxazcNRHfvJlTD8HPvf9HrGcAe63EJJMiSr9gmkaz229ndohqlq9NeRi/69Z7UcUffg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by FRWPR09MB8121.eurprd09.prod.outlook.com (2603:10a6:d10:19c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 1 Sep
 2025 08:24:26 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:24:26 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHb9v6Wv13ajPXjLkiShog0d4iGHbRZDQWAgCU4pIA=
Date: Mon, 1 Sep 2025 08:24:25 +0000
Message-ID: <780e72ad-59b8-43f3-a6c3-b01b5d1d8b72@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
 <a9874cc7-e18e-4b6c-aaac-2c6ce56c1bf7@linaro.org>
In-Reply-To: <a9874cc7-e18e-4b6c-aaac-2c6ce56c1bf7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|FRWPR09MB8121:EE_
x-ms-office365-filtering-correlation-id: 37224176-727c-48ae-f5ad-08dde930f678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dnM0WGlvSVlPaHo1WlNKNGE3cFdkUjVaMXd6K3B2cVgxb1UyQ2dQZzFkQ0Nv?=
 =?utf-8?B?Q1dNbWlFb0lwSWE2SU03MWVCNGxvU2ZjSTh1NVRsVE90MGpWSlNmVlp2aEU3?=
 =?utf-8?B?WktuQitRS2dPamxWdEpxUWwxQnFnMFBmdzJkZTJHazhnQlNJZXRlK2NreTZG?=
 =?utf-8?B?TmkvSmRrOHZ6UmpyKy9DTnM2dm14TTFoNEJ2MjVnNTF4VUVSQ0U4dTZhdSt3?=
 =?utf-8?B?TmM0V2I3aXVpaG4xVWhXTWVPanN4RGg1S1lKaG5xV1A2R2EzL1pLV0lCbDVP?=
 =?utf-8?B?bWMvd3ZIenVTVk9aaW16QXdVTVNZaDN6VGhRM1M5T1kvQ1VCSnRxdDJLSEdo?=
 =?utf-8?B?bWhKZGh5Y0U4N3VXK2JYdDV6c21IWEd5RWlDWGc0Z0ZyUEpYWWZ4aWVQcCtu?=
 =?utf-8?B?MmlGMVhBVGwyMkRLbFhtZ1ZGWlJvelNaNnVVclBiRklsRktSQ2RVaTgxeGp3?=
 =?utf-8?B?d29CR1dFb0VnVHZSbkFEd2NKeWJ6NXdudlVGdzUrT2NiYVBoSmYyUEFFY0dR?=
 =?utf-8?B?aTk0alVHdmo5ZGJtUTVVbFBLN0J0blRJamMxZUJmeFVBL0pnT0NoVzMwdEhC?=
 =?utf-8?B?NUt0Wk5sVC96cTVveGs1c2RrYktPem1HdDEySEdVVVhVM3E1blJyMnVmanhU?=
 =?utf-8?B?NUpkL3hlTENCRHNjRllMWlZVa2xlN1QvSkhTdERoQVprT1NoY0MxY2x2L2sz?=
 =?utf-8?B?U09LSkpzejJoblJ6SS9TYVJ6TTRxMEtobHJsQnh2ZEVpdFozOEdOaXlaQnhY?=
 =?utf-8?B?aWNYRVZOL3FuazkyTU9rcytGVzQvLzBYaCthcUR2SG5kamlXYm1hNWJiUjRa?=
 =?utf-8?B?T2N6RitrdU9sTm5jaWNtYXJvOXphQnNhSzFYMUs5N0wzTDFnRHZzODdzNnJm?=
 =?utf-8?B?RnB6b004MWl0NWdCRElTQ2diMkMwYU9TNXQ2TG9YV21kZzF5c1MwUXFLWlFs?=
 =?utf-8?B?UE51bTJuR1VoZWRPNEpDMjlPUEw4dnRHOHNpSkZlZllwWmhGRHJFbFhGSGVM?=
 =?utf-8?B?dm9DdEM2eUR1MDJxdG45dFY0a2xEZU45R3dhaTRKaXIzTGJIdm5OeE92V2x4?=
 =?utf-8?B?eFZnVnFicTFlTE4reTdvT2poRGltbEtXa0NhL1pFRVZxbXkxZ1RmV3NQVlN3?=
 =?utf-8?B?NmJqNnRhVzcwRnlVNW5OM01HMWxhM2NTL3ZZcnQ0bmljZU1Mb3J2VDJPbVV4?=
 =?utf-8?B?M0N1WHNXK1MyOXN4WDVDWDdEZ211TFlnU1MrUXBBQUtCUFBhK2x3L3JxUG16?=
 =?utf-8?B?dzkzYzFZUnR2clZPYk9PZnlIYjhvbjVOYlhmdVcvZGwwOEhlWGZqaXBZcHZQ?=
 =?utf-8?B?RnBmQ0JCVTFYRmRNb0Rxd09ONVpKaXQrWUhJamh3elNrUHp3bVcyWlFjZ2s4?=
 =?utf-8?B?dE53bHV6ZHA5cUJEZHlzaC9rMzlaMVdyMmJEMXNZbE5zV0tjNThldzgxQU4x?=
 =?utf-8?B?RjA2VVdpbzQ4RTBYK05BNTFlVDY3cnNIN3BPMVBvZndteTUxS2V6QkpiYTJD?=
 =?utf-8?B?K3hpa3Jod1J3YkFtdlZjenFYNTZaOTNnTDM5VHJTSE90Tzl3SVZyZGxlRmcr?=
 =?utf-8?B?ZXhJY2gycjVPb1lGSHEreVB0VkY1S1FoY1ROdXJqQ1pmMWExKy9FRXdvNG8z?=
 =?utf-8?B?K0dRNndOb0xxWWtBY2kzSDluQ1g0REQwTXNhTnVyUW5VUS84TU5vYWJzblJq?=
 =?utf-8?B?NG1vYURSaFBhaGllY0pQQkQrVkVncFdjQTBYeXhLRmhUQ0x6SVJUWitjV0R6?=
 =?utf-8?B?bk42cVRxbWVmOFdYQUcvMmtnMnBSTVA4Z3BqK09qTWExbU5neVNWWVVxN0g4?=
 =?utf-8?B?U0l5Ym02RjE2eG40ckJSK29JbGtNS3pCVUhCV0I3aXpodjZDU0ZuL0JRM01s?=
 =?utf-8?B?WXcyMWZ6U0ZFZDEwdWNGNDBlRVFsaXFJajhRd1JVTHd2SkRpWGlqMk9oL3ht?=
 =?utf-8?B?UDdMcVQ2SmhIK0JJbEpOSCtIRW9oWGZlTU1IRk91SlJRR2w1bFlab3o1RTNN?=
 =?utf-8?B?S0xGQU5iUzdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkZxSTl1S28zNktBMDdaOVNlMGw3UzIzNGo3U3FqUDRJN0tqQWhTQ0tKUDhB?=
 =?utf-8?B?QXNSamt6R01CUlc3UDB1OEJ0U1lGdnhXL0RQQU9sSU5HQlIvNmduRWN0N1Mw?=
 =?utf-8?B?eENiR0lSVGkzU1FXTHBTc3NYeVdWNmlNNE1iak5JVHp2NldsdUpxZHNwcnJm?=
 =?utf-8?B?bVBOV2RZV0VzOUpPMWlvMFhBZ3NMYWhKSzUyUi9rQkJadEM5aWhYUEIzVWlU?=
 =?utf-8?B?NUE1S0U2eGZzdXBGdTZ0aE9IMUd2SnNDVnhSNVJXeUo0L2dTT08vbCtmd3NC?=
 =?utf-8?B?VWQ0TDNFbmcyTDF3aHltRUpadVRCMXdxakRLRlQySHgramJxM2cvM3NGRWMr?=
 =?utf-8?B?WWtWWWlOM3RvazJ0Y29jR0ZSeTcvWkRFQ2VCS3prMnUwdjRUSDhnRmRmdk9O?=
 =?utf-8?B?STB6cGsvajhjcFlJMmtxWEdpYTd5aTBGYm9JTDdhTkhzVUZldUZMNFdQbTZQ?=
 =?utf-8?B?UUdJL2Q5S2hqTFEyTjVuSndGdllhcldabEhJUG5vUWZDWk5wcDlMMmZXb08y?=
 =?utf-8?B?a0hOaC9KbFc1NmFFS3BoMDF0cTBJZXNKZzZMbEdiUnl3Q1JkbzJDMHUwZXlh?=
 =?utf-8?B?aGNwbTBCRUF3Z0E2QktBNExRTnhtQXF0SUN1SnEyRGRpY3hXalIvbG5MclRj?=
 =?utf-8?B?US9KNjd5V00ybDdDakxUZGRuL1dMWmo5Uk8xdmxFSVBoRXVZb2JhRWJSV2ds?=
 =?utf-8?B?OGlneHJ2d2FEN01CODB1RXhLb0IwNUpCeHVTU1JnZmZ1OFRiVldQZXNqY1My?=
 =?utf-8?B?eXpBZGJrOVZUOE5ZblNnS2dpd2hZQTFCT1E0T283RHVhaXJEVDVVYXRSQ1px?=
 =?utf-8?B?L2RNcEx2SHdCUzZ6U3A0cWowZG1GeHFrRjk3WXhpaGRhWHMra3BrVWZ2Nm1C?=
 =?utf-8?B?M240TUpWMFlEMldrelU5NExRM2VIaHZRVGh2MjNhTUZiK0tIZ2JxWlovajA3?=
 =?utf-8?B?NVE4d0lORFZPdVg2N3haRTk5Nnk0dXlHOFVpV1ZnZ1JQc1I2YTNFSm9WQ3ZW?=
 =?utf-8?B?NUx3T1hpZ3hvSTJZSmJZYlNtWG9QU3dhQkY1a0d5RHhOTlFGRS9FOFE1NEtx?=
 =?utf-8?B?cUdkK3BHWG9LaWxKYmlaSWJvWXhwNFFZbWJxaDdNUHNvL0N2enhOd2g0V3Jw?=
 =?utf-8?B?eitqZ3hzWE90OGF3SkQ5WDFaYWdZWEtQc0ViQytSOCtMc3JWeWp4SU92a0dU?=
 =?utf-8?B?WEtpcUFHQ0syTkJQejZtTmZBdjJmTGZMeDlRdUpNN1JWc2FLVnpGQkdYeno3?=
 =?utf-8?B?bVpnZDExVEgveDlkV3MvL1BBOUlaU0VtUkVhZUVObFVSa1ZURmpkUjViQUE5?=
 =?utf-8?B?bVRzb216alVoTUk3WjNiMU8xQjFQNmd5VlR1TjZlVzROeEVibGNscFgzMm10?=
 =?utf-8?B?ODZ6NkFVWDlUTjJWMnZaY20xTjU1bG9SZ3hKeTZCMlo2UTkvcmp2L2hhNjBP?=
 =?utf-8?B?c0R5cTFZc01tcVNuc2IxNUd0aW9NS2dsdDhmR00rUFdRaStManJnUUo4VDdF?=
 =?utf-8?B?T2VoUDJWK1ppSXNUbVd5NEFJcFhFZVUwSUpYUjU4RUpabEJFL2Eyell6Z3hr?=
 =?utf-8?B?S2xIYXlxOWxyMk1NY1RRQW9wTkpiZ1h6VkNjWkZKWjRTUGowNEQ1dk8yRzdL?=
 =?utf-8?B?RXloWXVNZnJLRXNtbE85YzRMZW5xeUh4aXYxMG1CWVBBc0xRbmw1My9kVHBw?=
 =?utf-8?B?d1lRUFVDS3RBSEV0aVY4QWROUmFQSWtjL1V5WDNISi9HSXpLMHpHSXAzbGg5?=
 =?utf-8?B?bW1IQ2EycDU5d2dnb1V5Nk9yek5Jajc0Umw4RXBaWXRGQmQ2dnVjZ1owZjF0?=
 =?utf-8?B?K0NnbFRYTTEyelEyTEJTd3BkMi9DeVBlYTBaVjIzRFJuK0NxQnZrQTZPOGU2?=
 =?utf-8?B?NCtiazZ3cDJsa28vbkJzMGp6ME53VnZIb2o0ZkpsdGljQ0x5ekk3SFpwMXF1?=
 =?utf-8?B?NVlPb2hzcUJaMEFGdVJVZktxYXM1bGJMVHA3MHFUb05hRnF1YW5pUDRlT1VI?=
 =?utf-8?B?bnVjTG1QQVBQRERuUU5wRkhKak5PakZ0Z2UzQmJOVnl2MVpwRlQybWVKZ0VQ?=
 =?utf-8?B?K3VVdWdRNm42cmVWSVJxeThteEQ5VCtXSnR2YzdHY29MVktBTU5sRnRlenFN?=
 =?utf-8?B?UWw2NlJJRnF3aS95d3V5U3hJc1VDZithbGJicFdQU0Y2QU1LWm5VZDFyTnhp?=
 =?utf-8?Q?mQJu7FcKgTNd9SUFa403zOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99F04B42EDA1CA41BBA79FCA014FBB37@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37224176-727c-48ae-f5ad-08dde930f678
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:24:25.9072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOEt89G43BxJccufv+xgrhVPqG1Egd2nraR22OQm4/1GGGh0OaqwbMiLdx0k0+SikqNONyJg3atOrbSooeHr8PYBP3CMaecCShO539mhXG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR09MB8121
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

DQpPbiA4LiA4LiAyNS4gMTg6MDAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IEFkZCBSSVNDLVYgaW1wbGVtZW50YXRpb24gb2YgdGhlIENvaGVyZW50IE1hbmFnZXIgR2xvYmFs
IENvbnRyb2wNCj4+IFJlZ2lzdGVyIChDTUdDUikgZGV2aWNlLiBJdCBpcyBiYXNlZCBvbiB0aGUg
ZXhpc3RpbmcgTUlQUyBDTUdDUg0KPj4gaW1wbGVtZW50YXRpb24gYnV0IGFkYXB0ZWQgZm9yIFJJ
U0MtViBzeXN0ZW1zLg0KPj4NCj4+IFRoZSBDTUdDUiBkZXZpY2UgcHJvdmlkZXMgZ2xvYmFsIHN5
c3RlbSBjb250cm9sIGZvciBtdWx0aS1jb3JlDQo+PiBjb25maWd1cmF0aW9ucyBpbiBSSVNDLVYg
c3lzdGVtcy4NCj4+DQo+PiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhlIE1JUFMgQk9TVE9OIEFJQSBi
b2FyZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0Bo
dGVjZ3JvdXAuY29tPg0KPj4gLS0tDQo+PiDCoCBody9taXNjL0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArKw0KPj4gwqAgaHcvbWlzYy9tZXNvbi5idWlsZMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPj4gwqAgaHcvbWlzYy9yaXNjdl9jbWdjci5jwqDC
oMKgwqDCoMKgwqDCoCB8IDIzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiDCoCBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY21nY3IuaCB8wqAgNDkgKysrKysrKw0KPj4gwqAg
NCBmaWxlcyBjaGFuZ2VkLCAyOTUgaW5zZXJ0aW9ucygrKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L21pc2MvcmlzY3ZfY21nY3IuYw0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5oDQo+DQo+DQo+PiArc3RhdGljIHZvaWQgcmlzY3ZfZ2Ny
X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICvCoMKg
wqAgUklTQ1ZHQ1JTdGF0ZSAqcyA9IFJJU0NWX0dDUihkZXYpOw0KPg0KPiBQbGVhc2UgcmVwb3J0
IGFuIGVycm9yIGZvciBpbnZhbGlkIG51bV92cHMgdmFsdWVzICgwIG9yID5NQVgpLg0KPg0KSSB3
aWxsIGRvIGl0IGluIHY3LiBUaGFua3MhDQoNCg0KPj4gKw0KPj4gK8KgwqDCoCAvKiBDcmVhdGUg
bG9jYWwgc2V0IG9mIHJlZ2lzdGVycyBmb3IgZWFjaCBWUCAqLw0KPj4gK8KgwqDCoCBzLT52cHMg
PSBnX25ldyhSSVNDVkdDUlZQU3RhdGUsIHMtPm51bV92cHMpOw0KPj4gK30=

