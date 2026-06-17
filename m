Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F116CCD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZunI-0002NX-Kn; Wed, 17 Jun 2026 14:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZunB-0002GE-4z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:15:15 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZun9-0006B8-8B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781720108; x=1782324908; i=deller@gmx.de;
 bh=D8bDk6DrHRCtkPNvWgyPH/EtJF5l86UqtZSKp45iUrc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BCSMyv6Ff01x8Wol6PTbrMKden3xpAXOtY4wJIfb9wz/hgQ3cD0J4ZFhOMFT5XKL
 Kl+fc6dNWLcZsTmhYIJdQ1P0ICPq/wgPGZmmIMPY0eu9chm/PDirF3wdy5nkrSmBi
 bk9D2BxQMF/irh/MCTsR9dVyN8xLe8Dbp/SIZSV8YePc3FhlVA4Bbi3D2jEP3cUR5
 tOCWplFVfXHM5CUeJXFAuTf0l/KrtSC/vnpH4vO6uv37sfDxznX4Wm3U6wm6k+jnC
 B3aMiNxqueauPn4CbIP4MyyjjeMYrI95X6KcHBuyS6Ad/crI8USy2BHUGUjPdV7Er
 6GAUrhQ99aChxFppog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1wq5xr2sVL-00YYW4; Wed, 17
 Jun 2026 20:15:08 +0200
Message-ID: <bd55cbba-2cc0-4863-970f-9edf035b47b3@gmx.de>
Date: Wed, 17 Jun 2026 20:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] *-user: probe_guest_base improvments
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260616212055.334466-1-richard.henderson@linaro.org>
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
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EQeg/Wy690vRcNSTOxX7GEzkPuBBMc7+EsEgJzh472c2MLVyGBv
 1rgREmx0gxnhGu8ovtwdFyW5Z1AuM/8d7s5KEBrNvfcUvLoiQc8mMQpnIlMxfVcVGM/ZT6N
 8hTeznNZdoGTpoYtTwmmSlE7TRytRPRq0Aw8wGSvmUfcFGBxIbYuk2fcROGKZRv6/8aDQec
 Z/uQwO+BzqZ++PQwdtcjw==
UI-OutboundReport: notjunk:1;M01:P0:aykes9c6KVw=;x1FxTETjbalsKxpCMVXuzwhkQNv
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
> The first 4 patches fix the ambiguous guest_lobase parameter,
> which affects an odd usage of a bare metal image with qemu-arm.
>=20
> The rest of the patches improve bsd-user to use probe_guest_base.
>=20
> Changes for v2:
>    - read_self_maps rewrite (warner)
>    - rebase and r-b applied
I've tested the patch for Linux-user (not bsd-user), you you may add
to the whole series:

Tested-by: Helge Deller <deller@gmx.de

Helge

