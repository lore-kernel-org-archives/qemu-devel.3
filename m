Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUez-0003kB-17; Tue, 04 Jun 2024 09:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUex-0003jZ-3z
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:57:07 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUev-0006Jz-CV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:57:06 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f361af4cb6so1898171a34.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717509424; x=1718114224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HSWsv7qSs1aLESk5MC50gsqG5FLzpbPwKWUfTKJLtgM=;
 b=uZv2/q459olv/doY2qs93l9yEpADYpX7YuHmaZj+aKZeCKrpQMuc34msclnytyisMr
 ap3AnZGpfEtDMrQONKmfEq9SGWF8wjGdt1MtxedD2KQ+6zSA08Q3I6mqbu9JOLnZttUu
 4Ap4d3J5w4mYKUyhy4ie03/D6+IVOLbvgyTPO6gJv6sARECgcR1l1MT51a30T9RKRLjm
 QXcYVhzJWdOki0rU4LjiMBhzgY4DbCSwuW8MHqhy03msI7wshmIloM3G7pMfMTW5v3AX
 H5Bv02xv5X9TQDAUR0CrkZR2MD9mQ3Olw9zaiEUGnEVX60XJGFTFaJYuNjNgtvoPEu+z
 v/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509424; x=1718114224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSWsv7qSs1aLESk5MC50gsqG5FLzpbPwKWUfTKJLtgM=;
 b=ZzwDv9npsKuqMt9sbbzWkN5LqEWTMEeHFCqAHov7LX7StNEpETLncpfaHWePgyAkAF
 N0ORme5UEjohMOz587e/0G3BEXt1qpcK+fcKE5EFE+qTDFDuAHC99D1EOKv3egtqkH4E
 dr/3W2R3ypHI6WDyoSosfgLOyIhkP8fA9w9VWcmRbB63gFvUH8ZizTOkx4ERa3FwNC/q
 B1Bi3F6MtqwlbbqI0dIGnnk2malmaxOEb/6W3QRaYOXY0KlrA7uZaOXj6mUXuC4Nh1la
 Bn/sbwW1kr7S3yO6UvgCUzxlPu6rQVaB3iiFqSGo+90NNO+rKzpWgji0+6//+6l5RS0I
 pMTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIxRh40mR3DbVvcNJrwA9dPNviBTmbAgX3y+RESANBo4o/hVIOARAh5OjU9VlfZck31ETwKqI+iB8I9JQxoKiNIyFdSE0=
X-Gm-Message-State: AOJu0Ywoa0kJ1GX3p16USGBJUy4ltmTfxZyKKZHCQIlK5uM5e0qW/BKL
 qeQsFNqITvx1/YxG6M+l3AOIKKWqk1+J/RVNJ6TpW3kiuMbLQruiVAUAIM+78Jlld5c7ZleJsFx
 O
X-Google-Smtp-Source: AGHT+IES0pHxJ7XtaQPjTCN6qlLtMccfO5Il+PpuW9KajmXOhlXHTdv9DQpZxy2pLFv2DNJX0530dw==
X-Received: by 2002:a05:6830:4b1:b0:6f9:3b16:2b4 with SMTP id
 46e09a7af769-6f93b161c03mr2061380a34.8.1717509423761; 
 Tue, 04 Jun 2024 06:57:03 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9105a9f1fsm1944983a34.73.2024.06.04.06.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:57:03 -0700 (PDT)
Message-ID: <d784a37b-39d1-43d3-9f13-18c92c788608@linaro.org>
Date: Tue, 4 Jun 2024 08:57:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] target/i386: document incorrect semantics of
 watchpoint following MOV/POP SS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/bpt_helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/tcg/sysemu/bpt_helper.c b/target/i386/tcg/sysemu/bpt_helper.c
> index c1d5fce250c..b29acf41c38 100644
> --- a/target/i386/tcg/sysemu/bpt_helper.c
> +++ b/target/i386/tcg/sysemu/bpt_helper.c
> @@ -215,6 +215,12 @@ void breakpoint_handler(CPUState *cs)
>           if (cs->watchpoint_hit->flags & BP_CPU) {
>               cs->watchpoint_hit = NULL;
>               if (check_hw_breakpoints(env, false)) {
> +                /*
> +                 * FIXME: #DB should be delayed by one instruction if
> +                 * INHIBIT_IRQ is set (STI cannot trigger a watchpoint).
> +                 * The delayed #DB should also fuse with one generated
> +                 * by ICEBP (aka INT1).
> +                 */
>                   raise_exception(env, EXCP01_DB);
>               } else {
>                   cpu_loop_exit_noexc(cs);

Should be fixable with some sort of state machine initiated with 
TCGCPUOps.debug_check_watchpoint, but not easy.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

