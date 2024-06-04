Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C49C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERns-0001sD-2Q; Tue, 04 Jun 2024 06:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERnq-0001rs-FE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:54:06 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERnp-00007w-11
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:54:06 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7951c446fe7so17151085a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717498443; x=1718103243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3sZv0UF9O2GC/qf0yxqXAq56qljVhH/O8oPCOPwaVYs=;
 b=l3r1DmU0taS+cf6ScfBrLOMu84DLCJpOMkR43vZ9S49PCXZeQty+QnUKfBdkS3FZZb
 hpGzxsY+7FE9h/Uhg0LBZ2eUymIQVJGe9eFR/+AmY/VOjdFRZuYNXsw68z6WeH8ZhUJE
 TRThKqESiANPGeAxn81wR/dIHmXIffj/BJQuyl1melQGMG/lap8SmOmpoSTy3zQc8CLi
 oJxe8AGDYUXeZ9Nx42Ud/4Bs7aeRSzYnRmW7S2iVQ7t85JqJQvdCxrLRP1Y5RyDEQRJ7
 LHo2Af+dLF+t+m2rtLuwBHHiZVwT+Up7X5ilgj7KifijUXPEmRnQr9w2nWPqKyLVbB7g
 r7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717498443; x=1718103243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3sZv0UF9O2GC/qf0yxqXAq56qljVhH/O8oPCOPwaVYs=;
 b=nqA2qwXZ1nQ/9TEdajhvv9kYbuCGWnyvnWPXBvkTatgAom17x4wN3fAYRbiDmUeGiy
 4H0aCKN0YiNmNhttiKFZ9FDGOFyPteW+46qBHvByJQIz/YixLVGpHJNRitEnaKDBRaLH
 EDVy9s3vByTpr9MAayAUO7JQUrfmQ6E++ohUABMnoZCtnS370yoBG5iQvTZWRocNj84O
 hhtqr3avi/UeIDnOI3do3RIsh4oDe89TrTLfsbR502epVVKQNm2lhUaxa6sf+hz6Utl5
 T1xoSfdCMWWRzgoiyKVDMvxcG3qc/yE6M9UYq+Y+rbsVmQyXWp+NimdVuxwaZySjKPwm
 b83Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq6IfdfahkloRgY02zwBigJBr/Mx1rmisSgF304n4nYpd1wNsuI39xkjzNZPCp2MNxZK0QAgu/HmiolOAkDUyn7/XMy90=
X-Gm-Message-State: AOJu0Yya/SJ1vGYgAEaP3oRBtRCotH59v0bkWJWr9coAGwwd4e5oP2Dm
 dgDEdurSnlOv6C7mz0XkAlzylbeZ+uriQZE/O0RBcfRd/UD2pRxuCaZeemYTF0g=
X-Google-Smtp-Source: AGHT+IHVeq0o5pN7AN+tTSpiFY4f6CP86jfjAbn0bxgpYyzdriVAC5sCLHufdkHA6LWrR5Sf3/1Faw==
X-Received: by 2002:a05:620a:47dd:b0:792:c60e:2b10 with SMTP id
 af79cd13be357-794f5ed15efmr1118532185a.73.1717498443340; 
 Tue, 04 Jun 2024 03:54:03 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7951e909b9dsm9763085a.62.2024.06.04.03.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 03:54:03 -0700 (PDT)
Message-ID: <ce5da9ec-0ba8-4d8f-8204-2bfee00f2fbb@linaro.org>
Date: Tue, 4 Jun 2024 05:51:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] target/i386: fix pushed value of EFLAGS.RF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> When preparing an exception stack frame for a fault exception, the value
> pushed for RF is 1.  Take that into account.  The same should be true
> of interrupts for repeated string instructions, but the situation there
> is complicated.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 49 ++++++++++++++++++++++++++++++++----
>   target/i386/tcg/translate.c  |  8 ++++++
>   2 files changed, 52 insertions(+), 5 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

