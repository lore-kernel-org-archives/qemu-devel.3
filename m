Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5434BEF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm1E-0000zJ-7p; Wed, 04 Mar 2026 08:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1vxm1C-0000yv-98
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1vxm1A-0006vL-Kd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48371119eacso83044505e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1772629918; x=1773234718; darn=nongnu.org;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mh+Yn1FLjcbT4NTUoV5EqyaIT8r6txfh9f2r9eHoj3w=;
 b=dzn1TMOVy/Hr6aFJdVUMMCINzFJ6Dhn3o3YQhvrPevQ8UmzUri4/7MT/QBeybb9dlp
 N0J/HHrUHbFFcfWq/hOlrvK6swp6axnXwwYiR59bA4Zg/iimpmcTUrPaIFZys8PAHbX8
 xmuYSquNp4HfSrFI15j1LBqB7Qjs07XDStfwyGLUwoOMN+g73qyWJBkZd/t1GEpW6Y1C
 iYxajAyZHvDhbzxsg+GlrQF1Pp1XjD8nHcKLaWcUm27eobuKZVB5TiBtr963u2x5kV4K
 HS/MO2SqV+8Vb+G6dxxJy007exIZ2x1Ie6SLsJYdfUNQojGhM7ccGNKeitrF3kh4a494
 4Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629918; x=1773234718;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mh+Yn1FLjcbT4NTUoV5EqyaIT8r6txfh9f2r9eHoj3w=;
 b=lZtfS3bloY2HPssnpLFfw1FC+hzwrovvWp66cc9KThUpm/U7UwdYq+JWpbZiuzsnTZ
 qZiiK8KsbKeXlTHfXzLR2+y5F9gMAlsvOe+SCoKwaHwFek/ZPamIMBUdqSbmt+ZEvQLG
 WTPt/yS3FrlWE+Fms/yLe4/JlBv+jUrT+MPCgMBeXX82GJL2EX13FRM6BpMTXuBzQ0Bh
 0a/p/tktbSQ9eDnhilnX0BdcSWL/+mzNyAp9a5OG3i6NcAsqTGT+XRJOppa8znLE3h29
 JXU1PyzaTzEeKcnvT9EbzuaH5X2WDjHUlTLJovetX4+lMMmbLUwYb1O2oPM3GpgeLMNH
 FZCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ZQSE34yjPYD6HopRuE2JxWY26lhTNQeT2xVuPe7o9CaWLtfP9RazW7i06cBWZW7XkJlWYiWBgSik@nongnu.org
X-Gm-Message-State: AOJu0YxvhB2j1phORVbrt9O5d23wEOaEwtS6f8nn6cY7arGFJRKBFwHt
 orwO1Whfly9Mtg2Tk1Bp16A7hV/Ag13uFecfCO6yFPIMcylyWy6mLvPoMv5OvzJFz1c=
X-Gm-Gg: ATEYQzx669vjWLS66Mlgr43Y0jhodb4LjjzGJPuyDJXkEMSfjNZZz5NkrTlUnMUJaLs
 pl13qzlDP4+Uu86Hk2Zq38RMln50dTEyp3SMqAUJpqhalKcRJVfa3htcaOl93ByEuJcO+tqkHsA
 kwpe3kZNfW0/2nF2RGIGlqW8wKsEZBYFPOQ/tT5sp6qGIPlmHXl4U2jgbhbNWsaDQcuzOMwwCic
 /pdN1JeUzVxaNJAnx3BfxrkI6lV9dRbfXj60Gyds9fHpZP3BEpxOn37hzuxZKe1RqlXUnewp29A
 bRZMXDI+T1FPc20Y2PUN/vOBLghESU7o8QKdxFmDrWY9Rd0ZdCrbS3ukGqCVFM1JwwIuQdVuZE/
 8gya9gv0J9HrgwkeBh/0xyKmEQrccPRGdw7P6P2o8jvm8M87RPjVxebqkS1pYr6wnPFerSmmf/w
 CWTyETWJ3wY1VELo0nzP7BlbDIuJTDp2aJFJiO+/JDrYTH
X-Received: by 2002:a05:600c:a07:b0:47f:b737:5ce0 with SMTP id
 5b1f17b1804b1-4851988f31dmr31235805e9.23.1772629918410; 
 Wed, 04 Mar 2026 05:11:58 -0800 (PST)
Received: from [192.168.102.59] ([217.155.172.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b4d06c27sm22741278f8f.17.2026.03.04.05.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 05:11:57 -0800 (PST)
Message-ID: <511c95f2-b939-4461-9d83-8a2151da1bee@lowrisc.org>
Date: Wed, 4 Mar 2026 13:11:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "amitkh@google.com" <amitkh@google.com>,
 "qemu-maintainers@lowrisc.org" <qemu-maintainers@lowrisc.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dave@treblig.org" <dave@treblig.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <177159976712.8279.7732381632410882915-4@git.sr.ht>
 <bdcd1226cd1588c746506955ef77548e493cf8b3.camel@wdc.com>
Content-Language: en-US
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
Subject: Re: [PATCH qemu 04/11] [ot] target/riscv: implement custom LowRisc
 Ibex CSRs
In-Reply-To: <bdcd1226cd1588c746506955ef77548e493cf8b3.camel@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JDOVOk60Gfb0bdTvdRzSPysA"
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JDOVOk60Gfb0bdTvdRzSPysA
Content-Type: multipart/mixed; boundary="------------gBjHmQrvA4LiLhWI0pOIE240";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "amitkh@google.com" <amitkh@google.com>,
 "qemu-maintainers@lowrisc.org" <qemu-maintainers@lowrisc.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dave@treblig.org" <dave@treblig.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Message-ID: <511c95f2-b939-4461-9d83-8a2151da1bee@lowrisc.org>
Subject: Re: [PATCH qemu 04/11] [ot] target/riscv: implement custom LowRisc
 Ibex CSRs
References: <177159976712.8279.7732381632410882915-4@git.sr.ht>
 <bdcd1226cd1588c746506955ef77548e493cf8b3.camel@wdc.com>
In-Reply-To: <bdcd1226cd1588c746506955ef77548e493cf8b3.camel@wdc.com>

--------------gBjHmQrvA4LiLhWI0pOIE240
Content-Type: multipart/mixed; boundary="------------WBqE1g0Sfw01Npn6SWxOGbR8"

--------------WBqE1g0Sfw01Npn6SWxOGbR8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMDIvMjAyNiAwMDowNCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gSXMgbmV3
IE1JVCBjb2RlIGFsbG93ZWQgaW4gUUVNVT8NCj4NCj4gQWxpc3RhaXINCg0KSSBiZWxpZXZl
IHNvPyBpZiBub3QgdGhlbiB0aGlzIHdpbGwgYmUgYSBiaWcgYmFycmllciB0byBjb250cmli
dXRpbmcgDQp0aGlzIGNvZGUuDQoNCmNoZWNrcGF0Y2gucGwgdG9sZCBtZTogIlNhdyBhY2Nl
cHRhYmxlIGxpY2Vuc2UgJ01JVCcgYnV0IG5vdGUgDQonR1BMLTIuMC1vci1sYXRlcicgaXMg
cHJlZmVycmVkIGZvciBuZXcgZmlsZXMgdW5sZXNzIHRoZSBjb2RlIGlzIGRlcml2ZWQgDQpm
cm9tIGEgc291cmNlIGZpbGUgd2l0aCBhbiBleGlzdGluZyBkZWNsYXJlZCBsaWNlbnNlIHRo
YXQgbXVzdCBiZSANCnJldGFpbmVkLiBQbGVhc2UgZXhwbGFpbiB0aGUgbGljZW5zZSBjaG9p
Y2UgaW4gdGhlIGNvbW1pdMKgbWVzc2FnZS4iDQoNCkluIHRoaXMgY2FzZSAiYSBzb3VyY2Ug
ZmlsZSB3aXRoIGFuIGV4aXN0aW5nIGRlY2xhcmVkIGxpY2Vuc2UgdGhhdCBtdXN0IA0KYmUg
cmV0YWluZWQiIGRlc2NyaWJlcyBtYW55IG9mIHRoZSBmaWxlcyBvbiBvdXIgZm9yaywgc2lu
Y2UgdGhlc2UgYXJlIA0KYWxyZWFkeSBwdWJsaXNoZWQgdW5kZXIgdGhlIE1JVCBsaWNlbnNl
LiAob24gb3VyIGdpdGh1YiByZXBvKQ0KDQpJIHN1cHBvc2UgcGVyaGFwcyB5b3UgY291bGQg
aW50ZXJwcmV0IGl0IGFzIG1lYW5pbmcgb25seSAiYSBzb3VyY2UgZmlsZSANCmFscmVhZHkg
aW4gdGhlIHJlcG9zaXRvcnkiLg0KDQpDYW4gc29tZW9uZSBjbGFyaWZ5IHRoaXMgcGxlYXNl
Pw0KDQo=
--------------WBqE1g0Sfw01Npn6SWxOGbR8
Content-Type: application/pgp-keys; name="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
WZXWKp/svUI=3D
=3DQ1uI
-----END PGP PUBLIC KEY BLOCK-----

--------------WBqE1g0Sfw01Npn6SWxOGbR8--

--------------gBjHmQrvA4LiLhWI0pOIE240--

--------------JDOVOk60Gfb0bdTvdRzSPysA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmmoL5wFAwAAAAAACgkQfLsg1AtVWCzN
Rwv/UclcxD+DWprULIjEak2wVc9txnr/W9XOBDNthhbv5tsPJOJjhjG5vtjbSX51hBo72kSHxO8Z
t3mw3GSXR/+aP1RCpp3s1tOmAKPDXgJiEL6UKaLK7wYSiA+X0LZRwzxdblXyBttxGsTC3zT/qCkm
3m2V8GCdBv4u1nSet02zTW4nztyUjl95luvb1sSJaPORX8kgbHozj7sYPShfuFrzevYlHY+q54tn
+tufr409vNRNODTgXKI2IbjIVwcdr50++OLUbTOiAylqO1JjRNgfyorfQFTiQ3zcbK9ybqdGffM4
6RKk4gdWM6BvT41B3mYoP6P6tp0VtJxf1s3c2/Iy3vipDW2FENA2xICUmpBDBmb/R6Nnh9RVD4r6
CaIu2nQRTX2AwdOTwt84DLPj3DQFsOOz7jQTMhqXDnFT9zlkdUgVbp+3TlTcXv0YODHdTWhnkuFa
AFciGC9AlqZ5xv1oPiV38G66CLGLwZk5OGIfr25IhzTHWZr+ScJA7FSrvvRz
=BZB1
-----END PGP SIGNATURE-----

--------------JDOVOk60Gfb0bdTvdRzSPysA--

