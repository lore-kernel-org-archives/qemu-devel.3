Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32618D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4QGL-0005Q0-4k; Fri, 25 Oct 2024 15:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4QGG-0005Op-A3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:46:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4QGE-0006so-9M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:46:15 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so1723055a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729885572; x=1730490372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YOGDYhl0qG1s0ZEAFo090clg/DIDqwtQaJt2M8YnNbE=;
 b=TDx6SBtNL/sWItSgMSl4JC6ksJbeUqgwBlE5ZMGvXQLK9C4ra4OMX0kYlzgBcBE+S6
 BBjRKnbwCVsT7RGKqaJ1B2esmETwoDbdmvEcdUL1/PYmYfsXSWZVrgqm5L8S/Sgfw6Dl
 ePUgZ4a7P5nbyzg76yTxLxOSu2q5CocR6/vJsuJE2AaUEl6H5hJnGoiJ/JZUlX1RO4yP
 NI/FBSAKz6SgAi4/LVcjtGkJ7O5fx3pF/7Dg+Dr9ATD0MjVQDw0T/g098+rPMjiZNDm9
 IkNPuEOzJD8dyZAHq5D6aT7cnKDNuRCPB4Enn8BV0y5ZcJI/DRulQPJm+Z87nuyV6koe
 UoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729885572; x=1730490372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YOGDYhl0qG1s0ZEAFo090clg/DIDqwtQaJt2M8YnNbE=;
 b=o+3nEKhdvdXQNpDdW7C6XQKLg7TB1bGjzxXtRLrC6S0bkpevt6oMnRwsxgQxroLjuz
 UfW2jIq65m2CBxsEfJM72S9joeemWyS1EN7+A6WBM6k9GG9iDbRvvNroGIDCX4WqX8ON
 wny8tKc4R8Ch2WiyzqyfkV5sbXqzL+kedr7DQQzDArvNxrRxJlcgJWv0qIw+BkmzcH+O
 EuYUKaI+YrWyKGuUuUi5ZmzHlNdmWzqUNzp8K8cZx5LHIuSGczDm/vP1uV02ggX8YqV4
 xUdZy4Ljv7blh/YFBGGTfF97KUCyclwYlrY3hUCQYPs1ByESV7ytqLc0exnt2btBAnwl
 dzwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4FF8VSCak5NE93amjXdpPYDDCjXNTwTlEFPwtS2p7Mi9CcUm2PicpMmIK6W1El2X3O04SaQ46HAGw@nongnu.org
X-Gm-Message-State: AOJu0YxZrkbA0st0mdXsl+59/TSHLdwed1toRgOImWon+eHr4nFOeAi1
 B7cXAk0vGLcxUSdp6/YKLSHKsmPjre7IKwF6mGmP2XymV3Px98ng63Ox8aNSYso=
X-Google-Smtp-Source: AGHT+IH19+L0F6gDD1TRSLxGEGHwcI7HEby4tr0kP/4es7e6y+LR+loJMkfKrqHbTkTMDkf6sS6PDQ==
X-Received: by 2002:a05:6a21:6b0c:b0:1d9:1334:27e1 with SMTP id
 adf61e73a8af0-1d9a83ca04dmr480352637.13.1729885572601; 
 Fri, 25 Oct 2024 12:46:12 -0700 (PDT)
Received: from [192.168.2.252] ([201.190.186.93])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edcc132c0bsm1202740a12.70.2024.10.25.12.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:46:12 -0700 (PDT)
Message-ID: <ed9a4ac3-1b89-4ed8-9839-01df7fb4d989@linaro.org>
Date: Fri, 25 Oct 2024 16:46:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] target/mips: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the 2-NaN propagation rule explicitly in the float_status words
> we use.
> 
> For active_fpu.fp_status, we do this in a new fp_reset() function
> which mirrors the existing msa_reset() function in doing "first call
> restore to set the fp status parts that depend on CPU state, then set
> the fp status parts that are constant".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/fpu_helper.h       | 22 ++++++++++++++++++++++
>   target/mips/cpu.c              |  2 +-
>   target/mips/msa.c              | 17 +++++++++++++++++
>   fpu/softfloat-specialize.c.inc | 18 ++----------------
>   4 files changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
> index ad1116e8c10..7c3c7897b45 100644
> --- a/target/mips/fpu_helper.h
> +++ b/target/mips/fpu_helper.h
> @@ -44,6 +44,28 @@ static inline void restore_fp_status(CPUMIPSState *env)
>       restore_snan_bit_mode(env);
>   }
>   
> +static inline void fp_reset(CPUMIPSState *env)
> +{
> +    restore_fp_status(env);
> +
> +    /*
> +     * According to MIPS specifications, if one of the two operands is
> +     * a sNaN, a new qNaN has to be generated. This is done in
> +     * floatXX_silence_nan(). For qNaN inputs the specifications
> +     * says: "When possible, this QNaN result is one of the operand QNaN
> +     * values." In practice it seems that most implementations choose
> +     * the first operand if both operands are qNaN. In short this gives
> +     * the following rules:
> +     *  1. A if it is signaling
> +     *  2. B if it is signaling
> +     *  3. A (quiet)
> +     *  4. B (quiet)
> +     * A signaling NaN is always silenced before returning it.
> +     */
> +    set_float_2nan_prop_rule(float_2nan_prop_s_ab,
> +                             &env->active_fpu.fp_status);
> +}
> +
>   /* MSA */
>   
>   enum CPUMIPSMSADataFormat {
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 9724e71a5e0..d0a43b6d5c7 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -407,9 +407,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
>       }
>   
>       msa_reset(env);
> +    fp_reset(env);
>   
>       compute_hflags(env);
> -    restore_fp_status(env);
>       restore_pamask(env);
>       cs->exception_index = EXCP_NONE;
>   
> diff --git a/target/mips/msa.c b/target/mips/msa.c
> index 61f1a9a5936..9dffc428f5c 100644
> --- a/target/mips/msa.c
> +++ b/target/mips/msa.c
> @@ -49,6 +49,23 @@ void msa_reset(CPUMIPSState *env)
>       set_float_detect_tininess(float_tininess_after_rounding,
>                                 &env->active_tc.msa_fp_status);
>   
> +    /*
> +     * According to MIPS specifications, if one of the two operands is
> +     * a sNaN, a new qNaN has to be generated. This is done in
> +     * floatXX_silence_nan(). For qNaN inputs the specifications
> +     * says: "When possible, this QNaN result is one of the operand QNaN
> +     * values." In practice it seems that most implementations choose
> +     * the first operand if both operands are qNaN. In short this gives
> +     * the following rules:
> +     *  1. A if it is signaling
> +     *  2. B if it is signaling
> +     *  3. A (quiet)
> +     *  4. B (quiet)
> +     * A signaling NaN is always silenced before returning it.
> +     */
> +    set_float_2nan_prop_rule(float_2nan_prop_s_ab,
> +                             &env->active_tc.msa_fp_status);

Alternatively pass float_status* to fp_reset() and call it here as

        mips_fp_reset(&env->active_tc.msa_fp_status);

So we keep the comment in one place.

Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


