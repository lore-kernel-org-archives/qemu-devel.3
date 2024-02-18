Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60E0C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 11:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbetu-000458-GF; Sun, 18 Feb 2024 06:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbets-00043d-VS
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 06:00:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbetr-0006JI-8G
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 06:00:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4125e435b38so7430175e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708253997; x=1708858797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHKcay7KFj+8RMo3TjVFKKFvfy8qKespzrZ5hQy7ae0=;
 b=JjwzaPXY5x4JJSPph7DO2eaFjPwC6pBFW9eWu+gD/JiBiSL4BbcAaNVc8jRjkK7SzG
 UMLMiszSU+8PqbwX1yFITxWdE0PuWMKqk5h0j6YMQhPzLKEJnBOyxQAWOwPKChEIlEqD
 qZemrEOpjgHJtJvXwv0tlLNdPoo0Acz5BJqwVNTsZ37MLeewrzUlkv28gv84s8I5/vUc
 0Go8SsGIuUsjo468a8sKjZYhz/Ks/Q4KK/lM6NOMGSzeT69hOZCnm47zgCpzcHZqWS4S
 p4YDZj5T62j+9auaTX0Uwwf9EsVVIYIJpVN8sNb+FkXjzE4Kf0LnEIpWc3olBszSYcYx
 sFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708253997; x=1708858797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHKcay7KFj+8RMo3TjVFKKFvfy8qKespzrZ5hQy7ae0=;
 b=uRyTLu80YWD8g5MFUwjtH2alKTuf8xhdipApDnHVZN7vdJZOPFvPbNlR/yWpZSZOw1
 Akl6ve7w/YIvpPtZhiRdjbL/4GUZD5WSkoNdu3I/KW2UjcByqJtH/0K+XpyNRaL5NEy+
 /V11bkhiInC76u6tUsP8Tuj7u79GH+3pscz5h9pxzjsuJnijjYFCVekZgHtIhvbBy7az
 vgJubxbYC9Ei9gAhLcEmYjZwtoKKb7FW61An8MrehiioylJ5+LLUCB9czXjL/T2l2veX
 u/BcakbRuaSSiVVBw+3I8dv0gPKpcMdlyBuAm+n2P324cREhKO1iCzD+J7uREt6wIsr0
 6I9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxfSnsfRyn92gamE52AXNkx3GjsgkcsIHWY1hH3V33JNcpJyJwGYSygk2KuxMGhpN3YB/h759T5CIMiUHWQ0t111PWf4E=
X-Gm-Message-State: AOJu0YxICCrGl50WyHp2h6jGYcb4ka6pYtk74jEqlWrJknS7O3kj1XXG
 D0yLT58H9gWWB7ZqSSflUy3YMPuKmnvdh7gvVyHj9qbvRigFuWPph4a0ikgDt5Q=
X-Google-Smtp-Source: AGHT+IHZqH3lOc2rZfjA1ZsaHCutAQxNOsR7cL6MYW2Id39sOx6yVnurmknvfYXaSDWhi9dr6LyDWQ==
X-Received: by 2002:a05:600c:1913:b0:411:d3e8:42cc with SMTP id
 j19-20020a05600c191300b00411d3e842ccmr6835825wmq.32.1708253997312; 
 Sun, 18 Feb 2024 02:59:57 -0800 (PST)
Received: from [192.168.69.100] ([176.176.153.199])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a05600c354600b004107686650esm7857907wmq.36.2024.02.18.02.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Feb 2024 02:59:56 -0800 (PST)
Message-ID: <9fc0c2c7-dd57-459e-aecb-528edb74b4a7@linaro.org>
Date: Sun, 18 Feb 2024 11:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/aarch64: Apple does not align __int128_t in even
 registers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240216214547.10350-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240216214547.10350-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/2/24 22:45, Richard Henderson wrote:

Please include your comment
https://gitlab.com/qemu-project/qemu/-/issues/2169#note_1777369822

---
Apple differs from the standard ABI in the alignment of __int128_t.

 From Apple's documentation:

   When passing an argument with 16-byte alignment in integer registers,
   Apple platforms allow the argument to start in an odd-numbered xN
   register. The standard ABI requires it to begin in an even-numbered
   xN register.

This is confirmed with a simple test:

   void g(int w, __int128_t x, int y);
   void h(void)
   {
       g(-1, 0, 1);
   }

which produces

	mov	w0, #-1
	mov	x1, #0
	mov	x2, #0
	mov	w3, #1
	bl	_g


using Apple clang version 14.0.0 (clang-1400.0.29.202).  Note
that the x argument (the zeros) is loaded into x1 and x2 and
the y argument is loaded into w3.

On Linux, using the standard ARM ABI, this compiles to

         mov     w4, 1
         mov     x2, 0
         mov     x3, 0
         mov     w0, -1
         bl      g


Note that the x argument is loaded into x2 and x3, and the y
argument is loaded into w4.
The TCG JIT must be taught about this difference for MacOS.
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Cc: qemu-stable@nongnu.org
> Fixes: 5427a9a7604 ("tcg: Add TCG_TARGET_CALL_{RET,ARG}_I128")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2169
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> See the gitlab issue for complete discussion of the ABI.
> 
> r~
> 
> ---
>   tcg/aarch64/tcg-target.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index ef5ebe91bd..85d5746e47 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -55,7 +55,11 @@ typedef enum {
>   #define TCG_TARGET_CALL_STACK_OFFSET    0
>   #define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
>   #define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
> -#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
> +#ifdef CONFIG_DARWIN
> +# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
> +#else
> +# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
> +#endif
>   #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
>   
>   #define have_lse    (cpuinfo & CPUINFO_LSE)


