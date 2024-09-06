Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C3BE6FE49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 21:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smg51-0001ok-As; Fri, 06 Sep 2024 17:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smg4z-0001o8-Qp
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 17:01:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smg4y-00043s-5S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 17:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Bketme1o9llSMNljoKULeDyu9G8p4DAAu7jv9WM3goo=; b=z7TlyxyfVftGaKByJY+24kRfIi
 6rbhd1dv9ZGluJbdlgS+eNpO8CU+4M8Qgl1TxkWI19QatlxWpFHuJ2x7NIlCgFow7FydkCpQrFig2
 zJO1D5FifGd7wpUMWUyJ1UC3RDUMJNvCTx+8kqUp6cLg4AfLwv9Bx5iLfSYyPyIwcqCDj8i+HF1My
 hExMJb8/5PaXkieJHo/s/8f69QLJrzStGryYJ9DRC7fwBX8efJdoauc9QNtb+4CAcFGPi3ojs8hko
 yL9bJQrgC5yMSxV3U9ekgR/ixnIKOZRmhMm2nYEyznd5zsAq5ue8coWxNqGifFTdULLH1WNfbEl5f
 POVSnJnnu2Rf2tvnt8e4BkJgIIrgZR/2L+tx8iBZsoZBNf1wTTsrYd4TRIAB0MFsQxqVecCmS8DWG
 cvSsSx0586mM2VcUnGia0MlNuxxpg3ncYqcgPfi5A9gGApLofQJX5YqPjlIfvIbG6a54kZGQSJeU9
 H9HSvsw1Z4Zuln9LrZmnr9UhbQS+2aJ/6DURGBtT8o/7aWelzVdYwN2bQQ/NziMTQEuBbOdl3Nzmq
 2U5WGUczCEMDvRltAz5rM9pmNpd/jmWXVRD0O4fU0ADbdD/7rENhJh3B9RinTCm7RufjVK9dYJiUt
 i6nkEiD/x7gZ3lfuy45Vw7C3AR9UOxRMZoDknqclA=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smg4p-000BT9-Kh; Fri, 06 Sep 2024 22:01:11 +0100
Message-ID: <79716288-ab10-496a-9938-126125e92f63@ilande.co.uk>
Date: Fri, 6 Sep 2024 22:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Octavian Purdila <tavip@google.com>
References: <20240906132909.78886-1-philmd@linaro.org>
 <20240906132909.78886-2-philmd@linaro.org>
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
In-Reply-To: <20240906132909.78886-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 1/3] tests/unit: Strengthen FIFO8 tests
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

> Replace reused bytes { 0x1, 0x2, 0x3, 0x4 } by { 0x9, 0xa, 0xb, 0xc }
> to be sure a different value is overwritten.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/unit/test-fifo.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
> index 1e54cde871..9b3a4940d0 100644
> --- a/tests/unit/test-fifo.c
> +++ b/tests/unit/test-fifo.c
> @@ -22,7 +22,7 @@ static void test_fifo8_pop_bufptr_wrap(void)
>   {
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> -    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
>       const uint8_t *buf;
>       uint32_t count;
>   
> @@ -65,7 +65,7 @@ static void test_fifo8_peek_bufptr_wrap(void)
>   {
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> -    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
>       const uint8_t *buf;
>       uint32_t count;
>   
> @@ -112,7 +112,7 @@ static void test_fifo8_pop_buf_wrap(void)
>   {
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> -    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
>       uint8_t data_out[4];
>       int count;
>   
> @@ -126,8 +126,8 @@ static void test_fifo8_pop_buf_wrap(void)
>       g_assert(count == 4);
>       count = fifo8_pop_buf(&fifo, data_out, 4);
>       g_assert(count == 4);
> -    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
> -             data_out[2] == 0x3 && data_out[3] == 0x4);
> +    g_assert(data_out[0] == 0x9 && data_out[1] == 0xa &&
> +             data_out[2] == 0xb && data_out[3] == 0xc);
>   
>       g_assert(fifo8_num_used(&fifo) == 0);
>       fifo8_destroy(&fifo);
> @@ -157,7 +157,7 @@ static void test_fifo8_peek_buf_wrap(void)
>   {
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> -    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
>       uint8_t data_out[4];
>       int count;

That's a fair point: otherwise it could be easier for a bug in the Fifo8 
implementation to slip through:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


