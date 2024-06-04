Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69B9C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERns-0001sa-Mw; Tue, 04 Jun 2024 06:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERnr-0001s4-QW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:54:07 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sERnq-000089-Dg
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:54:07 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-795186ae3efso28150685a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717498445; x=1718103245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1YHCeoTxr6bcar72mMYxKygIkVGP46yMIr0TZP6ATE=;
 b=u/A8xGZMlep01NOItSiG2rMkrqMA+Q1e35u677/igubGgXH1B62eyELgDgl/jLSnk3
 UypwIkZ+cqLFyUcPB0NXso3yHWGrsAqBNq0URjpiA8q2zAoMs+6hqtwlSc1ZamMnFwKV
 +GroeZeoNjwqanW74KyqXzerqsvw4BPSm+8BYq+NGXrWu4DEc/L+VFVj4jSRxZCqLrqq
 lHE2zrDs0wmQnOkJvcU+LAB4MjGe1S8JBlT2wTzFW6oruAGINErqvRUVFuxITSd6VdpJ
 VeG2TRvbWNathu7X5zUzKsXcmaIbnnXAZWF67UP2UFQSRSJ5ulcsOgl5LidFppQJ+Hwe
 VdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717498445; x=1718103245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1YHCeoTxr6bcar72mMYxKygIkVGP46yMIr0TZP6ATE=;
 b=er/Fc8I/h2uBkBBf1wtxlORCIuu5u5pHLDWvueDvWx8Jfx004liyQPr7pAw6FvfD2k
 Y5A9y7RfkKCLZM6FdTQ+KWmpxK5FCe8eOFna88fvriOh448soUZWSmSHmLKpnsIAv7jK
 mW5ZyopjVEXgcHZBh2YADVGOC7dERmQe2NK8M5c9Gk8nekYk6HALTtH/OCKRoekfqb3o
 x14T2CRLOhJfkFPDbcZfxajlTzw95mYN2s5qCLqRA1pnIuS1L7w2qeJeXKmrBcLE7ENV
 i9wxjuAeCAwzIGX9nQvefGJb/eNgUjsbq/K6cZPbX55/EJTuBAXP/ieM4kjIQhqbN3Uw
 FoRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo3BPYtsnhSlBzjxkeq1nTrx5LgUoGmF/uIczJF/YdYnGE/SLGfVoN+FLheK95IeJMrwuwoWEc/olRC0ktDM8paAIeJmY=
X-Gm-Message-State: AOJu0Yy8uAjoK6/zTSyylwLXWb7r5GYwUHeC0KWZc9dQ9k/eVpNPNQnV
 Ptvlm2QNmN6sYqvlFxsSnHouQbN0BauPAlUE44koPqP3hvHjhuGbDnWg7PMtsFmRZq5daLpX9f/
 l
X-Google-Smtp-Source: AGHT+IGGQF5MULMJ4NXA4nJe+u6Zb2L7w5NsituWSqN8hzsjIP/hc0WdtPo+yKYaC4NrTsa9L+uMOw==
X-Received: by 2002:a05:620a:1118:b0:795:1494:33e with SMTP id
 af79cd13be357-795149403d5mr203904685a.15.1717498445338; 
 Tue, 04 Jun 2024 03:54:05 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7951e909b9dsm9763085a.62.2024.06.04.03.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 03:54:04 -0700 (PDT)
Message-ID: <9318cd14-3f74-4294-8a5b-e07c9ffb25fd@linaro.org>
Date: Tue, 4 Jun 2024 05:54:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] target/i386: cleanup HLT helpers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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
> Use decode.c's support for intercepts, doing the check in TCG-generated
> code rather than the helper.  This is cleaner because it allows removing
> the eip_addend argument to helper_hlt().
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/helper.h                 |  2 +-
>   target/i386/tcg/sysemu/misc_helper.c | 13 ++-----------
>   target/i386/tcg/decode-new.c.inc     |  4 ++--
>   target/i386/tcg/emit.c.inc           |  4 ++--
>   4 files changed, 7 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

