Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CCCC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmOp-0005m1-Fe; Mon, 11 Mar 2024 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjmOo-0005lX-Hv; Mon, 11 Mar 2024 16:37:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjmOm-0006pH-Pl; Mon, 11 Mar 2024 16:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=znsB1Ez6Cl2L+HBnbaqqKreNYUZ7qL0SSzNAoGyoZP4=; b=MOhhFEr16OGjAFBeUdEgXY8IzT
 bmdipQsi5mRUK3NdfZ2ND5VtY+Hlr6VlHWCDA4UcHfrpebMV1oNj4Vmc36AfGXovCRPEFSwj7Pc96
 lGV3TKwva2ioVp1S3ej2SgfC57EWhaVrHzl21KAKaJ5Q77jfdLpgTHi4qtOUIkavL4Xg9MXYtd/Ww
 H9vpc2hjVzzIA03uvv5uZoIiwRhthpZS06dZ3grk3vGY8gIO/ZmiKjaZtW6BlPh0fNcc4XB0q3p33
 WXrmYPfe5VTCFfPj6BazCMBj5J1d6vxZgQGTkDXja4hCyp+PENMMKy6Gi8NTjfbGa7spdujAzuacO
 opoFJOnnb+hZSIZt4LLCMOOnzuGJOhpAvZVo1lsG0EjW2Z7VrISfdbfRaddYVIdKZH/N0BKiqADNM
 ClWKgl5M04gSOIp2oZ8tdGYIiM5EEkRv8Qqw9jQ1/QDMoBIUU8XWLUABIVOV7LwzhWqQD23AcPmYU
 5xAsvJAPnODzpX9Ew7xZifEv8GKii9MT2RLSL6qVAHB1FP9zR9V6cRn/QtRL6V4nLbrEiSQWT2tIW
 qNc7MeQdMAFFnA1IyjEM32rZPtqZu8SHXfFzswAxMIYbSD3xiLcWZkc/+0eSGbTRjCH8pW5LZ+ENd
 J0ZPCYNXz2dn0Ynwupgh4yBmy9IoLKPqjJfl/BRrw=;
Received: from [2a00:23c4:8bb3:1000:a445:b8f9:4282:afb2]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjmNr-0009nx-7x; Mon, 11 Mar 2024 20:36:35 +0000
Message-ID: <8b954aba-e340-44a6-81a8-13892685c187@ilande.co.uk>
Date: Mon, 11 Mar 2024 20:37:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240311075806.668555-1-pbonzini@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240311075806.668555-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:a445:b8f9:4282:afb2
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/03/2024 07:58, Paolo Bonzini wrote:

> The low bit of MMU indices for x86 TCG indicates whether the processor is
> in 32-bit mode and therefore linear addresses have to be masked to 32 bits.
> However, the index was computed incorrectly, leading to possible conflicts
> in the TLB for any address above 4G.
> 
> Analyzed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: b1661801c18 ("target/i386: Fix physical address truncation", 2024-02-28)
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2206
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.h | 2 +-
>   target/i386/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f5..6b057380791 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2334,7 +2334,7 @@ static inline bool is_mmu_index_32(int mmu_index)
>   
>   static inline int cpu_mmu_index_kernel(CPUX86State *env)
>   {
> -    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
> +    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
>       int mmu_index_base =
>           !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
>           ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2666ef38089..78524bc6073 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7735,7 +7735,7 @@ static bool x86_cpu_has_work(CPUState *cs)
>   static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
>   {
>       CPUX86State *env = cpu_env(cs);
> -    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
> +    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
>       int mmu_index_base =
>           (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
>           !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :

LGTM. I've just done a few quick Windows boot tests, and all of Win98SE, WinXP and 
Win7 64-bit now appear to be working fine with this patch so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


