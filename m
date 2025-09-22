Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D3CCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0f1m-0000Jd-Jt; Mon, 22 Sep 2025 07:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0f1S-0000Bj-TQ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:48:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0f1P-0005r9-S2
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:47:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso28155415e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758541673; x=1759146473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxMI+RPuI8Yfkxb9R5hRcmHy8ISCUSMyAOCpO3OF0GU=;
 b=MBgq6W9I7TqfG1IpcDz62jUZ30D6lY5oaM1mJzswOEew3611+9S1YsU3e1MOBZYse9
 CB/mADZqQdIncE5TQHgd2e7KIX4xRhKlBLw7WuGnFyNFonhzKTcjGAy9VT8o/vopoHhR
 CpDhHSeZKXLQBLthdFhBan6o+nUKd6GTr6pkJXvS2Hse6rgDYESzC9zEUTrYhB8r/VgK
 65eNhsyfNE0IKxvF++v7f+o3K5SwIDp8y0k3oTMTSoaqzbriFIAvaiXwK1AuqmTNBIhI
 IWnw5+pY7dOWpwwqE57I8h9QfNq1tynY6lzOjxr4rZi2QifjRFRIWgvtxo9PLDlzjRRI
 cEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758541673; x=1759146473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxMI+RPuI8Yfkxb9R5hRcmHy8ISCUSMyAOCpO3OF0GU=;
 b=PY4FNCiBkWwvjMx2lYTzIF+KqzlNsIOEOsbdn0Rdzk1U5xOfFohWuC21fSiOkNSxkX
 1/7PaD8BU16EOfFyW4IFqSriZaBLyynqQYnNVpsXs9sCZMhT6/jRogJvwgWdBzY6KXWm
 PewvXfLuVTSQxvHXUsQfE+X+P4lcKpqHlt+aQfVzHw4MRuXkmZtQvh4T8bsrYmvT8STo
 z+ZN5ix4yOLha8HYsDQdMTi3F2o3duJW+Bs8nyjKTE/KqEfL6/rMn6C7Da99RB/a02Xr
 0pQblUxPciF8Uy3fUiBMp1zFQNbDzwd+l0+FF5WMRJwzkLn/jegfXX4U4ydboFrFmR2h
 WvEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJGovfoJh9YFDeIThc8uqz9L8vAqmeX1I7r+EMu5PeNm9wEW/wv5KgOlA8NeCbGcbIotGmoZxUONG+@nongnu.org
X-Gm-Message-State: AOJu0YzPJf2JBg3XIohlRvNcvwOgUXT9ROZKEIrrCcMwP3ID0QeTrkBl
 rfHCliHHbK5DC1j+P1+LQwhuMkF9o4FxfQnMqlVHZI7gM29PzitcWmFVo3wqtfWAgZQ=
X-Gm-Gg: ASbGncs2oeJrqxvnG1dzhmF63Y9VaH3osMgzZF4XeYHIX2o3yuGxHjL7aTezND16YZm
 ec+DFtSiKON8rBp2A84kK9pX0oK9I9brHOZlQb1u84SFzkS8E1nmbNjfISNv/qRQeJOQgm7Bljx
 CGvT/Yjyc5lu8DzEbL4PTL/EOb6Plf1Q1MvtLj2SvuNKmOix9ffL7lf22Ol/Ct7SnLFUpviPyLl
 LLa14dW84uh4auG79zD5C0eqym0hiIoiqmfuQhyk7F578BrDsHNRoFkh+dg6WS22vbpWlkJV7jx
 ugehEyekF6Qhzi3jpmLt8z0WKt8BCKXtk3BMlZNIJc/TFsyPlK2okKmS7uEaBTvdIXMlGFLUWZ1
 PC9E1xfOCL+OK9P2lJJD85Jy4NF8w7qdGZ8Zeqi98URliOcIBMyLDGjwME9WNURYw2Zep5JLZdQ
 L1
X-Google-Smtp-Source: AGHT+IHOh6W+rIGTzMWdiiGZiqDq41vGelHh5n9ANUBskRrL/EWuxMwmx2HUcppcRcZpyfA6IMHdKw==
X-Received: by 2002:a05:600c:9a5:b0:46c:e3df:529e with SMTP id
 5b1f17b1804b1-46ce3df54dfmr19175555e9.19.1758541672889; 
 Mon, 22 Sep 2025 04:47:52 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4697f473191sm128478735e9.22.2025.09.22.04.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:47:52 -0700 (PDT)
Message-ID: <4226caa6-9f8e-4079-a4c6-13e557120eef@linaro.org>
Date: Mon, 22 Sep 2025 13:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/25] target/xtensa: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
References: <cover.1757018626.git.neither@nut.email>
 <e54cd13ab5f6471e319816d34d50f4882e37c4e3.1757018626.git.neither@nut.email>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e54cd13ab5f6471e319816d34d50f4882e37c4e3.1757018626.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Julian, Max,

On 4/9/25 22:48, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for xtensa targets.
> 
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/xtensa/exc_helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
> index b611c9bf97..fdc522698d 100644
> --- a/target/xtensa/exc_helper.c
> +++ b/target/xtensa/exc_helper.c
> @@ -32,6 +32,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   #include "qemu/atomic.h"
> +#include "qemu/plugin.h"
>   
>   void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
>   {
> @@ -207,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
>       CPUXtensaState *env = cpu_env(cs);
>   
>       if (cs->exception_index == EXC_IRQ) {
> +        uint64_t last_pc = env->pc;
> +
>           qemu_log_mask(CPU_LOG_INT,
>                         "%s(EXC_IRQ) level = %d, cintlevel = %d, "
>                         "pc = %08x, a0 = %08x, ps = %08x, "
> @@ -218,6 +221,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
>                         env->sregs[INTSET], env->sregs[INTENABLE],
>                         env->sregs[CCOUNT]);
>           handle_interrupt(env);
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>       }
>   
>       switch (cs->exception_index) {
> @@ -238,9 +242,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
>                         env->sregs[CCOUNT]);
>           if (env->config->exception_vector[cs->exception_index]) {
>               uint32_t vector;
> +            uint64_t last_pc = env->pc;
>   
>               vector = env->config->exception_vector[cs->exception_index];
>               env->pc = relocated_vector(env, vector);
> +            qemu_plugin_vcpu_exception_cb(cs, last_pc);
>           } else {
>               qemu_log_mask(CPU_LOG_INT,
>                             "%s(pc = %08x) bad exception_index: %d\n",

Should we call qemu_plugin_vcpu_hostcall_cb() in SIMCALL opcode?


