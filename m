Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F00C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoBO-0005zo-8t; Wed, 07 Feb 2024 15:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoBL-0005yb-2s
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:06:07 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoBD-0004Fj-8M
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:06:06 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33b4e5ed890so780412f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707336356; x=1707941156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N37tJ00VgGFI2022Rb5MhedKmpx3N6qNEfBSYXO6aIg=;
 b=goip1U7ouwGHgIQtDXvd7U1K1Vcl8wkgju93n3CghXdl0hRS31DE+dbp/dO9TWbWFI
 d+rL/0+mIs3/KWHddFEbXR2v61ztXhOPpWp0rXdy2UAKUGxi37Np/+uv0ad8dzh3QM7j
 gIr39aHVoLaMy3SV4gILOfekKr+dHVfGOLb8BfmpAVQcbG2/ZqZeJJW7D/XWQ01VU1RJ
 RtJ7H2b2TVfxDPDNbGdAW6T1zRSM6DlF4iBNKCHLCZbh4TRlpClqD2T/uRA5a1bWyAV0
 YgPDKk5vu5uSW7pxO0WuWNGyXnX/RJ+kxRJM0N6EqHuI6tuJhprmApWcuzd6iUCOWlbv
 EOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707336356; x=1707941156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N37tJ00VgGFI2022Rb5MhedKmpx3N6qNEfBSYXO6aIg=;
 b=T7n04MnF7V4Q7r6h+Dfiichu19fgwu/sK6tDgyjD28rYHIYATJ53kjBOMVFw35NUaW
 7dHLhRJ9rGHZSb4EuLeR8VkT7fRHujLZWcYbr1v6+gwc0xc36Mx+wP4s5A5I2qALow/z
 CcNVEBr9e3LilOMURUn6M8T9LoTyfPwCveUusRPmntrauDRbOrd5ePTmXCJlgKn/rYHh
 Z2XPpJoyo+7PG9DzLqLVmraKQavA9jRQAz/2wInTCsppbv1ClBQREdYNCpqNapW3dBPn
 xxROvpTYTAmvooHhPbZ/0p3P8LBMWYQWhCFm2zfAxoudjtFT1cLZulohpTU/yCrQo3Hi
 nEKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaWHDCBNLzXsiggkHa+FRkfMhzLxOY6Fk0bQ3AxZWba5zDIkxB/di0xeT7tJ6Y7t6pmgl7osj2w7hkk0ZUpO2MTn7th9Y=
X-Gm-Message-State: AOJu0YxKWRT0sNRzkmHblEMUw2Rih/OFHPl/Y6IfepeIFMf2Et7bXKAR
 +toL7To+wdjff3bZ87wUZNb4RoHPT7Gk5ZgblpL0Nj9pCuHOfM0Eo9WuiAEUiuw=
X-Google-Smtp-Source: AGHT+IH2Phbmh9ji3XBtWp0SxypZwyrnxN4wclobVGUOTQ60Lti6h6bx32WiwTfHHZlyMCiHOoeMfg==
X-Received: by 2002:a5d:5f44:0:b0:33b:3d35:1ee9 with SMTP id
 cm4-20020a5d5f44000000b0033b3d351ee9mr4781374wrb.37.1707336356137; 
 Wed, 07 Feb 2024 12:05:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUJVJR0bOJSTtz0S8XeGI5oeSDg2FJ3FNQQjaH2ZNeNhEa3w9Clv8ZbA8JrLTQ6fzjP2D0q/6Nxun0B9w4MxeumKK/N/jjy7MDqiShG8ssHlbq9u0nBKpHLN6DRqugmymOsCxxlz5YqdpkWY4hT86R7OHqO412vyhdffRhFbR0DN7G0+zLkdqhh1IFJfW2DavMUANPIPjtZZ0OJQ4ocvql34Iz1uXJcBZ4hGDrrR5ew0RapRbgBmMBmtUoZ5VdhI4qAy6TXJBo4hpfXNt35+erPtox+GXCUH9zL39yx1U3wsmc7BliwtlMIXqaE5jD4GoPigpFQRe4RUlUapXuQXN78dImjl/YbS0cFKhAt02ajU8hlHxN5V/BvfT0C6Uirkj+OLruaBDhZFPzEb5Tf+CWCi90/jkx13P5O3n7Fh5VAfj54I95xFZ5isVY7MA23uyYHC4uSJQJ9eaFSchhUHpqP03RWqrEYml8Eql4Ich4+KMkZBiw4UobCGd6N5RKEwpUXTYbTBdlZYJC5aZYJRSR5dLRblQtL/kgBP6m25QE/NO3Tazn38haKXjs7Rv2KcCAEXNiJLfiL+/wSWt6Dqj8h5R5lrrunxKv2HwkumckvJ6WchC/mmIlmYj5p6SrdSafbmqN4q4L2gzDaI3yQC/k36bGlN0uJogKbP2DXMDd+R8uG2EjAHzaPdj6/h/Uxp7hDBesznxfpdICafFWfhjfBcKV/5Iip0PeqEUBC9Dw7eQvdO7SU3OpRNuNkr/vsi1R8FlEK8ql1RtbmuxxWbEUPUCo5hoLq7dgpH46N7rdZOeLL9lfp7jqEmBNbBpoPxSqsY0ABQ8JhmhR/GTkDsyY9GfCnkeg=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 e11-20020adffd0b000000b0033b47ee01f1sm2174954wrr.49.2024.02.07.12.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:05:55 -0800 (PST)
Message-ID: <3f911aae-542c-45ba-a8c6-eed0626baacd@linaro.org>
Date: Wed, 7 Feb 2024 21:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] gdbstub: Expose TARGET_SIGTRAP in a
 target-agnostic way
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
 <20240207163812.3231697-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207163812.3231697-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/2/24 17:38, Alex Bennée wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> The upcoming syscall catchpoint support needs to send SIGTRAP stop
> packets to GDB. Being able to compile this support only once for all
> targets is a good thing, and it requires hiding TARGET_SIGTRAP behind
> a function call.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20240202152506.279476-2-iii@linux.ibm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/internals.h   | 1 +
>   gdbstub/user-target.c | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 5c0c725e54c..aeb0d9b5377 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -136,6 +136,7 @@ void gdb_append_thread_id(CPUState *cpu, GString *buf);
>   int gdb_get_cpu_index(CPUState *cpu);
>   unsigned int gdb_get_max_cpus(void); /* both */
>   bool gdb_can_reverse(void); /* softmmu, stub for user */
> +int gdb_target_sigtrap(void); /* user */
>   
>   void gdb_create_default_process(GDBState *s);
>   
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index c4bba4c72c7..b7d4c37cd81 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -418,3 +418,8 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
>                       ts->bprm->filename + offset);
>       gdb_put_strbuf();
>   }
> +
> +int gdb_target_sigtrap(void)
> +{
> +    return TARGET_SIGTRAP;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


