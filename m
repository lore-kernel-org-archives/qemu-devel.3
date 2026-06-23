Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFD3CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4SL-0000EO-JU; Tue, 23 Jun 2026 12:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wc4SK-0000EG-7H
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:58:36 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wc4SI-0001h2-AU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UMIL8U3P3RbrZ5/NMUFExaeFPY3EZeAoQi3lTdQeIwY=; b=ODxCWy/mkUjN2h1482y+BA6M7F
 cNIo+rffUkDY1179HtILfCtnE63SdjWzli5G4raeorzzlwwfwpIoOtpkpOmbpEjNA9cZUlGclXpn1
 wVU4Rq2lJzlZx7jeN5ThhUW2cDtfNxM3vgkcFZDgG5Rf7BANt0SMbVL+dU1NXF/TEtURZNITBO3y6
 IO0qppgElehGw8B05nvyewftYEowKGIzE2ZedxaFOsatgq/pm0a8phh/J1fC0ujboh8XMG86Sp3Jy
 Jv4wuIY70LvIK4mIbXhqbYWpWbAr1MUkHKzma3L8zPONlOSWBQZt/LqvqVadb8T1V9Xns0zJs3ymN
 mqTDiHTQ==;
Received: from p548e302f.dip0.t-ipconnect.de ([84.142.48.47]
 helo=[192.168.253.101])
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rclobus@rclobus.nl>)
 id 1wc4SI-00000006a9d-0kVo for qemu-devel@nongnu.org;
 Tue, 23 Jun 2026 18:58:34 +0200
Message-ID: <d35cb62b-78cd-49ef-b2d3-cbb62a92cac0@rclobus.nl>
Date: Tue, 23 Jun 2026 18:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: Support the configurable EDID fields
To: qemu-devel@nongnu.org
References: <20260623163535.366104-2-rclobus@rclobus.nl>
Content-Language: en-GB
From: Roland Clobus <rclobus@rclobus.nl>
Autocrypt: addr=rclobus@rclobus.nl; keydata=
 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 2g==
In-Reply-To: <20260623163535.366104-2-rclobus@rclobus.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------e4yz0Q3oyCkNw0ypW0cTRNb1"
X-Authenticated-Id: rclobus@rclobus.nl
Received-SPF: pass client-ip=2a09:8b00:300:8::10;
 envelope-from=rclobus@rclobus.nl; helo=web05.whitelabeldomein.nl
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------e4yz0Q3oyCkNw0ypW0cTRNb1
Content-Type: multipart/mixed; boundary="------------1ssO0frrqwC6wWZHtL9Iinp7";
 protected-headers="v1"
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Message-ID: <d35cb62b-78cd-49ef-b2d3-cbb62a92cac0@rclobus.nl>
Subject: Re: [PATCH] virtio-gpu: Support the configurable EDID fields
References: <20260623163535.366104-2-rclobus@rclobus.nl>
In-Reply-To: <20260623163535.366104-2-rclobus@rclobus.nl>

--------------1ssO0frrqwC6wWZHtL9Iinp7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMvMDYvMjAyNiAxODozNSwgUm9sYW5kIENsb2J1cyB3cm90ZToNCj4gVGhpcyBwYXRj
aCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBmaWVsZHMgdGhhdCBhcmUgY3VycmVudGx5IGNvbmZp
Z3VyYWJsZQ0KPiBpbiB0aGUgZnVuY3Rpb24gcWVtdV9lZGlkX2dlbmVyYXRlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUm9sYW5kIENsb2J1cyA8cmNsb2J1c0ByY2xvYnVzLm5sPg0KDQpJ
J3ZlIHRlc3RlZCB3aXRoIHRoaXMgUUVNVSBzZXR0aW5nOg0KYGBgDQotZGV2aWNlICd7ImRy
aXZlciI6InZpcnRpby12Z2EtZ2wiLCAibWF4X291dHB1dHMiOjIsICJpZCI6InZnYTAwMSIs
ICJvdXRwdXRzIjpbIHsgInZlbmRvciI6ICJJVk0iLCAibmFtZSI6IkFBQSIsICJzZXJpYWwi
OiAiNDIiLCAid2lkdGhtbSI6IDQwLCAiaGVpZ2h0bW0iOiAzMCwgInhyZXMiOiAxMDI0LCAi
eXJlcyI6IDc2OCwgInhtYXgiOiAyMDQ4LCAieW1heCI6IDE1MzYsICJyZWZyZXNocmF0ZSI6
IDUwMDAwIH0sIHsgInZlbmRvciI6ICJSSFQiLCAibmFtZSI6IkJCQiIsICJzZXJpYWwiOiAi
NDMiLCAid2lkdGhtbSI6IDEwMDAsICJoZWlnaHRtbSI6IDc1MCwgInhyZXMiOiA4MDAsICJ5
cmVzIjogNjAwLCAieG1heCI6IDgwMCwgInltYXgiOiA2MDAsICJyZWZyZXNocmF0ZSI6IDYw
MDAwIH0gXX0nDQpgYGANCg0KV2l0aGluIHRoZSBWTToNCmBgYA0KY2F0IC9zeXMvY2xhc3Mv
ZHJtL2NhcmQwLVZpcnR1YWwtMS9lZGlkIHwgZWRpZC1kZWNvZGUNCmNhdCAvc3lzL2NsYXNz
L2RybS9jYXJkMC1WaXJ0dWFsLTIvZWRpZCB8IGVkaWQtZGVjb2RlDQpgYGANCg0KQm90aCBv
dXRwdXRzIGhhZCB0aGUgY29ycmVjdCB2ZW5kb3IsIG5hbWUsIHNlcmlhbCwgc2l6ZSwgcmVz
b2x1dGlvbiBhbmQgcmVmcmVzaCByYXRlcy4NCg0KV2l0aCBraW5kIHJlZ2FyZHMsDQpSb2xh
bmQgQ2xvYnVzDQo=

--------------1ssO0frrqwC6wWZHtL9Iinp7--

--------------e4yz0Q3oyCkNw0ypW0cTRNb1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUFVLM5Bdj7GSJEb+YsV8aqYUlb0FAmo6uzIACgkQYsV8aqYU
lb2BqhAAkH2RqgU86Hr52U3wbm1neejQC2zcpNTvROEVVuZUj/EORpiApwf4PjTo
tolyo5r6eVrlFXSdWieRNhTuWHGnBJLt6+yzbSlJbl4ZXzd3WqjBloEe9NAgbJGV
goxTSXmMTPHtXQfvZu9ZtiY7IRYbPi2M7wq4oRXqzvH4c+JKF7t8qtDKnoxASPwd
jODROAoFJWtYxWNKfAmpmACgeMzPDaPMK/cXbQf8lCGw5jUo1xHXugWzUOxewkh+
cimf+f1Do7NMIUXUFuVCJuwynSOZY1fSr3dXn8YqRmmhyIz8xWmMZqAMjWZMnnhV
cZWycaFb0Jpd3AmlC6SySggDfSAHNJ0xMeCxjTt9elBCGQ/VlpUIIPnq/AXIpSe9
2agJfrVXT6Zk1Zn4DGMcPzLK+bL/+gFlo1wbJ8lS0mBpgwRc0kvwkyHrv9BovjH9
CZNwbUy8clx8l4kbw+JZgams/rUlxePSnGpSS9thKideanjSpTIn2/QLGPnnlz5n
CVPZjwhDRPD8mYRLmN6BOBMTuzYmkIlOUb38ifp15r9Gn4AiDYglUEUU6pMDdKNF
mBB5XY6GVM8/kZBE3Qr54uHDhEZvTlnKlPs5NOAzX+2DB6bGAqFH5pc/paz1Ftgr
vR5bAYZgoMzhkUReX0u+sSVLWHhckCggAebakKnHIklGwGf3iPY=
=aqha
-----END PGP SIGNATURE-----

--------------e4yz0Q3oyCkNw0ypW0cTRNb1--

