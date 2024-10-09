Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4A8CEE342
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 19:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sycdv-0005n1-Ih; Wed, 09 Oct 2024 15:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sycdt-0005lT-Ti; Wed, 09 Oct 2024 15:46:41 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sycdr-0001t0-F9; Wed, 09 Oct 2024 15:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728503192; x=1729107992; i=deller@gmx.de;
 bh=l7/3KWyYkdVNuAZ8PjFJLPSZeO67WwppJtJn1V4WkXU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r6xW8flDeemx6WxYyjgfvIvxLG/dTONKG6/GOsgCGQdKTLSw6va0chMKc9oNEqkT
 /x0HVf2kVzaJbJ9giD+JnljWbsV0aXdtEKl/txt3bRcTaQPSTfk9dEMAOIIoHr2z0
 A4xgFRoNroVYODF3Ymc7vupPHqVqqrRYmE3W1Qf3KIA5+TUSrznfEBQiX7zHRb4ge
 DOGHk1lWTvJzyyJX76WnCQ88GpFbnVPMDscQeybOSLM55XupdVuExWG+rhdJaSE10
 zY57I5qLoiPl6W0BISzCM9DiDCLoAFGvOa+eDCTSHgol77ZWoL6NVY/p2kePISQqy
 knpT279Uqw6SRgIP3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU0q-1tWZsi1te0-00fYrf; Wed, 09
 Oct 2024 21:46:32 +0200
Message-ID: <c135e5d1-e742-4a62-9ad6-82614869dc6b@gmx.de>
Date: Wed, 9 Oct 2024 21:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] accel/tcg: Add TCGCPUOps.tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-6-richard.henderson@linaro.org>
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
In-Reply-To: <20241009000453.315652-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zCmpm0qU1enjfJ9eJtMe3crtl/bLN/vE//FdwjxOjRr8j2Fb/Zt
 Mqi199ikz4/XKLoNOHCBYqAx1k3iyuRHXMkf0O5XA2jI/f0o9OsHZIRhbwzy9FLEgQ2VNvV
 BjYKoOtVC5sPCW5i4FmRmNLjVktS+ejghzOiiuZV3P3PcEKN6PcXno0yUmYkmF+IEA/MJJR
 qZ69u9F0/dzp6K/5MWKjg==
UI-OutboundReport: notjunk:1;M01:P0:aTjAG1270K4=;3m8XDLjt8j3IgsgUWe4hCpmDMtz
 Eivwyn/pZAJAjI2olNWO8srf1kgZANKL6zIKw+ebIqNU9/pwDCCjYF7iIbpoJihMg4xhEPWnX
 mSU8w+ODopp7u40v30zLTcyBsyzmFRGHCnCDasikr9gN4Z53y1cUsXgu2utpeQNRWLX5QskHA
 QbFKSQg9Tm1tNQ4Hfc332LaXGqRYmIJnM7OPzFogEgPrXcDoYgXZvxaD6VhPs0fIqHNry1baR
 Q2jsTFB2XkrPpHR8eg78fwWGJnWEaGsoevh17HLTH9m+YVG3AiJ8JOqI8TULVpMHc9kTITh25
 2ufnJzfEoFYX5hVnaQ02MSc1yRsU12yBqr6UkTdYE1X1Hy0rwB2KNQVg5ftb6z427HHvFoN+2
 nz11SOFMFlguKkaK3Rq6Tw2PTRbh+G68k5x5Sh5he5L/R3DgRx/Xkge8W2hR6HQ2+qS4To6I+
 z57+zS5lHDCzAtSSSRxOlS84olAelgYtULn2jyYwqFNWjjgiVTyZPH3NuqI051QQns7NXzFkb
 zcwdMrR4NYy5ESNs3cvN52OmmG8V0F2bA7dCf0El1MwkYIWF3nxWE3+S2XBSsxGzI/N3KXtpo
 zlhD8C1QEctc5BiMsKu9qYaJvLGG5remrkyejoHTak/ZC7g0xMeabNmDR+AKd2Y2xTIolSii8
 6zg6XkeXacaUlxmYON+3FN394pGLDcQSRrwXyvWwFWafwRG0MFQg2bSo88G8xa21bqQBHW7zA
 bTvZBjpE3N9lGM/1xE6cv1Btsbq/HS72DRrv0xiVI5y+Ay8IGEXPK4rjOoZTWX3+upkwh4OV/
 ktZXo++Nrw/I2P7bRISoicjQ==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 10/9/24 02:04, Richard Henderson wrote:
> Add a new callback to handle softmmu paging.  Return the page
> details directly, instead of passing them indirectly to
> tlb_set_page.  Handle alignment simultaneously with paging so
> that faults are handled with target-specific priority.
>
> Route all calls the two hooks through a tlb_fill_align

Route all calls (of?) the two hooks... ?

> function local to cputlb.c.
>
> As yet no targets implement the new hook.
> As yet cputlb.c does not use the new alignment check.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h         |  4 +--
>   include/hw/core/tcg-cpu-ops.h | 26 +++++++++++++++
>   include/qemu/typedefs.h       |  1 +
>   accel/tcg/cputlb.c            | 61 ++++++++++++++++++++++-------------
>   4 files changed, 67 insertions(+), 25 deletions(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 04e9ad4996..d21a24c82f 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -205,7 +205,7 @@ struct CPUClass {
>    * so the layout is not as critical as that of CPUTLBEntry. This is
>    * also why we don't want to combine the two structs.
>    */
> -typedef struct CPUTLBEntryFull {
> +struct CPUTLBEntryFull {
>       /*
>        * @xlat_section contains:
>        *  - in the lower TARGET_PAGE_BITS, a physical section number
> @@ -261,7 +261,7 @@ typedef struct CPUTLBEntryFull {
>               bool guarded;
>           } arm;
>       } extra;
> -} CPUTLBEntryFull;
> +};
>
>   /*
>    * Data elements that are per MMU mode, minus the bits accessed by
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops=
.h
> index 34318cf0e6..c932690621 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -13,6 +13,7 @@
>   #include "exec/breakpoint.h"
>   #include "exec/hwaddr.h"
>   #include "exec/memattrs.h"
> +#include "exec/memop.h"
>   #include "exec/mmu-access-type.h"
>   #include "exec/vaddr.h"
>
> @@ -131,6 +132,31 @@ struct TCGCPUOps {
>        * same function signature.
>        */
>       bool (*cpu_exec_halt)(CPUState *cpu);
> +    /**
> +     * @tlb_fill_align: Handle a softmmu tlb miss
> +     * @cpu: cpu context
> +     * @out: output page properties
> +     * @addr: virtual address
> +     * @access_type: read, write or execute
> +     * @mmu_idx: mmu context
> +     * @memop: memory operation for the access
> +     * @size: memory access size, or 0 for whole page
> +     * @probe: test only, no fault
> +     * @ra: host return address for exception unwind
> +     *
> +     * If the access is valid, fill in @out and return true.
> +     * Otherwise if probe is true, return false.
> +     * Otherwise raise and exception and do not return.

Otherwise raise an(?) exception...


Reviewed-by: Helge Deller <deller@gmx.de>



