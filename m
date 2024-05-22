Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100BDC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9inM-0005UV-4q; Wed, 22 May 2024 06:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9inH-000544-HM
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:01:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9inF-00035d-Fb
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:01:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-571be483ccaso9720073a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716372114; x=1716976914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oegp7+oAJlG8HTHu4rsleQvR6zJkrTgiUoj+staxXc0=;
 b=xunSh7bRgfqRoI5rmKamtzW8leUSPjFeGAptfg/GQqR8Ey2Vkf4xy9WPD9+J4Kp0ci
 p1HiTsPgiumKCyWoPfgooIhiOAszvT5CHwbPk33L6FpvONGXRLA4SwTXK6mznVQRGEVo
 AdJukVFb61Cp+PcNFIN8kH+kzf+rGt32k+52WX8xeopv1MivOIDz4RoIlgFFaSvzdeYu
 4XdiYKjaSb+9AAHyWCsIfYYwLLymXnqVC/iKY7U4Yzh+H2p/Oh12+esKusI9kVyjPO/M
 KBuZVO0IZ6oAdsDBMvpif6x+l1DaKxX4F7yzix7gUzTS+oruWIp+MIEoLv+/0IF6iA8H
 2tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372114; x=1716976914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oegp7+oAJlG8HTHu4rsleQvR6zJkrTgiUoj+staxXc0=;
 b=L36Hx5lHGR/Dam/JgYfVkuPv6AHCU75kJGP2XuTTtq3dvY1+tIAyhNMLmoL4cBqjfu
 RAnqaei8pYgfPvx/ejMxl0hZW8YQXwvMQonMgNFICfbvMZYDi8pCxb+R3cGwEmnemNI6
 /+8aZAxQhxt+lGYUhW6hRgJYQW8xb8wzxoUIrxzm7GJf59VDtKRWvdlj2HQ6qtj7nmxa
 JwzULeI6c0Z8H5n+Q87D7vK12SzWzMEwbQ0DEttztSzWj3xB+9cplsMmejP1HJXgzNAq
 l2szDxvB0SfUdniOZGuhRX5m8JxkwN9BPx/7ZM60SAkXtQ0O0A69zSgKNIsYUsFNw27h
 beEg==
X-Gm-Message-State: AOJu0YzlXij+WXY9Mi02xIeIS1I0H3rnOY5z7aR2HJqmW3TEHpCCrI4h
 1Ym2EtL8jO5xqDZpao8ZLZZInELVkBRk1imDoWcjm+cIijhMgirWU+G77e1aqWIzwDVuCRUo63M
 b+5srpqqgzFpc/4Qjw3GppgTePO76R5lCqVwcDXxhsOJ9L/OOGZA=
X-Google-Smtp-Source: AGHT+IGiz5JeGkM/WdjU+d5p+qGLN40lDvfWIHDsJD7g1YPKhF0b2Ffzlmw2nIK9n/mB+uoXOcKuih4JrHFUeugwVn0=
X-Received: by 2002:a50:d51c:0:b0:56e:f64:aaf6 with SMTP id
 4fb4d7f45d1cf-578329fe0d0mr867285a12.5.1716372114327; Wed, 22 May 2024
 03:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-32-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 May 2024 11:01:40 +0100
Message-ID: <CAFEAcA_ASs4_O22dMi4chcZTT+K=3swJfp3KY83JPbsEJoF-RA@mail.gmail.com>
Subject: Re: [PATCH 31/57] target/arm: Convert SUQADD and USQADD to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 6 May 2024 at 02:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  16 +++++
>  target/arm/tcg/translate-a64.h |   6 ++
>  target/arm/tcg/gengvec64.c     | 106 +++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 113 ++++++++++++++-------------------
>  target/arm/tcg/vec_helper.c    |  64 +++++++++++++++++++
>  5 files changed, 241 insertions(+), 64 deletions(-)

Somewhere in this patch we break the setting of the QC bit
for SUQADD vector insns. (I was misreading my test insn
when I made my remark in the other thread, didn't
notice it was vector not scalar). Here's an isolated C
test example:

#include <stdint.h>
#include <stdio.h>

static void do_op(void *o, const void *a, const void *b, uint64_t *fpsr)
{
    asm volatile(
        "ld1 { v0.16b }, [%1]\n"
        "ld1 { v1.16b }, [%2]\n"
        "msr fpsr, xzr\n"
        "suqadd v0.4h, v1.4h\n"
        "mrs x5, fpsr\n"
        "str x5, [%3]\n"
        "st1 { v0.16b }, [%0]\n"
        : : "r"(o), "r"(a), "r"(b), "r"(fpsr) : "v0", "v1", "x5", "memory");
}

int main(void)
{
    uint64_t a[] = { 0xc000, 0x0 };
    uint64_t b[] = { 0x5000, 0x0 };
    uint64_t c[] = { 0, 0 };
    uint64_t fpsr = 0;

    printf("a: 0x%lx : %lx\n", a[1], a[0]);
    printf("b: 0x%lx : %lx\n", b[1], b[0]);
    do_op(&c, &a, &b, &fpsr);

    printf("result: 0x%lx : %lx\n", c[1], c[0]);
    printf("fpsr: 0x%lx\n", fpsr);
    return 0;
}
(build with aarch64-linux-gnu-gcc -o suqadd suqadd.c -static
and run with qemu-aarch64 suqadd)

After this patch we still generate the right result, but we
start setting the QC bit.

(Did you do much risu testing on this series?)

thanks
-- PMM

