Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE4AC9EC91
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIGq-0003pR-8A; Mon, 12 Jan 2026 08:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfIGX-0003lk-Il
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:47:29 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfIGV-000823-IG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:47:29 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so51386695e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768225645; x=1768830445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+MDTsCmcs2A1Wli3oFV+z3bKgMKiM9n9UjXLQAOreQw=;
 b=L/uso0wIke1vn0+Z57KbopT21y3Nb0b+vu/oVMZcgPphRWiMJRuiBhXm3cE4XKIoAi
 cZKxnsyRYoH8wEQO5xW6j0GQWpaHKStqjXBnfo9TxUb+5jDGVbbIX04npc+p8Yn6MIzN
 8hnANLj92TtQcTbulc4UrPtdSXmr2Y2U96srphJjCQMYdcAHi3BPQFySMFiSSxlMujhn
 Z762PEFp3wYrwbkkwXvuJvhJ/ypNCH28e1jwBT69/bthmRtspurc7jO/PaI6I7Ep4X8+
 Pa1YQh3tU2XEkfuww0WKMsHGI2SADaY3J+sKoTLyQw3lCaz81EeMIiVgENkBBfzA+K8L
 XYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768225645; x=1768830445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+MDTsCmcs2A1Wli3oFV+z3bKgMKiM9n9UjXLQAOreQw=;
 b=Ppv66EOL1jxaEiYoQLUmVGqMFkGOJj0Q6RviCxXuWgg9sMjU6EAH0EpEpjy0vl8kCa
 /SysRxxizsogg6Uv3feZu++rrudRik6nu6kqdbgc1bIjcF0YIUzfEoJfpysVgx+fuo9g
 U+aBAMBAk8d5y7dTN/PUjmd/LDpBQ1pTXmq2BKba+/0VletdFyh6UoTfXP+upKQDLfUa
 tXNCGhUQL/agmVbF+za5OVf0UapkgVUvIsO6Q1Ykw0nFlmhdqafBxOVIFjbncuqbZHRW
 7kLGpcG3UNbPRBN/giNdK9nZ6BE/tOt0geqmzVD/hE2eKxRUGeO2aJXr9A0UMqYu2CV5
 oygw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaXsK17PGnl7cNN2q9PUTDP3gVjZ7J0zWwjwCNerZxkAgpj6iodWNQ5cr5Yr7a1PmbeaRU533tThrs@nongnu.org
X-Gm-Message-State: AOJu0Yya3SGCp1MSjwsv9raBlTtETvC2LIAMftVJ9lcbMbyrVCZirGbo
 aXvPZVhXG974/znLC3iKD3UkIExiyFlSZHjIQO7tfAFhH9pKtaunv6RalOggtGjwd8A=
X-Gm-Gg: AY/fxX7hUlEH9AZIrLjoN0y2+9TsqBA0AI/bM53BCkHZ6imjMHNTj5b1bUL60ssJAbw
 rI5so4C+lYPd1oKYsRWJ0DbdSp/hkYSiZNNhQxl1dRcZJjmRhbzyo28TP+3aDdApV4U1JR0JX+l
 twqu6X2I+YkyEn8k/t1sl7pGw2xLFsyR09oMW1QFZpGTBjPus8lubKn3RIUDcqj3Z9PV1dGLS4o
 fLZfT/eZugfQdX3Ur3ng5H3XH0KvYRC9duhCmTEIm+p6IqU3SCfnuwtjxbsEEnY1o/C2WeyXIr9
 yYQ/FbgcFlgC/nxbjnDgkjSZCjc7LjqlfFLmI5ocB7elWDbVoosWwJrERtOstn+NeVZbzji75En
 2EpeAINw0O5NVrpjqdhN4W7WBNym2IQFc/qvEhcviEj1y2XHu6B2DgXF4gggtQanA/1aIj+HBKT
 rdoxomcNI6FdsgIMA81wcQuj0QfoG30YpzKjCDylJyKV0rTo5EToS2Ng==
X-Google-Smtp-Source: AGHT+IHxYMZr41Gpky8OQm9rOdZoi77g+eBYhpiXyOGZnrY2aWP5NoXNNbQEXKXGQANikQ3gp/Xe/A==
X-Received: by 2002:a05:600c:3152:b0:47a:940a:c972 with SMTP id
 5b1f17b1804b1-47d84b18752mr198707065e9.4.1768225644919; 
 Mon, 12 Jan 2026 05:47:24 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695225sm357506535e9.4.2026.01.12.05.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:47:24 -0800 (PST)
Message-ID: <2b4efec4-1c47-408e-9a87-a62c37e5bb01@linaro.org>
Date: Mon, 12 Jan 2026 14:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/15] target/s390x: Restrict WatchPoint API to TCG
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260112131457.67128-1-thuth@redhat.com>
 <20260112131457.67128-9-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112131457.67128-9-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

On 12/1/26 14:14, Thomas Huth wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
> we can let the compiler elide the s390_cpu_recompute_watchpoints()
> call when TCG is not available. Move this function -- along with
> s390x_cpu_debug_excp_handler() which was introduced in the same
> commit 311918b979c ("target-s390x: PER storage-alteration event
> support") -- to a TCG specific file to avoid compiling dead code
> on KVM. This restricts the WatchPoint API calls to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20260107130807.69870-2-philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/s390x-internal.h  |  2 -
>   target/s390x/tcg/tcg_s390x.h   |  5 ++
>   target/s390x/cpu.c             | 30 ++++++------
>   target/s390x/helper.c          | 38 ---------------
>   target/s390x/tcg/debug.c       | 85 ++++++++++++++++++++++++++++++++++
>   target/s390x/tcg/excp_helper.c | 32 -------------
>   target/s390x/tcg/meson.build   |  3 ++
>   7 files changed, 108 insertions(+), 87 deletions(-)
>   create mode 100644 target/s390x/tcg/debug.c

Thanks for taking this patch, but Richard said this WatchPoint
API shouldn't be TCG-only:

https://lore.kernel.org/qemu-devel/4be5bd97-21a5-40fe-9a9c-a4e05b11a1ea@linaro.org/


