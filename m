Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E1C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 18:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFuR-0007L1-Aj; Tue, 09 Apr 2024 14:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruFuP-0007KF-TV
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 14:09:25 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruFuN-0006iE-Qt
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 14:09:25 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so3626306a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712686160; x=1713290960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=grUsye7sMHr7N5eWPtoZseYAqfB7kCryOekwA5LaNsw=;
 b=syWt58mCMdgSN2CLAqYCeTvYgxJTLxYG7UAX+m+Z2hiJ8uiXtKc/i1ZrZqAgEE85Aa
 vesVH4w8182E32WwJqgWI4Cc1b81LmWEVGQD1VCJCeXovoF/JTamDMDQBHV4cYKObstF
 Lm6P/18YFe6MKNzukimWwjo+V6fFI4tigGx3eTcVK48NT0mygz3Nktv4VvCSb5urdFfY
 V4afezsciXdior2D1Fzs+Ind5a9crKFrX+kvMha2C8qwve9/ypuQhIsp9E7GOhtA4R4u
 kYOxCl5fLU8XIfggc4FSY+x5h2DMlkYgWFyEqkVZFPFLPlkG4k2BDa3/iiCjpfvAL3Wd
 wUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712686160; x=1713290960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=grUsye7sMHr7N5eWPtoZseYAqfB7kCryOekwA5LaNsw=;
 b=AfQeUukRxpcoBHyDuJkSKySSr/PhVQ1lSLIrwFup3a8A/8SBaEAb/TkO1nvxWYLdso
 KEGl20mxWm0n4rt+axkvx/NRclITzkz2QBEMAcSiP8DU/8Af0bVTXD+DeDpM0+FX2J1N
 DYvN+mL1qblBFVBrPoLxEQ6UhaNulEHtddVUpbs5/O/pjHE0eshd9mthJfVQt8xoVKPu
 1GfF4e4S7ycIWCca4UA5ktUemqmQHy9a8D3Hh5nPF+FLKQNxBq6M9NjuCHOAw6wvmPhD
 BfnKtli0SqO8Ty1mUq8FZbzivRtaJGhWaXxCIwkzlxZKbLSwtqgoOj+Rx0MyNbCRN10K
 N32A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfYHdXCiG8pybuENimmiaQc3jQwPW4HXzMMYuOduNCKARwxczRDx67s48oK1QBsi7yfoHiCpmp8GJZhFTDngC+yrtfKZg=
X-Gm-Message-State: AOJu0YxGThtAYz6wBiyDrm9BKUexE9wOF2XZ5wi0Io0W8Hsegl1G3tyU
 OOElfDXMzbMZiPKF+y5WIFJZ0tx+b6hAiCC4rCHLihMOXQlX/kOVGCueqL5DNUo=
X-Google-Smtp-Source: AGHT+IEb5U2pfzf+7m4u5pS2SdLbRTQYEyxQZXATv35tNcc4xJG7v0fXoRUl2oh6867m3aK0OOLmuw==
X-Received: by 2002:a17:90b:46d0:b0:2a2:ab2c:da40 with SMTP id
 jx16-20020a17090b46d000b002a2ab2cda40mr429916pjb.33.1712686160364; 
 Tue, 09 Apr 2024 11:09:20 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a17090a940700b002a528fae0c2sm3629940pjo.3.2024.04.09.11.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 11:09:19 -0700 (PDT)
Message-ID: <f67bf3a0-d684-4fe7-af05-bf2c1f273e42@linaro.org>
Date: Tue, 9 Apr 2024 08:09:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/28] target/i386: Honor xfeatures in xrstor_sigcontext
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
 <20240409050302.1523277-24-richard.henderson@linaro.org>
 <ecc1ce60-c31f-423b-8d5e-ba5138323212@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ecc1ce60-c31f-423b-8d5e-ba5138323212@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/8/24 21:44, Paolo Bonzini wrote:
>> +        /*
>> +         * Restore the features indicated in the frame, masked by
>> +         * those currently enabled.  Re-check the frame size.
>> +         * ??? It is not clear where the kernel does this, but it
>> +         * is not in check_xstate_in_sigframe, and so (probably)
>> +         * does not fall back to fxrstor.
>> +         */
> 
> I think you're referring to this in __fpu_restore_sig?
> 
>          if (use_xsave()) {
>                  /*
>                   * Remove all UABI feature bits not set in user_xfeatures
>                   * from the memory xstate header which makes the full
>                   * restore below bring them into init state. This works for
>                   * fx_only mode as well because that has only FP and SSE
>                   * set in user_xfeatures.
>                   *
>                   * Preserve supervisor states!
>                   */
>                  u64 mask = user_xfeatures | xfeatures_mask_supervisor();
> 
>                  fpregs->xsave.header.xfeatures &= mask;
>                  success = !os_xrstor_safe(fpu->fpstate,
>                                            fpu_kernel_cfg.max_features);
> 
> It is not masking against the user process's xcr0, but qemu-user's xcr0
> is effectively user_xfeatures (it's computed in x86_cpu_reset_hold() and
> will never change afterwards since XSETBV is privileged).

No, I'm talking about verifying that the xstate_size is large enough.

In check_xstate_in_sigframe,

         if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
             fx_sw->xstate_size < min_xstate_size ||

Check for the trivially too small case (fxregs + header).

             fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||

Check for the trivially too large case (presumably this is to catch stupidly large values, 
assuming garbage).

             fx_sw->xstate_size > fx_sw->extended_size)

Check for trivial mismatch between fields.

                 goto setfx;

But there's a middle case: if xfeatures > 3, then xstate_size must be > min_xstate_size.

I know that the kernel will handle any #GP in xrstor_from_user_sigframe, but there doesn't 
seem to be a real check for reading garbage beyond the given size.


r~

