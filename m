Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5BCEC1444
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQ4M-0005Ui-En; Tue, 03 Mar 2026 08:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vxQ4H-0005LS-Vv
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:45:46 -0500
Received: from mail-out-3.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vxQ4C-0001tO-EV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1772545541; x=1804081541;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=YFH0EkWUW4tdWpLP/LTieiEXDUUDdE1RtsX2K1daDLk=;
 b=nz2w8yBTdNT5jD8dUczNev3KqT2f3ajZ1cIUMaQJpKuFSaK3uOFjAr02
 3zBIZ0V+ERKHu4SLKkofgO/o09KGEUKEQuTjO7NoxDpH8rzHjRxGLcF6e
 2+XpYHjeFTXVZnzDjll6pQDPkqzB1MGkRQ0OeNrp20ePQndfXQmEJMmAd
 ecs6ylbXtG0DSwsQ7Ugve2CCy39uj7DjYXXGaKPr4hhIjiIU0lr4Hqagc
 TdFksb8cRL6R+1IUlfY6zBEsEhFqteiH2DO7r5VWARktWv0/wv0tKJoEq
 zULWbGh6ky/Z9aOlKqppaAMjtPe9k7A+F7VebpdKbF10sm6l2woK7lQz2 w==;
X-CSE-ConnectionGUID: 22FZIdMHSyCLlLa8F5dciw==
X-CSE-MsgGUID: FQ15gCGkRBaQLkJQVNaW1Q==
X-IPAS-Result: =?us-ascii?q?A2DpAAD85KZp/54agoZaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBghCCGIFggTodAQGEOJF0A5g8h10PAQEBAQEBAQEBBAQBUQQBA?=
 =?us-ascii?q?YUHAh+NASc4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQYBAQEBAQEGBYEhh?=
 =?us-ascii?q?glThloBAQEBAgEjVgULAgEIGCcDAgICLxQRAgQOBQ6CdAGCTBMUqCp6gTKBA?=
 =?us-ascii?q?d8CgRoSFAGBOAGBV4Z8AYFdE4MNd4R6ggxDgTwODYIwOD6EWoNEOoIvBIIig?=
 =?us-ascii?q?Q6HYQaBRolZUoFwLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFB9YGwcFEiEqg?=
 =?us-ascii?q?gZ4ggEPhmt5Ay5eGg4iAjxcSj4LWgWBRAMLbT03FBuMSRAhDYIUP4I0AYENg?=
 =?us-ascii?q?gY7HQvGcQeCOF2BCoZdgzOXYgQvl2CTCy6HZZBzqRYCBAIEBQIYgX+BfnF5A?=
 =?us-ascii?q?YI8UhcCD44tFoESAQLFengCOgIHAQoBAQMJgjmQEQGBHAEB?=
IronPort-Data: A9a23:hWu2QKuoz0nbrjpca45+rPprnOfnVHdfMUV32f8akzHdYApBsoF/q
 tZmKWCDPv6KNGLzLd5/Pt62pB8Au57cx9VnHgQ4pS1nRiIVgMeUXt7xwmUcns+xBpCZEBg3v
 512hv3odp1coqr0/0/1WlTZhSAik/nOHfykVLKs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyaDt8B56r8ks14qyp4GhA5zTSWNgS1LPgvyhNZH4gDfzpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID733CuDgRrukoKHKJ0hXV/0l1lrPgto
 Dl5jqFcfC9yVkH6sLlHD0MIQ3kW0Zpuo9crKVDn2SCaItavn3HEm52CB2luVWEUF3oe7Wxmr
 ZQlxD4xgh+r3biY8pO3b8lXl+8HKO3ibK1Ctnph0mSMZRomacirr6Ti3+Bk/BoAw/8UWN+Yf
 dUFaX9mYFLMbnWjOH9OU854xbzwwCOhNWQF+Dp5poJui4TX5Al4yqTsNpzWYNuHQ8RTkW6Vo
 WTL5W+/GA4GNJmWwDGF/3TqiuKncSbTA9tPSefmrac76LGV7kIqUUAZfnS4m9Ows2q9eethD
 UUroxN7+MDe82TuFLERRSaQuHOYswRaXtNBH+A+7CmJy6zd+QHfAXILJhZYZdk78cM7WzEu/
 lmOmdzvGHpoqrL9YXuZ+6fSpz60PyUYBWsDYyYeSk0C+daLiJkzjxbKQv5nEai8lNqzHiv/q
 w1mtwAkmKkTgN5OyP/+9BbdnC6s45HFCAI4junKYl+YAspCTNbNT+SVBZLztJ6s8K7xooG9g
 UU5
IronPort-HdrOrdr: A9a23:wxcgUaGGYqiYfOv1pLqEzceALOsnbusQ8zAXPhhKOHtomszxra
 +TdYcgpHnJYVcqKQwdcL+7Scq9qB/nmKKdpLNhWYtKPzOWxFdATrsSj7cKqgeIc0aVygce79
 YET0EUMrPN5C1B7foSlzPYLz9P+rW6GeuT9J7jJj9WPHlXg+sL1XYDNu+0KDwNeDV7
X-Talos-CUID: 9a23:rlqvEmG7LaS41wxsqmI9rmAmO8wAUkbM51PUB0boJztlQ7yKHAo=
X-Talos-MUID: 9a23:SEW1mwty+qjSXAbV8c2nqgg7achDzKeUIkk0tZYkgveiPBMpAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,322,1763420400"; 
 d="p7s'346?scan'346,208,346";a="315526319"
Attachment: smime.p7s
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
 by mail-in-3.itc.rwth-aachen.de with ESMTP; 03 Mar 2026 14:45:27 +0100
Received: from rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) by
 RWTHEX-W2-A.rwth-ad.de (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 14:45:27 +0100
Received: from rwthex-s2-a.rwth-ad.de ([fe80::9e0:8e94:8a31:2f0b]) by
 rwthex-s2-a.rwth-ad.de ([fe80::9e0:8e94:8a31:2f0b%4]) with mapi id
 15.02.2562.037; Tue, 3 Mar 2026 14:45:27 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH v2 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
Thread-Topic: [PATCH v2 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
Thread-Index: AQHcp+hguCr597vVyUWvsk3ZXLwesbWcnqaAgAA5fwA=
Date: Tue, 3 Mar 2026 13:45:27 +0000
Message-ID: <B17B010D-538C-46EF-B256-268586CA76D6@eonerc.rwth-aachen.de>
References: <20260227-semihosting-cpu-tswap-v2-0-cbdcdf39dd15@eonerc.rwth-aachen.de>
 <20260227-semihosting-cpu-tswap-v2-2-cbdcdf39dd15@eonerc.rwth-aachen.de>
 <CAFEAcA9+A4Y52f+zZ=hcJZnsAfhLKQf0dnfoWj49W3p53PUFwQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9+A4Y52f+zZ=hcJZnsAfhLKQf0dnfoWj49W3p53PUFwQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26022219
x-originating-ip: [137.226.124.15]
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha256; boundary="B_3855393926_1929436940"
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:48;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-3.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, MIME_QP_LONG_LINE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  =?utf-8?B?S3LDtm5pbmcsIE1hcnRpbg==?=
 <martin.kroening@eonerc.rwth-aachen.de>
From: martin.kroening--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--B_3855393926_1929436940
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

On 03.03.26, 12:20, "Peter Maydell" <peter.maydell@linaro.org <mailto:peter=
.maydell@linaro.org>> wrote:

> On Fri, 27 Feb 2026 at 12:55, Martin Kr=C3=B6ning
> <martin.kroening@eonerc.rwth-aachen.de <mailto:martin.kroening@eonerc.rwt=
h-aachen.de>> wrote:
> >
> > These functions are needed to support semihosting on CPUs that support
> > runtime-configurable endianness. They should not be used in other conte=
xts.
> >
> > Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de <=
mailto:martin.kroening@eonerc.rwth-aachen.de>>
> > ---
> > include/exec/tswap.h | 36 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 36 insertions(+)
> >
> > diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> > index 9e94fa0021..6d9301129d 100644
> > --- a/include/exec/tswap.h
> > +++ b/include/exec/tswap.h
> > @@ -10,6 +10,7 @@
> >
> > #include "qemu/bswap.h"
> > #include "qemu/target-info.h"
> > +#include "hw/core/cpu.h"
> >
> > /*
> > * If we're in target-specific code, we can hard-code the swapping
> > @@ -72,4 +73,39 @@ static inline void tswap64s(uint64_t *s)
> > }
> > #endif
> >
> > +/*
> > + * If we're in semihosting code, have to swap depending on the current=
ly
> > + * configured endianness of the CPU. These functions should not be use=
d in
> > + * other contexts.
> > + */
> > +#define cpu_internal_needs_bswap(cpu) \
> > + (HOST_BIG_ENDIAN !=3D cpu_internal_is_big_endian(cpu))
> > +
> > +static inline uint16_t cpu_internal_tswap16(CPUState *cpu, uint16_t s)
> > +{
> > + if (target_needs_bswap() || cpu_internal_needs_bswap(cpu)) {
>=20
>=20
> I don't think these should have the target_needs_bswap()
> check in them. Otherwise for a normally big-endian CPU on
> a little-endian host where the CPU is currently in
> little-endian mode, target_needs_bswap() will return true
> and we'll swap the data, even though we should not
> (because cpu_internal_needs_bswap() returns false).

You are right. Thanks for catching that.
Should I send a new series immediately or wait for further reviews?

Cheers,
Martin

--B_3855393926_1929436940
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIWHQYJKoZIhvcNAQcCoIIWDjCCFgoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghLUMIIG2jCCBUKgAwIBAgIQIzxeR1DfkY/t9Cm+VVHL6zANBgkqhkiG9w0BAQsFADBj
MQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2VhcmNo
IEluc3RpdHV0aW9ucyBDQTEbMBkGA1UEAwwSR0VBTlQgUy9NSU1FIFJTQSAxMB4XDTI1MTEx
MTE1Mjk0NloXDTI3MTExMTE1Mjk0NlowgdMxCzAJBgNVBAYTAkRFMRwwGgYDVQQIDBNOb3Jk
cmhlaW4tV2VzdGZhbGVuMR8wHQYDVQQKDBZSV1RIIEFhY2hlbiBVbml2ZXJzaXR5MREwDwYD
VQRhDAhHT1ZERStOVzERMA8GA1UEBAwIS3JvZW5pbmcxDzANBgNVBCoMBk1hcnRpbjEYMBYG
A1UEAwwPTWFydGluIEtyb2VuaW5nMTQwMgYJKoZIhvcNAQkBFiVtYXJ0aW4ua3JvZW5pbmdA
ZW9uZXJjLnJ3dGgtYWFjaGVuLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
scbe0MnfYWYhL3iklcUn43k7e4DJycolxDWXiOSghpE4NbV4obfamUtkigolqpVwkwAywxLM
B/RZkmg4NwK9eNklZlqvMbcL4N/A66LANFoFOBnEljtlBm89LlCTHPDsdtRrsfyQWXzo6fgH
SDMDYNWR4ejhKMJT83ZBHfTfNPsNtJqJ/lxR2jbiOEXGu8SQjuk5/ydV29N8i9a1dpHBFKWv
YSw16+4ii0O2p31oDiJYaggfAeN4PF1C7ZVH3gFKghwwFxUgvZmz04SEfJXBdh3zDQJn7DyJ
uw1myBMUXATwxN50PAZirIWm88iWh88z9rOpYhwGBFxw+YIcyAXjzZCGn51WKxWICLeSBrJJ
oJmFGlyJ+lehfh3t+O3iLtfsG3hmtF0ulXMRxECkS9rGC8WeMHLUJKhugBAQHGhDTyCbsxZW
y6EKgyMKA8zltWrOzD4107euoyuB+wl+54eXzbwMzbANfpMmGusW+EJh1OfGBaPVrU7mWIUq
sSU3KkRbEqfXNNSyEFvhMza5pfc+XvetNEI9tCGAuN1tY5PI0Akf+E0PARJ5WZl93s+3VOWB
eghS2N7qTiyyGNdSH5FlwYDIy3lTPan7WKA1dquBYoVf5srxjmdWVxTNLOlKMIMuhY6yfB+Z
iyDaoNjL3Xp5my/FE4TMHW6Xg/u9nNm/P1cCAwEAAaOCAZcwggGTMB8GA1UdIwQYMBaAFOuy
Lzv9rgLMKkQGXSXNHRIiaLBHMEoGCCsGAQUFBwEBBD4wPDA6BggrBgEFBQcwAoYuaHR0cDov
L2NydC5oYXJpY2EuZ3IvSEFSSUNBLUdFQU5ULVNNSU1FLVIxLmNlcjAwBgNVHREEKTAngSVt
YXJ0aW4ua3JvZW5pbmdAZW9uZXJjLnJ3dGgtYWFjaGVuLmRlMGMGA1UdIARcMFowCQYHZ4EM
AQUDAjAIBgYEAI96AQMwQwYNKwYBBAGBzxEBAQIEAjAyMDAGCCsGAQUFBwIBFiRodHRwczov
L3JlcG8uaGFyaWNhLmdyL2RvY3VtZW50cy9DUFMwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMD8GA1UdHwQ4MDYwNKAyoDCGLmh0dHA6Ly9jcmwuaGFyaWNhLmdyL0hBUklDQS1H
RUFOVC1TTUlNRS1SMS5jcmwwHQYDVR0OBBYEFBZ6nr2j7nTiNEpysS4Q1LWfhajdMA4GA1Ud
DwEB/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAYEASrEZ/VGpM+lPpNUZcqFCkF6bvVO7pAVG
iODiSZ5AZ6p0Tzj4R2/05ZcJja1cT7A9V+afh1lSQR+ZrEGmq5CUwrKCWQ5Clq1bbE4Owp0u
QcF3R7d1IWZmK16ukCk4hRHR93DJ81omdO5HRPh8mFKmLpn/bq+TP+Djm5qzM9S3w/Wgr+KJ
pUd6WkYAs1M17cypnn98r9LNAmmLEgN2P4rvuSGEwVW1gzOFPQeYi8vFRAgffdfuBAq0G8Jc
FJ3OTETxtoH3C1X7/CfcPkbnFLfB7lXXv3CuzD0Q2kHuWkzkSzVKG5yQSqEU57CLLgjNUnb2
Bw/lbfKW25IW3YApX5JhuQE/1Kmr6NSVV0Hkb5Hwrc7WZAmdNcvsyBKgQwEHa/pUSkLyuACy
ipgx8wv8ts+YGsQ5gKXKtw34PGEyIsUe7KuDTI5tS094yenQiN58UGkcBgD++wtswxpPv1ln
slpFh+4cEoEx81hdpcwSMIqUlBaDZGOrrseFwRDv5Nkdb9KgMIIGRDCCBCygAwIBAgIQFfmu
bKqNLtTTb3h/Htx7ATANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQGEwJHUjE3MDUGA1UECgwu
SGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEnMCUGA1UE
AwweSEFSSUNBIENsaWVudCBSU0EgUm9vdCBDQSAyMDIxMB4XDTI1MDEwMzExMTMwOFoXDTM5
MTIzMTExMTMwN1owYzELMAkGA1UEBhMCR1IxNzA1BgNVBAoMLkhlbGxlbmljIEFjYWRlbWlj
IGFuZCBSZXNlYXJjaCBJbnN0aXR1dGlvbnMgQ0ExGzAZBgNVBAMMEkdFQU5UIFMvTUlNRSBS
U0EgMTCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAKu4bq/+byKjHo25Xz32YBmO
+Wrkmc+UmfcdXSCI7yawwU9JSMEHAAKAASaJpLr9JAyt+tlB/rn/SaznSwY4ipBIffR0D5k/
ndfiI553dWgI4i/tkOGlNej/7JyE2CS9kTlOOs6pg5HaDpwqjAhCkje+IByg5gKWH6lzvMJo
5jQOtsGB2q6e5cYKwa9LJOAcR8iquds9LFssbHSMuVdSuTjpAjcGLqWfW++C0YXpWD+UonjQ
6lNEuiKUDmrFc+SEtLw56lYtp4uuxm4LW/HQSsx+oGwMBqaR6HhBQ3LydONjsbcbegRqJZFJ
oLsnwIHorEag44UIvjXzYJAx/NTiwVdHldO7cEvWscDbyQLR9koBoliq2HrgYFQs7NQxU+7M
LNSh8i6znWVNISUEg36M//I8BZl4VqD70ELlhKKN7rx+i7BwKOd2gxdWgFJhkPyQu9o+82R9
epXiRblo/rdkyv+2BFR7VpbgPUzncdi8/0h4dP/qQFYnA+Df0FFj7gYczwIDAQABo4IBZjCC
AWIwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSg1gc9XiT3e6BELiRSDRmqKwSR
pzBQBggrBgEFBQcBAQREMEIwQAYIKwYBBQUHMAKGNGh0dHA6Ly9jcnQuaGFyaWNhLmdyL0hB
UklDQS1DbGllbnQtUm9vdC0yMDIxLVJTQS5jZXIwRAYDVR0gBD0wOzA5BgRVHSAAMDEwLwYI
KwYBBQUHAgEWI2h0dHA6Ly9yZXBvLmhhcmljYS5nci9kb2N1bWVudHMvQ1BTMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDBDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsLmhh
cmljYS5nci9IQVJJQ0EtQ2xpZW50LVJvb3QtMjAyMS1SU0EuY3JsMB0GA1UdDgQWBBTrsi87
/a4CzCpEBl0lzR0SImiwRzAOBgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQELBQADggIBADve
uEX23DwrkygKtsF7DmcTGmi8SE20jmJLe0TMT8Nws1NqppE0ACym1agtY1IjUFm5MWabG/Ic
vRTh8sB9cRZgDQMqZLNCLofqL4aj/dKBXH4bwH2MVdjNHBoGvZkyhRz/kBE+x1vaWXclhWQM
OX5nVvRMfiEJiYotMP7KM88IaVZ9DkGJJEVftsnUWuvCWUtjagD6XWlqLHjNl+LufiZ/h9lD
vaWqG1/obfdStgofMc30RL+ES6gYKRwZpCA1coFzXV7Cnwx8toTl8bReqCNXexKzxlqAcRXP
OmlKkJQuqRI297oNuMPnoNZCY+yLnxyd4kZuu0XcOTNTpVjM8bvg8ACqhSYanrNDi/zTiTk7
gwm9GyH1X45fFNGNEFgpIaApjT2UELukDOmP18ZwC4EQeHawPJIqffMEmUJm6qbRPKGnNmcy
ygh4iZU3QbkRLLp3Z6QV3WoTEqyf5mL9qTGS6WJG65L8oaKw1Xh/bdGuVIDyBahpfP2c2pCd
0UH6+x73Rrq9GFlOijVr2OQSvKhzETNG917SvcURCBhMnIQFUXqHQyIY60eH1po6WtNOq/1K
5kpOG6Sq1RVc02LEit48uK4tRMVUKekSOjruGXW38DmAriPcMHjI6VQbqjc0Sq1VPz76ee4F
M5uLviSUZHYqDDqMWa8LFImK9iiKI8E3MIIFqjCCA5KgAwIBAgIQVVL4HtsbJCyeu5YYzQIo
PjANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNh
ZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEnMCUGA1UEAwweSEFSSUNBIENs
aWVudCBSU0EgUm9vdCBDQSAyMDIxMB4XDTIxMDIxOTEwNTg0NloXDTQ1MDIxMzEwNTg0NVow
bzELMAkGA1UEBhMCR1IxNzA1BgNVBAoMLkhlbGxlbmljIEFjYWRlbWljIGFuZCBSZXNlYXJj
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

--B_3855393926_1929436940--

