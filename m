Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34DAC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 20:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUu6W-0005zV-FP; Fri, 19 Jul 2024 16:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUu6T-0005pF-L7
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 16:21:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUu6S-0006M6-6r
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 16:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+t7NOpBDN7BgjUycaq/PV6SW8mYfm2V8xfxmV549UGA=; b=is7fwzivGViwlCfG/9choelaUW
 JRWz+DPOUSsjOM12kbm4g3RfLc8C85a1DfwCv9qmROmFLMjmoiFtFeCJuvhVX12xsuraPjAMnhvoy
 7W4AU7N2lIuyBl/14DBpgUEgG77cdDQTwCDoojGEvamM8eQfMYKTnBA5u1haSyxMxEEEnfZyX9zB9
 p2St+zg3P62ik7Mva3t08vlzy9YByJOfVE/7CkLmZBfVpDHXVzTE40bAedP7Qxtyton3IUZob1n5X
 nJLBGkslS2much+WBxV1OcwH+49Tsbmgg9yUop2N9qXIxM1lBMHLX7mAPHURpIF61dJc4kP1fmY/X
 HjghxPfgZ2XnIFuTFt9VV68t4HsCWhSM31rjsuK3G64CZ5DIv+2Vq2/uxErDV6nPV1zHxJzJb3a28
 WO0P6s291cK/xe5MVdkW4G75ep6CydzTeebPTIYVc7/6ajkO+g5qFD6E5Md82wOwIVMr8dkZPtneK
 MLrDpq0FnQ8EOSl4EqixwlpMtET1u+UQjEZnyAZVN2L7tVxOWeuVcYWPItOP7NJF84+K0iatN6rzR
 nTy+IwmltlBogUf1Yq9OP2dslxLFclJCisWQagm9lgWwPCsFDBE5AcmEtxkClrafTGyp0Q3cX2JpU
 LrJxCrb4amIorxHw1AdqRLnkTP7BFaDXl5Bvs6zSA=;
Received: from [2a00:23c4:8bb4:4000:502:30b7:7825:e35a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUu4u-0002QJ-ST; Fri, 19 Jul 2024 21:19:48 +0100
Message-ID: <e49735e8-1c33-42cb-9181-662a0c010b97@ilande.co.uk>
Date: Fri, 19 Jul 2024 21:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240719151628.46253-1-philmd@linaro.org>
 <20240719151628.46253-4-philmd@linaro.org>
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
In-Reply-To: <20240719151628.46253-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:502:30b7:7825:e35a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/3] util/fifo8: Introduce fifo8_change_capacity()
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

On 19/07/2024 16:16, Philippe Mathieu-Daudé wrote:

> FIFOs can be resized at runtime. Introduce the
> fifo8_change_capacity() method to do that.
> When capacity is changed, the FIFO must be reset.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/fifo8.h | 10 ++++++++++
>   util/fifo8.c         |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index c6295c6ff0..9fe0555a24 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -31,6 +31,16 @@ void fifo8_create(Fifo8 *fifo, uint32_t capacity);
>   
>   void fifo8_destroy(Fifo8 *fifo);
>   
> +/**
> + * fifo8_change_capacity:
> + * @fifo: struct Fifo8 to change the capacity
> + * @capacity: new capacity of the FIFO
> + *
> + * Change a FIFO capacity to the specified size. The FIFO is reset.
> + */
> +
> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity);
> +
>   /**
>    * fifo8_push:
>    * @fifo: FIFO to push to
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 2925fe5611..c453afd774 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -34,6 +34,13 @@ void fifo8_destroy(Fifo8 *fifo)
>       g_free(fifo->data);
>   }
>   
> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity)
> +{
> +    fifo->data = g_renew(uint8_t, fifo->data, capacity);
> +    fifo->capacity = capacity;
> +    fifo8_reset(fifo);
> +}
> +
>   void fifo8_push(Fifo8 *fifo, uint8_t data)
>   {
>       assert(fifo->num < fifo->capacity);

The changes look okay, however I'm a little confused as to why this is needed as 
generally hardware FIFOs are a fixed size? Presumably this is related to the PL011 
series?


ATB,

Mark.


