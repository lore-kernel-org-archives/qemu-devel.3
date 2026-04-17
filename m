Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B440F8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZte-0002j1-Lv; Thu, 16 Apr 2026 23:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtX-0002Z2-Q9; Thu, 16 Apr 2026 23:29:28 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtV-0005tG-4J; Thu, 16 Apr 2026 23:29:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg46N0ofErCtib0vPOBk+YWggcbVxscogAbKdckarFn8WuscT5vIWcZOFz9cD0ZQmJRgoey5a5BL+ecTRu9r4bs7DpxgaHQ07Vd+haafVC/cFDo5MEI1blNmtAnysSWSEZR+ozdaPW7PQvZVFDtwLJIWcqeozASCIwKFNpOysSnYBRBu3bVMBOeqhHDOp44oDIAt+7vR+0mmz8iOU76QkQeI886Eiw4lJAYG+Ffbv2rQirMqhQdePKlUtFZ7IizELTZbW8GsqUsltTTdyLfKTm+i6y4TbNyZLNEVBJcOXghqPg+tdOcaRV/zIFpHOsAWz7Xp6leWM2I8R7xM2ZlWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjXufL4bOZ/aNBLGh8VduVIl1f0gW/C1UYPpjv9Kkcs=;
 b=lLpYMM6VCe+yPiffsjFeAZTXDV6FOnuE7rJMxbXHP+wJbBaMaqnk/7vsjjqBUI7YEKBVss8K4JMKsq3tKANbLcWo0Zxhr532TlKVqgvgBhd3Z+CRsxKRqC2u1VeOMYWXLUxHk379vDAkZNTIt0PXbUGZ9fiSorDZTJOhRfZprffV6VH/JQ+opzwQ9Ld/y8omBQ4QrlwxjScVc6dMT4PbyPhQbuKtgg3TeLbidgqSIdOrosF8UVpfZ66J1Cm34ev1uB521TF7sJipdu/tAeVQpLE2lPAtGn0z/97ugI4ONHaQlEt5W2KmWLPKB1vVUYaHN2kOTXbOEBla/okGeMoS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjXufL4bOZ/aNBLGh8VduVIl1f0gW/C1UYPpjv9Kkcs=;
 b=EFIy34jFJzjva45YMJ+XxqG5mdIgEt7YqAaVkfUi6w5fJ/7PW2fHAw17KLOwRLEz9qppFlk9hh+JUPFccRWfmZg+k3iaQkrA6jM0HbOkdOgjGUc4tJ3OrmlliOhw0GYjPMBQuNbHvEs+aJgdOwTKDCixtSK2+DaPSEPgjgFms5ybZiV/cJFgmqHlj5DO8UJ2EdBMiqWBlKm3a9wLPRDexroY6zKv7TvcghqzOIWAyIZhF1BWgIk50/DcdLp+5jMZEXjIV6gXMHWKbjcsEEjVwNDuVk1V7q8iZ538fiwgI4N0Abe2AiolTFY2LDP2fbH1tuSuRKyfIqTgD6pe+EaBIg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8076.apcprd06.prod.outlook.com (2603:1096:d10:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:29:06 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:29:06 +0000
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
Subject: [PATCH v4 21/21] docs: Add support vbootrom and update Manual boot
 for ast2700fc
Thread-Topic: [PATCH v4 21/21] docs: Add support vbootrom and update Manual
 boot for ast2700fc
Thread-Index: AQHczhpYgU9sF33JSE2MzipbaP5ntA==
Date: Fri, 17 Apr 2026 03:29:06 +0000
Message-ID: <20260417032837.2664122-22-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f1b3df71-b298-4cd7-0a82-08de9c317ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: vT5zJST9/FzeiaJfDDnTqgWoJUYut0YNOAGL/HimzybkzGyb8N/hUZ5BqcZH3qiFHT0yg7Ssvaw0qG8X8PnndDFYVtovlkTvwdcNHcD6qDTYmzoeOSL3YEMNN16ZlHg/w0AuLykVyDf4D1jNmoPfsfz4auteH7wY3daqe2W5hcLYoxAB9fUpRtxlm0NA3eoo5I469EkVhp5+l1VjgWUxCXTuW1/pST1FFLoZGl0vnqoZStfB/4HyLtPystr5mJPQ1QtyyCg4zUFzg2kphs8S7Kz+tjkfqi+0DTmNzOlxuWMiPnOsa1Gq9Ljpr5ODHmFVgkwqlDCavREdJgAdde/SK75GETdfz2rtg2WmjHSZoOPmlLhHy2b81AZh2R60AvbDEatXnyY9WjdtyuVHQ46CGrIlTXEr+YlTiCbJCp5Su4dB6GnZMnT0PEBz/6d1xb8OxaSCdmvzo9Od9D2zt20X3FykimMjoYtCxBj/yls65tPZ9NcgU2J8b1jU3q7Qg20a1KHG+6w26GGyCdTfV3SpIAzOUTWcm2kTlPix1Y0ldk+loam9oE1DtbKv2XYKNEo56y5+rL0lp4CtFiftMgBBDZGkKEeiQznhY25GqXYiBTLBqMb01tAxrONdT4/xvI+4AX40qvhy4Y7BoZW8qHJj0In7csaDwR086qFbmKNOPU+Zy65iS+e4LwTx20MnJLdwnt4AqcLpqMbJmbLpA7dfTK738D0idjBNj4l9nBaTogcZcJdmqAgHM9TO0erelsCP8UZPDTOXf2aznqMS5QtF3w2511OMiLnPc7oi55tNr+5QDg7BvzVcYF/LfRsWisBL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oHYp0QNk+SRmFUaYz6sDFvi3T+YVbHXU3zWvS1ibgGtGGRu12PD9lW+SQN?=
 =?iso-8859-1?Q?bJKtCwMK58aFQ0Y2rOlPUJP8AMrB1iTOww8PNo5u6MHpNB+ug50365gFiy?=
 =?iso-8859-1?Q?8rbJGTyQ1v4fX+uZDEWGaBgKYpXjcz8bfn89PPfyOFBt3PBMWc4Mx4+PnL?=
 =?iso-8859-1?Q?eamZoGG2KzB1dWQhwlOCttdpeb6cdDUZoZ4RDdp2Bp9/+gdDwR/tNj2Ca8?=
 =?iso-8859-1?Q?wl1eD9SbDsMpIVJiqBEQ4lW7K6/9hY97wS9zCailU3T05ZSkUjJx6sFb0/?=
 =?iso-8859-1?Q?zWJDJHV4XcQAPSg+k0HaxkrXFvyg1HY+if3xyMJV/R+bRp5Qcx3QfTw3zN?=
 =?iso-8859-1?Q?wTZhvvs3n2/nr18qYVwncWW8Y+5QtFVnFhwQT5Ngz+mxgCgHxVZsYgxcjO?=
 =?iso-8859-1?Q?pU9KS70h20rqW536K+ZNxVFj0u2ZQNPx287qbwnHD1E8U/3XLy78CKhkPP?=
 =?iso-8859-1?Q?2LnehGOILm/4up6xhg803tIsaFHqc5saQcznif5xIA1fQpQ01MMPBGDsg2?=
 =?iso-8859-1?Q?X7rKCiO5ssJErWHXfBzgXP5OMDXSR7+Bmh+fS26RYXVxv/FchGAASaKtbI?=
 =?iso-8859-1?Q?FAsMK3K5Q0zeUgz0n/HbxST2IIpOW+E/wx7EfFBlYwmYO6MvoMoFdx6Wcp?=
 =?iso-8859-1?Q?Bs8ubYVgBkWnu/1rtul20b9/MwUP4bvXgDoOVNAKKpgBV7hiP2pXiLhgO+?=
 =?iso-8859-1?Q?juD/Dz0GpGZu7+eB0se9r8s/L2L29D9qMgqG5ZrE9O/3ooCLR4XZZ0uSql?=
 =?iso-8859-1?Q?23oEUssRatnH6uVNSCJBgRHARZ23rLL8cC4HlThgKP1uXT8T/p2xrM2wvD?=
 =?iso-8859-1?Q?tliDMy1c9KFSJbyCYv1vCu0IaPh4kL0VXWPBKpbGPx+VL6GsWsQZ9AwBYb?=
 =?iso-8859-1?Q?IdBdpp7AiWC2Ro9+G1ZmDtEQK7ivcpYTPIxqk1hA2z5/8jJeSShhepKnpM?=
 =?iso-8859-1?Q?bTOoG7Gus2fI4WfYRQI1Q4hlabhhiFO1fFD2h7NfWHzAo/H2n6TmqYyNf7?=
 =?iso-8859-1?Q?AS/pkugiLLhzo5XoxL3cZkNz6SuVzUZ7fQIrnVeBSxsF5yE9+6T8QMQoMo?=
 =?iso-8859-1?Q?YB8ooKfxf0cxjmZW+QKArl35BTkKd2GwftFjXniij7Y98FPP9DSAfaPsh6?=
 =?iso-8859-1?Q?PXwIFL9SdVJHCKOnezinG7eUyuFzb04PXbGn29RdBVXk4sUOycpz7lcxgp?=
 =?iso-8859-1?Q?Dtq48KYq85vZ70aBZS1mmV1MvoGaDJvputsztsCr8nJwYQI2rou+7o+2XJ?=
 =?iso-8859-1?Q?R3M7dxuwuo9pTc63tkWY05+tjDL03cxu9ErtbD0XWp1H519GMW/AirOgAZ?=
 =?iso-8859-1?Q?9c/vQPlut6W2RYrq2LPrcMwEXKBmKiMMfEMZmEgiJztIWvXqXPDwEtFYR5?=
 =?iso-8859-1?Q?la7gR8EEOHP+5UA6rqfzwkuLJ3vD92OWlcKX8RLkFSa/c/zl+hbu3FFuyl?=
 =?iso-8859-1?Q?T/+92vH4k79rcenLrJO3z6FOqti+njw6WHdZDQ8KRjo06RRjX1dvxjHXeQ?=
 =?iso-8859-1?Q?ECQkLissL8jYwIhVv5nP3V2eizwZysYMn1+AtX7EFXV5RxnG8n6lLd2Ek3?=
 =?iso-8859-1?Q?5UM6PZ5svHTvOfcO9mmMRyXdx/n8cyLMEc6lG4GQ5FiX2zKbvN+6rQNKp4?=
 =?iso-8859-1?Q?S59Lw/QaiUNraZ1eota6nCMyMu814gZlISgts+ekUNTocKCKbnu5Z+LS8v?=
 =?iso-8859-1?Q?MB226BiMdZPvkIY4sZhFmQWQVBSGphUUanzvUgVcrH4dZcdaJQtP/y8vJV?=
 =?iso-8859-1?Q?Dgi/zlDhEt20pYcrPGGKRD06dGZ8HSGI4aZNPZmoGk2okKu7Dv+2l7tNyw?=
 =?iso-8859-1?Q?JJApusx60w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sd9IGpi9xmHyHs6KKhyXHTON1Vync013sD1C90eJzYfyoa1mzUkSVRw7Avt6nUapOnmGw1pO4vzJxQ2Hk21EoHvzxSmLGxRGhVZpH2nlfq7rxYbcuNOeJe+RJqbNNTg5ptUpwEohcdDysJwkQYMc1l7OO1z3iW3aopJYBPiMrINRt/kXLWCjUVJBd/1tDgwcqwf9Dzf5H8WiOqf8E/lPxuRR0GG1QQjLqxi8dYBdTgyzVQl72WD4MNAYusDdImmZEKrFzeNVVd2mnDTv94aJ1CoRzCMNLaOs8BFNe00F+/hXIbkqLaFuor0vpZ8DdZ2wN01iuHPHEb1X9T+shODIBA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b3df71-b298-4cd7-0a82-08de9c317ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:29:06.0932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/ydxBwz1okJYrQed7lbE0WfgGd5ktoPmsap+o3VkohIQlWIsOx8wmBhzHLWIy9ihogszQhAzDbLVwWVgI5CVfa6zSib/x+T1z/W/4UT1Jk=
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 42 +++++++++++++++++++++++++++++++-------=0A=
 1 file changed, 35 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index d0054a7dbb..8454a04b13 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -389,18 +389,25 @@ Booting the ast2700fc machine=0A=
 AST2700 features four Cortex-A35 primary processors and two Cortex-M4 copr=
ocessors.=0A=
 **ast2700-evb** machine focuses on emulating the four Cortex-A35 primary p=
rocessors,=0A=
 **ast2700fc** machine extends **ast2700-evb** by adding support for the tw=
o Cortex-M4 coprocessors.=0A=
+There are two methods to boot the ast2700fc machine.=0A=
+=0A=
+Manual boot using ``-device loader``:=0A=
+=0A=
+In this approach, users manually load firmware and assign entry points via=
 QEMU loader devices.=0A=
+By default, the PSP begins execution at address ``0x430000000``, the load =
address of the bl31=0A=
+firmware. The SSP and TSP start in the powered-off state and must be expli=
citly enabled by the=0A=
+PSP through writes to SCU registers.=0A=
 =0A=
 Steps to boot the AST2700fc machine:=0A=
 =0A=
-1. Ensure you have the following AST2700A1 binaries available in a directo=
ry=0A=
+1. Ensure you have the following AST2700 binaries available in a directory=
=0A=
 =0A=
- * u-boot-nodtb.bin=0A=
- * u-boot.dtb=0A=
+ * u-boot.bin=0A=
  * bl31.bin=0A=
  * optee/tee-raw.bin=0A=
  * image-bmc=0A=
- * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)=0A=
- * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)=0A=
+ * zephyr-aspeed-ssp.bin (for SSP firmware, CPU 5)=0A=
+ * zephyr-aspeed-tsp.bin (for TSP firmware, CPU 6)=0A=
 =0A=
 2. Execute the following command to start ``ast2700fc`` machine:=0A=
 =0A=
@@ -410,6 +417,8 @@ Steps to boot the AST2700fc machine:=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700fc \=0A=
        -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42C000000,file=3D${IMGDIR}/z=
ephyr-aspeed-ssp.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42E000000,file=3D${IMGDIR}/z=
ephyr-aspeed-tsp.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
@@ -417,12 +426,31 @@ Steps to boot the AST2700fc machine:=0A=
        -device loader,cpu-num=3D2,addr=3D0x430000000 \=0A=
        -device loader,cpu-num=3D3,addr=3D0x430000000 \=0A=
        -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
-       -device loader,file=3D${IMGDIR}/zephyr-aspeed-ssp.elf,cpu-num=3D4 \=
=0A=
-       -device loader,file=3D${IMGDIR}/zephyr-aspeed-tsp.elf,cpu-num=3D5 \=
=0A=
        -serial pty -serial pty -serial pty \=0A=
        -snapshot \=0A=
        -S -nographic=0A=
 =0A=
+Boot using a virtual boot ROM (-bios):=0A=
+=0A=
+In this method, the virtual boot ROM (vbootrom) handles the full initializ=
ation sequence.=0A=
+It starts the PSP, which then enables the SSP and TSP by programming the a=
ppropriate SCU=0A=
+registers, following the hardware behavior.=0A=
+=0A=
+Execute the following command to start ``ast2700fc`` machine:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  IMGDIR=3Dast2700-default=0A=
+=0A=
+  $ qemu-system-aarch64 -M ast2700fc \=0A=
+      -bios ast27x0_bootrom.bin \=0A=
+      -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
+      -serial pty -serial pty -serial pty \=0A=
+      -snapshot \=0A=
+      -S -nographic=0A=
+=0A=
+Serial Console Redirection:=0A=
+=0A=
 After launching QEMU, serial devices will be automatically redirected.=0A=
 Example output:=0A=
 =0A=
-- =0A=
2.43.0=0A=

