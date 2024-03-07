Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4745CC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 22:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riM54-0005Tc-T6; Thu, 07 Mar 2024 17:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1riM53-0005TS-EW
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:19:13 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1riM51-0005Pa-SA
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rqRx8RizlcBxi0vUv3CPGMIuDZKZWJG4DPQZDSqDNZg=; b=Tbf1ZWN7cv+nDkppfWlCItlzVF
 qk2lGsOXNVVeLB2HzrR+LKrHw8b4Soon+k6k/NMrmNxGomYRBL5OCy51hSeEV6nL1Qb8M/HCKnXvS
 4/T2IBUfkki1/CjfspVrSQseRs1Th/qVw89v8jonrgcsXrGY2J2c+L7cvI/ZnjP8XPNqMR5xpneAp
 qHQ1CCnX0uNAYeJVmtUaTmMb9ZKQ+wZL32yTi/haO2lt/NkJSSA3CEQ3Wj3zv/uoHXQ8ywNAEz1xf
 /LvNu48p9tCaKzJLq/L+Xo67ZdMx8BQftXnoQQI01bhzG0zmbvIatfj1V9Ejfrb6osGJzwP5NCZhr
 ThA3b3Fppw77cWudAkuUISvczFKcOztRONxJp+F9XjOivbGphA4wBnBLijlS4dTaLcqOTunp2oJpK
 2pQtzzOM6QFrdzAlDkKL1fFkALVvqOwcSf+je9i6xEjoIcFM97bcUku0Rkia8V/2v/Am8UOWUGuzp
 14hmbal5lv68xrfCFboGYgDcZzGKfTwokJ8UeDniWbYwTrJh1QiU2K+PuspJK9brBvBbEpqO3ea0k
 p2Cgmz5ovTmon1AtNtjL2N+lrZUHwkQQFIBrsXP56ytPW/D7AmW4I0Qv1oEXmcsRvxEHIAXxrYVkL
 dQvQs4UR2sdQbrbSo9hszRDJ03ejZzPUf4aGOr2NQ=;
Received: from host86-159-123-79.range86-159.btcentralplus.com
 ([86.159.123.79] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1riM49-0005VC-0G; Thu, 07 Mar 2024 22:18:21 +0000
Message-ID: <411c8012-a507-4efe-88b7-273bf6f328b0@ilande.co.uk>
Date: Thu, 7 Mar 2024 22:19:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Daniel Palmer <daniel@0x0f.com>
References: <20240223155742.2790252-1-laurent@vivier.eu>
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
In-Reply-To: <20240223155742.2790252-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.159.123.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] virt: set the CPU type in BOOTINFO
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

On 23/02/2024 15:57, Laurent Vivier wrote:

> BI_CPUTYPE/BI_MMUTYPE/BI_FPUTYPE were statically assigned to the
> 68040 information.
> This patch changes the code to set in bootinfo the information
> provided by the command line '-cpu' parameter.
> 
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/2091
> Reported-by: Daniel Palmer <daniel@0x0f.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/virt.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index e2792ef46d93..b8e5e102e6b9 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -239,9 +239,20 @@ static void virt_init(MachineState *machine)
>           param_ptr = param_blob;
>   
>           BOOTINFO1(param_ptr, BI_MACHTYPE, MACH_VIRT);
> -        BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68040);
> -        BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68040);
> -        BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68040);
> +        if (m68k_feature(&cpu->env, M68K_FEATURE_M68020)) {
> +            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68020);
> +        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68030)) {
> +            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68030);
> +            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68030);
> +        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68040)) {
> +            BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68040);
> +            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68040);
> +            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68040);
> +        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68060)) {
> +            BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68060);
> +            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68060);
> +            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68060);
> +        }
>           BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
>   
>           BOOTINFO1(param_ptr, BI_VIRT_QEMU_VERSION,

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


