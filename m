Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F19C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDFh-0008RX-Cb; Tue, 07 Jul 2026 17:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1whDFe-0008RM-2b
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:22:46 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1whDFb-0006et-4o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783459350; x=1784064150; i=deller@gmx.de;
 bh=yy/8leevQdVdQmzRw27Bwv/CNuGepq+BYrmBfyflR6o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hpc4saEZs9mxZnhx6SiYAJ1qTDFIs398LLUnifGjC39hKOIL/W2w+jNTXJdFM8qb
 5/7LCDMVRBwg/IfZR5/eFbCIW4xrRc0qwgrHpWyN4BNK59RVf9u+D8ckf07DSZuBR
 fl6eHFHP1/LsacOHSQJkEdBXiHCK8Mc6Zvl5PVySrbtHuIqQZm5gLGB7CK/jmzkd9
 4akj3yr3fZXu0nwuE6xqsHcDaImFqTR0qfMqiMmyI80V7NdCQ+ReNbEbF7fptWwV1
 PiAQOOQUP7gGDFgQTrnBIg7xoRA2NgYBFjefEAyCVfeUl/B6WD8VMKWXaWX7QY1Su
 TMqDlDoQhKemeG3OGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1x4si80QdK-00vdRc; Tue, 07
 Jul 2026 23:22:30 +0200
Message-ID: <88ba7d65-4f06-4787-9cf9-d8e8f0335031@gmx.de>
Date: Tue, 7 Jul 2026 23:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Validate guest-passed dm_ioctl data_size
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260707104135.1234982-1-peter.maydell@linaro.org>
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
In-Reply-To: <20260707104135.1234982-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2iTnY+uDOFyhvLpDO4btyOFzFdH2irsCW4ZCkFdChEk9t8DxMA+
 MMrTeQO4bfU/GhpwYLlRRQzf97Ix7SMSeWHbSFsXF/yh+U7OnPtNxGwf+VKLuZPROVb1EAg
 7XOkiaXbeu3W/b1XoSFQQUQBN0DlF7mWf0E/BSeBfMSIi5U75r+SHVSfVKmvFgC/bVkgSsr
 T/fh7h7vWSW0G9jDXmdaQ==
UI-OutboundReport: notjunk:1;M01:P0:xTQ1MpqM5BQ=;OzGPn9WtbXngU19hSbZRTEhp+vF
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/7/26 12:41, Peter Maydell wrote:
> In do_ioctl_dm() we work with a struct dm_ioctl from the guest.  This
> has a fixed initial part, and then a variable data part; the guest
> tells us how long that part is by setting the data_size field.  The
> data_size is supposed to include the length of the fixed parts of the
> struct dm_ioctl.  Currently we don't validate anything about the
> guest-provided data_size, and we use it to allocate a buffer which we
> then copy the fixed part of the dm_ioctl struct into.  This means
> that if the guest passes a very small data_size the copy of the fixed
> part will overrun the buffer.
>=20
> Perform the same sanitizing of the minimum and maximum limits of the
> data_size that the kernel does in drivers/md/dm-ioctl.c in the
> copy_params() function.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 56e904ecb2018 ("linux-user: implement device mapper ioctls")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3736
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
Reviewed-by: Helge Deller <deller@gmx.de>


