Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F01FD0644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0DyF-0003EN-CA; Wed, 11 Mar 2026 03:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxm-00031V-QP; Wed, 11 Mar 2026 03:26:40 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxk-00053a-DF; Wed, 11 Mar 2026 03:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP+9sHePnNYSAyDZuANTPS0UhSPSmuPjGInkmwDnjJvcX9EVaOJMkBYT3u3CpOiZxRjQCAGM22skdtvESr5+hDQnYRt4BjyXaYakNgkod/iLdPM3PYQEwF8YBUBZu9D1RH1Br5wtz07VxxP0Z88p5viMzstRj9tR8XHZdThcoPKhGQgdg7Wf8D+64bJIWit23gPUWdf21RbN4kgib+mwG33GiluLAiCmIynaH/6FXGdCGVZNmdOwF3nYazR/9HTYqQu5WJLmCfntekAarsFU8OtrljqNxnq/oiRmVvU/zfy5TLk6Qh0ByZDYfCxzCdYeb0xXtxK6T81oE7vVTH5GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KL3ae98Fk7PZAGwiga/B4bfXs/RBAQVntYC0PZTpLM=;
 b=wTAtOyUdAv5ZN67im37Hv+gVfrMTqXPcYslb2AOZU240tFrv+zd478PqUsjOVamM6NQb0J5dWgK3tC8xTRzgOBZJmmW4zDpyNb0FlrzQS3FeiF+fHj+j1mlpsRKKovJqWm2Hq5T0/rOnLZUbdl1qkWauVVyJ7Ea8sloHtyVtqOhGmGsvpx+q8Obm5oaJ8ODP4VcBjLBRPYhapsRdBReP5pa10NQswLbk8ypkz714tOQ4x+OY5cFej21EPZOiREaq3n3OzLdPIMoE5jOlEOz1rpnhFUc2ME1BIinUjoYbKkowmXCSCr/RR4lS685catxAsBRvsb7B0AhRc42tHX+4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KL3ae98Fk7PZAGwiga/B4bfXs/RBAQVntYC0PZTpLM=;
 b=dnIfzwg4PJxDDTSu9WBMyOgKUW0ICs8S5eAi+0dsQ2wMx2fjq9kHqmkshuM9l/ejRl1HKOKxzG1yWKBWY41o+7xu0s2TE0D7PD3iX0gtSI7MO905+43UDx6B0UHQu8Xps11TzOXHOijstF5xK4jgvbuzINa6t/PVR1v0okpn6zIq/He5RyvcU36XLXyUva8GbybJXevx5GFq3XwMv3d64o+2A5sc/mQV9Dd1BB7OoyQLAmpCXtmf3/SzwBRoND+PUjk4ztibtqiNYh+wgYAaH2GhBMIoL1ScZged/h0Lns5YAqepqBynkUmcX66uDcV2VED3XeXw70/5pp6RkkdJtA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5084.apcprd06.prod.outlook.com (2603:1096:4:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 07:26:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 12/13] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v1 12/13] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHcsShhqT3KdGWq0ECUNysepEXPjg==
Date: Wed, 11 Mar 2026 07:26:30 +0000
Message-ID: <20260311072614.1095587-13-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5084:EE_
x-ms-office365-filtering-correlation-id: b39d7b23-a101-4b7b-8273-08de7f3f83b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: cZBjq38Wac4XH9GlfRI8bVWxUhPhdyzU2MTCfhB8IA/J/14gvYxpueZJwSykJNJwlMEEKgnpKHYtUKN3xtlwrkgrqWUVPuT2DFWUpEAOpzy32R9OyjDKC5ie93Sdj4ZOmugRghjwutf4gP/f5fh39vjL1DUQwd9w7BmOUUh+Zf9PKbeOdwzf0lZjXteFVb2YlbVn74P+MgaJHs0jAWw6UDEe9poprcLh9AOpO6JdSP38+FEy9Wdj2yGy9gi4CuqimO3MhpCXNBS5C8Wdi4aDtBR+f9V6bv/hSTD6eIVDAZ0Q6s13Fa27UpP4zH2qjD+aTxatzadgzwH73S8Kx4Bhj3HV3MV9zBVO4ekgq+cKM+kO/0oym7y+yuXWvCLopVZCiMKWDrkpzoLB7g8aDMWLE8xZaRVJ0i4rbYwFyLXogJdYnImghJRtWJTRdStu3ISBgkgK0Fun/UH8M7NF/cYyQ0vTkmWe73JiG0mpyVMtQ5DX8GS1a1EjIhMr/NxYVZB840doxf+q30FyWp2YJIipfHl9AC04RxHbn7gsQALxDg+0D/nkx8YyGS0iRtMVIrvgpuOnBLNnzNcUg03472OYl9V/tUJfwwiqKgpZvd1jm+87sHI9HIoIKrta/XfdKEa1xuSQtJ/+tCsayLnmyw9ZmK+GDoWFgvyEMQvY1/luhryv7dHDxtuwHPSWn1AoykK1rdaSos2xGXOkuU7eTx5W05SYPktp+YywGrzTFKKOu87/Q0QVKy/WWjLoG+/IfOJ6cccAyU19jVl90BCXm0znA7Wn2LOz+SNB8QNJuMjbjkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+IByQcmdcQTOMos8qFqz5ST/jnnl932ju3B5wQiNUB0YRH/lxFHzHV3Bvj?=
 =?iso-8859-1?Q?UgrHPvFM4nyc2xXcUuBdL8rnJJ8vUAp06qJsOS4CUC+YJp2gMw5tqMARtT?=
 =?iso-8859-1?Q?MVcggcIiTaAPcSjJouyqrX2gE1QFWvoL/lp80VNAVLfRa000s/WcFQ77xy?=
 =?iso-8859-1?Q?m9NxB6LvxMbltkjFAxmkDqmuTj1u7jcXh2MsInZeVxvExRagRGNeqXJpa8?=
 =?iso-8859-1?Q?pXhMq1QKiKuDnajMO7iUn3rZgYCtZz7AMz77j1bOuqn8U3gsdwQ3d8ensB?=
 =?iso-8859-1?Q?JeydwRyaHL3AsmBoeQfomMXpSbBshyQCDKmp1ejY0LYSWXoZ4Uyji88iu1?=
 =?iso-8859-1?Q?b4I3fMOdOkODBvd6A3k/PzfA6kXk53pxjz3c1T+CxzdCjTOMcXjTvIWk3M?=
 =?iso-8859-1?Q?D/AXWzMiVixsGETkzNnggpRUpCi+yF3YSL0jUgY48IQkXE/PjG2r3ihwp7?=
 =?iso-8859-1?Q?f6GRh0wZ6WVlYsxuwtx2yFI7cPxkw7Ir8I+7PWYon/dntakJvP8dBGoUoh?=
 =?iso-8859-1?Q?/+EnqQ+kEgXaeM78UH0vCjdK1MRe/vq3fd113xyK3+65CHsyYLw1I0Vt4l?=
 =?iso-8859-1?Q?sEntK0jMnY4n5ZmrsHY8tU7V+wroWM0Zw2Fhkx6vG6ZUgqughBQ9FcOw10?=
 =?iso-8859-1?Q?JyQArjknct1hPNVrMpw3fIkQq2EKEv6qWP8pVXR+mh0+SzsAF43HIi8g1B?=
 =?iso-8859-1?Q?isX6Rdw5h41LZdsx0bNAgQTHvT9P1r5t5s5Zb3398te5ASrRd/OtskF6kc?=
 =?iso-8859-1?Q?WWOMLafwohJI7QweWPjssoCZ8Wt70NR7FQynCC1qW7z2K8t8X4c0ttT5xM?=
 =?iso-8859-1?Q?xuUtFE8iJQ3fhZl2lmDM2rsE6LSR0l/gTCmdKOkyAAKlELy/1cCqk4MFWD?=
 =?iso-8859-1?Q?YR8KYLOXNPULc0ykiA/d7nw5mwR+jifiil2fSGTPsnIqkOpyaHBY1/L+vy?=
 =?iso-8859-1?Q?nLt/DBSg2kkmCjsg8g9gbRmpJcpLPK3SAWbHqFu9fq193/X9nPb+qyKsPZ?=
 =?iso-8859-1?Q?ZKMNnIisqkrbTc+aYz6fm7yvK5CqF/q90XLpAabkaMJ58ERPKh2DM+mGwd?=
 =?iso-8859-1?Q?NHS/QLIm19QAwJsvnjufM1JAbsKxV2L70zhfozX2MUFjSFyKAbgvCbXKc5?=
 =?iso-8859-1?Q?MqxAfu7sDaygg/sybEeRrFZDUIZLi0v42SGb7QouUxHF4uK29MMxZqYNVr?=
 =?iso-8859-1?Q?pcisxLMaYfzIyI5jsbCH43hl91f1tETdrkFy5J8QZ63btA9HMIP4w6ENru?=
 =?iso-8859-1?Q?ewsu2i7LxfI+Rl7pWdIntsj4JbjudDHrM6jlCWgNOTTeIe7zYy3rFkKpUB?=
 =?iso-8859-1?Q?P/X2ENKKDdfdZ0cxcFhvcUIe9ypPClgSu903wu+0x0sSL80Sg3xknMNce/?=
 =?iso-8859-1?Q?+Gw7lW1sh4O8/Ww5l/8nMq/fqQKwcAfcZOp3wa85CwP+Oy2cfwjt8Llryd?=
 =?iso-8859-1?Q?poMxI3ulqL7yWi/goSwWJR2TUGl9hAR7O4M0jMoMyDM15Fg9QOQ2d9R7k3?=
 =?iso-8859-1?Q?vHMpbdBEKaVjETeU7gPUYNqPpSFboCw8zdEi5FXqko44bXFKWdjb+jtZ38?=
 =?iso-8859-1?Q?JP9hmYU7UinHTSbxzf7/C2ZmEet9/EizpDmAd/C/eQ+F0Vj41Rt0mozE6t?=
 =?iso-8859-1?Q?FkN5rd+fE0slHhU6O5B/sUB6B1LnvnANpvIGnBZ5ymHujHr3Vh6ij7J6il?=
 =?iso-8859-1?Q?SoKQJKWyRbXUHolW/9E6Dm6/xefp4/Y3tcYwDMh0O+KvPzwa2A4TsT0wtU?=
 =?iso-8859-1?Q?GwGULH+5DJZBMSLmC+hklJ0tJfQCACNqR40J4CQ33pVmTWXVmpcY3RVg4s?=
 =?iso-8859-1?Q?YIvlQ1p7XA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: juhHa+DqjIEgs0/prUkY6syABD5hkbBx2/5me0wX0d/UOBsVzjS2l47I7jKEcZu5NNjiFeEJMPS+a2NUZgRzaH2tfd6HWb00HTp0S9m7oyS3+eQ258vkL4g6/TOzAxDis5HfcqBGBUhYsQ0T91xIGkL9Xg01gnS18Wme/wSJ8pTfQtLmSkE3Y7ghprIfPFMNgE68CkJOzTSXG3i1797KJHiaw3bu/DOdtkZs6tXwvyc4vUsI3fOq6iVbI53f8w2F0Fb9IHj77lka62e4awvsfDG89I8GHyJrk3AE77PiShaiBXA3p8X2ryxGqSO92zP6dklMM1ipUOLKYBlP+H/fCQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39d7b23-a101-4b7b-8273-08de7f3f83b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:30.2199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrohdjbd5m2HqQ0ASEdfRr9KGiY+KV6Vi1HqyRBsknGH6PbTHZIU+SA8Y7oU63PUn+whD9LPr+/ec66yCUBWyz2pkmV1VlrHqG/ZK0g0Fa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5084
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

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..4a1f7cad73 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,6 +856,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

