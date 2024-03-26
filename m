Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDE6C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp97n-0008F3-5g; Tue, 26 Mar 2024 11:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp97i-0008Eg-MR
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:54:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp97f-0002t9-1K
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:54:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6082eab17so4352756b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711468437; x=1712073237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mTH6NyEYRCwdqaZP4q4VPNh/XegFiVeS6drCaYPsuT0=;
 b=rE1Hz+9n2iKpTBlkCpNAdt+5ZuvyT2KkjqKmVXtXsFnIEtqpGEnqXv/YTFYLlGyWCW
 7rGZ9d15jkypIiQux5PoFPJNHJvba2/2o+o6ePiZxyAmVVkGD1TigUtwu+F9nXiqt1PU
 FcfspwDaiMJf4wNBE55kQFShQgpzVLh9iZjT9lhBLAcg/ufsI49zSDTPw0mG51KPGlOT
 vcn3mokcDA/vapyQPjln2WROrLILI4/RLKj/VOhGY06WFfS4nAN/mQra/H3CAzHQRGBp
 aip5z3QucZJAY6tVxsLBF2I0JiSZJ8N6g/mSShg8bgeIfn9T6qZrw5GMR8cfqfGDUUWK
 ezuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711468437; x=1712073237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mTH6NyEYRCwdqaZP4q4VPNh/XegFiVeS6drCaYPsuT0=;
 b=qaQHMvRG9R2h9ZZolBP5ffR9lwIYRdifeUHmeVVFUP2J/50pVqBVtYfDDObw29WY5o
 /rdKHX9yQxh/nUQPnBtD9BHRk/1b8PWk3AJFwJh/e4S3GBY6AIXsI+ybnuCNQvtAMBhg
 H1GkIP5+jyvucQ21+1GazOq5jAh49mFcEE1gkLY6Iosb1D94CrAyw1oa1XxDX0wrD522
 Ag2ggaG7IXGdPSLeuBrLcWp8hBJ/9h1QYzqQjde0409RlxmFqpXX/OSywqB7+N8weiSv
 Q8mjkYNlETcZ5NuMGnz1Qy+JOGK8RqhbLkBrS3Ll/vVHUqFNK+a3hGOd3zJFK2n+sU5j
 w8fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm5c7Zlo75E4oonNTmlKCrAwN/Ez6T3YVASRKFWO7P8M6qeODwZAtuJY2qtatuspEsioLGD897L2KEJVPU4kvqH6ACza4=
X-Gm-Message-State: AOJu0Yxwa0hkZ/IG1HEvCKZuPRCpO0ofhCpC8a64Y7AUiPWCC8/6xx7y
 hf8Wot+ySKpzJdEef8i4YSjBF37oZApfDvLj5T/mrcMNzHWqioOrq4OSgaRnrU0=
X-Google-Smtp-Source: AGHT+IG/Txea9bMdtJp4aYyPLklKlSm89OBzwO3WqzWOqVfTnVh081OwKZLO2rV0+9ewAmZqEkpvyQ==
X-Received: by 2002:a05:6a21:999f:b0:1a3:42ea:cbed with SMTP id
 ve31-20020a056a21999f00b001a342eacbedmr3551033pzb.44.1711468436985; 
 Tue, 26 Mar 2024 08:53:56 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 r16-20020a63d910000000b005dc5129ba9dsm7606556pgg.72.2024.03.26.08.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 08:53:56 -0700 (PDT)
Message-ID: <bcbf8200-1ffa-4a39-b7b5-e19a65257962@linaro.org>
Date: Mon, 25 Mar 2024 19:20:34 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: target/hppa: be,n nullifying first insn at branch target?
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <875xxa14z1.fsf@t14.stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <875xxa14z1.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/25/24 09:33, Sven Schnelle wrote:
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 7546a5f5a2..56c68a7cbe 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3847,7 +3849,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>           copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
>           tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
>       }
> -    if (a->n && use_nullify_skip(ctx)) {
> +    if (0 && a->n && use_nullify_skip(ctx)) {
>           copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
>           tcg_gen_addi_i64(tmp, tmp, 4);
>           copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
> 
> 
> So i think the problem is caused by this optimization. Does this ring a
> bell? Debugging this is rather hard, alone the logfile above is 6GB in
> size...

The problem is a missing

     nullify_set(ctx, 0)

within this block.

I have patches queued to reorg the IAQ handling, which I hope will fix the problem Sven 
saw with spaces.  It would fix this as a consequence of other unification.  But I think 
it's a bit too big for 9.0.


r~


