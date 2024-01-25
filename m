Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B70C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 06:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSso1-0000Zs-0s; Thu, 25 Jan 2024 01:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rSsnz-0000Z5-89
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 01:01:39 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rSsnw-0007Qd-1o
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 01:01:39 -0500
Received: from [192.168.55.37] (unknown [85.249.19.23])
 by mail.ispras.ru (Postfix) with ESMTPSA id 2F7D840F1DEA;
 Thu, 25 Jan 2024 06:01:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2F7D840F1DEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1706162471;
 bh=6WmkFbTmSDdYHXYVDDJyV2F2TT/Ioz9HULJ322MAFC8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sE/PjsBwabJTecE1pTUgd0TQS/ER8WjnauL+Vv2VeBdDIKejKYYXEXXMIIOBDMN8X
 iHJ6hH+2ekjXH5ngXN5Nv9suAjLqaVv7dVFw4Rq1snAza0MOsbZVlFt7oTWFLVh7b4
 BITu9ftO1O4QlO3ru1KggO5pdSDXgVOPHHhEopbg=
Message-ID: <c719b41b-b40b-4cf9-834e-21f5b650ad46@ispras.ru>
Date: Thu, 25 Jan 2024 09:01:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] accel/tcg: Introduce
 TCGCPUOps::need_replay_interrupt() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-7-philmd@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240124101639.30056-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 24.01.2024 13:16, Philippe Mathieu-Daudé wrote:
> In order to make accel/tcg/ target agnostic,
> introduce the need_replay_interrupt() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 5 +++++
>   accel/tcg/cpu-exec.c          | 5 ++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index 479713a36e..2fae3ac70f 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -170,6 +170,11 @@ struct TCGCPUOps {
>        */
>       bool (*io_recompile_replay_branch)(CPUState *cpu,
>                                          const TranslationBlock *tb);
> +    /**
> +     * @need_replay_interrupt: Return %true if @interrupt_request
> +     * needs to be recorded for replay purposes.
> +     */
> +    bool (*need_replay_interrupt)(int interrupt_request);
>   #endif /* !CONFIG_USER_ONLY */
>   #endif /* NEED_CPU_H */
>   
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index b10472cbc7..4ab7d6c896 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -778,7 +778,10 @@ static inline bool need_replay_interrupt(CPUClass *cc, int interrupt_request)
>   #if defined(TARGET_I386)
>       return !(interrupt_request & CPU_INTERRUPT_POLL);
>   #else
> -    return true;
> +    if (!cc->tcg_ops->need_replay_interrupt) {
> +        return true;
> +    }
> +    return cc->tcg_ops->need_replay_interrupt(interrupt_request);
>   #endif
>   }
>   #endif /* !CONFIG_USER_ONLY */


