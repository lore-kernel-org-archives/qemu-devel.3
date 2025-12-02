Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E440CD116FE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQN1x-00076c-QW; Tue, 02 Dec 2025 04:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQN1w-00076P-6W
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:50:44 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQN1u-0000tj-ON
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:50:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeCG2WwGU4QnQtnppkB7fmn5p/g4mB2qFcbWOBbRfMrrpZ36D0/gUsdAyM5TvUTiR/Vbm9OG3gzCEJKXcNP6DdE41LUA4Ehz/tDUzpXdECsBJ2u58udXBYA17qah5diPxG7MLZeVXfjXzAA8XCxJ4iOkt1oFzaVFdTxJpLVj5cJCZYHhrzYwi9OONSEFcSpE9sHaPQwrMFqUBuPISHobTsczignvC+kuNvVs/ZoMMy5tWUuIBTuaZo92UMuqxpjzeThw0lPz0zkpl6Ydbz7s3c3qdjLhgWS/G1STYPXjvpDNzii73WSg8Ug3KI1EqtkfOREFq7tUwB5/TyVPKJTeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vparr8Q4sBbNNZF5wikFX2KPx0D3JNatw+4rF5l8MME=;
 b=ELp4favuNmSX8OoOZLVyK3J4oKUJClbw3X6zW0GFPmhWhE0kfY4WGLwvXilyKsUvf6ft8l/Uov2bwKg/ecp59iryMB0YGUMiIQUJ4zMgqZTw3XQ+RmiqKjqFFBy5bxJvhImxhdQs3xRsWR7+MLz0G2BgolC/Eh+QYawDew7DZcx1injbilytJP7+2Ss5hUgsh0fVDwDLj5TQ9N4UZRDVBLU3a6The6wBt+xi0Yvyks28/sAebgTmTB5JQSnSJ6AsVs+PbT2veNEnAYMcSPVv6i0gUQN4R86fByOuC4W+TE6TQZXoNX0PffrACWG9BxIxgLihyaGfzP3C6gQhX6s5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vparr8Q4sBbNNZF5wikFX2KPx0D3JNatw+4rF5l8MME=;
 b=VaNbWQri2YFPea6NteGJqTCxKB3ylDw+66NK0/RmcIPIM5Or+iRVnod1nl+7pJDX2DngJdCYqb2Bo/1FGv7b5lxY3bCdga2hgB8BQBOgmbJzsfVruh8YIz8DYfSxn0CsyRhfT8qs9oE7rFAgfRQo+HIscOweMlbCmocgmUi3pmc9iTDN8XF4u3vmfcqK5HaBwKDhayjStTL5jQxzFmECLqdu6R8iuLPjr2R4KE1TprzWp30fgI5fkRRqJ2cwfk8OwnNb4KzAb0+sMVJoyZYrSwfI2T1Rk2WBmbJtdlzmlj+7Gb3RIOI6dIejFPTS10IRz94/YtG2CW4wrfhmcMY17Q==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 09:50:39 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:50:39 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented
 CCM(Clock Control Module) and Analog IP
Thread-Topic: [EXT] Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented
 CCM(Clock Control Module) and Analog IP
Thread-Index: AQHcWVR9T1b/BkRBy0eoF9vYyCuEa7UNVhcAgACZsrCAAD7cgIAAAGaA
Date: Tue, 2 Dec 2025 09:50:39 +0000
Message-ID: <AM9PR04MB8487AE782C4A49811949B5A687D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-3-gaurav.sharma_7@nxp.com>
 <CAFEAcA8WHgKtPPVQKNSRV2R5xVPCZ3vNxQgy9rcVu=ECrxNE2Q@mail.gmail.com>
 <AM9PR04MB84879F8FB1F3E1AE26F784F887D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA8OwigUfpS8E_hAND1aD+oNh48nongWLM7cRfU8ZP+9jA@mail.gmail.com>
In-Reply-To: <CAFEAcA8OwigUfpS8E_hAND1aD+oNh48nongWLM7cRfU8ZP+9jA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AS5PR04MB9856:EE_
x-ms-office365-filtering-correlation-id: 2ca33832-7f97-4fa1-a258-08de31884044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QkpXZFJxVFJqKzZoek83L2g1b0JsSVYvT2xQNkIvVDFjeG1MeGVFTWp5cnNB?=
 =?utf-8?B?VFNiWmFaZFhiUkpVbUR1c2Zmb3pySExMYTB0QlNhaHNVVHMzblBxeVQ5VzZ5?=
 =?utf-8?B?SXJDZkxkdTZrUHJFMXl2VUlMMlIxc3BMcEVIVTRHK2FoTnlWL3ZhdXhDRUta?=
 =?utf-8?B?WG9GS0NwaklUa2VNTlNsamp2N3d3ZWhHd2xzcDRBTUVSdmlodGRWMGc1Qzg0?=
 =?utf-8?B?NS9JODFHaTdlMjVQQmFCTmIyWlRMYXpYU1VtZUJRTXVudnlFUHpCMFZyQlFX?=
 =?utf-8?B?ZFFHcGZnOVBmQThaaHpkNUxKMjhuZXIrMFVyclJ3cFh6T09XbkNHcmI2VS8v?=
 =?utf-8?B?bVA4SHhsZHhRcC9Way8zZ1hVNngveGh5VDM3Qkt6b2pXdVQvcnVhZm4xTDBQ?=
 =?utf-8?B?eW9SeUhhNWNUMzdhOXN2eHpuN1NvSGhyVncrL2sxQnpiVHQveFdNTWVacFE3?=
 =?utf-8?B?UzREMFFUWFlXU2pxTkM3WDQzTGorMmU4U2ZLeHJkU0pvSjZSMGphWjgxL0or?=
 =?utf-8?B?d3BCeFhFNUxHd1Z5VkNHVWozcVNLbHdGdVJUTUVZQ2RsQmFiRkVKUmN2Yncr?=
 =?utf-8?B?a1RjRCtxM0dwT0JzUy9la0ZldnFOMlg0a3dveHBXazlmeVlMQ0g1YjVNaDFk?=
 =?utf-8?B?N2NzSmkzVHF6L2MxOGNrV3JKVTFyNmNDTjhncWJ0Ni9iay9aa29vcVVseWh5?=
 =?utf-8?B?eVg4RFFlS1VzUlZ6RjNNVzhrVXRLcmlZL3RMdElqZXA2NndYQnVVS2kxN2ZJ?=
 =?utf-8?B?WkdEakZlUnE3ZVMxM3ZJVWNjbko2TjlJbWF2Qmc2dU9oQjl3UmJzVHVkUjBm?=
 =?utf-8?B?RmsrcVNFUFVTSk12MnEvc0tDQW9Rako5eHBoNWIyMmtmUDZJMkRXNXNSYk52?=
 =?utf-8?B?K0FLSzVBZUg2S0FDRTdMcWpNaVBXVk9qdDFKbkErNFFIUGlZTlpDVjF1eHMr?=
 =?utf-8?B?WFMvcGMvOEV5bDNISmxldFlxZDZlajlQUXRNR2ZIQzVVMnNIK0RPTHk0SFd4?=
 =?utf-8?B?L0JmM0kxcFMwREIwcXh3UGZwdWlXM2R0YURwUkVFQWdQRUZpWmtRdG9xZzZh?=
 =?utf-8?B?SHJBY2k1SkE2VGRDdk1mMnBLc2RqOGF6djM4UjlRV2ZKY1AxTlVvbWs0TnZ0?=
 =?utf-8?B?UGNTZnpiamZNZXAxMm5hUVBYazVoWFphTU5wbWMxTk0yVkZxQ2pBZStUQlZu?=
 =?utf-8?B?WWR3L2p0QldIeTdUODl6d1lLOW9sTEF3QnE3MTFZWnFPQlptaGNkV1BzRDRF?=
 =?utf-8?B?T1ptZG9tZkJ4UzZjMVBqQ05LSXJzd2hhdFlDWmhDYVRtem1mTUNQY0lERGFY?=
 =?utf-8?B?TnltTXRRQVNwdlgxRGg5U2F1QUE1OEQ2ZHZaWXFyMGMxT3h2S2R1eVhCTmty?=
 =?utf-8?B?MzlNUmtFblY4NjN6bVE3bGFWb21vNXQ2MXlWWXI5MU1tOFVkR1BRVlpuK3RZ?=
 =?utf-8?B?NlplbkdzMWV2RUlQZzhtWGQ1c1lmVG5OcW5ObTBVS0FPc3BDQTE3M1k2S3NE?=
 =?utf-8?B?d1dkaXRsb1EyMmhOQzJIQ2w2VU1UZnhvM0UvU0NCMm5FWHZLTENsQXBqQjBx?=
 =?utf-8?B?K0ozYmxGK1ZkMVRYandqcVhrSm5CNVlrOWdmTGMxQ3ZTS3ZhUGU4L0cwRzRF?=
 =?utf-8?B?YURRN1JFeTVVN21LMHk2TVBpaWVGc3JqS3pQVEFtVmwyMW1qRHVFMWlaSXkw?=
 =?utf-8?B?RXYvVDYvK1Uvcmh0S05MMFhxQ2xuSGVIbHRGa1N4c3Z2VFJrWkhTVW1kT04y?=
 =?utf-8?B?anZpQUp1SVBKazRmMStLaGpBWmI5T3JTRTZwVm51R3pXMkpXQjFIY2JGaTBn?=
 =?utf-8?B?MTkvYURBbFg4aVRlaW8vSlY1SWJLaGphTm1ZaDhCbDBlbS9HNTJvK1NKa2Fl?=
 =?utf-8?B?MzUraG93QmdPQ1pDaUpsMDVyL3BHS1gwL2RzRXZWelVNNGcvcXltTUF2clMx?=
 =?utf-8?B?R1FjR21RdlRpRHBpTGR3eXNOZkVIQ0dvcGZXZlBqbnlaTk53Kyt0YngxMEZK?=
 =?utf-8?B?WlM3bGVrYWhZdTN0WUxMK1lCdDRiRmdRb01BdmRaNGVXRDFLeXowb2xQVDRS?=
 =?utf-8?Q?UsFKYs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3QvNVU0TTY4VXE0ekR1dzFRa1Q5cjg4b2poYkE0cGZJaHBmSFVzMEFKbWtx?=
 =?utf-8?B?d3pzMkFaeXdWTjVMS0VCTEMyMkFHb2xJY2xRSzFUYkNoZFIyZzBmKzY2N0V2?=
 =?utf-8?B?Rkx4THVwQWJPNkNXUmVhWlJrOFZjMXdKTkpSSnZvM3ZzZVlyTTJOZGlBNklK?=
 =?utf-8?B?YTU4M3hFZnBTVHFYREh3TmxTNm1NUjVMak9MVStjNDZiNWp5emUzb3BOZzRZ?=
 =?utf-8?B?bFEzUENaNlZYQXZZSHFLMkg1bm9vS003bnNFckVrM040dmI5NDBmMTlOdXA3?=
 =?utf-8?B?Z1VZcWFpSTk0ckhKalAwcWxrNVVhazYrUm5Od3NqT3EyKzNJcmxCWTI5ZUxM?=
 =?utf-8?B?ZmRtSFliV0dMVitRL0FoVjIrQWk2N1JJWW52ZTBjczFKYUhGZGxaaXNnMENV?=
 =?utf-8?B?bS9GRmovUUZSaDVjTloxWUYzUys4YlpVYnBBdGNTUkJUVldnUlV1eStlUDhV?=
 =?utf-8?B?MHNVaURTTmVIU3ROQlVlQnRtMWNaQWd1WWNRT3VnM1R6Ulp1NjRtWTYwSkNT?=
 =?utf-8?B?RTlJMzY3aStucHA5OUxoM1dDdGpoZmpSUzQyRS94bXcrN09VcjhNQTZNK0JE?=
 =?utf-8?B?bjExanBiSEtrNUh6N0Fkek8wZlVVK08vbVBIRGZUWlpIUlI2dzlTQ2FaV3Vj?=
 =?utf-8?B?MXptS2U2MTFCdTE4NlpXdThHazAwSG91UVlOUjVqUGtFY3RZeFZRUitnK3dX?=
 =?utf-8?B?TkZKSXNqZmlGeTh4TkZEYjBxeDJUVlNMbzhNZ0VWdnhWOVJ1SC9vZFBjL3pv?=
 =?utf-8?B?L2NHNVpCV3RtVVhDYmdjRjZtdWk4enYwbzhhQlVjc2oxQ0w3QzFWdXhETU4w?=
 =?utf-8?B?U09pUG1mV3ZVRVJBWkQ1T0xZUHRXQm9ncHVpSXp5TWpKeGQvbm9TVUxGZy9m?=
 =?utf-8?B?Z3hNcS83RVVxZkIwd2QvYlhWRDl5UGoxNUpkS05rUlVrRmFENzdvRjlNYU4w?=
 =?utf-8?B?eHNRL3UranNPWXgyZ3Irb0gvVWhsaXZPWkp6TnEybGZ3cDhjdlc2UTBwelIr?=
 =?utf-8?B?T3pkZGlMd2pRYnc3bk9BOUo4M2VGVUUwem1CdzZnazBIQkY3RFA0anFoRTlJ?=
 =?utf-8?B?UzgvY3dWZU5KR3pkM28yWGUvL2c2enNKMHI4Ykova2tQTFh3RG9wWGFIbkpO?=
 =?utf-8?B?OFpVWFh5QVZyZGV2Yjg0V2xFSkt5a3k5M2hxcTkwdi9RWHQ4bVpEcWY4bXM0?=
 =?utf-8?B?dUJBd3JtRkcvdjBYYmplaHF2NDRjSDlRYU1lL0xCelBwLzdFVTkwNHZseTJ1?=
 =?utf-8?B?ejdMYS8yNEtRTUJnWXUyeVNrY2I0RGNFNmtyNFliLzJGcWNHMTdQbzZrMzRq?=
 =?utf-8?B?aFd1OGt4SzZxeWZFY2pQL3dWSXhQbGF5NncwSWFkNDJBdjhnVURSQWJyZnpE?=
 =?utf-8?B?QzBrWTdTcnZUelBPcGpmckx1eVVQWWVOV3BoMjV2UGZUa01EcFlTNzNmaTZq?=
 =?utf-8?B?NlpvNE1JQmtoczZMUjFIZ0JCNDRqOTlqNmZmOU5mK0Y3VXZWNnNMclZibmI0?=
 =?utf-8?B?YUJUWTFJRHY0allNbjk2TmNrYWd2RnFuVmhmUGhzUGtIM3hiUmJMbngvWS85?=
 =?utf-8?B?WHFhdERwbmpTOVRESE5qSWdsQ1FGbEs4VHlsenZMdUVGdUgvNlhlS2s2Zlhl?=
 =?utf-8?B?RmRvUFpGYVJxMzVlSy9uaUwrbXorSjNRMWNlSEhyM3NJMnFIRjNlTlB3RDhL?=
 =?utf-8?B?R3hrRXlVWWFIenF5SUgvOXdDOXpYMER2MXU1SzJ6M1hCUmJTQlR6WW0xT2Rv?=
 =?utf-8?B?bmhqL0dHRlJwdGhjaFhOYVRiNTd5SldLVVVyMkcyVDFKcTNHalRRaUl1bUhi?=
 =?utf-8?B?bVhHdSt0TXhvRnJUR2RRRVE0SlRvVUlqb0dMcHR4aDcrdXE5c0RYajFKTWlR?=
 =?utf-8?B?WFQ0YndJVEhJbEcwa2tpaFJzOTBQa0FsYkJXSTd5ZVhnR0dEcDhSemRhVmM1?=
 =?utf-8?B?Z2RsUzIvVnBhZGNtajZvNDgxY3lSNHpPNU5YTVBnUGlwbHdsZEJBcXNIajcz?=
 =?utf-8?B?Sm03S3JNb3lEa1k2NGY3NjE4UlJnb0hDU01xK3dUNzhRdXkveE9YKzBYNUk1?=
 =?utf-8?B?MVphMDBlZkdNcTV5SDF4djVLYlBrZ1VUOHMxZ01CMDFkM1J3d2h1bjBMVFN2?=
 =?utf-8?Q?bkSLIdcjUChPP2Gp2k9clsgyv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca33832-7f97-4fa1-a258-08de31884044
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 09:50:39.5882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBPy4zZ69PEtX0948VCQ+ljrGZISi0DIhbeHKBCEsUvpMqH/XYxpQrNtGIkQ09tux/IHOInmkiD2l+PlwPAYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856
Received-SPF: permerror client-ip=2a01:111:f403:c200::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAwMiBEZWNlbWJlciAyMDI1IDE1OjE3
DQo+IFRvOiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gQ2M6IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTog
W0VYVF0gUmU6IFtQQVRDSHYzIDAyLzEzXSBody9hcm0vZnNsLWlteDhtbTogSW1wbGVtZW50ZWQN
Cj4gQ0NNKENsb2NrIENvbnRyb2wgTW9kdWxlKSBhbmQgQW5hbG9nIElQDQo+IA0KPiBDYXV0aW9u
OiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tp
bmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0
IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiAN
Cj4gDQo+IE9uIFR1ZSwgMiBEZWMgMjAyNSBhdCAwOTozMiwgR2F1cmF2IFNoYXJtYSA8Z2F1cmF2
LnNoYXJtYV83QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+IEFwb2xvZ2llcy4gSSBzaG91bGQgaGF2
ZSBleGVjdXRlZCBteSBlYXJsaWVyIHBsYW4gdG8gbWF4aW1pc2UgY29kZQ0KPiA+IHJlLXVzZS4g
TWVtb3J5IG1hcCBvZiBBbmFsb2cgYW5kIHRoZSByZXNldCB2YWx1ZXMgb2YgdGhlIHJlZ2lzdGVy
cyBhcmUNCj4gPiBhbG1vc3QgaWRlbnRpY2FsLiB3ZSBzaG91bGQgcmUtdXNlIHRoZSA4bXAgY29k
ZS4gSSB3aWxsIGNyZWF0ZSBhbm90aGVyIHBhdGNoDQo+IHJldmlzaW9uIHRoYXQgMS4gd2lsbCBo
YXZlIGNvZGUtcmV1c2Ugb2YgaW14OG1wIENDTSBhbmQgQW5hbG9nIDIuIHdpbGwgYWRkIGENCj4g
dWludDMyIHByb3BlcnR5ICdhcm1fcGxsX2ZkaXZfY3RsMF9yZXNldCcgaW4gaW14OG1wIGFuYWxv
ZyBzdGF0ZSBzdHJ1Y3QuDQo+IGlteDhtcCBhbmFsb2cgY2xhc3MgaW5pdCB3aWxsIGJlIHNldHRp
bmcgaXQgdG8gaXRzIGRlZmF1bHQgcmVzZXQtdmFsdWUuICBpbiBmc2wtDQo+IGlteDhtbSB3ZSB3
aWxsIGJlIG92ZXJyaWRpbmcgdGhpcyBkZWZhdWx0IHZhbHVlIHdpdGggOG1tJ3MgcmVzZXQgdmFs
dWUuDQo+ID4gMy4gVXBkYXRlIHRoZSA4bW0gZG9jdW1lbnRhdGlvbiBtZW50aW9uaW5nIHRoZSBj
Y20gYW5kIGFuYWxvZyByZS11c2UNCj4gDQo+IFlvdSBkb24ndCBuZWVkIHRvIG1lbnRpb24gdGhp
cyBpbiB0aGUgdXNlci1mYWNpbmcgZG9jdW1lbnRhdGlvbjsgaXQncyBqdXN0IGFuDQo+IGltcGxl
bWVudGF0aW9uIGRldGFpbC4gT3RoZXJ3aXNlIHRoaXMgc291bmRzIE9LLg0KDQpPa2F5Lg0KDQo+
ID4gT25lIHF1ZXN0aW9uIHJlZ2FyZGluZyB0aGUgcGF0Y2ggc3BsaXR0aW5nIHlvdSBwcm9wb3Nl
ZCBlYXJsaWVyLSBOb3cNCj4gPiB0aGF0IHdlIGFyZSByZS11c2luZyBjY20gYW5kIGFuYWxvZyBv
ZiA4bXAsIHdpbGwgaXQgYmUgbGlrZSAzIHBhdGNoZXMNCj4gPiA/IDotDQo+ID4gMSBwYXRjaCB0
aGF0IGFkZHMgQ0NNIGRldmljZSB0byA4bW0gaW4gS2NvbmZpZw0KPiA+IDEgcGF0Y2ggdGhhdCBh
ZGRzIEFuYWxvZyBkZXZpY2UgdG8gOG1tIGluIEtjb25maWcNCj4gPiAxIHBhdGNoIHRoYXQgYWRk
cyB0aGUgcHJvcGVydHkgJ2FybV9wbGxfZmRpdl9jdGwwX3Jlc2V0JyBpbiA4bXAgYW5hbG9nDQo+
ID4gc291cmNlDQo+IA0KPiBZb3UgY2FuIHN0cnVjdHVyZSBpdCBsaWtlIHRoaXM6DQo+ICBwYXRj
aCAxOiBhZGQgdGhlIG5ldyBwcm9wZXJ0eSB0byB0aGUgYW5hbG9nIGRldmljZSAgcGF0Y2ggMjog
YWRkIHRoZSBhbmFsb2cNCj4gZGV2aWNlIHRvIHRoZSA4bW0gYm9hcmQgKHNldHRpbmcNCj4gICAg
ICAgICAgIHRoZSBwcm9wZXJ0eSkNCj4gIHBhdGNoIDM6IGFkZCB0aGUgQ0NNIGRldmljZSB0byB0
aGUgOG1tIGJvYXJkDQo+IA0KDQpVbmRlcnN0b29kDQo=

