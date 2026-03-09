Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FE8F3C263
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaum-000340-TR; Mon, 09 Mar 2026 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vzaud-00033g-F2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:44:47 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vzaub-0005pS-CH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773063882; x=1773668682; i=deller@gmx.de;
 bh=exvYAR6CP4yXkWO8ubbhedcic6276GhfgYQTfjl/hQg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qrThMd4Uxh1xBxxp0yjkJt2hJ8DhLuMBBAYCAmbhxjLrSm71aT7u8irSKbAMLKHI
 QmpSwfVdkmr9ZRLzWunYhBlOow7k7i75hoUEl4e/euvYuCIzjM0nFjMT4iTX8gMr6
 S2SI8V0xd/S6znElWJIBU1vQwxqHUhzrOFd5oXhdQve1aVqbcbon2DAmG2qd9wmed
 1ezxbAuMQAghUnezNvLR5LZZDJ2yy98epP/iDyIr5+VyYBXK9DkgAM5nIsH5Qxkiu
 sF3ax9tHADyNsitx72GMncys+7iCK6ZtojTMg3/UTyLkbGxJqX2TwPFLcZJrZrSKy
 o6nJeibQaM/VcCVThA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1vaP6C3yo9-00tWLo; Mon, 09
 Mar 2026 14:44:42 +0100
Message-ID: <e389e2d6-2376-46f0-ba48-e38f39d07f20@gmx.de>
Date: Mon, 9 Mar 2026 14:44:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] For next patches
To: qemu-devel@nongnu.org
References: <20260308172936.2835-1-deller@kernel.org>
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
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VkGBMZeAVRgUjt0jpwsswUqtBiUHU/dS1SJLr5nK/hfcqS55f5d
 ASS/CulITekfmxc4KJPb9h97lWZ62gBbxGLvB41ULZpYJ6/MqJ+yYkoGjbJx2Swhqza25ts
 JB6ADq+WfsybH7+7W+S0UKMejrxNBZWSZO3AD77KysCq5nbewQlOTozMgrTYD8TiB42Yr4K
 TxgUFgtyftoo08PFWtH9Q==
UI-OutboundReport: notjunk:1;M01:P0:oJ4flN+di+w=;5n1Ln+WwK8rXD6L42+e4jJE+0AS
 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
 0+tqCuqw=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/8/26 18:29, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> The following changes since commit 900682c57287ea308850af4490339455512e9=
2e7:
>=20
>    Merge tag 'pull-target-arm-20260306-2' of https://gitlab.com/pm215/qe=
mu into staging (2026-03-06 15:58:24 +0000)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/hdeller/qemu-hppa.git tags/for-next-pull-request
>=20
> for you to fetch changes up to 9e8501ba72d5136ee5e6622f8863ce8ea252c29a:
>=20
>    linux-user: Improve formatting for mremap() (2026-03-07 22:58:27 +010=
0)
>=20
> ----------------------------------------------------------------
> linux-user and hppa patches
>=20
> Two patches which prevent memleaks when using Diva PCI
> cards on the parisc architecture.
> All other patches are for linux-user emulation.

Please ignore this pull request.

The two patches for Diva cards have already been merged via the "misc-hw" =
pull request.
I'll send a new pull request, which will include the "linux-user" patches =
only.

Helge

