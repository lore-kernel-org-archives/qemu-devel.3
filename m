Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28BDED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhT-0003Wr-NF; Tue, 14 Apr 2026 04:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhK-0003UR-Fq; Tue, 14 Apr 2026 04:00:38 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhG-0005mG-4f; Tue, 14 Apr 2026 04:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHeOdww6H6l/174PWeuVngkzoJKmIFEIt3yy6TraYEb91tu4qynRNL/heibc3q18+X18BQOJzdCG9od21VGjDZhJqmCZEg0bUiLQ7jyS7vunXbcuF4zzMZHrOkTWBezV671U2Q0aYiRpnIksBrrR5zEzmAyhZKT/WWOs5a8uX4RFSIcqG2Ncvo0mXMCzC4vz6Mzll5OcCaxiYGGul4vwB7T9i+JJB9VXGOeFQzAMGD/JVHWIRJPRo6yfeKUspyzTgpB7aQRsicd5+W8Osa8es1rcG1zADS6bek1Jdu1HcG39JfClYkeDBi/LvzY8X5MRmNnvV9yNbXAFQAha06Ydog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7JA2U2/glhOK4hBbFeYTfo5ffV5Mx9hVAVFVYf1LRk=;
 b=WIuVXn9Vpn0wMsKcvywySiVa7E32m0yWvem2SRAnCGEbDi2vrbf364S0h3Idpo2xjWNCtyCYVS/jtp01wdlLe6Cyc2sBAYc68RYxSqGGVr1V4TzkYzOlgMM755hrpmC3cjlu+UcKEs1iOXiXXDMK4rjvvpy0ZP7EAP4mmW63usL+ETNQnK5T8F/EDGRJIe7wOM8oSUL8RXXBsIKjb6k/uXJ6stXKKWvZKp7QyLI0vWpkUVBsTrU/RgnVz+deRIQp99PkjmrXMsk/Pa1hjlQ9FbRE2bH453Jdq8airoeTbH+iMA1+VZFY7IUhe5rUkfNydsQ78tJP30f5tFBRGsCfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7JA2U2/glhOK4hBbFeYTfo5ffV5Mx9hVAVFVYf1LRk=;
 b=IJXUd1376Iw2nBsBpt+U8fD3ZY2tEDI2wpbZ9rrTBNul/eJ+8HlWqQHOH6tA/BtEOPtVIxKXxWdLBFCDEcN96H9qjsiqGrkBPuxQCvSGHe8kEnXu9L1K6uk543RDHfCkt5wDdMv3TuOeWsJcw+DuK2nvtKpQVJpzVm3WRDs2uRFOYedYc4wsjBkAE49dBiKOYgc4o8qtr/r7yjbPebBjptVR5T31xk+2ylAOW+QGveCUbHFUaeyLW6Gu+SMnhUVjxo1eycxUfy9pf6CUnDGoxQUODGrUhvZaJkMuYVVhjZeextPc30TurEOGqfB1rHP+2msjrYtprQmXxDFw1dC0MA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 00/17] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v2 00/17] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHcy+TAanTAnxZJCUS42BSedMOnEw==
Date: Tue, 14 Apr 2026 08:00:26 +0000
Message-ID: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: 4c56d756-c20e-4318-5b59-08de99fbe36d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003; 
x-microsoft-antispam-message-info: If2kDMtO5MXPnPfcKhLL5XlDuEt5rWrFh8FuaGNP2KoDzyfmmwW45KtyweGpGp5mu0x32+TFwJ2CJbhbaaBWWahzaWlqsUC+3pakV7Cmz2HrSykx6Hb0K4zdp5ABFxlgo6uPY+acEuXseV0DcxfU6MuWi7WfJrFWkrEyLgBoJthJDVvYBEQ9VATfNSlfJ22XobK4yxzCd3pVZAiPTkHNpcqNbFqiRhLMYhPiC0StOFdp5n/8OKRiGZXdbpzewdnZRrDbqtne1/BkDdy9JZeu7uwMpLiH+UvdToUZLPDNpwhZTGNDFX50KuYb5AqVKURLOZsmSLwfb6aV2rv+B9sc4XYaRL5a6EMjGz/ctxKfpnyo6S1rzbVupL9zJu0XDWoDbBNVTRVRuT7TFyGaLKVRReU7pNZ35gJMJ9/Rb9+Vj+vSR2YpNDKip9FMVBiGQZaykk210xqGP6D9g64s4LXYe+fEmm9Tmk8/C0RFsDVmVV0P/EFqv/YzwAPh8Tjp5qi2tTdlEk0JfqSxMIdWn6plZSprYzzPUSoQTFB+M1eJdUpFcG5YcVrC3cGIt+wIoBzh63c4hzLl+Sjgu+Q8n9qSlEmwi9tnSmcucCH71/sx5e6p6z/ISUn8W6M+vvuXzd9stigSOrvLT6B/Rn/s468CyTsrT1/EgGQSMZbQmekf2tSgyFQqoK2hVKk0QcMXpiHniEd6zFCW4dVPwiGrhS5AdSw4NFagEwQ/Hli/D8g2GbwRoE9zb9pHzwtbimmTdIudCWeQnkajFXBQBKrpWfEzERTmXSyciRWqa5ekUajX7LU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V65mWyjIEf6NSGNImCLEsSlxZx5SsXTnKogsZ0IjgXY/3BgJPRdOWI9eCG?=
 =?iso-8859-1?Q?vh+cvRe2otrTv4UsIVgCxx9XDreS0wwkc4MBRRwY+C3DDybXuBnGzKGRr1?=
 =?iso-8859-1?Q?yEtMfmsiNKGiYUkGEU8xB+Rbn+5tXAAUw5t6avGPGi5v5Pwnp9GR7AHVAB?=
 =?iso-8859-1?Q?r0SVXc6jD7wKggxCXUIMi9uHZ9OaFQqu5EphhDvG121rvRkoL7dMHEyrKz?=
 =?iso-8859-1?Q?hmxB0ABjzAqZa4qfSOHKo3wALNpEBPSnkdbApb9pFAuo4Nu9gsDO4x3Fgi?=
 =?iso-8859-1?Q?NT4xe7ofR3vsTPfl0KX56J+sdQDSx5ohKJ2ralZh/Qfz7fhuZt7M98zrEe?=
 =?iso-8859-1?Q?Wn6DtVMMgi64uF0zU9p/amaW/oVnifpeE1Fi60Vn9yRe9F9T8FqwWXVbIB?=
 =?iso-8859-1?Q?8xS5hCNwIjRCp61Uiezeke6B/M2s0DP8Ap7Uijb1F6gexxoP5iYlvTjK1B?=
 =?iso-8859-1?Q?KygtQeEdR/WwgOaNLrb4bbQ5T7A96KKwS3CzjhxXzCe+t20lFtql443QJE?=
 =?iso-8859-1?Q?B68tqvIIg1Wus+FExVYOsvmnBHuaMZIA5cW20XPhDbcrzUbMWExbIiHAwX?=
 =?iso-8859-1?Q?QTBzUMRJ4fnrcni5lCXcPb4HAelslXEVkmaWfs4UKFlDaZw+H5DUyO4QvJ?=
 =?iso-8859-1?Q?FbQMxz13Uz4QREsqaZuCJ62Ie0hAsNXjLQjTKxp+zixJrh1llx9tPNGvVG?=
 =?iso-8859-1?Q?SoYTc2PVKPPC7yBVO5Gk1yHu4uYIMmFYPl8IzEspJou5ykoDCvW1q89+AK?=
 =?iso-8859-1?Q?lrAyQIGZQofNSprtZao9u+3lrrZrZKaykwoG0pX9+LW0fV1VbhGbD/we7g?=
 =?iso-8859-1?Q?wza76XVKlPNgJcq532vJFkAz1775q81bHl1pAT7NG8lO0ftUSE2+q2p8IX?=
 =?iso-8859-1?Q?R5OgNQFH2K51jchDeFLyq/YLFsuW3la/HY8GSgWVI9OhZGvwo5LHACNUsN?=
 =?iso-8859-1?Q?NRA8FTCq0cLEBF6YZdnzrB4SmfWJDFRh7qCc4CVODF8ucrrZ/mKH1ujbvO?=
 =?iso-8859-1?Q?shJHhcFD2nwgx7xVojzP92BxjslOWRF/Z43FleR+i4dxz89bBeGU57lehp?=
 =?iso-8859-1?Q?RJLKzMo9p+ytrzfFTW8QwqbRr1OmeEL7gowTp0UkCEqpBKno4iq3Wt1LvP?=
 =?iso-8859-1?Q?ONug5SbdPp7uuQNaBy029Bvzhjh6q1ZyCKuyTtdPy29LY4ioXWU0L/nd1u?=
 =?iso-8859-1?Q?IkZ5FIyiqPqeYGiWXJhL9hhSIvlRE7wO9MPIW+pcPAK1MVM6+2CvySWXGf?=
 =?iso-8859-1?Q?TS2AuiV0azfzvOxeI3P9m0QVlvvpFk6080YsWZYRCcIbJvvwNo2OOpJmv/?=
 =?iso-8859-1?Q?9eCm+UjqZMWWCXcBJbxcwocyVcN1Dcr9puhcNSgyOlofDUh3OBmvJeIzBA?=
 =?iso-8859-1?Q?RvY4KRSn/dO/WmNnbHchTfqGvTA+4ir+vtTT+zM7YYPRGiGt299tl0j8Bu?=
 =?iso-8859-1?Q?+n1bxxU7C/xNlTyJ9Zl82UqN484XSlvPlxEJ458x5EOOkkiIfNZqbkabHX?=
 =?iso-8859-1?Q?7sPPZ2a/CmM3UIaZ2m9U342FRD36WPhNdnldreKRfAPDMP53gy8BJuNgZq?=
 =?iso-8859-1?Q?/aQYKyX9w/wZ0bmqGFuga3sPT+xaqazNt2lcorug4vrFovj4CkIRwN14SJ?=
 =?iso-8859-1?Q?65Y+nPPqBTvD0R/wLr0D2SIy10pvbx/G1qn27L96/cZQCSspMAOCmDPSIe?=
 =?iso-8859-1?Q?AexfnRq9MZuHGLaf5GIHp6TG6pJ1pLZHo/ddcG5D66zAWr9EbwCQNh5bI/?=
 =?iso-8859-1?Q?l5N6E+WI1dGbnL+PzISBUfpqRoZfNv28DXyIshfGyqsVTLRvMDqJZ1R6o0?=
 =?iso-8859-1?Q?2P2PWJxyug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s62Tsq3SW03EWEHj3rqODoOr1cNet/zcmjtq3E5nEtjvf/a0V4u7IckrHp1ixUIQ1dQ/mByn35E3IdHZtCxbhnsKe1Ux0FiF+YLIFCTZkHI0D8WIXgSLAKjC2dBu7nN2wwxwmqnx+Q7EV6+R9UoVn86p029ciB3qj+aEHt66hyvS+7nkrFAjY0m5Dn+Co7GRzndKBzrazuP21IE6ySq60WN22norgW7uBlJPjvqGJbJJ35SxfEfvNJFCfUy4yKOKtTmEDuk0SxQ8XZseoVscBrBuc0ZWO7VAJZffYiMZlTzZI1mfmuZv5OFSLPH9ebZtPtMXEFdhF3H48TjoPtnZYw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c56d756-c20e-4318-5b59-08de99fbe36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:26.4030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8feH+o0eGAkxfUk+s9CicyQHG8hI4YFSYY9uq0F43unxeP/V252NzJd7vpKKZhp5/m5qUUe5tePHH/VWEL7PJU5XxqG40ZE84Jbz0XBN38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
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

EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,=0A=
which provides the upper 32 bits of descriptor addresses when the=0A=
controller advertises 64-bit capability.=0A=
=0A=
Currently QEMU EHCI model only partially supports this functionality and=0A=
descriptor addresses are effectively treated as 32-bit. This becomes=0A=
problematic on systems where system memory is located above the 4GB=0A=
boundary.=0A=
=0A=
The Linux EHCI driver enables 64-bit addressing if the controller=0A=
advertises the capability. During initialization it programs the=0A=
segment register to zero:=0A=
=0A=
  https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
#L600=0A=
=0A=
The driver also notes that descriptor structures allocated from the=0A=
DMA pool use segment zero semantics. Descriptor memory is allocated=0A=
using the DMA API and platforms may configure a 64-bit DMA mask,=0A=
allowing descriptor memory to be placed above 4GB.=0A=
=0A=
On AST2700 platforms, system DRAM is mapped at 0x400000000. As a=0A=
result, descriptor addresses constructed directly from the EHCI=0A=
registers do not match the actual system addresses used by the=0A=
controller when accessing queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
This patch series implements full 64-bit descriptor addressing support=0A=
in the EHCI emulation. Descriptor address handling is updated to use=0A=
64-bit values and the descriptor structures (QH, qTD, iTD and siTD)=0A=
are extended to support the upper address bits provided by the segment=0A=
register.=0A=
=0A=
In addition, a descriptor-addr-offset property is introduced so=0A=
platforms can apply an address translation when descriptor memory=0A=
resides above the 4GB boundary.=0A=
=0A=
The AST2700 machine uses this property to account for its DRAM mapping=0A=
at 0x400000000 and enables 64-bit EHCI DMA addressing.=0A=
=0A=
Test Result:=0A=
1. EHCI 32bits with ast2600-evb machine=0A=
Command line:=0A=
./build/qemu-system-arm \=0A=
  -machine ast2600-evb \=0A=
  -m 1G \=0A=
  -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw \=0A=
  -nographic \=0A=
  -device usb-kbd,bus=3Dusb-bus.1,id=3Dmykbd \=0A=
  -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
  -device usb-storage,bus=3Dusb-bus.1,id=3Dmystorage,drive=3Dusbdisk=0A=
  -snapshot \=0A=
  -nographic=0A=
Result:=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-=
v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller=0A=
Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_=
hcd Generic UHCI Host Controller=0A=
=0A=
2. EHCI 64bits with ast2700a2-evb machine=0A=
Command line:=0A=
./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\=0A=
 -bios ast27x0_bootrom.bin \=0A=
 -drive file=3Dimage-bmc,format=3Draw,if=3Dmtd \=0A=
 -snapshot \=0A=
 -device usb-kbd,bus=3Dusb-bus.3,id=3Dmykbd \=0A=
 -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
 -device usb-storage,bus=3Dusb-bus.3,id=3Dmystorage,drive=3Dusbdisk=0A=
Result:=0A=
root@ast2700-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-=
v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_=
hcd EHCI Host Controller=0A=
Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
 =0A=
v1=0A=
 1. Fix checkpatch coding style issues=0A=
 2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors=0A=
 3. Add descriptor address offset property=0A=
 4. Enable 64-bit EHCI DMA addressing on AST2700=0A=
 5. Configure descriptor address offset for AST2700=0A=
=0A=
v2=0A=
 1. Remove unused EHCIfstn structure and dead code=0A=
 2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)=0A=
 3. Replace DPRINTF debug logs with trace events=0A=
 4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2=0A=
 5. Fix review issue=0A=
 =0A=
Jamin Lin (17):=0A=
  hw/usb/hcd-ehci: Remove unused EHCIfstn structure and dead code=0A=
  hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with=0A=
    qemu_log_mask(LOG_GUEST_ERROR)=0A=
  hw/usb/hcd-ehci: Replace DPRINTF debug logs with trace events=0A=
  hw/usb/hcd-ehci: Change descriptor addresses to 64-bit=0A=
  hw/usb/hcd-ehci: Add property to advertise 64-bit addressing=0A=
    capability=0A=
  hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without 64-bit capability=0A=
  hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Add descriptor address offset property=0A=
  hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing=0A=
  hw/arm/aspeed_ast27x0: Set EHCI descriptor address offset=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for=0A=
    AST2600 SDK=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for=0A=
    AST2700 A1/A2=0A=
=0A=
 hw/usb/hcd-ehci.h                             |  55 ++-=0A=
 hw/arm/aspeed_ast27x0.c                       |   5 +=0A=
 hw/usb/hcd-ehci-pci.c                         |   4 +=0A=
 hw/usb/hcd-ehci-sysbus.c                      |   4 +=0A=
 hw/usb/hcd-ehci.c                             | 371 ++++++++++--------=0A=
 hw/usb/trace-events                           |  25 +-=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   7 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   7 +=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +=0A=
 9 files changed, 294 insertions(+), 191 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

