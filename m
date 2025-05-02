Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E54FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtEw-0003MO-RA; Fri, 02 May 2025 12:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uAtEv-0003M1-IV
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:27:53 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uAtEt-0006nA-8F
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746203265; x=1746808065; i=deller@gmx.de;
 bh=ar/Yu+me9YfsoJ21xcuRXzzmodcjKoD+2VXb417ffqI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EfJeDAVJ6cZ648HZXbvcsE+AVJ42KuP7eJvQAoxhxt1gaKuvQ63Pu3kBG4WaiJj5
 0taYZVewwNAsf03bxRgoWdnfWVgeFTM54nKQoU8xvAFDpWOX86T8WXZMmFHQX0Ti5
 RE5fVlpbdFcbOZTjlrMntbsWpTkc4hK2ohet0GZ17BbvMw7Jl3p7Kk1A+0Lf/hLod
 hpDp7Rrp5VktVpdLskOVavPATJ6pbVbjl/jmXSlYTAKr3nFUWbTD4TJ5uc0B1mhhx
 637t+ArgLNrDPTOU1zE3laKEQER0Nap57nH3WKrwjN0QOc0/qjuWgyWPw//pCNPA2
 9n4GxHkXYU1GYlVu8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1uUd323fJY-00ITVV; Fri, 02
 May 2025 18:27:44 +0200
Message-ID: <5aaf6f27-1157-4f2c-b16b-eb28b07a71eb@gmx.de>
Date: Fri, 2 May 2025 18:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char/serial: Remove unused prog_if compat property
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 philmd@linaro.org
References: <20250502095524.DE1F355D264@zero.eik.bme.hu>
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
In-Reply-To: <20250502095524.DE1F355D264@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4I+VYuN3RtkRGxMijqfRmOr/8NqtdHqXaXwgtoFK7P8ymvUfvYS
 XXgBfLsUsoc5RB6o+NPtIGdmc0kmwkrEEwZiNqxQDQSeM7Scldl97kyfzYFQ1B7BygZaYTq
 ANsd0XFvq+7BH1beIA0Z0J2BPkEgc6EmNnLFYe9jsr1R6oqWzA/1Wpi/64v7XAkhzmnybJi
 rAOIpeKlXUVIRrg66/bRg==
UI-OutboundReport: notjunk:1;M01:P0:h9liClKCSOs=;wkvGYbZqyoEAWvanrugOy5Q7gAJ
 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
 EI44he6G81gNgzT7jIxUhI=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/25 11:55, BALATON Zoltan wrote:
> This property was added to preserve previous value when this was fixed
> in version 2.1 but the last machine using it was already removed when
> adding diva-gsp leaving this property unused and unnecessary.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v2:
> Reword commit message, add Rb tag
>=20
>   hw/char/diva-gsp.c         |  6 ++----
>   hw/char/serial-pci-multi.c |  7 ++-----
>   hw/char/serial-pci.c       | 10 ++--------
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

