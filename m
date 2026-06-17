Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02C0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZugZ-0006KH-4F; Wed, 17 Jun 2026 14:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZugQ-0006IF-8A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:08:15 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZugO-0004hz-Du
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781719689; x=1782324489; i=deller@gmx.de;
 bh=Y7/wIkIkIvR7f/sxxtLJ7jZOyKsw8qlNX7DptkZ9ODo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JWrZekX3OMCtUH5r0ASSE7aj94GK1cgQS8hrYITKQzkOAzD6rB06qkhv6ag2cO/+
 CZIu/o0+XJcBs7lIpJnJFHttncHUws18rnXfiDkvCvPnqfxNMHxsnzMdMUf2wh7IZ
 ootDbwvpuvSgz3h2cMhAgYbx92jIzioqwZF0Wdy80Q+C/0OSlNsMTa2VtHqeqvFzI
 ZXPRJU1KwagxXiyT5o6OjAwxIM5ruHWiYJVMFvGNHF9HZGuLKeZiF8pM7tfh0cy66
 uLCzzG0WaPfGS+BnBW6sCU9kD0y5tJdIiDFdc5cZsnjbceLo8+SrZsotQA3BXPI6y
 CTbORQ0Gaxao40y2lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1xU5lk0FZN-011ZUS; Wed, 17
 Jun 2026 20:08:09 +0200
Message-ID: <1536f212-a5f4-425e-b647-67a01c418266@gmx.de>
Date: Wed, 17 Jun 2026 20:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] common-user: Move mmap_min_addr from linux-user
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-7-richard.henderson@linaro.org>
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
In-Reply-To: <20260616212055.334466-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s/zzBry7lZovKRszdOrb9oO/q8A69KoimM+h1WkdJ54IPWdoWkd
 vuU0T1MbeEeAr5hHpZT3/YoY3hThpEXsp+hkQyUE7wIrPWEldVp7j8eiH5jkoteWs8BXyYb
 pW9/Cz6h3Fst87RoWuhlU1NvWUNDU2QiuQgHBpVijEOEPZyqAGZODooa3uJl/DFR9c5Lh1i
 5gHVMIN1d2lqOdb7e5uXQ==
UI-OutboundReport: notjunk:1;M01:P0:tzewwmWpfo0=;lnv07Jj9zM1br40OxcMx851fzkH
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/16/26 23:20, Richard Henderson wrote:
> Introduce user/mmap-min-addr.h.  Initialize the variable
> from a constructor instead of main.
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Revied-by: Helge Deller <deller@gmx.de>

> ---
>   include/user/mmap-min-addr.h | 12 ++++++++++++
>   linux-user/user-internals.h  |  1 -
>   common-user/mmap-min-addr.c  | 37 ++++++++++++++++++++++++++++++++++++
>   linux-user/elfload.c         |  1 +
>   linux-user/main.c            | 33 +++-----------------------------
>   linux-user/mmap.c            |  1 +
>   common-user/meson.build      |  1 +
>   7 files changed, 55 insertions(+), 31 deletions(-)
>   create mode 100644 include/user/mmap-min-addr.h
>   create mode 100644 common-user/mmap-min-addr.c

