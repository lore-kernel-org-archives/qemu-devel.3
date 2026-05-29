Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D377CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw3-0008I6-Ua; Fri, 29 May 2026 02:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvv-0008FO-Qw; Fri, 29 May 2026 02:43:05 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvr-0002HG-UB; Fri, 29 May 2026 02:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxKyEJPSmlL/nE5PRHetUmOdfXoW75ZZhqNHFZlimy8IYNgWr9ec10ZQJDxFnX6e6vjb/jB/Rn7d4qOWLrzPhkKEvE0h5BSystA0WY43HROYzBn2QKCm3WWu15Ehp45GTGa3GMmHAW0rK7WUQag7EbZQLjzTCO126mI9bQXTNdO/sudmQpEmj/Vu0WQEzzQk610bSEu/YlEnNi8VbvoQOPSrl/WzKutZz1ZsuANYdl135TecZUorXVbHBdi7m/aulMj0FxLhhG2k9H30Eirs60JANmUHU4AlLJ1mTX8dHyjdMgN8dUWkc3ONk26Om2saG8hLn6PPt2L8uRHPN1vakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RWycotMyJQecu/E2mKJwE1qUmZ3M8WCH/7qdtV3R20=;
 b=xUVN2QEluagOlYFpSBJcTcvL8DI8XWOYopoessrxyAafA7DCWV3fmsQxFU/c1i/I1NjYEnvsOToqZkZhBNwipofGsFsd2wd/Czw/AkX7/P0mzj3rXPVSaIopwba8E9G/0ZZniGZjF/RlRBDv62SbKby1d/D8hxT6HdBqzw0FWaF31E/vgdGrbWOiNymD/vGAQPLdyJKMtmMKXTENu2C94iu5BkGDCzvPgRDtpbJO2k6Po6MQ9g92fBULf3cwR0cGkZksxvjYiBHjqcYrcedNipPgSFs7GzVljonuqOikvosOARSrlD/y006vUQP81e8mBsQsQsbKIuFCYzlMi1x+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RWycotMyJQecu/E2mKJwE1qUmZ3M8WCH/7qdtV3R20=;
 b=U7UeysSOrX89o80UVSxmyP+I4w37PHCvH++r9uUk6SEeD37XmHla2Vz+65kejfDI3Bz5JeqN1GpUycFI/MXwDig6lpnq+2mMkE9NIZHSrHLqauYL3QbamgDCtoyx+PW2RUvpC1tyf2KMYiDGWtiP31aW16c74quTeTWGXOlblP/hPbrm+VjE0ha+Km2mFh48DzUhGzk/aNMcsCqWH414/kEpITbbZWjII621b32ZEmhUfryBu07hpEHPr06lo2cXGcxYFV8znRIYRd2OikGkHJEASbwMFLZxIXksD6fEVsb+66MPvd0tJZc0T469I1OdujPJi2yAML3ivUt165Xevg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6063.apcprd06.prod.outlook.com (2603:1096:101:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:42:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to
 unify DMA address handling
Thread-Topic: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask
 to unify DMA address handling
Thread-Index: AQHc7zZbXaWLhHkUUE6lYtRTDVAgGQ==
Date: Fri, 29 May 2026 06:42:45 +0000
Message-ID: <20260529064243.2064188-2-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6063:EE_
x-ms-office365-filtering-correlation-id: 159c286e-2583-4982-17ab-08debd4d7dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: Tx0a55BvsY6m2Wov74prE+zbTZ1uwGHayasAMlfDhZEMELYXMy08ve7nPHsTX9RugXVp675HWC+GgmlN2MBxwLiWq+HCM6VEjE9R6iyStYevSq7PeWzOmdzOyg7pDvYvAEPRch36h5hWOcaKfmX1uGKARAP2xE3sX7b4Crni6iNNXYkV+OqTLagxBzOFOVRQxjlJQVxhnnav+GXDi82PmhmlR8lb/GKNNHHZQ11VtyCnThyyty9kG4beomgvTR/CJWxVzBcA5HAxZN+V0Y1NI021x0jvDp4QXE2rwdGKTxFy0XCzHC3aWLohpzMTqd4qPRo3THcZN6hI9CVJwsm0QuLTqh3PnQp+P+Rdd3D6dM036u4QbNqUHelcvb65BQKAxBWr1S7naHaftD29iiRDnNhJRwCSJNc3u4hq/qVv3L7SIFW+KCjQPtlZUWmyXsVkW47Cy287F4BjGDChNvEetKYM82hmilh6mwirU/1twQbw96LzxLLcWFlTPZYNHqyrTv7WeTHFrZhXiVX8xNcWcEblA3Wk01ZsU2DpjppRm1YxdK0oqp7eEprTzi9e295vvCG/aM8njcnTE4NfZWs5yWsTB7P0PGBV3m3iJ3RbauepeXJnHinR5kKw1qfd01yl5ndTfhiRYVa/BYTNrXWikmqeUb7BkrTStnw6GzJ5rGn5w5y0slMqcpuIN21990CEI5fxYo6lCfmyYxrwXorVj93qIZCRxDrLI9tFsnTRbyZwSfk0PYmbFtZH4AgK0/cN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J/JJ9xPzVkjh+9ACCA+WBxLZoiftcFz/4sP5yMdngQb2ls1njck7uGMmtA?=
 =?iso-8859-1?Q?wNqe35tYGxiOk0JJXwwPT5iopMs7Hjy2Bw8mKADN4rWb8I3u3/WIvZKZGl?=
 =?iso-8859-1?Q?MAQdrgWZDrTpAINtzWkQgek4GkjJ1UMhAcaMr8ZTccyrAd7O1dr+P9Loo8?=
 =?iso-8859-1?Q?f0aY2U87rpe07huL9ne5CLZEV8Xf+XwbCkjT3HZvPI9FsQ6IRyHVC6XZ5g?=
 =?iso-8859-1?Q?AGqZeVlZs0zh1TIgM4j91M6kMd7jtbcFhkiOr4e2sNODpfE/YW1vpf8UB3?=
 =?iso-8859-1?Q?tU1BlojeQylExtS/BvyGoSovkimNM1wm4lXoqDtR7XRhCvuiTWU95Bdc09?=
 =?iso-8859-1?Q?PG3GQ/HmBVAhLfY6EF3WtP6HTD34ul6kINSGOCv2FdHIS8FFC58lwLnsge?=
 =?iso-8859-1?Q?HmY7oIM4nX4peMyAAzbQUZPU0/EqpceqFJUkF0mC9+G7G8V8rviUjwH/ja?=
 =?iso-8859-1?Q?hDCAF0jgQmO3MkZktExIaCW8Zf/EHuPC+hQzwxLWOIjcaCesHWVSatwkbF?=
 =?iso-8859-1?Q?7IwVWdtIDH4ibLJbKX3VMzZQpyZallENN3YsbdZVrjO/rKjdLDH0lpRAZa?=
 =?iso-8859-1?Q?CiYzUC1VLZ7kXpp5U/HqtZkdkpe7jo8fdN66GeQ0A9f5mY5lh8kMbysm9Z?=
 =?iso-8859-1?Q?esr2S2ueKvMScz13dZL7O3s5HnoEEkv5kd5DT7Guvkh64H9b9kIpg5fr7z?=
 =?iso-8859-1?Q?CLbzroem37p73wKQ7h/dlaEVye2SyVrUDppiqL0DUycgwYgRQxVFXm0Lm+?=
 =?iso-8859-1?Q?81YdkNsJB2OlQnkZZK6uLVV1urZSlg+Qo0mz1WCMkgjNxxokQIM8yPhhLq?=
 =?iso-8859-1?Q?QcykZPdCQGnzDKt+OvGCneWJKjwPBdO6qUJWPFBaI7WWxSSinU4fRQ67fu?=
 =?iso-8859-1?Q?ayR+3nL+lL1Q5BLwfAUMO2XR+o8ldSU1QB3JDuYpUcmFM81He48HOyc/WW?=
 =?iso-8859-1?Q?J+FNhEVlImKZsmERfB0rAEE6AotkZrgPF6d6e8UhlIzqjzygWgWNxLp4l0?=
 =?iso-8859-1?Q?5QI2RF2/vGRpIjoCCiLA4BVXLw8zboPSpeWsb7ctT7GatPm+dV9KFjCOLW?=
 =?iso-8859-1?Q?MztEte5Oup61XNNv2nHIhuxixujQhNhCUF6RCcN0zV7F7Efo9wQqWCAy7v?=
 =?iso-8859-1?Q?o+RlM77xvUdX1dUApJ95lAepHa0JcpXDD81zQ4zTs3HrU65StpFBze2xFG?=
 =?iso-8859-1?Q?CUIUZb4E9GBjRSClvTuBX18ZZreApDdEggpSPKx0F9CnJUaTMlEW1g4Pjk?=
 =?iso-8859-1?Q?JgRUCdtOawYUGk0RWX9yiwRo0JS5Qtkj+DVubAJ54glYTlZxhpdyA7R1oY?=
 =?iso-8859-1?Q?0XhhkFBr6zz92O5tevD7L+e5kfqFo09DPExYCE6IeUUs0t3fGsmWDhCXRf?=
 =?iso-8859-1?Q?gZvgvYijftQ+uB14yjUzEJQIZ/SqFRpzU+GCJViRNbmN6zQTJ3MqiGI3Wj?=
 =?iso-8859-1?Q?1lp3ZVG+/pXanNdzLUCygh+DL8FVwriSjE0Ij9u+2GuHudvOvNK2wXNTB2?=
 =?iso-8859-1?Q?YBU0JYJx3Iz13vITv3IkEbOxIUMdh4KTZDajSv/tpeVC+2rnKGRJXRBKSU?=
 =?iso-8859-1?Q?PxXK3cPyTFcPOdA2JfIIpcoxjNkwUAV+DOgOMwD+Sl86wso5xS6qQqzpph?=
 =?iso-8859-1?Q?p8tNMpmNksUdPlcl7QeOwuFX1lC4F0F33HIQIEGhIN0PD2mNFWL9HiMoMF?=
 =?iso-8859-1?Q?Djd1UCYozxPlcePKIbUA3Oz3dRp/ehNKmknVx0CC76bkCaEw1dDYG7mq8/?=
 =?iso-8859-1?Q?qPlO3jZzK9busegT+tmltrjGNmWw0L2HZHdJGbHow2678FIt8F1PgF8uVN?=
 =?iso-8859-1?Q?mtNVYY4igA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cf9cRZqlqzFQxWRIV56UBQEwl0xbv3Bwrr2zXOnGGdHp/aIiOcsnPFU16nykLqwguAg1Xx58YjOczikNGMizq/QMinob0E59WcV973LE3HkdpAh9J3tmB2hSCdFrkLPRUMI5gd1ObTiFqT5Iw9CyEIikoHxR3hqJ/LMub2q2dawOUIS2QPPKe1zk7hkt2LV7A+ugsQ1IwjP5FFe38gKEYYvWVJCVbPx3B+yqVOnREEh5jlGgJc1fcvFcyM9KRaF+8k9u5zKnumsdKNmYz9FdwfDxIBk3cf77LZqoqByQju3r4puRMOpPLwH48DhrygpWEiLcdg1XFhfNSDN0iSRh2w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159c286e-2583-4982-17ab-08debd4d7dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:45.3782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4efj0imzaWDxr2KDYwIk/uV2uX2zysPaYiYj21OODExSXLOiu0y/LeaoW9cwCFJit5WvR8EhHNIih7AYcx0w+TALrzDGn3md/EkzHY0O/OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6063
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  5 +----=0A=
 hw/i2c/aspeed_i2c.c         | 22 +++++++++++++---------=0A=
 2 files changed, 14 insertions(+), 13 deletions(-)=0A=
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
index 80c4457500..9c0387a394 100644=0A=
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
@@ -1385,6 +1383,8 @@ static const TypeInfo aspeed_i2c_info =3D {=0A=
 static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,=0A=
                                           enum i2c_event event)=0A=
 {=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+=0A=
     switch (event) {=0A=
     case I2C_START_SEND_ASYNC:=0A=
         if (!SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CS_CMD, RX_DMA_EN)) {=
=0A=
@@ -1395,7 +1395,7 @@ static int aspeed_i2c_bus_new_slave_event(AspeedI2CBu=
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
@@ -1638,6 +1638,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->check_sram =3D true;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x1000;=0A=
+    aic->dma_addr_lo_mask =3D 0x3ffffffc;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_2500_i2c_info =3D {=0A=
@@ -1667,6 +1668,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x1000;=0A=
+    aic->dma_addr_lo_mask =3D 0x7fffffff;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_2600_i2c_info =3D {=0A=
@@ -1691,6 +1693,7 @@ static void aspeed_1030_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x10000;=0A=
+    aic->dma_addr_lo_mask =3D 0x7fffffff;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_1030_i2c_info =3D {=0A=
@@ -1718,6 +1721,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x2000;=0A=
     aic->has_dma64 =3D true;=0A=
+    aic->dma_addr_lo_mask =3D 0xffffffff;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_2700_i2c_info =3D {=0A=
-- =0A=
2.43.0=0A=

