Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472B7F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsg-0000EG-Qa; Wed, 15 Apr 2026 21:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsK-0008Gp-Mf; Wed, 15 Apr 2026 21:50:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBsJ-0007PV-6j; Wed, 15 Apr 2026 21:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7L7XUuSOxMgQY0/U+KDjbcdBDbgkHJydQpCmuD9QwRpOUmM/FBQ0wlsxac3odcaX6WJOGJmvod69yjuoqFkT1xafa6yx5misjwMpfdcYcWVYuZGfNbmmwXUVv2ilcEJe268KRq6UCTIlSy3/4/sbAvR2v45BPrQl3f7PS0EQvRA/tPRPX9sejMoLe2JVZMXHvx6B32HAvV8ta4XxMwWCf8OZ8T3i/zuv8/4b7MRvPmlFcqvHJavAxJzPwBVe5CiqmFJDv4O5T63f0GVyukjFAMiI58WRM674wo67ei9du79qyderCdMmJELBHH0ccYo4zIuRhfEd6a65DZ/weWsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygTh7ToBfZdOi8sGPc/aXWfB1/AxJP2jnWfeTJmsqNs=;
 b=OWqiqriL0vh7myRzzLZUqOvRdw0UyCrJqQAvOyta4r30IV6cDKpuysAvWgJ2mKvC2JXCTnWZkg3CmRSpErNzEr1ERcmrU7C244GIZavQLQmUDa/R3ld5R1ZCNQ7t/6wJdUcj89FUMCvjlLzQkGQCj9mLEB0hDgJwu2js5N+0HArlkppw/mwIDDj/IfTzryUullFRlpBngz9SDFEgK2jePdKLuyKDbKCkO39AgkUKL6hYAdpQ/WdQJO6hNLMd7HDZfZ+a38hG0+PIOqhgoV63JH3WZbpQPRLiCO8T3XVTWsYfTsGjIGwiTf6W4OyGmytHvEiGCfQGHXJ4Sy/WbUfoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygTh7ToBfZdOi8sGPc/aXWfB1/AxJP2jnWfeTJmsqNs=;
 b=RWtZ9cxFKpiDyK/AX2xZbHtkMro16mlhec1WEtNxlHGr6ARDMx7XQVdX+JdmH2ZUxdcbODE56Q/sUDMFfhx1fNa1TvX6LZxhMmQRTqC+Su99h+NzIIxQ6Did33DqXxAbR7BSsuOcWwvsQrmN1XnsEG+9G3J9ywenOZothlO2mfuApmQpNrgEq9+zqZz1WV4nIfkGh8kJcZ2xRfHsQzBIKrFeLfhCTXSr+LjeSK/hkWWWcl3a7FGsWL9eIGvCxGPQuJCvlL3aVYEZbrP6JcX6ruCysu2FJxnz1rrKUH24RFKFN03fz4aE26IvwZsfN59bvTgXsMbKyWs8aAGs8Y5bgw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:50:02 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:50:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 15/17] hw/arm/aspeed_ast27x0: Set EHCI descriptor address
 offset
Thread-Topic: [PATCH v3 15/17] hw/arm/aspeed_ast27x0: Set EHCI descriptor
 address offset
Thread-Index: AQHczUNW47iTpoljY0OGKkDOuhfdPA==
Date: Thu, 16 Apr 2026 01:50:01 +0000
Message-ID: <20260416014928.1279360-16-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 58fd51d2-1401-43d8-297a-08de9b5a7968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: rnbUFnTkC5EJ6tKiPG5Q4OgO7fPLhgdeHvWu9BL5l5fhVpOEXD00CjXHOK0tlVrQOuKCqcRAf5CI5/Nnr7zGtiJLZe1ex0pBV3m/bfSy9uZbh/DXrpg8VehYtHVfKauUyC3tLSiQbKkGB72tzFNrmpQCAMjTrjwp3LDHnk/k6hDFH9YkvHEnG25OghOvaAVtJrqVlh2f3TGQ+1g8gmXQsqziVH7HgU7roD2DdVVbBPMyxo7qAiWKv90ff6UyueuB9L0ZteIsk/js49+LBb8asWfQgz6Oillhcv0dNiTrgMVuxdV2jmXpLYdxQN9rmOzpZl+370VSQtbr8u3bqmARQOftQWSiI+utz8rFH9aTA3kbHxISrhj7gOjBXR2CO2l0UdUy9C6n2PVkiFgI4gafuUJBJO159I/HqLbLBJse+fYrLSLRo3+G261khQtXRWWbROGWIwNKl5rpRTQX5obcn6+/rFNYkwUIQNZF0U8qq6VIv6m5RLcZRBc3AM3ONUi1SM4pFttyhoPG0p3pXdGsDOV1AIX4jQaTvdtYLUm4KjcWk2rgaVGKWwNTYXP7oPgrNOfPoR8jelfEWi4h7x2Y68HXOgD9/nyJg9ttABSrQcL9/mTFxQkTECZmiflZkiQKSQBCYiT0Ndsd1+v+CsOrA+DIsEtdStY5M2Z3AZvDI+OIACUrMmNmRb6uL4RVKHrT+rzAypXrKW5HNIxK8HafDqg7s0XeQ1SN+KM8XY50E9eyUpgmX1QNcJTrL0HMhQUQFJUwNKsa+C8b3vva+gZ6GK8UOFc+aVDKf+MjJxTeB93/OxRJIa37yGtyEDJjySe3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gwQta4JuyjgkHdFPARewq03xmWaagBoab5jKOTLEzXHZP7MRU0OSqYF7jG?=
 =?iso-8859-1?Q?9zNRa+t7UkHMSIeed25XpFnmUGnIUlU4ctrCzNKf6Aox4pJfMNWWaxpvLT?=
 =?iso-8859-1?Q?1lxCjJTntToKuP9cWOX42JYJgYSXR1W8ADIhI4ND/8mYFmPUsxtRVllzHx?=
 =?iso-8859-1?Q?Itsivg4UwSRyNcyauikStDTILmsGgkkgsI54Ja/MqKORFXA7oq/C6lIB8Q?=
 =?iso-8859-1?Q?cTUh4cqF9PLNNSwBQzpznopBN+HdfaMcT3BHnFFtH81+DTlYal3jZph549?=
 =?iso-8859-1?Q?KD7OcQ8lUx5T1Ed3M4FFTmYePWmg9QVr71A5JHh5JNeJ/bzr3s50ubYhwQ?=
 =?iso-8859-1?Q?exKp/9EN3wIy1mDcjZoAH0sXDOSFv5/TIx4VAG1vwsnJk1ErP5xBuHICo2?=
 =?iso-8859-1?Q?QEFicgGASbVTa55Qi0Za1rlzTV2Sn4JAX1Gm3y65X2lwJFU+jp0f9Jseid?=
 =?iso-8859-1?Q?o0n4cJP0HHUPbIRjuXe6b7egKH7tPLwzdrx4NizBNXp3RjVexA9H45GZhz?=
 =?iso-8859-1?Q?hhxiqcyKwGa00dNylIeLKCY20Zq9dJbo+thpxs9wojmg88F+xTWorXtq4v?=
 =?iso-8859-1?Q?3+wBvu5uvIF7xCi6K2RT5NhliK8dXnZ0vPOi+wHXQ/hPbq1AITTnWoSmva?=
 =?iso-8859-1?Q?3l3mdEKYfGbbKBrUxb1yKExrmJQu7+fIen6UTqNcfjQT0okoIQNbqc2dvn?=
 =?iso-8859-1?Q?SooK4ngGXJtE3rUSKAgpElXdovlvd2bY86vINqkzHjmbkf3a7Dg19fQgF0?=
 =?iso-8859-1?Q?W18bm2uQXNIYESdA3CsvAg7eeWD3wbVVe55rSALJ0fkNFgZl0goqb7RjiL?=
 =?iso-8859-1?Q?LXhAGqvOQyMAtTbfqp9sgPesVuXvbc92j5V6y5Le0cmTL0/p5A04++omzG?=
 =?iso-8859-1?Q?SUUwc2ARhhPNlTPXe5JpKg1ELwW9c67tgQSo2YAh932J1sBeVOY3U3AqKN?=
 =?iso-8859-1?Q?A48ZHaWWagMsWRZtQfpEz4jGlcuGEWmGcdAibzzwaJtTB+5mcIA/BfSphc?=
 =?iso-8859-1?Q?mdvKj63ntalgC4KCh6JnNHvxYR1yKat1aEKIZaYVj8Mm0QLrN+JrHOUceo?=
 =?iso-8859-1?Q?TWm0LG1bqBFNIr9n2Rlgq0sI5hlKjcKfQZYJHB6DAmvtIszPK88SMOcxKt?=
 =?iso-8859-1?Q?r+ibMnPi0jT/O5KoIzMNJC4tm5m0qD7cAW4eXPBrUZEBVxrMPhekP3tP56?=
 =?iso-8859-1?Q?NdPdvoUpI4auub0TDyIqWeOUyRKfD0J1I2ynJtadfhofIN5ZAxId9pO5q1?=
 =?iso-8859-1?Q?qZJegKbTVw233dxz80T5UiFSISDxe2Z8kdee9a85PEz+oPN1psO+JYJT1Q?=
 =?iso-8859-1?Q?/9DZ6x9GsjpGFX5L2FzpeRIpf/FsRVaplDp34NDgV0ZCpX6VLNC/DOVOpm?=
 =?iso-8859-1?Q?EZkgmwC4XhoZ5Q8hksLmhjIjD0uyQ9QFtD3gbGWnGtmnQ83/wCctgl2DVL?=
 =?iso-8859-1?Q?6Rg12FqyYOfIeNdwoERy+ZmdbEK7UahgAG1pkiwOq9o+oo0UQGkzS4Sf1S?=
 =?iso-8859-1?Q?qRNyNzvqR0IiAddoOzI3FQGsDnMgQ6D1aTTfBczYN/cLySSYhtTEyINVf7?=
 =?iso-8859-1?Q?RkXqkbW7BnzcXmhGFHxqdLl1GQgm1GfM0B+qqPRsr4G0NXyxNd6QVB+VvA?=
 =?iso-8859-1?Q?gmxrgk9EznFWjfxqt5N/Dzgm3zzWDbyxoZP+t7GVAKLzhGeFJMg5K25q8v?=
 =?iso-8859-1?Q?iElw6T5qlNqeklKTg4PUbj6/B6LbYoQmsr4VOQmMjGT5Xc9iHJzJT+dmsY?=
 =?iso-8859-1?Q?tp+9QvxY0t/43e/23ICkKaPkN/fYsv5zGOeKRK1w2H+nS1+GPS0asElRaH?=
 =?iso-8859-1?Q?4psHmsZt6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H1W9vKC2f+KzJ0wGOlmKpJcG05hELlyFEWcrV7hRDo5ObsX32GKTaAICgLuSVyIQ378zd1H2JuEWy7Q75Xgaqpb74BsBSooP9r2krezJw2XqbucIGny7hpYOfgfotNYS0lNvjt/ym8l0mP2X5Qj8ima4GxavL8rl4PCEwXmGQrqHlTMcgWytTnB3/A/yLB3lrwoRpQq8WgTu8vgM6bOhHnPH8tpG9pBb7W8Ef6DG2LIEwSdz8tKLfMgZIvR1bj4hbkjeg8tmt4RAi13RjatPHYx3zFe49jif/IRvRdZuYgbHpZgrLxrU6axllMemiLL7LESJ3qLN30ptfA68AslAHg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fd51d2-1401-43d8-297a-08de9b5a7968
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:50:01.7982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GF6mXLcChsLqOLjUd5BTaOSSowv1RQ5j6LidK31kOVSjJQLmZbJ0/qz1nKs/Ms2DxPSVRv4Tg/N2sTsosbXK8U27jytGX1+0FAmqW5n1ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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

