Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCD7E6FE49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 21:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smg6A-0004x7-VG; Fri, 06 Sep 2024 17:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smg69-0004tB-Sy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 17:02:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smg68-00047u-DU
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 17:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AGo9sRpxlzrCreQE8jaGgnb6feBFh5LGLyEJK43zdqE=; b=NR5KGsqSThjve7wrqs9DMcdt0J
 kM+FYDGqDakFW5UtkjvPKC9RFdAKs/M8/rPLax8/fJ6i6PZNTx6BBj0wXmvCzgWItpP2yqvxcQp6N
 0iU3hTVHOTUupfd4p84khsUqmrJjoDJrel3cadCYbtS0m73jEHJkl3o9WFBFAjS3hkKtZiUin5sRg
 tX5+7QJpt4C9ARTosZr9v70Jj4+Jv9ZW+foEANdp5n/D8Kfk+7YGyHAjsDraGYEKTziL0Z9RDqxSH
 v45yb9U+3Xe5Rjixtoh/JMkO1YfwQ7G0kFKJ+MQ+hP/03HZdIRs/vcMIAN5M860hb0S5RXlv1mLuh
 gkb5yaLhIHWY8RzCDuAjHJwu99rEJqEjPuDKe111mJhPG7erMwRzFeNf664c46TMGDprzzxsOear6
 I+X6B+D7o335OJjDltpDM62G0s+QQhZ8evsg7n5UXX3u6UCmEgNDREtKaqrKo4nVPNyLBBeHgYBsW
 LAC/momWgONAGRlIa1XasSH7kdYhkwfZeWYeUzjg20xcIa67OAXd1NpFua/NkQmpCAyHfPW0DDdk6
 8Fe58zaqE07CNaGVPC5RBKn32WAwLSNFvE66J0FoZwnV8aES9/Sh4MLslfpA0vos1wteCerSPmCKJ
 dFagbbs91dPyQvjIJ8ESsBcgHxonkC+nukiblYTEQ=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smg61-000BTf-Ry; Fri, 06 Sep 2024 22:02:25 +0100
Message-ID: <d1469a79-a23f-4156-86f2-58973d2e0303@ilande.co.uk>
Date: Fri, 6 Sep 2024 22:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Octavian Purdila <tavip@google.com>
References: <20240906132909.78886-1-philmd@linaro.org>
 <20240906132909.78886-3-philmd@linaro.org>
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
In-Reply-To: <20240906132909.78886-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 2/3] tests/unit: Expand test_fifo8_peek_buf_wrap()
 coverage
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

On 06/09/2024 14:29, Philippe Mathieu-Daudé wrote:

> Test fifo8_peek_buf() can fill a buffer with wrapped data.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/unit/test-fifo.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
> index 9b3a4940d0..fada526b6c 100644
> --- a/tests/unit/test-fifo.c
> +++ b/tests/unit/test-fifo.c
> @@ -158,7 +158,7 @@ static void test_fifo8_peek_buf_wrap(void)
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
>       uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
> -    uint8_t data_out[4];
> +    uint8_t data_out[8];
>       int count;
>   
>       fifo8_create(&fifo, 8);
> @@ -174,6 +174,13 @@ static void test_fifo8_peek_buf_wrap(void)
>       g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
>                data_out[2] == 0x7 && data_out[3] == 0x8);
>   
> +    count = fifo8_peek_buf(&fifo, data_out, 8);
> +    g_assert(count == 8);
> +    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
> +             data_out[2] == 0x7 && data_out[3] == 0x8);
> +    g_assert(data_out[4] == 0x9 && data_out[5] == 0xa &&
> +             data_out[6] == 0xb && data_out[7] == 0xc);
> +
>       g_assert(fifo8_num_used(&fifo) == 8);
>       fifo8_destroy(&fifo);
>   }

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


