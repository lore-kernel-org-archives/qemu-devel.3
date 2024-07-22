Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17102C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2U8-0003PK-Kt; Mon, 22 Jul 2024 19:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW2U6-0003Ol-PR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:30:26 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW2U4-0007fU-LT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:30:26 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39834949f27so16263015ab.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721691022; x=1722295822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRXEcTw+hD+ofe8jbZzgUX0DrdGiQNE3WX+OB5kbBPU=;
 b=O/axm/S3OjIwJ1BXRhLI2dAP9MIU9dF6oNirO6nnTzT/qq9Ke86YBHM88a5oE8b+bv
 aP35BxFTj1ZZmeGFh9q6Ar4E0X2+6kqzV4D0WWMzi9A0hMFP8oWBos4UT5xSXgb6APc9
 q5r7oWDMCTFEED8UXiq7thipdbESG7+xU+orPSmFOYtWhQWuy/c6OInS1mNbYBmX2jEs
 vZsZww6WCwkzEPMaRrC5EFnPaD+sPL+QOsx1ev6r6b00qLOEa/p1s7xJlkAb5UyWBz3i
 Y2bvGX0Nb7f02J9NKCOYani0Ay6lsC5LDJDQQjNE6wY9ajkrUeAXkqNI6zhTUxRLayx2
 v+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721691022; x=1722295822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRXEcTw+hD+ofe8jbZzgUX0DrdGiQNE3WX+OB5kbBPU=;
 b=FZ25CHSnQt+SHCvO6Ebt1susGRGdW7GfjjiRYmmKMe2Gl4TqExvHxKgnG6PdCmsV2C
 Pn697vvHwfdZXdRnCX5LL0dZtekmAb+ophV0Mv6woeFhxKqDLD1ZwEPFuQBl9SYsVMeC
 SO5t0626Vrl0YUTvuAZPoP1vTRckHuzsFK8RXsmB/uUvvlT7tJGGvKqc3bpZTS5yxzxp
 gFDqxCrHOg8vS/jFeu0gJcIGOHyIQLSxnvKioDlKlO2FJC7DmfRa6zx+5Xf2eOgZhj8k
 O/PhuiQZpQ16+RlqyDMmmOAH2FEG2hS5nbF/W+abDE1phOHwBFODJ6tN/AkU54Xrj7jx
 iqXQ==
X-Gm-Message-State: AOJu0YzWdDoZLWXG4bP2GVQ1/krpURf3E2U5qGU9Ewss0M8yZoE+2wG7
 ry+WZQ8KwYoYbvjt3elVISA3yZf4z4AcMOYH3Vba4dYHmGhUd14kXhk0NXDGFlDqlOxpD8Ry+fg
 nsWE=
X-Google-Smtp-Source: AGHT+IGKqJdUJWpVpnKHZQcrmvR0U3awfCnBSabsmMzeho2BYcn7C1gDT6pI9ZAOgkrCtMktIiyU5A==
X-Received: by 2002:a05:6e02:218a:b0:395:ee4b:333 with SMTP id
 e9e14a558f8ab-39a0c9639fcmr13892685ab.28.1721691022330; 
 Mon, 22 Jul 2024 16:30:22 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a1582705d2sm3297901a12.86.2024.07.22.16.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 16:30:21 -0700 (PDT)
Message-ID: <7e7388e2-a273-45d9-be75-8deda6fc555f@linaro.org>
Date: Mon, 22 Jul 2024 16:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix race condition with scoreboards
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240722232344.2203257-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240722232344.2203257-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x12a.google.com
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

@Alex: If possible, this patch should be included for the release to come.

On 7/22/24 16:23, Pierrick Bouvier wrote:
> A deadlock can be created if a new vcpu (a) triggers a scoreboard
> reallocation, and another vcpu (b) wants to create a new scoreboard at
> the same time.
> 
> In this case, (a) holds the plugin lock, and starts an exclusive
> section, waiting for (b). But at the same time, (b) is waiting for
> plugin lock.
> 
> The solution is to drop the lock before entering the exclusive section.
> 
> This bug can be easily reproduced by creating a callback for any tb
> exec, that allocates a new scoreboard. In this case, as soon as we reach
> more than 16 vcpus, the deadlock occurs.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2344
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   plugins/core.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index 12c67b4b4eb..e31a5c1c9cc 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -214,28 +214,45 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
>   
>   static void plugin_grow_scoreboards__locked(CPUState *cpu)
>   {
> -    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
> +    size_t scoreboard_size = plugin.scoreboard_alloc_size;
> +    if (cpu->cpu_index < scoreboard_size) {
>           return;
>       }
>   
>       bool need_realloc = FALSE;
> -    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
> -        plugin.scoreboard_alloc_size *= 2;
> +    while (cpu->cpu_index >= scoreboard_size) {
> +        scoreboard_size *= 2;
>           need_realloc = TRUE;
>       }
>   
> +    if (!need_realloc) {
> +        return;
> +    }
>   
> -    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
> -        /* nothing to do, we just updated sizes for future scoreboards */
> +    if (QLIST_EMPTY(&plugin.scoreboards)) {
> +        /* just update size for future scoreboards */
> +        plugin.scoreboard_alloc_size = scoreboard_size;
>           return;
>       }
>   
> +    /*
> +     * A scoreboard creation/deletion might be in progress. If a new vcpu is
> +     * initialized at the same time, we are safe, as the new
> +     * plugin.scoreboard_alloc_size was not yet written.
> +     */
> +    qemu_rec_mutex_unlock(&plugin.lock);
> +
>       /* cpus must be stopped, as tb might still use an existing scoreboard. */
>       start_exclusive();
> +    /* re-acquire lock */
> +    qemu_rec_mutex_lock(&plugin.lock);
> +    /* in case another vcpu is created between unlock and exclusive section. */
> +    scoreboard_size = MAX(scoreboard_size, plugin.scoreboard_alloc_size);
>       struct qemu_plugin_scoreboard *score;
>       QLIST_FOREACH(score, &plugin.scoreboards, entry) {
> -        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
> +        g_array_set_size(score->data, scoreboard_size);
>       }
> +    plugin.scoreboard_alloc_size = scoreboard_size;
>       /* force all tb to be flushed, as scoreboard pointers were changed. */
>       tb_flush(cpu);
>       end_exclusive();

