Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91182606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=XsJPbZAf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLZuj-0002ES-1r; Tue, 27 Oct 2026 01:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLZuf-0002Dv-Eu; Tue, 27 Oct 2026 01:39:57 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLZud-0004Ba-Ch; Tue, 27 Oct 2026 01:39:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+gRGEumwv+P2BIv7vsUha5zOxnVw/TRknq7lXnIyBx0E66EYtTWi6q2wA2NXzF8huV7z8FlwFUC8/GE99PTenHBAhNkzeqvYSkxGTQpudFlF34V2BpGeZyxODBhl4FAlo1KovJsrVWPtIMeAThKyjiemPZWDAWL8y7lUsXeDegGWhpeGFmrHLPSUt0mDJUw4b38AwM3tUfZhliZGByu4X+PVTMr5fExNKnQDJW2zuGO3KOZrLIXVUVAr1DRv/X5L5Uqr4Qn+sQ1gH6QKnyV8SUvcVYa3/kW2jeqh4hfjcfOgumQZC63VrcZsgV2iM6djJWZL1v8rX1boRNbpHiX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgnSx2Ux+NORmV/cwIqLfyVUahfjdvS0MvWJAJ5Nz2A=;
 b=crk1zjmGMKsBUGogaUJmimS7E0hg9utVcu2l5TE2t1GXJsBPcFBVu4b4WrBuwVZfnUkdgBKAM3O7UdPZCf6HDUXoE674fj/eDLKADjkmBG5AIRyYtQJ1cHbSZmSK3qu9vpgfuSu+pv2lVh1WQfMwxrp5MdWZnfAMUcuc+62dEJlvV4uWCrLVhCfJ6y1fdSnhYHdNZvzvmF8exD5jvYI7i463TBpdrn7/iTXGIzaWpYCzdT+1lNb9OgrjMAlsw96/Uu09tGdVCOYrpPA19cm1lNP8/DHLYBpv3dcFlnDPGBiQQkZyNi9GHRux8uHUc/UDoGYGc3YxYEftxyfNcEV9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgnSx2Ux+NORmV/cwIqLfyVUahfjdvS0MvWJAJ5Nz2A=;
 b=XsJPbZAfLPZnPfAJVGhiH4eMyQERgabtU8eC9GWYI3XuZBf/ueTKxv7wYvK8GG8A6tFF+cVNvzoNcaYGqV5spl+Pl5U/qEvFDGUmawFb/JfrK+CfBSy8qNV+wzVx508wyDaJKyizfZFAOOYgvZbYswdxKLt+eUNShzmgeWFJk+hQMGt9ymKc5kteG0k+EEdx7tnr7TaJNF2tT/FZ6YFlmL3/CcVbY2+m+9GRo5sETBNI5TlVyAaR9oejmPVayPdYtAkDJ8NHkOIYu3MgQRR1qMjHP4Csfsz6xaJ1QcpYr5kmQJR720idN5h0iPCHSPnTZMPnETrOD8ybKvxJQ4npaw==
Received: from TYZPR06MB7373.apcprd06.prod.outlook.com (2603:1096:405:a7::14)
 by SI3PR06MB8732.apcprd06.prod.outlook.com (2603:1096:4:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 05:39:47 +0000
Received: from TYZPR06MB7373.apcprd06.prod.outlook.com
 ([fe80::9b90:c4d9:22de:2ac4]) by TYZPR06MB7373.apcprd06.prod.outlook.com
 ([fe80::9b90:c4d9:22de:2ac4%6]) with mapi id 15.21.0569.006; Tue, 27 Oct 2026
 05:39:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdX6uxp6OpQ9yqq0CEeDiwsS34zbcEqZMAgAxB77A=
Date: Tue, 27 Oct 2026 05:39:46 +0000
Message-ID: <TYZPR06MB7373C4DABEAE16D546241853FC602@TYZPR06MB7373.apcprd06.prod.outlook.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-2-jamin_lin@aspeedtech.com>
 <atXr2J5oxn3BBgb-@nucbdw.ghoffman.csb.home.kraxel.org>
In-Reply-To: <atXr2J5oxn3BBgb-@nucbdw.ghoffman.csb.home.kraxel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7373:EE_|SI3PR06MB8732:EE_
x-ms-office365-filtering-correlation-id: ae0caedc-044e-4149-f26d-08df33ecb5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|56012099006|4143699003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: sJFDIJ1nliKys6oIWgRElMWgUzGoD4xFC2dftNap2cNpPAh+BeS58yWiWvkxfgJKd9lh0nsahuKIxi7jAnjYuax4Dp5DFalZ+kCSznAAnr0qdFI/P8d2f2bXBrVcrMe2Y5epsphwlKCJ5WoUbf4dBqPjS/D5lA9LLjVLq3GRlEf+5nfQVlPaltdtSu/U5O0rLUiGAyGsKJQf/92/K4qPlgkVTaZICUUvnYLRmejwMLYAnBNglQ+bN+4fb36grvCON0uz/b06jA7N0y98w1w5EuTewmcwDVC3HCHA+Z3YeJtiVf/2E3rktPNVRXPE4wMEohdm0zEPlmKn8hzJDG94arGql66QNLSL5t4tEXvR2FOnMY8+m8qHCj3MwCgDljigO2FajSlq96pR+7sk940qzBV+nzPBoQwt4gFLN/u7oP3H+s1C4qco4avRtdO5rEV19iF0nhCp3u1L7yVecqeogrwGRKbfSD36gyHTAHFHHtNQrCvlQDog45SkrEoHpnmKJl1feDAxzpOYEebpSITMsqxcWGTSqxjbhsdzIAq6TrXrLCModKWgtyUf5ezT5aVfsX07Sbzuug3pR7xjoMvvVqQQ/mmv0ML2fFMh0QK1N4c5PL4pmCX5hUnAhPMV79lV3drlnJTas+7u/xQXljT7SnmJ69nFN1xkZuA96occFugMIIm/uWBzkB/ZFZWwT0H7ljE21GvNp3PfzlkOBZ1M2RH61pe6yDR5VZ8dsIf5WOA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB7373.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lIFnPhSb8+KdOEeNK+Ps2Y0KYwBoXajNpvIcgOwYvwYVbqy8j8ACEgUQz+?=
 =?iso-8859-1?Q?zk3nAc+UjNw9YieAvFFwp3Znbe9C6hznhftgVUTD8ZvCWxHoPlZ7wn4dnz?=
 =?iso-8859-1?Q?iD6pY72oetsjGwg4IXfFsseN+bKpcPhHliUlquYcdwOnOQF6KPcnIhpOxu?=
 =?iso-8859-1?Q?5Q/CL1PLY8hodSBMXhyGSdkFfQr8MDA7FZX7pFD6vJVBXaMSlnl5Q+HjNf?=
 =?iso-8859-1?Q?aHkzba9nnoXoOc/maiYqmzCyKTdZWqYoVcHP2dC6kLwL9QW6shMFmuB/UD?=
 =?iso-8859-1?Q?8c2FHly3Yqj1TQIA1V1Ole9fg0VseDGCZlpKvdBLKcaQG8JKWGXKvzpS1E?=
 =?iso-8859-1?Q?WTeEtOjIKGMDTFZhP4N0wUQjOJUTf9OnEK0orhV5rJrSujaQdKJxD+dBkH?=
 =?iso-8859-1?Q?VJJGvfMws2ZbsgxHLcLDuGfT6Z1bgdIclEjuvky8ZKV7BtWYRrtCt26vRl?=
 =?iso-8859-1?Q?MQxg/1Af8d65A98QfwLR/NuuF9wyhoLbAyt0rEjnjPuoD8d7s2usUdtWB4?=
 =?iso-8859-1?Q?sbd4mQJ3j/Uw+jDMe3LdW2kqS07Ecj9hqY3Jcxq0VlM8q1wm1aiNsLUQlO?=
 =?iso-8859-1?Q?al3jX1PU5hy4Rkp9tVMb00gtmKgN4dQPBIJ3iHkMttkBK/FRGVf03Z9iRY?=
 =?iso-8859-1?Q?w88JKMMkZ0cXbcHIZE+5QKHBXYwF7ol/cFrQG9cQOwDXSBoMqGn9ghN1gP?=
 =?iso-8859-1?Q?ORge7WL7sp9hSebcUzDaDogecmeUS2X/zQef+AoDcYl5R2OUG11DNEfVZu?=
 =?iso-8859-1?Q?CMTf4GNDY3yMt/j+VwfvwBqlXLMWVvPzSV/cCBNchjvkHuKQD2rlDLPzob?=
 =?iso-8859-1?Q?ruGszUGuDDgEMEWZMlwl6BVCrgfDy3jt2wTsfnaPPOlAXTCKElSStI9QHm?=
 =?iso-8859-1?Q?Wr14BkvK2M9va4crsEOcv469JSe72KGtFxIGoYL1g4QX2jjAHfBqANlXz1?=
 =?iso-8859-1?Q?eDbEgmtlPeZb+NyPzU53CvDfIDEbpP7MHOPQxz3OaUm+Tn/K3/5M71sw/z?=
 =?iso-8859-1?Q?zigW8bYa33KggfTK8qq2TMa4gyF1Y+kaYl5N94t1U9LFLFJBSky3jL31u7?=
 =?iso-8859-1?Q?+9Sz8sdpJ5OdJ6ULNLq0tqDhOEUUc2CKeQHXsa3LADV2zNv70mSDEiVaSo?=
 =?iso-8859-1?Q?o4iIuP6aNE5vGRhGFwSUBx8KtEOfhMzES4e6Y10aVHsk39zApAbbf+8cyk?=
 =?iso-8859-1?Q?aH9Ahj28Zg3eaV5AflAPMdNptOmw/VoeMFyzD26W91C+tUjWRxWVe/UUR0?=
 =?iso-8859-1?Q?CDXOUM9tAqo3IQzllWP3mFWhyGl3kbFKA25f8zLEMCrCiL1bS1q3rei0Hg?=
 =?iso-8859-1?Q?WuU46XjAUzCOg0TPz9losQevrvFhyILEIN9Coc27/9v0F+szctdWoR+kEu?=
 =?iso-8859-1?Q?KQXPKQIlm122YJguwbwFnkeJFRJNY+YQL054HNlhXIY1N30jBsdJln16A0?=
 =?iso-8859-1?Q?kxVNlC8x8sA5d8D/qM+o91s8Q5olyOwLN1jVniqZr+JGvvTLl0dk0J8cUV?=
 =?iso-8859-1?Q?666sxSXiHpvc424Vwsg3O29DCQ9A5VecE9fq7bv5hmxqWrQgz/oNjog0UZ?=
 =?iso-8859-1?Q?uTF8C9I1XSqYkmOim0HBLu/io+UCBspaRuoOHFU8IDj3M29yNqNuPhHyj6?=
 =?iso-8859-1?Q?K7OB3Cqk+ydEbkqhyN6bheJMWrH7bSD2xM7ng79SM2wYrUOuz38vtjFK/t?=
 =?iso-8859-1?Q?7FHWT0/0leI6Z2678BeIpEvTBfz9HJ7KRTkMeBv9TjbqmI54q+cqg8MIrE?=
 =?iso-8859-1?Q?z0X7vtJe2BvHgtHyTmoBLA5+30Ss79CJNDC2MnOayvGs7wTCjqCURawLF+?=
 =?iso-8859-1?Q?CPhsGpq8mw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7373.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0caedc-044e-4149-f26d-08df33ecb5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 05:39:46.8143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfycXoD4DBCX4eMIeLIYx5+OmqHWwIrR2XzJsnxMKBcVsFu0z2WaFwu+vtdluasSx4yUs1eEWc34yD+RJQ2xXDvkMSPwYwMg9Ktaq0s9zIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8732
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

Hi Gerd

> Subject: Re: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hu=
b
> insertion
>=20
> On Mon, Oct 19, 2026 at 09:24:50AM +0000, Jamin Lin wrote:
> > usb_claim_port() inserts a usb-hub when a device is plugged in and
> > only one port is still free, so that more devices can follow. That is
> > what a host controller with root ports wants.
>=20
> Ah, well, not really.  It's there mostly for historical reasons.
>=20
> The emulated usb hub supports only usb 1.1, so for newer host controllers=
 (ehci
> / xhci) it does not make much sense and the better approach is to add mor=
e
> host controllers if needed.  Which should rarely actually be the case tho=
ugh
> given that xhci supports up to 15 root ports.
>=20
> So if this gets into the way I'm wondering whenever the better approach h=
ere
> is to remove this altogether.  You can still add an USB hub manually of n=
eeded,
> IIRC there is (or was?) some board with a single-port OHCI where you actu=
ally
> need a hub if you want plug in both usb keyboard and usb mouse.  It just
> would not be automatic any more.
>=20
> Alternative idea would be to add the config option, but only enable the
> automatic hub logic for actual usb 1.1 controllers (ohci / uhci), where i=
t does
> not matter much for devices whenever they are plugged into an root port o=
r
> hub port.
>=20
> take care,
>   Gerd

Sorry for the late reply.

Yes, it gets in the way. usbredir carries one device per connection, so
our bus has one port. Plugging that device in adds a hub, and the device
ends up behind it. That is why I added the flag.

If you would rather do one of these, tell me and I will send it:

 1. Remove the automatic hub.
 2. Keep it, but only for the USB 1.1 controllers, ohci and uhci.

Thanks,
Jamin

