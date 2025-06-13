Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F5C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 03:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPugX-0006aH-Uc; Thu, 12 Jun 2025 23:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uPugT-0006Z8-GP; Thu, 12 Jun 2025 23:02:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uPugO-00009U-Ki; Thu, 12 Jun 2025 23:02:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQiplD+MlOIvphYSjUjdBgk5cBhIJmfcJP1jyR7fEYnVHPBt8+UDRrVJbhqN3dyBk4oQNT4mTbtiqySJtHeYfe5sYTqfSIHRFw9o0OCGKtQeftLeOlNxAP9407BpKsTGD7RH927wu5ZdMoC8VDEvb6/EuqRSrfGwBHwXgoiFW6E1KDI0nnq0XzZJrwnCIHnzxaixl3SKIEZMjIOvIGDBQfnBwtu8sYlh6IMgpPiTH28WJwnyPPnLB3woBLpGQ/HduwgIl/SMkdtq9zXRAMfUo1dzbQPXrXWsPUlGVD4OwFqHZrssS3eYBPtsS33P4NvXsWUjXWg6v0QADoZdsmPfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua+aA1Ow2fv+UnAgy3C8BlaGBY+PU3l5CdTrG0ThPCo=;
 b=c10ruKU9MbU44vmnSXJCs4AeAezcgDWUKYzfVA5Zx0IacASPk+StNAeDAf9nqiIjv30PIfOKxFYHGuOm7U+HrDY4X0rhNBI78MugsBwEAcKXFaF9LwqTkSn4p+gl41pOO3qMl9xM1KpMhez/t9FcMQxH3lCmicaztvnA7dbPxyH4oVDaJlxM6j+ZGtlxHFVYcnLvlrF7+CVXaOgEOAWfRce4C1rGktMq4U4U+eeJrkzAavFfDUytrzeW+5ZCqTOVxxN6rcqwN3LGPGXXqRjpELQnXv3CxhnXdw8JvuFXl66WWfnr/H+jnEyEGU4YS+wKJKYIdWjYT5X+E4TtpMliVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua+aA1Ow2fv+UnAgy3C8BlaGBY+PU3l5CdTrG0ThPCo=;
 b=FMBSooM5+joa8RCpfIz/4SkhhGCoCydCQ9A9LSIy66hd14rHB5W280SxcLlj+jG8FEkisQhmQVRBLdhLuY15V2H6zm0BMlcSBWjrscg70f0VD7gH3B48iffCMs2W4beuKTgzzZZC4FExGHxXasmvWqqMD3R0P1hQmbXjSj0iNNShZT03ywh7yYa0u1b9wceR5F9BElNxfen25c7p2ykfoueIOVEPuMDM35yFQ8GJ6KuuNBsSBgUFXS33sRccNZC5gonG1/vSqJ5xSOb/XnOBFKEeqTH5kluu8OwNs3XxUhiXjLt7qdAUe5bGD7hdx4xafmGYhyDZhbqRmqsLixzdRw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5199.apcprd06.prod.outlook.com (2603:1096:101:73::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Fri, 13 Jun 2025 03:01:58 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 03:01:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, Tan Siewert <tan@siewert.io>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Topic: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Index: AQHb26gO6SN3HcnSYUqhj+VKKkWvBrQAZASggAADQaA=
Date: Fri, 13 Jun 2025 03:01:58 +0000
Message-ID: <SI2PR06MB504192DDAD5ED2325B9AC0EFFC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250612144052.22478-1-tan@siewert.io>
 <SI2PR06MB5041DE20EB548C3137045975FC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041DE20EB548C3137045975FC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5199:EE_
x-ms-office365-filtering-correlation-id: b12ed9bd-4ded-42b5-c7d7-08ddaa26a93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jNh9Y1ye38nxeT/w/aa3BehhNWruwX/E3d33jblmjilk4Z3ffxySsxFitC?=
 =?iso-8859-1?Q?fsrq7+Aj4pzMj01hk/sfIWH7Gc5pe/KZtJVRzGi9iLZZM3mHcobDdB8Y+E?=
 =?iso-8859-1?Q?Ko3rfgALf7oaw0TJaE2bCrXLDUv8CC/5GKEuCOcDXvvNkOiBBUZPcvtsy2?=
 =?iso-8859-1?Q?brJ22QXnl3FOtEVyF+BLh6BOVipPiQvyhSyi9FeLAiN+9es9JEcEriU62/?=
 =?iso-8859-1?Q?RNEwkFihrty2DqTQIV/S69AGqCx20Te/Qi2jrW5wcREIloKOQt+R230WJ6?=
 =?iso-8859-1?Q?aUB7ES1v2/Kg8Q0Wyc7qC7chiBX7MDzYJo+rUOGuXLlxkmJl9xdwpB1He5?=
 =?iso-8859-1?Q?QigxZGiizFNdBjFB1B9sidJOfSBaLVoFw0Dn/LHbGlCs8f38Sagibl3TDa?=
 =?iso-8859-1?Q?t1FsX2scqiay1GdNHYfnyOANUzZFBVxDJ91T8Dd0YtoEZnqCcVuWx5Ewyp?=
 =?iso-8859-1?Q?m7A58vzUcTGNsfsL6XBlnzR0FHZj6alzzHGlCK/T5YVOXAOAtKx64ujBfT?=
 =?iso-8859-1?Q?LSLCF9DyYWr3kzdNTnuyXvQ5ALdtvuRIKxbHrFfF6/o/FnSU0Vax5STpje?=
 =?iso-8859-1?Q?g4YhvRaEglsXkm6Ta1bJpv4Yg0qLNnAyeeVLQq7uU/JEmPDHIl3FJzoul2?=
 =?iso-8859-1?Q?Otv8JTXsr005i4Mo8iFUPIb1aTzOimjcWXoPnkCn+65fo34Lcov6Us0+L2?=
 =?iso-8859-1?Q?3G5ysydYdeC8CBkbJqcdR1fYuKwv0lXYjkJkFOBxfSHysz613gjjR/P3Yw?=
 =?iso-8859-1?Q?cYXa/IlohX12DqrJgF/JSphApDe6Cf1KUzYsaSxdkL3cACvL6oKF2qaae2?=
 =?iso-8859-1?Q?QSZU6nPEKIR57bQx7BfuSnwMlr+TyPXsoq9VNfEuBi092CAttdVOENaW8c?=
 =?iso-8859-1?Q?PPM9ThsUlBOFf3GLcv/HcqNILLK+HKXsjLLsdaMrjnfjcIwyKgZsg55SgY?=
 =?iso-8859-1?Q?SdoNkDZqhrcxx3gqKUUspBieD/R1POnWfuvWnsS/atBhXHhfLUvNDX71Rv?=
 =?iso-8859-1?Q?a6GEF/lrHDOYzPhfDemdUsjvKjnrmD18tzxoBvQPNnZ2btcZBHo+2dTjOB?=
 =?iso-8859-1?Q?/vbtOQdiCJfuJeSnXy+aOoPaRBoL8mnP1Rf48Nd1YLjmystU2O7GplsHHJ?=
 =?iso-8859-1?Q?xtp865+11sgK966UKtaZD0sYJGXeGuy1PBDQ6Aav20+ACStiUlFXe1PEOF?=
 =?iso-8859-1?Q?DfKEMUko1Mj53FVWCWd04RCD6BueYsBse1btDDO839X/7X2ZY5SQOva7Id?=
 =?iso-8859-1?Q?qLsxkEU5+Bb1Pb4isnWzrBpHeLI1poFW01futuFtufC8drfEnCwbrz1Bq5?=
 =?iso-8859-1?Q?xyDnp1bX7SN14T0T0oeIBqprycR2zcL4qT0T9O26Qks10HiASs5M/F/55u?=
 =?iso-8859-1?Q?MK4NZZ/A9bqrdlChV0T/WqBmepXiNsZ1f0VuKLZZfkZtp00sLtYLGCTMdB?=
 =?iso-8859-1?Q?tYEl2A6i8wWA/OU3rIGeWFTAabUkNC12g7P4hNt+vStecSMDrhlCwe/tOv?=
 =?iso-8859-1?Q?ub3S08s+7WpYF+5ykRW62Nc9zoB5A9V6Uzeq5Q8Cstp9Ajh8NDMov4ra5l?=
 =?iso-8859-1?Q?lHwSlTM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eWFHz49P8tROyR7SFL4cn6PofqmmtuCZnx9pmSgunjSvXTVCyX+yqAM4XU?=
 =?iso-8859-1?Q?4vUVjMfWkSU0zM+erexGw4LIcLM/TqTYrMWdTLNeIopydOHpBhBKIXSrh5?=
 =?iso-8859-1?Q?Efocbc6cJ1VBFrrq88evAh+O8XeQdJ0jXBeLo8lS5kBTvcBEMNfAisOIM0?=
 =?iso-8859-1?Q?poItOFtJQfpQg045jCNQq50++/G3iEvj2Ti1KOhF6Z8RBi6f6gl499QOjT?=
 =?iso-8859-1?Q?QztOdy8qhJxpWQvAMQYvvOLg1O4gzmcxL6qRutk7vzK18lGoceOttEW0Fo?=
 =?iso-8859-1?Q?tFrsKqInGFdF/iB1dwZn7xPsf7tmcfUCFNsgIm1YGOt+4vHt5G49lzZqYJ?=
 =?iso-8859-1?Q?zLwScKIX4pwtfHP9pWjI6s3AwyDB0oV3oXzl1ybv6A5Pbxa1q35Ze4FUd9?=
 =?iso-8859-1?Q?Zeuj2Fq+udl19X4TtiG3J95XMTmDaoRoJ6yxmnt8B6JtrMvRGEnZ4JpHfs?=
 =?iso-8859-1?Q?2zdl8guBhFglCkCbkqhHaIkQspiIK/KDJwQPVceAgt018m691cqQp/rPA5?=
 =?iso-8859-1?Q?LAPw/gqOVr4IaPKYhlDneJ0Cx8f/e042x2N17MOC/SeMcK1oDzBnn+ZttN?=
 =?iso-8859-1?Q?h+xbhoPoD768H47Wn2T1+Lu91xQIso6TkdqN+pyzMueUVTdH02ceWQw+a6?=
 =?iso-8859-1?Q?yOcJP970dYtZ0I6BgLi5WGgDTWge76Vr94jZWjhm0jCjzJAsmrfMRpfVm5?=
 =?iso-8859-1?Q?B60b3Fk+sxCzvZzGh+VnJfhTKf/mUD2T6HhH5SmI6dxfJd3djyJRWgK2Qr?=
 =?iso-8859-1?Q?EMLtjBQaniND6v3nOCd3MdwtQla2WJ1XEzo81WySTj0Wulc2w5uJMNnzvm?=
 =?iso-8859-1?Q?vAtUGC0fhfogP6OOSffvxloPNNj/oxyLcPAR1YI6mhM09oF9Tc02mTWmf0?=
 =?iso-8859-1?Q?J/BoRz7XGpjc65mkIwxktVsBixqosVTRFXv0H+oF3wGY3ekjVV5jxpJ3BG?=
 =?iso-8859-1?Q?ToCnS/QKG4XRe3r2+QF515Zkh574eZmB9QsCiDqD1xX5/XZE2WPu9RYecR?=
 =?iso-8859-1?Q?R4legjHXkkkzYi/JXj5damxWRyB5c5lWO1wJvVh529zihztuDnc8Tfxs2p?=
 =?iso-8859-1?Q?31yFkzVbCqx53reCKnYLx90UIpAfyGIjpNXHi1UCRi5+GOShWKHsJRmwaC?=
 =?iso-8859-1?Q?n2JyxBaoJucCca2hcR4X8hq1n+NSTdeSM4t+fwyjZmO03/fsLuySFaNyMH?=
 =?iso-8859-1?Q?jPTDitqtEU+mjzxCFNQUGa8fgal7c+awpNRJYF1DQyuxgFivBK+rAuo2W5?=
 =?iso-8859-1?Q?f4X0JDUji1173G8Hn/cVGtVfbtRGeBmRxRFFH1EmtF3nJkv4t68PpO2a3n?=
 =?iso-8859-1?Q?KoGKJLGGMoi21L1EakA14fl9qvt9s1/cfyfdiMfFquxVHRbUR5iGx7vYH5?=
 =?iso-8859-1?Q?0WGptSb9/yYesJoSzphsIC4TFErRmEn0YhuFQry/lLwRXDj2HSlIGmQQLi?=
 =?iso-8859-1?Q?ZmdtvqeQ7JSWY9H5ggsquhGu2fJ9Vz5HmDfzADMsgBaMadTdXYjsa9ug5d?=
 =?iso-8859-1?Q?bqFQtEqd7g5E+LdIEx8MD1XROvyIiYTGdOkNXP9gHduyocE5+pCqA6bxgY?=
 =?iso-8859-1?Q?T7pWOm1/K7MXOmG+McSjTyw64966q82+Hg/PuZ5TZLhzvLC8encGEqkpUW?=
 =?iso-8859-1?Q?d8QG2PmoXGip1GnZgXHMNigT/TJdnA0R/H?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12ed9bd-4ded-42b5-c7d7-08ddaa26a93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 03:01:58.1108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DV+/3cBzrD0q7gETsULBu0LyRgSrP5Jgw+mni1cLFnngqLhWgV+FLQ/KNQUFCOnTSiuRXcvQF19aIdQrr1mrhSBSjyt2eN0qdFkAaqyFJGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5199
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> registers correctly
>=20
> Hi Tan,
>=20
> > Subject: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
> > registers correctly
> >
> > The AST2600 SCU has two protection key registers (0x00 and 0x10) that
> > both need to be unlocked. Each must be unlocked individually, but
> > locking one will lock both.
> >
> > This commit updates the SCU write logic to reject writes unless both
> > protection key registers are unlocked, matching the behaviour of real
> hardware.
> >
> > Signed-off-by: Tan Siewert <tan@siewert.io>
> > ---
> > V2:
> >   - Fix protection key register check to be an OR instead of AND
> >   - Add missing return if SCU is locked (like for AST2500)
> >
> >  hw/misc/aspeed_scu.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c index
> > 4930e00fed..4dcfe8f7b4 100644
> > --- a/hw/misc/aspeed_scu.c
> > +++ b/hw/misc/aspeed_scu.c
> > @@ -91,6 +91,7 @@
> >  #define BMC_DEV_ID           TO_REG(0x1A4)
> >
> >  #define AST2600_PROT_KEY          TO_REG(0x00)
> > +#define AST2600_PROT_KEY2         TO_REG(0x10)
> >  #define AST2600_SILICON_REV       TO_REG(0x04)
> >  #define AST2600_SILICON_REV2      TO_REG(0x14)
> >  #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
> > @@ -722,6 +723,7 @@ static void aspeed_ast2600_scu_write(void *opaque,
> > hwaddr offset,
> >      int reg =3D TO_REG(offset);
> >      /* Truncate here so bitwise operations below behave as expected */
> >      uint32_t data =3D data64;
> > +    bool unlocked =3D s->regs[AST2600_PROT_KEY] &&
> > + s->regs[AST2600_PROT_KEY2];
> >
> >      if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
> >          qemu_log_mask(LOG_GUEST_ERROR, @@ -730,15 +732,27 @@
> static
> > void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
> >          return;
> >      }
> >
> > -    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
> > +    if ((reg !=3D AST2600_PROT_KEY || reg !=3D AST2600_PROT_KEY2) &&
> > + !unlocked) {
> >          qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n",
> > __func__);
> > +        return;
> >      }
> >
> >      trace_aspeed_scu_write(offset, size, data);
> >
> >      switch (reg) {
> >      case AST2600_PROT_KEY:
> > -        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> > +    case AST2600_PROT_KEY2:
> > +        /*
> > +         * Writing a value other than the protection key will lock
> > +         * both protection registers, but unlocking must be done
> > +         * to each protection register individually.
> > +         */
> > +        if (data !=3D ASPEED_SCU_PROT_KEY) {
> > +            s->regs[AST2600_PROT_KEY] =3D 0;
> > +            s->regs[AST2600_PROT_KEY2] =3D 0;
> > +        } else {
> > +            s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0=
;
>                It can set 1 directly.
>                s->regs[reg] =3D 1;
> > +        }
> >          return;
> According to the datasheet description: it seems your changes do not matc=
h
> the actual hardware behavior.
> Protection Key
> This register is designed to protect SCU registers from unpredictable upd=
ates,
> especially when ARM CPU is out of control.
> The password of the protection key is 0x1688A8A8.
> Unlock SCU registers: Write 0x1688A8A8 to this register Lock SCU register=
s:
> Write others value to this register Only firmware can lock the SCU regist=
ers,
> other softwares (ex. system
> BIOS/driver) can not do this to prevent disturbing the operation of firmw=
are.
> When this register is unlocked, the read back value of this register is
> 0x00000001.
> When this register is locked, the read back value of this register is 0x0=
0000000.
> Writing to SCU000 can be seen on both SCU000 and SCU010.
> Writing to SCU010 is only on SCU010 itself. SCU000 does not change.
>=20
> I The following results were tested on the AST2600 EVB.
The following results were tested on the AST2600 EVB.
Sorry for typo

> Could you please verify the QEMU behavior?
>=20
> Writing to SCU000 can be seen on both SCU000 and SCU010.
> Writing to SCU010 is only on SCU010 itself. SCU000 does not change.
>=20
> 1. locked status
> ast# md 1e6e2000
> 1e6e2000: 00000000                               ....
> ast# md 1e6e2010
> 1e6e2010: 00000000
>=20
> unlocked protection key
> mw 1e6e2000 1688A8A8
>=20
> both key and key1 unlock
> ast# md 1e6e2000
> 1e6e2000: 00000001                               ....
> ast# md 1e6e2010
> 1e6e2010: 0000000
>=20
Sorry for typo
1e6e2010: 00000001

> lock protection key
> ast# mw 1e6e2000 abcd
>=20
> both key and key1 unlock
> ast# md 1e6e2000
> 1e6e2000: 00000000                               ....
> ast# md 1e6e2010
> 1e6e2010: 00000000
>=20
> unlocked protection key1
> ast# mw 1e6e2010 1688A8A8
> ast# md 1e6e2000
>=20
> Only protection key 1 unlock
> 1e6e2000: 00000000                               ....
> ast# md 1e6e2010
> 1e6e2010: 00000001
>=20
> Thanks-Jamin
>=20
> >      case AST2600_HW_STRAP1:
> >      case AST2600_HW_STRAP2:
> > --
> > 2.49.0
>=20


