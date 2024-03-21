Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7033CD11DB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOfv-0000GC-VU; Thu, 21 Mar 2024 16:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOfs-00009q-Nw
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:06:04 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOfr-0004yJ-93
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:06:04 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-430c76fbf05so9308051cf.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711051562; x=1711656362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xT44wO3PssFz76VTHqsbrAJTdpbeZTsn6CRZFUAW9nY=;
 b=lEfITgaAeXevfLFjYZZjWbHD/Au3DIeRZd6iGi/Yds3oYaEyRoHYbltWZOc+KlvGxr
 OqliKkBFqryAnmV9uFnAa2l9Kj6oGGxKlzi73ji9NAFURavP5qDQWedBawu+y6BY4fWD
 pLjdGL6ylkZMAHGKCbUwaafho7znqLWhj22SiMQP6I7D/Xce6WIJDDvXPOjmNnbgaHjQ
 0cPBTnuWnVU0hmyzE9a+qmvGBP4hfH6kJZSCBWBKmoBpOFO3IP8soLQhqaAtxQxqjfTx
 4PEtJ8X8y9a5wf8HpKWoOjMa+X15stvtjJeurP7ixEizX5ZvfaCToMfL31r/mHd7JRqc
 hUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711051562; x=1711656362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xT44wO3PssFz76VTHqsbrAJTdpbeZTsn6CRZFUAW9nY=;
 b=Tuv48s2jRb6H4H0Jp2pZ/fk0sCazTbNJMKOObpxinhy+qLII4ZFPJZ2V6zTKRhldG5
 GOZFaY2QB1Gybvn4dc/5qGWCl6CVs0ICeYZUQTu9IR2oprmcEaVQ9OCzVBQQehaH/n3G
 LO71MfMz4KEXlo9sBnudqOi8/Yqqb9LTH3IuY+dDfqKByhPl0ta22sxlNhKo4V2PCa8c
 +7ekac8DLZy0sd4ITahOOKqx4p8WULe7btTyxs8rwgo8vpxqW8XjFVDxlL8o8FnaM0p3
 wNsZxefW/q1GByxG9AnJ20DZ9mEyLyj9PhFQWCQ1LuLtKN0irWuU8Z3uEVtmLChdq401
 dSNQ==
X-Gm-Message-State: AOJu0Yym7FPGN5Ai9OgkxUpGmE/SYDWLsCNS/3dbq17gfuY6oom5mG6J
 n0cPy7EAuuYAls4JeMAy5xDuxXGnvqvZgebfS1U7VCo0TGWoMTFU+0LCI96AKlw2Zc62YBNUhO1
 +
X-Google-Smtp-Source: AGHT+IGW/ONHGJe4SKo2DdzYYF36M/hTZO5NUPwPl6+/CC+QCNQlH3XmIvRsJ/M4Y3M3JSiLscZIhg==
X-Received: by 2002:a05:6a20:4a1c:b0:1a3:72d6:641e with SMTP id
 fr28-20020a056a204a1c00b001a372d6641emr439672pzb.20.1711051088596; 
 Thu, 21 Mar 2024 12:58:08 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 u16-20020a1709026e1000b001ddc93c5759sm232860plk.196.2024.03.21.12.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 12:58:08 -0700 (PDT)
Message-ID: <134f8055-6b5a-4610-93d3-524d2f3de003@linaro.org>
Date: Thu, 21 Mar 2024 09:58:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hppa: add unit conditions for wide mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240321184228.611897-1-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321184228.611897-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

On 3/21/24 08:42, Sven Schnelle wrote:
> Wide mode provides two more conditions, add them.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 8a87996fc1..f493e207e1 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -963,11 +963,22 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
>   
>       switch (cf >> 1) {
>       case 0: /* never / TR */
> -    case 1: /* undefined */
> -    case 5: /* undefined */
>           cond = cond_make_f();
>           break;
>   
> +    case 1:

Wants a comment for /* SWZ / NWZ */

> +    case 5:

/* SWC / NWC */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

