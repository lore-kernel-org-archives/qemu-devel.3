Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F42C282D1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 01:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpHEz-00048Y-Gh; Mon, 03 Mar 2025 20:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpHEr-000470-NY; Mon, 03 Mar 2025 20:38:30 -0500
Received: from mail-tyzapc01on20725.outbound.protection.outlook.com
 ([2a01:111:f403:2011::725]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpHEl-0000JC-Vw; Mon, 03 Mar 2025 20:38:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKYQQPGAGVsqRmTs4TmwdAGcVml/snO2hCVhoCWC64kJE8K0wc9mLvxOnIsu3M56ubPI6BnhGmli97rxIDu6mCjH/179o0skhgp9jkAvjsqpSJexpUcKv61VoHO6abYSgqawdL13ELIt66mNkbuCPA+TPECs41hI+ZYU0uX3tfrigLpe3887qcs6KMhXK1Tc9xtp8D7rGKsVyllWZxed84KQDiOfnw9SZTL1EqqeoE079l4rw9DNVxH2uLd9gd98Xugs5VsdyfBkJiREKiAw63ZY/8/xj0J9y9Wf7dLvcYhrcw+9KWo8j6dl8xlIvaWJo8uhwElNRXrc0lVKzq0a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPFDNjLtUu4zbrbgY3aXEVv14rpq+x51Kio2YGB8fy8=;
 b=X7eTtFSaqS7upXhhPy9fraCAs/eWaa8z+FwI2xS2yR5XkXBMFwxdYufyUrAxcC14i9X2yun+Uu2vq2BJgFLKagNnjqQTAU8kkaf1SKGO3JYPEPRw92MN8rA2JYXn22e1Gw+3iI7qH+RLbgmqnqb0+ig11LTMvKYjkk3ZkB3cIG55nFgHITpBbemst6NXuM3ZtzUbfOw6I0eIgoanNz7VCle4/v/56JtYmwIW7ML7TQdKyPHUxQw/w4nx3Ixfe4eG1AuMrEIoxE+47/OOWrNtlq8QuRpKfPYx81pKStZNKsS1M18K0DSZUZlGIqKcGlb9zMMGqS7JXjKFIF90lIs2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFDNjLtUu4zbrbgY3aXEVv14rpq+x51Kio2YGB8fy8=;
 b=oIxBvGOrPXfGk9cPdsdTjZxzcHtdR4v8cfJPxPlNTLSm4LeuaK8ajV5D7IDZxk8oxU2S/CkaoWz5MLNljd7nEFDNF8q0ODvh84uTIuvC9cV9XBCSaRezb6jhbTzXMhW6OUXt8TD87Ed0JJItELwYGz5bChdqByVghbLevf42lIb9amUsR33ODEs2RS4A6uWeLeDKxKNVYoONhfQDmvxmXrzrKQEaQlOh3azK3fP1FHFqYxeMGIuB7Rca5VLQCgra03umoq6u24HpDHpTihlEH9TNb8D7yieWxWuqrvN84HJTF27pamyD+99NAzf3qCy0k2/Xn1zImuKeFaYVbE6q4w==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6111.apcprd06.prod.outlook.com (2603:1096:820:d9::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 01:38:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:38:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 5/6] hw/arm/aspeed_ast27x0.c Separate HW Strap
 Registers for SCU and SCUIO
Thread-Topic: [PATCH v4 5/6] hw/arm/aspeed_ast27x0.c Separate HW Strap
 Registers for SCU and SCUIO
Thread-Index: AQHbjA7n4UoZSbdRxk60jg/6rETxebNhaKiAgADLK/A=
Date: Tue, 4 Mar 2025 01:38:12 +0000
Message-ID: <SI2PR06MB504111589A2DCA1411BE9E26FCC82@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250303073547.1145080-1-jamin_lin@aspeedtech.com>
 <20250303073547.1145080-6-jamin_lin@aspeedtech.com>
 <2c8e99bc-bf5d-4447-84e7-8d4d5fea0add@kaod.org>
In-Reply-To: <2c8e99bc-bf5d-4447-84e7-8d4d5fea0add@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6111:EE_
x-ms-office365-filtering-correlation-id: 38ff0160-f29f-4f8b-88e3-08dd5abd3a03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEYxL2VKb2pyZmhUQjVCNXVmcE9DUTVhRG1WRXJnUXQxR0RnQWdnekFZVTR6?=
 =?utf-8?B?c1lPaXVJVSsvWldOc0FqcU5IUXFFZzZ0T3c2MVo1b1c4SVVPRXZ0ME5VN2xL?=
 =?utf-8?B?Q2NGcTVVZUwxZFA1bnBpWktMM1R2a0xqQW5DK2FWWXovRHo4MkJZZGc3L0Jw?=
 =?utf-8?B?N0pkMjVlWFJOcXdPMjhYdklwaGNKN1ZXeFBOTzltbWFTSExYU3htRCt6am50?=
 =?utf-8?B?Y3RudDQxTlFBM2xxc2VaaFZVMVF2V2lWcVNqRk1JZ2xRKzQ0bXVnYmt2bUNw?=
 =?utf-8?B?SVFBd2pWRnBKKzNsY1dwbUVrTTc5dUdpOG9aUDNiS2RMc1BuNVViY2ZZMG54?=
 =?utf-8?B?Z3dOY3RDdDBhZXhtaFBqRjVFajdsUkxUWDJVUXI1ZXJ2bnpibTRGQ0s2MlBS?=
 =?utf-8?B?NEE3MWtpYWQxZXBCZldKSWxCa0JIZXE4NGpWWXdtTFJaaTZ4ZE0xYUxzRVlO?=
 =?utf-8?B?QmFVVDl1RFZkOElTV3JmdjdxVmZXQ2JTb0VMR0ZROUtEZ1VUanJTTllvY2g5?=
 =?utf-8?B?NzhncDhMTmJXY0UvM1M5MTRVOUpjNVcvcFBNT3dWODJjS0I4OUh0aWlzK3Rx?=
 =?utf-8?B?clNXU0hYSTJmRmR5UFNTZlQ4blFQbTFuaEg2bitBNklrRjB6cjhJOGp1VVZE?=
 =?utf-8?B?aGoyVUQ1TjJhK25kV2hTamdLSXFDcXdCTlZQMHRjZXcybFE0eUs1M2ZIV1V6?=
 =?utf-8?B?SGdZemJmUkx4V01TZG9PQ2pjVXRGV1BYa2IxdUJKL3U4QmJ3akYvTWQ1cXpl?=
 =?utf-8?B?ZWlWS1VNMklqT0RSa1E0S1NNcmxvS2JlVkMxRzhyem03c3hPdk9uSGh4K3Jo?=
 =?utf-8?B?bURia29JemhobFNPN1pBdmRWejQzZENJaTBsaU1TeHBBeE1QR1R6V21UNFpk?=
 =?utf-8?B?RXdIbnBTWXdpMnJtSVBpWlNoaFB0TjVEUTdrcWR3Z0M3cXpCTUZmMGpMeUdO?=
 =?utf-8?B?bk0yRVczV0ljTm9YcHI3YXZTbjNGa3pPWU8vdUdKZC9mcmlzSXpkblFBQjJq?=
 =?utf-8?B?ZWVlOENSdmp6VENCZVJBaEx6Ky9Tdit2VDYvM3lqdnNCbDBMUXY5SGJWR0xN?=
 =?utf-8?B?WEpqOVFFNTl6QllvR0Q5UGpjRm1QeGVISnNLYjNqM2E3RTVXL3I4UzZMeUZR?=
 =?utf-8?B?VEhiZ0FadjFXRUhrbndDMmFiM202T3RGWnYvdHFOV0t2bmt6a0tOd2dYdmFV?=
 =?utf-8?B?NHFDTHcrZEg3SVJrWTVLYU9QekhIZW80QmZPdS9Qc3hoQi9lQlg3RGhoYkto?=
 =?utf-8?B?YkxzdHBEWjhhTWVpQnpxVEQyaGI5bzJGVFVQQWNEbDBIRXFycGgrOXdpalBL?=
 =?utf-8?B?NHVHaXQwSHI3KytySVNQMWxvYmswV2VpdXhxZ09sMTJ2dG5LSWZNR2U2U1dZ?=
 =?utf-8?B?UW1ObUtYdVJiblVlSG81WVVWY2FwQnhmMS9sV2pxNGNQUFVDd3hCUlVZUWhy?=
 =?utf-8?B?R0c5d0F2Z1hvMVhSWTQ5KzcxM3lzellBOVFTUTNCRzlZcXdINy94bER6TDRy?=
 =?utf-8?B?TlJ2Zlczc05rSVBJNEhPeStuMmJ1TFdIaHpZa3ZnRXNheVU5djRDSFR1bXFF?=
 =?utf-8?B?NnJnQ296S2J0TGxtVVRZTDdjdjMwNkd0TXppZTVZemVVLy8xUmltZkJvZktU?=
 =?utf-8?B?L3lHZEt3ckg4enVPUU5QcDloS0UweXIrUDFiVU1ZUXhEMFFVNk9IWE5BTnlQ?=
 =?utf-8?B?bFB5eDBZSXFmQ3NlYU1tVDhSUE9XN1FLVjdCU1F4SUY3NzhFemEyRUE5bGc0?=
 =?utf-8?B?d3VkaFlUVDlYRjZrVmh3YU9HT2FCV2F3dnlTU3Y5ZnREVXdoMzUvaStzOGsy?=
 =?utf-8?B?d3pTWTBZZklIdlo0ZFZPeG1uNFBFdlpSclovdGtIdGZQV1duTEtSMXZ4MnVF?=
 =?utf-8?B?eGVJekhPRG84bFpPR094VXc2M29OYnBHTVBYZ2lyUXlhcTF5elZTZWRzSmQ5?=
 =?utf-8?Q?lS+N7Wc9xP2lyHn5PjK61FUPM6X+ZvdT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWlDZ1BFRklzN1F1MVV4ZVZJckRqYUkyMVpPM2t5VE1ONkpwbHJYWEtkVjB4?=
 =?utf-8?B?T3VIbjBGWWxYWVJNKzVPMDM5WFhnVlZqajN5enY0eGVjb242UXd1bHBzbllT?=
 =?utf-8?B?eUNwWWNJYjFza3pNK3hhRGdZeHdCbUtTSnIvcGdqcXhQZG5YVFhKczVHc09I?=
 =?utf-8?B?b1JXd1dCSkw5bVZWTWJPdXN6cHJqUVQ3a1Z6eDlGQm44QUNCZHc3N2hzaEJI?=
 =?utf-8?B?a2ZCdUQ5VlpaTDZmb3BsOWt6Q1QyQ1pSSlVGSWpILzEvMUFUNmJSckUrRk5S?=
 =?utf-8?B?YW14Tmc3NkJXLyszcU02VDk0NWdzZ3pGSUZVQ3RCUGNPMitTWkE1U2tkdjN1?=
 =?utf-8?B?TUlhYk9nN2hPWFR4YWI2RzY0OVgvWmFhMVB5V3hhSVdZMjRRUnUzcmpZWU5R?=
 =?utf-8?B?Ykp0OGNSOTdKZlJmUW85dzN0VTFhVGdrWE9EeHVuaW1BVEVrRFhnWVJZRUwv?=
 =?utf-8?B?Rlgwai9NZEhaU0s4Z1pxb3pnaVd5cUptZUx4V1ZjL0xlMlluZE5QZXo3aUdj?=
 =?utf-8?B?Q1NVWHZTV0x3cUhUT2hXYmxXODl6SzkyZGpBNlhNcm45aWxPNHVTNUVTQjlN?=
 =?utf-8?B?dTkzSDM1KzRWekhvcjB1LytKdWRkeWJUTGFmRTM0NXlOQjBqcHRNdXhzQzZW?=
 =?utf-8?B?c3lXUVh5STdKU3JROW53Ti81UUtnMDZxQStYWnZvSHhwbTRzaVNGd3hsdUVQ?=
 =?utf-8?B?eFZmMnVQTVAwUWRVYXQvdmwvWlF4SUtNNEJVb1hhSUR6TDNLa1h4QWRSU2lE?=
 =?utf-8?B?OGtsV3FMMDA4MWJTd2NTcVM0VDZ2YTg4SDZYZ3NZMXNKeUptbFpUUU5pSFlk?=
 =?utf-8?B?MklSL1RBYkF2Wkx6WUdZSHlOczIzdFViNEpBVXRTc2Nuc0IvWmNDYjdBK0N4?=
 =?utf-8?B?YllMZEwvdncwcnMzU1ZZOUI5SE1MTk5KWXZzWHJ1Zks2NHNDYkZYd2NDbVZs?=
 =?utf-8?B?UW02bDA1OWZSOFdqMGJ4d1dkM2p0TjYrUngxdCtPVXFEZGRZNCtmcnFFVW1C?=
 =?utf-8?B?V0NjWkl3N1g5cmV2NE1QbVFzUFJtcHBFZTR4VDE4UW5qUmR0WEdTTit0bkxm?=
 =?utf-8?B?U2dnL0pMNDg0b2dsY011L3ZMb0toR1grNVJzYjZJbEFBd1FpR0ZSV3dJcU53?=
 =?utf-8?B?T2w4c1dzRy9oVFZHWDdZemZSRGwzc2kxc2ZReUg0SlBrRnVNU2RzdC9scWpD?=
 =?utf-8?B?U245dlByRGg5a3BvZURESVg4bUZHV1pHTXhGeVFqc2RUWE02a3gveGdkdU1n?=
 =?utf-8?B?ZzJkTHR6QVJXRW04ZzVmV0U1UTlzQTZOOG9LOE9HeVg4ckNOV3dNcXBjTUpF?=
 =?utf-8?B?Q3l3SXBtM3J4VUdnUjkrS3hCbEpRSnl1cFRGWkdmV0dHbkVlRExkcnlacXRX?=
 =?utf-8?B?KzcrT3kvZ09GTzBNaUM4WG1aeXRRd2NoTjBvMExadDZIejE1RVAwbEM1Q1cz?=
 =?utf-8?B?TlJ3THB0U2FTY0RuRXIybVFVZzJzUjlUdVJuRGxaNHBZOG9Ud2NhcG84SUpo?=
 =?utf-8?B?WG9BK3FIckRsK2x6T21kTFN6YURiai9Jd0cyK3hSN290d1NjUjJtNVQ5VnFW?=
 =?utf-8?B?VHp3YjJnOHhPRG9wMHZ4SW0xRkZaZ2loWnlzNzVuZlZEWjM1bXZyRHZtbmJT?=
 =?utf-8?B?ZnJpZFlWT1d0RDNoY3BRRGRXNHNiMmtHbkc3RnJXbHppSW1VbFVHZFJ6azg2?=
 =?utf-8?B?ZncwL2RTWlhqM3ZHTU5valBsMnA3TG9sMXhUa1BnWVJGemFCcUFlOGV2SHhj?=
 =?utf-8?B?bXFKNTh6SmxVbkY2aVZuaENxTnhGSVRENTZGREJIZjcwb1E5ZWlmL2s3ZUlh?=
 =?utf-8?B?SDAzdUxESVhzdGtKdkFldjVCNmJNOGpBejMreXlEeGd2K3cyandzbGY2d1Fa?=
 =?utf-8?B?QkZvMmlidkZHUEwrOFgvbTBOa3Q2ZUZyUjhDOHNOSG5kNFlLdzZXMHlqQlVR?=
 =?utf-8?B?S2tRYnRPMElZRDRlV0dVNTNlMFZqMEFxSEF1NkVDcDRGU3F6MDg5R1NqTXMx?=
 =?utf-8?B?WHJtRmRKQzJGVzIzVFJLcE0yUlVWNndNeDBkUFp6VUdWMFNlSUtYbTVDOUFm?=
 =?utf-8?B?Y2kraG5wemlHUVVqOEIwOVZwUE9va0xBMEh3UGFjWnNpMDBpY0FnQ3ZyRG1U?=
 =?utf-8?Q?8B41qpFzKQ0ucuA9Es1UsqEWg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ff0160-f29f-4f8b-88e3-08dd5abd3a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 01:38:12.4947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlu1PaWBnXJIXga0m43fVlB8+ikGMHyFmsaVf+c6ddrDf12bnPldXva5SUcSMX4w+5XtUsq+n3O6ZxlskdI9n78tz+C2Mu0Qw6ub5KYb/ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6111
Received-SPF: pass client-ip=2a01:111:f403:2011::725;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS82XSBody9hcm0vYXNwZWVk
X2FzdDI3eDAuYyBTZXBhcmF0ZSBIVyBTdHJhcA0KPiBSZWdpc3RlcnMgZm9yIFNDVSBhbmQgU0NV
SU8NCj4gDQo+IE9uIDMvMy8yNSAwODozNSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZXJlIGlz
IG9uZSBody1zdHJhcDEgcmVnaXN0ZXIgaW4gdGhlIFNDVSAoQ1BVIERJRSkgYW5kIGFub3RoZXIN
Cj4gPiBody1zdHJhcDEgcmVnaXN0ZXIgaW4gdGhlIFNDVUlPIChJTyBESUUpLiBUaGUgdmFsdWVz
IG9mIHRoZXNlIHR3bw0KPiA+IHJlZ2lzdGVycyBzaG91bGQgbm90IGJlIHRoZSBzYW1lLiBUbyBy
ZXVzZSB0aGUgY3VycmVudCBkZXNpZ24gb2YNCj4gPiBody1zdHJhcCwgaHctc3RyYXAxIGlzIGFz
c2lnbmVkIHRvIHRoZSBTQ1UgYW5kIHNldHMgdGhlIHZhbHVlIGluIHRoZQ0KPiA+IFNDVSBody1z
dHJhcDEgcmVnaXN0ZXIsIHdoaWxlIGh3LXN0cmFwMiBpcyBhc3NpZ25lZCB0byB0aGUgU0NVSU8g
YW5kIHNldHMgdGhlDQo+IHZhbHVlIGluIHRoZSBTQ1VJTyBody1zdHJhcDEgcmVnaXN0ZXIuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIHwgMTEgKysrKysrKysr
LS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgYi9ody9hcm0v
YXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiA+IGE0OGY0N2I3NGUuLjhjMjI1ZDRmOTAgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9ody9hcm0vYXNw
ZWVkX2FzdDI3eDAuYw0KPiA+IEBAIC0zMzEsMTYgKzMzMSwyMyBAQCBzdGF0aWMgdm9pZCBhc3Bl
ZWRfc29jX2FzdDI3MDBfaW5pdChPYmplY3QgKm9iaikNCj4gPiAgICAgICBvYmplY3RfaW5pdGlh
bGl6ZV9jaGlsZChvYmosICJzY3UiLCAmcy0+c2N1LCBUWVBFX0FTUEVFRF8yNzAwX1NDVSk7DQo+
ID4gICAgICAgcWRldl9wcm9wX3NldF91aW50MzIoREVWSUNFKCZzLT5zY3UpLCAic2lsaWNvbi1y
ZXYiLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNjLT5zaWxpY29uX3Jldik7DQo+
ID4gKyAgICAvKg0KPiA+ICsgICAgICogVGhlcmUgaXMgb25lIGh3LXN0cmFwMSByZWdpc3RlciBp
biB0aGUgU0NVIChDUFUgRElFKSBhbmQgYW5vdGhlcg0KPiA+ICsgICAgICogaHctc3RyYXAxIHJl
Z2lzdGVyIGluIHRoZSBTQ1VJTyAoSU8gRElFKS4gVG8gcmV1c2UgdGhlIGN1cnJlbnQNCj4gZGVz
aWduDQo+ID4gKyAgICAgKiBvZiBody1zdHJhcCwgaHctc3RyYXAxIGlzIGFzc2lnbmVkIHRvIHRo
ZSBTQ1UgYW5kIHNldHMgdGhlIHZhbHVlIGluDQo+IHRoZQ0KPiA+ICsgICAgICogU0NVIGh3LXN0
cmFwMSByZWdpc3Rlciwgd2hpbGUgaHctc3RyYXAyIGlzIGFzc2lnbmVkIHRvIHRoZSBTQ1VJTw0K
PiBhbmQNCj4gPiArICAgICAqIHNldHMgdGhlIHZhbHVlIGluIHRoZSBTQ1VJTyBody1zdHJhcDEg
cmVnaXN0ZXIuDQo+ID4gKyAgICAgKi8NCj4gDQo+IHBsZWFzZSBtb3ZlIHRoZSAgY29tbWVudCBi
ZWZvcmUNCj4gDQo+ICAgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9hbGlhcyhvYmosICJody1zdHJh
cDIiLCBPQkpFQ1QoJnMtPnNjdWlvKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJody1zdHJhcDEiKTsNCj4gDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiBhbmQgcmV2aWV3
Lg0KV2lsbCB1cGRhdGUgaXQuDQpKYW1pbg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+
IA0KPiA+ICAgICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfYWxpYXMob2JqLCAiaHctc3RyYXAxIiwg
T0JKRUNUKCZzLT5zY3UpLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImh3
LXN0cmFwMSIpOw0KPiA+IC0gICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9hbGlhcyhvYmosICJody1z
dHJhcDIiLCBPQkpFQ1QoJnMtPnNjdSksDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJody1zdHJhcDIiKTsNCj4gPiAgICAgICBvYmplY3RfcHJvcGVydHlfYWRkX2FsaWFzKG9i
aiwgImh3LXByb3Qta2V5IiwgT0JKRUNUKCZzLT5zY3UpLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgImh3LXByb3Qta2V5Iik7DQo+ID4NCj4gPiAgICAgICBvYmplY3RfaW5p
dGlhbGl6ZV9jaGlsZChvYmosICJzY3VpbyIsICZzLT5zY3VpbywNCj4gVFlQRV9BU1BFRURfMjcw
MF9TQ1VJTyk7DQo+ID4gICAgICAgcWRldl9wcm9wX3NldF91aW50MzIoREVWSUNFKCZzLT5zY3Vp
byksICJzaWxpY29uLXJldiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc2MtPnNp
bGljb25fcmV2KTsNCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfYWxpYXMob2JqLCAiaHct
c3RyYXAyIiwgT0JKRUNUKCZzLT5zY3VpbyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiaHctc3RyYXAxIik7DQo+ID4NCj4gPiAgICAgICBzbnByaW50Zih0eXBlbmFt
ZSwgc2l6ZW9mKHR5cGVuYW1lKSwgImFzcGVlZC5mbWMtJXMiLCBzb2NuYW1lKTsNCj4gPiAgICAg
ICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJmbWMiLCAmcy0+Zm1jLCB0eXBlbmFtZSk7
DQoNCg==

