Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B77FE91297
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOg-0001t1-6Q; Thu, 05 Feb 2026 22:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO9-0000Vb-4S; Thu, 05 Feb 2026 22:20:19 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO6-0008VR-0q; Thu, 05 Feb 2026 22:20:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdQZSnQiht34Vs4VE8uUKtnPBH9SbQv7Fr57m9Y6kdfaAdwtzGFPEv7bG52QiGzwYZF3ujceIhWHgy79+H8/GxggCRx9zMVOIAk+i+0ERj6PMCWXDv30jdURdBOgCWV4j9Ba48eADGCpnQ3yYQGvpWFGfoB+V8cLsng6sVbRorwVUp4d8LBP+y/0VQqNp37l+6u2gwg0y56XdUnVkMf/1obnIdqXQKlqTpkF1SnyyWo4O4AqsuG0dX4x77M6FjqF6phVCsF1LvAfM8vu8TndIj4zJhjeVM/JTQwxZFGX3hHMDQReF5NfxJgI5X5Zb6xQXQErtpPXjOhSmM7T/Z91YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coIzXWoH62VurJ9nb4WuiuDaNXuNdya6LvP915mKc7w=;
 b=wky6AaBzr/w3RYJkyE7M+kxOJHluQ9iOm5u/m1J3kJnXqFh9czE+C1LdLFq30jXy9j1Oxpa/6kDTaPYFGRncxzQMoTUqtPGnHkpLg6MZX7osWxTHf2PN28YrBcSKSIS+k02skMMhBpjfvKmssPIWu7vts72eqkc7hMPA1vZoRCGLGsaaZVPPOj6e63vz1tXdi3nUGsN6kTuMOKVhFRzbF8y0XE9CeiK1GtqdO2mEiINlVAr/CFbRzHTLLrGZ6Ry98f6TpiTEHY5i9zP4azVKSxIER3iKBfd1xMRnqaOig9PSBjcp6hwuycinlA+2gbtNttkqJnRBrkHxQCsq4f3MIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coIzXWoH62VurJ9nb4WuiuDaNXuNdya6LvP915mKc7w=;
 b=iXx3X7mTgpWJ8FBLJcVTKfKJH4C3yjq1lyh6KcGt+qWj9BleiU2nR/PCP7WYth0yTSO/zo9PWAGYygBP6icHulvW9N2bTiRrtSVsKs2Zoxuy9nOyNZnbk5bsvEl4wKRHEvrAo7IKCSc/2AlyagA6tS8N6zNhpeOvc6QtCV2F0Dbgaw8CZ/uusdENfap9fDdidAoxTtP0n2iJxA7D6QW/BHaauaMFqtxDuW3G1de1ALY1uRI4P1RtEcPvErdvf465HAilrfLL1yocxoGuULl5CBJk851nMtPtysDtMHt3uiCY0D6/W3OFNtK9WqLqtfDJZvN5fwJw1KTgZzebNl5TMA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Titus Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v3 17/20] hw/i3c: Add Mock target
Thread-Topic: [PATCH v3 17/20] hw/i3c: Add Mock target
Thread-Index: AQHclxd1Ocdmn8es6kuMtBPXydcz4Q==
Date: Fri, 6 Feb 2026 03:19:52 +0000
Message-ID: <20260206031926.3227848-18-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: 22980915-d954-4bc7-e8eb-08de652e987e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WaOHlzkf0G+QCfFqS7BQ213+1CKI5GFWYSLxVvcmgwX3/bwELBsnP8+3u8?=
 =?iso-8859-1?Q?egnYbjxN7yDA38rJ9nK1Dbr1dRg0F+T1EUyh1hJljZBL1+2TnbOOJIwwze?=
 =?iso-8859-1?Q?ufi2ElxeUS09Tu5VROnfZDgBpDM7MmYo7CxEST7XBoiK2ARBJs2bp7cndX?=
 =?iso-8859-1?Q?bYG2zIVw7q3B6LjCRbGw15qgSo89wwGnBcJ4Xud7y20PgmwM7w0lwtsZ9m?=
 =?iso-8859-1?Q?+GmqomBYFJD2+2bSfC3iYzm237t0nunVzrBgvMUG5RGv3LvskkeV/fSgKn?=
 =?iso-8859-1?Q?lIK2D5LHNzDYBDFghaOnYnUcc4bhmBYmRNaIrJFDRZoYn4hr0OWmjWOp42?=
 =?iso-8859-1?Q?Cz/q+IrHSbJtHfch6GZv8fLw7KGBdYzP5/SOHH9vf9eIwA1g3ryiuKcwBz?=
 =?iso-8859-1?Q?HiMX10qByO4Nal7Sm3CYvIZgNSaYqWMImEOy3eUUNgjAtaUCkdEFm5rsPE?=
 =?iso-8859-1?Q?EneC6187844Bei/lNBgOGI4DXYwGokloXl9FiNmCwQ2OcU22tKbpO448pg?=
 =?iso-8859-1?Q?Jyu/TJurCowjbZ/VQUT5DIcwJDOTfi01SQAeU7F0EPFNjyjiti3FxKPF71?=
 =?iso-8859-1?Q?VwHbl4bykKMQ/DI/fbQCq2+fi71vbbrWLcgxvE7B+GDVd8ZXx6rrdBb0g/?=
 =?iso-8859-1?Q?1L3jNM3zOme7TQUQx55bKNTfObBITzErtZMsFOpwUpZXBJXtJ0h7I6hjYb?=
 =?iso-8859-1?Q?gvoL6UeOXInv033qu0JI3EM6aIg0YGI2q5G+7lUsHIO4Mdi6GACfUZS9sV?=
 =?iso-8859-1?Q?iYskDSJkHaai5z1amLLMdtQJzaOuUoUsCKk3WWLtm/+Flt2kIOZ41wi2qT?=
 =?iso-8859-1?Q?B7uOMOaz2oJvKRPgwT5W6RYAnepvlq6P1HHJ77jo8x70rq5bap/UWTDZT6?=
 =?iso-8859-1?Q?Dpi7XZPLn9B0Jk/ucYVdLt+kDKXZzAb7jJlenyrKMcS6UyH340Jzc07czR?=
 =?iso-8859-1?Q?8XrB6ojhqaW+QQoBuYtSY4Pn+Vgz7HycLbVZq3TKa1/IvNVU5cGq5/1zHt?=
 =?iso-8859-1?Q?GGu0BBLVZ/MQHQY1+i83x4F0p+bZyxZDw3TklRBeIfbmZmSg8YD3Muu6Y4?=
 =?iso-8859-1?Q?A6OePc7YzZ3TFhMbsF13nIntqNAUVnYrKyVyjzRoi8DHA0lgZ2aGS8bUs1?=
 =?iso-8859-1?Q?7zWOVxYaP7E1f2fwzubAhyYz6WC+NGA8E93jt9m6WLzNEN9K2mrAlTajVi?=
 =?iso-8859-1?Q?Q0LQB4ncyGH1yVzb16qPMwIkXaxvJrrDctzkDkAMxU3kbii+XTCVSxsWV5?=
 =?iso-8859-1?Q?mifJ9rwDSp618SRSi7P5utoc1CDwZfXumJp0KZDHs5kYDBIFt8a8IGNsj6?=
 =?iso-8859-1?Q?+vRiICOmJzJ3Nlo/ttmlTOL12B3JdFCNekM9DbfzV7bykilxIUipHFMzGA?=
 =?iso-8859-1?Q?h/Phw9hfmSKCr+19VOjFMRs21seqhJjSn+iOn5/kXn84iQcOuXDp5BaOnG?=
 =?iso-8859-1?Q?tzPTwx9zDB1hhkZbg91YjgmDoYEwuVoXqm70R63CaBM+QamMEoxZvP7YLB?=
 =?iso-8859-1?Q?Q1V2Ad0tQ+FmgyNga6AHKhh83sMay+kl2+hBpnCIVmkOK28DmNMDfAHjqo?=
 =?iso-8859-1?Q?Zk5shU+/5SGhek5G92SurnTfZGOXPv16nJXM4oJpIG80qHRZ6swAOdzlfY?=
 =?iso-8859-1?Q?1g2i3QFcqmZn2B5mih6f+/DtO4vjC7ZSnRooiLrNqn+Dt4Z0XBzKR9fD1K?=
 =?iso-8859-1?Q?5PhTLounIfRrbKwDcNzQRb94BXQ5siSypWTEv2fq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7jtWgWTpP2oulB7/nrfFrVz9AWpGSOdBH4bG2qKIPGApkRTfXeumcA8AX5?=
 =?iso-8859-1?Q?X+nCFyXs43OSzn3ASlMLX/XrmUGtmrks3IzylwBzJaWGhlAcH5cw564Soq?=
 =?iso-8859-1?Q?EF3Zr40V9J6JsaiaIfubb1S8lYzdiniHtvKrH9lMkO1mZquXgfDeezc3Ix?=
 =?iso-8859-1?Q?ARWPmM3UdWC1x4vDew/MdkAQPFfqeG2QE5RKRnjgHU+SKMn6DB5g0pwO4m?=
 =?iso-8859-1?Q?8AxOnXKMBFNRk+sXf3fGGzvP23IY/uyJpRUlKgrEbCrr40rvDzeVdY2HeI?=
 =?iso-8859-1?Q?MM/TTqL2eYFlOiZS8PhHIAuzfBL/NyWpALPMIL3Ds/gVv6ev9lA8cS+jza?=
 =?iso-8859-1?Q?S3iEFN8qVGuXiiefUFX4aB9MgyYFssytYkgk1h00i3TYpLCq7V+q79vq/v?=
 =?iso-8859-1?Q?muKbwqtL9/GL34lvehVJd4z9W43mtqefyINNfjyAVBFQnHAeRBa6guZsiw?=
 =?iso-8859-1?Q?CbkrSFugvo5f8goTkVBDTZXooUrp/W5GxNr8LBXhCouLK3nn6XKGoHHplr?=
 =?iso-8859-1?Q?AbDVC4ZqbpE5Z6n8/aYEhTU+XNiptUqaRgtoqFkpGDSMy9VKkcKTkE6rq8?=
 =?iso-8859-1?Q?PDmUAXKDjQ8O1AEp21f72KCoCThh/tTs8QGBuaP2wQH/rRn8tGmYlJIpAN?=
 =?iso-8859-1?Q?mowdn37ajmRnfnIwkMfzSs7hY3u99Ri52gXNlSMzvOn6kdpH4F1PwDqlRj?=
 =?iso-8859-1?Q?RrOGsAImDQFqXbqQgQ/P2GJvuh6S211r53ibzoC/hiLJoeThZAYmtmDmTI?=
 =?iso-8859-1?Q?D5I/nWVDFX5Z2T4aE6D9tJwKmMdf/CTq8v6f4QgxBW1vZmThzsXbbM0nTY?=
 =?iso-8859-1?Q?Rpz7nrfFrbni2Xb6jDE99LB6jLNBojjHftJQt8b5SmYtO0h5lcO+91nIhd?=
 =?iso-8859-1?Q?jbLXedKa3uUliBY9HsAdPCnLfNXiePlgQ78QBFtkDXGe+RPpOcfv6yt13C?=
 =?iso-8859-1?Q?Bm5MuIdmx47K6GbAdIp5cGl1iH4//R2NanAcLBtcLGWLGfADmvtwNpJWIC?=
 =?iso-8859-1?Q?Y2kG+oPjk5BoM38D18WiahJnnVQd+pKXPKksp/Q3U+b8GnNHvGFtfLRt0n?=
 =?iso-8859-1?Q?dbsUIpu//j8odfr6a6S3bnZEXU1aU4T/y9OPJUyYcN9LEHuLV/EfGtfs+R?=
 =?iso-8859-1?Q?et1MHxvZkyc1WRez6E7eRJprGQ48FxKDvAfAVbJEYrBR8EdonkXIen3Nce?=
 =?iso-8859-1?Q?TIuZ32v0FBupyZCw82+vij1YNRZ79Sl8hJXigqTk7xgQ1yJjhvGa1VNGRS?=
 =?iso-8859-1?Q?kW5WDYtcq0xtO+n9VRlq38BwskO4GOW1t84ePTr19G+sfqKChZ6UTvGLGL?=
 =?iso-8859-1?Q?gegVzpsAEOYDj3/sTOGgAmCmTTRg4B2t5vRav4FfRX6t2ZeKn4PXRrXCA8?=
 =?iso-8859-1?Q?eTdfrcVW09cZCF3GkNl2TbNKOvZK0TUJ4BGcAqlcwO+Vgcxho8yDllfyVM?=
 =?iso-8859-1?Q?d7zzmYzMU/PvS2/fmWASao+8JtiHYVbsykum908Cvn3uh+XLFJJcSNr6BN?=
 =?iso-8859-1?Q?S+XJm+OVpjEM8VOxxONGE8OIIbnwaYG079zhc+zVBy2SE6zfdq1diRGanD?=
 =?iso-8859-1?Q?LQz4bhWHoQlVH8J8VXzIsAkxMAh3/N3M1d9/wyr7NBeECBcNQje+EVY8ro?=
 =?iso-8859-1?Q?097JLn+EP+WfXUIvivaxx+YA/YwLE+p29+Q6cEhq4pSA2Gz3PHvMRJJZDq?=
 =?iso-8859-1?Q?27qQCV+jnQBiTkGRal9SvvCkVnqdBsoPdM9JhcR9GJULtKwzvfyFaud8Oy?=
 =?iso-8859-1?Q?rNXvNF8yHpFdufhGGjE7otioa3A3+L+Q+e0djN1WqQvzBX924X4vLb3JuP?=
 =?iso-8859-1?Q?fWbbGjxhnQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22980915-d954-4bc7-e8eb-08de652e987e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:52.0803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7RMH1+6ziURdL3WXLpNnofoCiGP0IU3g59bNX9z/9L6zqK5C/PPbFxTmrE6xQUEzEjXXG8/8zZtV3tkgGlLkEdJoe1p89p5Dsdd2U+qCes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
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

Adds a simple i3c device to be used for testing in lieu of a real=0A=
device.=0A=
=0A=
The mock target supports the following features:=0A=
- A buffer that users can read and write to.=0A=
- CCC support for commonly used CCCs when probing devices on an I3C bus.=0A=
- IBI sending upon receiving a user-defined byte.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/mock-i3c-target.h |  52 ++++++=0A=
 hw/i3c/mock-i3c-target.c         | 311 +++++++++++++++++++++++++++++++=0A=
 hw/i3c/Kconfig                   |  10 +=0A=
 hw/i3c/meson.build               |   1 +=0A=
 hw/i3c/trace-events              |   9 +=0A=
 5 files changed, 383 insertions(+)=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
=0A=
diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-tar=
get.h=0A=
new file mode 100644=0A=
index 0000000000..7ac55a3179=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/mock-i3c-target.h=0A=
@@ -0,0 +1,52 @@=0A=
+#ifndef MOCK_I3C_TARGET_H_=0A=
+#define MOCK_I3C_TARGET_H_=0A=
+=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+=0A=
+#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)=0A=
+=0A=
+struct MockI3cTargetState {=0A=
+    I3CTarget i3c;=0A=
+=0A=
+    /* General device state */=0A=
+    bool can_ibi;=0A=
+    QEMUTimer qtimer;=0A=
+    size_t p_buf;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    /* For Handing CCCs. */=0A=
+    bool in_ccc;=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+=0A=
+    struct {=0A=
+        uint32_t buf_size;=0A=
+        uint8_t ibi_magic;=0A=
+    } cfg;=0A=
+};=0A=
+=0A=
+#endif=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
new file mode 100644=0A=
index 0000000000..e540a6c2f7=0A=
--- /dev/null=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -0,0 +1,311 @@=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/mock-i3c-target.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+=0A=
+#ifndef MOCK_I3C_TARGET_DEBUG=0A=
+#define MOCK_I3C_TARGET_DEBUG 0=0A=
+#endif=0A=
+=0A=
+#define DB_PRINTF(...) do { \=0A=
+        if (MOCK_I3C_TARGET_DEBUG) { \=0A=
+            qemu_log("%s: ", __func__); \=0A=
+            qemu_log(__VA_ARGS__); \=0A=
+        } \=0A=
+    } while (0)=0A=
+=0A=
+#define IBI_DELAY_NS (1 * 1000 * 1000)=0A=
+=0A=
+static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,=0A=
+                                   uint32_t num_to_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    uint32_t i;=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (i =3D 0; i < num_to_read; i++) {=0A=
+        data[i] =3D s->buf[s->p_buf];=0A=
+        trace_mock_i3c_target_rx(data[i]);=0A=
+        s->p_buf++;=0A=
+        if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Return the number of bytes we're sending to the controller. */=0A=
+    return i;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)=0A=
+{=0A=
+    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+    timer_mod(&s->qtimer, now + IBI_DELAY_NS);=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,=0A=
+                              uint32_t num_to_send, uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    int ret;=0A=
+    uint32_t to_write;=0A=
+=0A=
+    if (s->cfg.ibi_magic && num_to_send =3D=3D 1 && s->cfg.ibi_magic =3D=
=3D *data) {=0A=
+        mock_i3c_target_ibi_timer_start(s);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (num_to_send + s->p_buf > s->cfg.buf_size) {=0A=
+        to_write =3D s->cfg.buf_size - s->p_buf;=0A=
+        ret =3D -1;=0A=
+    } else {=0A=
+        to_write =3D num_to_send;=0A=
+        ret =3D 0;=0A=
+    }=0A=
+    for (uint32_t i =3D 0; i < to_write; i++) {=0A=
+        trace_mock_i3c_target_tx(data[i]);=0A=
+        s->buf[s->p_buf] =3D data[i];=0A=
+        s->p_buf++;=0A=
+    }=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    trace_mock_i3c_target_event(event);=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        s->in_ccc =3D false;=0A=
+        s->curr_ccc =3D 0;=0A=
+        s->ccc_byte_offset =3D 0;=0A=
+        s->p_buf =3D 0;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,=
=0A=
+                                           uint32_t num_to_read,=0A=
+                                           uint32_t *num_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+        /* Default data rate for I3C. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D 0;=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Support I3C version 1.1.x, no other features. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D 0;=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D 0x01;=0A=
+            }=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+        /* MWL/MRL is MSB first. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
+                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
+                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            s->ccc_byte_offset++;=0A=
+            *num_read =3D num_to_read;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t =
*data,=0A=
+                                            uint32_t num_to_send,=0A=
+                                            uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    if (!s->curr_ccc) {=0A=
+        s->in_ccc =3D true;=0A=
+        s->curr_ccc =3D *data;=0A=
+        trace_mock_i3c_target_new_ccc(s->curr_ccc);=0A=
+    }=0A=
+=0A=
+    *num_sent =3D 1;=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCC_ENEC:=0A=
+    case I3C_CCCD_ENEC:=0A=
+        s->can_ibi =3D true;=0A=
+        break;=0A=
+    case I3C_CCC_DISEC:=0A=
+    case I3C_CCCD_DISEC:=0A=
+        s->can_ibi =3D false;=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCC_SETAASA:=0A=
+    case I3C_CCC_RSTDAA:=0A=
+    case I3C_CCCD_SETDASA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_do_ibi(MockI3cTargetState *s)=0A=
+{=0A=
+    if (!s->can_ibi) {=0A=
+        DB_PRINTF("IBIs disabled by controller");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_do_ibi(s->i3c.address, true);=0A=
+    int nack =3D i3c_target_send_ibi(&s->i3c, s->i3c.address, /*is_recv=3D=
*/true);=0A=
+    /* Getting NACKed isn't necessarily an error, just print it out. */=0A=
+    if (nack) {=0A=
+        DB_PRINTF("NACKed from controller when sending target interrupt.\n=
");=0A=
+    }=0A=
+    nack =3D i3c_target_ibi_finish(&s->i3c, 0x00);=0A=
+    if (nack) {=0A=
+        DB_PRINTF("NACKed from controller when finishing target interrupt.=
\n");=0A=
+    }=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_timer_elapsed(void *opaque)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(opaque);=0A=
+    timer_del(&s->qtimer);=0A=
+    mock_i3c_target_do_ibi(s);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_reset(I3CTarget *i3c)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    s->can_ibi =3D false;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(dev);=0A=
+    s->buf =3D g_new0(uint8_t, s->cfg.buf_size);=0A=
+    mock_i3c_target_reset(&s->i3c);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_init(Object *obj)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(obj);=0A=
+    s->can_ibi =3D false;=0A=
+=0A=
+    /* For IBIs. */=0A=
+    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_el=
apsed,=0A=
+                  s);=0A=
+}=0A=
+=0A=
+static const Property remote_i3c_props[] =3D {=0A=
+    /* The size of the internal buffer. */=0A=
+    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100=
),=0A=
+    /*=0A=
+     * If the mock target receives this number, it will issue an IBI after=
=0A=
+     * 1 second. Disabled if the IBI magic number is 0.=0A=
+     */=0A=
+    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, =
0x00),=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *k =3D I3C_TARGET_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D mock_i3c_target_realize;=0A=
+    k->event =3D mock_i3c_target_event;=0A=
+    k->recv =3D mock_i3c_target_rx;=0A=
+    k->send =3D mock_i3c_target_tx;=0A=
+    k->handle_ccc_read =3D mock_i3c_target_handle_ccc_read;=0A=
+    k->handle_ccc_write =3D mock_i3c_target_handle_ccc_write;=0A=
+=0A=
+    device_class_set_props(dc, remote_i3c_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo mock_i3c_target_info =3D {=0A=
+    .name          =3D TYPE_MOCK_I3C_TARGET,=0A=
+    .parent        =3D TYPE_I3C_TARGET,=0A=
+    .instance_size =3D sizeof(MockI3cTargetState),=0A=
+    .instance_init =3D mock_i3c_target_init,=0A=
+    .class_init    =3D mock_i3c_target_class_init,=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_register_types(void)=0A=
+{=0A=
+    type_register_static(&mock_i3c_target_info);=0A=
+}=0A=
+=0A=
+type_init(mock_i3c_target_register_types)=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index ecec77d6fc..d5c6d4049b 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -3,3 +3,13 @@ config I3C=0A=
 =0A=
 config DW_I3C=0A=
     bool=0A=
+=0A=
+config I3C_DEVICES=0A=
+    # Device group for i3c devices which can reasonably be user-plugged to=
 any=0A=
+    # board's i3c bus.=0A=
+    bool=0A=
+=0A=
+config MOCK_I3C_TARGET=0A=
+    bool=0A=
+    select I3C=0A=
+    default y if I3C_DEVICES=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index 83d75e7d5c..e614b18712 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -2,4 +2,5 @@ i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target=
.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 39f33d9a50..3d6dd4f7dd 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -36,3 +36,12 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx=
8=0A=
 legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
 legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
 legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
+=0A=
+# mock-target.c=0A=
+mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8=0A=
+mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8=0A=
+mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8=0A=
+mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "=
I3C mock target read %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx=
8=0A=
+mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) =
"I3C mock target send %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI=
 with address 0x%" PRIx8 " RnW=3D%d"=0A=
-- =0A=
2.43.0=0A=

