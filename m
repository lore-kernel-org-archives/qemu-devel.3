Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r70IKdaH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWyua-0004RO-4D; Fri, 27 Nov 2026 11:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyuX-0004QS-GQ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:34:57 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyuV-0008MM-DZ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:34:57 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-675617e81f9so9461951d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795797293; cv=none;
 d=google.com; s=arc-20260327;
 b=KIGZ83xUW+NE40PyzDFz5n5ilpohasMxE+ruZMxOcskYNnnKLzC/PjJlg33csVD62N
 FCCdSnHA5HoijDNk+D9Ij/n3n9Uryj9odeg8sjIvOmL4tmu14qfsJvchNaso2J3fIY+5
 cvM+YAZ5iAU5Q6Dmqh4KDwEEam/Q3TPiAwhERmyOsgyh/pywt9EoiPlZxFEzkEsF0VIL
 KQwhE16MQhgr0Mh/Iax8cqYy5nP4Y1bVeyYHCOARyNJBGAzCdeOouAA8OlrjZYEGdxab
 UaJ7XngPb1UeuHk0IxQ0/FYCyA023uKSxR1jMJsLF/LrgvhJG3Pk2THYpE3vRQgzK3jU
 iKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gkNB1yn1vBvRfZOUu4YP2wMaupBynUSTFtR8pgn0SPM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=VN1Q6xgYvXXQFZ6kgQtqCYUIVSDZHDrpA0r9jw8QraihIIu/YyH31nrbN18BfBEzCO
 PiFVT0ruq61PV/YUhEl5lqDvkncLntKyWeVuyirk2BgEZ/d5UE8UFe+wUD9SSBpQS7GP
 KHLzpT5++saqOFUx1hStJrkqXxzfpi6J54NndqzH3MRH5JOVS42BtF11gxjfRWaDINVT
 ONpnFaIzxyJkgYC0BWwIGpIdb6Y2MUsitmwdcrPEqbsTm+kTo2P4vcr5qLRwWqOzKAZh
 fbzlkgw1AOJCEAqBeW7vN/irJ1xAazYHLwVPSTlvfv5uP1UQJ2eUQIOQbMsh+asPbJXM
 JccQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795797293; x=1796402093; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gkNB1yn1vBvRfZOUu4YP2wMaupBynUSTFtR8pgn0SPM=;
 b=r70IKdaHxPYjbOlvSLeP0kdufLzCnRas7DUoTu1cgw59GDTeHv1N93eMWb8UfGjT1M
 k6Kboop8l0qC0WNVkAljONnolfhCMFdARlxt0xmTRRxKMlX7aqyC0Edu6iw6zkfKaKqZ
 3wGSoabdDxH3BK/4F9ACVX/rY42IjqdpbEzK7dLKmEomxdmO/rQgOJ+ZOZfla5QdvXWK
 3uwFUhHmJWVxl5/HXXzhY9yjCzXGe8fLI2qB9HxmbrpVqH74QKC7udIw0VIG5vnI1p06
 YHWwJCaCaxaZN/hsrZCF/DH7NeMprj743uau+7ZT2IE5yoIzOCKorh3o8HNOHRH3KWGz
 GSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795797293; x=1796402093;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gkNB1yn1vBvRfZOUu4YP2wMaupBynUSTFtR8pgn0SPM=;
 b=MbUmHW0rwfCvpO2jZXO7qwYknFPb3qwOvklomtr77lC7cz4JMHZf/vi7hIQsB4U5uH
 Oi7sDjONtsHDDWGiVHUVmR2M0L0MstzpKq/dPEE+s6l31INFz93Fhu1dU4kiL96jJUxy
 FHZyPKsX5m40FHu4SNjCZlgYdEnCreSb/xnbtXCEapxum5VQmlu5R7y+1QAyq92hDwOj
 oIhzUKC78QDgK5Z5nMRSXqvx1bL7J6X7R+53GNBMw9F6l7L0zDqBJWpKpbtAZrgKXSwY
 Ewd0/4a5WYDH7Fmn4CWazuZrUGbjoOvJKaP+Ygh4KBsgU8BLr8vmW1DWv6rEyRQD5Lw8
 /BNg==
X-Gm-Message-State: APuU4Z+84Lel3XBvDqPLCjKJRjFDkNBWHg/UUyFWwUvdzQiPSuNWLkag
 dbL8JkL6iX7Drgsds8dOa8fTCfFrkA+86MZs84m3boXPrKybN54F5bZeLz4g4UgN+mJMbIls8hL
 y6SnaJb4lgQTPd1npNLFB7Z8ITBZA/5yhNyhOHUNvKw==
X-Gm-Gg: AZFdTZdB/3UL99DLKtc+kcQTnvSw6yr1jAKJm6jaxvrDina7GYA4XN/YTmXSVARd63Y
 feRxrd0EI5iJKFG1jbTZnhsgt7Qtys21Cy4fYvxmyl9wUVw6zEsv+fq/mtYuGXBbTYPGIc+N0ag
 Z/9KbKegnPKzBUJuzp1yx+8tZyz1Ahexen+nneoMLSZBDtm9IE7xMGM2CtOBstHZnXSMlQeh1e/
 Y2CeTp8BQOcOXQygjuRUPGUTqxc9wqhJkL9V9l47nXa/xgKy01PjepEOeEBAShhBQrGaTD6HVJJ
 CpN/78t3qPHAhTWWqAiNKX7Q69LiyHAdMjs3wFWQqWvD6Xc2GJ3tYnBLfwn2LAZNAM0PIHTFBWU
 y/HW6vDFshqUtA8uhY3Jh4uSBfni9I4bg+xCkd2meSRerjIAqzaoWl+TKrx25j/vWwtXCvRONMj
 H7nIjYEBjtDeQ8vH9DFCKD
X-Received: by 2002:a05:690e:138e:b0:67d:c122:e5ce with SMTP id
 956f58d0204a3-67df43ce276mr11155126d50.36.1795797292937; Fri, 27 Nov 2026
 08:34:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-6-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 16:34:40 +0000
X-Gm-Features: Aa3M54oSrEZUYgrrknaN5VsAijYOfU3DiqRU5-Dl4snvgEj38BfRQHJO52tiZSw
Message-ID: <CAFEAcA_t+5pTvv=UP62y5jWd5ENcUDSSgEemiT-HSC5T6YbLBg@mail.gmail.com>
Subject: Re: [PATCH 5/9] target/arm: Split out gen_indirect_branch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use this instead of DISAS_JUMP.  Existing indirect branches
> now end the TB with DISAS_NORETURN.  Share the code with
> gen_goto_tb when use_goto_tb is false.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 51 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

