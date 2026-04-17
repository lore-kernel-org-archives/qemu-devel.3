Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961DCF8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZta-0002fA-C6; Thu, 16 Apr 2026 23:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtO-0002TJ-EF; Thu, 16 Apr 2026 23:29:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtN-0005tG-2M; Thu, 16 Apr 2026 23:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAuub++9RG3WMy9W314SxZ/2I2nr2zM6UBcMWmhfvg58l6c3bX5CbCnRXHcKRg0w8OK6tHRPUzcATJXWoEj6FH7EU8Zw2TO4LT5R3EOcoOSHOB9B4CiE5hVSse/Lqn125hEDD+kMj1nTlG9IK2+CpmFJ2bZWcLTHEXdVWcxB4FkCY4QhUCcqnLd51yKERQCb+xc4qJuS+a1PxSKlpnrH19zMTe4GLzb88KHE4cbQ5/m4Zz36wH79V6UEFjg6ao8uh4hqE2BU4hPItCqNJaUC1XuYCyyNcTfCMaUwrnDoT4qI3nvcWi8mukqpVe4PzLmb4UxoF1sLlhXeVi1l/v4Kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVoB0oYHfgACgjxmy06loSipeMPm/g65qGwRqWlSYZI=;
 b=N/Fn17Gju8GJzXywqYw2LyKhLqjk1Ev/J1DyregaNO4LxirOcUKa1jENWT4oD+cI0WhVGA8Jszto8UgmNkqoQgo/zj8AE+CEdqSU8H7iV/NPpzeIDwLubsCW+3NlMsrGyp0UxOHAKRZqczKRwh/G1xPHNi9zXvUxL33AFhnB5a+8He7STJU11d83i2Q9GQBwTN8WmQaBF6JKBUJR3GdWfoo40b3H7xx0Sd5Sb8TPWGqLuRMyK0y/6oW8vcJuWFy7B83Ccm3XkgIKmAQ/zT9w25ZuGot/+qznaTlj8d2n+2jqGY2ouqQQz7oSzcAzvoYqXmpBCDwsdaQVLpV9sZPsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVoB0oYHfgACgjxmy06loSipeMPm/g65qGwRqWlSYZI=;
 b=ZzAD9M0s3pkq8g6Vxfkf2zat8wVH559rGPpjIyRbUI5iJxPty1cvkOEi2PZJx+saygAPgPp5bm/xSsvDI0idGG8iKPsbEvKrqhxE4tIDvBqfQ3SvM31z7Wm6V88A5z1WbgjSBWj9I/aliWqqfrrYqFJvXMiM4ezo65ZOu686E6KI9PX3KfzXhZGKKmr4iPrPsAj1AifXxzHqFJRRFo+DjYROzR53yQMGiY6UnxFtnu/+P3VehWB/032Ioih6tFJT/GvaKtfcy8dLmMTVZ0zALAYj1Ga37aMeGm5lW5nskK84njRyml5FldM/++Rnrab7LmQNhBNoKUjuA/4QRg4esw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8076.apcprd06.prod.outlook.com (2603:1096:d10:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:29:03 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:29:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings
Thread-Topic: [PATCH v4 19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap
 settings
Thread-Index: AQHczhpW0uXv0YCWFUyr/F146QByDA==
Date: Fri, 17 Apr 2026 03:29:03 +0000
Message-ID: <20260417032837.2664122-20-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8076:EE_
x-ms-office365-filtering-correlation-id: b2a34cb7-ea0b-45ef-2fb2-08de9c31795e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 3NOX29s0BX1xN3FSaOVxJaP59bLVb1rGMF1+pGSImlzoQyafKEGmuxI9cP03dvc6sLiflfvJ83zo6vLd2JSq2RFDC64ETeq4Jnx1GMU00JCa1IVT/G3HI0YJ+KkeVefeWNuAHXS2jBZmahwIMs+D0mQlmLANmwEoxXUba3z2NB1Tuz40PhRG8ZT55KSCG40amrM86CsW3dzvzKfFZQ85JWPfagBx9SZGJm/t3GbLQEgv+nKOfviiBNdHwcxk81NlDh1QASVgw+ExRA0acrF2dp7VZDolPpJai5mF6WqEIwzbwqqhSUbKODsKXQWHLorEvmn4T+CEzL1EpEMSG82muLtjitwWT7mSSn59n3GeItVR4a/2UGGpvskDsj51MiVrqgzMxOmwRDUgAK66WJH7VSxqRKJfmPJXkzu8+0hL8F33LmQlBRFDsoNUu1b8+DfBUDKa4Y1Uy2E/XTIjjPeEkiwZ8AFKiHxc+Kv+a9Jy0xcTulVWxsuJc1oad6WCUjFY6VaaWF0EPUUX6vpneBf/4yJBHl0W+3GKUfKxMleAHF4lInbw8ok6QFADjmeuVQHFoSDS/3We5stegz4A6VCKefE8EQXuWPNyKQs4BPdh94/dIXfvdOkcm22e5eYtlH8nFig0yZkKAxwinNfglKDQFBsFOT5uN9Q1F8lWuCyWbi6vxdb0u/NEpvbgor6baTtk6SpKOmmdjdWgK2QTVeRjBwft4Nr2xIE9olaUveXoZHZ/7R57FKtDuRoOldYg2Oi3CtLTQaufhFr2lJYfTQKTUq+HKnbqBdGtbBzpaTcRO3gPNJ7lW2QH2uVbrszgStQl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DDHp4cTB+sF7eaF7hBzHlQf+adCDu58kNI92ychE2Lx3tJDUBzZASI5Mxk?=
 =?iso-8859-1?Q?GxBYf78v19/lbYM+ExkUPRy/t790XNgxEa5N8qXEYloD9Oia5inPfhJsIh?=
 =?iso-8859-1?Q?eHis3Eo5rPRSiPruMYJV3ijiP3vRbQfQr80FadyV5R0bhXISsw0BqxD8vc?=
 =?iso-8859-1?Q?veJk2vGl9fNhVqzSB+sblHolJgFzAZQU2nSNgjbktCJKIHcit5t1jD3sls?=
 =?iso-8859-1?Q?0uGgPAyknKw3LBc/gOcEFxqy27Ck396o7rB0O3z79nfewnGRK4Nv5Akg4s?=
 =?iso-8859-1?Q?kXXSApyhxtT+NVpkenx/cfrzKWcwJ6cU9+ccyMa1+K80C8xBlC8xscnT17?=
 =?iso-8859-1?Q?AhkWCBp9cKY0kZjQeGmlSpzBKSeJaUtxYlG0hCYMry9qsbrs+MmKp2Zd1Z?=
 =?iso-8859-1?Q?OKjhqh8xXYLY25sYfncSqhWSjkhCEwXkpm2MCL5uzfoYgp92I1qWd9pfRZ?=
 =?iso-8859-1?Q?tPnm8donEAEAwRfTPT/AQ3N6P9o2w3d0X8jon9efOkVE0IuCjw+jvcKygb?=
 =?iso-8859-1?Q?rj1zxyjwWdly3EDSG+r04FxDMBfbiePDs5YNqItJDxPICHceoqxzWOAf56?=
 =?iso-8859-1?Q?VHqMRsjnLBDjUPtAih+0zFk/sxV7rxnQgIz21A39ME9w0NcO4Uw9aknRLs?=
 =?iso-8859-1?Q?k0UJi0J44Ciz3vwLR2emk6ms1rzjdcnTX8CGaXXfvZvJedCYGlEdVPXZyY?=
 =?iso-8859-1?Q?1YQeszrDuR5BRrwD9lXjz6otvYnbs6VxKRw77TJxhKFN+5ZstW9YSC0ryw?=
 =?iso-8859-1?Q?APoXYOy3jX/xUR55uJV4UzhdNQ17nbE123wIFzBJVz5FEldyJi43fRZWU1?=
 =?iso-8859-1?Q?9USa373blJz+Ozyx/sqACMZpx9E6rlwe7SBaRemvUchHqlw2LlHuQbeaBD?=
 =?iso-8859-1?Q?dih2MiaX4qP9ycXfwJvKa1qgDDRTcMJYPMldZeoXe8LMhbcqAammhEOzbi?=
 =?iso-8859-1?Q?sgued8AahBpquJQqvmCooz1wV6Do0nVYYG7Z19N19I2bC0z9S6Jp7X/yHA?=
 =?iso-8859-1?Q?AdaaUn/Q/df7xvVZsIGRzTAoUVxtKzc0LRgCaRIy9paTKZ+hp2v7l0CvL7?=
 =?iso-8859-1?Q?RxOhEEzXQlLDQ9OB1cbKIhTYNQZIdTqVR+eZkCBpb3IDkZ2E/Kx99UYtCP?=
 =?iso-8859-1?Q?ieSdQkoOFPZkIKrta1vOdbwzjuldDqkw26VHB7c+MPNM2xQYvM+Ziii/Tk?=
 =?iso-8859-1?Q?VT9aCaraJMLZqHlxkEdbVirDf1cv8tfckV6/rh/mbe0bc051szNqf8onn0?=
 =?iso-8859-1?Q?geXTC8sl55G/64Mc4P1ah6eWNnqeSFWzeouwK4zUr8fE4PGoDU7o9V4rL7?=
 =?iso-8859-1?Q?hN3TunPShvak/HCgAHCklzlpcqKBXDIVSne7W09T1vra0a9p9d/Ebu6AVH?=
 =?iso-8859-1?Q?N7bY+luTC9Wuo11rTN2wBMwJ9xOdQXhpOUiLfwwwyXzXekrOA0B+K8ndzg?=
 =?iso-8859-1?Q?Li6qTkZRrL6+G/Wj8Qzmd7OB/Tpm2AtRPzdgPhB/7jvEpytEU5LHuHvsxX?=
 =?iso-8859-1?Q?CysoxepQGvyDyX6Ar5So1PbSrMvBxvBS91ZsgCuB+ZjBlQzwbLpd+pu2tQ?=
 =?iso-8859-1?Q?II7C4Yn1s5yjtO5gnDnAScgsT44v8q2LMhJAjVlxuKhXTtFHDj7Uj5GjxA?=
 =?iso-8859-1?Q?2ygqp3l5b0oaHICDaEvPG1a3ohUfXN6L8rGsNFzHKGWAqVEVg2eoCNHHag?=
 =?iso-8859-1?Q?75xcozU0+VC73mEXKqIEz7QHu0GDlhrz2gtOI1LZbRxBcPD1pG3Vha/tj7?=
 =?iso-8859-1?Q?0q08jVlzh9IrL29ELE6lM47DjEn6Pfj3Ue9yy43JpaeFuH1btjEHWdriBx?=
 =?iso-8859-1?Q?lYEqD7FXvA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lVksZkmfNg7zo0Xxze/5EbEU4HZnujzy46i3FH4JdUvSQNbU9MOlAeSr7SSxIB2yhQr5nZBm/arxCdmI2m4gl+pdoRrMOIciX3ikujYCXpXsDZ30h/ZnARvFTrQTry1I2RBHEKK3ayDySEKG4bN73Mf/SYVCuISnEugD3sWEsOF0TMHEVKjrR0+uOM8fOs1gEGxuVTng6Nk7jflIooRz50qQH+e5QiIoYtfE4btOQw3GyH8p/YOTc8B3zIQ9YeAzG98ZIetM6vtOj9ZbXErX7AwXrChKOceyrTHWdu7OcHzJc+uaIg8R3P7uC7RCR7lIdfGO7CjiOc0OuCX+EsIomA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a34cb7-ea0b-45ef-2fb2-08de9c31795e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:29:03.6672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdaC2ePVu8GS1DNlA2/9y/AMdPpk4g4mJJcdC8R9d60wt1Zz3uCs1SWKfKHTzjgRV9c3k4I71ES6vr5FptsdPKEouicPxoLCfZ2rLSjA7Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8076
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

The hardware strap settings in the AST2700 FC machine model were incorrect.=
=0A=
=0A=
Update HW_STRAP1 and HW_STRAP2 to match the values observed from the=0A=
real EVB dump. These values are also consistent with the current=0A=
aspeed_ast27x0_evb.c machine setup.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index d1ff6fbd4d..69f114e68d 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -50,8 +50,10 @@ struct Ast2700FCState {=0A=
 =0A=
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)=0A=
 =0A=
-#define AST2700FC_HW_STRAP1 0x000000C0=0A=
-#define AST2700FC_HW_STRAP2 0x00000003=0A=
+/* SCU HW Strap1 */=0A=
+#define AST2700FC_HW_STRAP1 0x00000800=0A=
+/* SCUIO HW Strap1 */=0A=
+#define AST2700FC_HW_STRAP2 0x00000700=0A=
 #define AST2700FC_FMC_MODEL "w25q01jvq"=0A=
 #define AST2700FC_SPI_MODEL "w25q512jv"=0A=
 =0A=
-- =0A=
2.43.0=0A=

