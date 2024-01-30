Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82031C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjCi-0005WO-3y; Tue, 30 Jan 2024 03:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjCf-0005Vr-2F
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:10:45 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjCc-0000zh-8m
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:10:44 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-510221ab3ebso4950400e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706602240; x=1707207040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uj6/jqHV0QLziy+ZEFbT3OJZcuznN2sdnkdTZcAL+Rw=;
 b=DMBUHv/kqWNriXvAPfND2BoAonVFPPU5ADYGkxKHClsE0xXudPqkFHWMJV3XPits+7
 LecDtH3rit1xVxSNV5c2IoO0xKKFw9a8ZfGFE53MlvgQtJIpQzToivsXkVfft1pq5Tc1
 TMlm9nO12Riz7YBG09p392Q9tBRqb+m3uM4HFgjTxyUuZoBE7pt92Qd/cnzoPUJrLOIU
 AAR384lj2n48icBBa8h/ctjckoc4VwEX6UFCGPeSJ4eyVJeqeTjh0XHZXZC2uiQNBLZF
 UZP3dFTVzj5vKObwkhxUEJ+YxMFUwOEHvzcl7M3Jmw4M3GVnNhceowlBHIauQVszaUOG
 OxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706602240; x=1707207040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uj6/jqHV0QLziy+ZEFbT3OJZcuznN2sdnkdTZcAL+Rw=;
 b=L2vLTHoPwiFshTSYkP7T75EckmVcayoPXPefrRRvJOSLtjfLk4vNliQpRp8DIgeqoa
 BziIsI3BHsJ3HBEPKofddsa8rPMkvCWfBEKp1nvc7TIkEhpqmneUtrm+/8ZK5CRKZfC/
 YI2ASY64osnANH+zVxiQC7vGtVsWS+W+8kkXRJrqipsp8QiGLQ8qCO7BZ15yItsr7sOG
 CKv6VfEfSiApUrUMYtYsRSAp3jdAU7fbCa+bUHgaE+OpQDxaPJxkimSHQ8ZQYf6Mwjj9
 1wA92ru7vGesMN/FZrOUEpKSIZcHl5bYrwuTJINqfI8FgKy/pUayn2Y2v7NGhT+n9MSO
 4MxA==
X-Gm-Message-State: AOJu0Yx5vLGf+eUBCJZ9PfjDBMlW0f1BmPcKtPrn+jj4XUWAshjaubzT
 zojeU2ljpTCyjpRa1x5vSQbTvtOfXoWutZUeCsyvowvLAy1g5DjSl+ra7iEaxQE=
X-Google-Smtp-Source: AGHT+IEzG3UlcH+Q0uuSVH65S4Y+LLkugsKaA3X2vYuHShqhTEA2nOS7shEijTSfZ0JyvOOWRKVByQ==
X-Received: by 2002:ac2:4a65:0:b0:50f:1ac5:758c with SMTP id
 q5-20020ac24a65000000b0050f1ac5758cmr4955032lfp.17.1706602240381; 
 Tue, 30 Jan 2024 00:10:40 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b0040d5ae2906esm16186462wmq.30.2024.01.30.00.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:10:40 -0800 (PST)
Message-ID: <f538a86d-7ebb-466a-98de-d0093f6c202a@linaro.org>
Date: Tue, 30 Jan 2024 09:10:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] target/sparc: Introduce cpu_get_fsr, cpu_put_fsr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103173841.33651-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 3/11/23 18:38, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.h          |  4 +++-
>   target/sparc/helper.h       |  1 +
>   linux-user/sparc/cpu_loop.c |  2 +-
>   linux-user/sparc/signal.c   | 14 +++++++++-----
>   target/sparc/cpu.c          |  5 +++--
>   target/sparc/fop_helper.c   | 21 ++++++++++++++++++--
>   target/sparc/gdbstub.c      |  8 ++++----
>   target/sparc/machine.c      | 38 +++++++++++++++++++++++++++++++++++--
>   target/sparc/translate.c    |  7 ++++++-
>   9 files changed, 82 insertions(+), 18 deletions(-)


> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 44dfc07014..e46f15adb8 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -83,6 +83,34 @@ static const VMStateInfo vmstate_psr = {
>       .put = put_psr,
>   };
>   
> +static int get_fsr(QEMUFile *f, void *opaque, size_t size,
> +                   const VMStateField *field)
> +{
> +    SPARCCPU *cpu = opaque;
> +    CPUSPARCState *env = &cpu->env;
> +    target_ulong val = qemu_get_betl(f);
> +
> +    cpu_put_fsr(env, val);

Preferably directly using cpu_env(), otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    return 0;
> +}
> +
> +static int put_fsr(QEMUFile *f, void *opaque, size_t size,
> +                   const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    SPARCCPU *cpu = opaque;
> +    CPUSPARCState *env = &cpu->env;
> +    target_ulong val = cpu_get_fsr(env);

(Ditto)

> +
> +    qemu_put_betl(f, val);
> +    return 0;
> +}


