Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E393CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIg-00085U-Oy; Thu, 28 Aug 2025 13:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureMr-00080h-VW
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:16:51 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureMp-0006W0-EC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:16:49 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d60593000so7457327b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394204; x=1756999004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RoIK4vikQSzkgi5qK/w5vUHuhDRQPTk1Hy0FOS0oaq4=;
 b=P/EY1J5wB8PkN6Ne/ObY8DT16C/x/0djcAawKi4pIIAn+C8vQqXfGqZYbem1LTWuhg
 jvCp0XjFl/Vz/6khvTjkaEaKZgE5qMtpxvR/03q4/FekbZ8njOPGbm7Csg7ga3iVJI2j
 PAmpI4V5tM2EEvib+c1fibqKDb0AHuKHziwtLwHrxRdctz/pfMDl99Resfd0alABPoH6
 3XDTGvAC1uPgSg9OyFEM0BQOmB4OHXYKkrkVL3BVKLhEnPFzkHbNXC2ZVT8zZuzEyXdS
 Tclilo2vRdCvWz+r3o3lyMfLr8zPUFm9tIhnmVuxsiiHEedOwxo1l7qiWRgtnzcJGuUH
 1x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394204; x=1756999004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RoIK4vikQSzkgi5qK/w5vUHuhDRQPTk1Hy0FOS0oaq4=;
 b=KPHPT3xN2s2kYNKNJT0kGE04mv7SrMScsFe6GrhU7nve+1T0fmhGiCJWxOOmLLBg7r
 fbNO4GIxD/C6ah6w06O05vyU7eW5GyrClSmqU0fuJyHsQZ2Xh9zW6J+nvNbKddU9V5g/
 3rbpAOwR21TNqbo5FfSKC0YyfM3XgVB3FQ9vkBY0lRSaKzdCYdzV+9OFjHQaV799x409
 dwCVVmpQnUi4S6r9rSLohy+DBXKugp0D05qQpR3utjj0RruHtq8wl6tpImMknaVp8kjg
 8G4SBBIdB2RcamyJSmM4j70VJQE9o9DRD4ly33Sl0F+7Uguvi/Vgpy5cZvfspIciverl
 Almw==
X-Gm-Message-State: AOJu0YzCoYi6A32X649cgY3DEym64faFH3XvIJDr9u1X1Io6xPXIqeMl
 sSZKMTi1kvhMbR2Eu+sKtDwrQXbqMKvbjZp6KTLdK8a500q3gBz1Ao8or4xHwrgkzRAM1shMEFg
 +YdSoOrkwMMWNYG1er7Krg7IGmjFCHoOEpJ+1UbZFIh78dUrmcpMN
X-Gm-Gg: ASbGncvoUdjYP9iLoE5IBtqET5g0PCKEH994G9tWBHx8XotSfIwIPRFRIOHo9Y7SyEG
 XvzxWZswAptGegWIhzi99u0Rhk8hhkB1un8bmJjIYBPvEbv88uTFPqYXc3JqdvmBkqRUxLaY+A5
 kLlTBvf8ZvJ3TIwm/tSf7crl7xF6cb4FRC2JoUQ+UPn2JEeAWHRaYjxqhjm7Q45ujw6LUlBl5oG
 UqNedU46KuESSoleW4=
X-Google-Smtp-Source: AGHT+IGwGwyBVe5uspw2lliJA8Q/Z8g1YJMDiNkwKAg18C8i7841A6yEyxr/LHz4hRYnyDW1kwSwylvwJC0lt734pcU=
X-Received: by 2002:a05:690c:338e:b0:71f:f82d:91d2 with SMTP id
 00721157ae682-71ff82d97e3mr223406837b3.37.1756394203667; Thu, 28 Aug 2025
 08:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-54-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:16:31 +0100
X-Gm-Features: Ac12FXzFsYwa9zYTsVpMJ-DMhb0cI64Nq0bGHO50w6hKKaPIBnEtCk2hAYr4Gt0
Message-ID: <CAFEAcA_Q5DO+ReKFe7nH-5QtdsdTb0Fg95mm+YrGfP3CaAJu8Q@mail.gmail.com>
Subject: Re: [PATCH v3 53/87] linux-user/sh4: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 28 Aug 2025 at 13:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move target_pt_regs to target_ptrace.h.
> Convert to abi_foo types.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

