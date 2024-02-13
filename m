Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9998DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyGn-0008SK-Ge; Tue, 13 Feb 2024 14:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rZyGk-0008Rd-Io; Tue, 13 Feb 2024 14:16:38 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rZyGi-0001ez-EF; Tue, 13 Feb 2024 14:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707851789; x=1708456589; i=deller@gmx.de;
 bh=kfjod4PYv3cQkBE5h8W+F9BYajkOakBT0WtcZkW28eg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Ec75T1bbdthdfXnzdO46uXhXMm4QLThiuwUTvH5JrhRTgN+N9GYSangNxY53SmEB
 yhSoBYIdIx+4skuSRoZv0ZcLe+qFg9LJYJUs5GBz2o1PHiiyAnD4YlZ3In2EeWiBp
 16Z8xHokdG6crlzdhgkBdgIorY4q7blzsRAg6lPhoUWbMm7zdwJbqAdpcPy+qwBcN
 C9Z+Ju4gQ2GC9wDebk6v4bnZHxnEIjPAzgpoRcVfxbXztaWcjXO08r1bAOC+t8oDH
 /aoCsPKMH8xP+jvD/bngtXoLaUxw6VBuLe5C3VVbaC8bs/lIiFIWS83OMzAU/OqyX
 nfbmROgSpirgLX5Eng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.153.170]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1rZQIp0ep8-000bGX; Tue, 13
 Feb 2024 20:16:29 +0100
Message-ID: <b3be66b3-d032-4dec-ac47-0c2b41bd95cf@gmx.de>
Date: Tue, 13 Feb 2024 20:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Hppa64 patches
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240212234723.222847-1-deller@kernel.org>
 <675576ad-ef02-4791-8ad5-08d8ab2b710a@tls.msk.ru>
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
In-Reply-To: <675576ad-ef02-4791-8ad5-08d8ab2b710a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GJBfLpMYYJWEXKWgTlv+EDK0TGY8Lw8qXuWhizcO0Fbvx502I30
 maeGV4pw1Vi1u13TVYU4NSK2HhCA2bHKTG3wVi6ROMU5P9h/JPe3Mkg1hkkpWwdjH34LU3r
 NK45MqtHFLWi6h/LCpdBftEt71tML0QU76KS22CjLlXsGOO5KxNmUvWg7+xsy2iNQKSaNxa
 T+ieSnN22Y9iDu4UoS7nQ==
UI-OutboundReport: notjunk:1;M01:P0:k5B4VEbgbCU=;jNpcVMEFXbZYkwn+M3v89KsiHT3
 Nlz6ywle601znKg5oeeheZiP8jZw/1P+MQeFfeSRAtHp716/OKcl5AuyHJbki3IsN82VqwnHC
 U9anLaFM+Szk0QiWO+eqnWMoOsrVsJeH4y0QZKnScUQ6gOyWEHRKk22RaIVPCAntyMmCG81cx
 f7zeKSlcwxuxk430ypPCumUj6P+aDlYO0dCigieAxdaD7OfCowe0kDPapiJly6+WYxEpf6c/O
 TXEmyrsU6RbKoUL37HKdmqixtUpi+CUvbQBPvdwm+aB1pBLMC4hbtVVxhYft/lsPxr6p79LyP
 JKnsdVuOOdQ4ACxIgCUzos7UyoKQTce+rgMsFja0RMMqyf97XqXS8q7Gg4p07p2kPS+23r7+F
 nej/OWh2vszIxzlcyMg1RiO2dCzwPJO+RccAudsao8RcpfdyXthzrY91PPuCbsmaDVS3NbaCP
 3QEk9Mhn/cKHPN05cvsNSkiZEyHLVaU9VAwXJsBmG2RQEXhdqwtSsNKePTXDq4wxKuCjk3B8I
 JybD3QK0TJ/sB5oJelqz/de+yYxaaRW5AVRZhmKj9IZUPuPsvAS6O+w9OsxRH3C8UvLzTYGX9
 UxMlG8rPRMm6SH7PddcAoMMiv07eibg2DNW3VkM9ydPnxASPO8ZrPZV8DPBYYqkhxO2vDr+S0
 nmqmXM+yu9E32PYkIIPTIfbYRUt9870kvUAbzJ2PS/oOtd5XDY2/5KCs6P4SPYyVoAA6j/yVX
 wTRyMeiR6TflfqdkmY8GwItd/87+KdwsXsWUltNanU2FZBOpu+yFfht3fbjC+3+hDrfYUfcH1
 0sy1rwsbZBL0CGLl0cfDOSUyvZVvhZ6fZAPgwQl9aBVDA=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/13/24 19:09, Michael Tokarev wrote:
> 13.02.2024 02:47, deller@kernel.org =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> From: Helge Deller <deller@gmx.de>
>>
>> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c8=
7440:
>>
>> =C2=A0=C2=A0 Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qem=
u/armbru into staging (2024-02-03 13:31:58 +0000)
>>
>> are available in the Git repository at:
>>
>> =C2=A0=C2=A0 https://github.com/hdeller/qemu-hppa.git tags/hppa64-pull-=
request
>>
>> for you to fetch changes up to a9314795f068515ff5925d0f68adf0a3215f6d2d=
:
>>
>> =C2=A0=C2=A0 hw/hppa/machine: Load 64-bit firmware on 64-bit machines (=
2024-02-13 00:44:06 +0100)
>>
>> ----------------------------------------------------------------
>> target/hppa: Enhancements and fixes
>>
>> Some enhancements and fixes for the hppa target.
>>
>> The major change is, that this patchset adds a new SeaBIOS-hppa firmwar=
e
>> which is built as 32- and 64-bit firmware.
>> The new 64-bit firmware is necessary to fully support 64-bit operating =
systems
>> (HP-UX, Linux, NetBSD,...).
>>
>> ----------------------------------------------------------------
>>
>> Helge Deller (11):
>> =C2=A0=C2=A0 disas/hppa: Add disassembly for qemu specific instructions
>> =C2=A0=C2=A0 target/hppa: Add "diag 0x101" for console output support
>> =C2=A0=C2=A0 hw/pci-host/astro: Avoid aborting on access failure
>> =C2=A0=C2=A0 hw/pci-host/astro: Implement Hard Fail and Soft Fail mode
>> =C2=A0=C2=A0 lasi: allow access to LAN MAC address registers
>> =C2=A0=C2=A0 target/hppa: Implement do_transaction_failed handler for I=
/O errors
>> =C2=A0=C2=A0 lasi: Add reset I/O ports for LASI audio and FDC
>> =C2=A0=C2=A0 target/hppa: Allow read-access to PSW with rsm 0,reg instr=
uction
>> =C2=A0=C2=A0 target/hppa: PDC_BTLB_INFO uses 32-bit ints
>> =C2=A0=C2=A0 target/hppa: Update SeaBIOS-hppa to version 16
>> =C2=A0=C2=A0 hw/hppa/machine: Load 64-bit firmware on 64-bit machines
>>
>> Sven Schnelle (1):
>> =C2=A0=C2=A0 hw/net/tulip: add chip status register values
>
> Is there anything in there which is relevant for -stable?

Ideally all patches.
At minimum the tulip patch.

Helge


