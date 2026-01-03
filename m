Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75427FC6185
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 18:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc6Ud-0000BP-Ee; Sat, 03 Jan 2026 13:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6Ua-0000Ak-AI
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:36:49 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vc6UY-0003us-Ml
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 13:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767465404; x=1768070204; i=deller@gmx.de;
 bh=Myg/uuAjDOpkaAno5MEcNFyLxtBipxx2VGZfrZhBGyc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tqcGzvVnLaii7z2Ic/pq28s/Yr90rYvuV9GI4jPXNyRsQT/vwFCCZRFXHIlKrxPn
 oRZuMS67EgAYjDTd/6q7E20brKf6TyXoc13Ho1aA0eqnpu9KlAOjS5AFMMxxMSLVj
 Roh/dmguZDCzjpG51DZ+Cqq2ZLoHOO3SgjeWmgdBeKsRQCQZkT9iiHnVos1K94FZd
 omywHyPSYxwxAIUrzOmojjs+JAWrUYPUHyuoe1A5dRTO99ZUwIdr3HCfZl2eLtR93
 Ti37sRv2WKqhF0h1B56cvordGs21hVo8nZTs0+xT4+t/RR2B+AYNacCQXd2E894oY
 fYDf3xpo0Pm1D9fU2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1vGKVj2amp-00IiEx; Sat, 03
 Jan 2026 19:36:44 +0100
Message-ID: <6f2fdb14-1bc7-4fe3-b756-418b16b452ff@gmx.de>
Date: Sat, 3 Jan 2026 19:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] Add termios2 support to mips target
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
Cc: Luca Bonissi <qemu@bonslack.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-5-dilfridge@gentoo.org>
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
In-Reply-To: <20260103153239.15787-5-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hplmpq2mS1ucTWjSijpu2v7SPtwSF9xQcFSTNJVIx8NiHzbzBAI
 QMsr4+0wkx/60BTJqKhuS3XrPF+osk7mxi9s2IO29tSwBQlcHWNRoQE/MksMFrtFsfs1WJP
 fTzTxh1u7TD2tkfc+N4Q+TlQEJzzAo4NtpkIABqA37aaUJVDNjee6cDUnedzwFE4SWa1zk4
 rjD92BRZuzdPdw/4x19qA==
UI-OutboundReport: notjunk:1;M01:P0:HoHDHnGZqss=;4jLeYenW4ZnpFEVMXPeCGizEf0t
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/3/26 16:25, Andreas K. H=C3=BCttel wrote:
> From: Luca Bonissi <qemu@bonslack.org>
>=20
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> Link: https://lore.kernel.org/qemu-devel/361aa9c5-4464-4d27-8a2c-9ab7673=
24530@bonslack.org
> ---
>   linux-user/mips/termbits.h | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

