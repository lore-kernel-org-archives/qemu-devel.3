Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD063C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2T1-0005OI-4d; Sat, 08 Jun 2024 16:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Sx-0005Nk-TB
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:15:08 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Su-0005Tv-O9
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:15:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c2999f969aso2809152a91.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877701; x=1718482501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d49ZX7EWe2tR2G9tg8+4PLYO+G+xW4lgxPSaNuQWJhg=;
 b=iI0JFloiEQH3284mi862R5GLQqyStU1/eB3JMSqlAKA00y5x0ky8i9o5RneDnl08I+
 YpUX4dn0wSXJiF7I1e29Sv+15LVFgHZ98P3a9+604LPb2v+iS2yO6sudIStd9kqQ1QV1
 OvmSpgKwZs/GebrFvR/olpURCbX/ggC9Ab5hQVqEOSfTsxglRSZglN+AuplHX8qjAifF
 liw1iawP5TqO7nuAurX44sij5Q8KQCVOsKobsgTILu2Lt2tMFfLasb2mEMhwoVVEL4bT
 DPgv5v54dZhvUUbVbcK1HbWnLBkwvbgp8kwCtI7Pgz1EJDtnIBwtFZcYC6xTEq4wqx0D
 wNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877701; x=1718482501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d49ZX7EWe2tR2G9tg8+4PLYO+G+xW4lgxPSaNuQWJhg=;
 b=ug0TQdDnTkfGcq5YXVSPOx2RyZ0yLQ7mWFVK4Pfup5qAQZveSx400XCt52uDRaDZ/x
 BhfnKG2jeFdsBk5TC58WFlVmEKStFS8AHfqP71mMuOCdKwFmlGNdQnXDetpBsPDAaCut
 IfOHfvf1WYGPv9dNRkZtqgRxFA9VyjnCAyPqInD2g3PZE3q//klNPGs75kxBDfnrtMKJ
 zlcz1Hv/1PeuIxsVWEbu58JnWt9uTEvtciTqSFkwVyY5CbGLa2NLW9pDWP/PrtPNPifa
 kxiVU7yf2F+5wHT8jQOPj8wIIex/MON3itWVULC3wErAryg2airhTc5PIE9UIZps9bEt
 C5yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvuciDaRKJY63owVUufv4215ugNSbhg4DuZKl1AJG2PRJCwXDZvBsUYr9cdQSWNb8/7ZdA1oeLF/PE/ZyWDdiwfwtHEjk=
X-Gm-Message-State: AOJu0Yxyp5w+uk1PsRM9RcwtGNhUaDZ5Q7rRU7na3yfXe7jHdUcxz+WR
 ULwKo343fAE6px6hdTSYZVFtnrE0VBcguaJzuUEaDzxtgqn4XemrZb/8htmQ7U4=
X-Google-Smtp-Source: AGHT+IGlS1eUm3nDpoSBaQhHosFt+SjBuvQfi/12pQuZD2XCCTIAxMhfAkc8dgZbGOjCAmMVySxEIQ==
X-Received: by 2002:a17:902:e54a:b0:1f3:50b5:65bd with SMTP id
 d9443c01a7336-1f6d02f54c0mr59579095ad.33.1717877701337; 
 Sat, 08 Jun 2024 13:15:01 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd778259sm55000105ad.117.2024.06.08.13.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:15:00 -0700 (PDT)
Message-ID: <dfd5be79-e158-46d3-b7ac-0da4f7a3cd35@linaro.org>
Date: Sat, 8 Jun 2024 13:14:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/25] target/i386: assert that cc_op* and pc_save are
 preserved
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-24-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-24-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> Now all decoding has been done before any code generation.
> There is no need anymore to save and restore cc_op* and
> pc_save but, for the time being, assert that this is indeed
> the case.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

