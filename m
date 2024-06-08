Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25309C27C5F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0dJ-0000K8-Uo; Sat, 08 Jun 2024 14:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0dH-0000JF-PT
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:17:39 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0dG-0003T2-C1
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:17:39 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-375931cca98so4372755ab.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717870657; x=1718475457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T9Fw4OFBD/4H/HPL/A0NP5qMCNMO2q6vwQBnS6Y6fok=;
 b=aHUswHFWxBnXx3jJ+hO7Fpzc9yylJQFIp6p1k2wWB4bnUp8SS5yZUzOfSzcLOj9Nnf
 HgGgM4qTMMUq0RoaxGjxecS4SX07l2jmZ6gVXYhS+EwVCvo5hqtvBv9mrhBZMLR5RVWV
 i+uMY5oJOAlXKFqZb4BdP015sSahZNa8d91oXuVfVFuTWax5tnFA/ZP6H0bpw0m0OvWL
 +0z5eDXFGRf5jXkgqXCUXgbkt87F9kBAuHHVB40HNRgWfpPF6iwCzBorqnIdq4tWmJ1B
 NprgULwLJTq+/WJkAlXXB7RHMIGLFbNSz+tF4gUSLx9LjkZQaD/S0Nv97C6DjjMLQSjB
 fF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717870657; x=1718475457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T9Fw4OFBD/4H/HPL/A0NP5qMCNMO2q6vwQBnS6Y6fok=;
 b=rwwxNuhPxluR8GWrwVNdZ/uCftdGOcTWXBFw52pCSCMIaazHOb9Q+lmcW+WPXyMl9R
 kYwnusMavLlD19otYlqTWrah0kpXEb/He740yGbWw7y5nGa9QHB9Bk0ANyAG9zE+1dZg
 jzFhnF7piwC943+4+IEpd23dqOqJ55rfTmaoGoAcKNniyeFFyjHuxR1BMfbt1yBc3/cG
 +q/aDaIxGSY+ygjCVXT0j990+oUw4zoylFhMls3h1AT8hRW+xaLkyV23SXi9bXo8rbHe
 5i8MxWFFcJxEh7fHaWZNSDrgmWH416P2jfkLYsI6UWN6jTIXdxt4CmI7qylqvcinZPsj
 6Kpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB9kFHiqBdHKbh7X2UEA37V02vWTLcrcZpaGMXH72QfCijwoW1iy6ow5571epZ9zvxvYC7TV/YfXutgkmEhZ+gitY0kXA=
X-Gm-Message-State: AOJu0Yzc4lhIuUeNKEWNPc9aBMXMF7fFABnL2qinnk3Zpt7yIuI7FPbm
 GI1UOh9YFrwXMYv6bDqoqMtMv+VnMSyuJkmXgKf1wriKezgyh0ymWwuMLacqcbg=
X-Google-Smtp-Source: AGHT+IH+JOC/JYbMLvWx2BJK/5XdTnB8HfXAYAmS44kopycx6XfkwDBFr0YnHhbYLncl8xEH66l2VQ==
X-Received: by 2002:a05:6e02:1fe2:b0:374:9f16:d7 with SMTP id
 e9e14a558f8ab-37580333de3mr68383165ab.13.1717870656932; 
 Sat, 08 Jun 2024 11:17:36 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6e3bc701a75sm2392599a12.75.2024.06.08.11.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:17:36 -0700 (PDT)
Message-ID: <93024029-c39b-431d-80da-4fc96915f25e@linaro.org>
Date: Sat, 8 Jun 2024 11:17:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/25] target/i386: fix processing of intercept 0 (read
 CR0)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     | 1 +
>   target/i386/tcg/decode-new.c.inc | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

