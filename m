Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC3AC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrtd-0007m1-Jl; Mon, 08 Apr 2024 12:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtrtX-0007kT-LC
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:30:55 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtrtV-00085P-6a
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:30:55 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso2641607a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712593851; x=1713198651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B46nmzUDEK5iWrjU3GDo5zVyqJVPPH9DYAvynNHMM1A=;
 b=cFcFbTyEKAfVhqPLgavlCaz5tMSLhVGY3H21zIthTP0z4Sw1HL5pzbOUBk6y79qXP3
 JREpPpaATqW1CPAJFwF/WS1lv5taavsmS1S7oXh5x3//cRr/DnIj+k5o39OVl9d60abK
 rsFJEmYQBO842LlgNXMkt21RSKWtJXzN8p0rwTT/hWXLf+VJ3AuCrxO0Lj1xpIZ9Xd8r
 /YiSOwpGYlLDn2QH7wiOxmIdloCQahrg16aAUWhCmx38ufslhqz0++3zI2xMN1A4Lndk
 fzvAakgkcg2rRCpFbC70/kLMB4X3eOFVqS5j6TOxxe57gyGcQUYAWj07CTiA8O9P0O+d
 HSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712593851; x=1713198651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B46nmzUDEK5iWrjU3GDo5zVyqJVPPH9DYAvynNHMM1A=;
 b=EdAIgRreYuTCiWpXwHY+yZQ30hGnsP0rfiP86NZRwYfNXhbuXXfgWpY7ABZ/YEyeyX
 Ir4Uy8GR8gBQuCIgNhyYzXXKUMKSt0ovBkrJPzL9RX/C1xP79FZyAgO8UPl3h0WvVpWj
 qaHIJ4vMFzy6kMpABP8f8HR1tr9s+eaLeXpoHL5au0Rutyblvqd61EhfwX8SITGBFc9J
 bTosdnAWYg4eXRqcMs4kAtXYNIdRLzHlyIjGLd53HnCALam0Ebtr/y71XlbWA5p8bCxG
 1qivpBJ961MXvDHGwdyviNW7KNvn0Uqrqi6FudF2Jp9PrirYNEqJ/wwJWrY3TMO5qllL
 MPWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzOv6/gx8a5bagUkMLud9hfIWYHdh6vuQdRRozapZ2MgrSuCmBIytrFP88SZw7d4FmYGjCSn6Q9ye2mnmInDSWcZ/eTP8=
X-Gm-Message-State: AOJu0YwVnvBaeWb2rEKbWrwuc0NIarQSERBKg4PAAVaI9SvgSkwgrYiP
 IyU1VZ4lMBWASFEqT+2bHtYfEJzPotG5fHQ3CWF8HzfKQtXmo0075xlCtMchFW4=
X-Google-Smtp-Source: AGHT+IHoaYEwdcWPqWNwYGSTE6Tpk8rd41UZL+jlnusAkN0YeL8PJpcg0S4aXtNDewX5U42FTCbjdA==
X-Received: by 2002:a17:90a:38a7:b0:2a2:644a:a0e3 with SMTP id
 x36-20020a17090a38a700b002a2644aa0e3mr6753671pjb.3.1712593851054; 
 Mon, 08 Apr 2024 09:30:51 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a17090aac1600b002a26245adffsm6523981pjq.41.2024.04.08.09.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:30:50 -0700 (PDT)
Message-ID: <84e2d03a-f284-43ec-805c-3776fd3148fc@linaro.org>
Date: Mon, 8 Apr 2024 06:30:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] nanomips: fix warnings with GCC 14
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240408142509.484027-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408142509.484027-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/8/24 04:25, Paolo Bonzini wrote:
> GCC 14 shows -Wshadow=local warnings if an enum conflicts with a local
> variable (including a parameter).  To avoid this, move the problematic
> enum and all of its dependencies after the hundreds of functions that
> have a parameter named "instruction".
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   disas/nanomips.c | 194 +++++++++++++++++++++++------------------------
>   1 file changed, 97 insertions(+), 97 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

