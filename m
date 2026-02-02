Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A808D172D4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHg-0005wb-EJ; Mon, 02 Feb 2026 01:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHe-0005uw-6d; Mon, 02 Feb 2026 01:19:38 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHb-0003N7-6T; Mon, 02 Feb 2026 01:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9OhCc+WWo8n9/gi43he2dCiU/1ExPD48yTPVsW5gnUUmAKJPqWWwgzd+LTJpMe8efnasVLnfXs7d9yLK/iUSngX1X7Y4Z3nlxDDyf6ihpOClli//+5LtKNo2tyzfjDa0Ph9ivB3EzyfkY0Av8MzrUXV0Bb6XQ2u1cnTUtgVj+/Rmqlc6jZ7LFOwoe3DehdzYr86Y6JKomC1iF1Bt63sghlPxw/KmuG4crVTdvyhJeJfDVVDjEz63Ye+rr1Rq6rnWScJGZddBXFcyrJ3+ug+AeXa6Ih6WVsqZSDSDDMWaSDN85LbTxPNabyTFtPpGlW6jRq2WX1qfjyA6VUm2IqhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40eJHEAnNO4/KhDvGuDybS07SXtOUudu0jexI12FZoE=;
 b=UHVMyISbNu9a6YDd6oxGq7Hc0DuudC2OTbNoVa8BBiWMP3hpCfB/e5cvLKmzWuKXFLmU9HFNdV1jv6qdSBdFXb7TRm2pbY5p5tUL84RwsZxSUw/yCkg4AmswWmSRC5j5oNyrX9Fzljo93Dd2CYEJ2VzUFSO1aVquw8r33apFkd8OhtDsblifOZQdxYgzmCyjAVz8um4CQzDDOTzcxJlcpl9tWRKiJsr+l093Ilbu2Req8vmDodRqLFlbYU35eegxZuK6lYJc6/t43/GengwF8EQgAZYrz5A6Uc+/YKZzy10bPhRgbm6EyYYOGK8MFV4zN3JqG3p5snTCTRH2IQ6VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40eJHEAnNO4/KhDvGuDybS07SXtOUudu0jexI12FZoE=;
 b=VmXO8gfnVfNu1iOjfM72Z9N0oKZfoELmuX1lhP3AxNfELhHev6Mzpxi/tBmB3N7vP2sjb74uHHnIjQH1aQCD60mowhptCpSg7dyDcQ0RqBx3rDkEqv2XxD/NTwZnouqHNadKKIyJX+kPbxQiFkU8hvUGPN/wvHcoXzWmFuWgBgcX1ETJumcaHkaImjd0Hb+BFM1NT6m3p/Owubd3P9/96ICXW5vRUs+sNhkTR8ltSFlfPrTloLW8wZHZimgRkHybjwqyRH51y5zmyuGD2rhHeNZ/8vICtLagvGrMSuDr3kDgyfRqH5Ee5w8YiKRqsCG/EW/go2aq5Lz8C7/KKhYiBw==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:28 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 4/8] hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect
 address
Thread-Topic: [PATCH v1 4/8] hw/i2c/aspeed_i2c: Fix DMA moving data into
 incorrect address
Thread-Index: AQHclAvhZfSqfvuQwEmD3qWsKzD5mw==
Date: Mon, 2 Feb 2026 06:19:26 +0000
Message-ID: <SE3PR06MB8199EB45E8CB0A531B796C6BFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: 6e7d2507-67c9-4d2e-56ac-08de62230565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?q+vDg9dN64LLB/nbQaEoRxLKfZpHmW28RfAWlZbir57eIN7XPWiTdIz1Te1h?=
 =?us-ascii?Q?/vwdhsWzPxnMXigJjwBVQN4NOn0AqqoQfijZRi7jO1upGKzyi7QvKzTa7scE?=
 =?us-ascii?Q?1/mXpHiV5xFCZNrWJ5lMtTU/IwPbW6SRgLxaqeNvoaT92M7vxCF98rRyEaRX?=
 =?us-ascii?Q?4QRf2vwGj1bm6RqXqEZb55j7zI4LeHCEiDU9EuJeGf2f109Sr2M3IKxwSnlk?=
 =?us-ascii?Q?3n/D88yTAjvkQ4nu8ocAQ98x6I3FPUwSAdMDCCPU0p+7sLTAcRbpZqV3xxbS?=
 =?us-ascii?Q?5flg/WQhdKvXR7d6/KWCHEB8PfTZae6LiJS8j193nW6vtU5hxwriJTTXUIZv?=
 =?us-ascii?Q?YPCN41l7vmpU/MrZrYyeTo1IMJbeSZ5CjncI2h0FOWHiwa/hGaSHtMfkdX7W?=
 =?us-ascii?Q?XGSSpF7lkDrCUWb99zup4fSx1nzYjw0FYs6sOBkUsmim1R9t325Lzi7ftrrU?=
 =?us-ascii?Q?VG9NiyDePsZJDfXcMgfRp5Svh4ME7Ze2wgo21rzMo4zS0P1jMF8BJXcLLcB+?=
 =?us-ascii?Q?p6chXuWSuPgmXw8c/EW0AUHhUOAkKN+L7pStts5XEhBdwPoA9BC8NuVfSh2Z?=
 =?us-ascii?Q?oucaopz96o7q1/arn8Tf2SCOv3y3Fg4uEUj1MGTP93yzE0CRAw3CsX0Khukn?=
 =?us-ascii?Q?JNyaWwueTm1NvQKeHs947uGXsDMLhlDenjpsnZ8RzkxXAN9B/I6nBjNUkFFZ?=
 =?us-ascii?Q?O+GXm6w0n0gvUBunZ1/QaNrEWNc4UVLehzYelK7niRzO6nPiuR7O6tqYlyxG?=
 =?us-ascii?Q?/V5Tp2KzR3GMUtD3VgtMdUyuo2i/mQv1dJZY14+se6GJfsrMii/mQvwEvMef?=
 =?us-ascii?Q?6WaISDbq0RaDyGqdTa9pjUbNK76TeYbJY3VOjA49Ju04vtmHjRjtLCs+zmZ2?=
 =?us-ascii?Q?SiJmM1M3NQ/TbQ2dKn411F/9z3GSQjlt1wCyIR+sFl5f5JvBx1bLONuWgUSk?=
 =?us-ascii?Q?WA3Cc66zuzJ88fFsXA0oR9LoABz2cSAELTR8IVerXx9erAxjXXK+SwwIR6Zd?=
 =?us-ascii?Q?Jh9C5T63eWfL6Lk1vS1pSuFuyx6fUuZavQ/DenwezY2Dr4ZZ4HOLBjGSPorx?=
 =?us-ascii?Q?ynckLK0h0fY3ZTDXyuijGHtnxS9c6P1tN60bb1wFwX4CX+L94hnlOWsZn21L?=
 =?us-ascii?Q?u0tnxKxkzyKipZ7WVGU4PiDHLmj2UMSkW+j27qUxI6oeJh3Wv7kaHi/JVFBa?=
 =?us-ascii?Q?xRcAODH89Xeu2xTwZqUroNeniKD9HcXX7Szj/5UXSTUgwKJi9Kd+9w7sT1f0?=
 =?us-ascii?Q?KRr8L3o4mYcJvWvdU+aXQu9HecsewR7W+dP5FrCM2jHC9wlC+dHMPB+PBMOl?=
 =?us-ascii?Q?GCWjKVevvm4FhlPIrSviOgO8o6Vx6XFptDF/7uRyu8+6K2js+1P8yNlZF6Pl?=
 =?us-ascii?Q?w3VP79rn7d1fztz2R3jPYOCfGLJxaKrP0Y+8dyYUT1c4iYEt7xD/p598LR0b?=
 =?us-ascii?Q?8gG0uhRL7BIw+YX4fjSLd+WcBkR9NenXAz0Jbjvyh9HUsJoT+Hc75+Y18P9I?=
 =?us-ascii?Q?dSyyeYYEPAaw64mOngP3RbnO7UVCNnSFNU5HgKfoQBy0BXhPg0C6yDD8dWrx?=
 =?us-ascii?Q?D/qavAIjevXFZhUIbCJ/Xue95FLYcw2XtHiTNF6XJgWfDZabJWsIt8C/ZTqF?=
 =?us-ascii?Q?CC5eQALhy2Qk33dgd4jwKD4I4PpSZtDWIXISZTipJIVj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zAU4Dw5BwaC7FidSy7PBCr+nxv1N8g+Ldm+DJTbtoPcOXQQr4vA7Tzf6xkzr?=
 =?us-ascii?Q?CqJt/dzFcRRm4KV/VnjOjJst5EaWI3DfqUHfvWo0FLcPy3MAn5ATc6z9IyD3?=
 =?us-ascii?Q?4R/e5f11qkxibVdzEGfKqUfhNeaqkbTGUVQ0TR4RwzDrUE9EiyYehJy2kWbZ?=
 =?us-ascii?Q?t2ejUCifG9S0L5zY8iwLzWPU/VFD82miweaa/7xLADnA4Msghee/q46GzkqB?=
 =?us-ascii?Q?TU99OgecnwUiXyrDHLHChfoBeZA0uGRM+pbWt5aI7wGLsXqD0SJ6pPJ1pd9i?=
 =?us-ascii?Q?OPZe9miN5vJoa3q83sY0APOYO0ZgMGfN9TBDOOq1E1uebuBGubdwgoIgpO/w?=
 =?us-ascii?Q?ez/2HrhxKACevUqxLmWuxLVrtw2A5RAWzXu6GIan3OtCElPl3MOjQr0G/PbS?=
 =?us-ascii?Q?EDbP7qB1NmpSJFrPZ3yQj/4zb9JniEN2a+tdStc5UAhHIxTcD5+KzNyu4a9T?=
 =?us-ascii?Q?79YaTw7SnlfEVKsfSRcGXkxglX/5jw837M2DYOcnv6jAoGKkkxi1xC2Mqymu?=
 =?us-ascii?Q?jbhePbVFXJOsC+As4TfoKl3G4UkxSEAHylTGtx0YQjmR/tT48JWUtTOTPaot?=
 =?us-ascii?Q?P7cHL8/zbt07+5EqF52c+192hp3zC1dFM9BnkSoAntD2pLf/aSVQBS06p5mb?=
 =?us-ascii?Q?qe5IF6IYdouFpOzUKoOnxelab7e03qvQYEDrisXy8qi5TpQOBjffikcJ9TRD?=
 =?us-ascii?Q?cTPt6/K1iYIkJaTnwL6HbtvtAWw8RxPbunBzrsTgey8e64nH0uuEkfqdhA3K?=
 =?us-ascii?Q?K/kCq41wgPuEcJPPWMk626Tm3C8GxBA04w/hUUpyVtx5U2+TZZ5HHpfCgozc?=
 =?us-ascii?Q?oLRb1+OwXBoVwoQTkE9zQ8L0nxEXlTbnYbdNiamlSZDQZSuCtU205Tnj9uDn?=
 =?us-ascii?Q?kLuDwH8oiUnMGmA8XsRItKsE9l2OBAEnDOd68+vp1W7XZ5SJEpQ9IFR5wGUu?=
 =?us-ascii?Q?sMzi2crC0rATSFVP3AnLU/5aPKnrTmm1A2hs+/MWXMZvFoO5SR3Dt1/c03ui?=
 =?us-ascii?Q?1AwLvmHP58HODcHssZaIQJe5RXXbG270TKjWwsfPcW54EuYZ5f+NWnHjjxZq?=
 =?us-ascii?Q?Mh3Aj3A4o43C0LJ4/wEJoTL6+3J0pUkBIOCIecZBkRM/MSnaKFnGD6GeCzqH?=
 =?us-ascii?Q?jpPW5GjpF6AxXIFKhsOYMR9qav8730Vgmk40UyY994LegACTDTer/JMnvTku?=
 =?us-ascii?Q?3o0TadIf1FAmzftRJyUjDAKgOkHjugfJSoUoLO5hoMez72W+dL4U6SAUmFEk?=
 =?us-ascii?Q?Kr8jHgghNeuBexjThMlCkj/N6gfaZa42ic2BvZRrukBOp2t+3c3AGnTTZ+F7?=
 =?us-ascii?Q?ZNzwzVSaqJBPt0/tzvoVeVAh7yoM5F1RsbVlbZeqH45Fg62bmdGmUDsNyAtX?=
 =?us-ascii?Q?D9EzFMxzmfgQYqmUHxdO/+6PwvbwFF882si2YSJXSxlWEed3Hx+m9M/B2HkN?=
 =?us-ascii?Q?SFjLBfMknPc1z242PT9+aqlc3sjOBZOIb1ynTE9hDwIeJoWFXJOQdef3IEsf?=
 =?us-ascii?Q?ResY4oarvqJrHPtXkMCq6zRuhSTNCVsoX+P/b4CcEhCS+KsCe2+wbeqwOS4e?=
 =?us-ascii?Q?ovm73E636U2Z2+bjPP7G20P5uxNk7BQbsLtAJfVRehzBSa69oZpt+ZTjzKyf?=
 =?us-ascii?Q?ZjAzR24zFhQZLSYndZwn8Y3W6tpvc39wGjWZCOUyBATxLULtXbNqb/3xJ6q6?=
 =?us-ascii?Q?uUFj14/fUMM3MSDnERDdLvoD43mr6PXRkQ5/IfgXIv5OKRHZOElyNf0uDhPV?=
 =?us-ascii?Q?DQY7hovSZw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7d2507-67c9-4d2e-56ac-08de62230565
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:26.2312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTioJ+a8d2Yd9P0B4dHucFJcff8rCpLwTfWkL4TSO2SopFJb85vF6KRzI7hJUzYL7afuwfx8CSppO6q3friFBKX0DbVlG1YZieF/Q5kKGnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
In the previous design, the I2C model updated dma_dram_offset only when=0A=
firmware programmed the RX/TX DMA buffer address registers. The firmware=0A=
used to rewrite these registers before issuing each DMA command.=0A=
=0A=
The firmware driver behavior has changed to program the DMA address=0A=
registers only once during I2C initialization. As a result, the I2C model=
=0A=
no longer refreshes dma_dram_offset, causing DMA to move data into an=0A=
incorrect DRAM address.=0A=
=0A=
Fix this by introducing helper functions to update dma_dram_offset from=0A=
the DMA address registers, and invoke them right before handling TX/RX=0A=
DMA operations. This guarantees DMA always uses the correct buffer=0A=
address even if the registers are programmed only once.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c | 87 +++++++++++++++++++++++++++++++--------------=0A=
 1 file changed, 61 insertions(+), 26 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 1ee73a8f5e..fb3d6a5600 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -116,8 +116,6 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *b=
us, hwaddr offset,=0A=
             value =3D -1;=0A=
             break;=0A=
         }=0A=
-=0A=
-        value =3D extract64(bus->dma_dram_offset, 0, 32);=0A=
         break;=0A=
     case A_I2CD_DMA_LEN:=0A=
         if (!aic->has_dma) {=0A=
@@ -221,6 +219,64 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)=
=0A=
     return SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_CMD, TX_STATE);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The AST2700 support the maximum DRAM size is 8 GB.=0A=
+ * The DRAM offset range is from 0x0_0000_0000 to=0A=
+ * 0x1_FFFF_FFFF and it is enough to use bits [33:0]=0A=
+ * saving the dram offset.=0A=
+ * Therefore, save the high part physical address bit[1:0]=0A=
+ * of Tx/Rx buffer address as dma_dram_offset bit[33:32].=0A=
+ */=0A=
+static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t value;=0A=
+=0A=
+    assert(aic->has_dma);=0A=
+=0A=
+    if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
+        value =3D bus->regs[R_I2CM_DMA_TX_ADDR];=0A=
+        bus->dma_dram_offset =3D=0A=
+            deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));=0A=
+        if (!aic->has_dma64) {=0A=
+            value =3D bus->regs[R_I2CM_DMA_TX_ADDR_HI];=0A=
+            bus->dma_dram_offset =3D=0A=
+                deposit64(bus->dma_dram_offset, 32, 32,=0A=
+                          extract32(value, 0, 2));=0A=
+        }=0A=
+    } else {=0A=
+        value =3D bus->regs[R_I2CD_DMA_ADDR];=0A=
+        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                                         value & 0x3ffffffc);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t value;=0A=
+=0A=
+    assert(aic->has_dma);=0A=
+=0A=
+    if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
+        value =3D bus->regs[R_I2CM_DMA_RX_ADDR];=0A=
+        bus->dma_dram_offset =3D=0A=
+            deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));=0A=
+        if (!aic->has_dma64) {=0A=
+            value =3D bus->regs[R_I2CM_DMA_RX_ADDR_HI];=0A=
+            bus->dma_dram_offset =3D=0A=
+                deposit64(bus->dma_dram_offset, 32, 32,=0A=
+                          extract32(value, 0, 2));=0A=
+        }=0A=
+    } else {=0A=
+        value =3D bus->regs[R_I2CD_DMA_ADDR];=0A=
+        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                                         value & 0x3ffffffc);=0A=
+    }=0A=
+}=0A=
+=0A=
 static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)=0A=
 {=0A=
     MemTxResult result;=0A=
@@ -270,6 +326,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)=0A=
         if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);=0A=
         }=0A=
+        aspeed_i2c_set_tx_dma_dram_offset(bus);=0A=
         while (bus->regs[reg_dma_len]) {=0A=
             uint8_t data;=0A=
             ret =3D aspeed_i2c_dma_read(bus, &data);=0A=
@@ -335,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);=0A=
         }=0A=
 =0A=
+        aspeed_i2c_set_rx_dma_dram_offset(bus);=0A=
         while (bus->regs[reg_dma_len]) {=0A=
             MemTxResult result;=0A=
 =0A=
@@ -401,6 +459,7 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)=
=0A=
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {=
=0A=
         uint8_t data;=0A=
 =0A=
+        aspeed_i2c_set_tx_dma_dram_offset(bus);=0A=
         aspeed_i2c_dma_read(bus, &data);=0A=
         return data;=0A=
     } else {=0A=
@@ -657,16 +716,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bu=
s, hwaddr offset,=0A=
     case A_I2CM_DMA_TX_ADDR:=0A=
         bus->regs[R_I2CM_DMA_TX_ADDR] =3D FIELD_EX32(value, I2CM_DMA_TX_AD=
DR,=0A=
                                                    ADDR);=0A=
-        bus->dma_dram_offset =3D=0A=
-            deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));=0A=
         break;=0A=
     case A_I2CM_DMA_RX_ADDR:=0A=
         bus->regs[R_I2CM_DMA_RX_ADDR] =3D FIELD_EX32(value, I2CM_DMA_RX_AD=
DR,=0A=
                                                    ADDR);=0A=
-        bus->dma_dram_offset =3D=0A=
-            deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));=0A=
         break;=0A=
     case A_I2CM_DMA_LEN:=0A=
         w1t =3D FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||=0A=
@@ -748,15 +801,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus=
, hwaddr offset,=0A=
         qemu_log_mask(LOG_UNIMP, "%s: Slave mode DMA TX is not implemented=
\n",=0A=
                       __func__);=0A=
         break;=0A=
-=0A=
-    /*=0A=
-     * The AST2700 support the maximum DRAM size is 8 GB.=0A=
-     * The DRAM offset range is from 0x0_0000_0000 to=0A=
-     * 0x1_FFFF_FFFF and it is enough to use bits [33:0]=0A=
-     * saving the dram offset.=0A=
-     * Therefore, save the high part physical address bit[1:0]=0A=
-     * of Tx/Rx buffer address as dma_dram_offset bit[33:32].=0A=
-     */=0A=
     case A_I2CM_DMA_TX_ADDR_HI:=0A=
         if (!aic->has_dma64) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",=
=0A=
@@ -766,8 +810,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CM_DMA_TX_ADDR_HI] =3D FIELD_EX32(value,=0A=
                                                       I2CM_DMA_TX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 32, 32,=
=0A=
-                                         extract32(value, 0, 2));=0A=
         break;=0A=
     case A_I2CM_DMA_RX_ADDR_HI:=0A=
         if (!aic->has_dma64) {=0A=
@@ -778,8 +820,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CM_DMA_RX_ADDR_HI] =3D FIELD_EX32(value,=0A=
                                                       I2CM_DMA_RX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 32, 32,=
=0A=
-                                         extract32(value, 0, 2));=0A=
         break;=0A=
     case A_I2CS_DMA_TX_ADDR_HI:=0A=
         qemu_log_mask(LOG_UNIMP,=0A=
@@ -795,8 +835,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CS_DMA_RX_ADDR_HI] =3D FIELD_EX32(value,=0A=
                                                       I2CS_DMA_RX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 32, 32,=
=0A=
-                                         extract32(value, 0, 2));=0A=
         break;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\=
n",=0A=
@@ -887,9 +925,6 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func=
__);=0A=
             break;=0A=
         }=0A=
-=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                                         value & 0x3ffffffc);=0A=
         break;=0A=
 =0A=
     case A_I2CD_DMA_LEN:=0A=
-- =0A=
2.43.0=0A=
=0A=

