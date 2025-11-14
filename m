Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9986CE7B05
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 12:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJt9N-00080w-3l; Fri, 14 Nov 2025 07:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJt2a-00044O-Lj
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 07:36:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJt2X-0006RI-2O
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 07:36:34 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so1656415f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 04:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763123791; x=1763728591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hi0Ggm2J+RewAEfy0sHtgkw0RsI2w5w3CcHrqlRsIcA=;
 b=wkTW2Y1SXcS9ID9Uq+2mwx+1RH6O5xEyadjpJaJMeHJtIAHR905vL4gz5TG8+dro2J
 U129uuWc339VnwtOmI0/2QPypViI4ThdMrLIqFIupnzmnli209JVuLDTg/S02HV0GTs0
 WBshMlWHnYERDm+B73J0wQoc7Klpqw6HFDTcOpjjbgMN6ty4kRjoj69UiuRch+Tk00FD
 k+w68ggUnaNdcN3wCqpnyY6cAwEov41sv/lEWh8ngQfnC03bTeiA/D2SoQd7YA+BmGMh
 iSOfLxhGpDKxyoipDZD/bVsu27wGllCvB7fj1wWCqqYt5ttWGe2tA/huBeFLI9FShS6P
 J0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763123791; x=1763728591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hi0Ggm2J+RewAEfy0sHtgkw0RsI2w5w3CcHrqlRsIcA=;
 b=A6A/Z/uIKJyRaX15p4VBPw8HCFvM20PMrscWB7v93XQ/4FlFYn8Fco8xPQET46F5xK
 /iKg+aHgHUyFIL9etRZn4E1fHjrIVDfaouwC4NWObRUL47I7xTZc/Bi8/lqL7kpPQTY7
 552qPk+wvXSaLocC/GSrSqJ47HpL5ZpszmLosYJ2x3NvMcJx1qf0WPaec+NpNBrNOaiO
 5acP3jV7erCJbw3DttP4b+xcrotGglt5p+rDqhXZ5bMHNa22V9hBB5YiTGxbq1Y9VhKK
 RSzfMGc9n2UbitbsdFC4nLk8tzB3pEg32zsANL16sm+pWgGQm3S92rRhfaS2FJ6PQkid
 bh1Q==
X-Gm-Message-State: AOJu0YwpYICAPXsO6cgL/HlCp8UYJOM1wtN76Khf06yFeKxKzK8GRDZp
 Uv28UwjzxNns2jUmfRBCXfjvzPWn8fTO7FD4tuZ73RvaTnUEgFYw6icKdJ8wTf9usHc=
X-Gm-Gg: ASbGncvKsh8sRTrx9dN8hbmSmkv3mD3SlIkGgtUfoi5jAlUND1hULsodK31/WkkGQ8S
 Yb2+65A+P7bNk1Rs4KRcEm0Swn3EnmPRS4DtzAeC+ik+Ao3M7xIaiOg2QlexuiWHIqdYnqaQUQm
 UiqPebwTYT39Rmu1N57yY4G1GgWjPWnyGPVkgcVyQGaZs6IK/Db3qT2uI1VxHVYuJ1h2V/FiRbl
 pXAcstPEwtuZIfg3JB+DhDdnLnJB5GLD1FM1hJc1szgyLFEThJm4YurBaA7/XuY4WuObom6e3Uo
 WmSui+q1xTfzd+7uGCrvLzdIJGeQLvUKiedb6omuXZkUjwU1A+456UPS/ijNkLCEzbjT/GMr8Ha
 8+ApqMuD+M7uS9gPNzGcwsg7EgZeU8zJGnPrJnwvoeEOTj4bHyLX98zztVU7Kj0GTCml9Yn+ySH
 NrgCPU04wkXNt2jjnEhyZV0Fk/ARb+23IQ1yQxTfz66I4=
X-Google-Smtp-Source: AGHT+IGQ3MEopkbrjhpflf/6jyNZr/sR/9WXyIq81i+1viYK6p/b8vcnxv34x1mMnL+vpbAuc6EAfg==
X-Received: by 2002:a5d:5d10:0:b0:429:bac1:c7f5 with SMTP id
 ffacd0b85a97d-42b5938ee78mr2711790f8f.44.1763123791144; 
 Fri, 14 Nov 2025 04:36:31 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f2084dsm10015822f8f.42.2025.11.14.04.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 04:36:30 -0800 (PST)
Message-ID: <848dd7f0-112e-4950-bce4-4288c8515bde@linaro.org>
Date: Fri, 14 Nov 2025 13:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make sure fetch_instruction exist before calling it
Content-Language: en-US
To: phind.uet@gmail.com, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20251114082915.71884-2-phind.uet@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251114082915.71884-2-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 14/11/25 09:29, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Currently, this function is only available in MSHV. If a different accelerator
> is used, and the code jumps to this section, a segfault will occur.
> (I ran into this with HVF)
> 

Fixes: 1e25327b244 ("x86/emulate: Allow instruction decoding from stream")

> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   target/i386/emulate/x86_decode.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 97bd6f1a3b..d037ed1142 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -77,7 +77,11 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>           memcpy(&val, decode->stream->bytes + decode->len, size);
>       } else {
>           target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
> -        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +        if (emul_ops->fetch_instruction) {
> +            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +        } else {
> +            emul_ops->read_mem(env_cpu(env), &val, va, size);
> +        }
>       }
>       decode->len += size;
>   


