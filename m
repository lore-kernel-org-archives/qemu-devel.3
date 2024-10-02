Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1385DCF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwyP-0006V4-Fx; Wed, 02 Oct 2024 06:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1svwyN-0006Uc-6l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:52:47 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1svwyK-0003rT-Ik
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:52:46 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 6956af8c
 for <qemu-devel@nongnu.org>; Wed, 2 Oct 2024 13:26:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=message-id
 :date:mime-version:from:subject:to:content-type; s=dkimselector;
 bh=uhwPRJ/2Gh2gfpWcvuafszH87WY=; b=xWiTSJ5+pyUsD+N8vO8lWZsFIBhP
 2p/bcM+Kq7n9nsSakifx4mPl6si6G+dEfOBgO+qkG0b0GWCI0vuP5kUYx2JH5Zz+
 8YiLNYbs+BY2Odh8JTHolwAvmK1OfgEcatNanQeTmHnd1bwR1wREEP0/ydz7F0MJ
 kD5MCFihRhIgbcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=message-id
 :date:mime-version:from:subject:to:content-type; q=dns; s=
 dkimselector; b=cKjtV0TobMrCpRS2wKd5jtzu+oK7L2R5NTUGlNQbzi+t4D3J
 HTe4L+6PjriexnBm08RO7hT0uMl2gpJcNGp02MP2lwA9M1HY7Ak4ZfPGefBCQDXU
 1IyhNrZxFVcyQ7u2DNeUukvlDheE7TcoTtOBqHeCG8xgBRIDewhSf8FbTRk=
Received: from [10.137.0.39] (<unknown> [154.47.30.154])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 468f1824
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
 for <qemu-devel@nongnu.org>; Wed, 2 Oct 2024 13:25:59 +0300 (EEST)
Message-ID: <a5c8b6f0-7675-4063-a48f-ffd96180d431@quyllur.org>
Date: Wed, 2 Oct 2024 05:25:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rot127 <unisono@quyllur.org>
Subject: Capstone v6-Alpha is released
To: qemu-devel@nongnu.org
Content-Language: en-US
Autocrypt: addr=unisono@quyllur.org; keydata=
 xjMEY7wq3BYJKwYBBAHaRw8BAQdAsuxTQjfbARGo4F2Egj2t3sSK2cbhl5w744NBKJJRi/PN
 HFJvdDEyNyA8dW5pc29ub0BxdXlsbHVyLm9yZz7CkwQTFgoAOxYhBBVvnxKqKhsnIpRsAsep
 z77sou9aBQJjvESaAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEMepz77sou9a
 WdEA/jVTgTB6GTphNhqA3UoUjkRXDhLDcaNWbgVZqUU7jHIGAP0XFDgu8B8170B83LiTVrIe
 0d9v3AGanC6ur+kO2ts4B87AzQRjvDrnAQwAp27wT6kz0YywKLXtV7ZQ781KE9OR3sP/Shhh
 lpXa7fr8nBDlR5R6nK+H8VybMFG8B43Dtwmv6G94xZIlAv9HU/JfNZcArdHFrX/et7Bk1j+R
 MyoPcf9Hw5Xl7442PiCDPjbnOPtLtxOWTNSBHNQBtGm3K1H8KYOMuKdh+4coWyZJrrfxpqVF
 fyYOPU0Q/XvXqKGjn478IGb4EsP00x6nGxj28CfgSbuSELmTJWNX9PHGcquJn9tFb4frflaq
 LaEGXUM85MSXvbl1rtDm3jHwfBS94Hj0jVo0mnlJeIcZ4OyfGJ1cL3Ub0YLICKdeng3xY2V7
 qb+RxoiE7T0+O/pKWCwBVinlF0UUW9SAIoWgN174NeYYfIU0bTk6TP8RXPETPC9VmigTr52D
 kgftUlGbfG7elARfDBvwHoaHvZbr9GQVasvlbJiyaGnrV6ySeSaEL0YbUsdI7ogwVwH9dWLQ
 W0fsqCQWavSapz3pkV8SOlKmdfmuCQc4Wni+mW9B3vyDABEBAAHCwXQEGBYKACYWIQQVb58S
 qiobJyKUbALHqc++7KLvWgUCY7w65wIbDgUJA8JnAAHACRDHqc++7KLvWsD0IAQZAQgAHRYh
 BGhy9Q1ij6yxegWz3jgSuCWIEK9nBQJjvDrnAAoJEDgSuCWIEK9nDE8L/2Sy8kZZ3WJvsRMW
 AxPlpovhPIWB2doN2sPCCQ9TGZOEYJ6Ge4Peid5RJH6iSl3W0/K/59dG+s0ZABXzQOoo5yOQ
 zMr5V5+YPkW2Cvzpyc3iJLHXduxIGl6J4d8bFfPy+rAAt4ALz8Hr5OGrLj4viYjBifXRwux8
 Ifq3u8C6Qy5u/uagGIFxMgczana+O+w1JDFA/kRem209LgzZZByWXLAO5yc2VtbKdWkiL2vc
 EfGo1znoD2V5Js647Y9z0bMdtSvzwf/dqzINDLP3jODGgivLqU4Z+DMBWtO0JOQjnaDC5Geq
 ereJa78jtMSShmvG3KmrocEE1JZpZ6rxAsgHBTv5j5nZAG+FWeyyQowfiIiqXJo2K/SjjUYw
 Yk843Wg0fmwZYmzqaeXE26l9+1skQHuPR89ipZgMUOo228JhnzYC/Dv29tTudJ1DEzO7jUWh
 rIFB4aIf4aIwsoyJS9ByRjS+Gt7gC85J0yevYREwlK+pRWPoERfGLJfLBXBsEkxbINCNAP0f
 aDyLotRx7+8DEw83adqHwyu4GGMHJrOTcLt00pt7nQEAolZ3IJOtoP0wtwwqupaePZjf+cei
 RqM+ZobpFZYy2As=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9G7hj200Qk9ZYT4yopKBJmyk"
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL=0.141,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9G7hj200Qk9ZYT4yopKBJmyk
Content-Type: multipart/mixed; boundary="------------DwVMHwXnyIkAV6pWH0tYWH1Q";
 protected-headers="v1"
From: Rot127 <unisono@quyllur.org>
To: qemu-devel@nongnu.org
Message-ID: <a5c8b6f0-7675-4063-a48f-ffd96180d431@quyllur.org>
Subject: Capstone v6-Alpha is released

--------------DwVMHwXnyIkAV6pWH0tYWH1Q
Content-Type: multipart/mixed; boundary="------------zyrF05vG6fLtYRfbIbezo7kU"

--------------zyrF05vG6fLtYRfbIbezo7kU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

V2UgYXJlIHZlcnkgaGFwcHkgdG8gYW5ub3VuY2UgdGhlIHJlbGVhc2Ugb2YgQ2Fwc3RvbmUg
djYtQWxwaGExLg0KDQpBbHRob3VnaCBpdCBpcyBtYXJrZWQgYXMgQWxwaGEsIGl0IHJ1bnMg
anVzdCBhcyBzdGFibGUgYW5kIGhhcyBhdCBsZWFzdCANCnRoZSBzYW1lIHF1YWxpdHkgYXMg
YW55IG90aGVyIHJlbGVhc2UgYmVmb3JlLg0KSW4gZmFjdCwgaXQgc2hvdWxkIGJlIGV2ZW4g
YmV0dGVyIGJlY2F1c2Ugd2UgaW1wcm92ZWQgb3VyIHRlc3RpbmcgDQpzaWduaWZpY2FudGx5
IChjbGFuZy10aWR5LCBBU0FOLCBWYWxncmluZCwgdGVzdGluZyB0b29sIHJld3JpdHRlbiku
DQoNCkkgcXVpY2tseSB3YW50ZWQgdG8gbGlzdCBhbGwgbmV3IGZlYXR1cmVzIHRoYXQgYXJl
IGxpa2VseSBvZiBpbnRlcmVzdCB0byANClFlbXUgZGV2ZWxvcGVyczoNCg0KLSBVcGRhdGVk
IHRvIExMVk0gMTg6IEFBcmNoNjQgKGZvcm1lciBBUk02NCksIFN5c3RlbVosIE1pcHMuDQot
IEFkZGVkIE5hbm9NaXBzIGV4dGVuc2lvbiBmcm9tIHRoZSBNZWRpYVRlayBMTFZNIGZvcmsu
DQotIFVwZGF0ZWQgdG8gTExWTSAxNjogQVJNLCBQUEMgLSBVcGRhdGUgdG8gTExWTSAxOCAo
b3IgbGF0ZXIpIHdpbGwgY29tZSANCndpdGggdjYtQmV0YS4NCi0gTmV3IG1vZHVsZXM6IFh0
ZW5zYSwgTG9vbmdBcmNoLCBIUFBBLCBBbHBoYSAoYmFzZWQgb24gTExWTSAzKSwgVHJpQ29y
ZSANCihzaW5jZSB2NSkuDQotIFBQQyBQYWlyZWQgU2luZ2xlIGV4dGVuc2lvbiBhZGRlZC4N
Cg0KWW91IGNhbiBmaW5kIHRoZSBmdWxsIHJlbGVhc2UgZ3VpZGUgd2l0aCBhbGwgZGV0YWls
cyBoZXJlOiANCmh0dHBzOi8vZ2l0aHViLmNvbS9jYXBzdG9uZS1lbmdpbmUvY2Fwc3RvbmUv
YmxvYi9uZXh0L2RvY3MvY3NfdjZfcmVsZWFzZV9ndWlkZS5tZA0KDQpJZiB5b3UgYXJlIGlu
dGVyZXN0ZWQgaW4gdGhlIGRldGFpbHMgb2YgdGhlIG5ldyB1cGRhdGUgZnJhbWV3b3JrIA0K
QXV0by1TeW5jICh3aGljaCBtYWRlIHY2IHBvc3NpYmxlKSwgeW91IGNhbiByZWFkIG91ciBi
bG9nIHBvc3Q6DQpodHRwczovL3JpemluLnJlL3Bvc3RzL2F1dG8tc3luYy8NCg0KUGxlYXNl
IGxldCBtZSBrbm93IGFueSBxdWVzdGlvbnMgeW91IGZvbGtzIG1pZ2h0IGhhdmUuDQoNCg0K

--------------zyrF05vG6fLtYRfbIbezo7kU
Content-Type: application/pgp-keys; name="OpenPGP_0xC7A9CFBEECA2EF5A.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC7A9CFBEECA2EF5A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
okajPmaG6RWWMtgL
=3DJky5
-----END PGP PUBLIC KEY BLOCK-----


--------------zyrF05vG6fLtYRfbIbezo7kU--

--------------DwVMHwXnyIkAV6pWH0tYWH1Q--

--------------9G7hj200Qk9ZYT4yopKBJmyk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEaHL1DWKPrLF6BbPeOBK4JYgQr2cFAmb9H68ACgkQOBK4JYgQ
r2fEnwv+P7QDgtyOkCN4e9pTcfVyHgm+Evk264aGvV0v3Yq7WKyDZVbqIyewcjKL
Bxp6vC6pOBrfoZIANW+eNaV5v/j5YS0fk8WMAycVZZKS+GYsfM7s6Et8uB45lF8f
Q1Zb1KX4K4S/g5rl7nY/Dcg4EuRLbearx5VnJ4fJUZgpB30tNICEbMAW7Ilga9af
8Sjj1wLh7p4NYdkmbvRqmu04hXOqa5qZ249mupFAfcArq8oJu2NseDmPPldcE83S
pHg7yAH5cr2SkCSV7bd8oVxNGj0l57T99jDMM4lfUM806SXNEltnsfSCXMidDw5K
cFBPSq3m9uAQFAPQy7gKSuyKxbbloY9Wov3l75+9tfD+NQteKv5nlehMK1PQdXyu
Ne142dL0bTVT7FvfcZ2V96Q7mYehNJyKTYGhe9QClLeTwScAek9O//sKm5SLPBOu
mqoZfGc8r45oDz2Lk0LaVEEe3y+ZoVTDIZm7G+mtzf08vIXZkfysBRwCJvACWFWG
ZBMgUTS5
=5L0Q
-----END PGP SIGNATURE-----

--------------9G7hj200Qk9ZYT4yopKBJmyk--

