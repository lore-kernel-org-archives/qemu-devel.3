Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB340EB28C9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETj-0003Yw-H6; Fri, 06 Feb 2026 00:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETg-0003Wx-Ds; Fri, 06 Feb 2026 00:34:00 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETe-0007WD-U1; Fri, 06 Feb 2026 00:34:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVLH28pOJrEwhI1i+DMw9ufDkYoyBteu5GMJ7OLx/BC0rCTJ8IhgjvLd8+3Df/Sp2hhIYaVXc1uxYSqJ7a3DWiJLmaFuIvxj24FX35yqFMvI4uc/OQMXnbhlmhwVVqXh+lkUAPKwZVo+tXzptISlhGqTcO6gpJSvmM431WwG4regH9sOUzDl9lfX8ZithopEXe3UWiKPC4hdrqtCZoSnUzRRse3sCkfETffCyA2pQi0LFNzR+kP19ySJKkPgZrQGFM9h5kMWVfdsY6+VEeisY+OHGJRacUovFh4cwdavXF+X7fFN5aKKeKyegyGj9+8Cm3vZLixxi9ooKzH19Ofpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHWuhbWtU2s1AKXQicCCrroMUTSP0tQht4QDNGHbkkk=;
 b=Z8mUQFE97+UebDoFPs93MyF6Pzlp8hPj9spP3dBsjGhhEGZLVkeanJhSXocx6Yhb4sepvfuCwWzlW7FDy9hnRI9Xa5r3CINRu/B6C19ECr+GXpk6SOpg/GT4hk5tL5QUF64i2TbqGwEFumUR5RcD0/mhdtEeeUcJZMSWprb2FO3y/MMLsONpkJ9rVnnvzOoCFxfvDUG6/xUP7UhPOIqWDeKsPSq6zcQN0kt77zVF3iTiShGyibwqzJbwJ8eS3em4O83/km7yKdQfz7DYri2oO5iqjFNNc0poJ1hr6/C/NiFPIm21/SWMgoNnst5dKCPnfwX7qI8x2Tm1fOiqIgYwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHWuhbWtU2s1AKXQicCCrroMUTSP0tQht4QDNGHbkkk=;
 b=ZDmiRJkSxjK1Hr/3omorkUzU7rxUieyj6Xwuql/2D2orvxsiqeWgJlm8oBXX3tBIwyjyH6XzudCqY3CZqIZ8Vnax04LJZhntwecijWhoWQGMCq+ameEYjt/OoDof9oyHrpAcfzAF4pYFxGTcAi0FMMb9gAOGxu93GwcZcromcUdejgD2JLS1pzD87OO0A0YH86IrJe44aSSdInGTrf+FTCMcJMxDfNhApk/jOR7Z4ulMkTq7tuuZdrdEBUtTfhu5xdF3n1dc+vgoEHSsuZdbw/qdh1Dwr/Iwj+x0cbU5ItnXAEAsXq1asZMxWfONAw0ItPqa6CUelVuuRYg2yD3p3Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:50 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:50 +0000
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
Subject: [PATCH v1 06/10] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine
Thread-Topic: [PATCH v1 06/10] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
Thread-Index: AQHclyosSbMP25tLj0S0hntsBZSHhg==
Date: Fri, 6 Feb 2026 05:33:50 +0000
Message-ID: <20260206053340.3716041-8-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: 2146fe94-9162-40e6-e845-08de65414eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P+9mqXYOAmZgMxetUaG0YgMOMJIzvwvXBrE5Mo2maP3H3sPMK723M71srY?=
 =?iso-8859-1?Q?LFt2kzjXbxAmtssMPZ/50sC2+L7n6JF6sClSRTniN50XMLeaUYqvUmrL2r?=
 =?iso-8859-1?Q?4jFM+LDPndtHNJDxdQRiQeaifUW+w/5MxJ5LymGzi9oHe6U0Xv6oK+KZHV?=
 =?iso-8859-1?Q?UpcRFmRYxE91KLWjWizuAW0zutDnKE4vb5xScGNOjw3EaV7lnaoKcgo1yh?=
 =?iso-8859-1?Q?z8MVI1BFQO3LWSR65CRiwyBMCyT9W/jfZaZlbuCqKs4cMDp254NqEQkTnu?=
 =?iso-8859-1?Q?tL0JdCIPWbMN8niIED7zAozr5FD2JKfnHsKZjLlT8wGsgLeL42r88z1G6N?=
 =?iso-8859-1?Q?htTqFByfsOrKe+Ha1Pu96gCI2o/nIhnEIIW21e6cB+VbkFT5fIcfYI3Q8e?=
 =?iso-8859-1?Q?Tp8zLm1Np9elKqYo9T5xSOk8qhBMM/c9bAPggf2bkQwOBhAtAax3rju5Cg?=
 =?iso-8859-1?Q?buVaKqbtezmD0GDzYPsmrxJ2dwd9ODxT1JbZG6HST4fcLHE1NDMeen1FQO?=
 =?iso-8859-1?Q?RAPKFCNc9Y2izp2tv8Wf48rD0HIK5xgCVjh4rYhbjjK91ihdHM/APboLMX?=
 =?iso-8859-1?Q?J27pbj0oy7FuACTRB6mE0zWIiYyruiCmDPjUI0K3oKf9jsyI7QLO/c7Zxr?=
 =?iso-8859-1?Q?wBr8QGH1h7yFWqRaGWyMOIM+3JNBRmGmtqGLALoqgDRwORDyh41jCwjt3/?=
 =?iso-8859-1?Q?s8hJwHtMPIOmkmsHPx70fblu1LosILaCbEQ6CTDZ/aBPWv7jN6Baw51hl4?=
 =?iso-8859-1?Q?W08K4mnPFHDt3TbMKM3ufAKRvW0frPE+Jug8Fbz5+faCWfKJWgGOY016TZ?=
 =?iso-8859-1?Q?vyd5fU+1DxNMEpfUg54taa7etb8WV6VcG7zXeV+eDaWN7z/7JT/Vt0qx/y?=
 =?iso-8859-1?Q?AJTCtCSE2Ry90x4V1BgWPPR7Jdxl+24BQcYfNxrgEZ6nXUKbSVSmNSKuWU?=
 =?iso-8859-1?Q?muC2zrplNpamtUmb6QGmVD7EWC+HOpRWUSx1XZp++lVEOuFvFoP+n6eM2D?=
 =?iso-8859-1?Q?sCmNcXIJbdD5R7bzCi0lo9BTzDb56hdS+lsbufVv7xoDQ96uq6FIBvpRXF?=
 =?iso-8859-1?Q?6AbAgPHwAzqNHRcndfI5YiJvglVvpzYbBc/ack6Sa3LRnF1MlXHKA//Cn0?=
 =?iso-8859-1?Q?Q7PwyPwLbotfcLEBWJ3cAjSp3Uv00fqTPo8pjFAxxFdR76la1T5pGYEMEi?=
 =?iso-8859-1?Q?ec1RZHwX/kpNSKqkpIPEXThEOO+hDDjt62F98j4a7pHsXhw9a369oSjK5+?=
 =?iso-8859-1?Q?/v/TC6yHmjthXdMiYtT8JEQ2QdAApegMON3TAQ/Zg86i+Kl6i3b2EWRiKK?=
 =?iso-8859-1?Q?0itKIGq0yRxV0Om53SglLKvEvcTayRGt0PRYzloJHdjwcEo3m4vCOpcF17?=
 =?iso-8859-1?Q?DoBu81XI/zeuS776GAsuFra5ZOhoV/ODuXbBCW8BFkLKAaRj5oMPhx7M8Q?=
 =?iso-8859-1?Q?Xvcvypgtrmq0e5U7ygxfU96H5XplujSfKT26/pfN1MW8Vnh8SFV8UkE1+8?=
 =?iso-8859-1?Q?BT3B4L4TsVi2zSjcdOj64VNf3hCfvmfNjpZ4DTQ7edXvlsAYa996giBuFl?=
 =?iso-8859-1?Q?7kzx7eqpKOb5GeZEMlj0fpqU577KsCB4M8mKy2wBs4mo0gk8UQrebAH5pu?=
 =?iso-8859-1?Q?L9XFQxZtVKmZEVC88pbPtxrOkU03mXE1e5SI8VZjmhf1bZfGTbgUIl8CKS?=
 =?iso-8859-1?Q?opHDwvAX7tSfRNoHl7LLSm4Ir9xEZ1eKLvVjfqxG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qkKkz6ZncmvWfYbALxUxXAsTs9OBff110Wa9WGGSo5LM2YjV7653F5bNaz?=
 =?iso-8859-1?Q?UNbg0of78gojKUW8VA1pBvn/zfY+JZzN9ZCoAHlJ7aPA49cWX8ZfyztS9x?=
 =?iso-8859-1?Q?90s7C/pC69maXE5vu2MKalSNk3naFKNEqLMb+NGXFVeQgjCxTw65uzciB5?=
 =?iso-8859-1?Q?CZrjMsAPDzwiToPrUaIboO04a6ezPddiQPPLT0ydzPCtCrPAVK/ZSKlvzM?=
 =?iso-8859-1?Q?EWce14BqmLDk0CynP/Qsapux4x66qRW2hwvXx4tOpK3YK1DFBpyb6oY9TQ?=
 =?iso-8859-1?Q?J+9zhc0moYOo5hIc4PvYWjfJZsyQU7xzFMU90gfBaFjhj1mAV2Y8GqUuyb?=
 =?iso-8859-1?Q?YTwAM6tDf1r7AJswa4cmkTjC2GEvX9ZlsLmm7jCv1Vp1CmnrZZRUejeNAb?=
 =?iso-8859-1?Q?O+rsVj/5NqCkfDEYLgn6vbAwqLn0JYk02xGY+JxfY8IyQO1rF5rhseJVTA?=
 =?iso-8859-1?Q?iUmDAThBlSbaTr/U1y9O9nF/AKCySSzZoGT6rN0I2wY5hmNBFlEXaDllRQ?=
 =?iso-8859-1?Q?6LcoJw0pYD+91YZyuSjdXt1w7Z5lLUttgclAxN1QplZ3BOLPn4TTmn1sFo?=
 =?iso-8859-1?Q?agzPz4/mnGsMDPr+YAgBzXQAtInT+mhfHknS1Q/6bLl/tmuYRR3S8UHHke?=
 =?iso-8859-1?Q?0eLvlZ196BtieJw8Q7AqoLv6563r12JhgHH/SmPMYED+wlp4/IcUmR1cua?=
 =?iso-8859-1?Q?e0UCPa0UpBSuyviVu/Wgk+i+Evv2L/oUTXrZXfe9Lj8tz3zF4UYzaecx5u?=
 =?iso-8859-1?Q?Hm7FWzz/Wk3O8Zvis+1Xq58u5hsQwtFHNBY2v+Z1q0hYx9UhEmFllyE459?=
 =?iso-8859-1?Q?DIElB7Ip9fHdhVJ9upcQuId4APugx5jyjJ14hZr+mF4NOreo88gvY9j9Op?=
 =?iso-8859-1?Q?DGxksp3dtCdR+XWT61TPH7plekAzx/YtUcJ6avAEW4bNT188SwgV0ebuhm?=
 =?iso-8859-1?Q?eU6CpTTzdP6/I7wXf7dN7qElWM7u+ye/pDO9HZajSmzJMtYT0ukucWm2Yo?=
 =?iso-8859-1?Q?prSqz8OfyzBqG8FN3hy+m465I2kHHycXbwwLOkWHw/jvgusPu+EG0pUkAt?=
 =?iso-8859-1?Q?P/kQ48pqd0TyLA5qWPsD+OLa3jQowcp14kHNdApKR2ZVAi/Nyun94i+SSn?=
 =?iso-8859-1?Q?NMhZMqkZlZvyEX268WCXO/U0facuQ6OZCJ1lmLzy/rp+H5UQ8/G/FXx4WI?=
 =?iso-8859-1?Q?/5tGOFpq/vczcvby/IF9SrI3mvm1T/roE7eMld4TfWOcnyQ4uGG5mmlAlF?=
 =?iso-8859-1?Q?lp2eUoLOmzjrK8VlgVOyWGl0oki7lUS70yv6D/MeZJi0mH3hPl6fThLDNu?=
 =?iso-8859-1?Q?hzRetqEVxutuBm4SAcHUYDf5yGbPmaZhboopMi0bV3Ta3cD5mGyqv8zCru?=
 =?iso-8859-1?Q?ppUFmQxBWSaCBWEkmbhO8nKjWELtlxOOnFxQTbCEKJchqlV5PQ0+64+P1p?=
 =?iso-8859-1?Q?xsnGERAymqLjL5AqRaEjDsCEc9toK/yDUgWqnXlg7Og2IlAfTDCVCls7SR?=
 =?iso-8859-1?Q?abBml92NiS2KEGHUPfD7z7O7bHRiar/ui5qf8EBIZl6pZPwr3mBuUfTFAH?=
 =?iso-8859-1?Q?XPAyFLS40wvyrbGwhmh82Z4VbQtPgf7WhHBlAEha1XcpMptHkfWddp7XZt?=
 =?iso-8859-1?Q?thaWpRhKxsk6ecolqShb+JXJobNAdZ2btSE28g6KdNiUqZrn2tf1T4lVdr?=
 =?iso-8859-1?Q?D5Cw4NyUzXW3sdSChsNI3xLWJDtoFTA4F3ID0IzpmpHArBnEsRDecSkmfT?=
 =?iso-8859-1?Q?E9aWIc/9SiwA+PFGfJYpP7ON6DRNEBEVGDKqi+lSQkGJmHt4en4ZVRC9yW?=
 =?iso-8859-1?Q?nGTOUm2Ogw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2146fe94-9162-40e6-e845-08de65414eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:50.0925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMHPtkoWO0NfMunEUVRQkEzWG/ZNXPg/uvJFIGD2woZYqrVroKXpSNp92GievCRUtjG6tFv/PRgMBsaY/acDr2IgGZCtuICosx54e8JM69s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
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

Add a new AST2700 A2 EVB machine to model the newer A2 silicon.=0A=
=0A=
The "ast2700-evb" machine alias is moved to the AST2700 A2 EVB, making=0A=
it the default AST2700 evaluation board. The existing AST2700 A1 EVB=0A=
machine remains available as "ast2700a1-evb".=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0_evb.c | 29 ++++++++++++++++++++++++++++-=0A=
 1 file changed, 28 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c=0A=
index 31f7d61117..0ff1bebeb0 100644=0A=
--- a/hw/arm/aspeed_ast27x0_evb.c=0A=
+++ b/hw/arm/aspeed_ast27x0_evb.c=0A=
@@ -34,7 +34,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(Objec=
tClass *oc,=0A=
     MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
     AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
 =0A=
-    mc->alias =3D "ast2700-evb";=0A=
     mc->desc =3D "Aspeed AST2700 A1 EVB (Cortex-A35)";=0A=
     amc->soc_name  =3D "ast2700-a1";=0A=
     amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
@@ -50,12 +49,40 @@ static void aspeed_machine_ast2700a1_evb_class_init(Obj=
ectClass *oc,=0A=
     aspeed_machine_class_init_cpus_defaults(mc);=0A=
 }=0A=
 =0A=
+static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,=0A=
+                                                    const void *data)=0A=
+{=0A=
+    MachineClass *mc =3D MACHINE_CLASS(oc);=0A=
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);=0A=
+=0A=
+    mc->alias =3D "ast2700-evb";=0A=
+    mc->desc =3D "Aspeed AST2700 A2 EVB (Cortex-A35)";=0A=
+    amc->soc_name  =3D "ast2700-a2";=0A=
+    amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;=0A=
+    amc->hw_strap2 =3D AST2700_EVB_HW_STRAP2;=0A=
+    amc->fmc_model =3D "w25q01jvq";=0A=
+    amc->spi_model =3D "w25q512jv";=0A=
+    amc->num_cs    =3D 2;=0A=
+    amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;=
=0A=
+    amc->uart_default =3D ASPEED_DEV_UART12;=0A=
+    amc->i2c_init  =3D ast2700_evb_i2c_init;=0A=
+    amc->vbootrom =3D true;=0A=
+    mc->default_ram_size =3D 2 * GiB;=0A=
+    aspeed_machine_class_init_cpus_defaults(mc);=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_ast27x0_evb_types[] =3D {=0A=
     {=0A=
         .name          =3D MACHINE_TYPE_NAME("ast2700a1-evb"),=0A=
         .parent        =3D TYPE_ASPEED_MACHINE,=0A=
         .class_init    =3D aspeed_machine_ast2700a1_evb_class_init,=0A=
         .interfaces    =3D aarch64_machine_interfaces,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D MACHINE_TYPE_NAME("ast2700a2-evb"),=0A=
+        .parent        =3D TYPE_ASPEED_MACHINE,=0A=
+        .class_init    =3D aspeed_machine_ast2700a2_evb_class_init,=0A=
+        .interfaces    =3D aarch64_machine_interfaces,=0A=
     }=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=

