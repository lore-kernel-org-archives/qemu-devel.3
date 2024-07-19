Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F82DC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 20:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUu45-0006Bb-Hv; Fri, 19 Jul 2024 16:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUu44-0006AU-Dt
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 16:18:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUu42-0005ya-V6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 16:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+Hj/45MiinYM3J8e1mQ4BS22AnBP1ycNL8cKxp4narU=; b=iibEH6GShym68OED700RomdgUc
 bSithJ8GlpRDb8Nt9AJLvXkaj445ryLSGvQiejuk8dKoo7Vnj4STkOHH4XFVhEDoN7yFNqSHvj2FI
 2SjnQGgAhK4OeF6/n8+ByG19A2GEncwIBK8WWCpOaypljOg+BqKbVBgJujQdglPwfkhnWiDJue8kH
 4OtJCJaZ2M0xY1PHOsZMGyIWBv9wiG0BSanFpN1FdrPrs5WpWC/uodaQdK9n2RovK2eevBFpfCMxN
 +Gaa7yGFtDfUGU8CAgJ9DZv54WxT31EPy+K71pybpZZP2BnC1H/XOgZHTm7exuslvY8FPOnPtnAKn
 KwfGX0A8pQeLcqjBYhef7Hyw+gnzFWDls70mErgBgPYGL4CF84RO4rIdhesUqOK+LuABzT0shkzfH
 iZtixt874rYJj6doUrSUoMRciybrgmKXolEUnHkHnjGV6woz9L4mSFUyd8RuVCIh021jdh5lVJ2f9
 oJ3E2FbxKDA5dUmHYhTUzAAe5eINzFWYYKMvNHxceO1sokvoVWREbPo40TsLXLzWceMDjwX+LLk7E
 kQ2dS5aGiOXfMYBous7OsIpC3v0shgjzQwRjQPu3X68qPaF5K6uSY+IpuPGMs7A2fabzRcjr1gk19
 /m0OORTnWPqHtIkvOP64Qvev6rCyVBYi80kiu1iko=;
Received: from [2a00:23c4:8bb4:4000:502:30b7:7825:e35a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sUu2T-0002PF-4a; Fri, 19 Jul 2024 21:17:17 +0100
Message-ID: <0ef01db1-dcf0-4ee1-a153-6e4d227ec66a@ilande.co.uk>
Date: Fri, 19 Jul 2024 21:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240719151628.46253-1-philmd@linaro.org>
 <20240719151628.46253-2-philmd@linaro.org>
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
In-Reply-To: <20240719151628.46253-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:502:30b7:7825:e35a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/3] chardev/char-fe: Document returned value on error
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

> qemu_chr_fe_add_watch() and qemu_chr_fe_write[_all]()
> return -1 on error. Mention it in the documentation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/chardev/char-fe.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index ecef182835..3310449eaf 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -228,6 +228,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
>    * is thread-safe.
>    *
>    * Returns: the number of bytes consumed (0 if no associated Chardev)
> + *          or -1 on error.
>    */
>   int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
>   
> @@ -242,6 +243,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
>    * attempted to be written.  This function is thread-safe.
>    *
>    * Returns: the number of bytes consumed (0 if no associated Chardev)
> + *          or -1 on error.
>    */
>   int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
>   
> @@ -253,6 +255,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
>    * Read data to a buffer from the back end.
>    *
>    * Returns: the number of bytes read (0 if no associated Chardev)
> + *          or -1 on error.
>    */
>   int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


