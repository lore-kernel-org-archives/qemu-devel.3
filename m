Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DB9C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0sui-0006A1-L9; Sun, 30 Aug 2026 23:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suY-00067S-Ov; Sun, 30 Aug 2026 23:42:19 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suX-0006yh-73; Sun, 30 Aug 2026 23:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euz7wP58wPLLTsdrVeAouKGsjTSAPHC/l4KVa0n/5RS+qNVqTm+LP/Xhc0Yg/6GGIr4S2r0mgB8K+n5K1CKFZ0Wv6gNsE1YAtitd7asgOD0cJ9RxfVSth/fLBd6VJQ/maJiibW18UZxpMzKH75pZcKxHxYD6mHMqN9vEosRgK0+KnCEJfT+O7G+08MikIUC63a3n7aWzXM0oz8iZcJttcFGNUCjrskxJn0MhT5RMgUlfStuOrc7xogqlXCKlUXo0T10bWGa6U16ATKZ9irTYCM6kEMm1bZbxSk0gBmdYz9CKnbNTMgtZQ9cVAPG25mWBJKIvyzl4N95kD/FuXqO3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLh3qbry4TnrTdKx4ccYTK/Fi5KDO/milR4FSYxDxF8=;
 b=rn0pmHoNWM5sqszgGm0ZdcG1lPeX8WEfyCD5fTtWYFqDcvH/JMZBRSqad9LdHKjFUdpoYzIBJ2faEtbTJlJz+0ZUKn+DciyphzeJ9Hy3rbzEJIj++vdwXPm87Huzj2aiY9ulUnFLYw1kBn3wYNxplLPMb+Bai9Nv9MgSCmpASqT8MdX081tztgjwbFDG5yoPZreG03dy+WCUP9vPqKUpKkl9syUFyBpQkv3pfUzS5uqfXGiFoDGlA+tzn1llpyChJrs01unh9WJUnDh8DkgrPGynMwn+/z/wFgv+ozAith30p7/VlvMWjoayS+pKQx0FcVg08+u0QSOSmFFnLIHMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLh3qbry4TnrTdKx4ccYTK/Fi5KDO/milR4FSYxDxF8=;
 b=Dum0ivO8AL6KVXYPl3Udqc7CfJs7aCcj1+9NcFFG8634/jraoyaMyiwmFU42tKAYCJi1Hla7l9TqzMSM1g6VyWQV/E4eYzO0FcLPzhDdma3yjl8JoemOXh91mUsL7MQMCzf/j6H3tELmc8FMEXyQYGO3zBqbi+RQdfyU66n/AnNEegD0dl/miHh/V+Ibr75RNxwS3U5eyX4d9fu2SXsF94WSpkicqHs6nmoFOhzAPG3ietLkMY51YHGHcRPNUGbRv1cqPQ9h0pqjCLXQWftTft7v/7MIqu0Jk/wXAN0jdCMzisO/BaijvvJL1JgR+agQl/3vQsaHMBafK9O0349n9w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6164.apcprd06.prod.outlook.com (2603:1096:820:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:41:59 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:41:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 4/9] hw/arm/aspeed_ast10x0: Remove obsolete unimplemented
 SBC mapping
Thread-Topic: [PATCH v3 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Index: AQHdOPqtd5QUDj8ZqUSVCEfgziBplw==
Date: Mon, 31 Aug 2026 03:41:59 +0000
Message-ID: <20260831034153.192916-5-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6164:EE_
x-ms-office365-filtering-correlation-id: e2b5121a-0708-4922-5430-08df0711d00a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: sXQGE8dyC0jqGlHsLU3D+t6iO9uDbFc+xFvYvyKcu9godQ9xoWMzMtls5bmgb+uRH+WCKHe7MiA0YHdURvFKLkAPZlzNUy0OHTl7QChlZXL9y+iMyVPzkt8szga1SQ4oiO6hoNL5WEid+iUWSLa8qYgI/aE8yDJIdu0UNdsXkRkjVhHQt4zX43c/RbcAaA9rLeHSwfZHQMuGf3I3N7aoEriIaDCGSIEoEKfCNZy0gzYak98M2FIvhxs4JSOS613Zoqr2F0z9YyTZmNq3LgtG4XC8N7KKwK7lSESdeFZGz8uFJ8uPBbEDKgi92C4N+yMVIiX8VAanUrm7T/T391ybxGgpqQ9uLILkAJ418hqfTNXlSpd5ZsAGt7N7E3Bv7JpwXBiy20lMFUl/lWIclNAn4V9ZNU6BSZALnvd7/5ni22/r6hq2aER/9YXWBYWc3BXEMvX/2OYxgOjxNa+qiF4+xaAKX+U4ASQTHO11SJzI1/b27j6jYRY2W9AXAV/lr5QEgwYL+Whn5aZsCtv0EvnZesD94Xt3djA8tby3y7KDurPBnZNrt+AS9CwXfkqgbWJMiON9xOGgejJBQIsJs+Q1YL52LfCE4wzvlg05sLSsaKFiTYpmWVH27EokeanyLPFJNFaz6mWHTD8xxZSBosHscQHmqkRgCDl25dDsPZ9Kpv5RcU7Nyy+kl3wp+UKT4P5Yh+mG6t7snQGRNwCtHIJAArAGRTbA83CHz/DSujmKgnY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6212aCtio61YjgkYXnhUMuTTWLYFp6wbM783xKUV8QmlsugdorWRRCp6AV?=
 =?iso-8859-1?Q?aqNAc1VWGecK8f9lL4pz4SjX5vQaihUXkBANJ18CExBaF7jT2X9m/vYmWJ?=
 =?iso-8859-1?Q?Fx9kQm2mnhXeiGTPX9F6kLUGNnhY8VPY7gBHZscK2ilhxpARS6Dp0Yn7+l?=
 =?iso-8859-1?Q?2KDtxDeMKfUMi/6cOAzR1JVCMVM8bXtZdsX2+X3XGTC7X/zK0/m1q9BqXV?=
 =?iso-8859-1?Q?8XQlz2Nw+CBOCLuGp+qURsD9BDXl27EncFN759f8EK24g4oXgfk3MgtHcR?=
 =?iso-8859-1?Q?Pcz5Jprm2EmGGRofrYjvcM+EoMc4w2YKtX0IOGKT29MdpbUblGoTlBkIGR?=
 =?iso-8859-1?Q?VF6uoczjmgKJKLLhhw4xYK9s/FbbRMrS07eKRlYiUT7WJAuwlApUwNI3lR?=
 =?iso-8859-1?Q?HM2fKVJpMhVDFoSddqpbdCRQZw9JOjmzcp8bPl7RV/nht+WfkMOL0R6ABP?=
 =?iso-8859-1?Q?+4Wyp+rI2j8A/Uq3+kHNyHaC2BFMCpV8Rdiyz2dhsIST9IFugAM7S2GmPV?=
 =?iso-8859-1?Q?axO48dIwkgNhGuwuBXVDOL+lPNyb/N20Z9EV14RRCZlVySL+mDJpPr2sFJ?=
 =?iso-8859-1?Q?ponVNp1I7uKhwlp4+9zG4htTLt6vqr6ug9B53RaSZpUTX53rbWSYr4tzET?=
 =?iso-8859-1?Q?9FP5xQU8ExoRVAZgq/0PmTDfzYYOmF/9oyWsuUPSJiLqcm1DMyl3U4KAA1?=
 =?iso-8859-1?Q?hzWH6s4fELc/aBboF2cgRczPMvyB5RXXVTGFuvD6TnzqjE3oadXpOPiqFQ?=
 =?iso-8859-1?Q?Rf7OIKY6e8Ye2/LGoUJDX5YuhDFdPt3nSDfZWtjF4lE8s3oFHEwYNic0Ou?=
 =?iso-8859-1?Q?MS8obKEs17XmqFelsmA5Smw581IOZFWMys4n0Vqm9Q8eURW1xAn50XIIQ3?=
 =?iso-8859-1?Q?lMWU5zA37DWk0e3Xn051EFFCy8SM1K/3pFIDGcKIshAcPbzqW5Ly78uodU?=
 =?iso-8859-1?Q?30fI8XqGN+5J/emM6ME/rnA0Jn99CK/08pA2MWP8fYYsclnZM5Ac3xLKXj?=
 =?iso-8859-1?Q?irSOlAAPeVV30SNFT3Ir92veJw7WLTVOpqwjwvqGhKqaqNPl3xo3uAo5l8?=
 =?iso-8859-1?Q?jiahGp2a1Jo3Qj/OeG4xSFshXpLumY+eoSYyUNkd/wz82sC5hu04B1l4UA?=
 =?iso-8859-1?Q?dB4GXo1dvxf2cVQBI7vwaPCpApJBo0WUToswJgkiv1wRzgXjllttC3VG0r?=
 =?iso-8859-1?Q?esD0AaN+NaZSqQUzpHbFDIYIjyC7AJO5S1Hzp7M29tGqe2EABcevyV5NZ5?=
 =?iso-8859-1?Q?npgMsbGdsOYn+opMAh27Iubr1bD1NUFsHRsZW/++43fez1nW2/n+Olyum6?=
 =?iso-8859-1?Q?T+hXmNPbXB0W5OQkMcqUv6XwRjP2bVohZOOz4z09JV1t6h99w6VkOj+mA7?=
 =?iso-8859-1?Q?nxwhCDHqG7rxyOO/a8xkoEgS0bREhYoqSIgvXju6kL1BkMkruqbD8JvoqD?=
 =?iso-8859-1?Q?KHe2z3QndxJVEt+vWf7ZO+kJqMkcu8q+HSVqzvWEL6hxrgq0Z5YheLdA8N?=
 =?iso-8859-1?Q?vRKipL5ooS+zYL4psGkS1q0PNSMnWAJ+m0aPC9iSgtjHeRxfCp3gKsLL+1?=
 =?iso-8859-1?Q?MdRi8+8P2HAFKv/HeqjPJolzppGcgnZnfru4txKH59/FxAHDrEyp29112A?=
 =?iso-8859-1?Q?ZUQHEqQ5DYpJ9vc+hPF3SF8rFVEo5WKR971+tVu+smxsXmz0JqpATa/fZv?=
 =?iso-8859-1?Q?/mcPnzmxZ7+DbgalwYIE3R3eqxjm0BLgibYGVzb30wmaEEeYPb/8QaR6AT?=
 =?iso-8859-1?Q?KJ7dTAZQP2+mfiWjv0aQMrVZEAHWHlk1Nd/V8EbdyXhXH5WVqxfKnNX4fv?=
 =?iso-8859-1?Q?LkIDTjdLqA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FsLJWe3douvVdKXDQ1BIrvzKzzcQzRSEEwe7alIBxmtmjeE4tE4bT66RU4Qx2Rjyec2JLV2jN/cdZ7xc5Ft/tIsiPLQ3/IXulzTkPnTd69A1Kdy0az+C+JK4ikAIGsfuagvbqLt4+dye/vLcgXAg4jdBOMxmTWRnDJ+sWyVZaDMuam3zmUEaeza/kzkeG6weHbYvpW/m0UXHQ2qS/Q6CbJCTkQOAANqSrLiS2FNSLmKGBYP3kozmd5d4v1ZlDO8pHFGAa1njX1uQF+kMPGqxkancGbOrbEuto7e92qvilxEiuW4zZ1IcDjQgZAmRL9YhagL4ofqGh3bk6mpy/Ufrrg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b5121a-0708-4922-5430-08df0711d00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:41:59.5915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUaJgVLR1Qo8ZJlxlXIsO0TEkWXhIrdvyr571p3Ki33ooBqvMfEg5udNPVzA5Xxiu20MyjdLMO879rV+EhobvgX9ojnWfwdv+9wSqAjhYaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6164
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The AST10x0 SoC now implements the SBC device model. However, the=0A=
old unimplemented SBC mapping was left in place.=0A=
=0A=
Remove the obsolete mapping now that the SBC device is implemented.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast10x0.c | 7 -------=0A=
 1 file changed, 7 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 93c81195b5..5165dcce59 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -163,8 +163,6 @@ static void aspeed_soc_ast10x0_init(Object *obj, const =
char *socname)=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
     object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DE=
VICE);=0A=
-    object_initialize_child(obj, "sbc-unimplemented", &s->sbc_unimplemente=
d,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
     object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
@@ -222,11 +220,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
                                   "aspeed.io",=0A=
                                   sc->memmap[ASPEED_DEV_IOMEM],=0A=
                                   ASPEED_SOC_IOMEM_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory,=0A=
-                                  SYS_BUS_DEVICE(&s->sbc_unimplemented),=
=0A=
-                                  "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC]=
,=0A=
-                                  0x40000);=0A=
-=0A=
     /* AST10x0 CPU Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
-- =0A=
2.53.0=0A=

