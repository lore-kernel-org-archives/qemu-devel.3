Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6873C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAsSZ-00034d-BB; Sun, 27 Sep 2026 13:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAsSY-00034V-3y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:14:42 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAsSW-0002Xd-Dn
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790529270; x=1791134070; i=deller@gmx.de;
 bh=BXRsgtPIOUTrfvbDQspD9QqalNkk6rqSKJJJOO58pJU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=evJZJG/KH8FzaJijGfHfWNvmAX3mYf9O8Jwl7+ZOMGZ4QlwqxXi3tKrjkiQEYuZI
 yZuSFb5Zrpq8jG9nIRbJiUqaaB7bgbyCo+/ZmshS1FuAH6ZcusEJWreWhcdE0Gb+w
 yO2//2615LWnm++5y0YpRtC3+nNE7N0s8JDqwKHvJ/EzOzqtUQTWCivnQJx+XNkzw
 Zap+5DX71dNr9SvrrxAs9700YZGRMk0yG0GQNKFJLPPlJMzmxOXZRg/LhfjH00Eah
 UN97F5AltgTrmGh/LKWHTJEDeP/erVYD7rsU9BRhN/F1KtW5aqUyKPpyzBHfmdUHU
 NvPt1Zz+7z0PCOT7uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1xAJQW21s6-004sY2; Sun, 27
 Sep 2026 19:14:30 +0200
Message-ID: <f95b3ad3-d396-4f3b-b5a7-a3c13ed32484@gmx.de>
Date: Sun, 27 Sep 2026 19:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] input/hid: emit protocol aware mouse reports with
 pan support
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-4-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260331170823.72511-4-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Etz1/DX3g5IVtnstVQ2ugLnQSqr86lKPg/QYBgMh9K7+i04xSXM
 OGCla8v33rTQpl0HItc17ZTV6vFn/k+nA5jUCiAkECnu0Ui8+6Dm/ouYw1aaRANtEC5Pz7j
 ByiqgyOpTRaR8pC3dxGGoe9XKze1YMkox/t++JUc5axwc0pAnE4mjEiJR+SvtyZpR0V3F0P
 7i5UVEMImfIQDfL/w2YYA==
UI-OutboundReport: notjunk:1;M01:P0:MHZic2+SSow=;r8Op9OtaCpEScj4tJrdCYMJFX2e
 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
 JO57i5cVehHVXkJFnRy/VC0G0g==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/31/26 19:08, Soumyajyotii Ssarkar wrote:
> Implement protocol-aware mouse report output to support both boot
> protocol (protocol 0) and report protocol (protocol 1).
>=20
> Boot protocol: 4-byte reports (button, dx, dy, dz)
> Report protocol: 6-byte reports with report ID 0x01 + pan byte

pan bytes ? (with "s"?)

> Both modes now support the 'pan' field for horizontal scrolling. The
> distinction ensures correct behavior across different guest operating
> systems and their HID implementations.
>=20
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>   hw/input/hid.c | 44 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index 457dbb0096..d0b7af7c13 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -403,20 +403,42 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, i=
nt len)
>=20
>       /* Appears we have to invert the wheel direction */
>       dz =3D 0 - dz;
> +    pan =3D 0 - pan;
>       l =3D 0;
>       switch (hs->kind) {
>       case HID_MOUSE:
> -        if (len > l) {
> -            buf[l++] =3D e->buttons_state;
> -        }
> -        if (len > l) {
> -            buf[l++] =3D dx;
> -        }
> -        if (len > l) {
> -            buf[l++] =3D dy;
> -        }
> -        if (len > l) {
> -            buf[l++] =3D dz;
> +        if (hs->protocol =3D=3D 0) {

I suggest to add a comment here, e.g. "/* boot protocol (0) */"

> +            if (len > l) {
> +                buf[l++] =3D e->buttons_state;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D dx;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D dy;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D dz;
> +            }
> +        } else {

and e.g. "/* report protocol (1) */"

Looks good otherwise.

Helge


> +            if (len > l) {
> +                buf[l++] =3D 0x01;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D e->buttons_state;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D dx;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D dy;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D dz;
> +            }
> +            if (len > l) {
> +                buf[l++] =3D pan;
> +            }
>           }
>           break;
>=20
> --
> 2.53.0


