Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F791606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=a2LLl7SO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPAeB-0005oJ-Qb; Thu, 05 Nov 2026 22:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xPAe9-0005nv-1O; Thu, 05 Nov 2026 22:29:45 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xPAe5-0001cE-4Q; Thu, 05 Nov 2026 22:29:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+swJkAI4g9oFVIKF0u2bex4mRk5WKt9u2teZGIEmJG9sazBYlev46u2qdbTrf3opi+RI/zslKVjvurOrmFNwyLskKCsQ94KTkaXg82gJpSxnCLHliVPTvFeko+xSOARNK+0lUT6qKd0VcPD2rBCGjtXxF0SLC2jNSFtd36+u3zwj8Vvw1oIb3S8yjXIh4aDwjtjZwaMAtMBNn73bZ44Smsv/pzY8oAMl/SEWWRhanHSdwJJrGjmRP0mWTTYNcdaaj2i79G3t1b9XcP+zmfcdPZelnuGww2IcW3oTxivG/sylx6EL4v+YwC+1ZiHbmYUWk1TcatgbjuZpjpzRkFfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXmZP/o22YPY7Nw2kfylYO7CV8zovobJxt4LFUh8yAw=;
 b=TVHKPPG/Zl5WBvSREpa8ZzgVyw+BMvxUab8i4P3qb9PvbALXdIXng65BYr0tVU0CWsKVE92pXquatCkKsRbmbJmwgW+oCyOShYYzGzeQXPzWWyVr9f3zb9OMm0vlumWSKet2VwB/yuHtyLJNP2a0Rx+Kh5f4EFbjOv4jK8IkFWawbf48/JDVY+T8GkwTMrE9QL5ol0TMPPETY8iIW4hoDSZi89RF9XgjKbdUlO0X46Wd9bpxJvAkQY+gjEAyBwPwEF+PB5ZaIQkSrBXkQFAMiTL5CBY/SbzZf2x6NEBTSYoay89yZQGi3cESbisB79i9KAqnTfMsQQjKWosZsD3XIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXmZP/o22YPY7Nw2kfylYO7CV8zovobJxt4LFUh8yAw=;
 b=a2LLl7SOctTz90SW7kN4IUPkbD2KT7vqQrryeJtwJzqXu7qJYCWGZrwjjaZxrheTCj2R0RLHm7Qei5Q/K760vRAOvS7whpLtPHcszhrmdhUt0mT/Epu70G9RhwCKidorZN+KitvLvYnEE9Nj83nn225W7htFsIvWLQ9qHj6Mw4dy4bbMDVeVVN5nuz2ICqCVPTXd2uvkB3qAkN7/3PHETPkPBTcHTD/zbu6J8iez1zlwV8kHwvQeVatlZBhnRKIbgb4vV6SgNgGj40Htlstl8Jis25IwAmQTFMvbMSc88lK4ESMQocWtFY1YXixmvnp2k2xt7KOMjE6BXV+kR8bXbg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5073.apcprd06.prod.outlook.com (2603:1096:400:1c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 03:29:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 03:29:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "clg@kaod.org" <clg@kaod.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "kfting@nuvoton.com" <kfting@nuvoton.com>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "deller@gmx.de" <deller@gmx.de>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony@xenproject.org"
 <anthony@xenproject.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>
Subject: RE: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Thread-Topic: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaqugzonZbCOsyEq5GblPuZWDarccaGeAgAP/C2A=
Date: Fri, 6 Nov 2026 03:29:28 +0000
Message-ID: <SEZPR06MB73626D50E685F83DFB006D8DFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
 <20261103142327.1348025-1-junjie.cao@linux.dev>
In-Reply-To: <20261103142327.1348025-1-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5073:EE_
x-ms-office365-filtering-correlation-id: adc2b7a6-6df8-4910-ed68-08df3bb62a50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|261022075727099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 45qwcQA67U0vfxjjUKdXractJDBts2WaA41Dw9+d1JtW5DHEL7sdUd3CmwJej7PomFm6/UEf/M8WVXnlq7mL0zdF8IegiCc03oY3UIlwKtRAaYSiMsb6oXBGND+maGs/eQYbSr+ulcXTzY7KggeU2rG5VSDiuACwDqECq3Zu3yvV9ZXkcSt6M6KtleQCREVYW6/CbSG/cMmMMmcWPCjUlfCDXZqVpzMO8CaVQl4qNyBoTGDEOJ1d4HGaTUaqa2SLgOfwZQqA13+bLgdEa92YNQDgtR6ymKuEwZNvv7GpeEr5BaQSTFvaKlPqoLtTQ3LqxJ3YCFi7yAqa7QM1f3PrgEFcZ0GaIdPg5Nw+zwRWtGKjthZNQQI9eMhBjRNq+AAlBz/rd3gZyeDzTxlF1pOrt8SHMy9fMkt2uwNZPV/7hsY7fUqEgSVLqgAD6+zga+2WtfaEV5YYrO9t/VgwbZMv92hNcZoTYoFwxJOsL+DMUaUKKHds87zyq/a+obCFjvckeWxQOMWlxMvQaQX7g+DjpX7xJVNh3WAxX6tDt2FXZutKzszBSQe/P++o5OOhtOAsBvqxFGQf1FLgzcWQcoggtkCpEtfHnnx6tmWNDlC0VilMC1zYikBj8mokfp7raeZnpg5zoGhCS6kxvmbRfzt8kFunKgOjkeFPFGdC3aESDbtLb1J5ekUbYX15CPkd06vAW5SC/a4TF4cHhD1q/de0lkm5abSxZ0qpe34AKfN1IbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(261022075727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jrlo2CTL1Mghgn6/fSOQtCXsPoNUuIJ/U5YhD2g3+WJIKW2nwKThxYGnkJ?=
 =?iso-8859-1?Q?Cb2reUGK6tfRgDr5NSKnfmsfaoEcDK5GtNe0iRwmttcBazzx7PM4y7kWem?=
 =?iso-8859-1?Q?HWTBcTu3I2kAWoYLhNWMyX6XVw9M/7/CHL/TkuUHL/gsIaf45rKI0U16Gg?=
 =?iso-8859-1?Q?J+gQcBj6UiMhB1qx/+i3LoPYj6v5LeNm+cW9kBc/Q6zQXR8rhQARR/P0JP?=
 =?iso-8859-1?Q?FnKN73ZQjBCFRSaiGpoI3Ebc98HWMPCfKt2++ZnOYi/lgJSCvvZ739qvuW?=
 =?iso-8859-1?Q?7P5ez+GnZbHae7uXi+aMwP5Uljke/sdnfx+sbo4+XcWf6Qnoor87iF4XNH?=
 =?iso-8859-1?Q?g+b8WUcv3obxrCStspfHex9qMngolSxO2oI1b2vbRIfEDoBgXnvtqyRxHr?=
 =?iso-8859-1?Q?MxmvNbu/Lhh/MsESBORaE9ftc3nAE0/gn6fBT8bm8WtE/4mQ5pxmPw21Yt?=
 =?iso-8859-1?Q?rswUww+CO9ZR5SxcoGejAkiAsciV/W7uFTJYasAAZKXu2gZKX8mVBP7lng?=
 =?iso-8859-1?Q?UfYNufcxLBru7kF1nQDYlipIremQBQT/krBNdKrrEmTKdbudQYfdxFjlIA?=
 =?iso-8859-1?Q?+IsqvXPwT60KbZJ4XZ5V2s+W+BwcHrVIa7P+Q/XyrBFDYwI/10HILIPn5p?=
 =?iso-8859-1?Q?SOWW3yhuleeNyH63BGgNytUg3ndat1GCb+UD9xCgFAgkvydR3UtqqDc5ji?=
 =?iso-8859-1?Q?yrmlOlDbGFZ+g1+otrZ5uyCQyqgpJ+KDB+j0rfDNdCHXqepCrpnSePuTep?=
 =?iso-8859-1?Q?oJw9MDam347MmyNlBSM1e3/viyK0oNv0U84T5efulqnOpAJs6yVWNmGLYs?=
 =?iso-8859-1?Q?nkVJgRREVi5Rz22TBjaCCsnqL5eJ0DqhGDq3fc0tVZJ6ml6NwP9sG0U9Tf?=
 =?iso-8859-1?Q?lISp10VnHipWlOo3sS8gY6v1zMdWBZ/etHiOIdlG0bdJCzdsoZFHSyxaUA?=
 =?iso-8859-1?Q?1I+8dhrcGhlQbtVOdiaT55J1PJYaqR5I7sXDLrw7OitVl07da3px2r2+oJ?=
 =?iso-8859-1?Q?yz/zceDbf0q+eRYAsZDN3wSwgkyQoETJHiOZcxRtxSKZw8Q1fpdiQhXEkT?=
 =?iso-8859-1?Q?8u8u1jS5yComq3gHURvMf1PcZbeq9BaUrk9EiMCY+1maD5pAofkffuSZQP?=
 =?iso-8859-1?Q?pTxFgQcxyJ/rhie38Q+X3dLSxWSD5zRLNWNT1Olj4md+zojj24P0caWkKG?=
 =?iso-8859-1?Q?xYbpKlwkmIYcR8sY/msBPp5zHIOilcpa65OZmxNhOUwGSoUs6PNzBgre0K?=
 =?iso-8859-1?Q?ftvNXLKZ/I3dy/yHL0rcuXLGmyVvWu7fg3LaCQ1mtPodudagP/gC2/W4vw?=
 =?iso-8859-1?Q?gQrPRNiN8sIwoCm7HsbqreQ3sMeG4NUb0ljgZcpHrxo9f3EtA1yNDeTR3S?=
 =?iso-8859-1?Q?rehgIO3//HbmaC0bUB9k06k/Qxre5Ns0e0MQHv8f7bX6xh7AB1XMS4tk6R?=
 =?iso-8859-1?Q?unA1ShmIbeHkQkx2ngAnLqw1FPelnApYUgs0RFnzhhr0yNzdyeyTYXuuu4?=
 =?iso-8859-1?Q?DI3+O4K8cLdEtyWHHGhXwwoiqybzLMmntGWDJ70lRQaygslUjlGnRGuWWU?=
 =?iso-8859-1?Q?mA7rGdxoI1iBfqTossR2rWPjW5xEHJXoAWIa7J+9mrcEqEgueBEd7EVb6e?=
 =?iso-8859-1?Q?hT7/KETvXx7zz2cip9C1SCiDcwOm2IYUcrZ/PrL8Cz9AXHwe/KSjGKt3nX?=
 =?iso-8859-1?Q?HB4MimVdQBEQBbqQlPxmeaLthEV6f50OYoLe/dcZKDvvabPheTLSwb9CDm?=
 =?iso-8859-1?Q?ZjExpLg74Gb9B2smmPH6TakwH8I2OOBgMSQa5p2fRR/g/fPwgqThjEwr3/?=
 =?iso-8859-1?Q?SeVl4dlWaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: My3snRlK/oAdBrai07ZIYa7i4s5Kvr3j9wpw6El7kjCiTs+jwRh7IT269GuowgNWKLLva5DzVeDBOfmd0Nx3HUIDu+myT7Gc0FP9oKCkbICTl20Z+8Qkxul+zEcZAabPz35sY1Cb8j+wIyfdK6rAh01Qpd0NlZdx6LK63VwyN6T8gB/ycO2141Oa2/sdll7I7/IvCMhb7oVN8oQeCa6WiAClpg36EG0gVtWDkSVE3Kno+c9m77f3viGpgMeZl8MdeOCjlIomliHNzyst5Mh5BEKjCER0gPdy0Zsnhd4wiAHTWPUNNM+2NwfTwWjRoYRXpykkPytoLOAnaSAN+oRSKw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc2b7a6-6df8-4910-ed68-08df3bb62a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 03:29:28.9642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol4Dne8WrX+OfeKl8iuCny14E3u85y/At/JROl+F7dky0LMXV6jc/KktVQ7cxW/s/Cns4M/POpfjhOmwHJnpiITNAfu8uaIBqkGMK7BPILM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property a=
nd
> leave it off
>=20
> Hi Jamin,
>=20
> On Mon, Nov 02, 2026 at 09:22:05AM +0000, Jamin Lin wrote:
> > Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older
> > machine type keeps the hub it has today and a guest saved by an older
> > QEMU still loads.
>=20
> Reran the migration check from v7: with pc-q35-11.1, a guest saved withou=
t
> the series loads on v8 with the hub in place, for qemu-xhci with four HID
> devices and for q35 -usb with six.
>=20
> But this missed the 11.2 soft freeze, so in 12.0 pc-q35-11.2 is an old ma=
chine
> type too, and hw_compat_11_1 (my suggestion on v7) doesn't cover it. Save=
d
> with pc-q35-11.2 on master, both cases fail on v8:
>=20
>   Unknown section or instance '0000:00:01.0/4/usb-hub' 0
>   Unknown section or instance '0000:00:1d.7/6/usb-hub' 0
>=20
> The entries from 02-05 want hw_compat_11_2 once the 12.0 machine types
> are in.
>=20
> Junjie

Hi Junjie, Marc-Andr=E9, and Gerd,

Due to the QEMU code freeze and the planned 11.2 release in December, disab=
ling automatic hub creation while keeping migration compatibility with olde=
r QEMU versions requires adding the property to hw_compat_11_2.
We need to wait until after the QEMU 11.2 release for the maintainers to ad=
d hw_compat_11_2 to each machine type.

The USB redirection server is my original upstream goal, and I think this t=
ask is independent of the automatic hub task.
So, I want to split the auto-hub changes into a separate prerequisite patch=
 series and send v9 after the QEMU 11.2 release.

The USB redirection server common protocol series still needs rework on the=
 device announcement and control transfer patches.=20
I will send v9 next week and mention that it requires the patch series that=
 disables automatic hub creation.

This way, we can continue testing and reviewing the USB redirection server =
common protocol this month.(November)

"If you agree, I will send v9 next week. Otherwise, I will wait until after=
 the QEMU 11.2 release and then resend the full patch series as v9."

Thanks,
Jamin

