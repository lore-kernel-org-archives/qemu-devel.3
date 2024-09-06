Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB3E6FE4A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 21:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smgE5-0002Wu-4v; Fri, 06 Sep 2024 17:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smgE4-0002WK-DM
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 17:10:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smgE2-0004uY-Bx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 17:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=JzNr1q7pECI0IiQU5zHY+qRWYQAN0m9cNqCdcUXIIss=; b=r7id1wXweBuc0wREr3aou/TflC
 CEkoWw1i8bup04VRW0YYVVzq6SkWOD8Qk2kCue/dJ2fN3VFZcPUjRYn1ALmLfEivqYo0w1Q6pPceg
 PmfM7S4WA+/gXRoSp2JxvntzoGncUPo4mn7229GXZ0lomA60wZYruGnAiLpGdfngnE8gtcA1GbYfT
 +eptsv/fcnKyIUV425muBmGfTDR8McEyLq6U6JIGR4d2POZD9G6fQesN4YllWA1srZ3n1A0KiLwLJ
 DERH+t7r4HLxl9xW1uXr0OlWarCKo+w7cCjNHTUF5GC41oUeidyiPBE3De+/Jx6LSA3zrBW5PpoGo
 gj84T2x4WSJl5QbfpMvEsm6Gpq2HEo/fpEaU2lOhEADw+s5j+BZ+1pUyJAH/0sOBOKct7E7J+2fIM
 EMB0r57cSRXSr17w5FVJcqh38dqHn2oxlmSUvdIDc8fZIHamenCQbZubmmDlHFG/uMIaidzWvDuTh
 UbhA/DgTJyzDzeD4rM66UuKnuVO9TYtvc0kzoGTlU1ZWRqmvgpjMbMFvzBfGxeIR9r374ToktD6J/
 tKhssXaUMO6Z8ds30Jbm9ng7qvgO1X7tgbAYwh/ZhW+k76avmcWZ/MXZLLK0pe0E/ya9hgi5MiqDo
 vADNXsihVj/XGzLZd1qxcO8JqDjmrLtl/9lGFuLTc=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smgDv-000BXK-8s; Fri, 06 Sep 2024 22:10:35 +0100
Message-ID: <e87c4a87-d61d-4929-95c2-7a263406bea5@ilande.co.uk>
Date: Fri, 6 Sep 2024 22:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Octavian Purdila <tavip@google.com>
References: <20240906132909.78886-1-philmd@linaro.org>
 <20240906132909.78886-4-philmd@linaro.org>
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
In-Reply-To: <20240906132909.78886-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 3/3] tests/unit: Comment FIFO8 tests
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

> Add comments describing how the FIFO evolves during each test.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/unit/test-fifo.c | 188 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
> index fada526b6c..14153c41fa 100644
> --- a/tests/unit/test-fifo.c
> +++ b/tests/unit/test-fifo.c
> @@ -27,14 +27,36 @@ static void test_fifo8_pop_bufptr_wrap(void)
>       uint32_t count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: [ . . . . . . . . ]
> +     */
>   
>       fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: [ 1 2 3 4 . . . . ]
> +     */
>       buf = fifo8_pop_bufptr(&fifo, 2, &count);
> +    /*
> +     *      head --v  ]-- tail      used = 2
> +     * FIFO: [ 1 2 3 4 . . . . ]
> +     *  buf  --^                    count = 2
> +     */
>       g_assert(count == 2);
>       g_assert(buf[0] == 0x1 && buf[1] == 0x2);
>   
>       fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    /*
> +     *     tail --]v-- head         used = 8
> +     * FIFO: [ 9 a 3 4 5 6 7 8 ]
> +     */
>       buf = fifo8_pop_bufptr(&fifo, 8, &count);
> +    /*
> +     *  head --v  ]-- tail          used = 2
> +     * FIFO: [ 9 a 3 4 5 6 7 8 ]
> +     *  buf      --^                count = 6
> +     */
>       g_assert(count == 6);
>       g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
>                buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
> @@ -51,9 +73,22 @@ static void test_fifo8_pop_bufptr(void)
>       uint32_t count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: [ . . . . . . . . ]
> +     */
>   
>       fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: [ 1 2 3 4 . . . . ]
> +     */
>       buf = fifo8_pop_bufptr(&fifo, 2, &count);
> +    /*
> +     *      head --v  ]-- tail      used = 2
> +     * FIFO: [ 1 2 3 4 . . . . ]
> +     *  buf  --^                    count = 2
> +     */
>       g_assert(count == 2);
>       g_assert(buf[0] == 0x1 && buf[1] == 0x2);
>   
> @@ -70,18 +105,45 @@ static void test_fifo8_peek_bufptr_wrap(void)
>       uint32_t count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       buf = fifo8_peek_bufptr(&fifo, 2, &count);
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     *  buf: [ 1 2 ]                count = 2
> +     */
>       g_assert(count == 2);
>       g_assert(buf[0] == 0x1 && buf[1] == 0x2);
>   
>       buf = fifo8_pop_bufptr(&fifo, 2, &count);
> +    /*
> +     *     head  --v  ]-- tail      used = 2
> +     * FIFO: { 1 2 3 4 . . . . }
> +     *  buf: [ 1 2 ]                count = 2
> +     */
>       g_assert(count == 2);
>       g_assert(buf[0] == 0x1 && buf[1] == 0x2);
>       fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    /*
> +     *  tail   ---]v-- head         used = 8
> +     * FIFO: { 9 a 3 4 5 6 7 8 }
> +     */
>   
>       buf = fifo8_peek_bufptr(&fifo, 8, &count);
> +    /*
> +     *     tail --]v-- head         used = 8
> +     * FIFO: { 9 a 3 4 5 6 7 8 }
> +     *  buf:     [ 3 4 5 6 7 8 ]    count = 6
> +     */
>       g_assert(count == 6);
>       g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
>                buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
> @@ -98,9 +160,22 @@ static void test_fifo8_peek_bufptr(void)
>       uint32_t count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       buf = fifo8_peek_bufptr(&fifo, 2, &count);
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     *  buf: [ 1 2 ]                count = 2
> +     */
>       g_assert(count == 2);
>       g_assert(buf[0] == 0x1 && buf[1] == 0x2);
>   
> @@ -117,14 +192,38 @@ static void test_fifo8_pop_buf_wrap(void)
>       int count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       fifo8_pop_buf(&fifo, NULL, 4);
> +    /*
> +     *         tail --]v-- head     used = 0
> +     * FIFO: [ 1 2 3 4 . . . . ]
> +     */
>   
>       fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    /*
> +     *         tail --]v-- head     used = 8
> +     * FIFO: { 9 a b c 5 6 7 8 }
> +     */
>       count = fifo8_pop_buf(&fifo, NULL, 4);
> +    /*
> +     * head  --v      ]-- tail      used = 4
> +     * FIFO: { 9 a b c 5 6 7 8 }
> +     */
>       g_assert(count == 4);
>       count = fifo8_pop_buf(&fifo, data_out, 4);
> +    /*
> +     *         tail --]v-- head     used = 0
> +     * FIFO: { 9 a b c 5 6 7 8 }
> +     */
>       g_assert(count == 4);
>       g_assert(data_out[0] == 0x9 && data_out[1] == 0xa &&
>                data_out[2] == 0xb && data_out[3] == 0xc);
> @@ -141,9 +240,21 @@ static void test_fifo8_pop_buf(void)
>       int count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       count = fifo8_pop_buf(&fifo, NULL, 4);
> +    /*
> +     *         tail --]v-- head     used = 0
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       g_assert(count == 4);
>       count = fifo8_pop_buf(&fifo, data_out, 4);
>       g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
> @@ -162,19 +273,45 @@ static void test_fifo8_peek_buf_wrap(void)
>       int count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       fifo8_pop_buf(&fifo, NULL, 4);
> +    /*
> +     *         tail --]v-- head     used = 0
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    /*
> +     *         tail --]v-- head     used = 8
> +     * FIFO: { 9 a b c 5 6 7 8 }
> +     */
>       count = fifo8_peek_buf(&fifo, NULL, 4);
>       g_assert(count == 4);
>       count = fifo8_peek_buf(&fifo, data_out, 4);
> +    /*
> +     *         tail --]v-- head     used = 8
> +     * FIFO: { 9 a b c 5 6 7 8 }
> +     *  buf:         [ 5 6 7 8 ]    count = 4
> +     */
>       g_assert(count == 4);
>       g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
>                data_out[2] == 0x7 && data_out[3] == 0x8);
>   
>       count = fifo8_peek_buf(&fifo, data_out, 8);
> +    /*
> +     *         tail --]v-- head     used = 8
> +     * FIFO: { 9 a b c 5 6 7 8 }
> +     *  buf:         [ 5 6 7 8 9 a b c ] count = 8
> +     */
>       g_assert(count == 8);
>       g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
>                data_out[2] == 0x7 && data_out[3] == 0x8);
> @@ -193,14 +330,27 @@ static void test_fifo8_peek_buf(void)
>       int count;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>   
>       fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     */
>       count = fifo8_peek_buf(&fifo, NULL, 4);
>       g_assert(count == 4);
> +
>       g_assert(data_out[0] == 0xff && data_out[1] == 0xff &&
>                data_out[2] == 0xff && data_out[3] == 0xff);
> -
>       count = fifo8_peek_buf(&fifo, data_out, 4);
> +    /*
> +     *  head --v      ]-- tail      used = 4
> +     * FIFO: { 1 2 3 4 . . . . }
> +     *  buf: [ 1 2 3 4 ]            count = 4
> +     */
>       g_assert(count == 4);
>       g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
>                data_out[2] == 0x3 && data_out[3] == 0x4);
> @@ -215,12 +365,28 @@ static void test_fifo8_peek(void)
>       uint8_t c;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>       fifo8_push(&fifo, 0x1);
> +    /*
> +     *  head --v]-- tail            used = 1
> +     * FIFO: { 1 . . . . . . . }
> +     */
>       fifo8_push(&fifo, 0x2);
> +    /*
> +     *  head --v  ]-- tail          used = 2
> +     * FIFO: { 1 2 . . . . . . }
> +     */
>   
>       c = fifo8_peek(&fifo);
>       g_assert(c == 0x1);
>       fifo8_pop(&fifo);
> +    /*
> +     *    head --v]-- tail          used = 1
> +     * FIFO: { 1 2 . . . . . . }
> +     */
>       c = fifo8_peek(&fifo);
>       g_assert(c == 0x2);
>   
> @@ -234,12 +400,32 @@ static void test_fifo8_pushpop(void)
>       uint8_t c;
>   
>       fifo8_create(&fifo, 8);
> +    /*
> +     *  head --v-- tail             used = 0
> +     * FIFO: { . . . . . . . . }
> +     */
>       fifo8_push(&fifo, 0x1);
> +    /*
> +     *  head --v]-- tail            used = 1
> +     * FIFO: { 1 . . . . . . . }
> +     */
>       fifo8_push(&fifo, 0x2);
> +    /*
> +     *  head --v  ]-- tail          used = 2
> +     * FIFO: { 1 2 . . . . . . }
> +     */
>   
>       c = fifo8_pop(&fifo);
> +    /*
> +     *    head --v]-- tail          used = 1
> +     * FIFO: { 1 2 . . . . . . }
> +     */
>       g_assert(c == 0x1);
>       c = fifo8_pop(&fifo);
> +    /*
> +     *     tail --]v-- head         used = 0
> +     * FIFO: { 1 2 . . . . . . }
> +     */
>       g_assert(c == 0x2);
>   
>       g_assert(fifo8_num_used(&fifo) == 0);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


