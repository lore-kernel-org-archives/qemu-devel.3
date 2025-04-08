Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F430C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 19:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2EIt-0005xm-BF; Tue, 08 Apr 2025 15:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2EIr-0005xW-Hd
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 15:08:09 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2EIp-0005d9-1e
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 15:08:08 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso22194a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744139283; x=1744744083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PoR0k18zL+wCQ8uDu+6XuIQb84rncvjS7RkGXs89FUI=;
 b=jEP2duL+MN8KWkP3xzb+RlRY06WXR67BR6r92foLorNQ3CjDJhvvGw9XmqqYZNRLPE
 vq2HfcPjaBCmm5mr+jrjpDtSmFaXa/CC2TRn+ve5Mu36UnN47JfJGFwN5ViBeSzQjnC7
 T4RxmEFeL8XTxayCk5UxWOOpa5FuffLQZ0XYSeuXETJ85KcfSlbSaFudkPShV0sHJKLj
 7MrKT07yOq9YqZ6GPL1Ilz3c4S+v3ydDaERfd/DC63Sbz4tJ246HXtnGy+iUnlkK1c5u
 Fv+ZUVhnhRqNnnlvjWk870vsLUu8fKcKNj7HwzbpeIKaIl3nj31UTIdcsOaQfRcK7+UE
 aLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744139283; x=1744744083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PoR0k18zL+wCQ8uDu+6XuIQb84rncvjS7RkGXs89FUI=;
 b=O4OHcC/YqyplaWQ/TreVBRYNoKZcJJL7n03q20aQGUsokn4KVLiFF835bT48KK34sz
 bTydaJJl3qw/5+nYqPK36OsK2PxoV/HA0XX/766vsfP16K4qQTC5SJdHmgkOhH491jKx
 apQ/QQGXKFjkr/G7v2wcPgpgpiOz0oMb57XNtlCSFlovprlQDNDBJJvRrImG53jem8Um
 u4chf57v4NFUB3I0LKTa3hnFrjCljVAqehgrVVBQV5XHcL3EANDP9QVM5NYrXLTGqrUP
 92EfMl3g5Gegm/NPX3ZerxGQrYXY6iigSRtr6AYqCSjxs6aFkfsjZyUT5x8hPwjQkgmW
 BAuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp/w/o1ZfLb+a7IgDHnyY+X4uxnf1hceugW/UlR9zQQ1PRGBpSdhxYrOhBS2Y2neVGC8MWuBbE55jk@nongnu.org
X-Gm-Message-State: AOJu0YxYmusMyAjFKUyPmrEqL8Dvq6Apyfm1XWuCxwA/XjqRSySr1L3+
 AjK71alkW8iuc+ctXPPwXVJ4EX6C/bfwzu5AAkYsgQxoanUu9MLjp9fLzLWviFSBYQIe0/75235
 PBmg=
X-Gm-Gg: ASbGncupmTgCfN7wreW/KIuIdEyhd9ujRnkZA4LDvwSGVkFR3D8bS7JF5sPfj029Xhl
 i1xx64tf15q9sKpCJiDKLLccfeNCUZyddSUc/mzHpNc9mXHcOjUROttodmCf+5PGJFGEq6Cr7kq
 79YOpQOwvbuExnh42v3AAgvOVEaTGTpWMb/p4xwOZFM2stHO5uP8b7LzH1hm38oA1Hgj+wQq84S
 Os/Up+4pKd1UCjjjMkkacziddSF1aP79E6h34mHg0W+3esJupkboqrBSVTKNoRyESNi+DA4hTvh
 BL4D5LsANMQmlYTkpfyn1EDodvTzAegGkaL5t3XetTGokmfh8y0qUz6r3pX5aDp8/ZLGyZ/Rzl1
 Nj7BvpltjVopU
X-Google-Smtp-Source: AGHT+IHwTeNyn5lRzn+M3vo150Jj2X/wetmSognclJ4jMy/RIxXhhkLo+FTXKGZ5SMm2FzzS+aq6JQ==
X-Received: by 2002:a05:600c:2151:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43f0e55ecc4mr34997015e9.5.1744138893053; 
 Tue, 08 Apr 2025 12:01:33 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1660bcesm171596595e9.10.2025.04.08.12.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 12:01:32 -0700 (PDT)
Message-ID: <19616b23-6b86-4f64-9836-fbfda79c76b8@linaro.org>
Date: Tue, 8 Apr 2025 21:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/curses: Fix infinite loop on windows
To: William Hu <purplearmadillo77@proton.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 3/4/25 03:07, William Hu via wrote:
>  From a42046272f0544dd18ed58661e53ea17d1584c2c Mon Sep 17 00:00:00 2001
> From: William Hu <purplearmadillo77@proton.me>
> Date: Wed, 2 Apr 2025 12:00:00 -0400
> Subject: [PATCH] ui/curses: Fix infinite loop on windows
> 
> Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused by a
> 65535 == -1 comparison.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
> Signed-off-by: William Hu <purplearmadillo77@proton.me>
> ---
>   ui/curses.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/curses.c b/ui/curses.c
> index a39aee8762..3f5c5adf78 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -265,7 +265,12 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
>   
>   static void curses_refresh(DisplayChangeListener *dcl)
>   {
> -    int chr, keysym, keycode, keycode_alt;
> +    /*
> +     * DO NOT MAKE chr AN INT:
> +     * Causes silent conversion errors on Windows where wint_t is unsigned short.
> +     */
> +    wint_t chr = 0;
> +    int keysym, keycode, keycode_alt;
>       enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
>   
>       curses_winch_check();
> @@ -284,8 +289,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
>           /* while there are any pending key strokes to process */
>           chr = console_getch(&maybe_keycode);
>   
> -        if (chr == -1)
> +        if (chr == WEOF) {
>               break;
> +        }

Correct but incomplete, also missing the same check few lines below:

-- >8 --
diff --git a/ui/curses.c b/ui/curses.c
index a39aee87623..9c33de331cd 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -304,9 +304,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
          /* alt or esc key */
          if (keycode == 1) {
              enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
-            int nextchr = console_getch(&next_maybe_keycode);
+            wint_t nextchr = console_getch(&next_maybe_keycode);

-            if (nextchr != -1) {
+            if (nextchr != WEOF) {
                  chr = nextchr;
                  maybe_keycode = next_maybe_keycode;
                  keycode_alt = ALT;
---

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


