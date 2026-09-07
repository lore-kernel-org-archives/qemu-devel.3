Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF86C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWi-0002fI-Cc; Mon, 07 Sep 2026 05:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWg-0002eT-8Q; Mon, 07 Sep 2026 05:20:30 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWe-0001gr-K4; Mon, 07 Sep 2026 05:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht92euiEqIs3GRICQmmMHa5E3hLLNyJnT5/5fCLPui0CfUfyV9FnbJU1u5gkFkwa51y1JPk0zDvLPPIvCv7JV3oQ4zSbOdfkgg7wHU4vSsQhW09HLhCmAqBdSZgeiWPk0kGtGpCdDBRSWam2ryTIAxTSkkrzkDumqr4UQWWpFfe+2I4+vDleXgBZtXvQJ92pdFcx8S9U7AAV/JOkKldUroWMtiBpWB4FxWvV2spF8kd6AbWPbR5xFAvlzhNvW2yR+tr9ufR2IhX4qgCdgsewK+OP1Obc736DzTwYjMbk1n/GTA6K/HtWG/sgSG/ZKgGd2QJKpWQlRKiiU1eIg27PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAsaKbEcunvWuo5wSwV0RR29y2iDU96EA6RdZBfDK4I=;
 b=vsEghU5TohzgmXaDoYjh0TSu6fNtIrD66wz9BpLn/Y8GeeXINsVmErcm2C2joY7XhnM7jr1wHoDlrn07Ur4pDk0hbbtGpgBnkNHJ6irFuDajFbcpEMjjt3eZp7iyFc1FiQSMk5TmiYWZdc6z+9rXGhh3kZdoFyI1jupKC8n1dF91MOxnjaA9rY9Th4VlqScn8angOBDA++2WuSNi0jlHCW3t1GPJQ/oUE5rd4YejCnlpqjzxsT5IhRNPRuKCU2Kcxqc+518c3G+YATUEdUie1Wkw/JlOaR0uY+e9JUTHHCj2eX2u0q6asENGUAH1jtGnysaXamOYaoUzi4bcTRn3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAsaKbEcunvWuo5wSwV0RR29y2iDU96EA6RdZBfDK4I=;
 b=Hrkl17vHmDytbq+UDTe0iIxvgfehhIpZSwd/GPMM6ARDGxvt5jU9y5DjoLniQbP+0HIxrvPhOhUGe7IkqF/XGG+4d9vXtNqVHvV5ROFTvF0llogG3g4VsEWTnQSje9CK1z24E4tXIosH9QIYOKsmrEBhVi+jJ3NZh+gy3lKwKV3HLbChfUBqH5lYLpmnrYUbHJ9blNRpslleRLfqExaEcmxDGn2HOJJrdM0Vo0YDx25LSfoaSHRQbkDP7OXAuE8ijRZIXW9ncGLm+WJSjNeP7plJoRJy5xN7PGa/VygTWqWz37VO7JOf8nuPrpzX+6fnWEjqcAeXsFb9C5RrXekKnQ==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:14 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 7/7] docs/system/arm/aspeed: Document the VGA display
 controller
Thread-Topic: [PATCH v1 7/7] docs/system/arm/aspeed: Document the VGA display
 controller
Thread-Index: AQHdPqoWJQpnQv3bZk6Yrj5r1vNoWw==
Date: Mon, 7 Sep 2026 09:20:13 +0000
Message-ID: <20260907092004.2590015-8-jamin_lin@aspeedtech.com>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|SEYPR06MB5301:EE_
x-ms-office365-filtering-correlation-id: cfcfe19f-fbce-4b34-7637-08df0cc13955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|3023799007|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: KNQ/fbs1D8h8Raxzv/X3Q+Z3b/YE/6+pruAZCU7oTTs4CkDcYsDCPOr5UQvMYFOyvY22j034EaUXtyVHVX+d8K9xELHjWdW+FWf7NlkVqVbNfCLidLGut4VQJI9rdceabxy8t3tPUxchPaAcAAaANhGHjyGr/dsHA18C9TDz3hhsDwQfxGZPoWUPS+yONGYV704ufk+IyOs0O76m1tJoLqZYS9Y2T8yrE6BbZvbUwO4hHLKQqHLga+nid+w5zOOhxmmKAFM1PWcn5AOh5vbmm+xV7Q6SEmxOXFdgxXbR3rXj5r0Q3JASSG3EUdDdVBdTA0kLGvWOSZNXLfG0jx3mOrlLNQuAtv/sWeRe7awTxoh0id5YKSictO8XlW6gN+7jVufR3gZmtSO1zez/AELiqGiHEISchu8qv3mW7iA1OAGCYQ9aKmbEc9ypVtFlUmvLsL0tSmx3yYVx4gB8XgcPgAZviCb7Pjj+P9j7GMfmcQyRPAWNXSfgHlhp4qDjzX7QuWk11CcY3pp5vh39S5ZUizVw6PfB6ZS0hGuC/HLXyKpffiEMecj7i+M+zinXqmQYTiDE6x57WMjDg25qXhPB/Fq+spaQp3k651lX95cyp6/zdTD9Wf5pyzLqmDrmj3A+JWcM7IatFgq6U42ljS1+QGj+u1Cc4jKvVcP30umapB8xOiIqyXKJ7NkrFqbq9KFk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Kq9r5eTcFD+Qfpgny8n50i5QmigPXYx7/dXuskJOO0MY1jjL36DGdKtZFT?=
 =?iso-8859-1?Q?zEkP/dYhqUxqR78FoFJOKjOdgPjpXrHgbPPdHpGdqknnp5JxxEvXyN1+9p?=
 =?iso-8859-1?Q?s0hEY/xXiukpeJGZhB5ov3tUtIg5xnHZGix2QcgKhQzPEuQtiAoFENnAK1?=
 =?iso-8859-1?Q?jT5lP7O+BS6EM+s5Uv0aF4EM1LPsy2Vy5NUImSz544Q42Y9I/tWuqnuFOE?=
 =?iso-8859-1?Q?rez0/7DqPDFlv6upTEgDxjdj68iR0C6aaaKYGgCEH0kB0y/9udAZDvyUx+?=
 =?iso-8859-1?Q?pcO9nphG6PMB8pHFi1A1FMHmSFRSaAIJWolHXBUa502795PPvvinuUdM8i?=
 =?iso-8859-1?Q?1x3T48eO2X91m9Gfod+dbbAWauqDD8vUYEqi6Rty0kKNtXJUqTWxjYjfO7?=
 =?iso-8859-1?Q?PKZDRnsaAHPu3qTuPP82lumVintPOpQ0VOjm33KlVvGIk3PC8T6zZMN/yf?=
 =?iso-8859-1?Q?rln8Y4t8WC3k0NquDBdBF9sxa1noCXaKyfYmy/TYROzUyW55NLylLF4Zcb?=
 =?iso-8859-1?Q?Gyd6bHSPfw+GsuM3DQ3L71dGxE/lLqSPbJAZYvL1OJILAcN+M8jgwZnFtx?=
 =?iso-8859-1?Q?l60AhyC0YvFGJzrQW27bEz320p/zJNjHbJ1MEgjas8wr7St2Q4OHxlD8+J?=
 =?iso-8859-1?Q?6T8D9E6rl7vtH+jFu2MIHGaWi9DJ012kT9InNuTNOoRTsNZODMRV4I/Mju?=
 =?iso-8859-1?Q?M/9f9a9NZvbULgQQBR3FTiXaJ2TRDT2oMhyqm3AIuUMuetLTrkfLbCyfYE?=
 =?iso-8859-1?Q?wVIj4X5NmMtMYL3v2SzJFMbB3VjiZDwAxP1RZhu2HsAycGpN+bNkLEXqSK?=
 =?iso-8859-1?Q?Vnwg+zLfw8uSi3r73ZEBx1w33KPnsoVdt5LPfQxco3YMq/aYSbOkxA3YtP?=
 =?iso-8859-1?Q?tUI669riLFij6O6DXbjCf1lTJJGIR1xQl/Pd83z5lgkMOCZYcdU6ETlbYN?=
 =?iso-8859-1?Q?DMtsFuy4IFWl/KY/d9ETawob7PGBY1piGZuHVqNzosmDLpVuc9Lp27PRN9?=
 =?iso-8859-1?Q?mNXWkolMMtABIunab06uP/X/lk8a+Sbs7m/qlyiuBf2UzGxfHj4Q7YM34O?=
 =?iso-8859-1?Q?aiwmAWWRB3qmQHr9xObXnoCeNKW04DFPuXGwf4AjWLcmCV6uxq4FYYpVb2?=
 =?iso-8859-1?Q?g19ttq1Pt3z0GH+4t42nAYmmAc4I7S1EQvrKh1nRwZJQKUFtNTXIi9GZjw?=
 =?iso-8859-1?Q?m1tKSxP5n//HWODZIVl0phZHwGADulCE3Y4nJW6rZyfhHagvzeP0BaY0bU?=
 =?iso-8859-1?Q?P5ccWwfogHbqdLzF167pD7K4FIbI/g49kLo5cEQDZYn4x46UyL4b2Ax7/7?=
 =?iso-8859-1?Q?1UXGvpKbq9d/oaXJ+a6RJPblDGxIvBj/BHO5kwpi/7KphyPlEKCTvHESy6?=
 =?iso-8859-1?Q?07Anwx9QmoTPbRLfVEh5GJHcGt6doBcGZsfJbTr3C8DK4BUjFEo+fOK/dF?=
 =?iso-8859-1?Q?jbl/QqVuhFmliJ5zItpk8NTzwrAznD/wdWd9sGujdiiOflfKPsVJbXfavS?=
 =?iso-8859-1?Q?cKY48/pDdoOIrzwjpxIS3bbyOlznSEskA2NBhB1lepf/dIlLf450X0xFDp?=
 =?iso-8859-1?Q?qIUqKDLXsFuMCDuFHX96g68Y/VgpPexU+7FCvUIOUU2yl3EOx9rJhHY6Z2?=
 =?iso-8859-1?Q?phqYtcYlQJzc9i9l9rTbTOodGHhqa3SlO6/oB0Kpu79MwtUuaOke7VkJuw?=
 =?iso-8859-1?Q?m+LUVHoaNBr51pDqux1RQ2PpVPfwjDBI+QnP9TtJF98XO6umdaJGsbiqJ9?=
 =?iso-8859-1?Q?t8xQZRBeN2IsU2peZt7Rfrwkf0jym87x8V0UGfI4G5sCjsv8PC4YACjKdI?=
 =?iso-8859-1?Q?+4+YeZFDIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tqVVF5e7FA477sjj9yS0yZAgqp2Cfdvfa5tRqbD4tLoE8qXYwZwWLiM2CzvjVAlVUt6klK+ifCcKsvzVIeHq7jkLXnkPwcLB9eTlOit1YLQIKpUKCeoI/IgLa8GAKCzN7yTB+2jdW0Aa8PRB+NlRqkucyOoH6qmhZldtur+6y40pxTvMVfCsO8dzjnKa61OMHDgoNnEBjsyU8YdVRLd3NTDDLbmO7/mRYHGx7FWqSGbdDa95cWaanzBHgV3zD8cG5M0zCNTGSJ615XRXIrKT5V9Xes+EUHkWTAHuNdxD0MP5CtOtYGEM0IJ0j8u/1NWdr+coa3G+MQcPNp9O0vaTkA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcfe19f-fbce-4b34-7637-08df0cc13955
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:13.3159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1GmT/v+j4UdT/08bHxpRkXSmusjtAH2v/XQ30CVpegb9UAy4lCFn6dYW3LlwnP7Z7Ca3qkLBm5YAHOBWApPLF8JIKirKK3DUgo2DQOZbZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

The display controller was listed as missing, which it no longer is. It=0A=
does not belong with the rest of the machines' devices though: the host=0A=
reaches it as a PCI VGA endpoint, so it is plugged into whichever machine=
=0A=
stands in for the host rather than being part of the BMC machine.=0A=
=0A=
Describe it that way, with the two flavours, the property that sizes the=0A=
framebuffer aperture, the option ROM, and how to reach the screen.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 37 +++++++++++++++++++++++++++++++++++--=0A=
 1 file changed, 35 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 2d51ceeb84..0900b4202d 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -75,7 +75,6 @@ Missing devices=0A=
  * Slave GPIO Controller=0A=
  * Super I/O Controller=0A=
  * PCI-Express 1 Controller=0A=
- * Graphic Display Controller=0A=
  * MCTP Controller=0A=
  * Mailbox Controller=0A=
  * Virtual UART=0A=
@@ -319,7 +318,6 @@ Missing devices=0A=
  * Slave GPIO Controller=0A=
  * Super I/O Controller=0A=
  * PCI-Express 1 Controller=0A=
- * Graphic Display Controller=0A=
  * MCTP Controller=0A=
  * Mailbox Controller=0A=
  * Virtual UART=0A=
@@ -512,3 +510,38 @@ To boot a kernel directly from a Zephyr build tree:=0A=
 =0A=
   $ qemu-system-arm -M ast1030-evb -nographic \=0A=
         -kernel zephyr.bin=0A=
+=0A=
+VGA display controller=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+The display controller of the Aspeed SoCs is reached by the host as a PCI=
=0A=
+VGA endpoint, so it is modelled as a device to be plugged into whichever=
=0A=
+machine plays that host rather than as part of the BMC machines above:=0A=
+=0A=
+- ``ast2600-vga``          Aspeed AST2600 VGA=0A=
+- ``ast2700-vga``          Aspeed AST2700 VGA=0A=
+=0A=
+The size of the framebuffer aperture is set with ``vgamem_mb``, 32 MiB by=
=0A=
+default. The device comes up with the standard VGA BIOS; pass ``romfile``=
=0A=
+to use Aspeed's own option ROM instead, which can be downloaded from=0A=
+https://www.aspeedtech.com/support_driver/=0A=
+=0A=
+To plug one into an ``aarch64`` guest standing in for the host:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  $ qemu-system-aarch64 \=0A=
+        -M virt \=0A=
+        -cpu neoverse-n1 -smp 8 -m 4G \=0A=
+        -bios edk2-aarch64-code.fd \=0A=
+        -device ast2700-vga,vgamem_mb=3D32,romfile=3Duefi_arm_2700_vga.rom=
 \=0A=
+        -drive file=3Dnoble-server-cloudimg-arm64.img,format=3Dqcow2 \=0A=
+        -device qemu-xhci,id=3Dxhci \=0A=
+        -device usb-kbd,bus=3Dxhci.0 \=0A=
+        -device usb-tablet,bus=3Dxhci.0 \=0A=
+        -display vnc=3D0.0.0.0:0=0A=
+=0A=
+The disk image is an Ubuntu cloud image from=0A=
+https://cloud-images.ubuntu.com/. The output goes to the VNC backend on=0A=
+display 0, which listens on TCP port 5900, so point a VNC viewer at that=
=0A=
+port to see the screen.=0A=
-- =0A=
2.53.0=0A=

