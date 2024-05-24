Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09048C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVmV-0004E8-7u; Fri, 24 May 2024 10:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVmS-0004A3-U5
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:20:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVmF-0000Uv-RI
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:20:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f33d84eaefso15015565ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716560410; x=1717165210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3J9OIPCMOj4Re7rElq9eRcSSTeIn3R4vQI91FZ3J6E=;
 b=LZT8RFQpMfVkkWeqwOvPuWocq5+aZtd73d8uUri4OFrGmaWEon83VoYcqn7TxBVqxy
 jYFw9TMtSCFYaZYUJWB2zLrWWZ/vD4G4wHZxL7kPh+7fIhZXnWSwWLURdenjiMkN+Qgb
 0bbZdSLP0RcM0RL786BSjtu+AWePc+nmvJitNQ9Il+qHu/xhKGKY6cMxHjK/M6tD7B9R
 6imVTHU3/yg4nq7bsCjCXr9slXRI5Dn9ErjVonYdh2SjiyRPWE8XTEOHAtZMK9cl+3Nx
 Al+rqt1HevNNalIzmHEmyJHXtwkYBQMEpAkXJNZ69xTV5s8UjnZp9QImnUeJExBEGCg1
 mzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560410; x=1717165210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W3J9OIPCMOj4Re7rElq9eRcSSTeIn3R4vQI91FZ3J6E=;
 b=rF3n3dtyxvrxdjVJsOvjYr1NwzF759cgT+ZXVjX/5TrMErVu7higc3Q/N/AZV8unbP
 FR8GOM3tgpJM6jGIuxIJMshiXQCGwgH+7nnDV+owrhKzleyEAkg54/YIHAARjDUD4gbk
 cvJEWFg8pW37+Q54gtbkcMbr6CDHa56aEr8ACQfraGBOFBQb/5NRxYH6Ul3PQJzhSpwV
 ttib7e61c2D6fHNEkEL1Ppi1OyXkZZ/SBqZvybaHeKlvsPRBj9vHbjrsbbP3FuQ8ATCi
 V4i0SnOQ8XYVTqF2herDbfwxnZKdrcSByXVdoMwR6ImpAjcFzjEUWq/uS0aOqha1E79u
 ETnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ7+E4ZbAWYXqd77VV6uunmD4lU4lhUDNzxbUOsouW0zxRoE833a4xoHn/GDPRvyqVWyweDnYd6C0XDR/t5xr4sceTByE=
X-Gm-Message-State: AOJu0YyKPxtj0w19yNm/mXJlzpE/vJwkHcY0PkVDN0ICbe8DLQrUq4fI
 Mu++6MksobfFJifloK6F2tt4j9gLeq7ZDOlR7dCyVQWHGK41zEmHlOD/YjK1tHhXXFc8kjxufaa
 n
X-Google-Smtp-Source: AGHT+IFz6OKnhIUF7PwmvLuJWNI2z9MbvEs8k8jVdTdK5QPvTMbUPmmxwO7akIDYxRNFIP548K1vxQ==
X-Received: by 2002:a17:902:dacc:b0:1f3:436b:bdfb with SMTP id
 d9443c01a7336-1f4486eef85mr29747845ad.20.1716560410485; 
 Fri, 24 May 2024 07:20:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a8f93sm14406905ad.234.2024.05.24.07.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:20:10 -0700 (PDT)
Message-ID: <ada04ea4-9468-4bb5-b1d8-8743da3bddc9@linaro.org>
Date: Fri, 24 May 2024 07:20:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] target/i386: document and group DISAS_* constants
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Place DISAS_* constants that update cpu_eip first, and
> the "jump" ones last.  Add comments explaining the differences
> and usage.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

