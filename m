Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hHiXhPcY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkv4-0008VD-Qq; Fri, 30 Oct 2026 07:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMkv3-0008V4-R4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:37:13 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMkv1-0004Fe-WC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:37:13 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6f74f6b46abso330314eaf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793360230; x=1793965030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k6r6hnO0mKNQHsTZoVmSvqjlwYYMmPOfQWtXDAa5K7A=;
 b=hHiXhPcY1fJqwn1FooucgkZvASPYBJEDxd7jyQELRUSmsfTbYHrKeSP72HwP9lL4ka
 jDAJuZ/pKvT+56bf3chTghm+6JDQG6gJ8sXZOPrskuBftBCh5Ez+pZVE5kiJPNtnGDzv
 Afk+u/LeGvL4cDdZ3IdxHmpogEws/jWDsi/D4KdkLcNyxJBQcsz1rELIGsIKz1Jb3xTt
 r49cN0Xr5xZZceRmd4TWp9yotZEvqDPQZQEBYWAjCoXhH3N5DjAHtY7uIZvOIk0T50SF
 /goZi3TtjHM9bDJtG7mvhAJPY7ma4WVcIj9d5NdRlpeLPxn+3IHws4O7jmjZf13H/fQY
 1qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360230; x=1793965030;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6r6hnO0mKNQHsTZoVmSvqjlwYYMmPOfQWtXDAa5K7A=;
 b=MsGQBP8phKFJ13aOUXL65MkQZU4eOf9LNNtDu47BGIH4z2OOWBP+B1rWhFx7levp7G
 rnNx+rnyU79emVqQxGW5B0BAhRzTg3xtumraEHEDSupgAgtCwCT+QDFgvTLNj3KME3uI
 lUvX9Qm/nBkJirY5GgToyL8DBThjWtRzsJM7X2q7N/Pm6bp5V4Hqk17NlhczQKv7SoWU
 LeFqESkg9h6pPMVoN0W+xN+k7xxB/f/4fsK0jz7JNGjMkEv2vtPIZHdGUEvzDHpBCqFV
 XBpBSYTrZz7xterWnbjAvUah4goWYDfJjNk4E/ULaX79286RoThSEXo0T6l+hPQ8QvCc
 IxOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTJW0sczotiVFx0OvcwsSKOgW7jHzxOG3xxuRj96nWwPY0DJR0bknRWdVzTGHZybzZ7LH1FUP9UEqe@nongnu.org
X-Gm-Message-State: AFq9FYLPlaMmUj6j9YI0dT0/D9J2uqYoemFLBECgD8ts//vrO8AZA0XN
 LP8fC33IlCtx4Ld1vufsUByn0KT3whqDbw1royktGHF/dAE0ly+lpvAGlwZxecb6YJA=
X-Gm-Gg: AYBFou1ZTZ6R99RTuOQuqpyiV15672IUuX2JuoqUvXS54DsaDL0oqzeSNeLg9UHJxSn
 ICco92Xb7JJa1cSd9bwzpSJalg31gRlxAGhh3fIixc9HogwWqCdrUGVXdz57wW0v4QIZGZqtx7V
 CJyMP9afDGBHE2usUTw9ssxffWf8GfzckhS1Mwe1tZd0uzbVnMyMKBN0Z5QqyMyYoDAhyyN1WyA
 JCckMLPfXFiY8qzoPtX2PEIkMVDOWbCE8sYpPDcmq5OKtl6JQ9ZWo516l4q4ibOqcv94Cx0nK+c
 7qsbi4vQiTY5HvSlr+ArnaZT8FdQ2kkNhB5RmSRygmUXjxl/NB7lnSuPRFlWHoSoPDI92BwFK8y
 L8/EsIe7roILLSKEMcUmKF4vJ9Ughxwe40nQGON7SFip/h2oWsnTNBW+SXosRk3BrDW4UXKwV9p
 XwaFseeyITq3vYg4DqdxVO258u/eeuRGVt6u1hNnPMkgadV5czedh6FBvzCQkqIJbuU7IyAgvoN
 SJbz9CZHOVEB5dLHyTAPIvkBa4/+c0g5nbIF0Eihnc2F58FjmwN++sJdK2qmBz9aQ5d/5+L57fM
 nEpFksGBaMmoQqvFEaGOjP7dSgUZPSiT8XNXyWS3X5kd
X-Received: by 2002:a05:6820:55c9:20b0:70d:86e6:6f03 with SMTP id
 006d021491bc7-714f2421890mr830995eaf.6.1793360229893; 
 Fri, 30 Oct 2026 04:37:09 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4dd00sm1579985fac.5.2026.10.30.04.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 04:37:09 -0700 (PDT)
Message-ID: <451d1cfb-a94e-40c1-bb10-a768c5701f9b@linaro.org>
Date: Fri, 30 Oct 2026 06:37:07 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: terminate a tcg block on gen_RDMSR
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20261029171737.2126803-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029171737.2126803-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 12:17, Alex Bennée wrote:
> End the block the same way that gen_WRMSR does so an IO access under
> icount. While this fixes this particular case I suspect there are more
> IO like accesses the x86 TCG front-end should take care off.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4779
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index ed56edf8a3a..911bce5f539 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3783,6 +3783,7 @@ static void gen_RDMSR(DisasContext *s, X86DecodedInsn *decode)
>       gen_update_cc_op(s);
>       gen_update_eip_cur(s);
>       gen_helper_rdmsr(tcg_env);
> +    s->base.is_jmp = DISAS_EOB_NEXT;
>   }
>   #else
>   #define gen_RDMSR gen_unreachable

You've done nothing to update state.  I think you want

     translator_io_start(&s->base);

which will go though DISAS_TOO_MANY.


r~

