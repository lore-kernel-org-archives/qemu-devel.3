Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5503CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PIJ-0004vN-Rl; Mon, 29 Sep 2025 21:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PI3-0004nx-V8; Mon, 29 Sep 2025 21:36:29 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PHv-0003gY-LC; Mon, 29 Sep 2025 21:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LokEi/6CpQwixiepy+RxtsuVCtQ+QfuRvPoLG+qTYbfRiZUg/wlgrPz0C8GeZzr2sdh1ExrU9KpD6aUHv2tYcKuIv2swW3qB43wz7ozIpuOuDv3kJAcx0C+UMXYC+dF8crKzKaxdMSZGDU+SDiy/787wfnGi5jsnFgWGcCqVncPvP6nBiyUevrrVTLhFJXtCl/OKMM+xkh1CPASgT05oRaLvz2BJI8xDWmwLd3su6ZktOBoObEjuCWQItsbLdJmxY2Tch/zB8+aFltTJmB0jQey5ZFqY49zOrrDtmtJl3+ZAj1Fd8WfDSnlQgtKOaLqbh76ALoNl06PwInJpEAQeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN/nkJvOGhH2PbPgfyLGtbdF+yBy9/AvWoCJQWdeyiQ=;
 b=B2j8MLJLFzEgsVrQSzXL7o3ZirIB9jMNpo1kzPi61flcNBXfmcDY5EjbB/i/t/HLcOKxmqmd4vAIm1LvAHLyUOUsI5dQ+/XUjJt7LY/tB1VeIC/3yB+WpmMtiEXu9lhbYAiP0i8mw6Pdv2XjlX1/ybXMktwtXhWUI7442gKgVYaNK4cqlDmRATIn4wL10M3J31GcuaCTQ9YpbCFvPr1VlRhjqW20ao8BsG1WxjztdutcjnQ0a8Fq7Xbn816NhPxexFKEhMgDWRjJq1tIuCgyHvxJP3QLhuMpQ1XrHujBPgocZ5zh9pa5SMFKTvyPownvPOu2dNEugWiZEl26Yk4ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN/nkJvOGhH2PbPgfyLGtbdF+yBy9/AvWoCJQWdeyiQ=;
 b=vloKMS3dpbjqf8WyA/qTrlaQ/Za8hDU31HU+cPVzNe9mgIPid1WRRE8W+2XEWU2t3/Jj7FdUCfQI0Vrl2qOFJ9+SXxiNqFasHN7aN7SLSlbfZqxnvVuopFfnejNcA1B+J3HZglVciAq4VP8dtWnhQh3FzEt5ICNjVkfVqmxp0PXaZ7j63VYqtnPD6bawJhMECddSapwHgW+K1aV2IhtMRnEkagqIx2BuhBTzsud3WDQ4ZDhPsno35bmfl++YCED2fhgeUxFdWILfJXU0+k4CpuG7nTqT6rJYO4WaLUS8e4X6WBCA5eoK9G8vcG9y/IlFQNtgzgZUmmfaPRyDGibHdQ==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:36:09 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:36:09 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Titus Rwantare <titusr@google.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 5/7] hw/pci-host: enable MSI on npcm PCIe root complex
Thread-Topic: [PATCH 5/7] hw/pci-host: enable MSI on npcm PCIe root complex
Thread-Index: AQHcIda0P339osjEB065jRUMJvtk37SrEW4Q
Date: Tue, 30 Sep 2025 01:36:09 +0000
Message-ID: <TYPPR03MB9497C9184E4EE95B5CC7DB32DB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-5-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-5-d85883b2688d@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: 0e979d68-a615-4f5e-4623-08ddffc1bb9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eHhwdlRuYWtyN1JidEkxRXhuU1Y0NE95cFN5Nk1sR21CQi95TlVOeTZ1NEFW?=
 =?utf-8?B?eVJGZ0N0OFExbmNWdmRlZHBBdk1DeW5MUHJldHpGWUM3QkpvcmJzM3NhMkEr?=
 =?utf-8?B?UklDT3NZd1RQWW5ES3NFRnRVbW5TdTlWcHVOakkzNU9GQW85K3ZOUWErUEhH?=
 =?utf-8?B?Wms2TEhZdU8yY1JMWXdLbTJlanJ1SmU2dkVnL1FDVlBTdTF2UWM1YXBjK1dO?=
 =?utf-8?B?WGdvaHV6VjhrU1hHY3dta1lqcGdHZzR0SEpVWkM4RVZGaGl5UHYxU2ZDSUxo?=
 =?utf-8?B?ZEgvN2tyYk5nQmZSOU5QRXFzWVI0MlVQVktwNjF1S3Fvbm1sU0plUTg3dUk1?=
 =?utf-8?B?UTU1QlQvcGpqeVhRcGZPZkpjWEZpZW9LMHdUQmJISWZUWFFXc25XNmNHbnhF?=
 =?utf-8?B?NDZTc0orNE8xakg3cytVTk5mamlmQXNDUVFFa3ZMWEZ4THFnWjg2YXFocTdl?=
 =?utf-8?B?ZDI5UTg4NEZQQ3Nqa1V2Yk4yZVUxNnpNbVZaL2JXdENSQ0o2V3NaN01Lb2Fw?=
 =?utf-8?B?L1prNGVydCthdnVsOURMckJQaGNjeU1udktvVGxqQ3RWa01YaTVFRkZueE5m?=
 =?utf-8?B?V3ExYVc3eHdZSTdlVG1wUVFBR3lrU0M4S0pqSWJJU2Z2aWN6RGhSb0llRkkr?=
 =?utf-8?B?RlkwTDlIWFBneGdzZXNaK1ExUStXL0NXbVdjRERrK3h0TlFZQzVIVmpWbjlp?=
 =?utf-8?B?aE9nYkJpcHVWdUtPZXRQV3BLNFJ1dUZHbG5HcENndGpqVVNuWk9JYXNNNHhh?=
 =?utf-8?B?aTV5cnVtQ3kwamw4UDNIY2g1dXRxUTY4d3hldHIwR1lHa05NM1MybnYvVHhk?=
 =?utf-8?B?RzVNWlJ5V1Y0bHRXM2VlUEh5WHhJenI5WmxlWTJuNVlqeGk5Uko2KzVTaGVk?=
 =?utf-8?B?cUt2ZVVBMUxmOE42SlNwT3FDTkN1dG1GVTU2eVIzcDZUQnBKQXluSEMvRjhJ?=
 =?utf-8?B?N1NxTzNSbEdCUVBlZ3YrMERoeGpseW91MGpIY0FGUExxR2NlekJWV09BTW1E?=
 =?utf-8?B?V2NLQTRvc2t4akcyMkQxd05hZVY0L1ZGeGNlMXQwZmdIUjUxUmpIUzZhMEh1?=
 =?utf-8?B?SnVjbElNR2lMeGlJQnIya2FSbTBsZ3lIYVlqUit6MHAvRURZbGR3QlU0K0ZD?=
 =?utf-8?B?a3NIWE9sbWtoV2p5TTArbG1hcmx2T1ZRd0VjLzk2LzVnN3JRRllIQlRQOVF1?=
 =?utf-8?B?MU5FclMyQklPT0hUYlk4UDQ1S05LYUtRT1pucUVCa1NFQnpVckl3WnYrMXVh?=
 =?utf-8?B?SXhDYVFQQzRDWkk4U1pUYms1RjB6SDhmYXByZit0bmRQU0dZQmxCbThvQng2?=
 =?utf-8?B?QVJmaW9DMlhkUEZPMzdtbnlmOVlJcFN6RFJCOEdVSGZXQ25hZnJnbVJiS1ZX?=
 =?utf-8?B?bm9UeFo4dFg2QTZSb1JkdUE4Wk1OdGFCUWh0YkNJelZqZVM0QWtlUERMRUVo?=
 =?utf-8?B?Y3BkeDcwZ2huRmVyUkJCVUh4aDIydmdMd05hRS9RdDZyVXFLNWhhTUV2WFFn?=
 =?utf-8?B?ZzJWNDdBYlE1eTNkWFhTQVZYRUpsYUVLVGFzUW1jczIxMFU0aEFZYVhwRk9S?=
 =?utf-8?B?dXFSL2h1VzlYbjhNbkE1ZC9haEx6enI2KzJWcFVHM040SnJrY0V3c01DVWRi?=
 =?utf-8?B?blJPeHczcXNuUU03a0Q5SmdZL3kxaHVRQ2h6cDhPeDkrblBLMVhLbUxkN1Jn?=
 =?utf-8?B?dCtWMXJ3cFBiWWo3TUd1WUswTXBJcDFVbGlkOGZnSVNEVGNuL2cvQlBCdGYr?=
 =?utf-8?B?YzYwUi9HZVVvSnVIY0plakE1b1B3U0J1VHFWZ0dZYi9UT0kyRnFlZ2Rkcklw?=
 =?utf-8?B?RnF3czk5c2l1YnFTV2dnSHd6dHJKRDJQTERXalVJaHlMTmZuYityUWd3MUdE?=
 =?utf-8?B?SEE4UUNJSnhMeUVQa01XWTRnTTkzVlZoS0JCUG5qeGM1TEpUTkV5TUExcFUx?=
 =?utf-8?B?S3BwZXJyTXl0V0ZJZENTdkgxMTNXbXVmWFRlM1FPNEZWMTVzWU05R2h4Yk5v?=
 =?utf-8?B?WG1uSlAwYTlCZkdDcmp5K2JrNHc4dzhVMzl4WnFaZ1Z2dEV2UkwyUVZRODN2?=
 =?utf-8?Q?9Ot7Vq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhkM2NTcU5PK0lQMksvL0VmQkl5amQrc0E2S1pCbE9sMmlienFKQ1dlSHRJ?=
 =?utf-8?B?VFBPVWJpL0NtdW9WZnpsNm4reXI0UFZ4SHl4dXdndVJNK2RKeXNTY2dkeUlZ?=
 =?utf-8?B?VUxLVWZCUkJXZTNSN3NicE9KUXh2YUg4RWdIN3pDbGgweXFNZE9KRk1wckht?=
 =?utf-8?B?NU1wOGZsTGJaV1orWkZhTTZnMFZVSCs4QURkOXVEK0NRSnl5UTlyYitrenVE?=
 =?utf-8?B?VGpFQmJnbFcrWjJ5VldocjFBZlVpMWZqTUF5c1JMemxHSFp2dmxzZElKRVdY?=
 =?utf-8?B?WjF2U2JidzN1aGQrRmJVaXZ0WkZJbjRjWXhScHQ5VzdxcVdDZWsyc0NsZGFZ?=
 =?utf-8?B?Uk1LTlNFYzJpcGlIeDUzNTZLVmZZZlBvRFJWVU9vWWtydmRXWEZQZExqREtK?=
 =?utf-8?B?cjQrcFBYVDgybmMyQ1BBZklFWndURndLdGpaY293MDloVFkwMFRtSEV3KzJD?=
 =?utf-8?B?Wk5XajZNVzhWZ2lrRHJ2NGJjcCsxWWtsZUNlN3V2MnlTZE9OOTllaDlPc2pE?=
 =?utf-8?B?dTczUno2anEyTlRWeUM4MHVxRjFwTDhUeGFTYWJyYU1hSGVnSFlhOXZqTDh2?=
 =?utf-8?B?S09JTUZwVm96NUxacE9BQ0JubGlkMnpMMHlpd2ZiNlZmQ29Xb2hlRzdFNFRv?=
 =?utf-8?B?RTFhMzlKaHk4cnZHOG1hTFcrSWJtYWsyMDFOSXFjcGNQaHVLaThZbHd4dmdY?=
 =?utf-8?B?cnpUR1oxNSsrNDY0R1lFMHJ2VTE0eUdha2x3Z1I0QUtDbFFRanJzUEdSVzZN?=
 =?utf-8?B?YVBDU2FaYldLTHE5ZERQWTJETXZkTjlJRjl0QmtnR0VBZHBISkpRM0dETkZk?=
 =?utf-8?B?OTNBMFliZldlNFVMTzlFTGw1MDgrSEc1SndmZmRpaXVISHBnZ0RRN3JwVW5D?=
 =?utf-8?B?cDJ6N3ROdmszSkFYWWFNZ1BkTC9mUmRmU1NaVXZIYVpPemJmZ3NuUkFYMW9y?=
 =?utf-8?B?QVZZcGl6cGhjNC9xV3dNenk0OGFIdVhqODJjRmZqdTcwYnh2Y0JhRkREeHJv?=
 =?utf-8?B?elo2SGxrQnRIZ29wdFVYNmszVmMwdVRVZG5pTkNBZEVZS1Y1TnFkSXRCVHFl?=
 =?utf-8?B?VDl5NGVsdVhKVDhuSHloY1J2YUprU2E2QkVBanV2cGhVVG44UXVGcjBsbFZa?=
 =?utf-8?B?S2tPdGVMalZvWVJGbGZZNkhUWmd4R1VuU3RFenR4QzdJNzBIODJQZzI3UmJU?=
 =?utf-8?B?ZFJrUGNYTGRXRGdYT0owNTF3d2J1di84VkpFVEJJQzhCUSttSkRxejRnekFQ?=
 =?utf-8?B?dUIxM2RpdlNrN2hkT2NrUWFTQnV6aU5MVXgrcnRNUlE1Q3JYS3dkYTZIbmlX?=
 =?utf-8?B?ZldGWmNDdEM0cHFZa0ZiZE1qdjcrdzlBTnkvVFBvd2d4WUJWL1owandtbnU0?=
 =?utf-8?B?NzQyU215LzR4dUZvdk5yRWNKU2hBY0E1TnNNdlZLVVp6T09vRXYwWjQrKzBr?=
 =?utf-8?B?Sm5ZSENiTzc0aXZFWHcxdWJaZnd6TGZEQTF4SU15N1duZnFvMExQTzk4YVgv?=
 =?utf-8?B?OFh0ejB3VW5acjVyU003eUZCWVExMy9MRjhzVnBwaUgrcmF3Y2pvRGZ4ckdM?=
 =?utf-8?B?cUxZMkNkaHg3ODduY0VDU3FvUzVuUXVmbmxTVmN2RW8rOWVxTWQ3UVBsOWRR?=
 =?utf-8?B?UDZKdlZjSUw0WVMzK2FkcHNxVEpJRjhvczlTN1RjZzEvQ0gybWN3K1dHenRw?=
 =?utf-8?B?M3JpZVAzNVJNcnlSTTRNb25GRnBlODdydDNjMGM0bTdvZ2lrZGVRN3hoWDFa?=
 =?utf-8?B?N3hua0JEQ2t4V3lJM0ZRTWFuSEpUREk0K215RlpkQjNNTU8xRHJaOXBzbU16?=
 =?utf-8?B?UVpmZmUwRlVzaWdtejhaZ3YvUFJZYjNiMDh3bi9BM3FWNFJBWjNBRnkwajE1?=
 =?utf-8?B?VDMxNjdJTm1rVEFGQnpDTnY3cS9KTTk4RFp1dGZ4QS80bThUK1VxOG51VVJK?=
 =?utf-8?B?eW93OUxTWFpDaysyNmxmMWhpbDQ2Mmo4dmZBYktXQVVOakRhNEJKUW5FTHB0?=
 =?utf-8?B?UWc4MFd4VzFZaGMvNzBsTVhERlpXYzNlQjBidGVrRjQrbE0za0hpSDRzbWdN?=
 =?utf-8?B?bkpYazA0cmpsWjFxMjVML1FSaWt0Q1RXKytoVDM4QzJVamEwbnRNOWZFOTNi?=
 =?utf-8?Q?wYM2OB2Q4MgsonmKb/zCVbLlj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e979d68-a615-4f5e-4623-08ddffc1bb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:36:09.7603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEl6tgta3dufKRWFoYItTeMVr7m/JaYQRjiao2YP/FsMJPcXDasR9I2WgXds+7ZgMBi82CgGVHE3q+VHSP1Tbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=KFTING@nuvoton.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTAsIDIwMjUgNjoxMSBBTQ0KVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBDUzIwIEtGVGluZyA8S0ZUSU5H
QG51dm90b24uY29tPjsgSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUuY29tPjsgcWVtdS1hcm1Abm9u
Z251Lm9yZzsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgWXViaW4g
Wm91IDx5dWJpbnpAZ29vZ2xlLmNvbT47IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNv
bT4NClN1YmplY3Q6IFtQQVRDSCA1LzddIGh3L3BjaS1ob3N0OiBlbmFibGUgTVNJIG9uIG5wY20g
UENJZSByb290IGNvbXBsZXgNCg0KQ0FVVElPTiAtIEV4dGVybmFsIEVtYWlsOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGFja25vd2xlZGdlIHRoZSBz
ZW5kZXIgYW5kIGNvbnRlbnQuDQoNCg0KRnJvbTogVGl0dXMgUndhbnRhcmUgPHRpdHVzckBnb29n
bGUuY29tPg0KDQpUaGlzIGFsbG93cyBNU0kgY2FwYWJsZSBxZW11IGRldmljZXMgdG8gYXR0YWNo
IHRvIHRoZSByb290IGNvbXBsZXgNCg0KU2lnbmVkLW9mZi1ieTogVGl0dXMgUndhbnRhcmUgPHRp
dHVzckBnb29nbGUuY29tPg0KLS0tDQogaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuYyAgICAgICAg
IHwgNSArKysrKw0KIGluY2x1ZGUvaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuaCB8IDIgKysNCiAy
IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpLWhv
c3QvbnBjbV9wY2llcmMuYyBiL2h3L3BjaS1ob3N0L25wY21fcGNpZXJjLmMgaW5kZXggYTE3Njcz
MzVmZTc5YTMwNDY0YWNmMzJhZTk0ZmMxNGU0MTdjODllYi4uMGFmNzZkMTA2N2E3OGJkYmIxNjlh
ZjNlM2Q1YzRhMjUxNGNkMGZmNSAxMDA2NDQNCi0tLSBhL2h3L3BjaS1ob3N0L25wY21fcGNpZXJj
LmMNCisrKyBiL2h3L3BjaS1ob3N0L25wY21fcGNpZXJjLmMNCkBAIC0xMCw2ICsxMCw3IEBADQog
I2luY2x1ZGUgImh3L2lycS5oIg0KICNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCINCiAj
aW5jbHVkZSAiaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuaCINCisjaW5jbHVkZSAiaHcvcGNpL21z
aS5oIg0KICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQogI2luY2x1ZGUgInFlbXUvbG9nLmgiDQog
I2luY2x1ZGUgInFlbXUvdW5pdHMuaCINCkBAIC00NDIsNiArNDQzLDEwIEBAIHN0YXRpYyB2b2lk
IG5wY21fcGNpZXJjX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KICAg
ICBhZGRyZXNzX3NwYWNlX2luaXQoJnMtPnBjaWVfc3BhY2UsICZzLT5wY2llX3Jvb3QsICJwY2ll
LWFkZHJlc3Mtc3BhY2UiKTsNCiAgICAgcGNpX3JlYWxpemVfYW5kX3VucmVmKHJvb3QsIHBjaS0+
YnVzLCAmZXJyb3JfZmF0YWwpOw0KICAgICBwY2lfc2V0dXBfaW9tbXUocGNpLT5idXMsICZucGNt
X3BjaWVyY19pb21tdV9vcHMsIHMpOw0KKw0KKyAgICBtc2lfbm9uYnJva2VuID0gdHJ1ZTsNCisg
ICAgbXNpX2luaXQocm9vdCwgTlBDTV9QQ0lFUkNfTVNJX09GRlNFVCwgTlBDTV9QQ0lFUkNfTVNJ
X05SLA0KKyAgICAgICAgICAgICB0cnVlLCB0cnVlLCBlcnJwKTsNCiB9DQoNCiBzdGF0aWMgdm9p
ZCBucGNtX3BjaWVfcm9vdF9wb3J0X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKipl
cnJwKSBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2ktaG9zdC9ucGNtX3BjaWVyYy5oIGIvaW5j
bHVkZS9ody9wY2ktaG9zdC9ucGNtX3BjaWVyYy5oDQppbmRleCBhNDdlYWUwMDg0Yjg4YmE0Mzg4
NjgxYjI0YWI5N2Y3N2E0MzM4NTk0Li43ZDE4MTc3NTEwZjYwZDQ5ZjdmYWU3OTA4ZGQxZTNiZmJl
OWFlMTJiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2ktaG9zdC9ucGNtX3BjaWVyYy5oDQor
KysgYi9pbmNsdWRlL2h3L3BjaS1ob3N0L25wY21fcGNpZXJjLmgNCkBAIC04Nyw2ICs4Nyw4IEBA
DQogI2RlZmluZSBOUENNX1BDSUVSQ19OVU1fUEFfV0lORE9XUyAgICAgICAgICAyDQogI2RlZmlu
ZSBOUENNX1BDSUVSQ19OVU1fQVBfV0lORE9XUyAgICAgICAgICA1DQoNCisjZGVmaW5lIE5QQ01f
UENJRVJDX01TSV9OUiAgICAgICAgICAgICAgICAgIDMyDQorI2RlZmluZSBOUENNX1BDSUVSQ19N
U0lfT0ZGU0VUICAgICAgICAgICAgICAweDUwDQogLyogUENJZSBleHRlbmRlZCBjb25maWcgc3Bh
Y2Ugb2Zmc2V0cyAqLw0KICNkZWZpbmUgTlBDTV9QQ0lFX0hFQURFUl9PRkZTRVQgICAgICAgICAg
ICAgMHg4MA0KICNkZWZpbmUgTlBDTV9QQ0lFX0FFUl9PRkZTRVQgICAgICAgICAgICAgICAgMHgx
MDANCg0KLS0NCjIuNTEuMC4zODQuZzRjMDJhMzdiMjktZ29vZw0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiBUaGUg
cHJpdmlsZWdlZCBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1h
aWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBvbmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFzIGluZGljYXRl
ZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVyIG9mIHRoaXMgZW1haWwuIElmIHlvdSBhcmUgbm90IHRo
ZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGluIHRoaXMgZW1haWwgb3IgYXJlIG5vdCByZXNwb25zaWJs
ZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVtYWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBsZWFzZSBraW5k
bHkgcmVwbHkgdG8gdGhlIHNlbmRlciBpbmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQgZGVsZXRlIGFs
bCBjb3BpZXMgb2YgaXQgZnJvbSB5b3VyIGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNlcnZlciBpbW1l
ZGlhdGVseS4gWW91ciBjb29wZXJhdGlvbiBpcyBoaWdobHkgYXBwcmVjaWF0ZWQuIEl0IGlzIGFk
dmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIHVzZSBvZiBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gb2YgTnV2b3RvbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVkOyBhbmQgYW55IGluZm9ybWF0aW9u
IGluIHRoaXMgZW1haWwgaXJyZWxldmFudCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2YgTnV2
b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMgbmVpdGhlciBnaXZlbiBub3IgZW5kb3JzZWQgYnkgTnV2
b3Rvbi4NCg==

