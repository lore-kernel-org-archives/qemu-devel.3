Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA6C67861
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 00:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruLo0-0003Io-7F; Tue, 09 Apr 2024 20:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruLny-0003IQ-Pm
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 20:27:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruLnx-0001Xq-11
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 20:27:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ed2dbf3c92so2271448b3a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 17:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712708827; x=1713313627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgMcAmp+YD886JdrN+/pEeabiQrM8Q3S+gz8JLZo5iw=;
 b=AFYZqtS6nLV9H9cUHLUP6yx/q1AEEDG7iqsLMD6m43XWky7x/PFvrZKjbaUsCxti7k
 qpOwNT+mhoa8xjLkPruzsdVAVB3Hd6WriDWCyNTVLvf+U+CsZV99K3ZEc9yJeZmlD0cq
 +iu9WJYeBYo2VO/9oSuh4nTCIuh483FmUfmeL5Q243SFTufkrjIJA0fq81dybBH0X5yV
 U45p34gFEmjsJ45r6n+vmA3WVJrw6sKa8y33a8ahUg5xyGFvTiakCny+4JRsjUxkAQo3
 jCP7IkGQRZoZGwc/Dezoyo1N8YfFdG8eS66QOg5jx5YPD+BORmwLx0YBd9i8ELa53Iq1
 Yh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712708827; x=1713313627;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgMcAmp+YD886JdrN+/pEeabiQrM8Q3S+gz8JLZo5iw=;
 b=Z9X3FDy8N3pQRQSCzABhuONuuJg6WCQX3PLlR75evUP2JjACODbfs0Nfm3kyqXFgKD
 bn+5fGtl8Stefu9zn73uUfR36mXWv36A751iJbiw7imVKRIlSx3xhDvmdESKpcF/rLVZ
 2L4BZcQFXQ5eOvHDPnc6GgHVVx/GuPh41xUTJ6wPbaXO1z1YPSDK6AIiJ1mXcJwIjwYj
 fT8JU5TcN+iT97qHFf0Z+zIB14XbMzOLrR/8uzE7vyZiHG7xJacFlcTXhmgi+U7nj6av
 IEBPqmzH0SbenFE90HXu5T/ryLww5965jxxWFu0WZOMX1R+2MJ0LsH2VjT3G1PYe6H12
 8hRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7EX48UZC3rwaTjtrwaU7EUXb/ajzQ/xdOkzaU1Q8qejOddc+FN+LfK2G8kZ3x/AdAYUK2/e07Ls45s9WvKtbE5SCpvhA=
X-Gm-Message-State: AOJu0Yz+I62bbN3NJrniwxaUNp4bRnojAnbAxaFK9Cst7Kq2KWT8e8Nf
 SLoj+T8H7BWHomu1d1x7p5TA8cUkqK3EoR6oSjRDzSVN0WT8LsvPBGDSIAeeWP4=
X-Google-Smtp-Source: AGHT+IFsE0C878oRImyL9cajdNYZfTLAZsxK8x0sfsExpXGQo5+omswdaZgj8vjeSn5KJL6/pZChEg==
X-Received: by 2002:a05:6a00:1897:b0:6ec:da6c:fc2d with SMTP id
 x23-20020a056a00189700b006ecda6cfc2dmr1286925pfh.23.1712708826842; 
 Tue, 09 Apr 2024 17:27:06 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a656547000000b005f41aeec262sm1527396pgw.44.2024.04.09.17.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 17:27:06 -0700 (PDT)
Message-ID: <664e1db6-0841-4a77-a8c2-73fc51c009da@linaro.org>
Date: Tue, 9 Apr 2024 14:27:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/28] target/i386: Honor xfeatures in xrstor_sigcontext
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
 <20240409050302.1523277-24-richard.henderson@linaro.org>
 <ecc1ce60-c31f-423b-8d5e-ba5138323212@redhat.com>
 <f67bf3a0-d684-4fe7-af05-bf2c1f273e42@linaro.org>
Content-Language: en-US
In-Reply-To: <f67bf3a0-d684-4fe7-af05-bf2c1f273e42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/9/24 08:09, Richard Henderson wrote:
> On 4/8/24 21:44, Paolo Bonzini wrote:
>>> +        /*
>>> +         * Restore the features indicated in the frame, masked by
>>> +         * those currently enabled.  Re-check the frame size.
>>> +         * ??? It is not clear where the kernel does this, but it
>>> +         * is not in check_xstate_in_sigframe, and so (probably)
>>> +         * does not fall back to fxrstor.
>>> +         */
>>
>> I think you're referring to this in __fpu_restore_sig?
>>
>>          if (use_xsave()) {
>>                  /*
>>                   * Remove all UABI feature bits not set in user_xfeatures
>>                   * from the memory xstate header which makes the full
>>                   * restore below bring them into init state. This works for
>>                   * fx_only mode as well because that has only FP and SSE
>>                   * set in user_xfeatures.
>>                   *
>>                   * Preserve supervisor states!
>>                   */
>>                  u64 mask = user_xfeatures | xfeatures_mask_supervisor();
>>
>>                  fpregs->xsave.header.xfeatures &= mask;
>>                  success = !os_xrstor_safe(fpu->fpstate,
>>                                            fpu_kernel_cfg.max_features);
>>
>> It is not masking against the user process's xcr0, but qemu-user's xcr0
>> is effectively user_xfeatures (it's computed in x86_cpu_reset_hold() and
>> will never change afterwards since XSETBV is privileged).
> 
> No, I'm talking about verifying that the xstate_size is large enough.
> 
> In check_xstate_in_sigframe,
> 
>          if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
>              fx_sw->xstate_size < min_xstate_size ||
> 
> Check for the trivially too small case (fxregs + header).
> 
>              fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||
> 
> Check for the trivially too large case (presumably this is to catch stupidly large values, 
> assuming garbage).
> 
>              fx_sw->xstate_size > fx_sw->extended_size)
> 
> Check for trivial mismatch between fields.
> 
>                  goto setfx;
> 
> But there's a middle case: if xfeatures > 3, then xstate_size must be > min_xstate_size.
> 
> I know that the kernel will handle any #GP in xrstor_from_user_sigframe, but there doesn't 
> seem to be a real check for reading garbage beyond the given size.

Oh, I meant to mention, following the

     __fpu_restore_sig:
         user_xfeatures = fx_sw_user.xfeatures;
         ...
         if (!ia32_fxstate)
             restore_fpregs_from_user(..., user_xfeatures, ...)

     restore_fpregs_from_user(..., xrestore, ...)
         xrestore &= fpu->fpstate->user_xfeatures;
         __restore_fpregs_from_user(..., xrestore, ...)

path.


r~

