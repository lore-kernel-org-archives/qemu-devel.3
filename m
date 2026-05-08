Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3402FCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOpZ-0004qP-6P; Fri, 08 May 2026 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOpY-0004px-3K
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:17:40 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOpW-0001O8-G5
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:17:39 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-466ec4c6846so859961b6e.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778260657; x=1778865457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdKFsvptNMdDFxTJJA4MYZmwQKuq5ymwV+3pP7fpmN4=;
 b=eFn5nebFJHx8CnEP9M8OeaLzHKEUIXHOn8/pwZY17HH9yS+kewyK9U8K2ZC6JGh5RD
 OLZwOGCNg3syqH5DEu4GYZRDAK75lwG5Ze5OwTb/CQ1mFlzcaGeXqt+FKD3jRpMvQPsK
 zf3mpfbQQ2i3J59uMQ1tK++4TLx9sfDejnUHSx9uDQ4iB1091ZZNDQDQQpJxvbeiMs95
 XcfG0CjDVq6G3qhMFWazDsiN5sC98eyacJB/rd+HVjtQ6aFTmqm6nJzl0vObmfmaz1YD
 6EBrSrUwxP6u+GvvBJDkKY7MTIl98lCkNMJ4E0LmE3qPIBq7INKL9eHd9nRGHn1OSVqP
 OW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260657; x=1778865457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdKFsvptNMdDFxTJJA4MYZmwQKuq5ymwV+3pP7fpmN4=;
 b=YCveeluKtmXiHwsEMmp2qOot/uz/mIk1j8G3RmzD8ydVLOKi6BLEZXWDcdOb6Uapmq
 WHhGbPGE2s2VybECs8TxG1BlFDMmm6h91UbTpNh1bswOgNlh/FnBUrX+8t0HaFaAStzF
 E/df3LlCjxo0MG8pHqrYTqV4wlcwLqywJ0T8ZndVTnBRLZac5VGatmtiAmmRoFc0APwq
 Tj1x6a4fh8zvADEgEhUryajGOzhltgypYUSXHkp/tUV61kKsLbjWhj7037GtG8+6cr7k
 JYJ+/yTh69I7//3rrnTAx8j8O+xYJqRdtuPS1ob8mHZBrDN5agqZQGDe5n7G53CZ/T1R
 yjwQ==
X-Gm-Message-State: AOJu0YxrjhouoK3r32tXLrbq8xSZIybajmDWm6mXR7eKF6m/HgHcJ40F
 QU9gTkHw4lyXm54FKSGKXeWAbkSwmKyETpYWiHQDTxq/FX6tmYqy6Uo1ARGRpsxc/n1yp1jPz2o
 NYMVJ
X-Gm-Gg: AeBDievJudhTa1NwO7PYimwndVI5PJB0k34rlHhXiIe2xIhzZSeq1Jb7HPoi+sQ00l5
 t/SpB45pIgCgbivph89Ozc1HQ2ECW0hcW9E1kVOyVL0Km0LmmmSIziTrSYOUfPK2Xyi4ilBA5Cn
 YmvkGcB+6B+kYiuVp9PGace02yXhi69aJfK7tVUYFE+6CeCkqTRjmej84NJB4crrAez0LLP9t5w
 JNwfZeE+UwptKUVDUbY1viK6N1TqCvt6pEJ95wCSV2L6b9NmK5nqMgCDFsUe9/NdEJDMeMvipkD
 qik8kI3rQyjwJHcK/fbOSLQPYe2gv0vcckUgIY+2b8rncJS9kgGPz1+wt+njGN4rOjRWkFGx2a9
 MFVvsPOdyrcqt3ukdTjQaptUE+7ds40RD8lxgm2PKyimFUCzUWHgWuYpp9a8AwgM11trGcsWvZ6
 an5LmXXSnDlDZ+joyBHf1E7w9JNCfoFYsC8wCvb3YP0ePkY9UvsmzALtEDkpyXVQEp+EYj4W8UI
 +RwyjfpgA==
X-Received: by 2002:a05:6808:300c:b0:47b:bd7b:10de with SMTP id
 5614622812f47-480420dcf12mr7482244b6e.7.1778260656760; 
 Fri, 08 May 2026 10:17:36 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736dbc0sm2281020fac.11.2026.05.08.10.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:17:36 -0700 (PDT)
Message-ID: <36a1030a-e248-48be-b1f5-fb9d5836716b@linaro.org>
Date: Fri, 8 May 2026 12:17:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/32] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-3-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-3-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> Linux/MIPS enables software fixups for user-mode unaligned scalar
> accesses by default through MIPS_FIXADE/TIF_FIXADE.  QEMU linux-user did
> not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions unless
> translation was forced to use unaligned host accesses.
> 
> Key MIPS translation blocks on the linux-user unaligned policy, implement
> sysmips(MIPS_FIXADE) to toggle that policy, and raise SIGBUS/BUS_ADRALN
> when fixups are disabled.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MIPS_FLUSH_CACHE and MIPS_ATOMIC_SET into preparatory sysmips
>      patches.  (suggested by Richard Henderson)
> ---
>   linux-user/mips/cpu_loop.c         | 5 +++++
>   linux-user/mips/target_syscall.h   | 1 +
>   linux-user/mips64/target_syscall.h | 1 +
>   linux-user/syscall.c               | 8 ++++++++
>   target/mips/cpu.c                  | 8 ++++++--
>   target/mips/cpu.h                  | 4 ++++
>   target/mips/tcg/translate.c        | 6 +++++-
>   7 files changed, 30 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

