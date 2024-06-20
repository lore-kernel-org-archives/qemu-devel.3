Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3463EC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMbV-0008WP-2m; Thu, 20 Jun 2024 14:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sKMbS-0008Vs-Ia
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:33:46 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sKMbQ-0003TN-Pr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:33:46 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c7ecfc9e22so765417a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718908422; x=1719513222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPBDTAdx2m2IuSg83oz/wP8OmWF++UOUnKh2Zwa43tk=;
 b=MlwR1OA2ADybLl4EC0/XBGPZel9jz+dYO/SD1IWkG+jZZSLMvvFoSBdy0Kz7cVdvlp
 aTrQEC4XWutR11FsCDnB1gxOnZNf0JPy7Dh9AzT0Pzyz2WYpyBuXt/mEyz/vDoVmXXI8
 KCnfNLEUTU3UlRRvcG2FLQyBeA9vl72OzgB2YNb4pFlXnCw79Xf0GgauUwUMFV7kP/rL
 NbVkspB+JzuN/TMm48uYvauoLaNPG04z4Kpz+fHhtmGuCpQA91yY7c0YiEo92D9QvYZV
 AKhe652hkuw47Yf+dMyoUgUUrxJmhlV61sMBNQc6Ulew5uITQluW9IVFIimTws1t8K99
 CbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718908422; x=1719513222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPBDTAdx2m2IuSg83oz/wP8OmWF++UOUnKh2Zwa43tk=;
 b=Q8Qm2kZCFwMVR/f+rxBvAgyIcrmpQY8BBfav1PJz9ceCsJnmnzv80qaV5iGZtBmYam
 dZpVDHOfgTPHF6DmxBdS2rmhnGXrVpzYbTMwYSi6C44mfMRDnV/cwO4851IiRZPRnNBN
 qjNyV6D5N66cIHwnwPSjBNjeic2OJ/G5Q3fEjvH6nW88iVNRJRHBdz4cPl+mKCbtlT0E
 UK+wMwZSC2E7+aOKXQgindRMGnZMxCtb5hN84zFjDdcjHurf7C9h+tI5bplvNkQ+l23Y
 mKEKKhJyipndEQWbF7TBnuDf6QWT3zNVpc1SEKlICK02wubmRsPAsDmUuks8M7s67y/8
 FwxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4z8nR2NGxSbMHBiKZT1fPEBYSIb1Q3X40p1nizhJTtoxbVXllk/rw6Q76SGv3tP/nttU4I6rgcFz9CZ7pjeoyLu7qX34=
X-Gm-Message-State: AOJu0YzLeBDKHtCgrsgCkqBrY7Js3T09ZS9mels37mIfbt+6tOqMoM3l
 anYek6q5RZvBPfv+QwWU3MHXHtf9xw8gSsBCNFrJun+efYQ9xkH47bvpLaFVAjM=
X-Google-Smtp-Source: AGHT+IEzZo9SyRrqTPYaURtkzGJUQ+3pyBcw+W4EbBaR+KA5E9/FPl2pPrCkWJvyB0k9IoyAuunMUA==
X-Received: by 2002:a17:90a:e390:b0:2c2:d0b7:9a24 with SMTP id
 98e67ed59e1d1-2c7b5cc6e6cmr5613906a91.27.1718908422082; 
 Thu, 20 Jun 2024 11:33:42 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e59cafb9sm2029016a91.48.2024.06.20.11.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:33:41 -0700 (PDT)
Message-ID: <c4bd0134-ea09-4b89-a8d2-9928cbecf8e1@linaro.org>
Date: Thu, 20 Jun 2024 11:33:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add precision about capstone for execlog plugin
To: Alexandre Iooss <erdnaxe@crans.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20240620135731.977377-1-erdnaxe@crans.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240620135731.977377-1-erdnaxe@crans.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 6/20/24 06:57, Alexandre Iooss wrote:
> Some people are wondering why they get an empty string as disassembly.
> Most of the time, they configured QEMU without Capstone support.
> Let's document this behaviour to help users.
> 
> Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
> ---
>   docs/devel/tcg-plugins.rst | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index 9cc09d8c3d..f7d7b9e3a4 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -539,7 +539,9 @@ which will output an execution trace following this structure::
>     0, 0xd34, 0xf9c8f000, "bl #0x10c8"
>     0, 0x10c8, 0xfff96c43, "ldr r3, [r0, #0x44]", load, 0x200000e4, RAM
>   
> -the output can be filtered to only track certain instructions or
> +Please note that you need to configure QEMU with Capstone support to get disassembly.
> +
> +The output can be filtered to only track certain instructions or
>   addresses using the ``ifilter`` or ``afilter`` options. You can stack the
>   arguments if required::
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

