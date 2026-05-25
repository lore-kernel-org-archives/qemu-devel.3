Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC1BCD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu5-0001ol-Nh; Mon, 25 May 2026 01:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu2-0001cT-4n; Mon, 25 May 2026 01:31:02 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNty-00035Q-Ut; Mon, 25 May 2026 01:31:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTb7bjlX4wogRAZ5qbKDLU9vi/effUf8sNiQJfANYPoJs5qn/wWs+LOnJZ2ZUs7ulvZwAHnr8FwkHdtGpiwZG0DwAKjlVy7dKxrT7caD+WHSqPrk1AgSH7bGYoVkDYdSAit7oYU3yeFTw1GnDfPy8V4E/sKNXm8jrjhl7SvfiLHKrSh4LDgaAd/UHaL97953CcLdDh+Df/0crCcez2lsv3RNadoenW6ikSZzAVoM3iFHzH5qnAt71HSTgyH1gQx/Qkuya8WNvNFA+ak4qHfdk272/VdPwkxM40LSmdri+EZGNcRctAbgcT8LhiST7jRK53L1m0giufXpGDxAs50O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyrkSZTf7NQbMPpUKbV9ZU+cTg/mSng0DrZtsGUGrEI=;
 b=Vg7vofUnbmKR2lY6Eo5KU8ePYxP3Z/t/k80kd3nI62KzMRF9WX7X/wtMpEhLhZdgM3T2seoA5rp2m+8zZ2cEmGuwqnnHLUcrWAxna15SoaVYwBtUWjZZKMkqUTfNYuFxQHZj2xXLLBFD6TiD4FZ/CDQhFySovYgXNKaodYM2xzAXY8F7yyskJtwYUMQ83XSV2XlfzUDFnOUhI7rvqG81bVmB46Pb9fDecf+jR6rc/4smXU2asn5xbgx+HBDzRnzJvuORsapgEfSTz5sbvl6rB+4lps/kyLkqPtGokzuFZWYAFtqME9m/LG1Uo26mlElGPLQ62Uonb+LvHYhpNiVL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyrkSZTf7NQbMPpUKbV9ZU+cTg/mSng0DrZtsGUGrEI=;
 b=SbPbPPs/uLQBi2uVpUWeOreAR/od1rCV4KlHxvDtBjqCTybeIp9K9zsdoyIX4vYuhYmonLjDA5c0vI6JgKBy/YK6xfncMaz4aHLvmPBQUyjECEegTBrvCVMd8RUDTpQskmHBpr93kOdiArDP6DJB/6SL1yFZQj1nkDtJhMIJOc9jZm3QnV3idT7zSA9zNt80y/MAoXAvLHGVdBbkj5XP2UsSXu6DHq/ungfaWzuUp8vgdQmH0VtV0mJVNDBrgBVAwp3gS2lNT0bdRchNbaTSlFULO51q4XSYo53Plc8Vrm+EzC3gJTL8eBCm/dwddx2/jSEaaZK+dHgxzjE97Y5Vxg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/9] hw/arm/aspeed: Consolidate secure SRAM into SRAM array
Thread-Topic: [PATCH v2 4/9] hw/arm/aspeed: Consolidate secure SRAM into SRAM
 array
Thread-Index: AQHc7AehpDZzU61O+EOKOeO/b8oEaA==
Date: Mon, 25 May 2026 05:30:43 +0000
Message-ID: <20260525053036.3305181-5-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6657:EE_
x-ms-office365-filtering-correlation-id: 318f3a96-802e-491a-13c6-08deba1ec40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: TS6vkeU1TVPtcU86o/WkbuCIsin5BsUTPqSix37ZGhBy+wBEYxyHSMxG95I/Mga3K+3Y+O1Gf5N0PKFEPc4ZtIt9ZZa+ITo1h6W3GWRwD9yNMKZSx3KevnQRYgUydfpmKxs5Akru9p86vUIuI3iNHjYjaIc32J21ZvnEe6rijhrRCfcQRIFKJX9tV6qFXiLb5qx3hsScPrGLMqX2NEdu4b5Bc9yWx/rBRgPuPHSv9pCq7jbVrZ8cLbEkZpwaw/n49trGp0RduHNDIGN40Yvq+VyUcrCYUKsJMHeYhmMWbqUyZaIJLMAcjqQoMeut/+k8c0hEUxbG7qSCIqQKRqLtkUxhYli31ImMnekPxDcVSnPUlaRh7Ys0ubcC08Cc/e4cUcaSE+imwKM9D7mR3nKgMyQJVR6Z7alpYwzzTlMtkfiQ/XQjrUeTpAAWF0jmQW2bR9vZRPb0AvjZsr3n6cs4PaRQui7kJLg27IJVdjFJayePoJrp1K+GtNflQwSXDvai6BQfFaKlzYoS2RwCYzLaio6uX2fAF2hfW4xEehcorX4FEbgoId4NIUm+LrpGN/Wwu1Q+YU2BIfy+mEO2+qTM76TRYZdHrAjx/5HMkkND45ks2El7EApdziiSs+6UJxNpi7ejKe8/TcZle/g7bI2unRFfn08bFeiZkjid7xmV7t9eUt+jSuTJzI81DO6SbUJK5lIHs70tkt9cW5sjMecJB+zqn/BNsnZdvFqUMUw9QuwdMNoSGhsZ806OLm6QbTmmy8vzrZvFfR2dhwN/iha0Yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UeuQdmgdFydNxC4b3eeMKOzJl9BGMP3xLER0jZllBSRF3gYnpEP9V5ZZDC?=
 =?iso-8859-1?Q?L3fu9c4ihB67wsAZezhjL6Q8/KxghKC60VuJjd04VDku2DWueXAbFgjLzs?=
 =?iso-8859-1?Q?9KCeLDy03iCMzE5dIFjmaOMgObm0NC63WlmP27PKcYHw1lmGM6ECIfb6m+?=
 =?iso-8859-1?Q?lvJNOFdL0q/qj+lbHo2ya9OQNQSnJSLV7c/9EoRc2Qi2kz2qhMnFN9P7k9?=
 =?iso-8859-1?Q?IgfHSwAO4pg4/BlffXQqjfm9evv8RcAW/fW+mbqUKgROROlKrwXRMDLdIs?=
 =?iso-8859-1?Q?WvDqVgT1egurIm5v6dXvqie0ITby58shhY5eTwwHx638/zbusRxPNyV2fO?=
 =?iso-8859-1?Q?cr19l0THOgXHGKIACjNQgFJddXLIfBcvxEZQJDSP7sAI2u78IsqZS1GZFZ?=
 =?iso-8859-1?Q?8U1adtZTKwFMVbNDFBhCNCO3EzF2VhR0MXc8P7qffgnljzngaNzv+4PczG?=
 =?iso-8859-1?Q?hTUvVK1H+rgEWojSlTVIJ5pU+Sj3t1HFfwXR45OluENnhuIZ1iWgFcL3sY?=
 =?iso-8859-1?Q?c0rX/yLnlIQK4mdO87SAeGSG1267T0WLiPHa+GUFi5Azse9xIIumrYIvRC?=
 =?iso-8859-1?Q?KxptG7n5IXjdSSOKWMryimc73kDKDl7dYYycVxrers5sDjP0WRXLt9YvzK?=
 =?iso-8859-1?Q?neNvcHUvWmb2HOsKxzNnCuE1mmPV5bW6H+MLSXD3ZloTx2Xqa5eZTPHbYR?=
 =?iso-8859-1?Q?RyfPTAWttkoViMwTOehieKJdh85X+OSmfobW3jDunq8EyzhfBWDydA8aCs?=
 =?iso-8859-1?Q?HR1QINt9eltPiOVTkmThMF+XgaUyGdAAwaaQAmIIuvp+XMCDB34L4RSqpu?=
 =?iso-8859-1?Q?FF0oE/lof95Egd4mNBgR91UO4ev8s5Shzxeki1lZTEx4vtaRJ3lvzJcJ3J?=
 =?iso-8859-1?Q?158P51M4NcXTVasr5kIAN1rUVCzBWQ7suYznsfEtYslJm+RX9aHWXBFLQT?=
 =?iso-8859-1?Q?VSk77xhqtnVuxev1SlzYUnxfogJanDZkiA/CKdc3XcguPCIA6F8QUCvxOI?=
 =?iso-8859-1?Q?SXCgfiES3toroB5Xo39OGriSltc4nvruV2CtpXVHIlu5uj7AL1d0hYk+yp?=
 =?iso-8859-1?Q?x5iSmB9iP+dRZdmmw+ueuyiJ1QXWXX6Ar7gp4jGzEPfEi6FDS5fTaElqB0?=
 =?iso-8859-1?Q?I3pRtu3ALjdebUcOCdsji2SOascYJ/GKRrbe2CnQeX8lHi9pMGtYFsgxJQ?=
 =?iso-8859-1?Q?yA4mpwscc5TBfA07H2qEox4sMZ9FlkcdinXcAIiNAhNR2infhZu8fjiHEc?=
 =?iso-8859-1?Q?+QAl8GCnBrfrLHTEhfrp6wF9E+GnlmIUt3afIdz6y/NVIO8ekJwTUn/u8U?=
 =?iso-8859-1?Q?ga9dfnxe8Qsr9Ym/X8iWo8nV13BN/e8KE8vqrkgH95I3jlgOGY28hiMSD9?=
 =?iso-8859-1?Q?mkbzU5UH0B6OIXWIWmUgdjqxslIygPz+hv6IOQp+e+fm1nAimEYFKolAtV?=
 =?iso-8859-1?Q?W5Xz9jNwSH5de4D3Sg+vhWoAcC6KvmZxmlRheTO63MZwn5P/xsM61h7KYQ?=
 =?iso-8859-1?Q?V80z7luel+1r/XSpoULlhE1rlI84dIc4ydwoQLChdnusLZEixLSPJ2nv9d?=
 =?iso-8859-1?Q?QAh7+0Hca3G2svdtiMw1L9ouMbljt3F1L+rCrFKvS5sQjdp+n4gyTv/tBd?=
 =?iso-8859-1?Q?wAk5L1Mabc62K6ybTRmXtaqfrjGpYSawibRZSDStKQh9ui4a/Pl9T5LE5v?=
 =?iso-8859-1?Q?ENF70PiuAqd5RvWU23gaFxDFbW6Ouvxs13uEROyE+KFXMF9eNwzVbm8GJM?=
 =?iso-8859-1?Q?OIsyDQiv03so8wDWglPYLYfzOCQo1EvHORpOnmeRrMhMPUYrDrPC2XuNaw?=
 =?iso-8859-1?Q?7k2rh4CMcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J0Y6SF19XPJfub8FMFrupK3FauGYA+qs94PPV0ME/4hMke/qSFm6pI7MeOLBgVQXvLKYM/ts/Xv/Ybex6HI9VedD8ybQTzRqOuoL9SWiwSaml1+ivt/QzexvoPpJrxgnBdeDSgwaZRPojILQuYTjJ5kzIL8HNMljOCxdHZdwNCNFQRgOU6k7hnarDv4bqSxC345qIxSTg7GZI7QOxdk0m0exifNgadDjSoPvtDhLSFsR3QdBcp8eNXI8x/JhAaicm3ZXEZdt3SjPFY6Bk2iUR0WqxUv+ws3NZ+JAfINvxBv32QNtV/2oWlyOWsZ1IZEL1HamhkZkUDiSngqTO7KjZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f3a96-802e-491a-13c6-08deba1ec40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:43.3254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3msSoYaZoalMhJwQMPWSpORf0bPONV0bAFq5HoVTKp7rk3itubHw7YsatV49n135MwIZdSiB5WQxWcrfNjb699gCmW2zyXdulRoeRUaJh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
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

Some Aspeed SoCs contain multiple SRAM regions with different=0A=
sizes and MMIO mappings, such as internal SRAM and secure SRAM.=0A=
=0A=
The current implementation models secure SRAM separately from the=0A=
generic SRAM representation, which complicates future multi-SRAM=0A=
support and expansion.=0A=
=0A=
Increase ASPEED_SRAM_NUM to 2 and migrate secure SRAM to use the=0A=
common SRAM array representation. Rename the secure SRAM memmap=0A=
entry to ASPEED_DEV_SRAM1 and update AST10x0 to initialize both=0A=
SRAM regions through sram[] and sram_size[].=0A=
=0A=
This unifies SRAM-like regions under a common representation and=0A=
prepares for future SoCs with additional SRAM regions.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  6 ++----=0A=
 hw/arm/aspeed_ast10x0.c     | 16 +++++++++-------=0A=
 2 files changed, 11 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index dda602e9f2..3aac144cd4 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -60,7 +60,7 @@=0A=
 #define ASPEED_PCIE_NUM  3=0A=
 #define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
-#define ASPEED_SRAM_NUM 1=0A=
+#define ASPEED_SRAM_NUM 2=0A=
 =0A=
 struct AspeedSoCState {=0A=
     DeviceState parent;=0A=
@@ -89,7 +89,6 @@ struct AspeedSoCState {=0A=
     AspeedSBCState sbc;=0A=
     AspeedSLIState sli;=0A=
     AspeedSLIState sliio;=0A=
-    MemoryRegion secsram;=0A=
     UnimplementedDeviceState sbc_unimplemented;=0A=
     AspeedSDMCState sdmc;=0A=
     AspeedPWMState pwm;=0A=
@@ -173,7 +172,6 @@ struct AspeedSoCClass {=0A=
     const char * const *valid_cpu_types;=0A=
     uint32_t silicon_rev;=0A=
     uint64_t sram_size[ASPEED_SRAM_NUM];=0A=
-    uint64_t secsram_size;=0A=
     int pcie_num;=0A=
     int spis_num;=0A=
     int sgpio_num;=0A=
@@ -225,10 +223,10 @@ enum {=0A=
     ASPEED_DEV_SCU,=0A=
     ASPEED_DEV_ADC,=0A=
     ASPEED_DEV_SBC,=0A=
-    ASPEED_DEV_SECSRAM,=0A=
     ASPEED_DEV_EMMC_BC,=0A=
     ASPEED_DEV_VIDEO,=0A=
     ASPEED_DEV_SRAM0,=0A=
+    ASPEED_DEV_SRAM1,=0A=
     ASPEED_DEV_SDHCI,=0A=
     ASPEED_DEV_GPIO,=0A=
     ASPEED_DEV_GPIO_1_8V,=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index b55f788342..93c81195b5 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -21,7 +21,7 @@=0A=
 =0A=
 static const hwaddr aspeed_soc_ast1030_memmap[] =3D {=0A=
     [ASPEED_DEV_SRAM0]     =3D 0x00000000,=0A=
-    [ASPEED_DEV_SECSRAM]   =3D 0x79000000,=0A=
+    [ASPEED_DEV_SRAM1]     =3D 0x79000000, /* SEC SRAM */=0A=
     [ASPEED_DEV_IOMEM]     =3D 0x7E600000,=0A=
     [ASPEED_DEV_PWM]       =3D 0x7E610000,=0A=
     [ASPEED_DEV_FMC]       =3D 0x7E620000,=0A=
@@ -249,14 +249,16 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCS=
tate *a, Error **errp)=0A=
     memory_region_add_subregion(s->memory,=0A=
                                 sc->memmap[ASPEED_DEV_SRAM0],=0A=
                                 &s->sram[0]);=0A=
-    memory_region_init_ram(&s->secsram, OBJECT(s), "sec.sram",=0A=
-                           sc->secsram_size, &err);=0A=
+=0A=
+    /* Internal SEC SRAM */=0A=
+    memory_region_init_ram(&s->sram[1], OBJECT(s), "sec.sram",=0A=
+                           sc->sram_size[1], &err);=0A=
     if (err !=3D NULL) {=0A=
         error_propagate(errp, err);=0A=
         return false;=0A=
     }=0A=
-    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SECSRAM],=
=0A=
-                                &s->secsram);=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
+                                &s->sram[1]);=0A=
 =0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
@@ -494,7 +496,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev =3D AST1030_A1_SILICON_REV;=0A=
     sc->sram_size[0] =3D 0xc0000;=0A=
-    sc->secsram_size =3D 0x40000; /* 256 * KiB */=0A=
+    sc->sram_size[1] =3D 0x40000; /* SEC SRAM 256 * KiB */=0A=
     sc->spis_num =3D 2;=0A=
     sc->ehcis_num =3D 0;=0A=
     sc->wdts_num =3D 4;=0A=
@@ -522,7 +524,7 @@ static void aspeed_soc_ast1060_class_init(ObjectClass *=
klass, const void *data)=0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev =3D AST1060_A2_SILICON_REV;=0A=
     sc->sram_size[0] =3D 0xc0000;=0A=
-    sc->secsram_size =3D 0x40000; /* 256 * KiB */=0A=
+    sc->sram_size[1] =3D 0x40000; /* SEC SRAM 256 * KiB */=0A=
     sc->spis_num =3D 2;=0A=
     sc->wdts_num =3D 4;=0A=
     sc->uarts_num =3D 1;=0A=
-- =0A=
2.43.0=0A=

