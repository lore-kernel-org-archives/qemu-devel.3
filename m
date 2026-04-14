Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD1ED7B86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhl-0003jw-Qz; Tue, 14 Apr 2026 04:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhe-0003en-VW; Tue, 14 Apr 2026 04:00:59 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhd-0005tv-AD; Tue, 14 Apr 2026 04:00:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3fs+3S6WawsiagR6tfsnNHGdPKua6XBhYn9C/uAqI/sPr4wSdk3wezD+1sKbvohFF4i87RziadyxW5tZyJJsuAFYCFml7IKZNovwwFTEEwNoLUjNzZKhJjDBYYtBz7+cNyQLkqLnYr1VA+fA0upcWaml9AvrjJki3MYbFnY1kA+nxEr9T230UsJ+81dlvjsaY66Y8pZcd0HWA7C7yLqMLUzxLD5sg12ibtkj/6BhjpftOHLJwa4zcSsOREzO32NJim0ScRaqfhzg3oqTG+w0AUv+uWSFkvMuUPrMolyKsdWigcQc4w1t7JczrSzxbU6L8lt7HLHEB2YC4SsJHdPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygTh7ToBfZdOi8sGPc/aXWfB1/AxJP2jnWfeTJmsqNs=;
 b=s0Tm7fTcpatLMQi4S7PTlnEf3p76UfC9k80WChzMaw/2UrsnmBwkDbbryuX79WwV0KEOsI8rvqHNH8ZKhYvxI84iofHyqZCxMmrD94gd0TU/KSN999Ib+iWbTYtgQBoVpeciCQSwViWNMYlRPFiXHXvI98uSPKrBH6P4QXcQSxc3iCf69bgKgTy6+fCOEo3XJ6hrpIR5zzbBqa00qFjAZzdCtSxV8lTcOEzY+xamwUgAGbA4/0dGKF2UuOHvgRcjN7bNbZG6BtaFvehH0thfTxtf3OwBvnAhyetzOYp1SsvifzguuysbWMfUZY/4RC9EJB2+8IxblRcJ61lUn3x/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygTh7ToBfZdOi8sGPc/aXWfB1/AxJP2jnWfeTJmsqNs=;
 b=UwVOiFs0UaMynPf3A22p2hvT1/MsCurhLnghiASuczBVb+ywPRZm9q6CXBot+fu2EWve2B1UZWhOOxykMx9n3O3+OPHjvBaroxER1z0/ewb3WyBsrP/mOt0oAMiIkiYCIeU9b/0A7NiJrq7tYxNAvIiO2OIKrv2VK0PcHGMLMCYUJVklWqnSjnwc5c+U2spRgvqPRRn4yUjzM090ZQ846P0kPEMCZ/R4nVsybr20pawgL1nBY1TogCAlCyjkDPGWQmuwzX9T83U/oPHY6JBUcZUg9EOac80kKpge92xU8sTEJ6IaZoL47TpPx/DbMW7ELaxZIyVI1KwzKkGK5LYDgA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 15/17] hw/arm/aspeed_ast27x0: Set EHCI descriptor address
 offset
Thread-Topic: [PATCH v2 15/17] hw/arm/aspeed_ast27x0: Set EHCI descriptor
 address offset
Thread-Index: AQHcy+TLbfX2KXG/5EK1P/Ap3IRTjw==
Date: Tue, 14 Apr 2026 08:00:43 +0000
Message-ID: <20260414080025.3005916-16-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: 2ac972ab-3ef6-44a7-87c4-08de99fbedcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: yFTK2yng30KmUqP7VqBFWmWfMAXCmBcHQE1zZwLNyJHp/dfYKV9ne4F8UFPgyZyUzJciFz+8kFzmR65Kvx/Cqxg+aKo38IC5cR5uO9eFAC5wHSXpmyYhLbxHCRApurJgLTqAKcuR6ghNljVpNgqqjJw/qpziVm7AMsZlnXktrH1XUETWGVjhgylmW6w6CRhy51r8nasnEmbDSPPiIqMkt7mNoEOEvaE7MiTrDq+YYovgJfe06vTao1pG41W15YVv/xUNj7r9crawaTPiV4ubwbZWiBNYkgvrTG5nnHy5PUoMo+byK0pfV0DzVJqF8zN60704prz/82StNZN9yk7OMuseFuPmlDN7XTH00hCv0iEJi0MyKTPG+B77sJSkLZFVYqUWtyNBfZJ/Xv/9FPHImMTiWTcCsAP4PLQ2M1WxlKDYIFMdMPJU+I3ABRPaAC255svrxIwkY1VjaFQrOa1yYbSuPB5CUTQm7sM1ceVDAryI1l9i1N5NURw0k4Mmsh1jxiAguMeHyS2I5Qhc/TCMK6mIKhyL4dLTHbDaHtA8LBLHLUjv5QHWI/9kXnrgrDOG691Td4W4QkcVgDHjsM991O8UnO5duc1RiEWlua1oZbbrZscZTRaHssO1QV8ltpPea3m3hvv3gdxKsp7DCA0FLiUNlS+udM9NPruRLEx0zUlKSfUQhGzCwFYzymzCOpFyU5F1bqW+SuE5rw3WYHqVYyfRd3JinIJ8rPycEwem2bYZvL8mi1rrbOoDNxjsI+2WD2zv7FXPmbxfkhXRsR+E5wTE/f/3228ZUCNT/7+erF0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?on8WQ8GKkoMwq63cqHdz91DipndZyImx0O9u1WqOT3z/VYCcyhHJ7sap8N?=
 =?iso-8859-1?Q?JkCn+zo2LfMOhNGxpkGrsUJu/Jx4vSQuw2Vw9daugDMzoKgprm6U7HzkR2?=
 =?iso-8859-1?Q?iYXUCG1UHTqN060N69P9XYAS375a28TZBhkZhByJvICx8CGEtez/e3nzRi?=
 =?iso-8859-1?Q?+YPsSqsQsUa7/CjDfQob0TvHdSUWF5ZIngsNNZ/ZFfJy8tV9YSN0QFo43+?=
 =?iso-8859-1?Q?VXBmmm1CEdN4R8oVqH7R3iuJD3nbH2NSh15woMfiubYdY7TuL4XKOU4VUM?=
 =?iso-8859-1?Q?QqW82OCWypMJjUaA5rm5aSicriRYN1/wuZVjuRhquwgJ8pUsC5bz15v5HZ?=
 =?iso-8859-1?Q?+dQhDJ7mpCq5pkAu4N4E205wp9lNRMu0yMo+/Bci7KR323nJ5X8fANFvfe?=
 =?iso-8859-1?Q?pgnkG0rjR00yzpO8yk12lt+lej+OdcIxwrV39oaX7hKT999JIBz+SBckYl?=
 =?iso-8859-1?Q?oAvKLn+IToysGwZkIuFFdLCfnQ0tPjLk50elcpMnpAEoaRoDuufFHdl8fR?=
 =?iso-8859-1?Q?mT2oaOOWJ6sf6e5U2n6lyoBkAJTaUgSi5lSynPcH27Ep0Gri3H/KGiAfpk?=
 =?iso-8859-1?Q?Zpif8MkLdgPz2fcriFbHMEn/HWw+TfwSHCR950R6o/sLltDxz+n7Wb1Ggr?=
 =?iso-8859-1?Q?bjM0FhW1n3r7xnIoD5wHtJv6xY99G38vHhp8j7oitJSNuZfqGdswKb+Ijy?=
 =?iso-8859-1?Q?X2XK5J+RfBr1KWxQvcniHkSornGhiBAyICLMjLODXW4azgvgnS6wXUfP4x?=
 =?iso-8859-1?Q?17q9X3uxk6j5xvc6UvBzMDmZz//70ozr/uhMmoliS6XyE1QKKv27OZEYal?=
 =?iso-8859-1?Q?veZjt30K4a5S4ayVPVhVbf8OUloHDR/Ix5Feg2kze1Y1vhkTm25DTF06cM?=
 =?iso-8859-1?Q?bIixqdrxg03zmY2c290nxqzeE6ry8QPMzPxYXfFGzePjesXymqcnwSG5O2?=
 =?iso-8859-1?Q?ssebe2BlyQDJPeYmxD5rz+W3CAYwsnLKJY+LiFtT95sa6wyD9KNUudb0Yz?=
 =?iso-8859-1?Q?Housb4UsUeHnAnoU1kuOef0VPKmfVyrmS7/ii2EX3QJvLfM3tfV41SuTN/?=
 =?iso-8859-1?Q?Oe9+9rVL/X1t2ncUYdQDJYpJQx/4YITGFxoSYVlOfD6wSJ3SCb6e6YvgeC?=
 =?iso-8859-1?Q?5vdzWTRlUnHSFapqZuSLHJBFE9EoyuMNFt9R0hYFytd6UNUUgaKA6HUzeo?=
 =?iso-8859-1?Q?SIJwez5smS7JoCvjbL3qYX1SkqIT47Tgsgkmy/hW/66Ep9/iVQKXQ9ARhk?=
 =?iso-8859-1?Q?7l5cuKirsltusky138m/eDD2J4SDvx70n0DUwkBOzcnphD33uhHzBvSlkA?=
 =?iso-8859-1?Q?8UArlsgh/puW3qshNZ5T3PQPuuL2xNrhGqveqVlmf+fpnY2uAN91NUp+vi?=
 =?iso-8859-1?Q?ryZyCa4HNVC3j7iuzPIPhqKge9g2wx+MSHPPzEqhfQgcm3SYj+ZjMBQ74S?=
 =?iso-8859-1?Q?9AsZHUMlXNrvsBKLwp/hbvBIHGAa0moh5g70a3E7ro3pH1qOcUCfaZooIw?=
 =?iso-8859-1?Q?jHdCmc+5wPYAyIgfzxtR9bM+jkYP7glPUlvEo/4vC3YxO1nYd49LDB/9ka?=
 =?iso-8859-1?Q?M86ERWWni68dmPpe7CKNSoNibqeEVa7P40IpVOt4RxEfwE6M+af0sOYfLH?=
 =?iso-8859-1?Q?3ph21xmT3wLqQ6LeiIV1lwZHzJlbZn+HwEToFP6hKkdM3YaelXXvhVV0lR?=
 =?iso-8859-1?Q?ug6rpxfIjXE4rUtkDDZtehAj9M/5cZm+MYQIWvlgmanZ1+eJ/rdshG2ZB0?=
 =?iso-8859-1?Q?FRS6at8tybhUNmR0YplFbC9W6EWlwMwe/Aok2T2ErUP3l+i7arcwUdkX2h?=
 =?iso-8859-1?Q?RogejuMaqA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eFJoh/C1BFiD4HfzucXFGwjmf0JU3lXPLSg9QCFcMiK9zjZukbevW80i51m0/FqOrPzkFMerpA2TYkhFKX6ZDBR/VbTtD/8nYwHLUfcl22GJ7NT7vz1yUVzFfdQBOaOB+dn/T04nDDiHSHx0dLKhId2kpzhsv4bQw58FNQ1YEr6mA+Jp5Y0RevTyz2sbCff9/+4sZtwvkoZxqBzAGJDpofomkuJZ0vo1D2IcNsh4KBZhRyZ3EjOpe/tFdLiZcl5+1Lx7DMGaR1sPKb0mBQMjyIvDbvg9jI6n6ayVneunP4WxVueV5I24X9EPguaP0oNkCHlPY3WBP671sEXBGJCgpQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac972ab-3ef6-44a7-87c4-08de99fbedcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:43.8768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8iqRgEKSBPwCescAogzjh2PkqhhcCBGBD/xmDZOkOml/RYndvhiniqPU02urVo+UUIlmLy28F5cKjHq/ISIIW9UWMJYpBNBKCsVW43wJvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
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

On AST2700 platforms, system DRAM is mapped above 4GB with the=0A=
base address at 0x400000000.=0A=
=0A=
The Linux EHCI driver programs the segment register to zero when=0A=
64-bit addressing is supported. As a result, descriptor addresses=0A=
derived from the EHCI registers do not include the DRAM base=0A=
address.=0A=
=0A=
Descriptor memory is allocated through the DMA API with a 64-bit=0A=
DMA mask, which allows descriptors to be placed in DRAM above 4GB.=0A=
When running on AST2700, this means EHCI queue heads (QH) and queue=0A=
element transfer descriptors (qTD) reside at addresses starting=0A=
from 0x400000000.=0A=
=0A=
Set the descriptor-addr-offset property to the DRAM base so the=0A=
emulated EHCI controller can construct the correct descriptor=0A=
addresses when accessing system memory.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 4a1f7cad73..3cdbf78ac1 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -858,6 +858,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
                                  &error_abort);=0A=
+        object_property_set_int(OBJECT(&s->ehci[i]), "descriptor-addr-offs=
et",=0A=
+                                sc->memmap[ASPEED_DEV_SDRAM],=0A=
+                                &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

