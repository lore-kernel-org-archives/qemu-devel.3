Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C66C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rop71-0007zM-96; Mon, 25 Mar 2024 14:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop6z-0007yl-EK
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:31:57 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rop6x-0007Yl-Ht
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:31:57 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c37d50adecso3183797b6e.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711391513; x=1711996313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PggJuBS74bTcM4cE8tca9x7VXq/KIyJFVV/0+yy/rjs=;
 b=YOTY0KvB4FB3rQ/PzpAkOsstlu2WruZX/hy+bzlpajUU5UWv/csXTHKRwjSGLhwOi9
 rSDnD0mA6kViG1UNeoc6YBgbQU5BMId8QWwm87S0Lhb+IMjD+bnuwFHIlJ4P7lj3yNNK
 UuAjV0XRZQ9yqo0Qch42FqmDbdfu+7rP5Ey9HV+U9cknhi0H7/z5Uc2pZ+C6D06H+Xpd
 V7heA1WxYs/l+YHngZWCjUrUJVXAFnQ4m6aeyqJT0IyREEBkPTkivAgC0vb6uNSU1mBK
 YJBZxG3ocIK8+ohdTELy8psoAsOieBqbVhtTseAMo8BiRpZPAjfxJ61XxOLjPn0aaBaV
 nYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711391513; x=1711996313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PggJuBS74bTcM4cE8tca9x7VXq/KIyJFVV/0+yy/rjs=;
 b=VNUjAuHAzABZ8GcyysYhLFBm5ApO+VY0wHo5FHQXGJGAsluJLnyTz98n5tyhSR/J6g
 GQdQENYmz2f0I+2rVT060DxruRaL22IWwwFFwY+TtLBxd4wdaOMlCNObB2LB90iUNFwG
 pmB/pHHMdEdacGxLyRi6xAjODa0VrOIf1Lfh7Wu4ztU1zZb/RTbvSa7X81mMv1waJacR
 O13Af2jARi3ebtX7u/Nf5UuT2Zkj3mZBMLjPhLxQplmixhLO+E+ShDXX6k7vv9RFkQK5
 G+8qCpWukGbJWtksFHEj4Rfl7lJzLUktRjAnPOocG5HR421Ln3YLBv8BBEZEpCuupss0
 YUQA==
X-Gm-Message-State: AOJu0YwM95JgRbDfSdYeGFN86fPL9oPg9AUukTSb/hQL5wRV7DfWiLHK
 BhuOQ+nLhddmrWtN2ArnNvUoaKb3fuebf1gthlDXDfjUbugt5ohEmsajkc2VPEg=
X-Google-Smtp-Source: AGHT+IFer8KCn7GABKsGQr2JpRwliMd5CSAOGPLBtpaBDxD3Jbmj1aC1+BwEUleaPOK/+G7pMzWE+A==
X-Received: by 2002:a05:6808:f0a:b0:3c3:d12c:f307 with SMTP id
 m10-20020a0568080f0a00b003c3d12cf307mr3424436oiw.10.1711391513633; 
 Mon, 25 Mar 2024 11:31:53 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 v64-20020a638943000000b005dc36279d6dsm6113301pgd.73.2024.03.25.11.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 11:31:52 -0700 (PDT)
Message-ID: <18454146-2685-45d9-b435-126346682991@linaro.org>
Date: Mon, 25 Mar 2024 08:31:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] linux-user: Fix semctl() strace
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240325153313.526888-1-iii@linux.ibm.com>
 <20240325153313.526888-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325153313.526888-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 3/25/24 05:07, Ilya Leoshkevich wrote:
> The indices of arguments used with semctl() are all off-by-1, because
> arg1 is the ipc() command. Fix them. While at it, reuse print_semctl().
> 
> New output (for a small test program):
> 
>      3540333 semctl(999,888,SEM_INFO,0x00007fe5051ee9a0) = -1 errno=14 (Bad address)
> 
> Fixes: 7ccfb2eb5f9d ("Fix warnings that would be caused by gcc flag -Wwrite-strings")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/strace.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 9934e2208e2..9be71af4016 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -657,7 +657,7 @@ print_newselect(CPUArchState *cpu_env, const struct syscallname *name,
>   }
>   #endif
>   
> -#ifdef TARGET_NR_semctl
> +#if defined(TARGET_NR_semctl) || defined(TARGET_NR_ipc)
>   static void
>   print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
>                abi_long arg1, abi_long arg2, abi_long arg3,

You can remove this ifdef, because one of the two is always defined.
Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> @@ -698,10 +698,8 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
>   {
>       switch(arg1) {
>       case IPCOP_semctl:
> -        qemu_log("semctl(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",",
> -                 arg1, arg2);
> -        print_ipc_cmd(arg3);
> -        qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
> +        print_semctl(cpu_env, &(const struct syscallname){ .name = "semctl" },
> +                     arg2, arg3, arg4, arg5, 0, 0);
>           break;
>       case IPCOP_shmat:
>           print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },


