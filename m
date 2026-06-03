Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E73CCD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcmo-0003Vo-Oq; Wed, 03 Jun 2026 00:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcma-0003TM-IY; Wed, 03 Jun 2026 00:00:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmW-0002QB-JF; Wed, 03 Jun 2026 00:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv1bKe7UuXzY3GcD+van0TFiUg4KX5u4S0bMvEl62D9KrgcPnotUPPEs8cc2/XH9lEsn3Gme7RdeZpgOcB+8eBroJ7H6JwABTwrp+Mxo0z5mkTXJuTMWC9dgpyMRSt7lX4uRmTq6m3g4etPKmFWW0+bEMZ8cmXfMzmbWTg1+pQJE2PmRGp7nTAfXRNndwZGG+mc2TAd32LJKjPDePjvqqKFPGPQzeZzkPBi61HfKjAj8cS9fj7Q/4L6POPHiaqgr/2uIoHnoZaH5xM/+uH4WYNAnQQ2jL26LVqEkY1Uxea63/LxMhjTrDZveNMHKz3cvdDRoxYdPbUz2E7l9wzWobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcw+OCaWjlS94VeEpOQL0QCFpkLSIQmZiDUlXQsfais=;
 b=NAfduYwQftahiBPlYSeMYnGqpGffcGwNIn4Tn0WbLhB/kXsgWAjiBweowpm63FZULJDj9yYNt4NaUQu0MkvBR9+eAYqXKPONvBtBMbIgl+pPqg8xXw1NODzcVizaj1yRBVUGqUeDyrjJh+t7NhTQsqVz8g98dRtDnvZeJJKNj3IF2RGCeHjQPizpJ1Mq+YLGNJdIZ3ACrKB4qOakvyTbEchjOQFVl88oV9anCfsHgQnpVG/Nz9x3SrOH1vLWhncqhyZK3kclICjPjGnIVkju6E3Ct2jVit+DT8+GqmDauLAkfNDphbbYaU+OMjfYXY/6oSOs2PweSd/9Z9PE6st26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vcw+OCaWjlS94VeEpOQL0QCFpkLSIQmZiDUlXQsfais=;
 b=nGS62Ex6pk9TLkriNcJvgpw2LzMx5/wrqFH2DI87KlF7FjBKWO617IKPgQgZ/z/7J+z83a85IOEU5CXsk7Ww9v93BHht+EbE7MioUBkLZ5g7cyJOnbqk9eYl8Nt0sK9incpuneErESzH48Yc1WXqmlVS6IZfJUd31R3rpfvRCJc3M959HD+UkXLs2+nrLiNr0YUfYCUutYI4gEP9x62Pm7djhmOpRyJx93iKwhEk1kVlNfMo0JRQGrVNdDRJbffE+iDbsraTMSDJuGUqTOHEXOcgp1nK64eFGrEMMOp2pX1kXMZYFr3eRkwLoxwKx/NTGPvfd5dqIeuiVkkSKCEkVg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to
 unify DMA address handling
Thread-Topic: [PATCH v3 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask
 to unify DMA address handling
Thread-Index: AQHc8w2E8LG9mTwF50q43NKlevPhtg==
Date: Wed, 3 Jun 2026 04:00:29 +0000
Message-ID: <20260603040027.938816-2-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: 84178ad2-4847-490f-58f9-08dec124a706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: K2/DKgO5Nx9Zk4dW7fDXnIYWS9mqHFIfm4oJcFWTbbjzJFrAjZuwb7T5pUQH5ErULbxFYqOYNTxyS5cX6YdOeytuyIHBu2pEWEPVcvofz+AHhoukTJJ+pdvj+bX8lIo07IhIoNu8bHHbkDY0i2lAUk1BPnt/ASMXzSz55p1W5VA8NTsfaaxYnoEnK4NOiHChdTyBDHRShR1skdtqT3NUgfO+n/pivuvscz/u7VwduPVYc9q9Q/TIELjbJhxIpKhf/6/SY+1nxqBwp1sHGDzgx7MPMBxtz8x9z9ubmKEWbVuYdojU5UV+s1qD/ZNzBIRvyxaCEdr5TJ35PQWWk/DeYFquvA1DI1Uw8xeA2Gb9I4JVvnxV3gI2PUkbX33J0xkftxsGFcPA/srney9PHWSNQwEEg/sTafXMjwzJOCBSP5cnba98Eqml9eF+iYyXma6zjHMoO+OxG2ZoBDd+ddflrx+7O8iQlw8rqMTWyg/B/zI8wr4oF+++10S3hAytLxUVbMX/US4uw5qDzzCzQ0/CZgeDySml51t5bgmX+iS7+hziXnidpR526ILU5DsfXXJ8qzBaeq/BzejcAEQE5/QwuI+yZqiTpQuzhNgpSz6pSSW/HTywODN5CYghkkj3s8+XIsnEDRD/pGCiA2X/nyIGeZEczy1l9l6D6hbqa0xWyYk5FvamPhUOqwEooqssjWBCrw/OBs+/JuGS0b08NpFonrvENK4gOxGQZWNHkZHtTNCXpCgZa5a2DCcILCR5XRoe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1aOhYNOzkxBnVPpJ0JKpycXdow+Bks5953gyuScdxV4ME2WLQcdILqMBVo?=
 =?iso-8859-1?Q?/xkTXGhb28nRHvO7i/X0OLdXLK6QuXeQkRohwEQ21MojhQnd9PEIOcc3g/?=
 =?iso-8859-1?Q?26+e2SCjwPY15fg7PeIGXTT+n5P0zrIAdE86eIFBt+xWM8sI6i/uO9vSUp?=
 =?iso-8859-1?Q?mwJWfbSKdCDwpv7lgFlNiQZzrS7EhpQZSPlz2Ey4Pvmyhv9sNk2w1EZrZC?=
 =?iso-8859-1?Q?By6GF4YZI/QAD7vMaoCYa/E6dUnnqcYSmqROH0XdJt0IqKebymm+7GglYi?=
 =?iso-8859-1?Q?y8whGf0OyhYwPlSw9HfDT6d/8AibuBbp/hTrVoHOGDq5A9UqCkZRzv11rc?=
 =?iso-8859-1?Q?g49OHui8iT8zqOgfpRXKxBsGXktdIDvG747bo1stXSDKeyhd24jI4mfs5A?=
 =?iso-8859-1?Q?OgfWlpHNUAiGwMwYkxU2i9C3Zo2O8b2v99El7z+6MrqZll4tawQ+cfisin?=
 =?iso-8859-1?Q?z4iSdVLpiIw8mFA5ztaoEZ1uNwZHRdD0tQ9lELIyZZmxWdxgCsbE47MEQl?=
 =?iso-8859-1?Q?ebXJ8zNXlq6UD8oT8pkivbtxPKPMRu1kY9g6aB/1f/vlMbbidjHzWvJ6WF?=
 =?iso-8859-1?Q?T7MX7wGuXG2oC2cyiupquOjsp/UF9G4yGuEj+hIhpmnPfAmPfFreK3NWTi?=
 =?iso-8859-1?Q?9eTgI+IutVEVq+8DzChgAxnEEodChTPpyM2M7y9iiqS1LEkdnCt/lDrO/+?=
 =?iso-8859-1?Q?gIdVQrzja/sbll9Ln07CCp3glT4JksgIYkTeg4gp3yEDdemIhJLEzY6gsq?=
 =?iso-8859-1?Q?6Nu0EIOxJSUmRdMT3m8s+aKBcHEFwJx8QSsC2TQoA/fSZEG9Dz2lzHrzWo?=
 =?iso-8859-1?Q?YMm9WKJTyu0AmFJGqSENLweZKGB3OYZJitlVUVIx4pZIXAREAsEigjW3+C?=
 =?iso-8859-1?Q?mRQqMP9ALfEsKIL2cWTwjNgCbhXAyqb0NbRXlVgqvb0qwzX7eN/9rGyNR5?=
 =?iso-8859-1?Q?x2RWK188+LmCaQFP3xUZi6oemRRI76+GuV8evUzNrObSrWqbJT2s8eQ8YH?=
 =?iso-8859-1?Q?dXXkq4b16LRjJiE39qSI8ORwLB68q+tsSIzozgudmbCQkP0WtRGwxNjXqW?=
 =?iso-8859-1?Q?GetV96+6lx32QTXm4liD0CXfrQSoM30CZe85ixcSuBppZjUjsYnTfwcdJS?=
 =?iso-8859-1?Q?Q+o1FFX5ab/GNGJgpbXO2ElVvuU/KHrWqwTPeQXe7B6sZziaGssuRvWzFB?=
 =?iso-8859-1?Q?1XcEq6IGjr7OEkR5XXd8Y1eGysnWOXUC7tS812TnSNSATpIBOXc1eVYWgW?=
 =?iso-8859-1?Q?7V49qAW8wRzXDalXADlFTwOZG11eF8rVBtAIb9mgiqEieOtycsSWo1O0Oj?=
 =?iso-8859-1?Q?kkxBDCwyZVd2bt/LeumBDXwmWN9nTypUiqWERzc3q/MMWY7ABmBkLBDQFH?=
 =?iso-8859-1?Q?8sf605QotAbx+hiBL04e0DOknPHbR4EYUnyJj8TwiDgR3EjLK1HWrqyWpQ?=
 =?iso-8859-1?Q?TqHrJ6/SZSlqZCti+Cr2OFc3Gd4fMoi6Wiq7ijBb+0IEneHlxfdXmZipwS?=
 =?iso-8859-1?Q?K8kWncE3uJKjF0ZxD2OoImU5rAVQFUI5U6vHHDPcBuaqCm4aaMawnU/B71?=
 =?iso-8859-1?Q?0xxLADYM44g87J1AhB7jQzPNVwKqFGe+luw6zJlISMCQvhIMe2OxJ7Di9B?=
 =?iso-8859-1?Q?BGn7GgQAE6DjaLERtCAzhqF2M/pEzhtDSI7G7UPpR/h0xtTuHS/u499ts3?=
 =?iso-8859-1?Q?EarI9S2DH/aM+H3nrRQVEijinYin+vsNzVom4l8FgAgYP5jHtRoIPGeQj3?=
 =?iso-8859-1?Q?YqoNw/k77GUJn0Zd+FSSqq1FjizmNdhwz1tyLlOtBEeunU4EOM83BrOsOm?=
 =?iso-8859-1?Q?+HthJMhjKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RjixkL+9FRLR+8dR5GW2a/jkuf4qsP6oLLJ5uayP28dt4WnUqmqPmg17QjcARQg3J7UEVHNTAooFOYO19dl3KCWc2tXZhasfIPGUlaEYC/cHK+b6mKiAYaOz3jlCnT8yBUqsPU2PqB6stlE0slAesJloWlW4hpozgQPWdGLb9JWOHTuTSrcMU+ecM5i2ddqP32jk7+tL4HdW3R6rXcA/q0z8oLJ8bUh4ZcWhZ3FPABLngRFGyrArb8nvleoL6ZhqzmCyH7XcEf9znnb1hYzJ/3BqheNioiftWnwXlm3be41kr+KjAH/IXJlmWZDUXt5ESBrAjbsjNBE9/lOX7HFTkw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84178ad2-4847-490f-58f9-08dec124a706
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:29.7740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Si+/QUGq7i1F2jswpgPZZ3UhPslhzgKBeov+LXpHxbuRjdm3iy+ZcNCbKaNI8HBnUWi8SJ7Ghr8sSVNuBiWZBYI4NJIxwE+kAtF1G7luZmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
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

The Aspeed I2C controller has two register layouts.=0A=
=0A=
The AST2500 uses the old mode with a single DMA address register (I2CD_DMA_=
ADDR)=0A=
where the address is 4-byte aligned and masked to 0x3ffffffc.=0A=
=0A=
From AST2600 onwards, the new mode provides separate master TX/RX and slave=
 RX DMA=0A=
address registers (I2CM_DMA_TX_ADDR, I2CM_DMA_RX_ADDR, I2CS_DMA_RX_ADDR)=0A=
with different address widths per SoC:=0A=
  AST2600 (new mode): 0x7fffffff  - bits[30:0]=0A=
  AST1030 (new mode): 0x7fffffff  - bits[30:0]=0A=
  AST1060 (new mode): 0x7fffffff  - bits[30:0]=0A=
  AST2700 (new mode): 0xffffffff  - bits[31:0]=0A=
=0A=
Introduce dma_addr_lo_mask as a per-class attribute and apply it=0A=
uniformly when storing DMA address register writes and when loading=0A=
the address into dma_dram_offset for both master and slave paths.=0A=
This replaces the previous FIELD_EX32 extractions (which incorrectly=0A=
stripped bit 31 on AST2700) and the hardcoded 0x3ffffffc literal in=0A=
the old-mode path.=0A=
=0A=
Fixes: 1809ab6a67359e0876981cd05d2a50b2843eabad ("hw/i2c/aspeed: Add AST270=
0 support")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  5 +----=0A=
 hw/i2c/aspeed_i2c.c         | 24 ++++++++++++++----------=0A=
 2 files changed, 15 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index d42cb4865a..1fc229f699 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -209,13 +209,9 @@ REG32(I2CS_DMA_LEN, 0x2c)=0A=
     FIELD(I2CS_DMA_LEN, TX_BUF_LEN_W1T, 15, 1)=0A=
     FIELD(I2CS_DMA_LEN, TX_BUF_LEN, 0, 11)=0A=
 REG32(I2CM_DMA_TX_ADDR, 0x30)=0A=
-    FIELD(I2CM_DMA_TX_ADDR, ADDR, 0, 31)=0A=
 REG32(I2CM_DMA_RX_ADDR, 0x34)=0A=
-    FIELD(I2CM_DMA_RX_ADDR, ADDR, 0, 31)=0A=
 REG32(I2CS_DMA_TX_ADDR, 0x38)=0A=
-    FIELD(I2CS_DMA_TX_ADDR, ADDR, 0, 31)=0A=
 REG32(I2CS_DMA_RX_ADDR, 0x3c)=0A=
-    FIELD(I2CS_DMA_RX_ADDR, ADDR, 0, 31)=0A=
 REG32(I2CS_DEV_ADDR, 0x40)=0A=
 REG32(I2CM_DMA_LEN_STS, 0x48)=0A=
     FIELD(I2CM_DMA_LEN_STS, RX_LEN, 16, 13)=0A=
@@ -303,6 +299,7 @@ struct AspeedI2CClass {=0A=
     bool has_share_pool;=0A=
     uint64_t mem_size;=0A=
     bool has_dma64;=0A=
+    uint32_t dma_addr_lo_mask;=0A=
 };=0A=
 =0A=
 static inline bool aspeed_i2c_is_new_mode(AspeedI2CState *s)=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 4a6732a185..9d4e72c858 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -236,7 +236,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2C=
Bus *bus)=0A=
         value =3D bus->regs[R_I2CM_DMA_TX_ADDR];=0A=
         bus->dma_dram_offset =3D=0A=
             deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));=0A=
+                      value & aic->dma_addr_lo_mask);=0A=
         if (aic->has_dma64) {=0A=
             value =3D bus->regs[R_I2CM_DMA_TX_ADDR_HI];=0A=
             bus->dma_dram_offset =3D=0A=
@@ -246,7 +246,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2C=
Bus *bus)=0A=
     } else {=0A=
         value =3D bus->regs[R_I2CD_DMA_ADDR];=0A=
         bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                                         value & 0x3ffffffc);=0A=
+                                         value & aic->dma_addr_lo_mask);=
=0A=
     }=0A=
 }=0A=
 =0A=
@@ -261,7 +261,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2C=
Bus *bus)=0A=
         value =3D bus->regs[R_I2CM_DMA_RX_ADDR];=0A=
         bus->dma_dram_offset =3D=0A=
             deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));=0A=
+                      value & aic->dma_addr_lo_mask);=0A=
         if (aic->has_dma64) {=0A=
             value =3D bus->regs[R_I2CM_DMA_RX_ADDR_HI];=0A=
             bus->dma_dram_offset =3D=0A=
@@ -271,7 +271,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2C=
Bus *bus)=0A=
     } else {=0A=
         value =3D bus->regs[R_I2CD_DMA_ADDR];=0A=
         bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                                         value & 0x3ffffffc);=0A=
+                                         value & aic->dma_addr_lo_mask);=
=0A=
     }=0A=
 }=0A=
 =0A=
@@ -735,12 +735,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bu=
s, hwaddr offset,=0A=
         aspeed_i2c_bus_raise_interrupt(bus);=0A=
         break;=0A=
     case A_I2CM_DMA_TX_ADDR:=0A=
-        bus->regs[R_I2CM_DMA_TX_ADDR] =3D FIELD_EX32(value, I2CM_DMA_TX_AD=
DR,=0A=
-                                                   ADDR);=0A=
+        bus->regs[R_I2CM_DMA_TX_ADDR] =3D value & aic->dma_addr_lo_mask;=
=0A=
         break;=0A=
     case A_I2CM_DMA_RX_ADDR:=0A=
-        bus->regs[R_I2CM_DMA_RX_ADDR] =3D FIELD_EX32(value, I2CM_DMA_RX_AD=
DR,=0A=
-                                                   ADDR);=0A=
+        bus->regs[R_I2CM_DMA_RX_ADDR] =3D value & aic->dma_addr_lo_mask;=
=0A=
         break;=0A=
     case A_I2CM_DMA_LEN:=0A=
         w1t =3D FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||=0A=
@@ -777,7 +775,7 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CS_DEV_ADDR] =3D value;=0A=
         break;=0A=
     case A_I2CS_DMA_RX_ADDR:=0A=
-        bus->regs[R_I2CS_DMA_RX_ADDR] =3D value;=0A=
+        bus->regs[R_I2CS_DMA_RX_ADDR] =3D value & aic->dma_addr_lo_mask;=
=0A=
         break;=0A=
     case A_I2CS_DMA_LEN:=0A=
         if (FIELD_EX32(value, I2CS_DMA_LEN, RX_BUF_LEN_W1T)) {=0A=
@@ -1375,6 +1373,8 @@ static void aspeed_i2c_class_init(ObjectClass *klass,=
 const void *data)=0A=
 static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,=0A=
                                           enum i2c_event event)=0A=
 {=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+=0A=
     switch (event) {=0A=
     case I2C_START_SEND_ASYNC:=0A=
         if (!SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CS_CMD, RX_DMA_EN)) {=
=0A=
@@ -1385,7 +1385,7 @@ static int aspeed_i2c_bus_new_slave_event(AspeedI2CBu=
s *bus,=0A=
         ARRAY_FIELD_DP32(bus->regs, I2CS_DMA_LEN_STS, RX_LEN, 0);=0A=
         bus->dma_dram_offset =3D=0A=
             deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_RX_ADDR, ADDR))=
;=0A=
+                      bus->regs[R_I2CS_DMA_RX_ADDR] & aic->dma_addr_lo_mas=
k);=0A=
         bus->regs[R_I2CC_DMA_LEN] =3D=0A=
             ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_LEN, RX_BUF_LEN) + 1;=0A=
         i2c_ack(bus->bus);=0A=
@@ -1608,6 +1608,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->check_sram =3D true;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x1000;=0A=
+    aic->dma_addr_lo_mask =3D 0x3ffffffc;=0A=
 }=0A=
 =0A=
 static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)=0A=
@@ -1631,6 +1632,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x1000;=0A=
+    aic->dma_addr_lo_mask =3D 0x7fffffff;=0A=
 }=0A=
 =0A=
 static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
@@ -1649,6 +1651,7 @@ static void aspeed_1030_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x10000;=0A=
+    aic->dma_addr_lo_mask =3D 0x7fffffff;=0A=
 }=0A=
 =0A=
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
@@ -1670,6 +1673,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x2000;=0A=
     aic->has_dma64 =3D true;=0A=
+    aic->dma_addr_lo_mask =3D 0xffffffff;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_i2c_types[] =3D {=0A=
-- =0A=
2.43.0=0A=

