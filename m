Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8BACEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 22:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdFpO-0004wr-GN; Tue, 06 Jan 2026 17:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdFpN-0004tt-A2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:47:01 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdFpL-0002Nc-O7
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:47:01 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c84ec3b6eso1750652a91.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767739617; x=1768344417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYYl0h2YtNXwYIldVou7Qpz0KnSHFg1wSRMKIChho+Q=;
 b=Gt7imOvEgBFLPjQWvXZd+AK5ooD8egXP01k76M0XDxbMQN6pW1EmwtMce4LpgZvPxj
 SzZNmW8qVZlUhIxff9YmxeRo+BN8cjYuaRK2LnxD0AsmHkJwPjQOQ5U/bxw/wqvs/p++
 09XzlvxJRkcu1sxZyHMSElL5ve0X8S1OnyyhUl4IN0aqEXZNu2SGLFp3AEagu0ET6qJd
 yQTrY/86xCiM2RirPclGmPk9MxqBGxwLoeNhhG+jMb/ZR2lQN3WjgVZfKpnKoTun1uZf
 G2aqQt4XpYhNbEH/jTf5cmjoOu4jACniIfo9dAAjd7nz05ggmkK61g/LCO3h2u+LDr5b
 lOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767739617; x=1768344417;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VYYl0h2YtNXwYIldVou7Qpz0KnSHFg1wSRMKIChho+Q=;
 b=EB6VXpnhxxrRm+CJmWqqvxTUO+egcXE6vKGZ8SWXfy23QVP5CPLCOABlV6zghtUWK8
 O3TMBJ/gK//illBX1qoCN6M6RqpQ9xhd1IL6ROQ54y8E4TdPWJufPVkB3EhW3sAbUYDt
 GtbOPajUK+Iq7Fc7n55HEo0I29aKvBmTQsQtULGyPubyHPjJbh8ynP2yA54pONnPO3+H
 aHoNnpF2SvTtNTSWni7HAenRRzDs/Q9nix6UDTOGshrb3ZzjNBIa2Gm6R+xEgSEiWcU8
 UqITHj9ukGulxSdXo6bYfG2J2LNGLBt9m9CFhRW/cG/nvGyv4s6sxQ/7/CkWYvZ9dMhR
 R1jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJSgF/TUs0wv+Hisgcv4PnUsrpovR7jGs0keBcXDebZF4rbe181o9QuSLEFPwxOxOHc2F793Hbogs8@nongnu.org
X-Gm-Message-State: AOJu0Yz/vGi+MryGKIrJTYVNo5IOq/a6j+2TS8pGxTTA/jxdNTZ12Q7j
 /9DnC7gGnctIIRJyqJjux5H9F+hh1Ky9CWiRliCQunmR5ZY7q0hdEJ8YzbJQxa6UBIw=
X-Gm-Gg: AY/fxX6MmTyJntuMyBVfGqCOs+h5A+BlqvFoHhb1GA8LVIDN6dv2D9Q9urZbnwcZ0SH
 Ys3KHwKHnqFFLbzOKVLkeLYsunTJ+dN5bdr3rOQ/t+ay2f8zf9q6+CsDh9P/XRnWoerKWsaRtCU
 NHxuTDo3an1CCbsaBG9diDU/2LjIfiRxzAv3AyP/t/jORBe1y5BJZKFx0AoHTIKQTSrbU0/3up6
 fGNNxhoB0p4pI8g2ugGs9rMYcOxAGI+mXqCuINsgXUTkrVSnvEfH4lmUvL6J3Os9Fu5akauGBJf
 ae+UExO50r3pnDSDhA2gtDyxDFmC9/TemZYCi/55icBurgNOdfoaxxnSpN0qhV8yXpIkx+HYw0D
 V2xA+N0eVMCmSk0ungnE2UNTy24pvG9UwDW+vKLg69RVkn89r9SCtWItvmBCpYWx3WndHvzS8IG
 f4ERth7qeUV0zHT2f+al1G3Vo07GTcgw==
X-Google-Smtp-Source: AGHT+IGY76VUTniTDO7+cgFJ8zVkSQxUHo2Cj476jCx8xnmb3gQFY19lBCEx5IVVLcFtUpK3N657vQ==
X-Received: by 2002:a17:90a:e706:b0:34e:7938:669c with SMTP id
 98e67ed59e1d1-34f68cd5980mr561849a91.25.1767739617389; 
 Tue, 06 Jan 2026 14:46:57 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f634bcc21sm1005773a91.4.2026.01.06.14.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 14:46:56 -0800 (PST)
Message-ID: <b1d1e8fa-4936-46b3-8f13-fcfdc58878bf@linaro.org>
Date: Wed, 7 Jan 2026 09:46:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload.c: Correction to HWCAP2 accessor
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20260106-fix-hwcap2-sve2-v1-1-1d70dff63370@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260106-fix-hwcap2-sve2-v1-1-1d70dff63370@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/7/26 02:40, Jim MacArthur wrote:
> get_elf_hwcap was used when get_elf_hwcap2 should have been.
> 
> Fixes: fcac98d0ba8b ("linux-user: Remove ELF_HWCAP2")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3259
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0002d5be2f..35471c0c9a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -708,7 +708,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>       NEW_AUX_ENT(AT_EXECFN, info->file_string);
>   
>       if (HAVE_ELF_HWCAP2) {
> -        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
> +        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap2(thread_cpu));
>       }
>       if (u_base_platform) {
>           NEW_AUX_ENT(AT_BASE_PLATFORM, u_base_platform);
> 
> ---
> base-commit: 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0
> change-id: 20260106-fix-hwcap2-sve2-8ddbcf51b879
> 
> Best regards,

Oops.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued.


r~

