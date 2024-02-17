Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD7CC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRBw-0001w4-K9; Sat, 17 Feb 2024 15:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRBv-0001vs-5b
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:21:43 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRBt-0005Uq-JH
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:21:42 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e141a24ba1so957995b3a.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708201299; x=1708806099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XxsxeXp264LrAwX7rNOjhhHq8gi3Jpv2NtritrVS+SA=;
 b=N2eEx9ZZj85YWNkpYuStV/teBbihDgmstd4ewERRROXo23qUjDAdkfO5VXybI3x8sY
 8PjdcCsNg6cD1coyot4TTnA1lZ/yhV9rKzQDlWzFbSv2KIvn47oYFlgyRG1GJgZThhYG
 w6ReDKEII1Ohkx9sT5DZ/VO2ofjBSvIDDm3iRYm8JtGBotprRxW0y0/eI9r9LF7+x7th
 awWCfDd1PDc6bgBGzeVfOAyawgdgaJFgFhJnOI2MqhLzkI0h/c88iPjigJaxXCtZqQ9P
 nrUabxxHXt5zErWpDtMGBrlCENUHOwohNxDn5saCybm4r1wrxO8RAXjyRqrIHrLaEzVT
 NT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708201299; x=1708806099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XxsxeXp264LrAwX7rNOjhhHq8gi3Jpv2NtritrVS+SA=;
 b=C+BT27RNrGoA6cpd5P+LZWg9//wIcsosXk2ZQ2dPVdjOt5Uhf6wBCVkfUvR8H0LovT
 4gSer9kSBMeXsujJ8LGU1+iJgEsuAcMNc2CpCOFRAqbgnyGGaOPGzxthj4p5p7glRw8e
 VY9O1LQipBRWRvUq9CFwEfKv4EtpuuY4m5zFzwnyt+kYtkWlS10J43yhKsdDj9X9dhfb
 B5JP9ZEZJA9hXASz5gBHL0oNXMSJnXWiFmHZmoT2UgEUY3nY1EhrPfRW4Y461X6LW5BR
 uI/gXFzM3XMs7Q3kFgZrE2P0XWg4g1mPCWg1UUvzOAjrKHH2lP5cEIMmvGQDrFkJ9lKH
 oJAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2PXsf89UGjE2+5+DU9OIFW8gJHBo20KwGlDqAQNanuYDZwlbpbsWd2bLccT5DpbE3LaH0LR16FI4a6fLHEX0upWb4dCs=
X-Gm-Message-State: AOJu0YzT7lpbvHYJgCsUJM1IgJeHg3yVPVJoYHstCSwgx3hA0EW1EQvP
 hmEPWjPodlnNihC7wOQ641JoQX9tuUcYxdY+DlCgYRCCFd+2+mdQasTsP/1Eakc=
X-Google-Smtp-Source: AGHT+IF9jQQoSkANoU7rYcPCqmW2w5Ko8RpSY1C2HXt/IOO1wLk3/JX+jwvMnCPmJWBnZeX4u+cnqg==
X-Received: by 2002:a05:6a00:3d09:b0:6e0:a31e:6ee9 with SMTP id
 lo9-20020a056a003d0900b006e0a31e6ee9mr11059169pfb.12.1708201299379; 
 Sat, 17 Feb 2024 12:21:39 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 fd4-20020a056a002e8400b006e0901b71e4sm2043206pfb.48.2024.02.17.12.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:21:38 -0800 (PST)
Message-ID: <8e3732d9-129c-4514-bb7a-d4c5bdca90dd@linaro.org>
Date: Sat, 17 Feb 2024 10:21:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] gdbstub: Support disablement in a multi-threaded
 process
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216130817.369377-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 2/16/24 03:05, Ilya Leoshkevich wrote:
> The upcoming follow-fork-mode child support will require disabling
> gdbstub in the parent process, which may have multiple threads (which
> are represented as CPUs).
> 
> Loop over all CPUs in order to remove breakpoints and disable
> single-step. Move the respective code into a separate function.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   gdbstub/user.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 14918d1a217..e17f7ece908 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -356,16 +356,27 @@ int gdbserver_start(const char *port_or_path)
>       return -1;
>   }
>   
> +static void disable_gdbstub(void)
> +{
> +    CPUState *cpu;
> +
> +    close(gdbserver_user_state.fd);
> +    gdbserver_user_state.fd = -1;
> +    CPU_FOREACH(cpu) {
> +        cpu_breakpoint_remove_all(cpu, BP_GDB);
> +        /* no cpu_watchpoint_remove_all for user-mode */
> +        cpu_single_step(cpu, 0);
> +        tb_flush(cpu);

You only need to flush once.  The cpu argument is used to determine if we can perform the 
flush immediately or need to queue it.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

