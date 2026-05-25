Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055A7CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu5-0001pJ-UJ; Mon, 25 May 2026 01:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu3-0001gj-5E; Mon, 25 May 2026 01:31:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu1-00038d-J7; Mon, 25 May 2026 01:31:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iivtB3ntIOuvcCuRWVBymD8nXbZtPz+szxdySfqd5bMHYAo8JMpKDM5aUYlvdo5Qt3+9wBKuLzu5VAA9b8G/LBE6UKRF0NU2ayjYNErI9rF9tglg25DihXfuWNKGZOpg8zR231/i7IwA/RAT14OwRjeRYq60lm9KkvjPI4UAHcKtage5vtLHIjfTGK/UXRb0rsmGwheUXieTDx57CHRN+8zMolYU6k5rhi3BN/ynw9s1W570uOsAJliPrD3MeKFl9LBd6A8xqe89lA8wBjfaqkz5cDIsNCQb+lDw9ECBdgRWG+2NoW09jmcZhx9AjstKRQTAm+N4on9nvl9qwCd8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggR2LPy1PFk09TPhHeczs7kfdNswf4x83nWpdxv0FKA=;
 b=MioZVulOQw+HfNr48GWopT7TQLFznfgwfVzVFRKGBlaP/7kUGuQUHXNQFOCP/u3SZu4+GIWdD6wqDr74G4iCDeAGu/fCeYuaBE1urmqtbN7V9fv8IVOETGyj/bwdtmy5Z7aXg83h6SKCfyXL2SBw6ZO9a5HXQbMnVbFs9h74xrlzeJKFjweImcTHFh+Yw8voamC5NrEMNiK2iflqvh/mE9PC71ukMVzPGmwa7jIBi4jZ4O80Af2klw66jahmGnf+ox5AbjzYnlCDw2SXCUymGMsq6U5JEdT0KnWWwd1Z9llJMpq8ExUuFoSZ5tBLbYGTkEIzA0eSVqRwdXekAAmJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggR2LPy1PFk09TPhHeczs7kfdNswf4x83nWpdxv0FKA=;
 b=dxYmhF8h5gWWpdLhlNtppliS8Gqx5OCXVaL2RvpBEP1UhhY+Ptla1TMudhC/0K1FQ1OYOFO4b+4ml2d1YDQhg/iBOpn85/3mGZ455jwWZQOjCiTp8rClwebZrkiaxWZ2O3/ooHYWbCfmK122Rj8D10ZrdzlgKmg2v67JzURREU5zeuu2bhc7DmxOQGDWM+0phdHUJ3jR7dlNm1qGSvrAu6KFlWmGx5Nko8z6Y2Wyz0OLR62enR6QzZHe4ic+hJosPtnufab+MeXDJKqkKRIJztSBTzmw48Llzj8B1I0vprx08OfFt6iP9LsimdoJ1J6ZhatB3dFPRtrrXdRQdFPIOQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 5/9] hw/misc/aspeed_scu: Add AST1040 A0 silicon revision ID
Thread-Topic: [PATCH v2 5/9] hw/misc/aspeed_scu: Add AST1040 A0 silicon
 revision ID
Thread-Index: AQHc7AeiddfYCYXNhEuNX11lM2df0g==
Date: Mon, 25 May 2026 05:30:44 +0000
Message-ID: <20260525053036.3305181-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 2030dc82-a7ad-4e0c-2f05-08deba1ec4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 5z5eROoSKLUh5Mg+v81KjYbDxFG8bkEE6GnCM6RN7sZ30fhQjet+UI1WRt801iGSVvUXP2S1cF+8i744/x1ryjyF9XeIIXqd+FfGoCYSTnHs5GMcMJ3DfEXJW+hV0PsC2CSU+7VCoLEIFJnvqS6fb/ec7QyOX1Xhi/q8N6Ze48dFrOSXAXYQ2gey/VI0C5I/ZhFRMfLB52fsFz04F5vcLQOZZj3fPklcOkIQZTg2royOr6BolI4IYYf+Bet7Yf6d6F/84sHv1iE6XUAIOjwT4YlSX0bJiAigPARK2PufE21Fie2X1DAsZY93+ZTsoJPHn+w51Y0MbcWSb1xBcxujiiAVOF9PekhVzYgqOZYqdAPHl2kWx1sb6Z3qgblIqFZQGzcX0MR/UJylQb/tHrKdJu5EOMRTfIvM4mKvSxwSOIazZ4sAOwqVxNZ2Z+ET9+xpPaCuD40IStdNdFowEfxf4uoWbxCAhJB7ZFEpgQbIEgSGrZtmOAnicLUIWM53Ea61bYtns92V2dt8oA8sm1Ndq9mrqRzfHzjHDdFeLZiTQrXS/1aVXaKkiVG5640ccr+E1Be6Cd6IysjahwGKZueCLnGZda6fgULn+GsiQFyvgnwPNEWfmPM5paKKekGCJHycHWVLy3kXJyBP23xv+d288MAeXZ4TsS51jLqBZLpKOo4hjK1SayBaL90p6VZhhrZsoLivhQt+q7B0gxNd0WHmrnh892qku72dCO4HL4Q9+99O3uUaQtR1OafYsFVH5yx194novUf5/Fk8yNZZLNKZ7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UxPEk9YvxWFqDWBn2qePQdZSO4Y9w68Z51d5PpXUx9wutYV3CQvqBJZjgX?=
 =?iso-8859-1?Q?kCV8SnNOPTkBFDmNaSgb5H4GGSvEgruKambA1BDbI/GvEgN3UhdugKnePk?=
 =?iso-8859-1?Q?p6WfMx2gEW1Ic2zhZcKmCwa5Qf4bsV93O4ajj5wj1XIJcqItXbQW4AfRDr?=
 =?iso-8859-1?Q?8GAKcBtp4UiomU47ahdHgyJAquL7bI+dgFY2WNsh+HG+fY/c8Q5pBUMwbW?=
 =?iso-8859-1?Q?d70MV7Ld1nAcZTjxyYPCx2bXUCtAV62bcdF89gT2aqwH4fr2VdSe5hE+rd?=
 =?iso-8859-1?Q?feDXYhEtlNUKfEmu9pLgk+vyfAYseDkHpIxOIM+PYiDfnqPSDHMZm982xJ?=
 =?iso-8859-1?Q?yq0Dxx3AdKWQqJNz9+ZIEhVHg38SbSJU2Rb2ReOHGS0/HmlbPxizByl+K4?=
 =?iso-8859-1?Q?FSOPsrzN/1QztG+LL0zG/DlwiZNC6DK0RB1KzceQD42ZQce1S5740HGl5C?=
 =?iso-8859-1?Q?bd/vy63kYiSq632shw8WWrCjRtYXAw+7V+WD7RnYH5aNkcZ1Kst7a7iV6j?=
 =?iso-8859-1?Q?icIfHuZqYFhms/GNrbbhjNZN+mUMoLrleH0633bL6114pqF7lLKkgR1CVi?=
 =?iso-8859-1?Q?XwMnGHl6JYZpRqpVxS2uW1enEjouMJ9MSQNsucfprhDepFmyvi2D589Gja?=
 =?iso-8859-1?Q?pvhoRvxqzpqwbzLCm0ePqCB181uIo3anyu6VbE1vfjRdd+5qyWXm4zxYxD?=
 =?iso-8859-1?Q?bC4VXOrp+1tYtdrBF52ljcKkXChWBLlwReXaVqBnBTSTtsLmBd/Jn4KaIk?=
 =?iso-8859-1?Q?aJiZuAc+vOatwT9R63d7xI0qwtCRcP5CNeyJU+u0vZ5d/O9ljwjg/RLbNw?=
 =?iso-8859-1?Q?HhN55UFL95p1+PNRVyUENrkQA0GY3y8ur5EOFqjWZqrICgums//LkwaHp1?=
 =?iso-8859-1?Q?YjsKdpo7B5H5byIC74Oh1tNRstoD1QLg4TTC+yFgt46NWtfMip7pO6hoCb?=
 =?iso-8859-1?Q?124qx+T3iv9HveuLOcVF/m5Yl9HSa3cUpHtrp16zaOET5/eLmdHms/8j0F?=
 =?iso-8859-1?Q?jyQdFGIAdbTIdUJHwXmkxbatOgdCH/ODFdcsu6Qyj/moOt2HtcOPtDJAei?=
 =?iso-8859-1?Q?U5On8z/Oevw9T/LnFZdaYeiIikb7e4RLG1vtcYIUR7mq0B6TJ2rYtsit+0?=
 =?iso-8859-1?Q?NMbEGCVN5mrhy6ffGTrBienTwWRxra6IgzMgZxAtOOSQC2w70BwiDdDsAu?=
 =?iso-8859-1?Q?IsMWAKa1a+Mv4NF+iAZ+fCyFyF7ONpg9alD1k5qy9uPsy8MY7k6D0k1OOk?=
 =?iso-8859-1?Q?e/4ak+vNGENR+sZlI4vLBxjqcG8S45Vj376s6r06PqZTTBLrbOSh3xbZPV?=
 =?iso-8859-1?Q?P5xNthDpUOKlONv5V+E0J4h00ur0j4ZK7qclg4w9H+EhthtObE6ZYTTkWX?=
 =?iso-8859-1?Q?mghuVsIrST7xO2D199O+PTvlwBLbnQH6I4JysXTz17SxyDImgS0O4e+Dhp?=
 =?iso-8859-1?Q?wpvC+m5qN1wrag0aRCxE9I+48OSCT3y3sR1qtKe0ckhzb0vevf+FFHpLDq?=
 =?iso-8859-1?Q?l5o0TojiN3U8YDJB8o5/S9bcv67RRHnIzmw9LmFvx9BQijJtN7PtmxM5BR?=
 =?iso-8859-1?Q?YU+ZLxZInFtXBVX9yERusSg49d0Vc/c4krRZTfGsxX1/2fPrd6oHViVYQa?=
 =?iso-8859-1?Q?aAzK04go4+j/dq+b2JTprBFRZJDaa0iJd61JMUGf5tGWoPO727dZ27iOM5?=
 =?iso-8859-1?Q?6U1nA2M7c7camPGGxvU41O++IF7+T7wdAbbJVrdCRKXcNDkWG3ybn9+fYh?=
 =?iso-8859-1?Q?5l9i8BChikNxk57Pqmmc0dV+WRQJp+QDCK2SXp6klGJM3F+XK6krbvl3l5?=
 =?iso-8859-1?Q?JpfMhtbMDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZulUe7/UymQfmS9u6pQ4oK4aauQnIiLZGjPzk/ESISYwVRvS39d3bCzOjtX2Yh3kQqvZRbzgo95a4v6OpIrl9Bre5JrHn8peBhhHF3UahH7f2667ihL8NENXwRqvdEcCYwvcqOhvG6yRyYxv89lMuolqTLQtGVXR5M51Yo8wtpf0Q06GOlgaBcY0TgempqIij/UiHEVSr/FX+nAPi7NviwXSXcNyTJ30k5UIqGyfaEUVxmVVqYNs3k5d4OJBWZ0eVRHk6ZLafr6sno2t64Hl2aQvRsgsd5ThvTGoFJc0SQ10PVyEsDUZo5gQ11XI6aiEYY8E1l5sDwP8Va3YEo8uRw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2030dc82-a7ad-4e0c-2f05-08deba1ec4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:44.5526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrAQ5W6Cdo77xxsUQpQrNVKUQuV+t0JjSfMNFYFbGjAU0OpDtxoj18K50LxlLJKAxKLCD2kvYFTu6j/yXT74rv9tCFxoIthjQVd9ct1xMnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
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

Add the AST1040 A0 silicon revision definition and register it=0A=
in the supported Aspeed silicon revision table.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 1 +=0A=
 hw/misc/aspeed_scu.c         | 1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index d003955428..c30940ab76 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -46,6 +46,7 @@ struct AspeedSCUState {=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
+#define AST1040_A0_SILICON_REV   0x81000000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
 #define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index e4160356e4..507dc4ea9f 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -562,6 +562,7 @@ static uint32_t aspeed_silicon_revs[] =3D {=0A=
     AST1060_A2_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
     AST2700_A2_SILICON_REV,=0A=
+    AST1040_A0_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

