Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24A3C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 03:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYH5q-00009m-Mw; Sun, 28 Jul 2024 23:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYH5p-00009I-Rz
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:30:37 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYH5o-0000M7-2b
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:30:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so14085715ad.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 20:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722223833; x=1722828633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iLG29r0a12TmfMDEZf8s2WNWmnOfQXrSLIDHw+UJ7PA=;
 b=GiWLhNBleSokq2L3cNj7togbGE7/s6bvNucn4THHSLntme7Xr0/rEJo8MPgXdAhEzs
 W4iEs2gaTbkePkcHSIHCeiOg08VUjuGSJ04a5z3B+M/JAWYlJCkrPuECw/aUp2mv/SJT
 BdUF7TX3EqhETpbONYuDhhG6iLBFP0nN3XnmB2Tl12JApi/diQ6MiQkNzvcKLLjJXCjW
 hYm2lKt0S0ImQJCrKNl6lo1BTEcCiv3YMxU2mJzVxj/WGtCKpAhb7P2pkz/C249EYjGP
 9kiRfZWxwACrVvWjW49KlRppTe+2gF6XWZAm3dyP1v2i+pg8lEAu0IgTHQBh7pQjJrQO
 i3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722223833; x=1722828633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iLG29r0a12TmfMDEZf8s2WNWmnOfQXrSLIDHw+UJ7PA=;
 b=vg7h07E8JiJaevjKoGriAFFhrCERx8/mZTHLNEFbqxYWFKQKxLMjazC00JMq4r9b9I
 CUA5LVs6jjTyiYnK0KGaUMponRNgtd9P0SL5j3ViL8ALZwa+ZALUFyEslKrhIAMEjszH
 T82DG/i6Lzpvl71CqS87MkemT6wgoo4pgUxD1q9Kypu2bb9DAerUhO+/TibCJvN+WCZZ
 oTPVs8aVwFXQbwRKz1wFZ7dJGJshUo8FepbEEjkYUZg6le9Ld5MumBiWs3UvE6B5+XYd
 9t4YcDQHGGxdt5kOkJmwMxmTcAB/l/kJk10NjVfKyIj2LXZOARn2xxix5NExdiD85mQU
 gpPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdHanFUP8/Ghqcs9S1Q/CRDCDvp7vPqrBHvBn64xUYVW6bTMs7XoEQKueSPLyWPCF678RCr8uSTneP42QAEAdkvOJYMI=
X-Gm-Message-State: AOJu0YwEpJkie1bjxOXVCO9H6qlzZBYwCRNQ2Anq7Mq70v8SrHHPfomq
 YBuMjObflXIhzdStotfHf06V+bmMJpIIXeMCyqp1F7m5qkfE0cs5SqNTB9+8oGo=
X-Google-Smtp-Source: AGHT+IFGCJgE5AHDCSqhhylvgh1A2QWNl6UxsKLx8VwJ6Qe2JWIFpfhqLz0HgPvZpg178jJCLS7FGw==
X-Received: by 2002:a17:902:778e:b0:1fd:95ac:506b with SMTP id
 d9443c01a7336-1ff04950719mr40514205ad.64.1722223832448; 
 Sun, 28 Jul 2024 20:30:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7edd91asm71509285ad.131.2024.07.28.20.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 20:30:31 -0700 (PDT)
Message-ID: <a416aab9-56fc-40ef-a94e-92a944248809@linaro.org>
Date: Mon, 29 Jul 2024 13:30:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix race condition with scoreboards
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240722232344.2203257-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722232344.2203257-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/23/24 09:23, Pierrick Bouvier wrote:
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

Rather than MAX, if a concurrent resize just completed, we don't need to resize again.

So:

   start_exclusive
   lock
   if (size < alloc_size) {
      foreach
      flush
   }
   unlock
   end_exclusive.


r~

