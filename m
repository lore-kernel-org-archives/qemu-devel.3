Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 22:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFgJ8-0007QE-EK; Sun, 02 Nov 2025 17:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vFgJ7-0007Ps-1M
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:12:17 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vFgJ4-0003ok-Lf
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762121515; x=1762726315; i=deller@gmx.de;
 bh=KthOien3K7GDaswl/0l/KmVDs8+fIA1z1TMGL1BLF0s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WOna7I/UtTjPRYOgROcDC2rohC27N1NltdHo76f8gqDmSbNI9Ynu8lM96bxrGiJx
 1h/lBIA2W8GboWMDZLGM9fYx5P+2VonbieNKD0NqWSDNKVAKp3JHZb7CzWpnmHPE5
 fgVAniOeZA3VRvpaRwTDw52RyYamS3GD1Lm4WjFIj8o4kvv33zcK7pQgHczIWiA4X
 08LtSm8mogxDZdwMgN2wW4ouysu5H4JHM5Aj7NUAWPH4XLGBDvpUOvOPrbFaDWD+4
 EbYzTdG2r3fGBNm7wpZs2MW2wbMT2q8UtqdQBfI6YIXng+C0yQSdCgrvoQHVfsu/W
 3TcPsQKcg6k//mqpYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.170]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1vjsMb0K4g-00PRug; Sun, 02
 Nov 2025 23:11:55 +0100
Message-ID: <5b672b32-cc09-4e9e-8961-efe362991a87@gmx.de>
Date: Sun, 2 Nov 2025 23:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
To: Guenter Roeck <linux@roeck-us.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
 <07200388-ae9b-4021-afb6-5fd93584d39a@roeck-us.net>
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
In-Reply-To: <07200388-ae9b-4021-afb6-5fd93584d39a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5wUPgW4xhZaotJbe2lJpBpGcvhWohpLKs3NgAHgZgvVcIY4FNT
 cFn0j/67WHuxDW0nVKOD9DWgD33HVJXmFwT07uUZm9Xl2grnf5S5NdqYLZVwu8pblRQxMpG
 c+lyJ4Fu0HgOiVwl2pODbIIcNsm8IEzuogurHxXGTZI1C5cBi1bGepFojQjQBM157zOVt39
 wo/hRXI1AnpM1hc15j5qw==
UI-OutboundReport: notjunk:1;M01:P0:RIXOoWKZP+w=;QE4PGkBCaVNurOtTnByqOKyJzfX
 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
 W7DyhWJ+hbQKjBpMm1Nml1geEZ2aynnWHCb59w
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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

Hi Guenter,

On 11/2/25 18:31, Guenter Roeck wrote:
> On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
>> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
>>
>> Enable the i82596 network chip which is included in the LASI
>> multi I/O chip. Since LASI has different start addresses on
>> the various machines, always initialize the LASI components
>> by their offsets.
>>
>> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Changes since v1:
>> Added proper Qemu device initialization for LASI
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> Signed-off-by: is missing. Other than that,
>=20
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thank you so much for testing the series!
 =20
> Only on 715, though. The LASI Ethernet interface on B160L no longer
> instantiates for me after the SeaBIOS update to version 19.
Have you actually used LASI Ethernet with B160L, or just enabled it?
I'm asking, because the current breakage of LASI Ethernet on B160L is inte=
ntional.
LASI ethernet was mostly broken up to now. It was not enabled by default o=
n B160L.
Now, with Soumyajyotii's work on LASI ethernet and LASI SCSI, the goal is
to make the LASI chip fully functional including ethernet and SCSI.
To not break the already existing functional B160L machine for most users,
I introduced the 715 as testbed and new machine to independently fix LASI.
The goal is to make the virtual machines ideally 100% like the physical
machines in the long run, so when we have LASI fully working I plan to bri=
ng
it back to B160L again.

Helge

