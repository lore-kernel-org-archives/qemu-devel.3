Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420EEC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Ee-0008Rq-UN; Sat, 08 Jun 2024 16:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Ec-0008Qv-Uk
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:00:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Eb-0002af-EZ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:00:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f6f38b1ab0so3452255ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717876816; x=1718481616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NSyRBEb2Cp0LPKpiZrBUwMUQLWEeKFDqRn560iOTnEg=;
 b=vws9cBizyZsUDSj8r6uJRTHIZ22o2FNgMQxMaTrcksZpTKQoWnkvaDcpHjvQeJksxy
 Q0Rt49GuLLn84u+stT8AiIFyT4ouxfVk/FZl7eeLsc9bNCWCiOKGJeudn028jA1ulI1Q
 Y7YKvzuBVNglTpR4FrVmjPX47vfpnEjafedaVx3f4g3lZmWC9+C2Ir1V/jwgjtFk6HmG
 z/uOxW6sUmvzdkpIcuZh1czqNZq+umeE24xPrUMrWbrku1xL0LBBBCDRKrMLRTKn0a2E
 9vQcB3LKyhvhACzgGdSlBgDnO0otUfa2Gq+6ld0U7sJCm71TjyLgE7J8ZHnz7aeLZ+me
 QsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717876816; x=1718481616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSyRBEb2Cp0LPKpiZrBUwMUQLWEeKFDqRn560iOTnEg=;
 b=JDxTmpOErpLKfNAmso0YsNt2ab18nkO/lvrjm1rcYy5v7XXMsbOKIWNbBH6fssTjTM
 V5cPVK01mt83PGG0R4ueVQalzx/HU/u+7g/qhS7UcCxLxNGW1FOO5AGHxGWL4wWW3iwA
 qvu/HXzhq3iT8e36a46obKNBA56vQKOx7f3ehJ+G9erViLOa31oVs7CtoWoFPgB7xcI2
 ASKJleRCU8me07w29dxHVrmthrApLP3TXiYqQ4Zlb6OMmjMOG3X84H1juTy+Mgx3bTKi
 V8NCwd4gMDlhkGYYbw5nrjoE3MxXAl4yqUP3516wgq4M7aZLarNe2elDHrlqCnOQELEO
 QdnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/iNRBpuIJSrcy9qW8U3RyIFCnseyz5yCdq8xXJIcbj0gKqq9ZyDXWuhyqtuCpQQVbxioReZMvGqYZmiAsaei6X6AfS0g=
X-Gm-Message-State: AOJu0Yw1JSMdDCkD23N4j5aMhot3rt2co7zjj9xlDEkQn4TTLElNMTaZ
 6qfa738qkjwf/+iwQIiFIFV/1eNjJr+ge2NraDmten85O85yvIRM4cIPhrthwwJDvqzvHXh/41o
 H
X-Google-Smtp-Source: AGHT+IHQ3fjDtyGqy0cLJhbRZNt6HNqT9u0kn01XK9UZcNb4tw8kmjhaiB9sOFwBOFF8eKZkk9ZQAw==
X-Received: by 2002:a17:902:e552:b0:1f6:8be6:428d with SMTP id
 d9443c01a7336-1f6d03c295dmr68350315ad.56.1717876815595; 
 Sat, 08 Jun 2024 13:00:15 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7e5e98sm56387485ad.234.2024.06.08.13.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:00:15 -0700 (PDT)
Message-ID: <a4064223-8006-4aab-8aeb-c5c5f2f3df6b@linaro.org>
Date: Sat, 8 Jun 2024 13:00:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/25] target/i386: convert XADD to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-20-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 35 --------------------------------
>   target/i386/tcg/decode-new.c.inc |  3 ++-
>   target/i386/tcg/emit.c.inc       | 24 ++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 36 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

