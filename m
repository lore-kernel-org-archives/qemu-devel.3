Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461B5D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC02w-0003Hy-Tb; Fri, 15 Nov 2024 12:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC02v-0003Ho-BS
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:23:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC02t-0001DP-M7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:23:49 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cb47387ceso23835695ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731691425; x=1732296225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nN2un+7U4XmEz/KtFnSp9k/HddZ0Tgp3yyTcAGlxvow=;
 b=SBB3aLYxQrpYOpbYN6+7xLAHq1xT+Sj3TBhbHmYdjQ8cTXd9q3FAoJJuzmGvj+nxTW
 u5xsvCLIb4owZq4jrmEjgdFxoofTzyDzP7ysrqVXuBYjY4WG9zeeH9Qgdn7x0EyEbcbr
 CS8svetOj1OwaTAvuCzXxhqZS6C0s2ItvjFzP4wtrDbLzfOu5DI3N4xJoIYfkPlT+IxZ
 +Q30fzdgeA3du9UgMB9Q5S/uqwISH9tbl2OuBzvvg4bEkpQ1pPers7VkCFi9IeEdSTFR
 VOz1LjnY6MzvDouN0/0BWSi5pmAlEyX7Hivmwn0g5TGaE6/QrgO9Za0oIjWP4Z6taexx
 73cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691425; x=1732296225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nN2un+7U4XmEz/KtFnSp9k/HddZ0Tgp3yyTcAGlxvow=;
 b=r5U4ycSILFGifziGM2x1XlGo2frqvYXwboBBY7sde9jyhXPaGmcMebjzz3d9MKPgIc
 xdOx8vxSHcAxc7k+MSG5JaPWihcJvtjQgdahRvvGyjIB4mztV/TR1Dxy2m81Ti+1XMFr
 VimjzPuHXbpKivGvjM616IkLhxxdDjOrrFdMk2s1Igd3NRV0d6HgqKsFcfR3aRV7amXm
 qi/iqgweCOxjdY/g7uCVPeaZrOFb/3Mli89jG8H6Jelg4x0Ze99rHkaLExcpbVk/Ntwv
 jLtih8SCxuMu9gYV8DaRnXZklJdmKxva3dV2R4hzM/iXCsma2Il63Ki6CiZ5cwnk6MhP
 MonQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyyhS3akUJcmYT1ZDquoC1Uoa0UEWp3GQ8wzFn5mdM7c9OCUtp+0goneu/1Lrul6u3QLMfdymTMhzC@nongnu.org
X-Gm-Message-State: AOJu0YwcuYlW2GaogzSLd2nT2n2qRo27tuwfHDhOtVjMTo2xcpsLVKot
 nrNuqpbKkDVgRnQs2GDoeGttog3FA0jEiKO8fipfyv864WwPLtCkPzdPFSQA9HPlhF+jvklYUPz
 q
X-Google-Smtp-Source: AGHT+IEe405LgwaUa+tgzHJc73qRXgxkokumYt+OZJpVKzTVTV4iEqYqOPat+CHfoDdZ+25yGHPOgg==
X-Received: by 2002:a05:6a20:2595:b0:1dc:3c58:ee78 with SMTP id
 adf61e73a8af0-1dc90b47f37mr4476618637.18.1731691425677; 
 Fri, 15 Nov 2024 09:23:45 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7247711ce4bsm1582951b3a.47.2024.11.15.09.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:23:45 -0800 (PST)
Message-ID: <9796cc60-5efb-4a2d-9437-4832a6c43edf@linaro.org>
Date: Fri, 15 Nov 2024 09:23:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] accel/tcg: Remove cpu_unwind_state_data() unused
 CPUState argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241115152053.66442-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 11/15/24 07:20, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/translate-all.h | 3 +--
>   accel/tcg/translate-all.c    | 2 +-
>   target/i386/helper.c         | 3 ++-
>   target/openrisc/sys_helper.c | 7 +++----
>   4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
> index f06cfedd52..9303318953 100644
> --- a/include/exec/translate-all.h
> +++ b/include/exec/translate-all.h
> @@ -23,7 +23,6 @@
>   
>   /**
>    * cpu_unwind_state_data:
> - * @cpu: the cpu context
>    * @host_pc: the host pc within the translation
>    * @data: output data
>    *
> @@ -32,7 +31,7 @@
>    * function returns false; otherwise @data is loaded.
>    * This is the same unwind info as given to restore_state_to_opc.
>    */
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
> +bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data);

Hmm.  I wonder if it should be called "cpu_*" at all then?
Worth renaming to "tcg_*" or something?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

