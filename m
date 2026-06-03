Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C09CD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfF2-00006p-3v; Wed, 03 Jun 2026 02:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEz-00006H-Ob; Wed, 03 Jun 2026 02:38:13 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEx-0008Je-UX; Wed, 03 Jun 2026 02:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4gcc+rX+DiKcWDO46K5euUqVbcrmxpFUu+88Z1bRSrLDJlfW6FD352FzhijF6DeT8jRw2t8FtYksNjS8h20sxbWdSCFAwyV2G4O75SQ7k7ed8mAdfmn4hYKhFiScw9GBeCFXUnVHBXo+haMeaSN4esKwORdAQb5gpuvPT2fb3cMe8yYD3PplrAUTh/V98lyBl31qE+tGL5rX1qaIC+mzdIw1RssaVPe8+OKY5pyp+AZ7AUudctzKEzKegJpl69LN7wYsGBKQObixq2SH7YJF5ue0rCKyI0yBL2G/eBj/Kl26bD7d6oTvhNXaYb99Qfi1bEGXxPKUEbq32vMKZAkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NgAKbHhIGYOKlNWxbnpc77BWpuspkxp7Io2YLfQu9k=;
 b=N3T9eW+9nEiNDDKSbYdSEb2+XpyUF1zZfN1nAsDCo1XYxzsvCdHgrXDSR1HknM2YcPFMLFO4uqTzFnWrGGQHVmbo7iYEpG/pfZgGxPdojb4P35kXxD3foZpCjud2aXkx2gbljeVIeN27m2yX3wLbkE9D1w258Ffy5wTdb4lxwb3JBguHLRgkGneqbIfoj1i7BytRaHZH8GQ6H14FUfYMh6rG3OCq/zDmZCRxk4JuPblVwwR1oxL12PnzqBK5SXHUN7iE0aR9iMr+poBEqsHRlC23tBIKkFMqphnMnnXCM1TvN5ckZ/8H1nFXJqwCkCoPtDznSexiJJnT/MCr/EudgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NgAKbHhIGYOKlNWxbnpc77BWpuspkxp7Io2YLfQu9k=;
 b=DSZMvSWE26b3i4IqgN9mNCQ83fu+K27seQO3H5+kwJCfNLXfnLmrW/7AaeRZdI1TxWCCKURR+xdm3rxGo/Y1mv4AbSpzAd4Zek/34OEXU9/hXW1KQs8noLRV2N6d+3F6kZKcztsoQEIJlUDYrZszIuiMCHfa8bQFGy/DUnCZR1Z04UmDTXE/zWUsgI5Cu/8HtWq6m76hL3r9f71uOzp+rPYzgekSH7bpgmr/DNk3nJd+K8BR+2GJmyJitb5l/3BwCfeLvNCt2uMNwMKgq0GCYsWC6ZxkLIZBMnhDKfKNo63smpD6z9w1x0Rr5IvUEyEzL9VMm42wJnbj59hu98jYHw==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by SEZPR06MB6572.apcprd06.prod.outlook.com (2603:1096:101:184::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:38:06 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:38:06 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 6/6] docs/system/arm: Document AST1040 Caliptra mailbox
Thread-Topic: [RESEND PATCH 6/6] docs/system/arm: Document AST1040 Caliptra
 mailbox
Thread-Index: AQHc8yOJiD0gPjj7QE+aUl73xW3lVw==
Date: Wed, 3 Jun 2026 06:38:06 +0000
Message-ID: <20260603063756.1481524-7-steven_lee@aspeedtech.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|SEZPR06MB6572:EE_
x-ms-office365-filtering-correlation-id: 2fec0f8d-be7b-4cdc-bb7f-08dec13aabb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|6133799003|18002099003|22082099003|3023799007|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: cVXjpdW/R5VhpyhAOfej/LuyDYw+60GD8kUONuQzItvYU7quNZSoFrLu+rMn3Hs81VxzYssikXBQlJHV2CsA783XgTz4kUxDWVakFz2+5TO+KQ3Mv+3y3oLPNcouZBNephZbYsDapIDakV5pefUFFkfCSzz6ez1BDPgYpuSeS+FrW5QLc2a0gz1mHawEPMVEdGvrEvnqQGT89/xomKiZTcdxpQf8rsGx3aE/oHnuSOSHp2od4Ev4izJS3OKEcEIA0931wGbd+mBvtovxT2/QWXi2hkrxR5zx26+HJi8/U5A3JPro0Qhqdevh6Qg+Ix2X6CNByrnTZ2WF8E8fzJ1ZYZ8mwVNUyroWmEgNwB6SEd47vxLNdBqzPeFm1RpmWLRbcCvawzLtXoDu3hFjdf5axDWSlaruKvq8f4/1wvP9IQyWwydmIHfbhh2I2M73DhjjLgnxqYP9RWcSgzoZSkFF2z5delAY1rVWMK7W/Vq11NdZnOekXSuWnoWixrpvgcGWZVW+7SkXz5XHAmmREVLbXYR0ljaSkvO+D5z6klLZqEZsiSL8LFaIs5VIjCbK0Z3iBCkMKCzjwqiIw7d9q/xkZIV7VFP3lm6HjNq4hqHPAVH6xeQXqgH63YGcOEjMmZn5tYXS7jydmk6UamXvrTCXytrkVK5wrgZ009X8nMVbUSI8dJ9JlXs1+l4wnispLwWX/A3CvrkQ0KtBF3fGMCxvDW2Qc33AyxHNjgBFAGTYGHwLKyLKTLByISTFCvMjOYCp3Fh7lYKM2kPUgfa5UlGt9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qEDLEZ8UbOWVM0sTaS8vIBoBP2EYdD1jxAZf5nWFKf2uKwW46nvaOPHOYc?=
 =?iso-8859-1?Q?NgLA+nTNCtKxta/+dFneb2WuGHIsYBTlxsNuvhFTwN/FkIcedfzXehZIER?=
 =?iso-8859-1?Q?G1nMSIwO5IpGhSPjPkOIbj+aPKPgkp/Ei6DkYGBjac+2EIwROterQc5KMy?=
 =?iso-8859-1?Q?oeFicrDmT6jyzt5hhBIPGzB+aHM0awkbhO2o+FHkGaPp/yNf3nfG/cbB2F?=
 =?iso-8859-1?Q?ewBDH/t/RU6kIuFPrvRrli80N7TxXs6y7zW5FKjI0Sc6PiygEAWjW1SxN6?=
 =?iso-8859-1?Q?LS0sL9H3iYTo+ZWauEGi1yhLV+kc3Qe3GVBWRCruXJYhpNhEglManf8ncN?=
 =?iso-8859-1?Q?lMHqGlHCCUm1GQcZAIoDUTUn7fPr5RaXiZGsOrbrN4UH0FynSzIhdg22y1?=
 =?iso-8859-1?Q?BV1D9KQRUkqEp8vMxcRhfSyVv2RHmd5Ze+jPtVAqSSBrVJJjvniHBNFrLL?=
 =?iso-8859-1?Q?xSrz1faiSLoC6Cr0DNLR5JRVFipnAA5so8nkVLaZTdF0WDhXtPyiwswMHG?=
 =?iso-8859-1?Q?lY2oedFlLdaWAjYeJiSiOiq/uJPuMCls/TEdn302f497tiAJ0SLYtRgcLV?=
 =?iso-8859-1?Q?AYy3MAosxZXJPAOMw9lIXaMET+Rtry1W5NXMUmmYHLH4NzSrCnb2zuwm91?=
 =?iso-8859-1?Q?iBJ/5eukoNsqdF5OQ7ceFsbUzkDyPC/uAhlJiEdiV7VLi0/HFOCxRHiMFC?=
 =?iso-8859-1?Q?xbjvjEXWu/t/bLOgpQWUqAeXZQkZ8p4sbVFvMU948ZbT9t6yh/uA6LzC7L?=
 =?iso-8859-1?Q?qs4LZhBya+JwNv7n3ruUn5v2bMh8zFoImaCShRYA7pJEJfT2gi7jjeaa1D?=
 =?iso-8859-1?Q?8Ll6f0/7aDHRa9ifvwgfO6utwpB6znEgJI6Ew1fHFMlJwJ99f6bPHE9UKX?=
 =?iso-8859-1?Q?g/jWyBZ9oDgiA2vLoqGkHsA0yMv9433ibczN/SorHkwEJxaZkJoC6ptQe3?=
 =?iso-8859-1?Q?dqybl6rew3NytGg3rMnRdnC4Pm/qhOoJrzWHUZkEnLg6veYIx7RdPvjd8v?=
 =?iso-8859-1?Q?RR5neICm81H++j7v4OEN2K2DqUZFJu7O2er1YuKH/MCK2DE6GHhynv0W+Q?=
 =?iso-8859-1?Q?KnROcy357/R0wxISyHYPCqNAt0thdk3bi1G7XyfmLoT9wjuTC2Yda3ymEW?=
 =?iso-8859-1?Q?cN8M+Ep9nyR5KjYbDx1rpZEkBsjfoAza+ouQqdyJHq6HbzN/bJMw+dAdYj?=
 =?iso-8859-1?Q?24F0uwtygPEC1qqYuuqCERJAmvfsJIlun7KtQa8t8F+1KkH5zlTS4ZePo1?=
 =?iso-8859-1?Q?DrvHD1xs/BmlkF0mhs9M//mv/pexooRsXXMWSc2upzdKSzOU0xzNQ9Js1+?=
 =?iso-8859-1?Q?gTOpUS5OJwMlnxbPG8v8QdU0N5H5e10v2Tl4nC0o9z2ND0HIT6lRjUPP0E?=
 =?iso-8859-1?Q?6E+VMb4NCYCi0OcPb14soO1mluer21gGq4RBItwhqsE3JYkX7pM1q0RAl2?=
 =?iso-8859-1?Q?0El8mj/CbFBpN9YGUPGVZD4AMgfVIS1nppMwV475lG3YgM6PJb6CQSQrYu?=
 =?iso-8859-1?Q?NJGaQCEt4AiykXqjEJI0+XcKgdBv2gqC1gfRZw14MdFEvXyeIGiI0owVEq?=
 =?iso-8859-1?Q?1iTjIQkx42XjHBdGbGPtmOwaLzsurwAwQyJ3VExRGLdtUB3jUSwH66y3jq?=
 =?iso-8859-1?Q?J36ONMiwtcqfBSIEaSS+Bi901DtSZk9ZVW1Ykz3IPoCwTeIvXMwzqEGzWn?=
 =?iso-8859-1?Q?x7yvpB6BSMskhrl7jLVYKGZhmiNZAUDeqsxfmNjq05SsHO4z7hd47cHX0X?=
 =?iso-8859-1?Q?oOOvTYq07kQi4xAUGp9qCVDLGsS2Y1nEcxhDWZwYlEHXq5sa9F/z/1V6wZ?=
 =?iso-8859-1?Q?hckakzcKUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p0a0Va8rJo50OpoMcno/Mw6KFFlONlPboUvIWs+OW4w7Lq6IdCfXFYJP6qWuRIUTBuQopg3heno7cOcuSLzoLEc0P2crUD5wddVAUqS9QzpnQZv2hbfzxfk7v4WiT6UOBFedeZ7Ijb4x2h+hqPT8qmq0M1vTPpD3e54qGN/nQ6paY5mtibcTx5WKpEfHiGRQqPq9lJwm7Epj4zFdFWpO2b7dQqeLB+xQMn58goIGFkscMUrCEXyz7QxTtkgWgrDn4rgDPJbQrZx25ekHdgEYa0Gv/VnyQRAyM0txCIAxe7dmM19cgunxQ1Lqh+BcDdMaVpnfC71Y5FqCo/uN/F8OIA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec0f8d-be7b-4cdc-bb7f-08dec13aabb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:38:06.6103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFAUX8rnYFnQUaaroypmaV+V1rRuz58TUFrEOo1oHn+EZvw4K1dcyYwLUcVSbBEII6LEz43F8T9qT1J7EmbhwGjIvESh7sY73O/KAp15eBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6572
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Document the AST1040 Caliptra MCI mailbox windows, the SCU-controlled remap=
 aperture, and how to connect the external mailbox peer through a chardev b=
ackend.=0A=
=0A=
Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 32 ++++++++++++++++++++++++++++++++=0A=
 1 file changed, 32 insertions(+)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 2d51ceeb84..1ffa88c2ae 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -483,6 +483,7 @@ Supported devices=0A=
  * ADC=0A=
  * Secure Boot Controller=0A=
  * PECI Controller (minimal)=0A=
+ * Caliptra MCI mailbox (AST1040 only)=0A=
 =0A=
 =0A=
 Missing devices=0A=
@@ -512,3 +513,34 @@ To boot a kernel directly from a Zephyr build tree:=0A=
 =0A=
   $ qemu-system-arm -M ast1030-evb -nographic \=0A=
         -kernel zephyr.bin=0A=
+=0A=
+Caliptra MCI mailbox (ast1040-evb)=0A=
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=0A=
+=0A=
+The AST1040 chip provides a mechanism to map the Caliptra MCI mailbox=0A=
+register space into the Cortex-M4F address space. The Caliptra MCI mailbox=
=0A=
+SRAM and CSR are accessible at fixed addresses:=0A=
+=0A=
+- Mailbox SRAM at ``0x21400000`` (2 MiB, command/response payload)=0A=
+- Mailbox CSR  at ``0x21600000`` (4 KiB, LOCK/CMD/DLEN/EXECUTE/STATUS)=0A=
+=0A=
+The SCU ``CPTRA_PAGE_REG0`` register (at ``0x74C02120``) selects which=0A=
+Caliptra MCI page (SRAM or CSR) is exposed through the 4 KiB aperture at=
=0A=
+``0x74200000``, allowing firmware to access either window through a single=
=0A=
+address.=0A=
+=0A=
+By default the mailbox has no Caliptra peer, so writing ``EXECUTE`` report=
s=0A=
+``CMD_FAILURE``. To service commands with an external Caliptra simulator (=
for=0A=
+example caliptra-server) over a UNIX socket, start the simulator first, th=
en=0A=
+create an external peer device and link it with the machine's ``cptra-peer=
``=0A=
+option:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  $ qemu-system-arm -M ast1040-evb,cptra-peer=3Dpeer0 -nographic \=0A=
+        -chardev socket,id=3Dcptra0,path=3D/tmp/mcu_mbox.sock \=0A=
+        -device cptra-mbox-peer-extern,id=3Dpeer0,chardev=3Dcptra0 \=0A=
+        -kernel zephyr.elf=0A=
+=0A=
+Writing ``EXECUTE`` bridges the command and the mailbox SRAM payload to th=
e=0A=
+peer over the socket, and writes the response back into the mailbox SRAM.=
=0A=
-- =0A=
2.43.0=

