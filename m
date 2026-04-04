Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E3E88D70
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 06:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8uQ5-0004j3-25; Sat, 04 Apr 2026 02:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w8uKI-0006YN-UV
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 02:17:50 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w8uKH-0008AR-3t
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 02:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775283454; x=1775888254; i=deller@gmx.de;
 bh=hxCMSM27LqZJbVwbmmL9cwUctSFZMj+oonYCL6ulF94=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r+9SYucg7UZOPgEaJFzYzyLR/wLlPGIv4v7mpEORABkks+0npmLhKeEIAFhLQ3z3
 NGPwsZPLih1mBdTzrbz29xG7AlW/NDWK2EUc6UhstJsDZL7//sgp7LiJUvjMtaoWR
 vDcrJKwh9015fa9ZNkHKSv/GX6QQIdCUNW+FtZas6jRVsYynlFKhvlafxiSgWPo5o
 XSafkXS33q6qwtPayTYB7IAr7Itwus/eUl+xnSZXWPlnqXVE9gQTd7lKy+EorfiRD
 wuh5IySeqw+cZc8/ZxvEfFui36OvGG7WMUFaI09ati5Aj5wL5E+QN6rgDb2jGG8eB
 4VHjzYkApb9bvJjMZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9Mtg-1vNWFm2388-011oLX; Sat, 04
 Apr 2026 08:17:34 +0200
Message-ID: <bd71193d-1023-4208-8786-e32e6277d261@gmx.de>
Date: Sat, 4 Apr 2026 08:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: Allow building qemu tools on 32-bit hosts
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260402132801.16053-1-deller@kernel.org>
 <027b8930-0e78-4501-b412-37128d299d01@linaro.org>
 <3cd32e06-b0e9-44b0-9828-dd9fa39b31c3@tls.msk.ru>
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
In-Reply-To: <3cd32e06-b0e9-44b0-9828-dd9fa39b31c3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Z29vFsM3AyxwQfXVQVyjVEib2+Aa7W+H6lAMMUAjZMkHuuXqdS
 y5fnToPvpxjxVJDFzm7O5Hbf6wqjkk9jIl77gAiFb20MB9qrtCGxmJxWwiXdIxBdGfS+19B
 7ANpdLQvnKv/zyYHUb46hyMtOVi1W1Gw3/9YG/Vn4zLirZYfa48ZOjGeXb0kt2HySO7PcwO
 knSGI4Y9N+OfCtEstbQFw==
UI-OutboundReport: notjunk:1;M01:P0:5L6o7sJlVXw=;g/J5Tp9sGDph+9Aj236lAKpcccW
 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
 5SFiowDZmYs
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/4/26 07:46, Michael Tokarev wrote:
> On 04.04.2026 02:10, Richard Henderson wrote:
>> On 4/2/26 23:28, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Qemu's tools like qemu-img are often needed on 32-bit platforms,
>>> although the actual qemu emulators have been discontinued on 32-bit.
>>>
>>> To allow building the tools on 32-bit this patch implements two small
>>> changes:
>>>
>>> a) The check in meson.build is changed to still error out if the user
>>> tries to build qemu-system or qemu-user on a 32-bit platform, but allo=
ws
>>> building tools (e.g. by "--enable-tools") alone.
>>>
>>> b) Remove the compile time checks in atomic.h because:
>>> - for the qemu-system and qemu-user emulators this check is redundant
>>> =C2=A0=C2=A0 since we only allow 64-bit platforms anyway (see a)
>>
>> No it isn't.=C2=A0 It double-checks that we don't pass e.g. Int128.
>=20
> Well.=C2=A0 In current qemu 11.0-tobe, this compile test passes already,=
 so
> there's no code *currently* which pass an Int128 to atomic_read.=C2=A0 T=
his
> concern can be adjusted at the start of 11.1 development cycle, - with
> a check which has been thought about.=C2=A0 Right now we're too close to=
 the
> release, so more invasive changes is not a good idea.
>=20
> With the current check in place, it's completely impossible to build
> even the qga on 32bit platform, which is quite a drastic change.

I've just sent a patch which I think addresses Richard's concerns.
It actually implements his suggested fix to check against uint64_t instead=
.
 =20
>>> - it breaks those 32-bit platforms, which do provide (slower) 64-bit a=
tomics
>>> - 32-bit platforms without 64-bit atomics will fail instead with linke=
r errors
>>> - the runtime speed of the qemu tools aren't actually that important.
>>
>> Only i686 and armv7 have these.
>=20
> I've built it on most 32bit platforms on debian, including tests.
> It failed in the end on m68k, powerpc and sh4 becausse I forgot to pass
> -latomic there.

This is fixed in my latest patch as well.
I actually tested on powerpc...

>> I agree that other 32-bit hosts could fall back to libatomic, but we'd =
need to actually use it.
>=20
> It can be added in --extra-ldflags at the very least, - there's no need
> to rush for that this late in the release cycle.
>=20
>>> I've sucessfully tested building qemu tools on 32-bit hppa.
>>
>> Really?=C2=A0 So where does the 64-bit atomic come into it?
>> Was it in code that was compiled but not actually linked?
>=20
> In my case, it builds qemu-img and qemu-nbd fine, - so there, yes, that
> code isn't used.
>=20
> But it fails to link qga:
>=20
> ld: libqemuutil.a.p/util_qsp.c.o: undefined reference to symbol '__atomi=
c_load_8@@LIBATOMIC_1.0'
> ld: /usr/lib/m68k-linux-gnu/libatomic.so.1: error adding symbols: DSO mi=
ssing from command line
>=20
> maybe that one also isn't needed for qga link, - I saw these results
> just now, will take a closer look later today.

Try the patch (v2) I sent...

Helge

