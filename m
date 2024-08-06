Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717D7C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbNSq-0001FV-82; Tue, 06 Aug 2024 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.mamone@cambridgeconsultants.com>)
 id 1sbNSo-0001DC-4r
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:55:10 -0400
Received: from mail-mw2nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2412::607]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.mamone@cambridgeconsultants.com>)
 id 1sbNSf-0001Wh-IX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2dPh3f/5wChw0MXHE9M8cPlPcePNGdVBTQRNf9yJ4bKXqDVW0V2IFhXSXeWIKgo7iAjesZwfc9v7aJC6D3GLYOMLuPfIUUDEd72rPblZ5NB05UzvAnGJjOpnq4ecffwhPsho64bB9Nus3dl/e/CuA3yNpLIe8gOgQYWkDT5/N9lj2ZzaraBUK/J3zg1AAMLmRjhCG0KLVMrcJ/+QpPbKQhT8JxFmmR2uHeH8Gajyrg816XjvaTp0eEODnkozy/7SvCPiKhfl7/Ojry6Kh+7xA99fCDKmdxLVi+6r0aKprEBsUFhY7AzB493g4aBFtPONEUmGzaWUXy2FprbyO3qEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdQAAddyGhvR3iqx7/SRJ0SX8ZrsgquviRl8mvCCQDk=;
 b=eZD9GNmrbMPShKfA4aqm9Rgt0vLLgjpdNrfu7Km4Zl+nZb29W9TImHnF2HZ9791nHoImxa4iA7sEl7tnLHJSeeVZAKoX7Dne1Wbx5PvI0Bwp6R7mQWfXCXKDxSoGs2aYLGRZcqWZu71DBKvmCo9R4/CFfzPfqlwx8mvHZIA4YbanHP/NpBbdVBpXcN+9bNNC3O60hajCcbH5uJXFTT/BzpBfhoznvdHKfSGXJiMHtgtPwT10YIjjXQl6JS9+ZpwT2mYI9aJQ+Oj2L3fndEfO+CwwPU4l5rc2CaoIvftcyN/3Jc8gUZNFQAc5YEDugaPoDbz/tMMQ3EH0utOQJ34o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cambridgeconsultants.com; dmarc=pass action=none
 header.from=cambridgeconsultants.com; dkim=pass
 header.d=cambridgeconsultants.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cambridgeconsultants.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdQAAddyGhvR3iqx7/SRJ0SX8ZrsgquviRl8mvCCQDk=;
 b=acY8FTUwkf3nh5sjV/2dOUjc2F60Lyxot48UM2OxmPRoYULFuYGoMNKwQxZLSAYh+v1rRCJAIv/lyjeuO6kOx7b7N2+mrDsDk5ctMe6D5xkg9sp7b7F4BC/TzhcW1160zL+1W+aPntHA68dEK69xPweFmBvnG8S9pAV8kX1EuldUZE+UYtYDoh43eJlyWmGkmadGcDzCUYKVDO1EX96EW384zuArTgQFZQHYk2J06f8gd6+N4JsjKYn/2xaPbgB4b93AhdMGspoO5P2/tDN+vNT4NgsyV7nh4qP2r9APvZKcsYOdfx7xOmi4XdkbSqHxoKCw15+WI71+DOA5OVewCg==
Received: from MN2PR18MB3245.namprd18.prod.outlook.com (2603:10b6:208:163::16)
 by BN9PR18MB4298.namprd18.prod.outlook.com (2603:10b6:408:11c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 16:43:44 +0000
Received: from MN2PR18MB3245.namprd18.prod.outlook.com
 ([fe80::aa67:58c0:bf38:31d5]) by MN2PR18MB3245.namprd18.prod.outlook.com
 ([fe80::aa67:58c0:bf38:31d5%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 16:43:44 +0000
From: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Ryan Mamone
 <ryan.mamone@cambridgeconsultants.com>
Subject: Re: [PATCH] hw/display: Add SSD1306 dot matrix display controller
 support
Thread-Topic: [PATCH] hw/display: Add SSD1306 dot matrix display controller
 support
Thread-Index: AdqbK345jaEl2j54Qs+mUnVNH1704QBZZLCAEtosywY=
Date: Tue, 6 Aug 2024 16:43:44 +0000
Message-ID: <MN2PR18MB3245939BA4021D81B074FE699EBF2@MN2PR18MB3245.namprd18.prod.outlook.com>
References: <MN2PR18MB3245B1A3994C378A3BED5C439E1A2@MN2PR18MB3245.namprd18.prod.outlook.com>
 <CAFEAcA_GahiNnn10itFccO-vqjzzLpSRmo2DixQdQhqrGYknvw@mail.gmail.com>
In-Reply-To: <CAFEAcA_GahiNnn10itFccO-vqjzzLpSRmo2DixQdQhqrGYknvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cambridgeconsultants.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB3245:EE_|BN9PR18MB4298:EE_
x-ms-office365-filtering-correlation-id: d28bfd15-2067-4c4e-256e-08dcb636ef9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hkd7mRpSgdeqgCFBRz8IYr0OIcGFE2lvoud2V0B8Wa8VQdo6r8i0fy+4nu?=
 =?iso-8859-1?Q?PBLF4zTitUzO4tBDJo6z90GL8IaEHMf1yQtkQZQcaX9RxqnDwklLM6LPJ4?=
 =?iso-8859-1?Q?886cideSp6OPwJguLSdZQ/N4vRU8xukSVP7QC/ZqRhDYwb5gQet+r2o6Ph?=
 =?iso-8859-1?Q?nA51SKzqvihNvRxfRuZ5v+HhxdaJqcyQiqer0mUELOCKCrUcw2N190vM8f?=
 =?iso-8859-1?Q?5749KODOzHXKBifjndMqmgqcZatZst8ixRSLcBSbnsHqgY5LkhipRapnyM?=
 =?iso-8859-1?Q?ImA4wNe4ieANrqeoXPW5CKoO3fMI2wTCKYH4mq8cYbJInJi87n87vJaVsW?=
 =?iso-8859-1?Q?+iQa7m23JBOJol6Qi4H32SqDfxmorh58E3zV43OVr9WDWBCytRWkJk10vj?=
 =?iso-8859-1?Q?4jiEGDOxDcXfNjDOXQ7+dDMRboClb9+G3w9GgvNP0DHP1oQcU1/xx9KUJZ?=
 =?iso-8859-1?Q?lg42oI8nerOziukmLotLJVxX5JRMPEb7hYg2d0Tut7pruQ7ND4RlyuWfG4?=
 =?iso-8859-1?Q?hdsQtG3Rboi6erjfMrL7aG4c6I/qbFKR8HP9ZNw/FRIpHUmNihzKcAV8Yg?=
 =?iso-8859-1?Q?zLDuSKplsECW0Fn+SoXSpLCgyyFKL6WD2tp8lqaOVCYKOGnLAslzeAeHLo?=
 =?iso-8859-1?Q?JfT4H7S/wsT5PI3VXWJXM5YW8a5VYgLzkI4IX6Cn4WCkQrk0yKSmPlNy2k?=
 =?iso-8859-1?Q?CUDrPZ1vN7hegVYBuZB9gNUV9vqJDhEnyYv+ydNPIRUK0tcxNql9exgaBH?=
 =?iso-8859-1?Q?/UEASkM4I6ZBKS7PT6MIWFKilAm0Sl+FzLSfGMc9wZHxwcr+Rh4VELGUoo?=
 =?iso-8859-1?Q?TTNbzmmbX3C2Q7+gfGDYo/Z5+e3Z0UmNWrWWUrKefItvLJ1jO6/6H8Mgov?=
 =?iso-8859-1?Q?avIZsDHKPuL21A5+i94xWc/cAzHdzOzgxXyOeU459unlSIAu6ODR1svAiY?=
 =?iso-8859-1?Q?1DFBrLJY5YTWgE5TVkRtcCBAINOugKVekXdyyjoSjsb9Q5d9GfWoOnGJJz?=
 =?iso-8859-1?Q?zFC8KVLW7n7YwYE3bGorNZUUz+W8GZd1F1HkJQp/zFHwAIdZ8yQ1LieoKi?=
 =?iso-8859-1?Q?rh2myfqGK6a89+EEJWYMFhXnELiNhfAAdByIaUncSGWIW0i+H66NWcephS?=
 =?iso-8859-1?Q?/Nau5WaT+zTH6VPi3K9pMZAL4SWmqxmtDCNAVB3tjEzFDTfIb67+LlxMnP?=
 =?iso-8859-1?Q?VTl4NAlVnqiEjn0aop6s65nXgYsiRQZLo4K6SNB51tKt7urDrhBe1dJ99a?=
 =?iso-8859-1?Q?+Tc8Ivh4KITlxHuHStQMSgHfjx9C4Qw52VpVkmdR8qaV91G0EgQXRSMYzT?=
 =?iso-8859-1?Q?sMeAVUZcCASPiLjLyLRn9SzGrToBf3E6Rtnfz+QSf0PdNB/kxhweFGL0wi?=
 =?iso-8859-1?Q?tz6r+fF5PK6JZNUK4toE3up4Y6jJfBFw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR18MB3245.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I4xCUYA/AMLQDTLRji+sMQw2frXE1VvOa9kujoWE+7UHApghwlfPbtLe0n?=
 =?iso-8859-1?Q?OFp6wHRFKOZBqEhBxfsf2/DTyZPV/5BEMKsLrWVElJTh3AYZpdmEqY50Vz?=
 =?iso-8859-1?Q?YAsmNOTBXaMSt2kmUF77IEmrwEvtnAvFdsYjdq2GCyjP/b2hN7fUfNyM6Y?=
 =?iso-8859-1?Q?BVfpQVlb1seyf91/wunVlIkUiZrBuz52O796N4TBnd4KmEKQxr3qGjnBts?=
 =?iso-8859-1?Q?bWiyO7qrQ0zJWyTAHCB3A2OxgQLa9uxOx8dxAtAy4H7f03jJ8ryEUE15Ba?=
 =?iso-8859-1?Q?ogGnvDMZHeuz6vj2E/xiZQOdIIEdqlxOUCgUySmMcrp00YiDbetvnXBDkY?=
 =?iso-8859-1?Q?EQImTIVFdMDO6ys23UYSV/0ciyA90nEeDfQ2ZcBpjjutcmeayMXg5FVXqs?=
 =?iso-8859-1?Q?EPPieTlOwZCEQk9YzvoU9gMO/DWbtSism928NX1jVeihZT6ujD2rVAUP0K?=
 =?iso-8859-1?Q?YzBU/qmjZxRO1fL5e1MDqOW09/BZs+gZ9PXwpVzk3deQZxhsP+HVBTsNLD?=
 =?iso-8859-1?Q?4sB4r4b8memmAkq5aygnGJBlvCVNhXlcqMYvnpKCTFkbiqbCRVO8OYWJVW?=
 =?iso-8859-1?Q?GyOTrqpXpRFb0EfBxTRzk9mExrkiINU8K6uie6rBuqczxLuz3K9A1XDF5m?=
 =?iso-8859-1?Q?SjoILsLQyuw5TCRvKSFTQ5RQe8TZrUopMFU253FohcgfKt/lRbRLKe+X95?=
 =?iso-8859-1?Q?Ex/gKIB+wvP+oMPMzwKQKuZkSAFJcGj9pyiSw+ZaowGFMIyUvoG5ZD29iV?=
 =?iso-8859-1?Q?DeFNzangX6MFrzkXDqRDQl+ygJt/T8MF/qUjQDPBUtDyi84b6jmMePvSyL?=
 =?iso-8859-1?Q?6+DNOq/4NyaKtgV22/o8YJxiMiAyI4Zi0tSBLIWgXqsRirw8KiRHlrbsgh?=
 =?iso-8859-1?Q?EPVt3z3slEZ5DRM3ExC3f8uqkRUdlkzcJ/WOl4vB8Mh6fKSpc/qQfAVtNi?=
 =?iso-8859-1?Q?2YFQKWWFZ47X/bgXT8XeAl4jD3G8WGRkGSXfnCsx9qNsr7e8DSEGhlAk8L?=
 =?iso-8859-1?Q?k596GyqJlfPfrylmQtWJTdA9a6ZHNDpB+X5EqVKftbOlcQA3R+kgqXdeU/?=
 =?iso-8859-1?Q?lSL02kVQMS9+C97n3elemSRzs8E6gJpR236u2lzFDsJEeB+HXZRRnzVW87?=
 =?iso-8859-1?Q?vqELteZk+s+nU9iWku2LjhIctZ+95dkRp6nYuMRvUXrrBw8i+4/EvM1ToL?=
 =?iso-8859-1?Q?lOHe9bUumZY5iVeNkrgBDvCfKTT6bqJ+/5WrfQfcriMry8ab/YFtnnhN0s?=
 =?iso-8859-1?Q?psK95WYFeL9cHGEEep1G+kqpl/5+1GLJP72PxCQAuwQkBjOTH+oeYVhIzm?=
 =?iso-8859-1?Q?ZsMP6eeqcIlzobqbDriz/c+5V5wHeT6Uv6rpAipbIuTpNz0bAc1+t2YhWt?=
 =?iso-8859-1?Q?1P5mmaHdckR5RPs796WmCdGmnaFWlnpNLt41mi+5przIiCKumQBQVsObO+?=
 =?iso-8859-1?Q?KGALCihy69iwFvYv/yWvdh0WinzWJA9qJwkXgvVu8FVvI1BkOe1NLDHAvu?=
 =?iso-8859-1?Q?I4dMrFb4Bi+fvzvIWfXvJZh7UzDqQQ3WUHGdqAybmmLiZ5JGpjZskDhl4L?=
 =?iso-8859-1?Q?vO7ppQbkhYqghDjAhu3CzCABIyR6BK1yxvStLavurk3EGp1ezbQNn/KIyF?=
 =?iso-8859-1?Q?ZWl/dAGXoRXJXj73fM/OJVCut69ffV3aNkNClLSc3cMjj5haYi0cWUMw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cambridgeconsultants.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3245.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28bfd15-2067-4c4e-256e-08dcb636ef9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 16:43:44.3991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5456737e-8eab-46dd-b7dd-26953ed21090
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRw0tXasJrkg/hJkHBo7iwYhnTjzSXOLD9+WlsJBriQSS9kXD2DzVtMP7powf7L4kaB2A9khbl0ERMdA7tKFRTy4DbAzBFbPMV6WD2f/cEhvrk1SED/Jf4UzfPY8uxRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4298
Received-SPF: pass client-ip=2a01:111:f403:2412::607;
 envelope-from=ryan.mamone@cambridgeconsultants.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hi Peter,
I responded to this over 3mo ago and haven't seen a reply. I'm assuming it =
got lost so I'll try again.
For some background, I put together an internal Yocto training targeting a =
Raspberry Pi Zero board with a small SSD1306 based OLED display (ex. https:=
//www.adafruit.com/product/3527). The datasheet can be found on the adafrui=
t site at (https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf). To suppor=
t attendees which might not have the physical hardware I offer a QEMU build=
 with this patch so they can properly emulate the hardware to test their bu=
ilt image. I figured this patch could be useful to others who might want to=
 emulate these displays and got approval from work to contribute this patch=
.

To answer your question, this patch isn't to support a specific board but t=
o offer general support for these types of OLED displays. This is why I set=
 kconfig to select this device with I2C_DEVICES instead of being selected b=
y a specific board or architecture. However a RPi with one of these display=
s is a good example of a likely use case.

This SSD1306 controller seems to be used in the majority of these small che=
ap graphics OLED displays (mostly 128x64 or 128x32). The Yocto image I've b=
uilt uses the Luma OLED (https://luma-oled.readthedocs.io/) Python library =
to easily interface with the display. This is how I've performed all my tes=
ting (and what drove which commands I needed to implement). I'd recommend u=
sing the luma example scripts found here (https://github.com/rm-hull/luma.e=
xamples/tree/master/examples) for ease of testing. For instance running 'py=
thon3 examples/pi_logo.py --height 32' from within that repo. I can provide=
 you with an image and my QEMU command line arguments if needed for testing=
.

The code in this patch is largely based off the existing ssd0303 device mod=
el. To your point there is some overlap between the two devices. However th=
e existing ssd0303 device model is not fully compatible with the ssd1306. I=
 believe some of the commands differ but more importantly the ssd0303 imple=
mentation doesn't support multi-byte commands. To add that support would re=
quire an overhaul of the state machine. I'm not particularly familiar with =
the QEMU codebase or conventions as this is my first time looking at it so =
forgive me not knowing the best way to approach things. Most of the comment=
s you made were on code that was taken directly from the existing ssd0303 d=
evice. For instance DPRINTF usage, scaling_factor (which it calls 'MAGNIFY'=
), surface_bits_per_pixel handling, lack of reset handling, etc.

I do believe there needs to be some sort of scaling of the image as display=
ing 128x32 pixels on a modern high dpi monitor will result in something not=
 very usable which is why I exposed it as a property so a user can scale it=
 to their liking without needing to rebuild the device. If this could be ha=
ndled at a higher UI level that would be nice but I wouldn't even know wher=
e to begin on implementing something like that and it's not really my inten=
tion to become a regular maintainer (just figured it would be nice to give =
back to the community).

Your comments on the multiple framebuffers are valid. It's definitely not t=
he most efficient but I feel it's much easier to understand/maintain if it'=
s broken into multiple steps. I opted to err on code readability/maintainab=
ility over resource utilization. And since this is an optional component an=
d the resources (i.e. memory) are generally considered less scarce on the d=
esktop PC platforms I'd expect this to be run on, I feel it's a fair tradeo=
ff.

Per your comment on device reset handling, I'm not sure what a device reset=
 means with regards to an I2C device. While this device does have a physica=
l reset pin it's not part of the I2C bus and there is no explicit reset com=
mand over that bus.

Included below is a new patch with some of the changes you had recommended.

PS I'm stuck using corporate Outlook account for these correspondences so I=
 don't have access to tools like git send-mail. Let me know if there is som=
ething better I can do in these emails and I'm sorry if it completely destr=
oys your normal workflow.

Thanks
-Ryan



From de8696f9baa52ef63406fa8061b9f6acc609df87 Mon Sep 17 00:00:00 2001
From: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
Date: Tue, 30 Apr 2024 13:20:50 -0400
Subject: [PATCH] hw/display: Add SSD1306 dot matrix display controller supp=
ort

Signed-off-by: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
---
 hw/display/Kconfig     |   5 +
 hw/display/meson.build |   1 +
 hw/display/ssd1306.c   | 610 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 616 insertions(+)
 create mode 100644 hw/display/ssd1306.c

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a4552c8ed7..bfffa85cc8 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -37,6 +37,11 @@ config SSD0303
 config SSD0323
     bool

+config SSD1306
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
 config VGA_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 7db05eace9..4c3bccf87c 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_PL110', if_true: files('pl110=
.c'))
 system_ss.add(when: 'CONFIG_SII9022', if_true: files('sii9022.c'))
 system_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd0303.c'))
 system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
+system_ss.add(when: 'CONFIG_SSD1306', if_true: files('ssd1306.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xenfb.c'))

 system_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('vga-pci.c'))
diff --git a/hw/display/ssd1306.c b/hw/display/ssd1306.c
new file mode 100644
index 0000000000..d49eb775b3
--- /dev/null
+++ b/hw/display/ssd1306.c
@@ -0,0 +1,610 @@
+/*
+ * SSD1306 Dot Matrix Display Controller.
+ *
+ * The SSD1306 controller can support a variety of different displays up t=
o
+ * 128 x 64. The dimensions of the emulated display can be configured by t=
he
+ * 'width' and 'height' properties and has been tested using the most comm=
on
+ * displays dimensions of 128x64 and 128x32. A 'scaling' property has also
+ * been provided to perform integer pixel scaling of the output image to m=
ake
+ * it more viewable on pc displays. While the SSD1306 controller supports
+ * multiple physical interfaces this implementation only supports the I2C
+ * interface. Most of the commands relating to physical control, scrolling=
,
+ * multiplexing, and scanning direction are ignored.
+ *
+ * Datasheet can be located at:
+ * https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf
+ *
+ * Copyright (C) 2024 Cambridge Consultants.
+ * Written by Ryan Mamone
+ *
+ * This code is licensed under the GPLv2.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "ui/console.h"
+#include "qom/object.h"
+#include "qemu/log.h"
+
+
+/* Max supported display dimensions of the SSD1306 controller */
+#define MAX_WIDTH 128
+#define MAX_HEIGHT 64
+/* Surface color depth 32bit */
+#define COLOR_DEPTH_BPP 32
+
+enum ssd1306_addr_mode {
+    ssd1306_ADDR_MODE_HORIZ =3D 0,
+    ssd1306_ADDR_MODE_VERT =3D 1,
+    ssd1306_ADDR_MODE_PAGE =3D 2,
+    ssd1306_ADDR_MODE_INVALID
+};
+
+enum ssd1306_mode {
+    ssd1306_IDLE,
+    ssd1306_DATA,
+    ssd1306_CMD,
+    ssd1306_CMD_DATA
+};
+
+#define TYPE_SSD1306 "ssd1306"
+OBJECT_DECLARE_SIMPLE_TYPE(ssd1306_state, SSD1306)
+
+struct ssd1306_state {
+    I2CSlave parent_obj;
+
+    QemuConsole *con;
+    /* Emulated display dimensions */
+    uint8_t width;
+    uint8_t height;
+    /* Integer scaling factor to enlarge pixels for better viewing on PC d=
isplays */
+    uint8_t scaling_factor;
+    uint8_t addr_mode;
+    uint8_t col;
+    uint8_t col_start;
+    uint8_t col_end;
+    uint8_t page;
+    uint8_t page_start;
+    uint8_t page_end;
+    bool flash;
+    bool enabled;
+    bool inverse;
+    bool redraw;
+    enum ssd1306_mode mode;
+    uint8_t cmd; /* Command ID byte */
+    uint8_t cmd_byte_num; /* Command data parameter number */
+    uint8_t mono_framebuffer[MAX_WIDTH * MAX_HEIGHT];
+    uint8_t color_framebuffer[MAX_WIDTH * MAX_HEIGHT * (COLOR_DEPTH_BPP / =
8)];
+};
+
+/* Handler for I2C data transferred from SSD1306 controller */
+static uint8_t ssd1306_recv(I2CSlave *i2c)
+{
+    qemu_log_mask(LOG_UNIMP, "ssd1306: Reads not implemented\n");
+    return 0xff;
+}
+
+/* Handler for I2C data transferred to SSD1306 controller */
+static int ssd1306_send(I2CSlave *i2c, uint8_t data)
+{
+    ssd1306_state *s =3D SSD1306(i2c);
+
+    switch (s->mode) {
+    case ssd1306_IDLE:
+        s->mode =3D ((data & 0x40) =3D=3D 0x40) ? ssd1306_DATA : ssd1306_C=
MD;
+        break;
+    case ssd1306_DATA:
+        /*
+         * Map incoming data to pixels at correct location in framebuffer.
+         * Notably every 8 pixels are mapped vertically along the page
+         * (ref Figure 10-2 in the datasheet).
+         */
+        for (int i =3D 0; i < 8; i++) {
+            /* Simulating a monochrome display so just set/clear all bits =
*/
+            s->mono_framebuffer[(((s->page * 8) + i) * s->width) + s->col]=
 =3D
+                ((data >> i) & 0x01) ? 0xff : 0x00;
+        }
+
+        /* GDDRAM pointers update differently dependent on the addressing =
mode */
+        switch (s->addr_mode) {
+        case ssd1306_ADDR_MODE_HORIZ: /* Horizontal Addressing Mode */
+            s->col++;
+            if (s->col > s->col_end) {
+                s->col =3D s->col_start;
+                s->page++;
+                if (s->page > s->page_end) {
+                    s->page =3D s->page_start;
+                }
+            }
+            break;
+        case ssd1306_ADDR_MODE_VERT: /* Vertical Addressing Mode (UNTESTED=
) */
+            s->page++;
+            if (s->page > s->page_end) {
+                s->page =3D s->page_start;
+                s->col++;
+                if (s->col > s->col_end) {
+                    s->col =3D s->col_start;
+                }
+            }
+            break;
+        case ssd1306_ADDR_MODE_PAGE: /* Page Addressing Mode (UNTESTED) */
+            if (s->col < s->col_end) {
+                s->col++;
+            }
+            break;
+        default:
+            break;
+        }
+        s->redraw =3D true;
+        break;
+    case ssd1306_CMD:
+            s->cmd =3D data;
+            s->cmd_byte_num =3D 0;
+            /*
+             * Fallthrough so same code can handle commands with/without
+             * additional data bytes.
+             */
+            __attribute__ ((fallthrough));
+    case ssd1306_CMD_DATA:
+        switch (s->cmd) {
+        /*
+         * Fundamental Commands
+         */
+        /* Set Contrast Control */
+        case 0x81:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else {
+                data =3D data;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Entire display off (Use GDDRAM) */
+        case 0xA4:
+            s->flash =3D false;
+            s->redraw =3D true;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Entire display on (Ignore GDDRAM) */
+        case 0xA5:
+            s->flash =3D true;
+            s->redraw =3D true;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Inverse off */
+        case 0xA6:
+            s->inverse =3D false;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Inverse on */
+        case 0xA7:
+            s->inverse =3D true;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Display off */
+        case 0xAE:
+            s->enabled =3D false;
+            s->redraw =3D true;
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Display on */
+        case 0xAF:
+            s->enabled =3D true;
+            s->redraw =3D true;
+            s->mode =3D ssd1306_CMD;
+            break;
+
+        /*
+         * Scrolling Commands
+         */
+        /* Continuous Horizontal Scroll Setup (6 data bytes) */
+        case 0x26 ... 0x27:
+            if (s->cmd_byte_num =3D=3D 0) {
+                qemu_log_mask(LOG_UNIMP,
+                    "ssd1306: Continuous Horizontal Scroll Setup not imple=
mented\n");
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 6) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Continuous Vertical and Horizontal Scroll Setup (5 data bytes) =
*/
+        case 0x29 ... 0x2A:
+            if (s->cmd_byte_num =3D=3D 0) {
+                qemu_log_mask(LOG_UNIMP,
+                    "ssd1306: Continuous Vertical and Horizontal Scroll Se=
tup"
+                    " not implemented\n");
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 5) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Deactivate Scroll */
+        case 0x2E:
+            qemu_log_mask(LOG_UNIMP, "ssd1306: Deactivate Scroll not imple=
mented\n");
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Activate Scroll */
+        case 0x2F:
+            qemu_log_mask(LOG_UNIMP, "ssd1306: Activate Scroll not impleme=
nted\n");
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Vertical Scroll (2 data bytes) */
+        case 0xA3:
+            if (s->cmd_byte_num =3D=3D 0) {
+                qemu_log_mask(LOG_UNIMP,
+                    "ssd1306: Set Vertical Scroll not implemented\n");
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 2) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+
+        /*
+         * Address Setting Commands
+         */
+        /* Set Lower Column Start Address for Page Addressing Mode */
+        case 0x00 ... 0x0F:
+            s->col =3D (s->col & 0xf0) | (data & 0xf);
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Higher Column Start Address for Page Addressing Mode */
+        case 0x10 ... 0x1F:
+            s->col =3D (s->col & 0x0f) | (data & 0xf);
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Memory Addressing Mode (1 data byte) */
+        case 0x20:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->addr_mode =3D data & 0x3;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Column Address (2 data bytes) */
+        case 0x21:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->col_start =3D data & 0x7F;
+                s->col =3D s->col_start;
+            } else if (s->cmd_byte_num =3D=3D 2) {
+                s->col_end =3D data & 0x7F;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Page Address (2 data bytes) */
+        case 0x22:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->page_start =3D data & 0x07;
+                s->page =3D s->page_start;
+            } else if (s->cmd_byte_num =3D=3D 2) {
+                s->page_end =3D data & 0x07;
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Page Start Address for Page Addressing Mode */
+        case 0xB0 ... 0xB7:
+            s->page =3D data & 0x07;
+            s->mode =3D ssd1306_CMD;
+            break;
+
+        /*
+         * Hardware Configuration Commands
+         */
+        /* Set Display Start Line */
+        case 0x40 ... 0x7F:
+            if (s->cmd !=3D 0x40) {
+                qemu_log_mask(LOG_UNIMP,
+                    "ssd1306: Set Display Start Line (cmd 0x%02x) not impl=
emented\n",
+                    s->cmd);
+            }
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Segment Re-map */
+        case 0xA0 ... 0xA1:
+            if (s->cmd =3D=3D 0xA1) {
+                qemu_log_mask(LOG_UNIMP,
+                    "ssd1306: Set Segment Re-map (cmd 0x%02x) not implemen=
ted\n",
+                    s->cmd);
+            }
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Multiplex Ratio (1 data byte) */
+        case 0xA8:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                if (data !=3D s->height - 1) {
+                    qemu_log_mask(LOG_UNIMP,
+                        "ssd1306: Set Multiplex Ratio (0x%02x) not impleme=
nted\n",
+                        data);
+                }
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set COM Output Scan Direction */
+        case 0xC0 ... 0xC8:
+            if (s->cmd =3D=3D 0xC8) {
+                qemu_log_mask(LOG_UNIMP,
+                    "ssd1306: Set COM Output Scan Dir (cmd 0x%02x) not imp=
lemented\n",
+                    s->cmd);
+            }
+            s->mode =3D ssd1306_CMD;
+            break;
+        /* Set Display Offset (1 data byte) */
+        case 0xD3:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                if (data !=3D 0x00) {
+                    qemu_log_mask(LOG_UNIMP,
+                        "ssd1306: Set Display Offset (0x%02x) not implemen=
ted\n",
+                        data);
+                }
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set COM Pins Hardware Configuration (1 data byte) */
+        case 0xDA:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                if (data !=3D 0x12) {
+                    qemu_log_mask(LOG_UNIMP,
+                        "ssd1306: Set COM Pins Hardware (0x%02x) not imple=
mented\n",
+                        data);
+                }
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+
+        /*
+         * Timing and Driving Scheme Setting Commands
+         */
+        /* Set Display Clock Divide Ratio/Oscillator Freq. (1 data byte) *=
/
+        case 0xD5:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Pre-charge Period (1 data byte) */
+        case 0xD9:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Set Vcomh Deselect Level (1 data byte) */
+        case 0xDB:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* Charge Pump Setting (1 data byte) */
+        case 0x8D:
+            if (s->cmd_byte_num =3D=3D 0) {
+                s->mode =3D ssd1306_CMD_DATA;
+            } else if (s->cmd_byte_num =3D=3D 1) {
+                s->mode =3D ssd1306_CMD;
+            }
+            break;
+        /* NOP */
+        case 0xE3:
+            s->mode =3D ssd1306_CMD;
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "ssd1306: Unknown command: 0x%x\n", d=
ata);
+        }
+        s->cmd_byte_num++;
+        break;
+    }
+
+    return 0;
+}
+
+/* Handles I2C bus framing events */
+static int ssd1306_event(I2CSlave *i2c, enum i2c_event event)
+{
+    ssd1306_state *s =3D SSD1306(i2c);
+
+    switch (event) {
+    case I2C_FINISH:
+        s->mode =3D ssd1306_IDLE;
+        break;
+    case I2C_START_RECV:
+    case I2C_START_SEND:
+    case I2C_NACK:
+        /* Nothing to do.  */
+        break;
+    default:
+        return -1;
+    }
+
+    return 0;
+}
+
+/*
+ * Helper function to convert monochrome framebuffer to color framebuffer
+ * by padding out values to match dest color depth.
+ * 'src' framebuffer is expected to be 1 byte per pixel
+ */
+static void ssd1306_mono_to_color_fb(uint8_t *src, uint32_t size,
+                            uint8_t *dst, uint8_t bits_per_pixel)
+{
+    unsigned int idx =3D 0;
+    for (int i =3D 0; i < size; i++) {
+        for (int pad =3D 0; pad < (bits_per_pixel / 8); pad++) {
+            dst[idx++] =3D src[i];
+        }
+    }
+}
+
+/* Helper function to perform per pixel integer scaling */
+static void ssd1306_scale_fb(uint8_t *src, uint32_t src_width, uint32_t sr=
c_height,
+                          uint8_t src_bits_per_pixel, uint8_t *dst, uint8_=
t scale_factor)
+{
+    uint8_t bytes_per_pixel =3D src_bits_per_pixel / 8;
+    unsigned int idx =3D 0;
+
+    /* Scaling of 1 is just a direct copy */
+    if (scale_factor =3D=3D 1) {
+        memcpy(dst, src, src_width * src_height * bytes_per_pixel);
+    } else {
+        /*
+         * Copies each pixel (size=3Dsrc_bits_per_pixel) scale_factor time=
s and
+         * duplicate each of those lines scale_factor times.
+         */
+        for (int h =3D 0; h < src_height; h++) {
+            for (int hs =3D 0; hs < scale_factor; hs++) {
+                for (int w =3D 0; w < src_width; w++) {
+                    for (int ws =3D 0; ws < scale_factor; ws++) {
+                        memcpy(&dst[idx],
+                               &src[h * src_width * bytes_per_pixel +
+                                    w * bytes_per_pixel],
+                               bytes_per_pixel);
+                        idx +=3D bytes_per_pixel;
+                    }
+                }
+            }
+        }
+    }
+}
+
+/* Render the virtual framebuffer to the surface which will be displayed *=
/
+static void ssd1306_update_display(void *opaque)
+{
+    ssd1306_state *s =3D (ssd1306_state *)opaque;
+    DisplaySurface *surface =3D qemu_console_surface(s->con);
+
+    if (!s->redraw) {
+        return;
+    }
+
+    /* NOTE: Maintainer stated color depth is always 32bpp*/
+    int bpp =3D surface_bits_per_pixel(surface);
+    uint8_t *dest_surface =3D surface_data(surface);
+
+    if (s->flash) {
+        /* Turn on all pixels */
+        memset(dest_surface, 0xff,
+                (s->width * s->scaling_factor) *
+                (s->height * s->scaling_factor) *
+                (bpp / 8));
+    } else if (!s->enabled) {
+        /* Clear the output */
+        memset(dest_surface, 0x00,
+                (s->width * s->scaling_factor) *
+                (s->height * s->scaling_factor) *
+                (bpp / 8));
+    } else {
+        /*
+         * The following operations could have been done in a single pass
+         * but that would likely have resulted in less readable code.
+         */
+        ssd1306_mono_to_color_fb(s->mono_framebuffer, s->width * s->height=
,
+                                    s->color_framebuffer, bpp);
+        ssd1306_scale_fb(s->color_framebuffer, s->width, s->height, bpp,
+                            dest_surface, s->scaling_factor);
+    }
+    s->redraw =3D false;
+    dpy_gfx_update(s->con, 0, 0, s->width * s->scaling_factor,
+                    s->height * s->scaling_factor);
+}
+
+static void ssd1306_invalidate_display(void *opaque)
+{
+    ssd1306_state *s =3D (ssd1306_state *)opaque;
+    s->redraw =3D true;
+}
+
+static const VMStateDescription vmstate_ssd1306 =3D {
+    .name =3D "ssd1306_oled",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, ssd1306_state),
+        VMSTATE_UINT8(addr_mode, ssd1306_state),
+        VMSTATE_UINT8(col, ssd1306_state),
+        VMSTATE_UINT8(col_start, ssd1306_state),
+        VMSTATE_UINT8(col_end, ssd1306_state),
+        VMSTATE_UINT8(page, ssd1306_state),
+        VMSTATE_UINT8(page_start, ssd1306_state),
+        VMSTATE_UINT8(page_end, ssd1306_state),
+        VMSTATE_BOOL(flash, ssd1306_state),
+        VMSTATE_BOOL(enabled, ssd1306_state),
+        VMSTATE_BOOL(inverse, ssd1306_state),
+        VMSTATE_BOOL(redraw, ssd1306_state),
+        VMSTATE_UINT32(mode, ssd1306_state),
+        VMSTATE_UINT8(cmd, ssd1306_state),
+        VMSTATE_UINT8(cmd_byte_num, ssd1306_state),
+        VMSTATE_BUFFER(mono_framebuffer, ssd1306_state),
+        VMSTATE_BUFFER(color_framebuffer, ssd1306_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const GraphicHwOps ssd1306_ops =3D {
+    .invalidate  =3D ssd1306_invalidate_display,
+    .gfx_update  =3D ssd1306_update_display,
+};
+
+static void ssd1306_realize(DeviceState *dev, Error **errp)
+{
+    ssd1306_state *s =3D SSD1306(dev);
+
+    s->addr_mode =3D ssd1306_ADDR_MODE_PAGE;
+    s->col_start =3D 0;
+    s->col_start =3D 127;
+    s->page_start =3D 0;
+    s->page_end =3D 7;
+    memset(s->mono_framebuffer, 0, sizeof(s->mono_framebuffer));
+    s->con =3D graphic_console_init(dev, 0, &ssd1306_ops, s);
+    qemu_console_resize(s->con, s->width * s->scaling_factor,
+                        s->height * s->scaling_factor);
+}
+
+static Property ssd1306_properties[] =3D {
+    DEFINE_PROP_UINT8("width", ssd1306_state, width, 128),
+    DEFINE_PROP_UINT8("height", ssd1306_state, height, 32),
+    DEFINE_PROP_UINT8("scaling", ssd1306_state, scaling_factor, 4),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ssd1306_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+
+    dc->realize =3D ssd1306_realize;
+    k->event =3D ssd1306_event;
+    k->recv =3D ssd1306_recv;
+    k->send =3D ssd1306_send;
+    dc->vmsd =3D &vmstate_ssd1306;
+    device_class_set_props(dc, ssd1306_properties);
+}
+
+static const TypeInfo ssd1306_info =3D {
+    .name          =3D TYPE_SSD1306,
+    .parent        =3D TYPE_I2C_SLAVE,
+    .instance_size =3D sizeof(ssd1306_state),
+    .class_init    =3D ssd1306_class_init,
+};
+
+static void ssd1306_register_types(void)
+{
+    type_register_static(&ssd1306_info);
+}
+
+type_init(ssd1306_register_types)
--
2.34.1





________________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Thursday, May 2, 2024 9:03 AM
To: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/display: Add SSD1306 dot matrix display controller =
support

**EXTERNAL EMAIL**

On Tue, 30 Apr 2024 at 21:01, Ryan Mamone
<ryan.mamone@cambridgeconsultants.com> wrote:
>
> From 617b2d92085d03524dcf5c223568a4856cdff47f Mon Sep 17 00:00:00 2001
>
> From: Ryan Mamone <ryan.mamone@cambridgeconsultants.com>
>
> Date: Tue, 30 Apr 2024 13:20:50 -0400
>
> Subject: [PATCH] hw/display: Add SSD1306 dot matrix display controller su=
pport

Hi; thanks for this patch. It looks like unfortunately your
mail client has mangled it somewhat (among other things, it's
got sent in multipart/mixed with HTML, and for some reason when
I reply to it there are blank lines between every line). You
might want to look into sending it with a mail client that can
send plain text emails for the next version. (git send-email
is what I use.)

Anyway, some initial review comments (and some more interspersed
with the code below):

What's the purpose of this device model? Is it intended to be
used with a particular board model? What's an example of
a command line and/or guest setup demonstrating its use?

This is the kind of thing that's useful to provide in the
commit message, since it gives readers a rationale for why
this device is being added.

(Our existing ssd0303 and ssd0323 device models are both used
by boards we have models for: the stellaris boards.)


> +++ b/hw/display/ssd1306.c
>
> @@ -0,0 +1,612 @@
>
> +/*
>
> + * SSD1306 Dot Matrix Display Controller.
>
> + *
>
> + * The SSD1306 controller can support a variety of different displays up=
 to
>
> + * 128 x 64. The dimensions of the emulated display can be configured by=
 the
>
> + * 'width' and 'height' properties and has been tested using the most co=
mmon
>
> + * displays dimensions of 128x64 and 128x32. A 'scaling' property has al=
so
>
> + * been provided to perform integer pixel scaling of the output image to=
 make
>
> + * it more viewable on pc displays. While the SSD1306 controller support=
s
>
> + * multiple physical interfaces this implementation only supports the I2=
C
>
> + * interface. Most of the commands relating to physical control, scrolli=
ng,
>
> + * multiplexing, and scanning direction are ignored.
>
> + *
>
> + * Copyright (C) 2024 Cambridge Consultants.
>
> + * Written by Ryan Mamone
>
> + *
>
> + * This code is licensed under the GPL.

This is ambiguous -- please can you specify the exact version
of the GPL you're licensing the code under, eg "GPLv2 or later"?

>
> + */


Is there a publicly available datasheet for the device?
The top of the file is a good place for a comment giving the
title of the datasheet and (if possible) a URL where it can
be obtained.

> +
>
> +#include "qemu/osdep.h"
>
> +#include "qemu/error-report.h"
>
> +#include "hw/i2c/i2c.h"
>
> +#include "hw/qdev-properties.h"
>
> +#include "migration/vmstate.h"
>
> +#include "qemu/module.h"
>
> +#include "ui/console.h"
>
> +#include "qom/object.h"
>
> +
>
> +/*#define DEBUG_SSD1306 1*/
>
> +
>
> +#ifdef DEBUG_SSD1306
>
> +#define DPRINTF(fmt, ...) \
>
> +do { error_printf("ssd1306: " fmt , ## __VA_ARGS__); } while (0)
>
> +#define BADF(fmt, ...) \
>
> +do { error_printf("ssd1306: error: " fmt , ## __VA_ARGS__); } while (0)
>
> +#else
>
> +#define DPRINTF(fmt, ...) do {} while (0)
>
> +#define BADF(fmt, ...) \
>
> +do { error_printf("ssd1306: error: " fmt , ## __VA_ARGS__); } while (0)
>
> +#endif

Please don't use DPRINTF debug printing in new code: prefer
tracepoints for debug type messages and qemu_log_mask() for
guest errors and not-yet-implemented messages.

>
> +
>
> +
>
> +/* Max supported display dimensions of the SSD1306 controller */
>
> +#define MAX_WIDTH 128
>
> +#define MAX_HEIGHT 64
>
> +/* Max supported color depth 32bit */
>
> +#define MAX_BPP 32
>
> +
>
> +enum ssd1306_addr_mode {
>
> +    ssd1306_ADDR_MODE_HORIZ =3D 0,
>
> +    ssd1306_ADDR_MODE_VERT =3D 1,
>
> +    ssd1306_ADDR_MODE_PAGE =3D 2,
>
> +    ssd1306_ADDR_MODE_INVALID
>
> +};
>
> +
>
> +enum ssd1306_mode {
>
> +    ssd1306_IDLE,
>
> +    ssd1306_DATA,
>
> +    ssd1306_CMD,
>
> +    ssd1306_CMD_DATA
>
> +};
>
> +
>
> +#define TYPE_SSD1306 "ssd1306"
>
> +OBJECT_DECLARE_SIMPLE_TYPE(ssd1306_state, SSD1306)
>
> +
>
> +struct ssd1306_state {
>
> +    I2CSlave parent_obj;
>
> +
>
> +    QemuConsole *con;
>
> +    /* Emulated display dimensions */
>
> +    uint8_t width;
>
> +    uint8_t height;
>
> +    /* Integer scaling factor to enlarge pixels for better viewing on PC=
 displays */
>
> +    uint8_t scaling_factor;

I don't think we should do this. AFAIK no other display device
does this; if we wanted to do it we'd probably be better off
doing it generically at the UI level.

>
> +    uint8_t addr_mode;
>
> +    uint8_t col;
>
> +    uint8_t col_start;
>
> +    uint8_t col_end;
>
> +    uint8_t page;
>
> +    uint8_t page_start;
>
> +    uint8_t page_end;
>
> +    int mirror;
>
> +    int flash;
>
> +    int enabled;
>
> +    int inverse;
>
> +    int redraw;

These seem to be used as booleans, so prefer "bool".

>
> +    enum ssd1306_mode mode;
>
> +    uint8_t cmd; /* Command ID byte */
>
> +    uint8_t cmd_byte_num; /* Command data parameter number */
>
> +    uint8_t mono_framebuffer[MAX_WIDTH * MAX_HEIGHT];
>
> +    uint8_t color_framebuffer[MAX_WIDTH * MAX_HEIGHT * (MAX_BPP / 8)];

The usage of these two arrays seems rather awkward:

 * data from the device is monochrome, 1 bit per pixel, but it
   comes in as a byte that has the pixels for a vertical run of
   8 pixels rather than the usual horizontal
 * we expand this out into mono_framebuffer at 1 byte per pixel
   in ssd1306_send()
 * then we expand it again from that into color_framebuffer
   in ssd1306_mono_to_color_fb()
 * then we copy that across into the destination surface
   in ssd1306_scale_fb(), possibly scaling it up

I think we'd be better with only one framebuffer data array,
not two, and going straight from that to the destination surface.
(Given the stuff in the datasheet about scrolling and dispaly
offsets and so on, it's tempting to suggest that we should store
the data in the same format the GDDRAM keeps it in, and do the
byte-to-column-of-pixels conversion as we write into the destination
surface. But I haven't thought through that idea completely.)

> +};
>
> +
>
> +/* Handler for I2C data transferred from SSD1306 controller */
>
> +static uint8_t ssd1306_recv(I2CSlave *i2c)
>
> +{
>
> +    BADF("Reads not implemented\n");
>
> +    return 0xff;
>
> +}
>
> +
>
> +/* Handler for I2C data transferred to SSD1306 controller */
>
> +static int ssd1306_send(I2CSlave *i2c, uint8_t data)
>
> +{
>
> +    ssd1306_state *s =3D SSD1306(i2c);
>
> +
>
> +    switch (s->mode) {
>
> +    case ssd1306_IDLE:
>
> +        s->mode =3D ((data & 0x40) =3D=3D 0x40) ? ssd1306_DATA : ssd1306=
_CMD;
>
> +        break;
>
> +    case ssd1306_DATA:
>
> +        /*
>
> +         * Map incoming data to pixels at correct location in framebuffe=
r.
>
> +         * Notably every 8 pixels are mapped vertically along the page
>
> +         * (ref Figure 10-2 in the datasheet).
>
> +         */
>
> +        for (int i =3D 0; i < 8; i++) {
>
> +            /* Simulating a monochrome display so just set/clear all bit=
s */
>
> +            s->mono_framebuffer[(((s->page * 8) + i) * s->width) + s->co=
l] =3D
>
> +                ((data >> i) & 0x01) ? 0xff : 0x00;
>
> +        }
>
> +
>
> +        /* GDDRAM pointers update differently dependent on the addressin=
g mode */
>
> +        switch (s->addr_mode) {
>
> +        case ssd1306_ADDR_MODE_HORIZ: /* Horizontal Addressing Mode */
>
> +            s->col++;
>
> +            if (s->col > s->col_end) {
>
> +                s->col =3D s->col_start;
>
> +                s->page++;
>
> +                if (s->page > s->page_end) {
>
> +                    s->page =3D s->page_start;
>
> +                }
>
> +            }
>
> +            break;
>
> +        case ssd1306_ADDR_MODE_VERT: /* Vertical Addressing Mode (UNTEST=
ED) */
>
> +            s->page++;
>
> +            if (s->page > s->page_end) {
>
> +                s->page =3D s->page_start;
>
> +                s->col++;
>
> +                if (s->col > s->col_end) {
>
> +                    s->col =3D s->col_start;
>
> +                }
>
> +            }
>
> +            break;
>
> +        case ssd1306_ADDR_MODE_PAGE: /* Page Addressing Mode (UNTESTED) =
*/
>
> +            if (s->col < s->col_end) {
>
> +                s->col++;
>
> +            }
>
> +            break;
>
> +        default:
>
> +            break;
>
> +        }
>
> +        s->redraw =3D 1;
>
> +        break;
>
> +    case ssd1306_CMD:
>
> +            s->cmd =3D data;
>
> +            s->cmd_byte_num =3D 0;
>
> +            /*
>
> +             * Fallthrough so same code can handle commands with/without
>
> +             * additional data bytes.
>
> +             */
>
> +            __attribute__ ((fallthrough));
>
> +    case ssd1306_CMD_DATA:
>
> +        switch (s->cmd) {
>
> +        /*
>
> +         * Fundamental Commands
>
> +         */
>
> +        /* Set Contrast Control */

A lot of these commands look similar to those used in
sd0303 and sd0323. Is it worth trying to share
implementation between these device models, or do they
have too many divergences for it to be worthwhile ?


> +        case 0x81:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else {
>
> +                data =3D data;
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Entire display off (Use GDDRAM) */
>
> +        case 0xA4:
>
> +            s->flash =3D 0;
>
> +            s->redraw =3D 1;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Entire display on (Ignore GDDRAM) */
>
> +        case 0xA5:
>
> +            s->flash =3D 1;
>
> +            s->redraw =3D 1;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Inverse off */
>
> +        case 0xA6:
>
> +            s->inverse =3D 0;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Inverse on */
>
> +        case 0xA7:
>
> +            s->inverse =3D 1;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Display off */
>
> +        case 0xAE:
>
> +            s->enabled =3D 0;
>
> +            s->redraw =3D 1;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Display on */
>
> +        case 0xAF:
>
> +            s->enabled =3D 1;
>
> +            s->redraw =3D 1;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +
>
> +        /*
>
> +         * Scrolling Commands
>
> +         */
>
> +        /* Continuous Horizontal Scroll Setup (6 data bytes) */
>
> +        case 0x26 ... 0x27:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                DPRINTF("Continuous Horizontal Scroll Setup not implemen=
ted\n");
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 6) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Continuous Vertical and Horizontal Scroll Setup (5 data bytes=
) */
>
> +        case 0x29 ... 0x2A:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                DPRINTF("Continuous Vertical and Horizontal Scroll Setup=
 not "
>
> +                        "implemented\n");
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 5) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Deactivate Scroll */
>
> +        case 0x2E:
>
> +            DPRINTF("Deactivate Scroll not implemented\n");
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Activate Scroll */
>
> +        case 0x2F:
>
> +            DPRINTF("Activate Scroll not implemented\n");
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Set Vertical Scroll (2 data bytes) */
>
> +        case 0xA3:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                DPRINTF("Set Vertical Scroll not implemented\n");
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 2) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +
>
> +        /*
>
> +         * Address Setting Commands
>
> +         */
>
> +        /* Set Lower Column Start Address for Page Addressing Mode */
>
> +        case 0x00 ... 0x0F:
>
> +            s->col =3D (s->col & 0xf0) | (data & 0xf);
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Set Higher Column Start Address for Page Addressing Mode */
>
> +        case 0x10 ... 0x1F:
>
> +            s->col =3D (s->col & 0x0f) | (data & 0xf);
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Set Memory Addressing Mode (1 data byte) */
>
> +        case 0x20:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->addr_mode =3D data & 0x3;
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Column Address (2 data bytes) */
>
> +        case 0x21:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->col_start =3D data & 0x7F;
>
> +                s->col =3D s->col_start;
>
> +            } else if (s->cmd_byte_num =3D=3D 2) {
>
> +                s->col_end =3D data & 0x7F;
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Page Address (2 data bytes) */
>
> +        case 0x22:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->page_start =3D data & 0x07;
>
> +                s->page =3D s->page_start;
>
> +            } else if (s->cmd_byte_num =3D=3D 2) {
>
> +                s->page_end =3D data & 0x07;
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Page Start Address for Page Addressing Mode */
>
> +        case 0xB0 ... 0xB7:
>
> +            s->page =3D data & 0x07;
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +
>
> +        /*
>
> +         * Hardware Configuration Commands
>
> +         */
>
> +        /* Set Display Start Line */
>
> +        case 0x40 ... 0x7F:
>
> +            if (s->cmd !=3D 0x40) {
>
> +                DPRINTF("Set Display Start Line (cmd 0x%02x) not impleme=
nted\n", s->cmd);
>
> +            }
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Set Segment Re-map */
>
> +        case 0xA0 ... 0xA1:
>
> +            if (s->cmd =3D=3D 0xA1) {
>
> +                DPRINTF("Set Segment Re-map (cmd 0x%02x) not implemented=
\n", s->cmd);
>
> +            }
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Set Multiplex Ratio (1 data byte) */
>
> +        case 0xA8:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                if (data !=3D s->height - 1) {
>
> +                    DPRINTF("Set Multiplex Ratio (0x%02x) not implemente=
d\n", data);
>
> +                }
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set COM Output Scan Direction */
>
> +        case 0xC0 ... 0xC8:
>
> +            if (s->cmd =3D=3D 0xC8) {
>
> +                DPRINTF("Set COM Output Scan Dir (cmd 0x%02x) not implem=
ented\n", s->cmd);
>
> +            }
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        /* Set Display Offset (1 data byte) */
>
> +        case 0xD3:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                if (data !=3D 0x00) {
>
> +                    DPRINTF("Set Display Offset (0x%02x) not implemented=
\n", data);
>
> +                }
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set COM Pins Hardware Configuration (1 data byte) */
>
> +        case 0xDA:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                if (data !=3D 0x12) {
>
> +                    DPRINTF("Set COM Pins Hardware (0x%02x) not implemen=
ted\n", data);
>
> +                }
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +
>
> +        /*
>
> +         * Timing and Driving Scheme Setting Commands
>
> +         */
>
> +        /* Set Display Clock Divide Ratio/Oscillator Freq. (1 data byte)=
 */
>
> +        case 0xD5:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Pre-charge Period (1 data byte) */
>
> +        case 0xD9:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Set Vcomh Deselect Level (1 data byte) */
>
> +        case 0xDB:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* Charge Pump Setting (1 data byte) */
>
> +        case 0x8D:
>
> +            if (s->cmd_byte_num =3D=3D 0) {
>
> +                s->mode =3D ssd1306_CMD_DATA;
>
> +            } else if (s->cmd_byte_num =3D=3D 1) {
>
> +                s->mode =3D ssd1306_CMD;
>
> +            }
>
> +            break;
>
> +        /* NOP */
>
> +        case 0xE3:
>
> +            s->mode =3D ssd1306_CMD;
>
> +            break;
>
> +        default:
>
> +            BADF("Unknown command: 0x%x\n", data);
>
> +        }
>
> +        s->cmd_byte_num++;
>
> +        break;
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +/* Handles I2C bus framing events */
>
> +static int ssd1306_event(I2CSlave *i2c, enum i2c_event event)
>
> +{
>
> +    ssd1306_state *s =3D SSD1306(i2c);
>
> +
>
> +    switch (event) {
>
> +    case I2C_FINISH:
>
> +        s->mode =3D ssd1306_IDLE;
>
> +        break;
>
> +    case I2C_START_RECV:
>
> +    case I2C_START_SEND:
>
> +    case I2C_NACK:
>
> +        /* Nothing to do.  */
>
> +        break;
>
> +    default:
>
> +        return -1;
>
> +    }
>
> +
>
> +    return 0;
>
> +}
>
> +
>
> +/*
>
> + * Helper function to convert monochrome framebuffer to color framebuffe=
r
>
> + * by padding out values to match dest color depth.
>
> + * 'src' framebuffer is expected to be 1 byte per pixel
>
> + */
>
> +static void ssd1306_mono_to_color_fb(uint8_t *src, uint32_t size,
>
> +                            uint8_t *dst, uint8_t bits_per_pixel)
>
> +{
>
> +    unsigned int idx =3D 0;
>
> +    for (int i =3D 0; i < size; i++) {
>
> +        for (int pad =3D 0; pad < (bits_per_pixel / 8); pad++) {
>
> +            dst[idx++] =3D src[i];
>
> +        }
>
> +    }
>
> +}
>
> +
>
> +/* Helper function to perform per pixel integer scaling */
>
> +static void ssd1306_scale_fb(uint8_t *src, uint32_t src_width, uint32_t =
src_height,
>
> +                          uint8_t src_bits_per_pixel, uint8_t *dst, uint=
8_t scale_factor)
>
> +{
>
> +    uint8_t bytes_per_pixel =3D src_bits_per_pixel / 8;
>
> +    unsigned int idx =3D 0;
>
> +
>
> +    /* Scaling of 1 is just a direct copy */
>
> +    if (scale_factor =3D=3D 1) {
>
> +        memcpy(dst, src, src_width * src_height * bytes_per_pixel);
>
> +    } else {
>
> +        /*
>
> +         * Copies each pixel (size=3Dsrc_bits_per_pixel) scale_factor ti=
mes and
>
> +         * duplicate each of those lines scale_factor times.
>
> +         */
>
> +        for (int h =3D 0; h < src_height; h++) {
>
> +            for (int hs =3D 0; hs < scale_factor; hs++) {
>
> +                for (int w =3D 0; w < src_width; w++) {
>
> +                    for (int ws =3D 0; ws < scale_factor; ws++) {
>
> +                        memcpy(&dst[idx],
>
> +                               &src[h * src_width * bytes_per_pixel +
>
> +                                    w * bytes_per_pixel],
>
> +                               bytes_per_pixel);
>
> +                        idx +=3D bytes_per_pixel;
>
> +                    }
>
> +                }
>
> +            }
>
> +        }
>
> +    }
>
> +}
>
> +
>
> +/* Render the virtual framebuffer to the surface which will be displayed=
 */
>
> +static void ssd1306_update_display(void *opaque)
>
> +{
>
> +    ssd1306_state *s =3D (ssd1306_state *)opaque;
>
> +    DisplaySurface *surface =3D qemu_console_surface(s->con);
>
> +
>
> +    if (!s->redraw) {
>
> +        return;
>
> +    }
>
> +
>
> +    int bpp =3D surface_bits_per_pixel(surface);

In modern QEMU surface_bits_per_pixel() will always be 32
for the output display surface, so you don't need to try to
handle anything else. You can clean up/remove/simplify
any code that's handling arbitrary bpp values here.


>
> +    /* This device only handles displays with whole byte color depths */
>
> +    if (bpp && bpp % 8 !=3D 0) {
>
> +        DPRINTF("Invalid color depth (bpp=3D%d). "
>
> +                "Only whole byte color depths supported.\n", bpp);
>
> +        return;
>
> +    } else {
>
> +        uint8_t *dest_surface =3D surface_data(surface);
>
> +
>
> +        if (s->flash) {
>
> +            /* Turn on all pixels */
>
> +            memset(dest_surface, 0xff,
>
> +                   (s->width * s->scaling_factor) *
>
> +                   (s->height * s->scaling_factor) *
>
> +                   (bpp / 8));
>
> +        } else if (!s->enabled) {
>
> +            /* Clear the output */
>
> +            memset(dest_surface, 0x00,
>
> +                   (s->width * s->scaling_factor) *
>
> +                   (s->height * s->scaling_factor) *
>
> +                   (bpp / 8));
>
> +        } else {
>
> +            /*
>
> +             * The following operations could have been done in a single=
 pass
>
> +             * but that would likely have resulted in even more unreadab=
le code.
>
> +             */
>
> +            ssd1306_mono_to_color_fb(s->mono_framebuffer, s->width * s->=
height,
>
> +                                     s->color_framebuffer, bpp);
>
> +            ssd1306_scale_fb(s->color_framebuffer, s->width, s->height, =
bpp,
>
> +                             dest_surface, s->scaling_factor);
>
> +        }
>
> +        s->redraw =3D 0;
>
> +        dpy_gfx_update(s->con, 0, 0, s->width * s->scaling_factor,
>
> +                       s->height * s->scaling_factor);
>
> +    }
>
> +}
>
> +
>
> +static void ssd1306_invalidate_display(void *opaque)
>
> +{
>
> +    ssd1306_state *s =3D (ssd1306_state *)opaque;
>
> +    s->redraw =3D 1;
>
> +}
>
> +
>
> +static const VMStateDescription vmstate_ssd1306 =3D {
>
> +    .name =3D "ssd1306_oled",
>
> +    .version_id =3D 1,
>
> +    .minimum_version_id =3D 1,
>
> +    .fields =3D (const VMStateField[]) {
>
> +        VMSTATE_UINT8(addr_mode, ssd1306_state),
>
> +        VMSTATE_UINT8(col, ssd1306_state),
>
> +        VMSTATE_UINT8(col_start, ssd1306_state),
>
> +        VMSTATE_UINT8(col_end, ssd1306_state),
>
> +        VMSTATE_UINT8(page, ssd1306_state),
>
> +        VMSTATE_UINT8(page_start, ssd1306_state),
>
> +        VMSTATE_UINT8(page_end, ssd1306_state),
>
> +        VMSTATE_INT32(mirror, ssd1306_state),
>
> +        VMSTATE_INT32(flash, ssd1306_state),
>
> +        VMSTATE_INT32(enabled, ssd1306_state),
>
> +        VMSTATE_INT32(inverse, ssd1306_state),
>
> +        VMSTATE_INT32(redraw, ssd1306_state),
>
> +        VMSTATE_UINT32(mode, ssd1306_state),
>
> +        VMSTATE_UINT8(cmd, ssd1306_state),
>
> +        VMSTATE_UINT8(cmd_byte_num, ssd1306_state),
>
> +        VMSTATE_BUFFER(mono_framebuffer, ssd1306_state),
>
> +        VMSTATE_BUFFER(color_framebuffer, ssd1306_state),
>
> +        VMSTATE_I2C_SLAVE(parent_obj, ssd1306_state),

Usually we put the parent_obj at the top of the vmstate array,
not the bottom.

>
> +        VMSTATE_END_OF_LIST()
>
> +    }
>
> +};
>
> +
>
> +static const GraphicHwOps ssd1306_ops =3D {
>
> +    .invalidate  =3D ssd1306_invalidate_display,
>
> +    .gfx_update  =3D ssd1306_update_display,
>
> +};
>
> +
>
> +static void ssd1306_realize(DeviceState *dev, Error **errp)
>
> +{
>
> +    ssd1306_state *s =3D SSD1306(dev);
>
> +
>
> +    s->addr_mode =3D ssd1306_ADDR_MODE_PAGE;
>
> +    s->col_start =3D 0;
>
> +    s->col_start =3D 127;
>
> +    s->page_start =3D 0;
>
> +    s->page_end =3D 7;
>
> +    memset(s->mono_framebuffer, 0, sizeof(s->mono_framebuffer));

At least some of this should be done in reset, not realize.

>
> +    s->con =3D graphic_console_init(dev, 0, &ssd1306_ops, s);
>
> +    qemu_console_resize(s->con, s->width * s->scaling_factor,
>
> +                        s->height * s->scaling_factor);
>
> +}
>
> +
>
> +static Property ssd1306_properties[] =3D {
>
> +    DEFINE_PROP_UINT8("width", ssd1306_state, width, 128),
>
> +    DEFINE_PROP_UINT8("height", ssd1306_state, height, 32),

Are these really variable in real hardware?

>
> +    DEFINE_PROP_UINT8("scaling", ssd1306_state, scaling_factor, 4),
>
> +    DEFINE_PROP_END_OF_LIST(),
>
> +};
>
> +
>
> +static void ssd1306_class_init(ObjectClass *klass, void *data)
>
> +{
>
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>
> +
>
> +    dc->realize =3D ssd1306_realize;
>
> +    k->event =3D ssd1306_event;
>
> +    k->recv =3D ssd1306_recv;
>
> +    k->send =3D ssd1306_send;
>
> +    dc->vmsd =3D &vmstate_ssd1306;
>
> +    device_class_set_props(dc, ssd1306_properties);

I think this is missing device reset handling.

>
> +}

thanks
-- PMM
This email, including attachments, contains confidential information belong=
ing to Cambridge Consultants. It is intended for the addressee only and may=
 only be copied or disclosed to others with permission. If you are not the =
intended recipient please delete the material from any computer. Emails are=
 subject to monitoring for legal and security purposes. If this email has b=
een sent as a personal message the company accepts no liability for the con=
tent.

