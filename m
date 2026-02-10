Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F76EA3F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1X-0003HD-O0; Tue, 10 Feb 2026 00:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1O-0003Al-GW; Tue, 10 Feb 2026 00:10:47 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1M-0000Go-AB; Tue, 10 Feb 2026 00:10:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1nLGtoz2MVkjpLsSoenKg55uQHP0wg56hxUoFRP2Uu4OtLccarRalCOhJ9PNQU8dI7PhZLwxW3/j6sdbaZGVuQ26qy43TIwPwCm9MyQ9UwY7KyU9ZJ2kG3c7z3kf98srus4JL5UmaXF2tv6SpcuaMv9ft8gFO1EOTlJlzSHcgm2WGnIHF2SEpOClEUQw6jIFoBye8afTEp0w7x/XWu/b6N1yqkOR0JE6SioIY0Fr0ph2Aa8JmDImDZzkQd/I5BoZ2gengAmN4rjb0AayH6AArf8MVomQO2a9xxxCtkh1L2ty+o5PTdT5fhMQd2kbTTbifoRmiR8AXm7C36SLH8oBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJbyX6BuqYmpoeHYPp4TkojPH1B3IDTqJCHL9IBW1O4=;
 b=DSsZwASaD5gAJ7awK4T/jAgMa7QPzfva3GCG76yI//QUKe0zqSHNIro6wvn9zpKT6WSv2ZPp5SwyDqPiuZ7jpsy5bXhoq+vcmNN3xXZCiL7BtTqRu3xaB6wFLKos9B7MOdGS1Ry/Sr2ohF3pEVt8a8eWFysRDAApem/F1Dx3U3Uu3pFYCcPUsTLGWciyX2hdQ1RP36DBm0XgU0LUlD0P5Kl+SrbfrL7ha4Nl88yhaZHdtQT6+5Af7SOw/ELa6+N8P6oYY5hU0fVQSTPwQFiE92X2jQ6UJ6wleQRa6d+aL9dG8aZ+kK+m4tRYCt6bDQ/owQPmmNPZ4xEeXk4YwO/PVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJbyX6BuqYmpoeHYPp4TkojPH1B3IDTqJCHL9IBW1O4=;
 b=iA/qSBvhPR1nYTHahjyWEYjekQchW9V6tpSTGSfWfY59W1zF09HXfzEpkhGTArLiz8DJn/k630LufKf+mad6GJzqDdoTlphRvJww7DyMfhMtycnuGRbLwvaZzKmU2fAduL9ipsvZwvrqgZZzItZhiLDLHTsNAIx2e0Yc5DXMrksgGUWeboxGx2gqQ0xgcETA12wYPQps9fxLD/l1RXrvX3TKjCTfy6h4Oy9EkCc6col6o0B364Vs11/Zx3BP5JkaWiU4EtyQE0fi1fZaLv289ogzN0Ueg6dQJFOdC3LEJy23BCMc/yG0ljO4mVVfbGYZubLW+kGSS74GjkmtZeo4Ww==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 10/11] hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM size to
 2GB for AST2700 A2
Thread-Topic: [PATCH v2 10/11] hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM
 size to 2GB for AST2700 A2
Thread-Index: AQHcmkuOQyhgp39aHE6sOxJmm6Me3Q==
Date: Tue, 10 Feb 2026 05:10:21 +0000
Message-ID: <20260210051008.355149-11-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF9851F8D71:EE_
x-ms-office365-filtering-correlation-id: 739196d7-3bf0-4383-8871-08de6862b15b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PT0wHUGB74YEMJWT4rG0P/9JTKAmAtuDVXqLBB57ZWIU8YQ/DNyIC9SXit?=
 =?iso-8859-1?Q?8WlDYXTaCf6o1e5JmQHmGPZW/lK8rvTevOHq+I2uFCmpMMP+R/RqbM3s2o?=
 =?iso-8859-1?Q?ohs4Ttha3TsgRxQtIw6Ax7UeBrItvuR6bD3KzgMfs0/ZpnUArnkQs1VPQv?=
 =?iso-8859-1?Q?b3esdr4k7pPGVw+ZWiM51WxmjW6o2hFomAD+qLGqW+K2eGQyCA/YZdvW0c?=
 =?iso-8859-1?Q?crCtE92S8R/Cr5sQU2N12VG1Wr/uCReoPyOO6/o7FVqZPSK5L6LAeICHVl?=
 =?iso-8859-1?Q?8R/f9yVU3e1fAM41k/gOLvnpZBFGa8AEmbrbFD08khAElPjQfnSRLOrt17?=
 =?iso-8859-1?Q?6iUi7MeR2qdvWx473WUsKCuPqX5gP5A/YXO6wuK8sL3HbEpdNpL3kF87ib?=
 =?iso-8859-1?Q?uM+tr9YFvM2K7eAkP+KqSemHXL2oMxcQaJ6tm7Pk7Z35PdgETqLLOhudfF?=
 =?iso-8859-1?Q?wIHZUOj1IJAC2YZotInqXYczBEsfDvF2SF2oiyNMwTqpBIz409fdJ9Wpln?=
 =?iso-8859-1?Q?4cmpqOcxpB0WnFifzZ7FyzmAkvTmC18Tu85MQvyyp1zm/AiLyR/UG6mXRS?=
 =?iso-8859-1?Q?ObhTi4MvaBf9y1buGS7U98xeiC61yR3hSqUZiEdD9kDTb9ib5H3EPGZzP1?=
 =?iso-8859-1?Q?ePZeasS1iNwHfUeHxKQALlJyIQD0Y/YqXpCLywM587kx2mpDy4JvKkwsbd?=
 =?iso-8859-1?Q?CmKeQ4y+93oVFjfzTZT4wh+tyzf6OSh7MLPepoFUpy8DiGWo+lvqO1virk?=
 =?iso-8859-1?Q?AZpoPauMEab3KRzTyOeEiACln2GDh/Bn6jEBVxvEEK5TueuBWc4LBhzSZV?=
 =?iso-8859-1?Q?jcPysshabYOAD2TAoxS8oSP6VHeKKygHhS1klmmUF/KrrjgOFHaidjj8UH?=
 =?iso-8859-1?Q?OZMwRwkrMCQ+NXJ9xcw769NqEW2ML4DRea/leEJ0ag6A4ccvSaOnltgSpX?=
 =?iso-8859-1?Q?cgHRfFCTPA8hshZscTw6UNer2sNa3tRYBAOyqx9DKmHazs/2r1utUVVuI/?=
 =?iso-8859-1?Q?Bl91dkUQaziOssosE0dFExsCFLVg/VJf9XgK/qgwRTSdYp9z+auVW5qg0j?=
 =?iso-8859-1?Q?lbbqa1Jd5th2Urfg9aSfovW3al0l8C437FFTdM8zHfWVaYrjv26bFrT2uH?=
 =?iso-8859-1?Q?FmsrCEkWNFoMG1Rt8yCrAAphdiNhM1JOfO9VKVljY8HJ1DSqlRkRaj270y?=
 =?iso-8859-1?Q?6K9OyoMvmXEYfTfH4dSd/6IMn9q0uV9l48AmS0JmQjsoTaKWMZ6wQN91mX?=
 =?iso-8859-1?Q?U3FLybN7QajYgy3DbuE63uVxAumy2r5IcSa8jluoLBjnlHpIEOg3Lgq4Ae?=
 =?iso-8859-1?Q?pRFDrZ6AyAiTPgDw9m1L/LQiIB3+ESczs23V+Y4vSllNRmhvi67qGwa7aX?=
 =?iso-8859-1?Q?ym+bNdUl2LN6QovMufLrHPCBqcDrxNl+HPiNy+RPoJXKlVI9SUoRnKyTCc?=
 =?iso-8859-1?Q?4xQAXUxsIIV8o1S4EeLK6CEn+cee1RQhZP1ZE1KJhvKyXOfBoSc2kUDnId?=
 =?iso-8859-1?Q?cMpouTKeTLqcEwFyLZV7mmCO9sh2Osy7DwR4M1MUDdBEwIRXX7TH4wL0qB?=
 =?iso-8859-1?Q?e3LL0fcjtERgGByFUdSlNLPyqrBTT5rRFdyeDZEZXvcb0g4zz7zf48wzon?=
 =?iso-8859-1?Q?y3ofZ1Q1lo/6big7UrQ2hKsJjpUIwgfnVbxa7Yhkk9UMonuobXihy2PH15?=
 =?iso-8859-1?Q?J9ndm8/9hOfMuaCMx63hULFLRhYVG6EStCzRj9LB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9+4R6gxGt7f1LFJ9Td/o+NTIdTD2U+ticif+tHXchlT3toSHkVibsNW2fK?=
 =?iso-8859-1?Q?4WuSIdnr24q7qaa9AJuHl7jSCXGjBsYVuqJfwBFYwecxZfuZcBxZM0CRGE?=
 =?iso-8859-1?Q?v2GeKmpPBI9Vt9MqMevIG+IPXqXMsGFdt4YlJRrCkHQnLqSjCmS6zJXPXG?=
 =?iso-8859-1?Q?tRXJQXospbGrH8CzwdIw3eEn9VomovMfmGlx6M1WKKgLIU7xGuv924lc5B?=
 =?iso-8859-1?Q?M5EalL8pJTDQT7m7BJoDZLPkTCea85O8n6LIh4ALyDkYv441Iz6WMJzUSf?=
 =?iso-8859-1?Q?mIx/uXzXJHNcSMYGuzdbk/BXdQXNVtZV444kx+AO8rNvTGXt2dBSTNJ1MX?=
 =?iso-8859-1?Q?5vfLdlyERl2x2o7a4GfGHX99YnQvP1SE6lGugHTGayyo5xXw33a3tqwPfj?=
 =?iso-8859-1?Q?ZEInqATVrCcwUyfMkvn+CaA4oaIL/UtZC96G9BGKbPqjxJZhjL8Blz6Ca3?=
 =?iso-8859-1?Q?GZd0LOdupJ0HbID8Ep4t2QKezE1rqOBRrEWgxJuqjcMTR4QqrfUmycCwNc?=
 =?iso-8859-1?Q?EauZZw6jsYLvf4Js+zQi3Ny/YAaaXHMg/n+n6V+DLA1NE2QAa3DiUgHEDK?=
 =?iso-8859-1?Q?cKHyY/wTJYN3fc8Om+nfcT4yM2xm6m8UA+49Em8oLl+DeJpA6nrP2SEnc4?=
 =?iso-8859-1?Q?Z4q4yEdcVbzzgkIoK9oVc/lne5Jna9ERnOEEWGMfaW+RzV9fb/ZyNp2Idp?=
 =?iso-8859-1?Q?HszjpI3tZvWnUnMzyJdqLZm2yGzEH8mDgPAqjQb6i2JfrfZu5irsOjcroN?=
 =?iso-8859-1?Q?pm7cCdX1P0xdXnhSmlY9V8YXlbmTXOGbZHM4sberS8LAhuuFVggpJqjOTu?=
 =?iso-8859-1?Q?wBwAPfqBsAVgBxFEMijGtuDUqj/kfKgH8NL1Kt1BMXcJyWq+4CvJo8KRH4?=
 =?iso-8859-1?Q?585Jo+urpo2NJ9HxLkjnxPrS/00bS1na801uR63s1hCGZCi47jnP+/xnYn?=
 =?iso-8859-1?Q?pPtaeSkw6EdwX2lHGAD0+2u4jmez1/zYZj7Rt+PYPTsU+VxrhQtGgYh5Qx?=
 =?iso-8859-1?Q?XQ0SeK3MmQDORVNlVfcrqdsTsHkYNE6bQosub1TSdHKvzeLhgQJo3i08W8?=
 =?iso-8859-1?Q?TdEhcD83ZlTgqBQqVxV3QmqPIl2ea95dSnbwbAPqsc5vO6+tuaOiXVBkat?=
 =?iso-8859-1?Q?kxsGxQHelLNyKF+pjLurMUes8ZDXZMUqoYfhOxFpeypL9v79osJvfe7U38?=
 =?iso-8859-1?Q?ZV1608fCQZd3PtagURQ02YAXclWN5imIx+arhp/jhzPQA1O61FBaBhS5KF?=
 =?iso-8859-1?Q?WArgZ7Mw98/trbpJ47orwpHR8qWna0rnM0r/pyiSywlupHp3wc3E541BWe?=
 =?iso-8859-1?Q?LhDQWwYPMaN6LfgE8OH6AmBhkCrfZDg8j6rCouw1RuVEhPcyP/wr9Iq4Qb?=
 =?iso-8859-1?Q?Sx+RqXKAbMkYkfWRlSs3mP1QB/Y8KeEolTOaNMsprDVw8kPtQNQ9iSj6pC?=
 =?iso-8859-1?Q?txG2fdyjXg32t/eEn2fXCeut+/LRYGqgKGaUK87JUM7cx0Pt55nH1bgBjQ?=
 =?iso-8859-1?Q?ys8OazXVQfoQN4E4R4fmP58u8CPmPqFNx0fGwaQQrIGcQrL83ZeSYs5pzA?=
 =?iso-8859-1?Q?Z/MYq3O9/DBD0F4YnCSmEfj6xXX4JFvkVI/66btqyu720wMsSeC4SecH7v?=
 =?iso-8859-1?Q?auLlIgIQKpFN9LAZuLZvSGhTjpEvmhqopRvcfAv5wh7HHbZ25tUoOtDCEE?=
 =?iso-8859-1?Q?vrTrC3m5nFVnKH60TztduA2Ha1d2IqXLghB6FVVEPdmOgBVyKu9i2F/pMo?=
 =?iso-8859-1?Q?CbifU4T41CEa2lVQaryOMTBo+oM1B2AULx76tTDcu3L5b1EU6EaiJwUeSu?=
 =?iso-8859-1?Q?BYqtfKJW4g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739196d7-3bf0-4383-8871-08de6862b15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:21.0694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yv7w0aib7wjvA9IZHwtD/SX5sx/sG/Jxqzo5h/C7HB9SkW0Gpz0uFUN7qHT5YJvWivcTaoaW92/+hvLBJe9uBTlLGP2DHHPJE5RnEK4IIAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF9851F8D71
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

The AST2700 A1 EVB is equipped with 1GB of DRAM, while the AST2700 A2=0A=
EVB increases the DRAM size to 2GB.=0A=
=0A=
The ast2700fc machine is updated to support the AST2700 A2. Increase=0A=
the BMC DRAM size to 2GB to match the hardware configuration of=0A=
AST2700 A2.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 9b9bb2df75..5eb6680da9 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -48,7 +48,7 @@ struct Ast2700FCState {=0A=
     Aspeed27x0CoprocessorState tsp;=0A=
 };=0A=
 =0A=
-#define AST2700FC_BMC_RAM_SIZE (1 * GiB)=0A=
+#define AST2700FC_BMC_RAM_SIZE (2 * GiB)=0A=
 =0A=
 #define AST2700FC_HW_STRAP1 0x000000C0=0A=
 #define AST2700FC_HW_STRAP2 0x00000003=0A=
-- =0A=
2.43.0=0A=

