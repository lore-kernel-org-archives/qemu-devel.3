Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97804606A882
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SResa+YC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvb9-000760-8J; Fri, 13 Nov 2026 13:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvaj-0006lt-Or
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:01:44 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvag-0001wU-3d
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:01:35 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ed1f1a7695so4855885ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794592892; x=1795197692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9O4nZIOyY3KoUcaYT+xDwHIBtUE+yQrlv04O2eU8w38=;
 b=SResa+YCn596I25hAUBK5lKBYj289TOOk9x7YFtZDvlXafnOEKtVObuylLPzQzgn2X
 rbiyxAxxbAQsIEHrig+9hiimzTcoXjGnsoa8JS+uhiP05CMpI5wz6VU/r7E3n0hMmhvN
 jcdp49vEjD4gWvfy6w+J4n8BQ5SFxWbp2qt+7e/UD8u7h2fPgKrJwp8/GpuCaHaveICo
 5Z98D61IvUZAoGIX7HOzkqvdl4oQhTFTXzTHSAMfuWn2/opLKEmOCKwXLhtWdAnGFTRT
 psX9+GjouCOCxyCuDRS4mxJsQ9vVbi3KjJy9aRm/HdLUFeAFQDTiQD7KaTej/jpOwt6S
 uXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592892; x=1795197692;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9O4nZIOyY3KoUcaYT+xDwHIBtUE+yQrlv04O2eU8w38=;
 b=nXG2Z+vWwjEPzFd29Dm0i0e17ixMTvI/M9RfwwZUsEp6hfNDo2+ffMdHPRYCySDYms
 ylKcSQUg+jv7YKfFe7CRupXi83d/s8wZmbidoG9ImybNXateU030smHbgbDLkq4YUJcK
 KIBZUqfKDQMtYWXcz9Rye+5OZe1ODyNQBYTaDQpQhJN7XHilrzjwB+NIoM3Cv8K16rO+
 DfpAIuyDoP2y/t8j3uNp352XnHZGDUeTD6Pz84rJZDKRO7SeKz0bjXt+3lIDnpAHNrue
 UEf4KF/c12AbzzwJeLyRQcmFpdsL2PGGuOKYmtbrqi3eF792QfPsVYlNNgUk5jFBc4WT
 jw1w==
X-Gm-Message-State: APuU4Z9Y2YBlLTg0gVtMI4iWh5v5XVeMX5vmrj4CbjI+4N8UWyeElaTV
 OxYXgxwpjbTc8AYIPJbHgLMHU1AY9NZTUuceUkbz01vmf8xnyFyKA1GRUHKYDG0+d1t6B4QCJWy
 JhTYFqfQ=
X-Gm-Gg: AYBFou0W5FSuliYcoFmqPBdUlOKcSTwW6bOBusUskLKblTiQE/p36/PwArr0jUhPPmS
 Lh2jLMA/efRKJoJwK2o1QBfK9H+Pk+LJB73ownMhIQGEeVjfgVhAc9uLHt9gkufEWYELJSBrtdB
 GMmMdk9w5Pyb+8fBx4l6jSjGC2kKVdIVdHjSsjTPdhbpLn+vpVhA+YPrhRxsV8B8uy68FrCwMQ2
 NoV0ioTWPIE3cnhzEIr3VZmGLefyTOi4t/SGex5GbPH7/2RD3rTu69DYLZs0+WRL3Bv5NmqPcIk
 3WBYdHosqP7zqSkdYuwG841tdzZUuh9E1gzutLEv6pLQFfzyvN9unu5APtUiJ0eH+gCg2ZotNli
 3kh6iKzIrAQwBosoR9r8miQQqiDMA5Sa4AjeFyRInXf13qOxtrIyXfDlUfxuTrfpHr8LGpuPBfO
 B3O/Ac/q5iMXlzttPxUQEAQQelz6ArLXcM7vii5R2RBEU+zDFuauVXXdsQk9Y2hzQQrSpGfaVH3
 YoOyHmidkKlx9UCXIGGy4CpV04l80T/E4f0rQSqR5laplSGfZY9BJ9CJi/kowTaE+6RCc+fW5RH
 FXSONu4ub2GzWndOIcyG5C9aLh2n6LEF8sEzqipAry4=
X-Received: by 2002:a17:903:3887:b0:2ed:130f:8689 with SMTP id
 d9443c01a7336-2ee0dcc5b1emr26074045ad.61.1794592891650; 
 Fri, 13 Nov 2026 10:01:31 -0800 (PST)
Received: from [172.31.6.230] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f8623a8sm13770085ad.48.2026.11.13.10.01.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:01:31 -0800 (PST)
Message-ID: <00b09ae3-04f0-46ae-85da-82a48f25d4cd@linaro.org>
Date: Fri, 13 Nov 2026 11:01:29 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: remove unused argument of decode_ops
To: qemu-devel@nongnu.org
References: <20261109185659.1068793-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109185659.1068793-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 11:56, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index b91e3718cb5..731434ff50b 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2827,8 +2827,7 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
>   }
>   
>   
> -static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
> -                       X86DecodedInsn *decode)
> +static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>   {
>       X86OpEntry *e = &decode->e;
>   
> @@ -3608,7 +3607,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>           }
>       }
>   
> -    if (!decode_ops(s, env, decode_func, &decode)) {
> +    if (!decode_ops(s, env, &decode)) {
>           goto illegal_op;
>       }
>       if (!validate_cr0_exceptions(s, &decode)) {


