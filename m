Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6853E83EE3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX9X-0006W7-BY; Wed, 04 Feb 2026 02:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZL-0004f5-TV; Wed, 04 Feb 2026 01:40:55 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZJ-0004HE-Vr; Wed, 04 Feb 2026 01:40:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvmol2kIjWkyDPIiFkIermjVnajLdps/RRoID3XUg0qRfPpb6lQteCMYnULuNRJrwzbboRphH7STgdqvr6I/LOYMVi/Lz5Dgwa4O2OJ5PX7CCV2e1GpO8A+G8CPkAhC/QX69UpRxUQyGwVlvfBYuV16Xj0SzVz+6MEd3JfibPWhkL9MXRiHKrgDiR9NrqGXeAUO6wfajjqp+sxWyVsoD84EN/8JrHFQ94AjeK92vK/2Et1ECV6Rra51gjQBzJDMpwKpz17KZT22fCK4RzYR1U/Khg4rGWufKpyNUQKzcXn3Jh303oEJJAgVfx8xMudo3Ut1dshnpfUtpDQGM+agNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HxCxHDktcIzXCIZckd9BrN4dC+PRK9QzfFArg4Wo4E=;
 b=cCDrljkPjw3+mp1kRHErZ+aUWizTISXGTOWIPxF1efFLF9i4+/GpE3Kz2XcEiI9u4XCrwYgNjxHhiokM0LZ8tU6CtaPmsBowaUrRiRDpVk11hFkeGT2UM1FfmG0tvKloxrKW9DD3Yoy6MqQmKADpF11jUOozxEEGEyg9AmddNmO+sANr+SqIC+Kx31IFBd7jdB3ndODcwg9jEBHlwPjwSimzB8JqzFnBoyDRGnKxgnGdjAyaWPfl/4AgwFrWs554E09OcJf/7xWP7+Ussleituu6O/G79J7PQ1Vg9O4ZncdVIN8/KF8c5AgEx/kNEMDGuQxlqBF2hnpSf1HuKy54+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HxCxHDktcIzXCIZckd9BrN4dC+PRK9QzfFArg4Wo4E=;
 b=Guzegf+4fipv20P3HzpHrkKWkvrS2pNsRl7YTfyBvMAHPkpyJwX4aV1unxKQ3EhFgL0sCfV88N1z27V/q7KSJLS3dKFMUhGmkLfE2Ph6F5z5Wx8mI3T+bBr5cx0acWWnrDtkFb7Jk/F+qDKN2nhRq7kLB674KKlnDLkGj+UcYjIdU6XPUhUg2g+AfQt13klMlWvMfM4rj/P4QXER4MNad2BJvfOfM/HlBY+3+K6JCU6NNR3Feprfvqvw3U2k45sUFEtVj6LFCvzlZEEkxHaaDD33NHrUssJZzGcFcB+s2WyJoRDEC0LQwBuwzDrfCso7eey3tRJZ98yxR/gBrO+f6Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY2PPFD3DE53D05.apcprd06.prod.outlook.com (2603:1096:408::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 06:40:24 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:24 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 05/22] hw/arm/aspeed: Integrate AST1700 device into AST27X0
Thread-Topic: [PATCH v6 05/22] hw/arm/aspeed: Integrate AST1700 device into
 AST27X0
Thread-Index: AQHclaEkcPgw0qI+sUyKEDruGxfi+Q==
Date: Wed, 4 Feb 2026 06:40:24 +0000
Message-ID: <20260204064016.3515639-6-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY2PPFD3DE53D05:EE_
x-ms-office365-filtering-correlation-id: 9ca6ee6e-3453-4657-bc2a-08de63b846c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eGlld1o0amVjeFdQajlEb3Axek1yRTlVN05KRU5uODVVcmRVQks2SFk2RE13?=
 =?utf-8?B?OTRoK2lNRk5XVjhNdHZGWWlkc1Z0dVdUSDJVbUExN0pxWVhpTlV0L0EzVGVS?=
 =?utf-8?B?NFo4T05KTi9Ya1QvR2VJc1ZtYkdJQmQ3TXdDbE9QNysyaWFwUnlTR010ZWJC?=
 =?utf-8?B?dEZGdkdkamJiNXFwYzdmTWhaS3Y4KzlLWGhMM3hIcDN0dUlzMm9QTGtnMlIw?=
 =?utf-8?B?T3NNbTNkUExoYUV1TUxaam02YmlCUFVaNUZhVW1FUXh1WEJCdWVHeVdPVkx4?=
 =?utf-8?B?Q1dpa2E0eHhuQlBnVm1hVDZEMDZkV1NPOEsvNGNXVXdVQW91TWhsOEtTMkJi?=
 =?utf-8?B?UCt2RmdrUTYyVVJUejlndHVnUVNQYVRrbXA2OUZaR1ArZmhmQVZWUFIzNzBn?=
 =?utf-8?B?RjRiV3hyVFhMdzRrMHhCYzlMOEtkMHBoNmxjd2tvTnhVUmxzNGtvTHRQa0Nw?=
 =?utf-8?B?TFpmc3d1dXU2N0d0QXMxVzVQMXpYelBrZktUUXRmQlFFaU5aU25aZnVjQkFi?=
 =?utf-8?B?aFIzV1k3dmlTSUdkaENDMFBWV0tyWjVGRGFyTnJaRndoNlVEOWxYY3lOY2FG?=
 =?utf-8?B?YlU4Wk8wdmRqcTlpR2t0V2llQ3AySkRXNFlhQTlQWkU4M09vc2dsL0VYSVN5?=
 =?utf-8?B?cG1OeDZZcFloUmpkVlYxdVZVUHIrbXk3dFl5RE93UUlrMlA2aEk2N3QvZnQz?=
 =?utf-8?B?d0I3dU02eFFsMWN0Sm93YU5YVERMMXlCWHVTR0svRHBnU3dYNHRQa0xMSTly?=
 =?utf-8?B?RjBGR0lHRVRtdlJGWUJ3MndvOHZBbmVmUkRFNnJhMDB1Y3J0Qk9uQ2dESFpM?=
 =?utf-8?B?SS9raTdOMURucmE4dUpubU1PVVRqMXV5UnhFbEFJYnhFVndjd0JQTEd5NnJL?=
 =?utf-8?B?TWpYdWZiZmo5Lzdpb0lSUG14T3drSkorZWZIcjN5MmROZDMwa1BvSitmYUtr?=
 =?utf-8?B?ODBSY29HVUFLN3JDZEJVS2haOXVwM3JLTmxZMitQQjduaVEwdGNsRjZuVUVY?=
 =?utf-8?B?RkR2Ti9yNDZSUkNOVDhmOGRFVnIvd2RST204Z0ZaRXZlb2xIdXRlOXUxMzhB?=
 =?utf-8?B?bklxZ1pnYlF3OFVISlhnQkd1c3hUVHl5em9vQ0hLQ3k1U1BzVlJ5N1lJZnpm?=
 =?utf-8?B?b0JoZzZZa1VFMVJHV0ZQNmV1QkREMW1kWFJhN0paSjZEaFlDTm9RbTArSzhH?=
 =?utf-8?B?bGtOU3FlTlNVdHJ5S2tQTDNNbTBHK0hRd1l5VExEUmE2S2VzRFRBR1lmQzlk?=
 =?utf-8?B?UWtmVXFuaVVOcERmNFFFSStYQkc5K2l6U0RsLzAzZWtPQi9QcjlBelI4Q1Rr?=
 =?utf-8?B?MlZGNUxwYUtmV2M4aFE1OW1VSFdOa0U1bEdiRWp2MDFPU3pGOFBVRnlwYkxa?=
 =?utf-8?B?aGUrMTJxSlIrUE5xRnphbGUrNFZ5UHdrQWRzU3FCOC9ndVA5VkVRYzFqUjFZ?=
 =?utf-8?B?T0NNTmdSWXBtZTd5cHZYbVRKc0swZTlWOXN6Q0x3V3JpYTIzME1zdkh5bzJM?=
 =?utf-8?B?WkdnNWJNdWkzMkl5cmQ4bzhXMkliOWFlLzZESGo5YnEzY1hLbHZVYmNHZ0xR?=
 =?utf-8?B?dHQ2RHdUOGo3N0drSUptZk1Nb1Z1WXNBNnVCdy9mT0swNzlMYml1WUpUNTNE?=
 =?utf-8?B?S3A0V3lnemRSK0RvUm9CYXBGV3k2eEVJc0JjaHBneHRlNXZER01wUnRjdkFS?=
 =?utf-8?B?Vm1kNFE2dDRaMnlVL0svb3BnWHNjMlJGMWpSYWFXc1RCWEZTZnRWQ3RTTDBM?=
 =?utf-8?B?K2dISHJOZld1N0NJNGtoM3lJVFo2b0xGWG45alU0TUh4dDAybXE3SzJJQzhT?=
 =?utf-8?B?RC9uQnV4dHZwS2RldEJXUDNDNFNRZm9NWEZtdjNadkdFUi9XT2d6WjB4dVgx?=
 =?utf-8?B?NXFLZk9XY2VKcmtxTmFEZXltdzBsVkEwT0pIczVnYlJsWUxodjMrZ0hNK3FH?=
 =?utf-8?B?TmF1N0hWTjNRZzM1QkxWdUV1ZStjaThYb25GNm5ZbHQrSllqdzV4bWNUMDZk?=
 =?utf-8?B?cFpsMzZMR2pETW9wbGh4emQ1N3pXWHdhT1FHNHlpTkk5ejBHdTNMSGd4anFB?=
 =?utf-8?B?RGRQQ2xiRExJa0FwMWQvNFZ3RDRmL1RsRGxNU1R3WTJmWHBiMndrM0ZSNlhY?=
 =?utf-8?B?eXBud0NmUkFzTm9wYVZUNXIyVG42NnBCTXRRaVFQVEZoc3Axc29kbzJZaCtI?=
 =?utf-8?Q?koCYtLuemI2d8D4xRgiLtBg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJTQ0RxaVNOZUVGMldZWmhrSTY5clFlS0ZCTWVzQ21KRzVsZzM3cVdtU0N3?=
 =?utf-8?B?NHJ4cW4vWE5GNjFXUlN0WWFoamZEWGFXWVZxcWlwRmVOOW9qTE4yQ0lUVDdU?=
 =?utf-8?B?YmYyTy9YVlY2Y2tZRXR4QzRMT0NpMi83Y0JjTXNqS2ZsNExMWXkwRHUyMHk2?=
 =?utf-8?B?dS9GQ1JTVEt4Z3dUZ1J4QVJCNmlBZGgxODFrYnlTR0NvZXRvNmQvaVRDU3dk?=
 =?utf-8?B?UW5KUHMzakdENTFnczJ2eVdhemhUVGhORXF1UlZEbXh3WU9xZGtVRERqMlZR?=
 =?utf-8?B?KzNFVzMrSTIza0dBa3d4dHM4M0g4S2tsSlZ5OE43ZU1WTW1NWmh1QmNVZXJR?=
 =?utf-8?B?SXdTRlVZVVk0UG9ZaHFqcENpN2pvTlVyYXc5ZG9pMGFkZzhnQ0l3eGRxaWJL?=
 =?utf-8?B?bzRtWVpyV1lPM1d4ZEF5T0dzeGhxVE9CYlFIbzdFbXhIMlBrVW9pY2xaQlV5?=
 =?utf-8?B?WnFnQVprckcwOEdFaHJ0RHBVSWZtOUd2Lzg1Z2JjUTNDelNBTjB5Unc2N2h6?=
 =?utf-8?B?RytGMHBuZDd1ZUxXR0pKRkZSZnVrQ0t6Y0V4Z3QvZi9ueS8za21QRTk3Y1la?=
 =?utf-8?B?Z3ArTEZCNXlqMWNEa3NmMi83OGEraXdoYWxDMlNhb2xraTl0OEljT2tRaEhp?=
 =?utf-8?B?b0YrM2VPUEtRNzQwcGlhY202VzRoM0xQYzBqeU8zM2ozbkVNUnVuN0ZvbEtM?=
 =?utf-8?B?R0lzdU0vMGtBM0VTOXJJZ3IyaGlRaVo4YU9rQWhXRHk2OGVHMW1RZ1RqMk5R?=
 =?utf-8?B?bStnb2d5VVlNbENnK0F3UFRPSittRWpjcTlKUWNQMXlPNFo2c0VxTEVuR2VH?=
 =?utf-8?B?QmZGNjhmdTZFR2l3OXhkTW1aMDVCRnBaSldZd3l0UW5HOHZWSWhQdkY0ZTN4?=
 =?utf-8?B?K2ExOHRLNU5EdTN6NWRaUmNKNmlPNXByTVZkREFJZ1ZURjU2ekl0cVZESWlN?=
 =?utf-8?B?c3VJb2lLWkdHRFFEbUZsWklVSXQ4VlFjb1ZUMFUrQzExVjJjWVBndWRSYUlH?=
 =?utf-8?B?ZGNqc09EdnJHOTd5UzgwYlJqdWpmVFZmSjZBWE5oRFpVWEN0ZS95Qkw1Szh1?=
 =?utf-8?B?WWJGUVNSQmhMNVNCWWh5RjA3OWhQd0JZdGs0VnRpemVydis2QkVscUI2U25x?=
 =?utf-8?B?REV1QjFZRlRGNGZrbHcwYUV1elZXdldDZzVtMFlwNFdNOS9qN3BCU0RQZlI0?=
 =?utf-8?B?UlFnNGswVnNDZTN0Q3FLSDRGNWJZczROSUVTLzVWQ2o1YTQvdXVHR085M3Ji?=
 =?utf-8?B?TDYxbEF4djNJL21WbUVLdGF6cDBZOVBIbjJvcG9yVUhOcnF6eDVac0Ywdkda?=
 =?utf-8?B?YzlQZVFCV1BINHFCNTc0a3NYSXlyL3pSNjBPTnVsUlR4NlM2TFZGaittTWto?=
 =?utf-8?B?b2NNYmFCbWYrMkdRSDlvSGpadEJ2NzZHOGhiZGdabHNVRDdlZXhsTVY3QWl3?=
 =?utf-8?B?VGdrVzZ2TnZXOWM3U0U1UEpaMVFrQWw5U1VvRERTdmZkVFgvZWpJdXRjTkV6?=
 =?utf-8?B?TGQ3bEE5a0tlVkEya1ZRaHVRN1RncDEyVmRVQjBBbktJdkp2OGcya2NZejdF?=
 =?utf-8?B?ZENyeWhMYmlKU2V6THJiZWJJNjFxWFkwS09nNWlRZDROdGo4Ukd1RHU3eUFv?=
 =?utf-8?B?K3JjODlUcVVMV0YyVXhRTUNLdFJmR0QyZXBFREVqVG5pc0hOYWh0UmY0Rm81?=
 =?utf-8?B?eklYbkk2R2gzZUErMXFCdVEzVlcyRXZYdFp4eVhXVXJxUVZkdjBIeTZSZUtz?=
 =?utf-8?B?NzhJNGE5NkU3UTdrcGorbml3cktlTWdQcE9SUFBWb2xtU1JpbWlxYWpBMzRl?=
 =?utf-8?B?UDV1SWlzM016bUdnMzNyZVJCZFdHeCtmZm5yUEQ0UGlYUzJsdlFyRG5WdkRP?=
 =?utf-8?B?aWN6Z1UyU2dqNUt1Snd4T3c1V1ZwQzc3djFMejh5bExZTUc4MXlFZFBPVUhR?=
 =?utf-8?B?bHR5ZmtvdGFvcW1xOEx2SS82NWZMZ0lpblI5OWQ0WFk5WGZJUnJicUJQbkpl?=
 =?utf-8?B?YlJSMUw4OU1IZWVEd2w2UjRWRC92cUZ4MnExUzJPRzNteGoyTnJ5KzlMQTdJ?=
 =?utf-8?B?cFVMS1l5RFJSNjVIRlFzQVpnbjBJVG5NTFltbE5VR3BTQkxJNDczbzRFU3VO?=
 =?utf-8?B?bkg4Wmpvb204dUY5YUMyQnkvdUtmeG9uM2M1TjB4WkIvZC91M3RFcGEvYzZu?=
 =?utf-8?B?dWcyZEVGUHVKd1V3YTJUVmkzallJLzhYTFZwM2tHbHByRVJNQWNIdi9rZURU?=
 =?utf-8?B?Yi8rQ3VNQVpmYUQ1UlJnRGNEZkNxc2NnSXc0QnE3NTF1S01hc1lOUXY2bDBi?=
 =?utf-8?B?MDBibFVKcytvMUNodlFHUTdSVWZIam9MWCtHNmxzQ2tGdGVwVmhHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca6ee6e-3453-4657-bc2a-08de63b846c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:24.4870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9qfI8v9DluitKRrrR/xBuxc2QJzknFTS3yv/+x91JtS5kheNez/4Fu8zuOJ2MQp6QTGzH+AA3N4EIUEkan49Y1kivYmFbTu1j06mn5nK6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFD3DE53D05
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

Q29ubmVjdCB0aGUgQVNUMTcwMCBkZXZpY2UgYXMgYSBjaGlsZCBvZiB0aGUgQVNUMjdYMCBtb2Rl
bCB0byByZWZsZWN0Cml0cyByb2xlIGluIERDLVNDTSAyLjAgTFRQSS1iYXNlZCBhcmNoaXRlY3R1
cmVzLiBUaGlzIHBhdGNoIHdpcmVzCnRoZSBBU1QxNzAwIGRldmljZSBpbnRvIHRoZSBwbGF0Zm9y
bSB3aXRob3V0IGludHJvZHVjaW5nIGZ1bmN0aW9uYWwKcGVyaXBoZXJhbHMuCgpUaGlzIGZvcm1z
IHRoZSBiYXNlIGZvciBMVFBJIGV4cGFuZGVyIGVtdWxhdGlvbiBpbiBRRU1VIHVzaW5nCkFTVDI3
WDAgYXMgdGhlIGhvc3QgY29udHJvbGxlci4KCk5vdGU6IGlvZXhwX251bSBpcyBzZXQgdG8gMCBh
dCB0aGlzIHN0YWdlLiBPbmNlIGFsbCByZWxhdGVkIGRldmljZXMKYW5kIGludGVycnVwdHMgYXJl
IGZ1bGx5IGltcGxlbWVudGVkLCBpb2V4cF9udW0gd2lsbCBiZSB1cGRhdGVkIHRvCml0cyBleHBl
Y3RlZCB2YWx1ZS4gVGhpcyBlbnN1cmVzIHRoZSBtYWNoaW5lIHJlbWFpbnMgZnVuY3Rpb25hbCBh
dApldmVyeSBjb21taXQgYW5kIGF2b2lkcyBwb3RlbnRpYWwgY29tcGlsZXIgb3IgYnVpbGQgaXNz
dWVzLgoKU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5j
b20+ClJldmlld2VkLWJ5OiBD77+9ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZp
ZXdlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1i
eTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX3NvYy5oIHwgIDcgKysrKystLQogaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMg
ICAgIHwgMjYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9h
cm0vYXNwZWVkX3NvYy5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oCmluZGV4IDdiMDhj
Y2E5MDguLmYxOWJhYjM0NTcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aAorKysgYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmgKQEAgLTQ1LDYgKzQ1LDcgQEAKICNp
bmNsdWRlICJody9jaGFyL3NlcmlhbC1tbS5oIgogI2luY2x1ZGUgImh3L2ludGMvYXJtX2dpY3Yz
LmgiCiAjaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRfbHRwaS5oIgorI2luY2x1ZGUgImh3L2FybS9h
c3BlZWRfYXN0MTcwMC5oIgogCiAjZGVmaW5lIFZCT09UUk9NX0ZJTEVfTkFNRSAgImFzdDI3eDBf
Ym9vdHJvbS5iaW4iCiAKQEAgLTExMiwxMCArMTEzLDEwIEBAIHN0cnVjdCBBc3BlZWRTb0NTdGF0
ZSB7CiAgICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRlIGRwbWN1OwogICAgIFVuaW1wbGVtZW50
ZWREZXZpY2VTdGF0ZSBlc3BpOwogICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSB1ZGM7Ci0g
ICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRlIGx0cGk7CiAgICAgVW5pbXBsZW1lbnRlZERldmlj
ZVN0YXRlIGp0YWdbQVNQRUVEX0pUQUdfTlVNXTsKICAgICBBc3BlZWRBUEIyT1BCU3RhdGUgZnNp
WzJdOwogICAgIEFzcGVlZExUUElTdGF0ZSBsdHBpX2N0cmxbQVNQRUVEX0lPRVhQX05VTV07Cisg
ICAgQXNwZWVkQVNUMTcwMFNvQ1N0YXRlIGlvZXhwW0FTUEVFRF9JT0VYUF9OVU1dOwogfTsKIAog
I2RlZmluZSBUWVBFX0FTUEVFRF9TT0MgImFzcGVlZC1zb2MiCkBAIC0xNzgsNiArMTc5LDcgQEAg
c3RydWN0IEFzcGVlZFNvQ0NsYXNzIHsKICAgICBpbnQgbWFjc19udW07CiAgICAgaW50IHVhcnRz
X251bTsKICAgICBpbnQgdWFydHNfYmFzZTsKKyAgICBpbnQgaW9leHBfbnVtOwogICAgIGNvbnN0
IGludCAqaXJxbWFwOwogICAgIGNvbnN0IGh3YWRkciAqbWVtbWFwOwogICAgIHVpbnQzMl90IG51
bV9jcHVzOwpAQCAtMTkwLDcgKzE5Miw2IEBAIGVudW0gewogICAgIEFTUEVFRF9ERVZfSU9NRU0s
CiAgICAgQVNQRUVEX0RFVl9JT01FTTAsCiAgICAgQVNQRUVEX0RFVl9JT01FTTEsCi0gICAgQVNQ
RUVEX0RFVl9MVFBJLAogICAgIEFTUEVFRF9ERVZfVUFSVDAsCiAgICAgQVNQRUVEX0RFVl9VQVJU
MSwKICAgICBBU1BFRURfREVWX1VBUlQyLApAQCAtMjg1LDYgKzI4Niw4IEBAIGVudW0gewogICAg
IEFTUEVFRF9ERVZfSVBDMSwKICAgICBBU1BFRURfREVWX0xUUElfQ1RSTDEsCiAgICAgQVNQRUVE
X0RFVl9MVFBJX0NUUkwyLAorICAgIEFTUEVFRF9ERVZfTFRQSV9JTzAsCisgICAgQVNQRUVEX0RF
Vl9MVFBJX0lPMSwKIH07CiAKIGNvbnN0IGNoYXIgKmFzcGVlZF9zb2NfY3B1X3R5cGUoY29uc3Qg
Y2hhciAqIGNvbnN0ICp2YWxpZF9jcHVfdHlwZXMpOwpkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYwppbmRleCBiYmNiNmUwMTI3Li5h
MDUxMTJlMmIwIDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYworKysgYi9ody9h
cm0vYXNwZWVkX2FzdDI3eDAuYwpAQCAtMjYsNyArMjYsNiBAQAogI2RlZmluZSBBU1QyNzAwX1NP
Q19JT19TSVpFICAgICAgICAgIDB4MDBGRTAwMDAKICNkZWZpbmUgQVNUMjcwMF9TT0NfSU9NRU1f
U0laRSAgICAgICAweDAxMDAwMDAwCiAjZGVmaW5lIEFTVDI3MDBfU09DX0RQTUNVX1NJWkUgICAg
ICAgMHgwMDA0MDAwMAotI2RlZmluZSBBU1QyNzAwX1NPQ19MVFBJX1NJWkUgICAgICAgIDB4MDEw
MDAwMDAKIAogc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI3MDBfbWVtbWFwW10g
PSB7CiAgICAgW0FTUEVFRF9ERVZfVkJPT1RST01dICA9ICAweDAwMDAwMDAwLApAQCAtOTEsNyAr
OTAsOCBAQCBzdGF0aWMgY29uc3QgaHdhZGRyIGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1tYXBbXSA9
IHsKICAgICBbQVNQRUVEX0RFVl9MVFBJX0NUUkwxXSA9ICAweDE0QzM0MDAwLAogICAgIFtBU1BF
RURfREVWX0xUUElfQ1RSTDJdID0gIDB4MTRDMzUwMDAsCiAgICAgW0FTUEVFRF9ERVZfV0RUXSAg
ICAgICA9ICAweDE0QzM3MDAwLAotICAgIFtBU1BFRURfREVWX0xUUEldICAgICAgPSAgMHgzMDAw
MDAwMCwKKyAgICBbQVNQRUVEX0RFVl9MVFBJX0lPMF0gID0gIDB4MzAwMDAwMDAsCisgICAgW0FT
UEVFRF9ERVZfTFRQSV9JTzFdICA9ICAweDUwMDAwMDAwLAogICAgIFtBU1BFRURfREVWX1BDSUVf
TU1JTzBdID0gMHg2MDAwMDAwMCwKICAgICBbQVNQRUVEX0RFVl9QQ0lFX01NSU8xXSA9IDB4ODAw
MDAwMDAsCiAgICAgW0FTUEVFRF9ERVZfUENJRV9NTUlPMl0gPSAweEEwMDAwMDAwLApAQCAtNDk4
LDEwICs0OTgsMTQgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyNzAwX2luaXQoT2JqZWN0
ICpvYmopCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5sdHBpX2N0cmxbaV0s
IFRZUEVfQVNQRUVEX0xUUEkpOwogICAgIH0KIAorICAgIGZvciAoaSA9IDA7IGkgPCBzYy0+aW9l
eHBfbnVtOyBpKyspIHsKKyAgICAgICAgLyogQVNUMTcwMCBJT0VYUCAqLworICAgICAgICBvYmpl
Y3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJpb2V4cFsqXSIsICZzLT5pb2V4cFtpXSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9BU1BFRURfQVNUMTcwMCk7CisgICAgfQor
CiAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAiZHBtY3UiLCAmcy0+ZHBtY3UsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9VTklNUExFTUVOVEVEX0RFVklDRSk7Ci0g
ICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaSIsICZzLT5sdHBpLAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFRZUEVfVU5JTVBMRU1FTlRFRF9ERVZJQ0UpOwogICAgIG9i
amVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvbWVtIiwgJnMtPmlvbWVtLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFRZUEVfVU5JTVBMRU1FTlRFRF9ERVZJQ0UpOwogICAgIG9iamVj
dF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvbWVtMCIsICZzLT5pb21lbTAsCkBAIC05OTUsMTQg
Kzk5OSwxOSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VT
dGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgICAgIGFzcGVlZF9tbWlvX21hcChzLT5tZW1v
cnksIFNZU19CVVNfREVWSUNFKGx0cGlfY3RybCksIDAsIGx0cGlfYmFzZSk7CiAgICAgfQogCisg
ICAgLyogSU8gRXhwYW5kZXIgKi8KKyAgICBmb3IgKGkgPSAwOyBpIDwgc2MtPmlvZXhwX251bTsg
aSsrKSB7CisgICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPmlv
ZXhwW2ldKSwgZXJycCkpIHsKKyAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQorICAgICAg
ICBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoJnMtPmlvZXhwW2ldKSwgMCwKKyAgICAg
ICAgICAgICAgICAgICAgICAgIHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9MVFBJX0lPMCArIGldKTsK
KyAgICB9CisKICAgICBhc3BlZWRfbW1pb19tYXBfdW5pbXBsZW1lbnRlZChzLT5tZW1vcnksIFNZ
U19CVVNfREVWSUNFKCZzLT5kcG1jdSksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgImFzcGVlZC5kcG1jdSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Mt
Pm1lbW1hcFtBU1BFRURfREVWX0RQTUNVXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBBU1QyNzAwX1NPQ19EUE1DVV9TSVpFKTsKLSAgICBhc3BlZWRfbW1pb19tYXBfdW5pbXBs
ZW1lbnRlZChzLT5tZW1vcnksIFNZU19CVVNfREVWSUNFKCZzLT5sdHBpKSwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLmx0cGkiLAotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9MVFBJXSwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBU1QyNzAwX1NPQ19MVFBJX1NJWkUpOwogICAgIGFzcGVl
ZF9tbWlvX21hcF91bmltcGxlbWVudGVkKHMtPm1lbW9yeSwgU1lTX0JVU19ERVZJQ0UoJnMtPmlv
bWVtKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLmlvIiwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfSU9N
RU1dLApAQCAtMTA0MSw2ICsxMDUwLDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyNzAw
YTFfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgc2Mt
Pm1hY3NfbnVtICAgICA9IDM7CiAgICAgc2MtPnVhcnRzX251bSAgICA9IDEzOwogICAgIHNjLT5u
dW1fY3B1cyAgICAgPSA0OworICAgIHNjLT5pb2V4cF9udW0gICAgPSAwOwogICAgIHNjLT51YXJ0
c19iYXNlICAgPSBBU1BFRURfREVWX1VBUlQwOwogICAgIHNjLT5pcnFtYXAgICAgICAgPSBhc3Bl
ZWRfc29jX2FzdDI3MDBhMV9pcnFtYXA7CiAgICAgc2MtPm1lbW1hcCAgICAgICA9IGFzcGVlZF9z
b2NfYXN0MjcwMF9tZW1tYXA7Ci0tIAoyLjQzLjAK

