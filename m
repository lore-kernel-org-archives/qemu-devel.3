Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35F3C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 16:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roQeH-0007oB-MU; Sun, 24 Mar 2024 12:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1roQeG-0007o0-0G
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 12:24:40 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1roQeE-0000Jv-0M
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 12:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711297474; x=1711902274; i=deller@gmx.de;
 bh=QC/XEVExFh2Sl1v48u5uYyX2w2SuAOWTcyqBHJ8JulQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=F9EBkEiUqSC3AIKiU+7uMW6zjcT6Mb17mdWElrI1QVka0Q7x8+edDsIPb1+jBfnx
 2+D8b6RZW9nfNd9fs9UwdxqBR+Aeiw13oCS/R3qhR1Enk8SJuXL+uaxCZjCZdik4K
 vHCW+TXMJ41jgDy1d9Xxt0SeawfaeU0owQQsYYoHSCUB8HsekT+HmdMJurQh71osW
 T3x6UkrJ62RmS3sY3brRt2+SUkQb0oxWic51++vxu35c6oZVfI44yMOPVCB55R0eB
 uEpQ3Qm7wszSq/AFTWBiPho72v5f8a+lvTRbodi5PVHCT+dwkEpz40hg9gGkmlxMR
 HL2g+kdDf+6oc50EsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1sCY933sdc-00OKfg; Sun, 24
 Mar 2024 17:24:33 +0100
Message-ID: <e6fe525c-06b7-4cec-8a77-745cbfffee4a@gmx.de>
Date: Sun, 24 Mar 2024 17:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240324080945.991100-3-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xr3cbzdpu/7DofyF9jp+wtut5kP7HvadUrmvXEaagAHjPyYvA8b
 nhm6GomOAuJW0A+oRSONVp3nyl1j8pX2uxiyTch6lyxrsXk2DnqchKRNvawauGrlIp02ntF
 daAYid8cnhTfG0vYLpzQX1ocIMmSk7RCYWo43Z1Z+HAUu6Mob48iyUPxYIZUjEavFpLG+QS
 vyGraXt1nEuP8hwmEuAdw==
UI-OutboundReport: notjunk:1;M01:P0:iiC/Cki1WKY=;wpZhNB3z0iS4kkcJx7QTitbLfHP
 Giyttye5iTD2T1K4l9Qwwb5TBhnXOQmSFO3TL21SmGJjWsNAZn9NTykxbA40MKf8lQQpyEMQk
 3QOhU8Ix7CWDlZyT6Di5ZpoVd09+AGok9AZ/rl6SW4qT+Cm68OS/PklnvzVdgqND/ozh11aoG
 5OB1nUrY7p/79NZfL4kRlUUglz1pBxXT7r/qMjnCoKGP8OU/pEiOajzgS6EbElAijP5jgx9gt
 k2HXjYsrYkTiCYz8RAa9tEFRmE/aMX2wgMWyif0hoMqXf4visc4831JZuI203DrWEguJfro1+
 GWlPxK+yF4MN6KNklgUFV8tKbVii9qp7O+EK5FSRigm6Yn+yCMVuLlirkG0MJcjPGOcEHHexO
 KNmeAgPHo4qRfF9V3QKVeQmXKYUzXXk/qD1rCCOW/QW2fkelyPv9E3Z+hqBDmewK45jl7UBLx
 cjnE89P3okHyNVV1WZ12w+xJZucV+BgsKZd3jIWBQ9blOGWi8eXOfXfqbZ/tdTj3YWiJdA9EI
 uI5QkVYy1v1oOcHG76+ZA+AzFcZNEw1iPwWjOQR6nLFl0dUCAF0dnPG3MREg786/kHX8VMnPN
 WzGE29BXsIcAlI/z6Wxk64wepa1lHqEFbKk5g/5GOVP1lG2Pt6JvRc+IECHkxMBv9GAUwqcGR
 2397iMjOoX3ZgQmwAn8R1tIEBbp+ygr0bcHo/sYlBtcdIpvYcDtyUm2nztDyDhtxIGQ5huaC8
 JpMS2LxLxv1Sjg498EGAJcgqdoVSrT6SRDMuHKtRtwXeENPVKcTEVoTC31ubg2Fig1KwyDIYh
 ZkuHRJfVJMYEI54rfwOEYnNMp5YXARXCW+/9tbzDey4Hc=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/24/24 09:09, Sven Schnelle wrote:
> The CPU seems to mask a few bits in the offset when running
> under HP-UX. ISR/IOR register contents for an address in
> the processor HPA (0xfffffffffffa0000) on my C8000 and J6750:
>
> running on Linux: 000000003fffffff c0000000fffa0500
> running on HP-UX: 00000000301fffff c0000000fffa0500
>
> I haven't found how this is switched (guess some diag in the
> firmware), but linux + seabios seems to handle that as well,
> so lets mask out the additional bits.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

I've seen the issue on HP-UX too, and can confirm the patch does
not break existing 32- and 64-bit Linux installations, so:

Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


> ---
>   target/hppa/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index a072d0bb63..9bc4d208fa 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -283,12 +283,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *=
env)
>
>   void hppa_translate_init(void);
>
> +#define HPPA_GVA_OFFSET_MASK64 0x301fffffffffffff
>   #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
>
>   static inline uint64_t gva_offset_mask(target_ulong psw)
>   {
>       return (psw & PSW_W
> -            ? MAKE_64BIT_MASK(0, 62)
> +            ? HPPA_GVA_OFFSET_MASK64
>               : MAKE_64BIT_MASK(0, 32));
>   }
>


