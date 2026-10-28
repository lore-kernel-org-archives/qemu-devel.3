Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7D606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=FAMBqoNU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtTE-0004ZG-Td; Tue, 27 Oct 2026 22:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSh-0004Qb-4C; Tue, 27 Oct 2026 22:32:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSf-00082k-DM; Tue, 27 Oct 2026 22:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS1bGE30iOH14L/xrktHFLaeOlqMVHlP3JPk1Waw/BslQDeJYqnwiq+gg3vXeNxIDwHut/M+e2Sc1j0ZIx2XoD+kz23El6INEZJVeMjGYsh4e3SaBpW9U1ZPBjT+7o82THPpZv7uSzFsnKGW++5Nf1DMliX3o+ikeZZJqVqqd/mLGDW6NzZ2J7TSQBpeoKr+C4sWUWABR5FEK0CEo0mE5Tj2CIPJFgeEWGciQ+Rh7nuVlDuSLD0TLBw2QoflqisglQnvNJOajeKZDvyDgteRkvMRYX9DTAuxSc4Sn61viV31ews3cKX1mB+z6McyYOE6k+JvcIl75nVtRfRQkji1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK1n33dY0Ap6ewFhzzI37fzA6KhjHHsd8TeIPyls7E0=;
 b=kVmcC5wT+gpgISleRqWAwuYQLOZG3bZ0IyGSRoFEbnjP5TzVOtbctk6g5i9u4TOuKen4laO0BZLg2Wmk3s+sB0a/QF0KUlNJQc+ZG6fuY1t5hHHBF+XUMDPkI+PJLvH7FkQvu7GW6F5k/2V5jTueU8WqD3zg2zyA23ZAkcIk76Ch2QIkNLa4yhyGLN/YOZrrMnFhN6d04NGHjD7cHblgSdtKvPd1Nu071OWXYrwSKKKrKBHBsa33y1dpkEAnnn4jI0FvDN4ItY/c9drTSxJwWmM12iCWkHOId+lKJ/2MPO760Sl7145zs7QI0LF7Mdv9tR5ORWeJE1Z6UDLddMgcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK1n33dY0Ap6ewFhzzI37fzA6KhjHHsd8TeIPyls7E0=;
 b=FAMBqoNUubKLGhP5MTw0SirTyHm0U39cIkL9iCFGgOingZO5YpsVl9LfifJk62HUXcRShbU90mcXhRYKuHBo2vTc8YN6UXobAt6k6lbdXcLuo/WI1p/Rb4wdBNdXvqF0n73CoTf2p77KQXmPGrEa2MBsIuWwt9r1wchwCi42N1bA9XA/mQz4b5JZ5b9NVF9jnWxDBbSl/PqPVYHlZXiburZcqNUA6u0Z2FtgFHk3D/Jbm+eN8du83BxeO0Z8I2SfpJSYd44PjZFcjkfxqUntAV6+kZ3kPSmtLoYhnozT58FDVHcmrXYvwtnzNhnDyUiKlyrcU5vJNEacmOgFZxWmDg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:02 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 07/13] hw/arm/aspeed_ast1040: Add FMC and SPI filters as
 unimplemented devices
Thread-Topic: [PATCH v2 07/13] hw/arm/aspeed_ast1040: Add FMC and SPI filters
 as unimplemented devices
Thread-Index: AQHdZoSDmpy5gjTQQkuL9RU4+OXyrw==
Date: Wed, 28 Oct 2026 02:32:01 +0000
Message-ID: <20261028023154.48395-8-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8531:EE_
x-ms-office365-filtering-correlation-id: 6086ecc7-6c1f-4430-457c-08df349ba608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|21046099003|921020|56012099006|261021121427099003|261021123027099003|10067099003|261009221227099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: h6ZWX/LY395TDeNtlVPtSNdnwMI+V2oPaqkv4oJlyuu98vSPGpFbLDZXHAhpKEfdQHtfGbCezzwfMP+RY01O1tze/rSWxLO5+J/u/k97n1ZNnOwVqvjckmR47OYVLFfJZh3i92rN0WhPSxuYeEK2pPLt4jlk6t3TDxoo7yzOWx0k7yHWMfirBjD0vP7QBgbn6Nyek3guImu37chSbGasQYt2kOZx9pRgTVPlH7xcB7qzCi+aRR2u0XDinnuddHlOkbAhE+fZJV47JxhCl+d2l6up70lzCjOdos9GYHKnxYsY9FMQlY/Y3BGun1vutv6bjYWcW5axVLAI6hejK9DoKtc2ka78BsLwO2IEHb2yqvvW2IBrBLkxJyHW1Jt0xn0leToro6WDziNyJ46UBvTRjnwmRVOkMLM3wFFh1YoWaUpi7llDMhag0grxr+3dpiGLwdP43/t34uzWRH8Wva4GqVF1KWuzzkPHXx55rqAVU/LMQ2f8UfCc8k7pI4GesFNIggL+FpCALsZcRWzsyme9e4SoEW9I1p3kZLtphKKQ7ZnL3flj81LcQMZ5hIAH96Y7hvrl5bg8aoXSoBto5R3wBm/3Ddqq2PqVOJZ2n+Rpl+bSC/nJ77A6XfUq9aznp55WpyuBVNYAZd7Jgk6k3tP5de7xqgOe89RKhc7weGR5CsHVUCYlyVuNTjNyWJoIC5LwL6UKpebrMA22IVonUIaAraeaJXYr+IPLxL6tBhRz+hI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(21046099003)(921020)(56012099006)(261021121427099003)(261021123027099003)(10067099003)(261009221227099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?amdxEEhNPr5K+qpGOGXGurQOUCusuIAJB1fO8p92aVyo+dYjEgO3WJd2+4?=
 =?iso-8859-1?Q?yuKIAEs6k4nWOzTd5en3wW8QCdCbKprVdq/70FOSCI5PJEEAtEXdihIIPJ?=
 =?iso-8859-1?Q?b9ra0wSOJq6sY5UyjPCa+yYT5HceBbET8ZEh0YBtOG45/60PmBh/CWtRQX?=
 =?iso-8859-1?Q?acKmJwyNSnoz8SCWXLgj5FQFPo6rIwy66/uwF9XRWBMPDgs5Prp9GN5htA?=
 =?iso-8859-1?Q?qeJY5WkSAxcfOcAn4KJegqUK2WagWmfLKUHgS2Vj4iPWof/gPmQ7JIavfI?=
 =?iso-8859-1?Q?u5rvkXfg3J8GvkdbqN8A6E2HgtoeLvKmeb5AvK5QnTDzHeEs23l6zxHHw+?=
 =?iso-8859-1?Q?he2mB70qzaM+UCELkIYUkuySpCkV1D0OwIQKJURjq1i7kglltLjMDGk1md?=
 =?iso-8859-1?Q?CImpIU2c/qMZt/3M0z2t+hlcoAFGmpTo5z/3afT9XLt7KxSMr/Wn6sBpgO?=
 =?iso-8859-1?Q?gWh2F6VDR5gnZnUQ4Mq7f0LPIQIlrYa1G34sdqDExaHgEBfTNK057iGvLa?=
 =?iso-8859-1?Q?s49U0gOkfuqnPwDmyQuz8yCt9NYOn0JsUcx/2386hZlIxcMqCnga2OUIrO?=
 =?iso-8859-1?Q?7DIuBVOXMkSHT9MXbMs7gjl5pbUuvq+XXdiXVY9hr8Av0lImQKPeWiSkbd?=
 =?iso-8859-1?Q?iIZokH4gn8s7QcByZcQJiZMuOuH9sVINqtinne4X8880FKyCcHsFwl/kwm?=
 =?iso-8859-1?Q?VTywxkNE0WyiKhQc6wHSzM4qySXLxggmOi2gzn/fjEZPiHyIXk4iMxoBKd?=
 =?iso-8859-1?Q?4lRxrUzHQvFEshBM8nsC3FYVY7jH50TyWPlJiBWTxi7cH467QmSTiLxfkj?=
 =?iso-8859-1?Q?VHO9B5FShb3zTZrNm/f6UsibO1lUEySuUwK1ld7c5krrp7vVSYx9aQY1uO?=
 =?iso-8859-1?Q?ACov3lWQaMc6LPJy4aEP0vjPZxdX0jcPQ8Joymtnx7v0sGrUKbaTMVlw7U?=
 =?iso-8859-1?Q?yakHdh60MF3qjGb0Y+wfiDhJHXcNBgK+EgYEU8LcqnL15ju71lT8mBy98/?=
 =?iso-8859-1?Q?iK8FGDWYnxLSejAHMgYncHQhVDjuJODo0ZSg8rWoSbu/eVRv33TOxxbQNU?=
 =?iso-8859-1?Q?QlhfTTecFqhM84PfHVr1ZOqobRQHLuA7A24VBDTT7No5GXLeOrfAG1KhyC?=
 =?iso-8859-1?Q?JITDLWowsJVyx0kV5yAV+Fshz+eQP2Hiq/zG9DmssJOaO0EReEV5YDS2bw?=
 =?iso-8859-1?Q?ZQgX6Rc84jsC05k8zQfcuwQpZaisn+AP1vxZO4t73Mb3aGu8ZZxKhzHVjX?=
 =?iso-8859-1?Q?mmVREAaY60SeqA8R1epX8thu3iRkUjt3zUPJ0AWdsf+KKhu9GibYDLNsbl?=
 =?iso-8859-1?Q?fZORL6+wuMvajoeM4drycS9Dk/6lc+/JwIEi3ZsaVMeXtezGNOUyro8kOI?=
 =?iso-8859-1?Q?HqvtI/kweRRKnq5tCSo6fzMQzo9kukc1RFjBgEt/zvyjQmVKTWqcoPteCb?=
 =?iso-8859-1?Q?IsNoIYHe308KuLjZ8yFhCfhIWqazFLm5tdGwpMLrn3b/4FB1UwX/Ahvakp?=
 =?iso-8859-1?Q?IQMmPJ9qwnQQMl5blRfmkdd/2yGl9F44+WvQkwONZkZ6GBSwzii3aLqfbe?=
 =?iso-8859-1?Q?4Vpy36xqAe47L26Q7ARAT8YpM0wwCxVq0ymF8xToeg+FeZVFGBALgxnUg4?=
 =?iso-8859-1?Q?U7mdRoHU7pxYZCkTBdyHkhHmJuaAiCd8X/2XtCjW0w3OmJcmbY4shl8+62?=
 =?iso-8859-1?Q?w2NvU+Lm9Dxq9xpu6TVM7U9RRtSOJtADDUhT0JhsoDGx1vo0vJR1YBLKq4?=
 =?iso-8859-1?Q?sueWpxriuxI6zaFuuZamnj7OIAVkxZKA1uZsUGZlv2v0vFk5YYU+cqwBkY?=
 =?iso-8859-1?Q?ic4KvdfEHA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6086ecc7-6c1f-4430-457c-08df349ba608
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:01.9837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nqk0NWzLkVjAsmUWyLNdAJ0l0loN32jWZ6rDdqqCcBhqAGjPI6RJY+AU+pXlLJ9MRZBH/REMy7XUG7IkXc9St3D3p89G02pzbUlhI0uhuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST1040 provides filter register regions for the FMC, SPI0 and SPI1=0A=
controllers at the following addresses:=0A=
=0A=
FMC filter: 0x74000400=0A=
SPI0 filter: 0x74010400=0A=
SPI1 filter: 0x74020400=0A=
=0A=
These filters are not modeled yet. Add the register regions as=0A=
unimplemented devices to reflect the AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 6e3b6900e0..5eb091e675 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -87,6 +87,9 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "udc", "aspeed.udc", 0x74120000, 0x4000, -1000 },=0A=
     { "jtag[0]", "aspeed.jtag0", 0x74C01000, 0x100, -1000 },=0A=
     { "jtag[1]", "aspeed.jtag1", 0x74C09000, 0x100, -1000 },=0A=
+    { "fmc-filter",  "aspeed.fmc-filter", 0x74000400, 0x1000, -1000 },=0A=
+    { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
+    { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

