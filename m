Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AE8E9410B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 07:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbZy4-0001Hm-3H; Fri, 02 Jan 2026 02:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vbZy1-0001HI-CY; Fri, 02 Jan 2026 02:53:01 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vbZxy-0000e1-A4; Fri, 02 Jan 2026 02:53:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM3Vgxnug/tSPLeS1nzroovHwT2m8EArQl1failuFrLLbkR2ZTGcghvvc5mBqVg46U4+rqSOMeUW+oNjBgGpXWXKFjG3rCGdc1LJ/fjxjRGnD6tjYpfWDDxU/ML68M0lAdngTp3lMXC8DWs+xaibazBk7wUYZxBkgWKgOoWGCYUT/MZkcm9gJr0dypVUyGVYdn2eEhgF3C7CwG0KYtIxgI9s+WOgcUwuA77NcTheA/c847/Iz491fsEin0M0KW+80YHInl3jQEI+d1ksLLat+sB4+mC0gqtjRq0QvSwO5EIXFJY99Yp12GXQcsN79MrOH2ylDsW6iNdvnoPa72vcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s65ChH8Vl4vC1Ys8YOg/FFlsB/lcRWPNZFO1XtANdg=;
 b=CTAyDM77PhiIAOTpEPdCP/acKoQ/ol3zKN8hSyLmRe+OgQoOpdsNr7Tv/vRC67o5T3TP/QUq/FUaLkRLxopP3I/zakGL6vlxrfX4+xCRLIBui34Fm5yL3PyJxOAvtd6U16zaAl9ST0Gad7ynKORhfXFtvcxSduFSFq1/TfngqkqP6G1R0KLXi530D94UxfVgKYqKBB+wbFG5YPhrJpeWOs8LbBEk7ao9jcE9UbVGvthammzGEDbDSCie/N5PTorOL90RGbrnaksbrMUni2NyW3CG9nonxh1pvgzVV/cQCo07eNTlgL8Cm1ZwO/FWgvpAQ6zrSElOyHCb4+fDhUpr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s65ChH8Vl4vC1Ys8YOg/FFlsB/lcRWPNZFO1XtANdg=;
 b=HO1KWupN+iHOob2+3ntJYE4cok7qNg1CHud3/pnNY/gEYmMD2pO38v3OZcItnwEy1tSvGFPdhWIU9+lYRgoyhB+p5A4Rqy1SdzBtm2o7sYkAO3N0tjSZvfW3N/cTo51rOc4MdnstG80rynDCmY+xGb2LYtGkyP5Zvp33d6Cy/tMw03NOisaKohdrATJiy73neCTvMANgQlI7zfvG1ftzqIWDDSL+CR76aNOddcEEkM7LtIFvtDHhOlu3v2cd/c1+RPo7IDEGFfjnrZ5JJTq06d8RjeNMNXsq0xo1xETFNpxq9VBUuIqLEndLJBx7RA5UHnimFHNlK1ze/G1pQlDYyA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6041.apcprd06.prod.outlook.com (2603:1096:820:cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 07:52:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 07:52:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, Patrick Williams
 <patrick@stwcx.xyz>, Joel Stanley <joel@jms.id.au>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: Refactor ASPEED INTC
Thread-Topic: Refactor ASPEED INTC
Thread-Index: Adx7t1aXXYHZ0YoZSLmzYzIi+9c1nQ==
Date: Fri, 2 Jan 2026 07:52:45 +0000
Message-ID: <TYPPR06MB82060AAD1D538252B336AEA8FCBBA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6041:EE_
x-ms-office365-filtering-correlation-id: 0ec32a09-2df6-4a3d-a42a-08de49d3ea65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bHZO/ebDGSNhXqbG4GeEeWQmmDPFqTQK0QZlh//uDVFQs1RKVqRaVULoZN?=
 =?iso-8859-1?Q?nGsErWB8pUI8SDauG1LPE9w+gRc/KhWt1OPOMT34vh3iAOVT9ivBIgWwS7?=
 =?iso-8859-1?Q?KJNq5hbbFsjvbRB5jhRXUCdpI7efGpFtW5XVrXevrIXmQ2zzuXwDNpLkov?=
 =?iso-8859-1?Q?01cMOZDUZTKlIWskrilTPQGcGKyIVwJdrJdkyduwcpo8iyhYgOw0Nr0Dfa?=
 =?iso-8859-1?Q?oSQvrYA0RURgjpjzZ87Vepo5Pn7+vw7Q6HR7mSRMKPucWoUmLjFslumqQD?=
 =?iso-8859-1?Q?lr6A2N72dIVjXBgQm0heIdv81kr15Asj9fsbWiBnDHGtCZUeNPtGLsjQMx?=
 =?iso-8859-1?Q?6Uhm8k3ZppAuDeVaLNL78Jx2W/Q/LJbn19FURIMCY2d2tr2NdHJkJmmZ/C?=
 =?iso-8859-1?Q?3Hf+tLCGsGrgidmS+vziJM451563oGR49sPwn5qKqBMHRSaQok6gJDaw4k?=
 =?iso-8859-1?Q?+KNpcpS6wfw2BIkhOXSTjQ+QXTcnbmxSqKP5hLcf8UMfaGXoOWxvmpral3?=
 =?iso-8859-1?Q?T2lW7y3EjlRoFin4lpbzDAeBTGkNEiKVEgtCiNUKStsRrbLsodDE+8nFBz?=
 =?iso-8859-1?Q?iDipUAfejQbolGLNYGT13XOSH9IxQYXir96lINvQyg/oRM4uOLh6DBRBoy?=
 =?iso-8859-1?Q?Qk2UlBKjj7xXXiAQx8A+BeYn0wECKWNaNWOgmn0lMMorbpZBA5He/FWzuq?=
 =?iso-8859-1?Q?YN2AbzesGM8WzMmCVfQHoGJ/hB/uvFfFfcFK7KEsOHf+rp0oluW+dM6Cn3?=
 =?iso-8859-1?Q?amVUTtXklSNwIZ+sfFs9mhxAJsVuPy6rEMoruUuhWWjIoBLvmJAzzlHyy/?=
 =?iso-8859-1?Q?QRwqJj5BVDTW5qdFJXgMUUM/rpSmmBtdU75/LXKFKU8YzAvMc39Q4jSOCw?=
 =?iso-8859-1?Q?DoL1uIJe+0u+BEfJ8OoeVXP7exIrON/L1rRxeK9a8mTMH5uucEfy11+mCf?=
 =?iso-8859-1?Q?oAlnp6yfb5UD0fcZhN7A+9IibW0zB+V8KqEHAlMF7CZBckcb53AsfDNXkS?=
 =?iso-8859-1?Q?7R3wJhH/1rVcgZRhtpVMqYWNQPMgeUYYhr0f7nuLJeMyg5NGVr2XNt6W77?=
 =?iso-8859-1?Q?N+cRTZXVl4fW3J1LtxTDV0kzdndrP+q0YdRadZh1L2T4S6y/VgJgnWeTH4?=
 =?iso-8859-1?Q?I7Ja9F8UcXg7oxTkFK5N2vaKKLjshtAWvbBHlaaPmynQ5M6mb6XSHXLs9H?=
 =?iso-8859-1?Q?mp4NlUoY5v0K02E29bhYOiD9HxepDa+tC2ahX7zMIgvpECnSl+i7TJWb68?=
 =?iso-8859-1?Q?o6iJ+B1WdGlm222ZdYw1f676g1Q/7D0cNXLUlNW5cDeep9W4LpIbpBR3PW?=
 =?iso-8859-1?Q?hYEb/vUZyiJqlaZOo3bIfAT7MeiUZzNu0FeDrhAuG4KvmNHKYThsntnjxD?=
 =?iso-8859-1?Q?JnrcqRgJvCcjDX4XUjFY4dH4uHZyINuQ5X6S8su1ScQwhLiiwMhSE+BrqG?=
 =?iso-8859-1?Q?yuQkrZ6iel9i/JVn6SQfz6s/6cvLR/kl+1N8qy4+fdkVCeT4y4K7lkguD4?=
 =?iso-8859-1?Q?fSUFYlBovtKSXP7h+H25LLoqghnwPqhqSQbWPCqBdxJdb1u1Jph7JMVTjB?=
 =?iso-8859-1?Q?PFDQYrvKX+o8hE6bORE1HDSo6ObB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XRsP2YJh2nDEVxy1IBcDwkFcdvM7BMIQRsG+N8tcqTR791z4lmPf7uNcaR?=
 =?iso-8859-1?Q?UtLPKG1qK/UDbe2S22pDSTfiHEFPonhQC9qs7P9xbloU+e/nAYRmfODx0p?=
 =?iso-8859-1?Q?hU3XJiYH5rlHJxK2xwoxkBQDICcL/+4fb7YUMpTPm3NRrkbmHClhJ9SNlP?=
 =?iso-8859-1?Q?/wCRDYB0YVYBMkUqoNiI+nK7x2ZnehhzBD0tPeuoAPdoozIWVbRRETmB2b?=
 =?iso-8859-1?Q?8Kt5WMk0o5h5D6I8QF/v6xewKNfP+L6Qe2Dfi9iGVPKmUCBxEGbVe5/dF1?=
 =?iso-8859-1?Q?ruD5YozCVrDzI91jJ7KlBsO2s1P9MXNIlYpVAmFvYNuDIHNbQ+OQukFJlR?=
 =?iso-8859-1?Q?4lEm+HP/3i+DqKGW9aGhz/vOVau7IEzZ6pq141JjqJ+WhSiTpJIyxcf2q6?=
 =?iso-8859-1?Q?917nDFYOfbtqqtCopENghy4E4OKQZIzSm3FSuP86Pm8aN9LK/xJ+k7z62q?=
 =?iso-8859-1?Q?aNJFyY7k9kWSW5cELF8Romm5wl1wX58JNKCK0k8reDyQzwsdTat99K0A8n?=
 =?iso-8859-1?Q?WaeedDf6KF3NltYi1pNv8VvNk/yzUvYDGJJtKg7k61nv7AYiRZjG5L32wK?=
 =?iso-8859-1?Q?TAsITxuFkVHcEkWtuzrOC/zAeH3Xq86Iuvlw/SVGHQVHfS1+FwFaAbOV3B?=
 =?iso-8859-1?Q?04MKuZirodqC9uDXqWQl84nzFhgOP0dKHHwKv3w109CgjxvviwCbu6Vd8d?=
 =?iso-8859-1?Q?grR/b8iRprqUX/vbwBcx84aQ2q+pnPfFQ/sqoziC8GXvx4YV1ydN1p9sgv?=
 =?iso-8859-1?Q?ajQLvuUy/SbcdA0j/PFiR8m5uCcofZVegZhPX/uevL5Camwk5jej3Olsy1?=
 =?iso-8859-1?Q?A6EDHqh/yvDvqGeXy1nI8pRuKnDoHAe0MWz7uiMdSFU05O3g43lLvc32cP?=
 =?iso-8859-1?Q?7fVBHMrAv63b1mfiob61uCGxrbFoOlT6gWK7GHHTqBYTjfZHlsD7AxsYt3?=
 =?iso-8859-1?Q?j8cYDgV8VzhE1YY33ugt3hdBo2KjYhKGg7Ij0cmH37WAYpUyjaWZ8L2jjj?=
 =?iso-8859-1?Q?MN9Mxq9HGnCU2/40GTeF8R+sqLp8UuOkISg0iCgwCg6lqi28TGZgrMvXUd?=
 =?iso-8859-1?Q?CBxL0ppSkqqau52pU9FUQkFq2+1c5xNXRB61nhEZ6jFNcuXOEJpnf87OZf?=
 =?iso-8859-1?Q?fKDo7ODRRSqOZbACrN1t1p4OcA9bp7Y6/ybs9pJWQ6sq9/kEvZ+WuZtmQD?=
 =?iso-8859-1?Q?+7LO6ikzZg4R819lLoMS6IAvBUq7E+Xpzbxg69ikQAgQQgOJJdo3HVG5mp?=
 =?iso-8859-1?Q?s3FC2Gf7mxyJk2TsVyGPweQDKxt5+kKsGUHQwSFauoCg/v1wAGOXLMXfBY?=
 =?iso-8859-1?Q?ldBoculMNQnmsj41EU79yGlkh/cZEtr6/jvfhR/0VD+h00N9GOoGWW1Apm?=
 =?iso-8859-1?Q?4RhEEN5RioPvA4dbnNYiXv/D8unsPXGt4VEpAMU/RyY2zj60zsW891j7+q?=
 =?iso-8859-1?Q?cn9056n1xyfqcekjFBaopmTqHNTExzY90oLBgYkq6qLWAgrYdMOORzfRxK?=
 =?iso-8859-1?Q?ljJoA4lhiFUMeHd+RxxbPbHsore69UYejPkhP2Z9/DqOMY+uBhjjn+Q7xP?=
 =?iso-8859-1?Q?clXi3WlCAGgjAVs+QxzD7pUlj6kCg4YqbZSwE31UnODWq9unc8NfmzdJea?=
 =?iso-8859-1?Q?v75PtbNZaHCCAeg4rAy61Q2N9q8qKspAPFAgGFZduKYt05D5skFthFoSOC?=
 =?iso-8859-1?Q?1Z7CXss81V2dswtUoRpvQRz4qaNHzOIOaK290lOhHO5M2xmOdDYcxQE1zm?=
 =?iso-8859-1?Q?ajmYf2s8mpDmZ1e80ORgtd3fmJLiI2DA78ipu4AimpAWIkGI9J8GrNYzAT?=
 =?iso-8859-1?Q?uKE+jz4Vrw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_TYPPR06MB82060AAD1D538252B336AEA8FCBBATYPPR06MB8206apcp_"
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec32a09-2df6-4a3d-a42a-08de49d3ea65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2026 07:52:45.2106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jObif5vZ2OM/hBBDdW+OtF1sr7ZqVGUBo2qQlU8lJnI26sKx/Fh42kv97fRs3mwX179mcLJtBLhnMEcuUGO3arJJRgSpc4WgH7UBLX7Z56k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6041
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_TYPPR06MB82060AAD1D538252B336AEA8FCBBATYPPR06MB8206apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am considering refactoring the ASPEED INTC design.

According to the previous discussion, one suggestion was to create separate=
 memory regions for different register groups in order to reduce code size.
The total register space of INTC is 0x4000 (16 KB), and the register space =
of INTCIO is 0x400.
Based on this idea, I created a GIC memory region with size 0xB08 and mappe=
d it at offset 0x1000.

Relevant links:

https://github.com/qemu/qemu/commit/7ffee511fcf1487e016ae1d11c5e191557a8b80=
4
https://patchwork.kernel.org/project/qemu-devel/patch/20250213033531.336769=
7-2-jamin_lin@aspeedtech.com/

As mentioned in the discussion:

```````
However, we could "optimize" a bit the MMIO apertures to avoid mapping
huge unused gaps and only map the useful set of registers :

   INTC Registers      [ 0x1000 - 0x1B04 ]
   SSP INTC Registers  [ 0x2000 - 0x2B04 ]
   INTCIO Registers    [ 0x0100 - 0x0154 ]

Each set would be associated with a subregion which would be mapped at
the right offset in the region container.

This is just a suggestion.


Thanks,

C.
```````

However, after implementing this approach, I see several issues that make i=
t difficult to maintain in the long term:

  1.  Register offsets no longer match the datasheet
For example:
REG32(GICINT128_EN,         0x000)  -> 0x1000 in the datasheet.
REG32(GICINT128_STATUS,     0x004)  -> 0x1004 in the datasheet.
This mismatch makes the code harder to understand and more error-prone.


  1.  Sharing INTC / INTCIO between PSP, TSP, and SSP becomes complex
To allow TSP and SSP to access the same INTC and INTCIO registers, we would=
 need to create many memory aliases, which significantly increases complexi=
ty.


  1.  Poor scalability for future SoCs
Currently, we create separate SSP INTC, SSP INTCIO, TSP INTC, and TSP INTCI=
O memory regions only for AST2700.
Supporting future SoCs would require adding even more memory regions, which=
 does not scale well.


  1.  Total mapped size exceeds the original INTC size
The size of SSP INTC is 0x2B08 and the size of TSP INTC is 0x3B08. The comb=
ined size
(0x2B08 + 0x3B08 + 0x0B08) is larger than the original INTC size of 0x4000,=
 which is conceptually incorrect.

Because of these concerns, I would like to change the design to create only=
 one INTC and one INTCIO to improve maintainability and correctness.
In this model, coprocessors would only need to create a single memory alias=
 to share the INTC between PSP and SSP.

If you have any suggestions or alternative approaches, please let me know.

Thanks-Jamin



--_000_TYPPR06MB82060AAD1D538252B336AEA8FCBBATYPPR06MB8206apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:871380233;
	mso-list-type:hybrid;
	mso-list-template-ids:-959410324 -2031693986 67698713 67698715 67698703 67=
698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:ideograph-traditional;
	mso-level-text:%2\3001;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:48.0pt;
	text-indent:-24.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:72.0pt;
	text-indent:-24.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:96.0pt;
	text-indent:-24.0pt;}
@list l0:level5
	{mso-level-number-format:ideograph-traditional;
	mso-level-text:%5\3001;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:120.0pt;
	text-indent:-24.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:144.0pt;
	text-indent:-24.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-24.0pt;}
@list l0:level8
	{mso-level-number-format:ideograph-traditional;
	mso-level-text:%8\3001;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:192.0pt;
	text-indent:-24.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:216.0pt;
	text-indent:-24.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-TW" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all, <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">I am considering refactoring=
 the ASPEED INTC design.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">According to the previous discu=
ssion, one suggestion was to create separate memory regions for different r=
egister groups in order to reduce code size.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The total register space of INT=
C is 0x4000 (16 KB), and the register space of INTCIO is 0x400.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Based on this idea, I created a=
 GIC memory region with size 0xB08 and mapped it at offset 0x1000.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Relevant links:<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://github.com/q=
emu/qemu/commit/7ffee511fcf1487e016ae1d11c5e191557a8b804">https://github.co=
m/qemu/qemu/commit/7ffee511fcf1487e016ae1d11c5e191557a8b804</a><o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"https://patchwork.ke=
rnel.org/project/qemu-devel/patch/20250213033531.3367697-2-jamin_lin@aspeed=
tech.com/">https://patchwork.kernel.org/project/qemu-devel/patch/2025021303=
3531.3367697-2-jamin_lin@aspeedtech.com/</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">As mentioned in the discussion:=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">```````<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">However, we could &quot;optimiz=
e&quot; a bit the MMIO apertures to avoid mapping<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">huge unused gaps and only map t=
he useful set of registers :<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; INTC Registers&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; [ 0x1000 - 0x1B04 ]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; SSP INTC Registers=
&nbsp; [ 0x2000 - 0x2B04 ]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; INTCIO Registers&n=
bsp;&nbsp;&nbsp; [ 0x0100 - 0x0154 ]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Each set would be associated wi=
th a subregion which would be mapped at<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">the right offset in the region =
container.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This is just a suggestion.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">C.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">```````<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">However, after implementing thi=
s approach, I see several issues that make it difficult to maintain in the =
long term:<o:p></o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-list:l0 lev=
el1 lfo1">
<span lang=3D"EN-US">Register offsets no longer match the datasheet<o:p></o=
:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US">For example:<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">REG32(GICINT128_EN,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000)&nbsp; -&gt; 0x1000 in the datas=
heet.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">REG32(GICINT128_STATUS,&nbsp;&n=
bsp;&nbsp;&nbsp; 0x004) &nbsp;-&gt; 0x1004 in the datasheet.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This mismatch makes the code ha=
rder to understand and more error-prone.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-list:l0 lev=
el1 lfo1">
<span lang=3D"EN-US">Sharing INTC / INTCIO between PSP, TSP, and SSP become=
s complex<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US">To allow TSP and SSP to access =
the same INTC and INTCIO registers, we would need to create many memory ali=
ases, which significantly increases complexity.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"3" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-list:l0 lev=
el1 lfo1">
<span lang=3D"EN-US">Poor scalability for future SoCs<o:p></o:p></span></li=
></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Currently, we create separate S=
SP INTC, SSP INTCIO, TSP INTC, and TSP INTCIO memory regions only for AST27=
00.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Supporting future SoCs would re=
quire adding even more memory regions, which does not scale well.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"4" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:-18.0pt;mso-list:l0 lev=
el1 lfo1">
<span lang=3D"EN-US">Total mapped size exceeds the original INTC size<o:p><=
/o:p></span></li></ol>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">The size of SSP INTC is 0x2B=
08 and the size of TSP INTC is 0x3B08. The combined size<o:p></o:p></span><=
/b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">(0x2B08 + 0x3B08 + 0x0B08) i=
s larger than the original INTC size of 0x4000, which is conceptually incor=
rect.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">Because of these concerns, I=
 would like to change the design to create only one INTC and one INTCIO to =
improve maintainability and correctness.
<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">In this model, coprocessors =
would only need to create a single memory alias to share the INTC between P=
SP and SSP.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">If you have any suggestions or =
alternative approaches, please let me know.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks-Jamin<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_TYPPR06MB82060AAD1D538252B336AEA8FCBBATYPPR06MB8206apcp_--

