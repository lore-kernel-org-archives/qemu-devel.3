Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB4BC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 19:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBOm-00060e-Qt; Tue, 25 Jun 2024 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB8J-0001tq-4I
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:44:30 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB7M-0006p2-1K
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:42:57 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25cc6962c24so2624200fac.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340845; x=1719945645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6KuISq7Eq2uldN7W6ls6TqJkng66O5auRfGJh0XlrPQ=;
 b=gpwzQYKY07RHvenjsV9mL4hFyidKTEOSAWCIHj8Uz+Y9cSpUYkzyUoMhTsFNtLgwfr
 DFAlub/GvWDpTjxxWXuimbO7d+Xq1ATM5i0pk2N5wZMr/NIgKHnNHCeBv/z/lNMpcKsi
 zRyWy5F84NxEJBekEMnDNs1BkaL4mx1qvO/cE0+eeb61iWzW9gv3wPayyn1R+EZinZPf
 lmY5GmC3etNxLPRmo7D7luLxc3JfRzncR4ijEIIBW2yLccVcK3Tz8luRw5nSgi27cgpY
 OGcnBYphIlKeIo4u1yAEMkMUvY9N6pjcRhewOI5wqwiRXpNwz3ZWsqSQY4B84pLdOObE
 WFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340845; x=1719945645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KuISq7Eq2uldN7W6ls6TqJkng66O5auRfGJh0XlrPQ=;
 b=Njz2llreOaLSPTzV3bFZwEvPSJJIuX+sG6euOZzt8L7LieFGeppZeVaf5Ez45zQblS
 ZL3+mVXfg2owIZ9wvpy9xmA1E5DKvpmx5y08cw0LE/HTy+MUl7fjlQWPNLZ72HWPWhJs
 tqE1J8Bs86ustDWZo1Y9W3UN5Y/R/BfNWUXHEsMoSONdpmcfJoNe/5L6FndemvX0YuEp
 uVqVkZ5HZdFhW1wvS/0OLruOThsvRjNujedllfqtZTuNksRHIs9MHBvVagGOsiz59rL2
 sMlv4gHCh0YDyl/NNR5ViLg3WamfE/VPBfIsFkkjSx9pKRawlQxWlY9Jiy0XIH8/DTi6
 5oPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVNofkkM7JByuJdFHW7x6xL7EJWLaqQTa33OP9mUdwXHl/feZDhs3NlcDgxDr2k0jVqAQp7rQ7Gl3IpumGmnlkY0Y1mAY=
X-Gm-Message-State: AOJu0YwHv2+48mM/UUCEfQA8c2B4+qtJGqHEdb9pjMDV9w522rG0m/8Y
 XYJT9dFdKGj45VIe2CxsTNNW09JrfkOr/eJJ4rvAISjJQsKE3UieRtObuCGE8JredgD8bB3zhLp
 3
X-Google-Smtp-Source: AGHT+IGKYJpyIYjsGeMaUqsnlpNStNs7GW8QiC2j5TgIcMwtwy0tGqD5VjbKhUBepTVodJLhM4GbJg==
X-Received: by 2002:a17:903:32d1:b0:1fa:80b3:d63b with SMTP id
 d9443c01a7336-1fa80b3d9d1mr13791095ad.55.1719340306135; 
 Tue, 25 Jun 2024 11:31:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f2a06sm84617045ad.31.2024.06.25.11.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 11:31:45 -0700 (PDT)
Message-ID: <d7790078-80d8-4d02-82d1-7109040db81e@linaro.org>
Date: Tue, 25 Jun 2024 11:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h, use it in
 QAPI_LIST_LENGTH()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: flwu@google.com, berrange@redhat.com, peter.maydell@linaro.org,
 rkir@google.com
References: <20240625111848.709176-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240625111848.709176-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 6/25/24 04:18, Paolo Bonzini wrote:
> The typeof_strip_qual() is most useful for the atomic fetch-and-modify
> operations in atomic.h, but it can be used elsewhere as well.  For example,
> QAPI_LIST_LENGTH() assumes that the argument is not const, which is not a
> requirement.
> 
> Move the macro to compiler.h and, while at it, move it under #ifndef
> __cplusplus to emphasize that it uses C-only constructs.  A C++ version
> of typeof_strip_qual() using type traits is possible[1], but beyond the
> scope of this patch because the little C++ code that is in QEMU does not
> use QAPI.
> 
> The patch was tested by changing the declaration of strv_from_str_list()
> in qapi/qapi-type-helpers.c to:
> 
>      char **strv_from_str_list(const strList *const list)
> 
> This is valid C code, and it fails to compile without this change.
> 
> [1]https://lore.kernel.org/qemu-devel/20240624205647.112034-1-flwu@google.com/
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/qapi/util.h     |  2 +-
>   include/qemu/atomic.h   | 42 -------------------------------------
>   include/qemu/compiler.h | 46 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

