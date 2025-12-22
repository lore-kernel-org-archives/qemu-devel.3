Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF58E69162
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXlvf-00027o-Ej; Mon, 22 Dec 2025 14:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXlvd-00027X-Ar
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:50:50 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vXlvX-0005Eg-C2
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766433040; x=1767037840; i=deller@gmx.de;
 bh=sB021EE1qA9O2Xl2w1uqpfVQ3LcNDApm7Tuyadq46yI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XXiAtSNd6s436sAV1LL240TyJnq/r/7wp3cr/VxIJDYX63fhE7KYmt8v0o/g/c1V
 BrTbX/Pfj2Ng6uFsRUO0fNfU29dOg4BqgnOV64zkrtV1nX9tPqgq/U60FOlFK3qvM
 Ta2h1NtGKv4Le6gYkkRtwdKenCDZzWhz982fyf7zLZVuAlf/GHC6vKmjC2jbZb0su
 5ywoMByZJscwwjL4pKgDTczM7/AJZCEkWjZkhMoWRQJ6vwtwPzz848aSyAk2epGhN
 X+RBithn3e+0C1rQ2bdrg5WHNh6zr7DafOzdP2/u4RpMK8fjY2cJ49xv5QhPS3Vy9
 Sg1rkyeWYkbcjI60xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1vWxdo3lMN-000MG4; Mon, 22
 Dec 2025 20:50:39 +0100
Message-ID: <d29e6880-9781-4a9b-87e3-c184244ec719@gmx.de>
Date: Mon, 22 Dec 2025 20:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] scsi:ncr710: Add null pointer checks
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
 <20251221142317.266293-2-soumyajyotisarkar23@gmail.com>
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
In-Reply-To: <20251221142317.266293-2-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pq9YwfUqnGpx0ghVVzSme/QO88fU+tmqsNHRQXX7afVmhpw4o+y
 eir0v5OIOLbDWBxcUCMoEATTdTVoH3szvythKB/PtPi5RD9c5D3dCb495t8IY6gPFyqXLCF
 WXGOEVoEfY/qC32uAp0Q3JT+1EaOq9Bfyq+hRTFmOW7LahAwLvn4Zolh1CG/y8Fs2i01YI3
 nrZODqEVf0wdpXHfzuGAQ==
UI-OutboundReport: notjunk:1;M01:P0:lLyDwVFNI6M=;gH3PYu3NS0eAGPYGtqlap/HI+gW
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

I suggest to add spaces between "scsi:" and "ncr710:" in the patch title, =
e.g.:
   scsi: ncr710: Add null pointer checks

On 12/21/25 15:23, Soumyajyotii Ssarkar wrote:
> Add nullpointer safety checks in ncr710_request_free() &
> ncr710_request_cancelled() to prevent crashed while handing invalid req
> structures
>=20
> Added to preventing memory corruption, which occured during device
> initialization
>=20
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
> ---
>   hw/scsi/ncr53c710.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>


