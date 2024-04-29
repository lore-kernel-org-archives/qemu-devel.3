Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDCEC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FnW-0004l6-C0; Sun, 28 Apr 2024 21:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FnT-0004kx-Rt
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:27:12 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FnS-0001yH-Gg
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:27:11 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ee2d64423cso354799a34.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714354029; x=1714958829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6IAqzN8Se4dNo7X1NzV9e7TIoyRO3Jq2y62ayGbLFUc=;
 b=ae/cZfkNrSAN+nlN7+MSc42em1tSM8admS8da2GBHw3V8/NE3A/pHw3wOQOxMvKvI4
 1qMS1D/cVsUrkjHb01U/Xy9iKZdTs4iGd9SfaYO8my9eCbvg16XdhLJgK/ve0X523NON
 4SiXnOgVj3+xkBzgjnFW0fGcYGrJ6BpuWOOVLiOlgzvaZmxMHjuZzEes1DgP8ewktsCW
 6FB7OV/lWchxpxUse2YKkfiEDaMiDmYMQhxByka13u/GUkA7ipz5eIn5SuSOs7NwGi4e
 2a7QhAsiR8c8K2rMlHxaw0XtdCRCDI0apMvisd/4nZN+NJ9JQtJcxg7K213Elc0L3LTW
 lIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714354029; x=1714958829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6IAqzN8Se4dNo7X1NzV9e7TIoyRO3Jq2y62ayGbLFUc=;
 b=jkdEWcJO0mPci+kG5eG4h/eMl4PaaNDQpQx2/ZkCPRqI1+1JRhVaRih7hItMayefkR
 VYZLiU83rraLBV+e6BLh6Zb+rxcko4bmssxmwZnP7nC4J6RYSKhBayxQZ62aCa78rlSD
 CuIc2wAwYpFKg2pGzzBqIOpRUNw5rg7Fu3VN7A+zK5rED4jO7nCcfJkUFxype7AuRQMb
 wYUWWrXcnWA9PugkGRvbt3FJYEW8iRW1YKHm4QZL+QaEH/qnAG5Sj1dLR1JQF29cOXES
 W4x4eT5apjewOXT/VwOAvYyKASuGuFC7S7v2/U/VGPvglF1QSTguaUV2EUfbiAIIK5g6
 opfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYMrXNqmd2yTC1DR2AxxM0fDEsUxSdeUZ49sJZTNZdjDsTleG6pDXr/jRNPEbC1v7DC3BWPESt7rwhMPjPZ0VBw4S9W4o=
X-Gm-Message-State: AOJu0YzMg1VAb1cJuSCKMRte0rJRZdR7cCn8FwnH8qqoVxYzTeiKIN85
 eHzZyNKutPdBzOyzslIgdRA0St/ea6ohHQeeF07d3b7HwcgUfFPjssemqHZbcd0=
X-Google-Smtp-Source: AGHT+IEmp93c00oj3H8a/8+fnX2rsf94XunvOY0VfoP9cIO8l5wC1YEwdyWK4kutnQEobFiXlWxfBQ==
X-Received: by 2002:a05:6808:6248:b0:3c6:12fa:286 with SMTP id
 dt8-20020a056808624800b003c612fa0286mr6594008oib.15.1714354028967; 
 Sun, 28 Apr 2024 18:27:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a056a000b9500b006e6b2ba1577sm18076918pfj.138.2024.04.28.18.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 18:27:08 -0700 (PDT)
Message-ID: <716877cd-de08-42f4-8481-139f479953f2@linaro.org>
Date: Sun, 28 Apr 2024 18:27:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] user: Use get_task_state() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> Get the TaskState pointer calling get_task_state().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c     | 3 ++-
>   gdbstub/user-target.c | 4 ++--
>   linux-user/syscall.c  | 4 ++--
>   3 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

