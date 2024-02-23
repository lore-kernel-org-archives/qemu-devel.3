Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E6BC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOgF-00022i-W7; Fri, 23 Feb 2024 01:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdOgE-00022R-NY
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:05:06 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdOgD-0005eE-3B
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:05:06 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbb4806f67so312700b6e.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708668303; x=1709273103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AVpn56uAKqSy4bM5wbUPBSPDaybDTFerj5cuagAcW9k=;
 b=U1Mu77iBS98kEWM8LzP9TsQiS0jSrV1tBPZYP351D3PvQh0uHx1G3fFpsPeFF0Jhao
 sUElYBjwIL5GJpGX+TXo+TFhTLDvYI3T4CSD7WUTfZ4vkSsapb/VPWacuM1MsETvBlit
 Yxmf8f1JdzykjpaWrvQxaQq1uVwBDWcg4tcPje/GOrcogKuigoEnjPA/lbWLnbIALi1+
 aeADM+VuvZ1lZVOwUbkc+tuGwui/j2Kdd+8sL7WHTEMw4dGDXSgxTgJzAZoYqAApH5G4
 ac7qdkAn+kiism7XdUS1aAhQ+j8jJOtrdiv/dN/QAOU0XWpp+s9c928a57xAu9lDLsCJ
 6sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708668303; x=1709273103;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AVpn56uAKqSy4bM5wbUPBSPDaybDTFerj5cuagAcW9k=;
 b=fGIuIIuSFjZMyFAssybxMwqkxKXodepakrwbq1qJ0n5STjXtVKJtbG/XZEIunsHBOc
 YZLMB0kFrd75SSJQwv+/RmBZ4DVjAkj0QeR/xv4W7+YP1OsF5Ovm4Zim4y6O71XJXJSh
 vc69lbhgW3u/vaA94SxQSrKB5j+9WHE/zEPgOjfwg2DHZ+5s435KNw6OKie3Tu6YuhpV
 52il34cchKzcrIUghB480B0ePyopXeybK2Q6KHE7BAJPh/sb5T5FYkM4K0iFQhgtVHLb
 HRFoddKG7RE/eUK4vhVrXn3eMdkpqHoRXgFpImvV3NDW3HUvvgl+9h2+2gGeDTUv/G51
 4f3A==
X-Gm-Message-State: AOJu0Yx3wcHTIuxQC+G8oBZ47uip/kwrr0EWlW5CUk925x3AS2CwOjRI
 34RkfXPanz989bnp4FfdwBnINjXYg19gEDlbGu8TDkEx+2+RiBk9Q0Vn7UEuhOJG6BZMixdEtkg
 m
X-Google-Smtp-Source: AGHT+IH7rQjk3Tv3Tr/yqnuOgui/FZZlhbBYcSgp9ve4SLocO1ni6ePDBxwW/LPiyQzTfztC8Xo8ow==
X-Received: by 2002:a05:6808:1686:b0:3c1:4678:5aff with SMTP id
 bb6-20020a056808168600b003c146785affmr1260398oib.31.1708668302675; 
 Thu, 22 Feb 2024 22:05:02 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa78ec2000000b006e4d2cbcac8sm1904546pfr.94.2024.02.22.22.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 22:05:02 -0800 (PST)
Message-ID: <4bcc5abb-9b42-4687-9a8d-d9c15598b11f@linaro.org>
Date: Thu, 22 Feb 2024 20:04:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user: Add strace for shmat
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, iii@linux.ibm.com, richard.purdie@linuxfoundation.org, 
 mjt@tls.msk.ru
References: <20240223030309.458451-1-richard.henderson@linaro.org>
 <20240223030309.458451-3-richard.henderson@linaro.org>
In-Reply-To: <20240223030309.458451-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 2/22/24 17:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/strace.c    | 23 +++++++++++++++++++++++
>   linux-user/strace.list |  2 +-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index cf26e55264..47d6ec3263 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -670,6 +670,25 @@ print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
>   }
>   #endif
>   
> +static void
> +print_shmat(CPUArchState *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    static const struct flags shmat_flags[] = {
> +        FLAG_GENERIC(SHM_RND),
> +        FLAG_GENERIC(SHM_REMAP),
> +        FLAG_GENERIC(SHM_RDONLY),
> +        FLAG_GENERIC(SHM_EXEC),
> +    };

Missing FLAG_END, of course.


r~

