Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F1EC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgI-0003ww-4j; Tue, 02 Jun 2026 01:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgG-0003w0-BJ; Tue, 02 Jun 2026 01:28:48 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgC-0002gD-Ua; Tue, 02 Jun 2026 01:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdH8eRauh27mqIIskwNYQzyK3660lOdDb8pWTLn5PxvZEw2Wi7wE4dGjX57QrhN+DwDRsDUpVQ0zMDNuBhtQcGKw9BIw6nKzvaMo2xfUulZGo7CfIW1DxordM+QLTltAnWtkAKI13K63VHJMZMYcWRd2cyHHZru3ik+gE8WAHPfDcc6+neeyNPQX9/QD0u3FdaRlCGcOu2eH83ym6JBYYCItE51bIArtOtDtOM+OiQCZ3HSdVZOIPKu5wkwK9SeuYLekfP4SVhhOAUaZPLQ49OAfiZzPVXA2vjYnmPB93eib3e6uPKzdHCNdPM6LuVg3MT24/Ce5leLFdMLBBN/MYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dkBRuDh3Q0xUeKqDfKX/28puNKG0/vbDS3aJweapr4=;
 b=H6+ky4G7AiJvivMvZ7/iQqvnExzrITGw86JAGDK292YpxUUMoslUXH2rVDPKevmRDZXge8LqOrrH6p6srdAN1XKJcooJVYGu2HqLc9tA8c1a96cpEon9FvZAymRI1YsP03KL+sswUznkQBSY1NZFsenqmzMAXnDwP5CNofGLNkrUKU3M2WQeHJxh2SGMZcgrY5kVIbFfev+t145Kl5n0ZdnhDFaT4hLAauc5UikhTO3bfBVERV/tN/s2TOJX+4akyF1PJ38gfYamt26mK/xz2DAKzAElYC2tN/CHaOM1qf553RPmYsd6YM2qX5jxX0av/FJ8m9g6Gmvyb2ocox9ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dkBRuDh3Q0xUeKqDfKX/28puNKG0/vbDS3aJweapr4=;
 b=F9FY5qfms6nhmbJ5qz2yXVW3gJa3v35rS5pk9v8nwMSwi9qHCrCcTEphFmEDPubfce9XeIRUi6grc2So26dXqXeKSEyXHEWK2UNY9eGmEz7PuIMWk0GZrB0UCkwD+tf3gD53b1zvoGx20HlFS7xltrO5r+RlKp/wq8jxqpb1W0vgxSZtXfUnNWx3z1RJ0IjyUEE5U3m/MWX8LrGSFFT8PZDE4SpA+8gc611+dIOuawOiFgd3MOjgMzHt/va85dR8EG+RsaxQz0ToO+Edz8BP38i4fAeysRNyWFEqhLtSHSOJdcE7dSw+OvSeCbx33979wnx89DKHHXHsS5b6BYlQYQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to
 unify DMA address handling
Thread-Topic: [PATCH v2 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask
 to unify DMA address handling
Thread-Index: AQHc8lClc/pwAK0NSE21bh5LfoHzoQ==
Date: Tue, 2 Jun 2026 05:28:29 +0000
Message-ID: <20260602052827.1535299-2-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: 525038bd-fc05-4e99-3d6c-08dec067c7c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 1bono6VzOFNt/5Fhp54OV8Z6y0WxcKHFPP2inxOV3vVVdTJhgwdIrOOpt6VzKiv/Z4RwSfM1xIdNIv+9NlQdR79/xa8GKo0GY6quOTdAGeZZjq0mTFdCxBtwyRafqkyq/BjdffVmnoUhrUn7d1kAaWNeMVY6oQC438wia9FqncuC2rbHG9I2gI9IpkVOVnmhGlrEg3aIuPXs3cKcV8IlRSyph6jndHHL8NQs/yvcnNMcZJXyZMdKdticZJ+eB1j3697VPIxtt8WOwcx+Qex7cqh51GcZmVxo19wAIFvwsERRa+lhm4wK613V4JUZrmrqfTcJDgtcoOBpBstEPouh2dfcZgbOghREZeKRudr/3vCjAzfnjO+vtSfTJj10YoWoRO5avvIxUai/oxsIIoXAPsoGttYw+/mtl8bkfxVezv29q+guSp3JKjF0m55BGuziR2UAHX82KsD/MCyBVpkz8RCCNXAwWZvXHS2vIvecRprQLTVcqiVnZkPgsLytbsh+54qDMp2juHn4Upc4UgZxFuDthwDlCEHIpogXeaEhB6SFA2IS5SAJi2PREEMAutRWHSL6gpDDzJyI38nHUkfrjJuxpo5YmFb9E2xeh7lNEzqZua7yumlG20hES/JwCZTbykg8ngw8MmkMiYgkmsKWt2pTu7+f6WqxM8iG1+fPAFS9Ooq/iQlNJnTog0zkI4jKKKpLUFFMY8wPRGLKZSUVl2xbS10dFs1ft0uIwH/Dbxk/qfN9pMlBlE5V9FqWNakW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZFcu2fJFnyQA2pV07lHw7UQVrfL7rcXAM2nx2kjGOI24QaVzTqpwTA8fFJ?=
 =?iso-8859-1?Q?sEb3gy6QzPY2MNcHSaegiOCxO8Pig5U1184eIJjCxIijPE3rgr4Zg5LkFb?=
 =?iso-8859-1?Q?xpynCMFTJs7L17+9gEQrRuOjBv8wsDm07DrgQhMsohEkSYXlUxnfExKj5M?=
 =?iso-8859-1?Q?PssAFWg26M5dFpWST+DYbSZ+zcVfWGDwdpJ+oUW4HN4Sh5wK0Bt0lHnfyI?=
 =?iso-8859-1?Q?TTzedbLEfrvmjZyMCTCtfLktN0COPHjnwnhj98Lk1qEddWSPcCaoO5b4+g?=
 =?iso-8859-1?Q?3CJBM0PlWOP93ByakvjKN/ibpBUA9UCbxCvMdi9RNa0ExxJqzGxagKwIH/?=
 =?iso-8859-1?Q?bvxvxWRJyFq9G0f2AlAx9V+V+wtzUmvWByyccKO1DZ8oIk6ZW2X+jwFa2/?=
 =?iso-8859-1?Q?0lLgpB8ThF2ra4B+noAYX0cJXZmgPZJvf8qyuKwzkJeJk3dD+/wx5epKVQ?=
 =?iso-8859-1?Q?BURNySJPIcIH4sfWdBKoYQgKwQBC2QU3Re8lPHzzzdZFESl0XJqVhfcB5z?=
 =?iso-8859-1?Q?qT7eOX3LIon0mnLbUSqc/FFkYlFS12V5yAZSJMHrHef8aFg86sEp3NxKwU?=
 =?iso-8859-1?Q?LYLaTNIjhOGygeaDqdgYiLPLy09CPE5HBaOId7cwaqPRotwzR1TVLnQptI?=
 =?iso-8859-1?Q?Rt8AEVCDiQjNM7zKN9Q9YcH1u+HpSyMKCxG8sE686GAOFAXj9dLXupOvax?=
 =?iso-8859-1?Q?MUpobdQTteyibU7Vn5oR0vL8ZARvyEuCCUQqgt7aNM9K9VHaneuVVb/zk0?=
 =?iso-8859-1?Q?L3GLcvm0sgDlhuFX3StdEVgeYi4KX8oeuZeAjk6D6ZH8tjK4E7+qtmGNok?=
 =?iso-8859-1?Q?Pb+Yq3L1F+0Do7yutEJDa/o1BHb2eBybzz38nLLyahBfaXg2MDUd66eeVJ?=
 =?iso-8859-1?Q?Y7xtxxkjksCDmKkc33Q7oLPxwHCpkn2ORqWZ7ioTN4CkqNDCqgWCr1swz7?=
 =?iso-8859-1?Q?8EhsGJnAP2BDd5RawtywaNZoNKfJReammULjtPW9sfbppBXjgZxSAzKkf9?=
 =?iso-8859-1?Q?GwHULZNl0FvexV2PvY3ot6NdKHzoZ21jjKMm/HqGKhT+8fItAXVaVYNbkQ?=
 =?iso-8859-1?Q?7DgSusc5LcmDf8lSi/RlJON79uXJT/dBH86LL6LGVh3cUGtvhf457I0QFa?=
 =?iso-8859-1?Q?efw7dF2QocCP7jyu9GHd1mpgI3EgVn44xhW5vSv2kA/+mWDsaeNw6w31Gc?=
 =?iso-8859-1?Q?M9nt18D4rP/9C3xjUldldkQDN8HzttbAwyrJOQ1bxLqYO0cVYbi1R/xkDb?=
 =?iso-8859-1?Q?bKz+K1DRMYDoAQzIrANLiDabxS79xmfIksESEtSAiNtu0JGbEshInIxVyj?=
 =?iso-8859-1?Q?DvzCcPP2s1HA2UQmJ9NTtCphsTJJR8gOEVf+WwqhUvV2aoL2uLB1EbHoNv?=
 =?iso-8859-1?Q?gvXFLjZ8itn0dQxiXdhOxbQrTAFcw2l1f3LyoxK9ZQ5nCtKYC8BGZNm6Z8?=
 =?iso-8859-1?Q?AqgTVhELqoMabZwPFEDTGpvvJPDHzL97Gr82WByPGtXdzp+mt15axEkk47?=
 =?iso-8859-1?Q?wDKLX2hBd5LJMu+7ScGEv8Wm8B6J+ZmlX1haHOG7AfeS1me8aLco1isxn2?=
 =?iso-8859-1?Q?r+hPtWB7RGqm3KxnVUzVyH0rMnTckapl/x0wvX2KTUx0a6gOC2GR+BlY4t?=
 =?iso-8859-1?Q?SjwWtYRJg7e4QlHoKTCNksPXuWAWhzVOculoM3Ctso5uk+iawy2wJFdeup?=
 =?iso-8859-1?Q?kIPRiPKMO+rJCzsYS4ujCZrBc4BS32KXwJ7Se4M7CCTlNw7/2et18cFLCm?=
 =?iso-8859-1?Q?816dl2L9a9Bxigj1/+ETZZQSoMhP0l5xlM5uxxQPbQcCg761CJLXTRQuxc?=
 =?iso-8859-1?Q?dI4qfkWbxA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UdpFaIaBA7xJI58keZdqMDRXLqnxpCs39Gbc0S0mg6F34edoOj4LqEEOIjDidnBaj6Zc+Vd5Ily9nkA7IJkC3PVxIyo8CJk1lLte3R+1XrQoH5RYfm5XBUZj52BBcJeLbjZHNgppAwYaCE7npI74m4W3JhUsqQ8Ie6T10R1RbMsLdMGAFLS90n5TjMeREKWBGrDIUAy9jz9QfZfmUR0rI2bRNvFiskNQXIimCSa1DqbZIh4sHZSJhrRz2vcS0gLlTu1Tvep4OlfUCE8qoUea/9PL9HidOEmddZvt/Nu2vxnpsRqa2QrRy0yS2Qirxjixy7F9f8zyvOacK8OubugKoA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525038bd-fc05-4e99-3d6c-08dec067c7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:29.8389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euTbJA1bOCPnJztMC6YuWFQZRuwv+6/6jbO9syQSVxrL2QdVJHvfMYDaxQgM+k4aPSbP/jAUrbxjifBmwoyyUzBRSSlEMkBRkARqnv4IfzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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
Fixes: 1809ab6a67359e0876981cd05d2a50b2843eabad ("hw/i2c/aspeed: Add AST270=
0 support")=0A=
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
index 4a6732a185..a6b44174f5 100644=0A=
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

