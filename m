Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4383C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru6I5-0000Wf-11; Tue, 09 Apr 2024 03:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru6Hz-0000Qk-QF
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru6Hx-0005Gj-9t
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712649183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aUr/GPovg/EOwz00ZvJNHBGtT0ZHXswySmllKnpBDMw=;
 b=CbCfkeKE1SM+w7k7zxxYtYEGKxIW4bxbHRtBfvzIa8gCt12Iq0MUaY8+ObS2syOq391CIz
 G5N7s+DdVWxERLuKK9haU9QYNvFEhstM+iyuvmNCOAaraTiOHRN2+fvZe1yQiKFNoSvenZ
 x3AM+rSJq0dUMEJu8CSHqkgccDvHPrU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9o_jgxB_NUO6OyyPJcfH1Q-1; Tue, 09 Apr 2024 03:53:01 -0400
X-MC-Unique: 9o_jgxB_NUO6OyyPJcfH1Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343d7cd8f46so2494000f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712649180; x=1713253980;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUr/GPovg/EOwz00ZvJNHBGtT0ZHXswySmllKnpBDMw=;
 b=E5q2UHzg0CYqPl6gO6Co57dgCdbkXYAJDY6aZK8npUg8UNWgGw6ERWYX+/buui6iNz
 ik+sGE9UpFxOxbH+zWhZs0RtA8WK9OWDVkbwnmMf5jjphPUFFIPBxgSi6O4miQprm7UM
 eKam+jMVQ+r87UL0ReWiUyq6cYGJfQzKtKbpYoCDaDjG83ewzmqvRS+7CKnXajSSAjDN
 HTkgs8p+rfsdxdzQwAcBpafRUQ2TwRyzAINn2Jtz7E8EwEl7CWsnmsREUb56MoFi332K
 gCUg3oJLmmkIq19hmBfj58eNYWKmtPojACnNDvgXcdcPeFy4y+70nSvBLTIBkWtLoyLh
 0gPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXreXoFJT2UYtx9wIvz3RFe6rFHb0s2vxfZUB/5urSqW7zFigGgEuf0+YzAPd/dWaUTwzCNxz9oZt+qpXMW+YQFQgySIGA=
X-Gm-Message-State: AOJu0YzYNX9DuBobbztU5XCT5qn1xuCt2T3bAi61tvpTwSHPKbiU/XP4
 p42auxtiPI8oX3jFrS5ELxcON0yxviOhOgPCLinp7S/y8pbArQ+WIXkOWOPrzXkv96CgFftHo3n
 gForfVXpVkmniJL0fRBhJRQwKn/s9ummhSzTPM6fXM53eOsdfFfAVJZ4an6kK
X-Received: by 2002:adf:fd91:0:b0:343:98ee:524 with SMTP id
 d17-20020adffd91000000b0034398ee0524mr6710293wrr.36.1712649180093; 
 Tue, 09 Apr 2024 00:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiU13ZDjYqbsrIhBp1rh0P/G4/xqAJK30Pt4ubZ35Mxd7M0+NMUXVDs0dzegGTBt1tAfdUag==
X-Received: by 2002:adf:fd91:0:b0:343:98ee:524 with SMTP id
 d17-20020adffd91000000b0034398ee0524mr6710285wrr.36.1712649179773; 
 Tue, 09 Apr 2024 00:52:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.152.232])
 by smtp.googlemail.com with ESMTPSA id
 n6-20020a5d6606000000b0033e745b8bcfsm10745697wru.88.2024.04.09.00.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 00:52:59 -0700 (PDT)
Message-ID: <a9b44e30-2788-4d88-850b-4f89c4d1f830@redhat.com>
Date: Tue, 9 Apr 2024 09:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v2 00/28] linux-user/i386: Properly align signal
 frame
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/24 07:02, Richard Henderson wrote:
> v1: https://lore.kernel.org/qemu-devel/20230524054647.1093758-1-richard.henderson@linaro.org/
> 
> But v1 isn't particularly complet or korrect.
> 
> Disconnect fpstate from sigframe, just like the kernel does.
> Return the separate portions of the frame from get_sigframe.
> Alter all of the target fpu routines to access memory that
> has already been translated and sized.

With the exception of patch 22, and with small nits in patches 1/19/23:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> 
> r~
> 
> 
> Richard Henderson (28):
>    target/i386: Add tcg/access.[ch]
>    target/i386: Convert do_fldt, do_fstt to X86Access
>    target/i386: Convert helper_{fbld,fbst}_ST0 to X86Access
>    target/i386: Convert do_fldenv to X86Access
>    target/i386: Convert do_fstenv to X86Access
>    target/i386: Convert do_fsave, do_frstor to X86Access
>    target/i386: Convert do_xsave_{fpu,mxcr,sse} to X86Access
>    target/i386: Convert do_xrstor_{fpu,mxcr,sse} to X86Access
>    tagret/i386: Convert do_fxsave, do_fxrstor to X86Access
>    target/i386: Convert do_xsave_* to X86Access
>    target/i386: Convert do_xrstor_* to X86Access
>    target/i386: Split out do_xsave_chk
>    target/i386: Add rbfm argument to cpu_x86_{xsave,xrstor}
>    target/i386: Add {hw,sw}_reserved to X86LegacyXSaveArea
>    linux-user/i386: Drop xfeatures_size from sigcontext arithmetic
>    linux-user/i386: Remove xfeatures from target_fpstate_fxsave
>    linux-user/i386: Replace target_fpstate_fxsave with X86LegacyXSaveArea
>    linux-user/i386: Split out struct target_fregs_state
>    linux-user/i386: Fix -mregparm=3 for signal delivery
>    linux-user/i386: Return boolean success from restore_sigcontext
>    linux-user/i386: Return boolean success from xrstor_sigcontext
>    linux-user/i386: Fix allocation and alignment of fp state
>    target/i386: Honor xfeatures in xrstor_sigcontext
>    target/i386: Convert do_xsave to X86Access
>    target/i386: Convert do_xrstor to X86Access
>    target/i386: Pass host pointer and size to cpu_x86_{fsave,frstor}
>    target/i386: Pass host pointer and size to cpu_x86_{fxsave,fxrstor}
>    target/i386: Pass host pointer and size to cpu_x86_{xsave,xrstor}
> 
>   target/i386/cpu.h                |  57 ++-
>   target/i386/tcg/access.h         |  40 ++
>   linux-user/i386/signal.c         | 669 ++++++++++++++++++-------------
>   target/i386/tcg/access.c         | 160 ++++++++
>   target/i386/tcg/fpu_helper.c     | 561 ++++++++++++++++----------
>   tests/tcg/x86_64/test-1648.c     |  33 ++
>   target/i386/tcg/meson.build      |   1 +
>   tests/tcg/x86_64/Makefile.target |   1 +
>   8 files changed, 1014 insertions(+), 508 deletions(-)
>   create mode 100644 target/i386/tcg/access.h
>   create mode 100644 target/i386/tcg/access.c
>   create mode 100644 tests/tcg/x86_64/test-1648.c
> 


