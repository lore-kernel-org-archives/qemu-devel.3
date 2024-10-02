Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFE2CF6D21
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzEl-0001b7-VR; Wed, 02 Oct 2024 09:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1svqem-0005DH-TL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 00:08:09 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1svqek-0003vQ-3U
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 00:08:07 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 5db46bc8
 for <qemu-devel@nongnu.org>; Wed, 2 Oct 2024 07:07:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=message-id
 :date:mime-version:from:subject:to:content-type; s=dkimselector;
 bh=4wL8pnI8nf37S7XRi3737JmmH7U=; b=UmU1jiL1INfkXy4tFC81LUxbBdoz
 o8VJyCNi9U83R5Oqv8td+wB1WDrLGrSmkft7bT2M71EHap+U5ioJH5kFnaXoGzEh
 NBxrawrg4ESQPZNw0aGSLH2Rma3K2vrDRm+upxv84zg/bepsrJLdPuQ9u8qhH6UH
 /zMPkH0YzS0R/Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=message-id
 :date:mime-version:from:subject:to:content-type; q=dns; s=
 dkimselector; b=y8qxzpRWXecgR51ukRpmN682ZVODAVppRCwSA1cnUyDsFu/c
 8meZjXlA16s6iNpJHu4vzC8CjwAEKKHVFu3uxRTQRKd88PiJfkdkaOjCOZrNAGLq
 f4AC4POjcoSr36n0BVFrQMPxtw0f/6NteILhPseP5bUlVMV4+ZAPryM7EFw=
Received: from [10.137.0.39] (unn-154-47-29-26.datapacket.com [154.47.29.26])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 7f8cf8fb
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
 for <qemu-devel@nongnu.org>; Wed, 2 Oct 2024 07:07:59 +0300 (EEST)
Message-ID: <d4e5202c-00d0-446c-8b23-d0d31ed3235b@quyllur.org>
Date: Tue, 1 Oct 2024 23:07:55 -0500
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
 boundary="------------kEMdO7qX7kfHNItN432OKCvI"
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 02 Oct 2024 09:17:43 -0400
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
--------------kEMdO7qX7kfHNItN432OKCvI
Content-Type: multipart/mixed; boundary="------------cWA4B45w2F9Ub3f2hKdwGRAs";
 protected-headers="v1"
From: Rot127 <unisono@quyllur.org>
To: qemu-devel@nongnu.org
Message-ID: <d4e5202c-00d0-446c-8b23-d0d31ed3235b@quyllur.org>
Subject: Capstone v6-Alpha is released

--------------cWA4B45w2F9Ub3f2hKdwGRAs
Content-Type: multipart/mixed; boundary="------------p4SdXcGxVYqUE8hT0TDQOhN0"

--------------p4SdXcGxVYqUE8hT0TDQOhN0
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
IGxldCBtZSBrbm93IGFueSBxdWVzdGlvbnMgeW91IGZvbGtzIG1pZ2h0IGhhdmUuDQoNCg==

--------------p4SdXcGxVYqUE8hT0TDQOhN0
Content-Type: application/pgp-keys; name="OpenPGP_0xC7A9CFBEECA2EF5A.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC7A9CFBEECA2EF5A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
okajPmaG6RWWMtgL
=3DJky5
-----END PGP PUBLIC KEY BLOCK-----

--------------p4SdXcGxVYqUE8hT0TDQOhN0--

--------------cWA4B45w2F9Ub3f2hKdwGRAs--

--------------kEMdO7qX7kfHNItN432OKCvI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEaHL1DWKPrLF6BbPeOBK4JYgQr2cFAmb8xxsACgkQOBK4JYgQ
r2d6gAv8D6zgdhDY7cRbEoPfzZkLhzVR/snXjueOW0lwvToVrCssRoPtXbNTGxC4
KCfRfsO3lWabAky5wXaQSs6cT8JSjYjDv1NzkC1IWfARC+hzIuLrzOBBPVMKxS85
VlRfoc0n4T4n0YTQeNfHpZydeAyYjRFGeeeUjPoJIffRqxUXkJ5OrVvuA+emjPkZ
f9Oljo4N71YYr1KlVoQO9EnmOVsuAU/61LhR2rKLzlWNy9Fkelor0M8qe89/ROc+
nmCcSTfYbNAcKZjxK983f/G0ZCEi4JDKlbBoxx7FmUXsIimTxl2Eb+VeXQDJZI/y
EZlIxgGDQJlinNjr0Q/VYDcnug8ddHFpG2G8KIh8oJSBKfJ+coZ8qmpbSW36/wEX
TMZP4XMmFZEYLFVMvWqlXu7jCs9qPL8UQkSeGw4M0uoY2ODHjB+8NVb/eIQxagV2
VQ2DTChQatQgnNdNkzp7FZd1YhApLdE4ZM0fPT09mef9kj0LCoV3igI9dnwTAS60
aDJ80oXw
=uNT6
-----END PGP SIGNATURE-----

--------------kEMdO7qX7kfHNItN432OKCvI--

