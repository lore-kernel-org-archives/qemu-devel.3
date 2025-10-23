Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080D7CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw2C-0004Vy-Hp; Thu, 23 Oct 2025 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBw1u-0004Ml-EK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:11:04 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBw1q-00076e-Tu
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:11:00 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7815092cd22so11517357b3.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228654; x=1761833454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPEmKo1BZlwRmYCs2ocOwAiSSPpVj4RZHQIbZbI4P7E=;
 b=XXYOHD7RSDc5nBf2EEUKzxcryAyqYInizvNiP/WeO+jBuypMO7BZFSO3D09NcQwLsw
 BLUBWJ/q1uBpdFrbnLahfDaJQq1wNQNnlIZquPBbwnpF7WQCuMBe7t1ihGBqfciKCAHd
 i7agdWyvb/OXg3P5YNNQhJWswTBQW1vzrXOZMgsYc/f/Q8HjHTwOku8EPee52gAv72MH
 Mxaf1jSELWdsPYDtXotcrT643gUMigxoMXZzy659k1LgdgMizRWjjfNE951IyNrRluja
 qAnp5WXIKd4ezH9jnzGnyFpGc97PbZUIV3wIOO20K7TQHGV8OAjRy4RHsznc8JrM7vUD
 88yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228654; x=1761833454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPEmKo1BZlwRmYCs2ocOwAiSSPpVj4RZHQIbZbI4P7E=;
 b=bE72nX+qpXpakJd/sqKcUYLuqsXBJWVEVaKxMsBrnxGdPq5WUaKiamE6XfHDotkROX
 Dl8E1kN1RA7uwDonQDoHDYbNZY2tUq5ftk4rywcSdieWaXZJAd9+hNZPsiC8qelPJVrw
 oSDkOKRR6azFhn0n4DGOsDbVlB+55oXDKU61r+Cbi3PWxGFbFEfIiQG3nHe515DILJ0R
 8t0mhOgAH2JBsAPVqotE8yBFy4oAoLOrLhnUpCrlQGM3Dv0IDU4GeDH5Lnvv2X3ExtKO
 ntXMSuPAITFH++2ZzH9lS2hSLiKg1aNrZrUpX4VIbvZdAoAx4iKGIJM3KAjA8gJJUz5w
 QkSw==
X-Gm-Message-State: AOJu0YzO0aFGQ+eZaE7LbdtowaiMSuldvIUjBA/wCzYnNWqWuZRh3A2q
 D3ANNeXHRi1b9mmQigdyPUf7EFtqOQ05P5Kj0fGF1DUb/5w5q14xalSHd7Vz1e1BQtL8xONTs6i
 UgzdkbDksY6151d/u1E3jTr5GHOl8lECLyDfal+6BH6H8jn/B4TGz
X-Gm-Gg: ASbGnctTgyl1lJ8WZC0xftX6M3oq9aG/0xdei0nVNTTGwOIfDISX1pHUwdGIAVhp8jY
 E63B6OJK4iisMtJR5gWtn35VARmZVsUORjMm01sTpYUMT3ITrhj3k/+4dfZoFP7QGSP2ivZ9wE8
 YdPD5NYMPa0AlUybYi9ZoIglcmWmXXq6t3E9x/2U3JnUsNBSHGVPiIKZ4S+wLt+VNXyt0rjqP+G
 onrfLVjBKj2i3xafrLtggkWAAMmcUy3zMGhNKZdQki84Ch27rjfDViwa/+hkg==
X-Google-Smtp-Source: AGHT+IHdR2VO7hBFpnU2gmRml+4lAXIIm6hR4zhAzZp9ggY72YI+tfitYp+5Q5C/Av6kpnVaZzbdAWvYYyYH+jxh6t8=
X-Received: by 2002:a05:690c:a0ac:20b0:785:b16a:9bc2 with SMTP id
 00721157ae682-785b16aa098mr76430877b3.66.1761228654483; Thu, 23 Oct 2025
 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251014133540.1103268-1-pbonzini@redhat.com>
 <20251014133713.1103695-9-pbonzini@redhat.com>
In-Reply-To: <20251014133713.1103695-9-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 15:10:43 +0100
X-Gm-Features: AS18NWCPFMmRzti_mN9RSKdPgxRHTeTb0xIvgf7Pa1T0WYmZ59QqWe3TI7pHxmY
Message-ID: <CAFEAcA9=pB7ARZjCqMHy=cqpvFbEinbzsfAQt=OkoNwvY9Ocag@mail.gmail.com>
Subject: Re: [PULL 09/28] i386/cpu: Prevent delivering SIPI during SMM in TCG
 mode
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 YiFei Zhu <zhuyifei@google.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 14 Oct 2025 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> [commit message by YiFei Zhu]
>
> A malicious kernel may control the instruction pointer in SMM in a
> multi-processor VM by sending a sequence of IPIs via APIC:
>
> CPU0                    CPU1
> IPI(CPU1, MODE_INIT)
>                         x86_cpu_exec_reset()
>                         apic_init_reset()
>                         s->wait_for_sipi = true
> IPI(CPU1, MODE_SMI)
>                         do_smm_enter()
>                         env->hflags |= HF_SMM_MASK;
> IPI(CPU1, MODE_STARTUP, vector)
>                         do_cpu_sipi()
>                         apic_sipi()
>                         /* s->wait_for_sipi check passes */
>                         cpu_x86_load_seg_cache_sipi(vector)
>
> A different sequence, SMI INIT SIPI, is also buggy in TCG because
> INIT is not blocked or latched during SMM. However, it is not
> vulnerable to an instruction pointer control in the same way because
> x86_cpu_exec_reset clears env->hflags, exiting SMM.
>
> Fixes: a9bad65d2c1f ("target-i386: wake up processors that receive an SMI")
> Analyzed-by: YiFei Zhu <zhuyifei@google.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

FYI, a bug report that just landed has bisected this commit
as the apparent cause of WHPX SMP boot no longer working:

https://gitlab.com/qemu-project/qemu/-/issues/3178

thanks
-- PMM

