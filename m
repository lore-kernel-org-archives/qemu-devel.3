Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDE606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zenithal.me header.i=@zenithal.me header.a=rsa-sha256 header.s=selector1 header.b=HDdG9peQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWYqN-0000vH-Jx; Thu, 26 Nov 2026 07:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1xWYqL-0000uu-JE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:44:53 -0500
Received: from mail-japaneastazon11020107.outbound.protection.outlook.com
 ([52.101.229.107] helo=TY3P286CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1xWYqJ-0005ey-0y
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:44:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrOPYCQR0WEj18WzOTHWlhs+/dGjnbXTpBwMufh2mMQLsOy47bBrCyl7x1apDCxYr1NeIl6gj/oEDm/QPUObYyhNJrB/vd953xb8rzGqd3zV7ykLuJakME03q2Gdf74LpCwHBTVDSaW+BG0Fj0DJSXiYOzEMGyPNqnv3rhRdOePQCBVgSZBczUR01XSbcI9tC9tfX53u5xwqgJrWe4yuuuKhMKuEKVETGJBjUlh38nJVKDFMhEERHh97YuyoHMNXYSgfp6zPac/AV1fN27sbBSbOjvUkV/O3weMsX3yxbhOdDkVkj6YGkZmgwOMJEiWO2eWHTly+QqLicUw/4Gfqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnhKv3K+TkkoJN/3KxUgW5wyjCXkOnrzVsBNHLBEYag=;
 b=R36pjQQg9GUeHH1m77GEKfU7Hoba7+2RGsor/wOa31M+xqge24MCOmYzWFB+PT6rCQspuTU3Z6JANHWoHmafMrHlSM8tVlqAcyQBoLRG+tmR/c2D7twSGQVWLkb0ldi8iPJAEmvi8P08D0tlsDIBQk381F5qCVr/l0MICx+HZsz7qa4ey/pu05QOJ5wK9bic34Jp2aE+9Dp8kkWWsV6gn3G0LPH3BaRXdUE50gGaVJbRW22I6GFUMilDEef0BM9vCQ5X5GOJCIIynf6wHpjeTyWkOS4Z1cRyVLVjyjrkiWYUxfzVMSvN4m6yW0iClxm/ohM786ug46I+c63NwwcMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnhKv3K+TkkoJN/3KxUgW5wyjCXkOnrzVsBNHLBEYag=;
 b=HDdG9peQO56tBDVQj1B3X7qOpyMi7iLa9qty2R7NgoeCw5dPDxoRAwlzW6ARH226tDoWryAGzMJhNM6O4qcvXMfnno0x2Z+8mfxZ+O5hrWbiEqmKl5myec/QWPlh1qx6W9l/bAjfjChHCaWfp16iaugkGh/NPcTpU5qca+pBfXo=
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TY3P286MB3030.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:319::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.7; Thu, 26 Nov 2026 12:39:41 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a22c:62cd:f039:f25]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a22c:62cd:f039:f25%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:39:41 +0000
From: Hongren Zheng <i@zenithal.me>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Bin Guo <guobin@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Canokeys . org" <contact@canokeys.org>
Subject: Re: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
Thread-Topic: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
Thread-Index: AQHddsvEO12aI7QT706BfLjcGmqRWLcyzIz6gAEKWACADHfAnQ==
Date: Thu, 26 Nov 2026 12:39:41 +0000
Message-ID: <TYCP286MB13931FAE71A2DDBAD37DEB99BC422@TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM>
References: <20260918095718.33745-1-guobin@linux.alibaba.com>
 <CAFEAcA_wtZP7BvxMfamQG8XV5U0Q96Y1=Q5PL_mCEatfdrywPA@mail.gmail.com>
 <TYCP286MB1393A2F623C0081276E0563EBC7B2@TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM>
 <CAFEAcA-fWQy3afLRzCPjX2GQMDydx2w6eKbrmBBic8nOuwsDKA@mail.gmail.com>
In-Reply-To: <CAFEAcA-fWQy3afLRzCPjX2GQMDydx2w6eKbrmBBic8nOuwsDKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1393:EE_|TY3P286MB3030:EE_
x-ms-office365-filtering-correlation-id: 422a5b7c-c424-472f-a3de-08df4bba57b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|786006|23010399003|376014|38070700021|261102123227099003|10067099003|56012099006|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021135927099003|261026140227099003|261026121527099003|261009223027099003|20046099003|18002099003|22082099003|4143699003|6133799003;
x-microsoft-antispam-message-info: +8qL9xUutB3YygzheELWx0NyWe0NNIrYgATRuaSRUhXTkq+A1iSJ/nOzhrPORKaEsM2gQYU31H7W0Gtn2GO1tiQu6pwRp3vtMbR1W7pv8b6w2JZ4wXUp5tEDu2lMCNQFK/Q1wuMWk0FiVOjZIJYZu9+YVQodUAkrTOD/0iawy+JnM9lhkJIV8QCj/X2ixeXk6f95mTrO/8KG8WdIQ0diBCDpdkHMxAJtysmQ5o2b1MOQEXKjdYrqgYQDPB7aTK8UrheENBXh3BOc8latW4oxQwwy4DUYNvc1JHhC1jhJP/k9jWoNPFc3Pzix4aO6zZVoanhrUFH/bMwB31rIaHmP6ZGi+UYOzKYJkv7A/SZ7Wj5YagkQs+lbqx2numjTftrzPpny1NWH7rQDGKB39eaCO29oXH/JyRiIW4QzEfY8pdZbwG/Vvg2nSLiaovpghutUh7cIFiIewTzbN2/8rcY4/UnsPe/XyyI1PrBbEVwMjh4kMmNEiS2j1t5edvuruQwLeWqiO/N711oYP7oS9XB2IbXbqJAvgmhMRBvb8EDSXmOdd7M0304a6Bp9araY2kPAGIr7TiyvG4tDMhk9L9ppPMqTytx2/kKOd+KQB7ui/cT5g3iQiM+HIImVABQW1lDZeMPZqbqnfVAaXV1JbubmrBxelpNVIDG2j+igbw63gfY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(786006)(23010399003)(376014)(38070700021)(261102123227099003)(10067099003)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021135927099003)(261026140227099003)(261026121527099003)(261009223027099003)(20046099003)(18002099003)(22082099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VUir2ET3cmvQdGIpsd43ec1LhJSIQdwVKVDXQK6vpukc4pc0J+vbDmgvx/?=
 =?iso-8859-1?Q?7cVdNt5FdtUzaV9VlP8Trb+Z968xAJYZrW63jzTAfGtPGonuzamBFPTSx+?=
 =?iso-8859-1?Q?zkgR/UnyWlyHOgpHt/3LDXMH/djbIKv1AUdeQzGLfEpAqzwb9vxfzHTIQ5?=
 =?iso-8859-1?Q?Q/tnSVEw5iZcs9ewwNLzw2qGhtiPfMbvoVX2WPX4Z0aXx5KumkiWyx/0zK?=
 =?iso-8859-1?Q?5w8Fh70beixnfdPt0zxY8wyLohTf3sP75GeGvYEI7mLx60bWI92oyyUF90?=
 =?iso-8859-1?Q?x8XVO7Rr+Pq6wG+roJNIh91TutfM/i/ujweeMM4RxVOhIxRqFznhwZ+Kdy?=
 =?iso-8859-1?Q?ZUV6tLawW0xtfr2FM2HnRacsCpy9VXX7CY/AKVg237AOPfpv10BYLn8047?=
 =?iso-8859-1?Q?rkzDvUi2Jg4qTfKU4qRaiAb13S8MLiH/K+e/67XPQp4ZcNqJ+7WNmlubzq?=
 =?iso-8859-1?Q?2atqME8dE9mMECkdaHYjJPhrYsWRfElLrxss2aCouZCI0PuJRHgALJWLZe?=
 =?iso-8859-1?Q?6b0ft9MXOiTXew0qsMqJyOlV+Qwfr3f/Njqc2ANvyxGm/LQos9J4kNuQ57?=
 =?iso-8859-1?Q?xq0xd4gtJrs9DcqFQDrQsDQgNoVtYzb8yf1KaFy4xdpVEB5hMWXQf8PAd4?=
 =?iso-8859-1?Q?o1W+wiVmdoT7N6CLMUC8xbjoTxGqg+hoskwANRNITcaJehF0oF8Xm4pPGe?=
 =?iso-8859-1?Q?Cbth92V9vTuCNofttbJQWMfeeBjnbdu+Gg9nPVAc7kb5TfMMdAIH8CdNSl?=
 =?iso-8859-1?Q?7IbUs/obugfYH2BaoUJAUneE6z1nvV3+5fh+6a352TovUD8Y/9r9+9mWnz?=
 =?iso-8859-1?Q?ukivBeiepn38iKRfBA7JniyfrffFHWKz5PlNtKTgCyd9ks58P4BoTnsyJK?=
 =?iso-8859-1?Q?+Z/mQcoFeDr7C0ReDWKRbKuhoRwRoCRNf14KVp1SZAOwDFsXGyCPvYcLz7?=
 =?iso-8859-1?Q?jYxlPaDKabAASHfjSoYbsCyOSDyRJwmqfWuucONuViprajfMHtPTqPhzro?=
 =?iso-8859-1?Q?xRuhtsjinxASBf/iRLuuO1+AtZ4G6ihPc8lZUCGiLrekM5hXCcB8pj6xpS?=
 =?iso-8859-1?Q?cEkO9gPZttccamhPbkXr0kBPbkUiWfBdjbhn6hTd0684x4LQffu+t79aDY?=
 =?iso-8859-1?Q?PQHTazhm5FJN5Vn0WNjuHwSaz2IuHXiRz4z9ri0HHfqgMCm3gYeevHXPrp?=
 =?iso-8859-1?Q?3n4eEmlblD50WWlnbL0kpJgeDukJ8/1n6txKpHHk+0JK/N3StCkryl4a7a?=
 =?iso-8859-1?Q?/rHgI1lRnlc/geBTKr+J5n0KeT8vRwljepEqgGXvUQHIeKk/PeUK0mv+GV?=
 =?iso-8859-1?Q?uFaXwcHuom/khlz+Q9wO6FSCq8JFrkVhMtL7WzpMj6LjxqbjtbMsAKYyiY?=
 =?iso-8859-1?Q?DY2bB3iQGxbr14EqWjSIGCA2eaVmiM4Bhltiq4nhFMTZLy43EQh2I93eVf?=
 =?iso-8859-1?Q?PW94ynBXY9vFDQY/9K8oJ4vBslJBsF3J3S2ouFqzQk4iTlBpmMATt2KMue?=
 =?iso-8859-1?Q?Ou8YzIHWfqe9LHUf1NmTa4ZhBQHnQooXrz2EShAtezOdgtZGkwpvTn7SbG?=
 =?iso-8859-1?Q?9QVmAhzKVnhFkiOMBGmzdmAVvgIR4nLGLwUo1mU5G3U9otAH/gMW1MDENs?=
 =?iso-8859-1?Q?317KXd/voQZsu9pX5C2M0rOiqqpmxV1FgNJTqtMrlldfodFAcIF43C3sKa?=
 =?iso-8859-1?Q?AtvrD5rSzzZcDWaDNPFvzjmhYrK/5gYz3JXLH/Qjp94OQLfUrDYrrcAPL3?=
 =?iso-8859-1?Q?jHfru1jjeAz7LdZEYeADUAgvU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 422a5b7c-c424-472f-a3de-08df4bba57b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 12:39:41.7254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ke6X0uODwv07u/jlLqTl+Azlya0dkt/tsuqWxSHrtmxx9zYN7WqKw6lh4EDXyf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3030
Received-SPF: pass client-ip=52.101.229.107; envelope-from=i@zenithal.me;
 helo=TY3P286CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PMM wrote:=0A=
> On Tue, 17 Nov 2026 at 22:19, Hongren Zheng <i@zenithal.me> wrote:=0A=
> >=0A=
> > > On Fri, 18 Sept 2026 at 10:58, Bin Guo <guobin@linux.alibaba.com> wro=
te:=0A=
> > > > canokey_handle_data() takes the endpoint number from the USB packet=
=0A=
> > > > (p->ep->nr, guest-selectable 1..15) and uses it to index the fixed-=
size=0A=
> > > > ep_out[] / ep_out_size[] arrays of CanoKeyState, which hold only=0A=
> > > > CANOKEY_EP_NUM =3D 3 entries.  A forged bulk-OUT transfer on any en=
dpoint=0A=
> > > > number >=3D 3 therefore reads a bogus length from past ep_out_size[=
] and=0A=
> > > > writes guest data through a wild pointer read from past ep_out[].=
=0A=
> > > >=0A=
> > > > Validate p->ep->nr against CANOKEY_EP_NUM and return USB_RET_STALL =
for=0A=
> > > > invalid endpoints, before any array access.=0A=
> > > >=0A=
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4481=0A=
> > > > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>=0A=
> > >=0A=
> > > Probably worth Cc: qemu-stable@nongnu.org=0A=
> > >=0A=
> > > > --=0A=
> > >=0A=
> > > Did you have trouble getting the canokey code to build? I've=0A=
> > > been playing around with it, and the canokey-qemu library=0A=
> > > appears to have a busted pkgconfig file, such that meson=0A=
> > > can't find the include path for it and the #include in QEMU fails.=0A=
> > > I guess if you installed it to the system include it would work.=0A=
> > >=0A=
> > > NB: given that the canokey-qemu library is Apache licensed=0A=
> > > and QEMU is GPL-2, the whole canokey support in QEMU seems=0A=
> > > of very niche utility, because you can't actually distribute=0A=
> > > a QEMU binary that you build with it AIUI. And distros=0A=
> > > generally don't ship the canokey-qemu library anyway I think.=0A=
> > >=0A=
> > > So is it actually useful to anybody, or should we just deprecate it?=
=0A=
> =0A=
> > Thanks for the email. The fix looks good to me.=0A=
> >=0A=
> > Reviewed-by: Hongren Zheng <i@zenithal.me>=0A=
> >=0A=
> > Regarding the build, indeed it requires modifying PKG_CONFIG_PATH=0A=
> > for meson to find it for custom build, and this behavior is documented =
in [1].=0A=
> > If it is a system package, it should be fine.=0A=
> =0A=
> >Setting PKG_CONFIG_PATH is not sufficient. The problem is that=0A=
> > the pkg-config is:=0A=
> > =0A=
> prefix=3D/home/pm215/src/canokey-install=0A=
> libdir=3Dlib=0A=
> includedir=3Dinclude=0A=
> =0A=
> Name: libcanokey-qemu=0A=
> Description: CanoKey lib for QEMU=0A=
> Version: 1=0A=
> Libs: -L${libdir} -lcanokey-qemu=0A=
> Cflags: -I${includedir}=0A=
> =0A=
> but it doesn't actually put ${prefix} into the libdir or=0A=
> includedir variables. So meson put "-Iinclude" into CFLAGS,=0A=
> which can't find the include file. I think it ought to say=0A=
> =0A=
> libdir=3D${prefix}/lib=0A=
> includedir=3D${prefix}/include=0A=
=0A=
Thanks for pointing this out and it has been fixed in the canokey-qemu repo=
.=0A=
=0A=
> =0A=
> > For downstream usage, NixOS used it for CI testing of their=0A=
> > systemd-cryptoenroll for ensuring successful booting after upgrading [2=
].=0A=
> > There are efforts to push it for other distros [3]. I acknowledge that =
it=0A=
> > is niche, but I think there are still users.=0A=
> >=0A=
> > [1] https://www.qemu.org/docs/master/system/devices/canokey.html=0A=
> > [2] https://mynixos.com/nixpkgs/package/canokey-qemu=0A=
> > [3] https://github.com/canokeys/canokey-qemu/issues/6=0A=
> =0A=
> But what about the license conflict? I don't see distros=0A=
> being likely to want to enable building something that=0A=
> isn't redistributable, and especially something that's=0A=
> documented as "testing purposes only, no warranty on=0A=
> the security".=0A=
> =0A=
> thanks=0A=
> -- PMM=0A=
>=0A=
=0A=
I found openSUSE also builds canokey-qemu a long time ago and there are som=
e recent updates [4].=0A=
It is not shiped together with pre-built qemu, it is one dependency for dev=
el:microos:systemd-boot.=0A=
Nixpkgs building system only builds it on user's demand.=0A=
=0A=
I acknowledge the Apache 2.0 license issue and it can hardly change due to =
deep dependencies.=0A=
The tf-psa-crypto library we depend on uses Apache 2.0 license.=0A=
=0A=
Given the current situation that qemu and libcanokey-qemu are not shipped t=
ogether by distributions=0A=
and indeed there are some users for testing purposes, I still think keeping=
 it=0A=
as-is causes less trouble for downstream users. I am not able to think of b=
enefits of deprecating it=0A=
other than making more works for downstream users.=0A=
=0A=
Best,=0A=
Hongren=0A=
=0A=
[4] https://build.opensuse.org/package/revisions/Virtualization/canokey-qem=
u=0A=

