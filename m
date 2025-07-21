Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6D1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlzr-0003Lo-2r; Mon, 21 Jul 2025 04:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udlzS-00035C-Mm
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:35:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udlzP-0001k9-LE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:35:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d54214adso28436115e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753086911; x=1753691711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z9hmMkq6WRr+8Xm2fAKfj1k2r2ooPF3YBSZzbDONu68=;
 b=Y5d2e7X1502uJB9fiaTEskZ8bXiKM+u66lLoy3SBirPZxXs32tUUdwrqbnc+zAAGEr
 9RNrqZGdpIygG2vofs7RKvr2z7PvpDen7sPcfhziZd9EBrkHzGx7XHRLfn31OJMd1ujH
 bHqFj8ydrib+gPZfXOomJYgAxOQIygz+hz5QTV7zFvsfyTactDQ9y0VDDkKkihiq1f1I
 EBTIarRs1XyORGVv9CGqoZKokrYdSjJKS1PYSvZnhEkaNsDPya9suuiKdcFITTfcONr3
 GmcE7cGkX4lf7G45PqT/S0KygLXKR9I2EXDt9RELtGFiK7eMki4V82DIbLrYP4KC6Byl
 f3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753086911; x=1753691711;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9hmMkq6WRr+8Xm2fAKfj1k2r2ooPF3YBSZzbDONu68=;
 b=PBLawG1mzshSLFwaNYc30FCfGcW1hLVWGYQI2wBC2gljpDxQ/pc3NiyYKJt4KnR62v
 jZllUh68Y6o/NTIXdTsOMc1dGQLd8RMUcx/8+VZjzPxAF0JQ3daA12zcM0e57VSnlPpH
 3lyxBEWVvUhAbbRCkvgWkIDIJk5ZHCsUsaz39gGHG/vRLavdYhAOlpf6hrEB80IW+VHT
 sVWeohz6mbWAUykHZCbxpmRllifLVfnI+Z73658vIdMsDXbBAeIQfoS/tbhrjdLMFf6m
 vyIl2F6NntArtrRzqHyuDkyINW92f+aFHvbTfljTy7yU56U0cFFNjbrklzljtXqS+sp4
 plKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1eXjkeLsbzGl+PVs1vpnZX67rGrfYzwGQJUl++L3kLDr0+MkHOKELsvwzoqFlQKQZMXhM1CDMs6Vg@nongnu.org
X-Gm-Message-State: AOJu0Ywexg8qggI96ydmdlEJ2LksAZwUdVJ/7AJfIoNoQTUXLmS4VvK6
 dpjikpAOPcDewn+iiZ/9nSFgqSG8Lt62CC8YcVcxBfigCeG/v/XcF4fNwttRFAR0WaY=
X-Gm-Gg: ASbGncs5RbEgk5PmUIExn0Yyz57dR2Z0xkVOlQzAaxU6OmUqr/pn3pjuJyGwOlVs24d
 kdx2VZnfx9QG0LYvsF9qX1wexEGuoRh85hYLSY3Ct/EDSbYCiiuEVWME4QEP19YOBsvp10ZjZej
 VmcpbJ69R74J7dPgVNjP9lyKLkn1uP/cX78I/kPEsMLI/wZAtAIGt0CHFP7cGFT9ixkUk1mrxFu
 3Jt442mBKrHKNot1ToElZ+CBvnSl5WT0RqbJaZ7rxQrS8Be7/U6GRLBaw3zGxKzzBUi4bc/rqhZ
 +Etic7YM199s9htx/ibZgiCQApj4DQ29Yk8537kj4i5XWJ+1pCXsRLFGrv+uNl469HfEgJE0Y/s
 5AiYZ4n0pvkjd2FmVKZCrqfm2uoiHmUQf3MGDodwCCWr5RuztZSO+8Xxd5+a9hM7n2g==
X-Google-Smtp-Source: AGHT+IE3DzfiqDdSjqaAOr8CJICKzCjxxYXvo7roku1fBRqfr9MeVUcuAzSTX6VuNRvG0z11EDN3Tg==
X-Received: by 2002:a05:600c:3484:b0:456:1a41:f932 with SMTP id
 5b1f17b1804b1-4563535d2ddmr116720635e9.22.1753086911082; 
 Mon, 21 Jul 2025 01:35:11 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5a4e40sm95731465e9.6.2025.07.21.01.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:35:10 -0700 (PDT)
Message-ID: <5a57181b-4b17-4de4-bf48-e5222c9ba2c8@linaro.org>
Date: Mon, 21 Jul 2025 10:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] ui/curses: Fix infinite loop on windows
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: William Hu <purplearmadillo77@proton.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
 <19616b23-6b86-4f64-9836-fbfda79c76b8@linaro.org>
Content-Language: en-US
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <19616b23-6b86-4f64-9836-fbfda79c76b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Ping?

On 8/4/25 21:01, Philippe Mathieu-Daudé wrote:
> On 3/4/25 03:07, William Hu via wrote:
>>  From a42046272f0544dd18ed58661e53ea17d1584c2c Mon Sep 17 00:00:00 2001
>> From: William Hu <purplearmadillo77@proton.me>
>> Date: Wed, 2 Apr 2025 12:00:00 -0400
>> Subject: [PATCH] ui/curses: Fix infinite loop on windows
>>
>> Replace -1 comparisons for wint_t with WEOF to fix infinite loop 
>> caused by a
>> 65535 == -1 comparison.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
>> Signed-off-by: William Hu <purplearmadillo77@proton.me>
>> ---
>>   ui/curses.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/ui/curses.c b/ui/curses.c
>> index a39aee8762..3f5c5adf78 100644
>> --- a/ui/curses.c
>> +++ b/ui/curses.c
>> @@ -265,7 +265,12 @@ static int curses2foo(const int _curses2foo[], 
>> const int _curseskey2foo[],
>>   static void curses_refresh(DisplayChangeListener *dcl)
>>   {
>> -    int chr, keysym, keycode, keycode_alt;
>> +    /*
>> +     * DO NOT MAKE chr AN INT:
>> +     * Causes silent conversion errors on Windows where wint_t is 
>> unsigned short.
>> +     */
>> +    wint_t chr = 0;
>> +    int keysym, keycode, keycode_alt;
>>       enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
>>       curses_winch_check();
>> @@ -284,8 +289,9 @@ static void curses_refresh(DisplayChangeListener 
>> *dcl)
>>           /* while there are any pending key strokes to process */
>>           chr = console_getch(&maybe_keycode);
>> -        if (chr == -1)
>> +        if (chr == WEOF) {
>>               break;
>> +        }
> 
> Correct but incomplete, also missing the same check few lines below:
> 
> -- >8 --
> diff --git a/ui/curses.c b/ui/curses.c
> index a39aee87623..9c33de331cd 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -304,9 +304,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
>           /* alt or esc key */
>           if (keycode == 1) {
>               enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
> -            int nextchr = console_getch(&next_maybe_keycode);
> +            wint_t nextchr = console_getch(&next_maybe_keycode);
> 
> -            if (nextchr != -1) {
> +            if (nextchr != WEOF) {
>                   chr = nextchr;
>                   maybe_keycode = next_maybe_keycode;
>                   keycode_alt = ALT;
> ---
> 
> With that:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


