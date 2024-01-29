Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9443FC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 05:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUJrP-00074q-W0; Mon, 29 Jan 2024 00:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rUJrA-00074Q-Se
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 00:07:00 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rUJr5-0000W0-Qh
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 00:06:51 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9212E40F1DE3;
 Mon, 29 Jan 2024 05:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9212E40F1DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1706504781;
 bh=7ObhPA5/XWEr/jjW592N/wuC0pxaBMfcH73oNpZ7vqU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XjZSriQ/BQ+bXWNC3wo32XqxX3oAChRpeb+Z43xaMBneU9IOJBhTAEe3Z0iPMaQqH
 wX07M+1QR9kmmQXNbsbHgtWW9qLgWYeT2Ke0CX+u1zv5eJ7knDxeJcIeZHA465S/gD
 JO4AKTacMO1mvHpNUVjrAGuBLLkbNNV7FdW0npRU=
Message-ID: <29b41cae-1c4e-49e6-bdbf-255b62b02740@ispras.ru>
Date: Mon, 29 Jan 2024 08:06:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] replay: allow runstate shutdown->running when
 replaying trace
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240125160835.480488-1-npiggin@gmail.com>
 <20240125160835.480488-2-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240125160835.480488-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25.01.2024 19:08, Nicholas Piggin wrote:
> When replaying a trace, it is possible to go from shutdown to
> running with a reverse-debugging step. This can be useful if the
> problem being debugged triggers a reset or shutdown.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/sysemu/runstate.h |  1 +
>   replay/replay.c           |  2 ++
>   system/runstate.c         | 19 +++++++++++++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 0117d243c4..fe25eed3c0 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -9,6 +9,7 @@ void runstate_set(RunState new_state);
>   RunState runstate_get(void);
>   bool runstate_is_running(void);
>   bool runstate_needs_reset(void);
> +void runstate_replay_enable(void);
>   
>   typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
>   
> diff --git a/replay/replay.c b/replay/replay.c
> index 3fd241a4fc..2951eed3bd 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -383,6 +383,8 @@ static void replay_enable(const char *fname, int mode)
>           /* go to the beginning */
>           fseek(replay_file, HEADER_SIZE, SEEK_SET);
>           replay_fetch_data_kind();
> +
> +        runstate_replay_enable();
>       }
>   
>       replay_init_events();
> diff --git a/system/runstate.c b/system/runstate.c
> index d6ab860eca..bd0fed8657 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -182,6 +182,12 @@ static const RunStateTransition runstate_transitions_def[] = {
>       { RUN_STATE__MAX, RUN_STATE__MAX },
>   };
>   
> +static const RunStateTransition replay_runstate_transitions_def[] = {
> +    { RUN_STATE_SHUTDOWN, RUN_STATE_RUNNING},
> +
> +    { RUN_STATE__MAX, RUN_STATE__MAX },
> +};
> +
>   static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
>   
>   bool runstate_check(RunState state)
> @@ -189,6 +195,19 @@ bool runstate_check(RunState state)
>       return current_run_state == state;
>   }
>   
> +void runstate_replay_enable(void)
> +{
> +    const RunStateTransition *p;
> +
> +    assert(replay_mode == REPLAY_MODE_PLAY);
> +
> +    for (p = &replay_runstate_transitions_def[0]; p->from != RUN_STATE__MAX;
> +         p++) {
> +        runstate_valid_transitions[p->from][p->to] = true;
> +    }
> +
> +}
> +
>   static void runstate_init(void)
>   {
>       const RunStateTransition *p;


