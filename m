Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5DECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhzX-0006bI-Je; Tue, 28 Oct 2025 07:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vDhzT-0006aD-21
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:35:51 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vDhzJ-0004gs-VO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761651336; x=1762256136; i=deller@gmx.de;
 bh=yngDSiNKQxvvg7sLF6uwtXWzSYRX/O2IZQCB3UT3qXE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qq+hfvVCMPKnSqndzwKmbvX18gShwjjw4J85Nq/R1RUM8knOVJPosiI2nlmGSVD5
 V2YkCzwtXqf0dK7zNlvm5u2yD2k3yNR9whrYZaI5fTqiIQF/ICrLDTRJF3VGWh5W7
 efmhyM7cFLp0kgf1OfAgUo5xUDitugeY2IBQ/dv+tr2eiw9lEtdZMeI6/RaxNreqL
 hUsjQdxdoA1mn+Nvl1sLe4stOnBHv6N+o6E0aFw7GIfUVRy8Pr3GRbdQfDz76RY17
 9vVO/cgQiLIIMWPDQ4jWpq6bLBlPx/yOUGjjURFJGjNexkLeNrrYePAi+DQqlSuDD
 36EaawFOrrB9aMAsTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS54-1vyGxJ3O1a-00f2DJ; Tue, 28
 Oct 2025 12:35:35 +0100
Message-ID: <94295e11-1127-4eb1-89f1-9fa346cb8d29@gmx.de>
Date: Tue, 28 Oct 2025 12:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Use correct type for ioctl(FIGETBSZ) emulation
To: Bastian Blank <waldi@debian.org>, qemu-devel@nongnu.org
References: <s7ingr72rgtvch2poxlwyc25lkxp7hh5c273ubvmz4tdskjttz@7dzfvylkgwsh>
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
In-Reply-To: <s7ingr72rgtvch2poxlwyc25lkxp7hh5c273ubvmz4tdskjttz@7dzfvylkgwsh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mUp36w6sSLQS3kVTSNwuGM1Cs7eX8BhHmi7ExH/w4mrc7eMC9mr
 iJTAIsTMmiGW8tCWwSrxl8b/I7WFHlXwTI8Ls8pEKZlOweBfZaMVoU9Z6HbU69iWqzphGGg
 wA7U8ptMAz6LVyK48JHg/YWUQPbUp3bbrrSjoiUOsO+vfgACvGgz///GJ157i/fAk8ObX+g
 4sWtS0gkzh+OOzi5SiYlg==
UI-OutboundReport: notjunk:1;M01:P0:Hkcg+vJ2dEY=;fJ/YucfXGCoc16HBEBSRCgXX862
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/28/25 12:29, Bastian Blank wrote:
> The FIGETBSZ ioctl get's "int *" (pointer to 32bit integer) as argument,
> not "long *" as specified in qemu.  Using the correct type makes the
> emulation work.
>=20
> Signed-off-by: Bastian Blank <waldi@debian.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
> ---
>   linux-user/ioctls.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 3b41128..c87ce61 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -145,7 +145,7 @@
>        IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range=
)))
>   #endif
>  =20
> -     IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
> +     IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_INT))

Looks good.
Reviewed-by: Helge Deller <deller@gmx.de>

Can you check FIBMAP as well? I think it needs the same patch...

Helge

