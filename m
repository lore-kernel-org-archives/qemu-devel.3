Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277D0E7317E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e6-0003UJ-Gd; Mon, 02 Feb 2026 20:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dp-0003Mk-SG; Mon, 02 Feb 2026 20:55:45 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5do-0007tD-Fo; Mon, 02 Feb 2026 20:55:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=picc7/sNrWU+OQruKSqYLXzzGfpS3zNdAQGATafe8PFj8f+8aBzHMwcRKo67b0MrCQLRedVFHjJUqG+DU2bc95ZYL1DtyPW2fypGclEUpj/zFB+ogc7q30wmJRo9hF+R0yPLPq6JS7vdPN3mbF3HJop+ZK8FLfcA2fYpblPmUOUntPVRTk9yPxL0p8cMVpHN/Ye4UbWcnciTTTvHxt9cmlGofLERjgSb3yrChiRsxHBzEmuIaou4i/TRIZMqaKpKImDxtasz72+F3EjySk2AfCOlClyq5jruqYosG9bC0TPywUqq+8zcU5XPcRq/xMMS1Md3o9qItRNygxB3I0LUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ULmRsf8Adi6oFnNmPXiwRg2wVuT2Te0y6il12B3Gfk=;
 b=n7jDGU6S7KXjYZ3M0t11W76ln/50MopeSEnODP8APstAzamj0jjcWUH+0F+dvz5PXupT2cbaycczg1RV07CbaFKiW0g32SzOsumEgRwJgqtlQHKYr+7tywoUZzUjs11aonrMuy3AjnP157ATu5A3SzQj2j7FQEF+GIW/W1VhUj24gtzGJGvxwnx9d5km9Ph8sXLxMV4YaKEVzPgj7suwBYNNaWObewRlHRTL96lMVusR618Ji8aiqSfh5vlT6jcj+IyBZpc47rmmKd5Cw5y03XTIPRX+C+qxPU1n+B826suqApHLVOnsltaGWyQl9IaXCeAIWJTwmFcKTmObOSq2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULmRsf8Adi6oFnNmPXiwRg2wVuT2Te0y6il12B3Gfk=;
 b=B1LSrIDA6mbRihNKngf4rM4xBM8YWoyO5c22/rg6ZWm0rnWZII5VOv8rq0p4SX6HBgoHjyT/mE2QcIbRyZa563qzGRhrdWmqGWLRHeRR4yrUoyxSUvrGGqtx7jpkRuG3TnQTeDgDg/SDSiDi9QSMV9+RHBKfQ1WxzztSjrODyhllxrdDo/CAvouOb9T08KRyrRtw4ohbAsAgvEe7J+9qR1Wtcf5+8C++7S6FJmBdcG07/QQxZe/vxu6pbOeTZO6hi093wn1EcVPyj4g/dCeSKUwpGGY6i7A0rH4c8rgJOTtTcBMxR2vjf4MH3QMRYOcZKKDXkSeLUTgZOJfYwC9GoQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "clg@redhat.com" <clg@redhat.com>
Subject: [PATCH v2 3/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
Thread-Topic: [PATCH v2 3/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
Thread-Index: AQHclLAuiBdj+G5VrUWnrJO5yPqUEg==
Date: Tue, 3 Feb 2026 01:55:32 +0000
Message-ID: <TYPPR06MB8206870D7B011208F4A8A77AFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: 0c3cfcaf-09ad-44d8-c56e-08de62c750db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVAySTFxdDd3eTBFeDg2dWg1QmNKUytFZXh6TFNYajdmMFgzNUVKWERDdmk2?=
 =?utf-8?B?dVVzU3dSYjJsazZLc3JXWERBcnlFSGFHV0lOdjJHVVpqRjJPMmNXbWozMmI0?=
 =?utf-8?B?YzAwUkhxcnoyNWxTU1pQb2VhSXp1ZFU2OUxOeHNtdWV0OVlLMk5tMkFyL2Rw?=
 =?utf-8?B?aVlMSGdBVkUvazJ4MjBiSS94RWNQTlQ2STkyNUV1QjhQOE85NFh5NWZ5Ymp3?=
 =?utf-8?B?UHByNll6NHdWTWJCcFY4MmlyMm90OXhqMFB4a0oyYVBFL2VsbERxdnA0Y2s4?=
 =?utf-8?B?NFlWVzlHeDJQamZJS3J1b3JhYmpzclFtTjY5K0VGMG81NDJTM3VWOVM0NXpQ?=
 =?utf-8?B?a2oxUWsrRlJtM0trbHp0WmJ6aDMzZzhFK0Z6NTJET0hxN2dpYnZrUGxUWGpM?=
 =?utf-8?B?REV5cTgwY1RsR1lCbDlwaVJIMHhrY0gxU3BjUTBrVEt5dUR2eGp5SlZPa2dX?=
 =?utf-8?B?bHdIYjZIUGRyYnNwOWt1RGxiZjg0WFp5bVFnUVc2VjB1KzEyejR3S082ZlRj?=
 =?utf-8?B?bVVXNkVVSk94KzFkNVpXaUFoNGI1QUxuQ1hwRmh2QTczZ2FSajJhWkJ2REdp?=
 =?utf-8?B?M2wrbVVTalROdGpMc0RDU3ROMDREVXNjVG4wandjU2t3OFh2OGw0a3BjdDJl?=
 =?utf-8?B?d2UvZlFyR1Q2dTE0TGVQUzJRZXdKdEJTaXBPSmxXcnhIRlNiWTVYU01WOWdY?=
 =?utf-8?B?ZEpMTklaLzUrR01OZDNzVlk5dm5jNDFKUUpUOUhiejlSWkhNR1ZVaTBtSWxM?=
 =?utf-8?B?OHg1Y1V0YkJWaHQxb0s5SWsrRjE5VEFab3NlQXJ4em5GNWFla0FKWUF6TUpp?=
 =?utf-8?B?RkxFRnZobXJrRGxSQ3BmN2hPL3l0UE52S0J1czFqRDc3bWlJU0cyZnkvKzRn?=
 =?utf-8?B?dkJKSm1QbC9uOHRYMDNyZGVoZ1d6MXFHazhNRWFHSjJnK3Y3VEFSZ3krYWly?=
 =?utf-8?B?QWJicFhtdHRVT3ZjUFc5OTlEVTUvaHVodnRnL09wbVUzaTdjenZYbm1pQitF?=
 =?utf-8?B?aUdrTjVWdUwxN0YrR29ydUhsSUhhaTFwTTZXMHR2bXYzNHNvaUVidmVxZkFv?=
 =?utf-8?B?N3NUazBEVGVoZ2Q5bHdNWVJBL2R4NjdUVzBpWjBZZldqUklyRmZodlY0ckw0?=
 =?utf-8?B?SEgyU0R4RWVQS3FCVlAwd0xRdTM2Y1VOUDlVYjF5MFlSbTc1R29PNjdCVzQ5?=
 =?utf-8?B?Q1VHblB5TWJqb1A0clhLNkkwaVdRRkU2SW43bTZ1MFJOYTFLUlA2a2twSGxR?=
 =?utf-8?B?UGdIb3JpY2Rva0ZpcVY0eEJXK3ovQWZwc29zTDc3Wm11T1JwMG84dXF3Ykht?=
 =?utf-8?B?VW0xVFJBTE0rQmNnVkxJSUNTM202U0RpMnI1dkVrckMzNDI4N1JzNG5PTEFD?=
 =?utf-8?B?VFNCQU9LbGtXZXhiTHpKUVZGU0hMQmQzMkM4TStEK21MeHNXdjBjRHJKR2Iw?=
 =?utf-8?B?a0JnTjd0TmVZdXBWOGlTNW9kQW5vUkdqcnRFVVlKOUh4N1BkUzBURU00Nlcw?=
 =?utf-8?B?cWpuNzgzMGk5Tk1qRkxLTERlWHBiaXdobUJIR1RjNFlCTWZzTlZvM3hQYjF5?=
 =?utf-8?B?a3Z1cW9kM2JMR1VPV01aTU9Ebzg2MXFpT3N4SGoyTHgvVVI4Tit1VldzN0Ro?=
 =?utf-8?B?K08vZ01haWk2WThYYWdYTjVPaEEyU0lVc3ZmYlF6TW1RNlk1SlhDM0NGSFR1?=
 =?utf-8?B?T3dpY3puSm1MV0NPTWh5eVpUa0Z1bk9QMHhFSjdUT2MxSFYrOWt1K0pSVTd5?=
 =?utf-8?B?WWt2OVNCTk0rZUkvTW13SFYrQy9oc2VKVjFxQVA3RkUrT0xxMENLajZxZkRt?=
 =?utf-8?B?TUJ5OTN0QkFrNzFpWldkeGJxK1ZmV3dYdGZRTmJUSDFnQXB0ZkJaMVdUTFNS?=
 =?utf-8?B?UjZtUVREMkltVTVuT0E1a2lpc2FZTVRobHd1cDRpZjRYbXJsbVc5dmE1anJW?=
 =?utf-8?B?T3pvKzN2MnNLQ2d1emdBbGFLcHRWWW9jcVBOZmZtK1FQUDJqbVBwYUVJRTd2?=
 =?utf-8?B?eXY0dDBIV0Z2b0tVL3p2Z2FxVGhYclJRcHExKzIvV04zd3lDZ1M3WUV4SHlp?=
 =?utf-8?B?WWFwaDJTTGQ5cS8rM3gvUG1HUUlaSTlhbjJQMTRlZkhrRWJwcHkvQXppclFV?=
 =?utf-8?B?bFlGT3p2NFArWGFNN21NVXpFTHRLNDMvWlo0MWltVlN1T3pNZVNvcG8ya2Qv?=
 =?utf-8?Q?/1timncK16lKX6fYvEwh/aY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0kxa3FVNmpUNXZkL25EWW54NGFzYUplbHBxNnM5bUl2WU5ZTlRMUTNNblJz?=
 =?utf-8?B?UHdkOS94TWJQaWZ1L3BiMWtOZE8veFBMNytkeHIyeUlhQ0FHa2NKdk1ySVhJ?=
 =?utf-8?B?UDI2cmxHeHQ0NytOdnZyNm5UQjAwckdPUHB1UDBTbVY1Ym9KMi9TNXNTZkNV?=
 =?utf-8?B?ajJtbWw5LzVJekl4dk9WZ1M0NysrSkMwN01nMkdqODloWWs3em16TWE3NDAz?=
 =?utf-8?B?YnFOOEJ5R2hPdEc2L1FmZUo4RWR4L0JaRHpCSE1Ra09KdDBCT2l2VmlCdmhR?=
 =?utf-8?B?Si95QmNGSXp1SGxoNzVrMHFjUGZxYnpqR2lzajhwMk1RM1dSMDdEREdaL2t2?=
 =?utf-8?B?Wk5sRVFaKzBVRlkxenM0bHU4ZWtubGN4NTFnQjJFWnRCN09zTzZtVEFqSmxm?=
 =?utf-8?B?L2oyZmcxV3VVWUZXU085MnRkWERRTVJya0ozY3cyY2FGajVrTXNteTgvWGRn?=
 =?utf-8?B?cWRhdkl0T1VJUS9QeTNVc2YwUUtkaWhMQXZVSE1JUDA2U0M5S1FKVDBMUmg0?=
 =?utf-8?B?QWMyR1dTQWkvRStlQ0Fzd3FqNE8zaXM1dy9IZ2pCVTgvV0d5VHJISVNHc2dV?=
 =?utf-8?B?RXF4NGdwSFhFUU9ZY0R5V0dGRXJvWmJhUXhST0tPVjU5MTF5TGM4QjV2ay9P?=
 =?utf-8?B?MjI5Q0gzaXJacm5Jc3BlbXBTdXdLbnUySzE1RUcvcEw2aFlGYm55ZDFjSkJW?=
 =?utf-8?B?SjhUU3A3TldBNEJCNDZRM0FwdmZzNHgzZ3ZKNERUSGFzb0ZSTWNRczJjSzAr?=
 =?utf-8?B?UkF1SUVMVWdsWHRUbVB0SWh4QjNDd294V0YzZlhFL3RqSWxaTzNxUFFqbWNh?=
 =?utf-8?B?OHMzN3pUSUcxUjZBZStxWXhGbm5uWGdrRWVVTXdZZTB1NWhOSHpFdVRvNWlP?=
 =?utf-8?B?dTJFOFFnRkhSYWN4aEJ4VGZBRDBveUpRTXNnR242cVFScThYTkxqU2ZHaUcr?=
 =?utf-8?B?bHJoa1puVmZtZTFVYWdpajFpcXdzSEpNQS9Xdnd6eHNnTjNUWUZXaDArWnBX?=
 =?utf-8?B?S0NDUEtWWHZ3U09oWllyM2FLTldLTnBuYm9tTU5kZE9CcHBQcWVmMFlqbC95?=
 =?utf-8?B?U2NabXFUK1RCcWxrbExNVW5NZXBVdzF1ODZpc2JHV2dKd2lsVm9XWmpwYnhG?=
 =?utf-8?B?K0I1cEczeGdlWlprdm9lS05yR25Ta1hpVllYOWQ1WkNpak5LK0JWb3V1ajVU?=
 =?utf-8?B?TjZKRE5DU1FXcTJDeVhvd0NMU0MxMFRsVURkU01UMDJWTnJEK3plZFZUcGRP?=
 =?utf-8?B?YlZDeFQvWWhPYmNZemRjSjg5cktpU2xnV0srMU0wKytzckNZdXlwM2hGcFpz?=
 =?utf-8?B?TXUrdmpZR3p4WFVOak81cXQycGprTVRPQXZOZjg4cjhDTit4RldZSUlQKzVS?=
 =?utf-8?B?RVN2THF4Q2MreGZlWEp0KzlmMWwvVE5sWWpFalhFcE9vYTd6UUVMdFE4Z1Jw?=
 =?utf-8?B?ZlJnMENKUDNSeUhlUnBnRHRKK052SUlqVER4N1RKQkNLWStpMjRhUk9jSzNn?=
 =?utf-8?B?UnQ3aVgwRnFETGk1emRiZkVpdDhaMVhjODUyckJTQ2xUUEdseUs4R0Jwc3FW?=
 =?utf-8?B?N25vUHhLV0VoMUxocGh6N3hmaEc0U0k4SkdwN0diUExid2xTbWV4cytFVTZL?=
 =?utf-8?B?VlkyUERCTHZzcHV4ek5QQ2R0UkI5L0dVRkMvdkJJNXYzM3JsZ0NpWTVvMmhF?=
 =?utf-8?B?RXRBbERYU3Q0TmNZZTBhTmVRQ0IybUVXV0RWbllvRjhOMm1wQUMxRzhuMWdJ?=
 =?utf-8?B?QzhVU1QySmwzbjFCSUhEUTNlU2RZWGNGNkZ4UTQ0QXBDbGNVU2hMNXRRUFVF?=
 =?utf-8?B?V2VZbnE4STJzbzFHRnkyK1dTcVN1d25za2VMQ3EwcFpNTEd3d1N2RU9qOUU5?=
 =?utf-8?B?R3RvdWVBRFJLZGR0MG4wV3RlOGUyYTJ3TkR1dEQ0bFR1TUpxbFM1clN1K0FR?=
 =?utf-8?B?ZHFEcGw0cEFpc21aQ0xTRk4zeTlGWXpPY29XOXFQSlJlRng0MWcwem9BNjhN?=
 =?utf-8?B?NERYdXVVNzBHaTQ0OFlYbitBditXQmowMG9ONlkrMVZKQ0VzRjJVZ3VuT1pS?=
 =?utf-8?B?dWNNMVRqb1ByaVdueFYvYk9hQXpUd0I0R25odkdSMlk3dU5HOHo4Y3kybzJK?=
 =?utf-8?B?MENmdjI2VWxZN1hxY1R3SDYrOFVDSnlyNUlxWDlWekc3UXRKV0ViTGV4RkI4?=
 =?utf-8?B?WWFUd0hjRk1BZFpHSUVHN0JDMUlEQ0l0RE9Vc0lWWVEzRTgraVJ5bHB5TnZB?=
 =?utf-8?B?Y084aU1LSnBxWVE1RHRTSGpnd2VkSzlIMzgwcWptWllscy9rMmFMdXFDQnZI?=
 =?utf-8?B?SFhPYldzS0VxNUdQM3NFT1k3U2Z6UE5KVWZFTXh5VTB3RTNuNmdrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3cfcaf-09ad-44d8-c56e-08de62c750db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:32.7207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKE3kSDjqrY78ShLYZGdwe5I9artVJAopJdb4X4KaKk6J9UKVJPocaFToAPSEos2C8xK5l87CooFdxDj4Vun2iBN7vHVvFuSXO1YUN6vc3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

U29ydCB0aGUgU1NQIGFuZCBUU1AgSVJRIG1hcCB0YWJsZXMgdG8gaW1wcm92ZSByZWFkYWJpbGl0
eSBhbmQgbWFrZSB0aGUKZGVmaW5pdGlvbnMgZWFzaWVyIHRvIG1haW50YWluLgoKTm8gZnVuY3Rp
b25hbCBjaGFuZ2UuCgpTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4KUmV2aWV3ZWQtYnk6IEPvv71kcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
Ci0tLQogaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXNzcC5jIHwgNCArKy0tCiBody9hcm0vYXNwZWVk
X2FzdDI3eDAtdHNwLmMgfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3Au
YyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYwppbmRleCBlNGJjZjBmYTJhLi45YjEyYmE2
NzQzIDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMKKysrIGIvaHcvYXJt
L2FzcGVlZF9hc3QyN3gwLXNzcC5jCkBAIC00NCwxMiArNDQsMTMgQEAgc3RhdGljIGNvbnN0IGh3
YWRkciBhc3BlZWRfc29jX2FzdDI3eDBzc3BfbWVtbWFwW10gPSB7CiB9OwogCiBzdGF0aWMgY29u
c3QgaW50IGFzcGVlZF9zb2NfYXN0Mjd4MHNzcF9pcnFtYXBbXSA9IHsKKyAgICBbQVNQRUVEX0RF
Vl9VQVJUNF0gICAgID0gOCwKICAgICBbQVNQRUVEX0RFVl9TQ1VdICAgICAgID0gMTIsCisgICAg
W0FTUEVFRF9ERVZfVElNRVIxXSAgICA9IDE2LAogICAgIFtBU1BFRURfREVWX1VBUlQwXSAgICAg
PSAxNjQsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDFdICAgICA9IDE2NCwKICAgICBbQVNQRUVEX0RF
Vl9VQVJUMl0gICAgID0gMTY0LAogICAgIFtBU1BFRURfREVWX1VBUlQzXSAgICAgPSAxNjQsCi0g
ICAgW0FTUEVFRF9ERVZfVUFSVDRdICAgICA9IDgsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDVdICAg
ICA9IDE2NCwKICAgICBbQVNQRUVEX0RFVl9VQVJUNl0gICAgID0gMTY0LAogICAgIFtBU1BFRURf
REVWX1VBUlQ3XSAgICAgPSAxNjQsCkBAIC01OCw3ICs1OSw2IEBAIHN0YXRpYyBjb25zdCBpbnQg
YXNwZWVkX3NvY19hc3QyN3gwc3NwX2lycW1hcFtdID0gewogICAgIFtBU1BFRURfREVWX1VBUlQx
MF0gICAgPSAxNjQsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDExXSAgICA9IDE2NCwKICAgICBbQVNQ
RUVEX0RFVl9VQVJUMTJdICAgID0gMTY0LAotICAgIFtBU1BFRURfREVWX1RJTUVSMV0gICAgPSAx
NiwKIH07CiAKIC8qIFNTUElOVCAxNjQgKi8KZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0
Mjd4MC10c3AuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYwppbmRleCA2ODY4M2ExNWQ4
Li5lMzlkMWRjMTcxIDEwMDY0NAotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMKKysr
IGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXRzcC5jCkBAIC00NCwxMiArNDQsMTMgQEAgc3RhdGlj
IGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI3eDB0c3BfbWVtbWFwW10gPSB7CiB9OwogCiBz
dGF0aWMgY29uc3QgaW50IGFzcGVlZF9zb2NfYXN0Mjd4MHRzcF9pcnFtYXBbXSA9IHsKKyAgICBb
QVNQRUVEX0RFVl9VQVJUNF0gICAgID0gOCwKICAgICBbQVNQRUVEX0RFVl9TQ1VdICAgICAgID0g
MTIsCisgICAgW0FTUEVFRF9ERVZfVElNRVIxXSAgICA9IDE2LAogICAgIFtBU1BFRURfREVWX1VB
UlQwXSAgICAgPSAxNjQsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDFdICAgICA9IDE2NCwKICAgICBb
QVNQRUVEX0RFVl9VQVJUMl0gICAgID0gMTY0LAogICAgIFtBU1BFRURfREVWX1VBUlQzXSAgICAg
PSAxNjQsCi0gICAgW0FTUEVFRF9ERVZfVUFSVDRdICAgICA9IDgsCiAgICAgW0FTUEVFRF9ERVZf
VUFSVDVdICAgICA9IDE2NCwKICAgICBbQVNQRUVEX0RFVl9VQVJUNl0gICAgID0gMTY0LAogICAg
IFtBU1BFRURfREVWX1VBUlQ3XSAgICAgPSAxNjQsCkBAIC01OCw3ICs1OSw2IEBAIHN0YXRpYyBj
b25zdCBpbnQgYXNwZWVkX3NvY19hc3QyN3gwdHNwX2lycW1hcFtdID0gewogICAgIFtBU1BFRURf
REVWX1VBUlQxMF0gICAgPSAxNjQsCiAgICAgW0FTUEVFRF9ERVZfVUFSVDExXSAgICA9IDE2NCwK
ICAgICBbQVNQRUVEX0RFVl9VQVJUMTJdICAgID0gMTY0LAotICAgIFtBU1BFRURfREVWX1RJTUVS
MV0gICAgPSAxNiwKIH07CiAKIC8qIFRTUElOVCAxNjQgKi8KLS0gCjIuNDMuMAo=

