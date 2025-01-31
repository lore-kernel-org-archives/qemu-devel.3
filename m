Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F148EC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduSN-0005j2-MH; Fri, 31 Jan 2025 12:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tduSM-0005iJ-RU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:05:26 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tduSL-0005Rt-BZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:05:26 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e5addb1b359so714484276.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738343123; x=1738947923; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJMza0HWi/4HPrsqzH/OCskfN3h3DWq4XqJcQaikuoA=;
 b=ZLfvVbQgvVVk8YMs4GI/JymTgLvxBE+mv7WK/XFk+NlmYXKrGfvVXhVn6tarneGhuY
 YH+tmeXcVoYGfvlX+zul0ZRrizbJY6GYhmpR1w4eTuKNgHGequxklP8GF9/LmiDaP+CL
 cz//SqO2A/ohrPhOQHDFP0i1cziyiQmRqXpCxdvOtF741skTvLS3tlqT5rqGEAkHWKY7
 gopPQTombCOmCnuanuSJFIq0t2jRFFmGaXG5EjH76sD0HU4dqfL3Xm0eoDFECXYuz1b0
 oDGhLSDEQ5LU/NluvOnC281yAFECfuBkCvRq3MwuSWoEGGyYe/Mc7X+v/pYkR3PNPV6l
 zb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738343123; x=1738947923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJMza0HWi/4HPrsqzH/OCskfN3h3DWq4XqJcQaikuoA=;
 b=U1TcvP+PQwXTae68wXP/+1F7SimJ8lsAJKF7hZQEjoDYDBQKPynmb7gR/ron2SbO0+
 ab6KWrxbcpGLYHvj0HMraUddEXiPAQV6fMtl6F152gXYWtPVYzfjzRLWzr8xCWUlMqz7
 IeZ9hg3Si+s5ZL7aLvAzPuOXXVF01G03XIMgfMdv+baR/R28TWg8MfXsVlFSrv8+UT/o
 lIlzzmhqZlDe1/848ZTqHHhPMdfQZmAdM8oSuiaBtsvW7d1Ef1A8n0W2UGay0pMR+RJs
 C+S2mCB7X7UopK/gWjbet2Bb2Q9b4khFrZJUApQhX97q/5jWrtH3GHaR0axqk9gnxtuE
 Eg+g==
X-Gm-Message-State: AOJu0Yxj+A+Yz1tQ0EUF0winHp8ci+PThdCFYac6I2MpymkD510n0yn0
 XTpZPtpNEMzEcKxh5zZWQlwcXJBDgYop0KpOSsjCEQoInsrlRwnAIDawDHmv3wIOMZVtDDf0PPV
 37PX24/Ys49ntoul5XLq8IKHFVNtHbYX/dRuEaBVO6sIkzB+W
X-Gm-Gg: ASbGncvAM7LnOpJA8/mlRNxB3R2wD1F936Z0fwlD19XYKIbaqqnVZw/uHcFNul+Eweg
 kOTO4hJZEely9KhsHBMkNL+7lHI6IdPN+YAhqQrvW3CtIEVm27hvK+dh9twA7Vk5MkTTTND1wdg
 ==
X-Google-Smtp-Source: AGHT+IGWBGj8igKDjWJEEs+WrRTuhlrGN6r0N2Ro0pYsHSajweiaO9v0qcZY8hM1jCJVJj5CGv99oNAmAxpdY5PDJLA=
X-Received: by 2002:a05:6902:1a44:b0:e5a:cece:f371 with SMTP id
 3f1490d57ef6-e5acecef6b6mr5321592276.11.1738343123019; Fri, 31 Jan 2025
 09:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-28-peter.maydell@linaro.org>
 <49f1651f-89f6-41ba-92cd-dac25b3eba14@linaro.org>
In-Reply-To: <49f1651f-89f6-41ba-92cd-dac25b3eba14@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2025 17:05:11 +0000
X-Gm-Features: AWEUYZmqW05ozDOtRUkJqanHJ7JyIrLw9L-Ox3P3IpjfJ38RhfqlIv8VczxlYSg
Message-ID: <CAFEAcA8bqHQTuUbSiSZyag04kPbx6f3XUibM22oaufxkqdse_A@mail.gmail.com>
Subject: Re: [PATCH 27/76] target/arm: Define FPCR AH, FIZ, NEP bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Sat, 25 Jan 2025 at 17:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/24/25 08:27, Peter Maydell wrote:
> > diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> > index 3c8f3e65887..8c79ab4fc8a 100644
> > --- a/target/arm/vfp_helper.c
> > +++ b/target/arm/vfp_helper.c
> > @@ -242,6 +242,9 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
> >       if (!cpu_isar_feature(any_fp16, cpu)) {
> >           val &= ~FPCR_FZ16;
> >       }
> > +    if (!cpu_isar_feature(aa64_afp, cpu)) {
> > +        val &= ~(FPCR_FIZ | FPCR_AH | FPCR_NEP);
> > +    }
>
> I suppose this aa64 check, without is_a64(), is ok because the a32 caller has already
> applied FPSCR_FPCR_MASK.  And similarly for the ebf16 check below.
>
> >
> >       if (!cpu_isar_feature(aa64_ebf16, cpu)) {
> >           val &= ~FPCR_EBF;
>
> But it does feel like we could usefully move these to vfp_set_fpcr, or such?

I dunno, having all the feature tests in one place makes
sense to me. Since we're already doing it here for aa64_ebf16,
I think I prefer to keep the aa64_afp check the same way.
This series is big enough as it is without adding another
cleanup...

thanks
-- PMM

