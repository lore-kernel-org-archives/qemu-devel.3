Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1152FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlF9c-0001yH-SL; Fri, 15 Mar 2024 17:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF9b-0001xX-8Q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:31:51 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF9Y-0006Un-HL
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:31:49 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-22187576d54so1953686fac.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710538306; x=1711143106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SW5xvAxGVSsUbmFcCIJOoyCgU+n+KFQeJTG3aS/IKfE=;
 b=x8STgAVsNj9yXezGjwOCIdmSzbzLzTAKDm0Upgzt6btThy2WgaYfKZ+VJnV/ZojyxL
 /DveuUYzlvl7eRBa7nSfgPRXlMvzYakajXc9FzATxAvxzpGirszy98r1qDoG4b4oPen7
 z3/gD1Ui3H9hJzSqh2dS4qBQ3gAhlADBMELrJzUQR8JnStbATSHeWFIxaM8HrIqnEPh8
 +j8AoXq689A5SO0OFwl2a0sduK7fGv8VANRuUox90Gh4Ys+rP1Z6zJL/Eg3XvOJAWwg3
 Ik8nhf1UIucpjGn5n/RlCxETLTwYG00s5gsYPxLvTwWiwSgE8CG58bxFJTbnSkqaEJ8P
 ckUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710538306; x=1711143106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SW5xvAxGVSsUbmFcCIJOoyCgU+n+KFQeJTG3aS/IKfE=;
 b=VZd3sCT8xiZFtHZLArerYDRPVI3JyDYjvQSJ+CtKnmj0rMDNGsB0gm+GL313Ns5/Sv
 xNmXjQiDgK6wqYlhj/AC41/fm+K5TB8Hg4nW+CRYkc71T2CzKURGp9mAoHFXdMObSgQV
 dfOJ8h4ylrHswo0Hih72MQXkp0IgkWcU196lYlphlpDr5hK2nYmBxKI5BZzBpxQxfYTu
 mAriD1V0g9Ziwv0KP8rtUVQA9OQvmOeLPdeloKQzhefV9INsyWm1wwT9oDIPBKq3/7RS
 J5OeBok6ogEiV07KLhRvIDqxub6cRZ2RrX4NNILjVJFmmo8wUPoUpqmSt/IIm2CfMtvg
 oJ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW69FDVLhGkefVUfvplYA0Y0jgm4VgScIaXOWH/bX30/4zUBLl9jqIhAt9bXjeUP3hDlmB1+BteLya+CPlKJRvu/hvkdk=
X-Gm-Message-State: AOJu0YxTU/7zAXRkAlai4srK4Dn0u+0dUGFbjdPU0MzU6LkGFcWlF1Lo
 a7cNwGEKr0eOc9rKIQAzXbEFt7QjiSiOz2U5AzAWLXcF9k9yYjbeW3gdy15jlZ4=
X-Google-Smtp-Source: AGHT+IH8ZHCgfGzg+ZEmzzTwkasdeVuZVMMi5sTQxmhd4nAdA8tbCDQMsBIH9BAO6r+7BS+ggqYWgw==
X-Received: by 2002:a05:6870:350c:b0:221:8c16:1 with SMTP id
 k12-20020a056870350c00b002218c160001mr7146801oah.33.1710538306325; 
 Fri, 15 Mar 2024 14:31:46 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 r8-20020a62e408000000b006e64c9bc2b3sm3962473pfh.11.2024.03.15.14.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:31:45 -0700 (PDT)
Message-ID: <46bf4272-f946-4df4-b70b-cd4e13c5ade2@linaro.org>
Date: Fri, 15 Mar 2024 11:31:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 06/12] tcg/sparc64: Check for USER_ONLY definition
 instead of SOFTMMU one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Since we *might* have user emulation with softmmu,
> replace the system emulation check by !user emulation one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Having read further, the ultimate goal is worthwhile.
It'll be easy to turn these into runtime tests when we get there.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

