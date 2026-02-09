Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C08BEF06EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGb7-00075V-IW; Sun, 08 Feb 2026 21:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGb6-00074e-Ev
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:01:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGb5-0004Qs-53
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:01:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a9057b2ec3so18416655ad.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770602514; x=1771207314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nC9qN4o8mGzcPB/Te1+SUwQYFgzimGuIKCD95fQiZG8=;
 b=R3rMKbwOytlroU6tvUxg5DTsAO55XkshnoFsH4mlVqRPFhkqmbug5iwjp74AGXOSQs
 taxAxB08ZpGy01Y9ls8k/mjR+0SsfxYmLzGxHlwa5FUgiwqEGzrNc5b9slhkvZZlWtVZ
 JkOdoddIqzm8VGRxCtbHna1dmjilgKGFOOIt+mscGjeJDWim4Qvxec/q/0zzFth7MKv/
 py+JOdBJgb/MXcgdAiGjetLBfQ/PeuQ97bX1nn2fTy2FgKdXWfGVzqOE3bPTwrkGbJE9
 Wor8gxfPqC4sNv/2Qv3rgVpJW0MoBu77F2/at34+ko8nGLyjrA+grG7yHsCkfshFUwAr
 bcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770602514; x=1771207314;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nC9qN4o8mGzcPB/Te1+SUwQYFgzimGuIKCD95fQiZG8=;
 b=Oig+3HCvAe6eD9C797eg4veYv4s6gr8tn8tQjrqUneGchiMUAmePyZWEBU7533Lwpr
 foI/ah5Y9KoEDZRbt86Czu/PTqLY+Z12swRTbYAZvzG/LedRxQBKz9DfAqKkgjqGYxDA
 45baTOcYV9oLh5SXL+/GgilxlOTsTrZM8l4V2DR28gsousB6aw8bEWIkrCghRngwP/ZT
 jCyeXIDwqw2iojQkWq1ksU5QPfl/P2IxRr2WW7hmk7DCr0hsgG+e43E5CW2DNMmYqdib
 P3fd+oz8jhpxJArQbDgUnu9sXI5xpnd7Cl8jSChshKKUYRpUFkeF3U899KGi0ba5WFVK
 KHHw==
X-Gm-Message-State: AOJu0YxxGURCKkQe5d28lVqW/lWSD+V/7t/DgYsCmDLuUJ2jmF7yvfBp
 +m9Lzg7p8wSGP1TDU4QGLZ8WQahdnxSSj9j0sED0DmZzd7pFuCyhDJMOSlBcCLIsNACVXvJtozP
 OLIAEoCA=
X-Gm-Gg: AZuq6aJNHixiyNn52zX+glXijtkIFC1F77og0OJR/3XJJQE67LKoXkqkyCAH8yIMfzF
 zmwaETRs4KH8UYmrMXwnh1EWOIJMSal9ajT5MXdVL5WLMr0qpM5zru0QdfiNqHajn6GGkg3rEJ9
 eF3y91H2Dir3/BQSBkF9oLzrw+BXkgrOvY3oXw3TzWkKnW81jxz1QqX2TeFuFM/QgSbERH4yIaX
 W3t7BBLNuRBPgxmUw6KnRW9hB4QlZRQClJL/6Jy+cazppSvJqNJkYDUWsn8wyNCsZp0i3IwA/vp
 zTv3Lz6/Z7Tf+vWLRJTyPuQKdyTc9RWJ0pzMBrJWj0cDBA6o0nTop0xP32qwvvPvWsHwDSWjfQ5
 YjiFoF4noDrFNvcmphb5bmWADZnjWmn+kwXHiEYA8JhmHZ16JCQyjQ2RW2Jn9ggrLneasu2mZOh
 7DTqfx+9MmZr1BHVkeb1P5K7AwpMG1Y2srUPPkjbalL/T38loZSqwgLkSWE41keXlFrlKxWNy3A
 Q==
X-Received: by 2002:a17:902:dac1:b0:2a0:fb1c:143d with SMTP id
 d9443c01a7336-2a951607858mr97031625ad.1.1770602513767; 
 Sun, 08 Feb 2026 18:01:53 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a96251b6edsm63984125ad.69.2026.02.08.18.01.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:01:53 -0800 (PST)
Message-ID: <94c98126-adff-4ce5-89a4-559a96d36b38@linaro.org>
Date: Mon, 9 Feb 2026 12:01:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/24] bsd-user: Add semaphore operation constants and
 structures
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-13-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-13-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/9/26 05:26, Warner Losh wrote:
> Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc.)
> and the target_sembuf and target_semun structures needed for semop(2) and
> semctl(2) syscall emulation.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

