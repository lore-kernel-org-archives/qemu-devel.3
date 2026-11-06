Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C5606A328
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=lDgdC1bD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPAuJ-0000io-16; Thu, 05 Nov 2026 22:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xPAu4-0000hb-6u; Thu, 05 Nov 2026 22:46:12 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xPAu1-0003Ip-U1; Thu, 05 Nov 2026 22:46:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elJObx+rzD690J0hmbgt1yIVYORwesXe/y6vVVERUdJbzi01hn67iR5KCLfQ91KwIaUk2D3mG/V1yYOuBxXhC7lBuUk3HI4YvAqJ1Y+Mu4fKKjL4gQqRmK5Fwj8uEP009rpMUCistuaesY4Nmcqp5XFHUjQZJsp96qLuWQZ1jngvOPmLWsaRe4+PHa3kPTQLZlUOY3xAFmD4M4IYSquyFHfcOvmxIK/Oy014GN6mVkVx8CX+Oy0wPthQ9wR7AYdlK7vCVwM6yy8OFomwL0qP7GklKJ8/wXsSlwUoI0sx7eHj2Xn1qfztfATimLRUrRqehcPPhOKqFxWYwhL6MXRE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ3ESIv8pnvoGT3giU0WmiQtXz1sadcN+wcIvZYxuTc=;
 b=cRhWJdLjpJZYgmhzwMvP5v/jKu7t/J3mvLI9lEM1Oz+lMbUNsAzVEboOjs9ji3EeC/KU8mw1aIUD3g4A9eD47Ph1dMZB5f1OUgNWku3GJXy8esoHzde1s+ldBCE3tUqI5cSdghpddOuv4bTMHVaMWnRNk4D2A/T1oMuVzG4Cxi+gl49EXbAE5r7HC3yLu4awHTNa6dGhKLZmnigAQP35C9Tmk9b8wRExjNvOBLqqR/MPq6fFdKXURB7SiSkFasQA1dvOInvcWghsNCrEqCfLoaycO+VaLaWOAfoBoiorTrY22XFwmkg417lT+3dvG1DW2+w2YTtC6ErjQqA2b5vptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ3ESIv8pnvoGT3giU0WmiQtXz1sadcN+wcIvZYxuTc=;
 b=lDgdC1bDuev4sEER/Fal+TdQ588lipoghfSL6FIFatgq4Cs0Hi5Y4xGG5lNet3NIdjzH2vmVm3fFy8iC3RTrJQNxU5cwdE+VY6qTk92rNr0vd4bEBUO4ol1ojThns7AmHmmQJMYsXFWh6uiZMvJ8Rw5FXozfZa6L3mdzpweNjZqD24sFy4vXR3iCDdgqnjGz0Il2eRnvuRlxu3t9sd5LFrKYsWv/oWYMTeY7sveVzh5Ai0iMhtXRuBNVEvkBI2mBA/SzUmkqZAhp2aGiadatTDodnzUA0cMQDdGnrzkca89d1soeQwQrEKlnjrexxM/A9b1sLK+rtHWGFnR3ZlpM9g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5079.apcprd06.prod.outlook.com (2603:1096:400:1b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 03:45:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 03:45:58 +0000
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
Thread-Index: AQHdaqugzonZbCOsyEq5GblPuZWDarccaGeAgAP/C2CAAAURcA==
Date: Fri, 6 Nov 2026 03:45:58 +0000
Message-ID: <SEZPR06MB7362D089282550D7585C16DEFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
 <20261103142327.1348025-1-junjie.cao@linux.dev>
 <SEZPR06MB73626D50E685F83DFB006D8DFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB73626D50E685F83DFB006D8DFC762@SEZPR06MB7362.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5079:EE_
x-ms-office365-filtering-correlation-id: d7343fc9-47d1-48e3-2620-08df3bb8782b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|261022105027099003|261022075727099003|261026140227099003|38070700021|261026121527099003|261028144727099003|4143699003|10067099003|56012099006|22082099003|3023799007|18002099003;
x-microsoft-antispam-message-info: afMlWjAL6ctTeo1e5LXKH9nGmJCowkgopypaEy6bHCxARi/U1LeAacxyScfF+I5U5nMXaHqEGc2KWZuApNJYNDw4ghHdiEgIUVHFXzmSENXvzTKQe8UTLsaunAvDsOZbgaoPU/0w6RwAJHkaDKYee+oSX2/QRuDfECTdNCUkNipsSkYg5P4YTp7Kh2wTZCUI3pDzkofYgogRq45SC8hvXuA40XCsKBRIVEEuDvM35xjw65jyDdsd/Z8kiBTXOWYkHK/+99G1pzZS3LAWGiDdL6Op945b1qXZKfmIgYxvUSJpcpG30G1kKUHXPsozdUlTwfhnlyKvDOSt1FN7bpWuKuvWBhRqipEVHPlHknm5PRuq/sBAJ4klR83FoSj/eNnFdwG3UNR14P/kYQNLuarNBKOT643GjfJvRqsYvrMZQeC78n+g//oKS9pgFQT8BZKay+xF0WFGz+VZKR3mVlkwJos0iakmHefnNEtvqlQvOkf70jnG3OJZUved+xHtcwwKWatOezlebxzJmr1W8bmjSchSjonM4cfx9Uo8NV+Kp61DneLVX1mjVAif4IEqBqO/VmCIsyFLSBeeartX2cnWeNjIDIs7USs8PiX66IoS/Ewjqct9A3bTH0VXTizuA+zESCZJvjh8F0rYr5op2KOl7RQ7V6VgEVWtlYo8KIA/DKyjNJlxSWO+DWpsSMozfDAeXPiEIO9cjLaoZV4AeKttmTvhkvmioXhPw+E6B73a9mg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(261022105027099003)(261022075727099003)(261026140227099003)(38070700021)(261026121527099003)(261028144727099003)(4143699003)(10067099003)(56012099006)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6RkHOcsxhg32gsF2RjjkIfucsglZHJHcjLcBpWguUxjohDVW/aScTTyHB4?=
 =?iso-8859-1?Q?80JYhJKmf3frc4at1VTHZpM1O8/BHUZYfx0wxHEzOJJETAZX8LH0uPP8Rm?=
 =?iso-8859-1?Q?extBZCmcntrQ5pJOoYhVNB9/s29HfD31hhXxDWy/eVU15cIEfYysraSrt7?=
 =?iso-8859-1?Q?yeEufE1PnZgG77PyxNLBtGqOwZ/s7exSpo2NZUYIUHZRF5Ml0Vf5H5tggr?=
 =?iso-8859-1?Q?QsMKl62rKOi+Z6DHPdu7IvW0FZUlHdc3PCCp5Jg/8b2b2HYImWUSgB8B25?=
 =?iso-8859-1?Q?BI1n9YT8h0Ugfau6U6cufoFZWDzuORqj5KVFiajG1U4n8a3jcDWBbiTkBn?=
 =?iso-8859-1?Q?UHooZTl44BAtZhD4yd7qaHGC/zSV+iZlwsNeFE41InlqV+VhnFZjZFvzgD?=
 =?iso-8859-1?Q?+VXtnl7u7DV2dz6rSiXXhOjZapIIQoQrRBEReGbPZdzEZQF03lwGzONW5v?=
 =?iso-8859-1?Q?zh13MOPgmxp5CeCpHl217RpN1aDx4YwuGU/mdIPXmS1L9oVoZiDc3c7Ylw?=
 =?iso-8859-1?Q?59sJiD0nriU9sX4etpkxfdIMg1K19StHE3VRrwy4MDyKxIyYWclwIaOe1I?=
 =?iso-8859-1?Q?qgBWCtD4ONV4Pcj/vjjwMdHjqsvJC0WqvX27Lfp0cz3kniaQltNNGusis5?=
 =?iso-8859-1?Q?3Sq1Y4HveSOTS4EfOVF/zR5xsVB+H/CP/xCgp8JqTjxGeA1kl8a2eKKBGo?=
 =?iso-8859-1?Q?5ZVpL/8I/BaxT/d9ogmdPgP/0W3bT0jwcluJPhCtp/HzOtFcFpkfnw93ha?=
 =?iso-8859-1?Q?bHnqXozredxaC1TY6zrflBsfPDlVGRBM6Ti21B5kFehlRVqphk3PFGmPrR?=
 =?iso-8859-1?Q?HAk0s7ZSYzx2kjfW0yI6CYRtIa/yOqGIFJ9JteAzEsC9+la0FKKFx9qc09?=
 =?iso-8859-1?Q?q0bWlWMaO6DUe4Rdmc4mCpV7C7xu2Dpp+rsMjrcH4aM9wZxoYOuoH+PiO7?=
 =?iso-8859-1?Q?YM0oiqDDlpju3kstD6dYKBc5FM/doUCPuo0X547OXygbDPT7DlE9/FQ4Mf?=
 =?iso-8859-1?Q?v1jNy+QPIIKdbyqLjG0jdJxiAfU4wpbTdXLp1pJWR+r9EuOp58x/gMFrne?=
 =?iso-8859-1?Q?SbcAGOeieNKGLC1mrFnrcbUG3+144aAqR+LFbhUJzm9e6GTo6kbWIM2w30?=
 =?iso-8859-1?Q?3WXh0sArxUtqT16uDlTnhxe4drQBRtVlIwzJ2RVjcpLbvU9CKyD4ZXNDJV?=
 =?iso-8859-1?Q?h4kgkeZxmqJRNQfHxPudrSDdvTamyKr+0KSfXmaXx7sxHtTrIWwdBaC/IQ?=
 =?iso-8859-1?Q?cYDJRL5HzmlEEN1ZPI8kqApQe49ePtzBlEs7Ex32B/8DhqF8ICUUJmqnRZ?=
 =?iso-8859-1?Q?XLcqlqwV98jR80ofT7EY6Pr9XDQc/IN2wk41RY5zlMwudtfWkTz/CeaKSE?=
 =?iso-8859-1?Q?YCmC6s/Nk/7p8iLSDfVHzcApt9npIPYCzxjUqXAHPXPS3eElcgSgU/Ki08?=
 =?iso-8859-1?Q?jgRG6A5fjvEojG9UXgSsRmGBx0YuiYLj064WgI/Ssl8B5v9EGpMTwxNJSu?=
 =?iso-8859-1?Q?muGOzvUMAoyXCeCI7u5xDQr1BcxwL2DFDf8gNIVS7dtHWhNRpRLEao0/2b?=
 =?iso-8859-1?Q?ZTb8WzqzUOdIDTcaXebBUAFSRajLcYXzRs3HwyD6G34JhNN7rGA+3aCLKx?=
 =?iso-8859-1?Q?D4/dqO/KNznnaJevL0Mc3zPSBafXq51UoYyU/1FSXzVlwGV3SiA7z1J3IG?=
 =?iso-8859-1?Q?A/NdcsKAncAJ32F169NLuGSQQg73q23FAyE/E0eP+SHZdiOO+Sssk68VN0?=
 =?iso-8859-1?Q?7Q/QLLnMKx1MnROnQMKxGSteZWtcEmjysZ2wg7g4c1M7DGjTCqVBz461OU?=
 =?iso-8859-1?Q?JuBFrCePXQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z0A0jXgX0qaJ+3QfsLF2YgQBWjf02TeobscQadSV0TtW7Fthn1PO1IOpmbti8GZ3BgrZ/eMQF7BaUr17zgaCm+jQSj52VwD4RZewjp9Dck99K2N+BgOYiXjKav1hTe/o9LN8V2+OM1EegyBro8cLv9ZGCot1rYoOIxUkqrIPD+l+FpUkXEac++ygqSW4wtA/ul7r0tpRCXh0IQ4EHRPzHooGXGRq8b/maPB+00tS7sv5lRjkI+g8EbwCJpdVJPeZFVARnjSH+/OmvpnDVNJiT749WM+Pt3msfYqQhuEKNVQ7Rt5Owu6R2T09PAOr7a1lSkf/xmc6WMjTITQgthxl1w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7343fc9-47d1-48e3-2620-08df3bb8782b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 03:45:58.5520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xk8v7cb7mPyTTaobLKYemHvgksA5FIXWspzbAlZK+PlcQvS5VFuTvgomU6Y+4Xsfg4VVyxouark5CkS2fOoWdE6KRyT3gRpb3PTdBQeG56Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5079
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

> Subject: RE: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property a=
nd
> leave it off
>=20
> > Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub
> > property and leave it off
> >
> > Hi Jamin,
> >
> > On Mon, Nov 02, 2026 at 09:22:05AM +0000, Jamin Lin wrote:
> > > Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an
> > > older machine type keeps the hub it has today and a guest saved by
> > > an older QEMU still loads.
> >
> > Reran the migration check from v7: with pc-q35-11.1, a guest saved
> > without the series loads on v8 with the hub in place, for qemu-xhci
> > with four HID devices and for q35 -usb with six.
> >
> > But this missed the 11.2 soft freeze, so in 12.0 pc-q35-11.2 is an old
> > machine type too, and hw_compat_11_1 (my suggestion on v7) doesn't
> > cover it. Saved with pc-q35-11.2 on master, both cases fail on v8:
> >
> >   Unknown section or instance '0000:00:01.0/4/usb-hub' 0
> >   Unknown section or instance '0000:00:1d.7/6/usb-hub' 0
> >
> > The entries from 02-05 want hw_compat_11_2 once the 12.0 machine types
> > are in.
> >
> > Junjie
>=20
> Hi Junjie, Marc-Andr=E9, and Gerd,
>=20
> Due to the QEMU code freeze and the planned 11.2 release in December,


I am not sure about the correct release version. I expect it to be v11.2.
If the version is wrong, please correct me.

Thanks,
Jamin


> disabling automatic hub creation while keeping migration compatibility wi=
th
> older QEMU versions requires adding the property to hw_compat_11_2.
> We need to wait until after the QEMU 11.2 release for the maintainers to =
add
> hw_compat_11_2 to each machine type.
>=20
> The USB redirection server is my original upstream goal, and I think this=
 task is
> independent of the automatic hub task.
> So, I want to split the auto-hub changes into a separate prerequisite pat=
ch
> series and send v9 after the QEMU 11.2 release.
>=20
> The USB redirection server common protocol series still needs rework on t=
he
> device announcement and control transfer patches.
> I will send v9 next week and mention that it requires the patch series th=
at
> disables automatic hub creation.
>=20
> This way, we can continue testing and reviewing the USB redirection serve=
r
> common protocol this month.(November)
>=20
> "If you agree, I will send v9 next week. Otherwise, I will wait until aft=
er the
> QEMU 11.2 release and then resend the full patch series as v9."
>=20
> Thanks,
> Jamin


