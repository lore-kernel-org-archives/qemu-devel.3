Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACD606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zenithal.me header.i=@zenithal.me header.a=rsa-sha256 header.s=selector1 header.b=XZD75WOQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTRbc-0007cY-8E; Tue, 17 Nov 2026 17:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1xTRba-0007cM-PH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:24:46 -0500
Received: from mail-japanwestazon11020143.outbound.protection.outlook.com
 ([52.101.228.143] helo=OS0P286CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1xTRbY-00013g-7d
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:24:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4Rp0whvWy7rg9Xv9WRoGlzSKdJQvAs8oHzRKa1u3sJ2GjP3N1dOGBNu8LN1OylBoHWZEbKPtBRRWySeKaeVQd74i6bCvbRC4WwHSpLj+d5siWmq2gsT87+3XCgXVVHS15MLeNnAtVXbH8mOBw/jpHRmjvza2qOKZP3W7fUU+FckZWuetVOpwuXhkSsw/zg1Ml0vE0DbvjsrfnsDvHAswNcH6Af4pkSbCq5xadLwURWojS0a3BkfdkxkBe3Rd4S3KOSxtmxA0kBRMHVbp7s40XHgT3SzKXtVoEtB6MWvXN/66DsVEVgBl/nXwpoXSmnIOl/eHzTMhgupebzgO4tXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ump/wm/B7FacgI1/OmkWLP5v8K1ylotkbBIj3HtqIwU=;
 b=NyTRib1jZ7pjxnIbCT77DNnOowX8E2XGskpGuXAAlhXyJaQlofb/v00nqfr2dyhbYW5c3Y//J8soCTazxaGVJRIsgjQ+iwU42Ck/GCzKuOFlVIZMlY7T3wBwBFZUacekXwbrYB6SBJNmbAqVy0fpEzChBB8sOaPEluaTo+SxIAhDSwTEouz2x4XdRarV+OTIZEgZ0RO6kQQLGjh8g1cHjZe11vpLNsUtyj3TZF8x18Nzb7VwSbhg0KAxhF2gTxKL4697pQaVnVYZDkuK2R3jqH5kEik1EYQH8W/oMbXe+ZfaX77+DYOguZ1H+In3lxZ690uYQbkS/t8hurAm/vVyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ump/wm/B7FacgI1/OmkWLP5v8K1ylotkbBIj3HtqIwU=;
 b=XZD75WOQt4Mff5gnIFG7B0bkoTXWf0gFu4WdSAueLfd2KPAtYvD5sRyEhsgI/8zwKPoyXEQziD5GBRq+s7Djo4rzl6KU8yc/Zc1glUzk0A6eEGMFRLAxKwdm4K5TbUuAo/i/bdVdRQkmpzsJKmzxoNXzLNnXChR1WkIrcozpHQ4=
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1583.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 22:19:35 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a22c:62cd:f039:f25]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a22c:62cd:f039:f25%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:19:35 +0000
From: Hongren Zheng <i@zenithal.me>
To: Peter Maydell <peter.maydell@linaro.org>, Bin Guo
 <guobin@linux.alibaba.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Canokeys . org"
 <contact@canokeys.org>
Subject: Re: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
Thread-Topic: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
Thread-Index: AQHddsvEO12aI7QT706BfLjcGmqRWLcyzIz6
Date: Tue, 17 Nov 2026 22:19:35 +0000
Message-ID: <TYCP286MB1393A2F623C0081276E0563EBC7B2@TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM>
References: <20260918095718.33745-1-guobin@linux.alibaba.com>
 <CAFEAcA_wtZP7BvxMfamQG8XV5U0Q96Y1=Q5PL_mCEatfdrywPA@mail.gmail.com>
In-Reply-To: <CAFEAcA_wtZP7BvxMfamQG8XV5U0Q96Y1=Q5PL_mCEatfdrywPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1393:EE_|OSZP286MB1583:EE_
x-ms-office365-filtering-correlation-id: 8e18c937-e68a-4270-04be-08df44f8dc6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|41320700013|786006|1800799024|22082099003|18002099003|6133799003|20046099003|4143699003|56012099006|261026140227099003|261028144727099003|261021121427099003|10067099003|261021135927099003|261026121527099003|261102123227099003|261009223027099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: 7S2kbPGmTItG5lt9KIlfbENsdXr77BTuhocTxDdE9TfthzclrqcUFlNphbj3/1bMNorl5qsH9vYFcks3D1mkPTIeqD4iopSG4moEAp7VYNou6jwgtJm/+i4IKkZU4T9WWLJwTfB99r79R7p/Uwx9K2jOt7ivV+zqlpTERllTWwsHlaDGp1VKDlA8Jmlenf0GS4RNibHOl6r55hqwbFxBkQ4/+rTY/iM4e7oEld5+Rs7hp3KFsY19Sx+rMTmJK8y1JFtX5yux4xesnzIe1CElDhMQPJxd7+1zfUSrLK/7jLowaMRIRUmljyY6WRAuuDU7D2+WC3E2s8z0g8Dk/WqWWEVEIwn7O6pP+Z9lukXowgpRbB4kiTkKzeFcTbEGIeQUcGnbtE85+g5yv23qub2gid7yoBOGBYOKYhhzF//m5IV4RA5f7nF0L+aGLmSRdsT8wr1EgiMzZlvFJ4AmfujCPtTSzBt1klqtOA+eBOCDMyOxFM+Qm1dj/a9hBekpRllIWOVTdt8Qo+s/f3wWLkXxB7zEQ+nCmWWxkOW6t+3IPG2m/Bm4oCTrM/2O3LT8Fwad2L5XlUIBZFXubZUw9WoCDnLtGAOn8RkYJI+hbdnG+XY60xGUwgTkWc44Huq+scrcYo3oUjnfnF3x1p624emigmRqLWIWK5hLFuDiENZfhTs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(41320700013)(786006)(1800799024)(22082099003)(18002099003)(6133799003)(20046099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(10067099003)(261021135927099003)(261026121527099003)(261102123227099003)(261009223027099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Izc11Fh24i1du/cAGLz9QuDakKHAcyvRw3bbBPBUfBKJqY74STGXwukgNS?=
 =?iso-8859-1?Q?xuxPQIwuP+Z7PPzQ8IcjR43xMCg1/BBERMudnPNOxN0fz23vOL+oZyPe+X?=
 =?iso-8859-1?Q?9lP472oFnL6z9NMmRzqcEMCAozXa2TDS0PfCCAaWoA3YX7JsHNp0yQ1kjh?=
 =?iso-8859-1?Q?DuJXc8+pB4hmIGdZG0/N+xzF6ZtpMOFyj1DAMG5c2XdZA2qxZBycp+1KLo?=
 =?iso-8859-1?Q?fqWoFRt5muG4GG7DTGvM1QV2o3cbKTRUJ0pDKw3phHE+gQTh/o2MQkmfl8?=
 =?iso-8859-1?Q?Wk+wt+aWKJ9B/1vvxQ/oNd3RZIxGb1XdznsydMoIMoXbaVoKu5siYxUWXf?=
 =?iso-8859-1?Q?uq6ZO3Acl48q8wjE12iOkjf9k3QFplvzwjKRJHxAJPD9b01NMc25Iqhamp?=
 =?iso-8859-1?Q?UwOQHTZj4CyyNspKH1MUysf6u8xj7EJS3AKUT2mdOHCBv42rBV775zG8Xq?=
 =?iso-8859-1?Q?Bjo8gO3oSWFBeIOfuZyRT0gjAThEOkWxVI5Jh3Y94uze4ppKtw4PWP4Xee?=
 =?iso-8859-1?Q?hlXPXOeP0CgyFyZTCp+wv5rwvXyGZ1qOzp786rL1liSRXZtp6EYPvPtgCg?=
 =?iso-8859-1?Q?UuTSP0iAJTQK23APeI+2MNBe0ZOp5ybKTfRGmRPMG89yAOBgtgy0pVtBwA?=
 =?iso-8859-1?Q?Fwra1f8blmTPMxKaOfWOgvjH+caQ5BqhUU2ppziUjVHE0zkemDD8bsRQlC?=
 =?iso-8859-1?Q?up1MmcuG4zEKwHGr6nc042qkEZl4WdH4lUYjF9fd8IZOAJPzFW/8S8fOYD?=
 =?iso-8859-1?Q?Ggwie8WSMawDOxDrOUQVQrXgKeMwBGbbm8RiViiC1denYfMPBzGI2DO5Qf?=
 =?iso-8859-1?Q?RucaCtrD4t8J3Spn2HaR0IimlwPZVRquGue7tPwkEQw+18GDUgMBVOGrkv?=
 =?iso-8859-1?Q?8/5dxGB+xm2XeGMXW+u7TB7vuJ16jhdTP7y45Xl/nRwoCG5hTmh5Wr7tzw?=
 =?iso-8859-1?Q?FRlJcMxezmwdPDPHKnGd3EnZU4Xl7VMHquvLedMqRN5mk1B5irXMFUn6MS?=
 =?iso-8859-1?Q?eFf7hzHHPV/6L2vOL7rCGxze7MGtRfQFIYBqELnxGxRri435ijTg7BbZxo?=
 =?iso-8859-1?Q?BintdA38bcSqe1nomGZtdqJ7BjnxJtPqpv4kBhdfkXFeUpa8yEFKqN1I8B?=
 =?iso-8859-1?Q?UB5oFOyyDQGcjx59ENndhILDoi60M5/brvHeHRfHEgqJAFWRofxeG3XrAU?=
 =?iso-8859-1?Q?m9ig8tdc/XubtFdu7edcL/eHLCrOQ677JKDC83+AskxTTTPnqmJiloZt07?=
 =?iso-8859-1?Q?SbzWj1Y1OxtjsoXuXOqll+sN3o58T9nhmP/qJiT/7Hxutox/mJBmCueDD0?=
 =?iso-8859-1?Q?CfL4e1SiNRVhIYxOtHDPYdhPebmX7m9XQLzpbtUYOZu4ZzREQkcAAgDVLd?=
 =?iso-8859-1?Q?VQ3XKHT+ixc3SfT59LoRF7nf3OCUoo4bGcq+T/AW3UH72Fuxz7tjkfzc7k?=
 =?iso-8859-1?Q?D7YnQULYe8Q/W/OO50UBXOEXKze7QhZ0S9sJgiYmx7mtTofzW+tf7Xk+jF?=
 =?iso-8859-1?Q?jvTFFvV+8ESjqgBlC6CyZyGsPVoebnUzBYa6LuRQWI5BqHPzg7xOoCv9V+?=
 =?iso-8859-1?Q?9Y+jAnk4+oONtDtbJGbYcKG30FQFP7jqjuIxeET+yqAfEqKyjpBphOl4R+?=
 =?iso-8859-1?Q?4zUPw5wFrzE+/ZY4JazgUor2Wx6VDgjVU1HJlf7Hljq0dlDzHEscoW924a?=
 =?iso-8859-1?Q?iaf10BWmad0LXlS5oN9lZ8CXmLSIsNAPQ0qMrCeha6hYUNT0NPUGgBtggs?=
 =?iso-8859-1?Q?vR/kEYbuKuUv5U63NUgKpk/HI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e18c937-e68a-4270-04be-08df44f8dc6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 22:19:35.0282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaSoULXHyy5jD39ug46sfqh1NT99ohxfUpK226PzzZH5vzxUwvQP0OeiEEPUw0Tv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1583
Received-SPF: pass client-ip=52.101.228.143; envelope-from=i@zenithal.me;
 helo=OS0P286CU011.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

> On Fri, 18 Sept 2026 at 10:58, Bin Guo <guobin@linux.alibaba.com> wrote:=
=0A=
> > canokey_handle_data() takes the endpoint number from the USB packet=0A=
> > (p->ep->nr, guest-selectable 1..15) and uses it to index the fixed-size=
=0A=
> > ep_out[] / ep_out_size[] arrays of CanoKeyState, which hold only=0A=
> > CANOKEY_EP_NUM =3D 3 entries.  A forged bulk-OUT transfer on any endpoi=
nt=0A=
> > number >=3D 3 therefore reads a bogus length from past ep_out_size[] an=
d=0A=
> > writes guest data through a wild pointer read from past ep_out[].=0A=
> >=0A=
> > Validate p->ep->nr against CANOKEY_EP_NUM and return USB_RET_STALL for=
=0A=
> > invalid endpoints, before any array access.=0A=
> >=0A=
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4481=0A=
> > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>=0A=
> =0A=
> Probably worth Cc: qemu-stable@nongnu.org=0A=
> =0A=
> > --=0A=
> =0A=
> Did you have trouble getting the canokey code to build? I've=0A=
> been playing around with it, and the canokey-qemu library=0A=
> appears to have a busted pkgconfig file, such that meson=0A=
> can't find the include path for it and the #include in QEMU fails.=0A=
> I guess if you installed it to the system include it would work.=0A=
> =0A=
> NB: given that the canokey-qemu library is Apache licensed=0A=
> and QEMU is GPL-2, the whole canokey support in QEMU seems=0A=
> of very niche utility, because you can't actually distribute=0A=
> a QEMU binary that you build with it AIUI. And distros=0A=
> generally don't ship the canokey-qemu library anyway I think.=0A=
> =0A=
> So is it actually useful to anybody, or should we just deprecate it?=0A=
> =0A=
> thanks=0A=
> -- PMM=0A=
> =0A=
=0A=
Thanks for the email. The fix looks good to me.=0A=
=0A=
Reviewed-by: Hongren Zheng <i@zenithal.me>=0A=
=0A=
Regarding the build, indeed it requires modifying PKG_CONFIG_PATH=0A=
for meson to find it for custom build, and this behavior is documented in [=
1].=0A=
If it is a system package, it should be fine.=0A=
=0A=
For downstream usage, NixOS used it for CI testing of their=0A=
systemd-cryptoenroll for ensuring successful booting after upgrading [2].=
=0A=
There are efforts to push it for other distros [3]. I acknowledge that it=
=0A=
is niche, but I think there are still users.=0A=
=0A=
[1] https://www.qemu.org/docs/master/system/devices/canokey.html=0A=
[2] https://mynixos.com/nixpkgs/package/canokey-qemu=0A=
[3] https://github.com/canokeys/canokey-qemu/issues/6=0A=
=0A=
Best,=0A=
Hongren=0A=

