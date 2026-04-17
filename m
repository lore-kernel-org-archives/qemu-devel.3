Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057F5F8E4A6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZsz-0002Aa-B5; Thu, 16 Apr 2026 23:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZsw-00029o-00; Thu, 16 Apr 2026 23:28:50 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZst-0005ns-O2; Thu, 16 Apr 2026 23:28:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbhUdSfOOn1VKPYFqPZIY84jxMwmeXBIX+eQdeiL/Jdm3UcBKim79MbMP1FIQTFlm6MPqCyKPThkFi18hW5+pa5332I1Xls34TMhXnYINtjqQJCp54FMXMScepNgB6cvlXvPS3sxWC9ukX9+4RIvVQukaqGMW765OHGX56fBQiievTfMImJwJecfg1bAc96M14B04fpMUAYJCX58SkRYyXEzypWx6NOYC4o5gCzamqliQQdRKFLOVGwAEv6Wbik44NTZkUO2V/YPZQkLywFaFGXd8w86ARZkfYC7dmCx3Z/5E7qeWbWC8x/evNMoarA8Ijs7HxfUKDFW3bOg7x8mzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEUjXRk4iE9d8ctmz2tCFC3e07+/K/C+t92jIjXHoRU=;
 b=ZZrKNGib0NjgrkcQOIojLYD7Wdsu52Ww9Kv0HhW0kWme8ixCdA02zhcgciuzkeQACBR53KOKq3zms0/1eBxjsERcX6dK+NXSQ3AXXCiq97L1zaXvDXgYxnqOxa2eEfKo5hXJG58lcU2JSwoF3K1y6TWDXymmYJnhWfRn9gk6UWF6lfI8JPxS9seE4ep4xdw0+0xqATl+VJcOSoXwtpzRb//pXHAVK/4YpRdXSsexdTw/KRwyXTUZZnZWJTmMBrs+mP/pbqnFpk+cZS3NTZcwYzhQ7HdWM/2uzNYgAu7gj0ev9/qIdvGSLxMd4JFc7pdPPSiXrVwv8iUXl7dCMKejVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEUjXRk4iE9d8ctmz2tCFC3e07+/K/C+t92jIjXHoRU=;
 b=SLkG15UQ2HmJIwaP6zRHY1modBJdS4y+83KmLsFZdBTA3yt0netsH/IjAtJA+dIPUatcM3H9oK7ZtXiYt1/G9XayIZAbP5VK8GdOT7q/2Rv3MjfnqyFKb5C3kSFSu5aIYJ8JoorD4woiNmlaYGjwHJeep54Fv/xbsXoYL+ynq4k3QM2P6JNHHNLt4WTy1W3BZ53urOzwowaInDpj5KhujALMo9kKUbMLXsxNG8qNJPE8QiqaoGzPEWFl6HX1CQ+m/RySUqD86DGH0aBCCLH0Ad+e4z5WxVyN3uwM1D8iNGSVyN2zhLtSCyuNXEpWYoGxJy7936o69fe02YFpAFLelw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUYPR06MB8675.apcprd06.prod.outlook.com (2603:1096:d10:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:38 +0000
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
Subject: [PATCH v4 00/21] Add SSP/TSP power control and DRAM remap support for
 AST2700
Thread-Topic: [PATCH v4 00/21] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHczhpHdueeYCsr+0KxqBKmTjL7fA==
Date: Fri, 17 Apr 2026 03:28:38 +0000
Message-ID: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUYPR06MB8675:EE_
x-ms-office365-filtering-correlation-id: 7ab94bce-6db9-47b9-4380-08de9c316a78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: hZUtwKFEfnw2WEYuLp+w/IAK3iqcCR2TcuDr2EmU7bCK/XLS+LhHGYEVzxiLRgwq68slEPcaQKoO0XEsabslqjW5bCKTSd2sXMQl3DNeWEWdMSIMduFcQaJtGomDnMbQMlIEtrAdt3aa2BI1xVo6TiUoqVIQfU0zi/lvMBwIVMOmYnSJ2sNwuLEXs3iFvNqWbbyEEZuepUS6zalmWLkeorzO0klpTkiD6EIg8nOAIvrt7D/zlw0vZ87xjUrQ+g/hZ/g3uTMRegs6InJDRl8rfThvaszP29OOSLpBahMC/JA1zIO26c4qflGKa1bspIVUN6dBAvLc2H2PJ5e2om1Cxk6iUZjkbm05o1Y2Wm3jn85KQm9DjCRwsYA857STjR8gfw0XngC/7b1op9hXPqU/jYPBik5Q9A6m5hysWoT6aKK4aSpcQedpqLa5kf+NLvBkpbqszyDB1L2tARBr7BpjhHeQ6amzHWgbM/HZvxXef/dNz8j84xw84rjIwCcK709TnHu+o4YjVzTcopLNBfvrPKCnH9KrTllp1ooXE2uCLX9JC9u4mUJ1rrc8/FcTICP8z98HYRU9kYwP7h+kAZxYERvGaNnkpEoLARfpGHuXDNb6R+VD5jel+Vj0wwjtk1ZcWGeTX2Ysz0PZtmZdQRFVEOjOkhnRRyX4XYW8Rn0edcDknV7qoGnYVgG870nmJkRAg8SZq7Rj6DJr1EUKnrwn3BSMcZ3SDRGuOGxcyEZJZVYmSZoQdfkcf54uaM2eB4UrIwLK0qLI+NmTF56K4UEN13gkdToUh++bNStulZaT1KQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l/dJLl4C6kBfGy0rT0kT303vcDnxfKtt+I34bzdLqwbmIwgWr0ny1MwW5o?=
 =?iso-8859-1?Q?+7R9epUF+l77EiKqPZ0ybhdcK3mib9llU2K8m2OkH/bal0PuIyBU5W0NnK?=
 =?iso-8859-1?Q?UPotVPjUmNige8cNP1oQ/KAJDR3P5ypgpQiv/e+IhUkUMH+m3T19SmX7Vz?=
 =?iso-8859-1?Q?Ee7nsgrWCfHiJQUhJM5+BdvlaHfLD6LZRC4r0W4B9IM5dPq4iMwMOPqejd?=
 =?iso-8859-1?Q?vnWi9YDe8wJViN+H2NvZA6kj6htYq5o+r2Tv7ZJtV6sdodnsd0MYWoAxOV?=
 =?iso-8859-1?Q?p0jmolqM95AXBX2wn/ly56tdSEbVX0HWOzFJU0TfjZP1hzFoz8K4hH/M0E?=
 =?iso-8859-1?Q?y/FuxXAxeVk/jv6UIzWktZgwTcF1aTNWobeA4cDkxd4Gr/bkNmeNuGG+f8?=
 =?iso-8859-1?Q?yWVU9Xnk7zCEdlOOf5oM7XUt9cn7N9Bf7aIWtNXmllVipE+Q5sXKiOE8pt?=
 =?iso-8859-1?Q?1xJ4g69+vaVsIVWV2rJjLZxwcAT57AFBx1Y6dxZrw6IY7MSq8g0++2sb/+?=
 =?iso-8859-1?Q?TBP5yb/0fWglms97oIb23il+iim4vM9FLPg6vHNx4U1sCdyka5RIuFZPev?=
 =?iso-8859-1?Q?u09zp4MFo44z7cOfcCZno+KW1hXHcme2/A9ecU51jp75lMb3WN+D9S78PB?=
 =?iso-8859-1?Q?lXN8fgeBOW+EFMg8YV7WPdAjyvKfekrgJdxAop9YHFliNPl+fzgv8kjV4i?=
 =?iso-8859-1?Q?Iqv+TrasFHglNoCwFB+yy+7e1CC2l8+BSwlXydpnPjKJKK82sLzAxWRmfw?=
 =?iso-8859-1?Q?g9S4WetW9YMtksHhkJBNElE8OBqPaLo3Naeo/zta/tIObSjV78ZsaYH61O?=
 =?iso-8859-1?Q?6gi5+of84Q3QLEG0Bp0p3Z6DSKB7JfZe7QmLTjwzWdZYBdyNKMAJVbrix7?=
 =?iso-8859-1?Q?eZsHcizannj7aOImFpxIzSuDmTlHmLgPT53sFGta5gEK1H6SwUfuj9raMa?=
 =?iso-8859-1?Q?2ClP/DWU7mqJlZE9bxoaCaOe34GAvzr/Q5+hWK/4QYE9GRhsZ/aNRu5RD4?=
 =?iso-8859-1?Q?JRlGnXfUtHOb/2JlPoc5TDJP58cCVayETaHhCvr87gLFFlnxT/EbcTTZvX?=
 =?iso-8859-1?Q?Ii7nxgZRZ35uOCCIGe2UwMHiD6kcHyt0Ka6nUOazsa6GNlP11iUFZ2nbkq?=
 =?iso-8859-1?Q?t9meWH9jjxR0+ckGCIesgE+dZmhgyDHvR2u3nzKhe0lg29125BGOeKFoF2?=
 =?iso-8859-1?Q?Ow7bpiHek48FIlSknNvXDgKc6A+ByEDxg4yvw4ASj4xU6lkHdlJaK/F8cB?=
 =?iso-8859-1?Q?dY/MpUtDGud1DcaTn63Ry7F3V8ddJOzvc2L9c+tQVtv9cz5WBPuoxiU+Rr?=
 =?iso-8859-1?Q?wPZQ8gkI1dOwAlC8e+M3mFvooo8jjAkKB3lo1lZS0fFNXWn4PjOCXUOQbB?=
 =?iso-8859-1?Q?fpp8qRaRmpOChDL4MhcnYyqpRWjyb8w8taX5tsQTvqdWP31EQo60v7lbDu?=
 =?iso-8859-1?Q?mRNXxu/4ec9CL7XVPdI9Ib+5Ed+nAONtKqcALBY9NJjLr/1L541207vffD?=
 =?iso-8859-1?Q?lSVG5NO+yPlnBqb6qyrRZw5YZXvDc3Gq0xooa4DOo9PEIZgBT2Yln8CjQg?=
 =?iso-8859-1?Q?47f8F/067bxTukxoAck2+RTnJDbFXb4FMBwWLC8A7BwmYz6sgHMEUc85O0?=
 =?iso-8859-1?Q?OpV/s05ewg96/01UrNsIuMNuKsi8sOYhz1YbIkegt2jI/UVh2O7zfAc42r?=
 =?iso-8859-1?Q?MXpf5dr9E9ckux8Yd5mZ1NflE0r2HcaBklnxwap100+JHhG7zKPiYhNE9o?=
 =?iso-8859-1?Q?5TEiMgXp+cyleHqaDy17hGUDdJUprAk27119ZSUsy5kUZdugrMwjGxZmEz?=
 =?iso-8859-1?Q?wUjZkKhRNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mj+77wiwZ7Q4fwzrFZ8OBAsajltM1V5nAKSFAY+NmULrhaWEjzRe9hm5XFVlO8FVYVU9LnKpPQ5jxlHCUpWA5Lvf6jQZ9e2Cq1i43ryUyD4ErWNBjpINGJM348UZoZ0D8ZWpJAfiXSiBNrKIIKu9Y0H7KpegqOcxJEc/EKv6GfqcJNfnAFlxbfi9XGj91pOSiIA9d788x+Z2Em9pWGWYTc7I5pvJsnUFYXeOenmEPo1bWCrVTZeHEBEY3cwOIa6LGOm2NgmYZIwS7xeO01AUDRk+vBv+PFGsvSwxfZiAK7mofcmqdXE0VzRQ6T3Hyo5mAnJXwul38E3pvgtJbAVkVg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab94bce-6db9-47b9-4380-08de9c316a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:38.6276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZ9KRyzR+g6a/GsbyGy0sb33kO8ojPTNFWwleQFWBcfHibgVzJL1Gzj114VcmE1jehJjJJwnmiXdCylfPGS38H5RWVTug1S67NDZFud575w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8675
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

This series improves AST2700 platform support by aligning SSP/TSP=0A=
power and reset behavior with hardware, and enabling DRAM remapping=0A=
required for proper firmware boot flow.=0A=
=0A=
v1:=0A=
  1. The changes move DRAM/SDMC initialization earlier to support memory=0A=
aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement=0A=
SSP/TSP reset, power-on, and remap controls via SCU registers.=0A=
  2. With these updates, SSP and TSP can be booted via PSP and load their=
=0A=
binaries from DRAM. Functional tests and documentation are updated=0A=
accordingly.=0A=
=0A=
v2:=0A=
  Fix "make check" failure caused by both AST2700 and AST1700 realizing the=
 same=0A=
  TYPE_AST2700_SCU model.=0A=
  =0A=
v3:=0A=
 1. Drop "Move DRAM and SDMC initialization earlier to support memory alias=
ing"=0A=
 2. Support SPI/FMC FIFO Mode=0A=
 3. Add unimplemented devices=0A=
=0A=
v4:=0A=
 1. Introduce Aspeed2700SCU subclass and separate from generic SCU.=0A=
 2. Add separate reset handler for AST2700 SCUIO=0A=
 3. Add AST2700 SCUIO RNG control and data registers=0A=
 4. Share single SCUIO instance across PSP, SSP, and TSP=0A=
 5. Fix AST2700 FC hardware strap settings=0A=
 =0A=
Jamin Lin (21):=0A=
  hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass and separate from=0A=
    generic SCU=0A=
  hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO=0A=
  hw/arm/ast27x0: Start SSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Start TSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap=0A=
  hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap=0A=
  hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO=0A=
    regions for SSP/TSP=0A=
  hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions=0A=
    for SSP/TSP=0A=
  hw/block/m25p80: Implement volatile status register write enable for=0A=
    Winbond=0A=
  hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for=0A=
    AST2700=0A=
  hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700=0A=
    SCU/SCUIO=0A=
  hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers=0A=
  hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP=0A=
  hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP=0A=
    and load binaries from DRAM=0A=
  docs: Add support vbootrom and update Manual boot for ast2700fc=0A=
=0A=
 docs/system/arm/aspeed.rst                    |  42 ++-=0A=
 include/hw/arm/aspeed_ast1700.h               |   2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h           |  13 +-=0A=
 include/hw/arm/aspeed_soc.h                   |   4 +=0A=
 include/hw/misc/aspeed_scu.h                  |  10 +=0A=
 include/hw/ssi/aspeed_smc.h                   |   3 +-=0A=
 hw/arm/aspeed_ast27x0-fc.c                    |  22 +-=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   |  67 +++-=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   |  64 +++-=0A=
 hw/arm/aspeed_ast27x0.c                       |  22 +-=0A=
 hw/arm/aspeed_coprocessor_common.c            |   2 -=0A=
 hw/block/m25p80.c                             |  36 +-=0A=
 hw/misc/aspeed_scu.c                          | 324 +++++++++++++++++-=0A=
 hw/ssi/aspeed_smc.c                           | 113 +++++-=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  29 +-=0A=
 15 files changed, 672 insertions(+), 81 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

