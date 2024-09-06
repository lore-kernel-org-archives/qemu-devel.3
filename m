Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E427FE6FE48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 20:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smfts-0005CK-QN; Fri, 06 Sep 2024 16:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smftn-0005Bk-OV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:49:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smftl-0002nX-JS
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3Q90XV1CD7XPabi2hfaBrJTXvCP8PZVdC/Fk7GwT2zU=; b=jHHidoVmYqvZnazQPgQMfm0tj0
 KzM4rMl4IXoFAZdZnpRxtBlktLqBsG7Si6M1oAV2//JY4NUCFnqECJ6q8qQzv1mzglAskodCKjQ0g
 EQxWVzo4hFE+WOhIOrAHauOTKOr3Xg4eNN8Y7rQAEf/eE1YfQdXEJ0lGo1N8tB7AJZCGh6uPi9YCb
 bQh2Yphcr4q+7/7OwclNXKGQgCMXzDiDZheOCiiPri8t9fI0zZEwr3EtE7QyF4EpFlpgjYTd/ZhmG
 cv/+H0om7R5B4CZpK5p7GrL5ADU9Btam4J9IcWV5VDZ/wB1FC9S7TKHlTX1chNY44GRj7KiU2D0Xi
 bWJ8PZ5BTMIIOZBGyRN3By1vc8lBPOvSq/6paNdQ7xEgx2ecdDZPiSPh87Cz99Yzles1Pi4DkcqrN
 A22BQGY9yP4fK/hkwwNvWimZeuGWeCHn6iKEBRMCZMDBb7WtsuQH6b3qz4lx6m8DvjjCSg7LXWVEb
 yvy/nYDq+bTbL9faeF5qq0ai3K39sUHhcRy1TR/oHyCT/LpdZI9+wfnOkR8nBYAMW4LCROZwQgo40
 V5Q2hYDcUtqbyCsF/SEzo44HAg03znF3NhL1uQXr9laNNTOGJjeiW5EtqV5+ND7KQ97M+RsAvC2UL
 ILHbF4YW+iF5KPFmaJNhwJUisEYgpAo+WSEsPiQiA=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smftc-000BPH-B8; Fri, 06 Sep 2024 21:49:36 +0100
Message-ID: <18d9d323-675b-4c43-b277-0628a4d72fcf@ilande.co.uk>
Date: Fri, 6 Sep 2024 21:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
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
In-Reply-To: <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 9/9] tests/unit: add test-fifo unit test
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

On 28/08/2024 13:22, Mark Cave-Ayland wrote:

> This tests the Fifo8 implementation for basic operations as well as testing for
> the correct *_bufptr() including handling wraparound of the internal FIFO buffer.

Hmmm this doesn't quite read correctly either - I think perhaps something like:

This tests the Fifo8 implementation basic operations as well as testing the 
*_bufptr() in-place buffer functions and the newer *_buf() functions that also handle 
wraparound of the internal FIFO buffer.

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   tests/unit/meson.build |   1 +
>   tests/unit/test-fifo.c | 256 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 257 insertions(+)
>   create mode 100644 tests/unit/test-fifo.c
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 490ab8182d..89f9633cd6 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -47,6 +47,7 @@ tests = {
>     'test-logging': [],
>     'test-qapi-util': [],
>     'test-interval-tree': [],
> +  'test-fifo': [],
>   }
>   
>   if have_system or have_tools
> diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
> new file mode 100644
> index 0000000000..1e54cde871
> --- /dev/null
> +++ b/tests/unit/test-fifo.c
> @@ -0,0 +1,256 @@
> +/*
> + * Fifo8 tests
> + *
> + * Copyright 2024 Mark Cave-Ayland
> + *
> + * Authors:
> + *  Mark Cave-Ayland    <mark.cave-ayland@ilande.co.uk>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.

Regarding your comment on using SPDX is it also worth replacing the above two lines with:

     * SPDX-License-Identifier: GPL-2.0-or-later

?

> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "qemu/fifo8.h"
> +
> +const VMStateInfo vmstate_info_uint32;
> +const VMStateInfo vmstate_info_buffer;
> +
> +
> +static void test_fifo8_pop_bufptr_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    buf = fifo8_pop_bufptr(&fifo, 2, &count);
> +    g_assert(count == 2);
> +    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
> +
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    buf = fifo8_pop_bufptr(&fifo, 8, &count);
> +    g_assert(count == 6);
> +    g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
> +             buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
> +
> +    g_assert(fifo8_num_used(&fifo) == 2);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pop_bufptr(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    buf = fifo8_pop_bufptr(&fifo, 2, &count);
> +    g_assert(count == 2);
> +    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) == 2);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_bufptr_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    buf = fifo8_peek_bufptr(&fifo, 2, &count);
> +    g_assert(count == 2);
> +    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
> +
> +    buf = fifo8_pop_bufptr(&fifo, 2, &count);
> +    g_assert(count == 2);
> +    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +
> +    buf = fifo8_peek_bufptr(&fifo, 8, &count);
> +    g_assert(count == 6);
> +    g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
> +             buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
> +
> +    g_assert(fifo8_num_used(&fifo) == 8);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_bufptr(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    buf = fifo8_peek_bufptr(&fifo, 2, &count);
> +    g_assert(count == 2);
> +    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) == 4);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pop_buf_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_out[4];
> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    fifo8_pop_buf(&fifo, NULL, 4);
> +
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    count = fifo8_pop_buf(&fifo, NULL, 4);
> +    g_assert(count == 4);
> +    count = fifo8_pop_buf(&fifo, data_out, 4);
> +    g_assert(count == 4);
> +    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
> +             data_out[2] == 0x3 && data_out[3] == 0x4);
> +
> +    g_assert(fifo8_num_used(&fifo) == 0);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pop_buf(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8 };
> +    uint8_t data_out[] = { 0xff, 0xff, 0xff, 0xff };
> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    count = fifo8_pop_buf(&fifo, NULL, 4);
> +    g_assert(count == 4);
> +    count = fifo8_pop_buf(&fifo, data_out, 4);
> +    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
> +             data_out[2] == 0x7 && data_out[3] == 0x8);
> +
> +    g_assert(fifo8_num_used(&fifo) == 0);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_buf_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_out[4];
> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    fifo8_pop_buf(&fifo, NULL, 4);
> +
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    count = fifo8_peek_buf(&fifo, NULL, 4);
> +    g_assert(count == 4);
> +    count = fifo8_peek_buf(&fifo, data_out, 4);
> +    g_assert(count == 4);
> +    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
> +             data_out[2] == 0x7 && data_out[3] == 0x8);
> +
> +    g_assert(fifo8_num_used(&fifo) == 8);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_buf(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_out[] = { 0xff, 0xff, 0xff, 0xff };
> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    count = fifo8_peek_buf(&fifo, NULL, 4);
> +    g_assert(count == 4);
> +    g_assert(data_out[0] == 0xff && data_out[1] == 0xff &&
> +             data_out[2] == 0xff && data_out[3] == 0xff);
> +
> +    count = fifo8_peek_buf(&fifo, data_out, 4);
> +    g_assert(count == 4);
> +    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
> +             data_out[2] == 0x3 && data_out[3] == 0x4);
> +
> +    g_assert(fifo8_num_used(&fifo) == 4);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t c;
> +
> +    fifo8_create(&fifo, 8);
> +    fifo8_push(&fifo, 0x1);
> +    fifo8_push(&fifo, 0x2);
> +
> +    c = fifo8_peek(&fifo);
> +    g_assert(c == 0x1);
> +    fifo8_pop(&fifo);
> +    c = fifo8_peek(&fifo);
> +    g_assert(c == 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) == 1);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pushpop(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t c;
> +
> +    fifo8_create(&fifo, 8);
> +    fifo8_push(&fifo, 0x1);
> +    fifo8_push(&fifo, 0x2);
> +
> +    c = fifo8_pop(&fifo);
> +    g_assert(c == 0x1);
> +    c = fifo8_pop(&fifo);
> +    g_assert(c == 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) == 0);
> +    fifo8_destroy(&fifo);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/fifo8/pushpop", test_fifo8_pushpop);
> +    g_test_add_func("/fifo8/peek", test_fifo8_peek);
> +    g_test_add_func("/fifo8/peek_buf", test_fifo8_peek_buf);
> +    g_test_add_func("/fifo8/peek_buf_wrap", test_fifo8_peek_buf_wrap);
> +    g_test_add_func("/fifo8/pop_buf", test_fifo8_pop_buf);
> +    g_test_add_func("/fifo8/pop_buf_wrap", test_fifo8_pop_buf_wrap);
> +    g_test_add_func("/fifo8/peek_bufptr", test_fifo8_peek_bufptr);
> +    g_test_add_func("/fifo8/peek_bufptr_wrap", test_fifo8_peek_bufptr_wrap);
> +    g_test_add_func("/fifo8/pop_bufptr", test_fifo8_pop_bufptr);
> +    g_test_add_func("/fifo8/pop_bufptr_wrap", test_fifo8_pop_bufptr_wrap);
> +    return g_test_run();
> +}


ATB,

Mark.


