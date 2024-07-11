Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA092C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRnnr-0002bx-BZ; Thu, 11 Jul 2024 03:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1sRnnl-0002b3-Qu
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:01:13 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1sRnnh-0006dw-Rw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:01:13 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id b6e48450;
 Thu, 11 Jul 2024 10:00:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=message-id
 :date:mime-version:to:cc:references:subject:from:in-reply-to
 :content-type; s=dkimselector; bh=kYx0NPL0XNIke7iEa4tgnjD8Mb4=; b=
 fxcZtWvalo7tYn/Sv0AFpktBgU85Dx2Nlo9WaFGuAl5J4wE3C89xFNWlfEZDRTjg
 bFe1i6FiO7g54s6DJK1lswiSqRZ+VgCwysxIRd5GB6TQup47IVy4boVcF6K1MmTy
 DFaIdH5XxTAk1er4Ux++lrjgmiYBp8XINZ23JKzA5E8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=message-id
 :date:mime-version:to:cc:references:subject:from:in-reply-to
 :content-type; q=dns; s=dkimselector; b=CNJiYHUELEBQ+UyzfpmS67qe
 gauvr6CjuVnEtxgMfvcMwkIcOeaV9ayHE7Veek0UzqInUHqmDkTi5fxygiZhogwQ
 Es8T1TxLff/I/XYQZOc1HjgW6AcAaWfZJHjf1pyJjfKpLJ5eevaTuhkaGvY+tDCd
 V0i1fF+peZuJIs040hQ=
Received: from [10.137.0.39] (s176125235119.blix.com [176.125.235.119])
 by quyllur.org (OpenSMTPD) with ESMTPSA id a8298d5f
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Thu, 11 Jul 2024 10:00:50 +0300 (EEST)
Message-ID: <9063fd23-8b5a-4f46-bf74-f37b0eae83b9@quyllur.org>
Date: Thu, 11 Jul 2024 02:00:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: richard.henderson@linaro.org
Cc: mrm94040@yahoo.com, qemu-devel@nongnu.org
References: <bb7c5d11-f358-4680-9418-cbb8d596e943@linaro.org>
Subject: Re: Disassembler location
Content-Language: en-US
From: Rot127 <unisono@quyllur.org>
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
In-Reply-To: <bb7c5d11-f358-4680-9418-cbb8d596e943@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zv8ztg9JOwnj59zUZgTEJAQ2"
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
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
--------------zv8ztg9JOwnj59zUZgTEJAQ2
Content-Type: multipart/mixed; boundary="------------39Lzw87zPkxtHvEjkimDLafW";
 protected-headers="v1"
From: Rot127 <unisono@quyllur.org>
To: richard.henderson@linaro.org
Cc: mrm94040@yahoo.com, qemu-devel@nongnu.org
Message-ID: <9063fd23-8b5a-4f46-bf74-f37b0eae83b9@quyllur.org>
Subject: Re: Disassembler location
References: <bb7c5d11-f358-4680-9418-cbb8d596e943@linaro.org>
In-Reply-To: <bb7c5d11-f358-4680-9418-cbb8d596e943@linaro.org>

--------------39Lzw87zPkxtHvEjkimDLafW
Content-Type: multipart/mixed; boundary="------------Oz0KxE1jnuqgOts0IwJFO1ny"

--------------Oz0KxE1jnuqgOts0IwJFO1ny
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RnlpIHBsZWFzZSBub3RlIHRoYXQgTG9vbmdBcmNoIHN1cHBvcnQgd2FzIHJlY2VudGx5IGFk
ZGVkIHRvIENhcHN0b25lIA0KKGh0dHBzOi8vZ2l0aHViLmNvbS9jYXBzdG9uZS1lbmdpbmUv
Y2Fwc3RvbmUvcHVsbC8yMzQ5KS4NCg0KQWxzbywgaWYgeW91IHdhbnQgdG8gYWRkIHN1cHBv
cnQgZm9yIGEgbmV3IGFyY2hpdGVjdHVyZSBpbiBDYXBzdG9uZSBhbmQgDQppdCBpcyBzdXBw
b3J0ZWQgaW4gTExWTSwNCnlvdSBjYW4gdXNlIG91ciBuZXcgQXV0by1TeW5jIHVwZGF0ZXIu
IFNlZSANCmh0dHBzOi8vZ2l0aHViLmNvbS9jYXBzdG9uZS1lbmdpbmUvY2Fwc3RvbmUvaXNz
dWVzLzIwMTUuDQoNCg==
--------------Oz0KxE1jnuqgOts0IwJFO1ny
Content-Type: application/pgp-keys; name="OpenPGP_0xC7A9CFBEECA2EF5A.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC7A9CFBEECA2EF5A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
okajPmaG6RWWMtgL
=3DJky5
-----END PGP PUBLIC KEY BLOCK-----

--------------Oz0KxE1jnuqgOts0IwJFO1ny--

--------------39Lzw87zPkxtHvEjkimDLafW--

--------------zv8ztg9JOwnj59zUZgTEJAQ2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEaHL1DWKPrLF6BbPeOBK4JYgQr2cFAmaPgxoACgkQOBK4JYgQ
r2eI1Av9ElXml2jgObNLXwh7ZUfme3saZPtsyMhGlgPl23ga8anRfP+QOC8sC2RP
c548+c4z5cmCiWhzm5ASd/yunlGTNF5m6msTVt88m3oX7MMU/eY8uy7smb/nyyXP
jIlrZ1nJ23PNKDfY8vYwBdMwCeYwIf3jyHkmz18SlmPeYJVmqSZaWHOpC0j8T+Zc
kW/6TZehtUuiSO0kI7p4QniXC1ih4hHMBOkQ/tF1hJZ3MwB+8bUavcQSDIp+kbF9
inVvghIVLAJ0hIm1Oi5LLJQ4mD5ryx2+h1v3nqvF98H5tuUJSseTSUyOxnxWbwML
W0/dNYkXG4g6ugvq8h8MG9diSOWWZ6Tq9lkpB40w9kU6MghLGtmyS6v0TEl4Hpbk
hhJRMfCdpQ3wNZmBRaDAXFQz2j8ZS0orcIFdiMWilnFujLnzMSbzZExHhfr/I/S/
RfYNoASz5Fc30/hsGGcl0aEY0NlxJkxI0hclaHVIpdIZKjgQNH+60rsbePzr+3M8
H2e7bc8D
=5ZoW
-----END PGP SIGNATURE-----

--------------zv8ztg9JOwnj59zUZgTEJAQ2--

