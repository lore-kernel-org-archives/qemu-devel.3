Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1qu-0007Cv-41; Wed, 17 Jul 2024 06:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1qq-000722-BG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:25:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1qb-0005RH-Tc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:25:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso49490145e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721211918; x=1721816718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gyJCo7E/gq3hs2cJ+Br1QTNeZpmrisNjQPOXCsY6XaQ=;
 b=AWq1gnvxM4qCkL80Js82MrOE/Lqw+zugTxjyMm1wMG9exRRo9S4KbIHOiW7Q/Fdm/O
 kDKFp1BRpnRvi/51fMJMFty/vP6XkrfnStxG18/+Sy8TD32dZG9Dz0SQkliSUZGKvZO8
 oG5zV3Ac1CB72rud6AB4DxtqYZmOfRK2dRs1A4EiRjmRYWNA6D6OVczZKNmnrvAbzQ1r
 tL7P3F/aE2Pnwz8ips9B+tLEgD7bvLlSUgTC4X+Zo7Dor0fC2m7OZtvZlKEWu0Ag8DSy
 KxqPmUpoMGJZGIqLrlrLF8kamh688utIwiUv1r0VFfg3poP/j6qdXGZoj6PjsOUnYkkG
 s+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721211918; x=1721816718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gyJCo7E/gq3hs2cJ+Br1QTNeZpmrisNjQPOXCsY6XaQ=;
 b=oqGEgXV+1nk6zccI7pD1n0xK1WL2XIspAOYR6v16ao9/Ra6W0I2Ps9TQiOevEjb+Bw
 jNQ0oVTxgGwnEO0ayq5Hhj0qWV8BqmxzouesZ+3NQCugfcWsWeu+d+E3Ruazrwj18F9M
 LUgZWlbVp1CwFctODIn5+nn0Lwv/Kz4Z6HDZWY2JrHZMBUkSIzVT2MbwuKSw5o66Co/s
 TWnYw8qHc7Cq46RPtDp6/5MtwqCvt5Q4XdVQGFVj1oXAwhncQi/RjgDie6uUvIJ3E6Dy
 T96wjyRJFdkgtvUoRFlKstbKoemeKFkkRfFRkF/zwSOROrJKrmSaKncsIs6lOay8ppkv
 iuYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIYdGV1Nw3b06M+LoPqw8rVI3CdBKr4gkNI0Vpk2B9IL7oE2awOMVucZv7K24xi9zQ3hgiWpzWygfVIuACbsP5S+VuKVg=
X-Gm-Message-State: AOJu0YzAk4nzwVrVH2vexi439how4OsykilklFKMtnZU8yVcHE5a8jLC
 OSIXJPga/0YjkoZ6Qau6SRaJDgTRRxJ+iumyfAt2R/zgVUrL5fnZwvwBYlJ/p9rMryR4AAGtt20
 2FtaKkA==
X-Google-Smtp-Source: AGHT+IHNy8Z2HDVel5X75BeJ0tOp+qVUBJlcrssMGbJPSW8SfbM+iSg0S9J39oK71v2hFGl1Cev+Kw==
X-Received: by 2002:a05:600c:1987:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-427c2cfc334mr8760125e9.28.1721211917881; 
 Wed, 17 Jul 2024 03:25:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e83273sm165254965e9.17.2024.07.17.03.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:25:17 -0700 (PDT)
Message-ID: <a6d1f8a4-5c1f-4dcf-b0dc-c1a019e8ba78@linaro.org>
Date: Wed, 17 Jul 2024 12:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qga/commands-posix: Make ga_wait_child() return boolean
To: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20240716162351.270095-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240716162351.270095-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Konstantin,

If there are no other patches on your guest-agent queue,
I can take this patch in my next pull request.

Regards,

Phil.

On 16/7/24 18:23, Zhao Liu wrote:
> Make ga_wait_child() return boolean and check the returned boolean
> in ga_run_command() instead of dereferencing @errp.
> 
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Konstantin Kostiuk <kkostiuk@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v2:
>   * Added Phil's r/b.
>   * Used Phil's polished words.
> ---
>   qga/commands-posix.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 7f05996495a2..64bb0be94479 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -59,7 +59,7 @@
>   #endif
>   #endif
>   
> -static void ga_wait_child(pid_t pid, int *status, Error **errp)
> +static bool ga_wait_child(pid_t pid, int *status, Error **errp)
>   {
>       pid_t rpid;
>   
> @@ -70,10 +70,11 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
>       if (rpid == -1) {
>           error_setg_errno(errp, errno, "failed to wait for child (pid: %d)",
>                            pid);
> -        return;
> +        return false;
>       }
>   
>       g_assert(rpid == pid);
> +    return true;
>   }
>   
>   static ssize_t ga_pipe_read_str(int fd[2], char **str)
> @@ -178,8 +179,7 @@ static int ga_run_command(const char *argv[], const char *in_str,
>           goto out;
>       }
>   
> -    ga_wait_child(pid, &status, errp);
> -    if (*errp) {
> +    if (!ga_wait_child(pid, &status, errp)) {
>           goto out;
>       }
>   


