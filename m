Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96567EB594C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzmJ-0005Ui-6b; Tue, 10 Feb 2026 21:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzli-00057l-1l; Tue, 10 Feb 2026 21:15:54 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlg-0001ez-5F; Tue, 10 Feb 2026 21:15:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz28aHqJ6UGi5vUqqjswdX+mxE0fKu4A2AJy9uW3h0CQzcv6tTmHvAvnssOElgTR2RHh/x2kwsvrCA0EnlKhLRIxkE3DEr9+Yei8fLxuVJBQCArHIVThrSs2dz5CtWf2ALgbaTP5qLRkTZTkPm7wklWdA0lzb10SI+iBSPAFzl+mIsS/+RqM0HAgMvZVkloJ1xGyHNUiZDAgScJUTYpgeiX/UXm9Kn4gUS2D/v4sX7kIJI4JKLDe3Rc3abFDQfIJqiE3zJvb6aXXWaByUTebfwv5wJotKpXbp4d9l9rFqRuWkh/riejIaH83HHCgoeVoWciL3JoHKit9F6WynXjVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j6rEAe2Poh5invizi9CJJUD7f8H5gLdKwOrzgquEFM=;
 b=xI0RxCHz+xinFetplde9mpLEBdSE6Wue4ICVq/IT4C8LqF6DcNeFkf9vFKJ7yItrEpar4PdpYtyvy2zJe1+I+yKv8IqFpvAyAK8NoNJ/o1P/FBhvzJ3Dkk/HSd4EuBZP/d7gK63CDEGC4EI27HZIfhRpvFJNS8GLyGlqkleKASXIGm5DaEVdxUPgDJZO0yievjvskPcjFDU6p7QIkDVD07sIRBNVjX9wj3V/Ekxc7+4nCQA/6Z1OHotz1WlsMDjAuOisLUMdl6Aa2/Gn5neQug5NjB1d3uyh2VYYWAfvMw7MgJAMfc/1NQ5i/tmUx/8n2mKq4D8tIxGeST4KwNHspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j6rEAe2Poh5invizi9CJJUD7f8H5gLdKwOrzgquEFM=;
 b=jpgRVuUpZh/qsnyjKrKKpc62iPEQezqvBHoqJJfBSHwTs7ZHcZh9lzfjZ6KUgHSeA2Anw8WYI2i1Ocs/TKu6FQMyv1pDiUf9SUMSCOZKNyagjgz79mW3q3OYbbSCdP11IWkhpbAaFL0zisjKtzrI+pp7Ycij/aINoEA8wYXqGWneQj0aAQ/UTxtW4zYQUrpOKNrbIsrWMF47yImkWrV/9FenCvAqa95vTpde0RbOuhl5GDgM2cb1r1ZGY8ZXb71Go3GdggnaDzz1vpBSthozdGnDP39VjVE5MBwtbm2bKDCerIv4sXhQavW/O6uxL3CDTpfJnu89aHpUTBNFCd1qOA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:39 +0000
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
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 10/11] hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM size to
 2GB for AST2700 A2
Thread-Topic: [PATCH v3 10/11] hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM
 size to 2GB for AST2700 A2
Thread-Index: AQHcmvxQb05mQ2PCg0GMmshtYJjnLw==
Date: Wed, 11 Feb 2026 02:15:39 +0000
Message-ID: <20260211021527.119674-11-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: 3b4b7b69-6617-4ae3-6054-08de69137373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?buSCZ23apTefTagcbV3D8bkFkZp5rEueC257wuBuqd7F7w7Y0ZEpJQUG43?=
 =?iso-8859-1?Q?BJElva7AetkONEPtOryB/K0Rk1+rDMCdrtgyNHs4KbuFxkBUjr+z8IXJXR?=
 =?iso-8859-1?Q?qApa3beR0B1beANMhuWrE/m2psd0gvio523NbkxQXb7JeM/eCH4CZDx9GD?=
 =?iso-8859-1?Q?lJwAg0rSulysh7eVKN59UeMT+WspEqKxvN1MiYMWcI86hVi29f8/44c1X2?=
 =?iso-8859-1?Q?uvJyRgrH9nnnxnZeIvwfdrEOo5kKf824i3pOVdM4lhgxtJa7LVo1nrACZU?=
 =?iso-8859-1?Q?MyCk6UVI83Sly3QbeLBmy1DM2C5qmdy6qUl8YZ7ZgwcqAtYw9mshPTKv9+?=
 =?iso-8859-1?Q?DEx84JCJdAHAOI12rCB9uh7uafzNd8S95tWLjQ0bd6NPxfCG8MeRH5CmF/?=
 =?iso-8859-1?Q?VkKhhQ6LfFgPdRQW+g2uL3XWISfHuvni4UjqTw0mchof8T46Y92owi4K9D?=
 =?iso-8859-1?Q?hvgXYkd2qXiUoaDO/D999m+QT3Gf2jPlN//RMljbKM6kwHIHuNys/kx73L?=
 =?iso-8859-1?Q?vz+Tx48XgeCfpmeRK4XbCcR200aHP08BzwomTjM5P8fxIEOZNcdf1e4pK/?=
 =?iso-8859-1?Q?nMLYYrf1Ka4d/h0sQgyMvM9qnuBYI8y+b+fEcCHGCywfVn1R0ngT7IH94r?=
 =?iso-8859-1?Q?dwsypRTStYA4j2RvGs9+oQgzv3PHfa9qlOv8ldTWBTAjq/BiS4V1Y0+4+h?=
 =?iso-8859-1?Q?grflnXPfGLIeLOyeEfvw/yZfL9U3GRFNXz1BzfRb6W8LhC6vrgKBUUABD8?=
 =?iso-8859-1?Q?uA0JU2LKmNdVVTTyw95B65it/So1IEDlX1GWJr5gz8EvuzqTQCOtV1Mmjl?=
 =?iso-8859-1?Q?Vh9qKx1/EDrTIZ/Ig/OaqloBJeMI+wKp+jvj6fxWonAZjRyt50l8aIf+BX?=
 =?iso-8859-1?Q?ycWDc8KyHGDnV32oF/f/xLTV4g28b9qkA5OvSw4fZpGDwrdbDh/v8jhb+O?=
 =?iso-8859-1?Q?vf5HkCOvYGX1IbI6Mfo4K+HASPDe7BsuVW3GFb9q+bDsUMAvSFxSZ9oM33?=
 =?iso-8859-1?Q?YekqPDwPoGLnVe4XvDUSNV0UortlNKysfSVqmKIcIUZAxjfmvFHAu/x/nq?=
 =?iso-8859-1?Q?lfdQGCECrnR4dOht1EQeOZPofaQNQgR00bcrL5ymlOMjKXbm+tlYC15wE/?=
 =?iso-8859-1?Q?z8BASOqbKaL/+dx7DmB8PGyTsts8BnAn4CYIpBLVqcaCGUSufFRFAy8dKs?=
 =?iso-8859-1?Q?NSBvovm/LmLI+Lx2S1sfUVy87cN86GoCKlIAEDCRG5erUAf4V4WwouusVw?=
 =?iso-8859-1?Q?Wdrl9DLQohIWty35lOo+Aso9c+K+/Mjhrm7gFDftXgzHFb42nR2L9xIqcU?=
 =?iso-8859-1?Q?GrUWk5C5W6K3saobPTF3/oO4uli7M8v7y7e6qJeBaGsyqdjV0zogffitmM?=
 =?iso-8859-1?Q?0alOA10gO39USjZ8R8FUwJDr/MMPsk2gFODm7hQ2c+WxZ9fgKyBMqZ10tZ?=
 =?iso-8859-1?Q?2x/SLm4djabTIe8Ub6tSauCT/pQ23xxQ/6G9jMYkyJBQ6vJIr3FAeg2mZ0?=
 =?iso-8859-1?Q?QbA5K6nOZnqd3wOpOYds7ckrU+HBCp4waNcdyR4Y8GjiEwUHuk2zNWL0Fc?=
 =?iso-8859-1?Q?bxSwM5Ow5bBPmwvny5UhbhO+fxb1TMZQmEBDMQXrnR9u0HvQSqQQ84iN0r?=
 =?iso-8859-1?Q?yG+ygkcPWJnFYEnTF068Q53+Gyavj3IhOVRZIoYhG+vwKdl9R+ubxuyYR0?=
 =?iso-8859-1?Q?vXALIEimj8Mc9sXKfcCZNRrLhf5qpWtZGzN47HnA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zZWHHoPQg4S8ICWFuLwPq8gimgSj/yL1nFpVMLSTg0SG22O+IKCs6rteuR?=
 =?iso-8859-1?Q?E7/kgY1XUSMEsOQ+KPIypUNcv9XFokvBWSYjpFGBlm8GrecnV/vYZerkTS?=
 =?iso-8859-1?Q?bJ2fr+PsaTkrGkqL54rY3LcrOYE6sjBPVNtIh7kmAfC9n1Pn7b6ewwEnrt?=
 =?iso-8859-1?Q?hhm6qbJnLdE/26idgdWGxCg1Rd80WKCsxP/jtyCNC7kjqzAYd81cL78rqV?=
 =?iso-8859-1?Q?nkzs52xHWQu11Fqqa8/1mGcXh/FURg8TRaISa95c8oSjgZJblRZ61j3Ped?=
 =?iso-8859-1?Q?6hlyAvXmCPyIP099zYnWqh7HO9M3h6l/2NtKR7Zc9nB7Ld+hq/IXWMX7AA?=
 =?iso-8859-1?Q?UUxvXxH2lhCi/GL/Aqc79JjNlrmymP0pP0TXZhw+ViE1i6FQTW5UYMG+Eo?=
 =?iso-8859-1?Q?CXcB7IybgCSYx4hUsrnEh9ANc06cL16EzK4cjPOCa/w4Bcgbcqd+oExlES?=
 =?iso-8859-1?Q?hQpW3J+Twv6Y678NVQdfa9fQbsuvXExRYnb2E6W6q7xu6c6bQbdQW4ff3q?=
 =?iso-8859-1?Q?/vMYKculigM2PYUn0qy9JvrUlhS1uw0fVxmzWQTnRvMUsUum1FD8Qu2Ba/?=
 =?iso-8859-1?Q?9jKTwlhMpkjDyjBxLfDK4I8DjTymUkBUJr+7t/9Dt13GiXb0VmNvslaRVx?=
 =?iso-8859-1?Q?kqkO8oMrJh1ILCMWp8vAEDwypLu7gF4zbLvqAVcymUVT/n/3t6vjeUI5Z1?=
 =?iso-8859-1?Q?WsRU/PW4NJarsSTqnL2BFpDhISClGDhJEU6lJPFwKyb3RqdsnhjRnERD71?=
 =?iso-8859-1?Q?b/F5/bFrM1zOk+SQ0g2+T0ROUQeHdp69BNkt11lkXcg4gZvLK2d5vGTChE?=
 =?iso-8859-1?Q?agXiYNaaKwBV4s9SBWYVscrxcsndR1cfGMXcxJXKFGA+I1b3XW/DINWr62?=
 =?iso-8859-1?Q?dRcrPzG3JbeqkFxsvTRql4YRpLdeZxFZoC9qbDvWMuz5Xbd3j3TDNFi2qb?=
 =?iso-8859-1?Q?ed/whhGkca4d+8LIPjLcifQwyyQa9agpPMKr7mYye/3H+KNOb7Od9f8Gj7?=
 =?iso-8859-1?Q?HhFlvU88e6D8eiy/bCw4GmSu0WjvmOiLI7XE4gvmWxOCTUy4/nsa7dwn8q?=
 =?iso-8859-1?Q?VCVeZKedYJicWo1HcGo8dFpDoORHfU44x4AeH5PQV8gP7GENr9WH90JErN?=
 =?iso-8859-1?Q?S3BT5oo0lSH837XesdD5AwwlzhrBgGBeBV/kxFC9OoYvCJmarLPsjrCX6e?=
 =?iso-8859-1?Q?DovUIOsZvXcmxHTJS+fD+luwoR/47Hl5h3HY6vq6B3tbncdMM/w0Njv2yp?=
 =?iso-8859-1?Q?eokM2VrT5crY5Bscg8pQA+WqENv0loCyvbmqYF0xkxrn5aNVcyywssN4hD?=
 =?iso-8859-1?Q?KacBN08BWxp5HpLhwzuMg4AH0Ukm1F0jNLJB3jEOoilbwYu5r3UkIepaAR?=
 =?iso-8859-1?Q?Tm4BZhnwTh7hSavgFtloiGfrbIFdZ0Cffhv/ubussiAve/yclOUuC5Zi8R?=
 =?iso-8859-1?Q?eJF8rMra3m0RKECILZPFI+cFyev3SJRpgKrrsBQYh0UEWDzwOF1+Oa9K9U?=
 =?iso-8859-1?Q?Utz/2YCGGRNEZhE/PXN4ZEjfzJweVMeJ2jJde+kq8SDxhXFV8Eye0bpg2t?=
 =?iso-8859-1?Q?BXyT5mfHY2zagsdza+5/qPT0krCRu+ocuPpYZk5J12qglJO1MDld8ANnrh?=
 =?iso-8859-1?Q?KxXCCdLLqoRHZu0blwT9ZOQIzv2lmplauXefusuF0kp+QmDh6RC5ywrXE9?=
 =?iso-8859-1?Q?noUykm/fiX0QITZRfA0LCr8MmYXJxTOuAv3Dl19SCgOeIBYVGk/kNJQueH?=
 =?iso-8859-1?Q?xJYgTPLzO0kpw3oKqlwyggGwBb6qm8Kpl9Tyzok4lBQKNCIbMxgrNuFFjo?=
 =?iso-8859-1?Q?6GU1aWSg7g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4b7b69-6617-4ae3-6054-08de69137373
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:39.4921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwLKLZHhaQye+uxUlzoD6US2/de6k8qS7rutzqCWj5FacoIy16Z4caUIKL3vUjtssAwhExBWRtjmNf/7m5ZMijsAI6emy+dT++yK2sDiLDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
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

