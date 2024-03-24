Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595F8C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 16:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roQhr-0000sl-5V; Sun, 24 Mar 2024 12:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1roQhq-0000sd-9R
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 12:28:22 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1roQhn-0000kT-UU
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 12:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711297694; x=1711902494; i=deller@gmx.de;
 bh=P9+ujCkFST+g8sl3cvxTgyIQsvRFDOvVYPcslS/4CA4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=tbkIsrAFfCMVr+oKw4YTY4ukA3mTL6vsveaHA9M5dYSIm/5WM0dwzNL961q+wi8I
 iMXRNZO2pmB21kmxxEg5QT5u1cLRA0UjKRAWtZ/T9Wp7iaOPOJmG1o3iQJ+AZ4RQC
 1IZQnKS4L3w2VxuiZmFVEccVquqDTwQm7E+WNaw338yDZwCQ6GuNeaG5oTw7ubl3d
 EeYiegfPYOMx54yWA5NiUvfRFmTkCuVJ3g4l893KTbjI+f53cDogLpBF65H8MY6T/
 E1fB+dTZnXrEnutcQlhKrveSzHFgvmyLo7Dxa+uTdT/o0Z3IUA93/+cghc1AXL23k
 m/5jtANicOHIic9SzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1s7bkO2Hw6-00JLtR; Sun, 24
 Mar 2024 17:28:14 +0100
Message-ID: <1f7a34a6-9038-4419-abfe-d7f9addc5bcf@gmx.de>
Date: Sun, 24 Mar 2024 17:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: fix building gva for wide mode
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-4-svens@stackframe.org>
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
In-Reply-To: <20240324080945.991100-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NBIhQAmdmQ62+2NrEyJv8hfS0CY0vkWbkriteK+fP7BhWiyxFYV
 su6l2qrVqgzt7vGPsl3jsBrcoN6+Kg+rWRIOMyhHmVngFszsa6y9HaOvdEoOEAHNomyc/La
 VKg3id8iuBJFrZCze50OWF+VtMtRbe1n3JQE8ODR/gWXSddXVZf7OjekwNgaZ7o6uCNe8dZ
 oeHpFU7vryfp2Hb0uVfDQ==
UI-OutboundReport: notjunk:1;M01:P0:rAb906w5wx4=;a3gxo+DlM+yWMVRNONcSrpWW/VG
 f6ud/eUuHu7LVhvtGV/WkB8/iPo04nOTGYuctY2xRunV0ROMSOwDogYZ1FFE9GG2j2s0JUUq1
 6HQ4kw//hNRFT7xNIOTWWO56MBZ+HZgU+ygYdZrEc6VNdrqYdP11vENodi5WJ0pXbh9aCK2FG
 eKBYrjIv609SU8eZ061LhmzME0hgWmWmL5VrRkgue02HG1pXiCM99QVUMs63IS/kJ1lGoLgb+
 mNpZinLwxxH0EyKy/HfAUZweqgzfrsU2ruYRTVMuO3hAHD8HkeVNKHCzkD1ItiDaykN1bVHJj
 j47hGD/mW1v0jZ+IBo54RjEQ5DJVpCwTui//wip93IDWLWgiu6WIPH4fXOO8NtgSCUBie7VIP
 TQ5o2cZD00mV3E+gyDc2h8ISEGDdU4xfmSAMkRFgxHM75507PFKOZ4zCjYCq8d1f0tD36YTPU
 M7IiCL5yEjTRjAaH8LVtb6j+JqwKgmvOFaWzyT/34dYOGLZacjgGKJl1OqZQ/ofmI1htd6WFx
 STcJELJApFn2wJYA8XfDHhDyh3laY/zBP5/obWW3n1zGcRyqKtX5lcMWGmapoBhzYux8NZASN
 59RUo2qxgcPrijn/D8gg1y9WR0/BT5wMa1hCXoS8HAPEj404C4MeYsc1CGhNJ3vTCog1PsuDn
 kHZlOC4sCbmOSwdYt4inKO+n6UajTuke+hRjI9PBic+zitKFercWVTLiAEHqsYPQQvyGAnb+e
 YZ7J5U05+IAfcIienXZ05YVW8Gr+DpKaFXLaOvauywfwtmgliiVr8HqQ/LUh2bGzPJ6cmj/Ek
 0RENQFi+ceWjo7+jAqL7P+xf8YYbiEG7aHc5m/8wFghJ4=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/24/24 09:09, Sven Schnelle wrote:
> 64 Bit hppa no longer has a fixed 32/32 bit split between space and
> offset. Instead it uses 42 bits for the offset. The lower 10 bits of
> the space are always zero, leaving 22 bits actually used. Simply or
> the values together to build the gva.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   target/hppa/mem_helper.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 84785b5a5c..6f895fced7 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -523,13 +523,16 @@ void HELPER(itlbp_pa11)(CPUHPPAState *env, target_=
ulong addr, target_ulong reg)
>   }
>
>   static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
> -                       target_ulong r2, vaddr va_b)
> +                       target_ulong r2, uint64_t spc, uint64_t off)
>   {
>       HPPATLBEntry *ent;
> -    vaddr va_e;
> +    vaddr va_b, va_e;
>       uint64_t va_size;
>       int mask_shift;
>
> +    va_b =3D off & gva_offset_mask(env->psw);
> +    va_b |=3D spc << 32;
> +
>       mask_shift =3D 2 * (r1 & 0xf);
>       va_size =3D (uint64_t)TARGET_PAGE_SIZE << mask_shift;
>       va_b &=3D -va_size;
> @@ -569,14 +572,12 @@ static void itlbt_pa20(CPUHPPAState *env, target_u=
long r1,
>
>   void HELPER(idtlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ul=
ong r2)
>   {
> -    vaddr va_b =3D deposit64(env->cr[CR_IOR], 32, 32, env->cr[CR_ISR]);
> -    itlbt_pa20(env, r1, r2, va_b);
> +    itlbt_pa20(env, r1, r2, env->cr[CR_ISR], env->cr[CR_IOR]);
>   }
>
>   void HELPER(iitlbt_pa20)(CPUHPPAState *env, target_ulong r1, target_ul=
ong r2)
>   {
> -    vaddr va_b =3D deposit64(env->cr[CR_IIAOQ], 32, 32, env->cr[CR_IIAS=
Q]);
> -    itlbt_pa20(env, r1, r2, va_b);
> +    itlbt_pa20(env, r1, r2, env->cr[CR_IIASQ], env->cr[CR_IIAOQ]);
>   }
>
>   /* Purge (Insn/Data) TLB. */


