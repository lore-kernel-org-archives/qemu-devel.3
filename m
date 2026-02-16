Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB4CE83835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5mk-0006Eh-BO; Mon, 16 Feb 2026 16:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5mh-0006EF-Hr; Mon, 16 Feb 2026 16:05:36 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5mf-0005j9-HX; Mon, 16 Feb 2026 16:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AotiISKILNgy5Y6CoXi2SLyBg0LFDB/Sq0vaOwfnhMo=; b=vHNUaaxDjquyibMoteR2D1jR6G
 ys2OkcM1RbwBEgETbqKM4TahTQcVVP5kFSG0T7H1xdHOl+5n4LYePXbZOd50SLSDVCOywDt9GqPXl
 z5QXMT/EzgGQSg1lvlBiuiKHCsy529/33Cu1/TNYXjlB32NeXz+VoMICvrTc+ID9Cgmw4sSC5qUdH
 VALFGOSUcgW1Zu3owqyt8hN3CWJfpD7bbVGn8vI0n39lYSe5/4iTi6L2i/AjrRMf7pe9WR0npFSJF
 vCoBgovvyi4T8R8xVBz0voCO7cD3MyElkCdC/tL650yFxhwvBNns+nYtN+tzO/Yiw21nJLGGrkrIu
 XX3UgwAUh8kqiW6oIAUr+R8YReG4PegsjsaQ+DqoDhp66WIo2nscMVyOOIZunKyc2gNb94RxuE3gh
 jcJXthUJWBruLX9vmPFMlgyqANA22ulw6gWZ7OeSwNvRn4GpBH8I/e+bxW9HMh1pDZ2KFpsCiha49
 Fb61AuWFpkKtVzKZK8hRCfzUKoINH6JLJXTwx3KOJhUwLpiaQJp6O0ByXhhAq+8AjiK0m7gCI2cFq
 UvYbAcdQSlwPESLVGSnVEG+XRkrU9aFAwXgpSHqxIrKC7bKKqsV+jz22eMs0S1aF8JLRIfvTvS9sB
 HoIAeN/uyZeiBrxgwQSBh7L01CSWR8ZOiubwDyHT0=;
Received: from [2a02:8012:2f01:0:f01d:4e0f:6874:3706]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5jp-000Cdj-4W; Mon, 16 Feb 2026 21:02:37 +0000
Message-ID: <ec70a41d-f8ec-45ee-989e-20ddd81e5dbb@ilande.co.uk>
Date: Mon, 16 Feb 2026 21:05:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-7-philmd@linaro.org>
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
In-Reply-To: <20260214021240.58657-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:f01d:4e0f:6874:3706
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 6/8] hw/sparc: Set graphic display dimensions generically
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/02/2026 02:12, Philippe Mathieu-Daudé wrote:

> If a dimension is not set, have the machine init code
> set the default value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/sun4m.c        |  9 +++++++++
>   hw/sparc64/sun4u.c      | 10 ++++++++++
>   system/globals-target.c |  6 +-----
>   3 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 0c0d658d301..a17bdb36927 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -892,6 +892,15 @@ static void sun4m_hw_init(MachineState *machine)
>                        hwdef->esp_base, slavio_irq[18],
>                        hwdef->le_base, slavio_irq[16], &hostid);
>   
> +    if (!graphic_width) {
> +        graphic_width = 1024;
> +    }
> +    if (!graphic_height) {
> +        graphic_height = 768;
> +    }
> +    if (!graphic_depth) {
> +        graphic_depth = 8;
> +    }
>       if (graphic_depth != 8 && graphic_depth != 24) {
>           error_report("Unsupported depth: %d", graphic_depth);
>           exit (1);
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 5d7787fc1a5..b8bda1eb816 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -666,6 +666,16 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                                   sysbus_mmio_get_region(s, 0));
>       nvram = NVRAM(dev);
>    
> +    if (!graphic_width) {
> +        graphic_width = 1024;
> +    }
> +    if (!graphic_height) {
> +        graphic_height = 768;
> +    }
> +    if (!graphic_depth) {
> +        graphic_depth = 8;
> +    }
> +
>       initrd_size = 0;
>       initrd_addr = 0;
>       kernel_size = sun4u_load_kernel(machine->kernel_filename,
> diff --git a/system/globals-target.c b/system/globals-target.c
> index e3f7d846ac0..17a27a06218 100644
> --- a/system/globals-target.c
> +++ b/system/globals-target.c
> @@ -9,11 +9,7 @@
>   #include "qemu/osdep.h"
>   #include "system/system.h"
>   
> -#ifdef TARGET_SPARC
> -int graphic_width = 1024;
> -int graphic_height = 768;
> -int graphic_depth = 8;
> -#elif defined(TARGET_M68K)
> +#if defined(TARGET_SPARC) || defined(TARGET_M68K)
>   int graphic_width;
>   int graphic_height;
>   int graphic_depth;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


