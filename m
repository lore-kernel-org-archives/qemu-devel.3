Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E46C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 02:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjV3A-0007a9-8k; Wed, 28 Aug 2024 22:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjV38-0007Zc-NF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 22:38:14 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjV37-0003FV-48
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 22:38:14 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5b1e33fa8so95853eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 19:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724899091; x=1725503891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4qqJbpY0D9TuB+JOVR24DieoWrXq9yX0m0CfHgIjpqs=;
 b=IKtqe+VXiuZfWI0w87a53BjRI52IT/N/36pRqfX0pDwU/VuXrhR/gr7bbwDDckCsKM
 ga/eDnGyPHSUb4taS7rHxY+HJ2IGzTTkTAr4BvEK/naHKXx0Fo1VHmMarEBjILQvTA0V
 U4hc3055GVfb7dpDB1wZe7O6WI6MGjFLZpa/UbD3TjolGJh1QL1BhEaK9Sb3w292HSu3
 G1uxaA1KNZrebxC840LStB8SKKeI6xYdj+S3iXC3o6WLiJGzYTgkbWfJ1YwvoTjysRWh
 MQBesmFRtK3IvEP/3L8YGAuc4sDN33yDlcVl7SXf9qDQ3JQKr+lc3Ks+0FCx4oV78RfE
 0F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724899091; x=1725503891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4qqJbpY0D9TuB+JOVR24DieoWrXq9yX0m0CfHgIjpqs=;
 b=Ql4w8+oIoz+BZYbKnwiYtGsBZXRCtr8qTSUuGl9mMWXtGOzTFPo1VvCxhGcgsslRuC
 hkQLWmB7HB7RFDQH014g1BicdnotGzdo2TDO920udhW18xQ0JQNCB5qGNZZ0LX+PDDWp
 ZmJtCZTcQVxwk0NXy41dB8hqpfh4loqgspbEyjKZoI2vrJcp0DYpwNQLfWLgx+EFMAfV
 64Dt9YWsIhXHr/j7fWMaBsT4DSEnn/xqwYfwXyYm9G55kD4kXUzCZa2g/osZqp+ao9Ys
 MFGPVXQp6NtiZRnzq18q3+CYBuxz7p1TjKOAxlaYXK147gWkFauB+h9N+0SvS43pLfZ0
 5NgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5OY/Aru7JXdR3ckJjjLK1fOE1NbbBb17/90CJtYzsjVks9i96CVh9TdMArHq/CXgVx1cMx/xB5/2Q@nongnu.org
X-Gm-Message-State: AOJu0YwbnWCY64zxWh8QlWVVrlTwE55R2hL70g3tizQFkGgUGgFBv3wN
 dl0xJFj3hY4eRZjabSVPdCYaIUV18yu9vtQhpAn0HK29iu4wWpuH/skyC0Ep05Q=
X-Google-Smtp-Source: AGHT+IEB817FX66/wX0jnbXuPfuo2X7PzW+Zn88h9PWk99MFX3cAVQMsC6pXZBApyHuB8LR6dcz9ug==
X-Received: by 2002:a05:6820:4d02:b0:5dc:96ff:ae12 with SMTP id
 006d021491bc7-5df980c89f8mr1822802eaf.8.1724899090626; 
 Wed, 28 Aug 2024 19:38:10 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dfa047e4a8sm54776eaf.7.2024.08.28.19.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 19:38:10 -0700 (PDT)
Message-ID: <b8fe65c4-c7ee-4f01-98df-65ff304a3eb2@linaro.org>
Date: Thu, 29 Aug 2024 12:38:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-hppa-user: crashes immediately in hppa chroot
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
References: <Zs9am5fIuo3eXoKF@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zs9am5fIuo3eXoKF@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 8/29/24 03:12, Helge Deller wrote:
> Hi Richard,
> 
> I tested qemu-user from v9.1-rc4 for hppa and noticed that it crashes
> immediately when starting a hppa chroot.
> 
> I was able to bisect the segfault back to
> commit 081a0ed188d8d9d9038f00337d331d185a7ae331
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Wed Mar 27 13:04:00 2024 -1000
>      target/hppa: Do not mask in copy_iaoq_entry
> 
> This commit does not apply to git head any longer, but when I instead
> apply this (modified) patch the segfault vanishes:
> 
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -664,6 +664,11 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
>                               const DisasIAQE *src)
>   {
>       tcg_gen_addi_i64(dest, src->base ? : cpu_iaoq_f, src->disp);
> +
> +#if CONFIG_USER_ONLY
> +    uint64_t mask = gva_offset_mask(ctx->tb_flags);
> +    tcg_gen_andi_i64(dest, dest, mask);
> +#endif
>   }
>   
> Any idea or suggestion to fix it?

More specifics are required.

root@stoup:/opt/chroot/hppa/sid# ./qemu-hppa -L . ./bin/echo foo
foo


r~

